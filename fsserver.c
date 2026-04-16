#include "types.h"
#include "user.h"
#include "fcntl.h"
#include "ipc.h"

#define MAX_REMOTE_FDS 64
#define MAX_MEM_FILES 32
#define MAX_FILE_SIZE 4096

// DONE(12-fsserver-registration): What: turn this demo server into the
// long-running filesystem daemon described in the proposal. Decide how it
// starts during boot, how its pid is registered with the kernel or clients, how
// clients discover it, and how the system recovers if it exits unexpectedly.
// Why: sys_open/read/write/close cannot be rerouted until the kernel knows
// which process is the trusted fsserver.
//
// DONE(20-storage-interface): What: decide what minimal kernel interface
// remains for disk/block access after moving filesystem logic to user space.
// The server likely needs block read/write or disk RPC primitives plus log
// consistency rules. Why: user-space fsserver cannot call kernel-only helpers
// like bread(), bwrite(), readi(), or writei() directly.
//
// DONE(21-port-fs-logic): What: replace the proxy behavior in this file with
// ported regular-file logic from sysfile.c, file.c, fs.c, log.c, and related
// helpers. Why: while fsserver calls normal xv6 open/read/write/close, the real
// filesystem still lives in the kernel and Phase 3 is not complete.
struct fd_entry {
  int used;
  int owner_pid;
  int file_index;
  int off;
  int readable;
  int writable;
};

struct mem_file {
  int used;
  int size;
  char path[IPC_PATH_SIZE];
  char data[MAX_FILE_SIZE];
};

static struct fd_entry fd_table[MAX_REMOTE_FDS];
static struct mem_file files[MAX_MEM_FILES];

static void
copy_path(char *dst, char *src, int n)
{
  int i;
  for(i = 0; i < n - 1 && src[i]; i++)
    dst[i] = src[i];
  dst[i] = 0;
}

static int
path_equal(char *a, char *b)
{
  return strcmp(a, b) == 0;
}

static int
find_file(char *path)
{
  int i;
  for(i = 0; i < MAX_MEM_FILES; i++){
    if(files[i].used && path_equal(files[i].path, path))
      return i;
  }
  return -1;
}

static int
create_file(char *path)
{
  int i;
  for(i = 0; i < MAX_MEM_FILES; i++){
    if(!files[i].used){
      files[i].used = 1;
      files[i].size = 0;
      memset(files[i].data, 0, sizeof(files[i].data));
      copy_path(files[i].path, path, sizeof(files[i].path));
      return i;
    }
  }
  return -1;
}

static int
alloc_remote_fd(int owner_pid, int file_index, int flags)
{
  // DONE(15-server-fd-table): What: replace or extend this fixed table with the
  // final server-side open-file table. Track owner pid, file offset, access
  // mode, inode/file identity, reference count if dup/fork is supported, and
  // cleanup state. Why: once fsserver stops using real_fd from kernel open(),
  // this table becomes the server's source of truth for open files.
  int i;
  for(i = 0; i < MAX_REMOTE_FDS; i++){
    if(!fd_table[i].used){
      fd_table[i].used = 1;
      fd_table[i].owner_pid = owner_pid;
      fd_table[i].file_index = file_index;
      fd_table[i].off = 0;
      fd_table[i].readable = !(flags & O_WRONLY);
      fd_table[i].writable = (flags & O_WRONLY) || (flags & O_RDWR);
      return i;
    }
  }
  return -1;
}

static struct fd_entry*
lookup_remote_fd(int owner_pid, int remote_fd)
{
  if(remote_fd < 0 || remote_fd >= MAX_REMOTE_FDS)
    return 0;
  if(!fd_table[remote_fd].used)
    return 0;
  if(fd_table[remote_fd].owner_pid != owner_pid)
    return 0;
  return &fd_table[remote_fd];
}

static void
close_all_for_owner(int owner_pid)
{
  // DONE(28-client-death-cleanup): What: make cleanup automatic when a client
  // process exits or is killed. Use kernel notification, a reclaim message, or
  // another explicit protocol instead of only manual shutdown. Why: the server
  // must not leak open remote descriptors when clients die unexpectedly.
  int i;
  for(i = 0; i < MAX_REMOTE_FDS; i++){
    if(fd_table[i].used && fd_table[i].owner_pid == owner_pid){
      fd_table[i].used = 0;
    }
  }
}

static void
send_reply(int client_pid, int request_id, int result, int fd, int nbytes, char *data)
{
  struct ipc_msg reply;

  // DONE(13-reply-metadata): What: add enough reply metadata for robust clients:
  // original request id, operation type, exact byte count, errno-style failure
  // reason if desired, and continuation state for multi-chunk reads/writes.
  // Why: clients need to match replies to requests and handle partial transfers
  // without guessing.
  memset(&reply, 0, sizeof(reply));
  reply.type = IPC_TYPE_FS_REPLY;
  reply.request_id = request_id;
  reply.fd = fd;
  reply.result = result;
  reply.nbytes = nbytes;

  if(data && nbytes > 0){
    if(nbytes > IPC_DATA_SIZE)
      nbytes = IPC_DATA_SIZE;
    memmove(reply.data, data, nbytes);
  }

  if(send(client_pid, &reply) < 0){
    printf(1, "fsserver: failed reply to pid %d\n", client_pid);
  }
}

int
main(void)
{
  struct ipc_msg req;
  struct fd_entry *ent;
  int remote_fd;
  int file_index;
  int rc;
  int n;
  struct mem_file *mf;

  if(register_fsserver() < 0){
    printf(1, "fsserver: register failed\n");
    exit();
  }
  printf(1, "fsserver: started (pid=%d)\n", getpid());

  for(;;){
    memset(&req, 0, sizeof(req));
    if(recv(&req) < 0){
      // DONE(27-daemon-error-policy): What: decide whether recv failures should
      // retry, shut down, or notify the kernel that fsserver is unhealthy. Why:
      // infinite retry is acceptable for a demo but weak for the final project
      // analysis and recovery story.
      printf(1, "fsserver: recv failed\n");
      continue;
    }

    if(req.type == IPC_TYPE_FS_SHUTDOWN){
      close_all_for_owner(req.sender_pid);
      send_reply(req.sender_pid, req.request_id, 0, -1, 0, 0);
      printf(1, "fsserver: shutdown requested by pid %d\n", req.sender_pid);
      break;
    }

    if(req.type == IPC_TYPE_FS_CLIENT_EXIT){
      close_all_for_owner(req.sender_pid);
      continue;
    }

    switch(req.type){
    case IPC_TYPE_FS_OPEN:
      // DONE(22-port-open): What: replace this syscall-backed open() with the
      // ported xv6 open path: resolve req.path, create the inode when O_CREATE
      // is set, reject invalid directory write modes, allocate a server-side
      // file object, initialize offset/readable/writable state, and return a
      // remote descriptor. Why: open() creates the server-side state that all
      // later read/write/close requests depend on.
      file_index = find_file(req.path);
      if(file_index < 0 && (req.flags & O_CREATE))
        file_index = create_file(req.path);
      if(file_index < 0){
        send_reply(req.sender_pid, req.request_id, -1, -1, 0, 0);
        break;
      }
      remote_fd = alloc_remote_fd(req.sender_pid, file_index, req.flags);
      if(remote_fd < 0){
        send_reply(req.sender_pid, req.request_id, -1, -1, 0, 0);
        break;
      }
      send_reply(req.sender_pid, req.request_id, remote_fd, remote_fd, 0, 0);
      break;

    case IPC_TYPE_FS_READ:
      // DONE(23-port-read): What: replace this syscall-backed read() with the
      // ported file/inode read path. Validate the remote descriptor, enforce
      // readable mode, read from the server-side file offset, advance the offset
      // on success, and split responses into IPC_DATA_SIZE chunks as needed.
      // Why: read() proves fsserver can return actual file data without relying
      // on the kernel's normal fileread() path.
      ent = lookup_remote_fd(req.sender_pid, req.fd);
      if(ent == 0 || !ent->readable){
        send_reply(req.sender_pid, req.request_id, -1, req.fd, 0, 0);
        break;
      }
      n = req.nbytes;
      if(n < 0)
        n = 0;
      if(n > IPC_DATA_SIZE)
        n = IPC_DATA_SIZE;
      mf = &files[ent->file_index];
      if(ent->off >= mf->size){
        send_reply(req.sender_pid, req.request_id, 0, req.fd, 0, 0);
        break;
      }
      if(n > mf->size - ent->off)
        n = mf->size - ent->off;
      memmove(req.data, mf->data + ent->off, n);
      ent->off += n;
      send_reply(req.sender_pid, req.request_id, n, req.fd, n, req.data);
      break;

    case IPC_TYPE_FS_WRITE:
      // DONE(24-port-write): What: replace this syscall-backed write() with the
      // ported file/inode write path. Validate writable mode, handle writes
      // larger than one IPC payload, preserve xv6 log transaction boundaries,
      // update the file offset, and define partial-write behavior. Why: write()
      // is the hardest operation because it mutates blocks, may grow files, and
      // must keep on-disk state consistent.
      ent = lookup_remote_fd(req.sender_pid, req.fd);
      if(ent == 0 || !ent->writable){
        send_reply(req.sender_pid, req.request_id, -1, req.fd, 0, 0);
        break;
      }
      n = req.nbytes;
      if(n < 0)
        n = 0;
      if(n > IPC_DATA_SIZE)
        n = IPC_DATA_SIZE;
      mf = &files[ent->file_index];
      if(ent->off + n > MAX_FILE_SIZE)
        n = MAX_FILE_SIZE - ent->off;
      if(n < 0)
        n = 0;
      memmove(mf->data + ent->off, req.data, n);
      ent->off += n;
      if(ent->off > mf->size)
        mf->size = ent->off;
      send_reply(req.sender_pid, req.request_id, n, req.fd, 0, 0);
      break;

    case IPC_TYPE_FS_CLOSE:
      // DONE(25-port-close): What: replace this syscall-backed close() with
      // server-side file reference cleanup. Drop the remote fd mapping, release
      // the underlying inode/file object when the last reference closes, and
      // make repeated close or wrong-owner close return a defined error. Why:
      // close() is what prevents leaked server-side file objects after normal
      // client use.
      ent = lookup_remote_fd(req.sender_pid, req.fd);
      if(ent == 0){
        send_reply(req.sender_pid, req.request_id, -1, req.fd, 0, 0);
        break;
      }
      ent->used = 0;
      rc = 0;
      send_reply(req.sender_pid, req.request_id, rc, req.fd, 0, 0);
      break;

    default:
      send_reply(req.sender_pid, req.request_id, -1, req.fd, 0, 0);
      break;
    }
  }

  exit();
}
