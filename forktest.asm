
_forktest:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <printf>:

#define N  1000

void
printf(int fd, char *s, ...)
{
    1000:	f3 0f 1e fa          	endbr64
    1004:	55                   	push   %rbp
    1005:	48 89 e5             	mov    %rsp,%rbp
    1008:	48 81 ec c0 00 00 00 	sub    $0xc0,%rsp
    100f:	89 bd 4c ff ff ff    	mov    %edi,-0xb4(%rbp)
    1015:	48 89 b5 40 ff ff ff 	mov    %rsi,-0xc0(%rbp)
    101c:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    1023:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    102a:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    1031:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    1038:	84 c0                	test   %al,%al
    103a:	74 20                	je     105c <printf+0x5c>
    103c:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    1040:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    1044:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    1048:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    104c:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    1050:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    1054:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    1058:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  write(fd, s, strlen(s));
    105c:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1063:	48 89 c7             	mov    %rax,%rdi
    1066:	48 b8 e8 12 00 00 00 	movabs $0x12e8,%rax
    106d:	00 00 00 
    1070:	ff d0                	call   *%rax
    1072:	89 c2                	mov    %eax,%edx
    1074:	48 8b 8d 40 ff ff ff 	mov    -0xc0(%rbp),%rcx
    107b:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1081:	48 89 ce             	mov    %rcx,%rsi
    1084:	89 c7                	mov    %eax,%edi
    1086:	48 b8 87 15 00 00 00 	movabs $0x1587,%rax
    108d:	00 00 00 
    1090:	ff d0                	call   *%rax
}
    1092:	90                   	nop
    1093:	c9                   	leave
    1094:	c3                   	ret

0000000000001095 <forktest>:

void
forktest(void)
{
    1095:	f3 0f 1e fa          	endbr64
    1099:	55                   	push   %rbp
    109a:	48 89 e5             	mov    %rsp,%rbp
    109d:	48 83 ec 10          	sub    $0x10,%rsp
  int n, pid;

  printf(1, "fork test\n");
    10a1:	48 b8 80 16 00 00 00 	movabs $0x1680,%rax
    10a8:	00 00 00 
    10ab:	48 89 c6             	mov    %rax,%rsi
    10ae:	bf 01 00 00 00       	mov    $0x1,%edi
    10b3:	b8 00 00 00 00       	mov    $0x0,%eax
    10b8:	48 ba 00 10 00 00 00 	movabs $0x1000,%rdx
    10bf:	00 00 00 
    10c2:	ff d2                	call   *%rdx

  for(n=0; n<N; n++){
    10c4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    10cb:	eb 2b                	jmp    10f8 <forktest+0x63>
    pid = fork();
    10cd:	48 b8 46 15 00 00 00 	movabs $0x1546,%rax
    10d4:	00 00 00 
    10d7:	ff d0                	call   *%rax
    10d9:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(pid < 0)
    10dc:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    10e0:	78 21                	js     1103 <forktest+0x6e>
      break;
    if(pid == 0)
    10e2:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    10e6:	75 0c                	jne    10f4 <forktest+0x5f>
      exit();
    10e8:	48 b8 53 15 00 00 00 	movabs $0x1553,%rax
    10ef:	00 00 00 
    10f2:	ff d0                	call   *%rax
  for(n=0; n<N; n++){
    10f4:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    10f8:	81 7d fc e7 03 00 00 	cmpl   $0x3e7,-0x4(%rbp)
    10ff:	7e cc                	jle    10cd <forktest+0x38>
    1101:	eb 01                	jmp    1104 <forktest+0x6f>
      break;
    1103:	90                   	nop
  }

  if(n == N){
    1104:	81 7d fc e8 03 00 00 	cmpl   $0x3e8,-0x4(%rbp)
    110b:	75 77                	jne    1184 <forktest+0xef>
    printf(1, "fork claimed to work N times!\n", N);
    110d:	ba e8 03 00 00       	mov    $0x3e8,%edx
    1112:	48 b8 90 16 00 00 00 	movabs $0x1690,%rax
    1119:	00 00 00 
    111c:	48 89 c6             	mov    %rax,%rsi
    111f:	bf 01 00 00 00       	mov    $0x1,%edi
    1124:	b8 00 00 00 00       	mov    $0x0,%eax
    1129:	48 b9 00 10 00 00 00 	movabs $0x1000,%rcx
    1130:	00 00 00 
    1133:	ff d1                	call   *%rcx
    exit();
    1135:	48 b8 53 15 00 00 00 	movabs $0x1553,%rax
    113c:	00 00 00 
    113f:	ff d0                	call   *%rax
  }

  for(; n > 0; n--){
    if(wait() < 0){
    1141:	48 b8 60 15 00 00 00 	movabs $0x1560,%rax
    1148:	00 00 00 
    114b:	ff d0                	call   *%rax
    114d:	85 c0                	test   %eax,%eax
    114f:	79 2f                	jns    1180 <forktest+0xeb>
      printf(1, "wait stopped early\n");
    1151:	48 b8 af 16 00 00 00 	movabs $0x16af,%rax
    1158:	00 00 00 
    115b:	48 89 c6             	mov    %rax,%rsi
    115e:	bf 01 00 00 00       	mov    $0x1,%edi
    1163:	b8 00 00 00 00       	mov    $0x0,%eax
    1168:	48 ba 00 10 00 00 00 	movabs $0x1000,%rdx
    116f:	00 00 00 
    1172:	ff d2                	call   *%rdx
      exit();
    1174:	48 b8 53 15 00 00 00 	movabs $0x1553,%rax
    117b:	00 00 00 
    117e:	ff d0                	call   *%rax
  for(; n > 0; n--){
    1180:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
    1184:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1188:	7f b7                	jg     1141 <forktest+0xac>
    }
  }

  if(wait() != -1){
    118a:	48 b8 60 15 00 00 00 	movabs $0x1560,%rax
    1191:	00 00 00 
    1194:	ff d0                	call   *%rax
    1196:	83 f8 ff             	cmp    $0xffffffff,%eax
    1199:	74 2f                	je     11ca <forktest+0x135>
    printf(1, "wait got too many\n");
    119b:	48 b8 c3 16 00 00 00 	movabs $0x16c3,%rax
    11a2:	00 00 00 
    11a5:	48 89 c6             	mov    %rax,%rsi
    11a8:	bf 01 00 00 00       	mov    $0x1,%edi
    11ad:	b8 00 00 00 00       	mov    $0x0,%eax
    11b2:	48 ba 00 10 00 00 00 	movabs $0x1000,%rdx
    11b9:	00 00 00 
    11bc:	ff d2                	call   *%rdx
    exit();
    11be:	48 b8 53 15 00 00 00 	movabs $0x1553,%rax
    11c5:	00 00 00 
    11c8:	ff d0                	call   *%rax
  }

  printf(1, "fork test OK\n");
    11ca:	48 b8 d6 16 00 00 00 	movabs $0x16d6,%rax
    11d1:	00 00 00 
    11d4:	48 89 c6             	mov    %rax,%rsi
    11d7:	bf 01 00 00 00       	mov    $0x1,%edi
    11dc:	b8 00 00 00 00       	mov    $0x0,%eax
    11e1:	48 ba 00 10 00 00 00 	movabs $0x1000,%rdx
    11e8:	00 00 00 
    11eb:	ff d2                	call   *%rdx
}
    11ed:	90                   	nop
    11ee:	c9                   	leave
    11ef:	c3                   	ret

00000000000011f0 <main>:

int
main(void)
{
    11f0:	f3 0f 1e fa          	endbr64
    11f4:	55                   	push   %rbp
    11f5:	48 89 e5             	mov    %rsp,%rbp
  forktest();
    11f8:	48 b8 95 10 00 00 00 	movabs $0x1095,%rax
    11ff:	00 00 00 
    1202:	ff d0                	call   *%rax
  exit();
    1204:	48 b8 53 15 00 00 00 	movabs $0x1553,%rax
    120b:	00 00 00 
    120e:	ff d0                	call   *%rax

0000000000001210 <stosb>:
  stosb(dst, c, n);
  return dst;
}

char*
strchr(const char *s, char c)
    1210:	f3 0f 1e fa          	endbr64
    1214:	55                   	push   %rbp
    1215:	48 89 e5             	mov    %rsp,%rbp
    1218:	48 83 ec 10          	sub    $0x10,%rsp
    121c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1220:	89 75 f4             	mov    %esi,-0xc(%rbp)
    1223:	89 55 f0             	mov    %edx,-0x10(%rbp)
{
    1226:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    122a:	8b 55 f0             	mov    -0x10(%rbp),%edx
    122d:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1230:	48 89 ce             	mov    %rcx,%rsi
    1233:	48 89 f7             	mov    %rsi,%rdi
    1236:	89 d1                	mov    %edx,%ecx
    1238:	fc                   	cld
    1239:	f3 aa                	rep stos %al,%es:(%rdi)
    123b:	89 ca                	mov    %ecx,%edx
    123d:	48 89 fe             	mov    %rdi,%rsi
    1240:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    1244:	89 55 f0             	mov    %edx,-0x10(%rbp)
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
    1247:	90                   	nop
    1248:	c9                   	leave
    1249:	c3                   	ret

000000000000124a <strcpy>:
{
    124a:	f3 0f 1e fa          	endbr64
    124e:	55                   	push   %rbp
    124f:	48 89 e5             	mov    %rsp,%rbp
    1252:	48 83 ec 20          	sub    $0x20,%rsp
    1256:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    125a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  os = s;
    125e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1262:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    1266:	90                   	nop
    1267:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    126b:	48 8d 42 01          	lea    0x1(%rdx),%rax
    126f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    1273:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1277:	48 8d 48 01          	lea    0x1(%rax),%rcx
    127b:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    127f:	0f b6 12             	movzbl (%rdx),%edx
    1282:	88 10                	mov    %dl,(%rax)
    1284:	0f b6 00             	movzbl (%rax),%eax
    1287:	84 c0                	test   %al,%al
    1289:	75 dc                	jne    1267 <strcpy+0x1d>
  return os;
    128b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    128f:	c9                   	leave
    1290:	c3                   	ret

0000000000001291 <strcmp>:
{
    1291:	f3 0f 1e fa          	endbr64
    1295:	55                   	push   %rbp
    1296:	48 89 e5             	mov    %rsp,%rbp
    1299:	48 83 ec 10          	sub    $0x10,%rsp
    129d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    12a1:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    12a5:	eb 0a                	jmp    12b1 <strcmp+0x20>
    p++, q++;
    12a7:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    12ac:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    12b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    12b5:	0f b6 00             	movzbl (%rax),%eax
    12b8:	84 c0                	test   %al,%al
    12ba:	74 12                	je     12ce <strcmp+0x3d>
    12bc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    12c0:	0f b6 10             	movzbl (%rax),%edx
    12c3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    12c7:	0f b6 00             	movzbl (%rax),%eax
    12ca:	38 c2                	cmp    %al,%dl
    12cc:	74 d9                	je     12a7 <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
    12ce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    12d2:	0f b6 00             	movzbl (%rax),%eax
    12d5:	0f b6 d0             	movzbl %al,%edx
    12d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    12dc:	0f b6 00             	movzbl (%rax),%eax
    12df:	0f b6 c0             	movzbl %al,%eax
    12e2:	29 c2                	sub    %eax,%edx
    12e4:	89 d0                	mov    %edx,%eax
}
    12e6:	c9                   	leave
    12e7:	c3                   	ret

00000000000012e8 <strlen>:
{
    12e8:	f3 0f 1e fa          	endbr64
    12ec:	55                   	push   %rbp
    12ed:	48 89 e5             	mov    %rsp,%rbp
    12f0:	48 83 ec 18          	sub    $0x18,%rsp
    12f4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  for(n = 0; s[n]; n++)
    12f8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    12ff:	eb 04                	jmp    1305 <strlen+0x1d>
    1301:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1305:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1308:	48 63 d0             	movslq %eax,%rdx
    130b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    130f:	48 01 d0             	add    %rdx,%rax
    1312:	0f b6 00             	movzbl (%rax),%eax
    1315:	84 c0                	test   %al,%al
    1317:	75 e8                	jne    1301 <strlen+0x19>
  return n;
    1319:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    131c:	c9                   	leave
    131d:	c3                   	ret

000000000000131e <memset>:
{
    131e:	f3 0f 1e fa          	endbr64
    1322:	55                   	push   %rbp
    1323:	48 89 e5             	mov    %rsp,%rbp
    1326:	48 83 ec 10          	sub    $0x10,%rsp
    132a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    132e:	89 75 f4             	mov    %esi,-0xc(%rbp)
    1331:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    1334:	8b 55 f0             	mov    -0x10(%rbp),%edx
    1337:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    133a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    133e:	89 ce                	mov    %ecx,%esi
    1340:	48 89 c7             	mov    %rax,%rdi
    1343:	48 b8 10 12 00 00 00 	movabs $0x1210,%rax
    134a:	00 00 00 
    134d:	ff d0                	call   *%rax
  return dst;
    134f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    1353:	c9                   	leave
    1354:	c3                   	ret

0000000000001355 <strchr>:
{
    1355:	f3 0f 1e fa          	endbr64
    1359:	55                   	push   %rbp
    135a:	48 89 e5             	mov    %rsp,%rbp
    135d:	48 83 ec 10          	sub    $0x10,%rsp
    1361:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1365:	89 f0                	mov    %esi,%eax
    1367:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    136a:	eb 17                	jmp    1383 <strchr+0x2e>
    if(*s == c)
    136c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1370:	0f b6 00             	movzbl (%rax),%eax
    1373:	38 45 f4             	cmp    %al,-0xc(%rbp)
    1376:	75 06                	jne    137e <strchr+0x29>
      return (char*)s;
    1378:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    137c:	eb 15                	jmp    1393 <strchr+0x3e>
  for(; *s; s++)
    137e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1383:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1387:	0f b6 00             	movzbl (%rax),%eax
    138a:	84 c0                	test   %al,%al
    138c:	75 de                	jne    136c <strchr+0x17>
  return 0;
    138e:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1393:	c9                   	leave
    1394:	c3                   	ret

0000000000001395 <gets>:

char*
gets(char *buf, int max)
{
    1395:	f3 0f 1e fa          	endbr64
    1399:	55                   	push   %rbp
    139a:	48 89 e5             	mov    %rsp,%rbp
    139d:	48 83 ec 20          	sub    $0x20,%rsp
    13a1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    13a5:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    13a8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    13af:	eb 4f                	jmp    1400 <gets+0x6b>
    cc = read(0, &c, 1);
    13b1:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    13b5:	ba 01 00 00 00       	mov    $0x1,%edx
    13ba:	48 89 c6             	mov    %rax,%rsi
    13bd:	bf 00 00 00 00       	mov    $0x0,%edi
    13c2:	48 b8 7a 15 00 00 00 	movabs $0x157a,%rax
    13c9:	00 00 00 
    13cc:	ff d0                	call   *%rax
    13ce:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    13d1:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    13d5:	7e 36                	jle    140d <gets+0x78>
      break;
    buf[i++] = c;
    13d7:	8b 45 fc             	mov    -0x4(%rbp),%eax
    13da:	8d 50 01             	lea    0x1(%rax),%edx
    13dd:	89 55 fc             	mov    %edx,-0x4(%rbp)
    13e0:	48 63 d0             	movslq %eax,%rdx
    13e3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    13e7:	48 01 c2             	add    %rax,%rdx
    13ea:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    13ee:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    13f0:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    13f4:	3c 0a                	cmp    $0xa,%al
    13f6:	74 16                	je     140e <gets+0x79>
    13f8:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    13fc:	3c 0d                	cmp    $0xd,%al
    13fe:	74 0e                	je     140e <gets+0x79>
  for(i=0; i+1 < max; ){
    1400:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1403:	83 c0 01             	add    $0x1,%eax
    1406:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    1409:	7f a6                	jg     13b1 <gets+0x1c>
    140b:	eb 01                	jmp    140e <gets+0x79>
      break;
    140d:	90                   	nop
      break;
  }
  buf[i] = '\0';
    140e:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1411:	48 63 d0             	movslq %eax,%rdx
    1414:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1418:	48 01 d0             	add    %rdx,%rax
    141b:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    141e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    1422:	c9                   	leave
    1423:	c3                   	ret

0000000000001424 <stat>:

int
stat(char *n, struct stat *st)
{
    1424:	f3 0f 1e fa          	endbr64
    1428:	55                   	push   %rbp
    1429:	48 89 e5             	mov    %rsp,%rbp
    142c:	48 83 ec 20          	sub    $0x20,%rsp
    1430:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1434:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1438:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    143c:	be 00 00 00 00       	mov    $0x0,%esi
    1441:	48 89 c7             	mov    %rax,%rdi
    1444:	48 b8 bb 15 00 00 00 	movabs $0x15bb,%rax
    144b:	00 00 00 
    144e:	ff d0                	call   *%rax
    1450:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    1453:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1457:	79 07                	jns    1460 <stat+0x3c>
    return -1;
    1459:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    145e:	eb 2f                	jmp    148f <stat+0x6b>
  r = fstat(fd, st);
    1460:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1464:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1467:	48 89 d6             	mov    %rdx,%rsi
    146a:	89 c7                	mov    %eax,%edi
    146c:	48 b8 e2 15 00 00 00 	movabs $0x15e2,%rax
    1473:	00 00 00 
    1476:	ff d0                	call   *%rax
    1478:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    147b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    147e:	89 c7                	mov    %eax,%edi
    1480:	48 b8 94 15 00 00 00 	movabs $0x1594,%rax
    1487:	00 00 00 
    148a:	ff d0                	call   *%rax
  return r;
    148c:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    148f:	c9                   	leave
    1490:	c3                   	ret

0000000000001491 <atoi>:

int
atoi(const char *s)
{
    1491:	f3 0f 1e fa          	endbr64
    1495:	55                   	push   %rbp
    1496:	48 89 e5             	mov    %rsp,%rbp
    1499:	48 83 ec 18          	sub    $0x18,%rsp
    149d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    14a1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    14a8:	eb 28                	jmp    14d2 <atoi+0x41>
    n = n*10 + *s++ - '0';
    14aa:	8b 55 fc             	mov    -0x4(%rbp),%edx
    14ad:	89 d0                	mov    %edx,%eax
    14af:	c1 e0 02             	shl    $0x2,%eax
    14b2:	01 d0                	add    %edx,%eax
    14b4:	01 c0                	add    %eax,%eax
    14b6:	89 c1                	mov    %eax,%ecx
    14b8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    14bc:	48 8d 50 01          	lea    0x1(%rax),%rdx
    14c0:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    14c4:	0f b6 00             	movzbl (%rax),%eax
    14c7:	0f be c0             	movsbl %al,%eax
    14ca:	01 c8                	add    %ecx,%eax
    14cc:	83 e8 30             	sub    $0x30,%eax
    14cf:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    14d2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    14d6:	0f b6 00             	movzbl (%rax),%eax
    14d9:	3c 2f                	cmp    $0x2f,%al
    14db:	7e 0b                	jle    14e8 <atoi+0x57>
    14dd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    14e1:	0f b6 00             	movzbl (%rax),%eax
    14e4:	3c 39                	cmp    $0x39,%al
    14e6:	7e c2                	jle    14aa <atoi+0x19>
  return n;
    14e8:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    14eb:	c9                   	leave
    14ec:	c3                   	ret

00000000000014ed <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    14ed:	f3 0f 1e fa          	endbr64
    14f1:	55                   	push   %rbp
    14f2:	48 89 e5             	mov    %rsp,%rbp
    14f5:	48 83 ec 28          	sub    $0x28,%rsp
    14f9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    14fd:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    1501:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    1504:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1508:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    150c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1510:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    1514:	eb 1d                	jmp    1533 <memmove+0x46>
    *dst++ = *src++;
    1516:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    151a:	48 8d 42 01          	lea    0x1(%rdx),%rax
    151e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1522:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1526:	48 8d 48 01          	lea    0x1(%rax),%rcx
    152a:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    152e:	0f b6 12             	movzbl (%rdx),%edx
    1531:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    1533:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1536:	8d 50 ff             	lea    -0x1(%rax),%edx
    1539:	89 55 dc             	mov    %edx,-0x24(%rbp)
    153c:	85 c0                	test   %eax,%eax
    153e:	7f d6                	jg     1516 <memmove+0x29>
  return vdst;
    1540:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    1544:	c9                   	leave
    1545:	c3                   	ret

0000000000001546 <fork>:
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    1546:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    154d:	49 89 ca             	mov    %rcx,%r10
    1550:	0f 05                	syscall
    1552:	c3                   	ret

0000000000001553 <exit>:
SYSCALL(exit)
    1553:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    155a:	49 89 ca             	mov    %rcx,%r10
    155d:	0f 05                	syscall
    155f:	c3                   	ret

0000000000001560 <wait>:
SYSCALL(wait)
    1560:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    1567:	49 89 ca             	mov    %rcx,%r10
    156a:	0f 05                	syscall
    156c:	c3                   	ret

000000000000156d <pipe>:
SYSCALL(pipe)
    156d:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    1574:	49 89 ca             	mov    %rcx,%r10
    1577:	0f 05                	syscall
    1579:	c3                   	ret

000000000000157a <read>:
SYSCALL(read)
    157a:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    1581:	49 89 ca             	mov    %rcx,%r10
    1584:	0f 05                	syscall
    1586:	c3                   	ret

0000000000001587 <write>:
SYSCALL(write)
    1587:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    158e:	49 89 ca             	mov    %rcx,%r10
    1591:	0f 05                	syscall
    1593:	c3                   	ret

0000000000001594 <close>:
SYSCALL(close)
    1594:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    159b:	49 89 ca             	mov    %rcx,%r10
    159e:	0f 05                	syscall
    15a0:	c3                   	ret

00000000000015a1 <kill>:
SYSCALL(kill)
    15a1:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    15a8:	49 89 ca             	mov    %rcx,%r10
    15ab:	0f 05                	syscall
    15ad:	c3                   	ret

00000000000015ae <exec>:
SYSCALL(exec)
    15ae:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    15b5:	49 89 ca             	mov    %rcx,%r10
    15b8:	0f 05                	syscall
    15ba:	c3                   	ret

00000000000015bb <open>:
SYSCALL(open)
    15bb:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    15c2:	49 89 ca             	mov    %rcx,%r10
    15c5:	0f 05                	syscall
    15c7:	c3                   	ret

00000000000015c8 <mknod>:
SYSCALL(mknod)
    15c8:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    15cf:	49 89 ca             	mov    %rcx,%r10
    15d2:	0f 05                	syscall
    15d4:	c3                   	ret

00000000000015d5 <unlink>:
SYSCALL(unlink)
    15d5:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    15dc:	49 89 ca             	mov    %rcx,%r10
    15df:	0f 05                	syscall
    15e1:	c3                   	ret

00000000000015e2 <fstat>:
SYSCALL(fstat)
    15e2:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    15e9:	49 89 ca             	mov    %rcx,%r10
    15ec:	0f 05                	syscall
    15ee:	c3                   	ret

00000000000015ef <link>:
SYSCALL(link)
    15ef:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    15f6:	49 89 ca             	mov    %rcx,%r10
    15f9:	0f 05                	syscall
    15fb:	c3                   	ret

00000000000015fc <mkdir>:
SYSCALL(mkdir)
    15fc:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    1603:	49 89 ca             	mov    %rcx,%r10
    1606:	0f 05                	syscall
    1608:	c3                   	ret

0000000000001609 <chdir>:
SYSCALL(chdir)
    1609:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    1610:	49 89 ca             	mov    %rcx,%r10
    1613:	0f 05                	syscall
    1615:	c3                   	ret

0000000000001616 <dup>:
SYSCALL(dup)
    1616:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    161d:	49 89 ca             	mov    %rcx,%r10
    1620:	0f 05                	syscall
    1622:	c3                   	ret

0000000000001623 <getpid>:
SYSCALL(getpid)
    1623:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    162a:	49 89 ca             	mov    %rcx,%r10
    162d:	0f 05                	syscall
    162f:	c3                   	ret

0000000000001630 <sbrk>:
SYSCALL(sbrk)
    1630:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    1637:	49 89 ca             	mov    %rcx,%r10
    163a:	0f 05                	syscall
    163c:	c3                   	ret

000000000000163d <sleep>:
SYSCALL(sleep)
    163d:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    1644:	49 89 ca             	mov    %rcx,%r10
    1647:	0f 05                	syscall
    1649:	c3                   	ret

000000000000164a <uptime>:
SYSCALL(uptime)
    164a:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    1651:	49 89 ca             	mov    %rcx,%r10
    1654:	0f 05                	syscall
    1656:	c3                   	ret

0000000000001657 <send>:
SYSCALL(send)
    1657:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    165e:	49 89 ca             	mov    %rcx,%r10
    1661:	0f 05                	syscall
    1663:	c3                   	ret

0000000000001664 <recv>:
SYSCALL(recv)
    1664:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    166b:	49 89 ca             	mov    %rcx,%r10
    166e:	0f 05                	syscall
    1670:	c3                   	ret

0000000000001671 <register_fsserver>:
SYSCALL(register_fsserver)
    1671:	48 c7 c0 18 00 00 00 	mov    $0x18,%rax
    1678:	49 89 ca             	mov    %rcx,%r10
    167b:	0f 05                	syscall
    167d:	c3                   	ret
