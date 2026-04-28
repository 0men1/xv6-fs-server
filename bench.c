#include "types.h"
#include "user.h"
#include "fcntl.h"

static inline uint64 rdtsc(void) {
  uint32 lo, hi;
  asm volatile("rdtsc" : "=a" (lo), "=d" (hi));
  return ((uint64)hi << 32) | lo;
}

void test1_time_create(void)
{
  uint64 start, end;
  start = rdtsc();
  int fd = open("bench_a.txt", O_CREATE|O_RDWR);
  end = rdtsc();
  
  if (fd >= 0) {
    printf(1, "======Create/Open: %d cycles======\n", (int)(end - start));
    close(fd);
  } else {
    printf(1, "Create/Open: FAIL\n");
  }
}

void test2_time_write(void)
{
  int fd = open("bench_b.txt", O_CREATE|O_RDWR);
  if (fd < 0) return;

  uint64 start, end;
  start = rdtsc();
  int n = write(fd, "microkernel_bench", 17);
  end = rdtsc();
  
  if (n == 17) {
    printf(1, "======Write (17 bytes): %d cycles======\n", (int)(end - start));
  } else {
    printf(1, "Write: FAIL\n");
  }
  close(fd);
}

void test3_time_read(void)
{
  int fd = open("bench_b.txt", O_RDONLY);
  if (fd < 0) return;

  char buf[32];
  uint64 start, end;
  
  start = rdtsc();
  int n = read(fd, buf, 17);
  end = rdtsc();
  
  if (n > 0) {
    printf(1, "======Read (17 bytes): %d cycles======\n", (int)(end - start));
  } else {
    printf(1, "Read: FAIL\n");
  }
  close(fd);
}

void test4_time_close(void)
{
  int fd = open("bench_c.txt", O_CREATE|O_RDWR);
  if (fd < 0) return;

  uint64 start, end;
  start = rdtsc();
  close(fd);
  end = rdtsc();
  
  printf(1, "======Close: %d cycles======\n", (int)(end - start));
}

void test5_time_invalid_access(void)
{
  int fd = open("bench_d.txt", O_CREATE|O_RDONLY);
  if (fd < 0) return;

  uint64 start, end;
  start = rdtsc();
  int n = write(fd, "x", 1);
  end = rdtsc();
  
  if (n < 0) {
    printf(1, "======Write block (O_RDONLY): %d cycles======\n", (int)(end - start));
  } else {
    printf(1, "Write block: FAIL\n");
  }
  close(fd);
}

int main(void)
{
  printf(1, "In-Memory FS IPC Benchmark (Cycles)\n");
  test1_time_create();
  test2_time_write();
  test3_time_read();
  test4_time_close();
  test5_time_invalid_access();
  exit();
}
