
_zombie:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <main>:
    1000:	55                   	push   %rbp
    1001:	48 89 e5             	mov    %rsp,%rbp
    1004:	48 b8 67 13 00 00 00 	movabs $0x1367,%rax
    100b:	00 00 00 
    100e:	ff d0                	call   *%rax
    1010:	85 c0                	test   %eax,%eax
    1012:	7e 11                	jle    1025 <main+0x25>
    1014:	bf 05 00 00 00       	mov    $0x5,%edi
    1019:	48 b8 5e 14 00 00 00 	movabs $0x145e,%rax
    1020:	00 00 00 
    1023:	ff d0                	call   *%rax
    1025:	48 b8 74 13 00 00 00 	movabs $0x1374,%rax
    102c:	00 00 00 
    102f:	ff d0                	call   *%rax

0000000000001031 <stosb>:
  stosb(dst, c, n);
  return dst;
}

char*
strchr(const char *s, char c)
    1031:	f3 0f 1e fa          	endbr64
    1035:	55                   	push   %rbp
    1036:	48 89 e5             	mov    %rsp,%rbp
    1039:	48 83 ec 10          	sub    $0x10,%rsp
    103d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1041:	89 75 f4             	mov    %esi,-0xc(%rbp)
    1044:	89 55 f0             	mov    %edx,-0x10(%rbp)
{
    1047:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    104b:	8b 55 f0             	mov    -0x10(%rbp),%edx
    104e:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1051:	48 89 ce             	mov    %rcx,%rsi
    1054:	48 89 f7             	mov    %rsi,%rdi
    1057:	89 d1                	mov    %edx,%ecx
    1059:	fc                   	cld
    105a:	f3 aa                	rep stos %al,%es:(%rdi)
    105c:	89 ca                	mov    %ecx,%edx
    105e:	48 89 fe             	mov    %rdi,%rsi
    1061:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    1065:	89 55 f0             	mov    %edx,-0x10(%rbp)
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
    1068:	90                   	nop
    1069:	c9                   	leave
    106a:	c3                   	ret

000000000000106b <strcpy>:
{
    106b:	f3 0f 1e fa          	endbr64
    106f:	55                   	push   %rbp
    1070:	48 89 e5             	mov    %rsp,%rbp
    1073:	48 83 ec 20          	sub    $0x20,%rsp
    1077:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    107b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  os = s;
    107f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1083:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    1087:	90                   	nop
    1088:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    108c:	48 8d 42 01          	lea    0x1(%rdx),%rax
    1090:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    1094:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1098:	48 8d 48 01          	lea    0x1(%rax),%rcx
    109c:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    10a0:	0f b6 12             	movzbl (%rdx),%edx
    10a3:	88 10                	mov    %dl,(%rax)
    10a5:	0f b6 00             	movzbl (%rax),%eax
    10a8:	84 c0                	test   %al,%al
    10aa:	75 dc                	jne    1088 <strcpy+0x1d>
  return os;
    10ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    10b0:	c9                   	leave
    10b1:	c3                   	ret

00000000000010b2 <strcmp>:
{
    10b2:	f3 0f 1e fa          	endbr64
    10b6:	55                   	push   %rbp
    10b7:	48 89 e5             	mov    %rsp,%rbp
    10ba:	48 83 ec 10          	sub    $0x10,%rsp
    10be:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    10c2:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    10c6:	eb 0a                	jmp    10d2 <strcmp+0x20>
    p++, q++;
    10c8:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    10cd:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    10d2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    10d6:	0f b6 00             	movzbl (%rax),%eax
    10d9:	84 c0                	test   %al,%al
    10db:	74 12                	je     10ef <strcmp+0x3d>
    10dd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    10e1:	0f b6 10             	movzbl (%rax),%edx
    10e4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    10e8:	0f b6 00             	movzbl (%rax),%eax
    10eb:	38 c2                	cmp    %al,%dl
    10ed:	74 d9                	je     10c8 <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
    10ef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    10f3:	0f b6 00             	movzbl (%rax),%eax
    10f6:	0f b6 d0             	movzbl %al,%edx
    10f9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    10fd:	0f b6 00             	movzbl (%rax),%eax
    1100:	0f b6 c0             	movzbl %al,%eax
    1103:	29 c2                	sub    %eax,%edx
    1105:	89 d0                	mov    %edx,%eax
}
    1107:	c9                   	leave
    1108:	c3                   	ret

0000000000001109 <strlen>:
{
    1109:	f3 0f 1e fa          	endbr64
    110d:	55                   	push   %rbp
    110e:	48 89 e5             	mov    %rsp,%rbp
    1111:	48 83 ec 18          	sub    $0x18,%rsp
    1115:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  for(n = 0; s[n]; n++)
    1119:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1120:	eb 04                	jmp    1126 <strlen+0x1d>
    1122:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1126:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1129:	48 63 d0             	movslq %eax,%rdx
    112c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1130:	48 01 d0             	add    %rdx,%rax
    1133:	0f b6 00             	movzbl (%rax),%eax
    1136:	84 c0                	test   %al,%al
    1138:	75 e8                	jne    1122 <strlen+0x19>
  return n;
    113a:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    113d:	c9                   	leave
    113e:	c3                   	ret

000000000000113f <memset>:
{
    113f:	f3 0f 1e fa          	endbr64
    1143:	55                   	push   %rbp
    1144:	48 89 e5             	mov    %rsp,%rbp
    1147:	48 83 ec 10          	sub    $0x10,%rsp
    114b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    114f:	89 75 f4             	mov    %esi,-0xc(%rbp)
    1152:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    1155:	8b 55 f0             	mov    -0x10(%rbp),%edx
    1158:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    115b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    115f:	89 ce                	mov    %ecx,%esi
    1161:	48 89 c7             	mov    %rax,%rdi
    1164:	48 b8 31 10 00 00 00 	movabs $0x1031,%rax
    116b:	00 00 00 
    116e:	ff d0                	call   *%rax
  return dst;
    1170:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    1174:	c9                   	leave
    1175:	c3                   	ret

0000000000001176 <strchr>:
{
    1176:	f3 0f 1e fa          	endbr64
    117a:	55                   	push   %rbp
    117b:	48 89 e5             	mov    %rsp,%rbp
    117e:	48 83 ec 10          	sub    $0x10,%rsp
    1182:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1186:	89 f0                	mov    %esi,%eax
    1188:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    118b:	eb 17                	jmp    11a4 <strchr+0x2e>
    if(*s == c)
    118d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1191:	0f b6 00             	movzbl (%rax),%eax
    1194:	38 45 f4             	cmp    %al,-0xc(%rbp)
    1197:	75 06                	jne    119f <strchr+0x29>
      return (char*)s;
    1199:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    119d:	eb 15                	jmp    11b4 <strchr+0x3e>
  for(; *s; s++)
    119f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    11a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    11a8:	0f b6 00             	movzbl (%rax),%eax
    11ab:	84 c0                	test   %al,%al
    11ad:	75 de                	jne    118d <strchr+0x17>
  return 0;
    11af:	b8 00 00 00 00       	mov    $0x0,%eax
}
    11b4:	c9                   	leave
    11b5:	c3                   	ret

00000000000011b6 <gets>:

char*
gets(char *buf, int max)
{
    11b6:	f3 0f 1e fa          	endbr64
    11ba:	55                   	push   %rbp
    11bb:	48 89 e5             	mov    %rsp,%rbp
    11be:	48 83 ec 20          	sub    $0x20,%rsp
    11c2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    11c6:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11c9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    11d0:	eb 4f                	jmp    1221 <gets+0x6b>
    cc = read(0, &c, 1);
    11d2:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    11d6:	ba 01 00 00 00       	mov    $0x1,%edx
    11db:	48 89 c6             	mov    %rax,%rsi
    11de:	bf 00 00 00 00       	mov    $0x0,%edi
    11e3:	48 b8 9b 13 00 00 00 	movabs $0x139b,%rax
    11ea:	00 00 00 
    11ed:	ff d0                	call   *%rax
    11ef:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    11f2:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    11f6:	7e 36                	jle    122e <gets+0x78>
      break;
    buf[i++] = c;
    11f8:	8b 45 fc             	mov    -0x4(%rbp),%eax
    11fb:	8d 50 01             	lea    0x1(%rax),%edx
    11fe:	89 55 fc             	mov    %edx,-0x4(%rbp)
    1201:	48 63 d0             	movslq %eax,%rdx
    1204:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1208:	48 01 c2             	add    %rax,%rdx
    120b:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    120f:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    1211:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1215:	3c 0a                	cmp    $0xa,%al
    1217:	74 16                	je     122f <gets+0x79>
    1219:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    121d:	3c 0d                	cmp    $0xd,%al
    121f:	74 0e                	je     122f <gets+0x79>
  for(i=0; i+1 < max; ){
    1221:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1224:	83 c0 01             	add    $0x1,%eax
    1227:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    122a:	7f a6                	jg     11d2 <gets+0x1c>
    122c:	eb 01                	jmp    122f <gets+0x79>
      break;
    122e:	90                   	nop
      break;
  }
  buf[i] = '\0';
    122f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1232:	48 63 d0             	movslq %eax,%rdx
    1235:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1239:	48 01 d0             	add    %rdx,%rax
    123c:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    123f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    1243:	c9                   	leave
    1244:	c3                   	ret

0000000000001245 <stat>:

int
stat(char *n, struct stat *st)
{
    1245:	f3 0f 1e fa          	endbr64
    1249:	55                   	push   %rbp
    124a:	48 89 e5             	mov    %rsp,%rbp
    124d:	48 83 ec 20          	sub    $0x20,%rsp
    1251:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1255:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1259:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    125d:	be 00 00 00 00       	mov    $0x0,%esi
    1262:	48 89 c7             	mov    %rax,%rdi
    1265:	48 b8 dc 13 00 00 00 	movabs $0x13dc,%rax
    126c:	00 00 00 
    126f:	ff d0                	call   *%rax
    1271:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    1274:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1278:	79 07                	jns    1281 <stat+0x3c>
    return -1;
    127a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    127f:	eb 2f                	jmp    12b0 <stat+0x6b>
  r = fstat(fd, st);
    1281:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1285:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1288:	48 89 d6             	mov    %rdx,%rsi
    128b:	89 c7                	mov    %eax,%edi
    128d:	48 b8 03 14 00 00 00 	movabs $0x1403,%rax
    1294:	00 00 00 
    1297:	ff d0                	call   *%rax
    1299:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    129c:	8b 45 fc             	mov    -0x4(%rbp),%eax
    129f:	89 c7                	mov    %eax,%edi
    12a1:	48 b8 b5 13 00 00 00 	movabs $0x13b5,%rax
    12a8:	00 00 00 
    12ab:	ff d0                	call   *%rax
  return r;
    12ad:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    12b0:	c9                   	leave
    12b1:	c3                   	ret

00000000000012b2 <atoi>:

int
atoi(const char *s)
{
    12b2:	f3 0f 1e fa          	endbr64
    12b6:	55                   	push   %rbp
    12b7:	48 89 e5             	mov    %rsp,%rbp
    12ba:	48 83 ec 18          	sub    $0x18,%rsp
    12be:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    12c2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    12c9:	eb 28                	jmp    12f3 <atoi+0x41>
    n = n*10 + *s++ - '0';
    12cb:	8b 55 fc             	mov    -0x4(%rbp),%edx
    12ce:	89 d0                	mov    %edx,%eax
    12d0:	c1 e0 02             	shl    $0x2,%eax
    12d3:	01 d0                	add    %edx,%eax
    12d5:	01 c0                	add    %eax,%eax
    12d7:	89 c1                	mov    %eax,%ecx
    12d9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12dd:	48 8d 50 01          	lea    0x1(%rax),%rdx
    12e1:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    12e5:	0f b6 00             	movzbl (%rax),%eax
    12e8:	0f be c0             	movsbl %al,%eax
    12eb:	01 c8                	add    %ecx,%eax
    12ed:	83 e8 30             	sub    $0x30,%eax
    12f0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    12f3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12f7:	0f b6 00             	movzbl (%rax),%eax
    12fa:	3c 2f                	cmp    $0x2f,%al
    12fc:	7e 0b                	jle    1309 <atoi+0x57>
    12fe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1302:	0f b6 00             	movzbl (%rax),%eax
    1305:	3c 39                	cmp    $0x39,%al
    1307:	7e c2                	jle    12cb <atoi+0x19>
  return n;
    1309:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    130c:	c9                   	leave
    130d:	c3                   	ret

000000000000130e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    130e:	f3 0f 1e fa          	endbr64
    1312:	55                   	push   %rbp
    1313:	48 89 e5             	mov    %rsp,%rbp
    1316:	48 83 ec 28          	sub    $0x28,%rsp
    131a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    131e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    1322:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    1325:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1329:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    132d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1331:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    1335:	eb 1d                	jmp    1354 <memmove+0x46>
    *dst++ = *src++;
    1337:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    133b:	48 8d 42 01          	lea    0x1(%rdx),%rax
    133f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1343:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1347:	48 8d 48 01          	lea    0x1(%rax),%rcx
    134b:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    134f:	0f b6 12             	movzbl (%rdx),%edx
    1352:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    1354:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1357:	8d 50 ff             	lea    -0x1(%rax),%edx
    135a:	89 55 dc             	mov    %edx,-0x24(%rbp)
    135d:	85 c0                	test   %eax,%eax
    135f:	7f d6                	jg     1337 <memmove+0x29>
  return vdst;
    1361:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    1365:	c9                   	leave
    1366:	c3                   	ret

0000000000001367 <fork>:
    1367:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    136e:	49 89 ca             	mov    %rcx,%r10
    1371:	0f 05                	syscall
    1373:	c3                   	ret

0000000000001374 <exit>:
    1374:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    137b:	49 89 ca             	mov    %rcx,%r10
    137e:	0f 05                	syscall
    1380:	c3                   	ret

0000000000001381 <wait>:
    1381:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    1388:	49 89 ca             	mov    %rcx,%r10
    138b:	0f 05                	syscall
    138d:	c3                   	ret

000000000000138e <pipe>:
    138e:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    1395:	49 89 ca             	mov    %rcx,%r10
    1398:	0f 05                	syscall
    139a:	c3                   	ret

000000000000139b <read>:
    139b:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    13a2:	49 89 ca             	mov    %rcx,%r10
    13a5:	0f 05                	syscall
    13a7:	c3                   	ret

00000000000013a8 <write>:
    13a8:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    13af:	49 89 ca             	mov    %rcx,%r10
    13b2:	0f 05                	syscall
    13b4:	c3                   	ret

00000000000013b5 <close>:
    13b5:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    13bc:	49 89 ca             	mov    %rcx,%r10
    13bf:	0f 05                	syscall
    13c1:	c3                   	ret

00000000000013c2 <kill>:
    13c2:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    13c9:	49 89 ca             	mov    %rcx,%r10
    13cc:	0f 05                	syscall
    13ce:	c3                   	ret

00000000000013cf <exec>:
    13cf:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    13d6:	49 89 ca             	mov    %rcx,%r10
    13d9:	0f 05                	syscall
    13db:	c3                   	ret

00000000000013dc <open>:
    13dc:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    13e3:	49 89 ca             	mov    %rcx,%r10
    13e6:	0f 05                	syscall
    13e8:	c3                   	ret

00000000000013e9 <mknod>:
    13e9:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    13f0:	49 89 ca             	mov    %rcx,%r10
    13f3:	0f 05                	syscall
    13f5:	c3                   	ret

00000000000013f6 <unlink>:
    13f6:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    13fd:	49 89 ca             	mov    %rcx,%r10
    1400:	0f 05                	syscall
    1402:	c3                   	ret

0000000000001403 <fstat>:
    1403:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    140a:	49 89 ca             	mov    %rcx,%r10
    140d:	0f 05                	syscall
    140f:	c3                   	ret

0000000000001410 <link>:
    1410:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    1417:	49 89 ca             	mov    %rcx,%r10
    141a:	0f 05                	syscall
    141c:	c3                   	ret

000000000000141d <mkdir>:
    141d:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    1424:	49 89 ca             	mov    %rcx,%r10
    1427:	0f 05                	syscall
    1429:	c3                   	ret

000000000000142a <chdir>:
    142a:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    1431:	49 89 ca             	mov    %rcx,%r10
    1434:	0f 05                	syscall
    1436:	c3                   	ret

0000000000001437 <dup>:
    1437:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    143e:	49 89 ca             	mov    %rcx,%r10
    1441:	0f 05                	syscall
    1443:	c3                   	ret

0000000000001444 <getpid>:
    1444:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    144b:	49 89 ca             	mov    %rcx,%r10
    144e:	0f 05                	syscall
    1450:	c3                   	ret

0000000000001451 <sbrk>:
    1451:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    1458:	49 89 ca             	mov    %rcx,%r10
    145b:	0f 05                	syscall
    145d:	c3                   	ret

000000000000145e <sleep>:
    145e:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    1465:	49 89 ca             	mov    %rcx,%r10
    1468:	0f 05                	syscall
    146a:	c3                   	ret

000000000000146b <uptime>:
    146b:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    1472:	49 89 ca             	mov    %rcx,%r10
    1475:	0f 05                	syscall
    1477:	c3                   	ret

0000000000001478 <send>:
    1478:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    147f:	49 89 ca             	mov    %rcx,%r10
    1482:	0f 05                	syscall
    1484:	c3                   	ret

0000000000001485 <recv>:
    1485:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    148c:	49 89 ca             	mov    %rcx,%r10
    148f:	0f 05                	syscall
    1491:	c3                   	ret

0000000000001492 <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    1492:	f3 0f 1e fa          	endbr64
    1496:	55                   	push   %rbp
    1497:	48 89 e5             	mov    %rsp,%rbp
    149a:	48 83 ec 10          	sub    $0x10,%rsp
    149e:	89 7d fc             	mov    %edi,-0x4(%rbp)
    14a1:	89 f0                	mov    %esi,%eax
    14a3:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    14a6:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    14aa:	8b 45 fc             	mov    -0x4(%rbp),%eax
    14ad:	ba 01 00 00 00       	mov    $0x1,%edx
    14b2:	48 89 ce             	mov    %rcx,%rsi
    14b5:	89 c7                	mov    %eax,%edi
    14b7:	48 b8 a8 13 00 00 00 	movabs $0x13a8,%rax
    14be:	00 00 00 
    14c1:	ff d0                	call   *%rax
}
    14c3:	90                   	nop
    14c4:	c9                   	leave
    14c5:	c3                   	ret

00000000000014c6 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    14c6:	f3 0f 1e fa          	endbr64
    14ca:	55                   	push   %rbp
    14cb:	48 89 e5             	mov    %rsp,%rbp
    14ce:	48 83 ec 20          	sub    $0x20,%rsp
    14d2:	89 7d ec             	mov    %edi,-0x14(%rbp)
    14d5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    14d9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    14e0:	eb 35                	jmp    1517 <print_x64+0x51>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    14e2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    14e6:	48 c1 e8 3c          	shr    $0x3c,%rax
    14ea:	48 ba 40 1e 00 00 00 	movabs $0x1e40,%rdx
    14f1:	00 00 00 
    14f4:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    14f8:	0f be d0             	movsbl %al,%edx
    14fb:	8b 45 ec             	mov    -0x14(%rbp),%eax
    14fe:	89 d6                	mov    %edx,%esi
    1500:	89 c7                	mov    %eax,%edi
    1502:	48 b8 92 14 00 00 00 	movabs $0x1492,%rax
    1509:	00 00 00 
    150c:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    150e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1512:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    1517:	8b 45 fc             	mov    -0x4(%rbp),%eax
    151a:	83 f8 0f             	cmp    $0xf,%eax
    151d:	76 c3                	jbe    14e2 <print_x64+0x1c>
}
    151f:	90                   	nop
    1520:	90                   	nop
    1521:	c9                   	leave
    1522:	c3                   	ret

0000000000001523 <print_x32>:

  static void
print_x32(int fd, uint x)
{
    1523:	f3 0f 1e fa          	endbr64
    1527:	55                   	push   %rbp
    1528:	48 89 e5             	mov    %rsp,%rbp
    152b:	48 83 ec 20          	sub    $0x20,%rsp
    152f:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1532:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1535:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    153c:	eb 36                	jmp    1574 <print_x32+0x51>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    153e:	8b 45 e8             	mov    -0x18(%rbp),%eax
    1541:	c1 e8 1c             	shr    $0x1c,%eax
    1544:	89 c2                	mov    %eax,%edx
    1546:	48 b8 40 1e 00 00 00 	movabs $0x1e40,%rax
    154d:	00 00 00 
    1550:	89 d2                	mov    %edx,%edx
    1552:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    1556:	0f be d0             	movsbl %al,%edx
    1559:	8b 45 ec             	mov    -0x14(%rbp),%eax
    155c:	89 d6                	mov    %edx,%esi
    155e:	89 c7                	mov    %eax,%edi
    1560:	48 b8 92 14 00 00 00 	movabs $0x1492,%rax
    1567:	00 00 00 
    156a:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    156c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1570:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    1574:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1577:	83 f8 07             	cmp    $0x7,%eax
    157a:	76 c2                	jbe    153e <print_x32+0x1b>
}
    157c:	90                   	nop
    157d:	90                   	nop
    157e:	c9                   	leave
    157f:	c3                   	ret

0000000000001580 <print_d>:

  static void
print_d(int fd, int v)
{
    1580:	f3 0f 1e fa          	endbr64
    1584:	55                   	push   %rbp
    1585:	48 89 e5             	mov    %rsp,%rbp
    1588:	48 83 ec 30          	sub    $0x30,%rsp
    158c:	89 7d dc             	mov    %edi,-0x24(%rbp)
    158f:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    1592:	8b 45 d8             	mov    -0x28(%rbp),%eax
    1595:	48 98                	cltq
    1597:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    159b:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    159f:	79 04                	jns    15a5 <print_d+0x25>
    x = -x;
    15a1:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    15a5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    15ac:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    15b0:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    15b7:	66 66 66 
    15ba:	48 89 c8             	mov    %rcx,%rax
    15bd:	48 f7 ea             	imul   %rdx
    15c0:	48 c1 fa 02          	sar    $0x2,%rdx
    15c4:	48 89 c8             	mov    %rcx,%rax
    15c7:	48 c1 f8 3f          	sar    $0x3f,%rax
    15cb:	48 29 c2             	sub    %rax,%rdx
    15ce:	48 89 d0             	mov    %rdx,%rax
    15d1:	48 c1 e0 02          	shl    $0x2,%rax
    15d5:	48 01 d0             	add    %rdx,%rax
    15d8:	48 01 c0             	add    %rax,%rax
    15db:	48 29 c1             	sub    %rax,%rcx
    15de:	48 89 ca             	mov    %rcx,%rdx
    15e1:	8b 45 f4             	mov    -0xc(%rbp),%eax
    15e4:	8d 48 01             	lea    0x1(%rax),%ecx
    15e7:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    15ea:	48 b9 40 1e 00 00 00 	movabs $0x1e40,%rcx
    15f1:	00 00 00 
    15f4:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    15f8:	48 98                	cltq
    15fa:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    15fe:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1602:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1609:	66 66 66 
    160c:	48 89 c8             	mov    %rcx,%rax
    160f:	48 f7 ea             	imul   %rdx
    1612:	48 89 d0             	mov    %rdx,%rax
    1615:	48 c1 f8 02          	sar    $0x2,%rax
    1619:	48 c1 f9 3f          	sar    $0x3f,%rcx
    161d:	48 89 ca             	mov    %rcx,%rdx
    1620:	48 29 d0             	sub    %rdx,%rax
    1623:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    1627:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    162c:	0f 85 7a ff ff ff    	jne    15ac <print_d+0x2c>

  if (v < 0)
    1632:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1636:	79 32                	jns    166a <print_d+0xea>
    buf[i++] = '-';
    1638:	8b 45 f4             	mov    -0xc(%rbp),%eax
    163b:	8d 50 01             	lea    0x1(%rax),%edx
    163e:	89 55 f4             	mov    %edx,-0xc(%rbp)
    1641:	48 98                	cltq
    1643:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    1648:	eb 20                	jmp    166a <print_d+0xea>
    putc(fd, buf[i]);
    164a:	8b 45 f4             	mov    -0xc(%rbp),%eax
    164d:	48 98                	cltq
    164f:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    1654:	0f be d0             	movsbl %al,%edx
    1657:	8b 45 dc             	mov    -0x24(%rbp),%eax
    165a:	89 d6                	mov    %edx,%esi
    165c:	89 c7                	mov    %eax,%edi
    165e:	48 b8 92 14 00 00 00 	movabs $0x1492,%rax
    1665:	00 00 00 
    1668:	ff d0                	call   *%rax
  while (--i >= 0)
    166a:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    166e:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1672:	79 d6                	jns    164a <print_d+0xca>
}
    1674:	90                   	nop
    1675:	90                   	nop
    1676:	c9                   	leave
    1677:	c3                   	ret

0000000000001678 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    1678:	f3 0f 1e fa          	endbr64
    167c:	55                   	push   %rbp
    167d:	48 89 e5             	mov    %rsp,%rbp
    1680:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    1687:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    168d:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    1694:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    169b:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    16a2:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    16a9:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    16b0:	84 c0                	test   %al,%al
    16b2:	74 20                	je     16d4 <printf+0x5c>
    16b4:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    16b8:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    16bc:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    16c0:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    16c4:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    16c8:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    16cc:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    16d0:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    16d4:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    16db:	00 00 00 
    16de:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    16e5:	00 00 00 
    16e8:	48 8d 45 10          	lea    0x10(%rbp),%rax
    16ec:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    16f3:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    16fa:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1701:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    1708:	00 00 00 
    170b:	e9 41 03 00 00       	jmp    1a51 <printf+0x3d9>
    if (c != '%') {
    1710:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1717:	74 24                	je     173d <printf+0xc5>
      putc(fd, c);
    1719:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    171f:	0f be d0             	movsbl %al,%edx
    1722:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1728:	89 d6                	mov    %edx,%esi
    172a:	89 c7                	mov    %eax,%edi
    172c:	48 b8 92 14 00 00 00 	movabs $0x1492,%rax
    1733:	00 00 00 
    1736:	ff d0                	call   *%rax
      continue;
    1738:	e9 0d 03 00 00       	jmp    1a4a <printf+0x3d2>
    }
    c = fmt[++i] & 0xff;
    173d:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1744:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    174a:	48 63 d0             	movslq %eax,%rdx
    174d:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1754:	48 01 d0             	add    %rdx,%rax
    1757:	0f b6 00             	movzbl (%rax),%eax
    175a:	0f be c0             	movsbl %al,%eax
    175d:	25 ff 00 00 00       	and    $0xff,%eax
    1762:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    1768:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    176f:	0f 84 0f 03 00 00    	je     1a84 <printf+0x40c>
      break;
    switch(c) {
    1775:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    177c:	0f 84 74 02 00 00    	je     19f6 <printf+0x37e>
    1782:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1789:	0f 8c 82 02 00 00    	jl     1a11 <printf+0x399>
    178f:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    1796:	0f 8f 75 02 00 00    	jg     1a11 <printf+0x399>
    179c:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    17a3:	0f 8c 68 02 00 00    	jl     1a11 <printf+0x399>
    17a9:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    17af:	83 e8 63             	sub    $0x63,%eax
    17b2:	83 f8 15             	cmp    $0x15,%eax
    17b5:	0f 87 56 02 00 00    	ja     1a11 <printf+0x399>
    17bb:	89 c0                	mov    %eax,%eax
    17bd:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    17c4:	00 
    17c5:	48 b8 88 1d 00 00 00 	movabs $0x1d88,%rax
    17cc:	00 00 00 
    17cf:	48 01 d0             	add    %rdx,%rax
    17d2:	48 8b 00             	mov    (%rax),%rax
    17d5:	3e ff e0             	notrack jmp *%rax
    case 'c':
      putc(fd, va_arg(ap, int));
    17d8:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    17de:	83 f8 2f             	cmp    $0x2f,%eax
    17e1:	77 23                	ja     1806 <printf+0x18e>
    17e3:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    17ea:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    17f0:	89 d2                	mov    %edx,%edx
    17f2:	48 01 d0             	add    %rdx,%rax
    17f5:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    17fb:	83 c2 08             	add    $0x8,%edx
    17fe:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1804:	eb 12                	jmp    1818 <printf+0x1a0>
    1806:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    180d:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1811:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1818:	8b 00                	mov    (%rax),%eax
    181a:	0f be d0             	movsbl %al,%edx
    181d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1823:	89 d6                	mov    %edx,%esi
    1825:	89 c7                	mov    %eax,%edi
    1827:	48 b8 92 14 00 00 00 	movabs $0x1492,%rax
    182e:	00 00 00 
    1831:	ff d0                	call   *%rax
      break;
    1833:	e9 12 02 00 00       	jmp    1a4a <printf+0x3d2>
    case 'd':
      print_d(fd, va_arg(ap, int));
    1838:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    183e:	83 f8 2f             	cmp    $0x2f,%eax
    1841:	77 23                	ja     1866 <printf+0x1ee>
    1843:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    184a:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1850:	89 d2                	mov    %edx,%edx
    1852:	48 01 d0             	add    %rdx,%rax
    1855:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    185b:	83 c2 08             	add    $0x8,%edx
    185e:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1864:	eb 12                	jmp    1878 <printf+0x200>
    1866:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    186d:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1871:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1878:	8b 10                	mov    (%rax),%edx
    187a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1880:	89 d6                	mov    %edx,%esi
    1882:	89 c7                	mov    %eax,%edi
    1884:	48 b8 80 15 00 00 00 	movabs $0x1580,%rax
    188b:	00 00 00 
    188e:	ff d0                	call   *%rax
      break;
    1890:	e9 b5 01 00 00       	jmp    1a4a <printf+0x3d2>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    1895:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    189b:	83 f8 2f             	cmp    $0x2f,%eax
    189e:	77 23                	ja     18c3 <printf+0x24b>
    18a0:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    18a7:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18ad:	89 d2                	mov    %edx,%edx
    18af:	48 01 d0             	add    %rdx,%rax
    18b2:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18b8:	83 c2 08             	add    $0x8,%edx
    18bb:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    18c1:	eb 12                	jmp    18d5 <printf+0x25d>
    18c3:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    18ca:	48 8d 50 08          	lea    0x8(%rax),%rdx
    18ce:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    18d5:	8b 10                	mov    (%rax),%edx
    18d7:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    18dd:	89 d6                	mov    %edx,%esi
    18df:	89 c7                	mov    %eax,%edi
    18e1:	48 b8 23 15 00 00 00 	movabs $0x1523,%rax
    18e8:	00 00 00 
    18eb:	ff d0                	call   *%rax
      break;
    18ed:	e9 58 01 00 00       	jmp    1a4a <printf+0x3d2>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    18f2:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    18f8:	83 f8 2f             	cmp    $0x2f,%eax
    18fb:	77 23                	ja     1920 <printf+0x2a8>
    18fd:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1904:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    190a:	89 d2                	mov    %edx,%edx
    190c:	48 01 d0             	add    %rdx,%rax
    190f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1915:	83 c2 08             	add    $0x8,%edx
    1918:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    191e:	eb 12                	jmp    1932 <printf+0x2ba>
    1920:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1927:	48 8d 50 08          	lea    0x8(%rax),%rdx
    192b:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1932:	48 8b 10             	mov    (%rax),%rdx
    1935:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    193b:	48 89 d6             	mov    %rdx,%rsi
    193e:	89 c7                	mov    %eax,%edi
    1940:	48 b8 c6 14 00 00 00 	movabs $0x14c6,%rax
    1947:	00 00 00 
    194a:	ff d0                	call   *%rax
      break;
    194c:	e9 f9 00 00 00       	jmp    1a4a <printf+0x3d2>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    1951:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1957:	83 f8 2f             	cmp    $0x2f,%eax
    195a:	77 23                	ja     197f <printf+0x307>
    195c:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1963:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1969:	89 d2                	mov    %edx,%edx
    196b:	48 01 d0             	add    %rdx,%rax
    196e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1974:	83 c2 08             	add    $0x8,%edx
    1977:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    197d:	eb 12                	jmp    1991 <printf+0x319>
    197f:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1986:	48 8d 50 08          	lea    0x8(%rax),%rdx
    198a:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1991:	48 8b 00             	mov    (%rax),%rax
    1994:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    199b:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    19a2:	00 
    19a3:	75 41                	jne    19e6 <printf+0x36e>
        s = "(null)";
    19a5:	48 b8 80 1d 00 00 00 	movabs $0x1d80,%rax
    19ac:	00 00 00 
    19af:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    19b6:	eb 2e                	jmp    19e6 <printf+0x36e>
        putc(fd, *(s++));
    19b8:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    19bf:	48 8d 50 01          	lea    0x1(%rax),%rdx
    19c3:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    19ca:	0f b6 00             	movzbl (%rax),%eax
    19cd:	0f be d0             	movsbl %al,%edx
    19d0:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    19d6:	89 d6                	mov    %edx,%esi
    19d8:	89 c7                	mov    %eax,%edi
    19da:	48 b8 92 14 00 00 00 	movabs $0x1492,%rax
    19e1:	00 00 00 
    19e4:	ff d0                	call   *%rax
      while (*s)
    19e6:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    19ed:	0f b6 00             	movzbl (%rax),%eax
    19f0:	84 c0                	test   %al,%al
    19f2:	75 c4                	jne    19b8 <printf+0x340>
      break;
    19f4:	eb 54                	jmp    1a4a <printf+0x3d2>
    case '%':
      putc(fd, '%');
    19f6:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    19fc:	be 25 00 00 00       	mov    $0x25,%esi
    1a01:	89 c7                	mov    %eax,%edi
    1a03:	48 b8 92 14 00 00 00 	movabs $0x1492,%rax
    1a0a:	00 00 00 
    1a0d:	ff d0                	call   *%rax
      break;
    1a0f:	eb 39                	jmp    1a4a <printf+0x3d2>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1a11:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a17:	be 25 00 00 00       	mov    $0x25,%esi
    1a1c:	89 c7                	mov    %eax,%edi
    1a1e:	48 b8 92 14 00 00 00 	movabs $0x1492,%rax
    1a25:	00 00 00 
    1a28:	ff d0                	call   *%rax
      putc(fd, c);
    1a2a:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1a30:	0f be d0             	movsbl %al,%edx
    1a33:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a39:	89 d6                	mov    %edx,%esi
    1a3b:	89 c7                	mov    %eax,%edi
    1a3d:	48 b8 92 14 00 00 00 	movabs $0x1492,%rax
    1a44:	00 00 00 
    1a47:	ff d0                	call   *%rax
      break;
    1a49:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1a4a:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1a51:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1a57:	48 63 d0             	movslq %eax,%rdx
    1a5a:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1a61:	48 01 d0             	add    %rdx,%rax
    1a64:	0f b6 00             	movzbl (%rax),%eax
    1a67:	0f be c0             	movsbl %al,%eax
    1a6a:	25 ff 00 00 00       	and    $0xff,%eax
    1a6f:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1a75:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1a7c:	0f 85 8e fc ff ff    	jne    1710 <printf+0x98>
    }
  }
}
    1a82:	eb 01                	jmp    1a85 <printf+0x40d>
      break;
    1a84:	90                   	nop
}
    1a85:	90                   	nop
    1a86:	c9                   	leave
    1a87:	c3                   	ret

0000000000001a88 <free>:
    1a88:	55                   	push   %rbp
    1a89:	48 89 e5             	mov    %rsp,%rbp
    1a8c:	48 83 ec 18          	sub    $0x18,%rsp
    1a90:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1a94:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1a98:	48 83 e8 10          	sub    $0x10,%rax
    1a9c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1aa0:	48 b8 70 1e 00 00 00 	movabs $0x1e70,%rax
    1aa7:	00 00 00 
    1aaa:	48 8b 00             	mov    (%rax),%rax
    1aad:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1ab1:	eb 2f                	jmp    1ae2 <free+0x5a>
    1ab3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ab7:	48 8b 00             	mov    (%rax),%rax
    1aba:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1abe:	72 17                	jb     1ad7 <free+0x4f>
    1ac0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ac4:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1ac8:	72 2f                	jb     1af9 <free+0x71>
    1aca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ace:	48 8b 00             	mov    (%rax),%rax
    1ad1:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1ad5:	72 22                	jb     1af9 <free+0x71>
    1ad7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1adb:	48 8b 00             	mov    (%rax),%rax
    1ade:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1ae2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ae6:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1aea:	73 c7                	jae    1ab3 <free+0x2b>
    1aec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1af0:	48 8b 00             	mov    (%rax),%rax
    1af3:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1af7:	73 ba                	jae    1ab3 <free+0x2b>
    1af9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1afd:	8b 40 08             	mov    0x8(%rax),%eax
    1b00:	89 c0                	mov    %eax,%eax
    1b02:	48 c1 e0 04          	shl    $0x4,%rax
    1b06:	48 89 c2             	mov    %rax,%rdx
    1b09:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b0d:	48 01 c2             	add    %rax,%rdx
    1b10:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b14:	48 8b 00             	mov    (%rax),%rax
    1b17:	48 39 c2             	cmp    %rax,%rdx
    1b1a:	75 2d                	jne    1b49 <free+0xc1>
    1b1c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b20:	8b 50 08             	mov    0x8(%rax),%edx
    1b23:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b27:	48 8b 00             	mov    (%rax),%rax
    1b2a:	8b 40 08             	mov    0x8(%rax),%eax
    1b2d:	01 c2                	add    %eax,%edx
    1b2f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b33:	89 50 08             	mov    %edx,0x8(%rax)
    1b36:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b3a:	48 8b 00             	mov    (%rax),%rax
    1b3d:	48 8b 10             	mov    (%rax),%rdx
    1b40:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b44:	48 89 10             	mov    %rdx,(%rax)
    1b47:	eb 0e                	jmp    1b57 <free+0xcf>
    1b49:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b4d:	48 8b 10             	mov    (%rax),%rdx
    1b50:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b54:	48 89 10             	mov    %rdx,(%rax)
    1b57:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b5b:	8b 40 08             	mov    0x8(%rax),%eax
    1b5e:	89 c0                	mov    %eax,%eax
    1b60:	48 c1 e0 04          	shl    $0x4,%rax
    1b64:	48 89 c2             	mov    %rax,%rdx
    1b67:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b6b:	48 01 d0             	add    %rdx,%rax
    1b6e:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1b72:	75 27                	jne    1b9b <free+0x113>
    1b74:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b78:	8b 50 08             	mov    0x8(%rax),%edx
    1b7b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b7f:	8b 40 08             	mov    0x8(%rax),%eax
    1b82:	01 c2                	add    %eax,%edx
    1b84:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b88:	89 50 08             	mov    %edx,0x8(%rax)
    1b8b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b8f:	48 8b 10             	mov    (%rax),%rdx
    1b92:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b96:	48 89 10             	mov    %rdx,(%rax)
    1b99:	eb 0b                	jmp    1ba6 <free+0x11e>
    1b9b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b9f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1ba3:	48 89 10             	mov    %rdx,(%rax)
    1ba6:	48 ba 70 1e 00 00 00 	movabs $0x1e70,%rdx
    1bad:	00 00 00 
    1bb0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bb4:	48 89 02             	mov    %rax,(%rdx)
    1bb7:	90                   	nop
    1bb8:	c9                   	leave
    1bb9:	c3                   	ret

0000000000001bba <morecore>:
    1bba:	55                   	push   %rbp
    1bbb:	48 89 e5             	mov    %rsp,%rbp
    1bbe:	48 83 ec 20          	sub    $0x20,%rsp
    1bc2:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1bc5:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1bcc:	77 07                	ja     1bd5 <morecore+0x1b>
    1bce:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
    1bd5:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1bd8:	48 c1 e0 04          	shl    $0x4,%rax
    1bdc:	48 89 c7             	mov    %rax,%rdi
    1bdf:	48 b8 51 14 00 00 00 	movabs $0x1451,%rax
    1be6:	00 00 00 
    1be9:	ff d0                	call   *%rax
    1beb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1bef:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1bf4:	75 07                	jne    1bfd <morecore+0x43>
    1bf6:	b8 00 00 00 00       	mov    $0x0,%eax
    1bfb:	eb 36                	jmp    1c33 <morecore+0x79>
    1bfd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c01:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1c05:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c09:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1c0c:	89 50 08             	mov    %edx,0x8(%rax)
    1c0f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c13:	48 83 c0 10          	add    $0x10,%rax
    1c17:	48 89 c7             	mov    %rax,%rdi
    1c1a:	48 b8 88 1a 00 00 00 	movabs $0x1a88,%rax
    1c21:	00 00 00 
    1c24:	ff d0                	call   *%rax
    1c26:	48 b8 70 1e 00 00 00 	movabs $0x1e70,%rax
    1c2d:	00 00 00 
    1c30:	48 8b 00             	mov    (%rax),%rax
    1c33:	c9                   	leave
    1c34:	c3                   	ret

0000000000001c35 <malloc>:
    1c35:	55                   	push   %rbp
    1c36:	48 89 e5             	mov    %rsp,%rbp
    1c39:	48 83 ec 30          	sub    $0x30,%rsp
    1c3d:	89 7d dc             	mov    %edi,-0x24(%rbp)
    1c40:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1c43:	48 83 c0 0f          	add    $0xf,%rax
    1c47:	48 c1 e8 04          	shr    $0x4,%rax
    1c4b:	83 c0 01             	add    $0x1,%eax
    1c4e:	89 45 ec             	mov    %eax,-0x14(%rbp)
    1c51:	48 b8 70 1e 00 00 00 	movabs $0x1e70,%rax
    1c58:	00 00 00 
    1c5b:	48 8b 00             	mov    (%rax),%rax
    1c5e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1c62:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1c67:	75 4a                	jne    1cb3 <malloc+0x7e>
    1c69:	48 b8 60 1e 00 00 00 	movabs $0x1e60,%rax
    1c70:	00 00 00 
    1c73:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1c77:	48 ba 70 1e 00 00 00 	movabs $0x1e70,%rdx
    1c7e:	00 00 00 
    1c81:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c85:	48 89 02             	mov    %rax,(%rdx)
    1c88:	48 b8 70 1e 00 00 00 	movabs $0x1e70,%rax
    1c8f:	00 00 00 
    1c92:	48 8b 00             	mov    (%rax),%rax
    1c95:	48 ba 60 1e 00 00 00 	movabs $0x1e60,%rdx
    1c9c:	00 00 00 
    1c9f:	48 89 02             	mov    %rax,(%rdx)
    1ca2:	48 b8 60 1e 00 00 00 	movabs $0x1e60,%rax
    1ca9:	00 00 00 
    1cac:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
    1cb3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cb7:	48 8b 00             	mov    (%rax),%rax
    1cba:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1cbe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cc2:	8b 40 08             	mov    0x8(%rax),%eax
    1cc5:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1cc8:	72 65                	jb     1d2f <malloc+0xfa>
    1cca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cce:	8b 40 08             	mov    0x8(%rax),%eax
    1cd1:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1cd4:	75 10                	jne    1ce6 <malloc+0xb1>
    1cd6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cda:	48 8b 10             	mov    (%rax),%rdx
    1cdd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ce1:	48 89 10             	mov    %rdx,(%rax)
    1ce4:	eb 2e                	jmp    1d14 <malloc+0xdf>
    1ce6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cea:	8b 40 08             	mov    0x8(%rax),%eax
    1ced:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1cf0:	89 c2                	mov    %eax,%edx
    1cf2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cf6:	89 50 08             	mov    %edx,0x8(%rax)
    1cf9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cfd:	8b 40 08             	mov    0x8(%rax),%eax
    1d00:	89 c0                	mov    %eax,%eax
    1d02:	48 c1 e0 04          	shl    $0x4,%rax
    1d06:	48 01 45 f8          	add    %rax,-0x8(%rbp)
    1d0a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d0e:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1d11:	89 50 08             	mov    %edx,0x8(%rax)
    1d14:	48 ba 70 1e 00 00 00 	movabs $0x1e70,%rdx
    1d1b:	00 00 00 
    1d1e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d22:	48 89 02             	mov    %rax,(%rdx)
    1d25:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d29:	48 83 c0 10          	add    $0x10,%rax
    1d2d:	eb 4e                	jmp    1d7d <malloc+0x148>
    1d2f:	48 b8 70 1e 00 00 00 	movabs $0x1e70,%rax
    1d36:	00 00 00 
    1d39:	48 8b 00             	mov    (%rax),%rax
    1d3c:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1d40:	75 23                	jne    1d65 <malloc+0x130>
    1d42:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1d45:	89 c7                	mov    %eax,%edi
    1d47:	48 b8 ba 1b 00 00 00 	movabs $0x1bba,%rax
    1d4e:	00 00 00 
    1d51:	ff d0                	call   *%rax
    1d53:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1d57:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1d5c:	75 07                	jne    1d65 <malloc+0x130>
    1d5e:	b8 00 00 00 00       	mov    $0x0,%eax
    1d63:	eb 18                	jmp    1d7d <malloc+0x148>
    1d65:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d69:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1d6d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d71:	48 8b 00             	mov    (%rax),%rax
    1d74:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1d78:	e9 41 ff ff ff       	jmp    1cbe <malloc+0x89>
    1d7d:	c9                   	leave
    1d7e:	c3                   	ret
