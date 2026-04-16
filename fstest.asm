
_fstest:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <fs_call>:
// larger multi-chunk transfers. Why: the proposal requires measuring IPC and
// context-switch overhead against the monolithic baseline.

static int
fs_call(int server_pid, struct ipc_msg *msg)
{
    1000:	f3 0f 1e fa          	endbr64
    1004:	55                   	push   %rbp
    1005:	48 89 e5             	mov    %rsp,%rbp
    1008:	53                   	push   %rbx
    1009:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
    1010:	89 bd 0c ff ff ff    	mov    %edi,-0xf4(%rbp)
    1016:	48 89 b5 00 ff ff ff 	mov    %rsi,-0x100(%rbp)
  struct ipc_msg reply;

  if(send(server_pid, msg) < 0)
    101d:	48 8b 95 00 ff ff ff 	mov    -0x100(%rbp),%rdx
    1024:	8b 85 0c ff ff ff    	mov    -0xf4(%rbp),%eax
    102a:	48 89 d6             	mov    %rdx,%rsi
    102d:	89 c7                	mov    %eax,%edi
    102f:	48 b8 52 1b 00 00 00 	movabs $0x1b52,%rax
    1036:	00 00 00 
    1039:	ff d0                	call   *%rax
    103b:	85 c0                	test   %eax,%eax
    103d:	79 0a                	jns    1049 <fs_call+0x49>
    return -1;
    103f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1044:	e9 72 01 00 00       	jmp    11bb <fs_call+0x1bb>
  if(recv(&reply) < 0)
    1049:	48 8d 85 10 ff ff ff 	lea    -0xf0(%rbp),%rax
    1050:	48 89 c7             	mov    %rax,%rdi
    1053:	48 b8 5f 1b 00 00 00 	movabs $0x1b5f,%rax
    105a:	00 00 00 
    105d:	ff d0                	call   *%rax
    105f:	85 c0                	test   %eax,%eax
    1061:	79 0a                	jns    106d <fs_call+0x6d>
    return -1;
    1063:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1068:	e9 4e 01 00 00       	jmp    11bb <fs_call+0x1bb>
  if(reply.type != IPC_TYPE_FS_REPLY)
    106d:	8b 85 18 ff ff ff    	mov    -0xe8(%rbp),%eax
    1073:	83 f8 64             	cmp    $0x64,%eax
    1076:	74 0a                	je     1082 <fs_call+0x82>
    return -1;
    1078:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    107d:	e9 39 01 00 00       	jmp    11bb <fs_call+0x1bb>

  *msg = reply;
    1082:	48 8b 85 00 ff ff ff 	mov    -0x100(%rbp),%rax
    1089:	48 8b 8d 10 ff ff ff 	mov    -0xf0(%rbp),%rcx
    1090:	48 8b 9d 18 ff ff ff 	mov    -0xe8(%rbp),%rbx
    1097:	48 89 08             	mov    %rcx,(%rax)
    109a:	48 89 58 08          	mov    %rbx,0x8(%rax)
    109e:	48 8b 8d 20 ff ff ff 	mov    -0xe0(%rbp),%rcx
    10a5:	48 8b 9d 28 ff ff ff 	mov    -0xd8(%rbp),%rbx
    10ac:	48 89 48 10          	mov    %rcx,0x10(%rax)
    10b0:	48 89 58 18          	mov    %rbx,0x18(%rax)
    10b4:	48 8b 8d 30 ff ff ff 	mov    -0xd0(%rbp),%rcx
    10bb:	48 8b 9d 38 ff ff ff 	mov    -0xc8(%rbp),%rbx
    10c2:	48 89 48 20          	mov    %rcx,0x20(%rax)
    10c6:	48 89 58 28          	mov    %rbx,0x28(%rax)
    10ca:	48 8b 8d 40 ff ff ff 	mov    -0xc0(%rbp),%rcx
    10d1:	48 8b 9d 48 ff ff ff 	mov    -0xb8(%rbp),%rbx
    10d8:	48 89 48 30          	mov    %rcx,0x30(%rax)
    10dc:	48 89 58 38          	mov    %rbx,0x38(%rax)
    10e0:	48 8b 8d 50 ff ff ff 	mov    -0xb0(%rbp),%rcx
    10e7:	48 8b 9d 58 ff ff ff 	mov    -0xa8(%rbp),%rbx
    10ee:	48 89 48 40          	mov    %rcx,0x40(%rax)
    10f2:	48 89 58 48          	mov    %rbx,0x48(%rax)
    10f6:	48 8b 8d 60 ff ff ff 	mov    -0xa0(%rbp),%rcx
    10fd:	48 8b 9d 68 ff ff ff 	mov    -0x98(%rbp),%rbx
    1104:	48 89 48 50          	mov    %rcx,0x50(%rax)
    1108:	48 89 58 58          	mov    %rbx,0x58(%rax)
    110c:	48 8b 8d 70 ff ff ff 	mov    -0x90(%rbp),%rcx
    1113:	48 8b 9d 78 ff ff ff 	mov    -0x88(%rbp),%rbx
    111a:	48 89 48 60          	mov    %rcx,0x60(%rax)
    111e:	48 89 58 68          	mov    %rbx,0x68(%rax)
    1122:	48 8b 4d 80          	mov    -0x80(%rbp),%rcx
    1126:	48 8b 5d 88          	mov    -0x78(%rbp),%rbx
    112a:	48 89 48 70          	mov    %rcx,0x70(%rax)
    112e:	48 89 58 78          	mov    %rbx,0x78(%rax)
    1132:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
    1136:	48 8b 5d 98          	mov    -0x68(%rbp),%rbx
    113a:	48 89 88 80 00 00 00 	mov    %rcx,0x80(%rax)
    1141:	48 89 98 88 00 00 00 	mov    %rbx,0x88(%rax)
    1148:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
    114c:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
    1150:	48 89 88 90 00 00 00 	mov    %rcx,0x90(%rax)
    1157:	48 89 98 98 00 00 00 	mov    %rbx,0x98(%rax)
    115e:	48 8b 4d b0          	mov    -0x50(%rbp),%rcx
    1162:	48 8b 5d b8          	mov    -0x48(%rbp),%rbx
    1166:	48 89 88 a0 00 00 00 	mov    %rcx,0xa0(%rax)
    116d:	48 89 98 a8 00 00 00 	mov    %rbx,0xa8(%rax)
    1174:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
    1178:	48 8b 5d c8          	mov    -0x38(%rbp),%rbx
    117c:	48 89 88 b0 00 00 00 	mov    %rcx,0xb0(%rax)
    1183:	48 89 98 b8 00 00 00 	mov    %rbx,0xb8(%rax)
    118a:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
    118e:	48 8b 5d d8          	mov    -0x28(%rbp),%rbx
    1192:	48 89 88 c0 00 00 00 	mov    %rcx,0xc0(%rax)
    1199:	48 89 98 c8 00 00 00 	mov    %rbx,0xc8(%rax)
    11a0:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
    11a4:	48 8b 5d e8          	mov    -0x18(%rbp),%rbx
    11a8:	48 89 88 d0 00 00 00 	mov    %rcx,0xd0(%rax)
    11af:	48 89 98 d8 00 00 00 	mov    %rbx,0xd8(%rax)
  return 0;
    11b6:	b8 00 00 00 00       	mov    $0x0,%eax
}
    11bb:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
    11bf:	c9                   	leave
    11c0:	c3                   	ret

00000000000011c1 <fs_shutdown_remote>:

static void
fs_shutdown_remote(int server_pid)
{
    11c1:	f3 0f 1e fa          	endbr64
    11c5:	55                   	push   %rbp
    11c6:	48 89 e5             	mov    %rsp,%rbp
    11c9:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    11d0:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
  struct ipc_msg msg;
  memset(&msg, 0, sizeof(msg));
    11d6:	48 8d 85 20 ff ff ff 	lea    -0xe0(%rbp),%rax
    11dd:	ba e0 00 00 00       	mov    $0xe0,%edx
    11e2:	be 00 00 00 00       	mov    $0x0,%esi
    11e7:	48 89 c7             	mov    %rax,%rdi
    11ea:	48 b8 19 18 00 00 00 	movabs $0x1819,%rax
    11f1:	00 00 00 
    11f4:	ff d0                	call   *%rax
  msg.type = IPC_TYPE_FS_SHUTDOWN;
    11f6:	c7 85 28 ff ff ff 65 	movl   $0x65,-0xd8(%rbp)
    11fd:	00 00 00 
  fs_call(server_pid, &msg);
    1200:	48 8d 95 20 ff ff ff 	lea    -0xe0(%rbp),%rdx
    1207:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    120d:	48 89 d6             	mov    %rdx,%rsi
    1210:	89 c7                	mov    %eax,%edi
    1212:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1219:	00 00 00 
    121c:	ff d0                	call   *%rax
}
    121e:	90                   	nop
    121f:	c9                   	leave
    1220:	c3                   	ret

0000000000001221 <main>:

int
main(void)
{
    1221:	f3 0f 1e fa          	endbr64
    1225:	55                   	push   %rbp
    1226:	48 89 e5             	mov    %rsp,%rbp
    1229:	48 81 ec d0 00 00 00 	sub    $0xd0,%rsp
  int n;
  int i;
  int start;
  int end;
  char buf[IPC_DATA_SIZE + 1];
  char msg[] = "hello from IPC file server\n";
    1230:	48 b8 68 65 6c 6c 6f 	movabs $0x7266206f6c6c6568,%rax
    1237:	20 66 72 
    123a:	48 ba 6f 6d 20 49 50 	movabs $0x6620435049206d6f,%rdx
    1241:	43 20 66 
    1244:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    124b:	48 89 95 48 ff ff ff 	mov    %rdx,-0xb8(%rbp)
    1252:	48 b8 50 43 20 66 69 	movabs $0x20656c6966204350,%rax
    1259:	6c 65 20 
    125c:	48 ba 73 65 72 76 65 	movabs $0xa726576726573,%rdx
    1263:	72 0a 00 
    1266:	48 89 85 4c ff ff ff 	mov    %rax,-0xb4(%rbp)
    126d:	48 89 95 54 ff ff ff 	mov    %rdx,-0xac(%rbp)

  start = uptime();
    1274:	48 b8 45 1b 00 00 00 	movabs $0x1b45,%rax
    127b:	00 00 00 
    127e:	ff d0                	call   *%rax
    1280:	89 45 f8             	mov    %eax,-0x8(%rbp)
  for(i = 0; i < 20; i++){
    1283:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    128a:	eb 6f                	jmp    12fb <main+0xda>
    fd = open("baseline.txt", O_CREATE | O_RDWR);
    128c:	be 02 02 00 00       	mov    $0x202,%esi
    1291:	48 b8 78 24 00 00 00 	movabs $0x2478,%rax
    1298:	00 00 00 
    129b:	48 89 c7             	mov    %rax,%rdi
    129e:	48 b8 b6 1a 00 00 00 	movabs $0x1ab6,%rax
    12a5:	00 00 00 
    12a8:	ff d0                	call   *%rax
    12aa:	89 45 ec             	mov    %eax,-0x14(%rbp)
    if(fd >= 0){
    12ad:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
    12b1:	78 44                	js     12f7 <main+0xd6>
      write(fd, msg, strlen(msg));
    12b3:	48 8d 85 40 ff ff ff 	lea    -0xc0(%rbp),%rax
    12ba:	48 89 c7             	mov    %rax,%rdi
    12bd:	48 b8 e3 17 00 00 00 	movabs $0x17e3,%rax
    12c4:	00 00 00 
    12c7:	ff d0                	call   *%rax
    12c9:	89 c2                	mov    %eax,%edx
    12cb:	48 8d 8d 40 ff ff ff 	lea    -0xc0(%rbp),%rcx
    12d2:	8b 45 ec             	mov    -0x14(%rbp),%eax
    12d5:	48 89 ce             	mov    %rcx,%rsi
    12d8:	89 c7                	mov    %eax,%edi
    12da:	48 b8 82 1a 00 00 00 	movabs $0x1a82,%rax
    12e1:	00 00 00 
    12e4:	ff d0                	call   *%rax
      close(fd);
    12e6:	8b 45 ec             	mov    -0x14(%rbp),%eax
    12e9:	89 c7                	mov    %eax,%edi
    12eb:	48 b8 8f 1a 00 00 00 	movabs $0x1a8f,%rax
    12f2:	00 00 00 
    12f5:	ff d0                	call   *%rax
  for(i = 0; i < 20; i++){
    12f7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    12fb:	83 7d fc 13          	cmpl   $0x13,-0x4(%rbp)
    12ff:	7e 8b                	jle    128c <main+0x6b>
    }
  }
  end = uptime();
    1301:	48 b8 45 1b 00 00 00 	movabs $0x1b45,%rax
    1308:	00 00 00 
    130b:	ff d0                	call   *%rax
    130d:	89 45 f4             	mov    %eax,-0xc(%rbp)
  printf(1, "fstest: baseline kernel fs loop took %d ticks\n", end - start);
    1310:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1313:	2b 45 f8             	sub    -0x8(%rbp),%eax
    1316:	89 c2                	mov    %eax,%edx
    1318:	48 b8 88 24 00 00 00 	movabs $0x2488,%rax
    131f:	00 00 00 
    1322:	48 89 c6             	mov    %rax,%rsi
    1325:	bf 01 00 00 00       	mov    $0x1,%edi
    132a:	b8 00 00 00 00       	mov    $0x0,%eax
    132f:	48 b9 5f 1d 00 00 00 	movabs $0x1d5f,%rcx
    1336:	00 00 00 
    1339:	ff d1                	call   *%rcx

  server_pid = fork();
    133b:	48 b8 41 1a 00 00 00 	movabs $0x1a41,%rax
    1342:	00 00 00 
    1345:	ff d0                	call   *%rax
    1347:	89 45 f0             	mov    %eax,-0x10(%rbp)
  if(server_pid < 0){
    134a:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    134e:	79 2f                	jns    137f <main+0x15e>
    printf(1, "fstest: fork failed\n");
    1350:	48 b8 b7 24 00 00 00 	movabs $0x24b7,%rax
    1357:	00 00 00 
    135a:	48 89 c6             	mov    %rax,%rsi
    135d:	bf 01 00 00 00       	mov    $0x1,%edi
    1362:	b8 00 00 00 00       	mov    $0x0,%eax
    1367:	48 ba 5f 1d 00 00 00 	movabs $0x1d5f,%rdx
    136e:	00 00 00 
    1371:	ff d2                	call   *%rdx
    exit();
    1373:	48 b8 4e 1a 00 00 00 	movabs $0x1a4e,%rax
    137a:	00 00 00 
    137d:	ff d0                	call   *%rax
  }

  if(server_pid == 0){
    137f:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    1383:	75 6e                	jne    13f3 <main+0x1d2>
    char *argv[] = { "fsserver", 0 };
    1385:	48 b8 cc 24 00 00 00 	movabs $0x24cc,%rax
    138c:	00 00 00 
    138f:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
    1396:	48 c7 85 38 ff ff ff 	movq   $0x0,-0xc8(%rbp)
    139d:	00 00 00 00 
    exec("fsserver", argv);
    13a1:	48 8d 85 30 ff ff ff 	lea    -0xd0(%rbp),%rax
    13a8:	48 89 c6             	mov    %rax,%rsi
    13ab:	48 b8 cc 24 00 00 00 	movabs $0x24cc,%rax
    13b2:	00 00 00 
    13b5:	48 89 c7             	mov    %rax,%rdi
    13b8:	48 b8 a9 1a 00 00 00 	movabs $0x1aa9,%rax
    13bf:	00 00 00 
    13c2:	ff d0                	call   *%rax
    printf(1, "fstest: exec fsserver failed\n");
    13c4:	48 b8 d5 24 00 00 00 	movabs $0x24d5,%rax
    13cb:	00 00 00 
    13ce:	48 89 c6             	mov    %rax,%rsi
    13d1:	bf 01 00 00 00       	mov    $0x1,%edi
    13d6:	b8 00 00 00 00       	mov    $0x0,%eax
    13db:	48 ba 5f 1d 00 00 00 	movabs $0x1d5f,%rdx
    13e2:	00 00 00 
    13e5:	ff d2                	call   *%rdx
    exit();
    13e7:	48 b8 4e 1a 00 00 00 	movabs $0x1a4e,%rax
    13ee:	00 00 00 
    13f1:	ff d0                	call   *%rax
  }

  sleep(10);
    13f3:	bf 0a 00 00 00       	mov    $0xa,%edi
    13f8:	48 b8 38 1b 00 00 00 	movabs $0x1b38,%rax
    13ff:	00 00 00 
    1402:	ff d0                	call   *%rax

  start = uptime();
    1404:	48 b8 45 1b 00 00 00 	movabs $0x1b45,%rax
    140b:	00 00 00 
    140e:	ff d0                	call   *%rax
    1410:	89 45 f8             	mov    %eax,-0x8(%rbp)
  for(i = 0; i < 20; i++){
    1413:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    141a:	eb 6f                	jmp    148b <main+0x26a>
    fd = open("ipcbench.txt", O_CREATE | O_RDWR);
    141c:	be 02 02 00 00       	mov    $0x202,%esi
    1421:	48 b8 f3 24 00 00 00 	movabs $0x24f3,%rax
    1428:	00 00 00 
    142b:	48 89 c7             	mov    %rax,%rdi
    142e:	48 b8 b6 1a 00 00 00 	movabs $0x1ab6,%rax
    1435:	00 00 00 
    1438:	ff d0                	call   *%rax
    143a:	89 45 ec             	mov    %eax,-0x14(%rbp)
    if(fd >= 0){
    143d:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
    1441:	78 44                	js     1487 <main+0x266>
      write(fd, msg, strlen(msg));
    1443:	48 8d 85 40 ff ff ff 	lea    -0xc0(%rbp),%rax
    144a:	48 89 c7             	mov    %rax,%rdi
    144d:	48 b8 e3 17 00 00 00 	movabs $0x17e3,%rax
    1454:	00 00 00 
    1457:	ff d0                	call   *%rax
    1459:	89 c2                	mov    %eax,%edx
    145b:	48 8d 8d 40 ff ff ff 	lea    -0xc0(%rbp),%rcx
    1462:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1465:	48 89 ce             	mov    %rcx,%rsi
    1468:	89 c7                	mov    %eax,%edi
    146a:	48 b8 82 1a 00 00 00 	movabs $0x1a82,%rax
    1471:	00 00 00 
    1474:	ff d0                	call   *%rax
      close(fd);
    1476:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1479:	89 c7                	mov    %eax,%edi
    147b:	48 b8 8f 1a 00 00 00 	movabs $0x1a8f,%rax
    1482:	00 00 00 
    1485:	ff d0                	call   *%rax
  for(i = 0; i < 20; i++){
    1487:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    148b:	83 7d fc 13          	cmpl   $0x13,-0x4(%rbp)
    148f:	7e 8b                	jle    141c <main+0x1fb>
    }
  }
  end = uptime();
    1491:	48 b8 45 1b 00 00 00 	movabs $0x1b45,%rax
    1498:	00 00 00 
    149b:	ff d0                	call   *%rax
    149d:	89 45 f4             	mov    %eax,-0xc(%rbp)
  printf(1, "fstest: routed fsserver loop took %d ticks\n", end - start);
    14a0:	8b 45 f4             	mov    -0xc(%rbp),%eax
    14a3:	2b 45 f8             	sub    -0x8(%rbp),%eax
    14a6:	89 c2                	mov    %eax,%edx
    14a8:	48 b8 00 25 00 00 00 	movabs $0x2500,%rax
    14af:	00 00 00 
    14b2:	48 89 c6             	mov    %rax,%rsi
    14b5:	bf 01 00 00 00       	mov    $0x1,%edi
    14ba:	b8 00 00 00 00       	mov    $0x0,%eax
    14bf:	48 b9 5f 1d 00 00 00 	movabs $0x1d5f,%rcx
    14c6:	00 00 00 
    14c9:	ff d1                	call   *%rcx

  fd = open("ipcfs.txt", O_CREATE | O_RDWR);
    14cb:	be 02 02 00 00       	mov    $0x202,%esi
    14d0:	48 b8 2c 25 00 00 00 	movabs $0x252c,%rax
    14d7:	00 00 00 
    14da:	48 89 c7             	mov    %rax,%rdi
    14dd:	48 b8 b6 1a 00 00 00 	movabs $0x1ab6,%rax
    14e4:	00 00 00 
    14e7:	ff d0                	call   *%rax
    14e9:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if(fd < 0){
    14ec:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
    14f0:	79 4c                	jns    153e <main+0x31d>
    printf(1, "fstest: routed open failed\n");
    14f2:	48 b8 36 25 00 00 00 	movabs $0x2536,%rax
    14f9:	00 00 00 
    14fc:	48 89 c6             	mov    %rax,%rsi
    14ff:	bf 01 00 00 00       	mov    $0x1,%edi
    1504:	b8 00 00 00 00       	mov    $0x0,%eax
    1509:	48 ba 5f 1d 00 00 00 	movabs $0x1d5f,%rdx
    1510:	00 00 00 
    1513:	ff d2                	call   *%rdx
    kill(server_pid);
    1515:	8b 45 f0             	mov    -0x10(%rbp),%eax
    1518:	89 c7                	mov    %eax,%edi
    151a:	48 b8 9c 1a 00 00 00 	movabs $0x1a9c,%rax
    1521:	00 00 00 
    1524:	ff d0                	call   *%rax
    wait();
    1526:	48 b8 5b 1a 00 00 00 	movabs $0x1a5b,%rax
    152d:	00 00 00 
    1530:	ff d0                	call   *%rax
    exit();
    1532:	48 b8 4e 1a 00 00 00 	movabs $0x1a4e,%rax
    1539:	00 00 00 
    153c:	ff d0                	call   *%rax
  }

  if(write(fd, msg, strlen(msg)) < 0){
    153e:	48 8d 85 40 ff ff ff 	lea    -0xc0(%rbp),%rax
    1545:	48 89 c7             	mov    %rax,%rdi
    1548:	48 b8 e3 17 00 00 00 	movabs $0x17e3,%rax
    154f:	00 00 00 
    1552:	ff d0                	call   *%rax
    1554:	89 c2                	mov    %eax,%edx
    1556:	48 8d 8d 40 ff ff ff 	lea    -0xc0(%rbp),%rcx
    155d:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1560:	48 89 ce             	mov    %rcx,%rsi
    1563:	89 c7                	mov    %eax,%edi
    1565:	48 b8 82 1a 00 00 00 	movabs $0x1a82,%rax
    156c:	00 00 00 
    156f:	ff d0                	call   *%rax
    1571:	85 c0                	test   %eax,%eax
    1573:	79 23                	jns    1598 <main+0x377>
    printf(1, "fstest: routed write failed\n");
    1575:	48 b8 52 25 00 00 00 	movabs $0x2552,%rax
    157c:	00 00 00 
    157f:	48 89 c6             	mov    %rax,%rsi
    1582:	bf 01 00 00 00       	mov    $0x1,%edi
    1587:	b8 00 00 00 00       	mov    $0x0,%eax
    158c:	48 ba 5f 1d 00 00 00 	movabs $0x1d5f,%rdx
    1593:	00 00 00 
    1596:	ff d2                	call   *%rdx
  }
  if(close(fd) < 0){
    1598:	8b 45 ec             	mov    -0x14(%rbp),%eax
    159b:	89 c7                	mov    %eax,%edi
    159d:	48 b8 8f 1a 00 00 00 	movabs $0x1a8f,%rax
    15a4:	00 00 00 
    15a7:	ff d0                	call   *%rax
    15a9:	85 c0                	test   %eax,%eax
    15ab:	79 23                	jns    15d0 <main+0x3af>
    printf(1, "fstest: routed close failed\n");
    15ad:	48 b8 6f 25 00 00 00 	movabs $0x256f,%rax
    15b4:	00 00 00 
    15b7:	48 89 c6             	mov    %rax,%rsi
    15ba:	bf 01 00 00 00       	mov    $0x1,%edi
    15bf:	b8 00 00 00 00       	mov    $0x0,%eax
    15c4:	48 ba 5f 1d 00 00 00 	movabs $0x1d5f,%rdx
    15cb:	00 00 00 
    15ce:	ff d2                	call   *%rdx
  }

  fd = open("ipcfs.txt", O_RDONLY);
    15d0:	be 00 00 00 00       	mov    $0x0,%esi
    15d5:	48 b8 2c 25 00 00 00 	movabs $0x252c,%rax
    15dc:	00 00 00 
    15df:	48 89 c7             	mov    %rax,%rdi
    15e2:	48 b8 b6 1a 00 00 00 	movabs $0x1ab6,%rax
    15e9:	00 00 00 
    15ec:	ff d0                	call   *%rax
    15ee:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if(fd < 0){
    15f1:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
    15f5:	79 4c                	jns    1643 <main+0x422>
    printf(1, "fstest: routed reopen failed\n");
    15f7:	48 b8 8c 25 00 00 00 	movabs $0x258c,%rax
    15fe:	00 00 00 
    1601:	48 89 c6             	mov    %rax,%rsi
    1604:	bf 01 00 00 00       	mov    $0x1,%edi
    1609:	b8 00 00 00 00       	mov    $0x0,%eax
    160e:	48 ba 5f 1d 00 00 00 	movabs $0x1d5f,%rdx
    1615:	00 00 00 
    1618:	ff d2                	call   *%rdx
    fs_shutdown_remote(server_pid);
    161a:	8b 45 f0             	mov    -0x10(%rbp),%eax
    161d:	89 c7                	mov    %eax,%edi
    161f:	48 b8 c1 11 00 00 00 	movabs $0x11c1,%rax
    1626:	00 00 00 
    1629:	ff d0                	call   *%rax
    wait();
    162b:	48 b8 5b 1a 00 00 00 	movabs $0x1a5b,%rax
    1632:	00 00 00 
    1635:	ff d0                	call   *%rax
    exit();
    1637:	48 b8 4e 1a 00 00 00 	movabs $0x1a4e,%rax
    163e:	00 00 00 
    1641:	ff d0                	call   *%rax
  }

  n = read(fd, buf, IPC_DATA_SIZE);
    1643:	48 8d 8d 60 ff ff ff 	lea    -0xa0(%rbp),%rcx
    164a:	8b 45 ec             	mov    -0x14(%rbp),%eax
    164d:	ba 80 00 00 00       	mov    $0x80,%edx
    1652:	48 89 ce             	mov    %rcx,%rsi
    1655:	89 c7                	mov    %eax,%edi
    1657:	48 b8 75 1a 00 00 00 	movabs $0x1a75,%rax
    165e:	00 00 00 
    1661:	ff d0                	call   *%rax
    1663:	89 45 e8             	mov    %eax,-0x18(%rbp)
  if(n < 0){
    1666:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
    166a:	79 25                	jns    1691 <main+0x470>
    printf(1, "fstest: routed read failed\n");
    166c:	48 b8 aa 25 00 00 00 	movabs $0x25aa,%rax
    1673:	00 00 00 
    1676:	48 89 c6             	mov    %rax,%rsi
    1679:	bf 01 00 00 00       	mov    $0x1,%edi
    167e:	b8 00 00 00 00       	mov    $0x0,%eax
    1683:	48 ba 5f 1d 00 00 00 	movabs $0x1d5f,%rdx
    168a:	00 00 00 
    168d:	ff d2                	call   *%rdx
    168f:	eb 40                	jmp    16d1 <main+0x4b0>
  } else {
    buf[n] = 0;
    1691:	8b 45 e8             	mov    -0x18(%rbp),%eax
    1694:	48 98                	cltq
    1696:	c6 84 05 60 ff ff ff 	movb   $0x0,-0xa0(%rbp,%rax,1)
    169d:	00 
    printf(1, "fstest: read %d bytes: %s", n, buf);
    169e:	48 8d 95 60 ff ff ff 	lea    -0xa0(%rbp),%rdx
    16a5:	8b 45 e8             	mov    -0x18(%rbp),%eax
    16a8:	48 89 d1             	mov    %rdx,%rcx
    16ab:	89 c2                	mov    %eax,%edx
    16ad:	48 b8 c6 25 00 00 00 	movabs $0x25c6,%rax
    16b4:	00 00 00 
    16b7:	48 89 c6             	mov    %rax,%rsi
    16ba:	bf 01 00 00 00       	mov    $0x1,%edi
    16bf:	b8 00 00 00 00       	mov    $0x0,%eax
    16c4:	49 b8 5f 1d 00 00 00 	movabs $0x1d5f,%r8
    16cb:	00 00 00 
    16ce:	41 ff d0             	call   *%r8
  }
  close(fd);
    16d1:	8b 45 ec             	mov    -0x14(%rbp),%eax
    16d4:	89 c7                	mov    %eax,%edi
    16d6:	48 b8 8f 1a 00 00 00 	movabs $0x1a8f,%rax
    16dd:	00 00 00 
    16e0:	ff d0                	call   *%rax

  fs_shutdown_remote(server_pid);
    16e2:	8b 45 f0             	mov    -0x10(%rbp),%eax
    16e5:	89 c7                	mov    %eax,%edi
    16e7:	48 b8 c1 11 00 00 00 	movabs $0x11c1,%rax
    16ee:	00 00 00 
    16f1:	ff d0                	call   *%rax
  wait();
    16f3:	48 b8 5b 1a 00 00 00 	movabs $0x1a5b,%rax
    16fa:	00 00 00 
    16fd:	ff d0                	call   *%rax
  exit();
    16ff:	48 b8 4e 1a 00 00 00 	movabs $0x1a4e,%rax
    1706:	00 00 00 
    1709:	ff d0                	call   *%rax

000000000000170b <stosb>:
  stosb(dst, c, n);
  return dst;
}

char*
strchr(const char *s, char c)
    170b:	f3 0f 1e fa          	endbr64
    170f:	55                   	push   %rbp
    1710:	48 89 e5             	mov    %rsp,%rbp
    1713:	48 83 ec 10          	sub    $0x10,%rsp
    1717:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    171b:	89 75 f4             	mov    %esi,-0xc(%rbp)
    171e:	89 55 f0             	mov    %edx,-0x10(%rbp)
{
    1721:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1725:	8b 55 f0             	mov    -0x10(%rbp),%edx
    1728:	8b 45 f4             	mov    -0xc(%rbp),%eax
    172b:	48 89 ce             	mov    %rcx,%rsi
    172e:	48 89 f7             	mov    %rsi,%rdi
    1731:	89 d1                	mov    %edx,%ecx
    1733:	fc                   	cld
    1734:	f3 aa                	rep stos %al,%es:(%rdi)
    1736:	89 ca                	mov    %ecx,%edx
    1738:	48 89 fe             	mov    %rdi,%rsi
    173b:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    173f:	89 55 f0             	mov    %edx,-0x10(%rbp)
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
    1742:	90                   	nop
    1743:	c9                   	leave
    1744:	c3                   	ret

0000000000001745 <strcpy>:
{
    1745:	f3 0f 1e fa          	endbr64
    1749:	55                   	push   %rbp
    174a:	48 89 e5             	mov    %rsp,%rbp
    174d:	48 83 ec 20          	sub    $0x20,%rsp
    1751:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1755:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  os = s;
    1759:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    175d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    1761:	90                   	nop
    1762:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1766:	48 8d 42 01          	lea    0x1(%rdx),%rax
    176a:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    176e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1772:	48 8d 48 01          	lea    0x1(%rax),%rcx
    1776:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    177a:	0f b6 12             	movzbl (%rdx),%edx
    177d:	88 10                	mov    %dl,(%rax)
    177f:	0f b6 00             	movzbl (%rax),%eax
    1782:	84 c0                	test   %al,%al
    1784:	75 dc                	jne    1762 <strcpy+0x1d>
  return os;
    1786:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    178a:	c9                   	leave
    178b:	c3                   	ret

000000000000178c <strcmp>:
{
    178c:	f3 0f 1e fa          	endbr64
    1790:	55                   	push   %rbp
    1791:	48 89 e5             	mov    %rsp,%rbp
    1794:	48 83 ec 10          	sub    $0x10,%rsp
    1798:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    179c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    17a0:	eb 0a                	jmp    17ac <strcmp+0x20>
    p++, q++;
    17a2:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    17a7:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    17ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    17b0:	0f b6 00             	movzbl (%rax),%eax
    17b3:	84 c0                	test   %al,%al
    17b5:	74 12                	je     17c9 <strcmp+0x3d>
    17b7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    17bb:	0f b6 10             	movzbl (%rax),%edx
    17be:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    17c2:	0f b6 00             	movzbl (%rax),%eax
    17c5:	38 c2                	cmp    %al,%dl
    17c7:	74 d9                	je     17a2 <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
    17c9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    17cd:	0f b6 00             	movzbl (%rax),%eax
    17d0:	0f b6 d0             	movzbl %al,%edx
    17d3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    17d7:	0f b6 00             	movzbl (%rax),%eax
    17da:	0f b6 c0             	movzbl %al,%eax
    17dd:	29 c2                	sub    %eax,%edx
    17df:	89 d0                	mov    %edx,%eax
}
    17e1:	c9                   	leave
    17e2:	c3                   	ret

00000000000017e3 <strlen>:
{
    17e3:	f3 0f 1e fa          	endbr64
    17e7:	55                   	push   %rbp
    17e8:	48 89 e5             	mov    %rsp,%rbp
    17eb:	48 83 ec 18          	sub    $0x18,%rsp
    17ef:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  for(n = 0; s[n]; n++)
    17f3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    17fa:	eb 04                	jmp    1800 <strlen+0x1d>
    17fc:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1800:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1803:	48 63 d0             	movslq %eax,%rdx
    1806:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    180a:	48 01 d0             	add    %rdx,%rax
    180d:	0f b6 00             	movzbl (%rax),%eax
    1810:	84 c0                	test   %al,%al
    1812:	75 e8                	jne    17fc <strlen+0x19>
  return n;
    1814:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    1817:	c9                   	leave
    1818:	c3                   	ret

0000000000001819 <memset>:
{
    1819:	f3 0f 1e fa          	endbr64
    181d:	55                   	push   %rbp
    181e:	48 89 e5             	mov    %rsp,%rbp
    1821:	48 83 ec 10          	sub    $0x10,%rsp
    1825:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1829:	89 75 f4             	mov    %esi,-0xc(%rbp)
    182c:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    182f:	8b 55 f0             	mov    -0x10(%rbp),%edx
    1832:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    1835:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1839:	89 ce                	mov    %ecx,%esi
    183b:	48 89 c7             	mov    %rax,%rdi
    183e:	48 b8 0b 17 00 00 00 	movabs $0x170b,%rax
    1845:	00 00 00 
    1848:	ff d0                	call   *%rax
  return dst;
    184a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    184e:	c9                   	leave
    184f:	c3                   	ret

0000000000001850 <strchr>:
{
    1850:	f3 0f 1e fa          	endbr64
    1854:	55                   	push   %rbp
    1855:	48 89 e5             	mov    %rsp,%rbp
    1858:	48 83 ec 10          	sub    $0x10,%rsp
    185c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1860:	89 f0                	mov    %esi,%eax
    1862:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    1865:	eb 17                	jmp    187e <strchr+0x2e>
    if(*s == c)
    1867:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    186b:	0f b6 00             	movzbl (%rax),%eax
    186e:	38 45 f4             	cmp    %al,-0xc(%rbp)
    1871:	75 06                	jne    1879 <strchr+0x29>
      return (char*)s;
    1873:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1877:	eb 15                	jmp    188e <strchr+0x3e>
  for(; *s; s++)
    1879:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    187e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1882:	0f b6 00             	movzbl (%rax),%eax
    1885:	84 c0                	test   %al,%al
    1887:	75 de                	jne    1867 <strchr+0x17>
  return 0;
    1889:	b8 00 00 00 00       	mov    $0x0,%eax
}
    188e:	c9                   	leave
    188f:	c3                   	ret

0000000000001890 <gets>:

char*
gets(char *buf, int max)
{
    1890:	f3 0f 1e fa          	endbr64
    1894:	55                   	push   %rbp
    1895:	48 89 e5             	mov    %rsp,%rbp
    1898:	48 83 ec 20          	sub    $0x20,%rsp
    189c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    18a0:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    18a3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    18aa:	eb 4f                	jmp    18fb <gets+0x6b>
    cc = read(0, &c, 1);
    18ac:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    18b0:	ba 01 00 00 00       	mov    $0x1,%edx
    18b5:	48 89 c6             	mov    %rax,%rsi
    18b8:	bf 00 00 00 00       	mov    $0x0,%edi
    18bd:	48 b8 75 1a 00 00 00 	movabs $0x1a75,%rax
    18c4:	00 00 00 
    18c7:	ff d0                	call   *%rax
    18c9:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    18cc:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    18d0:	7e 36                	jle    1908 <gets+0x78>
      break;
    buf[i++] = c;
    18d2:	8b 45 fc             	mov    -0x4(%rbp),%eax
    18d5:	8d 50 01             	lea    0x1(%rax),%edx
    18d8:	89 55 fc             	mov    %edx,-0x4(%rbp)
    18db:	48 63 d0             	movslq %eax,%rdx
    18de:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    18e2:	48 01 c2             	add    %rax,%rdx
    18e5:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    18e9:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    18eb:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    18ef:	3c 0a                	cmp    $0xa,%al
    18f1:	74 16                	je     1909 <gets+0x79>
    18f3:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    18f7:	3c 0d                	cmp    $0xd,%al
    18f9:	74 0e                	je     1909 <gets+0x79>
  for(i=0; i+1 < max; ){
    18fb:	8b 45 fc             	mov    -0x4(%rbp),%eax
    18fe:	83 c0 01             	add    $0x1,%eax
    1901:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    1904:	7f a6                	jg     18ac <gets+0x1c>
    1906:	eb 01                	jmp    1909 <gets+0x79>
      break;
    1908:	90                   	nop
      break;
  }
  buf[i] = '\0';
    1909:	8b 45 fc             	mov    -0x4(%rbp),%eax
    190c:	48 63 d0             	movslq %eax,%rdx
    190f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1913:	48 01 d0             	add    %rdx,%rax
    1916:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    1919:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    191d:	c9                   	leave
    191e:	c3                   	ret

000000000000191f <stat>:

int
stat(char *n, struct stat *st)
{
    191f:	f3 0f 1e fa          	endbr64
    1923:	55                   	push   %rbp
    1924:	48 89 e5             	mov    %rsp,%rbp
    1927:	48 83 ec 20          	sub    $0x20,%rsp
    192b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    192f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1933:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1937:	be 00 00 00 00       	mov    $0x0,%esi
    193c:	48 89 c7             	mov    %rax,%rdi
    193f:	48 b8 b6 1a 00 00 00 	movabs $0x1ab6,%rax
    1946:	00 00 00 
    1949:	ff d0                	call   *%rax
    194b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    194e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1952:	79 07                	jns    195b <stat+0x3c>
    return -1;
    1954:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1959:	eb 2f                	jmp    198a <stat+0x6b>
  r = fstat(fd, st);
    195b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    195f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1962:	48 89 d6             	mov    %rdx,%rsi
    1965:	89 c7                	mov    %eax,%edi
    1967:	48 b8 dd 1a 00 00 00 	movabs $0x1add,%rax
    196e:	00 00 00 
    1971:	ff d0                	call   *%rax
    1973:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    1976:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1979:	89 c7                	mov    %eax,%edi
    197b:	48 b8 8f 1a 00 00 00 	movabs $0x1a8f,%rax
    1982:	00 00 00 
    1985:	ff d0                	call   *%rax
  return r;
    1987:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    198a:	c9                   	leave
    198b:	c3                   	ret

000000000000198c <atoi>:

int
atoi(const char *s)
{
    198c:	f3 0f 1e fa          	endbr64
    1990:	55                   	push   %rbp
    1991:	48 89 e5             	mov    %rsp,%rbp
    1994:	48 83 ec 18          	sub    $0x18,%rsp
    1998:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    199c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    19a3:	eb 28                	jmp    19cd <atoi+0x41>
    n = n*10 + *s++ - '0';
    19a5:	8b 55 fc             	mov    -0x4(%rbp),%edx
    19a8:	89 d0                	mov    %edx,%eax
    19aa:	c1 e0 02             	shl    $0x2,%eax
    19ad:	01 d0                	add    %edx,%eax
    19af:	01 c0                	add    %eax,%eax
    19b1:	89 c1                	mov    %eax,%ecx
    19b3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    19b7:	48 8d 50 01          	lea    0x1(%rax),%rdx
    19bb:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    19bf:	0f b6 00             	movzbl (%rax),%eax
    19c2:	0f be c0             	movsbl %al,%eax
    19c5:	01 c8                	add    %ecx,%eax
    19c7:	83 e8 30             	sub    $0x30,%eax
    19ca:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    19cd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    19d1:	0f b6 00             	movzbl (%rax),%eax
    19d4:	3c 2f                	cmp    $0x2f,%al
    19d6:	7e 0b                	jle    19e3 <atoi+0x57>
    19d8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    19dc:	0f b6 00             	movzbl (%rax),%eax
    19df:	3c 39                	cmp    $0x39,%al
    19e1:	7e c2                	jle    19a5 <atoi+0x19>
  return n;
    19e3:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    19e6:	c9                   	leave
    19e7:	c3                   	ret

00000000000019e8 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    19e8:	f3 0f 1e fa          	endbr64
    19ec:	55                   	push   %rbp
    19ed:	48 89 e5             	mov    %rsp,%rbp
    19f0:	48 83 ec 28          	sub    $0x28,%rsp
    19f4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    19f8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    19fc:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    19ff:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1a03:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    1a07:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1a0b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    1a0f:	eb 1d                	jmp    1a2e <memmove+0x46>
    *dst++ = *src++;
    1a11:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1a15:	48 8d 42 01          	lea    0x1(%rdx),%rax
    1a19:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1a1d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1a21:	48 8d 48 01          	lea    0x1(%rax),%rcx
    1a25:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    1a29:	0f b6 12             	movzbl (%rdx),%edx
    1a2c:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    1a2e:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1a31:	8d 50 ff             	lea    -0x1(%rax),%edx
    1a34:	89 55 dc             	mov    %edx,-0x24(%rbp)
    1a37:	85 c0                	test   %eax,%eax
    1a39:	7f d6                	jg     1a11 <memmove+0x29>
  return vdst;
    1a3b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    1a3f:	c9                   	leave
    1a40:	c3                   	ret

0000000000001a41 <fork>:
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    1a41:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    1a48:	49 89 ca             	mov    %rcx,%r10
    1a4b:	0f 05                	syscall
    1a4d:	c3                   	ret

0000000000001a4e <exit>:
SYSCALL(exit)
    1a4e:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    1a55:	49 89 ca             	mov    %rcx,%r10
    1a58:	0f 05                	syscall
    1a5a:	c3                   	ret

0000000000001a5b <wait>:
SYSCALL(wait)
    1a5b:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    1a62:	49 89 ca             	mov    %rcx,%r10
    1a65:	0f 05                	syscall
    1a67:	c3                   	ret

0000000000001a68 <pipe>:
SYSCALL(pipe)
    1a68:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    1a6f:	49 89 ca             	mov    %rcx,%r10
    1a72:	0f 05                	syscall
    1a74:	c3                   	ret

0000000000001a75 <read>:
SYSCALL(read)
    1a75:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    1a7c:	49 89 ca             	mov    %rcx,%r10
    1a7f:	0f 05                	syscall
    1a81:	c3                   	ret

0000000000001a82 <write>:
SYSCALL(write)
    1a82:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    1a89:	49 89 ca             	mov    %rcx,%r10
    1a8c:	0f 05                	syscall
    1a8e:	c3                   	ret

0000000000001a8f <close>:
SYSCALL(close)
    1a8f:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    1a96:	49 89 ca             	mov    %rcx,%r10
    1a99:	0f 05                	syscall
    1a9b:	c3                   	ret

0000000000001a9c <kill>:
SYSCALL(kill)
    1a9c:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    1aa3:	49 89 ca             	mov    %rcx,%r10
    1aa6:	0f 05                	syscall
    1aa8:	c3                   	ret

0000000000001aa9 <exec>:
SYSCALL(exec)
    1aa9:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    1ab0:	49 89 ca             	mov    %rcx,%r10
    1ab3:	0f 05                	syscall
    1ab5:	c3                   	ret

0000000000001ab6 <open>:
SYSCALL(open)
    1ab6:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    1abd:	49 89 ca             	mov    %rcx,%r10
    1ac0:	0f 05                	syscall
    1ac2:	c3                   	ret

0000000000001ac3 <mknod>:
SYSCALL(mknod)
    1ac3:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    1aca:	49 89 ca             	mov    %rcx,%r10
    1acd:	0f 05                	syscall
    1acf:	c3                   	ret

0000000000001ad0 <unlink>:
SYSCALL(unlink)
    1ad0:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    1ad7:	49 89 ca             	mov    %rcx,%r10
    1ada:	0f 05                	syscall
    1adc:	c3                   	ret

0000000000001add <fstat>:
SYSCALL(fstat)
    1add:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    1ae4:	49 89 ca             	mov    %rcx,%r10
    1ae7:	0f 05                	syscall
    1ae9:	c3                   	ret

0000000000001aea <link>:
SYSCALL(link)
    1aea:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    1af1:	49 89 ca             	mov    %rcx,%r10
    1af4:	0f 05                	syscall
    1af6:	c3                   	ret

0000000000001af7 <mkdir>:
SYSCALL(mkdir)
    1af7:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    1afe:	49 89 ca             	mov    %rcx,%r10
    1b01:	0f 05                	syscall
    1b03:	c3                   	ret

0000000000001b04 <chdir>:
SYSCALL(chdir)
    1b04:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    1b0b:	49 89 ca             	mov    %rcx,%r10
    1b0e:	0f 05                	syscall
    1b10:	c3                   	ret

0000000000001b11 <dup>:
SYSCALL(dup)
    1b11:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    1b18:	49 89 ca             	mov    %rcx,%r10
    1b1b:	0f 05                	syscall
    1b1d:	c3                   	ret

0000000000001b1e <getpid>:
SYSCALL(getpid)
    1b1e:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    1b25:	49 89 ca             	mov    %rcx,%r10
    1b28:	0f 05                	syscall
    1b2a:	c3                   	ret

0000000000001b2b <sbrk>:
SYSCALL(sbrk)
    1b2b:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    1b32:	49 89 ca             	mov    %rcx,%r10
    1b35:	0f 05                	syscall
    1b37:	c3                   	ret

0000000000001b38 <sleep>:
SYSCALL(sleep)
    1b38:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    1b3f:	49 89 ca             	mov    %rcx,%r10
    1b42:	0f 05                	syscall
    1b44:	c3                   	ret

0000000000001b45 <uptime>:
SYSCALL(uptime)
    1b45:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    1b4c:	49 89 ca             	mov    %rcx,%r10
    1b4f:	0f 05                	syscall
    1b51:	c3                   	ret

0000000000001b52 <send>:
SYSCALL(send)
    1b52:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    1b59:	49 89 ca             	mov    %rcx,%r10
    1b5c:	0f 05                	syscall
    1b5e:	c3                   	ret

0000000000001b5f <recv>:
SYSCALL(recv)
    1b5f:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    1b66:	49 89 ca             	mov    %rcx,%r10
    1b69:	0f 05                	syscall
    1b6b:	c3                   	ret

0000000000001b6c <register_fsserver>:
SYSCALL(register_fsserver)
    1b6c:	48 c7 c0 18 00 00 00 	mov    $0x18,%rax
    1b73:	49 89 ca             	mov    %rcx,%r10
    1b76:	0f 05                	syscall
    1b78:	c3                   	ret

0000000000001b79 <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    1b79:	f3 0f 1e fa          	endbr64
    1b7d:	55                   	push   %rbp
    1b7e:	48 89 e5             	mov    %rsp,%rbp
    1b81:	48 83 ec 10          	sub    $0x10,%rsp
    1b85:	89 7d fc             	mov    %edi,-0x4(%rbp)
    1b88:	89 f0                	mov    %esi,%eax
    1b8a:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    1b8d:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    1b91:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1b94:	ba 01 00 00 00       	mov    $0x1,%edx
    1b99:	48 89 ce             	mov    %rcx,%rsi
    1b9c:	89 c7                	mov    %eax,%edi
    1b9e:	48 b8 82 1a 00 00 00 	movabs $0x1a82,%rax
    1ba5:	00 00 00 
    1ba8:	ff d0                	call   *%rax
}
    1baa:	90                   	nop
    1bab:	c9                   	leave
    1bac:	c3                   	ret

0000000000001bad <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    1bad:	f3 0f 1e fa          	endbr64
    1bb1:	55                   	push   %rbp
    1bb2:	48 89 e5             	mov    %rsp,%rbp
    1bb5:	48 83 ec 20          	sub    $0x20,%rsp
    1bb9:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1bbc:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1bc0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1bc7:	eb 35                	jmp    1bfe <print_x64+0x51>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    1bc9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1bcd:	48 c1 e8 3c          	shr    $0x3c,%rax
    1bd1:	48 ba a0 26 00 00 00 	movabs $0x26a0,%rdx
    1bd8:	00 00 00 
    1bdb:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1bdf:	0f be d0             	movsbl %al,%edx
    1be2:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1be5:	89 d6                	mov    %edx,%esi
    1be7:	89 c7                	mov    %eax,%edi
    1be9:	48 b8 79 1b 00 00 00 	movabs $0x1b79,%rax
    1bf0:	00 00 00 
    1bf3:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1bf5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1bf9:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    1bfe:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1c01:	83 f8 0f             	cmp    $0xf,%eax
    1c04:	76 c3                	jbe    1bc9 <print_x64+0x1c>
}
    1c06:	90                   	nop
    1c07:	90                   	nop
    1c08:	c9                   	leave
    1c09:	c3                   	ret

0000000000001c0a <print_x32>:

  static void
print_x32(int fd, uint x)
{
    1c0a:	f3 0f 1e fa          	endbr64
    1c0e:	55                   	push   %rbp
    1c0f:	48 89 e5             	mov    %rsp,%rbp
    1c12:	48 83 ec 20          	sub    $0x20,%rsp
    1c16:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1c19:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1c1c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1c23:	eb 36                	jmp    1c5b <print_x32+0x51>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    1c25:	8b 45 e8             	mov    -0x18(%rbp),%eax
    1c28:	c1 e8 1c             	shr    $0x1c,%eax
    1c2b:	89 c2                	mov    %eax,%edx
    1c2d:	48 b8 a0 26 00 00 00 	movabs $0x26a0,%rax
    1c34:	00 00 00 
    1c37:	89 d2                	mov    %edx,%edx
    1c39:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    1c3d:	0f be d0             	movsbl %al,%edx
    1c40:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1c43:	89 d6                	mov    %edx,%esi
    1c45:	89 c7                	mov    %eax,%edi
    1c47:	48 b8 79 1b 00 00 00 	movabs $0x1b79,%rax
    1c4e:	00 00 00 
    1c51:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1c53:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1c57:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    1c5b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1c5e:	83 f8 07             	cmp    $0x7,%eax
    1c61:	76 c2                	jbe    1c25 <print_x32+0x1b>
}
    1c63:	90                   	nop
    1c64:	90                   	nop
    1c65:	c9                   	leave
    1c66:	c3                   	ret

0000000000001c67 <print_d>:

  static void
print_d(int fd, int v)
{
    1c67:	f3 0f 1e fa          	endbr64
    1c6b:	55                   	push   %rbp
    1c6c:	48 89 e5             	mov    %rsp,%rbp
    1c6f:	48 83 ec 30          	sub    $0x30,%rsp
    1c73:	89 7d dc             	mov    %edi,-0x24(%rbp)
    1c76:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    1c79:	8b 45 d8             	mov    -0x28(%rbp),%eax
    1c7c:	48 98                	cltq
    1c7e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    1c82:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1c86:	79 04                	jns    1c8c <print_d+0x25>
    x = -x;
    1c88:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    1c8c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    1c93:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1c97:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1c9e:	66 66 66 
    1ca1:	48 89 c8             	mov    %rcx,%rax
    1ca4:	48 f7 ea             	imul   %rdx
    1ca7:	48 c1 fa 02          	sar    $0x2,%rdx
    1cab:	48 89 c8             	mov    %rcx,%rax
    1cae:	48 c1 f8 3f          	sar    $0x3f,%rax
    1cb2:	48 29 c2             	sub    %rax,%rdx
    1cb5:	48 89 d0             	mov    %rdx,%rax
    1cb8:	48 c1 e0 02          	shl    $0x2,%rax
    1cbc:	48 01 d0             	add    %rdx,%rax
    1cbf:	48 01 c0             	add    %rax,%rax
    1cc2:	48 29 c1             	sub    %rax,%rcx
    1cc5:	48 89 ca             	mov    %rcx,%rdx
    1cc8:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1ccb:	8d 48 01             	lea    0x1(%rax),%ecx
    1cce:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    1cd1:	48 b9 a0 26 00 00 00 	movabs $0x26a0,%rcx
    1cd8:	00 00 00 
    1cdb:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    1cdf:	48 98                	cltq
    1ce1:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    1ce5:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1ce9:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1cf0:	66 66 66 
    1cf3:	48 89 c8             	mov    %rcx,%rax
    1cf6:	48 f7 ea             	imul   %rdx
    1cf9:	48 89 d0             	mov    %rdx,%rax
    1cfc:	48 c1 f8 02          	sar    $0x2,%rax
    1d00:	48 c1 f9 3f          	sar    $0x3f,%rcx
    1d04:	48 89 ca             	mov    %rcx,%rdx
    1d07:	48 29 d0             	sub    %rdx,%rax
    1d0a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    1d0e:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1d13:	0f 85 7a ff ff ff    	jne    1c93 <print_d+0x2c>

  if (v < 0)
    1d19:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1d1d:	79 32                	jns    1d51 <print_d+0xea>
    buf[i++] = '-';
    1d1f:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1d22:	8d 50 01             	lea    0x1(%rax),%edx
    1d25:	89 55 f4             	mov    %edx,-0xc(%rbp)
    1d28:	48 98                	cltq
    1d2a:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    1d2f:	eb 20                	jmp    1d51 <print_d+0xea>
    putc(fd, buf[i]);
    1d31:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1d34:	48 98                	cltq
    1d36:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    1d3b:	0f be d0             	movsbl %al,%edx
    1d3e:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1d41:	89 d6                	mov    %edx,%esi
    1d43:	89 c7                	mov    %eax,%edi
    1d45:	48 b8 79 1b 00 00 00 	movabs $0x1b79,%rax
    1d4c:	00 00 00 
    1d4f:	ff d0                	call   *%rax
  while (--i >= 0)
    1d51:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    1d55:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1d59:	79 d6                	jns    1d31 <print_d+0xca>
}
    1d5b:	90                   	nop
    1d5c:	90                   	nop
    1d5d:	c9                   	leave
    1d5e:	c3                   	ret

0000000000001d5f <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    1d5f:	f3 0f 1e fa          	endbr64
    1d63:	55                   	push   %rbp
    1d64:	48 89 e5             	mov    %rsp,%rbp
    1d67:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    1d6e:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    1d74:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    1d7b:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    1d82:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    1d89:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    1d90:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    1d97:	84 c0                	test   %al,%al
    1d99:	74 20                	je     1dbb <printf+0x5c>
    1d9b:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    1d9f:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    1da3:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    1da7:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    1dab:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    1daf:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    1db3:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    1db7:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    1dbb:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    1dc2:	00 00 00 
    1dc5:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    1dcc:	00 00 00 
    1dcf:	48 8d 45 10          	lea    0x10(%rbp),%rax
    1dd3:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    1dda:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    1de1:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1de8:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    1def:	00 00 00 
    1df2:	e9 41 03 00 00       	jmp    2138 <printf+0x3d9>
    if (c != '%') {
    1df7:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1dfe:	74 24                	je     1e24 <printf+0xc5>
      putc(fd, c);
    1e00:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1e06:	0f be d0             	movsbl %al,%edx
    1e09:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1e0f:	89 d6                	mov    %edx,%esi
    1e11:	89 c7                	mov    %eax,%edi
    1e13:	48 b8 79 1b 00 00 00 	movabs $0x1b79,%rax
    1e1a:	00 00 00 
    1e1d:	ff d0                	call   *%rax
      continue;
    1e1f:	e9 0d 03 00 00       	jmp    2131 <printf+0x3d2>
    }
    c = fmt[++i] & 0xff;
    1e24:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1e2b:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1e31:	48 63 d0             	movslq %eax,%rdx
    1e34:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1e3b:	48 01 d0             	add    %rdx,%rax
    1e3e:	0f b6 00             	movzbl (%rax),%eax
    1e41:	0f be c0             	movsbl %al,%eax
    1e44:	25 ff 00 00 00       	and    $0xff,%eax
    1e49:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    1e4f:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1e56:	0f 84 0f 03 00 00    	je     216b <printf+0x40c>
      break;
    switch(c) {
    1e5c:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1e63:	0f 84 74 02 00 00    	je     20dd <printf+0x37e>
    1e69:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1e70:	0f 8c 82 02 00 00    	jl     20f8 <printf+0x399>
    1e76:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    1e7d:	0f 8f 75 02 00 00    	jg     20f8 <printf+0x399>
    1e83:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    1e8a:	0f 8c 68 02 00 00    	jl     20f8 <printf+0x399>
    1e90:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1e96:	83 e8 63             	sub    $0x63,%eax
    1e99:	83 f8 15             	cmp    $0x15,%eax
    1e9c:	0f 87 56 02 00 00    	ja     20f8 <printf+0x399>
    1ea2:	89 c0                	mov    %eax,%eax
    1ea4:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1eab:	00 
    1eac:	48 b8 e8 25 00 00 00 	movabs $0x25e8,%rax
    1eb3:	00 00 00 
    1eb6:	48 01 d0             	add    %rdx,%rax
    1eb9:	48 8b 00             	mov    (%rax),%rax
    1ebc:	3e ff e0             	notrack jmp *%rax
    case 'c':
      putc(fd, va_arg(ap, int));
    1ebf:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1ec5:	83 f8 2f             	cmp    $0x2f,%eax
    1ec8:	77 23                	ja     1eed <printf+0x18e>
    1eca:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1ed1:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1ed7:	89 d2                	mov    %edx,%edx
    1ed9:	48 01 d0             	add    %rdx,%rax
    1edc:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1ee2:	83 c2 08             	add    $0x8,%edx
    1ee5:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1eeb:	eb 12                	jmp    1eff <printf+0x1a0>
    1eed:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1ef4:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1ef8:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1eff:	8b 00                	mov    (%rax),%eax
    1f01:	0f be d0             	movsbl %al,%edx
    1f04:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1f0a:	89 d6                	mov    %edx,%esi
    1f0c:	89 c7                	mov    %eax,%edi
    1f0e:	48 b8 79 1b 00 00 00 	movabs $0x1b79,%rax
    1f15:	00 00 00 
    1f18:	ff d0                	call   *%rax
      break;
    1f1a:	e9 12 02 00 00       	jmp    2131 <printf+0x3d2>
    case 'd':
      print_d(fd, va_arg(ap, int));
    1f1f:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1f25:	83 f8 2f             	cmp    $0x2f,%eax
    1f28:	77 23                	ja     1f4d <printf+0x1ee>
    1f2a:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1f31:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1f37:	89 d2                	mov    %edx,%edx
    1f39:	48 01 d0             	add    %rdx,%rax
    1f3c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1f42:	83 c2 08             	add    $0x8,%edx
    1f45:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1f4b:	eb 12                	jmp    1f5f <printf+0x200>
    1f4d:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1f54:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1f58:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1f5f:	8b 10                	mov    (%rax),%edx
    1f61:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1f67:	89 d6                	mov    %edx,%esi
    1f69:	89 c7                	mov    %eax,%edi
    1f6b:	48 b8 67 1c 00 00 00 	movabs $0x1c67,%rax
    1f72:	00 00 00 
    1f75:	ff d0                	call   *%rax
      break;
    1f77:	e9 b5 01 00 00       	jmp    2131 <printf+0x3d2>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    1f7c:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1f82:	83 f8 2f             	cmp    $0x2f,%eax
    1f85:	77 23                	ja     1faa <printf+0x24b>
    1f87:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1f8e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1f94:	89 d2                	mov    %edx,%edx
    1f96:	48 01 d0             	add    %rdx,%rax
    1f99:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1f9f:	83 c2 08             	add    $0x8,%edx
    1fa2:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1fa8:	eb 12                	jmp    1fbc <printf+0x25d>
    1faa:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1fb1:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1fb5:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1fbc:	8b 10                	mov    (%rax),%edx
    1fbe:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1fc4:	89 d6                	mov    %edx,%esi
    1fc6:	89 c7                	mov    %eax,%edi
    1fc8:	48 b8 0a 1c 00 00 00 	movabs $0x1c0a,%rax
    1fcf:	00 00 00 
    1fd2:	ff d0                	call   *%rax
      break;
    1fd4:	e9 58 01 00 00       	jmp    2131 <printf+0x3d2>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    1fd9:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1fdf:	83 f8 2f             	cmp    $0x2f,%eax
    1fe2:	77 23                	ja     2007 <printf+0x2a8>
    1fe4:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1feb:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1ff1:	89 d2                	mov    %edx,%edx
    1ff3:	48 01 d0             	add    %rdx,%rax
    1ff6:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1ffc:	83 c2 08             	add    $0x8,%edx
    1fff:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    2005:	eb 12                	jmp    2019 <printf+0x2ba>
    2007:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    200e:	48 8d 50 08          	lea    0x8(%rax),%rdx
    2012:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    2019:	48 8b 10             	mov    (%rax),%rdx
    201c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    2022:	48 89 d6             	mov    %rdx,%rsi
    2025:	89 c7                	mov    %eax,%edi
    2027:	48 b8 ad 1b 00 00 00 	movabs $0x1bad,%rax
    202e:	00 00 00 
    2031:	ff d0                	call   *%rax
      break;
    2033:	e9 f9 00 00 00       	jmp    2131 <printf+0x3d2>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    2038:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    203e:	83 f8 2f             	cmp    $0x2f,%eax
    2041:	77 23                	ja     2066 <printf+0x307>
    2043:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    204a:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    2050:	89 d2                	mov    %edx,%edx
    2052:	48 01 d0             	add    %rdx,%rax
    2055:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    205b:	83 c2 08             	add    $0x8,%edx
    205e:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    2064:	eb 12                	jmp    2078 <printf+0x319>
    2066:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    206d:	48 8d 50 08          	lea    0x8(%rax),%rdx
    2071:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    2078:	48 8b 00             	mov    (%rax),%rax
    207b:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    2082:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    2089:	00 
    208a:	75 41                	jne    20cd <printf+0x36e>
        s = "(null)";
    208c:	48 b8 e0 25 00 00 00 	movabs $0x25e0,%rax
    2093:	00 00 00 
    2096:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    209d:	eb 2e                	jmp    20cd <printf+0x36e>
        putc(fd, *(s++));
    209f:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    20a6:	48 8d 50 01          	lea    0x1(%rax),%rdx
    20aa:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    20b1:	0f b6 00             	movzbl (%rax),%eax
    20b4:	0f be d0             	movsbl %al,%edx
    20b7:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    20bd:	89 d6                	mov    %edx,%esi
    20bf:	89 c7                	mov    %eax,%edi
    20c1:	48 b8 79 1b 00 00 00 	movabs $0x1b79,%rax
    20c8:	00 00 00 
    20cb:	ff d0                	call   *%rax
      while (*s)
    20cd:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    20d4:	0f b6 00             	movzbl (%rax),%eax
    20d7:	84 c0                	test   %al,%al
    20d9:	75 c4                	jne    209f <printf+0x340>
      break;
    20db:	eb 54                	jmp    2131 <printf+0x3d2>
    case '%':
      putc(fd, '%');
    20dd:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    20e3:	be 25 00 00 00       	mov    $0x25,%esi
    20e8:	89 c7                	mov    %eax,%edi
    20ea:	48 b8 79 1b 00 00 00 	movabs $0x1b79,%rax
    20f1:	00 00 00 
    20f4:	ff d0                	call   *%rax
      break;
    20f6:	eb 39                	jmp    2131 <printf+0x3d2>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    20f8:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    20fe:	be 25 00 00 00       	mov    $0x25,%esi
    2103:	89 c7                	mov    %eax,%edi
    2105:	48 b8 79 1b 00 00 00 	movabs $0x1b79,%rax
    210c:	00 00 00 
    210f:	ff d0                	call   *%rax
      putc(fd, c);
    2111:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    2117:	0f be d0             	movsbl %al,%edx
    211a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    2120:	89 d6                	mov    %edx,%esi
    2122:	89 c7                	mov    %eax,%edi
    2124:	48 b8 79 1b 00 00 00 	movabs $0x1b79,%rax
    212b:	00 00 00 
    212e:	ff d0                	call   *%rax
      break;
    2130:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    2131:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    2138:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    213e:	48 63 d0             	movslq %eax,%rdx
    2141:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    2148:	48 01 d0             	add    %rdx,%rax
    214b:	0f b6 00             	movzbl (%rax),%eax
    214e:	0f be c0             	movsbl %al,%eax
    2151:	25 ff 00 00 00       	and    $0xff,%eax
    2156:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    215c:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    2163:	0f 85 8e fc ff ff    	jne    1df7 <printf+0x98>
    }
  }
}
    2169:	eb 01                	jmp    216c <printf+0x40d>
      break;
    216b:	90                   	nop
}
    216c:	90                   	nop
    216d:	c9                   	leave
    216e:	c3                   	ret

000000000000216f <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    216f:	f3 0f 1e fa          	endbr64
    2173:	55                   	push   %rbp
    2174:	48 89 e5             	mov    %rsp,%rbp
    2177:	48 83 ec 18          	sub    $0x18,%rsp
    217b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    217f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    2183:	48 83 e8 10          	sub    $0x10,%rax
    2187:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    218b:	48 b8 d0 26 00 00 00 	movabs $0x26d0,%rax
    2192:	00 00 00 
    2195:	48 8b 00             	mov    (%rax),%rax
    2198:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    219c:	eb 2f                	jmp    21cd <free+0x5e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    219e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    21a2:	48 8b 00             	mov    (%rax),%rax
    21a5:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    21a9:	72 17                	jb     21c2 <free+0x53>
    21ab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    21af:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    21b3:	72 2f                	jb     21e4 <free+0x75>
    21b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    21b9:	48 8b 00             	mov    (%rax),%rax
    21bc:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    21c0:	72 22                	jb     21e4 <free+0x75>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    21c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    21c6:	48 8b 00             	mov    (%rax),%rax
    21c9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    21cd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    21d1:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    21d5:	73 c7                	jae    219e <free+0x2f>
    21d7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    21db:	48 8b 00             	mov    (%rax),%rax
    21de:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    21e2:	73 ba                	jae    219e <free+0x2f>
      break;
  if(bp + bp->s.size == p->s.ptr){
    21e4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    21e8:	8b 40 08             	mov    0x8(%rax),%eax
    21eb:	89 c0                	mov    %eax,%eax
    21ed:	48 c1 e0 04          	shl    $0x4,%rax
    21f1:	48 89 c2             	mov    %rax,%rdx
    21f4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    21f8:	48 01 c2             	add    %rax,%rdx
    21fb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    21ff:	48 8b 00             	mov    (%rax),%rax
    2202:	48 39 c2             	cmp    %rax,%rdx
    2205:	75 2d                	jne    2234 <free+0xc5>
    bp->s.size += p->s.ptr->s.size;
    2207:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    220b:	8b 50 08             	mov    0x8(%rax),%edx
    220e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2212:	48 8b 00             	mov    (%rax),%rax
    2215:	8b 40 08             	mov    0x8(%rax),%eax
    2218:	01 c2                	add    %eax,%edx
    221a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    221e:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    2221:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2225:	48 8b 00             	mov    (%rax),%rax
    2228:	48 8b 10             	mov    (%rax),%rdx
    222b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    222f:	48 89 10             	mov    %rdx,(%rax)
    2232:	eb 0e                	jmp    2242 <free+0xd3>
  } else
    bp->s.ptr = p->s.ptr;
    2234:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2238:	48 8b 10             	mov    (%rax),%rdx
    223b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    223f:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    2242:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2246:	8b 40 08             	mov    0x8(%rax),%eax
    2249:	89 c0                	mov    %eax,%eax
    224b:	48 c1 e0 04          	shl    $0x4,%rax
    224f:	48 89 c2             	mov    %rax,%rdx
    2252:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2256:	48 01 d0             	add    %rdx,%rax
    2259:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    225d:	75 27                	jne    2286 <free+0x117>
    p->s.size += bp->s.size;
    225f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2263:	8b 50 08             	mov    0x8(%rax),%edx
    2266:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    226a:	8b 40 08             	mov    0x8(%rax),%eax
    226d:	01 c2                	add    %eax,%edx
    226f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2273:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    2276:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    227a:	48 8b 10             	mov    (%rax),%rdx
    227d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2281:	48 89 10             	mov    %rdx,(%rax)
    2284:	eb 0b                	jmp    2291 <free+0x122>
  } else
    p->s.ptr = bp;
    2286:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    228a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    228e:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    2291:	48 ba d0 26 00 00 00 	movabs $0x26d0,%rdx
    2298:	00 00 00 
    229b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    229f:	48 89 02             	mov    %rax,(%rdx)
}
    22a2:	90                   	nop
    22a3:	c9                   	leave
    22a4:	c3                   	ret

00000000000022a5 <morecore>:

static Header*
morecore(uint nu)
{
    22a5:	f3 0f 1e fa          	endbr64
    22a9:	55                   	push   %rbp
    22aa:	48 89 e5             	mov    %rsp,%rbp
    22ad:	48 83 ec 20          	sub    $0x20,%rsp
    22b1:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    22b4:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    22bb:	77 07                	ja     22c4 <morecore+0x1f>
    nu = 4096;
    22bd:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    22c4:	8b 45 ec             	mov    -0x14(%rbp),%eax
    22c7:	48 c1 e0 04          	shl    $0x4,%rax
    22cb:	48 89 c7             	mov    %rax,%rdi
    22ce:	48 b8 2b 1b 00 00 00 	movabs $0x1b2b,%rax
    22d5:	00 00 00 
    22d8:	ff d0                	call   *%rax
    22da:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    22de:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    22e3:	75 07                	jne    22ec <morecore+0x47>
    return 0;
    22e5:	b8 00 00 00 00       	mov    $0x0,%eax
    22ea:	eb 36                	jmp    2322 <morecore+0x7d>
  hp = (Header*)p;
    22ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    22f0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    22f4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    22f8:	8b 55 ec             	mov    -0x14(%rbp),%edx
    22fb:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    22fe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2302:	48 83 c0 10          	add    $0x10,%rax
    2306:	48 89 c7             	mov    %rax,%rdi
    2309:	48 b8 6f 21 00 00 00 	movabs $0x216f,%rax
    2310:	00 00 00 
    2313:	ff d0                	call   *%rax
  return freep;
    2315:	48 b8 d0 26 00 00 00 	movabs $0x26d0,%rax
    231c:	00 00 00 
    231f:	48 8b 00             	mov    (%rax),%rax
}
    2322:	c9                   	leave
    2323:	c3                   	ret

0000000000002324 <malloc>:

void*
malloc(uint nbytes)
{
    2324:	f3 0f 1e fa          	endbr64
    2328:	55                   	push   %rbp
    2329:	48 89 e5             	mov    %rsp,%rbp
    232c:	48 83 ec 30          	sub    $0x30,%rsp
    2330:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    2333:	8b 45 dc             	mov    -0x24(%rbp),%eax
    2336:	48 83 c0 0f          	add    $0xf,%rax
    233a:	48 c1 e8 04          	shr    $0x4,%rax
    233e:	83 c0 01             	add    $0x1,%eax
    2341:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    2344:	48 b8 d0 26 00 00 00 	movabs $0x26d0,%rax
    234b:	00 00 00 
    234e:	48 8b 00             	mov    (%rax),%rax
    2351:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    2355:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    235a:	75 4a                	jne    23a6 <malloc+0x82>
    base.s.ptr = freep = prevp = &base;
    235c:	48 b8 c0 26 00 00 00 	movabs $0x26c0,%rax
    2363:	00 00 00 
    2366:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    236a:	48 ba d0 26 00 00 00 	movabs $0x26d0,%rdx
    2371:	00 00 00 
    2374:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2378:	48 89 02             	mov    %rax,(%rdx)
    237b:	48 b8 d0 26 00 00 00 	movabs $0x26d0,%rax
    2382:	00 00 00 
    2385:	48 8b 00             	mov    (%rax),%rax
    2388:	48 ba c0 26 00 00 00 	movabs $0x26c0,%rdx
    238f:	00 00 00 
    2392:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    2395:	48 b8 c0 26 00 00 00 	movabs $0x26c0,%rax
    239c:	00 00 00 
    239f:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    23a6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    23aa:	48 8b 00             	mov    (%rax),%rax
    23ad:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    23b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    23b5:	8b 40 08             	mov    0x8(%rax),%eax
    23b8:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    23bb:	72 65                	jb     2422 <malloc+0xfe>
      if(p->s.size == nunits)
    23bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    23c1:	8b 40 08             	mov    0x8(%rax),%eax
    23c4:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    23c7:	75 10                	jne    23d9 <malloc+0xb5>
        prevp->s.ptr = p->s.ptr;
    23c9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    23cd:	48 8b 10             	mov    (%rax),%rdx
    23d0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    23d4:	48 89 10             	mov    %rdx,(%rax)
    23d7:	eb 2e                	jmp    2407 <malloc+0xe3>
      else {
        p->s.size -= nunits;
    23d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    23dd:	8b 40 08             	mov    0x8(%rax),%eax
    23e0:	2b 45 ec             	sub    -0x14(%rbp),%eax
    23e3:	89 c2                	mov    %eax,%edx
    23e5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    23e9:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    23ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    23f0:	8b 40 08             	mov    0x8(%rax),%eax
    23f3:	89 c0                	mov    %eax,%eax
    23f5:	48 c1 e0 04          	shl    $0x4,%rax
    23f9:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    23fd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2401:	8b 55 ec             	mov    -0x14(%rbp),%edx
    2404:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    2407:	48 ba d0 26 00 00 00 	movabs $0x26d0,%rdx
    240e:	00 00 00 
    2411:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2415:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    2418:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    241c:	48 83 c0 10          	add    $0x10,%rax
    2420:	eb 4e                	jmp    2470 <malloc+0x14c>
    }
    if(p == freep)
    2422:	48 b8 d0 26 00 00 00 	movabs $0x26d0,%rax
    2429:	00 00 00 
    242c:	48 8b 00             	mov    (%rax),%rax
    242f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    2433:	75 23                	jne    2458 <malloc+0x134>
      if((p = morecore(nunits)) == 0)
    2435:	8b 45 ec             	mov    -0x14(%rbp),%eax
    2438:	89 c7                	mov    %eax,%edi
    243a:	48 b8 a5 22 00 00 00 	movabs $0x22a5,%rax
    2441:	00 00 00 
    2444:	ff d0                	call   *%rax
    2446:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    244a:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    244f:	75 07                	jne    2458 <malloc+0x134>
        return 0;
    2451:	b8 00 00 00 00       	mov    $0x0,%eax
    2456:	eb 18                	jmp    2470 <malloc+0x14c>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    2458:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    245c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    2460:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2464:	48 8b 00             	mov    (%rax),%rax
    2467:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    246b:	e9 41 ff ff ff       	jmp    23b1 <malloc+0x8d>
  }
}
    2470:	c9                   	leave
    2471:	c3                   	ret
