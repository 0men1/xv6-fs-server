#pragma once

#define IPC_PATH_SIZE 64
#define IPC_DATA_SIZE 128

enum ipc_msg_type {
  IPC_TYPE_FS_OPEN = 1,
  IPC_TYPE_FS_READ = 2,
  IPC_TYPE_FS_WRITE = 3,
  IPC_TYPE_FS_CLOSE = 4,
  IPC_TYPE_FS_REPLY = 100,
  IPC_TYPE_FS_SHUTDOWN = 101
};

struct ipc_msg {
  int sender_pid;              // Filled by kernel send()
  int type;                    // enum ipc_msg_type
  int fd;                      // Client-visible descriptor for read/write/close
  int flags;                   // Open flags
  int nbytes;                  // Requested or returned data length
  int result;                  // Return code: >=0 success, <0 failure
  char path[IPC_PATH_SIZE];    // Path for open requests
  char data[IPC_DATA_SIZE];    // Payload for write/reply data
};
