#include "types.h"
#include "x86.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "fs.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "buf.h"


int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return proc->pid;
}

addr_t
sys_sbrk(void)
{
  addr_t addr;
  addr_t n;

  argaddr(0, &n);
  addr = proc->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(proc->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

int
sys_send(void)
{
	int pid;
	char* msg;

	if (argint(0, &pid) < 0 || argptr(1, &msg, sizeof(struct ipc_msg)) < 0) 
		return -1;

	return send(pid, msg);
}

int
sys_recv(void)
{
	char *msg;
	if (argptr(0, &msg, sizeof(struct ipc_msg)) < 0) 
		return -1;

	return recv(msg);
}

int
sys_register_fsserver(void)
{
	return register_fsserver();
}

int
sys_disk_request(void)
{
  uint sector;
  char *buf;
  int operation;
  int fsserver_pid = get_fsserver_pid();

  if(argint(0, (int*)&sector) < 0 || argptr(1, &buf, BSIZE) < 0 || argint(2, &operation) < 0)
    return -1;

  if(fsserver_pid <= 0 || proc->pid != fsserver_pid){
    cprintf("kernel: unauthorized disk request from pid %d\n", proc->pid);
    proc->killed = 1;
    return -1;
  }

  if(operation == 0){
    struct buf *bp = bread(ROOTDEV, sector);
    if(bp == 0)
      return -1;
    memmove(buf, bp->data, BSIZE);
    brelse(bp);
    return 0;
  } else if(operation == 1){
    struct buf *bp = bread(ROOTDEV, sector);
    if(bp == 0)
      return -1;
    memmove(bp->data, buf, BSIZE);
    bwrite(bp);
    brelse(bp);
    return 0;
  }
  return -1;
}
