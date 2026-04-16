
_cat:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <cat>:

char buf[512];

void
cat(int fd)
{
    1000:	f3 0f 1e fa          	endbr64
    1004:	55                   	push   %rbp
    1005:	48 89 e5             	mov    %rsp,%rbp
    1008:	48 83 ec 20          	sub    $0x20,%rsp
    100c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
    100f:	eb 57                	jmp    1068 <cat+0x68>
    if (write(1, buf, n) != n) {
    1011:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1014:	89 c2                	mov    %eax,%edx
    1016:	48 b8 60 20 00 00 00 	movabs $0x2060,%rax
    101d:	00 00 00 
    1020:	48 89 c6             	mov    %rax,%rsi
    1023:	bf 01 00 00 00       	mov    $0x1,%edi
    1028:	48 b8 44 15 00 00 00 	movabs $0x1544,%rax
    102f:	00 00 00 
    1032:	ff d0                	call   *%rax
    1034:	39 45 fc             	cmp    %eax,-0x4(%rbp)
    1037:	74 2f                	je     1068 <cat+0x68>
      printf(1, "cat: write error\n");
    1039:	48 b8 38 1f 00 00 00 	movabs $0x1f38,%rax
    1040:	00 00 00 
    1043:	48 89 c6             	mov    %rax,%rsi
    1046:	bf 01 00 00 00       	mov    $0x1,%edi
    104b:	b8 00 00 00 00       	mov    $0x0,%eax
    1050:	48 ba 21 18 00 00 00 	movabs $0x1821,%rdx
    1057:	00 00 00 
    105a:	ff d2                	call   *%rdx
      exit();
    105c:	48 b8 10 15 00 00 00 	movabs $0x1510,%rax
    1063:	00 00 00 
    1066:	ff d0                	call   *%rax
  while((n = read(fd, buf, sizeof(buf))) > 0) {
    1068:	8b 45 ec             	mov    -0x14(%rbp),%eax
    106b:	ba 00 02 00 00       	mov    $0x200,%edx
    1070:	48 b9 60 20 00 00 00 	movabs $0x2060,%rcx
    1077:	00 00 00 
    107a:	48 89 ce             	mov    %rcx,%rsi
    107d:	89 c7                	mov    %eax,%edi
    107f:	48 b8 37 15 00 00 00 	movabs $0x1537,%rax
    1086:	00 00 00 
    1089:	ff d0                	call   *%rax
    108b:	89 45 fc             	mov    %eax,-0x4(%rbp)
    108e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1092:	0f 8f 79 ff ff ff    	jg     1011 <cat+0x11>
    }
  }
  if(n < 0){
    1098:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    109c:	79 2f                	jns    10cd <cat+0xcd>
    printf(1, "cat: read error\n");
    109e:	48 b8 4a 1f 00 00 00 	movabs $0x1f4a,%rax
    10a5:	00 00 00 
    10a8:	48 89 c6             	mov    %rax,%rsi
    10ab:	bf 01 00 00 00       	mov    $0x1,%edi
    10b0:	b8 00 00 00 00       	mov    $0x0,%eax
    10b5:	48 ba 21 18 00 00 00 	movabs $0x1821,%rdx
    10bc:	00 00 00 
    10bf:	ff d2                	call   *%rdx
    exit();
    10c1:	48 b8 10 15 00 00 00 	movabs $0x1510,%rax
    10c8:	00 00 00 
    10cb:	ff d0                	call   *%rax
  }
}
    10cd:	90                   	nop
    10ce:	c9                   	leave
    10cf:	c3                   	ret

00000000000010d0 <main>:

int
main(int argc, char *argv[])
{
    10d0:	f3 0f 1e fa          	endbr64
    10d4:	55                   	push   %rbp
    10d5:	48 89 e5             	mov    %rsp,%rbp
    10d8:	48 83 ec 20          	sub    $0x20,%rsp
    10dc:	89 7d ec             	mov    %edi,-0x14(%rbp)
    10df:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd, i;

  if(argc <= 1){
    10e3:	83 7d ec 01          	cmpl   $0x1,-0x14(%rbp)
    10e7:	7f 1d                	jg     1106 <main+0x36>
    cat(0);
    10e9:	bf 00 00 00 00       	mov    $0x0,%edi
    10ee:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    10f5:	00 00 00 
    10f8:	ff d0                	call   *%rax
    exit();
    10fa:	48 b8 10 15 00 00 00 	movabs $0x1510,%rax
    1101:	00 00 00 
    1104:	ff d0                	call   *%rax
  }

  for(i = 1; i < argc; i++){
    1106:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
    110d:	e9 a3 00 00 00       	jmp    11b5 <main+0xe5>
    if((fd = open(argv[i], 0)) < 0){
    1112:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1115:	48 98                	cltq
    1117:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    111e:	00 
    111f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1123:	48 01 d0             	add    %rdx,%rax
    1126:	48 8b 00             	mov    (%rax),%rax
    1129:	be 00 00 00 00       	mov    $0x0,%esi
    112e:	48 89 c7             	mov    %rax,%rdi
    1131:	48 b8 78 15 00 00 00 	movabs $0x1578,%rax
    1138:	00 00 00 
    113b:	ff d0                	call   *%rax
    113d:	89 45 f8             	mov    %eax,-0x8(%rbp)
    1140:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1144:	79 49                	jns    118f <main+0xbf>
      printf(1, "cat: cannot open %s\n", argv[i]);
    1146:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1149:	48 98                	cltq
    114b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1152:	00 
    1153:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1157:	48 01 d0             	add    %rdx,%rax
    115a:	48 8b 00             	mov    (%rax),%rax
    115d:	48 89 c2             	mov    %rax,%rdx
    1160:	48 b8 5b 1f 00 00 00 	movabs $0x1f5b,%rax
    1167:	00 00 00 
    116a:	48 89 c6             	mov    %rax,%rsi
    116d:	bf 01 00 00 00       	mov    $0x1,%edi
    1172:	b8 00 00 00 00       	mov    $0x0,%eax
    1177:	48 b9 21 18 00 00 00 	movabs $0x1821,%rcx
    117e:	00 00 00 
    1181:	ff d1                	call   *%rcx
      exit();
    1183:	48 b8 10 15 00 00 00 	movabs $0x1510,%rax
    118a:	00 00 00 
    118d:	ff d0                	call   *%rax
    }
    cat(fd);
    118f:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1192:	89 c7                	mov    %eax,%edi
    1194:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    119b:	00 00 00 
    119e:	ff d0                	call   *%rax
    close(fd);
    11a0:	8b 45 f8             	mov    -0x8(%rbp),%eax
    11a3:	89 c7                	mov    %eax,%edi
    11a5:	48 b8 51 15 00 00 00 	movabs $0x1551,%rax
    11ac:	00 00 00 
    11af:	ff d0                	call   *%rax
  for(i = 1; i < argc; i++){
    11b1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    11b5:	8b 45 fc             	mov    -0x4(%rbp),%eax
    11b8:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    11bb:	0f 8c 51 ff ff ff    	jl     1112 <main+0x42>
  }
  exit();
    11c1:	48 b8 10 15 00 00 00 	movabs $0x1510,%rax
    11c8:	00 00 00 
    11cb:	ff d0                	call   *%rax

00000000000011cd <stosb>:
  stosb(dst, c, n);
  return dst;
}

char*
strchr(const char *s, char c)
    11cd:	f3 0f 1e fa          	endbr64
    11d1:	55                   	push   %rbp
    11d2:	48 89 e5             	mov    %rsp,%rbp
    11d5:	48 83 ec 10          	sub    $0x10,%rsp
    11d9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    11dd:	89 75 f4             	mov    %esi,-0xc(%rbp)
    11e0:	89 55 f0             	mov    %edx,-0x10(%rbp)
{
    11e3:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    11e7:	8b 55 f0             	mov    -0x10(%rbp),%edx
    11ea:	8b 45 f4             	mov    -0xc(%rbp),%eax
    11ed:	48 89 ce             	mov    %rcx,%rsi
    11f0:	48 89 f7             	mov    %rsi,%rdi
    11f3:	89 d1                	mov    %edx,%ecx
    11f5:	fc                   	cld
    11f6:	f3 aa                	rep stos %al,%es:(%rdi)
    11f8:	89 ca                	mov    %ecx,%edx
    11fa:	48 89 fe             	mov    %rdi,%rsi
    11fd:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    1201:	89 55 f0             	mov    %edx,-0x10(%rbp)
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
    1204:	90                   	nop
    1205:	c9                   	leave
    1206:	c3                   	ret

0000000000001207 <strcpy>:
{
    1207:	f3 0f 1e fa          	endbr64
    120b:	55                   	push   %rbp
    120c:	48 89 e5             	mov    %rsp,%rbp
    120f:	48 83 ec 20          	sub    $0x20,%rsp
    1213:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1217:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  os = s;
    121b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    121f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    1223:	90                   	nop
    1224:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1228:	48 8d 42 01          	lea    0x1(%rdx),%rax
    122c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    1230:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1234:	48 8d 48 01          	lea    0x1(%rax),%rcx
    1238:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    123c:	0f b6 12             	movzbl (%rdx),%edx
    123f:	88 10                	mov    %dl,(%rax)
    1241:	0f b6 00             	movzbl (%rax),%eax
    1244:	84 c0                	test   %al,%al
    1246:	75 dc                	jne    1224 <strcpy+0x1d>
  return os;
    1248:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    124c:	c9                   	leave
    124d:	c3                   	ret

000000000000124e <strcmp>:
{
    124e:	f3 0f 1e fa          	endbr64
    1252:	55                   	push   %rbp
    1253:	48 89 e5             	mov    %rsp,%rbp
    1256:	48 83 ec 10          	sub    $0x10,%rsp
    125a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    125e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    1262:	eb 0a                	jmp    126e <strcmp+0x20>
    p++, q++;
    1264:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1269:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    126e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1272:	0f b6 00             	movzbl (%rax),%eax
    1275:	84 c0                	test   %al,%al
    1277:	74 12                	je     128b <strcmp+0x3d>
    1279:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    127d:	0f b6 10             	movzbl (%rax),%edx
    1280:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1284:	0f b6 00             	movzbl (%rax),%eax
    1287:	38 c2                	cmp    %al,%dl
    1289:	74 d9                	je     1264 <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
    128b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    128f:	0f b6 00             	movzbl (%rax),%eax
    1292:	0f b6 d0             	movzbl %al,%edx
    1295:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1299:	0f b6 00             	movzbl (%rax),%eax
    129c:	0f b6 c0             	movzbl %al,%eax
    129f:	29 c2                	sub    %eax,%edx
    12a1:	89 d0                	mov    %edx,%eax
}
    12a3:	c9                   	leave
    12a4:	c3                   	ret

00000000000012a5 <strlen>:
{
    12a5:	f3 0f 1e fa          	endbr64
    12a9:	55                   	push   %rbp
    12aa:	48 89 e5             	mov    %rsp,%rbp
    12ad:	48 83 ec 18          	sub    $0x18,%rsp
    12b1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  for(n = 0; s[n]; n++)
    12b5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    12bc:	eb 04                	jmp    12c2 <strlen+0x1d>
    12be:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    12c2:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12c5:	48 63 d0             	movslq %eax,%rdx
    12c8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12cc:	48 01 d0             	add    %rdx,%rax
    12cf:	0f b6 00             	movzbl (%rax),%eax
    12d2:	84 c0                	test   %al,%al
    12d4:	75 e8                	jne    12be <strlen+0x19>
  return n;
    12d6:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    12d9:	c9                   	leave
    12da:	c3                   	ret

00000000000012db <memset>:
{
    12db:	f3 0f 1e fa          	endbr64
    12df:	55                   	push   %rbp
    12e0:	48 89 e5             	mov    %rsp,%rbp
    12e3:	48 83 ec 10          	sub    $0x10,%rsp
    12e7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    12eb:	89 75 f4             	mov    %esi,-0xc(%rbp)
    12ee:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    12f1:	8b 55 f0             	mov    -0x10(%rbp),%edx
    12f4:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    12f7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    12fb:	89 ce                	mov    %ecx,%esi
    12fd:	48 89 c7             	mov    %rax,%rdi
    1300:	48 b8 cd 11 00 00 00 	movabs $0x11cd,%rax
    1307:	00 00 00 
    130a:	ff d0                	call   *%rax
  return dst;
    130c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    1310:	c9                   	leave
    1311:	c3                   	ret

0000000000001312 <strchr>:
{
    1312:	f3 0f 1e fa          	endbr64
    1316:	55                   	push   %rbp
    1317:	48 89 e5             	mov    %rsp,%rbp
    131a:	48 83 ec 10          	sub    $0x10,%rsp
    131e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1322:	89 f0                	mov    %esi,%eax
    1324:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    1327:	eb 17                	jmp    1340 <strchr+0x2e>
    if(*s == c)
    1329:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    132d:	0f b6 00             	movzbl (%rax),%eax
    1330:	38 45 f4             	cmp    %al,-0xc(%rbp)
    1333:	75 06                	jne    133b <strchr+0x29>
      return (char*)s;
    1335:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1339:	eb 15                	jmp    1350 <strchr+0x3e>
  for(; *s; s++)
    133b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1340:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1344:	0f b6 00             	movzbl (%rax),%eax
    1347:	84 c0                	test   %al,%al
    1349:	75 de                	jne    1329 <strchr+0x17>
  return 0;
    134b:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1350:	c9                   	leave
    1351:	c3                   	ret

0000000000001352 <gets>:

char*
gets(char *buf, int max)
{
    1352:	f3 0f 1e fa          	endbr64
    1356:	55                   	push   %rbp
    1357:	48 89 e5             	mov    %rsp,%rbp
    135a:	48 83 ec 20          	sub    $0x20,%rsp
    135e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1362:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1365:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    136c:	eb 4f                	jmp    13bd <gets+0x6b>
    cc = read(0, &c, 1);
    136e:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    1372:	ba 01 00 00 00       	mov    $0x1,%edx
    1377:	48 89 c6             	mov    %rax,%rsi
    137a:	bf 00 00 00 00       	mov    $0x0,%edi
    137f:	48 b8 37 15 00 00 00 	movabs $0x1537,%rax
    1386:	00 00 00 
    1389:	ff d0                	call   *%rax
    138b:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    138e:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1392:	7e 36                	jle    13ca <gets+0x78>
      break;
    buf[i++] = c;
    1394:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1397:	8d 50 01             	lea    0x1(%rax),%edx
    139a:	89 55 fc             	mov    %edx,-0x4(%rbp)
    139d:	48 63 d0             	movslq %eax,%rdx
    13a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    13a4:	48 01 c2             	add    %rax,%rdx
    13a7:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    13ab:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    13ad:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    13b1:	3c 0a                	cmp    $0xa,%al
    13b3:	74 16                	je     13cb <gets+0x79>
    13b5:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    13b9:	3c 0d                	cmp    $0xd,%al
    13bb:	74 0e                	je     13cb <gets+0x79>
  for(i=0; i+1 < max; ){
    13bd:	8b 45 fc             	mov    -0x4(%rbp),%eax
    13c0:	83 c0 01             	add    $0x1,%eax
    13c3:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    13c6:	7f a6                	jg     136e <gets+0x1c>
    13c8:	eb 01                	jmp    13cb <gets+0x79>
      break;
    13ca:	90                   	nop
      break;
  }
  buf[i] = '\0';
    13cb:	8b 45 fc             	mov    -0x4(%rbp),%eax
    13ce:	48 63 d0             	movslq %eax,%rdx
    13d1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    13d5:	48 01 d0             	add    %rdx,%rax
    13d8:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    13db:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    13df:	c9                   	leave
    13e0:	c3                   	ret

00000000000013e1 <stat>:

int
stat(char *n, struct stat *st)
{
    13e1:	f3 0f 1e fa          	endbr64
    13e5:	55                   	push   %rbp
    13e6:	48 89 e5             	mov    %rsp,%rbp
    13e9:	48 83 ec 20          	sub    $0x20,%rsp
    13ed:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    13f1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    13f5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    13f9:	be 00 00 00 00       	mov    $0x0,%esi
    13fe:	48 89 c7             	mov    %rax,%rdi
    1401:	48 b8 78 15 00 00 00 	movabs $0x1578,%rax
    1408:	00 00 00 
    140b:	ff d0                	call   *%rax
    140d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    1410:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1414:	79 07                	jns    141d <stat+0x3c>
    return -1;
    1416:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    141b:	eb 2f                	jmp    144c <stat+0x6b>
  r = fstat(fd, st);
    141d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1421:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1424:	48 89 d6             	mov    %rdx,%rsi
    1427:	89 c7                	mov    %eax,%edi
    1429:	48 b8 9f 15 00 00 00 	movabs $0x159f,%rax
    1430:	00 00 00 
    1433:	ff d0                	call   *%rax
    1435:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    1438:	8b 45 fc             	mov    -0x4(%rbp),%eax
    143b:	89 c7                	mov    %eax,%edi
    143d:	48 b8 51 15 00 00 00 	movabs $0x1551,%rax
    1444:	00 00 00 
    1447:	ff d0                	call   *%rax
  return r;
    1449:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    144c:	c9                   	leave
    144d:	c3                   	ret

000000000000144e <atoi>:

int
atoi(const char *s)
{
    144e:	f3 0f 1e fa          	endbr64
    1452:	55                   	push   %rbp
    1453:	48 89 e5             	mov    %rsp,%rbp
    1456:	48 83 ec 18          	sub    $0x18,%rsp
    145a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    145e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1465:	eb 28                	jmp    148f <atoi+0x41>
    n = n*10 + *s++ - '0';
    1467:	8b 55 fc             	mov    -0x4(%rbp),%edx
    146a:	89 d0                	mov    %edx,%eax
    146c:	c1 e0 02             	shl    $0x2,%eax
    146f:	01 d0                	add    %edx,%eax
    1471:	01 c0                	add    %eax,%eax
    1473:	89 c1                	mov    %eax,%ecx
    1475:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1479:	48 8d 50 01          	lea    0x1(%rax),%rdx
    147d:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    1481:	0f b6 00             	movzbl (%rax),%eax
    1484:	0f be c0             	movsbl %al,%eax
    1487:	01 c8                	add    %ecx,%eax
    1489:	83 e8 30             	sub    $0x30,%eax
    148c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    148f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1493:	0f b6 00             	movzbl (%rax),%eax
    1496:	3c 2f                	cmp    $0x2f,%al
    1498:	7e 0b                	jle    14a5 <atoi+0x57>
    149a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    149e:	0f b6 00             	movzbl (%rax),%eax
    14a1:	3c 39                	cmp    $0x39,%al
    14a3:	7e c2                	jle    1467 <atoi+0x19>
  return n;
    14a5:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    14a8:	c9                   	leave
    14a9:	c3                   	ret

00000000000014aa <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    14aa:	f3 0f 1e fa          	endbr64
    14ae:	55                   	push   %rbp
    14af:	48 89 e5             	mov    %rsp,%rbp
    14b2:	48 83 ec 28          	sub    $0x28,%rsp
    14b6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    14ba:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    14be:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    14c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    14c5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    14c9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    14cd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    14d1:	eb 1d                	jmp    14f0 <memmove+0x46>
    *dst++ = *src++;
    14d3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    14d7:	48 8d 42 01          	lea    0x1(%rdx),%rax
    14db:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    14df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    14e3:	48 8d 48 01          	lea    0x1(%rax),%rcx
    14e7:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    14eb:	0f b6 12             	movzbl (%rdx),%edx
    14ee:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    14f0:	8b 45 dc             	mov    -0x24(%rbp),%eax
    14f3:	8d 50 ff             	lea    -0x1(%rax),%edx
    14f6:	89 55 dc             	mov    %edx,-0x24(%rbp)
    14f9:	85 c0                	test   %eax,%eax
    14fb:	7f d6                	jg     14d3 <memmove+0x29>
  return vdst;
    14fd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    1501:	c9                   	leave
    1502:	c3                   	ret

0000000000001503 <fork>:
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    1503:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    150a:	49 89 ca             	mov    %rcx,%r10
    150d:	0f 05                	syscall
    150f:	c3                   	ret

0000000000001510 <exit>:
SYSCALL(exit)
    1510:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    1517:	49 89 ca             	mov    %rcx,%r10
    151a:	0f 05                	syscall
    151c:	c3                   	ret

000000000000151d <wait>:
SYSCALL(wait)
    151d:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    1524:	49 89 ca             	mov    %rcx,%r10
    1527:	0f 05                	syscall
    1529:	c3                   	ret

000000000000152a <pipe>:
SYSCALL(pipe)
    152a:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    1531:	49 89 ca             	mov    %rcx,%r10
    1534:	0f 05                	syscall
    1536:	c3                   	ret

0000000000001537 <read>:
SYSCALL(read)
    1537:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    153e:	49 89 ca             	mov    %rcx,%r10
    1541:	0f 05                	syscall
    1543:	c3                   	ret

0000000000001544 <write>:
SYSCALL(write)
    1544:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    154b:	49 89 ca             	mov    %rcx,%r10
    154e:	0f 05                	syscall
    1550:	c3                   	ret

0000000000001551 <close>:
SYSCALL(close)
    1551:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    1558:	49 89 ca             	mov    %rcx,%r10
    155b:	0f 05                	syscall
    155d:	c3                   	ret

000000000000155e <kill>:
SYSCALL(kill)
    155e:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    1565:	49 89 ca             	mov    %rcx,%r10
    1568:	0f 05                	syscall
    156a:	c3                   	ret

000000000000156b <exec>:
SYSCALL(exec)
    156b:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    1572:	49 89 ca             	mov    %rcx,%r10
    1575:	0f 05                	syscall
    1577:	c3                   	ret

0000000000001578 <open>:
SYSCALL(open)
    1578:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    157f:	49 89 ca             	mov    %rcx,%r10
    1582:	0f 05                	syscall
    1584:	c3                   	ret

0000000000001585 <mknod>:
SYSCALL(mknod)
    1585:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    158c:	49 89 ca             	mov    %rcx,%r10
    158f:	0f 05                	syscall
    1591:	c3                   	ret

0000000000001592 <unlink>:
SYSCALL(unlink)
    1592:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    1599:	49 89 ca             	mov    %rcx,%r10
    159c:	0f 05                	syscall
    159e:	c3                   	ret

000000000000159f <fstat>:
SYSCALL(fstat)
    159f:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    15a6:	49 89 ca             	mov    %rcx,%r10
    15a9:	0f 05                	syscall
    15ab:	c3                   	ret

00000000000015ac <link>:
SYSCALL(link)
    15ac:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    15b3:	49 89 ca             	mov    %rcx,%r10
    15b6:	0f 05                	syscall
    15b8:	c3                   	ret

00000000000015b9 <mkdir>:
SYSCALL(mkdir)
    15b9:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    15c0:	49 89 ca             	mov    %rcx,%r10
    15c3:	0f 05                	syscall
    15c5:	c3                   	ret

00000000000015c6 <chdir>:
SYSCALL(chdir)
    15c6:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    15cd:	49 89 ca             	mov    %rcx,%r10
    15d0:	0f 05                	syscall
    15d2:	c3                   	ret

00000000000015d3 <dup>:
SYSCALL(dup)
    15d3:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    15da:	49 89 ca             	mov    %rcx,%r10
    15dd:	0f 05                	syscall
    15df:	c3                   	ret

00000000000015e0 <getpid>:
SYSCALL(getpid)
    15e0:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    15e7:	49 89 ca             	mov    %rcx,%r10
    15ea:	0f 05                	syscall
    15ec:	c3                   	ret

00000000000015ed <sbrk>:
SYSCALL(sbrk)
    15ed:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    15f4:	49 89 ca             	mov    %rcx,%r10
    15f7:	0f 05                	syscall
    15f9:	c3                   	ret

00000000000015fa <sleep>:
SYSCALL(sleep)
    15fa:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    1601:	49 89 ca             	mov    %rcx,%r10
    1604:	0f 05                	syscall
    1606:	c3                   	ret

0000000000001607 <uptime>:
SYSCALL(uptime)
    1607:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    160e:	49 89 ca             	mov    %rcx,%r10
    1611:	0f 05                	syscall
    1613:	c3                   	ret

0000000000001614 <send>:
SYSCALL(send)
    1614:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    161b:	49 89 ca             	mov    %rcx,%r10
    161e:	0f 05                	syscall
    1620:	c3                   	ret

0000000000001621 <recv>:
SYSCALL(recv)
    1621:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    1628:	49 89 ca             	mov    %rcx,%r10
    162b:	0f 05                	syscall
    162d:	c3                   	ret

000000000000162e <register_fsserver>:
SYSCALL(register_fsserver)
    162e:	48 c7 c0 18 00 00 00 	mov    $0x18,%rax
    1635:	49 89 ca             	mov    %rcx,%r10
    1638:	0f 05                	syscall
    163a:	c3                   	ret

000000000000163b <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    163b:	f3 0f 1e fa          	endbr64
    163f:	55                   	push   %rbp
    1640:	48 89 e5             	mov    %rsp,%rbp
    1643:	48 83 ec 10          	sub    $0x10,%rsp
    1647:	89 7d fc             	mov    %edi,-0x4(%rbp)
    164a:	89 f0                	mov    %esi,%eax
    164c:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    164f:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    1653:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1656:	ba 01 00 00 00       	mov    $0x1,%edx
    165b:	48 89 ce             	mov    %rcx,%rsi
    165e:	89 c7                	mov    %eax,%edi
    1660:	48 b8 44 15 00 00 00 	movabs $0x1544,%rax
    1667:	00 00 00 
    166a:	ff d0                	call   *%rax
}
    166c:	90                   	nop
    166d:	c9                   	leave
    166e:	c3                   	ret

000000000000166f <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    166f:	f3 0f 1e fa          	endbr64
    1673:	55                   	push   %rbp
    1674:	48 89 e5             	mov    %rsp,%rbp
    1677:	48 83 ec 20          	sub    $0x20,%rsp
    167b:	89 7d ec             	mov    %edi,-0x14(%rbp)
    167e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1682:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1689:	eb 35                	jmp    16c0 <print_x64+0x51>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    168b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    168f:	48 c1 e8 3c          	shr    $0x3c,%rax
    1693:	48 ba 30 20 00 00 00 	movabs $0x2030,%rdx
    169a:	00 00 00 
    169d:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    16a1:	0f be d0             	movsbl %al,%edx
    16a4:	8b 45 ec             	mov    -0x14(%rbp),%eax
    16a7:	89 d6                	mov    %edx,%esi
    16a9:	89 c7                	mov    %eax,%edi
    16ab:	48 b8 3b 16 00 00 00 	movabs $0x163b,%rax
    16b2:	00 00 00 
    16b5:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    16b7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    16bb:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    16c0:	8b 45 fc             	mov    -0x4(%rbp),%eax
    16c3:	83 f8 0f             	cmp    $0xf,%eax
    16c6:	76 c3                	jbe    168b <print_x64+0x1c>
}
    16c8:	90                   	nop
    16c9:	90                   	nop
    16ca:	c9                   	leave
    16cb:	c3                   	ret

00000000000016cc <print_x32>:

  static void
print_x32(int fd, uint x)
{
    16cc:	f3 0f 1e fa          	endbr64
    16d0:	55                   	push   %rbp
    16d1:	48 89 e5             	mov    %rsp,%rbp
    16d4:	48 83 ec 20          	sub    $0x20,%rsp
    16d8:	89 7d ec             	mov    %edi,-0x14(%rbp)
    16db:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    16de:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    16e5:	eb 36                	jmp    171d <print_x32+0x51>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    16e7:	8b 45 e8             	mov    -0x18(%rbp),%eax
    16ea:	c1 e8 1c             	shr    $0x1c,%eax
    16ed:	89 c2                	mov    %eax,%edx
    16ef:	48 b8 30 20 00 00 00 	movabs $0x2030,%rax
    16f6:	00 00 00 
    16f9:	89 d2                	mov    %edx,%edx
    16fb:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    16ff:	0f be d0             	movsbl %al,%edx
    1702:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1705:	89 d6                	mov    %edx,%esi
    1707:	89 c7                	mov    %eax,%edi
    1709:	48 b8 3b 16 00 00 00 	movabs $0x163b,%rax
    1710:	00 00 00 
    1713:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1715:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1719:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    171d:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1720:	83 f8 07             	cmp    $0x7,%eax
    1723:	76 c2                	jbe    16e7 <print_x32+0x1b>
}
    1725:	90                   	nop
    1726:	90                   	nop
    1727:	c9                   	leave
    1728:	c3                   	ret

0000000000001729 <print_d>:

  static void
print_d(int fd, int v)
{
    1729:	f3 0f 1e fa          	endbr64
    172d:	55                   	push   %rbp
    172e:	48 89 e5             	mov    %rsp,%rbp
    1731:	48 83 ec 30          	sub    $0x30,%rsp
    1735:	89 7d dc             	mov    %edi,-0x24(%rbp)
    1738:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    173b:	8b 45 d8             	mov    -0x28(%rbp),%eax
    173e:	48 98                	cltq
    1740:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    1744:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1748:	79 04                	jns    174e <print_d+0x25>
    x = -x;
    174a:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    174e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    1755:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1759:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1760:	66 66 66 
    1763:	48 89 c8             	mov    %rcx,%rax
    1766:	48 f7 ea             	imul   %rdx
    1769:	48 c1 fa 02          	sar    $0x2,%rdx
    176d:	48 89 c8             	mov    %rcx,%rax
    1770:	48 c1 f8 3f          	sar    $0x3f,%rax
    1774:	48 29 c2             	sub    %rax,%rdx
    1777:	48 89 d0             	mov    %rdx,%rax
    177a:	48 c1 e0 02          	shl    $0x2,%rax
    177e:	48 01 d0             	add    %rdx,%rax
    1781:	48 01 c0             	add    %rax,%rax
    1784:	48 29 c1             	sub    %rax,%rcx
    1787:	48 89 ca             	mov    %rcx,%rdx
    178a:	8b 45 f4             	mov    -0xc(%rbp),%eax
    178d:	8d 48 01             	lea    0x1(%rax),%ecx
    1790:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    1793:	48 b9 30 20 00 00 00 	movabs $0x2030,%rcx
    179a:	00 00 00 
    179d:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    17a1:	48 98                	cltq
    17a3:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    17a7:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    17ab:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    17b2:	66 66 66 
    17b5:	48 89 c8             	mov    %rcx,%rax
    17b8:	48 f7 ea             	imul   %rdx
    17bb:	48 89 d0             	mov    %rdx,%rax
    17be:	48 c1 f8 02          	sar    $0x2,%rax
    17c2:	48 c1 f9 3f          	sar    $0x3f,%rcx
    17c6:	48 89 ca             	mov    %rcx,%rdx
    17c9:	48 29 d0             	sub    %rdx,%rax
    17cc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    17d0:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    17d5:	0f 85 7a ff ff ff    	jne    1755 <print_d+0x2c>

  if (v < 0)
    17db:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    17df:	79 32                	jns    1813 <print_d+0xea>
    buf[i++] = '-';
    17e1:	8b 45 f4             	mov    -0xc(%rbp),%eax
    17e4:	8d 50 01             	lea    0x1(%rax),%edx
    17e7:	89 55 f4             	mov    %edx,-0xc(%rbp)
    17ea:	48 98                	cltq
    17ec:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    17f1:	eb 20                	jmp    1813 <print_d+0xea>
    putc(fd, buf[i]);
    17f3:	8b 45 f4             	mov    -0xc(%rbp),%eax
    17f6:	48 98                	cltq
    17f8:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    17fd:	0f be d0             	movsbl %al,%edx
    1800:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1803:	89 d6                	mov    %edx,%esi
    1805:	89 c7                	mov    %eax,%edi
    1807:	48 b8 3b 16 00 00 00 	movabs $0x163b,%rax
    180e:	00 00 00 
    1811:	ff d0                	call   *%rax
  while (--i >= 0)
    1813:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    1817:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    181b:	79 d6                	jns    17f3 <print_d+0xca>
}
    181d:	90                   	nop
    181e:	90                   	nop
    181f:	c9                   	leave
    1820:	c3                   	ret

0000000000001821 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    1821:	f3 0f 1e fa          	endbr64
    1825:	55                   	push   %rbp
    1826:	48 89 e5             	mov    %rsp,%rbp
    1829:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    1830:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    1836:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    183d:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    1844:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    184b:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    1852:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    1859:	84 c0                	test   %al,%al
    185b:	74 20                	je     187d <printf+0x5c>
    185d:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    1861:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    1865:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    1869:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    186d:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    1871:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    1875:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    1879:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    187d:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    1884:	00 00 00 
    1887:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    188e:	00 00 00 
    1891:	48 8d 45 10          	lea    0x10(%rbp),%rax
    1895:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    189c:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    18a3:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    18aa:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    18b1:	00 00 00 
    18b4:	e9 41 03 00 00       	jmp    1bfa <printf+0x3d9>
    if (c != '%') {
    18b9:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    18c0:	74 24                	je     18e6 <printf+0xc5>
      putc(fd, c);
    18c2:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    18c8:	0f be d0             	movsbl %al,%edx
    18cb:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    18d1:	89 d6                	mov    %edx,%esi
    18d3:	89 c7                	mov    %eax,%edi
    18d5:	48 b8 3b 16 00 00 00 	movabs $0x163b,%rax
    18dc:	00 00 00 
    18df:	ff d0                	call   *%rax
      continue;
    18e1:	e9 0d 03 00 00       	jmp    1bf3 <printf+0x3d2>
    }
    c = fmt[++i] & 0xff;
    18e6:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    18ed:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    18f3:	48 63 d0             	movslq %eax,%rdx
    18f6:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    18fd:	48 01 d0             	add    %rdx,%rax
    1900:	0f b6 00             	movzbl (%rax),%eax
    1903:	0f be c0             	movsbl %al,%eax
    1906:	25 ff 00 00 00       	and    $0xff,%eax
    190b:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    1911:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1918:	0f 84 0f 03 00 00    	je     1c2d <printf+0x40c>
      break;
    switch(c) {
    191e:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1925:	0f 84 74 02 00 00    	je     1b9f <printf+0x37e>
    192b:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1932:	0f 8c 82 02 00 00    	jl     1bba <printf+0x399>
    1938:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    193f:	0f 8f 75 02 00 00    	jg     1bba <printf+0x399>
    1945:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    194c:	0f 8c 68 02 00 00    	jl     1bba <printf+0x399>
    1952:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1958:	83 e8 63             	sub    $0x63,%eax
    195b:	83 f8 15             	cmp    $0x15,%eax
    195e:	0f 87 56 02 00 00    	ja     1bba <printf+0x399>
    1964:	89 c0                	mov    %eax,%eax
    1966:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    196d:	00 
    196e:	48 b8 78 1f 00 00 00 	movabs $0x1f78,%rax
    1975:	00 00 00 
    1978:	48 01 d0             	add    %rdx,%rax
    197b:	48 8b 00             	mov    (%rax),%rax
    197e:	3e ff e0             	notrack jmp *%rax
    case 'c':
      putc(fd, va_arg(ap, int));
    1981:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1987:	83 f8 2f             	cmp    $0x2f,%eax
    198a:	77 23                	ja     19af <printf+0x18e>
    198c:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1993:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1999:	89 d2                	mov    %edx,%edx
    199b:	48 01 d0             	add    %rdx,%rax
    199e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19a4:	83 c2 08             	add    $0x8,%edx
    19a7:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    19ad:	eb 12                	jmp    19c1 <printf+0x1a0>
    19af:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    19b6:	48 8d 50 08          	lea    0x8(%rax),%rdx
    19ba:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    19c1:	8b 00                	mov    (%rax),%eax
    19c3:	0f be d0             	movsbl %al,%edx
    19c6:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    19cc:	89 d6                	mov    %edx,%esi
    19ce:	89 c7                	mov    %eax,%edi
    19d0:	48 b8 3b 16 00 00 00 	movabs $0x163b,%rax
    19d7:	00 00 00 
    19da:	ff d0                	call   *%rax
      break;
    19dc:	e9 12 02 00 00       	jmp    1bf3 <printf+0x3d2>
    case 'd':
      print_d(fd, va_arg(ap, int));
    19e1:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    19e7:	83 f8 2f             	cmp    $0x2f,%eax
    19ea:	77 23                	ja     1a0f <printf+0x1ee>
    19ec:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    19f3:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19f9:	89 d2                	mov    %edx,%edx
    19fb:	48 01 d0             	add    %rdx,%rax
    19fe:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a04:	83 c2 08             	add    $0x8,%edx
    1a07:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1a0d:	eb 12                	jmp    1a21 <printf+0x200>
    1a0f:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a16:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a1a:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a21:	8b 10                	mov    (%rax),%edx
    1a23:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a29:	89 d6                	mov    %edx,%esi
    1a2b:	89 c7                	mov    %eax,%edi
    1a2d:	48 b8 29 17 00 00 00 	movabs $0x1729,%rax
    1a34:	00 00 00 
    1a37:	ff d0                	call   *%rax
      break;
    1a39:	e9 b5 01 00 00       	jmp    1bf3 <printf+0x3d2>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    1a3e:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1a44:	83 f8 2f             	cmp    $0x2f,%eax
    1a47:	77 23                	ja     1a6c <printf+0x24b>
    1a49:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1a50:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a56:	89 d2                	mov    %edx,%edx
    1a58:	48 01 d0             	add    %rdx,%rax
    1a5b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a61:	83 c2 08             	add    $0x8,%edx
    1a64:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1a6a:	eb 12                	jmp    1a7e <printf+0x25d>
    1a6c:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a73:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a77:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a7e:	8b 10                	mov    (%rax),%edx
    1a80:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a86:	89 d6                	mov    %edx,%esi
    1a88:	89 c7                	mov    %eax,%edi
    1a8a:	48 b8 cc 16 00 00 00 	movabs $0x16cc,%rax
    1a91:	00 00 00 
    1a94:	ff d0                	call   *%rax
      break;
    1a96:	e9 58 01 00 00       	jmp    1bf3 <printf+0x3d2>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    1a9b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1aa1:	83 f8 2f             	cmp    $0x2f,%eax
    1aa4:	77 23                	ja     1ac9 <printf+0x2a8>
    1aa6:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1aad:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1ab3:	89 d2                	mov    %edx,%edx
    1ab5:	48 01 d0             	add    %rdx,%rax
    1ab8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1abe:	83 c2 08             	add    $0x8,%edx
    1ac1:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1ac7:	eb 12                	jmp    1adb <printf+0x2ba>
    1ac9:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1ad0:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1ad4:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1adb:	48 8b 10             	mov    (%rax),%rdx
    1ade:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1ae4:	48 89 d6             	mov    %rdx,%rsi
    1ae7:	89 c7                	mov    %eax,%edi
    1ae9:	48 b8 6f 16 00 00 00 	movabs $0x166f,%rax
    1af0:	00 00 00 
    1af3:	ff d0                	call   *%rax
      break;
    1af5:	e9 f9 00 00 00       	jmp    1bf3 <printf+0x3d2>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    1afa:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1b00:	83 f8 2f             	cmp    $0x2f,%eax
    1b03:	77 23                	ja     1b28 <printf+0x307>
    1b05:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1b0c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b12:	89 d2                	mov    %edx,%edx
    1b14:	48 01 d0             	add    %rdx,%rax
    1b17:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b1d:	83 c2 08             	add    $0x8,%edx
    1b20:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1b26:	eb 12                	jmp    1b3a <printf+0x319>
    1b28:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1b2f:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1b33:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1b3a:	48 8b 00             	mov    (%rax),%rax
    1b3d:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    1b44:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1b4b:	00 
    1b4c:	75 41                	jne    1b8f <printf+0x36e>
        s = "(null)";
    1b4e:	48 b8 70 1f 00 00 00 	movabs $0x1f70,%rax
    1b55:	00 00 00 
    1b58:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1b5f:	eb 2e                	jmp    1b8f <printf+0x36e>
        putc(fd, *(s++));
    1b61:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1b68:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1b6c:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1b73:	0f b6 00             	movzbl (%rax),%eax
    1b76:	0f be d0             	movsbl %al,%edx
    1b79:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b7f:	89 d6                	mov    %edx,%esi
    1b81:	89 c7                	mov    %eax,%edi
    1b83:	48 b8 3b 16 00 00 00 	movabs $0x163b,%rax
    1b8a:	00 00 00 
    1b8d:	ff d0                	call   *%rax
      while (*s)
    1b8f:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1b96:	0f b6 00             	movzbl (%rax),%eax
    1b99:	84 c0                	test   %al,%al
    1b9b:	75 c4                	jne    1b61 <printf+0x340>
      break;
    1b9d:	eb 54                	jmp    1bf3 <printf+0x3d2>
    case '%':
      putc(fd, '%');
    1b9f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1ba5:	be 25 00 00 00       	mov    $0x25,%esi
    1baa:	89 c7                	mov    %eax,%edi
    1bac:	48 b8 3b 16 00 00 00 	movabs $0x163b,%rax
    1bb3:	00 00 00 
    1bb6:	ff d0                	call   *%rax
      break;
    1bb8:	eb 39                	jmp    1bf3 <printf+0x3d2>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1bba:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1bc0:	be 25 00 00 00       	mov    $0x25,%esi
    1bc5:	89 c7                	mov    %eax,%edi
    1bc7:	48 b8 3b 16 00 00 00 	movabs $0x163b,%rax
    1bce:	00 00 00 
    1bd1:	ff d0                	call   *%rax
      putc(fd, c);
    1bd3:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1bd9:	0f be d0             	movsbl %al,%edx
    1bdc:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1be2:	89 d6                	mov    %edx,%esi
    1be4:	89 c7                	mov    %eax,%edi
    1be6:	48 b8 3b 16 00 00 00 	movabs $0x163b,%rax
    1bed:	00 00 00 
    1bf0:	ff d0                	call   *%rax
      break;
    1bf2:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1bf3:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1bfa:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1c00:	48 63 d0             	movslq %eax,%rdx
    1c03:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1c0a:	48 01 d0             	add    %rdx,%rax
    1c0d:	0f b6 00             	movzbl (%rax),%eax
    1c10:	0f be c0             	movsbl %al,%eax
    1c13:	25 ff 00 00 00       	and    $0xff,%eax
    1c18:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1c1e:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1c25:	0f 85 8e fc ff ff    	jne    18b9 <printf+0x98>
    }
  }
}
    1c2b:	eb 01                	jmp    1c2e <printf+0x40d>
      break;
    1c2d:	90                   	nop
}
    1c2e:	90                   	nop
    1c2f:	c9                   	leave
    1c30:	c3                   	ret

0000000000001c31 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1c31:	f3 0f 1e fa          	endbr64
    1c35:	55                   	push   %rbp
    1c36:	48 89 e5             	mov    %rsp,%rbp
    1c39:	48 83 ec 18          	sub    $0x18,%rsp
    1c3d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1c41:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1c45:	48 83 e8 10          	sub    $0x10,%rax
    1c49:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1c4d:	48 b8 70 22 00 00 00 	movabs $0x2270,%rax
    1c54:	00 00 00 
    1c57:	48 8b 00             	mov    (%rax),%rax
    1c5a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1c5e:	eb 2f                	jmp    1c8f <free+0x5e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1c60:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c64:	48 8b 00             	mov    (%rax),%rax
    1c67:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1c6b:	72 17                	jb     1c84 <free+0x53>
    1c6d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c71:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1c75:	72 2f                	jb     1ca6 <free+0x75>
    1c77:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c7b:	48 8b 00             	mov    (%rax),%rax
    1c7e:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1c82:	72 22                	jb     1ca6 <free+0x75>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1c84:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c88:	48 8b 00             	mov    (%rax),%rax
    1c8b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1c8f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c93:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1c97:	73 c7                	jae    1c60 <free+0x2f>
    1c99:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c9d:	48 8b 00             	mov    (%rax),%rax
    1ca0:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1ca4:	73 ba                	jae    1c60 <free+0x2f>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1ca6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1caa:	8b 40 08             	mov    0x8(%rax),%eax
    1cad:	89 c0                	mov    %eax,%eax
    1caf:	48 c1 e0 04          	shl    $0x4,%rax
    1cb3:	48 89 c2             	mov    %rax,%rdx
    1cb6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cba:	48 01 c2             	add    %rax,%rdx
    1cbd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cc1:	48 8b 00             	mov    (%rax),%rax
    1cc4:	48 39 c2             	cmp    %rax,%rdx
    1cc7:	75 2d                	jne    1cf6 <free+0xc5>
    bp->s.size += p->s.ptr->s.size;
    1cc9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ccd:	8b 50 08             	mov    0x8(%rax),%edx
    1cd0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cd4:	48 8b 00             	mov    (%rax),%rax
    1cd7:	8b 40 08             	mov    0x8(%rax),%eax
    1cda:	01 c2                	add    %eax,%edx
    1cdc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ce0:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1ce3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ce7:	48 8b 00             	mov    (%rax),%rax
    1cea:	48 8b 10             	mov    (%rax),%rdx
    1ced:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cf1:	48 89 10             	mov    %rdx,(%rax)
    1cf4:	eb 0e                	jmp    1d04 <free+0xd3>
  } else
    bp->s.ptr = p->s.ptr;
    1cf6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cfa:	48 8b 10             	mov    (%rax),%rdx
    1cfd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d01:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    1d04:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d08:	8b 40 08             	mov    0x8(%rax),%eax
    1d0b:	89 c0                	mov    %eax,%eax
    1d0d:	48 c1 e0 04          	shl    $0x4,%rax
    1d11:	48 89 c2             	mov    %rax,%rdx
    1d14:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d18:	48 01 d0             	add    %rdx,%rax
    1d1b:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1d1f:	75 27                	jne    1d48 <free+0x117>
    p->s.size += bp->s.size;
    1d21:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d25:	8b 50 08             	mov    0x8(%rax),%edx
    1d28:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d2c:	8b 40 08             	mov    0x8(%rax),%eax
    1d2f:	01 c2                	add    %eax,%edx
    1d31:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d35:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    1d38:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d3c:	48 8b 10             	mov    (%rax),%rdx
    1d3f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d43:	48 89 10             	mov    %rdx,(%rax)
    1d46:	eb 0b                	jmp    1d53 <free+0x122>
  } else
    p->s.ptr = bp;
    1d48:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d4c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1d50:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    1d53:	48 ba 70 22 00 00 00 	movabs $0x2270,%rdx
    1d5a:	00 00 00 
    1d5d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d61:	48 89 02             	mov    %rax,(%rdx)
}
    1d64:	90                   	nop
    1d65:	c9                   	leave
    1d66:	c3                   	ret

0000000000001d67 <morecore>:

static Header*
morecore(uint nu)
{
    1d67:	f3 0f 1e fa          	endbr64
    1d6b:	55                   	push   %rbp
    1d6c:	48 89 e5             	mov    %rsp,%rbp
    1d6f:	48 83 ec 20          	sub    $0x20,%rsp
    1d73:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    1d76:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1d7d:	77 07                	ja     1d86 <morecore+0x1f>
    nu = 4096;
    1d7f:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    1d86:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1d89:	48 c1 e0 04          	shl    $0x4,%rax
    1d8d:	48 89 c7             	mov    %rax,%rdi
    1d90:	48 b8 ed 15 00 00 00 	movabs $0x15ed,%rax
    1d97:	00 00 00 
    1d9a:	ff d0                	call   *%rax
    1d9c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    1da0:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1da5:	75 07                	jne    1dae <morecore+0x47>
    return 0;
    1da7:	b8 00 00 00 00       	mov    $0x0,%eax
    1dac:	eb 36                	jmp    1de4 <morecore+0x7d>
  hp = (Header*)p;
    1dae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1db2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    1db6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1dba:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1dbd:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    1dc0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1dc4:	48 83 c0 10          	add    $0x10,%rax
    1dc8:	48 89 c7             	mov    %rax,%rdi
    1dcb:	48 b8 31 1c 00 00 00 	movabs $0x1c31,%rax
    1dd2:	00 00 00 
    1dd5:	ff d0                	call   *%rax
  return freep;
    1dd7:	48 b8 70 22 00 00 00 	movabs $0x2270,%rax
    1dde:	00 00 00 
    1de1:	48 8b 00             	mov    (%rax),%rax
}
    1de4:	c9                   	leave
    1de5:	c3                   	ret

0000000000001de6 <malloc>:

void*
malloc(uint nbytes)
{
    1de6:	f3 0f 1e fa          	endbr64
    1dea:	55                   	push   %rbp
    1deb:	48 89 e5             	mov    %rsp,%rbp
    1dee:	48 83 ec 30          	sub    $0x30,%rsp
    1df2:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1df5:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1df8:	48 83 c0 0f          	add    $0xf,%rax
    1dfc:	48 c1 e8 04          	shr    $0x4,%rax
    1e00:	83 c0 01             	add    $0x1,%eax
    1e03:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    1e06:	48 b8 70 22 00 00 00 	movabs $0x2270,%rax
    1e0d:	00 00 00 
    1e10:	48 8b 00             	mov    (%rax),%rax
    1e13:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1e17:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1e1c:	75 4a                	jne    1e68 <malloc+0x82>
    base.s.ptr = freep = prevp = &base;
    1e1e:	48 b8 60 22 00 00 00 	movabs $0x2260,%rax
    1e25:	00 00 00 
    1e28:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1e2c:	48 ba 70 22 00 00 00 	movabs $0x2270,%rdx
    1e33:	00 00 00 
    1e36:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e3a:	48 89 02             	mov    %rax,(%rdx)
    1e3d:	48 b8 70 22 00 00 00 	movabs $0x2270,%rax
    1e44:	00 00 00 
    1e47:	48 8b 00             	mov    (%rax),%rax
    1e4a:	48 ba 60 22 00 00 00 	movabs $0x2260,%rdx
    1e51:	00 00 00 
    1e54:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    1e57:	48 b8 60 22 00 00 00 	movabs $0x2260,%rax
    1e5e:	00 00 00 
    1e61:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1e68:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e6c:	48 8b 00             	mov    (%rax),%rax
    1e6f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1e73:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e77:	8b 40 08             	mov    0x8(%rax),%eax
    1e7a:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1e7d:	72 65                	jb     1ee4 <malloc+0xfe>
      if(p->s.size == nunits)
    1e7f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e83:	8b 40 08             	mov    0x8(%rax),%eax
    1e86:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1e89:	75 10                	jne    1e9b <malloc+0xb5>
        prevp->s.ptr = p->s.ptr;
    1e8b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e8f:	48 8b 10             	mov    (%rax),%rdx
    1e92:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e96:	48 89 10             	mov    %rdx,(%rax)
    1e99:	eb 2e                	jmp    1ec9 <malloc+0xe3>
      else {
        p->s.size -= nunits;
    1e9b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e9f:	8b 40 08             	mov    0x8(%rax),%eax
    1ea2:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1ea5:	89 c2                	mov    %eax,%edx
    1ea7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1eab:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    1eae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1eb2:	8b 40 08             	mov    0x8(%rax),%eax
    1eb5:	89 c0                	mov    %eax,%eax
    1eb7:	48 c1 e0 04          	shl    $0x4,%rax
    1ebb:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    1ebf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ec3:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1ec6:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    1ec9:	48 ba 70 22 00 00 00 	movabs $0x2270,%rdx
    1ed0:	00 00 00 
    1ed3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ed7:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    1eda:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ede:	48 83 c0 10          	add    $0x10,%rax
    1ee2:	eb 4e                	jmp    1f32 <malloc+0x14c>
    }
    if(p == freep)
    1ee4:	48 b8 70 22 00 00 00 	movabs $0x2270,%rax
    1eeb:	00 00 00 
    1eee:	48 8b 00             	mov    (%rax),%rax
    1ef1:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1ef5:	75 23                	jne    1f1a <malloc+0x134>
      if((p = morecore(nunits)) == 0)
    1ef7:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1efa:	89 c7                	mov    %eax,%edi
    1efc:	48 b8 67 1d 00 00 00 	movabs $0x1d67,%rax
    1f03:	00 00 00 
    1f06:	ff d0                	call   *%rax
    1f08:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1f0c:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1f11:	75 07                	jne    1f1a <malloc+0x134>
        return 0;
    1f13:	b8 00 00 00 00       	mov    $0x0,%eax
    1f18:	eb 18                	jmp    1f32 <malloc+0x14c>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1f1a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f1e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1f22:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f26:	48 8b 00             	mov    (%rax),%rax
    1f29:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1f2d:	e9 41 ff ff ff       	jmp    1e73 <malloc+0x8d>
  }
}
    1f32:	c9                   	leave
    1f33:	c3                   	ret
