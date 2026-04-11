
_cat:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <cat>:

char buf[512];

void
cat(int fd)
{
    1000:	55                   	push   %rbp
    1001:	48 89 e5             	mov    %rsp,%rbp
    1004:	48 83 ec 20          	sub    $0x20,%rsp
    1008:	89 7d ec             	mov    %edi,-0x14(%rbp)
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
    100b:	eb 57                	jmp    1064 <cat+0x64>
    if (write(1, buf, n) != n) {
    100d:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1010:	48 b9 60 1f 00 00 00 	movabs $0x1f60,%rcx
    1017:	00 00 00 
    101a:	89 c2                	mov    %eax,%edx
    101c:	48 89 ce             	mov    %rcx,%rsi
    101f:	bf 01 00 00 00       	mov    $0x1,%edi
    1024:	48 b8 14 15 00 00 00 	movabs $0x1514,%rax
    102b:	00 00 00 
    102e:	ff d0                	call   *%rax
    1030:	39 45 fc             	cmp    %eax,-0x4(%rbp)
    1033:	74 2f                	je     1064 <cat+0x64>
      printf(1, "cat: write error\n");
    1035:	48 b8 f6 1e 00 00 00 	movabs $0x1ef6,%rax
    103c:	00 00 00 
    103f:	48 89 c6             	mov    %rax,%rsi
    1042:	bf 01 00 00 00       	mov    $0x1,%edi
    1047:	b8 00 00 00 00       	mov    $0x0,%eax
    104c:	48 ba d4 17 00 00 00 	movabs $0x17d4,%rdx
    1053:	00 00 00 
    1056:	ff d2                	call   *%rdx
      exit();
    1058:	48 b8 e0 14 00 00 00 	movabs $0x14e0,%rax
    105f:	00 00 00 
    1062:	ff d0                	call   *%rax
  while((n = read(fd, buf, sizeof(buf))) > 0) {
    1064:	48 b9 60 1f 00 00 00 	movabs $0x1f60,%rcx
    106b:	00 00 00 
    106e:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1071:	ba 00 02 00 00       	mov    $0x200,%edx
    1076:	48 89 ce             	mov    %rcx,%rsi
    1079:	89 c7                	mov    %eax,%edi
    107b:	48 b8 07 15 00 00 00 	movabs $0x1507,%rax
    1082:	00 00 00 
    1085:	ff d0                	call   *%rax
    1087:	89 45 fc             	mov    %eax,-0x4(%rbp)
    108a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    108e:	0f 8f 79 ff ff ff    	jg     100d <cat+0xd>
    }
  }
  if(n < 0){
    1094:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1098:	79 2f                	jns    10c9 <cat+0xc9>
    printf(1, "cat: read error\n");
    109a:	48 b8 08 1f 00 00 00 	movabs $0x1f08,%rax
    10a1:	00 00 00 
    10a4:	48 89 c6             	mov    %rax,%rsi
    10a7:	bf 01 00 00 00       	mov    $0x1,%edi
    10ac:	b8 00 00 00 00       	mov    $0x0,%eax
    10b1:	48 ba d4 17 00 00 00 	movabs $0x17d4,%rdx
    10b8:	00 00 00 
    10bb:	ff d2                	call   *%rdx
    exit();
    10bd:	48 b8 e0 14 00 00 00 	movabs $0x14e0,%rax
    10c4:	00 00 00 
    10c7:	ff d0                	call   *%rax
  }
}
    10c9:	90                   	nop
    10ca:	c9                   	leave
    10cb:	c3                   	ret

00000000000010cc <main>:

int
main(int argc, char *argv[])
{
    10cc:	55                   	push   %rbp
    10cd:	48 89 e5             	mov    %rsp,%rbp
    10d0:	48 83 ec 20          	sub    $0x20,%rsp
    10d4:	89 7d ec             	mov    %edi,-0x14(%rbp)
    10d7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd, i;

  if(argc <= 1){
    10db:	83 7d ec 01          	cmpl   $0x1,-0x14(%rbp)
    10df:	7f 1d                	jg     10fe <main+0x32>
    cat(0);
    10e1:	bf 00 00 00 00       	mov    $0x0,%edi
    10e6:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    10ed:	00 00 00 
    10f0:	ff d0                	call   *%rax
    exit();
    10f2:	48 b8 e0 14 00 00 00 	movabs $0x14e0,%rax
    10f9:	00 00 00 
    10fc:	ff d0                	call   *%rax
  }

  for(i = 1; i < argc; i++){
    10fe:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
    1105:	e9 a3 00 00 00       	jmp    11ad <main+0xe1>
    if((fd = open(argv[i], 0)) < 0){
    110a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    110d:	48 98                	cltq
    110f:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1116:	00 
    1117:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    111b:	48 01 d0             	add    %rdx,%rax
    111e:	48 8b 00             	mov    (%rax),%rax
    1121:	be 00 00 00 00       	mov    $0x0,%esi
    1126:	48 89 c7             	mov    %rax,%rdi
    1129:	48 b8 48 15 00 00 00 	movabs $0x1548,%rax
    1130:	00 00 00 
    1133:	ff d0                	call   *%rax
    1135:	89 45 f8             	mov    %eax,-0x8(%rbp)
    1138:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    113c:	79 49                	jns    1187 <main+0xbb>
      printf(1, "cat: cannot open %s\n", argv[i]);
    113e:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1141:	48 98                	cltq
    1143:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    114a:	00 
    114b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    114f:	48 01 d0             	add    %rdx,%rax
    1152:	48 8b 00             	mov    (%rax),%rax
    1155:	48 b9 19 1f 00 00 00 	movabs $0x1f19,%rcx
    115c:	00 00 00 
    115f:	48 89 c2             	mov    %rax,%rdx
    1162:	48 89 ce             	mov    %rcx,%rsi
    1165:	bf 01 00 00 00       	mov    $0x1,%edi
    116a:	b8 00 00 00 00       	mov    $0x0,%eax
    116f:	48 b9 d4 17 00 00 00 	movabs $0x17d4,%rcx
    1176:	00 00 00 
    1179:	ff d1                	call   *%rcx
      exit();
    117b:	48 b8 e0 14 00 00 00 	movabs $0x14e0,%rax
    1182:	00 00 00 
    1185:	ff d0                	call   *%rax
    }
    cat(fd);
    1187:	8b 45 f8             	mov    -0x8(%rbp),%eax
    118a:	89 c7                	mov    %eax,%edi
    118c:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1193:	00 00 00 
    1196:	ff d0                	call   *%rax
    close(fd);
    1198:	8b 45 f8             	mov    -0x8(%rbp),%eax
    119b:	89 c7                	mov    %eax,%edi
    119d:	48 b8 21 15 00 00 00 	movabs $0x1521,%rax
    11a4:	00 00 00 
    11a7:	ff d0                	call   *%rax
  for(i = 1; i < argc; i++){
    11a9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    11ad:	8b 45 fc             	mov    -0x4(%rbp),%eax
    11b0:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    11b3:	0f 8c 51 ff ff ff    	jl     110a <main+0x3e>
  }
  exit();
    11b9:	48 b8 e0 14 00 00 00 	movabs $0x14e0,%rax
    11c0:	00 00 00 
    11c3:	ff d0                	call   *%rax

00000000000011c5 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    11c5:	55                   	push   %rbp
    11c6:	48 89 e5             	mov    %rsp,%rbp
    11c9:	48 83 ec 10          	sub    $0x10,%rsp
    11cd:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    11d1:	89 75 f4             	mov    %esi,-0xc(%rbp)
    11d4:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
    11d7:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    11db:	8b 55 f0             	mov    -0x10(%rbp),%edx
    11de:	8b 45 f4             	mov    -0xc(%rbp),%eax
    11e1:	48 89 ce             	mov    %rcx,%rsi
    11e4:	48 89 f7             	mov    %rsi,%rdi
    11e7:	89 d1                	mov    %edx,%ecx
    11e9:	fc                   	cld
    11ea:	f3 aa                	rep stos %al,(%rdi)
    11ec:	89 ca                	mov    %ecx,%edx
    11ee:	48 89 fe             	mov    %rdi,%rsi
    11f1:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    11f5:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    11f8:	90                   	nop
    11f9:	c9                   	leave
    11fa:	c3                   	ret

00000000000011fb <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    11fb:	55                   	push   %rbp
    11fc:	48 89 e5             	mov    %rsp,%rbp
    11ff:	48 83 ec 20          	sub    $0x20,%rsp
    1203:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1207:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
    120b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    120f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    1213:	90                   	nop
    1214:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1218:	48 8d 42 01          	lea    0x1(%rdx),%rax
    121c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    1220:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1224:	48 8d 48 01          	lea    0x1(%rax),%rcx
    1228:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    122c:	0f b6 12             	movzbl (%rdx),%edx
    122f:	88 10                	mov    %dl,(%rax)
    1231:	0f b6 00             	movzbl (%rax),%eax
    1234:	84 c0                	test   %al,%al
    1236:	75 dc                	jne    1214 <strcpy+0x19>
    ;
  return os;
    1238:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    123c:	c9                   	leave
    123d:	c3                   	ret

000000000000123e <strcmp>:

int
strcmp(const char *p, const char *q)
{
    123e:	55                   	push   %rbp
    123f:	48 89 e5             	mov    %rsp,%rbp
    1242:	48 83 ec 10          	sub    $0x10,%rsp
    1246:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    124a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    124e:	eb 0a                	jmp    125a <strcmp+0x1c>
    p++, q++;
    1250:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1255:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    125a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    125e:	0f b6 00             	movzbl (%rax),%eax
    1261:	84 c0                	test   %al,%al
    1263:	74 12                	je     1277 <strcmp+0x39>
    1265:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1269:	0f b6 10             	movzbl (%rax),%edx
    126c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1270:	0f b6 00             	movzbl (%rax),%eax
    1273:	38 c2                	cmp    %al,%dl
    1275:	74 d9                	je     1250 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
    1277:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    127b:	0f b6 00             	movzbl (%rax),%eax
    127e:	0f b6 d0             	movzbl %al,%edx
    1281:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1285:	0f b6 00             	movzbl (%rax),%eax
    1288:	0f b6 c0             	movzbl %al,%eax
    128b:	29 c2                	sub    %eax,%edx
    128d:	89 d0                	mov    %edx,%eax
}
    128f:	c9                   	leave
    1290:	c3                   	ret

0000000000001291 <strlen>:

uint
strlen(char *s)
{
    1291:	55                   	push   %rbp
    1292:	48 89 e5             	mov    %rsp,%rbp
    1295:	48 83 ec 18          	sub    $0x18,%rsp
    1299:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
    129d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    12a4:	eb 04                	jmp    12aa <strlen+0x19>
    12a6:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    12aa:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12ad:	48 63 d0             	movslq %eax,%rdx
    12b0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12b4:	48 01 d0             	add    %rdx,%rax
    12b7:	0f b6 00             	movzbl (%rax),%eax
    12ba:	84 c0                	test   %al,%al
    12bc:	75 e8                	jne    12a6 <strlen+0x15>
    ;
  return n;
    12be:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    12c1:	c9                   	leave
    12c2:	c3                   	ret

00000000000012c3 <memset>:

void*
memset(void *dst, int c, uint n)
{
    12c3:	55                   	push   %rbp
    12c4:	48 89 e5             	mov    %rsp,%rbp
    12c7:	48 83 ec 10          	sub    $0x10,%rsp
    12cb:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    12cf:	89 75 f4             	mov    %esi,-0xc(%rbp)
    12d2:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    12d5:	8b 55 f0             	mov    -0x10(%rbp),%edx
    12d8:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    12db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    12df:	89 ce                	mov    %ecx,%esi
    12e1:	48 89 c7             	mov    %rax,%rdi
    12e4:	48 b8 c5 11 00 00 00 	movabs $0x11c5,%rax
    12eb:	00 00 00 
    12ee:	ff d0                	call   *%rax
  return dst;
    12f0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    12f4:	c9                   	leave
    12f5:	c3                   	ret

00000000000012f6 <strchr>:

char*
strchr(const char *s, char c)
{
    12f6:	55                   	push   %rbp
    12f7:	48 89 e5             	mov    %rsp,%rbp
    12fa:	48 83 ec 10          	sub    $0x10,%rsp
    12fe:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1302:	89 f0                	mov    %esi,%eax
    1304:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    1307:	eb 17                	jmp    1320 <strchr+0x2a>
    if(*s == c)
    1309:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    130d:	0f b6 00             	movzbl (%rax),%eax
    1310:	38 45 f4             	cmp    %al,-0xc(%rbp)
    1313:	75 06                	jne    131b <strchr+0x25>
      return (char*)s;
    1315:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1319:	eb 15                	jmp    1330 <strchr+0x3a>
  for(; *s; s++)
    131b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1320:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1324:	0f b6 00             	movzbl (%rax),%eax
    1327:	84 c0                	test   %al,%al
    1329:	75 de                	jne    1309 <strchr+0x13>
  return 0;
    132b:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1330:	c9                   	leave
    1331:	c3                   	ret

0000000000001332 <gets>:

char*
gets(char *buf, int max)
{
    1332:	55                   	push   %rbp
    1333:	48 89 e5             	mov    %rsp,%rbp
    1336:	48 83 ec 20          	sub    $0x20,%rsp
    133a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    133e:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1341:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1348:	eb 4f                	jmp    1399 <gets+0x67>
    cc = read(0, &c, 1);
    134a:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    134e:	ba 01 00 00 00       	mov    $0x1,%edx
    1353:	48 89 c6             	mov    %rax,%rsi
    1356:	bf 00 00 00 00       	mov    $0x0,%edi
    135b:	48 b8 07 15 00 00 00 	movabs $0x1507,%rax
    1362:	00 00 00 
    1365:	ff d0                	call   *%rax
    1367:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    136a:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    136e:	7e 36                	jle    13a6 <gets+0x74>
      break;
    buf[i++] = c;
    1370:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1373:	8d 50 01             	lea    0x1(%rax),%edx
    1376:	89 55 fc             	mov    %edx,-0x4(%rbp)
    1379:	48 63 d0             	movslq %eax,%rdx
    137c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1380:	48 01 c2             	add    %rax,%rdx
    1383:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1387:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    1389:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    138d:	3c 0a                	cmp    $0xa,%al
    138f:	74 16                	je     13a7 <gets+0x75>
    1391:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1395:	3c 0d                	cmp    $0xd,%al
    1397:	74 0e                	je     13a7 <gets+0x75>
  for(i=0; i+1 < max; ){
    1399:	8b 45 fc             	mov    -0x4(%rbp),%eax
    139c:	83 c0 01             	add    $0x1,%eax
    139f:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    13a2:	7f a6                	jg     134a <gets+0x18>
    13a4:	eb 01                	jmp    13a7 <gets+0x75>
      break;
    13a6:	90                   	nop
      break;
  }
  buf[i] = '\0';
    13a7:	8b 45 fc             	mov    -0x4(%rbp),%eax
    13aa:	48 63 d0             	movslq %eax,%rdx
    13ad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    13b1:	48 01 d0             	add    %rdx,%rax
    13b4:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    13b7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    13bb:	c9                   	leave
    13bc:	c3                   	ret

00000000000013bd <stat>:

int
stat(char *n, struct stat *st)
{
    13bd:	55                   	push   %rbp
    13be:	48 89 e5             	mov    %rsp,%rbp
    13c1:	48 83 ec 20          	sub    $0x20,%rsp
    13c5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    13c9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    13cd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    13d1:	be 00 00 00 00       	mov    $0x0,%esi
    13d6:	48 89 c7             	mov    %rax,%rdi
    13d9:	48 b8 48 15 00 00 00 	movabs $0x1548,%rax
    13e0:	00 00 00 
    13e3:	ff d0                	call   *%rax
    13e5:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    13e8:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    13ec:	79 07                	jns    13f5 <stat+0x38>
    return -1;
    13ee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    13f3:	eb 2f                	jmp    1424 <stat+0x67>
  r = fstat(fd, st);
    13f5:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    13f9:	8b 45 fc             	mov    -0x4(%rbp),%eax
    13fc:	48 89 d6             	mov    %rdx,%rsi
    13ff:	89 c7                	mov    %eax,%edi
    1401:	48 b8 6f 15 00 00 00 	movabs $0x156f,%rax
    1408:	00 00 00 
    140b:	ff d0                	call   *%rax
    140d:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    1410:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1413:	89 c7                	mov    %eax,%edi
    1415:	48 b8 21 15 00 00 00 	movabs $0x1521,%rax
    141c:	00 00 00 
    141f:	ff d0                	call   *%rax
  return r;
    1421:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    1424:	c9                   	leave
    1425:	c3                   	ret

0000000000001426 <atoi>:

int
atoi(const char *s)
{
    1426:	55                   	push   %rbp
    1427:	48 89 e5             	mov    %rsp,%rbp
    142a:	48 83 ec 18          	sub    $0x18,%rsp
    142e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    1432:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1439:	eb 28                	jmp    1463 <atoi+0x3d>
    n = n*10 + *s++ - '0';
    143b:	8b 55 fc             	mov    -0x4(%rbp),%edx
    143e:	89 d0                	mov    %edx,%eax
    1440:	c1 e0 02             	shl    $0x2,%eax
    1443:	01 d0                	add    %edx,%eax
    1445:	01 c0                	add    %eax,%eax
    1447:	89 c1                	mov    %eax,%ecx
    1449:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    144d:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1451:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    1455:	0f b6 00             	movzbl (%rax),%eax
    1458:	0f be c0             	movsbl %al,%eax
    145b:	01 c8                	add    %ecx,%eax
    145d:	83 e8 30             	sub    $0x30,%eax
    1460:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1463:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1467:	0f b6 00             	movzbl (%rax),%eax
    146a:	3c 2f                	cmp    $0x2f,%al
    146c:	7e 0b                	jle    1479 <atoi+0x53>
    146e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1472:	0f b6 00             	movzbl (%rax),%eax
    1475:	3c 39                	cmp    $0x39,%al
    1477:	7e c2                	jle    143b <atoi+0x15>
  return n;
    1479:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    147c:	c9                   	leave
    147d:	c3                   	ret

000000000000147e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    147e:	55                   	push   %rbp
    147f:	48 89 e5             	mov    %rsp,%rbp
    1482:	48 83 ec 28          	sub    $0x28,%rsp
    1486:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    148a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    148e:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    1491:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1495:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    1499:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    149d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    14a1:	eb 1d                	jmp    14c0 <memmove+0x42>
    *dst++ = *src++;
    14a3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    14a7:	48 8d 42 01          	lea    0x1(%rdx),%rax
    14ab:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    14af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    14b3:	48 8d 48 01          	lea    0x1(%rax),%rcx
    14b7:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    14bb:	0f b6 12             	movzbl (%rdx),%edx
    14be:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    14c0:	8b 45 dc             	mov    -0x24(%rbp),%eax
    14c3:	8d 50 ff             	lea    -0x1(%rax),%edx
    14c6:	89 55 dc             	mov    %edx,-0x24(%rbp)
    14c9:	85 c0                	test   %eax,%eax
    14cb:	7f d6                	jg     14a3 <memmove+0x25>
  return vdst;
    14cd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    14d1:	c9                   	leave
    14d2:	c3                   	ret

00000000000014d3 <fork>:
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    14d3:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    14da:	49 89 ca             	mov    %rcx,%r10
    14dd:	0f 05                	syscall
    14df:	c3                   	ret

00000000000014e0 <exit>:
SYSCALL(exit)
    14e0:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    14e7:	49 89 ca             	mov    %rcx,%r10
    14ea:	0f 05                	syscall
    14ec:	c3                   	ret

00000000000014ed <wait>:
SYSCALL(wait)
    14ed:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    14f4:	49 89 ca             	mov    %rcx,%r10
    14f7:	0f 05                	syscall
    14f9:	c3                   	ret

00000000000014fa <pipe>:
SYSCALL(pipe)
    14fa:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    1501:	49 89 ca             	mov    %rcx,%r10
    1504:	0f 05                	syscall
    1506:	c3                   	ret

0000000000001507 <read>:
SYSCALL(read)
    1507:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    150e:	49 89 ca             	mov    %rcx,%r10
    1511:	0f 05                	syscall
    1513:	c3                   	ret

0000000000001514 <write>:
SYSCALL(write)
    1514:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    151b:	49 89 ca             	mov    %rcx,%r10
    151e:	0f 05                	syscall
    1520:	c3                   	ret

0000000000001521 <close>:
SYSCALL(close)
    1521:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    1528:	49 89 ca             	mov    %rcx,%r10
    152b:	0f 05                	syscall
    152d:	c3                   	ret

000000000000152e <kill>:
SYSCALL(kill)
    152e:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    1535:	49 89 ca             	mov    %rcx,%r10
    1538:	0f 05                	syscall
    153a:	c3                   	ret

000000000000153b <exec>:
SYSCALL(exec)
    153b:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    1542:	49 89 ca             	mov    %rcx,%r10
    1545:	0f 05                	syscall
    1547:	c3                   	ret

0000000000001548 <open>:
SYSCALL(open)
    1548:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    154f:	49 89 ca             	mov    %rcx,%r10
    1552:	0f 05                	syscall
    1554:	c3                   	ret

0000000000001555 <mknod>:
SYSCALL(mknod)
    1555:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    155c:	49 89 ca             	mov    %rcx,%r10
    155f:	0f 05                	syscall
    1561:	c3                   	ret

0000000000001562 <unlink>:
SYSCALL(unlink)
    1562:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    1569:	49 89 ca             	mov    %rcx,%r10
    156c:	0f 05                	syscall
    156e:	c3                   	ret

000000000000156f <fstat>:
SYSCALL(fstat)
    156f:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    1576:	49 89 ca             	mov    %rcx,%r10
    1579:	0f 05                	syscall
    157b:	c3                   	ret

000000000000157c <link>:
SYSCALL(link)
    157c:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    1583:	49 89 ca             	mov    %rcx,%r10
    1586:	0f 05                	syscall
    1588:	c3                   	ret

0000000000001589 <mkdir>:
SYSCALL(mkdir)
    1589:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    1590:	49 89 ca             	mov    %rcx,%r10
    1593:	0f 05                	syscall
    1595:	c3                   	ret

0000000000001596 <chdir>:
SYSCALL(chdir)
    1596:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    159d:	49 89 ca             	mov    %rcx,%r10
    15a0:	0f 05                	syscall
    15a2:	c3                   	ret

00000000000015a3 <dup>:
SYSCALL(dup)
    15a3:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    15aa:	49 89 ca             	mov    %rcx,%r10
    15ad:	0f 05                	syscall
    15af:	c3                   	ret

00000000000015b0 <getpid>:
SYSCALL(getpid)
    15b0:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    15b7:	49 89 ca             	mov    %rcx,%r10
    15ba:	0f 05                	syscall
    15bc:	c3                   	ret

00000000000015bd <sbrk>:
SYSCALL(sbrk)
    15bd:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    15c4:	49 89 ca             	mov    %rcx,%r10
    15c7:	0f 05                	syscall
    15c9:	c3                   	ret

00000000000015ca <sleep>:
SYSCALL(sleep)
    15ca:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    15d1:	49 89 ca             	mov    %rcx,%r10
    15d4:	0f 05                	syscall
    15d6:	c3                   	ret

00000000000015d7 <uptime>:
SYSCALL(uptime)
    15d7:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    15de:	49 89 ca             	mov    %rcx,%r10
    15e1:	0f 05                	syscall
    15e3:	c3                   	ret

00000000000015e4 <send>:
SYSCALL(send)
    15e4:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    15eb:	49 89 ca             	mov    %rcx,%r10
    15ee:	0f 05                	syscall
    15f0:	c3                   	ret

00000000000015f1 <recv>:
SYSCALL(recv)
    15f1:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    15f8:	49 89 ca             	mov    %rcx,%r10
    15fb:	0f 05                	syscall
    15fd:	c3                   	ret

00000000000015fe <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    15fe:	55                   	push   %rbp
    15ff:	48 89 e5             	mov    %rsp,%rbp
    1602:	48 83 ec 10          	sub    $0x10,%rsp
    1606:	89 7d fc             	mov    %edi,-0x4(%rbp)
    1609:	89 f0                	mov    %esi,%eax
    160b:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    160e:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    1612:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1615:	ba 01 00 00 00       	mov    $0x1,%edx
    161a:	48 89 ce             	mov    %rcx,%rsi
    161d:	89 c7                	mov    %eax,%edi
    161f:	48 b8 14 15 00 00 00 	movabs $0x1514,%rax
    1626:	00 00 00 
    1629:	ff d0                	call   *%rax
}
    162b:	90                   	nop
    162c:	c9                   	leave
    162d:	c3                   	ret

000000000000162e <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    162e:	55                   	push   %rbp
    162f:	48 89 e5             	mov    %rsp,%rbp
    1632:	48 83 ec 20          	sub    $0x20,%rsp
    1636:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1639:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    163d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1644:	eb 35                	jmp    167b <print_x64+0x4d>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    1646:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    164a:	48 c1 e8 3c          	shr    $0x3c,%rax
    164e:	48 ba 40 1f 00 00 00 	movabs $0x1f40,%rdx
    1655:	00 00 00 
    1658:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    165c:	0f be d0             	movsbl %al,%edx
    165f:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1662:	89 d6                	mov    %edx,%esi
    1664:	89 c7                	mov    %eax,%edi
    1666:	48 b8 fe 15 00 00 00 	movabs $0x15fe,%rax
    166d:	00 00 00 
    1670:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1672:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1676:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    167b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    167e:	83 f8 0f             	cmp    $0xf,%eax
    1681:	76 c3                	jbe    1646 <print_x64+0x18>
}
    1683:	90                   	nop
    1684:	90                   	nop
    1685:	c9                   	leave
    1686:	c3                   	ret

0000000000001687 <print_x32>:

  static void
print_x32(int fd, uint x)
{
    1687:	55                   	push   %rbp
    1688:	48 89 e5             	mov    %rsp,%rbp
    168b:	48 83 ec 20          	sub    $0x20,%rsp
    168f:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1692:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1695:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    169c:	eb 36                	jmp    16d4 <print_x32+0x4d>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    169e:	8b 45 e8             	mov    -0x18(%rbp),%eax
    16a1:	c1 e8 1c             	shr    $0x1c,%eax
    16a4:	89 c2                	mov    %eax,%edx
    16a6:	48 b8 40 1f 00 00 00 	movabs $0x1f40,%rax
    16ad:	00 00 00 
    16b0:	89 d2                	mov    %edx,%edx
    16b2:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    16b6:	0f be d0             	movsbl %al,%edx
    16b9:	8b 45 ec             	mov    -0x14(%rbp),%eax
    16bc:	89 d6                	mov    %edx,%esi
    16be:	89 c7                	mov    %eax,%edi
    16c0:	48 b8 fe 15 00 00 00 	movabs $0x15fe,%rax
    16c7:	00 00 00 
    16ca:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    16cc:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    16d0:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    16d4:	8b 45 fc             	mov    -0x4(%rbp),%eax
    16d7:	83 f8 07             	cmp    $0x7,%eax
    16da:	76 c2                	jbe    169e <print_x32+0x17>
}
    16dc:	90                   	nop
    16dd:	90                   	nop
    16de:	c9                   	leave
    16df:	c3                   	ret

00000000000016e0 <print_d>:

  static void
print_d(int fd, int v)
{
    16e0:	55                   	push   %rbp
    16e1:	48 89 e5             	mov    %rsp,%rbp
    16e4:	48 83 ec 30          	sub    $0x30,%rsp
    16e8:	89 7d dc             	mov    %edi,-0x24(%rbp)
    16eb:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    16ee:	8b 45 d8             	mov    -0x28(%rbp),%eax
    16f1:	48 98                	cltq
    16f3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    16f7:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    16fb:	79 04                	jns    1701 <print_d+0x21>
    x = -x;
    16fd:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    1701:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    1708:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    170c:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1713:	66 66 66 
    1716:	48 89 c8             	mov    %rcx,%rax
    1719:	48 f7 ea             	imul   %rdx
    171c:	48 c1 fa 02          	sar    $0x2,%rdx
    1720:	48 89 c8             	mov    %rcx,%rax
    1723:	48 c1 f8 3f          	sar    $0x3f,%rax
    1727:	48 29 c2             	sub    %rax,%rdx
    172a:	48 89 d0             	mov    %rdx,%rax
    172d:	48 c1 e0 02          	shl    $0x2,%rax
    1731:	48 01 d0             	add    %rdx,%rax
    1734:	48 01 c0             	add    %rax,%rax
    1737:	48 29 c1             	sub    %rax,%rcx
    173a:	48 89 ca             	mov    %rcx,%rdx
    173d:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1740:	8d 48 01             	lea    0x1(%rax),%ecx
    1743:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    1746:	48 b9 40 1f 00 00 00 	movabs $0x1f40,%rcx
    174d:	00 00 00 
    1750:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    1754:	48 98                	cltq
    1756:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    175a:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    175e:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1765:	66 66 66 
    1768:	48 89 c8             	mov    %rcx,%rax
    176b:	48 f7 ea             	imul   %rdx
    176e:	48 89 d0             	mov    %rdx,%rax
    1771:	48 c1 f8 02          	sar    $0x2,%rax
    1775:	48 c1 f9 3f          	sar    $0x3f,%rcx
    1779:	48 89 ca             	mov    %rcx,%rdx
    177c:	48 29 d0             	sub    %rdx,%rax
    177f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    1783:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1788:	0f 85 7a ff ff ff    	jne    1708 <print_d+0x28>

  if (v < 0)
    178e:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1792:	79 32                	jns    17c6 <print_d+0xe6>
    buf[i++] = '-';
    1794:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1797:	8d 50 01             	lea    0x1(%rax),%edx
    179a:	89 55 f4             	mov    %edx,-0xc(%rbp)
    179d:	48 98                	cltq
    179f:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    17a4:	eb 20                	jmp    17c6 <print_d+0xe6>
    putc(fd, buf[i]);
    17a6:	8b 45 f4             	mov    -0xc(%rbp),%eax
    17a9:	48 98                	cltq
    17ab:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    17b0:	0f be d0             	movsbl %al,%edx
    17b3:	8b 45 dc             	mov    -0x24(%rbp),%eax
    17b6:	89 d6                	mov    %edx,%esi
    17b8:	89 c7                	mov    %eax,%edi
    17ba:	48 b8 fe 15 00 00 00 	movabs $0x15fe,%rax
    17c1:	00 00 00 
    17c4:	ff d0                	call   *%rax
  while (--i >= 0)
    17c6:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    17ca:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    17ce:	79 d6                	jns    17a6 <print_d+0xc6>
}
    17d0:	90                   	nop
    17d1:	90                   	nop
    17d2:	c9                   	leave
    17d3:	c3                   	ret

00000000000017d4 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    17d4:	55                   	push   %rbp
    17d5:	48 89 e5             	mov    %rsp,%rbp
    17d8:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    17df:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    17e5:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    17ec:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    17f3:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    17fa:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    1801:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    1808:	84 c0                	test   %al,%al
    180a:	74 20                	je     182c <printf+0x58>
    180c:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    1810:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    1814:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    1818:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    181c:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    1820:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    1824:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    1828:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    182c:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    1833:	00 00 00 
    1836:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    183d:	00 00 00 
    1840:	48 8d 45 10          	lea    0x10(%rbp),%rax
    1844:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    184b:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    1852:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1859:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    1860:	00 00 00 
    1863:	e9 60 03 00 00       	jmp    1bc8 <printf+0x3f4>
    if (c != '%') {
    1868:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    186f:	74 24                	je     1895 <printf+0xc1>
      putc(fd, c);
    1871:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1877:	0f be d0             	movsbl %al,%edx
    187a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1880:	89 d6                	mov    %edx,%esi
    1882:	89 c7                	mov    %eax,%edi
    1884:	48 b8 fe 15 00 00 00 	movabs $0x15fe,%rax
    188b:	00 00 00 
    188e:	ff d0                	call   *%rax
      continue;
    1890:	e9 2c 03 00 00       	jmp    1bc1 <printf+0x3ed>
    }
    c = fmt[++i] & 0xff;
    1895:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    189c:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    18a2:	48 63 d0             	movslq %eax,%rdx
    18a5:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    18ac:	48 01 d0             	add    %rdx,%rax
    18af:	0f b6 00             	movzbl (%rax),%eax
    18b2:	0f be c0             	movsbl %al,%eax
    18b5:	25 ff 00 00 00       	and    $0xff,%eax
    18ba:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    18c0:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    18c7:	0f 84 2e 03 00 00    	je     1bfb <printf+0x427>
      break;
    switch(c) {
    18cd:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    18d4:	0f 84 32 01 00 00    	je     1a0c <printf+0x238>
    18da:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    18e1:	0f 8f a1 02 00 00    	jg     1b88 <printf+0x3b4>
    18e7:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    18ee:	0f 84 d4 01 00 00    	je     1ac8 <printf+0x2f4>
    18f4:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    18fb:	0f 8f 87 02 00 00    	jg     1b88 <printf+0x3b4>
    1901:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    1908:	0f 84 5b 01 00 00    	je     1a69 <printf+0x295>
    190e:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    1915:	0f 8f 6d 02 00 00    	jg     1b88 <printf+0x3b4>
    191b:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    1922:	0f 84 87 00 00 00    	je     19af <printf+0x1db>
    1928:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    192f:	0f 8f 53 02 00 00    	jg     1b88 <printf+0x3b4>
    1935:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    193c:	0f 84 2b 02 00 00    	je     1b6d <printf+0x399>
    1942:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    1949:	0f 85 39 02 00 00    	jne    1b88 <printf+0x3b4>
    case 'c':
      putc(fd, va_arg(ap, int));
    194f:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1955:	83 f8 2f             	cmp    $0x2f,%eax
    1958:	77 23                	ja     197d <printf+0x1a9>
    195a:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1961:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1967:	89 d2                	mov    %edx,%edx
    1969:	48 01 d0             	add    %rdx,%rax
    196c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1972:	83 c2 08             	add    $0x8,%edx
    1975:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    197b:	eb 12                	jmp    198f <printf+0x1bb>
    197d:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1984:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1988:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    198f:	8b 00                	mov    (%rax),%eax
    1991:	0f be d0             	movsbl %al,%edx
    1994:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    199a:	89 d6                	mov    %edx,%esi
    199c:	89 c7                	mov    %eax,%edi
    199e:	48 b8 fe 15 00 00 00 	movabs $0x15fe,%rax
    19a5:	00 00 00 
    19a8:	ff d0                	call   *%rax
      break;
    19aa:	e9 12 02 00 00       	jmp    1bc1 <printf+0x3ed>
    case 'd':
      print_d(fd, va_arg(ap, int));
    19af:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    19b5:	83 f8 2f             	cmp    $0x2f,%eax
    19b8:	77 23                	ja     19dd <printf+0x209>
    19ba:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    19c1:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19c7:	89 d2                	mov    %edx,%edx
    19c9:	48 01 d0             	add    %rdx,%rax
    19cc:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19d2:	83 c2 08             	add    $0x8,%edx
    19d5:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    19db:	eb 12                	jmp    19ef <printf+0x21b>
    19dd:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    19e4:	48 8d 50 08          	lea    0x8(%rax),%rdx
    19e8:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    19ef:	8b 10                	mov    (%rax),%edx
    19f1:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    19f7:	89 d6                	mov    %edx,%esi
    19f9:	89 c7                	mov    %eax,%edi
    19fb:	48 b8 e0 16 00 00 00 	movabs $0x16e0,%rax
    1a02:	00 00 00 
    1a05:	ff d0                	call   *%rax
      break;
    1a07:	e9 b5 01 00 00       	jmp    1bc1 <printf+0x3ed>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    1a0c:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1a12:	83 f8 2f             	cmp    $0x2f,%eax
    1a15:	77 23                	ja     1a3a <printf+0x266>
    1a17:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1a1e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a24:	89 d2                	mov    %edx,%edx
    1a26:	48 01 d0             	add    %rdx,%rax
    1a29:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a2f:	83 c2 08             	add    $0x8,%edx
    1a32:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1a38:	eb 12                	jmp    1a4c <printf+0x278>
    1a3a:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a41:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a45:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a4c:	8b 10                	mov    (%rax),%edx
    1a4e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a54:	89 d6                	mov    %edx,%esi
    1a56:	89 c7                	mov    %eax,%edi
    1a58:	48 b8 87 16 00 00 00 	movabs $0x1687,%rax
    1a5f:	00 00 00 
    1a62:	ff d0                	call   *%rax
      break;
    1a64:	e9 58 01 00 00       	jmp    1bc1 <printf+0x3ed>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    1a69:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1a6f:	83 f8 2f             	cmp    $0x2f,%eax
    1a72:	77 23                	ja     1a97 <printf+0x2c3>
    1a74:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1a7b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a81:	89 d2                	mov    %edx,%edx
    1a83:	48 01 d0             	add    %rdx,%rax
    1a86:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a8c:	83 c2 08             	add    $0x8,%edx
    1a8f:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1a95:	eb 12                	jmp    1aa9 <printf+0x2d5>
    1a97:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a9e:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1aa2:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1aa9:	48 8b 10             	mov    (%rax),%rdx
    1aac:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1ab2:	48 89 d6             	mov    %rdx,%rsi
    1ab5:	89 c7                	mov    %eax,%edi
    1ab7:	48 b8 2e 16 00 00 00 	movabs $0x162e,%rax
    1abe:	00 00 00 
    1ac1:	ff d0                	call   *%rax
      break;
    1ac3:	e9 f9 00 00 00       	jmp    1bc1 <printf+0x3ed>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    1ac8:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1ace:	83 f8 2f             	cmp    $0x2f,%eax
    1ad1:	77 23                	ja     1af6 <printf+0x322>
    1ad3:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1ada:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1ae0:	89 d2                	mov    %edx,%edx
    1ae2:	48 01 d0             	add    %rdx,%rax
    1ae5:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1aeb:	83 c2 08             	add    $0x8,%edx
    1aee:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1af4:	eb 12                	jmp    1b08 <printf+0x334>
    1af6:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1afd:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1b01:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1b08:	48 8b 00             	mov    (%rax),%rax
    1b0b:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    1b12:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1b19:	00 
    1b1a:	75 41                	jne    1b5d <printf+0x389>
        s = "(null)";
    1b1c:	48 b8 2e 1f 00 00 00 	movabs $0x1f2e,%rax
    1b23:	00 00 00 
    1b26:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1b2d:	eb 2e                	jmp    1b5d <printf+0x389>
        putc(fd, *(s++));
    1b2f:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1b36:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1b3a:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1b41:	0f b6 00             	movzbl (%rax),%eax
    1b44:	0f be d0             	movsbl %al,%edx
    1b47:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b4d:	89 d6                	mov    %edx,%esi
    1b4f:	89 c7                	mov    %eax,%edi
    1b51:	48 b8 fe 15 00 00 00 	movabs $0x15fe,%rax
    1b58:	00 00 00 
    1b5b:	ff d0                	call   *%rax
      while (*s)
    1b5d:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1b64:	0f b6 00             	movzbl (%rax),%eax
    1b67:	84 c0                	test   %al,%al
    1b69:	75 c4                	jne    1b2f <printf+0x35b>
      break;
    1b6b:	eb 54                	jmp    1bc1 <printf+0x3ed>
    case '%':
      putc(fd, '%');
    1b6d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b73:	be 25 00 00 00       	mov    $0x25,%esi
    1b78:	89 c7                	mov    %eax,%edi
    1b7a:	48 b8 fe 15 00 00 00 	movabs $0x15fe,%rax
    1b81:	00 00 00 
    1b84:	ff d0                	call   *%rax
      break;
    1b86:	eb 39                	jmp    1bc1 <printf+0x3ed>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1b88:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b8e:	be 25 00 00 00       	mov    $0x25,%esi
    1b93:	89 c7                	mov    %eax,%edi
    1b95:	48 b8 fe 15 00 00 00 	movabs $0x15fe,%rax
    1b9c:	00 00 00 
    1b9f:	ff d0                	call   *%rax
      putc(fd, c);
    1ba1:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1ba7:	0f be d0             	movsbl %al,%edx
    1baa:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1bb0:	89 d6                	mov    %edx,%esi
    1bb2:	89 c7                	mov    %eax,%edi
    1bb4:	48 b8 fe 15 00 00 00 	movabs $0x15fe,%rax
    1bbb:	00 00 00 
    1bbe:	ff d0                	call   *%rax
      break;
    1bc0:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1bc1:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1bc8:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1bce:	48 63 d0             	movslq %eax,%rdx
    1bd1:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1bd8:	48 01 d0             	add    %rdx,%rax
    1bdb:	0f b6 00             	movzbl (%rax),%eax
    1bde:	0f be c0             	movsbl %al,%eax
    1be1:	25 ff 00 00 00       	and    $0xff,%eax
    1be6:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1bec:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1bf3:	0f 85 6f fc ff ff    	jne    1868 <printf+0x94>
    }
  }
}
    1bf9:	eb 01                	jmp    1bfc <printf+0x428>
      break;
    1bfb:	90                   	nop
}
    1bfc:	90                   	nop
    1bfd:	c9                   	leave
    1bfe:	c3                   	ret

0000000000001bff <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1bff:	55                   	push   %rbp
    1c00:	48 89 e5             	mov    %rsp,%rbp
    1c03:	48 83 ec 18          	sub    $0x18,%rsp
    1c07:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1c0b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1c0f:	48 83 e8 10          	sub    $0x10,%rax
    1c13:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1c17:	48 b8 70 21 00 00 00 	movabs $0x2170,%rax
    1c1e:	00 00 00 
    1c21:	48 8b 00             	mov    (%rax),%rax
    1c24:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1c28:	eb 2f                	jmp    1c59 <free+0x5a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1c2a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c2e:	48 8b 00             	mov    (%rax),%rax
    1c31:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1c35:	72 17                	jb     1c4e <free+0x4f>
    1c37:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c3b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1c3f:	72 2f                	jb     1c70 <free+0x71>
    1c41:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c45:	48 8b 00             	mov    (%rax),%rax
    1c48:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1c4c:	72 22                	jb     1c70 <free+0x71>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1c4e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c52:	48 8b 00             	mov    (%rax),%rax
    1c55:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1c59:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c5d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1c61:	73 c7                	jae    1c2a <free+0x2b>
    1c63:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c67:	48 8b 00             	mov    (%rax),%rax
    1c6a:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1c6e:	73 ba                	jae    1c2a <free+0x2b>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1c70:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c74:	8b 40 08             	mov    0x8(%rax),%eax
    1c77:	89 c0                	mov    %eax,%eax
    1c79:	48 c1 e0 04          	shl    $0x4,%rax
    1c7d:	48 89 c2             	mov    %rax,%rdx
    1c80:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c84:	48 01 c2             	add    %rax,%rdx
    1c87:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c8b:	48 8b 00             	mov    (%rax),%rax
    1c8e:	48 39 c2             	cmp    %rax,%rdx
    1c91:	75 2d                	jne    1cc0 <free+0xc1>
    bp->s.size += p->s.ptr->s.size;
    1c93:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c97:	8b 50 08             	mov    0x8(%rax),%edx
    1c9a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c9e:	48 8b 00             	mov    (%rax),%rax
    1ca1:	8b 40 08             	mov    0x8(%rax),%eax
    1ca4:	01 c2                	add    %eax,%edx
    1ca6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1caa:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1cad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cb1:	48 8b 00             	mov    (%rax),%rax
    1cb4:	48 8b 10             	mov    (%rax),%rdx
    1cb7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cbb:	48 89 10             	mov    %rdx,(%rax)
    1cbe:	eb 0e                	jmp    1cce <free+0xcf>
  } else
    bp->s.ptr = p->s.ptr;
    1cc0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cc4:	48 8b 10             	mov    (%rax),%rdx
    1cc7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ccb:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    1cce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cd2:	8b 40 08             	mov    0x8(%rax),%eax
    1cd5:	89 c0                	mov    %eax,%eax
    1cd7:	48 c1 e0 04          	shl    $0x4,%rax
    1cdb:	48 89 c2             	mov    %rax,%rdx
    1cde:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ce2:	48 01 d0             	add    %rdx,%rax
    1ce5:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1ce9:	75 27                	jne    1d12 <free+0x113>
    p->s.size += bp->s.size;
    1ceb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cef:	8b 50 08             	mov    0x8(%rax),%edx
    1cf2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cf6:	8b 40 08             	mov    0x8(%rax),%eax
    1cf9:	01 c2                	add    %eax,%edx
    1cfb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cff:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    1d02:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d06:	48 8b 10             	mov    (%rax),%rdx
    1d09:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d0d:	48 89 10             	mov    %rdx,(%rax)
    1d10:	eb 0b                	jmp    1d1d <free+0x11e>
  } else
    p->s.ptr = bp;
    1d12:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d16:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1d1a:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    1d1d:	48 ba 70 21 00 00 00 	movabs $0x2170,%rdx
    1d24:	00 00 00 
    1d27:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d2b:	48 89 02             	mov    %rax,(%rdx)
}
    1d2e:	90                   	nop
    1d2f:	c9                   	leave
    1d30:	c3                   	ret

0000000000001d31 <morecore>:

static Header*
morecore(uint nu)
{
    1d31:	55                   	push   %rbp
    1d32:	48 89 e5             	mov    %rsp,%rbp
    1d35:	48 83 ec 20          	sub    $0x20,%rsp
    1d39:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    1d3c:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1d43:	77 07                	ja     1d4c <morecore+0x1b>
    nu = 4096;
    1d45:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    1d4c:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1d4f:	48 c1 e0 04          	shl    $0x4,%rax
    1d53:	48 89 c7             	mov    %rax,%rdi
    1d56:	48 b8 bd 15 00 00 00 	movabs $0x15bd,%rax
    1d5d:	00 00 00 
    1d60:	ff d0                	call   *%rax
    1d62:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    1d66:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1d6b:	75 07                	jne    1d74 <morecore+0x43>
    return 0;
    1d6d:	b8 00 00 00 00       	mov    $0x0,%eax
    1d72:	eb 36                	jmp    1daa <morecore+0x79>
  hp = (Header*)p;
    1d74:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d78:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    1d7c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d80:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1d83:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    1d86:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d8a:	48 83 c0 10          	add    $0x10,%rax
    1d8e:	48 89 c7             	mov    %rax,%rdi
    1d91:	48 b8 ff 1b 00 00 00 	movabs $0x1bff,%rax
    1d98:	00 00 00 
    1d9b:	ff d0                	call   *%rax
  return freep;
    1d9d:	48 b8 70 21 00 00 00 	movabs $0x2170,%rax
    1da4:	00 00 00 
    1da7:	48 8b 00             	mov    (%rax),%rax
}
    1daa:	c9                   	leave
    1dab:	c3                   	ret

0000000000001dac <malloc>:

void*
malloc(uint nbytes)
{
    1dac:	55                   	push   %rbp
    1dad:	48 89 e5             	mov    %rsp,%rbp
    1db0:	48 83 ec 30          	sub    $0x30,%rsp
    1db4:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1db7:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1dba:	48 83 c0 0f          	add    $0xf,%rax
    1dbe:	48 c1 e8 04          	shr    $0x4,%rax
    1dc2:	83 c0 01             	add    $0x1,%eax
    1dc5:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    1dc8:	48 b8 70 21 00 00 00 	movabs $0x2170,%rax
    1dcf:	00 00 00 
    1dd2:	48 8b 00             	mov    (%rax),%rax
    1dd5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1dd9:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1dde:	75 4a                	jne    1e2a <malloc+0x7e>
    base.s.ptr = freep = prevp = &base;
    1de0:	48 b8 60 21 00 00 00 	movabs $0x2160,%rax
    1de7:	00 00 00 
    1dea:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1dee:	48 ba 70 21 00 00 00 	movabs $0x2170,%rdx
    1df5:	00 00 00 
    1df8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1dfc:	48 89 02             	mov    %rax,(%rdx)
    1dff:	48 b8 70 21 00 00 00 	movabs $0x2170,%rax
    1e06:	00 00 00 
    1e09:	48 8b 00             	mov    (%rax),%rax
    1e0c:	48 ba 60 21 00 00 00 	movabs $0x2160,%rdx
    1e13:	00 00 00 
    1e16:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    1e19:	48 b8 60 21 00 00 00 	movabs $0x2160,%rax
    1e20:	00 00 00 
    1e23:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1e2a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e2e:	48 8b 00             	mov    (%rax),%rax
    1e31:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1e35:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e39:	8b 40 08             	mov    0x8(%rax),%eax
    1e3c:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1e3f:	72 65                	jb     1ea6 <malloc+0xfa>
      if(p->s.size == nunits)
    1e41:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e45:	8b 40 08             	mov    0x8(%rax),%eax
    1e48:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1e4b:	75 10                	jne    1e5d <malloc+0xb1>
        prevp->s.ptr = p->s.ptr;
    1e4d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e51:	48 8b 10             	mov    (%rax),%rdx
    1e54:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e58:	48 89 10             	mov    %rdx,(%rax)
    1e5b:	eb 2e                	jmp    1e8b <malloc+0xdf>
      else {
        p->s.size -= nunits;
    1e5d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e61:	8b 40 08             	mov    0x8(%rax),%eax
    1e64:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1e67:	89 c2                	mov    %eax,%edx
    1e69:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e6d:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    1e70:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e74:	8b 40 08             	mov    0x8(%rax),%eax
    1e77:	89 c0                	mov    %eax,%eax
    1e79:	48 c1 e0 04          	shl    $0x4,%rax
    1e7d:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    1e81:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e85:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1e88:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    1e8b:	48 ba 70 21 00 00 00 	movabs $0x2170,%rdx
    1e92:	00 00 00 
    1e95:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e99:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    1e9c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ea0:	48 83 c0 10          	add    $0x10,%rax
    1ea4:	eb 4e                	jmp    1ef4 <malloc+0x148>
    }
    if(p == freep)
    1ea6:	48 b8 70 21 00 00 00 	movabs $0x2170,%rax
    1ead:	00 00 00 
    1eb0:	48 8b 00             	mov    (%rax),%rax
    1eb3:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1eb7:	75 23                	jne    1edc <malloc+0x130>
      if((p = morecore(nunits)) == 0)
    1eb9:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1ebc:	89 c7                	mov    %eax,%edi
    1ebe:	48 b8 31 1d 00 00 00 	movabs $0x1d31,%rax
    1ec5:	00 00 00 
    1ec8:	ff d0                	call   *%rax
    1eca:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1ece:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1ed3:	75 07                	jne    1edc <malloc+0x130>
        return 0;
    1ed5:	b8 00 00 00 00       	mov    $0x0,%eax
    1eda:	eb 18                	jmp    1ef4 <malloc+0x148>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1edc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ee0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1ee4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ee8:	48 8b 00             	mov    (%rax),%rax
    1eeb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1eef:	e9 41 ff ff ff       	jmp    1e35 <malloc+0x89>
  }
}
    1ef4:	c9                   	leave
    1ef5:	c3                   	ret
