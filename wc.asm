
_wc:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
    1000:	f3 0f 1e fa          	endbr64
    1004:	55                   	push   %rbp
    1005:	48 89 e5             	mov    %rsp,%rbp
    1008:	48 83 ec 30          	sub    $0x30,%rsp
    100c:	89 7d dc             	mov    %edi,-0x24(%rbp)
    100f:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
    1013:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
    101a:	8b 45 f0             	mov    -0x10(%rbp),%eax
    101d:	89 45 f4             	mov    %eax,-0xc(%rbp)
    1020:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1023:	89 45 f8             	mov    %eax,-0x8(%rbp)
  inword = 0;
    1026:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
    102d:	e9 84 00 00 00       	jmp    10b6 <wc+0xb6>
    for(i=0; i<n; i++){
    1032:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1039:	eb 73                	jmp    10ae <wc+0xae>
      c++;
    103b:	83 45 f0 01          	addl   $0x1,-0x10(%rbp)
      if(buf[i] == '\n')
    103f:	48 ba 00 21 00 00 00 	movabs $0x2100,%rdx
    1046:	00 00 00 
    1049:	8b 45 fc             	mov    -0x4(%rbp),%eax
    104c:	48 98                	cltq
    104e:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1052:	3c 0a                	cmp    $0xa,%al
    1054:	75 04                	jne    105a <wc+0x5a>
        l++;
    1056:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
      if(strchr(" \r\t\n\v", buf[i]))
    105a:	48 ba 00 21 00 00 00 	movabs $0x2100,%rdx
    1061:	00 00 00 
    1064:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1067:	48 98                	cltq
    1069:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    106d:	0f be c0             	movsbl %al,%eax
    1070:	89 c6                	mov    %eax,%esi
    1072:	48 b8 e8 1f 00 00 00 	movabs $0x1fe8,%rax
    1079:	00 00 00 
    107c:	48 89 c7             	mov    %rax,%rdi
    107f:	48 b8 c2 13 00 00 00 	movabs $0x13c2,%rax
    1086:	00 00 00 
    1089:	ff d0                	call   *%rax
    108b:	48 85 c0             	test   %rax,%rax
    108e:	74 09                	je     1099 <wc+0x99>
        inword = 0;
    1090:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    1097:	eb 11                	jmp    10aa <wc+0xaa>
      else if(!inword){
    1099:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
    109d:	75 0b                	jne    10aa <wc+0xaa>
        w++;
    109f:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
        inword = 1;
    10a3:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%rbp)
    for(i=0; i<n; i++){
    10aa:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    10ae:	8b 45 fc             	mov    -0x4(%rbp),%eax
    10b1:	3b 45 e8             	cmp    -0x18(%rbp),%eax
    10b4:	7c 85                	jl     103b <wc+0x3b>
  while((n = read(fd, buf, sizeof(buf))) > 0){
    10b6:	8b 45 dc             	mov    -0x24(%rbp),%eax
    10b9:	ba 00 02 00 00       	mov    $0x200,%edx
    10be:	48 b9 00 21 00 00 00 	movabs $0x2100,%rcx
    10c5:	00 00 00 
    10c8:	48 89 ce             	mov    %rcx,%rsi
    10cb:	89 c7                	mov    %eax,%edi
    10cd:	48 b8 e7 15 00 00 00 	movabs $0x15e7,%rax
    10d4:	00 00 00 
    10d7:	ff d0                	call   *%rax
    10d9:	89 45 e8             	mov    %eax,-0x18(%rbp)
    10dc:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
    10e0:	0f 8f 4c ff ff ff    	jg     1032 <wc+0x32>
      }
    }
  }
  if(n < 0){
    10e6:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
    10ea:	79 2f                	jns    111b <wc+0x11b>
    printf(1, "wc: read error\n");
    10ec:	48 b8 ee 1f 00 00 00 	movabs $0x1fee,%rax
    10f3:	00 00 00 
    10f6:	48 89 c6             	mov    %rax,%rsi
    10f9:	bf 01 00 00 00       	mov    $0x1,%edi
    10fe:	b8 00 00 00 00       	mov    $0x0,%eax
    1103:	48 ba d1 18 00 00 00 	movabs $0x18d1,%rdx
    110a:	00 00 00 
    110d:	ff d2                	call   *%rdx
    exit();
    110f:	48 b8 c0 15 00 00 00 	movabs $0x15c0,%rax
    1116:	00 00 00 
    1119:	ff d0                	call   *%rax
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
    111b:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
    111f:	8b 4d f0             	mov    -0x10(%rbp),%ecx
    1122:	8b 55 f4             	mov    -0xc(%rbp),%edx
    1125:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1128:	49 89 f1             	mov    %rsi,%r9
    112b:	41 89 c8             	mov    %ecx,%r8d
    112e:	89 d1                	mov    %edx,%ecx
    1130:	89 c2                	mov    %eax,%edx
    1132:	48 b8 fe 1f 00 00 00 	movabs $0x1ffe,%rax
    1139:	00 00 00 
    113c:	48 89 c6             	mov    %rax,%rsi
    113f:	bf 01 00 00 00       	mov    $0x1,%edi
    1144:	b8 00 00 00 00       	mov    $0x0,%eax
    1149:	49 ba d1 18 00 00 00 	movabs $0x18d1,%r10
    1150:	00 00 00 
    1153:	41 ff d2             	call   *%r10
}
    1156:	90                   	nop
    1157:	c9                   	leave
    1158:	c3                   	ret

0000000000001159 <main>:

int
main(int argc, char *argv[])
{
    1159:	f3 0f 1e fa          	endbr64
    115d:	55                   	push   %rbp
    115e:	48 89 e5             	mov    %rsp,%rbp
    1161:	48 83 ec 20          	sub    $0x20,%rsp
    1165:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1168:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd, i;

  if(argc <= 1){
    116c:	83 7d ec 01          	cmpl   $0x1,-0x14(%rbp)
    1170:	7f 2a                	jg     119c <main+0x43>
    wc(0, "");
    1172:	48 b8 0b 20 00 00 00 	movabs $0x200b,%rax
    1179:	00 00 00 
    117c:	48 89 c6             	mov    %rax,%rsi
    117f:	bf 00 00 00 00       	mov    $0x0,%edi
    1184:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    118b:	00 00 00 
    118e:	ff d0                	call   *%rax
    exit();
    1190:	48 b8 c0 15 00 00 00 	movabs $0x15c0,%rax
    1197:	00 00 00 
    119a:	ff d0                	call   *%rax
  }

  for(i = 1; i < argc; i++){
    119c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
    11a3:	e9 bd 00 00 00       	jmp    1265 <main+0x10c>
    if((fd = open(argv[i], 0)) < 0){
    11a8:	8b 45 fc             	mov    -0x4(%rbp),%eax
    11ab:	48 98                	cltq
    11ad:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    11b4:	00 
    11b5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    11b9:	48 01 d0             	add    %rdx,%rax
    11bc:	48 8b 00             	mov    (%rax),%rax
    11bf:	be 00 00 00 00       	mov    $0x0,%esi
    11c4:	48 89 c7             	mov    %rax,%rdi
    11c7:	48 b8 28 16 00 00 00 	movabs $0x1628,%rax
    11ce:	00 00 00 
    11d1:	ff d0                	call   *%rax
    11d3:	89 45 f8             	mov    %eax,-0x8(%rbp)
    11d6:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    11da:	79 49                	jns    1225 <main+0xcc>
      printf(1, "wc: cannot open %s\n", argv[i]);
    11dc:	8b 45 fc             	mov    -0x4(%rbp),%eax
    11df:	48 98                	cltq
    11e1:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    11e8:	00 
    11e9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    11ed:	48 01 d0             	add    %rdx,%rax
    11f0:	48 8b 00             	mov    (%rax),%rax
    11f3:	48 89 c2             	mov    %rax,%rdx
    11f6:	48 b8 0c 20 00 00 00 	movabs $0x200c,%rax
    11fd:	00 00 00 
    1200:	48 89 c6             	mov    %rax,%rsi
    1203:	bf 01 00 00 00       	mov    $0x1,%edi
    1208:	b8 00 00 00 00       	mov    $0x0,%eax
    120d:	48 b9 d1 18 00 00 00 	movabs $0x18d1,%rcx
    1214:	00 00 00 
    1217:	ff d1                	call   *%rcx
      exit();
    1219:	48 b8 c0 15 00 00 00 	movabs $0x15c0,%rax
    1220:	00 00 00 
    1223:	ff d0                	call   *%rax
    }
    wc(fd, argv[i]);
    1225:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1228:	48 98                	cltq
    122a:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1231:	00 
    1232:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1236:	48 01 d0             	add    %rdx,%rax
    1239:	48 8b 10             	mov    (%rax),%rdx
    123c:	8b 45 f8             	mov    -0x8(%rbp),%eax
    123f:	48 89 d6             	mov    %rdx,%rsi
    1242:	89 c7                	mov    %eax,%edi
    1244:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    124b:	00 00 00 
    124e:	ff d0                	call   *%rax
    close(fd);
    1250:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1253:	89 c7                	mov    %eax,%edi
    1255:	48 b8 01 16 00 00 00 	movabs $0x1601,%rax
    125c:	00 00 00 
    125f:	ff d0                	call   *%rax
  for(i = 1; i < argc; i++){
    1261:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1265:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1268:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    126b:	0f 8c 37 ff ff ff    	jl     11a8 <main+0x4f>
  }
  exit();
    1271:	48 b8 c0 15 00 00 00 	movabs $0x15c0,%rax
    1278:	00 00 00 
    127b:	ff d0                	call   *%rax

000000000000127d <stosb>:
  stosb(dst, c, n);
  return dst;
}

char*
strchr(const char *s, char c)
    127d:	f3 0f 1e fa          	endbr64
    1281:	55                   	push   %rbp
    1282:	48 89 e5             	mov    %rsp,%rbp
    1285:	48 83 ec 10          	sub    $0x10,%rsp
    1289:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    128d:	89 75 f4             	mov    %esi,-0xc(%rbp)
    1290:	89 55 f0             	mov    %edx,-0x10(%rbp)
{
    1293:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1297:	8b 55 f0             	mov    -0x10(%rbp),%edx
    129a:	8b 45 f4             	mov    -0xc(%rbp),%eax
    129d:	48 89 ce             	mov    %rcx,%rsi
    12a0:	48 89 f7             	mov    %rsi,%rdi
    12a3:	89 d1                	mov    %edx,%ecx
    12a5:	fc                   	cld
    12a6:	f3 aa                	rep stos %al,%es:(%rdi)
    12a8:	89 ca                	mov    %ecx,%edx
    12aa:	48 89 fe             	mov    %rdi,%rsi
    12ad:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    12b1:	89 55 f0             	mov    %edx,-0x10(%rbp)
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
    12b4:	90                   	nop
    12b5:	c9                   	leave
    12b6:	c3                   	ret

00000000000012b7 <strcpy>:
{
    12b7:	f3 0f 1e fa          	endbr64
    12bb:	55                   	push   %rbp
    12bc:	48 89 e5             	mov    %rsp,%rbp
    12bf:	48 83 ec 20          	sub    $0x20,%rsp
    12c3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    12c7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  os = s;
    12cb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12cf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    12d3:	90                   	nop
    12d4:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    12d8:	48 8d 42 01          	lea    0x1(%rdx),%rax
    12dc:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    12e0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12e4:	48 8d 48 01          	lea    0x1(%rax),%rcx
    12e8:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    12ec:	0f b6 12             	movzbl (%rdx),%edx
    12ef:	88 10                	mov    %dl,(%rax)
    12f1:	0f b6 00             	movzbl (%rax),%eax
    12f4:	84 c0                	test   %al,%al
    12f6:	75 dc                	jne    12d4 <strcpy+0x1d>
  return os;
    12f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    12fc:	c9                   	leave
    12fd:	c3                   	ret

00000000000012fe <strcmp>:
{
    12fe:	f3 0f 1e fa          	endbr64
    1302:	55                   	push   %rbp
    1303:	48 89 e5             	mov    %rsp,%rbp
    1306:	48 83 ec 10          	sub    $0x10,%rsp
    130a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    130e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    1312:	eb 0a                	jmp    131e <strcmp+0x20>
    p++, q++;
    1314:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1319:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    131e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1322:	0f b6 00             	movzbl (%rax),%eax
    1325:	84 c0                	test   %al,%al
    1327:	74 12                	je     133b <strcmp+0x3d>
    1329:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    132d:	0f b6 10             	movzbl (%rax),%edx
    1330:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1334:	0f b6 00             	movzbl (%rax),%eax
    1337:	38 c2                	cmp    %al,%dl
    1339:	74 d9                	je     1314 <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
    133b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    133f:	0f b6 00             	movzbl (%rax),%eax
    1342:	0f b6 d0             	movzbl %al,%edx
    1345:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1349:	0f b6 00             	movzbl (%rax),%eax
    134c:	0f b6 c0             	movzbl %al,%eax
    134f:	29 c2                	sub    %eax,%edx
    1351:	89 d0                	mov    %edx,%eax
}
    1353:	c9                   	leave
    1354:	c3                   	ret

0000000000001355 <strlen>:
{
    1355:	f3 0f 1e fa          	endbr64
    1359:	55                   	push   %rbp
    135a:	48 89 e5             	mov    %rsp,%rbp
    135d:	48 83 ec 18          	sub    $0x18,%rsp
    1361:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  for(n = 0; s[n]; n++)
    1365:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    136c:	eb 04                	jmp    1372 <strlen+0x1d>
    136e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1372:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1375:	48 63 d0             	movslq %eax,%rdx
    1378:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    137c:	48 01 d0             	add    %rdx,%rax
    137f:	0f b6 00             	movzbl (%rax),%eax
    1382:	84 c0                	test   %al,%al
    1384:	75 e8                	jne    136e <strlen+0x19>
  return n;
    1386:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    1389:	c9                   	leave
    138a:	c3                   	ret

000000000000138b <memset>:
{
    138b:	f3 0f 1e fa          	endbr64
    138f:	55                   	push   %rbp
    1390:	48 89 e5             	mov    %rsp,%rbp
    1393:	48 83 ec 10          	sub    $0x10,%rsp
    1397:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    139b:	89 75 f4             	mov    %esi,-0xc(%rbp)
    139e:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    13a1:	8b 55 f0             	mov    -0x10(%rbp),%edx
    13a4:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    13a7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13ab:	89 ce                	mov    %ecx,%esi
    13ad:	48 89 c7             	mov    %rax,%rdi
    13b0:	48 b8 7d 12 00 00 00 	movabs $0x127d,%rax
    13b7:	00 00 00 
    13ba:	ff d0                	call   *%rax
  return dst;
    13bc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    13c0:	c9                   	leave
    13c1:	c3                   	ret

00000000000013c2 <strchr>:
{
    13c2:	f3 0f 1e fa          	endbr64
    13c6:	55                   	push   %rbp
    13c7:	48 89 e5             	mov    %rsp,%rbp
    13ca:	48 83 ec 10          	sub    $0x10,%rsp
    13ce:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    13d2:	89 f0                	mov    %esi,%eax
    13d4:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    13d7:	eb 17                	jmp    13f0 <strchr+0x2e>
    if(*s == c)
    13d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13dd:	0f b6 00             	movzbl (%rax),%eax
    13e0:	38 45 f4             	cmp    %al,-0xc(%rbp)
    13e3:	75 06                	jne    13eb <strchr+0x29>
      return (char*)s;
    13e5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13e9:	eb 15                	jmp    1400 <strchr+0x3e>
  for(; *s; s++)
    13eb:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    13f0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13f4:	0f b6 00             	movzbl (%rax),%eax
    13f7:	84 c0                	test   %al,%al
    13f9:	75 de                	jne    13d9 <strchr+0x17>
  return 0;
    13fb:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1400:	c9                   	leave
    1401:	c3                   	ret

0000000000001402 <gets>:

char*
gets(char *buf, int max)
{
    1402:	f3 0f 1e fa          	endbr64
    1406:	55                   	push   %rbp
    1407:	48 89 e5             	mov    %rsp,%rbp
    140a:	48 83 ec 20          	sub    $0x20,%rsp
    140e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1412:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1415:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    141c:	eb 4f                	jmp    146d <gets+0x6b>
    cc = read(0, &c, 1);
    141e:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    1422:	ba 01 00 00 00       	mov    $0x1,%edx
    1427:	48 89 c6             	mov    %rax,%rsi
    142a:	bf 00 00 00 00       	mov    $0x0,%edi
    142f:	48 b8 e7 15 00 00 00 	movabs $0x15e7,%rax
    1436:	00 00 00 
    1439:	ff d0                	call   *%rax
    143b:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    143e:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1442:	7e 36                	jle    147a <gets+0x78>
      break;
    buf[i++] = c;
    1444:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1447:	8d 50 01             	lea    0x1(%rax),%edx
    144a:	89 55 fc             	mov    %edx,-0x4(%rbp)
    144d:	48 63 d0             	movslq %eax,%rdx
    1450:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1454:	48 01 c2             	add    %rax,%rdx
    1457:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    145b:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    145d:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1461:	3c 0a                	cmp    $0xa,%al
    1463:	74 16                	je     147b <gets+0x79>
    1465:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1469:	3c 0d                	cmp    $0xd,%al
    146b:	74 0e                	je     147b <gets+0x79>
  for(i=0; i+1 < max; ){
    146d:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1470:	83 c0 01             	add    $0x1,%eax
    1473:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    1476:	7f a6                	jg     141e <gets+0x1c>
    1478:	eb 01                	jmp    147b <gets+0x79>
      break;
    147a:	90                   	nop
      break;
  }
  buf[i] = '\0';
    147b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    147e:	48 63 d0             	movslq %eax,%rdx
    1481:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1485:	48 01 d0             	add    %rdx,%rax
    1488:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    148b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    148f:	c9                   	leave
    1490:	c3                   	ret

0000000000001491 <stat>:

int
stat(char *n, struct stat *st)
{
    1491:	f3 0f 1e fa          	endbr64
    1495:	55                   	push   %rbp
    1496:	48 89 e5             	mov    %rsp,%rbp
    1499:	48 83 ec 20          	sub    $0x20,%rsp
    149d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    14a1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    14a5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    14a9:	be 00 00 00 00       	mov    $0x0,%esi
    14ae:	48 89 c7             	mov    %rax,%rdi
    14b1:	48 b8 28 16 00 00 00 	movabs $0x1628,%rax
    14b8:	00 00 00 
    14bb:	ff d0                	call   *%rax
    14bd:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    14c0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    14c4:	79 07                	jns    14cd <stat+0x3c>
    return -1;
    14c6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    14cb:	eb 2f                	jmp    14fc <stat+0x6b>
  r = fstat(fd, st);
    14cd:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    14d1:	8b 45 fc             	mov    -0x4(%rbp),%eax
    14d4:	48 89 d6             	mov    %rdx,%rsi
    14d7:	89 c7                	mov    %eax,%edi
    14d9:	48 b8 4f 16 00 00 00 	movabs $0x164f,%rax
    14e0:	00 00 00 
    14e3:	ff d0                	call   *%rax
    14e5:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    14e8:	8b 45 fc             	mov    -0x4(%rbp),%eax
    14eb:	89 c7                	mov    %eax,%edi
    14ed:	48 b8 01 16 00 00 00 	movabs $0x1601,%rax
    14f4:	00 00 00 
    14f7:	ff d0                	call   *%rax
  return r;
    14f9:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    14fc:	c9                   	leave
    14fd:	c3                   	ret

00000000000014fe <atoi>:

int
atoi(const char *s)
{
    14fe:	f3 0f 1e fa          	endbr64
    1502:	55                   	push   %rbp
    1503:	48 89 e5             	mov    %rsp,%rbp
    1506:	48 83 ec 18          	sub    $0x18,%rsp
    150a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    150e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1515:	eb 28                	jmp    153f <atoi+0x41>
    n = n*10 + *s++ - '0';
    1517:	8b 55 fc             	mov    -0x4(%rbp),%edx
    151a:	89 d0                	mov    %edx,%eax
    151c:	c1 e0 02             	shl    $0x2,%eax
    151f:	01 d0                	add    %edx,%eax
    1521:	01 c0                	add    %eax,%eax
    1523:	89 c1                	mov    %eax,%ecx
    1525:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1529:	48 8d 50 01          	lea    0x1(%rax),%rdx
    152d:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    1531:	0f b6 00             	movzbl (%rax),%eax
    1534:	0f be c0             	movsbl %al,%eax
    1537:	01 c8                	add    %ecx,%eax
    1539:	83 e8 30             	sub    $0x30,%eax
    153c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    153f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1543:	0f b6 00             	movzbl (%rax),%eax
    1546:	3c 2f                	cmp    $0x2f,%al
    1548:	7e 0b                	jle    1555 <atoi+0x57>
    154a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    154e:	0f b6 00             	movzbl (%rax),%eax
    1551:	3c 39                	cmp    $0x39,%al
    1553:	7e c2                	jle    1517 <atoi+0x19>
  return n;
    1555:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    1558:	c9                   	leave
    1559:	c3                   	ret

000000000000155a <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    155a:	f3 0f 1e fa          	endbr64
    155e:	55                   	push   %rbp
    155f:	48 89 e5             	mov    %rsp,%rbp
    1562:	48 83 ec 28          	sub    $0x28,%rsp
    1566:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    156a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    156e:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    1571:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1575:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    1579:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    157d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    1581:	eb 1d                	jmp    15a0 <memmove+0x46>
    *dst++ = *src++;
    1583:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1587:	48 8d 42 01          	lea    0x1(%rdx),%rax
    158b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    158f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1593:	48 8d 48 01          	lea    0x1(%rax),%rcx
    1597:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    159b:	0f b6 12             	movzbl (%rdx),%edx
    159e:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    15a0:	8b 45 dc             	mov    -0x24(%rbp),%eax
    15a3:	8d 50 ff             	lea    -0x1(%rax),%edx
    15a6:	89 55 dc             	mov    %edx,-0x24(%rbp)
    15a9:	85 c0                	test   %eax,%eax
    15ab:	7f d6                	jg     1583 <memmove+0x29>
  return vdst;
    15ad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    15b1:	c9                   	leave
    15b2:	c3                   	ret

00000000000015b3 <fork>:
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    15b3:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    15ba:	49 89 ca             	mov    %rcx,%r10
    15bd:	0f 05                	syscall
    15bf:	c3                   	ret

00000000000015c0 <exit>:
SYSCALL(exit)
    15c0:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    15c7:	49 89 ca             	mov    %rcx,%r10
    15ca:	0f 05                	syscall
    15cc:	c3                   	ret

00000000000015cd <wait>:
SYSCALL(wait)
    15cd:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    15d4:	49 89 ca             	mov    %rcx,%r10
    15d7:	0f 05                	syscall
    15d9:	c3                   	ret

00000000000015da <pipe>:
SYSCALL(pipe)
    15da:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    15e1:	49 89 ca             	mov    %rcx,%r10
    15e4:	0f 05                	syscall
    15e6:	c3                   	ret

00000000000015e7 <read>:
SYSCALL(read)
    15e7:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    15ee:	49 89 ca             	mov    %rcx,%r10
    15f1:	0f 05                	syscall
    15f3:	c3                   	ret

00000000000015f4 <write>:
SYSCALL(write)
    15f4:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    15fb:	49 89 ca             	mov    %rcx,%r10
    15fe:	0f 05                	syscall
    1600:	c3                   	ret

0000000000001601 <close>:
SYSCALL(close)
    1601:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    1608:	49 89 ca             	mov    %rcx,%r10
    160b:	0f 05                	syscall
    160d:	c3                   	ret

000000000000160e <kill>:
SYSCALL(kill)
    160e:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    1615:	49 89 ca             	mov    %rcx,%r10
    1618:	0f 05                	syscall
    161a:	c3                   	ret

000000000000161b <exec>:
SYSCALL(exec)
    161b:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    1622:	49 89 ca             	mov    %rcx,%r10
    1625:	0f 05                	syscall
    1627:	c3                   	ret

0000000000001628 <open>:
SYSCALL(open)
    1628:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    162f:	49 89 ca             	mov    %rcx,%r10
    1632:	0f 05                	syscall
    1634:	c3                   	ret

0000000000001635 <mknod>:
SYSCALL(mknod)
    1635:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    163c:	49 89 ca             	mov    %rcx,%r10
    163f:	0f 05                	syscall
    1641:	c3                   	ret

0000000000001642 <unlink>:
SYSCALL(unlink)
    1642:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    1649:	49 89 ca             	mov    %rcx,%r10
    164c:	0f 05                	syscall
    164e:	c3                   	ret

000000000000164f <fstat>:
SYSCALL(fstat)
    164f:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    1656:	49 89 ca             	mov    %rcx,%r10
    1659:	0f 05                	syscall
    165b:	c3                   	ret

000000000000165c <link>:
SYSCALL(link)
    165c:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    1663:	49 89 ca             	mov    %rcx,%r10
    1666:	0f 05                	syscall
    1668:	c3                   	ret

0000000000001669 <mkdir>:
SYSCALL(mkdir)
    1669:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    1670:	49 89 ca             	mov    %rcx,%r10
    1673:	0f 05                	syscall
    1675:	c3                   	ret

0000000000001676 <chdir>:
SYSCALL(chdir)
    1676:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    167d:	49 89 ca             	mov    %rcx,%r10
    1680:	0f 05                	syscall
    1682:	c3                   	ret

0000000000001683 <dup>:
SYSCALL(dup)
    1683:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    168a:	49 89 ca             	mov    %rcx,%r10
    168d:	0f 05                	syscall
    168f:	c3                   	ret

0000000000001690 <getpid>:
SYSCALL(getpid)
    1690:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    1697:	49 89 ca             	mov    %rcx,%r10
    169a:	0f 05                	syscall
    169c:	c3                   	ret

000000000000169d <sbrk>:
SYSCALL(sbrk)
    169d:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    16a4:	49 89 ca             	mov    %rcx,%r10
    16a7:	0f 05                	syscall
    16a9:	c3                   	ret

00000000000016aa <sleep>:
SYSCALL(sleep)
    16aa:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    16b1:	49 89 ca             	mov    %rcx,%r10
    16b4:	0f 05                	syscall
    16b6:	c3                   	ret

00000000000016b7 <uptime>:
SYSCALL(uptime)
    16b7:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    16be:	49 89 ca             	mov    %rcx,%r10
    16c1:	0f 05                	syscall
    16c3:	c3                   	ret

00000000000016c4 <send>:
SYSCALL(send)
    16c4:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    16cb:	49 89 ca             	mov    %rcx,%r10
    16ce:	0f 05                	syscall
    16d0:	c3                   	ret

00000000000016d1 <recv>:
SYSCALL(recv)
    16d1:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    16d8:	49 89 ca             	mov    %rcx,%r10
    16db:	0f 05                	syscall
    16dd:	c3                   	ret

00000000000016de <register_fsserver>:
SYSCALL(register_fsserver)
    16de:	48 c7 c0 18 00 00 00 	mov    $0x18,%rax
    16e5:	49 89 ca             	mov    %rcx,%r10
    16e8:	0f 05                	syscall
    16ea:	c3                   	ret

00000000000016eb <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    16eb:	f3 0f 1e fa          	endbr64
    16ef:	55                   	push   %rbp
    16f0:	48 89 e5             	mov    %rsp,%rbp
    16f3:	48 83 ec 10          	sub    $0x10,%rsp
    16f7:	89 7d fc             	mov    %edi,-0x4(%rbp)
    16fa:	89 f0                	mov    %esi,%eax
    16fc:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    16ff:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    1703:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1706:	ba 01 00 00 00       	mov    $0x1,%edx
    170b:	48 89 ce             	mov    %rcx,%rsi
    170e:	89 c7                	mov    %eax,%edi
    1710:	48 b8 f4 15 00 00 00 	movabs $0x15f4,%rax
    1717:	00 00 00 
    171a:	ff d0                	call   *%rax
}
    171c:	90                   	nop
    171d:	c9                   	leave
    171e:	c3                   	ret

000000000000171f <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    171f:	f3 0f 1e fa          	endbr64
    1723:	55                   	push   %rbp
    1724:	48 89 e5             	mov    %rsp,%rbp
    1727:	48 83 ec 20          	sub    $0x20,%rsp
    172b:	89 7d ec             	mov    %edi,-0x14(%rbp)
    172e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1732:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1739:	eb 35                	jmp    1770 <print_x64+0x51>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    173b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    173f:	48 c1 e8 3c          	shr    $0x3c,%rax
    1743:	48 ba e0 20 00 00 00 	movabs $0x20e0,%rdx
    174a:	00 00 00 
    174d:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1751:	0f be d0             	movsbl %al,%edx
    1754:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1757:	89 d6                	mov    %edx,%esi
    1759:	89 c7                	mov    %eax,%edi
    175b:	48 b8 eb 16 00 00 00 	movabs $0x16eb,%rax
    1762:	00 00 00 
    1765:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1767:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    176b:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    1770:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1773:	83 f8 0f             	cmp    $0xf,%eax
    1776:	76 c3                	jbe    173b <print_x64+0x1c>
}
    1778:	90                   	nop
    1779:	90                   	nop
    177a:	c9                   	leave
    177b:	c3                   	ret

000000000000177c <print_x32>:

  static void
print_x32(int fd, uint x)
{
    177c:	f3 0f 1e fa          	endbr64
    1780:	55                   	push   %rbp
    1781:	48 89 e5             	mov    %rsp,%rbp
    1784:	48 83 ec 20          	sub    $0x20,%rsp
    1788:	89 7d ec             	mov    %edi,-0x14(%rbp)
    178b:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    178e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1795:	eb 36                	jmp    17cd <print_x32+0x51>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    1797:	8b 45 e8             	mov    -0x18(%rbp),%eax
    179a:	c1 e8 1c             	shr    $0x1c,%eax
    179d:	89 c2                	mov    %eax,%edx
    179f:	48 b8 e0 20 00 00 00 	movabs $0x20e0,%rax
    17a6:	00 00 00 
    17a9:	89 d2                	mov    %edx,%edx
    17ab:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    17af:	0f be d0             	movsbl %al,%edx
    17b2:	8b 45 ec             	mov    -0x14(%rbp),%eax
    17b5:	89 d6                	mov    %edx,%esi
    17b7:	89 c7                	mov    %eax,%edi
    17b9:	48 b8 eb 16 00 00 00 	movabs $0x16eb,%rax
    17c0:	00 00 00 
    17c3:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    17c5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    17c9:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    17cd:	8b 45 fc             	mov    -0x4(%rbp),%eax
    17d0:	83 f8 07             	cmp    $0x7,%eax
    17d3:	76 c2                	jbe    1797 <print_x32+0x1b>
}
    17d5:	90                   	nop
    17d6:	90                   	nop
    17d7:	c9                   	leave
    17d8:	c3                   	ret

00000000000017d9 <print_d>:

  static void
print_d(int fd, int v)
{
    17d9:	f3 0f 1e fa          	endbr64
    17dd:	55                   	push   %rbp
    17de:	48 89 e5             	mov    %rsp,%rbp
    17e1:	48 83 ec 30          	sub    $0x30,%rsp
    17e5:	89 7d dc             	mov    %edi,-0x24(%rbp)
    17e8:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    17eb:	8b 45 d8             	mov    -0x28(%rbp),%eax
    17ee:	48 98                	cltq
    17f0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    17f4:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    17f8:	79 04                	jns    17fe <print_d+0x25>
    x = -x;
    17fa:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    17fe:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    1805:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1809:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1810:	66 66 66 
    1813:	48 89 c8             	mov    %rcx,%rax
    1816:	48 f7 ea             	imul   %rdx
    1819:	48 c1 fa 02          	sar    $0x2,%rdx
    181d:	48 89 c8             	mov    %rcx,%rax
    1820:	48 c1 f8 3f          	sar    $0x3f,%rax
    1824:	48 29 c2             	sub    %rax,%rdx
    1827:	48 89 d0             	mov    %rdx,%rax
    182a:	48 c1 e0 02          	shl    $0x2,%rax
    182e:	48 01 d0             	add    %rdx,%rax
    1831:	48 01 c0             	add    %rax,%rax
    1834:	48 29 c1             	sub    %rax,%rcx
    1837:	48 89 ca             	mov    %rcx,%rdx
    183a:	8b 45 f4             	mov    -0xc(%rbp),%eax
    183d:	8d 48 01             	lea    0x1(%rax),%ecx
    1840:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    1843:	48 b9 e0 20 00 00 00 	movabs $0x20e0,%rcx
    184a:	00 00 00 
    184d:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    1851:	48 98                	cltq
    1853:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    1857:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    185b:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1862:	66 66 66 
    1865:	48 89 c8             	mov    %rcx,%rax
    1868:	48 f7 ea             	imul   %rdx
    186b:	48 89 d0             	mov    %rdx,%rax
    186e:	48 c1 f8 02          	sar    $0x2,%rax
    1872:	48 c1 f9 3f          	sar    $0x3f,%rcx
    1876:	48 89 ca             	mov    %rcx,%rdx
    1879:	48 29 d0             	sub    %rdx,%rax
    187c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    1880:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1885:	0f 85 7a ff ff ff    	jne    1805 <print_d+0x2c>

  if (v < 0)
    188b:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    188f:	79 32                	jns    18c3 <print_d+0xea>
    buf[i++] = '-';
    1891:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1894:	8d 50 01             	lea    0x1(%rax),%edx
    1897:	89 55 f4             	mov    %edx,-0xc(%rbp)
    189a:	48 98                	cltq
    189c:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    18a1:	eb 20                	jmp    18c3 <print_d+0xea>
    putc(fd, buf[i]);
    18a3:	8b 45 f4             	mov    -0xc(%rbp),%eax
    18a6:	48 98                	cltq
    18a8:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    18ad:	0f be d0             	movsbl %al,%edx
    18b0:	8b 45 dc             	mov    -0x24(%rbp),%eax
    18b3:	89 d6                	mov    %edx,%esi
    18b5:	89 c7                	mov    %eax,%edi
    18b7:	48 b8 eb 16 00 00 00 	movabs $0x16eb,%rax
    18be:	00 00 00 
    18c1:	ff d0                	call   *%rax
  while (--i >= 0)
    18c3:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    18c7:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    18cb:	79 d6                	jns    18a3 <print_d+0xca>
}
    18cd:	90                   	nop
    18ce:	90                   	nop
    18cf:	c9                   	leave
    18d0:	c3                   	ret

00000000000018d1 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    18d1:	f3 0f 1e fa          	endbr64
    18d5:	55                   	push   %rbp
    18d6:	48 89 e5             	mov    %rsp,%rbp
    18d9:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    18e0:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    18e6:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    18ed:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    18f4:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    18fb:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    1902:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    1909:	84 c0                	test   %al,%al
    190b:	74 20                	je     192d <printf+0x5c>
    190d:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    1911:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    1915:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    1919:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    191d:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    1921:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    1925:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    1929:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    192d:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    1934:	00 00 00 
    1937:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    193e:	00 00 00 
    1941:	48 8d 45 10          	lea    0x10(%rbp),%rax
    1945:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    194c:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    1953:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    195a:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    1961:	00 00 00 
    1964:	e9 41 03 00 00       	jmp    1caa <printf+0x3d9>
    if (c != '%') {
    1969:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1970:	74 24                	je     1996 <printf+0xc5>
      putc(fd, c);
    1972:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1978:	0f be d0             	movsbl %al,%edx
    197b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1981:	89 d6                	mov    %edx,%esi
    1983:	89 c7                	mov    %eax,%edi
    1985:	48 b8 eb 16 00 00 00 	movabs $0x16eb,%rax
    198c:	00 00 00 
    198f:	ff d0                	call   *%rax
      continue;
    1991:	e9 0d 03 00 00       	jmp    1ca3 <printf+0x3d2>
    }
    c = fmt[++i] & 0xff;
    1996:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    199d:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    19a3:	48 63 d0             	movslq %eax,%rdx
    19a6:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    19ad:	48 01 d0             	add    %rdx,%rax
    19b0:	0f b6 00             	movzbl (%rax),%eax
    19b3:	0f be c0             	movsbl %al,%eax
    19b6:	25 ff 00 00 00       	and    $0xff,%eax
    19bb:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    19c1:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    19c8:	0f 84 0f 03 00 00    	je     1cdd <printf+0x40c>
      break;
    switch(c) {
    19ce:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    19d5:	0f 84 74 02 00 00    	je     1c4f <printf+0x37e>
    19db:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    19e2:	0f 8c 82 02 00 00    	jl     1c6a <printf+0x399>
    19e8:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    19ef:	0f 8f 75 02 00 00    	jg     1c6a <printf+0x399>
    19f5:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    19fc:	0f 8c 68 02 00 00    	jl     1c6a <printf+0x399>
    1a02:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1a08:	83 e8 63             	sub    $0x63,%eax
    1a0b:	83 f8 15             	cmp    $0x15,%eax
    1a0e:	0f 87 56 02 00 00    	ja     1c6a <printf+0x399>
    1a14:	89 c0                	mov    %eax,%eax
    1a16:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1a1d:	00 
    1a1e:	48 b8 28 20 00 00 00 	movabs $0x2028,%rax
    1a25:	00 00 00 
    1a28:	48 01 d0             	add    %rdx,%rax
    1a2b:	48 8b 00             	mov    (%rax),%rax
    1a2e:	3e ff e0             	notrack jmp *%rax
    case 'c':
      putc(fd, va_arg(ap, int));
    1a31:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1a37:	83 f8 2f             	cmp    $0x2f,%eax
    1a3a:	77 23                	ja     1a5f <printf+0x18e>
    1a3c:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1a43:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a49:	89 d2                	mov    %edx,%edx
    1a4b:	48 01 d0             	add    %rdx,%rax
    1a4e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a54:	83 c2 08             	add    $0x8,%edx
    1a57:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1a5d:	eb 12                	jmp    1a71 <printf+0x1a0>
    1a5f:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a66:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a6a:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a71:	8b 00                	mov    (%rax),%eax
    1a73:	0f be d0             	movsbl %al,%edx
    1a76:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a7c:	89 d6                	mov    %edx,%esi
    1a7e:	89 c7                	mov    %eax,%edi
    1a80:	48 b8 eb 16 00 00 00 	movabs $0x16eb,%rax
    1a87:	00 00 00 
    1a8a:	ff d0                	call   *%rax
      break;
    1a8c:	e9 12 02 00 00       	jmp    1ca3 <printf+0x3d2>
    case 'd':
      print_d(fd, va_arg(ap, int));
    1a91:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1a97:	83 f8 2f             	cmp    $0x2f,%eax
    1a9a:	77 23                	ja     1abf <printf+0x1ee>
    1a9c:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1aa3:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1aa9:	89 d2                	mov    %edx,%edx
    1aab:	48 01 d0             	add    %rdx,%rax
    1aae:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1ab4:	83 c2 08             	add    $0x8,%edx
    1ab7:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1abd:	eb 12                	jmp    1ad1 <printf+0x200>
    1abf:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1ac6:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1aca:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1ad1:	8b 10                	mov    (%rax),%edx
    1ad3:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1ad9:	89 d6                	mov    %edx,%esi
    1adb:	89 c7                	mov    %eax,%edi
    1add:	48 b8 d9 17 00 00 00 	movabs $0x17d9,%rax
    1ae4:	00 00 00 
    1ae7:	ff d0                	call   *%rax
      break;
    1ae9:	e9 b5 01 00 00       	jmp    1ca3 <printf+0x3d2>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    1aee:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1af4:	83 f8 2f             	cmp    $0x2f,%eax
    1af7:	77 23                	ja     1b1c <printf+0x24b>
    1af9:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1b00:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b06:	89 d2                	mov    %edx,%edx
    1b08:	48 01 d0             	add    %rdx,%rax
    1b0b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b11:	83 c2 08             	add    $0x8,%edx
    1b14:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1b1a:	eb 12                	jmp    1b2e <printf+0x25d>
    1b1c:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1b23:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1b27:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1b2e:	8b 10                	mov    (%rax),%edx
    1b30:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b36:	89 d6                	mov    %edx,%esi
    1b38:	89 c7                	mov    %eax,%edi
    1b3a:	48 b8 7c 17 00 00 00 	movabs $0x177c,%rax
    1b41:	00 00 00 
    1b44:	ff d0                	call   *%rax
      break;
    1b46:	e9 58 01 00 00       	jmp    1ca3 <printf+0x3d2>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    1b4b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1b51:	83 f8 2f             	cmp    $0x2f,%eax
    1b54:	77 23                	ja     1b79 <printf+0x2a8>
    1b56:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1b5d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b63:	89 d2                	mov    %edx,%edx
    1b65:	48 01 d0             	add    %rdx,%rax
    1b68:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b6e:	83 c2 08             	add    $0x8,%edx
    1b71:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1b77:	eb 12                	jmp    1b8b <printf+0x2ba>
    1b79:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1b80:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1b84:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1b8b:	48 8b 10             	mov    (%rax),%rdx
    1b8e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b94:	48 89 d6             	mov    %rdx,%rsi
    1b97:	89 c7                	mov    %eax,%edi
    1b99:	48 b8 1f 17 00 00 00 	movabs $0x171f,%rax
    1ba0:	00 00 00 
    1ba3:	ff d0                	call   *%rax
      break;
    1ba5:	e9 f9 00 00 00       	jmp    1ca3 <printf+0x3d2>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    1baa:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1bb0:	83 f8 2f             	cmp    $0x2f,%eax
    1bb3:	77 23                	ja     1bd8 <printf+0x307>
    1bb5:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1bbc:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1bc2:	89 d2                	mov    %edx,%edx
    1bc4:	48 01 d0             	add    %rdx,%rax
    1bc7:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1bcd:	83 c2 08             	add    $0x8,%edx
    1bd0:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1bd6:	eb 12                	jmp    1bea <printf+0x319>
    1bd8:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1bdf:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1be3:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1bea:	48 8b 00             	mov    (%rax),%rax
    1bed:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    1bf4:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1bfb:	00 
    1bfc:	75 41                	jne    1c3f <printf+0x36e>
        s = "(null)";
    1bfe:	48 b8 20 20 00 00 00 	movabs $0x2020,%rax
    1c05:	00 00 00 
    1c08:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1c0f:	eb 2e                	jmp    1c3f <printf+0x36e>
        putc(fd, *(s++));
    1c11:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1c18:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1c1c:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1c23:	0f b6 00             	movzbl (%rax),%eax
    1c26:	0f be d0             	movsbl %al,%edx
    1c29:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1c2f:	89 d6                	mov    %edx,%esi
    1c31:	89 c7                	mov    %eax,%edi
    1c33:	48 b8 eb 16 00 00 00 	movabs $0x16eb,%rax
    1c3a:	00 00 00 
    1c3d:	ff d0                	call   *%rax
      while (*s)
    1c3f:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1c46:	0f b6 00             	movzbl (%rax),%eax
    1c49:	84 c0                	test   %al,%al
    1c4b:	75 c4                	jne    1c11 <printf+0x340>
      break;
    1c4d:	eb 54                	jmp    1ca3 <printf+0x3d2>
    case '%':
      putc(fd, '%');
    1c4f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1c55:	be 25 00 00 00       	mov    $0x25,%esi
    1c5a:	89 c7                	mov    %eax,%edi
    1c5c:	48 b8 eb 16 00 00 00 	movabs $0x16eb,%rax
    1c63:	00 00 00 
    1c66:	ff d0                	call   *%rax
      break;
    1c68:	eb 39                	jmp    1ca3 <printf+0x3d2>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1c6a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1c70:	be 25 00 00 00       	mov    $0x25,%esi
    1c75:	89 c7                	mov    %eax,%edi
    1c77:	48 b8 eb 16 00 00 00 	movabs $0x16eb,%rax
    1c7e:	00 00 00 
    1c81:	ff d0                	call   *%rax
      putc(fd, c);
    1c83:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1c89:	0f be d0             	movsbl %al,%edx
    1c8c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1c92:	89 d6                	mov    %edx,%esi
    1c94:	89 c7                	mov    %eax,%edi
    1c96:	48 b8 eb 16 00 00 00 	movabs $0x16eb,%rax
    1c9d:	00 00 00 
    1ca0:	ff d0                	call   *%rax
      break;
    1ca2:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1ca3:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1caa:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1cb0:	48 63 d0             	movslq %eax,%rdx
    1cb3:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1cba:	48 01 d0             	add    %rdx,%rax
    1cbd:	0f b6 00             	movzbl (%rax),%eax
    1cc0:	0f be c0             	movsbl %al,%eax
    1cc3:	25 ff 00 00 00       	and    $0xff,%eax
    1cc8:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1cce:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1cd5:	0f 85 8e fc ff ff    	jne    1969 <printf+0x98>
    }
  }
}
    1cdb:	eb 01                	jmp    1cde <printf+0x40d>
      break;
    1cdd:	90                   	nop
}
    1cde:	90                   	nop
    1cdf:	c9                   	leave
    1ce0:	c3                   	ret

0000000000001ce1 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1ce1:	f3 0f 1e fa          	endbr64
    1ce5:	55                   	push   %rbp
    1ce6:	48 89 e5             	mov    %rsp,%rbp
    1ce9:	48 83 ec 18          	sub    $0x18,%rsp
    1ced:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1cf1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1cf5:	48 83 e8 10          	sub    $0x10,%rax
    1cf9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1cfd:	48 b8 10 23 00 00 00 	movabs $0x2310,%rax
    1d04:	00 00 00 
    1d07:	48 8b 00             	mov    (%rax),%rax
    1d0a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1d0e:	eb 2f                	jmp    1d3f <free+0x5e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1d10:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d14:	48 8b 00             	mov    (%rax),%rax
    1d17:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1d1b:	72 17                	jb     1d34 <free+0x53>
    1d1d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d21:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1d25:	72 2f                	jb     1d56 <free+0x75>
    1d27:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d2b:	48 8b 00             	mov    (%rax),%rax
    1d2e:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1d32:	72 22                	jb     1d56 <free+0x75>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1d34:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d38:	48 8b 00             	mov    (%rax),%rax
    1d3b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1d3f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d43:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1d47:	73 c7                	jae    1d10 <free+0x2f>
    1d49:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d4d:	48 8b 00             	mov    (%rax),%rax
    1d50:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1d54:	73 ba                	jae    1d10 <free+0x2f>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1d56:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d5a:	8b 40 08             	mov    0x8(%rax),%eax
    1d5d:	89 c0                	mov    %eax,%eax
    1d5f:	48 c1 e0 04          	shl    $0x4,%rax
    1d63:	48 89 c2             	mov    %rax,%rdx
    1d66:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d6a:	48 01 c2             	add    %rax,%rdx
    1d6d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d71:	48 8b 00             	mov    (%rax),%rax
    1d74:	48 39 c2             	cmp    %rax,%rdx
    1d77:	75 2d                	jne    1da6 <free+0xc5>
    bp->s.size += p->s.ptr->s.size;
    1d79:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d7d:	8b 50 08             	mov    0x8(%rax),%edx
    1d80:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d84:	48 8b 00             	mov    (%rax),%rax
    1d87:	8b 40 08             	mov    0x8(%rax),%eax
    1d8a:	01 c2                	add    %eax,%edx
    1d8c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d90:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1d93:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d97:	48 8b 00             	mov    (%rax),%rax
    1d9a:	48 8b 10             	mov    (%rax),%rdx
    1d9d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1da1:	48 89 10             	mov    %rdx,(%rax)
    1da4:	eb 0e                	jmp    1db4 <free+0xd3>
  } else
    bp->s.ptr = p->s.ptr;
    1da6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1daa:	48 8b 10             	mov    (%rax),%rdx
    1dad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1db1:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    1db4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1db8:	8b 40 08             	mov    0x8(%rax),%eax
    1dbb:	89 c0                	mov    %eax,%eax
    1dbd:	48 c1 e0 04          	shl    $0x4,%rax
    1dc1:	48 89 c2             	mov    %rax,%rdx
    1dc4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1dc8:	48 01 d0             	add    %rdx,%rax
    1dcb:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1dcf:	75 27                	jne    1df8 <free+0x117>
    p->s.size += bp->s.size;
    1dd1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1dd5:	8b 50 08             	mov    0x8(%rax),%edx
    1dd8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ddc:	8b 40 08             	mov    0x8(%rax),%eax
    1ddf:	01 c2                	add    %eax,%edx
    1de1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1de5:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    1de8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1dec:	48 8b 10             	mov    (%rax),%rdx
    1def:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1df3:	48 89 10             	mov    %rdx,(%rax)
    1df6:	eb 0b                	jmp    1e03 <free+0x122>
  } else
    p->s.ptr = bp;
    1df8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1dfc:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1e00:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    1e03:	48 ba 10 23 00 00 00 	movabs $0x2310,%rdx
    1e0a:	00 00 00 
    1e0d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e11:	48 89 02             	mov    %rax,(%rdx)
}
    1e14:	90                   	nop
    1e15:	c9                   	leave
    1e16:	c3                   	ret

0000000000001e17 <morecore>:

static Header*
morecore(uint nu)
{
    1e17:	f3 0f 1e fa          	endbr64
    1e1b:	55                   	push   %rbp
    1e1c:	48 89 e5             	mov    %rsp,%rbp
    1e1f:	48 83 ec 20          	sub    $0x20,%rsp
    1e23:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    1e26:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1e2d:	77 07                	ja     1e36 <morecore+0x1f>
    nu = 4096;
    1e2f:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    1e36:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1e39:	48 c1 e0 04          	shl    $0x4,%rax
    1e3d:	48 89 c7             	mov    %rax,%rdi
    1e40:	48 b8 9d 16 00 00 00 	movabs $0x169d,%rax
    1e47:	00 00 00 
    1e4a:	ff d0                	call   *%rax
    1e4c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    1e50:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1e55:	75 07                	jne    1e5e <morecore+0x47>
    return 0;
    1e57:	b8 00 00 00 00       	mov    $0x0,%eax
    1e5c:	eb 36                	jmp    1e94 <morecore+0x7d>
  hp = (Header*)p;
    1e5e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e62:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    1e66:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e6a:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1e6d:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    1e70:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e74:	48 83 c0 10          	add    $0x10,%rax
    1e78:	48 89 c7             	mov    %rax,%rdi
    1e7b:	48 b8 e1 1c 00 00 00 	movabs $0x1ce1,%rax
    1e82:	00 00 00 
    1e85:	ff d0                	call   *%rax
  return freep;
    1e87:	48 b8 10 23 00 00 00 	movabs $0x2310,%rax
    1e8e:	00 00 00 
    1e91:	48 8b 00             	mov    (%rax),%rax
}
    1e94:	c9                   	leave
    1e95:	c3                   	ret

0000000000001e96 <malloc>:

void*
malloc(uint nbytes)
{
    1e96:	f3 0f 1e fa          	endbr64
    1e9a:	55                   	push   %rbp
    1e9b:	48 89 e5             	mov    %rsp,%rbp
    1e9e:	48 83 ec 30          	sub    $0x30,%rsp
    1ea2:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1ea5:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1ea8:	48 83 c0 0f          	add    $0xf,%rax
    1eac:	48 c1 e8 04          	shr    $0x4,%rax
    1eb0:	83 c0 01             	add    $0x1,%eax
    1eb3:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    1eb6:	48 b8 10 23 00 00 00 	movabs $0x2310,%rax
    1ebd:	00 00 00 
    1ec0:	48 8b 00             	mov    (%rax),%rax
    1ec3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1ec7:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1ecc:	75 4a                	jne    1f18 <malloc+0x82>
    base.s.ptr = freep = prevp = &base;
    1ece:	48 b8 00 23 00 00 00 	movabs $0x2300,%rax
    1ed5:	00 00 00 
    1ed8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1edc:	48 ba 10 23 00 00 00 	movabs $0x2310,%rdx
    1ee3:	00 00 00 
    1ee6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1eea:	48 89 02             	mov    %rax,(%rdx)
    1eed:	48 b8 10 23 00 00 00 	movabs $0x2310,%rax
    1ef4:	00 00 00 
    1ef7:	48 8b 00             	mov    (%rax),%rax
    1efa:	48 ba 00 23 00 00 00 	movabs $0x2300,%rdx
    1f01:	00 00 00 
    1f04:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    1f07:	48 b8 00 23 00 00 00 	movabs $0x2300,%rax
    1f0e:	00 00 00 
    1f11:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1f18:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f1c:	48 8b 00             	mov    (%rax),%rax
    1f1f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1f23:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f27:	8b 40 08             	mov    0x8(%rax),%eax
    1f2a:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1f2d:	72 65                	jb     1f94 <malloc+0xfe>
      if(p->s.size == nunits)
    1f2f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f33:	8b 40 08             	mov    0x8(%rax),%eax
    1f36:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1f39:	75 10                	jne    1f4b <malloc+0xb5>
        prevp->s.ptr = p->s.ptr;
    1f3b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f3f:	48 8b 10             	mov    (%rax),%rdx
    1f42:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f46:	48 89 10             	mov    %rdx,(%rax)
    1f49:	eb 2e                	jmp    1f79 <malloc+0xe3>
      else {
        p->s.size -= nunits;
    1f4b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f4f:	8b 40 08             	mov    0x8(%rax),%eax
    1f52:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1f55:	89 c2                	mov    %eax,%edx
    1f57:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f5b:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    1f5e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f62:	8b 40 08             	mov    0x8(%rax),%eax
    1f65:	89 c0                	mov    %eax,%eax
    1f67:	48 c1 e0 04          	shl    $0x4,%rax
    1f6b:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    1f6f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f73:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1f76:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    1f79:	48 ba 10 23 00 00 00 	movabs $0x2310,%rdx
    1f80:	00 00 00 
    1f83:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f87:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    1f8a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f8e:	48 83 c0 10          	add    $0x10,%rax
    1f92:	eb 4e                	jmp    1fe2 <malloc+0x14c>
    }
    if(p == freep)
    1f94:	48 b8 10 23 00 00 00 	movabs $0x2310,%rax
    1f9b:	00 00 00 
    1f9e:	48 8b 00             	mov    (%rax),%rax
    1fa1:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1fa5:	75 23                	jne    1fca <malloc+0x134>
      if((p = morecore(nunits)) == 0)
    1fa7:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1faa:	89 c7                	mov    %eax,%edi
    1fac:	48 b8 17 1e 00 00 00 	movabs $0x1e17,%rax
    1fb3:	00 00 00 
    1fb6:	ff d0                	call   *%rax
    1fb8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1fbc:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1fc1:	75 07                	jne    1fca <malloc+0x134>
        return 0;
    1fc3:	b8 00 00 00 00       	mov    $0x0,%eax
    1fc8:	eb 18                	jmp    1fe2 <malloc+0x14c>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1fca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1fce:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1fd2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1fd6:	48 8b 00             	mov    (%rax),%rax
    1fd9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1fdd:	e9 41 ff ff ff       	jmp    1f23 <malloc+0x8d>
  }
}
    1fe2:	c9                   	leave
    1fe3:	c3                   	ret
