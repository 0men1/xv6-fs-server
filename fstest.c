#include "types.h"
#include "user.h"
#include "fcntl.h"
#include "ipc.h"

static int
fs_call(int server_pid, struct ipc_msg *msg)
{
  struct ipc_msg reply;

  if(send(server_pid, msg) < 0)
    return -1;
  if(recv(&reply) < 0)
    return -1;
  if(reply.type != IPC_TYPE_FS_REPLY)
    return -1;

  *msg = reply;
  return 0;
}

static int
fs_open_remote(int server_pid, char *path, int flags)
{
  struct ipc_msg msg;
  int i;
  memset(&msg, 0, sizeof(msg));
  msg.type = IPC_TYPE_FS_OPEN;
  msg.flags = flags;
  for(i = 0; i < IPC_PATH_SIZE - 1 && path[i] != 0; i++)
    msg.path[i] = path[i];
  msg.path[i] = 0;

  if(fs_call(server_pid, &msg) < 0)
    return -1;
  return msg.result;
}

static int
fs_write_remote(int server_pid, int fd, char *buf, int n)
{
  struct ipc_msg msg;
  if(n > IPC_DATA_SIZE)
    n = IPC_DATA_SIZE;
  if(n < 0)
    n = 0;

  memset(&msg, 0, sizeof(msg));
  msg.type = IPC_TYPE_FS_WRITE;
  msg.fd = fd;
  msg.nbytes = n;
  memmove(msg.data, buf, n);

  if(fs_call(server_pid, &msg) < 0)
    return -1;
  return msg.result;
}

static int
fs_read_remote(int server_pid, int fd, char *buf, int n)
{
  struct ipc_msg msg;
  if(n > IPC_DATA_SIZE)
    n = IPC_DATA_SIZE;
  if(n < 0)
    n = 0;

  memset(&msg, 0, sizeof(msg));
  msg.type = IPC_TYPE_FS_READ;
  msg.fd = fd;
  msg.nbytes = n;

  if(fs_call(server_pid, &msg) < 0)
    return -1;
  if(msg.result < 0)
    return -1;
  if(msg.nbytes > 0)
    memmove(buf, msg.data, msg.nbytes);
  return msg.result;
}

static int
fs_close_remote(int server_pid, int fd)
{
  struct ipc_msg msg;
  memset(&msg, 0, sizeof(msg));
  msg.type = IPC_TYPE_FS_CLOSE;
  msg.fd = fd;

  if(fs_call(server_pid, &msg) < 0)
    return -1;
  return msg.result;
}

static void
fs_shutdown_remote(int server_pid)
{
  struct ipc_msg msg;
  memset(&msg, 0, sizeof(msg));
  msg.type = IPC_TYPE_FS_SHUTDOWN;
  fs_call(server_pid, &msg);
}

int
main(void)
{
  int server_pid;
  int fd;
  int n;
  char buf[IPC_DATA_SIZE + 1];
  char msg[] = "hello from IPC file server\n";

  server_pid = fork();
  if(server_pid < 0){
    printf(1, "fstest: fork failed\n");
    exit();
  }

  if(server_pid == 0){
    char *argv[] = { "fsserver", 0 };
    exec("fsserver", argv);
    printf(1, "fstest: exec fsserver failed\n");
    exit();
  }

  sleep(10);

  fd = fs_open_remote(server_pid, "ipcfs.txt", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "fstest: remote open failed\n");
    kill(server_pid);
    wait();
    exit();
  }

  if(fs_write_remote(server_pid, fd, msg, strlen(msg)) < 0){
    printf(1, "fstest: remote write failed\n");
  }
  if(fs_close_remote(server_pid, fd) < 0){
    printf(1, "fstest: remote close failed\n");
  }

  fd = fs_open_remote(server_pid, "ipcfs.txt", O_RDONLY);
  if(fd < 0){
    printf(1, "fstest: reopen failed\n");
    fs_shutdown_remote(server_pid);
    wait();
    exit();
  }

  n = fs_read_remote(server_pid, fd, buf, IPC_DATA_SIZE);
  if(n < 0){
    printf(1, "fstest: remote read failed\n");
  } else {
    buf[n] = 0;
    printf(1, "fstest: read %d bytes: %s", n, buf);
  }
  fs_close_remote(server_pid, fd);

  fs_shutdown_remote(server_pid);
  wait();
  exit();
}
