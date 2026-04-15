
_stressfs:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <main>:
    1000:	55                   	push   %rbp
    1001:	48 89 e5             	mov    %rsp,%rbp
    1004:	48 81 ec 30 02 00 00 	sub    $0x230,%rsp
    100b:	89 bd dc fd ff ff    	mov    %edi,-0x224(%rbp)
    1011:	48 89 b5 d0 fd ff ff 	mov    %rsi,-0x230(%rbp)
    1018:	48 b8 73 74 72 65 73 	movabs $0x7366737365727473,%rax
    101f:	73 66 73 
    1022:	48 89 45 ee          	mov    %rax,-0x12(%rbp)
    1026:	66 c7 45 f6 30 00    	movw   $0x30,-0xa(%rbp)
    102c:	48 b8 18 1f 00 00 00 	movabs $0x1f18,%rax
    1033:	00 00 00 
    1036:	48 89 c6             	mov    %rax,%rsi
    1039:	bf 01 00 00 00       	mov    $0x1,%edi
    103e:	b8 00 00 00 00       	mov    $0x0,%eax
    1043:	48 ba 0b 18 00 00 00 	movabs $0x180b,%rdx
    104a:	00 00 00 
    104d:	ff d2                	call   *%rdx
    104f:	48 8d 85 e0 fd ff ff 	lea    -0x220(%rbp),%rax
    1056:	ba 00 02 00 00       	mov    $0x200,%edx
    105b:	be 61 00 00 00       	mov    $0x61,%esi
    1060:	48 89 c7             	mov    %rax,%rdi
    1063:	48 b8 d2 12 00 00 00 	movabs $0x12d2,%rax
    106a:	00 00 00 
    106d:	ff d0                	call   *%rax
    106f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1076:	eb 14                	jmp    108c <main+0x8c>
    1078:	48 b8 fa 14 00 00 00 	movabs $0x14fa,%rax
    107f:	00 00 00 
    1082:	ff d0                	call   *%rax
    1084:	85 c0                	test   %eax,%eax
    1086:	7f 0c                	jg     1094 <main+0x94>
    1088:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    108c:	83 7d fc 03          	cmpl   $0x3,-0x4(%rbp)
    1090:	7e e6                	jle    1078 <main+0x78>
    1092:	eb 01                	jmp    1095 <main+0x95>
    1094:	90                   	nop
    1095:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1098:	48 b9 2b 1f 00 00 00 	movabs $0x1f2b,%rcx
    109f:	00 00 00 
    10a2:	89 c2                	mov    %eax,%edx
    10a4:	48 89 ce             	mov    %rcx,%rsi
    10a7:	bf 01 00 00 00       	mov    $0x1,%edi
    10ac:	b8 00 00 00 00       	mov    $0x0,%eax
    10b1:	48 b9 0b 18 00 00 00 	movabs $0x180b,%rcx
    10b8:	00 00 00 
    10bb:	ff d1                	call   *%rcx
    10bd:	0f b6 45 f6          	movzbl -0xa(%rbp),%eax
    10c1:	89 c2                	mov    %eax,%edx
    10c3:	8b 45 fc             	mov    -0x4(%rbp),%eax
    10c6:	01 d0                	add    %edx,%eax
    10c8:	88 45 f6             	mov    %al,-0xa(%rbp)
    10cb:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
    10cf:	be 02 02 00 00       	mov    $0x202,%esi
    10d4:	48 89 c7             	mov    %rax,%rdi
    10d7:	48 b8 6f 15 00 00 00 	movabs $0x156f,%rax
    10de:	00 00 00 
    10e1:	ff d0                	call   *%rax
    10e3:	89 45 f8             	mov    %eax,-0x8(%rbp)
    10e6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    10ed:	eb 24                	jmp    1113 <main+0x113>
    10ef:	48 8d 8d e0 fd ff ff 	lea    -0x220(%rbp),%rcx
    10f6:	8b 45 f8             	mov    -0x8(%rbp),%eax
    10f9:	ba 00 02 00 00       	mov    $0x200,%edx
    10fe:	48 89 ce             	mov    %rcx,%rsi
    1101:	89 c7                	mov    %eax,%edi
    1103:	48 b8 3b 15 00 00 00 	movabs $0x153b,%rax
    110a:	00 00 00 
    110d:	ff d0                	call   *%rax
    110f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1113:	83 7d fc 13          	cmpl   $0x13,-0x4(%rbp)
    1117:	7e d6                	jle    10ef <main+0xef>
    1119:	8b 45 f8             	mov    -0x8(%rbp),%eax
    111c:	89 c7                	mov    %eax,%edi
    111e:	48 b8 48 15 00 00 00 	movabs $0x1548,%rax
    1125:	00 00 00 
    1128:	ff d0                	call   *%rax
    112a:	48 b8 35 1f 00 00 00 	movabs $0x1f35,%rax
    1131:	00 00 00 
    1134:	48 89 c6             	mov    %rax,%rsi
    1137:	bf 01 00 00 00       	mov    $0x1,%edi
    113c:	b8 00 00 00 00       	mov    $0x0,%eax
    1141:	48 ba 0b 18 00 00 00 	movabs $0x180b,%rdx
    1148:	00 00 00 
    114b:	ff d2                	call   *%rdx
    114d:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
    1151:	be 00 00 00 00       	mov    $0x0,%esi
    1156:	48 89 c7             	mov    %rax,%rdi
    1159:	48 b8 6f 15 00 00 00 	movabs $0x156f,%rax
    1160:	00 00 00 
    1163:	ff d0                	call   *%rax
    1165:	89 45 f8             	mov    %eax,-0x8(%rbp)
    1168:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    116f:	eb 24                	jmp    1195 <main+0x195>
    1171:	48 8d 8d e0 fd ff ff 	lea    -0x220(%rbp),%rcx
    1178:	8b 45 f8             	mov    -0x8(%rbp),%eax
    117b:	ba 00 02 00 00       	mov    $0x200,%edx
    1180:	48 89 ce             	mov    %rcx,%rsi
    1183:	89 c7                	mov    %eax,%edi
    1185:	48 b8 2e 15 00 00 00 	movabs $0x152e,%rax
    118c:	00 00 00 
    118f:	ff d0                	call   *%rax
    1191:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1195:	83 7d fc 13          	cmpl   $0x13,-0x4(%rbp)
    1199:	7e d6                	jle    1171 <main+0x171>
    119b:	8b 45 f8             	mov    -0x8(%rbp),%eax
    119e:	89 c7                	mov    %eax,%edi
    11a0:	48 b8 48 15 00 00 00 	movabs $0x1548,%rax
    11a7:	00 00 00 
    11aa:	ff d0                	call   *%rax
    11ac:	48 b8 14 15 00 00 00 	movabs $0x1514,%rax
    11b3:	00 00 00 
    11b6:	ff d0                	call   *%rax
    11b8:	48 b8 07 15 00 00 00 	movabs $0x1507,%rax
    11bf:	00 00 00 
    11c2:	ff d0                	call   *%rax

00000000000011c4 <stosb>:
  stosb(dst, c, n);
  return dst;
}

char*
strchr(const char *s, char c)
    11c4:	f3 0f 1e fa          	endbr64
    11c8:	55                   	push   %rbp
    11c9:	48 89 e5             	mov    %rsp,%rbp
    11cc:	48 83 ec 10          	sub    $0x10,%rsp
    11d0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    11d4:	89 75 f4             	mov    %esi,-0xc(%rbp)
    11d7:	89 55 f0             	mov    %edx,-0x10(%rbp)
{
    11da:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    11de:	8b 55 f0             	mov    -0x10(%rbp),%edx
    11e1:	8b 45 f4             	mov    -0xc(%rbp),%eax
    11e4:	48 89 ce             	mov    %rcx,%rsi
    11e7:	48 89 f7             	mov    %rsi,%rdi
    11ea:	89 d1                	mov    %edx,%ecx
    11ec:	fc                   	cld
    11ed:	f3 aa                	rep stos %al,%es:(%rdi)
    11ef:	89 ca                	mov    %ecx,%edx
    11f1:	48 89 fe             	mov    %rdi,%rsi
    11f4:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    11f8:	89 55 f0             	mov    %edx,-0x10(%rbp)
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
    11fb:	90                   	nop
    11fc:	c9                   	leave
    11fd:	c3                   	ret

00000000000011fe <strcpy>:
{
    11fe:	f3 0f 1e fa          	endbr64
    1202:	55                   	push   %rbp
    1203:	48 89 e5             	mov    %rsp,%rbp
    1206:	48 83 ec 20          	sub    $0x20,%rsp
    120a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    120e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  os = s;
    1212:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1216:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    121a:	90                   	nop
    121b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    121f:	48 8d 42 01          	lea    0x1(%rdx),%rax
    1223:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    1227:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    122b:	48 8d 48 01          	lea    0x1(%rax),%rcx
    122f:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    1233:	0f b6 12             	movzbl (%rdx),%edx
    1236:	88 10                	mov    %dl,(%rax)
    1238:	0f b6 00             	movzbl (%rax),%eax
    123b:	84 c0                	test   %al,%al
    123d:	75 dc                	jne    121b <strcpy+0x1d>
  return os;
    123f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    1243:	c9                   	leave
    1244:	c3                   	ret

0000000000001245 <strcmp>:
{
    1245:	f3 0f 1e fa          	endbr64
    1249:	55                   	push   %rbp
    124a:	48 89 e5             	mov    %rsp,%rbp
    124d:	48 83 ec 10          	sub    $0x10,%rsp
    1251:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1255:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    1259:	eb 0a                	jmp    1265 <strcmp+0x20>
    p++, q++;
    125b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1260:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    1265:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1269:	0f b6 00             	movzbl (%rax),%eax
    126c:	84 c0                	test   %al,%al
    126e:	74 12                	je     1282 <strcmp+0x3d>
    1270:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1274:	0f b6 10             	movzbl (%rax),%edx
    1277:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    127b:	0f b6 00             	movzbl (%rax),%eax
    127e:	38 c2                	cmp    %al,%dl
    1280:	74 d9                	je     125b <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
    1282:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1286:	0f b6 00             	movzbl (%rax),%eax
    1289:	0f b6 d0             	movzbl %al,%edx
    128c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1290:	0f b6 00             	movzbl (%rax),%eax
    1293:	0f b6 c0             	movzbl %al,%eax
    1296:	29 c2                	sub    %eax,%edx
    1298:	89 d0                	mov    %edx,%eax
}
    129a:	c9                   	leave
    129b:	c3                   	ret

000000000000129c <strlen>:
{
    129c:	f3 0f 1e fa          	endbr64
    12a0:	55                   	push   %rbp
    12a1:	48 89 e5             	mov    %rsp,%rbp
    12a4:	48 83 ec 18          	sub    $0x18,%rsp
    12a8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  for(n = 0; s[n]; n++)
    12ac:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    12b3:	eb 04                	jmp    12b9 <strlen+0x1d>
    12b5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    12b9:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12bc:	48 63 d0             	movslq %eax,%rdx
    12bf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12c3:	48 01 d0             	add    %rdx,%rax
    12c6:	0f b6 00             	movzbl (%rax),%eax
    12c9:	84 c0                	test   %al,%al
    12cb:	75 e8                	jne    12b5 <strlen+0x19>
  return n;
    12cd:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    12d0:	c9                   	leave
    12d1:	c3                   	ret

00000000000012d2 <memset>:
{
    12d2:	f3 0f 1e fa          	endbr64
    12d6:	55                   	push   %rbp
    12d7:	48 89 e5             	mov    %rsp,%rbp
    12da:	48 83 ec 10          	sub    $0x10,%rsp
    12de:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    12e2:	89 75 f4             	mov    %esi,-0xc(%rbp)
    12e5:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    12e8:	8b 55 f0             	mov    -0x10(%rbp),%edx
    12eb:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    12ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    12f2:	89 ce                	mov    %ecx,%esi
    12f4:	48 89 c7             	mov    %rax,%rdi
    12f7:	48 b8 c4 11 00 00 00 	movabs $0x11c4,%rax
    12fe:	00 00 00 
    1301:	ff d0                	call   *%rax
  return dst;
    1303:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    1307:	c9                   	leave
    1308:	c3                   	ret

0000000000001309 <strchr>:
{
    1309:	f3 0f 1e fa          	endbr64
    130d:	55                   	push   %rbp
    130e:	48 89 e5             	mov    %rsp,%rbp
    1311:	48 83 ec 10          	sub    $0x10,%rsp
    1315:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1319:	89 f0                	mov    %esi,%eax
    131b:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    131e:	eb 17                	jmp    1337 <strchr+0x2e>
    if(*s == c)
    1320:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1324:	0f b6 00             	movzbl (%rax),%eax
    1327:	38 45 f4             	cmp    %al,-0xc(%rbp)
    132a:	75 06                	jne    1332 <strchr+0x29>
      return (char*)s;
    132c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1330:	eb 15                	jmp    1347 <strchr+0x3e>
  for(; *s; s++)
    1332:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1337:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    133b:	0f b6 00             	movzbl (%rax),%eax
    133e:	84 c0                	test   %al,%al
    1340:	75 de                	jne    1320 <strchr+0x17>
  return 0;
    1342:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1347:	c9                   	leave
    1348:	c3                   	ret

0000000000001349 <gets>:

char*
gets(char *buf, int max)
{
    1349:	f3 0f 1e fa          	endbr64
    134d:	55                   	push   %rbp
    134e:	48 89 e5             	mov    %rsp,%rbp
    1351:	48 83 ec 20          	sub    $0x20,%rsp
    1355:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1359:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    135c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1363:	eb 4f                	jmp    13b4 <gets+0x6b>
    cc = read(0, &c, 1);
    1365:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    1369:	ba 01 00 00 00       	mov    $0x1,%edx
    136e:	48 89 c6             	mov    %rax,%rsi
    1371:	bf 00 00 00 00       	mov    $0x0,%edi
    1376:	48 b8 2e 15 00 00 00 	movabs $0x152e,%rax
    137d:	00 00 00 
    1380:	ff d0                	call   *%rax
    1382:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    1385:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1389:	7e 36                	jle    13c1 <gets+0x78>
      break;
    buf[i++] = c;
    138b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    138e:	8d 50 01             	lea    0x1(%rax),%edx
    1391:	89 55 fc             	mov    %edx,-0x4(%rbp)
    1394:	48 63 d0             	movslq %eax,%rdx
    1397:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    139b:	48 01 c2             	add    %rax,%rdx
    139e:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    13a2:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    13a4:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    13a8:	3c 0a                	cmp    $0xa,%al
    13aa:	74 16                	je     13c2 <gets+0x79>
    13ac:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    13b0:	3c 0d                	cmp    $0xd,%al
    13b2:	74 0e                	je     13c2 <gets+0x79>
  for(i=0; i+1 < max; ){
    13b4:	8b 45 fc             	mov    -0x4(%rbp),%eax
    13b7:	83 c0 01             	add    $0x1,%eax
    13ba:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    13bd:	7f a6                	jg     1365 <gets+0x1c>
    13bf:	eb 01                	jmp    13c2 <gets+0x79>
      break;
    13c1:	90                   	nop
      break;
  }
  buf[i] = '\0';
    13c2:	8b 45 fc             	mov    -0x4(%rbp),%eax
    13c5:	48 63 d0             	movslq %eax,%rdx
    13c8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    13cc:	48 01 d0             	add    %rdx,%rax
    13cf:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    13d2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    13d6:	c9                   	leave
    13d7:	c3                   	ret

00000000000013d8 <stat>:

int
stat(char *n, struct stat *st)
{
    13d8:	f3 0f 1e fa          	endbr64
    13dc:	55                   	push   %rbp
    13dd:	48 89 e5             	mov    %rsp,%rbp
    13e0:	48 83 ec 20          	sub    $0x20,%rsp
    13e4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    13e8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    13ec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    13f0:	be 00 00 00 00       	mov    $0x0,%esi
    13f5:	48 89 c7             	mov    %rax,%rdi
    13f8:	48 b8 6f 15 00 00 00 	movabs $0x156f,%rax
    13ff:	00 00 00 
    1402:	ff d0                	call   *%rax
    1404:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    1407:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    140b:	79 07                	jns    1414 <stat+0x3c>
    return -1;
    140d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1412:	eb 2f                	jmp    1443 <stat+0x6b>
  r = fstat(fd, st);
    1414:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1418:	8b 45 fc             	mov    -0x4(%rbp),%eax
    141b:	48 89 d6             	mov    %rdx,%rsi
    141e:	89 c7                	mov    %eax,%edi
    1420:	48 b8 96 15 00 00 00 	movabs $0x1596,%rax
    1427:	00 00 00 
    142a:	ff d0                	call   *%rax
    142c:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    142f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1432:	89 c7                	mov    %eax,%edi
    1434:	48 b8 48 15 00 00 00 	movabs $0x1548,%rax
    143b:	00 00 00 
    143e:	ff d0                	call   *%rax
  return r;
    1440:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    1443:	c9                   	leave
    1444:	c3                   	ret

0000000000001445 <atoi>:

int
atoi(const char *s)
{
    1445:	f3 0f 1e fa          	endbr64
    1449:	55                   	push   %rbp
    144a:	48 89 e5             	mov    %rsp,%rbp
    144d:	48 83 ec 18          	sub    $0x18,%rsp
    1451:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    1455:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    145c:	eb 28                	jmp    1486 <atoi+0x41>
    n = n*10 + *s++ - '0';
    145e:	8b 55 fc             	mov    -0x4(%rbp),%edx
    1461:	89 d0                	mov    %edx,%eax
    1463:	c1 e0 02             	shl    $0x2,%eax
    1466:	01 d0                	add    %edx,%eax
    1468:	01 c0                	add    %eax,%eax
    146a:	89 c1                	mov    %eax,%ecx
    146c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1470:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1474:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    1478:	0f b6 00             	movzbl (%rax),%eax
    147b:	0f be c0             	movsbl %al,%eax
    147e:	01 c8                	add    %ecx,%eax
    1480:	83 e8 30             	sub    $0x30,%eax
    1483:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1486:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    148a:	0f b6 00             	movzbl (%rax),%eax
    148d:	3c 2f                	cmp    $0x2f,%al
    148f:	7e 0b                	jle    149c <atoi+0x57>
    1491:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1495:	0f b6 00             	movzbl (%rax),%eax
    1498:	3c 39                	cmp    $0x39,%al
    149a:	7e c2                	jle    145e <atoi+0x19>
  return n;
    149c:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    149f:	c9                   	leave
    14a0:	c3                   	ret

00000000000014a1 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    14a1:	f3 0f 1e fa          	endbr64
    14a5:	55                   	push   %rbp
    14a6:	48 89 e5             	mov    %rsp,%rbp
    14a9:	48 83 ec 28          	sub    $0x28,%rsp
    14ad:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    14b1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    14b5:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    14b8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    14bc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    14c0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    14c4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    14c8:	eb 1d                	jmp    14e7 <memmove+0x46>
    *dst++ = *src++;
    14ca:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    14ce:	48 8d 42 01          	lea    0x1(%rdx),%rax
    14d2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    14d6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    14da:	48 8d 48 01          	lea    0x1(%rax),%rcx
    14de:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    14e2:	0f b6 12             	movzbl (%rdx),%edx
    14e5:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    14e7:	8b 45 dc             	mov    -0x24(%rbp),%eax
    14ea:	8d 50 ff             	lea    -0x1(%rax),%edx
    14ed:	89 55 dc             	mov    %edx,-0x24(%rbp)
    14f0:	85 c0                	test   %eax,%eax
    14f2:	7f d6                	jg     14ca <memmove+0x29>
  return vdst;
    14f4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    14f8:	c9                   	leave
    14f9:	c3                   	ret

00000000000014fa <fork>:
    14fa:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    1501:	49 89 ca             	mov    %rcx,%r10
    1504:	0f 05                	syscall
    1506:	c3                   	ret

0000000000001507 <exit>:
    1507:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    150e:	49 89 ca             	mov    %rcx,%r10
    1511:	0f 05                	syscall
    1513:	c3                   	ret

0000000000001514 <wait>:
    1514:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    151b:	49 89 ca             	mov    %rcx,%r10
    151e:	0f 05                	syscall
    1520:	c3                   	ret

0000000000001521 <pipe>:
    1521:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    1528:	49 89 ca             	mov    %rcx,%r10
    152b:	0f 05                	syscall
    152d:	c3                   	ret

000000000000152e <read>:
    152e:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    1535:	49 89 ca             	mov    %rcx,%r10
    1538:	0f 05                	syscall
    153a:	c3                   	ret

000000000000153b <write>:
    153b:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    1542:	49 89 ca             	mov    %rcx,%r10
    1545:	0f 05                	syscall
    1547:	c3                   	ret

0000000000001548 <close>:
    1548:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    154f:	49 89 ca             	mov    %rcx,%r10
    1552:	0f 05                	syscall
    1554:	c3                   	ret

0000000000001555 <kill>:
    1555:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    155c:	49 89 ca             	mov    %rcx,%r10
    155f:	0f 05                	syscall
    1561:	c3                   	ret

0000000000001562 <exec>:
    1562:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    1569:	49 89 ca             	mov    %rcx,%r10
    156c:	0f 05                	syscall
    156e:	c3                   	ret

000000000000156f <open>:
    156f:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    1576:	49 89 ca             	mov    %rcx,%r10
    1579:	0f 05                	syscall
    157b:	c3                   	ret

000000000000157c <mknod>:
    157c:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    1583:	49 89 ca             	mov    %rcx,%r10
    1586:	0f 05                	syscall
    1588:	c3                   	ret

0000000000001589 <unlink>:
    1589:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    1590:	49 89 ca             	mov    %rcx,%r10
    1593:	0f 05                	syscall
    1595:	c3                   	ret

0000000000001596 <fstat>:
    1596:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    159d:	49 89 ca             	mov    %rcx,%r10
    15a0:	0f 05                	syscall
    15a2:	c3                   	ret

00000000000015a3 <link>:
    15a3:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    15aa:	49 89 ca             	mov    %rcx,%r10
    15ad:	0f 05                	syscall
    15af:	c3                   	ret

00000000000015b0 <mkdir>:
    15b0:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    15b7:	49 89 ca             	mov    %rcx,%r10
    15ba:	0f 05                	syscall
    15bc:	c3                   	ret

00000000000015bd <chdir>:
    15bd:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    15c4:	49 89 ca             	mov    %rcx,%r10
    15c7:	0f 05                	syscall
    15c9:	c3                   	ret

00000000000015ca <dup>:
    15ca:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    15d1:	49 89 ca             	mov    %rcx,%r10
    15d4:	0f 05                	syscall
    15d6:	c3                   	ret

00000000000015d7 <getpid>:
    15d7:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    15de:	49 89 ca             	mov    %rcx,%r10
    15e1:	0f 05                	syscall
    15e3:	c3                   	ret

00000000000015e4 <sbrk>:
    15e4:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    15eb:	49 89 ca             	mov    %rcx,%r10
    15ee:	0f 05                	syscall
    15f0:	c3                   	ret

00000000000015f1 <sleep>:
    15f1:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    15f8:	49 89 ca             	mov    %rcx,%r10
    15fb:	0f 05                	syscall
    15fd:	c3                   	ret

00000000000015fe <uptime>:
    15fe:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    1605:	49 89 ca             	mov    %rcx,%r10
    1608:	0f 05                	syscall
    160a:	c3                   	ret

000000000000160b <send>:
    160b:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    1612:	49 89 ca             	mov    %rcx,%r10
    1615:	0f 05                	syscall
    1617:	c3                   	ret

0000000000001618 <recv>:
    1618:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    161f:	49 89 ca             	mov    %rcx,%r10
    1622:	0f 05                	syscall
    1624:	c3                   	ret

0000000000001625 <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    1625:	f3 0f 1e fa          	endbr64
    1629:	55                   	push   %rbp
    162a:	48 89 e5             	mov    %rsp,%rbp
    162d:	48 83 ec 10          	sub    $0x10,%rsp
    1631:	89 7d fc             	mov    %edi,-0x4(%rbp)
    1634:	89 f0                	mov    %esi,%eax
    1636:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    1639:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    163d:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1640:	ba 01 00 00 00       	mov    $0x1,%edx
    1645:	48 89 ce             	mov    %rcx,%rsi
    1648:	89 c7                	mov    %eax,%edi
    164a:	48 b8 3b 15 00 00 00 	movabs $0x153b,%rax
    1651:	00 00 00 
    1654:	ff d0                	call   *%rax
}
    1656:	90                   	nop
    1657:	c9                   	leave
    1658:	c3                   	ret

0000000000001659 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    1659:	f3 0f 1e fa          	endbr64
    165d:	55                   	push   %rbp
    165e:	48 89 e5             	mov    %rsp,%rbp
    1661:	48 83 ec 20          	sub    $0x20,%rsp
    1665:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1668:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    166c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1673:	eb 35                	jmp    16aa <print_x64+0x51>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    1675:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1679:	48 c1 e8 3c          	shr    $0x3c,%rax
    167d:	48 ba 00 20 00 00 00 	movabs $0x2000,%rdx
    1684:	00 00 00 
    1687:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    168b:	0f be d0             	movsbl %al,%edx
    168e:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1691:	89 d6                	mov    %edx,%esi
    1693:	89 c7                	mov    %eax,%edi
    1695:	48 b8 25 16 00 00 00 	movabs $0x1625,%rax
    169c:	00 00 00 
    169f:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    16a1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    16a5:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    16aa:	8b 45 fc             	mov    -0x4(%rbp),%eax
    16ad:	83 f8 0f             	cmp    $0xf,%eax
    16b0:	76 c3                	jbe    1675 <print_x64+0x1c>
}
    16b2:	90                   	nop
    16b3:	90                   	nop
    16b4:	c9                   	leave
    16b5:	c3                   	ret

00000000000016b6 <print_x32>:

  static void
print_x32(int fd, uint x)
{
    16b6:	f3 0f 1e fa          	endbr64
    16ba:	55                   	push   %rbp
    16bb:	48 89 e5             	mov    %rsp,%rbp
    16be:	48 83 ec 20          	sub    $0x20,%rsp
    16c2:	89 7d ec             	mov    %edi,-0x14(%rbp)
    16c5:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    16c8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    16cf:	eb 36                	jmp    1707 <print_x32+0x51>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    16d1:	8b 45 e8             	mov    -0x18(%rbp),%eax
    16d4:	c1 e8 1c             	shr    $0x1c,%eax
    16d7:	89 c2                	mov    %eax,%edx
    16d9:	48 b8 00 20 00 00 00 	movabs $0x2000,%rax
    16e0:	00 00 00 
    16e3:	89 d2                	mov    %edx,%edx
    16e5:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    16e9:	0f be d0             	movsbl %al,%edx
    16ec:	8b 45 ec             	mov    -0x14(%rbp),%eax
    16ef:	89 d6                	mov    %edx,%esi
    16f1:	89 c7                	mov    %eax,%edi
    16f3:	48 b8 25 16 00 00 00 	movabs $0x1625,%rax
    16fa:	00 00 00 
    16fd:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    16ff:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1703:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    1707:	8b 45 fc             	mov    -0x4(%rbp),%eax
    170a:	83 f8 07             	cmp    $0x7,%eax
    170d:	76 c2                	jbe    16d1 <print_x32+0x1b>
}
    170f:	90                   	nop
    1710:	90                   	nop
    1711:	c9                   	leave
    1712:	c3                   	ret

0000000000001713 <print_d>:

  static void
print_d(int fd, int v)
{
    1713:	f3 0f 1e fa          	endbr64
    1717:	55                   	push   %rbp
    1718:	48 89 e5             	mov    %rsp,%rbp
    171b:	48 83 ec 30          	sub    $0x30,%rsp
    171f:	89 7d dc             	mov    %edi,-0x24(%rbp)
    1722:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    1725:	8b 45 d8             	mov    -0x28(%rbp),%eax
    1728:	48 98                	cltq
    172a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    172e:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1732:	79 04                	jns    1738 <print_d+0x25>
    x = -x;
    1734:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    1738:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    173f:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1743:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    174a:	66 66 66 
    174d:	48 89 c8             	mov    %rcx,%rax
    1750:	48 f7 ea             	imul   %rdx
    1753:	48 c1 fa 02          	sar    $0x2,%rdx
    1757:	48 89 c8             	mov    %rcx,%rax
    175a:	48 c1 f8 3f          	sar    $0x3f,%rax
    175e:	48 29 c2             	sub    %rax,%rdx
    1761:	48 89 d0             	mov    %rdx,%rax
    1764:	48 c1 e0 02          	shl    $0x2,%rax
    1768:	48 01 d0             	add    %rdx,%rax
    176b:	48 01 c0             	add    %rax,%rax
    176e:	48 29 c1             	sub    %rax,%rcx
    1771:	48 89 ca             	mov    %rcx,%rdx
    1774:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1777:	8d 48 01             	lea    0x1(%rax),%ecx
    177a:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    177d:	48 b9 00 20 00 00 00 	movabs $0x2000,%rcx
    1784:	00 00 00 
    1787:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    178b:	48 98                	cltq
    178d:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    1791:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1795:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    179c:	66 66 66 
    179f:	48 89 c8             	mov    %rcx,%rax
    17a2:	48 f7 ea             	imul   %rdx
    17a5:	48 89 d0             	mov    %rdx,%rax
    17a8:	48 c1 f8 02          	sar    $0x2,%rax
    17ac:	48 c1 f9 3f          	sar    $0x3f,%rcx
    17b0:	48 89 ca             	mov    %rcx,%rdx
    17b3:	48 29 d0             	sub    %rdx,%rax
    17b6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    17ba:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    17bf:	0f 85 7a ff ff ff    	jne    173f <print_d+0x2c>

  if (v < 0)
    17c5:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    17c9:	79 32                	jns    17fd <print_d+0xea>
    buf[i++] = '-';
    17cb:	8b 45 f4             	mov    -0xc(%rbp),%eax
    17ce:	8d 50 01             	lea    0x1(%rax),%edx
    17d1:	89 55 f4             	mov    %edx,-0xc(%rbp)
    17d4:	48 98                	cltq
    17d6:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    17db:	eb 20                	jmp    17fd <print_d+0xea>
    putc(fd, buf[i]);
    17dd:	8b 45 f4             	mov    -0xc(%rbp),%eax
    17e0:	48 98                	cltq
    17e2:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    17e7:	0f be d0             	movsbl %al,%edx
    17ea:	8b 45 dc             	mov    -0x24(%rbp),%eax
    17ed:	89 d6                	mov    %edx,%esi
    17ef:	89 c7                	mov    %eax,%edi
    17f1:	48 b8 25 16 00 00 00 	movabs $0x1625,%rax
    17f8:	00 00 00 
    17fb:	ff d0                	call   *%rax
  while (--i >= 0)
    17fd:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    1801:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1805:	79 d6                	jns    17dd <print_d+0xca>
}
    1807:	90                   	nop
    1808:	90                   	nop
    1809:	c9                   	leave
    180a:	c3                   	ret

000000000000180b <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    180b:	f3 0f 1e fa          	endbr64
    180f:	55                   	push   %rbp
    1810:	48 89 e5             	mov    %rsp,%rbp
    1813:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    181a:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    1820:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    1827:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    182e:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    1835:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    183c:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    1843:	84 c0                	test   %al,%al
    1845:	74 20                	je     1867 <printf+0x5c>
    1847:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    184b:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    184f:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    1853:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    1857:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    185b:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    185f:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    1863:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    1867:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    186e:	00 00 00 
    1871:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    1878:	00 00 00 
    187b:	48 8d 45 10          	lea    0x10(%rbp),%rax
    187f:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    1886:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    188d:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1894:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    189b:	00 00 00 
    189e:	e9 41 03 00 00       	jmp    1be4 <printf+0x3d9>
    if (c != '%') {
    18a3:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    18aa:	74 24                	je     18d0 <printf+0xc5>
      putc(fd, c);
    18ac:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    18b2:	0f be d0             	movsbl %al,%edx
    18b5:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    18bb:	89 d6                	mov    %edx,%esi
    18bd:	89 c7                	mov    %eax,%edi
    18bf:	48 b8 25 16 00 00 00 	movabs $0x1625,%rax
    18c6:	00 00 00 
    18c9:	ff d0                	call   *%rax
      continue;
    18cb:	e9 0d 03 00 00       	jmp    1bdd <printf+0x3d2>
    }
    c = fmt[++i] & 0xff;
    18d0:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    18d7:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    18dd:	48 63 d0             	movslq %eax,%rdx
    18e0:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    18e7:	48 01 d0             	add    %rdx,%rax
    18ea:	0f b6 00             	movzbl (%rax),%eax
    18ed:	0f be c0             	movsbl %al,%eax
    18f0:	25 ff 00 00 00       	and    $0xff,%eax
    18f5:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    18fb:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1902:	0f 84 0f 03 00 00    	je     1c17 <printf+0x40c>
      break;
    switch(c) {
    1908:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    190f:	0f 84 74 02 00 00    	je     1b89 <printf+0x37e>
    1915:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    191c:	0f 8c 82 02 00 00    	jl     1ba4 <printf+0x399>
    1922:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    1929:	0f 8f 75 02 00 00    	jg     1ba4 <printf+0x399>
    192f:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    1936:	0f 8c 68 02 00 00    	jl     1ba4 <printf+0x399>
    193c:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1942:	83 e8 63             	sub    $0x63,%eax
    1945:	83 f8 15             	cmp    $0x15,%eax
    1948:	0f 87 56 02 00 00    	ja     1ba4 <printf+0x399>
    194e:	89 c0                	mov    %eax,%eax
    1950:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1957:	00 
    1958:	48 b8 48 1f 00 00 00 	movabs $0x1f48,%rax
    195f:	00 00 00 
    1962:	48 01 d0             	add    %rdx,%rax
    1965:	48 8b 00             	mov    (%rax),%rax
    1968:	3e ff e0             	notrack jmp *%rax
    case 'c':
      putc(fd, va_arg(ap, int));
    196b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1971:	83 f8 2f             	cmp    $0x2f,%eax
    1974:	77 23                	ja     1999 <printf+0x18e>
    1976:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    197d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1983:	89 d2                	mov    %edx,%edx
    1985:	48 01 d0             	add    %rdx,%rax
    1988:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    198e:	83 c2 08             	add    $0x8,%edx
    1991:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1997:	eb 12                	jmp    19ab <printf+0x1a0>
    1999:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    19a0:	48 8d 50 08          	lea    0x8(%rax),%rdx
    19a4:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    19ab:	8b 00                	mov    (%rax),%eax
    19ad:	0f be d0             	movsbl %al,%edx
    19b0:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    19b6:	89 d6                	mov    %edx,%esi
    19b8:	89 c7                	mov    %eax,%edi
    19ba:	48 b8 25 16 00 00 00 	movabs $0x1625,%rax
    19c1:	00 00 00 
    19c4:	ff d0                	call   *%rax
      break;
    19c6:	e9 12 02 00 00       	jmp    1bdd <printf+0x3d2>
    case 'd':
      print_d(fd, va_arg(ap, int));
    19cb:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    19d1:	83 f8 2f             	cmp    $0x2f,%eax
    19d4:	77 23                	ja     19f9 <printf+0x1ee>
    19d6:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    19dd:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19e3:	89 d2                	mov    %edx,%edx
    19e5:	48 01 d0             	add    %rdx,%rax
    19e8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19ee:	83 c2 08             	add    $0x8,%edx
    19f1:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    19f7:	eb 12                	jmp    1a0b <printf+0x200>
    19f9:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a00:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a04:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a0b:	8b 10                	mov    (%rax),%edx
    1a0d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a13:	89 d6                	mov    %edx,%esi
    1a15:	89 c7                	mov    %eax,%edi
    1a17:	48 b8 13 17 00 00 00 	movabs $0x1713,%rax
    1a1e:	00 00 00 
    1a21:	ff d0                	call   *%rax
      break;
    1a23:	e9 b5 01 00 00       	jmp    1bdd <printf+0x3d2>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    1a28:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1a2e:	83 f8 2f             	cmp    $0x2f,%eax
    1a31:	77 23                	ja     1a56 <printf+0x24b>
    1a33:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1a3a:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a40:	89 d2                	mov    %edx,%edx
    1a42:	48 01 d0             	add    %rdx,%rax
    1a45:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a4b:	83 c2 08             	add    $0x8,%edx
    1a4e:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1a54:	eb 12                	jmp    1a68 <printf+0x25d>
    1a56:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a5d:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a61:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a68:	8b 10                	mov    (%rax),%edx
    1a6a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a70:	89 d6                	mov    %edx,%esi
    1a72:	89 c7                	mov    %eax,%edi
    1a74:	48 b8 b6 16 00 00 00 	movabs $0x16b6,%rax
    1a7b:	00 00 00 
    1a7e:	ff d0                	call   *%rax
      break;
    1a80:	e9 58 01 00 00       	jmp    1bdd <printf+0x3d2>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    1a85:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1a8b:	83 f8 2f             	cmp    $0x2f,%eax
    1a8e:	77 23                	ja     1ab3 <printf+0x2a8>
    1a90:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1a97:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a9d:	89 d2                	mov    %edx,%edx
    1a9f:	48 01 d0             	add    %rdx,%rax
    1aa2:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1aa8:	83 c2 08             	add    $0x8,%edx
    1aab:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1ab1:	eb 12                	jmp    1ac5 <printf+0x2ba>
    1ab3:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1aba:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1abe:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1ac5:	48 8b 10             	mov    (%rax),%rdx
    1ac8:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1ace:	48 89 d6             	mov    %rdx,%rsi
    1ad1:	89 c7                	mov    %eax,%edi
    1ad3:	48 b8 59 16 00 00 00 	movabs $0x1659,%rax
    1ada:	00 00 00 
    1add:	ff d0                	call   *%rax
      break;
    1adf:	e9 f9 00 00 00       	jmp    1bdd <printf+0x3d2>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    1ae4:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1aea:	83 f8 2f             	cmp    $0x2f,%eax
    1aed:	77 23                	ja     1b12 <printf+0x307>
    1aef:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1af6:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1afc:	89 d2                	mov    %edx,%edx
    1afe:	48 01 d0             	add    %rdx,%rax
    1b01:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b07:	83 c2 08             	add    $0x8,%edx
    1b0a:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1b10:	eb 12                	jmp    1b24 <printf+0x319>
    1b12:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1b19:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1b1d:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1b24:	48 8b 00             	mov    (%rax),%rax
    1b27:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    1b2e:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1b35:	00 
    1b36:	75 41                	jne    1b79 <printf+0x36e>
        s = "(null)";
    1b38:	48 b8 40 1f 00 00 00 	movabs $0x1f40,%rax
    1b3f:	00 00 00 
    1b42:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1b49:	eb 2e                	jmp    1b79 <printf+0x36e>
        putc(fd, *(s++));
    1b4b:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1b52:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1b56:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1b5d:	0f b6 00             	movzbl (%rax),%eax
    1b60:	0f be d0             	movsbl %al,%edx
    1b63:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b69:	89 d6                	mov    %edx,%esi
    1b6b:	89 c7                	mov    %eax,%edi
    1b6d:	48 b8 25 16 00 00 00 	movabs $0x1625,%rax
    1b74:	00 00 00 
    1b77:	ff d0                	call   *%rax
      while (*s)
    1b79:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1b80:	0f b6 00             	movzbl (%rax),%eax
    1b83:	84 c0                	test   %al,%al
    1b85:	75 c4                	jne    1b4b <printf+0x340>
      break;
    1b87:	eb 54                	jmp    1bdd <printf+0x3d2>
    case '%':
      putc(fd, '%');
    1b89:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b8f:	be 25 00 00 00       	mov    $0x25,%esi
    1b94:	89 c7                	mov    %eax,%edi
    1b96:	48 b8 25 16 00 00 00 	movabs $0x1625,%rax
    1b9d:	00 00 00 
    1ba0:	ff d0                	call   *%rax
      break;
    1ba2:	eb 39                	jmp    1bdd <printf+0x3d2>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1ba4:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1baa:	be 25 00 00 00       	mov    $0x25,%esi
    1baf:	89 c7                	mov    %eax,%edi
    1bb1:	48 b8 25 16 00 00 00 	movabs $0x1625,%rax
    1bb8:	00 00 00 
    1bbb:	ff d0                	call   *%rax
      putc(fd, c);
    1bbd:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1bc3:	0f be d0             	movsbl %al,%edx
    1bc6:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1bcc:	89 d6                	mov    %edx,%esi
    1bce:	89 c7                	mov    %eax,%edi
    1bd0:	48 b8 25 16 00 00 00 	movabs $0x1625,%rax
    1bd7:	00 00 00 
    1bda:	ff d0                	call   *%rax
      break;
    1bdc:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1bdd:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1be4:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1bea:	48 63 d0             	movslq %eax,%rdx
    1bed:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1bf4:	48 01 d0             	add    %rdx,%rax
    1bf7:	0f b6 00             	movzbl (%rax),%eax
    1bfa:	0f be c0             	movsbl %al,%eax
    1bfd:	25 ff 00 00 00       	and    $0xff,%eax
    1c02:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1c08:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1c0f:	0f 85 8e fc ff ff    	jne    18a3 <printf+0x98>
    }
  }
}
    1c15:	eb 01                	jmp    1c18 <printf+0x40d>
      break;
    1c17:	90                   	nop
}
    1c18:	90                   	nop
    1c19:	c9                   	leave
    1c1a:	c3                   	ret

0000000000001c1b <free>:
    1c1b:	55                   	push   %rbp
    1c1c:	48 89 e5             	mov    %rsp,%rbp
    1c1f:	48 83 ec 18          	sub    $0x18,%rsp
    1c23:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1c27:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1c2b:	48 83 e8 10          	sub    $0x10,%rax
    1c2f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1c33:	48 b8 30 20 00 00 00 	movabs $0x2030,%rax
    1c3a:	00 00 00 
    1c3d:	48 8b 00             	mov    (%rax),%rax
    1c40:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1c44:	eb 2f                	jmp    1c75 <free+0x5a>
    1c46:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c4a:	48 8b 00             	mov    (%rax),%rax
    1c4d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1c51:	72 17                	jb     1c6a <free+0x4f>
    1c53:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c57:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1c5b:	72 2f                	jb     1c8c <free+0x71>
    1c5d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c61:	48 8b 00             	mov    (%rax),%rax
    1c64:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1c68:	72 22                	jb     1c8c <free+0x71>
    1c6a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c6e:	48 8b 00             	mov    (%rax),%rax
    1c71:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1c75:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c79:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1c7d:	73 c7                	jae    1c46 <free+0x2b>
    1c7f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c83:	48 8b 00             	mov    (%rax),%rax
    1c86:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1c8a:	73 ba                	jae    1c46 <free+0x2b>
    1c8c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c90:	8b 40 08             	mov    0x8(%rax),%eax
    1c93:	89 c0                	mov    %eax,%eax
    1c95:	48 c1 e0 04          	shl    $0x4,%rax
    1c99:	48 89 c2             	mov    %rax,%rdx
    1c9c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ca0:	48 01 c2             	add    %rax,%rdx
    1ca3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ca7:	48 8b 00             	mov    (%rax),%rax
    1caa:	48 39 c2             	cmp    %rax,%rdx
    1cad:	75 2d                	jne    1cdc <free+0xc1>
    1caf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cb3:	8b 50 08             	mov    0x8(%rax),%edx
    1cb6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cba:	48 8b 00             	mov    (%rax),%rax
    1cbd:	8b 40 08             	mov    0x8(%rax),%eax
    1cc0:	01 c2                	add    %eax,%edx
    1cc2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cc6:	89 50 08             	mov    %edx,0x8(%rax)
    1cc9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ccd:	48 8b 00             	mov    (%rax),%rax
    1cd0:	48 8b 10             	mov    (%rax),%rdx
    1cd3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cd7:	48 89 10             	mov    %rdx,(%rax)
    1cda:	eb 0e                	jmp    1cea <free+0xcf>
    1cdc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ce0:	48 8b 10             	mov    (%rax),%rdx
    1ce3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ce7:	48 89 10             	mov    %rdx,(%rax)
    1cea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cee:	8b 40 08             	mov    0x8(%rax),%eax
    1cf1:	89 c0                	mov    %eax,%eax
    1cf3:	48 c1 e0 04          	shl    $0x4,%rax
    1cf7:	48 89 c2             	mov    %rax,%rdx
    1cfa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cfe:	48 01 d0             	add    %rdx,%rax
    1d01:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1d05:	75 27                	jne    1d2e <free+0x113>
    1d07:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d0b:	8b 50 08             	mov    0x8(%rax),%edx
    1d0e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d12:	8b 40 08             	mov    0x8(%rax),%eax
    1d15:	01 c2                	add    %eax,%edx
    1d17:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d1b:	89 50 08             	mov    %edx,0x8(%rax)
    1d1e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d22:	48 8b 10             	mov    (%rax),%rdx
    1d25:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d29:	48 89 10             	mov    %rdx,(%rax)
    1d2c:	eb 0b                	jmp    1d39 <free+0x11e>
    1d2e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d32:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1d36:	48 89 10             	mov    %rdx,(%rax)
    1d39:	48 ba 30 20 00 00 00 	movabs $0x2030,%rdx
    1d40:	00 00 00 
    1d43:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d47:	48 89 02             	mov    %rax,(%rdx)
    1d4a:	90                   	nop
    1d4b:	c9                   	leave
    1d4c:	c3                   	ret

0000000000001d4d <morecore>:
    1d4d:	55                   	push   %rbp
    1d4e:	48 89 e5             	mov    %rsp,%rbp
    1d51:	48 83 ec 20          	sub    $0x20,%rsp
    1d55:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1d58:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1d5f:	77 07                	ja     1d68 <morecore+0x1b>
    1d61:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
    1d68:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1d6b:	48 c1 e0 04          	shl    $0x4,%rax
    1d6f:	48 89 c7             	mov    %rax,%rdi
    1d72:	48 b8 e4 15 00 00 00 	movabs $0x15e4,%rax
    1d79:	00 00 00 
    1d7c:	ff d0                	call   *%rax
    1d7e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1d82:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1d87:	75 07                	jne    1d90 <morecore+0x43>
    1d89:	b8 00 00 00 00       	mov    $0x0,%eax
    1d8e:	eb 36                	jmp    1dc6 <morecore+0x79>
    1d90:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d94:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1d98:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d9c:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1d9f:	89 50 08             	mov    %edx,0x8(%rax)
    1da2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1da6:	48 83 c0 10          	add    $0x10,%rax
    1daa:	48 89 c7             	mov    %rax,%rdi
    1dad:	48 b8 1b 1c 00 00 00 	movabs $0x1c1b,%rax
    1db4:	00 00 00 
    1db7:	ff d0                	call   *%rax
    1db9:	48 b8 30 20 00 00 00 	movabs $0x2030,%rax
    1dc0:	00 00 00 
    1dc3:	48 8b 00             	mov    (%rax),%rax
    1dc6:	c9                   	leave
    1dc7:	c3                   	ret

0000000000001dc8 <malloc>:
    1dc8:	55                   	push   %rbp
    1dc9:	48 89 e5             	mov    %rsp,%rbp
    1dcc:	48 83 ec 30          	sub    $0x30,%rsp
    1dd0:	89 7d dc             	mov    %edi,-0x24(%rbp)
    1dd3:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1dd6:	48 83 c0 0f          	add    $0xf,%rax
    1dda:	48 c1 e8 04          	shr    $0x4,%rax
    1dde:	83 c0 01             	add    $0x1,%eax
    1de1:	89 45 ec             	mov    %eax,-0x14(%rbp)
    1de4:	48 b8 30 20 00 00 00 	movabs $0x2030,%rax
    1deb:	00 00 00 
    1dee:	48 8b 00             	mov    (%rax),%rax
    1df1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1df5:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1dfa:	75 4a                	jne    1e46 <malloc+0x7e>
    1dfc:	48 b8 20 20 00 00 00 	movabs $0x2020,%rax
    1e03:	00 00 00 
    1e06:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1e0a:	48 ba 30 20 00 00 00 	movabs $0x2030,%rdx
    1e11:	00 00 00 
    1e14:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e18:	48 89 02             	mov    %rax,(%rdx)
    1e1b:	48 b8 30 20 00 00 00 	movabs $0x2030,%rax
    1e22:	00 00 00 
    1e25:	48 8b 00             	mov    (%rax),%rax
    1e28:	48 ba 20 20 00 00 00 	movabs $0x2020,%rdx
    1e2f:	00 00 00 
    1e32:	48 89 02             	mov    %rax,(%rdx)
    1e35:	48 b8 20 20 00 00 00 	movabs $0x2020,%rax
    1e3c:	00 00 00 
    1e3f:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
    1e46:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e4a:	48 8b 00             	mov    (%rax),%rax
    1e4d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1e51:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e55:	8b 40 08             	mov    0x8(%rax),%eax
    1e58:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1e5b:	72 65                	jb     1ec2 <malloc+0xfa>
    1e5d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e61:	8b 40 08             	mov    0x8(%rax),%eax
    1e64:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1e67:	75 10                	jne    1e79 <malloc+0xb1>
    1e69:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e6d:	48 8b 10             	mov    (%rax),%rdx
    1e70:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e74:	48 89 10             	mov    %rdx,(%rax)
    1e77:	eb 2e                	jmp    1ea7 <malloc+0xdf>
    1e79:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e7d:	8b 40 08             	mov    0x8(%rax),%eax
    1e80:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1e83:	89 c2                	mov    %eax,%edx
    1e85:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e89:	89 50 08             	mov    %edx,0x8(%rax)
    1e8c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e90:	8b 40 08             	mov    0x8(%rax),%eax
    1e93:	89 c0                	mov    %eax,%eax
    1e95:	48 c1 e0 04          	shl    $0x4,%rax
    1e99:	48 01 45 f8          	add    %rax,-0x8(%rbp)
    1e9d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ea1:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1ea4:	89 50 08             	mov    %edx,0x8(%rax)
    1ea7:	48 ba 30 20 00 00 00 	movabs $0x2030,%rdx
    1eae:	00 00 00 
    1eb1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1eb5:	48 89 02             	mov    %rax,(%rdx)
    1eb8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ebc:	48 83 c0 10          	add    $0x10,%rax
    1ec0:	eb 4e                	jmp    1f10 <malloc+0x148>
    1ec2:	48 b8 30 20 00 00 00 	movabs $0x2030,%rax
    1ec9:	00 00 00 
    1ecc:	48 8b 00             	mov    (%rax),%rax
    1ecf:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1ed3:	75 23                	jne    1ef8 <malloc+0x130>
    1ed5:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1ed8:	89 c7                	mov    %eax,%edi
    1eda:	48 b8 4d 1d 00 00 00 	movabs $0x1d4d,%rax
    1ee1:	00 00 00 
    1ee4:	ff d0                	call   *%rax
    1ee6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1eea:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1eef:	75 07                	jne    1ef8 <malloc+0x130>
    1ef1:	b8 00 00 00 00       	mov    $0x0,%eax
    1ef6:	eb 18                	jmp    1f10 <malloc+0x148>
    1ef8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1efc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1f00:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f04:	48 8b 00             	mov    (%rax),%rax
    1f07:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1f0b:	e9 41 ff ff ff       	jmp    1e51 <malloc+0x89>
    1f10:	c9                   	leave
    1f11:	c3                   	ret
