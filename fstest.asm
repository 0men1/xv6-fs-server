
_fstest:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <fs_call>:
#include "fcntl.h"
#include "ipc.h"

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
    102f:	48 b8 25 1d 00 00 00 	movabs $0x1d25,%rax
    1036:	00 00 00 
    1039:	ff d0                	call   *%rax
    103b:	85 c0                	test   %eax,%eax
    103d:	79 0a                	jns    1049 <fs_call+0x49>
    return -1;
    103f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1044:	e9 67 01 00 00       	jmp    11b0 <fs_call+0x1b0>
  if(recv(&reply) < 0)
    1049:	48 8d 85 10 ff ff ff 	lea    -0xf0(%rbp),%rax
    1050:	48 89 c7             	mov    %rax,%rdi
    1053:	48 b8 32 1d 00 00 00 	movabs $0x1d32,%rax
    105a:	00 00 00 
    105d:	ff d0                	call   *%rax
    105f:	85 c0                	test   %eax,%eax
    1061:	79 0a                	jns    106d <fs_call+0x6d>
    return -1;
    1063:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1068:	e9 43 01 00 00       	jmp    11b0 <fs_call+0x1b0>
  if(reply.type != IPC_TYPE_FS_REPLY)
    106d:	8b 85 14 ff ff ff    	mov    -0xec(%rbp),%eax
    1073:	83 f8 64             	cmp    $0x64,%eax
    1076:	74 0a                	je     1082 <fs_call+0x82>
    return -1;
    1078:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    107d:	e9 2e 01 00 00       	jmp    11b0 <fs_call+0x1b0>

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
    11a0:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    11a4:	48 89 90 d0 00 00 00 	mov    %rdx,0xd0(%rax)
  return 0;
    11ab:	b8 00 00 00 00       	mov    $0x0,%eax
}
    11b0:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
    11b4:	c9                   	leave
    11b5:	c3                   	ret

00000000000011b6 <fs_open_remote>:

static int
fs_open_remote(int server_pid, char *path, int flags)
{
    11b6:	f3 0f 1e fa          	endbr64
    11ba:	55                   	push   %rbp
    11bb:	48 89 e5             	mov    %rsp,%rbp
    11be:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    11c5:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    11cb:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    11d2:	89 95 18 ff ff ff    	mov    %edx,-0xe8(%rbp)
  struct ipc_msg msg;
  int i;
  memset(&msg, 0, sizeof(msg));
    11d8:	48 8d 85 20 ff ff ff 	lea    -0xe0(%rbp),%rax
    11df:	ba d8 00 00 00       	mov    $0xd8,%edx
    11e4:	be 00 00 00 00       	mov    $0x0,%esi
    11e9:	48 89 c7             	mov    %rax,%rdi
    11ec:	48 b8 ec 19 00 00 00 	movabs $0x19ec,%rax
    11f3:	00 00 00 
    11f6:	ff d0                	call   *%rax
  msg.type = IPC_TYPE_FS_OPEN;
    11f8:	c7 85 24 ff ff ff 01 	movl   $0x1,-0xdc(%rbp)
    11ff:	00 00 00 
  msg.flags = flags;
    1202:	8b 85 18 ff ff ff    	mov    -0xe8(%rbp),%eax
    1208:	89 85 2c ff ff ff    	mov    %eax,-0xd4(%rbp)
  for(i = 0; i < IPC_PATH_SIZE - 1 && path[i] != 0; i++)
    120e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1215:	eb 23                	jmp    123a <fs_open_remote+0x84>
    msg.path[i] = path[i];
    1217:	8b 45 fc             	mov    -0x4(%rbp),%eax
    121a:	48 63 d0             	movslq %eax,%rdx
    121d:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1224:	48 01 d0             	add    %rdx,%rax
    1227:	0f b6 10             	movzbl (%rax),%edx
    122a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    122d:	48 98                	cltq
    122f:	88 94 05 38 ff ff ff 	mov    %dl,-0xc8(%rbp,%rax,1)
  for(i = 0; i < IPC_PATH_SIZE - 1 && path[i] != 0; i++)
    1236:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    123a:	83 7d fc 3e          	cmpl   $0x3e,-0x4(%rbp)
    123e:	7f 17                	jg     1257 <fs_open_remote+0xa1>
    1240:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1243:	48 63 d0             	movslq %eax,%rdx
    1246:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    124d:	48 01 d0             	add    %rdx,%rax
    1250:	0f b6 00             	movzbl (%rax),%eax
    1253:	84 c0                	test   %al,%al
    1255:	75 c0                	jne    1217 <fs_open_remote+0x61>
  msg.path[i] = 0;
    1257:	8b 45 fc             	mov    -0x4(%rbp),%eax
    125a:	48 98                	cltq
    125c:	c6 84 05 38 ff ff ff 	movb   $0x0,-0xc8(%rbp,%rax,1)
    1263:	00 

  if(fs_call(server_pid, &msg) < 0)
    1264:	48 8d 95 20 ff ff ff 	lea    -0xe0(%rbp),%rdx
    126b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1271:	48 89 d6             	mov    %rdx,%rsi
    1274:	89 c7                	mov    %eax,%edi
    1276:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    127d:	00 00 00 
    1280:	ff d0                	call   *%rax
    1282:	85 c0                	test   %eax,%eax
    1284:	79 07                	jns    128d <fs_open_remote+0xd7>
    return -1;
    1286:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    128b:	eb 06                	jmp    1293 <fs_open_remote+0xdd>
  return msg.result;
    128d:	8b 85 34 ff ff ff    	mov    -0xcc(%rbp),%eax
}
    1293:	c9                   	leave
    1294:	c3                   	ret

0000000000001295 <fs_write_remote>:

static int
fs_write_remote(int server_pid, int fd, char *buf, int n)
{
    1295:	f3 0f 1e fa          	endbr64
    1299:	55                   	push   %rbp
    129a:	48 89 e5             	mov    %rsp,%rbp
    129d:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
    12a4:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    12aa:	89 b5 18 ff ff ff    	mov    %esi,-0xe8(%rbp)
    12b0:	48 89 95 10 ff ff ff 	mov    %rdx,-0xf0(%rbp)
    12b7:	89 8d 0c ff ff ff    	mov    %ecx,-0xf4(%rbp)
  struct ipc_msg msg;
  if(n > IPC_DATA_SIZE)
    12bd:	81 bd 0c ff ff ff 80 	cmpl   $0x80,-0xf4(%rbp)
    12c4:	00 00 00 
    12c7:	7e 0a                	jle    12d3 <fs_write_remote+0x3e>
    n = IPC_DATA_SIZE;
    12c9:	c7 85 0c ff ff ff 80 	movl   $0x80,-0xf4(%rbp)
    12d0:	00 00 00 
  if(n < 0)
    12d3:	83 bd 0c ff ff ff 00 	cmpl   $0x0,-0xf4(%rbp)
    12da:	79 0a                	jns    12e6 <fs_write_remote+0x51>
    n = 0;
    12dc:	c7 85 0c ff ff ff 00 	movl   $0x0,-0xf4(%rbp)
    12e3:	00 00 00 

  memset(&msg, 0, sizeof(msg));
    12e6:	48 8d 85 20 ff ff ff 	lea    -0xe0(%rbp),%rax
    12ed:	ba d8 00 00 00       	mov    $0xd8,%edx
    12f2:	be 00 00 00 00       	mov    $0x0,%esi
    12f7:	48 89 c7             	mov    %rax,%rdi
    12fa:	48 b8 ec 19 00 00 00 	movabs $0x19ec,%rax
    1301:	00 00 00 
    1304:	ff d0                	call   *%rax
  msg.type = IPC_TYPE_FS_WRITE;
    1306:	c7 85 24 ff ff ff 03 	movl   $0x3,-0xdc(%rbp)
    130d:	00 00 00 
  msg.fd = fd;
    1310:	8b 85 18 ff ff ff    	mov    -0xe8(%rbp),%eax
    1316:	89 85 28 ff ff ff    	mov    %eax,-0xd8(%rbp)
  msg.nbytes = n;
    131c:	8b 85 0c ff ff ff    	mov    -0xf4(%rbp),%eax
    1322:	89 85 30 ff ff ff    	mov    %eax,-0xd0(%rbp)
  memmove(msg.data, buf, n);
    1328:	8b 95 0c ff ff ff    	mov    -0xf4(%rbp),%edx
    132e:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1335:	48 8d 8d 20 ff ff ff 	lea    -0xe0(%rbp),%rcx
    133c:	48 83 c1 58          	add    $0x58,%rcx
    1340:	48 89 c6             	mov    %rax,%rsi
    1343:	48 89 cf             	mov    %rcx,%rdi
    1346:	48 b8 bb 1b 00 00 00 	movabs $0x1bbb,%rax
    134d:	00 00 00 
    1350:	ff d0                	call   *%rax

  if(fs_call(server_pid, &msg) < 0)
    1352:	48 8d 95 20 ff ff ff 	lea    -0xe0(%rbp),%rdx
    1359:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    135f:	48 89 d6             	mov    %rdx,%rsi
    1362:	89 c7                	mov    %eax,%edi
    1364:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    136b:	00 00 00 
    136e:	ff d0                	call   *%rax
    1370:	85 c0                	test   %eax,%eax
    1372:	79 07                	jns    137b <fs_write_remote+0xe6>
    return -1;
    1374:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1379:	eb 06                	jmp    1381 <fs_write_remote+0xec>
  return msg.result;
    137b:	8b 85 34 ff ff ff    	mov    -0xcc(%rbp),%eax
}
    1381:	c9                   	leave
    1382:	c3                   	ret

0000000000001383 <fs_read_remote>:

static int
fs_read_remote(int server_pid, int fd, char *buf, int n)
{
    1383:	f3 0f 1e fa          	endbr64
    1387:	55                   	push   %rbp
    1388:	48 89 e5             	mov    %rsp,%rbp
    138b:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
    1392:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    1398:	89 b5 18 ff ff ff    	mov    %esi,-0xe8(%rbp)
    139e:	48 89 95 10 ff ff ff 	mov    %rdx,-0xf0(%rbp)
    13a5:	89 8d 0c ff ff ff    	mov    %ecx,-0xf4(%rbp)
  struct ipc_msg msg;
  if(n > IPC_DATA_SIZE)
    13ab:	81 bd 0c ff ff ff 80 	cmpl   $0x80,-0xf4(%rbp)
    13b2:	00 00 00 
    13b5:	7e 0a                	jle    13c1 <fs_read_remote+0x3e>
    n = IPC_DATA_SIZE;
    13b7:	c7 85 0c ff ff ff 80 	movl   $0x80,-0xf4(%rbp)
    13be:	00 00 00 
  if(n < 0)
    13c1:	83 bd 0c ff ff ff 00 	cmpl   $0x0,-0xf4(%rbp)
    13c8:	79 0a                	jns    13d4 <fs_read_remote+0x51>
    n = 0;
    13ca:	c7 85 0c ff ff ff 00 	movl   $0x0,-0xf4(%rbp)
    13d1:	00 00 00 

  memset(&msg, 0, sizeof(msg));
    13d4:	48 8d 85 20 ff ff ff 	lea    -0xe0(%rbp),%rax
    13db:	ba d8 00 00 00       	mov    $0xd8,%edx
    13e0:	be 00 00 00 00       	mov    $0x0,%esi
    13e5:	48 89 c7             	mov    %rax,%rdi
    13e8:	48 b8 ec 19 00 00 00 	movabs $0x19ec,%rax
    13ef:	00 00 00 
    13f2:	ff d0                	call   *%rax
  msg.type = IPC_TYPE_FS_READ;
    13f4:	c7 85 24 ff ff ff 02 	movl   $0x2,-0xdc(%rbp)
    13fb:	00 00 00 
  msg.fd = fd;
    13fe:	8b 85 18 ff ff ff    	mov    -0xe8(%rbp),%eax
    1404:	89 85 28 ff ff ff    	mov    %eax,-0xd8(%rbp)
  msg.nbytes = n;
    140a:	8b 85 0c ff ff ff    	mov    -0xf4(%rbp),%eax
    1410:	89 85 30 ff ff ff    	mov    %eax,-0xd0(%rbp)

  if(fs_call(server_pid, &msg) < 0)
    1416:	48 8d 95 20 ff ff ff 	lea    -0xe0(%rbp),%rdx
    141d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1423:	48 89 d6             	mov    %rdx,%rsi
    1426:	89 c7                	mov    %eax,%edi
    1428:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    142f:	00 00 00 
    1432:	ff d0                	call   *%rax
    1434:	85 c0                	test   %eax,%eax
    1436:	79 07                	jns    143f <fs_read_remote+0xbc>
    return -1;
    1438:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    143d:	eb 4b                	jmp    148a <fs_read_remote+0x107>
  if(msg.result < 0)
    143f:	8b 85 34 ff ff ff    	mov    -0xcc(%rbp),%eax
    1445:	85 c0                	test   %eax,%eax
    1447:	79 07                	jns    1450 <fs_read_remote+0xcd>
    return -1;
    1449:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    144e:	eb 3a                	jmp    148a <fs_read_remote+0x107>
  if(msg.nbytes > 0)
    1450:	8b 85 30 ff ff ff    	mov    -0xd0(%rbp),%eax
    1456:	85 c0                	test   %eax,%eax
    1458:	7e 2a                	jle    1484 <fs_read_remote+0x101>
    memmove(buf, msg.data, msg.nbytes);
    145a:	8b 95 30 ff ff ff    	mov    -0xd0(%rbp),%edx
    1460:	48 8d 85 20 ff ff ff 	lea    -0xe0(%rbp),%rax
    1467:	48 8d 48 58          	lea    0x58(%rax),%rcx
    146b:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1472:	48 89 ce             	mov    %rcx,%rsi
    1475:	48 89 c7             	mov    %rax,%rdi
    1478:	48 b8 bb 1b 00 00 00 	movabs $0x1bbb,%rax
    147f:	00 00 00 
    1482:	ff d0                	call   *%rax
  return msg.result;
    1484:	8b 85 34 ff ff ff    	mov    -0xcc(%rbp),%eax
}
    148a:	c9                   	leave
    148b:	c3                   	ret

000000000000148c <fs_close_remote>:

static int
fs_close_remote(int server_pid, int fd)
{
    148c:	f3 0f 1e fa          	endbr64
    1490:	55                   	push   %rbp
    1491:	48 89 e5             	mov    %rsp,%rbp
    1494:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    149b:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    14a1:	89 b5 18 ff ff ff    	mov    %esi,-0xe8(%rbp)
  struct ipc_msg msg;
  memset(&msg, 0, sizeof(msg));
    14a7:	48 8d 85 20 ff ff ff 	lea    -0xe0(%rbp),%rax
    14ae:	ba d8 00 00 00       	mov    $0xd8,%edx
    14b3:	be 00 00 00 00       	mov    $0x0,%esi
    14b8:	48 89 c7             	mov    %rax,%rdi
    14bb:	48 b8 ec 19 00 00 00 	movabs $0x19ec,%rax
    14c2:	00 00 00 
    14c5:	ff d0                	call   *%rax
  msg.type = IPC_TYPE_FS_CLOSE;
    14c7:	c7 85 24 ff ff ff 04 	movl   $0x4,-0xdc(%rbp)
    14ce:	00 00 00 
  msg.fd = fd;
    14d1:	8b 85 18 ff ff ff    	mov    -0xe8(%rbp),%eax
    14d7:	89 85 28 ff ff ff    	mov    %eax,-0xd8(%rbp)

  if(fs_call(server_pid, &msg) < 0)
    14dd:	48 8d 95 20 ff ff ff 	lea    -0xe0(%rbp),%rdx
    14e4:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    14ea:	48 89 d6             	mov    %rdx,%rsi
    14ed:	89 c7                	mov    %eax,%edi
    14ef:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    14f6:	00 00 00 
    14f9:	ff d0                	call   *%rax
    14fb:	85 c0                	test   %eax,%eax
    14fd:	79 07                	jns    1506 <fs_close_remote+0x7a>
    return -1;
    14ff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1504:	eb 06                	jmp    150c <fs_close_remote+0x80>
  return msg.result;
    1506:	8b 85 34 ff ff ff    	mov    -0xcc(%rbp),%eax
}
    150c:	c9                   	leave
    150d:	c3                   	ret

000000000000150e <fs_shutdown_remote>:

static void
fs_shutdown_remote(int server_pid)
{
    150e:	f3 0f 1e fa          	endbr64
    1512:	55                   	push   %rbp
    1513:	48 89 e5             	mov    %rsp,%rbp
    1516:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    151d:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
  struct ipc_msg msg;
  memset(&msg, 0, sizeof(msg));
    1523:	48 8d 85 20 ff ff ff 	lea    -0xe0(%rbp),%rax
    152a:	ba d8 00 00 00       	mov    $0xd8,%edx
    152f:	be 00 00 00 00       	mov    $0x0,%esi
    1534:	48 89 c7             	mov    %rax,%rdi
    1537:	48 b8 ec 19 00 00 00 	movabs $0x19ec,%rax
    153e:	00 00 00 
    1541:	ff d0                	call   *%rax
  msg.type = IPC_TYPE_FS_SHUTDOWN;
    1543:	c7 85 24 ff ff ff 65 	movl   $0x65,-0xdc(%rbp)
    154a:	00 00 00 
  fs_call(server_pid, &msg);
    154d:	48 8d 95 20 ff ff ff 	lea    -0xe0(%rbp),%rdx
    1554:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    155a:	48 89 d6             	mov    %rdx,%rsi
    155d:	89 c7                	mov    %eax,%edi
    155f:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1566:	00 00 00 
    1569:	ff d0                	call   *%rax
}
    156b:	90                   	nop
    156c:	c9                   	leave
    156d:	c3                   	ret

000000000000156e <main>:

int
main(void)
{
    156e:	f3 0f 1e fa          	endbr64
    1572:	55                   	push   %rbp
    1573:	48 89 e5             	mov    %rsp,%rbp
    1576:	48 81 ec c0 00 00 00 	sub    $0xc0,%rsp
  int server_pid;
  int fd;
  int n;
  char buf[IPC_DATA_SIZE + 1];
  char msg[] = "hello from IPC file server\n";
    157d:	48 b8 68 65 6c 6c 6f 	movabs $0x7266206f6c6c6568,%rax
    1584:	20 66 72 
    1587:	48 ba 6f 6d 20 49 50 	movabs $0x6620435049206d6f,%rdx
    158e:	43 20 66 
    1591:	48 89 85 50 ff ff ff 	mov    %rax,-0xb0(%rbp)
    1598:	48 89 95 58 ff ff ff 	mov    %rdx,-0xa8(%rbp)
    159f:	48 b8 50 43 20 66 69 	movabs $0x20656c6966204350,%rax
    15a6:	6c 65 20 
    15a9:	48 ba 73 65 72 76 65 	movabs $0xa726576726573,%rdx
    15b0:	72 0a 00 
    15b3:	48 89 85 5c ff ff ff 	mov    %rax,-0xa4(%rbp)
    15ba:	48 89 95 64 ff ff ff 	mov    %rdx,-0x9c(%rbp)

  server_pid = fork();
    15c1:	48 b8 14 1c 00 00 00 	movabs $0x1c14,%rax
    15c8:	00 00 00 
    15cb:	ff d0                	call   *%rax
    15cd:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(server_pid < 0){
    15d0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    15d4:	79 2f                	jns    1605 <main+0x97>
    printf(1, "fstest: fork failed\n");
    15d6:	48 b8 30 26 00 00 00 	movabs $0x2630,%rax
    15dd:	00 00 00 
    15e0:	48 89 c6             	mov    %rax,%rsi
    15e3:	bf 01 00 00 00       	mov    $0x1,%edi
    15e8:	b8 00 00 00 00       	mov    $0x0,%eax
    15ed:	48 ba 25 1f 00 00 00 	movabs $0x1f25,%rdx
    15f4:	00 00 00 
    15f7:	ff d2                	call   *%rdx
    exit();
    15f9:	48 b8 21 1c 00 00 00 	movabs $0x1c21,%rax
    1600:	00 00 00 
    1603:	ff d0                	call   *%rax
  }

  if(server_pid == 0){
    1605:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1609:	75 6e                	jne    1679 <main+0x10b>
    char *argv[] = { "fsserver", 0 };
    160b:	48 b8 45 26 00 00 00 	movabs $0x2645,%rax
    1612:	00 00 00 
    1615:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    161c:	48 c7 85 48 ff ff ff 	movq   $0x0,-0xb8(%rbp)
    1623:	00 00 00 00 
    exec("fsserver", argv);
    1627:	48 8d 85 40 ff ff ff 	lea    -0xc0(%rbp),%rax
    162e:	48 89 c6             	mov    %rax,%rsi
    1631:	48 b8 45 26 00 00 00 	movabs $0x2645,%rax
    1638:	00 00 00 
    163b:	48 89 c7             	mov    %rax,%rdi
    163e:	48 b8 7c 1c 00 00 00 	movabs $0x1c7c,%rax
    1645:	00 00 00 
    1648:	ff d0                	call   *%rax
    printf(1, "fstest: exec fsserver failed\n");
    164a:	48 b8 4e 26 00 00 00 	movabs $0x264e,%rax
    1651:	00 00 00 
    1654:	48 89 c6             	mov    %rax,%rsi
    1657:	bf 01 00 00 00       	mov    $0x1,%edi
    165c:	b8 00 00 00 00       	mov    $0x0,%eax
    1661:	48 ba 25 1f 00 00 00 	movabs $0x1f25,%rdx
    1668:	00 00 00 
    166b:	ff d2                	call   *%rdx
    exit();
    166d:	48 b8 21 1c 00 00 00 	movabs $0x1c21,%rax
    1674:	00 00 00 
    1677:	ff d0                	call   *%rax
  }

  sleep(10);
    1679:	bf 0a 00 00 00       	mov    $0xa,%edi
    167e:	48 b8 0b 1d 00 00 00 	movabs $0x1d0b,%rax
    1685:	00 00 00 
    1688:	ff d0                	call   *%rax

  fd = fs_open_remote(server_pid, "ipcfs.txt", O_CREATE | O_RDWR);
    168a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    168d:	ba 02 02 00 00       	mov    $0x202,%edx
    1692:	48 b9 6c 26 00 00 00 	movabs $0x266c,%rcx
    1699:	00 00 00 
    169c:	48 89 ce             	mov    %rcx,%rsi
    169f:	89 c7                	mov    %eax,%edi
    16a1:	48 b8 b6 11 00 00 00 	movabs $0x11b6,%rax
    16a8:	00 00 00 
    16ab:	ff d0                	call   *%rax
    16ad:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(fd < 0){
    16b0:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    16b4:	79 4c                	jns    1702 <main+0x194>
    printf(1, "fstest: remote open failed\n");
    16b6:	48 b8 76 26 00 00 00 	movabs $0x2676,%rax
    16bd:	00 00 00 
    16c0:	48 89 c6             	mov    %rax,%rsi
    16c3:	bf 01 00 00 00       	mov    $0x1,%edi
    16c8:	b8 00 00 00 00       	mov    $0x0,%eax
    16cd:	48 ba 25 1f 00 00 00 	movabs $0x1f25,%rdx
    16d4:	00 00 00 
    16d7:	ff d2                	call   *%rdx
    kill(server_pid);
    16d9:	8b 45 fc             	mov    -0x4(%rbp),%eax
    16dc:	89 c7                	mov    %eax,%edi
    16de:	48 b8 6f 1c 00 00 00 	movabs $0x1c6f,%rax
    16e5:	00 00 00 
    16e8:	ff d0                	call   *%rax
    wait();
    16ea:	48 b8 2e 1c 00 00 00 	movabs $0x1c2e,%rax
    16f1:	00 00 00 
    16f4:	ff d0                	call   *%rax
    exit();
    16f6:	48 b8 21 1c 00 00 00 	movabs $0x1c21,%rax
    16fd:	00 00 00 
    1700:	ff d0                	call   *%rax
  }

  if(fs_write_remote(server_pid, fd, msg, strlen(msg)) < 0){
    1702:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    1709:	48 89 c7             	mov    %rax,%rdi
    170c:	48 b8 b6 19 00 00 00 	movabs $0x19b6,%rax
    1713:	00 00 00 
    1716:	ff d0                	call   *%rax
    1718:	89 c1                	mov    %eax,%ecx
    171a:	48 8d 95 50 ff ff ff 	lea    -0xb0(%rbp),%rdx
    1721:	8b 75 f8             	mov    -0x8(%rbp),%esi
    1724:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1727:	89 c7                	mov    %eax,%edi
    1729:	48 b8 95 12 00 00 00 	movabs $0x1295,%rax
    1730:	00 00 00 
    1733:	ff d0                	call   *%rax
    1735:	85 c0                	test   %eax,%eax
    1737:	79 23                	jns    175c <main+0x1ee>
    printf(1, "fstest: remote write failed\n");
    1739:	48 b8 92 26 00 00 00 	movabs $0x2692,%rax
    1740:	00 00 00 
    1743:	48 89 c6             	mov    %rax,%rsi
    1746:	bf 01 00 00 00       	mov    $0x1,%edi
    174b:	b8 00 00 00 00       	mov    $0x0,%eax
    1750:	48 ba 25 1f 00 00 00 	movabs $0x1f25,%rdx
    1757:	00 00 00 
    175a:	ff d2                	call   *%rdx
  }
  if(fs_close_remote(server_pid, fd) < 0){
    175c:	8b 55 f8             	mov    -0x8(%rbp),%edx
    175f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1762:	89 d6                	mov    %edx,%esi
    1764:	89 c7                	mov    %eax,%edi
    1766:	48 b8 8c 14 00 00 00 	movabs $0x148c,%rax
    176d:	00 00 00 
    1770:	ff d0                	call   *%rax
    1772:	85 c0                	test   %eax,%eax
    1774:	79 23                	jns    1799 <main+0x22b>
    printf(1, "fstest: remote close failed\n");
    1776:	48 b8 af 26 00 00 00 	movabs $0x26af,%rax
    177d:	00 00 00 
    1780:	48 89 c6             	mov    %rax,%rsi
    1783:	bf 01 00 00 00       	mov    $0x1,%edi
    1788:	b8 00 00 00 00       	mov    $0x0,%eax
    178d:	48 ba 25 1f 00 00 00 	movabs $0x1f25,%rdx
    1794:	00 00 00 
    1797:	ff d2                	call   *%rdx
  }

  fd = fs_open_remote(server_pid, "ipcfs.txt", O_RDONLY);
    1799:	8b 45 fc             	mov    -0x4(%rbp),%eax
    179c:	ba 00 00 00 00       	mov    $0x0,%edx
    17a1:	48 b9 6c 26 00 00 00 	movabs $0x266c,%rcx
    17a8:	00 00 00 
    17ab:	48 89 ce             	mov    %rcx,%rsi
    17ae:	89 c7                	mov    %eax,%edi
    17b0:	48 b8 b6 11 00 00 00 	movabs $0x11b6,%rax
    17b7:	00 00 00 
    17ba:	ff d0                	call   *%rax
    17bc:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(fd < 0){
    17bf:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    17c3:	79 4c                	jns    1811 <main+0x2a3>
    printf(1, "fstest: reopen failed\n");
    17c5:	48 b8 cc 26 00 00 00 	movabs $0x26cc,%rax
    17cc:	00 00 00 
    17cf:	48 89 c6             	mov    %rax,%rsi
    17d2:	bf 01 00 00 00       	mov    $0x1,%edi
    17d7:	b8 00 00 00 00       	mov    $0x0,%eax
    17dc:	48 ba 25 1f 00 00 00 	movabs $0x1f25,%rdx
    17e3:	00 00 00 
    17e6:	ff d2                	call   *%rdx
    fs_shutdown_remote(server_pid);
    17e8:	8b 45 fc             	mov    -0x4(%rbp),%eax
    17eb:	89 c7                	mov    %eax,%edi
    17ed:	48 b8 0e 15 00 00 00 	movabs $0x150e,%rax
    17f4:	00 00 00 
    17f7:	ff d0                	call   *%rax
    wait();
    17f9:	48 b8 2e 1c 00 00 00 	movabs $0x1c2e,%rax
    1800:	00 00 00 
    1803:	ff d0                	call   *%rax
    exit();
    1805:	48 b8 21 1c 00 00 00 	movabs $0x1c21,%rax
    180c:	00 00 00 
    180f:	ff d0                	call   *%rax
  }

  n = fs_read_remote(server_pid, fd, buf, IPC_DATA_SIZE);
    1811:	48 8d 95 70 ff ff ff 	lea    -0x90(%rbp),%rdx
    1818:	8b 75 f8             	mov    -0x8(%rbp),%esi
    181b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    181e:	b9 80 00 00 00       	mov    $0x80,%ecx
    1823:	89 c7                	mov    %eax,%edi
    1825:	48 b8 83 13 00 00 00 	movabs $0x1383,%rax
    182c:	00 00 00 
    182f:	ff d0                	call   *%rax
    1831:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(n < 0){
    1834:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1838:	79 25                	jns    185f <main+0x2f1>
    printf(1, "fstest: remote read failed\n");
    183a:	48 b8 e3 26 00 00 00 	movabs $0x26e3,%rax
    1841:	00 00 00 
    1844:	48 89 c6             	mov    %rax,%rsi
    1847:	bf 01 00 00 00       	mov    $0x1,%edi
    184c:	b8 00 00 00 00       	mov    $0x0,%eax
    1851:	48 ba 25 1f 00 00 00 	movabs $0x1f25,%rdx
    1858:	00 00 00 
    185b:	ff d2                	call   *%rdx
    185d:	eb 40                	jmp    189f <main+0x331>
  } else {
    buf[n] = 0;
    185f:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1862:	48 98                	cltq
    1864:	c6 84 05 70 ff ff ff 	movb   $0x0,-0x90(%rbp,%rax,1)
    186b:	00 
    printf(1, "fstest: read %d bytes: %s", n, buf);
    186c:	48 8d 95 70 ff ff ff 	lea    -0x90(%rbp),%rdx
    1873:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1876:	48 89 d1             	mov    %rdx,%rcx
    1879:	89 c2                	mov    %eax,%edx
    187b:	48 b8 ff 26 00 00 00 	movabs $0x26ff,%rax
    1882:	00 00 00 
    1885:	48 89 c6             	mov    %rax,%rsi
    1888:	bf 01 00 00 00       	mov    $0x1,%edi
    188d:	b8 00 00 00 00       	mov    $0x0,%eax
    1892:	49 b8 25 1f 00 00 00 	movabs $0x1f25,%r8
    1899:	00 00 00 
    189c:	41 ff d0             	call   *%r8
  }
  fs_close_remote(server_pid, fd);
    189f:	8b 55 f8             	mov    -0x8(%rbp),%edx
    18a2:	8b 45 fc             	mov    -0x4(%rbp),%eax
    18a5:	89 d6                	mov    %edx,%esi
    18a7:	89 c7                	mov    %eax,%edi
    18a9:	48 b8 8c 14 00 00 00 	movabs $0x148c,%rax
    18b0:	00 00 00 
    18b3:	ff d0                	call   *%rax

  fs_shutdown_remote(server_pid);
    18b5:	8b 45 fc             	mov    -0x4(%rbp),%eax
    18b8:	89 c7                	mov    %eax,%edi
    18ba:	48 b8 0e 15 00 00 00 	movabs $0x150e,%rax
    18c1:	00 00 00 
    18c4:	ff d0                	call   *%rax
  wait();
    18c6:	48 b8 2e 1c 00 00 00 	movabs $0x1c2e,%rax
    18cd:	00 00 00 
    18d0:	ff d0                	call   *%rax
  exit();
    18d2:	48 b8 21 1c 00 00 00 	movabs $0x1c21,%rax
    18d9:	00 00 00 
    18dc:	ff d0                	call   *%rax

00000000000018de <stosb>:
  stosb(dst, c, n);
  return dst;
}

char*
strchr(const char *s, char c)
    18de:	f3 0f 1e fa          	endbr64
    18e2:	55                   	push   %rbp
    18e3:	48 89 e5             	mov    %rsp,%rbp
    18e6:	48 83 ec 10          	sub    $0x10,%rsp
    18ea:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    18ee:	89 75 f4             	mov    %esi,-0xc(%rbp)
    18f1:	89 55 f0             	mov    %edx,-0x10(%rbp)
{
    18f4:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    18f8:	8b 55 f0             	mov    -0x10(%rbp),%edx
    18fb:	8b 45 f4             	mov    -0xc(%rbp),%eax
    18fe:	48 89 ce             	mov    %rcx,%rsi
    1901:	48 89 f7             	mov    %rsi,%rdi
    1904:	89 d1                	mov    %edx,%ecx
    1906:	fc                   	cld
    1907:	f3 aa                	rep stos %al,%es:(%rdi)
    1909:	89 ca                	mov    %ecx,%edx
    190b:	48 89 fe             	mov    %rdi,%rsi
    190e:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    1912:	89 55 f0             	mov    %edx,-0x10(%rbp)
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
    1915:	90                   	nop
    1916:	c9                   	leave
    1917:	c3                   	ret

0000000000001918 <strcpy>:
{
    1918:	f3 0f 1e fa          	endbr64
    191c:	55                   	push   %rbp
    191d:	48 89 e5             	mov    %rsp,%rbp
    1920:	48 83 ec 20          	sub    $0x20,%rsp
    1924:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1928:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  os = s;
    192c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1930:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    1934:	90                   	nop
    1935:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1939:	48 8d 42 01          	lea    0x1(%rdx),%rax
    193d:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    1941:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1945:	48 8d 48 01          	lea    0x1(%rax),%rcx
    1949:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    194d:	0f b6 12             	movzbl (%rdx),%edx
    1950:	88 10                	mov    %dl,(%rax)
    1952:	0f b6 00             	movzbl (%rax),%eax
    1955:	84 c0                	test   %al,%al
    1957:	75 dc                	jne    1935 <strcpy+0x1d>
  return os;
    1959:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    195d:	c9                   	leave
    195e:	c3                   	ret

000000000000195f <strcmp>:
{
    195f:	f3 0f 1e fa          	endbr64
    1963:	55                   	push   %rbp
    1964:	48 89 e5             	mov    %rsp,%rbp
    1967:	48 83 ec 10          	sub    $0x10,%rsp
    196b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    196f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    1973:	eb 0a                	jmp    197f <strcmp+0x20>
    p++, q++;
    1975:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    197a:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    197f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1983:	0f b6 00             	movzbl (%rax),%eax
    1986:	84 c0                	test   %al,%al
    1988:	74 12                	je     199c <strcmp+0x3d>
    198a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    198e:	0f b6 10             	movzbl (%rax),%edx
    1991:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1995:	0f b6 00             	movzbl (%rax),%eax
    1998:	38 c2                	cmp    %al,%dl
    199a:	74 d9                	je     1975 <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
    199c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    19a0:	0f b6 00             	movzbl (%rax),%eax
    19a3:	0f b6 d0             	movzbl %al,%edx
    19a6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    19aa:	0f b6 00             	movzbl (%rax),%eax
    19ad:	0f b6 c0             	movzbl %al,%eax
    19b0:	29 c2                	sub    %eax,%edx
    19b2:	89 d0                	mov    %edx,%eax
}
    19b4:	c9                   	leave
    19b5:	c3                   	ret

00000000000019b6 <strlen>:
{
    19b6:	f3 0f 1e fa          	endbr64
    19ba:	55                   	push   %rbp
    19bb:	48 89 e5             	mov    %rsp,%rbp
    19be:	48 83 ec 18          	sub    $0x18,%rsp
    19c2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  for(n = 0; s[n]; n++)
    19c6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    19cd:	eb 04                	jmp    19d3 <strlen+0x1d>
    19cf:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    19d3:	8b 45 fc             	mov    -0x4(%rbp),%eax
    19d6:	48 63 d0             	movslq %eax,%rdx
    19d9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    19dd:	48 01 d0             	add    %rdx,%rax
    19e0:	0f b6 00             	movzbl (%rax),%eax
    19e3:	84 c0                	test   %al,%al
    19e5:	75 e8                	jne    19cf <strlen+0x19>
  return n;
    19e7:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    19ea:	c9                   	leave
    19eb:	c3                   	ret

00000000000019ec <memset>:
{
    19ec:	f3 0f 1e fa          	endbr64
    19f0:	55                   	push   %rbp
    19f1:	48 89 e5             	mov    %rsp,%rbp
    19f4:	48 83 ec 10          	sub    $0x10,%rsp
    19f8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    19fc:	89 75 f4             	mov    %esi,-0xc(%rbp)
    19ff:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    1a02:	8b 55 f0             	mov    -0x10(%rbp),%edx
    1a05:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    1a08:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1a0c:	89 ce                	mov    %ecx,%esi
    1a0e:	48 89 c7             	mov    %rax,%rdi
    1a11:	48 b8 de 18 00 00 00 	movabs $0x18de,%rax
    1a18:	00 00 00 
    1a1b:	ff d0                	call   *%rax
  return dst;
    1a1d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    1a21:	c9                   	leave
    1a22:	c3                   	ret

0000000000001a23 <strchr>:
{
    1a23:	f3 0f 1e fa          	endbr64
    1a27:	55                   	push   %rbp
    1a28:	48 89 e5             	mov    %rsp,%rbp
    1a2b:	48 83 ec 10          	sub    $0x10,%rsp
    1a2f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1a33:	89 f0                	mov    %esi,%eax
    1a35:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    1a38:	eb 17                	jmp    1a51 <strchr+0x2e>
    if(*s == c)
    1a3a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1a3e:	0f b6 00             	movzbl (%rax),%eax
    1a41:	38 45 f4             	cmp    %al,-0xc(%rbp)
    1a44:	75 06                	jne    1a4c <strchr+0x29>
      return (char*)s;
    1a46:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1a4a:	eb 15                	jmp    1a61 <strchr+0x3e>
  for(; *s; s++)
    1a4c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1a51:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1a55:	0f b6 00             	movzbl (%rax),%eax
    1a58:	84 c0                	test   %al,%al
    1a5a:	75 de                	jne    1a3a <strchr+0x17>
  return 0;
    1a5c:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1a61:	c9                   	leave
    1a62:	c3                   	ret

0000000000001a63 <gets>:

char*
gets(char *buf, int max)
{
    1a63:	f3 0f 1e fa          	endbr64
    1a67:	55                   	push   %rbp
    1a68:	48 89 e5             	mov    %rsp,%rbp
    1a6b:	48 83 ec 20          	sub    $0x20,%rsp
    1a6f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1a73:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1a76:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1a7d:	eb 4f                	jmp    1ace <gets+0x6b>
    cc = read(0, &c, 1);
    1a7f:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    1a83:	ba 01 00 00 00       	mov    $0x1,%edx
    1a88:	48 89 c6             	mov    %rax,%rsi
    1a8b:	bf 00 00 00 00       	mov    $0x0,%edi
    1a90:	48 b8 48 1c 00 00 00 	movabs $0x1c48,%rax
    1a97:	00 00 00 
    1a9a:	ff d0                	call   *%rax
    1a9c:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    1a9f:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1aa3:	7e 36                	jle    1adb <gets+0x78>
      break;
    buf[i++] = c;
    1aa5:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1aa8:	8d 50 01             	lea    0x1(%rax),%edx
    1aab:	89 55 fc             	mov    %edx,-0x4(%rbp)
    1aae:	48 63 d0             	movslq %eax,%rdx
    1ab1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1ab5:	48 01 c2             	add    %rax,%rdx
    1ab8:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1abc:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    1abe:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1ac2:	3c 0a                	cmp    $0xa,%al
    1ac4:	74 16                	je     1adc <gets+0x79>
    1ac6:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1aca:	3c 0d                	cmp    $0xd,%al
    1acc:	74 0e                	je     1adc <gets+0x79>
  for(i=0; i+1 < max; ){
    1ace:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1ad1:	83 c0 01             	add    $0x1,%eax
    1ad4:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    1ad7:	7f a6                	jg     1a7f <gets+0x1c>
    1ad9:	eb 01                	jmp    1adc <gets+0x79>
      break;
    1adb:	90                   	nop
      break;
  }
  buf[i] = '\0';
    1adc:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1adf:	48 63 d0             	movslq %eax,%rdx
    1ae2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1ae6:	48 01 d0             	add    %rdx,%rax
    1ae9:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    1aec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    1af0:	c9                   	leave
    1af1:	c3                   	ret

0000000000001af2 <stat>:

int
stat(char *n, struct stat *st)
{
    1af2:	f3 0f 1e fa          	endbr64
    1af6:	55                   	push   %rbp
    1af7:	48 89 e5             	mov    %rsp,%rbp
    1afa:	48 83 ec 20          	sub    $0x20,%rsp
    1afe:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1b02:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1b06:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1b0a:	be 00 00 00 00       	mov    $0x0,%esi
    1b0f:	48 89 c7             	mov    %rax,%rdi
    1b12:	48 b8 89 1c 00 00 00 	movabs $0x1c89,%rax
    1b19:	00 00 00 
    1b1c:	ff d0                	call   *%rax
    1b1e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    1b21:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1b25:	79 07                	jns    1b2e <stat+0x3c>
    return -1;
    1b27:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1b2c:	eb 2f                	jmp    1b5d <stat+0x6b>
  r = fstat(fd, st);
    1b2e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1b32:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1b35:	48 89 d6             	mov    %rdx,%rsi
    1b38:	89 c7                	mov    %eax,%edi
    1b3a:	48 b8 b0 1c 00 00 00 	movabs $0x1cb0,%rax
    1b41:	00 00 00 
    1b44:	ff d0                	call   *%rax
    1b46:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    1b49:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1b4c:	89 c7                	mov    %eax,%edi
    1b4e:	48 b8 62 1c 00 00 00 	movabs $0x1c62,%rax
    1b55:	00 00 00 
    1b58:	ff d0                	call   *%rax
  return r;
    1b5a:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    1b5d:	c9                   	leave
    1b5e:	c3                   	ret

0000000000001b5f <atoi>:

int
atoi(const char *s)
{
    1b5f:	f3 0f 1e fa          	endbr64
    1b63:	55                   	push   %rbp
    1b64:	48 89 e5             	mov    %rsp,%rbp
    1b67:	48 83 ec 18          	sub    $0x18,%rsp
    1b6b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    1b6f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1b76:	eb 28                	jmp    1ba0 <atoi+0x41>
    n = n*10 + *s++ - '0';
    1b78:	8b 55 fc             	mov    -0x4(%rbp),%edx
    1b7b:	89 d0                	mov    %edx,%eax
    1b7d:	c1 e0 02             	shl    $0x2,%eax
    1b80:	01 d0                	add    %edx,%eax
    1b82:	01 c0                	add    %eax,%eax
    1b84:	89 c1                	mov    %eax,%ecx
    1b86:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1b8a:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1b8e:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    1b92:	0f b6 00             	movzbl (%rax),%eax
    1b95:	0f be c0             	movsbl %al,%eax
    1b98:	01 c8                	add    %ecx,%eax
    1b9a:	83 e8 30             	sub    $0x30,%eax
    1b9d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1ba0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1ba4:	0f b6 00             	movzbl (%rax),%eax
    1ba7:	3c 2f                	cmp    $0x2f,%al
    1ba9:	7e 0b                	jle    1bb6 <atoi+0x57>
    1bab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1baf:	0f b6 00             	movzbl (%rax),%eax
    1bb2:	3c 39                	cmp    $0x39,%al
    1bb4:	7e c2                	jle    1b78 <atoi+0x19>
  return n;
    1bb6:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    1bb9:	c9                   	leave
    1bba:	c3                   	ret

0000000000001bbb <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1bbb:	f3 0f 1e fa          	endbr64
    1bbf:	55                   	push   %rbp
    1bc0:	48 89 e5             	mov    %rsp,%rbp
    1bc3:	48 83 ec 28          	sub    $0x28,%rsp
    1bc7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1bcb:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    1bcf:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    1bd2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1bd6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    1bda:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1bde:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    1be2:	eb 1d                	jmp    1c01 <memmove+0x46>
    *dst++ = *src++;
    1be4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1be8:	48 8d 42 01          	lea    0x1(%rdx),%rax
    1bec:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1bf0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bf4:	48 8d 48 01          	lea    0x1(%rax),%rcx
    1bf8:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    1bfc:	0f b6 12             	movzbl (%rdx),%edx
    1bff:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    1c01:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1c04:	8d 50 ff             	lea    -0x1(%rax),%edx
    1c07:	89 55 dc             	mov    %edx,-0x24(%rbp)
    1c0a:	85 c0                	test   %eax,%eax
    1c0c:	7f d6                	jg     1be4 <memmove+0x29>
  return vdst;
    1c0e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    1c12:	c9                   	leave
    1c13:	c3                   	ret

0000000000001c14 <fork>:
    1c14:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    1c1b:	49 89 ca             	mov    %rcx,%r10
    1c1e:	0f 05                	syscall
    1c20:	c3                   	ret

0000000000001c21 <exit>:
    1c21:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    1c28:	49 89 ca             	mov    %rcx,%r10
    1c2b:	0f 05                	syscall
    1c2d:	c3                   	ret

0000000000001c2e <wait>:
    1c2e:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    1c35:	49 89 ca             	mov    %rcx,%r10
    1c38:	0f 05                	syscall
    1c3a:	c3                   	ret

0000000000001c3b <pipe>:
    1c3b:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    1c42:	49 89 ca             	mov    %rcx,%r10
    1c45:	0f 05                	syscall
    1c47:	c3                   	ret

0000000000001c48 <read>:
    1c48:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    1c4f:	49 89 ca             	mov    %rcx,%r10
    1c52:	0f 05                	syscall
    1c54:	c3                   	ret

0000000000001c55 <write>:
    1c55:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    1c5c:	49 89 ca             	mov    %rcx,%r10
    1c5f:	0f 05                	syscall
    1c61:	c3                   	ret

0000000000001c62 <close>:
    1c62:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    1c69:	49 89 ca             	mov    %rcx,%r10
    1c6c:	0f 05                	syscall
    1c6e:	c3                   	ret

0000000000001c6f <kill>:
    1c6f:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    1c76:	49 89 ca             	mov    %rcx,%r10
    1c79:	0f 05                	syscall
    1c7b:	c3                   	ret

0000000000001c7c <exec>:
    1c7c:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    1c83:	49 89 ca             	mov    %rcx,%r10
    1c86:	0f 05                	syscall
    1c88:	c3                   	ret

0000000000001c89 <open>:
    1c89:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    1c90:	49 89 ca             	mov    %rcx,%r10
    1c93:	0f 05                	syscall
    1c95:	c3                   	ret

0000000000001c96 <mknod>:
    1c96:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    1c9d:	49 89 ca             	mov    %rcx,%r10
    1ca0:	0f 05                	syscall
    1ca2:	c3                   	ret

0000000000001ca3 <unlink>:
    1ca3:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    1caa:	49 89 ca             	mov    %rcx,%r10
    1cad:	0f 05                	syscall
    1caf:	c3                   	ret

0000000000001cb0 <fstat>:
    1cb0:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    1cb7:	49 89 ca             	mov    %rcx,%r10
    1cba:	0f 05                	syscall
    1cbc:	c3                   	ret

0000000000001cbd <link>:
    1cbd:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    1cc4:	49 89 ca             	mov    %rcx,%r10
    1cc7:	0f 05                	syscall
    1cc9:	c3                   	ret

0000000000001cca <mkdir>:
    1cca:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    1cd1:	49 89 ca             	mov    %rcx,%r10
    1cd4:	0f 05                	syscall
    1cd6:	c3                   	ret

0000000000001cd7 <chdir>:
    1cd7:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    1cde:	49 89 ca             	mov    %rcx,%r10
    1ce1:	0f 05                	syscall
    1ce3:	c3                   	ret

0000000000001ce4 <dup>:
    1ce4:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    1ceb:	49 89 ca             	mov    %rcx,%r10
    1cee:	0f 05                	syscall
    1cf0:	c3                   	ret

0000000000001cf1 <getpid>:
    1cf1:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    1cf8:	49 89 ca             	mov    %rcx,%r10
    1cfb:	0f 05                	syscall
    1cfd:	c3                   	ret

0000000000001cfe <sbrk>:
    1cfe:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    1d05:	49 89 ca             	mov    %rcx,%r10
    1d08:	0f 05                	syscall
    1d0a:	c3                   	ret

0000000000001d0b <sleep>:
    1d0b:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    1d12:	49 89 ca             	mov    %rcx,%r10
    1d15:	0f 05                	syscall
    1d17:	c3                   	ret

0000000000001d18 <uptime>:
    1d18:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    1d1f:	49 89 ca             	mov    %rcx,%r10
    1d22:	0f 05                	syscall
    1d24:	c3                   	ret

0000000000001d25 <send>:
    1d25:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    1d2c:	49 89 ca             	mov    %rcx,%r10
    1d2f:	0f 05                	syscall
    1d31:	c3                   	ret

0000000000001d32 <recv>:
    1d32:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    1d39:	49 89 ca             	mov    %rcx,%r10
    1d3c:	0f 05                	syscall
    1d3e:	c3                   	ret

0000000000001d3f <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    1d3f:	f3 0f 1e fa          	endbr64
    1d43:	55                   	push   %rbp
    1d44:	48 89 e5             	mov    %rsp,%rbp
    1d47:	48 83 ec 10          	sub    $0x10,%rsp
    1d4b:	89 7d fc             	mov    %edi,-0x4(%rbp)
    1d4e:	89 f0                	mov    %esi,%eax
    1d50:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    1d53:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    1d57:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1d5a:	ba 01 00 00 00       	mov    $0x1,%edx
    1d5f:	48 89 ce             	mov    %rcx,%rsi
    1d62:	89 c7                	mov    %eax,%edi
    1d64:	48 b8 55 1c 00 00 00 	movabs $0x1c55,%rax
    1d6b:	00 00 00 
    1d6e:	ff d0                	call   *%rax
}
    1d70:	90                   	nop
    1d71:	c9                   	leave
    1d72:	c3                   	ret

0000000000001d73 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    1d73:	f3 0f 1e fa          	endbr64
    1d77:	55                   	push   %rbp
    1d78:	48 89 e5             	mov    %rsp,%rbp
    1d7b:	48 83 ec 20          	sub    $0x20,%rsp
    1d7f:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1d82:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1d86:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1d8d:	eb 35                	jmp    1dc4 <print_x64+0x51>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    1d8f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1d93:	48 c1 e8 3c          	shr    $0x3c,%rax
    1d97:	48 ba e0 27 00 00 00 	movabs $0x27e0,%rdx
    1d9e:	00 00 00 
    1da1:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1da5:	0f be d0             	movsbl %al,%edx
    1da8:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1dab:	89 d6                	mov    %edx,%esi
    1dad:	89 c7                	mov    %eax,%edi
    1daf:	48 b8 3f 1d 00 00 00 	movabs $0x1d3f,%rax
    1db6:	00 00 00 
    1db9:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1dbb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1dbf:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    1dc4:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1dc7:	83 f8 0f             	cmp    $0xf,%eax
    1dca:	76 c3                	jbe    1d8f <print_x64+0x1c>
}
    1dcc:	90                   	nop
    1dcd:	90                   	nop
    1dce:	c9                   	leave
    1dcf:	c3                   	ret

0000000000001dd0 <print_x32>:

  static void
print_x32(int fd, uint x)
{
    1dd0:	f3 0f 1e fa          	endbr64
    1dd4:	55                   	push   %rbp
    1dd5:	48 89 e5             	mov    %rsp,%rbp
    1dd8:	48 83 ec 20          	sub    $0x20,%rsp
    1ddc:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1ddf:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1de2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1de9:	eb 36                	jmp    1e21 <print_x32+0x51>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    1deb:	8b 45 e8             	mov    -0x18(%rbp),%eax
    1dee:	c1 e8 1c             	shr    $0x1c,%eax
    1df1:	89 c2                	mov    %eax,%edx
    1df3:	48 b8 e0 27 00 00 00 	movabs $0x27e0,%rax
    1dfa:	00 00 00 
    1dfd:	89 d2                	mov    %edx,%edx
    1dff:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    1e03:	0f be d0             	movsbl %al,%edx
    1e06:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1e09:	89 d6                	mov    %edx,%esi
    1e0b:	89 c7                	mov    %eax,%edi
    1e0d:	48 b8 3f 1d 00 00 00 	movabs $0x1d3f,%rax
    1e14:	00 00 00 
    1e17:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1e19:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1e1d:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    1e21:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1e24:	83 f8 07             	cmp    $0x7,%eax
    1e27:	76 c2                	jbe    1deb <print_x32+0x1b>
}
    1e29:	90                   	nop
    1e2a:	90                   	nop
    1e2b:	c9                   	leave
    1e2c:	c3                   	ret

0000000000001e2d <print_d>:

  static void
print_d(int fd, int v)
{
    1e2d:	f3 0f 1e fa          	endbr64
    1e31:	55                   	push   %rbp
    1e32:	48 89 e5             	mov    %rsp,%rbp
    1e35:	48 83 ec 30          	sub    $0x30,%rsp
    1e39:	89 7d dc             	mov    %edi,-0x24(%rbp)
    1e3c:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    1e3f:	8b 45 d8             	mov    -0x28(%rbp),%eax
    1e42:	48 98                	cltq
    1e44:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    1e48:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1e4c:	79 04                	jns    1e52 <print_d+0x25>
    x = -x;
    1e4e:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    1e52:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    1e59:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1e5d:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1e64:	66 66 66 
    1e67:	48 89 c8             	mov    %rcx,%rax
    1e6a:	48 f7 ea             	imul   %rdx
    1e6d:	48 c1 fa 02          	sar    $0x2,%rdx
    1e71:	48 89 c8             	mov    %rcx,%rax
    1e74:	48 c1 f8 3f          	sar    $0x3f,%rax
    1e78:	48 29 c2             	sub    %rax,%rdx
    1e7b:	48 89 d0             	mov    %rdx,%rax
    1e7e:	48 c1 e0 02          	shl    $0x2,%rax
    1e82:	48 01 d0             	add    %rdx,%rax
    1e85:	48 01 c0             	add    %rax,%rax
    1e88:	48 29 c1             	sub    %rax,%rcx
    1e8b:	48 89 ca             	mov    %rcx,%rdx
    1e8e:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1e91:	8d 48 01             	lea    0x1(%rax),%ecx
    1e94:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    1e97:	48 b9 e0 27 00 00 00 	movabs $0x27e0,%rcx
    1e9e:	00 00 00 
    1ea1:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    1ea5:	48 98                	cltq
    1ea7:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    1eab:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1eaf:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1eb6:	66 66 66 
    1eb9:	48 89 c8             	mov    %rcx,%rax
    1ebc:	48 f7 ea             	imul   %rdx
    1ebf:	48 89 d0             	mov    %rdx,%rax
    1ec2:	48 c1 f8 02          	sar    $0x2,%rax
    1ec6:	48 c1 f9 3f          	sar    $0x3f,%rcx
    1eca:	48 89 ca             	mov    %rcx,%rdx
    1ecd:	48 29 d0             	sub    %rdx,%rax
    1ed0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    1ed4:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1ed9:	0f 85 7a ff ff ff    	jne    1e59 <print_d+0x2c>

  if (v < 0)
    1edf:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1ee3:	79 32                	jns    1f17 <print_d+0xea>
    buf[i++] = '-';
    1ee5:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1ee8:	8d 50 01             	lea    0x1(%rax),%edx
    1eeb:	89 55 f4             	mov    %edx,-0xc(%rbp)
    1eee:	48 98                	cltq
    1ef0:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    1ef5:	eb 20                	jmp    1f17 <print_d+0xea>
    putc(fd, buf[i]);
    1ef7:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1efa:	48 98                	cltq
    1efc:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    1f01:	0f be d0             	movsbl %al,%edx
    1f04:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1f07:	89 d6                	mov    %edx,%esi
    1f09:	89 c7                	mov    %eax,%edi
    1f0b:	48 b8 3f 1d 00 00 00 	movabs $0x1d3f,%rax
    1f12:	00 00 00 
    1f15:	ff d0                	call   *%rax
  while (--i >= 0)
    1f17:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    1f1b:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1f1f:	79 d6                	jns    1ef7 <print_d+0xca>
}
    1f21:	90                   	nop
    1f22:	90                   	nop
    1f23:	c9                   	leave
    1f24:	c3                   	ret

0000000000001f25 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    1f25:	f3 0f 1e fa          	endbr64
    1f29:	55                   	push   %rbp
    1f2a:	48 89 e5             	mov    %rsp,%rbp
    1f2d:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    1f34:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    1f3a:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    1f41:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    1f48:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    1f4f:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    1f56:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    1f5d:	84 c0                	test   %al,%al
    1f5f:	74 20                	je     1f81 <printf+0x5c>
    1f61:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    1f65:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    1f69:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    1f6d:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    1f71:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    1f75:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    1f79:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    1f7d:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    1f81:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    1f88:	00 00 00 
    1f8b:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    1f92:	00 00 00 
    1f95:	48 8d 45 10          	lea    0x10(%rbp),%rax
    1f99:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    1fa0:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    1fa7:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1fae:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    1fb5:	00 00 00 
    1fb8:	e9 41 03 00 00       	jmp    22fe <printf+0x3d9>
    if (c != '%') {
    1fbd:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1fc4:	74 24                	je     1fea <printf+0xc5>
      putc(fd, c);
    1fc6:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1fcc:	0f be d0             	movsbl %al,%edx
    1fcf:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1fd5:	89 d6                	mov    %edx,%esi
    1fd7:	89 c7                	mov    %eax,%edi
    1fd9:	48 b8 3f 1d 00 00 00 	movabs $0x1d3f,%rax
    1fe0:	00 00 00 
    1fe3:	ff d0                	call   *%rax
      continue;
    1fe5:	e9 0d 03 00 00       	jmp    22f7 <printf+0x3d2>
    }
    c = fmt[++i] & 0xff;
    1fea:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1ff1:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1ff7:	48 63 d0             	movslq %eax,%rdx
    1ffa:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    2001:	48 01 d0             	add    %rdx,%rax
    2004:	0f b6 00             	movzbl (%rax),%eax
    2007:	0f be c0             	movsbl %al,%eax
    200a:	25 ff 00 00 00       	and    $0xff,%eax
    200f:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    2015:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    201c:	0f 84 0f 03 00 00    	je     2331 <printf+0x40c>
      break;
    switch(c) {
    2022:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    2029:	0f 84 74 02 00 00    	je     22a3 <printf+0x37e>
    202f:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    2036:	0f 8c 82 02 00 00    	jl     22be <printf+0x399>
    203c:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    2043:	0f 8f 75 02 00 00    	jg     22be <printf+0x399>
    2049:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    2050:	0f 8c 68 02 00 00    	jl     22be <printf+0x399>
    2056:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    205c:	83 e8 63             	sub    $0x63,%eax
    205f:	83 f8 15             	cmp    $0x15,%eax
    2062:	0f 87 56 02 00 00    	ja     22be <printf+0x399>
    2068:	89 c0                	mov    %eax,%eax
    206a:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    2071:	00 
    2072:	48 b8 28 27 00 00 00 	movabs $0x2728,%rax
    2079:	00 00 00 
    207c:	48 01 d0             	add    %rdx,%rax
    207f:	48 8b 00             	mov    (%rax),%rax
    2082:	3e ff e0             	notrack jmp *%rax
    case 'c':
      putc(fd, va_arg(ap, int));
    2085:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    208b:	83 f8 2f             	cmp    $0x2f,%eax
    208e:	77 23                	ja     20b3 <printf+0x18e>
    2090:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    2097:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    209d:	89 d2                	mov    %edx,%edx
    209f:	48 01 d0             	add    %rdx,%rax
    20a2:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    20a8:	83 c2 08             	add    $0x8,%edx
    20ab:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    20b1:	eb 12                	jmp    20c5 <printf+0x1a0>
    20b3:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    20ba:	48 8d 50 08          	lea    0x8(%rax),%rdx
    20be:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    20c5:	8b 00                	mov    (%rax),%eax
    20c7:	0f be d0             	movsbl %al,%edx
    20ca:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    20d0:	89 d6                	mov    %edx,%esi
    20d2:	89 c7                	mov    %eax,%edi
    20d4:	48 b8 3f 1d 00 00 00 	movabs $0x1d3f,%rax
    20db:	00 00 00 
    20de:	ff d0                	call   *%rax
      break;
    20e0:	e9 12 02 00 00       	jmp    22f7 <printf+0x3d2>
    case 'd':
      print_d(fd, va_arg(ap, int));
    20e5:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    20eb:	83 f8 2f             	cmp    $0x2f,%eax
    20ee:	77 23                	ja     2113 <printf+0x1ee>
    20f0:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    20f7:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    20fd:	89 d2                	mov    %edx,%edx
    20ff:	48 01 d0             	add    %rdx,%rax
    2102:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    2108:	83 c2 08             	add    $0x8,%edx
    210b:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    2111:	eb 12                	jmp    2125 <printf+0x200>
    2113:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    211a:	48 8d 50 08          	lea    0x8(%rax),%rdx
    211e:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    2125:	8b 10                	mov    (%rax),%edx
    2127:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    212d:	89 d6                	mov    %edx,%esi
    212f:	89 c7                	mov    %eax,%edi
    2131:	48 b8 2d 1e 00 00 00 	movabs $0x1e2d,%rax
    2138:	00 00 00 
    213b:	ff d0                	call   *%rax
      break;
    213d:	e9 b5 01 00 00       	jmp    22f7 <printf+0x3d2>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    2142:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    2148:	83 f8 2f             	cmp    $0x2f,%eax
    214b:	77 23                	ja     2170 <printf+0x24b>
    214d:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    2154:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    215a:	89 d2                	mov    %edx,%edx
    215c:	48 01 d0             	add    %rdx,%rax
    215f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    2165:	83 c2 08             	add    $0x8,%edx
    2168:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    216e:	eb 12                	jmp    2182 <printf+0x25d>
    2170:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    2177:	48 8d 50 08          	lea    0x8(%rax),%rdx
    217b:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    2182:	8b 10                	mov    (%rax),%edx
    2184:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    218a:	89 d6                	mov    %edx,%esi
    218c:	89 c7                	mov    %eax,%edi
    218e:	48 b8 d0 1d 00 00 00 	movabs $0x1dd0,%rax
    2195:	00 00 00 
    2198:	ff d0                	call   *%rax
      break;
    219a:	e9 58 01 00 00       	jmp    22f7 <printf+0x3d2>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    219f:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    21a5:	83 f8 2f             	cmp    $0x2f,%eax
    21a8:	77 23                	ja     21cd <printf+0x2a8>
    21aa:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    21b1:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    21b7:	89 d2                	mov    %edx,%edx
    21b9:	48 01 d0             	add    %rdx,%rax
    21bc:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    21c2:	83 c2 08             	add    $0x8,%edx
    21c5:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    21cb:	eb 12                	jmp    21df <printf+0x2ba>
    21cd:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    21d4:	48 8d 50 08          	lea    0x8(%rax),%rdx
    21d8:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    21df:	48 8b 10             	mov    (%rax),%rdx
    21e2:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    21e8:	48 89 d6             	mov    %rdx,%rsi
    21eb:	89 c7                	mov    %eax,%edi
    21ed:	48 b8 73 1d 00 00 00 	movabs $0x1d73,%rax
    21f4:	00 00 00 
    21f7:	ff d0                	call   *%rax
      break;
    21f9:	e9 f9 00 00 00       	jmp    22f7 <printf+0x3d2>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    21fe:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    2204:	83 f8 2f             	cmp    $0x2f,%eax
    2207:	77 23                	ja     222c <printf+0x307>
    2209:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    2210:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    2216:	89 d2                	mov    %edx,%edx
    2218:	48 01 d0             	add    %rdx,%rax
    221b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    2221:	83 c2 08             	add    $0x8,%edx
    2224:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    222a:	eb 12                	jmp    223e <printf+0x319>
    222c:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    2233:	48 8d 50 08          	lea    0x8(%rax),%rdx
    2237:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    223e:	48 8b 00             	mov    (%rax),%rax
    2241:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    2248:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    224f:	00 
    2250:	75 41                	jne    2293 <printf+0x36e>
        s = "(null)";
    2252:	48 b8 20 27 00 00 00 	movabs $0x2720,%rax
    2259:	00 00 00 
    225c:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    2263:	eb 2e                	jmp    2293 <printf+0x36e>
        putc(fd, *(s++));
    2265:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    226c:	48 8d 50 01          	lea    0x1(%rax),%rdx
    2270:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    2277:	0f b6 00             	movzbl (%rax),%eax
    227a:	0f be d0             	movsbl %al,%edx
    227d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    2283:	89 d6                	mov    %edx,%esi
    2285:	89 c7                	mov    %eax,%edi
    2287:	48 b8 3f 1d 00 00 00 	movabs $0x1d3f,%rax
    228e:	00 00 00 
    2291:	ff d0                	call   *%rax
      while (*s)
    2293:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    229a:	0f b6 00             	movzbl (%rax),%eax
    229d:	84 c0                	test   %al,%al
    229f:	75 c4                	jne    2265 <printf+0x340>
      break;
    22a1:	eb 54                	jmp    22f7 <printf+0x3d2>
    case '%':
      putc(fd, '%');
    22a3:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    22a9:	be 25 00 00 00       	mov    $0x25,%esi
    22ae:	89 c7                	mov    %eax,%edi
    22b0:	48 b8 3f 1d 00 00 00 	movabs $0x1d3f,%rax
    22b7:	00 00 00 
    22ba:	ff d0                	call   *%rax
      break;
    22bc:	eb 39                	jmp    22f7 <printf+0x3d2>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    22be:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    22c4:	be 25 00 00 00       	mov    $0x25,%esi
    22c9:	89 c7                	mov    %eax,%edi
    22cb:	48 b8 3f 1d 00 00 00 	movabs $0x1d3f,%rax
    22d2:	00 00 00 
    22d5:	ff d0                	call   *%rax
      putc(fd, c);
    22d7:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    22dd:	0f be d0             	movsbl %al,%edx
    22e0:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    22e6:	89 d6                	mov    %edx,%esi
    22e8:	89 c7                	mov    %eax,%edi
    22ea:	48 b8 3f 1d 00 00 00 	movabs $0x1d3f,%rax
    22f1:	00 00 00 
    22f4:	ff d0                	call   *%rax
      break;
    22f6:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    22f7:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    22fe:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    2304:	48 63 d0             	movslq %eax,%rdx
    2307:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    230e:	48 01 d0             	add    %rdx,%rax
    2311:	0f b6 00             	movzbl (%rax),%eax
    2314:	0f be c0             	movsbl %al,%eax
    2317:	25 ff 00 00 00       	and    $0xff,%eax
    231c:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    2322:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    2329:	0f 85 8e fc ff ff    	jne    1fbd <printf+0x98>
    }
  }
}
    232f:	eb 01                	jmp    2332 <printf+0x40d>
      break;
    2331:	90                   	nop
}
    2332:	90                   	nop
    2333:	c9                   	leave
    2334:	c3                   	ret

0000000000002335 <free>:
    2335:	55                   	push   %rbp
    2336:	48 89 e5             	mov    %rsp,%rbp
    2339:	48 83 ec 18          	sub    $0x18,%rsp
    233d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    2341:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    2345:	48 83 e8 10          	sub    $0x10,%rax
    2349:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    234d:	48 b8 10 28 00 00 00 	movabs $0x2810,%rax
    2354:	00 00 00 
    2357:	48 8b 00             	mov    (%rax),%rax
    235a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    235e:	eb 2f                	jmp    238f <free+0x5a>
    2360:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2364:	48 8b 00             	mov    (%rax),%rax
    2367:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    236b:	72 17                	jb     2384 <free+0x4f>
    236d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2371:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    2375:	72 2f                	jb     23a6 <free+0x71>
    2377:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    237b:	48 8b 00             	mov    (%rax),%rax
    237e:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    2382:	72 22                	jb     23a6 <free+0x71>
    2384:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2388:	48 8b 00             	mov    (%rax),%rax
    238b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    238f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2393:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    2397:	73 c7                	jae    2360 <free+0x2b>
    2399:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    239d:	48 8b 00             	mov    (%rax),%rax
    23a0:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    23a4:	73 ba                	jae    2360 <free+0x2b>
    23a6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    23aa:	8b 40 08             	mov    0x8(%rax),%eax
    23ad:	89 c0                	mov    %eax,%eax
    23af:	48 c1 e0 04          	shl    $0x4,%rax
    23b3:	48 89 c2             	mov    %rax,%rdx
    23b6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    23ba:	48 01 c2             	add    %rax,%rdx
    23bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    23c1:	48 8b 00             	mov    (%rax),%rax
    23c4:	48 39 c2             	cmp    %rax,%rdx
    23c7:	75 2d                	jne    23f6 <free+0xc1>
    23c9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    23cd:	8b 50 08             	mov    0x8(%rax),%edx
    23d0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    23d4:	48 8b 00             	mov    (%rax),%rax
    23d7:	8b 40 08             	mov    0x8(%rax),%eax
    23da:	01 c2                	add    %eax,%edx
    23dc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    23e0:	89 50 08             	mov    %edx,0x8(%rax)
    23e3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    23e7:	48 8b 00             	mov    (%rax),%rax
    23ea:	48 8b 10             	mov    (%rax),%rdx
    23ed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    23f1:	48 89 10             	mov    %rdx,(%rax)
    23f4:	eb 0e                	jmp    2404 <free+0xcf>
    23f6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    23fa:	48 8b 10             	mov    (%rax),%rdx
    23fd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2401:	48 89 10             	mov    %rdx,(%rax)
    2404:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2408:	8b 40 08             	mov    0x8(%rax),%eax
    240b:	89 c0                	mov    %eax,%eax
    240d:	48 c1 e0 04          	shl    $0x4,%rax
    2411:	48 89 c2             	mov    %rax,%rdx
    2414:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2418:	48 01 d0             	add    %rdx,%rax
    241b:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    241f:	75 27                	jne    2448 <free+0x113>
    2421:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2425:	8b 50 08             	mov    0x8(%rax),%edx
    2428:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    242c:	8b 40 08             	mov    0x8(%rax),%eax
    242f:	01 c2                	add    %eax,%edx
    2431:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2435:	89 50 08             	mov    %edx,0x8(%rax)
    2438:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    243c:	48 8b 10             	mov    (%rax),%rdx
    243f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2443:	48 89 10             	mov    %rdx,(%rax)
    2446:	eb 0b                	jmp    2453 <free+0x11e>
    2448:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    244c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    2450:	48 89 10             	mov    %rdx,(%rax)
    2453:	48 ba 10 28 00 00 00 	movabs $0x2810,%rdx
    245a:	00 00 00 
    245d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2461:	48 89 02             	mov    %rax,(%rdx)
    2464:	90                   	nop
    2465:	c9                   	leave
    2466:	c3                   	ret

0000000000002467 <morecore>:
    2467:	55                   	push   %rbp
    2468:	48 89 e5             	mov    %rsp,%rbp
    246b:	48 83 ec 20          	sub    $0x20,%rsp
    246f:	89 7d ec             	mov    %edi,-0x14(%rbp)
    2472:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    2479:	77 07                	ja     2482 <morecore+0x1b>
    247b:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
    2482:	8b 45 ec             	mov    -0x14(%rbp),%eax
    2485:	48 c1 e0 04          	shl    $0x4,%rax
    2489:	48 89 c7             	mov    %rax,%rdi
    248c:	48 b8 fe 1c 00 00 00 	movabs $0x1cfe,%rax
    2493:	00 00 00 
    2496:	ff d0                	call   *%rax
    2498:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    249c:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    24a1:	75 07                	jne    24aa <morecore+0x43>
    24a3:	b8 00 00 00 00       	mov    $0x0,%eax
    24a8:	eb 36                	jmp    24e0 <morecore+0x79>
    24aa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    24ae:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    24b2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    24b6:	8b 55 ec             	mov    -0x14(%rbp),%edx
    24b9:	89 50 08             	mov    %edx,0x8(%rax)
    24bc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    24c0:	48 83 c0 10          	add    $0x10,%rax
    24c4:	48 89 c7             	mov    %rax,%rdi
    24c7:	48 b8 35 23 00 00 00 	movabs $0x2335,%rax
    24ce:	00 00 00 
    24d1:	ff d0                	call   *%rax
    24d3:	48 b8 10 28 00 00 00 	movabs $0x2810,%rax
    24da:	00 00 00 
    24dd:	48 8b 00             	mov    (%rax),%rax
    24e0:	c9                   	leave
    24e1:	c3                   	ret

00000000000024e2 <malloc>:
    24e2:	55                   	push   %rbp
    24e3:	48 89 e5             	mov    %rsp,%rbp
    24e6:	48 83 ec 30          	sub    $0x30,%rsp
    24ea:	89 7d dc             	mov    %edi,-0x24(%rbp)
    24ed:	8b 45 dc             	mov    -0x24(%rbp),%eax
    24f0:	48 83 c0 0f          	add    $0xf,%rax
    24f4:	48 c1 e8 04          	shr    $0x4,%rax
    24f8:	83 c0 01             	add    $0x1,%eax
    24fb:	89 45 ec             	mov    %eax,-0x14(%rbp)
    24fe:	48 b8 10 28 00 00 00 	movabs $0x2810,%rax
    2505:	00 00 00 
    2508:	48 8b 00             	mov    (%rax),%rax
    250b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    250f:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    2514:	75 4a                	jne    2560 <malloc+0x7e>
    2516:	48 b8 00 28 00 00 00 	movabs $0x2800,%rax
    251d:	00 00 00 
    2520:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    2524:	48 ba 10 28 00 00 00 	movabs $0x2810,%rdx
    252b:	00 00 00 
    252e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2532:	48 89 02             	mov    %rax,(%rdx)
    2535:	48 b8 10 28 00 00 00 	movabs $0x2810,%rax
    253c:	00 00 00 
    253f:	48 8b 00             	mov    (%rax),%rax
    2542:	48 ba 00 28 00 00 00 	movabs $0x2800,%rdx
    2549:	00 00 00 
    254c:	48 89 02             	mov    %rax,(%rdx)
    254f:	48 b8 00 28 00 00 00 	movabs $0x2800,%rax
    2556:	00 00 00 
    2559:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
    2560:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2564:	48 8b 00             	mov    (%rax),%rax
    2567:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    256b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    256f:	8b 40 08             	mov    0x8(%rax),%eax
    2572:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    2575:	72 65                	jb     25dc <malloc+0xfa>
    2577:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    257b:	8b 40 08             	mov    0x8(%rax),%eax
    257e:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    2581:	75 10                	jne    2593 <malloc+0xb1>
    2583:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2587:	48 8b 10             	mov    (%rax),%rdx
    258a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    258e:	48 89 10             	mov    %rdx,(%rax)
    2591:	eb 2e                	jmp    25c1 <malloc+0xdf>
    2593:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2597:	8b 40 08             	mov    0x8(%rax),%eax
    259a:	2b 45 ec             	sub    -0x14(%rbp),%eax
    259d:	89 c2                	mov    %eax,%edx
    259f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    25a3:	89 50 08             	mov    %edx,0x8(%rax)
    25a6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    25aa:	8b 40 08             	mov    0x8(%rax),%eax
    25ad:	89 c0                	mov    %eax,%eax
    25af:	48 c1 e0 04          	shl    $0x4,%rax
    25b3:	48 01 45 f8          	add    %rax,-0x8(%rbp)
    25b7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    25bb:	8b 55 ec             	mov    -0x14(%rbp),%edx
    25be:	89 50 08             	mov    %edx,0x8(%rax)
    25c1:	48 ba 10 28 00 00 00 	movabs $0x2810,%rdx
    25c8:	00 00 00 
    25cb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    25cf:	48 89 02             	mov    %rax,(%rdx)
    25d2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    25d6:	48 83 c0 10          	add    $0x10,%rax
    25da:	eb 4e                	jmp    262a <malloc+0x148>
    25dc:	48 b8 10 28 00 00 00 	movabs $0x2810,%rax
    25e3:	00 00 00 
    25e6:	48 8b 00             	mov    (%rax),%rax
    25e9:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    25ed:	75 23                	jne    2612 <malloc+0x130>
    25ef:	8b 45 ec             	mov    -0x14(%rbp),%eax
    25f2:	89 c7                	mov    %eax,%edi
    25f4:	48 b8 67 24 00 00 00 	movabs $0x2467,%rax
    25fb:	00 00 00 
    25fe:	ff d0                	call   *%rax
    2600:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    2604:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    2609:	75 07                	jne    2612 <malloc+0x130>
    260b:	b8 00 00 00 00       	mov    $0x0,%eax
    2610:	eb 18                	jmp    262a <malloc+0x148>
    2612:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2616:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    261a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    261e:	48 8b 00             	mov    (%rax),%rax
    2621:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    2625:	e9 41 ff ff ff       	jmp    256b <malloc+0x89>
    262a:	c9                   	leave
    262b:	c3                   	ret
