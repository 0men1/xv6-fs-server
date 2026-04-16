#pragma once

#define IPC_PATH_SIZE 64
#define IPC_DATA_SIZE 128

// DONE(02-ipc-protocol): What: finalize and document the request/reply format
// before changing syscall routing or fsserver internals. Decide whether this
// fixed struct is enough or whether the protocol needs a header plus
// operation-specific payloads. Define path limits, payload limits, result/error
// meanings, request ids, and multi-chunk read/write rules. Why: the kernel,
// client helpers, tests, and fsserver must all agree on the same wire format
// before Phase 3 code can be trusted.
enum ipc_msg_type {
  IPC_TYPE_FS_OPEN = 1,
  IPC_TYPE_FS_READ = 2,
  IPC_TYPE_FS_WRITE = 3,
  IPC_TYPE_FS_CLOSE = 4,
  IPC_TYPE_FS_REPLY = 100,
  IPC_TYPE_FS_SHUTDOWN = 101,
  IPC_TYPE_FS_CLIENT_EXIT = 102
};

struct ipc_msg {
  // DONE(03-sender-auth): What: keep sender_pid as kernel-owned metadata only.
  // send() must always overwrite this field, and fsserver must trust only the
  // kernel-filled value. Why: clients must not be able to spoof another PID and
  // steal, close, or write through another process's remote file descriptors.
  int sender_pid;              // Filled by kernel send()
  int request_id;              // Copied into replies to match request/response
  int type;                    // enum ipc_msg_type
  int fd;                      // Client-visible descriptor for read/write/close
  int flags;                   // Open flags
  int nbytes;                  // Requested or returned data length
  int result;                  // Return code: >=0 success, <0 failure
  int error;                   // Optional error detail; 0 when unused
  char path[IPC_PATH_SIZE];    // Path for open requests
  char data[IPC_DATA_SIZE];    // Payload for write/reply data
};
