#define IPC_MSG_SIZE 64

struct ipc_msg{
	int sender_pid;
	int type;
	int fd;
	char data[IPC_MSG_SIZE];
};
