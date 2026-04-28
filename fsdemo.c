#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "fcntl.h"

char buf[512];
char buf2[512];

void
demo_write_read(void)
{
  int fd, n;
  char *testfile = "fsserver_demo.txt";
  char *testdata = "Hello from fsserver demo!\nThis file was created via the filesystem server.\n";

  printf(1, "\n=== Demo: Write and Read ===\n");

  // Create and write to a file
  fd = open(testfile, O_CREATE | O_WRONLY);
  if(fd < 0) {
    printf(1, "demo: failed to create %s\n", testfile);
    return;
  }
  printf(1, "Created file: %s (fd=%d)\n", testfile, fd);

  n = write(fd, testdata, strlen(testdata));
  printf(1, "Wrote %d bytes to file\n", n);
  close(fd);

  // Read the file back
  fd = open(testfile, O_RDONLY);
  if(fd < 0) {
    printf(1, "demo: failed to open %s for reading\n", testfile);
    return;
  }
  printf(1, "Opened file for reading (fd=%d)\n", fd);

  n = read(fd, buf, sizeof(buf));
  if(n > 0) {
    buf[n] = 0;
    printf(1, "Read %d bytes:\n---\n%s---\n", n, buf);
  }
  close(fd);
}

void
demo_readdir(void)
{
  int fd, n;
  char *testfile = "fsserver_demo.txt";

  printf(1, "\n=== Demo: Read Directory Entries ===\n");

  fd = open(".", O_RDONLY);
  if(fd < 0) {
    printf(1, "demo: cannot open current directory\n");
    return;
  }

  printf(1, "Directory entries in current directory:\n");
  while((n = read(fd, buf, sizeof(buf))) > 0) {
    char *bp = buf;
    int count = 0;
    while(bp < buf + n) {
      struct dirent *de = (struct dirent*)bp;
      if(de->inum == 0)
        break;
      printf(1, "  inode=%d, name=%s\n", de->inum, de->name);
      count++;
      bp += sizeof(struct dirent);
    }
    if(count == 0)
      break;
  }
  close(fd);
}

int
main(void)
{
  printf(1, "====================================\n");
  printf(1, "Filesystem Server Demo\n");
  printf(1, "====================================\n");
  printf(1, "This demo showcases the fsserver capabilities.\n");
  printf(1, "All file operations go through the fsserver\n");
  printf(1, "using IPC (Inter-Process Communication).\n");

  demo_write_read();
  demo_readdir();

  printf(1, "\n====================================\n");
  printf(1, "Demo completed successfully!\n");
  printf(1, "====================================\n");

  exit();
}
