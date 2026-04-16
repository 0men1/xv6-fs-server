
_sh:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <runcmd>:
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Winfinite-recursion"
// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
    1000:	f3 0f 1e fa          	endbr64
    1004:	55                   	push   %rbp
    1005:	48 89 e5             	mov    %rsp,%rbp
    1008:	48 83 ec 40          	sub    $0x40,%rsp
    100c:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    1010:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
    1015:	75 0c                	jne    1023 <runcmd+0x23>
    exit();
    1017:	48 b8 cd 25 00 00 00 	movabs $0x25cd,%rax
    101e:	00 00 00 
    1021:	ff d0                	call   *%rax

  switch(cmd->type){
    1023:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    1027:	8b 00                	mov    (%rax),%eax
    1029:	83 f8 05             	cmp    $0x5,%eax
    102c:	77 1d                	ja     104b <runcmd+0x4b>
    102e:	89 c0                	mov    %eax,%eax
    1030:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1037:	00 
    1038:	48 b8 28 30 00 00 00 	movabs $0x3028,%rax
    103f:	00 00 00 
    1042:	48 01 d0             	add    %rdx,%rax
    1045:	48 8b 00             	mov    (%rax),%rax
    1048:	3e ff e0             	notrack jmp *%rax
  default:
    panic("runcmd");
    104b:	48 b8 f8 2f 00 00 00 	movabs $0x2ff8,%rax
    1052:	00 00 00 
    1055:	48 89 c7             	mov    %rax,%rdi
    1058:	48 b8 54 15 00 00 00 	movabs $0x1554,%rax
    105f:	00 00 00 
    1062:	ff d0                	call   *%rax

  case EXEC:
    ecmd = (struct execcmd*)cmd;
    1064:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    1068:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    if(ecmd->argv[0] == 0)
    106c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    1070:	48 8b 40 08          	mov    0x8(%rax),%rax
    1074:	48 85 c0             	test   %rax,%rax
    1077:	75 0c                	jne    1085 <runcmd+0x85>
      exit();
    1079:	48 b8 cd 25 00 00 00 	movabs $0x25cd,%rax
    1080:	00 00 00 
    1083:	ff d0                	call   *%rax
    exec(ecmd->argv[0], ecmd->argv);
    1085:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    1089:	48 8d 50 08          	lea    0x8(%rax),%rdx
    108d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    1091:	48 8b 40 08          	mov    0x8(%rax),%rax
    1095:	48 89 d6             	mov    %rdx,%rsi
    1098:	48 89 c7             	mov    %rax,%rdi
    109b:	48 b8 28 26 00 00 00 	movabs $0x2628,%rax
    10a2:	00 00 00 
    10a5:	ff d0                	call   *%rax
    printf(2, "exec %s failed\n", ecmd->argv[0]);
    10a7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    10ab:	48 8b 40 08          	mov    0x8(%rax),%rax
    10af:	48 89 c2             	mov    %rax,%rdx
    10b2:	48 b8 ff 2f 00 00 00 	movabs $0x2fff,%rax
    10b9:	00 00 00 
    10bc:	48 89 c6             	mov    %rax,%rsi
    10bf:	bf 02 00 00 00       	mov    $0x2,%edi
    10c4:	b8 00 00 00 00       	mov    $0x0,%eax
    10c9:	48 b9 de 28 00 00 00 	movabs $0x28de,%rcx
    10d0:	00 00 00 
    10d3:	ff d1                	call   *%rcx
    break;
    10d5:	e9 68 02 00 00       	jmp    1342 <runcmd+0x342>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    10da:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    10de:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    close(rcmd->fd);
    10e2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    10e6:	8b 40 24             	mov    0x24(%rax),%eax
    10e9:	89 c7                	mov    %eax,%edi
    10eb:	48 b8 0e 26 00 00 00 	movabs $0x260e,%rax
    10f2:	00 00 00 
    10f5:	ff d0                	call   *%rax
    if(open(rcmd->file, rcmd->mode) < 0){
    10f7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    10fb:	8b 50 20             	mov    0x20(%rax),%edx
    10fe:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1102:	48 8b 40 10          	mov    0x10(%rax),%rax
    1106:	89 d6                	mov    %edx,%esi
    1108:	48 89 c7             	mov    %rax,%rdi
    110b:	48 b8 35 26 00 00 00 	movabs $0x2635,%rax
    1112:	00 00 00 
    1115:	ff d0                	call   *%rax
    1117:	85 c0                	test   %eax,%eax
    1119:	79 3a                	jns    1155 <runcmd+0x155>
      printf(2, "open %s failed\n", rcmd->file);
    111b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    111f:	48 8b 40 10          	mov    0x10(%rax),%rax
    1123:	48 89 c2             	mov    %rax,%rdx
    1126:	48 b8 0f 30 00 00 00 	movabs $0x300f,%rax
    112d:	00 00 00 
    1130:	48 89 c6             	mov    %rax,%rsi
    1133:	bf 02 00 00 00       	mov    $0x2,%edi
    1138:	b8 00 00 00 00       	mov    $0x0,%eax
    113d:	48 b9 de 28 00 00 00 	movabs $0x28de,%rcx
    1144:	00 00 00 
    1147:	ff d1                	call   *%rcx
      exit();
    1149:	48 b8 cd 25 00 00 00 	movabs $0x25cd,%rax
    1150:	00 00 00 
    1153:	ff d0                	call   *%rax
    }
    runcmd(rcmd->cmd);
    1155:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1159:	48 8b 40 08          	mov    0x8(%rax),%rax
    115d:	48 89 c7             	mov    %rax,%rdi
    1160:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1167:	00 00 00 
    116a:	ff d0                	call   *%rax
    break;
    116c:	e9 d1 01 00 00       	jmp    1342 <runcmd+0x342>

  case LIST:
    lcmd = (struct listcmd*)cmd;
    1171:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    1175:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if(fork1() == 0)
    1179:	48 b8 9a 15 00 00 00 	movabs $0x159a,%rax
    1180:	00 00 00 
    1183:	ff d0                	call   *%rax
    1185:	85 c0                	test   %eax,%eax
    1187:	75 17                	jne    11a0 <runcmd+0x1a0>
      runcmd(lcmd->left);
    1189:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    118d:	48 8b 40 08          	mov    0x8(%rax),%rax
    1191:	48 89 c7             	mov    %rax,%rdi
    1194:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    119b:	00 00 00 
    119e:	ff d0                	call   *%rax
    wait();
    11a0:	48 b8 da 25 00 00 00 	movabs $0x25da,%rax
    11a7:	00 00 00 
    11aa:	ff d0                	call   *%rax
    runcmd(lcmd->right);
    11ac:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    11b0:	48 8b 40 10          	mov    0x10(%rax),%rax
    11b4:	48 89 c7             	mov    %rax,%rdi
    11b7:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    11be:	00 00 00 
    11c1:	ff d0                	call   *%rax
    break;
    11c3:	e9 7a 01 00 00       	jmp    1342 <runcmd+0x342>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    11c8:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    11cc:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if(pipe(p) < 0)
    11d0:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    11d4:	48 89 c7             	mov    %rax,%rdi
    11d7:	48 b8 e7 25 00 00 00 	movabs $0x25e7,%rax
    11de:	00 00 00 
    11e1:	ff d0                	call   *%rax
    11e3:	85 c0                	test   %eax,%eax
    11e5:	79 19                	jns    1200 <runcmd+0x200>
      panic("pipe");
    11e7:	48 b8 1f 30 00 00 00 	movabs $0x301f,%rax
    11ee:	00 00 00 
    11f1:	48 89 c7             	mov    %rax,%rdi
    11f4:	48 b8 54 15 00 00 00 	movabs $0x1554,%rax
    11fb:	00 00 00 
    11fe:	ff d0                	call   *%rax
    if(fork1() == 0){
    1200:	48 b8 9a 15 00 00 00 	movabs $0x159a,%rax
    1207:	00 00 00 
    120a:	ff d0                	call   *%rax
    120c:	85 c0                	test   %eax,%eax
    120e:	75 5b                	jne    126b <runcmd+0x26b>
      close(1);
    1210:	bf 01 00 00 00       	mov    $0x1,%edi
    1215:	48 b8 0e 26 00 00 00 	movabs $0x260e,%rax
    121c:	00 00 00 
    121f:	ff d0                	call   *%rax
      dup(p[1]);
    1221:	8b 45 d4             	mov    -0x2c(%rbp),%eax
    1224:	89 c7                	mov    %eax,%edi
    1226:	48 b8 90 26 00 00 00 	movabs $0x2690,%rax
    122d:	00 00 00 
    1230:	ff d0                	call   *%rax
      close(p[0]);
    1232:	8b 45 d0             	mov    -0x30(%rbp),%eax
    1235:	89 c7                	mov    %eax,%edi
    1237:	48 b8 0e 26 00 00 00 	movabs $0x260e,%rax
    123e:	00 00 00 
    1241:	ff d0                	call   *%rax
      close(p[1]);
    1243:	8b 45 d4             	mov    -0x2c(%rbp),%eax
    1246:	89 c7                	mov    %eax,%edi
    1248:	48 b8 0e 26 00 00 00 	movabs $0x260e,%rax
    124f:	00 00 00 
    1252:	ff d0                	call   *%rax
      runcmd(pcmd->left);
    1254:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1258:	48 8b 40 08          	mov    0x8(%rax),%rax
    125c:	48 89 c7             	mov    %rax,%rdi
    125f:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1266:	00 00 00 
    1269:	ff d0                	call   *%rax
    }
    if(fork1() == 0){
    126b:	48 b8 9a 15 00 00 00 	movabs $0x159a,%rax
    1272:	00 00 00 
    1275:	ff d0                	call   *%rax
    1277:	85 c0                	test   %eax,%eax
    1279:	75 5b                	jne    12d6 <runcmd+0x2d6>
      close(0);
    127b:	bf 00 00 00 00       	mov    $0x0,%edi
    1280:	48 b8 0e 26 00 00 00 	movabs $0x260e,%rax
    1287:	00 00 00 
    128a:	ff d0                	call   *%rax
      dup(p[0]);
    128c:	8b 45 d0             	mov    -0x30(%rbp),%eax
    128f:	89 c7                	mov    %eax,%edi
    1291:	48 b8 90 26 00 00 00 	movabs $0x2690,%rax
    1298:	00 00 00 
    129b:	ff d0                	call   *%rax
      close(p[0]);
    129d:	8b 45 d0             	mov    -0x30(%rbp),%eax
    12a0:	89 c7                	mov    %eax,%edi
    12a2:	48 b8 0e 26 00 00 00 	movabs $0x260e,%rax
    12a9:	00 00 00 
    12ac:	ff d0                	call   *%rax
      close(p[1]);
    12ae:	8b 45 d4             	mov    -0x2c(%rbp),%eax
    12b1:	89 c7                	mov    %eax,%edi
    12b3:	48 b8 0e 26 00 00 00 	movabs $0x260e,%rax
    12ba:	00 00 00 
    12bd:	ff d0                	call   *%rax
      runcmd(pcmd->right);
    12bf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12c3:	48 8b 40 10          	mov    0x10(%rax),%rax
    12c7:	48 89 c7             	mov    %rax,%rdi
    12ca:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    12d1:	00 00 00 
    12d4:	ff d0                	call   *%rax
    }
    close(p[0]);
    12d6:	8b 45 d0             	mov    -0x30(%rbp),%eax
    12d9:	89 c7                	mov    %eax,%edi
    12db:	48 b8 0e 26 00 00 00 	movabs $0x260e,%rax
    12e2:	00 00 00 
    12e5:	ff d0                	call   *%rax
    close(p[1]);
    12e7:	8b 45 d4             	mov    -0x2c(%rbp),%eax
    12ea:	89 c7                	mov    %eax,%edi
    12ec:	48 b8 0e 26 00 00 00 	movabs $0x260e,%rax
    12f3:	00 00 00 
    12f6:	ff d0                	call   *%rax
    wait();
    12f8:	48 b8 da 25 00 00 00 	movabs $0x25da,%rax
    12ff:	00 00 00 
    1302:	ff d0                	call   *%rax
    wait();
    1304:	48 b8 da 25 00 00 00 	movabs $0x25da,%rax
    130b:	00 00 00 
    130e:	ff d0                	call   *%rax
    break;
    1310:	eb 30                	jmp    1342 <runcmd+0x342>

  case BACK:
    bcmd = (struct backcmd*)cmd;
    1312:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    1316:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(fork1() == 0)
    131a:	48 b8 9a 15 00 00 00 	movabs $0x159a,%rax
    1321:	00 00 00 
    1324:	ff d0                	call   *%rax
    1326:	85 c0                	test   %eax,%eax
    1328:	75 17                	jne    1341 <runcmd+0x341>
      runcmd(bcmd->cmd);
    132a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    132e:	48 8b 40 08          	mov    0x8(%rax),%rax
    1332:	48 89 c7             	mov    %rax,%rdi
    1335:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    133c:	00 00 00 
    133f:	ff d0                	call   *%rax
    break;
    1341:	90                   	nop
  }
  exit();
    1342:	48 b8 cd 25 00 00 00 	movabs $0x25cd,%rax
    1349:	00 00 00 
    134c:	ff d0                	call   *%rax

000000000000134e <getcmd>:
}
#pragma GCC diagnostic pop

int
getcmd(char *buf, int nbuf)
{
    134e:	f3 0f 1e fa          	endbr64
    1352:	55                   	push   %rbp
    1353:	48 89 e5             	mov    %rsp,%rbp
    1356:	48 83 ec 10          	sub    $0x10,%rsp
    135a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    135e:	89 75 f4             	mov    %esi,-0xc(%rbp)
  printf(2, "$ ");
    1361:	48 b8 58 30 00 00 00 	movabs $0x3058,%rax
    1368:	00 00 00 
    136b:	48 89 c6             	mov    %rax,%rsi
    136e:	bf 02 00 00 00       	mov    $0x2,%edi
    1373:	b8 00 00 00 00       	mov    $0x0,%eax
    1378:	48 ba de 28 00 00 00 	movabs $0x28de,%rdx
    137f:	00 00 00 
    1382:	ff d2                	call   *%rdx
  memset(buf, 0, nbuf);
    1384:	8b 55 f4             	mov    -0xc(%rbp),%edx
    1387:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    138b:	be 00 00 00 00       	mov    $0x0,%esi
    1390:	48 89 c7             	mov    %rax,%rdi
    1393:	48 b8 98 23 00 00 00 	movabs $0x2398,%rax
    139a:	00 00 00 
    139d:	ff d0                	call   *%rax
  gets(buf, nbuf);
    139f:	8b 55 f4             	mov    -0xc(%rbp),%edx
    13a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13a6:	89 d6                	mov    %edx,%esi
    13a8:	48 89 c7             	mov    %rax,%rdi
    13ab:	48 b8 0f 24 00 00 00 	movabs $0x240f,%rax
    13b2:	00 00 00 
    13b5:	ff d0                	call   *%rax
  if(buf[0] == 0) // EOF
    13b7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13bb:	0f b6 00             	movzbl (%rax),%eax
    13be:	84 c0                	test   %al,%al
    13c0:	75 07                	jne    13c9 <getcmd+0x7b>
    return -1;
    13c2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    13c7:	eb 05                	jmp    13ce <getcmd+0x80>
  return 0;
    13c9:	b8 00 00 00 00       	mov    $0x0,%eax
}
    13ce:	c9                   	leave
    13cf:	c3                   	ret

00000000000013d0 <main>:

int
main(void)
{
    13d0:	f3 0f 1e fa          	endbr64
    13d4:	55                   	push   %rbp
    13d5:	48 89 e5             	mov    %rsp,%rbp
    13d8:	48 83 ec 10          	sub    $0x10,%rsp
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
    13dc:	eb 19                	jmp    13f7 <main+0x27>
    if(fd >= 3){
    13de:	83 7d fc 02          	cmpl   $0x2,-0x4(%rbp)
    13e2:	7e 13                	jle    13f7 <main+0x27>
      close(fd);
    13e4:	8b 45 fc             	mov    -0x4(%rbp),%eax
    13e7:	89 c7                	mov    %eax,%edi
    13e9:	48 b8 0e 26 00 00 00 	movabs $0x260e,%rax
    13f0:	00 00 00 
    13f3:	ff d0                	call   *%rax
      break;
    13f5:	eb 27                	jmp    141e <main+0x4e>
  while((fd = open("console", O_RDWR)) >= 0){
    13f7:	be 02 00 00 00       	mov    $0x2,%esi
    13fc:	48 b8 5b 30 00 00 00 	movabs $0x305b,%rax
    1403:	00 00 00 
    1406:	48 89 c7             	mov    %rax,%rdi
    1409:	48 b8 35 26 00 00 00 	movabs $0x2635,%rax
    1410:	00 00 00 
    1413:	ff d0                	call   *%rax
    1415:	89 45 fc             	mov    %eax,-0x4(%rbp)
    1418:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    141c:	79 c0                	jns    13de <main+0xe>
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    141e:	e9 ff 00 00 00       	jmp    1522 <main+0x152>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
    1423:	48 b8 20 32 00 00 00 	movabs $0x3220,%rax
    142a:	00 00 00 
    142d:	0f b6 00             	movzbl (%rax),%eax
    1430:	3c 63                	cmp    $0x63,%al
    1432:	0f 85 a3 00 00 00    	jne    14db <main+0x10b>
    1438:	48 b8 20 32 00 00 00 	movabs $0x3220,%rax
    143f:	00 00 00 
    1442:	0f b6 40 01          	movzbl 0x1(%rax),%eax
    1446:	3c 64                	cmp    $0x64,%al
    1448:	0f 85 8d 00 00 00    	jne    14db <main+0x10b>
    144e:	48 b8 20 32 00 00 00 	movabs $0x3220,%rax
    1455:	00 00 00 
    1458:	0f b6 40 02          	movzbl 0x2(%rax),%eax
    145c:	3c 20                	cmp    $0x20,%al
    145e:	75 7b                	jne    14db <main+0x10b>
      // Chdir must be called by the parent, not the child.
      buf[strlen(buf)-1] = 0;  // chop \n
    1460:	48 b8 20 32 00 00 00 	movabs $0x3220,%rax
    1467:	00 00 00 
    146a:	48 89 c7             	mov    %rax,%rdi
    146d:	48 b8 62 23 00 00 00 	movabs $0x2362,%rax
    1474:	00 00 00 
    1477:	ff d0                	call   *%rax
    1479:	8d 50 ff             	lea    -0x1(%rax),%edx
    147c:	48 b8 20 32 00 00 00 	movabs $0x3220,%rax
    1483:	00 00 00 
    1486:	89 d2                	mov    %edx,%edx
    1488:	c6 04 10 00          	movb   $0x0,(%rax,%rdx,1)
      if(chdir(buf+3) < 0)
    148c:	48 b8 23 32 00 00 00 	movabs $0x3223,%rax
    1493:	00 00 00 
    1496:	48 89 c7             	mov    %rax,%rdi
    1499:	48 b8 83 26 00 00 00 	movabs $0x2683,%rax
    14a0:	00 00 00 
    14a3:	ff d0                	call   *%rax
    14a5:	85 c0                	test   %eax,%eax
    14a7:	79 78                	jns    1521 <main+0x151>
        printf(2, "cannot cd %s\n", buf+3);
    14a9:	48 b8 23 32 00 00 00 	movabs $0x3223,%rax
    14b0:	00 00 00 
    14b3:	48 89 c2             	mov    %rax,%rdx
    14b6:	48 b8 63 30 00 00 00 	movabs $0x3063,%rax
    14bd:	00 00 00 
    14c0:	48 89 c6             	mov    %rax,%rsi
    14c3:	bf 02 00 00 00       	mov    $0x2,%edi
    14c8:	b8 00 00 00 00       	mov    $0x0,%eax
    14cd:	48 b9 de 28 00 00 00 	movabs $0x28de,%rcx
    14d4:	00 00 00 
    14d7:	ff d1                	call   *%rcx
      continue;
    14d9:	eb 46                	jmp    1521 <main+0x151>
    }
    if(fork1() == 0)
    14db:	48 b8 9a 15 00 00 00 	movabs $0x159a,%rax
    14e2:	00 00 00 
    14e5:	ff d0                	call   *%rax
    14e7:	85 c0                	test   %eax,%eax
    14e9:	75 28                	jne    1513 <main+0x143>
      runcmd(parsecmd(buf));
    14eb:	48 b8 20 32 00 00 00 	movabs $0x3220,%rax
    14f2:	00 00 00 
    14f5:	48 89 c7             	mov    %rax,%rdi
    14f8:	48 b8 5a 1a 00 00 00 	movabs $0x1a5a,%rax
    14ff:	00 00 00 
    1502:	ff d0                	call   *%rax
    1504:	48 89 c7             	mov    %rax,%rdi
    1507:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    150e:	00 00 00 
    1511:	ff d0                	call   *%rax
    wait();
    1513:	48 b8 da 25 00 00 00 	movabs $0x25da,%rax
    151a:	00 00 00 
    151d:	ff d0                	call   *%rax
    151f:	eb 01                	jmp    1522 <main+0x152>
      continue;
    1521:	90                   	nop
  while(getcmd(buf, sizeof(buf)) >= 0){
    1522:	be 64 00 00 00       	mov    $0x64,%esi
    1527:	48 b8 20 32 00 00 00 	movabs $0x3220,%rax
    152e:	00 00 00 
    1531:	48 89 c7             	mov    %rax,%rdi
    1534:	48 b8 4e 13 00 00 00 	movabs $0x134e,%rax
    153b:	00 00 00 
    153e:	ff d0                	call   *%rax
    1540:	85 c0                	test   %eax,%eax
    1542:	0f 89 db fe ff ff    	jns    1423 <main+0x53>
  }
  exit();
    1548:	48 b8 cd 25 00 00 00 	movabs $0x25cd,%rax
    154f:	00 00 00 
    1552:	ff d0                	call   *%rax

0000000000001554 <panic>:
}

void
panic(char *s)
{
    1554:	f3 0f 1e fa          	endbr64
    1558:	55                   	push   %rbp
    1559:	48 89 e5             	mov    %rsp,%rbp
    155c:	48 83 ec 10          	sub    $0x10,%rsp
    1560:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  printf(2, "%s\n", s);
    1564:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1568:	48 89 c2             	mov    %rax,%rdx
    156b:	48 b8 71 30 00 00 00 	movabs $0x3071,%rax
    1572:	00 00 00 
    1575:	48 89 c6             	mov    %rax,%rsi
    1578:	bf 02 00 00 00       	mov    $0x2,%edi
    157d:	b8 00 00 00 00       	mov    $0x0,%eax
    1582:	48 b9 de 28 00 00 00 	movabs $0x28de,%rcx
    1589:	00 00 00 
    158c:	ff d1                	call   *%rcx
  exit();
    158e:	48 b8 cd 25 00 00 00 	movabs $0x25cd,%rax
    1595:	00 00 00 
    1598:	ff d0                	call   *%rax

000000000000159a <fork1>:
}

int
fork1(void)
{
    159a:	f3 0f 1e fa          	endbr64
    159e:	55                   	push   %rbp
    159f:	48 89 e5             	mov    %rsp,%rbp
    15a2:	48 83 ec 10          	sub    $0x10,%rsp
  int pid;

  pid = fork();
    15a6:	48 b8 c0 25 00 00 00 	movabs $0x25c0,%rax
    15ad:	00 00 00 
    15b0:	ff d0                	call   *%rax
    15b2:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(pid == -1)
    15b5:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%rbp)
    15b9:	75 19                	jne    15d4 <fork1+0x3a>
    panic("fork");
    15bb:	48 b8 75 30 00 00 00 	movabs $0x3075,%rax
    15c2:	00 00 00 
    15c5:	48 89 c7             	mov    %rax,%rdi
    15c8:	48 b8 54 15 00 00 00 	movabs $0x1554,%rax
    15cf:	00 00 00 
    15d2:	ff d0                	call   *%rax
  return pid;
    15d4:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    15d7:	c9                   	leave
    15d8:	c3                   	ret

00000000000015d9 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
    15d9:	f3 0f 1e fa          	endbr64
    15dd:	55                   	push   %rbp
    15de:	48 89 e5             	mov    %rsp,%rbp
    15e1:	48 83 ec 10          	sub    $0x10,%rsp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
    15e5:	bf a8 00 00 00       	mov    $0xa8,%edi
    15ea:	48 b8 a3 2e 00 00 00 	movabs $0x2ea3,%rax
    15f1:	00 00 00 
    15f4:	ff d0                	call   *%rax
    15f6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(cmd, 0, sizeof(*cmd));
    15fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    15fe:	ba a8 00 00 00       	mov    $0xa8,%edx
    1603:	be 00 00 00 00       	mov    $0x0,%esi
    1608:	48 89 c7             	mov    %rax,%rdi
    160b:	48 b8 98 23 00 00 00 	movabs $0x2398,%rax
    1612:	00 00 00 
    1615:	ff d0                	call   *%rax
  cmd->type = EXEC;
    1617:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    161b:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
  return (struct cmd*)cmd;
    1621:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    1625:	c9                   	leave
    1626:	c3                   	ret

0000000000001627 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
    1627:	f3 0f 1e fa          	endbr64
    162b:	55                   	push   %rbp
    162c:	48 89 e5             	mov    %rsp,%rbp
    162f:	48 83 ec 30          	sub    $0x30,%rsp
    1633:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1637:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    163b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    163f:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
    1642:	44 89 45 d0          	mov    %r8d,-0x30(%rbp)
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
    1646:	bf 28 00 00 00       	mov    $0x28,%edi
    164b:	48 b8 a3 2e 00 00 00 	movabs $0x2ea3,%rax
    1652:	00 00 00 
    1655:	ff d0                	call   *%rax
    1657:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(cmd, 0, sizeof(*cmd));
    165b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    165f:	ba 28 00 00 00       	mov    $0x28,%edx
    1664:	be 00 00 00 00       	mov    $0x0,%esi
    1669:	48 89 c7             	mov    %rax,%rdi
    166c:	48 b8 98 23 00 00 00 	movabs $0x2398,%rax
    1673:	00 00 00 
    1676:	ff d0                	call   *%rax
  cmd->type = REDIR;
    1678:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    167c:	c7 00 02 00 00 00    	movl   $0x2,(%rax)
  cmd->cmd = subcmd;
    1682:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1686:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
    168a:	48 89 50 08          	mov    %rdx,0x8(%rax)
  cmd->file = file;
    168e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1692:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1696:	48 89 50 10          	mov    %rdx,0x10(%rax)
  cmd->efile = efile;
    169a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    169e:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
    16a2:	48 89 50 18          	mov    %rdx,0x18(%rax)
  cmd->mode = mode;
    16a6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    16aa:	8b 55 d4             	mov    -0x2c(%rbp),%edx
    16ad:	89 50 20             	mov    %edx,0x20(%rax)
  cmd->fd = fd;
    16b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    16b4:	8b 55 d0             	mov    -0x30(%rbp),%edx
    16b7:	89 50 24             	mov    %edx,0x24(%rax)
  return (struct cmd*)cmd;
    16ba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    16be:	c9                   	leave
    16bf:	c3                   	ret

00000000000016c0 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
    16c0:	f3 0f 1e fa          	endbr64
    16c4:	55                   	push   %rbp
    16c5:	48 89 e5             	mov    %rsp,%rbp
    16c8:	48 83 ec 20          	sub    $0x20,%rsp
    16cc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    16d0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
    16d4:	bf 18 00 00 00       	mov    $0x18,%edi
    16d9:	48 b8 a3 2e 00 00 00 	movabs $0x2ea3,%rax
    16e0:	00 00 00 
    16e3:	ff d0                	call   *%rax
    16e5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(cmd, 0, sizeof(*cmd));
    16e9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    16ed:	ba 18 00 00 00       	mov    $0x18,%edx
    16f2:	be 00 00 00 00       	mov    $0x0,%esi
    16f7:	48 89 c7             	mov    %rax,%rdi
    16fa:	48 b8 98 23 00 00 00 	movabs $0x2398,%rax
    1701:	00 00 00 
    1704:	ff d0                	call   *%rax
  cmd->type = PIPE;
    1706:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    170a:	c7 00 03 00 00 00    	movl   $0x3,(%rax)
  cmd->left = left;
    1710:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1714:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
    1718:	48 89 50 08          	mov    %rdx,0x8(%rax)
  cmd->right = right;
    171c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1720:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1724:	48 89 50 10          	mov    %rdx,0x10(%rax)
  return (struct cmd*)cmd;
    1728:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    172c:	c9                   	leave
    172d:	c3                   	ret

000000000000172e <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
    172e:	f3 0f 1e fa          	endbr64
    1732:	55                   	push   %rbp
    1733:	48 89 e5             	mov    %rsp,%rbp
    1736:	48 83 ec 20          	sub    $0x20,%rsp
    173a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    173e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
    1742:	bf 18 00 00 00       	mov    $0x18,%edi
    1747:	48 b8 a3 2e 00 00 00 	movabs $0x2ea3,%rax
    174e:	00 00 00 
    1751:	ff d0                	call   *%rax
    1753:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(cmd, 0, sizeof(*cmd));
    1757:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    175b:	ba 18 00 00 00       	mov    $0x18,%edx
    1760:	be 00 00 00 00       	mov    $0x0,%esi
    1765:	48 89 c7             	mov    %rax,%rdi
    1768:	48 b8 98 23 00 00 00 	movabs $0x2398,%rax
    176f:	00 00 00 
    1772:	ff d0                	call   *%rax
  cmd->type = LIST;
    1774:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1778:	c7 00 04 00 00 00    	movl   $0x4,(%rax)
  cmd->left = left;
    177e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1782:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
    1786:	48 89 50 08          	mov    %rdx,0x8(%rax)
  cmd->right = right;
    178a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    178e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1792:	48 89 50 10          	mov    %rdx,0x10(%rax)
  return (struct cmd*)cmd;
    1796:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    179a:	c9                   	leave
    179b:	c3                   	ret

000000000000179c <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
    179c:	f3 0f 1e fa          	endbr64
    17a0:	55                   	push   %rbp
    17a1:	48 89 e5             	mov    %rsp,%rbp
    17a4:	48 83 ec 20          	sub    $0x20,%rsp
    17a8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
    17ac:	bf 10 00 00 00       	mov    $0x10,%edi
    17b1:	48 b8 a3 2e 00 00 00 	movabs $0x2ea3,%rax
    17b8:	00 00 00 
    17bb:	ff d0                	call   *%rax
    17bd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(cmd, 0, sizeof(*cmd));
    17c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    17c5:	ba 10 00 00 00       	mov    $0x10,%edx
    17ca:	be 00 00 00 00       	mov    $0x0,%esi
    17cf:	48 89 c7             	mov    %rax,%rdi
    17d2:	48 b8 98 23 00 00 00 	movabs $0x2398,%rax
    17d9:	00 00 00 
    17dc:	ff d0                	call   *%rax
  cmd->type = BACK;
    17de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    17e2:	c7 00 05 00 00 00    	movl   $0x5,(%rax)
  cmd->cmd = subcmd;
    17e8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    17ec:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
    17f0:	48 89 50 08          	mov    %rdx,0x8(%rax)
  return (struct cmd*)cmd;
    17f4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    17f8:	c9                   	leave
    17f9:	c3                   	ret

00000000000017fa <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
    17fa:	f3 0f 1e fa          	endbr64
    17fe:	55                   	push   %rbp
    17ff:	48 89 e5             	mov    %rsp,%rbp
    1802:	48 83 ec 30          	sub    $0x30,%rsp
    1806:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    180a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    180e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    1812:	48 89 4d d0          	mov    %rcx,-0x30(%rbp)
  char *s;
  int ret;

  s = *ps;
    1816:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    181a:	48 8b 00             	mov    (%rax),%rax
    181d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while(s < es && strchr(whitespace, *s))
    1821:	eb 05                	jmp    1828 <gettoken+0x2e>
    s++;
    1823:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  while(s < es && strchr(whitespace, *s))
    1828:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    182c:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
    1830:	73 2a                	jae    185c <gettoken+0x62>
    1832:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1836:	0f b6 00             	movzbl (%rax),%eax
    1839:	0f be c0             	movsbl %al,%eax
    183c:	89 c6                	mov    %eax,%esi
    183e:	48 b8 e0 31 00 00 00 	movabs $0x31e0,%rax
    1845:	00 00 00 
    1848:	48 89 c7             	mov    %rax,%rdi
    184b:	48 b8 cf 23 00 00 00 	movabs $0x23cf,%rax
    1852:	00 00 00 
    1855:	ff d0                	call   *%rax
    1857:	48 85 c0             	test   %rax,%rax
    185a:	75 c7                	jne    1823 <gettoken+0x29>
  if(q)
    185c:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
    1861:	74 0b                	je     186e <gettoken+0x74>
    *q = s;
    1863:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    1867:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
    186b:	48 89 10             	mov    %rdx,(%rax)
  ret = *s;
    186e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1872:	0f b6 00             	movzbl (%rax),%eax
    1875:	0f be c0             	movsbl %al,%eax
    1878:	89 45 f4             	mov    %eax,-0xc(%rbp)
  switch(*s){
    187b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    187f:	0f b6 00             	movzbl (%rax),%eax
    1882:	0f be c0             	movsbl %al,%eax
    1885:	83 f8 7c             	cmp    $0x7c,%eax
    1888:	74 30                	je     18ba <gettoken+0xc0>
    188a:	83 f8 7c             	cmp    $0x7c,%eax
    188d:	7f 53                	jg     18e2 <gettoken+0xe8>
    188f:	83 f8 3e             	cmp    $0x3e,%eax
    1892:	74 30                	je     18c4 <gettoken+0xca>
    1894:	83 f8 3e             	cmp    $0x3e,%eax
    1897:	7f 49                	jg     18e2 <gettoken+0xe8>
    1899:	83 f8 3c             	cmp    $0x3c,%eax
    189c:	7f 44                	jg     18e2 <gettoken+0xe8>
    189e:	83 f8 3b             	cmp    $0x3b,%eax
    18a1:	7d 17                	jge    18ba <gettoken+0xc0>
    18a3:	83 f8 29             	cmp    $0x29,%eax
    18a6:	7f 3a                	jg     18e2 <gettoken+0xe8>
    18a8:	83 f8 28             	cmp    $0x28,%eax
    18ab:	7d 0d                	jge    18ba <gettoken+0xc0>
    18ad:	85 c0                	test   %eax,%eax
    18af:	0f 84 9b 00 00 00    	je     1950 <gettoken+0x156>
    18b5:	83 f8 26             	cmp    $0x26,%eax
    18b8:	75 28                	jne    18e2 <gettoken+0xe8>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
    18ba:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    break;
    18bf:	e9 93 00 00 00       	jmp    1957 <gettoken+0x15d>
  case '>':
    s++;
    18c4:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    if(*s == '>'){
    18c9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    18cd:	0f b6 00             	movzbl (%rax),%eax
    18d0:	3c 3e                	cmp    $0x3e,%al
    18d2:	75 7f                	jne    1953 <gettoken+0x159>
      ret = '+';
    18d4:	c7 45 f4 2b 00 00 00 	movl   $0x2b,-0xc(%rbp)
      s++;
    18db:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    }
    break;
    18e0:	eb 71                	jmp    1953 <gettoken+0x159>
  default:
    ret = 'a';
    18e2:	c7 45 f4 61 00 00 00 	movl   $0x61,-0xc(%rbp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
    18e9:	eb 05                	jmp    18f0 <gettoken+0xf6>
      s++;
    18eb:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
    18f0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    18f4:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
    18f8:	73 5c                	jae    1956 <gettoken+0x15c>
    18fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    18fe:	0f b6 00             	movzbl (%rax),%eax
    1901:	0f be c0             	movsbl %al,%eax
    1904:	89 c6                	mov    %eax,%esi
    1906:	48 b8 e0 31 00 00 00 	movabs $0x31e0,%rax
    190d:	00 00 00 
    1910:	48 89 c7             	mov    %rax,%rdi
    1913:	48 b8 cf 23 00 00 00 	movabs $0x23cf,%rax
    191a:	00 00 00 
    191d:	ff d0                	call   *%rax
    191f:	48 85 c0             	test   %rax,%rax
    1922:	75 32                	jne    1956 <gettoken+0x15c>
    1924:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1928:	0f b6 00             	movzbl (%rax),%eax
    192b:	0f be c0             	movsbl %al,%eax
    192e:	89 c6                	mov    %eax,%esi
    1930:	48 b8 e8 31 00 00 00 	movabs $0x31e8,%rax
    1937:	00 00 00 
    193a:	48 89 c7             	mov    %rax,%rdi
    193d:	48 b8 cf 23 00 00 00 	movabs $0x23cf,%rax
    1944:	00 00 00 
    1947:	ff d0                	call   *%rax
    1949:	48 85 c0             	test   %rax,%rax
    194c:	74 9d                	je     18eb <gettoken+0xf1>
    break;
    194e:	eb 06                	jmp    1956 <gettoken+0x15c>
    break;
    1950:	90                   	nop
    1951:	eb 04                	jmp    1957 <gettoken+0x15d>
    break;
    1953:	90                   	nop
    1954:	eb 01                	jmp    1957 <gettoken+0x15d>
    break;
    1956:	90                   	nop
  }
  if(eq)
    1957:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
    195c:	74 12                	je     1970 <gettoken+0x176>
    *eq = s;
    195e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    1962:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
    1966:	48 89 10             	mov    %rdx,(%rax)

  while(s < es && strchr(whitespace, *s))
    1969:	eb 05                	jmp    1970 <gettoken+0x176>
    s++;
    196b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  while(s < es && strchr(whitespace, *s))
    1970:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1974:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
    1978:	73 2a                	jae    19a4 <gettoken+0x1aa>
    197a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    197e:	0f b6 00             	movzbl (%rax),%eax
    1981:	0f be c0             	movsbl %al,%eax
    1984:	89 c6                	mov    %eax,%esi
    1986:	48 b8 e0 31 00 00 00 	movabs $0x31e0,%rax
    198d:	00 00 00 
    1990:	48 89 c7             	mov    %rax,%rdi
    1993:	48 b8 cf 23 00 00 00 	movabs $0x23cf,%rax
    199a:	00 00 00 
    199d:	ff d0                	call   *%rax
    199f:	48 85 c0             	test   %rax,%rax
    19a2:	75 c7                	jne    196b <gettoken+0x171>
  *ps = s;
    19a4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    19a8:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
    19ac:	48 89 10             	mov    %rdx,(%rax)
  return ret;
    19af:	8b 45 f4             	mov    -0xc(%rbp),%eax
}
    19b2:	c9                   	leave
    19b3:	c3                   	ret

00000000000019b4 <peek>:

int
peek(char **ps, char *es, char *toks)
{
    19b4:	f3 0f 1e fa          	endbr64
    19b8:	55                   	push   %rbp
    19b9:	48 89 e5             	mov    %rsp,%rbp
    19bc:	48 83 ec 30          	sub    $0x30,%rsp
    19c0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    19c4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    19c8:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  char *s;

  s = *ps;
    19cc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    19d0:	48 8b 00             	mov    (%rax),%rax
    19d3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while(s < es && strchr(whitespace, *s))
    19d7:	eb 05                	jmp    19de <peek+0x2a>
    s++;
    19d9:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  while(s < es && strchr(whitespace, *s))
    19de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    19e2:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
    19e6:	73 2a                	jae    1a12 <peek+0x5e>
    19e8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    19ec:	0f b6 00             	movzbl (%rax),%eax
    19ef:	0f be c0             	movsbl %al,%eax
    19f2:	89 c6                	mov    %eax,%esi
    19f4:	48 b8 e0 31 00 00 00 	movabs $0x31e0,%rax
    19fb:	00 00 00 
    19fe:	48 89 c7             	mov    %rax,%rdi
    1a01:	48 b8 cf 23 00 00 00 	movabs $0x23cf,%rax
    1a08:	00 00 00 
    1a0b:	ff d0                	call   *%rax
    1a0d:	48 85 c0             	test   %rax,%rax
    1a10:	75 c7                	jne    19d9 <peek+0x25>
  *ps = s;
    1a12:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1a16:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
    1a1a:	48 89 10             	mov    %rdx,(%rax)
  return *s && strchr(toks, *s);
    1a1d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1a21:	0f b6 00             	movzbl (%rax),%eax
    1a24:	84 c0                	test   %al,%al
    1a26:	74 2b                	je     1a53 <peek+0x9f>
    1a28:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1a2c:	0f b6 00             	movzbl (%rax),%eax
    1a2f:	0f be d0             	movsbl %al,%edx
    1a32:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    1a36:	89 d6                	mov    %edx,%esi
    1a38:	48 89 c7             	mov    %rax,%rdi
    1a3b:	48 b8 cf 23 00 00 00 	movabs $0x23cf,%rax
    1a42:	00 00 00 
    1a45:	ff d0                	call   *%rax
    1a47:	48 85 c0             	test   %rax,%rax
    1a4a:	74 07                	je     1a53 <peek+0x9f>
    1a4c:	b8 01 00 00 00       	mov    $0x1,%eax
    1a51:	eb 05                	jmp    1a58 <peek+0xa4>
    1a53:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1a58:	c9                   	leave
    1a59:	c3                   	ret

0000000000001a5a <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
    1a5a:	f3 0f 1e fa          	endbr64
    1a5e:	55                   	push   %rbp
    1a5f:	48 89 e5             	mov    %rsp,%rbp
    1a62:	53                   	push   %rbx
    1a63:	48 83 ec 28          	sub    $0x28,%rsp
    1a67:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
    1a6b:	48 8b 5d d8          	mov    -0x28(%rbp),%rbx
    1a6f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    1a73:	48 89 c7             	mov    %rax,%rdi
    1a76:	48 b8 62 23 00 00 00 	movabs $0x2362,%rax
    1a7d:	00 00 00 
    1a80:	ff d0                	call   *%rax
    1a82:	89 c0                	mov    %eax,%eax
    1a84:	48 01 d8             	add    %rbx,%rax
    1a87:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  cmd = parseline(&s, es);
    1a8b:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
    1a8f:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
    1a93:	48 89 d6             	mov    %rdx,%rsi
    1a96:	48 89 c7             	mov    %rax,%rdi
    1a99:	48 b8 37 1b 00 00 00 	movabs $0x1b37,%rax
    1aa0:	00 00 00 
    1aa3:	ff d0                	call   *%rax
    1aa5:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  peek(&s, es, "");
    1aa9:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
    1aad:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
    1ab1:	48 ba 7a 30 00 00 00 	movabs $0x307a,%rdx
    1ab8:	00 00 00 
    1abb:	48 89 ce             	mov    %rcx,%rsi
    1abe:	48 89 c7             	mov    %rax,%rdi
    1ac1:	48 b8 b4 19 00 00 00 	movabs $0x19b4,%rax
    1ac8:	00 00 00 
    1acb:	ff d0                	call   *%rax
  if(s != es){
    1acd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    1ad1:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
    1ad5:	74 43                	je     1b1a <parsecmd+0xc0>
    printf(2, "leftovers: %s\n", s);
    1ad7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    1adb:	48 89 c2             	mov    %rax,%rdx
    1ade:	48 b8 7b 30 00 00 00 	movabs $0x307b,%rax
    1ae5:	00 00 00 
    1ae8:	48 89 c6             	mov    %rax,%rsi
    1aeb:	bf 02 00 00 00       	mov    $0x2,%edi
    1af0:	b8 00 00 00 00       	mov    $0x0,%eax
    1af5:	48 b9 de 28 00 00 00 	movabs $0x28de,%rcx
    1afc:	00 00 00 
    1aff:	ff d1                	call   *%rcx
    panic("syntax");
    1b01:	48 b8 8a 30 00 00 00 	movabs $0x308a,%rax
    1b08:	00 00 00 
    1b0b:	48 89 c7             	mov    %rax,%rdi
    1b0e:	48 b8 54 15 00 00 00 	movabs $0x1554,%rax
    1b15:	00 00 00 
    1b18:	ff d0                	call   *%rax
  }
  nulterminate(cmd);
    1b1a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1b1e:	48 89 c7             	mov    %rax,%rdi
    1b21:	48 b8 34 21 00 00 00 	movabs $0x2134,%rax
    1b28:	00 00 00 
    1b2b:	ff d0                	call   *%rax
  return cmd;
    1b2d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
}
    1b31:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
    1b35:	c9                   	leave
    1b36:	c3                   	ret

0000000000001b37 <parseline>:

struct cmd*
parseline(char **ps, char *es)
{
    1b37:	f3 0f 1e fa          	endbr64
    1b3b:	55                   	push   %rbp
    1b3c:	48 89 e5             	mov    %rsp,%rbp
    1b3f:	48 83 ec 20          	sub    $0x20,%rsp
    1b43:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1b47:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
    1b4b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1b4f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1b53:	48 89 d6             	mov    %rdx,%rsi
    1b56:	48 89 c7             	mov    %rax,%rdi
    1b59:	48 b8 51 1c 00 00 00 	movabs $0x1c51,%rax
    1b60:	00 00 00 
    1b63:	ff d0                	call   *%rax
    1b65:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while(peek(ps, es, "&")){
    1b69:	eb 38                	jmp    1ba3 <parseline+0x6c>
    gettoken(ps, es, 0, 0);
    1b6b:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
    1b6f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1b73:	b9 00 00 00 00       	mov    $0x0,%ecx
    1b78:	ba 00 00 00 00       	mov    $0x0,%edx
    1b7d:	48 89 c7             	mov    %rax,%rdi
    1b80:	48 b8 fa 17 00 00 00 	movabs $0x17fa,%rax
    1b87:	00 00 00 
    1b8a:	ff d0                	call   *%rax
    cmd = backcmd(cmd);
    1b8c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b90:	48 89 c7             	mov    %rax,%rdi
    1b93:	48 b8 9c 17 00 00 00 	movabs $0x179c,%rax
    1b9a:	00 00 00 
    1b9d:	ff d0                	call   *%rax
    1b9f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while(peek(ps, es, "&")){
    1ba3:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
    1ba7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1bab:	48 ba 91 30 00 00 00 	movabs $0x3091,%rdx
    1bb2:	00 00 00 
    1bb5:	48 89 ce             	mov    %rcx,%rsi
    1bb8:	48 89 c7             	mov    %rax,%rdi
    1bbb:	48 b8 b4 19 00 00 00 	movabs $0x19b4,%rax
    1bc2:	00 00 00 
    1bc5:	ff d0                	call   *%rax
    1bc7:	85 c0                	test   %eax,%eax
    1bc9:	75 a0                	jne    1b6b <parseline+0x34>
  }
  if(peek(ps, es, ";")){
    1bcb:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
    1bcf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1bd3:	48 ba 93 30 00 00 00 	movabs $0x3093,%rdx
    1bda:	00 00 00 
    1bdd:	48 89 ce             	mov    %rcx,%rsi
    1be0:	48 89 c7             	mov    %rax,%rdi
    1be3:	48 b8 b4 19 00 00 00 	movabs $0x19b4,%rax
    1bea:	00 00 00 
    1bed:	ff d0                	call   *%rax
    1bef:	85 c0                	test   %eax,%eax
    1bf1:	74 58                	je     1c4b <parseline+0x114>
    gettoken(ps, es, 0, 0);
    1bf3:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
    1bf7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1bfb:	b9 00 00 00 00       	mov    $0x0,%ecx
    1c00:	ba 00 00 00 00       	mov    $0x0,%edx
    1c05:	48 89 c7             	mov    %rax,%rdi
    1c08:	48 b8 fa 17 00 00 00 	movabs $0x17fa,%rax
    1c0f:	00 00 00 
    1c12:	ff d0                	call   *%rax
    cmd = listcmd(cmd, parseline(ps, es));
    1c14:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1c18:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1c1c:	48 89 d6             	mov    %rdx,%rsi
    1c1f:	48 89 c7             	mov    %rax,%rdi
    1c22:	48 b8 37 1b 00 00 00 	movabs $0x1b37,%rax
    1c29:	00 00 00 
    1c2c:	ff d0                	call   *%rax
    1c2e:	48 89 c2             	mov    %rax,%rdx
    1c31:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c35:	48 89 d6             	mov    %rdx,%rsi
    1c38:	48 89 c7             	mov    %rax,%rdi
    1c3b:	48 b8 2e 17 00 00 00 	movabs $0x172e,%rax
    1c42:	00 00 00 
    1c45:	ff d0                	call   *%rax
    1c47:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  }
  return cmd;
    1c4b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    1c4f:	c9                   	leave
    1c50:	c3                   	ret

0000000000001c51 <parsepipe>:

struct cmd*
parsepipe(char **ps, char *es)
{
    1c51:	f3 0f 1e fa          	endbr64
    1c55:	55                   	push   %rbp
    1c56:	48 89 e5             	mov    %rsp,%rbp
    1c59:	48 83 ec 20          	sub    $0x20,%rsp
    1c5d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1c61:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  struct cmd *cmd;

  cmd = parseexec(ps, es);
    1c65:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1c69:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1c6d:	48 89 d6             	mov    %rdx,%rsi
    1c70:	48 89 c7             	mov    %rax,%rdi
    1c73:	48 b8 7a 1f 00 00 00 	movabs $0x1f7a,%rax
    1c7a:	00 00 00 
    1c7d:	ff d0                	call   *%rax
    1c7f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(peek(ps, es, "|")){
    1c83:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
    1c87:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1c8b:	48 ba 95 30 00 00 00 	movabs $0x3095,%rdx
    1c92:	00 00 00 
    1c95:	48 89 ce             	mov    %rcx,%rsi
    1c98:	48 89 c7             	mov    %rax,%rdi
    1c9b:	48 b8 b4 19 00 00 00 	movabs $0x19b4,%rax
    1ca2:	00 00 00 
    1ca5:	ff d0                	call   *%rax
    1ca7:	85 c0                	test   %eax,%eax
    1ca9:	74 58                	je     1d03 <parsepipe+0xb2>
    gettoken(ps, es, 0, 0);
    1cab:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
    1caf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1cb3:	b9 00 00 00 00       	mov    $0x0,%ecx
    1cb8:	ba 00 00 00 00       	mov    $0x0,%edx
    1cbd:	48 89 c7             	mov    %rax,%rdi
    1cc0:	48 b8 fa 17 00 00 00 	movabs $0x17fa,%rax
    1cc7:	00 00 00 
    1cca:	ff d0                	call   *%rax
    cmd = pipecmd(cmd, parsepipe(ps, es));
    1ccc:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1cd0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1cd4:	48 89 d6             	mov    %rdx,%rsi
    1cd7:	48 89 c7             	mov    %rax,%rdi
    1cda:	48 b8 51 1c 00 00 00 	movabs $0x1c51,%rax
    1ce1:	00 00 00 
    1ce4:	ff d0                	call   *%rax
    1ce6:	48 89 c2             	mov    %rax,%rdx
    1ce9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ced:	48 89 d6             	mov    %rdx,%rsi
    1cf0:	48 89 c7             	mov    %rax,%rdi
    1cf3:	48 b8 c0 16 00 00 00 	movabs $0x16c0,%rax
    1cfa:	00 00 00 
    1cfd:	ff d0                	call   *%rax
    1cff:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  }
  return cmd;
    1d03:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    1d07:	c9                   	leave
    1d08:	c3                   	ret

0000000000001d09 <parseredirs>:

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
    1d09:	f3 0f 1e fa          	endbr64
    1d0d:	55                   	push   %rbp
    1d0e:	48 89 e5             	mov    %rsp,%rbp
    1d11:	48 83 ec 40          	sub    $0x40,%rsp
    1d15:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
    1d19:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
    1d1d:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
    1d21:	e9 04 01 00 00       	jmp    1e2a <parseredirs+0x121>
    tok = gettoken(ps, es, 0, 0);
    1d26:	48 8b 75 c8          	mov    -0x38(%rbp),%rsi
    1d2a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    1d2e:	b9 00 00 00 00       	mov    $0x0,%ecx
    1d33:	ba 00 00 00 00       	mov    $0x0,%edx
    1d38:	48 89 c7             	mov    %rax,%rdi
    1d3b:	48 b8 fa 17 00 00 00 	movabs $0x17fa,%rax
    1d42:	00 00 00 
    1d45:	ff d0                	call   *%rax
    1d47:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(gettoken(ps, es, &q, &eq) != 'a')
    1d4a:	48 8d 4d e8          	lea    -0x18(%rbp),%rcx
    1d4e:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
    1d52:	48 8b 75 c8          	mov    -0x38(%rbp),%rsi
    1d56:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    1d5a:	48 89 c7             	mov    %rax,%rdi
    1d5d:	48 b8 fa 17 00 00 00 	movabs $0x17fa,%rax
    1d64:	00 00 00 
    1d67:	ff d0                	call   *%rax
    1d69:	83 f8 61             	cmp    $0x61,%eax
    1d6c:	74 19                	je     1d87 <parseredirs+0x7e>
      panic("missing file for redirection");
    1d6e:	48 b8 97 30 00 00 00 	movabs $0x3097,%rax
    1d75:	00 00 00 
    1d78:	48 89 c7             	mov    %rax,%rdi
    1d7b:	48 b8 54 15 00 00 00 	movabs $0x1554,%rax
    1d82:	00 00 00 
    1d85:	ff d0                	call   *%rax
    switch(tok){
    1d87:	83 7d fc 3e          	cmpl   $0x3e,-0x4(%rbp)
    1d8b:	74 46                	je     1dd3 <parseredirs+0xca>
    1d8d:	83 7d fc 3e          	cmpl   $0x3e,-0x4(%rbp)
    1d91:	0f 8f 93 00 00 00    	jg     1e2a <parseredirs+0x121>
    1d97:	83 7d fc 2b          	cmpl   $0x2b,-0x4(%rbp)
    1d9b:	74 62                	je     1dff <parseredirs+0xf6>
    1d9d:	83 7d fc 3c          	cmpl   $0x3c,-0x4(%rbp)
    1da1:	0f 85 83 00 00 00    	jne    1e2a <parseredirs+0x121>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
    1da7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
    1dab:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
    1daf:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    1db3:	41 b8 00 00 00 00    	mov    $0x0,%r8d
    1db9:	b9 00 00 00 00       	mov    $0x0,%ecx
    1dbe:	48 89 c7             	mov    %rax,%rdi
    1dc1:	48 b8 27 16 00 00 00 	movabs $0x1627,%rax
    1dc8:	00 00 00 
    1dcb:	ff d0                	call   *%rax
    1dcd:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
      break;
    1dd1:	eb 57                	jmp    1e2a <parseredirs+0x121>
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
    1dd3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
    1dd7:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
    1ddb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    1ddf:	41 b8 01 00 00 00    	mov    $0x1,%r8d
    1de5:	b9 01 02 00 00       	mov    $0x201,%ecx
    1dea:	48 89 c7             	mov    %rax,%rdi
    1ded:	48 b8 27 16 00 00 00 	movabs $0x1627,%rax
    1df4:	00 00 00 
    1df7:	ff d0                	call   *%rax
    1df9:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
      break;
    1dfd:	eb 2b                	jmp    1e2a <parseredirs+0x121>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
    1dff:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
    1e03:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
    1e07:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    1e0b:	41 b8 01 00 00 00    	mov    $0x1,%r8d
    1e11:	b9 01 02 00 00       	mov    $0x201,%ecx
    1e16:	48 89 c7             	mov    %rax,%rdi
    1e19:	48 b8 27 16 00 00 00 	movabs $0x1627,%rax
    1e20:	00 00 00 
    1e23:	ff d0                	call   *%rax
    1e25:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
      break;
    1e29:	90                   	nop
  while(peek(ps, es, "<>")){
    1e2a:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
    1e2e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    1e32:	48 ba b4 30 00 00 00 	movabs $0x30b4,%rdx
    1e39:	00 00 00 
    1e3c:	48 89 ce             	mov    %rcx,%rsi
    1e3f:	48 89 c7             	mov    %rax,%rdi
    1e42:	48 b8 b4 19 00 00 00 	movabs $0x19b4,%rax
    1e49:	00 00 00 
    1e4c:	ff d0                	call   *%rax
    1e4e:	85 c0                	test   %eax,%eax
    1e50:	0f 85 d0 fe ff ff    	jne    1d26 <parseredirs+0x1d>
    }
  }
  return cmd;
    1e56:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
}
    1e5a:	c9                   	leave
    1e5b:	c3                   	ret

0000000000001e5c <parseblock>:

struct cmd*
parseblock(char **ps, char *es)
{
    1e5c:	f3 0f 1e fa          	endbr64
    1e60:	55                   	push   %rbp
    1e61:	48 89 e5             	mov    %rsp,%rbp
    1e64:	48 83 ec 20          	sub    $0x20,%rsp
    1e68:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1e6c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  struct cmd *cmd;

  if(!peek(ps, es, "("))
    1e70:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
    1e74:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1e78:	48 ba b7 30 00 00 00 	movabs $0x30b7,%rdx
    1e7f:	00 00 00 
    1e82:	48 89 ce             	mov    %rcx,%rsi
    1e85:	48 89 c7             	mov    %rax,%rdi
    1e88:	48 b8 b4 19 00 00 00 	movabs $0x19b4,%rax
    1e8f:	00 00 00 
    1e92:	ff d0                	call   *%rax
    1e94:	85 c0                	test   %eax,%eax
    1e96:	75 19                	jne    1eb1 <parseblock+0x55>
    panic("parseblock");
    1e98:	48 b8 b9 30 00 00 00 	movabs $0x30b9,%rax
    1e9f:	00 00 00 
    1ea2:	48 89 c7             	mov    %rax,%rdi
    1ea5:	48 b8 54 15 00 00 00 	movabs $0x1554,%rax
    1eac:	00 00 00 
    1eaf:	ff d0                	call   *%rax
  gettoken(ps, es, 0, 0);
    1eb1:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
    1eb5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1eb9:	b9 00 00 00 00       	mov    $0x0,%ecx
    1ebe:	ba 00 00 00 00       	mov    $0x0,%edx
    1ec3:	48 89 c7             	mov    %rax,%rdi
    1ec6:	48 b8 fa 17 00 00 00 	movabs $0x17fa,%rax
    1ecd:	00 00 00 
    1ed0:	ff d0                	call   *%rax
  cmd = parseline(ps, es);
    1ed2:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1ed6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1eda:	48 89 d6             	mov    %rdx,%rsi
    1edd:	48 89 c7             	mov    %rax,%rdi
    1ee0:	48 b8 37 1b 00 00 00 	movabs $0x1b37,%rax
    1ee7:	00 00 00 
    1eea:	ff d0                	call   *%rax
    1eec:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(!peek(ps, es, ")"))
    1ef0:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
    1ef4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1ef8:	48 ba c4 30 00 00 00 	movabs $0x30c4,%rdx
    1eff:	00 00 00 
    1f02:	48 89 ce             	mov    %rcx,%rsi
    1f05:	48 89 c7             	mov    %rax,%rdi
    1f08:	48 b8 b4 19 00 00 00 	movabs $0x19b4,%rax
    1f0f:	00 00 00 
    1f12:	ff d0                	call   *%rax
    1f14:	85 c0                	test   %eax,%eax
    1f16:	75 19                	jne    1f31 <parseblock+0xd5>
    panic("syntax - missing )");
    1f18:	48 b8 c6 30 00 00 00 	movabs $0x30c6,%rax
    1f1f:	00 00 00 
    1f22:	48 89 c7             	mov    %rax,%rdi
    1f25:	48 b8 54 15 00 00 00 	movabs $0x1554,%rax
    1f2c:	00 00 00 
    1f2f:	ff d0                	call   *%rax
  gettoken(ps, es, 0, 0);
    1f31:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
    1f35:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1f39:	b9 00 00 00 00       	mov    $0x0,%ecx
    1f3e:	ba 00 00 00 00       	mov    $0x0,%edx
    1f43:	48 89 c7             	mov    %rax,%rdi
    1f46:	48 b8 fa 17 00 00 00 	movabs $0x17fa,%rax
    1f4d:	00 00 00 
    1f50:	ff d0                	call   *%rax
  cmd = parseredirs(cmd, ps, es);
    1f52:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1f56:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
    1f5a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f5e:	48 89 ce             	mov    %rcx,%rsi
    1f61:	48 89 c7             	mov    %rax,%rdi
    1f64:	48 b8 09 1d 00 00 00 	movabs $0x1d09,%rax
    1f6b:	00 00 00 
    1f6e:	ff d0                	call   *%rax
    1f70:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  return cmd;
    1f74:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    1f78:	c9                   	leave
    1f79:	c3                   	ret

0000000000001f7a <parseexec>:

struct cmd*
parseexec(char **ps, char *es)
{
    1f7a:	f3 0f 1e fa          	endbr64
    1f7e:	55                   	push   %rbp
    1f7f:	48 89 e5             	mov    %rsp,%rbp
    1f82:	48 83 ec 40          	sub    $0x40,%rsp
    1f86:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
    1f8a:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
    1f8e:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
    1f92:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    1f96:	48 ba b7 30 00 00 00 	movabs $0x30b7,%rdx
    1f9d:	00 00 00 
    1fa0:	48 89 ce             	mov    %rcx,%rsi
    1fa3:	48 89 c7             	mov    %rax,%rdi
    1fa6:	48 b8 b4 19 00 00 00 	movabs $0x19b4,%rax
    1fad:	00 00 00 
    1fb0:	ff d0                	call   *%rax
    1fb2:	85 c0                	test   %eax,%eax
    1fb4:	74 1f                	je     1fd5 <parseexec+0x5b>
    return parseblock(ps, es);
    1fb6:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
    1fba:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    1fbe:	48 89 d6             	mov    %rdx,%rsi
    1fc1:	48 89 c7             	mov    %rax,%rdi
    1fc4:	48 b8 5c 1e 00 00 00 	movabs $0x1e5c,%rax
    1fcb:	00 00 00 
    1fce:	ff d0                	call   *%rax
    1fd0:	e9 5d 01 00 00       	jmp    2132 <parseexec+0x1b8>

  ret = execcmd();
    1fd5:	48 b8 d9 15 00 00 00 	movabs $0x15d9,%rax
    1fdc:	00 00 00 
    1fdf:	ff d0                	call   *%rax
    1fe1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  cmd = (struct execcmd*)ret;
    1fe5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1fe9:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

  argc = 0;
    1fed:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  ret = parseredirs(ret, ps, es);
    1ff4:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
    1ff8:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
    1ffc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2000:	48 89 ce             	mov    %rcx,%rsi
    2003:	48 89 c7             	mov    %rax,%rdi
    2006:	48 b8 09 1d 00 00 00 	movabs $0x1d09,%rax
    200d:	00 00 00 
    2010:	ff d0                	call   *%rax
    2012:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(!peek(ps, es, "|)&;")){
    2016:	e9 ba 00 00 00       	jmp    20d5 <parseexec+0x15b>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
    201b:	48 8d 4d d0          	lea    -0x30(%rbp),%rcx
    201f:	48 8d 55 d8          	lea    -0x28(%rbp),%rdx
    2023:	48 8b 75 c0          	mov    -0x40(%rbp),%rsi
    2027:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    202b:	48 89 c7             	mov    %rax,%rdi
    202e:	48 b8 fa 17 00 00 00 	movabs $0x17fa,%rax
    2035:	00 00 00 
    2038:	ff d0                	call   *%rax
    203a:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    203d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
    2041:	0f 84 bc 00 00 00    	je     2103 <parseexec+0x189>
      break;
    if(tok != 'a')
    2047:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
    204b:	74 19                	je     2066 <parseexec+0xec>
      panic("syntax");
    204d:	48 b8 8a 30 00 00 00 	movabs $0x308a,%rax
    2054:	00 00 00 
    2057:	48 89 c7             	mov    %rax,%rdi
    205a:	48 b8 54 15 00 00 00 	movabs $0x1554,%rax
    2061:	00 00 00 
    2064:	ff d0                	call   *%rax
    cmd->argv[argc] = q;
    2066:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
    206a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    206e:	8b 55 fc             	mov    -0x4(%rbp),%edx
    2071:	48 63 d2             	movslq %edx,%rdx
    2074:	48 89 4c d0 08       	mov    %rcx,0x8(%rax,%rdx,8)
    cmd->eargv[argc] = eq;
    2079:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
    207d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    2081:	8b 4d fc             	mov    -0x4(%rbp),%ecx
    2084:	48 63 c9             	movslq %ecx,%rcx
    2087:	48 83 c1 0a          	add    $0xa,%rcx
    208b:	48 89 54 c8 08       	mov    %rdx,0x8(%rax,%rcx,8)
    argc++;
    2090:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    if(argc >= MAXARGS)
    2094:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
    2098:	7e 19                	jle    20b3 <parseexec+0x139>
      panic("too many args");
    209a:	48 b8 d9 30 00 00 00 	movabs $0x30d9,%rax
    20a1:	00 00 00 
    20a4:	48 89 c7             	mov    %rax,%rdi
    20a7:	48 b8 54 15 00 00 00 	movabs $0x1554,%rax
    20ae:	00 00 00 
    20b1:	ff d0                	call   *%rax
    ret = parseredirs(ret, ps, es);
    20b3:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
    20b7:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
    20bb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    20bf:	48 89 ce             	mov    %rcx,%rsi
    20c2:	48 89 c7             	mov    %rax,%rdi
    20c5:	48 b8 09 1d 00 00 00 	movabs $0x1d09,%rax
    20cc:	00 00 00 
    20cf:	ff d0                	call   *%rax
    20d1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(!peek(ps, es, "|)&;")){
    20d5:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
    20d9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    20dd:	48 ba e7 30 00 00 00 	movabs $0x30e7,%rdx
    20e4:	00 00 00 
    20e7:	48 89 ce             	mov    %rcx,%rsi
    20ea:	48 89 c7             	mov    %rax,%rdi
    20ed:	48 b8 b4 19 00 00 00 	movabs $0x19b4,%rax
    20f4:	00 00 00 
    20f7:	ff d0                	call   *%rax
    20f9:	85 c0                	test   %eax,%eax
    20fb:	0f 84 1a ff ff ff    	je     201b <parseexec+0xa1>
    2101:	eb 01                	jmp    2104 <parseexec+0x18a>
      break;
    2103:	90                   	nop
  }
  cmd->argv[argc] = 0;
    2104:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    2108:	8b 55 fc             	mov    -0x4(%rbp),%edx
    210b:	48 63 d2             	movslq %edx,%rdx
    210e:	48 c7 44 d0 08 00 00 	movq   $0x0,0x8(%rax,%rdx,8)
    2115:	00 00 
  cmd->eargv[argc] = 0;
    2117:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    211b:	8b 55 fc             	mov    -0x4(%rbp),%edx
    211e:	48 63 d2             	movslq %edx,%rdx
    2121:	48 83 c2 0a          	add    $0xa,%rdx
    2125:	48 c7 44 d0 08 00 00 	movq   $0x0,0x8(%rax,%rdx,8)
    212c:	00 00 
  return ret;
    212e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
}
    2132:	c9                   	leave
    2133:	c3                   	ret

0000000000002134 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
    2134:	f3 0f 1e fa          	endbr64
    2138:	55                   	push   %rbp
    2139:	48 89 e5             	mov    %rsp,%rbp
    213c:	48 83 ec 40          	sub    $0x40,%rsp
    2140:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    2144:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
    2149:	75 0a                	jne    2155 <nulterminate+0x21>
    return 0;
    214b:	b8 00 00 00 00       	mov    $0x0,%eax
    2150:	e9 33 01 00 00       	jmp    2288 <nulterminate+0x154>

  switch(cmd->type){
    2155:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    2159:	8b 00                	mov    (%rax),%eax
    215b:	83 f8 05             	cmp    $0x5,%eax
    215e:	0f 87 20 01 00 00    	ja     2284 <nulterminate+0x150>
    2164:	89 c0                	mov    %eax,%eax
    2166:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    216d:	00 
    216e:	48 b8 f0 30 00 00 00 	movabs $0x30f0,%rax
    2175:	00 00 00 
    2178:	48 01 d0             	add    %rdx,%rax
    217b:	48 8b 00             	mov    (%rax),%rax
    217e:	3e ff e0             	notrack jmp *%rax
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    2181:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    2185:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    for(i=0; ecmd->argv[i]; i++)
    2189:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    2190:	eb 1a                	jmp    21ac <nulterminate+0x78>
      *ecmd->eargv[i] = 0;
    2192:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    2196:	8b 55 fc             	mov    -0x4(%rbp),%edx
    2199:	48 63 d2             	movslq %edx,%rdx
    219c:	48 83 c2 0a          	add    $0xa,%rdx
    21a0:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
    21a5:	c6 00 00             	movb   $0x0,(%rax)
    for(i=0; ecmd->argv[i]; i++)
    21a8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    21ac:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    21b0:	8b 55 fc             	mov    -0x4(%rbp),%edx
    21b3:	48 63 d2             	movslq %edx,%rdx
    21b6:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
    21bb:	48 85 c0             	test   %rax,%rax
    21be:	75 d2                	jne    2192 <nulterminate+0x5e>
    break;
    21c0:	e9 bf 00 00 00       	jmp    2284 <nulterminate+0x150>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    21c5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    21c9:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    nulterminate(rcmd->cmd);
    21cd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    21d1:	48 8b 40 08          	mov    0x8(%rax),%rax
    21d5:	48 89 c7             	mov    %rax,%rdi
    21d8:	48 b8 34 21 00 00 00 	movabs $0x2134,%rax
    21df:	00 00 00 
    21e2:	ff d0                	call   *%rax
    *rcmd->efile = 0;
    21e4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    21e8:	48 8b 40 18          	mov    0x18(%rax),%rax
    21ec:	c6 00 00             	movb   $0x0,(%rax)
    break;
    21ef:	e9 90 00 00 00       	jmp    2284 <nulterminate+0x150>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    21f4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    21f8:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    nulterminate(pcmd->left);
    21fc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    2200:	48 8b 40 08          	mov    0x8(%rax),%rax
    2204:	48 89 c7             	mov    %rax,%rdi
    2207:	48 b8 34 21 00 00 00 	movabs $0x2134,%rax
    220e:	00 00 00 
    2211:	ff d0                	call   *%rax
    nulterminate(pcmd->right);
    2213:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    2217:	48 8b 40 10          	mov    0x10(%rax),%rax
    221b:	48 89 c7             	mov    %rax,%rdi
    221e:	48 b8 34 21 00 00 00 	movabs $0x2134,%rax
    2225:	00 00 00 
    2228:	ff d0                	call   *%rax
    break;
    222a:	eb 58                	jmp    2284 <nulterminate+0x150>

  case LIST:
    lcmd = (struct listcmd*)cmd;
    222c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    2230:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    nulterminate(lcmd->left);
    2234:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    2238:	48 8b 40 08          	mov    0x8(%rax),%rax
    223c:	48 89 c7             	mov    %rax,%rdi
    223f:	48 b8 34 21 00 00 00 	movabs $0x2134,%rax
    2246:	00 00 00 
    2249:	ff d0                	call   *%rax
    nulterminate(lcmd->right);
    224b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    224f:	48 8b 40 10          	mov    0x10(%rax),%rax
    2253:	48 89 c7             	mov    %rax,%rdi
    2256:	48 b8 34 21 00 00 00 	movabs $0x2134,%rax
    225d:	00 00 00 
    2260:	ff d0                	call   *%rax
    break;
    2262:	eb 20                	jmp    2284 <nulterminate+0x150>

  case BACK:
    bcmd = (struct backcmd*)cmd;
    2264:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    2268:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    nulterminate(bcmd->cmd);
    226c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2270:	48 8b 40 08          	mov    0x8(%rax),%rax
    2274:	48 89 c7             	mov    %rax,%rdi
    2277:	48 b8 34 21 00 00 00 	movabs $0x2134,%rax
    227e:	00 00 00 
    2281:	ff d0                	call   *%rax
    break;
    2283:	90                   	nop
  }
  return cmd;
    2284:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
}
    2288:	c9                   	leave
    2289:	c3                   	ret

000000000000228a <stosb>:
  stosb(dst, c, n);
  return dst;
}

char*
strchr(const char *s, char c)
    228a:	f3 0f 1e fa          	endbr64
    228e:	55                   	push   %rbp
    228f:	48 89 e5             	mov    %rsp,%rbp
    2292:	48 83 ec 10          	sub    $0x10,%rsp
    2296:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    229a:	89 75 f4             	mov    %esi,-0xc(%rbp)
    229d:	89 55 f0             	mov    %edx,-0x10(%rbp)
{
    22a0:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    22a4:	8b 55 f0             	mov    -0x10(%rbp),%edx
    22a7:	8b 45 f4             	mov    -0xc(%rbp),%eax
    22aa:	48 89 ce             	mov    %rcx,%rsi
    22ad:	48 89 f7             	mov    %rsi,%rdi
    22b0:	89 d1                	mov    %edx,%ecx
    22b2:	fc                   	cld
    22b3:	f3 aa                	rep stos %al,%es:(%rdi)
    22b5:	89 ca                	mov    %ecx,%edx
    22b7:	48 89 fe             	mov    %rdi,%rsi
    22ba:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    22be:	89 55 f0             	mov    %edx,-0x10(%rbp)
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
    22c1:	90                   	nop
    22c2:	c9                   	leave
    22c3:	c3                   	ret

00000000000022c4 <strcpy>:
{
    22c4:	f3 0f 1e fa          	endbr64
    22c8:	55                   	push   %rbp
    22c9:	48 89 e5             	mov    %rsp,%rbp
    22cc:	48 83 ec 20          	sub    $0x20,%rsp
    22d0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    22d4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  os = s;
    22d8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    22dc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    22e0:	90                   	nop
    22e1:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    22e5:	48 8d 42 01          	lea    0x1(%rdx),%rax
    22e9:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    22ed:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    22f1:	48 8d 48 01          	lea    0x1(%rax),%rcx
    22f5:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    22f9:	0f b6 12             	movzbl (%rdx),%edx
    22fc:	88 10                	mov    %dl,(%rax)
    22fe:	0f b6 00             	movzbl (%rax),%eax
    2301:	84 c0                	test   %al,%al
    2303:	75 dc                	jne    22e1 <strcpy+0x1d>
  return os;
    2305:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    2309:	c9                   	leave
    230a:	c3                   	ret

000000000000230b <strcmp>:
{
    230b:	f3 0f 1e fa          	endbr64
    230f:	55                   	push   %rbp
    2310:	48 89 e5             	mov    %rsp,%rbp
    2313:	48 83 ec 10          	sub    $0x10,%rsp
    2317:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    231b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    231f:	eb 0a                	jmp    232b <strcmp+0x20>
    p++, q++;
    2321:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    2326:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    232b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    232f:	0f b6 00             	movzbl (%rax),%eax
    2332:	84 c0                	test   %al,%al
    2334:	74 12                	je     2348 <strcmp+0x3d>
    2336:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    233a:	0f b6 10             	movzbl (%rax),%edx
    233d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2341:	0f b6 00             	movzbl (%rax),%eax
    2344:	38 c2                	cmp    %al,%dl
    2346:	74 d9                	je     2321 <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
    2348:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    234c:	0f b6 00             	movzbl (%rax),%eax
    234f:	0f b6 d0             	movzbl %al,%edx
    2352:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2356:	0f b6 00             	movzbl (%rax),%eax
    2359:	0f b6 c0             	movzbl %al,%eax
    235c:	29 c2                	sub    %eax,%edx
    235e:	89 d0                	mov    %edx,%eax
}
    2360:	c9                   	leave
    2361:	c3                   	ret

0000000000002362 <strlen>:
{
    2362:	f3 0f 1e fa          	endbr64
    2366:	55                   	push   %rbp
    2367:	48 89 e5             	mov    %rsp,%rbp
    236a:	48 83 ec 18          	sub    $0x18,%rsp
    236e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  for(n = 0; s[n]; n++)
    2372:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    2379:	eb 04                	jmp    237f <strlen+0x1d>
    237b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    237f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2382:	48 63 d0             	movslq %eax,%rdx
    2385:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    2389:	48 01 d0             	add    %rdx,%rax
    238c:	0f b6 00             	movzbl (%rax),%eax
    238f:	84 c0                	test   %al,%al
    2391:	75 e8                	jne    237b <strlen+0x19>
  return n;
    2393:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    2396:	c9                   	leave
    2397:	c3                   	ret

0000000000002398 <memset>:
{
    2398:	f3 0f 1e fa          	endbr64
    239c:	55                   	push   %rbp
    239d:	48 89 e5             	mov    %rsp,%rbp
    23a0:	48 83 ec 10          	sub    $0x10,%rsp
    23a4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    23a8:	89 75 f4             	mov    %esi,-0xc(%rbp)
    23ab:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    23ae:	8b 55 f0             	mov    -0x10(%rbp),%edx
    23b1:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    23b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    23b8:	89 ce                	mov    %ecx,%esi
    23ba:	48 89 c7             	mov    %rax,%rdi
    23bd:	48 b8 8a 22 00 00 00 	movabs $0x228a,%rax
    23c4:	00 00 00 
    23c7:	ff d0                	call   *%rax
  return dst;
    23c9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    23cd:	c9                   	leave
    23ce:	c3                   	ret

00000000000023cf <strchr>:
{
    23cf:	f3 0f 1e fa          	endbr64
    23d3:	55                   	push   %rbp
    23d4:	48 89 e5             	mov    %rsp,%rbp
    23d7:	48 83 ec 10          	sub    $0x10,%rsp
    23db:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    23df:	89 f0                	mov    %esi,%eax
    23e1:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    23e4:	eb 17                	jmp    23fd <strchr+0x2e>
    if(*s == c)
    23e6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    23ea:	0f b6 00             	movzbl (%rax),%eax
    23ed:	38 45 f4             	cmp    %al,-0xc(%rbp)
    23f0:	75 06                	jne    23f8 <strchr+0x29>
      return (char*)s;
    23f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    23f6:	eb 15                	jmp    240d <strchr+0x3e>
  for(; *s; s++)
    23f8:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    23fd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2401:	0f b6 00             	movzbl (%rax),%eax
    2404:	84 c0                	test   %al,%al
    2406:	75 de                	jne    23e6 <strchr+0x17>
  return 0;
    2408:	b8 00 00 00 00       	mov    $0x0,%eax
}
    240d:	c9                   	leave
    240e:	c3                   	ret

000000000000240f <gets>:

char*
gets(char *buf, int max)
{
    240f:	f3 0f 1e fa          	endbr64
    2413:	55                   	push   %rbp
    2414:	48 89 e5             	mov    %rsp,%rbp
    2417:	48 83 ec 20          	sub    $0x20,%rsp
    241b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    241f:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    2422:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    2429:	eb 4f                	jmp    247a <gets+0x6b>
    cc = read(0, &c, 1);
    242b:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    242f:	ba 01 00 00 00       	mov    $0x1,%edx
    2434:	48 89 c6             	mov    %rax,%rsi
    2437:	bf 00 00 00 00       	mov    $0x0,%edi
    243c:	48 b8 f4 25 00 00 00 	movabs $0x25f4,%rax
    2443:	00 00 00 
    2446:	ff d0                	call   *%rax
    2448:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    244b:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    244f:	7e 36                	jle    2487 <gets+0x78>
      break;
    buf[i++] = c;
    2451:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2454:	8d 50 01             	lea    0x1(%rax),%edx
    2457:	89 55 fc             	mov    %edx,-0x4(%rbp)
    245a:	48 63 d0             	movslq %eax,%rdx
    245d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    2461:	48 01 c2             	add    %rax,%rdx
    2464:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    2468:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    246a:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    246e:	3c 0a                	cmp    $0xa,%al
    2470:	74 16                	je     2488 <gets+0x79>
    2472:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    2476:	3c 0d                	cmp    $0xd,%al
    2478:	74 0e                	je     2488 <gets+0x79>
  for(i=0; i+1 < max; ){
    247a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    247d:	83 c0 01             	add    $0x1,%eax
    2480:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    2483:	7f a6                	jg     242b <gets+0x1c>
    2485:	eb 01                	jmp    2488 <gets+0x79>
      break;
    2487:	90                   	nop
      break;
  }
  buf[i] = '\0';
    2488:	8b 45 fc             	mov    -0x4(%rbp),%eax
    248b:	48 63 d0             	movslq %eax,%rdx
    248e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    2492:	48 01 d0             	add    %rdx,%rax
    2495:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    2498:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    249c:	c9                   	leave
    249d:	c3                   	ret

000000000000249e <stat>:

int
stat(char *n, struct stat *st)
{
    249e:	f3 0f 1e fa          	endbr64
    24a2:	55                   	push   %rbp
    24a3:	48 89 e5             	mov    %rsp,%rbp
    24a6:	48 83 ec 20          	sub    $0x20,%rsp
    24aa:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    24ae:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    24b2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    24b6:	be 00 00 00 00       	mov    $0x0,%esi
    24bb:	48 89 c7             	mov    %rax,%rdi
    24be:	48 b8 35 26 00 00 00 	movabs $0x2635,%rax
    24c5:	00 00 00 
    24c8:	ff d0                	call   *%rax
    24ca:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    24cd:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    24d1:	79 07                	jns    24da <stat+0x3c>
    return -1;
    24d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    24d8:	eb 2f                	jmp    2509 <stat+0x6b>
  r = fstat(fd, st);
    24da:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    24de:	8b 45 fc             	mov    -0x4(%rbp),%eax
    24e1:	48 89 d6             	mov    %rdx,%rsi
    24e4:	89 c7                	mov    %eax,%edi
    24e6:	48 b8 5c 26 00 00 00 	movabs $0x265c,%rax
    24ed:	00 00 00 
    24f0:	ff d0                	call   *%rax
    24f2:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    24f5:	8b 45 fc             	mov    -0x4(%rbp),%eax
    24f8:	89 c7                	mov    %eax,%edi
    24fa:	48 b8 0e 26 00 00 00 	movabs $0x260e,%rax
    2501:	00 00 00 
    2504:	ff d0                	call   *%rax
  return r;
    2506:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    2509:	c9                   	leave
    250a:	c3                   	ret

000000000000250b <atoi>:

int
atoi(const char *s)
{
    250b:	f3 0f 1e fa          	endbr64
    250f:	55                   	push   %rbp
    2510:	48 89 e5             	mov    %rsp,%rbp
    2513:	48 83 ec 18          	sub    $0x18,%rsp
    2517:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    251b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    2522:	eb 28                	jmp    254c <atoi+0x41>
    n = n*10 + *s++ - '0';
    2524:	8b 55 fc             	mov    -0x4(%rbp),%edx
    2527:	89 d0                	mov    %edx,%eax
    2529:	c1 e0 02             	shl    $0x2,%eax
    252c:	01 d0                	add    %edx,%eax
    252e:	01 c0                	add    %eax,%eax
    2530:	89 c1                	mov    %eax,%ecx
    2532:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    2536:	48 8d 50 01          	lea    0x1(%rax),%rdx
    253a:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    253e:	0f b6 00             	movzbl (%rax),%eax
    2541:	0f be c0             	movsbl %al,%eax
    2544:	01 c8                	add    %ecx,%eax
    2546:	83 e8 30             	sub    $0x30,%eax
    2549:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    254c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    2550:	0f b6 00             	movzbl (%rax),%eax
    2553:	3c 2f                	cmp    $0x2f,%al
    2555:	7e 0b                	jle    2562 <atoi+0x57>
    2557:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    255b:	0f b6 00             	movzbl (%rax),%eax
    255e:	3c 39                	cmp    $0x39,%al
    2560:	7e c2                	jle    2524 <atoi+0x19>
  return n;
    2562:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    2565:	c9                   	leave
    2566:	c3                   	ret

0000000000002567 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    2567:	f3 0f 1e fa          	endbr64
    256b:	55                   	push   %rbp
    256c:	48 89 e5             	mov    %rsp,%rbp
    256f:	48 83 ec 28          	sub    $0x28,%rsp
    2573:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    2577:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    257b:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    257e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    2582:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    2586:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    258a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    258e:	eb 1d                	jmp    25ad <memmove+0x46>
    *dst++ = *src++;
    2590:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    2594:	48 8d 42 01          	lea    0x1(%rdx),%rax
    2598:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    259c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    25a0:	48 8d 48 01          	lea    0x1(%rax),%rcx
    25a4:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    25a8:	0f b6 12             	movzbl (%rdx),%edx
    25ab:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    25ad:	8b 45 dc             	mov    -0x24(%rbp),%eax
    25b0:	8d 50 ff             	lea    -0x1(%rax),%edx
    25b3:	89 55 dc             	mov    %edx,-0x24(%rbp)
    25b6:	85 c0                	test   %eax,%eax
    25b8:	7f d6                	jg     2590 <memmove+0x29>
  return vdst;
    25ba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    25be:	c9                   	leave
    25bf:	c3                   	ret

00000000000025c0 <fork>:
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    25c0:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    25c7:	49 89 ca             	mov    %rcx,%r10
    25ca:	0f 05                	syscall
    25cc:	c3                   	ret

00000000000025cd <exit>:
SYSCALL(exit)
    25cd:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    25d4:	49 89 ca             	mov    %rcx,%r10
    25d7:	0f 05                	syscall
    25d9:	c3                   	ret

00000000000025da <wait>:
SYSCALL(wait)
    25da:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    25e1:	49 89 ca             	mov    %rcx,%r10
    25e4:	0f 05                	syscall
    25e6:	c3                   	ret

00000000000025e7 <pipe>:
SYSCALL(pipe)
    25e7:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    25ee:	49 89 ca             	mov    %rcx,%r10
    25f1:	0f 05                	syscall
    25f3:	c3                   	ret

00000000000025f4 <read>:
SYSCALL(read)
    25f4:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    25fb:	49 89 ca             	mov    %rcx,%r10
    25fe:	0f 05                	syscall
    2600:	c3                   	ret

0000000000002601 <write>:
SYSCALL(write)
    2601:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    2608:	49 89 ca             	mov    %rcx,%r10
    260b:	0f 05                	syscall
    260d:	c3                   	ret

000000000000260e <close>:
SYSCALL(close)
    260e:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    2615:	49 89 ca             	mov    %rcx,%r10
    2618:	0f 05                	syscall
    261a:	c3                   	ret

000000000000261b <kill>:
SYSCALL(kill)
    261b:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    2622:	49 89 ca             	mov    %rcx,%r10
    2625:	0f 05                	syscall
    2627:	c3                   	ret

0000000000002628 <exec>:
SYSCALL(exec)
    2628:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    262f:	49 89 ca             	mov    %rcx,%r10
    2632:	0f 05                	syscall
    2634:	c3                   	ret

0000000000002635 <open>:
SYSCALL(open)
    2635:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    263c:	49 89 ca             	mov    %rcx,%r10
    263f:	0f 05                	syscall
    2641:	c3                   	ret

0000000000002642 <mknod>:
SYSCALL(mknod)
    2642:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    2649:	49 89 ca             	mov    %rcx,%r10
    264c:	0f 05                	syscall
    264e:	c3                   	ret

000000000000264f <unlink>:
SYSCALL(unlink)
    264f:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    2656:	49 89 ca             	mov    %rcx,%r10
    2659:	0f 05                	syscall
    265b:	c3                   	ret

000000000000265c <fstat>:
SYSCALL(fstat)
    265c:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    2663:	49 89 ca             	mov    %rcx,%r10
    2666:	0f 05                	syscall
    2668:	c3                   	ret

0000000000002669 <link>:
SYSCALL(link)
    2669:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    2670:	49 89 ca             	mov    %rcx,%r10
    2673:	0f 05                	syscall
    2675:	c3                   	ret

0000000000002676 <mkdir>:
SYSCALL(mkdir)
    2676:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    267d:	49 89 ca             	mov    %rcx,%r10
    2680:	0f 05                	syscall
    2682:	c3                   	ret

0000000000002683 <chdir>:
SYSCALL(chdir)
    2683:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    268a:	49 89 ca             	mov    %rcx,%r10
    268d:	0f 05                	syscall
    268f:	c3                   	ret

0000000000002690 <dup>:
SYSCALL(dup)
    2690:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    2697:	49 89 ca             	mov    %rcx,%r10
    269a:	0f 05                	syscall
    269c:	c3                   	ret

000000000000269d <getpid>:
SYSCALL(getpid)
    269d:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    26a4:	49 89 ca             	mov    %rcx,%r10
    26a7:	0f 05                	syscall
    26a9:	c3                   	ret

00000000000026aa <sbrk>:
SYSCALL(sbrk)
    26aa:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    26b1:	49 89 ca             	mov    %rcx,%r10
    26b4:	0f 05                	syscall
    26b6:	c3                   	ret

00000000000026b7 <sleep>:
SYSCALL(sleep)
    26b7:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    26be:	49 89 ca             	mov    %rcx,%r10
    26c1:	0f 05                	syscall
    26c3:	c3                   	ret

00000000000026c4 <uptime>:
SYSCALL(uptime)
    26c4:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    26cb:	49 89 ca             	mov    %rcx,%r10
    26ce:	0f 05                	syscall
    26d0:	c3                   	ret

00000000000026d1 <send>:
SYSCALL(send)
    26d1:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    26d8:	49 89 ca             	mov    %rcx,%r10
    26db:	0f 05                	syscall
    26dd:	c3                   	ret

00000000000026de <recv>:
SYSCALL(recv)
    26de:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    26e5:	49 89 ca             	mov    %rcx,%r10
    26e8:	0f 05                	syscall
    26ea:	c3                   	ret

00000000000026eb <register_fsserver>:
SYSCALL(register_fsserver)
    26eb:	48 c7 c0 18 00 00 00 	mov    $0x18,%rax
    26f2:	49 89 ca             	mov    %rcx,%r10
    26f5:	0f 05                	syscall
    26f7:	c3                   	ret

00000000000026f8 <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    26f8:	f3 0f 1e fa          	endbr64
    26fc:	55                   	push   %rbp
    26fd:	48 89 e5             	mov    %rsp,%rbp
    2700:	48 83 ec 10          	sub    $0x10,%rsp
    2704:	89 7d fc             	mov    %edi,-0x4(%rbp)
    2707:	89 f0                	mov    %esi,%eax
    2709:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    270c:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    2710:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2713:	ba 01 00 00 00       	mov    $0x1,%edx
    2718:	48 89 ce             	mov    %rcx,%rsi
    271b:	89 c7                	mov    %eax,%edi
    271d:	48 b8 01 26 00 00 00 	movabs $0x2601,%rax
    2724:	00 00 00 
    2727:	ff d0                	call   *%rax
}
    2729:	90                   	nop
    272a:	c9                   	leave
    272b:	c3                   	ret

000000000000272c <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    272c:	f3 0f 1e fa          	endbr64
    2730:	55                   	push   %rbp
    2731:	48 89 e5             	mov    %rsp,%rbp
    2734:	48 83 ec 20          	sub    $0x20,%rsp
    2738:	89 7d ec             	mov    %edi,-0x14(%rbp)
    273b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    273f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    2746:	eb 35                	jmp    277d <print_x64+0x51>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    2748:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    274c:	48 c1 e8 3c          	shr    $0x3c,%rax
    2750:	48 ba f0 31 00 00 00 	movabs $0x31f0,%rdx
    2757:	00 00 00 
    275a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    275e:	0f be d0             	movsbl %al,%edx
    2761:	8b 45 ec             	mov    -0x14(%rbp),%eax
    2764:	89 d6                	mov    %edx,%esi
    2766:	89 c7                	mov    %eax,%edi
    2768:	48 b8 f8 26 00 00 00 	movabs $0x26f8,%rax
    276f:	00 00 00 
    2772:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    2774:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    2778:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    277d:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2780:	83 f8 0f             	cmp    $0xf,%eax
    2783:	76 c3                	jbe    2748 <print_x64+0x1c>
}
    2785:	90                   	nop
    2786:	90                   	nop
    2787:	c9                   	leave
    2788:	c3                   	ret

0000000000002789 <print_x32>:

  static void
print_x32(int fd, uint x)
{
    2789:	f3 0f 1e fa          	endbr64
    278d:	55                   	push   %rbp
    278e:	48 89 e5             	mov    %rsp,%rbp
    2791:	48 83 ec 20          	sub    $0x20,%rsp
    2795:	89 7d ec             	mov    %edi,-0x14(%rbp)
    2798:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    279b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    27a2:	eb 36                	jmp    27da <print_x32+0x51>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    27a4:	8b 45 e8             	mov    -0x18(%rbp),%eax
    27a7:	c1 e8 1c             	shr    $0x1c,%eax
    27aa:	89 c2                	mov    %eax,%edx
    27ac:	48 b8 f0 31 00 00 00 	movabs $0x31f0,%rax
    27b3:	00 00 00 
    27b6:	89 d2                	mov    %edx,%edx
    27b8:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    27bc:	0f be d0             	movsbl %al,%edx
    27bf:	8b 45 ec             	mov    -0x14(%rbp),%eax
    27c2:	89 d6                	mov    %edx,%esi
    27c4:	89 c7                	mov    %eax,%edi
    27c6:	48 b8 f8 26 00 00 00 	movabs $0x26f8,%rax
    27cd:	00 00 00 
    27d0:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    27d2:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    27d6:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    27da:	8b 45 fc             	mov    -0x4(%rbp),%eax
    27dd:	83 f8 07             	cmp    $0x7,%eax
    27e0:	76 c2                	jbe    27a4 <print_x32+0x1b>
}
    27e2:	90                   	nop
    27e3:	90                   	nop
    27e4:	c9                   	leave
    27e5:	c3                   	ret

00000000000027e6 <print_d>:

  static void
print_d(int fd, int v)
{
    27e6:	f3 0f 1e fa          	endbr64
    27ea:	55                   	push   %rbp
    27eb:	48 89 e5             	mov    %rsp,%rbp
    27ee:	48 83 ec 30          	sub    $0x30,%rsp
    27f2:	89 7d dc             	mov    %edi,-0x24(%rbp)
    27f5:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    27f8:	8b 45 d8             	mov    -0x28(%rbp),%eax
    27fb:	48 98                	cltq
    27fd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    2801:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    2805:	79 04                	jns    280b <print_d+0x25>
    x = -x;
    2807:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    280b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    2812:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    2816:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    281d:	66 66 66 
    2820:	48 89 c8             	mov    %rcx,%rax
    2823:	48 f7 ea             	imul   %rdx
    2826:	48 c1 fa 02          	sar    $0x2,%rdx
    282a:	48 89 c8             	mov    %rcx,%rax
    282d:	48 c1 f8 3f          	sar    $0x3f,%rax
    2831:	48 29 c2             	sub    %rax,%rdx
    2834:	48 89 d0             	mov    %rdx,%rax
    2837:	48 c1 e0 02          	shl    $0x2,%rax
    283b:	48 01 d0             	add    %rdx,%rax
    283e:	48 01 c0             	add    %rax,%rax
    2841:	48 29 c1             	sub    %rax,%rcx
    2844:	48 89 ca             	mov    %rcx,%rdx
    2847:	8b 45 f4             	mov    -0xc(%rbp),%eax
    284a:	8d 48 01             	lea    0x1(%rax),%ecx
    284d:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    2850:	48 b9 f0 31 00 00 00 	movabs $0x31f0,%rcx
    2857:	00 00 00 
    285a:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    285e:	48 98                	cltq
    2860:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    2864:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    2868:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    286f:	66 66 66 
    2872:	48 89 c8             	mov    %rcx,%rax
    2875:	48 f7 ea             	imul   %rdx
    2878:	48 89 d0             	mov    %rdx,%rax
    287b:	48 c1 f8 02          	sar    $0x2,%rax
    287f:	48 c1 f9 3f          	sar    $0x3f,%rcx
    2883:	48 89 ca             	mov    %rcx,%rdx
    2886:	48 29 d0             	sub    %rdx,%rax
    2889:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    288d:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    2892:	0f 85 7a ff ff ff    	jne    2812 <print_d+0x2c>

  if (v < 0)
    2898:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    289c:	79 32                	jns    28d0 <print_d+0xea>
    buf[i++] = '-';
    289e:	8b 45 f4             	mov    -0xc(%rbp),%eax
    28a1:	8d 50 01             	lea    0x1(%rax),%edx
    28a4:	89 55 f4             	mov    %edx,-0xc(%rbp)
    28a7:	48 98                	cltq
    28a9:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    28ae:	eb 20                	jmp    28d0 <print_d+0xea>
    putc(fd, buf[i]);
    28b0:	8b 45 f4             	mov    -0xc(%rbp),%eax
    28b3:	48 98                	cltq
    28b5:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    28ba:	0f be d0             	movsbl %al,%edx
    28bd:	8b 45 dc             	mov    -0x24(%rbp),%eax
    28c0:	89 d6                	mov    %edx,%esi
    28c2:	89 c7                	mov    %eax,%edi
    28c4:	48 b8 f8 26 00 00 00 	movabs $0x26f8,%rax
    28cb:	00 00 00 
    28ce:	ff d0                	call   *%rax
  while (--i >= 0)
    28d0:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    28d4:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    28d8:	79 d6                	jns    28b0 <print_d+0xca>
}
    28da:	90                   	nop
    28db:	90                   	nop
    28dc:	c9                   	leave
    28dd:	c3                   	ret

00000000000028de <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    28de:	f3 0f 1e fa          	endbr64
    28e2:	55                   	push   %rbp
    28e3:	48 89 e5             	mov    %rsp,%rbp
    28e6:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    28ed:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    28f3:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    28fa:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    2901:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    2908:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    290f:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    2916:	84 c0                	test   %al,%al
    2918:	74 20                	je     293a <printf+0x5c>
    291a:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    291e:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    2922:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    2926:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    292a:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    292e:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    2932:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    2936:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    293a:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    2941:	00 00 00 
    2944:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    294b:	00 00 00 
    294e:	48 8d 45 10          	lea    0x10(%rbp),%rax
    2952:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    2959:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    2960:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    2967:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    296e:	00 00 00 
    2971:	e9 41 03 00 00       	jmp    2cb7 <printf+0x3d9>
    if (c != '%') {
    2976:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    297d:	74 24                	je     29a3 <printf+0xc5>
      putc(fd, c);
    297f:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    2985:	0f be d0             	movsbl %al,%edx
    2988:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    298e:	89 d6                	mov    %edx,%esi
    2990:	89 c7                	mov    %eax,%edi
    2992:	48 b8 f8 26 00 00 00 	movabs $0x26f8,%rax
    2999:	00 00 00 
    299c:	ff d0                	call   *%rax
      continue;
    299e:	e9 0d 03 00 00       	jmp    2cb0 <printf+0x3d2>
    }
    c = fmt[++i] & 0xff;
    29a3:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    29aa:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    29b0:	48 63 d0             	movslq %eax,%rdx
    29b3:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    29ba:	48 01 d0             	add    %rdx,%rax
    29bd:	0f b6 00             	movzbl (%rax),%eax
    29c0:	0f be c0             	movsbl %al,%eax
    29c3:	25 ff 00 00 00       	and    $0xff,%eax
    29c8:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    29ce:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    29d5:	0f 84 0f 03 00 00    	je     2cea <printf+0x40c>
      break;
    switch(c) {
    29db:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    29e2:	0f 84 74 02 00 00    	je     2c5c <printf+0x37e>
    29e8:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    29ef:	0f 8c 82 02 00 00    	jl     2c77 <printf+0x399>
    29f5:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    29fc:	0f 8f 75 02 00 00    	jg     2c77 <printf+0x399>
    2a02:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    2a09:	0f 8c 68 02 00 00    	jl     2c77 <printf+0x399>
    2a0f:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    2a15:	83 e8 63             	sub    $0x63,%eax
    2a18:	83 f8 15             	cmp    $0x15,%eax
    2a1b:	0f 87 56 02 00 00    	ja     2c77 <printf+0x399>
    2a21:	89 c0                	mov    %eax,%eax
    2a23:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    2a2a:	00 
    2a2b:	48 b8 28 31 00 00 00 	movabs $0x3128,%rax
    2a32:	00 00 00 
    2a35:	48 01 d0             	add    %rdx,%rax
    2a38:	48 8b 00             	mov    (%rax),%rax
    2a3b:	3e ff e0             	notrack jmp *%rax
    case 'c':
      putc(fd, va_arg(ap, int));
    2a3e:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    2a44:	83 f8 2f             	cmp    $0x2f,%eax
    2a47:	77 23                	ja     2a6c <printf+0x18e>
    2a49:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    2a50:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    2a56:	89 d2                	mov    %edx,%edx
    2a58:	48 01 d0             	add    %rdx,%rax
    2a5b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    2a61:	83 c2 08             	add    $0x8,%edx
    2a64:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    2a6a:	eb 12                	jmp    2a7e <printf+0x1a0>
    2a6c:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    2a73:	48 8d 50 08          	lea    0x8(%rax),%rdx
    2a77:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    2a7e:	8b 00                	mov    (%rax),%eax
    2a80:	0f be d0             	movsbl %al,%edx
    2a83:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    2a89:	89 d6                	mov    %edx,%esi
    2a8b:	89 c7                	mov    %eax,%edi
    2a8d:	48 b8 f8 26 00 00 00 	movabs $0x26f8,%rax
    2a94:	00 00 00 
    2a97:	ff d0                	call   *%rax
      break;
    2a99:	e9 12 02 00 00       	jmp    2cb0 <printf+0x3d2>
    case 'd':
      print_d(fd, va_arg(ap, int));
    2a9e:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    2aa4:	83 f8 2f             	cmp    $0x2f,%eax
    2aa7:	77 23                	ja     2acc <printf+0x1ee>
    2aa9:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    2ab0:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    2ab6:	89 d2                	mov    %edx,%edx
    2ab8:	48 01 d0             	add    %rdx,%rax
    2abb:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    2ac1:	83 c2 08             	add    $0x8,%edx
    2ac4:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    2aca:	eb 12                	jmp    2ade <printf+0x200>
    2acc:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    2ad3:	48 8d 50 08          	lea    0x8(%rax),%rdx
    2ad7:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    2ade:	8b 10                	mov    (%rax),%edx
    2ae0:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    2ae6:	89 d6                	mov    %edx,%esi
    2ae8:	89 c7                	mov    %eax,%edi
    2aea:	48 b8 e6 27 00 00 00 	movabs $0x27e6,%rax
    2af1:	00 00 00 
    2af4:	ff d0                	call   *%rax
      break;
    2af6:	e9 b5 01 00 00       	jmp    2cb0 <printf+0x3d2>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    2afb:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    2b01:	83 f8 2f             	cmp    $0x2f,%eax
    2b04:	77 23                	ja     2b29 <printf+0x24b>
    2b06:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    2b0d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    2b13:	89 d2                	mov    %edx,%edx
    2b15:	48 01 d0             	add    %rdx,%rax
    2b18:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    2b1e:	83 c2 08             	add    $0x8,%edx
    2b21:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    2b27:	eb 12                	jmp    2b3b <printf+0x25d>
    2b29:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    2b30:	48 8d 50 08          	lea    0x8(%rax),%rdx
    2b34:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    2b3b:	8b 10                	mov    (%rax),%edx
    2b3d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    2b43:	89 d6                	mov    %edx,%esi
    2b45:	89 c7                	mov    %eax,%edi
    2b47:	48 b8 89 27 00 00 00 	movabs $0x2789,%rax
    2b4e:	00 00 00 
    2b51:	ff d0                	call   *%rax
      break;
    2b53:	e9 58 01 00 00       	jmp    2cb0 <printf+0x3d2>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    2b58:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    2b5e:	83 f8 2f             	cmp    $0x2f,%eax
    2b61:	77 23                	ja     2b86 <printf+0x2a8>
    2b63:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    2b6a:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    2b70:	89 d2                	mov    %edx,%edx
    2b72:	48 01 d0             	add    %rdx,%rax
    2b75:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    2b7b:	83 c2 08             	add    $0x8,%edx
    2b7e:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    2b84:	eb 12                	jmp    2b98 <printf+0x2ba>
    2b86:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    2b8d:	48 8d 50 08          	lea    0x8(%rax),%rdx
    2b91:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    2b98:	48 8b 10             	mov    (%rax),%rdx
    2b9b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    2ba1:	48 89 d6             	mov    %rdx,%rsi
    2ba4:	89 c7                	mov    %eax,%edi
    2ba6:	48 b8 2c 27 00 00 00 	movabs $0x272c,%rax
    2bad:	00 00 00 
    2bb0:	ff d0                	call   *%rax
      break;
    2bb2:	e9 f9 00 00 00       	jmp    2cb0 <printf+0x3d2>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    2bb7:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    2bbd:	83 f8 2f             	cmp    $0x2f,%eax
    2bc0:	77 23                	ja     2be5 <printf+0x307>
    2bc2:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    2bc9:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    2bcf:	89 d2                	mov    %edx,%edx
    2bd1:	48 01 d0             	add    %rdx,%rax
    2bd4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    2bda:	83 c2 08             	add    $0x8,%edx
    2bdd:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    2be3:	eb 12                	jmp    2bf7 <printf+0x319>
    2be5:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    2bec:	48 8d 50 08          	lea    0x8(%rax),%rdx
    2bf0:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    2bf7:	48 8b 00             	mov    (%rax),%rax
    2bfa:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    2c01:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    2c08:	00 
    2c09:	75 41                	jne    2c4c <printf+0x36e>
        s = "(null)";
    2c0b:	48 b8 20 31 00 00 00 	movabs $0x3120,%rax
    2c12:	00 00 00 
    2c15:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    2c1c:	eb 2e                	jmp    2c4c <printf+0x36e>
        putc(fd, *(s++));
    2c1e:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    2c25:	48 8d 50 01          	lea    0x1(%rax),%rdx
    2c29:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    2c30:	0f b6 00             	movzbl (%rax),%eax
    2c33:	0f be d0             	movsbl %al,%edx
    2c36:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    2c3c:	89 d6                	mov    %edx,%esi
    2c3e:	89 c7                	mov    %eax,%edi
    2c40:	48 b8 f8 26 00 00 00 	movabs $0x26f8,%rax
    2c47:	00 00 00 
    2c4a:	ff d0                	call   *%rax
      while (*s)
    2c4c:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    2c53:	0f b6 00             	movzbl (%rax),%eax
    2c56:	84 c0                	test   %al,%al
    2c58:	75 c4                	jne    2c1e <printf+0x340>
      break;
    2c5a:	eb 54                	jmp    2cb0 <printf+0x3d2>
    case '%':
      putc(fd, '%');
    2c5c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    2c62:	be 25 00 00 00       	mov    $0x25,%esi
    2c67:	89 c7                	mov    %eax,%edi
    2c69:	48 b8 f8 26 00 00 00 	movabs $0x26f8,%rax
    2c70:	00 00 00 
    2c73:	ff d0                	call   *%rax
      break;
    2c75:	eb 39                	jmp    2cb0 <printf+0x3d2>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    2c77:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    2c7d:	be 25 00 00 00       	mov    $0x25,%esi
    2c82:	89 c7                	mov    %eax,%edi
    2c84:	48 b8 f8 26 00 00 00 	movabs $0x26f8,%rax
    2c8b:	00 00 00 
    2c8e:	ff d0                	call   *%rax
      putc(fd, c);
    2c90:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    2c96:	0f be d0             	movsbl %al,%edx
    2c99:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    2c9f:	89 d6                	mov    %edx,%esi
    2ca1:	89 c7                	mov    %eax,%edi
    2ca3:	48 b8 f8 26 00 00 00 	movabs $0x26f8,%rax
    2caa:	00 00 00 
    2cad:	ff d0                	call   *%rax
      break;
    2caf:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    2cb0:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    2cb7:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    2cbd:	48 63 d0             	movslq %eax,%rdx
    2cc0:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    2cc7:	48 01 d0             	add    %rdx,%rax
    2cca:	0f b6 00             	movzbl (%rax),%eax
    2ccd:	0f be c0             	movsbl %al,%eax
    2cd0:	25 ff 00 00 00       	and    $0xff,%eax
    2cd5:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    2cdb:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    2ce2:	0f 85 8e fc ff ff    	jne    2976 <printf+0x98>
    }
  }
}
    2ce8:	eb 01                	jmp    2ceb <printf+0x40d>
      break;
    2cea:	90                   	nop
}
    2ceb:	90                   	nop
    2cec:	c9                   	leave
    2ced:	c3                   	ret

0000000000002cee <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    2cee:	f3 0f 1e fa          	endbr64
    2cf2:	55                   	push   %rbp
    2cf3:	48 89 e5             	mov    %rsp,%rbp
    2cf6:	48 83 ec 18          	sub    $0x18,%rsp
    2cfa:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    2cfe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    2d02:	48 83 e8 10          	sub    $0x10,%rax
    2d06:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    2d0a:	48 b8 a0 32 00 00 00 	movabs $0x32a0,%rax
    2d11:	00 00 00 
    2d14:	48 8b 00             	mov    (%rax),%rax
    2d17:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    2d1b:	eb 2f                	jmp    2d4c <free+0x5e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    2d1d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2d21:	48 8b 00             	mov    (%rax),%rax
    2d24:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    2d28:	72 17                	jb     2d41 <free+0x53>
    2d2a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2d2e:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    2d32:	72 2f                	jb     2d63 <free+0x75>
    2d34:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2d38:	48 8b 00             	mov    (%rax),%rax
    2d3b:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    2d3f:	72 22                	jb     2d63 <free+0x75>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    2d41:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2d45:	48 8b 00             	mov    (%rax),%rax
    2d48:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    2d4c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2d50:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    2d54:	73 c7                	jae    2d1d <free+0x2f>
    2d56:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2d5a:	48 8b 00             	mov    (%rax),%rax
    2d5d:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    2d61:	73 ba                	jae    2d1d <free+0x2f>
      break;
  if(bp + bp->s.size == p->s.ptr){
    2d63:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2d67:	8b 40 08             	mov    0x8(%rax),%eax
    2d6a:	89 c0                	mov    %eax,%eax
    2d6c:	48 c1 e0 04          	shl    $0x4,%rax
    2d70:	48 89 c2             	mov    %rax,%rdx
    2d73:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2d77:	48 01 c2             	add    %rax,%rdx
    2d7a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2d7e:	48 8b 00             	mov    (%rax),%rax
    2d81:	48 39 c2             	cmp    %rax,%rdx
    2d84:	75 2d                	jne    2db3 <free+0xc5>
    bp->s.size += p->s.ptr->s.size;
    2d86:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2d8a:	8b 50 08             	mov    0x8(%rax),%edx
    2d8d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2d91:	48 8b 00             	mov    (%rax),%rax
    2d94:	8b 40 08             	mov    0x8(%rax),%eax
    2d97:	01 c2                	add    %eax,%edx
    2d99:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2d9d:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    2da0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2da4:	48 8b 00             	mov    (%rax),%rax
    2da7:	48 8b 10             	mov    (%rax),%rdx
    2daa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2dae:	48 89 10             	mov    %rdx,(%rax)
    2db1:	eb 0e                	jmp    2dc1 <free+0xd3>
  } else
    bp->s.ptr = p->s.ptr;
    2db3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2db7:	48 8b 10             	mov    (%rax),%rdx
    2dba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2dbe:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    2dc1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2dc5:	8b 40 08             	mov    0x8(%rax),%eax
    2dc8:	89 c0                	mov    %eax,%eax
    2dca:	48 c1 e0 04          	shl    $0x4,%rax
    2dce:	48 89 c2             	mov    %rax,%rdx
    2dd1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2dd5:	48 01 d0             	add    %rdx,%rax
    2dd8:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    2ddc:	75 27                	jne    2e05 <free+0x117>
    p->s.size += bp->s.size;
    2dde:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2de2:	8b 50 08             	mov    0x8(%rax),%edx
    2de5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2de9:	8b 40 08             	mov    0x8(%rax),%eax
    2dec:	01 c2                	add    %eax,%edx
    2dee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2df2:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    2df5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2df9:	48 8b 10             	mov    (%rax),%rdx
    2dfc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2e00:	48 89 10             	mov    %rdx,(%rax)
    2e03:	eb 0b                	jmp    2e10 <free+0x122>
  } else
    p->s.ptr = bp;
    2e05:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2e09:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    2e0d:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    2e10:	48 ba a0 32 00 00 00 	movabs $0x32a0,%rdx
    2e17:	00 00 00 
    2e1a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2e1e:	48 89 02             	mov    %rax,(%rdx)
}
    2e21:	90                   	nop
    2e22:	c9                   	leave
    2e23:	c3                   	ret

0000000000002e24 <morecore>:

static Header*
morecore(uint nu)
{
    2e24:	f3 0f 1e fa          	endbr64
    2e28:	55                   	push   %rbp
    2e29:	48 89 e5             	mov    %rsp,%rbp
    2e2c:	48 83 ec 20          	sub    $0x20,%rsp
    2e30:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    2e33:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    2e3a:	77 07                	ja     2e43 <morecore+0x1f>
    nu = 4096;
    2e3c:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    2e43:	8b 45 ec             	mov    -0x14(%rbp),%eax
    2e46:	48 c1 e0 04          	shl    $0x4,%rax
    2e4a:	48 89 c7             	mov    %rax,%rdi
    2e4d:	48 b8 aa 26 00 00 00 	movabs $0x26aa,%rax
    2e54:	00 00 00 
    2e57:	ff d0                	call   *%rax
    2e59:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    2e5d:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    2e62:	75 07                	jne    2e6b <morecore+0x47>
    return 0;
    2e64:	b8 00 00 00 00       	mov    $0x0,%eax
    2e69:	eb 36                	jmp    2ea1 <morecore+0x7d>
  hp = (Header*)p;
    2e6b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2e6f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    2e73:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2e77:	8b 55 ec             	mov    -0x14(%rbp),%edx
    2e7a:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    2e7d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2e81:	48 83 c0 10          	add    $0x10,%rax
    2e85:	48 89 c7             	mov    %rax,%rdi
    2e88:	48 b8 ee 2c 00 00 00 	movabs $0x2cee,%rax
    2e8f:	00 00 00 
    2e92:	ff d0                	call   *%rax
  return freep;
    2e94:	48 b8 a0 32 00 00 00 	movabs $0x32a0,%rax
    2e9b:	00 00 00 
    2e9e:	48 8b 00             	mov    (%rax),%rax
}
    2ea1:	c9                   	leave
    2ea2:	c3                   	ret

0000000000002ea3 <malloc>:

void*
malloc(uint nbytes)
{
    2ea3:	f3 0f 1e fa          	endbr64
    2ea7:	55                   	push   %rbp
    2ea8:	48 89 e5             	mov    %rsp,%rbp
    2eab:	48 83 ec 30          	sub    $0x30,%rsp
    2eaf:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    2eb2:	8b 45 dc             	mov    -0x24(%rbp),%eax
    2eb5:	48 83 c0 0f          	add    $0xf,%rax
    2eb9:	48 c1 e8 04          	shr    $0x4,%rax
    2ebd:	83 c0 01             	add    $0x1,%eax
    2ec0:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    2ec3:	48 b8 a0 32 00 00 00 	movabs $0x32a0,%rax
    2eca:	00 00 00 
    2ecd:	48 8b 00             	mov    (%rax),%rax
    2ed0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    2ed4:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    2ed9:	75 4a                	jne    2f25 <malloc+0x82>
    base.s.ptr = freep = prevp = &base;
    2edb:	48 b8 90 32 00 00 00 	movabs $0x3290,%rax
    2ee2:	00 00 00 
    2ee5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    2ee9:	48 ba a0 32 00 00 00 	movabs $0x32a0,%rdx
    2ef0:	00 00 00 
    2ef3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2ef7:	48 89 02             	mov    %rax,(%rdx)
    2efa:	48 b8 a0 32 00 00 00 	movabs $0x32a0,%rax
    2f01:	00 00 00 
    2f04:	48 8b 00             	mov    (%rax),%rax
    2f07:	48 ba 90 32 00 00 00 	movabs $0x3290,%rdx
    2f0e:	00 00 00 
    2f11:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    2f14:	48 b8 90 32 00 00 00 	movabs $0x3290,%rax
    2f1b:	00 00 00 
    2f1e:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    2f25:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2f29:	48 8b 00             	mov    (%rax),%rax
    2f2c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    2f30:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2f34:	8b 40 08             	mov    0x8(%rax),%eax
    2f37:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    2f3a:	72 65                	jb     2fa1 <malloc+0xfe>
      if(p->s.size == nunits)
    2f3c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2f40:	8b 40 08             	mov    0x8(%rax),%eax
    2f43:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    2f46:	75 10                	jne    2f58 <malloc+0xb5>
        prevp->s.ptr = p->s.ptr;
    2f48:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2f4c:	48 8b 10             	mov    (%rax),%rdx
    2f4f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2f53:	48 89 10             	mov    %rdx,(%rax)
    2f56:	eb 2e                	jmp    2f86 <malloc+0xe3>
      else {
        p->s.size -= nunits;
    2f58:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2f5c:	8b 40 08             	mov    0x8(%rax),%eax
    2f5f:	2b 45 ec             	sub    -0x14(%rbp),%eax
    2f62:	89 c2                	mov    %eax,%edx
    2f64:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2f68:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    2f6b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2f6f:	8b 40 08             	mov    0x8(%rax),%eax
    2f72:	89 c0                	mov    %eax,%eax
    2f74:	48 c1 e0 04          	shl    $0x4,%rax
    2f78:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    2f7c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2f80:	8b 55 ec             	mov    -0x14(%rbp),%edx
    2f83:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    2f86:	48 ba a0 32 00 00 00 	movabs $0x32a0,%rdx
    2f8d:	00 00 00 
    2f90:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2f94:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    2f97:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2f9b:	48 83 c0 10          	add    $0x10,%rax
    2f9f:	eb 4e                	jmp    2fef <malloc+0x14c>
    }
    if(p == freep)
    2fa1:	48 b8 a0 32 00 00 00 	movabs $0x32a0,%rax
    2fa8:	00 00 00 
    2fab:	48 8b 00             	mov    (%rax),%rax
    2fae:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    2fb2:	75 23                	jne    2fd7 <malloc+0x134>
      if((p = morecore(nunits)) == 0)
    2fb4:	8b 45 ec             	mov    -0x14(%rbp),%eax
    2fb7:	89 c7                	mov    %eax,%edi
    2fb9:	48 b8 24 2e 00 00 00 	movabs $0x2e24,%rax
    2fc0:	00 00 00 
    2fc3:	ff d0                	call   *%rax
    2fc5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    2fc9:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    2fce:	75 07                	jne    2fd7 <malloc+0x134>
        return 0;
    2fd0:	b8 00 00 00 00       	mov    $0x0,%eax
    2fd5:	eb 18                	jmp    2fef <malloc+0x14c>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    2fd7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2fdb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    2fdf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2fe3:	48 8b 00             	mov    (%rax),%rax
    2fe6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    2fea:	e9 41 ff ff ff       	jmp    2f30 <malloc+0x8d>
  }
}
    2fef:	c9                   	leave
    2ff0:	c3                   	ret
