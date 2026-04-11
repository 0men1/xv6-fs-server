
_rm:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
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
    printf(2, "Usage: rm files...\n");
    1015:	48 b8 ff 1d 00 00 00 	movabs $0x1dff,%rax
    101c:	00 00 00 
    101f:	48 89 c6             	mov    %rax,%rsi
    1022:	bf 02 00 00 00       	mov    $0x2,%edi
    1027:	b8 00 00 00 00       	mov    $0x0,%eax
    102c:	48 ba dd 16 00 00 00 	movabs $0x16dd,%rdx
    1033:	00 00 00 
    1036:	ff d2                	call   *%rdx
    exit();
    1038:	48 b8 e9 13 00 00 00 	movabs $0x13e9,%rax
    103f:	00 00 00 
    1042:	ff d0                	call   *%rax
  }

  for(i = 1; i < argc; i++){
    1044:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
    104b:	eb 6d                	jmp    10ba <main+0xba>
    if(unlink(argv[i]) < 0){
    104d:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1050:	48 98                	cltq
    1052:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1059:	00 
    105a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    105e:	48 01 d0             	add    %rdx,%rax
    1061:	48 8b 00             	mov    (%rax),%rax
    1064:	48 89 c7             	mov    %rax,%rdi
    1067:	48 b8 6b 14 00 00 00 	movabs $0x146b,%rax
    106e:	00 00 00 
    1071:	ff d0                	call   *%rax
    1073:	85 c0                	test   %eax,%eax
    1075:	79 3f                	jns    10b6 <main+0xb6>
      printf(2, "rm: %s failed to delete\n", argv[i]);
    1077:	8b 45 fc             	mov    -0x4(%rbp),%eax
    107a:	48 98                	cltq
    107c:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1083:	00 
    1084:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1088:	48 01 d0             	add    %rdx,%rax
    108b:	48 8b 00             	mov    (%rax),%rax
    108e:	48 b9 13 1e 00 00 00 	movabs $0x1e13,%rcx
    1095:	00 00 00 
    1098:	48 89 c2             	mov    %rax,%rdx
    109b:	48 89 ce             	mov    %rcx,%rsi
    109e:	bf 02 00 00 00       	mov    $0x2,%edi
    10a3:	b8 00 00 00 00       	mov    $0x0,%eax
    10a8:	48 b9 dd 16 00 00 00 	movabs $0x16dd,%rcx
    10af:	00 00 00 
    10b2:	ff d1                	call   *%rcx
      break;
    10b4:	eb 0c                	jmp    10c2 <main+0xc2>
  for(i = 1; i < argc; i++){
    10b6:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    10ba:	8b 45 fc             	mov    -0x4(%rbp),%eax
    10bd:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    10c0:	7c 8b                	jl     104d <main+0x4d>
    }
  }

  exit();
    10c2:	48 b8 e9 13 00 00 00 	movabs $0x13e9,%rax
    10c9:	00 00 00 
    10cc:	ff d0                	call   *%rax

00000000000010ce <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    10ce:	55                   	push   %rbp
    10cf:	48 89 e5             	mov    %rsp,%rbp
    10d2:	48 83 ec 10          	sub    $0x10,%rsp
    10d6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    10da:	89 75 f4             	mov    %esi,-0xc(%rbp)
    10dd:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
    10e0:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    10e4:	8b 55 f0             	mov    -0x10(%rbp),%edx
    10e7:	8b 45 f4             	mov    -0xc(%rbp),%eax
    10ea:	48 89 ce             	mov    %rcx,%rsi
    10ed:	48 89 f7             	mov    %rsi,%rdi
    10f0:	89 d1                	mov    %edx,%ecx
    10f2:	fc                   	cld
    10f3:	f3 aa                	rep stos %al,(%rdi)
    10f5:	89 ca                	mov    %ecx,%edx
    10f7:	48 89 fe             	mov    %rdi,%rsi
    10fa:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    10fe:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1101:	90                   	nop
    1102:	c9                   	leave
    1103:	c3                   	ret

0000000000001104 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1104:	55                   	push   %rbp
    1105:	48 89 e5             	mov    %rsp,%rbp
    1108:	48 83 ec 20          	sub    $0x20,%rsp
    110c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1110:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
    1114:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1118:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    111c:	90                   	nop
    111d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1121:	48 8d 42 01          	lea    0x1(%rdx),%rax
    1125:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    1129:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    112d:	48 8d 48 01          	lea    0x1(%rax),%rcx
    1131:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    1135:	0f b6 12             	movzbl (%rdx),%edx
    1138:	88 10                	mov    %dl,(%rax)
    113a:	0f b6 00             	movzbl (%rax),%eax
    113d:	84 c0                	test   %al,%al
    113f:	75 dc                	jne    111d <strcpy+0x19>
    ;
  return os;
    1141:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    1145:	c9                   	leave
    1146:	c3                   	ret

0000000000001147 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1147:	55                   	push   %rbp
    1148:	48 89 e5             	mov    %rsp,%rbp
    114b:	48 83 ec 10          	sub    $0x10,%rsp
    114f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1153:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    1157:	eb 0a                	jmp    1163 <strcmp+0x1c>
    p++, q++;
    1159:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    115e:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    1163:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1167:	0f b6 00             	movzbl (%rax),%eax
    116a:	84 c0                	test   %al,%al
    116c:	74 12                	je     1180 <strcmp+0x39>
    116e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1172:	0f b6 10             	movzbl (%rax),%edx
    1175:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1179:	0f b6 00             	movzbl (%rax),%eax
    117c:	38 c2                	cmp    %al,%dl
    117e:	74 d9                	je     1159 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
    1180:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1184:	0f b6 00             	movzbl (%rax),%eax
    1187:	0f b6 d0             	movzbl %al,%edx
    118a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    118e:	0f b6 00             	movzbl (%rax),%eax
    1191:	0f b6 c0             	movzbl %al,%eax
    1194:	29 c2                	sub    %eax,%edx
    1196:	89 d0                	mov    %edx,%eax
}
    1198:	c9                   	leave
    1199:	c3                   	ret

000000000000119a <strlen>:

uint
strlen(char *s)
{
    119a:	55                   	push   %rbp
    119b:	48 89 e5             	mov    %rsp,%rbp
    119e:	48 83 ec 18          	sub    $0x18,%rsp
    11a2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
    11a6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    11ad:	eb 04                	jmp    11b3 <strlen+0x19>
    11af:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    11b3:	8b 45 fc             	mov    -0x4(%rbp),%eax
    11b6:	48 63 d0             	movslq %eax,%rdx
    11b9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    11bd:	48 01 d0             	add    %rdx,%rax
    11c0:	0f b6 00             	movzbl (%rax),%eax
    11c3:	84 c0                	test   %al,%al
    11c5:	75 e8                	jne    11af <strlen+0x15>
    ;
  return n;
    11c7:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    11ca:	c9                   	leave
    11cb:	c3                   	ret

00000000000011cc <memset>:

void*
memset(void *dst, int c, uint n)
{
    11cc:	55                   	push   %rbp
    11cd:	48 89 e5             	mov    %rsp,%rbp
    11d0:	48 83 ec 10          	sub    $0x10,%rsp
    11d4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    11d8:	89 75 f4             	mov    %esi,-0xc(%rbp)
    11db:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    11de:	8b 55 f0             	mov    -0x10(%rbp),%edx
    11e1:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    11e4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    11e8:	89 ce                	mov    %ecx,%esi
    11ea:	48 89 c7             	mov    %rax,%rdi
    11ed:	48 b8 ce 10 00 00 00 	movabs $0x10ce,%rax
    11f4:	00 00 00 
    11f7:	ff d0                	call   *%rax
  return dst;
    11f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    11fd:	c9                   	leave
    11fe:	c3                   	ret

00000000000011ff <strchr>:

char*
strchr(const char *s, char c)
{
    11ff:	55                   	push   %rbp
    1200:	48 89 e5             	mov    %rsp,%rbp
    1203:	48 83 ec 10          	sub    $0x10,%rsp
    1207:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    120b:	89 f0                	mov    %esi,%eax
    120d:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    1210:	eb 17                	jmp    1229 <strchr+0x2a>
    if(*s == c)
    1212:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1216:	0f b6 00             	movzbl (%rax),%eax
    1219:	38 45 f4             	cmp    %al,-0xc(%rbp)
    121c:	75 06                	jne    1224 <strchr+0x25>
      return (char*)s;
    121e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1222:	eb 15                	jmp    1239 <strchr+0x3a>
  for(; *s; s++)
    1224:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1229:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    122d:	0f b6 00             	movzbl (%rax),%eax
    1230:	84 c0                	test   %al,%al
    1232:	75 de                	jne    1212 <strchr+0x13>
  return 0;
    1234:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1239:	c9                   	leave
    123a:	c3                   	ret

000000000000123b <gets>:

char*
gets(char *buf, int max)
{
    123b:	55                   	push   %rbp
    123c:	48 89 e5             	mov    %rsp,%rbp
    123f:	48 83 ec 20          	sub    $0x20,%rsp
    1243:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1247:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    124a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1251:	eb 4f                	jmp    12a2 <gets+0x67>
    cc = read(0, &c, 1);
    1253:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    1257:	ba 01 00 00 00       	mov    $0x1,%edx
    125c:	48 89 c6             	mov    %rax,%rsi
    125f:	bf 00 00 00 00       	mov    $0x0,%edi
    1264:	48 b8 10 14 00 00 00 	movabs $0x1410,%rax
    126b:	00 00 00 
    126e:	ff d0                	call   *%rax
    1270:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    1273:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1277:	7e 36                	jle    12af <gets+0x74>
      break;
    buf[i++] = c;
    1279:	8b 45 fc             	mov    -0x4(%rbp),%eax
    127c:	8d 50 01             	lea    0x1(%rax),%edx
    127f:	89 55 fc             	mov    %edx,-0x4(%rbp)
    1282:	48 63 d0             	movslq %eax,%rdx
    1285:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1289:	48 01 c2             	add    %rax,%rdx
    128c:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1290:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    1292:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1296:	3c 0a                	cmp    $0xa,%al
    1298:	74 16                	je     12b0 <gets+0x75>
    129a:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    129e:	3c 0d                	cmp    $0xd,%al
    12a0:	74 0e                	je     12b0 <gets+0x75>
  for(i=0; i+1 < max; ){
    12a2:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12a5:	83 c0 01             	add    $0x1,%eax
    12a8:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    12ab:	7f a6                	jg     1253 <gets+0x18>
    12ad:	eb 01                	jmp    12b0 <gets+0x75>
      break;
    12af:	90                   	nop
      break;
  }
  buf[i] = '\0';
    12b0:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12b3:	48 63 d0             	movslq %eax,%rdx
    12b6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12ba:	48 01 d0             	add    %rdx,%rax
    12bd:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    12c0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    12c4:	c9                   	leave
    12c5:	c3                   	ret

00000000000012c6 <stat>:

int
stat(char *n, struct stat *st)
{
    12c6:	55                   	push   %rbp
    12c7:	48 89 e5             	mov    %rsp,%rbp
    12ca:	48 83 ec 20          	sub    $0x20,%rsp
    12ce:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    12d2:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    12d6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12da:	be 00 00 00 00       	mov    $0x0,%esi
    12df:	48 89 c7             	mov    %rax,%rdi
    12e2:	48 b8 51 14 00 00 00 	movabs $0x1451,%rax
    12e9:	00 00 00 
    12ec:	ff d0                	call   *%rax
    12ee:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    12f1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    12f5:	79 07                	jns    12fe <stat+0x38>
    return -1;
    12f7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    12fc:	eb 2f                	jmp    132d <stat+0x67>
  r = fstat(fd, st);
    12fe:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1302:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1305:	48 89 d6             	mov    %rdx,%rsi
    1308:	89 c7                	mov    %eax,%edi
    130a:	48 b8 78 14 00 00 00 	movabs $0x1478,%rax
    1311:	00 00 00 
    1314:	ff d0                	call   *%rax
    1316:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    1319:	8b 45 fc             	mov    -0x4(%rbp),%eax
    131c:	89 c7                	mov    %eax,%edi
    131e:	48 b8 2a 14 00 00 00 	movabs $0x142a,%rax
    1325:	00 00 00 
    1328:	ff d0                	call   *%rax
  return r;
    132a:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    132d:	c9                   	leave
    132e:	c3                   	ret

000000000000132f <atoi>:

int
atoi(const char *s)
{
    132f:	55                   	push   %rbp
    1330:	48 89 e5             	mov    %rsp,%rbp
    1333:	48 83 ec 18          	sub    $0x18,%rsp
    1337:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    133b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1342:	eb 28                	jmp    136c <atoi+0x3d>
    n = n*10 + *s++ - '0';
    1344:	8b 55 fc             	mov    -0x4(%rbp),%edx
    1347:	89 d0                	mov    %edx,%eax
    1349:	c1 e0 02             	shl    $0x2,%eax
    134c:	01 d0                	add    %edx,%eax
    134e:	01 c0                	add    %eax,%eax
    1350:	89 c1                	mov    %eax,%ecx
    1352:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1356:	48 8d 50 01          	lea    0x1(%rax),%rdx
    135a:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    135e:	0f b6 00             	movzbl (%rax),%eax
    1361:	0f be c0             	movsbl %al,%eax
    1364:	01 c8                	add    %ecx,%eax
    1366:	83 e8 30             	sub    $0x30,%eax
    1369:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    136c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1370:	0f b6 00             	movzbl (%rax),%eax
    1373:	3c 2f                	cmp    $0x2f,%al
    1375:	7e 0b                	jle    1382 <atoi+0x53>
    1377:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    137b:	0f b6 00             	movzbl (%rax),%eax
    137e:	3c 39                	cmp    $0x39,%al
    1380:	7e c2                	jle    1344 <atoi+0x15>
  return n;
    1382:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    1385:	c9                   	leave
    1386:	c3                   	ret

0000000000001387 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1387:	55                   	push   %rbp
    1388:	48 89 e5             	mov    %rsp,%rbp
    138b:	48 83 ec 28          	sub    $0x28,%rsp
    138f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1393:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    1397:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    139a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    139e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    13a2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    13a6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    13aa:	eb 1d                	jmp    13c9 <memmove+0x42>
    *dst++ = *src++;
    13ac:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    13b0:	48 8d 42 01          	lea    0x1(%rdx),%rax
    13b4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    13b8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13bc:	48 8d 48 01          	lea    0x1(%rax),%rcx
    13c0:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    13c4:	0f b6 12             	movzbl (%rdx),%edx
    13c7:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    13c9:	8b 45 dc             	mov    -0x24(%rbp),%eax
    13cc:	8d 50 ff             	lea    -0x1(%rax),%edx
    13cf:	89 55 dc             	mov    %edx,-0x24(%rbp)
    13d2:	85 c0                	test   %eax,%eax
    13d4:	7f d6                	jg     13ac <memmove+0x25>
  return vdst;
    13d6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    13da:	c9                   	leave
    13db:	c3                   	ret

00000000000013dc <fork>:
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    13dc:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    13e3:	49 89 ca             	mov    %rcx,%r10
    13e6:	0f 05                	syscall
    13e8:	c3                   	ret

00000000000013e9 <exit>:
SYSCALL(exit)
    13e9:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    13f0:	49 89 ca             	mov    %rcx,%r10
    13f3:	0f 05                	syscall
    13f5:	c3                   	ret

00000000000013f6 <wait>:
SYSCALL(wait)
    13f6:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    13fd:	49 89 ca             	mov    %rcx,%r10
    1400:	0f 05                	syscall
    1402:	c3                   	ret

0000000000001403 <pipe>:
SYSCALL(pipe)
    1403:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    140a:	49 89 ca             	mov    %rcx,%r10
    140d:	0f 05                	syscall
    140f:	c3                   	ret

0000000000001410 <read>:
SYSCALL(read)
    1410:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    1417:	49 89 ca             	mov    %rcx,%r10
    141a:	0f 05                	syscall
    141c:	c3                   	ret

000000000000141d <write>:
SYSCALL(write)
    141d:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    1424:	49 89 ca             	mov    %rcx,%r10
    1427:	0f 05                	syscall
    1429:	c3                   	ret

000000000000142a <close>:
SYSCALL(close)
    142a:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    1431:	49 89 ca             	mov    %rcx,%r10
    1434:	0f 05                	syscall
    1436:	c3                   	ret

0000000000001437 <kill>:
SYSCALL(kill)
    1437:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    143e:	49 89 ca             	mov    %rcx,%r10
    1441:	0f 05                	syscall
    1443:	c3                   	ret

0000000000001444 <exec>:
SYSCALL(exec)
    1444:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    144b:	49 89 ca             	mov    %rcx,%r10
    144e:	0f 05                	syscall
    1450:	c3                   	ret

0000000000001451 <open>:
SYSCALL(open)
    1451:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    1458:	49 89 ca             	mov    %rcx,%r10
    145b:	0f 05                	syscall
    145d:	c3                   	ret

000000000000145e <mknod>:
SYSCALL(mknod)
    145e:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    1465:	49 89 ca             	mov    %rcx,%r10
    1468:	0f 05                	syscall
    146a:	c3                   	ret

000000000000146b <unlink>:
SYSCALL(unlink)
    146b:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    1472:	49 89 ca             	mov    %rcx,%r10
    1475:	0f 05                	syscall
    1477:	c3                   	ret

0000000000001478 <fstat>:
SYSCALL(fstat)
    1478:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    147f:	49 89 ca             	mov    %rcx,%r10
    1482:	0f 05                	syscall
    1484:	c3                   	ret

0000000000001485 <link>:
SYSCALL(link)
    1485:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    148c:	49 89 ca             	mov    %rcx,%r10
    148f:	0f 05                	syscall
    1491:	c3                   	ret

0000000000001492 <mkdir>:
SYSCALL(mkdir)
    1492:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    1499:	49 89 ca             	mov    %rcx,%r10
    149c:	0f 05                	syscall
    149e:	c3                   	ret

000000000000149f <chdir>:
SYSCALL(chdir)
    149f:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    14a6:	49 89 ca             	mov    %rcx,%r10
    14a9:	0f 05                	syscall
    14ab:	c3                   	ret

00000000000014ac <dup>:
SYSCALL(dup)
    14ac:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    14b3:	49 89 ca             	mov    %rcx,%r10
    14b6:	0f 05                	syscall
    14b8:	c3                   	ret

00000000000014b9 <getpid>:
SYSCALL(getpid)
    14b9:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    14c0:	49 89 ca             	mov    %rcx,%r10
    14c3:	0f 05                	syscall
    14c5:	c3                   	ret

00000000000014c6 <sbrk>:
SYSCALL(sbrk)
    14c6:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    14cd:	49 89 ca             	mov    %rcx,%r10
    14d0:	0f 05                	syscall
    14d2:	c3                   	ret

00000000000014d3 <sleep>:
SYSCALL(sleep)
    14d3:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    14da:	49 89 ca             	mov    %rcx,%r10
    14dd:	0f 05                	syscall
    14df:	c3                   	ret

00000000000014e0 <uptime>:
SYSCALL(uptime)
    14e0:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    14e7:	49 89 ca             	mov    %rcx,%r10
    14ea:	0f 05                	syscall
    14ec:	c3                   	ret

00000000000014ed <send>:
SYSCALL(send)
    14ed:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    14f4:	49 89 ca             	mov    %rcx,%r10
    14f7:	0f 05                	syscall
    14f9:	c3                   	ret

00000000000014fa <recv>:
SYSCALL(recv)
    14fa:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    1501:	49 89 ca             	mov    %rcx,%r10
    1504:	0f 05                	syscall
    1506:	c3                   	ret

0000000000001507 <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    1507:	55                   	push   %rbp
    1508:	48 89 e5             	mov    %rsp,%rbp
    150b:	48 83 ec 10          	sub    $0x10,%rsp
    150f:	89 7d fc             	mov    %edi,-0x4(%rbp)
    1512:	89 f0                	mov    %esi,%eax
    1514:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    1517:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    151b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    151e:	ba 01 00 00 00       	mov    $0x1,%edx
    1523:	48 89 ce             	mov    %rcx,%rsi
    1526:	89 c7                	mov    %eax,%edi
    1528:	48 b8 1d 14 00 00 00 	movabs $0x141d,%rax
    152f:	00 00 00 
    1532:	ff d0                	call   *%rax
}
    1534:	90                   	nop
    1535:	c9                   	leave
    1536:	c3                   	ret

0000000000001537 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    1537:	55                   	push   %rbp
    1538:	48 89 e5             	mov    %rsp,%rbp
    153b:	48 83 ec 20          	sub    $0x20,%rsp
    153f:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1542:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1546:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    154d:	eb 35                	jmp    1584 <print_x64+0x4d>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    154f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1553:	48 c1 e8 3c          	shr    $0x3c,%rax
    1557:	48 ba 40 1e 00 00 00 	movabs $0x1e40,%rdx
    155e:	00 00 00 
    1561:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1565:	0f be d0             	movsbl %al,%edx
    1568:	8b 45 ec             	mov    -0x14(%rbp),%eax
    156b:	89 d6                	mov    %edx,%esi
    156d:	89 c7                	mov    %eax,%edi
    156f:	48 b8 07 15 00 00 00 	movabs $0x1507,%rax
    1576:	00 00 00 
    1579:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    157b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    157f:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    1584:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1587:	83 f8 0f             	cmp    $0xf,%eax
    158a:	76 c3                	jbe    154f <print_x64+0x18>
}
    158c:	90                   	nop
    158d:	90                   	nop
    158e:	c9                   	leave
    158f:	c3                   	ret

0000000000001590 <print_x32>:

  static void
print_x32(int fd, uint x)
{
    1590:	55                   	push   %rbp
    1591:	48 89 e5             	mov    %rsp,%rbp
    1594:	48 83 ec 20          	sub    $0x20,%rsp
    1598:	89 7d ec             	mov    %edi,-0x14(%rbp)
    159b:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    159e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    15a5:	eb 36                	jmp    15dd <print_x32+0x4d>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    15a7:	8b 45 e8             	mov    -0x18(%rbp),%eax
    15aa:	c1 e8 1c             	shr    $0x1c,%eax
    15ad:	89 c2                	mov    %eax,%edx
    15af:	48 b8 40 1e 00 00 00 	movabs $0x1e40,%rax
    15b6:	00 00 00 
    15b9:	89 d2                	mov    %edx,%edx
    15bb:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    15bf:	0f be d0             	movsbl %al,%edx
    15c2:	8b 45 ec             	mov    -0x14(%rbp),%eax
    15c5:	89 d6                	mov    %edx,%esi
    15c7:	89 c7                	mov    %eax,%edi
    15c9:	48 b8 07 15 00 00 00 	movabs $0x1507,%rax
    15d0:	00 00 00 
    15d3:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    15d5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    15d9:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    15dd:	8b 45 fc             	mov    -0x4(%rbp),%eax
    15e0:	83 f8 07             	cmp    $0x7,%eax
    15e3:	76 c2                	jbe    15a7 <print_x32+0x17>
}
    15e5:	90                   	nop
    15e6:	90                   	nop
    15e7:	c9                   	leave
    15e8:	c3                   	ret

00000000000015e9 <print_d>:

  static void
print_d(int fd, int v)
{
    15e9:	55                   	push   %rbp
    15ea:	48 89 e5             	mov    %rsp,%rbp
    15ed:	48 83 ec 30          	sub    $0x30,%rsp
    15f1:	89 7d dc             	mov    %edi,-0x24(%rbp)
    15f4:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    15f7:	8b 45 d8             	mov    -0x28(%rbp),%eax
    15fa:	48 98                	cltq
    15fc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    1600:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1604:	79 04                	jns    160a <print_d+0x21>
    x = -x;
    1606:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    160a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    1611:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1615:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    161c:	66 66 66 
    161f:	48 89 c8             	mov    %rcx,%rax
    1622:	48 f7 ea             	imul   %rdx
    1625:	48 c1 fa 02          	sar    $0x2,%rdx
    1629:	48 89 c8             	mov    %rcx,%rax
    162c:	48 c1 f8 3f          	sar    $0x3f,%rax
    1630:	48 29 c2             	sub    %rax,%rdx
    1633:	48 89 d0             	mov    %rdx,%rax
    1636:	48 c1 e0 02          	shl    $0x2,%rax
    163a:	48 01 d0             	add    %rdx,%rax
    163d:	48 01 c0             	add    %rax,%rax
    1640:	48 29 c1             	sub    %rax,%rcx
    1643:	48 89 ca             	mov    %rcx,%rdx
    1646:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1649:	8d 48 01             	lea    0x1(%rax),%ecx
    164c:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    164f:	48 b9 40 1e 00 00 00 	movabs $0x1e40,%rcx
    1656:	00 00 00 
    1659:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    165d:	48 98                	cltq
    165f:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    1663:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1667:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    166e:	66 66 66 
    1671:	48 89 c8             	mov    %rcx,%rax
    1674:	48 f7 ea             	imul   %rdx
    1677:	48 89 d0             	mov    %rdx,%rax
    167a:	48 c1 f8 02          	sar    $0x2,%rax
    167e:	48 c1 f9 3f          	sar    $0x3f,%rcx
    1682:	48 89 ca             	mov    %rcx,%rdx
    1685:	48 29 d0             	sub    %rdx,%rax
    1688:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    168c:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1691:	0f 85 7a ff ff ff    	jne    1611 <print_d+0x28>

  if (v < 0)
    1697:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    169b:	79 32                	jns    16cf <print_d+0xe6>
    buf[i++] = '-';
    169d:	8b 45 f4             	mov    -0xc(%rbp),%eax
    16a0:	8d 50 01             	lea    0x1(%rax),%edx
    16a3:	89 55 f4             	mov    %edx,-0xc(%rbp)
    16a6:	48 98                	cltq
    16a8:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    16ad:	eb 20                	jmp    16cf <print_d+0xe6>
    putc(fd, buf[i]);
    16af:	8b 45 f4             	mov    -0xc(%rbp),%eax
    16b2:	48 98                	cltq
    16b4:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    16b9:	0f be d0             	movsbl %al,%edx
    16bc:	8b 45 dc             	mov    -0x24(%rbp),%eax
    16bf:	89 d6                	mov    %edx,%esi
    16c1:	89 c7                	mov    %eax,%edi
    16c3:	48 b8 07 15 00 00 00 	movabs $0x1507,%rax
    16ca:	00 00 00 
    16cd:	ff d0                	call   *%rax
  while (--i >= 0)
    16cf:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    16d3:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    16d7:	79 d6                	jns    16af <print_d+0xc6>
}
    16d9:	90                   	nop
    16da:	90                   	nop
    16db:	c9                   	leave
    16dc:	c3                   	ret

00000000000016dd <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    16dd:	55                   	push   %rbp
    16de:	48 89 e5             	mov    %rsp,%rbp
    16e1:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    16e8:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    16ee:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    16f5:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    16fc:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    1703:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    170a:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    1711:	84 c0                	test   %al,%al
    1713:	74 20                	je     1735 <printf+0x58>
    1715:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    1719:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    171d:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    1721:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    1725:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    1729:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    172d:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    1731:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    1735:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    173c:	00 00 00 
    173f:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    1746:	00 00 00 
    1749:	48 8d 45 10          	lea    0x10(%rbp),%rax
    174d:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    1754:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    175b:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1762:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    1769:	00 00 00 
    176c:	e9 60 03 00 00       	jmp    1ad1 <printf+0x3f4>
    if (c != '%') {
    1771:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1778:	74 24                	je     179e <printf+0xc1>
      putc(fd, c);
    177a:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1780:	0f be d0             	movsbl %al,%edx
    1783:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1789:	89 d6                	mov    %edx,%esi
    178b:	89 c7                	mov    %eax,%edi
    178d:	48 b8 07 15 00 00 00 	movabs $0x1507,%rax
    1794:	00 00 00 
    1797:	ff d0                	call   *%rax
      continue;
    1799:	e9 2c 03 00 00       	jmp    1aca <printf+0x3ed>
    }
    c = fmt[++i] & 0xff;
    179e:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    17a5:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    17ab:	48 63 d0             	movslq %eax,%rdx
    17ae:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    17b5:	48 01 d0             	add    %rdx,%rax
    17b8:	0f b6 00             	movzbl (%rax),%eax
    17bb:	0f be c0             	movsbl %al,%eax
    17be:	25 ff 00 00 00       	and    $0xff,%eax
    17c3:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    17c9:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    17d0:	0f 84 2e 03 00 00    	je     1b04 <printf+0x427>
      break;
    switch(c) {
    17d6:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    17dd:	0f 84 32 01 00 00    	je     1915 <printf+0x238>
    17e3:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    17ea:	0f 8f a1 02 00 00    	jg     1a91 <printf+0x3b4>
    17f0:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    17f7:	0f 84 d4 01 00 00    	je     19d1 <printf+0x2f4>
    17fd:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    1804:	0f 8f 87 02 00 00    	jg     1a91 <printf+0x3b4>
    180a:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    1811:	0f 84 5b 01 00 00    	je     1972 <printf+0x295>
    1817:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    181e:	0f 8f 6d 02 00 00    	jg     1a91 <printf+0x3b4>
    1824:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    182b:	0f 84 87 00 00 00    	je     18b8 <printf+0x1db>
    1831:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    1838:	0f 8f 53 02 00 00    	jg     1a91 <printf+0x3b4>
    183e:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1845:	0f 84 2b 02 00 00    	je     1a76 <printf+0x399>
    184b:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    1852:	0f 85 39 02 00 00    	jne    1a91 <printf+0x3b4>
    case 'c':
      putc(fd, va_arg(ap, int));
    1858:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    185e:	83 f8 2f             	cmp    $0x2f,%eax
    1861:	77 23                	ja     1886 <printf+0x1a9>
    1863:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    186a:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1870:	89 d2                	mov    %edx,%edx
    1872:	48 01 d0             	add    %rdx,%rax
    1875:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    187b:	83 c2 08             	add    $0x8,%edx
    187e:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1884:	eb 12                	jmp    1898 <printf+0x1bb>
    1886:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    188d:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1891:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1898:	8b 00                	mov    (%rax),%eax
    189a:	0f be d0             	movsbl %al,%edx
    189d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    18a3:	89 d6                	mov    %edx,%esi
    18a5:	89 c7                	mov    %eax,%edi
    18a7:	48 b8 07 15 00 00 00 	movabs $0x1507,%rax
    18ae:	00 00 00 
    18b1:	ff d0                	call   *%rax
      break;
    18b3:	e9 12 02 00 00       	jmp    1aca <printf+0x3ed>
    case 'd':
      print_d(fd, va_arg(ap, int));
    18b8:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    18be:	83 f8 2f             	cmp    $0x2f,%eax
    18c1:	77 23                	ja     18e6 <printf+0x209>
    18c3:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    18ca:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18d0:	89 d2                	mov    %edx,%edx
    18d2:	48 01 d0             	add    %rdx,%rax
    18d5:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18db:	83 c2 08             	add    $0x8,%edx
    18de:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    18e4:	eb 12                	jmp    18f8 <printf+0x21b>
    18e6:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    18ed:	48 8d 50 08          	lea    0x8(%rax),%rdx
    18f1:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    18f8:	8b 10                	mov    (%rax),%edx
    18fa:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1900:	89 d6                	mov    %edx,%esi
    1902:	89 c7                	mov    %eax,%edi
    1904:	48 b8 e9 15 00 00 00 	movabs $0x15e9,%rax
    190b:	00 00 00 
    190e:	ff d0                	call   *%rax
      break;
    1910:	e9 b5 01 00 00       	jmp    1aca <printf+0x3ed>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    1915:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    191b:	83 f8 2f             	cmp    $0x2f,%eax
    191e:	77 23                	ja     1943 <printf+0x266>
    1920:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1927:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    192d:	89 d2                	mov    %edx,%edx
    192f:	48 01 d0             	add    %rdx,%rax
    1932:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1938:	83 c2 08             	add    $0x8,%edx
    193b:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1941:	eb 12                	jmp    1955 <printf+0x278>
    1943:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    194a:	48 8d 50 08          	lea    0x8(%rax),%rdx
    194e:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1955:	8b 10                	mov    (%rax),%edx
    1957:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    195d:	89 d6                	mov    %edx,%esi
    195f:	89 c7                	mov    %eax,%edi
    1961:	48 b8 90 15 00 00 00 	movabs $0x1590,%rax
    1968:	00 00 00 
    196b:	ff d0                	call   *%rax
      break;
    196d:	e9 58 01 00 00       	jmp    1aca <printf+0x3ed>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    1972:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1978:	83 f8 2f             	cmp    $0x2f,%eax
    197b:	77 23                	ja     19a0 <printf+0x2c3>
    197d:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1984:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    198a:	89 d2                	mov    %edx,%edx
    198c:	48 01 d0             	add    %rdx,%rax
    198f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1995:	83 c2 08             	add    $0x8,%edx
    1998:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    199e:	eb 12                	jmp    19b2 <printf+0x2d5>
    19a0:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    19a7:	48 8d 50 08          	lea    0x8(%rax),%rdx
    19ab:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    19b2:	48 8b 10             	mov    (%rax),%rdx
    19b5:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    19bb:	48 89 d6             	mov    %rdx,%rsi
    19be:	89 c7                	mov    %eax,%edi
    19c0:	48 b8 37 15 00 00 00 	movabs $0x1537,%rax
    19c7:	00 00 00 
    19ca:	ff d0                	call   *%rax
      break;
    19cc:	e9 f9 00 00 00       	jmp    1aca <printf+0x3ed>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    19d1:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    19d7:	83 f8 2f             	cmp    $0x2f,%eax
    19da:	77 23                	ja     19ff <printf+0x322>
    19dc:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    19e3:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19e9:	89 d2                	mov    %edx,%edx
    19eb:	48 01 d0             	add    %rdx,%rax
    19ee:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19f4:	83 c2 08             	add    $0x8,%edx
    19f7:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    19fd:	eb 12                	jmp    1a11 <printf+0x334>
    19ff:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a06:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a0a:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a11:	48 8b 00             	mov    (%rax),%rax
    1a14:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    1a1b:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1a22:	00 
    1a23:	75 41                	jne    1a66 <printf+0x389>
        s = "(null)";
    1a25:	48 b8 2c 1e 00 00 00 	movabs $0x1e2c,%rax
    1a2c:	00 00 00 
    1a2f:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1a36:	eb 2e                	jmp    1a66 <printf+0x389>
        putc(fd, *(s++));
    1a38:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1a3f:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1a43:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1a4a:	0f b6 00             	movzbl (%rax),%eax
    1a4d:	0f be d0             	movsbl %al,%edx
    1a50:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a56:	89 d6                	mov    %edx,%esi
    1a58:	89 c7                	mov    %eax,%edi
    1a5a:	48 b8 07 15 00 00 00 	movabs $0x1507,%rax
    1a61:	00 00 00 
    1a64:	ff d0                	call   *%rax
      while (*s)
    1a66:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1a6d:	0f b6 00             	movzbl (%rax),%eax
    1a70:	84 c0                	test   %al,%al
    1a72:	75 c4                	jne    1a38 <printf+0x35b>
      break;
    1a74:	eb 54                	jmp    1aca <printf+0x3ed>
    case '%':
      putc(fd, '%');
    1a76:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a7c:	be 25 00 00 00       	mov    $0x25,%esi
    1a81:	89 c7                	mov    %eax,%edi
    1a83:	48 b8 07 15 00 00 00 	movabs $0x1507,%rax
    1a8a:	00 00 00 
    1a8d:	ff d0                	call   *%rax
      break;
    1a8f:	eb 39                	jmp    1aca <printf+0x3ed>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1a91:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a97:	be 25 00 00 00       	mov    $0x25,%esi
    1a9c:	89 c7                	mov    %eax,%edi
    1a9e:	48 b8 07 15 00 00 00 	movabs $0x1507,%rax
    1aa5:	00 00 00 
    1aa8:	ff d0                	call   *%rax
      putc(fd, c);
    1aaa:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1ab0:	0f be d0             	movsbl %al,%edx
    1ab3:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1ab9:	89 d6                	mov    %edx,%esi
    1abb:	89 c7                	mov    %eax,%edi
    1abd:	48 b8 07 15 00 00 00 	movabs $0x1507,%rax
    1ac4:	00 00 00 
    1ac7:	ff d0                	call   *%rax
      break;
    1ac9:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1aca:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1ad1:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1ad7:	48 63 d0             	movslq %eax,%rdx
    1ada:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1ae1:	48 01 d0             	add    %rdx,%rax
    1ae4:	0f b6 00             	movzbl (%rax),%eax
    1ae7:	0f be c0             	movsbl %al,%eax
    1aea:	25 ff 00 00 00       	and    $0xff,%eax
    1aef:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1af5:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1afc:	0f 85 6f fc ff ff    	jne    1771 <printf+0x94>
    }
  }
}
    1b02:	eb 01                	jmp    1b05 <printf+0x428>
      break;
    1b04:	90                   	nop
}
    1b05:	90                   	nop
    1b06:	c9                   	leave
    1b07:	c3                   	ret

0000000000001b08 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1b08:	55                   	push   %rbp
    1b09:	48 89 e5             	mov    %rsp,%rbp
    1b0c:	48 83 ec 18          	sub    $0x18,%rsp
    1b10:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1b14:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1b18:	48 83 e8 10          	sub    $0x10,%rax
    1b1c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1b20:	48 b8 70 1e 00 00 00 	movabs $0x1e70,%rax
    1b27:	00 00 00 
    1b2a:	48 8b 00             	mov    (%rax),%rax
    1b2d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1b31:	eb 2f                	jmp    1b62 <free+0x5a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1b33:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b37:	48 8b 00             	mov    (%rax),%rax
    1b3a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b3e:	72 17                	jb     1b57 <free+0x4f>
    1b40:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b44:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b48:	72 2f                	jb     1b79 <free+0x71>
    1b4a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b4e:	48 8b 00             	mov    (%rax),%rax
    1b51:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1b55:	72 22                	jb     1b79 <free+0x71>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1b57:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b5b:	48 8b 00             	mov    (%rax),%rax
    1b5e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1b62:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b66:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b6a:	73 c7                	jae    1b33 <free+0x2b>
    1b6c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b70:	48 8b 00             	mov    (%rax),%rax
    1b73:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1b77:	73 ba                	jae    1b33 <free+0x2b>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1b79:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b7d:	8b 40 08             	mov    0x8(%rax),%eax
    1b80:	89 c0                	mov    %eax,%eax
    1b82:	48 c1 e0 04          	shl    $0x4,%rax
    1b86:	48 89 c2             	mov    %rax,%rdx
    1b89:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b8d:	48 01 c2             	add    %rax,%rdx
    1b90:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b94:	48 8b 00             	mov    (%rax),%rax
    1b97:	48 39 c2             	cmp    %rax,%rdx
    1b9a:	75 2d                	jne    1bc9 <free+0xc1>
    bp->s.size += p->s.ptr->s.size;
    1b9c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ba0:	8b 50 08             	mov    0x8(%rax),%edx
    1ba3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ba7:	48 8b 00             	mov    (%rax),%rax
    1baa:	8b 40 08             	mov    0x8(%rax),%eax
    1bad:	01 c2                	add    %eax,%edx
    1baf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bb3:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1bb6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bba:	48 8b 00             	mov    (%rax),%rax
    1bbd:	48 8b 10             	mov    (%rax),%rdx
    1bc0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bc4:	48 89 10             	mov    %rdx,(%rax)
    1bc7:	eb 0e                	jmp    1bd7 <free+0xcf>
  } else
    bp->s.ptr = p->s.ptr;
    1bc9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bcd:	48 8b 10             	mov    (%rax),%rdx
    1bd0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bd4:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    1bd7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bdb:	8b 40 08             	mov    0x8(%rax),%eax
    1bde:	89 c0                	mov    %eax,%eax
    1be0:	48 c1 e0 04          	shl    $0x4,%rax
    1be4:	48 89 c2             	mov    %rax,%rdx
    1be7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1beb:	48 01 d0             	add    %rdx,%rax
    1bee:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1bf2:	75 27                	jne    1c1b <free+0x113>
    p->s.size += bp->s.size;
    1bf4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bf8:	8b 50 08             	mov    0x8(%rax),%edx
    1bfb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bff:	8b 40 08             	mov    0x8(%rax),%eax
    1c02:	01 c2                	add    %eax,%edx
    1c04:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c08:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    1c0b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c0f:	48 8b 10             	mov    (%rax),%rdx
    1c12:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c16:	48 89 10             	mov    %rdx,(%rax)
    1c19:	eb 0b                	jmp    1c26 <free+0x11e>
  } else
    p->s.ptr = bp;
    1c1b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c1f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1c23:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    1c26:	48 ba 70 1e 00 00 00 	movabs $0x1e70,%rdx
    1c2d:	00 00 00 
    1c30:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c34:	48 89 02             	mov    %rax,(%rdx)
}
    1c37:	90                   	nop
    1c38:	c9                   	leave
    1c39:	c3                   	ret

0000000000001c3a <morecore>:

static Header*
morecore(uint nu)
{
    1c3a:	55                   	push   %rbp
    1c3b:	48 89 e5             	mov    %rsp,%rbp
    1c3e:	48 83 ec 20          	sub    $0x20,%rsp
    1c42:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    1c45:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1c4c:	77 07                	ja     1c55 <morecore+0x1b>
    nu = 4096;
    1c4e:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    1c55:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1c58:	48 c1 e0 04          	shl    $0x4,%rax
    1c5c:	48 89 c7             	mov    %rax,%rdi
    1c5f:	48 b8 c6 14 00 00 00 	movabs $0x14c6,%rax
    1c66:	00 00 00 
    1c69:	ff d0                	call   *%rax
    1c6b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    1c6f:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1c74:	75 07                	jne    1c7d <morecore+0x43>
    return 0;
    1c76:	b8 00 00 00 00       	mov    $0x0,%eax
    1c7b:	eb 36                	jmp    1cb3 <morecore+0x79>
  hp = (Header*)p;
    1c7d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c81:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    1c85:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c89:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1c8c:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    1c8f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c93:	48 83 c0 10          	add    $0x10,%rax
    1c97:	48 89 c7             	mov    %rax,%rdi
    1c9a:	48 b8 08 1b 00 00 00 	movabs $0x1b08,%rax
    1ca1:	00 00 00 
    1ca4:	ff d0                	call   *%rax
  return freep;
    1ca6:	48 b8 70 1e 00 00 00 	movabs $0x1e70,%rax
    1cad:	00 00 00 
    1cb0:	48 8b 00             	mov    (%rax),%rax
}
    1cb3:	c9                   	leave
    1cb4:	c3                   	ret

0000000000001cb5 <malloc>:

void*
malloc(uint nbytes)
{
    1cb5:	55                   	push   %rbp
    1cb6:	48 89 e5             	mov    %rsp,%rbp
    1cb9:	48 83 ec 30          	sub    $0x30,%rsp
    1cbd:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1cc0:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1cc3:	48 83 c0 0f          	add    $0xf,%rax
    1cc7:	48 c1 e8 04          	shr    $0x4,%rax
    1ccb:	83 c0 01             	add    $0x1,%eax
    1cce:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    1cd1:	48 b8 70 1e 00 00 00 	movabs $0x1e70,%rax
    1cd8:	00 00 00 
    1cdb:	48 8b 00             	mov    (%rax),%rax
    1cde:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1ce2:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1ce7:	75 4a                	jne    1d33 <malloc+0x7e>
    base.s.ptr = freep = prevp = &base;
    1ce9:	48 b8 60 1e 00 00 00 	movabs $0x1e60,%rax
    1cf0:	00 00 00 
    1cf3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1cf7:	48 ba 70 1e 00 00 00 	movabs $0x1e70,%rdx
    1cfe:	00 00 00 
    1d01:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d05:	48 89 02             	mov    %rax,(%rdx)
    1d08:	48 b8 70 1e 00 00 00 	movabs $0x1e70,%rax
    1d0f:	00 00 00 
    1d12:	48 8b 00             	mov    (%rax),%rax
    1d15:	48 ba 60 1e 00 00 00 	movabs $0x1e60,%rdx
    1d1c:	00 00 00 
    1d1f:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    1d22:	48 b8 60 1e 00 00 00 	movabs $0x1e60,%rax
    1d29:	00 00 00 
    1d2c:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1d33:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d37:	48 8b 00             	mov    (%rax),%rax
    1d3a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1d3e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d42:	8b 40 08             	mov    0x8(%rax),%eax
    1d45:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1d48:	72 65                	jb     1daf <malloc+0xfa>
      if(p->s.size == nunits)
    1d4a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d4e:	8b 40 08             	mov    0x8(%rax),%eax
    1d51:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1d54:	75 10                	jne    1d66 <malloc+0xb1>
        prevp->s.ptr = p->s.ptr;
    1d56:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d5a:	48 8b 10             	mov    (%rax),%rdx
    1d5d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d61:	48 89 10             	mov    %rdx,(%rax)
    1d64:	eb 2e                	jmp    1d94 <malloc+0xdf>
      else {
        p->s.size -= nunits;
    1d66:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d6a:	8b 40 08             	mov    0x8(%rax),%eax
    1d6d:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1d70:	89 c2                	mov    %eax,%edx
    1d72:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d76:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    1d79:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d7d:	8b 40 08             	mov    0x8(%rax),%eax
    1d80:	89 c0                	mov    %eax,%eax
    1d82:	48 c1 e0 04          	shl    $0x4,%rax
    1d86:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    1d8a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d8e:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1d91:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    1d94:	48 ba 70 1e 00 00 00 	movabs $0x1e70,%rdx
    1d9b:	00 00 00 
    1d9e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1da2:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    1da5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1da9:	48 83 c0 10          	add    $0x10,%rax
    1dad:	eb 4e                	jmp    1dfd <malloc+0x148>
    }
    if(p == freep)
    1daf:	48 b8 70 1e 00 00 00 	movabs $0x1e70,%rax
    1db6:	00 00 00 
    1db9:	48 8b 00             	mov    (%rax),%rax
    1dbc:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1dc0:	75 23                	jne    1de5 <malloc+0x130>
      if((p = morecore(nunits)) == 0)
    1dc2:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1dc5:	89 c7                	mov    %eax,%edi
    1dc7:	48 b8 3a 1c 00 00 00 	movabs $0x1c3a,%rax
    1dce:	00 00 00 
    1dd1:	ff d0                	call   *%rax
    1dd3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1dd7:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1ddc:	75 07                	jne    1de5 <malloc+0x130>
        return 0;
    1dde:	b8 00 00 00 00       	mov    $0x0,%eax
    1de3:	eb 18                	jmp    1dfd <malloc+0x148>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1de5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1de9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1ded:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1df1:	48 8b 00             	mov    (%rax),%rax
    1df4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1df8:	e9 41 ff ff ff       	jmp    1d3e <malloc+0x89>
  }
}
    1dfd:	c9                   	leave
    1dfe:	c3                   	ret
