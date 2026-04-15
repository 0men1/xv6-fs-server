#include "types.h"
#include "user.h"
#include "fcntl.h"
#include "ipc.h"

#define MAX_REMOTE_FDS 64

struct fd_entry {
  int used;
  int owner_pid;
  int real_fd;
};

static struct fd_entry fd_table[MAX_REMOTE_FDS];

static int
alloc_remote_fd(int owner_pid, int real_fd)
{
  int i;
  for(i = 0; i < MAX_REMOTE_FDS; i++){
    if(!fd_table[i].used){
      fd_table[i].used = 1;
      fd_table[i].owner_pid = owner_pid;
      fd_table[i].real_fd = real_fd;
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
  int i;
  for(i = 0; i < MAX_REMOTE_FDS; i++){
    if(fd_table[i].used && fd_table[i].owner_pid == owner_pid){
      close(fd_table[i].real_fd);
      fd_table[i].used = 0;
    }
  }
}

static void
send_reply(int client_pid, int result, int fd, int nbytes, char *data)
{
  struct ipc_msg reply;

  memset(&reply, 0, sizeof(reply));
  reply.type = IPC_TYPE_FS_REPLY;
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
  int real_fd;
  int remote_fd;
  int rc;
  int n;

  printf(1, "fsserver: started (pid=%d)\n", getpid());

  for(;;){
    memset(&req, 0, sizeof(req));
    if(recv(&req) < 0){
      printf(1, "fsserver: recv failed\n");
      continue;
    }

    if(req.type == IPC_TYPE_FS_SHUTDOWN){
      close_all_for_owner(req.sender_pid);
      send_reply(req.sender_pid, 0, -1, 0, 0);
      printf(1, "fsserver: shutdown requested by pid %d\n", req.sender_pid);
      break;
    }

    switch(req.type){
    case IPC_TYPE_FS_OPEN:
      real_fd = open(req.path, req.flags);
      if(real_fd < 0){
        send_reply(req.sender_pid, -1, -1, 0, 0);
        break;
      }
      remote_fd = alloc_remote_fd(req.sender_pid, real_fd);
      if(remote_fd < 0){
        close(real_fd);
        send_reply(req.sender_pid, -1, -1, 0, 0);
        break;
      }
      send_reply(req.sender_pid, remote_fd, remote_fd, 0, 0);
      break;

    case IPC_TYPE_FS_READ:
      ent = lookup_remote_fd(req.sender_pid, req.fd);
      if(ent == 0){
        send_reply(req.sender_pid, -1, req.fd, 0, 0);
        break;
      }
      n = req.nbytes;
      if(n < 0)
        n = 0;
      if(n > IPC_DATA_SIZE)
        n = IPC_DATA_SIZE;
      rc = read(ent->real_fd, req.data, n);
      if(rc < 0){
        send_reply(req.sender_pid, -1, req.fd, 0, 0);
      } else {
        send_reply(req.sender_pid, rc, req.fd, rc, req.data);
      }
      break;

    case IPC_TYPE_FS_WRITE:
      ent = lookup_remote_fd(req.sender_pid, req.fd);
      if(ent == 0){
        send_reply(req.sender_pid, -1, req.fd, 0, 0);
        break;
      }
      n = req.nbytes;
      if(n < 0)
        n = 0;
      if(n > IPC_DATA_SIZE)
        n = IPC_DATA_SIZE;
      rc = write(ent->real_fd, req.data, n);
      if(rc < 0){
        send_reply(req.sender_pid, -1, req.fd, 0, 0);
      } else {
        send_reply(req.sender_pid, rc, req.fd, 0, 0);
      }
      break;

    case IPC_TYPE_FS_CLOSE:
      ent = lookup_remote_fd(req.sender_pid, req.fd);
      if(ent == 0){
        send_reply(req.sender_pid, -1, req.fd, 0, 0);
        break;
      }
      rc = close(ent->real_fd);
      ent->used = 0;
      if(rc < 0)
        send_reply(req.sender_pid, -1, req.fd, 0, 0);
      else
        send_reply(req.sender_pid, 0, req.fd, 0, 0);
      break;

    default:
      send_reply(req.sender_pid, -1, req.fd, 0, 0);
      break;
    }
  }

  exit();
}
