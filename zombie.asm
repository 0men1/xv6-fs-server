
_zombie:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
    1000:	f3 0f 1e fa          	endbr64
    1004:	55                   	push   %rbp
    1005:	48 89 e5             	mov    %rsp,%rbp
  if(fork() > 0)
    1008:	48 b8 6b 13 00 00 00 	movabs $0x136b,%rax
    100f:	00 00 00 
    1012:	ff d0                	call   *%rax
    1014:	85 c0                	test   %eax,%eax
    1016:	7e 11                	jle    1029 <main+0x29>
    sleep(5);  // Let child exit before parent.
    1018:	bf 05 00 00 00       	mov    $0x5,%edi
    101d:	48 b8 62 14 00 00 00 	movabs $0x1462,%rax
    1024:	00 00 00 
    1027:	ff d0                	call   *%rax
  exit();
    1029:	48 b8 78 13 00 00 00 	movabs $0x1378,%rax
    1030:	00 00 00 
    1033:	ff d0                	call   *%rax

0000000000001035 <stosb>:
  stosb(dst, c, n);
  return dst;
}

char*
strchr(const char *s, char c)
    1035:	f3 0f 1e fa          	endbr64
    1039:	55                   	push   %rbp
    103a:	48 89 e5             	mov    %rsp,%rbp
    103d:	48 83 ec 10          	sub    $0x10,%rsp
    1041:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1045:	89 75 f4             	mov    %esi,-0xc(%rbp)
    1048:	89 55 f0             	mov    %edx,-0x10(%rbp)
{
    104b:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    104f:	8b 55 f0             	mov    -0x10(%rbp),%edx
    1052:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1055:	48 89 ce             	mov    %rcx,%rsi
    1058:	48 89 f7             	mov    %rsi,%rdi
    105b:	89 d1                	mov    %edx,%ecx
    105d:	fc                   	cld
    105e:	f3 aa                	rep stos %al,%es:(%rdi)
    1060:	89 ca                	mov    %ecx,%edx
    1062:	48 89 fe             	mov    %rdi,%rsi
    1065:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    1069:	89 55 f0             	mov    %edx,-0x10(%rbp)
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
    106c:	90                   	nop
    106d:	c9                   	leave
    106e:	c3                   	ret

000000000000106f <strcpy>:
{
    106f:	f3 0f 1e fa          	endbr64
    1073:	55                   	push   %rbp
    1074:	48 89 e5             	mov    %rsp,%rbp
    1077:	48 83 ec 20          	sub    $0x20,%rsp
    107b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    107f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  os = s;
    1083:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1087:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    108b:	90                   	nop
    108c:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1090:	48 8d 42 01          	lea    0x1(%rdx),%rax
    1094:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    1098:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    109c:	48 8d 48 01          	lea    0x1(%rax),%rcx
    10a0:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    10a4:	0f b6 12             	movzbl (%rdx),%edx
    10a7:	88 10                	mov    %dl,(%rax)
    10a9:	0f b6 00             	movzbl (%rax),%eax
    10ac:	84 c0                	test   %al,%al
    10ae:	75 dc                	jne    108c <strcpy+0x1d>
  return os;
    10b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    10b4:	c9                   	leave
    10b5:	c3                   	ret

00000000000010b6 <strcmp>:
{
    10b6:	f3 0f 1e fa          	endbr64
    10ba:	55                   	push   %rbp
    10bb:	48 89 e5             	mov    %rsp,%rbp
    10be:	48 83 ec 10          	sub    $0x10,%rsp
    10c2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    10c6:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    10ca:	eb 0a                	jmp    10d6 <strcmp+0x20>
    p++, q++;
    10cc:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    10d1:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    10d6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    10da:	0f b6 00             	movzbl (%rax),%eax
    10dd:	84 c0                	test   %al,%al
    10df:	74 12                	je     10f3 <strcmp+0x3d>
    10e1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    10e5:	0f b6 10             	movzbl (%rax),%edx
    10e8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    10ec:	0f b6 00             	movzbl (%rax),%eax
    10ef:	38 c2                	cmp    %al,%dl
    10f1:	74 d9                	je     10cc <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
    10f3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    10f7:	0f b6 00             	movzbl (%rax),%eax
    10fa:	0f b6 d0             	movzbl %al,%edx
    10fd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1101:	0f b6 00             	movzbl (%rax),%eax
    1104:	0f b6 c0             	movzbl %al,%eax
    1107:	29 c2                	sub    %eax,%edx
    1109:	89 d0                	mov    %edx,%eax
}
    110b:	c9                   	leave
    110c:	c3                   	ret

000000000000110d <strlen>:
{
    110d:	f3 0f 1e fa          	endbr64
    1111:	55                   	push   %rbp
    1112:	48 89 e5             	mov    %rsp,%rbp
    1115:	48 83 ec 18          	sub    $0x18,%rsp
    1119:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  for(n = 0; s[n]; n++)
    111d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1124:	eb 04                	jmp    112a <strlen+0x1d>
    1126:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    112a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    112d:	48 63 d0             	movslq %eax,%rdx
    1130:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1134:	48 01 d0             	add    %rdx,%rax
    1137:	0f b6 00             	movzbl (%rax),%eax
    113a:	84 c0                	test   %al,%al
    113c:	75 e8                	jne    1126 <strlen+0x19>
  return n;
    113e:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    1141:	c9                   	leave
    1142:	c3                   	ret

0000000000001143 <memset>:
{
    1143:	f3 0f 1e fa          	endbr64
    1147:	55                   	push   %rbp
    1148:	48 89 e5             	mov    %rsp,%rbp
    114b:	48 83 ec 10          	sub    $0x10,%rsp
    114f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1153:	89 75 f4             	mov    %esi,-0xc(%rbp)
    1156:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    1159:	8b 55 f0             	mov    -0x10(%rbp),%edx
    115c:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    115f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1163:	89 ce                	mov    %ecx,%esi
    1165:	48 89 c7             	mov    %rax,%rdi
    1168:	48 b8 35 10 00 00 00 	movabs $0x1035,%rax
    116f:	00 00 00 
    1172:	ff d0                	call   *%rax
  return dst;
    1174:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    1178:	c9                   	leave
    1179:	c3                   	ret

000000000000117a <strchr>:
{
    117a:	f3 0f 1e fa          	endbr64
    117e:	55                   	push   %rbp
    117f:	48 89 e5             	mov    %rsp,%rbp
    1182:	48 83 ec 10          	sub    $0x10,%rsp
    1186:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    118a:	89 f0                	mov    %esi,%eax
    118c:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    118f:	eb 17                	jmp    11a8 <strchr+0x2e>
    if(*s == c)
    1191:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1195:	0f b6 00             	movzbl (%rax),%eax
    1198:	38 45 f4             	cmp    %al,-0xc(%rbp)
    119b:	75 06                	jne    11a3 <strchr+0x29>
      return (char*)s;
    119d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    11a1:	eb 15                	jmp    11b8 <strchr+0x3e>
  for(; *s; s++)
    11a3:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    11a8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    11ac:	0f b6 00             	movzbl (%rax),%eax
    11af:	84 c0                	test   %al,%al
    11b1:	75 de                	jne    1191 <strchr+0x17>
  return 0;
    11b3:	b8 00 00 00 00       	mov    $0x0,%eax
}
    11b8:	c9                   	leave
    11b9:	c3                   	ret

00000000000011ba <gets>:

char*
gets(char *buf, int max)
{
    11ba:	f3 0f 1e fa          	endbr64
    11be:	55                   	push   %rbp
    11bf:	48 89 e5             	mov    %rsp,%rbp
    11c2:	48 83 ec 20          	sub    $0x20,%rsp
    11c6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    11ca:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11cd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    11d4:	eb 4f                	jmp    1225 <gets+0x6b>
    cc = read(0, &c, 1);
    11d6:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    11da:	ba 01 00 00 00       	mov    $0x1,%edx
    11df:	48 89 c6             	mov    %rax,%rsi
    11e2:	bf 00 00 00 00       	mov    $0x0,%edi
    11e7:	48 b8 9f 13 00 00 00 	movabs $0x139f,%rax
    11ee:	00 00 00 
    11f1:	ff d0                	call   *%rax
    11f3:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    11f6:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    11fa:	7e 36                	jle    1232 <gets+0x78>
      break;
    buf[i++] = c;
    11fc:	8b 45 fc             	mov    -0x4(%rbp),%eax
    11ff:	8d 50 01             	lea    0x1(%rax),%edx
    1202:	89 55 fc             	mov    %edx,-0x4(%rbp)
    1205:	48 63 d0             	movslq %eax,%rdx
    1208:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    120c:	48 01 c2             	add    %rax,%rdx
    120f:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1213:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    1215:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1219:	3c 0a                	cmp    $0xa,%al
    121b:	74 16                	je     1233 <gets+0x79>
    121d:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1221:	3c 0d                	cmp    $0xd,%al
    1223:	74 0e                	je     1233 <gets+0x79>
  for(i=0; i+1 < max; ){
    1225:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1228:	83 c0 01             	add    $0x1,%eax
    122b:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    122e:	7f a6                	jg     11d6 <gets+0x1c>
    1230:	eb 01                	jmp    1233 <gets+0x79>
      break;
    1232:	90                   	nop
      break;
  }
  buf[i] = '\0';
    1233:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1236:	48 63 d0             	movslq %eax,%rdx
    1239:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    123d:	48 01 d0             	add    %rdx,%rax
    1240:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    1243:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    1247:	c9                   	leave
    1248:	c3                   	ret

0000000000001249 <stat>:

int
stat(char *n, struct stat *st)
{
    1249:	f3 0f 1e fa          	endbr64
    124d:	55                   	push   %rbp
    124e:	48 89 e5             	mov    %rsp,%rbp
    1251:	48 83 ec 20          	sub    $0x20,%rsp
    1255:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1259:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    125d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1261:	be 00 00 00 00       	mov    $0x0,%esi
    1266:	48 89 c7             	mov    %rax,%rdi
    1269:	48 b8 e0 13 00 00 00 	movabs $0x13e0,%rax
    1270:	00 00 00 
    1273:	ff d0                	call   *%rax
    1275:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    1278:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    127c:	79 07                	jns    1285 <stat+0x3c>
    return -1;
    127e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1283:	eb 2f                	jmp    12b4 <stat+0x6b>
  r = fstat(fd, st);
    1285:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1289:	8b 45 fc             	mov    -0x4(%rbp),%eax
    128c:	48 89 d6             	mov    %rdx,%rsi
    128f:	89 c7                	mov    %eax,%edi
    1291:	48 b8 07 14 00 00 00 	movabs $0x1407,%rax
    1298:	00 00 00 
    129b:	ff d0                	call   *%rax
    129d:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    12a0:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12a3:	89 c7                	mov    %eax,%edi
    12a5:	48 b8 b9 13 00 00 00 	movabs $0x13b9,%rax
    12ac:	00 00 00 
    12af:	ff d0                	call   *%rax
  return r;
    12b1:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    12b4:	c9                   	leave
    12b5:	c3                   	ret

00000000000012b6 <atoi>:

int
atoi(const char *s)
{
    12b6:	f3 0f 1e fa          	endbr64
    12ba:	55                   	push   %rbp
    12bb:	48 89 e5             	mov    %rsp,%rbp
    12be:	48 83 ec 18          	sub    $0x18,%rsp
    12c2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    12c6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    12cd:	eb 28                	jmp    12f7 <atoi+0x41>
    n = n*10 + *s++ - '0';
    12cf:	8b 55 fc             	mov    -0x4(%rbp),%edx
    12d2:	89 d0                	mov    %edx,%eax
    12d4:	c1 e0 02             	shl    $0x2,%eax
    12d7:	01 d0                	add    %edx,%eax
    12d9:	01 c0                	add    %eax,%eax
    12db:	89 c1                	mov    %eax,%ecx
    12dd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12e1:	48 8d 50 01          	lea    0x1(%rax),%rdx
    12e5:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    12e9:	0f b6 00             	movzbl (%rax),%eax
    12ec:	0f be c0             	movsbl %al,%eax
    12ef:	01 c8                	add    %ecx,%eax
    12f1:	83 e8 30             	sub    $0x30,%eax
    12f4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    12f7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12fb:	0f b6 00             	movzbl (%rax),%eax
    12fe:	3c 2f                	cmp    $0x2f,%al
    1300:	7e 0b                	jle    130d <atoi+0x57>
    1302:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1306:	0f b6 00             	movzbl (%rax),%eax
    1309:	3c 39                	cmp    $0x39,%al
    130b:	7e c2                	jle    12cf <atoi+0x19>
  return n;
    130d:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    1310:	c9                   	leave
    1311:	c3                   	ret

0000000000001312 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1312:	f3 0f 1e fa          	endbr64
    1316:	55                   	push   %rbp
    1317:	48 89 e5             	mov    %rsp,%rbp
    131a:	48 83 ec 28          	sub    $0x28,%rsp
    131e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1322:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    1326:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    1329:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    132d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    1331:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1335:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    1339:	eb 1d                	jmp    1358 <memmove+0x46>
    *dst++ = *src++;
    133b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    133f:	48 8d 42 01          	lea    0x1(%rdx),%rax
    1343:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1347:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    134b:	48 8d 48 01          	lea    0x1(%rax),%rcx
    134f:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    1353:	0f b6 12             	movzbl (%rdx),%edx
    1356:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    1358:	8b 45 dc             	mov    -0x24(%rbp),%eax
    135b:	8d 50 ff             	lea    -0x1(%rax),%edx
    135e:	89 55 dc             	mov    %edx,-0x24(%rbp)
    1361:	85 c0                	test   %eax,%eax
    1363:	7f d6                	jg     133b <memmove+0x29>
  return vdst;
    1365:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    1369:	c9                   	leave
    136a:	c3                   	ret

000000000000136b <fork>:
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    136b:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    1372:	49 89 ca             	mov    %rcx,%r10
    1375:	0f 05                	syscall
    1377:	c3                   	ret

0000000000001378 <exit>:
SYSCALL(exit)
    1378:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    137f:	49 89 ca             	mov    %rcx,%r10
    1382:	0f 05                	syscall
    1384:	c3                   	ret

0000000000001385 <wait>:
SYSCALL(wait)
    1385:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    138c:	49 89 ca             	mov    %rcx,%r10
    138f:	0f 05                	syscall
    1391:	c3                   	ret

0000000000001392 <pipe>:
SYSCALL(pipe)
    1392:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    1399:	49 89 ca             	mov    %rcx,%r10
    139c:	0f 05                	syscall
    139e:	c3                   	ret

000000000000139f <read>:
SYSCALL(read)
    139f:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    13a6:	49 89 ca             	mov    %rcx,%r10
    13a9:	0f 05                	syscall
    13ab:	c3                   	ret

00000000000013ac <write>:
SYSCALL(write)
    13ac:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    13b3:	49 89 ca             	mov    %rcx,%r10
    13b6:	0f 05                	syscall
    13b8:	c3                   	ret

00000000000013b9 <close>:
SYSCALL(close)
    13b9:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    13c0:	49 89 ca             	mov    %rcx,%r10
    13c3:	0f 05                	syscall
    13c5:	c3                   	ret

00000000000013c6 <kill>:
SYSCALL(kill)
    13c6:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    13cd:	49 89 ca             	mov    %rcx,%r10
    13d0:	0f 05                	syscall
    13d2:	c3                   	ret

00000000000013d3 <exec>:
SYSCALL(exec)
    13d3:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    13da:	49 89 ca             	mov    %rcx,%r10
    13dd:	0f 05                	syscall
    13df:	c3                   	ret

00000000000013e0 <open>:
SYSCALL(open)
    13e0:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    13e7:	49 89 ca             	mov    %rcx,%r10
    13ea:	0f 05                	syscall
    13ec:	c3                   	ret

00000000000013ed <mknod>:
SYSCALL(mknod)
    13ed:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    13f4:	49 89 ca             	mov    %rcx,%r10
    13f7:	0f 05                	syscall
    13f9:	c3                   	ret

00000000000013fa <unlink>:
SYSCALL(unlink)
    13fa:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    1401:	49 89 ca             	mov    %rcx,%r10
    1404:	0f 05                	syscall
    1406:	c3                   	ret

0000000000001407 <fstat>:
SYSCALL(fstat)
    1407:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    140e:	49 89 ca             	mov    %rcx,%r10
    1411:	0f 05                	syscall
    1413:	c3                   	ret

0000000000001414 <link>:
SYSCALL(link)
    1414:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    141b:	49 89 ca             	mov    %rcx,%r10
    141e:	0f 05                	syscall
    1420:	c3                   	ret

0000000000001421 <mkdir>:
SYSCALL(mkdir)
    1421:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    1428:	49 89 ca             	mov    %rcx,%r10
    142b:	0f 05                	syscall
    142d:	c3                   	ret

000000000000142e <chdir>:
SYSCALL(chdir)
    142e:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    1435:	49 89 ca             	mov    %rcx,%r10
    1438:	0f 05                	syscall
    143a:	c3                   	ret

000000000000143b <dup>:
SYSCALL(dup)
    143b:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    1442:	49 89 ca             	mov    %rcx,%r10
    1445:	0f 05                	syscall
    1447:	c3                   	ret

0000000000001448 <getpid>:
SYSCALL(getpid)
    1448:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    144f:	49 89 ca             	mov    %rcx,%r10
    1452:	0f 05                	syscall
    1454:	c3                   	ret

0000000000001455 <sbrk>:
SYSCALL(sbrk)
    1455:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    145c:	49 89 ca             	mov    %rcx,%r10
    145f:	0f 05                	syscall
    1461:	c3                   	ret

0000000000001462 <sleep>:
SYSCALL(sleep)
    1462:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    1469:	49 89 ca             	mov    %rcx,%r10
    146c:	0f 05                	syscall
    146e:	c3                   	ret

000000000000146f <uptime>:
SYSCALL(uptime)
    146f:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    1476:	49 89 ca             	mov    %rcx,%r10
    1479:	0f 05                	syscall
    147b:	c3                   	ret

000000000000147c <send>:
SYSCALL(send)
    147c:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    1483:	49 89 ca             	mov    %rcx,%r10
    1486:	0f 05                	syscall
    1488:	c3                   	ret

0000000000001489 <recv>:
SYSCALL(recv)
    1489:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    1490:	49 89 ca             	mov    %rcx,%r10
    1493:	0f 05                	syscall
    1495:	c3                   	ret

0000000000001496 <register_fsserver>:
SYSCALL(register_fsserver)
    1496:	48 c7 c0 18 00 00 00 	mov    $0x18,%rax
    149d:	49 89 ca             	mov    %rcx,%r10
    14a0:	0f 05                	syscall
    14a2:	c3                   	ret

00000000000014a3 <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    14a3:	f3 0f 1e fa          	endbr64
    14a7:	55                   	push   %rbp
    14a8:	48 89 e5             	mov    %rsp,%rbp
    14ab:	48 83 ec 10          	sub    $0x10,%rsp
    14af:	89 7d fc             	mov    %edi,-0x4(%rbp)
    14b2:	89 f0                	mov    %esi,%eax
    14b4:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    14b7:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    14bb:	8b 45 fc             	mov    -0x4(%rbp),%eax
    14be:	ba 01 00 00 00       	mov    $0x1,%edx
    14c3:	48 89 ce             	mov    %rcx,%rsi
    14c6:	89 c7                	mov    %eax,%edi
    14c8:	48 b8 ac 13 00 00 00 	movabs $0x13ac,%rax
    14cf:	00 00 00 
    14d2:	ff d0                	call   *%rax
}
    14d4:	90                   	nop
    14d5:	c9                   	leave
    14d6:	c3                   	ret

00000000000014d7 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    14d7:	f3 0f 1e fa          	endbr64
    14db:	55                   	push   %rbp
    14dc:	48 89 e5             	mov    %rsp,%rbp
    14df:	48 83 ec 20          	sub    $0x20,%rsp
    14e3:	89 7d ec             	mov    %edi,-0x14(%rbp)
    14e6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    14ea:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    14f1:	eb 35                	jmp    1528 <print_x64+0x51>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    14f3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    14f7:	48 c1 e8 3c          	shr    $0x3c,%rax
    14fb:	48 ba 60 1e 00 00 00 	movabs $0x1e60,%rdx
    1502:	00 00 00 
    1505:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1509:	0f be d0             	movsbl %al,%edx
    150c:	8b 45 ec             	mov    -0x14(%rbp),%eax
    150f:	89 d6                	mov    %edx,%esi
    1511:	89 c7                	mov    %eax,%edi
    1513:	48 b8 a3 14 00 00 00 	movabs $0x14a3,%rax
    151a:	00 00 00 
    151d:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    151f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1523:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    1528:	8b 45 fc             	mov    -0x4(%rbp),%eax
    152b:	83 f8 0f             	cmp    $0xf,%eax
    152e:	76 c3                	jbe    14f3 <print_x64+0x1c>
}
    1530:	90                   	nop
    1531:	90                   	nop
    1532:	c9                   	leave
    1533:	c3                   	ret

0000000000001534 <print_x32>:

  static void
print_x32(int fd, uint x)
{
    1534:	f3 0f 1e fa          	endbr64
    1538:	55                   	push   %rbp
    1539:	48 89 e5             	mov    %rsp,%rbp
    153c:	48 83 ec 20          	sub    $0x20,%rsp
    1540:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1543:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1546:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    154d:	eb 36                	jmp    1585 <print_x32+0x51>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    154f:	8b 45 e8             	mov    -0x18(%rbp),%eax
    1552:	c1 e8 1c             	shr    $0x1c,%eax
    1555:	89 c2                	mov    %eax,%edx
    1557:	48 b8 60 1e 00 00 00 	movabs $0x1e60,%rax
    155e:	00 00 00 
    1561:	89 d2                	mov    %edx,%edx
    1563:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    1567:	0f be d0             	movsbl %al,%edx
    156a:	8b 45 ec             	mov    -0x14(%rbp),%eax
    156d:	89 d6                	mov    %edx,%esi
    156f:	89 c7                	mov    %eax,%edi
    1571:	48 b8 a3 14 00 00 00 	movabs $0x14a3,%rax
    1578:	00 00 00 
    157b:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    157d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1581:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    1585:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1588:	83 f8 07             	cmp    $0x7,%eax
    158b:	76 c2                	jbe    154f <print_x32+0x1b>
}
    158d:	90                   	nop
    158e:	90                   	nop
    158f:	c9                   	leave
    1590:	c3                   	ret

0000000000001591 <print_d>:

  static void
print_d(int fd, int v)
{
    1591:	f3 0f 1e fa          	endbr64
    1595:	55                   	push   %rbp
    1596:	48 89 e5             	mov    %rsp,%rbp
    1599:	48 83 ec 30          	sub    $0x30,%rsp
    159d:	89 7d dc             	mov    %edi,-0x24(%rbp)
    15a0:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    15a3:	8b 45 d8             	mov    -0x28(%rbp),%eax
    15a6:	48 98                	cltq
    15a8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    15ac:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    15b0:	79 04                	jns    15b6 <print_d+0x25>
    x = -x;
    15b2:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    15b6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    15bd:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    15c1:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    15c8:	66 66 66 
    15cb:	48 89 c8             	mov    %rcx,%rax
    15ce:	48 f7 ea             	imul   %rdx
    15d1:	48 c1 fa 02          	sar    $0x2,%rdx
    15d5:	48 89 c8             	mov    %rcx,%rax
    15d8:	48 c1 f8 3f          	sar    $0x3f,%rax
    15dc:	48 29 c2             	sub    %rax,%rdx
    15df:	48 89 d0             	mov    %rdx,%rax
    15e2:	48 c1 e0 02          	shl    $0x2,%rax
    15e6:	48 01 d0             	add    %rdx,%rax
    15e9:	48 01 c0             	add    %rax,%rax
    15ec:	48 29 c1             	sub    %rax,%rcx
    15ef:	48 89 ca             	mov    %rcx,%rdx
    15f2:	8b 45 f4             	mov    -0xc(%rbp),%eax
    15f5:	8d 48 01             	lea    0x1(%rax),%ecx
    15f8:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    15fb:	48 b9 60 1e 00 00 00 	movabs $0x1e60,%rcx
    1602:	00 00 00 
    1605:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    1609:	48 98                	cltq
    160b:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    160f:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1613:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    161a:	66 66 66 
    161d:	48 89 c8             	mov    %rcx,%rax
    1620:	48 f7 ea             	imul   %rdx
    1623:	48 89 d0             	mov    %rdx,%rax
    1626:	48 c1 f8 02          	sar    $0x2,%rax
    162a:	48 c1 f9 3f          	sar    $0x3f,%rcx
    162e:	48 89 ca             	mov    %rcx,%rdx
    1631:	48 29 d0             	sub    %rdx,%rax
    1634:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    1638:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    163d:	0f 85 7a ff ff ff    	jne    15bd <print_d+0x2c>

  if (v < 0)
    1643:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1647:	79 32                	jns    167b <print_d+0xea>
    buf[i++] = '-';
    1649:	8b 45 f4             	mov    -0xc(%rbp),%eax
    164c:	8d 50 01             	lea    0x1(%rax),%edx
    164f:	89 55 f4             	mov    %edx,-0xc(%rbp)
    1652:	48 98                	cltq
    1654:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    1659:	eb 20                	jmp    167b <print_d+0xea>
    putc(fd, buf[i]);
    165b:	8b 45 f4             	mov    -0xc(%rbp),%eax
    165e:	48 98                	cltq
    1660:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    1665:	0f be d0             	movsbl %al,%edx
    1668:	8b 45 dc             	mov    -0x24(%rbp),%eax
    166b:	89 d6                	mov    %edx,%esi
    166d:	89 c7                	mov    %eax,%edi
    166f:	48 b8 a3 14 00 00 00 	movabs $0x14a3,%rax
    1676:	00 00 00 
    1679:	ff d0                	call   *%rax
  while (--i >= 0)
    167b:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    167f:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1683:	79 d6                	jns    165b <print_d+0xca>
}
    1685:	90                   	nop
    1686:	90                   	nop
    1687:	c9                   	leave
    1688:	c3                   	ret

0000000000001689 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    1689:	f3 0f 1e fa          	endbr64
    168d:	55                   	push   %rbp
    168e:	48 89 e5             	mov    %rsp,%rbp
    1691:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    1698:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    169e:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    16a5:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    16ac:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    16b3:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    16ba:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    16c1:	84 c0                	test   %al,%al
    16c3:	74 20                	je     16e5 <printf+0x5c>
    16c5:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    16c9:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    16cd:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    16d1:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    16d5:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    16d9:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    16dd:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    16e1:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    16e5:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    16ec:	00 00 00 
    16ef:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    16f6:	00 00 00 
    16f9:	48 8d 45 10          	lea    0x10(%rbp),%rax
    16fd:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    1704:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    170b:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1712:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    1719:	00 00 00 
    171c:	e9 41 03 00 00       	jmp    1a62 <printf+0x3d9>
    if (c != '%') {
    1721:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1728:	74 24                	je     174e <printf+0xc5>
      putc(fd, c);
    172a:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1730:	0f be d0             	movsbl %al,%edx
    1733:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1739:	89 d6                	mov    %edx,%esi
    173b:	89 c7                	mov    %eax,%edi
    173d:	48 b8 a3 14 00 00 00 	movabs $0x14a3,%rax
    1744:	00 00 00 
    1747:	ff d0                	call   *%rax
      continue;
    1749:	e9 0d 03 00 00       	jmp    1a5b <printf+0x3d2>
    }
    c = fmt[++i] & 0xff;
    174e:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1755:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    175b:	48 63 d0             	movslq %eax,%rdx
    175e:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1765:	48 01 d0             	add    %rdx,%rax
    1768:	0f b6 00             	movzbl (%rax),%eax
    176b:	0f be c0             	movsbl %al,%eax
    176e:	25 ff 00 00 00       	and    $0xff,%eax
    1773:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    1779:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1780:	0f 84 0f 03 00 00    	je     1a95 <printf+0x40c>
      break;
    switch(c) {
    1786:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    178d:	0f 84 74 02 00 00    	je     1a07 <printf+0x37e>
    1793:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    179a:	0f 8c 82 02 00 00    	jl     1a22 <printf+0x399>
    17a0:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    17a7:	0f 8f 75 02 00 00    	jg     1a22 <printf+0x399>
    17ad:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    17b4:	0f 8c 68 02 00 00    	jl     1a22 <printf+0x399>
    17ba:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    17c0:	83 e8 63             	sub    $0x63,%eax
    17c3:	83 f8 15             	cmp    $0x15,%eax
    17c6:	0f 87 56 02 00 00    	ja     1a22 <printf+0x399>
    17cc:	89 c0                	mov    %eax,%eax
    17ce:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    17d5:	00 
    17d6:	48 b8 a8 1d 00 00 00 	movabs $0x1da8,%rax
    17dd:	00 00 00 
    17e0:	48 01 d0             	add    %rdx,%rax
    17e3:	48 8b 00             	mov    (%rax),%rax
    17e6:	3e ff e0             	notrack jmp *%rax
    case 'c':
      putc(fd, va_arg(ap, int));
    17e9:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    17ef:	83 f8 2f             	cmp    $0x2f,%eax
    17f2:	77 23                	ja     1817 <printf+0x18e>
    17f4:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    17fb:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1801:	89 d2                	mov    %edx,%edx
    1803:	48 01 d0             	add    %rdx,%rax
    1806:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    180c:	83 c2 08             	add    $0x8,%edx
    180f:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1815:	eb 12                	jmp    1829 <printf+0x1a0>
    1817:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    181e:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1822:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1829:	8b 00                	mov    (%rax),%eax
    182b:	0f be d0             	movsbl %al,%edx
    182e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1834:	89 d6                	mov    %edx,%esi
    1836:	89 c7                	mov    %eax,%edi
    1838:	48 b8 a3 14 00 00 00 	movabs $0x14a3,%rax
    183f:	00 00 00 
    1842:	ff d0                	call   *%rax
      break;
    1844:	e9 12 02 00 00       	jmp    1a5b <printf+0x3d2>
    case 'd':
      print_d(fd, va_arg(ap, int));
    1849:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    184f:	83 f8 2f             	cmp    $0x2f,%eax
    1852:	77 23                	ja     1877 <printf+0x1ee>
    1854:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    185b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1861:	89 d2                	mov    %edx,%edx
    1863:	48 01 d0             	add    %rdx,%rax
    1866:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    186c:	83 c2 08             	add    $0x8,%edx
    186f:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1875:	eb 12                	jmp    1889 <printf+0x200>
    1877:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    187e:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1882:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1889:	8b 10                	mov    (%rax),%edx
    188b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1891:	89 d6                	mov    %edx,%esi
    1893:	89 c7                	mov    %eax,%edi
    1895:	48 b8 91 15 00 00 00 	movabs $0x1591,%rax
    189c:	00 00 00 
    189f:	ff d0                	call   *%rax
      break;
    18a1:	e9 b5 01 00 00       	jmp    1a5b <printf+0x3d2>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    18a6:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    18ac:	83 f8 2f             	cmp    $0x2f,%eax
    18af:	77 23                	ja     18d4 <printf+0x24b>
    18b1:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    18b8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18be:	89 d2                	mov    %edx,%edx
    18c0:	48 01 d0             	add    %rdx,%rax
    18c3:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18c9:	83 c2 08             	add    $0x8,%edx
    18cc:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    18d2:	eb 12                	jmp    18e6 <printf+0x25d>
    18d4:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    18db:	48 8d 50 08          	lea    0x8(%rax),%rdx
    18df:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    18e6:	8b 10                	mov    (%rax),%edx
    18e8:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    18ee:	89 d6                	mov    %edx,%esi
    18f0:	89 c7                	mov    %eax,%edi
    18f2:	48 b8 34 15 00 00 00 	movabs $0x1534,%rax
    18f9:	00 00 00 
    18fc:	ff d0                	call   *%rax
      break;
    18fe:	e9 58 01 00 00       	jmp    1a5b <printf+0x3d2>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    1903:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1909:	83 f8 2f             	cmp    $0x2f,%eax
    190c:	77 23                	ja     1931 <printf+0x2a8>
    190e:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1915:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    191b:	89 d2                	mov    %edx,%edx
    191d:	48 01 d0             	add    %rdx,%rax
    1920:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1926:	83 c2 08             	add    $0x8,%edx
    1929:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    192f:	eb 12                	jmp    1943 <printf+0x2ba>
    1931:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1938:	48 8d 50 08          	lea    0x8(%rax),%rdx
    193c:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1943:	48 8b 10             	mov    (%rax),%rdx
    1946:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    194c:	48 89 d6             	mov    %rdx,%rsi
    194f:	89 c7                	mov    %eax,%edi
    1951:	48 b8 d7 14 00 00 00 	movabs $0x14d7,%rax
    1958:	00 00 00 
    195b:	ff d0                	call   *%rax
      break;
    195d:	e9 f9 00 00 00       	jmp    1a5b <printf+0x3d2>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    1962:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1968:	83 f8 2f             	cmp    $0x2f,%eax
    196b:	77 23                	ja     1990 <printf+0x307>
    196d:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1974:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    197a:	89 d2                	mov    %edx,%edx
    197c:	48 01 d0             	add    %rdx,%rax
    197f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1985:	83 c2 08             	add    $0x8,%edx
    1988:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    198e:	eb 12                	jmp    19a2 <printf+0x319>
    1990:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1997:	48 8d 50 08          	lea    0x8(%rax),%rdx
    199b:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    19a2:	48 8b 00             	mov    (%rax),%rax
    19a5:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    19ac:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    19b3:	00 
    19b4:	75 41                	jne    19f7 <printf+0x36e>
        s = "(null)";
    19b6:	48 b8 a0 1d 00 00 00 	movabs $0x1da0,%rax
    19bd:	00 00 00 
    19c0:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    19c7:	eb 2e                	jmp    19f7 <printf+0x36e>
        putc(fd, *(s++));
    19c9:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    19d0:	48 8d 50 01          	lea    0x1(%rax),%rdx
    19d4:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    19db:	0f b6 00             	movzbl (%rax),%eax
    19de:	0f be d0             	movsbl %al,%edx
    19e1:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    19e7:	89 d6                	mov    %edx,%esi
    19e9:	89 c7                	mov    %eax,%edi
    19eb:	48 b8 a3 14 00 00 00 	movabs $0x14a3,%rax
    19f2:	00 00 00 
    19f5:	ff d0                	call   *%rax
      while (*s)
    19f7:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    19fe:	0f b6 00             	movzbl (%rax),%eax
    1a01:	84 c0                	test   %al,%al
    1a03:	75 c4                	jne    19c9 <printf+0x340>
      break;
    1a05:	eb 54                	jmp    1a5b <printf+0x3d2>
    case '%':
      putc(fd, '%');
    1a07:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a0d:	be 25 00 00 00       	mov    $0x25,%esi
    1a12:	89 c7                	mov    %eax,%edi
    1a14:	48 b8 a3 14 00 00 00 	movabs $0x14a3,%rax
    1a1b:	00 00 00 
    1a1e:	ff d0                	call   *%rax
      break;
    1a20:	eb 39                	jmp    1a5b <printf+0x3d2>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1a22:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a28:	be 25 00 00 00       	mov    $0x25,%esi
    1a2d:	89 c7                	mov    %eax,%edi
    1a2f:	48 b8 a3 14 00 00 00 	movabs $0x14a3,%rax
    1a36:	00 00 00 
    1a39:	ff d0                	call   *%rax
      putc(fd, c);
    1a3b:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1a41:	0f be d0             	movsbl %al,%edx
    1a44:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a4a:	89 d6                	mov    %edx,%esi
    1a4c:	89 c7                	mov    %eax,%edi
    1a4e:	48 b8 a3 14 00 00 00 	movabs $0x14a3,%rax
    1a55:	00 00 00 
    1a58:	ff d0                	call   *%rax
      break;
    1a5a:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1a5b:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1a62:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1a68:	48 63 d0             	movslq %eax,%rdx
    1a6b:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1a72:	48 01 d0             	add    %rdx,%rax
    1a75:	0f b6 00             	movzbl (%rax),%eax
    1a78:	0f be c0             	movsbl %al,%eax
    1a7b:	25 ff 00 00 00       	and    $0xff,%eax
    1a80:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1a86:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1a8d:	0f 85 8e fc ff ff    	jne    1721 <printf+0x98>
    }
  }
}
    1a93:	eb 01                	jmp    1a96 <printf+0x40d>
      break;
    1a95:	90                   	nop
}
    1a96:	90                   	nop
    1a97:	c9                   	leave
    1a98:	c3                   	ret

0000000000001a99 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1a99:	f3 0f 1e fa          	endbr64
    1a9d:	55                   	push   %rbp
    1a9e:	48 89 e5             	mov    %rsp,%rbp
    1aa1:	48 83 ec 18          	sub    $0x18,%rsp
    1aa5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1aa9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1aad:	48 83 e8 10          	sub    $0x10,%rax
    1ab1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1ab5:	48 b8 90 1e 00 00 00 	movabs $0x1e90,%rax
    1abc:	00 00 00 
    1abf:	48 8b 00             	mov    (%rax),%rax
    1ac2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1ac6:	eb 2f                	jmp    1af7 <free+0x5e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1ac8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1acc:	48 8b 00             	mov    (%rax),%rax
    1acf:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1ad3:	72 17                	jb     1aec <free+0x53>
    1ad5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ad9:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1add:	72 2f                	jb     1b0e <free+0x75>
    1adf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ae3:	48 8b 00             	mov    (%rax),%rax
    1ae6:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1aea:	72 22                	jb     1b0e <free+0x75>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1aec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1af0:	48 8b 00             	mov    (%rax),%rax
    1af3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1af7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1afb:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1aff:	73 c7                	jae    1ac8 <free+0x2f>
    1b01:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b05:	48 8b 00             	mov    (%rax),%rax
    1b08:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1b0c:	73 ba                	jae    1ac8 <free+0x2f>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1b0e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b12:	8b 40 08             	mov    0x8(%rax),%eax
    1b15:	89 c0                	mov    %eax,%eax
    1b17:	48 c1 e0 04          	shl    $0x4,%rax
    1b1b:	48 89 c2             	mov    %rax,%rdx
    1b1e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b22:	48 01 c2             	add    %rax,%rdx
    1b25:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b29:	48 8b 00             	mov    (%rax),%rax
    1b2c:	48 39 c2             	cmp    %rax,%rdx
    1b2f:	75 2d                	jne    1b5e <free+0xc5>
    bp->s.size += p->s.ptr->s.size;
    1b31:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b35:	8b 50 08             	mov    0x8(%rax),%edx
    1b38:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b3c:	48 8b 00             	mov    (%rax),%rax
    1b3f:	8b 40 08             	mov    0x8(%rax),%eax
    1b42:	01 c2                	add    %eax,%edx
    1b44:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b48:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1b4b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b4f:	48 8b 00             	mov    (%rax),%rax
    1b52:	48 8b 10             	mov    (%rax),%rdx
    1b55:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b59:	48 89 10             	mov    %rdx,(%rax)
    1b5c:	eb 0e                	jmp    1b6c <free+0xd3>
  } else
    bp->s.ptr = p->s.ptr;
    1b5e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b62:	48 8b 10             	mov    (%rax),%rdx
    1b65:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b69:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    1b6c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b70:	8b 40 08             	mov    0x8(%rax),%eax
    1b73:	89 c0                	mov    %eax,%eax
    1b75:	48 c1 e0 04          	shl    $0x4,%rax
    1b79:	48 89 c2             	mov    %rax,%rdx
    1b7c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b80:	48 01 d0             	add    %rdx,%rax
    1b83:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1b87:	75 27                	jne    1bb0 <free+0x117>
    p->s.size += bp->s.size;
    1b89:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b8d:	8b 50 08             	mov    0x8(%rax),%edx
    1b90:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b94:	8b 40 08             	mov    0x8(%rax),%eax
    1b97:	01 c2                	add    %eax,%edx
    1b99:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b9d:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    1ba0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ba4:	48 8b 10             	mov    (%rax),%rdx
    1ba7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bab:	48 89 10             	mov    %rdx,(%rax)
    1bae:	eb 0b                	jmp    1bbb <free+0x122>
  } else
    p->s.ptr = bp;
    1bb0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bb4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1bb8:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    1bbb:	48 ba 90 1e 00 00 00 	movabs $0x1e90,%rdx
    1bc2:	00 00 00 
    1bc5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bc9:	48 89 02             	mov    %rax,(%rdx)
}
    1bcc:	90                   	nop
    1bcd:	c9                   	leave
    1bce:	c3                   	ret

0000000000001bcf <morecore>:

static Header*
morecore(uint nu)
{
    1bcf:	f3 0f 1e fa          	endbr64
    1bd3:	55                   	push   %rbp
    1bd4:	48 89 e5             	mov    %rsp,%rbp
    1bd7:	48 83 ec 20          	sub    $0x20,%rsp
    1bdb:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    1bde:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1be5:	77 07                	ja     1bee <morecore+0x1f>
    nu = 4096;
    1be7:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    1bee:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1bf1:	48 c1 e0 04          	shl    $0x4,%rax
    1bf5:	48 89 c7             	mov    %rax,%rdi
    1bf8:	48 b8 55 14 00 00 00 	movabs $0x1455,%rax
    1bff:	00 00 00 
    1c02:	ff d0                	call   *%rax
    1c04:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    1c08:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1c0d:	75 07                	jne    1c16 <morecore+0x47>
    return 0;
    1c0f:	b8 00 00 00 00       	mov    $0x0,%eax
    1c14:	eb 36                	jmp    1c4c <morecore+0x7d>
  hp = (Header*)p;
    1c16:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c1a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    1c1e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c22:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1c25:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    1c28:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c2c:	48 83 c0 10          	add    $0x10,%rax
    1c30:	48 89 c7             	mov    %rax,%rdi
    1c33:	48 b8 99 1a 00 00 00 	movabs $0x1a99,%rax
    1c3a:	00 00 00 
    1c3d:	ff d0                	call   *%rax
  return freep;
    1c3f:	48 b8 90 1e 00 00 00 	movabs $0x1e90,%rax
    1c46:	00 00 00 
    1c49:	48 8b 00             	mov    (%rax),%rax
}
    1c4c:	c9                   	leave
    1c4d:	c3                   	ret

0000000000001c4e <malloc>:

void*
malloc(uint nbytes)
{
    1c4e:	f3 0f 1e fa          	endbr64
    1c52:	55                   	push   %rbp
    1c53:	48 89 e5             	mov    %rsp,%rbp
    1c56:	48 83 ec 30          	sub    $0x30,%rsp
    1c5a:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1c5d:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1c60:	48 83 c0 0f          	add    $0xf,%rax
    1c64:	48 c1 e8 04          	shr    $0x4,%rax
    1c68:	83 c0 01             	add    $0x1,%eax
    1c6b:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    1c6e:	48 b8 90 1e 00 00 00 	movabs $0x1e90,%rax
    1c75:	00 00 00 
    1c78:	48 8b 00             	mov    (%rax),%rax
    1c7b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1c7f:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1c84:	75 4a                	jne    1cd0 <malloc+0x82>
    base.s.ptr = freep = prevp = &base;
    1c86:	48 b8 80 1e 00 00 00 	movabs $0x1e80,%rax
    1c8d:	00 00 00 
    1c90:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1c94:	48 ba 90 1e 00 00 00 	movabs $0x1e90,%rdx
    1c9b:	00 00 00 
    1c9e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ca2:	48 89 02             	mov    %rax,(%rdx)
    1ca5:	48 b8 90 1e 00 00 00 	movabs $0x1e90,%rax
    1cac:	00 00 00 
    1caf:	48 8b 00             	mov    (%rax),%rax
    1cb2:	48 ba 80 1e 00 00 00 	movabs $0x1e80,%rdx
    1cb9:	00 00 00 
    1cbc:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    1cbf:	48 b8 80 1e 00 00 00 	movabs $0x1e80,%rax
    1cc6:	00 00 00 
    1cc9:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1cd0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cd4:	48 8b 00             	mov    (%rax),%rax
    1cd7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1cdb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cdf:	8b 40 08             	mov    0x8(%rax),%eax
    1ce2:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1ce5:	72 65                	jb     1d4c <malloc+0xfe>
      if(p->s.size == nunits)
    1ce7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ceb:	8b 40 08             	mov    0x8(%rax),%eax
    1cee:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1cf1:	75 10                	jne    1d03 <malloc+0xb5>
        prevp->s.ptr = p->s.ptr;
    1cf3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cf7:	48 8b 10             	mov    (%rax),%rdx
    1cfa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cfe:	48 89 10             	mov    %rdx,(%rax)
    1d01:	eb 2e                	jmp    1d31 <malloc+0xe3>
      else {
        p->s.size -= nunits;
    1d03:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d07:	8b 40 08             	mov    0x8(%rax),%eax
    1d0a:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1d0d:	89 c2                	mov    %eax,%edx
    1d0f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d13:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    1d16:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d1a:	8b 40 08             	mov    0x8(%rax),%eax
    1d1d:	89 c0                	mov    %eax,%eax
    1d1f:	48 c1 e0 04          	shl    $0x4,%rax
    1d23:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    1d27:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d2b:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1d2e:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    1d31:	48 ba 90 1e 00 00 00 	movabs $0x1e90,%rdx
    1d38:	00 00 00 
    1d3b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d3f:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    1d42:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d46:	48 83 c0 10          	add    $0x10,%rax
    1d4a:	eb 4e                	jmp    1d9a <malloc+0x14c>
    }
    if(p == freep)
    1d4c:	48 b8 90 1e 00 00 00 	movabs $0x1e90,%rax
    1d53:	00 00 00 
    1d56:	48 8b 00             	mov    (%rax),%rax
    1d59:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1d5d:	75 23                	jne    1d82 <malloc+0x134>
      if((p = morecore(nunits)) == 0)
    1d5f:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1d62:	89 c7                	mov    %eax,%edi
    1d64:	48 b8 cf 1b 00 00 00 	movabs $0x1bcf,%rax
    1d6b:	00 00 00 
    1d6e:	ff d0                	call   *%rax
    1d70:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1d74:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1d79:	75 07                	jne    1d82 <malloc+0x134>
        return 0;
    1d7b:	b8 00 00 00 00       	mov    $0x0,%eax
    1d80:	eb 18                	jmp    1d9a <malloc+0x14c>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1d82:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d86:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1d8a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d8e:	48 8b 00             	mov    (%rax),%rax
    1d91:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1d95:	e9 41 ff ff ff       	jmp    1cdb <malloc+0x8d>
  }
}
    1d9a:	c9                   	leave
    1d9b:	c3                   	ret
