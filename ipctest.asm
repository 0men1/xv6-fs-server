
_ipctest:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <server>:
// target PIDs, receiver exit while sender is blocked, multiple clients sending
// to one server, repeated send/recv loops, and maximum-size payloads. Why:
// Phase 3 depends on IPC being reliable under the same pressure that fsserver
// will create.

void server() {
    1000:	f3 0f 1e fa          	endbr64
    1004:	55                   	push   %rbp
    1005:	48 89 e5             	mov    %rsp,%rbp
    1008:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    struct ipc_msg msg;
    printf(1, "Server: waiting for message...\n");
    100f:	48 b8 18 21 00 00 00 	movabs $0x2118,%rax
    1016:	00 00 00 
    1019:	48 89 c6             	mov    %rax,%rsi
    101c:	bf 01 00 00 00       	mov    $0x1,%edi
    1021:	b8 00 00 00 00       	mov    $0x0,%eax
    1026:	48 ba 04 1a 00 00 00 	movabs $0x1a04,%rdx
    102d:	00 00 00 
    1030:	ff d2                	call   *%rdx
    
    if (recv(&msg) < 0) {
    1032:	48 8d 85 10 ff ff ff 	lea    -0xf0(%rbp),%rax
    1039:	48 89 c7             	mov    %rax,%rdi
    103c:	48 b8 04 18 00 00 00 	movabs $0x1804,%rax
    1043:	00 00 00 
    1046:	ff d0                	call   *%rax
    1048:	85 c0                	test   %eax,%eax
    104a:	79 2f                	jns    107b <server+0x7b>
        printf(1, "Server: receive failed\n");
    104c:	48 b8 38 21 00 00 00 	movabs $0x2138,%rax
    1053:	00 00 00 
    1056:	48 89 c6             	mov    %rax,%rsi
    1059:	bf 01 00 00 00       	mov    $0x1,%edi
    105e:	b8 00 00 00 00       	mov    $0x0,%eax
    1063:	48 ba 04 1a 00 00 00 	movabs $0x1a04,%rdx
    106a:	00 00 00 
    106d:	ff d2                	call   *%rdx
        exit();
    106f:	48 b8 f3 16 00 00 00 	movabs $0x16f3,%rax
    1076:	00 00 00 
    1079:	ff d0                	call   *%rax
    }

    printf(1, "Server: received from PID %d: %s\n", msg.sender_pid, msg.data);
    107b:	8b 85 10 ff ff ff    	mov    -0xf0(%rbp),%eax
    1081:	48 8d 95 10 ff ff ff 	lea    -0xf0(%rbp),%rdx
    1088:	48 83 c2 60          	add    $0x60,%rdx
    108c:	48 89 d1             	mov    %rdx,%rcx
    108f:	89 c2                	mov    %eax,%edx
    1091:	48 b8 50 21 00 00 00 	movabs $0x2150,%rax
    1098:	00 00 00 
    109b:	48 89 c6             	mov    %rax,%rsi
    109e:	bf 01 00 00 00       	mov    $0x1,%edi
    10a3:	b8 00 00 00 00       	mov    $0x0,%eax
    10a8:	49 b8 04 1a 00 00 00 	movabs $0x1a04,%r8
    10af:	00 00 00 
    10b2:	41 ff d0             	call   *%r8
    
    int client_pid = msg.sender_pid;
    10b5:	8b 85 10 ff ff ff    	mov    -0xf0(%rbp),%eax
    10bb:	89 45 fc             	mov    %eax,-0x4(%rbp)
    msg.sender_pid = getpid();
    10be:	48 b8 c3 17 00 00 00 	movabs $0x17c3,%rax
    10c5:	00 00 00 
    10c8:	ff d0                	call   *%rax
    10ca:	89 85 10 ff ff ff    	mov    %eax,-0xf0(%rbp)
    strcpy(msg.data, "ACK");
    10d0:	48 8d 85 10 ff ff ff 	lea    -0xf0(%rbp),%rax
    10d7:	48 83 c0 60          	add    $0x60,%rax
    10db:	48 ba 72 21 00 00 00 	movabs $0x2172,%rdx
    10e2:	00 00 00 
    10e5:	48 89 d6             	mov    %rdx,%rsi
    10e8:	48 89 c7             	mov    %rax,%rdi
    10eb:	48 b8 ea 13 00 00 00 	movabs $0x13ea,%rax
    10f2:	00 00 00 
    10f5:	ff d0                	call   *%rax
    
    if (send(client_pid, &msg) < 0) {
    10f7:	48 8d 95 10 ff ff ff 	lea    -0xf0(%rbp),%rdx
    10fe:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1101:	48 89 d6             	mov    %rdx,%rsi
    1104:	89 c7                	mov    %eax,%edi
    1106:	48 b8 f7 17 00 00 00 	movabs $0x17f7,%rax
    110d:	00 00 00 
    1110:	ff d0                	call   *%rax
    1112:	85 c0                	test   %eax,%eax
    1114:	79 23                	jns    1139 <server+0x139>
        printf(1, "Server: send failed\n");
    1116:	48 b8 76 21 00 00 00 	movabs $0x2176,%rax
    111d:	00 00 00 
    1120:	48 89 c6             	mov    %rax,%rsi
    1123:	bf 01 00 00 00       	mov    $0x1,%edi
    1128:	b8 00 00 00 00       	mov    $0x0,%eax
    112d:	48 ba 04 1a 00 00 00 	movabs $0x1a04,%rdx
    1134:	00 00 00 
    1137:	ff d2                	call   *%rdx
    }
    exit();
    1139:	48 b8 f3 16 00 00 00 	movabs $0x16f3,%rax
    1140:	00 00 00 
    1143:	ff d0                	call   *%rax

0000000000001145 <client>:
}

void client(int server_pid) {
    1145:	f3 0f 1e fa          	endbr64
    1149:	55                   	push   %rbp
    114a:	48 89 e5             	mov    %rsp,%rbp
    114d:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    1154:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    struct ipc_msg msg;
    memset(&msg, 0, sizeof(msg));
    115a:	48 8d 85 20 ff ff ff 	lea    -0xe0(%rbp),%rax
    1161:	ba e0 00 00 00       	mov    $0xe0,%edx
    1166:	be 00 00 00 00       	mov    $0x0,%esi
    116b:	48 89 c7             	mov    %rax,%rdi
    116e:	48 b8 be 14 00 00 00 	movabs $0x14be,%rax
    1175:	00 00 00 
    1178:	ff d0                	call   *%rax
    msg.sender_pid = getpid();
    117a:	48 b8 c3 17 00 00 00 	movabs $0x17c3,%rax
    1181:	00 00 00 
    1184:	ff d0                	call   *%rax
    1186:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%rbp)
    msg.type = IPC_TYPE_FS_OPEN;
    118c:	c7 85 28 ff ff ff 01 	movl   $0x1,-0xd8(%rbp)
    1193:	00 00 00 
    strcpy(msg.data, "REQ_FS_OPEN");
    1196:	48 8d 85 20 ff ff ff 	lea    -0xe0(%rbp),%rax
    119d:	48 83 c0 60          	add    $0x60,%rax
    11a1:	48 ba 8b 21 00 00 00 	movabs $0x218b,%rdx
    11a8:	00 00 00 
    11ab:	48 89 d6             	mov    %rdx,%rsi
    11ae:	48 89 c7             	mov    %rax,%rdi
    11b1:	48 b8 ea 13 00 00 00 	movabs $0x13ea,%rax
    11b8:	00 00 00 
    11bb:	ff d0                	call   *%rax

    if (send(9999, &msg) == 0) {
    11bd:	48 8d 85 20 ff ff ff 	lea    -0xe0(%rbp),%rax
    11c4:	48 89 c6             	mov    %rax,%rsi
    11c7:	bf 0f 27 00 00       	mov    $0x270f,%edi
    11cc:	48 b8 f7 17 00 00 00 	movabs $0x17f7,%rax
    11d3:	00 00 00 
    11d6:	ff d0                	call   *%rax
    11d8:	85 c0                	test   %eax,%eax
    11da:	75 2f                	jne    120b <client+0xc6>
        printf(1, "Client: invalid PID send unexpectedly worked\n");
    11dc:	48 b8 98 21 00 00 00 	movabs $0x2198,%rax
    11e3:	00 00 00 
    11e6:	48 89 c6             	mov    %rax,%rsi
    11e9:	bf 01 00 00 00       	mov    $0x1,%edi
    11ee:	b8 00 00 00 00       	mov    $0x0,%eax
    11f3:	48 ba 04 1a 00 00 00 	movabs $0x1a04,%rdx
    11fa:	00 00 00 
    11fd:	ff d2                	call   *%rdx
        exit();
    11ff:	48 b8 f3 16 00 00 00 	movabs $0x16f3,%rax
    1206:	00 00 00 
    1209:	ff d0                	call   *%rax
    }

    printf(1, "Client: sending to PID %d\n", server_pid);
    120b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1211:	89 c2                	mov    %eax,%edx
    1213:	48 b8 c6 21 00 00 00 	movabs $0x21c6,%rax
    121a:	00 00 00 
    121d:	48 89 c6             	mov    %rax,%rsi
    1220:	bf 01 00 00 00       	mov    $0x1,%edi
    1225:	b8 00 00 00 00       	mov    $0x0,%eax
    122a:	48 b9 04 1a 00 00 00 	movabs $0x1a04,%rcx
    1231:	00 00 00 
    1234:	ff d1                	call   *%rcx
    
    if (send(server_pid, &msg) < 0) {
    1236:	48 8d 95 20 ff ff ff 	lea    -0xe0(%rbp),%rdx
    123d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1243:	48 89 d6             	mov    %rdx,%rsi
    1246:	89 c7                	mov    %eax,%edi
    1248:	48 b8 f7 17 00 00 00 	movabs $0x17f7,%rax
    124f:	00 00 00 
    1252:	ff d0                	call   *%rax
    1254:	85 c0                	test   %eax,%eax
    1256:	79 2f                	jns    1287 <client+0x142>
        printf(1, "Client: send failed\n");
    1258:	48 b8 e1 21 00 00 00 	movabs $0x21e1,%rax
    125f:	00 00 00 
    1262:	48 89 c6             	mov    %rax,%rsi
    1265:	bf 01 00 00 00       	mov    $0x1,%edi
    126a:	b8 00 00 00 00       	mov    $0x0,%eax
    126f:	48 ba 04 1a 00 00 00 	movabs $0x1a04,%rdx
    1276:	00 00 00 
    1279:	ff d2                	call   *%rdx
        exit();
    127b:	48 b8 f3 16 00 00 00 	movabs $0x16f3,%rax
    1282:	00 00 00 
    1285:	ff d0                	call   *%rax
    }

    if (recv(&msg) < 0) {
    1287:	48 8d 85 20 ff ff ff 	lea    -0xe0(%rbp),%rax
    128e:	48 89 c7             	mov    %rax,%rdi
    1291:	48 b8 04 18 00 00 00 	movabs $0x1804,%rax
    1298:	00 00 00 
    129b:	ff d0                	call   *%rax
    129d:	85 c0                	test   %eax,%eax
    129f:	79 2f                	jns    12d0 <client+0x18b>
        printf(1, "Client: receive failed\n");
    12a1:	48 b8 f6 21 00 00 00 	movabs $0x21f6,%rax
    12a8:	00 00 00 
    12ab:	48 89 c6             	mov    %rax,%rsi
    12ae:	bf 01 00 00 00       	mov    $0x1,%edi
    12b3:	b8 00 00 00 00       	mov    $0x0,%eax
    12b8:	48 ba 04 1a 00 00 00 	movabs $0x1a04,%rdx
    12bf:	00 00 00 
    12c2:	ff d2                	call   *%rdx
        exit();
    12c4:	48 b8 f3 16 00 00 00 	movabs $0x16f3,%rax
    12cb:	00 00 00 
    12ce:	ff d0                	call   *%rax
    }

    printf(1, "Client: server responded with: %s\n", msg.data);
    12d0:	48 8d 85 20 ff ff ff 	lea    -0xe0(%rbp),%rax
    12d7:	48 83 c0 60          	add    $0x60,%rax
    12db:	48 89 c2             	mov    %rax,%rdx
    12de:	48 b8 10 22 00 00 00 	movabs $0x2210,%rax
    12e5:	00 00 00 
    12e8:	48 89 c6             	mov    %rax,%rsi
    12eb:	bf 01 00 00 00       	mov    $0x1,%edi
    12f0:	b8 00 00 00 00       	mov    $0x0,%eax
    12f5:	48 b9 04 1a 00 00 00 	movabs $0x1a04,%rcx
    12fc:	00 00 00 
    12ff:	ff d1                	call   *%rcx
    exit();
    1301:	48 b8 f3 16 00 00 00 	movabs $0x16f3,%rax
    1308:	00 00 00 
    130b:	ff d0                	call   *%rax

000000000000130d <main>:
}

int main(void) {
    130d:	f3 0f 1e fa          	endbr64
    1311:	55                   	push   %rbp
    1312:	48 89 e5             	mov    %rsp,%rbp
    1315:	48 83 ec 10          	sub    $0x10,%rsp
    int pid = fork();
    1319:	48 b8 e6 16 00 00 00 	movabs $0x16e6,%rax
    1320:	00 00 00 
    1323:	ff d0                	call   *%rax
    1325:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (pid < 0) {
    1328:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    132c:	79 2f                	jns    135d <main+0x50>
        printf(1, "Fork failed\n");
    132e:	48 b8 33 22 00 00 00 	movabs $0x2233,%rax
    1335:	00 00 00 
    1338:	48 89 c6             	mov    %rax,%rsi
    133b:	bf 01 00 00 00       	mov    $0x1,%edi
    1340:	b8 00 00 00 00       	mov    $0x0,%eax
    1345:	48 ba 04 1a 00 00 00 	movabs $0x1a04,%rdx
    134c:	00 00 00 
    134f:	ff d2                	call   *%rdx
        exit();
    1351:	48 b8 f3 16 00 00 00 	movabs $0x16f3,%rax
    1358:	00 00 00 
    135b:	ff d0                	call   *%rax
    }

    if (pid == 0) {
    135d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1361:	75 13                	jne    1376 <main+0x69>
        server();
    1363:	b8 00 00 00 00       	mov    $0x0,%eax
    1368:	48 ba 00 10 00 00 00 	movabs $0x1000,%rdx
    136f:	00 00 00 
    1372:	ff d2                	call   *%rdx
    1374:	eb 22                	jmp    1398 <main+0x8b>
    } else {
        // Give the server a moment to enter recv()
        sleep(10); 
    1376:	bf 0a 00 00 00       	mov    $0xa,%edi
    137b:	48 b8 dd 17 00 00 00 	movabs $0x17dd,%rax
    1382:	00 00 00 
    1385:	ff d0                	call   *%rax
        client(pid);
    1387:	8b 45 fc             	mov    -0x4(%rbp),%eax
    138a:	89 c7                	mov    %eax,%edi
    138c:	48 b8 45 11 00 00 00 	movabs $0x1145,%rax
    1393:	00 00 00 
    1396:	ff d0                	call   *%rax
    }

    wait();
    1398:	48 b8 00 17 00 00 00 	movabs $0x1700,%rax
    139f:	00 00 00 
    13a2:	ff d0                	call   *%rax
    exit();
    13a4:	48 b8 f3 16 00 00 00 	movabs $0x16f3,%rax
    13ab:	00 00 00 
    13ae:	ff d0                	call   *%rax

00000000000013b0 <stosb>:
  stosb(dst, c, n);
  return dst;
}

char*
strchr(const char *s, char c)
    13b0:	f3 0f 1e fa          	endbr64
    13b4:	55                   	push   %rbp
    13b5:	48 89 e5             	mov    %rsp,%rbp
    13b8:	48 83 ec 10          	sub    $0x10,%rsp
    13bc:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    13c0:	89 75 f4             	mov    %esi,-0xc(%rbp)
    13c3:	89 55 f0             	mov    %edx,-0x10(%rbp)
{
    13c6:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    13ca:	8b 55 f0             	mov    -0x10(%rbp),%edx
    13cd:	8b 45 f4             	mov    -0xc(%rbp),%eax
    13d0:	48 89 ce             	mov    %rcx,%rsi
    13d3:	48 89 f7             	mov    %rsi,%rdi
    13d6:	89 d1                	mov    %edx,%ecx
    13d8:	fc                   	cld
    13d9:	f3 aa                	rep stos %al,%es:(%rdi)
    13db:	89 ca                	mov    %ecx,%edx
    13dd:	48 89 fe             	mov    %rdi,%rsi
    13e0:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    13e4:	89 55 f0             	mov    %edx,-0x10(%rbp)
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
    13e7:	90                   	nop
    13e8:	c9                   	leave
    13e9:	c3                   	ret

00000000000013ea <strcpy>:
{
    13ea:	f3 0f 1e fa          	endbr64
    13ee:	55                   	push   %rbp
    13ef:	48 89 e5             	mov    %rsp,%rbp
    13f2:	48 83 ec 20          	sub    $0x20,%rsp
    13f6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    13fa:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  os = s;
    13fe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1402:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    1406:	90                   	nop
    1407:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    140b:	48 8d 42 01          	lea    0x1(%rdx),%rax
    140f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    1413:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1417:	48 8d 48 01          	lea    0x1(%rax),%rcx
    141b:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    141f:	0f b6 12             	movzbl (%rdx),%edx
    1422:	88 10                	mov    %dl,(%rax)
    1424:	0f b6 00             	movzbl (%rax),%eax
    1427:	84 c0                	test   %al,%al
    1429:	75 dc                	jne    1407 <strcpy+0x1d>
  return os;
    142b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    142f:	c9                   	leave
    1430:	c3                   	ret

0000000000001431 <strcmp>:
{
    1431:	f3 0f 1e fa          	endbr64
    1435:	55                   	push   %rbp
    1436:	48 89 e5             	mov    %rsp,%rbp
    1439:	48 83 ec 10          	sub    $0x10,%rsp
    143d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1441:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    1445:	eb 0a                	jmp    1451 <strcmp+0x20>
    p++, q++;
    1447:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    144c:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    1451:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1455:	0f b6 00             	movzbl (%rax),%eax
    1458:	84 c0                	test   %al,%al
    145a:	74 12                	je     146e <strcmp+0x3d>
    145c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1460:	0f b6 10             	movzbl (%rax),%edx
    1463:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1467:	0f b6 00             	movzbl (%rax),%eax
    146a:	38 c2                	cmp    %al,%dl
    146c:	74 d9                	je     1447 <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
    146e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1472:	0f b6 00             	movzbl (%rax),%eax
    1475:	0f b6 d0             	movzbl %al,%edx
    1478:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    147c:	0f b6 00             	movzbl (%rax),%eax
    147f:	0f b6 c0             	movzbl %al,%eax
    1482:	29 c2                	sub    %eax,%edx
    1484:	89 d0                	mov    %edx,%eax
}
    1486:	c9                   	leave
    1487:	c3                   	ret

0000000000001488 <strlen>:
{
    1488:	f3 0f 1e fa          	endbr64
    148c:	55                   	push   %rbp
    148d:	48 89 e5             	mov    %rsp,%rbp
    1490:	48 83 ec 18          	sub    $0x18,%rsp
    1494:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  for(n = 0; s[n]; n++)
    1498:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    149f:	eb 04                	jmp    14a5 <strlen+0x1d>
    14a1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    14a5:	8b 45 fc             	mov    -0x4(%rbp),%eax
    14a8:	48 63 d0             	movslq %eax,%rdx
    14ab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    14af:	48 01 d0             	add    %rdx,%rax
    14b2:	0f b6 00             	movzbl (%rax),%eax
    14b5:	84 c0                	test   %al,%al
    14b7:	75 e8                	jne    14a1 <strlen+0x19>
  return n;
    14b9:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    14bc:	c9                   	leave
    14bd:	c3                   	ret

00000000000014be <memset>:
{
    14be:	f3 0f 1e fa          	endbr64
    14c2:	55                   	push   %rbp
    14c3:	48 89 e5             	mov    %rsp,%rbp
    14c6:	48 83 ec 10          	sub    $0x10,%rsp
    14ca:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    14ce:	89 75 f4             	mov    %esi,-0xc(%rbp)
    14d1:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    14d4:	8b 55 f0             	mov    -0x10(%rbp),%edx
    14d7:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    14da:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    14de:	89 ce                	mov    %ecx,%esi
    14e0:	48 89 c7             	mov    %rax,%rdi
    14e3:	48 b8 b0 13 00 00 00 	movabs $0x13b0,%rax
    14ea:	00 00 00 
    14ed:	ff d0                	call   *%rax
  return dst;
    14ef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    14f3:	c9                   	leave
    14f4:	c3                   	ret

00000000000014f5 <strchr>:
{
    14f5:	f3 0f 1e fa          	endbr64
    14f9:	55                   	push   %rbp
    14fa:	48 89 e5             	mov    %rsp,%rbp
    14fd:	48 83 ec 10          	sub    $0x10,%rsp
    1501:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1505:	89 f0                	mov    %esi,%eax
    1507:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    150a:	eb 17                	jmp    1523 <strchr+0x2e>
    if(*s == c)
    150c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1510:	0f b6 00             	movzbl (%rax),%eax
    1513:	38 45 f4             	cmp    %al,-0xc(%rbp)
    1516:	75 06                	jne    151e <strchr+0x29>
      return (char*)s;
    1518:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    151c:	eb 15                	jmp    1533 <strchr+0x3e>
  for(; *s; s++)
    151e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1523:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1527:	0f b6 00             	movzbl (%rax),%eax
    152a:	84 c0                	test   %al,%al
    152c:	75 de                	jne    150c <strchr+0x17>
  return 0;
    152e:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1533:	c9                   	leave
    1534:	c3                   	ret

0000000000001535 <gets>:

char*
gets(char *buf, int max)
{
    1535:	f3 0f 1e fa          	endbr64
    1539:	55                   	push   %rbp
    153a:	48 89 e5             	mov    %rsp,%rbp
    153d:	48 83 ec 20          	sub    $0x20,%rsp
    1541:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1545:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1548:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    154f:	eb 4f                	jmp    15a0 <gets+0x6b>
    cc = read(0, &c, 1);
    1551:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    1555:	ba 01 00 00 00       	mov    $0x1,%edx
    155a:	48 89 c6             	mov    %rax,%rsi
    155d:	bf 00 00 00 00       	mov    $0x0,%edi
    1562:	48 b8 1a 17 00 00 00 	movabs $0x171a,%rax
    1569:	00 00 00 
    156c:	ff d0                	call   *%rax
    156e:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    1571:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1575:	7e 36                	jle    15ad <gets+0x78>
      break;
    buf[i++] = c;
    1577:	8b 45 fc             	mov    -0x4(%rbp),%eax
    157a:	8d 50 01             	lea    0x1(%rax),%edx
    157d:	89 55 fc             	mov    %edx,-0x4(%rbp)
    1580:	48 63 d0             	movslq %eax,%rdx
    1583:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1587:	48 01 c2             	add    %rax,%rdx
    158a:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    158e:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    1590:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1594:	3c 0a                	cmp    $0xa,%al
    1596:	74 16                	je     15ae <gets+0x79>
    1598:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    159c:	3c 0d                	cmp    $0xd,%al
    159e:	74 0e                	je     15ae <gets+0x79>
  for(i=0; i+1 < max; ){
    15a0:	8b 45 fc             	mov    -0x4(%rbp),%eax
    15a3:	83 c0 01             	add    $0x1,%eax
    15a6:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    15a9:	7f a6                	jg     1551 <gets+0x1c>
    15ab:	eb 01                	jmp    15ae <gets+0x79>
      break;
    15ad:	90                   	nop
      break;
  }
  buf[i] = '\0';
    15ae:	8b 45 fc             	mov    -0x4(%rbp),%eax
    15b1:	48 63 d0             	movslq %eax,%rdx
    15b4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    15b8:	48 01 d0             	add    %rdx,%rax
    15bb:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    15be:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    15c2:	c9                   	leave
    15c3:	c3                   	ret

00000000000015c4 <stat>:

int
stat(char *n, struct stat *st)
{
    15c4:	f3 0f 1e fa          	endbr64
    15c8:	55                   	push   %rbp
    15c9:	48 89 e5             	mov    %rsp,%rbp
    15cc:	48 83 ec 20          	sub    $0x20,%rsp
    15d0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    15d4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    15d8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    15dc:	be 00 00 00 00       	mov    $0x0,%esi
    15e1:	48 89 c7             	mov    %rax,%rdi
    15e4:	48 b8 5b 17 00 00 00 	movabs $0x175b,%rax
    15eb:	00 00 00 
    15ee:	ff d0                	call   *%rax
    15f0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    15f3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    15f7:	79 07                	jns    1600 <stat+0x3c>
    return -1;
    15f9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    15fe:	eb 2f                	jmp    162f <stat+0x6b>
  r = fstat(fd, st);
    1600:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1604:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1607:	48 89 d6             	mov    %rdx,%rsi
    160a:	89 c7                	mov    %eax,%edi
    160c:	48 b8 82 17 00 00 00 	movabs $0x1782,%rax
    1613:	00 00 00 
    1616:	ff d0                	call   *%rax
    1618:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    161b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    161e:	89 c7                	mov    %eax,%edi
    1620:	48 b8 34 17 00 00 00 	movabs $0x1734,%rax
    1627:	00 00 00 
    162a:	ff d0                	call   *%rax
  return r;
    162c:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    162f:	c9                   	leave
    1630:	c3                   	ret

0000000000001631 <atoi>:

int
atoi(const char *s)
{
    1631:	f3 0f 1e fa          	endbr64
    1635:	55                   	push   %rbp
    1636:	48 89 e5             	mov    %rsp,%rbp
    1639:	48 83 ec 18          	sub    $0x18,%rsp
    163d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    1641:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1648:	eb 28                	jmp    1672 <atoi+0x41>
    n = n*10 + *s++ - '0';
    164a:	8b 55 fc             	mov    -0x4(%rbp),%edx
    164d:	89 d0                	mov    %edx,%eax
    164f:	c1 e0 02             	shl    $0x2,%eax
    1652:	01 d0                	add    %edx,%eax
    1654:	01 c0                	add    %eax,%eax
    1656:	89 c1                	mov    %eax,%ecx
    1658:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    165c:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1660:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    1664:	0f b6 00             	movzbl (%rax),%eax
    1667:	0f be c0             	movsbl %al,%eax
    166a:	01 c8                	add    %ecx,%eax
    166c:	83 e8 30             	sub    $0x30,%eax
    166f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1672:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1676:	0f b6 00             	movzbl (%rax),%eax
    1679:	3c 2f                	cmp    $0x2f,%al
    167b:	7e 0b                	jle    1688 <atoi+0x57>
    167d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1681:	0f b6 00             	movzbl (%rax),%eax
    1684:	3c 39                	cmp    $0x39,%al
    1686:	7e c2                	jle    164a <atoi+0x19>
  return n;
    1688:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    168b:	c9                   	leave
    168c:	c3                   	ret

000000000000168d <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    168d:	f3 0f 1e fa          	endbr64
    1691:	55                   	push   %rbp
    1692:	48 89 e5             	mov    %rsp,%rbp
    1695:	48 83 ec 28          	sub    $0x28,%rsp
    1699:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    169d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    16a1:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    16a4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    16a8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    16ac:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    16b0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    16b4:	eb 1d                	jmp    16d3 <memmove+0x46>
    *dst++ = *src++;
    16b6:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    16ba:	48 8d 42 01          	lea    0x1(%rdx),%rax
    16be:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    16c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    16c6:	48 8d 48 01          	lea    0x1(%rax),%rcx
    16ca:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    16ce:	0f b6 12             	movzbl (%rdx),%edx
    16d1:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    16d3:	8b 45 dc             	mov    -0x24(%rbp),%eax
    16d6:	8d 50 ff             	lea    -0x1(%rax),%edx
    16d9:	89 55 dc             	mov    %edx,-0x24(%rbp)
    16dc:	85 c0                	test   %eax,%eax
    16de:	7f d6                	jg     16b6 <memmove+0x29>
  return vdst;
    16e0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    16e4:	c9                   	leave
    16e5:	c3                   	ret

00000000000016e6 <fork>:
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    16e6:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    16ed:	49 89 ca             	mov    %rcx,%r10
    16f0:	0f 05                	syscall
    16f2:	c3                   	ret

00000000000016f3 <exit>:
SYSCALL(exit)
    16f3:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    16fa:	49 89 ca             	mov    %rcx,%r10
    16fd:	0f 05                	syscall
    16ff:	c3                   	ret

0000000000001700 <wait>:
SYSCALL(wait)
    1700:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    1707:	49 89 ca             	mov    %rcx,%r10
    170a:	0f 05                	syscall
    170c:	c3                   	ret

000000000000170d <pipe>:
SYSCALL(pipe)
    170d:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    1714:	49 89 ca             	mov    %rcx,%r10
    1717:	0f 05                	syscall
    1719:	c3                   	ret

000000000000171a <read>:
SYSCALL(read)
    171a:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    1721:	49 89 ca             	mov    %rcx,%r10
    1724:	0f 05                	syscall
    1726:	c3                   	ret

0000000000001727 <write>:
SYSCALL(write)
    1727:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    172e:	49 89 ca             	mov    %rcx,%r10
    1731:	0f 05                	syscall
    1733:	c3                   	ret

0000000000001734 <close>:
SYSCALL(close)
    1734:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    173b:	49 89 ca             	mov    %rcx,%r10
    173e:	0f 05                	syscall
    1740:	c3                   	ret

0000000000001741 <kill>:
SYSCALL(kill)
    1741:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    1748:	49 89 ca             	mov    %rcx,%r10
    174b:	0f 05                	syscall
    174d:	c3                   	ret

000000000000174e <exec>:
SYSCALL(exec)
    174e:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    1755:	49 89 ca             	mov    %rcx,%r10
    1758:	0f 05                	syscall
    175a:	c3                   	ret

000000000000175b <open>:
SYSCALL(open)
    175b:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    1762:	49 89 ca             	mov    %rcx,%r10
    1765:	0f 05                	syscall
    1767:	c3                   	ret

0000000000001768 <mknod>:
SYSCALL(mknod)
    1768:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    176f:	49 89 ca             	mov    %rcx,%r10
    1772:	0f 05                	syscall
    1774:	c3                   	ret

0000000000001775 <unlink>:
SYSCALL(unlink)
    1775:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    177c:	49 89 ca             	mov    %rcx,%r10
    177f:	0f 05                	syscall
    1781:	c3                   	ret

0000000000001782 <fstat>:
SYSCALL(fstat)
    1782:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    1789:	49 89 ca             	mov    %rcx,%r10
    178c:	0f 05                	syscall
    178e:	c3                   	ret

000000000000178f <link>:
SYSCALL(link)
    178f:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    1796:	49 89 ca             	mov    %rcx,%r10
    1799:	0f 05                	syscall
    179b:	c3                   	ret

000000000000179c <mkdir>:
SYSCALL(mkdir)
    179c:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    17a3:	49 89 ca             	mov    %rcx,%r10
    17a6:	0f 05                	syscall
    17a8:	c3                   	ret

00000000000017a9 <chdir>:
SYSCALL(chdir)
    17a9:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    17b0:	49 89 ca             	mov    %rcx,%r10
    17b3:	0f 05                	syscall
    17b5:	c3                   	ret

00000000000017b6 <dup>:
SYSCALL(dup)
    17b6:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    17bd:	49 89 ca             	mov    %rcx,%r10
    17c0:	0f 05                	syscall
    17c2:	c3                   	ret

00000000000017c3 <getpid>:
SYSCALL(getpid)
    17c3:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    17ca:	49 89 ca             	mov    %rcx,%r10
    17cd:	0f 05                	syscall
    17cf:	c3                   	ret

00000000000017d0 <sbrk>:
SYSCALL(sbrk)
    17d0:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    17d7:	49 89 ca             	mov    %rcx,%r10
    17da:	0f 05                	syscall
    17dc:	c3                   	ret

00000000000017dd <sleep>:
SYSCALL(sleep)
    17dd:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    17e4:	49 89 ca             	mov    %rcx,%r10
    17e7:	0f 05                	syscall
    17e9:	c3                   	ret

00000000000017ea <uptime>:
SYSCALL(uptime)
    17ea:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    17f1:	49 89 ca             	mov    %rcx,%r10
    17f4:	0f 05                	syscall
    17f6:	c3                   	ret

00000000000017f7 <send>:
SYSCALL(send)
    17f7:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    17fe:	49 89 ca             	mov    %rcx,%r10
    1801:	0f 05                	syscall
    1803:	c3                   	ret

0000000000001804 <recv>:
SYSCALL(recv)
    1804:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    180b:	49 89 ca             	mov    %rcx,%r10
    180e:	0f 05                	syscall
    1810:	c3                   	ret

0000000000001811 <register_fsserver>:
SYSCALL(register_fsserver)
    1811:	48 c7 c0 18 00 00 00 	mov    $0x18,%rax
    1818:	49 89 ca             	mov    %rcx,%r10
    181b:	0f 05                	syscall
    181d:	c3                   	ret

000000000000181e <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    181e:	f3 0f 1e fa          	endbr64
    1822:	55                   	push   %rbp
    1823:	48 89 e5             	mov    %rsp,%rbp
    1826:	48 83 ec 10          	sub    $0x10,%rsp
    182a:	89 7d fc             	mov    %edi,-0x4(%rbp)
    182d:	89 f0                	mov    %esi,%eax
    182f:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    1832:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    1836:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1839:	ba 01 00 00 00       	mov    $0x1,%edx
    183e:	48 89 ce             	mov    %rcx,%rsi
    1841:	89 c7                	mov    %eax,%edi
    1843:	48 b8 27 17 00 00 00 	movabs $0x1727,%rax
    184a:	00 00 00 
    184d:	ff d0                	call   *%rax
}
    184f:	90                   	nop
    1850:	c9                   	leave
    1851:	c3                   	ret

0000000000001852 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    1852:	f3 0f 1e fa          	endbr64
    1856:	55                   	push   %rbp
    1857:	48 89 e5             	mov    %rsp,%rbp
    185a:	48 83 ec 20          	sub    $0x20,%rsp
    185e:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1861:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1865:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    186c:	eb 35                	jmp    18a3 <print_x64+0x51>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    186e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1872:	48 c1 e8 3c          	shr    $0x3c,%rax
    1876:	48 ba 00 23 00 00 00 	movabs $0x2300,%rdx
    187d:	00 00 00 
    1880:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1884:	0f be d0             	movsbl %al,%edx
    1887:	8b 45 ec             	mov    -0x14(%rbp),%eax
    188a:	89 d6                	mov    %edx,%esi
    188c:	89 c7                	mov    %eax,%edi
    188e:	48 b8 1e 18 00 00 00 	movabs $0x181e,%rax
    1895:	00 00 00 
    1898:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    189a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    189e:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    18a3:	8b 45 fc             	mov    -0x4(%rbp),%eax
    18a6:	83 f8 0f             	cmp    $0xf,%eax
    18a9:	76 c3                	jbe    186e <print_x64+0x1c>
}
    18ab:	90                   	nop
    18ac:	90                   	nop
    18ad:	c9                   	leave
    18ae:	c3                   	ret

00000000000018af <print_x32>:

  static void
print_x32(int fd, uint x)
{
    18af:	f3 0f 1e fa          	endbr64
    18b3:	55                   	push   %rbp
    18b4:	48 89 e5             	mov    %rsp,%rbp
    18b7:	48 83 ec 20          	sub    $0x20,%rsp
    18bb:	89 7d ec             	mov    %edi,-0x14(%rbp)
    18be:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    18c1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    18c8:	eb 36                	jmp    1900 <print_x32+0x51>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    18ca:	8b 45 e8             	mov    -0x18(%rbp),%eax
    18cd:	c1 e8 1c             	shr    $0x1c,%eax
    18d0:	89 c2                	mov    %eax,%edx
    18d2:	48 b8 00 23 00 00 00 	movabs $0x2300,%rax
    18d9:	00 00 00 
    18dc:	89 d2                	mov    %edx,%edx
    18de:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    18e2:	0f be d0             	movsbl %al,%edx
    18e5:	8b 45 ec             	mov    -0x14(%rbp),%eax
    18e8:	89 d6                	mov    %edx,%esi
    18ea:	89 c7                	mov    %eax,%edi
    18ec:	48 b8 1e 18 00 00 00 	movabs $0x181e,%rax
    18f3:	00 00 00 
    18f6:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    18f8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    18fc:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    1900:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1903:	83 f8 07             	cmp    $0x7,%eax
    1906:	76 c2                	jbe    18ca <print_x32+0x1b>
}
    1908:	90                   	nop
    1909:	90                   	nop
    190a:	c9                   	leave
    190b:	c3                   	ret

000000000000190c <print_d>:

  static void
print_d(int fd, int v)
{
    190c:	f3 0f 1e fa          	endbr64
    1910:	55                   	push   %rbp
    1911:	48 89 e5             	mov    %rsp,%rbp
    1914:	48 83 ec 30          	sub    $0x30,%rsp
    1918:	89 7d dc             	mov    %edi,-0x24(%rbp)
    191b:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    191e:	8b 45 d8             	mov    -0x28(%rbp),%eax
    1921:	48 98                	cltq
    1923:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    1927:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    192b:	79 04                	jns    1931 <print_d+0x25>
    x = -x;
    192d:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    1931:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    1938:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    193c:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1943:	66 66 66 
    1946:	48 89 c8             	mov    %rcx,%rax
    1949:	48 f7 ea             	imul   %rdx
    194c:	48 c1 fa 02          	sar    $0x2,%rdx
    1950:	48 89 c8             	mov    %rcx,%rax
    1953:	48 c1 f8 3f          	sar    $0x3f,%rax
    1957:	48 29 c2             	sub    %rax,%rdx
    195a:	48 89 d0             	mov    %rdx,%rax
    195d:	48 c1 e0 02          	shl    $0x2,%rax
    1961:	48 01 d0             	add    %rdx,%rax
    1964:	48 01 c0             	add    %rax,%rax
    1967:	48 29 c1             	sub    %rax,%rcx
    196a:	48 89 ca             	mov    %rcx,%rdx
    196d:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1970:	8d 48 01             	lea    0x1(%rax),%ecx
    1973:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    1976:	48 b9 00 23 00 00 00 	movabs $0x2300,%rcx
    197d:	00 00 00 
    1980:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    1984:	48 98                	cltq
    1986:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    198a:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    198e:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1995:	66 66 66 
    1998:	48 89 c8             	mov    %rcx,%rax
    199b:	48 f7 ea             	imul   %rdx
    199e:	48 89 d0             	mov    %rdx,%rax
    19a1:	48 c1 f8 02          	sar    $0x2,%rax
    19a5:	48 c1 f9 3f          	sar    $0x3f,%rcx
    19a9:	48 89 ca             	mov    %rcx,%rdx
    19ac:	48 29 d0             	sub    %rdx,%rax
    19af:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    19b3:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    19b8:	0f 85 7a ff ff ff    	jne    1938 <print_d+0x2c>

  if (v < 0)
    19be:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    19c2:	79 32                	jns    19f6 <print_d+0xea>
    buf[i++] = '-';
    19c4:	8b 45 f4             	mov    -0xc(%rbp),%eax
    19c7:	8d 50 01             	lea    0x1(%rax),%edx
    19ca:	89 55 f4             	mov    %edx,-0xc(%rbp)
    19cd:	48 98                	cltq
    19cf:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    19d4:	eb 20                	jmp    19f6 <print_d+0xea>
    putc(fd, buf[i]);
    19d6:	8b 45 f4             	mov    -0xc(%rbp),%eax
    19d9:	48 98                	cltq
    19db:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    19e0:	0f be d0             	movsbl %al,%edx
    19e3:	8b 45 dc             	mov    -0x24(%rbp),%eax
    19e6:	89 d6                	mov    %edx,%esi
    19e8:	89 c7                	mov    %eax,%edi
    19ea:	48 b8 1e 18 00 00 00 	movabs $0x181e,%rax
    19f1:	00 00 00 
    19f4:	ff d0                	call   *%rax
  while (--i >= 0)
    19f6:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    19fa:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    19fe:	79 d6                	jns    19d6 <print_d+0xca>
}
    1a00:	90                   	nop
    1a01:	90                   	nop
    1a02:	c9                   	leave
    1a03:	c3                   	ret

0000000000001a04 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    1a04:	f3 0f 1e fa          	endbr64
    1a08:	55                   	push   %rbp
    1a09:	48 89 e5             	mov    %rsp,%rbp
    1a0c:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    1a13:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    1a19:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    1a20:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    1a27:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    1a2e:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    1a35:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    1a3c:	84 c0                	test   %al,%al
    1a3e:	74 20                	je     1a60 <printf+0x5c>
    1a40:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    1a44:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    1a48:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    1a4c:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    1a50:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    1a54:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    1a58:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    1a5c:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    1a60:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    1a67:	00 00 00 
    1a6a:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    1a71:	00 00 00 
    1a74:	48 8d 45 10          	lea    0x10(%rbp),%rax
    1a78:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    1a7f:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    1a86:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1a8d:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    1a94:	00 00 00 
    1a97:	e9 41 03 00 00       	jmp    1ddd <printf+0x3d9>
    if (c != '%') {
    1a9c:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1aa3:	74 24                	je     1ac9 <printf+0xc5>
      putc(fd, c);
    1aa5:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1aab:	0f be d0             	movsbl %al,%edx
    1aae:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1ab4:	89 d6                	mov    %edx,%esi
    1ab6:	89 c7                	mov    %eax,%edi
    1ab8:	48 b8 1e 18 00 00 00 	movabs $0x181e,%rax
    1abf:	00 00 00 
    1ac2:	ff d0                	call   *%rax
      continue;
    1ac4:	e9 0d 03 00 00       	jmp    1dd6 <printf+0x3d2>
    }
    c = fmt[++i] & 0xff;
    1ac9:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1ad0:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1ad6:	48 63 d0             	movslq %eax,%rdx
    1ad9:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1ae0:	48 01 d0             	add    %rdx,%rax
    1ae3:	0f b6 00             	movzbl (%rax),%eax
    1ae6:	0f be c0             	movsbl %al,%eax
    1ae9:	25 ff 00 00 00       	and    $0xff,%eax
    1aee:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    1af4:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1afb:	0f 84 0f 03 00 00    	je     1e10 <printf+0x40c>
      break;
    switch(c) {
    1b01:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1b08:	0f 84 74 02 00 00    	je     1d82 <printf+0x37e>
    1b0e:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1b15:	0f 8c 82 02 00 00    	jl     1d9d <printf+0x399>
    1b1b:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    1b22:	0f 8f 75 02 00 00    	jg     1d9d <printf+0x399>
    1b28:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    1b2f:	0f 8c 68 02 00 00    	jl     1d9d <printf+0x399>
    1b35:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1b3b:	83 e8 63             	sub    $0x63,%eax
    1b3e:	83 f8 15             	cmp    $0x15,%eax
    1b41:	0f 87 56 02 00 00    	ja     1d9d <printf+0x399>
    1b47:	89 c0                	mov    %eax,%eax
    1b49:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1b50:	00 
    1b51:	48 b8 48 22 00 00 00 	movabs $0x2248,%rax
    1b58:	00 00 00 
    1b5b:	48 01 d0             	add    %rdx,%rax
    1b5e:	48 8b 00             	mov    (%rax),%rax
    1b61:	3e ff e0             	notrack jmp *%rax
    case 'c':
      putc(fd, va_arg(ap, int));
    1b64:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1b6a:	83 f8 2f             	cmp    $0x2f,%eax
    1b6d:	77 23                	ja     1b92 <printf+0x18e>
    1b6f:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1b76:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b7c:	89 d2                	mov    %edx,%edx
    1b7e:	48 01 d0             	add    %rdx,%rax
    1b81:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b87:	83 c2 08             	add    $0x8,%edx
    1b8a:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1b90:	eb 12                	jmp    1ba4 <printf+0x1a0>
    1b92:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1b99:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1b9d:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1ba4:	8b 00                	mov    (%rax),%eax
    1ba6:	0f be d0             	movsbl %al,%edx
    1ba9:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1baf:	89 d6                	mov    %edx,%esi
    1bb1:	89 c7                	mov    %eax,%edi
    1bb3:	48 b8 1e 18 00 00 00 	movabs $0x181e,%rax
    1bba:	00 00 00 
    1bbd:	ff d0                	call   *%rax
      break;
    1bbf:	e9 12 02 00 00       	jmp    1dd6 <printf+0x3d2>
    case 'd':
      print_d(fd, va_arg(ap, int));
    1bc4:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1bca:	83 f8 2f             	cmp    $0x2f,%eax
    1bcd:	77 23                	ja     1bf2 <printf+0x1ee>
    1bcf:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1bd6:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1bdc:	89 d2                	mov    %edx,%edx
    1bde:	48 01 d0             	add    %rdx,%rax
    1be1:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1be7:	83 c2 08             	add    $0x8,%edx
    1bea:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1bf0:	eb 12                	jmp    1c04 <printf+0x200>
    1bf2:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1bf9:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1bfd:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1c04:	8b 10                	mov    (%rax),%edx
    1c06:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1c0c:	89 d6                	mov    %edx,%esi
    1c0e:	89 c7                	mov    %eax,%edi
    1c10:	48 b8 0c 19 00 00 00 	movabs $0x190c,%rax
    1c17:	00 00 00 
    1c1a:	ff d0                	call   *%rax
      break;
    1c1c:	e9 b5 01 00 00       	jmp    1dd6 <printf+0x3d2>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    1c21:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1c27:	83 f8 2f             	cmp    $0x2f,%eax
    1c2a:	77 23                	ja     1c4f <printf+0x24b>
    1c2c:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1c33:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1c39:	89 d2                	mov    %edx,%edx
    1c3b:	48 01 d0             	add    %rdx,%rax
    1c3e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1c44:	83 c2 08             	add    $0x8,%edx
    1c47:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1c4d:	eb 12                	jmp    1c61 <printf+0x25d>
    1c4f:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1c56:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1c5a:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1c61:	8b 10                	mov    (%rax),%edx
    1c63:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1c69:	89 d6                	mov    %edx,%esi
    1c6b:	89 c7                	mov    %eax,%edi
    1c6d:	48 b8 af 18 00 00 00 	movabs $0x18af,%rax
    1c74:	00 00 00 
    1c77:	ff d0                	call   *%rax
      break;
    1c79:	e9 58 01 00 00       	jmp    1dd6 <printf+0x3d2>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    1c7e:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1c84:	83 f8 2f             	cmp    $0x2f,%eax
    1c87:	77 23                	ja     1cac <printf+0x2a8>
    1c89:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1c90:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1c96:	89 d2                	mov    %edx,%edx
    1c98:	48 01 d0             	add    %rdx,%rax
    1c9b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1ca1:	83 c2 08             	add    $0x8,%edx
    1ca4:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1caa:	eb 12                	jmp    1cbe <printf+0x2ba>
    1cac:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1cb3:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1cb7:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1cbe:	48 8b 10             	mov    (%rax),%rdx
    1cc1:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1cc7:	48 89 d6             	mov    %rdx,%rsi
    1cca:	89 c7                	mov    %eax,%edi
    1ccc:	48 b8 52 18 00 00 00 	movabs $0x1852,%rax
    1cd3:	00 00 00 
    1cd6:	ff d0                	call   *%rax
      break;
    1cd8:	e9 f9 00 00 00       	jmp    1dd6 <printf+0x3d2>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    1cdd:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1ce3:	83 f8 2f             	cmp    $0x2f,%eax
    1ce6:	77 23                	ja     1d0b <printf+0x307>
    1ce8:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1cef:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1cf5:	89 d2                	mov    %edx,%edx
    1cf7:	48 01 d0             	add    %rdx,%rax
    1cfa:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1d00:	83 c2 08             	add    $0x8,%edx
    1d03:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1d09:	eb 12                	jmp    1d1d <printf+0x319>
    1d0b:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1d12:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1d16:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1d1d:	48 8b 00             	mov    (%rax),%rax
    1d20:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    1d27:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1d2e:	00 
    1d2f:	75 41                	jne    1d72 <printf+0x36e>
        s = "(null)";
    1d31:	48 b8 40 22 00 00 00 	movabs $0x2240,%rax
    1d38:	00 00 00 
    1d3b:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1d42:	eb 2e                	jmp    1d72 <printf+0x36e>
        putc(fd, *(s++));
    1d44:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1d4b:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1d4f:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1d56:	0f b6 00             	movzbl (%rax),%eax
    1d59:	0f be d0             	movsbl %al,%edx
    1d5c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1d62:	89 d6                	mov    %edx,%esi
    1d64:	89 c7                	mov    %eax,%edi
    1d66:	48 b8 1e 18 00 00 00 	movabs $0x181e,%rax
    1d6d:	00 00 00 
    1d70:	ff d0                	call   *%rax
      while (*s)
    1d72:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1d79:	0f b6 00             	movzbl (%rax),%eax
    1d7c:	84 c0                	test   %al,%al
    1d7e:	75 c4                	jne    1d44 <printf+0x340>
      break;
    1d80:	eb 54                	jmp    1dd6 <printf+0x3d2>
    case '%':
      putc(fd, '%');
    1d82:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1d88:	be 25 00 00 00       	mov    $0x25,%esi
    1d8d:	89 c7                	mov    %eax,%edi
    1d8f:	48 b8 1e 18 00 00 00 	movabs $0x181e,%rax
    1d96:	00 00 00 
    1d99:	ff d0                	call   *%rax
      break;
    1d9b:	eb 39                	jmp    1dd6 <printf+0x3d2>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1d9d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1da3:	be 25 00 00 00       	mov    $0x25,%esi
    1da8:	89 c7                	mov    %eax,%edi
    1daa:	48 b8 1e 18 00 00 00 	movabs $0x181e,%rax
    1db1:	00 00 00 
    1db4:	ff d0                	call   *%rax
      putc(fd, c);
    1db6:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1dbc:	0f be d0             	movsbl %al,%edx
    1dbf:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1dc5:	89 d6                	mov    %edx,%esi
    1dc7:	89 c7                	mov    %eax,%edi
    1dc9:	48 b8 1e 18 00 00 00 	movabs $0x181e,%rax
    1dd0:	00 00 00 
    1dd3:	ff d0                	call   *%rax
      break;
    1dd5:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1dd6:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1ddd:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1de3:	48 63 d0             	movslq %eax,%rdx
    1de6:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1ded:	48 01 d0             	add    %rdx,%rax
    1df0:	0f b6 00             	movzbl (%rax),%eax
    1df3:	0f be c0             	movsbl %al,%eax
    1df6:	25 ff 00 00 00       	and    $0xff,%eax
    1dfb:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1e01:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1e08:	0f 85 8e fc ff ff    	jne    1a9c <printf+0x98>
    }
  }
}
    1e0e:	eb 01                	jmp    1e11 <printf+0x40d>
      break;
    1e10:	90                   	nop
}
    1e11:	90                   	nop
    1e12:	c9                   	leave
    1e13:	c3                   	ret

0000000000001e14 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1e14:	f3 0f 1e fa          	endbr64
    1e18:	55                   	push   %rbp
    1e19:	48 89 e5             	mov    %rsp,%rbp
    1e1c:	48 83 ec 18          	sub    $0x18,%rsp
    1e20:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1e24:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1e28:	48 83 e8 10          	sub    $0x10,%rax
    1e2c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1e30:	48 b8 30 23 00 00 00 	movabs $0x2330,%rax
    1e37:	00 00 00 
    1e3a:	48 8b 00             	mov    (%rax),%rax
    1e3d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1e41:	eb 2f                	jmp    1e72 <free+0x5e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1e43:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e47:	48 8b 00             	mov    (%rax),%rax
    1e4a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1e4e:	72 17                	jb     1e67 <free+0x53>
    1e50:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e54:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1e58:	72 2f                	jb     1e89 <free+0x75>
    1e5a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e5e:	48 8b 00             	mov    (%rax),%rax
    1e61:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1e65:	72 22                	jb     1e89 <free+0x75>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1e67:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e6b:	48 8b 00             	mov    (%rax),%rax
    1e6e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1e72:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e76:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1e7a:	73 c7                	jae    1e43 <free+0x2f>
    1e7c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e80:	48 8b 00             	mov    (%rax),%rax
    1e83:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1e87:	73 ba                	jae    1e43 <free+0x2f>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1e89:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e8d:	8b 40 08             	mov    0x8(%rax),%eax
    1e90:	89 c0                	mov    %eax,%eax
    1e92:	48 c1 e0 04          	shl    $0x4,%rax
    1e96:	48 89 c2             	mov    %rax,%rdx
    1e99:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e9d:	48 01 c2             	add    %rax,%rdx
    1ea0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ea4:	48 8b 00             	mov    (%rax),%rax
    1ea7:	48 39 c2             	cmp    %rax,%rdx
    1eaa:	75 2d                	jne    1ed9 <free+0xc5>
    bp->s.size += p->s.ptr->s.size;
    1eac:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1eb0:	8b 50 08             	mov    0x8(%rax),%edx
    1eb3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1eb7:	48 8b 00             	mov    (%rax),%rax
    1eba:	8b 40 08             	mov    0x8(%rax),%eax
    1ebd:	01 c2                	add    %eax,%edx
    1ebf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ec3:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1ec6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1eca:	48 8b 00             	mov    (%rax),%rax
    1ecd:	48 8b 10             	mov    (%rax),%rdx
    1ed0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ed4:	48 89 10             	mov    %rdx,(%rax)
    1ed7:	eb 0e                	jmp    1ee7 <free+0xd3>
  } else
    bp->s.ptr = p->s.ptr;
    1ed9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1edd:	48 8b 10             	mov    (%rax),%rdx
    1ee0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ee4:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    1ee7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1eeb:	8b 40 08             	mov    0x8(%rax),%eax
    1eee:	89 c0                	mov    %eax,%eax
    1ef0:	48 c1 e0 04          	shl    $0x4,%rax
    1ef4:	48 89 c2             	mov    %rax,%rdx
    1ef7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1efb:	48 01 d0             	add    %rdx,%rax
    1efe:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1f02:	75 27                	jne    1f2b <free+0x117>
    p->s.size += bp->s.size;
    1f04:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f08:	8b 50 08             	mov    0x8(%rax),%edx
    1f0b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f0f:	8b 40 08             	mov    0x8(%rax),%eax
    1f12:	01 c2                	add    %eax,%edx
    1f14:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f18:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    1f1b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f1f:	48 8b 10             	mov    (%rax),%rdx
    1f22:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f26:	48 89 10             	mov    %rdx,(%rax)
    1f29:	eb 0b                	jmp    1f36 <free+0x122>
  } else
    p->s.ptr = bp;
    1f2b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f2f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1f33:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    1f36:	48 ba 30 23 00 00 00 	movabs $0x2330,%rdx
    1f3d:	00 00 00 
    1f40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f44:	48 89 02             	mov    %rax,(%rdx)
}
    1f47:	90                   	nop
    1f48:	c9                   	leave
    1f49:	c3                   	ret

0000000000001f4a <morecore>:

static Header*
morecore(uint nu)
{
    1f4a:	f3 0f 1e fa          	endbr64
    1f4e:	55                   	push   %rbp
    1f4f:	48 89 e5             	mov    %rsp,%rbp
    1f52:	48 83 ec 20          	sub    $0x20,%rsp
    1f56:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    1f59:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1f60:	77 07                	ja     1f69 <morecore+0x1f>
    nu = 4096;
    1f62:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    1f69:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1f6c:	48 c1 e0 04          	shl    $0x4,%rax
    1f70:	48 89 c7             	mov    %rax,%rdi
    1f73:	48 b8 d0 17 00 00 00 	movabs $0x17d0,%rax
    1f7a:	00 00 00 
    1f7d:	ff d0                	call   *%rax
    1f7f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    1f83:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1f88:	75 07                	jne    1f91 <morecore+0x47>
    return 0;
    1f8a:	b8 00 00 00 00       	mov    $0x0,%eax
    1f8f:	eb 36                	jmp    1fc7 <morecore+0x7d>
  hp = (Header*)p;
    1f91:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f95:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    1f99:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f9d:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1fa0:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    1fa3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1fa7:	48 83 c0 10          	add    $0x10,%rax
    1fab:	48 89 c7             	mov    %rax,%rdi
    1fae:	48 b8 14 1e 00 00 00 	movabs $0x1e14,%rax
    1fb5:	00 00 00 
    1fb8:	ff d0                	call   *%rax
  return freep;
    1fba:	48 b8 30 23 00 00 00 	movabs $0x2330,%rax
    1fc1:	00 00 00 
    1fc4:	48 8b 00             	mov    (%rax),%rax
}
    1fc7:	c9                   	leave
    1fc8:	c3                   	ret

0000000000001fc9 <malloc>:

void*
malloc(uint nbytes)
{
    1fc9:	f3 0f 1e fa          	endbr64
    1fcd:	55                   	push   %rbp
    1fce:	48 89 e5             	mov    %rsp,%rbp
    1fd1:	48 83 ec 30          	sub    $0x30,%rsp
    1fd5:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1fd8:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1fdb:	48 83 c0 0f          	add    $0xf,%rax
    1fdf:	48 c1 e8 04          	shr    $0x4,%rax
    1fe3:	83 c0 01             	add    $0x1,%eax
    1fe6:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    1fe9:	48 b8 30 23 00 00 00 	movabs $0x2330,%rax
    1ff0:	00 00 00 
    1ff3:	48 8b 00             	mov    (%rax),%rax
    1ff6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1ffa:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1fff:	75 4a                	jne    204b <malloc+0x82>
    base.s.ptr = freep = prevp = &base;
    2001:	48 b8 20 23 00 00 00 	movabs $0x2320,%rax
    2008:	00 00 00 
    200b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    200f:	48 ba 30 23 00 00 00 	movabs $0x2330,%rdx
    2016:	00 00 00 
    2019:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    201d:	48 89 02             	mov    %rax,(%rdx)
    2020:	48 b8 30 23 00 00 00 	movabs $0x2330,%rax
    2027:	00 00 00 
    202a:	48 8b 00             	mov    (%rax),%rax
    202d:	48 ba 20 23 00 00 00 	movabs $0x2320,%rdx
    2034:	00 00 00 
    2037:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    203a:	48 b8 20 23 00 00 00 	movabs $0x2320,%rax
    2041:	00 00 00 
    2044:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    204b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    204f:	48 8b 00             	mov    (%rax),%rax
    2052:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    2056:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    205a:	8b 40 08             	mov    0x8(%rax),%eax
    205d:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    2060:	72 65                	jb     20c7 <malloc+0xfe>
      if(p->s.size == nunits)
    2062:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2066:	8b 40 08             	mov    0x8(%rax),%eax
    2069:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    206c:	75 10                	jne    207e <malloc+0xb5>
        prevp->s.ptr = p->s.ptr;
    206e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2072:	48 8b 10             	mov    (%rax),%rdx
    2075:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2079:	48 89 10             	mov    %rdx,(%rax)
    207c:	eb 2e                	jmp    20ac <malloc+0xe3>
      else {
        p->s.size -= nunits;
    207e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2082:	8b 40 08             	mov    0x8(%rax),%eax
    2085:	2b 45 ec             	sub    -0x14(%rbp),%eax
    2088:	89 c2                	mov    %eax,%edx
    208a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    208e:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    2091:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2095:	8b 40 08             	mov    0x8(%rax),%eax
    2098:	89 c0                	mov    %eax,%eax
    209a:	48 c1 e0 04          	shl    $0x4,%rax
    209e:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    20a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    20a6:	8b 55 ec             	mov    -0x14(%rbp),%edx
    20a9:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    20ac:	48 ba 30 23 00 00 00 	movabs $0x2330,%rdx
    20b3:	00 00 00 
    20b6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    20ba:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    20bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    20c1:	48 83 c0 10          	add    $0x10,%rax
    20c5:	eb 4e                	jmp    2115 <malloc+0x14c>
    }
    if(p == freep)
    20c7:	48 b8 30 23 00 00 00 	movabs $0x2330,%rax
    20ce:	00 00 00 
    20d1:	48 8b 00             	mov    (%rax),%rax
    20d4:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    20d8:	75 23                	jne    20fd <malloc+0x134>
      if((p = morecore(nunits)) == 0)
    20da:	8b 45 ec             	mov    -0x14(%rbp),%eax
    20dd:	89 c7                	mov    %eax,%edi
    20df:	48 b8 4a 1f 00 00 00 	movabs $0x1f4a,%rax
    20e6:	00 00 00 
    20e9:	ff d0                	call   *%rax
    20eb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    20ef:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    20f4:	75 07                	jne    20fd <malloc+0x134>
        return 0;
    20f6:	b8 00 00 00 00       	mov    $0x0,%eax
    20fb:	eb 18                	jmp    2115 <malloc+0x14c>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    20fd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2101:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    2105:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2109:	48 8b 00             	mov    (%rax),%rax
    210c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    2110:	e9 41 ff ff ff       	jmp    2056 <malloc+0x8d>
  }
}
    2115:	c9                   	leave
    2116:	c3                   	ret
