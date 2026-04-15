
_ipctest:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <server>:
#include "user.h"
#include "ipc.h"

void server() {
    1000:	f3 0f 1e fa          	endbr64
    1004:	55                   	push   %rbp
    1005:	48 89 e5             	mov    %rsp,%rbp
    1008:	48 81 ec e0 00 00 00 	sub    $0xe0,%rsp
    struct ipc_msg msg;
    printf(1, "Server: waiting for message...\n");
    100f:	48 b8 90 20 00 00 00 	movabs $0x2090,%rax
    1016:	00 00 00 
    1019:	48 89 c6             	mov    %rax,%rsi
    101c:	bf 01 00 00 00       	mov    $0x1,%edi
    1021:	b8 00 00 00 00       	mov    $0x0,%eax
    1026:	48 ba 89 19 00 00 00 	movabs $0x1989,%rdx
    102d:	00 00 00 
    1030:	ff d2                	call   *%rdx
    
    if (recv(&msg) < 0) {
    1032:	48 8d 85 20 ff ff ff 	lea    -0xe0(%rbp),%rax
    1039:	48 89 c7             	mov    %rax,%rdi
    103c:	48 b8 96 17 00 00 00 	movabs $0x1796,%rax
    1043:	00 00 00 
    1046:	ff d0                	call   *%rax
    1048:	85 c0                	test   %eax,%eax
    104a:	79 2f                	jns    107b <server+0x7b>
        printf(1, "Server: receive failed\n");
    104c:	48 b8 b0 20 00 00 00 	movabs $0x20b0,%rax
    1053:	00 00 00 
    1056:	48 89 c6             	mov    %rax,%rsi
    1059:	bf 01 00 00 00       	mov    $0x1,%edi
    105e:	b8 00 00 00 00       	mov    $0x0,%eax
    1063:	48 ba 89 19 00 00 00 	movabs $0x1989,%rdx
    106a:	00 00 00 
    106d:	ff d2                	call   *%rdx
        exit();
    106f:	48 b8 85 16 00 00 00 	movabs $0x1685,%rax
    1076:	00 00 00 
    1079:	ff d0                	call   *%rax
    }

    printf(1, "Server: received from PID %d: %s\n", msg.sender_pid, msg.data);
    107b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1081:	48 8d 95 20 ff ff ff 	lea    -0xe0(%rbp),%rdx
    1088:	48 83 c2 58          	add    $0x58,%rdx
    108c:	48 89 d1             	mov    %rdx,%rcx
    108f:	89 c2                	mov    %eax,%edx
    1091:	48 b8 c8 20 00 00 00 	movabs $0x20c8,%rax
    1098:	00 00 00 
    109b:	48 89 c6             	mov    %rax,%rsi
    109e:	bf 01 00 00 00       	mov    $0x1,%edi
    10a3:	b8 00 00 00 00       	mov    $0x0,%eax
    10a8:	49 b8 89 19 00 00 00 	movabs $0x1989,%r8
    10af:	00 00 00 
    10b2:	41 ff d0             	call   *%r8
    
    int client_pid = msg.sender_pid;
    10b5:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    10bb:	89 45 fc             	mov    %eax,-0x4(%rbp)
    msg.sender_pid = getpid();
    10be:	48 b8 55 17 00 00 00 	movabs $0x1755,%rax
    10c5:	00 00 00 
    10c8:	ff d0                	call   *%rax
    10ca:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%rbp)
    strcpy(msg.data, "ACK");
    10d0:	48 8d 85 20 ff ff ff 	lea    -0xe0(%rbp),%rax
    10d7:	48 83 c0 58          	add    $0x58,%rax
    10db:	48 ba ea 20 00 00 00 	movabs $0x20ea,%rdx
    10e2:	00 00 00 
    10e5:	48 89 d6             	mov    %rdx,%rsi
    10e8:	48 89 c7             	mov    %rax,%rdi
    10eb:	48 b8 7c 13 00 00 00 	movabs $0x137c,%rax
    10f2:	00 00 00 
    10f5:	ff d0                	call   *%rax
    
    if (send(client_pid, &msg) < 0) {
    10f7:	48 8d 95 20 ff ff ff 	lea    -0xe0(%rbp),%rdx
    10fe:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1101:	48 89 d6             	mov    %rdx,%rsi
    1104:	89 c7                	mov    %eax,%edi
    1106:	48 b8 89 17 00 00 00 	movabs $0x1789,%rax
    110d:	00 00 00 
    1110:	ff d0                	call   *%rax
    1112:	85 c0                	test   %eax,%eax
    1114:	79 23                	jns    1139 <server+0x139>
        printf(1, "Server: send failed\n");
    1116:	48 b8 ee 20 00 00 00 	movabs $0x20ee,%rax
    111d:	00 00 00 
    1120:	48 89 c6             	mov    %rax,%rsi
    1123:	bf 01 00 00 00       	mov    $0x1,%edi
    1128:	b8 00 00 00 00       	mov    $0x0,%eax
    112d:	48 ba 89 19 00 00 00 	movabs $0x1989,%rdx
    1134:	00 00 00 
    1137:	ff d2                	call   *%rdx
    }
    exit();
    1139:	48 b8 85 16 00 00 00 	movabs $0x1685,%rax
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
    msg.sender_pid = getpid();
    115a:	48 b8 55 17 00 00 00 	movabs $0x1755,%rax
    1161:	00 00 00 
    1164:	ff d0                	call   *%rax
    1166:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%rbp)
    msg.type = 1;
    116c:	c7 85 24 ff ff ff 01 	movl   $0x1,-0xdc(%rbp)
    1173:	00 00 00 
    strcpy(msg.data, "REQ_FS_OPEN");
    1176:	48 8d 85 20 ff ff ff 	lea    -0xe0(%rbp),%rax
    117d:	48 83 c0 58          	add    $0x58,%rax
    1181:	48 ba 03 21 00 00 00 	movabs $0x2103,%rdx
    1188:	00 00 00 
    118b:	48 89 d6             	mov    %rdx,%rsi
    118e:	48 89 c7             	mov    %rax,%rdi
    1191:	48 b8 7c 13 00 00 00 	movabs $0x137c,%rax
    1198:	00 00 00 
    119b:	ff d0                	call   *%rax

    printf(1, "Client: sending to PID %d\n", server_pid);
    119d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    11a3:	89 c2                	mov    %eax,%edx
    11a5:	48 b8 0f 21 00 00 00 	movabs $0x210f,%rax
    11ac:	00 00 00 
    11af:	48 89 c6             	mov    %rax,%rsi
    11b2:	bf 01 00 00 00       	mov    $0x1,%edi
    11b7:	b8 00 00 00 00       	mov    $0x0,%eax
    11bc:	48 b9 89 19 00 00 00 	movabs $0x1989,%rcx
    11c3:	00 00 00 
    11c6:	ff d1                	call   *%rcx
    
    if (send(server_pid, &msg) < 0) {
    11c8:	48 8d 95 20 ff ff ff 	lea    -0xe0(%rbp),%rdx
    11cf:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    11d5:	48 89 d6             	mov    %rdx,%rsi
    11d8:	89 c7                	mov    %eax,%edi
    11da:	48 b8 89 17 00 00 00 	movabs $0x1789,%rax
    11e1:	00 00 00 
    11e4:	ff d0                	call   *%rax
    11e6:	85 c0                	test   %eax,%eax
    11e8:	79 2f                	jns    1219 <client+0xd4>
        printf(1, "Client: send failed\n");
    11ea:	48 b8 2a 21 00 00 00 	movabs $0x212a,%rax
    11f1:	00 00 00 
    11f4:	48 89 c6             	mov    %rax,%rsi
    11f7:	bf 01 00 00 00       	mov    $0x1,%edi
    11fc:	b8 00 00 00 00       	mov    $0x0,%eax
    1201:	48 ba 89 19 00 00 00 	movabs $0x1989,%rdx
    1208:	00 00 00 
    120b:	ff d2                	call   *%rdx
        exit();
    120d:	48 b8 85 16 00 00 00 	movabs $0x1685,%rax
    1214:	00 00 00 
    1217:	ff d0                	call   *%rax
    }

    if (recv(&msg) < 0) {
    1219:	48 8d 85 20 ff ff ff 	lea    -0xe0(%rbp),%rax
    1220:	48 89 c7             	mov    %rax,%rdi
    1223:	48 b8 96 17 00 00 00 	movabs $0x1796,%rax
    122a:	00 00 00 
    122d:	ff d0                	call   *%rax
    122f:	85 c0                	test   %eax,%eax
    1231:	79 2f                	jns    1262 <client+0x11d>
        printf(1, "Client: receive failed\n");
    1233:	48 b8 3f 21 00 00 00 	movabs $0x213f,%rax
    123a:	00 00 00 
    123d:	48 89 c6             	mov    %rax,%rsi
    1240:	bf 01 00 00 00       	mov    $0x1,%edi
    1245:	b8 00 00 00 00       	mov    $0x0,%eax
    124a:	48 ba 89 19 00 00 00 	movabs $0x1989,%rdx
    1251:	00 00 00 
    1254:	ff d2                	call   *%rdx
        exit();
    1256:	48 b8 85 16 00 00 00 	movabs $0x1685,%rax
    125d:	00 00 00 
    1260:	ff d0                	call   *%rax
    }

    printf(1, "Client: server responded with: %s\n", msg.data);
    1262:	48 8d 85 20 ff ff ff 	lea    -0xe0(%rbp),%rax
    1269:	48 83 c0 58          	add    $0x58,%rax
    126d:	48 89 c2             	mov    %rax,%rdx
    1270:	48 b8 58 21 00 00 00 	movabs $0x2158,%rax
    1277:	00 00 00 
    127a:	48 89 c6             	mov    %rax,%rsi
    127d:	bf 01 00 00 00       	mov    $0x1,%edi
    1282:	b8 00 00 00 00       	mov    $0x0,%eax
    1287:	48 b9 89 19 00 00 00 	movabs $0x1989,%rcx
    128e:	00 00 00 
    1291:	ff d1                	call   *%rcx
    exit();
    1293:	48 b8 85 16 00 00 00 	movabs $0x1685,%rax
    129a:	00 00 00 
    129d:	ff d0                	call   *%rax

000000000000129f <main>:
}

int main(void) {
    129f:	f3 0f 1e fa          	endbr64
    12a3:	55                   	push   %rbp
    12a4:	48 89 e5             	mov    %rsp,%rbp
    12a7:	48 83 ec 10          	sub    $0x10,%rsp
    int pid = fork();
    12ab:	48 b8 78 16 00 00 00 	movabs $0x1678,%rax
    12b2:	00 00 00 
    12b5:	ff d0                	call   *%rax
    12b7:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (pid < 0) {
    12ba:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    12be:	79 2f                	jns    12ef <main+0x50>
        printf(1, "Fork failed\n");
    12c0:	48 b8 7b 21 00 00 00 	movabs $0x217b,%rax
    12c7:	00 00 00 
    12ca:	48 89 c6             	mov    %rax,%rsi
    12cd:	bf 01 00 00 00       	mov    $0x1,%edi
    12d2:	b8 00 00 00 00       	mov    $0x0,%eax
    12d7:	48 ba 89 19 00 00 00 	movabs $0x1989,%rdx
    12de:	00 00 00 
    12e1:	ff d2                	call   *%rdx
        exit();
    12e3:	48 b8 85 16 00 00 00 	movabs $0x1685,%rax
    12ea:	00 00 00 
    12ed:	ff d0                	call   *%rax
    }

    if (pid == 0) {
    12ef:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    12f3:	75 13                	jne    1308 <main+0x69>
        server();
    12f5:	b8 00 00 00 00       	mov    $0x0,%eax
    12fa:	48 ba 00 10 00 00 00 	movabs $0x1000,%rdx
    1301:	00 00 00 
    1304:	ff d2                	call   *%rdx
    1306:	eb 22                	jmp    132a <main+0x8b>
    } else {
        // Give the server a moment to enter recv()
        sleep(10); 
    1308:	bf 0a 00 00 00       	mov    $0xa,%edi
    130d:	48 b8 6f 17 00 00 00 	movabs $0x176f,%rax
    1314:	00 00 00 
    1317:	ff d0                	call   *%rax
        client(pid);
    1319:	8b 45 fc             	mov    -0x4(%rbp),%eax
    131c:	89 c7                	mov    %eax,%edi
    131e:	48 b8 45 11 00 00 00 	movabs $0x1145,%rax
    1325:	00 00 00 
    1328:	ff d0                	call   *%rax
    }

    wait();
    132a:	48 b8 92 16 00 00 00 	movabs $0x1692,%rax
    1331:	00 00 00 
    1334:	ff d0                	call   *%rax
    exit();
    1336:	48 b8 85 16 00 00 00 	movabs $0x1685,%rax
    133d:	00 00 00 
    1340:	ff d0                	call   *%rax

0000000000001342 <stosb>:
  stosb(dst, c, n);
  return dst;
}

char*
strchr(const char *s, char c)
    1342:	f3 0f 1e fa          	endbr64
    1346:	55                   	push   %rbp
    1347:	48 89 e5             	mov    %rsp,%rbp
    134a:	48 83 ec 10          	sub    $0x10,%rsp
    134e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1352:	89 75 f4             	mov    %esi,-0xc(%rbp)
    1355:	89 55 f0             	mov    %edx,-0x10(%rbp)
{
    1358:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    135c:	8b 55 f0             	mov    -0x10(%rbp),%edx
    135f:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1362:	48 89 ce             	mov    %rcx,%rsi
    1365:	48 89 f7             	mov    %rsi,%rdi
    1368:	89 d1                	mov    %edx,%ecx
    136a:	fc                   	cld
    136b:	f3 aa                	rep stos %al,%es:(%rdi)
    136d:	89 ca                	mov    %ecx,%edx
    136f:	48 89 fe             	mov    %rdi,%rsi
    1372:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    1376:	89 55 f0             	mov    %edx,-0x10(%rbp)
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
    1379:	90                   	nop
    137a:	c9                   	leave
    137b:	c3                   	ret

000000000000137c <strcpy>:
{
    137c:	f3 0f 1e fa          	endbr64
    1380:	55                   	push   %rbp
    1381:	48 89 e5             	mov    %rsp,%rbp
    1384:	48 83 ec 20          	sub    $0x20,%rsp
    1388:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    138c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  os = s;
    1390:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1394:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    1398:	90                   	nop
    1399:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    139d:	48 8d 42 01          	lea    0x1(%rdx),%rax
    13a1:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    13a5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    13a9:	48 8d 48 01          	lea    0x1(%rax),%rcx
    13ad:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    13b1:	0f b6 12             	movzbl (%rdx),%edx
    13b4:	88 10                	mov    %dl,(%rax)
    13b6:	0f b6 00             	movzbl (%rax),%eax
    13b9:	84 c0                	test   %al,%al
    13bb:	75 dc                	jne    1399 <strcpy+0x1d>
  return os;
    13bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    13c1:	c9                   	leave
    13c2:	c3                   	ret

00000000000013c3 <strcmp>:
{
    13c3:	f3 0f 1e fa          	endbr64
    13c7:	55                   	push   %rbp
    13c8:	48 89 e5             	mov    %rsp,%rbp
    13cb:	48 83 ec 10          	sub    $0x10,%rsp
    13cf:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    13d3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    13d7:	eb 0a                	jmp    13e3 <strcmp+0x20>
    p++, q++;
    13d9:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    13de:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    13e3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13e7:	0f b6 00             	movzbl (%rax),%eax
    13ea:	84 c0                	test   %al,%al
    13ec:	74 12                	je     1400 <strcmp+0x3d>
    13ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13f2:	0f b6 10             	movzbl (%rax),%edx
    13f5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    13f9:	0f b6 00             	movzbl (%rax),%eax
    13fc:	38 c2                	cmp    %al,%dl
    13fe:	74 d9                	je     13d9 <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
    1400:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1404:	0f b6 00             	movzbl (%rax),%eax
    1407:	0f b6 d0             	movzbl %al,%edx
    140a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    140e:	0f b6 00             	movzbl (%rax),%eax
    1411:	0f b6 c0             	movzbl %al,%eax
    1414:	29 c2                	sub    %eax,%edx
    1416:	89 d0                	mov    %edx,%eax
}
    1418:	c9                   	leave
    1419:	c3                   	ret

000000000000141a <strlen>:
{
    141a:	f3 0f 1e fa          	endbr64
    141e:	55                   	push   %rbp
    141f:	48 89 e5             	mov    %rsp,%rbp
    1422:	48 83 ec 18          	sub    $0x18,%rsp
    1426:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  for(n = 0; s[n]; n++)
    142a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1431:	eb 04                	jmp    1437 <strlen+0x1d>
    1433:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1437:	8b 45 fc             	mov    -0x4(%rbp),%eax
    143a:	48 63 d0             	movslq %eax,%rdx
    143d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1441:	48 01 d0             	add    %rdx,%rax
    1444:	0f b6 00             	movzbl (%rax),%eax
    1447:	84 c0                	test   %al,%al
    1449:	75 e8                	jne    1433 <strlen+0x19>
  return n;
    144b:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    144e:	c9                   	leave
    144f:	c3                   	ret

0000000000001450 <memset>:
{
    1450:	f3 0f 1e fa          	endbr64
    1454:	55                   	push   %rbp
    1455:	48 89 e5             	mov    %rsp,%rbp
    1458:	48 83 ec 10          	sub    $0x10,%rsp
    145c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1460:	89 75 f4             	mov    %esi,-0xc(%rbp)
    1463:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    1466:	8b 55 f0             	mov    -0x10(%rbp),%edx
    1469:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    146c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1470:	89 ce                	mov    %ecx,%esi
    1472:	48 89 c7             	mov    %rax,%rdi
    1475:	48 b8 42 13 00 00 00 	movabs $0x1342,%rax
    147c:	00 00 00 
    147f:	ff d0                	call   *%rax
  return dst;
    1481:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    1485:	c9                   	leave
    1486:	c3                   	ret

0000000000001487 <strchr>:
{
    1487:	f3 0f 1e fa          	endbr64
    148b:	55                   	push   %rbp
    148c:	48 89 e5             	mov    %rsp,%rbp
    148f:	48 83 ec 10          	sub    $0x10,%rsp
    1493:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1497:	89 f0                	mov    %esi,%eax
    1499:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    149c:	eb 17                	jmp    14b5 <strchr+0x2e>
    if(*s == c)
    149e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    14a2:	0f b6 00             	movzbl (%rax),%eax
    14a5:	38 45 f4             	cmp    %al,-0xc(%rbp)
    14a8:	75 06                	jne    14b0 <strchr+0x29>
      return (char*)s;
    14aa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    14ae:	eb 15                	jmp    14c5 <strchr+0x3e>
  for(; *s; s++)
    14b0:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    14b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    14b9:	0f b6 00             	movzbl (%rax),%eax
    14bc:	84 c0                	test   %al,%al
    14be:	75 de                	jne    149e <strchr+0x17>
  return 0;
    14c0:	b8 00 00 00 00       	mov    $0x0,%eax
}
    14c5:	c9                   	leave
    14c6:	c3                   	ret

00000000000014c7 <gets>:

char*
gets(char *buf, int max)
{
    14c7:	f3 0f 1e fa          	endbr64
    14cb:	55                   	push   %rbp
    14cc:	48 89 e5             	mov    %rsp,%rbp
    14cf:	48 83 ec 20          	sub    $0x20,%rsp
    14d3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    14d7:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    14da:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    14e1:	eb 4f                	jmp    1532 <gets+0x6b>
    cc = read(0, &c, 1);
    14e3:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    14e7:	ba 01 00 00 00       	mov    $0x1,%edx
    14ec:	48 89 c6             	mov    %rax,%rsi
    14ef:	bf 00 00 00 00       	mov    $0x0,%edi
    14f4:	48 b8 ac 16 00 00 00 	movabs $0x16ac,%rax
    14fb:	00 00 00 
    14fe:	ff d0                	call   *%rax
    1500:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    1503:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1507:	7e 36                	jle    153f <gets+0x78>
      break;
    buf[i++] = c;
    1509:	8b 45 fc             	mov    -0x4(%rbp),%eax
    150c:	8d 50 01             	lea    0x1(%rax),%edx
    150f:	89 55 fc             	mov    %edx,-0x4(%rbp)
    1512:	48 63 d0             	movslq %eax,%rdx
    1515:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1519:	48 01 c2             	add    %rax,%rdx
    151c:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1520:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    1522:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1526:	3c 0a                	cmp    $0xa,%al
    1528:	74 16                	je     1540 <gets+0x79>
    152a:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    152e:	3c 0d                	cmp    $0xd,%al
    1530:	74 0e                	je     1540 <gets+0x79>
  for(i=0; i+1 < max; ){
    1532:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1535:	83 c0 01             	add    $0x1,%eax
    1538:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    153b:	7f a6                	jg     14e3 <gets+0x1c>
    153d:	eb 01                	jmp    1540 <gets+0x79>
      break;
    153f:	90                   	nop
      break;
  }
  buf[i] = '\0';
    1540:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1543:	48 63 d0             	movslq %eax,%rdx
    1546:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    154a:	48 01 d0             	add    %rdx,%rax
    154d:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    1550:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    1554:	c9                   	leave
    1555:	c3                   	ret

0000000000001556 <stat>:

int
stat(char *n, struct stat *st)
{
    1556:	f3 0f 1e fa          	endbr64
    155a:	55                   	push   %rbp
    155b:	48 89 e5             	mov    %rsp,%rbp
    155e:	48 83 ec 20          	sub    $0x20,%rsp
    1562:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1566:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    156a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    156e:	be 00 00 00 00       	mov    $0x0,%esi
    1573:	48 89 c7             	mov    %rax,%rdi
    1576:	48 b8 ed 16 00 00 00 	movabs $0x16ed,%rax
    157d:	00 00 00 
    1580:	ff d0                	call   *%rax
    1582:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    1585:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1589:	79 07                	jns    1592 <stat+0x3c>
    return -1;
    158b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1590:	eb 2f                	jmp    15c1 <stat+0x6b>
  r = fstat(fd, st);
    1592:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1596:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1599:	48 89 d6             	mov    %rdx,%rsi
    159c:	89 c7                	mov    %eax,%edi
    159e:	48 b8 14 17 00 00 00 	movabs $0x1714,%rax
    15a5:	00 00 00 
    15a8:	ff d0                	call   *%rax
    15aa:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    15ad:	8b 45 fc             	mov    -0x4(%rbp),%eax
    15b0:	89 c7                	mov    %eax,%edi
    15b2:	48 b8 c6 16 00 00 00 	movabs $0x16c6,%rax
    15b9:	00 00 00 
    15bc:	ff d0                	call   *%rax
  return r;
    15be:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    15c1:	c9                   	leave
    15c2:	c3                   	ret

00000000000015c3 <atoi>:

int
atoi(const char *s)
{
    15c3:	f3 0f 1e fa          	endbr64
    15c7:	55                   	push   %rbp
    15c8:	48 89 e5             	mov    %rsp,%rbp
    15cb:	48 83 ec 18          	sub    $0x18,%rsp
    15cf:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    15d3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    15da:	eb 28                	jmp    1604 <atoi+0x41>
    n = n*10 + *s++ - '0';
    15dc:	8b 55 fc             	mov    -0x4(%rbp),%edx
    15df:	89 d0                	mov    %edx,%eax
    15e1:	c1 e0 02             	shl    $0x2,%eax
    15e4:	01 d0                	add    %edx,%eax
    15e6:	01 c0                	add    %eax,%eax
    15e8:	89 c1                	mov    %eax,%ecx
    15ea:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    15ee:	48 8d 50 01          	lea    0x1(%rax),%rdx
    15f2:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    15f6:	0f b6 00             	movzbl (%rax),%eax
    15f9:	0f be c0             	movsbl %al,%eax
    15fc:	01 c8                	add    %ecx,%eax
    15fe:	83 e8 30             	sub    $0x30,%eax
    1601:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1604:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1608:	0f b6 00             	movzbl (%rax),%eax
    160b:	3c 2f                	cmp    $0x2f,%al
    160d:	7e 0b                	jle    161a <atoi+0x57>
    160f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1613:	0f b6 00             	movzbl (%rax),%eax
    1616:	3c 39                	cmp    $0x39,%al
    1618:	7e c2                	jle    15dc <atoi+0x19>
  return n;
    161a:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    161d:	c9                   	leave
    161e:	c3                   	ret

000000000000161f <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    161f:	f3 0f 1e fa          	endbr64
    1623:	55                   	push   %rbp
    1624:	48 89 e5             	mov    %rsp,%rbp
    1627:	48 83 ec 28          	sub    $0x28,%rsp
    162b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    162f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    1633:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    1636:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    163a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    163e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1642:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    1646:	eb 1d                	jmp    1665 <memmove+0x46>
    *dst++ = *src++;
    1648:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    164c:	48 8d 42 01          	lea    0x1(%rdx),%rax
    1650:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1654:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1658:	48 8d 48 01          	lea    0x1(%rax),%rcx
    165c:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    1660:	0f b6 12             	movzbl (%rdx),%edx
    1663:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    1665:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1668:	8d 50 ff             	lea    -0x1(%rax),%edx
    166b:	89 55 dc             	mov    %edx,-0x24(%rbp)
    166e:	85 c0                	test   %eax,%eax
    1670:	7f d6                	jg     1648 <memmove+0x29>
  return vdst;
    1672:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    1676:	c9                   	leave
    1677:	c3                   	ret

0000000000001678 <fork>:
    1678:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    167f:	49 89 ca             	mov    %rcx,%r10
    1682:	0f 05                	syscall
    1684:	c3                   	ret

0000000000001685 <exit>:
    1685:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    168c:	49 89 ca             	mov    %rcx,%r10
    168f:	0f 05                	syscall
    1691:	c3                   	ret

0000000000001692 <wait>:
    1692:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    1699:	49 89 ca             	mov    %rcx,%r10
    169c:	0f 05                	syscall
    169e:	c3                   	ret

000000000000169f <pipe>:
    169f:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    16a6:	49 89 ca             	mov    %rcx,%r10
    16a9:	0f 05                	syscall
    16ab:	c3                   	ret

00000000000016ac <read>:
    16ac:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    16b3:	49 89 ca             	mov    %rcx,%r10
    16b6:	0f 05                	syscall
    16b8:	c3                   	ret

00000000000016b9 <write>:
    16b9:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    16c0:	49 89 ca             	mov    %rcx,%r10
    16c3:	0f 05                	syscall
    16c5:	c3                   	ret

00000000000016c6 <close>:
    16c6:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    16cd:	49 89 ca             	mov    %rcx,%r10
    16d0:	0f 05                	syscall
    16d2:	c3                   	ret

00000000000016d3 <kill>:
    16d3:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    16da:	49 89 ca             	mov    %rcx,%r10
    16dd:	0f 05                	syscall
    16df:	c3                   	ret

00000000000016e0 <exec>:
    16e0:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    16e7:	49 89 ca             	mov    %rcx,%r10
    16ea:	0f 05                	syscall
    16ec:	c3                   	ret

00000000000016ed <open>:
    16ed:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    16f4:	49 89 ca             	mov    %rcx,%r10
    16f7:	0f 05                	syscall
    16f9:	c3                   	ret

00000000000016fa <mknod>:
    16fa:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    1701:	49 89 ca             	mov    %rcx,%r10
    1704:	0f 05                	syscall
    1706:	c3                   	ret

0000000000001707 <unlink>:
    1707:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    170e:	49 89 ca             	mov    %rcx,%r10
    1711:	0f 05                	syscall
    1713:	c3                   	ret

0000000000001714 <fstat>:
    1714:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    171b:	49 89 ca             	mov    %rcx,%r10
    171e:	0f 05                	syscall
    1720:	c3                   	ret

0000000000001721 <link>:
    1721:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    1728:	49 89 ca             	mov    %rcx,%r10
    172b:	0f 05                	syscall
    172d:	c3                   	ret

000000000000172e <mkdir>:
    172e:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    1735:	49 89 ca             	mov    %rcx,%r10
    1738:	0f 05                	syscall
    173a:	c3                   	ret

000000000000173b <chdir>:
    173b:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    1742:	49 89 ca             	mov    %rcx,%r10
    1745:	0f 05                	syscall
    1747:	c3                   	ret

0000000000001748 <dup>:
    1748:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    174f:	49 89 ca             	mov    %rcx,%r10
    1752:	0f 05                	syscall
    1754:	c3                   	ret

0000000000001755 <getpid>:
    1755:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    175c:	49 89 ca             	mov    %rcx,%r10
    175f:	0f 05                	syscall
    1761:	c3                   	ret

0000000000001762 <sbrk>:
    1762:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    1769:	49 89 ca             	mov    %rcx,%r10
    176c:	0f 05                	syscall
    176e:	c3                   	ret

000000000000176f <sleep>:
    176f:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    1776:	49 89 ca             	mov    %rcx,%r10
    1779:	0f 05                	syscall
    177b:	c3                   	ret

000000000000177c <uptime>:
    177c:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    1783:	49 89 ca             	mov    %rcx,%r10
    1786:	0f 05                	syscall
    1788:	c3                   	ret

0000000000001789 <send>:
    1789:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    1790:	49 89 ca             	mov    %rcx,%r10
    1793:	0f 05                	syscall
    1795:	c3                   	ret

0000000000001796 <recv>:
    1796:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    179d:	49 89 ca             	mov    %rcx,%r10
    17a0:	0f 05                	syscall
    17a2:	c3                   	ret

00000000000017a3 <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    17a3:	f3 0f 1e fa          	endbr64
    17a7:	55                   	push   %rbp
    17a8:	48 89 e5             	mov    %rsp,%rbp
    17ab:	48 83 ec 10          	sub    $0x10,%rsp
    17af:	89 7d fc             	mov    %edi,-0x4(%rbp)
    17b2:	89 f0                	mov    %esi,%eax
    17b4:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    17b7:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    17bb:	8b 45 fc             	mov    -0x4(%rbp),%eax
    17be:	ba 01 00 00 00       	mov    $0x1,%edx
    17c3:	48 89 ce             	mov    %rcx,%rsi
    17c6:	89 c7                	mov    %eax,%edi
    17c8:	48 b8 b9 16 00 00 00 	movabs $0x16b9,%rax
    17cf:	00 00 00 
    17d2:	ff d0                	call   *%rax
}
    17d4:	90                   	nop
    17d5:	c9                   	leave
    17d6:	c3                   	ret

00000000000017d7 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    17d7:	f3 0f 1e fa          	endbr64
    17db:	55                   	push   %rbp
    17dc:	48 89 e5             	mov    %rsp,%rbp
    17df:	48 83 ec 20          	sub    $0x20,%rsp
    17e3:	89 7d ec             	mov    %edi,-0x14(%rbp)
    17e6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    17ea:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    17f1:	eb 35                	jmp    1828 <print_x64+0x51>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    17f3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    17f7:	48 c1 e8 3c          	shr    $0x3c,%rax
    17fb:	48 ba 40 22 00 00 00 	movabs $0x2240,%rdx
    1802:	00 00 00 
    1805:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1809:	0f be d0             	movsbl %al,%edx
    180c:	8b 45 ec             	mov    -0x14(%rbp),%eax
    180f:	89 d6                	mov    %edx,%esi
    1811:	89 c7                	mov    %eax,%edi
    1813:	48 b8 a3 17 00 00 00 	movabs $0x17a3,%rax
    181a:	00 00 00 
    181d:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    181f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1823:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    1828:	8b 45 fc             	mov    -0x4(%rbp),%eax
    182b:	83 f8 0f             	cmp    $0xf,%eax
    182e:	76 c3                	jbe    17f3 <print_x64+0x1c>
}
    1830:	90                   	nop
    1831:	90                   	nop
    1832:	c9                   	leave
    1833:	c3                   	ret

0000000000001834 <print_x32>:

  static void
print_x32(int fd, uint x)
{
    1834:	f3 0f 1e fa          	endbr64
    1838:	55                   	push   %rbp
    1839:	48 89 e5             	mov    %rsp,%rbp
    183c:	48 83 ec 20          	sub    $0x20,%rsp
    1840:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1843:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1846:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    184d:	eb 36                	jmp    1885 <print_x32+0x51>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    184f:	8b 45 e8             	mov    -0x18(%rbp),%eax
    1852:	c1 e8 1c             	shr    $0x1c,%eax
    1855:	89 c2                	mov    %eax,%edx
    1857:	48 b8 40 22 00 00 00 	movabs $0x2240,%rax
    185e:	00 00 00 
    1861:	89 d2                	mov    %edx,%edx
    1863:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    1867:	0f be d0             	movsbl %al,%edx
    186a:	8b 45 ec             	mov    -0x14(%rbp),%eax
    186d:	89 d6                	mov    %edx,%esi
    186f:	89 c7                	mov    %eax,%edi
    1871:	48 b8 a3 17 00 00 00 	movabs $0x17a3,%rax
    1878:	00 00 00 
    187b:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    187d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1881:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    1885:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1888:	83 f8 07             	cmp    $0x7,%eax
    188b:	76 c2                	jbe    184f <print_x32+0x1b>
}
    188d:	90                   	nop
    188e:	90                   	nop
    188f:	c9                   	leave
    1890:	c3                   	ret

0000000000001891 <print_d>:

  static void
print_d(int fd, int v)
{
    1891:	f3 0f 1e fa          	endbr64
    1895:	55                   	push   %rbp
    1896:	48 89 e5             	mov    %rsp,%rbp
    1899:	48 83 ec 30          	sub    $0x30,%rsp
    189d:	89 7d dc             	mov    %edi,-0x24(%rbp)
    18a0:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    18a3:	8b 45 d8             	mov    -0x28(%rbp),%eax
    18a6:	48 98                	cltq
    18a8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    18ac:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    18b0:	79 04                	jns    18b6 <print_d+0x25>
    x = -x;
    18b2:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    18b6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    18bd:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    18c1:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    18c8:	66 66 66 
    18cb:	48 89 c8             	mov    %rcx,%rax
    18ce:	48 f7 ea             	imul   %rdx
    18d1:	48 c1 fa 02          	sar    $0x2,%rdx
    18d5:	48 89 c8             	mov    %rcx,%rax
    18d8:	48 c1 f8 3f          	sar    $0x3f,%rax
    18dc:	48 29 c2             	sub    %rax,%rdx
    18df:	48 89 d0             	mov    %rdx,%rax
    18e2:	48 c1 e0 02          	shl    $0x2,%rax
    18e6:	48 01 d0             	add    %rdx,%rax
    18e9:	48 01 c0             	add    %rax,%rax
    18ec:	48 29 c1             	sub    %rax,%rcx
    18ef:	48 89 ca             	mov    %rcx,%rdx
    18f2:	8b 45 f4             	mov    -0xc(%rbp),%eax
    18f5:	8d 48 01             	lea    0x1(%rax),%ecx
    18f8:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    18fb:	48 b9 40 22 00 00 00 	movabs $0x2240,%rcx
    1902:	00 00 00 
    1905:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    1909:	48 98                	cltq
    190b:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    190f:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1913:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    191a:	66 66 66 
    191d:	48 89 c8             	mov    %rcx,%rax
    1920:	48 f7 ea             	imul   %rdx
    1923:	48 89 d0             	mov    %rdx,%rax
    1926:	48 c1 f8 02          	sar    $0x2,%rax
    192a:	48 c1 f9 3f          	sar    $0x3f,%rcx
    192e:	48 89 ca             	mov    %rcx,%rdx
    1931:	48 29 d0             	sub    %rdx,%rax
    1934:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    1938:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    193d:	0f 85 7a ff ff ff    	jne    18bd <print_d+0x2c>

  if (v < 0)
    1943:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1947:	79 32                	jns    197b <print_d+0xea>
    buf[i++] = '-';
    1949:	8b 45 f4             	mov    -0xc(%rbp),%eax
    194c:	8d 50 01             	lea    0x1(%rax),%edx
    194f:	89 55 f4             	mov    %edx,-0xc(%rbp)
    1952:	48 98                	cltq
    1954:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    1959:	eb 20                	jmp    197b <print_d+0xea>
    putc(fd, buf[i]);
    195b:	8b 45 f4             	mov    -0xc(%rbp),%eax
    195e:	48 98                	cltq
    1960:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    1965:	0f be d0             	movsbl %al,%edx
    1968:	8b 45 dc             	mov    -0x24(%rbp),%eax
    196b:	89 d6                	mov    %edx,%esi
    196d:	89 c7                	mov    %eax,%edi
    196f:	48 b8 a3 17 00 00 00 	movabs $0x17a3,%rax
    1976:	00 00 00 
    1979:	ff d0                	call   *%rax
  while (--i >= 0)
    197b:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    197f:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1983:	79 d6                	jns    195b <print_d+0xca>
}
    1985:	90                   	nop
    1986:	90                   	nop
    1987:	c9                   	leave
    1988:	c3                   	ret

0000000000001989 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    1989:	f3 0f 1e fa          	endbr64
    198d:	55                   	push   %rbp
    198e:	48 89 e5             	mov    %rsp,%rbp
    1991:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    1998:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    199e:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    19a5:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    19ac:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    19b3:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    19ba:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    19c1:	84 c0                	test   %al,%al
    19c3:	74 20                	je     19e5 <printf+0x5c>
    19c5:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    19c9:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    19cd:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    19d1:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    19d5:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    19d9:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    19dd:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    19e1:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    19e5:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    19ec:	00 00 00 
    19ef:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    19f6:	00 00 00 
    19f9:	48 8d 45 10          	lea    0x10(%rbp),%rax
    19fd:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    1a04:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    1a0b:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1a12:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    1a19:	00 00 00 
    1a1c:	e9 41 03 00 00       	jmp    1d62 <printf+0x3d9>
    if (c != '%') {
    1a21:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1a28:	74 24                	je     1a4e <printf+0xc5>
      putc(fd, c);
    1a2a:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1a30:	0f be d0             	movsbl %al,%edx
    1a33:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a39:	89 d6                	mov    %edx,%esi
    1a3b:	89 c7                	mov    %eax,%edi
    1a3d:	48 b8 a3 17 00 00 00 	movabs $0x17a3,%rax
    1a44:	00 00 00 
    1a47:	ff d0                	call   *%rax
      continue;
    1a49:	e9 0d 03 00 00       	jmp    1d5b <printf+0x3d2>
    }
    c = fmt[++i] & 0xff;
    1a4e:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1a55:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1a5b:	48 63 d0             	movslq %eax,%rdx
    1a5e:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1a65:	48 01 d0             	add    %rdx,%rax
    1a68:	0f b6 00             	movzbl (%rax),%eax
    1a6b:	0f be c0             	movsbl %al,%eax
    1a6e:	25 ff 00 00 00       	and    $0xff,%eax
    1a73:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    1a79:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1a80:	0f 84 0f 03 00 00    	je     1d95 <printf+0x40c>
      break;
    switch(c) {
    1a86:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1a8d:	0f 84 74 02 00 00    	je     1d07 <printf+0x37e>
    1a93:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1a9a:	0f 8c 82 02 00 00    	jl     1d22 <printf+0x399>
    1aa0:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    1aa7:	0f 8f 75 02 00 00    	jg     1d22 <printf+0x399>
    1aad:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    1ab4:	0f 8c 68 02 00 00    	jl     1d22 <printf+0x399>
    1aba:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1ac0:	83 e8 63             	sub    $0x63,%eax
    1ac3:	83 f8 15             	cmp    $0x15,%eax
    1ac6:	0f 87 56 02 00 00    	ja     1d22 <printf+0x399>
    1acc:	89 c0                	mov    %eax,%eax
    1ace:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1ad5:	00 
    1ad6:	48 b8 90 21 00 00 00 	movabs $0x2190,%rax
    1add:	00 00 00 
    1ae0:	48 01 d0             	add    %rdx,%rax
    1ae3:	48 8b 00             	mov    (%rax),%rax
    1ae6:	3e ff e0             	notrack jmp *%rax
    case 'c':
      putc(fd, va_arg(ap, int));
    1ae9:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1aef:	83 f8 2f             	cmp    $0x2f,%eax
    1af2:	77 23                	ja     1b17 <printf+0x18e>
    1af4:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1afb:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b01:	89 d2                	mov    %edx,%edx
    1b03:	48 01 d0             	add    %rdx,%rax
    1b06:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b0c:	83 c2 08             	add    $0x8,%edx
    1b0f:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1b15:	eb 12                	jmp    1b29 <printf+0x1a0>
    1b17:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1b1e:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1b22:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1b29:	8b 00                	mov    (%rax),%eax
    1b2b:	0f be d0             	movsbl %al,%edx
    1b2e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b34:	89 d6                	mov    %edx,%esi
    1b36:	89 c7                	mov    %eax,%edi
    1b38:	48 b8 a3 17 00 00 00 	movabs $0x17a3,%rax
    1b3f:	00 00 00 
    1b42:	ff d0                	call   *%rax
      break;
    1b44:	e9 12 02 00 00       	jmp    1d5b <printf+0x3d2>
    case 'd':
      print_d(fd, va_arg(ap, int));
    1b49:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1b4f:	83 f8 2f             	cmp    $0x2f,%eax
    1b52:	77 23                	ja     1b77 <printf+0x1ee>
    1b54:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1b5b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b61:	89 d2                	mov    %edx,%edx
    1b63:	48 01 d0             	add    %rdx,%rax
    1b66:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b6c:	83 c2 08             	add    $0x8,%edx
    1b6f:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1b75:	eb 12                	jmp    1b89 <printf+0x200>
    1b77:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1b7e:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1b82:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1b89:	8b 10                	mov    (%rax),%edx
    1b8b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b91:	89 d6                	mov    %edx,%esi
    1b93:	89 c7                	mov    %eax,%edi
    1b95:	48 b8 91 18 00 00 00 	movabs $0x1891,%rax
    1b9c:	00 00 00 
    1b9f:	ff d0                	call   *%rax
      break;
    1ba1:	e9 b5 01 00 00       	jmp    1d5b <printf+0x3d2>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    1ba6:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1bac:	83 f8 2f             	cmp    $0x2f,%eax
    1baf:	77 23                	ja     1bd4 <printf+0x24b>
    1bb1:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1bb8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1bbe:	89 d2                	mov    %edx,%edx
    1bc0:	48 01 d0             	add    %rdx,%rax
    1bc3:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1bc9:	83 c2 08             	add    $0x8,%edx
    1bcc:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1bd2:	eb 12                	jmp    1be6 <printf+0x25d>
    1bd4:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1bdb:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1bdf:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1be6:	8b 10                	mov    (%rax),%edx
    1be8:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1bee:	89 d6                	mov    %edx,%esi
    1bf0:	89 c7                	mov    %eax,%edi
    1bf2:	48 b8 34 18 00 00 00 	movabs $0x1834,%rax
    1bf9:	00 00 00 
    1bfc:	ff d0                	call   *%rax
      break;
    1bfe:	e9 58 01 00 00       	jmp    1d5b <printf+0x3d2>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    1c03:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1c09:	83 f8 2f             	cmp    $0x2f,%eax
    1c0c:	77 23                	ja     1c31 <printf+0x2a8>
    1c0e:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1c15:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1c1b:	89 d2                	mov    %edx,%edx
    1c1d:	48 01 d0             	add    %rdx,%rax
    1c20:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1c26:	83 c2 08             	add    $0x8,%edx
    1c29:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1c2f:	eb 12                	jmp    1c43 <printf+0x2ba>
    1c31:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1c38:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1c3c:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1c43:	48 8b 10             	mov    (%rax),%rdx
    1c46:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1c4c:	48 89 d6             	mov    %rdx,%rsi
    1c4f:	89 c7                	mov    %eax,%edi
    1c51:	48 b8 d7 17 00 00 00 	movabs $0x17d7,%rax
    1c58:	00 00 00 
    1c5b:	ff d0                	call   *%rax
      break;
    1c5d:	e9 f9 00 00 00       	jmp    1d5b <printf+0x3d2>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    1c62:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1c68:	83 f8 2f             	cmp    $0x2f,%eax
    1c6b:	77 23                	ja     1c90 <printf+0x307>
    1c6d:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1c74:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1c7a:	89 d2                	mov    %edx,%edx
    1c7c:	48 01 d0             	add    %rdx,%rax
    1c7f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1c85:	83 c2 08             	add    $0x8,%edx
    1c88:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1c8e:	eb 12                	jmp    1ca2 <printf+0x319>
    1c90:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1c97:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1c9b:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1ca2:	48 8b 00             	mov    (%rax),%rax
    1ca5:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    1cac:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1cb3:	00 
    1cb4:	75 41                	jne    1cf7 <printf+0x36e>
        s = "(null)";
    1cb6:	48 b8 88 21 00 00 00 	movabs $0x2188,%rax
    1cbd:	00 00 00 
    1cc0:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1cc7:	eb 2e                	jmp    1cf7 <printf+0x36e>
        putc(fd, *(s++));
    1cc9:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1cd0:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1cd4:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1cdb:	0f b6 00             	movzbl (%rax),%eax
    1cde:	0f be d0             	movsbl %al,%edx
    1ce1:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1ce7:	89 d6                	mov    %edx,%esi
    1ce9:	89 c7                	mov    %eax,%edi
    1ceb:	48 b8 a3 17 00 00 00 	movabs $0x17a3,%rax
    1cf2:	00 00 00 
    1cf5:	ff d0                	call   *%rax
      while (*s)
    1cf7:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1cfe:	0f b6 00             	movzbl (%rax),%eax
    1d01:	84 c0                	test   %al,%al
    1d03:	75 c4                	jne    1cc9 <printf+0x340>
      break;
    1d05:	eb 54                	jmp    1d5b <printf+0x3d2>
    case '%':
      putc(fd, '%');
    1d07:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1d0d:	be 25 00 00 00       	mov    $0x25,%esi
    1d12:	89 c7                	mov    %eax,%edi
    1d14:	48 b8 a3 17 00 00 00 	movabs $0x17a3,%rax
    1d1b:	00 00 00 
    1d1e:	ff d0                	call   *%rax
      break;
    1d20:	eb 39                	jmp    1d5b <printf+0x3d2>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1d22:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1d28:	be 25 00 00 00       	mov    $0x25,%esi
    1d2d:	89 c7                	mov    %eax,%edi
    1d2f:	48 b8 a3 17 00 00 00 	movabs $0x17a3,%rax
    1d36:	00 00 00 
    1d39:	ff d0                	call   *%rax
      putc(fd, c);
    1d3b:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1d41:	0f be d0             	movsbl %al,%edx
    1d44:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1d4a:	89 d6                	mov    %edx,%esi
    1d4c:	89 c7                	mov    %eax,%edi
    1d4e:	48 b8 a3 17 00 00 00 	movabs $0x17a3,%rax
    1d55:	00 00 00 
    1d58:	ff d0                	call   *%rax
      break;
    1d5a:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1d5b:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1d62:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1d68:	48 63 d0             	movslq %eax,%rdx
    1d6b:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1d72:	48 01 d0             	add    %rdx,%rax
    1d75:	0f b6 00             	movzbl (%rax),%eax
    1d78:	0f be c0             	movsbl %al,%eax
    1d7b:	25 ff 00 00 00       	and    $0xff,%eax
    1d80:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1d86:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1d8d:	0f 85 8e fc ff ff    	jne    1a21 <printf+0x98>
    }
  }
}
    1d93:	eb 01                	jmp    1d96 <printf+0x40d>
      break;
    1d95:	90                   	nop
}
    1d96:	90                   	nop
    1d97:	c9                   	leave
    1d98:	c3                   	ret

0000000000001d99 <free>:
    1d99:	55                   	push   %rbp
    1d9a:	48 89 e5             	mov    %rsp,%rbp
    1d9d:	48 83 ec 18          	sub    $0x18,%rsp
    1da1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1da5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1da9:	48 83 e8 10          	sub    $0x10,%rax
    1dad:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1db1:	48 b8 70 22 00 00 00 	movabs $0x2270,%rax
    1db8:	00 00 00 
    1dbb:	48 8b 00             	mov    (%rax),%rax
    1dbe:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1dc2:	eb 2f                	jmp    1df3 <free+0x5a>
    1dc4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1dc8:	48 8b 00             	mov    (%rax),%rax
    1dcb:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1dcf:	72 17                	jb     1de8 <free+0x4f>
    1dd1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1dd5:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1dd9:	72 2f                	jb     1e0a <free+0x71>
    1ddb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ddf:	48 8b 00             	mov    (%rax),%rax
    1de2:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1de6:	72 22                	jb     1e0a <free+0x71>
    1de8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1dec:	48 8b 00             	mov    (%rax),%rax
    1def:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1df3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1df7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1dfb:	73 c7                	jae    1dc4 <free+0x2b>
    1dfd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e01:	48 8b 00             	mov    (%rax),%rax
    1e04:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1e08:	73 ba                	jae    1dc4 <free+0x2b>
    1e0a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e0e:	8b 40 08             	mov    0x8(%rax),%eax
    1e11:	89 c0                	mov    %eax,%eax
    1e13:	48 c1 e0 04          	shl    $0x4,%rax
    1e17:	48 89 c2             	mov    %rax,%rdx
    1e1a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e1e:	48 01 c2             	add    %rax,%rdx
    1e21:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e25:	48 8b 00             	mov    (%rax),%rax
    1e28:	48 39 c2             	cmp    %rax,%rdx
    1e2b:	75 2d                	jne    1e5a <free+0xc1>
    1e2d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e31:	8b 50 08             	mov    0x8(%rax),%edx
    1e34:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e38:	48 8b 00             	mov    (%rax),%rax
    1e3b:	8b 40 08             	mov    0x8(%rax),%eax
    1e3e:	01 c2                	add    %eax,%edx
    1e40:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e44:	89 50 08             	mov    %edx,0x8(%rax)
    1e47:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e4b:	48 8b 00             	mov    (%rax),%rax
    1e4e:	48 8b 10             	mov    (%rax),%rdx
    1e51:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e55:	48 89 10             	mov    %rdx,(%rax)
    1e58:	eb 0e                	jmp    1e68 <free+0xcf>
    1e5a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e5e:	48 8b 10             	mov    (%rax),%rdx
    1e61:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e65:	48 89 10             	mov    %rdx,(%rax)
    1e68:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e6c:	8b 40 08             	mov    0x8(%rax),%eax
    1e6f:	89 c0                	mov    %eax,%eax
    1e71:	48 c1 e0 04          	shl    $0x4,%rax
    1e75:	48 89 c2             	mov    %rax,%rdx
    1e78:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e7c:	48 01 d0             	add    %rdx,%rax
    1e7f:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1e83:	75 27                	jne    1eac <free+0x113>
    1e85:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e89:	8b 50 08             	mov    0x8(%rax),%edx
    1e8c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e90:	8b 40 08             	mov    0x8(%rax),%eax
    1e93:	01 c2                	add    %eax,%edx
    1e95:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e99:	89 50 08             	mov    %edx,0x8(%rax)
    1e9c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ea0:	48 8b 10             	mov    (%rax),%rdx
    1ea3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ea7:	48 89 10             	mov    %rdx,(%rax)
    1eaa:	eb 0b                	jmp    1eb7 <free+0x11e>
    1eac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1eb0:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1eb4:	48 89 10             	mov    %rdx,(%rax)
    1eb7:	48 ba 70 22 00 00 00 	movabs $0x2270,%rdx
    1ebe:	00 00 00 
    1ec1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ec5:	48 89 02             	mov    %rax,(%rdx)
    1ec8:	90                   	nop
    1ec9:	c9                   	leave
    1eca:	c3                   	ret

0000000000001ecb <morecore>:
    1ecb:	55                   	push   %rbp
    1ecc:	48 89 e5             	mov    %rsp,%rbp
    1ecf:	48 83 ec 20          	sub    $0x20,%rsp
    1ed3:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1ed6:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1edd:	77 07                	ja     1ee6 <morecore+0x1b>
    1edf:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
    1ee6:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1ee9:	48 c1 e0 04          	shl    $0x4,%rax
    1eed:	48 89 c7             	mov    %rax,%rdi
    1ef0:	48 b8 62 17 00 00 00 	movabs $0x1762,%rax
    1ef7:	00 00 00 
    1efa:	ff d0                	call   *%rax
    1efc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1f00:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1f05:	75 07                	jne    1f0e <morecore+0x43>
    1f07:	b8 00 00 00 00       	mov    $0x0,%eax
    1f0c:	eb 36                	jmp    1f44 <morecore+0x79>
    1f0e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f12:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1f16:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f1a:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1f1d:	89 50 08             	mov    %edx,0x8(%rax)
    1f20:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f24:	48 83 c0 10          	add    $0x10,%rax
    1f28:	48 89 c7             	mov    %rax,%rdi
    1f2b:	48 b8 99 1d 00 00 00 	movabs $0x1d99,%rax
    1f32:	00 00 00 
    1f35:	ff d0                	call   *%rax
    1f37:	48 b8 70 22 00 00 00 	movabs $0x2270,%rax
    1f3e:	00 00 00 
    1f41:	48 8b 00             	mov    (%rax),%rax
    1f44:	c9                   	leave
    1f45:	c3                   	ret

0000000000001f46 <malloc>:
    1f46:	55                   	push   %rbp
    1f47:	48 89 e5             	mov    %rsp,%rbp
    1f4a:	48 83 ec 30          	sub    $0x30,%rsp
    1f4e:	89 7d dc             	mov    %edi,-0x24(%rbp)
    1f51:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1f54:	48 83 c0 0f          	add    $0xf,%rax
    1f58:	48 c1 e8 04          	shr    $0x4,%rax
    1f5c:	83 c0 01             	add    $0x1,%eax
    1f5f:	89 45 ec             	mov    %eax,-0x14(%rbp)
    1f62:	48 b8 70 22 00 00 00 	movabs $0x2270,%rax
    1f69:	00 00 00 
    1f6c:	48 8b 00             	mov    (%rax),%rax
    1f6f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1f73:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1f78:	75 4a                	jne    1fc4 <malloc+0x7e>
    1f7a:	48 b8 60 22 00 00 00 	movabs $0x2260,%rax
    1f81:	00 00 00 
    1f84:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1f88:	48 ba 70 22 00 00 00 	movabs $0x2270,%rdx
    1f8f:	00 00 00 
    1f92:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f96:	48 89 02             	mov    %rax,(%rdx)
    1f99:	48 b8 70 22 00 00 00 	movabs $0x2270,%rax
    1fa0:	00 00 00 
    1fa3:	48 8b 00             	mov    (%rax),%rax
    1fa6:	48 ba 60 22 00 00 00 	movabs $0x2260,%rdx
    1fad:	00 00 00 
    1fb0:	48 89 02             	mov    %rax,(%rdx)
    1fb3:	48 b8 60 22 00 00 00 	movabs $0x2260,%rax
    1fba:	00 00 00 
    1fbd:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
    1fc4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1fc8:	48 8b 00             	mov    (%rax),%rax
    1fcb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1fcf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1fd3:	8b 40 08             	mov    0x8(%rax),%eax
    1fd6:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1fd9:	72 65                	jb     2040 <malloc+0xfa>
    1fdb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1fdf:	8b 40 08             	mov    0x8(%rax),%eax
    1fe2:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1fe5:	75 10                	jne    1ff7 <malloc+0xb1>
    1fe7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1feb:	48 8b 10             	mov    (%rax),%rdx
    1fee:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ff2:	48 89 10             	mov    %rdx,(%rax)
    1ff5:	eb 2e                	jmp    2025 <malloc+0xdf>
    1ff7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ffb:	8b 40 08             	mov    0x8(%rax),%eax
    1ffe:	2b 45 ec             	sub    -0x14(%rbp),%eax
    2001:	89 c2                	mov    %eax,%edx
    2003:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2007:	89 50 08             	mov    %edx,0x8(%rax)
    200a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    200e:	8b 40 08             	mov    0x8(%rax),%eax
    2011:	89 c0                	mov    %eax,%eax
    2013:	48 c1 e0 04          	shl    $0x4,%rax
    2017:	48 01 45 f8          	add    %rax,-0x8(%rbp)
    201b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    201f:	8b 55 ec             	mov    -0x14(%rbp),%edx
    2022:	89 50 08             	mov    %edx,0x8(%rax)
    2025:	48 ba 70 22 00 00 00 	movabs $0x2270,%rdx
    202c:	00 00 00 
    202f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2033:	48 89 02             	mov    %rax,(%rdx)
    2036:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    203a:	48 83 c0 10          	add    $0x10,%rax
    203e:	eb 4e                	jmp    208e <malloc+0x148>
    2040:	48 b8 70 22 00 00 00 	movabs $0x2270,%rax
    2047:	00 00 00 
    204a:	48 8b 00             	mov    (%rax),%rax
    204d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    2051:	75 23                	jne    2076 <malloc+0x130>
    2053:	8b 45 ec             	mov    -0x14(%rbp),%eax
    2056:	89 c7                	mov    %eax,%edi
    2058:	48 b8 cb 1e 00 00 00 	movabs $0x1ecb,%rax
    205f:	00 00 00 
    2062:	ff d0                	call   *%rax
    2064:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    2068:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    206d:	75 07                	jne    2076 <malloc+0x130>
    206f:	b8 00 00 00 00       	mov    $0x0,%eax
    2074:	eb 18                	jmp    208e <malloc+0x148>
    2076:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    207a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    207e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2082:	48 8b 00             	mov    (%rax),%rax
    2085:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    2089:	e9 41 ff ff ff       	jmp    1fcf <malloc+0x89>
    208e:	c9                   	leave
    208f:	c3                   	ret
