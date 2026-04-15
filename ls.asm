
_ls:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
    1000:	f3 0f 1e fa          	endbr64
    1004:	55                   	push   %rbp
    1005:	48 89 e5             	mov    %rsp,%rbp
    1008:	53                   	push   %rbx
    1009:	48 83 ec 28          	sub    $0x28,%rsp
    100d:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
    1011:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    1015:	48 89 c7             	mov    %rax,%rdi
    1018:	48 b8 93 15 00 00 00 	movabs $0x1593,%rax
    101f:	00 00 00 
    1022:	ff d0                	call   *%rax
    1024:	89 c2                	mov    %eax,%edx
    1026:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    102a:	48 01 d0             	add    %rdx,%rax
    102d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    1031:	eb 05                	jmp    1038 <fmtname+0x38>
    1033:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
    1038:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    103c:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
    1040:	72 0b                	jb     104d <fmtname+0x4d>
    1042:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1046:	0f b6 00             	movzbl (%rax),%eax
    1049:	3c 2f                	cmp    $0x2f,%al
    104b:	75 e6                	jne    1033 <fmtname+0x33>
    ;
  p++;
    104d:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
    1052:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1056:	48 89 c7             	mov    %rax,%rdi
    1059:	48 b8 93 15 00 00 00 	movabs $0x1593,%rax
    1060:	00 00 00 
    1063:	ff d0                	call   *%rax
    1065:	83 f8 0d             	cmp    $0xd,%eax
    1068:	76 09                	jbe    1073 <fmtname+0x73>
    return p;
    106a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    106e:	e9 93 00 00 00       	jmp    1106 <fmtname+0x106>
  memmove(buf, p, strlen(p));
    1073:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1077:	48 89 c7             	mov    %rax,%rdi
    107a:	48 b8 93 15 00 00 00 	movabs $0x1593,%rax
    1081:	00 00 00 
    1084:	ff d0                	call   *%rax
    1086:	89 c2                	mov    %eax,%edx
    1088:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    108c:	48 89 c6             	mov    %rax,%rsi
    108f:	48 b8 40 23 00 00 00 	movabs $0x2340,%rax
    1096:	00 00 00 
    1099:	48 89 c7             	mov    %rax,%rdi
    109c:	48 b8 98 17 00 00 00 	movabs $0x1798,%rax
    10a3:	00 00 00 
    10a6:	ff d0                	call   *%rax
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
    10a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    10ac:	48 89 c7             	mov    %rax,%rdi
    10af:	48 b8 93 15 00 00 00 	movabs $0x1593,%rax
    10b6:	00 00 00 
    10b9:	ff d0                	call   *%rax
    10bb:	ba 0e 00 00 00       	mov    $0xe,%edx
    10c0:	89 d3                	mov    %edx,%ebx
    10c2:	29 c3                	sub    %eax,%ebx
    10c4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    10c8:	48 89 c7             	mov    %rax,%rdi
    10cb:	48 b8 93 15 00 00 00 	movabs $0x1593,%rax
    10d2:	00 00 00 
    10d5:	ff d0                	call   *%rax
    10d7:	89 c2                	mov    %eax,%edx
    10d9:	48 b8 40 23 00 00 00 	movabs $0x2340,%rax
    10e0:	00 00 00 
    10e3:	48 01 d0             	add    %rdx,%rax
    10e6:	89 da                	mov    %ebx,%edx
    10e8:	be 20 00 00 00       	mov    $0x20,%esi
    10ed:	48 89 c7             	mov    %rax,%rdi
    10f0:	48 b8 c9 15 00 00 00 	movabs $0x15c9,%rax
    10f7:	00 00 00 
    10fa:	ff d0                	call   *%rax
  return buf;
    10fc:	48 b8 40 23 00 00 00 	movabs $0x2340,%rax
    1103:	00 00 00 
}
    1106:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
    110a:	c9                   	leave
    110b:	c3                   	ret

000000000000110c <ls>:

void
ls(char *path)
{
    110c:	f3 0f 1e fa          	endbr64
    1110:	55                   	push   %rbp
    1111:	48 89 e5             	mov    %rsp,%rbp
    1114:	41 55                	push   %r13
    1116:	41 54                	push   %r12
    1118:	53                   	push   %rbx
    1119:	48 81 ec 58 02 00 00 	sub    $0x258,%rsp
    1120:	48 89 bd 98 fd ff ff 	mov    %rdi,-0x268(%rbp)
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
    1127:	48 8b 85 98 fd ff ff 	mov    -0x268(%rbp),%rax
    112e:	be 00 00 00 00       	mov    $0x0,%esi
    1133:	48 89 c7             	mov    %rax,%rdi
    1136:	48 b8 66 18 00 00 00 	movabs $0x1866,%rax
    113d:	00 00 00 
    1140:	ff d0                	call   *%rax
    1142:	89 45 dc             	mov    %eax,-0x24(%rbp)
    1145:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
    1149:	79 32                	jns    117d <ls+0x71>
    printf(2, "ls: cannot open %s\n", path);
    114b:	48 8b 85 98 fd ff ff 	mov    -0x268(%rbp),%rax
    1152:	48 89 c2             	mov    %rax,%rdx
    1155:	48 b8 10 22 00 00 00 	movabs $0x2210,%rax
    115c:	00 00 00 
    115f:	48 89 c6             	mov    %rax,%rsi
    1162:	bf 02 00 00 00       	mov    $0x2,%edi
    1167:	b8 00 00 00 00       	mov    $0x0,%eax
    116c:	48 b9 02 1b 00 00 00 	movabs $0x1b02,%rcx
    1173:	00 00 00 
    1176:	ff d1                	call   *%rcx
    return;
    1178:	e9 ab 02 00 00       	jmp    1428 <ls+0x31c>
  }

  if(fstat(fd, &st) < 0){
    117d:	48 8d 95 a0 fd ff ff 	lea    -0x260(%rbp),%rdx
    1184:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1187:	48 89 d6             	mov    %rdx,%rsi
    118a:	89 c7                	mov    %eax,%edi
    118c:	48 b8 8d 18 00 00 00 	movabs $0x188d,%rax
    1193:	00 00 00 
    1196:	ff d0                	call   *%rax
    1198:	85 c0                	test   %eax,%eax
    119a:	79 43                	jns    11df <ls+0xd3>
    printf(2, "ls: cannot stat %s\n", path);
    119c:	48 8b 85 98 fd ff ff 	mov    -0x268(%rbp),%rax
    11a3:	48 89 c2             	mov    %rax,%rdx
    11a6:	48 b8 24 22 00 00 00 	movabs $0x2224,%rax
    11ad:	00 00 00 
    11b0:	48 89 c6             	mov    %rax,%rsi
    11b3:	bf 02 00 00 00       	mov    $0x2,%edi
    11b8:	b8 00 00 00 00       	mov    $0x0,%eax
    11bd:	48 b9 02 1b 00 00 00 	movabs $0x1b02,%rcx
    11c4:	00 00 00 
    11c7:	ff d1                	call   *%rcx
    close(fd);
    11c9:	8b 45 dc             	mov    -0x24(%rbp),%eax
    11cc:	89 c7                	mov    %eax,%edi
    11ce:	48 b8 3f 18 00 00 00 	movabs $0x183f,%rax
    11d5:	00 00 00 
    11d8:	ff d0                	call   *%rax
    return;
    11da:	e9 49 02 00 00       	jmp    1428 <ls+0x31c>
  }

  switch(st.type){
    11df:	0f b7 85 a0 fd ff ff 	movzwl -0x260(%rbp),%eax
    11e6:	98                   	cwtl
    11e7:	83 f8 01             	cmp    $0x1,%eax
    11ea:	74 6b                	je     1257 <ls+0x14b>
    11ec:	83 f8 02             	cmp    $0x2,%eax
    11ef:	0f 85 22 02 00 00    	jne    1417 <ls+0x30b>
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
    11f5:	44 8b ad b0 fd ff ff 	mov    -0x250(%rbp),%r13d
    11fc:	44 8b a5 a8 fd ff ff 	mov    -0x258(%rbp),%r12d
    1203:	0f b7 85 a0 fd ff ff 	movzwl -0x260(%rbp),%eax
    120a:	0f bf d8             	movswl %ax,%ebx
    120d:	48 8b 85 98 fd ff ff 	mov    -0x268(%rbp),%rax
    1214:	48 89 c7             	mov    %rax,%rdi
    1217:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    121e:	00 00 00 
    1221:	ff d0                	call   *%rax
    1223:	45 89 e9             	mov    %r13d,%r9d
    1226:	45 89 e0             	mov    %r12d,%r8d
    1229:	89 d9                	mov    %ebx,%ecx
    122b:	48 89 c2             	mov    %rax,%rdx
    122e:	48 b8 38 22 00 00 00 	movabs $0x2238,%rax
    1235:	00 00 00 
    1238:	48 89 c6             	mov    %rax,%rsi
    123b:	bf 01 00 00 00       	mov    $0x1,%edi
    1240:	b8 00 00 00 00       	mov    $0x0,%eax
    1245:	49 ba 02 1b 00 00 00 	movabs $0x1b02,%r10
    124c:	00 00 00 
    124f:	41 ff d2             	call   *%r10
    break;
    1252:	e9 c0 01 00 00       	jmp    1417 <ls+0x30b>

  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
    1257:	48 8b 85 98 fd ff ff 	mov    -0x268(%rbp),%rax
    125e:	48 89 c7             	mov    %rax,%rdi
    1261:	48 b8 93 15 00 00 00 	movabs $0x1593,%rax
    1268:	00 00 00 
    126b:	ff d0                	call   *%rax
    126d:	83 c0 10             	add    $0x10,%eax
    1270:	3d 00 02 00 00       	cmp    $0x200,%eax
    1275:	76 28                	jbe    129f <ls+0x193>
      printf(1, "ls: path too long\n");
    1277:	48 b8 45 22 00 00 00 	movabs $0x2245,%rax
    127e:	00 00 00 
    1281:	48 89 c6             	mov    %rax,%rsi
    1284:	bf 01 00 00 00       	mov    $0x1,%edi
    1289:	b8 00 00 00 00       	mov    $0x0,%eax
    128e:	48 ba 02 1b 00 00 00 	movabs $0x1b02,%rdx
    1295:	00 00 00 
    1298:	ff d2                	call   *%rdx
      break;
    129a:	e9 78 01 00 00       	jmp    1417 <ls+0x30b>
    }
    strcpy(buf, path);
    129f:	48 8b 95 98 fd ff ff 	mov    -0x268(%rbp),%rdx
    12a6:	48 8d 85 d0 fd ff ff 	lea    -0x230(%rbp),%rax
    12ad:	48 89 d6             	mov    %rdx,%rsi
    12b0:	48 89 c7             	mov    %rax,%rdi
    12b3:	48 b8 f5 14 00 00 00 	movabs $0x14f5,%rax
    12ba:	00 00 00 
    12bd:	ff d0                	call   *%rax
    p = buf+strlen(buf);
    12bf:	48 8d 85 d0 fd ff ff 	lea    -0x230(%rbp),%rax
    12c6:	48 89 c7             	mov    %rax,%rdi
    12c9:	48 b8 93 15 00 00 00 	movabs $0x1593,%rax
    12d0:	00 00 00 
    12d3:	ff d0                	call   *%rax
    12d5:	89 c2                	mov    %eax,%edx
    12d7:	48 8d 85 d0 fd ff ff 	lea    -0x230(%rbp),%rax
    12de:	48 01 d0             	add    %rdx,%rax
    12e1:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    *p++ = '/';
    12e5:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    12e9:	48 8d 50 01          	lea    0x1(%rax),%rdx
    12ed:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
    12f1:	c6 00 2f             	movb   $0x2f,(%rax)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
    12f4:	e9 f4 00 00 00       	jmp    13ed <ls+0x2e1>
      if(de.inum == 0)
    12f9:	0f b7 85 c0 fd ff ff 	movzwl -0x240(%rbp),%eax
    1300:	66 85 c0             	test   %ax,%ax
    1303:	0f 84 e3 00 00 00    	je     13ec <ls+0x2e0>
        continue;
      memmove(p, de.name, DIRSIZ);
    1309:	48 8d 85 c0 fd ff ff 	lea    -0x240(%rbp),%rax
    1310:	48 8d 48 02          	lea    0x2(%rax),%rcx
    1314:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    1318:	ba 0e 00 00 00       	mov    $0xe,%edx
    131d:	48 89 ce             	mov    %rcx,%rsi
    1320:	48 89 c7             	mov    %rax,%rdi
    1323:	48 b8 98 17 00 00 00 	movabs $0x1798,%rax
    132a:	00 00 00 
    132d:	ff d0                	call   *%rax
      p[DIRSIZ] = 0;
    132f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    1333:	48 83 c0 0e          	add    $0xe,%rax
    1337:	c6 00 00             	movb   $0x0,(%rax)
      if(stat(buf, &st) < 0){
    133a:	48 8d 95 a0 fd ff ff 	lea    -0x260(%rbp),%rdx
    1341:	48 8d 85 d0 fd ff ff 	lea    -0x230(%rbp),%rax
    1348:	48 89 d6             	mov    %rdx,%rsi
    134b:	48 89 c7             	mov    %rax,%rdi
    134e:	48 b8 cf 16 00 00 00 	movabs $0x16cf,%rax
    1355:	00 00 00 
    1358:	ff d0                	call   *%rax
    135a:	85 c0                	test   %eax,%eax
    135c:	79 2f                	jns    138d <ls+0x281>
        printf(1, "ls: cannot stat %s\n", buf);
    135e:	48 8d 85 d0 fd ff ff 	lea    -0x230(%rbp),%rax
    1365:	48 89 c2             	mov    %rax,%rdx
    1368:	48 b8 24 22 00 00 00 	movabs $0x2224,%rax
    136f:	00 00 00 
    1372:	48 89 c6             	mov    %rax,%rsi
    1375:	bf 01 00 00 00       	mov    $0x1,%edi
    137a:	b8 00 00 00 00       	mov    $0x0,%eax
    137f:	48 b9 02 1b 00 00 00 	movabs $0x1b02,%rcx
    1386:	00 00 00 
    1389:	ff d1                	call   *%rcx
        continue;
    138b:	eb 60                	jmp    13ed <ls+0x2e1>
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    138d:	44 8b ad b0 fd ff ff 	mov    -0x250(%rbp),%r13d
    1394:	44 8b a5 a8 fd ff ff 	mov    -0x258(%rbp),%r12d
    139b:	0f b7 85 a0 fd ff ff 	movzwl -0x260(%rbp),%eax
    13a2:	0f bf d8             	movswl %ax,%ebx
    13a5:	48 8d 85 d0 fd ff ff 	lea    -0x230(%rbp),%rax
    13ac:	48 89 c7             	mov    %rax,%rdi
    13af:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    13b6:	00 00 00 
    13b9:	ff d0                	call   *%rax
    13bb:	45 89 e9             	mov    %r13d,%r9d
    13be:	45 89 e0             	mov    %r12d,%r8d
    13c1:	89 d9                	mov    %ebx,%ecx
    13c3:	48 89 c2             	mov    %rax,%rdx
    13c6:	48 b8 38 22 00 00 00 	movabs $0x2238,%rax
    13cd:	00 00 00 
    13d0:	48 89 c6             	mov    %rax,%rsi
    13d3:	bf 01 00 00 00       	mov    $0x1,%edi
    13d8:	b8 00 00 00 00       	mov    $0x0,%eax
    13dd:	49 ba 02 1b 00 00 00 	movabs $0x1b02,%r10
    13e4:	00 00 00 
    13e7:	41 ff d2             	call   *%r10
    13ea:	eb 01                	jmp    13ed <ls+0x2e1>
        continue;
    13ec:	90                   	nop
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
    13ed:	48 8d 8d c0 fd ff ff 	lea    -0x240(%rbp),%rcx
    13f4:	8b 45 dc             	mov    -0x24(%rbp),%eax
    13f7:	ba 10 00 00 00       	mov    $0x10,%edx
    13fc:	48 89 ce             	mov    %rcx,%rsi
    13ff:	89 c7                	mov    %eax,%edi
    1401:	48 b8 25 18 00 00 00 	movabs $0x1825,%rax
    1408:	00 00 00 
    140b:	ff d0                	call   *%rax
    140d:	83 f8 10             	cmp    $0x10,%eax
    1410:	0f 84 e3 fe ff ff    	je     12f9 <ls+0x1ed>
    }
    break;
    1416:	90                   	nop
  }
  close(fd);
    1417:	8b 45 dc             	mov    -0x24(%rbp),%eax
    141a:	89 c7                	mov    %eax,%edi
    141c:	48 b8 3f 18 00 00 00 	movabs $0x183f,%rax
    1423:	00 00 00 
    1426:	ff d0                	call   *%rax
}
    1428:	48 81 c4 58 02 00 00 	add    $0x258,%rsp
    142f:	5b                   	pop    %rbx
    1430:	41 5c                	pop    %r12
    1432:	41 5d                	pop    %r13
    1434:	5d                   	pop    %rbp
    1435:	c3                   	ret

0000000000001436 <main>:

int
main(int argc, char *argv[])
{
    1436:	f3 0f 1e fa          	endbr64
    143a:	55                   	push   %rbp
    143b:	48 89 e5             	mov    %rsp,%rbp
    143e:	48 83 ec 20          	sub    $0x20,%rsp
    1442:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1445:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;

  if(argc < 2){
    1449:	83 7d ec 01          	cmpl   $0x1,-0x14(%rbp)
    144d:	7f 25                	jg     1474 <main+0x3e>
    ls(".");
    144f:	48 b8 58 22 00 00 00 	movabs $0x2258,%rax
    1456:	00 00 00 
    1459:	48 89 c7             	mov    %rax,%rdi
    145c:	48 b8 0c 11 00 00 00 	movabs $0x110c,%rax
    1463:	00 00 00 
    1466:	ff d0                	call   *%rax
    exit();
    1468:	48 b8 fe 17 00 00 00 	movabs $0x17fe,%rax
    146f:	00 00 00 
    1472:	ff d0                	call   *%rax
  }
  for(i=1; i<argc; i++)
    1474:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
    147b:	eb 2a                	jmp    14a7 <main+0x71>
    ls(argv[i]);
    147d:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1480:	48 98                	cltq
    1482:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1489:	00 
    148a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    148e:	48 01 d0             	add    %rdx,%rax
    1491:	48 8b 00             	mov    (%rax),%rax
    1494:	48 89 c7             	mov    %rax,%rdi
    1497:	48 b8 0c 11 00 00 00 	movabs $0x110c,%rax
    149e:	00 00 00 
    14a1:	ff d0                	call   *%rax
  for(i=1; i<argc; i++)
    14a3:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    14a7:	8b 45 fc             	mov    -0x4(%rbp),%eax
    14aa:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    14ad:	7c ce                	jl     147d <main+0x47>
  exit();
    14af:	48 b8 fe 17 00 00 00 	movabs $0x17fe,%rax
    14b6:	00 00 00 
    14b9:	ff d0                	call   *%rax

00000000000014bb <stosb>:
  stosb(dst, c, n);
  return dst;
}

char*
strchr(const char *s, char c)
    14bb:	f3 0f 1e fa          	endbr64
    14bf:	55                   	push   %rbp
    14c0:	48 89 e5             	mov    %rsp,%rbp
    14c3:	48 83 ec 10          	sub    $0x10,%rsp
    14c7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    14cb:	89 75 f4             	mov    %esi,-0xc(%rbp)
    14ce:	89 55 f0             	mov    %edx,-0x10(%rbp)
{
    14d1:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    14d5:	8b 55 f0             	mov    -0x10(%rbp),%edx
    14d8:	8b 45 f4             	mov    -0xc(%rbp),%eax
    14db:	48 89 ce             	mov    %rcx,%rsi
    14de:	48 89 f7             	mov    %rsi,%rdi
    14e1:	89 d1                	mov    %edx,%ecx
    14e3:	fc                   	cld
    14e4:	f3 aa                	rep stos %al,%es:(%rdi)
    14e6:	89 ca                	mov    %ecx,%edx
    14e8:	48 89 fe             	mov    %rdi,%rsi
    14eb:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    14ef:	89 55 f0             	mov    %edx,-0x10(%rbp)
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
    14f2:	90                   	nop
    14f3:	c9                   	leave
    14f4:	c3                   	ret

00000000000014f5 <strcpy>:
{
    14f5:	f3 0f 1e fa          	endbr64
    14f9:	55                   	push   %rbp
    14fa:	48 89 e5             	mov    %rsp,%rbp
    14fd:	48 83 ec 20          	sub    $0x20,%rsp
    1501:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1505:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  os = s;
    1509:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    150d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    1511:	90                   	nop
    1512:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1516:	48 8d 42 01          	lea    0x1(%rdx),%rax
    151a:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    151e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1522:	48 8d 48 01          	lea    0x1(%rax),%rcx
    1526:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    152a:	0f b6 12             	movzbl (%rdx),%edx
    152d:	88 10                	mov    %dl,(%rax)
    152f:	0f b6 00             	movzbl (%rax),%eax
    1532:	84 c0                	test   %al,%al
    1534:	75 dc                	jne    1512 <strcpy+0x1d>
  return os;
    1536:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    153a:	c9                   	leave
    153b:	c3                   	ret

000000000000153c <strcmp>:
{
    153c:	f3 0f 1e fa          	endbr64
    1540:	55                   	push   %rbp
    1541:	48 89 e5             	mov    %rsp,%rbp
    1544:	48 83 ec 10          	sub    $0x10,%rsp
    1548:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    154c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    1550:	eb 0a                	jmp    155c <strcmp+0x20>
    p++, q++;
    1552:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1557:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    155c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1560:	0f b6 00             	movzbl (%rax),%eax
    1563:	84 c0                	test   %al,%al
    1565:	74 12                	je     1579 <strcmp+0x3d>
    1567:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    156b:	0f b6 10             	movzbl (%rax),%edx
    156e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1572:	0f b6 00             	movzbl (%rax),%eax
    1575:	38 c2                	cmp    %al,%dl
    1577:	74 d9                	je     1552 <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
    1579:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    157d:	0f b6 00             	movzbl (%rax),%eax
    1580:	0f b6 d0             	movzbl %al,%edx
    1583:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1587:	0f b6 00             	movzbl (%rax),%eax
    158a:	0f b6 c0             	movzbl %al,%eax
    158d:	29 c2                	sub    %eax,%edx
    158f:	89 d0                	mov    %edx,%eax
}
    1591:	c9                   	leave
    1592:	c3                   	ret

0000000000001593 <strlen>:
{
    1593:	f3 0f 1e fa          	endbr64
    1597:	55                   	push   %rbp
    1598:	48 89 e5             	mov    %rsp,%rbp
    159b:	48 83 ec 18          	sub    $0x18,%rsp
    159f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  for(n = 0; s[n]; n++)
    15a3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    15aa:	eb 04                	jmp    15b0 <strlen+0x1d>
    15ac:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    15b0:	8b 45 fc             	mov    -0x4(%rbp),%eax
    15b3:	48 63 d0             	movslq %eax,%rdx
    15b6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    15ba:	48 01 d0             	add    %rdx,%rax
    15bd:	0f b6 00             	movzbl (%rax),%eax
    15c0:	84 c0                	test   %al,%al
    15c2:	75 e8                	jne    15ac <strlen+0x19>
  return n;
    15c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    15c7:	c9                   	leave
    15c8:	c3                   	ret

00000000000015c9 <memset>:
{
    15c9:	f3 0f 1e fa          	endbr64
    15cd:	55                   	push   %rbp
    15ce:	48 89 e5             	mov    %rsp,%rbp
    15d1:	48 83 ec 10          	sub    $0x10,%rsp
    15d5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    15d9:	89 75 f4             	mov    %esi,-0xc(%rbp)
    15dc:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    15df:	8b 55 f0             	mov    -0x10(%rbp),%edx
    15e2:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    15e5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    15e9:	89 ce                	mov    %ecx,%esi
    15eb:	48 89 c7             	mov    %rax,%rdi
    15ee:	48 b8 bb 14 00 00 00 	movabs $0x14bb,%rax
    15f5:	00 00 00 
    15f8:	ff d0                	call   *%rax
  return dst;
    15fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    15fe:	c9                   	leave
    15ff:	c3                   	ret

0000000000001600 <strchr>:
{
    1600:	f3 0f 1e fa          	endbr64
    1604:	55                   	push   %rbp
    1605:	48 89 e5             	mov    %rsp,%rbp
    1608:	48 83 ec 10          	sub    $0x10,%rsp
    160c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1610:	89 f0                	mov    %esi,%eax
    1612:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    1615:	eb 17                	jmp    162e <strchr+0x2e>
    if(*s == c)
    1617:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    161b:	0f b6 00             	movzbl (%rax),%eax
    161e:	38 45 f4             	cmp    %al,-0xc(%rbp)
    1621:	75 06                	jne    1629 <strchr+0x29>
      return (char*)s;
    1623:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1627:	eb 15                	jmp    163e <strchr+0x3e>
  for(; *s; s++)
    1629:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    162e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1632:	0f b6 00             	movzbl (%rax),%eax
    1635:	84 c0                	test   %al,%al
    1637:	75 de                	jne    1617 <strchr+0x17>
  return 0;
    1639:	b8 00 00 00 00       	mov    $0x0,%eax
}
    163e:	c9                   	leave
    163f:	c3                   	ret

0000000000001640 <gets>:

char*
gets(char *buf, int max)
{
    1640:	f3 0f 1e fa          	endbr64
    1644:	55                   	push   %rbp
    1645:	48 89 e5             	mov    %rsp,%rbp
    1648:	48 83 ec 20          	sub    $0x20,%rsp
    164c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1650:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1653:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    165a:	eb 4f                	jmp    16ab <gets+0x6b>
    cc = read(0, &c, 1);
    165c:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    1660:	ba 01 00 00 00       	mov    $0x1,%edx
    1665:	48 89 c6             	mov    %rax,%rsi
    1668:	bf 00 00 00 00       	mov    $0x0,%edi
    166d:	48 b8 25 18 00 00 00 	movabs $0x1825,%rax
    1674:	00 00 00 
    1677:	ff d0                	call   *%rax
    1679:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    167c:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1680:	7e 36                	jle    16b8 <gets+0x78>
      break;
    buf[i++] = c;
    1682:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1685:	8d 50 01             	lea    0x1(%rax),%edx
    1688:	89 55 fc             	mov    %edx,-0x4(%rbp)
    168b:	48 63 d0             	movslq %eax,%rdx
    168e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1692:	48 01 c2             	add    %rax,%rdx
    1695:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1699:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    169b:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    169f:	3c 0a                	cmp    $0xa,%al
    16a1:	74 16                	je     16b9 <gets+0x79>
    16a3:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    16a7:	3c 0d                	cmp    $0xd,%al
    16a9:	74 0e                	je     16b9 <gets+0x79>
  for(i=0; i+1 < max; ){
    16ab:	8b 45 fc             	mov    -0x4(%rbp),%eax
    16ae:	83 c0 01             	add    $0x1,%eax
    16b1:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    16b4:	7f a6                	jg     165c <gets+0x1c>
    16b6:	eb 01                	jmp    16b9 <gets+0x79>
      break;
    16b8:	90                   	nop
      break;
  }
  buf[i] = '\0';
    16b9:	8b 45 fc             	mov    -0x4(%rbp),%eax
    16bc:	48 63 d0             	movslq %eax,%rdx
    16bf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    16c3:	48 01 d0             	add    %rdx,%rax
    16c6:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    16c9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    16cd:	c9                   	leave
    16ce:	c3                   	ret

00000000000016cf <stat>:

int
stat(char *n, struct stat *st)
{
    16cf:	f3 0f 1e fa          	endbr64
    16d3:	55                   	push   %rbp
    16d4:	48 89 e5             	mov    %rsp,%rbp
    16d7:	48 83 ec 20          	sub    $0x20,%rsp
    16db:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    16df:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    16e3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    16e7:	be 00 00 00 00       	mov    $0x0,%esi
    16ec:	48 89 c7             	mov    %rax,%rdi
    16ef:	48 b8 66 18 00 00 00 	movabs $0x1866,%rax
    16f6:	00 00 00 
    16f9:	ff d0                	call   *%rax
    16fb:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    16fe:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1702:	79 07                	jns    170b <stat+0x3c>
    return -1;
    1704:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1709:	eb 2f                	jmp    173a <stat+0x6b>
  r = fstat(fd, st);
    170b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    170f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1712:	48 89 d6             	mov    %rdx,%rsi
    1715:	89 c7                	mov    %eax,%edi
    1717:	48 b8 8d 18 00 00 00 	movabs $0x188d,%rax
    171e:	00 00 00 
    1721:	ff d0                	call   *%rax
    1723:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    1726:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1729:	89 c7                	mov    %eax,%edi
    172b:	48 b8 3f 18 00 00 00 	movabs $0x183f,%rax
    1732:	00 00 00 
    1735:	ff d0                	call   *%rax
  return r;
    1737:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    173a:	c9                   	leave
    173b:	c3                   	ret

000000000000173c <atoi>:

int
atoi(const char *s)
{
    173c:	f3 0f 1e fa          	endbr64
    1740:	55                   	push   %rbp
    1741:	48 89 e5             	mov    %rsp,%rbp
    1744:	48 83 ec 18          	sub    $0x18,%rsp
    1748:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    174c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1753:	eb 28                	jmp    177d <atoi+0x41>
    n = n*10 + *s++ - '0';
    1755:	8b 55 fc             	mov    -0x4(%rbp),%edx
    1758:	89 d0                	mov    %edx,%eax
    175a:	c1 e0 02             	shl    $0x2,%eax
    175d:	01 d0                	add    %edx,%eax
    175f:	01 c0                	add    %eax,%eax
    1761:	89 c1                	mov    %eax,%ecx
    1763:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1767:	48 8d 50 01          	lea    0x1(%rax),%rdx
    176b:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    176f:	0f b6 00             	movzbl (%rax),%eax
    1772:	0f be c0             	movsbl %al,%eax
    1775:	01 c8                	add    %ecx,%eax
    1777:	83 e8 30             	sub    $0x30,%eax
    177a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    177d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1781:	0f b6 00             	movzbl (%rax),%eax
    1784:	3c 2f                	cmp    $0x2f,%al
    1786:	7e 0b                	jle    1793 <atoi+0x57>
    1788:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    178c:	0f b6 00             	movzbl (%rax),%eax
    178f:	3c 39                	cmp    $0x39,%al
    1791:	7e c2                	jle    1755 <atoi+0x19>
  return n;
    1793:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    1796:	c9                   	leave
    1797:	c3                   	ret

0000000000001798 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1798:	f3 0f 1e fa          	endbr64
    179c:	55                   	push   %rbp
    179d:	48 89 e5             	mov    %rsp,%rbp
    17a0:	48 83 ec 28          	sub    $0x28,%rsp
    17a4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    17a8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    17ac:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    17af:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    17b3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    17b7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    17bb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    17bf:	eb 1d                	jmp    17de <memmove+0x46>
    *dst++ = *src++;
    17c1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    17c5:	48 8d 42 01          	lea    0x1(%rdx),%rax
    17c9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    17cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    17d1:	48 8d 48 01          	lea    0x1(%rax),%rcx
    17d5:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    17d9:	0f b6 12             	movzbl (%rdx),%edx
    17dc:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    17de:	8b 45 dc             	mov    -0x24(%rbp),%eax
    17e1:	8d 50 ff             	lea    -0x1(%rax),%edx
    17e4:	89 55 dc             	mov    %edx,-0x24(%rbp)
    17e7:	85 c0                	test   %eax,%eax
    17e9:	7f d6                	jg     17c1 <memmove+0x29>
  return vdst;
    17eb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    17ef:	c9                   	leave
    17f0:	c3                   	ret

00000000000017f1 <fork>:
    17f1:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    17f8:	49 89 ca             	mov    %rcx,%r10
    17fb:	0f 05                	syscall
    17fd:	c3                   	ret

00000000000017fe <exit>:
    17fe:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    1805:	49 89 ca             	mov    %rcx,%r10
    1808:	0f 05                	syscall
    180a:	c3                   	ret

000000000000180b <wait>:
    180b:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    1812:	49 89 ca             	mov    %rcx,%r10
    1815:	0f 05                	syscall
    1817:	c3                   	ret

0000000000001818 <pipe>:
    1818:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    181f:	49 89 ca             	mov    %rcx,%r10
    1822:	0f 05                	syscall
    1824:	c3                   	ret

0000000000001825 <read>:
    1825:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    182c:	49 89 ca             	mov    %rcx,%r10
    182f:	0f 05                	syscall
    1831:	c3                   	ret

0000000000001832 <write>:
    1832:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    1839:	49 89 ca             	mov    %rcx,%r10
    183c:	0f 05                	syscall
    183e:	c3                   	ret

000000000000183f <close>:
    183f:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    1846:	49 89 ca             	mov    %rcx,%r10
    1849:	0f 05                	syscall
    184b:	c3                   	ret

000000000000184c <kill>:
    184c:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    1853:	49 89 ca             	mov    %rcx,%r10
    1856:	0f 05                	syscall
    1858:	c3                   	ret

0000000000001859 <exec>:
    1859:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    1860:	49 89 ca             	mov    %rcx,%r10
    1863:	0f 05                	syscall
    1865:	c3                   	ret

0000000000001866 <open>:
    1866:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    186d:	49 89 ca             	mov    %rcx,%r10
    1870:	0f 05                	syscall
    1872:	c3                   	ret

0000000000001873 <mknod>:
    1873:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    187a:	49 89 ca             	mov    %rcx,%r10
    187d:	0f 05                	syscall
    187f:	c3                   	ret

0000000000001880 <unlink>:
    1880:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    1887:	49 89 ca             	mov    %rcx,%r10
    188a:	0f 05                	syscall
    188c:	c3                   	ret

000000000000188d <fstat>:
    188d:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    1894:	49 89 ca             	mov    %rcx,%r10
    1897:	0f 05                	syscall
    1899:	c3                   	ret

000000000000189a <link>:
    189a:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    18a1:	49 89 ca             	mov    %rcx,%r10
    18a4:	0f 05                	syscall
    18a6:	c3                   	ret

00000000000018a7 <mkdir>:
    18a7:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    18ae:	49 89 ca             	mov    %rcx,%r10
    18b1:	0f 05                	syscall
    18b3:	c3                   	ret

00000000000018b4 <chdir>:
    18b4:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    18bb:	49 89 ca             	mov    %rcx,%r10
    18be:	0f 05                	syscall
    18c0:	c3                   	ret

00000000000018c1 <dup>:
    18c1:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    18c8:	49 89 ca             	mov    %rcx,%r10
    18cb:	0f 05                	syscall
    18cd:	c3                   	ret

00000000000018ce <getpid>:
    18ce:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    18d5:	49 89 ca             	mov    %rcx,%r10
    18d8:	0f 05                	syscall
    18da:	c3                   	ret

00000000000018db <sbrk>:
    18db:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    18e2:	49 89 ca             	mov    %rcx,%r10
    18e5:	0f 05                	syscall
    18e7:	c3                   	ret

00000000000018e8 <sleep>:
    18e8:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    18ef:	49 89 ca             	mov    %rcx,%r10
    18f2:	0f 05                	syscall
    18f4:	c3                   	ret

00000000000018f5 <uptime>:
    18f5:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    18fc:	49 89 ca             	mov    %rcx,%r10
    18ff:	0f 05                	syscall
    1901:	c3                   	ret

0000000000001902 <send>:
    1902:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    1909:	49 89 ca             	mov    %rcx,%r10
    190c:	0f 05                	syscall
    190e:	c3                   	ret

000000000000190f <recv>:
    190f:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    1916:	49 89 ca             	mov    %rcx,%r10
    1919:	0f 05                	syscall
    191b:	c3                   	ret

000000000000191c <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    191c:	f3 0f 1e fa          	endbr64
    1920:	55                   	push   %rbp
    1921:	48 89 e5             	mov    %rsp,%rbp
    1924:	48 83 ec 10          	sub    $0x10,%rsp
    1928:	89 7d fc             	mov    %edi,-0x4(%rbp)
    192b:	89 f0                	mov    %esi,%eax
    192d:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    1930:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    1934:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1937:	ba 01 00 00 00       	mov    $0x1,%edx
    193c:	48 89 ce             	mov    %rcx,%rsi
    193f:	89 c7                	mov    %eax,%edi
    1941:	48 b8 32 18 00 00 00 	movabs $0x1832,%rax
    1948:	00 00 00 
    194b:	ff d0                	call   *%rax
}
    194d:	90                   	nop
    194e:	c9                   	leave
    194f:	c3                   	ret

0000000000001950 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    1950:	f3 0f 1e fa          	endbr64
    1954:	55                   	push   %rbp
    1955:	48 89 e5             	mov    %rsp,%rbp
    1958:	48 83 ec 20          	sub    $0x20,%rsp
    195c:	89 7d ec             	mov    %edi,-0x14(%rbp)
    195f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1963:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    196a:	eb 35                	jmp    19a1 <print_x64+0x51>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    196c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1970:	48 c1 e8 3c          	shr    $0x3c,%rax
    1974:	48 ba 20 23 00 00 00 	movabs $0x2320,%rdx
    197b:	00 00 00 
    197e:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1982:	0f be d0             	movsbl %al,%edx
    1985:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1988:	89 d6                	mov    %edx,%esi
    198a:	89 c7                	mov    %eax,%edi
    198c:	48 b8 1c 19 00 00 00 	movabs $0x191c,%rax
    1993:	00 00 00 
    1996:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1998:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    199c:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    19a1:	8b 45 fc             	mov    -0x4(%rbp),%eax
    19a4:	83 f8 0f             	cmp    $0xf,%eax
    19a7:	76 c3                	jbe    196c <print_x64+0x1c>
}
    19a9:	90                   	nop
    19aa:	90                   	nop
    19ab:	c9                   	leave
    19ac:	c3                   	ret

00000000000019ad <print_x32>:

  static void
print_x32(int fd, uint x)
{
    19ad:	f3 0f 1e fa          	endbr64
    19b1:	55                   	push   %rbp
    19b2:	48 89 e5             	mov    %rsp,%rbp
    19b5:	48 83 ec 20          	sub    $0x20,%rsp
    19b9:	89 7d ec             	mov    %edi,-0x14(%rbp)
    19bc:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    19bf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    19c6:	eb 36                	jmp    19fe <print_x32+0x51>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    19c8:	8b 45 e8             	mov    -0x18(%rbp),%eax
    19cb:	c1 e8 1c             	shr    $0x1c,%eax
    19ce:	89 c2                	mov    %eax,%edx
    19d0:	48 b8 20 23 00 00 00 	movabs $0x2320,%rax
    19d7:	00 00 00 
    19da:	89 d2                	mov    %edx,%edx
    19dc:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    19e0:	0f be d0             	movsbl %al,%edx
    19e3:	8b 45 ec             	mov    -0x14(%rbp),%eax
    19e6:	89 d6                	mov    %edx,%esi
    19e8:	89 c7                	mov    %eax,%edi
    19ea:	48 b8 1c 19 00 00 00 	movabs $0x191c,%rax
    19f1:	00 00 00 
    19f4:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    19f6:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    19fa:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    19fe:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1a01:	83 f8 07             	cmp    $0x7,%eax
    1a04:	76 c2                	jbe    19c8 <print_x32+0x1b>
}
    1a06:	90                   	nop
    1a07:	90                   	nop
    1a08:	c9                   	leave
    1a09:	c3                   	ret

0000000000001a0a <print_d>:

  static void
print_d(int fd, int v)
{
    1a0a:	f3 0f 1e fa          	endbr64
    1a0e:	55                   	push   %rbp
    1a0f:	48 89 e5             	mov    %rsp,%rbp
    1a12:	48 83 ec 30          	sub    $0x30,%rsp
    1a16:	89 7d dc             	mov    %edi,-0x24(%rbp)
    1a19:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    1a1c:	8b 45 d8             	mov    -0x28(%rbp),%eax
    1a1f:	48 98                	cltq
    1a21:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    1a25:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1a29:	79 04                	jns    1a2f <print_d+0x25>
    x = -x;
    1a2b:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    1a2f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    1a36:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1a3a:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1a41:	66 66 66 
    1a44:	48 89 c8             	mov    %rcx,%rax
    1a47:	48 f7 ea             	imul   %rdx
    1a4a:	48 c1 fa 02          	sar    $0x2,%rdx
    1a4e:	48 89 c8             	mov    %rcx,%rax
    1a51:	48 c1 f8 3f          	sar    $0x3f,%rax
    1a55:	48 29 c2             	sub    %rax,%rdx
    1a58:	48 89 d0             	mov    %rdx,%rax
    1a5b:	48 c1 e0 02          	shl    $0x2,%rax
    1a5f:	48 01 d0             	add    %rdx,%rax
    1a62:	48 01 c0             	add    %rax,%rax
    1a65:	48 29 c1             	sub    %rax,%rcx
    1a68:	48 89 ca             	mov    %rcx,%rdx
    1a6b:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1a6e:	8d 48 01             	lea    0x1(%rax),%ecx
    1a71:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    1a74:	48 b9 20 23 00 00 00 	movabs $0x2320,%rcx
    1a7b:	00 00 00 
    1a7e:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    1a82:	48 98                	cltq
    1a84:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    1a88:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1a8c:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1a93:	66 66 66 
    1a96:	48 89 c8             	mov    %rcx,%rax
    1a99:	48 f7 ea             	imul   %rdx
    1a9c:	48 89 d0             	mov    %rdx,%rax
    1a9f:	48 c1 f8 02          	sar    $0x2,%rax
    1aa3:	48 c1 f9 3f          	sar    $0x3f,%rcx
    1aa7:	48 89 ca             	mov    %rcx,%rdx
    1aaa:	48 29 d0             	sub    %rdx,%rax
    1aad:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    1ab1:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1ab6:	0f 85 7a ff ff ff    	jne    1a36 <print_d+0x2c>

  if (v < 0)
    1abc:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1ac0:	79 32                	jns    1af4 <print_d+0xea>
    buf[i++] = '-';
    1ac2:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1ac5:	8d 50 01             	lea    0x1(%rax),%edx
    1ac8:	89 55 f4             	mov    %edx,-0xc(%rbp)
    1acb:	48 98                	cltq
    1acd:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    1ad2:	eb 20                	jmp    1af4 <print_d+0xea>
    putc(fd, buf[i]);
    1ad4:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1ad7:	48 98                	cltq
    1ad9:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    1ade:	0f be d0             	movsbl %al,%edx
    1ae1:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1ae4:	89 d6                	mov    %edx,%esi
    1ae6:	89 c7                	mov    %eax,%edi
    1ae8:	48 b8 1c 19 00 00 00 	movabs $0x191c,%rax
    1aef:	00 00 00 
    1af2:	ff d0                	call   *%rax
  while (--i >= 0)
    1af4:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    1af8:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1afc:	79 d6                	jns    1ad4 <print_d+0xca>
}
    1afe:	90                   	nop
    1aff:	90                   	nop
    1b00:	c9                   	leave
    1b01:	c3                   	ret

0000000000001b02 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    1b02:	f3 0f 1e fa          	endbr64
    1b06:	55                   	push   %rbp
    1b07:	48 89 e5             	mov    %rsp,%rbp
    1b0a:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    1b11:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    1b17:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    1b1e:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    1b25:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    1b2c:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    1b33:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    1b3a:	84 c0                	test   %al,%al
    1b3c:	74 20                	je     1b5e <printf+0x5c>
    1b3e:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    1b42:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    1b46:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    1b4a:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    1b4e:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    1b52:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    1b56:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    1b5a:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    1b5e:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    1b65:	00 00 00 
    1b68:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    1b6f:	00 00 00 
    1b72:	48 8d 45 10          	lea    0x10(%rbp),%rax
    1b76:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    1b7d:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    1b84:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1b8b:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    1b92:	00 00 00 
    1b95:	e9 41 03 00 00       	jmp    1edb <printf+0x3d9>
    if (c != '%') {
    1b9a:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1ba1:	74 24                	je     1bc7 <printf+0xc5>
      putc(fd, c);
    1ba3:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1ba9:	0f be d0             	movsbl %al,%edx
    1bac:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1bb2:	89 d6                	mov    %edx,%esi
    1bb4:	89 c7                	mov    %eax,%edi
    1bb6:	48 b8 1c 19 00 00 00 	movabs $0x191c,%rax
    1bbd:	00 00 00 
    1bc0:	ff d0                	call   *%rax
      continue;
    1bc2:	e9 0d 03 00 00       	jmp    1ed4 <printf+0x3d2>
    }
    c = fmt[++i] & 0xff;
    1bc7:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1bce:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1bd4:	48 63 d0             	movslq %eax,%rdx
    1bd7:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1bde:	48 01 d0             	add    %rdx,%rax
    1be1:	0f b6 00             	movzbl (%rax),%eax
    1be4:	0f be c0             	movsbl %al,%eax
    1be7:	25 ff 00 00 00       	and    $0xff,%eax
    1bec:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    1bf2:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1bf9:	0f 84 0f 03 00 00    	je     1f0e <printf+0x40c>
      break;
    switch(c) {
    1bff:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1c06:	0f 84 74 02 00 00    	je     1e80 <printf+0x37e>
    1c0c:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1c13:	0f 8c 82 02 00 00    	jl     1e9b <printf+0x399>
    1c19:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    1c20:	0f 8f 75 02 00 00    	jg     1e9b <printf+0x399>
    1c26:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    1c2d:	0f 8c 68 02 00 00    	jl     1e9b <printf+0x399>
    1c33:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1c39:	83 e8 63             	sub    $0x63,%eax
    1c3c:	83 f8 15             	cmp    $0x15,%eax
    1c3f:	0f 87 56 02 00 00    	ja     1e9b <printf+0x399>
    1c45:	89 c0                	mov    %eax,%eax
    1c47:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1c4e:	00 
    1c4f:	48 b8 68 22 00 00 00 	movabs $0x2268,%rax
    1c56:	00 00 00 
    1c59:	48 01 d0             	add    %rdx,%rax
    1c5c:	48 8b 00             	mov    (%rax),%rax
    1c5f:	3e ff e0             	notrack jmp *%rax
    case 'c':
      putc(fd, va_arg(ap, int));
    1c62:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1c68:	83 f8 2f             	cmp    $0x2f,%eax
    1c6b:	77 23                	ja     1c90 <printf+0x18e>
    1c6d:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1c74:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1c7a:	89 d2                	mov    %edx,%edx
    1c7c:	48 01 d0             	add    %rdx,%rax
    1c7f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1c85:	83 c2 08             	add    $0x8,%edx
    1c88:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1c8e:	eb 12                	jmp    1ca2 <printf+0x1a0>
    1c90:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1c97:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1c9b:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1ca2:	8b 00                	mov    (%rax),%eax
    1ca4:	0f be d0             	movsbl %al,%edx
    1ca7:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1cad:	89 d6                	mov    %edx,%esi
    1caf:	89 c7                	mov    %eax,%edi
    1cb1:	48 b8 1c 19 00 00 00 	movabs $0x191c,%rax
    1cb8:	00 00 00 
    1cbb:	ff d0                	call   *%rax
      break;
    1cbd:	e9 12 02 00 00       	jmp    1ed4 <printf+0x3d2>
    case 'd':
      print_d(fd, va_arg(ap, int));
    1cc2:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1cc8:	83 f8 2f             	cmp    $0x2f,%eax
    1ccb:	77 23                	ja     1cf0 <printf+0x1ee>
    1ccd:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1cd4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1cda:	89 d2                	mov    %edx,%edx
    1cdc:	48 01 d0             	add    %rdx,%rax
    1cdf:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1ce5:	83 c2 08             	add    $0x8,%edx
    1ce8:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1cee:	eb 12                	jmp    1d02 <printf+0x200>
    1cf0:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1cf7:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1cfb:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1d02:	8b 10                	mov    (%rax),%edx
    1d04:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1d0a:	89 d6                	mov    %edx,%esi
    1d0c:	89 c7                	mov    %eax,%edi
    1d0e:	48 b8 0a 1a 00 00 00 	movabs $0x1a0a,%rax
    1d15:	00 00 00 
    1d18:	ff d0                	call   *%rax
      break;
    1d1a:	e9 b5 01 00 00       	jmp    1ed4 <printf+0x3d2>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    1d1f:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1d25:	83 f8 2f             	cmp    $0x2f,%eax
    1d28:	77 23                	ja     1d4d <printf+0x24b>
    1d2a:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1d31:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1d37:	89 d2                	mov    %edx,%edx
    1d39:	48 01 d0             	add    %rdx,%rax
    1d3c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1d42:	83 c2 08             	add    $0x8,%edx
    1d45:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1d4b:	eb 12                	jmp    1d5f <printf+0x25d>
    1d4d:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1d54:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1d58:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1d5f:	8b 10                	mov    (%rax),%edx
    1d61:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1d67:	89 d6                	mov    %edx,%esi
    1d69:	89 c7                	mov    %eax,%edi
    1d6b:	48 b8 ad 19 00 00 00 	movabs $0x19ad,%rax
    1d72:	00 00 00 
    1d75:	ff d0                	call   *%rax
      break;
    1d77:	e9 58 01 00 00       	jmp    1ed4 <printf+0x3d2>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    1d7c:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1d82:	83 f8 2f             	cmp    $0x2f,%eax
    1d85:	77 23                	ja     1daa <printf+0x2a8>
    1d87:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1d8e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1d94:	89 d2                	mov    %edx,%edx
    1d96:	48 01 d0             	add    %rdx,%rax
    1d99:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1d9f:	83 c2 08             	add    $0x8,%edx
    1da2:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1da8:	eb 12                	jmp    1dbc <printf+0x2ba>
    1daa:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1db1:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1db5:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1dbc:	48 8b 10             	mov    (%rax),%rdx
    1dbf:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1dc5:	48 89 d6             	mov    %rdx,%rsi
    1dc8:	89 c7                	mov    %eax,%edi
    1dca:	48 b8 50 19 00 00 00 	movabs $0x1950,%rax
    1dd1:	00 00 00 
    1dd4:	ff d0                	call   *%rax
      break;
    1dd6:	e9 f9 00 00 00       	jmp    1ed4 <printf+0x3d2>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    1ddb:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1de1:	83 f8 2f             	cmp    $0x2f,%eax
    1de4:	77 23                	ja     1e09 <printf+0x307>
    1de6:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1ded:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1df3:	89 d2                	mov    %edx,%edx
    1df5:	48 01 d0             	add    %rdx,%rax
    1df8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1dfe:	83 c2 08             	add    $0x8,%edx
    1e01:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1e07:	eb 12                	jmp    1e1b <printf+0x319>
    1e09:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1e10:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1e14:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1e1b:	48 8b 00             	mov    (%rax),%rax
    1e1e:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    1e25:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1e2c:	00 
    1e2d:	75 41                	jne    1e70 <printf+0x36e>
        s = "(null)";
    1e2f:	48 b8 60 22 00 00 00 	movabs $0x2260,%rax
    1e36:	00 00 00 
    1e39:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1e40:	eb 2e                	jmp    1e70 <printf+0x36e>
        putc(fd, *(s++));
    1e42:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1e49:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1e4d:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1e54:	0f b6 00             	movzbl (%rax),%eax
    1e57:	0f be d0             	movsbl %al,%edx
    1e5a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1e60:	89 d6                	mov    %edx,%esi
    1e62:	89 c7                	mov    %eax,%edi
    1e64:	48 b8 1c 19 00 00 00 	movabs $0x191c,%rax
    1e6b:	00 00 00 
    1e6e:	ff d0                	call   *%rax
      while (*s)
    1e70:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1e77:	0f b6 00             	movzbl (%rax),%eax
    1e7a:	84 c0                	test   %al,%al
    1e7c:	75 c4                	jne    1e42 <printf+0x340>
      break;
    1e7e:	eb 54                	jmp    1ed4 <printf+0x3d2>
    case '%':
      putc(fd, '%');
    1e80:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1e86:	be 25 00 00 00       	mov    $0x25,%esi
    1e8b:	89 c7                	mov    %eax,%edi
    1e8d:	48 b8 1c 19 00 00 00 	movabs $0x191c,%rax
    1e94:	00 00 00 
    1e97:	ff d0                	call   *%rax
      break;
    1e99:	eb 39                	jmp    1ed4 <printf+0x3d2>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1e9b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1ea1:	be 25 00 00 00       	mov    $0x25,%esi
    1ea6:	89 c7                	mov    %eax,%edi
    1ea8:	48 b8 1c 19 00 00 00 	movabs $0x191c,%rax
    1eaf:	00 00 00 
    1eb2:	ff d0                	call   *%rax
      putc(fd, c);
    1eb4:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1eba:	0f be d0             	movsbl %al,%edx
    1ebd:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1ec3:	89 d6                	mov    %edx,%esi
    1ec5:	89 c7                	mov    %eax,%edi
    1ec7:	48 b8 1c 19 00 00 00 	movabs $0x191c,%rax
    1ece:	00 00 00 
    1ed1:	ff d0                	call   *%rax
      break;
    1ed3:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1ed4:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1edb:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1ee1:	48 63 d0             	movslq %eax,%rdx
    1ee4:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1eeb:	48 01 d0             	add    %rdx,%rax
    1eee:	0f b6 00             	movzbl (%rax),%eax
    1ef1:	0f be c0             	movsbl %al,%eax
    1ef4:	25 ff 00 00 00       	and    $0xff,%eax
    1ef9:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1eff:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1f06:	0f 85 8e fc ff ff    	jne    1b9a <printf+0x98>
    }
  }
}
    1f0c:	eb 01                	jmp    1f0f <printf+0x40d>
      break;
    1f0e:	90                   	nop
}
    1f0f:	90                   	nop
    1f10:	c9                   	leave
    1f11:	c3                   	ret

0000000000001f12 <free>:
    1f12:	55                   	push   %rbp
    1f13:	48 89 e5             	mov    %rsp,%rbp
    1f16:	48 83 ec 18          	sub    $0x18,%rsp
    1f1a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1f1e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1f22:	48 83 e8 10          	sub    $0x10,%rax
    1f26:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1f2a:	48 b8 60 23 00 00 00 	movabs $0x2360,%rax
    1f31:	00 00 00 
    1f34:	48 8b 00             	mov    (%rax),%rax
    1f37:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1f3b:	eb 2f                	jmp    1f6c <free+0x5a>
    1f3d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f41:	48 8b 00             	mov    (%rax),%rax
    1f44:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1f48:	72 17                	jb     1f61 <free+0x4f>
    1f4a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f4e:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1f52:	72 2f                	jb     1f83 <free+0x71>
    1f54:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f58:	48 8b 00             	mov    (%rax),%rax
    1f5b:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1f5f:	72 22                	jb     1f83 <free+0x71>
    1f61:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f65:	48 8b 00             	mov    (%rax),%rax
    1f68:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1f6c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f70:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1f74:	73 c7                	jae    1f3d <free+0x2b>
    1f76:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f7a:	48 8b 00             	mov    (%rax),%rax
    1f7d:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1f81:	73 ba                	jae    1f3d <free+0x2b>
    1f83:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f87:	8b 40 08             	mov    0x8(%rax),%eax
    1f8a:	89 c0                	mov    %eax,%eax
    1f8c:	48 c1 e0 04          	shl    $0x4,%rax
    1f90:	48 89 c2             	mov    %rax,%rdx
    1f93:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f97:	48 01 c2             	add    %rax,%rdx
    1f9a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f9e:	48 8b 00             	mov    (%rax),%rax
    1fa1:	48 39 c2             	cmp    %rax,%rdx
    1fa4:	75 2d                	jne    1fd3 <free+0xc1>
    1fa6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1faa:	8b 50 08             	mov    0x8(%rax),%edx
    1fad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1fb1:	48 8b 00             	mov    (%rax),%rax
    1fb4:	8b 40 08             	mov    0x8(%rax),%eax
    1fb7:	01 c2                	add    %eax,%edx
    1fb9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1fbd:	89 50 08             	mov    %edx,0x8(%rax)
    1fc0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1fc4:	48 8b 00             	mov    (%rax),%rax
    1fc7:	48 8b 10             	mov    (%rax),%rdx
    1fca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1fce:	48 89 10             	mov    %rdx,(%rax)
    1fd1:	eb 0e                	jmp    1fe1 <free+0xcf>
    1fd3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1fd7:	48 8b 10             	mov    (%rax),%rdx
    1fda:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1fde:	48 89 10             	mov    %rdx,(%rax)
    1fe1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1fe5:	8b 40 08             	mov    0x8(%rax),%eax
    1fe8:	89 c0                	mov    %eax,%eax
    1fea:	48 c1 e0 04          	shl    $0x4,%rax
    1fee:	48 89 c2             	mov    %rax,%rdx
    1ff1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ff5:	48 01 d0             	add    %rdx,%rax
    1ff8:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1ffc:	75 27                	jne    2025 <free+0x113>
    1ffe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2002:	8b 50 08             	mov    0x8(%rax),%edx
    2005:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2009:	8b 40 08             	mov    0x8(%rax),%eax
    200c:	01 c2                	add    %eax,%edx
    200e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2012:	89 50 08             	mov    %edx,0x8(%rax)
    2015:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2019:	48 8b 10             	mov    (%rax),%rdx
    201c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2020:	48 89 10             	mov    %rdx,(%rax)
    2023:	eb 0b                	jmp    2030 <free+0x11e>
    2025:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2029:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    202d:	48 89 10             	mov    %rdx,(%rax)
    2030:	48 ba 60 23 00 00 00 	movabs $0x2360,%rdx
    2037:	00 00 00 
    203a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    203e:	48 89 02             	mov    %rax,(%rdx)
    2041:	90                   	nop
    2042:	c9                   	leave
    2043:	c3                   	ret

0000000000002044 <morecore>:
    2044:	55                   	push   %rbp
    2045:	48 89 e5             	mov    %rsp,%rbp
    2048:	48 83 ec 20          	sub    $0x20,%rsp
    204c:	89 7d ec             	mov    %edi,-0x14(%rbp)
    204f:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    2056:	77 07                	ja     205f <morecore+0x1b>
    2058:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
    205f:	8b 45 ec             	mov    -0x14(%rbp),%eax
    2062:	48 c1 e0 04          	shl    $0x4,%rax
    2066:	48 89 c7             	mov    %rax,%rdi
    2069:	48 b8 db 18 00 00 00 	movabs $0x18db,%rax
    2070:	00 00 00 
    2073:	ff d0                	call   *%rax
    2075:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    2079:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    207e:	75 07                	jne    2087 <morecore+0x43>
    2080:	b8 00 00 00 00       	mov    $0x0,%eax
    2085:	eb 36                	jmp    20bd <morecore+0x79>
    2087:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    208b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    208f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2093:	8b 55 ec             	mov    -0x14(%rbp),%edx
    2096:	89 50 08             	mov    %edx,0x8(%rax)
    2099:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    209d:	48 83 c0 10          	add    $0x10,%rax
    20a1:	48 89 c7             	mov    %rax,%rdi
    20a4:	48 b8 12 1f 00 00 00 	movabs $0x1f12,%rax
    20ab:	00 00 00 
    20ae:	ff d0                	call   *%rax
    20b0:	48 b8 60 23 00 00 00 	movabs $0x2360,%rax
    20b7:	00 00 00 
    20ba:	48 8b 00             	mov    (%rax),%rax
    20bd:	c9                   	leave
    20be:	c3                   	ret

00000000000020bf <malloc>:
    20bf:	55                   	push   %rbp
    20c0:	48 89 e5             	mov    %rsp,%rbp
    20c3:	48 83 ec 30          	sub    $0x30,%rsp
    20c7:	89 7d dc             	mov    %edi,-0x24(%rbp)
    20ca:	8b 45 dc             	mov    -0x24(%rbp),%eax
    20cd:	48 83 c0 0f          	add    $0xf,%rax
    20d1:	48 c1 e8 04          	shr    $0x4,%rax
    20d5:	83 c0 01             	add    $0x1,%eax
    20d8:	89 45 ec             	mov    %eax,-0x14(%rbp)
    20db:	48 b8 60 23 00 00 00 	movabs $0x2360,%rax
    20e2:	00 00 00 
    20e5:	48 8b 00             	mov    (%rax),%rax
    20e8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    20ec:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    20f1:	75 4a                	jne    213d <malloc+0x7e>
    20f3:	48 b8 50 23 00 00 00 	movabs $0x2350,%rax
    20fa:	00 00 00 
    20fd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    2101:	48 ba 60 23 00 00 00 	movabs $0x2360,%rdx
    2108:	00 00 00 
    210b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    210f:	48 89 02             	mov    %rax,(%rdx)
    2112:	48 b8 60 23 00 00 00 	movabs $0x2360,%rax
    2119:	00 00 00 
    211c:	48 8b 00             	mov    (%rax),%rax
    211f:	48 ba 50 23 00 00 00 	movabs $0x2350,%rdx
    2126:	00 00 00 
    2129:	48 89 02             	mov    %rax,(%rdx)
    212c:	48 b8 50 23 00 00 00 	movabs $0x2350,%rax
    2133:	00 00 00 
    2136:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
    213d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2141:	48 8b 00             	mov    (%rax),%rax
    2144:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    2148:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    214c:	8b 40 08             	mov    0x8(%rax),%eax
    214f:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    2152:	72 65                	jb     21b9 <malloc+0xfa>
    2154:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2158:	8b 40 08             	mov    0x8(%rax),%eax
    215b:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    215e:	75 10                	jne    2170 <malloc+0xb1>
    2160:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2164:	48 8b 10             	mov    (%rax),%rdx
    2167:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    216b:	48 89 10             	mov    %rdx,(%rax)
    216e:	eb 2e                	jmp    219e <malloc+0xdf>
    2170:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2174:	8b 40 08             	mov    0x8(%rax),%eax
    2177:	2b 45 ec             	sub    -0x14(%rbp),%eax
    217a:	89 c2                	mov    %eax,%edx
    217c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2180:	89 50 08             	mov    %edx,0x8(%rax)
    2183:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2187:	8b 40 08             	mov    0x8(%rax),%eax
    218a:	89 c0                	mov    %eax,%eax
    218c:	48 c1 e0 04          	shl    $0x4,%rax
    2190:	48 01 45 f8          	add    %rax,-0x8(%rbp)
    2194:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2198:	8b 55 ec             	mov    -0x14(%rbp),%edx
    219b:	89 50 08             	mov    %edx,0x8(%rax)
    219e:	48 ba 60 23 00 00 00 	movabs $0x2360,%rdx
    21a5:	00 00 00 
    21a8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    21ac:	48 89 02             	mov    %rax,(%rdx)
    21af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    21b3:	48 83 c0 10          	add    $0x10,%rax
    21b7:	eb 4e                	jmp    2207 <malloc+0x148>
    21b9:	48 b8 60 23 00 00 00 	movabs $0x2360,%rax
    21c0:	00 00 00 
    21c3:	48 8b 00             	mov    (%rax),%rax
    21c6:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    21ca:	75 23                	jne    21ef <malloc+0x130>
    21cc:	8b 45 ec             	mov    -0x14(%rbp),%eax
    21cf:	89 c7                	mov    %eax,%edi
    21d1:	48 b8 44 20 00 00 00 	movabs $0x2044,%rax
    21d8:	00 00 00 
    21db:	ff d0                	call   *%rax
    21dd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    21e1:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    21e6:	75 07                	jne    21ef <malloc+0x130>
    21e8:	b8 00 00 00 00       	mov    $0x0,%eax
    21ed:	eb 18                	jmp    2207 <malloc+0x148>
    21ef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    21f3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    21f7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    21fb:	48 8b 00             	mov    (%rax),%rax
    21fe:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    2202:	e9 41 ff ff ff       	jmp    2148 <malloc+0x89>
    2207:	c9                   	leave
    2208:	c3                   	ret
