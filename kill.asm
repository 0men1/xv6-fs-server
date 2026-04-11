
_kill:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
    1000:	55                   	push   %rbp
    1001:	48 89 e5             	mov    %rsp,%rbp
    1004:	48 83 ec 20          	sub    $0x20,%rsp
    1008:	89 7d ec             	mov    %edi,-0x14(%rbp)
    100b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;

  if(argc < 2){
    100f:	83 7d ec 01          	cmpl   $0x1,-0x14(%rbp)
    1013:	7f 2f                	jg     1044 <main+0x44>
    printf(2, "usage: kill pid...\n");
    1015:	48 b8 ca 1d 00 00 00 	movabs $0x1dca,%rax
    101c:	00 00 00 
    101f:	48 89 c6             	mov    %rax,%rsi
    1022:	bf 02 00 00 00       	mov    $0x2,%edi
    1027:	b8 00 00 00 00       	mov    $0x0,%eax
    102c:	48 ba a8 16 00 00 00 	movabs $0x16a8,%rdx
    1033:	00 00 00 
    1036:	ff d2                	call   *%rdx
    exit();
    1038:	48 b8 b4 13 00 00 00 	movabs $0x13b4,%rax
    103f:	00 00 00 
    1042:	ff d0                	call   *%rax
  }
  for(i=1; i<argc; i++)
    1044:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
    104b:	eb 38                	jmp    1085 <main+0x85>
    kill(atoi(argv[i]));
    104d:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1050:	48 98                	cltq
    1052:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1059:	00 
    105a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    105e:	48 01 d0             	add    %rdx,%rax
    1061:	48 8b 00             	mov    (%rax),%rax
    1064:	48 89 c7             	mov    %rax,%rdi
    1067:	48 b8 fa 12 00 00 00 	movabs $0x12fa,%rax
    106e:	00 00 00 
    1071:	ff d0                	call   *%rax
    1073:	89 c7                	mov    %eax,%edi
    1075:	48 b8 02 14 00 00 00 	movabs $0x1402,%rax
    107c:	00 00 00 
    107f:	ff d0                	call   *%rax
  for(i=1; i<argc; i++)
    1081:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1085:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1088:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    108b:	7c c0                	jl     104d <main+0x4d>
  exit();
    108d:	48 b8 b4 13 00 00 00 	movabs $0x13b4,%rax
    1094:	00 00 00 
    1097:	ff d0                	call   *%rax

0000000000001099 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1099:	55                   	push   %rbp
    109a:	48 89 e5             	mov    %rsp,%rbp
    109d:	48 83 ec 10          	sub    $0x10,%rsp
    10a1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    10a5:	89 75 f4             	mov    %esi,-0xc(%rbp)
    10a8:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
    10ab:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    10af:	8b 55 f0             	mov    -0x10(%rbp),%edx
    10b2:	8b 45 f4             	mov    -0xc(%rbp),%eax
    10b5:	48 89 ce             	mov    %rcx,%rsi
    10b8:	48 89 f7             	mov    %rsi,%rdi
    10bb:	89 d1                	mov    %edx,%ecx
    10bd:	fc                   	cld
    10be:	f3 aa                	rep stos %al,(%rdi)
    10c0:	89 ca                	mov    %ecx,%edx
    10c2:	48 89 fe             	mov    %rdi,%rsi
    10c5:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    10c9:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    10cc:	90                   	nop
    10cd:	c9                   	leave
    10ce:	c3                   	ret

00000000000010cf <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    10cf:	55                   	push   %rbp
    10d0:	48 89 e5             	mov    %rsp,%rbp
    10d3:	48 83 ec 20          	sub    $0x20,%rsp
    10d7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    10db:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
    10df:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    10e3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    10e7:	90                   	nop
    10e8:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    10ec:	48 8d 42 01          	lea    0x1(%rdx),%rax
    10f0:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    10f4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    10f8:	48 8d 48 01          	lea    0x1(%rax),%rcx
    10fc:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    1100:	0f b6 12             	movzbl (%rdx),%edx
    1103:	88 10                	mov    %dl,(%rax)
    1105:	0f b6 00             	movzbl (%rax),%eax
    1108:	84 c0                	test   %al,%al
    110a:	75 dc                	jne    10e8 <strcpy+0x19>
    ;
  return os;
    110c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    1110:	c9                   	leave
    1111:	c3                   	ret

0000000000001112 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1112:	55                   	push   %rbp
    1113:	48 89 e5             	mov    %rsp,%rbp
    1116:	48 83 ec 10          	sub    $0x10,%rsp
    111a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    111e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    1122:	eb 0a                	jmp    112e <strcmp+0x1c>
    p++, q++;
    1124:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1129:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    112e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1132:	0f b6 00             	movzbl (%rax),%eax
    1135:	84 c0                	test   %al,%al
    1137:	74 12                	je     114b <strcmp+0x39>
    1139:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    113d:	0f b6 10             	movzbl (%rax),%edx
    1140:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1144:	0f b6 00             	movzbl (%rax),%eax
    1147:	38 c2                	cmp    %al,%dl
    1149:	74 d9                	je     1124 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
    114b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    114f:	0f b6 00             	movzbl (%rax),%eax
    1152:	0f b6 d0             	movzbl %al,%edx
    1155:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1159:	0f b6 00             	movzbl (%rax),%eax
    115c:	0f b6 c0             	movzbl %al,%eax
    115f:	29 c2                	sub    %eax,%edx
    1161:	89 d0                	mov    %edx,%eax
}
    1163:	c9                   	leave
    1164:	c3                   	ret

0000000000001165 <strlen>:

uint
strlen(char *s)
{
    1165:	55                   	push   %rbp
    1166:	48 89 e5             	mov    %rsp,%rbp
    1169:	48 83 ec 18          	sub    $0x18,%rsp
    116d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
    1171:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1178:	eb 04                	jmp    117e <strlen+0x19>
    117a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    117e:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1181:	48 63 d0             	movslq %eax,%rdx
    1184:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1188:	48 01 d0             	add    %rdx,%rax
    118b:	0f b6 00             	movzbl (%rax),%eax
    118e:	84 c0                	test   %al,%al
    1190:	75 e8                	jne    117a <strlen+0x15>
    ;
  return n;
    1192:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    1195:	c9                   	leave
    1196:	c3                   	ret

0000000000001197 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1197:	55                   	push   %rbp
    1198:	48 89 e5             	mov    %rsp,%rbp
    119b:	48 83 ec 10          	sub    $0x10,%rsp
    119f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    11a3:	89 75 f4             	mov    %esi,-0xc(%rbp)
    11a6:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    11a9:	8b 55 f0             	mov    -0x10(%rbp),%edx
    11ac:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    11af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    11b3:	89 ce                	mov    %ecx,%esi
    11b5:	48 89 c7             	mov    %rax,%rdi
    11b8:	48 b8 99 10 00 00 00 	movabs $0x1099,%rax
    11bf:	00 00 00 
    11c2:	ff d0                	call   *%rax
  return dst;
    11c4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    11c8:	c9                   	leave
    11c9:	c3                   	ret

00000000000011ca <strchr>:

char*
strchr(const char *s, char c)
{
    11ca:	55                   	push   %rbp
    11cb:	48 89 e5             	mov    %rsp,%rbp
    11ce:	48 83 ec 10          	sub    $0x10,%rsp
    11d2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    11d6:	89 f0                	mov    %esi,%eax
    11d8:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    11db:	eb 17                	jmp    11f4 <strchr+0x2a>
    if(*s == c)
    11dd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    11e1:	0f b6 00             	movzbl (%rax),%eax
    11e4:	38 45 f4             	cmp    %al,-0xc(%rbp)
    11e7:	75 06                	jne    11ef <strchr+0x25>
      return (char*)s;
    11e9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    11ed:	eb 15                	jmp    1204 <strchr+0x3a>
  for(; *s; s++)
    11ef:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    11f4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    11f8:	0f b6 00             	movzbl (%rax),%eax
    11fb:	84 c0                	test   %al,%al
    11fd:	75 de                	jne    11dd <strchr+0x13>
  return 0;
    11ff:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1204:	c9                   	leave
    1205:	c3                   	ret

0000000000001206 <gets>:

char*
gets(char *buf, int max)
{
    1206:	55                   	push   %rbp
    1207:	48 89 e5             	mov    %rsp,%rbp
    120a:	48 83 ec 20          	sub    $0x20,%rsp
    120e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1212:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1215:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    121c:	eb 4f                	jmp    126d <gets+0x67>
    cc = read(0, &c, 1);
    121e:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    1222:	ba 01 00 00 00       	mov    $0x1,%edx
    1227:	48 89 c6             	mov    %rax,%rsi
    122a:	bf 00 00 00 00       	mov    $0x0,%edi
    122f:	48 b8 db 13 00 00 00 	movabs $0x13db,%rax
    1236:	00 00 00 
    1239:	ff d0                	call   *%rax
    123b:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    123e:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1242:	7e 36                	jle    127a <gets+0x74>
      break;
    buf[i++] = c;
    1244:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1247:	8d 50 01             	lea    0x1(%rax),%edx
    124a:	89 55 fc             	mov    %edx,-0x4(%rbp)
    124d:	48 63 d0             	movslq %eax,%rdx
    1250:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1254:	48 01 c2             	add    %rax,%rdx
    1257:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    125b:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    125d:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1261:	3c 0a                	cmp    $0xa,%al
    1263:	74 16                	je     127b <gets+0x75>
    1265:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1269:	3c 0d                	cmp    $0xd,%al
    126b:	74 0e                	je     127b <gets+0x75>
  for(i=0; i+1 < max; ){
    126d:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1270:	83 c0 01             	add    $0x1,%eax
    1273:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    1276:	7f a6                	jg     121e <gets+0x18>
    1278:	eb 01                	jmp    127b <gets+0x75>
      break;
    127a:	90                   	nop
      break;
  }
  buf[i] = '\0';
    127b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    127e:	48 63 d0             	movslq %eax,%rdx
    1281:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1285:	48 01 d0             	add    %rdx,%rax
    1288:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    128b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    128f:	c9                   	leave
    1290:	c3                   	ret

0000000000001291 <stat>:

int
stat(char *n, struct stat *st)
{
    1291:	55                   	push   %rbp
    1292:	48 89 e5             	mov    %rsp,%rbp
    1295:	48 83 ec 20          	sub    $0x20,%rsp
    1299:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    129d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    12a1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12a5:	be 00 00 00 00       	mov    $0x0,%esi
    12aa:	48 89 c7             	mov    %rax,%rdi
    12ad:	48 b8 1c 14 00 00 00 	movabs $0x141c,%rax
    12b4:	00 00 00 
    12b7:	ff d0                	call   *%rax
    12b9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    12bc:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    12c0:	79 07                	jns    12c9 <stat+0x38>
    return -1;
    12c2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    12c7:	eb 2f                	jmp    12f8 <stat+0x67>
  r = fstat(fd, st);
    12c9:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    12cd:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12d0:	48 89 d6             	mov    %rdx,%rsi
    12d3:	89 c7                	mov    %eax,%edi
    12d5:	48 b8 43 14 00 00 00 	movabs $0x1443,%rax
    12dc:	00 00 00 
    12df:	ff d0                	call   *%rax
    12e1:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    12e4:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12e7:	89 c7                	mov    %eax,%edi
    12e9:	48 b8 f5 13 00 00 00 	movabs $0x13f5,%rax
    12f0:	00 00 00 
    12f3:	ff d0                	call   *%rax
  return r;
    12f5:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    12f8:	c9                   	leave
    12f9:	c3                   	ret

00000000000012fa <atoi>:

int
atoi(const char *s)
{
    12fa:	55                   	push   %rbp
    12fb:	48 89 e5             	mov    %rsp,%rbp
    12fe:	48 83 ec 18          	sub    $0x18,%rsp
    1302:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    1306:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    130d:	eb 28                	jmp    1337 <atoi+0x3d>
    n = n*10 + *s++ - '0';
    130f:	8b 55 fc             	mov    -0x4(%rbp),%edx
    1312:	89 d0                	mov    %edx,%eax
    1314:	c1 e0 02             	shl    $0x2,%eax
    1317:	01 d0                	add    %edx,%eax
    1319:	01 c0                	add    %eax,%eax
    131b:	89 c1                	mov    %eax,%ecx
    131d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1321:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1325:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    1329:	0f b6 00             	movzbl (%rax),%eax
    132c:	0f be c0             	movsbl %al,%eax
    132f:	01 c8                	add    %ecx,%eax
    1331:	83 e8 30             	sub    $0x30,%eax
    1334:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1337:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    133b:	0f b6 00             	movzbl (%rax),%eax
    133e:	3c 2f                	cmp    $0x2f,%al
    1340:	7e 0b                	jle    134d <atoi+0x53>
    1342:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1346:	0f b6 00             	movzbl (%rax),%eax
    1349:	3c 39                	cmp    $0x39,%al
    134b:	7e c2                	jle    130f <atoi+0x15>
  return n;
    134d:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    1350:	c9                   	leave
    1351:	c3                   	ret

0000000000001352 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1352:	55                   	push   %rbp
    1353:	48 89 e5             	mov    %rsp,%rbp
    1356:	48 83 ec 28          	sub    $0x28,%rsp
    135a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    135e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    1362:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    1365:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1369:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    136d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1371:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    1375:	eb 1d                	jmp    1394 <memmove+0x42>
    *dst++ = *src++;
    1377:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    137b:	48 8d 42 01          	lea    0x1(%rdx),%rax
    137f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1383:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1387:	48 8d 48 01          	lea    0x1(%rax),%rcx
    138b:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    138f:	0f b6 12             	movzbl (%rdx),%edx
    1392:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    1394:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1397:	8d 50 ff             	lea    -0x1(%rax),%edx
    139a:	89 55 dc             	mov    %edx,-0x24(%rbp)
    139d:	85 c0                	test   %eax,%eax
    139f:	7f d6                	jg     1377 <memmove+0x25>
  return vdst;
    13a1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    13a5:	c9                   	leave
    13a6:	c3                   	ret

00000000000013a7 <fork>:
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    13a7:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    13ae:	49 89 ca             	mov    %rcx,%r10
    13b1:	0f 05                	syscall
    13b3:	c3                   	ret

00000000000013b4 <exit>:
SYSCALL(exit)
    13b4:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    13bb:	49 89 ca             	mov    %rcx,%r10
    13be:	0f 05                	syscall
    13c0:	c3                   	ret

00000000000013c1 <wait>:
SYSCALL(wait)
    13c1:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    13c8:	49 89 ca             	mov    %rcx,%r10
    13cb:	0f 05                	syscall
    13cd:	c3                   	ret

00000000000013ce <pipe>:
SYSCALL(pipe)
    13ce:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    13d5:	49 89 ca             	mov    %rcx,%r10
    13d8:	0f 05                	syscall
    13da:	c3                   	ret

00000000000013db <read>:
SYSCALL(read)
    13db:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    13e2:	49 89 ca             	mov    %rcx,%r10
    13e5:	0f 05                	syscall
    13e7:	c3                   	ret

00000000000013e8 <write>:
SYSCALL(write)
    13e8:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    13ef:	49 89 ca             	mov    %rcx,%r10
    13f2:	0f 05                	syscall
    13f4:	c3                   	ret

00000000000013f5 <close>:
SYSCALL(close)
    13f5:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    13fc:	49 89 ca             	mov    %rcx,%r10
    13ff:	0f 05                	syscall
    1401:	c3                   	ret

0000000000001402 <kill>:
SYSCALL(kill)
    1402:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    1409:	49 89 ca             	mov    %rcx,%r10
    140c:	0f 05                	syscall
    140e:	c3                   	ret

000000000000140f <exec>:
SYSCALL(exec)
    140f:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    1416:	49 89 ca             	mov    %rcx,%r10
    1419:	0f 05                	syscall
    141b:	c3                   	ret

000000000000141c <open>:
SYSCALL(open)
    141c:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    1423:	49 89 ca             	mov    %rcx,%r10
    1426:	0f 05                	syscall
    1428:	c3                   	ret

0000000000001429 <mknod>:
SYSCALL(mknod)
    1429:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    1430:	49 89 ca             	mov    %rcx,%r10
    1433:	0f 05                	syscall
    1435:	c3                   	ret

0000000000001436 <unlink>:
SYSCALL(unlink)
    1436:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    143d:	49 89 ca             	mov    %rcx,%r10
    1440:	0f 05                	syscall
    1442:	c3                   	ret

0000000000001443 <fstat>:
SYSCALL(fstat)
    1443:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    144a:	49 89 ca             	mov    %rcx,%r10
    144d:	0f 05                	syscall
    144f:	c3                   	ret

0000000000001450 <link>:
SYSCALL(link)
    1450:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    1457:	49 89 ca             	mov    %rcx,%r10
    145a:	0f 05                	syscall
    145c:	c3                   	ret

000000000000145d <mkdir>:
SYSCALL(mkdir)
    145d:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    1464:	49 89 ca             	mov    %rcx,%r10
    1467:	0f 05                	syscall
    1469:	c3                   	ret

000000000000146a <chdir>:
SYSCALL(chdir)
    146a:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    1471:	49 89 ca             	mov    %rcx,%r10
    1474:	0f 05                	syscall
    1476:	c3                   	ret

0000000000001477 <dup>:
SYSCALL(dup)
    1477:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    147e:	49 89 ca             	mov    %rcx,%r10
    1481:	0f 05                	syscall
    1483:	c3                   	ret

0000000000001484 <getpid>:
SYSCALL(getpid)
    1484:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    148b:	49 89 ca             	mov    %rcx,%r10
    148e:	0f 05                	syscall
    1490:	c3                   	ret

0000000000001491 <sbrk>:
SYSCALL(sbrk)
    1491:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    1498:	49 89 ca             	mov    %rcx,%r10
    149b:	0f 05                	syscall
    149d:	c3                   	ret

000000000000149e <sleep>:
SYSCALL(sleep)
    149e:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    14a5:	49 89 ca             	mov    %rcx,%r10
    14a8:	0f 05                	syscall
    14aa:	c3                   	ret

00000000000014ab <uptime>:
SYSCALL(uptime)
    14ab:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    14b2:	49 89 ca             	mov    %rcx,%r10
    14b5:	0f 05                	syscall
    14b7:	c3                   	ret

00000000000014b8 <send>:
SYSCALL(send)
    14b8:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    14bf:	49 89 ca             	mov    %rcx,%r10
    14c2:	0f 05                	syscall
    14c4:	c3                   	ret

00000000000014c5 <recv>:
SYSCALL(recv)
    14c5:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    14cc:	49 89 ca             	mov    %rcx,%r10
    14cf:	0f 05                	syscall
    14d1:	c3                   	ret

00000000000014d2 <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    14d2:	55                   	push   %rbp
    14d3:	48 89 e5             	mov    %rsp,%rbp
    14d6:	48 83 ec 10          	sub    $0x10,%rsp
    14da:	89 7d fc             	mov    %edi,-0x4(%rbp)
    14dd:	89 f0                	mov    %esi,%eax
    14df:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    14e2:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    14e6:	8b 45 fc             	mov    -0x4(%rbp),%eax
    14e9:	ba 01 00 00 00       	mov    $0x1,%edx
    14ee:	48 89 ce             	mov    %rcx,%rsi
    14f1:	89 c7                	mov    %eax,%edi
    14f3:	48 b8 e8 13 00 00 00 	movabs $0x13e8,%rax
    14fa:	00 00 00 
    14fd:	ff d0                	call   *%rax
}
    14ff:	90                   	nop
    1500:	c9                   	leave
    1501:	c3                   	ret

0000000000001502 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    1502:	55                   	push   %rbp
    1503:	48 89 e5             	mov    %rsp,%rbp
    1506:	48 83 ec 20          	sub    $0x20,%rsp
    150a:	89 7d ec             	mov    %edi,-0x14(%rbp)
    150d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1511:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1518:	eb 35                	jmp    154f <print_x64+0x4d>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    151a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    151e:	48 c1 e8 3c          	shr    $0x3c,%rax
    1522:	48 ba f0 1d 00 00 00 	movabs $0x1df0,%rdx
    1529:	00 00 00 
    152c:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1530:	0f be d0             	movsbl %al,%edx
    1533:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1536:	89 d6                	mov    %edx,%esi
    1538:	89 c7                	mov    %eax,%edi
    153a:	48 b8 d2 14 00 00 00 	movabs $0x14d2,%rax
    1541:	00 00 00 
    1544:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1546:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    154a:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    154f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1552:	83 f8 0f             	cmp    $0xf,%eax
    1555:	76 c3                	jbe    151a <print_x64+0x18>
}
    1557:	90                   	nop
    1558:	90                   	nop
    1559:	c9                   	leave
    155a:	c3                   	ret

000000000000155b <print_x32>:

  static void
print_x32(int fd, uint x)
{
    155b:	55                   	push   %rbp
    155c:	48 89 e5             	mov    %rsp,%rbp
    155f:	48 83 ec 20          	sub    $0x20,%rsp
    1563:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1566:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1569:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1570:	eb 36                	jmp    15a8 <print_x32+0x4d>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    1572:	8b 45 e8             	mov    -0x18(%rbp),%eax
    1575:	c1 e8 1c             	shr    $0x1c,%eax
    1578:	89 c2                	mov    %eax,%edx
    157a:	48 b8 f0 1d 00 00 00 	movabs $0x1df0,%rax
    1581:	00 00 00 
    1584:	89 d2                	mov    %edx,%edx
    1586:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    158a:	0f be d0             	movsbl %al,%edx
    158d:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1590:	89 d6                	mov    %edx,%esi
    1592:	89 c7                	mov    %eax,%edi
    1594:	48 b8 d2 14 00 00 00 	movabs $0x14d2,%rax
    159b:	00 00 00 
    159e:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    15a0:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    15a4:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    15a8:	8b 45 fc             	mov    -0x4(%rbp),%eax
    15ab:	83 f8 07             	cmp    $0x7,%eax
    15ae:	76 c2                	jbe    1572 <print_x32+0x17>
}
    15b0:	90                   	nop
    15b1:	90                   	nop
    15b2:	c9                   	leave
    15b3:	c3                   	ret

00000000000015b4 <print_d>:

  static void
print_d(int fd, int v)
{
    15b4:	55                   	push   %rbp
    15b5:	48 89 e5             	mov    %rsp,%rbp
    15b8:	48 83 ec 30          	sub    $0x30,%rsp
    15bc:	89 7d dc             	mov    %edi,-0x24(%rbp)
    15bf:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    15c2:	8b 45 d8             	mov    -0x28(%rbp),%eax
    15c5:	48 98                	cltq
    15c7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    15cb:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    15cf:	79 04                	jns    15d5 <print_d+0x21>
    x = -x;
    15d1:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    15d5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    15dc:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    15e0:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    15e7:	66 66 66 
    15ea:	48 89 c8             	mov    %rcx,%rax
    15ed:	48 f7 ea             	imul   %rdx
    15f0:	48 c1 fa 02          	sar    $0x2,%rdx
    15f4:	48 89 c8             	mov    %rcx,%rax
    15f7:	48 c1 f8 3f          	sar    $0x3f,%rax
    15fb:	48 29 c2             	sub    %rax,%rdx
    15fe:	48 89 d0             	mov    %rdx,%rax
    1601:	48 c1 e0 02          	shl    $0x2,%rax
    1605:	48 01 d0             	add    %rdx,%rax
    1608:	48 01 c0             	add    %rax,%rax
    160b:	48 29 c1             	sub    %rax,%rcx
    160e:	48 89 ca             	mov    %rcx,%rdx
    1611:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1614:	8d 48 01             	lea    0x1(%rax),%ecx
    1617:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    161a:	48 b9 f0 1d 00 00 00 	movabs $0x1df0,%rcx
    1621:	00 00 00 
    1624:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    1628:	48 98                	cltq
    162a:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    162e:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1632:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1639:	66 66 66 
    163c:	48 89 c8             	mov    %rcx,%rax
    163f:	48 f7 ea             	imul   %rdx
    1642:	48 89 d0             	mov    %rdx,%rax
    1645:	48 c1 f8 02          	sar    $0x2,%rax
    1649:	48 c1 f9 3f          	sar    $0x3f,%rcx
    164d:	48 89 ca             	mov    %rcx,%rdx
    1650:	48 29 d0             	sub    %rdx,%rax
    1653:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    1657:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    165c:	0f 85 7a ff ff ff    	jne    15dc <print_d+0x28>

  if (v < 0)
    1662:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1666:	79 32                	jns    169a <print_d+0xe6>
    buf[i++] = '-';
    1668:	8b 45 f4             	mov    -0xc(%rbp),%eax
    166b:	8d 50 01             	lea    0x1(%rax),%edx
    166e:	89 55 f4             	mov    %edx,-0xc(%rbp)
    1671:	48 98                	cltq
    1673:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    1678:	eb 20                	jmp    169a <print_d+0xe6>
    putc(fd, buf[i]);
    167a:	8b 45 f4             	mov    -0xc(%rbp),%eax
    167d:	48 98                	cltq
    167f:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    1684:	0f be d0             	movsbl %al,%edx
    1687:	8b 45 dc             	mov    -0x24(%rbp),%eax
    168a:	89 d6                	mov    %edx,%esi
    168c:	89 c7                	mov    %eax,%edi
    168e:	48 b8 d2 14 00 00 00 	movabs $0x14d2,%rax
    1695:	00 00 00 
    1698:	ff d0                	call   *%rax
  while (--i >= 0)
    169a:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    169e:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    16a2:	79 d6                	jns    167a <print_d+0xc6>
}
    16a4:	90                   	nop
    16a5:	90                   	nop
    16a6:	c9                   	leave
    16a7:	c3                   	ret

00000000000016a8 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    16a8:	55                   	push   %rbp
    16a9:	48 89 e5             	mov    %rsp,%rbp
    16ac:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    16b3:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    16b9:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    16c0:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    16c7:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    16ce:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    16d5:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    16dc:	84 c0                	test   %al,%al
    16de:	74 20                	je     1700 <printf+0x58>
    16e0:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    16e4:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    16e8:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    16ec:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    16f0:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    16f4:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    16f8:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    16fc:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    1700:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    1707:	00 00 00 
    170a:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    1711:	00 00 00 
    1714:	48 8d 45 10          	lea    0x10(%rbp),%rax
    1718:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    171f:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    1726:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    172d:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    1734:	00 00 00 
    1737:	e9 60 03 00 00       	jmp    1a9c <printf+0x3f4>
    if (c != '%') {
    173c:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1743:	74 24                	je     1769 <printf+0xc1>
      putc(fd, c);
    1745:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    174b:	0f be d0             	movsbl %al,%edx
    174e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1754:	89 d6                	mov    %edx,%esi
    1756:	89 c7                	mov    %eax,%edi
    1758:	48 b8 d2 14 00 00 00 	movabs $0x14d2,%rax
    175f:	00 00 00 
    1762:	ff d0                	call   *%rax
      continue;
    1764:	e9 2c 03 00 00       	jmp    1a95 <printf+0x3ed>
    }
    c = fmt[++i] & 0xff;
    1769:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1770:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1776:	48 63 d0             	movslq %eax,%rdx
    1779:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1780:	48 01 d0             	add    %rdx,%rax
    1783:	0f b6 00             	movzbl (%rax),%eax
    1786:	0f be c0             	movsbl %al,%eax
    1789:	25 ff 00 00 00       	and    $0xff,%eax
    178e:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    1794:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    179b:	0f 84 2e 03 00 00    	je     1acf <printf+0x427>
      break;
    switch(c) {
    17a1:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    17a8:	0f 84 32 01 00 00    	je     18e0 <printf+0x238>
    17ae:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    17b5:	0f 8f a1 02 00 00    	jg     1a5c <printf+0x3b4>
    17bb:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    17c2:	0f 84 d4 01 00 00    	je     199c <printf+0x2f4>
    17c8:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    17cf:	0f 8f 87 02 00 00    	jg     1a5c <printf+0x3b4>
    17d5:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    17dc:	0f 84 5b 01 00 00    	je     193d <printf+0x295>
    17e2:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    17e9:	0f 8f 6d 02 00 00    	jg     1a5c <printf+0x3b4>
    17ef:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    17f6:	0f 84 87 00 00 00    	je     1883 <printf+0x1db>
    17fc:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    1803:	0f 8f 53 02 00 00    	jg     1a5c <printf+0x3b4>
    1809:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1810:	0f 84 2b 02 00 00    	je     1a41 <printf+0x399>
    1816:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    181d:	0f 85 39 02 00 00    	jne    1a5c <printf+0x3b4>
    case 'c':
      putc(fd, va_arg(ap, int));
    1823:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1829:	83 f8 2f             	cmp    $0x2f,%eax
    182c:	77 23                	ja     1851 <printf+0x1a9>
    182e:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1835:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    183b:	89 d2                	mov    %edx,%edx
    183d:	48 01 d0             	add    %rdx,%rax
    1840:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1846:	83 c2 08             	add    $0x8,%edx
    1849:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    184f:	eb 12                	jmp    1863 <printf+0x1bb>
    1851:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1858:	48 8d 50 08          	lea    0x8(%rax),%rdx
    185c:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1863:	8b 00                	mov    (%rax),%eax
    1865:	0f be d0             	movsbl %al,%edx
    1868:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    186e:	89 d6                	mov    %edx,%esi
    1870:	89 c7                	mov    %eax,%edi
    1872:	48 b8 d2 14 00 00 00 	movabs $0x14d2,%rax
    1879:	00 00 00 
    187c:	ff d0                	call   *%rax
      break;
    187e:	e9 12 02 00 00       	jmp    1a95 <printf+0x3ed>
    case 'd':
      print_d(fd, va_arg(ap, int));
    1883:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1889:	83 f8 2f             	cmp    $0x2f,%eax
    188c:	77 23                	ja     18b1 <printf+0x209>
    188e:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1895:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    189b:	89 d2                	mov    %edx,%edx
    189d:	48 01 d0             	add    %rdx,%rax
    18a0:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18a6:	83 c2 08             	add    $0x8,%edx
    18a9:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    18af:	eb 12                	jmp    18c3 <printf+0x21b>
    18b1:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    18b8:	48 8d 50 08          	lea    0x8(%rax),%rdx
    18bc:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    18c3:	8b 10                	mov    (%rax),%edx
    18c5:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    18cb:	89 d6                	mov    %edx,%esi
    18cd:	89 c7                	mov    %eax,%edi
    18cf:	48 b8 b4 15 00 00 00 	movabs $0x15b4,%rax
    18d6:	00 00 00 
    18d9:	ff d0                	call   *%rax
      break;
    18db:	e9 b5 01 00 00       	jmp    1a95 <printf+0x3ed>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    18e0:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    18e6:	83 f8 2f             	cmp    $0x2f,%eax
    18e9:	77 23                	ja     190e <printf+0x266>
    18eb:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    18f2:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18f8:	89 d2                	mov    %edx,%edx
    18fa:	48 01 d0             	add    %rdx,%rax
    18fd:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1903:	83 c2 08             	add    $0x8,%edx
    1906:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    190c:	eb 12                	jmp    1920 <printf+0x278>
    190e:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1915:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1919:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1920:	8b 10                	mov    (%rax),%edx
    1922:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1928:	89 d6                	mov    %edx,%esi
    192a:	89 c7                	mov    %eax,%edi
    192c:	48 b8 5b 15 00 00 00 	movabs $0x155b,%rax
    1933:	00 00 00 
    1936:	ff d0                	call   *%rax
      break;
    1938:	e9 58 01 00 00       	jmp    1a95 <printf+0x3ed>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    193d:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1943:	83 f8 2f             	cmp    $0x2f,%eax
    1946:	77 23                	ja     196b <printf+0x2c3>
    1948:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    194f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1955:	89 d2                	mov    %edx,%edx
    1957:	48 01 d0             	add    %rdx,%rax
    195a:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1960:	83 c2 08             	add    $0x8,%edx
    1963:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1969:	eb 12                	jmp    197d <printf+0x2d5>
    196b:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1972:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1976:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    197d:	48 8b 10             	mov    (%rax),%rdx
    1980:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1986:	48 89 d6             	mov    %rdx,%rsi
    1989:	89 c7                	mov    %eax,%edi
    198b:	48 b8 02 15 00 00 00 	movabs $0x1502,%rax
    1992:	00 00 00 
    1995:	ff d0                	call   *%rax
      break;
    1997:	e9 f9 00 00 00       	jmp    1a95 <printf+0x3ed>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    199c:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    19a2:	83 f8 2f             	cmp    $0x2f,%eax
    19a5:	77 23                	ja     19ca <printf+0x322>
    19a7:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    19ae:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19b4:	89 d2                	mov    %edx,%edx
    19b6:	48 01 d0             	add    %rdx,%rax
    19b9:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19bf:	83 c2 08             	add    $0x8,%edx
    19c2:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    19c8:	eb 12                	jmp    19dc <printf+0x334>
    19ca:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    19d1:	48 8d 50 08          	lea    0x8(%rax),%rdx
    19d5:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    19dc:	48 8b 00             	mov    (%rax),%rax
    19df:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    19e6:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    19ed:	00 
    19ee:	75 41                	jne    1a31 <printf+0x389>
        s = "(null)";
    19f0:	48 b8 de 1d 00 00 00 	movabs $0x1dde,%rax
    19f7:	00 00 00 
    19fa:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1a01:	eb 2e                	jmp    1a31 <printf+0x389>
        putc(fd, *(s++));
    1a03:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1a0a:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1a0e:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1a15:	0f b6 00             	movzbl (%rax),%eax
    1a18:	0f be d0             	movsbl %al,%edx
    1a1b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a21:	89 d6                	mov    %edx,%esi
    1a23:	89 c7                	mov    %eax,%edi
    1a25:	48 b8 d2 14 00 00 00 	movabs $0x14d2,%rax
    1a2c:	00 00 00 
    1a2f:	ff d0                	call   *%rax
      while (*s)
    1a31:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1a38:	0f b6 00             	movzbl (%rax),%eax
    1a3b:	84 c0                	test   %al,%al
    1a3d:	75 c4                	jne    1a03 <printf+0x35b>
      break;
    1a3f:	eb 54                	jmp    1a95 <printf+0x3ed>
    case '%':
      putc(fd, '%');
    1a41:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a47:	be 25 00 00 00       	mov    $0x25,%esi
    1a4c:	89 c7                	mov    %eax,%edi
    1a4e:	48 b8 d2 14 00 00 00 	movabs $0x14d2,%rax
    1a55:	00 00 00 
    1a58:	ff d0                	call   *%rax
      break;
    1a5a:	eb 39                	jmp    1a95 <printf+0x3ed>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1a5c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a62:	be 25 00 00 00       	mov    $0x25,%esi
    1a67:	89 c7                	mov    %eax,%edi
    1a69:	48 b8 d2 14 00 00 00 	movabs $0x14d2,%rax
    1a70:	00 00 00 
    1a73:	ff d0                	call   *%rax
      putc(fd, c);
    1a75:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1a7b:	0f be d0             	movsbl %al,%edx
    1a7e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a84:	89 d6                	mov    %edx,%esi
    1a86:	89 c7                	mov    %eax,%edi
    1a88:	48 b8 d2 14 00 00 00 	movabs $0x14d2,%rax
    1a8f:	00 00 00 
    1a92:	ff d0                	call   *%rax
      break;
    1a94:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1a95:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1a9c:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1aa2:	48 63 d0             	movslq %eax,%rdx
    1aa5:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1aac:	48 01 d0             	add    %rdx,%rax
    1aaf:	0f b6 00             	movzbl (%rax),%eax
    1ab2:	0f be c0             	movsbl %al,%eax
    1ab5:	25 ff 00 00 00       	and    $0xff,%eax
    1aba:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1ac0:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1ac7:	0f 85 6f fc ff ff    	jne    173c <printf+0x94>
    }
  }
}
    1acd:	eb 01                	jmp    1ad0 <printf+0x428>
      break;
    1acf:	90                   	nop
}
    1ad0:	90                   	nop
    1ad1:	c9                   	leave
    1ad2:	c3                   	ret

0000000000001ad3 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1ad3:	55                   	push   %rbp
    1ad4:	48 89 e5             	mov    %rsp,%rbp
    1ad7:	48 83 ec 18          	sub    $0x18,%rsp
    1adb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1adf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1ae3:	48 83 e8 10          	sub    $0x10,%rax
    1ae7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1aeb:	48 b8 20 1e 00 00 00 	movabs $0x1e20,%rax
    1af2:	00 00 00 
    1af5:	48 8b 00             	mov    (%rax),%rax
    1af8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1afc:	eb 2f                	jmp    1b2d <free+0x5a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1afe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b02:	48 8b 00             	mov    (%rax),%rax
    1b05:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b09:	72 17                	jb     1b22 <free+0x4f>
    1b0b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b0f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b13:	72 2f                	jb     1b44 <free+0x71>
    1b15:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b19:	48 8b 00             	mov    (%rax),%rax
    1b1c:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1b20:	72 22                	jb     1b44 <free+0x71>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1b22:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b26:	48 8b 00             	mov    (%rax),%rax
    1b29:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1b2d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b31:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b35:	73 c7                	jae    1afe <free+0x2b>
    1b37:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b3b:	48 8b 00             	mov    (%rax),%rax
    1b3e:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1b42:	73 ba                	jae    1afe <free+0x2b>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1b44:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b48:	8b 40 08             	mov    0x8(%rax),%eax
    1b4b:	89 c0                	mov    %eax,%eax
    1b4d:	48 c1 e0 04          	shl    $0x4,%rax
    1b51:	48 89 c2             	mov    %rax,%rdx
    1b54:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b58:	48 01 c2             	add    %rax,%rdx
    1b5b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b5f:	48 8b 00             	mov    (%rax),%rax
    1b62:	48 39 c2             	cmp    %rax,%rdx
    1b65:	75 2d                	jne    1b94 <free+0xc1>
    bp->s.size += p->s.ptr->s.size;
    1b67:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b6b:	8b 50 08             	mov    0x8(%rax),%edx
    1b6e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b72:	48 8b 00             	mov    (%rax),%rax
    1b75:	8b 40 08             	mov    0x8(%rax),%eax
    1b78:	01 c2                	add    %eax,%edx
    1b7a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b7e:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1b81:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b85:	48 8b 00             	mov    (%rax),%rax
    1b88:	48 8b 10             	mov    (%rax),%rdx
    1b8b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b8f:	48 89 10             	mov    %rdx,(%rax)
    1b92:	eb 0e                	jmp    1ba2 <free+0xcf>
  } else
    bp->s.ptr = p->s.ptr;
    1b94:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b98:	48 8b 10             	mov    (%rax),%rdx
    1b9b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b9f:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    1ba2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ba6:	8b 40 08             	mov    0x8(%rax),%eax
    1ba9:	89 c0                	mov    %eax,%eax
    1bab:	48 c1 e0 04          	shl    $0x4,%rax
    1baf:	48 89 c2             	mov    %rax,%rdx
    1bb2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bb6:	48 01 d0             	add    %rdx,%rax
    1bb9:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1bbd:	75 27                	jne    1be6 <free+0x113>
    p->s.size += bp->s.size;
    1bbf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bc3:	8b 50 08             	mov    0x8(%rax),%edx
    1bc6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bca:	8b 40 08             	mov    0x8(%rax),%eax
    1bcd:	01 c2                	add    %eax,%edx
    1bcf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bd3:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    1bd6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bda:	48 8b 10             	mov    (%rax),%rdx
    1bdd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1be1:	48 89 10             	mov    %rdx,(%rax)
    1be4:	eb 0b                	jmp    1bf1 <free+0x11e>
  } else
    p->s.ptr = bp;
    1be6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bea:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1bee:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    1bf1:	48 ba 20 1e 00 00 00 	movabs $0x1e20,%rdx
    1bf8:	00 00 00 
    1bfb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bff:	48 89 02             	mov    %rax,(%rdx)
}
    1c02:	90                   	nop
    1c03:	c9                   	leave
    1c04:	c3                   	ret

0000000000001c05 <morecore>:

static Header*
morecore(uint nu)
{
    1c05:	55                   	push   %rbp
    1c06:	48 89 e5             	mov    %rsp,%rbp
    1c09:	48 83 ec 20          	sub    $0x20,%rsp
    1c0d:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    1c10:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1c17:	77 07                	ja     1c20 <morecore+0x1b>
    nu = 4096;
    1c19:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    1c20:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1c23:	48 c1 e0 04          	shl    $0x4,%rax
    1c27:	48 89 c7             	mov    %rax,%rdi
    1c2a:	48 b8 91 14 00 00 00 	movabs $0x1491,%rax
    1c31:	00 00 00 
    1c34:	ff d0                	call   *%rax
    1c36:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    1c3a:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1c3f:	75 07                	jne    1c48 <morecore+0x43>
    return 0;
    1c41:	b8 00 00 00 00       	mov    $0x0,%eax
    1c46:	eb 36                	jmp    1c7e <morecore+0x79>
  hp = (Header*)p;
    1c48:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c4c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    1c50:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c54:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1c57:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    1c5a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c5e:	48 83 c0 10          	add    $0x10,%rax
    1c62:	48 89 c7             	mov    %rax,%rdi
    1c65:	48 b8 d3 1a 00 00 00 	movabs $0x1ad3,%rax
    1c6c:	00 00 00 
    1c6f:	ff d0                	call   *%rax
  return freep;
    1c71:	48 b8 20 1e 00 00 00 	movabs $0x1e20,%rax
    1c78:	00 00 00 
    1c7b:	48 8b 00             	mov    (%rax),%rax
}
    1c7e:	c9                   	leave
    1c7f:	c3                   	ret

0000000000001c80 <malloc>:

void*
malloc(uint nbytes)
{
    1c80:	55                   	push   %rbp
    1c81:	48 89 e5             	mov    %rsp,%rbp
    1c84:	48 83 ec 30          	sub    $0x30,%rsp
    1c88:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1c8b:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1c8e:	48 83 c0 0f          	add    $0xf,%rax
    1c92:	48 c1 e8 04          	shr    $0x4,%rax
    1c96:	83 c0 01             	add    $0x1,%eax
    1c99:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    1c9c:	48 b8 20 1e 00 00 00 	movabs $0x1e20,%rax
    1ca3:	00 00 00 
    1ca6:	48 8b 00             	mov    (%rax),%rax
    1ca9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1cad:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1cb2:	75 4a                	jne    1cfe <malloc+0x7e>
    base.s.ptr = freep = prevp = &base;
    1cb4:	48 b8 10 1e 00 00 00 	movabs $0x1e10,%rax
    1cbb:	00 00 00 
    1cbe:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1cc2:	48 ba 20 1e 00 00 00 	movabs $0x1e20,%rdx
    1cc9:	00 00 00 
    1ccc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cd0:	48 89 02             	mov    %rax,(%rdx)
    1cd3:	48 b8 20 1e 00 00 00 	movabs $0x1e20,%rax
    1cda:	00 00 00 
    1cdd:	48 8b 00             	mov    (%rax),%rax
    1ce0:	48 ba 10 1e 00 00 00 	movabs $0x1e10,%rdx
    1ce7:	00 00 00 
    1cea:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    1ced:	48 b8 10 1e 00 00 00 	movabs $0x1e10,%rax
    1cf4:	00 00 00 
    1cf7:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1cfe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d02:	48 8b 00             	mov    (%rax),%rax
    1d05:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1d09:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d0d:	8b 40 08             	mov    0x8(%rax),%eax
    1d10:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1d13:	72 65                	jb     1d7a <malloc+0xfa>
      if(p->s.size == nunits)
    1d15:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d19:	8b 40 08             	mov    0x8(%rax),%eax
    1d1c:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1d1f:	75 10                	jne    1d31 <malloc+0xb1>
        prevp->s.ptr = p->s.ptr;
    1d21:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d25:	48 8b 10             	mov    (%rax),%rdx
    1d28:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d2c:	48 89 10             	mov    %rdx,(%rax)
    1d2f:	eb 2e                	jmp    1d5f <malloc+0xdf>
      else {
        p->s.size -= nunits;
    1d31:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d35:	8b 40 08             	mov    0x8(%rax),%eax
    1d38:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1d3b:	89 c2                	mov    %eax,%edx
    1d3d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d41:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    1d44:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d48:	8b 40 08             	mov    0x8(%rax),%eax
    1d4b:	89 c0                	mov    %eax,%eax
    1d4d:	48 c1 e0 04          	shl    $0x4,%rax
    1d51:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    1d55:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d59:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1d5c:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    1d5f:	48 ba 20 1e 00 00 00 	movabs $0x1e20,%rdx
    1d66:	00 00 00 
    1d69:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d6d:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    1d70:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d74:	48 83 c0 10          	add    $0x10,%rax
    1d78:	eb 4e                	jmp    1dc8 <malloc+0x148>
    }
    if(p == freep)
    1d7a:	48 b8 20 1e 00 00 00 	movabs $0x1e20,%rax
    1d81:	00 00 00 
    1d84:	48 8b 00             	mov    (%rax),%rax
    1d87:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1d8b:	75 23                	jne    1db0 <malloc+0x130>
      if((p = morecore(nunits)) == 0)
    1d8d:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1d90:	89 c7                	mov    %eax,%edi
    1d92:	48 b8 05 1c 00 00 00 	movabs $0x1c05,%rax
    1d99:	00 00 00 
    1d9c:	ff d0                	call   *%rax
    1d9e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1da2:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1da7:	75 07                	jne    1db0 <malloc+0x130>
        return 0;
    1da9:	b8 00 00 00 00       	mov    $0x0,%eax
    1dae:	eb 18                	jmp    1dc8 <malloc+0x148>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1db0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1db4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1db8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1dbc:	48 8b 00             	mov    (%rax),%rax
    1dbf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1dc3:	e9 41 ff ff ff       	jmp    1d09 <malloc+0x89>
  }
}
    1dc8:	c9                   	leave
    1dc9:	c3                   	ret
