
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
    1019:	48 b8 08 1e 00 00 00 	movabs $0x1e08,%rax
    1020:	00 00 00 
    1023:	48 89 c6             	mov    %rax,%rsi
    1026:	bf 02 00 00 00       	mov    $0x2,%edi
    102b:	b8 00 00 00 00       	mov    $0x0,%eax
    1030:	48 ba f1 16 00 00 00 	movabs $0x16f1,%rdx
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
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    13d3:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    13da:	49 89 ca             	mov    %rcx,%r10
    13dd:	0f 05                	syscall
    13df:	c3                   	ret

00000000000013e0 <exit>:
SYSCALL(exit)
    13e0:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    13e7:	49 89 ca             	mov    %rcx,%r10
    13ea:	0f 05                	syscall
    13ec:	c3                   	ret

00000000000013ed <wait>:
SYSCALL(wait)
    13ed:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    13f4:	49 89 ca             	mov    %rcx,%r10
    13f7:	0f 05                	syscall
    13f9:	c3                   	ret

00000000000013fa <pipe>:
SYSCALL(pipe)
    13fa:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    1401:	49 89 ca             	mov    %rcx,%r10
    1404:	0f 05                	syscall
    1406:	c3                   	ret

0000000000001407 <read>:
SYSCALL(read)
    1407:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    140e:	49 89 ca             	mov    %rcx,%r10
    1411:	0f 05                	syscall
    1413:	c3                   	ret

0000000000001414 <write>:
SYSCALL(write)
    1414:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    141b:	49 89 ca             	mov    %rcx,%r10
    141e:	0f 05                	syscall
    1420:	c3                   	ret

0000000000001421 <close>:
SYSCALL(close)
    1421:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    1428:	49 89 ca             	mov    %rcx,%r10
    142b:	0f 05                	syscall
    142d:	c3                   	ret

000000000000142e <kill>:
SYSCALL(kill)
    142e:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    1435:	49 89 ca             	mov    %rcx,%r10
    1438:	0f 05                	syscall
    143a:	c3                   	ret

000000000000143b <exec>:
SYSCALL(exec)
    143b:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    1442:	49 89 ca             	mov    %rcx,%r10
    1445:	0f 05                	syscall
    1447:	c3                   	ret

0000000000001448 <open>:
SYSCALL(open)
    1448:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    144f:	49 89 ca             	mov    %rcx,%r10
    1452:	0f 05                	syscall
    1454:	c3                   	ret

0000000000001455 <mknod>:
SYSCALL(mknod)
    1455:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    145c:	49 89 ca             	mov    %rcx,%r10
    145f:	0f 05                	syscall
    1461:	c3                   	ret

0000000000001462 <unlink>:
SYSCALL(unlink)
    1462:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    1469:	49 89 ca             	mov    %rcx,%r10
    146c:	0f 05                	syscall
    146e:	c3                   	ret

000000000000146f <fstat>:
SYSCALL(fstat)
    146f:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    1476:	49 89 ca             	mov    %rcx,%r10
    1479:	0f 05                	syscall
    147b:	c3                   	ret

000000000000147c <link>:
SYSCALL(link)
    147c:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    1483:	49 89 ca             	mov    %rcx,%r10
    1486:	0f 05                	syscall
    1488:	c3                   	ret

0000000000001489 <mkdir>:
SYSCALL(mkdir)
    1489:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    1490:	49 89 ca             	mov    %rcx,%r10
    1493:	0f 05                	syscall
    1495:	c3                   	ret

0000000000001496 <chdir>:
SYSCALL(chdir)
    1496:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    149d:	49 89 ca             	mov    %rcx,%r10
    14a0:	0f 05                	syscall
    14a2:	c3                   	ret

00000000000014a3 <dup>:
SYSCALL(dup)
    14a3:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    14aa:	49 89 ca             	mov    %rcx,%r10
    14ad:	0f 05                	syscall
    14af:	c3                   	ret

00000000000014b0 <getpid>:
SYSCALL(getpid)
    14b0:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    14b7:	49 89 ca             	mov    %rcx,%r10
    14ba:	0f 05                	syscall
    14bc:	c3                   	ret

00000000000014bd <sbrk>:
SYSCALL(sbrk)
    14bd:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    14c4:	49 89 ca             	mov    %rcx,%r10
    14c7:	0f 05                	syscall
    14c9:	c3                   	ret

00000000000014ca <sleep>:
SYSCALL(sleep)
    14ca:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    14d1:	49 89 ca             	mov    %rcx,%r10
    14d4:	0f 05                	syscall
    14d6:	c3                   	ret

00000000000014d7 <uptime>:
SYSCALL(uptime)
    14d7:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    14de:	49 89 ca             	mov    %rcx,%r10
    14e1:	0f 05                	syscall
    14e3:	c3                   	ret

00000000000014e4 <send>:
SYSCALL(send)
    14e4:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    14eb:	49 89 ca             	mov    %rcx,%r10
    14ee:	0f 05                	syscall
    14f0:	c3                   	ret

00000000000014f1 <recv>:
SYSCALL(recv)
    14f1:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    14f8:	49 89 ca             	mov    %rcx,%r10
    14fb:	0f 05                	syscall
    14fd:	c3                   	ret

00000000000014fe <register_fsserver>:
SYSCALL(register_fsserver)
    14fe:	48 c7 c0 18 00 00 00 	mov    $0x18,%rax
    1505:	49 89 ca             	mov    %rcx,%r10
    1508:	0f 05                	syscall
    150a:	c3                   	ret

000000000000150b <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    150b:	f3 0f 1e fa          	endbr64
    150f:	55                   	push   %rbp
    1510:	48 89 e5             	mov    %rsp,%rbp
    1513:	48 83 ec 10          	sub    $0x10,%rsp
    1517:	89 7d fc             	mov    %edi,-0x4(%rbp)
    151a:	89 f0                	mov    %esi,%eax
    151c:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    151f:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    1523:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1526:	ba 01 00 00 00       	mov    $0x1,%edx
    152b:	48 89 ce             	mov    %rcx,%rsi
    152e:	89 c7                	mov    %eax,%edi
    1530:	48 b8 14 14 00 00 00 	movabs $0x1414,%rax
    1537:	00 00 00 
    153a:	ff d0                	call   *%rax
}
    153c:	90                   	nop
    153d:	c9                   	leave
    153e:	c3                   	ret

000000000000153f <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    153f:	f3 0f 1e fa          	endbr64
    1543:	55                   	push   %rbp
    1544:	48 89 e5             	mov    %rsp,%rbp
    1547:	48 83 ec 20          	sub    $0x20,%rsp
    154b:	89 7d ec             	mov    %edi,-0x14(%rbp)
    154e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1552:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1559:	eb 35                	jmp    1590 <print_x64+0x51>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    155b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    155f:	48 c1 e8 3c          	shr    $0x3c,%rax
    1563:	48 ba e0 1e 00 00 00 	movabs $0x1ee0,%rdx
    156a:	00 00 00 
    156d:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1571:	0f be d0             	movsbl %al,%edx
    1574:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1577:	89 d6                	mov    %edx,%esi
    1579:	89 c7                	mov    %eax,%edi
    157b:	48 b8 0b 15 00 00 00 	movabs $0x150b,%rax
    1582:	00 00 00 
    1585:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1587:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    158b:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    1590:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1593:	83 f8 0f             	cmp    $0xf,%eax
    1596:	76 c3                	jbe    155b <print_x64+0x1c>
}
    1598:	90                   	nop
    1599:	90                   	nop
    159a:	c9                   	leave
    159b:	c3                   	ret

000000000000159c <print_x32>:

  static void
print_x32(int fd, uint x)
{
    159c:	f3 0f 1e fa          	endbr64
    15a0:	55                   	push   %rbp
    15a1:	48 89 e5             	mov    %rsp,%rbp
    15a4:	48 83 ec 20          	sub    $0x20,%rsp
    15a8:	89 7d ec             	mov    %edi,-0x14(%rbp)
    15ab:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    15ae:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    15b5:	eb 36                	jmp    15ed <print_x32+0x51>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    15b7:	8b 45 e8             	mov    -0x18(%rbp),%eax
    15ba:	c1 e8 1c             	shr    $0x1c,%eax
    15bd:	89 c2                	mov    %eax,%edx
    15bf:	48 b8 e0 1e 00 00 00 	movabs $0x1ee0,%rax
    15c6:	00 00 00 
    15c9:	89 d2                	mov    %edx,%edx
    15cb:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    15cf:	0f be d0             	movsbl %al,%edx
    15d2:	8b 45 ec             	mov    -0x14(%rbp),%eax
    15d5:	89 d6                	mov    %edx,%esi
    15d7:	89 c7                	mov    %eax,%edi
    15d9:	48 b8 0b 15 00 00 00 	movabs $0x150b,%rax
    15e0:	00 00 00 
    15e3:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    15e5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    15e9:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    15ed:	8b 45 fc             	mov    -0x4(%rbp),%eax
    15f0:	83 f8 07             	cmp    $0x7,%eax
    15f3:	76 c2                	jbe    15b7 <print_x32+0x1b>
}
    15f5:	90                   	nop
    15f6:	90                   	nop
    15f7:	c9                   	leave
    15f8:	c3                   	ret

00000000000015f9 <print_d>:

  static void
print_d(int fd, int v)
{
    15f9:	f3 0f 1e fa          	endbr64
    15fd:	55                   	push   %rbp
    15fe:	48 89 e5             	mov    %rsp,%rbp
    1601:	48 83 ec 30          	sub    $0x30,%rsp
    1605:	89 7d dc             	mov    %edi,-0x24(%rbp)
    1608:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    160b:	8b 45 d8             	mov    -0x28(%rbp),%eax
    160e:	48 98                	cltq
    1610:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    1614:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1618:	79 04                	jns    161e <print_d+0x25>
    x = -x;
    161a:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    161e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    1625:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1629:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1630:	66 66 66 
    1633:	48 89 c8             	mov    %rcx,%rax
    1636:	48 f7 ea             	imul   %rdx
    1639:	48 c1 fa 02          	sar    $0x2,%rdx
    163d:	48 89 c8             	mov    %rcx,%rax
    1640:	48 c1 f8 3f          	sar    $0x3f,%rax
    1644:	48 29 c2             	sub    %rax,%rdx
    1647:	48 89 d0             	mov    %rdx,%rax
    164a:	48 c1 e0 02          	shl    $0x2,%rax
    164e:	48 01 d0             	add    %rdx,%rax
    1651:	48 01 c0             	add    %rax,%rax
    1654:	48 29 c1             	sub    %rax,%rcx
    1657:	48 89 ca             	mov    %rcx,%rdx
    165a:	8b 45 f4             	mov    -0xc(%rbp),%eax
    165d:	8d 48 01             	lea    0x1(%rax),%ecx
    1660:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    1663:	48 b9 e0 1e 00 00 00 	movabs $0x1ee0,%rcx
    166a:	00 00 00 
    166d:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    1671:	48 98                	cltq
    1673:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    1677:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    167b:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1682:	66 66 66 
    1685:	48 89 c8             	mov    %rcx,%rax
    1688:	48 f7 ea             	imul   %rdx
    168b:	48 89 d0             	mov    %rdx,%rax
    168e:	48 c1 f8 02          	sar    $0x2,%rax
    1692:	48 c1 f9 3f          	sar    $0x3f,%rcx
    1696:	48 89 ca             	mov    %rcx,%rdx
    1699:	48 29 d0             	sub    %rdx,%rax
    169c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    16a0:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    16a5:	0f 85 7a ff ff ff    	jne    1625 <print_d+0x2c>

  if (v < 0)
    16ab:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    16af:	79 32                	jns    16e3 <print_d+0xea>
    buf[i++] = '-';
    16b1:	8b 45 f4             	mov    -0xc(%rbp),%eax
    16b4:	8d 50 01             	lea    0x1(%rax),%edx
    16b7:	89 55 f4             	mov    %edx,-0xc(%rbp)
    16ba:	48 98                	cltq
    16bc:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    16c1:	eb 20                	jmp    16e3 <print_d+0xea>
    putc(fd, buf[i]);
    16c3:	8b 45 f4             	mov    -0xc(%rbp),%eax
    16c6:	48 98                	cltq
    16c8:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    16cd:	0f be d0             	movsbl %al,%edx
    16d0:	8b 45 dc             	mov    -0x24(%rbp),%eax
    16d3:	89 d6                	mov    %edx,%esi
    16d5:	89 c7                	mov    %eax,%edi
    16d7:	48 b8 0b 15 00 00 00 	movabs $0x150b,%rax
    16de:	00 00 00 
    16e1:	ff d0                	call   *%rax
  while (--i >= 0)
    16e3:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    16e7:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    16eb:	79 d6                	jns    16c3 <print_d+0xca>
}
    16ed:	90                   	nop
    16ee:	90                   	nop
    16ef:	c9                   	leave
    16f0:	c3                   	ret

00000000000016f1 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    16f1:	f3 0f 1e fa          	endbr64
    16f5:	55                   	push   %rbp
    16f6:	48 89 e5             	mov    %rsp,%rbp
    16f9:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    1700:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    1706:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    170d:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    1714:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    171b:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    1722:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    1729:	84 c0                	test   %al,%al
    172b:	74 20                	je     174d <printf+0x5c>
    172d:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    1731:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    1735:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    1739:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    173d:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    1741:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    1745:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    1749:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    174d:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    1754:	00 00 00 
    1757:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    175e:	00 00 00 
    1761:	48 8d 45 10          	lea    0x10(%rbp),%rax
    1765:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    176c:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    1773:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    177a:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    1781:	00 00 00 
    1784:	e9 41 03 00 00       	jmp    1aca <printf+0x3d9>
    if (c != '%') {
    1789:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1790:	74 24                	je     17b6 <printf+0xc5>
      putc(fd, c);
    1792:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1798:	0f be d0             	movsbl %al,%edx
    179b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    17a1:	89 d6                	mov    %edx,%esi
    17a3:	89 c7                	mov    %eax,%edi
    17a5:	48 b8 0b 15 00 00 00 	movabs $0x150b,%rax
    17ac:	00 00 00 
    17af:	ff d0                	call   *%rax
      continue;
    17b1:	e9 0d 03 00 00       	jmp    1ac3 <printf+0x3d2>
    }
    c = fmt[++i] & 0xff;
    17b6:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    17bd:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    17c3:	48 63 d0             	movslq %eax,%rdx
    17c6:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    17cd:	48 01 d0             	add    %rdx,%rax
    17d0:	0f b6 00             	movzbl (%rax),%eax
    17d3:	0f be c0             	movsbl %al,%eax
    17d6:	25 ff 00 00 00       	and    $0xff,%eax
    17db:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    17e1:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    17e8:	0f 84 0f 03 00 00    	je     1afd <printf+0x40c>
      break;
    switch(c) {
    17ee:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    17f5:	0f 84 74 02 00 00    	je     1a6f <printf+0x37e>
    17fb:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1802:	0f 8c 82 02 00 00    	jl     1a8a <printf+0x399>
    1808:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    180f:	0f 8f 75 02 00 00    	jg     1a8a <printf+0x399>
    1815:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    181c:	0f 8c 68 02 00 00    	jl     1a8a <printf+0x399>
    1822:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1828:	83 e8 63             	sub    $0x63,%eax
    182b:	83 f8 15             	cmp    $0x15,%eax
    182e:	0f 87 56 02 00 00    	ja     1a8a <printf+0x399>
    1834:	89 c0                	mov    %eax,%eax
    1836:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    183d:	00 
    183e:	48 b8 28 1e 00 00 00 	movabs $0x1e28,%rax
    1845:	00 00 00 
    1848:	48 01 d0             	add    %rdx,%rax
    184b:	48 8b 00             	mov    (%rax),%rax
    184e:	3e ff e0             	notrack jmp *%rax
    case 'c':
      putc(fd, va_arg(ap, int));
    1851:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1857:	83 f8 2f             	cmp    $0x2f,%eax
    185a:	77 23                	ja     187f <printf+0x18e>
    185c:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1863:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1869:	89 d2                	mov    %edx,%edx
    186b:	48 01 d0             	add    %rdx,%rax
    186e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1874:	83 c2 08             	add    $0x8,%edx
    1877:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    187d:	eb 12                	jmp    1891 <printf+0x1a0>
    187f:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1886:	48 8d 50 08          	lea    0x8(%rax),%rdx
    188a:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1891:	8b 00                	mov    (%rax),%eax
    1893:	0f be d0             	movsbl %al,%edx
    1896:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    189c:	89 d6                	mov    %edx,%esi
    189e:	89 c7                	mov    %eax,%edi
    18a0:	48 b8 0b 15 00 00 00 	movabs $0x150b,%rax
    18a7:	00 00 00 
    18aa:	ff d0                	call   *%rax
      break;
    18ac:	e9 12 02 00 00       	jmp    1ac3 <printf+0x3d2>
    case 'd':
      print_d(fd, va_arg(ap, int));
    18b1:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    18b7:	83 f8 2f             	cmp    $0x2f,%eax
    18ba:	77 23                	ja     18df <printf+0x1ee>
    18bc:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    18c3:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18c9:	89 d2                	mov    %edx,%edx
    18cb:	48 01 d0             	add    %rdx,%rax
    18ce:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18d4:	83 c2 08             	add    $0x8,%edx
    18d7:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    18dd:	eb 12                	jmp    18f1 <printf+0x200>
    18df:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    18e6:	48 8d 50 08          	lea    0x8(%rax),%rdx
    18ea:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    18f1:	8b 10                	mov    (%rax),%edx
    18f3:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    18f9:	89 d6                	mov    %edx,%esi
    18fb:	89 c7                	mov    %eax,%edi
    18fd:	48 b8 f9 15 00 00 00 	movabs $0x15f9,%rax
    1904:	00 00 00 
    1907:	ff d0                	call   *%rax
      break;
    1909:	e9 b5 01 00 00       	jmp    1ac3 <printf+0x3d2>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    190e:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1914:	83 f8 2f             	cmp    $0x2f,%eax
    1917:	77 23                	ja     193c <printf+0x24b>
    1919:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1920:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1926:	89 d2                	mov    %edx,%edx
    1928:	48 01 d0             	add    %rdx,%rax
    192b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1931:	83 c2 08             	add    $0x8,%edx
    1934:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    193a:	eb 12                	jmp    194e <printf+0x25d>
    193c:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1943:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1947:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    194e:	8b 10                	mov    (%rax),%edx
    1950:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1956:	89 d6                	mov    %edx,%esi
    1958:	89 c7                	mov    %eax,%edi
    195a:	48 b8 9c 15 00 00 00 	movabs $0x159c,%rax
    1961:	00 00 00 
    1964:	ff d0                	call   *%rax
      break;
    1966:	e9 58 01 00 00       	jmp    1ac3 <printf+0x3d2>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    196b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1971:	83 f8 2f             	cmp    $0x2f,%eax
    1974:	77 23                	ja     1999 <printf+0x2a8>
    1976:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    197d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1983:	89 d2                	mov    %edx,%edx
    1985:	48 01 d0             	add    %rdx,%rax
    1988:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    198e:	83 c2 08             	add    $0x8,%edx
    1991:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1997:	eb 12                	jmp    19ab <printf+0x2ba>
    1999:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    19a0:	48 8d 50 08          	lea    0x8(%rax),%rdx
    19a4:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    19ab:	48 8b 10             	mov    (%rax),%rdx
    19ae:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    19b4:	48 89 d6             	mov    %rdx,%rsi
    19b7:	89 c7                	mov    %eax,%edi
    19b9:	48 b8 3f 15 00 00 00 	movabs $0x153f,%rax
    19c0:	00 00 00 
    19c3:	ff d0                	call   *%rax
      break;
    19c5:	e9 f9 00 00 00       	jmp    1ac3 <printf+0x3d2>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    19ca:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    19d0:	83 f8 2f             	cmp    $0x2f,%eax
    19d3:	77 23                	ja     19f8 <printf+0x307>
    19d5:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    19dc:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19e2:	89 d2                	mov    %edx,%edx
    19e4:	48 01 d0             	add    %rdx,%rax
    19e7:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19ed:	83 c2 08             	add    $0x8,%edx
    19f0:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    19f6:	eb 12                	jmp    1a0a <printf+0x319>
    19f8:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    19ff:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a03:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a0a:	48 8b 00             	mov    (%rax),%rax
    1a0d:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    1a14:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1a1b:	00 
    1a1c:	75 41                	jne    1a5f <printf+0x36e>
        s = "(null)";
    1a1e:	48 b8 20 1e 00 00 00 	movabs $0x1e20,%rax
    1a25:	00 00 00 
    1a28:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1a2f:	eb 2e                	jmp    1a5f <printf+0x36e>
        putc(fd, *(s++));
    1a31:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1a38:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1a3c:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1a43:	0f b6 00             	movzbl (%rax),%eax
    1a46:	0f be d0             	movsbl %al,%edx
    1a49:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a4f:	89 d6                	mov    %edx,%esi
    1a51:	89 c7                	mov    %eax,%edi
    1a53:	48 b8 0b 15 00 00 00 	movabs $0x150b,%rax
    1a5a:	00 00 00 
    1a5d:	ff d0                	call   *%rax
      while (*s)
    1a5f:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1a66:	0f b6 00             	movzbl (%rax),%eax
    1a69:	84 c0                	test   %al,%al
    1a6b:	75 c4                	jne    1a31 <printf+0x340>
      break;
    1a6d:	eb 54                	jmp    1ac3 <printf+0x3d2>
    case '%':
      putc(fd, '%');
    1a6f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a75:	be 25 00 00 00       	mov    $0x25,%esi
    1a7a:	89 c7                	mov    %eax,%edi
    1a7c:	48 b8 0b 15 00 00 00 	movabs $0x150b,%rax
    1a83:	00 00 00 
    1a86:	ff d0                	call   *%rax
      break;
    1a88:	eb 39                	jmp    1ac3 <printf+0x3d2>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1a8a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a90:	be 25 00 00 00       	mov    $0x25,%esi
    1a95:	89 c7                	mov    %eax,%edi
    1a97:	48 b8 0b 15 00 00 00 	movabs $0x150b,%rax
    1a9e:	00 00 00 
    1aa1:	ff d0                	call   *%rax
      putc(fd, c);
    1aa3:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1aa9:	0f be d0             	movsbl %al,%edx
    1aac:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1ab2:	89 d6                	mov    %edx,%esi
    1ab4:	89 c7                	mov    %eax,%edi
    1ab6:	48 b8 0b 15 00 00 00 	movabs $0x150b,%rax
    1abd:	00 00 00 
    1ac0:	ff d0                	call   *%rax
      break;
    1ac2:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1ac3:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1aca:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1ad0:	48 63 d0             	movslq %eax,%rdx
    1ad3:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1ada:	48 01 d0             	add    %rdx,%rax
    1add:	0f b6 00             	movzbl (%rax),%eax
    1ae0:	0f be c0             	movsbl %al,%eax
    1ae3:	25 ff 00 00 00       	and    $0xff,%eax
    1ae8:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1aee:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1af5:	0f 85 8e fc ff ff    	jne    1789 <printf+0x98>
    }
  }
}
    1afb:	eb 01                	jmp    1afe <printf+0x40d>
      break;
    1afd:	90                   	nop
}
    1afe:	90                   	nop
    1aff:	c9                   	leave
    1b00:	c3                   	ret

0000000000001b01 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1b01:	f3 0f 1e fa          	endbr64
    1b05:	55                   	push   %rbp
    1b06:	48 89 e5             	mov    %rsp,%rbp
    1b09:	48 83 ec 18          	sub    $0x18,%rsp
    1b0d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1b11:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1b15:	48 83 e8 10          	sub    $0x10,%rax
    1b19:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1b1d:	48 b8 10 1f 00 00 00 	movabs $0x1f10,%rax
    1b24:	00 00 00 
    1b27:	48 8b 00             	mov    (%rax),%rax
    1b2a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1b2e:	eb 2f                	jmp    1b5f <free+0x5e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1b30:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b34:	48 8b 00             	mov    (%rax),%rax
    1b37:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b3b:	72 17                	jb     1b54 <free+0x53>
    1b3d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b41:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b45:	72 2f                	jb     1b76 <free+0x75>
    1b47:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b4b:	48 8b 00             	mov    (%rax),%rax
    1b4e:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1b52:	72 22                	jb     1b76 <free+0x75>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1b54:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b58:	48 8b 00             	mov    (%rax),%rax
    1b5b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1b5f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b63:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b67:	73 c7                	jae    1b30 <free+0x2f>
    1b69:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b6d:	48 8b 00             	mov    (%rax),%rax
    1b70:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1b74:	73 ba                	jae    1b30 <free+0x2f>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1b76:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b7a:	8b 40 08             	mov    0x8(%rax),%eax
    1b7d:	89 c0                	mov    %eax,%eax
    1b7f:	48 c1 e0 04          	shl    $0x4,%rax
    1b83:	48 89 c2             	mov    %rax,%rdx
    1b86:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b8a:	48 01 c2             	add    %rax,%rdx
    1b8d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b91:	48 8b 00             	mov    (%rax),%rax
    1b94:	48 39 c2             	cmp    %rax,%rdx
    1b97:	75 2d                	jne    1bc6 <free+0xc5>
    bp->s.size += p->s.ptr->s.size;
    1b99:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b9d:	8b 50 08             	mov    0x8(%rax),%edx
    1ba0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ba4:	48 8b 00             	mov    (%rax),%rax
    1ba7:	8b 40 08             	mov    0x8(%rax),%eax
    1baa:	01 c2                	add    %eax,%edx
    1bac:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bb0:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1bb3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bb7:	48 8b 00             	mov    (%rax),%rax
    1bba:	48 8b 10             	mov    (%rax),%rdx
    1bbd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bc1:	48 89 10             	mov    %rdx,(%rax)
    1bc4:	eb 0e                	jmp    1bd4 <free+0xd3>
  } else
    bp->s.ptr = p->s.ptr;
    1bc6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bca:	48 8b 10             	mov    (%rax),%rdx
    1bcd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bd1:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    1bd4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bd8:	8b 40 08             	mov    0x8(%rax),%eax
    1bdb:	89 c0                	mov    %eax,%eax
    1bdd:	48 c1 e0 04          	shl    $0x4,%rax
    1be1:	48 89 c2             	mov    %rax,%rdx
    1be4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1be8:	48 01 d0             	add    %rdx,%rax
    1beb:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1bef:	75 27                	jne    1c18 <free+0x117>
    p->s.size += bp->s.size;
    1bf1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bf5:	8b 50 08             	mov    0x8(%rax),%edx
    1bf8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bfc:	8b 40 08             	mov    0x8(%rax),%eax
    1bff:	01 c2                	add    %eax,%edx
    1c01:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c05:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    1c08:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c0c:	48 8b 10             	mov    (%rax),%rdx
    1c0f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c13:	48 89 10             	mov    %rdx,(%rax)
    1c16:	eb 0b                	jmp    1c23 <free+0x122>
  } else
    p->s.ptr = bp;
    1c18:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c1c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1c20:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    1c23:	48 ba 10 1f 00 00 00 	movabs $0x1f10,%rdx
    1c2a:	00 00 00 
    1c2d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c31:	48 89 02             	mov    %rax,(%rdx)
}
    1c34:	90                   	nop
    1c35:	c9                   	leave
    1c36:	c3                   	ret

0000000000001c37 <morecore>:

static Header*
morecore(uint nu)
{
    1c37:	f3 0f 1e fa          	endbr64
    1c3b:	55                   	push   %rbp
    1c3c:	48 89 e5             	mov    %rsp,%rbp
    1c3f:	48 83 ec 20          	sub    $0x20,%rsp
    1c43:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    1c46:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1c4d:	77 07                	ja     1c56 <morecore+0x1f>
    nu = 4096;
    1c4f:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    1c56:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1c59:	48 c1 e0 04          	shl    $0x4,%rax
    1c5d:	48 89 c7             	mov    %rax,%rdi
    1c60:	48 b8 bd 14 00 00 00 	movabs $0x14bd,%rax
    1c67:	00 00 00 
    1c6a:	ff d0                	call   *%rax
    1c6c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    1c70:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1c75:	75 07                	jne    1c7e <morecore+0x47>
    return 0;
    1c77:	b8 00 00 00 00       	mov    $0x0,%eax
    1c7c:	eb 36                	jmp    1cb4 <morecore+0x7d>
  hp = (Header*)p;
    1c7e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c82:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    1c86:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c8a:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1c8d:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    1c90:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c94:	48 83 c0 10          	add    $0x10,%rax
    1c98:	48 89 c7             	mov    %rax,%rdi
    1c9b:	48 b8 01 1b 00 00 00 	movabs $0x1b01,%rax
    1ca2:	00 00 00 
    1ca5:	ff d0                	call   *%rax
  return freep;
    1ca7:	48 b8 10 1f 00 00 00 	movabs $0x1f10,%rax
    1cae:	00 00 00 
    1cb1:	48 8b 00             	mov    (%rax),%rax
}
    1cb4:	c9                   	leave
    1cb5:	c3                   	ret

0000000000001cb6 <malloc>:

void*
malloc(uint nbytes)
{
    1cb6:	f3 0f 1e fa          	endbr64
    1cba:	55                   	push   %rbp
    1cbb:	48 89 e5             	mov    %rsp,%rbp
    1cbe:	48 83 ec 30          	sub    $0x30,%rsp
    1cc2:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1cc5:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1cc8:	48 83 c0 0f          	add    $0xf,%rax
    1ccc:	48 c1 e8 04          	shr    $0x4,%rax
    1cd0:	83 c0 01             	add    $0x1,%eax
    1cd3:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    1cd6:	48 b8 10 1f 00 00 00 	movabs $0x1f10,%rax
    1cdd:	00 00 00 
    1ce0:	48 8b 00             	mov    (%rax),%rax
    1ce3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1ce7:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1cec:	75 4a                	jne    1d38 <malloc+0x82>
    base.s.ptr = freep = prevp = &base;
    1cee:	48 b8 00 1f 00 00 00 	movabs $0x1f00,%rax
    1cf5:	00 00 00 
    1cf8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1cfc:	48 ba 10 1f 00 00 00 	movabs $0x1f10,%rdx
    1d03:	00 00 00 
    1d06:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d0a:	48 89 02             	mov    %rax,(%rdx)
    1d0d:	48 b8 10 1f 00 00 00 	movabs $0x1f10,%rax
    1d14:	00 00 00 
    1d17:	48 8b 00             	mov    (%rax),%rax
    1d1a:	48 ba 00 1f 00 00 00 	movabs $0x1f00,%rdx
    1d21:	00 00 00 
    1d24:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    1d27:	48 b8 00 1f 00 00 00 	movabs $0x1f00,%rax
    1d2e:	00 00 00 
    1d31:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1d38:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d3c:	48 8b 00             	mov    (%rax),%rax
    1d3f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1d43:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d47:	8b 40 08             	mov    0x8(%rax),%eax
    1d4a:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1d4d:	72 65                	jb     1db4 <malloc+0xfe>
      if(p->s.size == nunits)
    1d4f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d53:	8b 40 08             	mov    0x8(%rax),%eax
    1d56:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1d59:	75 10                	jne    1d6b <malloc+0xb5>
        prevp->s.ptr = p->s.ptr;
    1d5b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d5f:	48 8b 10             	mov    (%rax),%rdx
    1d62:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d66:	48 89 10             	mov    %rdx,(%rax)
    1d69:	eb 2e                	jmp    1d99 <malloc+0xe3>
      else {
        p->s.size -= nunits;
    1d6b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d6f:	8b 40 08             	mov    0x8(%rax),%eax
    1d72:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1d75:	89 c2                	mov    %eax,%edx
    1d77:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d7b:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    1d7e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d82:	8b 40 08             	mov    0x8(%rax),%eax
    1d85:	89 c0                	mov    %eax,%eax
    1d87:	48 c1 e0 04          	shl    $0x4,%rax
    1d8b:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    1d8f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d93:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1d96:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    1d99:	48 ba 10 1f 00 00 00 	movabs $0x1f10,%rdx
    1da0:	00 00 00 
    1da3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1da7:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    1daa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1dae:	48 83 c0 10          	add    $0x10,%rax
    1db2:	eb 4e                	jmp    1e02 <malloc+0x14c>
    }
    if(p == freep)
    1db4:	48 b8 10 1f 00 00 00 	movabs $0x1f10,%rax
    1dbb:	00 00 00 
    1dbe:	48 8b 00             	mov    (%rax),%rax
    1dc1:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1dc5:	75 23                	jne    1dea <malloc+0x134>
      if((p = morecore(nunits)) == 0)
    1dc7:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1dca:	89 c7                	mov    %eax,%edi
    1dcc:	48 b8 37 1c 00 00 00 	movabs $0x1c37,%rax
    1dd3:	00 00 00 
    1dd6:	ff d0                	call   *%rax
    1dd8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1ddc:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1de1:	75 07                	jne    1dea <malloc+0x134>
        return 0;
    1de3:	b8 00 00 00 00       	mov    $0x0,%eax
    1de8:	eb 18                	jmp    1e02 <malloc+0x14c>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1dea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1dee:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1df2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1df6:	48 8b 00             	mov    (%rax),%rax
    1df9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1dfd:	e9 41 ff ff ff       	jmp    1d43 <malloc+0x8d>
  }
}
    1e02:	c9                   	leave
    1e03:	c3                   	ret
