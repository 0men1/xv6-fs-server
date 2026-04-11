
_ln:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
    1000:	55                   	push   %rbp
    1001:	48 89 e5             	mov    %rsp,%rbp
    1004:	48 83 ec 10          	sub    $0x10,%rsp
    1008:	89 7d fc             	mov    %edi,-0x4(%rbp)
    100b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(argc != 3){
    100f:	83 7d fc 03          	cmpl   $0x3,-0x4(%rbp)
    1013:	74 2f                	je     1044 <main+0x44>
    printf(2, "Usage: ln old new\n");
    1015:	48 b8 ea 1d 00 00 00 	movabs $0x1dea,%rax
    101c:	00 00 00 
    101f:	48 89 c6             	mov    %rax,%rsi
    1022:	bf 02 00 00 00       	mov    $0x2,%edi
    1027:	b8 00 00 00 00       	mov    $0x0,%eax
    102c:	48 ba c8 16 00 00 00 	movabs $0x16c8,%rdx
    1033:	00 00 00 
    1036:	ff d2                	call   *%rdx
    exit();
    1038:	48 b8 d4 13 00 00 00 	movabs $0x13d4,%rax
    103f:	00 00 00 
    1042:	ff d0                	call   *%rax
  }
  if(link(argv[1], argv[2]) < 0)
    1044:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1048:	48 83 c0 10          	add    $0x10,%rax
    104c:	48 8b 10             	mov    (%rax),%rdx
    104f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1053:	48 83 c0 08          	add    $0x8,%rax
    1057:	48 8b 00             	mov    (%rax),%rax
    105a:	48 89 d6             	mov    %rdx,%rsi
    105d:	48 89 c7             	mov    %rax,%rdi
    1060:	48 b8 70 14 00 00 00 	movabs $0x1470,%rax
    1067:	00 00 00 
    106a:	ff d0                	call   *%rax
    106c:	85 c0                	test   %eax,%eax
    106e:	79 3d                	jns    10ad <main+0xad>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
    1070:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1074:	48 83 c0 10          	add    $0x10,%rax
    1078:	48 8b 10             	mov    (%rax),%rdx
    107b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    107f:	48 83 c0 08          	add    $0x8,%rax
    1083:	48 8b 00             	mov    (%rax),%rax
    1086:	48 be fd 1d 00 00 00 	movabs $0x1dfd,%rsi
    108d:	00 00 00 
    1090:	48 89 d1             	mov    %rdx,%rcx
    1093:	48 89 c2             	mov    %rax,%rdx
    1096:	bf 02 00 00 00       	mov    $0x2,%edi
    109b:	b8 00 00 00 00       	mov    $0x0,%eax
    10a0:	49 b8 c8 16 00 00 00 	movabs $0x16c8,%r8
    10a7:	00 00 00 
    10aa:	41 ff d0             	call   *%r8
  exit();
    10ad:	48 b8 d4 13 00 00 00 	movabs $0x13d4,%rax
    10b4:	00 00 00 
    10b7:	ff d0                	call   *%rax

00000000000010b9 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    10b9:	55                   	push   %rbp
    10ba:	48 89 e5             	mov    %rsp,%rbp
    10bd:	48 83 ec 10          	sub    $0x10,%rsp
    10c1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    10c5:	89 75 f4             	mov    %esi,-0xc(%rbp)
    10c8:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
    10cb:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    10cf:	8b 55 f0             	mov    -0x10(%rbp),%edx
    10d2:	8b 45 f4             	mov    -0xc(%rbp),%eax
    10d5:	48 89 ce             	mov    %rcx,%rsi
    10d8:	48 89 f7             	mov    %rsi,%rdi
    10db:	89 d1                	mov    %edx,%ecx
    10dd:	fc                   	cld
    10de:	f3 aa                	rep stos %al,(%rdi)
    10e0:	89 ca                	mov    %ecx,%edx
    10e2:	48 89 fe             	mov    %rdi,%rsi
    10e5:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    10e9:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    10ec:	90                   	nop
    10ed:	c9                   	leave
    10ee:	c3                   	ret

00000000000010ef <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    10ef:	55                   	push   %rbp
    10f0:	48 89 e5             	mov    %rsp,%rbp
    10f3:	48 83 ec 20          	sub    $0x20,%rsp
    10f7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    10fb:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
    10ff:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1103:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    1107:	90                   	nop
    1108:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    110c:	48 8d 42 01          	lea    0x1(%rdx),%rax
    1110:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    1114:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1118:	48 8d 48 01          	lea    0x1(%rax),%rcx
    111c:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    1120:	0f b6 12             	movzbl (%rdx),%edx
    1123:	88 10                	mov    %dl,(%rax)
    1125:	0f b6 00             	movzbl (%rax),%eax
    1128:	84 c0                	test   %al,%al
    112a:	75 dc                	jne    1108 <strcpy+0x19>
    ;
  return os;
    112c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    1130:	c9                   	leave
    1131:	c3                   	ret

0000000000001132 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1132:	55                   	push   %rbp
    1133:	48 89 e5             	mov    %rsp,%rbp
    1136:	48 83 ec 10          	sub    $0x10,%rsp
    113a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    113e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    1142:	eb 0a                	jmp    114e <strcmp+0x1c>
    p++, q++;
    1144:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1149:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    114e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1152:	0f b6 00             	movzbl (%rax),%eax
    1155:	84 c0                	test   %al,%al
    1157:	74 12                	je     116b <strcmp+0x39>
    1159:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    115d:	0f b6 10             	movzbl (%rax),%edx
    1160:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1164:	0f b6 00             	movzbl (%rax),%eax
    1167:	38 c2                	cmp    %al,%dl
    1169:	74 d9                	je     1144 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
    116b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    116f:	0f b6 00             	movzbl (%rax),%eax
    1172:	0f b6 d0             	movzbl %al,%edx
    1175:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1179:	0f b6 00             	movzbl (%rax),%eax
    117c:	0f b6 c0             	movzbl %al,%eax
    117f:	29 c2                	sub    %eax,%edx
    1181:	89 d0                	mov    %edx,%eax
}
    1183:	c9                   	leave
    1184:	c3                   	ret

0000000000001185 <strlen>:

uint
strlen(char *s)
{
    1185:	55                   	push   %rbp
    1186:	48 89 e5             	mov    %rsp,%rbp
    1189:	48 83 ec 18          	sub    $0x18,%rsp
    118d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
    1191:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1198:	eb 04                	jmp    119e <strlen+0x19>
    119a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    119e:	8b 45 fc             	mov    -0x4(%rbp),%eax
    11a1:	48 63 d0             	movslq %eax,%rdx
    11a4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    11a8:	48 01 d0             	add    %rdx,%rax
    11ab:	0f b6 00             	movzbl (%rax),%eax
    11ae:	84 c0                	test   %al,%al
    11b0:	75 e8                	jne    119a <strlen+0x15>
    ;
  return n;
    11b2:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    11b5:	c9                   	leave
    11b6:	c3                   	ret

00000000000011b7 <memset>:

void*
memset(void *dst, int c, uint n)
{
    11b7:	55                   	push   %rbp
    11b8:	48 89 e5             	mov    %rsp,%rbp
    11bb:	48 83 ec 10          	sub    $0x10,%rsp
    11bf:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    11c3:	89 75 f4             	mov    %esi,-0xc(%rbp)
    11c6:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    11c9:	8b 55 f0             	mov    -0x10(%rbp),%edx
    11cc:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    11cf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    11d3:	89 ce                	mov    %ecx,%esi
    11d5:	48 89 c7             	mov    %rax,%rdi
    11d8:	48 b8 b9 10 00 00 00 	movabs $0x10b9,%rax
    11df:	00 00 00 
    11e2:	ff d0                	call   *%rax
  return dst;
    11e4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    11e8:	c9                   	leave
    11e9:	c3                   	ret

00000000000011ea <strchr>:

char*
strchr(const char *s, char c)
{
    11ea:	55                   	push   %rbp
    11eb:	48 89 e5             	mov    %rsp,%rbp
    11ee:	48 83 ec 10          	sub    $0x10,%rsp
    11f2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    11f6:	89 f0                	mov    %esi,%eax
    11f8:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    11fb:	eb 17                	jmp    1214 <strchr+0x2a>
    if(*s == c)
    11fd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1201:	0f b6 00             	movzbl (%rax),%eax
    1204:	38 45 f4             	cmp    %al,-0xc(%rbp)
    1207:	75 06                	jne    120f <strchr+0x25>
      return (char*)s;
    1209:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    120d:	eb 15                	jmp    1224 <strchr+0x3a>
  for(; *s; s++)
    120f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1214:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1218:	0f b6 00             	movzbl (%rax),%eax
    121b:	84 c0                	test   %al,%al
    121d:	75 de                	jne    11fd <strchr+0x13>
  return 0;
    121f:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1224:	c9                   	leave
    1225:	c3                   	ret

0000000000001226 <gets>:

char*
gets(char *buf, int max)
{
    1226:	55                   	push   %rbp
    1227:	48 89 e5             	mov    %rsp,%rbp
    122a:	48 83 ec 20          	sub    $0x20,%rsp
    122e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1232:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1235:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    123c:	eb 4f                	jmp    128d <gets+0x67>
    cc = read(0, &c, 1);
    123e:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    1242:	ba 01 00 00 00       	mov    $0x1,%edx
    1247:	48 89 c6             	mov    %rax,%rsi
    124a:	bf 00 00 00 00       	mov    $0x0,%edi
    124f:	48 b8 fb 13 00 00 00 	movabs $0x13fb,%rax
    1256:	00 00 00 
    1259:	ff d0                	call   *%rax
    125b:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    125e:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1262:	7e 36                	jle    129a <gets+0x74>
      break;
    buf[i++] = c;
    1264:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1267:	8d 50 01             	lea    0x1(%rax),%edx
    126a:	89 55 fc             	mov    %edx,-0x4(%rbp)
    126d:	48 63 d0             	movslq %eax,%rdx
    1270:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1274:	48 01 c2             	add    %rax,%rdx
    1277:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    127b:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    127d:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1281:	3c 0a                	cmp    $0xa,%al
    1283:	74 16                	je     129b <gets+0x75>
    1285:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1289:	3c 0d                	cmp    $0xd,%al
    128b:	74 0e                	je     129b <gets+0x75>
  for(i=0; i+1 < max; ){
    128d:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1290:	83 c0 01             	add    $0x1,%eax
    1293:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    1296:	7f a6                	jg     123e <gets+0x18>
    1298:	eb 01                	jmp    129b <gets+0x75>
      break;
    129a:	90                   	nop
      break;
  }
  buf[i] = '\0';
    129b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    129e:	48 63 d0             	movslq %eax,%rdx
    12a1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12a5:	48 01 d0             	add    %rdx,%rax
    12a8:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    12ab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    12af:	c9                   	leave
    12b0:	c3                   	ret

00000000000012b1 <stat>:

int
stat(char *n, struct stat *st)
{
    12b1:	55                   	push   %rbp
    12b2:	48 89 e5             	mov    %rsp,%rbp
    12b5:	48 83 ec 20          	sub    $0x20,%rsp
    12b9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    12bd:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    12c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12c5:	be 00 00 00 00       	mov    $0x0,%esi
    12ca:	48 89 c7             	mov    %rax,%rdi
    12cd:	48 b8 3c 14 00 00 00 	movabs $0x143c,%rax
    12d4:	00 00 00 
    12d7:	ff d0                	call   *%rax
    12d9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    12dc:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    12e0:	79 07                	jns    12e9 <stat+0x38>
    return -1;
    12e2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    12e7:	eb 2f                	jmp    1318 <stat+0x67>
  r = fstat(fd, st);
    12e9:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    12ed:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12f0:	48 89 d6             	mov    %rdx,%rsi
    12f3:	89 c7                	mov    %eax,%edi
    12f5:	48 b8 63 14 00 00 00 	movabs $0x1463,%rax
    12fc:	00 00 00 
    12ff:	ff d0                	call   *%rax
    1301:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    1304:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1307:	89 c7                	mov    %eax,%edi
    1309:	48 b8 15 14 00 00 00 	movabs $0x1415,%rax
    1310:	00 00 00 
    1313:	ff d0                	call   *%rax
  return r;
    1315:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    1318:	c9                   	leave
    1319:	c3                   	ret

000000000000131a <atoi>:

int
atoi(const char *s)
{
    131a:	55                   	push   %rbp
    131b:	48 89 e5             	mov    %rsp,%rbp
    131e:	48 83 ec 18          	sub    $0x18,%rsp
    1322:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    1326:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    132d:	eb 28                	jmp    1357 <atoi+0x3d>
    n = n*10 + *s++ - '0';
    132f:	8b 55 fc             	mov    -0x4(%rbp),%edx
    1332:	89 d0                	mov    %edx,%eax
    1334:	c1 e0 02             	shl    $0x2,%eax
    1337:	01 d0                	add    %edx,%eax
    1339:	01 c0                	add    %eax,%eax
    133b:	89 c1                	mov    %eax,%ecx
    133d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1341:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1345:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    1349:	0f b6 00             	movzbl (%rax),%eax
    134c:	0f be c0             	movsbl %al,%eax
    134f:	01 c8                	add    %ecx,%eax
    1351:	83 e8 30             	sub    $0x30,%eax
    1354:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1357:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    135b:	0f b6 00             	movzbl (%rax),%eax
    135e:	3c 2f                	cmp    $0x2f,%al
    1360:	7e 0b                	jle    136d <atoi+0x53>
    1362:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1366:	0f b6 00             	movzbl (%rax),%eax
    1369:	3c 39                	cmp    $0x39,%al
    136b:	7e c2                	jle    132f <atoi+0x15>
  return n;
    136d:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    1370:	c9                   	leave
    1371:	c3                   	ret

0000000000001372 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1372:	55                   	push   %rbp
    1373:	48 89 e5             	mov    %rsp,%rbp
    1376:	48 83 ec 28          	sub    $0x28,%rsp
    137a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    137e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    1382:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    1385:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1389:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    138d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1391:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    1395:	eb 1d                	jmp    13b4 <memmove+0x42>
    *dst++ = *src++;
    1397:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    139b:	48 8d 42 01          	lea    0x1(%rdx),%rax
    139f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    13a3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13a7:	48 8d 48 01          	lea    0x1(%rax),%rcx
    13ab:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    13af:	0f b6 12             	movzbl (%rdx),%edx
    13b2:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    13b4:	8b 45 dc             	mov    -0x24(%rbp),%eax
    13b7:	8d 50 ff             	lea    -0x1(%rax),%edx
    13ba:	89 55 dc             	mov    %edx,-0x24(%rbp)
    13bd:	85 c0                	test   %eax,%eax
    13bf:	7f d6                	jg     1397 <memmove+0x25>
  return vdst;
    13c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    13c5:	c9                   	leave
    13c6:	c3                   	ret

00000000000013c7 <fork>:
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    13c7:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    13ce:	49 89 ca             	mov    %rcx,%r10
    13d1:	0f 05                	syscall
    13d3:	c3                   	ret

00000000000013d4 <exit>:
SYSCALL(exit)
    13d4:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    13db:	49 89 ca             	mov    %rcx,%r10
    13de:	0f 05                	syscall
    13e0:	c3                   	ret

00000000000013e1 <wait>:
SYSCALL(wait)
    13e1:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    13e8:	49 89 ca             	mov    %rcx,%r10
    13eb:	0f 05                	syscall
    13ed:	c3                   	ret

00000000000013ee <pipe>:
SYSCALL(pipe)
    13ee:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    13f5:	49 89 ca             	mov    %rcx,%r10
    13f8:	0f 05                	syscall
    13fa:	c3                   	ret

00000000000013fb <read>:
SYSCALL(read)
    13fb:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    1402:	49 89 ca             	mov    %rcx,%r10
    1405:	0f 05                	syscall
    1407:	c3                   	ret

0000000000001408 <write>:
SYSCALL(write)
    1408:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    140f:	49 89 ca             	mov    %rcx,%r10
    1412:	0f 05                	syscall
    1414:	c3                   	ret

0000000000001415 <close>:
SYSCALL(close)
    1415:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    141c:	49 89 ca             	mov    %rcx,%r10
    141f:	0f 05                	syscall
    1421:	c3                   	ret

0000000000001422 <kill>:
SYSCALL(kill)
    1422:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    1429:	49 89 ca             	mov    %rcx,%r10
    142c:	0f 05                	syscall
    142e:	c3                   	ret

000000000000142f <exec>:
SYSCALL(exec)
    142f:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    1436:	49 89 ca             	mov    %rcx,%r10
    1439:	0f 05                	syscall
    143b:	c3                   	ret

000000000000143c <open>:
SYSCALL(open)
    143c:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    1443:	49 89 ca             	mov    %rcx,%r10
    1446:	0f 05                	syscall
    1448:	c3                   	ret

0000000000001449 <mknod>:
SYSCALL(mknod)
    1449:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    1450:	49 89 ca             	mov    %rcx,%r10
    1453:	0f 05                	syscall
    1455:	c3                   	ret

0000000000001456 <unlink>:
SYSCALL(unlink)
    1456:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    145d:	49 89 ca             	mov    %rcx,%r10
    1460:	0f 05                	syscall
    1462:	c3                   	ret

0000000000001463 <fstat>:
SYSCALL(fstat)
    1463:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    146a:	49 89 ca             	mov    %rcx,%r10
    146d:	0f 05                	syscall
    146f:	c3                   	ret

0000000000001470 <link>:
SYSCALL(link)
    1470:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    1477:	49 89 ca             	mov    %rcx,%r10
    147a:	0f 05                	syscall
    147c:	c3                   	ret

000000000000147d <mkdir>:
SYSCALL(mkdir)
    147d:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    1484:	49 89 ca             	mov    %rcx,%r10
    1487:	0f 05                	syscall
    1489:	c3                   	ret

000000000000148a <chdir>:
SYSCALL(chdir)
    148a:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    1491:	49 89 ca             	mov    %rcx,%r10
    1494:	0f 05                	syscall
    1496:	c3                   	ret

0000000000001497 <dup>:
SYSCALL(dup)
    1497:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    149e:	49 89 ca             	mov    %rcx,%r10
    14a1:	0f 05                	syscall
    14a3:	c3                   	ret

00000000000014a4 <getpid>:
SYSCALL(getpid)
    14a4:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    14ab:	49 89 ca             	mov    %rcx,%r10
    14ae:	0f 05                	syscall
    14b0:	c3                   	ret

00000000000014b1 <sbrk>:
SYSCALL(sbrk)
    14b1:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    14b8:	49 89 ca             	mov    %rcx,%r10
    14bb:	0f 05                	syscall
    14bd:	c3                   	ret

00000000000014be <sleep>:
SYSCALL(sleep)
    14be:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    14c5:	49 89 ca             	mov    %rcx,%r10
    14c8:	0f 05                	syscall
    14ca:	c3                   	ret

00000000000014cb <uptime>:
SYSCALL(uptime)
    14cb:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    14d2:	49 89 ca             	mov    %rcx,%r10
    14d5:	0f 05                	syscall
    14d7:	c3                   	ret

00000000000014d8 <send>:
SYSCALL(send)
    14d8:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    14df:	49 89 ca             	mov    %rcx,%r10
    14e2:	0f 05                	syscall
    14e4:	c3                   	ret

00000000000014e5 <recv>:
SYSCALL(recv)
    14e5:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    14ec:	49 89 ca             	mov    %rcx,%r10
    14ef:	0f 05                	syscall
    14f1:	c3                   	ret

00000000000014f2 <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    14f2:	55                   	push   %rbp
    14f3:	48 89 e5             	mov    %rsp,%rbp
    14f6:	48 83 ec 10          	sub    $0x10,%rsp
    14fa:	89 7d fc             	mov    %edi,-0x4(%rbp)
    14fd:	89 f0                	mov    %esi,%eax
    14ff:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    1502:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    1506:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1509:	ba 01 00 00 00       	mov    $0x1,%edx
    150e:	48 89 ce             	mov    %rcx,%rsi
    1511:	89 c7                	mov    %eax,%edi
    1513:	48 b8 08 14 00 00 00 	movabs $0x1408,%rax
    151a:	00 00 00 
    151d:	ff d0                	call   *%rax
}
    151f:	90                   	nop
    1520:	c9                   	leave
    1521:	c3                   	ret

0000000000001522 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    1522:	55                   	push   %rbp
    1523:	48 89 e5             	mov    %rsp,%rbp
    1526:	48 83 ec 20          	sub    $0x20,%rsp
    152a:	89 7d ec             	mov    %edi,-0x14(%rbp)
    152d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1531:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1538:	eb 35                	jmp    156f <print_x64+0x4d>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    153a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    153e:	48 c1 e8 3c          	shr    $0x3c,%rax
    1542:	48 ba 20 1e 00 00 00 	movabs $0x1e20,%rdx
    1549:	00 00 00 
    154c:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1550:	0f be d0             	movsbl %al,%edx
    1553:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1556:	89 d6                	mov    %edx,%esi
    1558:	89 c7                	mov    %eax,%edi
    155a:	48 b8 f2 14 00 00 00 	movabs $0x14f2,%rax
    1561:	00 00 00 
    1564:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1566:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    156a:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    156f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1572:	83 f8 0f             	cmp    $0xf,%eax
    1575:	76 c3                	jbe    153a <print_x64+0x18>
}
    1577:	90                   	nop
    1578:	90                   	nop
    1579:	c9                   	leave
    157a:	c3                   	ret

000000000000157b <print_x32>:

  static void
print_x32(int fd, uint x)
{
    157b:	55                   	push   %rbp
    157c:	48 89 e5             	mov    %rsp,%rbp
    157f:	48 83 ec 20          	sub    $0x20,%rsp
    1583:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1586:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1589:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1590:	eb 36                	jmp    15c8 <print_x32+0x4d>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    1592:	8b 45 e8             	mov    -0x18(%rbp),%eax
    1595:	c1 e8 1c             	shr    $0x1c,%eax
    1598:	89 c2                	mov    %eax,%edx
    159a:	48 b8 20 1e 00 00 00 	movabs $0x1e20,%rax
    15a1:	00 00 00 
    15a4:	89 d2                	mov    %edx,%edx
    15a6:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    15aa:	0f be d0             	movsbl %al,%edx
    15ad:	8b 45 ec             	mov    -0x14(%rbp),%eax
    15b0:	89 d6                	mov    %edx,%esi
    15b2:	89 c7                	mov    %eax,%edi
    15b4:	48 b8 f2 14 00 00 00 	movabs $0x14f2,%rax
    15bb:	00 00 00 
    15be:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    15c0:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    15c4:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    15c8:	8b 45 fc             	mov    -0x4(%rbp),%eax
    15cb:	83 f8 07             	cmp    $0x7,%eax
    15ce:	76 c2                	jbe    1592 <print_x32+0x17>
}
    15d0:	90                   	nop
    15d1:	90                   	nop
    15d2:	c9                   	leave
    15d3:	c3                   	ret

00000000000015d4 <print_d>:

  static void
print_d(int fd, int v)
{
    15d4:	55                   	push   %rbp
    15d5:	48 89 e5             	mov    %rsp,%rbp
    15d8:	48 83 ec 30          	sub    $0x30,%rsp
    15dc:	89 7d dc             	mov    %edi,-0x24(%rbp)
    15df:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    15e2:	8b 45 d8             	mov    -0x28(%rbp),%eax
    15e5:	48 98                	cltq
    15e7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    15eb:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    15ef:	79 04                	jns    15f5 <print_d+0x21>
    x = -x;
    15f1:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    15f5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    15fc:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1600:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1607:	66 66 66 
    160a:	48 89 c8             	mov    %rcx,%rax
    160d:	48 f7 ea             	imul   %rdx
    1610:	48 c1 fa 02          	sar    $0x2,%rdx
    1614:	48 89 c8             	mov    %rcx,%rax
    1617:	48 c1 f8 3f          	sar    $0x3f,%rax
    161b:	48 29 c2             	sub    %rax,%rdx
    161e:	48 89 d0             	mov    %rdx,%rax
    1621:	48 c1 e0 02          	shl    $0x2,%rax
    1625:	48 01 d0             	add    %rdx,%rax
    1628:	48 01 c0             	add    %rax,%rax
    162b:	48 29 c1             	sub    %rax,%rcx
    162e:	48 89 ca             	mov    %rcx,%rdx
    1631:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1634:	8d 48 01             	lea    0x1(%rax),%ecx
    1637:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    163a:	48 b9 20 1e 00 00 00 	movabs $0x1e20,%rcx
    1641:	00 00 00 
    1644:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    1648:	48 98                	cltq
    164a:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    164e:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1652:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1659:	66 66 66 
    165c:	48 89 c8             	mov    %rcx,%rax
    165f:	48 f7 ea             	imul   %rdx
    1662:	48 89 d0             	mov    %rdx,%rax
    1665:	48 c1 f8 02          	sar    $0x2,%rax
    1669:	48 c1 f9 3f          	sar    $0x3f,%rcx
    166d:	48 89 ca             	mov    %rcx,%rdx
    1670:	48 29 d0             	sub    %rdx,%rax
    1673:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    1677:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    167c:	0f 85 7a ff ff ff    	jne    15fc <print_d+0x28>

  if (v < 0)
    1682:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1686:	79 32                	jns    16ba <print_d+0xe6>
    buf[i++] = '-';
    1688:	8b 45 f4             	mov    -0xc(%rbp),%eax
    168b:	8d 50 01             	lea    0x1(%rax),%edx
    168e:	89 55 f4             	mov    %edx,-0xc(%rbp)
    1691:	48 98                	cltq
    1693:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    1698:	eb 20                	jmp    16ba <print_d+0xe6>
    putc(fd, buf[i]);
    169a:	8b 45 f4             	mov    -0xc(%rbp),%eax
    169d:	48 98                	cltq
    169f:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    16a4:	0f be d0             	movsbl %al,%edx
    16a7:	8b 45 dc             	mov    -0x24(%rbp),%eax
    16aa:	89 d6                	mov    %edx,%esi
    16ac:	89 c7                	mov    %eax,%edi
    16ae:	48 b8 f2 14 00 00 00 	movabs $0x14f2,%rax
    16b5:	00 00 00 
    16b8:	ff d0                	call   *%rax
  while (--i >= 0)
    16ba:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    16be:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    16c2:	79 d6                	jns    169a <print_d+0xc6>
}
    16c4:	90                   	nop
    16c5:	90                   	nop
    16c6:	c9                   	leave
    16c7:	c3                   	ret

00000000000016c8 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    16c8:	55                   	push   %rbp
    16c9:	48 89 e5             	mov    %rsp,%rbp
    16cc:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    16d3:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    16d9:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    16e0:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    16e7:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    16ee:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    16f5:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    16fc:	84 c0                	test   %al,%al
    16fe:	74 20                	je     1720 <printf+0x58>
    1700:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    1704:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    1708:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    170c:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    1710:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    1714:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    1718:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    171c:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    1720:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    1727:	00 00 00 
    172a:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    1731:	00 00 00 
    1734:	48 8d 45 10          	lea    0x10(%rbp),%rax
    1738:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    173f:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    1746:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    174d:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    1754:	00 00 00 
    1757:	e9 60 03 00 00       	jmp    1abc <printf+0x3f4>
    if (c != '%') {
    175c:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1763:	74 24                	je     1789 <printf+0xc1>
      putc(fd, c);
    1765:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    176b:	0f be d0             	movsbl %al,%edx
    176e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1774:	89 d6                	mov    %edx,%esi
    1776:	89 c7                	mov    %eax,%edi
    1778:	48 b8 f2 14 00 00 00 	movabs $0x14f2,%rax
    177f:	00 00 00 
    1782:	ff d0                	call   *%rax
      continue;
    1784:	e9 2c 03 00 00       	jmp    1ab5 <printf+0x3ed>
    }
    c = fmt[++i] & 0xff;
    1789:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1790:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1796:	48 63 d0             	movslq %eax,%rdx
    1799:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    17a0:	48 01 d0             	add    %rdx,%rax
    17a3:	0f b6 00             	movzbl (%rax),%eax
    17a6:	0f be c0             	movsbl %al,%eax
    17a9:	25 ff 00 00 00       	and    $0xff,%eax
    17ae:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    17b4:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    17bb:	0f 84 2e 03 00 00    	je     1aef <printf+0x427>
      break;
    switch(c) {
    17c1:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    17c8:	0f 84 32 01 00 00    	je     1900 <printf+0x238>
    17ce:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    17d5:	0f 8f a1 02 00 00    	jg     1a7c <printf+0x3b4>
    17db:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    17e2:	0f 84 d4 01 00 00    	je     19bc <printf+0x2f4>
    17e8:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    17ef:	0f 8f 87 02 00 00    	jg     1a7c <printf+0x3b4>
    17f5:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    17fc:	0f 84 5b 01 00 00    	je     195d <printf+0x295>
    1802:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    1809:	0f 8f 6d 02 00 00    	jg     1a7c <printf+0x3b4>
    180f:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    1816:	0f 84 87 00 00 00    	je     18a3 <printf+0x1db>
    181c:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    1823:	0f 8f 53 02 00 00    	jg     1a7c <printf+0x3b4>
    1829:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1830:	0f 84 2b 02 00 00    	je     1a61 <printf+0x399>
    1836:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    183d:	0f 85 39 02 00 00    	jne    1a7c <printf+0x3b4>
    case 'c':
      putc(fd, va_arg(ap, int));
    1843:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1849:	83 f8 2f             	cmp    $0x2f,%eax
    184c:	77 23                	ja     1871 <printf+0x1a9>
    184e:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1855:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    185b:	89 d2                	mov    %edx,%edx
    185d:	48 01 d0             	add    %rdx,%rax
    1860:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1866:	83 c2 08             	add    $0x8,%edx
    1869:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    186f:	eb 12                	jmp    1883 <printf+0x1bb>
    1871:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1878:	48 8d 50 08          	lea    0x8(%rax),%rdx
    187c:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1883:	8b 00                	mov    (%rax),%eax
    1885:	0f be d0             	movsbl %al,%edx
    1888:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    188e:	89 d6                	mov    %edx,%esi
    1890:	89 c7                	mov    %eax,%edi
    1892:	48 b8 f2 14 00 00 00 	movabs $0x14f2,%rax
    1899:	00 00 00 
    189c:	ff d0                	call   *%rax
      break;
    189e:	e9 12 02 00 00       	jmp    1ab5 <printf+0x3ed>
    case 'd':
      print_d(fd, va_arg(ap, int));
    18a3:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    18a9:	83 f8 2f             	cmp    $0x2f,%eax
    18ac:	77 23                	ja     18d1 <printf+0x209>
    18ae:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    18b5:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18bb:	89 d2                	mov    %edx,%edx
    18bd:	48 01 d0             	add    %rdx,%rax
    18c0:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18c6:	83 c2 08             	add    $0x8,%edx
    18c9:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    18cf:	eb 12                	jmp    18e3 <printf+0x21b>
    18d1:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    18d8:	48 8d 50 08          	lea    0x8(%rax),%rdx
    18dc:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    18e3:	8b 10                	mov    (%rax),%edx
    18e5:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    18eb:	89 d6                	mov    %edx,%esi
    18ed:	89 c7                	mov    %eax,%edi
    18ef:	48 b8 d4 15 00 00 00 	movabs $0x15d4,%rax
    18f6:	00 00 00 
    18f9:	ff d0                	call   *%rax
      break;
    18fb:	e9 b5 01 00 00       	jmp    1ab5 <printf+0x3ed>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    1900:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1906:	83 f8 2f             	cmp    $0x2f,%eax
    1909:	77 23                	ja     192e <printf+0x266>
    190b:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1912:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1918:	89 d2                	mov    %edx,%edx
    191a:	48 01 d0             	add    %rdx,%rax
    191d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1923:	83 c2 08             	add    $0x8,%edx
    1926:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    192c:	eb 12                	jmp    1940 <printf+0x278>
    192e:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1935:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1939:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1940:	8b 10                	mov    (%rax),%edx
    1942:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1948:	89 d6                	mov    %edx,%esi
    194a:	89 c7                	mov    %eax,%edi
    194c:	48 b8 7b 15 00 00 00 	movabs $0x157b,%rax
    1953:	00 00 00 
    1956:	ff d0                	call   *%rax
      break;
    1958:	e9 58 01 00 00       	jmp    1ab5 <printf+0x3ed>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    195d:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1963:	83 f8 2f             	cmp    $0x2f,%eax
    1966:	77 23                	ja     198b <printf+0x2c3>
    1968:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    196f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1975:	89 d2                	mov    %edx,%edx
    1977:	48 01 d0             	add    %rdx,%rax
    197a:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1980:	83 c2 08             	add    $0x8,%edx
    1983:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1989:	eb 12                	jmp    199d <printf+0x2d5>
    198b:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1992:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1996:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    199d:	48 8b 10             	mov    (%rax),%rdx
    19a0:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    19a6:	48 89 d6             	mov    %rdx,%rsi
    19a9:	89 c7                	mov    %eax,%edi
    19ab:	48 b8 22 15 00 00 00 	movabs $0x1522,%rax
    19b2:	00 00 00 
    19b5:	ff d0                	call   *%rax
      break;
    19b7:	e9 f9 00 00 00       	jmp    1ab5 <printf+0x3ed>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    19bc:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    19c2:	83 f8 2f             	cmp    $0x2f,%eax
    19c5:	77 23                	ja     19ea <printf+0x322>
    19c7:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    19ce:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19d4:	89 d2                	mov    %edx,%edx
    19d6:	48 01 d0             	add    %rdx,%rax
    19d9:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19df:	83 c2 08             	add    $0x8,%edx
    19e2:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    19e8:	eb 12                	jmp    19fc <printf+0x334>
    19ea:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    19f1:	48 8d 50 08          	lea    0x8(%rax),%rdx
    19f5:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    19fc:	48 8b 00             	mov    (%rax),%rax
    19ff:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    1a06:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1a0d:	00 
    1a0e:	75 41                	jne    1a51 <printf+0x389>
        s = "(null)";
    1a10:	48 b8 11 1e 00 00 00 	movabs $0x1e11,%rax
    1a17:	00 00 00 
    1a1a:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1a21:	eb 2e                	jmp    1a51 <printf+0x389>
        putc(fd, *(s++));
    1a23:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1a2a:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1a2e:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1a35:	0f b6 00             	movzbl (%rax),%eax
    1a38:	0f be d0             	movsbl %al,%edx
    1a3b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a41:	89 d6                	mov    %edx,%esi
    1a43:	89 c7                	mov    %eax,%edi
    1a45:	48 b8 f2 14 00 00 00 	movabs $0x14f2,%rax
    1a4c:	00 00 00 
    1a4f:	ff d0                	call   *%rax
      while (*s)
    1a51:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1a58:	0f b6 00             	movzbl (%rax),%eax
    1a5b:	84 c0                	test   %al,%al
    1a5d:	75 c4                	jne    1a23 <printf+0x35b>
      break;
    1a5f:	eb 54                	jmp    1ab5 <printf+0x3ed>
    case '%':
      putc(fd, '%');
    1a61:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a67:	be 25 00 00 00       	mov    $0x25,%esi
    1a6c:	89 c7                	mov    %eax,%edi
    1a6e:	48 b8 f2 14 00 00 00 	movabs $0x14f2,%rax
    1a75:	00 00 00 
    1a78:	ff d0                	call   *%rax
      break;
    1a7a:	eb 39                	jmp    1ab5 <printf+0x3ed>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1a7c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a82:	be 25 00 00 00       	mov    $0x25,%esi
    1a87:	89 c7                	mov    %eax,%edi
    1a89:	48 b8 f2 14 00 00 00 	movabs $0x14f2,%rax
    1a90:	00 00 00 
    1a93:	ff d0                	call   *%rax
      putc(fd, c);
    1a95:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1a9b:	0f be d0             	movsbl %al,%edx
    1a9e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1aa4:	89 d6                	mov    %edx,%esi
    1aa6:	89 c7                	mov    %eax,%edi
    1aa8:	48 b8 f2 14 00 00 00 	movabs $0x14f2,%rax
    1aaf:	00 00 00 
    1ab2:	ff d0                	call   *%rax
      break;
    1ab4:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1ab5:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1abc:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1ac2:	48 63 d0             	movslq %eax,%rdx
    1ac5:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1acc:	48 01 d0             	add    %rdx,%rax
    1acf:	0f b6 00             	movzbl (%rax),%eax
    1ad2:	0f be c0             	movsbl %al,%eax
    1ad5:	25 ff 00 00 00       	and    $0xff,%eax
    1ada:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1ae0:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1ae7:	0f 85 6f fc ff ff    	jne    175c <printf+0x94>
    }
  }
}
    1aed:	eb 01                	jmp    1af0 <printf+0x428>
      break;
    1aef:	90                   	nop
}
    1af0:	90                   	nop
    1af1:	c9                   	leave
    1af2:	c3                   	ret

0000000000001af3 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1af3:	55                   	push   %rbp
    1af4:	48 89 e5             	mov    %rsp,%rbp
    1af7:	48 83 ec 18          	sub    $0x18,%rsp
    1afb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1aff:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1b03:	48 83 e8 10          	sub    $0x10,%rax
    1b07:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1b0b:	48 b8 50 1e 00 00 00 	movabs $0x1e50,%rax
    1b12:	00 00 00 
    1b15:	48 8b 00             	mov    (%rax),%rax
    1b18:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1b1c:	eb 2f                	jmp    1b4d <free+0x5a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1b1e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b22:	48 8b 00             	mov    (%rax),%rax
    1b25:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b29:	72 17                	jb     1b42 <free+0x4f>
    1b2b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b2f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b33:	72 2f                	jb     1b64 <free+0x71>
    1b35:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b39:	48 8b 00             	mov    (%rax),%rax
    1b3c:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1b40:	72 22                	jb     1b64 <free+0x71>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1b42:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b46:	48 8b 00             	mov    (%rax),%rax
    1b49:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1b4d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b51:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b55:	73 c7                	jae    1b1e <free+0x2b>
    1b57:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b5b:	48 8b 00             	mov    (%rax),%rax
    1b5e:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1b62:	73 ba                	jae    1b1e <free+0x2b>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1b64:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b68:	8b 40 08             	mov    0x8(%rax),%eax
    1b6b:	89 c0                	mov    %eax,%eax
    1b6d:	48 c1 e0 04          	shl    $0x4,%rax
    1b71:	48 89 c2             	mov    %rax,%rdx
    1b74:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b78:	48 01 c2             	add    %rax,%rdx
    1b7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b7f:	48 8b 00             	mov    (%rax),%rax
    1b82:	48 39 c2             	cmp    %rax,%rdx
    1b85:	75 2d                	jne    1bb4 <free+0xc1>
    bp->s.size += p->s.ptr->s.size;
    1b87:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b8b:	8b 50 08             	mov    0x8(%rax),%edx
    1b8e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b92:	48 8b 00             	mov    (%rax),%rax
    1b95:	8b 40 08             	mov    0x8(%rax),%eax
    1b98:	01 c2                	add    %eax,%edx
    1b9a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b9e:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1ba1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ba5:	48 8b 00             	mov    (%rax),%rax
    1ba8:	48 8b 10             	mov    (%rax),%rdx
    1bab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1baf:	48 89 10             	mov    %rdx,(%rax)
    1bb2:	eb 0e                	jmp    1bc2 <free+0xcf>
  } else
    bp->s.ptr = p->s.ptr;
    1bb4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bb8:	48 8b 10             	mov    (%rax),%rdx
    1bbb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bbf:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    1bc2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bc6:	8b 40 08             	mov    0x8(%rax),%eax
    1bc9:	89 c0                	mov    %eax,%eax
    1bcb:	48 c1 e0 04          	shl    $0x4,%rax
    1bcf:	48 89 c2             	mov    %rax,%rdx
    1bd2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bd6:	48 01 d0             	add    %rdx,%rax
    1bd9:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1bdd:	75 27                	jne    1c06 <free+0x113>
    p->s.size += bp->s.size;
    1bdf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1be3:	8b 50 08             	mov    0x8(%rax),%edx
    1be6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bea:	8b 40 08             	mov    0x8(%rax),%eax
    1bed:	01 c2                	add    %eax,%edx
    1bef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bf3:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    1bf6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bfa:	48 8b 10             	mov    (%rax),%rdx
    1bfd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c01:	48 89 10             	mov    %rdx,(%rax)
    1c04:	eb 0b                	jmp    1c11 <free+0x11e>
  } else
    p->s.ptr = bp;
    1c06:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c0a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1c0e:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    1c11:	48 ba 50 1e 00 00 00 	movabs $0x1e50,%rdx
    1c18:	00 00 00 
    1c1b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c1f:	48 89 02             	mov    %rax,(%rdx)
}
    1c22:	90                   	nop
    1c23:	c9                   	leave
    1c24:	c3                   	ret

0000000000001c25 <morecore>:

static Header*
morecore(uint nu)
{
    1c25:	55                   	push   %rbp
    1c26:	48 89 e5             	mov    %rsp,%rbp
    1c29:	48 83 ec 20          	sub    $0x20,%rsp
    1c2d:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    1c30:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1c37:	77 07                	ja     1c40 <morecore+0x1b>
    nu = 4096;
    1c39:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    1c40:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1c43:	48 c1 e0 04          	shl    $0x4,%rax
    1c47:	48 89 c7             	mov    %rax,%rdi
    1c4a:	48 b8 b1 14 00 00 00 	movabs $0x14b1,%rax
    1c51:	00 00 00 
    1c54:	ff d0                	call   *%rax
    1c56:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    1c5a:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1c5f:	75 07                	jne    1c68 <morecore+0x43>
    return 0;
    1c61:	b8 00 00 00 00       	mov    $0x0,%eax
    1c66:	eb 36                	jmp    1c9e <morecore+0x79>
  hp = (Header*)p;
    1c68:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c6c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    1c70:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c74:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1c77:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    1c7a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c7e:	48 83 c0 10          	add    $0x10,%rax
    1c82:	48 89 c7             	mov    %rax,%rdi
    1c85:	48 b8 f3 1a 00 00 00 	movabs $0x1af3,%rax
    1c8c:	00 00 00 
    1c8f:	ff d0                	call   *%rax
  return freep;
    1c91:	48 b8 50 1e 00 00 00 	movabs $0x1e50,%rax
    1c98:	00 00 00 
    1c9b:	48 8b 00             	mov    (%rax),%rax
}
    1c9e:	c9                   	leave
    1c9f:	c3                   	ret

0000000000001ca0 <malloc>:

void*
malloc(uint nbytes)
{
    1ca0:	55                   	push   %rbp
    1ca1:	48 89 e5             	mov    %rsp,%rbp
    1ca4:	48 83 ec 30          	sub    $0x30,%rsp
    1ca8:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1cab:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1cae:	48 83 c0 0f          	add    $0xf,%rax
    1cb2:	48 c1 e8 04          	shr    $0x4,%rax
    1cb6:	83 c0 01             	add    $0x1,%eax
    1cb9:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    1cbc:	48 b8 50 1e 00 00 00 	movabs $0x1e50,%rax
    1cc3:	00 00 00 
    1cc6:	48 8b 00             	mov    (%rax),%rax
    1cc9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1ccd:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1cd2:	75 4a                	jne    1d1e <malloc+0x7e>
    base.s.ptr = freep = prevp = &base;
    1cd4:	48 b8 40 1e 00 00 00 	movabs $0x1e40,%rax
    1cdb:	00 00 00 
    1cde:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1ce2:	48 ba 50 1e 00 00 00 	movabs $0x1e50,%rdx
    1ce9:	00 00 00 
    1cec:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cf0:	48 89 02             	mov    %rax,(%rdx)
    1cf3:	48 b8 50 1e 00 00 00 	movabs $0x1e50,%rax
    1cfa:	00 00 00 
    1cfd:	48 8b 00             	mov    (%rax),%rax
    1d00:	48 ba 40 1e 00 00 00 	movabs $0x1e40,%rdx
    1d07:	00 00 00 
    1d0a:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    1d0d:	48 b8 40 1e 00 00 00 	movabs $0x1e40,%rax
    1d14:	00 00 00 
    1d17:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1d1e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d22:	48 8b 00             	mov    (%rax),%rax
    1d25:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1d29:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d2d:	8b 40 08             	mov    0x8(%rax),%eax
    1d30:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1d33:	72 65                	jb     1d9a <malloc+0xfa>
      if(p->s.size == nunits)
    1d35:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d39:	8b 40 08             	mov    0x8(%rax),%eax
    1d3c:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1d3f:	75 10                	jne    1d51 <malloc+0xb1>
        prevp->s.ptr = p->s.ptr;
    1d41:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d45:	48 8b 10             	mov    (%rax),%rdx
    1d48:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d4c:	48 89 10             	mov    %rdx,(%rax)
    1d4f:	eb 2e                	jmp    1d7f <malloc+0xdf>
      else {
        p->s.size -= nunits;
    1d51:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d55:	8b 40 08             	mov    0x8(%rax),%eax
    1d58:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1d5b:	89 c2                	mov    %eax,%edx
    1d5d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d61:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    1d64:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d68:	8b 40 08             	mov    0x8(%rax),%eax
    1d6b:	89 c0                	mov    %eax,%eax
    1d6d:	48 c1 e0 04          	shl    $0x4,%rax
    1d71:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    1d75:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d79:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1d7c:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    1d7f:	48 ba 50 1e 00 00 00 	movabs $0x1e50,%rdx
    1d86:	00 00 00 
    1d89:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d8d:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    1d90:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d94:	48 83 c0 10          	add    $0x10,%rax
    1d98:	eb 4e                	jmp    1de8 <malloc+0x148>
    }
    if(p == freep)
    1d9a:	48 b8 50 1e 00 00 00 	movabs $0x1e50,%rax
    1da1:	00 00 00 
    1da4:	48 8b 00             	mov    (%rax),%rax
    1da7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1dab:	75 23                	jne    1dd0 <malloc+0x130>
      if((p = morecore(nunits)) == 0)
    1dad:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1db0:	89 c7                	mov    %eax,%edi
    1db2:	48 b8 25 1c 00 00 00 	movabs $0x1c25,%rax
    1db9:	00 00 00 
    1dbc:	ff d0                	call   *%rax
    1dbe:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1dc2:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1dc7:	75 07                	jne    1dd0 <malloc+0x130>
        return 0;
    1dc9:	b8 00 00 00 00       	mov    $0x0,%eax
    1dce:	eb 18                	jmp    1de8 <malloc+0x148>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1dd0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1dd4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1dd8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ddc:	48 8b 00             	mov    (%rax),%rax
    1ddf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1de3:	e9 41 ff ff ff       	jmp    1d29 <malloc+0x89>
  }
}
    1de8:	c9                   	leave
    1de9:	c3                   	ret
