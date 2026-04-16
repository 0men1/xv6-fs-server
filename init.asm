
_init:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
    1000:	f3 0f 1e fa          	endbr64
    1004:	55                   	push   %rbp
    1005:	48 89 e5             	mov    %rsp,%rbp
    1008:	48 83 ec 10          	sub    $0x10,%rsp
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
    100c:	be 02 00 00 00       	mov    $0x2,%esi
    1011:	48 b8 0b 1f 00 00 00 	movabs $0x1f0b,%rax
    1018:	00 00 00 
    101b:	48 89 c7             	mov    %rax,%rdi
    101e:	48 b8 47 15 00 00 00 	movabs $0x1547,%rax
    1025:	00 00 00 
    1028:	ff d0                	call   *%rax
    102a:	85 c0                	test   %eax,%eax
    102c:	79 41                	jns    106f <main+0x6f>
    mknod("console", 1, 1);
    102e:	ba 01 00 00 00       	mov    $0x1,%edx
    1033:	be 01 00 00 00       	mov    $0x1,%esi
    1038:	48 b8 0b 1f 00 00 00 	movabs $0x1f0b,%rax
    103f:	00 00 00 
    1042:	48 89 c7             	mov    %rax,%rdi
    1045:	48 b8 54 15 00 00 00 	movabs $0x1554,%rax
    104c:	00 00 00 
    104f:	ff d0                	call   *%rax
    open("console", O_RDWR);
    1051:	be 02 00 00 00       	mov    $0x2,%esi
    1056:	48 b8 0b 1f 00 00 00 	movabs $0x1f0b,%rax
    105d:	00 00 00 
    1060:	48 89 c7             	mov    %rax,%rdi
    1063:	48 b8 47 15 00 00 00 	movabs $0x1547,%rax
    106a:	00 00 00 
    106d:	ff d0                	call   *%rax
  }
  dup(0);  // stdout
    106f:	bf 00 00 00 00       	mov    $0x0,%edi
    1074:	48 b8 a2 15 00 00 00 	movabs $0x15a2,%rax
    107b:	00 00 00 
    107e:	ff d0                	call   *%rax
  dup(0);  // stderr
    1080:	bf 00 00 00 00       	mov    $0x0,%edi
    1085:	48 b8 a2 15 00 00 00 	movabs $0x15a2,%rax
    108c:	00 00 00 
    108f:	ff d0                	call   *%rax

  for(;;){
    printf(1, "init: starting sh\n");
    1091:	48 b8 13 1f 00 00 00 	movabs $0x1f13,%rax
    1098:	00 00 00 
    109b:	48 89 c6             	mov    %rax,%rsi
    109e:	bf 01 00 00 00       	mov    $0x1,%edi
    10a3:	b8 00 00 00 00       	mov    $0x0,%eax
    10a8:	48 ba f0 17 00 00 00 	movabs $0x17f0,%rdx
    10af:	00 00 00 
    10b2:	ff d2                	call   *%rdx
    pid = fork();
    10b4:	48 b8 d2 14 00 00 00 	movabs $0x14d2,%rax
    10bb:	00 00 00 
    10be:	ff d0                	call   *%rax
    10c0:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(pid < 0){
    10c3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    10c7:	79 2f                	jns    10f8 <main+0xf8>
      printf(1, "init: fork failed\n");
    10c9:	48 b8 26 1f 00 00 00 	movabs $0x1f26,%rax
    10d0:	00 00 00 
    10d3:	48 89 c6             	mov    %rax,%rsi
    10d6:	bf 01 00 00 00       	mov    $0x1,%edi
    10db:	b8 00 00 00 00       	mov    $0x0,%eax
    10e0:	48 ba f0 17 00 00 00 	movabs $0x17f0,%rdx
    10e7:	00 00 00 
    10ea:	ff d2                	call   *%rdx
      exit();
    10ec:	48 b8 df 14 00 00 00 	movabs $0x14df,%rax
    10f3:	00 00 00 
    10f6:	ff d0                	call   *%rax
    }
    if(pid == 0){
    10f8:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    10fc:	75 78                	jne    1176 <main+0x176>
      exec("sh", argv);
    10fe:	48 b8 10 20 00 00 00 	movabs $0x2010,%rax
    1105:	00 00 00 
    1108:	48 89 c6             	mov    %rax,%rsi
    110b:	48 b8 08 1f 00 00 00 	movabs $0x1f08,%rax
    1112:	00 00 00 
    1115:	48 89 c7             	mov    %rax,%rdi
    1118:	48 b8 3a 15 00 00 00 	movabs $0x153a,%rax
    111f:	00 00 00 
    1122:	ff d0                	call   *%rax
      printf(1, "init: exec sh failed\n");
    1124:	48 b8 39 1f 00 00 00 	movabs $0x1f39,%rax
    112b:	00 00 00 
    112e:	48 89 c6             	mov    %rax,%rsi
    1131:	bf 01 00 00 00       	mov    $0x1,%edi
    1136:	b8 00 00 00 00       	mov    $0x0,%eax
    113b:	48 ba f0 17 00 00 00 	movabs $0x17f0,%rdx
    1142:	00 00 00 
    1145:	ff d2                	call   *%rdx
      exit();
    1147:	48 b8 df 14 00 00 00 	movabs $0x14df,%rax
    114e:	00 00 00 
    1151:	ff d0                	call   *%rax
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
    1153:	48 b8 4f 1f 00 00 00 	movabs $0x1f4f,%rax
    115a:	00 00 00 
    115d:	48 89 c6             	mov    %rax,%rsi
    1160:	bf 01 00 00 00       	mov    $0x1,%edi
    1165:	b8 00 00 00 00       	mov    $0x0,%eax
    116a:	48 ba f0 17 00 00 00 	movabs $0x17f0,%rdx
    1171:	00 00 00 
    1174:	ff d2                	call   *%rdx
    while((wpid=wait()) >= 0 && wpid != pid)
    1176:	48 b8 ec 14 00 00 00 	movabs $0x14ec,%rax
    117d:	00 00 00 
    1180:	ff d0                	call   *%rax
    1182:	89 45 f8             	mov    %eax,-0x8(%rbp)
    1185:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1189:	0f 88 02 ff ff ff    	js     1091 <main+0x91>
    118f:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1192:	3b 45 fc             	cmp    -0x4(%rbp),%eax
    1195:	75 bc                	jne    1153 <main+0x153>
    printf(1, "init: starting sh\n");
    1197:	e9 f5 fe ff ff       	jmp    1091 <main+0x91>

000000000000119c <stosb>:
  stosb(dst, c, n);
  return dst;
}

char*
strchr(const char *s, char c)
    119c:	f3 0f 1e fa          	endbr64
    11a0:	55                   	push   %rbp
    11a1:	48 89 e5             	mov    %rsp,%rbp
    11a4:	48 83 ec 10          	sub    $0x10,%rsp
    11a8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    11ac:	89 75 f4             	mov    %esi,-0xc(%rbp)
    11af:	89 55 f0             	mov    %edx,-0x10(%rbp)
{
    11b2:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    11b6:	8b 55 f0             	mov    -0x10(%rbp),%edx
    11b9:	8b 45 f4             	mov    -0xc(%rbp),%eax
    11bc:	48 89 ce             	mov    %rcx,%rsi
    11bf:	48 89 f7             	mov    %rsi,%rdi
    11c2:	89 d1                	mov    %edx,%ecx
    11c4:	fc                   	cld
    11c5:	f3 aa                	rep stos %al,%es:(%rdi)
    11c7:	89 ca                	mov    %ecx,%edx
    11c9:	48 89 fe             	mov    %rdi,%rsi
    11cc:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    11d0:	89 55 f0             	mov    %edx,-0x10(%rbp)
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
    11d3:	90                   	nop
    11d4:	c9                   	leave
    11d5:	c3                   	ret

00000000000011d6 <strcpy>:
{
    11d6:	f3 0f 1e fa          	endbr64
    11da:	55                   	push   %rbp
    11db:	48 89 e5             	mov    %rsp,%rbp
    11de:	48 83 ec 20          	sub    $0x20,%rsp
    11e2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    11e6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  os = s;
    11ea:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    11ee:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    11f2:	90                   	nop
    11f3:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    11f7:	48 8d 42 01          	lea    0x1(%rdx),%rax
    11fb:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    11ff:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1203:	48 8d 48 01          	lea    0x1(%rax),%rcx
    1207:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    120b:	0f b6 12             	movzbl (%rdx),%edx
    120e:	88 10                	mov    %dl,(%rax)
    1210:	0f b6 00             	movzbl (%rax),%eax
    1213:	84 c0                	test   %al,%al
    1215:	75 dc                	jne    11f3 <strcpy+0x1d>
  return os;
    1217:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    121b:	c9                   	leave
    121c:	c3                   	ret

000000000000121d <strcmp>:
{
    121d:	f3 0f 1e fa          	endbr64
    1221:	55                   	push   %rbp
    1222:	48 89 e5             	mov    %rsp,%rbp
    1225:	48 83 ec 10          	sub    $0x10,%rsp
    1229:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    122d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    1231:	eb 0a                	jmp    123d <strcmp+0x20>
    p++, q++;
    1233:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1238:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    123d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1241:	0f b6 00             	movzbl (%rax),%eax
    1244:	84 c0                	test   %al,%al
    1246:	74 12                	je     125a <strcmp+0x3d>
    1248:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    124c:	0f b6 10             	movzbl (%rax),%edx
    124f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1253:	0f b6 00             	movzbl (%rax),%eax
    1256:	38 c2                	cmp    %al,%dl
    1258:	74 d9                	je     1233 <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
    125a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    125e:	0f b6 00             	movzbl (%rax),%eax
    1261:	0f b6 d0             	movzbl %al,%edx
    1264:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1268:	0f b6 00             	movzbl (%rax),%eax
    126b:	0f b6 c0             	movzbl %al,%eax
    126e:	29 c2                	sub    %eax,%edx
    1270:	89 d0                	mov    %edx,%eax
}
    1272:	c9                   	leave
    1273:	c3                   	ret

0000000000001274 <strlen>:
{
    1274:	f3 0f 1e fa          	endbr64
    1278:	55                   	push   %rbp
    1279:	48 89 e5             	mov    %rsp,%rbp
    127c:	48 83 ec 18          	sub    $0x18,%rsp
    1280:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  for(n = 0; s[n]; n++)
    1284:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    128b:	eb 04                	jmp    1291 <strlen+0x1d>
    128d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1291:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1294:	48 63 d0             	movslq %eax,%rdx
    1297:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    129b:	48 01 d0             	add    %rdx,%rax
    129e:	0f b6 00             	movzbl (%rax),%eax
    12a1:	84 c0                	test   %al,%al
    12a3:	75 e8                	jne    128d <strlen+0x19>
  return n;
    12a5:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    12a8:	c9                   	leave
    12a9:	c3                   	ret

00000000000012aa <memset>:
{
    12aa:	f3 0f 1e fa          	endbr64
    12ae:	55                   	push   %rbp
    12af:	48 89 e5             	mov    %rsp,%rbp
    12b2:	48 83 ec 10          	sub    $0x10,%rsp
    12b6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    12ba:	89 75 f4             	mov    %esi,-0xc(%rbp)
    12bd:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    12c0:	8b 55 f0             	mov    -0x10(%rbp),%edx
    12c3:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    12c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    12ca:	89 ce                	mov    %ecx,%esi
    12cc:	48 89 c7             	mov    %rax,%rdi
    12cf:	48 b8 9c 11 00 00 00 	movabs $0x119c,%rax
    12d6:	00 00 00 
    12d9:	ff d0                	call   *%rax
  return dst;
    12db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    12df:	c9                   	leave
    12e0:	c3                   	ret

00000000000012e1 <strchr>:
{
    12e1:	f3 0f 1e fa          	endbr64
    12e5:	55                   	push   %rbp
    12e6:	48 89 e5             	mov    %rsp,%rbp
    12e9:	48 83 ec 10          	sub    $0x10,%rsp
    12ed:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    12f1:	89 f0                	mov    %esi,%eax
    12f3:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    12f6:	eb 17                	jmp    130f <strchr+0x2e>
    if(*s == c)
    12f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    12fc:	0f b6 00             	movzbl (%rax),%eax
    12ff:	38 45 f4             	cmp    %al,-0xc(%rbp)
    1302:	75 06                	jne    130a <strchr+0x29>
      return (char*)s;
    1304:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1308:	eb 15                	jmp    131f <strchr+0x3e>
  for(; *s; s++)
    130a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    130f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1313:	0f b6 00             	movzbl (%rax),%eax
    1316:	84 c0                	test   %al,%al
    1318:	75 de                	jne    12f8 <strchr+0x17>
  return 0;
    131a:	b8 00 00 00 00       	mov    $0x0,%eax
}
    131f:	c9                   	leave
    1320:	c3                   	ret

0000000000001321 <gets>:

char*
gets(char *buf, int max)
{
    1321:	f3 0f 1e fa          	endbr64
    1325:	55                   	push   %rbp
    1326:	48 89 e5             	mov    %rsp,%rbp
    1329:	48 83 ec 20          	sub    $0x20,%rsp
    132d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1331:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1334:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    133b:	eb 4f                	jmp    138c <gets+0x6b>
    cc = read(0, &c, 1);
    133d:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    1341:	ba 01 00 00 00       	mov    $0x1,%edx
    1346:	48 89 c6             	mov    %rax,%rsi
    1349:	bf 00 00 00 00       	mov    $0x0,%edi
    134e:	48 b8 06 15 00 00 00 	movabs $0x1506,%rax
    1355:	00 00 00 
    1358:	ff d0                	call   *%rax
    135a:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    135d:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1361:	7e 36                	jle    1399 <gets+0x78>
      break;
    buf[i++] = c;
    1363:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1366:	8d 50 01             	lea    0x1(%rax),%edx
    1369:	89 55 fc             	mov    %edx,-0x4(%rbp)
    136c:	48 63 d0             	movslq %eax,%rdx
    136f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1373:	48 01 c2             	add    %rax,%rdx
    1376:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    137a:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    137c:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1380:	3c 0a                	cmp    $0xa,%al
    1382:	74 16                	je     139a <gets+0x79>
    1384:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1388:	3c 0d                	cmp    $0xd,%al
    138a:	74 0e                	je     139a <gets+0x79>
  for(i=0; i+1 < max; ){
    138c:	8b 45 fc             	mov    -0x4(%rbp),%eax
    138f:	83 c0 01             	add    $0x1,%eax
    1392:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    1395:	7f a6                	jg     133d <gets+0x1c>
    1397:	eb 01                	jmp    139a <gets+0x79>
      break;
    1399:	90                   	nop
      break;
  }
  buf[i] = '\0';
    139a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    139d:	48 63 d0             	movslq %eax,%rdx
    13a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    13a4:	48 01 d0             	add    %rdx,%rax
    13a7:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    13aa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    13ae:	c9                   	leave
    13af:	c3                   	ret

00000000000013b0 <stat>:

int
stat(char *n, struct stat *st)
{
    13b0:	f3 0f 1e fa          	endbr64
    13b4:	55                   	push   %rbp
    13b5:	48 89 e5             	mov    %rsp,%rbp
    13b8:	48 83 ec 20          	sub    $0x20,%rsp
    13bc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    13c0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    13c4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    13c8:	be 00 00 00 00       	mov    $0x0,%esi
    13cd:	48 89 c7             	mov    %rax,%rdi
    13d0:	48 b8 47 15 00 00 00 	movabs $0x1547,%rax
    13d7:	00 00 00 
    13da:	ff d0                	call   *%rax
    13dc:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    13df:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    13e3:	79 07                	jns    13ec <stat+0x3c>
    return -1;
    13e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    13ea:	eb 2f                	jmp    141b <stat+0x6b>
  r = fstat(fd, st);
    13ec:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    13f0:	8b 45 fc             	mov    -0x4(%rbp),%eax
    13f3:	48 89 d6             	mov    %rdx,%rsi
    13f6:	89 c7                	mov    %eax,%edi
    13f8:	48 b8 6e 15 00 00 00 	movabs $0x156e,%rax
    13ff:	00 00 00 
    1402:	ff d0                	call   *%rax
    1404:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    1407:	8b 45 fc             	mov    -0x4(%rbp),%eax
    140a:	89 c7                	mov    %eax,%edi
    140c:	48 b8 20 15 00 00 00 	movabs $0x1520,%rax
    1413:	00 00 00 
    1416:	ff d0                	call   *%rax
  return r;
    1418:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    141b:	c9                   	leave
    141c:	c3                   	ret

000000000000141d <atoi>:

int
atoi(const char *s)
{
    141d:	f3 0f 1e fa          	endbr64
    1421:	55                   	push   %rbp
    1422:	48 89 e5             	mov    %rsp,%rbp
    1425:	48 83 ec 18          	sub    $0x18,%rsp
    1429:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    142d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1434:	eb 28                	jmp    145e <atoi+0x41>
    n = n*10 + *s++ - '0';
    1436:	8b 55 fc             	mov    -0x4(%rbp),%edx
    1439:	89 d0                	mov    %edx,%eax
    143b:	c1 e0 02             	shl    $0x2,%eax
    143e:	01 d0                	add    %edx,%eax
    1440:	01 c0                	add    %eax,%eax
    1442:	89 c1                	mov    %eax,%ecx
    1444:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1448:	48 8d 50 01          	lea    0x1(%rax),%rdx
    144c:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    1450:	0f b6 00             	movzbl (%rax),%eax
    1453:	0f be c0             	movsbl %al,%eax
    1456:	01 c8                	add    %ecx,%eax
    1458:	83 e8 30             	sub    $0x30,%eax
    145b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    145e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1462:	0f b6 00             	movzbl (%rax),%eax
    1465:	3c 2f                	cmp    $0x2f,%al
    1467:	7e 0b                	jle    1474 <atoi+0x57>
    1469:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    146d:	0f b6 00             	movzbl (%rax),%eax
    1470:	3c 39                	cmp    $0x39,%al
    1472:	7e c2                	jle    1436 <atoi+0x19>
  return n;
    1474:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    1477:	c9                   	leave
    1478:	c3                   	ret

0000000000001479 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1479:	f3 0f 1e fa          	endbr64
    147d:	55                   	push   %rbp
    147e:	48 89 e5             	mov    %rsp,%rbp
    1481:	48 83 ec 28          	sub    $0x28,%rsp
    1485:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1489:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    148d:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    1490:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1494:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    1498:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    149c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    14a0:	eb 1d                	jmp    14bf <memmove+0x46>
    *dst++ = *src++;
    14a2:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    14a6:	48 8d 42 01          	lea    0x1(%rdx),%rax
    14aa:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    14ae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    14b2:	48 8d 48 01          	lea    0x1(%rax),%rcx
    14b6:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    14ba:	0f b6 12             	movzbl (%rdx),%edx
    14bd:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    14bf:	8b 45 dc             	mov    -0x24(%rbp),%eax
    14c2:	8d 50 ff             	lea    -0x1(%rax),%edx
    14c5:	89 55 dc             	mov    %edx,-0x24(%rbp)
    14c8:	85 c0                	test   %eax,%eax
    14ca:	7f d6                	jg     14a2 <memmove+0x29>
  return vdst;
    14cc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    14d0:	c9                   	leave
    14d1:	c3                   	ret

00000000000014d2 <fork>:
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    14d2:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    14d9:	49 89 ca             	mov    %rcx,%r10
    14dc:	0f 05                	syscall
    14de:	c3                   	ret

00000000000014df <exit>:
SYSCALL(exit)
    14df:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    14e6:	49 89 ca             	mov    %rcx,%r10
    14e9:	0f 05                	syscall
    14eb:	c3                   	ret

00000000000014ec <wait>:
SYSCALL(wait)
    14ec:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    14f3:	49 89 ca             	mov    %rcx,%r10
    14f6:	0f 05                	syscall
    14f8:	c3                   	ret

00000000000014f9 <pipe>:
SYSCALL(pipe)
    14f9:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    1500:	49 89 ca             	mov    %rcx,%r10
    1503:	0f 05                	syscall
    1505:	c3                   	ret

0000000000001506 <read>:
SYSCALL(read)
    1506:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    150d:	49 89 ca             	mov    %rcx,%r10
    1510:	0f 05                	syscall
    1512:	c3                   	ret

0000000000001513 <write>:
SYSCALL(write)
    1513:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    151a:	49 89 ca             	mov    %rcx,%r10
    151d:	0f 05                	syscall
    151f:	c3                   	ret

0000000000001520 <close>:
SYSCALL(close)
    1520:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    1527:	49 89 ca             	mov    %rcx,%r10
    152a:	0f 05                	syscall
    152c:	c3                   	ret

000000000000152d <kill>:
SYSCALL(kill)
    152d:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    1534:	49 89 ca             	mov    %rcx,%r10
    1537:	0f 05                	syscall
    1539:	c3                   	ret

000000000000153a <exec>:
SYSCALL(exec)
    153a:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    1541:	49 89 ca             	mov    %rcx,%r10
    1544:	0f 05                	syscall
    1546:	c3                   	ret

0000000000001547 <open>:
SYSCALL(open)
    1547:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    154e:	49 89 ca             	mov    %rcx,%r10
    1551:	0f 05                	syscall
    1553:	c3                   	ret

0000000000001554 <mknod>:
SYSCALL(mknod)
    1554:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    155b:	49 89 ca             	mov    %rcx,%r10
    155e:	0f 05                	syscall
    1560:	c3                   	ret

0000000000001561 <unlink>:
SYSCALL(unlink)
    1561:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    1568:	49 89 ca             	mov    %rcx,%r10
    156b:	0f 05                	syscall
    156d:	c3                   	ret

000000000000156e <fstat>:
SYSCALL(fstat)
    156e:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    1575:	49 89 ca             	mov    %rcx,%r10
    1578:	0f 05                	syscall
    157a:	c3                   	ret

000000000000157b <link>:
SYSCALL(link)
    157b:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    1582:	49 89 ca             	mov    %rcx,%r10
    1585:	0f 05                	syscall
    1587:	c3                   	ret

0000000000001588 <mkdir>:
SYSCALL(mkdir)
    1588:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    158f:	49 89 ca             	mov    %rcx,%r10
    1592:	0f 05                	syscall
    1594:	c3                   	ret

0000000000001595 <chdir>:
SYSCALL(chdir)
    1595:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    159c:	49 89 ca             	mov    %rcx,%r10
    159f:	0f 05                	syscall
    15a1:	c3                   	ret

00000000000015a2 <dup>:
SYSCALL(dup)
    15a2:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    15a9:	49 89 ca             	mov    %rcx,%r10
    15ac:	0f 05                	syscall
    15ae:	c3                   	ret

00000000000015af <getpid>:
SYSCALL(getpid)
    15af:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    15b6:	49 89 ca             	mov    %rcx,%r10
    15b9:	0f 05                	syscall
    15bb:	c3                   	ret

00000000000015bc <sbrk>:
SYSCALL(sbrk)
    15bc:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    15c3:	49 89 ca             	mov    %rcx,%r10
    15c6:	0f 05                	syscall
    15c8:	c3                   	ret

00000000000015c9 <sleep>:
SYSCALL(sleep)
    15c9:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    15d0:	49 89 ca             	mov    %rcx,%r10
    15d3:	0f 05                	syscall
    15d5:	c3                   	ret

00000000000015d6 <uptime>:
SYSCALL(uptime)
    15d6:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    15dd:	49 89 ca             	mov    %rcx,%r10
    15e0:	0f 05                	syscall
    15e2:	c3                   	ret

00000000000015e3 <send>:
SYSCALL(send)
    15e3:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    15ea:	49 89 ca             	mov    %rcx,%r10
    15ed:	0f 05                	syscall
    15ef:	c3                   	ret

00000000000015f0 <recv>:
SYSCALL(recv)
    15f0:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    15f7:	49 89 ca             	mov    %rcx,%r10
    15fa:	0f 05                	syscall
    15fc:	c3                   	ret

00000000000015fd <register_fsserver>:
SYSCALL(register_fsserver)
    15fd:	48 c7 c0 18 00 00 00 	mov    $0x18,%rax
    1604:	49 89 ca             	mov    %rcx,%r10
    1607:	0f 05                	syscall
    1609:	c3                   	ret

000000000000160a <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    160a:	f3 0f 1e fa          	endbr64
    160e:	55                   	push   %rbp
    160f:	48 89 e5             	mov    %rsp,%rbp
    1612:	48 83 ec 10          	sub    $0x10,%rsp
    1616:	89 7d fc             	mov    %edi,-0x4(%rbp)
    1619:	89 f0                	mov    %esi,%eax
    161b:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    161e:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    1622:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1625:	ba 01 00 00 00       	mov    $0x1,%edx
    162a:	48 89 ce             	mov    %rcx,%rsi
    162d:	89 c7                	mov    %eax,%edi
    162f:	48 b8 13 15 00 00 00 	movabs $0x1513,%rax
    1636:	00 00 00 
    1639:	ff d0                	call   *%rax
}
    163b:	90                   	nop
    163c:	c9                   	leave
    163d:	c3                   	ret

000000000000163e <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    163e:	f3 0f 1e fa          	endbr64
    1642:	55                   	push   %rbp
    1643:	48 89 e5             	mov    %rsp,%rbp
    1646:	48 83 ec 20          	sub    $0x20,%rsp
    164a:	89 7d ec             	mov    %edi,-0x14(%rbp)
    164d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1651:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1658:	eb 35                	jmp    168f <print_x64+0x51>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    165a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    165e:	48 c1 e8 3c          	shr    $0x3c,%rax
    1662:	48 ba 20 20 00 00 00 	movabs $0x2020,%rdx
    1669:	00 00 00 
    166c:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1670:	0f be d0             	movsbl %al,%edx
    1673:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1676:	89 d6                	mov    %edx,%esi
    1678:	89 c7                	mov    %eax,%edi
    167a:	48 b8 0a 16 00 00 00 	movabs $0x160a,%rax
    1681:	00 00 00 
    1684:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1686:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    168a:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    168f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1692:	83 f8 0f             	cmp    $0xf,%eax
    1695:	76 c3                	jbe    165a <print_x64+0x1c>
}
    1697:	90                   	nop
    1698:	90                   	nop
    1699:	c9                   	leave
    169a:	c3                   	ret

000000000000169b <print_x32>:

  static void
print_x32(int fd, uint x)
{
    169b:	f3 0f 1e fa          	endbr64
    169f:	55                   	push   %rbp
    16a0:	48 89 e5             	mov    %rsp,%rbp
    16a3:	48 83 ec 20          	sub    $0x20,%rsp
    16a7:	89 7d ec             	mov    %edi,-0x14(%rbp)
    16aa:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    16ad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    16b4:	eb 36                	jmp    16ec <print_x32+0x51>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    16b6:	8b 45 e8             	mov    -0x18(%rbp),%eax
    16b9:	c1 e8 1c             	shr    $0x1c,%eax
    16bc:	89 c2                	mov    %eax,%edx
    16be:	48 b8 20 20 00 00 00 	movabs $0x2020,%rax
    16c5:	00 00 00 
    16c8:	89 d2                	mov    %edx,%edx
    16ca:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    16ce:	0f be d0             	movsbl %al,%edx
    16d1:	8b 45 ec             	mov    -0x14(%rbp),%eax
    16d4:	89 d6                	mov    %edx,%esi
    16d6:	89 c7                	mov    %eax,%edi
    16d8:	48 b8 0a 16 00 00 00 	movabs $0x160a,%rax
    16df:	00 00 00 
    16e2:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    16e4:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    16e8:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    16ec:	8b 45 fc             	mov    -0x4(%rbp),%eax
    16ef:	83 f8 07             	cmp    $0x7,%eax
    16f2:	76 c2                	jbe    16b6 <print_x32+0x1b>
}
    16f4:	90                   	nop
    16f5:	90                   	nop
    16f6:	c9                   	leave
    16f7:	c3                   	ret

00000000000016f8 <print_d>:

  static void
print_d(int fd, int v)
{
    16f8:	f3 0f 1e fa          	endbr64
    16fc:	55                   	push   %rbp
    16fd:	48 89 e5             	mov    %rsp,%rbp
    1700:	48 83 ec 30          	sub    $0x30,%rsp
    1704:	89 7d dc             	mov    %edi,-0x24(%rbp)
    1707:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    170a:	8b 45 d8             	mov    -0x28(%rbp),%eax
    170d:	48 98                	cltq
    170f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    1713:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1717:	79 04                	jns    171d <print_d+0x25>
    x = -x;
    1719:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    171d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    1724:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1728:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    172f:	66 66 66 
    1732:	48 89 c8             	mov    %rcx,%rax
    1735:	48 f7 ea             	imul   %rdx
    1738:	48 c1 fa 02          	sar    $0x2,%rdx
    173c:	48 89 c8             	mov    %rcx,%rax
    173f:	48 c1 f8 3f          	sar    $0x3f,%rax
    1743:	48 29 c2             	sub    %rax,%rdx
    1746:	48 89 d0             	mov    %rdx,%rax
    1749:	48 c1 e0 02          	shl    $0x2,%rax
    174d:	48 01 d0             	add    %rdx,%rax
    1750:	48 01 c0             	add    %rax,%rax
    1753:	48 29 c1             	sub    %rax,%rcx
    1756:	48 89 ca             	mov    %rcx,%rdx
    1759:	8b 45 f4             	mov    -0xc(%rbp),%eax
    175c:	8d 48 01             	lea    0x1(%rax),%ecx
    175f:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    1762:	48 b9 20 20 00 00 00 	movabs $0x2020,%rcx
    1769:	00 00 00 
    176c:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    1770:	48 98                	cltq
    1772:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    1776:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    177a:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1781:	66 66 66 
    1784:	48 89 c8             	mov    %rcx,%rax
    1787:	48 f7 ea             	imul   %rdx
    178a:	48 89 d0             	mov    %rdx,%rax
    178d:	48 c1 f8 02          	sar    $0x2,%rax
    1791:	48 c1 f9 3f          	sar    $0x3f,%rcx
    1795:	48 89 ca             	mov    %rcx,%rdx
    1798:	48 29 d0             	sub    %rdx,%rax
    179b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    179f:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    17a4:	0f 85 7a ff ff ff    	jne    1724 <print_d+0x2c>

  if (v < 0)
    17aa:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    17ae:	79 32                	jns    17e2 <print_d+0xea>
    buf[i++] = '-';
    17b0:	8b 45 f4             	mov    -0xc(%rbp),%eax
    17b3:	8d 50 01             	lea    0x1(%rax),%edx
    17b6:	89 55 f4             	mov    %edx,-0xc(%rbp)
    17b9:	48 98                	cltq
    17bb:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    17c0:	eb 20                	jmp    17e2 <print_d+0xea>
    putc(fd, buf[i]);
    17c2:	8b 45 f4             	mov    -0xc(%rbp),%eax
    17c5:	48 98                	cltq
    17c7:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    17cc:	0f be d0             	movsbl %al,%edx
    17cf:	8b 45 dc             	mov    -0x24(%rbp),%eax
    17d2:	89 d6                	mov    %edx,%esi
    17d4:	89 c7                	mov    %eax,%edi
    17d6:	48 b8 0a 16 00 00 00 	movabs $0x160a,%rax
    17dd:	00 00 00 
    17e0:	ff d0                	call   *%rax
  while (--i >= 0)
    17e2:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    17e6:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    17ea:	79 d6                	jns    17c2 <print_d+0xca>
}
    17ec:	90                   	nop
    17ed:	90                   	nop
    17ee:	c9                   	leave
    17ef:	c3                   	ret

00000000000017f0 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    17f0:	f3 0f 1e fa          	endbr64
    17f4:	55                   	push   %rbp
    17f5:	48 89 e5             	mov    %rsp,%rbp
    17f8:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    17ff:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    1805:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    180c:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    1813:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    181a:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    1821:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    1828:	84 c0                	test   %al,%al
    182a:	74 20                	je     184c <printf+0x5c>
    182c:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    1830:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    1834:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    1838:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    183c:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    1840:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    1844:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    1848:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    184c:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    1853:	00 00 00 
    1856:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    185d:	00 00 00 
    1860:	48 8d 45 10          	lea    0x10(%rbp),%rax
    1864:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    186b:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    1872:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1879:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    1880:	00 00 00 
    1883:	e9 41 03 00 00       	jmp    1bc9 <printf+0x3d9>
    if (c != '%') {
    1888:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    188f:	74 24                	je     18b5 <printf+0xc5>
      putc(fd, c);
    1891:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1897:	0f be d0             	movsbl %al,%edx
    189a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    18a0:	89 d6                	mov    %edx,%esi
    18a2:	89 c7                	mov    %eax,%edi
    18a4:	48 b8 0a 16 00 00 00 	movabs $0x160a,%rax
    18ab:	00 00 00 
    18ae:	ff d0                	call   *%rax
      continue;
    18b0:	e9 0d 03 00 00       	jmp    1bc2 <printf+0x3d2>
    }
    c = fmt[++i] & 0xff;
    18b5:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    18bc:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    18c2:	48 63 d0             	movslq %eax,%rdx
    18c5:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    18cc:	48 01 d0             	add    %rdx,%rax
    18cf:	0f b6 00             	movzbl (%rax),%eax
    18d2:	0f be c0             	movsbl %al,%eax
    18d5:	25 ff 00 00 00       	and    $0xff,%eax
    18da:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    18e0:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    18e7:	0f 84 0f 03 00 00    	je     1bfc <printf+0x40c>
      break;
    switch(c) {
    18ed:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    18f4:	0f 84 74 02 00 00    	je     1b6e <printf+0x37e>
    18fa:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1901:	0f 8c 82 02 00 00    	jl     1b89 <printf+0x399>
    1907:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    190e:	0f 8f 75 02 00 00    	jg     1b89 <printf+0x399>
    1914:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    191b:	0f 8c 68 02 00 00    	jl     1b89 <printf+0x399>
    1921:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1927:	83 e8 63             	sub    $0x63,%eax
    192a:	83 f8 15             	cmp    $0x15,%eax
    192d:	0f 87 56 02 00 00    	ja     1b89 <printf+0x399>
    1933:	89 c0                	mov    %eax,%eax
    1935:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    193c:	00 
    193d:	48 b8 60 1f 00 00 00 	movabs $0x1f60,%rax
    1944:	00 00 00 
    1947:	48 01 d0             	add    %rdx,%rax
    194a:	48 8b 00             	mov    (%rax),%rax
    194d:	3e ff e0             	notrack jmp *%rax
    case 'c':
      putc(fd, va_arg(ap, int));
    1950:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1956:	83 f8 2f             	cmp    $0x2f,%eax
    1959:	77 23                	ja     197e <printf+0x18e>
    195b:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1962:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1968:	89 d2                	mov    %edx,%edx
    196a:	48 01 d0             	add    %rdx,%rax
    196d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1973:	83 c2 08             	add    $0x8,%edx
    1976:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    197c:	eb 12                	jmp    1990 <printf+0x1a0>
    197e:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1985:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1989:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1990:	8b 00                	mov    (%rax),%eax
    1992:	0f be d0             	movsbl %al,%edx
    1995:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    199b:	89 d6                	mov    %edx,%esi
    199d:	89 c7                	mov    %eax,%edi
    199f:	48 b8 0a 16 00 00 00 	movabs $0x160a,%rax
    19a6:	00 00 00 
    19a9:	ff d0                	call   *%rax
      break;
    19ab:	e9 12 02 00 00       	jmp    1bc2 <printf+0x3d2>
    case 'd':
      print_d(fd, va_arg(ap, int));
    19b0:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    19b6:	83 f8 2f             	cmp    $0x2f,%eax
    19b9:	77 23                	ja     19de <printf+0x1ee>
    19bb:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    19c2:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19c8:	89 d2                	mov    %edx,%edx
    19ca:	48 01 d0             	add    %rdx,%rax
    19cd:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19d3:	83 c2 08             	add    $0x8,%edx
    19d6:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    19dc:	eb 12                	jmp    19f0 <printf+0x200>
    19de:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    19e5:	48 8d 50 08          	lea    0x8(%rax),%rdx
    19e9:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    19f0:	8b 10                	mov    (%rax),%edx
    19f2:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    19f8:	89 d6                	mov    %edx,%esi
    19fa:	89 c7                	mov    %eax,%edi
    19fc:	48 b8 f8 16 00 00 00 	movabs $0x16f8,%rax
    1a03:	00 00 00 
    1a06:	ff d0                	call   *%rax
      break;
    1a08:	e9 b5 01 00 00       	jmp    1bc2 <printf+0x3d2>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    1a0d:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1a13:	83 f8 2f             	cmp    $0x2f,%eax
    1a16:	77 23                	ja     1a3b <printf+0x24b>
    1a18:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1a1f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a25:	89 d2                	mov    %edx,%edx
    1a27:	48 01 d0             	add    %rdx,%rax
    1a2a:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a30:	83 c2 08             	add    $0x8,%edx
    1a33:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1a39:	eb 12                	jmp    1a4d <printf+0x25d>
    1a3b:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a42:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a46:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a4d:	8b 10                	mov    (%rax),%edx
    1a4f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a55:	89 d6                	mov    %edx,%esi
    1a57:	89 c7                	mov    %eax,%edi
    1a59:	48 b8 9b 16 00 00 00 	movabs $0x169b,%rax
    1a60:	00 00 00 
    1a63:	ff d0                	call   *%rax
      break;
    1a65:	e9 58 01 00 00       	jmp    1bc2 <printf+0x3d2>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    1a6a:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1a70:	83 f8 2f             	cmp    $0x2f,%eax
    1a73:	77 23                	ja     1a98 <printf+0x2a8>
    1a75:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1a7c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a82:	89 d2                	mov    %edx,%edx
    1a84:	48 01 d0             	add    %rdx,%rax
    1a87:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a8d:	83 c2 08             	add    $0x8,%edx
    1a90:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1a96:	eb 12                	jmp    1aaa <printf+0x2ba>
    1a98:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a9f:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1aa3:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1aaa:	48 8b 10             	mov    (%rax),%rdx
    1aad:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1ab3:	48 89 d6             	mov    %rdx,%rsi
    1ab6:	89 c7                	mov    %eax,%edi
    1ab8:	48 b8 3e 16 00 00 00 	movabs $0x163e,%rax
    1abf:	00 00 00 
    1ac2:	ff d0                	call   *%rax
      break;
    1ac4:	e9 f9 00 00 00       	jmp    1bc2 <printf+0x3d2>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    1ac9:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1acf:	83 f8 2f             	cmp    $0x2f,%eax
    1ad2:	77 23                	ja     1af7 <printf+0x307>
    1ad4:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1adb:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1ae1:	89 d2                	mov    %edx,%edx
    1ae3:	48 01 d0             	add    %rdx,%rax
    1ae6:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1aec:	83 c2 08             	add    $0x8,%edx
    1aef:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1af5:	eb 12                	jmp    1b09 <printf+0x319>
    1af7:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1afe:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1b02:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1b09:	48 8b 00             	mov    (%rax),%rax
    1b0c:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    1b13:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1b1a:	00 
    1b1b:	75 41                	jne    1b5e <printf+0x36e>
        s = "(null)";
    1b1d:	48 b8 58 1f 00 00 00 	movabs $0x1f58,%rax
    1b24:	00 00 00 
    1b27:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1b2e:	eb 2e                	jmp    1b5e <printf+0x36e>
        putc(fd, *(s++));
    1b30:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1b37:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1b3b:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1b42:	0f b6 00             	movzbl (%rax),%eax
    1b45:	0f be d0             	movsbl %al,%edx
    1b48:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b4e:	89 d6                	mov    %edx,%esi
    1b50:	89 c7                	mov    %eax,%edi
    1b52:	48 b8 0a 16 00 00 00 	movabs $0x160a,%rax
    1b59:	00 00 00 
    1b5c:	ff d0                	call   *%rax
      while (*s)
    1b5e:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1b65:	0f b6 00             	movzbl (%rax),%eax
    1b68:	84 c0                	test   %al,%al
    1b6a:	75 c4                	jne    1b30 <printf+0x340>
      break;
    1b6c:	eb 54                	jmp    1bc2 <printf+0x3d2>
    case '%':
      putc(fd, '%');
    1b6e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b74:	be 25 00 00 00       	mov    $0x25,%esi
    1b79:	89 c7                	mov    %eax,%edi
    1b7b:	48 b8 0a 16 00 00 00 	movabs $0x160a,%rax
    1b82:	00 00 00 
    1b85:	ff d0                	call   *%rax
      break;
    1b87:	eb 39                	jmp    1bc2 <printf+0x3d2>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1b89:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b8f:	be 25 00 00 00       	mov    $0x25,%esi
    1b94:	89 c7                	mov    %eax,%edi
    1b96:	48 b8 0a 16 00 00 00 	movabs $0x160a,%rax
    1b9d:	00 00 00 
    1ba0:	ff d0                	call   *%rax
      putc(fd, c);
    1ba2:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1ba8:	0f be d0             	movsbl %al,%edx
    1bab:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1bb1:	89 d6                	mov    %edx,%esi
    1bb3:	89 c7                	mov    %eax,%edi
    1bb5:	48 b8 0a 16 00 00 00 	movabs $0x160a,%rax
    1bbc:	00 00 00 
    1bbf:	ff d0                	call   *%rax
      break;
    1bc1:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1bc2:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1bc9:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1bcf:	48 63 d0             	movslq %eax,%rdx
    1bd2:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1bd9:	48 01 d0             	add    %rdx,%rax
    1bdc:	0f b6 00             	movzbl (%rax),%eax
    1bdf:	0f be c0             	movsbl %al,%eax
    1be2:	25 ff 00 00 00       	and    $0xff,%eax
    1be7:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1bed:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1bf4:	0f 85 8e fc ff ff    	jne    1888 <printf+0x98>
    }
  }
}
    1bfa:	eb 01                	jmp    1bfd <printf+0x40d>
      break;
    1bfc:	90                   	nop
}
    1bfd:	90                   	nop
    1bfe:	c9                   	leave
    1bff:	c3                   	ret

0000000000001c00 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1c00:	f3 0f 1e fa          	endbr64
    1c04:	55                   	push   %rbp
    1c05:	48 89 e5             	mov    %rsp,%rbp
    1c08:	48 83 ec 18          	sub    $0x18,%rsp
    1c0c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1c10:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1c14:	48 83 e8 10          	sub    $0x10,%rax
    1c18:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1c1c:	48 b8 50 20 00 00 00 	movabs $0x2050,%rax
    1c23:	00 00 00 
    1c26:	48 8b 00             	mov    (%rax),%rax
    1c29:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1c2d:	eb 2f                	jmp    1c5e <free+0x5e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1c2f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c33:	48 8b 00             	mov    (%rax),%rax
    1c36:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1c3a:	72 17                	jb     1c53 <free+0x53>
    1c3c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c40:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1c44:	72 2f                	jb     1c75 <free+0x75>
    1c46:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c4a:	48 8b 00             	mov    (%rax),%rax
    1c4d:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1c51:	72 22                	jb     1c75 <free+0x75>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1c53:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c57:	48 8b 00             	mov    (%rax),%rax
    1c5a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1c5e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c62:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1c66:	73 c7                	jae    1c2f <free+0x2f>
    1c68:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c6c:	48 8b 00             	mov    (%rax),%rax
    1c6f:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1c73:	73 ba                	jae    1c2f <free+0x2f>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1c75:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c79:	8b 40 08             	mov    0x8(%rax),%eax
    1c7c:	89 c0                	mov    %eax,%eax
    1c7e:	48 c1 e0 04          	shl    $0x4,%rax
    1c82:	48 89 c2             	mov    %rax,%rdx
    1c85:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c89:	48 01 c2             	add    %rax,%rdx
    1c8c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c90:	48 8b 00             	mov    (%rax),%rax
    1c93:	48 39 c2             	cmp    %rax,%rdx
    1c96:	75 2d                	jne    1cc5 <free+0xc5>
    bp->s.size += p->s.ptr->s.size;
    1c98:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c9c:	8b 50 08             	mov    0x8(%rax),%edx
    1c9f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ca3:	48 8b 00             	mov    (%rax),%rax
    1ca6:	8b 40 08             	mov    0x8(%rax),%eax
    1ca9:	01 c2                	add    %eax,%edx
    1cab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1caf:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1cb2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cb6:	48 8b 00             	mov    (%rax),%rax
    1cb9:	48 8b 10             	mov    (%rax),%rdx
    1cbc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cc0:	48 89 10             	mov    %rdx,(%rax)
    1cc3:	eb 0e                	jmp    1cd3 <free+0xd3>
  } else
    bp->s.ptr = p->s.ptr;
    1cc5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cc9:	48 8b 10             	mov    (%rax),%rdx
    1ccc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cd0:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    1cd3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cd7:	8b 40 08             	mov    0x8(%rax),%eax
    1cda:	89 c0                	mov    %eax,%eax
    1cdc:	48 c1 e0 04          	shl    $0x4,%rax
    1ce0:	48 89 c2             	mov    %rax,%rdx
    1ce3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ce7:	48 01 d0             	add    %rdx,%rax
    1cea:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1cee:	75 27                	jne    1d17 <free+0x117>
    p->s.size += bp->s.size;
    1cf0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cf4:	8b 50 08             	mov    0x8(%rax),%edx
    1cf7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cfb:	8b 40 08             	mov    0x8(%rax),%eax
    1cfe:	01 c2                	add    %eax,%edx
    1d00:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d04:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    1d07:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d0b:	48 8b 10             	mov    (%rax),%rdx
    1d0e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d12:	48 89 10             	mov    %rdx,(%rax)
    1d15:	eb 0b                	jmp    1d22 <free+0x122>
  } else
    p->s.ptr = bp;
    1d17:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d1b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1d1f:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    1d22:	48 ba 50 20 00 00 00 	movabs $0x2050,%rdx
    1d29:	00 00 00 
    1d2c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d30:	48 89 02             	mov    %rax,(%rdx)
}
    1d33:	90                   	nop
    1d34:	c9                   	leave
    1d35:	c3                   	ret

0000000000001d36 <morecore>:

static Header*
morecore(uint nu)
{
    1d36:	f3 0f 1e fa          	endbr64
    1d3a:	55                   	push   %rbp
    1d3b:	48 89 e5             	mov    %rsp,%rbp
    1d3e:	48 83 ec 20          	sub    $0x20,%rsp
    1d42:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    1d45:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1d4c:	77 07                	ja     1d55 <morecore+0x1f>
    nu = 4096;
    1d4e:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    1d55:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1d58:	48 c1 e0 04          	shl    $0x4,%rax
    1d5c:	48 89 c7             	mov    %rax,%rdi
    1d5f:	48 b8 bc 15 00 00 00 	movabs $0x15bc,%rax
    1d66:	00 00 00 
    1d69:	ff d0                	call   *%rax
    1d6b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    1d6f:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1d74:	75 07                	jne    1d7d <morecore+0x47>
    return 0;
    1d76:	b8 00 00 00 00       	mov    $0x0,%eax
    1d7b:	eb 36                	jmp    1db3 <morecore+0x7d>
  hp = (Header*)p;
    1d7d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d81:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    1d85:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d89:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1d8c:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    1d8f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d93:	48 83 c0 10          	add    $0x10,%rax
    1d97:	48 89 c7             	mov    %rax,%rdi
    1d9a:	48 b8 00 1c 00 00 00 	movabs $0x1c00,%rax
    1da1:	00 00 00 
    1da4:	ff d0                	call   *%rax
  return freep;
    1da6:	48 b8 50 20 00 00 00 	movabs $0x2050,%rax
    1dad:	00 00 00 
    1db0:	48 8b 00             	mov    (%rax),%rax
}
    1db3:	c9                   	leave
    1db4:	c3                   	ret

0000000000001db5 <malloc>:

void*
malloc(uint nbytes)
{
    1db5:	f3 0f 1e fa          	endbr64
    1db9:	55                   	push   %rbp
    1dba:	48 89 e5             	mov    %rsp,%rbp
    1dbd:	48 83 ec 30          	sub    $0x30,%rsp
    1dc1:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1dc4:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1dc7:	48 83 c0 0f          	add    $0xf,%rax
    1dcb:	48 c1 e8 04          	shr    $0x4,%rax
    1dcf:	83 c0 01             	add    $0x1,%eax
    1dd2:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    1dd5:	48 b8 50 20 00 00 00 	movabs $0x2050,%rax
    1ddc:	00 00 00 
    1ddf:	48 8b 00             	mov    (%rax),%rax
    1de2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1de6:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1deb:	75 4a                	jne    1e37 <malloc+0x82>
    base.s.ptr = freep = prevp = &base;
    1ded:	48 b8 40 20 00 00 00 	movabs $0x2040,%rax
    1df4:	00 00 00 
    1df7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1dfb:	48 ba 50 20 00 00 00 	movabs $0x2050,%rdx
    1e02:	00 00 00 
    1e05:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e09:	48 89 02             	mov    %rax,(%rdx)
    1e0c:	48 b8 50 20 00 00 00 	movabs $0x2050,%rax
    1e13:	00 00 00 
    1e16:	48 8b 00             	mov    (%rax),%rax
    1e19:	48 ba 40 20 00 00 00 	movabs $0x2040,%rdx
    1e20:	00 00 00 
    1e23:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    1e26:	48 b8 40 20 00 00 00 	movabs $0x2040,%rax
    1e2d:	00 00 00 
    1e30:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1e37:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e3b:	48 8b 00             	mov    (%rax),%rax
    1e3e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1e42:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e46:	8b 40 08             	mov    0x8(%rax),%eax
    1e49:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1e4c:	72 65                	jb     1eb3 <malloc+0xfe>
      if(p->s.size == nunits)
    1e4e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e52:	8b 40 08             	mov    0x8(%rax),%eax
    1e55:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1e58:	75 10                	jne    1e6a <malloc+0xb5>
        prevp->s.ptr = p->s.ptr;
    1e5a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e5e:	48 8b 10             	mov    (%rax),%rdx
    1e61:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e65:	48 89 10             	mov    %rdx,(%rax)
    1e68:	eb 2e                	jmp    1e98 <malloc+0xe3>
      else {
        p->s.size -= nunits;
    1e6a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e6e:	8b 40 08             	mov    0x8(%rax),%eax
    1e71:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1e74:	89 c2                	mov    %eax,%edx
    1e76:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e7a:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    1e7d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e81:	8b 40 08             	mov    0x8(%rax),%eax
    1e84:	89 c0                	mov    %eax,%eax
    1e86:	48 c1 e0 04          	shl    $0x4,%rax
    1e8a:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    1e8e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e92:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1e95:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    1e98:	48 ba 50 20 00 00 00 	movabs $0x2050,%rdx
    1e9f:	00 00 00 
    1ea2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ea6:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    1ea9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ead:	48 83 c0 10          	add    $0x10,%rax
    1eb1:	eb 4e                	jmp    1f01 <malloc+0x14c>
    }
    if(p == freep)
    1eb3:	48 b8 50 20 00 00 00 	movabs $0x2050,%rax
    1eba:	00 00 00 
    1ebd:	48 8b 00             	mov    (%rax),%rax
    1ec0:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1ec4:	75 23                	jne    1ee9 <malloc+0x134>
      if((p = morecore(nunits)) == 0)
    1ec6:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1ec9:	89 c7                	mov    %eax,%edi
    1ecb:	48 b8 36 1d 00 00 00 	movabs $0x1d36,%rax
    1ed2:	00 00 00 
    1ed5:	ff d0                	call   *%rax
    1ed7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1edb:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1ee0:	75 07                	jne    1ee9 <malloc+0x134>
        return 0;
    1ee2:	b8 00 00 00 00       	mov    $0x0,%eax
    1ee7:	eb 18                	jmp    1f01 <malloc+0x14c>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1ee9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1eed:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1ef1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ef5:	48 8b 00             	mov    (%rax),%rax
    1ef8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1efc:	e9 41 ff ff ff       	jmp    1e42 <malloc+0x8d>
  }
}
    1f01:	c9                   	leave
    1f02:	c3                   	ret
