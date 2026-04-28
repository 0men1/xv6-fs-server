// File-system system calls.
// Mostly argument checking, since we don't trust
// user code, and calls into file.c and fs.c.
//
// DONE(01-current-fs-map): Current monolithic FS path:
// sys_open validates user arguments, resolves or creates an inode through
// fs.c, allocates a struct file in file.c, and installs it in proc->ofile[].
// sys_read, sys_write, and sys_close fetch proc->ofile[] entries here, then
// call file.c helpers. FD_INODE operations continue through fs.c inode code,
// log.c transactions, bio.c buffers, and ide.c disk I/O.
//
// DONE(14-client-remote-fd): What: design how the kernel represents a
// client-side remote file descriptor after fsserver opens a file. Options
// include adding an FD_REMOTE type to struct file or adding a separate per-proc
// remote fd table. Why: sys_read/sys_write/sys_close need a reliable way to
// detect "this fd is served by fsserver" without confusing it with pipes,
// devices, or old inode-backed files.

#include "types.h"
#include "defs.h"
#include "param.h"
#include "stat.h"
#include "mmu.h"
#include "proc.h"
#include "fs.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "file.h"
#include "fcntl.h"

static int next_fs_request_id = 1;

static int
fsserver_active(void)
{
  return get_fsserver_pid() > 0 && !is_fsserver();
}

static int
fs_ipc_call(struct ipc_msg *req, struct ipc_msg *reply)
{
  int server_pid;
  int request_id;

  server_pid = get_fsserver_pid();
  if(server_pid < 0)
    return -1;

  request_id = __sync_fetch_and_add(&next_fs_request_id, 1);
  req->request_id = request_id;

  if(ipc_send_msg(server_pid, req) < 0)
    return -1;
  if(ipc_recv_msg(reply) < 0)
    return -1;
  if(reply->type != IPC_TYPE_FS_REPLY || reply->request_id != request_id)
    return -1;
  return 0;
}

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
}

int
sys_dup(void)
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
  if(f->type == FD_REMOTE)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}

int
sys_read(void)
{
  struct file *f;
  int n;
  char *p;

  // DONE(18-reroute-read): What: when fd is a remote fsserver file, validate
  // the user buffer and byte count, send IPC_TYPE_FS_READ, wait for
  // IPC_TYPE_FS_REPLY, and copy returned bytes into p. Why: normal user programs
  // should call read() unchanged while the kernel forwards regular-file work to
  // fsserver. Keep pipe/device reads local unless the design moves them too.
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
  if(f->type == FD_REMOTE){
    struct ipc_msg req;
    struct ipc_msg reply;
    int total;
    int chunk;

    total = 0;
    while(total < n){
      chunk = n - total;
      if(chunk > IPC_DATA_SIZE)
        chunk = IPC_DATA_SIZE;

      memset(&req, 0, sizeof(req));
      req.type = IPC_TYPE_FS_READ;
      req.fd = f->remote_fd;
      req.nbytes = chunk;

      if(fs_ipc_call(&req, &reply) < 0 || reply.result < 0)
        return total > 0 ? total : -1;
      if(reply.nbytes > reply.result)
        return total > 0 ? total : -1;
      if(reply.result == 0)
        break;

      memmove(p + total, reply.data, reply.result);
      total += reply.result;

      if(reply.result < chunk)
        break;
    }
    return total;
  }
  return fileread(f, p, n);
}

int
sys_write(void)
{
  struct file *f;
  int n;
  char *p;

  // DONE(19-reroute-write): What: when fd is a remote fsserver file, gather the
  // user buffer into one or more IPC_DATA_SIZE payloads, send IPC_TYPE_FS_WRITE,
  // and return the fsserver result. Why: write() must preserve the normal xv6
  // API while moving regular-file writes through IPC.
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
  if(f->type == FD_REMOTE){
    struct ipc_msg req;
    struct ipc_msg reply;
    int total;
    int chunk;

    total = 0;
    while(total < n){
      chunk = n - total;
      if(chunk > IPC_DATA_SIZE)
        chunk = IPC_DATA_SIZE;

      memset(&req, 0, sizeof(req));
      req.type = IPC_TYPE_FS_WRITE;
      req.fd = f->remote_fd;
      req.nbytes = chunk;
      memmove(req.data, p + total, chunk);

      if(fs_ipc_call(&req, &reply) < 0 || reply.result < 0)
        return total > 0 ? total : -1;
      if(reply.result == 0)
        break;
      total += reply.result;
      if(reply.result < chunk)
        break;
    }
    return total;
  }
  return filewrite(f, p, n);
}

int
sys_close(void)
{
  int fd;
  struct file *f;

  // DONE(17-reroute-close): What: if fd is a remote fsserver descriptor, send
  // IPC_TYPE_FS_CLOSE and clear client-side descriptor state only after the
  // server confirms or returns a defined error. Why: close() owns cleanup, so
  // stale remote descriptors here will leak server-side file state.
  if(argfd(0, &fd, &f) < 0)
    return -1;
  if(f->type == FD_REMOTE){
    struct ipc_msg req;
    struct ipc_msg reply;
    int result;

    memset(&req, 0, sizeof(req));
    req.type = IPC_TYPE_FS_CLOSE;
    req.fd = f->remote_fd;

    result = -1;
    if(fs_ipc_call(&req, &reply) == 0)
      result = reply.result;

    proc->ofile[fd] = 0;
    fileclose(f);
    return result;
  }
  proc->ofile[fd] = 0;
  fileclose(f);
  return 0;
}

int
sys_fstat(void)
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
  return filestat(f, st);
}

static int
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;
  // Is the directory dp empty except for "." and ".." ?
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
    if(de.inum != 0)
      return 0;
  }
  return 1;
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;

  begin_op();
  if((ip = namei(old)) == 0){
    end_op();
    return -1;
  }

  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
  iput(ip);

  end_op();

  return 0;

bad:
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
//PAGEBREAK!

int
sys_unlink(void)
{
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
    end_op();
    return -1;
  }

  ilock(dp);

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);

  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);

  end_op();

  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
  ilock(dp);

  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");

  ilock(ip);
  ip->major = major;
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
    iupdate(dp);
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}

int
sys_open(void)
{
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
    return -1;

  if(fsserver_active()){
    struct ipc_msg req;
    struct ipc_msg reply;

    if(strlen(path) >= IPC_PATH_SIZE)
      return -1;

    memset(&req, 0, sizeof(req));
    req.type = IPC_TYPE_FS_OPEN;
    req.flags = omode;
    safestrcpy(req.path, path, sizeof(req.path));

    if(fs_ipc_call(&req, &reply) < 0 || reply.result < 0)
      return -1;

    if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
      if(f)
        fileclose(f);

      memset(&req, 0, sizeof(req));
      req.type = IPC_TYPE_FS_CLOSE;
      req.fd = reply.fd;
      fs_ipc_call(&req, &reply);
      return -1;
    }

    f->type = FD_REMOTE;
    f->ip = 0;
    f->pipe = 0;
    f->off = 0;
    f->remote_fd = reply.fd;
    f->remote_owner = get_fsserver_pid();
    f->readable = !(omode & O_WRONLY);
    f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    return fd;
  }

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
      end_op();
      return -1;
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
      iunlockput(ip);
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}

int
sys_mkdir(void)
{
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
  end_op();
  return 0;
}

int
sys_mknod(void)
{
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
  end_op();
  return 0;
}

int
sys_chdir(void)
{
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
  iput(proc->cwd);
  end_op();
  proc->cwd = ip;
  return 0;
}

int
sys_exec(void)
{
  char *path, *argv[MAXARG];
  int i;
  addr_t uargv, uarg;

  if(argstr(0, &path) < 0 || argaddr(1, &uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchaddr(uargv+(sizeof(addr_t))*i, (addr_t*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}

int
sys_pipe(void)
{
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      proc->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
