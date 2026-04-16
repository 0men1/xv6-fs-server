
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
    1019:	48 b8 28 1e 00 00 00 	movabs $0x1e28,%rax
    1020:	00 00 00 
    1023:	48 89 c6             	mov    %rax,%rsi
    1026:	bf 02 00 00 00       	mov    $0x2,%edi
    102b:	b8 00 00 00 00       	mov    $0x0,%eax
    1030:	48 ba 14 17 00 00 00 	movabs $0x1714,%rdx
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
    1090:	48 b8 3b 1e 00 00 00 	movabs $0x1e3b,%rax
    1097:	00 00 00 
    109a:	48 89 c6             	mov    %rax,%rsi
    109d:	bf 02 00 00 00       	mov    $0x2,%edi
    10a2:	b8 00 00 00 00       	mov    $0x0,%eax
    10a7:	49 b8 14 17 00 00 00 	movabs $0x1714,%r8
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
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    13f6:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    13fd:	49 89 ca             	mov    %rcx,%r10
    1400:	0f 05                	syscall
    1402:	c3                   	ret

0000000000001403 <exit>:
SYSCALL(exit)
    1403:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    140a:	49 89 ca             	mov    %rcx,%r10
    140d:	0f 05                	syscall
    140f:	c3                   	ret

0000000000001410 <wait>:
SYSCALL(wait)
    1410:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    1417:	49 89 ca             	mov    %rcx,%r10
    141a:	0f 05                	syscall
    141c:	c3                   	ret

000000000000141d <pipe>:
SYSCALL(pipe)
    141d:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    1424:	49 89 ca             	mov    %rcx,%r10
    1427:	0f 05                	syscall
    1429:	c3                   	ret

000000000000142a <read>:
SYSCALL(read)
    142a:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    1431:	49 89 ca             	mov    %rcx,%r10
    1434:	0f 05                	syscall
    1436:	c3                   	ret

0000000000001437 <write>:
SYSCALL(write)
    1437:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    143e:	49 89 ca             	mov    %rcx,%r10
    1441:	0f 05                	syscall
    1443:	c3                   	ret

0000000000001444 <close>:
SYSCALL(close)
    1444:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    144b:	49 89 ca             	mov    %rcx,%r10
    144e:	0f 05                	syscall
    1450:	c3                   	ret

0000000000001451 <kill>:
SYSCALL(kill)
    1451:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    1458:	49 89 ca             	mov    %rcx,%r10
    145b:	0f 05                	syscall
    145d:	c3                   	ret

000000000000145e <exec>:
SYSCALL(exec)
    145e:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    1465:	49 89 ca             	mov    %rcx,%r10
    1468:	0f 05                	syscall
    146a:	c3                   	ret

000000000000146b <open>:
SYSCALL(open)
    146b:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    1472:	49 89 ca             	mov    %rcx,%r10
    1475:	0f 05                	syscall
    1477:	c3                   	ret

0000000000001478 <mknod>:
SYSCALL(mknod)
    1478:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    147f:	49 89 ca             	mov    %rcx,%r10
    1482:	0f 05                	syscall
    1484:	c3                   	ret

0000000000001485 <unlink>:
SYSCALL(unlink)
    1485:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    148c:	49 89 ca             	mov    %rcx,%r10
    148f:	0f 05                	syscall
    1491:	c3                   	ret

0000000000001492 <fstat>:
SYSCALL(fstat)
    1492:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    1499:	49 89 ca             	mov    %rcx,%r10
    149c:	0f 05                	syscall
    149e:	c3                   	ret

000000000000149f <link>:
SYSCALL(link)
    149f:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    14a6:	49 89 ca             	mov    %rcx,%r10
    14a9:	0f 05                	syscall
    14ab:	c3                   	ret

00000000000014ac <mkdir>:
SYSCALL(mkdir)
    14ac:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    14b3:	49 89 ca             	mov    %rcx,%r10
    14b6:	0f 05                	syscall
    14b8:	c3                   	ret

00000000000014b9 <chdir>:
SYSCALL(chdir)
    14b9:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    14c0:	49 89 ca             	mov    %rcx,%r10
    14c3:	0f 05                	syscall
    14c5:	c3                   	ret

00000000000014c6 <dup>:
SYSCALL(dup)
    14c6:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    14cd:	49 89 ca             	mov    %rcx,%r10
    14d0:	0f 05                	syscall
    14d2:	c3                   	ret

00000000000014d3 <getpid>:
SYSCALL(getpid)
    14d3:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    14da:	49 89 ca             	mov    %rcx,%r10
    14dd:	0f 05                	syscall
    14df:	c3                   	ret

00000000000014e0 <sbrk>:
SYSCALL(sbrk)
    14e0:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    14e7:	49 89 ca             	mov    %rcx,%r10
    14ea:	0f 05                	syscall
    14ec:	c3                   	ret

00000000000014ed <sleep>:
SYSCALL(sleep)
    14ed:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    14f4:	49 89 ca             	mov    %rcx,%r10
    14f7:	0f 05                	syscall
    14f9:	c3                   	ret

00000000000014fa <uptime>:
SYSCALL(uptime)
    14fa:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    1501:	49 89 ca             	mov    %rcx,%r10
    1504:	0f 05                	syscall
    1506:	c3                   	ret

0000000000001507 <send>:
SYSCALL(send)
    1507:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    150e:	49 89 ca             	mov    %rcx,%r10
    1511:	0f 05                	syscall
    1513:	c3                   	ret

0000000000001514 <recv>:
SYSCALL(recv)
    1514:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    151b:	49 89 ca             	mov    %rcx,%r10
    151e:	0f 05                	syscall
    1520:	c3                   	ret

0000000000001521 <register_fsserver>:
SYSCALL(register_fsserver)
    1521:	48 c7 c0 18 00 00 00 	mov    $0x18,%rax
    1528:	49 89 ca             	mov    %rcx,%r10
    152b:	0f 05                	syscall
    152d:	c3                   	ret

000000000000152e <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    152e:	f3 0f 1e fa          	endbr64
    1532:	55                   	push   %rbp
    1533:	48 89 e5             	mov    %rsp,%rbp
    1536:	48 83 ec 10          	sub    $0x10,%rsp
    153a:	89 7d fc             	mov    %edi,-0x4(%rbp)
    153d:	89 f0                	mov    %esi,%eax
    153f:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    1542:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    1546:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1549:	ba 01 00 00 00       	mov    $0x1,%edx
    154e:	48 89 ce             	mov    %rcx,%rsi
    1551:	89 c7                	mov    %eax,%edi
    1553:	48 b8 37 14 00 00 00 	movabs $0x1437,%rax
    155a:	00 00 00 
    155d:	ff d0                	call   *%rax
}
    155f:	90                   	nop
    1560:	c9                   	leave
    1561:	c3                   	ret

0000000000001562 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    1562:	f3 0f 1e fa          	endbr64
    1566:	55                   	push   %rbp
    1567:	48 89 e5             	mov    %rsp,%rbp
    156a:	48 83 ec 20          	sub    $0x20,%rsp
    156e:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1571:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1575:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    157c:	eb 35                	jmp    15b3 <print_x64+0x51>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    157e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1582:	48 c1 e8 3c          	shr    $0x3c,%rax
    1586:	48 ba 10 1f 00 00 00 	movabs $0x1f10,%rdx
    158d:	00 00 00 
    1590:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1594:	0f be d0             	movsbl %al,%edx
    1597:	8b 45 ec             	mov    -0x14(%rbp),%eax
    159a:	89 d6                	mov    %edx,%esi
    159c:	89 c7                	mov    %eax,%edi
    159e:	48 b8 2e 15 00 00 00 	movabs $0x152e,%rax
    15a5:	00 00 00 
    15a8:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    15aa:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    15ae:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    15b3:	8b 45 fc             	mov    -0x4(%rbp),%eax
    15b6:	83 f8 0f             	cmp    $0xf,%eax
    15b9:	76 c3                	jbe    157e <print_x64+0x1c>
}
    15bb:	90                   	nop
    15bc:	90                   	nop
    15bd:	c9                   	leave
    15be:	c3                   	ret

00000000000015bf <print_x32>:

  static void
print_x32(int fd, uint x)
{
    15bf:	f3 0f 1e fa          	endbr64
    15c3:	55                   	push   %rbp
    15c4:	48 89 e5             	mov    %rsp,%rbp
    15c7:	48 83 ec 20          	sub    $0x20,%rsp
    15cb:	89 7d ec             	mov    %edi,-0x14(%rbp)
    15ce:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    15d1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    15d8:	eb 36                	jmp    1610 <print_x32+0x51>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    15da:	8b 45 e8             	mov    -0x18(%rbp),%eax
    15dd:	c1 e8 1c             	shr    $0x1c,%eax
    15e0:	89 c2                	mov    %eax,%edx
    15e2:	48 b8 10 1f 00 00 00 	movabs $0x1f10,%rax
    15e9:	00 00 00 
    15ec:	89 d2                	mov    %edx,%edx
    15ee:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    15f2:	0f be d0             	movsbl %al,%edx
    15f5:	8b 45 ec             	mov    -0x14(%rbp),%eax
    15f8:	89 d6                	mov    %edx,%esi
    15fa:	89 c7                	mov    %eax,%edi
    15fc:	48 b8 2e 15 00 00 00 	movabs $0x152e,%rax
    1603:	00 00 00 
    1606:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1608:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    160c:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    1610:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1613:	83 f8 07             	cmp    $0x7,%eax
    1616:	76 c2                	jbe    15da <print_x32+0x1b>
}
    1618:	90                   	nop
    1619:	90                   	nop
    161a:	c9                   	leave
    161b:	c3                   	ret

000000000000161c <print_d>:

  static void
print_d(int fd, int v)
{
    161c:	f3 0f 1e fa          	endbr64
    1620:	55                   	push   %rbp
    1621:	48 89 e5             	mov    %rsp,%rbp
    1624:	48 83 ec 30          	sub    $0x30,%rsp
    1628:	89 7d dc             	mov    %edi,-0x24(%rbp)
    162b:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    162e:	8b 45 d8             	mov    -0x28(%rbp),%eax
    1631:	48 98                	cltq
    1633:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    1637:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    163b:	79 04                	jns    1641 <print_d+0x25>
    x = -x;
    163d:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    1641:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    1648:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    164c:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1653:	66 66 66 
    1656:	48 89 c8             	mov    %rcx,%rax
    1659:	48 f7 ea             	imul   %rdx
    165c:	48 c1 fa 02          	sar    $0x2,%rdx
    1660:	48 89 c8             	mov    %rcx,%rax
    1663:	48 c1 f8 3f          	sar    $0x3f,%rax
    1667:	48 29 c2             	sub    %rax,%rdx
    166a:	48 89 d0             	mov    %rdx,%rax
    166d:	48 c1 e0 02          	shl    $0x2,%rax
    1671:	48 01 d0             	add    %rdx,%rax
    1674:	48 01 c0             	add    %rax,%rax
    1677:	48 29 c1             	sub    %rax,%rcx
    167a:	48 89 ca             	mov    %rcx,%rdx
    167d:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1680:	8d 48 01             	lea    0x1(%rax),%ecx
    1683:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    1686:	48 b9 10 1f 00 00 00 	movabs $0x1f10,%rcx
    168d:	00 00 00 
    1690:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    1694:	48 98                	cltq
    1696:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    169a:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    169e:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    16a5:	66 66 66 
    16a8:	48 89 c8             	mov    %rcx,%rax
    16ab:	48 f7 ea             	imul   %rdx
    16ae:	48 89 d0             	mov    %rdx,%rax
    16b1:	48 c1 f8 02          	sar    $0x2,%rax
    16b5:	48 c1 f9 3f          	sar    $0x3f,%rcx
    16b9:	48 89 ca             	mov    %rcx,%rdx
    16bc:	48 29 d0             	sub    %rdx,%rax
    16bf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    16c3:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    16c8:	0f 85 7a ff ff ff    	jne    1648 <print_d+0x2c>

  if (v < 0)
    16ce:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    16d2:	79 32                	jns    1706 <print_d+0xea>
    buf[i++] = '-';
    16d4:	8b 45 f4             	mov    -0xc(%rbp),%eax
    16d7:	8d 50 01             	lea    0x1(%rax),%edx
    16da:	89 55 f4             	mov    %edx,-0xc(%rbp)
    16dd:	48 98                	cltq
    16df:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    16e4:	eb 20                	jmp    1706 <print_d+0xea>
    putc(fd, buf[i]);
    16e6:	8b 45 f4             	mov    -0xc(%rbp),%eax
    16e9:	48 98                	cltq
    16eb:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    16f0:	0f be d0             	movsbl %al,%edx
    16f3:	8b 45 dc             	mov    -0x24(%rbp),%eax
    16f6:	89 d6                	mov    %edx,%esi
    16f8:	89 c7                	mov    %eax,%edi
    16fa:	48 b8 2e 15 00 00 00 	movabs $0x152e,%rax
    1701:	00 00 00 
    1704:	ff d0                	call   *%rax
  while (--i >= 0)
    1706:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    170a:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    170e:	79 d6                	jns    16e6 <print_d+0xca>
}
    1710:	90                   	nop
    1711:	90                   	nop
    1712:	c9                   	leave
    1713:	c3                   	ret

0000000000001714 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    1714:	f3 0f 1e fa          	endbr64
    1718:	55                   	push   %rbp
    1719:	48 89 e5             	mov    %rsp,%rbp
    171c:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    1723:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    1729:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    1730:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    1737:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    173e:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    1745:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    174c:	84 c0                	test   %al,%al
    174e:	74 20                	je     1770 <printf+0x5c>
    1750:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    1754:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    1758:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    175c:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    1760:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    1764:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    1768:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    176c:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    1770:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    1777:	00 00 00 
    177a:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    1781:	00 00 00 
    1784:	48 8d 45 10          	lea    0x10(%rbp),%rax
    1788:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    178f:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    1796:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    179d:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    17a4:	00 00 00 
    17a7:	e9 41 03 00 00       	jmp    1aed <printf+0x3d9>
    if (c != '%') {
    17ac:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    17b3:	74 24                	je     17d9 <printf+0xc5>
      putc(fd, c);
    17b5:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    17bb:	0f be d0             	movsbl %al,%edx
    17be:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    17c4:	89 d6                	mov    %edx,%esi
    17c6:	89 c7                	mov    %eax,%edi
    17c8:	48 b8 2e 15 00 00 00 	movabs $0x152e,%rax
    17cf:	00 00 00 
    17d2:	ff d0                	call   *%rax
      continue;
    17d4:	e9 0d 03 00 00       	jmp    1ae6 <printf+0x3d2>
    }
    c = fmt[++i] & 0xff;
    17d9:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    17e0:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    17e6:	48 63 d0             	movslq %eax,%rdx
    17e9:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    17f0:	48 01 d0             	add    %rdx,%rax
    17f3:	0f b6 00             	movzbl (%rax),%eax
    17f6:	0f be c0             	movsbl %al,%eax
    17f9:	25 ff 00 00 00       	and    $0xff,%eax
    17fe:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    1804:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    180b:	0f 84 0f 03 00 00    	je     1b20 <printf+0x40c>
      break;
    switch(c) {
    1811:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1818:	0f 84 74 02 00 00    	je     1a92 <printf+0x37e>
    181e:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1825:	0f 8c 82 02 00 00    	jl     1aad <printf+0x399>
    182b:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    1832:	0f 8f 75 02 00 00    	jg     1aad <printf+0x399>
    1838:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    183f:	0f 8c 68 02 00 00    	jl     1aad <printf+0x399>
    1845:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    184b:	83 e8 63             	sub    $0x63,%eax
    184e:	83 f8 15             	cmp    $0x15,%eax
    1851:	0f 87 56 02 00 00    	ja     1aad <printf+0x399>
    1857:	89 c0                	mov    %eax,%eax
    1859:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1860:	00 
    1861:	48 b8 58 1e 00 00 00 	movabs $0x1e58,%rax
    1868:	00 00 00 
    186b:	48 01 d0             	add    %rdx,%rax
    186e:	48 8b 00             	mov    (%rax),%rax
    1871:	3e ff e0             	notrack jmp *%rax
    case 'c':
      putc(fd, va_arg(ap, int));
    1874:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    187a:	83 f8 2f             	cmp    $0x2f,%eax
    187d:	77 23                	ja     18a2 <printf+0x18e>
    187f:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1886:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    188c:	89 d2                	mov    %edx,%edx
    188e:	48 01 d0             	add    %rdx,%rax
    1891:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1897:	83 c2 08             	add    $0x8,%edx
    189a:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    18a0:	eb 12                	jmp    18b4 <printf+0x1a0>
    18a2:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    18a9:	48 8d 50 08          	lea    0x8(%rax),%rdx
    18ad:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    18b4:	8b 00                	mov    (%rax),%eax
    18b6:	0f be d0             	movsbl %al,%edx
    18b9:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    18bf:	89 d6                	mov    %edx,%esi
    18c1:	89 c7                	mov    %eax,%edi
    18c3:	48 b8 2e 15 00 00 00 	movabs $0x152e,%rax
    18ca:	00 00 00 
    18cd:	ff d0                	call   *%rax
      break;
    18cf:	e9 12 02 00 00       	jmp    1ae6 <printf+0x3d2>
    case 'd':
      print_d(fd, va_arg(ap, int));
    18d4:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    18da:	83 f8 2f             	cmp    $0x2f,%eax
    18dd:	77 23                	ja     1902 <printf+0x1ee>
    18df:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    18e6:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18ec:	89 d2                	mov    %edx,%edx
    18ee:	48 01 d0             	add    %rdx,%rax
    18f1:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18f7:	83 c2 08             	add    $0x8,%edx
    18fa:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1900:	eb 12                	jmp    1914 <printf+0x200>
    1902:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1909:	48 8d 50 08          	lea    0x8(%rax),%rdx
    190d:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1914:	8b 10                	mov    (%rax),%edx
    1916:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    191c:	89 d6                	mov    %edx,%esi
    191e:	89 c7                	mov    %eax,%edi
    1920:	48 b8 1c 16 00 00 00 	movabs $0x161c,%rax
    1927:	00 00 00 
    192a:	ff d0                	call   *%rax
      break;
    192c:	e9 b5 01 00 00       	jmp    1ae6 <printf+0x3d2>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    1931:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1937:	83 f8 2f             	cmp    $0x2f,%eax
    193a:	77 23                	ja     195f <printf+0x24b>
    193c:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1943:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1949:	89 d2                	mov    %edx,%edx
    194b:	48 01 d0             	add    %rdx,%rax
    194e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1954:	83 c2 08             	add    $0x8,%edx
    1957:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    195d:	eb 12                	jmp    1971 <printf+0x25d>
    195f:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1966:	48 8d 50 08          	lea    0x8(%rax),%rdx
    196a:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1971:	8b 10                	mov    (%rax),%edx
    1973:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1979:	89 d6                	mov    %edx,%esi
    197b:	89 c7                	mov    %eax,%edi
    197d:	48 b8 bf 15 00 00 00 	movabs $0x15bf,%rax
    1984:	00 00 00 
    1987:	ff d0                	call   *%rax
      break;
    1989:	e9 58 01 00 00       	jmp    1ae6 <printf+0x3d2>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    198e:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1994:	83 f8 2f             	cmp    $0x2f,%eax
    1997:	77 23                	ja     19bc <printf+0x2a8>
    1999:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    19a0:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19a6:	89 d2                	mov    %edx,%edx
    19a8:	48 01 d0             	add    %rdx,%rax
    19ab:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19b1:	83 c2 08             	add    $0x8,%edx
    19b4:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    19ba:	eb 12                	jmp    19ce <printf+0x2ba>
    19bc:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    19c3:	48 8d 50 08          	lea    0x8(%rax),%rdx
    19c7:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    19ce:	48 8b 10             	mov    (%rax),%rdx
    19d1:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    19d7:	48 89 d6             	mov    %rdx,%rsi
    19da:	89 c7                	mov    %eax,%edi
    19dc:	48 b8 62 15 00 00 00 	movabs $0x1562,%rax
    19e3:	00 00 00 
    19e6:	ff d0                	call   *%rax
      break;
    19e8:	e9 f9 00 00 00       	jmp    1ae6 <printf+0x3d2>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    19ed:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    19f3:	83 f8 2f             	cmp    $0x2f,%eax
    19f6:	77 23                	ja     1a1b <printf+0x307>
    19f8:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    19ff:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a05:	89 d2                	mov    %edx,%edx
    1a07:	48 01 d0             	add    %rdx,%rax
    1a0a:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a10:	83 c2 08             	add    $0x8,%edx
    1a13:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1a19:	eb 12                	jmp    1a2d <printf+0x319>
    1a1b:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a22:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a26:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a2d:	48 8b 00             	mov    (%rax),%rax
    1a30:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    1a37:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1a3e:	00 
    1a3f:	75 41                	jne    1a82 <printf+0x36e>
        s = "(null)";
    1a41:	48 b8 50 1e 00 00 00 	movabs $0x1e50,%rax
    1a48:	00 00 00 
    1a4b:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1a52:	eb 2e                	jmp    1a82 <printf+0x36e>
        putc(fd, *(s++));
    1a54:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1a5b:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1a5f:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1a66:	0f b6 00             	movzbl (%rax),%eax
    1a69:	0f be d0             	movsbl %al,%edx
    1a6c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a72:	89 d6                	mov    %edx,%esi
    1a74:	89 c7                	mov    %eax,%edi
    1a76:	48 b8 2e 15 00 00 00 	movabs $0x152e,%rax
    1a7d:	00 00 00 
    1a80:	ff d0                	call   *%rax
      while (*s)
    1a82:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1a89:	0f b6 00             	movzbl (%rax),%eax
    1a8c:	84 c0                	test   %al,%al
    1a8e:	75 c4                	jne    1a54 <printf+0x340>
      break;
    1a90:	eb 54                	jmp    1ae6 <printf+0x3d2>
    case '%':
      putc(fd, '%');
    1a92:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a98:	be 25 00 00 00       	mov    $0x25,%esi
    1a9d:	89 c7                	mov    %eax,%edi
    1a9f:	48 b8 2e 15 00 00 00 	movabs $0x152e,%rax
    1aa6:	00 00 00 
    1aa9:	ff d0                	call   *%rax
      break;
    1aab:	eb 39                	jmp    1ae6 <printf+0x3d2>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1aad:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1ab3:	be 25 00 00 00       	mov    $0x25,%esi
    1ab8:	89 c7                	mov    %eax,%edi
    1aba:	48 b8 2e 15 00 00 00 	movabs $0x152e,%rax
    1ac1:	00 00 00 
    1ac4:	ff d0                	call   *%rax
      putc(fd, c);
    1ac6:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1acc:	0f be d0             	movsbl %al,%edx
    1acf:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1ad5:	89 d6                	mov    %edx,%esi
    1ad7:	89 c7                	mov    %eax,%edi
    1ad9:	48 b8 2e 15 00 00 00 	movabs $0x152e,%rax
    1ae0:	00 00 00 
    1ae3:	ff d0                	call   *%rax
      break;
    1ae5:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1ae6:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1aed:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1af3:	48 63 d0             	movslq %eax,%rdx
    1af6:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1afd:	48 01 d0             	add    %rdx,%rax
    1b00:	0f b6 00             	movzbl (%rax),%eax
    1b03:	0f be c0             	movsbl %al,%eax
    1b06:	25 ff 00 00 00       	and    $0xff,%eax
    1b0b:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1b11:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1b18:	0f 85 8e fc ff ff    	jne    17ac <printf+0x98>
    }
  }
}
    1b1e:	eb 01                	jmp    1b21 <printf+0x40d>
      break;
    1b20:	90                   	nop
}
    1b21:	90                   	nop
    1b22:	c9                   	leave
    1b23:	c3                   	ret

0000000000001b24 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1b24:	f3 0f 1e fa          	endbr64
    1b28:	55                   	push   %rbp
    1b29:	48 89 e5             	mov    %rsp,%rbp
    1b2c:	48 83 ec 18          	sub    $0x18,%rsp
    1b30:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1b34:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1b38:	48 83 e8 10          	sub    $0x10,%rax
    1b3c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1b40:	48 b8 40 1f 00 00 00 	movabs $0x1f40,%rax
    1b47:	00 00 00 
    1b4a:	48 8b 00             	mov    (%rax),%rax
    1b4d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1b51:	eb 2f                	jmp    1b82 <free+0x5e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1b53:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b57:	48 8b 00             	mov    (%rax),%rax
    1b5a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b5e:	72 17                	jb     1b77 <free+0x53>
    1b60:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b64:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b68:	72 2f                	jb     1b99 <free+0x75>
    1b6a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b6e:	48 8b 00             	mov    (%rax),%rax
    1b71:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1b75:	72 22                	jb     1b99 <free+0x75>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1b77:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b7b:	48 8b 00             	mov    (%rax),%rax
    1b7e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1b82:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b86:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b8a:	73 c7                	jae    1b53 <free+0x2f>
    1b8c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b90:	48 8b 00             	mov    (%rax),%rax
    1b93:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1b97:	73 ba                	jae    1b53 <free+0x2f>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1b99:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b9d:	8b 40 08             	mov    0x8(%rax),%eax
    1ba0:	89 c0                	mov    %eax,%eax
    1ba2:	48 c1 e0 04          	shl    $0x4,%rax
    1ba6:	48 89 c2             	mov    %rax,%rdx
    1ba9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bad:	48 01 c2             	add    %rax,%rdx
    1bb0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bb4:	48 8b 00             	mov    (%rax),%rax
    1bb7:	48 39 c2             	cmp    %rax,%rdx
    1bba:	75 2d                	jne    1be9 <free+0xc5>
    bp->s.size += p->s.ptr->s.size;
    1bbc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bc0:	8b 50 08             	mov    0x8(%rax),%edx
    1bc3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bc7:	48 8b 00             	mov    (%rax),%rax
    1bca:	8b 40 08             	mov    0x8(%rax),%eax
    1bcd:	01 c2                	add    %eax,%edx
    1bcf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bd3:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1bd6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bda:	48 8b 00             	mov    (%rax),%rax
    1bdd:	48 8b 10             	mov    (%rax),%rdx
    1be0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1be4:	48 89 10             	mov    %rdx,(%rax)
    1be7:	eb 0e                	jmp    1bf7 <free+0xd3>
  } else
    bp->s.ptr = p->s.ptr;
    1be9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bed:	48 8b 10             	mov    (%rax),%rdx
    1bf0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bf4:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    1bf7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bfb:	8b 40 08             	mov    0x8(%rax),%eax
    1bfe:	89 c0                	mov    %eax,%eax
    1c00:	48 c1 e0 04          	shl    $0x4,%rax
    1c04:	48 89 c2             	mov    %rax,%rdx
    1c07:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c0b:	48 01 d0             	add    %rdx,%rax
    1c0e:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1c12:	75 27                	jne    1c3b <free+0x117>
    p->s.size += bp->s.size;
    1c14:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c18:	8b 50 08             	mov    0x8(%rax),%edx
    1c1b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c1f:	8b 40 08             	mov    0x8(%rax),%eax
    1c22:	01 c2                	add    %eax,%edx
    1c24:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c28:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    1c2b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c2f:	48 8b 10             	mov    (%rax),%rdx
    1c32:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c36:	48 89 10             	mov    %rdx,(%rax)
    1c39:	eb 0b                	jmp    1c46 <free+0x122>
  } else
    p->s.ptr = bp;
    1c3b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c3f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1c43:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    1c46:	48 ba 40 1f 00 00 00 	movabs $0x1f40,%rdx
    1c4d:	00 00 00 
    1c50:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c54:	48 89 02             	mov    %rax,(%rdx)
}
    1c57:	90                   	nop
    1c58:	c9                   	leave
    1c59:	c3                   	ret

0000000000001c5a <morecore>:

static Header*
morecore(uint nu)
{
    1c5a:	f3 0f 1e fa          	endbr64
    1c5e:	55                   	push   %rbp
    1c5f:	48 89 e5             	mov    %rsp,%rbp
    1c62:	48 83 ec 20          	sub    $0x20,%rsp
    1c66:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    1c69:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1c70:	77 07                	ja     1c79 <morecore+0x1f>
    nu = 4096;
    1c72:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    1c79:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1c7c:	48 c1 e0 04          	shl    $0x4,%rax
    1c80:	48 89 c7             	mov    %rax,%rdi
    1c83:	48 b8 e0 14 00 00 00 	movabs $0x14e0,%rax
    1c8a:	00 00 00 
    1c8d:	ff d0                	call   *%rax
    1c8f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    1c93:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1c98:	75 07                	jne    1ca1 <morecore+0x47>
    return 0;
    1c9a:	b8 00 00 00 00       	mov    $0x0,%eax
    1c9f:	eb 36                	jmp    1cd7 <morecore+0x7d>
  hp = (Header*)p;
    1ca1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ca5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    1ca9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cad:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1cb0:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    1cb3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cb7:	48 83 c0 10          	add    $0x10,%rax
    1cbb:	48 89 c7             	mov    %rax,%rdi
    1cbe:	48 b8 24 1b 00 00 00 	movabs $0x1b24,%rax
    1cc5:	00 00 00 
    1cc8:	ff d0                	call   *%rax
  return freep;
    1cca:	48 b8 40 1f 00 00 00 	movabs $0x1f40,%rax
    1cd1:	00 00 00 
    1cd4:	48 8b 00             	mov    (%rax),%rax
}
    1cd7:	c9                   	leave
    1cd8:	c3                   	ret

0000000000001cd9 <malloc>:

void*
malloc(uint nbytes)
{
    1cd9:	f3 0f 1e fa          	endbr64
    1cdd:	55                   	push   %rbp
    1cde:	48 89 e5             	mov    %rsp,%rbp
    1ce1:	48 83 ec 30          	sub    $0x30,%rsp
    1ce5:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1ce8:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1ceb:	48 83 c0 0f          	add    $0xf,%rax
    1cef:	48 c1 e8 04          	shr    $0x4,%rax
    1cf3:	83 c0 01             	add    $0x1,%eax
    1cf6:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    1cf9:	48 b8 40 1f 00 00 00 	movabs $0x1f40,%rax
    1d00:	00 00 00 
    1d03:	48 8b 00             	mov    (%rax),%rax
    1d06:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1d0a:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1d0f:	75 4a                	jne    1d5b <malloc+0x82>
    base.s.ptr = freep = prevp = &base;
    1d11:	48 b8 30 1f 00 00 00 	movabs $0x1f30,%rax
    1d18:	00 00 00 
    1d1b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1d1f:	48 ba 40 1f 00 00 00 	movabs $0x1f40,%rdx
    1d26:	00 00 00 
    1d29:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d2d:	48 89 02             	mov    %rax,(%rdx)
    1d30:	48 b8 40 1f 00 00 00 	movabs $0x1f40,%rax
    1d37:	00 00 00 
    1d3a:	48 8b 00             	mov    (%rax),%rax
    1d3d:	48 ba 30 1f 00 00 00 	movabs $0x1f30,%rdx
    1d44:	00 00 00 
    1d47:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    1d4a:	48 b8 30 1f 00 00 00 	movabs $0x1f30,%rax
    1d51:	00 00 00 
    1d54:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1d5b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d5f:	48 8b 00             	mov    (%rax),%rax
    1d62:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1d66:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d6a:	8b 40 08             	mov    0x8(%rax),%eax
    1d6d:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1d70:	72 65                	jb     1dd7 <malloc+0xfe>
      if(p->s.size == nunits)
    1d72:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d76:	8b 40 08             	mov    0x8(%rax),%eax
    1d79:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1d7c:	75 10                	jne    1d8e <malloc+0xb5>
        prevp->s.ptr = p->s.ptr;
    1d7e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d82:	48 8b 10             	mov    (%rax),%rdx
    1d85:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d89:	48 89 10             	mov    %rdx,(%rax)
    1d8c:	eb 2e                	jmp    1dbc <malloc+0xe3>
      else {
        p->s.size -= nunits;
    1d8e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d92:	8b 40 08             	mov    0x8(%rax),%eax
    1d95:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1d98:	89 c2                	mov    %eax,%edx
    1d9a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d9e:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    1da1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1da5:	8b 40 08             	mov    0x8(%rax),%eax
    1da8:	89 c0                	mov    %eax,%eax
    1daa:	48 c1 e0 04          	shl    $0x4,%rax
    1dae:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    1db2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1db6:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1db9:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    1dbc:	48 ba 40 1f 00 00 00 	movabs $0x1f40,%rdx
    1dc3:	00 00 00 
    1dc6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1dca:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    1dcd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1dd1:	48 83 c0 10          	add    $0x10,%rax
    1dd5:	eb 4e                	jmp    1e25 <malloc+0x14c>
    }
    if(p == freep)
    1dd7:	48 b8 40 1f 00 00 00 	movabs $0x1f40,%rax
    1dde:	00 00 00 
    1de1:	48 8b 00             	mov    (%rax),%rax
    1de4:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1de8:	75 23                	jne    1e0d <malloc+0x134>
      if((p = morecore(nunits)) == 0)
    1dea:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1ded:	89 c7                	mov    %eax,%edi
    1def:	48 b8 5a 1c 00 00 00 	movabs $0x1c5a,%rax
    1df6:	00 00 00 
    1df9:	ff d0                	call   *%rax
    1dfb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1dff:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1e04:	75 07                	jne    1e0d <malloc+0x134>
        return 0;
    1e06:	b8 00 00 00 00       	mov    $0x0,%eax
    1e0b:	eb 18                	jmp    1e25 <malloc+0x14c>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1e0d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e11:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1e15:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e19:	48 8b 00             	mov    (%rax),%rax
    1e1c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1e20:	e9 41 ff ff ff       	jmp    1d66 <malloc+0x8d>
  }
}
    1e25:	c9                   	leave
    1e26:	c3                   	ret
