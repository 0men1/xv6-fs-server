
_usertests:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <failexit>:
char name[3];
char *echoargv[] = { "echo", "ALL", "TESTS", "PASSED", 0 };

void
failexit(const char * const msg)
{
    1000:	f3 0f 1e fa          	endbr64
    1004:	55                   	push   %rbp
    1005:	48 89 e5             	mov    %rsp,%rbp
    1008:	48 83 ec 10          	sub    $0x10,%rsp
    100c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  printf(1, "!! FAILED %s\n", msg);
    1010:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1014:	48 89 c2             	mov    %rax,%rdx
    1017:	48 b8 7e 72 00 00 00 	movabs $0x727e,%rax
    101e:	00 00 00 
    1021:	48 89 c6             	mov    %rax,%rsi
    1024:	bf 01 00 00 00       	mov    $0x1,%edi
    1029:	b8 00 00 00 00       	mov    $0x0,%eax
    102e:	48 b9 55 6b 00 00 00 	movabs $0x6b55,%rcx
    1035:	00 00 00 
    1038:	ff d1                	call   *%rcx
  exit();
    103a:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    1041:	00 00 00 
    1044:	ff d0                	call   *%rax

0000000000001046 <iputtest>:
}

// does chdir() call iput(p->cwd) in a transaction?
void
iputtest(void)
{
    1046:	f3 0f 1e fa          	endbr64
    104a:	55                   	push   %rbp
    104b:	48 89 e5             	mov    %rsp,%rbp
  printf(1, "iput test\n");
    104e:	48 b8 8c 72 00 00 00 	movabs $0x728c,%rax
    1055:	00 00 00 
    1058:	48 89 c6             	mov    %rax,%rsi
    105b:	bf 01 00 00 00       	mov    $0x1,%edi
    1060:	b8 00 00 00 00       	mov    $0x0,%eax
    1065:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    106c:	00 00 00 
    106f:	ff d2                	call   *%rdx

  if(mkdir("iputdir") < 0){
    1071:	48 b8 97 72 00 00 00 	movabs $0x7297,%rax
    1078:	00 00 00 
    107b:	48 89 c7             	mov    %rax,%rdi
    107e:	48 b8 ed 68 00 00 00 	movabs $0x68ed,%rax
    1085:	00 00 00 
    1088:	ff d0                	call   *%rax
    108a:	85 c0                	test   %eax,%eax
    108c:	79 19                	jns    10a7 <iputtest+0x61>
    failexit("mkdir");
    108e:	48 b8 9f 72 00 00 00 	movabs $0x729f,%rax
    1095:	00 00 00 
    1098:	48 89 c7             	mov    %rax,%rdi
    109b:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    10a2:	00 00 00 
    10a5:	ff d0                	call   *%rax
  }
  if(chdir("iputdir") < 0){
    10a7:	48 b8 97 72 00 00 00 	movabs $0x7297,%rax
    10ae:	00 00 00 
    10b1:	48 89 c7             	mov    %rax,%rdi
    10b4:	48 b8 fa 68 00 00 00 	movabs $0x68fa,%rax
    10bb:	00 00 00 
    10be:	ff d0                	call   *%rax
    10c0:	85 c0                	test   %eax,%eax
    10c2:	79 19                	jns    10dd <iputtest+0x97>
    failexit("chdir iputdir");
    10c4:	48 b8 a5 72 00 00 00 	movabs $0x72a5,%rax
    10cb:	00 00 00 
    10ce:	48 89 c7             	mov    %rax,%rdi
    10d1:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    10d8:	00 00 00 
    10db:	ff d0                	call   *%rax
  }
  if(unlink("../iputdir") < 0){
    10dd:	48 b8 b3 72 00 00 00 	movabs $0x72b3,%rax
    10e4:	00 00 00 
    10e7:	48 89 c7             	mov    %rax,%rdi
    10ea:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    10f1:	00 00 00 
    10f4:	ff d0                	call   *%rax
    10f6:	85 c0                	test   %eax,%eax
    10f8:	79 19                	jns    1113 <iputtest+0xcd>
    failexit("unlink ../iputdir");
    10fa:	48 b8 be 72 00 00 00 	movabs $0x72be,%rax
    1101:	00 00 00 
    1104:	48 89 c7             	mov    %rax,%rdi
    1107:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    110e:	00 00 00 
    1111:	ff d0                	call   *%rax
  }
  if(chdir("/") < 0){
    1113:	48 b8 d0 72 00 00 00 	movabs $0x72d0,%rax
    111a:	00 00 00 
    111d:	48 89 c7             	mov    %rax,%rdi
    1120:	48 b8 fa 68 00 00 00 	movabs $0x68fa,%rax
    1127:	00 00 00 
    112a:	ff d0                	call   *%rax
    112c:	85 c0                	test   %eax,%eax
    112e:	79 19                	jns    1149 <iputtest+0x103>
    failexit("chdir /");
    1130:	48 b8 d2 72 00 00 00 	movabs $0x72d2,%rax
    1137:	00 00 00 
    113a:	48 89 c7             	mov    %rax,%rdi
    113d:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1144:	00 00 00 
    1147:	ff d0                	call   *%rax
  }
  printf(1, "iput test ok\n");
    1149:	48 b8 da 72 00 00 00 	movabs $0x72da,%rax
    1150:	00 00 00 
    1153:	48 89 c6             	mov    %rax,%rsi
    1156:	bf 01 00 00 00       	mov    $0x1,%edi
    115b:	b8 00 00 00 00       	mov    $0x0,%eax
    1160:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    1167:	00 00 00 
    116a:	ff d2                	call   *%rdx
}
    116c:	90                   	nop
    116d:	5d                   	pop    %rbp
    116e:	c3                   	ret

000000000000116f <exitiputtest>:

// does exit() call iput(p->cwd) in a transaction?
void
exitiputtest(void)
{
    116f:	f3 0f 1e fa          	endbr64
    1173:	55                   	push   %rbp
    1174:	48 89 e5             	mov    %rsp,%rbp
    1177:	48 83 ec 10          	sub    $0x10,%rsp
  int pid;

  printf(1, "exitiput test\n");
    117b:	48 b8 e8 72 00 00 00 	movabs $0x72e8,%rax
    1182:	00 00 00 
    1185:	48 89 c6             	mov    %rax,%rsi
    1188:	bf 01 00 00 00       	mov    $0x1,%edi
    118d:	b8 00 00 00 00       	mov    $0x0,%eax
    1192:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    1199:	00 00 00 
    119c:	ff d2                	call   *%rdx

  pid = fork();
    119e:	48 b8 37 68 00 00 00 	movabs $0x6837,%rax
    11a5:	00 00 00 
    11a8:	ff d0                	call   *%rax
    11aa:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(pid < 0){
    11ad:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    11b1:	79 19                	jns    11cc <exitiputtest+0x5d>
    failexit("fork");
    11b3:	48 b8 f7 72 00 00 00 	movabs $0x72f7,%rax
    11ba:	00 00 00 
    11bd:	48 89 c7             	mov    %rax,%rdi
    11c0:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    11c7:	00 00 00 
    11ca:	ff d0                	call   *%rax
  }
  if(pid == 0){
    11cc:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    11d0:	0f 85 ae 00 00 00    	jne    1284 <exitiputtest+0x115>
    if(mkdir("iputdir") < 0){
    11d6:	48 b8 97 72 00 00 00 	movabs $0x7297,%rax
    11dd:	00 00 00 
    11e0:	48 89 c7             	mov    %rax,%rdi
    11e3:	48 b8 ed 68 00 00 00 	movabs $0x68ed,%rax
    11ea:	00 00 00 
    11ed:	ff d0                	call   *%rax
    11ef:	85 c0                	test   %eax,%eax
    11f1:	79 19                	jns    120c <exitiputtest+0x9d>
      failexit("mkdir");
    11f3:	48 b8 9f 72 00 00 00 	movabs $0x729f,%rax
    11fa:	00 00 00 
    11fd:	48 89 c7             	mov    %rax,%rdi
    1200:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1207:	00 00 00 
    120a:	ff d0                	call   *%rax
    }
    if(chdir("iputdir") < 0){
    120c:	48 b8 97 72 00 00 00 	movabs $0x7297,%rax
    1213:	00 00 00 
    1216:	48 89 c7             	mov    %rax,%rdi
    1219:	48 b8 fa 68 00 00 00 	movabs $0x68fa,%rax
    1220:	00 00 00 
    1223:	ff d0                	call   *%rax
    1225:	85 c0                	test   %eax,%eax
    1227:	79 19                	jns    1242 <exitiputtest+0xd3>
      failexit("child chdir");
    1229:	48 b8 fc 72 00 00 00 	movabs $0x72fc,%rax
    1230:	00 00 00 
    1233:	48 89 c7             	mov    %rax,%rdi
    1236:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    123d:	00 00 00 
    1240:	ff d0                	call   *%rax
    }
    if(unlink("../iputdir") < 0){
    1242:	48 b8 b3 72 00 00 00 	movabs $0x72b3,%rax
    1249:	00 00 00 
    124c:	48 89 c7             	mov    %rax,%rdi
    124f:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    1256:	00 00 00 
    1259:	ff d0                	call   *%rax
    125b:	85 c0                	test   %eax,%eax
    125d:	79 19                	jns    1278 <exitiputtest+0x109>
      failexit("unlink ../iputdir");
    125f:	48 b8 be 72 00 00 00 	movabs $0x72be,%rax
    1266:	00 00 00 
    1269:	48 89 c7             	mov    %rax,%rdi
    126c:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1273:	00 00 00 
    1276:	ff d0                	call   *%rax
    }
    exit();
    1278:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    127f:	00 00 00 
    1282:	ff d0                	call   *%rax
  }
  wait();
    1284:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    128b:	00 00 00 
    128e:	ff d0                	call   *%rax
  printf(1, "exitiput test ok\n");
    1290:	48 b8 08 73 00 00 00 	movabs $0x7308,%rax
    1297:	00 00 00 
    129a:	48 89 c6             	mov    %rax,%rsi
    129d:	bf 01 00 00 00       	mov    $0x1,%edi
    12a2:	b8 00 00 00 00       	mov    $0x0,%eax
    12a7:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    12ae:	00 00 00 
    12b1:	ff d2                	call   *%rdx
}
    12b3:	90                   	nop
    12b4:	c9                   	leave
    12b5:	c3                   	ret

00000000000012b6 <openiputtest>:
//      for(i = 0; i < 10000; i++)
//        yield();
//    }
void
openiputtest(void)
{
    12b6:	f3 0f 1e fa          	endbr64
    12ba:	55                   	push   %rbp
    12bb:	48 89 e5             	mov    %rsp,%rbp
    12be:	48 83 ec 10          	sub    $0x10,%rsp
  int pid;

  printf(1, "openiput test\n");
    12c2:	48 b8 1a 73 00 00 00 	movabs $0x731a,%rax
    12c9:	00 00 00 
    12cc:	48 89 c6             	mov    %rax,%rsi
    12cf:	bf 01 00 00 00       	mov    $0x1,%edi
    12d4:	b8 00 00 00 00       	mov    $0x0,%eax
    12d9:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    12e0:	00 00 00 
    12e3:	ff d2                	call   *%rdx
  if(mkdir("oidir") < 0){
    12e5:	48 b8 29 73 00 00 00 	movabs $0x7329,%rax
    12ec:	00 00 00 
    12ef:	48 89 c7             	mov    %rax,%rdi
    12f2:	48 b8 ed 68 00 00 00 	movabs $0x68ed,%rax
    12f9:	00 00 00 
    12fc:	ff d0                	call   *%rax
    12fe:	85 c0                	test   %eax,%eax
    1300:	79 19                	jns    131b <openiputtest+0x65>
    failexit("mkdir oidir");
    1302:	48 b8 2f 73 00 00 00 	movabs $0x732f,%rax
    1309:	00 00 00 
    130c:	48 89 c7             	mov    %rax,%rdi
    130f:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1316:	00 00 00 
    1319:	ff d0                	call   *%rax
  }
  pid = fork();
    131b:	48 b8 37 68 00 00 00 	movabs $0x6837,%rax
    1322:	00 00 00 
    1325:	ff d0                	call   *%rax
    1327:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(pid < 0){
    132a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    132e:	79 19                	jns    1349 <openiputtest+0x93>
    failexit("fork");
    1330:	48 b8 f7 72 00 00 00 	movabs $0x72f7,%rax
    1337:	00 00 00 
    133a:	48 89 c7             	mov    %rax,%rdi
    133d:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1344:	00 00 00 
    1347:	ff d0                	call   *%rax
  }
  if(pid == 0){
    1349:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    134d:	75 4c                	jne    139b <openiputtest+0xe5>
    int fd = open("oidir", O_RDWR);
    134f:	be 02 00 00 00       	mov    $0x2,%esi
    1354:	48 b8 29 73 00 00 00 	movabs $0x7329,%rax
    135b:	00 00 00 
    135e:	48 89 c7             	mov    %rax,%rdi
    1361:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    1368:	00 00 00 
    136b:	ff d0                	call   *%rax
    136d:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(fd >= 0){
    1370:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1374:	78 19                	js     138f <openiputtest+0xd9>
      failexit("open directory for write succeeded");
    1376:	48 b8 40 73 00 00 00 	movabs $0x7340,%rax
    137d:	00 00 00 
    1380:	48 89 c7             	mov    %rax,%rdi
    1383:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    138a:	00 00 00 
    138d:	ff d0                	call   *%rax
    }
    exit();
    138f:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    1396:	00 00 00 
    1399:	ff d0                	call   *%rax
  }
  sleep(1);
    139b:	bf 01 00 00 00       	mov    $0x1,%edi
    13a0:	48 b8 2e 69 00 00 00 	movabs $0x692e,%rax
    13a7:	00 00 00 
    13aa:	ff d0                	call   *%rax
  if(unlink("oidir") != 0){
    13ac:	48 b8 29 73 00 00 00 	movabs $0x7329,%rax
    13b3:	00 00 00 
    13b6:	48 89 c7             	mov    %rax,%rdi
    13b9:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    13c0:	00 00 00 
    13c3:	ff d0                	call   *%rax
    13c5:	85 c0                	test   %eax,%eax
    13c7:	74 19                	je     13e2 <openiputtest+0x12c>
    failexit("unlink");
    13c9:	48 b8 63 73 00 00 00 	movabs $0x7363,%rax
    13d0:	00 00 00 
    13d3:	48 89 c7             	mov    %rax,%rdi
    13d6:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    13dd:	00 00 00 
    13e0:	ff d0                	call   *%rax
  }
  wait();
    13e2:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    13e9:	00 00 00 
    13ec:	ff d0                	call   *%rax
  printf(1, "openiput test ok\n");
    13ee:	48 b8 6a 73 00 00 00 	movabs $0x736a,%rax
    13f5:	00 00 00 
    13f8:	48 89 c6             	mov    %rax,%rsi
    13fb:	bf 01 00 00 00       	mov    $0x1,%edi
    1400:	b8 00 00 00 00       	mov    $0x0,%eax
    1405:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    140c:	00 00 00 
    140f:	ff d2                	call   *%rdx
}
    1411:	90                   	nop
    1412:	c9                   	leave
    1413:	c3                   	ret

0000000000001414 <opentest>:

// simple file system tests

void
opentest(void)
{
    1414:	f3 0f 1e fa          	endbr64
    1418:	55                   	push   %rbp
    1419:	48 89 e5             	mov    %rsp,%rbp
    141c:	48 83 ec 10          	sub    $0x10,%rsp
  int fd;

  printf(1, "open test\n");
    1420:	48 b8 7c 73 00 00 00 	movabs $0x737c,%rax
    1427:	00 00 00 
    142a:	48 89 c6             	mov    %rax,%rsi
    142d:	bf 01 00 00 00       	mov    $0x1,%edi
    1432:	b8 00 00 00 00       	mov    $0x0,%eax
    1437:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    143e:	00 00 00 
    1441:	ff d2                	call   *%rdx
  fd = open("echo", 0);
    1443:	be 00 00 00 00       	mov    $0x0,%esi
    1448:	48 b8 68 72 00 00 00 	movabs $0x7268,%rax
    144f:	00 00 00 
    1452:	48 89 c7             	mov    %rax,%rdi
    1455:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    145c:	00 00 00 
    145f:	ff d0                	call   *%rax
    1461:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    1464:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1468:	79 19                	jns    1483 <opentest+0x6f>
    failexit("open echo");
    146a:	48 b8 87 73 00 00 00 	movabs $0x7387,%rax
    1471:	00 00 00 
    1474:	48 89 c7             	mov    %rax,%rdi
    1477:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    147e:	00 00 00 
    1481:	ff d0                	call   *%rax
  }
  close(fd);
    1483:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1486:	89 c7                	mov    %eax,%edi
    1488:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    148f:	00 00 00 
    1492:	ff d0                	call   *%rax
  fd = open("doesnotexist", 0);
    1494:	be 00 00 00 00       	mov    $0x0,%esi
    1499:	48 b8 91 73 00 00 00 	movabs $0x7391,%rax
    14a0:	00 00 00 
    14a3:	48 89 c7             	mov    %rax,%rdi
    14a6:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    14ad:	00 00 00 
    14b0:	ff d0                	call   *%rax
    14b2:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd >= 0){
    14b5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    14b9:	78 19                	js     14d4 <opentest+0xc0>
    failexit("open doesnotexist succeeded!");
    14bb:	48 b8 9e 73 00 00 00 	movabs $0x739e,%rax
    14c2:	00 00 00 
    14c5:	48 89 c7             	mov    %rax,%rdi
    14c8:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    14cf:	00 00 00 
    14d2:	ff d0                	call   *%rax
  }
  printf(1, "open test ok\n");
    14d4:	48 b8 bb 73 00 00 00 	movabs $0x73bb,%rax
    14db:	00 00 00 
    14de:	48 89 c6             	mov    %rax,%rsi
    14e1:	bf 01 00 00 00       	mov    $0x1,%edi
    14e6:	b8 00 00 00 00       	mov    $0x0,%eax
    14eb:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    14f2:	00 00 00 
    14f5:	ff d2                	call   *%rdx
}
    14f7:	90                   	nop
    14f8:	c9                   	leave
    14f9:	c3                   	ret

00000000000014fa <writetest>:

void
writetest(void)
{
    14fa:	f3 0f 1e fa          	endbr64
    14fe:	55                   	push   %rbp
    14ff:	48 89 e5             	mov    %rsp,%rbp
    1502:	48 83 ec 10          	sub    $0x10,%rsp
  int fd;
  int i;

  printf(1, "small file test\n");
    1506:	48 b8 c9 73 00 00 00 	movabs $0x73c9,%rax
    150d:	00 00 00 
    1510:	48 89 c6             	mov    %rax,%rsi
    1513:	bf 01 00 00 00       	mov    $0x1,%edi
    1518:	b8 00 00 00 00       	mov    $0x0,%eax
    151d:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    1524:	00 00 00 
    1527:	ff d2                	call   *%rdx
  fd = open("small", O_CREATE|O_RDWR);
    1529:	be 02 02 00 00       	mov    $0x202,%esi
    152e:	48 b8 da 73 00 00 00 	movabs $0x73da,%rax
    1535:	00 00 00 
    1538:	48 89 c7             	mov    %rax,%rdi
    153b:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    1542:	00 00 00 
    1545:	ff d0                	call   *%rax
    1547:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(fd < 0){
    154a:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    154e:	79 19                	jns    1569 <writetest+0x6f>
    failexit("error: creat small");
    1550:	48 b8 e0 73 00 00 00 	movabs $0x73e0,%rax
    1557:	00 00 00 
    155a:	48 89 c7             	mov    %rax,%rdi
    155d:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1564:	00 00 00 
    1567:	ff d0                	call   *%rax
  }
  for(i = 0; i < 100; i++){
    1569:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1570:	e9 bc 00 00 00       	jmp    1631 <writetest+0x137>
    if(write(fd, "aaaaaaaaaa", 10) != 10){
    1575:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1578:	ba 0a 00 00 00       	mov    $0xa,%edx
    157d:	48 b9 f3 73 00 00 00 	movabs $0x73f3,%rcx
    1584:	00 00 00 
    1587:	48 89 ce             	mov    %rcx,%rsi
    158a:	89 c7                	mov    %eax,%edi
    158c:	48 b8 78 68 00 00 00 	movabs $0x6878,%rax
    1593:	00 00 00 
    1596:	ff d0                	call   *%rax
    1598:	83 f8 0a             	cmp    $0xa,%eax
    159b:	74 34                	je     15d1 <writetest+0xd7>
      printf(1, "error: write aa %d new file failed\n", i);
    159d:	8b 45 fc             	mov    -0x4(%rbp),%eax
    15a0:	89 c2                	mov    %eax,%edx
    15a2:	48 b8 00 74 00 00 00 	movabs $0x7400,%rax
    15a9:	00 00 00 
    15ac:	48 89 c6             	mov    %rax,%rsi
    15af:	bf 01 00 00 00       	mov    $0x1,%edi
    15b4:	b8 00 00 00 00       	mov    $0x0,%eax
    15b9:	48 b9 55 6b 00 00 00 	movabs $0x6b55,%rcx
    15c0:	00 00 00 
    15c3:	ff d1                	call   *%rcx
      exit();
    15c5:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    15cc:	00 00 00 
    15cf:	ff d0                	call   *%rax
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
    15d1:	8b 45 f8             	mov    -0x8(%rbp),%eax
    15d4:	ba 0a 00 00 00       	mov    $0xa,%edx
    15d9:	48 b9 24 74 00 00 00 	movabs $0x7424,%rcx
    15e0:	00 00 00 
    15e3:	48 89 ce             	mov    %rcx,%rsi
    15e6:	89 c7                	mov    %eax,%edi
    15e8:	48 b8 78 68 00 00 00 	movabs $0x6878,%rax
    15ef:	00 00 00 
    15f2:	ff d0                	call   *%rax
    15f4:	83 f8 0a             	cmp    $0xa,%eax
    15f7:	74 34                	je     162d <writetest+0x133>
      printf(1, "error: write bb %d new file failed\n", i);
    15f9:	8b 45 fc             	mov    -0x4(%rbp),%eax
    15fc:	89 c2                	mov    %eax,%edx
    15fe:	48 b8 30 74 00 00 00 	movabs $0x7430,%rax
    1605:	00 00 00 
    1608:	48 89 c6             	mov    %rax,%rsi
    160b:	bf 01 00 00 00       	mov    $0x1,%edi
    1610:	b8 00 00 00 00       	mov    $0x0,%eax
    1615:	48 b9 55 6b 00 00 00 	movabs $0x6b55,%rcx
    161c:	00 00 00 
    161f:	ff d1                	call   *%rcx
      exit();
    1621:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    1628:	00 00 00 
    162b:	ff d0                	call   *%rax
  for(i = 0; i < 100; i++){
    162d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1631:	83 7d fc 63          	cmpl   $0x63,-0x4(%rbp)
    1635:	0f 8e 3a ff ff ff    	jle    1575 <writetest+0x7b>
    }
  }
  close(fd);
    163b:	8b 45 f8             	mov    -0x8(%rbp),%eax
    163e:	89 c7                	mov    %eax,%edi
    1640:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    1647:	00 00 00 
    164a:	ff d0                	call   *%rax
  fd = open("small", O_RDONLY);
    164c:	be 00 00 00 00       	mov    $0x0,%esi
    1651:	48 b8 da 73 00 00 00 	movabs $0x73da,%rax
    1658:	00 00 00 
    165b:	48 89 c7             	mov    %rax,%rdi
    165e:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    1665:	00 00 00 
    1668:	ff d0                	call   *%rax
    166a:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(fd < 0){
    166d:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1671:	79 19                	jns    168c <writetest+0x192>
    failexit("error: open small");
    1673:	48 b8 54 74 00 00 00 	movabs $0x7454,%rax
    167a:	00 00 00 
    167d:	48 89 c7             	mov    %rax,%rdi
    1680:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1687:	00 00 00 
    168a:	ff d0                	call   *%rax
  }
  i = read(fd, buf, 2000);
    168c:	8b 45 f8             	mov    -0x8(%rbp),%eax
    168f:	ba d0 07 00 00       	mov    $0x7d0,%edx
    1694:	48 b9 00 8a 00 00 00 	movabs $0x8a00,%rcx
    169b:	00 00 00 
    169e:	48 89 ce             	mov    %rcx,%rsi
    16a1:	89 c7                	mov    %eax,%edi
    16a3:	48 b8 6b 68 00 00 00 	movabs $0x686b,%rax
    16aa:	00 00 00 
    16ad:	ff d0                	call   *%rax
    16af:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(i != 2000){
    16b2:	81 7d fc d0 07 00 00 	cmpl   $0x7d0,-0x4(%rbp)
    16b9:	74 19                	je     16d4 <writetest+0x1da>
    failexit("read");
    16bb:	48 b8 66 74 00 00 00 	movabs $0x7466,%rax
    16c2:	00 00 00 
    16c5:	48 89 c7             	mov    %rax,%rdi
    16c8:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    16cf:	00 00 00 
    16d2:	ff d0                	call   *%rax
  }
  close(fd);
    16d4:	8b 45 f8             	mov    -0x8(%rbp),%eax
    16d7:	89 c7                	mov    %eax,%edi
    16d9:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    16e0:	00 00 00 
    16e3:	ff d0                	call   *%rax

  if(unlink("small") < 0){
    16e5:	48 b8 da 73 00 00 00 	movabs $0x73da,%rax
    16ec:	00 00 00 
    16ef:	48 89 c7             	mov    %rax,%rdi
    16f2:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    16f9:	00 00 00 
    16fc:	ff d0                	call   *%rax
    16fe:	85 c0                	test   %eax,%eax
    1700:	79 25                	jns    1727 <writetest+0x22d>
    failexit("unlink small");
    1702:	48 b8 6b 74 00 00 00 	movabs $0x746b,%rax
    1709:	00 00 00 
    170c:	48 89 c7             	mov    %rax,%rdi
    170f:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1716:	00 00 00 
    1719:	ff d0                	call   *%rax
    exit();
    171b:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    1722:	00 00 00 
    1725:	ff d0                	call   *%rax
  }
  printf(1, "small file test ok\n");
    1727:	48 b8 78 74 00 00 00 	movabs $0x7478,%rax
    172e:	00 00 00 
    1731:	48 89 c6             	mov    %rax,%rsi
    1734:	bf 01 00 00 00       	mov    $0x1,%edi
    1739:	b8 00 00 00 00       	mov    $0x0,%eax
    173e:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    1745:	00 00 00 
    1748:	ff d2                	call   *%rdx
}
    174a:	90                   	nop
    174b:	c9                   	leave
    174c:	c3                   	ret

000000000000174d <writetest1>:

void
writetest1(void)
{
    174d:	f3 0f 1e fa          	endbr64
    1751:	55                   	push   %rbp
    1752:	48 89 e5             	mov    %rsp,%rbp
    1755:	48 83 ec 10          	sub    $0x10,%rsp
  int i, fd, n;

  printf(1, "big files test\n");
    1759:	48 b8 8c 74 00 00 00 	movabs $0x748c,%rax
    1760:	00 00 00 
    1763:	48 89 c6             	mov    %rax,%rsi
    1766:	bf 01 00 00 00       	mov    $0x1,%edi
    176b:	b8 00 00 00 00       	mov    $0x0,%eax
    1770:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    1777:	00 00 00 
    177a:	ff d2                	call   *%rdx

  fd = open("big", O_CREATE|O_RDWR);
    177c:	be 02 02 00 00       	mov    $0x202,%esi
    1781:	48 b8 9c 74 00 00 00 	movabs $0x749c,%rax
    1788:	00 00 00 
    178b:	48 89 c7             	mov    %rax,%rdi
    178e:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    1795:	00 00 00 
    1798:	ff d0                	call   *%rax
    179a:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(fd < 0){
    179d:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    17a1:	79 19                	jns    17bc <writetest1+0x6f>
    failexit("error: creat big");
    17a3:	48 b8 a0 74 00 00 00 	movabs $0x74a0,%rax
    17aa:	00 00 00 
    17ad:	48 89 c7             	mov    %rax,%rdi
    17b0:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    17b7:	00 00 00 
    17ba:	ff d0                	call   *%rax
  }

  for(i = 0; i < MAXFILE; i++){
    17bc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    17c3:	eb 56                	jmp    181b <writetest1+0xce>
    ((int*)buf)[0] = i;
    17c5:	48 ba 00 8a 00 00 00 	movabs $0x8a00,%rdx
    17cc:	00 00 00 
    17cf:	8b 45 fc             	mov    -0x4(%rbp),%eax
    17d2:	89 02                	mov    %eax,(%rdx)
    if(write(fd, buf, 512) != 512){
    17d4:	8b 45 f4             	mov    -0xc(%rbp),%eax
    17d7:	ba 00 02 00 00       	mov    $0x200,%edx
    17dc:	48 b9 00 8a 00 00 00 	movabs $0x8a00,%rcx
    17e3:	00 00 00 
    17e6:	48 89 ce             	mov    %rcx,%rsi
    17e9:	89 c7                	mov    %eax,%edi
    17eb:	48 b8 78 68 00 00 00 	movabs $0x6878,%rax
    17f2:	00 00 00 
    17f5:	ff d0                	call   *%rax
    17f7:	3d 00 02 00 00       	cmp    $0x200,%eax
    17fc:	74 19                	je     1817 <writetest1+0xca>
      failexit("error: write big file");
    17fe:	48 b8 b1 74 00 00 00 	movabs $0x74b1,%rax
    1805:	00 00 00 
    1808:	48 89 c7             	mov    %rax,%rdi
    180b:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1812:	00 00 00 
    1815:	ff d0                	call   *%rax
  for(i = 0; i < MAXFILE; i++){
    1817:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    181b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    181e:	3d 8b 00 00 00       	cmp    $0x8b,%eax
    1823:	76 a0                	jbe    17c5 <writetest1+0x78>
    }
  }

  close(fd);
    1825:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1828:	89 c7                	mov    %eax,%edi
    182a:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    1831:	00 00 00 
    1834:	ff d0                	call   *%rax

  fd = open("big", O_RDONLY);
    1836:	be 00 00 00 00       	mov    $0x0,%esi
    183b:	48 b8 9c 74 00 00 00 	movabs $0x749c,%rax
    1842:	00 00 00 
    1845:	48 89 c7             	mov    %rax,%rdi
    1848:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    184f:	00 00 00 
    1852:	ff d0                	call   *%rax
    1854:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(fd < 0){
    1857:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    185b:	79 19                	jns    1876 <writetest1+0x129>
    failexit("error: open big");
    185d:	48 b8 c7 74 00 00 00 	movabs $0x74c7,%rax
    1864:	00 00 00 
    1867:	48 89 c7             	mov    %rax,%rdi
    186a:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1871:	00 00 00 
    1874:	ff d0                	call   *%rax
  }

  n = 0;
    1876:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  for(;;){
    i = read(fd, buf, 512);
    187d:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1880:	ba 00 02 00 00       	mov    $0x200,%edx
    1885:	48 b9 00 8a 00 00 00 	movabs $0x8a00,%rcx
    188c:	00 00 00 
    188f:	48 89 ce             	mov    %rcx,%rsi
    1892:	89 c7                	mov    %eax,%edi
    1894:	48 b8 6b 68 00 00 00 	movabs $0x686b,%rax
    189b:	00 00 00 
    189e:	ff d0                	call   *%rax
    18a0:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(i == 0){
    18a3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    18a7:	75 41                	jne    18ea <writetest1+0x19d>
      if(n == MAXFILE - 1){
    18a9:	81 7d f8 8b 00 00 00 	cmpl   $0x8b,-0x8(%rbp)
    18b0:	0f 85 ce 00 00 00    	jne    1984 <writetest1+0x237>
        printf(1, "read only %d blocks from big. failed", n);
    18b6:	8b 45 f8             	mov    -0x8(%rbp),%eax
    18b9:	89 c2                	mov    %eax,%edx
    18bb:	48 b8 d8 74 00 00 00 	movabs $0x74d8,%rax
    18c2:	00 00 00 
    18c5:	48 89 c6             	mov    %rax,%rsi
    18c8:	bf 01 00 00 00       	mov    $0x1,%edi
    18cd:	b8 00 00 00 00       	mov    $0x0,%eax
    18d2:	48 b9 55 6b 00 00 00 	movabs $0x6b55,%rcx
    18d9:	00 00 00 
    18dc:	ff d1                	call   *%rcx
        exit();
    18de:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    18e5:	00 00 00 
    18e8:	ff d0                	call   *%rax
      }
      break;
    } else if(i != 512){
    18ea:	81 7d fc 00 02 00 00 	cmpl   $0x200,-0x4(%rbp)
    18f1:	74 34                	je     1927 <writetest1+0x1da>
      printf(1, "read failed %d\n", i);
    18f3:	8b 45 fc             	mov    -0x4(%rbp),%eax
    18f6:	89 c2                	mov    %eax,%edx
    18f8:	48 b8 fd 74 00 00 00 	movabs $0x74fd,%rax
    18ff:	00 00 00 
    1902:	48 89 c6             	mov    %rax,%rsi
    1905:	bf 01 00 00 00       	mov    $0x1,%edi
    190a:	b8 00 00 00 00       	mov    $0x0,%eax
    190f:	48 b9 55 6b 00 00 00 	movabs $0x6b55,%rcx
    1916:	00 00 00 
    1919:	ff d1                	call   *%rcx
      exit();
    191b:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    1922:	00 00 00 
    1925:	ff d0                	call   *%rax
    }
    if(((int*)buf)[0] != n){
    1927:	48 b8 00 8a 00 00 00 	movabs $0x8a00,%rax
    192e:	00 00 00 
    1931:	8b 00                	mov    (%rax),%eax
    1933:	39 45 f8             	cmp    %eax,-0x8(%rbp)
    1936:	74 43                	je     197b <writetest1+0x22e>
      printf(1, "read content of block %d is %d. failed\n",
             n, ((int*)buf)[0]);
    1938:	48 b8 00 8a 00 00 00 	movabs $0x8a00,%rax
    193f:	00 00 00 
      printf(1, "read content of block %d is %d. failed\n",
    1942:	8b 10                	mov    (%rax),%edx
    1944:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1947:	89 d1                	mov    %edx,%ecx
    1949:	89 c2                	mov    %eax,%edx
    194b:	48 b8 10 75 00 00 00 	movabs $0x7510,%rax
    1952:	00 00 00 
    1955:	48 89 c6             	mov    %rax,%rsi
    1958:	bf 01 00 00 00       	mov    $0x1,%edi
    195d:	b8 00 00 00 00       	mov    $0x0,%eax
    1962:	49 b8 55 6b 00 00 00 	movabs $0x6b55,%r8
    1969:	00 00 00 
    196c:	41 ff d0             	call   *%r8
      exit();
    196f:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    1976:	00 00 00 
    1979:	ff d0                	call   *%rax
    }
    n++;
    197b:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    i = read(fd, buf, 512);
    197f:	e9 f9 fe ff ff       	jmp    187d <writetest1+0x130>
      break;
    1984:	90                   	nop
  }
  close(fd);
    1985:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1988:	89 c7                	mov    %eax,%edi
    198a:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    1991:	00 00 00 
    1994:	ff d0                	call   *%rax
  if(unlink("big") < 0){
    1996:	48 b8 9c 74 00 00 00 	movabs $0x749c,%rax
    199d:	00 00 00 
    19a0:	48 89 c7             	mov    %rax,%rdi
    19a3:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    19aa:	00 00 00 
    19ad:	ff d0                	call   *%rax
    19af:	85 c0                	test   %eax,%eax
    19b1:	79 25                	jns    19d8 <writetest1+0x28b>
    failexit("unlink big");
    19b3:	48 b8 38 75 00 00 00 	movabs $0x7538,%rax
    19ba:	00 00 00 
    19bd:	48 89 c7             	mov    %rax,%rdi
    19c0:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    19c7:	00 00 00 
    19ca:	ff d0                	call   *%rax
    exit();
    19cc:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    19d3:	00 00 00 
    19d6:	ff d0                	call   *%rax
  }
  printf(1, "big files ok\n");
    19d8:	48 b8 43 75 00 00 00 	movabs $0x7543,%rax
    19df:	00 00 00 
    19e2:	48 89 c6             	mov    %rax,%rsi
    19e5:	bf 01 00 00 00       	mov    $0x1,%edi
    19ea:	b8 00 00 00 00       	mov    $0x0,%eax
    19ef:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    19f6:	00 00 00 
    19f9:	ff d2                	call   *%rdx
}
    19fb:	90                   	nop
    19fc:	c9                   	leave
    19fd:	c3                   	ret

00000000000019fe <createtest>:

void
createtest(void)
{
    19fe:	f3 0f 1e fa          	endbr64
    1a02:	55                   	push   %rbp
    1a03:	48 89 e5             	mov    %rsp,%rbp
    1a06:	48 83 ec 10          	sub    $0x10,%rsp
  int i, fd;

  printf(1, "many creates, followed by unlink test\n");
    1a0a:	48 b8 58 75 00 00 00 	movabs $0x7558,%rax
    1a11:	00 00 00 
    1a14:	48 89 c6             	mov    %rax,%rsi
    1a17:	bf 01 00 00 00       	mov    $0x1,%edi
    1a1c:	b8 00 00 00 00       	mov    $0x0,%eax
    1a21:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    1a28:	00 00 00 
    1a2b:	ff d2                	call   *%rdx

  name[0] = 'a';
    1a2d:	48 b8 00 aa 00 00 00 	movabs $0xaa00,%rax
    1a34:	00 00 00 
    1a37:	c6 00 61             	movb   $0x61,(%rax)
  name[2] = '\0';
    1a3a:	48 b8 00 aa 00 00 00 	movabs $0xaa00,%rax
    1a41:	00 00 00 
    1a44:	c6 40 02 00          	movb   $0x0,0x2(%rax)
  for(i = 0; i < 52; i++){
    1a48:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1a4f:	eb 4b                	jmp    1a9c <createtest+0x9e>
    name[1] = '0' + i;
    1a51:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1a54:	83 c0 30             	add    $0x30,%eax
    1a57:	89 c2                	mov    %eax,%edx
    1a59:	48 b8 00 aa 00 00 00 	movabs $0xaa00,%rax
    1a60:	00 00 00 
    1a63:	88 50 01             	mov    %dl,0x1(%rax)
    fd = open(name, O_CREATE|O_RDWR);
    1a66:	be 02 02 00 00       	mov    $0x202,%esi
    1a6b:	48 b8 00 aa 00 00 00 	movabs $0xaa00,%rax
    1a72:	00 00 00 
    1a75:	48 89 c7             	mov    %rax,%rdi
    1a78:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    1a7f:	00 00 00 
    1a82:	ff d0                	call   *%rax
    1a84:	89 45 f8             	mov    %eax,-0x8(%rbp)
    close(fd);
    1a87:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1a8a:	89 c7                	mov    %eax,%edi
    1a8c:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    1a93:	00 00 00 
    1a96:	ff d0                	call   *%rax
  for(i = 0; i < 52; i++){
    1a98:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1a9c:	83 7d fc 33          	cmpl   $0x33,-0x4(%rbp)
    1aa0:	7e af                	jle    1a51 <createtest+0x53>
  }
  for(i = 0; i < 52; i++){
    1aa2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1aa9:	eb 32                	jmp    1add <createtest+0xdf>
    name[1] = '0' + i;
    1aab:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1aae:	83 c0 30             	add    $0x30,%eax
    1ab1:	89 c2                	mov    %eax,%edx
    1ab3:	48 b8 00 aa 00 00 00 	movabs $0xaa00,%rax
    1aba:	00 00 00 
    1abd:	88 50 01             	mov    %dl,0x1(%rax)
    unlink(name);
    1ac0:	48 b8 00 aa 00 00 00 	movabs $0xaa00,%rax
    1ac7:	00 00 00 
    1aca:	48 89 c7             	mov    %rax,%rdi
    1acd:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    1ad4:	00 00 00 
    1ad7:	ff d0                	call   *%rax
  for(i = 0; i < 52; i++){
    1ad9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1add:	83 7d fc 33          	cmpl   $0x33,-0x4(%rbp)
    1ae1:	7e c8                	jle    1aab <createtest+0xad>
  }
  for(i = 0; i < 52; i++){
    1ae3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1aea:	eb 59                	jmp    1b45 <createtest+0x147>
    name[1] = '0' + i;
    1aec:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1aef:	83 c0 30             	add    $0x30,%eax
    1af2:	89 c2                	mov    %eax,%edx
    1af4:	48 b8 00 aa 00 00 00 	movabs $0xaa00,%rax
    1afb:	00 00 00 
    1afe:	88 50 01             	mov    %dl,0x1(%rax)
    fd = open(name, O_RDWR);
    1b01:	be 02 00 00 00       	mov    $0x2,%esi
    1b06:	48 b8 00 aa 00 00 00 	movabs $0xaa00,%rax
    1b0d:	00 00 00 
    1b10:	48 89 c7             	mov    %rax,%rdi
    1b13:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    1b1a:	00 00 00 
    1b1d:	ff d0                	call   *%rax
    1b1f:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(fd >= 0) {
    1b22:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1b26:	78 19                	js     1b41 <createtest+0x143>
      failexit("open should fail.");
    1b28:	48 b8 7f 75 00 00 00 	movabs $0x757f,%rax
    1b2f:	00 00 00 
    1b32:	48 89 c7             	mov    %rax,%rdi
    1b35:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1b3c:	00 00 00 
    1b3f:	ff d0                	call   *%rax
  for(i = 0; i < 52; i++){
    1b41:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1b45:	83 7d fc 33          	cmpl   $0x33,-0x4(%rbp)
    1b49:	7e a1                	jle    1aec <createtest+0xee>
    }
  }

  printf(1, "many creates, followed by unlink; ok\n");
    1b4b:	48 b8 98 75 00 00 00 	movabs $0x7598,%rax
    1b52:	00 00 00 
    1b55:	48 89 c6             	mov    %rax,%rsi
    1b58:	bf 01 00 00 00       	mov    $0x1,%edi
    1b5d:	b8 00 00 00 00       	mov    $0x0,%eax
    1b62:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    1b69:	00 00 00 
    1b6c:	ff d2                	call   *%rdx
}
    1b6e:	90                   	nop
    1b6f:	c9                   	leave
    1b70:	c3                   	ret

0000000000001b71 <dirtest>:

void dirtest(void)
{
    1b71:	f3 0f 1e fa          	endbr64
    1b75:	55                   	push   %rbp
    1b76:	48 89 e5             	mov    %rsp,%rbp
  printf(1, "mkdir test\n");
    1b79:	48 b8 be 75 00 00 00 	movabs $0x75be,%rax
    1b80:	00 00 00 
    1b83:	48 89 c6             	mov    %rax,%rsi
    1b86:	bf 01 00 00 00       	mov    $0x1,%edi
    1b8b:	b8 00 00 00 00       	mov    $0x0,%eax
    1b90:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    1b97:	00 00 00 
    1b9a:	ff d2                	call   *%rdx

  if(mkdir("dir0") < 0){
    1b9c:	48 b8 ca 75 00 00 00 	movabs $0x75ca,%rax
    1ba3:	00 00 00 
    1ba6:	48 89 c7             	mov    %rax,%rdi
    1ba9:	48 b8 ed 68 00 00 00 	movabs $0x68ed,%rax
    1bb0:	00 00 00 
    1bb3:	ff d0                	call   *%rax
    1bb5:	85 c0                	test   %eax,%eax
    1bb7:	79 19                	jns    1bd2 <dirtest+0x61>
    failexit("mkdir");
    1bb9:	48 b8 9f 72 00 00 00 	movabs $0x729f,%rax
    1bc0:	00 00 00 
    1bc3:	48 89 c7             	mov    %rax,%rdi
    1bc6:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1bcd:	00 00 00 
    1bd0:	ff d0                	call   *%rax
  }

  if(chdir("dir0") < 0){
    1bd2:	48 b8 ca 75 00 00 00 	movabs $0x75ca,%rax
    1bd9:	00 00 00 
    1bdc:	48 89 c7             	mov    %rax,%rdi
    1bdf:	48 b8 fa 68 00 00 00 	movabs $0x68fa,%rax
    1be6:	00 00 00 
    1be9:	ff d0                	call   *%rax
    1beb:	85 c0                	test   %eax,%eax
    1bed:	79 19                	jns    1c08 <dirtest+0x97>
    failexit("chdir dir0");
    1bef:	48 b8 cf 75 00 00 00 	movabs $0x75cf,%rax
    1bf6:	00 00 00 
    1bf9:	48 89 c7             	mov    %rax,%rdi
    1bfc:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1c03:	00 00 00 
    1c06:	ff d0                	call   *%rax
  }

  if(chdir("..") < 0){
    1c08:	48 b8 da 75 00 00 00 	movabs $0x75da,%rax
    1c0f:	00 00 00 
    1c12:	48 89 c7             	mov    %rax,%rdi
    1c15:	48 b8 fa 68 00 00 00 	movabs $0x68fa,%rax
    1c1c:	00 00 00 
    1c1f:	ff d0                	call   *%rax
    1c21:	85 c0                	test   %eax,%eax
    1c23:	79 19                	jns    1c3e <dirtest+0xcd>
    failexit("chdir ..");
    1c25:	48 b8 dd 75 00 00 00 	movabs $0x75dd,%rax
    1c2c:	00 00 00 
    1c2f:	48 89 c7             	mov    %rax,%rdi
    1c32:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1c39:	00 00 00 
    1c3c:	ff d0                	call   *%rax
  }

  if(unlink("dir0") < 0){
    1c3e:	48 b8 ca 75 00 00 00 	movabs $0x75ca,%rax
    1c45:	00 00 00 
    1c48:	48 89 c7             	mov    %rax,%rdi
    1c4b:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    1c52:	00 00 00 
    1c55:	ff d0                	call   *%rax
    1c57:	85 c0                	test   %eax,%eax
    1c59:	79 19                	jns    1c74 <dirtest+0x103>
    failexit("unlink dir0");
    1c5b:	48 b8 e6 75 00 00 00 	movabs $0x75e6,%rax
    1c62:	00 00 00 
    1c65:	48 89 c7             	mov    %rax,%rdi
    1c68:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1c6f:	00 00 00 
    1c72:	ff d0                	call   *%rax
  }
  printf(1, "mkdir test ok\n");
    1c74:	48 b8 f2 75 00 00 00 	movabs $0x75f2,%rax
    1c7b:	00 00 00 
    1c7e:	48 89 c6             	mov    %rax,%rsi
    1c81:	bf 01 00 00 00       	mov    $0x1,%edi
    1c86:	b8 00 00 00 00       	mov    $0x0,%eax
    1c8b:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    1c92:	00 00 00 
    1c95:	ff d2                	call   *%rdx
}
    1c97:	90                   	nop
    1c98:	5d                   	pop    %rbp
    1c99:	c3                   	ret

0000000000001c9a <exectest>:

void
exectest(void)
{
    1c9a:	f3 0f 1e fa          	endbr64
    1c9e:	55                   	push   %rbp
    1c9f:	48 89 e5             	mov    %rsp,%rbp
  printf(1, "exec test\n");
    1ca2:	48 b8 01 76 00 00 00 	movabs $0x7601,%rax
    1ca9:	00 00 00 
    1cac:	48 89 c6             	mov    %rax,%rsi
    1caf:	bf 01 00 00 00       	mov    $0x1,%edi
    1cb4:	b8 00 00 00 00       	mov    $0x0,%eax
    1cb9:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    1cc0:	00 00 00 
    1cc3:	ff d2                	call   *%rdx
  if(exec("echo", echoargv) < 0){
    1cc5:	48 b8 a0 89 00 00 00 	movabs $0x89a0,%rax
    1ccc:	00 00 00 
    1ccf:	48 89 c6             	mov    %rax,%rsi
    1cd2:	48 b8 68 72 00 00 00 	movabs $0x7268,%rax
    1cd9:	00 00 00 
    1cdc:	48 89 c7             	mov    %rax,%rdi
    1cdf:	48 b8 9f 68 00 00 00 	movabs $0x689f,%rax
    1ce6:	00 00 00 
    1ce9:	ff d0                	call   *%rax
    1ceb:	85 c0                	test   %eax,%eax
    1ced:	79 19                	jns    1d08 <exectest+0x6e>
    failexit("exec echo");
    1cef:	48 b8 0c 76 00 00 00 	movabs $0x760c,%rax
    1cf6:	00 00 00 
    1cf9:	48 89 c7             	mov    %rax,%rdi
    1cfc:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1d03:	00 00 00 
    1d06:	ff d0                	call   *%rax
  }
  printf(1, "exec test ok\n");
    1d08:	48 b8 16 76 00 00 00 	movabs $0x7616,%rax
    1d0f:	00 00 00 
    1d12:	48 89 c6             	mov    %rax,%rsi
    1d15:	bf 01 00 00 00       	mov    $0x1,%edi
    1d1a:	b8 00 00 00 00       	mov    $0x0,%eax
    1d1f:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    1d26:	00 00 00 
    1d29:	ff d2                	call   *%rdx
}
    1d2b:	90                   	nop
    1d2c:	5d                   	pop    %rbp
    1d2d:	c3                   	ret

0000000000001d2e <nullptrtest>:

void
nullptrtest(void)
{
    1d2e:	f3 0f 1e fa          	endbr64
    1d32:	55                   	push   %rbp
    1d33:	48 89 e5             	mov    %rsp,%rbp
    1d36:	48 83 ec 10          	sub    $0x10,%rsp
  printf(1, "null pointer test\n");
    1d3a:	48 b8 24 76 00 00 00 	movabs $0x7624,%rax
    1d41:	00 00 00 
    1d44:	48 89 c6             	mov    %rax,%rsi
    1d47:	bf 01 00 00 00       	mov    $0x1,%edi
    1d4c:	b8 00 00 00 00       	mov    $0x0,%eax
    1d51:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    1d58:	00 00 00 
    1d5b:	ff d2                	call   *%rdx
  printf(1, "expect one killed process\n");
    1d5d:	48 b8 37 76 00 00 00 	movabs $0x7637,%rax
    1d64:	00 00 00 
    1d67:	48 89 c6             	mov    %rax,%rsi
    1d6a:	bf 01 00 00 00       	mov    $0x1,%edi
    1d6f:	b8 00 00 00 00       	mov    $0x0,%eax
    1d74:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    1d7b:	00 00 00 
    1d7e:	ff d2                	call   *%rdx
  int ppid = getpid();
    1d80:	48 b8 14 69 00 00 00 	movabs $0x6914,%rax
    1d87:	00 00 00 
    1d8a:	ff d0                	call   *%rax
    1d8c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if (fork() == 0) {
    1d8f:	48 b8 37 68 00 00 00 	movabs $0x6837,%rax
    1d96:	00 00 00 
    1d99:	ff d0                	call   *%rax
    1d9b:	85 c0                	test   %eax,%eax
    1d9d:	75 4c                	jne    1deb <nullptrtest+0xbd>
    *(addr_t *)(0) = 10;
    1d9f:	b8 00 00 00 00       	mov    $0x0,%eax
    1da4:	48 c7 00 0a 00 00 00 	movq   $0xa,(%rax)
    printf(1, "can write to unmapped page 0, failed");
    1dab:	48 b8 58 76 00 00 00 	movabs $0x7658,%rax
    1db2:	00 00 00 
    1db5:	48 89 c6             	mov    %rax,%rsi
    1db8:	bf 01 00 00 00       	mov    $0x1,%edi
    1dbd:	b8 00 00 00 00       	mov    $0x0,%eax
    1dc2:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    1dc9:	00 00 00 
    1dcc:	ff d2                	call   *%rdx
    kill(ppid);
    1dce:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1dd1:	89 c7                	mov    %eax,%edi
    1dd3:	48 b8 92 68 00 00 00 	movabs $0x6892,%rax
    1dda:	00 00 00 
    1ddd:	ff d0                	call   *%rax
    exit();
    1ddf:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    1de6:	00 00 00 
    1de9:	ff d0                	call   *%rax
  } else {
    wait();
    1deb:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    1df2:	00 00 00 
    1df5:	ff d0                	call   *%rax
  }
  printf(1, "null pointer test ok\n");
    1df7:	48 b8 7d 76 00 00 00 	movabs $0x767d,%rax
    1dfe:	00 00 00 
    1e01:	48 89 c6             	mov    %rax,%rsi
    1e04:	bf 01 00 00 00       	mov    $0x1,%edi
    1e09:	b8 00 00 00 00       	mov    $0x0,%eax
    1e0e:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    1e15:	00 00 00 
    1e18:	ff d2                	call   *%rdx
}
    1e1a:	90                   	nop
    1e1b:	c9                   	leave
    1e1c:	c3                   	ret

0000000000001e1d <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
    1e1d:	f3 0f 1e fa          	endbr64
    1e21:	55                   	push   %rbp
    1e22:	48 89 e5             	mov    %rsp,%rbp
    1e25:	48 83 ec 20          	sub    $0x20,%rsp
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
    1e29:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
    1e2d:	48 89 c7             	mov    %rax,%rdi
    1e30:	48 b8 5e 68 00 00 00 	movabs $0x685e,%rax
    1e37:	00 00 00 
    1e3a:	ff d0                	call   *%rax
    1e3c:	85 c0                	test   %eax,%eax
    1e3e:	74 19                	je     1e59 <pipe1+0x3c>
    failexit("pipe()");
    1e40:	48 b8 93 76 00 00 00 	movabs $0x7693,%rax
    1e47:	00 00 00 
    1e4a:	48 89 c7             	mov    %rax,%rdi
    1e4d:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1e54:	00 00 00 
    1e57:	ff d0                	call   *%rax
  }
  pid = fork();
    1e59:	48 b8 37 68 00 00 00 	movabs $0x6837,%rax
    1e60:	00 00 00 
    1e63:	ff d0                	call   *%rax
    1e65:	89 45 e8             	mov    %eax,-0x18(%rbp)
  seq = 0;
    1e68:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  if(pid == 0){
    1e6f:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
    1e73:	0f 85 a6 00 00 00    	jne    1f1f <pipe1+0x102>
    close(fds[0]);
    1e79:	8b 45 e0             	mov    -0x20(%rbp),%eax
    1e7c:	89 c7                	mov    %eax,%edi
    1e7e:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    1e85:	00 00 00 
    1e88:	ff d0                	call   *%rax
    for(n = 0; n < 5; n++){
    1e8a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    1e91:	eb 7a                	jmp    1f0d <pipe1+0xf0>
      for(i = 0; i < 1033; i++)
    1e93:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
    1e9a:	eb 21                	jmp    1ebd <pipe1+0xa0>
        buf[i] = seq++;
    1e9c:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1e9f:	8d 50 01             	lea    0x1(%rax),%edx
    1ea2:	89 55 fc             	mov    %edx,-0x4(%rbp)
    1ea5:	89 c1                	mov    %eax,%ecx
    1ea7:	48 ba 00 8a 00 00 00 	movabs $0x8a00,%rdx
    1eae:	00 00 00 
    1eb1:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1eb4:	48 98                	cltq
    1eb6:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
      for(i = 0; i < 1033; i++)
    1eb9:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    1ebd:	81 7d f8 08 04 00 00 	cmpl   $0x408,-0x8(%rbp)
    1ec4:	7e d6                	jle    1e9c <pipe1+0x7f>
      if(write(fds[1], buf, 1033) != 1033){
    1ec6:	8b 45 e4             	mov    -0x1c(%rbp),%eax
    1ec9:	ba 09 04 00 00       	mov    $0x409,%edx
    1ece:	48 b9 00 8a 00 00 00 	movabs $0x8a00,%rcx
    1ed5:	00 00 00 
    1ed8:	48 89 ce             	mov    %rcx,%rsi
    1edb:	89 c7                	mov    %eax,%edi
    1edd:	48 b8 78 68 00 00 00 	movabs $0x6878,%rax
    1ee4:	00 00 00 
    1ee7:	ff d0                	call   *%rax
    1ee9:	3d 09 04 00 00       	cmp    $0x409,%eax
    1eee:	74 19                	je     1f09 <pipe1+0xec>
        failexit("pipe1 oops 1");
    1ef0:	48 b8 9a 76 00 00 00 	movabs $0x769a,%rax
    1ef7:	00 00 00 
    1efa:	48 89 c7             	mov    %rax,%rdi
    1efd:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1f04:	00 00 00 
    1f07:	ff d0                	call   *%rax
    for(n = 0; n < 5; n++){
    1f09:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
    1f0d:	83 7d f4 04          	cmpl   $0x4,-0xc(%rbp)
    1f11:	7e 80                	jle    1e93 <pipe1+0x76>
      }
    }
    exit();
    1f13:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    1f1a:	00 00 00 
    1f1d:	ff d0                	call   *%rax
  } else if(pid > 0){
    1f1f:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
    1f23:	0f 8e 20 01 00 00    	jle    2049 <pipe1+0x22c>
    close(fds[1]);
    1f29:	8b 45 e4             	mov    -0x1c(%rbp),%eax
    1f2c:	89 c7                	mov    %eax,%edi
    1f2e:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    1f35:	00 00 00 
    1f38:	ff d0                	call   *%rax
    total = 0;
    1f3a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    cc = 1;
    1f41:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%rbp)
    while((n = read(fds[0], buf, cc)) > 0){
    1f48:	eb 75                	jmp    1fbf <pipe1+0x1a2>
      for(i = 0; i < n; i++){
    1f4a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
    1f51:	eb 4a                	jmp    1f9d <pipe1+0x180>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    1f53:	48 ba 00 8a 00 00 00 	movabs $0x8a00,%rdx
    1f5a:	00 00 00 
    1f5d:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1f60:	48 98                	cltq
    1f62:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1f66:	0f be c8             	movsbl %al,%ecx
    1f69:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1f6c:	8d 50 01             	lea    0x1(%rax),%edx
    1f6f:	89 55 fc             	mov    %edx,-0x4(%rbp)
    1f72:	31 c8                	xor    %ecx,%eax
    1f74:	0f b6 c0             	movzbl %al,%eax
    1f77:	85 c0                	test   %eax,%eax
    1f79:	74 1e                	je     1f99 <pipe1+0x17c>
          failexit("pipe1 oops 2");
    1f7b:	48 b8 a7 76 00 00 00 	movabs $0x76a7,%rax
    1f82:	00 00 00 
    1f85:	48 89 c7             	mov    %rax,%rdi
    1f88:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1f8f:	00 00 00 
    1f92:	ff d0                	call   *%rax
    1f94:	e9 ec 00 00 00       	jmp    2085 <pipe1+0x268>
      for(i = 0; i < n; i++){
    1f99:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    1f9d:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1fa0:	3b 45 f4             	cmp    -0xc(%rbp),%eax
    1fa3:	7c ae                	jl     1f53 <pipe1+0x136>
          return;
        }
      }
      total += n;
    1fa5:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1fa8:	01 45 ec             	add    %eax,-0x14(%rbp)
      cc = cc * 2;
    1fab:	d1 65 f0             	shll   $1,-0x10(%rbp)
      if(cc > sizeof(buf))
    1fae:	8b 45 f0             	mov    -0x10(%rbp),%eax
    1fb1:	3d 00 20 00 00       	cmp    $0x2000,%eax
    1fb6:	76 07                	jbe    1fbf <pipe1+0x1a2>
        cc = sizeof(buf);
    1fb8:	c7 45 f0 00 20 00 00 	movl   $0x2000,-0x10(%rbp)
    while((n = read(fds[0], buf, cc)) > 0){
    1fbf:	8b 45 e0             	mov    -0x20(%rbp),%eax
    1fc2:	8b 55 f0             	mov    -0x10(%rbp),%edx
    1fc5:	48 b9 00 8a 00 00 00 	movabs $0x8a00,%rcx
    1fcc:	00 00 00 
    1fcf:	48 89 ce             	mov    %rcx,%rsi
    1fd2:	89 c7                	mov    %eax,%edi
    1fd4:	48 b8 6b 68 00 00 00 	movabs $0x686b,%rax
    1fdb:	00 00 00 
    1fde:	ff d0                	call   *%rax
    1fe0:	89 45 f4             	mov    %eax,-0xc(%rbp)
    1fe3:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1fe7:	0f 8f 5d ff ff ff    	jg     1f4a <pipe1+0x12d>
    }
    if(total != 5 * 1033){
    1fed:	81 7d ec 2d 14 00 00 	cmpl   $0x142d,-0x14(%rbp)
    1ff4:	74 34                	je     202a <pipe1+0x20d>
      printf(1, "pipe1 oops 3 total %d\n", total);
    1ff6:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1ff9:	89 c2                	mov    %eax,%edx
    1ffb:	48 b8 b4 76 00 00 00 	movabs $0x76b4,%rax
    2002:	00 00 00 
    2005:	48 89 c6             	mov    %rax,%rsi
    2008:	bf 01 00 00 00       	mov    $0x1,%edi
    200d:	b8 00 00 00 00       	mov    $0x0,%eax
    2012:	48 b9 55 6b 00 00 00 	movabs $0x6b55,%rcx
    2019:	00 00 00 
    201c:	ff d1                	call   *%rcx
      exit();
    201e:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    2025:	00 00 00 
    2028:	ff d0                	call   *%rax
    }
    close(fds[0]);
    202a:	8b 45 e0             	mov    -0x20(%rbp),%eax
    202d:	89 c7                	mov    %eax,%edi
    202f:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    2036:	00 00 00 
    2039:	ff d0                	call   *%rax
    wait();
    203b:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    2042:	00 00 00 
    2045:	ff d0                	call   *%rax
    2047:	eb 19                	jmp    2062 <pipe1+0x245>
  } else {
    failexit("fork()");
    2049:	48 b8 cb 76 00 00 00 	movabs $0x76cb,%rax
    2050:	00 00 00 
    2053:	48 89 c7             	mov    %rax,%rdi
    2056:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    205d:	00 00 00 
    2060:	ff d0                	call   *%rax
  }
  printf(1, "pipe1 ok\n");
    2062:	48 b8 d2 76 00 00 00 	movabs $0x76d2,%rax
    2069:	00 00 00 
    206c:	48 89 c6             	mov    %rax,%rsi
    206f:	bf 01 00 00 00       	mov    $0x1,%edi
    2074:	b8 00 00 00 00       	mov    $0x0,%eax
    2079:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    2080:	00 00 00 
    2083:	ff d2                	call   *%rdx
}
    2085:	c9                   	leave
    2086:	c3                   	ret

0000000000002087 <preempt>:

// meant to be run w/ at most two CPUs
void
preempt(void)
{
    2087:	f3 0f 1e fa          	endbr64
    208b:	55                   	push   %rbp
    208c:	48 89 e5             	mov    %rsp,%rbp
    208f:	48 83 ec 20          	sub    $0x20,%rsp
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
    2093:	48 b8 dc 76 00 00 00 	movabs $0x76dc,%rax
    209a:	00 00 00 
    209d:	48 89 c6             	mov    %rax,%rsi
    20a0:	bf 01 00 00 00       	mov    $0x1,%edi
    20a5:	b8 00 00 00 00       	mov    $0x0,%eax
    20aa:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    20b1:	00 00 00 
    20b4:	ff d2                	call   *%rdx
  pid1 = fork();
    20b6:	48 b8 37 68 00 00 00 	movabs $0x6837,%rax
    20bd:	00 00 00 
    20c0:	ff d0                	call   *%rax
    20c2:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(pid1 == 0)
    20c5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    20c9:	75 03                	jne    20ce <preempt+0x47>
    for(;;)
    20cb:	90                   	nop
    20cc:	eb fd                	jmp    20cb <preempt+0x44>
      ;

  pid2 = fork();
    20ce:	48 b8 37 68 00 00 00 	movabs $0x6837,%rax
    20d5:	00 00 00 
    20d8:	ff d0                	call   *%rax
    20da:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(pid2 == 0)
    20dd:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    20e1:	75 03                	jne    20e6 <preempt+0x5f>
    for(;;)
    20e3:	90                   	nop
    20e4:	eb fd                	jmp    20e3 <preempt+0x5c>
      ;

  pipe(pfds);
    20e6:	48 8d 45 ec          	lea    -0x14(%rbp),%rax
    20ea:	48 89 c7             	mov    %rax,%rdi
    20ed:	48 b8 5e 68 00 00 00 	movabs $0x685e,%rax
    20f4:	00 00 00 
    20f7:	ff d0                	call   *%rax
  pid3 = fork();
    20f9:	48 b8 37 68 00 00 00 	movabs $0x6837,%rax
    2100:	00 00 00 
    2103:	ff d0                	call   *%rax
    2105:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(pid3 == 0){
    2108:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    210c:	75 70                	jne    217e <preempt+0xf7>
    close(pfds[0]);
    210e:	8b 45 ec             	mov    -0x14(%rbp),%eax
    2111:	89 c7                	mov    %eax,%edi
    2113:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    211a:	00 00 00 
    211d:	ff d0                	call   *%rax
    if(write(pfds[1], "x", 1) != 1)
    211f:	8b 45 f0             	mov    -0x10(%rbp),%eax
    2122:	ba 01 00 00 00       	mov    $0x1,%edx
    2127:	48 b9 e6 76 00 00 00 	movabs $0x76e6,%rcx
    212e:	00 00 00 
    2131:	48 89 ce             	mov    %rcx,%rsi
    2134:	89 c7                	mov    %eax,%edi
    2136:	48 b8 78 68 00 00 00 	movabs $0x6878,%rax
    213d:	00 00 00 
    2140:	ff d0                	call   *%rax
    2142:	83 f8 01             	cmp    $0x1,%eax
    2145:	74 23                	je     216a <preempt+0xe3>
      printf(1, "preempt write error");
    2147:	48 b8 e8 76 00 00 00 	movabs $0x76e8,%rax
    214e:	00 00 00 
    2151:	48 89 c6             	mov    %rax,%rsi
    2154:	bf 01 00 00 00       	mov    $0x1,%edi
    2159:	b8 00 00 00 00       	mov    $0x0,%eax
    215e:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    2165:	00 00 00 
    2168:	ff d2                	call   *%rdx
    close(pfds[1]);
    216a:	8b 45 f0             	mov    -0x10(%rbp),%eax
    216d:	89 c7                	mov    %eax,%edi
    216f:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    2176:	00 00 00 
    2179:	ff d0                	call   *%rax
    for(;;)
    217b:	90                   	nop
    217c:	eb fd                	jmp    217b <preempt+0xf4>
      ;
  }

  close(pfds[1]);
    217e:	8b 45 f0             	mov    -0x10(%rbp),%eax
    2181:	89 c7                	mov    %eax,%edi
    2183:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    218a:	00 00 00 
    218d:	ff d0                	call   *%rax
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    218f:	8b 45 ec             	mov    -0x14(%rbp),%eax
    2192:	ba 00 20 00 00       	mov    $0x2000,%edx
    2197:	48 b9 00 8a 00 00 00 	movabs $0x8a00,%rcx
    219e:	00 00 00 
    21a1:	48 89 ce             	mov    %rcx,%rsi
    21a4:	89 c7                	mov    %eax,%edi
    21a6:	48 b8 6b 68 00 00 00 	movabs $0x686b,%rax
    21ad:	00 00 00 
    21b0:	ff d0                	call   *%rax
    21b2:	83 f8 01             	cmp    $0x1,%eax
    21b5:	74 28                	je     21df <preempt+0x158>
    printf(1, "preempt read error");
    21b7:	48 b8 fc 76 00 00 00 	movabs $0x76fc,%rax
    21be:	00 00 00 
    21c1:	48 89 c6             	mov    %rax,%rsi
    21c4:	bf 01 00 00 00       	mov    $0x1,%edi
    21c9:	b8 00 00 00 00       	mov    $0x0,%eax
    21ce:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    21d5:	00 00 00 
    21d8:	ff d2                	call   *%rdx
    21da:	e9 d1 00 00 00       	jmp    22b0 <preempt+0x229>
    return;
  }
  close(pfds[0]);
    21df:	8b 45 ec             	mov    -0x14(%rbp),%eax
    21e2:	89 c7                	mov    %eax,%edi
    21e4:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    21eb:	00 00 00 
    21ee:	ff d0                	call   *%rax
  printf(1, "kill... ");
    21f0:	48 b8 0f 77 00 00 00 	movabs $0x770f,%rax
    21f7:	00 00 00 
    21fa:	48 89 c6             	mov    %rax,%rsi
    21fd:	bf 01 00 00 00       	mov    $0x1,%edi
    2202:	b8 00 00 00 00       	mov    $0x0,%eax
    2207:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    220e:	00 00 00 
    2211:	ff d2                	call   *%rdx
  kill(pid1);
    2213:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2216:	89 c7                	mov    %eax,%edi
    2218:	48 b8 92 68 00 00 00 	movabs $0x6892,%rax
    221f:	00 00 00 
    2222:	ff d0                	call   *%rax
  kill(pid2);
    2224:	8b 45 f8             	mov    -0x8(%rbp),%eax
    2227:	89 c7                	mov    %eax,%edi
    2229:	48 b8 92 68 00 00 00 	movabs $0x6892,%rax
    2230:	00 00 00 
    2233:	ff d0                	call   *%rax
  kill(pid3);
    2235:	8b 45 f4             	mov    -0xc(%rbp),%eax
    2238:	89 c7                	mov    %eax,%edi
    223a:	48 b8 92 68 00 00 00 	movabs $0x6892,%rax
    2241:	00 00 00 
    2244:	ff d0                	call   *%rax
  printf(1, "wait... ");
    2246:	48 b8 18 77 00 00 00 	movabs $0x7718,%rax
    224d:	00 00 00 
    2250:	48 89 c6             	mov    %rax,%rsi
    2253:	bf 01 00 00 00       	mov    $0x1,%edi
    2258:	b8 00 00 00 00       	mov    $0x0,%eax
    225d:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    2264:	00 00 00 
    2267:	ff d2                	call   *%rdx
  wait();
    2269:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    2270:	00 00 00 
    2273:	ff d0                	call   *%rax
  wait();
    2275:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    227c:	00 00 00 
    227f:	ff d0                	call   *%rax
  wait();
    2281:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    2288:	00 00 00 
    228b:	ff d0                	call   *%rax
  printf(1, "preempt ok\n");
    228d:	48 b8 21 77 00 00 00 	movabs $0x7721,%rax
    2294:	00 00 00 
    2297:	48 89 c6             	mov    %rax,%rsi
    229a:	bf 01 00 00 00       	mov    $0x1,%edi
    229f:	b8 00 00 00 00       	mov    $0x0,%eax
    22a4:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    22ab:	00 00 00 
    22ae:	ff d2                	call   *%rdx
}
    22b0:	c9                   	leave
    22b1:	c3                   	ret

00000000000022b2 <exitwait>:

// try to find any races between exit and wait
void
exitwait(void)
{
    22b2:	f3 0f 1e fa          	endbr64
    22b6:	55                   	push   %rbp
    22b7:	48 89 e5             	mov    %rsp,%rbp
    22ba:	48 83 ec 10          	sub    $0x10,%rsp
  int i, pid;

  for(i = 0; i < 100; i++){
    22be:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    22c5:	e9 86 00 00 00       	jmp    2350 <exitwait+0x9e>
    pid = fork();
    22ca:	48 b8 37 68 00 00 00 	movabs $0x6837,%rax
    22d1:	00 00 00 
    22d4:	ff d0                	call   *%rax
    22d6:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(pid < 0){
    22d9:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    22dd:	79 25                	jns    2304 <exitwait+0x52>
      printf(1, "fork");
    22df:	48 b8 f7 72 00 00 00 	movabs $0x72f7,%rax
    22e6:	00 00 00 
    22e9:	48 89 c6             	mov    %rax,%rsi
    22ec:	bf 01 00 00 00       	mov    $0x1,%edi
    22f1:	b8 00 00 00 00       	mov    $0x0,%eax
    22f6:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    22fd:	00 00 00 
    2300:	ff d2                	call   *%rdx
      return;
    2302:	eb 79                	jmp    237d <exitwait+0xcb>
    }
    if(pid){
    2304:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    2308:	74 36                	je     2340 <exitwait+0x8e>
      if(wait() != pid){
    230a:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    2311:	00 00 00 
    2314:	ff d0                	call   *%rax
    2316:	39 45 f8             	cmp    %eax,-0x8(%rbp)
    2319:	74 31                	je     234c <exitwait+0x9a>
        printf(1, "wait wrong pid\n");
    231b:	48 b8 2d 77 00 00 00 	movabs $0x772d,%rax
    2322:	00 00 00 
    2325:	48 89 c6             	mov    %rax,%rsi
    2328:	bf 01 00 00 00       	mov    $0x1,%edi
    232d:	b8 00 00 00 00       	mov    $0x0,%eax
    2332:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    2339:	00 00 00 
    233c:	ff d2                	call   *%rdx
        return;
    233e:	eb 3d                	jmp    237d <exitwait+0xcb>
      }
    } else {
      exit();
    2340:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    2347:	00 00 00 
    234a:	ff d0                	call   *%rax
  for(i = 0; i < 100; i++){
    234c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    2350:	83 7d fc 63          	cmpl   $0x63,-0x4(%rbp)
    2354:	0f 8e 70 ff ff ff    	jle    22ca <exitwait+0x18>
    }
  }
  printf(1, "exitwait ok\n");
    235a:	48 b8 3d 77 00 00 00 	movabs $0x773d,%rax
    2361:	00 00 00 
    2364:	48 89 c6             	mov    %rax,%rsi
    2367:	bf 01 00 00 00       	mov    $0x1,%edi
    236c:	b8 00 00 00 00       	mov    $0x0,%eax
    2371:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    2378:	00 00 00 
    237b:	ff d2                	call   *%rdx
}
    237d:	c9                   	leave
    237e:	c3                   	ret

000000000000237f <mem>:

void
mem(void)
{
    237f:	f3 0f 1e fa          	endbr64
    2383:	55                   	push   %rbp
    2384:	48 89 e5             	mov    %rsp,%rbp
    2387:	48 83 ec 20          	sub    $0x20,%rsp
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
    238b:	48 b8 4a 77 00 00 00 	movabs $0x774a,%rax
    2392:	00 00 00 
    2395:	48 89 c6             	mov    %rax,%rsi
    2398:	bf 01 00 00 00       	mov    $0x1,%edi
    239d:	b8 00 00 00 00       	mov    $0x0,%eax
    23a2:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    23a9:	00 00 00 
    23ac:	ff d2                	call   *%rdx
  ppid = getpid();
    23ae:	48 b8 14 69 00 00 00 	movabs $0x6914,%rax
    23b5:	00 00 00 
    23b8:	ff d0                	call   *%rax
    23ba:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if((pid = fork()) == 0){
    23bd:	48 b8 37 68 00 00 00 	movabs $0x6837,%rax
    23c4:	00 00 00 
    23c7:	ff d0                	call   *%rax
    23c9:	89 45 f0             	mov    %eax,-0x10(%rbp)
    23cc:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    23d0:	0f 85 29 01 00 00    	jne    24ff <mem+0x180>
    m1 = 0;
    23d6:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
    23dd:	00 
    while((m2 = malloc(100001)) != 0){
    23de:	eb 13                	jmp    23f3 <mem+0x74>
      //printf(1, "m2 %p\n", m2);
      *(void**)m2 = m1;
    23e0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    23e4:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
    23e8:	48 89 10             	mov    %rdx,(%rax)
      m1 = m2;
    23eb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    23ef:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while((m2 = malloc(100001)) != 0){
    23f3:	bf a1 86 01 00       	mov    $0x186a1,%edi
    23f8:	48 b8 1a 71 00 00 00 	movabs $0x711a,%rax
    23ff:	00 00 00 
    2402:	ff d0                	call   *%rax
    2404:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    2408:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
    240d:	75 d1                	jne    23e0 <mem+0x61>
    }
    printf(1, "alloc ended\n");
    240f:	48 b8 54 77 00 00 00 	movabs $0x7754,%rax
    2416:	00 00 00 
    2419:	48 89 c6             	mov    %rax,%rsi
    241c:	bf 01 00 00 00       	mov    $0x1,%edi
    2421:	b8 00 00 00 00       	mov    $0x0,%eax
    2426:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    242d:	00 00 00 
    2430:	ff d2                	call   *%rdx
    while(m1){
    2432:	eb 26                	jmp    245a <mem+0xdb>
      m2 = *(void**)m1;
    2434:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2438:	48 8b 00             	mov    (%rax),%rax
    243b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
      free(m1);
    243f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2443:	48 89 c7             	mov    %rax,%rdi
    2446:	48 b8 65 6f 00 00 00 	movabs $0x6f65,%rax
    244d:	00 00 00 
    2450:	ff d0                	call   *%rax
      m1 = m2;
    2452:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    2456:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while(m1){
    245a:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    245f:	75 d3                	jne    2434 <mem+0xb5>
    }
    m1 = malloc(1024*20);
    2461:	bf 00 50 00 00       	mov    $0x5000,%edi
    2466:	48 b8 1a 71 00 00 00 	movabs $0x711a,%rax
    246d:	00 00 00 
    2470:	ff d0                	call   *%rax
    2472:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(m1 == 0){
    2476:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    247b:	75 40                	jne    24bd <mem+0x13e>
      printf(1, "couldn't allocate mem?!!\n");
    247d:	48 b8 61 77 00 00 00 	movabs $0x7761,%rax
    2484:	00 00 00 
    2487:	48 89 c6             	mov    %rax,%rsi
    248a:	bf 01 00 00 00       	mov    $0x1,%edi
    248f:	b8 00 00 00 00       	mov    $0x0,%eax
    2494:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    249b:	00 00 00 
    249e:	ff d2                	call   *%rdx
      kill(ppid);
    24a0:	8b 45 f4             	mov    -0xc(%rbp),%eax
    24a3:	89 c7                	mov    %eax,%edi
    24a5:	48 b8 92 68 00 00 00 	movabs $0x6892,%rax
    24ac:	00 00 00 
    24af:	ff d0                	call   *%rax
      exit();
    24b1:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    24b8:	00 00 00 
    24bb:	ff d0                	call   *%rax
    }
    free(m1);
    24bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    24c1:	48 89 c7             	mov    %rax,%rdi
    24c4:	48 b8 65 6f 00 00 00 	movabs $0x6f65,%rax
    24cb:	00 00 00 
    24ce:	ff d0                	call   *%rax
    printf(1, "mem ok\n");
    24d0:	48 b8 7b 77 00 00 00 	movabs $0x777b,%rax
    24d7:	00 00 00 
    24da:	48 89 c6             	mov    %rax,%rsi
    24dd:	bf 01 00 00 00       	mov    $0x1,%edi
    24e2:	b8 00 00 00 00       	mov    $0x0,%eax
    24e7:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    24ee:	00 00 00 
    24f1:	ff d2                	call   *%rdx
    exit();
    24f3:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    24fa:	00 00 00 
    24fd:	ff d0                	call   *%rax
  } else {
    wait();
    24ff:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    2506:	00 00 00 
    2509:	ff d0                	call   *%rax
  }
}
    250b:	90                   	nop
    250c:	c9                   	leave
    250d:	c3                   	ret

000000000000250e <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
    250e:	f3 0f 1e fa          	endbr64
    2512:	55                   	push   %rbp
    2513:	48 89 e5             	mov    %rsp,%rbp
    2516:	48 83 ec 30          	sub    $0x30,%rsp
  int fd, pid, i, n, nc, np;
  char buf[10];

  printf(1, "sharedfd test\n");
    251a:	48 b8 83 77 00 00 00 	movabs $0x7783,%rax
    2521:	00 00 00 
    2524:	48 89 c6             	mov    %rax,%rsi
    2527:	bf 01 00 00 00       	mov    $0x1,%edi
    252c:	b8 00 00 00 00       	mov    $0x0,%eax
    2531:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    2538:	00 00 00 
    253b:	ff d2                	call   *%rdx

  unlink("sharedfd");
    253d:	48 b8 92 77 00 00 00 	movabs $0x7792,%rax
    2544:	00 00 00 
    2547:	48 89 c7             	mov    %rax,%rdi
    254a:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    2551:	00 00 00 
    2554:	ff d0                	call   *%rax
  fd = open("sharedfd", O_CREATE|O_RDWR);
    2556:	be 02 02 00 00       	mov    $0x202,%esi
    255b:	48 b8 92 77 00 00 00 	movabs $0x7792,%rax
    2562:	00 00 00 
    2565:	48 89 c7             	mov    %rax,%rdi
    2568:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    256f:	00 00 00 
    2572:	ff d0                	call   *%rax
    2574:	89 45 f0             	mov    %eax,-0x10(%rbp)
  if(fd < 0){
    2577:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    257b:	79 28                	jns    25a5 <sharedfd+0x97>
    printf(1, "fstests: cannot open sharedfd for writing");
    257d:	48 b8 a0 77 00 00 00 	movabs $0x77a0,%rax
    2584:	00 00 00 
    2587:	48 89 c6             	mov    %rax,%rsi
    258a:	bf 01 00 00 00       	mov    $0x1,%edi
    258f:	b8 00 00 00 00       	mov    $0x0,%eax
    2594:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    259b:	00 00 00 
    259e:	ff d2                	call   *%rdx
    return;
    25a0:	e9 1f 02 00 00       	jmp    27c4 <sharedfd+0x2b6>
  }
  pid = fork();
    25a5:	48 b8 37 68 00 00 00 	movabs $0x6837,%rax
    25ac:	00 00 00 
    25af:	ff d0                	call   *%rax
    25b1:	89 45 ec             	mov    %eax,-0x14(%rbp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
    25b4:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
    25b8:	75 07                	jne    25c1 <sharedfd+0xb3>
    25ba:	b9 63 00 00 00       	mov    $0x63,%ecx
    25bf:	eb 05                	jmp    25c6 <sharedfd+0xb8>
    25c1:	b9 70 00 00 00       	mov    $0x70,%ecx
    25c6:	48 8d 45 de          	lea    -0x22(%rbp),%rax
    25ca:	ba 0a 00 00 00       	mov    $0xa,%edx
    25cf:	89 ce                	mov    %ecx,%esi
    25d1:	48 89 c7             	mov    %rax,%rdi
    25d4:	48 b8 0f 66 00 00 00 	movabs $0x660f,%rax
    25db:	00 00 00 
    25de:	ff d0                	call   *%rax
  for(i = 0; i < 1000; i++){
    25e0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    25e7:	eb 4b                	jmp    2634 <sharedfd+0x126>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    25e9:	48 8d 4d de          	lea    -0x22(%rbp),%rcx
    25ed:	8b 45 f0             	mov    -0x10(%rbp),%eax
    25f0:	ba 0a 00 00 00       	mov    $0xa,%edx
    25f5:	48 89 ce             	mov    %rcx,%rsi
    25f8:	89 c7                	mov    %eax,%edi
    25fa:	48 b8 78 68 00 00 00 	movabs $0x6878,%rax
    2601:	00 00 00 
    2604:	ff d0                	call   *%rax
    2606:	83 f8 0a             	cmp    $0xa,%eax
    2609:	74 25                	je     2630 <sharedfd+0x122>
      printf(1, "fstests: write sharedfd failed\n");
    260b:	48 b8 d0 77 00 00 00 	movabs $0x77d0,%rax
    2612:	00 00 00 
    2615:	48 89 c6             	mov    %rax,%rsi
    2618:	bf 01 00 00 00       	mov    $0x1,%edi
    261d:	b8 00 00 00 00       	mov    $0x0,%eax
    2622:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    2629:	00 00 00 
    262c:	ff d2                	call   *%rdx
      break;
    262e:	eb 0d                	jmp    263d <sharedfd+0x12f>
  for(i = 0; i < 1000; i++){
    2630:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    2634:	81 7d fc e7 03 00 00 	cmpl   $0x3e7,-0x4(%rbp)
    263b:	7e ac                	jle    25e9 <sharedfd+0xdb>
    }
  }
  if(pid == 0)
    263d:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
    2641:	75 0c                	jne    264f <sharedfd+0x141>
    exit();
    2643:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    264a:	00 00 00 
    264d:	ff d0                	call   *%rax
  else
    wait();
    264f:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    2656:	00 00 00 
    2659:	ff d0                	call   *%rax
  close(fd);
    265b:	8b 45 f0             	mov    -0x10(%rbp),%eax
    265e:	89 c7                	mov    %eax,%edi
    2660:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    2667:	00 00 00 
    266a:	ff d0                	call   *%rax
  fd = open("sharedfd", 0);
    266c:	be 00 00 00 00       	mov    $0x0,%esi
    2671:	48 b8 92 77 00 00 00 	movabs $0x7792,%rax
    2678:	00 00 00 
    267b:	48 89 c7             	mov    %rax,%rdi
    267e:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    2685:	00 00 00 
    2688:	ff d0                	call   *%rax
    268a:	89 45 f0             	mov    %eax,-0x10(%rbp)
  if(fd < 0){
    268d:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    2691:	79 28                	jns    26bb <sharedfd+0x1ad>
    printf(1, "fstests: cannot open sharedfd for reading\n");
    2693:	48 b8 f0 77 00 00 00 	movabs $0x77f0,%rax
    269a:	00 00 00 
    269d:	48 89 c6             	mov    %rax,%rsi
    26a0:	bf 01 00 00 00       	mov    $0x1,%edi
    26a5:	b8 00 00 00 00       	mov    $0x0,%eax
    26aa:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    26b1:	00 00 00 
    26b4:	ff d2                	call   *%rdx
    return;
    26b6:	e9 09 01 00 00       	jmp    27c4 <sharedfd+0x2b6>
  }
  nc = np = 0;
    26bb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    26c2:	8b 45 f4             	mov    -0xc(%rbp),%eax
    26c5:	89 45 f8             	mov    %eax,-0x8(%rbp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
    26c8:	eb 39                	jmp    2703 <sharedfd+0x1f5>
    for(i = 0; i < sizeof(buf); i++){
    26ca:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    26d1:	eb 28                	jmp    26fb <sharedfd+0x1ed>
      if(buf[i] == 'c')
    26d3:	8b 45 fc             	mov    -0x4(%rbp),%eax
    26d6:	48 98                	cltq
    26d8:	0f b6 44 05 de       	movzbl -0x22(%rbp,%rax,1),%eax
    26dd:	3c 63                	cmp    $0x63,%al
    26df:	75 04                	jne    26e5 <sharedfd+0x1d7>
        nc++;
    26e1:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
      if(buf[i] == 'p')
    26e5:	8b 45 fc             	mov    -0x4(%rbp),%eax
    26e8:	48 98                	cltq
    26ea:	0f b6 44 05 de       	movzbl -0x22(%rbp,%rax,1),%eax
    26ef:	3c 70                	cmp    $0x70,%al
    26f1:	75 04                	jne    26f7 <sharedfd+0x1e9>
        np++;
    26f3:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
    for(i = 0; i < sizeof(buf); i++){
    26f7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    26fb:	8b 45 fc             	mov    -0x4(%rbp),%eax
    26fe:	83 f8 09             	cmp    $0x9,%eax
    2701:	76 d0                	jbe    26d3 <sharedfd+0x1c5>
  while((n = read(fd, buf, sizeof(buf))) > 0){
    2703:	48 8d 4d de          	lea    -0x22(%rbp),%rcx
    2707:	8b 45 f0             	mov    -0x10(%rbp),%eax
    270a:	ba 0a 00 00 00       	mov    $0xa,%edx
    270f:	48 89 ce             	mov    %rcx,%rsi
    2712:	89 c7                	mov    %eax,%edi
    2714:	48 b8 6b 68 00 00 00 	movabs $0x686b,%rax
    271b:	00 00 00 
    271e:	ff d0                	call   *%rax
    2720:	89 45 e8             	mov    %eax,-0x18(%rbp)
    2723:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
    2727:	7f a1                	jg     26ca <sharedfd+0x1bc>
    }
  }
  close(fd);
    2729:	8b 45 f0             	mov    -0x10(%rbp),%eax
    272c:	89 c7                	mov    %eax,%edi
    272e:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    2735:	00 00 00 
    2738:	ff d0                	call   *%rax
  unlink("sharedfd");
    273a:	48 b8 92 77 00 00 00 	movabs $0x7792,%rax
    2741:	00 00 00 
    2744:	48 89 c7             	mov    %rax,%rdi
    2747:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    274e:	00 00 00 
    2751:	ff d0                	call   *%rax
  if(nc == 10000 && np == 10000){
    2753:	81 7d f8 10 27 00 00 	cmpl   $0x2710,-0x8(%rbp)
    275a:	75 2e                	jne    278a <sharedfd+0x27c>
    275c:	81 7d f4 10 27 00 00 	cmpl   $0x2710,-0xc(%rbp)
    2763:	75 25                	jne    278a <sharedfd+0x27c>
    printf(1, "sharedfd ok\n");
    2765:	48 b8 1b 78 00 00 00 	movabs $0x781b,%rax
    276c:	00 00 00 
    276f:	48 89 c6             	mov    %rax,%rsi
    2772:	bf 01 00 00 00       	mov    $0x1,%edi
    2777:	b8 00 00 00 00       	mov    $0x0,%eax
    277c:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    2783:	00 00 00 
    2786:	ff d2                	call   *%rdx
    2788:	eb 3a                	jmp    27c4 <sharedfd+0x2b6>
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    278a:	8b 55 f4             	mov    -0xc(%rbp),%edx
    278d:	8b 45 f8             	mov    -0x8(%rbp),%eax
    2790:	89 d1                	mov    %edx,%ecx
    2792:	89 c2                	mov    %eax,%edx
    2794:	48 b8 28 78 00 00 00 	movabs $0x7828,%rax
    279b:	00 00 00 
    279e:	48 89 c6             	mov    %rax,%rsi
    27a1:	bf 01 00 00 00       	mov    $0x1,%edi
    27a6:	b8 00 00 00 00       	mov    $0x0,%eax
    27ab:	49 b8 55 6b 00 00 00 	movabs $0x6b55,%r8
    27b2:	00 00 00 
    27b5:	41 ff d0             	call   *%r8
    exit();
    27b8:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    27bf:	00 00 00 
    27c2:	ff d0                	call   *%rax
  }
}
    27c4:	c9                   	leave
    27c5:	c3                   	ret

00000000000027c6 <fourfiles>:

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(void)
{
    27c6:	f3 0f 1e fa          	endbr64
    27ca:	55                   	push   %rbp
    27cb:	48 89 e5             	mov    %rsp,%rbp
    27ce:	48 83 ec 50          	sub    $0x50,%rsp
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
    27d2:	48 b8 3d 78 00 00 00 	movabs $0x783d,%rax
    27d9:	00 00 00 
    27dc:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
    27e0:	48 b8 40 78 00 00 00 	movabs $0x7840,%rax
    27e7:	00 00 00 
    27ea:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    27ee:	48 b8 43 78 00 00 00 	movabs $0x7843,%rax
    27f5:	00 00 00 
    27f8:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    27fc:	48 b8 46 78 00 00 00 	movabs $0x7846,%rax
    2803:	00 00 00 
    2806:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  char *fname;

  printf(1, "fourfiles test\n");
    280a:	48 b8 49 78 00 00 00 	movabs $0x7849,%rax
    2811:	00 00 00 
    2814:	48 89 c6             	mov    %rax,%rsi
    2817:	bf 01 00 00 00       	mov    $0x1,%edi
    281c:	b8 00 00 00 00       	mov    $0x0,%eax
    2821:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    2828:	00 00 00 
    282b:	ff d2                	call   *%rdx

  for(pi = 0; pi < 4; pi++){
    282d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
    2834:	e9 3f 01 00 00       	jmp    2978 <fourfiles+0x1b2>
    fname = names[pi];
    2839:	8b 45 f0             	mov    -0x10(%rbp),%eax
    283c:	48 98                	cltq
    283e:	48 8b 44 c5 b0       	mov    -0x50(%rbp,%rax,8),%rax
    2843:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    unlink(fname);
    2847:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    284b:	48 89 c7             	mov    %rax,%rdi
    284e:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    2855:	00 00 00 
    2858:	ff d0                	call   *%rax

    pid = fork();
    285a:	48 b8 37 68 00 00 00 	movabs $0x6837,%rax
    2861:	00 00 00 
    2864:	ff d0                	call   *%rax
    2866:	89 45 dc             	mov    %eax,-0x24(%rbp)
    if(pid < 0){
    2869:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
    286d:	79 19                	jns    2888 <fourfiles+0xc2>
      failexit("fork");
    286f:	48 b8 f7 72 00 00 00 	movabs $0x72f7,%rax
    2876:	00 00 00 
    2879:	48 89 c7             	mov    %rax,%rdi
    287c:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    2883:	00 00 00 
    2886:	ff d0                	call   *%rax
    }

    if(pid == 0){
    2888:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
    288c:	0f 85 e2 00 00 00    	jne    2974 <fourfiles+0x1ae>
      fd = open(fname, O_CREATE | O_RDWR);
    2892:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    2896:	be 02 02 00 00       	mov    $0x202,%esi
    289b:	48 89 c7             	mov    %rax,%rdi
    289e:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    28a5:	00 00 00 
    28a8:	ff d0                	call   *%rax
    28aa:	89 45 e4             	mov    %eax,-0x1c(%rbp)
      if(fd < 0){
    28ad:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
    28b1:	79 19                	jns    28cc <fourfiles+0x106>
        failexit("create");
    28b3:	48 b8 59 78 00 00 00 	movabs $0x7859,%rax
    28ba:	00 00 00 
    28bd:	48 89 c7             	mov    %rax,%rdi
    28c0:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    28c7:	00 00 00 
    28ca:	ff d0                	call   *%rax
      }

      memset(buf, '0'+pi, 512);
    28cc:	8b 45 f0             	mov    -0x10(%rbp),%eax
    28cf:	83 c0 30             	add    $0x30,%eax
    28d2:	ba 00 02 00 00       	mov    $0x200,%edx
    28d7:	89 c6                	mov    %eax,%esi
    28d9:	48 b8 00 8a 00 00 00 	movabs $0x8a00,%rax
    28e0:	00 00 00 
    28e3:	48 89 c7             	mov    %rax,%rdi
    28e6:	48 b8 0f 66 00 00 00 	movabs $0x660f,%rax
    28ed:	00 00 00 
    28f0:	ff d0                	call   *%rax
      for(i = 0; i < 12; i++){
    28f2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    28f9:	eb 67                	jmp    2962 <fourfiles+0x19c>
        if((n = write(fd, buf, 500)) != 500){
    28fb:	8b 45 e4             	mov    -0x1c(%rbp),%eax
    28fe:	ba f4 01 00 00       	mov    $0x1f4,%edx
    2903:	48 b9 00 8a 00 00 00 	movabs $0x8a00,%rcx
    290a:	00 00 00 
    290d:	48 89 ce             	mov    %rcx,%rsi
    2910:	89 c7                	mov    %eax,%edi
    2912:	48 b8 78 68 00 00 00 	movabs $0x6878,%rax
    2919:	00 00 00 
    291c:	ff d0                	call   *%rax
    291e:	89 45 e0             	mov    %eax,-0x20(%rbp)
    2921:	81 7d e0 f4 01 00 00 	cmpl   $0x1f4,-0x20(%rbp)
    2928:	74 34                	je     295e <fourfiles+0x198>
          printf(1, "write failed %d\n", n);
    292a:	8b 45 e0             	mov    -0x20(%rbp),%eax
    292d:	89 c2                	mov    %eax,%edx
    292f:	48 b8 60 78 00 00 00 	movabs $0x7860,%rax
    2936:	00 00 00 
    2939:	48 89 c6             	mov    %rax,%rsi
    293c:	bf 01 00 00 00       	mov    $0x1,%edi
    2941:	b8 00 00 00 00       	mov    $0x0,%eax
    2946:	48 b9 55 6b 00 00 00 	movabs $0x6b55,%rcx
    294d:	00 00 00 
    2950:	ff d1                	call   *%rcx
          exit();
    2952:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    2959:	00 00 00 
    295c:	ff d0                	call   *%rax
      for(i = 0; i < 12; i++){
    295e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    2962:	83 7d fc 0b          	cmpl   $0xb,-0x4(%rbp)
    2966:	7e 93                	jle    28fb <fourfiles+0x135>
        }
      }
      exit();
    2968:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    296f:	00 00 00 
    2972:	ff d0                	call   *%rax
  for(pi = 0; pi < 4; pi++){
    2974:	83 45 f0 01          	addl   $0x1,-0x10(%rbp)
    2978:	83 7d f0 03          	cmpl   $0x3,-0x10(%rbp)
    297c:	0f 8e b7 fe ff ff    	jle    2839 <fourfiles+0x73>
    }
  }

  for(pi = 0; pi < 4; pi++){
    2982:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
    2989:	eb 10                	jmp    299b <fourfiles+0x1d5>
    wait();
    298b:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    2992:	00 00 00 
    2995:	ff d0                	call   *%rax
  for(pi = 0; pi < 4; pi++){
    2997:	83 45 f0 01          	addl   $0x1,-0x10(%rbp)
    299b:	83 7d f0 03          	cmpl   $0x3,-0x10(%rbp)
    299f:	7e ea                	jle    298b <fourfiles+0x1c5>
  }

  for(i = 0; i < 2; i++){
    29a1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    29a8:	e9 17 01 00 00       	jmp    2ac4 <fourfiles+0x2fe>
    fname = names[i];
    29ad:	8b 45 fc             	mov    -0x4(%rbp),%eax
    29b0:	48 98                	cltq
    29b2:	48 8b 44 c5 b0       	mov    -0x50(%rbp,%rax,8),%rax
    29b7:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    fd = open(fname, 0);
    29bb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    29bf:	be 00 00 00 00       	mov    $0x0,%esi
    29c4:	48 89 c7             	mov    %rax,%rdi
    29c7:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    29ce:	00 00 00 
    29d1:	ff d0                	call   *%rax
    29d3:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    total = 0;
    29d6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    29dd:	eb 54                	jmp    2a33 <fourfiles+0x26d>
      for(j = 0; j < n; j++){
    29df:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
    29e6:	eb 3d                	jmp    2a25 <fourfiles+0x25f>
        if(buf[j] != '0'+i){
    29e8:	48 ba 00 8a 00 00 00 	movabs $0x8a00,%rdx
    29ef:	00 00 00 
    29f2:	8b 45 f8             	mov    -0x8(%rbp),%eax
    29f5:	48 98                	cltq
    29f7:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    29fb:	0f be d0             	movsbl %al,%edx
    29fe:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2a01:	83 c0 30             	add    $0x30,%eax
    2a04:	39 c2                	cmp    %eax,%edx
    2a06:	74 19                	je     2a21 <fourfiles+0x25b>
          failexit("wrong char");
    2a08:	48 b8 71 78 00 00 00 	movabs $0x7871,%rax
    2a0f:	00 00 00 
    2a12:	48 89 c7             	mov    %rax,%rdi
    2a15:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    2a1c:	00 00 00 
    2a1f:	ff d0                	call   *%rax
      for(j = 0; j < n; j++){
    2a21:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    2a25:	8b 45 f8             	mov    -0x8(%rbp),%eax
    2a28:	3b 45 e0             	cmp    -0x20(%rbp),%eax
    2a2b:	7c bb                	jl     29e8 <fourfiles+0x222>
        }
      }
      total += n;
    2a2d:	8b 45 e0             	mov    -0x20(%rbp),%eax
    2a30:	01 45 f4             	add    %eax,-0xc(%rbp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    2a33:	8b 45 e4             	mov    -0x1c(%rbp),%eax
    2a36:	ba 00 20 00 00       	mov    $0x2000,%edx
    2a3b:	48 b9 00 8a 00 00 00 	movabs $0x8a00,%rcx
    2a42:	00 00 00 
    2a45:	48 89 ce             	mov    %rcx,%rsi
    2a48:	89 c7                	mov    %eax,%edi
    2a4a:	48 b8 6b 68 00 00 00 	movabs $0x686b,%rax
    2a51:	00 00 00 
    2a54:	ff d0                	call   *%rax
    2a56:	89 45 e0             	mov    %eax,-0x20(%rbp)
    2a59:	83 7d e0 00          	cmpl   $0x0,-0x20(%rbp)
    2a5d:	7f 80                	jg     29df <fourfiles+0x219>
    }
    close(fd);
    2a5f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
    2a62:	89 c7                	mov    %eax,%edi
    2a64:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    2a6b:	00 00 00 
    2a6e:	ff d0                	call   *%rax
    if(total != 12*500){
    2a70:	81 7d f4 70 17 00 00 	cmpl   $0x1770,-0xc(%rbp)
    2a77:	74 34                	je     2aad <fourfiles+0x2e7>
      printf(1, "wrong length %d\n", total);
    2a79:	8b 45 f4             	mov    -0xc(%rbp),%eax
    2a7c:	89 c2                	mov    %eax,%edx
    2a7e:	48 b8 7c 78 00 00 00 	movabs $0x787c,%rax
    2a85:	00 00 00 
    2a88:	48 89 c6             	mov    %rax,%rsi
    2a8b:	bf 01 00 00 00       	mov    $0x1,%edi
    2a90:	b8 00 00 00 00       	mov    $0x0,%eax
    2a95:	48 b9 55 6b 00 00 00 	movabs $0x6b55,%rcx
    2a9c:	00 00 00 
    2a9f:	ff d1                	call   *%rcx
      exit();
    2aa1:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    2aa8:	00 00 00 
    2aab:	ff d0                	call   *%rax
    }
    unlink(fname);
    2aad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    2ab1:	48 89 c7             	mov    %rax,%rdi
    2ab4:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    2abb:	00 00 00 
    2abe:	ff d0                	call   *%rax
  for(i = 0; i < 2; i++){
    2ac0:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    2ac4:	83 7d fc 01          	cmpl   $0x1,-0x4(%rbp)
    2ac8:	0f 8e df fe ff ff    	jle    29ad <fourfiles+0x1e7>
  }

  printf(1, "fourfiles ok\n");
    2ace:	48 b8 8d 78 00 00 00 	movabs $0x788d,%rax
    2ad5:	00 00 00 
    2ad8:	48 89 c6             	mov    %rax,%rsi
    2adb:	bf 01 00 00 00       	mov    $0x1,%edi
    2ae0:	b8 00 00 00 00       	mov    $0x0,%eax
    2ae5:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    2aec:	00 00 00 
    2aef:	ff d2                	call   *%rdx
}
    2af1:	90                   	nop
    2af2:	c9                   	leave
    2af3:	c3                   	ret

0000000000002af4 <createdelete>:

// four processes create and delete different files in same directory
void
createdelete(void)
{
    2af4:	f3 0f 1e fa          	endbr64
    2af8:	55                   	push   %rbp
    2af9:	48 89 e5             	mov    %rsp,%rbp
    2afc:	48 83 ec 30          	sub    $0x30,%rsp
  enum { N = 20 };
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");
    2b00:	48 b8 9b 78 00 00 00 	movabs $0x789b,%rax
    2b07:	00 00 00 
    2b0a:	48 89 c6             	mov    %rax,%rsi
    2b0d:	bf 01 00 00 00       	mov    $0x1,%edi
    2b12:	b8 00 00 00 00       	mov    $0x0,%eax
    2b17:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    2b1e:	00 00 00 
    2b21:	ff d2                	call   *%rdx

  for(pi = 0; pi < 4; pi++){
    2b23:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
    2b2a:	e9 15 01 00 00       	jmp    2c44 <createdelete+0x150>
    pid = fork();
    2b2f:	48 b8 37 68 00 00 00 	movabs $0x6837,%rax
    2b36:	00 00 00 
    2b39:	ff d0                	call   *%rax
    2b3b:	89 45 f0             	mov    %eax,-0x10(%rbp)
    if(pid < 0){
    2b3e:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    2b42:	79 19                	jns    2b5d <createdelete+0x69>
      failexit("fork");
    2b44:	48 b8 f7 72 00 00 00 	movabs $0x72f7,%rax
    2b4b:	00 00 00 
    2b4e:	48 89 c7             	mov    %rax,%rdi
    2b51:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    2b58:	00 00 00 
    2b5b:	ff d0                	call   *%rax
    }

    if(pid == 0){
    2b5d:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    2b61:	0f 85 d9 00 00 00    	jne    2c40 <createdelete+0x14c>
      name[0] = 'p' + pi;
    2b67:	8b 45 f8             	mov    -0x8(%rbp),%eax
    2b6a:	83 c0 70             	add    $0x70,%eax
    2b6d:	88 45 d0             	mov    %al,-0x30(%rbp)
      name[2] = '\0';
    2b70:	c6 45 d2 00          	movb   $0x0,-0x2e(%rbp)
      for(i = 0; i < N; i++){
    2b74:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    2b7b:	e9 aa 00 00 00       	jmp    2c2a <createdelete+0x136>
        name[1] = '0' + i;
    2b80:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2b83:	83 c0 30             	add    $0x30,%eax
    2b86:	88 45 d1             	mov    %al,-0x2f(%rbp)
        fd = open(name, O_CREATE | O_RDWR);
    2b89:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    2b8d:	be 02 02 00 00       	mov    $0x202,%esi
    2b92:	48 89 c7             	mov    %rax,%rdi
    2b95:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    2b9c:	00 00 00 
    2b9f:	ff d0                	call   *%rax
    2ba1:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if(fd < 0){
    2ba4:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    2ba8:	79 19                	jns    2bc3 <createdelete+0xcf>
          failexit("create");
    2baa:	48 b8 59 78 00 00 00 	movabs $0x7859,%rax
    2bb1:	00 00 00 
    2bb4:	48 89 c7             	mov    %rax,%rdi
    2bb7:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    2bbe:	00 00 00 
    2bc1:	ff d0                	call   *%rax
        }
        close(fd);
    2bc3:	8b 45 f4             	mov    -0xc(%rbp),%eax
    2bc6:	89 c7                	mov    %eax,%edi
    2bc8:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    2bcf:	00 00 00 
    2bd2:	ff d0                	call   *%rax
        if(i > 0 && (i % 2 ) == 0){
    2bd4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    2bd8:	7e 4c                	jle    2c26 <createdelete+0x132>
    2bda:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2bdd:	83 e0 01             	and    $0x1,%eax
    2be0:	85 c0                	test   %eax,%eax
    2be2:	75 42                	jne    2c26 <createdelete+0x132>
          name[1] = '0' + (i / 2);
    2be4:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2be7:	89 c2                	mov    %eax,%edx
    2be9:	c1 ea 1f             	shr    $0x1f,%edx
    2bec:	01 d0                	add    %edx,%eax
    2bee:	d1 f8                	sar    $1,%eax
    2bf0:	83 c0 30             	add    $0x30,%eax
    2bf3:	88 45 d1             	mov    %al,-0x2f(%rbp)
          if(unlink(name) < 0){
    2bf6:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    2bfa:	48 89 c7             	mov    %rax,%rdi
    2bfd:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    2c04:	00 00 00 
    2c07:	ff d0                	call   *%rax
    2c09:	85 c0                	test   %eax,%eax
    2c0b:	79 19                	jns    2c26 <createdelete+0x132>
            failexit("unlink");
    2c0d:	48 b8 63 73 00 00 00 	movabs $0x7363,%rax
    2c14:	00 00 00 
    2c17:	48 89 c7             	mov    %rax,%rdi
    2c1a:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    2c21:	00 00 00 
    2c24:	ff d0                	call   *%rax
      for(i = 0; i < N; i++){
    2c26:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    2c2a:	83 7d fc 13          	cmpl   $0x13,-0x4(%rbp)
    2c2e:	0f 8e 4c ff ff ff    	jle    2b80 <createdelete+0x8c>
          }
        }
      }
      exit();
    2c34:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    2c3b:	00 00 00 
    2c3e:	ff d0                	call   *%rax
  for(pi = 0; pi < 4; pi++){
    2c40:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    2c44:	83 7d f8 03          	cmpl   $0x3,-0x8(%rbp)
    2c48:	0f 8e e1 fe ff ff    	jle    2b2f <createdelete+0x3b>
    }
  }

  for(pi = 0; pi < 4; pi++){
    2c4e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
    2c55:	eb 10                	jmp    2c67 <createdelete+0x173>
    wait();
    2c57:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    2c5e:	00 00 00 
    2c61:	ff d0                	call   *%rax
  for(pi = 0; pi < 4; pi++){
    2c63:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    2c67:	83 7d f8 03          	cmpl   $0x3,-0x8(%rbp)
    2c6b:	7e ea                	jle    2c57 <createdelete+0x163>
  }

  name[0] = name[1] = name[2] = 0;
    2c6d:	c6 45 d2 00          	movb   $0x0,-0x2e(%rbp)
    2c71:	0f b6 45 d2          	movzbl -0x2e(%rbp),%eax
    2c75:	88 45 d1             	mov    %al,-0x2f(%rbp)
    2c78:	0f b6 45 d1          	movzbl -0x2f(%rbp),%eax
    2c7c:	88 45 d0             	mov    %al,-0x30(%rbp)
  for(i = 0; i < N; i++){
    2c7f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    2c86:	e9 f2 00 00 00       	jmp    2d7d <createdelete+0x289>
    for(pi = 0; pi < 4; pi++){
    2c8b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
    2c92:	e9 d8 00 00 00       	jmp    2d6f <createdelete+0x27b>
      name[0] = 'p' + pi;
    2c97:	8b 45 f8             	mov    -0x8(%rbp),%eax
    2c9a:	83 c0 70             	add    $0x70,%eax
    2c9d:	88 45 d0             	mov    %al,-0x30(%rbp)
      name[1] = '0' + i;
    2ca0:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2ca3:	83 c0 30             	add    $0x30,%eax
    2ca6:	88 45 d1             	mov    %al,-0x2f(%rbp)
      fd = open(name, 0);
    2ca9:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    2cad:	be 00 00 00 00       	mov    $0x0,%esi
    2cb2:	48 89 c7             	mov    %rax,%rdi
    2cb5:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    2cbc:	00 00 00 
    2cbf:	ff d0                	call   *%rax
    2cc1:	89 45 f4             	mov    %eax,-0xc(%rbp)
      if((i == 0 || i >= N/2) && fd < 0){
    2cc4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    2cc8:	74 06                	je     2cd0 <createdelete+0x1dc>
    2cca:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
    2cce:	7e 3c                	jle    2d0c <createdelete+0x218>
    2cd0:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    2cd4:	79 36                	jns    2d0c <createdelete+0x218>
        printf(1, "oops createdelete %s didn't exist\n", name);
    2cd6:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    2cda:	48 89 c2             	mov    %rax,%rdx
    2cdd:	48 b8 b0 78 00 00 00 	movabs $0x78b0,%rax
    2ce4:	00 00 00 
    2ce7:	48 89 c6             	mov    %rax,%rsi
    2cea:	bf 01 00 00 00       	mov    $0x1,%edi
    2cef:	b8 00 00 00 00       	mov    $0x0,%eax
    2cf4:	48 b9 55 6b 00 00 00 	movabs $0x6b55,%rcx
    2cfb:	00 00 00 
    2cfe:	ff d1                	call   *%rcx
        exit();
    2d00:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    2d07:	00 00 00 
    2d0a:	ff d0                	call   *%rax
      } else if((i >= 1 && i < N/2) && fd >= 0){
    2d0c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    2d10:	7e 42                	jle    2d54 <createdelete+0x260>
    2d12:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
    2d16:	7f 3c                	jg     2d54 <createdelete+0x260>
    2d18:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    2d1c:	78 36                	js     2d54 <createdelete+0x260>
        printf(1, "oops createdelete %s did exist\n", name);
    2d1e:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    2d22:	48 89 c2             	mov    %rax,%rdx
    2d25:	48 b8 d8 78 00 00 00 	movabs $0x78d8,%rax
    2d2c:	00 00 00 
    2d2f:	48 89 c6             	mov    %rax,%rsi
    2d32:	bf 01 00 00 00       	mov    $0x1,%edi
    2d37:	b8 00 00 00 00       	mov    $0x0,%eax
    2d3c:	48 b9 55 6b 00 00 00 	movabs $0x6b55,%rcx
    2d43:	00 00 00 
    2d46:	ff d1                	call   *%rcx
        exit();
    2d48:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    2d4f:	00 00 00 
    2d52:	ff d0                	call   *%rax
      }
      if(fd >= 0)
    2d54:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    2d58:	78 11                	js     2d6b <createdelete+0x277>
        close(fd);
    2d5a:	8b 45 f4             	mov    -0xc(%rbp),%eax
    2d5d:	89 c7                	mov    %eax,%edi
    2d5f:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    2d66:	00 00 00 
    2d69:	ff d0                	call   *%rax
    for(pi = 0; pi < 4; pi++){
    2d6b:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    2d6f:	83 7d f8 03          	cmpl   $0x3,-0x8(%rbp)
    2d73:	0f 8e 1e ff ff ff    	jle    2c97 <createdelete+0x1a3>
  for(i = 0; i < N; i++){
    2d79:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    2d7d:	83 7d fc 13          	cmpl   $0x13,-0x4(%rbp)
    2d81:	0f 8e 04 ff ff ff    	jle    2c8b <createdelete+0x197>
    }
  }

  for(i = 0; i < N; i++){
    2d87:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    2d8e:	eb 3c                	jmp    2dcc <createdelete+0x2d8>
    for(pi = 0; pi < 4; pi++){
    2d90:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
    2d97:	eb 29                	jmp    2dc2 <createdelete+0x2ce>
      name[0] = 'p' + i;
    2d99:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2d9c:	83 c0 70             	add    $0x70,%eax
    2d9f:	88 45 d0             	mov    %al,-0x30(%rbp)
      name[1] = '0' + i;
    2da2:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2da5:	83 c0 30             	add    $0x30,%eax
    2da8:	88 45 d1             	mov    %al,-0x2f(%rbp)
      unlink(name);
    2dab:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    2daf:	48 89 c7             	mov    %rax,%rdi
    2db2:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    2db9:	00 00 00 
    2dbc:	ff d0                	call   *%rax
    for(pi = 0; pi < 4; pi++){
    2dbe:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    2dc2:	83 7d f8 03          	cmpl   $0x3,-0x8(%rbp)
    2dc6:	7e d1                	jle    2d99 <createdelete+0x2a5>
  for(i = 0; i < N; i++){
    2dc8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    2dcc:	83 7d fc 13          	cmpl   $0x13,-0x4(%rbp)
    2dd0:	7e be                	jle    2d90 <createdelete+0x29c>
    }
  }

  printf(1, "createdelete ok\n");
    2dd2:	48 b8 f8 78 00 00 00 	movabs $0x78f8,%rax
    2dd9:	00 00 00 
    2ddc:	48 89 c6             	mov    %rax,%rsi
    2ddf:	bf 01 00 00 00       	mov    $0x1,%edi
    2de4:	b8 00 00 00 00       	mov    $0x0,%eax
    2de9:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    2df0:	00 00 00 
    2df3:	ff d2                	call   *%rdx
}
    2df5:	90                   	nop
    2df6:	c9                   	leave
    2df7:	c3                   	ret

0000000000002df8 <unlinkread>:

// can I unlink a file and still read it?
void
unlinkread(void)
{
    2df8:	f3 0f 1e fa          	endbr64
    2dfc:	55                   	push   %rbp
    2dfd:	48 89 e5             	mov    %rsp,%rbp
    2e00:	48 83 ec 10          	sub    $0x10,%rsp
  int fd, fd1;

  printf(1, "unlinkread test\n");
    2e04:	48 b8 09 79 00 00 00 	movabs $0x7909,%rax
    2e0b:	00 00 00 
    2e0e:	48 89 c6             	mov    %rax,%rsi
    2e11:	bf 01 00 00 00       	mov    $0x1,%edi
    2e16:	b8 00 00 00 00       	mov    $0x0,%eax
    2e1b:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    2e22:	00 00 00 
    2e25:	ff d2                	call   *%rdx
  fd = open("unlinkread", O_CREATE | O_RDWR);
    2e27:	be 02 02 00 00       	mov    $0x202,%esi
    2e2c:	48 b8 1a 79 00 00 00 	movabs $0x791a,%rax
    2e33:	00 00 00 
    2e36:	48 89 c7             	mov    %rax,%rdi
    2e39:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    2e40:	00 00 00 
    2e43:	ff d0                	call   *%rax
    2e45:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    2e48:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    2e4c:	79 19                	jns    2e67 <unlinkread+0x6f>
    failexit("create unlinkread");
    2e4e:	48 b8 25 79 00 00 00 	movabs $0x7925,%rax
    2e55:	00 00 00 
    2e58:	48 89 c7             	mov    %rax,%rdi
    2e5b:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    2e62:	00 00 00 
    2e65:	ff d0                	call   *%rax
  }
  write(fd, "hello", 5);
    2e67:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2e6a:	ba 05 00 00 00       	mov    $0x5,%edx
    2e6f:	48 b9 37 79 00 00 00 	movabs $0x7937,%rcx
    2e76:	00 00 00 
    2e79:	48 89 ce             	mov    %rcx,%rsi
    2e7c:	89 c7                	mov    %eax,%edi
    2e7e:	48 b8 78 68 00 00 00 	movabs $0x6878,%rax
    2e85:	00 00 00 
    2e88:	ff d0                	call   *%rax
  close(fd);
    2e8a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2e8d:	89 c7                	mov    %eax,%edi
    2e8f:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    2e96:	00 00 00 
    2e99:	ff d0                	call   *%rax

  fd = open("unlinkread", O_RDWR);
    2e9b:	be 02 00 00 00       	mov    $0x2,%esi
    2ea0:	48 b8 1a 79 00 00 00 	movabs $0x791a,%rax
    2ea7:	00 00 00 
    2eaa:	48 89 c7             	mov    %rax,%rdi
    2ead:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    2eb4:	00 00 00 
    2eb7:	ff d0                	call   *%rax
    2eb9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    2ebc:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    2ec0:	79 19                	jns    2edb <unlinkread+0xe3>
    failexit("open unlinkread");
    2ec2:	48 b8 3d 79 00 00 00 	movabs $0x793d,%rax
    2ec9:	00 00 00 
    2ecc:	48 89 c7             	mov    %rax,%rdi
    2ecf:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    2ed6:	00 00 00 
    2ed9:	ff d0                	call   *%rax
  }
  if(unlink("unlinkread") != 0){
    2edb:	48 b8 1a 79 00 00 00 	movabs $0x791a,%rax
    2ee2:	00 00 00 
    2ee5:	48 89 c7             	mov    %rax,%rdi
    2ee8:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    2eef:	00 00 00 
    2ef2:	ff d0                	call   *%rax
    2ef4:	85 c0                	test   %eax,%eax
    2ef6:	74 19                	je     2f11 <unlinkread+0x119>
    failexit("unlink unlinkread");
    2ef8:	48 b8 4d 79 00 00 00 	movabs $0x794d,%rax
    2eff:	00 00 00 
    2f02:	48 89 c7             	mov    %rax,%rdi
    2f05:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    2f0c:	00 00 00 
    2f0f:	ff d0                	call   *%rax
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    2f11:	be 02 02 00 00       	mov    $0x202,%esi
    2f16:	48 b8 1a 79 00 00 00 	movabs $0x791a,%rax
    2f1d:	00 00 00 
    2f20:	48 89 c7             	mov    %rax,%rdi
    2f23:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    2f2a:	00 00 00 
    2f2d:	ff d0                	call   *%rax
    2f2f:	89 45 f8             	mov    %eax,-0x8(%rbp)
  write(fd1, "yyy", 3);
    2f32:	8b 45 f8             	mov    -0x8(%rbp),%eax
    2f35:	ba 03 00 00 00       	mov    $0x3,%edx
    2f3a:	48 b9 5f 79 00 00 00 	movabs $0x795f,%rcx
    2f41:	00 00 00 
    2f44:	48 89 ce             	mov    %rcx,%rsi
    2f47:	89 c7                	mov    %eax,%edi
    2f49:	48 b8 78 68 00 00 00 	movabs $0x6878,%rax
    2f50:	00 00 00 
    2f53:	ff d0                	call   *%rax
  close(fd1);
    2f55:	8b 45 f8             	mov    -0x8(%rbp),%eax
    2f58:	89 c7                	mov    %eax,%edi
    2f5a:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    2f61:	00 00 00 
    2f64:	ff d0                	call   *%rax

  if(read(fd, buf, sizeof(buf)) != 5){
    2f66:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2f69:	ba 00 20 00 00       	mov    $0x2000,%edx
    2f6e:	48 b9 00 8a 00 00 00 	movabs $0x8a00,%rcx
    2f75:	00 00 00 
    2f78:	48 89 ce             	mov    %rcx,%rsi
    2f7b:	89 c7                	mov    %eax,%edi
    2f7d:	48 b8 6b 68 00 00 00 	movabs $0x686b,%rax
    2f84:	00 00 00 
    2f87:	ff d0                	call   *%rax
    2f89:	83 f8 05             	cmp    $0x5,%eax
    2f8c:	74 19                	je     2fa7 <unlinkread+0x1af>
    failexit("unlinkread read failed");
    2f8e:	48 b8 63 79 00 00 00 	movabs $0x7963,%rax
    2f95:	00 00 00 
    2f98:	48 89 c7             	mov    %rax,%rdi
    2f9b:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    2fa2:	00 00 00 
    2fa5:	ff d0                	call   *%rax
  }
  if(buf[0] != 'h'){
    2fa7:	48 b8 00 8a 00 00 00 	movabs $0x8a00,%rax
    2fae:	00 00 00 
    2fb1:	0f b6 00             	movzbl (%rax),%eax
    2fb4:	3c 68                	cmp    $0x68,%al
    2fb6:	74 19                	je     2fd1 <unlinkread+0x1d9>
    failexit("unlinkread wrong data");
    2fb8:	48 b8 7a 79 00 00 00 	movabs $0x797a,%rax
    2fbf:	00 00 00 
    2fc2:	48 89 c7             	mov    %rax,%rdi
    2fc5:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    2fcc:	00 00 00 
    2fcf:	ff d0                	call   *%rax
  }
  if(write(fd, buf, 10) != 10){
    2fd1:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2fd4:	ba 0a 00 00 00       	mov    $0xa,%edx
    2fd9:	48 b9 00 8a 00 00 00 	movabs $0x8a00,%rcx
    2fe0:	00 00 00 
    2fe3:	48 89 ce             	mov    %rcx,%rsi
    2fe6:	89 c7                	mov    %eax,%edi
    2fe8:	48 b8 78 68 00 00 00 	movabs $0x6878,%rax
    2fef:	00 00 00 
    2ff2:	ff d0                	call   *%rax
    2ff4:	83 f8 0a             	cmp    $0xa,%eax
    2ff7:	74 19                	je     3012 <unlinkread+0x21a>
    failexit("unlinkread write");
    2ff9:	48 b8 90 79 00 00 00 	movabs $0x7990,%rax
    3000:	00 00 00 
    3003:	48 89 c7             	mov    %rax,%rdi
    3006:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    300d:	00 00 00 
    3010:	ff d0                	call   *%rax
  }
  close(fd);
    3012:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3015:	89 c7                	mov    %eax,%edi
    3017:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    301e:	00 00 00 
    3021:	ff d0                	call   *%rax
  unlink("unlinkread");
    3023:	48 b8 1a 79 00 00 00 	movabs $0x791a,%rax
    302a:	00 00 00 
    302d:	48 89 c7             	mov    %rax,%rdi
    3030:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    3037:	00 00 00 
    303a:	ff d0                	call   *%rax
  printf(1, "unlinkread ok\n");
    303c:	48 b8 a1 79 00 00 00 	movabs $0x79a1,%rax
    3043:	00 00 00 
    3046:	48 89 c6             	mov    %rax,%rsi
    3049:	bf 01 00 00 00       	mov    $0x1,%edi
    304e:	b8 00 00 00 00       	mov    $0x0,%eax
    3053:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    305a:	00 00 00 
    305d:	ff d2                	call   *%rdx
}
    305f:	90                   	nop
    3060:	c9                   	leave
    3061:	c3                   	ret

0000000000003062 <linktest>:

void
linktest(void)
{
    3062:	f3 0f 1e fa          	endbr64
    3066:	55                   	push   %rbp
    3067:	48 89 e5             	mov    %rsp,%rbp
    306a:	48 83 ec 10          	sub    $0x10,%rsp
  int fd;

  printf(1, "linktest\n");
    306e:	48 b8 b0 79 00 00 00 	movabs $0x79b0,%rax
    3075:	00 00 00 
    3078:	48 89 c6             	mov    %rax,%rsi
    307b:	bf 01 00 00 00       	mov    $0x1,%edi
    3080:	b8 00 00 00 00       	mov    $0x0,%eax
    3085:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    308c:	00 00 00 
    308f:	ff d2                	call   *%rdx

  unlink("lf1");
    3091:	48 b8 ba 79 00 00 00 	movabs $0x79ba,%rax
    3098:	00 00 00 
    309b:	48 89 c7             	mov    %rax,%rdi
    309e:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    30a5:	00 00 00 
    30a8:	ff d0                	call   *%rax
  unlink("lf2");
    30aa:	48 b8 be 79 00 00 00 	movabs $0x79be,%rax
    30b1:	00 00 00 
    30b4:	48 89 c7             	mov    %rax,%rdi
    30b7:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    30be:	00 00 00 
    30c1:	ff d0                	call   *%rax

  fd = open("lf1", O_CREATE|O_RDWR);
    30c3:	be 02 02 00 00       	mov    $0x202,%esi
    30c8:	48 b8 ba 79 00 00 00 	movabs $0x79ba,%rax
    30cf:	00 00 00 
    30d2:	48 89 c7             	mov    %rax,%rdi
    30d5:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    30dc:	00 00 00 
    30df:	ff d0                	call   *%rax
    30e1:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    30e4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    30e8:	79 19                	jns    3103 <linktest+0xa1>
    failexit("create lf1");
    30ea:	48 b8 c2 79 00 00 00 	movabs $0x79c2,%rax
    30f1:	00 00 00 
    30f4:	48 89 c7             	mov    %rax,%rdi
    30f7:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    30fe:	00 00 00 
    3101:	ff d0                	call   *%rax
  }
  if(write(fd, "hello", 5) != 5){
    3103:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3106:	ba 05 00 00 00       	mov    $0x5,%edx
    310b:	48 b9 37 79 00 00 00 	movabs $0x7937,%rcx
    3112:	00 00 00 
    3115:	48 89 ce             	mov    %rcx,%rsi
    3118:	89 c7                	mov    %eax,%edi
    311a:	48 b8 78 68 00 00 00 	movabs $0x6878,%rax
    3121:	00 00 00 
    3124:	ff d0                	call   *%rax
    3126:	83 f8 05             	cmp    $0x5,%eax
    3129:	74 19                	je     3144 <linktest+0xe2>
    failexit("write lf1");
    312b:	48 b8 cd 79 00 00 00 	movabs $0x79cd,%rax
    3132:	00 00 00 
    3135:	48 89 c7             	mov    %rax,%rdi
    3138:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    313f:	00 00 00 
    3142:	ff d0                	call   *%rax
  }
  close(fd);
    3144:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3147:	89 c7                	mov    %eax,%edi
    3149:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    3150:	00 00 00 
    3153:	ff d0                	call   *%rax

  if(link("lf1", "lf2") < 0){
    3155:	48 b8 be 79 00 00 00 	movabs $0x79be,%rax
    315c:	00 00 00 
    315f:	48 89 c6             	mov    %rax,%rsi
    3162:	48 b8 ba 79 00 00 00 	movabs $0x79ba,%rax
    3169:	00 00 00 
    316c:	48 89 c7             	mov    %rax,%rdi
    316f:	48 b8 e0 68 00 00 00 	movabs $0x68e0,%rax
    3176:	00 00 00 
    3179:	ff d0                	call   *%rax
    317b:	85 c0                	test   %eax,%eax
    317d:	79 19                	jns    3198 <linktest+0x136>
    failexit("link lf1 lf2");
    317f:	48 b8 d7 79 00 00 00 	movabs $0x79d7,%rax
    3186:	00 00 00 
    3189:	48 89 c7             	mov    %rax,%rdi
    318c:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3193:	00 00 00 
    3196:	ff d0                	call   *%rax
  }
  unlink("lf1");
    3198:	48 b8 ba 79 00 00 00 	movabs $0x79ba,%rax
    319f:	00 00 00 
    31a2:	48 89 c7             	mov    %rax,%rdi
    31a5:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    31ac:	00 00 00 
    31af:	ff d0                	call   *%rax

  if(open("lf1", 0) >= 0){
    31b1:	be 00 00 00 00       	mov    $0x0,%esi
    31b6:	48 b8 ba 79 00 00 00 	movabs $0x79ba,%rax
    31bd:	00 00 00 
    31c0:	48 89 c7             	mov    %rax,%rdi
    31c3:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    31ca:	00 00 00 
    31cd:	ff d0                	call   *%rax
    31cf:	85 c0                	test   %eax,%eax
    31d1:	78 19                	js     31ec <linktest+0x18a>
    failexit("unlinked lf1 but it is still there!");
    31d3:	48 b8 e8 79 00 00 00 	movabs $0x79e8,%rax
    31da:	00 00 00 
    31dd:	48 89 c7             	mov    %rax,%rdi
    31e0:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    31e7:	00 00 00 
    31ea:	ff d0                	call   *%rax
  }

  fd = open("lf2", 0);
    31ec:	be 00 00 00 00       	mov    $0x0,%esi
    31f1:	48 b8 be 79 00 00 00 	movabs $0x79be,%rax
    31f8:	00 00 00 
    31fb:	48 89 c7             	mov    %rax,%rdi
    31fe:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    3205:	00 00 00 
    3208:	ff d0                	call   *%rax
    320a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    320d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    3211:	79 19                	jns    322c <linktest+0x1ca>
    failexit("open lf2");
    3213:	48 b8 0c 7a 00 00 00 	movabs $0x7a0c,%rax
    321a:	00 00 00 
    321d:	48 89 c7             	mov    %rax,%rdi
    3220:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3227:	00 00 00 
    322a:	ff d0                	call   *%rax
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    322c:	8b 45 fc             	mov    -0x4(%rbp),%eax
    322f:	ba 00 20 00 00       	mov    $0x2000,%edx
    3234:	48 b9 00 8a 00 00 00 	movabs $0x8a00,%rcx
    323b:	00 00 00 
    323e:	48 89 ce             	mov    %rcx,%rsi
    3241:	89 c7                	mov    %eax,%edi
    3243:	48 b8 6b 68 00 00 00 	movabs $0x686b,%rax
    324a:	00 00 00 
    324d:	ff d0                	call   *%rax
    324f:	83 f8 05             	cmp    $0x5,%eax
    3252:	74 19                	je     326d <linktest+0x20b>
    failexit("read lf2");
    3254:	48 b8 15 7a 00 00 00 	movabs $0x7a15,%rax
    325b:	00 00 00 
    325e:	48 89 c7             	mov    %rax,%rdi
    3261:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3268:	00 00 00 
    326b:	ff d0                	call   *%rax
  }
  close(fd);
    326d:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3270:	89 c7                	mov    %eax,%edi
    3272:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    3279:	00 00 00 
    327c:	ff d0                	call   *%rax

  if(link("lf2", "lf2") >= 0){
    327e:	48 b8 be 79 00 00 00 	movabs $0x79be,%rax
    3285:	00 00 00 
    3288:	48 89 c6             	mov    %rax,%rsi
    328b:	48 b8 be 79 00 00 00 	movabs $0x79be,%rax
    3292:	00 00 00 
    3295:	48 89 c7             	mov    %rax,%rdi
    3298:	48 b8 e0 68 00 00 00 	movabs $0x68e0,%rax
    329f:	00 00 00 
    32a2:	ff d0                	call   *%rax
    32a4:	85 c0                	test   %eax,%eax
    32a6:	78 19                	js     32c1 <linktest+0x25f>
    failexit("link lf2 lf2 succeeded! oops");
    32a8:	48 b8 1e 7a 00 00 00 	movabs $0x7a1e,%rax
    32af:	00 00 00 
    32b2:	48 89 c7             	mov    %rax,%rdi
    32b5:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    32bc:	00 00 00 
    32bf:	ff d0                	call   *%rax
  }

  unlink("lf2");
    32c1:	48 b8 be 79 00 00 00 	movabs $0x79be,%rax
    32c8:	00 00 00 
    32cb:	48 89 c7             	mov    %rax,%rdi
    32ce:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    32d5:	00 00 00 
    32d8:	ff d0                	call   *%rax
  if(link("lf2", "lf1") >= 0){
    32da:	48 b8 ba 79 00 00 00 	movabs $0x79ba,%rax
    32e1:	00 00 00 
    32e4:	48 89 c6             	mov    %rax,%rsi
    32e7:	48 b8 be 79 00 00 00 	movabs $0x79be,%rax
    32ee:	00 00 00 
    32f1:	48 89 c7             	mov    %rax,%rdi
    32f4:	48 b8 e0 68 00 00 00 	movabs $0x68e0,%rax
    32fb:	00 00 00 
    32fe:	ff d0                	call   *%rax
    3300:	85 c0                	test   %eax,%eax
    3302:	78 19                	js     331d <linktest+0x2bb>
    failexit("link non-existant succeeded! oops");
    3304:	48 b8 40 7a 00 00 00 	movabs $0x7a40,%rax
    330b:	00 00 00 
    330e:	48 89 c7             	mov    %rax,%rdi
    3311:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3318:	00 00 00 
    331b:	ff d0                	call   *%rax
  }

  if(link(".", "lf1") >= 0){
    331d:	48 b8 ba 79 00 00 00 	movabs $0x79ba,%rax
    3324:	00 00 00 
    3327:	48 89 c6             	mov    %rax,%rsi
    332a:	48 b8 62 7a 00 00 00 	movabs $0x7a62,%rax
    3331:	00 00 00 
    3334:	48 89 c7             	mov    %rax,%rdi
    3337:	48 b8 e0 68 00 00 00 	movabs $0x68e0,%rax
    333e:	00 00 00 
    3341:	ff d0                	call   *%rax
    3343:	85 c0                	test   %eax,%eax
    3345:	78 19                	js     3360 <linktest+0x2fe>
    failexit("link . lf1 succeeded! oops");
    3347:	48 b8 64 7a 00 00 00 	movabs $0x7a64,%rax
    334e:	00 00 00 
    3351:	48 89 c7             	mov    %rax,%rdi
    3354:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    335b:	00 00 00 
    335e:	ff d0                	call   *%rax
  }

  printf(1, "linktest ok\n");
    3360:	48 b8 7f 7a 00 00 00 	movabs $0x7a7f,%rax
    3367:	00 00 00 
    336a:	48 89 c6             	mov    %rax,%rsi
    336d:	bf 01 00 00 00       	mov    $0x1,%edi
    3372:	b8 00 00 00 00       	mov    $0x0,%eax
    3377:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    337e:	00 00 00 
    3381:	ff d2                	call   *%rdx
}
    3383:	90                   	nop
    3384:	c9                   	leave
    3385:	c3                   	ret

0000000000003386 <concreate>:

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    3386:	f3 0f 1e fa          	endbr64
    338a:	55                   	push   %rbp
    338b:	48 89 e5             	mov    %rsp,%rbp
    338e:	48 83 ec 50          	sub    $0x50,%rsp
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    3392:	48 b8 8c 7a 00 00 00 	movabs $0x7a8c,%rax
    3399:	00 00 00 
    339c:	48 89 c6             	mov    %rax,%rsi
    339f:	bf 01 00 00 00       	mov    $0x1,%edi
    33a4:	b8 00 00 00 00       	mov    $0x0,%eax
    33a9:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    33b0:	00 00 00 
    33b3:	ff d2                	call   *%rdx
  file[0] = 'C';
    33b5:	c6 45 ed 43          	movb   $0x43,-0x13(%rbp)
  file[2] = '\0';
    33b9:	c6 45 ef 00          	movb   $0x0,-0x11(%rbp)
  for(i = 0; i < 40; i++){
    33bd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    33c4:	e9 5e 01 00 00       	jmp    3527 <concreate+0x1a1>
    file[1] = '0' + i;
    33c9:	8b 45 fc             	mov    -0x4(%rbp),%eax
    33cc:	83 c0 30             	add    $0x30,%eax
    33cf:	88 45 ee             	mov    %al,-0x12(%rbp)
    unlink(file);
    33d2:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    33d6:	48 89 c7             	mov    %rax,%rdi
    33d9:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    33e0:	00 00 00 
    33e3:	ff d0                	call   *%rax
    pid = fork();
    33e5:	48 b8 37 68 00 00 00 	movabs $0x6837,%rax
    33ec:	00 00 00 
    33ef:	ff d0                	call   *%rax
    33f1:	89 45 f0             	mov    %eax,-0x10(%rbp)
    if(pid && (i % 3) == 1){
    33f4:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    33f8:	74 4f                	je     3449 <concreate+0xc3>
    33fa:	8b 4d fc             	mov    -0x4(%rbp),%ecx
    33fd:	48 63 c1             	movslq %ecx,%rax
    3400:	48 69 c0 56 55 55 55 	imul   $0x55555556,%rax,%rax
    3407:	48 c1 e8 20          	shr    $0x20,%rax
    340b:	48 89 c2             	mov    %rax,%rdx
    340e:	89 c8                	mov    %ecx,%eax
    3410:	c1 f8 1f             	sar    $0x1f,%eax
    3413:	29 c2                	sub    %eax,%edx
    3415:	89 d0                	mov    %edx,%eax
    3417:	01 c0                	add    %eax,%eax
    3419:	01 d0                	add    %edx,%eax
    341b:	29 c1                	sub    %eax,%ecx
    341d:	89 ca                	mov    %ecx,%edx
    341f:	83 fa 01             	cmp    $0x1,%edx
    3422:	75 25                	jne    3449 <concreate+0xc3>
      link("C0", file);
    3424:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    3428:	48 89 c6             	mov    %rax,%rsi
    342b:	48 b8 9c 7a 00 00 00 	movabs $0x7a9c,%rax
    3432:	00 00 00 
    3435:	48 89 c7             	mov    %rax,%rdi
    3438:	48 b8 e0 68 00 00 00 	movabs $0x68e0,%rax
    343f:	00 00 00 
    3442:	ff d0                	call   *%rax
    3444:	e9 bc 00 00 00       	jmp    3505 <concreate+0x17f>
    } else if(pid == 0 && (i % 5) == 1){
    3449:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    344d:	75 4e                	jne    349d <concreate+0x117>
    344f:	8b 4d fc             	mov    -0x4(%rbp),%ecx
    3452:	48 63 c1             	movslq %ecx,%rax
    3455:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
    345c:	48 c1 e8 20          	shr    $0x20,%rax
    3460:	89 c2                	mov    %eax,%edx
    3462:	d1 fa                	sar    $1,%edx
    3464:	89 c8                	mov    %ecx,%eax
    3466:	c1 f8 1f             	sar    $0x1f,%eax
    3469:	29 c2                	sub    %eax,%edx
    346b:	89 d0                	mov    %edx,%eax
    346d:	c1 e0 02             	shl    $0x2,%eax
    3470:	01 d0                	add    %edx,%eax
    3472:	29 c1                	sub    %eax,%ecx
    3474:	89 ca                	mov    %ecx,%edx
    3476:	83 fa 01             	cmp    $0x1,%edx
    3479:	75 22                	jne    349d <concreate+0x117>
      link("C0", file);
    347b:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    347f:	48 89 c6             	mov    %rax,%rsi
    3482:	48 b8 9c 7a 00 00 00 	movabs $0x7a9c,%rax
    3489:	00 00 00 
    348c:	48 89 c7             	mov    %rax,%rdi
    348f:	48 b8 e0 68 00 00 00 	movabs $0x68e0,%rax
    3496:	00 00 00 
    3499:	ff d0                	call   *%rax
    349b:	eb 68                	jmp    3505 <concreate+0x17f>
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    349d:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    34a1:	be 02 02 00 00       	mov    $0x202,%esi
    34a6:	48 89 c7             	mov    %rax,%rdi
    34a9:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    34b0:	00 00 00 
    34b3:	ff d0                	call   *%rax
    34b5:	89 45 f4             	mov    %eax,-0xc(%rbp)
      if(fd < 0){
    34b8:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    34bc:	79 36                	jns    34f4 <concreate+0x16e>
        printf(1, "concreate create %s failed\n", file);
    34be:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    34c2:	48 89 c2             	mov    %rax,%rdx
    34c5:	48 b8 9f 7a 00 00 00 	movabs $0x7a9f,%rax
    34cc:	00 00 00 
    34cf:	48 89 c6             	mov    %rax,%rsi
    34d2:	bf 01 00 00 00       	mov    $0x1,%edi
    34d7:	b8 00 00 00 00       	mov    $0x0,%eax
    34dc:	48 b9 55 6b 00 00 00 	movabs $0x6b55,%rcx
    34e3:	00 00 00 
    34e6:	ff d1                	call   *%rcx
        exit();
    34e8:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    34ef:	00 00 00 
    34f2:	ff d0                	call   *%rax
      }
      close(fd);
    34f4:	8b 45 f4             	mov    -0xc(%rbp),%eax
    34f7:	89 c7                	mov    %eax,%edi
    34f9:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    3500:	00 00 00 
    3503:	ff d0                	call   *%rax
    }
    if(pid == 0)
    3505:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    3509:	75 0c                	jne    3517 <concreate+0x191>
      exit();
    350b:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    3512:	00 00 00 
    3515:	ff d0                	call   *%rax
    else
      wait();
    3517:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    351e:	00 00 00 
    3521:	ff d0                	call   *%rax
  for(i = 0; i < 40; i++){
    3523:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    3527:	83 7d fc 27          	cmpl   $0x27,-0x4(%rbp)
    352b:	0f 8e 98 fe ff ff    	jle    33c9 <concreate+0x43>
  }

  memset(fa, 0, sizeof(fa));
    3531:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
    3535:	ba 28 00 00 00       	mov    $0x28,%edx
    353a:	be 00 00 00 00       	mov    $0x0,%esi
    353f:	48 89 c7             	mov    %rax,%rdi
    3542:	48 b8 0f 66 00 00 00 	movabs $0x660f,%rax
    3549:	00 00 00 
    354c:	ff d0                	call   *%rax
  fd = open(".", 0);
    354e:	be 00 00 00 00       	mov    $0x0,%esi
    3553:	48 b8 62 7a 00 00 00 	movabs $0x7a62,%rax
    355a:	00 00 00 
    355d:	48 89 c7             	mov    %rax,%rdi
    3560:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    3567:	00 00 00 
    356a:	ff d0                	call   *%rax
    356c:	89 45 f4             	mov    %eax,-0xc(%rbp)
  n = 0;
    356f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  while(read(fd, &de, sizeof(de)) > 0){
    3576:	e9 d3 00 00 00       	jmp    364e <concreate+0x2c8>
    if(de.inum == 0)
    357b:	0f b7 45 b0          	movzwl -0x50(%rbp),%eax
    357f:	66 85 c0             	test   %ax,%ax
    3582:	0f 84 c5 00 00 00    	je     364d <concreate+0x2c7>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    3588:	0f b6 45 b2          	movzbl -0x4e(%rbp),%eax
    358c:	3c 43                	cmp    $0x43,%al
    358e:	0f 85 ba 00 00 00    	jne    364e <concreate+0x2c8>
    3594:	0f b6 45 b4          	movzbl -0x4c(%rbp),%eax
    3598:	84 c0                	test   %al,%al
    359a:	0f 85 ae 00 00 00    	jne    364e <concreate+0x2c8>
      i = de.name[1] - '0';
    35a0:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
    35a4:	0f be c0             	movsbl %al,%eax
    35a7:	83 e8 30             	sub    $0x30,%eax
    35aa:	89 45 fc             	mov    %eax,-0x4(%rbp)
      if(i < 0 || i >= sizeof(fa)){
    35ad:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    35b1:	78 08                	js     35bb <concreate+0x235>
    35b3:	8b 45 fc             	mov    -0x4(%rbp),%eax
    35b6:	83 f8 27             	cmp    $0x27,%eax
    35b9:	76 3a                	jbe    35f5 <concreate+0x26f>
        printf(1, "concreate weird file %s\n", de.name);
    35bb:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
    35bf:	48 83 c0 02          	add    $0x2,%rax
    35c3:	48 89 c2             	mov    %rax,%rdx
    35c6:	48 b8 bb 7a 00 00 00 	movabs $0x7abb,%rax
    35cd:	00 00 00 
    35d0:	48 89 c6             	mov    %rax,%rsi
    35d3:	bf 01 00 00 00       	mov    $0x1,%edi
    35d8:	b8 00 00 00 00       	mov    $0x0,%eax
    35dd:	48 b9 55 6b 00 00 00 	movabs $0x6b55,%rcx
    35e4:	00 00 00 
    35e7:	ff d1                	call   *%rcx
        exit();
    35e9:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    35f0:	00 00 00 
    35f3:	ff d0                	call   *%rax
      }
      if(fa[i]){
    35f5:	8b 45 fc             	mov    -0x4(%rbp),%eax
    35f8:	48 98                	cltq
    35fa:	0f b6 44 05 c0       	movzbl -0x40(%rbp,%rax,1),%eax
    35ff:	84 c0                	test   %al,%al
    3601:	74 3a                	je     363d <concreate+0x2b7>
        printf(1, "concreate duplicate file %s\n", de.name);
    3603:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
    3607:	48 83 c0 02          	add    $0x2,%rax
    360b:	48 89 c2             	mov    %rax,%rdx
    360e:	48 b8 d4 7a 00 00 00 	movabs $0x7ad4,%rax
    3615:	00 00 00 
    3618:	48 89 c6             	mov    %rax,%rsi
    361b:	bf 01 00 00 00       	mov    $0x1,%edi
    3620:	b8 00 00 00 00       	mov    $0x0,%eax
    3625:	48 b9 55 6b 00 00 00 	movabs $0x6b55,%rcx
    362c:	00 00 00 
    362f:	ff d1                	call   *%rcx
        exit();
    3631:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    3638:	00 00 00 
    363b:	ff d0                	call   *%rax
      }
      fa[i] = 1;
    363d:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3640:	48 98                	cltq
    3642:	c6 44 05 c0 01       	movb   $0x1,-0x40(%rbp,%rax,1)
      n++;
    3647:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    364b:	eb 01                	jmp    364e <concreate+0x2c8>
      continue;
    364d:	90                   	nop
  while(read(fd, &de, sizeof(de)) > 0){
    364e:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
    3652:	8b 45 f4             	mov    -0xc(%rbp),%eax
    3655:	ba 10 00 00 00       	mov    $0x10,%edx
    365a:	48 89 ce             	mov    %rcx,%rsi
    365d:	89 c7                	mov    %eax,%edi
    365f:	48 b8 6b 68 00 00 00 	movabs $0x686b,%rax
    3666:	00 00 00 
    3669:	ff d0                	call   *%rax
    366b:	85 c0                	test   %eax,%eax
    366d:	0f 8f 08 ff ff ff    	jg     357b <concreate+0x1f5>
    }
  }
  close(fd);
    3673:	8b 45 f4             	mov    -0xc(%rbp),%eax
    3676:	89 c7                	mov    %eax,%edi
    3678:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    367f:	00 00 00 
    3682:	ff d0                	call   *%rax

  if(n != 40){
    3684:	83 7d f8 28          	cmpl   $0x28,-0x8(%rbp)
    3688:	74 19                	je     36a3 <concreate+0x31d>
    failexit("concreate not enough files in directory listing");
    368a:	48 b8 f8 7a 00 00 00 	movabs $0x7af8,%rax
    3691:	00 00 00 
    3694:	48 89 c7             	mov    %rax,%rdi
    3697:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    369e:	00 00 00 
    36a1:	ff d0                	call   *%rax
  }

  for(i = 0; i < 40; i++){
    36a3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    36aa:	e9 a6 01 00 00       	jmp    3855 <concreate+0x4cf>
    file[1] = '0' + i;
    36af:	8b 45 fc             	mov    -0x4(%rbp),%eax
    36b2:	83 c0 30             	add    $0x30,%eax
    36b5:	88 45 ee             	mov    %al,-0x12(%rbp)
    pid = fork();
    36b8:	48 b8 37 68 00 00 00 	movabs $0x6837,%rax
    36bf:	00 00 00 
    36c2:	ff d0                	call   *%rax
    36c4:	89 45 f0             	mov    %eax,-0x10(%rbp)
    if(pid < 0){
    36c7:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    36cb:	79 19                	jns    36e6 <concreate+0x360>
      failexit("fork");
    36cd:	48 b8 f7 72 00 00 00 	movabs $0x72f7,%rax
    36d4:	00 00 00 
    36d7:	48 89 c7             	mov    %rax,%rdi
    36da:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    36e1:	00 00 00 
    36e4:	ff d0                	call   *%rax
    }
    if(((i % 3) == 0 && pid == 0) ||
    36e6:	8b 4d fc             	mov    -0x4(%rbp),%ecx
    36e9:	48 63 c1             	movslq %ecx,%rax
    36ec:	48 69 c0 56 55 55 55 	imul   $0x55555556,%rax,%rax
    36f3:	48 c1 e8 20          	shr    $0x20,%rax
    36f7:	48 89 c2             	mov    %rax,%rdx
    36fa:	89 c8                	mov    %ecx,%eax
    36fc:	c1 f8 1f             	sar    $0x1f,%eax
    36ff:	29 c2                	sub    %eax,%edx
    3701:	89 d0                	mov    %edx,%eax
    3703:	01 c0                	add    %eax,%eax
    3705:	01 d0                	add    %edx,%eax
    3707:	29 c1                	sub    %eax,%ecx
    3709:	89 ca                	mov    %ecx,%edx
    370b:	85 d2                	test   %edx,%edx
    370d:	75 06                	jne    3715 <concreate+0x38f>
    370f:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    3713:	74 38                	je     374d <concreate+0x3c7>
       ((i % 3) == 1 && pid != 0)){
    3715:	8b 4d fc             	mov    -0x4(%rbp),%ecx
    3718:	48 63 c1             	movslq %ecx,%rax
    371b:	48 69 c0 56 55 55 55 	imul   $0x55555556,%rax,%rax
    3722:	48 c1 e8 20          	shr    $0x20,%rax
    3726:	48 89 c2             	mov    %rax,%rdx
    3729:	89 c8                	mov    %ecx,%eax
    372b:	c1 f8 1f             	sar    $0x1f,%eax
    372e:	29 c2                	sub    %eax,%edx
    3730:	89 d0                	mov    %edx,%eax
    3732:	01 c0                	add    %eax,%eax
    3734:	01 d0                	add    %edx,%eax
    3736:	29 c1                	sub    %eax,%ecx
    3738:	89 ca                	mov    %ecx,%edx
    if(((i % 3) == 0 && pid == 0) ||
    373a:	83 fa 01             	cmp    $0x1,%edx
    373d:	0f 85 a4 00 00 00    	jne    37e7 <concreate+0x461>
       ((i % 3) == 1 && pid != 0)){
    3743:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    3747:	0f 84 9a 00 00 00    	je     37e7 <concreate+0x461>
      close(open(file, 0));
    374d:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    3751:	be 00 00 00 00       	mov    $0x0,%esi
    3756:	48 89 c7             	mov    %rax,%rdi
    3759:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    3760:	00 00 00 
    3763:	ff d0                	call   *%rax
    3765:	89 c7                	mov    %eax,%edi
    3767:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    376e:	00 00 00 
    3771:	ff d0                	call   *%rax
      close(open(file, 0));
    3773:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    3777:	be 00 00 00 00       	mov    $0x0,%esi
    377c:	48 89 c7             	mov    %rax,%rdi
    377f:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    3786:	00 00 00 
    3789:	ff d0                	call   *%rax
    378b:	89 c7                	mov    %eax,%edi
    378d:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    3794:	00 00 00 
    3797:	ff d0                	call   *%rax
      close(open(file, 0));
    3799:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    379d:	be 00 00 00 00       	mov    $0x0,%esi
    37a2:	48 89 c7             	mov    %rax,%rdi
    37a5:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    37ac:	00 00 00 
    37af:	ff d0                	call   *%rax
    37b1:	89 c7                	mov    %eax,%edi
    37b3:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    37ba:	00 00 00 
    37bd:	ff d0                	call   *%rax
      close(open(file, 0));
    37bf:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    37c3:	be 00 00 00 00       	mov    $0x0,%esi
    37c8:	48 89 c7             	mov    %rax,%rdi
    37cb:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    37d2:	00 00 00 
    37d5:	ff d0                	call   *%rax
    37d7:	89 c7                	mov    %eax,%edi
    37d9:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    37e0:	00 00 00 
    37e3:	ff d0                	call   *%rax
    37e5:	eb 4c                	jmp    3833 <concreate+0x4ad>
    } else {
      unlink(file);
    37e7:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    37eb:	48 89 c7             	mov    %rax,%rdi
    37ee:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    37f5:	00 00 00 
    37f8:	ff d0                	call   *%rax
      unlink(file);
    37fa:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    37fe:	48 89 c7             	mov    %rax,%rdi
    3801:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    3808:	00 00 00 
    380b:	ff d0                	call   *%rax
      unlink(file);
    380d:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    3811:	48 89 c7             	mov    %rax,%rdi
    3814:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    381b:	00 00 00 
    381e:	ff d0                	call   *%rax
      unlink(file);
    3820:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    3824:	48 89 c7             	mov    %rax,%rdi
    3827:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    382e:	00 00 00 
    3831:	ff d0                	call   *%rax
    }
    if(pid == 0)
    3833:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    3837:	75 0c                	jne    3845 <concreate+0x4bf>
      exit();
    3839:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    3840:	00 00 00 
    3843:	ff d0                	call   *%rax
    else
      wait();
    3845:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    384c:	00 00 00 
    384f:	ff d0                	call   *%rax
  for(i = 0; i < 40; i++){
    3851:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    3855:	83 7d fc 27          	cmpl   $0x27,-0x4(%rbp)
    3859:	0f 8e 50 fe ff ff    	jle    36af <concreate+0x329>
  }

  printf(1, "concreate ok\n");
    385f:	48 b8 28 7b 00 00 00 	movabs $0x7b28,%rax
    3866:	00 00 00 
    3869:	48 89 c6             	mov    %rax,%rsi
    386c:	bf 01 00 00 00       	mov    $0x1,%edi
    3871:	b8 00 00 00 00       	mov    $0x0,%eax
    3876:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    387d:	00 00 00 
    3880:	ff d2                	call   *%rdx
}
    3882:	90                   	nop
    3883:	c9                   	leave
    3884:	c3                   	ret

0000000000003885 <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink()
{
    3885:	f3 0f 1e fa          	endbr64
    3889:	55                   	push   %rbp
    388a:	48 89 e5             	mov    %rsp,%rbp
    388d:	48 83 ec 10          	sub    $0x10,%rsp
  int pid, i;

  printf(1, "linkunlink test\n");
    3891:	48 b8 36 7b 00 00 00 	movabs $0x7b36,%rax
    3898:	00 00 00 
    389b:	48 89 c6             	mov    %rax,%rsi
    389e:	bf 01 00 00 00       	mov    $0x1,%edi
    38a3:	b8 00 00 00 00       	mov    $0x0,%eax
    38a8:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    38af:	00 00 00 
    38b2:	ff d2                	call   *%rdx

  unlink("x");
    38b4:	48 b8 e6 76 00 00 00 	movabs $0x76e6,%rax
    38bb:	00 00 00 
    38be:	48 89 c7             	mov    %rax,%rdi
    38c1:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    38c8:	00 00 00 
    38cb:	ff d0                	call   *%rax
  pid = fork();
    38cd:	48 b8 37 68 00 00 00 	movabs $0x6837,%rax
    38d4:	00 00 00 
    38d7:	ff d0                	call   *%rax
    38d9:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(pid < 0){
    38dc:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    38e0:	79 19                	jns    38fb <linkunlink+0x76>
    failexit("fork");
    38e2:	48 b8 f7 72 00 00 00 	movabs $0x72f7,%rax
    38e9:	00 00 00 
    38ec:	48 89 c7             	mov    %rax,%rdi
    38ef:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    38f6:	00 00 00 
    38f9:	ff d0                	call   *%rax
  }

  unsigned int x = (pid ? 1 : 97);
    38fb:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    38ff:	74 07                	je     3908 <linkunlink+0x83>
    3901:	b8 01 00 00 00       	mov    $0x1,%eax
    3906:	eb 05                	jmp    390d <linkunlink+0x88>
    3908:	b8 61 00 00 00       	mov    $0x61,%eax
    390d:	89 45 f8             	mov    %eax,-0x8(%rbp)
  for(i = 0; i < 100; i++){
    3910:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    3917:	e9 cd 00 00 00       	jmp    39e9 <linkunlink+0x164>
    x = x * 1103515245 + 12345;
    391c:	8b 45 f8             	mov    -0x8(%rbp),%eax
    391f:	69 c0 6d 4e c6 41    	imul   $0x41c64e6d,%eax,%eax
    3925:	05 39 30 00 00       	add    $0x3039,%eax
    392a:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if((x % 3) == 0){
    392d:	8b 4d f8             	mov    -0x8(%rbp),%ecx
    3930:	89 ca                	mov    %ecx,%edx
    3932:	b8 ab aa aa aa       	mov    $0xaaaaaaab,%eax
    3937:	48 0f af c2          	imul   %rdx,%rax
    393b:	48 c1 e8 20          	shr    $0x20,%rax
    393f:	89 c2                	mov    %eax,%edx
    3941:	d1 ea                	shr    $1,%edx
    3943:	89 d0                	mov    %edx,%eax
    3945:	01 c0                	add    %eax,%eax
    3947:	01 d0                	add    %edx,%eax
    3949:	29 c1                	sub    %eax,%ecx
    394b:	89 ca                	mov    %ecx,%edx
    394d:	85 d2                	test   %edx,%edx
    394f:	75 2e                	jne    397f <linkunlink+0xfa>
      close(open("x", O_RDWR | O_CREATE));
    3951:	be 02 02 00 00       	mov    $0x202,%esi
    3956:	48 b8 e6 76 00 00 00 	movabs $0x76e6,%rax
    395d:	00 00 00 
    3960:	48 89 c7             	mov    %rax,%rdi
    3963:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    396a:	00 00 00 
    396d:	ff d0                	call   *%rax
    396f:	89 c7                	mov    %eax,%edi
    3971:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    3978:	00 00 00 
    397b:	ff d0                	call   *%rax
    397d:	eb 66                	jmp    39e5 <linkunlink+0x160>
    } else if((x % 3) == 1){
    397f:	8b 4d f8             	mov    -0x8(%rbp),%ecx
    3982:	89 ca                	mov    %ecx,%edx
    3984:	b8 ab aa aa aa       	mov    $0xaaaaaaab,%eax
    3989:	48 0f af c2          	imul   %rdx,%rax
    398d:	48 c1 e8 20          	shr    $0x20,%rax
    3991:	89 c2                	mov    %eax,%edx
    3993:	d1 ea                	shr    $1,%edx
    3995:	89 d0                	mov    %edx,%eax
    3997:	01 c0                	add    %eax,%eax
    3999:	01 d0                	add    %edx,%eax
    399b:	29 c1                	sub    %eax,%ecx
    399d:	89 ca                	mov    %ecx,%edx
    399f:	83 fa 01             	cmp    $0x1,%edx
    39a2:	75 28                	jne    39cc <linkunlink+0x147>
      link("cat", "x");
    39a4:	48 b8 e6 76 00 00 00 	movabs $0x76e6,%rax
    39ab:	00 00 00 
    39ae:	48 89 c6             	mov    %rax,%rsi
    39b1:	48 b8 47 7b 00 00 00 	movabs $0x7b47,%rax
    39b8:	00 00 00 
    39bb:	48 89 c7             	mov    %rax,%rdi
    39be:	48 b8 e0 68 00 00 00 	movabs $0x68e0,%rax
    39c5:	00 00 00 
    39c8:	ff d0                	call   *%rax
    39ca:	eb 19                	jmp    39e5 <linkunlink+0x160>
    } else {
      unlink("x");
    39cc:	48 b8 e6 76 00 00 00 	movabs $0x76e6,%rax
    39d3:	00 00 00 
    39d6:	48 89 c7             	mov    %rax,%rdi
    39d9:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    39e0:	00 00 00 
    39e3:	ff d0                	call   *%rax
  for(i = 0; i < 100; i++){
    39e5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    39e9:	83 7d fc 63          	cmpl   $0x63,-0x4(%rbp)
    39ed:	0f 8e 29 ff ff ff    	jle    391c <linkunlink+0x97>
    }
  }

  if(pid)
    39f3:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    39f7:	74 0e                	je     3a07 <linkunlink+0x182>
    wait();
    39f9:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    3a00:	00 00 00 
    3a03:	ff d0                	call   *%rax
    3a05:	eb 0c                	jmp    3a13 <linkunlink+0x18e>
  else
    exit();
    3a07:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    3a0e:	00 00 00 
    3a11:	ff d0                	call   *%rax

  printf(1, "linkunlink ok\n");
    3a13:	48 b8 4b 7b 00 00 00 	movabs $0x7b4b,%rax
    3a1a:	00 00 00 
    3a1d:	48 89 c6             	mov    %rax,%rsi
    3a20:	bf 01 00 00 00       	mov    $0x1,%edi
    3a25:	b8 00 00 00 00       	mov    $0x0,%eax
    3a2a:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    3a31:	00 00 00 
    3a34:	ff d2                	call   *%rdx
}
    3a36:	90                   	nop
    3a37:	c9                   	leave
    3a38:	c3                   	ret

0000000000003a39 <bigdir>:

// directory that uses indirect blocks
void
bigdir(void)
{
    3a39:	f3 0f 1e fa          	endbr64
    3a3d:	55                   	push   %rbp
    3a3e:	48 89 e5             	mov    %rsp,%rbp
    3a41:	48 83 ec 20          	sub    $0x20,%rsp
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
    3a45:	48 b8 5a 7b 00 00 00 	movabs $0x7b5a,%rax
    3a4c:	00 00 00 
    3a4f:	48 89 c6             	mov    %rax,%rsi
    3a52:	bf 01 00 00 00       	mov    $0x1,%edi
    3a57:	b8 00 00 00 00       	mov    $0x0,%eax
    3a5c:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    3a63:	00 00 00 
    3a66:	ff d2                	call   *%rdx
  unlink("bd");
    3a68:	48 b8 67 7b 00 00 00 	movabs $0x7b67,%rax
    3a6f:	00 00 00 
    3a72:	48 89 c7             	mov    %rax,%rdi
    3a75:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    3a7c:	00 00 00 
    3a7f:	ff d0                	call   *%rax

  fd = open("bd", O_CREATE);
    3a81:	be 00 02 00 00       	mov    $0x200,%esi
    3a86:	48 b8 67 7b 00 00 00 	movabs $0x7b67,%rax
    3a8d:	00 00 00 
    3a90:	48 89 c7             	mov    %rax,%rdi
    3a93:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    3a9a:	00 00 00 
    3a9d:	ff d0                	call   *%rax
    3a9f:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(fd < 0){
    3aa2:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    3aa6:	79 19                	jns    3ac1 <bigdir+0x88>
    failexit("bigdir create");
    3aa8:	48 b8 6a 7b 00 00 00 	movabs $0x7b6a,%rax
    3aaf:	00 00 00 
    3ab2:	48 89 c7             	mov    %rax,%rdi
    3ab5:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3abc:	00 00 00 
    3abf:	ff d0                	call   *%rax
  }
  close(fd);
    3ac1:	8b 45 f8             	mov    -0x8(%rbp),%eax
    3ac4:	89 c7                	mov    %eax,%edi
    3ac6:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    3acd:	00 00 00 
    3ad0:	ff d0                	call   *%rax

  for(i = 0; i < 500; i++){
    3ad2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    3ad9:	eb 77                	jmp    3b52 <bigdir+0x119>
    name[0] = 'x';
    3adb:	c6 45 ee 78          	movb   $0x78,-0x12(%rbp)
    name[1] = '0' + (i / 64);
    3adf:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3ae2:	8d 50 3f             	lea    0x3f(%rax),%edx
    3ae5:	85 c0                	test   %eax,%eax
    3ae7:	0f 48 c2             	cmovs  %edx,%eax
    3aea:	c1 f8 06             	sar    $0x6,%eax
    3aed:	83 c0 30             	add    $0x30,%eax
    3af0:	88 45 ef             	mov    %al,-0x11(%rbp)
    name[2] = '0' + (i % 64);
    3af3:	8b 55 fc             	mov    -0x4(%rbp),%edx
    3af6:	89 d0                	mov    %edx,%eax
    3af8:	c1 f8 1f             	sar    $0x1f,%eax
    3afb:	c1 e8 1a             	shr    $0x1a,%eax
    3afe:	01 c2                	add    %eax,%edx
    3b00:	83 e2 3f             	and    $0x3f,%edx
    3b03:	29 c2                	sub    %eax,%edx
    3b05:	89 d0                	mov    %edx,%eax
    3b07:	83 c0 30             	add    $0x30,%eax
    3b0a:	88 45 f0             	mov    %al,-0x10(%rbp)
    name[3] = '\0';
    3b0d:	c6 45 f1 00          	movb   $0x0,-0xf(%rbp)
    if(link("bd", name) != 0){
    3b11:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
    3b15:	48 89 c6             	mov    %rax,%rsi
    3b18:	48 b8 67 7b 00 00 00 	movabs $0x7b67,%rax
    3b1f:	00 00 00 
    3b22:	48 89 c7             	mov    %rax,%rdi
    3b25:	48 b8 e0 68 00 00 00 	movabs $0x68e0,%rax
    3b2c:	00 00 00 
    3b2f:	ff d0                	call   *%rax
    3b31:	85 c0                	test   %eax,%eax
    3b33:	74 19                	je     3b4e <bigdir+0x115>
      failexit("bigdir link");
    3b35:	48 b8 78 7b 00 00 00 	movabs $0x7b78,%rax
    3b3c:	00 00 00 
    3b3f:	48 89 c7             	mov    %rax,%rdi
    3b42:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3b49:	00 00 00 
    3b4c:	ff d0                	call   *%rax
  for(i = 0; i < 500; i++){
    3b4e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    3b52:	81 7d fc f3 01 00 00 	cmpl   $0x1f3,-0x4(%rbp)
    3b59:	7e 80                	jle    3adb <bigdir+0xa2>
    }
  }

  unlink("bd");
    3b5b:	48 b8 67 7b 00 00 00 	movabs $0x7b67,%rax
    3b62:	00 00 00 
    3b65:	48 89 c7             	mov    %rax,%rdi
    3b68:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    3b6f:	00 00 00 
    3b72:	ff d0                	call   *%rax
  for(i = 0; i < 500; i++){
    3b74:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    3b7b:	eb 6a                	jmp    3be7 <bigdir+0x1ae>
    name[0] = 'x';
    3b7d:	c6 45 ee 78          	movb   $0x78,-0x12(%rbp)
    name[1] = '0' + (i / 64);
    3b81:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3b84:	8d 50 3f             	lea    0x3f(%rax),%edx
    3b87:	85 c0                	test   %eax,%eax
    3b89:	0f 48 c2             	cmovs  %edx,%eax
    3b8c:	c1 f8 06             	sar    $0x6,%eax
    3b8f:	83 c0 30             	add    $0x30,%eax
    3b92:	88 45 ef             	mov    %al,-0x11(%rbp)
    name[2] = '0' + (i % 64);
    3b95:	8b 55 fc             	mov    -0x4(%rbp),%edx
    3b98:	89 d0                	mov    %edx,%eax
    3b9a:	c1 f8 1f             	sar    $0x1f,%eax
    3b9d:	c1 e8 1a             	shr    $0x1a,%eax
    3ba0:	01 c2                	add    %eax,%edx
    3ba2:	83 e2 3f             	and    $0x3f,%edx
    3ba5:	29 c2                	sub    %eax,%edx
    3ba7:	89 d0                	mov    %edx,%eax
    3ba9:	83 c0 30             	add    $0x30,%eax
    3bac:	88 45 f0             	mov    %al,-0x10(%rbp)
    name[3] = '\0';
    3baf:	c6 45 f1 00          	movb   $0x0,-0xf(%rbp)
    if(unlink(name) != 0){
    3bb3:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
    3bb7:	48 89 c7             	mov    %rax,%rdi
    3bba:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    3bc1:	00 00 00 
    3bc4:	ff d0                	call   *%rax
    3bc6:	85 c0                	test   %eax,%eax
    3bc8:	74 19                	je     3be3 <bigdir+0x1aa>
      failexit("bigdir unlink failed");
    3bca:	48 b8 84 7b 00 00 00 	movabs $0x7b84,%rax
    3bd1:	00 00 00 
    3bd4:	48 89 c7             	mov    %rax,%rdi
    3bd7:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3bde:	00 00 00 
    3be1:	ff d0                	call   *%rax
  for(i = 0; i < 500; i++){
    3be3:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    3be7:	81 7d fc f3 01 00 00 	cmpl   $0x1f3,-0x4(%rbp)
    3bee:	7e 8d                	jle    3b7d <bigdir+0x144>
    }
  }

  printf(1, "bigdir ok\n");
    3bf0:	48 b8 99 7b 00 00 00 	movabs $0x7b99,%rax
    3bf7:	00 00 00 
    3bfa:	48 89 c6             	mov    %rax,%rsi
    3bfd:	bf 01 00 00 00       	mov    $0x1,%edi
    3c02:	b8 00 00 00 00       	mov    $0x0,%eax
    3c07:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    3c0e:	00 00 00 
    3c11:	ff d2                	call   *%rdx
}
    3c13:	90                   	nop
    3c14:	c9                   	leave
    3c15:	c3                   	ret

0000000000003c16 <subdir>:

void
subdir(void)
{
    3c16:	f3 0f 1e fa          	endbr64
    3c1a:	55                   	push   %rbp
    3c1b:	48 89 e5             	mov    %rsp,%rbp
    3c1e:	48 83 ec 10          	sub    $0x10,%rsp
  int fd, cc;

  printf(1, "subdir test\n");
    3c22:	48 b8 a4 7b 00 00 00 	movabs $0x7ba4,%rax
    3c29:	00 00 00 
    3c2c:	48 89 c6             	mov    %rax,%rsi
    3c2f:	bf 01 00 00 00       	mov    $0x1,%edi
    3c34:	b8 00 00 00 00       	mov    $0x0,%eax
    3c39:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    3c40:	00 00 00 
    3c43:	ff d2                	call   *%rdx

  unlink("ff");
    3c45:	48 b8 b1 7b 00 00 00 	movabs $0x7bb1,%rax
    3c4c:	00 00 00 
    3c4f:	48 89 c7             	mov    %rax,%rdi
    3c52:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    3c59:	00 00 00 
    3c5c:	ff d0                	call   *%rax
  if(mkdir("dd") != 0){
    3c5e:	48 b8 b4 7b 00 00 00 	movabs $0x7bb4,%rax
    3c65:	00 00 00 
    3c68:	48 89 c7             	mov    %rax,%rdi
    3c6b:	48 b8 ed 68 00 00 00 	movabs $0x68ed,%rax
    3c72:	00 00 00 
    3c75:	ff d0                	call   *%rax
    3c77:	85 c0                	test   %eax,%eax
    3c79:	74 19                	je     3c94 <subdir+0x7e>
    failexit("subdir mkdir dd");
    3c7b:	48 b8 b7 7b 00 00 00 	movabs $0x7bb7,%rax
    3c82:	00 00 00 
    3c85:	48 89 c7             	mov    %rax,%rdi
    3c88:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3c8f:	00 00 00 
    3c92:	ff d0                	call   *%rax
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    3c94:	be 02 02 00 00       	mov    $0x202,%esi
    3c99:	48 b8 c7 7b 00 00 00 	movabs $0x7bc7,%rax
    3ca0:	00 00 00 
    3ca3:	48 89 c7             	mov    %rax,%rdi
    3ca6:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    3cad:	00 00 00 
    3cb0:	ff d0                	call   *%rax
    3cb2:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    3cb5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    3cb9:	79 19                	jns    3cd4 <subdir+0xbe>
    failexit("create dd/ff");
    3cbb:	48 b8 cd 7b 00 00 00 	movabs $0x7bcd,%rax
    3cc2:	00 00 00 
    3cc5:	48 89 c7             	mov    %rax,%rdi
    3cc8:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3ccf:	00 00 00 
    3cd2:	ff d0                	call   *%rax
  }
  write(fd, "ff", 2);
    3cd4:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3cd7:	ba 02 00 00 00       	mov    $0x2,%edx
    3cdc:	48 b9 b1 7b 00 00 00 	movabs $0x7bb1,%rcx
    3ce3:	00 00 00 
    3ce6:	48 89 ce             	mov    %rcx,%rsi
    3ce9:	89 c7                	mov    %eax,%edi
    3ceb:	48 b8 78 68 00 00 00 	movabs $0x6878,%rax
    3cf2:	00 00 00 
    3cf5:	ff d0                	call   *%rax
  close(fd);
    3cf7:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3cfa:	89 c7                	mov    %eax,%edi
    3cfc:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    3d03:	00 00 00 
    3d06:	ff d0                	call   *%rax

  if(unlink("dd") >= 0){
    3d08:	48 b8 b4 7b 00 00 00 	movabs $0x7bb4,%rax
    3d0f:	00 00 00 
    3d12:	48 89 c7             	mov    %rax,%rdi
    3d15:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    3d1c:	00 00 00 
    3d1f:	ff d0                	call   *%rax
    3d21:	85 c0                	test   %eax,%eax
    3d23:	78 19                	js     3d3e <subdir+0x128>
    failexit("unlink dd (non-empty dir) succeeded!");
    3d25:	48 b8 e0 7b 00 00 00 	movabs $0x7be0,%rax
    3d2c:	00 00 00 
    3d2f:	48 89 c7             	mov    %rax,%rdi
    3d32:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3d39:	00 00 00 
    3d3c:	ff d0                	call   *%rax
  }

  if(mkdir("/dd/dd") != 0){
    3d3e:	48 b8 05 7c 00 00 00 	movabs $0x7c05,%rax
    3d45:	00 00 00 
    3d48:	48 89 c7             	mov    %rax,%rdi
    3d4b:	48 b8 ed 68 00 00 00 	movabs $0x68ed,%rax
    3d52:	00 00 00 
    3d55:	ff d0                	call   *%rax
    3d57:	85 c0                	test   %eax,%eax
    3d59:	74 19                	je     3d74 <subdir+0x15e>
    failexit("subdir mkdir dd/dd");
    3d5b:	48 b8 0c 7c 00 00 00 	movabs $0x7c0c,%rax
    3d62:	00 00 00 
    3d65:	48 89 c7             	mov    %rax,%rdi
    3d68:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3d6f:	00 00 00 
    3d72:	ff d0                	call   *%rax
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    3d74:	be 02 02 00 00       	mov    $0x202,%esi
    3d79:	48 b8 1f 7c 00 00 00 	movabs $0x7c1f,%rax
    3d80:	00 00 00 
    3d83:	48 89 c7             	mov    %rax,%rdi
    3d86:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    3d8d:	00 00 00 
    3d90:	ff d0                	call   *%rax
    3d92:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    3d95:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    3d99:	79 19                	jns    3db4 <subdir+0x19e>
    failexit("create dd/dd/ff");
    3d9b:	48 b8 28 7c 00 00 00 	movabs $0x7c28,%rax
    3da2:	00 00 00 
    3da5:	48 89 c7             	mov    %rax,%rdi
    3da8:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3daf:	00 00 00 
    3db2:	ff d0                	call   *%rax
  }
  write(fd, "FF", 2);
    3db4:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3db7:	ba 02 00 00 00       	mov    $0x2,%edx
    3dbc:	48 b9 38 7c 00 00 00 	movabs $0x7c38,%rcx
    3dc3:	00 00 00 
    3dc6:	48 89 ce             	mov    %rcx,%rsi
    3dc9:	89 c7                	mov    %eax,%edi
    3dcb:	48 b8 78 68 00 00 00 	movabs $0x6878,%rax
    3dd2:	00 00 00 
    3dd5:	ff d0                	call   *%rax
  close(fd);
    3dd7:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3dda:	89 c7                	mov    %eax,%edi
    3ddc:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    3de3:	00 00 00 
    3de6:	ff d0                	call   *%rax

  fd = open("dd/dd/../ff", 0);
    3de8:	be 00 00 00 00       	mov    $0x0,%esi
    3ded:	48 b8 3b 7c 00 00 00 	movabs $0x7c3b,%rax
    3df4:	00 00 00 
    3df7:	48 89 c7             	mov    %rax,%rdi
    3dfa:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    3e01:	00 00 00 
    3e04:	ff d0                	call   *%rax
    3e06:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    3e09:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    3e0d:	79 19                	jns    3e28 <subdir+0x212>
    failexit("open dd/dd/../ff");
    3e0f:	48 b8 47 7c 00 00 00 	movabs $0x7c47,%rax
    3e16:	00 00 00 
    3e19:	48 89 c7             	mov    %rax,%rdi
    3e1c:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3e23:	00 00 00 
    3e26:	ff d0                	call   *%rax
  }
  cc = read(fd, buf, sizeof(buf));
    3e28:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3e2b:	ba 00 20 00 00       	mov    $0x2000,%edx
    3e30:	48 b9 00 8a 00 00 00 	movabs $0x8a00,%rcx
    3e37:	00 00 00 
    3e3a:	48 89 ce             	mov    %rcx,%rsi
    3e3d:	89 c7                	mov    %eax,%edi
    3e3f:	48 b8 6b 68 00 00 00 	movabs $0x686b,%rax
    3e46:	00 00 00 
    3e49:	ff d0                	call   *%rax
    3e4b:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(cc != 2 || buf[0] != 'f'){
    3e4e:	83 7d f8 02          	cmpl   $0x2,-0x8(%rbp)
    3e52:	75 11                	jne    3e65 <subdir+0x24f>
    3e54:	48 b8 00 8a 00 00 00 	movabs $0x8a00,%rax
    3e5b:	00 00 00 
    3e5e:	0f b6 00             	movzbl (%rax),%eax
    3e61:	3c 66                	cmp    $0x66,%al
    3e63:	74 19                	je     3e7e <subdir+0x268>
    failexit("dd/dd/../ff wrong content");
    3e65:	48 b8 58 7c 00 00 00 	movabs $0x7c58,%rax
    3e6c:	00 00 00 
    3e6f:	48 89 c7             	mov    %rax,%rdi
    3e72:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3e79:	00 00 00 
    3e7c:	ff d0                	call   *%rax
  }
  close(fd);
    3e7e:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3e81:	89 c7                	mov    %eax,%edi
    3e83:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    3e8a:	00 00 00 
    3e8d:	ff d0                	call   *%rax

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    3e8f:	48 b8 72 7c 00 00 00 	movabs $0x7c72,%rax
    3e96:	00 00 00 
    3e99:	48 89 c6             	mov    %rax,%rsi
    3e9c:	48 b8 1f 7c 00 00 00 	movabs $0x7c1f,%rax
    3ea3:	00 00 00 
    3ea6:	48 89 c7             	mov    %rax,%rdi
    3ea9:	48 b8 e0 68 00 00 00 	movabs $0x68e0,%rax
    3eb0:	00 00 00 
    3eb3:	ff d0                	call   *%rax
    3eb5:	85 c0                	test   %eax,%eax
    3eb7:	74 19                	je     3ed2 <subdir+0x2bc>
    failexit("link dd/dd/ff dd/dd/ffff");
    3eb9:	48 b8 7d 7c 00 00 00 	movabs $0x7c7d,%rax
    3ec0:	00 00 00 
    3ec3:	48 89 c7             	mov    %rax,%rdi
    3ec6:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3ecd:	00 00 00 
    3ed0:	ff d0                	call   *%rax
  }

  if(unlink("dd/dd/ff") != 0){
    3ed2:	48 b8 1f 7c 00 00 00 	movabs $0x7c1f,%rax
    3ed9:	00 00 00 
    3edc:	48 89 c7             	mov    %rax,%rdi
    3edf:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    3ee6:	00 00 00 
    3ee9:	ff d0                	call   *%rax
    3eeb:	85 c0                	test   %eax,%eax
    3eed:	74 19                	je     3f08 <subdir+0x2f2>
    failexit("unlink dd/dd/ff");
    3eef:	48 b8 96 7c 00 00 00 	movabs $0x7c96,%rax
    3ef6:	00 00 00 
    3ef9:	48 89 c7             	mov    %rax,%rdi
    3efc:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3f03:	00 00 00 
    3f06:	ff d0                	call   *%rax
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    3f08:	be 00 00 00 00       	mov    $0x0,%esi
    3f0d:	48 b8 1f 7c 00 00 00 	movabs $0x7c1f,%rax
    3f14:	00 00 00 
    3f17:	48 89 c7             	mov    %rax,%rdi
    3f1a:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    3f21:	00 00 00 
    3f24:	ff d0                	call   *%rax
    3f26:	85 c0                	test   %eax,%eax
    3f28:	78 19                	js     3f43 <subdir+0x32d>
    failexit("open (unlinked) dd/dd/ff succeeded");
    3f2a:	48 b8 a8 7c 00 00 00 	movabs $0x7ca8,%rax
    3f31:	00 00 00 
    3f34:	48 89 c7             	mov    %rax,%rdi
    3f37:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3f3e:	00 00 00 
    3f41:	ff d0                	call   *%rax
  }

  if(chdir("dd") != 0){
    3f43:	48 b8 b4 7b 00 00 00 	movabs $0x7bb4,%rax
    3f4a:	00 00 00 
    3f4d:	48 89 c7             	mov    %rax,%rdi
    3f50:	48 b8 fa 68 00 00 00 	movabs $0x68fa,%rax
    3f57:	00 00 00 
    3f5a:	ff d0                	call   *%rax
    3f5c:	85 c0                	test   %eax,%eax
    3f5e:	74 19                	je     3f79 <subdir+0x363>
    failexit("chdir dd");
    3f60:	48 b8 cb 7c 00 00 00 	movabs $0x7ccb,%rax
    3f67:	00 00 00 
    3f6a:	48 89 c7             	mov    %rax,%rdi
    3f6d:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3f74:	00 00 00 
    3f77:	ff d0                	call   *%rax
  }
  if(chdir("dd/../../dd") != 0){
    3f79:	48 b8 d4 7c 00 00 00 	movabs $0x7cd4,%rax
    3f80:	00 00 00 
    3f83:	48 89 c7             	mov    %rax,%rdi
    3f86:	48 b8 fa 68 00 00 00 	movabs $0x68fa,%rax
    3f8d:	00 00 00 
    3f90:	ff d0                	call   *%rax
    3f92:	85 c0                	test   %eax,%eax
    3f94:	74 19                	je     3faf <subdir+0x399>
    failexit("chdir dd/../../dd");
    3f96:	48 b8 e0 7c 00 00 00 	movabs $0x7ce0,%rax
    3f9d:	00 00 00 
    3fa0:	48 89 c7             	mov    %rax,%rdi
    3fa3:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3faa:	00 00 00 
    3fad:	ff d0                	call   *%rax
  }
  if(chdir("dd/../../../dd") != 0){
    3faf:	48 b8 f2 7c 00 00 00 	movabs $0x7cf2,%rax
    3fb6:	00 00 00 
    3fb9:	48 89 c7             	mov    %rax,%rdi
    3fbc:	48 b8 fa 68 00 00 00 	movabs $0x68fa,%rax
    3fc3:	00 00 00 
    3fc6:	ff d0                	call   *%rax
    3fc8:	85 c0                	test   %eax,%eax
    3fca:	74 19                	je     3fe5 <subdir+0x3cf>
    failexit("chdir dd/../../dd");
    3fcc:	48 b8 e0 7c 00 00 00 	movabs $0x7ce0,%rax
    3fd3:	00 00 00 
    3fd6:	48 89 c7             	mov    %rax,%rdi
    3fd9:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3fe0:	00 00 00 
    3fe3:	ff d0                	call   *%rax
  }
  if(chdir("./..") != 0){
    3fe5:	48 b8 01 7d 00 00 00 	movabs $0x7d01,%rax
    3fec:	00 00 00 
    3fef:	48 89 c7             	mov    %rax,%rdi
    3ff2:	48 b8 fa 68 00 00 00 	movabs $0x68fa,%rax
    3ff9:	00 00 00 
    3ffc:	ff d0                	call   *%rax
    3ffe:	85 c0                	test   %eax,%eax
    4000:	74 19                	je     401b <subdir+0x405>
    failexit("chdir ./..");
    4002:	48 b8 06 7d 00 00 00 	movabs $0x7d06,%rax
    4009:	00 00 00 
    400c:	48 89 c7             	mov    %rax,%rdi
    400f:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4016:	00 00 00 
    4019:	ff d0                	call   *%rax
  }

  fd = open("dd/dd/ffff", 0);
    401b:	be 00 00 00 00       	mov    $0x0,%esi
    4020:	48 b8 72 7c 00 00 00 	movabs $0x7c72,%rax
    4027:	00 00 00 
    402a:	48 89 c7             	mov    %rax,%rdi
    402d:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    4034:	00 00 00 
    4037:	ff d0                	call   *%rax
    4039:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    403c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    4040:	79 19                	jns    405b <subdir+0x445>
    failexit("open dd/dd/ffff");
    4042:	48 b8 11 7d 00 00 00 	movabs $0x7d11,%rax
    4049:	00 00 00 
    404c:	48 89 c7             	mov    %rax,%rdi
    404f:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4056:	00 00 00 
    4059:	ff d0                	call   *%rax
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    405b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    405e:	ba 00 20 00 00       	mov    $0x2000,%edx
    4063:	48 b9 00 8a 00 00 00 	movabs $0x8a00,%rcx
    406a:	00 00 00 
    406d:	48 89 ce             	mov    %rcx,%rsi
    4070:	89 c7                	mov    %eax,%edi
    4072:	48 b8 6b 68 00 00 00 	movabs $0x686b,%rax
    4079:	00 00 00 
    407c:	ff d0                	call   *%rax
    407e:	83 f8 02             	cmp    $0x2,%eax
    4081:	74 19                	je     409c <subdir+0x486>
    failexit("read dd/dd/ffff wrong len");
    4083:	48 b8 21 7d 00 00 00 	movabs $0x7d21,%rax
    408a:	00 00 00 
    408d:	48 89 c7             	mov    %rax,%rdi
    4090:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4097:	00 00 00 
    409a:	ff d0                	call   *%rax
  }
  close(fd);
    409c:	8b 45 fc             	mov    -0x4(%rbp),%eax
    409f:	89 c7                	mov    %eax,%edi
    40a1:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    40a8:	00 00 00 
    40ab:	ff d0                	call   *%rax

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    40ad:	be 00 00 00 00       	mov    $0x0,%esi
    40b2:	48 b8 1f 7c 00 00 00 	movabs $0x7c1f,%rax
    40b9:	00 00 00 
    40bc:	48 89 c7             	mov    %rax,%rdi
    40bf:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    40c6:	00 00 00 
    40c9:	ff d0                	call   *%rax
    40cb:	85 c0                	test   %eax,%eax
    40cd:	78 19                	js     40e8 <subdir+0x4d2>
    failexit("open (unlinked) dd/dd/ff succeeded");
    40cf:	48 b8 a8 7c 00 00 00 	movabs $0x7ca8,%rax
    40d6:	00 00 00 
    40d9:	48 89 c7             	mov    %rax,%rdi
    40dc:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    40e3:	00 00 00 
    40e6:	ff d0                	call   *%rax
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    40e8:	be 02 02 00 00       	mov    $0x202,%esi
    40ed:	48 b8 3b 7d 00 00 00 	movabs $0x7d3b,%rax
    40f4:	00 00 00 
    40f7:	48 89 c7             	mov    %rax,%rdi
    40fa:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    4101:	00 00 00 
    4104:	ff d0                	call   *%rax
    4106:	85 c0                	test   %eax,%eax
    4108:	78 19                	js     4123 <subdir+0x50d>
    failexit("create dd/ff/ff succeeded");
    410a:	48 b8 44 7d 00 00 00 	movabs $0x7d44,%rax
    4111:	00 00 00 
    4114:	48 89 c7             	mov    %rax,%rdi
    4117:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    411e:	00 00 00 
    4121:	ff d0                	call   *%rax
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    4123:	be 02 02 00 00       	mov    $0x202,%esi
    4128:	48 b8 5e 7d 00 00 00 	movabs $0x7d5e,%rax
    412f:	00 00 00 
    4132:	48 89 c7             	mov    %rax,%rdi
    4135:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    413c:	00 00 00 
    413f:	ff d0                	call   *%rax
    4141:	85 c0                	test   %eax,%eax
    4143:	78 19                	js     415e <subdir+0x548>
    failexit("create dd/xx/ff succeeded");
    4145:	48 b8 67 7d 00 00 00 	movabs $0x7d67,%rax
    414c:	00 00 00 
    414f:	48 89 c7             	mov    %rax,%rdi
    4152:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4159:	00 00 00 
    415c:	ff d0                	call   *%rax
  }
  if(open("dd", O_CREATE) >= 0){
    415e:	be 00 02 00 00       	mov    $0x200,%esi
    4163:	48 b8 b4 7b 00 00 00 	movabs $0x7bb4,%rax
    416a:	00 00 00 
    416d:	48 89 c7             	mov    %rax,%rdi
    4170:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    4177:	00 00 00 
    417a:	ff d0                	call   *%rax
    417c:	85 c0                	test   %eax,%eax
    417e:	78 19                	js     4199 <subdir+0x583>
    failexit("create dd succeeded");
    4180:	48 b8 81 7d 00 00 00 	movabs $0x7d81,%rax
    4187:	00 00 00 
    418a:	48 89 c7             	mov    %rax,%rdi
    418d:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4194:	00 00 00 
    4197:	ff d0                	call   *%rax
  }
  if(open("dd", O_RDWR) >= 0){
    4199:	be 02 00 00 00       	mov    $0x2,%esi
    419e:	48 b8 b4 7b 00 00 00 	movabs $0x7bb4,%rax
    41a5:	00 00 00 
    41a8:	48 89 c7             	mov    %rax,%rdi
    41ab:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    41b2:	00 00 00 
    41b5:	ff d0                	call   *%rax
    41b7:	85 c0                	test   %eax,%eax
    41b9:	78 19                	js     41d4 <subdir+0x5be>
    failexit("open dd rdwr succeeded");
    41bb:	48 b8 95 7d 00 00 00 	movabs $0x7d95,%rax
    41c2:	00 00 00 
    41c5:	48 89 c7             	mov    %rax,%rdi
    41c8:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    41cf:	00 00 00 
    41d2:	ff d0                	call   *%rax
  }
  if(open("dd", O_WRONLY) >= 0){
    41d4:	be 01 00 00 00       	mov    $0x1,%esi
    41d9:	48 b8 b4 7b 00 00 00 	movabs $0x7bb4,%rax
    41e0:	00 00 00 
    41e3:	48 89 c7             	mov    %rax,%rdi
    41e6:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    41ed:	00 00 00 
    41f0:	ff d0                	call   *%rax
    41f2:	85 c0                	test   %eax,%eax
    41f4:	78 19                	js     420f <subdir+0x5f9>
    failexit("open dd wronly succeeded");
    41f6:	48 b8 ac 7d 00 00 00 	movabs $0x7dac,%rax
    41fd:	00 00 00 
    4200:	48 89 c7             	mov    %rax,%rdi
    4203:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    420a:	00 00 00 
    420d:	ff d0                	call   *%rax
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    420f:	48 b8 c5 7d 00 00 00 	movabs $0x7dc5,%rax
    4216:	00 00 00 
    4219:	48 89 c6             	mov    %rax,%rsi
    421c:	48 b8 3b 7d 00 00 00 	movabs $0x7d3b,%rax
    4223:	00 00 00 
    4226:	48 89 c7             	mov    %rax,%rdi
    4229:	48 b8 e0 68 00 00 00 	movabs $0x68e0,%rax
    4230:	00 00 00 
    4233:	ff d0                	call   *%rax
    4235:	85 c0                	test   %eax,%eax
    4237:	75 19                	jne    4252 <subdir+0x63c>
    failexit("link dd/ff/ff dd/dd/xx succeeded");
    4239:	48 b8 d0 7d 00 00 00 	movabs $0x7dd0,%rax
    4240:	00 00 00 
    4243:	48 89 c7             	mov    %rax,%rdi
    4246:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    424d:	00 00 00 
    4250:	ff d0                	call   *%rax
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    4252:	48 b8 c5 7d 00 00 00 	movabs $0x7dc5,%rax
    4259:	00 00 00 
    425c:	48 89 c6             	mov    %rax,%rsi
    425f:	48 b8 5e 7d 00 00 00 	movabs $0x7d5e,%rax
    4266:	00 00 00 
    4269:	48 89 c7             	mov    %rax,%rdi
    426c:	48 b8 e0 68 00 00 00 	movabs $0x68e0,%rax
    4273:	00 00 00 
    4276:	ff d0                	call   *%rax
    4278:	85 c0                	test   %eax,%eax
    427a:	75 19                	jne    4295 <subdir+0x67f>
    failexit("link dd/xx/ff dd/dd/xx succeededn");
    427c:	48 b8 f8 7d 00 00 00 	movabs $0x7df8,%rax
    4283:	00 00 00 
    4286:	48 89 c7             	mov    %rax,%rdi
    4289:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4290:	00 00 00 
    4293:	ff d0                	call   *%rax
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    4295:	48 b8 72 7c 00 00 00 	movabs $0x7c72,%rax
    429c:	00 00 00 
    429f:	48 89 c6             	mov    %rax,%rsi
    42a2:	48 b8 c7 7b 00 00 00 	movabs $0x7bc7,%rax
    42a9:	00 00 00 
    42ac:	48 89 c7             	mov    %rax,%rdi
    42af:	48 b8 e0 68 00 00 00 	movabs $0x68e0,%rax
    42b6:	00 00 00 
    42b9:	ff d0                	call   *%rax
    42bb:	85 c0                	test   %eax,%eax
    42bd:	75 19                	jne    42d8 <subdir+0x6c2>
    failexit("link dd/ff dd/dd/ffff succeeded");
    42bf:	48 b8 20 7e 00 00 00 	movabs $0x7e20,%rax
    42c6:	00 00 00 
    42c9:	48 89 c7             	mov    %rax,%rdi
    42cc:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    42d3:	00 00 00 
    42d6:	ff d0                	call   *%rax
  }
  if(mkdir("dd/ff/ff") == 0){
    42d8:	48 b8 3b 7d 00 00 00 	movabs $0x7d3b,%rax
    42df:	00 00 00 
    42e2:	48 89 c7             	mov    %rax,%rdi
    42e5:	48 b8 ed 68 00 00 00 	movabs $0x68ed,%rax
    42ec:	00 00 00 
    42ef:	ff d0                	call   *%rax
    42f1:	85 c0                	test   %eax,%eax
    42f3:	75 19                	jne    430e <subdir+0x6f8>
    failexit("mkdir dd/ff/ff succeeded");
    42f5:	48 b8 40 7e 00 00 00 	movabs $0x7e40,%rax
    42fc:	00 00 00 
    42ff:	48 89 c7             	mov    %rax,%rdi
    4302:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4309:	00 00 00 
    430c:	ff d0                	call   *%rax
  }
  if(mkdir("dd/xx/ff") == 0){
    430e:	48 b8 5e 7d 00 00 00 	movabs $0x7d5e,%rax
    4315:	00 00 00 
    4318:	48 89 c7             	mov    %rax,%rdi
    431b:	48 b8 ed 68 00 00 00 	movabs $0x68ed,%rax
    4322:	00 00 00 
    4325:	ff d0                	call   *%rax
    4327:	85 c0                	test   %eax,%eax
    4329:	75 19                	jne    4344 <subdir+0x72e>
    failexit("mkdir dd/xx/ff succeeded");
    432b:	48 b8 59 7e 00 00 00 	movabs $0x7e59,%rax
    4332:	00 00 00 
    4335:	48 89 c7             	mov    %rax,%rdi
    4338:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    433f:	00 00 00 
    4342:	ff d0                	call   *%rax
  }
  if(mkdir("dd/dd/ffff") == 0){
    4344:	48 b8 72 7c 00 00 00 	movabs $0x7c72,%rax
    434b:	00 00 00 
    434e:	48 89 c7             	mov    %rax,%rdi
    4351:	48 b8 ed 68 00 00 00 	movabs $0x68ed,%rax
    4358:	00 00 00 
    435b:	ff d0                	call   *%rax
    435d:	85 c0                	test   %eax,%eax
    435f:	75 19                	jne    437a <subdir+0x764>
    failexit("mkdir dd/dd/ffff succeeded");
    4361:	48 b8 72 7e 00 00 00 	movabs $0x7e72,%rax
    4368:	00 00 00 
    436b:	48 89 c7             	mov    %rax,%rdi
    436e:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4375:	00 00 00 
    4378:	ff d0                	call   *%rax
  }
  if(unlink("dd/xx/ff") == 0){
    437a:	48 b8 5e 7d 00 00 00 	movabs $0x7d5e,%rax
    4381:	00 00 00 
    4384:	48 89 c7             	mov    %rax,%rdi
    4387:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    438e:	00 00 00 
    4391:	ff d0                	call   *%rax
    4393:	85 c0                	test   %eax,%eax
    4395:	75 19                	jne    43b0 <subdir+0x79a>
    failexit("unlink dd/xx/ff succeeded");
    4397:	48 b8 8d 7e 00 00 00 	movabs $0x7e8d,%rax
    439e:	00 00 00 
    43a1:	48 89 c7             	mov    %rax,%rdi
    43a4:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    43ab:	00 00 00 
    43ae:	ff d0                	call   *%rax
  }
  if(unlink("dd/ff/ff") == 0){
    43b0:	48 b8 3b 7d 00 00 00 	movabs $0x7d3b,%rax
    43b7:	00 00 00 
    43ba:	48 89 c7             	mov    %rax,%rdi
    43bd:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    43c4:	00 00 00 
    43c7:	ff d0                	call   *%rax
    43c9:	85 c0                	test   %eax,%eax
    43cb:	75 19                	jne    43e6 <subdir+0x7d0>
    failexit("unlink dd/ff/ff succeeded");
    43cd:	48 b8 a7 7e 00 00 00 	movabs $0x7ea7,%rax
    43d4:	00 00 00 
    43d7:	48 89 c7             	mov    %rax,%rdi
    43da:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    43e1:	00 00 00 
    43e4:	ff d0                	call   *%rax
  }
  if(chdir("dd/ff") == 0){
    43e6:	48 b8 c7 7b 00 00 00 	movabs $0x7bc7,%rax
    43ed:	00 00 00 
    43f0:	48 89 c7             	mov    %rax,%rdi
    43f3:	48 b8 fa 68 00 00 00 	movabs $0x68fa,%rax
    43fa:	00 00 00 
    43fd:	ff d0                	call   *%rax
    43ff:	85 c0                	test   %eax,%eax
    4401:	75 19                	jne    441c <subdir+0x806>
    failexit("chdir dd/ff succeeded");
    4403:	48 b8 c1 7e 00 00 00 	movabs $0x7ec1,%rax
    440a:	00 00 00 
    440d:	48 89 c7             	mov    %rax,%rdi
    4410:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4417:	00 00 00 
    441a:	ff d0                	call   *%rax
  }
  if(chdir("dd/xx") == 0){
    441c:	48 b8 d7 7e 00 00 00 	movabs $0x7ed7,%rax
    4423:	00 00 00 
    4426:	48 89 c7             	mov    %rax,%rdi
    4429:	48 b8 fa 68 00 00 00 	movabs $0x68fa,%rax
    4430:	00 00 00 
    4433:	ff d0                	call   *%rax
    4435:	85 c0                	test   %eax,%eax
    4437:	75 19                	jne    4452 <subdir+0x83c>
    failexit("chdir dd/xx succeeded");
    4439:	48 b8 dd 7e 00 00 00 	movabs $0x7edd,%rax
    4440:	00 00 00 
    4443:	48 89 c7             	mov    %rax,%rdi
    4446:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    444d:	00 00 00 
    4450:	ff d0                	call   *%rax
  }

  if(unlink("dd/dd/ffff") != 0){
    4452:	48 b8 72 7c 00 00 00 	movabs $0x7c72,%rax
    4459:	00 00 00 
    445c:	48 89 c7             	mov    %rax,%rdi
    445f:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    4466:	00 00 00 
    4469:	ff d0                	call   *%rax
    446b:	85 c0                	test   %eax,%eax
    446d:	74 19                	je     4488 <subdir+0x872>
    failexit("unlink dd/dd/ff");
    446f:	48 b8 96 7c 00 00 00 	movabs $0x7c96,%rax
    4476:	00 00 00 
    4479:	48 89 c7             	mov    %rax,%rdi
    447c:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4483:	00 00 00 
    4486:	ff d0                	call   *%rax
  }
  if(unlink("dd/ff") != 0){
    4488:	48 b8 c7 7b 00 00 00 	movabs $0x7bc7,%rax
    448f:	00 00 00 
    4492:	48 89 c7             	mov    %rax,%rdi
    4495:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    449c:	00 00 00 
    449f:	ff d0                	call   *%rax
    44a1:	85 c0                	test   %eax,%eax
    44a3:	74 19                	je     44be <subdir+0x8a8>
    failexit("unlink dd/ff");
    44a5:	48 b8 f3 7e 00 00 00 	movabs $0x7ef3,%rax
    44ac:	00 00 00 
    44af:	48 89 c7             	mov    %rax,%rdi
    44b2:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    44b9:	00 00 00 
    44bc:	ff d0                	call   *%rax
  }
  if(unlink("dd") == 0){
    44be:	48 b8 b4 7b 00 00 00 	movabs $0x7bb4,%rax
    44c5:	00 00 00 
    44c8:	48 89 c7             	mov    %rax,%rdi
    44cb:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    44d2:	00 00 00 
    44d5:	ff d0                	call   *%rax
    44d7:	85 c0                	test   %eax,%eax
    44d9:	75 19                	jne    44f4 <subdir+0x8de>
    failexit("unlink non-empty dd succeeded");
    44db:	48 b8 00 7f 00 00 00 	movabs $0x7f00,%rax
    44e2:	00 00 00 
    44e5:	48 89 c7             	mov    %rax,%rdi
    44e8:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    44ef:	00 00 00 
    44f2:	ff d0                	call   *%rax
  }
  if(unlink("dd/dd") < 0){
    44f4:	48 b8 1e 7f 00 00 00 	movabs $0x7f1e,%rax
    44fb:	00 00 00 
    44fe:	48 89 c7             	mov    %rax,%rdi
    4501:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    4508:	00 00 00 
    450b:	ff d0                	call   *%rax
    450d:	85 c0                	test   %eax,%eax
    450f:	79 19                	jns    452a <subdir+0x914>
    failexit("unlink dd/dd");
    4511:	48 b8 24 7f 00 00 00 	movabs $0x7f24,%rax
    4518:	00 00 00 
    451b:	48 89 c7             	mov    %rax,%rdi
    451e:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4525:	00 00 00 
    4528:	ff d0                	call   *%rax
  }
  if(unlink("dd") < 0){
    452a:	48 b8 b4 7b 00 00 00 	movabs $0x7bb4,%rax
    4531:	00 00 00 
    4534:	48 89 c7             	mov    %rax,%rdi
    4537:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    453e:	00 00 00 
    4541:	ff d0                	call   *%rax
    4543:	85 c0                	test   %eax,%eax
    4545:	79 19                	jns    4560 <subdir+0x94a>
    failexit("unlink dd");
    4547:	48 b8 31 7f 00 00 00 	movabs $0x7f31,%rax
    454e:	00 00 00 
    4551:	48 89 c7             	mov    %rax,%rdi
    4554:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    455b:	00 00 00 
    455e:	ff d0                	call   *%rax
  }

  printf(1, "subdir ok\n");
    4560:	48 b8 3b 7f 00 00 00 	movabs $0x7f3b,%rax
    4567:	00 00 00 
    456a:	48 89 c6             	mov    %rax,%rsi
    456d:	bf 01 00 00 00       	mov    $0x1,%edi
    4572:	b8 00 00 00 00       	mov    $0x0,%eax
    4577:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    457e:	00 00 00 
    4581:	ff d2                	call   *%rdx
}
    4583:	90                   	nop
    4584:	c9                   	leave
    4585:	c3                   	ret

0000000000004586 <bigwrite>:

// test writes that are larger than the log.
void
bigwrite(void)
{
    4586:	f3 0f 1e fa          	endbr64
    458a:	55                   	push   %rbp
    458b:	48 89 e5             	mov    %rsp,%rbp
    458e:	48 83 ec 10          	sub    $0x10,%rsp
  int fd, sz;

  printf(1, "bigwrite test\n");
    4592:	48 b8 46 7f 00 00 00 	movabs $0x7f46,%rax
    4599:	00 00 00 
    459c:	48 89 c6             	mov    %rax,%rsi
    459f:	bf 01 00 00 00       	mov    $0x1,%edi
    45a4:	b8 00 00 00 00       	mov    $0x0,%eax
    45a9:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    45b0:	00 00 00 
    45b3:	ff d2                	call   *%rdx

  unlink("bigwrite");
    45b5:	48 b8 55 7f 00 00 00 	movabs $0x7f55,%rax
    45bc:	00 00 00 
    45bf:	48 89 c7             	mov    %rax,%rdi
    45c2:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    45c9:	00 00 00 
    45cc:	ff d0                	call   *%rax
  for(sz = 499; sz < 12*512; sz += 471){
    45ce:	c7 45 fc f3 01 00 00 	movl   $0x1f3,-0x4(%rbp)
    45d5:	e9 ea 00 00 00       	jmp    46c4 <bigwrite+0x13e>
    fd = open("bigwrite", O_CREATE | O_RDWR);
    45da:	be 02 02 00 00       	mov    $0x202,%esi
    45df:	48 b8 55 7f 00 00 00 	movabs $0x7f55,%rax
    45e6:	00 00 00 
    45e9:	48 89 c7             	mov    %rax,%rdi
    45ec:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    45f3:	00 00 00 
    45f6:	ff d0                	call   *%rax
    45f8:	89 45 f4             	mov    %eax,-0xc(%rbp)
    if(fd < 0){
    45fb:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    45ff:	79 19                	jns    461a <bigwrite+0x94>
      failexit("cannot create bigwrite");
    4601:	48 b8 5e 7f 00 00 00 	movabs $0x7f5e,%rax
    4608:	00 00 00 
    460b:	48 89 c7             	mov    %rax,%rdi
    460e:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4615:	00 00 00 
    4618:	ff d0                	call   *%rax
    }
    int i;
    for(i = 0; i < 2; i++){
    461a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
    4621:	eb 6a                	jmp    468d <bigwrite+0x107>
      int cc = write(fd, buf, sz);
    4623:	8b 55 fc             	mov    -0x4(%rbp),%edx
    4626:	8b 45 f4             	mov    -0xc(%rbp),%eax
    4629:	48 b9 00 8a 00 00 00 	movabs $0x8a00,%rcx
    4630:	00 00 00 
    4633:	48 89 ce             	mov    %rcx,%rsi
    4636:	89 c7                	mov    %eax,%edi
    4638:	48 b8 78 68 00 00 00 	movabs $0x6878,%rax
    463f:	00 00 00 
    4642:	ff d0                	call   *%rax
    4644:	89 45 f0             	mov    %eax,-0x10(%rbp)
      if(cc != sz){
    4647:	8b 45 f0             	mov    -0x10(%rbp),%eax
    464a:	3b 45 fc             	cmp    -0x4(%rbp),%eax
    464d:	74 3a                	je     4689 <bigwrite+0x103>
        printf(1, "write(%d) ret %d\n", sz, cc);
    464f:	8b 55 f0             	mov    -0x10(%rbp),%edx
    4652:	8b 45 fc             	mov    -0x4(%rbp),%eax
    4655:	89 d1                	mov    %edx,%ecx
    4657:	89 c2                	mov    %eax,%edx
    4659:	48 b8 75 7f 00 00 00 	movabs $0x7f75,%rax
    4660:	00 00 00 
    4663:	48 89 c6             	mov    %rax,%rsi
    4666:	bf 01 00 00 00       	mov    $0x1,%edi
    466b:	b8 00 00 00 00       	mov    $0x0,%eax
    4670:	49 b8 55 6b 00 00 00 	movabs $0x6b55,%r8
    4677:	00 00 00 
    467a:	41 ff d0             	call   *%r8
        exit();
    467d:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    4684:	00 00 00 
    4687:	ff d0                	call   *%rax
    for(i = 0; i < 2; i++){
    4689:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    468d:	83 7d f8 01          	cmpl   $0x1,-0x8(%rbp)
    4691:	7e 90                	jle    4623 <bigwrite+0x9d>
      }
    }
    close(fd);
    4693:	8b 45 f4             	mov    -0xc(%rbp),%eax
    4696:	89 c7                	mov    %eax,%edi
    4698:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    469f:	00 00 00 
    46a2:	ff d0                	call   *%rax
    unlink("bigwrite");
    46a4:	48 b8 55 7f 00 00 00 	movabs $0x7f55,%rax
    46ab:	00 00 00 
    46ae:	48 89 c7             	mov    %rax,%rdi
    46b1:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    46b8:	00 00 00 
    46bb:	ff d0                	call   *%rax
  for(sz = 499; sz < 12*512; sz += 471){
    46bd:	81 45 fc d7 01 00 00 	addl   $0x1d7,-0x4(%rbp)
    46c4:	81 7d fc ff 17 00 00 	cmpl   $0x17ff,-0x4(%rbp)
    46cb:	0f 8e 09 ff ff ff    	jle    45da <bigwrite+0x54>
  }

  printf(1, "bigwrite ok\n");
    46d1:	48 b8 87 7f 00 00 00 	movabs $0x7f87,%rax
    46d8:	00 00 00 
    46db:	48 89 c6             	mov    %rax,%rsi
    46de:	bf 01 00 00 00       	mov    $0x1,%edi
    46e3:	b8 00 00 00 00       	mov    $0x0,%eax
    46e8:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    46ef:	00 00 00 
    46f2:	ff d2                	call   *%rdx
}
    46f4:	90                   	nop
    46f5:	c9                   	leave
    46f6:	c3                   	ret

00000000000046f7 <bigfile>:

void
bigfile(void)
{
    46f7:	f3 0f 1e fa          	endbr64
    46fb:	55                   	push   %rbp
    46fc:	48 89 e5             	mov    %rsp,%rbp
    46ff:	48 83 ec 10          	sub    $0x10,%rsp
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
    4703:	48 b8 94 7f 00 00 00 	movabs $0x7f94,%rax
    470a:	00 00 00 
    470d:	48 89 c6             	mov    %rax,%rsi
    4710:	bf 01 00 00 00       	mov    $0x1,%edi
    4715:	b8 00 00 00 00       	mov    $0x0,%eax
    471a:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    4721:	00 00 00 
    4724:	ff d2                	call   *%rdx

  unlink("bigfile");
    4726:	48 b8 a2 7f 00 00 00 	movabs $0x7fa2,%rax
    472d:	00 00 00 
    4730:	48 89 c7             	mov    %rax,%rdi
    4733:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    473a:	00 00 00 
    473d:	ff d0                	call   *%rax
  fd = open("bigfile", O_CREATE | O_RDWR);
    473f:	be 02 02 00 00       	mov    $0x202,%esi
    4744:	48 b8 a2 7f 00 00 00 	movabs $0x7fa2,%rax
    474b:	00 00 00 
    474e:	48 89 c7             	mov    %rax,%rdi
    4751:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    4758:	00 00 00 
    475b:	ff d0                	call   *%rax
    475d:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(fd < 0){
    4760:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    4764:	79 19                	jns    477f <bigfile+0x88>
    failexit("cannot create bigfile");
    4766:	48 b8 aa 7f 00 00 00 	movabs $0x7faa,%rax
    476d:	00 00 00 
    4770:	48 89 c7             	mov    %rax,%rdi
    4773:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    477a:	00 00 00 
    477d:	ff d0                	call   *%rax
  }
  for(i = 0; i < 20; i++){
    477f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    4786:	eb 6a                	jmp    47f2 <bigfile+0xfb>
    memset(buf, i, 600);
    4788:	8b 45 fc             	mov    -0x4(%rbp),%eax
    478b:	ba 58 02 00 00       	mov    $0x258,%edx
    4790:	89 c6                	mov    %eax,%esi
    4792:	48 b8 00 8a 00 00 00 	movabs $0x8a00,%rax
    4799:	00 00 00 
    479c:	48 89 c7             	mov    %rax,%rdi
    479f:	48 b8 0f 66 00 00 00 	movabs $0x660f,%rax
    47a6:	00 00 00 
    47a9:	ff d0                	call   *%rax
    if(write(fd, buf, 600) != 600){
    47ab:	8b 45 f4             	mov    -0xc(%rbp),%eax
    47ae:	ba 58 02 00 00       	mov    $0x258,%edx
    47b3:	48 b9 00 8a 00 00 00 	movabs $0x8a00,%rcx
    47ba:	00 00 00 
    47bd:	48 89 ce             	mov    %rcx,%rsi
    47c0:	89 c7                	mov    %eax,%edi
    47c2:	48 b8 78 68 00 00 00 	movabs $0x6878,%rax
    47c9:	00 00 00 
    47cc:	ff d0                	call   *%rax
    47ce:	3d 58 02 00 00       	cmp    $0x258,%eax
    47d3:	74 19                	je     47ee <bigfile+0xf7>
      failexit("write bigfile");
    47d5:	48 b8 c0 7f 00 00 00 	movabs $0x7fc0,%rax
    47dc:	00 00 00 
    47df:	48 89 c7             	mov    %rax,%rdi
    47e2:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    47e9:	00 00 00 
    47ec:	ff d0                	call   *%rax
  for(i = 0; i < 20; i++){
    47ee:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    47f2:	83 7d fc 13          	cmpl   $0x13,-0x4(%rbp)
    47f6:	7e 90                	jle    4788 <bigfile+0x91>
    }
  }
  close(fd);
    47f8:	8b 45 f4             	mov    -0xc(%rbp),%eax
    47fb:	89 c7                	mov    %eax,%edi
    47fd:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    4804:	00 00 00 
    4807:	ff d0                	call   *%rax

  fd = open("bigfile", 0);
    4809:	be 00 00 00 00       	mov    $0x0,%esi
    480e:	48 b8 a2 7f 00 00 00 	movabs $0x7fa2,%rax
    4815:	00 00 00 
    4818:	48 89 c7             	mov    %rax,%rdi
    481b:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    4822:	00 00 00 
    4825:	ff d0                	call   *%rax
    4827:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(fd < 0){
    482a:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    482e:	79 19                	jns    4849 <bigfile+0x152>
    failexit("cannot open bigfile");
    4830:	48 b8 ce 7f 00 00 00 	movabs $0x7fce,%rax
    4837:	00 00 00 
    483a:	48 89 c7             	mov    %rax,%rdi
    483d:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4844:	00 00 00 
    4847:	ff d0                	call   *%rax
  }
  total = 0;
    4849:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  for(i = 0; ; i++){
    4850:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    cc = read(fd, buf, 300);
    4857:	8b 45 f4             	mov    -0xc(%rbp),%eax
    485a:	ba 2c 01 00 00       	mov    $0x12c,%edx
    485f:	48 b9 00 8a 00 00 00 	movabs $0x8a00,%rcx
    4866:	00 00 00 
    4869:	48 89 ce             	mov    %rcx,%rsi
    486c:	89 c7                	mov    %eax,%edi
    486e:	48 b8 6b 68 00 00 00 	movabs $0x686b,%rax
    4875:	00 00 00 
    4878:	ff d0                	call   *%rax
    487a:	89 45 f0             	mov    %eax,-0x10(%rbp)
    if(cc < 0){
    487d:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    4881:	79 19                	jns    489c <bigfile+0x1a5>
      failexit("read bigfile");
    4883:	48 b8 e2 7f 00 00 00 	movabs $0x7fe2,%rax
    488a:	00 00 00 
    488d:	48 89 c7             	mov    %rax,%rdi
    4890:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4897:	00 00 00 
    489a:	ff d0                	call   *%rax
    }
    if(cc == 0)
    489c:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    48a0:	0f 84 8e 00 00 00    	je     4934 <bigfile+0x23d>
      break;
    if(cc != 300){
    48a6:	81 7d f0 2c 01 00 00 	cmpl   $0x12c,-0x10(%rbp)
    48ad:	74 19                	je     48c8 <bigfile+0x1d1>
      failexit("short read bigfile");
    48af:	48 b8 ef 7f 00 00 00 	movabs $0x7fef,%rax
    48b6:	00 00 00 
    48b9:	48 89 c7             	mov    %rax,%rdi
    48bc:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    48c3:	00 00 00 
    48c6:	ff d0                	call   *%rax
    }
    if(buf[0] != i/2 || buf[299] != i/2){
    48c8:	48 b8 00 8a 00 00 00 	movabs $0x8a00,%rax
    48cf:	00 00 00 
    48d2:	0f b6 00             	movzbl (%rax),%eax
    48d5:	0f be d0             	movsbl %al,%edx
    48d8:	8b 45 fc             	mov    -0x4(%rbp),%eax
    48db:	89 c1                	mov    %eax,%ecx
    48dd:	c1 e9 1f             	shr    $0x1f,%ecx
    48e0:	01 c8                	add    %ecx,%eax
    48e2:	d1 f8                	sar    $1,%eax
    48e4:	39 c2                	cmp    %eax,%edx
    48e6:	75 24                	jne    490c <bigfile+0x215>
    48e8:	48 b8 00 8a 00 00 00 	movabs $0x8a00,%rax
    48ef:	00 00 00 
    48f2:	0f b6 80 2b 01 00 00 	movzbl 0x12b(%rax),%eax
    48f9:	0f be d0             	movsbl %al,%edx
    48fc:	8b 45 fc             	mov    -0x4(%rbp),%eax
    48ff:	89 c1                	mov    %eax,%ecx
    4901:	c1 e9 1f             	shr    $0x1f,%ecx
    4904:	01 c8                	add    %ecx,%eax
    4906:	d1 f8                	sar    $1,%eax
    4908:	39 c2                	cmp    %eax,%edx
    490a:	74 19                	je     4925 <bigfile+0x22e>
      failexit("read bigfile wrong data");
    490c:	48 b8 02 80 00 00 00 	movabs $0x8002,%rax
    4913:	00 00 00 
    4916:	48 89 c7             	mov    %rax,%rdi
    4919:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4920:	00 00 00 
    4923:	ff d0                	call   *%rax
    }
    total += cc;
    4925:	8b 45 f0             	mov    -0x10(%rbp),%eax
    4928:	01 45 f8             	add    %eax,-0x8(%rbp)
  for(i = 0; ; i++){
    492b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    cc = read(fd, buf, 300);
    492f:	e9 23 ff ff ff       	jmp    4857 <bigfile+0x160>
      break;
    4934:	90                   	nop
  }
  close(fd);
    4935:	8b 45 f4             	mov    -0xc(%rbp),%eax
    4938:	89 c7                	mov    %eax,%edi
    493a:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    4941:	00 00 00 
    4944:	ff d0                	call   *%rax
  if(total != 20*600){
    4946:	81 7d f8 e0 2e 00 00 	cmpl   $0x2ee0,-0x8(%rbp)
    494d:	74 19                	je     4968 <bigfile+0x271>
    failexit("read bigfile wrong total");
    494f:	48 b8 1a 80 00 00 00 	movabs $0x801a,%rax
    4956:	00 00 00 
    4959:	48 89 c7             	mov    %rax,%rdi
    495c:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4963:	00 00 00 
    4966:	ff d0                	call   *%rax
  }
  unlink("bigfile");
    4968:	48 b8 a2 7f 00 00 00 	movabs $0x7fa2,%rax
    496f:	00 00 00 
    4972:	48 89 c7             	mov    %rax,%rdi
    4975:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    497c:	00 00 00 
    497f:	ff d0                	call   *%rax

  printf(1, "bigfile test ok\n");
    4981:	48 b8 33 80 00 00 00 	movabs $0x8033,%rax
    4988:	00 00 00 
    498b:	48 89 c6             	mov    %rax,%rsi
    498e:	bf 01 00 00 00       	mov    $0x1,%edi
    4993:	b8 00 00 00 00       	mov    $0x0,%eax
    4998:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    499f:	00 00 00 
    49a2:	ff d2                	call   *%rdx
}
    49a4:	90                   	nop
    49a5:	c9                   	leave
    49a6:	c3                   	ret

00000000000049a7 <fourteen>:

void
fourteen(void)
{
    49a7:	f3 0f 1e fa          	endbr64
    49ab:	55                   	push   %rbp
    49ac:	48 89 e5             	mov    %rsp,%rbp
    49af:	48 83 ec 10          	sub    $0x10,%rsp
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
    49b3:	48 b8 44 80 00 00 00 	movabs $0x8044,%rax
    49ba:	00 00 00 
    49bd:	48 89 c6             	mov    %rax,%rsi
    49c0:	bf 01 00 00 00       	mov    $0x1,%edi
    49c5:	b8 00 00 00 00       	mov    $0x0,%eax
    49ca:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    49d1:	00 00 00 
    49d4:	ff d2                	call   *%rdx

  if(mkdir("12345678901234") != 0){
    49d6:	48 b8 53 80 00 00 00 	movabs $0x8053,%rax
    49dd:	00 00 00 
    49e0:	48 89 c7             	mov    %rax,%rdi
    49e3:	48 b8 ed 68 00 00 00 	movabs $0x68ed,%rax
    49ea:	00 00 00 
    49ed:	ff d0                	call   *%rax
    49ef:	85 c0                	test   %eax,%eax
    49f1:	74 19                	je     4a0c <fourteen+0x65>
    failexit("mkdir 12345678901234");
    49f3:	48 b8 62 80 00 00 00 	movabs $0x8062,%rax
    49fa:	00 00 00 
    49fd:	48 89 c7             	mov    %rax,%rdi
    4a00:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4a07:	00 00 00 
    4a0a:	ff d0                	call   *%rax
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    4a0c:	48 b8 78 80 00 00 00 	movabs $0x8078,%rax
    4a13:	00 00 00 
    4a16:	48 89 c7             	mov    %rax,%rdi
    4a19:	48 b8 ed 68 00 00 00 	movabs $0x68ed,%rax
    4a20:	00 00 00 
    4a23:	ff d0                	call   *%rax
    4a25:	85 c0                	test   %eax,%eax
    4a27:	74 19                	je     4a42 <fourteen+0x9b>
    failexit("mkdir 12345678901234/123456789012345");
    4a29:	48 b8 98 80 00 00 00 	movabs $0x8098,%rax
    4a30:	00 00 00 
    4a33:	48 89 c7             	mov    %rax,%rdi
    4a36:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4a3d:	00 00 00 
    4a40:	ff d0                	call   *%rax
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    4a42:	be 00 02 00 00       	mov    $0x200,%esi
    4a47:	48 b8 c0 80 00 00 00 	movabs $0x80c0,%rax
    4a4e:	00 00 00 
    4a51:	48 89 c7             	mov    %rax,%rdi
    4a54:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    4a5b:	00 00 00 
    4a5e:	ff d0                	call   *%rax
    4a60:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    4a63:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    4a67:	79 19                	jns    4a82 <fourteen+0xdb>
    failexit("create 123456789012345/123456789012345/123456789012345");
    4a69:	48 b8 f0 80 00 00 00 	movabs $0x80f0,%rax
    4a70:	00 00 00 
    4a73:	48 89 c7             	mov    %rax,%rdi
    4a76:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4a7d:	00 00 00 
    4a80:	ff d0                	call   *%rax
  }
  close(fd);
    4a82:	8b 45 fc             	mov    -0x4(%rbp),%eax
    4a85:	89 c7                	mov    %eax,%edi
    4a87:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    4a8e:	00 00 00 
    4a91:	ff d0                	call   *%rax
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    4a93:	be 00 00 00 00       	mov    $0x0,%esi
    4a98:	48 b8 28 81 00 00 00 	movabs $0x8128,%rax
    4a9f:	00 00 00 
    4aa2:	48 89 c7             	mov    %rax,%rdi
    4aa5:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    4aac:	00 00 00 
    4aaf:	ff d0                	call   *%rax
    4ab1:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    4ab4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    4ab8:	79 19                	jns    4ad3 <fourteen+0x12c>
    failexit("open 12345678901234/12345678901234/12345678901234");
    4aba:	48 b8 58 81 00 00 00 	movabs $0x8158,%rax
    4ac1:	00 00 00 
    4ac4:	48 89 c7             	mov    %rax,%rdi
    4ac7:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4ace:	00 00 00 
    4ad1:	ff d0                	call   *%rax
  }
  close(fd);
    4ad3:	8b 45 fc             	mov    -0x4(%rbp),%eax
    4ad6:	89 c7                	mov    %eax,%edi
    4ad8:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    4adf:	00 00 00 
    4ae2:	ff d0                	call   *%rax

  if(mkdir("12345678901234/12345678901234") == 0){
    4ae4:	48 b8 8a 81 00 00 00 	movabs $0x818a,%rax
    4aeb:	00 00 00 
    4aee:	48 89 c7             	mov    %rax,%rdi
    4af1:	48 b8 ed 68 00 00 00 	movabs $0x68ed,%rax
    4af8:	00 00 00 
    4afb:	ff d0                	call   *%rax
    4afd:	85 c0                	test   %eax,%eax
    4aff:	75 19                	jne    4b1a <fourteen+0x173>
    failexit("mkdir 12345678901234/12345678901234 succeeded");
    4b01:	48 b8 a8 81 00 00 00 	movabs $0x81a8,%rax
    4b08:	00 00 00 
    4b0b:	48 89 c7             	mov    %rax,%rdi
    4b0e:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4b15:	00 00 00 
    4b18:	ff d0                	call   *%rax
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    4b1a:	48 b8 d8 81 00 00 00 	movabs $0x81d8,%rax
    4b21:	00 00 00 
    4b24:	48 89 c7             	mov    %rax,%rdi
    4b27:	48 b8 ed 68 00 00 00 	movabs $0x68ed,%rax
    4b2e:	00 00 00 
    4b31:	ff d0                	call   *%rax
    4b33:	85 c0                	test   %eax,%eax
    4b35:	75 19                	jne    4b50 <fourteen+0x1a9>
    failexit("mkdir 12345678901234/123456789012345 succeeded");
    4b37:	48 b8 f8 81 00 00 00 	movabs $0x81f8,%rax
    4b3e:	00 00 00 
    4b41:	48 89 c7             	mov    %rax,%rdi
    4b44:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4b4b:	00 00 00 
    4b4e:	ff d0                	call   *%rax
  }

  printf(1, "fourteen ok\n");
    4b50:	48 b8 27 82 00 00 00 	movabs $0x8227,%rax
    4b57:	00 00 00 
    4b5a:	48 89 c6             	mov    %rax,%rsi
    4b5d:	bf 01 00 00 00       	mov    $0x1,%edi
    4b62:	b8 00 00 00 00       	mov    $0x0,%eax
    4b67:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    4b6e:	00 00 00 
    4b71:	ff d2                	call   *%rdx
}
    4b73:	90                   	nop
    4b74:	c9                   	leave
    4b75:	c3                   	ret

0000000000004b76 <rmdot>:

void
rmdot(void)
{
    4b76:	f3 0f 1e fa          	endbr64
    4b7a:	55                   	push   %rbp
    4b7b:	48 89 e5             	mov    %rsp,%rbp
  printf(1, "rmdot test\n");
    4b7e:	48 b8 34 82 00 00 00 	movabs $0x8234,%rax
    4b85:	00 00 00 
    4b88:	48 89 c6             	mov    %rax,%rsi
    4b8b:	bf 01 00 00 00       	mov    $0x1,%edi
    4b90:	b8 00 00 00 00       	mov    $0x0,%eax
    4b95:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    4b9c:	00 00 00 
    4b9f:	ff d2                	call   *%rdx
  if(mkdir("dots") != 0){
    4ba1:	48 b8 40 82 00 00 00 	movabs $0x8240,%rax
    4ba8:	00 00 00 
    4bab:	48 89 c7             	mov    %rax,%rdi
    4bae:	48 b8 ed 68 00 00 00 	movabs $0x68ed,%rax
    4bb5:	00 00 00 
    4bb8:	ff d0                	call   *%rax
    4bba:	85 c0                	test   %eax,%eax
    4bbc:	74 19                	je     4bd7 <rmdot+0x61>
    failexit("mkdir dots");
    4bbe:	48 b8 45 82 00 00 00 	movabs $0x8245,%rax
    4bc5:	00 00 00 
    4bc8:	48 89 c7             	mov    %rax,%rdi
    4bcb:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4bd2:	00 00 00 
    4bd5:	ff d0                	call   *%rax
  }
  if(chdir("dots") != 0){
    4bd7:	48 b8 40 82 00 00 00 	movabs $0x8240,%rax
    4bde:	00 00 00 
    4be1:	48 89 c7             	mov    %rax,%rdi
    4be4:	48 b8 fa 68 00 00 00 	movabs $0x68fa,%rax
    4beb:	00 00 00 
    4bee:	ff d0                	call   *%rax
    4bf0:	85 c0                	test   %eax,%eax
    4bf2:	74 19                	je     4c0d <rmdot+0x97>
    failexit("chdir dots");
    4bf4:	48 b8 50 82 00 00 00 	movabs $0x8250,%rax
    4bfb:	00 00 00 
    4bfe:	48 89 c7             	mov    %rax,%rdi
    4c01:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4c08:	00 00 00 
    4c0b:	ff d0                	call   *%rax
  }
  if(unlink(".") == 0){
    4c0d:	48 b8 62 7a 00 00 00 	movabs $0x7a62,%rax
    4c14:	00 00 00 
    4c17:	48 89 c7             	mov    %rax,%rdi
    4c1a:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    4c21:	00 00 00 
    4c24:	ff d0                	call   *%rax
    4c26:	85 c0                	test   %eax,%eax
    4c28:	75 19                	jne    4c43 <rmdot+0xcd>
    failexit("rm . worked");
    4c2a:	48 b8 5b 82 00 00 00 	movabs $0x825b,%rax
    4c31:	00 00 00 
    4c34:	48 89 c7             	mov    %rax,%rdi
    4c37:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4c3e:	00 00 00 
    4c41:	ff d0                	call   *%rax
  }
  if(unlink("..") == 0){
    4c43:	48 b8 da 75 00 00 00 	movabs $0x75da,%rax
    4c4a:	00 00 00 
    4c4d:	48 89 c7             	mov    %rax,%rdi
    4c50:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    4c57:	00 00 00 
    4c5a:	ff d0                	call   *%rax
    4c5c:	85 c0                	test   %eax,%eax
    4c5e:	75 19                	jne    4c79 <rmdot+0x103>
    failexit("rm .. worked");
    4c60:	48 b8 67 82 00 00 00 	movabs $0x8267,%rax
    4c67:	00 00 00 
    4c6a:	48 89 c7             	mov    %rax,%rdi
    4c6d:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4c74:	00 00 00 
    4c77:	ff d0                	call   *%rax
  }
  if(chdir("/") != 0){
    4c79:	48 b8 d0 72 00 00 00 	movabs $0x72d0,%rax
    4c80:	00 00 00 
    4c83:	48 89 c7             	mov    %rax,%rdi
    4c86:	48 b8 fa 68 00 00 00 	movabs $0x68fa,%rax
    4c8d:	00 00 00 
    4c90:	ff d0                	call   *%rax
    4c92:	85 c0                	test   %eax,%eax
    4c94:	74 19                	je     4caf <rmdot+0x139>
    failexit("chdir /");
    4c96:	48 b8 d2 72 00 00 00 	movabs $0x72d2,%rax
    4c9d:	00 00 00 
    4ca0:	48 89 c7             	mov    %rax,%rdi
    4ca3:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4caa:	00 00 00 
    4cad:	ff d0                	call   *%rax
  }
  if(unlink("dots/.") == 0){
    4caf:	48 b8 74 82 00 00 00 	movabs $0x8274,%rax
    4cb6:	00 00 00 
    4cb9:	48 89 c7             	mov    %rax,%rdi
    4cbc:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    4cc3:	00 00 00 
    4cc6:	ff d0                	call   *%rax
    4cc8:	85 c0                	test   %eax,%eax
    4cca:	75 19                	jne    4ce5 <rmdot+0x16f>
    failexit("unlink dots/. worked");
    4ccc:	48 b8 7b 82 00 00 00 	movabs $0x827b,%rax
    4cd3:	00 00 00 
    4cd6:	48 89 c7             	mov    %rax,%rdi
    4cd9:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4ce0:	00 00 00 
    4ce3:	ff d0                	call   *%rax
  }
  if(unlink("dots/..") == 0){
    4ce5:	48 b8 90 82 00 00 00 	movabs $0x8290,%rax
    4cec:	00 00 00 
    4cef:	48 89 c7             	mov    %rax,%rdi
    4cf2:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    4cf9:	00 00 00 
    4cfc:	ff d0                	call   *%rax
    4cfe:	85 c0                	test   %eax,%eax
    4d00:	75 19                	jne    4d1b <rmdot+0x1a5>
    failexit("unlink dots/.. worked");
    4d02:	48 b8 98 82 00 00 00 	movabs $0x8298,%rax
    4d09:	00 00 00 
    4d0c:	48 89 c7             	mov    %rax,%rdi
    4d0f:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4d16:	00 00 00 
    4d19:	ff d0                	call   *%rax
  }
  if(unlink("dots") != 0){
    4d1b:	48 b8 40 82 00 00 00 	movabs $0x8240,%rax
    4d22:	00 00 00 
    4d25:	48 89 c7             	mov    %rax,%rdi
    4d28:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    4d2f:	00 00 00 
    4d32:	ff d0                	call   *%rax
    4d34:	85 c0                	test   %eax,%eax
    4d36:	74 19                	je     4d51 <rmdot+0x1db>
    failexit("unlink dots");
    4d38:	48 b8 ae 82 00 00 00 	movabs $0x82ae,%rax
    4d3f:	00 00 00 
    4d42:	48 89 c7             	mov    %rax,%rdi
    4d45:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4d4c:	00 00 00 
    4d4f:	ff d0                	call   *%rax
  }
  printf(1, "rmdot ok\n");
    4d51:	48 b8 ba 82 00 00 00 	movabs $0x82ba,%rax
    4d58:	00 00 00 
    4d5b:	48 89 c6             	mov    %rax,%rsi
    4d5e:	bf 01 00 00 00       	mov    $0x1,%edi
    4d63:	b8 00 00 00 00       	mov    $0x0,%eax
    4d68:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    4d6f:	00 00 00 
    4d72:	ff d2                	call   *%rdx
}
    4d74:	90                   	nop
    4d75:	5d                   	pop    %rbp
    4d76:	c3                   	ret

0000000000004d77 <dirfile>:

void
dirfile(void)
{
    4d77:	f3 0f 1e fa          	endbr64
    4d7b:	55                   	push   %rbp
    4d7c:	48 89 e5             	mov    %rsp,%rbp
    4d7f:	48 83 ec 10          	sub    $0x10,%rsp
  int fd;

  printf(1, "dir vs file\n");
    4d83:	48 b8 c4 82 00 00 00 	movabs $0x82c4,%rax
    4d8a:	00 00 00 
    4d8d:	48 89 c6             	mov    %rax,%rsi
    4d90:	bf 01 00 00 00       	mov    $0x1,%edi
    4d95:	b8 00 00 00 00       	mov    $0x0,%eax
    4d9a:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    4da1:	00 00 00 
    4da4:	ff d2                	call   *%rdx

  fd = open("dirfile", O_CREATE);
    4da6:	be 00 02 00 00       	mov    $0x200,%esi
    4dab:	48 b8 d1 82 00 00 00 	movabs $0x82d1,%rax
    4db2:	00 00 00 
    4db5:	48 89 c7             	mov    %rax,%rdi
    4db8:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    4dbf:	00 00 00 
    4dc2:	ff d0                	call   *%rax
    4dc4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    4dc7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    4dcb:	79 19                	jns    4de6 <dirfile+0x6f>
    failexit("create dirfile");
    4dcd:	48 b8 d9 82 00 00 00 	movabs $0x82d9,%rax
    4dd4:	00 00 00 
    4dd7:	48 89 c7             	mov    %rax,%rdi
    4dda:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4de1:	00 00 00 
    4de4:	ff d0                	call   *%rax
  }
  close(fd);
    4de6:	8b 45 fc             	mov    -0x4(%rbp),%eax
    4de9:	89 c7                	mov    %eax,%edi
    4deb:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    4df2:	00 00 00 
    4df5:	ff d0                	call   *%rax
  if(chdir("dirfile") == 0){
    4df7:	48 b8 d1 82 00 00 00 	movabs $0x82d1,%rax
    4dfe:	00 00 00 
    4e01:	48 89 c7             	mov    %rax,%rdi
    4e04:	48 b8 fa 68 00 00 00 	movabs $0x68fa,%rax
    4e0b:	00 00 00 
    4e0e:	ff d0                	call   *%rax
    4e10:	85 c0                	test   %eax,%eax
    4e12:	75 19                	jne    4e2d <dirfile+0xb6>
    failexit("chdir dirfile succeeded");
    4e14:	48 b8 e8 82 00 00 00 	movabs $0x82e8,%rax
    4e1b:	00 00 00 
    4e1e:	48 89 c7             	mov    %rax,%rdi
    4e21:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4e28:	00 00 00 
    4e2b:	ff d0                	call   *%rax
  }
  fd = open("dirfile/xx", 0);
    4e2d:	be 00 00 00 00       	mov    $0x0,%esi
    4e32:	48 b8 00 83 00 00 00 	movabs $0x8300,%rax
    4e39:	00 00 00 
    4e3c:	48 89 c7             	mov    %rax,%rdi
    4e3f:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    4e46:	00 00 00 
    4e49:	ff d0                	call   *%rax
    4e4b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd >= 0){
    4e4e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    4e52:	78 19                	js     4e6d <dirfile+0xf6>
    failexit("create dirfile/xx succeeded");
    4e54:	48 b8 0b 83 00 00 00 	movabs $0x830b,%rax
    4e5b:	00 00 00 
    4e5e:	48 89 c7             	mov    %rax,%rdi
    4e61:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4e68:	00 00 00 
    4e6b:	ff d0                	call   *%rax
  }
  fd = open("dirfile/xx", O_CREATE);
    4e6d:	be 00 02 00 00       	mov    $0x200,%esi
    4e72:	48 b8 00 83 00 00 00 	movabs $0x8300,%rax
    4e79:	00 00 00 
    4e7c:	48 89 c7             	mov    %rax,%rdi
    4e7f:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    4e86:	00 00 00 
    4e89:	ff d0                	call   *%rax
    4e8b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd >= 0){
    4e8e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    4e92:	78 19                	js     4ead <dirfile+0x136>
    failexit("create dirfile/xx succeeded");
    4e94:	48 b8 0b 83 00 00 00 	movabs $0x830b,%rax
    4e9b:	00 00 00 
    4e9e:	48 89 c7             	mov    %rax,%rdi
    4ea1:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4ea8:	00 00 00 
    4eab:	ff d0                	call   *%rax
  }
  if(mkdir("dirfile/xx") == 0){
    4ead:	48 b8 00 83 00 00 00 	movabs $0x8300,%rax
    4eb4:	00 00 00 
    4eb7:	48 89 c7             	mov    %rax,%rdi
    4eba:	48 b8 ed 68 00 00 00 	movabs $0x68ed,%rax
    4ec1:	00 00 00 
    4ec4:	ff d0                	call   *%rax
    4ec6:	85 c0                	test   %eax,%eax
    4ec8:	75 19                	jne    4ee3 <dirfile+0x16c>
    failexit("mkdir dirfile/xx succeeded");
    4eca:	48 b8 27 83 00 00 00 	movabs $0x8327,%rax
    4ed1:	00 00 00 
    4ed4:	48 89 c7             	mov    %rax,%rdi
    4ed7:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4ede:	00 00 00 
    4ee1:	ff d0                	call   *%rax
  }
  if(unlink("dirfile/xx") == 0){
    4ee3:	48 b8 00 83 00 00 00 	movabs $0x8300,%rax
    4eea:	00 00 00 
    4eed:	48 89 c7             	mov    %rax,%rdi
    4ef0:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    4ef7:	00 00 00 
    4efa:	ff d0                	call   *%rax
    4efc:	85 c0                	test   %eax,%eax
    4efe:	75 19                	jne    4f19 <dirfile+0x1a2>
    failexit("unlink dirfile/xx succeeded");
    4f00:	48 b8 42 83 00 00 00 	movabs $0x8342,%rax
    4f07:	00 00 00 
    4f0a:	48 89 c7             	mov    %rax,%rdi
    4f0d:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4f14:	00 00 00 
    4f17:	ff d0                	call   *%rax
  }
  if(link("README", "dirfile/xx") == 0){
    4f19:	48 b8 00 83 00 00 00 	movabs $0x8300,%rax
    4f20:	00 00 00 
    4f23:	48 89 c6             	mov    %rax,%rsi
    4f26:	48 b8 5e 83 00 00 00 	movabs $0x835e,%rax
    4f2d:	00 00 00 
    4f30:	48 89 c7             	mov    %rax,%rdi
    4f33:	48 b8 e0 68 00 00 00 	movabs $0x68e0,%rax
    4f3a:	00 00 00 
    4f3d:	ff d0                	call   *%rax
    4f3f:	85 c0                	test   %eax,%eax
    4f41:	75 19                	jne    4f5c <dirfile+0x1e5>
    failexit("link to dirfile/xx succeeded");
    4f43:	48 b8 65 83 00 00 00 	movabs $0x8365,%rax
    4f4a:	00 00 00 
    4f4d:	48 89 c7             	mov    %rax,%rdi
    4f50:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4f57:	00 00 00 
    4f5a:	ff d0                	call   *%rax
  }
  if(unlink("dirfile") != 0){
    4f5c:	48 b8 d1 82 00 00 00 	movabs $0x82d1,%rax
    4f63:	00 00 00 
    4f66:	48 89 c7             	mov    %rax,%rdi
    4f69:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    4f70:	00 00 00 
    4f73:	ff d0                	call   *%rax
    4f75:	85 c0                	test   %eax,%eax
    4f77:	74 19                	je     4f92 <dirfile+0x21b>
    failexit("unlink dirfile");
    4f79:	48 b8 82 83 00 00 00 	movabs $0x8382,%rax
    4f80:	00 00 00 
    4f83:	48 89 c7             	mov    %rax,%rdi
    4f86:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4f8d:	00 00 00 
    4f90:	ff d0                	call   *%rax
  }

  fd = open(".", O_RDWR);
    4f92:	be 02 00 00 00       	mov    $0x2,%esi
    4f97:	48 b8 62 7a 00 00 00 	movabs $0x7a62,%rax
    4f9e:	00 00 00 
    4fa1:	48 89 c7             	mov    %rax,%rdi
    4fa4:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    4fab:	00 00 00 
    4fae:	ff d0                	call   *%rax
    4fb0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd >= 0){
    4fb3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    4fb7:	78 19                	js     4fd2 <dirfile+0x25b>
    failexit("open . for writing succeeded");
    4fb9:	48 b8 91 83 00 00 00 	movabs $0x8391,%rax
    4fc0:	00 00 00 
    4fc3:	48 89 c7             	mov    %rax,%rdi
    4fc6:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4fcd:	00 00 00 
    4fd0:	ff d0                	call   *%rax
  }
  fd = open(".", 0);
    4fd2:	be 00 00 00 00       	mov    $0x0,%esi
    4fd7:	48 b8 62 7a 00 00 00 	movabs $0x7a62,%rax
    4fde:	00 00 00 
    4fe1:	48 89 c7             	mov    %rax,%rdi
    4fe4:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    4feb:	00 00 00 
    4fee:	ff d0                	call   *%rax
    4ff0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(write(fd, "x", 1) > 0){
    4ff3:	8b 45 fc             	mov    -0x4(%rbp),%eax
    4ff6:	ba 01 00 00 00       	mov    $0x1,%edx
    4ffb:	48 b9 e6 76 00 00 00 	movabs $0x76e6,%rcx
    5002:	00 00 00 
    5005:	48 89 ce             	mov    %rcx,%rsi
    5008:	89 c7                	mov    %eax,%edi
    500a:	48 b8 78 68 00 00 00 	movabs $0x6878,%rax
    5011:	00 00 00 
    5014:	ff d0                	call   *%rax
    5016:	85 c0                	test   %eax,%eax
    5018:	7e 19                	jle    5033 <dirfile+0x2bc>
    failexit("write . succeeded");
    501a:	48 b8 ae 83 00 00 00 	movabs $0x83ae,%rax
    5021:	00 00 00 
    5024:	48 89 c7             	mov    %rax,%rdi
    5027:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    502e:	00 00 00 
    5031:	ff d0                	call   *%rax
  }
  close(fd);
    5033:	8b 45 fc             	mov    -0x4(%rbp),%eax
    5036:	89 c7                	mov    %eax,%edi
    5038:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    503f:	00 00 00 
    5042:	ff d0                	call   *%rax

  printf(1, "dir vs file OK\n");
    5044:	48 b8 c0 83 00 00 00 	movabs $0x83c0,%rax
    504b:	00 00 00 
    504e:	48 89 c6             	mov    %rax,%rsi
    5051:	bf 01 00 00 00       	mov    $0x1,%edi
    5056:	b8 00 00 00 00       	mov    $0x0,%eax
    505b:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    5062:	00 00 00 
    5065:	ff d2                	call   *%rdx
}
    5067:	90                   	nop
    5068:	c9                   	leave
    5069:	c3                   	ret

000000000000506a <iref>:

// test that iput() is called at the end of _namei()
void
iref(void)
{
    506a:	f3 0f 1e fa          	endbr64
    506e:	55                   	push   %rbp
    506f:	48 89 e5             	mov    %rsp,%rbp
    5072:	48 83 ec 10          	sub    $0x10,%rsp
  int i, fd;

  printf(1, "empty file name\n");
    5076:	48 b8 d0 83 00 00 00 	movabs $0x83d0,%rax
    507d:	00 00 00 
    5080:	48 89 c6             	mov    %rax,%rsi
    5083:	bf 01 00 00 00       	mov    $0x1,%edi
    5088:	b8 00 00 00 00       	mov    $0x0,%eax
    508d:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    5094:	00 00 00 
    5097:	ff d2                	call   *%rdx

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    5099:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    50a0:	e9 38 01 00 00       	jmp    51dd <iref+0x173>
    if(mkdir("irefd") != 0){
    50a5:	48 b8 e1 83 00 00 00 	movabs $0x83e1,%rax
    50ac:	00 00 00 
    50af:	48 89 c7             	mov    %rax,%rdi
    50b2:	48 b8 ed 68 00 00 00 	movabs $0x68ed,%rax
    50b9:	00 00 00 
    50bc:	ff d0                	call   *%rax
    50be:	85 c0                	test   %eax,%eax
    50c0:	74 19                	je     50db <iref+0x71>
      failexit("mkdir irefd");
    50c2:	48 b8 e7 83 00 00 00 	movabs $0x83e7,%rax
    50c9:	00 00 00 
    50cc:	48 89 c7             	mov    %rax,%rdi
    50cf:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    50d6:	00 00 00 
    50d9:	ff d0                	call   *%rax
    }
    if(chdir("irefd") != 0){
    50db:	48 b8 e1 83 00 00 00 	movabs $0x83e1,%rax
    50e2:	00 00 00 
    50e5:	48 89 c7             	mov    %rax,%rdi
    50e8:	48 b8 fa 68 00 00 00 	movabs $0x68fa,%rax
    50ef:	00 00 00 
    50f2:	ff d0                	call   *%rax
    50f4:	85 c0                	test   %eax,%eax
    50f6:	74 19                	je     5111 <iref+0xa7>
      failexit("chdir irefd");
    50f8:	48 b8 f3 83 00 00 00 	movabs $0x83f3,%rax
    50ff:	00 00 00 
    5102:	48 89 c7             	mov    %rax,%rdi
    5105:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    510c:	00 00 00 
    510f:	ff d0                	call   *%rax
    }

    mkdir("");
    5111:	48 b8 ff 83 00 00 00 	movabs $0x83ff,%rax
    5118:	00 00 00 
    511b:	48 89 c7             	mov    %rax,%rdi
    511e:	48 b8 ed 68 00 00 00 	movabs $0x68ed,%rax
    5125:	00 00 00 
    5128:	ff d0                	call   *%rax
    link("README", "");
    512a:	48 b8 ff 83 00 00 00 	movabs $0x83ff,%rax
    5131:	00 00 00 
    5134:	48 89 c6             	mov    %rax,%rsi
    5137:	48 b8 5e 83 00 00 00 	movabs $0x835e,%rax
    513e:	00 00 00 
    5141:	48 89 c7             	mov    %rax,%rdi
    5144:	48 b8 e0 68 00 00 00 	movabs $0x68e0,%rax
    514b:	00 00 00 
    514e:	ff d0                	call   *%rax
    fd = open("", O_CREATE);
    5150:	be 00 02 00 00       	mov    $0x200,%esi
    5155:	48 b8 ff 83 00 00 00 	movabs $0x83ff,%rax
    515c:	00 00 00 
    515f:	48 89 c7             	mov    %rax,%rdi
    5162:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    5169:	00 00 00 
    516c:	ff d0                	call   *%rax
    516e:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(fd >= 0)
    5171:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    5175:	78 11                	js     5188 <iref+0x11e>
      close(fd);
    5177:	8b 45 f8             	mov    -0x8(%rbp),%eax
    517a:	89 c7                	mov    %eax,%edi
    517c:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    5183:	00 00 00 
    5186:	ff d0                	call   *%rax
    fd = open("xx", O_CREATE);
    5188:	be 00 02 00 00       	mov    $0x200,%esi
    518d:	48 b8 00 84 00 00 00 	movabs $0x8400,%rax
    5194:	00 00 00 
    5197:	48 89 c7             	mov    %rax,%rdi
    519a:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    51a1:	00 00 00 
    51a4:	ff d0                	call   *%rax
    51a6:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(fd >= 0)
    51a9:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    51ad:	78 11                	js     51c0 <iref+0x156>
      close(fd);
    51af:	8b 45 f8             	mov    -0x8(%rbp),%eax
    51b2:	89 c7                	mov    %eax,%edi
    51b4:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    51bb:	00 00 00 
    51be:	ff d0                	call   *%rax
    unlink("xx");
    51c0:	48 b8 00 84 00 00 00 	movabs $0x8400,%rax
    51c7:	00 00 00 
    51ca:	48 89 c7             	mov    %rax,%rdi
    51cd:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    51d4:	00 00 00 
    51d7:	ff d0                	call   *%rax
  for(i = 0; i < 50 + 1; i++){
    51d9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    51dd:	83 7d fc 32          	cmpl   $0x32,-0x4(%rbp)
    51e1:	0f 8e be fe ff ff    	jle    50a5 <iref+0x3b>
  }

  chdir("/");
    51e7:	48 b8 d0 72 00 00 00 	movabs $0x72d0,%rax
    51ee:	00 00 00 
    51f1:	48 89 c7             	mov    %rax,%rdi
    51f4:	48 b8 fa 68 00 00 00 	movabs $0x68fa,%rax
    51fb:	00 00 00 
    51fe:	ff d0                	call   *%rax
  printf(1, "empty file name OK\n");
    5200:	48 b8 03 84 00 00 00 	movabs $0x8403,%rax
    5207:	00 00 00 
    520a:	48 89 c6             	mov    %rax,%rsi
    520d:	bf 01 00 00 00       	mov    $0x1,%edi
    5212:	b8 00 00 00 00       	mov    $0x0,%eax
    5217:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    521e:	00 00 00 
    5221:	ff d2                	call   *%rdx
}
    5223:	90                   	nop
    5224:	c9                   	leave
    5225:	c3                   	ret

0000000000005226 <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    5226:	f3 0f 1e fa          	endbr64
    522a:	55                   	push   %rbp
    522b:	48 89 e5             	mov    %rsp,%rbp
    522e:	48 83 ec 10          	sub    $0x10,%rsp
  int n, pid;

  printf(1, "fork test\n");
    5232:	48 b8 17 84 00 00 00 	movabs $0x8417,%rax
    5239:	00 00 00 
    523c:	48 89 c6             	mov    %rax,%rsi
    523f:	bf 01 00 00 00       	mov    $0x1,%edi
    5244:	b8 00 00 00 00       	mov    $0x0,%eax
    5249:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    5250:	00 00 00 
    5253:	ff d2                	call   *%rdx

  for(n=0; n<1000; n++){
    5255:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    525c:	eb 2b                	jmp    5289 <forktest+0x63>
    pid = fork();
    525e:	48 b8 37 68 00 00 00 	movabs $0x6837,%rax
    5265:	00 00 00 
    5268:	ff d0                	call   *%rax
    526a:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(pid < 0)
    526d:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    5271:	78 21                	js     5294 <forktest+0x6e>
      break;
    if(pid == 0)
    5273:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    5277:	75 0c                	jne    5285 <forktest+0x5f>
      exit();
    5279:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    5280:	00 00 00 
    5283:	ff d0                	call   *%rax
  for(n=0; n<1000; n++){
    5285:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    5289:	81 7d fc e7 03 00 00 	cmpl   $0x3e7,-0x4(%rbp)
    5290:	7e cc                	jle    525e <forktest+0x38>
    5292:	eb 01                	jmp    5295 <forktest+0x6f>
      break;
    5294:	90                   	nop
  }

  if(n == 1000){
    5295:	81 7d fc e8 03 00 00 	cmpl   $0x3e8,-0x4(%rbp)
    529c:	75 48                	jne    52e6 <forktest+0xc0>
    failexit("fork claimed to work 1000 times");
    529e:	48 b8 28 84 00 00 00 	movabs $0x8428,%rax
    52a5:	00 00 00 
    52a8:	48 89 c7             	mov    %rax,%rdi
    52ab:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    52b2:	00 00 00 
    52b5:	ff d0                	call   *%rax
  }

  for(; n > 0; n--){
    52b7:	eb 2d                	jmp    52e6 <forktest+0xc0>
    if(wait() < 0){
    52b9:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    52c0:	00 00 00 
    52c3:	ff d0                	call   *%rax
    52c5:	85 c0                	test   %eax,%eax
    52c7:	79 19                	jns    52e2 <forktest+0xbc>
      failexit("wait stopped early");
    52c9:	48 b8 48 84 00 00 00 	movabs $0x8448,%rax
    52d0:	00 00 00 
    52d3:	48 89 c7             	mov    %rax,%rdi
    52d6:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    52dd:	00 00 00 
    52e0:	ff d0                	call   *%rax
  for(; n > 0; n--){
    52e2:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
    52e6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    52ea:	7f cd                	jg     52b9 <forktest+0x93>
    }
  }

  if(wait() != -1){
    52ec:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    52f3:	00 00 00 
    52f6:	ff d0                	call   *%rax
    52f8:	83 f8 ff             	cmp    $0xffffffff,%eax
    52fb:	74 19                	je     5316 <forktest+0xf0>
    failexit("wait got too many");
    52fd:	48 b8 5b 84 00 00 00 	movabs $0x845b,%rax
    5304:	00 00 00 
    5307:	48 89 c7             	mov    %rax,%rdi
    530a:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    5311:	00 00 00 
    5314:	ff d0                	call   *%rax
  }

  printf(1, "fork test OK\n");
    5316:	48 b8 6d 84 00 00 00 	movabs $0x846d,%rax
    531d:	00 00 00 
    5320:	48 89 c6             	mov    %rax,%rsi
    5323:	bf 01 00 00 00       	mov    $0x1,%edi
    5328:	b8 00 00 00 00       	mov    $0x0,%eax
    532d:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    5334:	00 00 00 
    5337:	ff d2                	call   *%rdx
}
    5339:	90                   	nop
    533a:	c9                   	leave
    533b:	c3                   	ret

000000000000533c <sbrktest>:

void
sbrktest(void)
{
    533c:	f3 0f 1e fa          	endbr64
    5340:	55                   	push   %rbp
    5341:	48 89 e5             	mov    %rsp,%rbp
    5344:	48 81 ec 90 00 00 00 	sub    $0x90,%rsp
  int fds[2], pid, pids[10], ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(1, "sbrk test\n");
    534b:	48 b8 7b 84 00 00 00 	movabs $0x847b,%rax
    5352:	00 00 00 
    5355:	48 89 c6             	mov    %rax,%rsi
    5358:	bf 01 00 00 00       	mov    $0x1,%edi
    535d:	b8 00 00 00 00       	mov    $0x0,%eax
    5362:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    5369:	00 00 00 
    536c:	ff d2                	call   *%rdx
  oldbrk = sbrk(0);
    536e:	bf 00 00 00 00       	mov    $0x0,%edi
    5373:	48 b8 21 69 00 00 00 	movabs $0x6921,%rax
    537a:	00 00 00 
    537d:	ff d0                	call   *%rax
    537f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

  // can one sbrk() less than a page?
  a = sbrk(0);
    5383:	bf 00 00 00 00       	mov    $0x0,%edi
    5388:	48 b8 21 69 00 00 00 	movabs $0x6921,%rax
    538f:	00 00 00 
    5392:	ff d0                	call   *%rax
    5394:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  int i;
  for(i = 0; i < 5000; i++){
    5398:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    539f:	eb 79                	jmp    541a <sbrktest+0xde>
    b = sbrk(1);
    53a1:	bf 01 00 00 00       	mov    $0x1,%edi
    53a6:	48 b8 21 69 00 00 00 	movabs $0x6921,%rax
    53ad:	00 00 00 
    53b0:	ff d0                	call   *%rax
    53b2:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
    if(b != a){
    53b6:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    53ba:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
    53be:	74 43                	je     5403 <sbrktest+0xc7>
      printf(1, "sbrk test failed %d %p %p\n", i, a, b);
    53c0:	48 8b 4d b0          	mov    -0x50(%rbp),%rcx
    53c4:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
    53c8:	8b 45 f4             	mov    -0xc(%rbp),%eax
    53cb:	49 89 c8             	mov    %rcx,%r8
    53ce:	48 89 d1             	mov    %rdx,%rcx
    53d1:	89 c2                	mov    %eax,%edx
    53d3:	48 b8 86 84 00 00 00 	movabs $0x8486,%rax
    53da:	00 00 00 
    53dd:	48 89 c6             	mov    %rax,%rsi
    53e0:	bf 01 00 00 00       	mov    $0x1,%edi
    53e5:	b8 00 00 00 00       	mov    $0x0,%eax
    53ea:	49 b9 55 6b 00 00 00 	movabs $0x6b55,%r9
    53f1:	00 00 00 
    53f4:	41 ff d1             	call   *%r9
      exit();
    53f7:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    53fe:	00 00 00 
    5401:	ff d0                	call   *%rax
    }
    *b = 1;
    5403:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    5407:	c6 00 01             	movb   $0x1,(%rax)
    a = b + 1;
    540a:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    540e:	48 83 c0 01          	add    $0x1,%rax
    5412:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  for(i = 0; i < 5000; i++){
    5416:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
    541a:	81 7d f4 87 13 00 00 	cmpl   $0x1387,-0xc(%rbp)
    5421:	0f 8e 7a ff ff ff    	jle    53a1 <sbrktest+0x65>
  }
  pid = fork();
    5427:	48 b8 37 68 00 00 00 	movabs $0x6837,%rax
    542e:	00 00 00 
    5431:	ff d0                	call   *%rax
    5433:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  if(pid < 0){
    5436:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
    543a:	79 19                	jns    5455 <sbrktest+0x119>
    failexit("sbrk test fork");
    543c:	48 b8 a1 84 00 00 00 	movabs $0x84a1,%rax
    5443:	00 00 00 
    5446:	48 89 c7             	mov    %rax,%rdi
    5449:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    5450:	00 00 00 
    5453:	ff d0                	call   *%rax
  }
  c = sbrk(1);
    5455:	bf 01 00 00 00       	mov    $0x1,%edi
    545a:	48 b8 21 69 00 00 00 	movabs $0x6921,%rax
    5461:	00 00 00 
    5464:	ff d0                	call   *%rax
    5466:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  c = sbrk(1);
    546a:	bf 01 00 00 00       	mov    $0x1,%edi
    546f:	48 b8 21 69 00 00 00 	movabs $0x6921,%rax
    5476:	00 00 00 
    5479:	ff d0                	call   *%rax
    547b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  if(c != a + 1){
    547f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    5483:	48 83 c0 01          	add    $0x1,%rax
    5487:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
    548b:	74 19                	je     54a6 <sbrktest+0x16a>
    failexit("sbrk test failed post-fork");
    548d:	48 b8 b0 84 00 00 00 	movabs $0x84b0,%rax
    5494:	00 00 00 
    5497:	48 89 c7             	mov    %rax,%rdi
    549a:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    54a1:	00 00 00 
    54a4:	ff d0                	call   *%rax
  }
  if(pid == 0)
    54a6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
    54aa:	75 0c                	jne    54b8 <sbrktest+0x17c>
    exit();
    54ac:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    54b3:	00 00 00 
    54b6:	ff d0                	call   *%rax
  wait();
    54b8:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    54bf:	00 00 00 
    54c2:	ff d0                	call   *%rax

  // can one grow address space to something big?
#define BIG (100*1024*1024)
  a = sbrk(0);
    54c4:	bf 00 00 00 00       	mov    $0x0,%edi
    54c9:	48 b8 21 69 00 00 00 	movabs $0x6921,%rax
    54d0:	00 00 00 
    54d3:	ff d0                	call   *%rax
    54d5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  amt = (BIG) - (addr_t)a;
    54d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    54dd:	89 c2                	mov    %eax,%edx
    54df:	b8 00 00 40 06       	mov    $0x6400000,%eax
    54e4:	29 d0                	sub    %edx,%eax
    54e6:	89 45 d4             	mov    %eax,-0x2c(%rbp)
  p = sbrk(amt);
    54e9:	8b 45 d4             	mov    -0x2c(%rbp),%eax
    54ec:	48 89 c7             	mov    %rax,%rdi
    54ef:	48 b8 21 69 00 00 00 	movabs $0x6921,%rax
    54f6:	00 00 00 
    54f9:	ff d0                	call   *%rax
    54fb:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  if (p != a) {
    54ff:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    5503:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
    5507:	74 19                	je     5522 <sbrktest+0x1e6>
    failexit("sbrk test failed to grow big address space; enough phys mem?");
    5509:	48 b8 d0 84 00 00 00 	movabs $0x84d0,%rax
    5510:	00 00 00 
    5513:	48 89 c7             	mov    %rax,%rdi
    5516:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    551d:	00 00 00 
    5520:	ff d0                	call   *%rax
  }
  lastaddr = (char*) (BIG-1);
    5522:	48 c7 45 c0 ff ff 3f 	movq   $0x63fffff,-0x40(%rbp)
    5529:	06 
  *lastaddr = 99;
    552a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
    552e:	c6 00 63             	movb   $0x63,(%rax)

  // can one de-allocate?
  a = sbrk(0);
    5531:	bf 00 00 00 00       	mov    $0x0,%edi
    5536:	48 b8 21 69 00 00 00 	movabs $0x6921,%rax
    553d:	00 00 00 
    5540:	ff d0                	call   *%rax
    5542:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  c = sbrk(-4096);
    5546:	48 c7 c7 00 f0 ff ff 	mov    $0xfffffffffffff000,%rdi
    554d:	48 b8 21 69 00 00 00 	movabs $0x6921,%rax
    5554:	00 00 00 
    5557:	ff d0                	call   *%rax
    5559:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  if(c == (char*)0xffffffff){
    555d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    5562:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
    5566:	75 19                	jne    5581 <sbrktest+0x245>
    failexit("sbrk could not deallocate");
    5568:	48 b8 0d 85 00 00 00 	movabs $0x850d,%rax
    556f:	00 00 00 
    5572:	48 89 c7             	mov    %rax,%rdi
    5575:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    557c:	00 00 00 
    557f:	ff d0                	call   *%rax
  }
  c = sbrk(0);
    5581:	bf 00 00 00 00       	mov    $0x0,%edi
    5586:	48 b8 21 69 00 00 00 	movabs $0x6921,%rax
    558d:	00 00 00 
    5590:	ff d0                	call   *%rax
    5592:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  if(c != a - 4096){
    5596:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    559a:	48 2d 00 10 00 00    	sub    $0x1000,%rax
    55a0:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
    55a4:	74 3e                	je     55e4 <sbrktest+0x2a8>
    printf(1, "sbrk deallocation produced wrong address, a %p c %p\n", a, c);
    55a6:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
    55aa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    55ae:	48 89 d1             	mov    %rdx,%rcx
    55b1:	48 89 c2             	mov    %rax,%rdx
    55b4:	48 b8 28 85 00 00 00 	movabs $0x8528,%rax
    55bb:	00 00 00 
    55be:	48 89 c6             	mov    %rax,%rsi
    55c1:	bf 01 00 00 00       	mov    $0x1,%edi
    55c6:	b8 00 00 00 00       	mov    $0x0,%eax
    55cb:	49 b8 55 6b 00 00 00 	movabs $0x6b55,%r8
    55d2:	00 00 00 
    55d5:	41 ff d0             	call   *%r8
    exit();
    55d8:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    55df:	00 00 00 
    55e2:	ff d0                	call   *%rax
  }

  // can one re-allocate that page?
  a = sbrk(0);
    55e4:	bf 00 00 00 00       	mov    $0x0,%edi
    55e9:	48 b8 21 69 00 00 00 	movabs $0x6921,%rax
    55f0:	00 00 00 
    55f3:	ff d0                	call   *%rax
    55f5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  c = sbrk(4096);
    55f9:	bf 00 10 00 00       	mov    $0x1000,%edi
    55fe:	48 b8 21 69 00 00 00 	movabs $0x6921,%rax
    5605:	00 00 00 
    5608:	ff d0                	call   *%rax
    560a:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  if(c != a || sbrk(0) != a + 4096){
    560e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    5612:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
    5616:	75 21                	jne    5639 <sbrktest+0x2fd>
    5618:	bf 00 00 00 00       	mov    $0x0,%edi
    561d:	48 b8 21 69 00 00 00 	movabs $0x6921,%rax
    5624:	00 00 00 
    5627:	ff d0                	call   *%rax
    5629:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
    562d:	48 81 c2 00 10 00 00 	add    $0x1000,%rdx
    5634:	48 39 d0             	cmp    %rdx,%rax
    5637:	74 3e                	je     5677 <sbrktest+0x33b>
    printf(1, "sbrk re-allocation failed, a %p c %p\n", a, c);
    5639:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
    563d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    5641:	48 89 d1             	mov    %rdx,%rcx
    5644:	48 89 c2             	mov    %rax,%rdx
    5647:	48 b8 60 85 00 00 00 	movabs $0x8560,%rax
    564e:	00 00 00 
    5651:	48 89 c6             	mov    %rax,%rsi
    5654:	bf 01 00 00 00       	mov    $0x1,%edi
    5659:	b8 00 00 00 00       	mov    $0x0,%eax
    565e:	49 b8 55 6b 00 00 00 	movabs $0x6b55,%r8
    5665:	00 00 00 
    5668:	41 ff d0             	call   *%r8
    exit();
    566b:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    5672:	00 00 00 
    5675:	ff d0                	call   *%rax
  }
  if(*lastaddr == 99){
    5677:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
    567b:	0f b6 00             	movzbl (%rax),%eax
    567e:	3c 63                	cmp    $0x63,%al
    5680:	75 19                	jne    569b <sbrktest+0x35f>
    // should be zero
    failexit("sbrk de-allocation didn't really deallocate");
    5682:	48 b8 88 85 00 00 00 	movabs $0x8588,%rax
    5689:	00 00 00 
    568c:	48 89 c7             	mov    %rax,%rdi
    568f:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    5696:	00 00 00 
    5699:	ff d0                	call   *%rax
  }

  a = sbrk(0);
    569b:	bf 00 00 00 00       	mov    $0x0,%edi
    56a0:	48 b8 21 69 00 00 00 	movabs $0x6921,%rax
    56a7:	00 00 00 
    56aa:	ff d0                	call   *%rax
    56ac:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  c = sbrk(-(sbrk(0) - oldbrk));
    56b0:	bf 00 00 00 00       	mov    $0x0,%edi
    56b5:	48 b8 21 69 00 00 00 	movabs $0x6921,%rax
    56bc:	00 00 00 
    56bf:	ff d0                	call   *%rax
    56c1:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
    56c5:	48 29 c2             	sub    %rax,%rdx
    56c8:	48 89 d0             	mov    %rdx,%rax
    56cb:	48 89 c7             	mov    %rax,%rdi
    56ce:	48 b8 21 69 00 00 00 	movabs $0x6921,%rax
    56d5:	00 00 00 
    56d8:	ff d0                	call   *%rax
    56da:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  if(c != a){
    56de:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    56e2:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
    56e6:	74 3e                	je     5726 <sbrktest+0x3ea>
    printf(1, "sbrk downsize failed, a %p c %p\n", a, c);
    56e8:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
    56ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    56f0:	48 89 d1             	mov    %rdx,%rcx
    56f3:	48 89 c2             	mov    %rax,%rdx
    56f6:	48 b8 b8 85 00 00 00 	movabs $0x85b8,%rax
    56fd:	00 00 00 
    5700:	48 89 c6             	mov    %rax,%rsi
    5703:	bf 01 00 00 00       	mov    $0x1,%edi
    5708:	b8 00 00 00 00       	mov    $0x0,%eax
    570d:	49 b8 55 6b 00 00 00 	movabs $0x6b55,%r8
    5714:	00 00 00 
    5717:	41 ff d0             	call   *%r8
    exit();
    571a:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    5721:	00 00 00 
    5724:	ff d0                	call   *%rax
  }

  printf(1, "expecting 10 killed processes:\n");
    5726:	48 b8 e0 85 00 00 00 	movabs $0x85e0,%rax
    572d:	00 00 00 
    5730:	48 89 c6             	mov    %rax,%rsi
    5733:	bf 01 00 00 00       	mov    $0x1,%edi
    5738:	b8 00 00 00 00       	mov    $0x0,%eax
    573d:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    5744:	00 00 00 
    5747:	ff d2                	call   *%rdx
  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+1000000); a += 100000){
    5749:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
    5750:	80 ff ff 
    5753:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    5757:	e9 ab 00 00 00       	jmp    5807 <sbrktest+0x4cb>
    ppid = getpid();
    575c:	48 b8 14 69 00 00 00 	movabs $0x6914,%rax
    5763:	00 00 00 
    5766:	ff d0                	call   *%rax
    5768:	89 45 b8             	mov    %eax,-0x48(%rbp)
    pid = fork();
    576b:	48 b8 37 68 00 00 00 	movabs $0x6837,%rax
    5772:	00 00 00 
    5775:	ff d0                	call   *%rax
    5777:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if(pid < 0){
    577a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
    577e:	79 19                	jns    5799 <sbrktest+0x45d>
      failexit("fork");
    5780:	48 b8 f7 72 00 00 00 	movabs $0x72f7,%rax
    5787:	00 00 00 
    578a:	48 89 c7             	mov    %rax,%rdi
    578d:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    5794:	00 00 00 
    5797:	ff d0                	call   *%rax
    }
    if(pid == 0){
    5799:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
    579d:	75 54                	jne    57f3 <sbrktest+0x4b7>
      printf(1, "oops could read %p = %c\n", a, *a);
    579f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    57a3:	0f b6 00             	movzbl (%rax),%eax
    57a6:	0f be d0             	movsbl %al,%edx
    57a9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    57ad:	89 d1                	mov    %edx,%ecx
    57af:	48 89 c2             	mov    %rax,%rdx
    57b2:	48 b8 00 86 00 00 00 	movabs $0x8600,%rax
    57b9:	00 00 00 
    57bc:	48 89 c6             	mov    %rax,%rsi
    57bf:	bf 01 00 00 00       	mov    $0x1,%edi
    57c4:	b8 00 00 00 00       	mov    $0x0,%eax
    57c9:	49 b8 55 6b 00 00 00 	movabs $0x6b55,%r8
    57d0:	00 00 00 
    57d3:	41 ff d0             	call   *%r8
      kill(ppid);
    57d6:	8b 45 b8             	mov    -0x48(%rbp),%eax
    57d9:	89 c7                	mov    %eax,%edi
    57db:	48 b8 92 68 00 00 00 	movabs $0x6892,%rax
    57e2:	00 00 00 
    57e5:	ff d0                	call   *%rax
      exit();
    57e7:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    57ee:	00 00 00 
    57f1:	ff d0                	call   *%rax
    }
    wait();
    57f3:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    57fa:	00 00 00 
    57fd:	ff d0                	call   *%rax
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+1000000); a += 100000){
    57ff:	48 81 45 f8 a0 86 01 	addq   $0x186a0,-0x8(%rbp)
    5806:	00 
    5807:	48 b8 3f 42 0f 00 00 	movabs $0xffff8000000f423f,%rax
    580e:	80 ff ff 
    5811:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
    5815:	0f 83 41 ff ff ff    	jae    575c <sbrktest+0x420>
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    581b:	48 8d 45 a8          	lea    -0x58(%rbp),%rax
    581f:	48 89 c7             	mov    %rax,%rdi
    5822:	48 b8 5e 68 00 00 00 	movabs $0x685e,%rax
    5829:	00 00 00 
    582c:	ff d0                	call   *%rax
    582e:	85 c0                	test   %eax,%eax
    5830:	74 19                	je     584b <sbrktest+0x50f>
    failexit("pipe()");
    5832:	48 b8 93 76 00 00 00 	movabs $0x7693,%rax
    5839:	00 00 00 
    583c:	48 89 c7             	mov    %rax,%rdi
    583f:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    5846:	00 00 00 
    5849:	ff d0                	call   *%rax
  }
  printf(1, "expecting failed sbrk()s:\n");
    584b:	48 b8 19 86 00 00 00 	movabs $0x8619,%rax
    5852:	00 00 00 
    5855:	48 89 c6             	mov    %rax,%rsi
    5858:	bf 01 00 00 00       	mov    $0x1,%edi
    585d:	b8 00 00 00 00       	mov    $0x0,%eax
    5862:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    5869:	00 00 00 
    586c:	ff d2                	call   *%rdx
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    586e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    5875:	e9 e6 00 00 00       	jmp    5960 <sbrktest+0x624>
    if((pids[i] = fork()) == 0){
    587a:	48 b8 37 68 00 00 00 	movabs $0x6837,%rax
    5881:	00 00 00 
    5884:	ff d0                	call   *%rax
    5886:	8b 55 f4             	mov    -0xc(%rbp),%edx
    5889:	48 63 d2             	movslq %edx,%rdx
    588c:	89 44 95 80          	mov    %eax,-0x80(%rbp,%rdx,4)
    5890:	8b 45 f4             	mov    -0xc(%rbp),%eax
    5893:	48 98                	cltq
    5895:	8b 44 85 80          	mov    -0x80(%rbp,%rax,4),%eax
    5899:	85 c0                	test   %eax,%eax
    589b:	0f 85 8d 00 00 00    	jne    592e <sbrktest+0x5f2>
      // allocate a lot of memory
      int ret = (int)(addr_t)sbrk(BIG - (addr_t)sbrk(0));
    58a1:	bf 00 00 00 00       	mov    $0x0,%edi
    58a6:	48 b8 21 69 00 00 00 	movabs $0x6921,%rax
    58ad:	00 00 00 
    58b0:	ff d0                	call   *%rax
    58b2:	48 89 c2             	mov    %rax,%rdx
    58b5:	b8 00 00 40 06       	mov    $0x6400000,%eax
    58ba:	48 29 d0             	sub    %rdx,%rax
    58bd:	48 89 c7             	mov    %rax,%rdi
    58c0:	48 b8 21 69 00 00 00 	movabs $0x6921,%rax
    58c7:	00 00 00 
    58ca:	ff d0                	call   *%rax
    58cc:	89 45 bc             	mov    %eax,-0x44(%rbp)
      if(ret < 0)
    58cf:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
    58d3:	79 23                	jns    58f8 <sbrktest+0x5bc>
        printf(1, "sbrk returned -1 as expected\n");
    58d5:	48 b8 34 86 00 00 00 	movabs $0x8634,%rax
    58dc:	00 00 00 
    58df:	48 89 c6             	mov    %rax,%rsi
    58e2:	bf 01 00 00 00       	mov    $0x1,%edi
    58e7:	b8 00 00 00 00       	mov    $0x0,%eax
    58ec:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    58f3:	00 00 00 
    58f6:	ff d2                	call   *%rdx
      write(fds[1], "x", 1);
    58f8:	8b 45 ac             	mov    -0x54(%rbp),%eax
    58fb:	ba 01 00 00 00       	mov    $0x1,%edx
    5900:	48 b9 e6 76 00 00 00 	movabs $0x76e6,%rcx
    5907:	00 00 00 
    590a:	48 89 ce             	mov    %rcx,%rsi
    590d:	89 c7                	mov    %eax,%edi
    590f:	48 b8 78 68 00 00 00 	movabs $0x6878,%rax
    5916:	00 00 00 
    5919:	ff d0                	call   *%rax
      // sit around until killed
      for(;;)
        sleep(1000);
    591b:	bf e8 03 00 00       	mov    $0x3e8,%edi
    5920:	48 b8 2e 69 00 00 00 	movabs $0x692e,%rax
    5927:	00 00 00 
    592a:	ff d0                	call   *%rax
    592c:	eb ed                	jmp    591b <sbrktest+0x5df>
    }
    if(pids[i] != -1)
    592e:	8b 45 f4             	mov    -0xc(%rbp),%eax
    5931:	48 98                	cltq
    5933:	8b 44 85 80          	mov    -0x80(%rbp,%rax,4),%eax
    5937:	83 f8 ff             	cmp    $0xffffffff,%eax
    593a:	74 20                	je     595c <sbrktest+0x620>
      read(fds[0], &scratch, 1); // wait
    593c:	8b 45 a8             	mov    -0x58(%rbp),%eax
    593f:	48 8d 8d 7f ff ff ff 	lea    -0x81(%rbp),%rcx
    5946:	ba 01 00 00 00       	mov    $0x1,%edx
    594b:	48 89 ce             	mov    %rcx,%rsi
    594e:	89 c7                	mov    %eax,%edi
    5950:	48 b8 6b 68 00 00 00 	movabs $0x686b,%rax
    5957:	00 00 00 
    595a:	ff d0                	call   *%rax
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    595c:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
    5960:	8b 45 f4             	mov    -0xc(%rbp),%eax
    5963:	83 f8 09             	cmp    $0x9,%eax
    5966:	0f 86 0e ff ff ff    	jbe    587a <sbrktest+0x53e>
  }

  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate one here
  c = sbrk(4096);
    596c:	bf 00 10 00 00       	mov    $0x1000,%edi
    5971:	48 b8 21 69 00 00 00 	movabs $0x6921,%rax
    5978:	00 00 00 
    597b:	ff d0                	call   *%rax
    597d:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    5981:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    5988:	eb 38                	jmp    59c2 <sbrktest+0x686>
    if(pids[i] == -1)
    598a:	8b 45 f4             	mov    -0xc(%rbp),%eax
    598d:	48 98                	cltq
    598f:	8b 44 85 80          	mov    -0x80(%rbp,%rax,4),%eax
    5993:	83 f8 ff             	cmp    $0xffffffff,%eax
    5996:	74 25                	je     59bd <sbrktest+0x681>
      continue;
    kill(pids[i]);
    5998:	8b 45 f4             	mov    -0xc(%rbp),%eax
    599b:	48 98                	cltq
    599d:	8b 44 85 80          	mov    -0x80(%rbp,%rax,4),%eax
    59a1:	89 c7                	mov    %eax,%edi
    59a3:	48 b8 92 68 00 00 00 	movabs $0x6892,%rax
    59aa:	00 00 00 
    59ad:	ff d0                	call   *%rax
    wait();
    59af:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    59b6:	00 00 00 
    59b9:	ff d0                	call   *%rax
    59bb:	eb 01                	jmp    59be <sbrktest+0x682>
      continue;
    59bd:	90                   	nop
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    59be:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
    59c2:	8b 45 f4             	mov    -0xc(%rbp),%eax
    59c5:	83 f8 09             	cmp    $0x9,%eax
    59c8:	76 c0                	jbe    598a <sbrktest+0x64e>
  }
  if(c == (char*)0xffffffff){ // ?
    59ca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    59cf:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
    59d3:	75 19                	jne    59ee <sbrktest+0x6b2>
    failexit("failed sbrk leaked memory");
    59d5:	48 b8 52 86 00 00 00 	movabs $0x8652,%rax
    59dc:	00 00 00 
    59df:	48 89 c7             	mov    %rax,%rdi
    59e2:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    59e9:	00 00 00 
    59ec:	ff d0                	call   *%rax
  }

  if(sbrk(0) > oldbrk)
    59ee:	bf 00 00 00 00       	mov    $0x0,%edi
    59f3:	48 b8 21 69 00 00 00 	movabs $0x6921,%rax
    59fa:	00 00 00 
    59fd:	ff d0                	call   *%rax
    59ff:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
    5a03:	73 2a                	jae    5a2f <sbrktest+0x6f3>
    sbrk(-(sbrk(0) - oldbrk));
    5a05:	bf 00 00 00 00       	mov    $0x0,%edi
    5a0a:	48 b8 21 69 00 00 00 	movabs $0x6921,%rax
    5a11:	00 00 00 
    5a14:	ff d0                	call   *%rax
    5a16:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
    5a1a:	48 29 c2             	sub    %rax,%rdx
    5a1d:	48 89 d0             	mov    %rdx,%rax
    5a20:	48 89 c7             	mov    %rax,%rdi
    5a23:	48 b8 21 69 00 00 00 	movabs $0x6921,%rax
    5a2a:	00 00 00 
    5a2d:	ff d0                	call   *%rax

  printf(1, "sbrk test OK\n");
    5a2f:	48 b8 6c 86 00 00 00 	movabs $0x866c,%rax
    5a36:	00 00 00 
    5a39:	48 89 c6             	mov    %rax,%rsi
    5a3c:	bf 01 00 00 00       	mov    $0x1,%edi
    5a41:	b8 00 00 00 00       	mov    $0x0,%eax
    5a46:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    5a4d:	00 00 00 
    5a50:	ff d2                	call   *%rdx
}
    5a52:	90                   	nop
    5a53:	c9                   	leave
    5a54:	c3                   	ret

0000000000005a55 <validatetest>:

void
validatetest(void)
{
    5a55:	f3 0f 1e fa          	endbr64
    5a59:	55                   	push   %rbp
    5a5a:	48 89 e5             	mov    %rsp,%rbp
    5a5d:	48 83 ec 10          	sub    $0x10,%rsp
  int hi;
  addr_t p;

  printf(1, "validate test\n");
    5a61:	48 b8 7a 86 00 00 00 	movabs $0x867a,%rax
    5a68:	00 00 00 
    5a6b:	48 89 c6             	mov    %rax,%rsi
    5a6e:	bf 01 00 00 00       	mov    $0x1,%edi
    5a73:	b8 00 00 00 00       	mov    $0x0,%eax
    5a78:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    5a7f:	00 00 00 
    5a82:	ff d2                	call   *%rdx
  hi = 1100*1024;
    5a84:	c7 45 f4 00 30 11 00 	movl   $0x113000,-0xc(%rbp)

  // first page not mapped
  for(p = 4096; p <= (uint)hi; p += 4096){
    5a8b:	48 c7 45 f8 00 10 00 	movq   $0x1000,-0x8(%rbp)
    5a92:	00 
    5a93:	eb 46                	jmp    5adb <validatetest+0x86>
    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    5a95:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    5a99:	48 89 c6             	mov    %rax,%rsi
    5a9c:	48 b8 89 86 00 00 00 	movabs $0x8689,%rax
    5aa3:	00 00 00 
    5aa6:	48 89 c7             	mov    %rax,%rdi
    5aa9:	48 b8 e0 68 00 00 00 	movabs $0x68e0,%rax
    5ab0:	00 00 00 
    5ab3:	ff d0                	call   *%rax
    5ab5:	83 f8 ff             	cmp    $0xffffffff,%eax
    5ab8:	74 19                	je     5ad3 <validatetest+0x7e>
      failexit("link should not succeed.");
    5aba:	48 b8 94 86 00 00 00 	movabs $0x8694,%rax
    5ac1:	00 00 00 
    5ac4:	48 89 c7             	mov    %rax,%rdi
    5ac7:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    5ace:	00 00 00 
    5ad1:	ff d0                	call   *%rax
  for(p = 4096; p <= (uint)hi; p += 4096){
    5ad3:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
    5ada:	00 
    5adb:	8b 45 f4             	mov    -0xc(%rbp),%eax
    5ade:	89 c0                	mov    %eax,%eax
    5ae0:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
    5ae4:	73 af                	jae    5a95 <validatetest+0x40>
    }
  }

  printf(1, "validate ok\n");
    5ae6:	48 b8 ad 86 00 00 00 	movabs $0x86ad,%rax
    5aed:	00 00 00 
    5af0:	48 89 c6             	mov    %rax,%rsi
    5af3:	bf 01 00 00 00       	mov    $0x1,%edi
    5af8:	b8 00 00 00 00       	mov    $0x0,%eax
    5afd:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    5b04:	00 00 00 
    5b07:	ff d2                	call   *%rdx
}
    5b09:	90                   	nop
    5b0a:	c9                   	leave
    5b0b:	c3                   	ret

0000000000005b0c <bsstest>:

// does unintialized data start out zero?
char uninit[10000];
void
bsstest(void)
{
    5b0c:	f3 0f 1e fa          	endbr64
    5b10:	55                   	push   %rbp
    5b11:	48 89 e5             	mov    %rsp,%rbp
    5b14:	48 83 ec 10          	sub    $0x10,%rsp
  int i;

  printf(1, "bss test\n");
    5b18:	48 b8 ba 86 00 00 00 	movabs $0x86ba,%rax
    5b1f:	00 00 00 
    5b22:	48 89 c6             	mov    %rax,%rsi
    5b25:	bf 01 00 00 00       	mov    $0x1,%edi
    5b2a:	b8 00 00 00 00       	mov    $0x0,%eax
    5b2f:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    5b36:	00 00 00 
    5b39:	ff d2                	call   *%rdx
  for(i = 0; i < sizeof(uninit); i++){
    5b3b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    5b42:	eb 34                	jmp    5b78 <bsstest+0x6c>
    if(uninit[i] != '\0'){
    5b44:	48 ba 20 aa 00 00 00 	movabs $0xaa20,%rdx
    5b4b:	00 00 00 
    5b4e:	8b 45 fc             	mov    -0x4(%rbp),%eax
    5b51:	48 98                	cltq
    5b53:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    5b57:	84 c0                	test   %al,%al
    5b59:	74 19                	je     5b74 <bsstest+0x68>
      failexit("bss test");
    5b5b:	48 b8 c4 86 00 00 00 	movabs $0x86c4,%rax
    5b62:	00 00 00 
    5b65:	48 89 c7             	mov    %rax,%rdi
    5b68:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    5b6f:	00 00 00 
    5b72:	ff d0                	call   *%rax
  for(i = 0; i < sizeof(uninit); i++){
    5b74:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    5b78:	8b 45 fc             	mov    -0x4(%rbp),%eax
    5b7b:	3d 0f 27 00 00       	cmp    $0x270f,%eax
    5b80:	76 c2                	jbe    5b44 <bsstest+0x38>
    }
  }
  printf(1, "bss test ok\n");
    5b82:	48 b8 cd 86 00 00 00 	movabs $0x86cd,%rax
    5b89:	00 00 00 
    5b8c:	48 89 c6             	mov    %rax,%rsi
    5b8f:	bf 01 00 00 00       	mov    $0x1,%edi
    5b94:	b8 00 00 00 00       	mov    $0x0,%eax
    5b99:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    5ba0:	00 00 00 
    5ba3:	ff d2                	call   *%rdx
}
    5ba5:	90                   	nop
    5ba6:	c9                   	leave
    5ba7:	c3                   	ret

0000000000005ba8 <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(void)
{
    5ba8:	f3 0f 1e fa          	endbr64
    5bac:	55                   	push   %rbp
    5bad:	48 89 e5             	mov    %rsp,%rbp
    5bb0:	48 83 ec 10          	sub    $0x10,%rsp
  int pid, fd;

  unlink("bigarg-ok");
    5bb4:	48 b8 da 86 00 00 00 	movabs $0x86da,%rax
    5bbb:	00 00 00 
    5bbe:	48 89 c7             	mov    %rax,%rdi
    5bc1:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    5bc8:	00 00 00 
    5bcb:	ff d0                	call   *%rax
  pid = fork();
    5bcd:	48 b8 37 68 00 00 00 	movabs $0x6837,%rax
    5bd4:	00 00 00 
    5bd7:	ff d0                	call   *%rax
    5bd9:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(pid == 0){
    5bdc:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    5be0:	0f 85 ef 00 00 00    	jne    5cd5 <bigargtest+0x12d>
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    5be6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    5bed:	eb 21                	jmp    5c10 <bigargtest+0x68>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    5bef:	48 ba 40 d1 00 00 00 	movabs $0xd140,%rdx
    5bf6:	00 00 00 
    5bf9:	8b 45 fc             	mov    -0x4(%rbp),%eax
    5bfc:	48 98                	cltq
    5bfe:	48 b9 e8 86 00 00 00 	movabs $0x86e8,%rcx
    5c05:	00 00 00 
    5c08:	48 89 0c c2          	mov    %rcx,(%rdx,%rax,8)
    for(i = 0; i < MAXARG-1; i++)
    5c0c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    5c10:	83 7d fc 1e          	cmpl   $0x1e,-0x4(%rbp)
    5c14:	7e d9                	jle    5bef <bigargtest+0x47>
    args[MAXARG-1] = 0;
    5c16:	48 b8 40 d1 00 00 00 	movabs $0xd140,%rax
    5c1d:	00 00 00 
    5c20:	48 c7 80 f8 00 00 00 	movq   $0x0,0xf8(%rax)
    5c27:	00 00 00 00 
    printf(1, "bigarg test\n");
    5c2b:	48 b8 c5 87 00 00 00 	movabs $0x87c5,%rax
    5c32:	00 00 00 
    5c35:	48 89 c6             	mov    %rax,%rsi
    5c38:	bf 01 00 00 00       	mov    $0x1,%edi
    5c3d:	b8 00 00 00 00       	mov    $0x0,%eax
    5c42:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    5c49:	00 00 00 
    5c4c:	ff d2                	call   *%rdx
    exec("echo", args);
    5c4e:	48 b8 40 d1 00 00 00 	movabs $0xd140,%rax
    5c55:	00 00 00 
    5c58:	48 89 c6             	mov    %rax,%rsi
    5c5b:	48 b8 68 72 00 00 00 	movabs $0x7268,%rax
    5c62:	00 00 00 
    5c65:	48 89 c7             	mov    %rax,%rdi
    5c68:	48 b8 9f 68 00 00 00 	movabs $0x689f,%rax
    5c6f:	00 00 00 
    5c72:	ff d0                	call   *%rax
    printf(1, "bigarg test ok\n");
    5c74:	48 b8 d2 87 00 00 00 	movabs $0x87d2,%rax
    5c7b:	00 00 00 
    5c7e:	48 89 c6             	mov    %rax,%rsi
    5c81:	bf 01 00 00 00       	mov    $0x1,%edi
    5c86:	b8 00 00 00 00       	mov    $0x0,%eax
    5c8b:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    5c92:	00 00 00 
    5c95:	ff d2                	call   *%rdx
    fd = open("bigarg-ok", O_CREATE);
    5c97:	be 00 02 00 00       	mov    $0x200,%esi
    5c9c:	48 b8 da 86 00 00 00 	movabs $0x86da,%rax
    5ca3:	00 00 00 
    5ca6:	48 89 c7             	mov    %rax,%rdi
    5ca9:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    5cb0:	00 00 00 
    5cb3:	ff d0                	call   *%rax
    5cb5:	89 45 f4             	mov    %eax,-0xc(%rbp)
    close(fd);
    5cb8:	8b 45 f4             	mov    -0xc(%rbp),%eax
    5cbb:	89 c7                	mov    %eax,%edi
    5cbd:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    5cc4:	00 00 00 
    5cc7:	ff d0                	call   *%rax
    exit();
    5cc9:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    5cd0:	00 00 00 
    5cd3:	ff d0                	call   *%rax
  } else if(pid < 0){
    5cd5:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    5cd9:	79 19                	jns    5cf4 <bigargtest+0x14c>
    failexit("bigargtest: fork");
    5cdb:	48 b8 e2 87 00 00 00 	movabs $0x87e2,%rax
    5ce2:	00 00 00 
    5ce5:	48 89 c7             	mov    %rax,%rdi
    5ce8:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    5cef:	00 00 00 
    5cf2:	ff d0                	call   *%rax
  }
  wait();
    5cf4:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    5cfb:	00 00 00 
    5cfe:	ff d0                	call   *%rax
  fd = open("bigarg-ok", 0);
    5d00:	be 00 00 00 00       	mov    $0x0,%esi
    5d05:	48 b8 da 86 00 00 00 	movabs $0x86da,%rax
    5d0c:	00 00 00 
    5d0f:	48 89 c7             	mov    %rax,%rdi
    5d12:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    5d19:	00 00 00 
    5d1c:	ff d0                	call   *%rax
    5d1e:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(fd < 0){
    5d21:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    5d25:	79 19                	jns    5d40 <bigargtest+0x198>
    failexit("bigarg test");
    5d27:	48 b8 f3 87 00 00 00 	movabs $0x87f3,%rax
    5d2e:	00 00 00 
    5d31:	48 89 c7             	mov    %rax,%rdi
    5d34:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    5d3b:	00 00 00 
    5d3e:	ff d0                	call   *%rax
  }
  close(fd);
    5d40:	8b 45 f4             	mov    -0xc(%rbp),%eax
    5d43:	89 c7                	mov    %eax,%edi
    5d45:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    5d4c:	00 00 00 
    5d4f:	ff d0                	call   *%rax
  unlink("bigarg-ok");
    5d51:	48 b8 da 86 00 00 00 	movabs $0x86da,%rax
    5d58:	00 00 00 
    5d5b:	48 89 c7             	mov    %rax,%rdi
    5d5e:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    5d65:	00 00 00 
    5d68:	ff d0                	call   *%rax
}
    5d6a:	90                   	nop
    5d6b:	c9                   	leave
    5d6c:	c3                   	ret

0000000000005d6d <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    5d6d:	f3 0f 1e fa          	endbr64
    5d71:	55                   	push   %rbp
    5d72:	48 89 e5             	mov    %rsp,%rbp
    5d75:	48 83 ec 60          	sub    $0x60,%rsp
  int nfiles;
  int fsblocks = 0;
    5d79:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)

  printf(1, "fsfull test\n");
    5d80:	48 b8 ff 87 00 00 00 	movabs $0x87ff,%rax
    5d87:	00 00 00 
    5d8a:	48 89 c6             	mov    %rax,%rsi
    5d8d:	bf 01 00 00 00       	mov    $0x1,%edi
    5d92:	b8 00 00 00 00       	mov    $0x0,%eax
    5d97:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    5d9e:	00 00 00 
    5da1:	ff d2                	call   *%rdx

  for(nfiles = 0; ; nfiles++){
    5da3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    char name[64];
    name[0] = 'f';
    5daa:	c6 45 a0 66          	movb   $0x66,-0x60(%rbp)
    name[1] = '0' + nfiles / 1000;
    5dae:	8b 45 fc             	mov    -0x4(%rbp),%eax
    5db1:	48 63 d0             	movslq %eax,%rdx
    5db4:	48 69 d2 d3 4d 62 10 	imul   $0x10624dd3,%rdx,%rdx
    5dbb:	48 c1 ea 20          	shr    $0x20,%rdx
    5dbf:	c1 fa 06             	sar    $0x6,%edx
    5dc2:	c1 f8 1f             	sar    $0x1f,%eax
    5dc5:	29 c2                	sub    %eax,%edx
    5dc7:	89 d0                	mov    %edx,%eax
    5dc9:	83 c0 30             	add    $0x30,%eax
    5dcc:	88 45 a1             	mov    %al,-0x5f(%rbp)
    name[2] = '0' + (nfiles % 1000) / 100;
    5dcf:	8b 55 fc             	mov    -0x4(%rbp),%edx
    5dd2:	48 63 c2             	movslq %edx,%rax
    5dd5:	48 69 c0 d3 4d 62 10 	imul   $0x10624dd3,%rax,%rax
    5ddc:	48 c1 e8 20          	shr    $0x20,%rax
    5de0:	c1 f8 06             	sar    $0x6,%eax
    5de3:	89 d1                	mov    %edx,%ecx
    5de5:	c1 f9 1f             	sar    $0x1f,%ecx
    5de8:	29 c8                	sub    %ecx,%eax
    5dea:	69 c8 e8 03 00 00    	imul   $0x3e8,%eax,%ecx
    5df0:	89 d0                	mov    %edx,%eax
    5df2:	29 c8                	sub    %ecx,%eax
    5df4:	48 63 d0             	movslq %eax,%rdx
    5df7:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
    5dfe:	48 c1 ea 20          	shr    $0x20,%rdx
    5e02:	c1 fa 05             	sar    $0x5,%edx
    5e05:	c1 f8 1f             	sar    $0x1f,%eax
    5e08:	29 c2                	sub    %eax,%edx
    5e0a:	89 d0                	mov    %edx,%eax
    5e0c:	83 c0 30             	add    $0x30,%eax
    5e0f:	88 45 a2             	mov    %al,-0x5e(%rbp)
    name[3] = '0' + (nfiles % 100) / 10;
    5e12:	8b 55 fc             	mov    -0x4(%rbp),%edx
    5e15:	48 63 c2             	movslq %edx,%rax
    5e18:	48 69 c0 1f 85 eb 51 	imul   $0x51eb851f,%rax,%rax
    5e1f:	48 c1 e8 20          	shr    $0x20,%rax
    5e23:	c1 f8 05             	sar    $0x5,%eax
    5e26:	89 d1                	mov    %edx,%ecx
    5e28:	c1 f9 1f             	sar    $0x1f,%ecx
    5e2b:	29 c8                	sub    %ecx,%eax
    5e2d:	6b c8 64             	imul   $0x64,%eax,%ecx
    5e30:	89 d0                	mov    %edx,%eax
    5e32:	29 c8                	sub    %ecx,%eax
    5e34:	48 63 d0             	movslq %eax,%rdx
    5e37:	48 69 d2 67 66 66 66 	imul   $0x66666667,%rdx,%rdx
    5e3e:	48 c1 ea 20          	shr    $0x20,%rdx
    5e42:	c1 fa 02             	sar    $0x2,%edx
    5e45:	c1 f8 1f             	sar    $0x1f,%eax
    5e48:	29 c2                	sub    %eax,%edx
    5e4a:	89 d0                	mov    %edx,%eax
    5e4c:	83 c0 30             	add    $0x30,%eax
    5e4f:	88 45 a3             	mov    %al,-0x5d(%rbp)
    name[4] = '0' + (nfiles % 10);
    5e52:	8b 55 fc             	mov    -0x4(%rbp),%edx
    5e55:	48 63 c2             	movslq %edx,%rax
    5e58:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
    5e5f:	48 c1 e8 20          	shr    $0x20,%rax
    5e63:	89 c1                	mov    %eax,%ecx
    5e65:	c1 f9 02             	sar    $0x2,%ecx
    5e68:	89 d0                	mov    %edx,%eax
    5e6a:	c1 f8 1f             	sar    $0x1f,%eax
    5e6d:	29 c1                	sub    %eax,%ecx
    5e6f:	89 c8                	mov    %ecx,%eax
    5e71:	c1 e0 02             	shl    $0x2,%eax
    5e74:	01 c8                	add    %ecx,%eax
    5e76:	01 c0                	add    %eax,%eax
    5e78:	89 d1                	mov    %edx,%ecx
    5e7a:	29 c1                	sub    %eax,%ecx
    5e7c:	89 c8                	mov    %ecx,%eax
    5e7e:	83 c0 30             	add    $0x30,%eax
    5e81:	88 45 a4             	mov    %al,-0x5c(%rbp)
    name[5] = '\0';
    5e84:	c6 45 a5 00          	movb   $0x0,-0x5b(%rbp)
    printf(1, "writing %s\n", name);
    5e88:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
    5e8c:	48 89 c2             	mov    %rax,%rdx
    5e8f:	48 b8 0c 88 00 00 00 	movabs $0x880c,%rax
    5e96:	00 00 00 
    5e99:	48 89 c6             	mov    %rax,%rsi
    5e9c:	bf 01 00 00 00       	mov    $0x1,%edi
    5ea1:	b8 00 00 00 00       	mov    $0x0,%eax
    5ea6:	48 b9 55 6b 00 00 00 	movabs $0x6b55,%rcx
    5ead:	00 00 00 
    5eb0:	ff d1                	call   *%rcx
    int fd = open(name, O_CREATE|O_RDWR);
    5eb2:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
    5eb6:	be 02 02 00 00       	mov    $0x202,%esi
    5ebb:	48 89 c7             	mov    %rax,%rdi
    5ebe:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    5ec5:	00 00 00 
    5ec8:	ff d0                	call   *%rax
    5eca:	89 45 f0             	mov    %eax,-0x10(%rbp)
    if(fd < 0){
    5ecd:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    5ed1:	79 2f                	jns    5f02 <fsfull+0x195>
      printf(1, "open %s failed\n", name);
    5ed3:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
    5ed7:	48 89 c2             	mov    %rax,%rdx
    5eda:	48 b8 18 88 00 00 00 	movabs $0x8818,%rax
    5ee1:	00 00 00 
    5ee4:	48 89 c6             	mov    %rax,%rsi
    5ee7:	bf 01 00 00 00       	mov    $0x1,%edi
    5eec:	b8 00 00 00 00       	mov    $0x0,%eax
    5ef1:	48 b9 55 6b 00 00 00 	movabs $0x6b55,%rcx
    5ef8:	00 00 00 
    5efb:	ff d1                	call   *%rcx
      break;
    5efd:	e9 8c 00 00 00       	jmp    5f8e <fsfull+0x221>
    }
    int total = 0;
    5f02:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    while(1){
      int cc = write(fd, buf, 512);
    5f09:	8b 45 f0             	mov    -0x10(%rbp),%eax
    5f0c:	ba 00 02 00 00       	mov    $0x200,%edx
    5f11:	48 b9 00 8a 00 00 00 	movabs $0x8a00,%rcx
    5f18:	00 00 00 
    5f1b:	48 89 ce             	mov    %rcx,%rsi
    5f1e:	89 c7                	mov    %eax,%edi
    5f20:	48 b8 78 68 00 00 00 	movabs $0x6878,%rax
    5f27:	00 00 00 
    5f2a:	ff d0                	call   *%rax
    5f2c:	89 45 ec             	mov    %eax,-0x14(%rbp)
      if(cc < 512)
    5f2f:	81 7d ec ff 01 00 00 	cmpl   $0x1ff,-0x14(%rbp)
    5f36:	7e 0c                	jle    5f44 <fsfull+0x1d7>
        break;
      total += cc;
    5f38:	8b 45 ec             	mov    -0x14(%rbp),%eax
    5f3b:	01 45 f4             	add    %eax,-0xc(%rbp)
      fsblocks++;
    5f3e:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    while(1){
    5f42:	eb c5                	jmp    5f09 <fsfull+0x19c>
        break;
    5f44:	90                   	nop
    }
    printf(1, "wrote %d bytes\n", total);
    5f45:	8b 45 f4             	mov    -0xc(%rbp),%eax
    5f48:	89 c2                	mov    %eax,%edx
    5f4a:	48 b8 28 88 00 00 00 	movabs $0x8828,%rax
    5f51:	00 00 00 
    5f54:	48 89 c6             	mov    %rax,%rsi
    5f57:	bf 01 00 00 00       	mov    $0x1,%edi
    5f5c:	b8 00 00 00 00       	mov    $0x0,%eax
    5f61:	48 b9 55 6b 00 00 00 	movabs $0x6b55,%rcx
    5f68:	00 00 00 
    5f6b:	ff d1                	call   *%rcx
    close(fd);
    5f6d:	8b 45 f0             	mov    -0x10(%rbp),%eax
    5f70:	89 c7                	mov    %eax,%edi
    5f72:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    5f79:	00 00 00 
    5f7c:	ff d0                	call   *%rax
    if(total == 0)
    5f7e:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    5f82:	74 09                	je     5f8d <fsfull+0x220>
  for(nfiles = 0; ; nfiles++){
    5f84:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    5f88:	e9 1d fe ff ff       	jmp    5daa <fsfull+0x3d>
      break;
    5f8d:	90                   	nop
  }

  while(nfiles >= 0){
    5f8e:	e9 f5 00 00 00       	jmp    6088 <fsfull+0x31b>
    char name[64];
    name[0] = 'f';
    5f93:	c6 45 a0 66          	movb   $0x66,-0x60(%rbp)
    name[1] = '0' + nfiles / 1000;
    5f97:	8b 45 fc             	mov    -0x4(%rbp),%eax
    5f9a:	48 63 d0             	movslq %eax,%rdx
    5f9d:	48 69 d2 d3 4d 62 10 	imul   $0x10624dd3,%rdx,%rdx
    5fa4:	48 c1 ea 20          	shr    $0x20,%rdx
    5fa8:	c1 fa 06             	sar    $0x6,%edx
    5fab:	c1 f8 1f             	sar    $0x1f,%eax
    5fae:	29 c2                	sub    %eax,%edx
    5fb0:	89 d0                	mov    %edx,%eax
    5fb2:	83 c0 30             	add    $0x30,%eax
    5fb5:	88 45 a1             	mov    %al,-0x5f(%rbp)
    name[2] = '0' + (nfiles % 1000) / 100;
    5fb8:	8b 55 fc             	mov    -0x4(%rbp),%edx
    5fbb:	48 63 c2             	movslq %edx,%rax
    5fbe:	48 69 c0 d3 4d 62 10 	imul   $0x10624dd3,%rax,%rax
    5fc5:	48 c1 e8 20          	shr    $0x20,%rax
    5fc9:	c1 f8 06             	sar    $0x6,%eax
    5fcc:	89 d1                	mov    %edx,%ecx
    5fce:	c1 f9 1f             	sar    $0x1f,%ecx
    5fd1:	29 c8                	sub    %ecx,%eax
    5fd3:	69 c8 e8 03 00 00    	imul   $0x3e8,%eax,%ecx
    5fd9:	89 d0                	mov    %edx,%eax
    5fdb:	29 c8                	sub    %ecx,%eax
    5fdd:	48 63 d0             	movslq %eax,%rdx
    5fe0:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
    5fe7:	48 c1 ea 20          	shr    $0x20,%rdx
    5feb:	c1 fa 05             	sar    $0x5,%edx
    5fee:	c1 f8 1f             	sar    $0x1f,%eax
    5ff1:	29 c2                	sub    %eax,%edx
    5ff3:	89 d0                	mov    %edx,%eax
    5ff5:	83 c0 30             	add    $0x30,%eax
    5ff8:	88 45 a2             	mov    %al,-0x5e(%rbp)
    name[3] = '0' + (nfiles % 100) / 10;
    5ffb:	8b 55 fc             	mov    -0x4(%rbp),%edx
    5ffe:	48 63 c2             	movslq %edx,%rax
    6001:	48 69 c0 1f 85 eb 51 	imul   $0x51eb851f,%rax,%rax
    6008:	48 c1 e8 20          	shr    $0x20,%rax
    600c:	c1 f8 05             	sar    $0x5,%eax
    600f:	89 d1                	mov    %edx,%ecx
    6011:	c1 f9 1f             	sar    $0x1f,%ecx
    6014:	29 c8                	sub    %ecx,%eax
    6016:	6b c8 64             	imul   $0x64,%eax,%ecx
    6019:	89 d0                	mov    %edx,%eax
    601b:	29 c8                	sub    %ecx,%eax
    601d:	48 63 d0             	movslq %eax,%rdx
    6020:	48 69 d2 67 66 66 66 	imul   $0x66666667,%rdx,%rdx
    6027:	48 c1 ea 20          	shr    $0x20,%rdx
    602b:	c1 fa 02             	sar    $0x2,%edx
    602e:	c1 f8 1f             	sar    $0x1f,%eax
    6031:	29 c2                	sub    %eax,%edx
    6033:	89 d0                	mov    %edx,%eax
    6035:	83 c0 30             	add    $0x30,%eax
    6038:	88 45 a3             	mov    %al,-0x5d(%rbp)
    name[4] = '0' + (nfiles % 10);
    603b:	8b 55 fc             	mov    -0x4(%rbp),%edx
    603e:	48 63 c2             	movslq %edx,%rax
    6041:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
    6048:	48 c1 e8 20          	shr    $0x20,%rax
    604c:	89 c1                	mov    %eax,%ecx
    604e:	c1 f9 02             	sar    $0x2,%ecx
    6051:	89 d0                	mov    %edx,%eax
    6053:	c1 f8 1f             	sar    $0x1f,%eax
    6056:	29 c1                	sub    %eax,%ecx
    6058:	89 c8                	mov    %ecx,%eax
    605a:	c1 e0 02             	shl    $0x2,%eax
    605d:	01 c8                	add    %ecx,%eax
    605f:	01 c0                	add    %eax,%eax
    6061:	89 d1                	mov    %edx,%ecx
    6063:	29 c1                	sub    %eax,%ecx
    6065:	89 c8                	mov    %ecx,%eax
    6067:	83 c0 30             	add    $0x30,%eax
    606a:	88 45 a4             	mov    %al,-0x5c(%rbp)
    name[5] = '\0';
    606d:	c6 45 a5 00          	movb   $0x0,-0x5b(%rbp)
    unlink(name);
    6071:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
    6075:	48 89 c7             	mov    %rax,%rdi
    6078:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    607f:	00 00 00 
    6082:	ff d0                	call   *%rax
    nfiles--;
    6084:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
  while(nfiles >= 0){
    6088:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    608c:	0f 89 01 ff ff ff    	jns    5f93 <fsfull+0x226>
  }

  printf(1, "fsfull test finished\n");
    6092:	48 b8 38 88 00 00 00 	movabs $0x8838,%rax
    6099:	00 00 00 
    609c:	48 89 c6             	mov    %rax,%rsi
    609f:	bf 01 00 00 00       	mov    $0x1,%edi
    60a4:	b8 00 00 00 00       	mov    $0x0,%eax
    60a9:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    60b0:	00 00 00 
    60b3:	ff d2                	call   *%rdx
}
    60b5:	90                   	nop
    60b6:	c9                   	leave
    60b7:	c3                   	ret

00000000000060b8 <uio>:

void
uio()
{
    60b8:	f3 0f 1e fa          	endbr64
    60bc:	55                   	push   %rbp
    60bd:	48 89 e5             	mov    %rsp,%rbp
    60c0:	48 83 ec 10          	sub    $0x10,%rsp
  #define RTC_ADDR 0x70
  #define RTC_DATA 0x71

  ushort port = 0;
    60c4:	66 c7 45 fe 00 00    	movw   $0x0,-0x2(%rbp)
  uchar val = 0;
    60ca:	c6 45 fd 00          	movb   $0x0,-0x3(%rbp)
  int pid;

  printf(1, "uio test\n");
    60ce:	48 b8 4e 88 00 00 00 	movabs $0x884e,%rax
    60d5:	00 00 00 
    60d8:	48 89 c6             	mov    %rax,%rsi
    60db:	bf 01 00 00 00       	mov    $0x1,%edi
    60e0:	b8 00 00 00 00       	mov    $0x0,%eax
    60e5:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    60ec:	00 00 00 
    60ef:	ff d2                	call   *%rdx
  pid = fork();
    60f1:	48 b8 37 68 00 00 00 	movabs $0x6837,%rax
    60f8:	00 00 00 
    60fb:	ff d0                	call   *%rax
    60fd:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(pid == 0){
    6100:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    6104:	75 52                	jne    6158 <uio+0xa0>
    port = RTC_ADDR;
    6106:	66 c7 45 fe 70 00    	movw   $0x70,-0x2(%rbp)
    val = 0x09;  /* year */
    610c:	c6 45 fd 09          	movb   $0x9,-0x3(%rbp)
    /* http://wiki.osdev.org/Inline_Assembly/Examples */
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    6110:	0f b6 45 fd          	movzbl -0x3(%rbp),%eax
    6114:	0f b7 55 fe          	movzwl -0x2(%rbp),%edx
    6118:	ee                   	out    %al,(%dx)
    port = RTC_DATA;
    6119:	66 c7 45 fe 71 00    	movw   $0x71,-0x2(%rbp)
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    611f:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
    6123:	89 c2                	mov    %eax,%edx
    6125:	ec                   	in     (%dx),%al
    6126:	88 45 fd             	mov    %al,-0x3(%rbp)
    printf(1, "uio test succeeded\n");
    6129:	48 b8 58 88 00 00 00 	movabs $0x8858,%rax
    6130:	00 00 00 
    6133:	48 89 c6             	mov    %rax,%rsi
    6136:	bf 01 00 00 00       	mov    $0x1,%edi
    613b:	b8 00 00 00 00       	mov    $0x0,%eax
    6140:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    6147:	00 00 00 
    614a:	ff d2                	call   *%rdx
    exit();
    614c:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    6153:	00 00 00 
    6156:	ff d0                	call   *%rax
  } else if(pid < 0){
    6158:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    615c:	79 19                	jns    6177 <uio+0xbf>
    failexit("fork");
    615e:	48 b8 f7 72 00 00 00 	movabs $0x72f7,%rax
    6165:	00 00 00 
    6168:	48 89 c7             	mov    %rax,%rdi
    616b:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    6172:	00 00 00 
    6175:	ff d0                	call   *%rax
  }
  wait();
    6177:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    617e:	00 00 00 
    6181:	ff d0                	call   *%rax
  printf(1, "uio test done\n");
    6183:	48 b8 6c 88 00 00 00 	movabs $0x886c,%rax
    618a:	00 00 00 
    618d:	48 89 c6             	mov    %rax,%rsi
    6190:	bf 01 00 00 00       	mov    $0x1,%edi
    6195:	b8 00 00 00 00       	mov    $0x0,%eax
    619a:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    61a1:	00 00 00 
    61a4:	ff d2                	call   *%rdx
}
    61a6:	90                   	nop
    61a7:	c9                   	leave
    61a8:	c3                   	ret

00000000000061a9 <argptest>:

void argptest()
{
    61a9:	f3 0f 1e fa          	endbr64
    61ad:	55                   	push   %rbp
    61ae:	48 89 e5             	mov    %rsp,%rbp
    61b1:	48 83 ec 10          	sub    $0x10,%rsp
  int fd;
  fd = open("init", O_RDONLY);
    61b5:	be 00 00 00 00       	mov    $0x0,%esi
    61ba:	48 b8 7b 88 00 00 00 	movabs $0x887b,%rax
    61c1:	00 00 00 
    61c4:	48 89 c7             	mov    %rax,%rdi
    61c7:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    61ce:	00 00 00 
    61d1:	ff d0                	call   *%rax
    61d3:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if (fd < 0) {
    61d6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    61da:	79 19                	jns    61f5 <argptest+0x4c>
    failexit("open");
    61dc:	48 b8 80 88 00 00 00 	movabs $0x8880,%rax
    61e3:	00 00 00 
    61e6:	48 89 c7             	mov    %rax,%rdi
    61e9:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    61f0:	00 00 00 
    61f3:	ff d0                	call   *%rax
  }
  read(fd, sbrk(0) - 1, -1);
    61f5:	bf 00 00 00 00       	mov    $0x0,%edi
    61fa:	48 b8 21 69 00 00 00 	movabs $0x6921,%rax
    6201:	00 00 00 
    6204:	ff d0                	call   *%rax
    6206:	48 8d 48 ff          	lea    -0x1(%rax),%rcx
    620a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    620d:	ba ff ff ff ff       	mov    $0xffffffff,%edx
    6212:	48 89 ce             	mov    %rcx,%rsi
    6215:	89 c7                	mov    %eax,%edi
    6217:	48 b8 6b 68 00 00 00 	movabs $0x686b,%rax
    621e:	00 00 00 
    6221:	ff d0                	call   *%rax
  close(fd);
    6223:	8b 45 fc             	mov    -0x4(%rbp),%eax
    6226:	89 c7                	mov    %eax,%edi
    6228:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    622f:	00 00 00 
    6232:	ff d0                	call   *%rax
  printf(1, "arg test passed\n");
    6234:	48 b8 85 88 00 00 00 	movabs $0x8885,%rax
    623b:	00 00 00 
    623e:	48 89 c6             	mov    %rax,%rsi
    6241:	bf 01 00 00 00       	mov    $0x1,%edi
    6246:	b8 00 00 00 00       	mov    $0x0,%eax
    624b:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    6252:	00 00 00 
    6255:	ff d2                	call   *%rdx
}
    6257:	90                   	nop
    6258:	c9                   	leave
    6259:	c3                   	ret

000000000000625a <rand>:

unsigned long randstate = 1;
unsigned int
rand()
{
    625a:	f3 0f 1e fa          	endbr64
    625e:	55                   	push   %rbp
    625f:	48 89 e5             	mov    %rsp,%rbp
  randstate = randstate * 1664525 + 1013904223;
    6262:	48 b8 c8 89 00 00 00 	movabs $0x89c8,%rax
    6269:	00 00 00 
    626c:	48 8b 00             	mov    (%rax),%rax
    626f:	48 69 c0 0d 66 19 00 	imul   $0x19660d,%rax,%rax
    6276:	48 8d 90 5f f3 6e 3c 	lea    0x3c6ef35f(%rax),%rdx
    627d:	48 b8 c8 89 00 00 00 	movabs $0x89c8,%rax
    6284:	00 00 00 
    6287:	48 89 10             	mov    %rdx,(%rax)
  return randstate;
    628a:	48 b8 c8 89 00 00 00 	movabs $0x89c8,%rax
    6291:	00 00 00 
    6294:	48 8b 00             	mov    (%rax),%rax
}
    6297:	5d                   	pop    %rbp
    6298:	c3                   	ret

0000000000006299 <main>:

int
main(int argc, char *argv[])
{
    6299:	f3 0f 1e fa          	endbr64
    629d:	55                   	push   %rbp
    629e:	48 89 e5             	mov    %rsp,%rbp
    62a1:	48 83 ec 10          	sub    $0x10,%rsp
    62a5:	89 7d fc             	mov    %edi,-0x4(%rbp)
    62a8:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  printf(1, "usertests starting\n");
    62ac:	48 b8 96 88 00 00 00 	movabs $0x8896,%rax
    62b3:	00 00 00 
    62b6:	48 89 c6             	mov    %rax,%rsi
    62b9:	bf 01 00 00 00       	mov    $0x1,%edi
    62be:	b8 00 00 00 00       	mov    $0x0,%eax
    62c3:	48 ba 55 6b 00 00 00 	movabs $0x6b55,%rdx
    62ca:	00 00 00 
    62cd:	ff d2                	call   *%rdx

  if(open("usertests.ran", 0) >= 0){
    62cf:	be 00 00 00 00       	mov    $0x0,%esi
    62d4:	48 b8 aa 88 00 00 00 	movabs $0x88aa,%rax
    62db:	00 00 00 
    62de:	48 89 c7             	mov    %rax,%rdi
    62e1:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    62e8:	00 00 00 
    62eb:	ff d0                	call   *%rax
    62ed:	85 c0                	test   %eax,%eax
    62ef:	78 19                	js     630a <main+0x71>
    failexit("already ran user tests -- rebuild fs.img");
    62f1:	48 b8 b8 88 00 00 00 	movabs $0x88b8,%rax
    62f8:	00 00 00 
    62fb:	48 89 c7             	mov    %rax,%rdi
    62fe:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    6305:	00 00 00 
    6308:	ff d0                	call   *%rax
  }
  close(open("usertests.ran", O_CREATE));
    630a:	be 00 02 00 00       	mov    $0x200,%esi
    630f:	48 b8 aa 88 00 00 00 	movabs $0x88aa,%rax
    6316:	00 00 00 
    6319:	48 89 c7             	mov    %rax,%rdi
    631c:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    6323:	00 00 00 
    6326:	ff d0                	call   *%rax
    6328:	89 c7                	mov    %eax,%edi
    632a:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    6331:	00 00 00 
    6334:	ff d0                	call   *%rax

  argptest();
    6336:	b8 00 00 00 00       	mov    $0x0,%eax
    633b:	48 ba a9 61 00 00 00 	movabs $0x61a9,%rdx
    6342:	00 00 00 
    6345:	ff d2                	call   *%rdx
  createdelete();
    6347:	48 b8 f4 2a 00 00 00 	movabs $0x2af4,%rax
    634e:	00 00 00 
    6351:	ff d0                	call   *%rax
  linkunlink();
    6353:	b8 00 00 00 00       	mov    $0x0,%eax
    6358:	48 ba 85 38 00 00 00 	movabs $0x3885,%rdx
    635f:	00 00 00 
    6362:	ff d2                	call   *%rdx
  concreate();
    6364:	48 b8 86 33 00 00 00 	movabs $0x3386,%rax
    636b:	00 00 00 
    636e:	ff d0                	call   *%rax
  fourfiles();
    6370:	48 b8 c6 27 00 00 00 	movabs $0x27c6,%rax
    6377:	00 00 00 
    637a:	ff d0                	call   *%rax
  sharedfd();
    637c:	48 b8 0e 25 00 00 00 	movabs $0x250e,%rax
    6383:	00 00 00 
    6386:	ff d0                	call   *%rax

  bigargtest();
    6388:	48 b8 a8 5b 00 00 00 	movabs $0x5ba8,%rax
    638f:	00 00 00 
    6392:	ff d0                	call   *%rax
  bigwrite();
    6394:	48 b8 86 45 00 00 00 	movabs $0x4586,%rax
    639b:	00 00 00 
    639e:	ff d0                	call   *%rax
  bigargtest();
    63a0:	48 b8 a8 5b 00 00 00 	movabs $0x5ba8,%rax
    63a7:	00 00 00 
    63aa:	ff d0                	call   *%rax
  bsstest();
    63ac:	48 b8 0c 5b 00 00 00 	movabs $0x5b0c,%rax
    63b3:	00 00 00 
    63b6:	ff d0                	call   *%rax
  sbrktest();
    63b8:	48 b8 3c 53 00 00 00 	movabs $0x533c,%rax
    63bf:	00 00 00 
    63c2:	ff d0                	call   *%rax
  validatetest();
    63c4:	48 b8 55 5a 00 00 00 	movabs $0x5a55,%rax
    63cb:	00 00 00 
    63ce:	ff d0                	call   *%rax

  opentest();
    63d0:	48 b8 14 14 00 00 00 	movabs $0x1414,%rax
    63d7:	00 00 00 
    63da:	ff d0                	call   *%rax
  writetest();
    63dc:	48 b8 fa 14 00 00 00 	movabs $0x14fa,%rax
    63e3:	00 00 00 
    63e6:	ff d0                	call   *%rax
  writetest1();
    63e8:	48 b8 4d 17 00 00 00 	movabs $0x174d,%rax
    63ef:	00 00 00 
    63f2:	ff d0                	call   *%rax
  createtest();
    63f4:	48 b8 fe 19 00 00 00 	movabs $0x19fe,%rax
    63fb:	00 00 00 
    63fe:	ff d0                	call   *%rax

  openiputtest();
    6400:	48 b8 b6 12 00 00 00 	movabs $0x12b6,%rax
    6407:	00 00 00 
    640a:	ff d0                	call   *%rax
  exitiputtest();
    640c:	48 b8 6f 11 00 00 00 	movabs $0x116f,%rax
    6413:	00 00 00 
    6416:	ff d0                	call   *%rax
  iputtest();
    6418:	48 b8 46 10 00 00 00 	movabs $0x1046,%rax
    641f:	00 00 00 
    6422:	ff d0                	call   *%rax

  mem();
    6424:	48 b8 7f 23 00 00 00 	movabs $0x237f,%rax
    642b:	00 00 00 
    642e:	ff d0                	call   *%rax
  pipe1();
    6430:	48 b8 1d 1e 00 00 00 	movabs $0x1e1d,%rax
    6437:	00 00 00 
    643a:	ff d0                	call   *%rax
  preempt();
    643c:	48 b8 87 20 00 00 00 	movabs $0x2087,%rax
    6443:	00 00 00 
    6446:	ff d0                	call   *%rax
  exitwait();
    6448:	48 b8 b2 22 00 00 00 	movabs $0x22b2,%rax
    644f:	00 00 00 
    6452:	ff d0                	call   *%rax
  nullptrtest();
    6454:	48 b8 2e 1d 00 00 00 	movabs $0x1d2e,%rax
    645b:	00 00 00 
    645e:	ff d0                	call   *%rax

  rmdot();
    6460:	48 b8 76 4b 00 00 00 	movabs $0x4b76,%rax
    6467:	00 00 00 
    646a:	ff d0                	call   *%rax
  fourteen();
    646c:	48 b8 a7 49 00 00 00 	movabs $0x49a7,%rax
    6473:	00 00 00 
    6476:	ff d0                	call   *%rax
  bigfile();
    6478:	48 b8 f7 46 00 00 00 	movabs $0x46f7,%rax
    647f:	00 00 00 
    6482:	ff d0                	call   *%rax
  subdir();
    6484:	48 b8 16 3c 00 00 00 	movabs $0x3c16,%rax
    648b:	00 00 00 
    648e:	ff d0                	call   *%rax
  linktest();
    6490:	48 b8 62 30 00 00 00 	movabs $0x3062,%rax
    6497:	00 00 00 
    649a:	ff d0                	call   *%rax
  unlinkread();
    649c:	48 b8 f8 2d 00 00 00 	movabs $0x2df8,%rax
    64a3:	00 00 00 
    64a6:	ff d0                	call   *%rax
  dirfile();
    64a8:	48 b8 77 4d 00 00 00 	movabs $0x4d77,%rax
    64af:	00 00 00 
    64b2:	ff d0                	call   *%rax
  iref();
    64b4:	48 b8 6a 50 00 00 00 	movabs $0x506a,%rax
    64bb:	00 00 00 
    64be:	ff d0                	call   *%rax
  forktest();
    64c0:	48 b8 26 52 00 00 00 	movabs $0x5226,%rax
    64c7:	00 00 00 
    64ca:	ff d0                	call   *%rax
  bigdir(); // slow
    64cc:	48 b8 39 3a 00 00 00 	movabs $0x3a39,%rax
    64d3:	00 00 00 
    64d6:	ff d0                	call   *%rax
  uio();
    64d8:	b8 00 00 00 00       	mov    $0x0,%eax
    64dd:	48 ba b8 60 00 00 00 	movabs $0x60b8,%rdx
    64e4:	00 00 00 
    64e7:	ff d2                	call   *%rdx

  exectest(); // will exit
    64e9:	48 b8 9a 1c 00 00 00 	movabs $0x1c9a,%rax
    64f0:	00 00 00 
    64f3:	ff d0                	call   *%rax

  exit();
    64f5:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    64fc:	00 00 00 
    64ff:	ff d0                	call   *%rax

0000000000006501 <stosb>:
  stosb(dst, c, n);
  return dst;
}

char*
strchr(const char *s, char c)
    6501:	f3 0f 1e fa          	endbr64
    6505:	55                   	push   %rbp
    6506:	48 89 e5             	mov    %rsp,%rbp
    6509:	48 83 ec 10          	sub    $0x10,%rsp
    650d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    6511:	89 75 f4             	mov    %esi,-0xc(%rbp)
    6514:	89 55 f0             	mov    %edx,-0x10(%rbp)
{
    6517:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    651b:	8b 55 f0             	mov    -0x10(%rbp),%edx
    651e:	8b 45 f4             	mov    -0xc(%rbp),%eax
    6521:	48 89 ce             	mov    %rcx,%rsi
    6524:	48 89 f7             	mov    %rsi,%rdi
    6527:	89 d1                	mov    %edx,%ecx
    6529:	fc                   	cld
    652a:	f3 aa                	rep stos %al,%es:(%rdi)
    652c:	89 ca                	mov    %ecx,%edx
    652e:	48 89 fe             	mov    %rdi,%rsi
    6531:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    6535:	89 55 f0             	mov    %edx,-0x10(%rbp)
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
    6538:	90                   	nop
    6539:	c9                   	leave
    653a:	c3                   	ret

000000000000653b <strcpy>:
{
    653b:	f3 0f 1e fa          	endbr64
    653f:	55                   	push   %rbp
    6540:	48 89 e5             	mov    %rsp,%rbp
    6543:	48 83 ec 20          	sub    $0x20,%rsp
    6547:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    654b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  os = s;
    654f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    6553:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    6557:	90                   	nop
    6558:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    655c:	48 8d 42 01          	lea    0x1(%rdx),%rax
    6560:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    6564:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    6568:	48 8d 48 01          	lea    0x1(%rax),%rcx
    656c:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    6570:	0f b6 12             	movzbl (%rdx),%edx
    6573:	88 10                	mov    %dl,(%rax)
    6575:	0f b6 00             	movzbl (%rax),%eax
    6578:	84 c0                	test   %al,%al
    657a:	75 dc                	jne    6558 <strcpy+0x1d>
  return os;
    657c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    6580:	c9                   	leave
    6581:	c3                   	ret

0000000000006582 <strcmp>:
{
    6582:	f3 0f 1e fa          	endbr64
    6586:	55                   	push   %rbp
    6587:	48 89 e5             	mov    %rsp,%rbp
    658a:	48 83 ec 10          	sub    $0x10,%rsp
    658e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    6592:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    6596:	eb 0a                	jmp    65a2 <strcmp+0x20>
    p++, q++;
    6598:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    659d:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    65a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    65a6:	0f b6 00             	movzbl (%rax),%eax
    65a9:	84 c0                	test   %al,%al
    65ab:	74 12                	je     65bf <strcmp+0x3d>
    65ad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    65b1:	0f b6 10             	movzbl (%rax),%edx
    65b4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    65b8:	0f b6 00             	movzbl (%rax),%eax
    65bb:	38 c2                	cmp    %al,%dl
    65bd:	74 d9                	je     6598 <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
    65bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    65c3:	0f b6 00             	movzbl (%rax),%eax
    65c6:	0f b6 d0             	movzbl %al,%edx
    65c9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    65cd:	0f b6 00             	movzbl (%rax),%eax
    65d0:	0f b6 c0             	movzbl %al,%eax
    65d3:	29 c2                	sub    %eax,%edx
    65d5:	89 d0                	mov    %edx,%eax
}
    65d7:	c9                   	leave
    65d8:	c3                   	ret

00000000000065d9 <strlen>:
{
    65d9:	f3 0f 1e fa          	endbr64
    65dd:	55                   	push   %rbp
    65de:	48 89 e5             	mov    %rsp,%rbp
    65e1:	48 83 ec 18          	sub    $0x18,%rsp
    65e5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  for(n = 0; s[n]; n++)
    65e9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    65f0:	eb 04                	jmp    65f6 <strlen+0x1d>
    65f2:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    65f6:	8b 45 fc             	mov    -0x4(%rbp),%eax
    65f9:	48 63 d0             	movslq %eax,%rdx
    65fc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    6600:	48 01 d0             	add    %rdx,%rax
    6603:	0f b6 00             	movzbl (%rax),%eax
    6606:	84 c0                	test   %al,%al
    6608:	75 e8                	jne    65f2 <strlen+0x19>
  return n;
    660a:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    660d:	c9                   	leave
    660e:	c3                   	ret

000000000000660f <memset>:
{
    660f:	f3 0f 1e fa          	endbr64
    6613:	55                   	push   %rbp
    6614:	48 89 e5             	mov    %rsp,%rbp
    6617:	48 83 ec 10          	sub    $0x10,%rsp
    661b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    661f:	89 75 f4             	mov    %esi,-0xc(%rbp)
    6622:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    6625:	8b 55 f0             	mov    -0x10(%rbp),%edx
    6628:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    662b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    662f:	89 ce                	mov    %ecx,%esi
    6631:	48 89 c7             	mov    %rax,%rdi
    6634:	48 b8 01 65 00 00 00 	movabs $0x6501,%rax
    663b:	00 00 00 
    663e:	ff d0                	call   *%rax
  return dst;
    6640:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    6644:	c9                   	leave
    6645:	c3                   	ret

0000000000006646 <strchr>:
{
    6646:	f3 0f 1e fa          	endbr64
    664a:	55                   	push   %rbp
    664b:	48 89 e5             	mov    %rsp,%rbp
    664e:	48 83 ec 10          	sub    $0x10,%rsp
    6652:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    6656:	89 f0                	mov    %esi,%eax
    6658:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    665b:	eb 17                	jmp    6674 <strchr+0x2e>
    if(*s == c)
    665d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6661:	0f b6 00             	movzbl (%rax),%eax
    6664:	38 45 f4             	cmp    %al,-0xc(%rbp)
    6667:	75 06                	jne    666f <strchr+0x29>
      return (char*)s;
    6669:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    666d:	eb 15                	jmp    6684 <strchr+0x3e>
  for(; *s; s++)
    666f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    6674:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6678:	0f b6 00             	movzbl (%rax),%eax
    667b:	84 c0                	test   %al,%al
    667d:	75 de                	jne    665d <strchr+0x17>
  return 0;
    667f:	b8 00 00 00 00       	mov    $0x0,%eax
}
    6684:	c9                   	leave
    6685:	c3                   	ret

0000000000006686 <gets>:

char*
gets(char *buf, int max)
{
    6686:	f3 0f 1e fa          	endbr64
    668a:	55                   	push   %rbp
    668b:	48 89 e5             	mov    %rsp,%rbp
    668e:	48 83 ec 20          	sub    $0x20,%rsp
    6692:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    6696:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    6699:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    66a0:	eb 4f                	jmp    66f1 <gets+0x6b>
    cc = read(0, &c, 1);
    66a2:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    66a6:	ba 01 00 00 00       	mov    $0x1,%edx
    66ab:	48 89 c6             	mov    %rax,%rsi
    66ae:	bf 00 00 00 00       	mov    $0x0,%edi
    66b3:	48 b8 6b 68 00 00 00 	movabs $0x686b,%rax
    66ba:	00 00 00 
    66bd:	ff d0                	call   *%rax
    66bf:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    66c2:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    66c6:	7e 36                	jle    66fe <gets+0x78>
      break;
    buf[i++] = c;
    66c8:	8b 45 fc             	mov    -0x4(%rbp),%eax
    66cb:	8d 50 01             	lea    0x1(%rax),%edx
    66ce:	89 55 fc             	mov    %edx,-0x4(%rbp)
    66d1:	48 63 d0             	movslq %eax,%rdx
    66d4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    66d8:	48 01 c2             	add    %rax,%rdx
    66db:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    66df:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    66e1:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    66e5:	3c 0a                	cmp    $0xa,%al
    66e7:	74 16                	je     66ff <gets+0x79>
    66e9:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    66ed:	3c 0d                	cmp    $0xd,%al
    66ef:	74 0e                	je     66ff <gets+0x79>
  for(i=0; i+1 < max; ){
    66f1:	8b 45 fc             	mov    -0x4(%rbp),%eax
    66f4:	83 c0 01             	add    $0x1,%eax
    66f7:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    66fa:	7f a6                	jg     66a2 <gets+0x1c>
    66fc:	eb 01                	jmp    66ff <gets+0x79>
      break;
    66fe:	90                   	nop
      break;
  }
  buf[i] = '\0';
    66ff:	8b 45 fc             	mov    -0x4(%rbp),%eax
    6702:	48 63 d0             	movslq %eax,%rdx
    6705:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    6709:	48 01 d0             	add    %rdx,%rax
    670c:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    670f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    6713:	c9                   	leave
    6714:	c3                   	ret

0000000000006715 <stat>:

int
stat(char *n, struct stat *st)
{
    6715:	f3 0f 1e fa          	endbr64
    6719:	55                   	push   %rbp
    671a:	48 89 e5             	mov    %rsp,%rbp
    671d:	48 83 ec 20          	sub    $0x20,%rsp
    6721:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    6725:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    6729:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    672d:	be 00 00 00 00       	mov    $0x0,%esi
    6732:	48 89 c7             	mov    %rax,%rdi
    6735:	48 b8 ac 68 00 00 00 	movabs $0x68ac,%rax
    673c:	00 00 00 
    673f:	ff d0                	call   *%rax
    6741:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    6744:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    6748:	79 07                	jns    6751 <stat+0x3c>
    return -1;
    674a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    674f:	eb 2f                	jmp    6780 <stat+0x6b>
  r = fstat(fd, st);
    6751:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    6755:	8b 45 fc             	mov    -0x4(%rbp),%eax
    6758:	48 89 d6             	mov    %rdx,%rsi
    675b:	89 c7                	mov    %eax,%edi
    675d:	48 b8 d3 68 00 00 00 	movabs $0x68d3,%rax
    6764:	00 00 00 
    6767:	ff d0                	call   *%rax
    6769:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    676c:	8b 45 fc             	mov    -0x4(%rbp),%eax
    676f:	89 c7                	mov    %eax,%edi
    6771:	48 b8 85 68 00 00 00 	movabs $0x6885,%rax
    6778:	00 00 00 
    677b:	ff d0                	call   *%rax
  return r;
    677d:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    6780:	c9                   	leave
    6781:	c3                   	ret

0000000000006782 <atoi>:

int
atoi(const char *s)
{
    6782:	f3 0f 1e fa          	endbr64
    6786:	55                   	push   %rbp
    6787:	48 89 e5             	mov    %rsp,%rbp
    678a:	48 83 ec 18          	sub    $0x18,%rsp
    678e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    6792:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    6799:	eb 28                	jmp    67c3 <atoi+0x41>
    n = n*10 + *s++ - '0';
    679b:	8b 55 fc             	mov    -0x4(%rbp),%edx
    679e:	89 d0                	mov    %edx,%eax
    67a0:	c1 e0 02             	shl    $0x2,%eax
    67a3:	01 d0                	add    %edx,%eax
    67a5:	01 c0                	add    %eax,%eax
    67a7:	89 c1                	mov    %eax,%ecx
    67a9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    67ad:	48 8d 50 01          	lea    0x1(%rax),%rdx
    67b1:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    67b5:	0f b6 00             	movzbl (%rax),%eax
    67b8:	0f be c0             	movsbl %al,%eax
    67bb:	01 c8                	add    %ecx,%eax
    67bd:	83 e8 30             	sub    $0x30,%eax
    67c0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    67c3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    67c7:	0f b6 00             	movzbl (%rax),%eax
    67ca:	3c 2f                	cmp    $0x2f,%al
    67cc:	7e 0b                	jle    67d9 <atoi+0x57>
    67ce:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    67d2:	0f b6 00             	movzbl (%rax),%eax
    67d5:	3c 39                	cmp    $0x39,%al
    67d7:	7e c2                	jle    679b <atoi+0x19>
  return n;
    67d9:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    67dc:	c9                   	leave
    67dd:	c3                   	ret

00000000000067de <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    67de:	f3 0f 1e fa          	endbr64
    67e2:	55                   	push   %rbp
    67e3:	48 89 e5             	mov    %rsp,%rbp
    67e6:	48 83 ec 28          	sub    $0x28,%rsp
    67ea:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    67ee:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    67f2:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    67f5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    67f9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    67fd:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    6801:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    6805:	eb 1d                	jmp    6824 <memmove+0x46>
    *dst++ = *src++;
    6807:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    680b:	48 8d 42 01          	lea    0x1(%rdx),%rax
    680f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    6813:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6817:	48 8d 48 01          	lea    0x1(%rax),%rcx
    681b:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    681f:	0f b6 12             	movzbl (%rdx),%edx
    6822:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    6824:	8b 45 dc             	mov    -0x24(%rbp),%eax
    6827:	8d 50 ff             	lea    -0x1(%rax),%edx
    682a:	89 55 dc             	mov    %edx,-0x24(%rbp)
    682d:	85 c0                	test   %eax,%eax
    682f:	7f d6                	jg     6807 <memmove+0x29>
  return vdst;
    6831:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    6835:	c9                   	leave
    6836:	c3                   	ret

0000000000006837 <fork>:
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    6837:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    683e:	49 89 ca             	mov    %rcx,%r10
    6841:	0f 05                	syscall
    6843:	c3                   	ret

0000000000006844 <exit>:
SYSCALL(exit)
    6844:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    684b:	49 89 ca             	mov    %rcx,%r10
    684e:	0f 05                	syscall
    6850:	c3                   	ret

0000000000006851 <wait>:
SYSCALL(wait)
    6851:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    6858:	49 89 ca             	mov    %rcx,%r10
    685b:	0f 05                	syscall
    685d:	c3                   	ret

000000000000685e <pipe>:
SYSCALL(pipe)
    685e:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    6865:	49 89 ca             	mov    %rcx,%r10
    6868:	0f 05                	syscall
    686a:	c3                   	ret

000000000000686b <read>:
SYSCALL(read)
    686b:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    6872:	49 89 ca             	mov    %rcx,%r10
    6875:	0f 05                	syscall
    6877:	c3                   	ret

0000000000006878 <write>:
SYSCALL(write)
    6878:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    687f:	49 89 ca             	mov    %rcx,%r10
    6882:	0f 05                	syscall
    6884:	c3                   	ret

0000000000006885 <close>:
SYSCALL(close)
    6885:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    688c:	49 89 ca             	mov    %rcx,%r10
    688f:	0f 05                	syscall
    6891:	c3                   	ret

0000000000006892 <kill>:
SYSCALL(kill)
    6892:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    6899:	49 89 ca             	mov    %rcx,%r10
    689c:	0f 05                	syscall
    689e:	c3                   	ret

000000000000689f <exec>:
SYSCALL(exec)
    689f:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    68a6:	49 89 ca             	mov    %rcx,%r10
    68a9:	0f 05                	syscall
    68ab:	c3                   	ret

00000000000068ac <open>:
SYSCALL(open)
    68ac:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    68b3:	49 89 ca             	mov    %rcx,%r10
    68b6:	0f 05                	syscall
    68b8:	c3                   	ret

00000000000068b9 <mknod>:
SYSCALL(mknod)
    68b9:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    68c0:	49 89 ca             	mov    %rcx,%r10
    68c3:	0f 05                	syscall
    68c5:	c3                   	ret

00000000000068c6 <unlink>:
SYSCALL(unlink)
    68c6:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    68cd:	49 89 ca             	mov    %rcx,%r10
    68d0:	0f 05                	syscall
    68d2:	c3                   	ret

00000000000068d3 <fstat>:
SYSCALL(fstat)
    68d3:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    68da:	49 89 ca             	mov    %rcx,%r10
    68dd:	0f 05                	syscall
    68df:	c3                   	ret

00000000000068e0 <link>:
SYSCALL(link)
    68e0:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    68e7:	49 89 ca             	mov    %rcx,%r10
    68ea:	0f 05                	syscall
    68ec:	c3                   	ret

00000000000068ed <mkdir>:
SYSCALL(mkdir)
    68ed:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    68f4:	49 89 ca             	mov    %rcx,%r10
    68f7:	0f 05                	syscall
    68f9:	c3                   	ret

00000000000068fa <chdir>:
SYSCALL(chdir)
    68fa:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    6901:	49 89 ca             	mov    %rcx,%r10
    6904:	0f 05                	syscall
    6906:	c3                   	ret

0000000000006907 <dup>:
SYSCALL(dup)
    6907:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    690e:	49 89 ca             	mov    %rcx,%r10
    6911:	0f 05                	syscall
    6913:	c3                   	ret

0000000000006914 <getpid>:
SYSCALL(getpid)
    6914:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    691b:	49 89 ca             	mov    %rcx,%r10
    691e:	0f 05                	syscall
    6920:	c3                   	ret

0000000000006921 <sbrk>:
SYSCALL(sbrk)
    6921:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    6928:	49 89 ca             	mov    %rcx,%r10
    692b:	0f 05                	syscall
    692d:	c3                   	ret

000000000000692e <sleep>:
SYSCALL(sleep)
    692e:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    6935:	49 89 ca             	mov    %rcx,%r10
    6938:	0f 05                	syscall
    693a:	c3                   	ret

000000000000693b <uptime>:
SYSCALL(uptime)
    693b:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    6942:	49 89 ca             	mov    %rcx,%r10
    6945:	0f 05                	syscall
    6947:	c3                   	ret

0000000000006948 <send>:
SYSCALL(send)
    6948:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    694f:	49 89 ca             	mov    %rcx,%r10
    6952:	0f 05                	syscall
    6954:	c3                   	ret

0000000000006955 <recv>:
SYSCALL(recv)
    6955:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    695c:	49 89 ca             	mov    %rcx,%r10
    695f:	0f 05                	syscall
    6961:	c3                   	ret

0000000000006962 <register_fsserver>:
SYSCALL(register_fsserver)
    6962:	48 c7 c0 18 00 00 00 	mov    $0x18,%rax
    6969:	49 89 ca             	mov    %rcx,%r10
    696c:	0f 05                	syscall
    696e:	c3                   	ret

000000000000696f <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    696f:	f3 0f 1e fa          	endbr64
    6973:	55                   	push   %rbp
    6974:	48 89 e5             	mov    %rsp,%rbp
    6977:	48 83 ec 10          	sub    $0x10,%rsp
    697b:	89 7d fc             	mov    %edi,-0x4(%rbp)
    697e:	89 f0                	mov    %esi,%eax
    6980:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    6983:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    6987:	8b 45 fc             	mov    -0x4(%rbp),%eax
    698a:	ba 01 00 00 00       	mov    $0x1,%edx
    698f:	48 89 ce             	mov    %rcx,%rsi
    6992:	89 c7                	mov    %eax,%edi
    6994:	48 b8 78 68 00 00 00 	movabs $0x6878,%rax
    699b:	00 00 00 
    699e:	ff d0                	call   *%rax
}
    69a0:	90                   	nop
    69a1:	c9                   	leave
    69a2:	c3                   	ret

00000000000069a3 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    69a3:	f3 0f 1e fa          	endbr64
    69a7:	55                   	push   %rbp
    69a8:	48 89 e5             	mov    %rsp,%rbp
    69ab:	48 83 ec 20          	sub    $0x20,%rsp
    69af:	89 7d ec             	mov    %edi,-0x14(%rbp)
    69b2:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    69b6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    69bd:	eb 35                	jmp    69f4 <print_x64+0x51>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    69bf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    69c3:	48 c1 e8 3c          	shr    $0x3c,%rax
    69c7:	48 ba d0 89 00 00 00 	movabs $0x89d0,%rdx
    69ce:	00 00 00 
    69d1:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    69d5:	0f be d0             	movsbl %al,%edx
    69d8:	8b 45 ec             	mov    -0x14(%rbp),%eax
    69db:	89 d6                	mov    %edx,%esi
    69dd:	89 c7                	mov    %eax,%edi
    69df:	48 b8 6f 69 00 00 00 	movabs $0x696f,%rax
    69e6:	00 00 00 
    69e9:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    69eb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    69ef:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    69f4:	8b 45 fc             	mov    -0x4(%rbp),%eax
    69f7:	83 f8 0f             	cmp    $0xf,%eax
    69fa:	76 c3                	jbe    69bf <print_x64+0x1c>
}
    69fc:	90                   	nop
    69fd:	90                   	nop
    69fe:	c9                   	leave
    69ff:	c3                   	ret

0000000000006a00 <print_x32>:

  static void
print_x32(int fd, uint x)
{
    6a00:	f3 0f 1e fa          	endbr64
    6a04:	55                   	push   %rbp
    6a05:	48 89 e5             	mov    %rsp,%rbp
    6a08:	48 83 ec 20          	sub    $0x20,%rsp
    6a0c:	89 7d ec             	mov    %edi,-0x14(%rbp)
    6a0f:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    6a12:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    6a19:	eb 36                	jmp    6a51 <print_x32+0x51>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    6a1b:	8b 45 e8             	mov    -0x18(%rbp),%eax
    6a1e:	c1 e8 1c             	shr    $0x1c,%eax
    6a21:	89 c2                	mov    %eax,%edx
    6a23:	48 b8 d0 89 00 00 00 	movabs $0x89d0,%rax
    6a2a:	00 00 00 
    6a2d:	89 d2                	mov    %edx,%edx
    6a2f:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    6a33:	0f be d0             	movsbl %al,%edx
    6a36:	8b 45 ec             	mov    -0x14(%rbp),%eax
    6a39:	89 d6                	mov    %edx,%esi
    6a3b:	89 c7                	mov    %eax,%edi
    6a3d:	48 b8 6f 69 00 00 00 	movabs $0x696f,%rax
    6a44:	00 00 00 
    6a47:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    6a49:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    6a4d:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    6a51:	8b 45 fc             	mov    -0x4(%rbp),%eax
    6a54:	83 f8 07             	cmp    $0x7,%eax
    6a57:	76 c2                	jbe    6a1b <print_x32+0x1b>
}
    6a59:	90                   	nop
    6a5a:	90                   	nop
    6a5b:	c9                   	leave
    6a5c:	c3                   	ret

0000000000006a5d <print_d>:

  static void
print_d(int fd, int v)
{
    6a5d:	f3 0f 1e fa          	endbr64
    6a61:	55                   	push   %rbp
    6a62:	48 89 e5             	mov    %rsp,%rbp
    6a65:	48 83 ec 30          	sub    $0x30,%rsp
    6a69:	89 7d dc             	mov    %edi,-0x24(%rbp)
    6a6c:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    6a6f:	8b 45 d8             	mov    -0x28(%rbp),%eax
    6a72:	48 98                	cltq
    6a74:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    6a78:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    6a7c:	79 04                	jns    6a82 <print_d+0x25>
    x = -x;
    6a7e:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    6a82:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    6a89:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    6a8d:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    6a94:	66 66 66 
    6a97:	48 89 c8             	mov    %rcx,%rax
    6a9a:	48 f7 ea             	imul   %rdx
    6a9d:	48 c1 fa 02          	sar    $0x2,%rdx
    6aa1:	48 89 c8             	mov    %rcx,%rax
    6aa4:	48 c1 f8 3f          	sar    $0x3f,%rax
    6aa8:	48 29 c2             	sub    %rax,%rdx
    6aab:	48 89 d0             	mov    %rdx,%rax
    6aae:	48 c1 e0 02          	shl    $0x2,%rax
    6ab2:	48 01 d0             	add    %rdx,%rax
    6ab5:	48 01 c0             	add    %rax,%rax
    6ab8:	48 29 c1             	sub    %rax,%rcx
    6abb:	48 89 ca             	mov    %rcx,%rdx
    6abe:	8b 45 f4             	mov    -0xc(%rbp),%eax
    6ac1:	8d 48 01             	lea    0x1(%rax),%ecx
    6ac4:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    6ac7:	48 b9 d0 89 00 00 00 	movabs $0x89d0,%rcx
    6ace:	00 00 00 
    6ad1:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    6ad5:	48 98                	cltq
    6ad7:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    6adb:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    6adf:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    6ae6:	66 66 66 
    6ae9:	48 89 c8             	mov    %rcx,%rax
    6aec:	48 f7 ea             	imul   %rdx
    6aef:	48 89 d0             	mov    %rdx,%rax
    6af2:	48 c1 f8 02          	sar    $0x2,%rax
    6af6:	48 c1 f9 3f          	sar    $0x3f,%rcx
    6afa:	48 89 ca             	mov    %rcx,%rdx
    6afd:	48 29 d0             	sub    %rdx,%rax
    6b00:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    6b04:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    6b09:	0f 85 7a ff ff ff    	jne    6a89 <print_d+0x2c>

  if (v < 0)
    6b0f:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    6b13:	79 32                	jns    6b47 <print_d+0xea>
    buf[i++] = '-';
    6b15:	8b 45 f4             	mov    -0xc(%rbp),%eax
    6b18:	8d 50 01             	lea    0x1(%rax),%edx
    6b1b:	89 55 f4             	mov    %edx,-0xc(%rbp)
    6b1e:	48 98                	cltq
    6b20:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    6b25:	eb 20                	jmp    6b47 <print_d+0xea>
    putc(fd, buf[i]);
    6b27:	8b 45 f4             	mov    -0xc(%rbp),%eax
    6b2a:	48 98                	cltq
    6b2c:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    6b31:	0f be d0             	movsbl %al,%edx
    6b34:	8b 45 dc             	mov    -0x24(%rbp),%eax
    6b37:	89 d6                	mov    %edx,%esi
    6b39:	89 c7                	mov    %eax,%edi
    6b3b:	48 b8 6f 69 00 00 00 	movabs $0x696f,%rax
    6b42:	00 00 00 
    6b45:	ff d0                	call   *%rax
  while (--i >= 0)
    6b47:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    6b4b:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    6b4f:	79 d6                	jns    6b27 <print_d+0xca>
}
    6b51:	90                   	nop
    6b52:	90                   	nop
    6b53:	c9                   	leave
    6b54:	c3                   	ret

0000000000006b55 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    6b55:	f3 0f 1e fa          	endbr64
    6b59:	55                   	push   %rbp
    6b5a:	48 89 e5             	mov    %rsp,%rbp
    6b5d:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    6b64:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    6b6a:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    6b71:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    6b78:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    6b7f:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    6b86:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    6b8d:	84 c0                	test   %al,%al
    6b8f:	74 20                	je     6bb1 <printf+0x5c>
    6b91:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    6b95:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    6b99:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    6b9d:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    6ba1:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    6ba5:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    6ba9:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    6bad:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    6bb1:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    6bb8:	00 00 00 
    6bbb:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    6bc2:	00 00 00 
    6bc5:	48 8d 45 10          	lea    0x10(%rbp),%rax
    6bc9:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    6bd0:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    6bd7:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    6bde:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    6be5:	00 00 00 
    6be8:	e9 41 03 00 00       	jmp    6f2e <printf+0x3d9>
    if (c != '%') {
    6bed:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    6bf4:	74 24                	je     6c1a <printf+0xc5>
      putc(fd, c);
    6bf6:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    6bfc:	0f be d0             	movsbl %al,%edx
    6bff:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    6c05:	89 d6                	mov    %edx,%esi
    6c07:	89 c7                	mov    %eax,%edi
    6c09:	48 b8 6f 69 00 00 00 	movabs $0x696f,%rax
    6c10:	00 00 00 
    6c13:	ff d0                	call   *%rax
      continue;
    6c15:	e9 0d 03 00 00       	jmp    6f27 <printf+0x3d2>
    }
    c = fmt[++i] & 0xff;
    6c1a:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    6c21:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    6c27:	48 63 d0             	movslq %eax,%rdx
    6c2a:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    6c31:	48 01 d0             	add    %rdx,%rax
    6c34:	0f b6 00             	movzbl (%rax),%eax
    6c37:	0f be c0             	movsbl %al,%eax
    6c3a:	25 ff 00 00 00       	and    $0xff,%eax
    6c3f:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    6c45:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    6c4c:	0f 84 0f 03 00 00    	je     6f61 <printf+0x40c>
      break;
    switch(c) {
    6c52:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    6c59:	0f 84 74 02 00 00    	je     6ed3 <printf+0x37e>
    6c5f:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    6c66:	0f 8c 82 02 00 00    	jl     6eee <printf+0x399>
    6c6c:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    6c73:	0f 8f 75 02 00 00    	jg     6eee <printf+0x399>
    6c79:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    6c80:	0f 8c 68 02 00 00    	jl     6eee <printf+0x399>
    6c86:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    6c8c:	83 e8 63             	sub    $0x63,%eax
    6c8f:	83 f8 15             	cmp    $0x15,%eax
    6c92:	0f 87 56 02 00 00    	ja     6eee <printf+0x399>
    6c98:	89 c0                	mov    %eax,%eax
    6c9a:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    6ca1:	00 
    6ca2:	48 b8 f0 88 00 00 00 	movabs $0x88f0,%rax
    6ca9:	00 00 00 
    6cac:	48 01 d0             	add    %rdx,%rax
    6caf:	48 8b 00             	mov    (%rax),%rax
    6cb2:	3e ff e0             	notrack jmp *%rax
    case 'c':
      putc(fd, va_arg(ap, int));
    6cb5:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    6cbb:	83 f8 2f             	cmp    $0x2f,%eax
    6cbe:	77 23                	ja     6ce3 <printf+0x18e>
    6cc0:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    6cc7:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    6ccd:	89 d2                	mov    %edx,%edx
    6ccf:	48 01 d0             	add    %rdx,%rax
    6cd2:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    6cd8:	83 c2 08             	add    $0x8,%edx
    6cdb:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    6ce1:	eb 12                	jmp    6cf5 <printf+0x1a0>
    6ce3:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    6cea:	48 8d 50 08          	lea    0x8(%rax),%rdx
    6cee:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    6cf5:	8b 00                	mov    (%rax),%eax
    6cf7:	0f be d0             	movsbl %al,%edx
    6cfa:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    6d00:	89 d6                	mov    %edx,%esi
    6d02:	89 c7                	mov    %eax,%edi
    6d04:	48 b8 6f 69 00 00 00 	movabs $0x696f,%rax
    6d0b:	00 00 00 
    6d0e:	ff d0                	call   *%rax
      break;
    6d10:	e9 12 02 00 00       	jmp    6f27 <printf+0x3d2>
    case 'd':
      print_d(fd, va_arg(ap, int));
    6d15:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    6d1b:	83 f8 2f             	cmp    $0x2f,%eax
    6d1e:	77 23                	ja     6d43 <printf+0x1ee>
    6d20:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    6d27:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    6d2d:	89 d2                	mov    %edx,%edx
    6d2f:	48 01 d0             	add    %rdx,%rax
    6d32:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    6d38:	83 c2 08             	add    $0x8,%edx
    6d3b:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    6d41:	eb 12                	jmp    6d55 <printf+0x200>
    6d43:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    6d4a:	48 8d 50 08          	lea    0x8(%rax),%rdx
    6d4e:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    6d55:	8b 10                	mov    (%rax),%edx
    6d57:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    6d5d:	89 d6                	mov    %edx,%esi
    6d5f:	89 c7                	mov    %eax,%edi
    6d61:	48 b8 5d 6a 00 00 00 	movabs $0x6a5d,%rax
    6d68:	00 00 00 
    6d6b:	ff d0                	call   *%rax
      break;
    6d6d:	e9 b5 01 00 00       	jmp    6f27 <printf+0x3d2>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    6d72:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    6d78:	83 f8 2f             	cmp    $0x2f,%eax
    6d7b:	77 23                	ja     6da0 <printf+0x24b>
    6d7d:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    6d84:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    6d8a:	89 d2                	mov    %edx,%edx
    6d8c:	48 01 d0             	add    %rdx,%rax
    6d8f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    6d95:	83 c2 08             	add    $0x8,%edx
    6d98:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    6d9e:	eb 12                	jmp    6db2 <printf+0x25d>
    6da0:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    6da7:	48 8d 50 08          	lea    0x8(%rax),%rdx
    6dab:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    6db2:	8b 10                	mov    (%rax),%edx
    6db4:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    6dba:	89 d6                	mov    %edx,%esi
    6dbc:	89 c7                	mov    %eax,%edi
    6dbe:	48 b8 00 6a 00 00 00 	movabs $0x6a00,%rax
    6dc5:	00 00 00 
    6dc8:	ff d0                	call   *%rax
      break;
    6dca:	e9 58 01 00 00       	jmp    6f27 <printf+0x3d2>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    6dcf:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    6dd5:	83 f8 2f             	cmp    $0x2f,%eax
    6dd8:	77 23                	ja     6dfd <printf+0x2a8>
    6dda:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    6de1:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    6de7:	89 d2                	mov    %edx,%edx
    6de9:	48 01 d0             	add    %rdx,%rax
    6dec:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    6df2:	83 c2 08             	add    $0x8,%edx
    6df5:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    6dfb:	eb 12                	jmp    6e0f <printf+0x2ba>
    6dfd:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    6e04:	48 8d 50 08          	lea    0x8(%rax),%rdx
    6e08:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    6e0f:	48 8b 10             	mov    (%rax),%rdx
    6e12:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    6e18:	48 89 d6             	mov    %rdx,%rsi
    6e1b:	89 c7                	mov    %eax,%edi
    6e1d:	48 b8 a3 69 00 00 00 	movabs $0x69a3,%rax
    6e24:	00 00 00 
    6e27:	ff d0                	call   *%rax
      break;
    6e29:	e9 f9 00 00 00       	jmp    6f27 <printf+0x3d2>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    6e2e:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    6e34:	83 f8 2f             	cmp    $0x2f,%eax
    6e37:	77 23                	ja     6e5c <printf+0x307>
    6e39:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    6e40:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    6e46:	89 d2                	mov    %edx,%edx
    6e48:	48 01 d0             	add    %rdx,%rax
    6e4b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    6e51:	83 c2 08             	add    $0x8,%edx
    6e54:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    6e5a:	eb 12                	jmp    6e6e <printf+0x319>
    6e5c:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    6e63:	48 8d 50 08          	lea    0x8(%rax),%rdx
    6e67:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    6e6e:	48 8b 00             	mov    (%rax),%rax
    6e71:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    6e78:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    6e7f:	00 
    6e80:	75 41                	jne    6ec3 <printf+0x36e>
        s = "(null)";
    6e82:	48 b8 e8 88 00 00 00 	movabs $0x88e8,%rax
    6e89:	00 00 00 
    6e8c:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    6e93:	eb 2e                	jmp    6ec3 <printf+0x36e>
        putc(fd, *(s++));
    6e95:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    6e9c:	48 8d 50 01          	lea    0x1(%rax),%rdx
    6ea0:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    6ea7:	0f b6 00             	movzbl (%rax),%eax
    6eaa:	0f be d0             	movsbl %al,%edx
    6ead:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    6eb3:	89 d6                	mov    %edx,%esi
    6eb5:	89 c7                	mov    %eax,%edi
    6eb7:	48 b8 6f 69 00 00 00 	movabs $0x696f,%rax
    6ebe:	00 00 00 
    6ec1:	ff d0                	call   *%rax
      while (*s)
    6ec3:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    6eca:	0f b6 00             	movzbl (%rax),%eax
    6ecd:	84 c0                	test   %al,%al
    6ecf:	75 c4                	jne    6e95 <printf+0x340>
      break;
    6ed1:	eb 54                	jmp    6f27 <printf+0x3d2>
    case '%':
      putc(fd, '%');
    6ed3:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    6ed9:	be 25 00 00 00       	mov    $0x25,%esi
    6ede:	89 c7                	mov    %eax,%edi
    6ee0:	48 b8 6f 69 00 00 00 	movabs $0x696f,%rax
    6ee7:	00 00 00 
    6eea:	ff d0                	call   *%rax
      break;
    6eec:	eb 39                	jmp    6f27 <printf+0x3d2>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    6eee:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    6ef4:	be 25 00 00 00       	mov    $0x25,%esi
    6ef9:	89 c7                	mov    %eax,%edi
    6efb:	48 b8 6f 69 00 00 00 	movabs $0x696f,%rax
    6f02:	00 00 00 
    6f05:	ff d0                	call   *%rax
      putc(fd, c);
    6f07:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    6f0d:	0f be d0             	movsbl %al,%edx
    6f10:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    6f16:	89 d6                	mov    %edx,%esi
    6f18:	89 c7                	mov    %eax,%edi
    6f1a:	48 b8 6f 69 00 00 00 	movabs $0x696f,%rax
    6f21:	00 00 00 
    6f24:	ff d0                	call   *%rax
      break;
    6f26:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    6f27:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    6f2e:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    6f34:	48 63 d0             	movslq %eax,%rdx
    6f37:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    6f3e:	48 01 d0             	add    %rdx,%rax
    6f41:	0f b6 00             	movzbl (%rax),%eax
    6f44:	0f be c0             	movsbl %al,%eax
    6f47:	25 ff 00 00 00       	and    $0xff,%eax
    6f4c:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    6f52:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    6f59:	0f 85 8e fc ff ff    	jne    6bed <printf+0x98>
    }
  }
}
    6f5f:	eb 01                	jmp    6f62 <printf+0x40d>
      break;
    6f61:	90                   	nop
}
    6f62:	90                   	nop
    6f63:	c9                   	leave
    6f64:	c3                   	ret

0000000000006f65 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    6f65:	f3 0f 1e fa          	endbr64
    6f69:	55                   	push   %rbp
    6f6a:	48 89 e5             	mov    %rsp,%rbp
    6f6d:	48 83 ec 18          	sub    $0x18,%rsp
    6f71:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    6f75:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    6f79:	48 83 e8 10          	sub    $0x10,%rax
    6f7d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    6f81:	48 b8 50 d2 00 00 00 	movabs $0xd250,%rax
    6f88:	00 00 00 
    6f8b:	48 8b 00             	mov    (%rax),%rax
    6f8e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    6f92:	eb 2f                	jmp    6fc3 <free+0x5e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    6f94:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6f98:	48 8b 00             	mov    (%rax),%rax
    6f9b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    6f9f:	72 17                	jb     6fb8 <free+0x53>
    6fa1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    6fa5:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    6fa9:	72 2f                	jb     6fda <free+0x75>
    6fab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6faf:	48 8b 00             	mov    (%rax),%rax
    6fb2:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    6fb6:	72 22                	jb     6fda <free+0x75>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    6fb8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6fbc:	48 8b 00             	mov    (%rax),%rax
    6fbf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    6fc3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    6fc7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    6fcb:	73 c7                	jae    6f94 <free+0x2f>
    6fcd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6fd1:	48 8b 00             	mov    (%rax),%rax
    6fd4:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    6fd8:	73 ba                	jae    6f94 <free+0x2f>
      break;
  if(bp + bp->s.size == p->s.ptr){
    6fda:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    6fde:	8b 40 08             	mov    0x8(%rax),%eax
    6fe1:	89 c0                	mov    %eax,%eax
    6fe3:	48 c1 e0 04          	shl    $0x4,%rax
    6fe7:	48 89 c2             	mov    %rax,%rdx
    6fea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    6fee:	48 01 c2             	add    %rax,%rdx
    6ff1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6ff5:	48 8b 00             	mov    (%rax),%rax
    6ff8:	48 39 c2             	cmp    %rax,%rdx
    6ffb:	75 2d                	jne    702a <free+0xc5>
    bp->s.size += p->s.ptr->s.size;
    6ffd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    7001:	8b 50 08             	mov    0x8(%rax),%edx
    7004:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    7008:	48 8b 00             	mov    (%rax),%rax
    700b:	8b 40 08             	mov    0x8(%rax),%eax
    700e:	01 c2                	add    %eax,%edx
    7010:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    7014:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    7017:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    701b:	48 8b 00             	mov    (%rax),%rax
    701e:	48 8b 10             	mov    (%rax),%rdx
    7021:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    7025:	48 89 10             	mov    %rdx,(%rax)
    7028:	eb 0e                	jmp    7038 <free+0xd3>
  } else
    bp->s.ptr = p->s.ptr;
    702a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    702e:	48 8b 10             	mov    (%rax),%rdx
    7031:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    7035:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    7038:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    703c:	8b 40 08             	mov    0x8(%rax),%eax
    703f:	89 c0                	mov    %eax,%eax
    7041:	48 c1 e0 04          	shl    $0x4,%rax
    7045:	48 89 c2             	mov    %rax,%rdx
    7048:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    704c:	48 01 d0             	add    %rdx,%rax
    704f:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    7053:	75 27                	jne    707c <free+0x117>
    p->s.size += bp->s.size;
    7055:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    7059:	8b 50 08             	mov    0x8(%rax),%edx
    705c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    7060:	8b 40 08             	mov    0x8(%rax),%eax
    7063:	01 c2                	add    %eax,%edx
    7065:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    7069:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    706c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    7070:	48 8b 10             	mov    (%rax),%rdx
    7073:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    7077:	48 89 10             	mov    %rdx,(%rax)
    707a:	eb 0b                	jmp    7087 <free+0x122>
  } else
    p->s.ptr = bp;
    707c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    7080:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    7084:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    7087:	48 ba 50 d2 00 00 00 	movabs $0xd250,%rdx
    708e:	00 00 00 
    7091:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    7095:	48 89 02             	mov    %rax,(%rdx)
}
    7098:	90                   	nop
    7099:	c9                   	leave
    709a:	c3                   	ret

000000000000709b <morecore>:

static Header*
morecore(uint nu)
{
    709b:	f3 0f 1e fa          	endbr64
    709f:	55                   	push   %rbp
    70a0:	48 89 e5             	mov    %rsp,%rbp
    70a3:	48 83 ec 20          	sub    $0x20,%rsp
    70a7:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    70aa:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    70b1:	77 07                	ja     70ba <morecore+0x1f>
    nu = 4096;
    70b3:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    70ba:	8b 45 ec             	mov    -0x14(%rbp),%eax
    70bd:	48 c1 e0 04          	shl    $0x4,%rax
    70c1:	48 89 c7             	mov    %rax,%rdi
    70c4:	48 b8 21 69 00 00 00 	movabs $0x6921,%rax
    70cb:	00 00 00 
    70ce:	ff d0                	call   *%rax
    70d0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    70d4:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    70d9:	75 07                	jne    70e2 <morecore+0x47>
    return 0;
    70db:	b8 00 00 00 00       	mov    $0x0,%eax
    70e0:	eb 36                	jmp    7118 <morecore+0x7d>
  hp = (Header*)p;
    70e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    70e6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    70ea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    70ee:	8b 55 ec             	mov    -0x14(%rbp),%edx
    70f1:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    70f4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    70f8:	48 83 c0 10          	add    $0x10,%rax
    70fc:	48 89 c7             	mov    %rax,%rdi
    70ff:	48 b8 65 6f 00 00 00 	movabs $0x6f65,%rax
    7106:	00 00 00 
    7109:	ff d0                	call   *%rax
  return freep;
    710b:	48 b8 50 d2 00 00 00 	movabs $0xd250,%rax
    7112:	00 00 00 
    7115:	48 8b 00             	mov    (%rax),%rax
}
    7118:	c9                   	leave
    7119:	c3                   	ret

000000000000711a <malloc>:

void*
malloc(uint nbytes)
{
    711a:	f3 0f 1e fa          	endbr64
    711e:	55                   	push   %rbp
    711f:	48 89 e5             	mov    %rsp,%rbp
    7122:	48 83 ec 30          	sub    $0x30,%rsp
    7126:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    7129:	8b 45 dc             	mov    -0x24(%rbp),%eax
    712c:	48 83 c0 0f          	add    $0xf,%rax
    7130:	48 c1 e8 04          	shr    $0x4,%rax
    7134:	83 c0 01             	add    $0x1,%eax
    7137:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    713a:	48 b8 50 d2 00 00 00 	movabs $0xd250,%rax
    7141:	00 00 00 
    7144:	48 8b 00             	mov    (%rax),%rax
    7147:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    714b:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    7150:	75 4a                	jne    719c <malloc+0x82>
    base.s.ptr = freep = prevp = &base;
    7152:	48 b8 40 d2 00 00 00 	movabs $0xd240,%rax
    7159:	00 00 00 
    715c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    7160:	48 ba 50 d2 00 00 00 	movabs $0xd250,%rdx
    7167:	00 00 00 
    716a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    716e:	48 89 02             	mov    %rax,(%rdx)
    7171:	48 b8 50 d2 00 00 00 	movabs $0xd250,%rax
    7178:	00 00 00 
    717b:	48 8b 00             	mov    (%rax),%rax
    717e:	48 ba 40 d2 00 00 00 	movabs $0xd240,%rdx
    7185:	00 00 00 
    7188:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    718b:	48 b8 40 d2 00 00 00 	movabs $0xd240,%rax
    7192:	00 00 00 
    7195:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    719c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    71a0:	48 8b 00             	mov    (%rax),%rax
    71a3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    71a7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    71ab:	8b 40 08             	mov    0x8(%rax),%eax
    71ae:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    71b1:	72 65                	jb     7218 <malloc+0xfe>
      if(p->s.size == nunits)
    71b3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    71b7:	8b 40 08             	mov    0x8(%rax),%eax
    71ba:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    71bd:	75 10                	jne    71cf <malloc+0xb5>
        prevp->s.ptr = p->s.ptr;
    71bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    71c3:	48 8b 10             	mov    (%rax),%rdx
    71c6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    71ca:	48 89 10             	mov    %rdx,(%rax)
    71cd:	eb 2e                	jmp    71fd <malloc+0xe3>
      else {
        p->s.size -= nunits;
    71cf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    71d3:	8b 40 08             	mov    0x8(%rax),%eax
    71d6:	2b 45 ec             	sub    -0x14(%rbp),%eax
    71d9:	89 c2                	mov    %eax,%edx
    71db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    71df:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    71e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    71e6:	8b 40 08             	mov    0x8(%rax),%eax
    71e9:	89 c0                	mov    %eax,%eax
    71eb:	48 c1 e0 04          	shl    $0x4,%rax
    71ef:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    71f3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    71f7:	8b 55 ec             	mov    -0x14(%rbp),%edx
    71fa:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    71fd:	48 ba 50 d2 00 00 00 	movabs $0xd250,%rdx
    7204:	00 00 00 
    7207:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    720b:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    720e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    7212:	48 83 c0 10          	add    $0x10,%rax
    7216:	eb 4e                	jmp    7266 <malloc+0x14c>
    }
    if(p == freep)
    7218:	48 b8 50 d2 00 00 00 	movabs $0xd250,%rax
    721f:	00 00 00 
    7222:	48 8b 00             	mov    (%rax),%rax
    7225:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    7229:	75 23                	jne    724e <malloc+0x134>
      if((p = morecore(nunits)) == 0)
    722b:	8b 45 ec             	mov    -0x14(%rbp),%eax
    722e:	89 c7                	mov    %eax,%edi
    7230:	48 b8 9b 70 00 00 00 	movabs $0x709b,%rax
    7237:	00 00 00 
    723a:	ff d0                	call   *%rax
    723c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    7240:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    7245:	75 07                	jne    724e <malloc+0x134>
        return 0;
    7247:	b8 00 00 00 00       	mov    $0x0,%eax
    724c:	eb 18                	jmp    7266 <malloc+0x14c>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    724e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    7252:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    7256:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    725a:	48 8b 00             	mov    (%rax),%rax
    725d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    7261:	e9 41 ff ff ff       	jmp    71a7 <malloc+0x8d>
  }
}
    7266:	c9                   	leave
    7267:	c3                   	ret
