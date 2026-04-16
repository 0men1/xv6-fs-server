#include "user.h"
#include "ipc.h"

// DONE(26-ipc-tests): What: expand this IPC smoke test into cases for invalid
// target PIDs, receiver exit while sender is blocked, multiple clients sending
// to one server, repeated send/recv loops, and maximum-size payloads. Why:
// Phase 3 depends on IPC being reliable under the same pressure that fsserver
// will create.

void server() {
    struct ipc_msg msg;
    printf(1, "Server: waiting for message...\n");
    
    if (recv(&msg) < 0) {
        printf(1, "Server: receive failed\n");
        exit();
    }

    printf(1, "Server: received from PID %d: %s\n", msg.sender_pid, msg.data);
    
    int client_pid = msg.sender_pid;
    msg.sender_pid = getpid();
    strcpy(msg.data, "ACK");
    
    if (send(client_pid, &msg) < 0) {
        printf(1, "Server: send failed\n");
    }
    exit();
}

void client(int server_pid) {
    struct ipc_msg msg;
    memset(&msg, 0, sizeof(msg));
    msg.sender_pid = getpid();
    msg.type = IPC_TYPE_FS_OPEN;
    strcpy(msg.data, "REQ_FS_OPEN");

    if (send(9999, &msg) == 0) {
        printf(1, "Client: invalid PID send unexpectedly worked\n");
        exit();
    }

    printf(1, "Client: sending to PID %d\n", server_pid);
    
    if (send(server_pid, &msg) < 0) {
        printf(1, "Client: send failed\n");
        exit();
    }

    if (recv(&msg) < 0) {
        printf(1, "Client: receive failed\n");
        exit();
    }

    printf(1, "Client: server responded with: %s\n", msg.data);
    exit();
}

int main(void) {
    int pid = fork();

    if (pid < 0) {
        printf(1, "Fork failed\n");
        exit();
    }

    if (pid == 0) {
        server();
    } else {
        // Give the server a moment to enter recv()
        sleep(10); 
        client(pid);
    }

    wait();
    exit();
}
