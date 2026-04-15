
_usertests:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <failexit>:
    1000:	55                   	push   %rbp
    1001:	48 89 e5             	mov    %rsp,%rbp
    1004:	48 83 ec 10          	sub    $0x10,%rsp
    1008:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    100c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1010:	48 b9 96 71 00 00 00 	movabs $0x7196,%rcx
    1017:	00 00 00 
    101a:	48 89 c2             	mov    %rax,%rdx
    101d:	48 89 ce             	mov    %rcx,%rsi
    1020:	bf 01 00 00 00       	mov    $0x1,%edi
    1025:	b8 00 00 00 00       	mov    $0x0,%eax
    102a:	48 b9 78 6a 00 00 00 	movabs $0x6a78,%rcx
    1031:	00 00 00 
    1034:	ff d1                	call   *%rcx
    1036:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    103d:	00 00 00 
    1040:	ff d0                	call   *%rax

0000000000001042 <iputtest>:
    1042:	55                   	push   %rbp
    1043:	48 89 e5             	mov    %rsp,%rbp
    1046:	48 b8 a4 71 00 00 00 	movabs $0x71a4,%rax
    104d:	00 00 00 
    1050:	48 89 c6             	mov    %rax,%rsi
    1053:	bf 01 00 00 00       	mov    $0x1,%edi
    1058:	b8 00 00 00 00       	mov    $0x0,%eax
    105d:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    1064:	00 00 00 
    1067:	ff d2                	call   *%rdx
    1069:	48 b8 af 71 00 00 00 	movabs $0x71af,%rax
    1070:	00 00 00 
    1073:	48 89 c7             	mov    %rax,%rdi
    1076:	48 b8 1d 68 00 00 00 	movabs $0x681d,%rax
    107d:	00 00 00 
    1080:	ff d0                	call   *%rax
    1082:	85 c0                	test   %eax,%eax
    1084:	79 19                	jns    109f <iputtest+0x5d>
    1086:	48 b8 b7 71 00 00 00 	movabs $0x71b7,%rax
    108d:	00 00 00 
    1090:	48 89 c7             	mov    %rax,%rdi
    1093:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    109a:	00 00 00 
    109d:	ff d0                	call   *%rax
    109f:	48 b8 af 71 00 00 00 	movabs $0x71af,%rax
    10a6:	00 00 00 
    10a9:	48 89 c7             	mov    %rax,%rdi
    10ac:	48 b8 2a 68 00 00 00 	movabs $0x682a,%rax
    10b3:	00 00 00 
    10b6:	ff d0                	call   *%rax
    10b8:	85 c0                	test   %eax,%eax
    10ba:	79 19                	jns    10d5 <iputtest+0x93>
    10bc:	48 b8 bd 71 00 00 00 	movabs $0x71bd,%rax
    10c3:	00 00 00 
    10c6:	48 89 c7             	mov    %rax,%rdi
    10c9:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    10d0:	00 00 00 
    10d3:	ff d0                	call   *%rax
    10d5:	48 b8 cb 71 00 00 00 	movabs $0x71cb,%rax
    10dc:	00 00 00 
    10df:	48 89 c7             	mov    %rax,%rdi
    10e2:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    10e9:	00 00 00 
    10ec:	ff d0                	call   *%rax
    10ee:	85 c0                	test   %eax,%eax
    10f0:	79 19                	jns    110b <iputtest+0xc9>
    10f2:	48 b8 d6 71 00 00 00 	movabs $0x71d6,%rax
    10f9:	00 00 00 
    10fc:	48 89 c7             	mov    %rax,%rdi
    10ff:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1106:	00 00 00 
    1109:	ff d0                	call   *%rax
    110b:	48 b8 e8 71 00 00 00 	movabs $0x71e8,%rax
    1112:	00 00 00 
    1115:	48 89 c7             	mov    %rax,%rdi
    1118:	48 b8 2a 68 00 00 00 	movabs $0x682a,%rax
    111f:	00 00 00 
    1122:	ff d0                	call   *%rax
    1124:	85 c0                	test   %eax,%eax
    1126:	79 19                	jns    1141 <iputtest+0xff>
    1128:	48 b8 ea 71 00 00 00 	movabs $0x71ea,%rax
    112f:	00 00 00 
    1132:	48 89 c7             	mov    %rax,%rdi
    1135:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    113c:	00 00 00 
    113f:	ff d0                	call   *%rax
    1141:	48 b8 f2 71 00 00 00 	movabs $0x71f2,%rax
    1148:	00 00 00 
    114b:	48 89 c6             	mov    %rax,%rsi
    114e:	bf 01 00 00 00       	mov    $0x1,%edi
    1153:	b8 00 00 00 00       	mov    $0x0,%eax
    1158:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    115f:	00 00 00 
    1162:	ff d2                	call   *%rdx
    1164:	90                   	nop
    1165:	5d                   	pop    %rbp
    1166:	c3                   	ret

0000000000001167 <exitiputtest>:
    1167:	55                   	push   %rbp
    1168:	48 89 e5             	mov    %rsp,%rbp
    116b:	48 83 ec 10          	sub    $0x10,%rsp
    116f:	48 b8 00 72 00 00 00 	movabs $0x7200,%rax
    1176:	00 00 00 
    1179:	48 89 c6             	mov    %rax,%rsi
    117c:	bf 01 00 00 00       	mov    $0x1,%edi
    1181:	b8 00 00 00 00       	mov    $0x0,%eax
    1186:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    118d:	00 00 00 
    1190:	ff d2                	call   *%rdx
    1192:	48 b8 67 67 00 00 00 	movabs $0x6767,%rax
    1199:	00 00 00 
    119c:	ff d0                	call   *%rax
    119e:	89 45 fc             	mov    %eax,-0x4(%rbp)
    11a1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    11a5:	79 19                	jns    11c0 <exitiputtest+0x59>
    11a7:	48 b8 0f 72 00 00 00 	movabs $0x720f,%rax
    11ae:	00 00 00 
    11b1:	48 89 c7             	mov    %rax,%rdi
    11b4:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    11bb:	00 00 00 
    11be:	ff d0                	call   *%rax
    11c0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    11c4:	0f 85 ae 00 00 00    	jne    1278 <exitiputtest+0x111>
    11ca:	48 b8 af 71 00 00 00 	movabs $0x71af,%rax
    11d1:	00 00 00 
    11d4:	48 89 c7             	mov    %rax,%rdi
    11d7:	48 b8 1d 68 00 00 00 	movabs $0x681d,%rax
    11de:	00 00 00 
    11e1:	ff d0                	call   *%rax
    11e3:	85 c0                	test   %eax,%eax
    11e5:	79 19                	jns    1200 <exitiputtest+0x99>
    11e7:	48 b8 b7 71 00 00 00 	movabs $0x71b7,%rax
    11ee:	00 00 00 
    11f1:	48 89 c7             	mov    %rax,%rdi
    11f4:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    11fb:	00 00 00 
    11fe:	ff d0                	call   *%rax
    1200:	48 b8 af 71 00 00 00 	movabs $0x71af,%rax
    1207:	00 00 00 
    120a:	48 89 c7             	mov    %rax,%rdi
    120d:	48 b8 2a 68 00 00 00 	movabs $0x682a,%rax
    1214:	00 00 00 
    1217:	ff d0                	call   *%rax
    1219:	85 c0                	test   %eax,%eax
    121b:	79 19                	jns    1236 <exitiputtest+0xcf>
    121d:	48 b8 14 72 00 00 00 	movabs $0x7214,%rax
    1224:	00 00 00 
    1227:	48 89 c7             	mov    %rax,%rdi
    122a:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1231:	00 00 00 
    1234:	ff d0                	call   *%rax
    1236:	48 b8 cb 71 00 00 00 	movabs $0x71cb,%rax
    123d:	00 00 00 
    1240:	48 89 c7             	mov    %rax,%rdi
    1243:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    124a:	00 00 00 
    124d:	ff d0                	call   *%rax
    124f:	85 c0                	test   %eax,%eax
    1251:	79 19                	jns    126c <exitiputtest+0x105>
    1253:	48 b8 d6 71 00 00 00 	movabs $0x71d6,%rax
    125a:	00 00 00 
    125d:	48 89 c7             	mov    %rax,%rdi
    1260:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1267:	00 00 00 
    126a:	ff d0                	call   *%rax
    126c:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    1273:	00 00 00 
    1276:	ff d0                	call   *%rax
    1278:	48 b8 81 67 00 00 00 	movabs $0x6781,%rax
    127f:	00 00 00 
    1282:	ff d0                	call   *%rax
    1284:	48 b8 20 72 00 00 00 	movabs $0x7220,%rax
    128b:	00 00 00 
    128e:	48 89 c6             	mov    %rax,%rsi
    1291:	bf 01 00 00 00       	mov    $0x1,%edi
    1296:	b8 00 00 00 00       	mov    $0x0,%eax
    129b:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    12a2:	00 00 00 
    12a5:	ff d2                	call   *%rdx
    12a7:	90                   	nop
    12a8:	c9                   	leave
    12a9:	c3                   	ret

00000000000012aa <openiputtest>:
    12aa:	55                   	push   %rbp
    12ab:	48 89 e5             	mov    %rsp,%rbp
    12ae:	48 83 ec 10          	sub    $0x10,%rsp
    12b2:	48 b8 32 72 00 00 00 	movabs $0x7232,%rax
    12b9:	00 00 00 
    12bc:	48 89 c6             	mov    %rax,%rsi
    12bf:	bf 01 00 00 00       	mov    $0x1,%edi
    12c4:	b8 00 00 00 00       	mov    $0x0,%eax
    12c9:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    12d0:	00 00 00 
    12d3:	ff d2                	call   *%rdx
    12d5:	48 b8 41 72 00 00 00 	movabs $0x7241,%rax
    12dc:	00 00 00 
    12df:	48 89 c7             	mov    %rax,%rdi
    12e2:	48 b8 1d 68 00 00 00 	movabs $0x681d,%rax
    12e9:	00 00 00 
    12ec:	ff d0                	call   *%rax
    12ee:	85 c0                	test   %eax,%eax
    12f0:	79 19                	jns    130b <openiputtest+0x61>
    12f2:	48 b8 47 72 00 00 00 	movabs $0x7247,%rax
    12f9:	00 00 00 
    12fc:	48 89 c7             	mov    %rax,%rdi
    12ff:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1306:	00 00 00 
    1309:	ff d0                	call   *%rax
    130b:	48 b8 67 67 00 00 00 	movabs $0x6767,%rax
    1312:	00 00 00 
    1315:	ff d0                	call   *%rax
    1317:	89 45 fc             	mov    %eax,-0x4(%rbp)
    131a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    131e:	79 19                	jns    1339 <openiputtest+0x8f>
    1320:	48 b8 0f 72 00 00 00 	movabs $0x720f,%rax
    1327:	00 00 00 
    132a:	48 89 c7             	mov    %rax,%rdi
    132d:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1334:	00 00 00 
    1337:	ff d0                	call   *%rax
    1339:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    133d:	75 4c                	jne    138b <openiputtest+0xe1>
    133f:	48 b8 41 72 00 00 00 	movabs $0x7241,%rax
    1346:	00 00 00 
    1349:	be 02 00 00 00       	mov    $0x2,%esi
    134e:	48 89 c7             	mov    %rax,%rdi
    1351:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    1358:	00 00 00 
    135b:	ff d0                	call   *%rax
    135d:	89 45 f8             	mov    %eax,-0x8(%rbp)
    1360:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1364:	78 19                	js     137f <openiputtest+0xd5>
    1366:	48 b8 58 72 00 00 00 	movabs $0x7258,%rax
    136d:	00 00 00 
    1370:	48 89 c7             	mov    %rax,%rdi
    1373:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    137a:	00 00 00 
    137d:	ff d0                	call   *%rax
    137f:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    1386:	00 00 00 
    1389:	ff d0                	call   *%rax
    138b:	bf 01 00 00 00       	mov    $0x1,%edi
    1390:	48 b8 5e 68 00 00 00 	movabs $0x685e,%rax
    1397:	00 00 00 
    139a:	ff d0                	call   *%rax
    139c:	48 b8 41 72 00 00 00 	movabs $0x7241,%rax
    13a3:	00 00 00 
    13a6:	48 89 c7             	mov    %rax,%rdi
    13a9:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    13b0:	00 00 00 
    13b3:	ff d0                	call   *%rax
    13b5:	85 c0                	test   %eax,%eax
    13b7:	74 19                	je     13d2 <openiputtest+0x128>
    13b9:	48 b8 7b 72 00 00 00 	movabs $0x727b,%rax
    13c0:	00 00 00 
    13c3:	48 89 c7             	mov    %rax,%rdi
    13c6:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    13cd:	00 00 00 
    13d0:	ff d0                	call   *%rax
    13d2:	48 b8 81 67 00 00 00 	movabs $0x6781,%rax
    13d9:	00 00 00 
    13dc:	ff d0                	call   *%rax
    13de:	48 b8 82 72 00 00 00 	movabs $0x7282,%rax
    13e5:	00 00 00 
    13e8:	48 89 c6             	mov    %rax,%rsi
    13eb:	bf 01 00 00 00       	mov    $0x1,%edi
    13f0:	b8 00 00 00 00       	mov    $0x0,%eax
    13f5:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    13fc:	00 00 00 
    13ff:	ff d2                	call   *%rdx
    1401:	90                   	nop
    1402:	c9                   	leave
    1403:	c3                   	ret

0000000000001404 <opentest>:
    1404:	55                   	push   %rbp
    1405:	48 89 e5             	mov    %rsp,%rbp
    1408:	48 83 ec 10          	sub    $0x10,%rsp
    140c:	48 b8 94 72 00 00 00 	movabs $0x7294,%rax
    1413:	00 00 00 
    1416:	48 89 c6             	mov    %rax,%rsi
    1419:	bf 01 00 00 00       	mov    $0x1,%edi
    141e:	b8 00 00 00 00       	mov    $0x0,%eax
    1423:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    142a:	00 00 00 
    142d:	ff d2                	call   *%rdx
    142f:	48 b8 80 71 00 00 00 	movabs $0x7180,%rax
    1436:	00 00 00 
    1439:	be 00 00 00 00       	mov    $0x0,%esi
    143e:	48 89 c7             	mov    %rax,%rdi
    1441:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    1448:	00 00 00 
    144b:	ff d0                	call   *%rax
    144d:	89 45 fc             	mov    %eax,-0x4(%rbp)
    1450:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1454:	79 19                	jns    146f <opentest+0x6b>
    1456:	48 b8 9f 72 00 00 00 	movabs $0x729f,%rax
    145d:	00 00 00 
    1460:	48 89 c7             	mov    %rax,%rdi
    1463:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    146a:	00 00 00 
    146d:	ff d0                	call   *%rax
    146f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1472:	89 c7                	mov    %eax,%edi
    1474:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    147b:	00 00 00 
    147e:	ff d0                	call   *%rax
    1480:	48 b8 a9 72 00 00 00 	movabs $0x72a9,%rax
    1487:	00 00 00 
    148a:	be 00 00 00 00       	mov    $0x0,%esi
    148f:	48 89 c7             	mov    %rax,%rdi
    1492:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    1499:	00 00 00 
    149c:	ff d0                	call   *%rax
    149e:	89 45 fc             	mov    %eax,-0x4(%rbp)
    14a1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    14a5:	78 19                	js     14c0 <opentest+0xbc>
    14a7:	48 b8 b6 72 00 00 00 	movabs $0x72b6,%rax
    14ae:	00 00 00 
    14b1:	48 89 c7             	mov    %rax,%rdi
    14b4:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    14bb:	00 00 00 
    14be:	ff d0                	call   *%rax
    14c0:	48 b8 d3 72 00 00 00 	movabs $0x72d3,%rax
    14c7:	00 00 00 
    14ca:	48 89 c6             	mov    %rax,%rsi
    14cd:	bf 01 00 00 00       	mov    $0x1,%edi
    14d2:	b8 00 00 00 00       	mov    $0x0,%eax
    14d7:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    14de:	00 00 00 
    14e1:	ff d2                	call   *%rdx
    14e3:	90                   	nop
    14e4:	c9                   	leave
    14e5:	c3                   	ret

00000000000014e6 <writetest>:
    14e6:	55                   	push   %rbp
    14e7:	48 89 e5             	mov    %rsp,%rbp
    14ea:	48 83 ec 10          	sub    $0x10,%rsp
    14ee:	48 b8 e1 72 00 00 00 	movabs $0x72e1,%rax
    14f5:	00 00 00 
    14f8:	48 89 c6             	mov    %rax,%rsi
    14fb:	bf 01 00 00 00       	mov    $0x1,%edi
    1500:	b8 00 00 00 00       	mov    $0x0,%eax
    1505:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    150c:	00 00 00 
    150f:	ff d2                	call   *%rdx
    1511:	48 b8 f2 72 00 00 00 	movabs $0x72f2,%rax
    1518:	00 00 00 
    151b:	be 02 02 00 00       	mov    $0x202,%esi
    1520:	48 89 c7             	mov    %rax,%rdi
    1523:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    152a:	00 00 00 
    152d:	ff d0                	call   *%rax
    152f:	89 45 f8             	mov    %eax,-0x8(%rbp)
    1532:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1536:	79 19                	jns    1551 <writetest+0x6b>
    1538:	48 b8 f8 72 00 00 00 	movabs $0x72f8,%rax
    153f:	00 00 00 
    1542:	48 89 c7             	mov    %rax,%rdi
    1545:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    154c:	00 00 00 
    154f:	ff d0                	call   *%rax
    1551:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1558:	e9 bc 00 00 00       	jmp    1619 <writetest+0x133>
    155d:	48 b9 0b 73 00 00 00 	movabs $0x730b,%rcx
    1564:	00 00 00 
    1567:	8b 45 f8             	mov    -0x8(%rbp),%eax
    156a:	ba 0a 00 00 00       	mov    $0xa,%edx
    156f:	48 89 ce             	mov    %rcx,%rsi
    1572:	89 c7                	mov    %eax,%edi
    1574:	48 b8 a8 67 00 00 00 	movabs $0x67a8,%rax
    157b:	00 00 00 
    157e:	ff d0                	call   *%rax
    1580:	83 f8 0a             	cmp    $0xa,%eax
    1583:	74 34                	je     15b9 <writetest+0xd3>
    1585:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1588:	48 b9 18 73 00 00 00 	movabs $0x7318,%rcx
    158f:	00 00 00 
    1592:	89 c2                	mov    %eax,%edx
    1594:	48 89 ce             	mov    %rcx,%rsi
    1597:	bf 01 00 00 00       	mov    $0x1,%edi
    159c:	b8 00 00 00 00       	mov    $0x0,%eax
    15a1:	48 b9 78 6a 00 00 00 	movabs $0x6a78,%rcx
    15a8:	00 00 00 
    15ab:	ff d1                	call   *%rcx
    15ad:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    15b4:	00 00 00 
    15b7:	ff d0                	call   *%rax
    15b9:	48 b9 3c 73 00 00 00 	movabs $0x733c,%rcx
    15c0:	00 00 00 
    15c3:	8b 45 f8             	mov    -0x8(%rbp),%eax
    15c6:	ba 0a 00 00 00       	mov    $0xa,%edx
    15cb:	48 89 ce             	mov    %rcx,%rsi
    15ce:	89 c7                	mov    %eax,%edi
    15d0:	48 b8 a8 67 00 00 00 	movabs $0x67a8,%rax
    15d7:	00 00 00 
    15da:	ff d0                	call   *%rax
    15dc:	83 f8 0a             	cmp    $0xa,%eax
    15df:	74 34                	je     1615 <writetest+0x12f>
    15e1:	8b 45 fc             	mov    -0x4(%rbp),%eax
    15e4:	48 b9 48 73 00 00 00 	movabs $0x7348,%rcx
    15eb:	00 00 00 
    15ee:	89 c2                	mov    %eax,%edx
    15f0:	48 89 ce             	mov    %rcx,%rsi
    15f3:	bf 01 00 00 00       	mov    $0x1,%edi
    15f8:	b8 00 00 00 00       	mov    $0x0,%eax
    15fd:	48 b9 78 6a 00 00 00 	movabs $0x6a78,%rcx
    1604:	00 00 00 
    1607:	ff d1                	call   *%rcx
    1609:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    1610:	00 00 00 
    1613:	ff d0                	call   *%rax
    1615:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1619:	83 7d fc 63          	cmpl   $0x63,-0x4(%rbp)
    161d:	0f 8e 3a ff ff ff    	jle    155d <writetest+0x77>
    1623:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1626:	89 c7                	mov    %eax,%edi
    1628:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    162f:	00 00 00 
    1632:	ff d0                	call   *%rax
    1634:	48 b8 f2 72 00 00 00 	movabs $0x72f2,%rax
    163b:	00 00 00 
    163e:	be 00 00 00 00       	mov    $0x0,%esi
    1643:	48 89 c7             	mov    %rax,%rdi
    1646:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    164d:	00 00 00 
    1650:	ff d0                	call   *%rax
    1652:	89 45 f8             	mov    %eax,-0x8(%rbp)
    1655:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1659:	79 19                	jns    1674 <writetest+0x18e>
    165b:	48 b8 6c 73 00 00 00 	movabs $0x736c,%rax
    1662:	00 00 00 
    1665:	48 89 c7             	mov    %rax,%rdi
    1668:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    166f:	00 00 00 
    1672:	ff d0                	call   *%rax
    1674:	48 b9 20 89 00 00 00 	movabs $0x8920,%rcx
    167b:	00 00 00 
    167e:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1681:	ba d0 07 00 00       	mov    $0x7d0,%edx
    1686:	48 89 ce             	mov    %rcx,%rsi
    1689:	89 c7                	mov    %eax,%edi
    168b:	48 b8 9b 67 00 00 00 	movabs $0x679b,%rax
    1692:	00 00 00 
    1695:	ff d0                	call   *%rax
    1697:	89 45 fc             	mov    %eax,-0x4(%rbp)
    169a:	81 7d fc d0 07 00 00 	cmpl   $0x7d0,-0x4(%rbp)
    16a1:	74 19                	je     16bc <writetest+0x1d6>
    16a3:	48 b8 7e 73 00 00 00 	movabs $0x737e,%rax
    16aa:	00 00 00 
    16ad:	48 89 c7             	mov    %rax,%rdi
    16b0:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    16b7:	00 00 00 
    16ba:	ff d0                	call   *%rax
    16bc:	8b 45 f8             	mov    -0x8(%rbp),%eax
    16bf:	89 c7                	mov    %eax,%edi
    16c1:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    16c8:	00 00 00 
    16cb:	ff d0                	call   *%rax
    16cd:	48 b8 f2 72 00 00 00 	movabs $0x72f2,%rax
    16d4:	00 00 00 
    16d7:	48 89 c7             	mov    %rax,%rdi
    16da:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    16e1:	00 00 00 
    16e4:	ff d0                	call   *%rax
    16e6:	85 c0                	test   %eax,%eax
    16e8:	79 25                	jns    170f <writetest+0x229>
    16ea:	48 b8 83 73 00 00 00 	movabs $0x7383,%rax
    16f1:	00 00 00 
    16f4:	48 89 c7             	mov    %rax,%rdi
    16f7:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    16fe:	00 00 00 
    1701:	ff d0                	call   *%rax
    1703:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    170a:	00 00 00 
    170d:	ff d0                	call   *%rax
    170f:	48 b8 90 73 00 00 00 	movabs $0x7390,%rax
    1716:	00 00 00 
    1719:	48 89 c6             	mov    %rax,%rsi
    171c:	bf 01 00 00 00       	mov    $0x1,%edi
    1721:	b8 00 00 00 00       	mov    $0x0,%eax
    1726:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    172d:	00 00 00 
    1730:	ff d2                	call   *%rdx
    1732:	90                   	nop
    1733:	c9                   	leave
    1734:	c3                   	ret

0000000000001735 <writetest1>:
    1735:	55                   	push   %rbp
    1736:	48 89 e5             	mov    %rsp,%rbp
    1739:	48 83 ec 10          	sub    $0x10,%rsp
    173d:	48 b8 a4 73 00 00 00 	movabs $0x73a4,%rax
    1744:	00 00 00 
    1747:	48 89 c6             	mov    %rax,%rsi
    174a:	bf 01 00 00 00       	mov    $0x1,%edi
    174f:	b8 00 00 00 00       	mov    $0x0,%eax
    1754:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    175b:	00 00 00 
    175e:	ff d2                	call   *%rdx
    1760:	48 b8 b4 73 00 00 00 	movabs $0x73b4,%rax
    1767:	00 00 00 
    176a:	be 02 02 00 00       	mov    $0x202,%esi
    176f:	48 89 c7             	mov    %rax,%rdi
    1772:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    1779:	00 00 00 
    177c:	ff d0                	call   *%rax
    177e:	89 45 f4             	mov    %eax,-0xc(%rbp)
    1781:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1785:	79 19                	jns    17a0 <writetest1+0x6b>
    1787:	48 b8 b8 73 00 00 00 	movabs $0x73b8,%rax
    178e:	00 00 00 
    1791:	48 89 c7             	mov    %rax,%rdi
    1794:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    179b:	00 00 00 
    179e:	ff d0                	call   *%rax
    17a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    17a7:	eb 56                	jmp    17ff <writetest1+0xca>
    17a9:	48 ba 20 89 00 00 00 	movabs $0x8920,%rdx
    17b0:	00 00 00 
    17b3:	8b 45 fc             	mov    -0x4(%rbp),%eax
    17b6:	89 02                	mov    %eax,(%rdx)
    17b8:	48 b9 20 89 00 00 00 	movabs $0x8920,%rcx
    17bf:	00 00 00 
    17c2:	8b 45 f4             	mov    -0xc(%rbp),%eax
    17c5:	ba 00 02 00 00       	mov    $0x200,%edx
    17ca:	48 89 ce             	mov    %rcx,%rsi
    17cd:	89 c7                	mov    %eax,%edi
    17cf:	48 b8 a8 67 00 00 00 	movabs $0x67a8,%rax
    17d6:	00 00 00 
    17d9:	ff d0                	call   *%rax
    17db:	3d 00 02 00 00       	cmp    $0x200,%eax
    17e0:	74 19                	je     17fb <writetest1+0xc6>
    17e2:	48 b8 c9 73 00 00 00 	movabs $0x73c9,%rax
    17e9:	00 00 00 
    17ec:	48 89 c7             	mov    %rax,%rdi
    17ef:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    17f6:	00 00 00 
    17f9:	ff d0                	call   *%rax
    17fb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    17ff:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1802:	3d 8b 00 00 00       	cmp    $0x8b,%eax
    1807:	76 a0                	jbe    17a9 <writetest1+0x74>
    1809:	8b 45 f4             	mov    -0xc(%rbp),%eax
    180c:	89 c7                	mov    %eax,%edi
    180e:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    1815:	00 00 00 
    1818:	ff d0                	call   *%rax
    181a:	48 b8 b4 73 00 00 00 	movabs $0x73b4,%rax
    1821:	00 00 00 
    1824:	be 00 00 00 00       	mov    $0x0,%esi
    1829:	48 89 c7             	mov    %rax,%rdi
    182c:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    1833:	00 00 00 
    1836:	ff d0                	call   *%rax
    1838:	89 45 f4             	mov    %eax,-0xc(%rbp)
    183b:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    183f:	79 19                	jns    185a <writetest1+0x125>
    1841:	48 b8 df 73 00 00 00 	movabs $0x73df,%rax
    1848:	00 00 00 
    184b:	48 89 c7             	mov    %rax,%rdi
    184e:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1855:	00 00 00 
    1858:	ff d0                	call   *%rax
    185a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
    1861:	48 b9 20 89 00 00 00 	movabs $0x8920,%rcx
    1868:	00 00 00 
    186b:	8b 45 f4             	mov    -0xc(%rbp),%eax
    186e:	ba 00 02 00 00       	mov    $0x200,%edx
    1873:	48 89 ce             	mov    %rcx,%rsi
    1876:	89 c7                	mov    %eax,%edi
    1878:	48 b8 9b 67 00 00 00 	movabs $0x679b,%rax
    187f:	00 00 00 
    1882:	ff d0                	call   *%rax
    1884:	89 45 fc             	mov    %eax,-0x4(%rbp)
    1887:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    188b:	75 41                	jne    18ce <writetest1+0x199>
    188d:	81 7d f8 8b 00 00 00 	cmpl   $0x8b,-0x8(%rbp)
    1894:	0f 85 cb 00 00 00    	jne    1965 <writetest1+0x230>
    189a:	8b 45 f8             	mov    -0x8(%rbp),%eax
    189d:	48 b9 f0 73 00 00 00 	movabs $0x73f0,%rcx
    18a4:	00 00 00 
    18a7:	89 c2                	mov    %eax,%edx
    18a9:	48 89 ce             	mov    %rcx,%rsi
    18ac:	bf 01 00 00 00       	mov    $0x1,%edi
    18b1:	b8 00 00 00 00       	mov    $0x0,%eax
    18b6:	48 b9 78 6a 00 00 00 	movabs $0x6a78,%rcx
    18bd:	00 00 00 
    18c0:	ff d1                	call   *%rcx
    18c2:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    18c9:	00 00 00 
    18cc:	ff d0                	call   *%rax
    18ce:	81 7d fc 00 02 00 00 	cmpl   $0x200,-0x4(%rbp)
    18d5:	74 34                	je     190b <writetest1+0x1d6>
    18d7:	8b 45 fc             	mov    -0x4(%rbp),%eax
    18da:	48 b9 15 74 00 00 00 	movabs $0x7415,%rcx
    18e1:	00 00 00 
    18e4:	89 c2                	mov    %eax,%edx
    18e6:	48 89 ce             	mov    %rcx,%rsi
    18e9:	bf 01 00 00 00       	mov    $0x1,%edi
    18ee:	b8 00 00 00 00       	mov    $0x0,%eax
    18f3:	48 b9 78 6a 00 00 00 	movabs $0x6a78,%rcx
    18fa:	00 00 00 
    18fd:	ff d1                	call   *%rcx
    18ff:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    1906:	00 00 00 
    1909:	ff d0                	call   *%rax
    190b:	48 b8 20 89 00 00 00 	movabs $0x8920,%rax
    1912:	00 00 00 
    1915:	8b 00                	mov    (%rax),%eax
    1917:	39 45 f8             	cmp    %eax,-0x8(%rbp)
    191a:	74 40                	je     195c <writetest1+0x227>
    191c:	48 b8 20 89 00 00 00 	movabs $0x8920,%rax
    1923:	00 00 00 
    1926:	8b 10                	mov    (%rax),%edx
    1928:	8b 45 f8             	mov    -0x8(%rbp),%eax
    192b:	48 be 28 74 00 00 00 	movabs $0x7428,%rsi
    1932:	00 00 00 
    1935:	89 d1                	mov    %edx,%ecx
    1937:	89 c2                	mov    %eax,%edx
    1939:	bf 01 00 00 00       	mov    $0x1,%edi
    193e:	b8 00 00 00 00       	mov    $0x0,%eax
    1943:	49 b8 78 6a 00 00 00 	movabs $0x6a78,%r8
    194a:	00 00 00 
    194d:	41 ff d0             	call   *%r8
    1950:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    1957:	00 00 00 
    195a:	ff d0                	call   *%rax
    195c:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    1960:	e9 fc fe ff ff       	jmp    1861 <writetest1+0x12c>
    1965:	90                   	nop
    1966:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1969:	89 c7                	mov    %eax,%edi
    196b:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    1972:	00 00 00 
    1975:	ff d0                	call   *%rax
    1977:	48 b8 b4 73 00 00 00 	movabs $0x73b4,%rax
    197e:	00 00 00 
    1981:	48 89 c7             	mov    %rax,%rdi
    1984:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    198b:	00 00 00 
    198e:	ff d0                	call   *%rax
    1990:	85 c0                	test   %eax,%eax
    1992:	79 25                	jns    19b9 <writetest1+0x284>
    1994:	48 b8 50 74 00 00 00 	movabs $0x7450,%rax
    199b:	00 00 00 
    199e:	48 89 c7             	mov    %rax,%rdi
    19a1:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    19a8:	00 00 00 
    19ab:	ff d0                	call   *%rax
    19ad:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    19b4:	00 00 00 
    19b7:	ff d0                	call   *%rax
    19b9:	48 b8 5b 74 00 00 00 	movabs $0x745b,%rax
    19c0:	00 00 00 
    19c3:	48 89 c6             	mov    %rax,%rsi
    19c6:	bf 01 00 00 00       	mov    $0x1,%edi
    19cb:	b8 00 00 00 00       	mov    $0x0,%eax
    19d0:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    19d7:	00 00 00 
    19da:	ff d2                	call   *%rdx
    19dc:	90                   	nop
    19dd:	c9                   	leave
    19de:	c3                   	ret

00000000000019df <createtest>:
    19df:	55                   	push   %rbp
    19e0:	48 89 e5             	mov    %rsp,%rbp
    19e3:	48 83 ec 10          	sub    $0x10,%rsp
    19e7:	48 b8 70 74 00 00 00 	movabs $0x7470,%rax
    19ee:	00 00 00 
    19f1:	48 89 c6             	mov    %rax,%rsi
    19f4:	bf 01 00 00 00       	mov    $0x1,%edi
    19f9:	b8 00 00 00 00       	mov    $0x0,%eax
    19fe:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    1a05:	00 00 00 
    1a08:	ff d2                	call   *%rdx
    1a0a:	48 b8 20 a9 00 00 00 	movabs $0xa920,%rax
    1a11:	00 00 00 
    1a14:	c6 00 61             	movb   $0x61,(%rax)
    1a17:	48 b8 20 a9 00 00 00 	movabs $0xa920,%rax
    1a1e:	00 00 00 
    1a21:	c6 40 02 00          	movb   $0x0,0x2(%rax)
    1a25:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1a2c:	eb 4b                	jmp    1a79 <createtest+0x9a>
    1a2e:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1a31:	83 c0 30             	add    $0x30,%eax
    1a34:	89 c2                	mov    %eax,%edx
    1a36:	48 b8 20 a9 00 00 00 	movabs $0xa920,%rax
    1a3d:	00 00 00 
    1a40:	88 50 01             	mov    %dl,0x1(%rax)
    1a43:	48 b8 20 a9 00 00 00 	movabs $0xa920,%rax
    1a4a:	00 00 00 
    1a4d:	be 02 02 00 00       	mov    $0x202,%esi
    1a52:	48 89 c7             	mov    %rax,%rdi
    1a55:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    1a5c:	00 00 00 
    1a5f:	ff d0                	call   *%rax
    1a61:	89 45 f8             	mov    %eax,-0x8(%rbp)
    1a64:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1a67:	89 c7                	mov    %eax,%edi
    1a69:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    1a70:	00 00 00 
    1a73:	ff d0                	call   *%rax
    1a75:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1a79:	83 7d fc 33          	cmpl   $0x33,-0x4(%rbp)
    1a7d:	7e af                	jle    1a2e <createtest+0x4f>
    1a7f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1a86:	eb 32                	jmp    1aba <createtest+0xdb>
    1a88:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1a8b:	83 c0 30             	add    $0x30,%eax
    1a8e:	89 c2                	mov    %eax,%edx
    1a90:	48 b8 20 a9 00 00 00 	movabs $0xa920,%rax
    1a97:	00 00 00 
    1a9a:	88 50 01             	mov    %dl,0x1(%rax)
    1a9d:	48 b8 20 a9 00 00 00 	movabs $0xa920,%rax
    1aa4:	00 00 00 
    1aa7:	48 89 c7             	mov    %rax,%rdi
    1aaa:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    1ab1:	00 00 00 
    1ab4:	ff d0                	call   *%rax
    1ab6:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1aba:	83 7d fc 33          	cmpl   $0x33,-0x4(%rbp)
    1abe:	7e c8                	jle    1a88 <createtest+0xa9>
    1ac0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1ac7:	eb 59                	jmp    1b22 <createtest+0x143>
    1ac9:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1acc:	83 c0 30             	add    $0x30,%eax
    1acf:	89 c2                	mov    %eax,%edx
    1ad1:	48 b8 20 a9 00 00 00 	movabs $0xa920,%rax
    1ad8:	00 00 00 
    1adb:	88 50 01             	mov    %dl,0x1(%rax)
    1ade:	48 b8 20 a9 00 00 00 	movabs $0xa920,%rax
    1ae5:	00 00 00 
    1ae8:	be 02 00 00 00       	mov    $0x2,%esi
    1aed:	48 89 c7             	mov    %rax,%rdi
    1af0:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    1af7:	00 00 00 
    1afa:	ff d0                	call   *%rax
    1afc:	89 45 f8             	mov    %eax,-0x8(%rbp)
    1aff:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1b03:	78 19                	js     1b1e <createtest+0x13f>
    1b05:	48 b8 97 74 00 00 00 	movabs $0x7497,%rax
    1b0c:	00 00 00 
    1b0f:	48 89 c7             	mov    %rax,%rdi
    1b12:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1b19:	00 00 00 
    1b1c:	ff d0                	call   *%rax
    1b1e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1b22:	83 7d fc 33          	cmpl   $0x33,-0x4(%rbp)
    1b26:	7e a1                	jle    1ac9 <createtest+0xea>
    1b28:	48 b8 b0 74 00 00 00 	movabs $0x74b0,%rax
    1b2f:	00 00 00 
    1b32:	48 89 c6             	mov    %rax,%rsi
    1b35:	bf 01 00 00 00       	mov    $0x1,%edi
    1b3a:	b8 00 00 00 00       	mov    $0x0,%eax
    1b3f:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    1b46:	00 00 00 
    1b49:	ff d2                	call   *%rdx
    1b4b:	90                   	nop
    1b4c:	c9                   	leave
    1b4d:	c3                   	ret

0000000000001b4e <dirtest>:
    1b4e:	55                   	push   %rbp
    1b4f:	48 89 e5             	mov    %rsp,%rbp
    1b52:	48 b8 d6 74 00 00 00 	movabs $0x74d6,%rax
    1b59:	00 00 00 
    1b5c:	48 89 c6             	mov    %rax,%rsi
    1b5f:	bf 01 00 00 00       	mov    $0x1,%edi
    1b64:	b8 00 00 00 00       	mov    $0x0,%eax
    1b69:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    1b70:	00 00 00 
    1b73:	ff d2                	call   *%rdx
    1b75:	48 b8 e2 74 00 00 00 	movabs $0x74e2,%rax
    1b7c:	00 00 00 
    1b7f:	48 89 c7             	mov    %rax,%rdi
    1b82:	48 b8 1d 68 00 00 00 	movabs $0x681d,%rax
    1b89:	00 00 00 
    1b8c:	ff d0                	call   *%rax
    1b8e:	85 c0                	test   %eax,%eax
    1b90:	79 19                	jns    1bab <dirtest+0x5d>
    1b92:	48 b8 b7 71 00 00 00 	movabs $0x71b7,%rax
    1b99:	00 00 00 
    1b9c:	48 89 c7             	mov    %rax,%rdi
    1b9f:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1ba6:	00 00 00 
    1ba9:	ff d0                	call   *%rax
    1bab:	48 b8 e2 74 00 00 00 	movabs $0x74e2,%rax
    1bb2:	00 00 00 
    1bb5:	48 89 c7             	mov    %rax,%rdi
    1bb8:	48 b8 2a 68 00 00 00 	movabs $0x682a,%rax
    1bbf:	00 00 00 
    1bc2:	ff d0                	call   *%rax
    1bc4:	85 c0                	test   %eax,%eax
    1bc6:	79 19                	jns    1be1 <dirtest+0x93>
    1bc8:	48 b8 e7 74 00 00 00 	movabs $0x74e7,%rax
    1bcf:	00 00 00 
    1bd2:	48 89 c7             	mov    %rax,%rdi
    1bd5:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1bdc:	00 00 00 
    1bdf:	ff d0                	call   *%rax
    1be1:	48 b8 f2 74 00 00 00 	movabs $0x74f2,%rax
    1be8:	00 00 00 
    1beb:	48 89 c7             	mov    %rax,%rdi
    1bee:	48 b8 2a 68 00 00 00 	movabs $0x682a,%rax
    1bf5:	00 00 00 
    1bf8:	ff d0                	call   *%rax
    1bfa:	85 c0                	test   %eax,%eax
    1bfc:	79 19                	jns    1c17 <dirtest+0xc9>
    1bfe:	48 b8 f5 74 00 00 00 	movabs $0x74f5,%rax
    1c05:	00 00 00 
    1c08:	48 89 c7             	mov    %rax,%rdi
    1c0b:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1c12:	00 00 00 
    1c15:	ff d0                	call   *%rax
    1c17:	48 b8 e2 74 00 00 00 	movabs $0x74e2,%rax
    1c1e:	00 00 00 
    1c21:	48 89 c7             	mov    %rax,%rdi
    1c24:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    1c2b:	00 00 00 
    1c2e:	ff d0                	call   *%rax
    1c30:	85 c0                	test   %eax,%eax
    1c32:	79 19                	jns    1c4d <dirtest+0xff>
    1c34:	48 b8 fe 74 00 00 00 	movabs $0x74fe,%rax
    1c3b:	00 00 00 
    1c3e:	48 89 c7             	mov    %rax,%rdi
    1c41:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1c48:	00 00 00 
    1c4b:	ff d0                	call   *%rax
    1c4d:	48 b8 0a 75 00 00 00 	movabs $0x750a,%rax
    1c54:	00 00 00 
    1c57:	48 89 c6             	mov    %rax,%rsi
    1c5a:	bf 01 00 00 00       	mov    $0x1,%edi
    1c5f:	b8 00 00 00 00       	mov    $0x0,%eax
    1c64:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    1c6b:	00 00 00 
    1c6e:	ff d2                	call   *%rdx
    1c70:	90                   	nop
    1c71:	5d                   	pop    %rbp
    1c72:	c3                   	ret

0000000000001c73 <exectest>:
    1c73:	55                   	push   %rbp
    1c74:	48 89 e5             	mov    %rsp,%rbp
    1c77:	48 b8 19 75 00 00 00 	movabs $0x7519,%rax
    1c7e:	00 00 00 
    1c81:	48 89 c6             	mov    %rax,%rsi
    1c84:	bf 01 00 00 00       	mov    $0x1,%edi
    1c89:	b8 00 00 00 00       	mov    $0x0,%eax
    1c8e:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    1c95:	00 00 00 
    1c98:	ff d2                	call   *%rdx
    1c9a:	48 ba c0 88 00 00 00 	movabs $0x88c0,%rdx
    1ca1:	00 00 00 
    1ca4:	48 b8 80 71 00 00 00 	movabs $0x7180,%rax
    1cab:	00 00 00 
    1cae:	48 89 d6             	mov    %rdx,%rsi
    1cb1:	48 89 c7             	mov    %rax,%rdi
    1cb4:	48 b8 cf 67 00 00 00 	movabs $0x67cf,%rax
    1cbb:	00 00 00 
    1cbe:	ff d0                	call   *%rax
    1cc0:	85 c0                	test   %eax,%eax
    1cc2:	79 19                	jns    1cdd <exectest+0x6a>
    1cc4:	48 b8 24 75 00 00 00 	movabs $0x7524,%rax
    1ccb:	00 00 00 
    1cce:	48 89 c7             	mov    %rax,%rdi
    1cd1:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1cd8:	00 00 00 
    1cdb:	ff d0                	call   *%rax
    1cdd:	48 b8 2e 75 00 00 00 	movabs $0x752e,%rax
    1ce4:	00 00 00 
    1ce7:	48 89 c6             	mov    %rax,%rsi
    1cea:	bf 01 00 00 00       	mov    $0x1,%edi
    1cef:	b8 00 00 00 00       	mov    $0x0,%eax
    1cf4:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    1cfb:	00 00 00 
    1cfe:	ff d2                	call   *%rdx
    1d00:	90                   	nop
    1d01:	5d                   	pop    %rbp
    1d02:	c3                   	ret

0000000000001d03 <nullptrtest>:
    1d03:	55                   	push   %rbp
    1d04:	48 89 e5             	mov    %rsp,%rbp
    1d07:	48 83 ec 10          	sub    $0x10,%rsp
    1d0b:	48 b8 3c 75 00 00 00 	movabs $0x753c,%rax
    1d12:	00 00 00 
    1d15:	48 89 c6             	mov    %rax,%rsi
    1d18:	bf 01 00 00 00       	mov    $0x1,%edi
    1d1d:	b8 00 00 00 00       	mov    $0x0,%eax
    1d22:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    1d29:	00 00 00 
    1d2c:	ff d2                	call   *%rdx
    1d2e:	48 b8 4f 75 00 00 00 	movabs $0x754f,%rax
    1d35:	00 00 00 
    1d38:	48 89 c6             	mov    %rax,%rsi
    1d3b:	bf 01 00 00 00       	mov    $0x1,%edi
    1d40:	b8 00 00 00 00       	mov    $0x0,%eax
    1d45:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    1d4c:	00 00 00 
    1d4f:	ff d2                	call   *%rdx
    1d51:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    1d58:	00 00 00 
    1d5b:	ff d0                	call   *%rax
    1d5d:	89 45 fc             	mov    %eax,-0x4(%rbp)
    1d60:	48 b8 67 67 00 00 00 	movabs $0x6767,%rax
    1d67:	00 00 00 
    1d6a:	ff d0                	call   *%rax
    1d6c:	85 c0                	test   %eax,%eax
    1d6e:	75 4c                	jne    1dbc <nullptrtest+0xb9>
    1d70:	b8 00 00 00 00       	mov    $0x0,%eax
    1d75:	48 c7 00 0a 00 00 00 	movq   $0xa,(%rax)
    1d7c:	48 b8 70 75 00 00 00 	movabs $0x7570,%rax
    1d83:	00 00 00 
    1d86:	48 89 c6             	mov    %rax,%rsi
    1d89:	bf 01 00 00 00       	mov    $0x1,%edi
    1d8e:	b8 00 00 00 00       	mov    $0x0,%eax
    1d93:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    1d9a:	00 00 00 
    1d9d:	ff d2                	call   *%rdx
    1d9f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1da2:	89 c7                	mov    %eax,%edi
    1da4:	48 b8 c2 67 00 00 00 	movabs $0x67c2,%rax
    1dab:	00 00 00 
    1dae:	ff d0                	call   *%rax
    1db0:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    1db7:	00 00 00 
    1dba:	ff d0                	call   *%rax
    1dbc:	48 b8 81 67 00 00 00 	movabs $0x6781,%rax
    1dc3:	00 00 00 
    1dc6:	ff d0                	call   *%rax
    1dc8:	48 b8 95 75 00 00 00 	movabs $0x7595,%rax
    1dcf:	00 00 00 
    1dd2:	48 89 c6             	mov    %rax,%rsi
    1dd5:	bf 01 00 00 00       	mov    $0x1,%edi
    1dda:	b8 00 00 00 00       	mov    $0x0,%eax
    1ddf:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    1de6:	00 00 00 
    1de9:	ff d2                	call   *%rdx
    1deb:	90                   	nop
    1dec:	c9                   	leave
    1ded:	c3                   	ret

0000000000001dee <pipe1>:
    1dee:	55                   	push   %rbp
    1def:	48 89 e5             	mov    %rsp,%rbp
    1df2:	48 83 ec 20          	sub    $0x20,%rsp
    1df6:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
    1dfa:	48 89 c7             	mov    %rax,%rdi
    1dfd:	48 b8 8e 67 00 00 00 	movabs $0x678e,%rax
    1e04:	00 00 00 
    1e07:	ff d0                	call   *%rax
    1e09:	85 c0                	test   %eax,%eax
    1e0b:	74 19                	je     1e26 <pipe1+0x38>
    1e0d:	48 b8 ab 75 00 00 00 	movabs $0x75ab,%rax
    1e14:	00 00 00 
    1e17:	48 89 c7             	mov    %rax,%rdi
    1e1a:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1e21:	00 00 00 
    1e24:	ff d0                	call   *%rax
    1e26:	48 b8 67 67 00 00 00 	movabs $0x6767,%rax
    1e2d:	00 00 00 
    1e30:	ff d0                	call   *%rax
    1e32:	89 45 e8             	mov    %eax,-0x18(%rbp)
    1e35:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1e3c:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
    1e40:	0f 85 a6 00 00 00    	jne    1eec <pipe1+0xfe>
    1e46:	8b 45 e0             	mov    -0x20(%rbp),%eax
    1e49:	89 c7                	mov    %eax,%edi
    1e4b:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    1e52:	00 00 00 
    1e55:	ff d0                	call   *%rax
    1e57:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    1e5e:	eb 7a                	jmp    1eda <pipe1+0xec>
    1e60:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
    1e67:	eb 21                	jmp    1e8a <pipe1+0x9c>
    1e69:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1e6c:	8d 50 01             	lea    0x1(%rax),%edx
    1e6f:	89 55 fc             	mov    %edx,-0x4(%rbp)
    1e72:	89 c1                	mov    %eax,%ecx
    1e74:	48 ba 20 89 00 00 00 	movabs $0x8920,%rdx
    1e7b:	00 00 00 
    1e7e:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1e81:	48 98                	cltq
    1e83:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
    1e86:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    1e8a:	81 7d f8 08 04 00 00 	cmpl   $0x408,-0x8(%rbp)
    1e91:	7e d6                	jle    1e69 <pipe1+0x7b>
    1e93:	8b 45 e4             	mov    -0x1c(%rbp),%eax
    1e96:	48 b9 20 89 00 00 00 	movabs $0x8920,%rcx
    1e9d:	00 00 00 
    1ea0:	ba 09 04 00 00       	mov    $0x409,%edx
    1ea5:	48 89 ce             	mov    %rcx,%rsi
    1ea8:	89 c7                	mov    %eax,%edi
    1eaa:	48 b8 a8 67 00 00 00 	movabs $0x67a8,%rax
    1eb1:	00 00 00 
    1eb4:	ff d0                	call   *%rax
    1eb6:	3d 09 04 00 00       	cmp    $0x409,%eax
    1ebb:	74 19                	je     1ed6 <pipe1+0xe8>
    1ebd:	48 b8 b2 75 00 00 00 	movabs $0x75b2,%rax
    1ec4:	00 00 00 
    1ec7:	48 89 c7             	mov    %rax,%rdi
    1eca:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1ed1:	00 00 00 
    1ed4:	ff d0                	call   *%rax
    1ed6:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
    1eda:	83 7d f4 04          	cmpl   $0x4,-0xc(%rbp)
    1ede:	7e 80                	jle    1e60 <pipe1+0x72>
    1ee0:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    1ee7:	00 00 00 
    1eea:	ff d0                	call   *%rax
    1eec:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
    1ef0:	0f 8e 20 01 00 00    	jle    2016 <pipe1+0x228>
    1ef6:	8b 45 e4             	mov    -0x1c(%rbp),%eax
    1ef9:	89 c7                	mov    %eax,%edi
    1efb:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    1f02:	00 00 00 
    1f05:	ff d0                	call   *%rax
    1f07:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    1f0e:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%rbp)
    1f15:	eb 75                	jmp    1f8c <pipe1+0x19e>
    1f17:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
    1f1e:	eb 4a                	jmp    1f6a <pipe1+0x17c>
    1f20:	48 ba 20 89 00 00 00 	movabs $0x8920,%rdx
    1f27:	00 00 00 
    1f2a:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1f2d:	48 98                	cltq
    1f2f:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1f33:	0f be c8             	movsbl %al,%ecx
    1f36:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1f39:	8d 50 01             	lea    0x1(%rax),%edx
    1f3c:	89 55 fc             	mov    %edx,-0x4(%rbp)
    1f3f:	31 c8                	xor    %ecx,%eax
    1f41:	0f b6 c0             	movzbl %al,%eax
    1f44:	85 c0                	test   %eax,%eax
    1f46:	74 1e                	je     1f66 <pipe1+0x178>
    1f48:	48 b8 bf 75 00 00 00 	movabs $0x75bf,%rax
    1f4f:	00 00 00 
    1f52:	48 89 c7             	mov    %rax,%rdi
    1f55:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1f5c:	00 00 00 
    1f5f:	ff d0                	call   *%rax
    1f61:	e9 ec 00 00 00       	jmp    2052 <pipe1+0x264>
    1f66:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    1f6a:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1f6d:	3b 45 f4             	cmp    -0xc(%rbp),%eax
    1f70:	7c ae                	jl     1f20 <pipe1+0x132>
    1f72:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1f75:	01 45 ec             	add    %eax,-0x14(%rbp)
    1f78:	d1 65 f0             	shll   $1,-0x10(%rbp)
    1f7b:	8b 45 f0             	mov    -0x10(%rbp),%eax
    1f7e:	3d 00 20 00 00       	cmp    $0x2000,%eax
    1f83:	76 07                	jbe    1f8c <pipe1+0x19e>
    1f85:	c7 45 f0 00 20 00 00 	movl   $0x2000,-0x10(%rbp)
    1f8c:	8b 45 e0             	mov    -0x20(%rbp),%eax
    1f8f:	8b 55 f0             	mov    -0x10(%rbp),%edx
    1f92:	48 b9 20 89 00 00 00 	movabs $0x8920,%rcx
    1f99:	00 00 00 
    1f9c:	48 89 ce             	mov    %rcx,%rsi
    1f9f:	89 c7                	mov    %eax,%edi
    1fa1:	48 b8 9b 67 00 00 00 	movabs $0x679b,%rax
    1fa8:	00 00 00 
    1fab:	ff d0                	call   *%rax
    1fad:	89 45 f4             	mov    %eax,-0xc(%rbp)
    1fb0:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1fb4:	0f 8f 5d ff ff ff    	jg     1f17 <pipe1+0x129>
    1fba:	81 7d ec 2d 14 00 00 	cmpl   $0x142d,-0x14(%rbp)
    1fc1:	74 34                	je     1ff7 <pipe1+0x209>
    1fc3:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1fc6:	48 b9 cc 75 00 00 00 	movabs $0x75cc,%rcx
    1fcd:	00 00 00 
    1fd0:	89 c2                	mov    %eax,%edx
    1fd2:	48 89 ce             	mov    %rcx,%rsi
    1fd5:	bf 01 00 00 00       	mov    $0x1,%edi
    1fda:	b8 00 00 00 00       	mov    $0x0,%eax
    1fdf:	48 b9 78 6a 00 00 00 	movabs $0x6a78,%rcx
    1fe6:	00 00 00 
    1fe9:	ff d1                	call   *%rcx
    1feb:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    1ff2:	00 00 00 
    1ff5:	ff d0                	call   *%rax
    1ff7:	8b 45 e0             	mov    -0x20(%rbp),%eax
    1ffa:	89 c7                	mov    %eax,%edi
    1ffc:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    2003:	00 00 00 
    2006:	ff d0                	call   *%rax
    2008:	48 b8 81 67 00 00 00 	movabs $0x6781,%rax
    200f:	00 00 00 
    2012:	ff d0                	call   *%rax
    2014:	eb 19                	jmp    202f <pipe1+0x241>
    2016:	48 b8 e3 75 00 00 00 	movabs $0x75e3,%rax
    201d:	00 00 00 
    2020:	48 89 c7             	mov    %rax,%rdi
    2023:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    202a:	00 00 00 
    202d:	ff d0                	call   *%rax
    202f:	48 b8 ea 75 00 00 00 	movabs $0x75ea,%rax
    2036:	00 00 00 
    2039:	48 89 c6             	mov    %rax,%rsi
    203c:	bf 01 00 00 00       	mov    $0x1,%edi
    2041:	b8 00 00 00 00       	mov    $0x0,%eax
    2046:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    204d:	00 00 00 
    2050:	ff d2                	call   *%rdx
    2052:	c9                   	leave
    2053:	c3                   	ret

0000000000002054 <preempt>:
    2054:	55                   	push   %rbp
    2055:	48 89 e5             	mov    %rsp,%rbp
    2058:	48 83 ec 20          	sub    $0x20,%rsp
    205c:	48 b8 f4 75 00 00 00 	movabs $0x75f4,%rax
    2063:	00 00 00 
    2066:	48 89 c6             	mov    %rax,%rsi
    2069:	bf 01 00 00 00       	mov    $0x1,%edi
    206e:	b8 00 00 00 00       	mov    $0x0,%eax
    2073:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    207a:	00 00 00 
    207d:	ff d2                	call   *%rdx
    207f:	48 b8 67 67 00 00 00 	movabs $0x6767,%rax
    2086:	00 00 00 
    2089:	ff d0                	call   *%rax
    208b:	89 45 fc             	mov    %eax,-0x4(%rbp)
    208e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    2092:	75 03                	jne    2097 <preempt+0x43>
    2094:	90                   	nop
    2095:	eb fd                	jmp    2094 <preempt+0x40>
    2097:	48 b8 67 67 00 00 00 	movabs $0x6767,%rax
    209e:	00 00 00 
    20a1:	ff d0                	call   *%rax
    20a3:	89 45 f8             	mov    %eax,-0x8(%rbp)
    20a6:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    20aa:	75 03                	jne    20af <preempt+0x5b>
    20ac:	90                   	nop
    20ad:	eb fd                	jmp    20ac <preempt+0x58>
    20af:	48 8d 45 ec          	lea    -0x14(%rbp),%rax
    20b3:	48 89 c7             	mov    %rax,%rdi
    20b6:	48 b8 8e 67 00 00 00 	movabs $0x678e,%rax
    20bd:	00 00 00 
    20c0:	ff d0                	call   *%rax
    20c2:	48 b8 67 67 00 00 00 	movabs $0x6767,%rax
    20c9:	00 00 00 
    20cc:	ff d0                	call   *%rax
    20ce:	89 45 f4             	mov    %eax,-0xc(%rbp)
    20d1:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    20d5:	75 70                	jne    2147 <preempt+0xf3>
    20d7:	8b 45 ec             	mov    -0x14(%rbp),%eax
    20da:	89 c7                	mov    %eax,%edi
    20dc:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    20e3:	00 00 00 
    20e6:	ff d0                	call   *%rax
    20e8:	8b 45 f0             	mov    -0x10(%rbp),%eax
    20eb:	48 b9 fe 75 00 00 00 	movabs $0x75fe,%rcx
    20f2:	00 00 00 
    20f5:	ba 01 00 00 00       	mov    $0x1,%edx
    20fa:	48 89 ce             	mov    %rcx,%rsi
    20fd:	89 c7                	mov    %eax,%edi
    20ff:	48 b8 a8 67 00 00 00 	movabs $0x67a8,%rax
    2106:	00 00 00 
    2109:	ff d0                	call   *%rax
    210b:	83 f8 01             	cmp    $0x1,%eax
    210e:	74 23                	je     2133 <preempt+0xdf>
    2110:	48 b8 00 76 00 00 00 	movabs $0x7600,%rax
    2117:	00 00 00 
    211a:	48 89 c6             	mov    %rax,%rsi
    211d:	bf 01 00 00 00       	mov    $0x1,%edi
    2122:	b8 00 00 00 00       	mov    $0x0,%eax
    2127:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    212e:	00 00 00 
    2131:	ff d2                	call   *%rdx
    2133:	8b 45 f0             	mov    -0x10(%rbp),%eax
    2136:	89 c7                	mov    %eax,%edi
    2138:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    213f:	00 00 00 
    2142:	ff d0                	call   *%rax
    2144:	90                   	nop
    2145:	eb fd                	jmp    2144 <preempt+0xf0>
    2147:	8b 45 f0             	mov    -0x10(%rbp),%eax
    214a:	89 c7                	mov    %eax,%edi
    214c:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    2153:	00 00 00 
    2156:	ff d0                	call   *%rax
    2158:	8b 45 ec             	mov    -0x14(%rbp),%eax
    215b:	48 b9 20 89 00 00 00 	movabs $0x8920,%rcx
    2162:	00 00 00 
    2165:	ba 00 20 00 00       	mov    $0x2000,%edx
    216a:	48 89 ce             	mov    %rcx,%rsi
    216d:	89 c7                	mov    %eax,%edi
    216f:	48 b8 9b 67 00 00 00 	movabs $0x679b,%rax
    2176:	00 00 00 
    2179:	ff d0                	call   *%rax
    217b:	83 f8 01             	cmp    $0x1,%eax
    217e:	74 28                	je     21a8 <preempt+0x154>
    2180:	48 b8 14 76 00 00 00 	movabs $0x7614,%rax
    2187:	00 00 00 
    218a:	48 89 c6             	mov    %rax,%rsi
    218d:	bf 01 00 00 00       	mov    $0x1,%edi
    2192:	b8 00 00 00 00       	mov    $0x0,%eax
    2197:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    219e:	00 00 00 
    21a1:	ff d2                	call   *%rdx
    21a3:	e9 d1 00 00 00       	jmp    2279 <preempt+0x225>
    21a8:	8b 45 ec             	mov    -0x14(%rbp),%eax
    21ab:	89 c7                	mov    %eax,%edi
    21ad:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    21b4:	00 00 00 
    21b7:	ff d0                	call   *%rax
    21b9:	48 b8 27 76 00 00 00 	movabs $0x7627,%rax
    21c0:	00 00 00 
    21c3:	48 89 c6             	mov    %rax,%rsi
    21c6:	bf 01 00 00 00       	mov    $0x1,%edi
    21cb:	b8 00 00 00 00       	mov    $0x0,%eax
    21d0:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    21d7:	00 00 00 
    21da:	ff d2                	call   *%rdx
    21dc:	8b 45 fc             	mov    -0x4(%rbp),%eax
    21df:	89 c7                	mov    %eax,%edi
    21e1:	48 b8 c2 67 00 00 00 	movabs $0x67c2,%rax
    21e8:	00 00 00 
    21eb:	ff d0                	call   *%rax
    21ed:	8b 45 f8             	mov    -0x8(%rbp),%eax
    21f0:	89 c7                	mov    %eax,%edi
    21f2:	48 b8 c2 67 00 00 00 	movabs $0x67c2,%rax
    21f9:	00 00 00 
    21fc:	ff d0                	call   *%rax
    21fe:	8b 45 f4             	mov    -0xc(%rbp),%eax
    2201:	89 c7                	mov    %eax,%edi
    2203:	48 b8 c2 67 00 00 00 	movabs $0x67c2,%rax
    220a:	00 00 00 
    220d:	ff d0                	call   *%rax
    220f:	48 b8 30 76 00 00 00 	movabs $0x7630,%rax
    2216:	00 00 00 
    2219:	48 89 c6             	mov    %rax,%rsi
    221c:	bf 01 00 00 00       	mov    $0x1,%edi
    2221:	b8 00 00 00 00       	mov    $0x0,%eax
    2226:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    222d:	00 00 00 
    2230:	ff d2                	call   *%rdx
    2232:	48 b8 81 67 00 00 00 	movabs $0x6781,%rax
    2239:	00 00 00 
    223c:	ff d0                	call   *%rax
    223e:	48 b8 81 67 00 00 00 	movabs $0x6781,%rax
    2245:	00 00 00 
    2248:	ff d0                	call   *%rax
    224a:	48 b8 81 67 00 00 00 	movabs $0x6781,%rax
    2251:	00 00 00 
    2254:	ff d0                	call   *%rax
    2256:	48 b8 39 76 00 00 00 	movabs $0x7639,%rax
    225d:	00 00 00 
    2260:	48 89 c6             	mov    %rax,%rsi
    2263:	bf 01 00 00 00       	mov    $0x1,%edi
    2268:	b8 00 00 00 00       	mov    $0x0,%eax
    226d:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    2274:	00 00 00 
    2277:	ff d2                	call   *%rdx
    2279:	c9                   	leave
    227a:	c3                   	ret

000000000000227b <exitwait>:
    227b:	55                   	push   %rbp
    227c:	48 89 e5             	mov    %rsp,%rbp
    227f:	48 83 ec 10          	sub    $0x10,%rsp
    2283:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    228a:	e9 86 00 00 00       	jmp    2315 <exitwait+0x9a>
    228f:	48 b8 67 67 00 00 00 	movabs $0x6767,%rax
    2296:	00 00 00 
    2299:	ff d0                	call   *%rax
    229b:	89 45 f8             	mov    %eax,-0x8(%rbp)
    229e:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    22a2:	79 25                	jns    22c9 <exitwait+0x4e>
    22a4:	48 b8 0f 72 00 00 00 	movabs $0x720f,%rax
    22ab:	00 00 00 
    22ae:	48 89 c6             	mov    %rax,%rsi
    22b1:	bf 01 00 00 00       	mov    $0x1,%edi
    22b6:	b8 00 00 00 00       	mov    $0x0,%eax
    22bb:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    22c2:	00 00 00 
    22c5:	ff d2                	call   *%rdx
    22c7:	eb 79                	jmp    2342 <exitwait+0xc7>
    22c9:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    22cd:	74 36                	je     2305 <exitwait+0x8a>
    22cf:	48 b8 81 67 00 00 00 	movabs $0x6781,%rax
    22d6:	00 00 00 
    22d9:	ff d0                	call   *%rax
    22db:	39 45 f8             	cmp    %eax,-0x8(%rbp)
    22de:	74 31                	je     2311 <exitwait+0x96>
    22e0:	48 b8 45 76 00 00 00 	movabs $0x7645,%rax
    22e7:	00 00 00 
    22ea:	48 89 c6             	mov    %rax,%rsi
    22ed:	bf 01 00 00 00       	mov    $0x1,%edi
    22f2:	b8 00 00 00 00       	mov    $0x0,%eax
    22f7:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    22fe:	00 00 00 
    2301:	ff d2                	call   *%rdx
    2303:	eb 3d                	jmp    2342 <exitwait+0xc7>
    2305:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    230c:	00 00 00 
    230f:	ff d0                	call   *%rax
    2311:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    2315:	83 7d fc 63          	cmpl   $0x63,-0x4(%rbp)
    2319:	0f 8e 70 ff ff ff    	jle    228f <exitwait+0x14>
    231f:	48 b8 55 76 00 00 00 	movabs $0x7655,%rax
    2326:	00 00 00 
    2329:	48 89 c6             	mov    %rax,%rsi
    232c:	bf 01 00 00 00       	mov    $0x1,%edi
    2331:	b8 00 00 00 00       	mov    $0x0,%eax
    2336:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    233d:	00 00 00 
    2340:	ff d2                	call   *%rdx
    2342:	c9                   	leave
    2343:	c3                   	ret

0000000000002344 <mem>:
    2344:	55                   	push   %rbp
    2345:	48 89 e5             	mov    %rsp,%rbp
    2348:	48 83 ec 20          	sub    $0x20,%rsp
    234c:	48 b8 62 76 00 00 00 	movabs $0x7662,%rax
    2353:	00 00 00 
    2356:	48 89 c6             	mov    %rax,%rsi
    2359:	bf 01 00 00 00       	mov    $0x1,%edi
    235e:	b8 00 00 00 00       	mov    $0x0,%eax
    2363:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    236a:	00 00 00 
    236d:	ff d2                	call   *%rdx
    236f:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    2376:	00 00 00 
    2379:	ff d0                	call   *%rax
    237b:	89 45 f4             	mov    %eax,-0xc(%rbp)
    237e:	48 b8 67 67 00 00 00 	movabs $0x6767,%rax
    2385:	00 00 00 
    2388:	ff d0                	call   *%rax
    238a:	89 45 f0             	mov    %eax,-0x10(%rbp)
    238d:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    2391:	0f 85 29 01 00 00    	jne    24c0 <mem+0x17c>
    2397:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
    239e:	00 
    239f:	eb 13                	jmp    23b4 <mem+0x70>
    23a1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    23a5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
    23a9:	48 89 10             	mov    %rdx,(%rax)
    23ac:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    23b0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    23b4:	bf a1 86 01 00       	mov    $0x186a1,%edi
    23b9:	48 b8 35 70 00 00 00 	movabs $0x7035,%rax
    23c0:	00 00 00 
    23c3:	ff d0                	call   *%rax
    23c5:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    23c9:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
    23ce:	75 d1                	jne    23a1 <mem+0x5d>
    23d0:	48 b8 6c 76 00 00 00 	movabs $0x766c,%rax
    23d7:	00 00 00 
    23da:	48 89 c6             	mov    %rax,%rsi
    23dd:	bf 01 00 00 00       	mov    $0x1,%edi
    23e2:	b8 00 00 00 00       	mov    $0x0,%eax
    23e7:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    23ee:	00 00 00 
    23f1:	ff d2                	call   *%rdx
    23f3:	eb 26                	jmp    241b <mem+0xd7>
    23f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    23f9:	48 8b 00             	mov    (%rax),%rax
    23fc:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    2400:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2404:	48 89 c7             	mov    %rax,%rdi
    2407:	48 b8 88 6e 00 00 00 	movabs $0x6e88,%rax
    240e:	00 00 00 
    2411:	ff d0                	call   *%rax
    2413:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    2417:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    241b:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    2420:	75 d3                	jne    23f5 <mem+0xb1>
    2422:	bf 00 50 00 00       	mov    $0x5000,%edi
    2427:	48 b8 35 70 00 00 00 	movabs $0x7035,%rax
    242e:	00 00 00 
    2431:	ff d0                	call   *%rax
    2433:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    2437:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    243c:	75 40                	jne    247e <mem+0x13a>
    243e:	48 b8 79 76 00 00 00 	movabs $0x7679,%rax
    2445:	00 00 00 
    2448:	48 89 c6             	mov    %rax,%rsi
    244b:	bf 01 00 00 00       	mov    $0x1,%edi
    2450:	b8 00 00 00 00       	mov    $0x0,%eax
    2455:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    245c:	00 00 00 
    245f:	ff d2                	call   *%rdx
    2461:	8b 45 f4             	mov    -0xc(%rbp),%eax
    2464:	89 c7                	mov    %eax,%edi
    2466:	48 b8 c2 67 00 00 00 	movabs $0x67c2,%rax
    246d:	00 00 00 
    2470:	ff d0                	call   *%rax
    2472:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    2479:	00 00 00 
    247c:	ff d0                	call   *%rax
    247e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2482:	48 89 c7             	mov    %rax,%rdi
    2485:	48 b8 88 6e 00 00 00 	movabs $0x6e88,%rax
    248c:	00 00 00 
    248f:	ff d0                	call   *%rax
    2491:	48 b8 93 76 00 00 00 	movabs $0x7693,%rax
    2498:	00 00 00 
    249b:	48 89 c6             	mov    %rax,%rsi
    249e:	bf 01 00 00 00       	mov    $0x1,%edi
    24a3:	b8 00 00 00 00       	mov    $0x0,%eax
    24a8:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    24af:	00 00 00 
    24b2:	ff d2                	call   *%rdx
    24b4:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    24bb:	00 00 00 
    24be:	ff d0                	call   *%rax
    24c0:	48 b8 81 67 00 00 00 	movabs $0x6781,%rax
    24c7:	00 00 00 
    24ca:	ff d0                	call   *%rax
    24cc:	90                   	nop
    24cd:	c9                   	leave
    24ce:	c3                   	ret

00000000000024cf <sharedfd>:
    24cf:	55                   	push   %rbp
    24d0:	48 89 e5             	mov    %rsp,%rbp
    24d3:	48 83 ec 30          	sub    $0x30,%rsp
    24d7:	48 b8 9b 76 00 00 00 	movabs $0x769b,%rax
    24de:	00 00 00 
    24e1:	48 89 c6             	mov    %rax,%rsi
    24e4:	bf 01 00 00 00       	mov    $0x1,%edi
    24e9:	b8 00 00 00 00       	mov    $0x0,%eax
    24ee:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    24f5:	00 00 00 
    24f8:	ff d2                	call   *%rdx
    24fa:	48 b8 aa 76 00 00 00 	movabs $0x76aa,%rax
    2501:	00 00 00 
    2504:	48 89 c7             	mov    %rax,%rdi
    2507:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    250e:	00 00 00 
    2511:	ff d0                	call   *%rax
    2513:	48 b8 aa 76 00 00 00 	movabs $0x76aa,%rax
    251a:	00 00 00 
    251d:	be 02 02 00 00       	mov    $0x202,%esi
    2522:	48 89 c7             	mov    %rax,%rdi
    2525:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    252c:	00 00 00 
    252f:	ff d0                	call   *%rax
    2531:	89 45 f0             	mov    %eax,-0x10(%rbp)
    2534:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    2538:	79 28                	jns    2562 <sharedfd+0x93>
    253a:	48 b8 b8 76 00 00 00 	movabs $0x76b8,%rax
    2541:	00 00 00 
    2544:	48 89 c6             	mov    %rax,%rsi
    2547:	bf 01 00 00 00       	mov    $0x1,%edi
    254c:	b8 00 00 00 00       	mov    $0x0,%eax
    2551:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    2558:	00 00 00 
    255b:	ff d2                	call   *%rdx
    255d:	e9 1c 02 00 00       	jmp    277e <sharedfd+0x2af>
    2562:	48 b8 67 67 00 00 00 	movabs $0x6767,%rax
    2569:	00 00 00 
    256c:	ff d0                	call   *%rax
    256e:	89 45 ec             	mov    %eax,-0x14(%rbp)
    2571:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
    2575:	75 07                	jne    257e <sharedfd+0xaf>
    2577:	b9 63 00 00 00       	mov    $0x63,%ecx
    257c:	eb 05                	jmp    2583 <sharedfd+0xb4>
    257e:	b9 70 00 00 00       	mov    $0x70,%ecx
    2583:	48 8d 45 de          	lea    -0x22(%rbp),%rax
    2587:	ba 0a 00 00 00       	mov    $0xa,%edx
    258c:	89 ce                	mov    %ecx,%esi
    258e:	48 89 c7             	mov    %rax,%rdi
    2591:	48 b8 3f 65 00 00 00 	movabs $0x653f,%rax
    2598:	00 00 00 
    259b:	ff d0                	call   *%rax
    259d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    25a4:	eb 4b                	jmp    25f1 <sharedfd+0x122>
    25a6:	48 8d 4d de          	lea    -0x22(%rbp),%rcx
    25aa:	8b 45 f0             	mov    -0x10(%rbp),%eax
    25ad:	ba 0a 00 00 00       	mov    $0xa,%edx
    25b2:	48 89 ce             	mov    %rcx,%rsi
    25b5:	89 c7                	mov    %eax,%edi
    25b7:	48 b8 a8 67 00 00 00 	movabs $0x67a8,%rax
    25be:	00 00 00 
    25c1:	ff d0                	call   *%rax
    25c3:	83 f8 0a             	cmp    $0xa,%eax
    25c6:	74 25                	je     25ed <sharedfd+0x11e>
    25c8:	48 b8 e8 76 00 00 00 	movabs $0x76e8,%rax
    25cf:	00 00 00 
    25d2:	48 89 c6             	mov    %rax,%rsi
    25d5:	bf 01 00 00 00       	mov    $0x1,%edi
    25da:	b8 00 00 00 00       	mov    $0x0,%eax
    25df:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    25e6:	00 00 00 
    25e9:	ff d2                	call   *%rdx
    25eb:	eb 0d                	jmp    25fa <sharedfd+0x12b>
    25ed:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    25f1:	81 7d fc e7 03 00 00 	cmpl   $0x3e7,-0x4(%rbp)
    25f8:	7e ac                	jle    25a6 <sharedfd+0xd7>
    25fa:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
    25fe:	75 0c                	jne    260c <sharedfd+0x13d>
    2600:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    2607:	00 00 00 
    260a:	ff d0                	call   *%rax
    260c:	48 b8 81 67 00 00 00 	movabs $0x6781,%rax
    2613:	00 00 00 
    2616:	ff d0                	call   *%rax
    2618:	8b 45 f0             	mov    -0x10(%rbp),%eax
    261b:	89 c7                	mov    %eax,%edi
    261d:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    2624:	00 00 00 
    2627:	ff d0                	call   *%rax
    2629:	48 b8 aa 76 00 00 00 	movabs $0x76aa,%rax
    2630:	00 00 00 
    2633:	be 00 00 00 00       	mov    $0x0,%esi
    2638:	48 89 c7             	mov    %rax,%rdi
    263b:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    2642:	00 00 00 
    2645:	ff d0                	call   *%rax
    2647:	89 45 f0             	mov    %eax,-0x10(%rbp)
    264a:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    264e:	79 28                	jns    2678 <sharedfd+0x1a9>
    2650:	48 b8 08 77 00 00 00 	movabs $0x7708,%rax
    2657:	00 00 00 
    265a:	48 89 c6             	mov    %rax,%rsi
    265d:	bf 01 00 00 00       	mov    $0x1,%edi
    2662:	b8 00 00 00 00       	mov    $0x0,%eax
    2667:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    266e:	00 00 00 
    2671:	ff d2                	call   *%rdx
    2673:	e9 06 01 00 00       	jmp    277e <sharedfd+0x2af>
    2678:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    267f:	8b 45 f4             	mov    -0xc(%rbp),%eax
    2682:	89 45 f8             	mov    %eax,-0x8(%rbp)
    2685:	eb 39                	jmp    26c0 <sharedfd+0x1f1>
    2687:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    268e:	eb 28                	jmp    26b8 <sharedfd+0x1e9>
    2690:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2693:	48 98                	cltq
    2695:	0f b6 44 05 de       	movzbl -0x22(%rbp,%rax,1),%eax
    269a:	3c 63                	cmp    $0x63,%al
    269c:	75 04                	jne    26a2 <sharedfd+0x1d3>
    269e:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    26a2:	8b 45 fc             	mov    -0x4(%rbp),%eax
    26a5:	48 98                	cltq
    26a7:	0f b6 44 05 de       	movzbl -0x22(%rbp,%rax,1),%eax
    26ac:	3c 70                	cmp    $0x70,%al
    26ae:	75 04                	jne    26b4 <sharedfd+0x1e5>
    26b0:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
    26b4:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    26b8:	8b 45 fc             	mov    -0x4(%rbp),%eax
    26bb:	83 f8 09             	cmp    $0x9,%eax
    26be:	76 d0                	jbe    2690 <sharedfd+0x1c1>
    26c0:	48 8d 4d de          	lea    -0x22(%rbp),%rcx
    26c4:	8b 45 f0             	mov    -0x10(%rbp),%eax
    26c7:	ba 0a 00 00 00       	mov    $0xa,%edx
    26cc:	48 89 ce             	mov    %rcx,%rsi
    26cf:	89 c7                	mov    %eax,%edi
    26d1:	48 b8 9b 67 00 00 00 	movabs $0x679b,%rax
    26d8:	00 00 00 
    26db:	ff d0                	call   *%rax
    26dd:	89 45 e8             	mov    %eax,-0x18(%rbp)
    26e0:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
    26e4:	7f a1                	jg     2687 <sharedfd+0x1b8>
    26e6:	8b 45 f0             	mov    -0x10(%rbp),%eax
    26e9:	89 c7                	mov    %eax,%edi
    26eb:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    26f2:	00 00 00 
    26f5:	ff d0                	call   *%rax
    26f7:	48 b8 aa 76 00 00 00 	movabs $0x76aa,%rax
    26fe:	00 00 00 
    2701:	48 89 c7             	mov    %rax,%rdi
    2704:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    270b:	00 00 00 
    270e:	ff d0                	call   *%rax
    2710:	81 7d f8 10 27 00 00 	cmpl   $0x2710,-0x8(%rbp)
    2717:	75 2e                	jne    2747 <sharedfd+0x278>
    2719:	81 7d f4 10 27 00 00 	cmpl   $0x2710,-0xc(%rbp)
    2720:	75 25                	jne    2747 <sharedfd+0x278>
    2722:	48 b8 33 77 00 00 00 	movabs $0x7733,%rax
    2729:	00 00 00 
    272c:	48 89 c6             	mov    %rax,%rsi
    272f:	bf 01 00 00 00       	mov    $0x1,%edi
    2734:	b8 00 00 00 00       	mov    $0x0,%eax
    2739:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    2740:	00 00 00 
    2743:	ff d2                	call   *%rdx
    2745:	eb 37                	jmp    277e <sharedfd+0x2af>
    2747:	8b 55 f4             	mov    -0xc(%rbp),%edx
    274a:	8b 45 f8             	mov    -0x8(%rbp),%eax
    274d:	48 be 40 77 00 00 00 	movabs $0x7740,%rsi
    2754:	00 00 00 
    2757:	89 d1                	mov    %edx,%ecx
    2759:	89 c2                	mov    %eax,%edx
    275b:	bf 01 00 00 00       	mov    $0x1,%edi
    2760:	b8 00 00 00 00       	mov    $0x0,%eax
    2765:	49 b8 78 6a 00 00 00 	movabs $0x6a78,%r8
    276c:	00 00 00 
    276f:	41 ff d0             	call   *%r8
    2772:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    2779:	00 00 00 
    277c:	ff d0                	call   *%rax
    277e:	c9                   	leave
    277f:	c3                   	ret

0000000000002780 <fourfiles>:
    2780:	55                   	push   %rbp
    2781:	48 89 e5             	mov    %rsp,%rbp
    2784:	48 83 ec 50          	sub    $0x50,%rsp
    2788:	48 b8 55 77 00 00 00 	movabs $0x7755,%rax
    278f:	00 00 00 
    2792:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
    2796:	48 b8 58 77 00 00 00 	movabs $0x7758,%rax
    279d:	00 00 00 
    27a0:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    27a4:	48 b8 5b 77 00 00 00 	movabs $0x775b,%rax
    27ab:	00 00 00 
    27ae:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    27b2:	48 b8 5e 77 00 00 00 	movabs $0x775e,%rax
    27b9:	00 00 00 
    27bc:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    27c0:	48 b8 61 77 00 00 00 	movabs $0x7761,%rax
    27c7:	00 00 00 
    27ca:	48 89 c6             	mov    %rax,%rsi
    27cd:	bf 01 00 00 00       	mov    $0x1,%edi
    27d2:	b8 00 00 00 00       	mov    $0x0,%eax
    27d7:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    27de:	00 00 00 
    27e1:	ff d2                	call   *%rdx
    27e3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
    27ea:	e9 3f 01 00 00       	jmp    292e <fourfiles+0x1ae>
    27ef:	8b 45 f0             	mov    -0x10(%rbp),%eax
    27f2:	48 98                	cltq
    27f4:	48 8b 44 c5 b0       	mov    -0x50(%rbp,%rax,8),%rax
    27f9:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    27fd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    2801:	48 89 c7             	mov    %rax,%rdi
    2804:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    280b:	00 00 00 
    280e:	ff d0                	call   *%rax
    2810:	48 b8 67 67 00 00 00 	movabs $0x6767,%rax
    2817:	00 00 00 
    281a:	ff d0                	call   *%rax
    281c:	89 45 dc             	mov    %eax,-0x24(%rbp)
    281f:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
    2823:	79 19                	jns    283e <fourfiles+0xbe>
    2825:	48 b8 0f 72 00 00 00 	movabs $0x720f,%rax
    282c:	00 00 00 
    282f:	48 89 c7             	mov    %rax,%rdi
    2832:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    2839:	00 00 00 
    283c:	ff d0                	call   *%rax
    283e:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
    2842:	0f 85 e2 00 00 00    	jne    292a <fourfiles+0x1aa>
    2848:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    284c:	be 02 02 00 00       	mov    $0x202,%esi
    2851:	48 89 c7             	mov    %rax,%rdi
    2854:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    285b:	00 00 00 
    285e:	ff d0                	call   *%rax
    2860:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    2863:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
    2867:	79 19                	jns    2882 <fourfiles+0x102>
    2869:	48 b8 71 77 00 00 00 	movabs $0x7771,%rax
    2870:	00 00 00 
    2873:	48 89 c7             	mov    %rax,%rdi
    2876:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    287d:	00 00 00 
    2880:	ff d0                	call   *%rax
    2882:	8b 45 f0             	mov    -0x10(%rbp),%eax
    2885:	8d 48 30             	lea    0x30(%rax),%ecx
    2888:	48 b8 20 89 00 00 00 	movabs $0x8920,%rax
    288f:	00 00 00 
    2892:	ba 00 02 00 00       	mov    $0x200,%edx
    2897:	89 ce                	mov    %ecx,%esi
    2899:	48 89 c7             	mov    %rax,%rdi
    289c:	48 b8 3f 65 00 00 00 	movabs $0x653f,%rax
    28a3:	00 00 00 
    28a6:	ff d0                	call   *%rax
    28a8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    28af:	eb 67                	jmp    2918 <fourfiles+0x198>
    28b1:	48 b9 20 89 00 00 00 	movabs $0x8920,%rcx
    28b8:	00 00 00 
    28bb:	8b 45 e4             	mov    -0x1c(%rbp),%eax
    28be:	ba f4 01 00 00       	mov    $0x1f4,%edx
    28c3:	48 89 ce             	mov    %rcx,%rsi
    28c6:	89 c7                	mov    %eax,%edi
    28c8:	48 b8 a8 67 00 00 00 	movabs $0x67a8,%rax
    28cf:	00 00 00 
    28d2:	ff d0                	call   *%rax
    28d4:	89 45 e0             	mov    %eax,-0x20(%rbp)
    28d7:	81 7d e0 f4 01 00 00 	cmpl   $0x1f4,-0x20(%rbp)
    28de:	74 34                	je     2914 <fourfiles+0x194>
    28e0:	8b 45 e0             	mov    -0x20(%rbp),%eax
    28e3:	48 b9 78 77 00 00 00 	movabs $0x7778,%rcx
    28ea:	00 00 00 
    28ed:	89 c2                	mov    %eax,%edx
    28ef:	48 89 ce             	mov    %rcx,%rsi
    28f2:	bf 01 00 00 00       	mov    $0x1,%edi
    28f7:	b8 00 00 00 00       	mov    $0x0,%eax
    28fc:	48 b9 78 6a 00 00 00 	movabs $0x6a78,%rcx
    2903:	00 00 00 
    2906:	ff d1                	call   *%rcx
    2908:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    290f:	00 00 00 
    2912:	ff d0                	call   *%rax
    2914:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    2918:	83 7d fc 0b          	cmpl   $0xb,-0x4(%rbp)
    291c:	7e 93                	jle    28b1 <fourfiles+0x131>
    291e:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    2925:	00 00 00 
    2928:	ff d0                	call   *%rax
    292a:	83 45 f0 01          	addl   $0x1,-0x10(%rbp)
    292e:	83 7d f0 03          	cmpl   $0x3,-0x10(%rbp)
    2932:	0f 8e b7 fe ff ff    	jle    27ef <fourfiles+0x6f>
    2938:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
    293f:	eb 10                	jmp    2951 <fourfiles+0x1d1>
    2941:	48 b8 81 67 00 00 00 	movabs $0x6781,%rax
    2948:	00 00 00 
    294b:	ff d0                	call   *%rax
    294d:	83 45 f0 01          	addl   $0x1,-0x10(%rbp)
    2951:	83 7d f0 03          	cmpl   $0x3,-0x10(%rbp)
    2955:	7e ea                	jle    2941 <fourfiles+0x1c1>
    2957:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    295e:	e9 17 01 00 00       	jmp    2a7a <fourfiles+0x2fa>
    2963:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2966:	48 98                	cltq
    2968:	48 8b 44 c5 b0       	mov    -0x50(%rbp,%rax,8),%rax
    296d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    2971:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    2975:	be 00 00 00 00       	mov    $0x0,%esi
    297a:	48 89 c7             	mov    %rax,%rdi
    297d:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    2984:	00 00 00 
    2987:	ff d0                	call   *%rax
    2989:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    298c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    2993:	eb 54                	jmp    29e9 <fourfiles+0x269>
    2995:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
    299c:	eb 3d                	jmp    29db <fourfiles+0x25b>
    299e:	48 ba 20 89 00 00 00 	movabs $0x8920,%rdx
    29a5:	00 00 00 
    29a8:	8b 45 f8             	mov    -0x8(%rbp),%eax
    29ab:	48 98                	cltq
    29ad:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    29b1:	0f be d0             	movsbl %al,%edx
    29b4:	8b 45 fc             	mov    -0x4(%rbp),%eax
    29b7:	83 c0 30             	add    $0x30,%eax
    29ba:	39 c2                	cmp    %eax,%edx
    29bc:	74 19                	je     29d7 <fourfiles+0x257>
    29be:	48 b8 89 77 00 00 00 	movabs $0x7789,%rax
    29c5:	00 00 00 
    29c8:	48 89 c7             	mov    %rax,%rdi
    29cb:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    29d2:	00 00 00 
    29d5:	ff d0                	call   *%rax
    29d7:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    29db:	8b 45 f8             	mov    -0x8(%rbp),%eax
    29de:	3b 45 e0             	cmp    -0x20(%rbp),%eax
    29e1:	7c bb                	jl     299e <fourfiles+0x21e>
    29e3:	8b 45 e0             	mov    -0x20(%rbp),%eax
    29e6:	01 45 f4             	add    %eax,-0xc(%rbp)
    29e9:	48 b9 20 89 00 00 00 	movabs $0x8920,%rcx
    29f0:	00 00 00 
    29f3:	8b 45 e4             	mov    -0x1c(%rbp),%eax
    29f6:	ba 00 20 00 00       	mov    $0x2000,%edx
    29fb:	48 89 ce             	mov    %rcx,%rsi
    29fe:	89 c7                	mov    %eax,%edi
    2a00:	48 b8 9b 67 00 00 00 	movabs $0x679b,%rax
    2a07:	00 00 00 
    2a0a:	ff d0                	call   *%rax
    2a0c:	89 45 e0             	mov    %eax,-0x20(%rbp)
    2a0f:	83 7d e0 00          	cmpl   $0x0,-0x20(%rbp)
    2a13:	7f 80                	jg     2995 <fourfiles+0x215>
    2a15:	8b 45 e4             	mov    -0x1c(%rbp),%eax
    2a18:	89 c7                	mov    %eax,%edi
    2a1a:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    2a21:	00 00 00 
    2a24:	ff d0                	call   *%rax
    2a26:	81 7d f4 70 17 00 00 	cmpl   $0x1770,-0xc(%rbp)
    2a2d:	74 34                	je     2a63 <fourfiles+0x2e3>
    2a2f:	8b 45 f4             	mov    -0xc(%rbp),%eax
    2a32:	48 b9 94 77 00 00 00 	movabs $0x7794,%rcx
    2a39:	00 00 00 
    2a3c:	89 c2                	mov    %eax,%edx
    2a3e:	48 89 ce             	mov    %rcx,%rsi
    2a41:	bf 01 00 00 00       	mov    $0x1,%edi
    2a46:	b8 00 00 00 00       	mov    $0x0,%eax
    2a4b:	48 b9 78 6a 00 00 00 	movabs $0x6a78,%rcx
    2a52:	00 00 00 
    2a55:	ff d1                	call   *%rcx
    2a57:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    2a5e:	00 00 00 
    2a61:	ff d0                	call   *%rax
    2a63:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    2a67:	48 89 c7             	mov    %rax,%rdi
    2a6a:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    2a71:	00 00 00 
    2a74:	ff d0                	call   *%rax
    2a76:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    2a7a:	83 7d fc 01          	cmpl   $0x1,-0x4(%rbp)
    2a7e:	0f 8e df fe ff ff    	jle    2963 <fourfiles+0x1e3>
    2a84:	48 b8 a5 77 00 00 00 	movabs $0x77a5,%rax
    2a8b:	00 00 00 
    2a8e:	48 89 c6             	mov    %rax,%rsi
    2a91:	bf 01 00 00 00       	mov    $0x1,%edi
    2a96:	b8 00 00 00 00       	mov    $0x0,%eax
    2a9b:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    2aa2:	00 00 00 
    2aa5:	ff d2                	call   *%rdx
    2aa7:	90                   	nop
    2aa8:	c9                   	leave
    2aa9:	c3                   	ret

0000000000002aaa <createdelete>:
    2aaa:	55                   	push   %rbp
    2aab:	48 89 e5             	mov    %rsp,%rbp
    2aae:	48 83 ec 30          	sub    $0x30,%rsp
    2ab2:	48 b8 b3 77 00 00 00 	movabs $0x77b3,%rax
    2ab9:	00 00 00 
    2abc:	48 89 c6             	mov    %rax,%rsi
    2abf:	bf 01 00 00 00       	mov    $0x1,%edi
    2ac4:	b8 00 00 00 00       	mov    $0x0,%eax
    2ac9:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    2ad0:	00 00 00 
    2ad3:	ff d2                	call   *%rdx
    2ad5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
    2adc:	e9 15 01 00 00       	jmp    2bf6 <createdelete+0x14c>
    2ae1:	48 b8 67 67 00 00 00 	movabs $0x6767,%rax
    2ae8:	00 00 00 
    2aeb:	ff d0                	call   *%rax
    2aed:	89 45 f0             	mov    %eax,-0x10(%rbp)
    2af0:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    2af4:	79 19                	jns    2b0f <createdelete+0x65>
    2af6:	48 b8 0f 72 00 00 00 	movabs $0x720f,%rax
    2afd:	00 00 00 
    2b00:	48 89 c7             	mov    %rax,%rdi
    2b03:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    2b0a:	00 00 00 
    2b0d:	ff d0                	call   *%rax
    2b0f:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    2b13:	0f 85 d9 00 00 00    	jne    2bf2 <createdelete+0x148>
    2b19:	8b 45 f8             	mov    -0x8(%rbp),%eax
    2b1c:	83 c0 70             	add    $0x70,%eax
    2b1f:	88 45 d0             	mov    %al,-0x30(%rbp)
    2b22:	c6 45 d2 00          	movb   $0x0,-0x2e(%rbp)
    2b26:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    2b2d:	e9 aa 00 00 00       	jmp    2bdc <createdelete+0x132>
    2b32:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2b35:	83 c0 30             	add    $0x30,%eax
    2b38:	88 45 d1             	mov    %al,-0x2f(%rbp)
    2b3b:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    2b3f:	be 02 02 00 00       	mov    $0x202,%esi
    2b44:	48 89 c7             	mov    %rax,%rdi
    2b47:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    2b4e:	00 00 00 
    2b51:	ff d0                	call   *%rax
    2b53:	89 45 f4             	mov    %eax,-0xc(%rbp)
    2b56:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    2b5a:	79 19                	jns    2b75 <createdelete+0xcb>
    2b5c:	48 b8 71 77 00 00 00 	movabs $0x7771,%rax
    2b63:	00 00 00 
    2b66:	48 89 c7             	mov    %rax,%rdi
    2b69:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    2b70:	00 00 00 
    2b73:	ff d0                	call   *%rax
    2b75:	8b 45 f4             	mov    -0xc(%rbp),%eax
    2b78:	89 c7                	mov    %eax,%edi
    2b7a:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    2b81:	00 00 00 
    2b84:	ff d0                	call   *%rax
    2b86:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    2b8a:	7e 4c                	jle    2bd8 <createdelete+0x12e>
    2b8c:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2b8f:	83 e0 01             	and    $0x1,%eax
    2b92:	85 c0                	test   %eax,%eax
    2b94:	75 42                	jne    2bd8 <createdelete+0x12e>
    2b96:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2b99:	89 c2                	mov    %eax,%edx
    2b9b:	c1 ea 1f             	shr    $0x1f,%edx
    2b9e:	01 d0                	add    %edx,%eax
    2ba0:	d1 f8                	sar    $1,%eax
    2ba2:	83 c0 30             	add    $0x30,%eax
    2ba5:	88 45 d1             	mov    %al,-0x2f(%rbp)
    2ba8:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    2bac:	48 89 c7             	mov    %rax,%rdi
    2baf:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    2bb6:	00 00 00 
    2bb9:	ff d0                	call   *%rax
    2bbb:	85 c0                	test   %eax,%eax
    2bbd:	79 19                	jns    2bd8 <createdelete+0x12e>
    2bbf:	48 b8 7b 72 00 00 00 	movabs $0x727b,%rax
    2bc6:	00 00 00 
    2bc9:	48 89 c7             	mov    %rax,%rdi
    2bcc:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    2bd3:	00 00 00 
    2bd6:	ff d0                	call   *%rax
    2bd8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    2bdc:	83 7d fc 13          	cmpl   $0x13,-0x4(%rbp)
    2be0:	0f 8e 4c ff ff ff    	jle    2b32 <createdelete+0x88>
    2be6:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    2bed:	00 00 00 
    2bf0:	ff d0                	call   *%rax
    2bf2:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    2bf6:	83 7d f8 03          	cmpl   $0x3,-0x8(%rbp)
    2bfa:	0f 8e e1 fe ff ff    	jle    2ae1 <createdelete+0x37>
    2c00:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
    2c07:	eb 10                	jmp    2c19 <createdelete+0x16f>
    2c09:	48 b8 81 67 00 00 00 	movabs $0x6781,%rax
    2c10:	00 00 00 
    2c13:	ff d0                	call   *%rax
    2c15:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    2c19:	83 7d f8 03          	cmpl   $0x3,-0x8(%rbp)
    2c1d:	7e ea                	jle    2c09 <createdelete+0x15f>
    2c1f:	c6 45 d2 00          	movb   $0x0,-0x2e(%rbp)
    2c23:	0f b6 45 d2          	movzbl -0x2e(%rbp),%eax
    2c27:	88 45 d1             	mov    %al,-0x2f(%rbp)
    2c2a:	0f b6 45 d1          	movzbl -0x2f(%rbp),%eax
    2c2e:	88 45 d0             	mov    %al,-0x30(%rbp)
    2c31:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    2c38:	e9 f2 00 00 00       	jmp    2d2f <createdelete+0x285>
    2c3d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
    2c44:	e9 d8 00 00 00       	jmp    2d21 <createdelete+0x277>
    2c49:	8b 45 f8             	mov    -0x8(%rbp),%eax
    2c4c:	83 c0 70             	add    $0x70,%eax
    2c4f:	88 45 d0             	mov    %al,-0x30(%rbp)
    2c52:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2c55:	83 c0 30             	add    $0x30,%eax
    2c58:	88 45 d1             	mov    %al,-0x2f(%rbp)
    2c5b:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    2c5f:	be 00 00 00 00       	mov    $0x0,%esi
    2c64:	48 89 c7             	mov    %rax,%rdi
    2c67:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    2c6e:	00 00 00 
    2c71:	ff d0                	call   *%rax
    2c73:	89 45 f4             	mov    %eax,-0xc(%rbp)
    2c76:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    2c7a:	74 06                	je     2c82 <createdelete+0x1d8>
    2c7c:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
    2c80:	7e 3c                	jle    2cbe <createdelete+0x214>
    2c82:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    2c86:	79 36                	jns    2cbe <createdelete+0x214>
    2c88:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    2c8c:	48 b9 c8 77 00 00 00 	movabs $0x77c8,%rcx
    2c93:	00 00 00 
    2c96:	48 89 c2             	mov    %rax,%rdx
    2c99:	48 89 ce             	mov    %rcx,%rsi
    2c9c:	bf 01 00 00 00       	mov    $0x1,%edi
    2ca1:	b8 00 00 00 00       	mov    $0x0,%eax
    2ca6:	48 b9 78 6a 00 00 00 	movabs $0x6a78,%rcx
    2cad:	00 00 00 
    2cb0:	ff d1                	call   *%rcx
    2cb2:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    2cb9:	00 00 00 
    2cbc:	ff d0                	call   *%rax
    2cbe:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    2cc2:	7e 42                	jle    2d06 <createdelete+0x25c>
    2cc4:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
    2cc8:	7f 3c                	jg     2d06 <createdelete+0x25c>
    2cca:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    2cce:	78 36                	js     2d06 <createdelete+0x25c>
    2cd0:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    2cd4:	48 b9 f0 77 00 00 00 	movabs $0x77f0,%rcx
    2cdb:	00 00 00 
    2cde:	48 89 c2             	mov    %rax,%rdx
    2ce1:	48 89 ce             	mov    %rcx,%rsi
    2ce4:	bf 01 00 00 00       	mov    $0x1,%edi
    2ce9:	b8 00 00 00 00       	mov    $0x0,%eax
    2cee:	48 b9 78 6a 00 00 00 	movabs $0x6a78,%rcx
    2cf5:	00 00 00 
    2cf8:	ff d1                	call   *%rcx
    2cfa:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    2d01:	00 00 00 
    2d04:	ff d0                	call   *%rax
    2d06:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    2d0a:	78 11                	js     2d1d <createdelete+0x273>
    2d0c:	8b 45 f4             	mov    -0xc(%rbp),%eax
    2d0f:	89 c7                	mov    %eax,%edi
    2d11:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    2d18:	00 00 00 
    2d1b:	ff d0                	call   *%rax
    2d1d:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    2d21:	83 7d f8 03          	cmpl   $0x3,-0x8(%rbp)
    2d25:	0f 8e 1e ff ff ff    	jle    2c49 <createdelete+0x19f>
    2d2b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    2d2f:	83 7d fc 13          	cmpl   $0x13,-0x4(%rbp)
    2d33:	0f 8e 04 ff ff ff    	jle    2c3d <createdelete+0x193>
    2d39:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    2d40:	eb 3c                	jmp    2d7e <createdelete+0x2d4>
    2d42:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
    2d49:	eb 29                	jmp    2d74 <createdelete+0x2ca>
    2d4b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2d4e:	83 c0 70             	add    $0x70,%eax
    2d51:	88 45 d0             	mov    %al,-0x30(%rbp)
    2d54:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2d57:	83 c0 30             	add    $0x30,%eax
    2d5a:	88 45 d1             	mov    %al,-0x2f(%rbp)
    2d5d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    2d61:	48 89 c7             	mov    %rax,%rdi
    2d64:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    2d6b:	00 00 00 
    2d6e:	ff d0                	call   *%rax
    2d70:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    2d74:	83 7d f8 03          	cmpl   $0x3,-0x8(%rbp)
    2d78:	7e d1                	jle    2d4b <createdelete+0x2a1>
    2d7a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    2d7e:	83 7d fc 13          	cmpl   $0x13,-0x4(%rbp)
    2d82:	7e be                	jle    2d42 <createdelete+0x298>
    2d84:	48 b8 10 78 00 00 00 	movabs $0x7810,%rax
    2d8b:	00 00 00 
    2d8e:	48 89 c6             	mov    %rax,%rsi
    2d91:	bf 01 00 00 00       	mov    $0x1,%edi
    2d96:	b8 00 00 00 00       	mov    $0x0,%eax
    2d9b:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    2da2:	00 00 00 
    2da5:	ff d2                	call   *%rdx
    2da7:	90                   	nop
    2da8:	c9                   	leave
    2da9:	c3                   	ret

0000000000002daa <unlinkread>:
    2daa:	55                   	push   %rbp
    2dab:	48 89 e5             	mov    %rsp,%rbp
    2dae:	48 83 ec 10          	sub    $0x10,%rsp
    2db2:	48 b8 21 78 00 00 00 	movabs $0x7821,%rax
    2db9:	00 00 00 
    2dbc:	48 89 c6             	mov    %rax,%rsi
    2dbf:	bf 01 00 00 00       	mov    $0x1,%edi
    2dc4:	b8 00 00 00 00       	mov    $0x0,%eax
    2dc9:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    2dd0:	00 00 00 
    2dd3:	ff d2                	call   *%rdx
    2dd5:	48 b8 32 78 00 00 00 	movabs $0x7832,%rax
    2ddc:	00 00 00 
    2ddf:	be 02 02 00 00       	mov    $0x202,%esi
    2de4:	48 89 c7             	mov    %rax,%rdi
    2de7:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    2dee:	00 00 00 
    2df1:	ff d0                	call   *%rax
    2df3:	89 45 fc             	mov    %eax,-0x4(%rbp)
    2df6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    2dfa:	79 19                	jns    2e15 <unlinkread+0x6b>
    2dfc:	48 b8 3d 78 00 00 00 	movabs $0x783d,%rax
    2e03:	00 00 00 
    2e06:	48 89 c7             	mov    %rax,%rdi
    2e09:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    2e10:	00 00 00 
    2e13:	ff d0                	call   *%rax
    2e15:	48 b9 4f 78 00 00 00 	movabs $0x784f,%rcx
    2e1c:	00 00 00 
    2e1f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2e22:	ba 05 00 00 00       	mov    $0x5,%edx
    2e27:	48 89 ce             	mov    %rcx,%rsi
    2e2a:	89 c7                	mov    %eax,%edi
    2e2c:	48 b8 a8 67 00 00 00 	movabs $0x67a8,%rax
    2e33:	00 00 00 
    2e36:	ff d0                	call   *%rax
    2e38:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2e3b:	89 c7                	mov    %eax,%edi
    2e3d:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    2e44:	00 00 00 
    2e47:	ff d0                	call   *%rax
    2e49:	48 b8 32 78 00 00 00 	movabs $0x7832,%rax
    2e50:	00 00 00 
    2e53:	be 02 00 00 00       	mov    $0x2,%esi
    2e58:	48 89 c7             	mov    %rax,%rdi
    2e5b:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    2e62:	00 00 00 
    2e65:	ff d0                	call   *%rax
    2e67:	89 45 fc             	mov    %eax,-0x4(%rbp)
    2e6a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    2e6e:	79 19                	jns    2e89 <unlinkread+0xdf>
    2e70:	48 b8 55 78 00 00 00 	movabs $0x7855,%rax
    2e77:	00 00 00 
    2e7a:	48 89 c7             	mov    %rax,%rdi
    2e7d:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    2e84:	00 00 00 
    2e87:	ff d0                	call   *%rax
    2e89:	48 b8 32 78 00 00 00 	movabs $0x7832,%rax
    2e90:	00 00 00 
    2e93:	48 89 c7             	mov    %rax,%rdi
    2e96:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    2e9d:	00 00 00 
    2ea0:	ff d0                	call   *%rax
    2ea2:	85 c0                	test   %eax,%eax
    2ea4:	74 19                	je     2ebf <unlinkread+0x115>
    2ea6:	48 b8 65 78 00 00 00 	movabs $0x7865,%rax
    2ead:	00 00 00 
    2eb0:	48 89 c7             	mov    %rax,%rdi
    2eb3:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    2eba:	00 00 00 
    2ebd:	ff d0                	call   *%rax
    2ebf:	48 b8 32 78 00 00 00 	movabs $0x7832,%rax
    2ec6:	00 00 00 
    2ec9:	be 02 02 00 00       	mov    $0x202,%esi
    2ece:	48 89 c7             	mov    %rax,%rdi
    2ed1:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    2ed8:	00 00 00 
    2edb:	ff d0                	call   *%rax
    2edd:	89 45 f8             	mov    %eax,-0x8(%rbp)
    2ee0:	48 b9 77 78 00 00 00 	movabs $0x7877,%rcx
    2ee7:	00 00 00 
    2eea:	8b 45 f8             	mov    -0x8(%rbp),%eax
    2eed:	ba 03 00 00 00       	mov    $0x3,%edx
    2ef2:	48 89 ce             	mov    %rcx,%rsi
    2ef5:	89 c7                	mov    %eax,%edi
    2ef7:	48 b8 a8 67 00 00 00 	movabs $0x67a8,%rax
    2efe:	00 00 00 
    2f01:	ff d0                	call   *%rax
    2f03:	8b 45 f8             	mov    -0x8(%rbp),%eax
    2f06:	89 c7                	mov    %eax,%edi
    2f08:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    2f0f:	00 00 00 
    2f12:	ff d0                	call   *%rax
    2f14:	48 b9 20 89 00 00 00 	movabs $0x8920,%rcx
    2f1b:	00 00 00 
    2f1e:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2f21:	ba 00 20 00 00       	mov    $0x2000,%edx
    2f26:	48 89 ce             	mov    %rcx,%rsi
    2f29:	89 c7                	mov    %eax,%edi
    2f2b:	48 b8 9b 67 00 00 00 	movabs $0x679b,%rax
    2f32:	00 00 00 
    2f35:	ff d0                	call   *%rax
    2f37:	83 f8 05             	cmp    $0x5,%eax
    2f3a:	74 19                	je     2f55 <unlinkread+0x1ab>
    2f3c:	48 b8 7b 78 00 00 00 	movabs $0x787b,%rax
    2f43:	00 00 00 
    2f46:	48 89 c7             	mov    %rax,%rdi
    2f49:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    2f50:	00 00 00 
    2f53:	ff d0                	call   *%rax
    2f55:	48 b8 20 89 00 00 00 	movabs $0x8920,%rax
    2f5c:	00 00 00 
    2f5f:	0f b6 00             	movzbl (%rax),%eax
    2f62:	3c 68                	cmp    $0x68,%al
    2f64:	74 19                	je     2f7f <unlinkread+0x1d5>
    2f66:	48 b8 92 78 00 00 00 	movabs $0x7892,%rax
    2f6d:	00 00 00 
    2f70:	48 89 c7             	mov    %rax,%rdi
    2f73:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    2f7a:	00 00 00 
    2f7d:	ff d0                	call   *%rax
    2f7f:	48 b9 20 89 00 00 00 	movabs $0x8920,%rcx
    2f86:	00 00 00 
    2f89:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2f8c:	ba 0a 00 00 00       	mov    $0xa,%edx
    2f91:	48 89 ce             	mov    %rcx,%rsi
    2f94:	89 c7                	mov    %eax,%edi
    2f96:	48 b8 a8 67 00 00 00 	movabs $0x67a8,%rax
    2f9d:	00 00 00 
    2fa0:	ff d0                	call   *%rax
    2fa2:	83 f8 0a             	cmp    $0xa,%eax
    2fa5:	74 19                	je     2fc0 <unlinkread+0x216>
    2fa7:	48 b8 a8 78 00 00 00 	movabs $0x78a8,%rax
    2fae:	00 00 00 
    2fb1:	48 89 c7             	mov    %rax,%rdi
    2fb4:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    2fbb:	00 00 00 
    2fbe:	ff d0                	call   *%rax
    2fc0:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2fc3:	89 c7                	mov    %eax,%edi
    2fc5:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    2fcc:	00 00 00 
    2fcf:	ff d0                	call   *%rax
    2fd1:	48 b8 32 78 00 00 00 	movabs $0x7832,%rax
    2fd8:	00 00 00 
    2fdb:	48 89 c7             	mov    %rax,%rdi
    2fde:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    2fe5:	00 00 00 
    2fe8:	ff d0                	call   *%rax
    2fea:	48 b8 b9 78 00 00 00 	movabs $0x78b9,%rax
    2ff1:	00 00 00 
    2ff4:	48 89 c6             	mov    %rax,%rsi
    2ff7:	bf 01 00 00 00       	mov    $0x1,%edi
    2ffc:	b8 00 00 00 00       	mov    $0x0,%eax
    3001:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    3008:	00 00 00 
    300b:	ff d2                	call   *%rdx
    300d:	90                   	nop
    300e:	c9                   	leave
    300f:	c3                   	ret

0000000000003010 <linktest>:
    3010:	55                   	push   %rbp
    3011:	48 89 e5             	mov    %rsp,%rbp
    3014:	48 83 ec 10          	sub    $0x10,%rsp
    3018:	48 b8 c8 78 00 00 00 	movabs $0x78c8,%rax
    301f:	00 00 00 
    3022:	48 89 c6             	mov    %rax,%rsi
    3025:	bf 01 00 00 00       	mov    $0x1,%edi
    302a:	b8 00 00 00 00       	mov    $0x0,%eax
    302f:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    3036:	00 00 00 
    3039:	ff d2                	call   *%rdx
    303b:	48 b8 d2 78 00 00 00 	movabs $0x78d2,%rax
    3042:	00 00 00 
    3045:	48 89 c7             	mov    %rax,%rdi
    3048:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    304f:	00 00 00 
    3052:	ff d0                	call   *%rax
    3054:	48 b8 d6 78 00 00 00 	movabs $0x78d6,%rax
    305b:	00 00 00 
    305e:	48 89 c7             	mov    %rax,%rdi
    3061:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    3068:	00 00 00 
    306b:	ff d0                	call   *%rax
    306d:	48 b8 d2 78 00 00 00 	movabs $0x78d2,%rax
    3074:	00 00 00 
    3077:	be 02 02 00 00       	mov    $0x202,%esi
    307c:	48 89 c7             	mov    %rax,%rdi
    307f:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    3086:	00 00 00 
    3089:	ff d0                	call   *%rax
    308b:	89 45 fc             	mov    %eax,-0x4(%rbp)
    308e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    3092:	79 19                	jns    30ad <linktest+0x9d>
    3094:	48 b8 da 78 00 00 00 	movabs $0x78da,%rax
    309b:	00 00 00 
    309e:	48 89 c7             	mov    %rax,%rdi
    30a1:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    30a8:	00 00 00 
    30ab:	ff d0                	call   *%rax
    30ad:	48 b9 4f 78 00 00 00 	movabs $0x784f,%rcx
    30b4:	00 00 00 
    30b7:	8b 45 fc             	mov    -0x4(%rbp),%eax
    30ba:	ba 05 00 00 00       	mov    $0x5,%edx
    30bf:	48 89 ce             	mov    %rcx,%rsi
    30c2:	89 c7                	mov    %eax,%edi
    30c4:	48 b8 a8 67 00 00 00 	movabs $0x67a8,%rax
    30cb:	00 00 00 
    30ce:	ff d0                	call   *%rax
    30d0:	83 f8 05             	cmp    $0x5,%eax
    30d3:	74 19                	je     30ee <linktest+0xde>
    30d5:	48 b8 e5 78 00 00 00 	movabs $0x78e5,%rax
    30dc:	00 00 00 
    30df:	48 89 c7             	mov    %rax,%rdi
    30e2:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    30e9:	00 00 00 
    30ec:	ff d0                	call   *%rax
    30ee:	8b 45 fc             	mov    -0x4(%rbp),%eax
    30f1:	89 c7                	mov    %eax,%edi
    30f3:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    30fa:	00 00 00 
    30fd:	ff d0                	call   *%rax
    30ff:	48 ba d6 78 00 00 00 	movabs $0x78d6,%rdx
    3106:	00 00 00 
    3109:	48 b8 d2 78 00 00 00 	movabs $0x78d2,%rax
    3110:	00 00 00 
    3113:	48 89 d6             	mov    %rdx,%rsi
    3116:	48 89 c7             	mov    %rax,%rdi
    3119:	48 b8 10 68 00 00 00 	movabs $0x6810,%rax
    3120:	00 00 00 
    3123:	ff d0                	call   *%rax
    3125:	85 c0                	test   %eax,%eax
    3127:	79 19                	jns    3142 <linktest+0x132>
    3129:	48 b8 ef 78 00 00 00 	movabs $0x78ef,%rax
    3130:	00 00 00 
    3133:	48 89 c7             	mov    %rax,%rdi
    3136:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    313d:	00 00 00 
    3140:	ff d0                	call   *%rax
    3142:	48 b8 d2 78 00 00 00 	movabs $0x78d2,%rax
    3149:	00 00 00 
    314c:	48 89 c7             	mov    %rax,%rdi
    314f:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    3156:	00 00 00 
    3159:	ff d0                	call   *%rax
    315b:	48 b8 d2 78 00 00 00 	movabs $0x78d2,%rax
    3162:	00 00 00 
    3165:	be 00 00 00 00       	mov    $0x0,%esi
    316a:	48 89 c7             	mov    %rax,%rdi
    316d:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    3174:	00 00 00 
    3177:	ff d0                	call   *%rax
    3179:	85 c0                	test   %eax,%eax
    317b:	78 19                	js     3196 <linktest+0x186>
    317d:	48 b8 00 79 00 00 00 	movabs $0x7900,%rax
    3184:	00 00 00 
    3187:	48 89 c7             	mov    %rax,%rdi
    318a:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3191:	00 00 00 
    3194:	ff d0                	call   *%rax
    3196:	48 b8 d6 78 00 00 00 	movabs $0x78d6,%rax
    319d:	00 00 00 
    31a0:	be 00 00 00 00       	mov    $0x0,%esi
    31a5:	48 89 c7             	mov    %rax,%rdi
    31a8:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    31af:	00 00 00 
    31b2:	ff d0                	call   *%rax
    31b4:	89 45 fc             	mov    %eax,-0x4(%rbp)
    31b7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    31bb:	79 19                	jns    31d6 <linktest+0x1c6>
    31bd:	48 b8 24 79 00 00 00 	movabs $0x7924,%rax
    31c4:	00 00 00 
    31c7:	48 89 c7             	mov    %rax,%rdi
    31ca:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    31d1:	00 00 00 
    31d4:	ff d0                	call   *%rax
    31d6:	48 b9 20 89 00 00 00 	movabs $0x8920,%rcx
    31dd:	00 00 00 
    31e0:	8b 45 fc             	mov    -0x4(%rbp),%eax
    31e3:	ba 00 20 00 00       	mov    $0x2000,%edx
    31e8:	48 89 ce             	mov    %rcx,%rsi
    31eb:	89 c7                	mov    %eax,%edi
    31ed:	48 b8 9b 67 00 00 00 	movabs $0x679b,%rax
    31f4:	00 00 00 
    31f7:	ff d0                	call   *%rax
    31f9:	83 f8 05             	cmp    $0x5,%eax
    31fc:	74 19                	je     3217 <linktest+0x207>
    31fe:	48 b8 2d 79 00 00 00 	movabs $0x792d,%rax
    3205:	00 00 00 
    3208:	48 89 c7             	mov    %rax,%rdi
    320b:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3212:	00 00 00 
    3215:	ff d0                	call   *%rax
    3217:	8b 45 fc             	mov    -0x4(%rbp),%eax
    321a:	89 c7                	mov    %eax,%edi
    321c:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    3223:	00 00 00 
    3226:	ff d0                	call   *%rax
    3228:	48 ba d6 78 00 00 00 	movabs $0x78d6,%rdx
    322f:	00 00 00 
    3232:	48 b8 d6 78 00 00 00 	movabs $0x78d6,%rax
    3239:	00 00 00 
    323c:	48 89 d6             	mov    %rdx,%rsi
    323f:	48 89 c7             	mov    %rax,%rdi
    3242:	48 b8 10 68 00 00 00 	movabs $0x6810,%rax
    3249:	00 00 00 
    324c:	ff d0                	call   *%rax
    324e:	85 c0                	test   %eax,%eax
    3250:	78 19                	js     326b <linktest+0x25b>
    3252:	48 b8 36 79 00 00 00 	movabs $0x7936,%rax
    3259:	00 00 00 
    325c:	48 89 c7             	mov    %rax,%rdi
    325f:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3266:	00 00 00 
    3269:	ff d0                	call   *%rax
    326b:	48 b8 d6 78 00 00 00 	movabs $0x78d6,%rax
    3272:	00 00 00 
    3275:	48 89 c7             	mov    %rax,%rdi
    3278:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    327f:	00 00 00 
    3282:	ff d0                	call   *%rax
    3284:	48 ba d2 78 00 00 00 	movabs $0x78d2,%rdx
    328b:	00 00 00 
    328e:	48 b8 d6 78 00 00 00 	movabs $0x78d6,%rax
    3295:	00 00 00 
    3298:	48 89 d6             	mov    %rdx,%rsi
    329b:	48 89 c7             	mov    %rax,%rdi
    329e:	48 b8 10 68 00 00 00 	movabs $0x6810,%rax
    32a5:	00 00 00 
    32a8:	ff d0                	call   *%rax
    32aa:	85 c0                	test   %eax,%eax
    32ac:	78 19                	js     32c7 <linktest+0x2b7>
    32ae:	48 b8 58 79 00 00 00 	movabs $0x7958,%rax
    32b5:	00 00 00 
    32b8:	48 89 c7             	mov    %rax,%rdi
    32bb:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    32c2:	00 00 00 
    32c5:	ff d0                	call   *%rax
    32c7:	48 ba d2 78 00 00 00 	movabs $0x78d2,%rdx
    32ce:	00 00 00 
    32d1:	48 b8 7a 79 00 00 00 	movabs $0x797a,%rax
    32d8:	00 00 00 
    32db:	48 89 d6             	mov    %rdx,%rsi
    32de:	48 89 c7             	mov    %rax,%rdi
    32e1:	48 b8 10 68 00 00 00 	movabs $0x6810,%rax
    32e8:	00 00 00 
    32eb:	ff d0                	call   *%rax
    32ed:	85 c0                	test   %eax,%eax
    32ef:	78 19                	js     330a <linktest+0x2fa>
    32f1:	48 b8 7c 79 00 00 00 	movabs $0x797c,%rax
    32f8:	00 00 00 
    32fb:	48 89 c7             	mov    %rax,%rdi
    32fe:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3305:	00 00 00 
    3308:	ff d0                	call   *%rax
    330a:	48 b8 97 79 00 00 00 	movabs $0x7997,%rax
    3311:	00 00 00 
    3314:	48 89 c6             	mov    %rax,%rsi
    3317:	bf 01 00 00 00       	mov    $0x1,%edi
    331c:	b8 00 00 00 00       	mov    $0x0,%eax
    3321:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    3328:	00 00 00 
    332b:	ff d2                	call   *%rdx
    332d:	90                   	nop
    332e:	c9                   	leave
    332f:	c3                   	ret

0000000000003330 <concreate>:
    3330:	55                   	push   %rbp
    3331:	48 89 e5             	mov    %rsp,%rbp
    3334:	48 83 ec 50          	sub    $0x50,%rsp
    3338:	48 b8 a4 79 00 00 00 	movabs $0x79a4,%rax
    333f:	00 00 00 
    3342:	48 89 c6             	mov    %rax,%rsi
    3345:	bf 01 00 00 00       	mov    $0x1,%edi
    334a:	b8 00 00 00 00       	mov    $0x0,%eax
    334f:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    3356:	00 00 00 
    3359:	ff d2                	call   *%rdx
    335b:	c6 45 ed 43          	movb   $0x43,-0x13(%rbp)
    335f:	c6 45 ef 00          	movb   $0x0,-0x11(%rbp)
    3363:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    336a:	e9 5e 01 00 00       	jmp    34cd <concreate+0x19d>
    336f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3372:	83 c0 30             	add    $0x30,%eax
    3375:	88 45 ee             	mov    %al,-0x12(%rbp)
    3378:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    337c:	48 89 c7             	mov    %rax,%rdi
    337f:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    3386:	00 00 00 
    3389:	ff d0                	call   *%rax
    338b:	48 b8 67 67 00 00 00 	movabs $0x6767,%rax
    3392:	00 00 00 
    3395:	ff d0                	call   *%rax
    3397:	89 45 f0             	mov    %eax,-0x10(%rbp)
    339a:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    339e:	74 4f                	je     33ef <concreate+0xbf>
    33a0:	8b 4d fc             	mov    -0x4(%rbp),%ecx
    33a3:	48 63 c1             	movslq %ecx,%rax
    33a6:	48 69 c0 56 55 55 55 	imul   $0x55555556,%rax,%rax
    33ad:	48 c1 e8 20          	shr    $0x20,%rax
    33b1:	48 89 c2             	mov    %rax,%rdx
    33b4:	89 c8                	mov    %ecx,%eax
    33b6:	c1 f8 1f             	sar    $0x1f,%eax
    33b9:	29 c2                	sub    %eax,%edx
    33bb:	89 d0                	mov    %edx,%eax
    33bd:	01 c0                	add    %eax,%eax
    33bf:	01 d0                	add    %edx,%eax
    33c1:	29 c1                	sub    %eax,%ecx
    33c3:	89 ca                	mov    %ecx,%edx
    33c5:	83 fa 01             	cmp    $0x1,%edx
    33c8:	75 25                	jne    33ef <concreate+0xbf>
    33ca:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    33ce:	48 ba b4 79 00 00 00 	movabs $0x79b4,%rdx
    33d5:	00 00 00 
    33d8:	48 89 c6             	mov    %rax,%rsi
    33db:	48 89 d7             	mov    %rdx,%rdi
    33de:	48 b8 10 68 00 00 00 	movabs $0x6810,%rax
    33e5:	00 00 00 
    33e8:	ff d0                	call   *%rax
    33ea:	e9 bc 00 00 00       	jmp    34ab <concreate+0x17b>
    33ef:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    33f3:	75 4e                	jne    3443 <concreate+0x113>
    33f5:	8b 4d fc             	mov    -0x4(%rbp),%ecx
    33f8:	48 63 c1             	movslq %ecx,%rax
    33fb:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
    3402:	48 c1 e8 20          	shr    $0x20,%rax
    3406:	89 c2                	mov    %eax,%edx
    3408:	d1 fa                	sar    $1,%edx
    340a:	89 c8                	mov    %ecx,%eax
    340c:	c1 f8 1f             	sar    $0x1f,%eax
    340f:	29 c2                	sub    %eax,%edx
    3411:	89 d0                	mov    %edx,%eax
    3413:	c1 e0 02             	shl    $0x2,%eax
    3416:	01 d0                	add    %edx,%eax
    3418:	29 c1                	sub    %eax,%ecx
    341a:	89 ca                	mov    %ecx,%edx
    341c:	83 fa 01             	cmp    $0x1,%edx
    341f:	75 22                	jne    3443 <concreate+0x113>
    3421:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    3425:	48 ba b4 79 00 00 00 	movabs $0x79b4,%rdx
    342c:	00 00 00 
    342f:	48 89 c6             	mov    %rax,%rsi
    3432:	48 89 d7             	mov    %rdx,%rdi
    3435:	48 b8 10 68 00 00 00 	movabs $0x6810,%rax
    343c:	00 00 00 
    343f:	ff d0                	call   *%rax
    3441:	eb 68                	jmp    34ab <concreate+0x17b>
    3443:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    3447:	be 02 02 00 00       	mov    $0x202,%esi
    344c:	48 89 c7             	mov    %rax,%rdi
    344f:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    3456:	00 00 00 
    3459:	ff d0                	call   *%rax
    345b:	89 45 f4             	mov    %eax,-0xc(%rbp)
    345e:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    3462:	79 36                	jns    349a <concreate+0x16a>
    3464:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    3468:	48 b9 b7 79 00 00 00 	movabs $0x79b7,%rcx
    346f:	00 00 00 
    3472:	48 89 c2             	mov    %rax,%rdx
    3475:	48 89 ce             	mov    %rcx,%rsi
    3478:	bf 01 00 00 00       	mov    $0x1,%edi
    347d:	b8 00 00 00 00       	mov    $0x0,%eax
    3482:	48 b9 78 6a 00 00 00 	movabs $0x6a78,%rcx
    3489:	00 00 00 
    348c:	ff d1                	call   *%rcx
    348e:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    3495:	00 00 00 
    3498:	ff d0                	call   *%rax
    349a:	8b 45 f4             	mov    -0xc(%rbp),%eax
    349d:	89 c7                	mov    %eax,%edi
    349f:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    34a6:	00 00 00 
    34a9:	ff d0                	call   *%rax
    34ab:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    34af:	75 0c                	jne    34bd <concreate+0x18d>
    34b1:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    34b8:	00 00 00 
    34bb:	ff d0                	call   *%rax
    34bd:	48 b8 81 67 00 00 00 	movabs $0x6781,%rax
    34c4:	00 00 00 
    34c7:	ff d0                	call   *%rax
    34c9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    34cd:	83 7d fc 27          	cmpl   $0x27,-0x4(%rbp)
    34d1:	0f 8e 98 fe ff ff    	jle    336f <concreate+0x3f>
    34d7:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
    34db:	ba 28 00 00 00       	mov    $0x28,%edx
    34e0:	be 00 00 00 00       	mov    $0x0,%esi
    34e5:	48 89 c7             	mov    %rax,%rdi
    34e8:	48 b8 3f 65 00 00 00 	movabs $0x653f,%rax
    34ef:	00 00 00 
    34f2:	ff d0                	call   *%rax
    34f4:	48 b8 7a 79 00 00 00 	movabs $0x797a,%rax
    34fb:	00 00 00 
    34fe:	be 00 00 00 00       	mov    $0x0,%esi
    3503:	48 89 c7             	mov    %rax,%rdi
    3506:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    350d:	00 00 00 
    3510:	ff d0                	call   *%rax
    3512:	89 45 f4             	mov    %eax,-0xc(%rbp)
    3515:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
    351c:	e9 cd 00 00 00       	jmp    35ee <concreate+0x2be>
    3521:	0f b7 45 b0          	movzwl -0x50(%rbp),%eax
    3525:	66 85 c0             	test   %ax,%ax
    3528:	0f 84 bf 00 00 00    	je     35ed <concreate+0x2bd>
    352e:	0f b6 45 b2          	movzbl -0x4e(%rbp),%eax
    3532:	3c 43                	cmp    $0x43,%al
    3534:	0f 85 b4 00 00 00    	jne    35ee <concreate+0x2be>
    353a:	0f b6 45 b4          	movzbl -0x4c(%rbp),%eax
    353e:	84 c0                	test   %al,%al
    3540:	0f 85 a8 00 00 00    	jne    35ee <concreate+0x2be>
    3546:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
    354a:	0f be c0             	movsbl %al,%eax
    354d:	83 e8 30             	sub    $0x30,%eax
    3550:	89 45 fc             	mov    %eax,-0x4(%rbp)
    3553:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    3557:	78 08                	js     3561 <concreate+0x231>
    3559:	8b 45 fc             	mov    -0x4(%rbp),%eax
    355c:	83 f8 27             	cmp    $0x27,%eax
    355f:	76 37                	jbe    3598 <concreate+0x268>
    3561:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
    3565:	48 8d 50 02          	lea    0x2(%rax),%rdx
    3569:	48 b8 d3 79 00 00 00 	movabs $0x79d3,%rax
    3570:	00 00 00 
    3573:	48 89 c6             	mov    %rax,%rsi
    3576:	bf 01 00 00 00       	mov    $0x1,%edi
    357b:	b8 00 00 00 00       	mov    $0x0,%eax
    3580:	48 b9 78 6a 00 00 00 	movabs $0x6a78,%rcx
    3587:	00 00 00 
    358a:	ff d1                	call   *%rcx
    358c:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    3593:	00 00 00 
    3596:	ff d0                	call   *%rax
    3598:	8b 45 fc             	mov    -0x4(%rbp),%eax
    359b:	48 98                	cltq
    359d:	0f b6 44 05 c0       	movzbl -0x40(%rbp,%rax,1),%eax
    35a2:	84 c0                	test   %al,%al
    35a4:	74 37                	je     35dd <concreate+0x2ad>
    35a6:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
    35aa:	48 8d 50 02          	lea    0x2(%rax),%rdx
    35ae:	48 b8 ec 79 00 00 00 	movabs $0x79ec,%rax
    35b5:	00 00 00 
    35b8:	48 89 c6             	mov    %rax,%rsi
    35bb:	bf 01 00 00 00       	mov    $0x1,%edi
    35c0:	b8 00 00 00 00       	mov    $0x0,%eax
    35c5:	48 b9 78 6a 00 00 00 	movabs $0x6a78,%rcx
    35cc:	00 00 00 
    35cf:	ff d1                	call   *%rcx
    35d1:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    35d8:	00 00 00 
    35db:	ff d0                	call   *%rax
    35dd:	8b 45 fc             	mov    -0x4(%rbp),%eax
    35e0:	48 98                	cltq
    35e2:	c6 44 05 c0 01       	movb   $0x1,-0x40(%rbp,%rax,1)
    35e7:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    35eb:	eb 01                	jmp    35ee <concreate+0x2be>
    35ed:	90                   	nop
    35ee:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
    35f2:	8b 45 f4             	mov    -0xc(%rbp),%eax
    35f5:	ba 10 00 00 00       	mov    $0x10,%edx
    35fa:	48 89 ce             	mov    %rcx,%rsi
    35fd:	89 c7                	mov    %eax,%edi
    35ff:	48 b8 9b 67 00 00 00 	movabs $0x679b,%rax
    3606:	00 00 00 
    3609:	ff d0                	call   *%rax
    360b:	85 c0                	test   %eax,%eax
    360d:	0f 8f 0e ff ff ff    	jg     3521 <concreate+0x1f1>
    3613:	8b 45 f4             	mov    -0xc(%rbp),%eax
    3616:	89 c7                	mov    %eax,%edi
    3618:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    361f:	00 00 00 
    3622:	ff d0                	call   *%rax
    3624:	83 7d f8 28          	cmpl   $0x28,-0x8(%rbp)
    3628:	74 19                	je     3643 <concreate+0x313>
    362a:	48 b8 10 7a 00 00 00 	movabs $0x7a10,%rax
    3631:	00 00 00 
    3634:	48 89 c7             	mov    %rax,%rdi
    3637:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    363e:	00 00 00 
    3641:	ff d0                	call   *%rax
    3643:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    364a:	e9 a6 01 00 00       	jmp    37f5 <concreate+0x4c5>
    364f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3652:	83 c0 30             	add    $0x30,%eax
    3655:	88 45 ee             	mov    %al,-0x12(%rbp)
    3658:	48 b8 67 67 00 00 00 	movabs $0x6767,%rax
    365f:	00 00 00 
    3662:	ff d0                	call   *%rax
    3664:	89 45 f0             	mov    %eax,-0x10(%rbp)
    3667:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    366b:	79 19                	jns    3686 <concreate+0x356>
    366d:	48 b8 0f 72 00 00 00 	movabs $0x720f,%rax
    3674:	00 00 00 
    3677:	48 89 c7             	mov    %rax,%rdi
    367a:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3681:	00 00 00 
    3684:	ff d0                	call   *%rax
    3686:	8b 4d fc             	mov    -0x4(%rbp),%ecx
    3689:	48 63 c1             	movslq %ecx,%rax
    368c:	48 69 c0 56 55 55 55 	imul   $0x55555556,%rax,%rax
    3693:	48 c1 e8 20          	shr    $0x20,%rax
    3697:	48 89 c2             	mov    %rax,%rdx
    369a:	89 c8                	mov    %ecx,%eax
    369c:	c1 f8 1f             	sar    $0x1f,%eax
    369f:	29 c2                	sub    %eax,%edx
    36a1:	89 d0                	mov    %edx,%eax
    36a3:	01 c0                	add    %eax,%eax
    36a5:	01 d0                	add    %edx,%eax
    36a7:	29 c1                	sub    %eax,%ecx
    36a9:	89 ca                	mov    %ecx,%edx
    36ab:	85 d2                	test   %edx,%edx
    36ad:	75 06                	jne    36b5 <concreate+0x385>
    36af:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    36b3:	74 38                	je     36ed <concreate+0x3bd>
    36b5:	8b 4d fc             	mov    -0x4(%rbp),%ecx
    36b8:	48 63 c1             	movslq %ecx,%rax
    36bb:	48 69 c0 56 55 55 55 	imul   $0x55555556,%rax,%rax
    36c2:	48 c1 e8 20          	shr    $0x20,%rax
    36c6:	48 89 c2             	mov    %rax,%rdx
    36c9:	89 c8                	mov    %ecx,%eax
    36cb:	c1 f8 1f             	sar    $0x1f,%eax
    36ce:	29 c2                	sub    %eax,%edx
    36d0:	89 d0                	mov    %edx,%eax
    36d2:	01 c0                	add    %eax,%eax
    36d4:	01 d0                	add    %edx,%eax
    36d6:	29 c1                	sub    %eax,%ecx
    36d8:	89 ca                	mov    %ecx,%edx
    36da:	83 fa 01             	cmp    $0x1,%edx
    36dd:	0f 85 a4 00 00 00    	jne    3787 <concreate+0x457>
    36e3:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    36e7:	0f 84 9a 00 00 00    	je     3787 <concreate+0x457>
    36ed:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    36f1:	be 00 00 00 00       	mov    $0x0,%esi
    36f6:	48 89 c7             	mov    %rax,%rdi
    36f9:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    3700:	00 00 00 
    3703:	ff d0                	call   *%rax
    3705:	89 c7                	mov    %eax,%edi
    3707:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    370e:	00 00 00 
    3711:	ff d0                	call   *%rax
    3713:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    3717:	be 00 00 00 00       	mov    $0x0,%esi
    371c:	48 89 c7             	mov    %rax,%rdi
    371f:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    3726:	00 00 00 
    3729:	ff d0                	call   *%rax
    372b:	89 c7                	mov    %eax,%edi
    372d:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    3734:	00 00 00 
    3737:	ff d0                	call   *%rax
    3739:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    373d:	be 00 00 00 00       	mov    $0x0,%esi
    3742:	48 89 c7             	mov    %rax,%rdi
    3745:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    374c:	00 00 00 
    374f:	ff d0                	call   *%rax
    3751:	89 c7                	mov    %eax,%edi
    3753:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    375a:	00 00 00 
    375d:	ff d0                	call   *%rax
    375f:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    3763:	be 00 00 00 00       	mov    $0x0,%esi
    3768:	48 89 c7             	mov    %rax,%rdi
    376b:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    3772:	00 00 00 
    3775:	ff d0                	call   *%rax
    3777:	89 c7                	mov    %eax,%edi
    3779:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    3780:	00 00 00 
    3783:	ff d0                	call   *%rax
    3785:	eb 4c                	jmp    37d3 <concreate+0x4a3>
    3787:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    378b:	48 89 c7             	mov    %rax,%rdi
    378e:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    3795:	00 00 00 
    3798:	ff d0                	call   *%rax
    379a:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    379e:	48 89 c7             	mov    %rax,%rdi
    37a1:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    37a8:	00 00 00 
    37ab:	ff d0                	call   *%rax
    37ad:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    37b1:	48 89 c7             	mov    %rax,%rdi
    37b4:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    37bb:	00 00 00 
    37be:	ff d0                	call   *%rax
    37c0:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    37c4:	48 89 c7             	mov    %rax,%rdi
    37c7:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    37ce:	00 00 00 
    37d1:	ff d0                	call   *%rax
    37d3:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    37d7:	75 0c                	jne    37e5 <concreate+0x4b5>
    37d9:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    37e0:	00 00 00 
    37e3:	ff d0                	call   *%rax
    37e5:	48 b8 81 67 00 00 00 	movabs $0x6781,%rax
    37ec:	00 00 00 
    37ef:	ff d0                	call   *%rax
    37f1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    37f5:	83 7d fc 27          	cmpl   $0x27,-0x4(%rbp)
    37f9:	0f 8e 50 fe ff ff    	jle    364f <concreate+0x31f>
    37ff:	48 b8 40 7a 00 00 00 	movabs $0x7a40,%rax
    3806:	00 00 00 
    3809:	48 89 c6             	mov    %rax,%rsi
    380c:	bf 01 00 00 00       	mov    $0x1,%edi
    3811:	b8 00 00 00 00       	mov    $0x0,%eax
    3816:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    381d:	00 00 00 
    3820:	ff d2                	call   *%rdx
    3822:	90                   	nop
    3823:	c9                   	leave
    3824:	c3                   	ret

0000000000003825 <linkunlink>:
    3825:	55                   	push   %rbp
    3826:	48 89 e5             	mov    %rsp,%rbp
    3829:	48 83 ec 10          	sub    $0x10,%rsp
    382d:	48 b8 4e 7a 00 00 00 	movabs $0x7a4e,%rax
    3834:	00 00 00 
    3837:	48 89 c6             	mov    %rax,%rsi
    383a:	bf 01 00 00 00       	mov    $0x1,%edi
    383f:	b8 00 00 00 00       	mov    $0x0,%eax
    3844:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    384b:	00 00 00 
    384e:	ff d2                	call   *%rdx
    3850:	48 b8 fe 75 00 00 00 	movabs $0x75fe,%rax
    3857:	00 00 00 
    385a:	48 89 c7             	mov    %rax,%rdi
    385d:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    3864:	00 00 00 
    3867:	ff d0                	call   *%rax
    3869:	48 b8 67 67 00 00 00 	movabs $0x6767,%rax
    3870:	00 00 00 
    3873:	ff d0                	call   *%rax
    3875:	89 45 f4             	mov    %eax,-0xc(%rbp)
    3878:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    387c:	79 19                	jns    3897 <linkunlink+0x72>
    387e:	48 b8 0f 72 00 00 00 	movabs $0x720f,%rax
    3885:	00 00 00 
    3888:	48 89 c7             	mov    %rax,%rdi
    388b:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3892:	00 00 00 
    3895:	ff d0                	call   *%rax
    3897:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    389b:	74 09                	je     38a6 <linkunlink+0x81>
    389d:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    38a4:	eb 07                	jmp    38ad <linkunlink+0x88>
    38a6:	c7 45 f8 61 00 00 00 	movl   $0x61,-0x8(%rbp)
    38ad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    38b4:	e9 cd 00 00 00       	jmp    3986 <linkunlink+0x161>
    38b9:	8b 45 f8             	mov    -0x8(%rbp),%eax
    38bc:	69 c0 6d 4e c6 41    	imul   $0x41c64e6d,%eax,%eax
    38c2:	05 39 30 00 00       	add    $0x3039,%eax
    38c7:	89 45 f8             	mov    %eax,-0x8(%rbp)
    38ca:	8b 4d f8             	mov    -0x8(%rbp),%ecx
    38cd:	89 ca                	mov    %ecx,%edx
    38cf:	b8 ab aa aa aa       	mov    $0xaaaaaaab,%eax
    38d4:	48 0f af c2          	imul   %rdx,%rax
    38d8:	48 c1 e8 20          	shr    $0x20,%rax
    38dc:	89 c2                	mov    %eax,%edx
    38de:	d1 ea                	shr    $1,%edx
    38e0:	89 d0                	mov    %edx,%eax
    38e2:	01 c0                	add    %eax,%eax
    38e4:	01 d0                	add    %edx,%eax
    38e6:	29 c1                	sub    %eax,%ecx
    38e8:	89 ca                	mov    %ecx,%edx
    38ea:	85 d2                	test   %edx,%edx
    38ec:	75 2e                	jne    391c <linkunlink+0xf7>
    38ee:	48 b8 fe 75 00 00 00 	movabs $0x75fe,%rax
    38f5:	00 00 00 
    38f8:	be 02 02 00 00       	mov    $0x202,%esi
    38fd:	48 89 c7             	mov    %rax,%rdi
    3900:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    3907:	00 00 00 
    390a:	ff d0                	call   *%rax
    390c:	89 c7                	mov    %eax,%edi
    390e:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    3915:	00 00 00 
    3918:	ff d0                	call   *%rax
    391a:	eb 66                	jmp    3982 <linkunlink+0x15d>
    391c:	8b 4d f8             	mov    -0x8(%rbp),%ecx
    391f:	89 ca                	mov    %ecx,%edx
    3921:	b8 ab aa aa aa       	mov    $0xaaaaaaab,%eax
    3926:	48 0f af c2          	imul   %rdx,%rax
    392a:	48 c1 e8 20          	shr    $0x20,%rax
    392e:	89 c2                	mov    %eax,%edx
    3930:	d1 ea                	shr    $1,%edx
    3932:	89 d0                	mov    %edx,%eax
    3934:	01 c0                	add    %eax,%eax
    3936:	01 d0                	add    %edx,%eax
    3938:	29 c1                	sub    %eax,%ecx
    393a:	89 ca                	mov    %ecx,%edx
    393c:	83 fa 01             	cmp    $0x1,%edx
    393f:	75 28                	jne    3969 <linkunlink+0x144>
    3941:	48 ba fe 75 00 00 00 	movabs $0x75fe,%rdx
    3948:	00 00 00 
    394b:	48 b8 5f 7a 00 00 00 	movabs $0x7a5f,%rax
    3952:	00 00 00 
    3955:	48 89 d6             	mov    %rdx,%rsi
    3958:	48 89 c7             	mov    %rax,%rdi
    395b:	48 b8 10 68 00 00 00 	movabs $0x6810,%rax
    3962:	00 00 00 
    3965:	ff d0                	call   *%rax
    3967:	eb 19                	jmp    3982 <linkunlink+0x15d>
    3969:	48 b8 fe 75 00 00 00 	movabs $0x75fe,%rax
    3970:	00 00 00 
    3973:	48 89 c7             	mov    %rax,%rdi
    3976:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    397d:	00 00 00 
    3980:	ff d0                	call   *%rax
    3982:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    3986:	83 7d fc 63          	cmpl   $0x63,-0x4(%rbp)
    398a:	0f 8e 29 ff ff ff    	jle    38b9 <linkunlink+0x94>
    3990:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    3994:	74 0e                	je     39a4 <linkunlink+0x17f>
    3996:	48 b8 81 67 00 00 00 	movabs $0x6781,%rax
    399d:	00 00 00 
    39a0:	ff d0                	call   *%rax
    39a2:	eb 0c                	jmp    39b0 <linkunlink+0x18b>
    39a4:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    39ab:	00 00 00 
    39ae:	ff d0                	call   *%rax
    39b0:	48 b8 63 7a 00 00 00 	movabs $0x7a63,%rax
    39b7:	00 00 00 
    39ba:	48 89 c6             	mov    %rax,%rsi
    39bd:	bf 01 00 00 00       	mov    $0x1,%edi
    39c2:	b8 00 00 00 00       	mov    $0x0,%eax
    39c7:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    39ce:	00 00 00 
    39d1:	ff d2                	call   *%rdx
    39d3:	90                   	nop
    39d4:	c9                   	leave
    39d5:	c3                   	ret

00000000000039d6 <bigdir>:
    39d6:	55                   	push   %rbp
    39d7:	48 89 e5             	mov    %rsp,%rbp
    39da:	48 83 ec 20          	sub    $0x20,%rsp
    39de:	48 b8 72 7a 00 00 00 	movabs $0x7a72,%rax
    39e5:	00 00 00 
    39e8:	48 89 c6             	mov    %rax,%rsi
    39eb:	bf 01 00 00 00       	mov    $0x1,%edi
    39f0:	b8 00 00 00 00       	mov    $0x0,%eax
    39f5:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    39fc:	00 00 00 
    39ff:	ff d2                	call   *%rdx
    3a01:	48 b8 7f 7a 00 00 00 	movabs $0x7a7f,%rax
    3a08:	00 00 00 
    3a0b:	48 89 c7             	mov    %rax,%rdi
    3a0e:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    3a15:	00 00 00 
    3a18:	ff d0                	call   *%rax
    3a1a:	48 b8 7f 7a 00 00 00 	movabs $0x7a7f,%rax
    3a21:	00 00 00 
    3a24:	be 00 02 00 00       	mov    $0x200,%esi
    3a29:	48 89 c7             	mov    %rax,%rdi
    3a2c:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    3a33:	00 00 00 
    3a36:	ff d0                	call   *%rax
    3a38:	89 45 f8             	mov    %eax,-0x8(%rbp)
    3a3b:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    3a3f:	79 19                	jns    3a5a <bigdir+0x84>
    3a41:	48 b8 82 7a 00 00 00 	movabs $0x7a82,%rax
    3a48:	00 00 00 
    3a4b:	48 89 c7             	mov    %rax,%rdi
    3a4e:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3a55:	00 00 00 
    3a58:	ff d0                	call   *%rax
    3a5a:	8b 45 f8             	mov    -0x8(%rbp),%eax
    3a5d:	89 c7                	mov    %eax,%edi
    3a5f:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    3a66:	00 00 00 
    3a69:	ff d0                	call   *%rax
    3a6b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    3a72:	eb 77                	jmp    3aeb <bigdir+0x115>
    3a74:	c6 45 ee 78          	movb   $0x78,-0x12(%rbp)
    3a78:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3a7b:	8d 50 3f             	lea    0x3f(%rax),%edx
    3a7e:	85 c0                	test   %eax,%eax
    3a80:	0f 48 c2             	cmovs  %edx,%eax
    3a83:	c1 f8 06             	sar    $0x6,%eax
    3a86:	83 c0 30             	add    $0x30,%eax
    3a89:	88 45 ef             	mov    %al,-0x11(%rbp)
    3a8c:	8b 55 fc             	mov    -0x4(%rbp),%edx
    3a8f:	89 d0                	mov    %edx,%eax
    3a91:	c1 f8 1f             	sar    $0x1f,%eax
    3a94:	c1 e8 1a             	shr    $0x1a,%eax
    3a97:	01 c2                	add    %eax,%edx
    3a99:	83 e2 3f             	and    $0x3f,%edx
    3a9c:	29 c2                	sub    %eax,%edx
    3a9e:	89 d0                	mov    %edx,%eax
    3aa0:	83 c0 30             	add    $0x30,%eax
    3aa3:	88 45 f0             	mov    %al,-0x10(%rbp)
    3aa6:	c6 45 f1 00          	movb   $0x0,-0xf(%rbp)
    3aaa:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
    3aae:	48 ba 7f 7a 00 00 00 	movabs $0x7a7f,%rdx
    3ab5:	00 00 00 
    3ab8:	48 89 c6             	mov    %rax,%rsi
    3abb:	48 89 d7             	mov    %rdx,%rdi
    3abe:	48 b8 10 68 00 00 00 	movabs $0x6810,%rax
    3ac5:	00 00 00 
    3ac8:	ff d0                	call   *%rax
    3aca:	85 c0                	test   %eax,%eax
    3acc:	74 19                	je     3ae7 <bigdir+0x111>
    3ace:	48 b8 90 7a 00 00 00 	movabs $0x7a90,%rax
    3ad5:	00 00 00 
    3ad8:	48 89 c7             	mov    %rax,%rdi
    3adb:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3ae2:	00 00 00 
    3ae5:	ff d0                	call   *%rax
    3ae7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    3aeb:	81 7d fc f3 01 00 00 	cmpl   $0x1f3,-0x4(%rbp)
    3af2:	7e 80                	jle    3a74 <bigdir+0x9e>
    3af4:	48 b8 7f 7a 00 00 00 	movabs $0x7a7f,%rax
    3afb:	00 00 00 
    3afe:	48 89 c7             	mov    %rax,%rdi
    3b01:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    3b08:	00 00 00 
    3b0b:	ff d0                	call   *%rax
    3b0d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    3b14:	eb 6a                	jmp    3b80 <bigdir+0x1aa>
    3b16:	c6 45 ee 78          	movb   $0x78,-0x12(%rbp)
    3b1a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3b1d:	8d 50 3f             	lea    0x3f(%rax),%edx
    3b20:	85 c0                	test   %eax,%eax
    3b22:	0f 48 c2             	cmovs  %edx,%eax
    3b25:	c1 f8 06             	sar    $0x6,%eax
    3b28:	83 c0 30             	add    $0x30,%eax
    3b2b:	88 45 ef             	mov    %al,-0x11(%rbp)
    3b2e:	8b 55 fc             	mov    -0x4(%rbp),%edx
    3b31:	89 d0                	mov    %edx,%eax
    3b33:	c1 f8 1f             	sar    $0x1f,%eax
    3b36:	c1 e8 1a             	shr    $0x1a,%eax
    3b39:	01 c2                	add    %eax,%edx
    3b3b:	83 e2 3f             	and    $0x3f,%edx
    3b3e:	29 c2                	sub    %eax,%edx
    3b40:	89 d0                	mov    %edx,%eax
    3b42:	83 c0 30             	add    $0x30,%eax
    3b45:	88 45 f0             	mov    %al,-0x10(%rbp)
    3b48:	c6 45 f1 00          	movb   $0x0,-0xf(%rbp)
    3b4c:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
    3b50:	48 89 c7             	mov    %rax,%rdi
    3b53:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    3b5a:	00 00 00 
    3b5d:	ff d0                	call   *%rax
    3b5f:	85 c0                	test   %eax,%eax
    3b61:	74 19                	je     3b7c <bigdir+0x1a6>
    3b63:	48 b8 9c 7a 00 00 00 	movabs $0x7a9c,%rax
    3b6a:	00 00 00 
    3b6d:	48 89 c7             	mov    %rax,%rdi
    3b70:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3b77:	00 00 00 
    3b7a:	ff d0                	call   *%rax
    3b7c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    3b80:	81 7d fc f3 01 00 00 	cmpl   $0x1f3,-0x4(%rbp)
    3b87:	7e 8d                	jle    3b16 <bigdir+0x140>
    3b89:	48 b8 b1 7a 00 00 00 	movabs $0x7ab1,%rax
    3b90:	00 00 00 
    3b93:	48 89 c6             	mov    %rax,%rsi
    3b96:	bf 01 00 00 00       	mov    $0x1,%edi
    3b9b:	b8 00 00 00 00       	mov    $0x0,%eax
    3ba0:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    3ba7:	00 00 00 
    3baa:	ff d2                	call   *%rdx
    3bac:	90                   	nop
    3bad:	c9                   	leave
    3bae:	c3                   	ret

0000000000003baf <subdir>:
    3baf:	55                   	push   %rbp
    3bb0:	48 89 e5             	mov    %rsp,%rbp
    3bb3:	48 83 ec 10          	sub    $0x10,%rsp
    3bb7:	48 b8 bc 7a 00 00 00 	movabs $0x7abc,%rax
    3bbe:	00 00 00 
    3bc1:	48 89 c6             	mov    %rax,%rsi
    3bc4:	bf 01 00 00 00       	mov    $0x1,%edi
    3bc9:	b8 00 00 00 00       	mov    $0x0,%eax
    3bce:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    3bd5:	00 00 00 
    3bd8:	ff d2                	call   *%rdx
    3bda:	48 b8 c9 7a 00 00 00 	movabs $0x7ac9,%rax
    3be1:	00 00 00 
    3be4:	48 89 c7             	mov    %rax,%rdi
    3be7:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    3bee:	00 00 00 
    3bf1:	ff d0                	call   *%rax
    3bf3:	48 b8 cc 7a 00 00 00 	movabs $0x7acc,%rax
    3bfa:	00 00 00 
    3bfd:	48 89 c7             	mov    %rax,%rdi
    3c00:	48 b8 1d 68 00 00 00 	movabs $0x681d,%rax
    3c07:	00 00 00 
    3c0a:	ff d0                	call   *%rax
    3c0c:	85 c0                	test   %eax,%eax
    3c0e:	74 19                	je     3c29 <subdir+0x7a>
    3c10:	48 b8 cf 7a 00 00 00 	movabs $0x7acf,%rax
    3c17:	00 00 00 
    3c1a:	48 89 c7             	mov    %rax,%rdi
    3c1d:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3c24:	00 00 00 
    3c27:	ff d0                	call   *%rax
    3c29:	48 b8 df 7a 00 00 00 	movabs $0x7adf,%rax
    3c30:	00 00 00 
    3c33:	be 02 02 00 00       	mov    $0x202,%esi
    3c38:	48 89 c7             	mov    %rax,%rdi
    3c3b:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    3c42:	00 00 00 
    3c45:	ff d0                	call   *%rax
    3c47:	89 45 fc             	mov    %eax,-0x4(%rbp)
    3c4a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    3c4e:	79 19                	jns    3c69 <subdir+0xba>
    3c50:	48 b8 e5 7a 00 00 00 	movabs $0x7ae5,%rax
    3c57:	00 00 00 
    3c5a:	48 89 c7             	mov    %rax,%rdi
    3c5d:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3c64:	00 00 00 
    3c67:	ff d0                	call   *%rax
    3c69:	48 b9 c9 7a 00 00 00 	movabs $0x7ac9,%rcx
    3c70:	00 00 00 
    3c73:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3c76:	ba 02 00 00 00       	mov    $0x2,%edx
    3c7b:	48 89 ce             	mov    %rcx,%rsi
    3c7e:	89 c7                	mov    %eax,%edi
    3c80:	48 b8 a8 67 00 00 00 	movabs $0x67a8,%rax
    3c87:	00 00 00 
    3c8a:	ff d0                	call   *%rax
    3c8c:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3c8f:	89 c7                	mov    %eax,%edi
    3c91:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    3c98:	00 00 00 
    3c9b:	ff d0                	call   *%rax
    3c9d:	48 b8 cc 7a 00 00 00 	movabs $0x7acc,%rax
    3ca4:	00 00 00 
    3ca7:	48 89 c7             	mov    %rax,%rdi
    3caa:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    3cb1:	00 00 00 
    3cb4:	ff d0                	call   *%rax
    3cb6:	85 c0                	test   %eax,%eax
    3cb8:	78 19                	js     3cd3 <subdir+0x124>
    3cba:	48 b8 f8 7a 00 00 00 	movabs $0x7af8,%rax
    3cc1:	00 00 00 
    3cc4:	48 89 c7             	mov    %rax,%rdi
    3cc7:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3cce:	00 00 00 
    3cd1:	ff d0                	call   *%rax
    3cd3:	48 b8 1d 7b 00 00 00 	movabs $0x7b1d,%rax
    3cda:	00 00 00 
    3cdd:	48 89 c7             	mov    %rax,%rdi
    3ce0:	48 b8 1d 68 00 00 00 	movabs $0x681d,%rax
    3ce7:	00 00 00 
    3cea:	ff d0                	call   *%rax
    3cec:	85 c0                	test   %eax,%eax
    3cee:	74 19                	je     3d09 <subdir+0x15a>
    3cf0:	48 b8 24 7b 00 00 00 	movabs $0x7b24,%rax
    3cf7:	00 00 00 
    3cfa:	48 89 c7             	mov    %rax,%rdi
    3cfd:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3d04:	00 00 00 
    3d07:	ff d0                	call   *%rax
    3d09:	48 b8 37 7b 00 00 00 	movabs $0x7b37,%rax
    3d10:	00 00 00 
    3d13:	be 02 02 00 00       	mov    $0x202,%esi
    3d18:	48 89 c7             	mov    %rax,%rdi
    3d1b:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    3d22:	00 00 00 
    3d25:	ff d0                	call   *%rax
    3d27:	89 45 fc             	mov    %eax,-0x4(%rbp)
    3d2a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    3d2e:	79 19                	jns    3d49 <subdir+0x19a>
    3d30:	48 b8 40 7b 00 00 00 	movabs $0x7b40,%rax
    3d37:	00 00 00 
    3d3a:	48 89 c7             	mov    %rax,%rdi
    3d3d:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3d44:	00 00 00 
    3d47:	ff d0                	call   *%rax
    3d49:	48 b9 50 7b 00 00 00 	movabs $0x7b50,%rcx
    3d50:	00 00 00 
    3d53:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3d56:	ba 02 00 00 00       	mov    $0x2,%edx
    3d5b:	48 89 ce             	mov    %rcx,%rsi
    3d5e:	89 c7                	mov    %eax,%edi
    3d60:	48 b8 a8 67 00 00 00 	movabs $0x67a8,%rax
    3d67:	00 00 00 
    3d6a:	ff d0                	call   *%rax
    3d6c:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3d6f:	89 c7                	mov    %eax,%edi
    3d71:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    3d78:	00 00 00 
    3d7b:	ff d0                	call   *%rax
    3d7d:	48 b8 53 7b 00 00 00 	movabs $0x7b53,%rax
    3d84:	00 00 00 
    3d87:	be 00 00 00 00       	mov    $0x0,%esi
    3d8c:	48 89 c7             	mov    %rax,%rdi
    3d8f:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    3d96:	00 00 00 
    3d99:	ff d0                	call   *%rax
    3d9b:	89 45 fc             	mov    %eax,-0x4(%rbp)
    3d9e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    3da2:	79 19                	jns    3dbd <subdir+0x20e>
    3da4:	48 b8 5f 7b 00 00 00 	movabs $0x7b5f,%rax
    3dab:	00 00 00 
    3dae:	48 89 c7             	mov    %rax,%rdi
    3db1:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3db8:	00 00 00 
    3dbb:	ff d0                	call   *%rax
    3dbd:	48 b9 20 89 00 00 00 	movabs $0x8920,%rcx
    3dc4:	00 00 00 
    3dc7:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3dca:	ba 00 20 00 00       	mov    $0x2000,%edx
    3dcf:	48 89 ce             	mov    %rcx,%rsi
    3dd2:	89 c7                	mov    %eax,%edi
    3dd4:	48 b8 9b 67 00 00 00 	movabs $0x679b,%rax
    3ddb:	00 00 00 
    3dde:	ff d0                	call   *%rax
    3de0:	89 45 f8             	mov    %eax,-0x8(%rbp)
    3de3:	83 7d f8 02          	cmpl   $0x2,-0x8(%rbp)
    3de7:	75 11                	jne    3dfa <subdir+0x24b>
    3de9:	48 b8 20 89 00 00 00 	movabs $0x8920,%rax
    3df0:	00 00 00 
    3df3:	0f b6 00             	movzbl (%rax),%eax
    3df6:	3c 66                	cmp    $0x66,%al
    3df8:	74 19                	je     3e13 <subdir+0x264>
    3dfa:	48 b8 70 7b 00 00 00 	movabs $0x7b70,%rax
    3e01:	00 00 00 
    3e04:	48 89 c7             	mov    %rax,%rdi
    3e07:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3e0e:	00 00 00 
    3e11:	ff d0                	call   *%rax
    3e13:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3e16:	89 c7                	mov    %eax,%edi
    3e18:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    3e1f:	00 00 00 
    3e22:	ff d0                	call   *%rax
    3e24:	48 ba 8a 7b 00 00 00 	movabs $0x7b8a,%rdx
    3e2b:	00 00 00 
    3e2e:	48 b8 37 7b 00 00 00 	movabs $0x7b37,%rax
    3e35:	00 00 00 
    3e38:	48 89 d6             	mov    %rdx,%rsi
    3e3b:	48 89 c7             	mov    %rax,%rdi
    3e3e:	48 b8 10 68 00 00 00 	movabs $0x6810,%rax
    3e45:	00 00 00 
    3e48:	ff d0                	call   *%rax
    3e4a:	85 c0                	test   %eax,%eax
    3e4c:	74 19                	je     3e67 <subdir+0x2b8>
    3e4e:	48 b8 95 7b 00 00 00 	movabs $0x7b95,%rax
    3e55:	00 00 00 
    3e58:	48 89 c7             	mov    %rax,%rdi
    3e5b:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3e62:	00 00 00 
    3e65:	ff d0                	call   *%rax
    3e67:	48 b8 37 7b 00 00 00 	movabs $0x7b37,%rax
    3e6e:	00 00 00 
    3e71:	48 89 c7             	mov    %rax,%rdi
    3e74:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    3e7b:	00 00 00 
    3e7e:	ff d0                	call   *%rax
    3e80:	85 c0                	test   %eax,%eax
    3e82:	74 19                	je     3e9d <subdir+0x2ee>
    3e84:	48 b8 ae 7b 00 00 00 	movabs $0x7bae,%rax
    3e8b:	00 00 00 
    3e8e:	48 89 c7             	mov    %rax,%rdi
    3e91:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3e98:	00 00 00 
    3e9b:	ff d0                	call   *%rax
    3e9d:	48 b8 37 7b 00 00 00 	movabs $0x7b37,%rax
    3ea4:	00 00 00 
    3ea7:	be 00 00 00 00       	mov    $0x0,%esi
    3eac:	48 89 c7             	mov    %rax,%rdi
    3eaf:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    3eb6:	00 00 00 
    3eb9:	ff d0                	call   *%rax
    3ebb:	85 c0                	test   %eax,%eax
    3ebd:	78 19                	js     3ed8 <subdir+0x329>
    3ebf:	48 b8 c0 7b 00 00 00 	movabs $0x7bc0,%rax
    3ec6:	00 00 00 
    3ec9:	48 89 c7             	mov    %rax,%rdi
    3ecc:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3ed3:	00 00 00 
    3ed6:	ff d0                	call   *%rax
    3ed8:	48 b8 cc 7a 00 00 00 	movabs $0x7acc,%rax
    3edf:	00 00 00 
    3ee2:	48 89 c7             	mov    %rax,%rdi
    3ee5:	48 b8 2a 68 00 00 00 	movabs $0x682a,%rax
    3eec:	00 00 00 
    3eef:	ff d0                	call   *%rax
    3ef1:	85 c0                	test   %eax,%eax
    3ef3:	74 19                	je     3f0e <subdir+0x35f>
    3ef5:	48 b8 e3 7b 00 00 00 	movabs $0x7be3,%rax
    3efc:	00 00 00 
    3eff:	48 89 c7             	mov    %rax,%rdi
    3f02:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3f09:	00 00 00 
    3f0c:	ff d0                	call   *%rax
    3f0e:	48 b8 ec 7b 00 00 00 	movabs $0x7bec,%rax
    3f15:	00 00 00 
    3f18:	48 89 c7             	mov    %rax,%rdi
    3f1b:	48 b8 2a 68 00 00 00 	movabs $0x682a,%rax
    3f22:	00 00 00 
    3f25:	ff d0                	call   *%rax
    3f27:	85 c0                	test   %eax,%eax
    3f29:	74 19                	je     3f44 <subdir+0x395>
    3f2b:	48 b8 f8 7b 00 00 00 	movabs $0x7bf8,%rax
    3f32:	00 00 00 
    3f35:	48 89 c7             	mov    %rax,%rdi
    3f38:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3f3f:	00 00 00 
    3f42:	ff d0                	call   *%rax
    3f44:	48 b8 0a 7c 00 00 00 	movabs $0x7c0a,%rax
    3f4b:	00 00 00 
    3f4e:	48 89 c7             	mov    %rax,%rdi
    3f51:	48 b8 2a 68 00 00 00 	movabs $0x682a,%rax
    3f58:	00 00 00 
    3f5b:	ff d0                	call   *%rax
    3f5d:	85 c0                	test   %eax,%eax
    3f5f:	74 19                	je     3f7a <subdir+0x3cb>
    3f61:	48 b8 f8 7b 00 00 00 	movabs $0x7bf8,%rax
    3f68:	00 00 00 
    3f6b:	48 89 c7             	mov    %rax,%rdi
    3f6e:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3f75:	00 00 00 
    3f78:	ff d0                	call   *%rax
    3f7a:	48 b8 19 7c 00 00 00 	movabs $0x7c19,%rax
    3f81:	00 00 00 
    3f84:	48 89 c7             	mov    %rax,%rdi
    3f87:	48 b8 2a 68 00 00 00 	movabs $0x682a,%rax
    3f8e:	00 00 00 
    3f91:	ff d0                	call   *%rax
    3f93:	85 c0                	test   %eax,%eax
    3f95:	74 19                	je     3fb0 <subdir+0x401>
    3f97:	48 b8 1e 7c 00 00 00 	movabs $0x7c1e,%rax
    3f9e:	00 00 00 
    3fa1:	48 89 c7             	mov    %rax,%rdi
    3fa4:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3fab:	00 00 00 
    3fae:	ff d0                	call   *%rax
    3fb0:	48 b8 8a 7b 00 00 00 	movabs $0x7b8a,%rax
    3fb7:	00 00 00 
    3fba:	be 00 00 00 00       	mov    $0x0,%esi
    3fbf:	48 89 c7             	mov    %rax,%rdi
    3fc2:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    3fc9:	00 00 00 
    3fcc:	ff d0                	call   *%rax
    3fce:	89 45 fc             	mov    %eax,-0x4(%rbp)
    3fd1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    3fd5:	79 19                	jns    3ff0 <subdir+0x441>
    3fd7:	48 b8 29 7c 00 00 00 	movabs $0x7c29,%rax
    3fde:	00 00 00 
    3fe1:	48 89 c7             	mov    %rax,%rdi
    3fe4:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3feb:	00 00 00 
    3fee:	ff d0                	call   *%rax
    3ff0:	48 b9 20 89 00 00 00 	movabs $0x8920,%rcx
    3ff7:	00 00 00 
    3ffa:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3ffd:	ba 00 20 00 00       	mov    $0x2000,%edx
    4002:	48 89 ce             	mov    %rcx,%rsi
    4005:	89 c7                	mov    %eax,%edi
    4007:	48 b8 9b 67 00 00 00 	movabs $0x679b,%rax
    400e:	00 00 00 
    4011:	ff d0                	call   *%rax
    4013:	83 f8 02             	cmp    $0x2,%eax
    4016:	74 19                	je     4031 <subdir+0x482>
    4018:	48 b8 39 7c 00 00 00 	movabs $0x7c39,%rax
    401f:	00 00 00 
    4022:	48 89 c7             	mov    %rax,%rdi
    4025:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    402c:	00 00 00 
    402f:	ff d0                	call   *%rax
    4031:	8b 45 fc             	mov    -0x4(%rbp),%eax
    4034:	89 c7                	mov    %eax,%edi
    4036:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    403d:	00 00 00 
    4040:	ff d0                	call   *%rax
    4042:	48 b8 37 7b 00 00 00 	movabs $0x7b37,%rax
    4049:	00 00 00 
    404c:	be 00 00 00 00       	mov    $0x0,%esi
    4051:	48 89 c7             	mov    %rax,%rdi
    4054:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    405b:	00 00 00 
    405e:	ff d0                	call   *%rax
    4060:	85 c0                	test   %eax,%eax
    4062:	78 19                	js     407d <subdir+0x4ce>
    4064:	48 b8 c0 7b 00 00 00 	movabs $0x7bc0,%rax
    406b:	00 00 00 
    406e:	48 89 c7             	mov    %rax,%rdi
    4071:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4078:	00 00 00 
    407b:	ff d0                	call   *%rax
    407d:	48 b8 53 7c 00 00 00 	movabs $0x7c53,%rax
    4084:	00 00 00 
    4087:	be 02 02 00 00       	mov    $0x202,%esi
    408c:	48 89 c7             	mov    %rax,%rdi
    408f:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    4096:	00 00 00 
    4099:	ff d0                	call   *%rax
    409b:	85 c0                	test   %eax,%eax
    409d:	78 19                	js     40b8 <subdir+0x509>
    409f:	48 b8 5c 7c 00 00 00 	movabs $0x7c5c,%rax
    40a6:	00 00 00 
    40a9:	48 89 c7             	mov    %rax,%rdi
    40ac:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    40b3:	00 00 00 
    40b6:	ff d0                	call   *%rax
    40b8:	48 b8 76 7c 00 00 00 	movabs $0x7c76,%rax
    40bf:	00 00 00 
    40c2:	be 02 02 00 00       	mov    $0x202,%esi
    40c7:	48 89 c7             	mov    %rax,%rdi
    40ca:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    40d1:	00 00 00 
    40d4:	ff d0                	call   *%rax
    40d6:	85 c0                	test   %eax,%eax
    40d8:	78 19                	js     40f3 <subdir+0x544>
    40da:	48 b8 7f 7c 00 00 00 	movabs $0x7c7f,%rax
    40e1:	00 00 00 
    40e4:	48 89 c7             	mov    %rax,%rdi
    40e7:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    40ee:	00 00 00 
    40f1:	ff d0                	call   *%rax
    40f3:	48 b8 cc 7a 00 00 00 	movabs $0x7acc,%rax
    40fa:	00 00 00 
    40fd:	be 00 02 00 00       	mov    $0x200,%esi
    4102:	48 89 c7             	mov    %rax,%rdi
    4105:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    410c:	00 00 00 
    410f:	ff d0                	call   *%rax
    4111:	85 c0                	test   %eax,%eax
    4113:	78 19                	js     412e <subdir+0x57f>
    4115:	48 b8 99 7c 00 00 00 	movabs $0x7c99,%rax
    411c:	00 00 00 
    411f:	48 89 c7             	mov    %rax,%rdi
    4122:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4129:	00 00 00 
    412c:	ff d0                	call   *%rax
    412e:	48 b8 cc 7a 00 00 00 	movabs $0x7acc,%rax
    4135:	00 00 00 
    4138:	be 02 00 00 00       	mov    $0x2,%esi
    413d:	48 89 c7             	mov    %rax,%rdi
    4140:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    4147:	00 00 00 
    414a:	ff d0                	call   *%rax
    414c:	85 c0                	test   %eax,%eax
    414e:	78 19                	js     4169 <subdir+0x5ba>
    4150:	48 b8 ad 7c 00 00 00 	movabs $0x7cad,%rax
    4157:	00 00 00 
    415a:	48 89 c7             	mov    %rax,%rdi
    415d:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4164:	00 00 00 
    4167:	ff d0                	call   *%rax
    4169:	48 b8 cc 7a 00 00 00 	movabs $0x7acc,%rax
    4170:	00 00 00 
    4173:	be 01 00 00 00       	mov    $0x1,%esi
    4178:	48 89 c7             	mov    %rax,%rdi
    417b:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    4182:	00 00 00 
    4185:	ff d0                	call   *%rax
    4187:	85 c0                	test   %eax,%eax
    4189:	78 19                	js     41a4 <subdir+0x5f5>
    418b:	48 b8 c4 7c 00 00 00 	movabs $0x7cc4,%rax
    4192:	00 00 00 
    4195:	48 89 c7             	mov    %rax,%rdi
    4198:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    419f:	00 00 00 
    41a2:	ff d0                	call   *%rax
    41a4:	48 ba dd 7c 00 00 00 	movabs $0x7cdd,%rdx
    41ab:	00 00 00 
    41ae:	48 b8 53 7c 00 00 00 	movabs $0x7c53,%rax
    41b5:	00 00 00 
    41b8:	48 89 d6             	mov    %rdx,%rsi
    41bb:	48 89 c7             	mov    %rax,%rdi
    41be:	48 b8 10 68 00 00 00 	movabs $0x6810,%rax
    41c5:	00 00 00 
    41c8:	ff d0                	call   *%rax
    41ca:	85 c0                	test   %eax,%eax
    41cc:	75 19                	jne    41e7 <subdir+0x638>
    41ce:	48 b8 e8 7c 00 00 00 	movabs $0x7ce8,%rax
    41d5:	00 00 00 
    41d8:	48 89 c7             	mov    %rax,%rdi
    41db:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    41e2:	00 00 00 
    41e5:	ff d0                	call   *%rax
    41e7:	48 ba dd 7c 00 00 00 	movabs $0x7cdd,%rdx
    41ee:	00 00 00 
    41f1:	48 b8 76 7c 00 00 00 	movabs $0x7c76,%rax
    41f8:	00 00 00 
    41fb:	48 89 d6             	mov    %rdx,%rsi
    41fe:	48 89 c7             	mov    %rax,%rdi
    4201:	48 b8 10 68 00 00 00 	movabs $0x6810,%rax
    4208:	00 00 00 
    420b:	ff d0                	call   *%rax
    420d:	85 c0                	test   %eax,%eax
    420f:	75 19                	jne    422a <subdir+0x67b>
    4211:	48 b8 10 7d 00 00 00 	movabs $0x7d10,%rax
    4218:	00 00 00 
    421b:	48 89 c7             	mov    %rax,%rdi
    421e:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4225:	00 00 00 
    4228:	ff d0                	call   *%rax
    422a:	48 ba 8a 7b 00 00 00 	movabs $0x7b8a,%rdx
    4231:	00 00 00 
    4234:	48 b8 df 7a 00 00 00 	movabs $0x7adf,%rax
    423b:	00 00 00 
    423e:	48 89 d6             	mov    %rdx,%rsi
    4241:	48 89 c7             	mov    %rax,%rdi
    4244:	48 b8 10 68 00 00 00 	movabs $0x6810,%rax
    424b:	00 00 00 
    424e:	ff d0                	call   *%rax
    4250:	85 c0                	test   %eax,%eax
    4252:	75 19                	jne    426d <subdir+0x6be>
    4254:	48 b8 38 7d 00 00 00 	movabs $0x7d38,%rax
    425b:	00 00 00 
    425e:	48 89 c7             	mov    %rax,%rdi
    4261:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4268:	00 00 00 
    426b:	ff d0                	call   *%rax
    426d:	48 b8 53 7c 00 00 00 	movabs $0x7c53,%rax
    4274:	00 00 00 
    4277:	48 89 c7             	mov    %rax,%rdi
    427a:	48 b8 1d 68 00 00 00 	movabs $0x681d,%rax
    4281:	00 00 00 
    4284:	ff d0                	call   *%rax
    4286:	85 c0                	test   %eax,%eax
    4288:	75 19                	jne    42a3 <subdir+0x6f4>
    428a:	48 b8 58 7d 00 00 00 	movabs $0x7d58,%rax
    4291:	00 00 00 
    4294:	48 89 c7             	mov    %rax,%rdi
    4297:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    429e:	00 00 00 
    42a1:	ff d0                	call   *%rax
    42a3:	48 b8 76 7c 00 00 00 	movabs $0x7c76,%rax
    42aa:	00 00 00 
    42ad:	48 89 c7             	mov    %rax,%rdi
    42b0:	48 b8 1d 68 00 00 00 	movabs $0x681d,%rax
    42b7:	00 00 00 
    42ba:	ff d0                	call   *%rax
    42bc:	85 c0                	test   %eax,%eax
    42be:	75 19                	jne    42d9 <subdir+0x72a>
    42c0:	48 b8 71 7d 00 00 00 	movabs $0x7d71,%rax
    42c7:	00 00 00 
    42ca:	48 89 c7             	mov    %rax,%rdi
    42cd:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    42d4:	00 00 00 
    42d7:	ff d0                	call   *%rax
    42d9:	48 b8 8a 7b 00 00 00 	movabs $0x7b8a,%rax
    42e0:	00 00 00 
    42e3:	48 89 c7             	mov    %rax,%rdi
    42e6:	48 b8 1d 68 00 00 00 	movabs $0x681d,%rax
    42ed:	00 00 00 
    42f0:	ff d0                	call   *%rax
    42f2:	85 c0                	test   %eax,%eax
    42f4:	75 19                	jne    430f <subdir+0x760>
    42f6:	48 b8 8a 7d 00 00 00 	movabs $0x7d8a,%rax
    42fd:	00 00 00 
    4300:	48 89 c7             	mov    %rax,%rdi
    4303:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    430a:	00 00 00 
    430d:	ff d0                	call   *%rax
    430f:	48 b8 76 7c 00 00 00 	movabs $0x7c76,%rax
    4316:	00 00 00 
    4319:	48 89 c7             	mov    %rax,%rdi
    431c:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    4323:	00 00 00 
    4326:	ff d0                	call   *%rax
    4328:	85 c0                	test   %eax,%eax
    432a:	75 19                	jne    4345 <subdir+0x796>
    432c:	48 b8 a5 7d 00 00 00 	movabs $0x7da5,%rax
    4333:	00 00 00 
    4336:	48 89 c7             	mov    %rax,%rdi
    4339:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4340:	00 00 00 
    4343:	ff d0                	call   *%rax
    4345:	48 b8 53 7c 00 00 00 	movabs $0x7c53,%rax
    434c:	00 00 00 
    434f:	48 89 c7             	mov    %rax,%rdi
    4352:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    4359:	00 00 00 
    435c:	ff d0                	call   *%rax
    435e:	85 c0                	test   %eax,%eax
    4360:	75 19                	jne    437b <subdir+0x7cc>
    4362:	48 b8 bf 7d 00 00 00 	movabs $0x7dbf,%rax
    4369:	00 00 00 
    436c:	48 89 c7             	mov    %rax,%rdi
    436f:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4376:	00 00 00 
    4379:	ff d0                	call   *%rax
    437b:	48 b8 df 7a 00 00 00 	movabs $0x7adf,%rax
    4382:	00 00 00 
    4385:	48 89 c7             	mov    %rax,%rdi
    4388:	48 b8 2a 68 00 00 00 	movabs $0x682a,%rax
    438f:	00 00 00 
    4392:	ff d0                	call   *%rax
    4394:	85 c0                	test   %eax,%eax
    4396:	75 19                	jne    43b1 <subdir+0x802>
    4398:	48 b8 d9 7d 00 00 00 	movabs $0x7dd9,%rax
    439f:	00 00 00 
    43a2:	48 89 c7             	mov    %rax,%rdi
    43a5:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    43ac:	00 00 00 
    43af:	ff d0                	call   *%rax
    43b1:	48 b8 ef 7d 00 00 00 	movabs $0x7def,%rax
    43b8:	00 00 00 
    43bb:	48 89 c7             	mov    %rax,%rdi
    43be:	48 b8 2a 68 00 00 00 	movabs $0x682a,%rax
    43c5:	00 00 00 
    43c8:	ff d0                	call   *%rax
    43ca:	85 c0                	test   %eax,%eax
    43cc:	75 19                	jne    43e7 <subdir+0x838>
    43ce:	48 b8 f5 7d 00 00 00 	movabs $0x7df5,%rax
    43d5:	00 00 00 
    43d8:	48 89 c7             	mov    %rax,%rdi
    43db:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    43e2:	00 00 00 
    43e5:	ff d0                	call   *%rax
    43e7:	48 b8 8a 7b 00 00 00 	movabs $0x7b8a,%rax
    43ee:	00 00 00 
    43f1:	48 89 c7             	mov    %rax,%rdi
    43f4:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    43fb:	00 00 00 
    43fe:	ff d0                	call   *%rax
    4400:	85 c0                	test   %eax,%eax
    4402:	74 19                	je     441d <subdir+0x86e>
    4404:	48 b8 ae 7b 00 00 00 	movabs $0x7bae,%rax
    440b:	00 00 00 
    440e:	48 89 c7             	mov    %rax,%rdi
    4411:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4418:	00 00 00 
    441b:	ff d0                	call   *%rax
    441d:	48 b8 df 7a 00 00 00 	movabs $0x7adf,%rax
    4424:	00 00 00 
    4427:	48 89 c7             	mov    %rax,%rdi
    442a:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    4431:	00 00 00 
    4434:	ff d0                	call   *%rax
    4436:	85 c0                	test   %eax,%eax
    4438:	74 19                	je     4453 <subdir+0x8a4>
    443a:	48 b8 0b 7e 00 00 00 	movabs $0x7e0b,%rax
    4441:	00 00 00 
    4444:	48 89 c7             	mov    %rax,%rdi
    4447:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    444e:	00 00 00 
    4451:	ff d0                	call   *%rax
    4453:	48 b8 cc 7a 00 00 00 	movabs $0x7acc,%rax
    445a:	00 00 00 
    445d:	48 89 c7             	mov    %rax,%rdi
    4460:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    4467:	00 00 00 
    446a:	ff d0                	call   *%rax
    446c:	85 c0                	test   %eax,%eax
    446e:	75 19                	jne    4489 <subdir+0x8da>
    4470:	48 b8 18 7e 00 00 00 	movabs $0x7e18,%rax
    4477:	00 00 00 
    447a:	48 89 c7             	mov    %rax,%rdi
    447d:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4484:	00 00 00 
    4487:	ff d0                	call   *%rax
    4489:	48 b8 36 7e 00 00 00 	movabs $0x7e36,%rax
    4490:	00 00 00 
    4493:	48 89 c7             	mov    %rax,%rdi
    4496:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    449d:	00 00 00 
    44a0:	ff d0                	call   *%rax
    44a2:	85 c0                	test   %eax,%eax
    44a4:	79 19                	jns    44bf <subdir+0x910>
    44a6:	48 b8 3c 7e 00 00 00 	movabs $0x7e3c,%rax
    44ad:	00 00 00 
    44b0:	48 89 c7             	mov    %rax,%rdi
    44b3:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    44ba:	00 00 00 
    44bd:	ff d0                	call   *%rax
    44bf:	48 b8 cc 7a 00 00 00 	movabs $0x7acc,%rax
    44c6:	00 00 00 
    44c9:	48 89 c7             	mov    %rax,%rdi
    44cc:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    44d3:	00 00 00 
    44d6:	ff d0                	call   *%rax
    44d8:	85 c0                	test   %eax,%eax
    44da:	79 19                	jns    44f5 <subdir+0x946>
    44dc:	48 b8 49 7e 00 00 00 	movabs $0x7e49,%rax
    44e3:	00 00 00 
    44e6:	48 89 c7             	mov    %rax,%rdi
    44e9:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    44f0:	00 00 00 
    44f3:	ff d0                	call   *%rax
    44f5:	48 b8 53 7e 00 00 00 	movabs $0x7e53,%rax
    44fc:	00 00 00 
    44ff:	48 89 c6             	mov    %rax,%rsi
    4502:	bf 01 00 00 00       	mov    $0x1,%edi
    4507:	b8 00 00 00 00       	mov    $0x0,%eax
    450c:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    4513:	00 00 00 
    4516:	ff d2                	call   *%rdx
    4518:	90                   	nop
    4519:	c9                   	leave
    451a:	c3                   	ret

000000000000451b <bigwrite>:
    451b:	55                   	push   %rbp
    451c:	48 89 e5             	mov    %rsp,%rbp
    451f:	48 83 ec 10          	sub    $0x10,%rsp
    4523:	48 b8 5e 7e 00 00 00 	movabs $0x7e5e,%rax
    452a:	00 00 00 
    452d:	48 89 c6             	mov    %rax,%rsi
    4530:	bf 01 00 00 00       	mov    $0x1,%edi
    4535:	b8 00 00 00 00       	mov    $0x0,%eax
    453a:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    4541:	00 00 00 
    4544:	ff d2                	call   *%rdx
    4546:	48 b8 6d 7e 00 00 00 	movabs $0x7e6d,%rax
    454d:	00 00 00 
    4550:	48 89 c7             	mov    %rax,%rdi
    4553:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    455a:	00 00 00 
    455d:	ff d0                	call   *%rax
    455f:	c7 45 fc f3 01 00 00 	movl   $0x1f3,-0x4(%rbp)
    4566:	e9 e7 00 00 00       	jmp    4652 <bigwrite+0x137>
    456b:	48 b8 6d 7e 00 00 00 	movabs $0x7e6d,%rax
    4572:	00 00 00 
    4575:	be 02 02 00 00       	mov    $0x202,%esi
    457a:	48 89 c7             	mov    %rax,%rdi
    457d:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    4584:	00 00 00 
    4587:	ff d0                	call   *%rax
    4589:	89 45 f4             	mov    %eax,-0xc(%rbp)
    458c:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    4590:	79 19                	jns    45ab <bigwrite+0x90>
    4592:	48 b8 76 7e 00 00 00 	movabs $0x7e76,%rax
    4599:	00 00 00 
    459c:	48 89 c7             	mov    %rax,%rdi
    459f:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    45a6:	00 00 00 
    45a9:	ff d0                	call   *%rax
    45ab:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
    45b2:	eb 67                	jmp    461b <bigwrite+0x100>
    45b4:	8b 55 fc             	mov    -0x4(%rbp),%edx
    45b7:	48 b9 20 89 00 00 00 	movabs $0x8920,%rcx
    45be:	00 00 00 
    45c1:	8b 45 f4             	mov    -0xc(%rbp),%eax
    45c4:	48 89 ce             	mov    %rcx,%rsi
    45c7:	89 c7                	mov    %eax,%edi
    45c9:	48 b8 a8 67 00 00 00 	movabs $0x67a8,%rax
    45d0:	00 00 00 
    45d3:	ff d0                	call   *%rax
    45d5:	89 45 f0             	mov    %eax,-0x10(%rbp)
    45d8:	8b 45 f0             	mov    -0x10(%rbp),%eax
    45db:	3b 45 fc             	cmp    -0x4(%rbp),%eax
    45de:	74 37                	je     4617 <bigwrite+0xfc>
    45e0:	8b 55 f0             	mov    -0x10(%rbp),%edx
    45e3:	8b 45 fc             	mov    -0x4(%rbp),%eax
    45e6:	48 be 8d 7e 00 00 00 	movabs $0x7e8d,%rsi
    45ed:	00 00 00 
    45f0:	89 d1                	mov    %edx,%ecx
    45f2:	89 c2                	mov    %eax,%edx
    45f4:	bf 01 00 00 00       	mov    $0x1,%edi
    45f9:	b8 00 00 00 00       	mov    $0x0,%eax
    45fe:	49 b8 78 6a 00 00 00 	movabs $0x6a78,%r8
    4605:	00 00 00 
    4608:	41 ff d0             	call   *%r8
    460b:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    4612:	00 00 00 
    4615:	ff d0                	call   *%rax
    4617:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    461b:	83 7d f8 01          	cmpl   $0x1,-0x8(%rbp)
    461f:	7e 93                	jle    45b4 <bigwrite+0x99>
    4621:	8b 45 f4             	mov    -0xc(%rbp),%eax
    4624:	89 c7                	mov    %eax,%edi
    4626:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    462d:	00 00 00 
    4630:	ff d0                	call   *%rax
    4632:	48 b8 6d 7e 00 00 00 	movabs $0x7e6d,%rax
    4639:	00 00 00 
    463c:	48 89 c7             	mov    %rax,%rdi
    463f:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    4646:	00 00 00 
    4649:	ff d0                	call   *%rax
    464b:	81 45 fc d7 01 00 00 	addl   $0x1d7,-0x4(%rbp)
    4652:	81 7d fc ff 17 00 00 	cmpl   $0x17ff,-0x4(%rbp)
    4659:	0f 8e 0c ff ff ff    	jle    456b <bigwrite+0x50>
    465f:	48 b8 9f 7e 00 00 00 	movabs $0x7e9f,%rax
    4666:	00 00 00 
    4669:	48 89 c6             	mov    %rax,%rsi
    466c:	bf 01 00 00 00       	mov    $0x1,%edi
    4671:	b8 00 00 00 00       	mov    $0x0,%eax
    4676:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    467d:	00 00 00 
    4680:	ff d2                	call   *%rdx
    4682:	90                   	nop
    4683:	c9                   	leave
    4684:	c3                   	ret

0000000000004685 <bigfile>:
    4685:	55                   	push   %rbp
    4686:	48 89 e5             	mov    %rsp,%rbp
    4689:	48 83 ec 10          	sub    $0x10,%rsp
    468d:	48 b8 ac 7e 00 00 00 	movabs $0x7eac,%rax
    4694:	00 00 00 
    4697:	48 89 c6             	mov    %rax,%rsi
    469a:	bf 01 00 00 00       	mov    $0x1,%edi
    469f:	b8 00 00 00 00       	mov    $0x0,%eax
    46a4:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    46ab:	00 00 00 
    46ae:	ff d2                	call   *%rdx
    46b0:	48 b8 ba 7e 00 00 00 	movabs $0x7eba,%rax
    46b7:	00 00 00 
    46ba:	48 89 c7             	mov    %rax,%rdi
    46bd:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    46c4:	00 00 00 
    46c7:	ff d0                	call   *%rax
    46c9:	48 b8 ba 7e 00 00 00 	movabs $0x7eba,%rax
    46d0:	00 00 00 
    46d3:	be 02 02 00 00       	mov    $0x202,%esi
    46d8:	48 89 c7             	mov    %rax,%rdi
    46db:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    46e2:	00 00 00 
    46e5:	ff d0                	call   *%rax
    46e7:	89 45 f4             	mov    %eax,-0xc(%rbp)
    46ea:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    46ee:	79 19                	jns    4709 <bigfile+0x84>
    46f0:	48 b8 c2 7e 00 00 00 	movabs $0x7ec2,%rax
    46f7:	00 00 00 
    46fa:	48 89 c7             	mov    %rax,%rdi
    46fd:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4704:	00 00 00 
    4707:	ff d0                	call   *%rax
    4709:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    4710:	eb 6a                	jmp    477c <bigfile+0xf7>
    4712:	8b 45 fc             	mov    -0x4(%rbp),%eax
    4715:	48 b9 20 89 00 00 00 	movabs $0x8920,%rcx
    471c:	00 00 00 
    471f:	ba 58 02 00 00       	mov    $0x258,%edx
    4724:	89 c6                	mov    %eax,%esi
    4726:	48 89 cf             	mov    %rcx,%rdi
    4729:	48 b8 3f 65 00 00 00 	movabs $0x653f,%rax
    4730:	00 00 00 
    4733:	ff d0                	call   *%rax
    4735:	48 b9 20 89 00 00 00 	movabs $0x8920,%rcx
    473c:	00 00 00 
    473f:	8b 45 f4             	mov    -0xc(%rbp),%eax
    4742:	ba 58 02 00 00       	mov    $0x258,%edx
    4747:	48 89 ce             	mov    %rcx,%rsi
    474a:	89 c7                	mov    %eax,%edi
    474c:	48 b8 a8 67 00 00 00 	movabs $0x67a8,%rax
    4753:	00 00 00 
    4756:	ff d0                	call   *%rax
    4758:	3d 58 02 00 00       	cmp    $0x258,%eax
    475d:	74 19                	je     4778 <bigfile+0xf3>
    475f:	48 b8 d8 7e 00 00 00 	movabs $0x7ed8,%rax
    4766:	00 00 00 
    4769:	48 89 c7             	mov    %rax,%rdi
    476c:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4773:	00 00 00 
    4776:	ff d0                	call   *%rax
    4778:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    477c:	83 7d fc 13          	cmpl   $0x13,-0x4(%rbp)
    4780:	7e 90                	jle    4712 <bigfile+0x8d>
    4782:	8b 45 f4             	mov    -0xc(%rbp),%eax
    4785:	89 c7                	mov    %eax,%edi
    4787:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    478e:	00 00 00 
    4791:	ff d0                	call   *%rax
    4793:	48 b8 ba 7e 00 00 00 	movabs $0x7eba,%rax
    479a:	00 00 00 
    479d:	be 00 00 00 00       	mov    $0x0,%esi
    47a2:	48 89 c7             	mov    %rax,%rdi
    47a5:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    47ac:	00 00 00 
    47af:	ff d0                	call   *%rax
    47b1:	89 45 f4             	mov    %eax,-0xc(%rbp)
    47b4:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    47b8:	79 19                	jns    47d3 <bigfile+0x14e>
    47ba:	48 b8 e6 7e 00 00 00 	movabs $0x7ee6,%rax
    47c1:	00 00 00 
    47c4:	48 89 c7             	mov    %rax,%rdi
    47c7:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    47ce:	00 00 00 
    47d1:	ff d0                	call   *%rax
    47d3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
    47da:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    47e1:	48 b9 20 89 00 00 00 	movabs $0x8920,%rcx
    47e8:	00 00 00 
    47eb:	8b 45 f4             	mov    -0xc(%rbp),%eax
    47ee:	ba 2c 01 00 00       	mov    $0x12c,%edx
    47f3:	48 89 ce             	mov    %rcx,%rsi
    47f6:	89 c7                	mov    %eax,%edi
    47f8:	48 b8 9b 67 00 00 00 	movabs $0x679b,%rax
    47ff:	00 00 00 
    4802:	ff d0                	call   *%rax
    4804:	89 45 f0             	mov    %eax,-0x10(%rbp)
    4807:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    480b:	79 19                	jns    4826 <bigfile+0x1a1>
    480d:	48 b8 fa 7e 00 00 00 	movabs $0x7efa,%rax
    4814:	00 00 00 
    4817:	48 89 c7             	mov    %rax,%rdi
    481a:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4821:	00 00 00 
    4824:	ff d0                	call   *%rax
    4826:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    482a:	0f 84 8e 00 00 00    	je     48be <bigfile+0x239>
    4830:	81 7d f0 2c 01 00 00 	cmpl   $0x12c,-0x10(%rbp)
    4837:	74 19                	je     4852 <bigfile+0x1cd>
    4839:	48 b8 07 7f 00 00 00 	movabs $0x7f07,%rax
    4840:	00 00 00 
    4843:	48 89 c7             	mov    %rax,%rdi
    4846:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    484d:	00 00 00 
    4850:	ff d0                	call   *%rax
    4852:	48 b8 20 89 00 00 00 	movabs $0x8920,%rax
    4859:	00 00 00 
    485c:	0f b6 00             	movzbl (%rax),%eax
    485f:	0f be d0             	movsbl %al,%edx
    4862:	8b 45 fc             	mov    -0x4(%rbp),%eax
    4865:	89 c1                	mov    %eax,%ecx
    4867:	c1 e9 1f             	shr    $0x1f,%ecx
    486a:	01 c8                	add    %ecx,%eax
    486c:	d1 f8                	sar    $1,%eax
    486e:	39 c2                	cmp    %eax,%edx
    4870:	75 24                	jne    4896 <bigfile+0x211>
    4872:	48 b8 20 89 00 00 00 	movabs $0x8920,%rax
    4879:	00 00 00 
    487c:	0f b6 80 2b 01 00 00 	movzbl 0x12b(%rax),%eax
    4883:	0f be d0             	movsbl %al,%edx
    4886:	8b 45 fc             	mov    -0x4(%rbp),%eax
    4889:	89 c1                	mov    %eax,%ecx
    488b:	c1 e9 1f             	shr    $0x1f,%ecx
    488e:	01 c8                	add    %ecx,%eax
    4890:	d1 f8                	sar    $1,%eax
    4892:	39 c2                	cmp    %eax,%edx
    4894:	74 19                	je     48af <bigfile+0x22a>
    4896:	48 b8 1a 7f 00 00 00 	movabs $0x7f1a,%rax
    489d:	00 00 00 
    48a0:	48 89 c7             	mov    %rax,%rdi
    48a3:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    48aa:	00 00 00 
    48ad:	ff d0                	call   *%rax
    48af:	8b 45 f0             	mov    -0x10(%rbp),%eax
    48b2:	01 45 f8             	add    %eax,-0x8(%rbp)
    48b5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    48b9:	e9 23 ff ff ff       	jmp    47e1 <bigfile+0x15c>
    48be:	90                   	nop
    48bf:	8b 45 f4             	mov    -0xc(%rbp),%eax
    48c2:	89 c7                	mov    %eax,%edi
    48c4:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    48cb:	00 00 00 
    48ce:	ff d0                	call   *%rax
    48d0:	81 7d f8 e0 2e 00 00 	cmpl   $0x2ee0,-0x8(%rbp)
    48d7:	74 19                	je     48f2 <bigfile+0x26d>
    48d9:	48 b8 32 7f 00 00 00 	movabs $0x7f32,%rax
    48e0:	00 00 00 
    48e3:	48 89 c7             	mov    %rax,%rdi
    48e6:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    48ed:	00 00 00 
    48f0:	ff d0                	call   *%rax
    48f2:	48 b8 ba 7e 00 00 00 	movabs $0x7eba,%rax
    48f9:	00 00 00 
    48fc:	48 89 c7             	mov    %rax,%rdi
    48ff:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    4906:	00 00 00 
    4909:	ff d0                	call   *%rax
    490b:	48 b8 4b 7f 00 00 00 	movabs $0x7f4b,%rax
    4912:	00 00 00 
    4915:	48 89 c6             	mov    %rax,%rsi
    4918:	bf 01 00 00 00       	mov    $0x1,%edi
    491d:	b8 00 00 00 00       	mov    $0x0,%eax
    4922:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    4929:	00 00 00 
    492c:	ff d2                	call   *%rdx
    492e:	90                   	nop
    492f:	c9                   	leave
    4930:	c3                   	ret

0000000000004931 <fourteen>:
    4931:	55                   	push   %rbp
    4932:	48 89 e5             	mov    %rsp,%rbp
    4935:	48 83 ec 10          	sub    $0x10,%rsp
    4939:	48 b8 5c 7f 00 00 00 	movabs $0x7f5c,%rax
    4940:	00 00 00 
    4943:	48 89 c6             	mov    %rax,%rsi
    4946:	bf 01 00 00 00       	mov    $0x1,%edi
    494b:	b8 00 00 00 00       	mov    $0x0,%eax
    4950:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    4957:	00 00 00 
    495a:	ff d2                	call   *%rdx
    495c:	48 b8 6b 7f 00 00 00 	movabs $0x7f6b,%rax
    4963:	00 00 00 
    4966:	48 89 c7             	mov    %rax,%rdi
    4969:	48 b8 1d 68 00 00 00 	movabs $0x681d,%rax
    4970:	00 00 00 
    4973:	ff d0                	call   *%rax
    4975:	85 c0                	test   %eax,%eax
    4977:	74 19                	je     4992 <fourteen+0x61>
    4979:	48 b8 7a 7f 00 00 00 	movabs $0x7f7a,%rax
    4980:	00 00 00 
    4983:	48 89 c7             	mov    %rax,%rdi
    4986:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    498d:	00 00 00 
    4990:	ff d0                	call   *%rax
    4992:	48 b8 90 7f 00 00 00 	movabs $0x7f90,%rax
    4999:	00 00 00 
    499c:	48 89 c7             	mov    %rax,%rdi
    499f:	48 b8 1d 68 00 00 00 	movabs $0x681d,%rax
    49a6:	00 00 00 
    49a9:	ff d0                	call   *%rax
    49ab:	85 c0                	test   %eax,%eax
    49ad:	74 19                	je     49c8 <fourteen+0x97>
    49af:	48 b8 b0 7f 00 00 00 	movabs $0x7fb0,%rax
    49b6:	00 00 00 
    49b9:	48 89 c7             	mov    %rax,%rdi
    49bc:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    49c3:	00 00 00 
    49c6:	ff d0                	call   *%rax
    49c8:	48 b8 d8 7f 00 00 00 	movabs $0x7fd8,%rax
    49cf:	00 00 00 
    49d2:	be 00 02 00 00       	mov    $0x200,%esi
    49d7:	48 89 c7             	mov    %rax,%rdi
    49da:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    49e1:	00 00 00 
    49e4:	ff d0                	call   *%rax
    49e6:	89 45 fc             	mov    %eax,-0x4(%rbp)
    49e9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    49ed:	79 19                	jns    4a08 <fourteen+0xd7>
    49ef:	48 b8 08 80 00 00 00 	movabs $0x8008,%rax
    49f6:	00 00 00 
    49f9:	48 89 c7             	mov    %rax,%rdi
    49fc:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4a03:	00 00 00 
    4a06:	ff d0                	call   *%rax
    4a08:	8b 45 fc             	mov    -0x4(%rbp),%eax
    4a0b:	89 c7                	mov    %eax,%edi
    4a0d:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    4a14:	00 00 00 
    4a17:	ff d0                	call   *%rax
    4a19:	48 b8 40 80 00 00 00 	movabs $0x8040,%rax
    4a20:	00 00 00 
    4a23:	be 00 00 00 00       	mov    $0x0,%esi
    4a28:	48 89 c7             	mov    %rax,%rdi
    4a2b:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    4a32:	00 00 00 
    4a35:	ff d0                	call   *%rax
    4a37:	89 45 fc             	mov    %eax,-0x4(%rbp)
    4a3a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    4a3e:	79 19                	jns    4a59 <fourteen+0x128>
    4a40:	48 b8 70 80 00 00 00 	movabs $0x8070,%rax
    4a47:	00 00 00 
    4a4a:	48 89 c7             	mov    %rax,%rdi
    4a4d:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4a54:	00 00 00 
    4a57:	ff d0                	call   *%rax
    4a59:	8b 45 fc             	mov    -0x4(%rbp),%eax
    4a5c:	89 c7                	mov    %eax,%edi
    4a5e:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    4a65:	00 00 00 
    4a68:	ff d0                	call   *%rax
    4a6a:	48 b8 a2 80 00 00 00 	movabs $0x80a2,%rax
    4a71:	00 00 00 
    4a74:	48 89 c7             	mov    %rax,%rdi
    4a77:	48 b8 1d 68 00 00 00 	movabs $0x681d,%rax
    4a7e:	00 00 00 
    4a81:	ff d0                	call   *%rax
    4a83:	85 c0                	test   %eax,%eax
    4a85:	75 19                	jne    4aa0 <fourteen+0x16f>
    4a87:	48 b8 c0 80 00 00 00 	movabs $0x80c0,%rax
    4a8e:	00 00 00 
    4a91:	48 89 c7             	mov    %rax,%rdi
    4a94:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4a9b:	00 00 00 
    4a9e:	ff d0                	call   *%rax
    4aa0:	48 b8 f0 80 00 00 00 	movabs $0x80f0,%rax
    4aa7:	00 00 00 
    4aaa:	48 89 c7             	mov    %rax,%rdi
    4aad:	48 b8 1d 68 00 00 00 	movabs $0x681d,%rax
    4ab4:	00 00 00 
    4ab7:	ff d0                	call   *%rax
    4ab9:	85 c0                	test   %eax,%eax
    4abb:	75 19                	jne    4ad6 <fourteen+0x1a5>
    4abd:	48 b8 10 81 00 00 00 	movabs $0x8110,%rax
    4ac4:	00 00 00 
    4ac7:	48 89 c7             	mov    %rax,%rdi
    4aca:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4ad1:	00 00 00 
    4ad4:	ff d0                	call   *%rax
    4ad6:	48 b8 3f 81 00 00 00 	movabs $0x813f,%rax
    4add:	00 00 00 
    4ae0:	48 89 c6             	mov    %rax,%rsi
    4ae3:	bf 01 00 00 00       	mov    $0x1,%edi
    4ae8:	b8 00 00 00 00       	mov    $0x0,%eax
    4aed:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    4af4:	00 00 00 
    4af7:	ff d2                	call   *%rdx
    4af9:	90                   	nop
    4afa:	c9                   	leave
    4afb:	c3                   	ret

0000000000004afc <rmdot>:
    4afc:	55                   	push   %rbp
    4afd:	48 89 e5             	mov    %rsp,%rbp
    4b00:	48 b8 4c 81 00 00 00 	movabs $0x814c,%rax
    4b07:	00 00 00 
    4b0a:	48 89 c6             	mov    %rax,%rsi
    4b0d:	bf 01 00 00 00       	mov    $0x1,%edi
    4b12:	b8 00 00 00 00       	mov    $0x0,%eax
    4b17:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    4b1e:	00 00 00 
    4b21:	ff d2                	call   *%rdx
    4b23:	48 b8 58 81 00 00 00 	movabs $0x8158,%rax
    4b2a:	00 00 00 
    4b2d:	48 89 c7             	mov    %rax,%rdi
    4b30:	48 b8 1d 68 00 00 00 	movabs $0x681d,%rax
    4b37:	00 00 00 
    4b3a:	ff d0                	call   *%rax
    4b3c:	85 c0                	test   %eax,%eax
    4b3e:	74 19                	je     4b59 <rmdot+0x5d>
    4b40:	48 b8 5d 81 00 00 00 	movabs $0x815d,%rax
    4b47:	00 00 00 
    4b4a:	48 89 c7             	mov    %rax,%rdi
    4b4d:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4b54:	00 00 00 
    4b57:	ff d0                	call   *%rax
    4b59:	48 b8 58 81 00 00 00 	movabs $0x8158,%rax
    4b60:	00 00 00 
    4b63:	48 89 c7             	mov    %rax,%rdi
    4b66:	48 b8 2a 68 00 00 00 	movabs $0x682a,%rax
    4b6d:	00 00 00 
    4b70:	ff d0                	call   *%rax
    4b72:	85 c0                	test   %eax,%eax
    4b74:	74 19                	je     4b8f <rmdot+0x93>
    4b76:	48 b8 68 81 00 00 00 	movabs $0x8168,%rax
    4b7d:	00 00 00 
    4b80:	48 89 c7             	mov    %rax,%rdi
    4b83:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4b8a:	00 00 00 
    4b8d:	ff d0                	call   *%rax
    4b8f:	48 b8 7a 79 00 00 00 	movabs $0x797a,%rax
    4b96:	00 00 00 
    4b99:	48 89 c7             	mov    %rax,%rdi
    4b9c:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    4ba3:	00 00 00 
    4ba6:	ff d0                	call   *%rax
    4ba8:	85 c0                	test   %eax,%eax
    4baa:	75 19                	jne    4bc5 <rmdot+0xc9>
    4bac:	48 b8 73 81 00 00 00 	movabs $0x8173,%rax
    4bb3:	00 00 00 
    4bb6:	48 89 c7             	mov    %rax,%rdi
    4bb9:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4bc0:	00 00 00 
    4bc3:	ff d0                	call   *%rax
    4bc5:	48 b8 f2 74 00 00 00 	movabs $0x74f2,%rax
    4bcc:	00 00 00 
    4bcf:	48 89 c7             	mov    %rax,%rdi
    4bd2:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    4bd9:	00 00 00 
    4bdc:	ff d0                	call   *%rax
    4bde:	85 c0                	test   %eax,%eax
    4be0:	75 19                	jne    4bfb <rmdot+0xff>
    4be2:	48 b8 7f 81 00 00 00 	movabs $0x817f,%rax
    4be9:	00 00 00 
    4bec:	48 89 c7             	mov    %rax,%rdi
    4bef:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4bf6:	00 00 00 
    4bf9:	ff d0                	call   *%rax
    4bfb:	48 b8 e8 71 00 00 00 	movabs $0x71e8,%rax
    4c02:	00 00 00 
    4c05:	48 89 c7             	mov    %rax,%rdi
    4c08:	48 b8 2a 68 00 00 00 	movabs $0x682a,%rax
    4c0f:	00 00 00 
    4c12:	ff d0                	call   *%rax
    4c14:	85 c0                	test   %eax,%eax
    4c16:	74 19                	je     4c31 <rmdot+0x135>
    4c18:	48 b8 ea 71 00 00 00 	movabs $0x71ea,%rax
    4c1f:	00 00 00 
    4c22:	48 89 c7             	mov    %rax,%rdi
    4c25:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4c2c:	00 00 00 
    4c2f:	ff d0                	call   *%rax
    4c31:	48 b8 8c 81 00 00 00 	movabs $0x818c,%rax
    4c38:	00 00 00 
    4c3b:	48 89 c7             	mov    %rax,%rdi
    4c3e:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    4c45:	00 00 00 
    4c48:	ff d0                	call   *%rax
    4c4a:	85 c0                	test   %eax,%eax
    4c4c:	75 19                	jne    4c67 <rmdot+0x16b>
    4c4e:	48 b8 93 81 00 00 00 	movabs $0x8193,%rax
    4c55:	00 00 00 
    4c58:	48 89 c7             	mov    %rax,%rdi
    4c5b:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4c62:	00 00 00 
    4c65:	ff d0                	call   *%rax
    4c67:	48 b8 a8 81 00 00 00 	movabs $0x81a8,%rax
    4c6e:	00 00 00 
    4c71:	48 89 c7             	mov    %rax,%rdi
    4c74:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    4c7b:	00 00 00 
    4c7e:	ff d0                	call   *%rax
    4c80:	85 c0                	test   %eax,%eax
    4c82:	75 19                	jne    4c9d <rmdot+0x1a1>
    4c84:	48 b8 b0 81 00 00 00 	movabs $0x81b0,%rax
    4c8b:	00 00 00 
    4c8e:	48 89 c7             	mov    %rax,%rdi
    4c91:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4c98:	00 00 00 
    4c9b:	ff d0                	call   *%rax
    4c9d:	48 b8 58 81 00 00 00 	movabs $0x8158,%rax
    4ca4:	00 00 00 
    4ca7:	48 89 c7             	mov    %rax,%rdi
    4caa:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    4cb1:	00 00 00 
    4cb4:	ff d0                	call   *%rax
    4cb6:	85 c0                	test   %eax,%eax
    4cb8:	74 19                	je     4cd3 <rmdot+0x1d7>
    4cba:	48 b8 c6 81 00 00 00 	movabs $0x81c6,%rax
    4cc1:	00 00 00 
    4cc4:	48 89 c7             	mov    %rax,%rdi
    4cc7:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4cce:	00 00 00 
    4cd1:	ff d0                	call   *%rax
    4cd3:	48 b8 d2 81 00 00 00 	movabs $0x81d2,%rax
    4cda:	00 00 00 
    4cdd:	48 89 c6             	mov    %rax,%rsi
    4ce0:	bf 01 00 00 00       	mov    $0x1,%edi
    4ce5:	b8 00 00 00 00       	mov    $0x0,%eax
    4cea:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    4cf1:	00 00 00 
    4cf4:	ff d2                	call   *%rdx
    4cf6:	90                   	nop
    4cf7:	5d                   	pop    %rbp
    4cf8:	c3                   	ret

0000000000004cf9 <dirfile>:
    4cf9:	55                   	push   %rbp
    4cfa:	48 89 e5             	mov    %rsp,%rbp
    4cfd:	48 83 ec 10          	sub    $0x10,%rsp
    4d01:	48 b8 dc 81 00 00 00 	movabs $0x81dc,%rax
    4d08:	00 00 00 
    4d0b:	48 89 c6             	mov    %rax,%rsi
    4d0e:	bf 01 00 00 00       	mov    $0x1,%edi
    4d13:	b8 00 00 00 00       	mov    $0x0,%eax
    4d18:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    4d1f:	00 00 00 
    4d22:	ff d2                	call   *%rdx
    4d24:	48 b8 e9 81 00 00 00 	movabs $0x81e9,%rax
    4d2b:	00 00 00 
    4d2e:	be 00 02 00 00       	mov    $0x200,%esi
    4d33:	48 89 c7             	mov    %rax,%rdi
    4d36:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    4d3d:	00 00 00 
    4d40:	ff d0                	call   *%rax
    4d42:	89 45 fc             	mov    %eax,-0x4(%rbp)
    4d45:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    4d49:	79 19                	jns    4d64 <dirfile+0x6b>
    4d4b:	48 b8 f1 81 00 00 00 	movabs $0x81f1,%rax
    4d52:	00 00 00 
    4d55:	48 89 c7             	mov    %rax,%rdi
    4d58:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4d5f:	00 00 00 
    4d62:	ff d0                	call   *%rax
    4d64:	8b 45 fc             	mov    -0x4(%rbp),%eax
    4d67:	89 c7                	mov    %eax,%edi
    4d69:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    4d70:	00 00 00 
    4d73:	ff d0                	call   *%rax
    4d75:	48 b8 e9 81 00 00 00 	movabs $0x81e9,%rax
    4d7c:	00 00 00 
    4d7f:	48 89 c7             	mov    %rax,%rdi
    4d82:	48 b8 2a 68 00 00 00 	movabs $0x682a,%rax
    4d89:	00 00 00 
    4d8c:	ff d0                	call   *%rax
    4d8e:	85 c0                	test   %eax,%eax
    4d90:	75 19                	jne    4dab <dirfile+0xb2>
    4d92:	48 b8 00 82 00 00 00 	movabs $0x8200,%rax
    4d99:	00 00 00 
    4d9c:	48 89 c7             	mov    %rax,%rdi
    4d9f:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4da6:	00 00 00 
    4da9:	ff d0                	call   *%rax
    4dab:	48 b8 18 82 00 00 00 	movabs $0x8218,%rax
    4db2:	00 00 00 
    4db5:	be 00 00 00 00       	mov    $0x0,%esi
    4dba:	48 89 c7             	mov    %rax,%rdi
    4dbd:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    4dc4:	00 00 00 
    4dc7:	ff d0                	call   *%rax
    4dc9:	89 45 fc             	mov    %eax,-0x4(%rbp)
    4dcc:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    4dd0:	78 19                	js     4deb <dirfile+0xf2>
    4dd2:	48 b8 23 82 00 00 00 	movabs $0x8223,%rax
    4dd9:	00 00 00 
    4ddc:	48 89 c7             	mov    %rax,%rdi
    4ddf:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4de6:	00 00 00 
    4de9:	ff d0                	call   *%rax
    4deb:	48 b8 18 82 00 00 00 	movabs $0x8218,%rax
    4df2:	00 00 00 
    4df5:	be 00 02 00 00       	mov    $0x200,%esi
    4dfa:	48 89 c7             	mov    %rax,%rdi
    4dfd:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    4e04:	00 00 00 
    4e07:	ff d0                	call   *%rax
    4e09:	89 45 fc             	mov    %eax,-0x4(%rbp)
    4e0c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    4e10:	78 19                	js     4e2b <dirfile+0x132>
    4e12:	48 b8 23 82 00 00 00 	movabs $0x8223,%rax
    4e19:	00 00 00 
    4e1c:	48 89 c7             	mov    %rax,%rdi
    4e1f:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4e26:	00 00 00 
    4e29:	ff d0                	call   *%rax
    4e2b:	48 b8 18 82 00 00 00 	movabs $0x8218,%rax
    4e32:	00 00 00 
    4e35:	48 89 c7             	mov    %rax,%rdi
    4e38:	48 b8 1d 68 00 00 00 	movabs $0x681d,%rax
    4e3f:	00 00 00 
    4e42:	ff d0                	call   *%rax
    4e44:	85 c0                	test   %eax,%eax
    4e46:	75 19                	jne    4e61 <dirfile+0x168>
    4e48:	48 b8 3f 82 00 00 00 	movabs $0x823f,%rax
    4e4f:	00 00 00 
    4e52:	48 89 c7             	mov    %rax,%rdi
    4e55:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4e5c:	00 00 00 
    4e5f:	ff d0                	call   *%rax
    4e61:	48 b8 18 82 00 00 00 	movabs $0x8218,%rax
    4e68:	00 00 00 
    4e6b:	48 89 c7             	mov    %rax,%rdi
    4e6e:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    4e75:	00 00 00 
    4e78:	ff d0                	call   *%rax
    4e7a:	85 c0                	test   %eax,%eax
    4e7c:	75 19                	jne    4e97 <dirfile+0x19e>
    4e7e:	48 b8 5a 82 00 00 00 	movabs $0x825a,%rax
    4e85:	00 00 00 
    4e88:	48 89 c7             	mov    %rax,%rdi
    4e8b:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4e92:	00 00 00 
    4e95:	ff d0                	call   *%rax
    4e97:	48 ba 18 82 00 00 00 	movabs $0x8218,%rdx
    4e9e:	00 00 00 
    4ea1:	48 b8 76 82 00 00 00 	movabs $0x8276,%rax
    4ea8:	00 00 00 
    4eab:	48 89 d6             	mov    %rdx,%rsi
    4eae:	48 89 c7             	mov    %rax,%rdi
    4eb1:	48 b8 10 68 00 00 00 	movabs $0x6810,%rax
    4eb8:	00 00 00 
    4ebb:	ff d0                	call   *%rax
    4ebd:	85 c0                	test   %eax,%eax
    4ebf:	75 19                	jne    4eda <dirfile+0x1e1>
    4ec1:	48 b8 7d 82 00 00 00 	movabs $0x827d,%rax
    4ec8:	00 00 00 
    4ecb:	48 89 c7             	mov    %rax,%rdi
    4ece:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4ed5:	00 00 00 
    4ed8:	ff d0                	call   *%rax
    4eda:	48 b8 e9 81 00 00 00 	movabs $0x81e9,%rax
    4ee1:	00 00 00 
    4ee4:	48 89 c7             	mov    %rax,%rdi
    4ee7:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    4eee:	00 00 00 
    4ef1:	ff d0                	call   *%rax
    4ef3:	85 c0                	test   %eax,%eax
    4ef5:	74 19                	je     4f10 <dirfile+0x217>
    4ef7:	48 b8 9a 82 00 00 00 	movabs $0x829a,%rax
    4efe:	00 00 00 
    4f01:	48 89 c7             	mov    %rax,%rdi
    4f04:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4f0b:	00 00 00 
    4f0e:	ff d0                	call   *%rax
    4f10:	48 b8 7a 79 00 00 00 	movabs $0x797a,%rax
    4f17:	00 00 00 
    4f1a:	be 02 00 00 00       	mov    $0x2,%esi
    4f1f:	48 89 c7             	mov    %rax,%rdi
    4f22:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    4f29:	00 00 00 
    4f2c:	ff d0                	call   *%rax
    4f2e:	89 45 fc             	mov    %eax,-0x4(%rbp)
    4f31:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    4f35:	78 19                	js     4f50 <dirfile+0x257>
    4f37:	48 b8 a9 82 00 00 00 	movabs $0x82a9,%rax
    4f3e:	00 00 00 
    4f41:	48 89 c7             	mov    %rax,%rdi
    4f44:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4f4b:	00 00 00 
    4f4e:	ff d0                	call   *%rax
    4f50:	48 b8 7a 79 00 00 00 	movabs $0x797a,%rax
    4f57:	00 00 00 
    4f5a:	be 00 00 00 00       	mov    $0x0,%esi
    4f5f:	48 89 c7             	mov    %rax,%rdi
    4f62:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    4f69:	00 00 00 
    4f6c:	ff d0                	call   *%rax
    4f6e:	89 45 fc             	mov    %eax,-0x4(%rbp)
    4f71:	48 b9 fe 75 00 00 00 	movabs $0x75fe,%rcx
    4f78:	00 00 00 
    4f7b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    4f7e:	ba 01 00 00 00       	mov    $0x1,%edx
    4f83:	48 89 ce             	mov    %rcx,%rsi
    4f86:	89 c7                	mov    %eax,%edi
    4f88:	48 b8 a8 67 00 00 00 	movabs $0x67a8,%rax
    4f8f:	00 00 00 
    4f92:	ff d0                	call   *%rax
    4f94:	85 c0                	test   %eax,%eax
    4f96:	7e 19                	jle    4fb1 <dirfile+0x2b8>
    4f98:	48 b8 c6 82 00 00 00 	movabs $0x82c6,%rax
    4f9f:	00 00 00 
    4fa2:	48 89 c7             	mov    %rax,%rdi
    4fa5:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4fac:	00 00 00 
    4faf:	ff d0                	call   *%rax
    4fb1:	8b 45 fc             	mov    -0x4(%rbp),%eax
    4fb4:	89 c7                	mov    %eax,%edi
    4fb6:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    4fbd:	00 00 00 
    4fc0:	ff d0                	call   *%rax
    4fc2:	48 b8 d8 82 00 00 00 	movabs $0x82d8,%rax
    4fc9:	00 00 00 
    4fcc:	48 89 c6             	mov    %rax,%rsi
    4fcf:	bf 01 00 00 00       	mov    $0x1,%edi
    4fd4:	b8 00 00 00 00       	mov    $0x0,%eax
    4fd9:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    4fe0:	00 00 00 
    4fe3:	ff d2                	call   *%rdx
    4fe5:	90                   	nop
    4fe6:	c9                   	leave
    4fe7:	c3                   	ret

0000000000004fe8 <iref>:
    4fe8:	55                   	push   %rbp
    4fe9:	48 89 e5             	mov    %rsp,%rbp
    4fec:	48 83 ec 10          	sub    $0x10,%rsp
    4ff0:	48 b8 e8 82 00 00 00 	movabs $0x82e8,%rax
    4ff7:	00 00 00 
    4ffa:	48 89 c6             	mov    %rax,%rsi
    4ffd:	bf 01 00 00 00       	mov    $0x1,%edi
    5002:	b8 00 00 00 00       	mov    $0x0,%eax
    5007:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    500e:	00 00 00 
    5011:	ff d2                	call   *%rdx
    5013:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    501a:	e9 38 01 00 00       	jmp    5157 <iref+0x16f>
    501f:	48 b8 f9 82 00 00 00 	movabs $0x82f9,%rax
    5026:	00 00 00 
    5029:	48 89 c7             	mov    %rax,%rdi
    502c:	48 b8 1d 68 00 00 00 	movabs $0x681d,%rax
    5033:	00 00 00 
    5036:	ff d0                	call   *%rax
    5038:	85 c0                	test   %eax,%eax
    503a:	74 19                	je     5055 <iref+0x6d>
    503c:	48 b8 ff 82 00 00 00 	movabs $0x82ff,%rax
    5043:	00 00 00 
    5046:	48 89 c7             	mov    %rax,%rdi
    5049:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    5050:	00 00 00 
    5053:	ff d0                	call   *%rax
    5055:	48 b8 f9 82 00 00 00 	movabs $0x82f9,%rax
    505c:	00 00 00 
    505f:	48 89 c7             	mov    %rax,%rdi
    5062:	48 b8 2a 68 00 00 00 	movabs $0x682a,%rax
    5069:	00 00 00 
    506c:	ff d0                	call   *%rax
    506e:	85 c0                	test   %eax,%eax
    5070:	74 19                	je     508b <iref+0xa3>
    5072:	48 b8 0b 83 00 00 00 	movabs $0x830b,%rax
    5079:	00 00 00 
    507c:	48 89 c7             	mov    %rax,%rdi
    507f:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    5086:	00 00 00 
    5089:	ff d0                	call   *%rax
    508b:	48 b8 17 83 00 00 00 	movabs $0x8317,%rax
    5092:	00 00 00 
    5095:	48 89 c7             	mov    %rax,%rdi
    5098:	48 b8 1d 68 00 00 00 	movabs $0x681d,%rax
    509f:	00 00 00 
    50a2:	ff d0                	call   *%rax
    50a4:	48 ba 17 83 00 00 00 	movabs $0x8317,%rdx
    50ab:	00 00 00 
    50ae:	48 b8 76 82 00 00 00 	movabs $0x8276,%rax
    50b5:	00 00 00 
    50b8:	48 89 d6             	mov    %rdx,%rsi
    50bb:	48 89 c7             	mov    %rax,%rdi
    50be:	48 b8 10 68 00 00 00 	movabs $0x6810,%rax
    50c5:	00 00 00 
    50c8:	ff d0                	call   *%rax
    50ca:	48 b8 17 83 00 00 00 	movabs $0x8317,%rax
    50d1:	00 00 00 
    50d4:	be 00 02 00 00       	mov    $0x200,%esi
    50d9:	48 89 c7             	mov    %rax,%rdi
    50dc:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    50e3:	00 00 00 
    50e6:	ff d0                	call   *%rax
    50e8:	89 45 f8             	mov    %eax,-0x8(%rbp)
    50eb:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    50ef:	78 11                	js     5102 <iref+0x11a>
    50f1:	8b 45 f8             	mov    -0x8(%rbp),%eax
    50f4:	89 c7                	mov    %eax,%edi
    50f6:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    50fd:	00 00 00 
    5100:	ff d0                	call   *%rax
    5102:	48 b8 18 83 00 00 00 	movabs $0x8318,%rax
    5109:	00 00 00 
    510c:	be 00 02 00 00       	mov    $0x200,%esi
    5111:	48 89 c7             	mov    %rax,%rdi
    5114:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    511b:	00 00 00 
    511e:	ff d0                	call   *%rax
    5120:	89 45 f8             	mov    %eax,-0x8(%rbp)
    5123:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    5127:	78 11                	js     513a <iref+0x152>
    5129:	8b 45 f8             	mov    -0x8(%rbp),%eax
    512c:	89 c7                	mov    %eax,%edi
    512e:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    5135:	00 00 00 
    5138:	ff d0                	call   *%rax
    513a:	48 b8 18 83 00 00 00 	movabs $0x8318,%rax
    5141:	00 00 00 
    5144:	48 89 c7             	mov    %rax,%rdi
    5147:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    514e:	00 00 00 
    5151:	ff d0                	call   *%rax
    5153:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    5157:	83 7d fc 32          	cmpl   $0x32,-0x4(%rbp)
    515b:	0f 8e be fe ff ff    	jle    501f <iref+0x37>
    5161:	48 b8 e8 71 00 00 00 	movabs $0x71e8,%rax
    5168:	00 00 00 
    516b:	48 89 c7             	mov    %rax,%rdi
    516e:	48 b8 2a 68 00 00 00 	movabs $0x682a,%rax
    5175:	00 00 00 
    5178:	ff d0                	call   *%rax
    517a:	48 b8 1b 83 00 00 00 	movabs $0x831b,%rax
    5181:	00 00 00 
    5184:	48 89 c6             	mov    %rax,%rsi
    5187:	bf 01 00 00 00       	mov    $0x1,%edi
    518c:	b8 00 00 00 00       	mov    $0x0,%eax
    5191:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    5198:	00 00 00 
    519b:	ff d2                	call   *%rdx
    519d:	90                   	nop
    519e:	c9                   	leave
    519f:	c3                   	ret

00000000000051a0 <forktest>:
    51a0:	55                   	push   %rbp
    51a1:	48 89 e5             	mov    %rsp,%rbp
    51a4:	48 83 ec 10          	sub    $0x10,%rsp
    51a8:	48 b8 2f 83 00 00 00 	movabs $0x832f,%rax
    51af:	00 00 00 
    51b2:	48 89 c6             	mov    %rax,%rsi
    51b5:	bf 01 00 00 00       	mov    $0x1,%edi
    51ba:	b8 00 00 00 00       	mov    $0x0,%eax
    51bf:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    51c6:	00 00 00 
    51c9:	ff d2                	call   *%rdx
    51cb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    51d2:	eb 2b                	jmp    51ff <forktest+0x5f>
    51d4:	48 b8 67 67 00 00 00 	movabs $0x6767,%rax
    51db:	00 00 00 
    51de:	ff d0                	call   *%rax
    51e0:	89 45 f8             	mov    %eax,-0x8(%rbp)
    51e3:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    51e7:	78 21                	js     520a <forktest+0x6a>
    51e9:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    51ed:	75 0c                	jne    51fb <forktest+0x5b>
    51ef:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    51f6:	00 00 00 
    51f9:	ff d0                	call   *%rax
    51fb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    51ff:	81 7d fc e7 03 00 00 	cmpl   $0x3e7,-0x4(%rbp)
    5206:	7e cc                	jle    51d4 <forktest+0x34>
    5208:	eb 01                	jmp    520b <forktest+0x6b>
    520a:	90                   	nop
    520b:	81 7d fc e8 03 00 00 	cmpl   $0x3e8,-0x4(%rbp)
    5212:	75 48                	jne    525c <forktest+0xbc>
    5214:	48 b8 40 83 00 00 00 	movabs $0x8340,%rax
    521b:	00 00 00 
    521e:	48 89 c7             	mov    %rax,%rdi
    5221:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    5228:	00 00 00 
    522b:	ff d0                	call   *%rax
    522d:	eb 2d                	jmp    525c <forktest+0xbc>
    522f:	48 b8 81 67 00 00 00 	movabs $0x6781,%rax
    5236:	00 00 00 
    5239:	ff d0                	call   *%rax
    523b:	85 c0                	test   %eax,%eax
    523d:	79 19                	jns    5258 <forktest+0xb8>
    523f:	48 b8 60 83 00 00 00 	movabs $0x8360,%rax
    5246:	00 00 00 
    5249:	48 89 c7             	mov    %rax,%rdi
    524c:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    5253:	00 00 00 
    5256:	ff d0                	call   *%rax
    5258:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
    525c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    5260:	7f cd                	jg     522f <forktest+0x8f>
    5262:	48 b8 81 67 00 00 00 	movabs $0x6781,%rax
    5269:	00 00 00 
    526c:	ff d0                	call   *%rax
    526e:	83 f8 ff             	cmp    $0xffffffff,%eax
    5271:	74 19                	je     528c <forktest+0xec>
    5273:	48 b8 73 83 00 00 00 	movabs $0x8373,%rax
    527a:	00 00 00 
    527d:	48 89 c7             	mov    %rax,%rdi
    5280:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    5287:	00 00 00 
    528a:	ff d0                	call   *%rax
    528c:	48 b8 85 83 00 00 00 	movabs $0x8385,%rax
    5293:	00 00 00 
    5296:	48 89 c6             	mov    %rax,%rsi
    5299:	bf 01 00 00 00       	mov    $0x1,%edi
    529e:	b8 00 00 00 00       	mov    $0x0,%eax
    52a3:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    52aa:	00 00 00 
    52ad:	ff d2                	call   *%rdx
    52af:	90                   	nop
    52b0:	c9                   	leave
    52b1:	c3                   	ret

00000000000052b2 <sbrktest>:
    52b2:	55                   	push   %rbp
    52b3:	48 89 e5             	mov    %rsp,%rbp
    52b6:	48 81 ec 90 00 00 00 	sub    $0x90,%rsp
    52bd:	48 b8 93 83 00 00 00 	movabs $0x8393,%rax
    52c4:	00 00 00 
    52c7:	48 89 c6             	mov    %rax,%rsi
    52ca:	bf 01 00 00 00       	mov    $0x1,%edi
    52cf:	b8 00 00 00 00       	mov    $0x0,%eax
    52d4:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    52db:	00 00 00 
    52de:	ff d2                	call   *%rdx
    52e0:	bf 00 00 00 00       	mov    $0x0,%edi
    52e5:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    52ec:	00 00 00 
    52ef:	ff d0                	call   *%rax
    52f1:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    52f5:	bf 00 00 00 00       	mov    $0x0,%edi
    52fa:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    5301:	00 00 00 
    5304:	ff d0                	call   *%rax
    5306:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    530a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    5311:	eb 76                	jmp    5389 <sbrktest+0xd7>
    5313:	bf 01 00 00 00       	mov    $0x1,%edi
    5318:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    531f:	00 00 00 
    5322:	ff d0                	call   *%rax
    5324:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
    5328:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    532c:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
    5330:	74 40                	je     5372 <sbrktest+0xc0>
    5332:	48 8b 4d b0          	mov    -0x50(%rbp),%rcx
    5336:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
    533a:	8b 45 f4             	mov    -0xc(%rbp),%eax
    533d:	48 be 9e 83 00 00 00 	movabs $0x839e,%rsi
    5344:	00 00 00 
    5347:	49 89 c8             	mov    %rcx,%r8
    534a:	48 89 d1             	mov    %rdx,%rcx
    534d:	89 c2                	mov    %eax,%edx
    534f:	bf 01 00 00 00       	mov    $0x1,%edi
    5354:	b8 00 00 00 00       	mov    $0x0,%eax
    5359:	49 b9 78 6a 00 00 00 	movabs $0x6a78,%r9
    5360:	00 00 00 
    5363:	41 ff d1             	call   *%r9
    5366:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    536d:	00 00 00 
    5370:	ff d0                	call   *%rax
    5372:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    5376:	c6 00 01             	movb   $0x1,(%rax)
    5379:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    537d:	48 83 c0 01          	add    $0x1,%rax
    5381:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    5385:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
    5389:	81 7d f4 87 13 00 00 	cmpl   $0x1387,-0xc(%rbp)
    5390:	7e 81                	jle    5313 <sbrktest+0x61>
    5392:	48 b8 67 67 00 00 00 	movabs $0x6767,%rax
    5399:	00 00 00 
    539c:	ff d0                	call   *%rax
    539e:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    53a1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
    53a5:	79 19                	jns    53c0 <sbrktest+0x10e>
    53a7:	48 b8 b9 83 00 00 00 	movabs $0x83b9,%rax
    53ae:	00 00 00 
    53b1:	48 89 c7             	mov    %rax,%rdi
    53b4:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    53bb:	00 00 00 
    53be:	ff d0                	call   *%rax
    53c0:	bf 01 00 00 00       	mov    $0x1,%edi
    53c5:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    53cc:	00 00 00 
    53cf:	ff d0                	call   *%rax
    53d1:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    53d5:	bf 01 00 00 00       	mov    $0x1,%edi
    53da:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    53e1:	00 00 00 
    53e4:	ff d0                	call   *%rax
    53e6:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    53ea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    53ee:	48 83 c0 01          	add    $0x1,%rax
    53f2:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
    53f6:	74 19                	je     5411 <sbrktest+0x15f>
    53f8:	48 b8 c8 83 00 00 00 	movabs $0x83c8,%rax
    53ff:	00 00 00 
    5402:	48 89 c7             	mov    %rax,%rdi
    5405:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    540c:	00 00 00 
    540f:	ff d0                	call   *%rax
    5411:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
    5415:	75 0c                	jne    5423 <sbrktest+0x171>
    5417:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    541e:	00 00 00 
    5421:	ff d0                	call   *%rax
    5423:	48 b8 81 67 00 00 00 	movabs $0x6781,%rax
    542a:	00 00 00 
    542d:	ff d0                	call   *%rax
    542f:	bf 00 00 00 00       	mov    $0x0,%edi
    5434:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    543b:	00 00 00 
    543e:	ff d0                	call   *%rax
    5440:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    5444:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    5448:	89 c2                	mov    %eax,%edx
    544a:	b8 00 00 40 06       	mov    $0x6400000,%eax
    544f:	29 d0                	sub    %edx,%eax
    5451:	89 45 d4             	mov    %eax,-0x2c(%rbp)
    5454:	8b 45 d4             	mov    -0x2c(%rbp),%eax
    5457:	48 89 c7             	mov    %rax,%rdi
    545a:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    5461:	00 00 00 
    5464:	ff d0                	call   *%rax
    5466:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    546a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    546e:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
    5472:	74 19                	je     548d <sbrktest+0x1db>
    5474:	48 b8 e8 83 00 00 00 	movabs $0x83e8,%rax
    547b:	00 00 00 
    547e:	48 89 c7             	mov    %rax,%rdi
    5481:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    5488:	00 00 00 
    548b:	ff d0                	call   *%rax
    548d:	48 c7 45 c0 ff ff 3f 	movq   $0x63fffff,-0x40(%rbp)
    5494:	06 
    5495:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
    5499:	c6 00 63             	movb   $0x63,(%rax)
    549c:	bf 00 00 00 00       	mov    $0x0,%edi
    54a1:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    54a8:	00 00 00 
    54ab:	ff d0                	call   *%rax
    54ad:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    54b1:	48 c7 c7 00 f0 ff ff 	mov    $0xfffffffffffff000,%rdi
    54b8:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    54bf:	00 00 00 
    54c2:	ff d0                	call   *%rax
    54c4:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    54c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    54cd:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
    54d1:	75 19                	jne    54ec <sbrktest+0x23a>
    54d3:	48 b8 25 84 00 00 00 	movabs $0x8425,%rax
    54da:	00 00 00 
    54dd:	48 89 c7             	mov    %rax,%rdi
    54e0:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    54e7:	00 00 00 
    54ea:	ff d0                	call   *%rax
    54ec:	bf 00 00 00 00       	mov    $0x0,%edi
    54f1:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    54f8:	00 00 00 
    54fb:	ff d0                	call   *%rax
    54fd:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    5501:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    5505:	48 2d 00 10 00 00    	sub    $0x1000,%rax
    550b:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
    550f:	74 3b                	je     554c <sbrktest+0x29a>
    5511:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
    5515:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    5519:	48 be 40 84 00 00 00 	movabs $0x8440,%rsi
    5520:	00 00 00 
    5523:	48 89 d1             	mov    %rdx,%rcx
    5526:	48 89 c2             	mov    %rax,%rdx
    5529:	bf 01 00 00 00       	mov    $0x1,%edi
    552e:	b8 00 00 00 00       	mov    $0x0,%eax
    5533:	49 b8 78 6a 00 00 00 	movabs $0x6a78,%r8
    553a:	00 00 00 
    553d:	41 ff d0             	call   *%r8
    5540:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    5547:	00 00 00 
    554a:	ff d0                	call   *%rax
    554c:	bf 00 00 00 00       	mov    $0x0,%edi
    5551:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    5558:	00 00 00 
    555b:	ff d0                	call   *%rax
    555d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    5561:	bf 00 10 00 00       	mov    $0x1000,%edi
    5566:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    556d:	00 00 00 
    5570:	ff d0                	call   *%rax
    5572:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    5576:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    557a:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
    557e:	75 21                	jne    55a1 <sbrktest+0x2ef>
    5580:	bf 00 00 00 00       	mov    $0x0,%edi
    5585:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    558c:	00 00 00 
    558f:	ff d0                	call   *%rax
    5591:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
    5595:	48 81 c2 00 10 00 00 	add    $0x1000,%rdx
    559c:	48 39 d0             	cmp    %rdx,%rax
    559f:	74 3b                	je     55dc <sbrktest+0x32a>
    55a1:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
    55a5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    55a9:	48 be 78 84 00 00 00 	movabs $0x8478,%rsi
    55b0:	00 00 00 
    55b3:	48 89 d1             	mov    %rdx,%rcx
    55b6:	48 89 c2             	mov    %rax,%rdx
    55b9:	bf 01 00 00 00       	mov    $0x1,%edi
    55be:	b8 00 00 00 00       	mov    $0x0,%eax
    55c3:	49 b8 78 6a 00 00 00 	movabs $0x6a78,%r8
    55ca:	00 00 00 
    55cd:	41 ff d0             	call   *%r8
    55d0:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    55d7:	00 00 00 
    55da:	ff d0                	call   *%rax
    55dc:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
    55e0:	0f b6 00             	movzbl (%rax),%eax
    55e3:	3c 63                	cmp    $0x63,%al
    55e5:	75 19                	jne    5600 <sbrktest+0x34e>
    55e7:	48 b8 a0 84 00 00 00 	movabs $0x84a0,%rax
    55ee:	00 00 00 
    55f1:	48 89 c7             	mov    %rax,%rdi
    55f4:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    55fb:	00 00 00 
    55fe:	ff d0                	call   *%rax
    5600:	bf 00 00 00 00       	mov    $0x0,%edi
    5605:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    560c:	00 00 00 
    560f:	ff d0                	call   *%rax
    5611:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    5615:	bf 00 00 00 00       	mov    $0x0,%edi
    561a:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    5621:	00 00 00 
    5624:	ff d0                	call   *%rax
    5626:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
    562a:	48 29 c2             	sub    %rax,%rdx
    562d:	48 89 d0             	mov    %rdx,%rax
    5630:	48 89 c7             	mov    %rax,%rdi
    5633:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    563a:	00 00 00 
    563d:	ff d0                	call   *%rax
    563f:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    5643:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    5647:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
    564b:	74 3b                	je     5688 <sbrktest+0x3d6>
    564d:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
    5651:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    5655:	48 be d0 84 00 00 00 	movabs $0x84d0,%rsi
    565c:	00 00 00 
    565f:	48 89 d1             	mov    %rdx,%rcx
    5662:	48 89 c2             	mov    %rax,%rdx
    5665:	bf 01 00 00 00       	mov    $0x1,%edi
    566a:	b8 00 00 00 00       	mov    $0x0,%eax
    566f:	49 b8 78 6a 00 00 00 	movabs $0x6a78,%r8
    5676:	00 00 00 
    5679:	41 ff d0             	call   *%r8
    567c:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    5683:	00 00 00 
    5686:	ff d0                	call   *%rax
    5688:	48 b8 f8 84 00 00 00 	movabs $0x84f8,%rax
    568f:	00 00 00 
    5692:	48 89 c6             	mov    %rax,%rsi
    5695:	bf 01 00 00 00       	mov    $0x1,%edi
    569a:	b8 00 00 00 00       	mov    $0x0,%eax
    569f:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    56a6:	00 00 00 
    56a9:	ff d2                	call   *%rdx
    56ab:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
    56b2:	80 ff ff 
    56b5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    56b9:	e9 a8 00 00 00       	jmp    5766 <sbrktest+0x4b4>
    56be:	48 b8 44 68 00 00 00 	movabs $0x6844,%rax
    56c5:	00 00 00 
    56c8:	ff d0                	call   *%rax
    56ca:	89 45 b8             	mov    %eax,-0x48(%rbp)
    56cd:	48 b8 67 67 00 00 00 	movabs $0x6767,%rax
    56d4:	00 00 00 
    56d7:	ff d0                	call   *%rax
    56d9:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    56dc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
    56e0:	79 19                	jns    56fb <sbrktest+0x449>
    56e2:	48 b8 0f 72 00 00 00 	movabs $0x720f,%rax
    56e9:	00 00 00 
    56ec:	48 89 c7             	mov    %rax,%rdi
    56ef:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    56f6:	00 00 00 
    56f9:	ff d0                	call   *%rax
    56fb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
    56ff:	75 51                	jne    5752 <sbrktest+0x4a0>
    5701:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    5705:	0f b6 00             	movzbl (%rax),%eax
    5708:	0f be d0             	movsbl %al,%edx
    570b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    570f:	48 be 18 85 00 00 00 	movabs $0x8518,%rsi
    5716:	00 00 00 
    5719:	89 d1                	mov    %edx,%ecx
    571b:	48 89 c2             	mov    %rax,%rdx
    571e:	bf 01 00 00 00       	mov    $0x1,%edi
    5723:	b8 00 00 00 00       	mov    $0x0,%eax
    5728:	49 b8 78 6a 00 00 00 	movabs $0x6a78,%r8
    572f:	00 00 00 
    5732:	41 ff d0             	call   *%r8
    5735:	8b 45 b8             	mov    -0x48(%rbp),%eax
    5738:	89 c7                	mov    %eax,%edi
    573a:	48 b8 c2 67 00 00 00 	movabs $0x67c2,%rax
    5741:	00 00 00 
    5744:	ff d0                	call   *%rax
    5746:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    574d:	00 00 00 
    5750:	ff d0                	call   *%rax
    5752:	48 b8 81 67 00 00 00 	movabs $0x6781,%rax
    5759:	00 00 00 
    575c:	ff d0                	call   *%rax
    575e:	48 81 45 f8 a0 86 01 	addq   $0x186a0,-0x8(%rbp)
    5765:	00 
    5766:	48 b8 3f 42 0f 00 00 	movabs $0xffff8000000f423f,%rax
    576d:	80 ff ff 
    5770:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
    5774:	0f 83 44 ff ff ff    	jae    56be <sbrktest+0x40c>
    577a:	48 8d 45 a8          	lea    -0x58(%rbp),%rax
    577e:	48 89 c7             	mov    %rax,%rdi
    5781:	48 b8 8e 67 00 00 00 	movabs $0x678e,%rax
    5788:	00 00 00 
    578b:	ff d0                	call   *%rax
    578d:	85 c0                	test   %eax,%eax
    578f:	74 19                	je     57aa <sbrktest+0x4f8>
    5791:	48 b8 ab 75 00 00 00 	movabs $0x75ab,%rax
    5798:	00 00 00 
    579b:	48 89 c7             	mov    %rax,%rdi
    579e:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    57a5:	00 00 00 
    57a8:	ff d0                	call   *%rax
    57aa:	48 b8 31 85 00 00 00 	movabs $0x8531,%rax
    57b1:	00 00 00 
    57b4:	48 89 c6             	mov    %rax,%rsi
    57b7:	bf 01 00 00 00       	mov    $0x1,%edi
    57bc:	b8 00 00 00 00       	mov    $0x0,%eax
    57c1:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    57c8:	00 00 00 
    57cb:	ff d2                	call   *%rdx
    57cd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    57d4:	e9 e6 00 00 00       	jmp    58bf <sbrktest+0x60d>
    57d9:	48 b8 67 67 00 00 00 	movabs $0x6767,%rax
    57e0:	00 00 00 
    57e3:	ff d0                	call   *%rax
    57e5:	8b 55 f4             	mov    -0xc(%rbp),%edx
    57e8:	48 63 d2             	movslq %edx,%rdx
    57eb:	89 44 95 80          	mov    %eax,-0x80(%rbp,%rdx,4)
    57ef:	8b 45 f4             	mov    -0xc(%rbp),%eax
    57f2:	48 98                	cltq
    57f4:	8b 44 85 80          	mov    -0x80(%rbp,%rax,4),%eax
    57f8:	85 c0                	test   %eax,%eax
    57fa:	0f 85 8d 00 00 00    	jne    588d <sbrktest+0x5db>
    5800:	bf 00 00 00 00       	mov    $0x0,%edi
    5805:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    580c:	00 00 00 
    580f:	ff d0                	call   *%rax
    5811:	48 89 c2             	mov    %rax,%rdx
    5814:	b8 00 00 40 06       	mov    $0x6400000,%eax
    5819:	48 29 d0             	sub    %rdx,%rax
    581c:	48 89 c7             	mov    %rax,%rdi
    581f:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    5826:	00 00 00 
    5829:	ff d0                	call   *%rax
    582b:	89 45 bc             	mov    %eax,-0x44(%rbp)
    582e:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
    5832:	79 23                	jns    5857 <sbrktest+0x5a5>
    5834:	48 b8 4c 85 00 00 00 	movabs $0x854c,%rax
    583b:	00 00 00 
    583e:	48 89 c6             	mov    %rax,%rsi
    5841:	bf 01 00 00 00       	mov    $0x1,%edi
    5846:	b8 00 00 00 00       	mov    $0x0,%eax
    584b:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    5852:	00 00 00 
    5855:	ff d2                	call   *%rdx
    5857:	8b 45 ac             	mov    -0x54(%rbp),%eax
    585a:	48 b9 fe 75 00 00 00 	movabs $0x75fe,%rcx
    5861:	00 00 00 
    5864:	ba 01 00 00 00       	mov    $0x1,%edx
    5869:	48 89 ce             	mov    %rcx,%rsi
    586c:	89 c7                	mov    %eax,%edi
    586e:	48 b8 a8 67 00 00 00 	movabs $0x67a8,%rax
    5875:	00 00 00 
    5878:	ff d0                	call   *%rax
    587a:	bf e8 03 00 00       	mov    $0x3e8,%edi
    587f:	48 b8 5e 68 00 00 00 	movabs $0x685e,%rax
    5886:	00 00 00 
    5889:	ff d0                	call   *%rax
    588b:	eb ed                	jmp    587a <sbrktest+0x5c8>
    588d:	8b 45 f4             	mov    -0xc(%rbp),%eax
    5890:	48 98                	cltq
    5892:	8b 44 85 80          	mov    -0x80(%rbp,%rax,4),%eax
    5896:	83 f8 ff             	cmp    $0xffffffff,%eax
    5899:	74 20                	je     58bb <sbrktest+0x609>
    589b:	8b 45 a8             	mov    -0x58(%rbp),%eax
    589e:	48 8d 8d 7f ff ff ff 	lea    -0x81(%rbp),%rcx
    58a5:	ba 01 00 00 00       	mov    $0x1,%edx
    58aa:	48 89 ce             	mov    %rcx,%rsi
    58ad:	89 c7                	mov    %eax,%edi
    58af:	48 b8 9b 67 00 00 00 	movabs $0x679b,%rax
    58b6:	00 00 00 
    58b9:	ff d0                	call   *%rax
    58bb:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
    58bf:	8b 45 f4             	mov    -0xc(%rbp),%eax
    58c2:	83 f8 09             	cmp    $0x9,%eax
    58c5:	0f 86 0e ff ff ff    	jbe    57d9 <sbrktest+0x527>
    58cb:	bf 00 10 00 00       	mov    $0x1000,%edi
    58d0:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    58d7:	00 00 00 
    58da:	ff d0                	call   *%rax
    58dc:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    58e0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    58e7:	eb 38                	jmp    5921 <sbrktest+0x66f>
    58e9:	8b 45 f4             	mov    -0xc(%rbp),%eax
    58ec:	48 98                	cltq
    58ee:	8b 44 85 80          	mov    -0x80(%rbp,%rax,4),%eax
    58f2:	83 f8 ff             	cmp    $0xffffffff,%eax
    58f5:	74 25                	je     591c <sbrktest+0x66a>
    58f7:	8b 45 f4             	mov    -0xc(%rbp),%eax
    58fa:	48 98                	cltq
    58fc:	8b 44 85 80          	mov    -0x80(%rbp,%rax,4),%eax
    5900:	89 c7                	mov    %eax,%edi
    5902:	48 b8 c2 67 00 00 00 	movabs $0x67c2,%rax
    5909:	00 00 00 
    590c:	ff d0                	call   *%rax
    590e:	48 b8 81 67 00 00 00 	movabs $0x6781,%rax
    5915:	00 00 00 
    5918:	ff d0                	call   *%rax
    591a:	eb 01                	jmp    591d <sbrktest+0x66b>
    591c:	90                   	nop
    591d:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
    5921:	8b 45 f4             	mov    -0xc(%rbp),%eax
    5924:	83 f8 09             	cmp    $0x9,%eax
    5927:	76 c0                	jbe    58e9 <sbrktest+0x637>
    5929:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    592e:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
    5932:	75 19                	jne    594d <sbrktest+0x69b>
    5934:	48 b8 6a 85 00 00 00 	movabs $0x856a,%rax
    593b:	00 00 00 
    593e:	48 89 c7             	mov    %rax,%rdi
    5941:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    5948:	00 00 00 
    594b:	ff d0                	call   *%rax
    594d:	bf 00 00 00 00       	mov    $0x0,%edi
    5952:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    5959:	00 00 00 
    595c:	ff d0                	call   *%rax
    595e:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
    5962:	73 2a                	jae    598e <sbrktest+0x6dc>
    5964:	bf 00 00 00 00       	mov    $0x0,%edi
    5969:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    5970:	00 00 00 
    5973:	ff d0                	call   *%rax
    5975:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
    5979:	48 29 c2             	sub    %rax,%rdx
    597c:	48 89 d0             	mov    %rdx,%rax
    597f:	48 89 c7             	mov    %rax,%rdi
    5982:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    5989:	00 00 00 
    598c:	ff d0                	call   *%rax
    598e:	48 b8 84 85 00 00 00 	movabs $0x8584,%rax
    5995:	00 00 00 
    5998:	48 89 c6             	mov    %rax,%rsi
    599b:	bf 01 00 00 00       	mov    $0x1,%edi
    59a0:	b8 00 00 00 00       	mov    $0x0,%eax
    59a5:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    59ac:	00 00 00 
    59af:	ff d2                	call   *%rdx
    59b1:	90                   	nop
    59b2:	c9                   	leave
    59b3:	c3                   	ret

00000000000059b4 <validatetest>:
    59b4:	55                   	push   %rbp
    59b5:	48 89 e5             	mov    %rsp,%rbp
    59b8:	48 83 ec 10          	sub    $0x10,%rsp
    59bc:	48 b8 92 85 00 00 00 	movabs $0x8592,%rax
    59c3:	00 00 00 
    59c6:	48 89 c6             	mov    %rax,%rsi
    59c9:	bf 01 00 00 00       	mov    $0x1,%edi
    59ce:	b8 00 00 00 00       	mov    $0x0,%eax
    59d3:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    59da:	00 00 00 
    59dd:	ff d2                	call   *%rdx
    59df:	c7 45 f4 00 30 11 00 	movl   $0x113000,-0xc(%rbp)
    59e6:	48 c7 45 f8 00 10 00 	movq   $0x1000,-0x8(%rbp)
    59ed:	00 
    59ee:	eb 46                	jmp    5a36 <validatetest+0x82>
    59f0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    59f4:	48 ba a1 85 00 00 00 	movabs $0x85a1,%rdx
    59fb:	00 00 00 
    59fe:	48 89 c6             	mov    %rax,%rsi
    5a01:	48 89 d7             	mov    %rdx,%rdi
    5a04:	48 b8 10 68 00 00 00 	movabs $0x6810,%rax
    5a0b:	00 00 00 
    5a0e:	ff d0                	call   *%rax
    5a10:	83 f8 ff             	cmp    $0xffffffff,%eax
    5a13:	74 19                	je     5a2e <validatetest+0x7a>
    5a15:	48 b8 ac 85 00 00 00 	movabs $0x85ac,%rax
    5a1c:	00 00 00 
    5a1f:	48 89 c7             	mov    %rax,%rdi
    5a22:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    5a29:	00 00 00 
    5a2c:	ff d0                	call   *%rax
    5a2e:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
    5a35:	00 
    5a36:	8b 45 f4             	mov    -0xc(%rbp),%eax
    5a39:	89 c0                	mov    %eax,%eax
    5a3b:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
    5a3f:	73 af                	jae    59f0 <validatetest+0x3c>
    5a41:	48 b8 c5 85 00 00 00 	movabs $0x85c5,%rax
    5a48:	00 00 00 
    5a4b:	48 89 c6             	mov    %rax,%rsi
    5a4e:	bf 01 00 00 00       	mov    $0x1,%edi
    5a53:	b8 00 00 00 00       	mov    $0x0,%eax
    5a58:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    5a5f:	00 00 00 
    5a62:	ff d2                	call   *%rdx
    5a64:	90                   	nop
    5a65:	c9                   	leave
    5a66:	c3                   	ret

0000000000005a67 <bsstest>:
    5a67:	55                   	push   %rbp
    5a68:	48 89 e5             	mov    %rsp,%rbp
    5a6b:	48 83 ec 10          	sub    $0x10,%rsp
    5a6f:	48 b8 d2 85 00 00 00 	movabs $0x85d2,%rax
    5a76:	00 00 00 
    5a79:	48 89 c6             	mov    %rax,%rsi
    5a7c:	bf 01 00 00 00       	mov    $0x1,%edi
    5a81:	b8 00 00 00 00       	mov    $0x0,%eax
    5a86:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    5a8d:	00 00 00 
    5a90:	ff d2                	call   *%rdx
    5a92:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    5a99:	eb 34                	jmp    5acf <bsstest+0x68>
    5a9b:	48 ba 40 a9 00 00 00 	movabs $0xa940,%rdx
    5aa2:	00 00 00 
    5aa5:	8b 45 fc             	mov    -0x4(%rbp),%eax
    5aa8:	48 98                	cltq
    5aaa:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    5aae:	84 c0                	test   %al,%al
    5ab0:	74 19                	je     5acb <bsstest+0x64>
    5ab2:	48 b8 dc 85 00 00 00 	movabs $0x85dc,%rax
    5ab9:	00 00 00 
    5abc:	48 89 c7             	mov    %rax,%rdi
    5abf:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    5ac6:	00 00 00 
    5ac9:	ff d0                	call   *%rax
    5acb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    5acf:	8b 45 fc             	mov    -0x4(%rbp),%eax
    5ad2:	3d 0f 27 00 00       	cmp    $0x270f,%eax
    5ad7:	76 c2                	jbe    5a9b <bsstest+0x34>
    5ad9:	48 b8 e5 85 00 00 00 	movabs $0x85e5,%rax
    5ae0:	00 00 00 
    5ae3:	48 89 c6             	mov    %rax,%rsi
    5ae6:	bf 01 00 00 00       	mov    $0x1,%edi
    5aeb:	b8 00 00 00 00       	mov    $0x0,%eax
    5af0:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    5af7:	00 00 00 
    5afa:	ff d2                	call   *%rdx
    5afc:	90                   	nop
    5afd:	c9                   	leave
    5afe:	c3                   	ret

0000000000005aff <bigargtest>:
    5aff:	55                   	push   %rbp
    5b00:	48 89 e5             	mov    %rsp,%rbp
    5b03:	48 83 ec 10          	sub    $0x10,%rsp
    5b07:	48 b8 f2 85 00 00 00 	movabs $0x85f2,%rax
    5b0e:	00 00 00 
    5b11:	48 89 c7             	mov    %rax,%rdi
    5b14:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    5b1b:	00 00 00 
    5b1e:	ff d0                	call   *%rax
    5b20:	48 b8 67 67 00 00 00 	movabs $0x6767,%rax
    5b27:	00 00 00 
    5b2a:	ff d0                	call   *%rax
    5b2c:	89 45 f8             	mov    %eax,-0x8(%rbp)
    5b2f:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    5b33:	0f 85 ef 00 00 00    	jne    5c28 <bigargtest+0x129>
    5b39:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    5b40:	eb 21                	jmp    5b63 <bigargtest+0x64>
    5b42:	48 ba 60 d0 00 00 00 	movabs $0xd060,%rdx
    5b49:	00 00 00 
    5b4c:	8b 45 fc             	mov    -0x4(%rbp),%eax
    5b4f:	48 98                	cltq
    5b51:	48 b9 00 86 00 00 00 	movabs $0x8600,%rcx
    5b58:	00 00 00 
    5b5b:	48 89 0c c2          	mov    %rcx,(%rdx,%rax,8)
    5b5f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    5b63:	83 7d fc 1e          	cmpl   $0x1e,-0x4(%rbp)
    5b67:	7e d9                	jle    5b42 <bigargtest+0x43>
    5b69:	48 b8 60 d0 00 00 00 	movabs $0xd060,%rax
    5b70:	00 00 00 
    5b73:	48 c7 80 f8 00 00 00 	movq   $0x0,0xf8(%rax)
    5b7a:	00 00 00 00 
    5b7e:	48 b8 dd 86 00 00 00 	movabs $0x86dd,%rax
    5b85:	00 00 00 
    5b88:	48 89 c6             	mov    %rax,%rsi
    5b8b:	bf 01 00 00 00       	mov    $0x1,%edi
    5b90:	b8 00 00 00 00       	mov    $0x0,%eax
    5b95:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    5b9c:	00 00 00 
    5b9f:	ff d2                	call   *%rdx
    5ba1:	48 ba 60 d0 00 00 00 	movabs $0xd060,%rdx
    5ba8:	00 00 00 
    5bab:	48 b8 80 71 00 00 00 	movabs $0x7180,%rax
    5bb2:	00 00 00 
    5bb5:	48 89 d6             	mov    %rdx,%rsi
    5bb8:	48 89 c7             	mov    %rax,%rdi
    5bbb:	48 b8 cf 67 00 00 00 	movabs $0x67cf,%rax
    5bc2:	00 00 00 
    5bc5:	ff d0                	call   *%rax
    5bc7:	48 b8 ea 86 00 00 00 	movabs $0x86ea,%rax
    5bce:	00 00 00 
    5bd1:	48 89 c6             	mov    %rax,%rsi
    5bd4:	bf 01 00 00 00       	mov    $0x1,%edi
    5bd9:	b8 00 00 00 00       	mov    $0x0,%eax
    5bde:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    5be5:	00 00 00 
    5be8:	ff d2                	call   *%rdx
    5bea:	48 b8 f2 85 00 00 00 	movabs $0x85f2,%rax
    5bf1:	00 00 00 
    5bf4:	be 00 02 00 00       	mov    $0x200,%esi
    5bf9:	48 89 c7             	mov    %rax,%rdi
    5bfc:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    5c03:	00 00 00 
    5c06:	ff d0                	call   *%rax
    5c08:	89 45 f4             	mov    %eax,-0xc(%rbp)
    5c0b:	8b 45 f4             	mov    -0xc(%rbp),%eax
    5c0e:	89 c7                	mov    %eax,%edi
    5c10:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    5c17:	00 00 00 
    5c1a:	ff d0                	call   *%rax
    5c1c:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    5c23:	00 00 00 
    5c26:	ff d0                	call   *%rax
    5c28:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    5c2c:	79 19                	jns    5c47 <bigargtest+0x148>
    5c2e:	48 b8 fa 86 00 00 00 	movabs $0x86fa,%rax
    5c35:	00 00 00 
    5c38:	48 89 c7             	mov    %rax,%rdi
    5c3b:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    5c42:	00 00 00 
    5c45:	ff d0                	call   *%rax
    5c47:	48 b8 81 67 00 00 00 	movabs $0x6781,%rax
    5c4e:	00 00 00 
    5c51:	ff d0                	call   *%rax
    5c53:	48 b8 f2 85 00 00 00 	movabs $0x85f2,%rax
    5c5a:	00 00 00 
    5c5d:	be 00 00 00 00       	mov    $0x0,%esi
    5c62:	48 89 c7             	mov    %rax,%rdi
    5c65:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    5c6c:	00 00 00 
    5c6f:	ff d0                	call   *%rax
    5c71:	89 45 f4             	mov    %eax,-0xc(%rbp)
    5c74:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    5c78:	79 19                	jns    5c93 <bigargtest+0x194>
    5c7a:	48 b8 0b 87 00 00 00 	movabs $0x870b,%rax
    5c81:	00 00 00 
    5c84:	48 89 c7             	mov    %rax,%rdi
    5c87:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    5c8e:	00 00 00 
    5c91:	ff d0                	call   *%rax
    5c93:	8b 45 f4             	mov    -0xc(%rbp),%eax
    5c96:	89 c7                	mov    %eax,%edi
    5c98:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    5c9f:	00 00 00 
    5ca2:	ff d0                	call   *%rax
    5ca4:	48 b8 f2 85 00 00 00 	movabs $0x85f2,%rax
    5cab:	00 00 00 
    5cae:	48 89 c7             	mov    %rax,%rdi
    5cb1:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    5cb8:	00 00 00 
    5cbb:	ff d0                	call   *%rax
    5cbd:	90                   	nop
    5cbe:	c9                   	leave
    5cbf:	c3                   	ret

0000000000005cc0 <fsfull>:
    5cc0:	55                   	push   %rbp
    5cc1:	48 89 e5             	mov    %rsp,%rbp
    5cc4:	48 83 ec 60          	sub    $0x60,%rsp
    5cc8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
    5ccf:	48 b8 17 87 00 00 00 	movabs $0x8717,%rax
    5cd6:	00 00 00 
    5cd9:	48 89 c6             	mov    %rax,%rsi
    5cdc:	bf 01 00 00 00       	mov    $0x1,%edi
    5ce1:	b8 00 00 00 00       	mov    $0x0,%eax
    5ce6:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    5ced:	00 00 00 
    5cf0:	ff d2                	call   *%rdx
    5cf2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    5cf9:	c6 45 a0 66          	movb   $0x66,-0x60(%rbp)
    5cfd:	8b 45 fc             	mov    -0x4(%rbp),%eax
    5d00:	48 63 d0             	movslq %eax,%rdx
    5d03:	48 69 d2 d3 4d 62 10 	imul   $0x10624dd3,%rdx,%rdx
    5d0a:	48 c1 ea 20          	shr    $0x20,%rdx
    5d0e:	c1 fa 06             	sar    $0x6,%edx
    5d11:	c1 f8 1f             	sar    $0x1f,%eax
    5d14:	29 c2                	sub    %eax,%edx
    5d16:	89 d0                	mov    %edx,%eax
    5d18:	83 c0 30             	add    $0x30,%eax
    5d1b:	88 45 a1             	mov    %al,-0x5f(%rbp)
    5d1e:	8b 55 fc             	mov    -0x4(%rbp),%edx
    5d21:	48 63 c2             	movslq %edx,%rax
    5d24:	48 69 c0 d3 4d 62 10 	imul   $0x10624dd3,%rax,%rax
    5d2b:	48 c1 e8 20          	shr    $0x20,%rax
    5d2f:	c1 f8 06             	sar    $0x6,%eax
    5d32:	89 d1                	mov    %edx,%ecx
    5d34:	c1 f9 1f             	sar    $0x1f,%ecx
    5d37:	29 c8                	sub    %ecx,%eax
    5d39:	69 c8 e8 03 00 00    	imul   $0x3e8,%eax,%ecx
    5d3f:	89 d0                	mov    %edx,%eax
    5d41:	29 c8                	sub    %ecx,%eax
    5d43:	48 63 d0             	movslq %eax,%rdx
    5d46:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
    5d4d:	48 c1 ea 20          	shr    $0x20,%rdx
    5d51:	c1 fa 05             	sar    $0x5,%edx
    5d54:	c1 f8 1f             	sar    $0x1f,%eax
    5d57:	29 c2                	sub    %eax,%edx
    5d59:	89 d0                	mov    %edx,%eax
    5d5b:	83 c0 30             	add    $0x30,%eax
    5d5e:	88 45 a2             	mov    %al,-0x5e(%rbp)
    5d61:	8b 55 fc             	mov    -0x4(%rbp),%edx
    5d64:	48 63 c2             	movslq %edx,%rax
    5d67:	48 69 c0 1f 85 eb 51 	imul   $0x51eb851f,%rax,%rax
    5d6e:	48 c1 e8 20          	shr    $0x20,%rax
    5d72:	c1 f8 05             	sar    $0x5,%eax
    5d75:	89 d1                	mov    %edx,%ecx
    5d77:	c1 f9 1f             	sar    $0x1f,%ecx
    5d7a:	29 c8                	sub    %ecx,%eax
    5d7c:	6b c8 64             	imul   $0x64,%eax,%ecx
    5d7f:	89 d0                	mov    %edx,%eax
    5d81:	29 c8                	sub    %ecx,%eax
    5d83:	48 63 d0             	movslq %eax,%rdx
    5d86:	48 69 d2 67 66 66 66 	imul   $0x66666667,%rdx,%rdx
    5d8d:	48 c1 ea 20          	shr    $0x20,%rdx
    5d91:	c1 fa 02             	sar    $0x2,%edx
    5d94:	c1 f8 1f             	sar    $0x1f,%eax
    5d97:	29 c2                	sub    %eax,%edx
    5d99:	89 d0                	mov    %edx,%eax
    5d9b:	83 c0 30             	add    $0x30,%eax
    5d9e:	88 45 a3             	mov    %al,-0x5d(%rbp)
    5da1:	8b 55 fc             	mov    -0x4(%rbp),%edx
    5da4:	48 63 c2             	movslq %edx,%rax
    5da7:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
    5dae:	48 c1 e8 20          	shr    $0x20,%rax
    5db2:	89 c1                	mov    %eax,%ecx
    5db4:	c1 f9 02             	sar    $0x2,%ecx
    5db7:	89 d0                	mov    %edx,%eax
    5db9:	c1 f8 1f             	sar    $0x1f,%eax
    5dbc:	29 c1                	sub    %eax,%ecx
    5dbe:	89 c8                	mov    %ecx,%eax
    5dc0:	c1 e0 02             	shl    $0x2,%eax
    5dc3:	01 c8                	add    %ecx,%eax
    5dc5:	01 c0                	add    %eax,%eax
    5dc7:	89 d1                	mov    %edx,%ecx
    5dc9:	29 c1                	sub    %eax,%ecx
    5dcb:	89 c8                	mov    %ecx,%eax
    5dcd:	83 c0 30             	add    $0x30,%eax
    5dd0:	88 45 a4             	mov    %al,-0x5c(%rbp)
    5dd3:	c6 45 a5 00          	movb   $0x0,-0x5b(%rbp)
    5dd7:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
    5ddb:	48 b9 24 87 00 00 00 	movabs $0x8724,%rcx
    5de2:	00 00 00 
    5de5:	48 89 c2             	mov    %rax,%rdx
    5de8:	48 89 ce             	mov    %rcx,%rsi
    5deb:	bf 01 00 00 00       	mov    $0x1,%edi
    5df0:	b8 00 00 00 00       	mov    $0x0,%eax
    5df5:	48 b9 78 6a 00 00 00 	movabs $0x6a78,%rcx
    5dfc:	00 00 00 
    5dff:	ff d1                	call   *%rcx
    5e01:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
    5e05:	be 02 02 00 00       	mov    $0x202,%esi
    5e0a:	48 89 c7             	mov    %rax,%rdi
    5e0d:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    5e14:	00 00 00 
    5e17:	ff d0                	call   *%rax
    5e19:	89 45 f0             	mov    %eax,-0x10(%rbp)
    5e1c:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    5e20:	79 2f                	jns    5e51 <fsfull+0x191>
    5e22:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
    5e26:	48 b9 30 87 00 00 00 	movabs $0x8730,%rcx
    5e2d:	00 00 00 
    5e30:	48 89 c2             	mov    %rax,%rdx
    5e33:	48 89 ce             	mov    %rcx,%rsi
    5e36:	bf 01 00 00 00       	mov    $0x1,%edi
    5e3b:	b8 00 00 00 00       	mov    $0x0,%eax
    5e40:	48 b9 78 6a 00 00 00 	movabs $0x6a78,%rcx
    5e47:	00 00 00 
    5e4a:	ff d1                	call   *%rcx
    5e4c:	e9 8c 00 00 00       	jmp    5edd <fsfull+0x21d>
    5e51:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    5e58:	48 b9 20 89 00 00 00 	movabs $0x8920,%rcx
    5e5f:	00 00 00 
    5e62:	8b 45 f0             	mov    -0x10(%rbp),%eax
    5e65:	ba 00 02 00 00       	mov    $0x200,%edx
    5e6a:	48 89 ce             	mov    %rcx,%rsi
    5e6d:	89 c7                	mov    %eax,%edi
    5e6f:	48 b8 a8 67 00 00 00 	movabs $0x67a8,%rax
    5e76:	00 00 00 
    5e79:	ff d0                	call   *%rax
    5e7b:	89 45 ec             	mov    %eax,-0x14(%rbp)
    5e7e:	81 7d ec ff 01 00 00 	cmpl   $0x1ff,-0x14(%rbp)
    5e85:	7e 0c                	jle    5e93 <fsfull+0x1d3>
    5e87:	8b 45 ec             	mov    -0x14(%rbp),%eax
    5e8a:	01 45 f4             	add    %eax,-0xc(%rbp)
    5e8d:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    5e91:	eb c5                	jmp    5e58 <fsfull+0x198>
    5e93:	90                   	nop
    5e94:	8b 45 f4             	mov    -0xc(%rbp),%eax
    5e97:	48 b9 40 87 00 00 00 	movabs $0x8740,%rcx
    5e9e:	00 00 00 
    5ea1:	89 c2                	mov    %eax,%edx
    5ea3:	48 89 ce             	mov    %rcx,%rsi
    5ea6:	bf 01 00 00 00       	mov    $0x1,%edi
    5eab:	b8 00 00 00 00       	mov    $0x0,%eax
    5eb0:	48 b9 78 6a 00 00 00 	movabs $0x6a78,%rcx
    5eb7:	00 00 00 
    5eba:	ff d1                	call   *%rcx
    5ebc:	8b 45 f0             	mov    -0x10(%rbp),%eax
    5ebf:	89 c7                	mov    %eax,%edi
    5ec1:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    5ec8:	00 00 00 
    5ecb:	ff d0                	call   *%rax
    5ecd:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    5ed1:	74 09                	je     5edc <fsfull+0x21c>
    5ed3:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    5ed7:	e9 1d fe ff ff       	jmp    5cf9 <fsfull+0x39>
    5edc:	90                   	nop
    5edd:	e9 f5 00 00 00       	jmp    5fd7 <fsfull+0x317>
    5ee2:	c6 45 a0 66          	movb   $0x66,-0x60(%rbp)
    5ee6:	8b 45 fc             	mov    -0x4(%rbp),%eax
    5ee9:	48 63 d0             	movslq %eax,%rdx
    5eec:	48 69 d2 d3 4d 62 10 	imul   $0x10624dd3,%rdx,%rdx
    5ef3:	48 c1 ea 20          	shr    $0x20,%rdx
    5ef7:	c1 fa 06             	sar    $0x6,%edx
    5efa:	c1 f8 1f             	sar    $0x1f,%eax
    5efd:	29 c2                	sub    %eax,%edx
    5eff:	89 d0                	mov    %edx,%eax
    5f01:	83 c0 30             	add    $0x30,%eax
    5f04:	88 45 a1             	mov    %al,-0x5f(%rbp)
    5f07:	8b 55 fc             	mov    -0x4(%rbp),%edx
    5f0a:	48 63 c2             	movslq %edx,%rax
    5f0d:	48 69 c0 d3 4d 62 10 	imul   $0x10624dd3,%rax,%rax
    5f14:	48 c1 e8 20          	shr    $0x20,%rax
    5f18:	c1 f8 06             	sar    $0x6,%eax
    5f1b:	89 d1                	mov    %edx,%ecx
    5f1d:	c1 f9 1f             	sar    $0x1f,%ecx
    5f20:	29 c8                	sub    %ecx,%eax
    5f22:	69 c8 e8 03 00 00    	imul   $0x3e8,%eax,%ecx
    5f28:	89 d0                	mov    %edx,%eax
    5f2a:	29 c8                	sub    %ecx,%eax
    5f2c:	48 63 d0             	movslq %eax,%rdx
    5f2f:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
    5f36:	48 c1 ea 20          	shr    $0x20,%rdx
    5f3a:	c1 fa 05             	sar    $0x5,%edx
    5f3d:	c1 f8 1f             	sar    $0x1f,%eax
    5f40:	29 c2                	sub    %eax,%edx
    5f42:	89 d0                	mov    %edx,%eax
    5f44:	83 c0 30             	add    $0x30,%eax
    5f47:	88 45 a2             	mov    %al,-0x5e(%rbp)
    5f4a:	8b 55 fc             	mov    -0x4(%rbp),%edx
    5f4d:	48 63 c2             	movslq %edx,%rax
    5f50:	48 69 c0 1f 85 eb 51 	imul   $0x51eb851f,%rax,%rax
    5f57:	48 c1 e8 20          	shr    $0x20,%rax
    5f5b:	c1 f8 05             	sar    $0x5,%eax
    5f5e:	89 d1                	mov    %edx,%ecx
    5f60:	c1 f9 1f             	sar    $0x1f,%ecx
    5f63:	29 c8                	sub    %ecx,%eax
    5f65:	6b c8 64             	imul   $0x64,%eax,%ecx
    5f68:	89 d0                	mov    %edx,%eax
    5f6a:	29 c8                	sub    %ecx,%eax
    5f6c:	48 63 d0             	movslq %eax,%rdx
    5f6f:	48 69 d2 67 66 66 66 	imul   $0x66666667,%rdx,%rdx
    5f76:	48 c1 ea 20          	shr    $0x20,%rdx
    5f7a:	c1 fa 02             	sar    $0x2,%edx
    5f7d:	c1 f8 1f             	sar    $0x1f,%eax
    5f80:	29 c2                	sub    %eax,%edx
    5f82:	89 d0                	mov    %edx,%eax
    5f84:	83 c0 30             	add    $0x30,%eax
    5f87:	88 45 a3             	mov    %al,-0x5d(%rbp)
    5f8a:	8b 55 fc             	mov    -0x4(%rbp),%edx
    5f8d:	48 63 c2             	movslq %edx,%rax
    5f90:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
    5f97:	48 c1 e8 20          	shr    $0x20,%rax
    5f9b:	89 c1                	mov    %eax,%ecx
    5f9d:	c1 f9 02             	sar    $0x2,%ecx
    5fa0:	89 d0                	mov    %edx,%eax
    5fa2:	c1 f8 1f             	sar    $0x1f,%eax
    5fa5:	29 c1                	sub    %eax,%ecx
    5fa7:	89 c8                	mov    %ecx,%eax
    5fa9:	c1 e0 02             	shl    $0x2,%eax
    5fac:	01 c8                	add    %ecx,%eax
    5fae:	01 c0                	add    %eax,%eax
    5fb0:	89 d1                	mov    %edx,%ecx
    5fb2:	29 c1                	sub    %eax,%ecx
    5fb4:	89 c8                	mov    %ecx,%eax
    5fb6:	83 c0 30             	add    $0x30,%eax
    5fb9:	88 45 a4             	mov    %al,-0x5c(%rbp)
    5fbc:	c6 45 a5 00          	movb   $0x0,-0x5b(%rbp)
    5fc0:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
    5fc4:	48 89 c7             	mov    %rax,%rdi
    5fc7:	48 b8 f6 67 00 00 00 	movabs $0x67f6,%rax
    5fce:	00 00 00 
    5fd1:	ff d0                	call   *%rax
    5fd3:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
    5fd7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    5fdb:	0f 89 01 ff ff ff    	jns    5ee2 <fsfull+0x222>
    5fe1:	48 b8 50 87 00 00 00 	movabs $0x8750,%rax
    5fe8:	00 00 00 
    5feb:	48 89 c6             	mov    %rax,%rsi
    5fee:	bf 01 00 00 00       	mov    $0x1,%edi
    5ff3:	b8 00 00 00 00       	mov    $0x0,%eax
    5ff8:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    5fff:	00 00 00 
    6002:	ff d2                	call   *%rdx
    6004:	90                   	nop
    6005:	c9                   	leave
    6006:	c3                   	ret

0000000000006007 <uio>:
    6007:	55                   	push   %rbp
    6008:	48 89 e5             	mov    %rsp,%rbp
    600b:	48 83 ec 10          	sub    $0x10,%rsp
    600f:	66 c7 45 fe 00 00    	movw   $0x0,-0x2(%rbp)
    6015:	c6 45 fd 00          	movb   $0x0,-0x3(%rbp)
    6019:	48 b8 66 87 00 00 00 	movabs $0x8766,%rax
    6020:	00 00 00 
    6023:	48 89 c6             	mov    %rax,%rsi
    6026:	bf 01 00 00 00       	mov    $0x1,%edi
    602b:	b8 00 00 00 00       	mov    $0x0,%eax
    6030:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    6037:	00 00 00 
    603a:	ff d2                	call   *%rdx
    603c:	48 b8 67 67 00 00 00 	movabs $0x6767,%rax
    6043:	00 00 00 
    6046:	ff d0                	call   *%rax
    6048:	89 45 f8             	mov    %eax,-0x8(%rbp)
    604b:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    604f:	75 52                	jne    60a3 <uio+0x9c>
    6051:	66 c7 45 fe 70 00    	movw   $0x70,-0x2(%rbp)
    6057:	c6 45 fd 09          	movb   $0x9,-0x3(%rbp)
    605b:	0f b6 45 fd          	movzbl -0x3(%rbp),%eax
    605f:	0f b7 55 fe          	movzwl -0x2(%rbp),%edx
    6063:	ee                   	out    %al,(%dx)
    6064:	66 c7 45 fe 71 00    	movw   $0x71,-0x2(%rbp)
    606a:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
    606e:	89 c2                	mov    %eax,%edx
    6070:	ec                   	in     (%dx),%al
    6071:	88 45 fd             	mov    %al,-0x3(%rbp)
    6074:	48 b8 70 87 00 00 00 	movabs $0x8770,%rax
    607b:	00 00 00 
    607e:	48 89 c6             	mov    %rax,%rsi
    6081:	bf 01 00 00 00       	mov    $0x1,%edi
    6086:	b8 00 00 00 00       	mov    $0x0,%eax
    608b:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    6092:	00 00 00 
    6095:	ff d2                	call   *%rdx
    6097:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    609e:	00 00 00 
    60a1:	ff d0                	call   *%rax
    60a3:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    60a7:	79 19                	jns    60c2 <uio+0xbb>
    60a9:	48 b8 0f 72 00 00 00 	movabs $0x720f,%rax
    60b0:	00 00 00 
    60b3:	48 89 c7             	mov    %rax,%rdi
    60b6:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    60bd:	00 00 00 
    60c0:	ff d0                	call   *%rax
    60c2:	48 b8 81 67 00 00 00 	movabs $0x6781,%rax
    60c9:	00 00 00 
    60cc:	ff d0                	call   *%rax
    60ce:	48 b8 84 87 00 00 00 	movabs $0x8784,%rax
    60d5:	00 00 00 
    60d8:	48 89 c6             	mov    %rax,%rsi
    60db:	bf 01 00 00 00       	mov    $0x1,%edi
    60e0:	b8 00 00 00 00       	mov    $0x0,%eax
    60e5:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    60ec:	00 00 00 
    60ef:	ff d2                	call   *%rdx
    60f1:	90                   	nop
    60f2:	c9                   	leave
    60f3:	c3                   	ret

00000000000060f4 <argptest>:
    60f4:	55                   	push   %rbp
    60f5:	48 89 e5             	mov    %rsp,%rbp
    60f8:	48 83 ec 10          	sub    $0x10,%rsp
    60fc:	48 b8 93 87 00 00 00 	movabs $0x8793,%rax
    6103:	00 00 00 
    6106:	be 00 00 00 00       	mov    $0x0,%esi
    610b:	48 89 c7             	mov    %rax,%rdi
    610e:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    6115:	00 00 00 
    6118:	ff d0                	call   *%rax
    611a:	89 45 fc             	mov    %eax,-0x4(%rbp)
    611d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    6121:	79 19                	jns    613c <argptest+0x48>
    6123:	48 b8 98 87 00 00 00 	movabs $0x8798,%rax
    612a:	00 00 00 
    612d:	48 89 c7             	mov    %rax,%rdi
    6130:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    6137:	00 00 00 
    613a:	ff d0                	call   *%rax
    613c:	bf 00 00 00 00       	mov    $0x0,%edi
    6141:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    6148:	00 00 00 
    614b:	ff d0                	call   *%rax
    614d:	48 8d 48 ff          	lea    -0x1(%rax),%rcx
    6151:	8b 45 fc             	mov    -0x4(%rbp),%eax
    6154:	ba ff ff ff ff       	mov    $0xffffffff,%edx
    6159:	48 89 ce             	mov    %rcx,%rsi
    615c:	89 c7                	mov    %eax,%edi
    615e:	48 b8 9b 67 00 00 00 	movabs $0x679b,%rax
    6165:	00 00 00 
    6168:	ff d0                	call   *%rax
    616a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    616d:	89 c7                	mov    %eax,%edi
    616f:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    6176:	00 00 00 
    6179:	ff d0                	call   *%rax
    617b:	48 b8 9d 87 00 00 00 	movabs $0x879d,%rax
    6182:	00 00 00 
    6185:	48 89 c6             	mov    %rax,%rsi
    6188:	bf 01 00 00 00       	mov    $0x1,%edi
    618d:	b8 00 00 00 00       	mov    $0x0,%eax
    6192:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    6199:	00 00 00 
    619c:	ff d2                	call   *%rdx
    619e:	90                   	nop
    619f:	c9                   	leave
    61a0:	c3                   	ret

00000000000061a1 <rand>:
    61a1:	55                   	push   %rbp
    61a2:	48 89 e5             	mov    %rsp,%rbp
    61a5:	48 b8 e8 88 00 00 00 	movabs $0x88e8,%rax
    61ac:	00 00 00 
    61af:	48 8b 00             	mov    (%rax),%rax
    61b2:	48 69 c0 0d 66 19 00 	imul   $0x19660d,%rax,%rax
    61b9:	48 8d 90 5f f3 6e 3c 	lea    0x3c6ef35f(%rax),%rdx
    61c0:	48 b8 e8 88 00 00 00 	movabs $0x88e8,%rax
    61c7:	00 00 00 
    61ca:	48 89 10             	mov    %rdx,(%rax)
    61cd:	48 b8 e8 88 00 00 00 	movabs $0x88e8,%rax
    61d4:	00 00 00 
    61d7:	48 8b 00             	mov    (%rax),%rax
    61da:	5d                   	pop    %rbp
    61db:	c3                   	ret

00000000000061dc <main>:
    61dc:	55                   	push   %rbp
    61dd:	48 89 e5             	mov    %rsp,%rbp
    61e0:	48 83 ec 10          	sub    $0x10,%rsp
    61e4:	89 7d fc             	mov    %edi,-0x4(%rbp)
    61e7:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    61eb:	48 b8 ae 87 00 00 00 	movabs $0x87ae,%rax
    61f2:	00 00 00 
    61f5:	48 89 c6             	mov    %rax,%rsi
    61f8:	bf 01 00 00 00       	mov    $0x1,%edi
    61fd:	b8 00 00 00 00       	mov    $0x0,%eax
    6202:	48 ba 78 6a 00 00 00 	movabs $0x6a78,%rdx
    6209:	00 00 00 
    620c:	ff d2                	call   *%rdx
    620e:	48 b8 c2 87 00 00 00 	movabs $0x87c2,%rax
    6215:	00 00 00 
    6218:	be 00 00 00 00       	mov    $0x0,%esi
    621d:	48 89 c7             	mov    %rax,%rdi
    6220:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    6227:	00 00 00 
    622a:	ff d0                	call   *%rax
    622c:	85 c0                	test   %eax,%eax
    622e:	78 19                	js     6249 <main+0x6d>
    6230:	48 b8 d0 87 00 00 00 	movabs $0x87d0,%rax
    6237:	00 00 00 
    623a:	48 89 c7             	mov    %rax,%rdi
    623d:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    6244:	00 00 00 
    6247:	ff d0                	call   *%rax
    6249:	48 b8 c2 87 00 00 00 	movabs $0x87c2,%rax
    6250:	00 00 00 
    6253:	be 00 02 00 00       	mov    $0x200,%esi
    6258:	48 89 c7             	mov    %rax,%rdi
    625b:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    6262:	00 00 00 
    6265:	ff d0                	call   *%rax
    6267:	89 c7                	mov    %eax,%edi
    6269:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    6270:	00 00 00 
    6273:	ff d0                	call   *%rax
    6275:	48 b8 f4 60 00 00 00 	movabs $0x60f4,%rax
    627c:	00 00 00 
    627f:	ff d0                	call   *%rax
    6281:	48 b8 aa 2a 00 00 00 	movabs $0x2aaa,%rax
    6288:	00 00 00 
    628b:	ff d0                	call   *%rax
    628d:	48 b8 25 38 00 00 00 	movabs $0x3825,%rax
    6294:	00 00 00 
    6297:	ff d0                	call   *%rax
    6299:	48 b8 30 33 00 00 00 	movabs $0x3330,%rax
    62a0:	00 00 00 
    62a3:	ff d0                	call   *%rax
    62a5:	48 b8 80 27 00 00 00 	movabs $0x2780,%rax
    62ac:	00 00 00 
    62af:	ff d0                	call   *%rax
    62b1:	48 b8 cf 24 00 00 00 	movabs $0x24cf,%rax
    62b8:	00 00 00 
    62bb:	ff d0                	call   *%rax
    62bd:	48 b8 ff 5a 00 00 00 	movabs $0x5aff,%rax
    62c4:	00 00 00 
    62c7:	ff d0                	call   *%rax
    62c9:	48 b8 1b 45 00 00 00 	movabs $0x451b,%rax
    62d0:	00 00 00 
    62d3:	ff d0                	call   *%rax
    62d5:	48 b8 ff 5a 00 00 00 	movabs $0x5aff,%rax
    62dc:	00 00 00 
    62df:	ff d0                	call   *%rax
    62e1:	48 b8 67 5a 00 00 00 	movabs $0x5a67,%rax
    62e8:	00 00 00 
    62eb:	ff d0                	call   *%rax
    62ed:	48 b8 b2 52 00 00 00 	movabs $0x52b2,%rax
    62f4:	00 00 00 
    62f7:	ff d0                	call   *%rax
    62f9:	48 b8 b4 59 00 00 00 	movabs $0x59b4,%rax
    6300:	00 00 00 
    6303:	ff d0                	call   *%rax
    6305:	48 b8 04 14 00 00 00 	movabs $0x1404,%rax
    630c:	00 00 00 
    630f:	ff d0                	call   *%rax
    6311:	48 b8 e6 14 00 00 00 	movabs $0x14e6,%rax
    6318:	00 00 00 
    631b:	ff d0                	call   *%rax
    631d:	48 b8 35 17 00 00 00 	movabs $0x1735,%rax
    6324:	00 00 00 
    6327:	ff d0                	call   *%rax
    6329:	48 b8 df 19 00 00 00 	movabs $0x19df,%rax
    6330:	00 00 00 
    6333:	ff d0                	call   *%rax
    6335:	48 b8 aa 12 00 00 00 	movabs $0x12aa,%rax
    633c:	00 00 00 
    633f:	ff d0                	call   *%rax
    6341:	48 b8 67 11 00 00 00 	movabs $0x1167,%rax
    6348:	00 00 00 
    634b:	ff d0                	call   *%rax
    634d:	48 b8 42 10 00 00 00 	movabs $0x1042,%rax
    6354:	00 00 00 
    6357:	ff d0                	call   *%rax
    6359:	48 b8 44 23 00 00 00 	movabs $0x2344,%rax
    6360:	00 00 00 
    6363:	ff d0                	call   *%rax
    6365:	48 b8 ee 1d 00 00 00 	movabs $0x1dee,%rax
    636c:	00 00 00 
    636f:	ff d0                	call   *%rax
    6371:	48 b8 54 20 00 00 00 	movabs $0x2054,%rax
    6378:	00 00 00 
    637b:	ff d0                	call   *%rax
    637d:	48 b8 7b 22 00 00 00 	movabs $0x227b,%rax
    6384:	00 00 00 
    6387:	ff d0                	call   *%rax
    6389:	48 b8 03 1d 00 00 00 	movabs $0x1d03,%rax
    6390:	00 00 00 
    6393:	ff d0                	call   *%rax
    6395:	48 b8 fc 4a 00 00 00 	movabs $0x4afc,%rax
    639c:	00 00 00 
    639f:	ff d0                	call   *%rax
    63a1:	48 b8 31 49 00 00 00 	movabs $0x4931,%rax
    63a8:	00 00 00 
    63ab:	ff d0                	call   *%rax
    63ad:	48 b8 85 46 00 00 00 	movabs $0x4685,%rax
    63b4:	00 00 00 
    63b7:	ff d0                	call   *%rax
    63b9:	48 b8 af 3b 00 00 00 	movabs $0x3baf,%rax
    63c0:	00 00 00 
    63c3:	ff d0                	call   *%rax
    63c5:	48 b8 10 30 00 00 00 	movabs $0x3010,%rax
    63cc:	00 00 00 
    63cf:	ff d0                	call   *%rax
    63d1:	48 b8 aa 2d 00 00 00 	movabs $0x2daa,%rax
    63d8:	00 00 00 
    63db:	ff d0                	call   *%rax
    63dd:	48 b8 f9 4c 00 00 00 	movabs $0x4cf9,%rax
    63e4:	00 00 00 
    63e7:	ff d0                	call   *%rax
    63e9:	48 b8 e8 4f 00 00 00 	movabs $0x4fe8,%rax
    63f0:	00 00 00 
    63f3:	ff d0                	call   *%rax
    63f5:	48 b8 a0 51 00 00 00 	movabs $0x51a0,%rax
    63fc:	00 00 00 
    63ff:	ff d0                	call   *%rax
    6401:	48 b8 d6 39 00 00 00 	movabs $0x39d6,%rax
    6408:	00 00 00 
    640b:	ff d0                	call   *%rax
    640d:	48 b8 07 60 00 00 00 	movabs $0x6007,%rax
    6414:	00 00 00 
    6417:	ff d0                	call   *%rax
    6419:	48 b8 73 1c 00 00 00 	movabs $0x1c73,%rax
    6420:	00 00 00 
    6423:	ff d0                	call   *%rax
    6425:	48 b8 74 67 00 00 00 	movabs $0x6774,%rax
    642c:	00 00 00 
    642f:	ff d0                	call   *%rax

0000000000006431 <stosb>:
  stosb(dst, c, n);
  return dst;
}

char*
strchr(const char *s, char c)
    6431:	f3 0f 1e fa          	endbr64
    6435:	55                   	push   %rbp
    6436:	48 89 e5             	mov    %rsp,%rbp
    6439:	48 83 ec 10          	sub    $0x10,%rsp
    643d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    6441:	89 75 f4             	mov    %esi,-0xc(%rbp)
    6444:	89 55 f0             	mov    %edx,-0x10(%rbp)
{
    6447:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    644b:	8b 55 f0             	mov    -0x10(%rbp),%edx
    644e:	8b 45 f4             	mov    -0xc(%rbp),%eax
    6451:	48 89 ce             	mov    %rcx,%rsi
    6454:	48 89 f7             	mov    %rsi,%rdi
    6457:	89 d1                	mov    %edx,%ecx
    6459:	fc                   	cld
    645a:	f3 aa                	rep stos %al,%es:(%rdi)
    645c:	89 ca                	mov    %ecx,%edx
    645e:	48 89 fe             	mov    %rdi,%rsi
    6461:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    6465:	89 55 f0             	mov    %edx,-0x10(%rbp)
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
    6468:	90                   	nop
    6469:	c9                   	leave
    646a:	c3                   	ret

000000000000646b <strcpy>:
{
    646b:	f3 0f 1e fa          	endbr64
    646f:	55                   	push   %rbp
    6470:	48 89 e5             	mov    %rsp,%rbp
    6473:	48 83 ec 20          	sub    $0x20,%rsp
    6477:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    647b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  os = s;
    647f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    6483:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    6487:	90                   	nop
    6488:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    648c:	48 8d 42 01          	lea    0x1(%rdx),%rax
    6490:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    6494:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    6498:	48 8d 48 01          	lea    0x1(%rax),%rcx
    649c:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    64a0:	0f b6 12             	movzbl (%rdx),%edx
    64a3:	88 10                	mov    %dl,(%rax)
    64a5:	0f b6 00             	movzbl (%rax),%eax
    64a8:	84 c0                	test   %al,%al
    64aa:	75 dc                	jne    6488 <strcpy+0x1d>
  return os;
    64ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    64b0:	c9                   	leave
    64b1:	c3                   	ret

00000000000064b2 <strcmp>:
{
    64b2:	f3 0f 1e fa          	endbr64
    64b6:	55                   	push   %rbp
    64b7:	48 89 e5             	mov    %rsp,%rbp
    64ba:	48 83 ec 10          	sub    $0x10,%rsp
    64be:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    64c2:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    64c6:	eb 0a                	jmp    64d2 <strcmp+0x20>
    p++, q++;
    64c8:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    64cd:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    64d2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    64d6:	0f b6 00             	movzbl (%rax),%eax
    64d9:	84 c0                	test   %al,%al
    64db:	74 12                	je     64ef <strcmp+0x3d>
    64dd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    64e1:	0f b6 10             	movzbl (%rax),%edx
    64e4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    64e8:	0f b6 00             	movzbl (%rax),%eax
    64eb:	38 c2                	cmp    %al,%dl
    64ed:	74 d9                	je     64c8 <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
    64ef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    64f3:	0f b6 00             	movzbl (%rax),%eax
    64f6:	0f b6 d0             	movzbl %al,%edx
    64f9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    64fd:	0f b6 00             	movzbl (%rax),%eax
    6500:	0f b6 c0             	movzbl %al,%eax
    6503:	29 c2                	sub    %eax,%edx
    6505:	89 d0                	mov    %edx,%eax
}
    6507:	c9                   	leave
    6508:	c3                   	ret

0000000000006509 <strlen>:
{
    6509:	f3 0f 1e fa          	endbr64
    650d:	55                   	push   %rbp
    650e:	48 89 e5             	mov    %rsp,%rbp
    6511:	48 83 ec 18          	sub    $0x18,%rsp
    6515:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  for(n = 0; s[n]; n++)
    6519:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    6520:	eb 04                	jmp    6526 <strlen+0x1d>
    6522:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    6526:	8b 45 fc             	mov    -0x4(%rbp),%eax
    6529:	48 63 d0             	movslq %eax,%rdx
    652c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    6530:	48 01 d0             	add    %rdx,%rax
    6533:	0f b6 00             	movzbl (%rax),%eax
    6536:	84 c0                	test   %al,%al
    6538:	75 e8                	jne    6522 <strlen+0x19>
  return n;
    653a:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    653d:	c9                   	leave
    653e:	c3                   	ret

000000000000653f <memset>:
{
    653f:	f3 0f 1e fa          	endbr64
    6543:	55                   	push   %rbp
    6544:	48 89 e5             	mov    %rsp,%rbp
    6547:	48 83 ec 10          	sub    $0x10,%rsp
    654b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    654f:	89 75 f4             	mov    %esi,-0xc(%rbp)
    6552:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    6555:	8b 55 f0             	mov    -0x10(%rbp),%edx
    6558:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    655b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    655f:	89 ce                	mov    %ecx,%esi
    6561:	48 89 c7             	mov    %rax,%rdi
    6564:	48 b8 31 64 00 00 00 	movabs $0x6431,%rax
    656b:	00 00 00 
    656e:	ff d0                	call   *%rax
  return dst;
    6570:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    6574:	c9                   	leave
    6575:	c3                   	ret

0000000000006576 <strchr>:
{
    6576:	f3 0f 1e fa          	endbr64
    657a:	55                   	push   %rbp
    657b:	48 89 e5             	mov    %rsp,%rbp
    657e:	48 83 ec 10          	sub    $0x10,%rsp
    6582:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    6586:	89 f0                	mov    %esi,%eax
    6588:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    658b:	eb 17                	jmp    65a4 <strchr+0x2e>
    if(*s == c)
    658d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6591:	0f b6 00             	movzbl (%rax),%eax
    6594:	38 45 f4             	cmp    %al,-0xc(%rbp)
    6597:	75 06                	jne    659f <strchr+0x29>
      return (char*)s;
    6599:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    659d:	eb 15                	jmp    65b4 <strchr+0x3e>
  for(; *s; s++)
    659f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    65a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    65a8:	0f b6 00             	movzbl (%rax),%eax
    65ab:	84 c0                	test   %al,%al
    65ad:	75 de                	jne    658d <strchr+0x17>
  return 0;
    65af:	b8 00 00 00 00       	mov    $0x0,%eax
}
    65b4:	c9                   	leave
    65b5:	c3                   	ret

00000000000065b6 <gets>:

char*
gets(char *buf, int max)
{
    65b6:	f3 0f 1e fa          	endbr64
    65ba:	55                   	push   %rbp
    65bb:	48 89 e5             	mov    %rsp,%rbp
    65be:	48 83 ec 20          	sub    $0x20,%rsp
    65c2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    65c6:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    65c9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    65d0:	eb 4f                	jmp    6621 <gets+0x6b>
    cc = read(0, &c, 1);
    65d2:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    65d6:	ba 01 00 00 00       	mov    $0x1,%edx
    65db:	48 89 c6             	mov    %rax,%rsi
    65de:	bf 00 00 00 00       	mov    $0x0,%edi
    65e3:	48 b8 9b 67 00 00 00 	movabs $0x679b,%rax
    65ea:	00 00 00 
    65ed:	ff d0                	call   *%rax
    65ef:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    65f2:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    65f6:	7e 36                	jle    662e <gets+0x78>
      break;
    buf[i++] = c;
    65f8:	8b 45 fc             	mov    -0x4(%rbp),%eax
    65fb:	8d 50 01             	lea    0x1(%rax),%edx
    65fe:	89 55 fc             	mov    %edx,-0x4(%rbp)
    6601:	48 63 d0             	movslq %eax,%rdx
    6604:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    6608:	48 01 c2             	add    %rax,%rdx
    660b:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    660f:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    6611:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    6615:	3c 0a                	cmp    $0xa,%al
    6617:	74 16                	je     662f <gets+0x79>
    6619:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    661d:	3c 0d                	cmp    $0xd,%al
    661f:	74 0e                	je     662f <gets+0x79>
  for(i=0; i+1 < max; ){
    6621:	8b 45 fc             	mov    -0x4(%rbp),%eax
    6624:	83 c0 01             	add    $0x1,%eax
    6627:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    662a:	7f a6                	jg     65d2 <gets+0x1c>
    662c:	eb 01                	jmp    662f <gets+0x79>
      break;
    662e:	90                   	nop
      break;
  }
  buf[i] = '\0';
    662f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    6632:	48 63 d0             	movslq %eax,%rdx
    6635:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    6639:	48 01 d0             	add    %rdx,%rax
    663c:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    663f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    6643:	c9                   	leave
    6644:	c3                   	ret

0000000000006645 <stat>:

int
stat(char *n, struct stat *st)
{
    6645:	f3 0f 1e fa          	endbr64
    6649:	55                   	push   %rbp
    664a:	48 89 e5             	mov    %rsp,%rbp
    664d:	48 83 ec 20          	sub    $0x20,%rsp
    6651:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    6655:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    6659:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    665d:	be 00 00 00 00       	mov    $0x0,%esi
    6662:	48 89 c7             	mov    %rax,%rdi
    6665:	48 b8 dc 67 00 00 00 	movabs $0x67dc,%rax
    666c:	00 00 00 
    666f:	ff d0                	call   *%rax
    6671:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    6674:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    6678:	79 07                	jns    6681 <stat+0x3c>
    return -1;
    667a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    667f:	eb 2f                	jmp    66b0 <stat+0x6b>
  r = fstat(fd, st);
    6681:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    6685:	8b 45 fc             	mov    -0x4(%rbp),%eax
    6688:	48 89 d6             	mov    %rdx,%rsi
    668b:	89 c7                	mov    %eax,%edi
    668d:	48 b8 03 68 00 00 00 	movabs $0x6803,%rax
    6694:	00 00 00 
    6697:	ff d0                	call   *%rax
    6699:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    669c:	8b 45 fc             	mov    -0x4(%rbp),%eax
    669f:	89 c7                	mov    %eax,%edi
    66a1:	48 b8 b5 67 00 00 00 	movabs $0x67b5,%rax
    66a8:	00 00 00 
    66ab:	ff d0                	call   *%rax
  return r;
    66ad:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    66b0:	c9                   	leave
    66b1:	c3                   	ret

00000000000066b2 <atoi>:

int
atoi(const char *s)
{
    66b2:	f3 0f 1e fa          	endbr64
    66b6:	55                   	push   %rbp
    66b7:	48 89 e5             	mov    %rsp,%rbp
    66ba:	48 83 ec 18          	sub    $0x18,%rsp
    66be:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    66c2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    66c9:	eb 28                	jmp    66f3 <atoi+0x41>
    n = n*10 + *s++ - '0';
    66cb:	8b 55 fc             	mov    -0x4(%rbp),%edx
    66ce:	89 d0                	mov    %edx,%eax
    66d0:	c1 e0 02             	shl    $0x2,%eax
    66d3:	01 d0                	add    %edx,%eax
    66d5:	01 c0                	add    %eax,%eax
    66d7:	89 c1                	mov    %eax,%ecx
    66d9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    66dd:	48 8d 50 01          	lea    0x1(%rax),%rdx
    66e1:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    66e5:	0f b6 00             	movzbl (%rax),%eax
    66e8:	0f be c0             	movsbl %al,%eax
    66eb:	01 c8                	add    %ecx,%eax
    66ed:	83 e8 30             	sub    $0x30,%eax
    66f0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    66f3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    66f7:	0f b6 00             	movzbl (%rax),%eax
    66fa:	3c 2f                	cmp    $0x2f,%al
    66fc:	7e 0b                	jle    6709 <atoi+0x57>
    66fe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    6702:	0f b6 00             	movzbl (%rax),%eax
    6705:	3c 39                	cmp    $0x39,%al
    6707:	7e c2                	jle    66cb <atoi+0x19>
  return n;
    6709:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    670c:	c9                   	leave
    670d:	c3                   	ret

000000000000670e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    670e:	f3 0f 1e fa          	endbr64
    6712:	55                   	push   %rbp
    6713:	48 89 e5             	mov    %rsp,%rbp
    6716:	48 83 ec 28          	sub    $0x28,%rsp
    671a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    671e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    6722:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    6725:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    6729:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    672d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    6731:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    6735:	eb 1d                	jmp    6754 <memmove+0x46>
    *dst++ = *src++;
    6737:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    673b:	48 8d 42 01          	lea    0x1(%rdx),%rax
    673f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    6743:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6747:	48 8d 48 01          	lea    0x1(%rax),%rcx
    674b:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    674f:	0f b6 12             	movzbl (%rdx),%edx
    6752:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    6754:	8b 45 dc             	mov    -0x24(%rbp),%eax
    6757:	8d 50 ff             	lea    -0x1(%rax),%edx
    675a:	89 55 dc             	mov    %edx,-0x24(%rbp)
    675d:	85 c0                	test   %eax,%eax
    675f:	7f d6                	jg     6737 <memmove+0x29>
  return vdst;
    6761:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    6765:	c9                   	leave
    6766:	c3                   	ret

0000000000006767 <fork>:
    6767:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    676e:	49 89 ca             	mov    %rcx,%r10
    6771:	0f 05                	syscall
    6773:	c3                   	ret

0000000000006774 <exit>:
    6774:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    677b:	49 89 ca             	mov    %rcx,%r10
    677e:	0f 05                	syscall
    6780:	c3                   	ret

0000000000006781 <wait>:
    6781:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    6788:	49 89 ca             	mov    %rcx,%r10
    678b:	0f 05                	syscall
    678d:	c3                   	ret

000000000000678e <pipe>:
    678e:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    6795:	49 89 ca             	mov    %rcx,%r10
    6798:	0f 05                	syscall
    679a:	c3                   	ret

000000000000679b <read>:
    679b:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    67a2:	49 89 ca             	mov    %rcx,%r10
    67a5:	0f 05                	syscall
    67a7:	c3                   	ret

00000000000067a8 <write>:
    67a8:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    67af:	49 89 ca             	mov    %rcx,%r10
    67b2:	0f 05                	syscall
    67b4:	c3                   	ret

00000000000067b5 <close>:
    67b5:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    67bc:	49 89 ca             	mov    %rcx,%r10
    67bf:	0f 05                	syscall
    67c1:	c3                   	ret

00000000000067c2 <kill>:
    67c2:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    67c9:	49 89 ca             	mov    %rcx,%r10
    67cc:	0f 05                	syscall
    67ce:	c3                   	ret

00000000000067cf <exec>:
    67cf:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    67d6:	49 89 ca             	mov    %rcx,%r10
    67d9:	0f 05                	syscall
    67db:	c3                   	ret

00000000000067dc <open>:
    67dc:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    67e3:	49 89 ca             	mov    %rcx,%r10
    67e6:	0f 05                	syscall
    67e8:	c3                   	ret

00000000000067e9 <mknod>:
    67e9:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    67f0:	49 89 ca             	mov    %rcx,%r10
    67f3:	0f 05                	syscall
    67f5:	c3                   	ret

00000000000067f6 <unlink>:
    67f6:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    67fd:	49 89 ca             	mov    %rcx,%r10
    6800:	0f 05                	syscall
    6802:	c3                   	ret

0000000000006803 <fstat>:
    6803:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    680a:	49 89 ca             	mov    %rcx,%r10
    680d:	0f 05                	syscall
    680f:	c3                   	ret

0000000000006810 <link>:
    6810:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    6817:	49 89 ca             	mov    %rcx,%r10
    681a:	0f 05                	syscall
    681c:	c3                   	ret

000000000000681d <mkdir>:
    681d:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    6824:	49 89 ca             	mov    %rcx,%r10
    6827:	0f 05                	syscall
    6829:	c3                   	ret

000000000000682a <chdir>:
    682a:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    6831:	49 89 ca             	mov    %rcx,%r10
    6834:	0f 05                	syscall
    6836:	c3                   	ret

0000000000006837 <dup>:
    6837:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    683e:	49 89 ca             	mov    %rcx,%r10
    6841:	0f 05                	syscall
    6843:	c3                   	ret

0000000000006844 <getpid>:
    6844:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    684b:	49 89 ca             	mov    %rcx,%r10
    684e:	0f 05                	syscall
    6850:	c3                   	ret

0000000000006851 <sbrk>:
    6851:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    6858:	49 89 ca             	mov    %rcx,%r10
    685b:	0f 05                	syscall
    685d:	c3                   	ret

000000000000685e <sleep>:
    685e:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    6865:	49 89 ca             	mov    %rcx,%r10
    6868:	0f 05                	syscall
    686a:	c3                   	ret

000000000000686b <uptime>:
    686b:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    6872:	49 89 ca             	mov    %rcx,%r10
    6875:	0f 05                	syscall
    6877:	c3                   	ret

0000000000006878 <send>:
    6878:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    687f:	49 89 ca             	mov    %rcx,%r10
    6882:	0f 05                	syscall
    6884:	c3                   	ret

0000000000006885 <recv>:
    6885:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    688c:	49 89 ca             	mov    %rcx,%r10
    688f:	0f 05                	syscall
    6891:	c3                   	ret

0000000000006892 <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    6892:	f3 0f 1e fa          	endbr64
    6896:	55                   	push   %rbp
    6897:	48 89 e5             	mov    %rsp,%rbp
    689a:	48 83 ec 10          	sub    $0x10,%rsp
    689e:	89 7d fc             	mov    %edi,-0x4(%rbp)
    68a1:	89 f0                	mov    %esi,%eax
    68a3:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    68a6:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    68aa:	8b 45 fc             	mov    -0x4(%rbp),%eax
    68ad:	ba 01 00 00 00       	mov    $0x1,%edx
    68b2:	48 89 ce             	mov    %rcx,%rsi
    68b5:	89 c7                	mov    %eax,%edi
    68b7:	48 b8 a8 67 00 00 00 	movabs $0x67a8,%rax
    68be:	00 00 00 
    68c1:	ff d0                	call   *%rax
}
    68c3:	90                   	nop
    68c4:	c9                   	leave
    68c5:	c3                   	ret

00000000000068c6 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    68c6:	f3 0f 1e fa          	endbr64
    68ca:	55                   	push   %rbp
    68cb:	48 89 e5             	mov    %rsp,%rbp
    68ce:	48 83 ec 20          	sub    $0x20,%rsp
    68d2:	89 7d ec             	mov    %edi,-0x14(%rbp)
    68d5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    68d9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    68e0:	eb 35                	jmp    6917 <print_x64+0x51>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    68e2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    68e6:	48 c1 e8 3c          	shr    $0x3c,%rax
    68ea:	48 ba f0 88 00 00 00 	movabs $0x88f0,%rdx
    68f1:	00 00 00 
    68f4:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    68f8:	0f be d0             	movsbl %al,%edx
    68fb:	8b 45 ec             	mov    -0x14(%rbp),%eax
    68fe:	89 d6                	mov    %edx,%esi
    6900:	89 c7                	mov    %eax,%edi
    6902:	48 b8 92 68 00 00 00 	movabs $0x6892,%rax
    6909:	00 00 00 
    690c:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    690e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    6912:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    6917:	8b 45 fc             	mov    -0x4(%rbp),%eax
    691a:	83 f8 0f             	cmp    $0xf,%eax
    691d:	76 c3                	jbe    68e2 <print_x64+0x1c>
}
    691f:	90                   	nop
    6920:	90                   	nop
    6921:	c9                   	leave
    6922:	c3                   	ret

0000000000006923 <print_x32>:

  static void
print_x32(int fd, uint x)
{
    6923:	f3 0f 1e fa          	endbr64
    6927:	55                   	push   %rbp
    6928:	48 89 e5             	mov    %rsp,%rbp
    692b:	48 83 ec 20          	sub    $0x20,%rsp
    692f:	89 7d ec             	mov    %edi,-0x14(%rbp)
    6932:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    6935:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    693c:	eb 36                	jmp    6974 <print_x32+0x51>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    693e:	8b 45 e8             	mov    -0x18(%rbp),%eax
    6941:	c1 e8 1c             	shr    $0x1c,%eax
    6944:	89 c2                	mov    %eax,%edx
    6946:	48 b8 f0 88 00 00 00 	movabs $0x88f0,%rax
    694d:	00 00 00 
    6950:	89 d2                	mov    %edx,%edx
    6952:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    6956:	0f be d0             	movsbl %al,%edx
    6959:	8b 45 ec             	mov    -0x14(%rbp),%eax
    695c:	89 d6                	mov    %edx,%esi
    695e:	89 c7                	mov    %eax,%edi
    6960:	48 b8 92 68 00 00 00 	movabs $0x6892,%rax
    6967:	00 00 00 
    696a:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    696c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    6970:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    6974:	8b 45 fc             	mov    -0x4(%rbp),%eax
    6977:	83 f8 07             	cmp    $0x7,%eax
    697a:	76 c2                	jbe    693e <print_x32+0x1b>
}
    697c:	90                   	nop
    697d:	90                   	nop
    697e:	c9                   	leave
    697f:	c3                   	ret

0000000000006980 <print_d>:

  static void
print_d(int fd, int v)
{
    6980:	f3 0f 1e fa          	endbr64
    6984:	55                   	push   %rbp
    6985:	48 89 e5             	mov    %rsp,%rbp
    6988:	48 83 ec 30          	sub    $0x30,%rsp
    698c:	89 7d dc             	mov    %edi,-0x24(%rbp)
    698f:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    6992:	8b 45 d8             	mov    -0x28(%rbp),%eax
    6995:	48 98                	cltq
    6997:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    699b:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    699f:	79 04                	jns    69a5 <print_d+0x25>
    x = -x;
    69a1:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    69a5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    69ac:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    69b0:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    69b7:	66 66 66 
    69ba:	48 89 c8             	mov    %rcx,%rax
    69bd:	48 f7 ea             	imul   %rdx
    69c0:	48 c1 fa 02          	sar    $0x2,%rdx
    69c4:	48 89 c8             	mov    %rcx,%rax
    69c7:	48 c1 f8 3f          	sar    $0x3f,%rax
    69cb:	48 29 c2             	sub    %rax,%rdx
    69ce:	48 89 d0             	mov    %rdx,%rax
    69d1:	48 c1 e0 02          	shl    $0x2,%rax
    69d5:	48 01 d0             	add    %rdx,%rax
    69d8:	48 01 c0             	add    %rax,%rax
    69db:	48 29 c1             	sub    %rax,%rcx
    69de:	48 89 ca             	mov    %rcx,%rdx
    69e1:	8b 45 f4             	mov    -0xc(%rbp),%eax
    69e4:	8d 48 01             	lea    0x1(%rax),%ecx
    69e7:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    69ea:	48 b9 f0 88 00 00 00 	movabs $0x88f0,%rcx
    69f1:	00 00 00 
    69f4:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    69f8:	48 98                	cltq
    69fa:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    69fe:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    6a02:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    6a09:	66 66 66 
    6a0c:	48 89 c8             	mov    %rcx,%rax
    6a0f:	48 f7 ea             	imul   %rdx
    6a12:	48 89 d0             	mov    %rdx,%rax
    6a15:	48 c1 f8 02          	sar    $0x2,%rax
    6a19:	48 c1 f9 3f          	sar    $0x3f,%rcx
    6a1d:	48 89 ca             	mov    %rcx,%rdx
    6a20:	48 29 d0             	sub    %rdx,%rax
    6a23:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    6a27:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    6a2c:	0f 85 7a ff ff ff    	jne    69ac <print_d+0x2c>

  if (v < 0)
    6a32:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    6a36:	79 32                	jns    6a6a <print_d+0xea>
    buf[i++] = '-';
    6a38:	8b 45 f4             	mov    -0xc(%rbp),%eax
    6a3b:	8d 50 01             	lea    0x1(%rax),%edx
    6a3e:	89 55 f4             	mov    %edx,-0xc(%rbp)
    6a41:	48 98                	cltq
    6a43:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    6a48:	eb 20                	jmp    6a6a <print_d+0xea>
    putc(fd, buf[i]);
    6a4a:	8b 45 f4             	mov    -0xc(%rbp),%eax
    6a4d:	48 98                	cltq
    6a4f:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    6a54:	0f be d0             	movsbl %al,%edx
    6a57:	8b 45 dc             	mov    -0x24(%rbp),%eax
    6a5a:	89 d6                	mov    %edx,%esi
    6a5c:	89 c7                	mov    %eax,%edi
    6a5e:	48 b8 92 68 00 00 00 	movabs $0x6892,%rax
    6a65:	00 00 00 
    6a68:	ff d0                	call   *%rax
  while (--i >= 0)
    6a6a:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    6a6e:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    6a72:	79 d6                	jns    6a4a <print_d+0xca>
}
    6a74:	90                   	nop
    6a75:	90                   	nop
    6a76:	c9                   	leave
    6a77:	c3                   	ret

0000000000006a78 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    6a78:	f3 0f 1e fa          	endbr64
    6a7c:	55                   	push   %rbp
    6a7d:	48 89 e5             	mov    %rsp,%rbp
    6a80:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    6a87:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    6a8d:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    6a94:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    6a9b:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    6aa2:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    6aa9:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    6ab0:	84 c0                	test   %al,%al
    6ab2:	74 20                	je     6ad4 <printf+0x5c>
    6ab4:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    6ab8:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    6abc:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    6ac0:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    6ac4:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    6ac8:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    6acc:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    6ad0:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    6ad4:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    6adb:	00 00 00 
    6ade:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    6ae5:	00 00 00 
    6ae8:	48 8d 45 10          	lea    0x10(%rbp),%rax
    6aec:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    6af3:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    6afa:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    6b01:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    6b08:	00 00 00 
    6b0b:	e9 41 03 00 00       	jmp    6e51 <printf+0x3d9>
    if (c != '%') {
    6b10:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    6b17:	74 24                	je     6b3d <printf+0xc5>
      putc(fd, c);
    6b19:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    6b1f:	0f be d0             	movsbl %al,%edx
    6b22:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    6b28:	89 d6                	mov    %edx,%esi
    6b2a:	89 c7                	mov    %eax,%edi
    6b2c:	48 b8 92 68 00 00 00 	movabs $0x6892,%rax
    6b33:	00 00 00 
    6b36:	ff d0                	call   *%rax
      continue;
    6b38:	e9 0d 03 00 00       	jmp    6e4a <printf+0x3d2>
    }
    c = fmt[++i] & 0xff;
    6b3d:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    6b44:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    6b4a:	48 63 d0             	movslq %eax,%rdx
    6b4d:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    6b54:	48 01 d0             	add    %rdx,%rax
    6b57:	0f b6 00             	movzbl (%rax),%eax
    6b5a:	0f be c0             	movsbl %al,%eax
    6b5d:	25 ff 00 00 00       	and    $0xff,%eax
    6b62:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    6b68:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    6b6f:	0f 84 0f 03 00 00    	je     6e84 <printf+0x40c>
      break;
    switch(c) {
    6b75:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    6b7c:	0f 84 74 02 00 00    	je     6df6 <printf+0x37e>
    6b82:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    6b89:	0f 8c 82 02 00 00    	jl     6e11 <printf+0x399>
    6b8f:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    6b96:	0f 8f 75 02 00 00    	jg     6e11 <printf+0x399>
    6b9c:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    6ba3:	0f 8c 68 02 00 00    	jl     6e11 <printf+0x399>
    6ba9:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    6baf:	83 e8 63             	sub    $0x63,%eax
    6bb2:	83 f8 15             	cmp    $0x15,%eax
    6bb5:	0f 87 56 02 00 00    	ja     6e11 <printf+0x399>
    6bbb:	89 c0                	mov    %eax,%eax
    6bbd:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    6bc4:	00 
    6bc5:	48 b8 08 88 00 00 00 	movabs $0x8808,%rax
    6bcc:	00 00 00 
    6bcf:	48 01 d0             	add    %rdx,%rax
    6bd2:	48 8b 00             	mov    (%rax),%rax
    6bd5:	3e ff e0             	notrack jmp *%rax
    case 'c':
      putc(fd, va_arg(ap, int));
    6bd8:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    6bde:	83 f8 2f             	cmp    $0x2f,%eax
    6be1:	77 23                	ja     6c06 <printf+0x18e>
    6be3:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    6bea:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    6bf0:	89 d2                	mov    %edx,%edx
    6bf2:	48 01 d0             	add    %rdx,%rax
    6bf5:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    6bfb:	83 c2 08             	add    $0x8,%edx
    6bfe:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    6c04:	eb 12                	jmp    6c18 <printf+0x1a0>
    6c06:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    6c0d:	48 8d 50 08          	lea    0x8(%rax),%rdx
    6c11:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    6c18:	8b 00                	mov    (%rax),%eax
    6c1a:	0f be d0             	movsbl %al,%edx
    6c1d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    6c23:	89 d6                	mov    %edx,%esi
    6c25:	89 c7                	mov    %eax,%edi
    6c27:	48 b8 92 68 00 00 00 	movabs $0x6892,%rax
    6c2e:	00 00 00 
    6c31:	ff d0                	call   *%rax
      break;
    6c33:	e9 12 02 00 00       	jmp    6e4a <printf+0x3d2>
    case 'd':
      print_d(fd, va_arg(ap, int));
    6c38:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    6c3e:	83 f8 2f             	cmp    $0x2f,%eax
    6c41:	77 23                	ja     6c66 <printf+0x1ee>
    6c43:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    6c4a:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    6c50:	89 d2                	mov    %edx,%edx
    6c52:	48 01 d0             	add    %rdx,%rax
    6c55:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    6c5b:	83 c2 08             	add    $0x8,%edx
    6c5e:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    6c64:	eb 12                	jmp    6c78 <printf+0x200>
    6c66:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    6c6d:	48 8d 50 08          	lea    0x8(%rax),%rdx
    6c71:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    6c78:	8b 10                	mov    (%rax),%edx
    6c7a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    6c80:	89 d6                	mov    %edx,%esi
    6c82:	89 c7                	mov    %eax,%edi
    6c84:	48 b8 80 69 00 00 00 	movabs $0x6980,%rax
    6c8b:	00 00 00 
    6c8e:	ff d0                	call   *%rax
      break;
    6c90:	e9 b5 01 00 00       	jmp    6e4a <printf+0x3d2>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    6c95:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    6c9b:	83 f8 2f             	cmp    $0x2f,%eax
    6c9e:	77 23                	ja     6cc3 <printf+0x24b>
    6ca0:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    6ca7:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    6cad:	89 d2                	mov    %edx,%edx
    6caf:	48 01 d0             	add    %rdx,%rax
    6cb2:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    6cb8:	83 c2 08             	add    $0x8,%edx
    6cbb:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    6cc1:	eb 12                	jmp    6cd5 <printf+0x25d>
    6cc3:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    6cca:	48 8d 50 08          	lea    0x8(%rax),%rdx
    6cce:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    6cd5:	8b 10                	mov    (%rax),%edx
    6cd7:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    6cdd:	89 d6                	mov    %edx,%esi
    6cdf:	89 c7                	mov    %eax,%edi
    6ce1:	48 b8 23 69 00 00 00 	movabs $0x6923,%rax
    6ce8:	00 00 00 
    6ceb:	ff d0                	call   *%rax
      break;
    6ced:	e9 58 01 00 00       	jmp    6e4a <printf+0x3d2>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    6cf2:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    6cf8:	83 f8 2f             	cmp    $0x2f,%eax
    6cfb:	77 23                	ja     6d20 <printf+0x2a8>
    6cfd:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    6d04:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    6d0a:	89 d2                	mov    %edx,%edx
    6d0c:	48 01 d0             	add    %rdx,%rax
    6d0f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    6d15:	83 c2 08             	add    $0x8,%edx
    6d18:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    6d1e:	eb 12                	jmp    6d32 <printf+0x2ba>
    6d20:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    6d27:	48 8d 50 08          	lea    0x8(%rax),%rdx
    6d2b:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    6d32:	48 8b 10             	mov    (%rax),%rdx
    6d35:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    6d3b:	48 89 d6             	mov    %rdx,%rsi
    6d3e:	89 c7                	mov    %eax,%edi
    6d40:	48 b8 c6 68 00 00 00 	movabs $0x68c6,%rax
    6d47:	00 00 00 
    6d4a:	ff d0                	call   *%rax
      break;
    6d4c:	e9 f9 00 00 00       	jmp    6e4a <printf+0x3d2>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    6d51:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    6d57:	83 f8 2f             	cmp    $0x2f,%eax
    6d5a:	77 23                	ja     6d7f <printf+0x307>
    6d5c:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    6d63:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    6d69:	89 d2                	mov    %edx,%edx
    6d6b:	48 01 d0             	add    %rdx,%rax
    6d6e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    6d74:	83 c2 08             	add    $0x8,%edx
    6d77:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    6d7d:	eb 12                	jmp    6d91 <printf+0x319>
    6d7f:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    6d86:	48 8d 50 08          	lea    0x8(%rax),%rdx
    6d8a:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    6d91:	48 8b 00             	mov    (%rax),%rax
    6d94:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    6d9b:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    6da2:	00 
    6da3:	75 41                	jne    6de6 <printf+0x36e>
        s = "(null)";
    6da5:	48 b8 00 88 00 00 00 	movabs $0x8800,%rax
    6dac:	00 00 00 
    6daf:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    6db6:	eb 2e                	jmp    6de6 <printf+0x36e>
        putc(fd, *(s++));
    6db8:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    6dbf:	48 8d 50 01          	lea    0x1(%rax),%rdx
    6dc3:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    6dca:	0f b6 00             	movzbl (%rax),%eax
    6dcd:	0f be d0             	movsbl %al,%edx
    6dd0:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    6dd6:	89 d6                	mov    %edx,%esi
    6dd8:	89 c7                	mov    %eax,%edi
    6dda:	48 b8 92 68 00 00 00 	movabs $0x6892,%rax
    6de1:	00 00 00 
    6de4:	ff d0                	call   *%rax
      while (*s)
    6de6:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    6ded:	0f b6 00             	movzbl (%rax),%eax
    6df0:	84 c0                	test   %al,%al
    6df2:	75 c4                	jne    6db8 <printf+0x340>
      break;
    6df4:	eb 54                	jmp    6e4a <printf+0x3d2>
    case '%':
      putc(fd, '%');
    6df6:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    6dfc:	be 25 00 00 00       	mov    $0x25,%esi
    6e01:	89 c7                	mov    %eax,%edi
    6e03:	48 b8 92 68 00 00 00 	movabs $0x6892,%rax
    6e0a:	00 00 00 
    6e0d:	ff d0                	call   *%rax
      break;
    6e0f:	eb 39                	jmp    6e4a <printf+0x3d2>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    6e11:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    6e17:	be 25 00 00 00       	mov    $0x25,%esi
    6e1c:	89 c7                	mov    %eax,%edi
    6e1e:	48 b8 92 68 00 00 00 	movabs $0x6892,%rax
    6e25:	00 00 00 
    6e28:	ff d0                	call   *%rax
      putc(fd, c);
    6e2a:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    6e30:	0f be d0             	movsbl %al,%edx
    6e33:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    6e39:	89 d6                	mov    %edx,%esi
    6e3b:	89 c7                	mov    %eax,%edi
    6e3d:	48 b8 92 68 00 00 00 	movabs $0x6892,%rax
    6e44:	00 00 00 
    6e47:	ff d0                	call   *%rax
      break;
    6e49:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    6e4a:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    6e51:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    6e57:	48 63 d0             	movslq %eax,%rdx
    6e5a:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    6e61:	48 01 d0             	add    %rdx,%rax
    6e64:	0f b6 00             	movzbl (%rax),%eax
    6e67:	0f be c0             	movsbl %al,%eax
    6e6a:	25 ff 00 00 00       	and    $0xff,%eax
    6e6f:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    6e75:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    6e7c:	0f 85 8e fc ff ff    	jne    6b10 <printf+0x98>
    }
  }
}
    6e82:	eb 01                	jmp    6e85 <printf+0x40d>
      break;
    6e84:	90                   	nop
}
    6e85:	90                   	nop
    6e86:	c9                   	leave
    6e87:	c3                   	ret

0000000000006e88 <free>:
    6e88:	55                   	push   %rbp
    6e89:	48 89 e5             	mov    %rsp,%rbp
    6e8c:	48 83 ec 18          	sub    $0x18,%rsp
    6e90:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    6e94:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    6e98:	48 83 e8 10          	sub    $0x10,%rax
    6e9c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    6ea0:	48 b8 70 d1 00 00 00 	movabs $0xd170,%rax
    6ea7:	00 00 00 
    6eaa:	48 8b 00             	mov    (%rax),%rax
    6ead:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    6eb1:	eb 2f                	jmp    6ee2 <free+0x5a>
    6eb3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6eb7:	48 8b 00             	mov    (%rax),%rax
    6eba:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    6ebe:	72 17                	jb     6ed7 <free+0x4f>
    6ec0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    6ec4:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    6ec8:	72 2f                	jb     6ef9 <free+0x71>
    6eca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6ece:	48 8b 00             	mov    (%rax),%rax
    6ed1:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    6ed5:	72 22                	jb     6ef9 <free+0x71>
    6ed7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6edb:	48 8b 00             	mov    (%rax),%rax
    6ede:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    6ee2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    6ee6:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    6eea:	73 c7                	jae    6eb3 <free+0x2b>
    6eec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6ef0:	48 8b 00             	mov    (%rax),%rax
    6ef3:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    6ef7:	73 ba                	jae    6eb3 <free+0x2b>
    6ef9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    6efd:	8b 40 08             	mov    0x8(%rax),%eax
    6f00:	89 c0                	mov    %eax,%eax
    6f02:	48 c1 e0 04          	shl    $0x4,%rax
    6f06:	48 89 c2             	mov    %rax,%rdx
    6f09:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    6f0d:	48 01 c2             	add    %rax,%rdx
    6f10:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6f14:	48 8b 00             	mov    (%rax),%rax
    6f17:	48 39 c2             	cmp    %rax,%rdx
    6f1a:	75 2d                	jne    6f49 <free+0xc1>
    6f1c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    6f20:	8b 50 08             	mov    0x8(%rax),%edx
    6f23:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6f27:	48 8b 00             	mov    (%rax),%rax
    6f2a:	8b 40 08             	mov    0x8(%rax),%eax
    6f2d:	01 c2                	add    %eax,%edx
    6f2f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    6f33:	89 50 08             	mov    %edx,0x8(%rax)
    6f36:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6f3a:	48 8b 00             	mov    (%rax),%rax
    6f3d:	48 8b 10             	mov    (%rax),%rdx
    6f40:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    6f44:	48 89 10             	mov    %rdx,(%rax)
    6f47:	eb 0e                	jmp    6f57 <free+0xcf>
    6f49:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6f4d:	48 8b 10             	mov    (%rax),%rdx
    6f50:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    6f54:	48 89 10             	mov    %rdx,(%rax)
    6f57:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6f5b:	8b 40 08             	mov    0x8(%rax),%eax
    6f5e:	89 c0                	mov    %eax,%eax
    6f60:	48 c1 e0 04          	shl    $0x4,%rax
    6f64:	48 89 c2             	mov    %rax,%rdx
    6f67:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6f6b:	48 01 d0             	add    %rdx,%rax
    6f6e:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    6f72:	75 27                	jne    6f9b <free+0x113>
    6f74:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6f78:	8b 50 08             	mov    0x8(%rax),%edx
    6f7b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    6f7f:	8b 40 08             	mov    0x8(%rax),%eax
    6f82:	01 c2                	add    %eax,%edx
    6f84:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6f88:	89 50 08             	mov    %edx,0x8(%rax)
    6f8b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    6f8f:	48 8b 10             	mov    (%rax),%rdx
    6f92:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6f96:	48 89 10             	mov    %rdx,(%rax)
    6f99:	eb 0b                	jmp    6fa6 <free+0x11e>
    6f9b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6f9f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    6fa3:	48 89 10             	mov    %rdx,(%rax)
    6fa6:	48 ba 70 d1 00 00 00 	movabs $0xd170,%rdx
    6fad:	00 00 00 
    6fb0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6fb4:	48 89 02             	mov    %rax,(%rdx)
    6fb7:	90                   	nop
    6fb8:	c9                   	leave
    6fb9:	c3                   	ret

0000000000006fba <morecore>:
    6fba:	55                   	push   %rbp
    6fbb:	48 89 e5             	mov    %rsp,%rbp
    6fbe:	48 83 ec 20          	sub    $0x20,%rsp
    6fc2:	89 7d ec             	mov    %edi,-0x14(%rbp)
    6fc5:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    6fcc:	77 07                	ja     6fd5 <morecore+0x1b>
    6fce:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
    6fd5:	8b 45 ec             	mov    -0x14(%rbp),%eax
    6fd8:	48 c1 e0 04          	shl    $0x4,%rax
    6fdc:	48 89 c7             	mov    %rax,%rdi
    6fdf:	48 b8 51 68 00 00 00 	movabs $0x6851,%rax
    6fe6:	00 00 00 
    6fe9:	ff d0                	call   *%rax
    6feb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    6fef:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    6ff4:	75 07                	jne    6ffd <morecore+0x43>
    6ff6:	b8 00 00 00 00       	mov    $0x0,%eax
    6ffb:	eb 36                	jmp    7033 <morecore+0x79>
    6ffd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    7001:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    7005:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    7009:	8b 55 ec             	mov    -0x14(%rbp),%edx
    700c:	89 50 08             	mov    %edx,0x8(%rax)
    700f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    7013:	48 83 c0 10          	add    $0x10,%rax
    7017:	48 89 c7             	mov    %rax,%rdi
    701a:	48 b8 88 6e 00 00 00 	movabs $0x6e88,%rax
    7021:	00 00 00 
    7024:	ff d0                	call   *%rax
    7026:	48 b8 70 d1 00 00 00 	movabs $0xd170,%rax
    702d:	00 00 00 
    7030:	48 8b 00             	mov    (%rax),%rax
    7033:	c9                   	leave
    7034:	c3                   	ret

0000000000007035 <malloc>:
    7035:	55                   	push   %rbp
    7036:	48 89 e5             	mov    %rsp,%rbp
    7039:	48 83 ec 30          	sub    $0x30,%rsp
    703d:	89 7d dc             	mov    %edi,-0x24(%rbp)
    7040:	8b 45 dc             	mov    -0x24(%rbp),%eax
    7043:	48 83 c0 0f          	add    $0xf,%rax
    7047:	48 c1 e8 04          	shr    $0x4,%rax
    704b:	83 c0 01             	add    $0x1,%eax
    704e:	89 45 ec             	mov    %eax,-0x14(%rbp)
    7051:	48 b8 70 d1 00 00 00 	movabs $0xd170,%rax
    7058:	00 00 00 
    705b:	48 8b 00             	mov    (%rax),%rax
    705e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    7062:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    7067:	75 4a                	jne    70b3 <malloc+0x7e>
    7069:	48 b8 60 d1 00 00 00 	movabs $0xd160,%rax
    7070:	00 00 00 
    7073:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    7077:	48 ba 70 d1 00 00 00 	movabs $0xd170,%rdx
    707e:	00 00 00 
    7081:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    7085:	48 89 02             	mov    %rax,(%rdx)
    7088:	48 b8 70 d1 00 00 00 	movabs $0xd170,%rax
    708f:	00 00 00 
    7092:	48 8b 00             	mov    (%rax),%rax
    7095:	48 ba 60 d1 00 00 00 	movabs $0xd160,%rdx
    709c:	00 00 00 
    709f:	48 89 02             	mov    %rax,(%rdx)
    70a2:	48 b8 60 d1 00 00 00 	movabs $0xd160,%rax
    70a9:	00 00 00 
    70ac:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
    70b3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    70b7:	48 8b 00             	mov    (%rax),%rax
    70ba:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    70be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    70c2:	8b 40 08             	mov    0x8(%rax),%eax
    70c5:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    70c8:	72 65                	jb     712f <malloc+0xfa>
    70ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    70ce:	8b 40 08             	mov    0x8(%rax),%eax
    70d1:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    70d4:	75 10                	jne    70e6 <malloc+0xb1>
    70d6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    70da:	48 8b 10             	mov    (%rax),%rdx
    70dd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    70e1:	48 89 10             	mov    %rdx,(%rax)
    70e4:	eb 2e                	jmp    7114 <malloc+0xdf>
    70e6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    70ea:	8b 40 08             	mov    0x8(%rax),%eax
    70ed:	2b 45 ec             	sub    -0x14(%rbp),%eax
    70f0:	89 c2                	mov    %eax,%edx
    70f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    70f6:	89 50 08             	mov    %edx,0x8(%rax)
    70f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    70fd:	8b 40 08             	mov    0x8(%rax),%eax
    7100:	89 c0                	mov    %eax,%eax
    7102:	48 c1 e0 04          	shl    $0x4,%rax
    7106:	48 01 45 f8          	add    %rax,-0x8(%rbp)
    710a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    710e:	8b 55 ec             	mov    -0x14(%rbp),%edx
    7111:	89 50 08             	mov    %edx,0x8(%rax)
    7114:	48 ba 70 d1 00 00 00 	movabs $0xd170,%rdx
    711b:	00 00 00 
    711e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    7122:	48 89 02             	mov    %rax,(%rdx)
    7125:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    7129:	48 83 c0 10          	add    $0x10,%rax
    712d:	eb 4e                	jmp    717d <malloc+0x148>
    712f:	48 b8 70 d1 00 00 00 	movabs $0xd170,%rax
    7136:	00 00 00 
    7139:	48 8b 00             	mov    (%rax),%rax
    713c:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    7140:	75 23                	jne    7165 <malloc+0x130>
    7142:	8b 45 ec             	mov    -0x14(%rbp),%eax
    7145:	89 c7                	mov    %eax,%edi
    7147:	48 b8 ba 6f 00 00 00 	movabs $0x6fba,%rax
    714e:	00 00 00 
    7151:	ff d0                	call   *%rax
    7153:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    7157:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    715c:	75 07                	jne    7165 <malloc+0x130>
    715e:	b8 00 00 00 00       	mov    $0x0,%eax
    7163:	eb 18                	jmp    717d <malloc+0x148>
    7165:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    7169:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    716d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    7171:	48 8b 00             	mov    (%rax),%rax
    7174:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    7178:	e9 41 ff ff ff       	jmp    70be <malloc+0x89>
    717d:	c9                   	leave
    717e:	c3                   	ret
