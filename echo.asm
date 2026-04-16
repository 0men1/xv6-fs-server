
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
    1027:	48 b8 00 1e 00 00 00 	movabs $0x1e00,%rax
    102e:	00 00 00 
    1031:	eb 0a                	jmp    103d <main+0x3d>
    1033:	48 b8 02 1e 00 00 00 	movabs $0x1e02,%rax
    103a:	00 00 00 
    103d:	8b 55 fc             	mov    -0x4(%rbp),%edx
    1040:	48 63 d2             	movslq %edx,%rdx
    1043:	48 8d 0c d5 00 00 00 	lea    0x0(,%rdx,8),%rcx
    104a:	00 
    104b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    104f:	48 01 ca             	add    %rcx,%rdx
    1052:	48 8b 12             	mov    (%rdx),%rdx
    1055:	48 89 c1             	mov    %rax,%rcx
    1058:	48 b8 04 1e 00 00 00 	movabs $0x1e04,%rax
    105f:	00 00 00 
    1062:	48 89 c6             	mov    %rax,%rsi
    1065:	bf 01 00 00 00       	mov    $0x1,%edi
    106a:	b8 00 00 00 00       	mov    $0x0,%eax
    106f:	49 b8 e8 16 00 00 00 	movabs $0x16e8,%r8
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
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    13ca:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    13d1:	49 89 ca             	mov    %rcx,%r10
    13d4:	0f 05                	syscall
    13d6:	c3                   	ret

00000000000013d7 <exit>:
SYSCALL(exit)
    13d7:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    13de:	49 89 ca             	mov    %rcx,%r10
    13e1:	0f 05                	syscall
    13e3:	c3                   	ret

00000000000013e4 <wait>:
SYSCALL(wait)
    13e4:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    13eb:	49 89 ca             	mov    %rcx,%r10
    13ee:	0f 05                	syscall
    13f0:	c3                   	ret

00000000000013f1 <pipe>:
SYSCALL(pipe)
    13f1:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    13f8:	49 89 ca             	mov    %rcx,%r10
    13fb:	0f 05                	syscall
    13fd:	c3                   	ret

00000000000013fe <read>:
SYSCALL(read)
    13fe:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    1405:	49 89 ca             	mov    %rcx,%r10
    1408:	0f 05                	syscall
    140a:	c3                   	ret

000000000000140b <write>:
SYSCALL(write)
    140b:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    1412:	49 89 ca             	mov    %rcx,%r10
    1415:	0f 05                	syscall
    1417:	c3                   	ret

0000000000001418 <close>:
SYSCALL(close)
    1418:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    141f:	49 89 ca             	mov    %rcx,%r10
    1422:	0f 05                	syscall
    1424:	c3                   	ret

0000000000001425 <kill>:
SYSCALL(kill)
    1425:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    142c:	49 89 ca             	mov    %rcx,%r10
    142f:	0f 05                	syscall
    1431:	c3                   	ret

0000000000001432 <exec>:
SYSCALL(exec)
    1432:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    1439:	49 89 ca             	mov    %rcx,%r10
    143c:	0f 05                	syscall
    143e:	c3                   	ret

000000000000143f <open>:
SYSCALL(open)
    143f:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    1446:	49 89 ca             	mov    %rcx,%r10
    1449:	0f 05                	syscall
    144b:	c3                   	ret

000000000000144c <mknod>:
SYSCALL(mknod)
    144c:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    1453:	49 89 ca             	mov    %rcx,%r10
    1456:	0f 05                	syscall
    1458:	c3                   	ret

0000000000001459 <unlink>:
SYSCALL(unlink)
    1459:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    1460:	49 89 ca             	mov    %rcx,%r10
    1463:	0f 05                	syscall
    1465:	c3                   	ret

0000000000001466 <fstat>:
SYSCALL(fstat)
    1466:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    146d:	49 89 ca             	mov    %rcx,%r10
    1470:	0f 05                	syscall
    1472:	c3                   	ret

0000000000001473 <link>:
SYSCALL(link)
    1473:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    147a:	49 89 ca             	mov    %rcx,%r10
    147d:	0f 05                	syscall
    147f:	c3                   	ret

0000000000001480 <mkdir>:
SYSCALL(mkdir)
    1480:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    1487:	49 89 ca             	mov    %rcx,%r10
    148a:	0f 05                	syscall
    148c:	c3                   	ret

000000000000148d <chdir>:
SYSCALL(chdir)
    148d:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    1494:	49 89 ca             	mov    %rcx,%r10
    1497:	0f 05                	syscall
    1499:	c3                   	ret

000000000000149a <dup>:
SYSCALL(dup)
    149a:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    14a1:	49 89 ca             	mov    %rcx,%r10
    14a4:	0f 05                	syscall
    14a6:	c3                   	ret

00000000000014a7 <getpid>:
SYSCALL(getpid)
    14a7:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    14ae:	49 89 ca             	mov    %rcx,%r10
    14b1:	0f 05                	syscall
    14b3:	c3                   	ret

00000000000014b4 <sbrk>:
SYSCALL(sbrk)
    14b4:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    14bb:	49 89 ca             	mov    %rcx,%r10
    14be:	0f 05                	syscall
    14c0:	c3                   	ret

00000000000014c1 <sleep>:
SYSCALL(sleep)
    14c1:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    14c8:	49 89 ca             	mov    %rcx,%r10
    14cb:	0f 05                	syscall
    14cd:	c3                   	ret

00000000000014ce <uptime>:
SYSCALL(uptime)
    14ce:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    14d5:	49 89 ca             	mov    %rcx,%r10
    14d8:	0f 05                	syscall
    14da:	c3                   	ret

00000000000014db <send>:
SYSCALL(send)
    14db:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    14e2:	49 89 ca             	mov    %rcx,%r10
    14e5:	0f 05                	syscall
    14e7:	c3                   	ret

00000000000014e8 <recv>:
SYSCALL(recv)
    14e8:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    14ef:	49 89 ca             	mov    %rcx,%r10
    14f2:	0f 05                	syscall
    14f4:	c3                   	ret

00000000000014f5 <register_fsserver>:
SYSCALL(register_fsserver)
    14f5:	48 c7 c0 18 00 00 00 	mov    $0x18,%rax
    14fc:	49 89 ca             	mov    %rcx,%r10
    14ff:	0f 05                	syscall
    1501:	c3                   	ret

0000000000001502 <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    1502:	f3 0f 1e fa          	endbr64
    1506:	55                   	push   %rbp
    1507:	48 89 e5             	mov    %rsp,%rbp
    150a:	48 83 ec 10          	sub    $0x10,%rsp
    150e:	89 7d fc             	mov    %edi,-0x4(%rbp)
    1511:	89 f0                	mov    %esi,%eax
    1513:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    1516:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    151a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    151d:	ba 01 00 00 00       	mov    $0x1,%edx
    1522:	48 89 ce             	mov    %rcx,%rsi
    1525:	89 c7                	mov    %eax,%edi
    1527:	48 b8 0b 14 00 00 00 	movabs $0x140b,%rax
    152e:	00 00 00 
    1531:	ff d0                	call   *%rax
}
    1533:	90                   	nop
    1534:	c9                   	leave
    1535:	c3                   	ret

0000000000001536 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    1536:	f3 0f 1e fa          	endbr64
    153a:	55                   	push   %rbp
    153b:	48 89 e5             	mov    %rsp,%rbp
    153e:	48 83 ec 20          	sub    $0x20,%rsp
    1542:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1545:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1549:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1550:	eb 35                	jmp    1587 <print_x64+0x51>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    1552:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1556:	48 c1 e8 3c          	shr    $0x3c,%rax
    155a:	48 ba d0 1e 00 00 00 	movabs $0x1ed0,%rdx
    1561:	00 00 00 
    1564:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1568:	0f be d0             	movsbl %al,%edx
    156b:	8b 45 ec             	mov    -0x14(%rbp),%eax
    156e:	89 d6                	mov    %edx,%esi
    1570:	89 c7                	mov    %eax,%edi
    1572:	48 b8 02 15 00 00 00 	movabs $0x1502,%rax
    1579:	00 00 00 
    157c:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    157e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1582:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    1587:	8b 45 fc             	mov    -0x4(%rbp),%eax
    158a:	83 f8 0f             	cmp    $0xf,%eax
    158d:	76 c3                	jbe    1552 <print_x64+0x1c>
}
    158f:	90                   	nop
    1590:	90                   	nop
    1591:	c9                   	leave
    1592:	c3                   	ret

0000000000001593 <print_x32>:

  static void
print_x32(int fd, uint x)
{
    1593:	f3 0f 1e fa          	endbr64
    1597:	55                   	push   %rbp
    1598:	48 89 e5             	mov    %rsp,%rbp
    159b:	48 83 ec 20          	sub    $0x20,%rsp
    159f:	89 7d ec             	mov    %edi,-0x14(%rbp)
    15a2:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    15a5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    15ac:	eb 36                	jmp    15e4 <print_x32+0x51>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    15ae:	8b 45 e8             	mov    -0x18(%rbp),%eax
    15b1:	c1 e8 1c             	shr    $0x1c,%eax
    15b4:	89 c2                	mov    %eax,%edx
    15b6:	48 b8 d0 1e 00 00 00 	movabs $0x1ed0,%rax
    15bd:	00 00 00 
    15c0:	89 d2                	mov    %edx,%edx
    15c2:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    15c6:	0f be d0             	movsbl %al,%edx
    15c9:	8b 45 ec             	mov    -0x14(%rbp),%eax
    15cc:	89 d6                	mov    %edx,%esi
    15ce:	89 c7                	mov    %eax,%edi
    15d0:	48 b8 02 15 00 00 00 	movabs $0x1502,%rax
    15d7:	00 00 00 
    15da:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    15dc:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    15e0:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    15e4:	8b 45 fc             	mov    -0x4(%rbp),%eax
    15e7:	83 f8 07             	cmp    $0x7,%eax
    15ea:	76 c2                	jbe    15ae <print_x32+0x1b>
}
    15ec:	90                   	nop
    15ed:	90                   	nop
    15ee:	c9                   	leave
    15ef:	c3                   	ret

00000000000015f0 <print_d>:

  static void
print_d(int fd, int v)
{
    15f0:	f3 0f 1e fa          	endbr64
    15f4:	55                   	push   %rbp
    15f5:	48 89 e5             	mov    %rsp,%rbp
    15f8:	48 83 ec 30          	sub    $0x30,%rsp
    15fc:	89 7d dc             	mov    %edi,-0x24(%rbp)
    15ff:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    1602:	8b 45 d8             	mov    -0x28(%rbp),%eax
    1605:	48 98                	cltq
    1607:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    160b:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    160f:	79 04                	jns    1615 <print_d+0x25>
    x = -x;
    1611:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    1615:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    161c:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1620:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1627:	66 66 66 
    162a:	48 89 c8             	mov    %rcx,%rax
    162d:	48 f7 ea             	imul   %rdx
    1630:	48 c1 fa 02          	sar    $0x2,%rdx
    1634:	48 89 c8             	mov    %rcx,%rax
    1637:	48 c1 f8 3f          	sar    $0x3f,%rax
    163b:	48 29 c2             	sub    %rax,%rdx
    163e:	48 89 d0             	mov    %rdx,%rax
    1641:	48 c1 e0 02          	shl    $0x2,%rax
    1645:	48 01 d0             	add    %rdx,%rax
    1648:	48 01 c0             	add    %rax,%rax
    164b:	48 29 c1             	sub    %rax,%rcx
    164e:	48 89 ca             	mov    %rcx,%rdx
    1651:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1654:	8d 48 01             	lea    0x1(%rax),%ecx
    1657:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    165a:	48 b9 d0 1e 00 00 00 	movabs $0x1ed0,%rcx
    1661:	00 00 00 
    1664:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    1668:	48 98                	cltq
    166a:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    166e:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1672:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1679:	66 66 66 
    167c:	48 89 c8             	mov    %rcx,%rax
    167f:	48 f7 ea             	imul   %rdx
    1682:	48 89 d0             	mov    %rdx,%rax
    1685:	48 c1 f8 02          	sar    $0x2,%rax
    1689:	48 c1 f9 3f          	sar    $0x3f,%rcx
    168d:	48 89 ca             	mov    %rcx,%rdx
    1690:	48 29 d0             	sub    %rdx,%rax
    1693:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    1697:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    169c:	0f 85 7a ff ff ff    	jne    161c <print_d+0x2c>

  if (v < 0)
    16a2:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    16a6:	79 32                	jns    16da <print_d+0xea>
    buf[i++] = '-';
    16a8:	8b 45 f4             	mov    -0xc(%rbp),%eax
    16ab:	8d 50 01             	lea    0x1(%rax),%edx
    16ae:	89 55 f4             	mov    %edx,-0xc(%rbp)
    16b1:	48 98                	cltq
    16b3:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    16b8:	eb 20                	jmp    16da <print_d+0xea>
    putc(fd, buf[i]);
    16ba:	8b 45 f4             	mov    -0xc(%rbp),%eax
    16bd:	48 98                	cltq
    16bf:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    16c4:	0f be d0             	movsbl %al,%edx
    16c7:	8b 45 dc             	mov    -0x24(%rbp),%eax
    16ca:	89 d6                	mov    %edx,%esi
    16cc:	89 c7                	mov    %eax,%edi
    16ce:	48 b8 02 15 00 00 00 	movabs $0x1502,%rax
    16d5:	00 00 00 
    16d8:	ff d0                	call   *%rax
  while (--i >= 0)
    16da:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    16de:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    16e2:	79 d6                	jns    16ba <print_d+0xca>
}
    16e4:	90                   	nop
    16e5:	90                   	nop
    16e6:	c9                   	leave
    16e7:	c3                   	ret

00000000000016e8 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    16e8:	f3 0f 1e fa          	endbr64
    16ec:	55                   	push   %rbp
    16ed:	48 89 e5             	mov    %rsp,%rbp
    16f0:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    16f7:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    16fd:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    1704:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    170b:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    1712:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    1719:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    1720:	84 c0                	test   %al,%al
    1722:	74 20                	je     1744 <printf+0x5c>
    1724:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    1728:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    172c:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    1730:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    1734:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    1738:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    173c:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    1740:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    1744:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    174b:	00 00 00 
    174e:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    1755:	00 00 00 
    1758:	48 8d 45 10          	lea    0x10(%rbp),%rax
    175c:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    1763:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    176a:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1771:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    1778:	00 00 00 
    177b:	e9 41 03 00 00       	jmp    1ac1 <printf+0x3d9>
    if (c != '%') {
    1780:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1787:	74 24                	je     17ad <printf+0xc5>
      putc(fd, c);
    1789:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    178f:	0f be d0             	movsbl %al,%edx
    1792:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1798:	89 d6                	mov    %edx,%esi
    179a:	89 c7                	mov    %eax,%edi
    179c:	48 b8 02 15 00 00 00 	movabs $0x1502,%rax
    17a3:	00 00 00 
    17a6:	ff d0                	call   *%rax
      continue;
    17a8:	e9 0d 03 00 00       	jmp    1aba <printf+0x3d2>
    }
    c = fmt[++i] & 0xff;
    17ad:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    17b4:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    17ba:	48 63 d0             	movslq %eax,%rdx
    17bd:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    17c4:	48 01 d0             	add    %rdx,%rax
    17c7:	0f b6 00             	movzbl (%rax),%eax
    17ca:	0f be c0             	movsbl %al,%eax
    17cd:	25 ff 00 00 00       	and    $0xff,%eax
    17d2:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    17d8:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    17df:	0f 84 0f 03 00 00    	je     1af4 <printf+0x40c>
      break;
    switch(c) {
    17e5:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    17ec:	0f 84 74 02 00 00    	je     1a66 <printf+0x37e>
    17f2:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    17f9:	0f 8c 82 02 00 00    	jl     1a81 <printf+0x399>
    17ff:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    1806:	0f 8f 75 02 00 00    	jg     1a81 <printf+0x399>
    180c:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    1813:	0f 8c 68 02 00 00    	jl     1a81 <printf+0x399>
    1819:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    181f:	83 e8 63             	sub    $0x63,%eax
    1822:	83 f8 15             	cmp    $0x15,%eax
    1825:	0f 87 56 02 00 00    	ja     1a81 <printf+0x399>
    182b:	89 c0                	mov    %eax,%eax
    182d:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1834:	00 
    1835:	48 b8 18 1e 00 00 00 	movabs $0x1e18,%rax
    183c:	00 00 00 
    183f:	48 01 d0             	add    %rdx,%rax
    1842:	48 8b 00             	mov    (%rax),%rax
    1845:	3e ff e0             	notrack jmp *%rax
    case 'c':
      putc(fd, va_arg(ap, int));
    1848:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    184e:	83 f8 2f             	cmp    $0x2f,%eax
    1851:	77 23                	ja     1876 <printf+0x18e>
    1853:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    185a:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1860:	89 d2                	mov    %edx,%edx
    1862:	48 01 d0             	add    %rdx,%rax
    1865:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    186b:	83 c2 08             	add    $0x8,%edx
    186e:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1874:	eb 12                	jmp    1888 <printf+0x1a0>
    1876:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    187d:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1881:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1888:	8b 00                	mov    (%rax),%eax
    188a:	0f be d0             	movsbl %al,%edx
    188d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1893:	89 d6                	mov    %edx,%esi
    1895:	89 c7                	mov    %eax,%edi
    1897:	48 b8 02 15 00 00 00 	movabs $0x1502,%rax
    189e:	00 00 00 
    18a1:	ff d0                	call   *%rax
      break;
    18a3:	e9 12 02 00 00       	jmp    1aba <printf+0x3d2>
    case 'd':
      print_d(fd, va_arg(ap, int));
    18a8:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    18ae:	83 f8 2f             	cmp    $0x2f,%eax
    18b1:	77 23                	ja     18d6 <printf+0x1ee>
    18b3:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    18ba:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18c0:	89 d2                	mov    %edx,%edx
    18c2:	48 01 d0             	add    %rdx,%rax
    18c5:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18cb:	83 c2 08             	add    $0x8,%edx
    18ce:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    18d4:	eb 12                	jmp    18e8 <printf+0x200>
    18d6:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    18dd:	48 8d 50 08          	lea    0x8(%rax),%rdx
    18e1:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    18e8:	8b 10                	mov    (%rax),%edx
    18ea:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    18f0:	89 d6                	mov    %edx,%esi
    18f2:	89 c7                	mov    %eax,%edi
    18f4:	48 b8 f0 15 00 00 00 	movabs $0x15f0,%rax
    18fb:	00 00 00 
    18fe:	ff d0                	call   *%rax
      break;
    1900:	e9 b5 01 00 00       	jmp    1aba <printf+0x3d2>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    1905:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    190b:	83 f8 2f             	cmp    $0x2f,%eax
    190e:	77 23                	ja     1933 <printf+0x24b>
    1910:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1917:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    191d:	89 d2                	mov    %edx,%edx
    191f:	48 01 d0             	add    %rdx,%rax
    1922:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1928:	83 c2 08             	add    $0x8,%edx
    192b:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1931:	eb 12                	jmp    1945 <printf+0x25d>
    1933:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    193a:	48 8d 50 08          	lea    0x8(%rax),%rdx
    193e:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1945:	8b 10                	mov    (%rax),%edx
    1947:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    194d:	89 d6                	mov    %edx,%esi
    194f:	89 c7                	mov    %eax,%edi
    1951:	48 b8 93 15 00 00 00 	movabs $0x1593,%rax
    1958:	00 00 00 
    195b:	ff d0                	call   *%rax
      break;
    195d:	e9 58 01 00 00       	jmp    1aba <printf+0x3d2>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    1962:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1968:	83 f8 2f             	cmp    $0x2f,%eax
    196b:	77 23                	ja     1990 <printf+0x2a8>
    196d:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1974:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    197a:	89 d2                	mov    %edx,%edx
    197c:	48 01 d0             	add    %rdx,%rax
    197f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1985:	83 c2 08             	add    $0x8,%edx
    1988:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    198e:	eb 12                	jmp    19a2 <printf+0x2ba>
    1990:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1997:	48 8d 50 08          	lea    0x8(%rax),%rdx
    199b:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    19a2:	48 8b 10             	mov    (%rax),%rdx
    19a5:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    19ab:	48 89 d6             	mov    %rdx,%rsi
    19ae:	89 c7                	mov    %eax,%edi
    19b0:	48 b8 36 15 00 00 00 	movabs $0x1536,%rax
    19b7:	00 00 00 
    19ba:	ff d0                	call   *%rax
      break;
    19bc:	e9 f9 00 00 00       	jmp    1aba <printf+0x3d2>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    19c1:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    19c7:	83 f8 2f             	cmp    $0x2f,%eax
    19ca:	77 23                	ja     19ef <printf+0x307>
    19cc:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    19d3:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19d9:	89 d2                	mov    %edx,%edx
    19db:	48 01 d0             	add    %rdx,%rax
    19de:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19e4:	83 c2 08             	add    $0x8,%edx
    19e7:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    19ed:	eb 12                	jmp    1a01 <printf+0x319>
    19ef:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    19f6:	48 8d 50 08          	lea    0x8(%rax),%rdx
    19fa:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a01:	48 8b 00             	mov    (%rax),%rax
    1a04:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    1a0b:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1a12:	00 
    1a13:	75 41                	jne    1a56 <printf+0x36e>
        s = "(null)";
    1a15:	48 b8 10 1e 00 00 00 	movabs $0x1e10,%rax
    1a1c:	00 00 00 
    1a1f:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1a26:	eb 2e                	jmp    1a56 <printf+0x36e>
        putc(fd, *(s++));
    1a28:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1a2f:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1a33:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1a3a:	0f b6 00             	movzbl (%rax),%eax
    1a3d:	0f be d0             	movsbl %al,%edx
    1a40:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a46:	89 d6                	mov    %edx,%esi
    1a48:	89 c7                	mov    %eax,%edi
    1a4a:	48 b8 02 15 00 00 00 	movabs $0x1502,%rax
    1a51:	00 00 00 
    1a54:	ff d0                	call   *%rax
      while (*s)
    1a56:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1a5d:	0f b6 00             	movzbl (%rax),%eax
    1a60:	84 c0                	test   %al,%al
    1a62:	75 c4                	jne    1a28 <printf+0x340>
      break;
    1a64:	eb 54                	jmp    1aba <printf+0x3d2>
    case '%':
      putc(fd, '%');
    1a66:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a6c:	be 25 00 00 00       	mov    $0x25,%esi
    1a71:	89 c7                	mov    %eax,%edi
    1a73:	48 b8 02 15 00 00 00 	movabs $0x1502,%rax
    1a7a:	00 00 00 
    1a7d:	ff d0                	call   *%rax
      break;
    1a7f:	eb 39                	jmp    1aba <printf+0x3d2>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1a81:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a87:	be 25 00 00 00       	mov    $0x25,%esi
    1a8c:	89 c7                	mov    %eax,%edi
    1a8e:	48 b8 02 15 00 00 00 	movabs $0x1502,%rax
    1a95:	00 00 00 
    1a98:	ff d0                	call   *%rax
      putc(fd, c);
    1a9a:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1aa0:	0f be d0             	movsbl %al,%edx
    1aa3:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1aa9:	89 d6                	mov    %edx,%esi
    1aab:	89 c7                	mov    %eax,%edi
    1aad:	48 b8 02 15 00 00 00 	movabs $0x1502,%rax
    1ab4:	00 00 00 
    1ab7:	ff d0                	call   *%rax
      break;
    1ab9:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1aba:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1ac1:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1ac7:	48 63 d0             	movslq %eax,%rdx
    1aca:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1ad1:	48 01 d0             	add    %rdx,%rax
    1ad4:	0f b6 00             	movzbl (%rax),%eax
    1ad7:	0f be c0             	movsbl %al,%eax
    1ada:	25 ff 00 00 00       	and    $0xff,%eax
    1adf:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1ae5:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1aec:	0f 85 8e fc ff ff    	jne    1780 <printf+0x98>
    }
  }
}
    1af2:	eb 01                	jmp    1af5 <printf+0x40d>
      break;
    1af4:	90                   	nop
}
    1af5:	90                   	nop
    1af6:	c9                   	leave
    1af7:	c3                   	ret

0000000000001af8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1af8:	f3 0f 1e fa          	endbr64
    1afc:	55                   	push   %rbp
    1afd:	48 89 e5             	mov    %rsp,%rbp
    1b00:	48 83 ec 18          	sub    $0x18,%rsp
    1b04:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1b08:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1b0c:	48 83 e8 10          	sub    $0x10,%rax
    1b10:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1b14:	48 b8 00 1f 00 00 00 	movabs $0x1f00,%rax
    1b1b:	00 00 00 
    1b1e:	48 8b 00             	mov    (%rax),%rax
    1b21:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1b25:	eb 2f                	jmp    1b56 <free+0x5e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1b27:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b2b:	48 8b 00             	mov    (%rax),%rax
    1b2e:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b32:	72 17                	jb     1b4b <free+0x53>
    1b34:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b38:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b3c:	72 2f                	jb     1b6d <free+0x75>
    1b3e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b42:	48 8b 00             	mov    (%rax),%rax
    1b45:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1b49:	72 22                	jb     1b6d <free+0x75>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1b4b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b4f:	48 8b 00             	mov    (%rax),%rax
    1b52:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1b56:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b5a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b5e:	73 c7                	jae    1b27 <free+0x2f>
    1b60:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b64:	48 8b 00             	mov    (%rax),%rax
    1b67:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1b6b:	73 ba                	jae    1b27 <free+0x2f>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1b6d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b71:	8b 40 08             	mov    0x8(%rax),%eax
    1b74:	89 c0                	mov    %eax,%eax
    1b76:	48 c1 e0 04          	shl    $0x4,%rax
    1b7a:	48 89 c2             	mov    %rax,%rdx
    1b7d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b81:	48 01 c2             	add    %rax,%rdx
    1b84:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b88:	48 8b 00             	mov    (%rax),%rax
    1b8b:	48 39 c2             	cmp    %rax,%rdx
    1b8e:	75 2d                	jne    1bbd <free+0xc5>
    bp->s.size += p->s.ptr->s.size;
    1b90:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b94:	8b 50 08             	mov    0x8(%rax),%edx
    1b97:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b9b:	48 8b 00             	mov    (%rax),%rax
    1b9e:	8b 40 08             	mov    0x8(%rax),%eax
    1ba1:	01 c2                	add    %eax,%edx
    1ba3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ba7:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1baa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bae:	48 8b 00             	mov    (%rax),%rax
    1bb1:	48 8b 10             	mov    (%rax),%rdx
    1bb4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bb8:	48 89 10             	mov    %rdx,(%rax)
    1bbb:	eb 0e                	jmp    1bcb <free+0xd3>
  } else
    bp->s.ptr = p->s.ptr;
    1bbd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bc1:	48 8b 10             	mov    (%rax),%rdx
    1bc4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bc8:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    1bcb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bcf:	8b 40 08             	mov    0x8(%rax),%eax
    1bd2:	89 c0                	mov    %eax,%eax
    1bd4:	48 c1 e0 04          	shl    $0x4,%rax
    1bd8:	48 89 c2             	mov    %rax,%rdx
    1bdb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bdf:	48 01 d0             	add    %rdx,%rax
    1be2:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1be6:	75 27                	jne    1c0f <free+0x117>
    p->s.size += bp->s.size;
    1be8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bec:	8b 50 08             	mov    0x8(%rax),%edx
    1bef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bf3:	8b 40 08             	mov    0x8(%rax),%eax
    1bf6:	01 c2                	add    %eax,%edx
    1bf8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bfc:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    1bff:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c03:	48 8b 10             	mov    (%rax),%rdx
    1c06:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c0a:	48 89 10             	mov    %rdx,(%rax)
    1c0d:	eb 0b                	jmp    1c1a <free+0x122>
  } else
    p->s.ptr = bp;
    1c0f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c13:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1c17:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    1c1a:	48 ba 00 1f 00 00 00 	movabs $0x1f00,%rdx
    1c21:	00 00 00 
    1c24:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c28:	48 89 02             	mov    %rax,(%rdx)
}
    1c2b:	90                   	nop
    1c2c:	c9                   	leave
    1c2d:	c3                   	ret

0000000000001c2e <morecore>:

static Header*
morecore(uint nu)
{
    1c2e:	f3 0f 1e fa          	endbr64
    1c32:	55                   	push   %rbp
    1c33:	48 89 e5             	mov    %rsp,%rbp
    1c36:	48 83 ec 20          	sub    $0x20,%rsp
    1c3a:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    1c3d:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1c44:	77 07                	ja     1c4d <morecore+0x1f>
    nu = 4096;
    1c46:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    1c4d:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1c50:	48 c1 e0 04          	shl    $0x4,%rax
    1c54:	48 89 c7             	mov    %rax,%rdi
    1c57:	48 b8 b4 14 00 00 00 	movabs $0x14b4,%rax
    1c5e:	00 00 00 
    1c61:	ff d0                	call   *%rax
    1c63:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    1c67:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1c6c:	75 07                	jne    1c75 <morecore+0x47>
    return 0;
    1c6e:	b8 00 00 00 00       	mov    $0x0,%eax
    1c73:	eb 36                	jmp    1cab <morecore+0x7d>
  hp = (Header*)p;
    1c75:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c79:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    1c7d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c81:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1c84:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    1c87:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c8b:	48 83 c0 10          	add    $0x10,%rax
    1c8f:	48 89 c7             	mov    %rax,%rdi
    1c92:	48 b8 f8 1a 00 00 00 	movabs $0x1af8,%rax
    1c99:	00 00 00 
    1c9c:	ff d0                	call   *%rax
  return freep;
    1c9e:	48 b8 00 1f 00 00 00 	movabs $0x1f00,%rax
    1ca5:	00 00 00 
    1ca8:	48 8b 00             	mov    (%rax),%rax
}
    1cab:	c9                   	leave
    1cac:	c3                   	ret

0000000000001cad <malloc>:

void*
malloc(uint nbytes)
{
    1cad:	f3 0f 1e fa          	endbr64
    1cb1:	55                   	push   %rbp
    1cb2:	48 89 e5             	mov    %rsp,%rbp
    1cb5:	48 83 ec 30          	sub    $0x30,%rsp
    1cb9:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1cbc:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1cbf:	48 83 c0 0f          	add    $0xf,%rax
    1cc3:	48 c1 e8 04          	shr    $0x4,%rax
    1cc7:	83 c0 01             	add    $0x1,%eax
    1cca:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    1ccd:	48 b8 00 1f 00 00 00 	movabs $0x1f00,%rax
    1cd4:	00 00 00 
    1cd7:	48 8b 00             	mov    (%rax),%rax
    1cda:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1cde:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1ce3:	75 4a                	jne    1d2f <malloc+0x82>
    base.s.ptr = freep = prevp = &base;
    1ce5:	48 b8 f0 1e 00 00 00 	movabs $0x1ef0,%rax
    1cec:	00 00 00 
    1cef:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1cf3:	48 ba 00 1f 00 00 00 	movabs $0x1f00,%rdx
    1cfa:	00 00 00 
    1cfd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d01:	48 89 02             	mov    %rax,(%rdx)
    1d04:	48 b8 00 1f 00 00 00 	movabs $0x1f00,%rax
    1d0b:	00 00 00 
    1d0e:	48 8b 00             	mov    (%rax),%rax
    1d11:	48 ba f0 1e 00 00 00 	movabs $0x1ef0,%rdx
    1d18:	00 00 00 
    1d1b:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    1d1e:	48 b8 f0 1e 00 00 00 	movabs $0x1ef0,%rax
    1d25:	00 00 00 
    1d28:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1d2f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d33:	48 8b 00             	mov    (%rax),%rax
    1d36:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1d3a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d3e:	8b 40 08             	mov    0x8(%rax),%eax
    1d41:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1d44:	72 65                	jb     1dab <malloc+0xfe>
      if(p->s.size == nunits)
    1d46:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d4a:	8b 40 08             	mov    0x8(%rax),%eax
    1d4d:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1d50:	75 10                	jne    1d62 <malloc+0xb5>
        prevp->s.ptr = p->s.ptr;
    1d52:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d56:	48 8b 10             	mov    (%rax),%rdx
    1d59:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d5d:	48 89 10             	mov    %rdx,(%rax)
    1d60:	eb 2e                	jmp    1d90 <malloc+0xe3>
      else {
        p->s.size -= nunits;
    1d62:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d66:	8b 40 08             	mov    0x8(%rax),%eax
    1d69:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1d6c:	89 c2                	mov    %eax,%edx
    1d6e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d72:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    1d75:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d79:	8b 40 08             	mov    0x8(%rax),%eax
    1d7c:	89 c0                	mov    %eax,%eax
    1d7e:	48 c1 e0 04          	shl    $0x4,%rax
    1d82:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    1d86:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d8a:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1d8d:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    1d90:	48 ba 00 1f 00 00 00 	movabs $0x1f00,%rdx
    1d97:	00 00 00 
    1d9a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d9e:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    1da1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1da5:	48 83 c0 10          	add    $0x10,%rax
    1da9:	eb 4e                	jmp    1df9 <malloc+0x14c>
    }
    if(p == freep)
    1dab:	48 b8 00 1f 00 00 00 	movabs $0x1f00,%rax
    1db2:	00 00 00 
    1db5:	48 8b 00             	mov    (%rax),%rax
    1db8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1dbc:	75 23                	jne    1de1 <malloc+0x134>
      if((p = morecore(nunits)) == 0)
    1dbe:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1dc1:	89 c7                	mov    %eax,%edi
    1dc3:	48 b8 2e 1c 00 00 00 	movabs $0x1c2e,%rax
    1dca:	00 00 00 
    1dcd:	ff d0                	call   *%rax
    1dcf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1dd3:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1dd8:	75 07                	jne    1de1 <malloc+0x134>
        return 0;
    1dda:	b8 00 00 00 00       	mov    $0x0,%eax
    1ddf:	eb 18                	jmp    1df9 <malloc+0x14c>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1de1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1de5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1de9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ded:	48 8b 00             	mov    (%rax),%rax
    1df0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1df4:	e9 41 ff ff ff       	jmp    1d3a <malloc+0x8d>
  }
}
    1df9:	c9                   	leave
    1dfa:	c3                   	ret
