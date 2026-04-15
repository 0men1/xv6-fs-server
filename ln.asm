
_ln:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
    1000:	f3 0f 1e fa          	endbr64
    1004:	55                   	push   %rbp
    1005:	48 89 e5             	mov    %rsp,%rbp
    1008:	48 83 ec 10          	sub    $0x10,%rsp
    100c:	89 7d fc             	mov    %edi,-0x4(%rbp)
    100f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(argc != 3){
    1013:	83 7d fc 03          	cmpl   $0x3,-0x4(%rbp)
    1017:	74 2f                	je     1048 <main+0x48>
    printf(2, "Usage: ln old new\n");
    1019:	48 b8 10 1e 00 00 00 	movabs $0x1e10,%rax
    1020:	00 00 00 
    1023:	48 89 c6             	mov    %rax,%rsi
    1026:	bf 02 00 00 00       	mov    $0x2,%edi
    102b:	b8 00 00 00 00       	mov    $0x0,%eax
    1030:	48 ba 07 17 00 00 00 	movabs $0x1707,%rdx
    1037:	00 00 00 
    103a:	ff d2                	call   *%rdx
    exit();
    103c:	48 b8 03 14 00 00 00 	movabs $0x1403,%rax
    1043:	00 00 00 
    1046:	ff d0                	call   *%rax
  }
  if(link(argv[1], argv[2]) < 0)
    1048:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    104c:	48 83 c0 10          	add    $0x10,%rax
    1050:	48 8b 10             	mov    (%rax),%rdx
    1053:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1057:	48 83 c0 08          	add    $0x8,%rax
    105b:	48 8b 00             	mov    (%rax),%rax
    105e:	48 89 d6             	mov    %rdx,%rsi
    1061:	48 89 c7             	mov    %rax,%rdi
    1064:	48 b8 9f 14 00 00 00 	movabs $0x149f,%rax
    106b:	00 00 00 
    106e:	ff d0                	call   *%rax
    1070:	85 c0                	test   %eax,%eax
    1072:	79 40                	jns    10b4 <main+0xb4>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
    1074:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1078:	48 83 c0 10          	add    $0x10,%rax
    107c:	48 8b 10             	mov    (%rax),%rdx
    107f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1083:	48 83 c0 08          	add    $0x8,%rax
    1087:	48 8b 00             	mov    (%rax),%rax
    108a:	48 89 d1             	mov    %rdx,%rcx
    108d:	48 89 c2             	mov    %rax,%rdx
    1090:	48 b8 23 1e 00 00 00 	movabs $0x1e23,%rax
    1097:	00 00 00 
    109a:	48 89 c6             	mov    %rax,%rsi
    109d:	bf 02 00 00 00       	mov    $0x2,%edi
    10a2:	b8 00 00 00 00       	mov    $0x0,%eax
    10a7:	49 b8 07 17 00 00 00 	movabs $0x1707,%r8
    10ae:	00 00 00 
    10b1:	41 ff d0             	call   *%r8
  exit();
    10b4:	48 b8 03 14 00 00 00 	movabs $0x1403,%rax
    10bb:	00 00 00 
    10be:	ff d0                	call   *%rax

00000000000010c0 <stosb>:
  stosb(dst, c, n);
  return dst;
}

char*
strchr(const char *s, char c)
    10c0:	f3 0f 1e fa          	endbr64
    10c4:	55                   	push   %rbp
    10c5:	48 89 e5             	mov    %rsp,%rbp
    10c8:	48 83 ec 10          	sub    $0x10,%rsp
    10cc:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    10d0:	89 75 f4             	mov    %esi,-0xc(%rbp)
    10d3:	89 55 f0             	mov    %edx,-0x10(%rbp)
{
    10d6:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    10da:	8b 55 f0             	mov    -0x10(%rbp),%edx
    10dd:	8b 45 f4             	mov    -0xc(%rbp),%eax
    10e0:	48 89 ce             	mov    %rcx,%rsi
    10e3:	48 89 f7             	mov    %rsi,%rdi
    10e6:	89 d1                	mov    %edx,%ecx
    10e8:	fc                   	cld
    10e9:	f3 aa                	rep stos %al,%es:(%rdi)
    10eb:	89 ca                	mov    %ecx,%edx
    10ed:	48 89 fe             	mov    %rdi,%rsi
    10f0:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    10f4:	89 55 f0             	mov    %edx,-0x10(%rbp)
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
    10f7:	90                   	nop
    10f8:	c9                   	leave
    10f9:	c3                   	ret

00000000000010fa <strcpy>:
{
    10fa:	f3 0f 1e fa          	endbr64
    10fe:	55                   	push   %rbp
    10ff:	48 89 e5             	mov    %rsp,%rbp
    1102:	48 83 ec 20          	sub    $0x20,%rsp
    1106:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    110a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  os = s;
    110e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1112:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    1116:	90                   	nop
    1117:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    111b:	48 8d 42 01          	lea    0x1(%rdx),%rax
    111f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    1123:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1127:	48 8d 48 01          	lea    0x1(%rax),%rcx
    112b:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    112f:	0f b6 12             	movzbl (%rdx),%edx
    1132:	88 10                	mov    %dl,(%rax)
    1134:	0f b6 00             	movzbl (%rax),%eax
    1137:	84 c0                	test   %al,%al
    1139:	75 dc                	jne    1117 <strcpy+0x1d>
  return os;
    113b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    113f:	c9                   	leave
    1140:	c3                   	ret

0000000000001141 <strcmp>:
{
    1141:	f3 0f 1e fa          	endbr64
    1145:	55                   	push   %rbp
    1146:	48 89 e5             	mov    %rsp,%rbp
    1149:	48 83 ec 10          	sub    $0x10,%rsp
    114d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1151:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    1155:	eb 0a                	jmp    1161 <strcmp+0x20>
    p++, q++;
    1157:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    115c:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    1161:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1165:	0f b6 00             	movzbl (%rax),%eax
    1168:	84 c0                	test   %al,%al
    116a:	74 12                	je     117e <strcmp+0x3d>
    116c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1170:	0f b6 10             	movzbl (%rax),%edx
    1173:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1177:	0f b6 00             	movzbl (%rax),%eax
    117a:	38 c2                	cmp    %al,%dl
    117c:	74 d9                	je     1157 <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
    117e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1182:	0f b6 00             	movzbl (%rax),%eax
    1185:	0f b6 d0             	movzbl %al,%edx
    1188:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    118c:	0f b6 00             	movzbl (%rax),%eax
    118f:	0f b6 c0             	movzbl %al,%eax
    1192:	29 c2                	sub    %eax,%edx
    1194:	89 d0                	mov    %edx,%eax
}
    1196:	c9                   	leave
    1197:	c3                   	ret

0000000000001198 <strlen>:
{
    1198:	f3 0f 1e fa          	endbr64
    119c:	55                   	push   %rbp
    119d:	48 89 e5             	mov    %rsp,%rbp
    11a0:	48 83 ec 18          	sub    $0x18,%rsp
    11a4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  for(n = 0; s[n]; n++)
    11a8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    11af:	eb 04                	jmp    11b5 <strlen+0x1d>
    11b1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    11b5:	8b 45 fc             	mov    -0x4(%rbp),%eax
    11b8:	48 63 d0             	movslq %eax,%rdx
    11bb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    11bf:	48 01 d0             	add    %rdx,%rax
    11c2:	0f b6 00             	movzbl (%rax),%eax
    11c5:	84 c0                	test   %al,%al
    11c7:	75 e8                	jne    11b1 <strlen+0x19>
  return n;
    11c9:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    11cc:	c9                   	leave
    11cd:	c3                   	ret

00000000000011ce <memset>:
{
    11ce:	f3 0f 1e fa          	endbr64
    11d2:	55                   	push   %rbp
    11d3:	48 89 e5             	mov    %rsp,%rbp
    11d6:	48 83 ec 10          	sub    $0x10,%rsp
    11da:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    11de:	89 75 f4             	mov    %esi,-0xc(%rbp)
    11e1:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    11e4:	8b 55 f0             	mov    -0x10(%rbp),%edx
    11e7:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    11ea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    11ee:	89 ce                	mov    %ecx,%esi
    11f0:	48 89 c7             	mov    %rax,%rdi
    11f3:	48 b8 c0 10 00 00 00 	movabs $0x10c0,%rax
    11fa:	00 00 00 
    11fd:	ff d0                	call   *%rax
  return dst;
    11ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    1203:	c9                   	leave
    1204:	c3                   	ret

0000000000001205 <strchr>:
{
    1205:	f3 0f 1e fa          	endbr64
    1209:	55                   	push   %rbp
    120a:	48 89 e5             	mov    %rsp,%rbp
    120d:	48 83 ec 10          	sub    $0x10,%rsp
    1211:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1215:	89 f0                	mov    %esi,%eax
    1217:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    121a:	eb 17                	jmp    1233 <strchr+0x2e>
    if(*s == c)
    121c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1220:	0f b6 00             	movzbl (%rax),%eax
    1223:	38 45 f4             	cmp    %al,-0xc(%rbp)
    1226:	75 06                	jne    122e <strchr+0x29>
      return (char*)s;
    1228:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    122c:	eb 15                	jmp    1243 <strchr+0x3e>
  for(; *s; s++)
    122e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1233:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1237:	0f b6 00             	movzbl (%rax),%eax
    123a:	84 c0                	test   %al,%al
    123c:	75 de                	jne    121c <strchr+0x17>
  return 0;
    123e:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1243:	c9                   	leave
    1244:	c3                   	ret

0000000000001245 <gets>:

char*
gets(char *buf, int max)
{
    1245:	f3 0f 1e fa          	endbr64
    1249:	55                   	push   %rbp
    124a:	48 89 e5             	mov    %rsp,%rbp
    124d:	48 83 ec 20          	sub    $0x20,%rsp
    1251:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1255:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1258:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    125f:	eb 4f                	jmp    12b0 <gets+0x6b>
    cc = read(0, &c, 1);
    1261:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    1265:	ba 01 00 00 00       	mov    $0x1,%edx
    126a:	48 89 c6             	mov    %rax,%rsi
    126d:	bf 00 00 00 00       	mov    $0x0,%edi
    1272:	48 b8 2a 14 00 00 00 	movabs $0x142a,%rax
    1279:	00 00 00 
    127c:	ff d0                	call   *%rax
    127e:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    1281:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1285:	7e 36                	jle    12bd <gets+0x78>
      break;
    buf[i++] = c;
    1287:	8b 45 fc             	mov    -0x4(%rbp),%eax
    128a:	8d 50 01             	lea    0x1(%rax),%edx
    128d:	89 55 fc             	mov    %edx,-0x4(%rbp)
    1290:	48 63 d0             	movslq %eax,%rdx
    1293:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1297:	48 01 c2             	add    %rax,%rdx
    129a:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    129e:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    12a0:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    12a4:	3c 0a                	cmp    $0xa,%al
    12a6:	74 16                	je     12be <gets+0x79>
    12a8:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    12ac:	3c 0d                	cmp    $0xd,%al
    12ae:	74 0e                	je     12be <gets+0x79>
  for(i=0; i+1 < max; ){
    12b0:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12b3:	83 c0 01             	add    $0x1,%eax
    12b6:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    12b9:	7f a6                	jg     1261 <gets+0x1c>
    12bb:	eb 01                	jmp    12be <gets+0x79>
      break;
    12bd:	90                   	nop
      break;
  }
  buf[i] = '\0';
    12be:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12c1:	48 63 d0             	movslq %eax,%rdx
    12c4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12c8:	48 01 d0             	add    %rdx,%rax
    12cb:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    12ce:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    12d2:	c9                   	leave
    12d3:	c3                   	ret

00000000000012d4 <stat>:

int
stat(char *n, struct stat *st)
{
    12d4:	f3 0f 1e fa          	endbr64
    12d8:	55                   	push   %rbp
    12d9:	48 89 e5             	mov    %rsp,%rbp
    12dc:	48 83 ec 20          	sub    $0x20,%rsp
    12e0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    12e4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    12e8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12ec:	be 00 00 00 00       	mov    $0x0,%esi
    12f1:	48 89 c7             	mov    %rax,%rdi
    12f4:	48 b8 6b 14 00 00 00 	movabs $0x146b,%rax
    12fb:	00 00 00 
    12fe:	ff d0                	call   *%rax
    1300:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    1303:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1307:	79 07                	jns    1310 <stat+0x3c>
    return -1;
    1309:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    130e:	eb 2f                	jmp    133f <stat+0x6b>
  r = fstat(fd, st);
    1310:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1314:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1317:	48 89 d6             	mov    %rdx,%rsi
    131a:	89 c7                	mov    %eax,%edi
    131c:	48 b8 92 14 00 00 00 	movabs $0x1492,%rax
    1323:	00 00 00 
    1326:	ff d0                	call   *%rax
    1328:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    132b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    132e:	89 c7                	mov    %eax,%edi
    1330:	48 b8 44 14 00 00 00 	movabs $0x1444,%rax
    1337:	00 00 00 
    133a:	ff d0                	call   *%rax
  return r;
    133c:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    133f:	c9                   	leave
    1340:	c3                   	ret

0000000000001341 <atoi>:

int
atoi(const char *s)
{
    1341:	f3 0f 1e fa          	endbr64
    1345:	55                   	push   %rbp
    1346:	48 89 e5             	mov    %rsp,%rbp
    1349:	48 83 ec 18          	sub    $0x18,%rsp
    134d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    1351:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1358:	eb 28                	jmp    1382 <atoi+0x41>
    n = n*10 + *s++ - '0';
    135a:	8b 55 fc             	mov    -0x4(%rbp),%edx
    135d:	89 d0                	mov    %edx,%eax
    135f:	c1 e0 02             	shl    $0x2,%eax
    1362:	01 d0                	add    %edx,%eax
    1364:	01 c0                	add    %eax,%eax
    1366:	89 c1                	mov    %eax,%ecx
    1368:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    136c:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1370:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    1374:	0f b6 00             	movzbl (%rax),%eax
    1377:	0f be c0             	movsbl %al,%eax
    137a:	01 c8                	add    %ecx,%eax
    137c:	83 e8 30             	sub    $0x30,%eax
    137f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1382:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1386:	0f b6 00             	movzbl (%rax),%eax
    1389:	3c 2f                	cmp    $0x2f,%al
    138b:	7e 0b                	jle    1398 <atoi+0x57>
    138d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1391:	0f b6 00             	movzbl (%rax),%eax
    1394:	3c 39                	cmp    $0x39,%al
    1396:	7e c2                	jle    135a <atoi+0x19>
  return n;
    1398:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    139b:	c9                   	leave
    139c:	c3                   	ret

000000000000139d <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    139d:	f3 0f 1e fa          	endbr64
    13a1:	55                   	push   %rbp
    13a2:	48 89 e5             	mov    %rsp,%rbp
    13a5:	48 83 ec 28          	sub    $0x28,%rsp
    13a9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    13ad:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    13b1:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    13b4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    13b8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    13bc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    13c0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    13c4:	eb 1d                	jmp    13e3 <memmove+0x46>
    *dst++ = *src++;
    13c6:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    13ca:	48 8d 42 01          	lea    0x1(%rdx),%rax
    13ce:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    13d2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13d6:	48 8d 48 01          	lea    0x1(%rax),%rcx
    13da:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    13de:	0f b6 12             	movzbl (%rdx),%edx
    13e1:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    13e3:	8b 45 dc             	mov    -0x24(%rbp),%eax
    13e6:	8d 50 ff             	lea    -0x1(%rax),%edx
    13e9:	89 55 dc             	mov    %edx,-0x24(%rbp)
    13ec:	85 c0                	test   %eax,%eax
    13ee:	7f d6                	jg     13c6 <memmove+0x29>
  return vdst;
    13f0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    13f4:	c9                   	leave
    13f5:	c3                   	ret

00000000000013f6 <fork>:
    13f6:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    13fd:	49 89 ca             	mov    %rcx,%r10
    1400:	0f 05                	syscall
    1402:	c3                   	ret

0000000000001403 <exit>:
    1403:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    140a:	49 89 ca             	mov    %rcx,%r10
    140d:	0f 05                	syscall
    140f:	c3                   	ret

0000000000001410 <wait>:
    1410:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    1417:	49 89 ca             	mov    %rcx,%r10
    141a:	0f 05                	syscall
    141c:	c3                   	ret

000000000000141d <pipe>:
    141d:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    1424:	49 89 ca             	mov    %rcx,%r10
    1427:	0f 05                	syscall
    1429:	c3                   	ret

000000000000142a <read>:
    142a:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    1431:	49 89 ca             	mov    %rcx,%r10
    1434:	0f 05                	syscall
    1436:	c3                   	ret

0000000000001437 <write>:
    1437:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    143e:	49 89 ca             	mov    %rcx,%r10
    1441:	0f 05                	syscall
    1443:	c3                   	ret

0000000000001444 <close>:
    1444:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    144b:	49 89 ca             	mov    %rcx,%r10
    144e:	0f 05                	syscall
    1450:	c3                   	ret

0000000000001451 <kill>:
    1451:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    1458:	49 89 ca             	mov    %rcx,%r10
    145b:	0f 05                	syscall
    145d:	c3                   	ret

000000000000145e <exec>:
    145e:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    1465:	49 89 ca             	mov    %rcx,%r10
    1468:	0f 05                	syscall
    146a:	c3                   	ret

000000000000146b <open>:
    146b:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    1472:	49 89 ca             	mov    %rcx,%r10
    1475:	0f 05                	syscall
    1477:	c3                   	ret

0000000000001478 <mknod>:
    1478:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    147f:	49 89 ca             	mov    %rcx,%r10
    1482:	0f 05                	syscall
    1484:	c3                   	ret

0000000000001485 <unlink>:
    1485:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    148c:	49 89 ca             	mov    %rcx,%r10
    148f:	0f 05                	syscall
    1491:	c3                   	ret

0000000000001492 <fstat>:
    1492:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    1499:	49 89 ca             	mov    %rcx,%r10
    149c:	0f 05                	syscall
    149e:	c3                   	ret

000000000000149f <link>:
    149f:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    14a6:	49 89 ca             	mov    %rcx,%r10
    14a9:	0f 05                	syscall
    14ab:	c3                   	ret

00000000000014ac <mkdir>:
    14ac:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    14b3:	49 89 ca             	mov    %rcx,%r10
    14b6:	0f 05                	syscall
    14b8:	c3                   	ret

00000000000014b9 <chdir>:
    14b9:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    14c0:	49 89 ca             	mov    %rcx,%r10
    14c3:	0f 05                	syscall
    14c5:	c3                   	ret

00000000000014c6 <dup>:
    14c6:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    14cd:	49 89 ca             	mov    %rcx,%r10
    14d0:	0f 05                	syscall
    14d2:	c3                   	ret

00000000000014d3 <getpid>:
    14d3:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    14da:	49 89 ca             	mov    %rcx,%r10
    14dd:	0f 05                	syscall
    14df:	c3                   	ret

00000000000014e0 <sbrk>:
    14e0:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    14e7:	49 89 ca             	mov    %rcx,%r10
    14ea:	0f 05                	syscall
    14ec:	c3                   	ret

00000000000014ed <sleep>:
    14ed:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    14f4:	49 89 ca             	mov    %rcx,%r10
    14f7:	0f 05                	syscall
    14f9:	c3                   	ret

00000000000014fa <uptime>:
    14fa:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    1501:	49 89 ca             	mov    %rcx,%r10
    1504:	0f 05                	syscall
    1506:	c3                   	ret

0000000000001507 <send>:
    1507:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    150e:	49 89 ca             	mov    %rcx,%r10
    1511:	0f 05                	syscall
    1513:	c3                   	ret

0000000000001514 <recv>:
    1514:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    151b:	49 89 ca             	mov    %rcx,%r10
    151e:	0f 05                	syscall
    1520:	c3                   	ret

0000000000001521 <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    1521:	f3 0f 1e fa          	endbr64
    1525:	55                   	push   %rbp
    1526:	48 89 e5             	mov    %rsp,%rbp
    1529:	48 83 ec 10          	sub    $0x10,%rsp
    152d:	89 7d fc             	mov    %edi,-0x4(%rbp)
    1530:	89 f0                	mov    %esi,%eax
    1532:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    1535:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    1539:	8b 45 fc             	mov    -0x4(%rbp),%eax
    153c:	ba 01 00 00 00       	mov    $0x1,%edx
    1541:	48 89 ce             	mov    %rcx,%rsi
    1544:	89 c7                	mov    %eax,%edi
    1546:	48 b8 37 14 00 00 00 	movabs $0x1437,%rax
    154d:	00 00 00 
    1550:	ff d0                	call   *%rax
}
    1552:	90                   	nop
    1553:	c9                   	leave
    1554:	c3                   	ret

0000000000001555 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    1555:	f3 0f 1e fa          	endbr64
    1559:	55                   	push   %rbp
    155a:	48 89 e5             	mov    %rsp,%rbp
    155d:	48 83 ec 20          	sub    $0x20,%rsp
    1561:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1564:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1568:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    156f:	eb 35                	jmp    15a6 <print_x64+0x51>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    1571:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1575:	48 c1 e8 3c          	shr    $0x3c,%rax
    1579:	48 ba f0 1e 00 00 00 	movabs $0x1ef0,%rdx
    1580:	00 00 00 
    1583:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1587:	0f be d0             	movsbl %al,%edx
    158a:	8b 45 ec             	mov    -0x14(%rbp),%eax
    158d:	89 d6                	mov    %edx,%esi
    158f:	89 c7                	mov    %eax,%edi
    1591:	48 b8 21 15 00 00 00 	movabs $0x1521,%rax
    1598:	00 00 00 
    159b:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    159d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    15a1:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    15a6:	8b 45 fc             	mov    -0x4(%rbp),%eax
    15a9:	83 f8 0f             	cmp    $0xf,%eax
    15ac:	76 c3                	jbe    1571 <print_x64+0x1c>
}
    15ae:	90                   	nop
    15af:	90                   	nop
    15b0:	c9                   	leave
    15b1:	c3                   	ret

00000000000015b2 <print_x32>:

  static void
print_x32(int fd, uint x)
{
    15b2:	f3 0f 1e fa          	endbr64
    15b6:	55                   	push   %rbp
    15b7:	48 89 e5             	mov    %rsp,%rbp
    15ba:	48 83 ec 20          	sub    $0x20,%rsp
    15be:	89 7d ec             	mov    %edi,-0x14(%rbp)
    15c1:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    15c4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    15cb:	eb 36                	jmp    1603 <print_x32+0x51>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    15cd:	8b 45 e8             	mov    -0x18(%rbp),%eax
    15d0:	c1 e8 1c             	shr    $0x1c,%eax
    15d3:	89 c2                	mov    %eax,%edx
    15d5:	48 b8 f0 1e 00 00 00 	movabs $0x1ef0,%rax
    15dc:	00 00 00 
    15df:	89 d2                	mov    %edx,%edx
    15e1:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    15e5:	0f be d0             	movsbl %al,%edx
    15e8:	8b 45 ec             	mov    -0x14(%rbp),%eax
    15eb:	89 d6                	mov    %edx,%esi
    15ed:	89 c7                	mov    %eax,%edi
    15ef:	48 b8 21 15 00 00 00 	movabs $0x1521,%rax
    15f6:	00 00 00 
    15f9:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    15fb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    15ff:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    1603:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1606:	83 f8 07             	cmp    $0x7,%eax
    1609:	76 c2                	jbe    15cd <print_x32+0x1b>
}
    160b:	90                   	nop
    160c:	90                   	nop
    160d:	c9                   	leave
    160e:	c3                   	ret

000000000000160f <print_d>:

  static void
print_d(int fd, int v)
{
    160f:	f3 0f 1e fa          	endbr64
    1613:	55                   	push   %rbp
    1614:	48 89 e5             	mov    %rsp,%rbp
    1617:	48 83 ec 30          	sub    $0x30,%rsp
    161b:	89 7d dc             	mov    %edi,-0x24(%rbp)
    161e:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    1621:	8b 45 d8             	mov    -0x28(%rbp),%eax
    1624:	48 98                	cltq
    1626:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    162a:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    162e:	79 04                	jns    1634 <print_d+0x25>
    x = -x;
    1630:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    1634:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    163b:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    163f:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1646:	66 66 66 
    1649:	48 89 c8             	mov    %rcx,%rax
    164c:	48 f7 ea             	imul   %rdx
    164f:	48 c1 fa 02          	sar    $0x2,%rdx
    1653:	48 89 c8             	mov    %rcx,%rax
    1656:	48 c1 f8 3f          	sar    $0x3f,%rax
    165a:	48 29 c2             	sub    %rax,%rdx
    165d:	48 89 d0             	mov    %rdx,%rax
    1660:	48 c1 e0 02          	shl    $0x2,%rax
    1664:	48 01 d0             	add    %rdx,%rax
    1667:	48 01 c0             	add    %rax,%rax
    166a:	48 29 c1             	sub    %rax,%rcx
    166d:	48 89 ca             	mov    %rcx,%rdx
    1670:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1673:	8d 48 01             	lea    0x1(%rax),%ecx
    1676:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    1679:	48 b9 f0 1e 00 00 00 	movabs $0x1ef0,%rcx
    1680:	00 00 00 
    1683:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    1687:	48 98                	cltq
    1689:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    168d:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1691:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1698:	66 66 66 
    169b:	48 89 c8             	mov    %rcx,%rax
    169e:	48 f7 ea             	imul   %rdx
    16a1:	48 89 d0             	mov    %rdx,%rax
    16a4:	48 c1 f8 02          	sar    $0x2,%rax
    16a8:	48 c1 f9 3f          	sar    $0x3f,%rcx
    16ac:	48 89 ca             	mov    %rcx,%rdx
    16af:	48 29 d0             	sub    %rdx,%rax
    16b2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    16b6:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    16bb:	0f 85 7a ff ff ff    	jne    163b <print_d+0x2c>

  if (v < 0)
    16c1:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    16c5:	79 32                	jns    16f9 <print_d+0xea>
    buf[i++] = '-';
    16c7:	8b 45 f4             	mov    -0xc(%rbp),%eax
    16ca:	8d 50 01             	lea    0x1(%rax),%edx
    16cd:	89 55 f4             	mov    %edx,-0xc(%rbp)
    16d0:	48 98                	cltq
    16d2:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    16d7:	eb 20                	jmp    16f9 <print_d+0xea>
    putc(fd, buf[i]);
    16d9:	8b 45 f4             	mov    -0xc(%rbp),%eax
    16dc:	48 98                	cltq
    16de:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    16e3:	0f be d0             	movsbl %al,%edx
    16e6:	8b 45 dc             	mov    -0x24(%rbp),%eax
    16e9:	89 d6                	mov    %edx,%esi
    16eb:	89 c7                	mov    %eax,%edi
    16ed:	48 b8 21 15 00 00 00 	movabs $0x1521,%rax
    16f4:	00 00 00 
    16f7:	ff d0                	call   *%rax
  while (--i >= 0)
    16f9:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    16fd:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1701:	79 d6                	jns    16d9 <print_d+0xca>
}
    1703:	90                   	nop
    1704:	90                   	nop
    1705:	c9                   	leave
    1706:	c3                   	ret

0000000000001707 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    1707:	f3 0f 1e fa          	endbr64
    170b:	55                   	push   %rbp
    170c:	48 89 e5             	mov    %rsp,%rbp
    170f:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    1716:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    171c:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    1723:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    172a:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    1731:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    1738:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    173f:	84 c0                	test   %al,%al
    1741:	74 20                	je     1763 <printf+0x5c>
    1743:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    1747:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    174b:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    174f:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    1753:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    1757:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    175b:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    175f:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    1763:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    176a:	00 00 00 
    176d:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    1774:	00 00 00 
    1777:	48 8d 45 10          	lea    0x10(%rbp),%rax
    177b:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    1782:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    1789:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1790:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    1797:	00 00 00 
    179a:	e9 41 03 00 00       	jmp    1ae0 <printf+0x3d9>
    if (c != '%') {
    179f:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    17a6:	74 24                	je     17cc <printf+0xc5>
      putc(fd, c);
    17a8:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    17ae:	0f be d0             	movsbl %al,%edx
    17b1:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    17b7:	89 d6                	mov    %edx,%esi
    17b9:	89 c7                	mov    %eax,%edi
    17bb:	48 b8 21 15 00 00 00 	movabs $0x1521,%rax
    17c2:	00 00 00 
    17c5:	ff d0                	call   *%rax
      continue;
    17c7:	e9 0d 03 00 00       	jmp    1ad9 <printf+0x3d2>
    }
    c = fmt[++i] & 0xff;
    17cc:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    17d3:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    17d9:	48 63 d0             	movslq %eax,%rdx
    17dc:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    17e3:	48 01 d0             	add    %rdx,%rax
    17e6:	0f b6 00             	movzbl (%rax),%eax
    17e9:	0f be c0             	movsbl %al,%eax
    17ec:	25 ff 00 00 00       	and    $0xff,%eax
    17f1:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    17f7:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    17fe:	0f 84 0f 03 00 00    	je     1b13 <printf+0x40c>
      break;
    switch(c) {
    1804:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    180b:	0f 84 74 02 00 00    	je     1a85 <printf+0x37e>
    1811:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1818:	0f 8c 82 02 00 00    	jl     1aa0 <printf+0x399>
    181e:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    1825:	0f 8f 75 02 00 00    	jg     1aa0 <printf+0x399>
    182b:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    1832:	0f 8c 68 02 00 00    	jl     1aa0 <printf+0x399>
    1838:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    183e:	83 e8 63             	sub    $0x63,%eax
    1841:	83 f8 15             	cmp    $0x15,%eax
    1844:	0f 87 56 02 00 00    	ja     1aa0 <printf+0x399>
    184a:	89 c0                	mov    %eax,%eax
    184c:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1853:	00 
    1854:	48 b8 40 1e 00 00 00 	movabs $0x1e40,%rax
    185b:	00 00 00 
    185e:	48 01 d0             	add    %rdx,%rax
    1861:	48 8b 00             	mov    (%rax),%rax
    1864:	3e ff e0             	notrack jmp *%rax
    case 'c':
      putc(fd, va_arg(ap, int));
    1867:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    186d:	83 f8 2f             	cmp    $0x2f,%eax
    1870:	77 23                	ja     1895 <printf+0x18e>
    1872:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1879:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    187f:	89 d2                	mov    %edx,%edx
    1881:	48 01 d0             	add    %rdx,%rax
    1884:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    188a:	83 c2 08             	add    $0x8,%edx
    188d:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1893:	eb 12                	jmp    18a7 <printf+0x1a0>
    1895:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    189c:	48 8d 50 08          	lea    0x8(%rax),%rdx
    18a0:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    18a7:	8b 00                	mov    (%rax),%eax
    18a9:	0f be d0             	movsbl %al,%edx
    18ac:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    18b2:	89 d6                	mov    %edx,%esi
    18b4:	89 c7                	mov    %eax,%edi
    18b6:	48 b8 21 15 00 00 00 	movabs $0x1521,%rax
    18bd:	00 00 00 
    18c0:	ff d0                	call   *%rax
      break;
    18c2:	e9 12 02 00 00       	jmp    1ad9 <printf+0x3d2>
    case 'd':
      print_d(fd, va_arg(ap, int));
    18c7:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    18cd:	83 f8 2f             	cmp    $0x2f,%eax
    18d0:	77 23                	ja     18f5 <printf+0x1ee>
    18d2:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    18d9:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18df:	89 d2                	mov    %edx,%edx
    18e1:	48 01 d0             	add    %rdx,%rax
    18e4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18ea:	83 c2 08             	add    $0x8,%edx
    18ed:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    18f3:	eb 12                	jmp    1907 <printf+0x200>
    18f5:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    18fc:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1900:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1907:	8b 10                	mov    (%rax),%edx
    1909:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    190f:	89 d6                	mov    %edx,%esi
    1911:	89 c7                	mov    %eax,%edi
    1913:	48 b8 0f 16 00 00 00 	movabs $0x160f,%rax
    191a:	00 00 00 
    191d:	ff d0                	call   *%rax
      break;
    191f:	e9 b5 01 00 00       	jmp    1ad9 <printf+0x3d2>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    1924:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    192a:	83 f8 2f             	cmp    $0x2f,%eax
    192d:	77 23                	ja     1952 <printf+0x24b>
    192f:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1936:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    193c:	89 d2                	mov    %edx,%edx
    193e:	48 01 d0             	add    %rdx,%rax
    1941:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1947:	83 c2 08             	add    $0x8,%edx
    194a:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1950:	eb 12                	jmp    1964 <printf+0x25d>
    1952:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1959:	48 8d 50 08          	lea    0x8(%rax),%rdx
    195d:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1964:	8b 10                	mov    (%rax),%edx
    1966:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    196c:	89 d6                	mov    %edx,%esi
    196e:	89 c7                	mov    %eax,%edi
    1970:	48 b8 b2 15 00 00 00 	movabs $0x15b2,%rax
    1977:	00 00 00 
    197a:	ff d0                	call   *%rax
      break;
    197c:	e9 58 01 00 00       	jmp    1ad9 <printf+0x3d2>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    1981:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1987:	83 f8 2f             	cmp    $0x2f,%eax
    198a:	77 23                	ja     19af <printf+0x2a8>
    198c:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1993:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1999:	89 d2                	mov    %edx,%edx
    199b:	48 01 d0             	add    %rdx,%rax
    199e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19a4:	83 c2 08             	add    $0x8,%edx
    19a7:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    19ad:	eb 12                	jmp    19c1 <printf+0x2ba>
    19af:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    19b6:	48 8d 50 08          	lea    0x8(%rax),%rdx
    19ba:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    19c1:	48 8b 10             	mov    (%rax),%rdx
    19c4:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    19ca:	48 89 d6             	mov    %rdx,%rsi
    19cd:	89 c7                	mov    %eax,%edi
    19cf:	48 b8 55 15 00 00 00 	movabs $0x1555,%rax
    19d6:	00 00 00 
    19d9:	ff d0                	call   *%rax
      break;
    19db:	e9 f9 00 00 00       	jmp    1ad9 <printf+0x3d2>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    19e0:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    19e6:	83 f8 2f             	cmp    $0x2f,%eax
    19e9:	77 23                	ja     1a0e <printf+0x307>
    19eb:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    19f2:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19f8:	89 d2                	mov    %edx,%edx
    19fa:	48 01 d0             	add    %rdx,%rax
    19fd:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a03:	83 c2 08             	add    $0x8,%edx
    1a06:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1a0c:	eb 12                	jmp    1a20 <printf+0x319>
    1a0e:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a15:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a19:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a20:	48 8b 00             	mov    (%rax),%rax
    1a23:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    1a2a:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1a31:	00 
    1a32:	75 41                	jne    1a75 <printf+0x36e>
        s = "(null)";
    1a34:	48 b8 38 1e 00 00 00 	movabs $0x1e38,%rax
    1a3b:	00 00 00 
    1a3e:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1a45:	eb 2e                	jmp    1a75 <printf+0x36e>
        putc(fd, *(s++));
    1a47:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1a4e:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1a52:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1a59:	0f b6 00             	movzbl (%rax),%eax
    1a5c:	0f be d0             	movsbl %al,%edx
    1a5f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a65:	89 d6                	mov    %edx,%esi
    1a67:	89 c7                	mov    %eax,%edi
    1a69:	48 b8 21 15 00 00 00 	movabs $0x1521,%rax
    1a70:	00 00 00 
    1a73:	ff d0                	call   *%rax
      while (*s)
    1a75:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1a7c:	0f b6 00             	movzbl (%rax),%eax
    1a7f:	84 c0                	test   %al,%al
    1a81:	75 c4                	jne    1a47 <printf+0x340>
      break;
    1a83:	eb 54                	jmp    1ad9 <printf+0x3d2>
    case '%':
      putc(fd, '%');
    1a85:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a8b:	be 25 00 00 00       	mov    $0x25,%esi
    1a90:	89 c7                	mov    %eax,%edi
    1a92:	48 b8 21 15 00 00 00 	movabs $0x1521,%rax
    1a99:	00 00 00 
    1a9c:	ff d0                	call   *%rax
      break;
    1a9e:	eb 39                	jmp    1ad9 <printf+0x3d2>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1aa0:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1aa6:	be 25 00 00 00       	mov    $0x25,%esi
    1aab:	89 c7                	mov    %eax,%edi
    1aad:	48 b8 21 15 00 00 00 	movabs $0x1521,%rax
    1ab4:	00 00 00 
    1ab7:	ff d0                	call   *%rax
      putc(fd, c);
    1ab9:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1abf:	0f be d0             	movsbl %al,%edx
    1ac2:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1ac8:	89 d6                	mov    %edx,%esi
    1aca:	89 c7                	mov    %eax,%edi
    1acc:	48 b8 21 15 00 00 00 	movabs $0x1521,%rax
    1ad3:	00 00 00 
    1ad6:	ff d0                	call   *%rax
      break;
    1ad8:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1ad9:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1ae0:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1ae6:	48 63 d0             	movslq %eax,%rdx
    1ae9:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1af0:	48 01 d0             	add    %rdx,%rax
    1af3:	0f b6 00             	movzbl (%rax),%eax
    1af6:	0f be c0             	movsbl %al,%eax
    1af9:	25 ff 00 00 00       	and    $0xff,%eax
    1afe:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1b04:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1b0b:	0f 85 8e fc ff ff    	jne    179f <printf+0x98>
    }
  }
}
    1b11:	eb 01                	jmp    1b14 <printf+0x40d>
      break;
    1b13:	90                   	nop
}
    1b14:	90                   	nop
    1b15:	c9                   	leave
    1b16:	c3                   	ret

0000000000001b17 <free>:
    1b17:	55                   	push   %rbp
    1b18:	48 89 e5             	mov    %rsp,%rbp
    1b1b:	48 83 ec 18          	sub    $0x18,%rsp
    1b1f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1b23:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1b27:	48 83 e8 10          	sub    $0x10,%rax
    1b2b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1b2f:	48 b8 20 1f 00 00 00 	movabs $0x1f20,%rax
    1b36:	00 00 00 
    1b39:	48 8b 00             	mov    (%rax),%rax
    1b3c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1b40:	eb 2f                	jmp    1b71 <free+0x5a>
    1b42:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b46:	48 8b 00             	mov    (%rax),%rax
    1b49:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b4d:	72 17                	jb     1b66 <free+0x4f>
    1b4f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b53:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b57:	72 2f                	jb     1b88 <free+0x71>
    1b59:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b5d:	48 8b 00             	mov    (%rax),%rax
    1b60:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1b64:	72 22                	jb     1b88 <free+0x71>
    1b66:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b6a:	48 8b 00             	mov    (%rax),%rax
    1b6d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1b71:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b75:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b79:	73 c7                	jae    1b42 <free+0x2b>
    1b7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b7f:	48 8b 00             	mov    (%rax),%rax
    1b82:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1b86:	73 ba                	jae    1b42 <free+0x2b>
    1b88:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b8c:	8b 40 08             	mov    0x8(%rax),%eax
    1b8f:	89 c0                	mov    %eax,%eax
    1b91:	48 c1 e0 04          	shl    $0x4,%rax
    1b95:	48 89 c2             	mov    %rax,%rdx
    1b98:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b9c:	48 01 c2             	add    %rax,%rdx
    1b9f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ba3:	48 8b 00             	mov    (%rax),%rax
    1ba6:	48 39 c2             	cmp    %rax,%rdx
    1ba9:	75 2d                	jne    1bd8 <free+0xc1>
    1bab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1baf:	8b 50 08             	mov    0x8(%rax),%edx
    1bb2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bb6:	48 8b 00             	mov    (%rax),%rax
    1bb9:	8b 40 08             	mov    0x8(%rax),%eax
    1bbc:	01 c2                	add    %eax,%edx
    1bbe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bc2:	89 50 08             	mov    %edx,0x8(%rax)
    1bc5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bc9:	48 8b 00             	mov    (%rax),%rax
    1bcc:	48 8b 10             	mov    (%rax),%rdx
    1bcf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bd3:	48 89 10             	mov    %rdx,(%rax)
    1bd6:	eb 0e                	jmp    1be6 <free+0xcf>
    1bd8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bdc:	48 8b 10             	mov    (%rax),%rdx
    1bdf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1be3:	48 89 10             	mov    %rdx,(%rax)
    1be6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bea:	8b 40 08             	mov    0x8(%rax),%eax
    1bed:	89 c0                	mov    %eax,%eax
    1bef:	48 c1 e0 04          	shl    $0x4,%rax
    1bf3:	48 89 c2             	mov    %rax,%rdx
    1bf6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bfa:	48 01 d0             	add    %rdx,%rax
    1bfd:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1c01:	75 27                	jne    1c2a <free+0x113>
    1c03:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c07:	8b 50 08             	mov    0x8(%rax),%edx
    1c0a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c0e:	8b 40 08             	mov    0x8(%rax),%eax
    1c11:	01 c2                	add    %eax,%edx
    1c13:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c17:	89 50 08             	mov    %edx,0x8(%rax)
    1c1a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c1e:	48 8b 10             	mov    (%rax),%rdx
    1c21:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c25:	48 89 10             	mov    %rdx,(%rax)
    1c28:	eb 0b                	jmp    1c35 <free+0x11e>
    1c2a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c2e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1c32:	48 89 10             	mov    %rdx,(%rax)
    1c35:	48 ba 20 1f 00 00 00 	movabs $0x1f20,%rdx
    1c3c:	00 00 00 
    1c3f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c43:	48 89 02             	mov    %rax,(%rdx)
    1c46:	90                   	nop
    1c47:	c9                   	leave
    1c48:	c3                   	ret

0000000000001c49 <morecore>:
    1c49:	55                   	push   %rbp
    1c4a:	48 89 e5             	mov    %rsp,%rbp
    1c4d:	48 83 ec 20          	sub    $0x20,%rsp
    1c51:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1c54:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1c5b:	77 07                	ja     1c64 <morecore+0x1b>
    1c5d:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
    1c64:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1c67:	48 c1 e0 04          	shl    $0x4,%rax
    1c6b:	48 89 c7             	mov    %rax,%rdi
    1c6e:	48 b8 e0 14 00 00 00 	movabs $0x14e0,%rax
    1c75:	00 00 00 
    1c78:	ff d0                	call   *%rax
    1c7a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1c7e:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1c83:	75 07                	jne    1c8c <morecore+0x43>
    1c85:	b8 00 00 00 00       	mov    $0x0,%eax
    1c8a:	eb 36                	jmp    1cc2 <morecore+0x79>
    1c8c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c90:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1c94:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c98:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1c9b:	89 50 08             	mov    %edx,0x8(%rax)
    1c9e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ca2:	48 83 c0 10          	add    $0x10,%rax
    1ca6:	48 89 c7             	mov    %rax,%rdi
    1ca9:	48 b8 17 1b 00 00 00 	movabs $0x1b17,%rax
    1cb0:	00 00 00 
    1cb3:	ff d0                	call   *%rax
    1cb5:	48 b8 20 1f 00 00 00 	movabs $0x1f20,%rax
    1cbc:	00 00 00 
    1cbf:	48 8b 00             	mov    (%rax),%rax
    1cc2:	c9                   	leave
    1cc3:	c3                   	ret

0000000000001cc4 <malloc>:
    1cc4:	55                   	push   %rbp
    1cc5:	48 89 e5             	mov    %rsp,%rbp
    1cc8:	48 83 ec 30          	sub    $0x30,%rsp
    1ccc:	89 7d dc             	mov    %edi,-0x24(%rbp)
    1ccf:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1cd2:	48 83 c0 0f          	add    $0xf,%rax
    1cd6:	48 c1 e8 04          	shr    $0x4,%rax
    1cda:	83 c0 01             	add    $0x1,%eax
    1cdd:	89 45 ec             	mov    %eax,-0x14(%rbp)
    1ce0:	48 b8 20 1f 00 00 00 	movabs $0x1f20,%rax
    1ce7:	00 00 00 
    1cea:	48 8b 00             	mov    (%rax),%rax
    1ced:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1cf1:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1cf6:	75 4a                	jne    1d42 <malloc+0x7e>
    1cf8:	48 b8 10 1f 00 00 00 	movabs $0x1f10,%rax
    1cff:	00 00 00 
    1d02:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1d06:	48 ba 20 1f 00 00 00 	movabs $0x1f20,%rdx
    1d0d:	00 00 00 
    1d10:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d14:	48 89 02             	mov    %rax,(%rdx)
    1d17:	48 b8 20 1f 00 00 00 	movabs $0x1f20,%rax
    1d1e:	00 00 00 
    1d21:	48 8b 00             	mov    (%rax),%rax
    1d24:	48 ba 10 1f 00 00 00 	movabs $0x1f10,%rdx
    1d2b:	00 00 00 
    1d2e:	48 89 02             	mov    %rax,(%rdx)
    1d31:	48 b8 10 1f 00 00 00 	movabs $0x1f10,%rax
    1d38:	00 00 00 
    1d3b:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
    1d42:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d46:	48 8b 00             	mov    (%rax),%rax
    1d49:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1d4d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d51:	8b 40 08             	mov    0x8(%rax),%eax
    1d54:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1d57:	72 65                	jb     1dbe <malloc+0xfa>
    1d59:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d5d:	8b 40 08             	mov    0x8(%rax),%eax
    1d60:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1d63:	75 10                	jne    1d75 <malloc+0xb1>
    1d65:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d69:	48 8b 10             	mov    (%rax),%rdx
    1d6c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d70:	48 89 10             	mov    %rdx,(%rax)
    1d73:	eb 2e                	jmp    1da3 <malloc+0xdf>
    1d75:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d79:	8b 40 08             	mov    0x8(%rax),%eax
    1d7c:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1d7f:	89 c2                	mov    %eax,%edx
    1d81:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d85:	89 50 08             	mov    %edx,0x8(%rax)
    1d88:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d8c:	8b 40 08             	mov    0x8(%rax),%eax
    1d8f:	89 c0                	mov    %eax,%eax
    1d91:	48 c1 e0 04          	shl    $0x4,%rax
    1d95:	48 01 45 f8          	add    %rax,-0x8(%rbp)
    1d99:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d9d:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1da0:	89 50 08             	mov    %edx,0x8(%rax)
    1da3:	48 ba 20 1f 00 00 00 	movabs $0x1f20,%rdx
    1daa:	00 00 00 
    1dad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1db1:	48 89 02             	mov    %rax,(%rdx)
    1db4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1db8:	48 83 c0 10          	add    $0x10,%rax
    1dbc:	eb 4e                	jmp    1e0c <malloc+0x148>
    1dbe:	48 b8 20 1f 00 00 00 	movabs $0x1f20,%rax
    1dc5:	00 00 00 
    1dc8:	48 8b 00             	mov    (%rax),%rax
    1dcb:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1dcf:	75 23                	jne    1df4 <malloc+0x130>
    1dd1:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1dd4:	89 c7                	mov    %eax,%edi
    1dd6:	48 b8 49 1c 00 00 00 	movabs $0x1c49,%rax
    1ddd:	00 00 00 
    1de0:	ff d0                	call   *%rax
    1de2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1de6:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1deb:	75 07                	jne    1df4 <malloc+0x130>
    1ded:	b8 00 00 00 00       	mov    $0x0,%eax
    1df2:	eb 18                	jmp    1e0c <malloc+0x148>
    1df4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1df8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1dfc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e00:	48 8b 00             	mov    (%rax),%rax
    1e03:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1e07:	e9 41 ff ff ff       	jmp    1d4d <malloc+0x89>
    1e0c:	c9                   	leave
    1e0d:	c3                   	ret
