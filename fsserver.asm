
_fsserver:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <alloc_remote_fd>:

static struct fd_entry fd_table[MAX_REMOTE_FDS];

static int
alloc_remote_fd(int owner_pid, int real_fd)
{
    1000:	f3 0f 1e fa          	endbr64
    1004:	55                   	push   %rbp
    1005:	48 89 e5             	mov    %rsp,%rbp
    1008:	48 83 ec 18          	sub    $0x18,%rsp
    100c:	89 7d ec             	mov    %edi,-0x14(%rbp)
    100f:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for(i = 0; i < MAX_REMOTE_FDS; i++){
    1012:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1019:	e9 a7 00 00 00       	jmp    10c5 <alloc_remote_fd+0xc5>
    if(!fd_table[i].used){
    101e:	48 b9 80 27 00 00 00 	movabs $0x2780,%rcx
    1025:	00 00 00 
    1028:	8b 45 fc             	mov    -0x4(%rbp),%eax
    102b:	48 63 d0             	movslq %eax,%rdx
    102e:	48 89 d0             	mov    %rdx,%rax
    1031:	48 01 c0             	add    %rax,%rax
    1034:	48 01 d0             	add    %rdx,%rax
    1037:	48 c1 e0 02          	shl    $0x2,%rax
    103b:	48 01 c8             	add    %rcx,%rax
    103e:	8b 00                	mov    (%rax),%eax
    1040:	85 c0                	test   %eax,%eax
    1042:	75 7d                	jne    10c1 <alloc_remote_fd+0xc1>
      fd_table[i].used = 1;
    1044:	48 b9 80 27 00 00 00 	movabs $0x2780,%rcx
    104b:	00 00 00 
    104e:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1051:	48 63 d0             	movslq %eax,%rdx
    1054:	48 89 d0             	mov    %rdx,%rax
    1057:	48 01 c0             	add    %rax,%rax
    105a:	48 01 d0             	add    %rdx,%rax
    105d:	48 c1 e0 02          	shl    $0x2,%rax
    1061:	48 01 c8             	add    %rcx,%rax
    1064:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
      fd_table[i].owner_pid = owner_pid;
    106a:	48 b9 80 27 00 00 00 	movabs $0x2780,%rcx
    1071:	00 00 00 
    1074:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1077:	48 63 d0             	movslq %eax,%rdx
    107a:	48 89 d0             	mov    %rdx,%rax
    107d:	48 01 c0             	add    %rax,%rax
    1080:	48 01 d0             	add    %rdx,%rax
    1083:	48 c1 e0 02          	shl    $0x2,%rax
    1087:	48 01 c8             	add    %rcx,%rax
    108a:	48 8d 50 04          	lea    0x4(%rax),%rdx
    108e:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1091:	89 02                	mov    %eax,(%rdx)
      fd_table[i].real_fd = real_fd;
    1093:	48 b9 80 27 00 00 00 	movabs $0x2780,%rcx
    109a:	00 00 00 
    109d:	8b 45 fc             	mov    -0x4(%rbp),%eax
    10a0:	48 63 d0             	movslq %eax,%rdx
    10a3:	48 89 d0             	mov    %rdx,%rax
    10a6:	48 01 c0             	add    %rax,%rax
    10a9:	48 01 d0             	add    %rdx,%rax
    10ac:	48 c1 e0 02          	shl    $0x2,%rax
    10b0:	48 01 c8             	add    %rcx,%rax
    10b3:	48 8d 50 08          	lea    0x8(%rax),%rdx
    10b7:	8b 45 e8             	mov    -0x18(%rbp),%eax
    10ba:	89 02                	mov    %eax,(%rdx)
      return i;
    10bc:	8b 45 fc             	mov    -0x4(%rbp),%eax
    10bf:	eb 13                	jmp    10d4 <alloc_remote_fd+0xd4>
  for(i = 0; i < MAX_REMOTE_FDS; i++){
    10c1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    10c5:	83 7d fc 3f          	cmpl   $0x3f,-0x4(%rbp)
    10c9:	0f 8e 4f ff ff ff    	jle    101e <alloc_remote_fd+0x1e>
    }
  }
  return -1;
    10cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    10d4:	c9                   	leave
    10d5:	c3                   	ret

00000000000010d6 <lookup_remote_fd>:

static struct fd_entry*
lookup_remote_fd(int owner_pid, int remote_fd)
{
    10d6:	f3 0f 1e fa          	endbr64
    10da:	55                   	push   %rbp
    10db:	48 89 e5             	mov    %rsp,%rbp
    10de:	48 83 ec 08          	sub    $0x8,%rsp
    10e2:	89 7d fc             	mov    %edi,-0x4(%rbp)
    10e5:	89 75 f8             	mov    %esi,-0x8(%rbp)
  if(remote_fd < 0 || remote_fd >= MAX_REMOTE_FDS)
    10e8:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    10ec:	78 06                	js     10f4 <lookup_remote_fd+0x1e>
    10ee:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
    10f2:	7e 07                	jle    10fb <lookup_remote_fd+0x25>
    return 0;
    10f4:	b8 00 00 00 00       	mov    $0x0,%eax
    10f9:	eb 7f                	jmp    117a <lookup_remote_fd+0xa4>
  if(!fd_table[remote_fd].used)
    10fb:	48 b9 80 27 00 00 00 	movabs $0x2780,%rcx
    1102:	00 00 00 
    1105:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1108:	48 63 d0             	movslq %eax,%rdx
    110b:	48 89 d0             	mov    %rdx,%rax
    110e:	48 01 c0             	add    %rax,%rax
    1111:	48 01 d0             	add    %rdx,%rax
    1114:	48 c1 e0 02          	shl    $0x2,%rax
    1118:	48 01 c8             	add    %rcx,%rax
    111b:	8b 00                	mov    (%rax),%eax
    111d:	85 c0                	test   %eax,%eax
    111f:	75 07                	jne    1128 <lookup_remote_fd+0x52>
    return 0;
    1121:	b8 00 00 00 00       	mov    $0x0,%eax
    1126:	eb 52                	jmp    117a <lookup_remote_fd+0xa4>
  if(fd_table[remote_fd].owner_pid != owner_pid)
    1128:	48 b9 80 27 00 00 00 	movabs $0x2780,%rcx
    112f:	00 00 00 
    1132:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1135:	48 63 d0             	movslq %eax,%rdx
    1138:	48 89 d0             	mov    %rdx,%rax
    113b:	48 01 c0             	add    %rax,%rax
    113e:	48 01 d0             	add    %rdx,%rax
    1141:	48 c1 e0 02          	shl    $0x2,%rax
    1145:	48 01 c8             	add    %rcx,%rax
    1148:	48 83 c0 04          	add    $0x4,%rax
    114c:	8b 00                	mov    (%rax),%eax
    114e:	39 45 fc             	cmp    %eax,-0x4(%rbp)
    1151:	74 07                	je     115a <lookup_remote_fd+0x84>
    return 0;
    1153:	b8 00 00 00 00       	mov    $0x0,%eax
    1158:	eb 20                	jmp    117a <lookup_remote_fd+0xa4>
  return &fd_table[remote_fd];
    115a:	8b 45 f8             	mov    -0x8(%rbp),%eax
    115d:	48 63 d0             	movslq %eax,%rdx
    1160:	48 89 d0             	mov    %rdx,%rax
    1163:	48 01 c0             	add    %rax,%rax
    1166:	48 01 d0             	add    %rdx,%rax
    1169:	48 c1 e0 02          	shl    $0x2,%rax
    116d:	48 ba 80 27 00 00 00 	movabs $0x2780,%rdx
    1174:	00 00 00 
    1177:	48 01 d0             	add    %rdx,%rax
}
    117a:	c9                   	leave
    117b:	c3                   	ret

000000000000117c <close_all_for_owner>:

static void
close_all_for_owner(int owner_pid)
{
    117c:	f3 0f 1e fa          	endbr64
    1180:	55                   	push   %rbp
    1181:	48 89 e5             	mov    %rsp,%rbp
    1184:	48 83 ec 20          	sub    $0x20,%rsp
    1188:	89 7d ec             	mov    %edi,-0x14(%rbp)
  int i;
  for(i = 0; i < MAX_REMOTE_FDS; i++){
    118b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1192:	e9 b3 00 00 00       	jmp    124a <close_all_for_owner+0xce>
    if(fd_table[i].used && fd_table[i].owner_pid == owner_pid){
    1197:	48 b9 80 27 00 00 00 	movabs $0x2780,%rcx
    119e:	00 00 00 
    11a1:	8b 45 fc             	mov    -0x4(%rbp),%eax
    11a4:	48 63 d0             	movslq %eax,%rdx
    11a7:	48 89 d0             	mov    %rdx,%rax
    11aa:	48 01 c0             	add    %rax,%rax
    11ad:	48 01 d0             	add    %rdx,%rax
    11b0:	48 c1 e0 02          	shl    $0x2,%rax
    11b4:	48 01 c8             	add    %rcx,%rax
    11b7:	8b 00                	mov    (%rax),%eax
    11b9:	85 c0                	test   %eax,%eax
    11bb:	0f 84 85 00 00 00    	je     1246 <close_all_for_owner+0xca>
    11c1:	48 b9 80 27 00 00 00 	movabs $0x2780,%rcx
    11c8:	00 00 00 
    11cb:	8b 45 fc             	mov    -0x4(%rbp),%eax
    11ce:	48 63 d0             	movslq %eax,%rdx
    11d1:	48 89 d0             	mov    %rdx,%rax
    11d4:	48 01 c0             	add    %rax,%rax
    11d7:	48 01 d0             	add    %rdx,%rax
    11da:	48 c1 e0 02          	shl    $0x2,%rax
    11de:	48 01 c8             	add    %rcx,%rax
    11e1:	48 83 c0 04          	add    $0x4,%rax
    11e5:	8b 00                	mov    (%rax),%eax
    11e7:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    11ea:	75 5a                	jne    1246 <close_all_for_owner+0xca>
      close(fd_table[i].real_fd);
    11ec:	48 b9 80 27 00 00 00 	movabs $0x2780,%rcx
    11f3:	00 00 00 
    11f6:	8b 45 fc             	mov    -0x4(%rbp),%eax
    11f9:	48 63 d0             	movslq %eax,%rdx
    11fc:	48 89 d0             	mov    %rdx,%rax
    11ff:	48 01 c0             	add    %rax,%rax
    1202:	48 01 d0             	add    %rdx,%rax
    1205:	48 c1 e0 02          	shl    $0x2,%rax
    1209:	48 01 c8             	add    %rcx,%rax
    120c:	48 83 c0 08          	add    $0x8,%rax
    1210:	8b 00                	mov    (%rax),%eax
    1212:	89 c7                	mov    %eax,%edi
    1214:	48 b8 58 1c 00 00 00 	movabs $0x1c58,%rax
    121b:	00 00 00 
    121e:	ff d0                	call   *%rax
      fd_table[i].used = 0;
    1220:	48 b9 80 27 00 00 00 	movabs $0x2780,%rcx
    1227:	00 00 00 
    122a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    122d:	48 63 d0             	movslq %eax,%rdx
    1230:	48 89 d0             	mov    %rdx,%rax
    1233:	48 01 c0             	add    %rax,%rax
    1236:	48 01 d0             	add    %rdx,%rax
    1239:	48 c1 e0 02          	shl    $0x2,%rax
    123d:	48 01 c8             	add    %rcx,%rax
    1240:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  for(i = 0; i < MAX_REMOTE_FDS; i++){
    1246:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    124a:	83 7d fc 3f          	cmpl   $0x3f,-0x4(%rbp)
    124e:	0f 8e 43 ff ff ff    	jle    1197 <close_all_for_owner+0x1b>
    }
  }
}
    1254:	90                   	nop
    1255:	90                   	nop
    1256:	c9                   	leave
    1257:	c3                   	ret

0000000000001258 <send_reply>:

static void
send_reply(int client_pid, int result, int fd, int nbytes, char *data)
{
    1258:	f3 0f 1e fa          	endbr64
    125c:	55                   	push   %rbp
    125d:	48 89 e5             	mov    %rsp,%rbp
    1260:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
    1267:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    126d:	89 b5 18 ff ff ff    	mov    %esi,-0xe8(%rbp)
    1273:	89 95 14 ff ff ff    	mov    %edx,-0xec(%rbp)
    1279:	89 8d 10 ff ff ff    	mov    %ecx,-0xf0(%rbp)
    127f:	4c 89 85 08 ff ff ff 	mov    %r8,-0xf8(%rbp)
  struct ipc_msg reply;

  memset(&reply, 0, sizeof(reply));
    1286:	48 8d 85 20 ff ff ff 	lea    -0xe0(%rbp),%rax
    128d:	ba d8 00 00 00       	mov    $0xd8,%edx
    1292:	be 00 00 00 00       	mov    $0x0,%esi
    1297:	48 89 c7             	mov    %rax,%rdi
    129a:	48 b8 e2 19 00 00 00 	movabs $0x19e2,%rax
    12a1:	00 00 00 
    12a4:	ff d0                	call   *%rax
  reply.type = IPC_TYPE_FS_REPLY;
    12a6:	c7 85 24 ff ff ff 64 	movl   $0x64,-0xdc(%rbp)
    12ad:	00 00 00 
  reply.fd = fd;
    12b0:	8b 85 14 ff ff ff    	mov    -0xec(%rbp),%eax
    12b6:	89 85 28 ff ff ff    	mov    %eax,-0xd8(%rbp)
  reply.result = result;
    12bc:	8b 85 18 ff ff ff    	mov    -0xe8(%rbp),%eax
    12c2:	89 85 34 ff ff ff    	mov    %eax,-0xcc(%rbp)
  reply.nbytes = nbytes;
    12c8:	8b 85 10 ff ff ff    	mov    -0xf0(%rbp),%eax
    12ce:	89 85 30 ff ff ff    	mov    %eax,-0xd0(%rbp)

  if(data && nbytes > 0){
    12d4:	48 83 bd 08 ff ff ff 	cmpq   $0x0,-0xf8(%rbp)
    12db:	00 
    12dc:	74 49                	je     1327 <send_reply+0xcf>
    12de:	83 bd 10 ff ff ff 00 	cmpl   $0x0,-0xf0(%rbp)
    12e5:	7e 40                	jle    1327 <send_reply+0xcf>
    if(nbytes > IPC_DATA_SIZE)
    12e7:	81 bd 10 ff ff ff 80 	cmpl   $0x80,-0xf0(%rbp)
    12ee:	00 00 00 
    12f1:	7e 0a                	jle    12fd <send_reply+0xa5>
      nbytes = IPC_DATA_SIZE;
    12f3:	c7 85 10 ff ff ff 80 	movl   $0x80,-0xf0(%rbp)
    12fa:	00 00 00 
    memmove(reply.data, data, nbytes);
    12fd:	8b 95 10 ff ff ff    	mov    -0xf0(%rbp),%edx
    1303:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
    130a:	48 8d 8d 20 ff ff ff 	lea    -0xe0(%rbp),%rcx
    1311:	48 83 c1 58          	add    $0x58,%rcx
    1315:	48 89 c6             	mov    %rax,%rsi
    1318:	48 89 cf             	mov    %rcx,%rdi
    131b:	48 b8 b1 1b 00 00 00 	movabs $0x1bb1,%rax
    1322:	00 00 00 
    1325:	ff d0                	call   *%rax
  }

  if(send(client_pid, &reply) < 0){
    1327:	48 8d 95 20 ff ff ff 	lea    -0xe0(%rbp),%rdx
    132e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1334:	48 89 d6             	mov    %rdx,%rsi
    1337:	89 c7                	mov    %eax,%edi
    1339:	48 b8 1b 1d 00 00 00 	movabs $0x1d1b,%rax
    1340:	00 00 00 
    1343:	ff d0                	call   *%rax
    1345:	85 c0                	test   %eax,%eax
    1347:	79 2b                	jns    1374 <send_reply+0x11c>
    printf(1, "fsserver: failed reply to pid %d\n", client_pid);
    1349:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    134f:	89 c2                	mov    %eax,%edx
    1351:	48 b8 28 26 00 00 00 	movabs $0x2628,%rax
    1358:	00 00 00 
    135b:	48 89 c6             	mov    %rax,%rsi
    135e:	bf 01 00 00 00       	mov    $0x1,%edi
    1363:	b8 00 00 00 00       	mov    $0x0,%eax
    1368:	48 b9 1b 1f 00 00 00 	movabs $0x1f1b,%rcx
    136f:	00 00 00 
    1372:	ff d1                	call   *%rcx
  }
}
    1374:	90                   	nop
    1375:	c9                   	leave
    1376:	c3                   	ret

0000000000001377 <main>:

int
main(void)
{
    1377:	f3 0f 1e fa          	endbr64
    137b:	55                   	push   %rbp
    137c:	48 89 e5             	mov    %rsp,%rbp
    137f:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
  int real_fd;
  int remote_fd;
  int rc;
  int n;

  printf(1, "fsserver: started (pid=%d)\n", getpid());
    1386:	48 b8 e7 1c 00 00 00 	movabs $0x1ce7,%rax
    138d:	00 00 00 
    1390:	ff d0                	call   *%rax
    1392:	89 c2                	mov    %eax,%edx
    1394:	48 b8 4a 26 00 00 00 	movabs $0x264a,%rax
    139b:	00 00 00 
    139e:	48 89 c6             	mov    %rax,%rsi
    13a1:	bf 01 00 00 00       	mov    $0x1,%edi
    13a6:	b8 00 00 00 00       	mov    $0x0,%eax
    13ab:	48 b9 1b 1f 00 00 00 	movabs $0x1f1b,%rcx
    13b2:	00 00 00 
    13b5:	ff d1                	call   *%rcx

  for(;;){
    memset(&req, 0, sizeof(req));
    13b7:	48 8d 85 00 ff ff ff 	lea    -0x100(%rbp),%rax
    13be:	ba d8 00 00 00       	mov    $0xd8,%edx
    13c3:	be 00 00 00 00       	mov    $0x0,%esi
    13c8:	48 89 c7             	mov    %rax,%rdi
    13cb:	48 b8 e2 19 00 00 00 	movabs $0x19e2,%rax
    13d2:	00 00 00 
    13d5:	ff d0                	call   *%rax
    if(recv(&req) < 0){
    13d7:	48 8d 85 00 ff ff ff 	lea    -0x100(%rbp),%rax
    13de:	48 89 c7             	mov    %rax,%rdi
    13e1:	48 b8 28 1d 00 00 00 	movabs $0x1d28,%rax
    13e8:	00 00 00 
    13eb:	ff d0                	call   *%rax
    13ed:	85 c0                	test   %eax,%eax
    13ef:	79 28                	jns    1419 <main+0xa2>
      printf(1, "fsserver: recv failed\n");
    13f1:	48 b8 66 26 00 00 00 	movabs $0x2666,%rax
    13f8:	00 00 00 
    13fb:	48 89 c6             	mov    %rax,%rsi
    13fe:	bf 01 00 00 00       	mov    $0x1,%edi
    1403:	b8 00 00 00 00       	mov    $0x0,%eax
    1408:	48 ba 1b 1f 00 00 00 	movabs $0x1f1b,%rdx
    140f:	00 00 00 
    1412:	ff d2                	call   *%rdx
      continue;
    1414:	e9 b6 04 00 00       	jmp    18cf <main+0x558>
    }

    if(req.type == IPC_TYPE_FS_SHUTDOWN){
    1419:	8b 85 04 ff ff ff    	mov    -0xfc(%rbp),%eax
    141f:	83 f8 65             	cmp    $0x65,%eax
    1422:	75 75                	jne    1499 <main+0x122>
      close_all_for_owner(req.sender_pid);
    1424:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
    142a:	89 c7                	mov    %eax,%edi
    142c:	48 b8 7c 11 00 00 00 	movabs $0x117c,%rax
    1433:	00 00 00 
    1436:	ff d0                	call   *%rax
      send_reply(req.sender_pid, 0, -1, 0, 0);
    1438:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
    143e:	41 b8 00 00 00 00    	mov    $0x0,%r8d
    1444:	b9 00 00 00 00       	mov    $0x0,%ecx
    1449:	ba ff ff ff ff       	mov    $0xffffffff,%edx
    144e:	be 00 00 00 00       	mov    $0x0,%esi
    1453:	89 c7                	mov    %eax,%edi
    1455:	48 b8 58 12 00 00 00 	movabs $0x1258,%rax
    145c:	00 00 00 
    145f:	ff d0                	call   *%rax
      printf(1, "fsserver: shutdown requested by pid %d\n", req.sender_pid);
    1461:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
    1467:	89 c2                	mov    %eax,%edx
    1469:	48 b8 80 26 00 00 00 	movabs $0x2680,%rax
    1470:	00 00 00 
    1473:	48 89 c6             	mov    %rax,%rsi
    1476:	bf 01 00 00 00       	mov    $0x1,%edi
    147b:	b8 00 00 00 00       	mov    $0x0,%eax
    1480:	48 b9 1b 1f 00 00 00 	movabs $0x1f1b,%rcx
    1487:	00 00 00 
    148a:	ff d1                	call   *%rcx
      break;
    148c:	90                   	nop
      send_reply(req.sender_pid, -1, req.fd, 0, 0);
      break;
    }
  }

  exit();
    148d:	48 b8 17 1c 00 00 00 	movabs $0x1c17,%rax
    1494:	00 00 00 
    1497:	ff d0                	call   *%rax
    switch(req.type){
    1499:	8b 85 04 ff ff ff    	mov    -0xfc(%rbp),%eax
    149f:	83 f8 04             	cmp    $0x4,%eax
    14a2:	0f 84 26 03 00 00    	je     17ce <main+0x457>
    14a8:	83 f8 04             	cmp    $0x4,%eax
    14ab:	0f 8f f3 03 00 00    	jg     18a4 <main+0x52d>
    14b1:	83 f8 03             	cmp    $0x3,%eax
    14b4:	0f 84 0d 02 00 00    	je     16c7 <main+0x350>
    14ba:	83 f8 03             	cmp    $0x3,%eax
    14bd:	0f 8f e1 03 00 00    	jg     18a4 <main+0x52d>
    14c3:	83 f8 01             	cmp    $0x1,%eax
    14c6:	74 0e                	je     14d6 <main+0x15f>
    14c8:	83 f8 02             	cmp    $0x2,%eax
    14cb:	0f 84 e9 00 00 00    	je     15ba <main+0x243>
    14d1:	e9 ce 03 00 00       	jmp    18a4 <main+0x52d>
      real_fd = open(req.path, req.flags);
    14d6:	8b 85 0c ff ff ff    	mov    -0xf4(%rbp),%eax
    14dc:	48 8d 95 00 ff ff ff 	lea    -0x100(%rbp),%rdx
    14e3:	48 83 c2 18          	add    $0x18,%rdx
    14e7:	89 c6                	mov    %eax,%esi
    14e9:	48 89 d7             	mov    %rdx,%rdi
    14ec:	48 b8 7f 1c 00 00 00 	movabs $0x1c7f,%rax
    14f3:	00 00 00 
    14f6:	ff d0                	call   *%rax
    14f8:	89 45 e8             	mov    %eax,-0x18(%rbp)
      if(real_fd < 0){
    14fb:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
    14ff:	79 2e                	jns    152f <main+0x1b8>
        send_reply(req.sender_pid, -1, -1, 0, 0);
    1501:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
    1507:	41 b8 00 00 00 00    	mov    $0x0,%r8d
    150d:	b9 00 00 00 00       	mov    $0x0,%ecx
    1512:	ba ff ff ff ff       	mov    $0xffffffff,%edx
    1517:	be ff ff ff ff       	mov    $0xffffffff,%esi
    151c:	89 c7                	mov    %eax,%edi
    151e:	48 b8 58 12 00 00 00 	movabs $0x1258,%rax
    1525:	00 00 00 
    1528:	ff d0                	call   *%rax
        break;
    152a:	e9 a0 03 00 00       	jmp    18cf <main+0x558>
      remote_fd = alloc_remote_fd(req.sender_pid, real_fd);
    152f:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
    1535:	8b 55 e8             	mov    -0x18(%rbp),%edx
    1538:	89 d6                	mov    %edx,%esi
    153a:	89 c7                	mov    %eax,%edi
    153c:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1543:	00 00 00 
    1546:	ff d0                	call   *%rax
    1548:	89 45 e4             	mov    %eax,-0x1c(%rbp)
      if(remote_fd < 0){
    154b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
    154f:	79 3f                	jns    1590 <main+0x219>
        close(real_fd);
    1551:	8b 45 e8             	mov    -0x18(%rbp),%eax
    1554:	89 c7                	mov    %eax,%edi
    1556:	48 b8 58 1c 00 00 00 	movabs $0x1c58,%rax
    155d:	00 00 00 
    1560:	ff d0                	call   *%rax
        send_reply(req.sender_pid, -1, -1, 0, 0);
    1562:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
    1568:	41 b8 00 00 00 00    	mov    $0x0,%r8d
    156e:	b9 00 00 00 00       	mov    $0x0,%ecx
    1573:	ba ff ff ff ff       	mov    $0xffffffff,%edx
    1578:	be ff ff ff ff       	mov    $0xffffffff,%esi
    157d:	89 c7                	mov    %eax,%edi
    157f:	48 b8 58 12 00 00 00 	movabs $0x1258,%rax
    1586:	00 00 00 
    1589:	ff d0                	call   *%rax
        break;
    158b:	e9 3f 03 00 00       	jmp    18cf <main+0x558>
      send_reply(req.sender_pid, remote_fd, remote_fd, 0, 0);
    1590:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
    1596:	8b 55 e4             	mov    -0x1c(%rbp),%edx
    1599:	8b 75 e4             	mov    -0x1c(%rbp),%esi
    159c:	41 b8 00 00 00 00    	mov    $0x0,%r8d
    15a2:	b9 00 00 00 00       	mov    $0x0,%ecx
    15a7:	89 c7                	mov    %eax,%edi
    15a9:	48 b8 58 12 00 00 00 	movabs $0x1258,%rax
    15b0:	00 00 00 
    15b3:	ff d0                	call   *%rax
      break;
    15b5:	e9 15 03 00 00       	jmp    18cf <main+0x558>
      ent = lookup_remote_fd(req.sender_pid, req.fd);
    15ba:	8b 95 08 ff ff ff    	mov    -0xf8(%rbp),%edx
    15c0:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
    15c6:	89 d6                	mov    %edx,%esi
    15c8:	89 c7                	mov    %eax,%edi
    15ca:	48 b8 d6 10 00 00 00 	movabs $0x10d6,%rax
    15d1:	00 00 00 
    15d4:	ff d0                	call   *%rax
    15d6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
      if(ent == 0){
    15da:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    15df:	75 2f                	jne    1610 <main+0x299>
        send_reply(req.sender_pid, -1, req.fd, 0, 0);
    15e1:	8b 95 08 ff ff ff    	mov    -0xf8(%rbp),%edx
    15e7:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
    15ed:	41 b8 00 00 00 00    	mov    $0x0,%r8d
    15f3:	b9 00 00 00 00       	mov    $0x0,%ecx
    15f8:	be ff ff ff ff       	mov    $0xffffffff,%esi
    15fd:	89 c7                	mov    %eax,%edi
    15ff:	48 b8 58 12 00 00 00 	movabs $0x1258,%rax
    1606:	00 00 00 
    1609:	ff d0                	call   *%rax
        break;
    160b:	e9 bf 02 00 00       	jmp    18cf <main+0x558>
      n = req.nbytes;
    1610:	8b 85 10 ff ff ff    	mov    -0xf0(%rbp),%eax
    1616:	89 45 fc             	mov    %eax,-0x4(%rbp)
      if(n < 0)
    1619:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    161d:	79 07                	jns    1626 <main+0x2af>
        n = 0;
    161f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
      if(n > IPC_DATA_SIZE)
    1626:	81 7d fc 80 00 00 00 	cmpl   $0x80,-0x4(%rbp)
    162d:	7e 07                	jle    1636 <main+0x2bf>
        n = IPC_DATA_SIZE;
    162f:	c7 45 fc 80 00 00 00 	movl   $0x80,-0x4(%rbp)
      rc = read(ent->real_fd, req.data, n);
    1636:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    163a:	8b 40 08             	mov    0x8(%rax),%eax
    163d:	8b 55 fc             	mov    -0x4(%rbp),%edx
    1640:	48 8d 8d 00 ff ff ff 	lea    -0x100(%rbp),%rcx
    1647:	48 83 c1 58          	add    $0x58,%rcx
    164b:	48 89 ce             	mov    %rcx,%rsi
    164e:	89 c7                	mov    %eax,%edi
    1650:	48 b8 3e 1c 00 00 00 	movabs $0x1c3e,%rax
    1657:	00 00 00 
    165a:	ff d0                	call   *%rax
    165c:	89 45 ec             	mov    %eax,-0x14(%rbp)
      if(rc < 0){
    165f:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
    1663:	79 2f                	jns    1694 <main+0x31d>
        send_reply(req.sender_pid, -1, req.fd, 0, 0);
    1665:	8b 95 08 ff ff ff    	mov    -0xf8(%rbp),%edx
    166b:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
    1671:	41 b8 00 00 00 00    	mov    $0x0,%r8d
    1677:	b9 00 00 00 00       	mov    $0x0,%ecx
    167c:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1681:	89 c7                	mov    %eax,%edi
    1683:	48 b8 58 12 00 00 00 	movabs $0x1258,%rax
    168a:	00 00 00 
    168d:	ff d0                	call   *%rax
      break;
    168f:	e9 3b 02 00 00       	jmp    18cf <main+0x558>
        send_reply(req.sender_pid, rc, req.fd, rc, req.data);
    1694:	8b 95 08 ff ff ff    	mov    -0xf8(%rbp),%edx
    169a:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
    16a0:	48 8d 8d 00 ff ff ff 	lea    -0x100(%rbp),%rcx
    16a7:	48 8d 79 58          	lea    0x58(%rcx),%rdi
    16ab:	8b 4d ec             	mov    -0x14(%rbp),%ecx
    16ae:	8b 75 ec             	mov    -0x14(%rbp),%esi
    16b1:	49 89 f8             	mov    %rdi,%r8
    16b4:	89 c7                	mov    %eax,%edi
    16b6:	48 b8 58 12 00 00 00 	movabs $0x1258,%rax
    16bd:	00 00 00 
    16c0:	ff d0                	call   *%rax
      break;
    16c2:	e9 08 02 00 00       	jmp    18cf <main+0x558>
      ent = lookup_remote_fd(req.sender_pid, req.fd);
    16c7:	8b 95 08 ff ff ff    	mov    -0xf8(%rbp),%edx
    16cd:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
    16d3:	89 d6                	mov    %edx,%esi
    16d5:	89 c7                	mov    %eax,%edi
    16d7:	48 b8 d6 10 00 00 00 	movabs $0x10d6,%rax
    16de:	00 00 00 
    16e1:	ff d0                	call   *%rax
    16e3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
      if(ent == 0){
    16e7:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    16ec:	75 2f                	jne    171d <main+0x3a6>
        send_reply(req.sender_pid, -1, req.fd, 0, 0);
    16ee:	8b 95 08 ff ff ff    	mov    -0xf8(%rbp),%edx
    16f4:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
    16fa:	41 b8 00 00 00 00    	mov    $0x0,%r8d
    1700:	b9 00 00 00 00       	mov    $0x0,%ecx
    1705:	be ff ff ff ff       	mov    $0xffffffff,%esi
    170a:	89 c7                	mov    %eax,%edi
    170c:	48 b8 58 12 00 00 00 	movabs $0x1258,%rax
    1713:	00 00 00 
    1716:	ff d0                	call   *%rax
        break;
    1718:	e9 b2 01 00 00       	jmp    18cf <main+0x558>
      n = req.nbytes;
    171d:	8b 85 10 ff ff ff    	mov    -0xf0(%rbp),%eax
    1723:	89 45 fc             	mov    %eax,-0x4(%rbp)
      if(n < 0)
    1726:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    172a:	79 07                	jns    1733 <main+0x3bc>
        n = 0;
    172c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
      if(n > IPC_DATA_SIZE)
    1733:	81 7d fc 80 00 00 00 	cmpl   $0x80,-0x4(%rbp)
    173a:	7e 07                	jle    1743 <main+0x3cc>
        n = IPC_DATA_SIZE;
    173c:	c7 45 fc 80 00 00 00 	movl   $0x80,-0x4(%rbp)
      rc = write(ent->real_fd, req.data, n);
    1743:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1747:	8b 40 08             	mov    0x8(%rax),%eax
    174a:	8b 55 fc             	mov    -0x4(%rbp),%edx
    174d:	48 8d 8d 00 ff ff ff 	lea    -0x100(%rbp),%rcx
    1754:	48 83 c1 58          	add    $0x58,%rcx
    1758:	48 89 ce             	mov    %rcx,%rsi
    175b:	89 c7                	mov    %eax,%edi
    175d:	48 b8 4b 1c 00 00 00 	movabs $0x1c4b,%rax
    1764:	00 00 00 
    1767:	ff d0                	call   *%rax
    1769:	89 45 ec             	mov    %eax,-0x14(%rbp)
      if(rc < 0){
    176c:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
    1770:	79 2f                	jns    17a1 <main+0x42a>
        send_reply(req.sender_pid, -1, req.fd, 0, 0);
    1772:	8b 95 08 ff ff ff    	mov    -0xf8(%rbp),%edx
    1778:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
    177e:	41 b8 00 00 00 00    	mov    $0x0,%r8d
    1784:	b9 00 00 00 00       	mov    $0x0,%ecx
    1789:	be ff ff ff ff       	mov    $0xffffffff,%esi
    178e:	89 c7                	mov    %eax,%edi
    1790:	48 b8 58 12 00 00 00 	movabs $0x1258,%rax
    1797:	00 00 00 
    179a:	ff d0                	call   *%rax
      break;
    179c:	e9 2e 01 00 00       	jmp    18cf <main+0x558>
        send_reply(req.sender_pid, rc, req.fd, 0, 0);
    17a1:	8b 95 08 ff ff ff    	mov    -0xf8(%rbp),%edx
    17a7:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
    17ad:	8b 75 ec             	mov    -0x14(%rbp),%esi
    17b0:	41 b8 00 00 00 00    	mov    $0x0,%r8d
    17b6:	b9 00 00 00 00       	mov    $0x0,%ecx
    17bb:	89 c7                	mov    %eax,%edi
    17bd:	48 b8 58 12 00 00 00 	movabs $0x1258,%rax
    17c4:	00 00 00 
    17c7:	ff d0                	call   *%rax
      break;
    17c9:	e9 01 01 00 00       	jmp    18cf <main+0x558>
      ent = lookup_remote_fd(req.sender_pid, req.fd);
    17ce:	8b 95 08 ff ff ff    	mov    -0xf8(%rbp),%edx
    17d4:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
    17da:	89 d6                	mov    %edx,%esi
    17dc:	89 c7                	mov    %eax,%edi
    17de:	48 b8 d6 10 00 00 00 	movabs $0x10d6,%rax
    17e5:	00 00 00 
    17e8:	ff d0                	call   *%rax
    17ea:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
      if(ent == 0){
    17ee:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    17f3:	75 2f                	jne    1824 <main+0x4ad>
        send_reply(req.sender_pid, -1, req.fd, 0, 0);
    17f5:	8b 95 08 ff ff ff    	mov    -0xf8(%rbp),%edx
    17fb:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
    1801:	41 b8 00 00 00 00    	mov    $0x0,%r8d
    1807:	b9 00 00 00 00       	mov    $0x0,%ecx
    180c:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1811:	89 c7                	mov    %eax,%edi
    1813:	48 b8 58 12 00 00 00 	movabs $0x1258,%rax
    181a:	00 00 00 
    181d:	ff d0                	call   *%rax
        break;
    181f:	e9 ab 00 00 00       	jmp    18cf <main+0x558>
      rc = close(ent->real_fd);
    1824:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1828:	8b 40 08             	mov    0x8(%rax),%eax
    182b:	89 c7                	mov    %eax,%edi
    182d:	48 b8 58 1c 00 00 00 	movabs $0x1c58,%rax
    1834:	00 00 00 
    1837:	ff d0                	call   *%rax
    1839:	89 45 ec             	mov    %eax,-0x14(%rbp)
      ent->used = 0;
    183c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1840:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
      if(rc < 0)
    1846:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
    184a:	79 2c                	jns    1878 <main+0x501>
        send_reply(req.sender_pid, -1, req.fd, 0, 0);
    184c:	8b 95 08 ff ff ff    	mov    -0xf8(%rbp),%edx
    1852:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
    1858:	41 b8 00 00 00 00    	mov    $0x0,%r8d
    185e:	b9 00 00 00 00       	mov    $0x0,%ecx
    1863:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1868:	89 c7                	mov    %eax,%edi
    186a:	48 b8 58 12 00 00 00 	movabs $0x1258,%rax
    1871:	00 00 00 
    1874:	ff d0                	call   *%rax
      break;
    1876:	eb 57                	jmp    18cf <main+0x558>
        send_reply(req.sender_pid, 0, req.fd, 0, 0);
    1878:	8b 95 08 ff ff ff    	mov    -0xf8(%rbp),%edx
    187e:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
    1884:	41 b8 00 00 00 00    	mov    $0x0,%r8d
    188a:	b9 00 00 00 00       	mov    $0x0,%ecx
    188f:	be 00 00 00 00       	mov    $0x0,%esi
    1894:	89 c7                	mov    %eax,%edi
    1896:	48 b8 58 12 00 00 00 	movabs $0x1258,%rax
    189d:	00 00 00 
    18a0:	ff d0                	call   *%rax
      break;
    18a2:	eb 2b                	jmp    18cf <main+0x558>
      send_reply(req.sender_pid, -1, req.fd, 0, 0);
    18a4:	8b 95 08 ff ff ff    	mov    -0xf8(%rbp),%edx
    18aa:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
    18b0:	41 b8 00 00 00 00    	mov    $0x0,%r8d
    18b6:	b9 00 00 00 00       	mov    $0x0,%ecx
    18bb:	be ff ff ff ff       	mov    $0xffffffff,%esi
    18c0:	89 c7                	mov    %eax,%edi
    18c2:	48 b8 58 12 00 00 00 	movabs $0x1258,%rax
    18c9:	00 00 00 
    18cc:	ff d0                	call   *%rax
      break;
    18ce:	90                   	nop
    memset(&req, 0, sizeof(req));
    18cf:	e9 e3 fa ff ff       	jmp    13b7 <main+0x40>

00000000000018d4 <stosb>:
  stosb(dst, c, n);
  return dst;
}

char*
strchr(const char *s, char c)
    18d4:	f3 0f 1e fa          	endbr64
    18d8:	55                   	push   %rbp
    18d9:	48 89 e5             	mov    %rsp,%rbp
    18dc:	48 83 ec 10          	sub    $0x10,%rsp
    18e0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    18e4:	89 75 f4             	mov    %esi,-0xc(%rbp)
    18e7:	89 55 f0             	mov    %edx,-0x10(%rbp)
{
    18ea:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    18ee:	8b 55 f0             	mov    -0x10(%rbp),%edx
    18f1:	8b 45 f4             	mov    -0xc(%rbp),%eax
    18f4:	48 89 ce             	mov    %rcx,%rsi
    18f7:	48 89 f7             	mov    %rsi,%rdi
    18fa:	89 d1                	mov    %edx,%ecx
    18fc:	fc                   	cld
    18fd:	f3 aa                	rep stos %al,%es:(%rdi)
    18ff:	89 ca                	mov    %ecx,%edx
    1901:	48 89 fe             	mov    %rdi,%rsi
    1904:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    1908:	89 55 f0             	mov    %edx,-0x10(%rbp)
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
    190b:	90                   	nop
    190c:	c9                   	leave
    190d:	c3                   	ret

000000000000190e <strcpy>:
{
    190e:	f3 0f 1e fa          	endbr64
    1912:	55                   	push   %rbp
    1913:	48 89 e5             	mov    %rsp,%rbp
    1916:	48 83 ec 20          	sub    $0x20,%rsp
    191a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    191e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  os = s;
    1922:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1926:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    192a:	90                   	nop
    192b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    192f:	48 8d 42 01          	lea    0x1(%rdx),%rax
    1933:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    1937:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    193b:	48 8d 48 01          	lea    0x1(%rax),%rcx
    193f:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    1943:	0f b6 12             	movzbl (%rdx),%edx
    1946:	88 10                	mov    %dl,(%rax)
    1948:	0f b6 00             	movzbl (%rax),%eax
    194b:	84 c0                	test   %al,%al
    194d:	75 dc                	jne    192b <strcpy+0x1d>
  return os;
    194f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    1953:	c9                   	leave
    1954:	c3                   	ret

0000000000001955 <strcmp>:
{
    1955:	f3 0f 1e fa          	endbr64
    1959:	55                   	push   %rbp
    195a:	48 89 e5             	mov    %rsp,%rbp
    195d:	48 83 ec 10          	sub    $0x10,%rsp
    1961:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1965:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    1969:	eb 0a                	jmp    1975 <strcmp+0x20>
    p++, q++;
    196b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1970:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    1975:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1979:	0f b6 00             	movzbl (%rax),%eax
    197c:	84 c0                	test   %al,%al
    197e:	74 12                	je     1992 <strcmp+0x3d>
    1980:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1984:	0f b6 10             	movzbl (%rax),%edx
    1987:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    198b:	0f b6 00             	movzbl (%rax),%eax
    198e:	38 c2                	cmp    %al,%dl
    1990:	74 d9                	je     196b <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
    1992:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1996:	0f b6 00             	movzbl (%rax),%eax
    1999:	0f b6 d0             	movzbl %al,%edx
    199c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    19a0:	0f b6 00             	movzbl (%rax),%eax
    19a3:	0f b6 c0             	movzbl %al,%eax
    19a6:	29 c2                	sub    %eax,%edx
    19a8:	89 d0                	mov    %edx,%eax
}
    19aa:	c9                   	leave
    19ab:	c3                   	ret

00000000000019ac <strlen>:
{
    19ac:	f3 0f 1e fa          	endbr64
    19b0:	55                   	push   %rbp
    19b1:	48 89 e5             	mov    %rsp,%rbp
    19b4:	48 83 ec 18          	sub    $0x18,%rsp
    19b8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  for(n = 0; s[n]; n++)
    19bc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    19c3:	eb 04                	jmp    19c9 <strlen+0x1d>
    19c5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    19c9:	8b 45 fc             	mov    -0x4(%rbp),%eax
    19cc:	48 63 d0             	movslq %eax,%rdx
    19cf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    19d3:	48 01 d0             	add    %rdx,%rax
    19d6:	0f b6 00             	movzbl (%rax),%eax
    19d9:	84 c0                	test   %al,%al
    19db:	75 e8                	jne    19c5 <strlen+0x19>
  return n;
    19dd:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    19e0:	c9                   	leave
    19e1:	c3                   	ret

00000000000019e2 <memset>:
{
    19e2:	f3 0f 1e fa          	endbr64
    19e6:	55                   	push   %rbp
    19e7:	48 89 e5             	mov    %rsp,%rbp
    19ea:	48 83 ec 10          	sub    $0x10,%rsp
    19ee:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    19f2:	89 75 f4             	mov    %esi,-0xc(%rbp)
    19f5:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    19f8:	8b 55 f0             	mov    -0x10(%rbp),%edx
    19fb:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    19fe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1a02:	89 ce                	mov    %ecx,%esi
    1a04:	48 89 c7             	mov    %rax,%rdi
    1a07:	48 b8 d4 18 00 00 00 	movabs $0x18d4,%rax
    1a0e:	00 00 00 
    1a11:	ff d0                	call   *%rax
  return dst;
    1a13:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    1a17:	c9                   	leave
    1a18:	c3                   	ret

0000000000001a19 <strchr>:
{
    1a19:	f3 0f 1e fa          	endbr64
    1a1d:	55                   	push   %rbp
    1a1e:	48 89 e5             	mov    %rsp,%rbp
    1a21:	48 83 ec 10          	sub    $0x10,%rsp
    1a25:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1a29:	89 f0                	mov    %esi,%eax
    1a2b:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    1a2e:	eb 17                	jmp    1a47 <strchr+0x2e>
    if(*s == c)
    1a30:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1a34:	0f b6 00             	movzbl (%rax),%eax
    1a37:	38 45 f4             	cmp    %al,-0xc(%rbp)
    1a3a:	75 06                	jne    1a42 <strchr+0x29>
      return (char*)s;
    1a3c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1a40:	eb 15                	jmp    1a57 <strchr+0x3e>
  for(; *s; s++)
    1a42:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1a47:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1a4b:	0f b6 00             	movzbl (%rax),%eax
    1a4e:	84 c0                	test   %al,%al
    1a50:	75 de                	jne    1a30 <strchr+0x17>
  return 0;
    1a52:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1a57:	c9                   	leave
    1a58:	c3                   	ret

0000000000001a59 <gets>:

char*
gets(char *buf, int max)
{
    1a59:	f3 0f 1e fa          	endbr64
    1a5d:	55                   	push   %rbp
    1a5e:	48 89 e5             	mov    %rsp,%rbp
    1a61:	48 83 ec 20          	sub    $0x20,%rsp
    1a65:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1a69:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1a6c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1a73:	eb 4f                	jmp    1ac4 <gets+0x6b>
    cc = read(0, &c, 1);
    1a75:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    1a79:	ba 01 00 00 00       	mov    $0x1,%edx
    1a7e:	48 89 c6             	mov    %rax,%rsi
    1a81:	bf 00 00 00 00       	mov    $0x0,%edi
    1a86:	48 b8 3e 1c 00 00 00 	movabs $0x1c3e,%rax
    1a8d:	00 00 00 
    1a90:	ff d0                	call   *%rax
    1a92:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    1a95:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1a99:	7e 36                	jle    1ad1 <gets+0x78>
      break;
    buf[i++] = c;
    1a9b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1a9e:	8d 50 01             	lea    0x1(%rax),%edx
    1aa1:	89 55 fc             	mov    %edx,-0x4(%rbp)
    1aa4:	48 63 d0             	movslq %eax,%rdx
    1aa7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1aab:	48 01 c2             	add    %rax,%rdx
    1aae:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1ab2:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    1ab4:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1ab8:	3c 0a                	cmp    $0xa,%al
    1aba:	74 16                	je     1ad2 <gets+0x79>
    1abc:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1ac0:	3c 0d                	cmp    $0xd,%al
    1ac2:	74 0e                	je     1ad2 <gets+0x79>
  for(i=0; i+1 < max; ){
    1ac4:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1ac7:	83 c0 01             	add    $0x1,%eax
    1aca:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    1acd:	7f a6                	jg     1a75 <gets+0x1c>
    1acf:	eb 01                	jmp    1ad2 <gets+0x79>
      break;
    1ad1:	90                   	nop
      break;
  }
  buf[i] = '\0';
    1ad2:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1ad5:	48 63 d0             	movslq %eax,%rdx
    1ad8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1adc:	48 01 d0             	add    %rdx,%rax
    1adf:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    1ae2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    1ae6:	c9                   	leave
    1ae7:	c3                   	ret

0000000000001ae8 <stat>:

int
stat(char *n, struct stat *st)
{
    1ae8:	f3 0f 1e fa          	endbr64
    1aec:	55                   	push   %rbp
    1aed:	48 89 e5             	mov    %rsp,%rbp
    1af0:	48 83 ec 20          	sub    $0x20,%rsp
    1af4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1af8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1afc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1b00:	be 00 00 00 00       	mov    $0x0,%esi
    1b05:	48 89 c7             	mov    %rax,%rdi
    1b08:	48 b8 7f 1c 00 00 00 	movabs $0x1c7f,%rax
    1b0f:	00 00 00 
    1b12:	ff d0                	call   *%rax
    1b14:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    1b17:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1b1b:	79 07                	jns    1b24 <stat+0x3c>
    return -1;
    1b1d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1b22:	eb 2f                	jmp    1b53 <stat+0x6b>
  r = fstat(fd, st);
    1b24:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1b28:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1b2b:	48 89 d6             	mov    %rdx,%rsi
    1b2e:	89 c7                	mov    %eax,%edi
    1b30:	48 b8 a6 1c 00 00 00 	movabs $0x1ca6,%rax
    1b37:	00 00 00 
    1b3a:	ff d0                	call   *%rax
    1b3c:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    1b3f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1b42:	89 c7                	mov    %eax,%edi
    1b44:	48 b8 58 1c 00 00 00 	movabs $0x1c58,%rax
    1b4b:	00 00 00 
    1b4e:	ff d0                	call   *%rax
  return r;
    1b50:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    1b53:	c9                   	leave
    1b54:	c3                   	ret

0000000000001b55 <atoi>:

int
atoi(const char *s)
{
    1b55:	f3 0f 1e fa          	endbr64
    1b59:	55                   	push   %rbp
    1b5a:	48 89 e5             	mov    %rsp,%rbp
    1b5d:	48 83 ec 18          	sub    $0x18,%rsp
    1b61:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    1b65:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1b6c:	eb 28                	jmp    1b96 <atoi+0x41>
    n = n*10 + *s++ - '0';
    1b6e:	8b 55 fc             	mov    -0x4(%rbp),%edx
    1b71:	89 d0                	mov    %edx,%eax
    1b73:	c1 e0 02             	shl    $0x2,%eax
    1b76:	01 d0                	add    %edx,%eax
    1b78:	01 c0                	add    %eax,%eax
    1b7a:	89 c1                	mov    %eax,%ecx
    1b7c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1b80:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1b84:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    1b88:	0f b6 00             	movzbl (%rax),%eax
    1b8b:	0f be c0             	movsbl %al,%eax
    1b8e:	01 c8                	add    %ecx,%eax
    1b90:	83 e8 30             	sub    $0x30,%eax
    1b93:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1b96:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1b9a:	0f b6 00             	movzbl (%rax),%eax
    1b9d:	3c 2f                	cmp    $0x2f,%al
    1b9f:	7e 0b                	jle    1bac <atoi+0x57>
    1ba1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1ba5:	0f b6 00             	movzbl (%rax),%eax
    1ba8:	3c 39                	cmp    $0x39,%al
    1baa:	7e c2                	jle    1b6e <atoi+0x19>
  return n;
    1bac:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    1baf:	c9                   	leave
    1bb0:	c3                   	ret

0000000000001bb1 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1bb1:	f3 0f 1e fa          	endbr64
    1bb5:	55                   	push   %rbp
    1bb6:	48 89 e5             	mov    %rsp,%rbp
    1bb9:	48 83 ec 28          	sub    $0x28,%rsp
    1bbd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1bc1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    1bc5:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    1bc8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1bcc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    1bd0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1bd4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    1bd8:	eb 1d                	jmp    1bf7 <memmove+0x46>
    *dst++ = *src++;
    1bda:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1bde:	48 8d 42 01          	lea    0x1(%rdx),%rax
    1be2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1be6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bea:	48 8d 48 01          	lea    0x1(%rax),%rcx
    1bee:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    1bf2:	0f b6 12             	movzbl (%rdx),%edx
    1bf5:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    1bf7:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1bfa:	8d 50 ff             	lea    -0x1(%rax),%edx
    1bfd:	89 55 dc             	mov    %edx,-0x24(%rbp)
    1c00:	85 c0                	test   %eax,%eax
    1c02:	7f d6                	jg     1bda <memmove+0x29>
  return vdst;
    1c04:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    1c08:	c9                   	leave
    1c09:	c3                   	ret

0000000000001c0a <fork>:
    1c0a:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    1c11:	49 89 ca             	mov    %rcx,%r10
    1c14:	0f 05                	syscall
    1c16:	c3                   	ret

0000000000001c17 <exit>:
    1c17:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    1c1e:	49 89 ca             	mov    %rcx,%r10
    1c21:	0f 05                	syscall
    1c23:	c3                   	ret

0000000000001c24 <wait>:
    1c24:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    1c2b:	49 89 ca             	mov    %rcx,%r10
    1c2e:	0f 05                	syscall
    1c30:	c3                   	ret

0000000000001c31 <pipe>:
    1c31:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    1c38:	49 89 ca             	mov    %rcx,%r10
    1c3b:	0f 05                	syscall
    1c3d:	c3                   	ret

0000000000001c3e <read>:
    1c3e:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    1c45:	49 89 ca             	mov    %rcx,%r10
    1c48:	0f 05                	syscall
    1c4a:	c3                   	ret

0000000000001c4b <write>:
    1c4b:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    1c52:	49 89 ca             	mov    %rcx,%r10
    1c55:	0f 05                	syscall
    1c57:	c3                   	ret

0000000000001c58 <close>:
    1c58:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    1c5f:	49 89 ca             	mov    %rcx,%r10
    1c62:	0f 05                	syscall
    1c64:	c3                   	ret

0000000000001c65 <kill>:
    1c65:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    1c6c:	49 89 ca             	mov    %rcx,%r10
    1c6f:	0f 05                	syscall
    1c71:	c3                   	ret

0000000000001c72 <exec>:
    1c72:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    1c79:	49 89 ca             	mov    %rcx,%r10
    1c7c:	0f 05                	syscall
    1c7e:	c3                   	ret

0000000000001c7f <open>:
    1c7f:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    1c86:	49 89 ca             	mov    %rcx,%r10
    1c89:	0f 05                	syscall
    1c8b:	c3                   	ret

0000000000001c8c <mknod>:
    1c8c:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    1c93:	49 89 ca             	mov    %rcx,%r10
    1c96:	0f 05                	syscall
    1c98:	c3                   	ret

0000000000001c99 <unlink>:
    1c99:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    1ca0:	49 89 ca             	mov    %rcx,%r10
    1ca3:	0f 05                	syscall
    1ca5:	c3                   	ret

0000000000001ca6 <fstat>:
    1ca6:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    1cad:	49 89 ca             	mov    %rcx,%r10
    1cb0:	0f 05                	syscall
    1cb2:	c3                   	ret

0000000000001cb3 <link>:
    1cb3:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    1cba:	49 89 ca             	mov    %rcx,%r10
    1cbd:	0f 05                	syscall
    1cbf:	c3                   	ret

0000000000001cc0 <mkdir>:
    1cc0:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    1cc7:	49 89 ca             	mov    %rcx,%r10
    1cca:	0f 05                	syscall
    1ccc:	c3                   	ret

0000000000001ccd <chdir>:
    1ccd:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    1cd4:	49 89 ca             	mov    %rcx,%r10
    1cd7:	0f 05                	syscall
    1cd9:	c3                   	ret

0000000000001cda <dup>:
    1cda:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    1ce1:	49 89 ca             	mov    %rcx,%r10
    1ce4:	0f 05                	syscall
    1ce6:	c3                   	ret

0000000000001ce7 <getpid>:
    1ce7:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    1cee:	49 89 ca             	mov    %rcx,%r10
    1cf1:	0f 05                	syscall
    1cf3:	c3                   	ret

0000000000001cf4 <sbrk>:
    1cf4:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    1cfb:	49 89 ca             	mov    %rcx,%r10
    1cfe:	0f 05                	syscall
    1d00:	c3                   	ret

0000000000001d01 <sleep>:
    1d01:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    1d08:	49 89 ca             	mov    %rcx,%r10
    1d0b:	0f 05                	syscall
    1d0d:	c3                   	ret

0000000000001d0e <uptime>:
    1d0e:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    1d15:	49 89 ca             	mov    %rcx,%r10
    1d18:	0f 05                	syscall
    1d1a:	c3                   	ret

0000000000001d1b <send>:
    1d1b:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    1d22:	49 89 ca             	mov    %rcx,%r10
    1d25:	0f 05                	syscall
    1d27:	c3                   	ret

0000000000001d28 <recv>:
    1d28:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    1d2f:	49 89 ca             	mov    %rcx,%r10
    1d32:	0f 05                	syscall
    1d34:	c3                   	ret

0000000000001d35 <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    1d35:	f3 0f 1e fa          	endbr64
    1d39:	55                   	push   %rbp
    1d3a:	48 89 e5             	mov    %rsp,%rbp
    1d3d:	48 83 ec 10          	sub    $0x10,%rsp
    1d41:	89 7d fc             	mov    %edi,-0x4(%rbp)
    1d44:	89 f0                	mov    %esi,%eax
    1d46:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    1d49:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    1d4d:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1d50:	ba 01 00 00 00       	mov    $0x1,%edx
    1d55:	48 89 ce             	mov    %rcx,%rsi
    1d58:	89 c7                	mov    %eax,%edi
    1d5a:	48 b8 4b 1c 00 00 00 	movabs $0x1c4b,%rax
    1d61:	00 00 00 
    1d64:	ff d0                	call   *%rax
}
    1d66:	90                   	nop
    1d67:	c9                   	leave
    1d68:	c3                   	ret

0000000000001d69 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    1d69:	f3 0f 1e fa          	endbr64
    1d6d:	55                   	push   %rbp
    1d6e:	48 89 e5             	mov    %rsp,%rbp
    1d71:	48 83 ec 20          	sub    $0x20,%rsp
    1d75:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1d78:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1d7c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1d83:	eb 35                	jmp    1dba <print_x64+0x51>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    1d85:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1d89:	48 c1 e8 3c          	shr    $0x3c,%rax
    1d8d:	48 ba 60 27 00 00 00 	movabs $0x2760,%rdx
    1d94:	00 00 00 
    1d97:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1d9b:	0f be d0             	movsbl %al,%edx
    1d9e:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1da1:	89 d6                	mov    %edx,%esi
    1da3:	89 c7                	mov    %eax,%edi
    1da5:	48 b8 35 1d 00 00 00 	movabs $0x1d35,%rax
    1dac:	00 00 00 
    1daf:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1db1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1db5:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    1dba:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1dbd:	83 f8 0f             	cmp    $0xf,%eax
    1dc0:	76 c3                	jbe    1d85 <print_x64+0x1c>
}
    1dc2:	90                   	nop
    1dc3:	90                   	nop
    1dc4:	c9                   	leave
    1dc5:	c3                   	ret

0000000000001dc6 <print_x32>:

  static void
print_x32(int fd, uint x)
{
    1dc6:	f3 0f 1e fa          	endbr64
    1dca:	55                   	push   %rbp
    1dcb:	48 89 e5             	mov    %rsp,%rbp
    1dce:	48 83 ec 20          	sub    $0x20,%rsp
    1dd2:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1dd5:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1dd8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1ddf:	eb 36                	jmp    1e17 <print_x32+0x51>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    1de1:	8b 45 e8             	mov    -0x18(%rbp),%eax
    1de4:	c1 e8 1c             	shr    $0x1c,%eax
    1de7:	89 c2                	mov    %eax,%edx
    1de9:	48 b8 60 27 00 00 00 	movabs $0x2760,%rax
    1df0:	00 00 00 
    1df3:	89 d2                	mov    %edx,%edx
    1df5:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    1df9:	0f be d0             	movsbl %al,%edx
    1dfc:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1dff:	89 d6                	mov    %edx,%esi
    1e01:	89 c7                	mov    %eax,%edi
    1e03:	48 b8 35 1d 00 00 00 	movabs $0x1d35,%rax
    1e0a:	00 00 00 
    1e0d:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1e0f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1e13:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    1e17:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1e1a:	83 f8 07             	cmp    $0x7,%eax
    1e1d:	76 c2                	jbe    1de1 <print_x32+0x1b>
}
    1e1f:	90                   	nop
    1e20:	90                   	nop
    1e21:	c9                   	leave
    1e22:	c3                   	ret

0000000000001e23 <print_d>:

  static void
print_d(int fd, int v)
{
    1e23:	f3 0f 1e fa          	endbr64
    1e27:	55                   	push   %rbp
    1e28:	48 89 e5             	mov    %rsp,%rbp
    1e2b:	48 83 ec 30          	sub    $0x30,%rsp
    1e2f:	89 7d dc             	mov    %edi,-0x24(%rbp)
    1e32:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    1e35:	8b 45 d8             	mov    -0x28(%rbp),%eax
    1e38:	48 98                	cltq
    1e3a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    1e3e:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1e42:	79 04                	jns    1e48 <print_d+0x25>
    x = -x;
    1e44:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    1e48:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    1e4f:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1e53:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1e5a:	66 66 66 
    1e5d:	48 89 c8             	mov    %rcx,%rax
    1e60:	48 f7 ea             	imul   %rdx
    1e63:	48 c1 fa 02          	sar    $0x2,%rdx
    1e67:	48 89 c8             	mov    %rcx,%rax
    1e6a:	48 c1 f8 3f          	sar    $0x3f,%rax
    1e6e:	48 29 c2             	sub    %rax,%rdx
    1e71:	48 89 d0             	mov    %rdx,%rax
    1e74:	48 c1 e0 02          	shl    $0x2,%rax
    1e78:	48 01 d0             	add    %rdx,%rax
    1e7b:	48 01 c0             	add    %rax,%rax
    1e7e:	48 29 c1             	sub    %rax,%rcx
    1e81:	48 89 ca             	mov    %rcx,%rdx
    1e84:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1e87:	8d 48 01             	lea    0x1(%rax),%ecx
    1e8a:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    1e8d:	48 b9 60 27 00 00 00 	movabs $0x2760,%rcx
    1e94:	00 00 00 
    1e97:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    1e9b:	48 98                	cltq
    1e9d:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    1ea1:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1ea5:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1eac:	66 66 66 
    1eaf:	48 89 c8             	mov    %rcx,%rax
    1eb2:	48 f7 ea             	imul   %rdx
    1eb5:	48 89 d0             	mov    %rdx,%rax
    1eb8:	48 c1 f8 02          	sar    $0x2,%rax
    1ebc:	48 c1 f9 3f          	sar    $0x3f,%rcx
    1ec0:	48 89 ca             	mov    %rcx,%rdx
    1ec3:	48 29 d0             	sub    %rdx,%rax
    1ec6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    1eca:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1ecf:	0f 85 7a ff ff ff    	jne    1e4f <print_d+0x2c>

  if (v < 0)
    1ed5:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1ed9:	79 32                	jns    1f0d <print_d+0xea>
    buf[i++] = '-';
    1edb:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1ede:	8d 50 01             	lea    0x1(%rax),%edx
    1ee1:	89 55 f4             	mov    %edx,-0xc(%rbp)
    1ee4:	48 98                	cltq
    1ee6:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    1eeb:	eb 20                	jmp    1f0d <print_d+0xea>
    putc(fd, buf[i]);
    1eed:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1ef0:	48 98                	cltq
    1ef2:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    1ef7:	0f be d0             	movsbl %al,%edx
    1efa:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1efd:	89 d6                	mov    %edx,%esi
    1eff:	89 c7                	mov    %eax,%edi
    1f01:	48 b8 35 1d 00 00 00 	movabs $0x1d35,%rax
    1f08:	00 00 00 
    1f0b:	ff d0                	call   *%rax
  while (--i >= 0)
    1f0d:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    1f11:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1f15:	79 d6                	jns    1eed <print_d+0xca>
}
    1f17:	90                   	nop
    1f18:	90                   	nop
    1f19:	c9                   	leave
    1f1a:	c3                   	ret

0000000000001f1b <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    1f1b:	f3 0f 1e fa          	endbr64
    1f1f:	55                   	push   %rbp
    1f20:	48 89 e5             	mov    %rsp,%rbp
    1f23:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    1f2a:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    1f30:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    1f37:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    1f3e:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    1f45:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    1f4c:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    1f53:	84 c0                	test   %al,%al
    1f55:	74 20                	je     1f77 <printf+0x5c>
    1f57:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    1f5b:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    1f5f:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    1f63:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    1f67:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    1f6b:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    1f6f:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    1f73:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    1f77:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    1f7e:	00 00 00 
    1f81:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    1f88:	00 00 00 
    1f8b:	48 8d 45 10          	lea    0x10(%rbp),%rax
    1f8f:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    1f96:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    1f9d:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1fa4:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    1fab:	00 00 00 
    1fae:	e9 41 03 00 00       	jmp    22f4 <printf+0x3d9>
    if (c != '%') {
    1fb3:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1fba:	74 24                	je     1fe0 <printf+0xc5>
      putc(fd, c);
    1fbc:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1fc2:	0f be d0             	movsbl %al,%edx
    1fc5:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1fcb:	89 d6                	mov    %edx,%esi
    1fcd:	89 c7                	mov    %eax,%edi
    1fcf:	48 b8 35 1d 00 00 00 	movabs $0x1d35,%rax
    1fd6:	00 00 00 
    1fd9:	ff d0                	call   *%rax
      continue;
    1fdb:	e9 0d 03 00 00       	jmp    22ed <printf+0x3d2>
    }
    c = fmt[++i] & 0xff;
    1fe0:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1fe7:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1fed:	48 63 d0             	movslq %eax,%rdx
    1ff0:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1ff7:	48 01 d0             	add    %rdx,%rax
    1ffa:	0f b6 00             	movzbl (%rax),%eax
    1ffd:	0f be c0             	movsbl %al,%eax
    2000:	25 ff 00 00 00       	and    $0xff,%eax
    2005:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    200b:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    2012:	0f 84 0f 03 00 00    	je     2327 <printf+0x40c>
      break;
    switch(c) {
    2018:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    201f:	0f 84 74 02 00 00    	je     2299 <printf+0x37e>
    2025:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    202c:	0f 8c 82 02 00 00    	jl     22b4 <printf+0x399>
    2032:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    2039:	0f 8f 75 02 00 00    	jg     22b4 <printf+0x399>
    203f:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    2046:	0f 8c 68 02 00 00    	jl     22b4 <printf+0x399>
    204c:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    2052:	83 e8 63             	sub    $0x63,%eax
    2055:	83 f8 15             	cmp    $0x15,%eax
    2058:	0f 87 56 02 00 00    	ja     22b4 <printf+0x399>
    205e:	89 c0                	mov    %eax,%eax
    2060:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    2067:	00 
    2068:	48 b8 b0 26 00 00 00 	movabs $0x26b0,%rax
    206f:	00 00 00 
    2072:	48 01 d0             	add    %rdx,%rax
    2075:	48 8b 00             	mov    (%rax),%rax
    2078:	3e ff e0             	notrack jmp *%rax
    case 'c':
      putc(fd, va_arg(ap, int));
    207b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    2081:	83 f8 2f             	cmp    $0x2f,%eax
    2084:	77 23                	ja     20a9 <printf+0x18e>
    2086:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    208d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    2093:	89 d2                	mov    %edx,%edx
    2095:	48 01 d0             	add    %rdx,%rax
    2098:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    209e:	83 c2 08             	add    $0x8,%edx
    20a1:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    20a7:	eb 12                	jmp    20bb <printf+0x1a0>
    20a9:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    20b0:	48 8d 50 08          	lea    0x8(%rax),%rdx
    20b4:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    20bb:	8b 00                	mov    (%rax),%eax
    20bd:	0f be d0             	movsbl %al,%edx
    20c0:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    20c6:	89 d6                	mov    %edx,%esi
    20c8:	89 c7                	mov    %eax,%edi
    20ca:	48 b8 35 1d 00 00 00 	movabs $0x1d35,%rax
    20d1:	00 00 00 
    20d4:	ff d0                	call   *%rax
      break;
    20d6:	e9 12 02 00 00       	jmp    22ed <printf+0x3d2>
    case 'd':
      print_d(fd, va_arg(ap, int));
    20db:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    20e1:	83 f8 2f             	cmp    $0x2f,%eax
    20e4:	77 23                	ja     2109 <printf+0x1ee>
    20e6:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    20ed:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    20f3:	89 d2                	mov    %edx,%edx
    20f5:	48 01 d0             	add    %rdx,%rax
    20f8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    20fe:	83 c2 08             	add    $0x8,%edx
    2101:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    2107:	eb 12                	jmp    211b <printf+0x200>
    2109:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    2110:	48 8d 50 08          	lea    0x8(%rax),%rdx
    2114:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    211b:	8b 10                	mov    (%rax),%edx
    211d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    2123:	89 d6                	mov    %edx,%esi
    2125:	89 c7                	mov    %eax,%edi
    2127:	48 b8 23 1e 00 00 00 	movabs $0x1e23,%rax
    212e:	00 00 00 
    2131:	ff d0                	call   *%rax
      break;
    2133:	e9 b5 01 00 00       	jmp    22ed <printf+0x3d2>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    2138:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    213e:	83 f8 2f             	cmp    $0x2f,%eax
    2141:	77 23                	ja     2166 <printf+0x24b>
    2143:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    214a:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    2150:	89 d2                	mov    %edx,%edx
    2152:	48 01 d0             	add    %rdx,%rax
    2155:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    215b:	83 c2 08             	add    $0x8,%edx
    215e:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    2164:	eb 12                	jmp    2178 <printf+0x25d>
    2166:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    216d:	48 8d 50 08          	lea    0x8(%rax),%rdx
    2171:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    2178:	8b 10                	mov    (%rax),%edx
    217a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    2180:	89 d6                	mov    %edx,%esi
    2182:	89 c7                	mov    %eax,%edi
    2184:	48 b8 c6 1d 00 00 00 	movabs $0x1dc6,%rax
    218b:	00 00 00 
    218e:	ff d0                	call   *%rax
      break;
    2190:	e9 58 01 00 00       	jmp    22ed <printf+0x3d2>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    2195:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    219b:	83 f8 2f             	cmp    $0x2f,%eax
    219e:	77 23                	ja     21c3 <printf+0x2a8>
    21a0:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    21a7:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    21ad:	89 d2                	mov    %edx,%edx
    21af:	48 01 d0             	add    %rdx,%rax
    21b2:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    21b8:	83 c2 08             	add    $0x8,%edx
    21bb:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    21c1:	eb 12                	jmp    21d5 <printf+0x2ba>
    21c3:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    21ca:	48 8d 50 08          	lea    0x8(%rax),%rdx
    21ce:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    21d5:	48 8b 10             	mov    (%rax),%rdx
    21d8:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    21de:	48 89 d6             	mov    %rdx,%rsi
    21e1:	89 c7                	mov    %eax,%edi
    21e3:	48 b8 69 1d 00 00 00 	movabs $0x1d69,%rax
    21ea:	00 00 00 
    21ed:	ff d0                	call   *%rax
      break;
    21ef:	e9 f9 00 00 00       	jmp    22ed <printf+0x3d2>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    21f4:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    21fa:	83 f8 2f             	cmp    $0x2f,%eax
    21fd:	77 23                	ja     2222 <printf+0x307>
    21ff:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    2206:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    220c:	89 d2                	mov    %edx,%edx
    220e:	48 01 d0             	add    %rdx,%rax
    2211:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    2217:	83 c2 08             	add    $0x8,%edx
    221a:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    2220:	eb 12                	jmp    2234 <printf+0x319>
    2222:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    2229:	48 8d 50 08          	lea    0x8(%rax),%rdx
    222d:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    2234:	48 8b 00             	mov    (%rax),%rax
    2237:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    223e:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    2245:	00 
    2246:	75 41                	jne    2289 <printf+0x36e>
        s = "(null)";
    2248:	48 b8 a8 26 00 00 00 	movabs $0x26a8,%rax
    224f:	00 00 00 
    2252:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    2259:	eb 2e                	jmp    2289 <printf+0x36e>
        putc(fd, *(s++));
    225b:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    2262:	48 8d 50 01          	lea    0x1(%rax),%rdx
    2266:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    226d:	0f b6 00             	movzbl (%rax),%eax
    2270:	0f be d0             	movsbl %al,%edx
    2273:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    2279:	89 d6                	mov    %edx,%esi
    227b:	89 c7                	mov    %eax,%edi
    227d:	48 b8 35 1d 00 00 00 	movabs $0x1d35,%rax
    2284:	00 00 00 
    2287:	ff d0                	call   *%rax
      while (*s)
    2289:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    2290:	0f b6 00             	movzbl (%rax),%eax
    2293:	84 c0                	test   %al,%al
    2295:	75 c4                	jne    225b <printf+0x340>
      break;
    2297:	eb 54                	jmp    22ed <printf+0x3d2>
    case '%':
      putc(fd, '%');
    2299:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    229f:	be 25 00 00 00       	mov    $0x25,%esi
    22a4:	89 c7                	mov    %eax,%edi
    22a6:	48 b8 35 1d 00 00 00 	movabs $0x1d35,%rax
    22ad:	00 00 00 
    22b0:	ff d0                	call   *%rax
      break;
    22b2:	eb 39                	jmp    22ed <printf+0x3d2>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    22b4:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    22ba:	be 25 00 00 00       	mov    $0x25,%esi
    22bf:	89 c7                	mov    %eax,%edi
    22c1:	48 b8 35 1d 00 00 00 	movabs $0x1d35,%rax
    22c8:	00 00 00 
    22cb:	ff d0                	call   *%rax
      putc(fd, c);
    22cd:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    22d3:	0f be d0             	movsbl %al,%edx
    22d6:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    22dc:	89 d6                	mov    %edx,%esi
    22de:	89 c7                	mov    %eax,%edi
    22e0:	48 b8 35 1d 00 00 00 	movabs $0x1d35,%rax
    22e7:	00 00 00 
    22ea:	ff d0                	call   *%rax
      break;
    22ec:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    22ed:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    22f4:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    22fa:	48 63 d0             	movslq %eax,%rdx
    22fd:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    2304:	48 01 d0             	add    %rdx,%rax
    2307:	0f b6 00             	movzbl (%rax),%eax
    230a:	0f be c0             	movsbl %al,%eax
    230d:	25 ff 00 00 00       	and    $0xff,%eax
    2312:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    2318:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    231f:	0f 85 8e fc ff ff    	jne    1fb3 <printf+0x98>
    }
  }
}
    2325:	eb 01                	jmp    2328 <printf+0x40d>
      break;
    2327:	90                   	nop
}
    2328:	90                   	nop
    2329:	c9                   	leave
    232a:	c3                   	ret

000000000000232b <free>:
    232b:	55                   	push   %rbp
    232c:	48 89 e5             	mov    %rsp,%rbp
    232f:	48 83 ec 18          	sub    $0x18,%rsp
    2333:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    2337:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    233b:	48 83 e8 10          	sub    $0x10,%rax
    233f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    2343:	48 b8 90 2a 00 00 00 	movabs $0x2a90,%rax
    234a:	00 00 00 
    234d:	48 8b 00             	mov    (%rax),%rax
    2350:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    2354:	eb 2f                	jmp    2385 <free+0x5a>
    2356:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    235a:	48 8b 00             	mov    (%rax),%rax
    235d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    2361:	72 17                	jb     237a <free+0x4f>
    2363:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2367:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    236b:	72 2f                	jb     239c <free+0x71>
    236d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2371:	48 8b 00             	mov    (%rax),%rax
    2374:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    2378:	72 22                	jb     239c <free+0x71>
    237a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    237e:	48 8b 00             	mov    (%rax),%rax
    2381:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    2385:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2389:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    238d:	73 c7                	jae    2356 <free+0x2b>
    238f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2393:	48 8b 00             	mov    (%rax),%rax
    2396:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    239a:	73 ba                	jae    2356 <free+0x2b>
    239c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    23a0:	8b 40 08             	mov    0x8(%rax),%eax
    23a3:	89 c0                	mov    %eax,%eax
    23a5:	48 c1 e0 04          	shl    $0x4,%rax
    23a9:	48 89 c2             	mov    %rax,%rdx
    23ac:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    23b0:	48 01 c2             	add    %rax,%rdx
    23b3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    23b7:	48 8b 00             	mov    (%rax),%rax
    23ba:	48 39 c2             	cmp    %rax,%rdx
    23bd:	75 2d                	jne    23ec <free+0xc1>
    23bf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    23c3:	8b 50 08             	mov    0x8(%rax),%edx
    23c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    23ca:	48 8b 00             	mov    (%rax),%rax
    23cd:	8b 40 08             	mov    0x8(%rax),%eax
    23d0:	01 c2                	add    %eax,%edx
    23d2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    23d6:	89 50 08             	mov    %edx,0x8(%rax)
    23d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    23dd:	48 8b 00             	mov    (%rax),%rax
    23e0:	48 8b 10             	mov    (%rax),%rdx
    23e3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    23e7:	48 89 10             	mov    %rdx,(%rax)
    23ea:	eb 0e                	jmp    23fa <free+0xcf>
    23ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    23f0:	48 8b 10             	mov    (%rax),%rdx
    23f3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    23f7:	48 89 10             	mov    %rdx,(%rax)
    23fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    23fe:	8b 40 08             	mov    0x8(%rax),%eax
    2401:	89 c0                	mov    %eax,%eax
    2403:	48 c1 e0 04          	shl    $0x4,%rax
    2407:	48 89 c2             	mov    %rax,%rdx
    240a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    240e:	48 01 d0             	add    %rdx,%rax
    2411:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    2415:	75 27                	jne    243e <free+0x113>
    2417:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    241b:	8b 50 08             	mov    0x8(%rax),%edx
    241e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2422:	8b 40 08             	mov    0x8(%rax),%eax
    2425:	01 c2                	add    %eax,%edx
    2427:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    242b:	89 50 08             	mov    %edx,0x8(%rax)
    242e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2432:	48 8b 10             	mov    (%rax),%rdx
    2435:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2439:	48 89 10             	mov    %rdx,(%rax)
    243c:	eb 0b                	jmp    2449 <free+0x11e>
    243e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2442:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    2446:	48 89 10             	mov    %rdx,(%rax)
    2449:	48 ba 90 2a 00 00 00 	movabs $0x2a90,%rdx
    2450:	00 00 00 
    2453:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2457:	48 89 02             	mov    %rax,(%rdx)
    245a:	90                   	nop
    245b:	c9                   	leave
    245c:	c3                   	ret

000000000000245d <morecore>:
    245d:	55                   	push   %rbp
    245e:	48 89 e5             	mov    %rsp,%rbp
    2461:	48 83 ec 20          	sub    $0x20,%rsp
    2465:	89 7d ec             	mov    %edi,-0x14(%rbp)
    2468:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    246f:	77 07                	ja     2478 <morecore+0x1b>
    2471:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
    2478:	8b 45 ec             	mov    -0x14(%rbp),%eax
    247b:	48 c1 e0 04          	shl    $0x4,%rax
    247f:	48 89 c7             	mov    %rax,%rdi
    2482:	48 b8 f4 1c 00 00 00 	movabs $0x1cf4,%rax
    2489:	00 00 00 
    248c:	ff d0                	call   *%rax
    248e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    2492:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    2497:	75 07                	jne    24a0 <morecore+0x43>
    2499:	b8 00 00 00 00       	mov    $0x0,%eax
    249e:	eb 36                	jmp    24d6 <morecore+0x79>
    24a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    24a4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    24a8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    24ac:	8b 55 ec             	mov    -0x14(%rbp),%edx
    24af:	89 50 08             	mov    %edx,0x8(%rax)
    24b2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    24b6:	48 83 c0 10          	add    $0x10,%rax
    24ba:	48 89 c7             	mov    %rax,%rdi
    24bd:	48 b8 2b 23 00 00 00 	movabs $0x232b,%rax
    24c4:	00 00 00 
    24c7:	ff d0                	call   *%rax
    24c9:	48 b8 90 2a 00 00 00 	movabs $0x2a90,%rax
    24d0:	00 00 00 
    24d3:	48 8b 00             	mov    (%rax),%rax
    24d6:	c9                   	leave
    24d7:	c3                   	ret

00000000000024d8 <malloc>:
    24d8:	55                   	push   %rbp
    24d9:	48 89 e5             	mov    %rsp,%rbp
    24dc:	48 83 ec 30          	sub    $0x30,%rsp
    24e0:	89 7d dc             	mov    %edi,-0x24(%rbp)
    24e3:	8b 45 dc             	mov    -0x24(%rbp),%eax
    24e6:	48 83 c0 0f          	add    $0xf,%rax
    24ea:	48 c1 e8 04          	shr    $0x4,%rax
    24ee:	83 c0 01             	add    $0x1,%eax
    24f1:	89 45 ec             	mov    %eax,-0x14(%rbp)
    24f4:	48 b8 90 2a 00 00 00 	movabs $0x2a90,%rax
    24fb:	00 00 00 
    24fe:	48 8b 00             	mov    (%rax),%rax
    2501:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    2505:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    250a:	75 4a                	jne    2556 <malloc+0x7e>
    250c:	48 b8 80 2a 00 00 00 	movabs $0x2a80,%rax
    2513:	00 00 00 
    2516:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    251a:	48 ba 90 2a 00 00 00 	movabs $0x2a90,%rdx
    2521:	00 00 00 
    2524:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2528:	48 89 02             	mov    %rax,(%rdx)
    252b:	48 b8 90 2a 00 00 00 	movabs $0x2a90,%rax
    2532:	00 00 00 
    2535:	48 8b 00             	mov    (%rax),%rax
    2538:	48 ba 80 2a 00 00 00 	movabs $0x2a80,%rdx
    253f:	00 00 00 
    2542:	48 89 02             	mov    %rax,(%rdx)
    2545:	48 b8 80 2a 00 00 00 	movabs $0x2a80,%rax
    254c:	00 00 00 
    254f:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
    2556:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    255a:	48 8b 00             	mov    (%rax),%rax
    255d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    2561:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2565:	8b 40 08             	mov    0x8(%rax),%eax
    2568:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    256b:	72 65                	jb     25d2 <malloc+0xfa>
    256d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2571:	8b 40 08             	mov    0x8(%rax),%eax
    2574:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    2577:	75 10                	jne    2589 <malloc+0xb1>
    2579:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    257d:	48 8b 10             	mov    (%rax),%rdx
    2580:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2584:	48 89 10             	mov    %rdx,(%rax)
    2587:	eb 2e                	jmp    25b7 <malloc+0xdf>
    2589:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    258d:	8b 40 08             	mov    0x8(%rax),%eax
    2590:	2b 45 ec             	sub    -0x14(%rbp),%eax
    2593:	89 c2                	mov    %eax,%edx
    2595:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2599:	89 50 08             	mov    %edx,0x8(%rax)
    259c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    25a0:	8b 40 08             	mov    0x8(%rax),%eax
    25a3:	89 c0                	mov    %eax,%eax
    25a5:	48 c1 e0 04          	shl    $0x4,%rax
    25a9:	48 01 45 f8          	add    %rax,-0x8(%rbp)
    25ad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    25b1:	8b 55 ec             	mov    -0x14(%rbp),%edx
    25b4:	89 50 08             	mov    %edx,0x8(%rax)
    25b7:	48 ba 90 2a 00 00 00 	movabs $0x2a90,%rdx
    25be:	00 00 00 
    25c1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    25c5:	48 89 02             	mov    %rax,(%rdx)
    25c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    25cc:	48 83 c0 10          	add    $0x10,%rax
    25d0:	eb 4e                	jmp    2620 <malloc+0x148>
    25d2:	48 b8 90 2a 00 00 00 	movabs $0x2a90,%rax
    25d9:	00 00 00 
    25dc:	48 8b 00             	mov    (%rax),%rax
    25df:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    25e3:	75 23                	jne    2608 <malloc+0x130>
    25e5:	8b 45 ec             	mov    -0x14(%rbp),%eax
    25e8:	89 c7                	mov    %eax,%edi
    25ea:	48 b8 5d 24 00 00 00 	movabs $0x245d,%rax
    25f1:	00 00 00 
    25f4:	ff d0                	call   *%rax
    25f6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    25fa:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    25ff:	75 07                	jne    2608 <malloc+0x130>
    2601:	b8 00 00 00 00       	mov    $0x0,%eax
    2606:	eb 18                	jmp    2620 <malloc+0x148>
    2608:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    260c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    2610:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2614:	48 8b 00             	mov    (%rax),%rax
    2617:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    261b:	e9 41 ff ff ff       	jmp    2561 <malloc+0x89>
    2620:	c9                   	leave
    2621:	c3                   	ret
