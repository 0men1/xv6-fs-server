
_zombie:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
    1000:	55                   	push   %rbp
    1001:	48 89 e5             	mov    %rsp,%rbp
  if(fork() > 0)
    1004:	48 b8 3f 13 00 00 00 	movabs $0x133f,%rax
    100b:	00 00 00 
    100e:	ff d0                	call   *%rax
    1010:	85 c0                	test   %eax,%eax
    1012:	7e 11                	jle    1025 <main+0x25>
    sleep(5);  // Let child exit before parent.
    1014:	bf 05 00 00 00       	mov    $0x5,%edi
    1019:	48 b8 36 14 00 00 00 	movabs $0x1436,%rax
    1020:	00 00 00 
    1023:	ff d0                	call   *%rax
  exit();
    1025:	48 b8 4c 13 00 00 00 	movabs $0x134c,%rax
    102c:	00 00 00 
    102f:	ff d0                	call   *%rax

0000000000001031 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1031:	55                   	push   %rbp
    1032:	48 89 e5             	mov    %rsp,%rbp
    1035:	48 83 ec 10          	sub    $0x10,%rsp
    1039:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    103d:	89 75 f4             	mov    %esi,-0xc(%rbp)
    1040:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
    1043:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1047:	8b 55 f0             	mov    -0x10(%rbp),%edx
    104a:	8b 45 f4             	mov    -0xc(%rbp),%eax
    104d:	48 89 ce             	mov    %rcx,%rsi
    1050:	48 89 f7             	mov    %rsi,%rdi
    1053:	89 d1                	mov    %edx,%ecx
    1055:	fc                   	cld
    1056:	f3 aa                	rep stos %al,(%rdi)
    1058:	89 ca                	mov    %ecx,%edx
    105a:	48 89 fe             	mov    %rdi,%rsi
    105d:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    1061:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1064:	90                   	nop
    1065:	c9                   	leave
    1066:	c3                   	ret

0000000000001067 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1067:	55                   	push   %rbp
    1068:	48 89 e5             	mov    %rsp,%rbp
    106b:	48 83 ec 20          	sub    $0x20,%rsp
    106f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1073:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
    1077:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    107b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    107f:	90                   	nop
    1080:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1084:	48 8d 42 01          	lea    0x1(%rdx),%rax
    1088:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    108c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1090:	48 8d 48 01          	lea    0x1(%rax),%rcx
    1094:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    1098:	0f b6 12             	movzbl (%rdx),%edx
    109b:	88 10                	mov    %dl,(%rax)
    109d:	0f b6 00             	movzbl (%rax),%eax
    10a0:	84 c0                	test   %al,%al
    10a2:	75 dc                	jne    1080 <strcpy+0x19>
    ;
  return os;
    10a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    10a8:	c9                   	leave
    10a9:	c3                   	ret

00000000000010aa <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10aa:	55                   	push   %rbp
    10ab:	48 89 e5             	mov    %rsp,%rbp
    10ae:	48 83 ec 10          	sub    $0x10,%rsp
    10b2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    10b6:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    10ba:	eb 0a                	jmp    10c6 <strcmp+0x1c>
    p++, q++;
    10bc:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    10c1:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    10c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    10ca:	0f b6 00             	movzbl (%rax),%eax
    10cd:	84 c0                	test   %al,%al
    10cf:	74 12                	je     10e3 <strcmp+0x39>
    10d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    10d5:	0f b6 10             	movzbl (%rax),%edx
    10d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    10dc:	0f b6 00             	movzbl (%rax),%eax
    10df:	38 c2                	cmp    %al,%dl
    10e1:	74 d9                	je     10bc <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
    10e3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    10e7:	0f b6 00             	movzbl (%rax),%eax
    10ea:	0f b6 d0             	movzbl %al,%edx
    10ed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    10f1:	0f b6 00             	movzbl (%rax),%eax
    10f4:	0f b6 c0             	movzbl %al,%eax
    10f7:	29 c2                	sub    %eax,%edx
    10f9:	89 d0                	mov    %edx,%eax
}
    10fb:	c9                   	leave
    10fc:	c3                   	ret

00000000000010fd <strlen>:

uint
strlen(char *s)
{
    10fd:	55                   	push   %rbp
    10fe:	48 89 e5             	mov    %rsp,%rbp
    1101:	48 83 ec 18          	sub    $0x18,%rsp
    1105:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
    1109:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1110:	eb 04                	jmp    1116 <strlen+0x19>
    1112:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1116:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1119:	48 63 d0             	movslq %eax,%rdx
    111c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1120:	48 01 d0             	add    %rdx,%rax
    1123:	0f b6 00             	movzbl (%rax),%eax
    1126:	84 c0                	test   %al,%al
    1128:	75 e8                	jne    1112 <strlen+0x15>
    ;
  return n;
    112a:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    112d:	c9                   	leave
    112e:	c3                   	ret

000000000000112f <memset>:

void*
memset(void *dst, int c, uint n)
{
    112f:	55                   	push   %rbp
    1130:	48 89 e5             	mov    %rsp,%rbp
    1133:	48 83 ec 10          	sub    $0x10,%rsp
    1137:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    113b:	89 75 f4             	mov    %esi,-0xc(%rbp)
    113e:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    1141:	8b 55 f0             	mov    -0x10(%rbp),%edx
    1144:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    1147:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    114b:	89 ce                	mov    %ecx,%esi
    114d:	48 89 c7             	mov    %rax,%rdi
    1150:	48 b8 31 10 00 00 00 	movabs $0x1031,%rax
    1157:	00 00 00 
    115a:	ff d0                	call   *%rax
  return dst;
    115c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    1160:	c9                   	leave
    1161:	c3                   	ret

0000000000001162 <strchr>:

char*
strchr(const char *s, char c)
{
    1162:	55                   	push   %rbp
    1163:	48 89 e5             	mov    %rsp,%rbp
    1166:	48 83 ec 10          	sub    $0x10,%rsp
    116a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    116e:	89 f0                	mov    %esi,%eax
    1170:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    1173:	eb 17                	jmp    118c <strchr+0x2a>
    if(*s == c)
    1175:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1179:	0f b6 00             	movzbl (%rax),%eax
    117c:	38 45 f4             	cmp    %al,-0xc(%rbp)
    117f:	75 06                	jne    1187 <strchr+0x25>
      return (char*)s;
    1181:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1185:	eb 15                	jmp    119c <strchr+0x3a>
  for(; *s; s++)
    1187:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    118c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1190:	0f b6 00             	movzbl (%rax),%eax
    1193:	84 c0                	test   %al,%al
    1195:	75 de                	jne    1175 <strchr+0x13>
  return 0;
    1197:	b8 00 00 00 00       	mov    $0x0,%eax
}
    119c:	c9                   	leave
    119d:	c3                   	ret

000000000000119e <gets>:

char*
gets(char *buf, int max)
{
    119e:	55                   	push   %rbp
    119f:	48 89 e5             	mov    %rsp,%rbp
    11a2:	48 83 ec 20          	sub    $0x20,%rsp
    11a6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    11aa:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11ad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    11b4:	eb 4f                	jmp    1205 <gets+0x67>
    cc = read(0, &c, 1);
    11b6:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    11ba:	ba 01 00 00 00       	mov    $0x1,%edx
    11bf:	48 89 c6             	mov    %rax,%rsi
    11c2:	bf 00 00 00 00       	mov    $0x0,%edi
    11c7:	48 b8 73 13 00 00 00 	movabs $0x1373,%rax
    11ce:	00 00 00 
    11d1:	ff d0                	call   *%rax
    11d3:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    11d6:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    11da:	7e 36                	jle    1212 <gets+0x74>
      break;
    buf[i++] = c;
    11dc:	8b 45 fc             	mov    -0x4(%rbp),%eax
    11df:	8d 50 01             	lea    0x1(%rax),%edx
    11e2:	89 55 fc             	mov    %edx,-0x4(%rbp)
    11e5:	48 63 d0             	movslq %eax,%rdx
    11e8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    11ec:	48 01 c2             	add    %rax,%rdx
    11ef:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    11f3:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    11f5:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    11f9:	3c 0a                	cmp    $0xa,%al
    11fb:	74 16                	je     1213 <gets+0x75>
    11fd:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1201:	3c 0d                	cmp    $0xd,%al
    1203:	74 0e                	je     1213 <gets+0x75>
  for(i=0; i+1 < max; ){
    1205:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1208:	83 c0 01             	add    $0x1,%eax
    120b:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    120e:	7f a6                	jg     11b6 <gets+0x18>
    1210:	eb 01                	jmp    1213 <gets+0x75>
      break;
    1212:	90                   	nop
      break;
  }
  buf[i] = '\0';
    1213:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1216:	48 63 d0             	movslq %eax,%rdx
    1219:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    121d:	48 01 d0             	add    %rdx,%rax
    1220:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    1223:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    1227:	c9                   	leave
    1228:	c3                   	ret

0000000000001229 <stat>:

int
stat(char *n, struct stat *st)
{
    1229:	55                   	push   %rbp
    122a:	48 89 e5             	mov    %rsp,%rbp
    122d:	48 83 ec 20          	sub    $0x20,%rsp
    1231:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1235:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1239:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    123d:	be 00 00 00 00       	mov    $0x0,%esi
    1242:	48 89 c7             	mov    %rax,%rdi
    1245:	48 b8 b4 13 00 00 00 	movabs $0x13b4,%rax
    124c:	00 00 00 
    124f:	ff d0                	call   *%rax
    1251:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    1254:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1258:	79 07                	jns    1261 <stat+0x38>
    return -1;
    125a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    125f:	eb 2f                	jmp    1290 <stat+0x67>
  r = fstat(fd, st);
    1261:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1265:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1268:	48 89 d6             	mov    %rdx,%rsi
    126b:	89 c7                	mov    %eax,%edi
    126d:	48 b8 db 13 00 00 00 	movabs $0x13db,%rax
    1274:	00 00 00 
    1277:	ff d0                	call   *%rax
    1279:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    127c:	8b 45 fc             	mov    -0x4(%rbp),%eax
    127f:	89 c7                	mov    %eax,%edi
    1281:	48 b8 8d 13 00 00 00 	movabs $0x138d,%rax
    1288:	00 00 00 
    128b:	ff d0                	call   *%rax
  return r;
    128d:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    1290:	c9                   	leave
    1291:	c3                   	ret

0000000000001292 <atoi>:

int
atoi(const char *s)
{
    1292:	55                   	push   %rbp
    1293:	48 89 e5             	mov    %rsp,%rbp
    1296:	48 83 ec 18          	sub    $0x18,%rsp
    129a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    129e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    12a5:	eb 28                	jmp    12cf <atoi+0x3d>
    n = n*10 + *s++ - '0';
    12a7:	8b 55 fc             	mov    -0x4(%rbp),%edx
    12aa:	89 d0                	mov    %edx,%eax
    12ac:	c1 e0 02             	shl    $0x2,%eax
    12af:	01 d0                	add    %edx,%eax
    12b1:	01 c0                	add    %eax,%eax
    12b3:	89 c1                	mov    %eax,%ecx
    12b5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12b9:	48 8d 50 01          	lea    0x1(%rax),%rdx
    12bd:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    12c1:	0f b6 00             	movzbl (%rax),%eax
    12c4:	0f be c0             	movsbl %al,%eax
    12c7:	01 c8                	add    %ecx,%eax
    12c9:	83 e8 30             	sub    $0x30,%eax
    12cc:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    12cf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12d3:	0f b6 00             	movzbl (%rax),%eax
    12d6:	3c 2f                	cmp    $0x2f,%al
    12d8:	7e 0b                	jle    12e5 <atoi+0x53>
    12da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12de:	0f b6 00             	movzbl (%rax),%eax
    12e1:	3c 39                	cmp    $0x39,%al
    12e3:	7e c2                	jle    12a7 <atoi+0x15>
  return n;
    12e5:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    12e8:	c9                   	leave
    12e9:	c3                   	ret

00000000000012ea <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    12ea:	55                   	push   %rbp
    12eb:	48 89 e5             	mov    %rsp,%rbp
    12ee:	48 83 ec 28          	sub    $0x28,%rsp
    12f2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    12f6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    12fa:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    12fd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1301:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    1305:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1309:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    130d:	eb 1d                	jmp    132c <memmove+0x42>
    *dst++ = *src++;
    130f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1313:	48 8d 42 01          	lea    0x1(%rdx),%rax
    1317:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    131b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    131f:	48 8d 48 01          	lea    0x1(%rax),%rcx
    1323:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    1327:	0f b6 12             	movzbl (%rdx),%edx
    132a:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    132c:	8b 45 dc             	mov    -0x24(%rbp),%eax
    132f:	8d 50 ff             	lea    -0x1(%rax),%edx
    1332:	89 55 dc             	mov    %edx,-0x24(%rbp)
    1335:	85 c0                	test   %eax,%eax
    1337:	7f d6                	jg     130f <memmove+0x25>
  return vdst;
    1339:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    133d:	c9                   	leave
    133e:	c3                   	ret

000000000000133f <fork>:
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    133f:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    1346:	49 89 ca             	mov    %rcx,%r10
    1349:	0f 05                	syscall
    134b:	c3                   	ret

000000000000134c <exit>:
SYSCALL(exit)
    134c:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    1353:	49 89 ca             	mov    %rcx,%r10
    1356:	0f 05                	syscall
    1358:	c3                   	ret

0000000000001359 <wait>:
SYSCALL(wait)
    1359:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    1360:	49 89 ca             	mov    %rcx,%r10
    1363:	0f 05                	syscall
    1365:	c3                   	ret

0000000000001366 <pipe>:
SYSCALL(pipe)
    1366:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    136d:	49 89 ca             	mov    %rcx,%r10
    1370:	0f 05                	syscall
    1372:	c3                   	ret

0000000000001373 <read>:
SYSCALL(read)
    1373:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    137a:	49 89 ca             	mov    %rcx,%r10
    137d:	0f 05                	syscall
    137f:	c3                   	ret

0000000000001380 <write>:
SYSCALL(write)
    1380:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    1387:	49 89 ca             	mov    %rcx,%r10
    138a:	0f 05                	syscall
    138c:	c3                   	ret

000000000000138d <close>:
SYSCALL(close)
    138d:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    1394:	49 89 ca             	mov    %rcx,%r10
    1397:	0f 05                	syscall
    1399:	c3                   	ret

000000000000139a <kill>:
SYSCALL(kill)
    139a:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    13a1:	49 89 ca             	mov    %rcx,%r10
    13a4:	0f 05                	syscall
    13a6:	c3                   	ret

00000000000013a7 <exec>:
SYSCALL(exec)
    13a7:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    13ae:	49 89 ca             	mov    %rcx,%r10
    13b1:	0f 05                	syscall
    13b3:	c3                   	ret

00000000000013b4 <open>:
SYSCALL(open)
    13b4:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    13bb:	49 89 ca             	mov    %rcx,%r10
    13be:	0f 05                	syscall
    13c0:	c3                   	ret

00000000000013c1 <mknod>:
SYSCALL(mknod)
    13c1:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    13c8:	49 89 ca             	mov    %rcx,%r10
    13cb:	0f 05                	syscall
    13cd:	c3                   	ret

00000000000013ce <unlink>:
SYSCALL(unlink)
    13ce:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    13d5:	49 89 ca             	mov    %rcx,%r10
    13d8:	0f 05                	syscall
    13da:	c3                   	ret

00000000000013db <fstat>:
SYSCALL(fstat)
    13db:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    13e2:	49 89 ca             	mov    %rcx,%r10
    13e5:	0f 05                	syscall
    13e7:	c3                   	ret

00000000000013e8 <link>:
SYSCALL(link)
    13e8:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    13ef:	49 89 ca             	mov    %rcx,%r10
    13f2:	0f 05                	syscall
    13f4:	c3                   	ret

00000000000013f5 <mkdir>:
SYSCALL(mkdir)
    13f5:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    13fc:	49 89 ca             	mov    %rcx,%r10
    13ff:	0f 05                	syscall
    1401:	c3                   	ret

0000000000001402 <chdir>:
SYSCALL(chdir)
    1402:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    1409:	49 89 ca             	mov    %rcx,%r10
    140c:	0f 05                	syscall
    140e:	c3                   	ret

000000000000140f <dup>:
SYSCALL(dup)
    140f:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    1416:	49 89 ca             	mov    %rcx,%r10
    1419:	0f 05                	syscall
    141b:	c3                   	ret

000000000000141c <getpid>:
SYSCALL(getpid)
    141c:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    1423:	49 89 ca             	mov    %rcx,%r10
    1426:	0f 05                	syscall
    1428:	c3                   	ret

0000000000001429 <sbrk>:
SYSCALL(sbrk)
    1429:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    1430:	49 89 ca             	mov    %rcx,%r10
    1433:	0f 05                	syscall
    1435:	c3                   	ret

0000000000001436 <sleep>:
SYSCALL(sleep)
    1436:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    143d:	49 89 ca             	mov    %rcx,%r10
    1440:	0f 05                	syscall
    1442:	c3                   	ret

0000000000001443 <uptime>:
SYSCALL(uptime)
    1443:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    144a:	49 89 ca             	mov    %rcx,%r10
    144d:	0f 05                	syscall
    144f:	c3                   	ret

0000000000001450 <send>:
SYSCALL(send)
    1450:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    1457:	49 89 ca             	mov    %rcx,%r10
    145a:	0f 05                	syscall
    145c:	c3                   	ret

000000000000145d <recv>:
SYSCALL(recv)
    145d:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    1464:	49 89 ca             	mov    %rcx,%r10
    1467:	0f 05                	syscall
    1469:	c3                   	ret

000000000000146a <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    146a:	55                   	push   %rbp
    146b:	48 89 e5             	mov    %rsp,%rbp
    146e:	48 83 ec 10          	sub    $0x10,%rsp
    1472:	89 7d fc             	mov    %edi,-0x4(%rbp)
    1475:	89 f0                	mov    %esi,%eax
    1477:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    147a:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    147e:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1481:	ba 01 00 00 00       	mov    $0x1,%edx
    1486:	48 89 ce             	mov    %rcx,%rsi
    1489:	89 c7                	mov    %eax,%edi
    148b:	48 b8 80 13 00 00 00 	movabs $0x1380,%rax
    1492:	00 00 00 
    1495:	ff d0                	call   *%rax
}
    1497:	90                   	nop
    1498:	c9                   	leave
    1499:	c3                   	ret

000000000000149a <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    149a:	55                   	push   %rbp
    149b:	48 89 e5             	mov    %rsp,%rbp
    149e:	48 83 ec 20          	sub    $0x20,%rsp
    14a2:	89 7d ec             	mov    %edi,-0x14(%rbp)
    14a5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    14a9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    14b0:	eb 35                	jmp    14e7 <print_x64+0x4d>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    14b2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    14b6:	48 c1 e8 3c          	shr    $0x3c,%rax
    14ba:	48 ba 70 1d 00 00 00 	movabs $0x1d70,%rdx
    14c1:	00 00 00 
    14c4:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    14c8:	0f be d0             	movsbl %al,%edx
    14cb:	8b 45 ec             	mov    -0x14(%rbp),%eax
    14ce:	89 d6                	mov    %edx,%esi
    14d0:	89 c7                	mov    %eax,%edi
    14d2:	48 b8 6a 14 00 00 00 	movabs $0x146a,%rax
    14d9:	00 00 00 
    14dc:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    14de:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    14e2:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    14e7:	8b 45 fc             	mov    -0x4(%rbp),%eax
    14ea:	83 f8 0f             	cmp    $0xf,%eax
    14ed:	76 c3                	jbe    14b2 <print_x64+0x18>
}
    14ef:	90                   	nop
    14f0:	90                   	nop
    14f1:	c9                   	leave
    14f2:	c3                   	ret

00000000000014f3 <print_x32>:

  static void
print_x32(int fd, uint x)
{
    14f3:	55                   	push   %rbp
    14f4:	48 89 e5             	mov    %rsp,%rbp
    14f7:	48 83 ec 20          	sub    $0x20,%rsp
    14fb:	89 7d ec             	mov    %edi,-0x14(%rbp)
    14fe:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1501:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1508:	eb 36                	jmp    1540 <print_x32+0x4d>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    150a:	8b 45 e8             	mov    -0x18(%rbp),%eax
    150d:	c1 e8 1c             	shr    $0x1c,%eax
    1510:	89 c2                	mov    %eax,%edx
    1512:	48 b8 70 1d 00 00 00 	movabs $0x1d70,%rax
    1519:	00 00 00 
    151c:	89 d2                	mov    %edx,%edx
    151e:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    1522:	0f be d0             	movsbl %al,%edx
    1525:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1528:	89 d6                	mov    %edx,%esi
    152a:	89 c7                	mov    %eax,%edi
    152c:	48 b8 6a 14 00 00 00 	movabs $0x146a,%rax
    1533:	00 00 00 
    1536:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1538:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    153c:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    1540:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1543:	83 f8 07             	cmp    $0x7,%eax
    1546:	76 c2                	jbe    150a <print_x32+0x17>
}
    1548:	90                   	nop
    1549:	90                   	nop
    154a:	c9                   	leave
    154b:	c3                   	ret

000000000000154c <print_d>:

  static void
print_d(int fd, int v)
{
    154c:	55                   	push   %rbp
    154d:	48 89 e5             	mov    %rsp,%rbp
    1550:	48 83 ec 30          	sub    $0x30,%rsp
    1554:	89 7d dc             	mov    %edi,-0x24(%rbp)
    1557:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    155a:	8b 45 d8             	mov    -0x28(%rbp),%eax
    155d:	48 98                	cltq
    155f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    1563:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1567:	79 04                	jns    156d <print_d+0x21>
    x = -x;
    1569:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    156d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    1574:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1578:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    157f:	66 66 66 
    1582:	48 89 c8             	mov    %rcx,%rax
    1585:	48 f7 ea             	imul   %rdx
    1588:	48 c1 fa 02          	sar    $0x2,%rdx
    158c:	48 89 c8             	mov    %rcx,%rax
    158f:	48 c1 f8 3f          	sar    $0x3f,%rax
    1593:	48 29 c2             	sub    %rax,%rdx
    1596:	48 89 d0             	mov    %rdx,%rax
    1599:	48 c1 e0 02          	shl    $0x2,%rax
    159d:	48 01 d0             	add    %rdx,%rax
    15a0:	48 01 c0             	add    %rax,%rax
    15a3:	48 29 c1             	sub    %rax,%rcx
    15a6:	48 89 ca             	mov    %rcx,%rdx
    15a9:	8b 45 f4             	mov    -0xc(%rbp),%eax
    15ac:	8d 48 01             	lea    0x1(%rax),%ecx
    15af:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    15b2:	48 b9 70 1d 00 00 00 	movabs $0x1d70,%rcx
    15b9:	00 00 00 
    15bc:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    15c0:	48 98                	cltq
    15c2:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    15c6:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    15ca:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    15d1:	66 66 66 
    15d4:	48 89 c8             	mov    %rcx,%rax
    15d7:	48 f7 ea             	imul   %rdx
    15da:	48 89 d0             	mov    %rdx,%rax
    15dd:	48 c1 f8 02          	sar    $0x2,%rax
    15e1:	48 c1 f9 3f          	sar    $0x3f,%rcx
    15e5:	48 89 ca             	mov    %rcx,%rdx
    15e8:	48 29 d0             	sub    %rdx,%rax
    15eb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    15ef:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    15f4:	0f 85 7a ff ff ff    	jne    1574 <print_d+0x28>

  if (v < 0)
    15fa:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    15fe:	79 32                	jns    1632 <print_d+0xe6>
    buf[i++] = '-';
    1600:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1603:	8d 50 01             	lea    0x1(%rax),%edx
    1606:	89 55 f4             	mov    %edx,-0xc(%rbp)
    1609:	48 98                	cltq
    160b:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    1610:	eb 20                	jmp    1632 <print_d+0xe6>
    putc(fd, buf[i]);
    1612:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1615:	48 98                	cltq
    1617:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    161c:	0f be d0             	movsbl %al,%edx
    161f:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1622:	89 d6                	mov    %edx,%esi
    1624:	89 c7                	mov    %eax,%edi
    1626:	48 b8 6a 14 00 00 00 	movabs $0x146a,%rax
    162d:	00 00 00 
    1630:	ff d0                	call   *%rax
  while (--i >= 0)
    1632:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    1636:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    163a:	79 d6                	jns    1612 <print_d+0xc6>
}
    163c:	90                   	nop
    163d:	90                   	nop
    163e:	c9                   	leave
    163f:	c3                   	ret

0000000000001640 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    1640:	55                   	push   %rbp
    1641:	48 89 e5             	mov    %rsp,%rbp
    1644:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    164b:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    1651:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    1658:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    165f:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    1666:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    166d:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    1674:	84 c0                	test   %al,%al
    1676:	74 20                	je     1698 <printf+0x58>
    1678:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    167c:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    1680:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    1684:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    1688:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    168c:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    1690:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    1694:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    1698:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    169f:	00 00 00 
    16a2:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    16a9:	00 00 00 
    16ac:	48 8d 45 10          	lea    0x10(%rbp),%rax
    16b0:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    16b7:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    16be:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    16c5:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    16cc:	00 00 00 
    16cf:	e9 60 03 00 00       	jmp    1a34 <printf+0x3f4>
    if (c != '%') {
    16d4:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    16db:	74 24                	je     1701 <printf+0xc1>
      putc(fd, c);
    16dd:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    16e3:	0f be d0             	movsbl %al,%edx
    16e6:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    16ec:	89 d6                	mov    %edx,%esi
    16ee:	89 c7                	mov    %eax,%edi
    16f0:	48 b8 6a 14 00 00 00 	movabs $0x146a,%rax
    16f7:	00 00 00 
    16fa:	ff d0                	call   *%rax
      continue;
    16fc:	e9 2c 03 00 00       	jmp    1a2d <printf+0x3ed>
    }
    c = fmt[++i] & 0xff;
    1701:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1708:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    170e:	48 63 d0             	movslq %eax,%rdx
    1711:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1718:	48 01 d0             	add    %rdx,%rax
    171b:	0f b6 00             	movzbl (%rax),%eax
    171e:	0f be c0             	movsbl %al,%eax
    1721:	25 ff 00 00 00       	and    $0xff,%eax
    1726:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    172c:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1733:	0f 84 2e 03 00 00    	je     1a67 <printf+0x427>
      break;
    switch(c) {
    1739:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    1740:	0f 84 32 01 00 00    	je     1878 <printf+0x238>
    1746:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    174d:	0f 8f a1 02 00 00    	jg     19f4 <printf+0x3b4>
    1753:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    175a:	0f 84 d4 01 00 00    	je     1934 <printf+0x2f4>
    1760:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    1767:	0f 8f 87 02 00 00    	jg     19f4 <printf+0x3b4>
    176d:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    1774:	0f 84 5b 01 00 00    	je     18d5 <printf+0x295>
    177a:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    1781:	0f 8f 6d 02 00 00    	jg     19f4 <printf+0x3b4>
    1787:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    178e:	0f 84 87 00 00 00    	je     181b <printf+0x1db>
    1794:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    179b:	0f 8f 53 02 00 00    	jg     19f4 <printf+0x3b4>
    17a1:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    17a8:	0f 84 2b 02 00 00    	je     19d9 <printf+0x399>
    17ae:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    17b5:	0f 85 39 02 00 00    	jne    19f4 <printf+0x3b4>
    case 'c':
      putc(fd, va_arg(ap, int));
    17bb:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    17c1:	83 f8 2f             	cmp    $0x2f,%eax
    17c4:	77 23                	ja     17e9 <printf+0x1a9>
    17c6:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    17cd:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    17d3:	89 d2                	mov    %edx,%edx
    17d5:	48 01 d0             	add    %rdx,%rax
    17d8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    17de:	83 c2 08             	add    $0x8,%edx
    17e1:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    17e7:	eb 12                	jmp    17fb <printf+0x1bb>
    17e9:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    17f0:	48 8d 50 08          	lea    0x8(%rax),%rdx
    17f4:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    17fb:	8b 00                	mov    (%rax),%eax
    17fd:	0f be d0             	movsbl %al,%edx
    1800:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1806:	89 d6                	mov    %edx,%esi
    1808:	89 c7                	mov    %eax,%edi
    180a:	48 b8 6a 14 00 00 00 	movabs $0x146a,%rax
    1811:	00 00 00 
    1814:	ff d0                	call   *%rax
      break;
    1816:	e9 12 02 00 00       	jmp    1a2d <printf+0x3ed>
    case 'd':
      print_d(fd, va_arg(ap, int));
    181b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1821:	83 f8 2f             	cmp    $0x2f,%eax
    1824:	77 23                	ja     1849 <printf+0x209>
    1826:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    182d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1833:	89 d2                	mov    %edx,%edx
    1835:	48 01 d0             	add    %rdx,%rax
    1838:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    183e:	83 c2 08             	add    $0x8,%edx
    1841:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1847:	eb 12                	jmp    185b <printf+0x21b>
    1849:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1850:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1854:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    185b:	8b 10                	mov    (%rax),%edx
    185d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1863:	89 d6                	mov    %edx,%esi
    1865:	89 c7                	mov    %eax,%edi
    1867:	48 b8 4c 15 00 00 00 	movabs $0x154c,%rax
    186e:	00 00 00 
    1871:	ff d0                	call   *%rax
      break;
    1873:	e9 b5 01 00 00       	jmp    1a2d <printf+0x3ed>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    1878:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    187e:	83 f8 2f             	cmp    $0x2f,%eax
    1881:	77 23                	ja     18a6 <printf+0x266>
    1883:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    188a:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1890:	89 d2                	mov    %edx,%edx
    1892:	48 01 d0             	add    %rdx,%rax
    1895:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    189b:	83 c2 08             	add    $0x8,%edx
    189e:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    18a4:	eb 12                	jmp    18b8 <printf+0x278>
    18a6:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    18ad:	48 8d 50 08          	lea    0x8(%rax),%rdx
    18b1:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    18b8:	8b 10                	mov    (%rax),%edx
    18ba:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    18c0:	89 d6                	mov    %edx,%esi
    18c2:	89 c7                	mov    %eax,%edi
    18c4:	48 b8 f3 14 00 00 00 	movabs $0x14f3,%rax
    18cb:	00 00 00 
    18ce:	ff d0                	call   *%rax
      break;
    18d0:	e9 58 01 00 00       	jmp    1a2d <printf+0x3ed>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    18d5:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    18db:	83 f8 2f             	cmp    $0x2f,%eax
    18de:	77 23                	ja     1903 <printf+0x2c3>
    18e0:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    18e7:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18ed:	89 d2                	mov    %edx,%edx
    18ef:	48 01 d0             	add    %rdx,%rax
    18f2:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18f8:	83 c2 08             	add    $0x8,%edx
    18fb:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1901:	eb 12                	jmp    1915 <printf+0x2d5>
    1903:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    190a:	48 8d 50 08          	lea    0x8(%rax),%rdx
    190e:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1915:	48 8b 10             	mov    (%rax),%rdx
    1918:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    191e:	48 89 d6             	mov    %rdx,%rsi
    1921:	89 c7                	mov    %eax,%edi
    1923:	48 b8 9a 14 00 00 00 	movabs $0x149a,%rax
    192a:	00 00 00 
    192d:	ff d0                	call   *%rax
      break;
    192f:	e9 f9 00 00 00       	jmp    1a2d <printf+0x3ed>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    1934:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    193a:	83 f8 2f             	cmp    $0x2f,%eax
    193d:	77 23                	ja     1962 <printf+0x322>
    193f:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1946:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    194c:	89 d2                	mov    %edx,%edx
    194e:	48 01 d0             	add    %rdx,%rax
    1951:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1957:	83 c2 08             	add    $0x8,%edx
    195a:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1960:	eb 12                	jmp    1974 <printf+0x334>
    1962:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1969:	48 8d 50 08          	lea    0x8(%rax),%rdx
    196d:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1974:	48 8b 00             	mov    (%rax),%rax
    1977:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    197e:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1985:	00 
    1986:	75 41                	jne    19c9 <printf+0x389>
        s = "(null)";
    1988:	48 b8 62 1d 00 00 00 	movabs $0x1d62,%rax
    198f:	00 00 00 
    1992:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1999:	eb 2e                	jmp    19c9 <printf+0x389>
        putc(fd, *(s++));
    199b:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    19a2:	48 8d 50 01          	lea    0x1(%rax),%rdx
    19a6:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    19ad:	0f b6 00             	movzbl (%rax),%eax
    19b0:	0f be d0             	movsbl %al,%edx
    19b3:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    19b9:	89 d6                	mov    %edx,%esi
    19bb:	89 c7                	mov    %eax,%edi
    19bd:	48 b8 6a 14 00 00 00 	movabs $0x146a,%rax
    19c4:	00 00 00 
    19c7:	ff d0                	call   *%rax
      while (*s)
    19c9:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    19d0:	0f b6 00             	movzbl (%rax),%eax
    19d3:	84 c0                	test   %al,%al
    19d5:	75 c4                	jne    199b <printf+0x35b>
      break;
    19d7:	eb 54                	jmp    1a2d <printf+0x3ed>
    case '%':
      putc(fd, '%');
    19d9:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    19df:	be 25 00 00 00       	mov    $0x25,%esi
    19e4:	89 c7                	mov    %eax,%edi
    19e6:	48 b8 6a 14 00 00 00 	movabs $0x146a,%rax
    19ed:	00 00 00 
    19f0:	ff d0                	call   *%rax
      break;
    19f2:	eb 39                	jmp    1a2d <printf+0x3ed>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    19f4:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    19fa:	be 25 00 00 00       	mov    $0x25,%esi
    19ff:	89 c7                	mov    %eax,%edi
    1a01:	48 b8 6a 14 00 00 00 	movabs $0x146a,%rax
    1a08:	00 00 00 
    1a0b:	ff d0                	call   *%rax
      putc(fd, c);
    1a0d:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1a13:	0f be d0             	movsbl %al,%edx
    1a16:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a1c:	89 d6                	mov    %edx,%esi
    1a1e:	89 c7                	mov    %eax,%edi
    1a20:	48 b8 6a 14 00 00 00 	movabs $0x146a,%rax
    1a27:	00 00 00 
    1a2a:	ff d0                	call   *%rax
      break;
    1a2c:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1a2d:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1a34:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1a3a:	48 63 d0             	movslq %eax,%rdx
    1a3d:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1a44:	48 01 d0             	add    %rdx,%rax
    1a47:	0f b6 00             	movzbl (%rax),%eax
    1a4a:	0f be c0             	movsbl %al,%eax
    1a4d:	25 ff 00 00 00       	and    $0xff,%eax
    1a52:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1a58:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1a5f:	0f 85 6f fc ff ff    	jne    16d4 <printf+0x94>
    }
  }
}
    1a65:	eb 01                	jmp    1a68 <printf+0x428>
      break;
    1a67:	90                   	nop
}
    1a68:	90                   	nop
    1a69:	c9                   	leave
    1a6a:	c3                   	ret

0000000000001a6b <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1a6b:	55                   	push   %rbp
    1a6c:	48 89 e5             	mov    %rsp,%rbp
    1a6f:	48 83 ec 18          	sub    $0x18,%rsp
    1a73:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1a77:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1a7b:	48 83 e8 10          	sub    $0x10,%rax
    1a7f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1a83:	48 b8 a0 1d 00 00 00 	movabs $0x1da0,%rax
    1a8a:	00 00 00 
    1a8d:	48 8b 00             	mov    (%rax),%rax
    1a90:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1a94:	eb 2f                	jmp    1ac5 <free+0x5a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1a96:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1a9a:	48 8b 00             	mov    (%rax),%rax
    1a9d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1aa1:	72 17                	jb     1aba <free+0x4f>
    1aa3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1aa7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1aab:	72 2f                	jb     1adc <free+0x71>
    1aad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ab1:	48 8b 00             	mov    (%rax),%rax
    1ab4:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1ab8:	72 22                	jb     1adc <free+0x71>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1aba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1abe:	48 8b 00             	mov    (%rax),%rax
    1ac1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1ac5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ac9:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1acd:	73 c7                	jae    1a96 <free+0x2b>
    1acf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ad3:	48 8b 00             	mov    (%rax),%rax
    1ad6:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1ada:	73 ba                	jae    1a96 <free+0x2b>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1adc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ae0:	8b 40 08             	mov    0x8(%rax),%eax
    1ae3:	89 c0                	mov    %eax,%eax
    1ae5:	48 c1 e0 04          	shl    $0x4,%rax
    1ae9:	48 89 c2             	mov    %rax,%rdx
    1aec:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1af0:	48 01 c2             	add    %rax,%rdx
    1af3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1af7:	48 8b 00             	mov    (%rax),%rax
    1afa:	48 39 c2             	cmp    %rax,%rdx
    1afd:	75 2d                	jne    1b2c <free+0xc1>
    bp->s.size += p->s.ptr->s.size;
    1aff:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b03:	8b 50 08             	mov    0x8(%rax),%edx
    1b06:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b0a:	48 8b 00             	mov    (%rax),%rax
    1b0d:	8b 40 08             	mov    0x8(%rax),%eax
    1b10:	01 c2                	add    %eax,%edx
    1b12:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b16:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1b19:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b1d:	48 8b 00             	mov    (%rax),%rax
    1b20:	48 8b 10             	mov    (%rax),%rdx
    1b23:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b27:	48 89 10             	mov    %rdx,(%rax)
    1b2a:	eb 0e                	jmp    1b3a <free+0xcf>
  } else
    bp->s.ptr = p->s.ptr;
    1b2c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b30:	48 8b 10             	mov    (%rax),%rdx
    1b33:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b37:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    1b3a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b3e:	8b 40 08             	mov    0x8(%rax),%eax
    1b41:	89 c0                	mov    %eax,%eax
    1b43:	48 c1 e0 04          	shl    $0x4,%rax
    1b47:	48 89 c2             	mov    %rax,%rdx
    1b4a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b4e:	48 01 d0             	add    %rdx,%rax
    1b51:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1b55:	75 27                	jne    1b7e <free+0x113>
    p->s.size += bp->s.size;
    1b57:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b5b:	8b 50 08             	mov    0x8(%rax),%edx
    1b5e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b62:	8b 40 08             	mov    0x8(%rax),%eax
    1b65:	01 c2                	add    %eax,%edx
    1b67:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b6b:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    1b6e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b72:	48 8b 10             	mov    (%rax),%rdx
    1b75:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b79:	48 89 10             	mov    %rdx,(%rax)
    1b7c:	eb 0b                	jmp    1b89 <free+0x11e>
  } else
    p->s.ptr = bp;
    1b7e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b82:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1b86:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    1b89:	48 ba a0 1d 00 00 00 	movabs $0x1da0,%rdx
    1b90:	00 00 00 
    1b93:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b97:	48 89 02             	mov    %rax,(%rdx)
}
    1b9a:	90                   	nop
    1b9b:	c9                   	leave
    1b9c:	c3                   	ret

0000000000001b9d <morecore>:

static Header*
morecore(uint nu)
{
    1b9d:	55                   	push   %rbp
    1b9e:	48 89 e5             	mov    %rsp,%rbp
    1ba1:	48 83 ec 20          	sub    $0x20,%rsp
    1ba5:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    1ba8:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1baf:	77 07                	ja     1bb8 <morecore+0x1b>
    nu = 4096;
    1bb1:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    1bb8:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1bbb:	48 c1 e0 04          	shl    $0x4,%rax
    1bbf:	48 89 c7             	mov    %rax,%rdi
    1bc2:	48 b8 29 14 00 00 00 	movabs $0x1429,%rax
    1bc9:	00 00 00 
    1bcc:	ff d0                	call   *%rax
    1bce:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    1bd2:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1bd7:	75 07                	jne    1be0 <morecore+0x43>
    return 0;
    1bd9:	b8 00 00 00 00       	mov    $0x0,%eax
    1bde:	eb 36                	jmp    1c16 <morecore+0x79>
  hp = (Header*)p;
    1be0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1be4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    1be8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bec:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1bef:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    1bf2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bf6:	48 83 c0 10          	add    $0x10,%rax
    1bfa:	48 89 c7             	mov    %rax,%rdi
    1bfd:	48 b8 6b 1a 00 00 00 	movabs $0x1a6b,%rax
    1c04:	00 00 00 
    1c07:	ff d0                	call   *%rax
  return freep;
    1c09:	48 b8 a0 1d 00 00 00 	movabs $0x1da0,%rax
    1c10:	00 00 00 
    1c13:	48 8b 00             	mov    (%rax),%rax
}
    1c16:	c9                   	leave
    1c17:	c3                   	ret

0000000000001c18 <malloc>:

void*
malloc(uint nbytes)
{
    1c18:	55                   	push   %rbp
    1c19:	48 89 e5             	mov    %rsp,%rbp
    1c1c:	48 83 ec 30          	sub    $0x30,%rsp
    1c20:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1c23:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1c26:	48 83 c0 0f          	add    $0xf,%rax
    1c2a:	48 c1 e8 04          	shr    $0x4,%rax
    1c2e:	83 c0 01             	add    $0x1,%eax
    1c31:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    1c34:	48 b8 a0 1d 00 00 00 	movabs $0x1da0,%rax
    1c3b:	00 00 00 
    1c3e:	48 8b 00             	mov    (%rax),%rax
    1c41:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1c45:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1c4a:	75 4a                	jne    1c96 <malloc+0x7e>
    base.s.ptr = freep = prevp = &base;
    1c4c:	48 b8 90 1d 00 00 00 	movabs $0x1d90,%rax
    1c53:	00 00 00 
    1c56:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1c5a:	48 ba a0 1d 00 00 00 	movabs $0x1da0,%rdx
    1c61:	00 00 00 
    1c64:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c68:	48 89 02             	mov    %rax,(%rdx)
    1c6b:	48 b8 a0 1d 00 00 00 	movabs $0x1da0,%rax
    1c72:	00 00 00 
    1c75:	48 8b 00             	mov    (%rax),%rax
    1c78:	48 ba 90 1d 00 00 00 	movabs $0x1d90,%rdx
    1c7f:	00 00 00 
    1c82:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    1c85:	48 b8 90 1d 00 00 00 	movabs $0x1d90,%rax
    1c8c:	00 00 00 
    1c8f:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1c96:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c9a:	48 8b 00             	mov    (%rax),%rax
    1c9d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1ca1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ca5:	8b 40 08             	mov    0x8(%rax),%eax
    1ca8:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1cab:	72 65                	jb     1d12 <malloc+0xfa>
      if(p->s.size == nunits)
    1cad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cb1:	8b 40 08             	mov    0x8(%rax),%eax
    1cb4:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1cb7:	75 10                	jne    1cc9 <malloc+0xb1>
        prevp->s.ptr = p->s.ptr;
    1cb9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cbd:	48 8b 10             	mov    (%rax),%rdx
    1cc0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cc4:	48 89 10             	mov    %rdx,(%rax)
    1cc7:	eb 2e                	jmp    1cf7 <malloc+0xdf>
      else {
        p->s.size -= nunits;
    1cc9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ccd:	8b 40 08             	mov    0x8(%rax),%eax
    1cd0:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1cd3:	89 c2                	mov    %eax,%edx
    1cd5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cd9:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    1cdc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ce0:	8b 40 08             	mov    0x8(%rax),%eax
    1ce3:	89 c0                	mov    %eax,%eax
    1ce5:	48 c1 e0 04          	shl    $0x4,%rax
    1ce9:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    1ced:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cf1:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1cf4:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    1cf7:	48 ba a0 1d 00 00 00 	movabs $0x1da0,%rdx
    1cfe:	00 00 00 
    1d01:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d05:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    1d08:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d0c:	48 83 c0 10          	add    $0x10,%rax
    1d10:	eb 4e                	jmp    1d60 <malloc+0x148>
    }
    if(p == freep)
    1d12:	48 b8 a0 1d 00 00 00 	movabs $0x1da0,%rax
    1d19:	00 00 00 
    1d1c:	48 8b 00             	mov    (%rax),%rax
    1d1f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1d23:	75 23                	jne    1d48 <malloc+0x130>
      if((p = morecore(nunits)) == 0)
    1d25:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1d28:	89 c7                	mov    %eax,%edi
    1d2a:	48 b8 9d 1b 00 00 00 	movabs $0x1b9d,%rax
    1d31:	00 00 00 
    1d34:	ff d0                	call   *%rax
    1d36:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1d3a:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1d3f:	75 07                	jne    1d48 <malloc+0x130>
        return 0;
    1d41:	b8 00 00 00 00       	mov    $0x0,%eax
    1d46:	eb 18                	jmp    1d60 <malloc+0x148>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1d48:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d4c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1d50:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d54:	48 8b 00             	mov    (%rax),%rax
    1d57:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1d5b:	e9 41 ff ff ff       	jmp    1ca1 <malloc+0x89>
  }
}
    1d60:	c9                   	leave
    1d61:	c3                   	ret
