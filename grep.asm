
_grep:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
    1000:	f3 0f 1e fa          	endbr64
    1004:	55                   	push   %rbp
    1005:	48 89 e5             	mov    %rsp,%rbp
    1008:	48 83 ec 30          	sub    $0x30,%rsp
    100c:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
    1010:	89 75 d4             	mov    %esi,-0x2c(%rbp)
  int n, m;
  char *p, *q;

  m = 0;
    1013:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
    101a:	e9 09 01 00 00       	jmp    1128 <grep+0x128>
    m += n;
    101f:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1022:	01 45 fc             	add    %eax,-0x4(%rbp)
    buf[m] = '\0';
    1025:	48 ba e0 22 00 00 00 	movabs $0x22e0,%rdx
    102c:	00 00 00 
    102f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1032:	48 98                	cltq
    1034:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
    p = buf;
    1038:	48 b8 e0 22 00 00 00 	movabs $0x22e0,%rax
    103f:	00 00 00 
    1042:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    while((q = strchr(p, '\n')) != 0){
    1046:	eb 5e                	jmp    10a6 <grep+0xa6>
      *q = 0;
    1048:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    104c:	c6 00 00             	movb   $0x0,(%rax)
      if(match(pattern, p)){
    104f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1053:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    1057:	48 89 d6             	mov    %rdx,%rsi
    105a:	48 89 c7             	mov    %rax,%rdi
    105d:	48 b8 ba 12 00 00 00 	movabs $0x12ba,%rax
    1064:	00 00 00 
    1067:	ff d0                	call   *%rax
    1069:	85 c0                	test   %eax,%eax
    106b:	74 2d                	je     109a <grep+0x9a>
        *q = '\n';
    106d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1071:	c6 00 0a             	movb   $0xa,(%rax)
        write(1, p, q+1 - p);
    1074:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1078:	48 83 c0 01          	add    $0x1,%rax
    107c:	48 2b 45 f0          	sub    -0x10(%rbp),%rax
    1080:	89 c2                	mov    %eax,%edx
    1082:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1086:	48 89 c6             	mov    %rax,%rsi
    1089:	bf 01 00 00 00       	mov    $0x1,%edi
    108e:	48 b8 f9 17 00 00 00 	movabs $0x17f9,%rax
    1095:	00 00 00 
    1098:	ff d0                	call   *%rax
      }
      p = q+1;
    109a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    109e:	48 83 c0 01          	add    $0x1,%rax
    10a2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    while((q = strchr(p, '\n')) != 0){
    10a6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    10aa:	be 0a 00 00 00       	mov    $0xa,%esi
    10af:	48 89 c7             	mov    %rax,%rdi
    10b2:	48 b8 c7 15 00 00 00 	movabs $0x15c7,%rax
    10b9:	00 00 00 
    10bc:	ff d0                	call   *%rax
    10be:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    10c2:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
    10c7:	0f 85 7b ff ff ff    	jne    1048 <grep+0x48>
    }
    if(p == buf)
    10cd:	48 b8 e0 22 00 00 00 	movabs $0x22e0,%rax
    10d4:	00 00 00 
    10d7:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    10db:	75 07                	jne    10e4 <grep+0xe4>
      m = 0;
    10dd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    if(m > 0){
    10e4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    10e8:	7e 3e                	jle    1128 <grep+0x128>
      m -= p - buf;
    10ea:	8b 45 fc             	mov    -0x4(%rbp),%eax
    10ed:	48 ba e0 22 00 00 00 	movabs $0x22e0,%rdx
    10f4:	00 00 00 
    10f7:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
    10fb:	48 29 d1             	sub    %rdx,%rcx
    10fe:	89 ca                	mov    %ecx,%edx
    1100:	29 d0                	sub    %edx,%eax
    1102:	89 45 fc             	mov    %eax,-0x4(%rbp)
      memmove(buf, p, m);
    1105:	8b 55 fc             	mov    -0x4(%rbp),%edx
    1108:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    110c:	48 89 c6             	mov    %rax,%rsi
    110f:	48 b8 e0 22 00 00 00 	movabs $0x22e0,%rax
    1116:	00 00 00 
    1119:	48 89 c7             	mov    %rax,%rdi
    111c:	48 b8 5f 17 00 00 00 	movabs $0x175f,%rax
    1123:	00 00 00 
    1126:	ff d0                	call   *%rax
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
    1128:	8b 45 fc             	mov    -0x4(%rbp),%eax
    112b:	ba ff 03 00 00       	mov    $0x3ff,%edx
    1130:	29 c2                	sub    %eax,%edx
    1132:	89 d6                	mov    %edx,%esi
    1134:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1137:	48 98                	cltq
    1139:	48 ba e0 22 00 00 00 	movabs $0x22e0,%rdx
    1140:	00 00 00 
    1143:	48 8d 0c 10          	lea    (%rax,%rdx,1),%rcx
    1147:	8b 45 d4             	mov    -0x2c(%rbp),%eax
    114a:	89 f2                	mov    %esi,%edx
    114c:	48 89 ce             	mov    %rcx,%rsi
    114f:	89 c7                	mov    %eax,%edi
    1151:	48 b8 ec 17 00 00 00 	movabs $0x17ec,%rax
    1158:	00 00 00 
    115b:	ff d0                	call   *%rax
    115d:	89 45 ec             	mov    %eax,-0x14(%rbp)
    1160:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
    1164:	0f 8f b5 fe ff ff    	jg     101f <grep+0x1f>
    }
  }
}
    116a:	90                   	nop
    116b:	90                   	nop
    116c:	c9                   	leave
    116d:	c3                   	ret

000000000000116e <main>:

int
main(int argc, char *argv[])
{
    116e:	f3 0f 1e fa          	endbr64
    1172:	55                   	push   %rbp
    1173:	48 89 e5             	mov    %rsp,%rbp
    1176:	48 83 ec 30          	sub    $0x30,%rsp
    117a:	89 7d dc             	mov    %edi,-0x24(%rbp)
    117d:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  int fd, i;
  char *pattern;

  if(argc <= 1){
    1181:	83 7d dc 01          	cmpl   $0x1,-0x24(%rbp)
    1185:	7f 2f                	jg     11b6 <main+0x48>
    printf(2, "usage: grep pattern [file ...]\n");
    1187:	48 b8 d0 21 00 00 00 	movabs $0x21d0,%rax
    118e:	00 00 00 
    1191:	48 89 c6             	mov    %rax,%rsi
    1194:	bf 02 00 00 00       	mov    $0x2,%edi
    1199:	b8 00 00 00 00       	mov    $0x0,%eax
    119e:	48 ba c9 1a 00 00 00 	movabs $0x1ac9,%rdx
    11a5:	00 00 00 
    11a8:	ff d2                	call   *%rdx
    exit();
    11aa:	48 b8 c5 17 00 00 00 	movabs $0x17c5,%rax
    11b1:	00 00 00 
    11b4:	ff d0                	call   *%rax
  }
  pattern = argv[1];
    11b6:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    11ba:	48 8b 40 08          	mov    0x8(%rax),%rax
    11be:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

  if(argc <= 2){
    11c2:	83 7d dc 02          	cmpl   $0x2,-0x24(%rbp)
    11c6:	7f 24                	jg     11ec <main+0x7e>
    grep(pattern, 0);
    11c8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    11cc:	be 00 00 00 00       	mov    $0x0,%esi
    11d1:	48 89 c7             	mov    %rax,%rdi
    11d4:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    11db:	00 00 00 
    11de:	ff d0                	call   *%rax
    exit();
    11e0:	48 b8 c5 17 00 00 00 	movabs $0x17c5,%rax
    11e7:	00 00 00 
    11ea:	ff d0                	call   *%rax
  }

  for(i = 2; i < argc; i++){
    11ec:	c7 45 fc 02 00 00 00 	movl   $0x2,-0x4(%rbp)
    11f3:	e9 aa 00 00 00       	jmp    12a2 <main+0x134>
    if((fd = open(argv[i], 0)) < 0){
    11f8:	8b 45 fc             	mov    -0x4(%rbp),%eax
    11fb:	48 98                	cltq
    11fd:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1204:	00 
    1205:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    1209:	48 01 d0             	add    %rdx,%rax
    120c:	48 8b 00             	mov    (%rax),%rax
    120f:	be 00 00 00 00       	mov    $0x0,%esi
    1214:	48 89 c7             	mov    %rax,%rdi
    1217:	48 b8 2d 18 00 00 00 	movabs $0x182d,%rax
    121e:	00 00 00 
    1221:	ff d0                	call   *%rax
    1223:	89 45 ec             	mov    %eax,-0x14(%rbp)
    1226:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
    122a:	79 49                	jns    1275 <main+0x107>
      printf(1, "grep: cannot open %s\n", argv[i]);
    122c:	8b 45 fc             	mov    -0x4(%rbp),%eax
    122f:	48 98                	cltq
    1231:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1238:	00 
    1239:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    123d:	48 01 d0             	add    %rdx,%rax
    1240:	48 8b 00             	mov    (%rax),%rax
    1243:	48 89 c2             	mov    %rax,%rdx
    1246:	48 b8 f0 21 00 00 00 	movabs $0x21f0,%rax
    124d:	00 00 00 
    1250:	48 89 c6             	mov    %rax,%rsi
    1253:	bf 01 00 00 00       	mov    $0x1,%edi
    1258:	b8 00 00 00 00       	mov    $0x0,%eax
    125d:	48 b9 c9 1a 00 00 00 	movabs $0x1ac9,%rcx
    1264:	00 00 00 
    1267:	ff d1                	call   *%rcx
      exit();
    1269:	48 b8 c5 17 00 00 00 	movabs $0x17c5,%rax
    1270:	00 00 00 
    1273:	ff d0                	call   *%rax
    }
    grep(pattern, fd);
    1275:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1278:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    127c:	89 d6                	mov    %edx,%esi
    127e:	48 89 c7             	mov    %rax,%rdi
    1281:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1288:	00 00 00 
    128b:	ff d0                	call   *%rax
    close(fd);
    128d:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1290:	89 c7                	mov    %eax,%edi
    1292:	48 b8 06 18 00 00 00 	movabs $0x1806,%rax
    1299:	00 00 00 
    129c:	ff d0                	call   *%rax
  for(i = 2; i < argc; i++){
    129e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    12a2:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12a5:	3b 45 dc             	cmp    -0x24(%rbp),%eax
    12a8:	0f 8c 4a ff ff ff    	jl     11f8 <main+0x8a>
  }
  exit();
    12ae:	48 b8 c5 17 00 00 00 	movabs $0x17c5,%rax
    12b5:	00 00 00 
    12b8:	ff d0                	call   *%rax

00000000000012ba <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
    12ba:	f3 0f 1e fa          	endbr64
    12be:	55                   	push   %rbp
    12bf:	48 89 e5             	mov    %rsp,%rbp
    12c2:	48 83 ec 10          	sub    $0x10,%rsp
    12c6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    12ca:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(re[0] == '^')
    12ce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    12d2:	0f b6 00             	movzbl (%rax),%eax
    12d5:	3c 5e                	cmp    $0x5e,%al
    12d7:	75 20                	jne    12f9 <match+0x3f>
    return matchhere(re+1, text);
    12d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    12dd:	48 8d 50 01          	lea    0x1(%rax),%rdx
    12e1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    12e5:	48 89 c6             	mov    %rax,%rsi
    12e8:	48 89 d7             	mov    %rdx,%rdi
    12eb:	48 b8 38 13 00 00 00 	movabs $0x1338,%rax
    12f2:	00 00 00 
    12f5:	ff d0                	call   *%rax
    12f7:	eb 3d                	jmp    1336 <match+0x7c>
  do{  // must look at empty string
    if(matchhere(re, text))
    12f9:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    12fd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1301:	48 89 d6             	mov    %rdx,%rsi
    1304:	48 89 c7             	mov    %rax,%rdi
    1307:	48 b8 38 13 00 00 00 	movabs $0x1338,%rax
    130e:	00 00 00 
    1311:	ff d0                	call   *%rax
    1313:	85 c0                	test   %eax,%eax
    1315:	74 07                	je     131e <match+0x64>
      return 1;
    1317:	b8 01 00 00 00       	mov    $0x1,%eax
    131c:	eb 18                	jmp    1336 <match+0x7c>
  }while(*text++ != '\0');
    131e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1322:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1326:	48 89 55 f0          	mov    %rdx,-0x10(%rbp)
    132a:	0f b6 00             	movzbl (%rax),%eax
    132d:	84 c0                	test   %al,%al
    132f:	75 c8                	jne    12f9 <match+0x3f>
  return 0;
    1331:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1336:	c9                   	leave
    1337:	c3                   	ret

0000000000001338 <matchhere>:

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
    1338:	f3 0f 1e fa          	endbr64
    133c:	55                   	push   %rbp
    133d:	48 89 e5             	mov    %rsp,%rbp
    1340:	48 83 ec 10          	sub    $0x10,%rsp
    1344:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1348:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(re[0] == '\0')
    134c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1350:	0f b6 00             	movzbl (%rax),%eax
    1353:	84 c0                	test   %al,%al
    1355:	75 0a                	jne    1361 <matchhere+0x29>
    return 1;
    1357:	b8 01 00 00 00       	mov    $0x1,%eax
    135c:	e9 b4 00 00 00       	jmp    1415 <matchhere+0xdd>
  if(re[1] == '*')
    1361:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1365:	48 83 c0 01          	add    $0x1,%rax
    1369:	0f b6 00             	movzbl (%rax),%eax
    136c:	3c 2a                	cmp    $0x2a,%al
    136e:	75 29                	jne    1399 <matchhere+0x61>
    return matchstar(re[0], re+2, text);
    1370:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1374:	48 8d 48 02          	lea    0x2(%rax),%rcx
    1378:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    137c:	0f b6 00             	movzbl (%rax),%eax
    137f:	0f be c0             	movsbl %al,%eax
    1382:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1386:	48 89 ce             	mov    %rcx,%rsi
    1389:	89 c7                	mov    %eax,%edi
    138b:	48 b8 17 14 00 00 00 	movabs $0x1417,%rax
    1392:	00 00 00 
    1395:	ff d0                	call   *%rax
    1397:	eb 7c                	jmp    1415 <matchhere+0xdd>
  if(re[0] == '$' && re[1] == '\0')
    1399:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    139d:	0f b6 00             	movzbl (%rax),%eax
    13a0:	3c 24                	cmp    $0x24,%al
    13a2:	75 20                	jne    13c4 <matchhere+0x8c>
    13a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13a8:	48 83 c0 01          	add    $0x1,%rax
    13ac:	0f b6 00             	movzbl (%rax),%eax
    13af:	84 c0                	test   %al,%al
    13b1:	75 11                	jne    13c4 <matchhere+0x8c>
    return *text == '\0';
    13b3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    13b7:	0f b6 00             	movzbl (%rax),%eax
    13ba:	84 c0                	test   %al,%al
    13bc:	0f 94 c0             	sete   %al
    13bf:	0f b6 c0             	movzbl %al,%eax
    13c2:	eb 51                	jmp    1415 <matchhere+0xdd>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    13c4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    13c8:	0f b6 00             	movzbl (%rax),%eax
    13cb:	84 c0                	test   %al,%al
    13cd:	74 41                	je     1410 <matchhere+0xd8>
    13cf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13d3:	0f b6 00             	movzbl (%rax),%eax
    13d6:	3c 2e                	cmp    $0x2e,%al
    13d8:	74 12                	je     13ec <matchhere+0xb4>
    13da:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13de:	0f b6 10             	movzbl (%rax),%edx
    13e1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    13e5:	0f b6 00             	movzbl (%rax),%eax
    13e8:	38 c2                	cmp    %al,%dl
    13ea:	75 24                	jne    1410 <matchhere+0xd8>
    return matchhere(re+1, text+1);
    13ec:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    13f0:	48 8d 50 01          	lea    0x1(%rax),%rdx
    13f4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13f8:	48 83 c0 01          	add    $0x1,%rax
    13fc:	48 89 d6             	mov    %rdx,%rsi
    13ff:	48 89 c7             	mov    %rax,%rdi
    1402:	48 b8 38 13 00 00 00 	movabs $0x1338,%rax
    1409:	00 00 00 
    140c:	ff d0                	call   *%rax
    140e:	eb 05                	jmp    1415 <matchhere+0xdd>
  return 0;
    1410:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1415:	c9                   	leave
    1416:	c3                   	ret

0000000000001417 <matchstar>:

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
    1417:	f3 0f 1e fa          	endbr64
    141b:	55                   	push   %rbp
    141c:	48 89 e5             	mov    %rsp,%rbp
    141f:	48 83 ec 20          	sub    $0x20,%rsp
    1423:	89 7d fc             	mov    %edi,-0x4(%rbp)
    1426:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    142a:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
    142e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
    1432:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1436:	48 89 d6             	mov    %rdx,%rsi
    1439:	48 89 c7             	mov    %rax,%rdi
    143c:	48 b8 38 13 00 00 00 	movabs $0x1338,%rax
    1443:	00 00 00 
    1446:	ff d0                	call   *%rax
    1448:	85 c0                	test   %eax,%eax
    144a:	74 07                	je     1453 <matchstar+0x3c>
      return 1;
    144c:	b8 01 00 00 00       	mov    $0x1,%eax
    1451:	eb 2d                	jmp    1480 <matchstar+0x69>
  }while(*text!='\0' && (*text++==c || c=='.'));
    1453:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1457:	0f b6 00             	movzbl (%rax),%eax
    145a:	84 c0                	test   %al,%al
    145c:	74 1d                	je     147b <matchstar+0x64>
    145e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1462:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1466:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    146a:	0f b6 00             	movzbl (%rax),%eax
    146d:	0f be c0             	movsbl %al,%eax
    1470:	39 45 fc             	cmp    %eax,-0x4(%rbp)
    1473:	74 b9                	je     142e <matchstar+0x17>
    1475:	83 7d fc 2e          	cmpl   $0x2e,-0x4(%rbp)
    1479:	74 b3                	je     142e <matchstar+0x17>
  return 0;
    147b:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1480:	c9                   	leave
    1481:	c3                   	ret

0000000000001482 <stosb>:
  stosb(dst, c, n);
  return dst;
}

char*
strchr(const char *s, char c)
    1482:	f3 0f 1e fa          	endbr64
    1486:	55                   	push   %rbp
    1487:	48 89 e5             	mov    %rsp,%rbp
    148a:	48 83 ec 10          	sub    $0x10,%rsp
    148e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1492:	89 75 f4             	mov    %esi,-0xc(%rbp)
    1495:	89 55 f0             	mov    %edx,-0x10(%rbp)
{
    1498:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    149c:	8b 55 f0             	mov    -0x10(%rbp),%edx
    149f:	8b 45 f4             	mov    -0xc(%rbp),%eax
    14a2:	48 89 ce             	mov    %rcx,%rsi
    14a5:	48 89 f7             	mov    %rsi,%rdi
    14a8:	89 d1                	mov    %edx,%ecx
    14aa:	fc                   	cld
    14ab:	f3 aa                	rep stos %al,%es:(%rdi)
    14ad:	89 ca                	mov    %ecx,%edx
    14af:	48 89 fe             	mov    %rdi,%rsi
    14b2:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    14b6:	89 55 f0             	mov    %edx,-0x10(%rbp)
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
    14b9:	90                   	nop
    14ba:	c9                   	leave
    14bb:	c3                   	ret

00000000000014bc <strcpy>:
{
    14bc:	f3 0f 1e fa          	endbr64
    14c0:	55                   	push   %rbp
    14c1:	48 89 e5             	mov    %rsp,%rbp
    14c4:	48 83 ec 20          	sub    $0x20,%rsp
    14c8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    14cc:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  os = s;
    14d0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    14d4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    14d8:	90                   	nop
    14d9:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    14dd:	48 8d 42 01          	lea    0x1(%rdx),%rax
    14e1:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    14e5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    14e9:	48 8d 48 01          	lea    0x1(%rax),%rcx
    14ed:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    14f1:	0f b6 12             	movzbl (%rdx),%edx
    14f4:	88 10                	mov    %dl,(%rax)
    14f6:	0f b6 00             	movzbl (%rax),%eax
    14f9:	84 c0                	test   %al,%al
    14fb:	75 dc                	jne    14d9 <strcpy+0x1d>
  return os;
    14fd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    1501:	c9                   	leave
    1502:	c3                   	ret

0000000000001503 <strcmp>:
{
    1503:	f3 0f 1e fa          	endbr64
    1507:	55                   	push   %rbp
    1508:	48 89 e5             	mov    %rsp,%rbp
    150b:	48 83 ec 10          	sub    $0x10,%rsp
    150f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1513:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    1517:	eb 0a                	jmp    1523 <strcmp+0x20>
    p++, q++;
    1519:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    151e:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    1523:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1527:	0f b6 00             	movzbl (%rax),%eax
    152a:	84 c0                	test   %al,%al
    152c:	74 12                	je     1540 <strcmp+0x3d>
    152e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1532:	0f b6 10             	movzbl (%rax),%edx
    1535:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1539:	0f b6 00             	movzbl (%rax),%eax
    153c:	38 c2                	cmp    %al,%dl
    153e:	74 d9                	je     1519 <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
    1540:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1544:	0f b6 00             	movzbl (%rax),%eax
    1547:	0f b6 d0             	movzbl %al,%edx
    154a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    154e:	0f b6 00             	movzbl (%rax),%eax
    1551:	0f b6 c0             	movzbl %al,%eax
    1554:	29 c2                	sub    %eax,%edx
    1556:	89 d0                	mov    %edx,%eax
}
    1558:	c9                   	leave
    1559:	c3                   	ret

000000000000155a <strlen>:
{
    155a:	f3 0f 1e fa          	endbr64
    155e:	55                   	push   %rbp
    155f:	48 89 e5             	mov    %rsp,%rbp
    1562:	48 83 ec 18          	sub    $0x18,%rsp
    1566:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  for(n = 0; s[n]; n++)
    156a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1571:	eb 04                	jmp    1577 <strlen+0x1d>
    1573:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1577:	8b 45 fc             	mov    -0x4(%rbp),%eax
    157a:	48 63 d0             	movslq %eax,%rdx
    157d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1581:	48 01 d0             	add    %rdx,%rax
    1584:	0f b6 00             	movzbl (%rax),%eax
    1587:	84 c0                	test   %al,%al
    1589:	75 e8                	jne    1573 <strlen+0x19>
  return n;
    158b:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    158e:	c9                   	leave
    158f:	c3                   	ret

0000000000001590 <memset>:
{
    1590:	f3 0f 1e fa          	endbr64
    1594:	55                   	push   %rbp
    1595:	48 89 e5             	mov    %rsp,%rbp
    1598:	48 83 ec 10          	sub    $0x10,%rsp
    159c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    15a0:	89 75 f4             	mov    %esi,-0xc(%rbp)
    15a3:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    15a6:	8b 55 f0             	mov    -0x10(%rbp),%edx
    15a9:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    15ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    15b0:	89 ce                	mov    %ecx,%esi
    15b2:	48 89 c7             	mov    %rax,%rdi
    15b5:	48 b8 82 14 00 00 00 	movabs $0x1482,%rax
    15bc:	00 00 00 
    15bf:	ff d0                	call   *%rax
  return dst;
    15c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    15c5:	c9                   	leave
    15c6:	c3                   	ret

00000000000015c7 <strchr>:
{
    15c7:	f3 0f 1e fa          	endbr64
    15cb:	55                   	push   %rbp
    15cc:	48 89 e5             	mov    %rsp,%rbp
    15cf:	48 83 ec 10          	sub    $0x10,%rsp
    15d3:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    15d7:	89 f0                	mov    %esi,%eax
    15d9:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    15dc:	eb 17                	jmp    15f5 <strchr+0x2e>
    if(*s == c)
    15de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    15e2:	0f b6 00             	movzbl (%rax),%eax
    15e5:	38 45 f4             	cmp    %al,-0xc(%rbp)
    15e8:	75 06                	jne    15f0 <strchr+0x29>
      return (char*)s;
    15ea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    15ee:	eb 15                	jmp    1605 <strchr+0x3e>
  for(; *s; s++)
    15f0:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    15f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    15f9:	0f b6 00             	movzbl (%rax),%eax
    15fc:	84 c0                	test   %al,%al
    15fe:	75 de                	jne    15de <strchr+0x17>
  return 0;
    1600:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1605:	c9                   	leave
    1606:	c3                   	ret

0000000000001607 <gets>:

char*
gets(char *buf, int max)
{
    1607:	f3 0f 1e fa          	endbr64
    160b:	55                   	push   %rbp
    160c:	48 89 e5             	mov    %rsp,%rbp
    160f:	48 83 ec 20          	sub    $0x20,%rsp
    1613:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1617:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    161a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1621:	eb 4f                	jmp    1672 <gets+0x6b>
    cc = read(0, &c, 1);
    1623:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    1627:	ba 01 00 00 00       	mov    $0x1,%edx
    162c:	48 89 c6             	mov    %rax,%rsi
    162f:	bf 00 00 00 00       	mov    $0x0,%edi
    1634:	48 b8 ec 17 00 00 00 	movabs $0x17ec,%rax
    163b:	00 00 00 
    163e:	ff d0                	call   *%rax
    1640:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    1643:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1647:	7e 36                	jle    167f <gets+0x78>
      break;
    buf[i++] = c;
    1649:	8b 45 fc             	mov    -0x4(%rbp),%eax
    164c:	8d 50 01             	lea    0x1(%rax),%edx
    164f:	89 55 fc             	mov    %edx,-0x4(%rbp)
    1652:	48 63 d0             	movslq %eax,%rdx
    1655:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1659:	48 01 c2             	add    %rax,%rdx
    165c:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1660:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    1662:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1666:	3c 0a                	cmp    $0xa,%al
    1668:	74 16                	je     1680 <gets+0x79>
    166a:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    166e:	3c 0d                	cmp    $0xd,%al
    1670:	74 0e                	je     1680 <gets+0x79>
  for(i=0; i+1 < max; ){
    1672:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1675:	83 c0 01             	add    $0x1,%eax
    1678:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    167b:	7f a6                	jg     1623 <gets+0x1c>
    167d:	eb 01                	jmp    1680 <gets+0x79>
      break;
    167f:	90                   	nop
      break;
  }
  buf[i] = '\0';
    1680:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1683:	48 63 d0             	movslq %eax,%rdx
    1686:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    168a:	48 01 d0             	add    %rdx,%rax
    168d:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    1690:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    1694:	c9                   	leave
    1695:	c3                   	ret

0000000000001696 <stat>:

int
stat(char *n, struct stat *st)
{
    1696:	f3 0f 1e fa          	endbr64
    169a:	55                   	push   %rbp
    169b:	48 89 e5             	mov    %rsp,%rbp
    169e:	48 83 ec 20          	sub    $0x20,%rsp
    16a2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    16a6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    16aa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    16ae:	be 00 00 00 00       	mov    $0x0,%esi
    16b3:	48 89 c7             	mov    %rax,%rdi
    16b6:	48 b8 2d 18 00 00 00 	movabs $0x182d,%rax
    16bd:	00 00 00 
    16c0:	ff d0                	call   *%rax
    16c2:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    16c5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    16c9:	79 07                	jns    16d2 <stat+0x3c>
    return -1;
    16cb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    16d0:	eb 2f                	jmp    1701 <stat+0x6b>
  r = fstat(fd, st);
    16d2:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    16d6:	8b 45 fc             	mov    -0x4(%rbp),%eax
    16d9:	48 89 d6             	mov    %rdx,%rsi
    16dc:	89 c7                	mov    %eax,%edi
    16de:	48 b8 54 18 00 00 00 	movabs $0x1854,%rax
    16e5:	00 00 00 
    16e8:	ff d0                	call   *%rax
    16ea:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    16ed:	8b 45 fc             	mov    -0x4(%rbp),%eax
    16f0:	89 c7                	mov    %eax,%edi
    16f2:	48 b8 06 18 00 00 00 	movabs $0x1806,%rax
    16f9:	00 00 00 
    16fc:	ff d0                	call   *%rax
  return r;
    16fe:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    1701:	c9                   	leave
    1702:	c3                   	ret

0000000000001703 <atoi>:

int
atoi(const char *s)
{
    1703:	f3 0f 1e fa          	endbr64
    1707:	55                   	push   %rbp
    1708:	48 89 e5             	mov    %rsp,%rbp
    170b:	48 83 ec 18          	sub    $0x18,%rsp
    170f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    1713:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    171a:	eb 28                	jmp    1744 <atoi+0x41>
    n = n*10 + *s++ - '0';
    171c:	8b 55 fc             	mov    -0x4(%rbp),%edx
    171f:	89 d0                	mov    %edx,%eax
    1721:	c1 e0 02             	shl    $0x2,%eax
    1724:	01 d0                	add    %edx,%eax
    1726:	01 c0                	add    %eax,%eax
    1728:	89 c1                	mov    %eax,%ecx
    172a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    172e:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1732:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    1736:	0f b6 00             	movzbl (%rax),%eax
    1739:	0f be c0             	movsbl %al,%eax
    173c:	01 c8                	add    %ecx,%eax
    173e:	83 e8 30             	sub    $0x30,%eax
    1741:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1744:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1748:	0f b6 00             	movzbl (%rax),%eax
    174b:	3c 2f                	cmp    $0x2f,%al
    174d:	7e 0b                	jle    175a <atoi+0x57>
    174f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1753:	0f b6 00             	movzbl (%rax),%eax
    1756:	3c 39                	cmp    $0x39,%al
    1758:	7e c2                	jle    171c <atoi+0x19>
  return n;
    175a:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    175d:	c9                   	leave
    175e:	c3                   	ret

000000000000175f <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    175f:	f3 0f 1e fa          	endbr64
    1763:	55                   	push   %rbp
    1764:	48 89 e5             	mov    %rsp,%rbp
    1767:	48 83 ec 28          	sub    $0x28,%rsp
    176b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    176f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    1773:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    1776:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    177a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    177e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1782:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    1786:	eb 1d                	jmp    17a5 <memmove+0x46>
    *dst++ = *src++;
    1788:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    178c:	48 8d 42 01          	lea    0x1(%rdx),%rax
    1790:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1794:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1798:	48 8d 48 01          	lea    0x1(%rax),%rcx
    179c:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    17a0:	0f b6 12             	movzbl (%rdx),%edx
    17a3:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    17a5:	8b 45 dc             	mov    -0x24(%rbp),%eax
    17a8:	8d 50 ff             	lea    -0x1(%rax),%edx
    17ab:	89 55 dc             	mov    %edx,-0x24(%rbp)
    17ae:	85 c0                	test   %eax,%eax
    17b0:	7f d6                	jg     1788 <memmove+0x29>
  return vdst;
    17b2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    17b6:	c9                   	leave
    17b7:	c3                   	ret

00000000000017b8 <fork>:
    17b8:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    17bf:	49 89 ca             	mov    %rcx,%r10
    17c2:	0f 05                	syscall
    17c4:	c3                   	ret

00000000000017c5 <exit>:
    17c5:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    17cc:	49 89 ca             	mov    %rcx,%r10
    17cf:	0f 05                	syscall
    17d1:	c3                   	ret

00000000000017d2 <wait>:
    17d2:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    17d9:	49 89 ca             	mov    %rcx,%r10
    17dc:	0f 05                	syscall
    17de:	c3                   	ret

00000000000017df <pipe>:
    17df:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    17e6:	49 89 ca             	mov    %rcx,%r10
    17e9:	0f 05                	syscall
    17eb:	c3                   	ret

00000000000017ec <read>:
    17ec:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    17f3:	49 89 ca             	mov    %rcx,%r10
    17f6:	0f 05                	syscall
    17f8:	c3                   	ret

00000000000017f9 <write>:
    17f9:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    1800:	49 89 ca             	mov    %rcx,%r10
    1803:	0f 05                	syscall
    1805:	c3                   	ret

0000000000001806 <close>:
    1806:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    180d:	49 89 ca             	mov    %rcx,%r10
    1810:	0f 05                	syscall
    1812:	c3                   	ret

0000000000001813 <kill>:
    1813:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    181a:	49 89 ca             	mov    %rcx,%r10
    181d:	0f 05                	syscall
    181f:	c3                   	ret

0000000000001820 <exec>:
    1820:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    1827:	49 89 ca             	mov    %rcx,%r10
    182a:	0f 05                	syscall
    182c:	c3                   	ret

000000000000182d <open>:
    182d:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    1834:	49 89 ca             	mov    %rcx,%r10
    1837:	0f 05                	syscall
    1839:	c3                   	ret

000000000000183a <mknod>:
    183a:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    1841:	49 89 ca             	mov    %rcx,%r10
    1844:	0f 05                	syscall
    1846:	c3                   	ret

0000000000001847 <unlink>:
    1847:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    184e:	49 89 ca             	mov    %rcx,%r10
    1851:	0f 05                	syscall
    1853:	c3                   	ret

0000000000001854 <fstat>:
    1854:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    185b:	49 89 ca             	mov    %rcx,%r10
    185e:	0f 05                	syscall
    1860:	c3                   	ret

0000000000001861 <link>:
    1861:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    1868:	49 89 ca             	mov    %rcx,%r10
    186b:	0f 05                	syscall
    186d:	c3                   	ret

000000000000186e <mkdir>:
    186e:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    1875:	49 89 ca             	mov    %rcx,%r10
    1878:	0f 05                	syscall
    187a:	c3                   	ret

000000000000187b <chdir>:
    187b:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    1882:	49 89 ca             	mov    %rcx,%r10
    1885:	0f 05                	syscall
    1887:	c3                   	ret

0000000000001888 <dup>:
    1888:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    188f:	49 89 ca             	mov    %rcx,%r10
    1892:	0f 05                	syscall
    1894:	c3                   	ret

0000000000001895 <getpid>:
    1895:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    189c:	49 89 ca             	mov    %rcx,%r10
    189f:	0f 05                	syscall
    18a1:	c3                   	ret

00000000000018a2 <sbrk>:
    18a2:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    18a9:	49 89 ca             	mov    %rcx,%r10
    18ac:	0f 05                	syscall
    18ae:	c3                   	ret

00000000000018af <sleep>:
    18af:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    18b6:	49 89 ca             	mov    %rcx,%r10
    18b9:	0f 05                	syscall
    18bb:	c3                   	ret

00000000000018bc <uptime>:
    18bc:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    18c3:	49 89 ca             	mov    %rcx,%r10
    18c6:	0f 05                	syscall
    18c8:	c3                   	ret

00000000000018c9 <send>:
    18c9:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    18d0:	49 89 ca             	mov    %rcx,%r10
    18d3:	0f 05                	syscall
    18d5:	c3                   	ret

00000000000018d6 <recv>:
    18d6:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    18dd:	49 89 ca             	mov    %rcx,%r10
    18e0:	0f 05                	syscall
    18e2:	c3                   	ret

00000000000018e3 <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    18e3:	f3 0f 1e fa          	endbr64
    18e7:	55                   	push   %rbp
    18e8:	48 89 e5             	mov    %rsp,%rbp
    18eb:	48 83 ec 10          	sub    $0x10,%rsp
    18ef:	89 7d fc             	mov    %edi,-0x4(%rbp)
    18f2:	89 f0                	mov    %esi,%eax
    18f4:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    18f7:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    18fb:	8b 45 fc             	mov    -0x4(%rbp),%eax
    18fe:	ba 01 00 00 00       	mov    $0x1,%edx
    1903:	48 89 ce             	mov    %rcx,%rsi
    1906:	89 c7                	mov    %eax,%edi
    1908:	48 b8 f9 17 00 00 00 	movabs $0x17f9,%rax
    190f:	00 00 00 
    1912:	ff d0                	call   *%rax
}
    1914:	90                   	nop
    1915:	c9                   	leave
    1916:	c3                   	ret

0000000000001917 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    1917:	f3 0f 1e fa          	endbr64
    191b:	55                   	push   %rbp
    191c:	48 89 e5             	mov    %rsp,%rbp
    191f:	48 83 ec 20          	sub    $0x20,%rsp
    1923:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1926:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    192a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1931:	eb 35                	jmp    1968 <print_x64+0x51>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    1933:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1937:	48 c1 e8 3c          	shr    $0x3c,%rax
    193b:	48 ba c0 22 00 00 00 	movabs $0x22c0,%rdx
    1942:	00 00 00 
    1945:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1949:	0f be d0             	movsbl %al,%edx
    194c:	8b 45 ec             	mov    -0x14(%rbp),%eax
    194f:	89 d6                	mov    %edx,%esi
    1951:	89 c7                	mov    %eax,%edi
    1953:	48 b8 e3 18 00 00 00 	movabs $0x18e3,%rax
    195a:	00 00 00 
    195d:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    195f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1963:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    1968:	8b 45 fc             	mov    -0x4(%rbp),%eax
    196b:	83 f8 0f             	cmp    $0xf,%eax
    196e:	76 c3                	jbe    1933 <print_x64+0x1c>
}
    1970:	90                   	nop
    1971:	90                   	nop
    1972:	c9                   	leave
    1973:	c3                   	ret

0000000000001974 <print_x32>:

  static void
print_x32(int fd, uint x)
{
    1974:	f3 0f 1e fa          	endbr64
    1978:	55                   	push   %rbp
    1979:	48 89 e5             	mov    %rsp,%rbp
    197c:	48 83 ec 20          	sub    $0x20,%rsp
    1980:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1983:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1986:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    198d:	eb 36                	jmp    19c5 <print_x32+0x51>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    198f:	8b 45 e8             	mov    -0x18(%rbp),%eax
    1992:	c1 e8 1c             	shr    $0x1c,%eax
    1995:	89 c2                	mov    %eax,%edx
    1997:	48 b8 c0 22 00 00 00 	movabs $0x22c0,%rax
    199e:	00 00 00 
    19a1:	89 d2                	mov    %edx,%edx
    19a3:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    19a7:	0f be d0             	movsbl %al,%edx
    19aa:	8b 45 ec             	mov    -0x14(%rbp),%eax
    19ad:	89 d6                	mov    %edx,%esi
    19af:	89 c7                	mov    %eax,%edi
    19b1:	48 b8 e3 18 00 00 00 	movabs $0x18e3,%rax
    19b8:	00 00 00 
    19bb:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    19bd:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    19c1:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    19c5:	8b 45 fc             	mov    -0x4(%rbp),%eax
    19c8:	83 f8 07             	cmp    $0x7,%eax
    19cb:	76 c2                	jbe    198f <print_x32+0x1b>
}
    19cd:	90                   	nop
    19ce:	90                   	nop
    19cf:	c9                   	leave
    19d0:	c3                   	ret

00000000000019d1 <print_d>:

  static void
print_d(int fd, int v)
{
    19d1:	f3 0f 1e fa          	endbr64
    19d5:	55                   	push   %rbp
    19d6:	48 89 e5             	mov    %rsp,%rbp
    19d9:	48 83 ec 30          	sub    $0x30,%rsp
    19dd:	89 7d dc             	mov    %edi,-0x24(%rbp)
    19e0:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    19e3:	8b 45 d8             	mov    -0x28(%rbp),%eax
    19e6:	48 98                	cltq
    19e8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    19ec:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    19f0:	79 04                	jns    19f6 <print_d+0x25>
    x = -x;
    19f2:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    19f6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    19fd:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1a01:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1a08:	66 66 66 
    1a0b:	48 89 c8             	mov    %rcx,%rax
    1a0e:	48 f7 ea             	imul   %rdx
    1a11:	48 c1 fa 02          	sar    $0x2,%rdx
    1a15:	48 89 c8             	mov    %rcx,%rax
    1a18:	48 c1 f8 3f          	sar    $0x3f,%rax
    1a1c:	48 29 c2             	sub    %rax,%rdx
    1a1f:	48 89 d0             	mov    %rdx,%rax
    1a22:	48 c1 e0 02          	shl    $0x2,%rax
    1a26:	48 01 d0             	add    %rdx,%rax
    1a29:	48 01 c0             	add    %rax,%rax
    1a2c:	48 29 c1             	sub    %rax,%rcx
    1a2f:	48 89 ca             	mov    %rcx,%rdx
    1a32:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1a35:	8d 48 01             	lea    0x1(%rax),%ecx
    1a38:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    1a3b:	48 b9 c0 22 00 00 00 	movabs $0x22c0,%rcx
    1a42:	00 00 00 
    1a45:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    1a49:	48 98                	cltq
    1a4b:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    1a4f:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1a53:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1a5a:	66 66 66 
    1a5d:	48 89 c8             	mov    %rcx,%rax
    1a60:	48 f7 ea             	imul   %rdx
    1a63:	48 89 d0             	mov    %rdx,%rax
    1a66:	48 c1 f8 02          	sar    $0x2,%rax
    1a6a:	48 c1 f9 3f          	sar    $0x3f,%rcx
    1a6e:	48 89 ca             	mov    %rcx,%rdx
    1a71:	48 29 d0             	sub    %rdx,%rax
    1a74:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    1a78:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1a7d:	0f 85 7a ff ff ff    	jne    19fd <print_d+0x2c>

  if (v < 0)
    1a83:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1a87:	79 32                	jns    1abb <print_d+0xea>
    buf[i++] = '-';
    1a89:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1a8c:	8d 50 01             	lea    0x1(%rax),%edx
    1a8f:	89 55 f4             	mov    %edx,-0xc(%rbp)
    1a92:	48 98                	cltq
    1a94:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    1a99:	eb 20                	jmp    1abb <print_d+0xea>
    putc(fd, buf[i]);
    1a9b:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1a9e:	48 98                	cltq
    1aa0:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    1aa5:	0f be d0             	movsbl %al,%edx
    1aa8:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1aab:	89 d6                	mov    %edx,%esi
    1aad:	89 c7                	mov    %eax,%edi
    1aaf:	48 b8 e3 18 00 00 00 	movabs $0x18e3,%rax
    1ab6:	00 00 00 
    1ab9:	ff d0                	call   *%rax
  while (--i >= 0)
    1abb:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    1abf:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1ac3:	79 d6                	jns    1a9b <print_d+0xca>
}
    1ac5:	90                   	nop
    1ac6:	90                   	nop
    1ac7:	c9                   	leave
    1ac8:	c3                   	ret

0000000000001ac9 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    1ac9:	f3 0f 1e fa          	endbr64
    1acd:	55                   	push   %rbp
    1ace:	48 89 e5             	mov    %rsp,%rbp
    1ad1:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    1ad8:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    1ade:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    1ae5:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    1aec:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    1af3:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    1afa:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    1b01:	84 c0                	test   %al,%al
    1b03:	74 20                	je     1b25 <printf+0x5c>
    1b05:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    1b09:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    1b0d:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    1b11:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    1b15:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    1b19:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    1b1d:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    1b21:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    1b25:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    1b2c:	00 00 00 
    1b2f:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    1b36:	00 00 00 
    1b39:	48 8d 45 10          	lea    0x10(%rbp),%rax
    1b3d:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    1b44:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    1b4b:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1b52:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    1b59:	00 00 00 
    1b5c:	e9 41 03 00 00       	jmp    1ea2 <printf+0x3d9>
    if (c != '%') {
    1b61:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1b68:	74 24                	je     1b8e <printf+0xc5>
      putc(fd, c);
    1b6a:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1b70:	0f be d0             	movsbl %al,%edx
    1b73:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b79:	89 d6                	mov    %edx,%esi
    1b7b:	89 c7                	mov    %eax,%edi
    1b7d:	48 b8 e3 18 00 00 00 	movabs $0x18e3,%rax
    1b84:	00 00 00 
    1b87:	ff d0                	call   *%rax
      continue;
    1b89:	e9 0d 03 00 00       	jmp    1e9b <printf+0x3d2>
    }
    c = fmt[++i] & 0xff;
    1b8e:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1b95:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1b9b:	48 63 d0             	movslq %eax,%rdx
    1b9e:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1ba5:	48 01 d0             	add    %rdx,%rax
    1ba8:	0f b6 00             	movzbl (%rax),%eax
    1bab:	0f be c0             	movsbl %al,%eax
    1bae:	25 ff 00 00 00       	and    $0xff,%eax
    1bb3:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    1bb9:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1bc0:	0f 84 0f 03 00 00    	je     1ed5 <printf+0x40c>
      break;
    switch(c) {
    1bc6:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1bcd:	0f 84 74 02 00 00    	je     1e47 <printf+0x37e>
    1bd3:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1bda:	0f 8c 82 02 00 00    	jl     1e62 <printf+0x399>
    1be0:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    1be7:	0f 8f 75 02 00 00    	jg     1e62 <printf+0x399>
    1bed:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    1bf4:	0f 8c 68 02 00 00    	jl     1e62 <printf+0x399>
    1bfa:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1c00:	83 e8 63             	sub    $0x63,%eax
    1c03:	83 f8 15             	cmp    $0x15,%eax
    1c06:	0f 87 56 02 00 00    	ja     1e62 <printf+0x399>
    1c0c:	89 c0                	mov    %eax,%eax
    1c0e:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1c15:	00 
    1c16:	48 b8 10 22 00 00 00 	movabs $0x2210,%rax
    1c1d:	00 00 00 
    1c20:	48 01 d0             	add    %rdx,%rax
    1c23:	48 8b 00             	mov    (%rax),%rax
    1c26:	3e ff e0             	notrack jmp *%rax
    case 'c':
      putc(fd, va_arg(ap, int));
    1c29:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1c2f:	83 f8 2f             	cmp    $0x2f,%eax
    1c32:	77 23                	ja     1c57 <printf+0x18e>
    1c34:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1c3b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1c41:	89 d2                	mov    %edx,%edx
    1c43:	48 01 d0             	add    %rdx,%rax
    1c46:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1c4c:	83 c2 08             	add    $0x8,%edx
    1c4f:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1c55:	eb 12                	jmp    1c69 <printf+0x1a0>
    1c57:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1c5e:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1c62:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1c69:	8b 00                	mov    (%rax),%eax
    1c6b:	0f be d0             	movsbl %al,%edx
    1c6e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1c74:	89 d6                	mov    %edx,%esi
    1c76:	89 c7                	mov    %eax,%edi
    1c78:	48 b8 e3 18 00 00 00 	movabs $0x18e3,%rax
    1c7f:	00 00 00 
    1c82:	ff d0                	call   *%rax
      break;
    1c84:	e9 12 02 00 00       	jmp    1e9b <printf+0x3d2>
    case 'd':
      print_d(fd, va_arg(ap, int));
    1c89:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1c8f:	83 f8 2f             	cmp    $0x2f,%eax
    1c92:	77 23                	ja     1cb7 <printf+0x1ee>
    1c94:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1c9b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1ca1:	89 d2                	mov    %edx,%edx
    1ca3:	48 01 d0             	add    %rdx,%rax
    1ca6:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1cac:	83 c2 08             	add    $0x8,%edx
    1caf:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1cb5:	eb 12                	jmp    1cc9 <printf+0x200>
    1cb7:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1cbe:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1cc2:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1cc9:	8b 10                	mov    (%rax),%edx
    1ccb:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1cd1:	89 d6                	mov    %edx,%esi
    1cd3:	89 c7                	mov    %eax,%edi
    1cd5:	48 b8 d1 19 00 00 00 	movabs $0x19d1,%rax
    1cdc:	00 00 00 
    1cdf:	ff d0                	call   *%rax
      break;
    1ce1:	e9 b5 01 00 00       	jmp    1e9b <printf+0x3d2>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    1ce6:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1cec:	83 f8 2f             	cmp    $0x2f,%eax
    1cef:	77 23                	ja     1d14 <printf+0x24b>
    1cf1:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1cf8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1cfe:	89 d2                	mov    %edx,%edx
    1d00:	48 01 d0             	add    %rdx,%rax
    1d03:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1d09:	83 c2 08             	add    $0x8,%edx
    1d0c:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1d12:	eb 12                	jmp    1d26 <printf+0x25d>
    1d14:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1d1b:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1d1f:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1d26:	8b 10                	mov    (%rax),%edx
    1d28:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1d2e:	89 d6                	mov    %edx,%esi
    1d30:	89 c7                	mov    %eax,%edi
    1d32:	48 b8 74 19 00 00 00 	movabs $0x1974,%rax
    1d39:	00 00 00 
    1d3c:	ff d0                	call   *%rax
      break;
    1d3e:	e9 58 01 00 00       	jmp    1e9b <printf+0x3d2>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    1d43:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1d49:	83 f8 2f             	cmp    $0x2f,%eax
    1d4c:	77 23                	ja     1d71 <printf+0x2a8>
    1d4e:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1d55:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1d5b:	89 d2                	mov    %edx,%edx
    1d5d:	48 01 d0             	add    %rdx,%rax
    1d60:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1d66:	83 c2 08             	add    $0x8,%edx
    1d69:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1d6f:	eb 12                	jmp    1d83 <printf+0x2ba>
    1d71:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1d78:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1d7c:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1d83:	48 8b 10             	mov    (%rax),%rdx
    1d86:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1d8c:	48 89 d6             	mov    %rdx,%rsi
    1d8f:	89 c7                	mov    %eax,%edi
    1d91:	48 b8 17 19 00 00 00 	movabs $0x1917,%rax
    1d98:	00 00 00 
    1d9b:	ff d0                	call   *%rax
      break;
    1d9d:	e9 f9 00 00 00       	jmp    1e9b <printf+0x3d2>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    1da2:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1da8:	83 f8 2f             	cmp    $0x2f,%eax
    1dab:	77 23                	ja     1dd0 <printf+0x307>
    1dad:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1db4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1dba:	89 d2                	mov    %edx,%edx
    1dbc:	48 01 d0             	add    %rdx,%rax
    1dbf:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1dc5:	83 c2 08             	add    $0x8,%edx
    1dc8:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1dce:	eb 12                	jmp    1de2 <printf+0x319>
    1dd0:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1dd7:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1ddb:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1de2:	48 8b 00             	mov    (%rax),%rax
    1de5:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    1dec:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1df3:	00 
    1df4:	75 41                	jne    1e37 <printf+0x36e>
        s = "(null)";
    1df6:	48 b8 08 22 00 00 00 	movabs $0x2208,%rax
    1dfd:	00 00 00 
    1e00:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1e07:	eb 2e                	jmp    1e37 <printf+0x36e>
        putc(fd, *(s++));
    1e09:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1e10:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1e14:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1e1b:	0f b6 00             	movzbl (%rax),%eax
    1e1e:	0f be d0             	movsbl %al,%edx
    1e21:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1e27:	89 d6                	mov    %edx,%esi
    1e29:	89 c7                	mov    %eax,%edi
    1e2b:	48 b8 e3 18 00 00 00 	movabs $0x18e3,%rax
    1e32:	00 00 00 
    1e35:	ff d0                	call   *%rax
      while (*s)
    1e37:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1e3e:	0f b6 00             	movzbl (%rax),%eax
    1e41:	84 c0                	test   %al,%al
    1e43:	75 c4                	jne    1e09 <printf+0x340>
      break;
    1e45:	eb 54                	jmp    1e9b <printf+0x3d2>
    case '%':
      putc(fd, '%');
    1e47:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1e4d:	be 25 00 00 00       	mov    $0x25,%esi
    1e52:	89 c7                	mov    %eax,%edi
    1e54:	48 b8 e3 18 00 00 00 	movabs $0x18e3,%rax
    1e5b:	00 00 00 
    1e5e:	ff d0                	call   *%rax
      break;
    1e60:	eb 39                	jmp    1e9b <printf+0x3d2>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1e62:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1e68:	be 25 00 00 00       	mov    $0x25,%esi
    1e6d:	89 c7                	mov    %eax,%edi
    1e6f:	48 b8 e3 18 00 00 00 	movabs $0x18e3,%rax
    1e76:	00 00 00 
    1e79:	ff d0                	call   *%rax
      putc(fd, c);
    1e7b:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1e81:	0f be d0             	movsbl %al,%edx
    1e84:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1e8a:	89 d6                	mov    %edx,%esi
    1e8c:	89 c7                	mov    %eax,%edi
    1e8e:	48 b8 e3 18 00 00 00 	movabs $0x18e3,%rax
    1e95:	00 00 00 
    1e98:	ff d0                	call   *%rax
      break;
    1e9a:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1e9b:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1ea2:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1ea8:	48 63 d0             	movslq %eax,%rdx
    1eab:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1eb2:	48 01 d0             	add    %rdx,%rax
    1eb5:	0f b6 00             	movzbl (%rax),%eax
    1eb8:	0f be c0             	movsbl %al,%eax
    1ebb:	25 ff 00 00 00       	and    $0xff,%eax
    1ec0:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1ec6:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1ecd:	0f 85 8e fc ff ff    	jne    1b61 <printf+0x98>
    }
  }
}
    1ed3:	eb 01                	jmp    1ed6 <printf+0x40d>
      break;
    1ed5:	90                   	nop
}
    1ed6:	90                   	nop
    1ed7:	c9                   	leave
    1ed8:	c3                   	ret

0000000000001ed9 <free>:
    1ed9:	55                   	push   %rbp
    1eda:	48 89 e5             	mov    %rsp,%rbp
    1edd:	48 83 ec 18          	sub    $0x18,%rsp
    1ee1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1ee5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1ee9:	48 83 e8 10          	sub    $0x10,%rax
    1eed:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1ef1:	48 b8 f0 26 00 00 00 	movabs $0x26f0,%rax
    1ef8:	00 00 00 
    1efb:	48 8b 00             	mov    (%rax),%rax
    1efe:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1f02:	eb 2f                	jmp    1f33 <free+0x5a>
    1f04:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f08:	48 8b 00             	mov    (%rax),%rax
    1f0b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1f0f:	72 17                	jb     1f28 <free+0x4f>
    1f11:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f15:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1f19:	72 2f                	jb     1f4a <free+0x71>
    1f1b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f1f:	48 8b 00             	mov    (%rax),%rax
    1f22:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1f26:	72 22                	jb     1f4a <free+0x71>
    1f28:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f2c:	48 8b 00             	mov    (%rax),%rax
    1f2f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1f33:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f37:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1f3b:	73 c7                	jae    1f04 <free+0x2b>
    1f3d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f41:	48 8b 00             	mov    (%rax),%rax
    1f44:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1f48:	73 ba                	jae    1f04 <free+0x2b>
    1f4a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f4e:	8b 40 08             	mov    0x8(%rax),%eax
    1f51:	89 c0                	mov    %eax,%eax
    1f53:	48 c1 e0 04          	shl    $0x4,%rax
    1f57:	48 89 c2             	mov    %rax,%rdx
    1f5a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f5e:	48 01 c2             	add    %rax,%rdx
    1f61:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f65:	48 8b 00             	mov    (%rax),%rax
    1f68:	48 39 c2             	cmp    %rax,%rdx
    1f6b:	75 2d                	jne    1f9a <free+0xc1>
    1f6d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f71:	8b 50 08             	mov    0x8(%rax),%edx
    1f74:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f78:	48 8b 00             	mov    (%rax),%rax
    1f7b:	8b 40 08             	mov    0x8(%rax),%eax
    1f7e:	01 c2                	add    %eax,%edx
    1f80:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f84:	89 50 08             	mov    %edx,0x8(%rax)
    1f87:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f8b:	48 8b 00             	mov    (%rax),%rax
    1f8e:	48 8b 10             	mov    (%rax),%rdx
    1f91:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f95:	48 89 10             	mov    %rdx,(%rax)
    1f98:	eb 0e                	jmp    1fa8 <free+0xcf>
    1f9a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f9e:	48 8b 10             	mov    (%rax),%rdx
    1fa1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1fa5:	48 89 10             	mov    %rdx,(%rax)
    1fa8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1fac:	8b 40 08             	mov    0x8(%rax),%eax
    1faf:	89 c0                	mov    %eax,%eax
    1fb1:	48 c1 e0 04          	shl    $0x4,%rax
    1fb5:	48 89 c2             	mov    %rax,%rdx
    1fb8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1fbc:	48 01 d0             	add    %rdx,%rax
    1fbf:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1fc3:	75 27                	jne    1fec <free+0x113>
    1fc5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1fc9:	8b 50 08             	mov    0x8(%rax),%edx
    1fcc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1fd0:	8b 40 08             	mov    0x8(%rax),%eax
    1fd3:	01 c2                	add    %eax,%edx
    1fd5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1fd9:	89 50 08             	mov    %edx,0x8(%rax)
    1fdc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1fe0:	48 8b 10             	mov    (%rax),%rdx
    1fe3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1fe7:	48 89 10             	mov    %rdx,(%rax)
    1fea:	eb 0b                	jmp    1ff7 <free+0x11e>
    1fec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ff0:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1ff4:	48 89 10             	mov    %rdx,(%rax)
    1ff7:	48 ba f0 26 00 00 00 	movabs $0x26f0,%rdx
    1ffe:	00 00 00 
    2001:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2005:	48 89 02             	mov    %rax,(%rdx)
    2008:	90                   	nop
    2009:	c9                   	leave
    200a:	c3                   	ret

000000000000200b <morecore>:
    200b:	55                   	push   %rbp
    200c:	48 89 e5             	mov    %rsp,%rbp
    200f:	48 83 ec 20          	sub    $0x20,%rsp
    2013:	89 7d ec             	mov    %edi,-0x14(%rbp)
    2016:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    201d:	77 07                	ja     2026 <morecore+0x1b>
    201f:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
    2026:	8b 45 ec             	mov    -0x14(%rbp),%eax
    2029:	48 c1 e0 04          	shl    $0x4,%rax
    202d:	48 89 c7             	mov    %rax,%rdi
    2030:	48 b8 a2 18 00 00 00 	movabs $0x18a2,%rax
    2037:	00 00 00 
    203a:	ff d0                	call   *%rax
    203c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    2040:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    2045:	75 07                	jne    204e <morecore+0x43>
    2047:	b8 00 00 00 00       	mov    $0x0,%eax
    204c:	eb 36                	jmp    2084 <morecore+0x79>
    204e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2052:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    2056:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    205a:	8b 55 ec             	mov    -0x14(%rbp),%edx
    205d:	89 50 08             	mov    %edx,0x8(%rax)
    2060:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2064:	48 83 c0 10          	add    $0x10,%rax
    2068:	48 89 c7             	mov    %rax,%rdi
    206b:	48 b8 d9 1e 00 00 00 	movabs $0x1ed9,%rax
    2072:	00 00 00 
    2075:	ff d0                	call   *%rax
    2077:	48 b8 f0 26 00 00 00 	movabs $0x26f0,%rax
    207e:	00 00 00 
    2081:	48 8b 00             	mov    (%rax),%rax
    2084:	c9                   	leave
    2085:	c3                   	ret

0000000000002086 <malloc>:
    2086:	55                   	push   %rbp
    2087:	48 89 e5             	mov    %rsp,%rbp
    208a:	48 83 ec 30          	sub    $0x30,%rsp
    208e:	89 7d dc             	mov    %edi,-0x24(%rbp)
    2091:	8b 45 dc             	mov    -0x24(%rbp),%eax
    2094:	48 83 c0 0f          	add    $0xf,%rax
    2098:	48 c1 e8 04          	shr    $0x4,%rax
    209c:	83 c0 01             	add    $0x1,%eax
    209f:	89 45 ec             	mov    %eax,-0x14(%rbp)
    20a2:	48 b8 f0 26 00 00 00 	movabs $0x26f0,%rax
    20a9:	00 00 00 
    20ac:	48 8b 00             	mov    (%rax),%rax
    20af:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    20b3:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    20b8:	75 4a                	jne    2104 <malloc+0x7e>
    20ba:	48 b8 e0 26 00 00 00 	movabs $0x26e0,%rax
    20c1:	00 00 00 
    20c4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    20c8:	48 ba f0 26 00 00 00 	movabs $0x26f0,%rdx
    20cf:	00 00 00 
    20d2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    20d6:	48 89 02             	mov    %rax,(%rdx)
    20d9:	48 b8 f0 26 00 00 00 	movabs $0x26f0,%rax
    20e0:	00 00 00 
    20e3:	48 8b 00             	mov    (%rax),%rax
    20e6:	48 ba e0 26 00 00 00 	movabs $0x26e0,%rdx
    20ed:	00 00 00 
    20f0:	48 89 02             	mov    %rax,(%rdx)
    20f3:	48 b8 e0 26 00 00 00 	movabs $0x26e0,%rax
    20fa:	00 00 00 
    20fd:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
    2104:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2108:	48 8b 00             	mov    (%rax),%rax
    210b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    210f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2113:	8b 40 08             	mov    0x8(%rax),%eax
    2116:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    2119:	72 65                	jb     2180 <malloc+0xfa>
    211b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    211f:	8b 40 08             	mov    0x8(%rax),%eax
    2122:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    2125:	75 10                	jne    2137 <malloc+0xb1>
    2127:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    212b:	48 8b 10             	mov    (%rax),%rdx
    212e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2132:	48 89 10             	mov    %rdx,(%rax)
    2135:	eb 2e                	jmp    2165 <malloc+0xdf>
    2137:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    213b:	8b 40 08             	mov    0x8(%rax),%eax
    213e:	2b 45 ec             	sub    -0x14(%rbp),%eax
    2141:	89 c2                	mov    %eax,%edx
    2143:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2147:	89 50 08             	mov    %edx,0x8(%rax)
    214a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    214e:	8b 40 08             	mov    0x8(%rax),%eax
    2151:	89 c0                	mov    %eax,%eax
    2153:	48 c1 e0 04          	shl    $0x4,%rax
    2157:	48 01 45 f8          	add    %rax,-0x8(%rbp)
    215b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    215f:	8b 55 ec             	mov    -0x14(%rbp),%edx
    2162:	89 50 08             	mov    %edx,0x8(%rax)
    2165:	48 ba f0 26 00 00 00 	movabs $0x26f0,%rdx
    216c:	00 00 00 
    216f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2173:	48 89 02             	mov    %rax,(%rdx)
    2176:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    217a:	48 83 c0 10          	add    $0x10,%rax
    217e:	eb 4e                	jmp    21ce <malloc+0x148>
    2180:	48 b8 f0 26 00 00 00 	movabs $0x26f0,%rax
    2187:	00 00 00 
    218a:	48 8b 00             	mov    (%rax),%rax
    218d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    2191:	75 23                	jne    21b6 <malloc+0x130>
    2193:	8b 45 ec             	mov    -0x14(%rbp),%eax
    2196:	89 c7                	mov    %eax,%edi
    2198:	48 b8 0b 20 00 00 00 	movabs $0x200b,%rax
    219f:	00 00 00 
    21a2:	ff d0                	call   *%rax
    21a4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    21a8:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    21ad:	75 07                	jne    21b6 <malloc+0x130>
    21af:	b8 00 00 00 00       	mov    $0x0,%eax
    21b4:	eb 18                	jmp    21ce <malloc+0x148>
    21b6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    21ba:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    21be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    21c2:	48 8b 00             	mov    (%rax),%rax
    21c5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    21c9:	e9 41 ff ff ff       	jmp    210f <malloc+0x89>
    21ce:	c9                   	leave
    21cf:	c3                   	ret
