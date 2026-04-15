
_wc:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <wc>:
    1000:	55                   	push   %rbp
    1001:	48 89 e5             	mov    %rsp,%rbp
    1004:	48 83 ec 30          	sub    $0x30,%rsp
    1008:	89 7d dc             	mov    %edi,-0x24(%rbp)
    100b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
    100f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
    1016:	8b 45 f0             	mov    -0x10(%rbp),%eax
    1019:	89 45 f4             	mov    %eax,-0xc(%rbp)
    101c:	8b 45 f4             	mov    -0xc(%rbp),%eax
    101f:	89 45 f8             	mov    %eax,-0x8(%rbp)
    1022:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    1029:	e9 84 00 00 00       	jmp    10b2 <wc+0xb2>
    102e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1035:	eb 73                	jmp    10aa <wc+0xaa>
    1037:	83 45 f0 01          	addl   $0x1,-0x10(%rbp)
    103b:	48 ba e0 20 00 00 00 	movabs $0x20e0,%rdx
    1042:	00 00 00 
    1045:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1048:	48 98                	cltq
    104a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    104e:	3c 0a                	cmp    $0xa,%al
    1050:	75 04                	jne    1056 <wc+0x56>
    1052:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    1056:	48 ba e0 20 00 00 00 	movabs $0x20e0,%rdx
    105d:	00 00 00 
    1060:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1063:	48 98                	cltq
    1065:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1069:	0f be c0             	movsbl %al,%eax
    106c:	48 ba c0 1f 00 00 00 	movabs $0x1fc0,%rdx
    1073:	00 00 00 
    1076:	89 c6                	mov    %eax,%esi
    1078:	48 89 d7             	mov    %rdx,%rdi
    107b:	48 b8 b7 13 00 00 00 	movabs $0x13b7,%rax
    1082:	00 00 00 
    1085:	ff d0                	call   *%rax
    1087:	48 85 c0             	test   %rax,%rax
    108a:	74 09                	je     1095 <wc+0x95>
    108c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    1093:	eb 11                	jmp    10a6 <wc+0xa6>
    1095:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
    1099:	75 0b                	jne    10a6 <wc+0xa6>
    109b:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
    109f:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%rbp)
    10a6:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    10aa:	8b 45 fc             	mov    -0x4(%rbp),%eax
    10ad:	3b 45 e8             	cmp    -0x18(%rbp),%eax
    10b0:	7c 85                	jl     1037 <wc+0x37>
    10b2:	48 b9 e0 20 00 00 00 	movabs $0x20e0,%rcx
    10b9:	00 00 00 
    10bc:	8b 45 dc             	mov    -0x24(%rbp),%eax
    10bf:	ba 00 02 00 00       	mov    $0x200,%edx
    10c4:	48 89 ce             	mov    %rcx,%rsi
    10c7:	89 c7                	mov    %eax,%edi
    10c9:	48 b8 dc 15 00 00 00 	movabs $0x15dc,%rax
    10d0:	00 00 00 
    10d3:	ff d0                	call   *%rax
    10d5:	89 45 e8             	mov    %eax,-0x18(%rbp)
    10d8:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
    10dc:	0f 8f 4c ff ff ff    	jg     102e <wc+0x2e>
    10e2:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
    10e6:	79 2f                	jns    1117 <wc+0x117>
    10e8:	48 b8 c6 1f 00 00 00 	movabs $0x1fc6,%rax
    10ef:	00 00 00 
    10f2:	48 89 c6             	mov    %rax,%rsi
    10f5:	bf 01 00 00 00       	mov    $0x1,%edi
    10fa:	b8 00 00 00 00       	mov    $0x0,%eax
    10ff:	48 ba b9 18 00 00 00 	movabs $0x18b9,%rdx
    1106:	00 00 00 
    1109:	ff d2                	call   *%rdx
    110b:	48 b8 b5 15 00 00 00 	movabs $0x15b5,%rax
    1112:	00 00 00 
    1115:	ff d0                	call   *%rax
    1117:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
    111b:	8b 4d f0             	mov    -0x10(%rbp),%ecx
    111e:	8b 55 f4             	mov    -0xc(%rbp),%edx
    1121:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1124:	48 be d6 1f 00 00 00 	movabs $0x1fd6,%rsi
    112b:	00 00 00 
    112e:	49 89 f9             	mov    %rdi,%r9
    1131:	41 89 c8             	mov    %ecx,%r8d
    1134:	89 d1                	mov    %edx,%ecx
    1136:	89 c2                	mov    %eax,%edx
    1138:	bf 01 00 00 00       	mov    $0x1,%edi
    113d:	b8 00 00 00 00       	mov    $0x0,%eax
    1142:	49 ba b9 18 00 00 00 	movabs $0x18b9,%r10
    1149:	00 00 00 
    114c:	41 ff d2             	call   *%r10
    114f:	90                   	nop
    1150:	c9                   	leave
    1151:	c3                   	ret

0000000000001152 <main>:
    1152:	55                   	push   %rbp
    1153:	48 89 e5             	mov    %rsp,%rbp
    1156:	48 83 ec 20          	sub    $0x20,%rsp
    115a:	89 7d ec             	mov    %edi,-0x14(%rbp)
    115d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    1161:	83 7d ec 01          	cmpl   $0x1,-0x14(%rbp)
    1165:	7f 2a                	jg     1191 <main+0x3f>
    1167:	48 b8 e3 1f 00 00 00 	movabs $0x1fe3,%rax
    116e:	00 00 00 
    1171:	48 89 c6             	mov    %rax,%rsi
    1174:	bf 00 00 00 00       	mov    $0x0,%edi
    1179:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1180:	00 00 00 
    1183:	ff d0                	call   *%rax
    1185:	48 b8 b5 15 00 00 00 	movabs $0x15b5,%rax
    118c:	00 00 00 
    118f:	ff d0                	call   *%rax
    1191:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
    1198:	e9 bd 00 00 00       	jmp    125a <main+0x108>
    119d:	8b 45 fc             	mov    -0x4(%rbp),%eax
    11a0:	48 98                	cltq
    11a2:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    11a9:	00 
    11aa:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    11ae:	48 01 d0             	add    %rdx,%rax
    11b1:	48 8b 00             	mov    (%rax),%rax
    11b4:	be 00 00 00 00       	mov    $0x0,%esi
    11b9:	48 89 c7             	mov    %rax,%rdi
    11bc:	48 b8 1d 16 00 00 00 	movabs $0x161d,%rax
    11c3:	00 00 00 
    11c6:	ff d0                	call   *%rax
    11c8:	89 45 f8             	mov    %eax,-0x8(%rbp)
    11cb:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    11cf:	79 49                	jns    121a <main+0xc8>
    11d1:	8b 45 fc             	mov    -0x4(%rbp),%eax
    11d4:	48 98                	cltq
    11d6:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    11dd:	00 
    11de:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    11e2:	48 01 d0             	add    %rdx,%rax
    11e5:	48 8b 00             	mov    (%rax),%rax
    11e8:	48 b9 e4 1f 00 00 00 	movabs $0x1fe4,%rcx
    11ef:	00 00 00 
    11f2:	48 89 c2             	mov    %rax,%rdx
    11f5:	48 89 ce             	mov    %rcx,%rsi
    11f8:	bf 01 00 00 00       	mov    $0x1,%edi
    11fd:	b8 00 00 00 00       	mov    $0x0,%eax
    1202:	48 b9 b9 18 00 00 00 	movabs $0x18b9,%rcx
    1209:	00 00 00 
    120c:	ff d1                	call   *%rcx
    120e:	48 b8 b5 15 00 00 00 	movabs $0x15b5,%rax
    1215:	00 00 00 
    1218:	ff d0                	call   *%rax
    121a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    121d:	48 98                	cltq
    121f:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1226:	00 
    1227:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    122b:	48 01 d0             	add    %rdx,%rax
    122e:	48 8b 10             	mov    (%rax),%rdx
    1231:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1234:	48 89 d6             	mov    %rdx,%rsi
    1237:	89 c7                	mov    %eax,%edi
    1239:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1240:	00 00 00 
    1243:	ff d0                	call   *%rax
    1245:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1248:	89 c7                	mov    %eax,%edi
    124a:	48 b8 f6 15 00 00 00 	movabs $0x15f6,%rax
    1251:	00 00 00 
    1254:	ff d0                	call   *%rax
    1256:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    125a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    125d:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1260:	0f 8c 37 ff ff ff    	jl     119d <main+0x4b>
    1266:	48 b8 b5 15 00 00 00 	movabs $0x15b5,%rax
    126d:	00 00 00 
    1270:	ff d0                	call   *%rax

0000000000001272 <stosb>:
  stosb(dst, c, n);
  return dst;
}

char*
strchr(const char *s, char c)
    1272:	f3 0f 1e fa          	endbr64
    1276:	55                   	push   %rbp
    1277:	48 89 e5             	mov    %rsp,%rbp
    127a:	48 83 ec 10          	sub    $0x10,%rsp
    127e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1282:	89 75 f4             	mov    %esi,-0xc(%rbp)
    1285:	89 55 f0             	mov    %edx,-0x10(%rbp)
{
    1288:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    128c:	8b 55 f0             	mov    -0x10(%rbp),%edx
    128f:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1292:	48 89 ce             	mov    %rcx,%rsi
    1295:	48 89 f7             	mov    %rsi,%rdi
    1298:	89 d1                	mov    %edx,%ecx
    129a:	fc                   	cld
    129b:	f3 aa                	rep stos %al,%es:(%rdi)
    129d:	89 ca                	mov    %ecx,%edx
    129f:	48 89 fe             	mov    %rdi,%rsi
    12a2:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    12a6:	89 55 f0             	mov    %edx,-0x10(%rbp)
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
    12a9:	90                   	nop
    12aa:	c9                   	leave
    12ab:	c3                   	ret

00000000000012ac <strcpy>:
{
    12ac:	f3 0f 1e fa          	endbr64
    12b0:	55                   	push   %rbp
    12b1:	48 89 e5             	mov    %rsp,%rbp
    12b4:	48 83 ec 20          	sub    $0x20,%rsp
    12b8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    12bc:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  os = s;
    12c0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12c4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    12c8:	90                   	nop
    12c9:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    12cd:	48 8d 42 01          	lea    0x1(%rdx),%rax
    12d1:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    12d5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12d9:	48 8d 48 01          	lea    0x1(%rax),%rcx
    12dd:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    12e1:	0f b6 12             	movzbl (%rdx),%edx
    12e4:	88 10                	mov    %dl,(%rax)
    12e6:	0f b6 00             	movzbl (%rax),%eax
    12e9:	84 c0                	test   %al,%al
    12eb:	75 dc                	jne    12c9 <strcpy+0x1d>
  return os;
    12ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    12f1:	c9                   	leave
    12f2:	c3                   	ret

00000000000012f3 <strcmp>:
{
    12f3:	f3 0f 1e fa          	endbr64
    12f7:	55                   	push   %rbp
    12f8:	48 89 e5             	mov    %rsp,%rbp
    12fb:	48 83 ec 10          	sub    $0x10,%rsp
    12ff:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1303:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    1307:	eb 0a                	jmp    1313 <strcmp+0x20>
    p++, q++;
    1309:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    130e:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    1313:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1317:	0f b6 00             	movzbl (%rax),%eax
    131a:	84 c0                	test   %al,%al
    131c:	74 12                	je     1330 <strcmp+0x3d>
    131e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1322:	0f b6 10             	movzbl (%rax),%edx
    1325:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1329:	0f b6 00             	movzbl (%rax),%eax
    132c:	38 c2                	cmp    %al,%dl
    132e:	74 d9                	je     1309 <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
    1330:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1334:	0f b6 00             	movzbl (%rax),%eax
    1337:	0f b6 d0             	movzbl %al,%edx
    133a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    133e:	0f b6 00             	movzbl (%rax),%eax
    1341:	0f b6 c0             	movzbl %al,%eax
    1344:	29 c2                	sub    %eax,%edx
    1346:	89 d0                	mov    %edx,%eax
}
    1348:	c9                   	leave
    1349:	c3                   	ret

000000000000134a <strlen>:
{
    134a:	f3 0f 1e fa          	endbr64
    134e:	55                   	push   %rbp
    134f:	48 89 e5             	mov    %rsp,%rbp
    1352:	48 83 ec 18          	sub    $0x18,%rsp
    1356:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  for(n = 0; s[n]; n++)
    135a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1361:	eb 04                	jmp    1367 <strlen+0x1d>
    1363:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1367:	8b 45 fc             	mov    -0x4(%rbp),%eax
    136a:	48 63 d0             	movslq %eax,%rdx
    136d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1371:	48 01 d0             	add    %rdx,%rax
    1374:	0f b6 00             	movzbl (%rax),%eax
    1377:	84 c0                	test   %al,%al
    1379:	75 e8                	jne    1363 <strlen+0x19>
  return n;
    137b:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    137e:	c9                   	leave
    137f:	c3                   	ret

0000000000001380 <memset>:
{
    1380:	f3 0f 1e fa          	endbr64
    1384:	55                   	push   %rbp
    1385:	48 89 e5             	mov    %rsp,%rbp
    1388:	48 83 ec 10          	sub    $0x10,%rsp
    138c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1390:	89 75 f4             	mov    %esi,-0xc(%rbp)
    1393:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    1396:	8b 55 f0             	mov    -0x10(%rbp),%edx
    1399:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    139c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13a0:	89 ce                	mov    %ecx,%esi
    13a2:	48 89 c7             	mov    %rax,%rdi
    13a5:	48 b8 72 12 00 00 00 	movabs $0x1272,%rax
    13ac:	00 00 00 
    13af:	ff d0                	call   *%rax
  return dst;
    13b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    13b5:	c9                   	leave
    13b6:	c3                   	ret

00000000000013b7 <strchr>:
{
    13b7:	f3 0f 1e fa          	endbr64
    13bb:	55                   	push   %rbp
    13bc:	48 89 e5             	mov    %rsp,%rbp
    13bf:	48 83 ec 10          	sub    $0x10,%rsp
    13c3:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    13c7:	89 f0                	mov    %esi,%eax
    13c9:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    13cc:	eb 17                	jmp    13e5 <strchr+0x2e>
    if(*s == c)
    13ce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13d2:	0f b6 00             	movzbl (%rax),%eax
    13d5:	38 45 f4             	cmp    %al,-0xc(%rbp)
    13d8:	75 06                	jne    13e0 <strchr+0x29>
      return (char*)s;
    13da:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13de:	eb 15                	jmp    13f5 <strchr+0x3e>
  for(; *s; s++)
    13e0:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    13e5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13e9:	0f b6 00             	movzbl (%rax),%eax
    13ec:	84 c0                	test   %al,%al
    13ee:	75 de                	jne    13ce <strchr+0x17>
  return 0;
    13f0:	b8 00 00 00 00       	mov    $0x0,%eax
}
    13f5:	c9                   	leave
    13f6:	c3                   	ret

00000000000013f7 <gets>:

char*
gets(char *buf, int max)
{
    13f7:	f3 0f 1e fa          	endbr64
    13fb:	55                   	push   %rbp
    13fc:	48 89 e5             	mov    %rsp,%rbp
    13ff:	48 83 ec 20          	sub    $0x20,%rsp
    1403:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1407:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    140a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1411:	eb 4f                	jmp    1462 <gets+0x6b>
    cc = read(0, &c, 1);
    1413:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    1417:	ba 01 00 00 00       	mov    $0x1,%edx
    141c:	48 89 c6             	mov    %rax,%rsi
    141f:	bf 00 00 00 00       	mov    $0x0,%edi
    1424:	48 b8 dc 15 00 00 00 	movabs $0x15dc,%rax
    142b:	00 00 00 
    142e:	ff d0                	call   *%rax
    1430:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    1433:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1437:	7e 36                	jle    146f <gets+0x78>
      break;
    buf[i++] = c;
    1439:	8b 45 fc             	mov    -0x4(%rbp),%eax
    143c:	8d 50 01             	lea    0x1(%rax),%edx
    143f:	89 55 fc             	mov    %edx,-0x4(%rbp)
    1442:	48 63 d0             	movslq %eax,%rdx
    1445:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1449:	48 01 c2             	add    %rax,%rdx
    144c:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1450:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    1452:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1456:	3c 0a                	cmp    $0xa,%al
    1458:	74 16                	je     1470 <gets+0x79>
    145a:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    145e:	3c 0d                	cmp    $0xd,%al
    1460:	74 0e                	je     1470 <gets+0x79>
  for(i=0; i+1 < max; ){
    1462:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1465:	83 c0 01             	add    $0x1,%eax
    1468:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    146b:	7f a6                	jg     1413 <gets+0x1c>
    146d:	eb 01                	jmp    1470 <gets+0x79>
      break;
    146f:	90                   	nop
      break;
  }
  buf[i] = '\0';
    1470:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1473:	48 63 d0             	movslq %eax,%rdx
    1476:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    147a:	48 01 d0             	add    %rdx,%rax
    147d:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    1480:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    1484:	c9                   	leave
    1485:	c3                   	ret

0000000000001486 <stat>:

int
stat(char *n, struct stat *st)
{
    1486:	f3 0f 1e fa          	endbr64
    148a:	55                   	push   %rbp
    148b:	48 89 e5             	mov    %rsp,%rbp
    148e:	48 83 ec 20          	sub    $0x20,%rsp
    1492:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1496:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    149a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    149e:	be 00 00 00 00       	mov    $0x0,%esi
    14a3:	48 89 c7             	mov    %rax,%rdi
    14a6:	48 b8 1d 16 00 00 00 	movabs $0x161d,%rax
    14ad:	00 00 00 
    14b0:	ff d0                	call   *%rax
    14b2:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    14b5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    14b9:	79 07                	jns    14c2 <stat+0x3c>
    return -1;
    14bb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    14c0:	eb 2f                	jmp    14f1 <stat+0x6b>
  r = fstat(fd, st);
    14c2:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    14c6:	8b 45 fc             	mov    -0x4(%rbp),%eax
    14c9:	48 89 d6             	mov    %rdx,%rsi
    14cc:	89 c7                	mov    %eax,%edi
    14ce:	48 b8 44 16 00 00 00 	movabs $0x1644,%rax
    14d5:	00 00 00 
    14d8:	ff d0                	call   *%rax
    14da:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    14dd:	8b 45 fc             	mov    -0x4(%rbp),%eax
    14e0:	89 c7                	mov    %eax,%edi
    14e2:	48 b8 f6 15 00 00 00 	movabs $0x15f6,%rax
    14e9:	00 00 00 
    14ec:	ff d0                	call   *%rax
  return r;
    14ee:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    14f1:	c9                   	leave
    14f2:	c3                   	ret

00000000000014f3 <atoi>:

int
atoi(const char *s)
{
    14f3:	f3 0f 1e fa          	endbr64
    14f7:	55                   	push   %rbp
    14f8:	48 89 e5             	mov    %rsp,%rbp
    14fb:	48 83 ec 18          	sub    $0x18,%rsp
    14ff:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    1503:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    150a:	eb 28                	jmp    1534 <atoi+0x41>
    n = n*10 + *s++ - '0';
    150c:	8b 55 fc             	mov    -0x4(%rbp),%edx
    150f:	89 d0                	mov    %edx,%eax
    1511:	c1 e0 02             	shl    $0x2,%eax
    1514:	01 d0                	add    %edx,%eax
    1516:	01 c0                	add    %eax,%eax
    1518:	89 c1                	mov    %eax,%ecx
    151a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    151e:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1522:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    1526:	0f b6 00             	movzbl (%rax),%eax
    1529:	0f be c0             	movsbl %al,%eax
    152c:	01 c8                	add    %ecx,%eax
    152e:	83 e8 30             	sub    $0x30,%eax
    1531:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1534:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1538:	0f b6 00             	movzbl (%rax),%eax
    153b:	3c 2f                	cmp    $0x2f,%al
    153d:	7e 0b                	jle    154a <atoi+0x57>
    153f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1543:	0f b6 00             	movzbl (%rax),%eax
    1546:	3c 39                	cmp    $0x39,%al
    1548:	7e c2                	jle    150c <atoi+0x19>
  return n;
    154a:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    154d:	c9                   	leave
    154e:	c3                   	ret

000000000000154f <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    154f:	f3 0f 1e fa          	endbr64
    1553:	55                   	push   %rbp
    1554:	48 89 e5             	mov    %rsp,%rbp
    1557:	48 83 ec 28          	sub    $0x28,%rsp
    155b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    155f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    1563:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    1566:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    156a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    156e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1572:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    1576:	eb 1d                	jmp    1595 <memmove+0x46>
    *dst++ = *src++;
    1578:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    157c:	48 8d 42 01          	lea    0x1(%rdx),%rax
    1580:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1584:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1588:	48 8d 48 01          	lea    0x1(%rax),%rcx
    158c:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    1590:	0f b6 12             	movzbl (%rdx),%edx
    1593:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    1595:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1598:	8d 50 ff             	lea    -0x1(%rax),%edx
    159b:	89 55 dc             	mov    %edx,-0x24(%rbp)
    159e:	85 c0                	test   %eax,%eax
    15a0:	7f d6                	jg     1578 <memmove+0x29>
  return vdst;
    15a2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    15a6:	c9                   	leave
    15a7:	c3                   	ret

00000000000015a8 <fork>:
    15a8:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    15af:	49 89 ca             	mov    %rcx,%r10
    15b2:	0f 05                	syscall
    15b4:	c3                   	ret

00000000000015b5 <exit>:
    15b5:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    15bc:	49 89 ca             	mov    %rcx,%r10
    15bf:	0f 05                	syscall
    15c1:	c3                   	ret

00000000000015c2 <wait>:
    15c2:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    15c9:	49 89 ca             	mov    %rcx,%r10
    15cc:	0f 05                	syscall
    15ce:	c3                   	ret

00000000000015cf <pipe>:
    15cf:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    15d6:	49 89 ca             	mov    %rcx,%r10
    15d9:	0f 05                	syscall
    15db:	c3                   	ret

00000000000015dc <read>:
    15dc:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    15e3:	49 89 ca             	mov    %rcx,%r10
    15e6:	0f 05                	syscall
    15e8:	c3                   	ret

00000000000015e9 <write>:
    15e9:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    15f0:	49 89 ca             	mov    %rcx,%r10
    15f3:	0f 05                	syscall
    15f5:	c3                   	ret

00000000000015f6 <close>:
    15f6:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    15fd:	49 89 ca             	mov    %rcx,%r10
    1600:	0f 05                	syscall
    1602:	c3                   	ret

0000000000001603 <kill>:
    1603:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    160a:	49 89 ca             	mov    %rcx,%r10
    160d:	0f 05                	syscall
    160f:	c3                   	ret

0000000000001610 <exec>:
    1610:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    1617:	49 89 ca             	mov    %rcx,%r10
    161a:	0f 05                	syscall
    161c:	c3                   	ret

000000000000161d <open>:
    161d:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    1624:	49 89 ca             	mov    %rcx,%r10
    1627:	0f 05                	syscall
    1629:	c3                   	ret

000000000000162a <mknod>:
    162a:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    1631:	49 89 ca             	mov    %rcx,%r10
    1634:	0f 05                	syscall
    1636:	c3                   	ret

0000000000001637 <unlink>:
    1637:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    163e:	49 89 ca             	mov    %rcx,%r10
    1641:	0f 05                	syscall
    1643:	c3                   	ret

0000000000001644 <fstat>:
    1644:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    164b:	49 89 ca             	mov    %rcx,%r10
    164e:	0f 05                	syscall
    1650:	c3                   	ret

0000000000001651 <link>:
    1651:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    1658:	49 89 ca             	mov    %rcx,%r10
    165b:	0f 05                	syscall
    165d:	c3                   	ret

000000000000165e <mkdir>:
    165e:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    1665:	49 89 ca             	mov    %rcx,%r10
    1668:	0f 05                	syscall
    166a:	c3                   	ret

000000000000166b <chdir>:
    166b:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    1672:	49 89 ca             	mov    %rcx,%r10
    1675:	0f 05                	syscall
    1677:	c3                   	ret

0000000000001678 <dup>:
    1678:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    167f:	49 89 ca             	mov    %rcx,%r10
    1682:	0f 05                	syscall
    1684:	c3                   	ret

0000000000001685 <getpid>:
    1685:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    168c:	49 89 ca             	mov    %rcx,%r10
    168f:	0f 05                	syscall
    1691:	c3                   	ret

0000000000001692 <sbrk>:
    1692:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    1699:	49 89 ca             	mov    %rcx,%r10
    169c:	0f 05                	syscall
    169e:	c3                   	ret

000000000000169f <sleep>:
    169f:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    16a6:	49 89 ca             	mov    %rcx,%r10
    16a9:	0f 05                	syscall
    16ab:	c3                   	ret

00000000000016ac <uptime>:
    16ac:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    16b3:	49 89 ca             	mov    %rcx,%r10
    16b6:	0f 05                	syscall
    16b8:	c3                   	ret

00000000000016b9 <send>:
    16b9:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    16c0:	49 89 ca             	mov    %rcx,%r10
    16c3:	0f 05                	syscall
    16c5:	c3                   	ret

00000000000016c6 <recv>:
    16c6:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    16cd:	49 89 ca             	mov    %rcx,%r10
    16d0:	0f 05                	syscall
    16d2:	c3                   	ret

00000000000016d3 <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    16d3:	f3 0f 1e fa          	endbr64
    16d7:	55                   	push   %rbp
    16d8:	48 89 e5             	mov    %rsp,%rbp
    16db:	48 83 ec 10          	sub    $0x10,%rsp
    16df:	89 7d fc             	mov    %edi,-0x4(%rbp)
    16e2:	89 f0                	mov    %esi,%eax
    16e4:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    16e7:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    16eb:	8b 45 fc             	mov    -0x4(%rbp),%eax
    16ee:	ba 01 00 00 00       	mov    $0x1,%edx
    16f3:	48 89 ce             	mov    %rcx,%rsi
    16f6:	89 c7                	mov    %eax,%edi
    16f8:	48 b8 e9 15 00 00 00 	movabs $0x15e9,%rax
    16ff:	00 00 00 
    1702:	ff d0                	call   *%rax
}
    1704:	90                   	nop
    1705:	c9                   	leave
    1706:	c3                   	ret

0000000000001707 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    1707:	f3 0f 1e fa          	endbr64
    170b:	55                   	push   %rbp
    170c:	48 89 e5             	mov    %rsp,%rbp
    170f:	48 83 ec 20          	sub    $0x20,%rsp
    1713:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1716:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    171a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1721:	eb 35                	jmp    1758 <print_x64+0x51>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    1723:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1727:	48 c1 e8 3c          	shr    $0x3c,%rax
    172b:	48 ba b0 20 00 00 00 	movabs $0x20b0,%rdx
    1732:	00 00 00 
    1735:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1739:	0f be d0             	movsbl %al,%edx
    173c:	8b 45 ec             	mov    -0x14(%rbp),%eax
    173f:	89 d6                	mov    %edx,%esi
    1741:	89 c7                	mov    %eax,%edi
    1743:	48 b8 d3 16 00 00 00 	movabs $0x16d3,%rax
    174a:	00 00 00 
    174d:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    174f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1753:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    1758:	8b 45 fc             	mov    -0x4(%rbp),%eax
    175b:	83 f8 0f             	cmp    $0xf,%eax
    175e:	76 c3                	jbe    1723 <print_x64+0x1c>
}
    1760:	90                   	nop
    1761:	90                   	nop
    1762:	c9                   	leave
    1763:	c3                   	ret

0000000000001764 <print_x32>:

  static void
print_x32(int fd, uint x)
{
    1764:	f3 0f 1e fa          	endbr64
    1768:	55                   	push   %rbp
    1769:	48 89 e5             	mov    %rsp,%rbp
    176c:	48 83 ec 20          	sub    $0x20,%rsp
    1770:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1773:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1776:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    177d:	eb 36                	jmp    17b5 <print_x32+0x51>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    177f:	8b 45 e8             	mov    -0x18(%rbp),%eax
    1782:	c1 e8 1c             	shr    $0x1c,%eax
    1785:	89 c2                	mov    %eax,%edx
    1787:	48 b8 b0 20 00 00 00 	movabs $0x20b0,%rax
    178e:	00 00 00 
    1791:	89 d2                	mov    %edx,%edx
    1793:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    1797:	0f be d0             	movsbl %al,%edx
    179a:	8b 45 ec             	mov    -0x14(%rbp),%eax
    179d:	89 d6                	mov    %edx,%esi
    179f:	89 c7                	mov    %eax,%edi
    17a1:	48 b8 d3 16 00 00 00 	movabs $0x16d3,%rax
    17a8:	00 00 00 
    17ab:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    17ad:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    17b1:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    17b5:	8b 45 fc             	mov    -0x4(%rbp),%eax
    17b8:	83 f8 07             	cmp    $0x7,%eax
    17bb:	76 c2                	jbe    177f <print_x32+0x1b>
}
    17bd:	90                   	nop
    17be:	90                   	nop
    17bf:	c9                   	leave
    17c0:	c3                   	ret

00000000000017c1 <print_d>:

  static void
print_d(int fd, int v)
{
    17c1:	f3 0f 1e fa          	endbr64
    17c5:	55                   	push   %rbp
    17c6:	48 89 e5             	mov    %rsp,%rbp
    17c9:	48 83 ec 30          	sub    $0x30,%rsp
    17cd:	89 7d dc             	mov    %edi,-0x24(%rbp)
    17d0:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    17d3:	8b 45 d8             	mov    -0x28(%rbp),%eax
    17d6:	48 98                	cltq
    17d8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    17dc:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    17e0:	79 04                	jns    17e6 <print_d+0x25>
    x = -x;
    17e2:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    17e6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    17ed:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    17f1:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    17f8:	66 66 66 
    17fb:	48 89 c8             	mov    %rcx,%rax
    17fe:	48 f7 ea             	imul   %rdx
    1801:	48 c1 fa 02          	sar    $0x2,%rdx
    1805:	48 89 c8             	mov    %rcx,%rax
    1808:	48 c1 f8 3f          	sar    $0x3f,%rax
    180c:	48 29 c2             	sub    %rax,%rdx
    180f:	48 89 d0             	mov    %rdx,%rax
    1812:	48 c1 e0 02          	shl    $0x2,%rax
    1816:	48 01 d0             	add    %rdx,%rax
    1819:	48 01 c0             	add    %rax,%rax
    181c:	48 29 c1             	sub    %rax,%rcx
    181f:	48 89 ca             	mov    %rcx,%rdx
    1822:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1825:	8d 48 01             	lea    0x1(%rax),%ecx
    1828:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    182b:	48 b9 b0 20 00 00 00 	movabs $0x20b0,%rcx
    1832:	00 00 00 
    1835:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    1839:	48 98                	cltq
    183b:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    183f:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1843:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    184a:	66 66 66 
    184d:	48 89 c8             	mov    %rcx,%rax
    1850:	48 f7 ea             	imul   %rdx
    1853:	48 89 d0             	mov    %rdx,%rax
    1856:	48 c1 f8 02          	sar    $0x2,%rax
    185a:	48 c1 f9 3f          	sar    $0x3f,%rcx
    185e:	48 89 ca             	mov    %rcx,%rdx
    1861:	48 29 d0             	sub    %rdx,%rax
    1864:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    1868:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    186d:	0f 85 7a ff ff ff    	jne    17ed <print_d+0x2c>

  if (v < 0)
    1873:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1877:	79 32                	jns    18ab <print_d+0xea>
    buf[i++] = '-';
    1879:	8b 45 f4             	mov    -0xc(%rbp),%eax
    187c:	8d 50 01             	lea    0x1(%rax),%edx
    187f:	89 55 f4             	mov    %edx,-0xc(%rbp)
    1882:	48 98                	cltq
    1884:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    1889:	eb 20                	jmp    18ab <print_d+0xea>
    putc(fd, buf[i]);
    188b:	8b 45 f4             	mov    -0xc(%rbp),%eax
    188e:	48 98                	cltq
    1890:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    1895:	0f be d0             	movsbl %al,%edx
    1898:	8b 45 dc             	mov    -0x24(%rbp),%eax
    189b:	89 d6                	mov    %edx,%esi
    189d:	89 c7                	mov    %eax,%edi
    189f:	48 b8 d3 16 00 00 00 	movabs $0x16d3,%rax
    18a6:	00 00 00 
    18a9:	ff d0                	call   *%rax
  while (--i >= 0)
    18ab:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    18af:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    18b3:	79 d6                	jns    188b <print_d+0xca>
}
    18b5:	90                   	nop
    18b6:	90                   	nop
    18b7:	c9                   	leave
    18b8:	c3                   	ret

00000000000018b9 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    18b9:	f3 0f 1e fa          	endbr64
    18bd:	55                   	push   %rbp
    18be:	48 89 e5             	mov    %rsp,%rbp
    18c1:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    18c8:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    18ce:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    18d5:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    18dc:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    18e3:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    18ea:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    18f1:	84 c0                	test   %al,%al
    18f3:	74 20                	je     1915 <printf+0x5c>
    18f5:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    18f9:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    18fd:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    1901:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    1905:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    1909:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    190d:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    1911:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    1915:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    191c:	00 00 00 
    191f:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    1926:	00 00 00 
    1929:	48 8d 45 10          	lea    0x10(%rbp),%rax
    192d:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    1934:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    193b:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1942:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    1949:	00 00 00 
    194c:	e9 41 03 00 00       	jmp    1c92 <printf+0x3d9>
    if (c != '%') {
    1951:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1958:	74 24                	je     197e <printf+0xc5>
      putc(fd, c);
    195a:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1960:	0f be d0             	movsbl %al,%edx
    1963:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1969:	89 d6                	mov    %edx,%esi
    196b:	89 c7                	mov    %eax,%edi
    196d:	48 b8 d3 16 00 00 00 	movabs $0x16d3,%rax
    1974:	00 00 00 
    1977:	ff d0                	call   *%rax
      continue;
    1979:	e9 0d 03 00 00       	jmp    1c8b <printf+0x3d2>
    }
    c = fmt[++i] & 0xff;
    197e:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1985:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    198b:	48 63 d0             	movslq %eax,%rdx
    198e:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1995:	48 01 d0             	add    %rdx,%rax
    1998:	0f b6 00             	movzbl (%rax),%eax
    199b:	0f be c0             	movsbl %al,%eax
    199e:	25 ff 00 00 00       	and    $0xff,%eax
    19a3:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    19a9:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    19b0:	0f 84 0f 03 00 00    	je     1cc5 <printf+0x40c>
      break;
    switch(c) {
    19b6:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    19bd:	0f 84 74 02 00 00    	je     1c37 <printf+0x37e>
    19c3:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    19ca:	0f 8c 82 02 00 00    	jl     1c52 <printf+0x399>
    19d0:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    19d7:	0f 8f 75 02 00 00    	jg     1c52 <printf+0x399>
    19dd:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    19e4:	0f 8c 68 02 00 00    	jl     1c52 <printf+0x399>
    19ea:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    19f0:	83 e8 63             	sub    $0x63,%eax
    19f3:	83 f8 15             	cmp    $0x15,%eax
    19f6:	0f 87 56 02 00 00    	ja     1c52 <printf+0x399>
    19fc:	89 c0                	mov    %eax,%eax
    19fe:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1a05:	00 
    1a06:	48 b8 00 20 00 00 00 	movabs $0x2000,%rax
    1a0d:	00 00 00 
    1a10:	48 01 d0             	add    %rdx,%rax
    1a13:	48 8b 00             	mov    (%rax),%rax
    1a16:	3e ff e0             	notrack jmp *%rax
    case 'c':
      putc(fd, va_arg(ap, int));
    1a19:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1a1f:	83 f8 2f             	cmp    $0x2f,%eax
    1a22:	77 23                	ja     1a47 <printf+0x18e>
    1a24:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1a2b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a31:	89 d2                	mov    %edx,%edx
    1a33:	48 01 d0             	add    %rdx,%rax
    1a36:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a3c:	83 c2 08             	add    $0x8,%edx
    1a3f:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1a45:	eb 12                	jmp    1a59 <printf+0x1a0>
    1a47:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a4e:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a52:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a59:	8b 00                	mov    (%rax),%eax
    1a5b:	0f be d0             	movsbl %al,%edx
    1a5e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a64:	89 d6                	mov    %edx,%esi
    1a66:	89 c7                	mov    %eax,%edi
    1a68:	48 b8 d3 16 00 00 00 	movabs $0x16d3,%rax
    1a6f:	00 00 00 
    1a72:	ff d0                	call   *%rax
      break;
    1a74:	e9 12 02 00 00       	jmp    1c8b <printf+0x3d2>
    case 'd':
      print_d(fd, va_arg(ap, int));
    1a79:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1a7f:	83 f8 2f             	cmp    $0x2f,%eax
    1a82:	77 23                	ja     1aa7 <printf+0x1ee>
    1a84:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1a8b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a91:	89 d2                	mov    %edx,%edx
    1a93:	48 01 d0             	add    %rdx,%rax
    1a96:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a9c:	83 c2 08             	add    $0x8,%edx
    1a9f:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1aa5:	eb 12                	jmp    1ab9 <printf+0x200>
    1aa7:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1aae:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1ab2:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1ab9:	8b 10                	mov    (%rax),%edx
    1abb:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1ac1:	89 d6                	mov    %edx,%esi
    1ac3:	89 c7                	mov    %eax,%edi
    1ac5:	48 b8 c1 17 00 00 00 	movabs $0x17c1,%rax
    1acc:	00 00 00 
    1acf:	ff d0                	call   *%rax
      break;
    1ad1:	e9 b5 01 00 00       	jmp    1c8b <printf+0x3d2>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    1ad6:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1adc:	83 f8 2f             	cmp    $0x2f,%eax
    1adf:	77 23                	ja     1b04 <printf+0x24b>
    1ae1:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1ae8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1aee:	89 d2                	mov    %edx,%edx
    1af0:	48 01 d0             	add    %rdx,%rax
    1af3:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1af9:	83 c2 08             	add    $0x8,%edx
    1afc:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1b02:	eb 12                	jmp    1b16 <printf+0x25d>
    1b04:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1b0b:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1b0f:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1b16:	8b 10                	mov    (%rax),%edx
    1b18:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b1e:	89 d6                	mov    %edx,%esi
    1b20:	89 c7                	mov    %eax,%edi
    1b22:	48 b8 64 17 00 00 00 	movabs $0x1764,%rax
    1b29:	00 00 00 
    1b2c:	ff d0                	call   *%rax
      break;
    1b2e:	e9 58 01 00 00       	jmp    1c8b <printf+0x3d2>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    1b33:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1b39:	83 f8 2f             	cmp    $0x2f,%eax
    1b3c:	77 23                	ja     1b61 <printf+0x2a8>
    1b3e:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1b45:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b4b:	89 d2                	mov    %edx,%edx
    1b4d:	48 01 d0             	add    %rdx,%rax
    1b50:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b56:	83 c2 08             	add    $0x8,%edx
    1b59:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1b5f:	eb 12                	jmp    1b73 <printf+0x2ba>
    1b61:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1b68:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1b6c:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1b73:	48 8b 10             	mov    (%rax),%rdx
    1b76:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b7c:	48 89 d6             	mov    %rdx,%rsi
    1b7f:	89 c7                	mov    %eax,%edi
    1b81:	48 b8 07 17 00 00 00 	movabs $0x1707,%rax
    1b88:	00 00 00 
    1b8b:	ff d0                	call   *%rax
      break;
    1b8d:	e9 f9 00 00 00       	jmp    1c8b <printf+0x3d2>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    1b92:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1b98:	83 f8 2f             	cmp    $0x2f,%eax
    1b9b:	77 23                	ja     1bc0 <printf+0x307>
    1b9d:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1ba4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1baa:	89 d2                	mov    %edx,%edx
    1bac:	48 01 d0             	add    %rdx,%rax
    1baf:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1bb5:	83 c2 08             	add    $0x8,%edx
    1bb8:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1bbe:	eb 12                	jmp    1bd2 <printf+0x319>
    1bc0:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1bc7:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1bcb:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1bd2:	48 8b 00             	mov    (%rax),%rax
    1bd5:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    1bdc:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1be3:	00 
    1be4:	75 41                	jne    1c27 <printf+0x36e>
        s = "(null)";
    1be6:	48 b8 f8 1f 00 00 00 	movabs $0x1ff8,%rax
    1bed:	00 00 00 
    1bf0:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1bf7:	eb 2e                	jmp    1c27 <printf+0x36e>
        putc(fd, *(s++));
    1bf9:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1c00:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1c04:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1c0b:	0f b6 00             	movzbl (%rax),%eax
    1c0e:	0f be d0             	movsbl %al,%edx
    1c11:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1c17:	89 d6                	mov    %edx,%esi
    1c19:	89 c7                	mov    %eax,%edi
    1c1b:	48 b8 d3 16 00 00 00 	movabs $0x16d3,%rax
    1c22:	00 00 00 
    1c25:	ff d0                	call   *%rax
      while (*s)
    1c27:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1c2e:	0f b6 00             	movzbl (%rax),%eax
    1c31:	84 c0                	test   %al,%al
    1c33:	75 c4                	jne    1bf9 <printf+0x340>
      break;
    1c35:	eb 54                	jmp    1c8b <printf+0x3d2>
    case '%':
      putc(fd, '%');
    1c37:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1c3d:	be 25 00 00 00       	mov    $0x25,%esi
    1c42:	89 c7                	mov    %eax,%edi
    1c44:	48 b8 d3 16 00 00 00 	movabs $0x16d3,%rax
    1c4b:	00 00 00 
    1c4e:	ff d0                	call   *%rax
      break;
    1c50:	eb 39                	jmp    1c8b <printf+0x3d2>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1c52:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1c58:	be 25 00 00 00       	mov    $0x25,%esi
    1c5d:	89 c7                	mov    %eax,%edi
    1c5f:	48 b8 d3 16 00 00 00 	movabs $0x16d3,%rax
    1c66:	00 00 00 
    1c69:	ff d0                	call   *%rax
      putc(fd, c);
    1c6b:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1c71:	0f be d0             	movsbl %al,%edx
    1c74:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1c7a:	89 d6                	mov    %edx,%esi
    1c7c:	89 c7                	mov    %eax,%edi
    1c7e:	48 b8 d3 16 00 00 00 	movabs $0x16d3,%rax
    1c85:	00 00 00 
    1c88:	ff d0                	call   *%rax
      break;
    1c8a:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1c8b:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1c92:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1c98:	48 63 d0             	movslq %eax,%rdx
    1c9b:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1ca2:	48 01 d0             	add    %rdx,%rax
    1ca5:	0f b6 00             	movzbl (%rax),%eax
    1ca8:	0f be c0             	movsbl %al,%eax
    1cab:	25 ff 00 00 00       	and    $0xff,%eax
    1cb0:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1cb6:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1cbd:	0f 85 8e fc ff ff    	jne    1951 <printf+0x98>
    }
  }
}
    1cc3:	eb 01                	jmp    1cc6 <printf+0x40d>
      break;
    1cc5:	90                   	nop
}
    1cc6:	90                   	nop
    1cc7:	c9                   	leave
    1cc8:	c3                   	ret

0000000000001cc9 <free>:
    1cc9:	55                   	push   %rbp
    1cca:	48 89 e5             	mov    %rsp,%rbp
    1ccd:	48 83 ec 18          	sub    $0x18,%rsp
    1cd1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1cd5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1cd9:	48 83 e8 10          	sub    $0x10,%rax
    1cdd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1ce1:	48 b8 f0 22 00 00 00 	movabs $0x22f0,%rax
    1ce8:	00 00 00 
    1ceb:	48 8b 00             	mov    (%rax),%rax
    1cee:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1cf2:	eb 2f                	jmp    1d23 <free+0x5a>
    1cf4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cf8:	48 8b 00             	mov    (%rax),%rax
    1cfb:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1cff:	72 17                	jb     1d18 <free+0x4f>
    1d01:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d05:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1d09:	72 2f                	jb     1d3a <free+0x71>
    1d0b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d0f:	48 8b 00             	mov    (%rax),%rax
    1d12:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1d16:	72 22                	jb     1d3a <free+0x71>
    1d18:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d1c:	48 8b 00             	mov    (%rax),%rax
    1d1f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1d23:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d27:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1d2b:	73 c7                	jae    1cf4 <free+0x2b>
    1d2d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d31:	48 8b 00             	mov    (%rax),%rax
    1d34:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1d38:	73 ba                	jae    1cf4 <free+0x2b>
    1d3a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d3e:	8b 40 08             	mov    0x8(%rax),%eax
    1d41:	89 c0                	mov    %eax,%eax
    1d43:	48 c1 e0 04          	shl    $0x4,%rax
    1d47:	48 89 c2             	mov    %rax,%rdx
    1d4a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d4e:	48 01 c2             	add    %rax,%rdx
    1d51:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d55:	48 8b 00             	mov    (%rax),%rax
    1d58:	48 39 c2             	cmp    %rax,%rdx
    1d5b:	75 2d                	jne    1d8a <free+0xc1>
    1d5d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d61:	8b 50 08             	mov    0x8(%rax),%edx
    1d64:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d68:	48 8b 00             	mov    (%rax),%rax
    1d6b:	8b 40 08             	mov    0x8(%rax),%eax
    1d6e:	01 c2                	add    %eax,%edx
    1d70:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d74:	89 50 08             	mov    %edx,0x8(%rax)
    1d77:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d7b:	48 8b 00             	mov    (%rax),%rax
    1d7e:	48 8b 10             	mov    (%rax),%rdx
    1d81:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d85:	48 89 10             	mov    %rdx,(%rax)
    1d88:	eb 0e                	jmp    1d98 <free+0xcf>
    1d8a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d8e:	48 8b 10             	mov    (%rax),%rdx
    1d91:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d95:	48 89 10             	mov    %rdx,(%rax)
    1d98:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d9c:	8b 40 08             	mov    0x8(%rax),%eax
    1d9f:	89 c0                	mov    %eax,%eax
    1da1:	48 c1 e0 04          	shl    $0x4,%rax
    1da5:	48 89 c2             	mov    %rax,%rdx
    1da8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1dac:	48 01 d0             	add    %rdx,%rax
    1daf:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1db3:	75 27                	jne    1ddc <free+0x113>
    1db5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1db9:	8b 50 08             	mov    0x8(%rax),%edx
    1dbc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1dc0:	8b 40 08             	mov    0x8(%rax),%eax
    1dc3:	01 c2                	add    %eax,%edx
    1dc5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1dc9:	89 50 08             	mov    %edx,0x8(%rax)
    1dcc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1dd0:	48 8b 10             	mov    (%rax),%rdx
    1dd3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1dd7:	48 89 10             	mov    %rdx,(%rax)
    1dda:	eb 0b                	jmp    1de7 <free+0x11e>
    1ddc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1de0:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1de4:	48 89 10             	mov    %rdx,(%rax)
    1de7:	48 ba f0 22 00 00 00 	movabs $0x22f0,%rdx
    1dee:	00 00 00 
    1df1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1df5:	48 89 02             	mov    %rax,(%rdx)
    1df8:	90                   	nop
    1df9:	c9                   	leave
    1dfa:	c3                   	ret

0000000000001dfb <morecore>:
    1dfb:	55                   	push   %rbp
    1dfc:	48 89 e5             	mov    %rsp,%rbp
    1dff:	48 83 ec 20          	sub    $0x20,%rsp
    1e03:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1e06:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1e0d:	77 07                	ja     1e16 <morecore+0x1b>
    1e0f:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
    1e16:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1e19:	48 c1 e0 04          	shl    $0x4,%rax
    1e1d:	48 89 c7             	mov    %rax,%rdi
    1e20:	48 b8 92 16 00 00 00 	movabs $0x1692,%rax
    1e27:	00 00 00 
    1e2a:	ff d0                	call   *%rax
    1e2c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1e30:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1e35:	75 07                	jne    1e3e <morecore+0x43>
    1e37:	b8 00 00 00 00       	mov    $0x0,%eax
    1e3c:	eb 36                	jmp    1e74 <morecore+0x79>
    1e3e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e42:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1e46:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e4a:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1e4d:	89 50 08             	mov    %edx,0x8(%rax)
    1e50:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e54:	48 83 c0 10          	add    $0x10,%rax
    1e58:	48 89 c7             	mov    %rax,%rdi
    1e5b:	48 b8 c9 1c 00 00 00 	movabs $0x1cc9,%rax
    1e62:	00 00 00 
    1e65:	ff d0                	call   *%rax
    1e67:	48 b8 f0 22 00 00 00 	movabs $0x22f0,%rax
    1e6e:	00 00 00 
    1e71:	48 8b 00             	mov    (%rax),%rax
    1e74:	c9                   	leave
    1e75:	c3                   	ret

0000000000001e76 <malloc>:
    1e76:	55                   	push   %rbp
    1e77:	48 89 e5             	mov    %rsp,%rbp
    1e7a:	48 83 ec 30          	sub    $0x30,%rsp
    1e7e:	89 7d dc             	mov    %edi,-0x24(%rbp)
    1e81:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1e84:	48 83 c0 0f          	add    $0xf,%rax
    1e88:	48 c1 e8 04          	shr    $0x4,%rax
    1e8c:	83 c0 01             	add    $0x1,%eax
    1e8f:	89 45 ec             	mov    %eax,-0x14(%rbp)
    1e92:	48 b8 f0 22 00 00 00 	movabs $0x22f0,%rax
    1e99:	00 00 00 
    1e9c:	48 8b 00             	mov    (%rax),%rax
    1e9f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1ea3:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1ea8:	75 4a                	jne    1ef4 <malloc+0x7e>
    1eaa:	48 b8 e0 22 00 00 00 	movabs $0x22e0,%rax
    1eb1:	00 00 00 
    1eb4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1eb8:	48 ba f0 22 00 00 00 	movabs $0x22f0,%rdx
    1ebf:	00 00 00 
    1ec2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ec6:	48 89 02             	mov    %rax,(%rdx)
    1ec9:	48 b8 f0 22 00 00 00 	movabs $0x22f0,%rax
    1ed0:	00 00 00 
    1ed3:	48 8b 00             	mov    (%rax),%rax
    1ed6:	48 ba e0 22 00 00 00 	movabs $0x22e0,%rdx
    1edd:	00 00 00 
    1ee0:	48 89 02             	mov    %rax,(%rdx)
    1ee3:	48 b8 e0 22 00 00 00 	movabs $0x22e0,%rax
    1eea:	00 00 00 
    1eed:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
    1ef4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ef8:	48 8b 00             	mov    (%rax),%rax
    1efb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1eff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f03:	8b 40 08             	mov    0x8(%rax),%eax
    1f06:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1f09:	72 65                	jb     1f70 <malloc+0xfa>
    1f0b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f0f:	8b 40 08             	mov    0x8(%rax),%eax
    1f12:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1f15:	75 10                	jne    1f27 <malloc+0xb1>
    1f17:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f1b:	48 8b 10             	mov    (%rax),%rdx
    1f1e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f22:	48 89 10             	mov    %rdx,(%rax)
    1f25:	eb 2e                	jmp    1f55 <malloc+0xdf>
    1f27:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f2b:	8b 40 08             	mov    0x8(%rax),%eax
    1f2e:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1f31:	89 c2                	mov    %eax,%edx
    1f33:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f37:	89 50 08             	mov    %edx,0x8(%rax)
    1f3a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f3e:	8b 40 08             	mov    0x8(%rax),%eax
    1f41:	89 c0                	mov    %eax,%eax
    1f43:	48 c1 e0 04          	shl    $0x4,%rax
    1f47:	48 01 45 f8          	add    %rax,-0x8(%rbp)
    1f4b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f4f:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1f52:	89 50 08             	mov    %edx,0x8(%rax)
    1f55:	48 ba f0 22 00 00 00 	movabs $0x22f0,%rdx
    1f5c:	00 00 00 
    1f5f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f63:	48 89 02             	mov    %rax,(%rdx)
    1f66:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f6a:	48 83 c0 10          	add    $0x10,%rax
    1f6e:	eb 4e                	jmp    1fbe <malloc+0x148>
    1f70:	48 b8 f0 22 00 00 00 	movabs $0x22f0,%rax
    1f77:	00 00 00 
    1f7a:	48 8b 00             	mov    (%rax),%rax
    1f7d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1f81:	75 23                	jne    1fa6 <malloc+0x130>
    1f83:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1f86:	89 c7                	mov    %eax,%edi
    1f88:	48 b8 fb 1d 00 00 00 	movabs $0x1dfb,%rax
    1f8f:	00 00 00 
    1f92:	ff d0                	call   *%rax
    1f94:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1f98:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1f9d:	75 07                	jne    1fa6 <malloc+0x130>
    1f9f:	b8 00 00 00 00       	mov    $0x0,%eax
    1fa4:	eb 18                	jmp    1fbe <malloc+0x148>
    1fa6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1faa:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1fae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1fb2:	48 8b 00             	mov    (%rax),%rax
    1fb5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1fb9:	e9 41 ff ff ff       	jmp    1eff <malloc+0x89>
    1fbe:	c9                   	leave
    1fbf:	c3                   	ret
