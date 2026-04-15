
_kill:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
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
    printf(2, "usage: kill pid...\n");
    1019:	48 b8 f0 1d 00 00 00 	movabs $0x1df0,%rax
    1020:	00 00 00 
    1023:	48 89 c6             	mov    %rax,%rsi
    1026:	bf 02 00 00 00       	mov    $0x2,%edi
    102b:	b8 00 00 00 00       	mov    $0x0,%eax
    1030:	48 ba e4 16 00 00 00 	movabs $0x16e4,%rdx
    1037:	00 00 00 
    103a:	ff d2                	call   *%rdx
    exit();
    103c:	48 b8 e0 13 00 00 00 	movabs $0x13e0,%rax
    1043:	00 00 00 
    1046:	ff d0                	call   *%rax
  }
  for(i=1; i<argc; i++)
    1048:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
    104f:	eb 38                	jmp    1089 <main+0x89>
    kill(atoi(argv[i]));
    1051:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1054:	48 98                	cltq
    1056:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    105d:	00 
    105e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1062:	48 01 d0             	add    %rdx,%rax
    1065:	48 8b 00             	mov    (%rax),%rax
    1068:	48 89 c7             	mov    %rax,%rdi
    106b:	48 b8 1e 13 00 00 00 	movabs $0x131e,%rax
    1072:	00 00 00 
    1075:	ff d0                	call   *%rax
    1077:	89 c7                	mov    %eax,%edi
    1079:	48 b8 2e 14 00 00 00 	movabs $0x142e,%rax
    1080:	00 00 00 
    1083:	ff d0                	call   *%rax
  for(i=1; i<argc; i++)
    1085:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1089:	8b 45 fc             	mov    -0x4(%rbp),%eax
    108c:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    108f:	7c c0                	jl     1051 <main+0x51>
  exit();
    1091:	48 b8 e0 13 00 00 00 	movabs $0x13e0,%rax
    1098:	00 00 00 
    109b:	ff d0                	call   *%rax

000000000000109d <stosb>:
  stosb(dst, c, n);
  return dst;
}

char*
strchr(const char *s, char c)
    109d:	f3 0f 1e fa          	endbr64
    10a1:	55                   	push   %rbp
    10a2:	48 89 e5             	mov    %rsp,%rbp
    10a5:	48 83 ec 10          	sub    $0x10,%rsp
    10a9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    10ad:	89 75 f4             	mov    %esi,-0xc(%rbp)
    10b0:	89 55 f0             	mov    %edx,-0x10(%rbp)
{
    10b3:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    10b7:	8b 55 f0             	mov    -0x10(%rbp),%edx
    10ba:	8b 45 f4             	mov    -0xc(%rbp),%eax
    10bd:	48 89 ce             	mov    %rcx,%rsi
    10c0:	48 89 f7             	mov    %rsi,%rdi
    10c3:	89 d1                	mov    %edx,%ecx
    10c5:	fc                   	cld
    10c6:	f3 aa                	rep stos %al,%es:(%rdi)
    10c8:	89 ca                	mov    %ecx,%edx
    10ca:	48 89 fe             	mov    %rdi,%rsi
    10cd:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    10d1:	89 55 f0             	mov    %edx,-0x10(%rbp)
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
    10d4:	90                   	nop
    10d5:	c9                   	leave
    10d6:	c3                   	ret

00000000000010d7 <strcpy>:
{
    10d7:	f3 0f 1e fa          	endbr64
    10db:	55                   	push   %rbp
    10dc:	48 89 e5             	mov    %rsp,%rbp
    10df:	48 83 ec 20          	sub    $0x20,%rsp
    10e3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    10e7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  os = s;
    10eb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    10ef:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    10f3:	90                   	nop
    10f4:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    10f8:	48 8d 42 01          	lea    0x1(%rdx),%rax
    10fc:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    1100:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1104:	48 8d 48 01          	lea    0x1(%rax),%rcx
    1108:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    110c:	0f b6 12             	movzbl (%rdx),%edx
    110f:	88 10                	mov    %dl,(%rax)
    1111:	0f b6 00             	movzbl (%rax),%eax
    1114:	84 c0                	test   %al,%al
    1116:	75 dc                	jne    10f4 <strcpy+0x1d>
  return os;
    1118:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    111c:	c9                   	leave
    111d:	c3                   	ret

000000000000111e <strcmp>:
{
    111e:	f3 0f 1e fa          	endbr64
    1122:	55                   	push   %rbp
    1123:	48 89 e5             	mov    %rsp,%rbp
    1126:	48 83 ec 10          	sub    $0x10,%rsp
    112a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    112e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    1132:	eb 0a                	jmp    113e <strcmp+0x20>
    p++, q++;
    1134:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1139:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    113e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1142:	0f b6 00             	movzbl (%rax),%eax
    1145:	84 c0                	test   %al,%al
    1147:	74 12                	je     115b <strcmp+0x3d>
    1149:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    114d:	0f b6 10             	movzbl (%rax),%edx
    1150:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1154:	0f b6 00             	movzbl (%rax),%eax
    1157:	38 c2                	cmp    %al,%dl
    1159:	74 d9                	je     1134 <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
    115b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    115f:	0f b6 00             	movzbl (%rax),%eax
    1162:	0f b6 d0             	movzbl %al,%edx
    1165:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1169:	0f b6 00             	movzbl (%rax),%eax
    116c:	0f b6 c0             	movzbl %al,%eax
    116f:	29 c2                	sub    %eax,%edx
    1171:	89 d0                	mov    %edx,%eax
}
    1173:	c9                   	leave
    1174:	c3                   	ret

0000000000001175 <strlen>:
{
    1175:	f3 0f 1e fa          	endbr64
    1179:	55                   	push   %rbp
    117a:	48 89 e5             	mov    %rsp,%rbp
    117d:	48 83 ec 18          	sub    $0x18,%rsp
    1181:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  for(n = 0; s[n]; n++)
    1185:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    118c:	eb 04                	jmp    1192 <strlen+0x1d>
    118e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1192:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1195:	48 63 d0             	movslq %eax,%rdx
    1198:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    119c:	48 01 d0             	add    %rdx,%rax
    119f:	0f b6 00             	movzbl (%rax),%eax
    11a2:	84 c0                	test   %al,%al
    11a4:	75 e8                	jne    118e <strlen+0x19>
  return n;
    11a6:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    11a9:	c9                   	leave
    11aa:	c3                   	ret

00000000000011ab <memset>:
{
    11ab:	f3 0f 1e fa          	endbr64
    11af:	55                   	push   %rbp
    11b0:	48 89 e5             	mov    %rsp,%rbp
    11b3:	48 83 ec 10          	sub    $0x10,%rsp
    11b7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    11bb:	89 75 f4             	mov    %esi,-0xc(%rbp)
    11be:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    11c1:	8b 55 f0             	mov    -0x10(%rbp),%edx
    11c4:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    11c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    11cb:	89 ce                	mov    %ecx,%esi
    11cd:	48 89 c7             	mov    %rax,%rdi
    11d0:	48 b8 9d 10 00 00 00 	movabs $0x109d,%rax
    11d7:	00 00 00 
    11da:	ff d0                	call   *%rax
  return dst;
    11dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    11e0:	c9                   	leave
    11e1:	c3                   	ret

00000000000011e2 <strchr>:
{
    11e2:	f3 0f 1e fa          	endbr64
    11e6:	55                   	push   %rbp
    11e7:	48 89 e5             	mov    %rsp,%rbp
    11ea:	48 83 ec 10          	sub    $0x10,%rsp
    11ee:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    11f2:	89 f0                	mov    %esi,%eax
    11f4:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    11f7:	eb 17                	jmp    1210 <strchr+0x2e>
    if(*s == c)
    11f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    11fd:	0f b6 00             	movzbl (%rax),%eax
    1200:	38 45 f4             	cmp    %al,-0xc(%rbp)
    1203:	75 06                	jne    120b <strchr+0x29>
      return (char*)s;
    1205:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1209:	eb 15                	jmp    1220 <strchr+0x3e>
  for(; *s; s++)
    120b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1210:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1214:	0f b6 00             	movzbl (%rax),%eax
    1217:	84 c0                	test   %al,%al
    1219:	75 de                	jne    11f9 <strchr+0x17>
  return 0;
    121b:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1220:	c9                   	leave
    1221:	c3                   	ret

0000000000001222 <gets>:

char*
gets(char *buf, int max)
{
    1222:	f3 0f 1e fa          	endbr64
    1226:	55                   	push   %rbp
    1227:	48 89 e5             	mov    %rsp,%rbp
    122a:	48 83 ec 20          	sub    $0x20,%rsp
    122e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1232:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1235:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    123c:	eb 4f                	jmp    128d <gets+0x6b>
    cc = read(0, &c, 1);
    123e:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    1242:	ba 01 00 00 00       	mov    $0x1,%edx
    1247:	48 89 c6             	mov    %rax,%rsi
    124a:	bf 00 00 00 00       	mov    $0x0,%edi
    124f:	48 b8 07 14 00 00 00 	movabs $0x1407,%rax
    1256:	00 00 00 
    1259:	ff d0                	call   *%rax
    125b:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    125e:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1262:	7e 36                	jle    129a <gets+0x78>
      break;
    buf[i++] = c;
    1264:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1267:	8d 50 01             	lea    0x1(%rax),%edx
    126a:	89 55 fc             	mov    %edx,-0x4(%rbp)
    126d:	48 63 d0             	movslq %eax,%rdx
    1270:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1274:	48 01 c2             	add    %rax,%rdx
    1277:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    127b:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    127d:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1281:	3c 0a                	cmp    $0xa,%al
    1283:	74 16                	je     129b <gets+0x79>
    1285:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1289:	3c 0d                	cmp    $0xd,%al
    128b:	74 0e                	je     129b <gets+0x79>
  for(i=0; i+1 < max; ){
    128d:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1290:	83 c0 01             	add    $0x1,%eax
    1293:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    1296:	7f a6                	jg     123e <gets+0x1c>
    1298:	eb 01                	jmp    129b <gets+0x79>
      break;
    129a:	90                   	nop
      break;
  }
  buf[i] = '\0';
    129b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    129e:	48 63 d0             	movslq %eax,%rdx
    12a1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12a5:	48 01 d0             	add    %rdx,%rax
    12a8:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    12ab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    12af:	c9                   	leave
    12b0:	c3                   	ret

00000000000012b1 <stat>:

int
stat(char *n, struct stat *st)
{
    12b1:	f3 0f 1e fa          	endbr64
    12b5:	55                   	push   %rbp
    12b6:	48 89 e5             	mov    %rsp,%rbp
    12b9:	48 83 ec 20          	sub    $0x20,%rsp
    12bd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    12c1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    12c5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12c9:	be 00 00 00 00       	mov    $0x0,%esi
    12ce:	48 89 c7             	mov    %rax,%rdi
    12d1:	48 b8 48 14 00 00 00 	movabs $0x1448,%rax
    12d8:	00 00 00 
    12db:	ff d0                	call   *%rax
    12dd:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    12e0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    12e4:	79 07                	jns    12ed <stat+0x3c>
    return -1;
    12e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    12eb:	eb 2f                	jmp    131c <stat+0x6b>
  r = fstat(fd, st);
    12ed:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    12f1:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12f4:	48 89 d6             	mov    %rdx,%rsi
    12f7:	89 c7                	mov    %eax,%edi
    12f9:	48 b8 6f 14 00 00 00 	movabs $0x146f,%rax
    1300:	00 00 00 
    1303:	ff d0                	call   *%rax
    1305:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    1308:	8b 45 fc             	mov    -0x4(%rbp),%eax
    130b:	89 c7                	mov    %eax,%edi
    130d:	48 b8 21 14 00 00 00 	movabs $0x1421,%rax
    1314:	00 00 00 
    1317:	ff d0                	call   *%rax
  return r;
    1319:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    131c:	c9                   	leave
    131d:	c3                   	ret

000000000000131e <atoi>:

int
atoi(const char *s)
{
    131e:	f3 0f 1e fa          	endbr64
    1322:	55                   	push   %rbp
    1323:	48 89 e5             	mov    %rsp,%rbp
    1326:	48 83 ec 18          	sub    $0x18,%rsp
    132a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    132e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1335:	eb 28                	jmp    135f <atoi+0x41>
    n = n*10 + *s++ - '0';
    1337:	8b 55 fc             	mov    -0x4(%rbp),%edx
    133a:	89 d0                	mov    %edx,%eax
    133c:	c1 e0 02             	shl    $0x2,%eax
    133f:	01 d0                	add    %edx,%eax
    1341:	01 c0                	add    %eax,%eax
    1343:	89 c1                	mov    %eax,%ecx
    1345:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1349:	48 8d 50 01          	lea    0x1(%rax),%rdx
    134d:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    1351:	0f b6 00             	movzbl (%rax),%eax
    1354:	0f be c0             	movsbl %al,%eax
    1357:	01 c8                	add    %ecx,%eax
    1359:	83 e8 30             	sub    $0x30,%eax
    135c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    135f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1363:	0f b6 00             	movzbl (%rax),%eax
    1366:	3c 2f                	cmp    $0x2f,%al
    1368:	7e 0b                	jle    1375 <atoi+0x57>
    136a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    136e:	0f b6 00             	movzbl (%rax),%eax
    1371:	3c 39                	cmp    $0x39,%al
    1373:	7e c2                	jle    1337 <atoi+0x19>
  return n;
    1375:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    1378:	c9                   	leave
    1379:	c3                   	ret

000000000000137a <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    137a:	f3 0f 1e fa          	endbr64
    137e:	55                   	push   %rbp
    137f:	48 89 e5             	mov    %rsp,%rbp
    1382:	48 83 ec 28          	sub    $0x28,%rsp
    1386:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    138a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    138e:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    1391:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1395:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    1399:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    139d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    13a1:	eb 1d                	jmp    13c0 <memmove+0x46>
    *dst++ = *src++;
    13a3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    13a7:	48 8d 42 01          	lea    0x1(%rdx),%rax
    13ab:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    13af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13b3:	48 8d 48 01          	lea    0x1(%rax),%rcx
    13b7:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    13bb:	0f b6 12             	movzbl (%rdx),%edx
    13be:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    13c0:	8b 45 dc             	mov    -0x24(%rbp),%eax
    13c3:	8d 50 ff             	lea    -0x1(%rax),%edx
    13c6:	89 55 dc             	mov    %edx,-0x24(%rbp)
    13c9:	85 c0                	test   %eax,%eax
    13cb:	7f d6                	jg     13a3 <memmove+0x29>
  return vdst;
    13cd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    13d1:	c9                   	leave
    13d2:	c3                   	ret

00000000000013d3 <fork>:
    13d3:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    13da:	49 89 ca             	mov    %rcx,%r10
    13dd:	0f 05                	syscall
    13df:	c3                   	ret

00000000000013e0 <exit>:
    13e0:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    13e7:	49 89 ca             	mov    %rcx,%r10
    13ea:	0f 05                	syscall
    13ec:	c3                   	ret

00000000000013ed <wait>:
    13ed:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    13f4:	49 89 ca             	mov    %rcx,%r10
    13f7:	0f 05                	syscall
    13f9:	c3                   	ret

00000000000013fa <pipe>:
    13fa:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    1401:	49 89 ca             	mov    %rcx,%r10
    1404:	0f 05                	syscall
    1406:	c3                   	ret

0000000000001407 <read>:
    1407:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    140e:	49 89 ca             	mov    %rcx,%r10
    1411:	0f 05                	syscall
    1413:	c3                   	ret

0000000000001414 <write>:
    1414:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    141b:	49 89 ca             	mov    %rcx,%r10
    141e:	0f 05                	syscall
    1420:	c3                   	ret

0000000000001421 <close>:
    1421:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    1428:	49 89 ca             	mov    %rcx,%r10
    142b:	0f 05                	syscall
    142d:	c3                   	ret

000000000000142e <kill>:
    142e:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    1435:	49 89 ca             	mov    %rcx,%r10
    1438:	0f 05                	syscall
    143a:	c3                   	ret

000000000000143b <exec>:
    143b:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    1442:	49 89 ca             	mov    %rcx,%r10
    1445:	0f 05                	syscall
    1447:	c3                   	ret

0000000000001448 <open>:
    1448:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    144f:	49 89 ca             	mov    %rcx,%r10
    1452:	0f 05                	syscall
    1454:	c3                   	ret

0000000000001455 <mknod>:
    1455:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    145c:	49 89 ca             	mov    %rcx,%r10
    145f:	0f 05                	syscall
    1461:	c3                   	ret

0000000000001462 <unlink>:
    1462:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    1469:	49 89 ca             	mov    %rcx,%r10
    146c:	0f 05                	syscall
    146e:	c3                   	ret

000000000000146f <fstat>:
    146f:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    1476:	49 89 ca             	mov    %rcx,%r10
    1479:	0f 05                	syscall
    147b:	c3                   	ret

000000000000147c <link>:
    147c:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    1483:	49 89 ca             	mov    %rcx,%r10
    1486:	0f 05                	syscall
    1488:	c3                   	ret

0000000000001489 <mkdir>:
    1489:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    1490:	49 89 ca             	mov    %rcx,%r10
    1493:	0f 05                	syscall
    1495:	c3                   	ret

0000000000001496 <chdir>:
    1496:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    149d:	49 89 ca             	mov    %rcx,%r10
    14a0:	0f 05                	syscall
    14a2:	c3                   	ret

00000000000014a3 <dup>:
    14a3:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    14aa:	49 89 ca             	mov    %rcx,%r10
    14ad:	0f 05                	syscall
    14af:	c3                   	ret

00000000000014b0 <getpid>:
    14b0:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    14b7:	49 89 ca             	mov    %rcx,%r10
    14ba:	0f 05                	syscall
    14bc:	c3                   	ret

00000000000014bd <sbrk>:
    14bd:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    14c4:	49 89 ca             	mov    %rcx,%r10
    14c7:	0f 05                	syscall
    14c9:	c3                   	ret

00000000000014ca <sleep>:
    14ca:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    14d1:	49 89 ca             	mov    %rcx,%r10
    14d4:	0f 05                	syscall
    14d6:	c3                   	ret

00000000000014d7 <uptime>:
    14d7:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    14de:	49 89 ca             	mov    %rcx,%r10
    14e1:	0f 05                	syscall
    14e3:	c3                   	ret

00000000000014e4 <send>:
    14e4:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    14eb:	49 89 ca             	mov    %rcx,%r10
    14ee:	0f 05                	syscall
    14f0:	c3                   	ret

00000000000014f1 <recv>:
    14f1:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    14f8:	49 89 ca             	mov    %rcx,%r10
    14fb:	0f 05                	syscall
    14fd:	c3                   	ret

00000000000014fe <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    14fe:	f3 0f 1e fa          	endbr64
    1502:	55                   	push   %rbp
    1503:	48 89 e5             	mov    %rsp,%rbp
    1506:	48 83 ec 10          	sub    $0x10,%rsp
    150a:	89 7d fc             	mov    %edi,-0x4(%rbp)
    150d:	89 f0                	mov    %esi,%eax
    150f:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    1512:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    1516:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1519:	ba 01 00 00 00       	mov    $0x1,%edx
    151e:	48 89 ce             	mov    %rcx,%rsi
    1521:	89 c7                	mov    %eax,%edi
    1523:	48 b8 14 14 00 00 00 	movabs $0x1414,%rax
    152a:	00 00 00 
    152d:	ff d0                	call   *%rax
}
    152f:	90                   	nop
    1530:	c9                   	leave
    1531:	c3                   	ret

0000000000001532 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    1532:	f3 0f 1e fa          	endbr64
    1536:	55                   	push   %rbp
    1537:	48 89 e5             	mov    %rsp,%rbp
    153a:	48 83 ec 20          	sub    $0x20,%rsp
    153e:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1541:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1545:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    154c:	eb 35                	jmp    1583 <print_x64+0x51>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    154e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1552:	48 c1 e8 3c          	shr    $0x3c,%rax
    1556:	48 ba c0 1e 00 00 00 	movabs $0x1ec0,%rdx
    155d:	00 00 00 
    1560:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1564:	0f be d0             	movsbl %al,%edx
    1567:	8b 45 ec             	mov    -0x14(%rbp),%eax
    156a:	89 d6                	mov    %edx,%esi
    156c:	89 c7                	mov    %eax,%edi
    156e:	48 b8 fe 14 00 00 00 	movabs $0x14fe,%rax
    1575:	00 00 00 
    1578:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    157a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    157e:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    1583:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1586:	83 f8 0f             	cmp    $0xf,%eax
    1589:	76 c3                	jbe    154e <print_x64+0x1c>
}
    158b:	90                   	nop
    158c:	90                   	nop
    158d:	c9                   	leave
    158e:	c3                   	ret

000000000000158f <print_x32>:

  static void
print_x32(int fd, uint x)
{
    158f:	f3 0f 1e fa          	endbr64
    1593:	55                   	push   %rbp
    1594:	48 89 e5             	mov    %rsp,%rbp
    1597:	48 83 ec 20          	sub    $0x20,%rsp
    159b:	89 7d ec             	mov    %edi,-0x14(%rbp)
    159e:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    15a1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    15a8:	eb 36                	jmp    15e0 <print_x32+0x51>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    15aa:	8b 45 e8             	mov    -0x18(%rbp),%eax
    15ad:	c1 e8 1c             	shr    $0x1c,%eax
    15b0:	89 c2                	mov    %eax,%edx
    15b2:	48 b8 c0 1e 00 00 00 	movabs $0x1ec0,%rax
    15b9:	00 00 00 
    15bc:	89 d2                	mov    %edx,%edx
    15be:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    15c2:	0f be d0             	movsbl %al,%edx
    15c5:	8b 45 ec             	mov    -0x14(%rbp),%eax
    15c8:	89 d6                	mov    %edx,%esi
    15ca:	89 c7                	mov    %eax,%edi
    15cc:	48 b8 fe 14 00 00 00 	movabs $0x14fe,%rax
    15d3:	00 00 00 
    15d6:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    15d8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    15dc:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    15e0:	8b 45 fc             	mov    -0x4(%rbp),%eax
    15e3:	83 f8 07             	cmp    $0x7,%eax
    15e6:	76 c2                	jbe    15aa <print_x32+0x1b>
}
    15e8:	90                   	nop
    15e9:	90                   	nop
    15ea:	c9                   	leave
    15eb:	c3                   	ret

00000000000015ec <print_d>:

  static void
print_d(int fd, int v)
{
    15ec:	f3 0f 1e fa          	endbr64
    15f0:	55                   	push   %rbp
    15f1:	48 89 e5             	mov    %rsp,%rbp
    15f4:	48 83 ec 30          	sub    $0x30,%rsp
    15f8:	89 7d dc             	mov    %edi,-0x24(%rbp)
    15fb:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    15fe:	8b 45 d8             	mov    -0x28(%rbp),%eax
    1601:	48 98                	cltq
    1603:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    1607:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    160b:	79 04                	jns    1611 <print_d+0x25>
    x = -x;
    160d:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    1611:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    1618:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    161c:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1623:	66 66 66 
    1626:	48 89 c8             	mov    %rcx,%rax
    1629:	48 f7 ea             	imul   %rdx
    162c:	48 c1 fa 02          	sar    $0x2,%rdx
    1630:	48 89 c8             	mov    %rcx,%rax
    1633:	48 c1 f8 3f          	sar    $0x3f,%rax
    1637:	48 29 c2             	sub    %rax,%rdx
    163a:	48 89 d0             	mov    %rdx,%rax
    163d:	48 c1 e0 02          	shl    $0x2,%rax
    1641:	48 01 d0             	add    %rdx,%rax
    1644:	48 01 c0             	add    %rax,%rax
    1647:	48 29 c1             	sub    %rax,%rcx
    164a:	48 89 ca             	mov    %rcx,%rdx
    164d:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1650:	8d 48 01             	lea    0x1(%rax),%ecx
    1653:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    1656:	48 b9 c0 1e 00 00 00 	movabs $0x1ec0,%rcx
    165d:	00 00 00 
    1660:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    1664:	48 98                	cltq
    1666:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    166a:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    166e:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1675:	66 66 66 
    1678:	48 89 c8             	mov    %rcx,%rax
    167b:	48 f7 ea             	imul   %rdx
    167e:	48 89 d0             	mov    %rdx,%rax
    1681:	48 c1 f8 02          	sar    $0x2,%rax
    1685:	48 c1 f9 3f          	sar    $0x3f,%rcx
    1689:	48 89 ca             	mov    %rcx,%rdx
    168c:	48 29 d0             	sub    %rdx,%rax
    168f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    1693:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1698:	0f 85 7a ff ff ff    	jne    1618 <print_d+0x2c>

  if (v < 0)
    169e:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    16a2:	79 32                	jns    16d6 <print_d+0xea>
    buf[i++] = '-';
    16a4:	8b 45 f4             	mov    -0xc(%rbp),%eax
    16a7:	8d 50 01             	lea    0x1(%rax),%edx
    16aa:	89 55 f4             	mov    %edx,-0xc(%rbp)
    16ad:	48 98                	cltq
    16af:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    16b4:	eb 20                	jmp    16d6 <print_d+0xea>
    putc(fd, buf[i]);
    16b6:	8b 45 f4             	mov    -0xc(%rbp),%eax
    16b9:	48 98                	cltq
    16bb:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    16c0:	0f be d0             	movsbl %al,%edx
    16c3:	8b 45 dc             	mov    -0x24(%rbp),%eax
    16c6:	89 d6                	mov    %edx,%esi
    16c8:	89 c7                	mov    %eax,%edi
    16ca:	48 b8 fe 14 00 00 00 	movabs $0x14fe,%rax
    16d1:	00 00 00 
    16d4:	ff d0                	call   *%rax
  while (--i >= 0)
    16d6:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    16da:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    16de:	79 d6                	jns    16b6 <print_d+0xca>
}
    16e0:	90                   	nop
    16e1:	90                   	nop
    16e2:	c9                   	leave
    16e3:	c3                   	ret

00000000000016e4 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    16e4:	f3 0f 1e fa          	endbr64
    16e8:	55                   	push   %rbp
    16e9:	48 89 e5             	mov    %rsp,%rbp
    16ec:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    16f3:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    16f9:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    1700:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    1707:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    170e:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    1715:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    171c:	84 c0                	test   %al,%al
    171e:	74 20                	je     1740 <printf+0x5c>
    1720:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    1724:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    1728:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    172c:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    1730:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    1734:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    1738:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    173c:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    1740:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    1747:	00 00 00 
    174a:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    1751:	00 00 00 
    1754:	48 8d 45 10          	lea    0x10(%rbp),%rax
    1758:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    175f:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    1766:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    176d:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    1774:	00 00 00 
    1777:	e9 41 03 00 00       	jmp    1abd <printf+0x3d9>
    if (c != '%') {
    177c:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1783:	74 24                	je     17a9 <printf+0xc5>
      putc(fd, c);
    1785:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    178b:	0f be d0             	movsbl %al,%edx
    178e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1794:	89 d6                	mov    %edx,%esi
    1796:	89 c7                	mov    %eax,%edi
    1798:	48 b8 fe 14 00 00 00 	movabs $0x14fe,%rax
    179f:	00 00 00 
    17a2:	ff d0                	call   *%rax
      continue;
    17a4:	e9 0d 03 00 00       	jmp    1ab6 <printf+0x3d2>
    }
    c = fmt[++i] & 0xff;
    17a9:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    17b0:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    17b6:	48 63 d0             	movslq %eax,%rdx
    17b9:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    17c0:	48 01 d0             	add    %rdx,%rax
    17c3:	0f b6 00             	movzbl (%rax),%eax
    17c6:	0f be c0             	movsbl %al,%eax
    17c9:	25 ff 00 00 00       	and    $0xff,%eax
    17ce:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    17d4:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    17db:	0f 84 0f 03 00 00    	je     1af0 <printf+0x40c>
      break;
    switch(c) {
    17e1:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    17e8:	0f 84 74 02 00 00    	je     1a62 <printf+0x37e>
    17ee:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    17f5:	0f 8c 82 02 00 00    	jl     1a7d <printf+0x399>
    17fb:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    1802:	0f 8f 75 02 00 00    	jg     1a7d <printf+0x399>
    1808:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    180f:	0f 8c 68 02 00 00    	jl     1a7d <printf+0x399>
    1815:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    181b:	83 e8 63             	sub    $0x63,%eax
    181e:	83 f8 15             	cmp    $0x15,%eax
    1821:	0f 87 56 02 00 00    	ja     1a7d <printf+0x399>
    1827:	89 c0                	mov    %eax,%eax
    1829:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1830:	00 
    1831:	48 b8 10 1e 00 00 00 	movabs $0x1e10,%rax
    1838:	00 00 00 
    183b:	48 01 d0             	add    %rdx,%rax
    183e:	48 8b 00             	mov    (%rax),%rax
    1841:	3e ff e0             	notrack jmp *%rax
    case 'c':
      putc(fd, va_arg(ap, int));
    1844:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    184a:	83 f8 2f             	cmp    $0x2f,%eax
    184d:	77 23                	ja     1872 <printf+0x18e>
    184f:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1856:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    185c:	89 d2                	mov    %edx,%edx
    185e:	48 01 d0             	add    %rdx,%rax
    1861:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1867:	83 c2 08             	add    $0x8,%edx
    186a:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1870:	eb 12                	jmp    1884 <printf+0x1a0>
    1872:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1879:	48 8d 50 08          	lea    0x8(%rax),%rdx
    187d:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1884:	8b 00                	mov    (%rax),%eax
    1886:	0f be d0             	movsbl %al,%edx
    1889:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    188f:	89 d6                	mov    %edx,%esi
    1891:	89 c7                	mov    %eax,%edi
    1893:	48 b8 fe 14 00 00 00 	movabs $0x14fe,%rax
    189a:	00 00 00 
    189d:	ff d0                	call   *%rax
      break;
    189f:	e9 12 02 00 00       	jmp    1ab6 <printf+0x3d2>
    case 'd':
      print_d(fd, va_arg(ap, int));
    18a4:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    18aa:	83 f8 2f             	cmp    $0x2f,%eax
    18ad:	77 23                	ja     18d2 <printf+0x1ee>
    18af:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    18b6:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18bc:	89 d2                	mov    %edx,%edx
    18be:	48 01 d0             	add    %rdx,%rax
    18c1:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18c7:	83 c2 08             	add    $0x8,%edx
    18ca:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    18d0:	eb 12                	jmp    18e4 <printf+0x200>
    18d2:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    18d9:	48 8d 50 08          	lea    0x8(%rax),%rdx
    18dd:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    18e4:	8b 10                	mov    (%rax),%edx
    18e6:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    18ec:	89 d6                	mov    %edx,%esi
    18ee:	89 c7                	mov    %eax,%edi
    18f0:	48 b8 ec 15 00 00 00 	movabs $0x15ec,%rax
    18f7:	00 00 00 
    18fa:	ff d0                	call   *%rax
      break;
    18fc:	e9 b5 01 00 00       	jmp    1ab6 <printf+0x3d2>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    1901:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1907:	83 f8 2f             	cmp    $0x2f,%eax
    190a:	77 23                	ja     192f <printf+0x24b>
    190c:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1913:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1919:	89 d2                	mov    %edx,%edx
    191b:	48 01 d0             	add    %rdx,%rax
    191e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1924:	83 c2 08             	add    $0x8,%edx
    1927:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    192d:	eb 12                	jmp    1941 <printf+0x25d>
    192f:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1936:	48 8d 50 08          	lea    0x8(%rax),%rdx
    193a:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1941:	8b 10                	mov    (%rax),%edx
    1943:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1949:	89 d6                	mov    %edx,%esi
    194b:	89 c7                	mov    %eax,%edi
    194d:	48 b8 8f 15 00 00 00 	movabs $0x158f,%rax
    1954:	00 00 00 
    1957:	ff d0                	call   *%rax
      break;
    1959:	e9 58 01 00 00       	jmp    1ab6 <printf+0x3d2>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    195e:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1964:	83 f8 2f             	cmp    $0x2f,%eax
    1967:	77 23                	ja     198c <printf+0x2a8>
    1969:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1970:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1976:	89 d2                	mov    %edx,%edx
    1978:	48 01 d0             	add    %rdx,%rax
    197b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1981:	83 c2 08             	add    $0x8,%edx
    1984:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    198a:	eb 12                	jmp    199e <printf+0x2ba>
    198c:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1993:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1997:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    199e:	48 8b 10             	mov    (%rax),%rdx
    19a1:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    19a7:	48 89 d6             	mov    %rdx,%rsi
    19aa:	89 c7                	mov    %eax,%edi
    19ac:	48 b8 32 15 00 00 00 	movabs $0x1532,%rax
    19b3:	00 00 00 
    19b6:	ff d0                	call   *%rax
      break;
    19b8:	e9 f9 00 00 00       	jmp    1ab6 <printf+0x3d2>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    19bd:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    19c3:	83 f8 2f             	cmp    $0x2f,%eax
    19c6:	77 23                	ja     19eb <printf+0x307>
    19c8:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    19cf:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19d5:	89 d2                	mov    %edx,%edx
    19d7:	48 01 d0             	add    %rdx,%rax
    19da:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19e0:	83 c2 08             	add    $0x8,%edx
    19e3:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    19e9:	eb 12                	jmp    19fd <printf+0x319>
    19eb:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    19f2:	48 8d 50 08          	lea    0x8(%rax),%rdx
    19f6:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    19fd:	48 8b 00             	mov    (%rax),%rax
    1a00:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    1a07:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1a0e:	00 
    1a0f:	75 41                	jne    1a52 <printf+0x36e>
        s = "(null)";
    1a11:	48 b8 08 1e 00 00 00 	movabs $0x1e08,%rax
    1a18:	00 00 00 
    1a1b:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1a22:	eb 2e                	jmp    1a52 <printf+0x36e>
        putc(fd, *(s++));
    1a24:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1a2b:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1a2f:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1a36:	0f b6 00             	movzbl (%rax),%eax
    1a39:	0f be d0             	movsbl %al,%edx
    1a3c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a42:	89 d6                	mov    %edx,%esi
    1a44:	89 c7                	mov    %eax,%edi
    1a46:	48 b8 fe 14 00 00 00 	movabs $0x14fe,%rax
    1a4d:	00 00 00 
    1a50:	ff d0                	call   *%rax
      while (*s)
    1a52:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1a59:	0f b6 00             	movzbl (%rax),%eax
    1a5c:	84 c0                	test   %al,%al
    1a5e:	75 c4                	jne    1a24 <printf+0x340>
      break;
    1a60:	eb 54                	jmp    1ab6 <printf+0x3d2>
    case '%':
      putc(fd, '%');
    1a62:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a68:	be 25 00 00 00       	mov    $0x25,%esi
    1a6d:	89 c7                	mov    %eax,%edi
    1a6f:	48 b8 fe 14 00 00 00 	movabs $0x14fe,%rax
    1a76:	00 00 00 
    1a79:	ff d0                	call   *%rax
      break;
    1a7b:	eb 39                	jmp    1ab6 <printf+0x3d2>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1a7d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a83:	be 25 00 00 00       	mov    $0x25,%esi
    1a88:	89 c7                	mov    %eax,%edi
    1a8a:	48 b8 fe 14 00 00 00 	movabs $0x14fe,%rax
    1a91:	00 00 00 
    1a94:	ff d0                	call   *%rax
      putc(fd, c);
    1a96:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1a9c:	0f be d0             	movsbl %al,%edx
    1a9f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1aa5:	89 d6                	mov    %edx,%esi
    1aa7:	89 c7                	mov    %eax,%edi
    1aa9:	48 b8 fe 14 00 00 00 	movabs $0x14fe,%rax
    1ab0:	00 00 00 
    1ab3:	ff d0                	call   *%rax
      break;
    1ab5:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1ab6:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1abd:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1ac3:	48 63 d0             	movslq %eax,%rdx
    1ac6:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1acd:	48 01 d0             	add    %rdx,%rax
    1ad0:	0f b6 00             	movzbl (%rax),%eax
    1ad3:	0f be c0             	movsbl %al,%eax
    1ad6:	25 ff 00 00 00       	and    $0xff,%eax
    1adb:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1ae1:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1ae8:	0f 85 8e fc ff ff    	jne    177c <printf+0x98>
    }
  }
}
    1aee:	eb 01                	jmp    1af1 <printf+0x40d>
      break;
    1af0:	90                   	nop
}
    1af1:	90                   	nop
    1af2:	c9                   	leave
    1af3:	c3                   	ret

0000000000001af4 <free>:
    1af4:	55                   	push   %rbp
    1af5:	48 89 e5             	mov    %rsp,%rbp
    1af8:	48 83 ec 18          	sub    $0x18,%rsp
    1afc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1b00:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1b04:	48 83 e8 10          	sub    $0x10,%rax
    1b08:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1b0c:	48 b8 f0 1e 00 00 00 	movabs $0x1ef0,%rax
    1b13:	00 00 00 
    1b16:	48 8b 00             	mov    (%rax),%rax
    1b19:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1b1d:	eb 2f                	jmp    1b4e <free+0x5a>
    1b1f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b23:	48 8b 00             	mov    (%rax),%rax
    1b26:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b2a:	72 17                	jb     1b43 <free+0x4f>
    1b2c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b30:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b34:	72 2f                	jb     1b65 <free+0x71>
    1b36:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b3a:	48 8b 00             	mov    (%rax),%rax
    1b3d:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1b41:	72 22                	jb     1b65 <free+0x71>
    1b43:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b47:	48 8b 00             	mov    (%rax),%rax
    1b4a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1b4e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b52:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b56:	73 c7                	jae    1b1f <free+0x2b>
    1b58:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b5c:	48 8b 00             	mov    (%rax),%rax
    1b5f:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1b63:	73 ba                	jae    1b1f <free+0x2b>
    1b65:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b69:	8b 40 08             	mov    0x8(%rax),%eax
    1b6c:	89 c0                	mov    %eax,%eax
    1b6e:	48 c1 e0 04          	shl    $0x4,%rax
    1b72:	48 89 c2             	mov    %rax,%rdx
    1b75:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b79:	48 01 c2             	add    %rax,%rdx
    1b7c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b80:	48 8b 00             	mov    (%rax),%rax
    1b83:	48 39 c2             	cmp    %rax,%rdx
    1b86:	75 2d                	jne    1bb5 <free+0xc1>
    1b88:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b8c:	8b 50 08             	mov    0x8(%rax),%edx
    1b8f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b93:	48 8b 00             	mov    (%rax),%rax
    1b96:	8b 40 08             	mov    0x8(%rax),%eax
    1b99:	01 c2                	add    %eax,%edx
    1b9b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b9f:	89 50 08             	mov    %edx,0x8(%rax)
    1ba2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ba6:	48 8b 00             	mov    (%rax),%rax
    1ba9:	48 8b 10             	mov    (%rax),%rdx
    1bac:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bb0:	48 89 10             	mov    %rdx,(%rax)
    1bb3:	eb 0e                	jmp    1bc3 <free+0xcf>
    1bb5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bb9:	48 8b 10             	mov    (%rax),%rdx
    1bbc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bc0:	48 89 10             	mov    %rdx,(%rax)
    1bc3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bc7:	8b 40 08             	mov    0x8(%rax),%eax
    1bca:	89 c0                	mov    %eax,%eax
    1bcc:	48 c1 e0 04          	shl    $0x4,%rax
    1bd0:	48 89 c2             	mov    %rax,%rdx
    1bd3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bd7:	48 01 d0             	add    %rdx,%rax
    1bda:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1bde:	75 27                	jne    1c07 <free+0x113>
    1be0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1be4:	8b 50 08             	mov    0x8(%rax),%edx
    1be7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1beb:	8b 40 08             	mov    0x8(%rax),%eax
    1bee:	01 c2                	add    %eax,%edx
    1bf0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bf4:	89 50 08             	mov    %edx,0x8(%rax)
    1bf7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bfb:	48 8b 10             	mov    (%rax),%rdx
    1bfe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c02:	48 89 10             	mov    %rdx,(%rax)
    1c05:	eb 0b                	jmp    1c12 <free+0x11e>
    1c07:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c0b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1c0f:	48 89 10             	mov    %rdx,(%rax)
    1c12:	48 ba f0 1e 00 00 00 	movabs $0x1ef0,%rdx
    1c19:	00 00 00 
    1c1c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c20:	48 89 02             	mov    %rax,(%rdx)
    1c23:	90                   	nop
    1c24:	c9                   	leave
    1c25:	c3                   	ret

0000000000001c26 <morecore>:
    1c26:	55                   	push   %rbp
    1c27:	48 89 e5             	mov    %rsp,%rbp
    1c2a:	48 83 ec 20          	sub    $0x20,%rsp
    1c2e:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1c31:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1c38:	77 07                	ja     1c41 <morecore+0x1b>
    1c3a:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
    1c41:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1c44:	48 c1 e0 04          	shl    $0x4,%rax
    1c48:	48 89 c7             	mov    %rax,%rdi
    1c4b:	48 b8 bd 14 00 00 00 	movabs $0x14bd,%rax
    1c52:	00 00 00 
    1c55:	ff d0                	call   *%rax
    1c57:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1c5b:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1c60:	75 07                	jne    1c69 <morecore+0x43>
    1c62:	b8 00 00 00 00       	mov    $0x0,%eax
    1c67:	eb 36                	jmp    1c9f <morecore+0x79>
    1c69:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c6d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1c71:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c75:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1c78:	89 50 08             	mov    %edx,0x8(%rax)
    1c7b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c7f:	48 83 c0 10          	add    $0x10,%rax
    1c83:	48 89 c7             	mov    %rax,%rdi
    1c86:	48 b8 f4 1a 00 00 00 	movabs $0x1af4,%rax
    1c8d:	00 00 00 
    1c90:	ff d0                	call   *%rax
    1c92:	48 b8 f0 1e 00 00 00 	movabs $0x1ef0,%rax
    1c99:	00 00 00 
    1c9c:	48 8b 00             	mov    (%rax),%rax
    1c9f:	c9                   	leave
    1ca0:	c3                   	ret

0000000000001ca1 <malloc>:
    1ca1:	55                   	push   %rbp
    1ca2:	48 89 e5             	mov    %rsp,%rbp
    1ca5:	48 83 ec 30          	sub    $0x30,%rsp
    1ca9:	89 7d dc             	mov    %edi,-0x24(%rbp)
    1cac:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1caf:	48 83 c0 0f          	add    $0xf,%rax
    1cb3:	48 c1 e8 04          	shr    $0x4,%rax
    1cb7:	83 c0 01             	add    $0x1,%eax
    1cba:	89 45 ec             	mov    %eax,-0x14(%rbp)
    1cbd:	48 b8 f0 1e 00 00 00 	movabs $0x1ef0,%rax
    1cc4:	00 00 00 
    1cc7:	48 8b 00             	mov    (%rax),%rax
    1cca:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1cce:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1cd3:	75 4a                	jne    1d1f <malloc+0x7e>
    1cd5:	48 b8 e0 1e 00 00 00 	movabs $0x1ee0,%rax
    1cdc:	00 00 00 
    1cdf:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1ce3:	48 ba f0 1e 00 00 00 	movabs $0x1ef0,%rdx
    1cea:	00 00 00 
    1ced:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cf1:	48 89 02             	mov    %rax,(%rdx)
    1cf4:	48 b8 f0 1e 00 00 00 	movabs $0x1ef0,%rax
    1cfb:	00 00 00 
    1cfe:	48 8b 00             	mov    (%rax),%rax
    1d01:	48 ba e0 1e 00 00 00 	movabs $0x1ee0,%rdx
    1d08:	00 00 00 
    1d0b:	48 89 02             	mov    %rax,(%rdx)
    1d0e:	48 b8 e0 1e 00 00 00 	movabs $0x1ee0,%rax
    1d15:	00 00 00 
    1d18:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
    1d1f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d23:	48 8b 00             	mov    (%rax),%rax
    1d26:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1d2a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d2e:	8b 40 08             	mov    0x8(%rax),%eax
    1d31:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1d34:	72 65                	jb     1d9b <malloc+0xfa>
    1d36:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d3a:	8b 40 08             	mov    0x8(%rax),%eax
    1d3d:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1d40:	75 10                	jne    1d52 <malloc+0xb1>
    1d42:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d46:	48 8b 10             	mov    (%rax),%rdx
    1d49:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d4d:	48 89 10             	mov    %rdx,(%rax)
    1d50:	eb 2e                	jmp    1d80 <malloc+0xdf>
    1d52:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d56:	8b 40 08             	mov    0x8(%rax),%eax
    1d59:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1d5c:	89 c2                	mov    %eax,%edx
    1d5e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d62:	89 50 08             	mov    %edx,0x8(%rax)
    1d65:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d69:	8b 40 08             	mov    0x8(%rax),%eax
    1d6c:	89 c0                	mov    %eax,%eax
    1d6e:	48 c1 e0 04          	shl    $0x4,%rax
    1d72:	48 01 45 f8          	add    %rax,-0x8(%rbp)
    1d76:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d7a:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1d7d:	89 50 08             	mov    %edx,0x8(%rax)
    1d80:	48 ba f0 1e 00 00 00 	movabs $0x1ef0,%rdx
    1d87:	00 00 00 
    1d8a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d8e:	48 89 02             	mov    %rax,(%rdx)
    1d91:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d95:	48 83 c0 10          	add    $0x10,%rax
    1d99:	eb 4e                	jmp    1de9 <malloc+0x148>
    1d9b:	48 b8 f0 1e 00 00 00 	movabs $0x1ef0,%rax
    1da2:	00 00 00 
    1da5:	48 8b 00             	mov    (%rax),%rax
    1da8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1dac:	75 23                	jne    1dd1 <malloc+0x130>
    1dae:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1db1:	89 c7                	mov    %eax,%edi
    1db3:	48 b8 26 1c 00 00 00 	movabs $0x1c26,%rax
    1dba:	00 00 00 
    1dbd:	ff d0                	call   *%rax
    1dbf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1dc3:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1dc8:	75 07                	jne    1dd1 <malloc+0x130>
    1dca:	b8 00 00 00 00       	mov    $0x0,%eax
    1dcf:	eb 18                	jmp    1de9 <malloc+0x148>
    1dd1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1dd5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1dd9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ddd:	48 8b 00             	mov    (%rax),%rax
    1de0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1de4:	e9 41 ff ff ff       	jmp    1d2a <malloc+0x89>
    1de9:	c9                   	leave
    1dea:	c3                   	ret
