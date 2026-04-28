#include "types.h"
#include "user.h"
#include "fcntl.h"

void test1(void)
{
  int fd = open("a.txt", O_CREATE|O_RDWR);
  if (fd >= 0) {
    printf(1, "test1: PASS\n");
    close(fd);
  } else {
    printf(1, "test1: FAIL\n");
  }
}

void test2(void)
{
  int fd = open("a.txt", O_RDONLY);
  if (fd >= 0) {
    printf(1, "test2: PASS\n");
    close(fd);
  } else {
    printf(1, "test2: FAIL\n");
  }
}

void test3(void)
{
  int fd = open("b.txt", O_CREATE|O_RDWR);
  int n = write(fd, "hi", 2);
  printf(1, "test3: wrote %d\n", n);
  close(fd);
  if (n == 2)
    printf(1, "test3: PASS\n");
  else
    printf(1, "test3: FAIL\n");
}

void test4(void)
{
  int fd = open("b.txt", O_RDONLY);
  char buf[16];
  int n = read(fd, buf, 16);
  printf(1, "test4: read %d\n", n);
  close(fd);
  if (n > 0)
    printf(1, "test4: PASS\n");
  else
    printf(1, "test4: FAIL\n");
}

void test5(void)
{
  int fd = open("c.txt", O_CREATE|O_RDONLY);
  if (fd < 0) {
    printf(1, "test5: FAIL (open)\n");
    return;
  }
  int n = write(fd, "x", 1);
  close(fd);
  if (n < 0)
    printf(1, "test5: PASS (write blocked)\n");
  else
    printf(1, "test5: FAIL (write allowed)\n");
}

void test6(void)
{
  int fd = open("d.txt", O_CREATE|O_WRONLY);
  if (fd < 0) {
    printf(1, "test6: FAIL (open)\n");
    return;
  }
  char buf[16];
  int n = read(fd, buf, 16);
  close(fd);
  if (n < 0)
    printf(1, "test6: PASS (read blocked)\n");
  else
    printf(1, "test6: FAIL (read allowed)\n");
}

void test7(void)
{
  // Test write then read in same test
  int fd = open("e.txt", O_CREATE|O_RDWR);
  if (fd < 0) {
    printf(1, "test7: FAIL (open)\n");
    return;
  }
  int n = write(fd, "hello", 5);
  if (n != 5) {
    printf(1, "test7: FAIL (write)\n");
    close(fd);
    return;
  }
  // Reopen for reading
  close(fd);
  fd = open("e.txt", O_RDONLY);
  if (fd < 0) {
    printf(1, "test7: FAIL (reopen)\n");
    return;
  }
  char buf[16];
  n = read(fd, buf, 16);
  printf(1, "test7: read %d bytes\n", n);
  close(fd);
  if (n == 5)
    printf(1, "test7: PASS\n");
  else
    printf(1, "test7: FAIL\n");
}

int main(void)
{
  test1();
  test2();
  test3();
  test4();
  test5();
  test6();
  test7();
  exit();
}
