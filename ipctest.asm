
_ipctest:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <server>:
#include "types.h"
#include "stat.h"
#include "user.h"
#include "ipc.h"

void server() {
    1000:	55                   	push   %rbp
    1001:	48 89 e5             	mov    %rsp,%rbp
    1004:	48 83 ec 50          	sub    $0x50,%rsp
    struct ipc_msg msg;
    printf(1, "Server: waiting for message...\n");
    1008:	48 b8 28 20 00 00 00 	movabs $0x2028,%rax
    100f:	00 00 00 
    1012:	48 89 c6             	mov    %rax,%rsi
    1015:	bf 01 00 00 00       	mov    $0x1,%edi
    101a:	b8 00 00 00 00       	mov    $0x0,%eax
    101f:	48 ba 04 19 00 00 00 	movabs $0x1904,%rdx
    1026:	00 00 00 
    1029:	ff d2                	call   *%rdx
    
    if (recv(&msg) < 0) {
    102b:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
    102f:	48 89 c7             	mov    %rax,%rdi
    1032:	48 b8 21 17 00 00 00 	movabs $0x1721,%rax
    1039:	00 00 00 
    103c:	ff d0                	call   *%rax
    103e:	85 c0                	test   %eax,%eax
    1040:	79 2f                	jns    1071 <server+0x71>
        printf(1, "Server: receive failed\n");
    1042:	48 b8 48 20 00 00 00 	movabs $0x2048,%rax
    1049:	00 00 00 
    104c:	48 89 c6             	mov    %rax,%rsi
    104f:	bf 01 00 00 00       	mov    $0x1,%edi
    1054:	b8 00 00 00 00       	mov    $0x0,%eax
    1059:	48 ba 04 19 00 00 00 	movabs $0x1904,%rdx
    1060:	00 00 00 
    1063:	ff d2                	call   *%rdx
        exit();
    1065:	48 b8 10 16 00 00 00 	movabs $0x1610,%rax
    106c:	00 00 00 
    106f:	ff d0                	call   *%rax
    }

    printf(1, "Server: received from PID %d: %s\n", msg.sender_pid, msg.data);
    1071:	8b 45 b0             	mov    -0x50(%rbp),%eax
    1074:	48 8d 55 b0          	lea    -0x50(%rbp),%rdx
    1078:	48 83 c2 0c          	add    $0xc,%rdx
    107c:	48 be 60 20 00 00 00 	movabs $0x2060,%rsi
    1083:	00 00 00 
    1086:	48 89 d1             	mov    %rdx,%rcx
    1089:	89 c2                	mov    %eax,%edx
    108b:	bf 01 00 00 00       	mov    $0x1,%edi
    1090:	b8 00 00 00 00       	mov    $0x0,%eax
    1095:	49 b8 04 19 00 00 00 	movabs $0x1904,%r8
    109c:	00 00 00 
    109f:	41 ff d0             	call   *%r8
    
    // Respond to client
    int client_pid = msg.sender_pid;
    10a2:	8b 45 b0             	mov    -0x50(%rbp),%eax
    10a5:	89 45 fc             	mov    %eax,-0x4(%rbp)
    msg.sender_pid = getpid();
    10a8:	48 b8 e0 16 00 00 00 	movabs $0x16e0,%rax
    10af:	00 00 00 
    10b2:	ff d0                	call   *%rax
    10b4:	89 45 b0             	mov    %eax,-0x50(%rbp)
    strcpy(msg.data, "ACK");
    10b7:	48 ba 82 20 00 00 00 	movabs $0x2082,%rdx
    10be:	00 00 00 
    10c1:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
    10c5:	48 83 c0 0c          	add    $0xc,%rax
    10c9:	48 89 d6             	mov    %rdx,%rsi
    10cc:	48 89 c7             	mov    %rax,%rdi
    10cf:	48 b8 2b 13 00 00 00 	movabs $0x132b,%rax
    10d6:	00 00 00 
    10d9:	ff d0                	call   *%rax
    
    if (send(client_pid, &msg) < 0) {
    10db:	48 8d 55 b0          	lea    -0x50(%rbp),%rdx
    10df:	8b 45 fc             	mov    -0x4(%rbp),%eax
    10e2:	48 89 d6             	mov    %rdx,%rsi
    10e5:	89 c7                	mov    %eax,%edi
    10e7:	48 b8 14 17 00 00 00 	movabs $0x1714,%rax
    10ee:	00 00 00 
    10f1:	ff d0                	call   *%rax
    10f3:	85 c0                	test   %eax,%eax
    10f5:	79 23                	jns    111a <server+0x11a>
        printf(1, "Server: send failed\n");
    10f7:	48 b8 86 20 00 00 00 	movabs $0x2086,%rax
    10fe:	00 00 00 
    1101:	48 89 c6             	mov    %rax,%rsi
    1104:	bf 01 00 00 00       	mov    $0x1,%edi
    1109:	b8 00 00 00 00       	mov    $0x0,%eax
    110e:	48 ba 04 19 00 00 00 	movabs $0x1904,%rdx
    1115:	00 00 00 
    1118:	ff d2                	call   *%rdx
    }
    exit();
    111a:	48 b8 10 16 00 00 00 	movabs $0x1610,%rax
    1121:	00 00 00 
    1124:	ff d0                	call   *%rax

0000000000001126 <client>:
}

void client(int server_pid) {
    1126:	55                   	push   %rbp
    1127:	48 89 e5             	mov    %rsp,%rbp
    112a:	48 83 ec 60          	sub    $0x60,%rsp
    112e:	89 7d ac             	mov    %edi,-0x54(%rbp)
    struct ipc_msg msg;
    msg.sender_pid = getpid();
    1131:	48 b8 e0 16 00 00 00 	movabs $0x16e0,%rax
    1138:	00 00 00 
    113b:	ff d0                	call   *%rax
    113d:	89 45 b0             	mov    %eax,-0x50(%rbp)
    msg.type = 1;
    1140:	c7 45 b4 01 00 00 00 	movl   $0x1,-0x4c(%rbp)
    strcpy(msg.data, "REQ_FS_OPEN");
    1147:	48 ba 9b 20 00 00 00 	movabs $0x209b,%rdx
    114e:	00 00 00 
    1151:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
    1155:	48 83 c0 0c          	add    $0xc,%rax
    1159:	48 89 d6             	mov    %rdx,%rsi
    115c:	48 89 c7             	mov    %rax,%rdi
    115f:	48 b8 2b 13 00 00 00 	movabs $0x132b,%rax
    1166:	00 00 00 
    1169:	ff d0                	call   *%rax

    printf(1, "Client: sending to PID %d\n", server_pid);
    116b:	8b 45 ac             	mov    -0x54(%rbp),%eax
    116e:	48 b9 a7 20 00 00 00 	movabs $0x20a7,%rcx
    1175:	00 00 00 
    1178:	89 c2                	mov    %eax,%edx
    117a:	48 89 ce             	mov    %rcx,%rsi
    117d:	bf 01 00 00 00       	mov    $0x1,%edi
    1182:	b8 00 00 00 00       	mov    $0x0,%eax
    1187:	48 b9 04 19 00 00 00 	movabs $0x1904,%rcx
    118e:	00 00 00 
    1191:	ff d1                	call   *%rcx
    
    if (send(server_pid, &msg) < 0) {
    1193:	48 8d 55 b0          	lea    -0x50(%rbp),%rdx
    1197:	8b 45 ac             	mov    -0x54(%rbp),%eax
    119a:	48 89 d6             	mov    %rdx,%rsi
    119d:	89 c7                	mov    %eax,%edi
    119f:	48 b8 14 17 00 00 00 	movabs $0x1714,%rax
    11a6:	00 00 00 
    11a9:	ff d0                	call   *%rax
    11ab:	85 c0                	test   %eax,%eax
    11ad:	79 2f                	jns    11de <client+0xb8>
        printf(1, "Client: send failed\n");
    11af:	48 b8 c2 20 00 00 00 	movabs $0x20c2,%rax
    11b6:	00 00 00 
    11b9:	48 89 c6             	mov    %rax,%rsi
    11bc:	bf 01 00 00 00       	mov    $0x1,%edi
    11c1:	b8 00 00 00 00       	mov    $0x0,%eax
    11c6:	48 ba 04 19 00 00 00 	movabs $0x1904,%rdx
    11cd:	00 00 00 
    11d0:	ff d2                	call   *%rdx
        exit();
    11d2:	48 b8 10 16 00 00 00 	movabs $0x1610,%rax
    11d9:	00 00 00 
    11dc:	ff d0                	call   *%rax
    }

    if (recv(&msg) < 0) {
    11de:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
    11e2:	48 89 c7             	mov    %rax,%rdi
    11e5:	48 b8 21 17 00 00 00 	movabs $0x1721,%rax
    11ec:	00 00 00 
    11ef:	ff d0                	call   *%rax
    11f1:	85 c0                	test   %eax,%eax
    11f3:	79 2f                	jns    1224 <client+0xfe>
        printf(1, "Client: receive failed\n");
    11f5:	48 b8 d7 20 00 00 00 	movabs $0x20d7,%rax
    11fc:	00 00 00 
    11ff:	48 89 c6             	mov    %rax,%rsi
    1202:	bf 01 00 00 00       	mov    $0x1,%edi
    1207:	b8 00 00 00 00       	mov    $0x0,%eax
    120c:	48 ba 04 19 00 00 00 	movabs $0x1904,%rdx
    1213:	00 00 00 
    1216:	ff d2                	call   *%rdx
        exit();
    1218:	48 b8 10 16 00 00 00 	movabs $0x1610,%rax
    121f:	00 00 00 
    1222:	ff d0                	call   *%rax
    }

    printf(1, "Client: server responded with: %s\n", msg.data);
    1224:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
    1228:	48 8d 50 0c          	lea    0xc(%rax),%rdx
    122c:	48 b8 f0 20 00 00 00 	movabs $0x20f0,%rax
    1233:	00 00 00 
    1236:	48 89 c6             	mov    %rax,%rsi
    1239:	bf 01 00 00 00       	mov    $0x1,%edi
    123e:	b8 00 00 00 00       	mov    $0x0,%eax
    1243:	48 b9 04 19 00 00 00 	movabs $0x1904,%rcx
    124a:	00 00 00 
    124d:	ff d1                	call   *%rcx
    exit();
    124f:	48 b8 10 16 00 00 00 	movabs $0x1610,%rax
    1256:	00 00 00 
    1259:	ff d0                	call   *%rax

000000000000125b <main>:
}

int main(void) {
    125b:	55                   	push   %rbp
    125c:	48 89 e5             	mov    %rsp,%rbp
    125f:	48 83 ec 10          	sub    $0x10,%rsp
    int pid = fork();
    1263:	48 b8 03 16 00 00 00 	movabs $0x1603,%rax
    126a:	00 00 00 
    126d:	ff d0                	call   *%rax
    126f:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (pid < 0) {
    1272:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1276:	79 2f                	jns    12a7 <main+0x4c>
        printf(1, "Fork failed\n");
    1278:	48 b8 13 21 00 00 00 	movabs $0x2113,%rax
    127f:	00 00 00 
    1282:	48 89 c6             	mov    %rax,%rsi
    1285:	bf 01 00 00 00       	mov    $0x1,%edi
    128a:	b8 00 00 00 00       	mov    $0x0,%eax
    128f:	48 ba 04 19 00 00 00 	movabs $0x1904,%rdx
    1296:	00 00 00 
    1299:	ff d2                	call   *%rdx
        exit();
    129b:	48 b8 10 16 00 00 00 	movabs $0x1610,%rax
    12a2:	00 00 00 
    12a5:	ff d0                	call   *%rax
    }

    if (pid == 0) {
    12a7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    12ab:	75 0e                	jne    12bb <main+0x60>
        server();
    12ad:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    12b4:	00 00 00 
    12b7:	ff d0                	call   *%rax
    12b9:	eb 22                	jmp    12dd <main+0x82>
    } else {
        // Give the server a moment to enter recv()
        sleep(10); 
    12bb:	bf 0a 00 00 00       	mov    $0xa,%edi
    12c0:	48 b8 fa 16 00 00 00 	movabs $0x16fa,%rax
    12c7:	00 00 00 
    12ca:	ff d0                	call   *%rax
        client(pid);
    12cc:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12cf:	89 c7                	mov    %eax,%edi
    12d1:	48 b8 26 11 00 00 00 	movabs $0x1126,%rax
    12d8:	00 00 00 
    12db:	ff d0                	call   *%rax
    }

    wait();
    12dd:	48 b8 1d 16 00 00 00 	movabs $0x161d,%rax
    12e4:	00 00 00 
    12e7:	ff d0                	call   *%rax
    exit();
    12e9:	48 b8 10 16 00 00 00 	movabs $0x1610,%rax
    12f0:	00 00 00 
    12f3:	ff d0                	call   *%rax

00000000000012f5 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    12f5:	55                   	push   %rbp
    12f6:	48 89 e5             	mov    %rsp,%rbp
    12f9:	48 83 ec 10          	sub    $0x10,%rsp
    12fd:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1301:	89 75 f4             	mov    %esi,-0xc(%rbp)
    1304:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
    1307:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    130b:	8b 55 f0             	mov    -0x10(%rbp),%edx
    130e:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1311:	48 89 ce             	mov    %rcx,%rsi
    1314:	48 89 f7             	mov    %rsi,%rdi
    1317:	89 d1                	mov    %edx,%ecx
    1319:	fc                   	cld
    131a:	f3 aa                	rep stos %al,(%rdi)
    131c:	89 ca                	mov    %ecx,%edx
    131e:	48 89 fe             	mov    %rdi,%rsi
    1321:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    1325:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1328:	90                   	nop
    1329:	c9                   	leave
    132a:	c3                   	ret

000000000000132b <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    132b:	55                   	push   %rbp
    132c:	48 89 e5             	mov    %rsp,%rbp
    132f:	48 83 ec 20          	sub    $0x20,%rsp
    1333:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1337:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
    133b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    133f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    1343:	90                   	nop
    1344:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1348:	48 8d 42 01          	lea    0x1(%rdx),%rax
    134c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    1350:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1354:	48 8d 48 01          	lea    0x1(%rax),%rcx
    1358:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    135c:	0f b6 12             	movzbl (%rdx),%edx
    135f:	88 10                	mov    %dl,(%rax)
    1361:	0f b6 00             	movzbl (%rax),%eax
    1364:	84 c0                	test   %al,%al
    1366:	75 dc                	jne    1344 <strcpy+0x19>
    ;
  return os;
    1368:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    136c:	c9                   	leave
    136d:	c3                   	ret

000000000000136e <strcmp>:

int
strcmp(const char *p, const char *q)
{
    136e:	55                   	push   %rbp
    136f:	48 89 e5             	mov    %rsp,%rbp
    1372:	48 83 ec 10          	sub    $0x10,%rsp
    1376:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    137a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    137e:	eb 0a                	jmp    138a <strcmp+0x1c>
    p++, q++;
    1380:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1385:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    138a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    138e:	0f b6 00             	movzbl (%rax),%eax
    1391:	84 c0                	test   %al,%al
    1393:	74 12                	je     13a7 <strcmp+0x39>
    1395:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1399:	0f b6 10             	movzbl (%rax),%edx
    139c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    13a0:	0f b6 00             	movzbl (%rax),%eax
    13a3:	38 c2                	cmp    %al,%dl
    13a5:	74 d9                	je     1380 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
    13a7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13ab:	0f b6 00             	movzbl (%rax),%eax
    13ae:	0f b6 d0             	movzbl %al,%edx
    13b1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    13b5:	0f b6 00             	movzbl (%rax),%eax
    13b8:	0f b6 c0             	movzbl %al,%eax
    13bb:	29 c2                	sub    %eax,%edx
    13bd:	89 d0                	mov    %edx,%eax
}
    13bf:	c9                   	leave
    13c0:	c3                   	ret

00000000000013c1 <strlen>:

uint
strlen(char *s)
{
    13c1:	55                   	push   %rbp
    13c2:	48 89 e5             	mov    %rsp,%rbp
    13c5:	48 83 ec 18          	sub    $0x18,%rsp
    13c9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
    13cd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    13d4:	eb 04                	jmp    13da <strlen+0x19>
    13d6:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    13da:	8b 45 fc             	mov    -0x4(%rbp),%eax
    13dd:	48 63 d0             	movslq %eax,%rdx
    13e0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    13e4:	48 01 d0             	add    %rdx,%rax
    13e7:	0f b6 00             	movzbl (%rax),%eax
    13ea:	84 c0                	test   %al,%al
    13ec:	75 e8                	jne    13d6 <strlen+0x15>
    ;
  return n;
    13ee:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    13f1:	c9                   	leave
    13f2:	c3                   	ret

00000000000013f3 <memset>:

void*
memset(void *dst, int c, uint n)
{
    13f3:	55                   	push   %rbp
    13f4:	48 89 e5             	mov    %rsp,%rbp
    13f7:	48 83 ec 10          	sub    $0x10,%rsp
    13fb:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    13ff:	89 75 f4             	mov    %esi,-0xc(%rbp)
    1402:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    1405:	8b 55 f0             	mov    -0x10(%rbp),%edx
    1408:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    140b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    140f:	89 ce                	mov    %ecx,%esi
    1411:	48 89 c7             	mov    %rax,%rdi
    1414:	48 b8 f5 12 00 00 00 	movabs $0x12f5,%rax
    141b:	00 00 00 
    141e:	ff d0                	call   *%rax
  return dst;
    1420:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    1424:	c9                   	leave
    1425:	c3                   	ret

0000000000001426 <strchr>:

char*
strchr(const char *s, char c)
{
    1426:	55                   	push   %rbp
    1427:	48 89 e5             	mov    %rsp,%rbp
    142a:	48 83 ec 10          	sub    $0x10,%rsp
    142e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1432:	89 f0                	mov    %esi,%eax
    1434:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    1437:	eb 17                	jmp    1450 <strchr+0x2a>
    if(*s == c)
    1439:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    143d:	0f b6 00             	movzbl (%rax),%eax
    1440:	38 45 f4             	cmp    %al,-0xc(%rbp)
    1443:	75 06                	jne    144b <strchr+0x25>
      return (char*)s;
    1445:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1449:	eb 15                	jmp    1460 <strchr+0x3a>
  for(; *s; s++)
    144b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1450:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1454:	0f b6 00             	movzbl (%rax),%eax
    1457:	84 c0                	test   %al,%al
    1459:	75 de                	jne    1439 <strchr+0x13>
  return 0;
    145b:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1460:	c9                   	leave
    1461:	c3                   	ret

0000000000001462 <gets>:

char*
gets(char *buf, int max)
{
    1462:	55                   	push   %rbp
    1463:	48 89 e5             	mov    %rsp,%rbp
    1466:	48 83 ec 20          	sub    $0x20,%rsp
    146a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    146e:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1471:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1478:	eb 4f                	jmp    14c9 <gets+0x67>
    cc = read(0, &c, 1);
    147a:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    147e:	ba 01 00 00 00       	mov    $0x1,%edx
    1483:	48 89 c6             	mov    %rax,%rsi
    1486:	bf 00 00 00 00       	mov    $0x0,%edi
    148b:	48 b8 37 16 00 00 00 	movabs $0x1637,%rax
    1492:	00 00 00 
    1495:	ff d0                	call   *%rax
    1497:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    149a:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    149e:	7e 36                	jle    14d6 <gets+0x74>
      break;
    buf[i++] = c;
    14a0:	8b 45 fc             	mov    -0x4(%rbp),%eax
    14a3:	8d 50 01             	lea    0x1(%rax),%edx
    14a6:	89 55 fc             	mov    %edx,-0x4(%rbp)
    14a9:	48 63 d0             	movslq %eax,%rdx
    14ac:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    14b0:	48 01 c2             	add    %rax,%rdx
    14b3:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    14b7:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    14b9:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    14bd:	3c 0a                	cmp    $0xa,%al
    14bf:	74 16                	je     14d7 <gets+0x75>
    14c1:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    14c5:	3c 0d                	cmp    $0xd,%al
    14c7:	74 0e                	je     14d7 <gets+0x75>
  for(i=0; i+1 < max; ){
    14c9:	8b 45 fc             	mov    -0x4(%rbp),%eax
    14cc:	83 c0 01             	add    $0x1,%eax
    14cf:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    14d2:	7f a6                	jg     147a <gets+0x18>
    14d4:	eb 01                	jmp    14d7 <gets+0x75>
      break;
    14d6:	90                   	nop
      break;
  }
  buf[i] = '\0';
    14d7:	8b 45 fc             	mov    -0x4(%rbp),%eax
    14da:	48 63 d0             	movslq %eax,%rdx
    14dd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    14e1:	48 01 d0             	add    %rdx,%rax
    14e4:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    14e7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    14eb:	c9                   	leave
    14ec:	c3                   	ret

00000000000014ed <stat>:

int
stat(char *n, struct stat *st)
{
    14ed:	55                   	push   %rbp
    14ee:	48 89 e5             	mov    %rsp,%rbp
    14f1:	48 83 ec 20          	sub    $0x20,%rsp
    14f5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    14f9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    14fd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1501:	be 00 00 00 00       	mov    $0x0,%esi
    1506:	48 89 c7             	mov    %rax,%rdi
    1509:	48 b8 78 16 00 00 00 	movabs $0x1678,%rax
    1510:	00 00 00 
    1513:	ff d0                	call   *%rax
    1515:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    1518:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    151c:	79 07                	jns    1525 <stat+0x38>
    return -1;
    151e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1523:	eb 2f                	jmp    1554 <stat+0x67>
  r = fstat(fd, st);
    1525:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1529:	8b 45 fc             	mov    -0x4(%rbp),%eax
    152c:	48 89 d6             	mov    %rdx,%rsi
    152f:	89 c7                	mov    %eax,%edi
    1531:	48 b8 9f 16 00 00 00 	movabs $0x169f,%rax
    1538:	00 00 00 
    153b:	ff d0                	call   *%rax
    153d:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    1540:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1543:	89 c7                	mov    %eax,%edi
    1545:	48 b8 51 16 00 00 00 	movabs $0x1651,%rax
    154c:	00 00 00 
    154f:	ff d0                	call   *%rax
  return r;
    1551:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    1554:	c9                   	leave
    1555:	c3                   	ret

0000000000001556 <atoi>:

int
atoi(const char *s)
{
    1556:	55                   	push   %rbp
    1557:	48 89 e5             	mov    %rsp,%rbp
    155a:	48 83 ec 18          	sub    $0x18,%rsp
    155e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    1562:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1569:	eb 28                	jmp    1593 <atoi+0x3d>
    n = n*10 + *s++ - '0';
    156b:	8b 55 fc             	mov    -0x4(%rbp),%edx
    156e:	89 d0                	mov    %edx,%eax
    1570:	c1 e0 02             	shl    $0x2,%eax
    1573:	01 d0                	add    %edx,%eax
    1575:	01 c0                	add    %eax,%eax
    1577:	89 c1                	mov    %eax,%ecx
    1579:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    157d:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1581:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    1585:	0f b6 00             	movzbl (%rax),%eax
    1588:	0f be c0             	movsbl %al,%eax
    158b:	01 c8                	add    %ecx,%eax
    158d:	83 e8 30             	sub    $0x30,%eax
    1590:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1593:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1597:	0f b6 00             	movzbl (%rax),%eax
    159a:	3c 2f                	cmp    $0x2f,%al
    159c:	7e 0b                	jle    15a9 <atoi+0x53>
    159e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    15a2:	0f b6 00             	movzbl (%rax),%eax
    15a5:	3c 39                	cmp    $0x39,%al
    15a7:	7e c2                	jle    156b <atoi+0x15>
  return n;
    15a9:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    15ac:	c9                   	leave
    15ad:	c3                   	ret

00000000000015ae <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    15ae:	55                   	push   %rbp
    15af:	48 89 e5             	mov    %rsp,%rbp
    15b2:	48 83 ec 28          	sub    $0x28,%rsp
    15b6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    15ba:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    15be:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    15c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    15c5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    15c9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    15cd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    15d1:	eb 1d                	jmp    15f0 <memmove+0x42>
    *dst++ = *src++;
    15d3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    15d7:	48 8d 42 01          	lea    0x1(%rdx),%rax
    15db:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    15df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    15e3:	48 8d 48 01          	lea    0x1(%rax),%rcx
    15e7:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    15eb:	0f b6 12             	movzbl (%rdx),%edx
    15ee:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    15f0:	8b 45 dc             	mov    -0x24(%rbp),%eax
    15f3:	8d 50 ff             	lea    -0x1(%rax),%edx
    15f6:	89 55 dc             	mov    %edx,-0x24(%rbp)
    15f9:	85 c0                	test   %eax,%eax
    15fb:	7f d6                	jg     15d3 <memmove+0x25>
  return vdst;
    15fd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    1601:	c9                   	leave
    1602:	c3                   	ret

0000000000001603 <fork>:
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    1603:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    160a:	49 89 ca             	mov    %rcx,%r10
    160d:	0f 05                	syscall
    160f:	c3                   	ret

0000000000001610 <exit>:
SYSCALL(exit)
    1610:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    1617:	49 89 ca             	mov    %rcx,%r10
    161a:	0f 05                	syscall
    161c:	c3                   	ret

000000000000161d <wait>:
SYSCALL(wait)
    161d:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    1624:	49 89 ca             	mov    %rcx,%r10
    1627:	0f 05                	syscall
    1629:	c3                   	ret

000000000000162a <pipe>:
SYSCALL(pipe)
    162a:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    1631:	49 89 ca             	mov    %rcx,%r10
    1634:	0f 05                	syscall
    1636:	c3                   	ret

0000000000001637 <read>:
SYSCALL(read)
    1637:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    163e:	49 89 ca             	mov    %rcx,%r10
    1641:	0f 05                	syscall
    1643:	c3                   	ret

0000000000001644 <write>:
SYSCALL(write)
    1644:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    164b:	49 89 ca             	mov    %rcx,%r10
    164e:	0f 05                	syscall
    1650:	c3                   	ret

0000000000001651 <close>:
SYSCALL(close)
    1651:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    1658:	49 89 ca             	mov    %rcx,%r10
    165b:	0f 05                	syscall
    165d:	c3                   	ret

000000000000165e <kill>:
SYSCALL(kill)
    165e:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    1665:	49 89 ca             	mov    %rcx,%r10
    1668:	0f 05                	syscall
    166a:	c3                   	ret

000000000000166b <exec>:
SYSCALL(exec)
    166b:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    1672:	49 89 ca             	mov    %rcx,%r10
    1675:	0f 05                	syscall
    1677:	c3                   	ret

0000000000001678 <open>:
SYSCALL(open)
    1678:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    167f:	49 89 ca             	mov    %rcx,%r10
    1682:	0f 05                	syscall
    1684:	c3                   	ret

0000000000001685 <mknod>:
SYSCALL(mknod)
    1685:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    168c:	49 89 ca             	mov    %rcx,%r10
    168f:	0f 05                	syscall
    1691:	c3                   	ret

0000000000001692 <unlink>:
SYSCALL(unlink)
    1692:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    1699:	49 89 ca             	mov    %rcx,%r10
    169c:	0f 05                	syscall
    169e:	c3                   	ret

000000000000169f <fstat>:
SYSCALL(fstat)
    169f:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    16a6:	49 89 ca             	mov    %rcx,%r10
    16a9:	0f 05                	syscall
    16ab:	c3                   	ret

00000000000016ac <link>:
SYSCALL(link)
    16ac:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    16b3:	49 89 ca             	mov    %rcx,%r10
    16b6:	0f 05                	syscall
    16b8:	c3                   	ret

00000000000016b9 <mkdir>:
SYSCALL(mkdir)
    16b9:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    16c0:	49 89 ca             	mov    %rcx,%r10
    16c3:	0f 05                	syscall
    16c5:	c3                   	ret

00000000000016c6 <chdir>:
SYSCALL(chdir)
    16c6:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    16cd:	49 89 ca             	mov    %rcx,%r10
    16d0:	0f 05                	syscall
    16d2:	c3                   	ret

00000000000016d3 <dup>:
SYSCALL(dup)
    16d3:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    16da:	49 89 ca             	mov    %rcx,%r10
    16dd:	0f 05                	syscall
    16df:	c3                   	ret

00000000000016e0 <getpid>:
SYSCALL(getpid)
    16e0:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    16e7:	49 89 ca             	mov    %rcx,%r10
    16ea:	0f 05                	syscall
    16ec:	c3                   	ret

00000000000016ed <sbrk>:
SYSCALL(sbrk)
    16ed:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    16f4:	49 89 ca             	mov    %rcx,%r10
    16f7:	0f 05                	syscall
    16f9:	c3                   	ret

00000000000016fa <sleep>:
SYSCALL(sleep)
    16fa:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    1701:	49 89 ca             	mov    %rcx,%r10
    1704:	0f 05                	syscall
    1706:	c3                   	ret

0000000000001707 <uptime>:
SYSCALL(uptime)
    1707:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    170e:	49 89 ca             	mov    %rcx,%r10
    1711:	0f 05                	syscall
    1713:	c3                   	ret

0000000000001714 <send>:
SYSCALL(send)
    1714:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    171b:	49 89 ca             	mov    %rcx,%r10
    171e:	0f 05                	syscall
    1720:	c3                   	ret

0000000000001721 <recv>:
SYSCALL(recv)
    1721:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    1728:	49 89 ca             	mov    %rcx,%r10
    172b:	0f 05                	syscall
    172d:	c3                   	ret

000000000000172e <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    172e:	55                   	push   %rbp
    172f:	48 89 e5             	mov    %rsp,%rbp
    1732:	48 83 ec 10          	sub    $0x10,%rsp
    1736:	89 7d fc             	mov    %edi,-0x4(%rbp)
    1739:	89 f0                	mov    %esi,%eax
    173b:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    173e:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    1742:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1745:	ba 01 00 00 00       	mov    $0x1,%edx
    174a:	48 89 ce             	mov    %rcx,%rsi
    174d:	89 c7                	mov    %eax,%edi
    174f:	48 b8 44 16 00 00 00 	movabs $0x1644,%rax
    1756:	00 00 00 
    1759:	ff d0                	call   *%rax
}
    175b:	90                   	nop
    175c:	c9                   	leave
    175d:	c3                   	ret

000000000000175e <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    175e:	55                   	push   %rbp
    175f:	48 89 e5             	mov    %rsp,%rbp
    1762:	48 83 ec 20          	sub    $0x20,%rsp
    1766:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1769:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    176d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1774:	eb 35                	jmp    17ab <print_x64+0x4d>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    1776:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    177a:	48 c1 e8 3c          	shr    $0x3c,%rax
    177e:	48 ba 30 21 00 00 00 	movabs $0x2130,%rdx
    1785:	00 00 00 
    1788:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    178c:	0f be d0             	movsbl %al,%edx
    178f:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1792:	89 d6                	mov    %edx,%esi
    1794:	89 c7                	mov    %eax,%edi
    1796:	48 b8 2e 17 00 00 00 	movabs $0x172e,%rax
    179d:	00 00 00 
    17a0:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    17a2:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    17a6:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    17ab:	8b 45 fc             	mov    -0x4(%rbp),%eax
    17ae:	83 f8 0f             	cmp    $0xf,%eax
    17b1:	76 c3                	jbe    1776 <print_x64+0x18>
}
    17b3:	90                   	nop
    17b4:	90                   	nop
    17b5:	c9                   	leave
    17b6:	c3                   	ret

00000000000017b7 <print_x32>:

  static void
print_x32(int fd, uint x)
{
    17b7:	55                   	push   %rbp
    17b8:	48 89 e5             	mov    %rsp,%rbp
    17bb:	48 83 ec 20          	sub    $0x20,%rsp
    17bf:	89 7d ec             	mov    %edi,-0x14(%rbp)
    17c2:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    17c5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    17cc:	eb 36                	jmp    1804 <print_x32+0x4d>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    17ce:	8b 45 e8             	mov    -0x18(%rbp),%eax
    17d1:	c1 e8 1c             	shr    $0x1c,%eax
    17d4:	89 c2                	mov    %eax,%edx
    17d6:	48 b8 30 21 00 00 00 	movabs $0x2130,%rax
    17dd:	00 00 00 
    17e0:	89 d2                	mov    %edx,%edx
    17e2:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    17e6:	0f be d0             	movsbl %al,%edx
    17e9:	8b 45 ec             	mov    -0x14(%rbp),%eax
    17ec:	89 d6                	mov    %edx,%esi
    17ee:	89 c7                	mov    %eax,%edi
    17f0:	48 b8 2e 17 00 00 00 	movabs $0x172e,%rax
    17f7:	00 00 00 
    17fa:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    17fc:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1800:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    1804:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1807:	83 f8 07             	cmp    $0x7,%eax
    180a:	76 c2                	jbe    17ce <print_x32+0x17>
}
    180c:	90                   	nop
    180d:	90                   	nop
    180e:	c9                   	leave
    180f:	c3                   	ret

0000000000001810 <print_d>:

  static void
print_d(int fd, int v)
{
    1810:	55                   	push   %rbp
    1811:	48 89 e5             	mov    %rsp,%rbp
    1814:	48 83 ec 30          	sub    $0x30,%rsp
    1818:	89 7d dc             	mov    %edi,-0x24(%rbp)
    181b:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    181e:	8b 45 d8             	mov    -0x28(%rbp),%eax
    1821:	48 98                	cltq
    1823:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    1827:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    182b:	79 04                	jns    1831 <print_d+0x21>
    x = -x;
    182d:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    1831:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    1838:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    183c:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1843:	66 66 66 
    1846:	48 89 c8             	mov    %rcx,%rax
    1849:	48 f7 ea             	imul   %rdx
    184c:	48 c1 fa 02          	sar    $0x2,%rdx
    1850:	48 89 c8             	mov    %rcx,%rax
    1853:	48 c1 f8 3f          	sar    $0x3f,%rax
    1857:	48 29 c2             	sub    %rax,%rdx
    185a:	48 89 d0             	mov    %rdx,%rax
    185d:	48 c1 e0 02          	shl    $0x2,%rax
    1861:	48 01 d0             	add    %rdx,%rax
    1864:	48 01 c0             	add    %rax,%rax
    1867:	48 29 c1             	sub    %rax,%rcx
    186a:	48 89 ca             	mov    %rcx,%rdx
    186d:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1870:	8d 48 01             	lea    0x1(%rax),%ecx
    1873:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    1876:	48 b9 30 21 00 00 00 	movabs $0x2130,%rcx
    187d:	00 00 00 
    1880:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    1884:	48 98                	cltq
    1886:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    188a:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    188e:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1895:	66 66 66 
    1898:	48 89 c8             	mov    %rcx,%rax
    189b:	48 f7 ea             	imul   %rdx
    189e:	48 89 d0             	mov    %rdx,%rax
    18a1:	48 c1 f8 02          	sar    $0x2,%rax
    18a5:	48 c1 f9 3f          	sar    $0x3f,%rcx
    18a9:	48 89 ca             	mov    %rcx,%rdx
    18ac:	48 29 d0             	sub    %rdx,%rax
    18af:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    18b3:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    18b8:	0f 85 7a ff ff ff    	jne    1838 <print_d+0x28>

  if (v < 0)
    18be:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    18c2:	79 32                	jns    18f6 <print_d+0xe6>
    buf[i++] = '-';
    18c4:	8b 45 f4             	mov    -0xc(%rbp),%eax
    18c7:	8d 50 01             	lea    0x1(%rax),%edx
    18ca:	89 55 f4             	mov    %edx,-0xc(%rbp)
    18cd:	48 98                	cltq
    18cf:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    18d4:	eb 20                	jmp    18f6 <print_d+0xe6>
    putc(fd, buf[i]);
    18d6:	8b 45 f4             	mov    -0xc(%rbp),%eax
    18d9:	48 98                	cltq
    18db:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    18e0:	0f be d0             	movsbl %al,%edx
    18e3:	8b 45 dc             	mov    -0x24(%rbp),%eax
    18e6:	89 d6                	mov    %edx,%esi
    18e8:	89 c7                	mov    %eax,%edi
    18ea:	48 b8 2e 17 00 00 00 	movabs $0x172e,%rax
    18f1:	00 00 00 
    18f4:	ff d0                	call   *%rax
  while (--i >= 0)
    18f6:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    18fa:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    18fe:	79 d6                	jns    18d6 <print_d+0xc6>
}
    1900:	90                   	nop
    1901:	90                   	nop
    1902:	c9                   	leave
    1903:	c3                   	ret

0000000000001904 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    1904:	55                   	push   %rbp
    1905:	48 89 e5             	mov    %rsp,%rbp
    1908:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    190f:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    1915:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    191c:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    1923:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    192a:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    1931:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    1938:	84 c0                	test   %al,%al
    193a:	74 20                	je     195c <printf+0x58>
    193c:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    1940:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    1944:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    1948:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    194c:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    1950:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    1954:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    1958:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    195c:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    1963:	00 00 00 
    1966:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    196d:	00 00 00 
    1970:	48 8d 45 10          	lea    0x10(%rbp),%rax
    1974:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    197b:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    1982:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1989:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    1990:	00 00 00 
    1993:	e9 60 03 00 00       	jmp    1cf8 <printf+0x3f4>
    if (c != '%') {
    1998:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    199f:	74 24                	je     19c5 <printf+0xc1>
      putc(fd, c);
    19a1:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    19a7:	0f be d0             	movsbl %al,%edx
    19aa:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    19b0:	89 d6                	mov    %edx,%esi
    19b2:	89 c7                	mov    %eax,%edi
    19b4:	48 b8 2e 17 00 00 00 	movabs $0x172e,%rax
    19bb:	00 00 00 
    19be:	ff d0                	call   *%rax
      continue;
    19c0:	e9 2c 03 00 00       	jmp    1cf1 <printf+0x3ed>
    }
    c = fmt[++i] & 0xff;
    19c5:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    19cc:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    19d2:	48 63 d0             	movslq %eax,%rdx
    19d5:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    19dc:	48 01 d0             	add    %rdx,%rax
    19df:	0f b6 00             	movzbl (%rax),%eax
    19e2:	0f be c0             	movsbl %al,%eax
    19e5:	25 ff 00 00 00       	and    $0xff,%eax
    19ea:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    19f0:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    19f7:	0f 84 2e 03 00 00    	je     1d2b <printf+0x427>
      break;
    switch(c) {
    19fd:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    1a04:	0f 84 32 01 00 00    	je     1b3c <printf+0x238>
    1a0a:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    1a11:	0f 8f a1 02 00 00    	jg     1cb8 <printf+0x3b4>
    1a17:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    1a1e:	0f 84 d4 01 00 00    	je     1bf8 <printf+0x2f4>
    1a24:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    1a2b:	0f 8f 87 02 00 00    	jg     1cb8 <printf+0x3b4>
    1a31:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    1a38:	0f 84 5b 01 00 00    	je     1b99 <printf+0x295>
    1a3e:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    1a45:	0f 8f 6d 02 00 00    	jg     1cb8 <printf+0x3b4>
    1a4b:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    1a52:	0f 84 87 00 00 00    	je     1adf <printf+0x1db>
    1a58:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    1a5f:	0f 8f 53 02 00 00    	jg     1cb8 <printf+0x3b4>
    1a65:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1a6c:	0f 84 2b 02 00 00    	je     1c9d <printf+0x399>
    1a72:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    1a79:	0f 85 39 02 00 00    	jne    1cb8 <printf+0x3b4>
    case 'c':
      putc(fd, va_arg(ap, int));
    1a7f:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1a85:	83 f8 2f             	cmp    $0x2f,%eax
    1a88:	77 23                	ja     1aad <printf+0x1a9>
    1a8a:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1a91:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a97:	89 d2                	mov    %edx,%edx
    1a99:	48 01 d0             	add    %rdx,%rax
    1a9c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1aa2:	83 c2 08             	add    $0x8,%edx
    1aa5:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1aab:	eb 12                	jmp    1abf <printf+0x1bb>
    1aad:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1ab4:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1ab8:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1abf:	8b 00                	mov    (%rax),%eax
    1ac1:	0f be d0             	movsbl %al,%edx
    1ac4:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1aca:	89 d6                	mov    %edx,%esi
    1acc:	89 c7                	mov    %eax,%edi
    1ace:	48 b8 2e 17 00 00 00 	movabs $0x172e,%rax
    1ad5:	00 00 00 
    1ad8:	ff d0                	call   *%rax
      break;
    1ada:	e9 12 02 00 00       	jmp    1cf1 <printf+0x3ed>
    case 'd':
      print_d(fd, va_arg(ap, int));
    1adf:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1ae5:	83 f8 2f             	cmp    $0x2f,%eax
    1ae8:	77 23                	ja     1b0d <printf+0x209>
    1aea:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1af1:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1af7:	89 d2                	mov    %edx,%edx
    1af9:	48 01 d0             	add    %rdx,%rax
    1afc:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b02:	83 c2 08             	add    $0x8,%edx
    1b05:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1b0b:	eb 12                	jmp    1b1f <printf+0x21b>
    1b0d:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1b14:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1b18:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1b1f:	8b 10                	mov    (%rax),%edx
    1b21:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b27:	89 d6                	mov    %edx,%esi
    1b29:	89 c7                	mov    %eax,%edi
    1b2b:	48 b8 10 18 00 00 00 	movabs $0x1810,%rax
    1b32:	00 00 00 
    1b35:	ff d0                	call   *%rax
      break;
    1b37:	e9 b5 01 00 00       	jmp    1cf1 <printf+0x3ed>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    1b3c:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1b42:	83 f8 2f             	cmp    $0x2f,%eax
    1b45:	77 23                	ja     1b6a <printf+0x266>
    1b47:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1b4e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b54:	89 d2                	mov    %edx,%edx
    1b56:	48 01 d0             	add    %rdx,%rax
    1b59:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b5f:	83 c2 08             	add    $0x8,%edx
    1b62:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1b68:	eb 12                	jmp    1b7c <printf+0x278>
    1b6a:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1b71:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1b75:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1b7c:	8b 10                	mov    (%rax),%edx
    1b7e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b84:	89 d6                	mov    %edx,%esi
    1b86:	89 c7                	mov    %eax,%edi
    1b88:	48 b8 b7 17 00 00 00 	movabs $0x17b7,%rax
    1b8f:	00 00 00 
    1b92:	ff d0                	call   *%rax
      break;
    1b94:	e9 58 01 00 00       	jmp    1cf1 <printf+0x3ed>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    1b99:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1b9f:	83 f8 2f             	cmp    $0x2f,%eax
    1ba2:	77 23                	ja     1bc7 <printf+0x2c3>
    1ba4:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1bab:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1bb1:	89 d2                	mov    %edx,%edx
    1bb3:	48 01 d0             	add    %rdx,%rax
    1bb6:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1bbc:	83 c2 08             	add    $0x8,%edx
    1bbf:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1bc5:	eb 12                	jmp    1bd9 <printf+0x2d5>
    1bc7:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1bce:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1bd2:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1bd9:	48 8b 10             	mov    (%rax),%rdx
    1bdc:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1be2:	48 89 d6             	mov    %rdx,%rsi
    1be5:	89 c7                	mov    %eax,%edi
    1be7:	48 b8 5e 17 00 00 00 	movabs $0x175e,%rax
    1bee:	00 00 00 
    1bf1:	ff d0                	call   *%rax
      break;
    1bf3:	e9 f9 00 00 00       	jmp    1cf1 <printf+0x3ed>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    1bf8:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1bfe:	83 f8 2f             	cmp    $0x2f,%eax
    1c01:	77 23                	ja     1c26 <printf+0x322>
    1c03:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1c0a:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1c10:	89 d2                	mov    %edx,%edx
    1c12:	48 01 d0             	add    %rdx,%rax
    1c15:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1c1b:	83 c2 08             	add    $0x8,%edx
    1c1e:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1c24:	eb 12                	jmp    1c38 <printf+0x334>
    1c26:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1c2d:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1c31:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1c38:	48 8b 00             	mov    (%rax),%rax
    1c3b:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    1c42:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1c49:	00 
    1c4a:	75 41                	jne    1c8d <printf+0x389>
        s = "(null)";
    1c4c:	48 b8 20 21 00 00 00 	movabs $0x2120,%rax
    1c53:	00 00 00 
    1c56:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1c5d:	eb 2e                	jmp    1c8d <printf+0x389>
        putc(fd, *(s++));
    1c5f:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1c66:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1c6a:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1c71:	0f b6 00             	movzbl (%rax),%eax
    1c74:	0f be d0             	movsbl %al,%edx
    1c77:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1c7d:	89 d6                	mov    %edx,%esi
    1c7f:	89 c7                	mov    %eax,%edi
    1c81:	48 b8 2e 17 00 00 00 	movabs $0x172e,%rax
    1c88:	00 00 00 
    1c8b:	ff d0                	call   *%rax
      while (*s)
    1c8d:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1c94:	0f b6 00             	movzbl (%rax),%eax
    1c97:	84 c0                	test   %al,%al
    1c99:	75 c4                	jne    1c5f <printf+0x35b>
      break;
    1c9b:	eb 54                	jmp    1cf1 <printf+0x3ed>
    case '%':
      putc(fd, '%');
    1c9d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1ca3:	be 25 00 00 00       	mov    $0x25,%esi
    1ca8:	89 c7                	mov    %eax,%edi
    1caa:	48 b8 2e 17 00 00 00 	movabs $0x172e,%rax
    1cb1:	00 00 00 
    1cb4:	ff d0                	call   *%rax
      break;
    1cb6:	eb 39                	jmp    1cf1 <printf+0x3ed>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1cb8:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1cbe:	be 25 00 00 00       	mov    $0x25,%esi
    1cc3:	89 c7                	mov    %eax,%edi
    1cc5:	48 b8 2e 17 00 00 00 	movabs $0x172e,%rax
    1ccc:	00 00 00 
    1ccf:	ff d0                	call   *%rax
      putc(fd, c);
    1cd1:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1cd7:	0f be d0             	movsbl %al,%edx
    1cda:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1ce0:	89 d6                	mov    %edx,%esi
    1ce2:	89 c7                	mov    %eax,%edi
    1ce4:	48 b8 2e 17 00 00 00 	movabs $0x172e,%rax
    1ceb:	00 00 00 
    1cee:	ff d0                	call   *%rax
      break;
    1cf0:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1cf1:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1cf8:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1cfe:	48 63 d0             	movslq %eax,%rdx
    1d01:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1d08:	48 01 d0             	add    %rdx,%rax
    1d0b:	0f b6 00             	movzbl (%rax),%eax
    1d0e:	0f be c0             	movsbl %al,%eax
    1d11:	25 ff 00 00 00       	and    $0xff,%eax
    1d16:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1d1c:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1d23:	0f 85 6f fc ff ff    	jne    1998 <printf+0x94>
    }
  }
}
    1d29:	eb 01                	jmp    1d2c <printf+0x428>
      break;
    1d2b:	90                   	nop
}
    1d2c:	90                   	nop
    1d2d:	c9                   	leave
    1d2e:	c3                   	ret

0000000000001d2f <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1d2f:	55                   	push   %rbp
    1d30:	48 89 e5             	mov    %rsp,%rbp
    1d33:	48 83 ec 18          	sub    $0x18,%rsp
    1d37:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1d3b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1d3f:	48 83 e8 10          	sub    $0x10,%rax
    1d43:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1d47:	48 b8 60 21 00 00 00 	movabs $0x2160,%rax
    1d4e:	00 00 00 
    1d51:	48 8b 00             	mov    (%rax),%rax
    1d54:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1d58:	eb 2f                	jmp    1d89 <free+0x5a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1d5a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d5e:	48 8b 00             	mov    (%rax),%rax
    1d61:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1d65:	72 17                	jb     1d7e <free+0x4f>
    1d67:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d6b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1d6f:	72 2f                	jb     1da0 <free+0x71>
    1d71:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d75:	48 8b 00             	mov    (%rax),%rax
    1d78:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1d7c:	72 22                	jb     1da0 <free+0x71>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1d7e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d82:	48 8b 00             	mov    (%rax),%rax
    1d85:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1d89:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d8d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1d91:	73 c7                	jae    1d5a <free+0x2b>
    1d93:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d97:	48 8b 00             	mov    (%rax),%rax
    1d9a:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1d9e:	73 ba                	jae    1d5a <free+0x2b>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1da0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1da4:	8b 40 08             	mov    0x8(%rax),%eax
    1da7:	89 c0                	mov    %eax,%eax
    1da9:	48 c1 e0 04          	shl    $0x4,%rax
    1dad:	48 89 c2             	mov    %rax,%rdx
    1db0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1db4:	48 01 c2             	add    %rax,%rdx
    1db7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1dbb:	48 8b 00             	mov    (%rax),%rax
    1dbe:	48 39 c2             	cmp    %rax,%rdx
    1dc1:	75 2d                	jne    1df0 <free+0xc1>
    bp->s.size += p->s.ptr->s.size;
    1dc3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1dc7:	8b 50 08             	mov    0x8(%rax),%edx
    1dca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1dce:	48 8b 00             	mov    (%rax),%rax
    1dd1:	8b 40 08             	mov    0x8(%rax),%eax
    1dd4:	01 c2                	add    %eax,%edx
    1dd6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1dda:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1ddd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1de1:	48 8b 00             	mov    (%rax),%rax
    1de4:	48 8b 10             	mov    (%rax),%rdx
    1de7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1deb:	48 89 10             	mov    %rdx,(%rax)
    1dee:	eb 0e                	jmp    1dfe <free+0xcf>
  } else
    bp->s.ptr = p->s.ptr;
    1df0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1df4:	48 8b 10             	mov    (%rax),%rdx
    1df7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1dfb:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    1dfe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e02:	8b 40 08             	mov    0x8(%rax),%eax
    1e05:	89 c0                	mov    %eax,%eax
    1e07:	48 c1 e0 04          	shl    $0x4,%rax
    1e0b:	48 89 c2             	mov    %rax,%rdx
    1e0e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e12:	48 01 d0             	add    %rdx,%rax
    1e15:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1e19:	75 27                	jne    1e42 <free+0x113>
    p->s.size += bp->s.size;
    1e1b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e1f:	8b 50 08             	mov    0x8(%rax),%edx
    1e22:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e26:	8b 40 08             	mov    0x8(%rax),%eax
    1e29:	01 c2                	add    %eax,%edx
    1e2b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e2f:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    1e32:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e36:	48 8b 10             	mov    (%rax),%rdx
    1e39:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e3d:	48 89 10             	mov    %rdx,(%rax)
    1e40:	eb 0b                	jmp    1e4d <free+0x11e>
  } else
    p->s.ptr = bp;
    1e42:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e46:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1e4a:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    1e4d:	48 ba 60 21 00 00 00 	movabs $0x2160,%rdx
    1e54:	00 00 00 
    1e57:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e5b:	48 89 02             	mov    %rax,(%rdx)
}
    1e5e:	90                   	nop
    1e5f:	c9                   	leave
    1e60:	c3                   	ret

0000000000001e61 <morecore>:

static Header*
morecore(uint nu)
{
    1e61:	55                   	push   %rbp
    1e62:	48 89 e5             	mov    %rsp,%rbp
    1e65:	48 83 ec 20          	sub    $0x20,%rsp
    1e69:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    1e6c:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1e73:	77 07                	ja     1e7c <morecore+0x1b>
    nu = 4096;
    1e75:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    1e7c:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1e7f:	48 c1 e0 04          	shl    $0x4,%rax
    1e83:	48 89 c7             	mov    %rax,%rdi
    1e86:	48 b8 ed 16 00 00 00 	movabs $0x16ed,%rax
    1e8d:	00 00 00 
    1e90:	ff d0                	call   *%rax
    1e92:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    1e96:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1e9b:	75 07                	jne    1ea4 <morecore+0x43>
    return 0;
    1e9d:	b8 00 00 00 00       	mov    $0x0,%eax
    1ea2:	eb 36                	jmp    1eda <morecore+0x79>
  hp = (Header*)p;
    1ea4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ea8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    1eac:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1eb0:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1eb3:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    1eb6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1eba:	48 83 c0 10          	add    $0x10,%rax
    1ebe:	48 89 c7             	mov    %rax,%rdi
    1ec1:	48 b8 2f 1d 00 00 00 	movabs $0x1d2f,%rax
    1ec8:	00 00 00 
    1ecb:	ff d0                	call   *%rax
  return freep;
    1ecd:	48 b8 60 21 00 00 00 	movabs $0x2160,%rax
    1ed4:	00 00 00 
    1ed7:	48 8b 00             	mov    (%rax),%rax
}
    1eda:	c9                   	leave
    1edb:	c3                   	ret

0000000000001edc <malloc>:

void*
malloc(uint nbytes)
{
    1edc:	55                   	push   %rbp
    1edd:	48 89 e5             	mov    %rsp,%rbp
    1ee0:	48 83 ec 30          	sub    $0x30,%rsp
    1ee4:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1ee7:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1eea:	48 83 c0 0f          	add    $0xf,%rax
    1eee:	48 c1 e8 04          	shr    $0x4,%rax
    1ef2:	83 c0 01             	add    $0x1,%eax
    1ef5:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    1ef8:	48 b8 60 21 00 00 00 	movabs $0x2160,%rax
    1eff:	00 00 00 
    1f02:	48 8b 00             	mov    (%rax),%rax
    1f05:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1f09:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1f0e:	75 4a                	jne    1f5a <malloc+0x7e>
    base.s.ptr = freep = prevp = &base;
    1f10:	48 b8 50 21 00 00 00 	movabs $0x2150,%rax
    1f17:	00 00 00 
    1f1a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1f1e:	48 ba 60 21 00 00 00 	movabs $0x2160,%rdx
    1f25:	00 00 00 
    1f28:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f2c:	48 89 02             	mov    %rax,(%rdx)
    1f2f:	48 b8 60 21 00 00 00 	movabs $0x2160,%rax
    1f36:	00 00 00 
    1f39:	48 8b 00             	mov    (%rax),%rax
    1f3c:	48 ba 50 21 00 00 00 	movabs $0x2150,%rdx
    1f43:	00 00 00 
    1f46:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    1f49:	48 b8 50 21 00 00 00 	movabs $0x2150,%rax
    1f50:	00 00 00 
    1f53:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1f5a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f5e:	48 8b 00             	mov    (%rax),%rax
    1f61:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1f65:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f69:	8b 40 08             	mov    0x8(%rax),%eax
    1f6c:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1f6f:	72 65                	jb     1fd6 <malloc+0xfa>
      if(p->s.size == nunits)
    1f71:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f75:	8b 40 08             	mov    0x8(%rax),%eax
    1f78:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1f7b:	75 10                	jne    1f8d <malloc+0xb1>
        prevp->s.ptr = p->s.ptr;
    1f7d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f81:	48 8b 10             	mov    (%rax),%rdx
    1f84:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f88:	48 89 10             	mov    %rdx,(%rax)
    1f8b:	eb 2e                	jmp    1fbb <malloc+0xdf>
      else {
        p->s.size -= nunits;
    1f8d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f91:	8b 40 08             	mov    0x8(%rax),%eax
    1f94:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1f97:	89 c2                	mov    %eax,%edx
    1f99:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f9d:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    1fa0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1fa4:	8b 40 08             	mov    0x8(%rax),%eax
    1fa7:	89 c0                	mov    %eax,%eax
    1fa9:	48 c1 e0 04          	shl    $0x4,%rax
    1fad:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    1fb1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1fb5:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1fb8:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    1fbb:	48 ba 60 21 00 00 00 	movabs $0x2160,%rdx
    1fc2:	00 00 00 
    1fc5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1fc9:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    1fcc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1fd0:	48 83 c0 10          	add    $0x10,%rax
    1fd4:	eb 4e                	jmp    2024 <malloc+0x148>
    }
    if(p == freep)
    1fd6:	48 b8 60 21 00 00 00 	movabs $0x2160,%rax
    1fdd:	00 00 00 
    1fe0:	48 8b 00             	mov    (%rax),%rax
    1fe3:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1fe7:	75 23                	jne    200c <malloc+0x130>
      if((p = morecore(nunits)) == 0)
    1fe9:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1fec:	89 c7                	mov    %eax,%edi
    1fee:	48 b8 61 1e 00 00 00 	movabs $0x1e61,%rax
    1ff5:	00 00 00 
    1ff8:	ff d0                	call   *%rax
    1ffa:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1ffe:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    2003:	75 07                	jne    200c <malloc+0x130>
        return 0;
    2005:	b8 00 00 00 00       	mov    $0x0,%eax
    200a:	eb 18                	jmp    2024 <malloc+0x148>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    200c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2010:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    2014:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2018:	48 8b 00             	mov    (%rax),%rax
    201b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    201f:	e9 41 ff ff ff       	jmp    1f65 <malloc+0x89>
  }
}
    2024:	c9                   	leave
    2025:	c3                   	ret
