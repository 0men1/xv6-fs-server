#include "types.h"
#include "user.h"
#include "fcntl.h"
#include "ipc.h"
#include "fs.h"
#include "stat.h"

#define MAX_REMOTE_FDS 64
#define NINODE 32
#define NBUF 32
#define ROOTDEV 1

struct ubuf {
  int flags;
  uint dev;
  uint blockno;
  int refcnt;
  struct ubuf *prev;
  struct ubuf *next;
  uchar data[BSIZE];
};

#define B_VALID 0x2
#define B_DIRTY 0x4

struct uinode {
  uint dev;
  uint inum;
  int ref;
  short type;
  short major;
  short minor;
  short nlink;
  uint size;
  uint addrs[NDIRECT+1];
  int valid;
};

#define I_VALID 0x2
#define umin(a, b) ((a) < (b) ? (a) : (b))

static int unamecmp(char *s1, char *s2) {
  while(*s1 && *s2 && *s1 == *s2) { s1++; s2++; }
  return *s1 - *s2;
}

static struct ubuf ubuf_cache[NBUF];
static struct ubuf ubuf_head;
static struct uinode uinode_cache[NINODE];
static struct superblock sb;

static void ubuf_init(void) {
  int i;
  ubuf_head.prev = &ubuf_head;
  ubuf_head.next = &ubuf_head;
  for(i = 0; i < NBUF; i++) {
    ubuf_cache[i].next = ubuf_head.next;
    ubuf_cache[i].prev = &ubuf_head;
    ubuf_head.next->prev = &ubuf_cache[i];
    ubuf_head.next = &ubuf_cache[i];
  }
}

static struct ubuf* ubuf_get(uint dev, uint blockno) {
  struct ubuf *b;
  for(b = ubuf_head.next; b != &ubuf_head; b = b->next) {
    if(b->dev == dev && b->blockno == blockno) {
      b->refcnt++;
      return b;
    }
  }
  for(b = ubuf_head.prev; b != &ubuf_head; b = b->prev) {
    if(b->refcnt == 0) {
      b->dev = dev;
      b->blockno = blockno;
      b->flags = 0;
      b->refcnt = 1;
      return b;
    }
  }
  return 0;
}

static struct ubuf* ubread(uint dev, uint blockno) {
  struct ubuf *b;
  b = ubuf_get(dev, blockno);
  if(b && !(b->flags & B_VALID)) {
    if(disk_request(blockno, b->data, 0) < 0) {
      b->refcnt--;
      return 0;
    }
    b->flags |= B_VALID;
  }
  return b;
}

static void ubwrite(struct ubuf *b) {
  disk_request(b->blockno, b->data, 1);
}

static void ubrelse(struct ubuf *b) {
  b->refcnt--;
}

static void uinode_init(void) {
  int i;
  for(i = 0; i < NINODE; i++)
    uinode_cache[i].ref = 0;
}

static struct uinode* uiget(uint dev, uint inum) {
  struct uinode *ip, *empty;
  empty = 0;
  for(ip = uinode_cache; ip < &uinode_cache[NINODE]; ip++) {
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum) {
      ip->ref++;
      return ip;
    }
    if(empty == 0 && ip->ref == 0)
      empty = ip;
  }
  if(empty == 0)
    return 0;
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  return ip;
}

static void uilock(struct uinode *ip) {
  struct ubuf *bp;
  struct dinode *dip;
  if(ip->valid)
    return;
  bp = ubread(ip->dev, IBLOCK(ip->inum, sb));
  if(bp == 0)
    return;
  dip = (struct dinode*)bp->data + ip->inum % IPB;
  ip->type = dip->type;
  ip->major = dip->major;
  ip->minor = dip->minor;
  ip->nlink = dip->nlink;
  ip->size = dip->size;
  memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
  ubrelse(bp);
  ip->valid = 1;
}

static void uiput(struct uinode *ip) {
  ip->ref--;
  if(ip->ref == 0)
    ip->valid = 0;
}

static void uiupdate(struct uinode *ip) {
  struct ubuf *bp;
  struct dinode *dip;
  bp = ubread(ip->dev, IBLOCK(ip->inum, sb));
  if(bp == 0)
    return;
  dip = (struct dinode*)bp->data + ip->inum % IPB;
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  ubwrite(bp);
  ubrelse(bp);
}

static void readsb(void) {
  struct ubuf *bp = ubread(ROOTDEV, 1);
  if(bp) {
    memmove(&sb, bp->data, sizeof(sb));
    ubrelse(bp);
  }
}

static uint balloc(void) {
  int b, bi, m;
  struct ubuf *bp;
  for(b = 0; b < sb.size; b += BPB) {
    bp = ubread(ROOTDEV, BBLOCK(b, sb));
    if(bp == 0) continue;
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++) {
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0) {
        bp->data[bi/8] |= m;
        ubwrite(bp);
        ubrelse(bp);
        return b + bi;
      }
    }
    ubrelse(bp);
  }
  return 0;
}

static void bfree(uint b) {
  int bi, m;
  struct ubuf *bp;
  readsb();
  bp = ubread(ROOTDEV, BBLOCK(b, sb));
  if(bp == 0) return;
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0) {
    ubrelse(bp);
    return;
  }
  bp->data[bi/8] &= ~m;
  ubwrite(bp);
  ubrelse(bp);
}

static uint bmap(struct uinode *ip, uint bn) {
  uint addr;
  struct ubuf *bp;
  uint *a;
  if(bn < NDIRECT) {
    if((addr = ip->addrs[bn]) == 0) {
      addr = balloc();
      if(addr == 0) return 0;
      ip->addrs[bn] = addr;
    }
    return addr;
  }
  bn -= NDIRECT;
  if(bn < NINDIRECT) {
    if((addr = ip->addrs[NDIRECT]) == 0) {
      addr = balloc();
      if(addr == 0) return 0;
      ip->addrs[NDIRECT] = addr;
    }
    bp = ubread(ROOTDEV, addr);
    if(bp == 0) return 0;
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0) {
      addr = balloc();
      if(addr == 0) { ubrelse(bp); return 0; }
      a[bn] = addr;
      ubwrite(bp);
    }
    ubrelse(bp);
    return addr;
  }
  return 0;
}

static int uwritei(struct uinode *ip, char *src, uint off, uint n) {
  uint tot, m;
  struct ubuf *bp;
  uint addr;
  if(off + n < off) return -1;
  for(tot = 0; tot < n; tot += m, off += m, src += m) {
    addr = bmap(ip, off/BSIZE);
    if(addr == 0) return -1;
    bp = ubread(ROOTDEV, addr);
    if(bp == 0) return -1;
    m = umin(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
    ubwrite(bp);
    ubrelse(bp);
  }
  if(n > 0 && off > ip->size) {
    ip->size = off;
    uiupdate(ip);
  }
  return n;
}

static int ureadi(struct uinode *ip, char *dst, uint off, uint n) {
  uint tot, m;
  struct ubuf *bp;
  uint addr;
  if(off >= ip->size) return 0;
  if(off + n > ip->size) n = ip->size - off;
  for(tot = 0; tot < n; tot += m, off += m, dst += m) {
    addr = bmap(ip, off/BSIZE);
    if(addr == 0) return -1;
    bp = ubread(ROOTDEV, addr);
    if(bp == 0) return -1;
    m = umin(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    ubrelse(bp);
  }
  return n;
}

static struct uinode* dirlookup(struct uinode *dp, char *name, uint *poff) {
  uint off;
  struct dirent de;
  if(dp->type != T_DIR) return 0;
  for(off = 0; off < dp->size; off += sizeof(de)) {
    int r = ureadi(dp, (char*)&de, off, sizeof(de));
    if(r != sizeof(de))
      return 0;
    if(de.inum == 0) continue;
    if(unamecmp(name, de.name) == 0) {
      if(poff) *poff = off;
      return uiget(dp->dev, de.inum);
    }
  }
  return 0;
}

static int dirlink(struct uinode *dp, char *name, uint inum) {
  uint off;
  struct dirent de;
  
  // Check if name already exists
  if(dirlookup(dp, name, 0) != 0)
    return -1;
  
  // Find empty dirent
  for(off = 0; off < dp->size; off += sizeof(de)) {
    if(ureadi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      return -1;
    if(de.inum == 0)
      break;
  }
  
  // Create new dirent
  memset(&de, 0, sizeof(de));
  memmove(de.name, name, DIRSIZ);
  de.inum = inum;
  if(uwritei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    return -1;
  
  if(off >= dp->size) {
    dp->size = off + sizeof(de);
    uiupdate(dp);
  }
  return 0;
}

static struct uinode* namei(char *path) {
  struct uinode *ip, *next;
  char name[DIRSIZ];
  char *p;
  ip = uiget(ROOTDEV, ROOTINO);  // treat relative paths as root-relative

  p = path;
  while(*p == '/') p++;
  while(*p) {
    char *s = p;
    while(*p && *p != '/') p++;
    int len = p - s;
    if(len >= DIRSIZ) { memmove(name, s, DIRSIZ); name[DIRSIZ-1]=0; }
    else { memmove(name, s, len); name[len] = 0; }
    while(*p == '/') p++;
    uilock(ip);
    if(ip->type != T_DIR) { printf(1, "namei: not dir\n"); uiput(ip); return 0; }
    next = dirlookup(ip, name, 0);
    if(next == 0 && *p == 0) {
      // File not found and this is the final component
      printf(1, "namei: file not found\n");
      uiput(ip);
      return 0;
    }
    uiput(ip);
    if(next == 0) { printf(1, "namei: intermediate not found\n"); return 0; }
    ip = next;
  }
  return ip;
}

static struct uinode* nameiparent(char *path, char *name) {
  struct uinode *ip, *next;
  char *p;
  if(*path == '/')
    ip = uiget(ROOTDEV, ROOTINO);
  else
    return 0;
  p = path;
  while(*p == '/') p++;
  
  // Skip to parent directory
  while(*p) {
    char *s = p;
    while(*p && *p != '/') p++;
    int len = p - s;
    if(len >= DIRSIZ) { memmove(name, s, DIRSIZ); name[DIRSIZ-1]=0; }
    else { memmove(name, s, len); name[len] = 0; }
    
    // Check if this is the last component
    while(*p == '/') p++;
    if(*p == 0) return ip; // Found parent
    
    while(*p == '/') p++;
    uilock(ip);
    if(ip->type != T_DIR) { uiput(ip); return 0; }
    next = dirlookup(ip, name, 0);
    uiput(ip);
    if(next == 0) return 0;
    ip = next;
  }
  return 0;
}

static struct uinode* ialloc(short type) {
  int inum;
  struct ubuf *bp;
  struct dinode *dip;
  for(inum = 1; inum < sb.ninodes; inum++) {
    bp = ubread(ROOTDEV, IBLOCK(inum, sb));
    if(bp == 0) continue;
    dip = (struct dinode*)bp->data + inum % IPB;
    if(dip->type == 0) {
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      ubwrite(bp);
      ubrelse(bp);
      return uiget(ROOTDEV, inum);
    }
    ubrelse(bp);
  }
  return 0;
}

struct fd_entry {
  int used;
  int owner_pid;
  int fd;
  int off;
  int readable;
  int writable;
};

static struct fd_entry fd_table[MAX_REMOTE_FDS];
static struct uinode *fd_inodes[MAX_REMOTE_FDS];

static int alloc_remote_fd(int owner_pid, int flags) {
  int i;
  for(i = 0; i < MAX_REMOTE_FDS; i++) {
    if(!fd_table[i].used) {
      fd_table[i].used = 1;
      fd_table[i].owner_pid = owner_pid;
      fd_table[i].fd = i;
      fd_table[i].off = 0;
      fd_table[i].readable = !(flags & O_WRONLY);
      fd_table[i].writable = (flags & O_WRONLY) || (flags & O_RDWR);
      return i;
    }
  }
  return -1;
}

static struct fd_entry* lookup_remote_fd(int owner_pid, int remote_fd) {
  if(remote_fd < 0 || remote_fd >= MAX_REMOTE_FDS) return 0;
  if(!fd_table[remote_fd].used) return 0;
  if(fd_table[remote_fd].owner_pid != owner_pid) return 0;
  return &fd_table[remote_fd];
}

static void close_all_for_owner(int owner_pid) {
  int i;
  for(i = 0; i < MAX_REMOTE_FDS; i++) {
    if(fd_table[i].used && fd_table[i].owner_pid == owner_pid) {
      fd_table[i].used = 0;
      if(fd_inodes[i]) { uiput(fd_inodes[i]); fd_inodes[i] = 0; }
    }
  }
}

static void send_reply(int client_pid, int request_id, int result, int fd, int nbytes, char *data) {
  struct ipc_msg reply;
  memset(&reply, 0, sizeof(reply));
  reply.type = IPC_TYPE_FS_REPLY;
  reply.request_id = request_id;
  reply.fd = fd;
  reply.result = result;
  reply.nbytes = nbytes;
  if(data && nbytes > 0) {
    if(nbytes > IPC_DATA_SIZE) nbytes = IPC_DATA_SIZE;
    memmove(reply.data, data, nbytes);
  }
  if(send(client_pid, &reply) < 0)
    printf(1, "fsserver: failed reply to pid %d\n", client_pid);
}

int main(void) {
  struct ipc_msg req;
  struct fd_entry *ent;
  int remote_fd;
  int n;
  struct uinode *ip;

  if(register_fsserver() < 0) {
    printf(1, "fsserver: register failed\n");
    exit();
  }
  printf(1, "fsserver: started (pid=%d)\n", getpid());

  ubuf_init();
  uinode_init();
  readsb();

  for(;;) {
    memset(&req, 0, sizeof(req));
    if(recv(&req) < 0) {
      printf(1, "fsserver: recv failed\n");
      continue;
    }

    if(req.type == IPC_TYPE_FS_SHUTDOWN) {
      close_all_for_owner(req.sender_pid);
      send_reply(req.sender_pid, req.request_id, 0, -1, 0, 0);
      printf(1, "fsserver: shutdown\n");
      break;
    }

    if(req.type == IPC_TYPE_FS_CLIENT_EXIT) {
      close_all_for_owner(req.sender_pid);
      continue;
    }

    switch(req.type) {
    case IPC_TYPE_FS_OPEN:
      printf(1, "fsserver: OPEN path=%s flags=%d\n", req.path, req.flags);
      ip = namei(req.path);
      if(ip == 0 && (req.flags & O_CREATE)) {
        // Need to create file - get parent directory (root for simple paths)
        char name[DIRSIZ];
        char *p = req.path;
        while(*p == '/') p++;
        char *s = p;
        while(*p && *p != '/') p++;
        int len = p - s;
        if(len >= DIRSIZ) { memmove(name, s, DIRSIZ); name[DIRSIZ-1]=0; }
        else { memmove(name, s, len); name[len] = 0; }
        printf(1, "fsserver: creating file %s\n", name);
        
        // Get root directory
        struct uinode *dp = uiget(ROOTDEV, ROOTINO);
        if(dp == 0) {
          printf(1, "fsserver: failed to get root\n");
          send_reply(req.sender_pid, req.request_id, -1, -1, 0, 0);
          break;
        }
        uilock(dp);
        printf(1, "fsserver: root dir size=%d\n", dp->size);
        
        ip = ialloc(T_FILE);
        if(ip == 0) {
          printf(1, "fsserver: ialloc failed\n");
          uiput(dp);
          send_reply(req.sender_pid, req.request_id, -1, -1, 0, 0);
          break;
        }
        printf(1, "fsserver: allocated inode %d\n", ip->inum);
        uilock(ip);
        ip->nlink = 1;
        uiupdate(ip);
        
        if(dirlink(dp, name, ip->inum) < 0) {
          printf(1, "fsserver: dirlink failed\n");
          ip->nlink = 0;
          uiupdate(ip);
          uiput(ip);
          uiput(dp);
          send_reply(req.sender_pid, req.request_id, -1, -1, 0, 0);
          break;
        }
        uiput(dp);
      }
      if(ip == 0) {
        printf(1, "fsserver: file not found\n");
        send_reply(req.sender_pid, req.request_id, -1, -1, 0, 0);
        break;
      }
      uilock(ip);
      printf(1, "fsserver: file found, inum=%d size=%d\n", ip->inum, ip->size);
      remote_fd = alloc_remote_fd(req.sender_pid, req.flags);
      if(remote_fd < 0) {
        uiput(ip);
        send_reply(req.sender_pid, req.request_id, -1, -1, 0, 0);
        break;
      }
      fd_inodes[remote_fd] = ip;
      send_reply(req.sender_pid, req.request_id, remote_fd, remote_fd, 0, 0);
      break;

    case IPC_TYPE_FS_READ:
      ent = lookup_remote_fd(req.sender_pid, req.fd);
      if(!ent || !ent->readable) {
        send_reply(req.sender_pid, req.request_id, -1, req.fd, 0, 0);
        break;
      }
      ip = fd_inodes[req.fd];
      if(!ip) {
        send_reply(req.sender_pid, req.request_id, -1, req.fd, 0, 0);
        break;
      }
      n = req.nbytes;
      if(n > IPC_DATA_SIZE) n = IPC_DATA_SIZE;
      if(ent->off >= ip->size) {
        send_reply(req.sender_pid, req.request_id, 0, req.fd, 0, 0);
        break;
      }
      if(n > ip->size - ent->off) n = ip->size - ent->off;
      n = ureadi(ip, req.data, ent->off, n);
      if(n < 0)
        send_reply(req.sender_pid, req.request_id, -1, req.fd, 0, 0);
      else {
        ent->off += n;
        send_reply(req.sender_pid, req.request_id, n, req.fd, n, req.data);
      }
      break;

    case IPC_TYPE_FS_WRITE:
      ent = lookup_remote_fd(req.sender_pid, req.fd);
      if(!ent || !ent->writable) {
        send_reply(req.sender_pid, req.request_id, -1, req.fd, 0, 0);
        break;
      }
      ip = fd_inodes[req.fd];
      if(!ip) {
        send_reply(req.sender_pid, req.request_id, -1, req.fd, 0, 0);
        break;
      }
      n = req.nbytes;
      if(n > IPC_DATA_SIZE) n = IPC_DATA_SIZE;
      n = uwritei(ip, req.data, ent->off, n);
      if(n < 0)
        send_reply(req.sender_pid, req.request_id, -1, req.fd, 0, 0);
      else {
        ent->off += n;
        send_reply(req.sender_pid, req.request_id, n, req.fd, 0, 0);
      }
      break;

    case IPC_TYPE_FS_CLOSE:
      ent = lookup_remote_fd(req.sender_pid, req.fd);
      if(!ent) {
        send_reply(req.sender_pid, req.request_id, -1, req.fd, 0, 0);
        break;
      }
      if(fd_inodes[req.fd]) {
        uiput(fd_inodes[req.fd]);
        fd_inodes[req.fd] = 0;
      }
      ent->used = 0;
      send_reply(req.sender_pid, req.request_id, 0, req.fd, 0, 0);
      break;

    default:
      send_reply(req.sender_pid, req.request_id, -1, req.fd, 0, 0);
      break;
    }
  }

  exit();
}
