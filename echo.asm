
_echo:     file format elf64-x86-64


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

  for(i = 1; i < argc; i++)
    1013:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
    101a:	eb 64                	jmp    1080 <main+0x80>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
    101c:	8b 45 fc             	mov    -0x4(%rbp),%eax
    101f:	83 c0 01             	add    $0x1,%eax
    1022:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1025:	7e 0c                	jle    1033 <main+0x33>
    1027:	48 b8 e8 1d 00 00 00 	movabs $0x1de8,%rax
    102e:	00 00 00 
    1031:	eb 0a                	jmp    103d <main+0x3d>
    1033:	48 b8 ea 1d 00 00 00 	movabs $0x1dea,%rax
    103a:	00 00 00 
    103d:	8b 55 fc             	mov    -0x4(%rbp),%edx
    1040:	48 63 d2             	movslq %edx,%rdx
    1043:	48 8d 0c d5 00 00 00 	lea    0x0(,%rdx,8),%rcx
    104a:	00 
    104b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    104f:	48 01 ca             	add    %rcx,%rdx
    1052:	48 8b 12             	mov    (%rdx),%rdx
    1055:	48 89 c1             	mov    %rax,%rcx
    1058:	48 b8 ec 1d 00 00 00 	movabs $0x1dec,%rax
    105f:	00 00 00 
    1062:	48 89 c6             	mov    %rax,%rsi
    1065:	bf 01 00 00 00       	mov    $0x1,%edi
    106a:	b8 00 00 00 00       	mov    $0x0,%eax
    106f:	49 b8 db 16 00 00 00 	movabs $0x16db,%r8
    1076:	00 00 00 
    1079:	41 ff d0             	call   *%r8
  for(i = 1; i < argc; i++)
    107c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1080:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1083:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1086:	7c 94                	jl     101c <main+0x1c>
  exit();
    1088:	48 b8 d7 13 00 00 00 	movabs $0x13d7,%rax
    108f:	00 00 00 
    1092:	ff d0                	call   *%rax

0000000000001094 <stosb>:
  stosb(dst, c, n);
  return dst;
}

char*
strchr(const char *s, char c)
    1094:	f3 0f 1e fa          	endbr64
    1098:	55                   	push   %rbp
    1099:	48 89 e5             	mov    %rsp,%rbp
    109c:	48 83 ec 10          	sub    $0x10,%rsp
    10a0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    10a4:	89 75 f4             	mov    %esi,-0xc(%rbp)
    10a7:	89 55 f0             	mov    %edx,-0x10(%rbp)
{
    10aa:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    10ae:	8b 55 f0             	mov    -0x10(%rbp),%edx
    10b1:	8b 45 f4             	mov    -0xc(%rbp),%eax
    10b4:	48 89 ce             	mov    %rcx,%rsi
    10b7:	48 89 f7             	mov    %rsi,%rdi
    10ba:	89 d1                	mov    %edx,%ecx
    10bc:	fc                   	cld
    10bd:	f3 aa                	rep stos %al,%es:(%rdi)
    10bf:	89 ca                	mov    %ecx,%edx
    10c1:	48 89 fe             	mov    %rdi,%rsi
    10c4:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    10c8:	89 55 f0             	mov    %edx,-0x10(%rbp)
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
    10cb:	90                   	nop
    10cc:	c9                   	leave
    10cd:	c3                   	ret

00000000000010ce <strcpy>:
{
    10ce:	f3 0f 1e fa          	endbr64
    10d2:	55                   	push   %rbp
    10d3:	48 89 e5             	mov    %rsp,%rbp
    10d6:	48 83 ec 20          	sub    $0x20,%rsp
    10da:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    10de:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  os = s;
    10e2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    10e6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    10ea:	90                   	nop
    10eb:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    10ef:	48 8d 42 01          	lea    0x1(%rdx),%rax
    10f3:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    10f7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    10fb:	48 8d 48 01          	lea    0x1(%rax),%rcx
    10ff:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    1103:	0f b6 12             	movzbl (%rdx),%edx
    1106:	88 10                	mov    %dl,(%rax)
    1108:	0f b6 00             	movzbl (%rax),%eax
    110b:	84 c0                	test   %al,%al
    110d:	75 dc                	jne    10eb <strcpy+0x1d>
  return os;
    110f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    1113:	c9                   	leave
    1114:	c3                   	ret

0000000000001115 <strcmp>:
{
    1115:	f3 0f 1e fa          	endbr64
    1119:	55                   	push   %rbp
    111a:	48 89 e5             	mov    %rsp,%rbp
    111d:	48 83 ec 10          	sub    $0x10,%rsp
    1121:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1125:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    1129:	eb 0a                	jmp    1135 <strcmp+0x20>
    p++, q++;
    112b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1130:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    1135:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1139:	0f b6 00             	movzbl (%rax),%eax
    113c:	84 c0                	test   %al,%al
    113e:	74 12                	je     1152 <strcmp+0x3d>
    1140:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1144:	0f b6 10             	movzbl (%rax),%edx
    1147:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    114b:	0f b6 00             	movzbl (%rax),%eax
    114e:	38 c2                	cmp    %al,%dl
    1150:	74 d9                	je     112b <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
    1152:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1156:	0f b6 00             	movzbl (%rax),%eax
    1159:	0f b6 d0             	movzbl %al,%edx
    115c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1160:	0f b6 00             	movzbl (%rax),%eax
    1163:	0f b6 c0             	movzbl %al,%eax
    1166:	29 c2                	sub    %eax,%edx
    1168:	89 d0                	mov    %edx,%eax
}
    116a:	c9                   	leave
    116b:	c3                   	ret

000000000000116c <strlen>:
{
    116c:	f3 0f 1e fa          	endbr64
    1170:	55                   	push   %rbp
    1171:	48 89 e5             	mov    %rsp,%rbp
    1174:	48 83 ec 18          	sub    $0x18,%rsp
    1178:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  for(n = 0; s[n]; n++)
    117c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1183:	eb 04                	jmp    1189 <strlen+0x1d>
    1185:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1189:	8b 45 fc             	mov    -0x4(%rbp),%eax
    118c:	48 63 d0             	movslq %eax,%rdx
    118f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1193:	48 01 d0             	add    %rdx,%rax
    1196:	0f b6 00             	movzbl (%rax),%eax
    1199:	84 c0                	test   %al,%al
    119b:	75 e8                	jne    1185 <strlen+0x19>
  return n;
    119d:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    11a0:	c9                   	leave
    11a1:	c3                   	ret

00000000000011a2 <memset>:
{
    11a2:	f3 0f 1e fa          	endbr64
    11a6:	55                   	push   %rbp
    11a7:	48 89 e5             	mov    %rsp,%rbp
    11aa:	48 83 ec 10          	sub    $0x10,%rsp
    11ae:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    11b2:	89 75 f4             	mov    %esi,-0xc(%rbp)
    11b5:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    11b8:	8b 55 f0             	mov    -0x10(%rbp),%edx
    11bb:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    11be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    11c2:	89 ce                	mov    %ecx,%esi
    11c4:	48 89 c7             	mov    %rax,%rdi
    11c7:	48 b8 94 10 00 00 00 	movabs $0x1094,%rax
    11ce:	00 00 00 
    11d1:	ff d0                	call   *%rax
  return dst;
    11d3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    11d7:	c9                   	leave
    11d8:	c3                   	ret

00000000000011d9 <strchr>:
{
    11d9:	f3 0f 1e fa          	endbr64
    11dd:	55                   	push   %rbp
    11de:	48 89 e5             	mov    %rsp,%rbp
    11e1:	48 83 ec 10          	sub    $0x10,%rsp
    11e5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    11e9:	89 f0                	mov    %esi,%eax
    11eb:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    11ee:	eb 17                	jmp    1207 <strchr+0x2e>
    if(*s == c)
    11f0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    11f4:	0f b6 00             	movzbl (%rax),%eax
    11f7:	38 45 f4             	cmp    %al,-0xc(%rbp)
    11fa:	75 06                	jne    1202 <strchr+0x29>
      return (char*)s;
    11fc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1200:	eb 15                	jmp    1217 <strchr+0x3e>
  for(; *s; s++)
    1202:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1207:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    120b:	0f b6 00             	movzbl (%rax),%eax
    120e:	84 c0                	test   %al,%al
    1210:	75 de                	jne    11f0 <strchr+0x17>
  return 0;
    1212:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1217:	c9                   	leave
    1218:	c3                   	ret

0000000000001219 <gets>:

char*
gets(char *buf, int max)
{
    1219:	f3 0f 1e fa          	endbr64
    121d:	55                   	push   %rbp
    121e:	48 89 e5             	mov    %rsp,%rbp
    1221:	48 83 ec 20          	sub    $0x20,%rsp
    1225:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1229:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    122c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1233:	eb 4f                	jmp    1284 <gets+0x6b>
    cc = read(0, &c, 1);
    1235:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    1239:	ba 01 00 00 00       	mov    $0x1,%edx
    123e:	48 89 c6             	mov    %rax,%rsi
    1241:	bf 00 00 00 00       	mov    $0x0,%edi
    1246:	48 b8 fe 13 00 00 00 	movabs $0x13fe,%rax
    124d:	00 00 00 
    1250:	ff d0                	call   *%rax
    1252:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    1255:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1259:	7e 36                	jle    1291 <gets+0x78>
      break;
    buf[i++] = c;
    125b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    125e:	8d 50 01             	lea    0x1(%rax),%edx
    1261:	89 55 fc             	mov    %edx,-0x4(%rbp)
    1264:	48 63 d0             	movslq %eax,%rdx
    1267:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    126b:	48 01 c2             	add    %rax,%rdx
    126e:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1272:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    1274:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1278:	3c 0a                	cmp    $0xa,%al
    127a:	74 16                	je     1292 <gets+0x79>
    127c:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1280:	3c 0d                	cmp    $0xd,%al
    1282:	74 0e                	je     1292 <gets+0x79>
  for(i=0; i+1 < max; ){
    1284:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1287:	83 c0 01             	add    $0x1,%eax
    128a:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    128d:	7f a6                	jg     1235 <gets+0x1c>
    128f:	eb 01                	jmp    1292 <gets+0x79>
      break;
    1291:	90                   	nop
      break;
  }
  buf[i] = '\0';
    1292:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1295:	48 63 d0             	movslq %eax,%rdx
    1298:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    129c:	48 01 d0             	add    %rdx,%rax
    129f:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    12a2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    12a6:	c9                   	leave
    12a7:	c3                   	ret

00000000000012a8 <stat>:

int
stat(char *n, struct stat *st)
{
    12a8:	f3 0f 1e fa          	endbr64
    12ac:	55                   	push   %rbp
    12ad:	48 89 e5             	mov    %rsp,%rbp
    12b0:	48 83 ec 20          	sub    $0x20,%rsp
    12b4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    12b8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    12bc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12c0:	be 00 00 00 00       	mov    $0x0,%esi
    12c5:	48 89 c7             	mov    %rax,%rdi
    12c8:	48 b8 3f 14 00 00 00 	movabs $0x143f,%rax
    12cf:	00 00 00 
    12d2:	ff d0                	call   *%rax
    12d4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    12d7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    12db:	79 07                	jns    12e4 <stat+0x3c>
    return -1;
    12dd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    12e2:	eb 2f                	jmp    1313 <stat+0x6b>
  r = fstat(fd, st);
    12e4:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    12e8:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12eb:	48 89 d6             	mov    %rdx,%rsi
    12ee:	89 c7                	mov    %eax,%edi
    12f0:	48 b8 66 14 00 00 00 	movabs $0x1466,%rax
    12f7:	00 00 00 
    12fa:	ff d0                	call   *%rax
    12fc:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    12ff:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1302:	89 c7                	mov    %eax,%edi
    1304:	48 b8 18 14 00 00 00 	movabs $0x1418,%rax
    130b:	00 00 00 
    130e:	ff d0                	call   *%rax
  return r;
    1310:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    1313:	c9                   	leave
    1314:	c3                   	ret

0000000000001315 <atoi>:

int
atoi(const char *s)
{
    1315:	f3 0f 1e fa          	endbr64
    1319:	55                   	push   %rbp
    131a:	48 89 e5             	mov    %rsp,%rbp
    131d:	48 83 ec 18          	sub    $0x18,%rsp
    1321:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    1325:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    132c:	eb 28                	jmp    1356 <atoi+0x41>
    n = n*10 + *s++ - '0';
    132e:	8b 55 fc             	mov    -0x4(%rbp),%edx
    1331:	89 d0                	mov    %edx,%eax
    1333:	c1 e0 02             	shl    $0x2,%eax
    1336:	01 d0                	add    %edx,%eax
    1338:	01 c0                	add    %eax,%eax
    133a:	89 c1                	mov    %eax,%ecx
    133c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1340:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1344:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    1348:	0f b6 00             	movzbl (%rax),%eax
    134b:	0f be c0             	movsbl %al,%eax
    134e:	01 c8                	add    %ecx,%eax
    1350:	83 e8 30             	sub    $0x30,%eax
    1353:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1356:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    135a:	0f b6 00             	movzbl (%rax),%eax
    135d:	3c 2f                	cmp    $0x2f,%al
    135f:	7e 0b                	jle    136c <atoi+0x57>
    1361:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1365:	0f b6 00             	movzbl (%rax),%eax
    1368:	3c 39                	cmp    $0x39,%al
    136a:	7e c2                	jle    132e <atoi+0x19>
  return n;
    136c:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    136f:	c9                   	leave
    1370:	c3                   	ret

0000000000001371 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1371:	f3 0f 1e fa          	endbr64
    1375:	55                   	push   %rbp
    1376:	48 89 e5             	mov    %rsp,%rbp
    1379:	48 83 ec 28          	sub    $0x28,%rsp
    137d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1381:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    1385:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    1388:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    138c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    1390:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1394:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    1398:	eb 1d                	jmp    13b7 <memmove+0x46>
    *dst++ = *src++;
    139a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    139e:	48 8d 42 01          	lea    0x1(%rdx),%rax
    13a2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    13a6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13aa:	48 8d 48 01          	lea    0x1(%rax),%rcx
    13ae:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    13b2:	0f b6 12             	movzbl (%rdx),%edx
    13b5:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    13b7:	8b 45 dc             	mov    -0x24(%rbp),%eax
    13ba:	8d 50 ff             	lea    -0x1(%rax),%edx
    13bd:	89 55 dc             	mov    %edx,-0x24(%rbp)
    13c0:	85 c0                	test   %eax,%eax
    13c2:	7f d6                	jg     139a <memmove+0x29>
  return vdst;
    13c4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    13c8:	c9                   	leave
    13c9:	c3                   	ret

00000000000013ca <fork>:
    13ca:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    13d1:	49 89 ca             	mov    %rcx,%r10
    13d4:	0f 05                	syscall
    13d6:	c3                   	ret

00000000000013d7 <exit>:
    13d7:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    13de:	49 89 ca             	mov    %rcx,%r10
    13e1:	0f 05                	syscall
    13e3:	c3                   	ret

00000000000013e4 <wait>:
    13e4:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    13eb:	49 89 ca             	mov    %rcx,%r10
    13ee:	0f 05                	syscall
    13f0:	c3                   	ret

00000000000013f1 <pipe>:
    13f1:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    13f8:	49 89 ca             	mov    %rcx,%r10
    13fb:	0f 05                	syscall
    13fd:	c3                   	ret

00000000000013fe <read>:
    13fe:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    1405:	49 89 ca             	mov    %rcx,%r10
    1408:	0f 05                	syscall
    140a:	c3                   	ret

000000000000140b <write>:
    140b:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    1412:	49 89 ca             	mov    %rcx,%r10
    1415:	0f 05                	syscall
    1417:	c3                   	ret

0000000000001418 <close>:
    1418:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    141f:	49 89 ca             	mov    %rcx,%r10
    1422:	0f 05                	syscall
    1424:	c3                   	ret

0000000000001425 <kill>:
    1425:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    142c:	49 89 ca             	mov    %rcx,%r10
    142f:	0f 05                	syscall
    1431:	c3                   	ret

0000000000001432 <exec>:
    1432:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    1439:	49 89 ca             	mov    %rcx,%r10
    143c:	0f 05                	syscall
    143e:	c3                   	ret

000000000000143f <open>:
    143f:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    1446:	49 89 ca             	mov    %rcx,%r10
    1449:	0f 05                	syscall
    144b:	c3                   	ret

000000000000144c <mknod>:
    144c:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    1453:	49 89 ca             	mov    %rcx,%r10
    1456:	0f 05                	syscall
    1458:	c3                   	ret

0000000000001459 <unlink>:
    1459:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    1460:	49 89 ca             	mov    %rcx,%r10
    1463:	0f 05                	syscall
    1465:	c3                   	ret

0000000000001466 <fstat>:
    1466:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    146d:	49 89 ca             	mov    %rcx,%r10
    1470:	0f 05                	syscall
    1472:	c3                   	ret

0000000000001473 <link>:
    1473:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    147a:	49 89 ca             	mov    %rcx,%r10
    147d:	0f 05                	syscall
    147f:	c3                   	ret

0000000000001480 <mkdir>:
    1480:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    1487:	49 89 ca             	mov    %rcx,%r10
    148a:	0f 05                	syscall
    148c:	c3                   	ret

000000000000148d <chdir>:
    148d:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    1494:	49 89 ca             	mov    %rcx,%r10
    1497:	0f 05                	syscall
    1499:	c3                   	ret

000000000000149a <dup>:
    149a:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    14a1:	49 89 ca             	mov    %rcx,%r10
    14a4:	0f 05                	syscall
    14a6:	c3                   	ret

00000000000014a7 <getpid>:
    14a7:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    14ae:	49 89 ca             	mov    %rcx,%r10
    14b1:	0f 05                	syscall
    14b3:	c3                   	ret

00000000000014b4 <sbrk>:
    14b4:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    14bb:	49 89 ca             	mov    %rcx,%r10
    14be:	0f 05                	syscall
    14c0:	c3                   	ret

00000000000014c1 <sleep>:
    14c1:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    14c8:	49 89 ca             	mov    %rcx,%r10
    14cb:	0f 05                	syscall
    14cd:	c3                   	ret

00000000000014ce <uptime>:
    14ce:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    14d5:	49 89 ca             	mov    %rcx,%r10
    14d8:	0f 05                	syscall
    14da:	c3                   	ret

00000000000014db <send>:
    14db:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    14e2:	49 89 ca             	mov    %rcx,%r10
    14e5:	0f 05                	syscall
    14e7:	c3                   	ret

00000000000014e8 <recv>:
    14e8:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    14ef:	49 89 ca             	mov    %rcx,%r10
    14f2:	0f 05                	syscall
    14f4:	c3                   	ret

00000000000014f5 <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    14f5:	f3 0f 1e fa          	endbr64
    14f9:	55                   	push   %rbp
    14fa:	48 89 e5             	mov    %rsp,%rbp
    14fd:	48 83 ec 10          	sub    $0x10,%rsp
    1501:	89 7d fc             	mov    %edi,-0x4(%rbp)
    1504:	89 f0                	mov    %esi,%eax
    1506:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    1509:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    150d:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1510:	ba 01 00 00 00       	mov    $0x1,%edx
    1515:	48 89 ce             	mov    %rcx,%rsi
    1518:	89 c7                	mov    %eax,%edi
    151a:	48 b8 0b 14 00 00 00 	movabs $0x140b,%rax
    1521:	00 00 00 
    1524:	ff d0                	call   *%rax
}
    1526:	90                   	nop
    1527:	c9                   	leave
    1528:	c3                   	ret

0000000000001529 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    1529:	f3 0f 1e fa          	endbr64
    152d:	55                   	push   %rbp
    152e:	48 89 e5             	mov    %rsp,%rbp
    1531:	48 83 ec 20          	sub    $0x20,%rsp
    1535:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1538:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    153c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1543:	eb 35                	jmp    157a <print_x64+0x51>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    1545:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1549:	48 c1 e8 3c          	shr    $0x3c,%rax
    154d:	48 ba b0 1e 00 00 00 	movabs $0x1eb0,%rdx
    1554:	00 00 00 
    1557:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    155b:	0f be d0             	movsbl %al,%edx
    155e:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1561:	89 d6                	mov    %edx,%esi
    1563:	89 c7                	mov    %eax,%edi
    1565:	48 b8 f5 14 00 00 00 	movabs $0x14f5,%rax
    156c:	00 00 00 
    156f:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1571:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1575:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    157a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    157d:	83 f8 0f             	cmp    $0xf,%eax
    1580:	76 c3                	jbe    1545 <print_x64+0x1c>
}
    1582:	90                   	nop
    1583:	90                   	nop
    1584:	c9                   	leave
    1585:	c3                   	ret

0000000000001586 <print_x32>:

  static void
print_x32(int fd, uint x)
{
    1586:	f3 0f 1e fa          	endbr64
    158a:	55                   	push   %rbp
    158b:	48 89 e5             	mov    %rsp,%rbp
    158e:	48 83 ec 20          	sub    $0x20,%rsp
    1592:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1595:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1598:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    159f:	eb 36                	jmp    15d7 <print_x32+0x51>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    15a1:	8b 45 e8             	mov    -0x18(%rbp),%eax
    15a4:	c1 e8 1c             	shr    $0x1c,%eax
    15a7:	89 c2                	mov    %eax,%edx
    15a9:	48 b8 b0 1e 00 00 00 	movabs $0x1eb0,%rax
    15b0:	00 00 00 
    15b3:	89 d2                	mov    %edx,%edx
    15b5:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    15b9:	0f be d0             	movsbl %al,%edx
    15bc:	8b 45 ec             	mov    -0x14(%rbp),%eax
    15bf:	89 d6                	mov    %edx,%esi
    15c1:	89 c7                	mov    %eax,%edi
    15c3:	48 b8 f5 14 00 00 00 	movabs $0x14f5,%rax
    15ca:	00 00 00 
    15cd:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    15cf:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    15d3:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    15d7:	8b 45 fc             	mov    -0x4(%rbp),%eax
    15da:	83 f8 07             	cmp    $0x7,%eax
    15dd:	76 c2                	jbe    15a1 <print_x32+0x1b>
}
    15df:	90                   	nop
    15e0:	90                   	nop
    15e1:	c9                   	leave
    15e2:	c3                   	ret

00000000000015e3 <print_d>:

  static void
print_d(int fd, int v)
{
    15e3:	f3 0f 1e fa          	endbr64
    15e7:	55                   	push   %rbp
    15e8:	48 89 e5             	mov    %rsp,%rbp
    15eb:	48 83 ec 30          	sub    $0x30,%rsp
    15ef:	89 7d dc             	mov    %edi,-0x24(%rbp)
    15f2:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    15f5:	8b 45 d8             	mov    -0x28(%rbp),%eax
    15f8:	48 98                	cltq
    15fa:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    15fe:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1602:	79 04                	jns    1608 <print_d+0x25>
    x = -x;
    1604:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    1608:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    160f:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1613:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    161a:	66 66 66 
    161d:	48 89 c8             	mov    %rcx,%rax
    1620:	48 f7 ea             	imul   %rdx
    1623:	48 c1 fa 02          	sar    $0x2,%rdx
    1627:	48 89 c8             	mov    %rcx,%rax
    162a:	48 c1 f8 3f          	sar    $0x3f,%rax
    162e:	48 29 c2             	sub    %rax,%rdx
    1631:	48 89 d0             	mov    %rdx,%rax
    1634:	48 c1 e0 02          	shl    $0x2,%rax
    1638:	48 01 d0             	add    %rdx,%rax
    163b:	48 01 c0             	add    %rax,%rax
    163e:	48 29 c1             	sub    %rax,%rcx
    1641:	48 89 ca             	mov    %rcx,%rdx
    1644:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1647:	8d 48 01             	lea    0x1(%rax),%ecx
    164a:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    164d:	48 b9 b0 1e 00 00 00 	movabs $0x1eb0,%rcx
    1654:	00 00 00 
    1657:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    165b:	48 98                	cltq
    165d:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    1661:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1665:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    166c:	66 66 66 
    166f:	48 89 c8             	mov    %rcx,%rax
    1672:	48 f7 ea             	imul   %rdx
    1675:	48 89 d0             	mov    %rdx,%rax
    1678:	48 c1 f8 02          	sar    $0x2,%rax
    167c:	48 c1 f9 3f          	sar    $0x3f,%rcx
    1680:	48 89 ca             	mov    %rcx,%rdx
    1683:	48 29 d0             	sub    %rdx,%rax
    1686:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    168a:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    168f:	0f 85 7a ff ff ff    	jne    160f <print_d+0x2c>

  if (v < 0)
    1695:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1699:	79 32                	jns    16cd <print_d+0xea>
    buf[i++] = '-';
    169b:	8b 45 f4             	mov    -0xc(%rbp),%eax
    169e:	8d 50 01             	lea    0x1(%rax),%edx
    16a1:	89 55 f4             	mov    %edx,-0xc(%rbp)
    16a4:	48 98                	cltq
    16a6:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    16ab:	eb 20                	jmp    16cd <print_d+0xea>
    putc(fd, buf[i]);
    16ad:	8b 45 f4             	mov    -0xc(%rbp),%eax
    16b0:	48 98                	cltq
    16b2:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    16b7:	0f be d0             	movsbl %al,%edx
    16ba:	8b 45 dc             	mov    -0x24(%rbp),%eax
    16bd:	89 d6                	mov    %edx,%esi
    16bf:	89 c7                	mov    %eax,%edi
    16c1:	48 b8 f5 14 00 00 00 	movabs $0x14f5,%rax
    16c8:	00 00 00 
    16cb:	ff d0                	call   *%rax
  while (--i >= 0)
    16cd:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    16d1:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    16d5:	79 d6                	jns    16ad <print_d+0xca>
}
    16d7:	90                   	nop
    16d8:	90                   	nop
    16d9:	c9                   	leave
    16da:	c3                   	ret

00000000000016db <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    16db:	f3 0f 1e fa          	endbr64
    16df:	55                   	push   %rbp
    16e0:	48 89 e5             	mov    %rsp,%rbp
    16e3:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    16ea:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    16f0:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    16f7:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    16fe:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    1705:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    170c:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    1713:	84 c0                	test   %al,%al
    1715:	74 20                	je     1737 <printf+0x5c>
    1717:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    171b:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    171f:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    1723:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    1727:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    172b:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    172f:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    1733:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    1737:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    173e:	00 00 00 
    1741:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    1748:	00 00 00 
    174b:	48 8d 45 10          	lea    0x10(%rbp),%rax
    174f:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    1756:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    175d:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1764:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    176b:	00 00 00 
    176e:	e9 41 03 00 00       	jmp    1ab4 <printf+0x3d9>
    if (c != '%') {
    1773:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    177a:	74 24                	je     17a0 <printf+0xc5>
      putc(fd, c);
    177c:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1782:	0f be d0             	movsbl %al,%edx
    1785:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    178b:	89 d6                	mov    %edx,%esi
    178d:	89 c7                	mov    %eax,%edi
    178f:	48 b8 f5 14 00 00 00 	movabs $0x14f5,%rax
    1796:	00 00 00 
    1799:	ff d0                	call   *%rax
      continue;
    179b:	e9 0d 03 00 00       	jmp    1aad <printf+0x3d2>
    }
    c = fmt[++i] & 0xff;
    17a0:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    17a7:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    17ad:	48 63 d0             	movslq %eax,%rdx
    17b0:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    17b7:	48 01 d0             	add    %rdx,%rax
    17ba:	0f b6 00             	movzbl (%rax),%eax
    17bd:	0f be c0             	movsbl %al,%eax
    17c0:	25 ff 00 00 00       	and    $0xff,%eax
    17c5:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    17cb:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    17d2:	0f 84 0f 03 00 00    	je     1ae7 <printf+0x40c>
      break;
    switch(c) {
    17d8:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    17df:	0f 84 74 02 00 00    	je     1a59 <printf+0x37e>
    17e5:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    17ec:	0f 8c 82 02 00 00    	jl     1a74 <printf+0x399>
    17f2:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    17f9:	0f 8f 75 02 00 00    	jg     1a74 <printf+0x399>
    17ff:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    1806:	0f 8c 68 02 00 00    	jl     1a74 <printf+0x399>
    180c:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1812:	83 e8 63             	sub    $0x63,%eax
    1815:	83 f8 15             	cmp    $0x15,%eax
    1818:	0f 87 56 02 00 00    	ja     1a74 <printf+0x399>
    181e:	89 c0                	mov    %eax,%eax
    1820:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1827:	00 
    1828:	48 b8 00 1e 00 00 00 	movabs $0x1e00,%rax
    182f:	00 00 00 
    1832:	48 01 d0             	add    %rdx,%rax
    1835:	48 8b 00             	mov    (%rax),%rax
    1838:	3e ff e0             	notrack jmp *%rax
    case 'c':
      putc(fd, va_arg(ap, int));
    183b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1841:	83 f8 2f             	cmp    $0x2f,%eax
    1844:	77 23                	ja     1869 <printf+0x18e>
    1846:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    184d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1853:	89 d2                	mov    %edx,%edx
    1855:	48 01 d0             	add    %rdx,%rax
    1858:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    185e:	83 c2 08             	add    $0x8,%edx
    1861:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1867:	eb 12                	jmp    187b <printf+0x1a0>
    1869:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1870:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1874:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    187b:	8b 00                	mov    (%rax),%eax
    187d:	0f be d0             	movsbl %al,%edx
    1880:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1886:	89 d6                	mov    %edx,%esi
    1888:	89 c7                	mov    %eax,%edi
    188a:	48 b8 f5 14 00 00 00 	movabs $0x14f5,%rax
    1891:	00 00 00 
    1894:	ff d0                	call   *%rax
      break;
    1896:	e9 12 02 00 00       	jmp    1aad <printf+0x3d2>
    case 'd':
      print_d(fd, va_arg(ap, int));
    189b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    18a1:	83 f8 2f             	cmp    $0x2f,%eax
    18a4:	77 23                	ja     18c9 <printf+0x1ee>
    18a6:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    18ad:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18b3:	89 d2                	mov    %edx,%edx
    18b5:	48 01 d0             	add    %rdx,%rax
    18b8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18be:	83 c2 08             	add    $0x8,%edx
    18c1:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    18c7:	eb 12                	jmp    18db <printf+0x200>
    18c9:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    18d0:	48 8d 50 08          	lea    0x8(%rax),%rdx
    18d4:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    18db:	8b 10                	mov    (%rax),%edx
    18dd:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    18e3:	89 d6                	mov    %edx,%esi
    18e5:	89 c7                	mov    %eax,%edi
    18e7:	48 b8 e3 15 00 00 00 	movabs $0x15e3,%rax
    18ee:	00 00 00 
    18f1:	ff d0                	call   *%rax
      break;
    18f3:	e9 b5 01 00 00       	jmp    1aad <printf+0x3d2>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    18f8:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    18fe:	83 f8 2f             	cmp    $0x2f,%eax
    1901:	77 23                	ja     1926 <printf+0x24b>
    1903:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    190a:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1910:	89 d2                	mov    %edx,%edx
    1912:	48 01 d0             	add    %rdx,%rax
    1915:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    191b:	83 c2 08             	add    $0x8,%edx
    191e:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1924:	eb 12                	jmp    1938 <printf+0x25d>
    1926:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    192d:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1931:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1938:	8b 10                	mov    (%rax),%edx
    193a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1940:	89 d6                	mov    %edx,%esi
    1942:	89 c7                	mov    %eax,%edi
    1944:	48 b8 86 15 00 00 00 	movabs $0x1586,%rax
    194b:	00 00 00 
    194e:	ff d0                	call   *%rax
      break;
    1950:	e9 58 01 00 00       	jmp    1aad <printf+0x3d2>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    1955:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    195b:	83 f8 2f             	cmp    $0x2f,%eax
    195e:	77 23                	ja     1983 <printf+0x2a8>
    1960:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1967:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    196d:	89 d2                	mov    %edx,%edx
    196f:	48 01 d0             	add    %rdx,%rax
    1972:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1978:	83 c2 08             	add    $0x8,%edx
    197b:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1981:	eb 12                	jmp    1995 <printf+0x2ba>
    1983:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    198a:	48 8d 50 08          	lea    0x8(%rax),%rdx
    198e:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1995:	48 8b 10             	mov    (%rax),%rdx
    1998:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    199e:	48 89 d6             	mov    %rdx,%rsi
    19a1:	89 c7                	mov    %eax,%edi
    19a3:	48 b8 29 15 00 00 00 	movabs $0x1529,%rax
    19aa:	00 00 00 
    19ad:	ff d0                	call   *%rax
      break;
    19af:	e9 f9 00 00 00       	jmp    1aad <printf+0x3d2>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    19b4:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    19ba:	83 f8 2f             	cmp    $0x2f,%eax
    19bd:	77 23                	ja     19e2 <printf+0x307>
    19bf:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    19c6:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19cc:	89 d2                	mov    %edx,%edx
    19ce:	48 01 d0             	add    %rdx,%rax
    19d1:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19d7:	83 c2 08             	add    $0x8,%edx
    19da:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    19e0:	eb 12                	jmp    19f4 <printf+0x319>
    19e2:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    19e9:	48 8d 50 08          	lea    0x8(%rax),%rdx
    19ed:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    19f4:	48 8b 00             	mov    (%rax),%rax
    19f7:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    19fe:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1a05:	00 
    1a06:	75 41                	jne    1a49 <printf+0x36e>
        s = "(null)";
    1a08:	48 b8 f8 1d 00 00 00 	movabs $0x1df8,%rax
    1a0f:	00 00 00 
    1a12:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1a19:	eb 2e                	jmp    1a49 <printf+0x36e>
        putc(fd, *(s++));
    1a1b:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1a22:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1a26:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1a2d:	0f b6 00             	movzbl (%rax),%eax
    1a30:	0f be d0             	movsbl %al,%edx
    1a33:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a39:	89 d6                	mov    %edx,%esi
    1a3b:	89 c7                	mov    %eax,%edi
    1a3d:	48 b8 f5 14 00 00 00 	movabs $0x14f5,%rax
    1a44:	00 00 00 
    1a47:	ff d0                	call   *%rax
      while (*s)
    1a49:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1a50:	0f b6 00             	movzbl (%rax),%eax
    1a53:	84 c0                	test   %al,%al
    1a55:	75 c4                	jne    1a1b <printf+0x340>
      break;
    1a57:	eb 54                	jmp    1aad <printf+0x3d2>
    case '%':
      putc(fd, '%');
    1a59:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a5f:	be 25 00 00 00       	mov    $0x25,%esi
    1a64:	89 c7                	mov    %eax,%edi
    1a66:	48 b8 f5 14 00 00 00 	movabs $0x14f5,%rax
    1a6d:	00 00 00 
    1a70:	ff d0                	call   *%rax
      break;
    1a72:	eb 39                	jmp    1aad <printf+0x3d2>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1a74:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a7a:	be 25 00 00 00       	mov    $0x25,%esi
    1a7f:	89 c7                	mov    %eax,%edi
    1a81:	48 b8 f5 14 00 00 00 	movabs $0x14f5,%rax
    1a88:	00 00 00 
    1a8b:	ff d0                	call   *%rax
      putc(fd, c);
    1a8d:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1a93:	0f be d0             	movsbl %al,%edx
    1a96:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a9c:	89 d6                	mov    %edx,%esi
    1a9e:	89 c7                	mov    %eax,%edi
    1aa0:	48 b8 f5 14 00 00 00 	movabs $0x14f5,%rax
    1aa7:	00 00 00 
    1aaa:	ff d0                	call   *%rax
      break;
    1aac:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1aad:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1ab4:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1aba:	48 63 d0             	movslq %eax,%rdx
    1abd:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1ac4:	48 01 d0             	add    %rdx,%rax
    1ac7:	0f b6 00             	movzbl (%rax),%eax
    1aca:	0f be c0             	movsbl %al,%eax
    1acd:	25 ff 00 00 00       	and    $0xff,%eax
    1ad2:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1ad8:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1adf:	0f 85 8e fc ff ff    	jne    1773 <printf+0x98>
    }
  }
}
    1ae5:	eb 01                	jmp    1ae8 <printf+0x40d>
      break;
    1ae7:	90                   	nop
}
    1ae8:	90                   	nop
    1ae9:	c9                   	leave
    1aea:	c3                   	ret

0000000000001aeb <free>:
    1aeb:	55                   	push   %rbp
    1aec:	48 89 e5             	mov    %rsp,%rbp
    1aef:	48 83 ec 18          	sub    $0x18,%rsp
    1af3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1af7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1afb:	48 83 e8 10          	sub    $0x10,%rax
    1aff:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1b03:	48 b8 e0 1e 00 00 00 	movabs $0x1ee0,%rax
    1b0a:	00 00 00 
    1b0d:	48 8b 00             	mov    (%rax),%rax
    1b10:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1b14:	eb 2f                	jmp    1b45 <free+0x5a>
    1b16:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b1a:	48 8b 00             	mov    (%rax),%rax
    1b1d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b21:	72 17                	jb     1b3a <free+0x4f>
    1b23:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b27:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b2b:	72 2f                	jb     1b5c <free+0x71>
    1b2d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b31:	48 8b 00             	mov    (%rax),%rax
    1b34:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1b38:	72 22                	jb     1b5c <free+0x71>
    1b3a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b3e:	48 8b 00             	mov    (%rax),%rax
    1b41:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1b45:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b49:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b4d:	73 c7                	jae    1b16 <free+0x2b>
    1b4f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b53:	48 8b 00             	mov    (%rax),%rax
    1b56:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1b5a:	73 ba                	jae    1b16 <free+0x2b>
    1b5c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b60:	8b 40 08             	mov    0x8(%rax),%eax
    1b63:	89 c0                	mov    %eax,%eax
    1b65:	48 c1 e0 04          	shl    $0x4,%rax
    1b69:	48 89 c2             	mov    %rax,%rdx
    1b6c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b70:	48 01 c2             	add    %rax,%rdx
    1b73:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b77:	48 8b 00             	mov    (%rax),%rax
    1b7a:	48 39 c2             	cmp    %rax,%rdx
    1b7d:	75 2d                	jne    1bac <free+0xc1>
    1b7f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b83:	8b 50 08             	mov    0x8(%rax),%edx
    1b86:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b8a:	48 8b 00             	mov    (%rax),%rax
    1b8d:	8b 40 08             	mov    0x8(%rax),%eax
    1b90:	01 c2                	add    %eax,%edx
    1b92:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b96:	89 50 08             	mov    %edx,0x8(%rax)
    1b99:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b9d:	48 8b 00             	mov    (%rax),%rax
    1ba0:	48 8b 10             	mov    (%rax),%rdx
    1ba3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ba7:	48 89 10             	mov    %rdx,(%rax)
    1baa:	eb 0e                	jmp    1bba <free+0xcf>
    1bac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bb0:	48 8b 10             	mov    (%rax),%rdx
    1bb3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bb7:	48 89 10             	mov    %rdx,(%rax)
    1bba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bbe:	8b 40 08             	mov    0x8(%rax),%eax
    1bc1:	89 c0                	mov    %eax,%eax
    1bc3:	48 c1 e0 04          	shl    $0x4,%rax
    1bc7:	48 89 c2             	mov    %rax,%rdx
    1bca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bce:	48 01 d0             	add    %rdx,%rax
    1bd1:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1bd5:	75 27                	jne    1bfe <free+0x113>
    1bd7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bdb:	8b 50 08             	mov    0x8(%rax),%edx
    1bde:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1be2:	8b 40 08             	mov    0x8(%rax),%eax
    1be5:	01 c2                	add    %eax,%edx
    1be7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1beb:	89 50 08             	mov    %edx,0x8(%rax)
    1bee:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bf2:	48 8b 10             	mov    (%rax),%rdx
    1bf5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bf9:	48 89 10             	mov    %rdx,(%rax)
    1bfc:	eb 0b                	jmp    1c09 <free+0x11e>
    1bfe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c02:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1c06:	48 89 10             	mov    %rdx,(%rax)
    1c09:	48 ba e0 1e 00 00 00 	movabs $0x1ee0,%rdx
    1c10:	00 00 00 
    1c13:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c17:	48 89 02             	mov    %rax,(%rdx)
    1c1a:	90                   	nop
    1c1b:	c9                   	leave
    1c1c:	c3                   	ret

0000000000001c1d <morecore>:
    1c1d:	55                   	push   %rbp
    1c1e:	48 89 e5             	mov    %rsp,%rbp
    1c21:	48 83 ec 20          	sub    $0x20,%rsp
    1c25:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1c28:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1c2f:	77 07                	ja     1c38 <morecore+0x1b>
    1c31:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
    1c38:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1c3b:	48 c1 e0 04          	shl    $0x4,%rax
    1c3f:	48 89 c7             	mov    %rax,%rdi
    1c42:	48 b8 b4 14 00 00 00 	movabs $0x14b4,%rax
    1c49:	00 00 00 
    1c4c:	ff d0                	call   *%rax
    1c4e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1c52:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1c57:	75 07                	jne    1c60 <morecore+0x43>
    1c59:	b8 00 00 00 00       	mov    $0x0,%eax
    1c5e:	eb 36                	jmp    1c96 <morecore+0x79>
    1c60:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c64:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1c68:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c6c:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1c6f:	89 50 08             	mov    %edx,0x8(%rax)
    1c72:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c76:	48 83 c0 10          	add    $0x10,%rax
    1c7a:	48 89 c7             	mov    %rax,%rdi
    1c7d:	48 b8 eb 1a 00 00 00 	movabs $0x1aeb,%rax
    1c84:	00 00 00 
    1c87:	ff d0                	call   *%rax
    1c89:	48 b8 e0 1e 00 00 00 	movabs $0x1ee0,%rax
    1c90:	00 00 00 
    1c93:	48 8b 00             	mov    (%rax),%rax
    1c96:	c9                   	leave
    1c97:	c3                   	ret

0000000000001c98 <malloc>:
    1c98:	55                   	push   %rbp
    1c99:	48 89 e5             	mov    %rsp,%rbp
    1c9c:	48 83 ec 30          	sub    $0x30,%rsp
    1ca0:	89 7d dc             	mov    %edi,-0x24(%rbp)
    1ca3:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1ca6:	48 83 c0 0f          	add    $0xf,%rax
    1caa:	48 c1 e8 04          	shr    $0x4,%rax
    1cae:	83 c0 01             	add    $0x1,%eax
    1cb1:	89 45 ec             	mov    %eax,-0x14(%rbp)
    1cb4:	48 b8 e0 1e 00 00 00 	movabs $0x1ee0,%rax
    1cbb:	00 00 00 
    1cbe:	48 8b 00             	mov    (%rax),%rax
    1cc1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1cc5:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1cca:	75 4a                	jne    1d16 <malloc+0x7e>
    1ccc:	48 b8 d0 1e 00 00 00 	movabs $0x1ed0,%rax
    1cd3:	00 00 00 
    1cd6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1cda:	48 ba e0 1e 00 00 00 	movabs $0x1ee0,%rdx
    1ce1:	00 00 00 
    1ce4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ce8:	48 89 02             	mov    %rax,(%rdx)
    1ceb:	48 b8 e0 1e 00 00 00 	movabs $0x1ee0,%rax
    1cf2:	00 00 00 
    1cf5:	48 8b 00             	mov    (%rax),%rax
    1cf8:	48 ba d0 1e 00 00 00 	movabs $0x1ed0,%rdx
    1cff:	00 00 00 
    1d02:	48 89 02             	mov    %rax,(%rdx)
    1d05:	48 b8 d0 1e 00 00 00 	movabs $0x1ed0,%rax
    1d0c:	00 00 00 
    1d0f:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
    1d16:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d1a:	48 8b 00             	mov    (%rax),%rax
    1d1d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1d21:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d25:	8b 40 08             	mov    0x8(%rax),%eax
    1d28:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1d2b:	72 65                	jb     1d92 <malloc+0xfa>
    1d2d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d31:	8b 40 08             	mov    0x8(%rax),%eax
    1d34:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1d37:	75 10                	jne    1d49 <malloc+0xb1>
    1d39:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d3d:	48 8b 10             	mov    (%rax),%rdx
    1d40:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d44:	48 89 10             	mov    %rdx,(%rax)
    1d47:	eb 2e                	jmp    1d77 <malloc+0xdf>
    1d49:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d4d:	8b 40 08             	mov    0x8(%rax),%eax
    1d50:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1d53:	89 c2                	mov    %eax,%edx
    1d55:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d59:	89 50 08             	mov    %edx,0x8(%rax)
    1d5c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d60:	8b 40 08             	mov    0x8(%rax),%eax
    1d63:	89 c0                	mov    %eax,%eax
    1d65:	48 c1 e0 04          	shl    $0x4,%rax
    1d69:	48 01 45 f8          	add    %rax,-0x8(%rbp)
    1d6d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d71:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1d74:	89 50 08             	mov    %edx,0x8(%rax)
    1d77:	48 ba e0 1e 00 00 00 	movabs $0x1ee0,%rdx
    1d7e:	00 00 00 
    1d81:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d85:	48 89 02             	mov    %rax,(%rdx)
    1d88:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d8c:	48 83 c0 10          	add    $0x10,%rax
    1d90:	eb 4e                	jmp    1de0 <malloc+0x148>
    1d92:	48 b8 e0 1e 00 00 00 	movabs $0x1ee0,%rax
    1d99:	00 00 00 
    1d9c:	48 8b 00             	mov    (%rax),%rax
    1d9f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1da3:	75 23                	jne    1dc8 <malloc+0x130>
    1da5:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1da8:	89 c7                	mov    %eax,%edi
    1daa:	48 b8 1d 1c 00 00 00 	movabs $0x1c1d,%rax
    1db1:	00 00 00 
    1db4:	ff d0                	call   *%rax
    1db6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1dba:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1dbf:	75 07                	jne    1dc8 <malloc+0x130>
    1dc1:	b8 00 00 00 00       	mov    $0x0,%eax
    1dc6:	eb 18                	jmp    1de0 <malloc+0x148>
    1dc8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1dcc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1dd0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1dd4:	48 8b 00             	mov    (%rax),%rax
    1dd7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1ddb:	e9 41 ff ff ff       	jmp    1d21 <malloc+0x89>
    1de0:	c9                   	leave
    1de1:	c3                   	ret
