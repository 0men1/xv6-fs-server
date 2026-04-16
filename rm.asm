
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
    1019:	48 b8 40 1e 00 00 00 	movabs $0x1e40,%rax
    1020:	00 00 00 
    1023:	48 89 c6             	mov    %rax,%rsi
    1026:	bf 02 00 00 00       	mov    $0x2,%edi
    102b:	b8 00 00 00 00       	mov    $0x0,%eax
    1030:	48 ba 26 17 00 00 00 	movabs $0x1726,%rdx
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
    1095:	48 b8 54 1e 00 00 00 	movabs $0x1e54,%rax
    109c:	00 00 00 
    109f:	48 89 c6             	mov    %rax,%rsi
    10a2:	bf 02 00 00 00       	mov    $0x2,%edi
    10a7:	b8 00 00 00 00       	mov    $0x0,%eax
    10ac:	48 b9 26 17 00 00 00 	movabs $0x1726,%rcx
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
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    1408:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    140f:	49 89 ca             	mov    %rcx,%r10
    1412:	0f 05                	syscall
    1414:	c3                   	ret

0000000000001415 <exit>:
SYSCALL(exit)
    1415:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    141c:	49 89 ca             	mov    %rcx,%r10
    141f:	0f 05                	syscall
    1421:	c3                   	ret

0000000000001422 <wait>:
SYSCALL(wait)
    1422:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    1429:	49 89 ca             	mov    %rcx,%r10
    142c:	0f 05                	syscall
    142e:	c3                   	ret

000000000000142f <pipe>:
SYSCALL(pipe)
    142f:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    1436:	49 89 ca             	mov    %rcx,%r10
    1439:	0f 05                	syscall
    143b:	c3                   	ret

000000000000143c <read>:
SYSCALL(read)
    143c:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    1443:	49 89 ca             	mov    %rcx,%r10
    1446:	0f 05                	syscall
    1448:	c3                   	ret

0000000000001449 <write>:
SYSCALL(write)
    1449:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    1450:	49 89 ca             	mov    %rcx,%r10
    1453:	0f 05                	syscall
    1455:	c3                   	ret

0000000000001456 <close>:
SYSCALL(close)
    1456:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    145d:	49 89 ca             	mov    %rcx,%r10
    1460:	0f 05                	syscall
    1462:	c3                   	ret

0000000000001463 <kill>:
SYSCALL(kill)
    1463:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    146a:	49 89 ca             	mov    %rcx,%r10
    146d:	0f 05                	syscall
    146f:	c3                   	ret

0000000000001470 <exec>:
SYSCALL(exec)
    1470:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    1477:	49 89 ca             	mov    %rcx,%r10
    147a:	0f 05                	syscall
    147c:	c3                   	ret

000000000000147d <open>:
SYSCALL(open)
    147d:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    1484:	49 89 ca             	mov    %rcx,%r10
    1487:	0f 05                	syscall
    1489:	c3                   	ret

000000000000148a <mknod>:
SYSCALL(mknod)
    148a:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    1491:	49 89 ca             	mov    %rcx,%r10
    1494:	0f 05                	syscall
    1496:	c3                   	ret

0000000000001497 <unlink>:
SYSCALL(unlink)
    1497:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    149e:	49 89 ca             	mov    %rcx,%r10
    14a1:	0f 05                	syscall
    14a3:	c3                   	ret

00000000000014a4 <fstat>:
SYSCALL(fstat)
    14a4:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    14ab:	49 89 ca             	mov    %rcx,%r10
    14ae:	0f 05                	syscall
    14b0:	c3                   	ret

00000000000014b1 <link>:
SYSCALL(link)
    14b1:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    14b8:	49 89 ca             	mov    %rcx,%r10
    14bb:	0f 05                	syscall
    14bd:	c3                   	ret

00000000000014be <mkdir>:
SYSCALL(mkdir)
    14be:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    14c5:	49 89 ca             	mov    %rcx,%r10
    14c8:	0f 05                	syscall
    14ca:	c3                   	ret

00000000000014cb <chdir>:
SYSCALL(chdir)
    14cb:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    14d2:	49 89 ca             	mov    %rcx,%r10
    14d5:	0f 05                	syscall
    14d7:	c3                   	ret

00000000000014d8 <dup>:
SYSCALL(dup)
    14d8:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    14df:	49 89 ca             	mov    %rcx,%r10
    14e2:	0f 05                	syscall
    14e4:	c3                   	ret

00000000000014e5 <getpid>:
SYSCALL(getpid)
    14e5:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    14ec:	49 89 ca             	mov    %rcx,%r10
    14ef:	0f 05                	syscall
    14f1:	c3                   	ret

00000000000014f2 <sbrk>:
SYSCALL(sbrk)
    14f2:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    14f9:	49 89 ca             	mov    %rcx,%r10
    14fc:	0f 05                	syscall
    14fe:	c3                   	ret

00000000000014ff <sleep>:
SYSCALL(sleep)
    14ff:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    1506:	49 89 ca             	mov    %rcx,%r10
    1509:	0f 05                	syscall
    150b:	c3                   	ret

000000000000150c <uptime>:
SYSCALL(uptime)
    150c:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    1513:	49 89 ca             	mov    %rcx,%r10
    1516:	0f 05                	syscall
    1518:	c3                   	ret

0000000000001519 <send>:
SYSCALL(send)
    1519:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    1520:	49 89 ca             	mov    %rcx,%r10
    1523:	0f 05                	syscall
    1525:	c3                   	ret

0000000000001526 <recv>:
SYSCALL(recv)
    1526:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    152d:	49 89 ca             	mov    %rcx,%r10
    1530:	0f 05                	syscall
    1532:	c3                   	ret

0000000000001533 <register_fsserver>:
SYSCALL(register_fsserver)
    1533:	48 c7 c0 18 00 00 00 	mov    $0x18,%rax
    153a:	49 89 ca             	mov    %rcx,%r10
    153d:	0f 05                	syscall
    153f:	c3                   	ret

0000000000001540 <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    1540:	f3 0f 1e fa          	endbr64
    1544:	55                   	push   %rbp
    1545:	48 89 e5             	mov    %rsp,%rbp
    1548:	48 83 ec 10          	sub    $0x10,%rsp
    154c:	89 7d fc             	mov    %edi,-0x4(%rbp)
    154f:	89 f0                	mov    %esi,%eax
    1551:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    1554:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    1558:	8b 45 fc             	mov    -0x4(%rbp),%eax
    155b:	ba 01 00 00 00       	mov    $0x1,%edx
    1560:	48 89 ce             	mov    %rcx,%rsi
    1563:	89 c7                	mov    %eax,%edi
    1565:	48 b8 49 14 00 00 00 	movabs $0x1449,%rax
    156c:	00 00 00 
    156f:	ff d0                	call   *%rax
}
    1571:	90                   	nop
    1572:	c9                   	leave
    1573:	c3                   	ret

0000000000001574 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    1574:	f3 0f 1e fa          	endbr64
    1578:	55                   	push   %rbp
    1579:	48 89 e5             	mov    %rsp,%rbp
    157c:	48 83 ec 20          	sub    $0x20,%rsp
    1580:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1583:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1587:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    158e:	eb 35                	jmp    15c5 <print_x64+0x51>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    1590:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1594:	48 c1 e8 3c          	shr    $0x3c,%rax
    1598:	48 ba 30 1f 00 00 00 	movabs $0x1f30,%rdx
    159f:	00 00 00 
    15a2:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    15a6:	0f be d0             	movsbl %al,%edx
    15a9:	8b 45 ec             	mov    -0x14(%rbp),%eax
    15ac:	89 d6                	mov    %edx,%esi
    15ae:	89 c7                	mov    %eax,%edi
    15b0:	48 b8 40 15 00 00 00 	movabs $0x1540,%rax
    15b7:	00 00 00 
    15ba:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    15bc:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    15c0:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    15c5:	8b 45 fc             	mov    -0x4(%rbp),%eax
    15c8:	83 f8 0f             	cmp    $0xf,%eax
    15cb:	76 c3                	jbe    1590 <print_x64+0x1c>
}
    15cd:	90                   	nop
    15ce:	90                   	nop
    15cf:	c9                   	leave
    15d0:	c3                   	ret

00000000000015d1 <print_x32>:

  static void
print_x32(int fd, uint x)
{
    15d1:	f3 0f 1e fa          	endbr64
    15d5:	55                   	push   %rbp
    15d6:	48 89 e5             	mov    %rsp,%rbp
    15d9:	48 83 ec 20          	sub    $0x20,%rsp
    15dd:	89 7d ec             	mov    %edi,-0x14(%rbp)
    15e0:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    15e3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    15ea:	eb 36                	jmp    1622 <print_x32+0x51>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    15ec:	8b 45 e8             	mov    -0x18(%rbp),%eax
    15ef:	c1 e8 1c             	shr    $0x1c,%eax
    15f2:	89 c2                	mov    %eax,%edx
    15f4:	48 b8 30 1f 00 00 00 	movabs $0x1f30,%rax
    15fb:	00 00 00 
    15fe:	89 d2                	mov    %edx,%edx
    1600:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    1604:	0f be d0             	movsbl %al,%edx
    1607:	8b 45 ec             	mov    -0x14(%rbp),%eax
    160a:	89 d6                	mov    %edx,%esi
    160c:	89 c7                	mov    %eax,%edi
    160e:	48 b8 40 15 00 00 00 	movabs $0x1540,%rax
    1615:	00 00 00 
    1618:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    161a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    161e:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    1622:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1625:	83 f8 07             	cmp    $0x7,%eax
    1628:	76 c2                	jbe    15ec <print_x32+0x1b>
}
    162a:	90                   	nop
    162b:	90                   	nop
    162c:	c9                   	leave
    162d:	c3                   	ret

000000000000162e <print_d>:

  static void
print_d(int fd, int v)
{
    162e:	f3 0f 1e fa          	endbr64
    1632:	55                   	push   %rbp
    1633:	48 89 e5             	mov    %rsp,%rbp
    1636:	48 83 ec 30          	sub    $0x30,%rsp
    163a:	89 7d dc             	mov    %edi,-0x24(%rbp)
    163d:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    1640:	8b 45 d8             	mov    -0x28(%rbp),%eax
    1643:	48 98                	cltq
    1645:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    1649:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    164d:	79 04                	jns    1653 <print_d+0x25>
    x = -x;
    164f:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    1653:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    165a:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    165e:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1665:	66 66 66 
    1668:	48 89 c8             	mov    %rcx,%rax
    166b:	48 f7 ea             	imul   %rdx
    166e:	48 c1 fa 02          	sar    $0x2,%rdx
    1672:	48 89 c8             	mov    %rcx,%rax
    1675:	48 c1 f8 3f          	sar    $0x3f,%rax
    1679:	48 29 c2             	sub    %rax,%rdx
    167c:	48 89 d0             	mov    %rdx,%rax
    167f:	48 c1 e0 02          	shl    $0x2,%rax
    1683:	48 01 d0             	add    %rdx,%rax
    1686:	48 01 c0             	add    %rax,%rax
    1689:	48 29 c1             	sub    %rax,%rcx
    168c:	48 89 ca             	mov    %rcx,%rdx
    168f:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1692:	8d 48 01             	lea    0x1(%rax),%ecx
    1695:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    1698:	48 b9 30 1f 00 00 00 	movabs $0x1f30,%rcx
    169f:	00 00 00 
    16a2:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    16a6:	48 98                	cltq
    16a8:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    16ac:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    16b0:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    16b7:	66 66 66 
    16ba:	48 89 c8             	mov    %rcx,%rax
    16bd:	48 f7 ea             	imul   %rdx
    16c0:	48 89 d0             	mov    %rdx,%rax
    16c3:	48 c1 f8 02          	sar    $0x2,%rax
    16c7:	48 c1 f9 3f          	sar    $0x3f,%rcx
    16cb:	48 89 ca             	mov    %rcx,%rdx
    16ce:	48 29 d0             	sub    %rdx,%rax
    16d1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    16d5:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    16da:	0f 85 7a ff ff ff    	jne    165a <print_d+0x2c>

  if (v < 0)
    16e0:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    16e4:	79 32                	jns    1718 <print_d+0xea>
    buf[i++] = '-';
    16e6:	8b 45 f4             	mov    -0xc(%rbp),%eax
    16e9:	8d 50 01             	lea    0x1(%rax),%edx
    16ec:	89 55 f4             	mov    %edx,-0xc(%rbp)
    16ef:	48 98                	cltq
    16f1:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    16f6:	eb 20                	jmp    1718 <print_d+0xea>
    putc(fd, buf[i]);
    16f8:	8b 45 f4             	mov    -0xc(%rbp),%eax
    16fb:	48 98                	cltq
    16fd:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    1702:	0f be d0             	movsbl %al,%edx
    1705:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1708:	89 d6                	mov    %edx,%esi
    170a:	89 c7                	mov    %eax,%edi
    170c:	48 b8 40 15 00 00 00 	movabs $0x1540,%rax
    1713:	00 00 00 
    1716:	ff d0                	call   *%rax
  while (--i >= 0)
    1718:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    171c:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1720:	79 d6                	jns    16f8 <print_d+0xca>
}
    1722:	90                   	nop
    1723:	90                   	nop
    1724:	c9                   	leave
    1725:	c3                   	ret

0000000000001726 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    1726:	f3 0f 1e fa          	endbr64
    172a:	55                   	push   %rbp
    172b:	48 89 e5             	mov    %rsp,%rbp
    172e:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    1735:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    173b:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    1742:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    1749:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    1750:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    1757:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    175e:	84 c0                	test   %al,%al
    1760:	74 20                	je     1782 <printf+0x5c>
    1762:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    1766:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    176a:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    176e:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    1772:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    1776:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    177a:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    177e:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    1782:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    1789:	00 00 00 
    178c:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    1793:	00 00 00 
    1796:	48 8d 45 10          	lea    0x10(%rbp),%rax
    179a:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    17a1:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    17a8:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    17af:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    17b6:	00 00 00 
    17b9:	e9 41 03 00 00       	jmp    1aff <printf+0x3d9>
    if (c != '%') {
    17be:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    17c5:	74 24                	je     17eb <printf+0xc5>
      putc(fd, c);
    17c7:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    17cd:	0f be d0             	movsbl %al,%edx
    17d0:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    17d6:	89 d6                	mov    %edx,%esi
    17d8:	89 c7                	mov    %eax,%edi
    17da:	48 b8 40 15 00 00 00 	movabs $0x1540,%rax
    17e1:	00 00 00 
    17e4:	ff d0                	call   *%rax
      continue;
    17e6:	e9 0d 03 00 00       	jmp    1af8 <printf+0x3d2>
    }
    c = fmt[++i] & 0xff;
    17eb:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    17f2:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    17f8:	48 63 d0             	movslq %eax,%rdx
    17fb:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1802:	48 01 d0             	add    %rdx,%rax
    1805:	0f b6 00             	movzbl (%rax),%eax
    1808:	0f be c0             	movsbl %al,%eax
    180b:	25 ff 00 00 00       	and    $0xff,%eax
    1810:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    1816:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    181d:	0f 84 0f 03 00 00    	je     1b32 <printf+0x40c>
      break;
    switch(c) {
    1823:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    182a:	0f 84 74 02 00 00    	je     1aa4 <printf+0x37e>
    1830:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1837:	0f 8c 82 02 00 00    	jl     1abf <printf+0x399>
    183d:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    1844:	0f 8f 75 02 00 00    	jg     1abf <printf+0x399>
    184a:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    1851:	0f 8c 68 02 00 00    	jl     1abf <printf+0x399>
    1857:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    185d:	83 e8 63             	sub    $0x63,%eax
    1860:	83 f8 15             	cmp    $0x15,%eax
    1863:	0f 87 56 02 00 00    	ja     1abf <printf+0x399>
    1869:	89 c0                	mov    %eax,%eax
    186b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1872:	00 
    1873:	48 b8 78 1e 00 00 00 	movabs $0x1e78,%rax
    187a:	00 00 00 
    187d:	48 01 d0             	add    %rdx,%rax
    1880:	48 8b 00             	mov    (%rax),%rax
    1883:	3e ff e0             	notrack jmp *%rax
    case 'c':
      putc(fd, va_arg(ap, int));
    1886:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    188c:	83 f8 2f             	cmp    $0x2f,%eax
    188f:	77 23                	ja     18b4 <printf+0x18e>
    1891:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1898:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    189e:	89 d2                	mov    %edx,%edx
    18a0:	48 01 d0             	add    %rdx,%rax
    18a3:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18a9:	83 c2 08             	add    $0x8,%edx
    18ac:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    18b2:	eb 12                	jmp    18c6 <printf+0x1a0>
    18b4:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    18bb:	48 8d 50 08          	lea    0x8(%rax),%rdx
    18bf:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    18c6:	8b 00                	mov    (%rax),%eax
    18c8:	0f be d0             	movsbl %al,%edx
    18cb:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    18d1:	89 d6                	mov    %edx,%esi
    18d3:	89 c7                	mov    %eax,%edi
    18d5:	48 b8 40 15 00 00 00 	movabs $0x1540,%rax
    18dc:	00 00 00 
    18df:	ff d0                	call   *%rax
      break;
    18e1:	e9 12 02 00 00       	jmp    1af8 <printf+0x3d2>
    case 'd':
      print_d(fd, va_arg(ap, int));
    18e6:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    18ec:	83 f8 2f             	cmp    $0x2f,%eax
    18ef:	77 23                	ja     1914 <printf+0x1ee>
    18f1:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    18f8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18fe:	89 d2                	mov    %edx,%edx
    1900:	48 01 d0             	add    %rdx,%rax
    1903:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1909:	83 c2 08             	add    $0x8,%edx
    190c:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1912:	eb 12                	jmp    1926 <printf+0x200>
    1914:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    191b:	48 8d 50 08          	lea    0x8(%rax),%rdx
    191f:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1926:	8b 10                	mov    (%rax),%edx
    1928:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    192e:	89 d6                	mov    %edx,%esi
    1930:	89 c7                	mov    %eax,%edi
    1932:	48 b8 2e 16 00 00 00 	movabs $0x162e,%rax
    1939:	00 00 00 
    193c:	ff d0                	call   *%rax
      break;
    193e:	e9 b5 01 00 00       	jmp    1af8 <printf+0x3d2>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    1943:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1949:	83 f8 2f             	cmp    $0x2f,%eax
    194c:	77 23                	ja     1971 <printf+0x24b>
    194e:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1955:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    195b:	89 d2                	mov    %edx,%edx
    195d:	48 01 d0             	add    %rdx,%rax
    1960:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1966:	83 c2 08             	add    $0x8,%edx
    1969:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    196f:	eb 12                	jmp    1983 <printf+0x25d>
    1971:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1978:	48 8d 50 08          	lea    0x8(%rax),%rdx
    197c:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1983:	8b 10                	mov    (%rax),%edx
    1985:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    198b:	89 d6                	mov    %edx,%esi
    198d:	89 c7                	mov    %eax,%edi
    198f:	48 b8 d1 15 00 00 00 	movabs $0x15d1,%rax
    1996:	00 00 00 
    1999:	ff d0                	call   *%rax
      break;
    199b:	e9 58 01 00 00       	jmp    1af8 <printf+0x3d2>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    19a0:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    19a6:	83 f8 2f             	cmp    $0x2f,%eax
    19a9:	77 23                	ja     19ce <printf+0x2a8>
    19ab:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    19b2:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19b8:	89 d2                	mov    %edx,%edx
    19ba:	48 01 d0             	add    %rdx,%rax
    19bd:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19c3:	83 c2 08             	add    $0x8,%edx
    19c6:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    19cc:	eb 12                	jmp    19e0 <printf+0x2ba>
    19ce:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    19d5:	48 8d 50 08          	lea    0x8(%rax),%rdx
    19d9:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    19e0:	48 8b 10             	mov    (%rax),%rdx
    19e3:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    19e9:	48 89 d6             	mov    %rdx,%rsi
    19ec:	89 c7                	mov    %eax,%edi
    19ee:	48 b8 74 15 00 00 00 	movabs $0x1574,%rax
    19f5:	00 00 00 
    19f8:	ff d0                	call   *%rax
      break;
    19fa:	e9 f9 00 00 00       	jmp    1af8 <printf+0x3d2>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    19ff:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1a05:	83 f8 2f             	cmp    $0x2f,%eax
    1a08:	77 23                	ja     1a2d <printf+0x307>
    1a0a:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1a11:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a17:	89 d2                	mov    %edx,%edx
    1a19:	48 01 d0             	add    %rdx,%rax
    1a1c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a22:	83 c2 08             	add    $0x8,%edx
    1a25:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1a2b:	eb 12                	jmp    1a3f <printf+0x319>
    1a2d:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a34:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a38:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a3f:	48 8b 00             	mov    (%rax),%rax
    1a42:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    1a49:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1a50:	00 
    1a51:	75 41                	jne    1a94 <printf+0x36e>
        s = "(null)";
    1a53:	48 b8 70 1e 00 00 00 	movabs $0x1e70,%rax
    1a5a:	00 00 00 
    1a5d:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1a64:	eb 2e                	jmp    1a94 <printf+0x36e>
        putc(fd, *(s++));
    1a66:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1a6d:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1a71:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1a78:	0f b6 00             	movzbl (%rax),%eax
    1a7b:	0f be d0             	movsbl %al,%edx
    1a7e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a84:	89 d6                	mov    %edx,%esi
    1a86:	89 c7                	mov    %eax,%edi
    1a88:	48 b8 40 15 00 00 00 	movabs $0x1540,%rax
    1a8f:	00 00 00 
    1a92:	ff d0                	call   *%rax
      while (*s)
    1a94:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1a9b:	0f b6 00             	movzbl (%rax),%eax
    1a9e:	84 c0                	test   %al,%al
    1aa0:	75 c4                	jne    1a66 <printf+0x340>
      break;
    1aa2:	eb 54                	jmp    1af8 <printf+0x3d2>
    case '%':
      putc(fd, '%');
    1aa4:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1aaa:	be 25 00 00 00       	mov    $0x25,%esi
    1aaf:	89 c7                	mov    %eax,%edi
    1ab1:	48 b8 40 15 00 00 00 	movabs $0x1540,%rax
    1ab8:	00 00 00 
    1abb:	ff d0                	call   *%rax
      break;
    1abd:	eb 39                	jmp    1af8 <printf+0x3d2>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1abf:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1ac5:	be 25 00 00 00       	mov    $0x25,%esi
    1aca:	89 c7                	mov    %eax,%edi
    1acc:	48 b8 40 15 00 00 00 	movabs $0x1540,%rax
    1ad3:	00 00 00 
    1ad6:	ff d0                	call   *%rax
      putc(fd, c);
    1ad8:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1ade:	0f be d0             	movsbl %al,%edx
    1ae1:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1ae7:	89 d6                	mov    %edx,%esi
    1ae9:	89 c7                	mov    %eax,%edi
    1aeb:	48 b8 40 15 00 00 00 	movabs $0x1540,%rax
    1af2:	00 00 00 
    1af5:	ff d0                	call   *%rax
      break;
    1af7:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1af8:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1aff:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1b05:	48 63 d0             	movslq %eax,%rdx
    1b08:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1b0f:	48 01 d0             	add    %rdx,%rax
    1b12:	0f b6 00             	movzbl (%rax),%eax
    1b15:	0f be c0             	movsbl %al,%eax
    1b18:	25 ff 00 00 00       	and    $0xff,%eax
    1b1d:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1b23:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1b2a:	0f 85 8e fc ff ff    	jne    17be <printf+0x98>
    }
  }
}
    1b30:	eb 01                	jmp    1b33 <printf+0x40d>
      break;
    1b32:	90                   	nop
}
    1b33:	90                   	nop
    1b34:	c9                   	leave
    1b35:	c3                   	ret

0000000000001b36 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1b36:	f3 0f 1e fa          	endbr64
    1b3a:	55                   	push   %rbp
    1b3b:	48 89 e5             	mov    %rsp,%rbp
    1b3e:	48 83 ec 18          	sub    $0x18,%rsp
    1b42:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1b46:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1b4a:	48 83 e8 10          	sub    $0x10,%rax
    1b4e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1b52:	48 b8 60 1f 00 00 00 	movabs $0x1f60,%rax
    1b59:	00 00 00 
    1b5c:	48 8b 00             	mov    (%rax),%rax
    1b5f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1b63:	eb 2f                	jmp    1b94 <free+0x5e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1b65:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b69:	48 8b 00             	mov    (%rax),%rax
    1b6c:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b70:	72 17                	jb     1b89 <free+0x53>
    1b72:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b76:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b7a:	72 2f                	jb     1bab <free+0x75>
    1b7c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b80:	48 8b 00             	mov    (%rax),%rax
    1b83:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1b87:	72 22                	jb     1bab <free+0x75>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1b89:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b8d:	48 8b 00             	mov    (%rax),%rax
    1b90:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1b94:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b98:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b9c:	73 c7                	jae    1b65 <free+0x2f>
    1b9e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ba2:	48 8b 00             	mov    (%rax),%rax
    1ba5:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1ba9:	73 ba                	jae    1b65 <free+0x2f>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1bab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1baf:	8b 40 08             	mov    0x8(%rax),%eax
    1bb2:	89 c0                	mov    %eax,%eax
    1bb4:	48 c1 e0 04          	shl    $0x4,%rax
    1bb8:	48 89 c2             	mov    %rax,%rdx
    1bbb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bbf:	48 01 c2             	add    %rax,%rdx
    1bc2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bc6:	48 8b 00             	mov    (%rax),%rax
    1bc9:	48 39 c2             	cmp    %rax,%rdx
    1bcc:	75 2d                	jne    1bfb <free+0xc5>
    bp->s.size += p->s.ptr->s.size;
    1bce:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bd2:	8b 50 08             	mov    0x8(%rax),%edx
    1bd5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bd9:	48 8b 00             	mov    (%rax),%rax
    1bdc:	8b 40 08             	mov    0x8(%rax),%eax
    1bdf:	01 c2                	add    %eax,%edx
    1be1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1be5:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1be8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bec:	48 8b 00             	mov    (%rax),%rax
    1bef:	48 8b 10             	mov    (%rax),%rdx
    1bf2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bf6:	48 89 10             	mov    %rdx,(%rax)
    1bf9:	eb 0e                	jmp    1c09 <free+0xd3>
  } else
    bp->s.ptr = p->s.ptr;
    1bfb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bff:	48 8b 10             	mov    (%rax),%rdx
    1c02:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c06:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    1c09:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c0d:	8b 40 08             	mov    0x8(%rax),%eax
    1c10:	89 c0                	mov    %eax,%eax
    1c12:	48 c1 e0 04          	shl    $0x4,%rax
    1c16:	48 89 c2             	mov    %rax,%rdx
    1c19:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c1d:	48 01 d0             	add    %rdx,%rax
    1c20:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1c24:	75 27                	jne    1c4d <free+0x117>
    p->s.size += bp->s.size;
    1c26:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c2a:	8b 50 08             	mov    0x8(%rax),%edx
    1c2d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c31:	8b 40 08             	mov    0x8(%rax),%eax
    1c34:	01 c2                	add    %eax,%edx
    1c36:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c3a:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    1c3d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c41:	48 8b 10             	mov    (%rax),%rdx
    1c44:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c48:	48 89 10             	mov    %rdx,(%rax)
    1c4b:	eb 0b                	jmp    1c58 <free+0x122>
  } else
    p->s.ptr = bp;
    1c4d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c51:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1c55:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    1c58:	48 ba 60 1f 00 00 00 	movabs $0x1f60,%rdx
    1c5f:	00 00 00 
    1c62:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c66:	48 89 02             	mov    %rax,(%rdx)
}
    1c69:	90                   	nop
    1c6a:	c9                   	leave
    1c6b:	c3                   	ret

0000000000001c6c <morecore>:

static Header*
morecore(uint nu)
{
    1c6c:	f3 0f 1e fa          	endbr64
    1c70:	55                   	push   %rbp
    1c71:	48 89 e5             	mov    %rsp,%rbp
    1c74:	48 83 ec 20          	sub    $0x20,%rsp
    1c78:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    1c7b:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1c82:	77 07                	ja     1c8b <morecore+0x1f>
    nu = 4096;
    1c84:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    1c8b:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1c8e:	48 c1 e0 04          	shl    $0x4,%rax
    1c92:	48 89 c7             	mov    %rax,%rdi
    1c95:	48 b8 f2 14 00 00 00 	movabs $0x14f2,%rax
    1c9c:	00 00 00 
    1c9f:	ff d0                	call   *%rax
    1ca1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    1ca5:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1caa:	75 07                	jne    1cb3 <morecore+0x47>
    return 0;
    1cac:	b8 00 00 00 00       	mov    $0x0,%eax
    1cb1:	eb 36                	jmp    1ce9 <morecore+0x7d>
  hp = (Header*)p;
    1cb3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cb7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    1cbb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cbf:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1cc2:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    1cc5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cc9:	48 83 c0 10          	add    $0x10,%rax
    1ccd:	48 89 c7             	mov    %rax,%rdi
    1cd0:	48 b8 36 1b 00 00 00 	movabs $0x1b36,%rax
    1cd7:	00 00 00 
    1cda:	ff d0                	call   *%rax
  return freep;
    1cdc:	48 b8 60 1f 00 00 00 	movabs $0x1f60,%rax
    1ce3:	00 00 00 
    1ce6:	48 8b 00             	mov    (%rax),%rax
}
    1ce9:	c9                   	leave
    1cea:	c3                   	ret

0000000000001ceb <malloc>:

void*
malloc(uint nbytes)
{
    1ceb:	f3 0f 1e fa          	endbr64
    1cef:	55                   	push   %rbp
    1cf0:	48 89 e5             	mov    %rsp,%rbp
    1cf3:	48 83 ec 30          	sub    $0x30,%rsp
    1cf7:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1cfa:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1cfd:	48 83 c0 0f          	add    $0xf,%rax
    1d01:	48 c1 e8 04          	shr    $0x4,%rax
    1d05:	83 c0 01             	add    $0x1,%eax
    1d08:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    1d0b:	48 b8 60 1f 00 00 00 	movabs $0x1f60,%rax
    1d12:	00 00 00 
    1d15:	48 8b 00             	mov    (%rax),%rax
    1d18:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1d1c:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1d21:	75 4a                	jne    1d6d <malloc+0x82>
    base.s.ptr = freep = prevp = &base;
    1d23:	48 b8 50 1f 00 00 00 	movabs $0x1f50,%rax
    1d2a:	00 00 00 
    1d2d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1d31:	48 ba 60 1f 00 00 00 	movabs $0x1f60,%rdx
    1d38:	00 00 00 
    1d3b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d3f:	48 89 02             	mov    %rax,(%rdx)
    1d42:	48 b8 60 1f 00 00 00 	movabs $0x1f60,%rax
    1d49:	00 00 00 
    1d4c:	48 8b 00             	mov    (%rax),%rax
    1d4f:	48 ba 50 1f 00 00 00 	movabs $0x1f50,%rdx
    1d56:	00 00 00 
    1d59:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    1d5c:	48 b8 50 1f 00 00 00 	movabs $0x1f50,%rax
    1d63:	00 00 00 
    1d66:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1d6d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d71:	48 8b 00             	mov    (%rax),%rax
    1d74:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1d78:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d7c:	8b 40 08             	mov    0x8(%rax),%eax
    1d7f:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1d82:	72 65                	jb     1de9 <malloc+0xfe>
      if(p->s.size == nunits)
    1d84:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d88:	8b 40 08             	mov    0x8(%rax),%eax
    1d8b:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1d8e:	75 10                	jne    1da0 <malloc+0xb5>
        prevp->s.ptr = p->s.ptr;
    1d90:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d94:	48 8b 10             	mov    (%rax),%rdx
    1d97:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d9b:	48 89 10             	mov    %rdx,(%rax)
    1d9e:	eb 2e                	jmp    1dce <malloc+0xe3>
      else {
        p->s.size -= nunits;
    1da0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1da4:	8b 40 08             	mov    0x8(%rax),%eax
    1da7:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1daa:	89 c2                	mov    %eax,%edx
    1dac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1db0:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    1db3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1db7:	8b 40 08             	mov    0x8(%rax),%eax
    1dba:	89 c0                	mov    %eax,%eax
    1dbc:	48 c1 e0 04          	shl    $0x4,%rax
    1dc0:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    1dc4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1dc8:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1dcb:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    1dce:	48 ba 60 1f 00 00 00 	movabs $0x1f60,%rdx
    1dd5:	00 00 00 
    1dd8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ddc:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    1ddf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1de3:	48 83 c0 10          	add    $0x10,%rax
    1de7:	eb 4e                	jmp    1e37 <malloc+0x14c>
    }
    if(p == freep)
    1de9:	48 b8 60 1f 00 00 00 	movabs $0x1f60,%rax
    1df0:	00 00 00 
    1df3:	48 8b 00             	mov    (%rax),%rax
    1df6:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1dfa:	75 23                	jne    1e1f <malloc+0x134>
      if((p = morecore(nunits)) == 0)
    1dfc:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1dff:	89 c7                	mov    %eax,%edi
    1e01:	48 b8 6c 1c 00 00 00 	movabs $0x1c6c,%rax
    1e08:	00 00 00 
    1e0b:	ff d0                	call   *%rax
    1e0d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1e11:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1e16:	75 07                	jne    1e1f <malloc+0x134>
        return 0;
    1e18:	b8 00 00 00 00       	mov    $0x0,%eax
    1e1d:	eb 18                	jmp    1e37 <malloc+0x14c>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1e1f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e23:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1e27:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e2b:	48 8b 00             	mov    (%rax),%rax
    1e2e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1e32:	e9 41 ff ff ff       	jmp    1d78 <malloc+0x8d>
  }
}
    1e37:	c9                   	leave
    1e38:	c3                   	ret
