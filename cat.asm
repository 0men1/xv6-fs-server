
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
    1016:	48 b8 40 20 00 00 00 	movabs $0x2040,%rax
    101d:	00 00 00 
    1020:	48 89 c6             	mov    %rax,%rsi
    1023:	bf 01 00 00 00       	mov    $0x1,%edi
    1028:	48 b8 44 15 00 00 00 	movabs $0x1544,%rax
    102f:	00 00 00 
    1032:	ff d0                	call   *%rax
    1034:	39 45 fc             	cmp    %eax,-0x4(%rbp)
    1037:	74 2f                	je     1068 <cat+0x68>
      printf(1, "cat: write error\n");
    1039:	48 b8 20 1f 00 00 00 	movabs $0x1f20,%rax
    1040:	00 00 00 
    1043:	48 89 c6             	mov    %rax,%rsi
    1046:	bf 01 00 00 00       	mov    $0x1,%edi
    104b:	b8 00 00 00 00       	mov    $0x0,%eax
    1050:	48 ba 14 18 00 00 00 	movabs $0x1814,%rdx
    1057:	00 00 00 
    105a:	ff d2                	call   *%rdx
      exit();
    105c:	48 b8 10 15 00 00 00 	movabs $0x1510,%rax
    1063:	00 00 00 
    1066:	ff d0                	call   *%rax
  while((n = read(fd, buf, sizeof(buf))) > 0) {
    1068:	8b 45 ec             	mov    -0x14(%rbp),%eax
    106b:	ba 00 02 00 00       	mov    $0x200,%edx
    1070:	48 b9 40 20 00 00 00 	movabs $0x2040,%rcx
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
    109e:	48 b8 32 1f 00 00 00 	movabs $0x1f32,%rax
    10a5:	00 00 00 
    10a8:	48 89 c6             	mov    %rax,%rsi
    10ab:	bf 01 00 00 00       	mov    $0x1,%edi
    10b0:	b8 00 00 00 00       	mov    $0x0,%eax
    10b5:	48 ba 14 18 00 00 00 	movabs $0x1814,%rdx
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
    1160:	48 b8 43 1f 00 00 00 	movabs $0x1f43,%rax
    1167:	00 00 00 
    116a:	48 89 c6             	mov    %rax,%rsi
    116d:	bf 01 00 00 00       	mov    $0x1,%edi
    1172:	b8 00 00 00 00       	mov    $0x0,%eax
    1177:	48 b9 14 18 00 00 00 	movabs $0x1814,%rcx
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
    1503:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    150a:	49 89 ca             	mov    %rcx,%r10
    150d:	0f 05                	syscall
    150f:	c3                   	ret

0000000000001510 <exit>:
    1510:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    1517:	49 89 ca             	mov    %rcx,%r10
    151a:	0f 05                	syscall
    151c:	c3                   	ret

000000000000151d <wait>:
    151d:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    1524:	49 89 ca             	mov    %rcx,%r10
    1527:	0f 05                	syscall
    1529:	c3                   	ret

000000000000152a <pipe>:
    152a:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    1531:	49 89 ca             	mov    %rcx,%r10
    1534:	0f 05                	syscall
    1536:	c3                   	ret

0000000000001537 <read>:
    1537:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    153e:	49 89 ca             	mov    %rcx,%r10
    1541:	0f 05                	syscall
    1543:	c3                   	ret

0000000000001544 <write>:
    1544:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    154b:	49 89 ca             	mov    %rcx,%r10
    154e:	0f 05                	syscall
    1550:	c3                   	ret

0000000000001551 <close>:
    1551:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    1558:	49 89 ca             	mov    %rcx,%r10
    155b:	0f 05                	syscall
    155d:	c3                   	ret

000000000000155e <kill>:
    155e:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    1565:	49 89 ca             	mov    %rcx,%r10
    1568:	0f 05                	syscall
    156a:	c3                   	ret

000000000000156b <exec>:
    156b:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    1572:	49 89 ca             	mov    %rcx,%r10
    1575:	0f 05                	syscall
    1577:	c3                   	ret

0000000000001578 <open>:
    1578:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    157f:	49 89 ca             	mov    %rcx,%r10
    1582:	0f 05                	syscall
    1584:	c3                   	ret

0000000000001585 <mknod>:
    1585:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    158c:	49 89 ca             	mov    %rcx,%r10
    158f:	0f 05                	syscall
    1591:	c3                   	ret

0000000000001592 <unlink>:
    1592:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    1599:	49 89 ca             	mov    %rcx,%r10
    159c:	0f 05                	syscall
    159e:	c3                   	ret

000000000000159f <fstat>:
    159f:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    15a6:	49 89 ca             	mov    %rcx,%r10
    15a9:	0f 05                	syscall
    15ab:	c3                   	ret

00000000000015ac <link>:
    15ac:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    15b3:	49 89 ca             	mov    %rcx,%r10
    15b6:	0f 05                	syscall
    15b8:	c3                   	ret

00000000000015b9 <mkdir>:
    15b9:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    15c0:	49 89 ca             	mov    %rcx,%r10
    15c3:	0f 05                	syscall
    15c5:	c3                   	ret

00000000000015c6 <chdir>:
    15c6:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    15cd:	49 89 ca             	mov    %rcx,%r10
    15d0:	0f 05                	syscall
    15d2:	c3                   	ret

00000000000015d3 <dup>:
    15d3:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    15da:	49 89 ca             	mov    %rcx,%r10
    15dd:	0f 05                	syscall
    15df:	c3                   	ret

00000000000015e0 <getpid>:
    15e0:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    15e7:	49 89 ca             	mov    %rcx,%r10
    15ea:	0f 05                	syscall
    15ec:	c3                   	ret

00000000000015ed <sbrk>:
    15ed:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    15f4:	49 89 ca             	mov    %rcx,%r10
    15f7:	0f 05                	syscall
    15f9:	c3                   	ret

00000000000015fa <sleep>:
    15fa:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    1601:	49 89 ca             	mov    %rcx,%r10
    1604:	0f 05                	syscall
    1606:	c3                   	ret

0000000000001607 <uptime>:
    1607:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    160e:	49 89 ca             	mov    %rcx,%r10
    1611:	0f 05                	syscall
    1613:	c3                   	ret

0000000000001614 <send>:
    1614:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    161b:	49 89 ca             	mov    %rcx,%r10
    161e:	0f 05                	syscall
    1620:	c3                   	ret

0000000000001621 <recv>:
    1621:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    1628:	49 89 ca             	mov    %rcx,%r10
    162b:	0f 05                	syscall
    162d:	c3                   	ret

000000000000162e <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    162e:	f3 0f 1e fa          	endbr64
    1632:	55                   	push   %rbp
    1633:	48 89 e5             	mov    %rsp,%rbp
    1636:	48 83 ec 10          	sub    $0x10,%rsp
    163a:	89 7d fc             	mov    %edi,-0x4(%rbp)
    163d:	89 f0                	mov    %esi,%eax
    163f:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    1642:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    1646:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1649:	ba 01 00 00 00       	mov    $0x1,%edx
    164e:	48 89 ce             	mov    %rcx,%rsi
    1651:	89 c7                	mov    %eax,%edi
    1653:	48 b8 44 15 00 00 00 	movabs $0x1544,%rax
    165a:	00 00 00 
    165d:	ff d0                	call   *%rax
}
    165f:	90                   	nop
    1660:	c9                   	leave
    1661:	c3                   	ret

0000000000001662 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    1662:	f3 0f 1e fa          	endbr64
    1666:	55                   	push   %rbp
    1667:	48 89 e5             	mov    %rsp,%rbp
    166a:	48 83 ec 20          	sub    $0x20,%rsp
    166e:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1671:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1675:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    167c:	eb 35                	jmp    16b3 <print_x64+0x51>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    167e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1682:	48 c1 e8 3c          	shr    $0x3c,%rax
    1686:	48 ba 10 20 00 00 00 	movabs $0x2010,%rdx
    168d:	00 00 00 
    1690:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1694:	0f be d0             	movsbl %al,%edx
    1697:	8b 45 ec             	mov    -0x14(%rbp),%eax
    169a:	89 d6                	mov    %edx,%esi
    169c:	89 c7                	mov    %eax,%edi
    169e:	48 b8 2e 16 00 00 00 	movabs $0x162e,%rax
    16a5:	00 00 00 
    16a8:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    16aa:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    16ae:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    16b3:	8b 45 fc             	mov    -0x4(%rbp),%eax
    16b6:	83 f8 0f             	cmp    $0xf,%eax
    16b9:	76 c3                	jbe    167e <print_x64+0x1c>
}
    16bb:	90                   	nop
    16bc:	90                   	nop
    16bd:	c9                   	leave
    16be:	c3                   	ret

00000000000016bf <print_x32>:

  static void
print_x32(int fd, uint x)
{
    16bf:	f3 0f 1e fa          	endbr64
    16c3:	55                   	push   %rbp
    16c4:	48 89 e5             	mov    %rsp,%rbp
    16c7:	48 83 ec 20          	sub    $0x20,%rsp
    16cb:	89 7d ec             	mov    %edi,-0x14(%rbp)
    16ce:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    16d1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    16d8:	eb 36                	jmp    1710 <print_x32+0x51>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    16da:	8b 45 e8             	mov    -0x18(%rbp),%eax
    16dd:	c1 e8 1c             	shr    $0x1c,%eax
    16e0:	89 c2                	mov    %eax,%edx
    16e2:	48 b8 10 20 00 00 00 	movabs $0x2010,%rax
    16e9:	00 00 00 
    16ec:	89 d2                	mov    %edx,%edx
    16ee:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    16f2:	0f be d0             	movsbl %al,%edx
    16f5:	8b 45 ec             	mov    -0x14(%rbp),%eax
    16f8:	89 d6                	mov    %edx,%esi
    16fa:	89 c7                	mov    %eax,%edi
    16fc:	48 b8 2e 16 00 00 00 	movabs $0x162e,%rax
    1703:	00 00 00 
    1706:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1708:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    170c:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    1710:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1713:	83 f8 07             	cmp    $0x7,%eax
    1716:	76 c2                	jbe    16da <print_x32+0x1b>
}
    1718:	90                   	nop
    1719:	90                   	nop
    171a:	c9                   	leave
    171b:	c3                   	ret

000000000000171c <print_d>:

  static void
print_d(int fd, int v)
{
    171c:	f3 0f 1e fa          	endbr64
    1720:	55                   	push   %rbp
    1721:	48 89 e5             	mov    %rsp,%rbp
    1724:	48 83 ec 30          	sub    $0x30,%rsp
    1728:	89 7d dc             	mov    %edi,-0x24(%rbp)
    172b:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    172e:	8b 45 d8             	mov    -0x28(%rbp),%eax
    1731:	48 98                	cltq
    1733:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    1737:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    173b:	79 04                	jns    1741 <print_d+0x25>
    x = -x;
    173d:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    1741:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    1748:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    174c:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1753:	66 66 66 
    1756:	48 89 c8             	mov    %rcx,%rax
    1759:	48 f7 ea             	imul   %rdx
    175c:	48 c1 fa 02          	sar    $0x2,%rdx
    1760:	48 89 c8             	mov    %rcx,%rax
    1763:	48 c1 f8 3f          	sar    $0x3f,%rax
    1767:	48 29 c2             	sub    %rax,%rdx
    176a:	48 89 d0             	mov    %rdx,%rax
    176d:	48 c1 e0 02          	shl    $0x2,%rax
    1771:	48 01 d0             	add    %rdx,%rax
    1774:	48 01 c0             	add    %rax,%rax
    1777:	48 29 c1             	sub    %rax,%rcx
    177a:	48 89 ca             	mov    %rcx,%rdx
    177d:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1780:	8d 48 01             	lea    0x1(%rax),%ecx
    1783:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    1786:	48 b9 10 20 00 00 00 	movabs $0x2010,%rcx
    178d:	00 00 00 
    1790:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    1794:	48 98                	cltq
    1796:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    179a:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    179e:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    17a5:	66 66 66 
    17a8:	48 89 c8             	mov    %rcx,%rax
    17ab:	48 f7 ea             	imul   %rdx
    17ae:	48 89 d0             	mov    %rdx,%rax
    17b1:	48 c1 f8 02          	sar    $0x2,%rax
    17b5:	48 c1 f9 3f          	sar    $0x3f,%rcx
    17b9:	48 89 ca             	mov    %rcx,%rdx
    17bc:	48 29 d0             	sub    %rdx,%rax
    17bf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    17c3:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    17c8:	0f 85 7a ff ff ff    	jne    1748 <print_d+0x2c>

  if (v < 0)
    17ce:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    17d2:	79 32                	jns    1806 <print_d+0xea>
    buf[i++] = '-';
    17d4:	8b 45 f4             	mov    -0xc(%rbp),%eax
    17d7:	8d 50 01             	lea    0x1(%rax),%edx
    17da:	89 55 f4             	mov    %edx,-0xc(%rbp)
    17dd:	48 98                	cltq
    17df:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    17e4:	eb 20                	jmp    1806 <print_d+0xea>
    putc(fd, buf[i]);
    17e6:	8b 45 f4             	mov    -0xc(%rbp),%eax
    17e9:	48 98                	cltq
    17eb:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    17f0:	0f be d0             	movsbl %al,%edx
    17f3:	8b 45 dc             	mov    -0x24(%rbp),%eax
    17f6:	89 d6                	mov    %edx,%esi
    17f8:	89 c7                	mov    %eax,%edi
    17fa:	48 b8 2e 16 00 00 00 	movabs $0x162e,%rax
    1801:	00 00 00 
    1804:	ff d0                	call   *%rax
  while (--i >= 0)
    1806:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    180a:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    180e:	79 d6                	jns    17e6 <print_d+0xca>
}
    1810:	90                   	nop
    1811:	90                   	nop
    1812:	c9                   	leave
    1813:	c3                   	ret

0000000000001814 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    1814:	f3 0f 1e fa          	endbr64
    1818:	55                   	push   %rbp
    1819:	48 89 e5             	mov    %rsp,%rbp
    181c:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    1823:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    1829:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    1830:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    1837:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    183e:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    1845:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    184c:	84 c0                	test   %al,%al
    184e:	74 20                	je     1870 <printf+0x5c>
    1850:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    1854:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    1858:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    185c:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    1860:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    1864:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    1868:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    186c:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    1870:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    1877:	00 00 00 
    187a:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    1881:	00 00 00 
    1884:	48 8d 45 10          	lea    0x10(%rbp),%rax
    1888:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    188f:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    1896:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    189d:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    18a4:	00 00 00 
    18a7:	e9 41 03 00 00       	jmp    1bed <printf+0x3d9>
    if (c != '%') {
    18ac:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    18b3:	74 24                	je     18d9 <printf+0xc5>
      putc(fd, c);
    18b5:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    18bb:	0f be d0             	movsbl %al,%edx
    18be:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    18c4:	89 d6                	mov    %edx,%esi
    18c6:	89 c7                	mov    %eax,%edi
    18c8:	48 b8 2e 16 00 00 00 	movabs $0x162e,%rax
    18cf:	00 00 00 
    18d2:	ff d0                	call   *%rax
      continue;
    18d4:	e9 0d 03 00 00       	jmp    1be6 <printf+0x3d2>
    }
    c = fmt[++i] & 0xff;
    18d9:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    18e0:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    18e6:	48 63 d0             	movslq %eax,%rdx
    18e9:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    18f0:	48 01 d0             	add    %rdx,%rax
    18f3:	0f b6 00             	movzbl (%rax),%eax
    18f6:	0f be c0             	movsbl %al,%eax
    18f9:	25 ff 00 00 00       	and    $0xff,%eax
    18fe:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    1904:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    190b:	0f 84 0f 03 00 00    	je     1c20 <printf+0x40c>
      break;
    switch(c) {
    1911:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1918:	0f 84 74 02 00 00    	je     1b92 <printf+0x37e>
    191e:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1925:	0f 8c 82 02 00 00    	jl     1bad <printf+0x399>
    192b:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    1932:	0f 8f 75 02 00 00    	jg     1bad <printf+0x399>
    1938:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    193f:	0f 8c 68 02 00 00    	jl     1bad <printf+0x399>
    1945:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    194b:	83 e8 63             	sub    $0x63,%eax
    194e:	83 f8 15             	cmp    $0x15,%eax
    1951:	0f 87 56 02 00 00    	ja     1bad <printf+0x399>
    1957:	89 c0                	mov    %eax,%eax
    1959:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1960:	00 
    1961:	48 b8 60 1f 00 00 00 	movabs $0x1f60,%rax
    1968:	00 00 00 
    196b:	48 01 d0             	add    %rdx,%rax
    196e:	48 8b 00             	mov    (%rax),%rax
    1971:	3e ff e0             	notrack jmp *%rax
    case 'c':
      putc(fd, va_arg(ap, int));
    1974:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    197a:	83 f8 2f             	cmp    $0x2f,%eax
    197d:	77 23                	ja     19a2 <printf+0x18e>
    197f:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1986:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    198c:	89 d2                	mov    %edx,%edx
    198e:	48 01 d0             	add    %rdx,%rax
    1991:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1997:	83 c2 08             	add    $0x8,%edx
    199a:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    19a0:	eb 12                	jmp    19b4 <printf+0x1a0>
    19a2:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    19a9:	48 8d 50 08          	lea    0x8(%rax),%rdx
    19ad:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    19b4:	8b 00                	mov    (%rax),%eax
    19b6:	0f be d0             	movsbl %al,%edx
    19b9:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    19bf:	89 d6                	mov    %edx,%esi
    19c1:	89 c7                	mov    %eax,%edi
    19c3:	48 b8 2e 16 00 00 00 	movabs $0x162e,%rax
    19ca:	00 00 00 
    19cd:	ff d0                	call   *%rax
      break;
    19cf:	e9 12 02 00 00       	jmp    1be6 <printf+0x3d2>
    case 'd':
      print_d(fd, va_arg(ap, int));
    19d4:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    19da:	83 f8 2f             	cmp    $0x2f,%eax
    19dd:	77 23                	ja     1a02 <printf+0x1ee>
    19df:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    19e6:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19ec:	89 d2                	mov    %edx,%edx
    19ee:	48 01 d0             	add    %rdx,%rax
    19f1:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19f7:	83 c2 08             	add    $0x8,%edx
    19fa:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1a00:	eb 12                	jmp    1a14 <printf+0x200>
    1a02:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a09:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a0d:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a14:	8b 10                	mov    (%rax),%edx
    1a16:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a1c:	89 d6                	mov    %edx,%esi
    1a1e:	89 c7                	mov    %eax,%edi
    1a20:	48 b8 1c 17 00 00 00 	movabs $0x171c,%rax
    1a27:	00 00 00 
    1a2a:	ff d0                	call   *%rax
      break;
    1a2c:	e9 b5 01 00 00       	jmp    1be6 <printf+0x3d2>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    1a31:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1a37:	83 f8 2f             	cmp    $0x2f,%eax
    1a3a:	77 23                	ja     1a5f <printf+0x24b>
    1a3c:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1a43:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a49:	89 d2                	mov    %edx,%edx
    1a4b:	48 01 d0             	add    %rdx,%rax
    1a4e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a54:	83 c2 08             	add    $0x8,%edx
    1a57:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1a5d:	eb 12                	jmp    1a71 <printf+0x25d>
    1a5f:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a66:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a6a:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a71:	8b 10                	mov    (%rax),%edx
    1a73:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a79:	89 d6                	mov    %edx,%esi
    1a7b:	89 c7                	mov    %eax,%edi
    1a7d:	48 b8 bf 16 00 00 00 	movabs $0x16bf,%rax
    1a84:	00 00 00 
    1a87:	ff d0                	call   *%rax
      break;
    1a89:	e9 58 01 00 00       	jmp    1be6 <printf+0x3d2>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    1a8e:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1a94:	83 f8 2f             	cmp    $0x2f,%eax
    1a97:	77 23                	ja     1abc <printf+0x2a8>
    1a99:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1aa0:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1aa6:	89 d2                	mov    %edx,%edx
    1aa8:	48 01 d0             	add    %rdx,%rax
    1aab:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1ab1:	83 c2 08             	add    $0x8,%edx
    1ab4:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1aba:	eb 12                	jmp    1ace <printf+0x2ba>
    1abc:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1ac3:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1ac7:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1ace:	48 8b 10             	mov    (%rax),%rdx
    1ad1:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1ad7:	48 89 d6             	mov    %rdx,%rsi
    1ada:	89 c7                	mov    %eax,%edi
    1adc:	48 b8 62 16 00 00 00 	movabs $0x1662,%rax
    1ae3:	00 00 00 
    1ae6:	ff d0                	call   *%rax
      break;
    1ae8:	e9 f9 00 00 00       	jmp    1be6 <printf+0x3d2>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    1aed:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1af3:	83 f8 2f             	cmp    $0x2f,%eax
    1af6:	77 23                	ja     1b1b <printf+0x307>
    1af8:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1aff:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b05:	89 d2                	mov    %edx,%edx
    1b07:	48 01 d0             	add    %rdx,%rax
    1b0a:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b10:	83 c2 08             	add    $0x8,%edx
    1b13:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1b19:	eb 12                	jmp    1b2d <printf+0x319>
    1b1b:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1b22:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1b26:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1b2d:	48 8b 00             	mov    (%rax),%rax
    1b30:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    1b37:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1b3e:	00 
    1b3f:	75 41                	jne    1b82 <printf+0x36e>
        s = "(null)";
    1b41:	48 b8 58 1f 00 00 00 	movabs $0x1f58,%rax
    1b48:	00 00 00 
    1b4b:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1b52:	eb 2e                	jmp    1b82 <printf+0x36e>
        putc(fd, *(s++));
    1b54:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1b5b:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1b5f:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1b66:	0f b6 00             	movzbl (%rax),%eax
    1b69:	0f be d0             	movsbl %al,%edx
    1b6c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b72:	89 d6                	mov    %edx,%esi
    1b74:	89 c7                	mov    %eax,%edi
    1b76:	48 b8 2e 16 00 00 00 	movabs $0x162e,%rax
    1b7d:	00 00 00 
    1b80:	ff d0                	call   *%rax
      while (*s)
    1b82:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1b89:	0f b6 00             	movzbl (%rax),%eax
    1b8c:	84 c0                	test   %al,%al
    1b8e:	75 c4                	jne    1b54 <printf+0x340>
      break;
    1b90:	eb 54                	jmp    1be6 <printf+0x3d2>
    case '%':
      putc(fd, '%');
    1b92:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b98:	be 25 00 00 00       	mov    $0x25,%esi
    1b9d:	89 c7                	mov    %eax,%edi
    1b9f:	48 b8 2e 16 00 00 00 	movabs $0x162e,%rax
    1ba6:	00 00 00 
    1ba9:	ff d0                	call   *%rax
      break;
    1bab:	eb 39                	jmp    1be6 <printf+0x3d2>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1bad:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1bb3:	be 25 00 00 00       	mov    $0x25,%esi
    1bb8:	89 c7                	mov    %eax,%edi
    1bba:	48 b8 2e 16 00 00 00 	movabs $0x162e,%rax
    1bc1:	00 00 00 
    1bc4:	ff d0                	call   *%rax
      putc(fd, c);
    1bc6:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1bcc:	0f be d0             	movsbl %al,%edx
    1bcf:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1bd5:	89 d6                	mov    %edx,%esi
    1bd7:	89 c7                	mov    %eax,%edi
    1bd9:	48 b8 2e 16 00 00 00 	movabs $0x162e,%rax
    1be0:	00 00 00 
    1be3:	ff d0                	call   *%rax
      break;
    1be5:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1be6:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1bed:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1bf3:	48 63 d0             	movslq %eax,%rdx
    1bf6:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1bfd:	48 01 d0             	add    %rdx,%rax
    1c00:	0f b6 00             	movzbl (%rax),%eax
    1c03:	0f be c0             	movsbl %al,%eax
    1c06:	25 ff 00 00 00       	and    $0xff,%eax
    1c0b:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1c11:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1c18:	0f 85 8e fc ff ff    	jne    18ac <printf+0x98>
    }
  }
}
    1c1e:	eb 01                	jmp    1c21 <printf+0x40d>
      break;
    1c20:	90                   	nop
}
    1c21:	90                   	nop
    1c22:	c9                   	leave
    1c23:	c3                   	ret

0000000000001c24 <free>:
    1c24:	55                   	push   %rbp
    1c25:	48 89 e5             	mov    %rsp,%rbp
    1c28:	48 83 ec 18          	sub    $0x18,%rsp
    1c2c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1c30:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1c34:	48 83 e8 10          	sub    $0x10,%rax
    1c38:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1c3c:	48 b8 50 22 00 00 00 	movabs $0x2250,%rax
    1c43:	00 00 00 
    1c46:	48 8b 00             	mov    (%rax),%rax
    1c49:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1c4d:	eb 2f                	jmp    1c7e <free+0x5a>
    1c4f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c53:	48 8b 00             	mov    (%rax),%rax
    1c56:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1c5a:	72 17                	jb     1c73 <free+0x4f>
    1c5c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c60:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1c64:	72 2f                	jb     1c95 <free+0x71>
    1c66:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c6a:	48 8b 00             	mov    (%rax),%rax
    1c6d:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1c71:	72 22                	jb     1c95 <free+0x71>
    1c73:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c77:	48 8b 00             	mov    (%rax),%rax
    1c7a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1c7e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c82:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1c86:	73 c7                	jae    1c4f <free+0x2b>
    1c88:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c8c:	48 8b 00             	mov    (%rax),%rax
    1c8f:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1c93:	73 ba                	jae    1c4f <free+0x2b>
    1c95:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c99:	8b 40 08             	mov    0x8(%rax),%eax
    1c9c:	89 c0                	mov    %eax,%eax
    1c9e:	48 c1 e0 04          	shl    $0x4,%rax
    1ca2:	48 89 c2             	mov    %rax,%rdx
    1ca5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ca9:	48 01 c2             	add    %rax,%rdx
    1cac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cb0:	48 8b 00             	mov    (%rax),%rax
    1cb3:	48 39 c2             	cmp    %rax,%rdx
    1cb6:	75 2d                	jne    1ce5 <free+0xc1>
    1cb8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cbc:	8b 50 08             	mov    0x8(%rax),%edx
    1cbf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cc3:	48 8b 00             	mov    (%rax),%rax
    1cc6:	8b 40 08             	mov    0x8(%rax),%eax
    1cc9:	01 c2                	add    %eax,%edx
    1ccb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ccf:	89 50 08             	mov    %edx,0x8(%rax)
    1cd2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cd6:	48 8b 00             	mov    (%rax),%rax
    1cd9:	48 8b 10             	mov    (%rax),%rdx
    1cdc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ce0:	48 89 10             	mov    %rdx,(%rax)
    1ce3:	eb 0e                	jmp    1cf3 <free+0xcf>
    1ce5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ce9:	48 8b 10             	mov    (%rax),%rdx
    1cec:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cf0:	48 89 10             	mov    %rdx,(%rax)
    1cf3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cf7:	8b 40 08             	mov    0x8(%rax),%eax
    1cfa:	89 c0                	mov    %eax,%eax
    1cfc:	48 c1 e0 04          	shl    $0x4,%rax
    1d00:	48 89 c2             	mov    %rax,%rdx
    1d03:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d07:	48 01 d0             	add    %rdx,%rax
    1d0a:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1d0e:	75 27                	jne    1d37 <free+0x113>
    1d10:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d14:	8b 50 08             	mov    0x8(%rax),%edx
    1d17:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d1b:	8b 40 08             	mov    0x8(%rax),%eax
    1d1e:	01 c2                	add    %eax,%edx
    1d20:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d24:	89 50 08             	mov    %edx,0x8(%rax)
    1d27:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d2b:	48 8b 10             	mov    (%rax),%rdx
    1d2e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d32:	48 89 10             	mov    %rdx,(%rax)
    1d35:	eb 0b                	jmp    1d42 <free+0x11e>
    1d37:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d3b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1d3f:	48 89 10             	mov    %rdx,(%rax)
    1d42:	48 ba 50 22 00 00 00 	movabs $0x2250,%rdx
    1d49:	00 00 00 
    1d4c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d50:	48 89 02             	mov    %rax,(%rdx)
    1d53:	90                   	nop
    1d54:	c9                   	leave
    1d55:	c3                   	ret

0000000000001d56 <morecore>:
    1d56:	55                   	push   %rbp
    1d57:	48 89 e5             	mov    %rsp,%rbp
    1d5a:	48 83 ec 20          	sub    $0x20,%rsp
    1d5e:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1d61:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1d68:	77 07                	ja     1d71 <morecore+0x1b>
    1d6a:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
    1d71:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1d74:	48 c1 e0 04          	shl    $0x4,%rax
    1d78:	48 89 c7             	mov    %rax,%rdi
    1d7b:	48 b8 ed 15 00 00 00 	movabs $0x15ed,%rax
    1d82:	00 00 00 
    1d85:	ff d0                	call   *%rax
    1d87:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1d8b:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1d90:	75 07                	jne    1d99 <morecore+0x43>
    1d92:	b8 00 00 00 00       	mov    $0x0,%eax
    1d97:	eb 36                	jmp    1dcf <morecore+0x79>
    1d99:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d9d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1da1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1da5:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1da8:	89 50 08             	mov    %edx,0x8(%rax)
    1dab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1daf:	48 83 c0 10          	add    $0x10,%rax
    1db3:	48 89 c7             	mov    %rax,%rdi
    1db6:	48 b8 24 1c 00 00 00 	movabs $0x1c24,%rax
    1dbd:	00 00 00 
    1dc0:	ff d0                	call   *%rax
    1dc2:	48 b8 50 22 00 00 00 	movabs $0x2250,%rax
    1dc9:	00 00 00 
    1dcc:	48 8b 00             	mov    (%rax),%rax
    1dcf:	c9                   	leave
    1dd0:	c3                   	ret

0000000000001dd1 <malloc>:
    1dd1:	55                   	push   %rbp
    1dd2:	48 89 e5             	mov    %rsp,%rbp
    1dd5:	48 83 ec 30          	sub    $0x30,%rsp
    1dd9:	89 7d dc             	mov    %edi,-0x24(%rbp)
    1ddc:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1ddf:	48 83 c0 0f          	add    $0xf,%rax
    1de3:	48 c1 e8 04          	shr    $0x4,%rax
    1de7:	83 c0 01             	add    $0x1,%eax
    1dea:	89 45 ec             	mov    %eax,-0x14(%rbp)
    1ded:	48 b8 50 22 00 00 00 	movabs $0x2250,%rax
    1df4:	00 00 00 
    1df7:	48 8b 00             	mov    (%rax),%rax
    1dfa:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1dfe:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1e03:	75 4a                	jne    1e4f <malloc+0x7e>
    1e05:	48 b8 40 22 00 00 00 	movabs $0x2240,%rax
    1e0c:	00 00 00 
    1e0f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1e13:	48 ba 50 22 00 00 00 	movabs $0x2250,%rdx
    1e1a:	00 00 00 
    1e1d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e21:	48 89 02             	mov    %rax,(%rdx)
    1e24:	48 b8 50 22 00 00 00 	movabs $0x2250,%rax
    1e2b:	00 00 00 
    1e2e:	48 8b 00             	mov    (%rax),%rax
    1e31:	48 ba 40 22 00 00 00 	movabs $0x2240,%rdx
    1e38:	00 00 00 
    1e3b:	48 89 02             	mov    %rax,(%rdx)
    1e3e:	48 b8 40 22 00 00 00 	movabs $0x2240,%rax
    1e45:	00 00 00 
    1e48:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
    1e4f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e53:	48 8b 00             	mov    (%rax),%rax
    1e56:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1e5a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e5e:	8b 40 08             	mov    0x8(%rax),%eax
    1e61:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1e64:	72 65                	jb     1ecb <malloc+0xfa>
    1e66:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e6a:	8b 40 08             	mov    0x8(%rax),%eax
    1e6d:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1e70:	75 10                	jne    1e82 <malloc+0xb1>
    1e72:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e76:	48 8b 10             	mov    (%rax),%rdx
    1e79:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e7d:	48 89 10             	mov    %rdx,(%rax)
    1e80:	eb 2e                	jmp    1eb0 <malloc+0xdf>
    1e82:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e86:	8b 40 08             	mov    0x8(%rax),%eax
    1e89:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1e8c:	89 c2                	mov    %eax,%edx
    1e8e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e92:	89 50 08             	mov    %edx,0x8(%rax)
    1e95:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e99:	8b 40 08             	mov    0x8(%rax),%eax
    1e9c:	89 c0                	mov    %eax,%eax
    1e9e:	48 c1 e0 04          	shl    $0x4,%rax
    1ea2:	48 01 45 f8          	add    %rax,-0x8(%rbp)
    1ea6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1eaa:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1ead:	89 50 08             	mov    %edx,0x8(%rax)
    1eb0:	48 ba 50 22 00 00 00 	movabs $0x2250,%rdx
    1eb7:	00 00 00 
    1eba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ebe:	48 89 02             	mov    %rax,(%rdx)
    1ec1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ec5:	48 83 c0 10          	add    $0x10,%rax
    1ec9:	eb 4e                	jmp    1f19 <malloc+0x148>
    1ecb:	48 b8 50 22 00 00 00 	movabs $0x2250,%rax
    1ed2:	00 00 00 
    1ed5:	48 8b 00             	mov    (%rax),%rax
    1ed8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1edc:	75 23                	jne    1f01 <malloc+0x130>
    1ede:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1ee1:	89 c7                	mov    %eax,%edi
    1ee3:	48 b8 56 1d 00 00 00 	movabs $0x1d56,%rax
    1eea:	00 00 00 
    1eed:	ff d0                	call   *%rax
    1eef:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1ef3:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1ef8:	75 07                	jne    1f01 <malloc+0x130>
    1efa:	b8 00 00 00 00       	mov    $0x0,%eax
    1eff:	eb 18                	jmp    1f19 <malloc+0x148>
    1f01:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f05:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1f09:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f0d:	48 8b 00             	mov    (%rax),%rax
    1f10:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1f14:	e9 41 ff ff ff       	jmp    1e5a <malloc+0x89>
    1f19:	c9                   	leave
    1f1a:	c3                   	ret
