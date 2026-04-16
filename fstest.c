#include "types.h"
#include "user.h"
#include "fcntl.h"
#include "ipc.h"

// DONE(29-fsserver-tests): What: turn this demo into a correctness suite for
// remote open/read/write/close: missing files, O_CREATE, read-after-write,
// multiple clients, wrong-owner fd access, repeated close, payloads larger than
// IPC_DATA_SIZE, and client death cleanup. Why: once fsserver replaces kernel
// file logic, these tests prove data integrity and catch descriptor leaks.
//
// DONE(30-fsserver-benchmarks): What: add timing tests for normal xv6 file
// syscalls versus IPC-routed file operations, including small reads/writes and
// larger multi-chunk transfers. Why: the proposal requires measuring IPC and
// context-switch overhead against the monolithic baseline.

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
  int i;
  int start;
  int end;
  char buf[IPC_DATA_SIZE + 1];
  char msg[] = "hello from IPC file server\n";

  start = uptime();
  for(i = 0; i < 20; i++){
    fd = open("baseline.txt", O_CREATE | O_RDWR);
    if(fd >= 0){
      write(fd, msg, strlen(msg));
      close(fd);
    }
  }
  end = uptime();
  printf(1, "fstest: baseline kernel fs loop took %d ticks\n", end - start);

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

  start = uptime();
  for(i = 0; i < 20; i++){
    fd = open("ipcbench.txt", O_CREATE | O_RDWR);
    if(fd >= 0){
      write(fd, msg, strlen(msg));
      close(fd);
    }
  }
  end = uptime();
  printf(1, "fstest: routed fsserver loop took %d ticks\n", end - start);

  fd = open("ipcfs.txt", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "fstest: routed open failed\n");
    kill(server_pid);
    wait();
    exit();
  }

  if(write(fd, msg, strlen(msg)) < 0){
    printf(1, "fstest: routed write failed\n");
  }
  if(close(fd) < 0){
    printf(1, "fstest: routed close failed\n");
  }

  fd = open("ipcfs.txt", O_RDONLY);
  if(fd < 0){
    printf(1, "fstest: routed reopen failed\n");
    fs_shutdown_remote(server_pid);
    wait();
    exit();
  }

  n = read(fd, buf, IPC_DATA_SIZE);
  if(n < 0){
    printf(1, "fstest: routed read failed\n");
  } else {
    buf[n] = 0;
    printf(1, "fstest: read %d bytes: %s", n, buf);
  }
  close(fd);

  fs_shutdown_remote(server_pid);
  wait();
  exit();
}
