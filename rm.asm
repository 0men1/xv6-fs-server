
_rm:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
    1000:	f3 0f 1e fa          	endbr64
    1004:	55                   	push   %rbp
    1005:	48 89 e5             	mov    %rsp,%rbp
    1008:	48 83 ec 20          	sub    $0x20,%rsp
    100c:	89 7d ec             	mov    %edi,-0x14(%rbp)
    100f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;

  if(argc < 2){
    1013:	83 7d ec 01          	cmpl   $0x1,-0x14(%rbp)
    1017:	7f 2f                	jg     1048 <main+0x48>
    printf(2, "Usage: rm files...\n");
    1019:	48 b8 20 1e 00 00 00 	movabs $0x1e20,%rax
    1020:	00 00 00 
    1023:	48 89 c6             	mov    %rax,%rsi
    1026:	bf 02 00 00 00       	mov    $0x2,%edi
    102b:	b8 00 00 00 00       	mov    $0x0,%eax
    1030:	48 ba 19 17 00 00 00 	movabs $0x1719,%rdx
    1037:	00 00 00 
    103a:	ff d2                	call   *%rdx
    exit();
    103c:	48 b8 15 14 00 00 00 	movabs $0x1415,%rax
    1043:	00 00 00 
    1046:	ff d0                	call   *%rax
  }

  for(i = 1; i < argc; i++){
    1048:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
    104f:	eb 6d                	jmp    10be <main+0xbe>
    if(unlink(argv[i]) < 0){
    1051:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1054:	48 98                	cltq
    1056:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    105d:	00 
    105e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1062:	48 01 d0             	add    %rdx,%rax
    1065:	48 8b 00             	mov    (%rax),%rax
    1068:	48 89 c7             	mov    %rax,%rdi
    106b:	48 b8 97 14 00 00 00 	movabs $0x1497,%rax
    1072:	00 00 00 
    1075:	ff d0                	call   *%rax
    1077:	85 c0                	test   %eax,%eax
    1079:	79 3f                	jns    10ba <main+0xba>
      printf(2, "rm: %s failed to delete\n", argv[i]);
    107b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    107e:	48 98                	cltq
    1080:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1087:	00 
    1088:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    108c:	48 01 d0             	add    %rdx,%rax
    108f:	48 8b 00             	mov    (%rax),%rax
    1092:	48 89 c2             	mov    %rax,%rdx
    1095:	48 b8 34 1e 00 00 00 	movabs $0x1e34,%rax
    109c:	00 00 00 
    109f:	48 89 c6             	mov    %rax,%rsi
    10a2:	bf 02 00 00 00       	mov    $0x2,%edi
    10a7:	b8 00 00 00 00       	mov    $0x0,%eax
    10ac:	48 b9 19 17 00 00 00 	movabs $0x1719,%rcx
    10b3:	00 00 00 
    10b6:	ff d1                	call   *%rcx
      break;
    10b8:	eb 0c                	jmp    10c6 <main+0xc6>
  for(i = 1; i < argc; i++){
    10ba:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    10be:	8b 45 fc             	mov    -0x4(%rbp),%eax
    10c1:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    10c4:	7c 8b                	jl     1051 <main+0x51>
    }
  }

  exit();
    10c6:	48 b8 15 14 00 00 00 	movabs $0x1415,%rax
    10cd:	00 00 00 
    10d0:	ff d0                	call   *%rax

00000000000010d2 <stosb>:
  stosb(dst, c, n);
  return dst;
}

char*
strchr(const char *s, char c)
    10d2:	f3 0f 1e fa          	endbr64
    10d6:	55                   	push   %rbp
    10d7:	48 89 e5             	mov    %rsp,%rbp
    10da:	48 83 ec 10          	sub    $0x10,%rsp
    10de:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    10e2:	89 75 f4             	mov    %esi,-0xc(%rbp)
    10e5:	89 55 f0             	mov    %edx,-0x10(%rbp)
{
    10e8:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    10ec:	8b 55 f0             	mov    -0x10(%rbp),%edx
    10ef:	8b 45 f4             	mov    -0xc(%rbp),%eax
    10f2:	48 89 ce             	mov    %rcx,%rsi
    10f5:	48 89 f7             	mov    %rsi,%rdi
    10f8:	89 d1                	mov    %edx,%ecx
    10fa:	fc                   	cld
    10fb:	f3 aa                	rep stos %al,%es:(%rdi)
    10fd:	89 ca                	mov    %ecx,%edx
    10ff:	48 89 fe             	mov    %rdi,%rsi
    1102:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    1106:	89 55 f0             	mov    %edx,-0x10(%rbp)
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
    1109:	90                   	nop
    110a:	c9                   	leave
    110b:	c3                   	ret

000000000000110c <strcpy>:
{
    110c:	f3 0f 1e fa          	endbr64
    1110:	55                   	push   %rbp
    1111:	48 89 e5             	mov    %rsp,%rbp
    1114:	48 83 ec 20          	sub    $0x20,%rsp
    1118:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    111c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  os = s;
    1120:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1124:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    1128:	90                   	nop
    1129:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    112d:	48 8d 42 01          	lea    0x1(%rdx),%rax
    1131:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    1135:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1139:	48 8d 48 01          	lea    0x1(%rax),%rcx
    113d:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    1141:	0f b6 12             	movzbl (%rdx),%edx
    1144:	88 10                	mov    %dl,(%rax)
    1146:	0f b6 00             	movzbl (%rax),%eax
    1149:	84 c0                	test   %al,%al
    114b:	75 dc                	jne    1129 <strcpy+0x1d>
  return os;
    114d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    1151:	c9                   	leave
    1152:	c3                   	ret

0000000000001153 <strcmp>:
{
    1153:	f3 0f 1e fa          	endbr64
    1157:	55                   	push   %rbp
    1158:	48 89 e5             	mov    %rsp,%rbp
    115b:	48 83 ec 10          	sub    $0x10,%rsp
    115f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1163:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    1167:	eb 0a                	jmp    1173 <strcmp+0x20>
    p++, q++;
    1169:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    116e:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    1173:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1177:	0f b6 00             	movzbl (%rax),%eax
    117a:	84 c0                	test   %al,%al
    117c:	74 12                	je     1190 <strcmp+0x3d>
    117e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1182:	0f b6 10             	movzbl (%rax),%edx
    1185:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1189:	0f b6 00             	movzbl (%rax),%eax
    118c:	38 c2                	cmp    %al,%dl
    118e:	74 d9                	je     1169 <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
    1190:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1194:	0f b6 00             	movzbl (%rax),%eax
    1197:	0f b6 d0             	movzbl %al,%edx
    119a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    119e:	0f b6 00             	movzbl (%rax),%eax
    11a1:	0f b6 c0             	movzbl %al,%eax
    11a4:	29 c2                	sub    %eax,%edx
    11a6:	89 d0                	mov    %edx,%eax
}
    11a8:	c9                   	leave
    11a9:	c3                   	ret

00000000000011aa <strlen>:
{
    11aa:	f3 0f 1e fa          	endbr64
    11ae:	55                   	push   %rbp
    11af:	48 89 e5             	mov    %rsp,%rbp
    11b2:	48 83 ec 18          	sub    $0x18,%rsp
    11b6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  for(n = 0; s[n]; n++)
    11ba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    11c1:	eb 04                	jmp    11c7 <strlen+0x1d>
    11c3:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    11c7:	8b 45 fc             	mov    -0x4(%rbp),%eax
    11ca:	48 63 d0             	movslq %eax,%rdx
    11cd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    11d1:	48 01 d0             	add    %rdx,%rax
    11d4:	0f b6 00             	movzbl (%rax),%eax
    11d7:	84 c0                	test   %al,%al
    11d9:	75 e8                	jne    11c3 <strlen+0x19>
  return n;
    11db:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    11de:	c9                   	leave
    11df:	c3                   	ret

00000000000011e0 <memset>:
{
    11e0:	f3 0f 1e fa          	endbr64
    11e4:	55                   	push   %rbp
    11e5:	48 89 e5             	mov    %rsp,%rbp
    11e8:	48 83 ec 10          	sub    $0x10,%rsp
    11ec:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    11f0:	89 75 f4             	mov    %esi,-0xc(%rbp)
    11f3:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    11f6:	8b 55 f0             	mov    -0x10(%rbp),%edx
    11f9:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    11fc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1200:	89 ce                	mov    %ecx,%esi
    1202:	48 89 c7             	mov    %rax,%rdi
    1205:	48 b8 d2 10 00 00 00 	movabs $0x10d2,%rax
    120c:	00 00 00 
    120f:	ff d0                	call   *%rax
  return dst;
    1211:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    1215:	c9                   	leave
    1216:	c3                   	ret

0000000000001217 <strchr>:
{
    1217:	f3 0f 1e fa          	endbr64
    121b:	55                   	push   %rbp
    121c:	48 89 e5             	mov    %rsp,%rbp
    121f:	48 83 ec 10          	sub    $0x10,%rsp
    1223:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1227:	89 f0                	mov    %esi,%eax
    1229:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    122c:	eb 17                	jmp    1245 <strchr+0x2e>
    if(*s == c)
    122e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1232:	0f b6 00             	movzbl (%rax),%eax
    1235:	38 45 f4             	cmp    %al,-0xc(%rbp)
    1238:	75 06                	jne    1240 <strchr+0x29>
      return (char*)s;
    123a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    123e:	eb 15                	jmp    1255 <strchr+0x3e>
  for(; *s; s++)
    1240:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1245:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1249:	0f b6 00             	movzbl (%rax),%eax
    124c:	84 c0                	test   %al,%al
    124e:	75 de                	jne    122e <strchr+0x17>
  return 0;
    1250:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1255:	c9                   	leave
    1256:	c3                   	ret

0000000000001257 <gets>:

char*
gets(char *buf, int max)
{
    1257:	f3 0f 1e fa          	endbr64
    125b:	55                   	push   %rbp
    125c:	48 89 e5             	mov    %rsp,%rbp
    125f:	48 83 ec 20          	sub    $0x20,%rsp
    1263:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1267:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    126a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1271:	eb 4f                	jmp    12c2 <gets+0x6b>
    cc = read(0, &c, 1);
    1273:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    1277:	ba 01 00 00 00       	mov    $0x1,%edx
    127c:	48 89 c6             	mov    %rax,%rsi
    127f:	bf 00 00 00 00       	mov    $0x0,%edi
    1284:	48 b8 3c 14 00 00 00 	movabs $0x143c,%rax
    128b:	00 00 00 
    128e:	ff d0                	call   *%rax
    1290:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    1293:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1297:	7e 36                	jle    12cf <gets+0x78>
      break;
    buf[i++] = c;
    1299:	8b 45 fc             	mov    -0x4(%rbp),%eax
    129c:	8d 50 01             	lea    0x1(%rax),%edx
    129f:	89 55 fc             	mov    %edx,-0x4(%rbp)
    12a2:	48 63 d0             	movslq %eax,%rdx
    12a5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12a9:	48 01 c2             	add    %rax,%rdx
    12ac:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    12b0:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    12b2:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    12b6:	3c 0a                	cmp    $0xa,%al
    12b8:	74 16                	je     12d0 <gets+0x79>
    12ba:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    12be:	3c 0d                	cmp    $0xd,%al
    12c0:	74 0e                	je     12d0 <gets+0x79>
  for(i=0; i+1 < max; ){
    12c2:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12c5:	83 c0 01             	add    $0x1,%eax
    12c8:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    12cb:	7f a6                	jg     1273 <gets+0x1c>
    12cd:	eb 01                	jmp    12d0 <gets+0x79>
      break;
    12cf:	90                   	nop
      break;
  }
  buf[i] = '\0';
    12d0:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12d3:	48 63 d0             	movslq %eax,%rdx
    12d6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12da:	48 01 d0             	add    %rdx,%rax
    12dd:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    12e0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    12e4:	c9                   	leave
    12e5:	c3                   	ret

00000000000012e6 <stat>:

int
stat(char *n, struct stat *st)
{
    12e6:	f3 0f 1e fa          	endbr64
    12ea:	55                   	push   %rbp
    12eb:	48 89 e5             	mov    %rsp,%rbp
    12ee:	48 83 ec 20          	sub    $0x20,%rsp
    12f2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    12f6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    12fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12fe:	be 00 00 00 00       	mov    $0x0,%esi
    1303:	48 89 c7             	mov    %rax,%rdi
    1306:	48 b8 7d 14 00 00 00 	movabs $0x147d,%rax
    130d:	00 00 00 
    1310:	ff d0                	call   *%rax
    1312:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    1315:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1319:	79 07                	jns    1322 <stat+0x3c>
    return -1;
    131b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1320:	eb 2f                	jmp    1351 <stat+0x6b>
  r = fstat(fd, st);
    1322:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1326:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1329:	48 89 d6             	mov    %rdx,%rsi
    132c:	89 c7                	mov    %eax,%edi
    132e:	48 b8 a4 14 00 00 00 	movabs $0x14a4,%rax
    1335:	00 00 00 
    1338:	ff d0                	call   *%rax
    133a:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    133d:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1340:	89 c7                	mov    %eax,%edi
    1342:	48 b8 56 14 00 00 00 	movabs $0x1456,%rax
    1349:	00 00 00 
    134c:	ff d0                	call   *%rax
  return r;
    134e:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    1351:	c9                   	leave
    1352:	c3                   	ret

0000000000001353 <atoi>:

int
atoi(const char *s)
{
    1353:	f3 0f 1e fa          	endbr64
    1357:	55                   	push   %rbp
    1358:	48 89 e5             	mov    %rsp,%rbp
    135b:	48 83 ec 18          	sub    $0x18,%rsp
    135f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    1363:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    136a:	eb 28                	jmp    1394 <atoi+0x41>
    n = n*10 + *s++ - '0';
    136c:	8b 55 fc             	mov    -0x4(%rbp),%edx
    136f:	89 d0                	mov    %edx,%eax
    1371:	c1 e0 02             	shl    $0x2,%eax
    1374:	01 d0                	add    %edx,%eax
    1376:	01 c0                	add    %eax,%eax
    1378:	89 c1                	mov    %eax,%ecx
    137a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    137e:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1382:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    1386:	0f b6 00             	movzbl (%rax),%eax
    1389:	0f be c0             	movsbl %al,%eax
    138c:	01 c8                	add    %ecx,%eax
    138e:	83 e8 30             	sub    $0x30,%eax
    1391:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1394:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1398:	0f b6 00             	movzbl (%rax),%eax
    139b:	3c 2f                	cmp    $0x2f,%al
    139d:	7e 0b                	jle    13aa <atoi+0x57>
    139f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    13a3:	0f b6 00             	movzbl (%rax),%eax
    13a6:	3c 39                	cmp    $0x39,%al
    13a8:	7e c2                	jle    136c <atoi+0x19>
  return n;
    13aa:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    13ad:	c9                   	leave
    13ae:	c3                   	ret

00000000000013af <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    13af:	f3 0f 1e fa          	endbr64
    13b3:	55                   	push   %rbp
    13b4:	48 89 e5             	mov    %rsp,%rbp
    13b7:	48 83 ec 28          	sub    $0x28,%rsp
    13bb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    13bf:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    13c3:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    13c6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    13ca:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    13ce:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    13d2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    13d6:	eb 1d                	jmp    13f5 <memmove+0x46>
    *dst++ = *src++;
    13d8:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    13dc:	48 8d 42 01          	lea    0x1(%rdx),%rax
    13e0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    13e4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13e8:	48 8d 48 01          	lea    0x1(%rax),%rcx
    13ec:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    13f0:	0f b6 12             	movzbl (%rdx),%edx
    13f3:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    13f5:	8b 45 dc             	mov    -0x24(%rbp),%eax
    13f8:	8d 50 ff             	lea    -0x1(%rax),%edx
    13fb:	89 55 dc             	mov    %edx,-0x24(%rbp)
    13fe:	85 c0                	test   %eax,%eax
    1400:	7f d6                	jg     13d8 <memmove+0x29>
  return vdst;
    1402:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    1406:	c9                   	leave
    1407:	c3                   	ret

0000000000001408 <fork>:
    1408:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    140f:	49 89 ca             	mov    %rcx,%r10
    1412:	0f 05                	syscall
    1414:	c3                   	ret

0000000000001415 <exit>:
    1415:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    141c:	49 89 ca             	mov    %rcx,%r10
    141f:	0f 05                	syscall
    1421:	c3                   	ret

0000000000001422 <wait>:
    1422:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    1429:	49 89 ca             	mov    %rcx,%r10
    142c:	0f 05                	syscall
    142e:	c3                   	ret

000000000000142f <pipe>:
    142f:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    1436:	49 89 ca             	mov    %rcx,%r10
    1439:	0f 05                	syscall
    143b:	c3                   	ret

000000000000143c <read>:
    143c:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    1443:	49 89 ca             	mov    %rcx,%r10
    1446:	0f 05                	syscall
    1448:	c3                   	ret

0000000000001449 <write>:
    1449:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    1450:	49 89 ca             	mov    %rcx,%r10
    1453:	0f 05                	syscall
    1455:	c3                   	ret

0000000000001456 <close>:
    1456:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    145d:	49 89 ca             	mov    %rcx,%r10
    1460:	0f 05                	syscall
    1462:	c3                   	ret

0000000000001463 <kill>:
    1463:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    146a:	49 89 ca             	mov    %rcx,%r10
    146d:	0f 05                	syscall
    146f:	c3                   	ret

0000000000001470 <exec>:
    1470:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    1477:	49 89 ca             	mov    %rcx,%r10
    147a:	0f 05                	syscall
    147c:	c3                   	ret

000000000000147d <open>:
    147d:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    1484:	49 89 ca             	mov    %rcx,%r10
    1487:	0f 05                	syscall
    1489:	c3                   	ret

000000000000148a <mknod>:
    148a:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    1491:	49 89 ca             	mov    %rcx,%r10
    1494:	0f 05                	syscall
    1496:	c3                   	ret

0000000000001497 <unlink>:
    1497:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    149e:	49 89 ca             	mov    %rcx,%r10
    14a1:	0f 05                	syscall
    14a3:	c3                   	ret

00000000000014a4 <fstat>:
    14a4:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    14ab:	49 89 ca             	mov    %rcx,%r10
    14ae:	0f 05                	syscall
    14b0:	c3                   	ret

00000000000014b1 <link>:
    14b1:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    14b8:	49 89 ca             	mov    %rcx,%r10
    14bb:	0f 05                	syscall
    14bd:	c3                   	ret

00000000000014be <mkdir>:
    14be:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    14c5:	49 89 ca             	mov    %rcx,%r10
    14c8:	0f 05                	syscall
    14ca:	c3                   	ret

00000000000014cb <chdir>:
    14cb:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    14d2:	49 89 ca             	mov    %rcx,%r10
    14d5:	0f 05                	syscall
    14d7:	c3                   	ret

00000000000014d8 <dup>:
    14d8:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    14df:	49 89 ca             	mov    %rcx,%r10
    14e2:	0f 05                	syscall
    14e4:	c3                   	ret

00000000000014e5 <getpid>:
    14e5:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    14ec:	49 89 ca             	mov    %rcx,%r10
    14ef:	0f 05                	syscall
    14f1:	c3                   	ret

00000000000014f2 <sbrk>:
    14f2:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    14f9:	49 89 ca             	mov    %rcx,%r10
    14fc:	0f 05                	syscall
    14fe:	c3                   	ret

00000000000014ff <sleep>:
    14ff:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    1506:	49 89 ca             	mov    %rcx,%r10
    1509:	0f 05                	syscall
    150b:	c3                   	ret

000000000000150c <uptime>:
    150c:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    1513:	49 89 ca             	mov    %rcx,%r10
    1516:	0f 05                	syscall
    1518:	c3                   	ret

0000000000001519 <send>:
    1519:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    1520:	49 89 ca             	mov    %rcx,%r10
    1523:	0f 05                	syscall
    1525:	c3                   	ret

0000000000001526 <recv>:
    1526:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    152d:	49 89 ca             	mov    %rcx,%r10
    1530:	0f 05                	syscall
    1532:	c3                   	ret

0000000000001533 <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    1533:	f3 0f 1e fa          	endbr64
    1537:	55                   	push   %rbp
    1538:	48 89 e5             	mov    %rsp,%rbp
    153b:	48 83 ec 10          	sub    $0x10,%rsp
    153f:	89 7d fc             	mov    %edi,-0x4(%rbp)
    1542:	89 f0                	mov    %esi,%eax
    1544:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    1547:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    154b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    154e:	ba 01 00 00 00       	mov    $0x1,%edx
    1553:	48 89 ce             	mov    %rcx,%rsi
    1556:	89 c7                	mov    %eax,%edi
    1558:	48 b8 49 14 00 00 00 	movabs $0x1449,%rax
    155f:	00 00 00 
    1562:	ff d0                	call   *%rax
}
    1564:	90                   	nop
    1565:	c9                   	leave
    1566:	c3                   	ret

0000000000001567 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    1567:	f3 0f 1e fa          	endbr64
    156b:	55                   	push   %rbp
    156c:	48 89 e5             	mov    %rsp,%rbp
    156f:	48 83 ec 20          	sub    $0x20,%rsp
    1573:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1576:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    157a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1581:	eb 35                	jmp    15b8 <print_x64+0x51>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    1583:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1587:	48 c1 e8 3c          	shr    $0x3c,%rax
    158b:	48 ba 10 1f 00 00 00 	movabs $0x1f10,%rdx
    1592:	00 00 00 
    1595:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1599:	0f be d0             	movsbl %al,%edx
    159c:	8b 45 ec             	mov    -0x14(%rbp),%eax
    159f:	89 d6                	mov    %edx,%esi
    15a1:	89 c7                	mov    %eax,%edi
    15a3:	48 b8 33 15 00 00 00 	movabs $0x1533,%rax
    15aa:	00 00 00 
    15ad:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    15af:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    15b3:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    15b8:	8b 45 fc             	mov    -0x4(%rbp),%eax
    15bb:	83 f8 0f             	cmp    $0xf,%eax
    15be:	76 c3                	jbe    1583 <print_x64+0x1c>
}
    15c0:	90                   	nop
    15c1:	90                   	nop
    15c2:	c9                   	leave
    15c3:	c3                   	ret

00000000000015c4 <print_x32>:

  static void
print_x32(int fd, uint x)
{
    15c4:	f3 0f 1e fa          	endbr64
    15c8:	55                   	push   %rbp
    15c9:	48 89 e5             	mov    %rsp,%rbp
    15cc:	48 83 ec 20          	sub    $0x20,%rsp
    15d0:	89 7d ec             	mov    %edi,-0x14(%rbp)
    15d3:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    15d6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    15dd:	eb 36                	jmp    1615 <print_x32+0x51>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    15df:	8b 45 e8             	mov    -0x18(%rbp),%eax
    15e2:	c1 e8 1c             	shr    $0x1c,%eax
    15e5:	89 c2                	mov    %eax,%edx
    15e7:	48 b8 10 1f 00 00 00 	movabs $0x1f10,%rax
    15ee:	00 00 00 
    15f1:	89 d2                	mov    %edx,%edx
    15f3:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    15f7:	0f be d0             	movsbl %al,%edx
    15fa:	8b 45 ec             	mov    -0x14(%rbp),%eax
    15fd:	89 d6                	mov    %edx,%esi
    15ff:	89 c7                	mov    %eax,%edi
    1601:	48 b8 33 15 00 00 00 	movabs $0x1533,%rax
    1608:	00 00 00 
    160b:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    160d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1611:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    1615:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1618:	83 f8 07             	cmp    $0x7,%eax
    161b:	76 c2                	jbe    15df <print_x32+0x1b>
}
    161d:	90                   	nop
    161e:	90                   	nop
    161f:	c9                   	leave
    1620:	c3                   	ret

0000000000001621 <print_d>:

  static void
print_d(int fd, int v)
{
    1621:	f3 0f 1e fa          	endbr64
    1625:	55                   	push   %rbp
    1626:	48 89 e5             	mov    %rsp,%rbp
    1629:	48 83 ec 30          	sub    $0x30,%rsp
    162d:	89 7d dc             	mov    %edi,-0x24(%rbp)
    1630:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    1633:	8b 45 d8             	mov    -0x28(%rbp),%eax
    1636:	48 98                	cltq
    1638:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    163c:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1640:	79 04                	jns    1646 <print_d+0x25>
    x = -x;
    1642:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    1646:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    164d:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1651:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1658:	66 66 66 
    165b:	48 89 c8             	mov    %rcx,%rax
    165e:	48 f7 ea             	imul   %rdx
    1661:	48 c1 fa 02          	sar    $0x2,%rdx
    1665:	48 89 c8             	mov    %rcx,%rax
    1668:	48 c1 f8 3f          	sar    $0x3f,%rax
    166c:	48 29 c2             	sub    %rax,%rdx
    166f:	48 89 d0             	mov    %rdx,%rax
    1672:	48 c1 e0 02          	shl    $0x2,%rax
    1676:	48 01 d0             	add    %rdx,%rax
    1679:	48 01 c0             	add    %rax,%rax
    167c:	48 29 c1             	sub    %rax,%rcx
    167f:	48 89 ca             	mov    %rcx,%rdx
    1682:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1685:	8d 48 01             	lea    0x1(%rax),%ecx
    1688:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    168b:	48 b9 10 1f 00 00 00 	movabs $0x1f10,%rcx
    1692:	00 00 00 
    1695:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    1699:	48 98                	cltq
    169b:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    169f:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    16a3:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    16aa:	66 66 66 
    16ad:	48 89 c8             	mov    %rcx,%rax
    16b0:	48 f7 ea             	imul   %rdx
    16b3:	48 89 d0             	mov    %rdx,%rax
    16b6:	48 c1 f8 02          	sar    $0x2,%rax
    16ba:	48 c1 f9 3f          	sar    $0x3f,%rcx
    16be:	48 89 ca             	mov    %rcx,%rdx
    16c1:	48 29 d0             	sub    %rdx,%rax
    16c4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    16c8:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    16cd:	0f 85 7a ff ff ff    	jne    164d <print_d+0x2c>

  if (v < 0)
    16d3:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    16d7:	79 32                	jns    170b <print_d+0xea>
    buf[i++] = '-';
    16d9:	8b 45 f4             	mov    -0xc(%rbp),%eax
    16dc:	8d 50 01             	lea    0x1(%rax),%edx
    16df:	89 55 f4             	mov    %edx,-0xc(%rbp)
    16e2:	48 98                	cltq
    16e4:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    16e9:	eb 20                	jmp    170b <print_d+0xea>
    putc(fd, buf[i]);
    16eb:	8b 45 f4             	mov    -0xc(%rbp),%eax
    16ee:	48 98                	cltq
    16f0:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    16f5:	0f be d0             	movsbl %al,%edx
    16f8:	8b 45 dc             	mov    -0x24(%rbp),%eax
    16fb:	89 d6                	mov    %edx,%esi
    16fd:	89 c7                	mov    %eax,%edi
    16ff:	48 b8 33 15 00 00 00 	movabs $0x1533,%rax
    1706:	00 00 00 
    1709:	ff d0                	call   *%rax
  while (--i >= 0)
    170b:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    170f:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1713:	79 d6                	jns    16eb <print_d+0xca>
}
    1715:	90                   	nop
    1716:	90                   	nop
    1717:	c9                   	leave
    1718:	c3                   	ret

0000000000001719 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    1719:	f3 0f 1e fa          	endbr64
    171d:	55                   	push   %rbp
    171e:	48 89 e5             	mov    %rsp,%rbp
    1721:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    1728:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    172e:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    1735:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    173c:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    1743:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    174a:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    1751:	84 c0                	test   %al,%al
    1753:	74 20                	je     1775 <printf+0x5c>
    1755:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    1759:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    175d:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    1761:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    1765:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    1769:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    176d:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    1771:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    1775:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    177c:	00 00 00 
    177f:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    1786:	00 00 00 
    1789:	48 8d 45 10          	lea    0x10(%rbp),%rax
    178d:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    1794:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    179b:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    17a2:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    17a9:	00 00 00 
    17ac:	e9 41 03 00 00       	jmp    1af2 <printf+0x3d9>
    if (c != '%') {
    17b1:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    17b8:	74 24                	je     17de <printf+0xc5>
      putc(fd, c);
    17ba:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    17c0:	0f be d0             	movsbl %al,%edx
    17c3:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    17c9:	89 d6                	mov    %edx,%esi
    17cb:	89 c7                	mov    %eax,%edi
    17cd:	48 b8 33 15 00 00 00 	movabs $0x1533,%rax
    17d4:	00 00 00 
    17d7:	ff d0                	call   *%rax
      continue;
    17d9:	e9 0d 03 00 00       	jmp    1aeb <printf+0x3d2>
    }
    c = fmt[++i] & 0xff;
    17de:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    17e5:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    17eb:	48 63 d0             	movslq %eax,%rdx
    17ee:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    17f5:	48 01 d0             	add    %rdx,%rax
    17f8:	0f b6 00             	movzbl (%rax),%eax
    17fb:	0f be c0             	movsbl %al,%eax
    17fe:	25 ff 00 00 00       	and    $0xff,%eax
    1803:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    1809:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1810:	0f 84 0f 03 00 00    	je     1b25 <printf+0x40c>
      break;
    switch(c) {
    1816:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    181d:	0f 84 74 02 00 00    	je     1a97 <printf+0x37e>
    1823:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    182a:	0f 8c 82 02 00 00    	jl     1ab2 <printf+0x399>
    1830:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    1837:	0f 8f 75 02 00 00    	jg     1ab2 <printf+0x399>
    183d:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    1844:	0f 8c 68 02 00 00    	jl     1ab2 <printf+0x399>
    184a:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1850:	83 e8 63             	sub    $0x63,%eax
    1853:	83 f8 15             	cmp    $0x15,%eax
    1856:	0f 87 56 02 00 00    	ja     1ab2 <printf+0x399>
    185c:	89 c0                	mov    %eax,%eax
    185e:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1865:	00 
    1866:	48 b8 58 1e 00 00 00 	movabs $0x1e58,%rax
    186d:	00 00 00 
    1870:	48 01 d0             	add    %rdx,%rax
    1873:	48 8b 00             	mov    (%rax),%rax
    1876:	3e ff e0             	notrack jmp *%rax
    case 'c':
      putc(fd, va_arg(ap, int));
    1879:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    187f:	83 f8 2f             	cmp    $0x2f,%eax
    1882:	77 23                	ja     18a7 <printf+0x18e>
    1884:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    188b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1891:	89 d2                	mov    %edx,%edx
    1893:	48 01 d0             	add    %rdx,%rax
    1896:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    189c:	83 c2 08             	add    $0x8,%edx
    189f:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    18a5:	eb 12                	jmp    18b9 <printf+0x1a0>
    18a7:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    18ae:	48 8d 50 08          	lea    0x8(%rax),%rdx
    18b2:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    18b9:	8b 00                	mov    (%rax),%eax
    18bb:	0f be d0             	movsbl %al,%edx
    18be:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    18c4:	89 d6                	mov    %edx,%esi
    18c6:	89 c7                	mov    %eax,%edi
    18c8:	48 b8 33 15 00 00 00 	movabs $0x1533,%rax
    18cf:	00 00 00 
    18d2:	ff d0                	call   *%rax
      break;
    18d4:	e9 12 02 00 00       	jmp    1aeb <printf+0x3d2>
    case 'd':
      print_d(fd, va_arg(ap, int));
    18d9:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    18df:	83 f8 2f             	cmp    $0x2f,%eax
    18e2:	77 23                	ja     1907 <printf+0x1ee>
    18e4:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    18eb:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18f1:	89 d2                	mov    %edx,%edx
    18f3:	48 01 d0             	add    %rdx,%rax
    18f6:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18fc:	83 c2 08             	add    $0x8,%edx
    18ff:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1905:	eb 12                	jmp    1919 <printf+0x200>
    1907:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    190e:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1912:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1919:	8b 10                	mov    (%rax),%edx
    191b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1921:	89 d6                	mov    %edx,%esi
    1923:	89 c7                	mov    %eax,%edi
    1925:	48 b8 21 16 00 00 00 	movabs $0x1621,%rax
    192c:	00 00 00 
    192f:	ff d0                	call   *%rax
      break;
    1931:	e9 b5 01 00 00       	jmp    1aeb <printf+0x3d2>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    1936:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    193c:	83 f8 2f             	cmp    $0x2f,%eax
    193f:	77 23                	ja     1964 <printf+0x24b>
    1941:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1948:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    194e:	89 d2                	mov    %edx,%edx
    1950:	48 01 d0             	add    %rdx,%rax
    1953:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1959:	83 c2 08             	add    $0x8,%edx
    195c:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1962:	eb 12                	jmp    1976 <printf+0x25d>
    1964:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    196b:	48 8d 50 08          	lea    0x8(%rax),%rdx
    196f:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1976:	8b 10                	mov    (%rax),%edx
    1978:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    197e:	89 d6                	mov    %edx,%esi
    1980:	89 c7                	mov    %eax,%edi
    1982:	48 b8 c4 15 00 00 00 	movabs $0x15c4,%rax
    1989:	00 00 00 
    198c:	ff d0                	call   *%rax
      break;
    198e:	e9 58 01 00 00       	jmp    1aeb <printf+0x3d2>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    1993:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1999:	83 f8 2f             	cmp    $0x2f,%eax
    199c:	77 23                	ja     19c1 <printf+0x2a8>
    199e:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    19a5:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19ab:	89 d2                	mov    %edx,%edx
    19ad:	48 01 d0             	add    %rdx,%rax
    19b0:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19b6:	83 c2 08             	add    $0x8,%edx
    19b9:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    19bf:	eb 12                	jmp    19d3 <printf+0x2ba>
    19c1:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    19c8:	48 8d 50 08          	lea    0x8(%rax),%rdx
    19cc:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    19d3:	48 8b 10             	mov    (%rax),%rdx
    19d6:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    19dc:	48 89 d6             	mov    %rdx,%rsi
    19df:	89 c7                	mov    %eax,%edi
    19e1:	48 b8 67 15 00 00 00 	movabs $0x1567,%rax
    19e8:	00 00 00 
    19eb:	ff d0                	call   *%rax
      break;
    19ed:	e9 f9 00 00 00       	jmp    1aeb <printf+0x3d2>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    19f2:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    19f8:	83 f8 2f             	cmp    $0x2f,%eax
    19fb:	77 23                	ja     1a20 <printf+0x307>
    19fd:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1a04:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a0a:	89 d2                	mov    %edx,%edx
    1a0c:	48 01 d0             	add    %rdx,%rax
    1a0f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a15:	83 c2 08             	add    $0x8,%edx
    1a18:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1a1e:	eb 12                	jmp    1a32 <printf+0x319>
    1a20:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a27:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a2b:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a32:	48 8b 00             	mov    (%rax),%rax
    1a35:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    1a3c:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1a43:	00 
    1a44:	75 41                	jne    1a87 <printf+0x36e>
        s = "(null)";
    1a46:	48 b8 50 1e 00 00 00 	movabs $0x1e50,%rax
    1a4d:	00 00 00 
    1a50:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1a57:	eb 2e                	jmp    1a87 <printf+0x36e>
        putc(fd, *(s++));
    1a59:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1a60:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1a64:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1a6b:	0f b6 00             	movzbl (%rax),%eax
    1a6e:	0f be d0             	movsbl %al,%edx
    1a71:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a77:	89 d6                	mov    %edx,%esi
    1a79:	89 c7                	mov    %eax,%edi
    1a7b:	48 b8 33 15 00 00 00 	movabs $0x1533,%rax
    1a82:	00 00 00 
    1a85:	ff d0                	call   *%rax
      while (*s)
    1a87:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1a8e:	0f b6 00             	movzbl (%rax),%eax
    1a91:	84 c0                	test   %al,%al
    1a93:	75 c4                	jne    1a59 <printf+0x340>
      break;
    1a95:	eb 54                	jmp    1aeb <printf+0x3d2>
    case '%':
      putc(fd, '%');
    1a97:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a9d:	be 25 00 00 00       	mov    $0x25,%esi
    1aa2:	89 c7                	mov    %eax,%edi
    1aa4:	48 b8 33 15 00 00 00 	movabs $0x1533,%rax
    1aab:	00 00 00 
    1aae:	ff d0                	call   *%rax
      break;
    1ab0:	eb 39                	jmp    1aeb <printf+0x3d2>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1ab2:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1ab8:	be 25 00 00 00       	mov    $0x25,%esi
    1abd:	89 c7                	mov    %eax,%edi
    1abf:	48 b8 33 15 00 00 00 	movabs $0x1533,%rax
    1ac6:	00 00 00 
    1ac9:	ff d0                	call   *%rax
      putc(fd, c);
    1acb:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1ad1:	0f be d0             	movsbl %al,%edx
    1ad4:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1ada:	89 d6                	mov    %edx,%esi
    1adc:	89 c7                	mov    %eax,%edi
    1ade:	48 b8 33 15 00 00 00 	movabs $0x1533,%rax
    1ae5:	00 00 00 
    1ae8:	ff d0                	call   *%rax
      break;
    1aea:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1aeb:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1af2:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1af8:	48 63 d0             	movslq %eax,%rdx
    1afb:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1b02:	48 01 d0             	add    %rdx,%rax
    1b05:	0f b6 00             	movzbl (%rax),%eax
    1b08:	0f be c0             	movsbl %al,%eax
    1b0b:	25 ff 00 00 00       	and    $0xff,%eax
    1b10:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1b16:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1b1d:	0f 85 8e fc ff ff    	jne    17b1 <printf+0x98>
    }
  }
}
    1b23:	eb 01                	jmp    1b26 <printf+0x40d>
      break;
    1b25:	90                   	nop
}
    1b26:	90                   	nop
    1b27:	c9                   	leave
    1b28:	c3                   	ret

0000000000001b29 <free>:
    1b29:	55                   	push   %rbp
    1b2a:	48 89 e5             	mov    %rsp,%rbp
    1b2d:	48 83 ec 18          	sub    $0x18,%rsp
    1b31:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1b35:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1b39:	48 83 e8 10          	sub    $0x10,%rax
    1b3d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1b41:	48 b8 40 1f 00 00 00 	movabs $0x1f40,%rax
    1b48:	00 00 00 
    1b4b:	48 8b 00             	mov    (%rax),%rax
    1b4e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1b52:	eb 2f                	jmp    1b83 <free+0x5a>
    1b54:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b58:	48 8b 00             	mov    (%rax),%rax
    1b5b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b5f:	72 17                	jb     1b78 <free+0x4f>
    1b61:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b65:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b69:	72 2f                	jb     1b9a <free+0x71>
    1b6b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b6f:	48 8b 00             	mov    (%rax),%rax
    1b72:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1b76:	72 22                	jb     1b9a <free+0x71>
    1b78:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b7c:	48 8b 00             	mov    (%rax),%rax
    1b7f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1b83:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b87:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b8b:	73 c7                	jae    1b54 <free+0x2b>
    1b8d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b91:	48 8b 00             	mov    (%rax),%rax
    1b94:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1b98:	73 ba                	jae    1b54 <free+0x2b>
    1b9a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b9e:	8b 40 08             	mov    0x8(%rax),%eax
    1ba1:	89 c0                	mov    %eax,%eax
    1ba3:	48 c1 e0 04          	shl    $0x4,%rax
    1ba7:	48 89 c2             	mov    %rax,%rdx
    1baa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bae:	48 01 c2             	add    %rax,%rdx
    1bb1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bb5:	48 8b 00             	mov    (%rax),%rax
    1bb8:	48 39 c2             	cmp    %rax,%rdx
    1bbb:	75 2d                	jne    1bea <free+0xc1>
    1bbd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bc1:	8b 50 08             	mov    0x8(%rax),%edx
    1bc4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bc8:	48 8b 00             	mov    (%rax),%rax
    1bcb:	8b 40 08             	mov    0x8(%rax),%eax
    1bce:	01 c2                	add    %eax,%edx
    1bd0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bd4:	89 50 08             	mov    %edx,0x8(%rax)
    1bd7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bdb:	48 8b 00             	mov    (%rax),%rax
    1bde:	48 8b 10             	mov    (%rax),%rdx
    1be1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1be5:	48 89 10             	mov    %rdx,(%rax)
    1be8:	eb 0e                	jmp    1bf8 <free+0xcf>
    1bea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bee:	48 8b 10             	mov    (%rax),%rdx
    1bf1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bf5:	48 89 10             	mov    %rdx,(%rax)
    1bf8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bfc:	8b 40 08             	mov    0x8(%rax),%eax
    1bff:	89 c0                	mov    %eax,%eax
    1c01:	48 c1 e0 04          	shl    $0x4,%rax
    1c05:	48 89 c2             	mov    %rax,%rdx
    1c08:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c0c:	48 01 d0             	add    %rdx,%rax
    1c0f:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1c13:	75 27                	jne    1c3c <free+0x113>
    1c15:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c19:	8b 50 08             	mov    0x8(%rax),%edx
    1c1c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c20:	8b 40 08             	mov    0x8(%rax),%eax
    1c23:	01 c2                	add    %eax,%edx
    1c25:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c29:	89 50 08             	mov    %edx,0x8(%rax)
    1c2c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c30:	48 8b 10             	mov    (%rax),%rdx
    1c33:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c37:	48 89 10             	mov    %rdx,(%rax)
    1c3a:	eb 0b                	jmp    1c47 <free+0x11e>
    1c3c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c40:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1c44:	48 89 10             	mov    %rdx,(%rax)
    1c47:	48 ba 40 1f 00 00 00 	movabs $0x1f40,%rdx
    1c4e:	00 00 00 
    1c51:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c55:	48 89 02             	mov    %rax,(%rdx)
    1c58:	90                   	nop
    1c59:	c9                   	leave
    1c5a:	c3                   	ret

0000000000001c5b <morecore>:
    1c5b:	55                   	push   %rbp
    1c5c:	48 89 e5             	mov    %rsp,%rbp
    1c5f:	48 83 ec 20          	sub    $0x20,%rsp
    1c63:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1c66:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1c6d:	77 07                	ja     1c76 <morecore+0x1b>
    1c6f:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
    1c76:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1c79:	48 c1 e0 04          	shl    $0x4,%rax
    1c7d:	48 89 c7             	mov    %rax,%rdi
    1c80:	48 b8 f2 14 00 00 00 	movabs $0x14f2,%rax
    1c87:	00 00 00 
    1c8a:	ff d0                	call   *%rax
    1c8c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1c90:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1c95:	75 07                	jne    1c9e <morecore+0x43>
    1c97:	b8 00 00 00 00       	mov    $0x0,%eax
    1c9c:	eb 36                	jmp    1cd4 <morecore+0x79>
    1c9e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ca2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1ca6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1caa:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1cad:	89 50 08             	mov    %edx,0x8(%rax)
    1cb0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cb4:	48 83 c0 10          	add    $0x10,%rax
    1cb8:	48 89 c7             	mov    %rax,%rdi
    1cbb:	48 b8 29 1b 00 00 00 	movabs $0x1b29,%rax
    1cc2:	00 00 00 
    1cc5:	ff d0                	call   *%rax
    1cc7:	48 b8 40 1f 00 00 00 	movabs $0x1f40,%rax
    1cce:	00 00 00 
    1cd1:	48 8b 00             	mov    (%rax),%rax
    1cd4:	c9                   	leave
    1cd5:	c3                   	ret

0000000000001cd6 <malloc>:
    1cd6:	55                   	push   %rbp
    1cd7:	48 89 e5             	mov    %rsp,%rbp
    1cda:	48 83 ec 30          	sub    $0x30,%rsp
    1cde:	89 7d dc             	mov    %edi,-0x24(%rbp)
    1ce1:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1ce4:	48 83 c0 0f          	add    $0xf,%rax
    1ce8:	48 c1 e8 04          	shr    $0x4,%rax
    1cec:	83 c0 01             	add    $0x1,%eax
    1cef:	89 45 ec             	mov    %eax,-0x14(%rbp)
    1cf2:	48 b8 40 1f 00 00 00 	movabs $0x1f40,%rax
    1cf9:	00 00 00 
    1cfc:	48 8b 00             	mov    (%rax),%rax
    1cff:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1d03:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1d08:	75 4a                	jne    1d54 <malloc+0x7e>
    1d0a:	48 b8 30 1f 00 00 00 	movabs $0x1f30,%rax
    1d11:	00 00 00 
    1d14:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1d18:	48 ba 40 1f 00 00 00 	movabs $0x1f40,%rdx
    1d1f:	00 00 00 
    1d22:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d26:	48 89 02             	mov    %rax,(%rdx)
    1d29:	48 b8 40 1f 00 00 00 	movabs $0x1f40,%rax
    1d30:	00 00 00 
    1d33:	48 8b 00             	mov    (%rax),%rax
    1d36:	48 ba 30 1f 00 00 00 	movabs $0x1f30,%rdx
    1d3d:	00 00 00 
    1d40:	48 89 02             	mov    %rax,(%rdx)
    1d43:	48 b8 30 1f 00 00 00 	movabs $0x1f30,%rax
    1d4a:	00 00 00 
    1d4d:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
    1d54:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d58:	48 8b 00             	mov    (%rax),%rax
    1d5b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1d5f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d63:	8b 40 08             	mov    0x8(%rax),%eax
    1d66:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1d69:	72 65                	jb     1dd0 <malloc+0xfa>
    1d6b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d6f:	8b 40 08             	mov    0x8(%rax),%eax
    1d72:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1d75:	75 10                	jne    1d87 <malloc+0xb1>
    1d77:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d7b:	48 8b 10             	mov    (%rax),%rdx
    1d7e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d82:	48 89 10             	mov    %rdx,(%rax)
    1d85:	eb 2e                	jmp    1db5 <malloc+0xdf>
    1d87:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d8b:	8b 40 08             	mov    0x8(%rax),%eax
    1d8e:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1d91:	89 c2                	mov    %eax,%edx
    1d93:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d97:	89 50 08             	mov    %edx,0x8(%rax)
    1d9a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d9e:	8b 40 08             	mov    0x8(%rax),%eax
    1da1:	89 c0                	mov    %eax,%eax
    1da3:	48 c1 e0 04          	shl    $0x4,%rax
    1da7:	48 01 45 f8          	add    %rax,-0x8(%rbp)
    1dab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1daf:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1db2:	89 50 08             	mov    %edx,0x8(%rax)
    1db5:	48 ba 40 1f 00 00 00 	movabs $0x1f40,%rdx
    1dbc:	00 00 00 
    1dbf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1dc3:	48 89 02             	mov    %rax,(%rdx)
    1dc6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1dca:	48 83 c0 10          	add    $0x10,%rax
    1dce:	eb 4e                	jmp    1e1e <malloc+0x148>
    1dd0:	48 b8 40 1f 00 00 00 	movabs $0x1f40,%rax
    1dd7:	00 00 00 
    1dda:	48 8b 00             	mov    (%rax),%rax
    1ddd:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1de1:	75 23                	jne    1e06 <malloc+0x130>
    1de3:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1de6:	89 c7                	mov    %eax,%edi
    1de8:	48 b8 5b 1c 00 00 00 	movabs $0x1c5b,%rax
    1def:	00 00 00 
    1df2:	ff d0                	call   *%rax
    1df4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1df8:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1dfd:	75 07                	jne    1e06 <malloc+0x130>
    1dff:	b8 00 00 00 00       	mov    $0x0,%eax
    1e04:	eb 18                	jmp    1e1e <malloc+0x148>
    1e06:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e0a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1e0e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e12:	48 8b 00             	mov    (%rax),%rax
    1e15:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1e19:	e9 41 ff ff ff       	jmp    1d5f <malloc+0x89>
    1e1e:	c9                   	leave
    1e1f:	c3                   	ret
