
_stressfs:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
    1000:	f3 0f 1e fa          	endbr64
    1004:	55                   	push   %rbp
    1005:	48 89 e5             	mov    %rsp,%rbp
    1008:	48 81 ec 30 02 00 00 	sub    $0x230,%rsp
    100f:	89 bd dc fd ff ff    	mov    %edi,-0x224(%rbp)
    1015:	48 89 b5 d0 fd ff ff 	mov    %rsi,-0x230(%rbp)
  int fd, i;
  char path[] = "stressfs0";
    101c:	48 b8 73 74 72 65 73 	movabs $0x7366737365727473,%rax
    1023:	73 66 73 
    1026:	48 89 45 ee          	mov    %rax,-0x12(%rbp)
    102a:	66 c7 45 f6 30 00    	movw   $0x30,-0xa(%rbp)
  char data[512];

  printf(1, "stressfs starting\n");
    1030:	48 b8 30 1f 00 00 00 	movabs $0x1f30,%rax
    1037:	00 00 00 
    103a:	48 89 c6             	mov    %rax,%rsi
    103d:	bf 01 00 00 00       	mov    $0x1,%edi
    1042:	b8 00 00 00 00       	mov    $0x0,%eax
    1047:	48 ba 1c 18 00 00 00 	movabs $0x181c,%rdx
    104e:	00 00 00 
    1051:	ff d2                	call   *%rdx
  memset(data, 'a', sizeof(data));
    1053:	48 8d 85 e0 fd ff ff 	lea    -0x220(%rbp),%rax
    105a:	ba 00 02 00 00       	mov    $0x200,%edx
    105f:	be 61 00 00 00       	mov    $0x61,%esi
    1064:	48 89 c7             	mov    %rax,%rdi
    1067:	48 b8 d6 12 00 00 00 	movabs $0x12d6,%rax
    106e:	00 00 00 
    1071:	ff d0                	call   *%rax

  for(i = 0; i < 4; i++)
    1073:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    107a:	eb 14                	jmp    1090 <main+0x90>
    if(fork() > 0)
    107c:	48 b8 fe 14 00 00 00 	movabs $0x14fe,%rax
    1083:	00 00 00 
    1086:	ff d0                	call   *%rax
    1088:	85 c0                	test   %eax,%eax
    108a:	7f 0c                	jg     1098 <main+0x98>
  for(i = 0; i < 4; i++)
    108c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1090:	83 7d fc 03          	cmpl   $0x3,-0x4(%rbp)
    1094:	7e e6                	jle    107c <main+0x7c>
    1096:	eb 01                	jmp    1099 <main+0x99>
      break;
    1098:	90                   	nop

  printf(1, "write %d\n", i);
    1099:	8b 45 fc             	mov    -0x4(%rbp),%eax
    109c:	89 c2                	mov    %eax,%edx
    109e:	48 b8 43 1f 00 00 00 	movabs $0x1f43,%rax
    10a5:	00 00 00 
    10a8:	48 89 c6             	mov    %rax,%rsi
    10ab:	bf 01 00 00 00       	mov    $0x1,%edi
    10b0:	b8 00 00 00 00       	mov    $0x0,%eax
    10b5:	48 b9 1c 18 00 00 00 	movabs $0x181c,%rcx
    10bc:	00 00 00 
    10bf:	ff d1                	call   *%rcx

  path[8] += i;
    10c1:	0f b6 45 f6          	movzbl -0xa(%rbp),%eax
    10c5:	89 c2                	mov    %eax,%edx
    10c7:	8b 45 fc             	mov    -0x4(%rbp),%eax
    10ca:	01 d0                	add    %edx,%eax
    10cc:	88 45 f6             	mov    %al,-0xa(%rbp)
  fd = open(path, O_CREATE | O_RDWR);
    10cf:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
    10d3:	be 02 02 00 00       	mov    $0x202,%esi
    10d8:	48 89 c7             	mov    %rax,%rdi
    10db:	48 b8 73 15 00 00 00 	movabs $0x1573,%rax
    10e2:	00 00 00 
    10e5:	ff d0                	call   *%rax
    10e7:	89 45 f8             	mov    %eax,-0x8(%rbp)
  for(i = 0; i < 20; i++)
    10ea:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    10f1:	eb 24                	jmp    1117 <main+0x117>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
    10f3:	48 8d 8d e0 fd ff ff 	lea    -0x220(%rbp),%rcx
    10fa:	8b 45 f8             	mov    -0x8(%rbp),%eax
    10fd:	ba 00 02 00 00       	mov    $0x200,%edx
    1102:	48 89 ce             	mov    %rcx,%rsi
    1105:	89 c7                	mov    %eax,%edi
    1107:	48 b8 3f 15 00 00 00 	movabs $0x153f,%rax
    110e:	00 00 00 
    1111:	ff d0                	call   *%rax
  for(i = 0; i < 20; i++)
    1113:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1117:	83 7d fc 13          	cmpl   $0x13,-0x4(%rbp)
    111b:	7e d6                	jle    10f3 <main+0xf3>
  close(fd);
    111d:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1120:	89 c7                	mov    %eax,%edi
    1122:	48 b8 4c 15 00 00 00 	movabs $0x154c,%rax
    1129:	00 00 00 
    112c:	ff d0                	call   *%rax

  printf(1, "read\n");
    112e:	48 b8 4d 1f 00 00 00 	movabs $0x1f4d,%rax
    1135:	00 00 00 
    1138:	48 89 c6             	mov    %rax,%rsi
    113b:	bf 01 00 00 00       	mov    $0x1,%edi
    1140:	b8 00 00 00 00       	mov    $0x0,%eax
    1145:	48 ba 1c 18 00 00 00 	movabs $0x181c,%rdx
    114c:	00 00 00 
    114f:	ff d2                	call   *%rdx

  fd = open(path, O_RDONLY);
    1151:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
    1155:	be 00 00 00 00       	mov    $0x0,%esi
    115a:	48 89 c7             	mov    %rax,%rdi
    115d:	48 b8 73 15 00 00 00 	movabs $0x1573,%rax
    1164:	00 00 00 
    1167:	ff d0                	call   *%rax
    1169:	89 45 f8             	mov    %eax,-0x8(%rbp)
  for (i = 0; i < 20; i++)
    116c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1173:	eb 24                	jmp    1199 <main+0x199>
    read(fd, data, sizeof(data));
    1175:	48 8d 8d e0 fd ff ff 	lea    -0x220(%rbp),%rcx
    117c:	8b 45 f8             	mov    -0x8(%rbp),%eax
    117f:	ba 00 02 00 00       	mov    $0x200,%edx
    1184:	48 89 ce             	mov    %rcx,%rsi
    1187:	89 c7                	mov    %eax,%edi
    1189:	48 b8 32 15 00 00 00 	movabs $0x1532,%rax
    1190:	00 00 00 
    1193:	ff d0                	call   *%rax
  for (i = 0; i < 20; i++)
    1195:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1199:	83 7d fc 13          	cmpl   $0x13,-0x4(%rbp)
    119d:	7e d6                	jle    1175 <main+0x175>
  close(fd);
    119f:	8b 45 f8             	mov    -0x8(%rbp),%eax
    11a2:	89 c7                	mov    %eax,%edi
    11a4:	48 b8 4c 15 00 00 00 	movabs $0x154c,%rax
    11ab:	00 00 00 
    11ae:	ff d0                	call   *%rax

  wait();
    11b0:	48 b8 18 15 00 00 00 	movabs $0x1518,%rax
    11b7:	00 00 00 
    11ba:	ff d0                	call   *%rax

  exit();
    11bc:	48 b8 0b 15 00 00 00 	movabs $0x150b,%rax
    11c3:	00 00 00 
    11c6:	ff d0                	call   *%rax

00000000000011c8 <stosb>:
  stosb(dst, c, n);
  return dst;
}

char*
strchr(const char *s, char c)
    11c8:	f3 0f 1e fa          	endbr64
    11cc:	55                   	push   %rbp
    11cd:	48 89 e5             	mov    %rsp,%rbp
    11d0:	48 83 ec 10          	sub    $0x10,%rsp
    11d4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    11d8:	89 75 f4             	mov    %esi,-0xc(%rbp)
    11db:	89 55 f0             	mov    %edx,-0x10(%rbp)
{
    11de:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    11e2:	8b 55 f0             	mov    -0x10(%rbp),%edx
    11e5:	8b 45 f4             	mov    -0xc(%rbp),%eax
    11e8:	48 89 ce             	mov    %rcx,%rsi
    11eb:	48 89 f7             	mov    %rsi,%rdi
    11ee:	89 d1                	mov    %edx,%ecx
    11f0:	fc                   	cld
    11f1:	f3 aa                	rep stos %al,%es:(%rdi)
    11f3:	89 ca                	mov    %ecx,%edx
    11f5:	48 89 fe             	mov    %rdi,%rsi
    11f8:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    11fc:	89 55 f0             	mov    %edx,-0x10(%rbp)
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
    11ff:	90                   	nop
    1200:	c9                   	leave
    1201:	c3                   	ret

0000000000001202 <strcpy>:
{
    1202:	f3 0f 1e fa          	endbr64
    1206:	55                   	push   %rbp
    1207:	48 89 e5             	mov    %rsp,%rbp
    120a:	48 83 ec 20          	sub    $0x20,%rsp
    120e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1212:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  os = s;
    1216:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    121a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    121e:	90                   	nop
    121f:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1223:	48 8d 42 01          	lea    0x1(%rdx),%rax
    1227:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    122b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    122f:	48 8d 48 01          	lea    0x1(%rax),%rcx
    1233:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    1237:	0f b6 12             	movzbl (%rdx),%edx
    123a:	88 10                	mov    %dl,(%rax)
    123c:	0f b6 00             	movzbl (%rax),%eax
    123f:	84 c0                	test   %al,%al
    1241:	75 dc                	jne    121f <strcpy+0x1d>
  return os;
    1243:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    1247:	c9                   	leave
    1248:	c3                   	ret

0000000000001249 <strcmp>:
{
    1249:	f3 0f 1e fa          	endbr64
    124d:	55                   	push   %rbp
    124e:	48 89 e5             	mov    %rsp,%rbp
    1251:	48 83 ec 10          	sub    $0x10,%rsp
    1255:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1259:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    125d:	eb 0a                	jmp    1269 <strcmp+0x20>
    p++, q++;
    125f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1264:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    1269:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    126d:	0f b6 00             	movzbl (%rax),%eax
    1270:	84 c0                	test   %al,%al
    1272:	74 12                	je     1286 <strcmp+0x3d>
    1274:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1278:	0f b6 10             	movzbl (%rax),%edx
    127b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    127f:	0f b6 00             	movzbl (%rax),%eax
    1282:	38 c2                	cmp    %al,%dl
    1284:	74 d9                	je     125f <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
    1286:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    128a:	0f b6 00             	movzbl (%rax),%eax
    128d:	0f b6 d0             	movzbl %al,%edx
    1290:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1294:	0f b6 00             	movzbl (%rax),%eax
    1297:	0f b6 c0             	movzbl %al,%eax
    129a:	29 c2                	sub    %eax,%edx
    129c:	89 d0                	mov    %edx,%eax
}
    129e:	c9                   	leave
    129f:	c3                   	ret

00000000000012a0 <strlen>:
{
    12a0:	f3 0f 1e fa          	endbr64
    12a4:	55                   	push   %rbp
    12a5:	48 89 e5             	mov    %rsp,%rbp
    12a8:	48 83 ec 18          	sub    $0x18,%rsp
    12ac:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  for(n = 0; s[n]; n++)
    12b0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    12b7:	eb 04                	jmp    12bd <strlen+0x1d>
    12b9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    12bd:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12c0:	48 63 d0             	movslq %eax,%rdx
    12c3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12c7:	48 01 d0             	add    %rdx,%rax
    12ca:	0f b6 00             	movzbl (%rax),%eax
    12cd:	84 c0                	test   %al,%al
    12cf:	75 e8                	jne    12b9 <strlen+0x19>
  return n;
    12d1:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    12d4:	c9                   	leave
    12d5:	c3                   	ret

00000000000012d6 <memset>:
{
    12d6:	f3 0f 1e fa          	endbr64
    12da:	55                   	push   %rbp
    12db:	48 89 e5             	mov    %rsp,%rbp
    12de:	48 83 ec 10          	sub    $0x10,%rsp
    12e2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    12e6:	89 75 f4             	mov    %esi,-0xc(%rbp)
    12e9:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    12ec:	8b 55 f0             	mov    -0x10(%rbp),%edx
    12ef:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    12f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    12f6:	89 ce                	mov    %ecx,%esi
    12f8:	48 89 c7             	mov    %rax,%rdi
    12fb:	48 b8 c8 11 00 00 00 	movabs $0x11c8,%rax
    1302:	00 00 00 
    1305:	ff d0                	call   *%rax
  return dst;
    1307:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    130b:	c9                   	leave
    130c:	c3                   	ret

000000000000130d <strchr>:
{
    130d:	f3 0f 1e fa          	endbr64
    1311:	55                   	push   %rbp
    1312:	48 89 e5             	mov    %rsp,%rbp
    1315:	48 83 ec 10          	sub    $0x10,%rsp
    1319:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    131d:	89 f0                	mov    %esi,%eax
    131f:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    1322:	eb 17                	jmp    133b <strchr+0x2e>
    if(*s == c)
    1324:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1328:	0f b6 00             	movzbl (%rax),%eax
    132b:	38 45 f4             	cmp    %al,-0xc(%rbp)
    132e:	75 06                	jne    1336 <strchr+0x29>
      return (char*)s;
    1330:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1334:	eb 15                	jmp    134b <strchr+0x3e>
  for(; *s; s++)
    1336:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    133b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    133f:	0f b6 00             	movzbl (%rax),%eax
    1342:	84 c0                	test   %al,%al
    1344:	75 de                	jne    1324 <strchr+0x17>
  return 0;
    1346:	b8 00 00 00 00       	mov    $0x0,%eax
}
    134b:	c9                   	leave
    134c:	c3                   	ret

000000000000134d <gets>:

char*
gets(char *buf, int max)
{
    134d:	f3 0f 1e fa          	endbr64
    1351:	55                   	push   %rbp
    1352:	48 89 e5             	mov    %rsp,%rbp
    1355:	48 83 ec 20          	sub    $0x20,%rsp
    1359:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    135d:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1360:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1367:	eb 4f                	jmp    13b8 <gets+0x6b>
    cc = read(0, &c, 1);
    1369:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    136d:	ba 01 00 00 00       	mov    $0x1,%edx
    1372:	48 89 c6             	mov    %rax,%rsi
    1375:	bf 00 00 00 00       	mov    $0x0,%edi
    137a:	48 b8 32 15 00 00 00 	movabs $0x1532,%rax
    1381:	00 00 00 
    1384:	ff d0                	call   *%rax
    1386:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    1389:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    138d:	7e 36                	jle    13c5 <gets+0x78>
      break;
    buf[i++] = c;
    138f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1392:	8d 50 01             	lea    0x1(%rax),%edx
    1395:	89 55 fc             	mov    %edx,-0x4(%rbp)
    1398:	48 63 d0             	movslq %eax,%rdx
    139b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    139f:	48 01 c2             	add    %rax,%rdx
    13a2:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    13a6:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    13a8:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    13ac:	3c 0a                	cmp    $0xa,%al
    13ae:	74 16                	je     13c6 <gets+0x79>
    13b0:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    13b4:	3c 0d                	cmp    $0xd,%al
    13b6:	74 0e                	je     13c6 <gets+0x79>
  for(i=0; i+1 < max; ){
    13b8:	8b 45 fc             	mov    -0x4(%rbp),%eax
    13bb:	83 c0 01             	add    $0x1,%eax
    13be:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    13c1:	7f a6                	jg     1369 <gets+0x1c>
    13c3:	eb 01                	jmp    13c6 <gets+0x79>
      break;
    13c5:	90                   	nop
      break;
  }
  buf[i] = '\0';
    13c6:	8b 45 fc             	mov    -0x4(%rbp),%eax
    13c9:	48 63 d0             	movslq %eax,%rdx
    13cc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    13d0:	48 01 d0             	add    %rdx,%rax
    13d3:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    13d6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    13da:	c9                   	leave
    13db:	c3                   	ret

00000000000013dc <stat>:

int
stat(char *n, struct stat *st)
{
    13dc:	f3 0f 1e fa          	endbr64
    13e0:	55                   	push   %rbp
    13e1:	48 89 e5             	mov    %rsp,%rbp
    13e4:	48 83 ec 20          	sub    $0x20,%rsp
    13e8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    13ec:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    13f0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    13f4:	be 00 00 00 00       	mov    $0x0,%esi
    13f9:	48 89 c7             	mov    %rax,%rdi
    13fc:	48 b8 73 15 00 00 00 	movabs $0x1573,%rax
    1403:	00 00 00 
    1406:	ff d0                	call   *%rax
    1408:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    140b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    140f:	79 07                	jns    1418 <stat+0x3c>
    return -1;
    1411:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1416:	eb 2f                	jmp    1447 <stat+0x6b>
  r = fstat(fd, st);
    1418:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    141c:	8b 45 fc             	mov    -0x4(%rbp),%eax
    141f:	48 89 d6             	mov    %rdx,%rsi
    1422:	89 c7                	mov    %eax,%edi
    1424:	48 b8 9a 15 00 00 00 	movabs $0x159a,%rax
    142b:	00 00 00 
    142e:	ff d0                	call   *%rax
    1430:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    1433:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1436:	89 c7                	mov    %eax,%edi
    1438:	48 b8 4c 15 00 00 00 	movabs $0x154c,%rax
    143f:	00 00 00 
    1442:	ff d0                	call   *%rax
  return r;
    1444:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    1447:	c9                   	leave
    1448:	c3                   	ret

0000000000001449 <atoi>:

int
atoi(const char *s)
{
    1449:	f3 0f 1e fa          	endbr64
    144d:	55                   	push   %rbp
    144e:	48 89 e5             	mov    %rsp,%rbp
    1451:	48 83 ec 18          	sub    $0x18,%rsp
    1455:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    1459:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1460:	eb 28                	jmp    148a <atoi+0x41>
    n = n*10 + *s++ - '0';
    1462:	8b 55 fc             	mov    -0x4(%rbp),%edx
    1465:	89 d0                	mov    %edx,%eax
    1467:	c1 e0 02             	shl    $0x2,%eax
    146a:	01 d0                	add    %edx,%eax
    146c:	01 c0                	add    %eax,%eax
    146e:	89 c1                	mov    %eax,%ecx
    1470:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1474:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1478:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    147c:	0f b6 00             	movzbl (%rax),%eax
    147f:	0f be c0             	movsbl %al,%eax
    1482:	01 c8                	add    %ecx,%eax
    1484:	83 e8 30             	sub    $0x30,%eax
    1487:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    148a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    148e:	0f b6 00             	movzbl (%rax),%eax
    1491:	3c 2f                	cmp    $0x2f,%al
    1493:	7e 0b                	jle    14a0 <atoi+0x57>
    1495:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1499:	0f b6 00             	movzbl (%rax),%eax
    149c:	3c 39                	cmp    $0x39,%al
    149e:	7e c2                	jle    1462 <atoi+0x19>
  return n;
    14a0:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    14a3:	c9                   	leave
    14a4:	c3                   	ret

00000000000014a5 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    14a5:	f3 0f 1e fa          	endbr64
    14a9:	55                   	push   %rbp
    14aa:	48 89 e5             	mov    %rsp,%rbp
    14ad:	48 83 ec 28          	sub    $0x28,%rsp
    14b1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    14b5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    14b9:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    14bc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    14c0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    14c4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    14c8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    14cc:	eb 1d                	jmp    14eb <memmove+0x46>
    *dst++ = *src++;
    14ce:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    14d2:	48 8d 42 01          	lea    0x1(%rdx),%rax
    14d6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    14da:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    14de:	48 8d 48 01          	lea    0x1(%rax),%rcx
    14e2:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    14e6:	0f b6 12             	movzbl (%rdx),%edx
    14e9:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    14eb:	8b 45 dc             	mov    -0x24(%rbp),%eax
    14ee:	8d 50 ff             	lea    -0x1(%rax),%edx
    14f1:	89 55 dc             	mov    %edx,-0x24(%rbp)
    14f4:	85 c0                	test   %eax,%eax
    14f6:	7f d6                	jg     14ce <memmove+0x29>
  return vdst;
    14f8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    14fc:	c9                   	leave
    14fd:	c3                   	ret

00000000000014fe <fork>:
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    14fe:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    1505:	49 89 ca             	mov    %rcx,%r10
    1508:	0f 05                	syscall
    150a:	c3                   	ret

000000000000150b <exit>:
SYSCALL(exit)
    150b:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    1512:	49 89 ca             	mov    %rcx,%r10
    1515:	0f 05                	syscall
    1517:	c3                   	ret

0000000000001518 <wait>:
SYSCALL(wait)
    1518:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    151f:	49 89 ca             	mov    %rcx,%r10
    1522:	0f 05                	syscall
    1524:	c3                   	ret

0000000000001525 <pipe>:
SYSCALL(pipe)
    1525:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    152c:	49 89 ca             	mov    %rcx,%r10
    152f:	0f 05                	syscall
    1531:	c3                   	ret

0000000000001532 <read>:
SYSCALL(read)
    1532:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    1539:	49 89 ca             	mov    %rcx,%r10
    153c:	0f 05                	syscall
    153e:	c3                   	ret

000000000000153f <write>:
SYSCALL(write)
    153f:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    1546:	49 89 ca             	mov    %rcx,%r10
    1549:	0f 05                	syscall
    154b:	c3                   	ret

000000000000154c <close>:
SYSCALL(close)
    154c:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    1553:	49 89 ca             	mov    %rcx,%r10
    1556:	0f 05                	syscall
    1558:	c3                   	ret

0000000000001559 <kill>:
SYSCALL(kill)
    1559:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    1560:	49 89 ca             	mov    %rcx,%r10
    1563:	0f 05                	syscall
    1565:	c3                   	ret

0000000000001566 <exec>:
SYSCALL(exec)
    1566:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    156d:	49 89 ca             	mov    %rcx,%r10
    1570:	0f 05                	syscall
    1572:	c3                   	ret

0000000000001573 <open>:
SYSCALL(open)
    1573:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    157a:	49 89 ca             	mov    %rcx,%r10
    157d:	0f 05                	syscall
    157f:	c3                   	ret

0000000000001580 <mknod>:
SYSCALL(mknod)
    1580:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    1587:	49 89 ca             	mov    %rcx,%r10
    158a:	0f 05                	syscall
    158c:	c3                   	ret

000000000000158d <unlink>:
SYSCALL(unlink)
    158d:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    1594:	49 89 ca             	mov    %rcx,%r10
    1597:	0f 05                	syscall
    1599:	c3                   	ret

000000000000159a <fstat>:
SYSCALL(fstat)
    159a:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    15a1:	49 89 ca             	mov    %rcx,%r10
    15a4:	0f 05                	syscall
    15a6:	c3                   	ret

00000000000015a7 <link>:
SYSCALL(link)
    15a7:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    15ae:	49 89 ca             	mov    %rcx,%r10
    15b1:	0f 05                	syscall
    15b3:	c3                   	ret

00000000000015b4 <mkdir>:
SYSCALL(mkdir)
    15b4:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    15bb:	49 89 ca             	mov    %rcx,%r10
    15be:	0f 05                	syscall
    15c0:	c3                   	ret

00000000000015c1 <chdir>:
SYSCALL(chdir)
    15c1:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    15c8:	49 89 ca             	mov    %rcx,%r10
    15cb:	0f 05                	syscall
    15cd:	c3                   	ret

00000000000015ce <dup>:
SYSCALL(dup)
    15ce:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    15d5:	49 89 ca             	mov    %rcx,%r10
    15d8:	0f 05                	syscall
    15da:	c3                   	ret

00000000000015db <getpid>:
SYSCALL(getpid)
    15db:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    15e2:	49 89 ca             	mov    %rcx,%r10
    15e5:	0f 05                	syscall
    15e7:	c3                   	ret

00000000000015e8 <sbrk>:
SYSCALL(sbrk)
    15e8:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    15ef:	49 89 ca             	mov    %rcx,%r10
    15f2:	0f 05                	syscall
    15f4:	c3                   	ret

00000000000015f5 <sleep>:
SYSCALL(sleep)
    15f5:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    15fc:	49 89 ca             	mov    %rcx,%r10
    15ff:	0f 05                	syscall
    1601:	c3                   	ret

0000000000001602 <uptime>:
SYSCALL(uptime)
    1602:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    1609:	49 89 ca             	mov    %rcx,%r10
    160c:	0f 05                	syscall
    160e:	c3                   	ret

000000000000160f <send>:
SYSCALL(send)
    160f:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    1616:	49 89 ca             	mov    %rcx,%r10
    1619:	0f 05                	syscall
    161b:	c3                   	ret

000000000000161c <recv>:
SYSCALL(recv)
    161c:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    1623:	49 89 ca             	mov    %rcx,%r10
    1626:	0f 05                	syscall
    1628:	c3                   	ret

0000000000001629 <register_fsserver>:
SYSCALL(register_fsserver)
    1629:	48 c7 c0 18 00 00 00 	mov    $0x18,%rax
    1630:	49 89 ca             	mov    %rcx,%r10
    1633:	0f 05                	syscall
    1635:	c3                   	ret

0000000000001636 <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    1636:	f3 0f 1e fa          	endbr64
    163a:	55                   	push   %rbp
    163b:	48 89 e5             	mov    %rsp,%rbp
    163e:	48 83 ec 10          	sub    $0x10,%rsp
    1642:	89 7d fc             	mov    %edi,-0x4(%rbp)
    1645:	89 f0                	mov    %esi,%eax
    1647:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    164a:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    164e:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1651:	ba 01 00 00 00       	mov    $0x1,%edx
    1656:	48 89 ce             	mov    %rcx,%rsi
    1659:	89 c7                	mov    %eax,%edi
    165b:	48 b8 3f 15 00 00 00 	movabs $0x153f,%rax
    1662:	00 00 00 
    1665:	ff d0                	call   *%rax
}
    1667:	90                   	nop
    1668:	c9                   	leave
    1669:	c3                   	ret

000000000000166a <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    166a:	f3 0f 1e fa          	endbr64
    166e:	55                   	push   %rbp
    166f:	48 89 e5             	mov    %rsp,%rbp
    1672:	48 83 ec 20          	sub    $0x20,%rsp
    1676:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1679:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    167d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1684:	eb 35                	jmp    16bb <print_x64+0x51>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    1686:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    168a:	48 c1 e8 3c          	shr    $0x3c,%rax
    168e:	48 ba 10 20 00 00 00 	movabs $0x2010,%rdx
    1695:	00 00 00 
    1698:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    169c:	0f be d0             	movsbl %al,%edx
    169f:	8b 45 ec             	mov    -0x14(%rbp),%eax
    16a2:	89 d6                	mov    %edx,%esi
    16a4:	89 c7                	mov    %eax,%edi
    16a6:	48 b8 36 16 00 00 00 	movabs $0x1636,%rax
    16ad:	00 00 00 
    16b0:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    16b2:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    16b6:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    16bb:	8b 45 fc             	mov    -0x4(%rbp),%eax
    16be:	83 f8 0f             	cmp    $0xf,%eax
    16c1:	76 c3                	jbe    1686 <print_x64+0x1c>
}
    16c3:	90                   	nop
    16c4:	90                   	nop
    16c5:	c9                   	leave
    16c6:	c3                   	ret

00000000000016c7 <print_x32>:

  static void
print_x32(int fd, uint x)
{
    16c7:	f3 0f 1e fa          	endbr64
    16cb:	55                   	push   %rbp
    16cc:	48 89 e5             	mov    %rsp,%rbp
    16cf:	48 83 ec 20          	sub    $0x20,%rsp
    16d3:	89 7d ec             	mov    %edi,-0x14(%rbp)
    16d6:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    16d9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    16e0:	eb 36                	jmp    1718 <print_x32+0x51>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    16e2:	8b 45 e8             	mov    -0x18(%rbp),%eax
    16e5:	c1 e8 1c             	shr    $0x1c,%eax
    16e8:	89 c2                	mov    %eax,%edx
    16ea:	48 b8 10 20 00 00 00 	movabs $0x2010,%rax
    16f1:	00 00 00 
    16f4:	89 d2                	mov    %edx,%edx
    16f6:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    16fa:	0f be d0             	movsbl %al,%edx
    16fd:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1700:	89 d6                	mov    %edx,%esi
    1702:	89 c7                	mov    %eax,%edi
    1704:	48 b8 36 16 00 00 00 	movabs $0x1636,%rax
    170b:	00 00 00 
    170e:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1710:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1714:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    1718:	8b 45 fc             	mov    -0x4(%rbp),%eax
    171b:	83 f8 07             	cmp    $0x7,%eax
    171e:	76 c2                	jbe    16e2 <print_x32+0x1b>
}
    1720:	90                   	nop
    1721:	90                   	nop
    1722:	c9                   	leave
    1723:	c3                   	ret

0000000000001724 <print_d>:

  static void
print_d(int fd, int v)
{
    1724:	f3 0f 1e fa          	endbr64
    1728:	55                   	push   %rbp
    1729:	48 89 e5             	mov    %rsp,%rbp
    172c:	48 83 ec 30          	sub    $0x30,%rsp
    1730:	89 7d dc             	mov    %edi,-0x24(%rbp)
    1733:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    1736:	8b 45 d8             	mov    -0x28(%rbp),%eax
    1739:	48 98                	cltq
    173b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    173f:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1743:	79 04                	jns    1749 <print_d+0x25>
    x = -x;
    1745:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    1749:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    1750:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1754:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    175b:	66 66 66 
    175e:	48 89 c8             	mov    %rcx,%rax
    1761:	48 f7 ea             	imul   %rdx
    1764:	48 c1 fa 02          	sar    $0x2,%rdx
    1768:	48 89 c8             	mov    %rcx,%rax
    176b:	48 c1 f8 3f          	sar    $0x3f,%rax
    176f:	48 29 c2             	sub    %rax,%rdx
    1772:	48 89 d0             	mov    %rdx,%rax
    1775:	48 c1 e0 02          	shl    $0x2,%rax
    1779:	48 01 d0             	add    %rdx,%rax
    177c:	48 01 c0             	add    %rax,%rax
    177f:	48 29 c1             	sub    %rax,%rcx
    1782:	48 89 ca             	mov    %rcx,%rdx
    1785:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1788:	8d 48 01             	lea    0x1(%rax),%ecx
    178b:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    178e:	48 b9 10 20 00 00 00 	movabs $0x2010,%rcx
    1795:	00 00 00 
    1798:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    179c:	48 98                	cltq
    179e:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    17a2:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    17a6:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    17ad:	66 66 66 
    17b0:	48 89 c8             	mov    %rcx,%rax
    17b3:	48 f7 ea             	imul   %rdx
    17b6:	48 89 d0             	mov    %rdx,%rax
    17b9:	48 c1 f8 02          	sar    $0x2,%rax
    17bd:	48 c1 f9 3f          	sar    $0x3f,%rcx
    17c1:	48 89 ca             	mov    %rcx,%rdx
    17c4:	48 29 d0             	sub    %rdx,%rax
    17c7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    17cb:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    17d0:	0f 85 7a ff ff ff    	jne    1750 <print_d+0x2c>

  if (v < 0)
    17d6:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    17da:	79 32                	jns    180e <print_d+0xea>
    buf[i++] = '-';
    17dc:	8b 45 f4             	mov    -0xc(%rbp),%eax
    17df:	8d 50 01             	lea    0x1(%rax),%edx
    17e2:	89 55 f4             	mov    %edx,-0xc(%rbp)
    17e5:	48 98                	cltq
    17e7:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    17ec:	eb 20                	jmp    180e <print_d+0xea>
    putc(fd, buf[i]);
    17ee:	8b 45 f4             	mov    -0xc(%rbp),%eax
    17f1:	48 98                	cltq
    17f3:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    17f8:	0f be d0             	movsbl %al,%edx
    17fb:	8b 45 dc             	mov    -0x24(%rbp),%eax
    17fe:	89 d6                	mov    %edx,%esi
    1800:	89 c7                	mov    %eax,%edi
    1802:	48 b8 36 16 00 00 00 	movabs $0x1636,%rax
    1809:	00 00 00 
    180c:	ff d0                	call   *%rax
  while (--i >= 0)
    180e:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    1812:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1816:	79 d6                	jns    17ee <print_d+0xca>
}
    1818:	90                   	nop
    1819:	90                   	nop
    181a:	c9                   	leave
    181b:	c3                   	ret

000000000000181c <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    181c:	f3 0f 1e fa          	endbr64
    1820:	55                   	push   %rbp
    1821:	48 89 e5             	mov    %rsp,%rbp
    1824:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    182b:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    1831:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    1838:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    183f:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    1846:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    184d:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    1854:	84 c0                	test   %al,%al
    1856:	74 20                	je     1878 <printf+0x5c>
    1858:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    185c:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    1860:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    1864:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    1868:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    186c:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    1870:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    1874:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    1878:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    187f:	00 00 00 
    1882:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    1889:	00 00 00 
    188c:	48 8d 45 10          	lea    0x10(%rbp),%rax
    1890:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    1897:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    189e:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    18a5:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    18ac:	00 00 00 
    18af:	e9 41 03 00 00       	jmp    1bf5 <printf+0x3d9>
    if (c != '%') {
    18b4:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    18bb:	74 24                	je     18e1 <printf+0xc5>
      putc(fd, c);
    18bd:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    18c3:	0f be d0             	movsbl %al,%edx
    18c6:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    18cc:	89 d6                	mov    %edx,%esi
    18ce:	89 c7                	mov    %eax,%edi
    18d0:	48 b8 36 16 00 00 00 	movabs $0x1636,%rax
    18d7:	00 00 00 
    18da:	ff d0                	call   *%rax
      continue;
    18dc:	e9 0d 03 00 00       	jmp    1bee <printf+0x3d2>
    }
    c = fmt[++i] & 0xff;
    18e1:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    18e8:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    18ee:	48 63 d0             	movslq %eax,%rdx
    18f1:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    18f8:	48 01 d0             	add    %rdx,%rax
    18fb:	0f b6 00             	movzbl (%rax),%eax
    18fe:	0f be c0             	movsbl %al,%eax
    1901:	25 ff 00 00 00       	and    $0xff,%eax
    1906:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    190c:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1913:	0f 84 0f 03 00 00    	je     1c28 <printf+0x40c>
      break;
    switch(c) {
    1919:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1920:	0f 84 74 02 00 00    	je     1b9a <printf+0x37e>
    1926:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    192d:	0f 8c 82 02 00 00    	jl     1bb5 <printf+0x399>
    1933:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    193a:	0f 8f 75 02 00 00    	jg     1bb5 <printf+0x399>
    1940:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    1947:	0f 8c 68 02 00 00    	jl     1bb5 <printf+0x399>
    194d:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1953:	83 e8 63             	sub    $0x63,%eax
    1956:	83 f8 15             	cmp    $0x15,%eax
    1959:	0f 87 56 02 00 00    	ja     1bb5 <printf+0x399>
    195f:	89 c0                	mov    %eax,%eax
    1961:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1968:	00 
    1969:	48 b8 60 1f 00 00 00 	movabs $0x1f60,%rax
    1970:	00 00 00 
    1973:	48 01 d0             	add    %rdx,%rax
    1976:	48 8b 00             	mov    (%rax),%rax
    1979:	3e ff e0             	notrack jmp *%rax
    case 'c':
      putc(fd, va_arg(ap, int));
    197c:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1982:	83 f8 2f             	cmp    $0x2f,%eax
    1985:	77 23                	ja     19aa <printf+0x18e>
    1987:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    198e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1994:	89 d2                	mov    %edx,%edx
    1996:	48 01 d0             	add    %rdx,%rax
    1999:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    199f:	83 c2 08             	add    $0x8,%edx
    19a2:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    19a8:	eb 12                	jmp    19bc <printf+0x1a0>
    19aa:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    19b1:	48 8d 50 08          	lea    0x8(%rax),%rdx
    19b5:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    19bc:	8b 00                	mov    (%rax),%eax
    19be:	0f be d0             	movsbl %al,%edx
    19c1:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    19c7:	89 d6                	mov    %edx,%esi
    19c9:	89 c7                	mov    %eax,%edi
    19cb:	48 b8 36 16 00 00 00 	movabs $0x1636,%rax
    19d2:	00 00 00 
    19d5:	ff d0                	call   *%rax
      break;
    19d7:	e9 12 02 00 00       	jmp    1bee <printf+0x3d2>
    case 'd':
      print_d(fd, va_arg(ap, int));
    19dc:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    19e2:	83 f8 2f             	cmp    $0x2f,%eax
    19e5:	77 23                	ja     1a0a <printf+0x1ee>
    19e7:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    19ee:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19f4:	89 d2                	mov    %edx,%edx
    19f6:	48 01 d0             	add    %rdx,%rax
    19f9:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19ff:	83 c2 08             	add    $0x8,%edx
    1a02:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1a08:	eb 12                	jmp    1a1c <printf+0x200>
    1a0a:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a11:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a15:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a1c:	8b 10                	mov    (%rax),%edx
    1a1e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a24:	89 d6                	mov    %edx,%esi
    1a26:	89 c7                	mov    %eax,%edi
    1a28:	48 b8 24 17 00 00 00 	movabs $0x1724,%rax
    1a2f:	00 00 00 
    1a32:	ff d0                	call   *%rax
      break;
    1a34:	e9 b5 01 00 00       	jmp    1bee <printf+0x3d2>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    1a39:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1a3f:	83 f8 2f             	cmp    $0x2f,%eax
    1a42:	77 23                	ja     1a67 <printf+0x24b>
    1a44:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1a4b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a51:	89 d2                	mov    %edx,%edx
    1a53:	48 01 d0             	add    %rdx,%rax
    1a56:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a5c:	83 c2 08             	add    $0x8,%edx
    1a5f:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1a65:	eb 12                	jmp    1a79 <printf+0x25d>
    1a67:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a6e:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a72:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a79:	8b 10                	mov    (%rax),%edx
    1a7b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a81:	89 d6                	mov    %edx,%esi
    1a83:	89 c7                	mov    %eax,%edi
    1a85:	48 b8 c7 16 00 00 00 	movabs $0x16c7,%rax
    1a8c:	00 00 00 
    1a8f:	ff d0                	call   *%rax
      break;
    1a91:	e9 58 01 00 00       	jmp    1bee <printf+0x3d2>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    1a96:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1a9c:	83 f8 2f             	cmp    $0x2f,%eax
    1a9f:	77 23                	ja     1ac4 <printf+0x2a8>
    1aa1:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1aa8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1aae:	89 d2                	mov    %edx,%edx
    1ab0:	48 01 d0             	add    %rdx,%rax
    1ab3:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1ab9:	83 c2 08             	add    $0x8,%edx
    1abc:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1ac2:	eb 12                	jmp    1ad6 <printf+0x2ba>
    1ac4:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1acb:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1acf:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1ad6:	48 8b 10             	mov    (%rax),%rdx
    1ad9:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1adf:	48 89 d6             	mov    %rdx,%rsi
    1ae2:	89 c7                	mov    %eax,%edi
    1ae4:	48 b8 6a 16 00 00 00 	movabs $0x166a,%rax
    1aeb:	00 00 00 
    1aee:	ff d0                	call   *%rax
      break;
    1af0:	e9 f9 00 00 00       	jmp    1bee <printf+0x3d2>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    1af5:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1afb:	83 f8 2f             	cmp    $0x2f,%eax
    1afe:	77 23                	ja     1b23 <printf+0x307>
    1b00:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1b07:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b0d:	89 d2                	mov    %edx,%edx
    1b0f:	48 01 d0             	add    %rdx,%rax
    1b12:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b18:	83 c2 08             	add    $0x8,%edx
    1b1b:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1b21:	eb 12                	jmp    1b35 <printf+0x319>
    1b23:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1b2a:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1b2e:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1b35:	48 8b 00             	mov    (%rax),%rax
    1b38:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    1b3f:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1b46:	00 
    1b47:	75 41                	jne    1b8a <printf+0x36e>
        s = "(null)";
    1b49:	48 b8 58 1f 00 00 00 	movabs $0x1f58,%rax
    1b50:	00 00 00 
    1b53:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1b5a:	eb 2e                	jmp    1b8a <printf+0x36e>
        putc(fd, *(s++));
    1b5c:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1b63:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1b67:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1b6e:	0f b6 00             	movzbl (%rax),%eax
    1b71:	0f be d0             	movsbl %al,%edx
    1b74:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b7a:	89 d6                	mov    %edx,%esi
    1b7c:	89 c7                	mov    %eax,%edi
    1b7e:	48 b8 36 16 00 00 00 	movabs $0x1636,%rax
    1b85:	00 00 00 
    1b88:	ff d0                	call   *%rax
      while (*s)
    1b8a:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1b91:	0f b6 00             	movzbl (%rax),%eax
    1b94:	84 c0                	test   %al,%al
    1b96:	75 c4                	jne    1b5c <printf+0x340>
      break;
    1b98:	eb 54                	jmp    1bee <printf+0x3d2>
    case '%':
      putc(fd, '%');
    1b9a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1ba0:	be 25 00 00 00       	mov    $0x25,%esi
    1ba5:	89 c7                	mov    %eax,%edi
    1ba7:	48 b8 36 16 00 00 00 	movabs $0x1636,%rax
    1bae:	00 00 00 
    1bb1:	ff d0                	call   *%rax
      break;
    1bb3:	eb 39                	jmp    1bee <printf+0x3d2>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1bb5:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1bbb:	be 25 00 00 00       	mov    $0x25,%esi
    1bc0:	89 c7                	mov    %eax,%edi
    1bc2:	48 b8 36 16 00 00 00 	movabs $0x1636,%rax
    1bc9:	00 00 00 
    1bcc:	ff d0                	call   *%rax
      putc(fd, c);
    1bce:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1bd4:	0f be d0             	movsbl %al,%edx
    1bd7:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1bdd:	89 d6                	mov    %edx,%esi
    1bdf:	89 c7                	mov    %eax,%edi
    1be1:	48 b8 36 16 00 00 00 	movabs $0x1636,%rax
    1be8:	00 00 00 
    1beb:	ff d0                	call   *%rax
      break;
    1bed:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1bee:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1bf5:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1bfb:	48 63 d0             	movslq %eax,%rdx
    1bfe:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1c05:	48 01 d0             	add    %rdx,%rax
    1c08:	0f b6 00             	movzbl (%rax),%eax
    1c0b:	0f be c0             	movsbl %al,%eax
    1c0e:	25 ff 00 00 00       	and    $0xff,%eax
    1c13:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1c19:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1c20:	0f 85 8e fc ff ff    	jne    18b4 <printf+0x98>
    }
  }
}
    1c26:	eb 01                	jmp    1c29 <printf+0x40d>
      break;
    1c28:	90                   	nop
}
    1c29:	90                   	nop
    1c2a:	c9                   	leave
    1c2b:	c3                   	ret

0000000000001c2c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1c2c:	f3 0f 1e fa          	endbr64
    1c30:	55                   	push   %rbp
    1c31:	48 89 e5             	mov    %rsp,%rbp
    1c34:	48 83 ec 18          	sub    $0x18,%rsp
    1c38:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1c3c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1c40:	48 83 e8 10          	sub    $0x10,%rax
    1c44:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1c48:	48 b8 40 20 00 00 00 	movabs $0x2040,%rax
    1c4f:	00 00 00 
    1c52:	48 8b 00             	mov    (%rax),%rax
    1c55:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1c59:	eb 2f                	jmp    1c8a <free+0x5e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1c5b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c5f:	48 8b 00             	mov    (%rax),%rax
    1c62:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1c66:	72 17                	jb     1c7f <free+0x53>
    1c68:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c6c:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1c70:	72 2f                	jb     1ca1 <free+0x75>
    1c72:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c76:	48 8b 00             	mov    (%rax),%rax
    1c79:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1c7d:	72 22                	jb     1ca1 <free+0x75>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1c7f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c83:	48 8b 00             	mov    (%rax),%rax
    1c86:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1c8a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c8e:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1c92:	73 c7                	jae    1c5b <free+0x2f>
    1c94:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c98:	48 8b 00             	mov    (%rax),%rax
    1c9b:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1c9f:	73 ba                	jae    1c5b <free+0x2f>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1ca1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ca5:	8b 40 08             	mov    0x8(%rax),%eax
    1ca8:	89 c0                	mov    %eax,%eax
    1caa:	48 c1 e0 04          	shl    $0x4,%rax
    1cae:	48 89 c2             	mov    %rax,%rdx
    1cb1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cb5:	48 01 c2             	add    %rax,%rdx
    1cb8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cbc:	48 8b 00             	mov    (%rax),%rax
    1cbf:	48 39 c2             	cmp    %rax,%rdx
    1cc2:	75 2d                	jne    1cf1 <free+0xc5>
    bp->s.size += p->s.ptr->s.size;
    1cc4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cc8:	8b 50 08             	mov    0x8(%rax),%edx
    1ccb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ccf:	48 8b 00             	mov    (%rax),%rax
    1cd2:	8b 40 08             	mov    0x8(%rax),%eax
    1cd5:	01 c2                	add    %eax,%edx
    1cd7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cdb:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1cde:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ce2:	48 8b 00             	mov    (%rax),%rax
    1ce5:	48 8b 10             	mov    (%rax),%rdx
    1ce8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cec:	48 89 10             	mov    %rdx,(%rax)
    1cef:	eb 0e                	jmp    1cff <free+0xd3>
  } else
    bp->s.ptr = p->s.ptr;
    1cf1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cf5:	48 8b 10             	mov    (%rax),%rdx
    1cf8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cfc:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    1cff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d03:	8b 40 08             	mov    0x8(%rax),%eax
    1d06:	89 c0                	mov    %eax,%eax
    1d08:	48 c1 e0 04          	shl    $0x4,%rax
    1d0c:	48 89 c2             	mov    %rax,%rdx
    1d0f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d13:	48 01 d0             	add    %rdx,%rax
    1d16:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1d1a:	75 27                	jne    1d43 <free+0x117>
    p->s.size += bp->s.size;
    1d1c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d20:	8b 50 08             	mov    0x8(%rax),%edx
    1d23:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d27:	8b 40 08             	mov    0x8(%rax),%eax
    1d2a:	01 c2                	add    %eax,%edx
    1d2c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d30:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    1d33:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d37:	48 8b 10             	mov    (%rax),%rdx
    1d3a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d3e:	48 89 10             	mov    %rdx,(%rax)
    1d41:	eb 0b                	jmp    1d4e <free+0x122>
  } else
    p->s.ptr = bp;
    1d43:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d47:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1d4b:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    1d4e:	48 ba 40 20 00 00 00 	movabs $0x2040,%rdx
    1d55:	00 00 00 
    1d58:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d5c:	48 89 02             	mov    %rax,(%rdx)
}
    1d5f:	90                   	nop
    1d60:	c9                   	leave
    1d61:	c3                   	ret

0000000000001d62 <morecore>:

static Header*
morecore(uint nu)
{
    1d62:	f3 0f 1e fa          	endbr64
    1d66:	55                   	push   %rbp
    1d67:	48 89 e5             	mov    %rsp,%rbp
    1d6a:	48 83 ec 20          	sub    $0x20,%rsp
    1d6e:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    1d71:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1d78:	77 07                	ja     1d81 <morecore+0x1f>
    nu = 4096;
    1d7a:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    1d81:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1d84:	48 c1 e0 04          	shl    $0x4,%rax
    1d88:	48 89 c7             	mov    %rax,%rdi
    1d8b:	48 b8 e8 15 00 00 00 	movabs $0x15e8,%rax
    1d92:	00 00 00 
    1d95:	ff d0                	call   *%rax
    1d97:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    1d9b:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1da0:	75 07                	jne    1da9 <morecore+0x47>
    return 0;
    1da2:	b8 00 00 00 00       	mov    $0x0,%eax
    1da7:	eb 36                	jmp    1ddf <morecore+0x7d>
  hp = (Header*)p;
    1da9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1dad:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    1db1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1db5:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1db8:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    1dbb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1dbf:	48 83 c0 10          	add    $0x10,%rax
    1dc3:	48 89 c7             	mov    %rax,%rdi
    1dc6:	48 b8 2c 1c 00 00 00 	movabs $0x1c2c,%rax
    1dcd:	00 00 00 
    1dd0:	ff d0                	call   *%rax
  return freep;
    1dd2:	48 b8 40 20 00 00 00 	movabs $0x2040,%rax
    1dd9:	00 00 00 
    1ddc:	48 8b 00             	mov    (%rax),%rax
}
    1ddf:	c9                   	leave
    1de0:	c3                   	ret

0000000000001de1 <malloc>:

void*
malloc(uint nbytes)
{
    1de1:	f3 0f 1e fa          	endbr64
    1de5:	55                   	push   %rbp
    1de6:	48 89 e5             	mov    %rsp,%rbp
    1de9:	48 83 ec 30          	sub    $0x30,%rsp
    1ded:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1df0:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1df3:	48 83 c0 0f          	add    $0xf,%rax
    1df7:	48 c1 e8 04          	shr    $0x4,%rax
    1dfb:	83 c0 01             	add    $0x1,%eax
    1dfe:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    1e01:	48 b8 40 20 00 00 00 	movabs $0x2040,%rax
    1e08:	00 00 00 
    1e0b:	48 8b 00             	mov    (%rax),%rax
    1e0e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1e12:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1e17:	75 4a                	jne    1e63 <malloc+0x82>
    base.s.ptr = freep = prevp = &base;
    1e19:	48 b8 30 20 00 00 00 	movabs $0x2030,%rax
    1e20:	00 00 00 
    1e23:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1e27:	48 ba 40 20 00 00 00 	movabs $0x2040,%rdx
    1e2e:	00 00 00 
    1e31:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e35:	48 89 02             	mov    %rax,(%rdx)
    1e38:	48 b8 40 20 00 00 00 	movabs $0x2040,%rax
    1e3f:	00 00 00 
    1e42:	48 8b 00             	mov    (%rax),%rax
    1e45:	48 ba 30 20 00 00 00 	movabs $0x2030,%rdx
    1e4c:	00 00 00 
    1e4f:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    1e52:	48 b8 30 20 00 00 00 	movabs $0x2030,%rax
    1e59:	00 00 00 
    1e5c:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1e63:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e67:	48 8b 00             	mov    (%rax),%rax
    1e6a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1e6e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e72:	8b 40 08             	mov    0x8(%rax),%eax
    1e75:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1e78:	72 65                	jb     1edf <malloc+0xfe>
      if(p->s.size == nunits)
    1e7a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e7e:	8b 40 08             	mov    0x8(%rax),%eax
    1e81:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1e84:	75 10                	jne    1e96 <malloc+0xb5>
        prevp->s.ptr = p->s.ptr;
    1e86:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e8a:	48 8b 10             	mov    (%rax),%rdx
    1e8d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e91:	48 89 10             	mov    %rdx,(%rax)
    1e94:	eb 2e                	jmp    1ec4 <malloc+0xe3>
      else {
        p->s.size -= nunits;
    1e96:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e9a:	8b 40 08             	mov    0x8(%rax),%eax
    1e9d:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1ea0:	89 c2                	mov    %eax,%edx
    1ea2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ea6:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    1ea9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ead:	8b 40 08             	mov    0x8(%rax),%eax
    1eb0:	89 c0                	mov    %eax,%eax
    1eb2:	48 c1 e0 04          	shl    $0x4,%rax
    1eb6:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    1eba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ebe:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1ec1:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    1ec4:	48 ba 40 20 00 00 00 	movabs $0x2040,%rdx
    1ecb:	00 00 00 
    1ece:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ed2:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    1ed5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ed9:	48 83 c0 10          	add    $0x10,%rax
    1edd:	eb 4e                	jmp    1f2d <malloc+0x14c>
    }
    if(p == freep)
    1edf:	48 b8 40 20 00 00 00 	movabs $0x2040,%rax
    1ee6:	00 00 00 
    1ee9:	48 8b 00             	mov    (%rax),%rax
    1eec:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1ef0:	75 23                	jne    1f15 <malloc+0x134>
      if((p = morecore(nunits)) == 0)
    1ef2:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1ef5:	89 c7                	mov    %eax,%edi
    1ef7:	48 b8 62 1d 00 00 00 	movabs $0x1d62,%rax
    1efe:	00 00 00 
    1f01:	ff d0                	call   *%rax
    1f03:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1f07:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1f0c:	75 07                	jne    1f15 <malloc+0x134>
        return 0;
    1f0e:	b8 00 00 00 00       	mov    $0x0,%eax
    1f13:	eb 18                	jmp    1f2d <malloc+0x14c>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1f15:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f19:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1f1d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f21:	48 8b 00             	mov    (%rax),%rax
    1f24:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1f28:	e9 41 ff ff ff       	jmp    1e6e <malloc+0x8d>
  }
}
    1f2d:	c9                   	leave
    1f2e:	c3                   	ret
