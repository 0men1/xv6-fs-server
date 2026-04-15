
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
    1011:	48 b8 f3 1e 00 00 00 	movabs $0x1ef3,%rax
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
    1038:	48 b8 f3 1e 00 00 00 	movabs $0x1ef3,%rax
    103f:	00 00 00 
    1042:	48 89 c7             	mov    %rax,%rdi
    1045:	48 b8 54 15 00 00 00 	movabs $0x1554,%rax
    104c:	00 00 00 
    104f:	ff d0                	call   *%rax
    open("console", O_RDWR);
    1051:	be 02 00 00 00       	mov    $0x2,%esi
    1056:	48 b8 f3 1e 00 00 00 	movabs $0x1ef3,%rax
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
    1091:	48 b8 fb 1e 00 00 00 	movabs $0x1efb,%rax
    1098:	00 00 00 
    109b:	48 89 c6             	mov    %rax,%rsi
    109e:	bf 01 00 00 00       	mov    $0x1,%edi
    10a3:	b8 00 00 00 00       	mov    $0x0,%eax
    10a8:	48 ba e3 17 00 00 00 	movabs $0x17e3,%rdx
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
    10c9:	48 b8 0e 1f 00 00 00 	movabs $0x1f0e,%rax
    10d0:	00 00 00 
    10d3:	48 89 c6             	mov    %rax,%rsi
    10d6:	bf 01 00 00 00       	mov    $0x1,%edi
    10db:	b8 00 00 00 00       	mov    $0x0,%eax
    10e0:	48 ba e3 17 00 00 00 	movabs $0x17e3,%rdx
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
    10fe:	48 b8 00 20 00 00 00 	movabs $0x2000,%rax
    1105:	00 00 00 
    1108:	48 89 c6             	mov    %rax,%rsi
    110b:	48 b8 f0 1e 00 00 00 	movabs $0x1ef0,%rax
    1112:	00 00 00 
    1115:	48 89 c7             	mov    %rax,%rdi
    1118:	48 b8 3a 15 00 00 00 	movabs $0x153a,%rax
    111f:	00 00 00 
    1122:	ff d0                	call   *%rax
      printf(1, "init: exec sh failed\n");
    1124:	48 b8 21 1f 00 00 00 	movabs $0x1f21,%rax
    112b:	00 00 00 
    112e:	48 89 c6             	mov    %rax,%rsi
    1131:	bf 01 00 00 00       	mov    $0x1,%edi
    1136:	b8 00 00 00 00       	mov    $0x0,%eax
    113b:	48 ba e3 17 00 00 00 	movabs $0x17e3,%rdx
    1142:	00 00 00 
    1145:	ff d2                	call   *%rdx
      exit();
    1147:	48 b8 df 14 00 00 00 	movabs $0x14df,%rax
    114e:	00 00 00 
    1151:	ff d0                	call   *%rax
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
    1153:	48 b8 37 1f 00 00 00 	movabs $0x1f37,%rax
    115a:	00 00 00 
    115d:	48 89 c6             	mov    %rax,%rsi
    1160:	bf 01 00 00 00       	mov    $0x1,%edi
    1165:	b8 00 00 00 00       	mov    $0x0,%eax
    116a:	48 ba e3 17 00 00 00 	movabs $0x17e3,%rdx
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
    14d2:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    14d9:	49 89 ca             	mov    %rcx,%r10
    14dc:	0f 05                	syscall
    14de:	c3                   	ret

00000000000014df <exit>:
    14df:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    14e6:	49 89 ca             	mov    %rcx,%r10
    14e9:	0f 05                	syscall
    14eb:	c3                   	ret

00000000000014ec <wait>:
    14ec:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    14f3:	49 89 ca             	mov    %rcx,%r10
    14f6:	0f 05                	syscall
    14f8:	c3                   	ret

00000000000014f9 <pipe>:
    14f9:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    1500:	49 89 ca             	mov    %rcx,%r10
    1503:	0f 05                	syscall
    1505:	c3                   	ret

0000000000001506 <read>:
    1506:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    150d:	49 89 ca             	mov    %rcx,%r10
    1510:	0f 05                	syscall
    1512:	c3                   	ret

0000000000001513 <write>:
    1513:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    151a:	49 89 ca             	mov    %rcx,%r10
    151d:	0f 05                	syscall
    151f:	c3                   	ret

0000000000001520 <close>:
    1520:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    1527:	49 89 ca             	mov    %rcx,%r10
    152a:	0f 05                	syscall
    152c:	c3                   	ret

000000000000152d <kill>:
    152d:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    1534:	49 89 ca             	mov    %rcx,%r10
    1537:	0f 05                	syscall
    1539:	c3                   	ret

000000000000153a <exec>:
    153a:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    1541:	49 89 ca             	mov    %rcx,%r10
    1544:	0f 05                	syscall
    1546:	c3                   	ret

0000000000001547 <open>:
    1547:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    154e:	49 89 ca             	mov    %rcx,%r10
    1551:	0f 05                	syscall
    1553:	c3                   	ret

0000000000001554 <mknod>:
    1554:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    155b:	49 89 ca             	mov    %rcx,%r10
    155e:	0f 05                	syscall
    1560:	c3                   	ret

0000000000001561 <unlink>:
    1561:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    1568:	49 89 ca             	mov    %rcx,%r10
    156b:	0f 05                	syscall
    156d:	c3                   	ret

000000000000156e <fstat>:
    156e:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    1575:	49 89 ca             	mov    %rcx,%r10
    1578:	0f 05                	syscall
    157a:	c3                   	ret

000000000000157b <link>:
    157b:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    1582:	49 89 ca             	mov    %rcx,%r10
    1585:	0f 05                	syscall
    1587:	c3                   	ret

0000000000001588 <mkdir>:
    1588:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    158f:	49 89 ca             	mov    %rcx,%r10
    1592:	0f 05                	syscall
    1594:	c3                   	ret

0000000000001595 <chdir>:
    1595:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    159c:	49 89 ca             	mov    %rcx,%r10
    159f:	0f 05                	syscall
    15a1:	c3                   	ret

00000000000015a2 <dup>:
    15a2:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    15a9:	49 89 ca             	mov    %rcx,%r10
    15ac:	0f 05                	syscall
    15ae:	c3                   	ret

00000000000015af <getpid>:
    15af:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    15b6:	49 89 ca             	mov    %rcx,%r10
    15b9:	0f 05                	syscall
    15bb:	c3                   	ret

00000000000015bc <sbrk>:
    15bc:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    15c3:	49 89 ca             	mov    %rcx,%r10
    15c6:	0f 05                	syscall
    15c8:	c3                   	ret

00000000000015c9 <sleep>:
    15c9:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    15d0:	49 89 ca             	mov    %rcx,%r10
    15d3:	0f 05                	syscall
    15d5:	c3                   	ret

00000000000015d6 <uptime>:
    15d6:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    15dd:	49 89 ca             	mov    %rcx,%r10
    15e0:	0f 05                	syscall
    15e2:	c3                   	ret

00000000000015e3 <send>:
    15e3:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    15ea:	49 89 ca             	mov    %rcx,%r10
    15ed:	0f 05                	syscall
    15ef:	c3                   	ret

00000000000015f0 <recv>:
    15f0:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    15f7:	49 89 ca             	mov    %rcx,%r10
    15fa:	0f 05                	syscall
    15fc:	c3                   	ret

00000000000015fd <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    15fd:	f3 0f 1e fa          	endbr64
    1601:	55                   	push   %rbp
    1602:	48 89 e5             	mov    %rsp,%rbp
    1605:	48 83 ec 10          	sub    $0x10,%rsp
    1609:	89 7d fc             	mov    %edi,-0x4(%rbp)
    160c:	89 f0                	mov    %esi,%eax
    160e:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    1611:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    1615:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1618:	ba 01 00 00 00       	mov    $0x1,%edx
    161d:	48 89 ce             	mov    %rcx,%rsi
    1620:	89 c7                	mov    %eax,%edi
    1622:	48 b8 13 15 00 00 00 	movabs $0x1513,%rax
    1629:	00 00 00 
    162c:	ff d0                	call   *%rax
}
    162e:	90                   	nop
    162f:	c9                   	leave
    1630:	c3                   	ret

0000000000001631 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    1631:	f3 0f 1e fa          	endbr64
    1635:	55                   	push   %rbp
    1636:	48 89 e5             	mov    %rsp,%rbp
    1639:	48 83 ec 20          	sub    $0x20,%rsp
    163d:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1640:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1644:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    164b:	eb 35                	jmp    1682 <print_x64+0x51>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    164d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1651:	48 c1 e8 3c          	shr    $0x3c,%rax
    1655:	48 ba 10 20 00 00 00 	movabs $0x2010,%rdx
    165c:	00 00 00 
    165f:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1663:	0f be d0             	movsbl %al,%edx
    1666:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1669:	89 d6                	mov    %edx,%esi
    166b:	89 c7                	mov    %eax,%edi
    166d:	48 b8 fd 15 00 00 00 	movabs $0x15fd,%rax
    1674:	00 00 00 
    1677:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1679:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    167d:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    1682:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1685:	83 f8 0f             	cmp    $0xf,%eax
    1688:	76 c3                	jbe    164d <print_x64+0x1c>
}
    168a:	90                   	nop
    168b:	90                   	nop
    168c:	c9                   	leave
    168d:	c3                   	ret

000000000000168e <print_x32>:

  static void
print_x32(int fd, uint x)
{
    168e:	f3 0f 1e fa          	endbr64
    1692:	55                   	push   %rbp
    1693:	48 89 e5             	mov    %rsp,%rbp
    1696:	48 83 ec 20          	sub    $0x20,%rsp
    169a:	89 7d ec             	mov    %edi,-0x14(%rbp)
    169d:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    16a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    16a7:	eb 36                	jmp    16df <print_x32+0x51>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    16a9:	8b 45 e8             	mov    -0x18(%rbp),%eax
    16ac:	c1 e8 1c             	shr    $0x1c,%eax
    16af:	89 c2                	mov    %eax,%edx
    16b1:	48 b8 10 20 00 00 00 	movabs $0x2010,%rax
    16b8:	00 00 00 
    16bb:	89 d2                	mov    %edx,%edx
    16bd:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    16c1:	0f be d0             	movsbl %al,%edx
    16c4:	8b 45 ec             	mov    -0x14(%rbp),%eax
    16c7:	89 d6                	mov    %edx,%esi
    16c9:	89 c7                	mov    %eax,%edi
    16cb:	48 b8 fd 15 00 00 00 	movabs $0x15fd,%rax
    16d2:	00 00 00 
    16d5:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    16d7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    16db:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    16df:	8b 45 fc             	mov    -0x4(%rbp),%eax
    16e2:	83 f8 07             	cmp    $0x7,%eax
    16e5:	76 c2                	jbe    16a9 <print_x32+0x1b>
}
    16e7:	90                   	nop
    16e8:	90                   	nop
    16e9:	c9                   	leave
    16ea:	c3                   	ret

00000000000016eb <print_d>:

  static void
print_d(int fd, int v)
{
    16eb:	f3 0f 1e fa          	endbr64
    16ef:	55                   	push   %rbp
    16f0:	48 89 e5             	mov    %rsp,%rbp
    16f3:	48 83 ec 30          	sub    $0x30,%rsp
    16f7:	89 7d dc             	mov    %edi,-0x24(%rbp)
    16fa:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    16fd:	8b 45 d8             	mov    -0x28(%rbp),%eax
    1700:	48 98                	cltq
    1702:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    1706:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    170a:	79 04                	jns    1710 <print_d+0x25>
    x = -x;
    170c:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    1710:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    1717:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    171b:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1722:	66 66 66 
    1725:	48 89 c8             	mov    %rcx,%rax
    1728:	48 f7 ea             	imul   %rdx
    172b:	48 c1 fa 02          	sar    $0x2,%rdx
    172f:	48 89 c8             	mov    %rcx,%rax
    1732:	48 c1 f8 3f          	sar    $0x3f,%rax
    1736:	48 29 c2             	sub    %rax,%rdx
    1739:	48 89 d0             	mov    %rdx,%rax
    173c:	48 c1 e0 02          	shl    $0x2,%rax
    1740:	48 01 d0             	add    %rdx,%rax
    1743:	48 01 c0             	add    %rax,%rax
    1746:	48 29 c1             	sub    %rax,%rcx
    1749:	48 89 ca             	mov    %rcx,%rdx
    174c:	8b 45 f4             	mov    -0xc(%rbp),%eax
    174f:	8d 48 01             	lea    0x1(%rax),%ecx
    1752:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    1755:	48 b9 10 20 00 00 00 	movabs $0x2010,%rcx
    175c:	00 00 00 
    175f:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    1763:	48 98                	cltq
    1765:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    1769:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    176d:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1774:	66 66 66 
    1777:	48 89 c8             	mov    %rcx,%rax
    177a:	48 f7 ea             	imul   %rdx
    177d:	48 89 d0             	mov    %rdx,%rax
    1780:	48 c1 f8 02          	sar    $0x2,%rax
    1784:	48 c1 f9 3f          	sar    $0x3f,%rcx
    1788:	48 89 ca             	mov    %rcx,%rdx
    178b:	48 29 d0             	sub    %rdx,%rax
    178e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    1792:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1797:	0f 85 7a ff ff ff    	jne    1717 <print_d+0x2c>

  if (v < 0)
    179d:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    17a1:	79 32                	jns    17d5 <print_d+0xea>
    buf[i++] = '-';
    17a3:	8b 45 f4             	mov    -0xc(%rbp),%eax
    17a6:	8d 50 01             	lea    0x1(%rax),%edx
    17a9:	89 55 f4             	mov    %edx,-0xc(%rbp)
    17ac:	48 98                	cltq
    17ae:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    17b3:	eb 20                	jmp    17d5 <print_d+0xea>
    putc(fd, buf[i]);
    17b5:	8b 45 f4             	mov    -0xc(%rbp),%eax
    17b8:	48 98                	cltq
    17ba:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    17bf:	0f be d0             	movsbl %al,%edx
    17c2:	8b 45 dc             	mov    -0x24(%rbp),%eax
    17c5:	89 d6                	mov    %edx,%esi
    17c7:	89 c7                	mov    %eax,%edi
    17c9:	48 b8 fd 15 00 00 00 	movabs $0x15fd,%rax
    17d0:	00 00 00 
    17d3:	ff d0                	call   *%rax
  while (--i >= 0)
    17d5:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    17d9:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    17dd:	79 d6                	jns    17b5 <print_d+0xca>
}
    17df:	90                   	nop
    17e0:	90                   	nop
    17e1:	c9                   	leave
    17e2:	c3                   	ret

00000000000017e3 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    17e3:	f3 0f 1e fa          	endbr64
    17e7:	55                   	push   %rbp
    17e8:	48 89 e5             	mov    %rsp,%rbp
    17eb:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    17f2:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    17f8:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    17ff:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    1806:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    180d:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    1814:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    181b:	84 c0                	test   %al,%al
    181d:	74 20                	je     183f <printf+0x5c>
    181f:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    1823:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    1827:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    182b:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    182f:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    1833:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    1837:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    183b:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    183f:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    1846:	00 00 00 
    1849:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    1850:	00 00 00 
    1853:	48 8d 45 10          	lea    0x10(%rbp),%rax
    1857:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    185e:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    1865:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    186c:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    1873:	00 00 00 
    1876:	e9 41 03 00 00       	jmp    1bbc <printf+0x3d9>
    if (c != '%') {
    187b:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1882:	74 24                	je     18a8 <printf+0xc5>
      putc(fd, c);
    1884:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    188a:	0f be d0             	movsbl %al,%edx
    188d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1893:	89 d6                	mov    %edx,%esi
    1895:	89 c7                	mov    %eax,%edi
    1897:	48 b8 fd 15 00 00 00 	movabs $0x15fd,%rax
    189e:	00 00 00 
    18a1:	ff d0                	call   *%rax
      continue;
    18a3:	e9 0d 03 00 00       	jmp    1bb5 <printf+0x3d2>
    }
    c = fmt[++i] & 0xff;
    18a8:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    18af:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    18b5:	48 63 d0             	movslq %eax,%rdx
    18b8:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    18bf:	48 01 d0             	add    %rdx,%rax
    18c2:	0f b6 00             	movzbl (%rax),%eax
    18c5:	0f be c0             	movsbl %al,%eax
    18c8:	25 ff 00 00 00       	and    $0xff,%eax
    18cd:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    18d3:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    18da:	0f 84 0f 03 00 00    	je     1bef <printf+0x40c>
      break;
    switch(c) {
    18e0:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    18e7:	0f 84 74 02 00 00    	je     1b61 <printf+0x37e>
    18ed:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    18f4:	0f 8c 82 02 00 00    	jl     1b7c <printf+0x399>
    18fa:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    1901:	0f 8f 75 02 00 00    	jg     1b7c <printf+0x399>
    1907:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    190e:	0f 8c 68 02 00 00    	jl     1b7c <printf+0x399>
    1914:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    191a:	83 e8 63             	sub    $0x63,%eax
    191d:	83 f8 15             	cmp    $0x15,%eax
    1920:	0f 87 56 02 00 00    	ja     1b7c <printf+0x399>
    1926:	89 c0                	mov    %eax,%eax
    1928:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    192f:	00 
    1930:	48 b8 48 1f 00 00 00 	movabs $0x1f48,%rax
    1937:	00 00 00 
    193a:	48 01 d0             	add    %rdx,%rax
    193d:	48 8b 00             	mov    (%rax),%rax
    1940:	3e ff e0             	notrack jmp *%rax
    case 'c':
      putc(fd, va_arg(ap, int));
    1943:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1949:	83 f8 2f             	cmp    $0x2f,%eax
    194c:	77 23                	ja     1971 <printf+0x18e>
    194e:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1955:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    195b:	89 d2                	mov    %edx,%edx
    195d:	48 01 d0             	add    %rdx,%rax
    1960:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1966:	83 c2 08             	add    $0x8,%edx
    1969:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    196f:	eb 12                	jmp    1983 <printf+0x1a0>
    1971:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1978:	48 8d 50 08          	lea    0x8(%rax),%rdx
    197c:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1983:	8b 00                	mov    (%rax),%eax
    1985:	0f be d0             	movsbl %al,%edx
    1988:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    198e:	89 d6                	mov    %edx,%esi
    1990:	89 c7                	mov    %eax,%edi
    1992:	48 b8 fd 15 00 00 00 	movabs $0x15fd,%rax
    1999:	00 00 00 
    199c:	ff d0                	call   *%rax
      break;
    199e:	e9 12 02 00 00       	jmp    1bb5 <printf+0x3d2>
    case 'd':
      print_d(fd, va_arg(ap, int));
    19a3:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    19a9:	83 f8 2f             	cmp    $0x2f,%eax
    19ac:	77 23                	ja     19d1 <printf+0x1ee>
    19ae:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    19b5:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19bb:	89 d2                	mov    %edx,%edx
    19bd:	48 01 d0             	add    %rdx,%rax
    19c0:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19c6:	83 c2 08             	add    $0x8,%edx
    19c9:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    19cf:	eb 12                	jmp    19e3 <printf+0x200>
    19d1:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    19d8:	48 8d 50 08          	lea    0x8(%rax),%rdx
    19dc:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    19e3:	8b 10                	mov    (%rax),%edx
    19e5:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    19eb:	89 d6                	mov    %edx,%esi
    19ed:	89 c7                	mov    %eax,%edi
    19ef:	48 b8 eb 16 00 00 00 	movabs $0x16eb,%rax
    19f6:	00 00 00 
    19f9:	ff d0                	call   *%rax
      break;
    19fb:	e9 b5 01 00 00       	jmp    1bb5 <printf+0x3d2>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    1a00:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1a06:	83 f8 2f             	cmp    $0x2f,%eax
    1a09:	77 23                	ja     1a2e <printf+0x24b>
    1a0b:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1a12:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a18:	89 d2                	mov    %edx,%edx
    1a1a:	48 01 d0             	add    %rdx,%rax
    1a1d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a23:	83 c2 08             	add    $0x8,%edx
    1a26:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1a2c:	eb 12                	jmp    1a40 <printf+0x25d>
    1a2e:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a35:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a39:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a40:	8b 10                	mov    (%rax),%edx
    1a42:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a48:	89 d6                	mov    %edx,%esi
    1a4a:	89 c7                	mov    %eax,%edi
    1a4c:	48 b8 8e 16 00 00 00 	movabs $0x168e,%rax
    1a53:	00 00 00 
    1a56:	ff d0                	call   *%rax
      break;
    1a58:	e9 58 01 00 00       	jmp    1bb5 <printf+0x3d2>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    1a5d:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1a63:	83 f8 2f             	cmp    $0x2f,%eax
    1a66:	77 23                	ja     1a8b <printf+0x2a8>
    1a68:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1a6f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a75:	89 d2                	mov    %edx,%edx
    1a77:	48 01 d0             	add    %rdx,%rax
    1a7a:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a80:	83 c2 08             	add    $0x8,%edx
    1a83:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1a89:	eb 12                	jmp    1a9d <printf+0x2ba>
    1a8b:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a92:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a96:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a9d:	48 8b 10             	mov    (%rax),%rdx
    1aa0:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1aa6:	48 89 d6             	mov    %rdx,%rsi
    1aa9:	89 c7                	mov    %eax,%edi
    1aab:	48 b8 31 16 00 00 00 	movabs $0x1631,%rax
    1ab2:	00 00 00 
    1ab5:	ff d0                	call   *%rax
      break;
    1ab7:	e9 f9 00 00 00       	jmp    1bb5 <printf+0x3d2>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    1abc:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1ac2:	83 f8 2f             	cmp    $0x2f,%eax
    1ac5:	77 23                	ja     1aea <printf+0x307>
    1ac7:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1ace:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1ad4:	89 d2                	mov    %edx,%edx
    1ad6:	48 01 d0             	add    %rdx,%rax
    1ad9:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1adf:	83 c2 08             	add    $0x8,%edx
    1ae2:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1ae8:	eb 12                	jmp    1afc <printf+0x319>
    1aea:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1af1:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1af5:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1afc:	48 8b 00             	mov    (%rax),%rax
    1aff:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    1b06:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1b0d:	00 
    1b0e:	75 41                	jne    1b51 <printf+0x36e>
        s = "(null)";
    1b10:	48 b8 40 1f 00 00 00 	movabs $0x1f40,%rax
    1b17:	00 00 00 
    1b1a:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1b21:	eb 2e                	jmp    1b51 <printf+0x36e>
        putc(fd, *(s++));
    1b23:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1b2a:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1b2e:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1b35:	0f b6 00             	movzbl (%rax),%eax
    1b38:	0f be d0             	movsbl %al,%edx
    1b3b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b41:	89 d6                	mov    %edx,%esi
    1b43:	89 c7                	mov    %eax,%edi
    1b45:	48 b8 fd 15 00 00 00 	movabs $0x15fd,%rax
    1b4c:	00 00 00 
    1b4f:	ff d0                	call   *%rax
      while (*s)
    1b51:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1b58:	0f b6 00             	movzbl (%rax),%eax
    1b5b:	84 c0                	test   %al,%al
    1b5d:	75 c4                	jne    1b23 <printf+0x340>
      break;
    1b5f:	eb 54                	jmp    1bb5 <printf+0x3d2>
    case '%':
      putc(fd, '%');
    1b61:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b67:	be 25 00 00 00       	mov    $0x25,%esi
    1b6c:	89 c7                	mov    %eax,%edi
    1b6e:	48 b8 fd 15 00 00 00 	movabs $0x15fd,%rax
    1b75:	00 00 00 
    1b78:	ff d0                	call   *%rax
      break;
    1b7a:	eb 39                	jmp    1bb5 <printf+0x3d2>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1b7c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b82:	be 25 00 00 00       	mov    $0x25,%esi
    1b87:	89 c7                	mov    %eax,%edi
    1b89:	48 b8 fd 15 00 00 00 	movabs $0x15fd,%rax
    1b90:	00 00 00 
    1b93:	ff d0                	call   *%rax
      putc(fd, c);
    1b95:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1b9b:	0f be d0             	movsbl %al,%edx
    1b9e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1ba4:	89 d6                	mov    %edx,%esi
    1ba6:	89 c7                	mov    %eax,%edi
    1ba8:	48 b8 fd 15 00 00 00 	movabs $0x15fd,%rax
    1baf:	00 00 00 
    1bb2:	ff d0                	call   *%rax
      break;
    1bb4:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1bb5:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1bbc:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1bc2:	48 63 d0             	movslq %eax,%rdx
    1bc5:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1bcc:	48 01 d0             	add    %rdx,%rax
    1bcf:	0f b6 00             	movzbl (%rax),%eax
    1bd2:	0f be c0             	movsbl %al,%eax
    1bd5:	25 ff 00 00 00       	and    $0xff,%eax
    1bda:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1be0:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1be7:	0f 85 8e fc ff ff    	jne    187b <printf+0x98>
    }
  }
}
    1bed:	eb 01                	jmp    1bf0 <printf+0x40d>
      break;
    1bef:	90                   	nop
}
    1bf0:	90                   	nop
    1bf1:	c9                   	leave
    1bf2:	c3                   	ret

0000000000001bf3 <free>:
    1bf3:	55                   	push   %rbp
    1bf4:	48 89 e5             	mov    %rsp,%rbp
    1bf7:	48 83 ec 18          	sub    $0x18,%rsp
    1bfb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1bff:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1c03:	48 83 e8 10          	sub    $0x10,%rax
    1c07:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1c0b:	48 b8 40 20 00 00 00 	movabs $0x2040,%rax
    1c12:	00 00 00 
    1c15:	48 8b 00             	mov    (%rax),%rax
    1c18:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1c1c:	eb 2f                	jmp    1c4d <free+0x5a>
    1c1e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c22:	48 8b 00             	mov    (%rax),%rax
    1c25:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1c29:	72 17                	jb     1c42 <free+0x4f>
    1c2b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c2f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1c33:	72 2f                	jb     1c64 <free+0x71>
    1c35:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c39:	48 8b 00             	mov    (%rax),%rax
    1c3c:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1c40:	72 22                	jb     1c64 <free+0x71>
    1c42:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c46:	48 8b 00             	mov    (%rax),%rax
    1c49:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1c4d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c51:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1c55:	73 c7                	jae    1c1e <free+0x2b>
    1c57:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c5b:	48 8b 00             	mov    (%rax),%rax
    1c5e:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1c62:	73 ba                	jae    1c1e <free+0x2b>
    1c64:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c68:	8b 40 08             	mov    0x8(%rax),%eax
    1c6b:	89 c0                	mov    %eax,%eax
    1c6d:	48 c1 e0 04          	shl    $0x4,%rax
    1c71:	48 89 c2             	mov    %rax,%rdx
    1c74:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c78:	48 01 c2             	add    %rax,%rdx
    1c7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c7f:	48 8b 00             	mov    (%rax),%rax
    1c82:	48 39 c2             	cmp    %rax,%rdx
    1c85:	75 2d                	jne    1cb4 <free+0xc1>
    1c87:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c8b:	8b 50 08             	mov    0x8(%rax),%edx
    1c8e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c92:	48 8b 00             	mov    (%rax),%rax
    1c95:	8b 40 08             	mov    0x8(%rax),%eax
    1c98:	01 c2                	add    %eax,%edx
    1c9a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c9e:	89 50 08             	mov    %edx,0x8(%rax)
    1ca1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ca5:	48 8b 00             	mov    (%rax),%rax
    1ca8:	48 8b 10             	mov    (%rax),%rdx
    1cab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1caf:	48 89 10             	mov    %rdx,(%rax)
    1cb2:	eb 0e                	jmp    1cc2 <free+0xcf>
    1cb4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cb8:	48 8b 10             	mov    (%rax),%rdx
    1cbb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cbf:	48 89 10             	mov    %rdx,(%rax)
    1cc2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cc6:	8b 40 08             	mov    0x8(%rax),%eax
    1cc9:	89 c0                	mov    %eax,%eax
    1ccb:	48 c1 e0 04          	shl    $0x4,%rax
    1ccf:	48 89 c2             	mov    %rax,%rdx
    1cd2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cd6:	48 01 d0             	add    %rdx,%rax
    1cd9:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1cdd:	75 27                	jne    1d06 <free+0x113>
    1cdf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ce3:	8b 50 08             	mov    0x8(%rax),%edx
    1ce6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cea:	8b 40 08             	mov    0x8(%rax),%eax
    1ced:	01 c2                	add    %eax,%edx
    1cef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cf3:	89 50 08             	mov    %edx,0x8(%rax)
    1cf6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cfa:	48 8b 10             	mov    (%rax),%rdx
    1cfd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d01:	48 89 10             	mov    %rdx,(%rax)
    1d04:	eb 0b                	jmp    1d11 <free+0x11e>
    1d06:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d0a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1d0e:	48 89 10             	mov    %rdx,(%rax)
    1d11:	48 ba 40 20 00 00 00 	movabs $0x2040,%rdx
    1d18:	00 00 00 
    1d1b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d1f:	48 89 02             	mov    %rax,(%rdx)
    1d22:	90                   	nop
    1d23:	c9                   	leave
    1d24:	c3                   	ret

0000000000001d25 <morecore>:
    1d25:	55                   	push   %rbp
    1d26:	48 89 e5             	mov    %rsp,%rbp
    1d29:	48 83 ec 20          	sub    $0x20,%rsp
    1d2d:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1d30:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1d37:	77 07                	ja     1d40 <morecore+0x1b>
    1d39:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
    1d40:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1d43:	48 c1 e0 04          	shl    $0x4,%rax
    1d47:	48 89 c7             	mov    %rax,%rdi
    1d4a:	48 b8 bc 15 00 00 00 	movabs $0x15bc,%rax
    1d51:	00 00 00 
    1d54:	ff d0                	call   *%rax
    1d56:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1d5a:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1d5f:	75 07                	jne    1d68 <morecore+0x43>
    1d61:	b8 00 00 00 00       	mov    $0x0,%eax
    1d66:	eb 36                	jmp    1d9e <morecore+0x79>
    1d68:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d6c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1d70:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d74:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1d77:	89 50 08             	mov    %edx,0x8(%rax)
    1d7a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d7e:	48 83 c0 10          	add    $0x10,%rax
    1d82:	48 89 c7             	mov    %rax,%rdi
    1d85:	48 b8 f3 1b 00 00 00 	movabs $0x1bf3,%rax
    1d8c:	00 00 00 
    1d8f:	ff d0                	call   *%rax
    1d91:	48 b8 40 20 00 00 00 	movabs $0x2040,%rax
    1d98:	00 00 00 
    1d9b:	48 8b 00             	mov    (%rax),%rax
    1d9e:	c9                   	leave
    1d9f:	c3                   	ret

0000000000001da0 <malloc>:
    1da0:	55                   	push   %rbp
    1da1:	48 89 e5             	mov    %rsp,%rbp
    1da4:	48 83 ec 30          	sub    $0x30,%rsp
    1da8:	89 7d dc             	mov    %edi,-0x24(%rbp)
    1dab:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1dae:	48 83 c0 0f          	add    $0xf,%rax
    1db2:	48 c1 e8 04          	shr    $0x4,%rax
    1db6:	83 c0 01             	add    $0x1,%eax
    1db9:	89 45 ec             	mov    %eax,-0x14(%rbp)
    1dbc:	48 b8 40 20 00 00 00 	movabs $0x2040,%rax
    1dc3:	00 00 00 
    1dc6:	48 8b 00             	mov    (%rax),%rax
    1dc9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1dcd:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1dd2:	75 4a                	jne    1e1e <malloc+0x7e>
    1dd4:	48 b8 30 20 00 00 00 	movabs $0x2030,%rax
    1ddb:	00 00 00 
    1dde:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1de2:	48 ba 40 20 00 00 00 	movabs $0x2040,%rdx
    1de9:	00 00 00 
    1dec:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1df0:	48 89 02             	mov    %rax,(%rdx)
    1df3:	48 b8 40 20 00 00 00 	movabs $0x2040,%rax
    1dfa:	00 00 00 
    1dfd:	48 8b 00             	mov    (%rax),%rax
    1e00:	48 ba 30 20 00 00 00 	movabs $0x2030,%rdx
    1e07:	00 00 00 
    1e0a:	48 89 02             	mov    %rax,(%rdx)
    1e0d:	48 b8 30 20 00 00 00 	movabs $0x2030,%rax
    1e14:	00 00 00 
    1e17:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
    1e1e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e22:	48 8b 00             	mov    (%rax),%rax
    1e25:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1e29:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e2d:	8b 40 08             	mov    0x8(%rax),%eax
    1e30:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1e33:	72 65                	jb     1e9a <malloc+0xfa>
    1e35:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e39:	8b 40 08             	mov    0x8(%rax),%eax
    1e3c:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1e3f:	75 10                	jne    1e51 <malloc+0xb1>
    1e41:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e45:	48 8b 10             	mov    (%rax),%rdx
    1e48:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e4c:	48 89 10             	mov    %rdx,(%rax)
    1e4f:	eb 2e                	jmp    1e7f <malloc+0xdf>
    1e51:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e55:	8b 40 08             	mov    0x8(%rax),%eax
    1e58:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1e5b:	89 c2                	mov    %eax,%edx
    1e5d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e61:	89 50 08             	mov    %edx,0x8(%rax)
    1e64:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e68:	8b 40 08             	mov    0x8(%rax),%eax
    1e6b:	89 c0                	mov    %eax,%eax
    1e6d:	48 c1 e0 04          	shl    $0x4,%rax
    1e71:	48 01 45 f8          	add    %rax,-0x8(%rbp)
    1e75:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e79:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1e7c:	89 50 08             	mov    %edx,0x8(%rax)
    1e7f:	48 ba 40 20 00 00 00 	movabs $0x2040,%rdx
    1e86:	00 00 00 
    1e89:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e8d:	48 89 02             	mov    %rax,(%rdx)
    1e90:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e94:	48 83 c0 10          	add    $0x10,%rax
    1e98:	eb 4e                	jmp    1ee8 <malloc+0x148>
    1e9a:	48 b8 40 20 00 00 00 	movabs $0x2040,%rax
    1ea1:	00 00 00 
    1ea4:	48 8b 00             	mov    (%rax),%rax
    1ea7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1eab:	75 23                	jne    1ed0 <malloc+0x130>
    1ead:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1eb0:	89 c7                	mov    %eax,%edi
    1eb2:	48 b8 25 1d 00 00 00 	movabs $0x1d25,%rax
    1eb9:	00 00 00 
    1ebc:	ff d0                	call   *%rax
    1ebe:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1ec2:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1ec7:	75 07                	jne    1ed0 <malloc+0x130>
    1ec9:	b8 00 00 00 00       	mov    $0x0,%eax
    1ece:	eb 18                	jmp    1ee8 <malloc+0x148>
    1ed0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ed4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1ed8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1edc:	48 8b 00             	mov    (%rax),%rax
    1edf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1ee3:	e9 41 ff ff ff       	jmp    1e29 <malloc+0x89>
    1ee8:	c9                   	leave
    1ee9:	c3                   	ret
