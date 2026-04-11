
_wc:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
    1000:	55                   	push   %rbp
    1001:	48 89 e5             	mov    %rsp,%rbp
    1004:	48 83 ec 30          	sub    $0x30,%rsp
    1008:	89 7d dc             	mov    %edi,-0x24(%rbp)
    100b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
    100f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
    1016:	8b 45 f0             	mov    -0x10(%rbp),%eax
    1019:	89 45 f4             	mov    %eax,-0xc(%rbp)
    101c:	8b 45 f4             	mov    -0xc(%rbp),%eax
    101f:	89 45 f8             	mov    %eax,-0x8(%rbp)
  inword = 0;
    1022:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
    1029:	e9 84 00 00 00       	jmp    10b2 <wc+0xb2>
    for(i=0; i<n; i++){
    102e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1035:	eb 73                	jmp    10aa <wc+0xaa>
      c++;
    1037:	83 45 f0 01          	addl   $0x1,-0x10(%rbp)
      if(buf[i] == '\n')
    103b:	48 ba 20 20 00 00 00 	movabs $0x2020,%rdx
    1042:	00 00 00 
    1045:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1048:	48 98                	cltq
    104a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    104e:	3c 0a                	cmp    $0xa,%al
    1050:	75 04                	jne    1056 <wc+0x56>
        l++;
    1052:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
      if(strchr(" \r\t\n\v", buf[i]))
    1056:	48 ba 20 20 00 00 00 	movabs $0x2020,%rdx
    105d:	00 00 00 
    1060:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1063:	48 98                	cltq
    1065:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1069:	0f be c0             	movsbl %al,%eax
    106c:	48 ba a3 1f 00 00 00 	movabs $0x1fa3,%rdx
    1073:	00 00 00 
    1076:	89 c6                	mov    %eax,%esi
    1078:	48 89 d7             	mov    %rdx,%rdi
    107b:	48 b8 a3 13 00 00 00 	movabs $0x13a3,%rax
    1082:	00 00 00 
    1085:	ff d0                	call   *%rax
    1087:	48 85 c0             	test   %rax,%rax
    108a:	74 09                	je     1095 <wc+0x95>
        inword = 0;
    108c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    1093:	eb 11                	jmp    10a6 <wc+0xa6>
      else if(!inword){
    1095:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
    1099:	75 0b                	jne    10a6 <wc+0xa6>
        w++;
    109b:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
        inword = 1;
    109f:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%rbp)
    for(i=0; i<n; i++){
    10a6:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    10aa:	8b 45 fc             	mov    -0x4(%rbp),%eax
    10ad:	3b 45 e8             	cmp    -0x18(%rbp),%eax
    10b0:	7c 85                	jl     1037 <wc+0x37>
  while((n = read(fd, buf, sizeof(buf))) > 0){
    10b2:	48 b9 20 20 00 00 00 	movabs $0x2020,%rcx
    10b9:	00 00 00 
    10bc:	8b 45 dc             	mov    -0x24(%rbp),%eax
    10bf:	ba 00 02 00 00       	mov    $0x200,%edx
    10c4:	48 89 ce             	mov    %rcx,%rsi
    10c7:	89 c7                	mov    %eax,%edi
    10c9:	48 b8 b4 15 00 00 00 	movabs $0x15b4,%rax
    10d0:	00 00 00 
    10d3:	ff d0                	call   *%rax
    10d5:	89 45 e8             	mov    %eax,-0x18(%rbp)
    10d8:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
    10dc:	0f 8f 4c ff ff ff    	jg     102e <wc+0x2e>
      }
    }
  }
  if(n < 0){
    10e2:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
    10e6:	79 2f                	jns    1117 <wc+0x117>
    printf(1, "wc: read error\n");
    10e8:	48 b8 a9 1f 00 00 00 	movabs $0x1fa9,%rax
    10ef:	00 00 00 
    10f2:	48 89 c6             	mov    %rax,%rsi
    10f5:	bf 01 00 00 00       	mov    $0x1,%edi
    10fa:	b8 00 00 00 00       	mov    $0x0,%eax
    10ff:	48 ba 81 18 00 00 00 	movabs $0x1881,%rdx
    1106:	00 00 00 
    1109:	ff d2                	call   *%rdx
    exit();
    110b:	48 b8 8d 15 00 00 00 	movabs $0x158d,%rax
    1112:	00 00 00 
    1115:	ff d0                	call   *%rax
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
    1117:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
    111b:	8b 4d f0             	mov    -0x10(%rbp),%ecx
    111e:	8b 55 f4             	mov    -0xc(%rbp),%edx
    1121:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1124:	48 be b9 1f 00 00 00 	movabs $0x1fb9,%rsi
    112b:	00 00 00 
    112e:	49 89 f9             	mov    %rdi,%r9
    1131:	41 89 c8             	mov    %ecx,%r8d
    1134:	89 d1                	mov    %edx,%ecx
    1136:	89 c2                	mov    %eax,%edx
    1138:	bf 01 00 00 00       	mov    $0x1,%edi
    113d:	b8 00 00 00 00       	mov    $0x0,%eax
    1142:	49 ba 81 18 00 00 00 	movabs $0x1881,%r10
    1149:	00 00 00 
    114c:	41 ff d2             	call   *%r10
}
    114f:	90                   	nop
    1150:	c9                   	leave
    1151:	c3                   	ret

0000000000001152 <main>:

int
main(int argc, char *argv[])
{
    1152:	55                   	push   %rbp
    1153:	48 89 e5             	mov    %rsp,%rbp
    1156:	48 83 ec 20          	sub    $0x20,%rsp
    115a:	89 7d ec             	mov    %edi,-0x14(%rbp)
    115d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd, i;

  if(argc <= 1){
    1161:	83 7d ec 01          	cmpl   $0x1,-0x14(%rbp)
    1165:	7f 2a                	jg     1191 <main+0x3f>
    wc(0, "");
    1167:	48 b8 c6 1f 00 00 00 	movabs $0x1fc6,%rax
    116e:	00 00 00 
    1171:	48 89 c6             	mov    %rax,%rsi
    1174:	bf 00 00 00 00       	mov    $0x0,%edi
    1179:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1180:	00 00 00 
    1183:	ff d0                	call   *%rax
    exit();
    1185:	48 b8 8d 15 00 00 00 	movabs $0x158d,%rax
    118c:	00 00 00 
    118f:	ff d0                	call   *%rax
  }

  for(i = 1; i < argc; i++){
    1191:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
    1198:	e9 bd 00 00 00       	jmp    125a <main+0x108>
    if((fd = open(argv[i], 0)) < 0){
    119d:	8b 45 fc             	mov    -0x4(%rbp),%eax
    11a0:	48 98                	cltq
    11a2:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    11a9:	00 
    11aa:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    11ae:	48 01 d0             	add    %rdx,%rax
    11b1:	48 8b 00             	mov    (%rax),%rax
    11b4:	be 00 00 00 00       	mov    $0x0,%esi
    11b9:	48 89 c7             	mov    %rax,%rdi
    11bc:	48 b8 f5 15 00 00 00 	movabs $0x15f5,%rax
    11c3:	00 00 00 
    11c6:	ff d0                	call   *%rax
    11c8:	89 45 f8             	mov    %eax,-0x8(%rbp)
    11cb:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    11cf:	79 49                	jns    121a <main+0xc8>
      printf(1, "wc: cannot open %s\n", argv[i]);
    11d1:	8b 45 fc             	mov    -0x4(%rbp),%eax
    11d4:	48 98                	cltq
    11d6:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    11dd:	00 
    11de:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    11e2:	48 01 d0             	add    %rdx,%rax
    11e5:	48 8b 00             	mov    (%rax),%rax
    11e8:	48 b9 c7 1f 00 00 00 	movabs $0x1fc7,%rcx
    11ef:	00 00 00 
    11f2:	48 89 c2             	mov    %rax,%rdx
    11f5:	48 89 ce             	mov    %rcx,%rsi
    11f8:	bf 01 00 00 00       	mov    $0x1,%edi
    11fd:	b8 00 00 00 00       	mov    $0x0,%eax
    1202:	48 b9 81 18 00 00 00 	movabs $0x1881,%rcx
    1209:	00 00 00 
    120c:	ff d1                	call   *%rcx
      exit();
    120e:	48 b8 8d 15 00 00 00 	movabs $0x158d,%rax
    1215:	00 00 00 
    1218:	ff d0                	call   *%rax
    }
    wc(fd, argv[i]);
    121a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    121d:	48 98                	cltq
    121f:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1226:	00 
    1227:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    122b:	48 01 d0             	add    %rdx,%rax
    122e:	48 8b 10             	mov    (%rax),%rdx
    1231:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1234:	48 89 d6             	mov    %rdx,%rsi
    1237:	89 c7                	mov    %eax,%edi
    1239:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1240:	00 00 00 
    1243:	ff d0                	call   *%rax
    close(fd);
    1245:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1248:	89 c7                	mov    %eax,%edi
    124a:	48 b8 ce 15 00 00 00 	movabs $0x15ce,%rax
    1251:	00 00 00 
    1254:	ff d0                	call   *%rax
  for(i = 1; i < argc; i++){
    1256:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    125a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    125d:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1260:	0f 8c 37 ff ff ff    	jl     119d <main+0x4b>
  }
  exit();
    1266:	48 b8 8d 15 00 00 00 	movabs $0x158d,%rax
    126d:	00 00 00 
    1270:	ff d0                	call   *%rax

0000000000001272 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1272:	55                   	push   %rbp
    1273:	48 89 e5             	mov    %rsp,%rbp
    1276:	48 83 ec 10          	sub    $0x10,%rsp
    127a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    127e:	89 75 f4             	mov    %esi,-0xc(%rbp)
    1281:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
    1284:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1288:	8b 55 f0             	mov    -0x10(%rbp),%edx
    128b:	8b 45 f4             	mov    -0xc(%rbp),%eax
    128e:	48 89 ce             	mov    %rcx,%rsi
    1291:	48 89 f7             	mov    %rsi,%rdi
    1294:	89 d1                	mov    %edx,%ecx
    1296:	fc                   	cld
    1297:	f3 aa                	rep stos %al,(%rdi)
    1299:	89 ca                	mov    %ecx,%edx
    129b:	48 89 fe             	mov    %rdi,%rsi
    129e:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    12a2:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    12a5:	90                   	nop
    12a6:	c9                   	leave
    12a7:	c3                   	ret

00000000000012a8 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    12a8:	55                   	push   %rbp
    12a9:	48 89 e5             	mov    %rsp,%rbp
    12ac:	48 83 ec 20          	sub    $0x20,%rsp
    12b0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    12b4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
    12b8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12bc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    12c0:	90                   	nop
    12c1:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    12c5:	48 8d 42 01          	lea    0x1(%rdx),%rax
    12c9:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    12cd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12d1:	48 8d 48 01          	lea    0x1(%rax),%rcx
    12d5:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    12d9:	0f b6 12             	movzbl (%rdx),%edx
    12dc:	88 10                	mov    %dl,(%rax)
    12de:	0f b6 00             	movzbl (%rax),%eax
    12e1:	84 c0                	test   %al,%al
    12e3:	75 dc                	jne    12c1 <strcpy+0x19>
    ;
  return os;
    12e5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    12e9:	c9                   	leave
    12ea:	c3                   	ret

00000000000012eb <strcmp>:

int
strcmp(const char *p, const char *q)
{
    12eb:	55                   	push   %rbp
    12ec:	48 89 e5             	mov    %rsp,%rbp
    12ef:	48 83 ec 10          	sub    $0x10,%rsp
    12f3:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    12f7:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    12fb:	eb 0a                	jmp    1307 <strcmp+0x1c>
    p++, q++;
    12fd:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1302:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    1307:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    130b:	0f b6 00             	movzbl (%rax),%eax
    130e:	84 c0                	test   %al,%al
    1310:	74 12                	je     1324 <strcmp+0x39>
    1312:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1316:	0f b6 10             	movzbl (%rax),%edx
    1319:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    131d:	0f b6 00             	movzbl (%rax),%eax
    1320:	38 c2                	cmp    %al,%dl
    1322:	74 d9                	je     12fd <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
    1324:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1328:	0f b6 00             	movzbl (%rax),%eax
    132b:	0f b6 d0             	movzbl %al,%edx
    132e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1332:	0f b6 00             	movzbl (%rax),%eax
    1335:	0f b6 c0             	movzbl %al,%eax
    1338:	29 c2                	sub    %eax,%edx
    133a:	89 d0                	mov    %edx,%eax
}
    133c:	c9                   	leave
    133d:	c3                   	ret

000000000000133e <strlen>:

uint
strlen(char *s)
{
    133e:	55                   	push   %rbp
    133f:	48 89 e5             	mov    %rsp,%rbp
    1342:	48 83 ec 18          	sub    $0x18,%rsp
    1346:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
    134a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1351:	eb 04                	jmp    1357 <strlen+0x19>
    1353:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1357:	8b 45 fc             	mov    -0x4(%rbp),%eax
    135a:	48 63 d0             	movslq %eax,%rdx
    135d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1361:	48 01 d0             	add    %rdx,%rax
    1364:	0f b6 00             	movzbl (%rax),%eax
    1367:	84 c0                	test   %al,%al
    1369:	75 e8                	jne    1353 <strlen+0x15>
    ;
  return n;
    136b:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    136e:	c9                   	leave
    136f:	c3                   	ret

0000000000001370 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1370:	55                   	push   %rbp
    1371:	48 89 e5             	mov    %rsp,%rbp
    1374:	48 83 ec 10          	sub    $0x10,%rsp
    1378:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    137c:	89 75 f4             	mov    %esi,-0xc(%rbp)
    137f:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    1382:	8b 55 f0             	mov    -0x10(%rbp),%edx
    1385:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    1388:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    138c:	89 ce                	mov    %ecx,%esi
    138e:	48 89 c7             	mov    %rax,%rdi
    1391:	48 b8 72 12 00 00 00 	movabs $0x1272,%rax
    1398:	00 00 00 
    139b:	ff d0                	call   *%rax
  return dst;
    139d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    13a1:	c9                   	leave
    13a2:	c3                   	ret

00000000000013a3 <strchr>:

char*
strchr(const char *s, char c)
{
    13a3:	55                   	push   %rbp
    13a4:	48 89 e5             	mov    %rsp,%rbp
    13a7:	48 83 ec 10          	sub    $0x10,%rsp
    13ab:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    13af:	89 f0                	mov    %esi,%eax
    13b1:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    13b4:	eb 17                	jmp    13cd <strchr+0x2a>
    if(*s == c)
    13b6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13ba:	0f b6 00             	movzbl (%rax),%eax
    13bd:	38 45 f4             	cmp    %al,-0xc(%rbp)
    13c0:	75 06                	jne    13c8 <strchr+0x25>
      return (char*)s;
    13c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13c6:	eb 15                	jmp    13dd <strchr+0x3a>
  for(; *s; s++)
    13c8:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    13cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13d1:	0f b6 00             	movzbl (%rax),%eax
    13d4:	84 c0                	test   %al,%al
    13d6:	75 de                	jne    13b6 <strchr+0x13>
  return 0;
    13d8:	b8 00 00 00 00       	mov    $0x0,%eax
}
    13dd:	c9                   	leave
    13de:	c3                   	ret

00000000000013df <gets>:

char*
gets(char *buf, int max)
{
    13df:	55                   	push   %rbp
    13e0:	48 89 e5             	mov    %rsp,%rbp
    13e3:	48 83 ec 20          	sub    $0x20,%rsp
    13e7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    13eb:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    13ee:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    13f5:	eb 4f                	jmp    1446 <gets+0x67>
    cc = read(0, &c, 1);
    13f7:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    13fb:	ba 01 00 00 00       	mov    $0x1,%edx
    1400:	48 89 c6             	mov    %rax,%rsi
    1403:	bf 00 00 00 00       	mov    $0x0,%edi
    1408:	48 b8 b4 15 00 00 00 	movabs $0x15b4,%rax
    140f:	00 00 00 
    1412:	ff d0                	call   *%rax
    1414:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    1417:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    141b:	7e 36                	jle    1453 <gets+0x74>
      break;
    buf[i++] = c;
    141d:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1420:	8d 50 01             	lea    0x1(%rax),%edx
    1423:	89 55 fc             	mov    %edx,-0x4(%rbp)
    1426:	48 63 d0             	movslq %eax,%rdx
    1429:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    142d:	48 01 c2             	add    %rax,%rdx
    1430:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1434:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    1436:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    143a:	3c 0a                	cmp    $0xa,%al
    143c:	74 16                	je     1454 <gets+0x75>
    143e:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1442:	3c 0d                	cmp    $0xd,%al
    1444:	74 0e                	je     1454 <gets+0x75>
  for(i=0; i+1 < max; ){
    1446:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1449:	83 c0 01             	add    $0x1,%eax
    144c:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    144f:	7f a6                	jg     13f7 <gets+0x18>
    1451:	eb 01                	jmp    1454 <gets+0x75>
      break;
    1453:	90                   	nop
      break;
  }
  buf[i] = '\0';
    1454:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1457:	48 63 d0             	movslq %eax,%rdx
    145a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    145e:	48 01 d0             	add    %rdx,%rax
    1461:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    1464:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    1468:	c9                   	leave
    1469:	c3                   	ret

000000000000146a <stat>:

int
stat(char *n, struct stat *st)
{
    146a:	55                   	push   %rbp
    146b:	48 89 e5             	mov    %rsp,%rbp
    146e:	48 83 ec 20          	sub    $0x20,%rsp
    1472:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1476:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    147a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    147e:	be 00 00 00 00       	mov    $0x0,%esi
    1483:	48 89 c7             	mov    %rax,%rdi
    1486:	48 b8 f5 15 00 00 00 	movabs $0x15f5,%rax
    148d:	00 00 00 
    1490:	ff d0                	call   *%rax
    1492:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    1495:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1499:	79 07                	jns    14a2 <stat+0x38>
    return -1;
    149b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    14a0:	eb 2f                	jmp    14d1 <stat+0x67>
  r = fstat(fd, st);
    14a2:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    14a6:	8b 45 fc             	mov    -0x4(%rbp),%eax
    14a9:	48 89 d6             	mov    %rdx,%rsi
    14ac:	89 c7                	mov    %eax,%edi
    14ae:	48 b8 1c 16 00 00 00 	movabs $0x161c,%rax
    14b5:	00 00 00 
    14b8:	ff d0                	call   *%rax
    14ba:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    14bd:	8b 45 fc             	mov    -0x4(%rbp),%eax
    14c0:	89 c7                	mov    %eax,%edi
    14c2:	48 b8 ce 15 00 00 00 	movabs $0x15ce,%rax
    14c9:	00 00 00 
    14cc:	ff d0                	call   *%rax
  return r;
    14ce:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    14d1:	c9                   	leave
    14d2:	c3                   	ret

00000000000014d3 <atoi>:

int
atoi(const char *s)
{
    14d3:	55                   	push   %rbp
    14d4:	48 89 e5             	mov    %rsp,%rbp
    14d7:	48 83 ec 18          	sub    $0x18,%rsp
    14db:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    14df:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    14e6:	eb 28                	jmp    1510 <atoi+0x3d>
    n = n*10 + *s++ - '0';
    14e8:	8b 55 fc             	mov    -0x4(%rbp),%edx
    14eb:	89 d0                	mov    %edx,%eax
    14ed:	c1 e0 02             	shl    $0x2,%eax
    14f0:	01 d0                	add    %edx,%eax
    14f2:	01 c0                	add    %eax,%eax
    14f4:	89 c1                	mov    %eax,%ecx
    14f6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    14fa:	48 8d 50 01          	lea    0x1(%rax),%rdx
    14fe:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    1502:	0f b6 00             	movzbl (%rax),%eax
    1505:	0f be c0             	movsbl %al,%eax
    1508:	01 c8                	add    %ecx,%eax
    150a:	83 e8 30             	sub    $0x30,%eax
    150d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1510:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1514:	0f b6 00             	movzbl (%rax),%eax
    1517:	3c 2f                	cmp    $0x2f,%al
    1519:	7e 0b                	jle    1526 <atoi+0x53>
    151b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    151f:	0f b6 00             	movzbl (%rax),%eax
    1522:	3c 39                	cmp    $0x39,%al
    1524:	7e c2                	jle    14e8 <atoi+0x15>
  return n;
    1526:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    1529:	c9                   	leave
    152a:	c3                   	ret

000000000000152b <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    152b:	55                   	push   %rbp
    152c:	48 89 e5             	mov    %rsp,%rbp
    152f:	48 83 ec 28          	sub    $0x28,%rsp
    1533:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1537:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    153b:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    153e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1542:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    1546:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    154a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    154e:	eb 1d                	jmp    156d <memmove+0x42>
    *dst++ = *src++;
    1550:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1554:	48 8d 42 01          	lea    0x1(%rdx),%rax
    1558:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    155c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1560:	48 8d 48 01          	lea    0x1(%rax),%rcx
    1564:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    1568:	0f b6 12             	movzbl (%rdx),%edx
    156b:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    156d:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1570:	8d 50 ff             	lea    -0x1(%rax),%edx
    1573:	89 55 dc             	mov    %edx,-0x24(%rbp)
    1576:	85 c0                	test   %eax,%eax
    1578:	7f d6                	jg     1550 <memmove+0x25>
  return vdst;
    157a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    157e:	c9                   	leave
    157f:	c3                   	ret

0000000000001580 <fork>:
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    1580:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    1587:	49 89 ca             	mov    %rcx,%r10
    158a:	0f 05                	syscall
    158c:	c3                   	ret

000000000000158d <exit>:
SYSCALL(exit)
    158d:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    1594:	49 89 ca             	mov    %rcx,%r10
    1597:	0f 05                	syscall
    1599:	c3                   	ret

000000000000159a <wait>:
SYSCALL(wait)
    159a:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    15a1:	49 89 ca             	mov    %rcx,%r10
    15a4:	0f 05                	syscall
    15a6:	c3                   	ret

00000000000015a7 <pipe>:
SYSCALL(pipe)
    15a7:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    15ae:	49 89 ca             	mov    %rcx,%r10
    15b1:	0f 05                	syscall
    15b3:	c3                   	ret

00000000000015b4 <read>:
SYSCALL(read)
    15b4:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    15bb:	49 89 ca             	mov    %rcx,%r10
    15be:	0f 05                	syscall
    15c0:	c3                   	ret

00000000000015c1 <write>:
SYSCALL(write)
    15c1:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    15c8:	49 89 ca             	mov    %rcx,%r10
    15cb:	0f 05                	syscall
    15cd:	c3                   	ret

00000000000015ce <close>:
SYSCALL(close)
    15ce:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    15d5:	49 89 ca             	mov    %rcx,%r10
    15d8:	0f 05                	syscall
    15da:	c3                   	ret

00000000000015db <kill>:
SYSCALL(kill)
    15db:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    15e2:	49 89 ca             	mov    %rcx,%r10
    15e5:	0f 05                	syscall
    15e7:	c3                   	ret

00000000000015e8 <exec>:
SYSCALL(exec)
    15e8:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    15ef:	49 89 ca             	mov    %rcx,%r10
    15f2:	0f 05                	syscall
    15f4:	c3                   	ret

00000000000015f5 <open>:
SYSCALL(open)
    15f5:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    15fc:	49 89 ca             	mov    %rcx,%r10
    15ff:	0f 05                	syscall
    1601:	c3                   	ret

0000000000001602 <mknod>:
SYSCALL(mknod)
    1602:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    1609:	49 89 ca             	mov    %rcx,%r10
    160c:	0f 05                	syscall
    160e:	c3                   	ret

000000000000160f <unlink>:
SYSCALL(unlink)
    160f:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    1616:	49 89 ca             	mov    %rcx,%r10
    1619:	0f 05                	syscall
    161b:	c3                   	ret

000000000000161c <fstat>:
SYSCALL(fstat)
    161c:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    1623:	49 89 ca             	mov    %rcx,%r10
    1626:	0f 05                	syscall
    1628:	c3                   	ret

0000000000001629 <link>:
SYSCALL(link)
    1629:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    1630:	49 89 ca             	mov    %rcx,%r10
    1633:	0f 05                	syscall
    1635:	c3                   	ret

0000000000001636 <mkdir>:
SYSCALL(mkdir)
    1636:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    163d:	49 89 ca             	mov    %rcx,%r10
    1640:	0f 05                	syscall
    1642:	c3                   	ret

0000000000001643 <chdir>:
SYSCALL(chdir)
    1643:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    164a:	49 89 ca             	mov    %rcx,%r10
    164d:	0f 05                	syscall
    164f:	c3                   	ret

0000000000001650 <dup>:
SYSCALL(dup)
    1650:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    1657:	49 89 ca             	mov    %rcx,%r10
    165a:	0f 05                	syscall
    165c:	c3                   	ret

000000000000165d <getpid>:
SYSCALL(getpid)
    165d:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    1664:	49 89 ca             	mov    %rcx,%r10
    1667:	0f 05                	syscall
    1669:	c3                   	ret

000000000000166a <sbrk>:
SYSCALL(sbrk)
    166a:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    1671:	49 89 ca             	mov    %rcx,%r10
    1674:	0f 05                	syscall
    1676:	c3                   	ret

0000000000001677 <sleep>:
SYSCALL(sleep)
    1677:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    167e:	49 89 ca             	mov    %rcx,%r10
    1681:	0f 05                	syscall
    1683:	c3                   	ret

0000000000001684 <uptime>:
SYSCALL(uptime)
    1684:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    168b:	49 89 ca             	mov    %rcx,%r10
    168e:	0f 05                	syscall
    1690:	c3                   	ret

0000000000001691 <send>:
SYSCALL(send)
    1691:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    1698:	49 89 ca             	mov    %rcx,%r10
    169b:	0f 05                	syscall
    169d:	c3                   	ret

000000000000169e <recv>:
SYSCALL(recv)
    169e:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    16a5:	49 89 ca             	mov    %rcx,%r10
    16a8:	0f 05                	syscall
    16aa:	c3                   	ret

00000000000016ab <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    16ab:	55                   	push   %rbp
    16ac:	48 89 e5             	mov    %rsp,%rbp
    16af:	48 83 ec 10          	sub    $0x10,%rsp
    16b3:	89 7d fc             	mov    %edi,-0x4(%rbp)
    16b6:	89 f0                	mov    %esi,%eax
    16b8:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    16bb:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    16bf:	8b 45 fc             	mov    -0x4(%rbp),%eax
    16c2:	ba 01 00 00 00       	mov    $0x1,%edx
    16c7:	48 89 ce             	mov    %rcx,%rsi
    16ca:	89 c7                	mov    %eax,%edi
    16cc:	48 b8 c1 15 00 00 00 	movabs $0x15c1,%rax
    16d3:	00 00 00 
    16d6:	ff d0                	call   *%rax
}
    16d8:	90                   	nop
    16d9:	c9                   	leave
    16da:	c3                   	ret

00000000000016db <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    16db:	55                   	push   %rbp
    16dc:	48 89 e5             	mov    %rsp,%rbp
    16df:	48 83 ec 20          	sub    $0x20,%rsp
    16e3:	89 7d ec             	mov    %edi,-0x14(%rbp)
    16e6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    16ea:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    16f1:	eb 35                	jmp    1728 <print_x64+0x4d>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    16f3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    16f7:	48 c1 e8 3c          	shr    $0x3c,%rax
    16fb:	48 ba f0 1f 00 00 00 	movabs $0x1ff0,%rdx
    1702:	00 00 00 
    1705:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1709:	0f be d0             	movsbl %al,%edx
    170c:	8b 45 ec             	mov    -0x14(%rbp),%eax
    170f:	89 d6                	mov    %edx,%esi
    1711:	89 c7                	mov    %eax,%edi
    1713:	48 b8 ab 16 00 00 00 	movabs $0x16ab,%rax
    171a:	00 00 00 
    171d:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    171f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1723:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    1728:	8b 45 fc             	mov    -0x4(%rbp),%eax
    172b:	83 f8 0f             	cmp    $0xf,%eax
    172e:	76 c3                	jbe    16f3 <print_x64+0x18>
}
    1730:	90                   	nop
    1731:	90                   	nop
    1732:	c9                   	leave
    1733:	c3                   	ret

0000000000001734 <print_x32>:

  static void
print_x32(int fd, uint x)
{
    1734:	55                   	push   %rbp
    1735:	48 89 e5             	mov    %rsp,%rbp
    1738:	48 83 ec 20          	sub    $0x20,%rsp
    173c:	89 7d ec             	mov    %edi,-0x14(%rbp)
    173f:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1742:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1749:	eb 36                	jmp    1781 <print_x32+0x4d>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    174b:	8b 45 e8             	mov    -0x18(%rbp),%eax
    174e:	c1 e8 1c             	shr    $0x1c,%eax
    1751:	89 c2                	mov    %eax,%edx
    1753:	48 b8 f0 1f 00 00 00 	movabs $0x1ff0,%rax
    175a:	00 00 00 
    175d:	89 d2                	mov    %edx,%edx
    175f:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    1763:	0f be d0             	movsbl %al,%edx
    1766:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1769:	89 d6                	mov    %edx,%esi
    176b:	89 c7                	mov    %eax,%edi
    176d:	48 b8 ab 16 00 00 00 	movabs $0x16ab,%rax
    1774:	00 00 00 
    1777:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1779:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    177d:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    1781:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1784:	83 f8 07             	cmp    $0x7,%eax
    1787:	76 c2                	jbe    174b <print_x32+0x17>
}
    1789:	90                   	nop
    178a:	90                   	nop
    178b:	c9                   	leave
    178c:	c3                   	ret

000000000000178d <print_d>:

  static void
print_d(int fd, int v)
{
    178d:	55                   	push   %rbp
    178e:	48 89 e5             	mov    %rsp,%rbp
    1791:	48 83 ec 30          	sub    $0x30,%rsp
    1795:	89 7d dc             	mov    %edi,-0x24(%rbp)
    1798:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    179b:	8b 45 d8             	mov    -0x28(%rbp),%eax
    179e:	48 98                	cltq
    17a0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    17a4:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    17a8:	79 04                	jns    17ae <print_d+0x21>
    x = -x;
    17aa:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    17ae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    17b5:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    17b9:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    17c0:	66 66 66 
    17c3:	48 89 c8             	mov    %rcx,%rax
    17c6:	48 f7 ea             	imul   %rdx
    17c9:	48 c1 fa 02          	sar    $0x2,%rdx
    17cd:	48 89 c8             	mov    %rcx,%rax
    17d0:	48 c1 f8 3f          	sar    $0x3f,%rax
    17d4:	48 29 c2             	sub    %rax,%rdx
    17d7:	48 89 d0             	mov    %rdx,%rax
    17da:	48 c1 e0 02          	shl    $0x2,%rax
    17de:	48 01 d0             	add    %rdx,%rax
    17e1:	48 01 c0             	add    %rax,%rax
    17e4:	48 29 c1             	sub    %rax,%rcx
    17e7:	48 89 ca             	mov    %rcx,%rdx
    17ea:	8b 45 f4             	mov    -0xc(%rbp),%eax
    17ed:	8d 48 01             	lea    0x1(%rax),%ecx
    17f0:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    17f3:	48 b9 f0 1f 00 00 00 	movabs $0x1ff0,%rcx
    17fa:	00 00 00 
    17fd:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    1801:	48 98                	cltq
    1803:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    1807:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    180b:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1812:	66 66 66 
    1815:	48 89 c8             	mov    %rcx,%rax
    1818:	48 f7 ea             	imul   %rdx
    181b:	48 89 d0             	mov    %rdx,%rax
    181e:	48 c1 f8 02          	sar    $0x2,%rax
    1822:	48 c1 f9 3f          	sar    $0x3f,%rcx
    1826:	48 89 ca             	mov    %rcx,%rdx
    1829:	48 29 d0             	sub    %rdx,%rax
    182c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    1830:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1835:	0f 85 7a ff ff ff    	jne    17b5 <print_d+0x28>

  if (v < 0)
    183b:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    183f:	79 32                	jns    1873 <print_d+0xe6>
    buf[i++] = '-';
    1841:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1844:	8d 50 01             	lea    0x1(%rax),%edx
    1847:	89 55 f4             	mov    %edx,-0xc(%rbp)
    184a:	48 98                	cltq
    184c:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    1851:	eb 20                	jmp    1873 <print_d+0xe6>
    putc(fd, buf[i]);
    1853:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1856:	48 98                	cltq
    1858:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    185d:	0f be d0             	movsbl %al,%edx
    1860:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1863:	89 d6                	mov    %edx,%esi
    1865:	89 c7                	mov    %eax,%edi
    1867:	48 b8 ab 16 00 00 00 	movabs $0x16ab,%rax
    186e:	00 00 00 
    1871:	ff d0                	call   *%rax
  while (--i >= 0)
    1873:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    1877:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    187b:	79 d6                	jns    1853 <print_d+0xc6>
}
    187d:	90                   	nop
    187e:	90                   	nop
    187f:	c9                   	leave
    1880:	c3                   	ret

0000000000001881 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    1881:	55                   	push   %rbp
    1882:	48 89 e5             	mov    %rsp,%rbp
    1885:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    188c:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    1892:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    1899:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    18a0:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    18a7:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    18ae:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    18b5:	84 c0                	test   %al,%al
    18b7:	74 20                	je     18d9 <printf+0x58>
    18b9:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    18bd:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    18c1:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    18c5:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    18c9:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    18cd:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    18d1:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    18d5:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    18d9:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    18e0:	00 00 00 
    18e3:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    18ea:	00 00 00 
    18ed:	48 8d 45 10          	lea    0x10(%rbp),%rax
    18f1:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    18f8:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    18ff:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1906:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    190d:	00 00 00 
    1910:	e9 60 03 00 00       	jmp    1c75 <printf+0x3f4>
    if (c != '%') {
    1915:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    191c:	74 24                	je     1942 <printf+0xc1>
      putc(fd, c);
    191e:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1924:	0f be d0             	movsbl %al,%edx
    1927:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    192d:	89 d6                	mov    %edx,%esi
    192f:	89 c7                	mov    %eax,%edi
    1931:	48 b8 ab 16 00 00 00 	movabs $0x16ab,%rax
    1938:	00 00 00 
    193b:	ff d0                	call   *%rax
      continue;
    193d:	e9 2c 03 00 00       	jmp    1c6e <printf+0x3ed>
    }
    c = fmt[++i] & 0xff;
    1942:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1949:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    194f:	48 63 d0             	movslq %eax,%rdx
    1952:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1959:	48 01 d0             	add    %rdx,%rax
    195c:	0f b6 00             	movzbl (%rax),%eax
    195f:	0f be c0             	movsbl %al,%eax
    1962:	25 ff 00 00 00       	and    $0xff,%eax
    1967:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    196d:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1974:	0f 84 2e 03 00 00    	je     1ca8 <printf+0x427>
      break;
    switch(c) {
    197a:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    1981:	0f 84 32 01 00 00    	je     1ab9 <printf+0x238>
    1987:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    198e:	0f 8f a1 02 00 00    	jg     1c35 <printf+0x3b4>
    1994:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    199b:	0f 84 d4 01 00 00    	je     1b75 <printf+0x2f4>
    19a1:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    19a8:	0f 8f 87 02 00 00    	jg     1c35 <printf+0x3b4>
    19ae:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    19b5:	0f 84 5b 01 00 00    	je     1b16 <printf+0x295>
    19bb:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    19c2:	0f 8f 6d 02 00 00    	jg     1c35 <printf+0x3b4>
    19c8:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    19cf:	0f 84 87 00 00 00    	je     1a5c <printf+0x1db>
    19d5:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    19dc:	0f 8f 53 02 00 00    	jg     1c35 <printf+0x3b4>
    19e2:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    19e9:	0f 84 2b 02 00 00    	je     1c1a <printf+0x399>
    19ef:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    19f6:	0f 85 39 02 00 00    	jne    1c35 <printf+0x3b4>
    case 'c':
      putc(fd, va_arg(ap, int));
    19fc:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1a02:	83 f8 2f             	cmp    $0x2f,%eax
    1a05:	77 23                	ja     1a2a <printf+0x1a9>
    1a07:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1a0e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a14:	89 d2                	mov    %edx,%edx
    1a16:	48 01 d0             	add    %rdx,%rax
    1a19:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a1f:	83 c2 08             	add    $0x8,%edx
    1a22:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1a28:	eb 12                	jmp    1a3c <printf+0x1bb>
    1a2a:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a31:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a35:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a3c:	8b 00                	mov    (%rax),%eax
    1a3e:	0f be d0             	movsbl %al,%edx
    1a41:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a47:	89 d6                	mov    %edx,%esi
    1a49:	89 c7                	mov    %eax,%edi
    1a4b:	48 b8 ab 16 00 00 00 	movabs $0x16ab,%rax
    1a52:	00 00 00 
    1a55:	ff d0                	call   *%rax
      break;
    1a57:	e9 12 02 00 00       	jmp    1c6e <printf+0x3ed>
    case 'd':
      print_d(fd, va_arg(ap, int));
    1a5c:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1a62:	83 f8 2f             	cmp    $0x2f,%eax
    1a65:	77 23                	ja     1a8a <printf+0x209>
    1a67:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1a6e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a74:	89 d2                	mov    %edx,%edx
    1a76:	48 01 d0             	add    %rdx,%rax
    1a79:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a7f:	83 c2 08             	add    $0x8,%edx
    1a82:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1a88:	eb 12                	jmp    1a9c <printf+0x21b>
    1a8a:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a91:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a95:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a9c:	8b 10                	mov    (%rax),%edx
    1a9e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1aa4:	89 d6                	mov    %edx,%esi
    1aa6:	89 c7                	mov    %eax,%edi
    1aa8:	48 b8 8d 17 00 00 00 	movabs $0x178d,%rax
    1aaf:	00 00 00 
    1ab2:	ff d0                	call   *%rax
      break;
    1ab4:	e9 b5 01 00 00       	jmp    1c6e <printf+0x3ed>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    1ab9:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1abf:	83 f8 2f             	cmp    $0x2f,%eax
    1ac2:	77 23                	ja     1ae7 <printf+0x266>
    1ac4:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1acb:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1ad1:	89 d2                	mov    %edx,%edx
    1ad3:	48 01 d0             	add    %rdx,%rax
    1ad6:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1adc:	83 c2 08             	add    $0x8,%edx
    1adf:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1ae5:	eb 12                	jmp    1af9 <printf+0x278>
    1ae7:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1aee:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1af2:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1af9:	8b 10                	mov    (%rax),%edx
    1afb:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b01:	89 d6                	mov    %edx,%esi
    1b03:	89 c7                	mov    %eax,%edi
    1b05:	48 b8 34 17 00 00 00 	movabs $0x1734,%rax
    1b0c:	00 00 00 
    1b0f:	ff d0                	call   *%rax
      break;
    1b11:	e9 58 01 00 00       	jmp    1c6e <printf+0x3ed>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    1b16:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1b1c:	83 f8 2f             	cmp    $0x2f,%eax
    1b1f:	77 23                	ja     1b44 <printf+0x2c3>
    1b21:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1b28:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b2e:	89 d2                	mov    %edx,%edx
    1b30:	48 01 d0             	add    %rdx,%rax
    1b33:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b39:	83 c2 08             	add    $0x8,%edx
    1b3c:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1b42:	eb 12                	jmp    1b56 <printf+0x2d5>
    1b44:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1b4b:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1b4f:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1b56:	48 8b 10             	mov    (%rax),%rdx
    1b59:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b5f:	48 89 d6             	mov    %rdx,%rsi
    1b62:	89 c7                	mov    %eax,%edi
    1b64:	48 b8 db 16 00 00 00 	movabs $0x16db,%rax
    1b6b:	00 00 00 
    1b6e:	ff d0                	call   *%rax
      break;
    1b70:	e9 f9 00 00 00       	jmp    1c6e <printf+0x3ed>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    1b75:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1b7b:	83 f8 2f             	cmp    $0x2f,%eax
    1b7e:	77 23                	ja     1ba3 <printf+0x322>
    1b80:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1b87:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b8d:	89 d2                	mov    %edx,%edx
    1b8f:	48 01 d0             	add    %rdx,%rax
    1b92:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b98:	83 c2 08             	add    $0x8,%edx
    1b9b:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1ba1:	eb 12                	jmp    1bb5 <printf+0x334>
    1ba3:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1baa:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1bae:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1bb5:	48 8b 00             	mov    (%rax),%rax
    1bb8:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    1bbf:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1bc6:	00 
    1bc7:	75 41                	jne    1c0a <printf+0x389>
        s = "(null)";
    1bc9:	48 b8 db 1f 00 00 00 	movabs $0x1fdb,%rax
    1bd0:	00 00 00 
    1bd3:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1bda:	eb 2e                	jmp    1c0a <printf+0x389>
        putc(fd, *(s++));
    1bdc:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1be3:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1be7:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1bee:	0f b6 00             	movzbl (%rax),%eax
    1bf1:	0f be d0             	movsbl %al,%edx
    1bf4:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1bfa:	89 d6                	mov    %edx,%esi
    1bfc:	89 c7                	mov    %eax,%edi
    1bfe:	48 b8 ab 16 00 00 00 	movabs $0x16ab,%rax
    1c05:	00 00 00 
    1c08:	ff d0                	call   *%rax
      while (*s)
    1c0a:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1c11:	0f b6 00             	movzbl (%rax),%eax
    1c14:	84 c0                	test   %al,%al
    1c16:	75 c4                	jne    1bdc <printf+0x35b>
      break;
    1c18:	eb 54                	jmp    1c6e <printf+0x3ed>
    case '%':
      putc(fd, '%');
    1c1a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1c20:	be 25 00 00 00       	mov    $0x25,%esi
    1c25:	89 c7                	mov    %eax,%edi
    1c27:	48 b8 ab 16 00 00 00 	movabs $0x16ab,%rax
    1c2e:	00 00 00 
    1c31:	ff d0                	call   *%rax
      break;
    1c33:	eb 39                	jmp    1c6e <printf+0x3ed>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1c35:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1c3b:	be 25 00 00 00       	mov    $0x25,%esi
    1c40:	89 c7                	mov    %eax,%edi
    1c42:	48 b8 ab 16 00 00 00 	movabs $0x16ab,%rax
    1c49:	00 00 00 
    1c4c:	ff d0                	call   *%rax
      putc(fd, c);
    1c4e:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1c54:	0f be d0             	movsbl %al,%edx
    1c57:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1c5d:	89 d6                	mov    %edx,%esi
    1c5f:	89 c7                	mov    %eax,%edi
    1c61:	48 b8 ab 16 00 00 00 	movabs $0x16ab,%rax
    1c68:	00 00 00 
    1c6b:	ff d0                	call   *%rax
      break;
    1c6d:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1c6e:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1c75:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1c7b:	48 63 d0             	movslq %eax,%rdx
    1c7e:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1c85:	48 01 d0             	add    %rdx,%rax
    1c88:	0f b6 00             	movzbl (%rax),%eax
    1c8b:	0f be c0             	movsbl %al,%eax
    1c8e:	25 ff 00 00 00       	and    $0xff,%eax
    1c93:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1c99:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1ca0:	0f 85 6f fc ff ff    	jne    1915 <printf+0x94>
    }
  }
}
    1ca6:	eb 01                	jmp    1ca9 <printf+0x428>
      break;
    1ca8:	90                   	nop
}
    1ca9:	90                   	nop
    1caa:	c9                   	leave
    1cab:	c3                   	ret

0000000000001cac <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1cac:	55                   	push   %rbp
    1cad:	48 89 e5             	mov    %rsp,%rbp
    1cb0:	48 83 ec 18          	sub    $0x18,%rsp
    1cb4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1cb8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1cbc:	48 83 e8 10          	sub    $0x10,%rax
    1cc0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1cc4:	48 b8 30 22 00 00 00 	movabs $0x2230,%rax
    1ccb:	00 00 00 
    1cce:	48 8b 00             	mov    (%rax),%rax
    1cd1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1cd5:	eb 2f                	jmp    1d06 <free+0x5a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1cd7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cdb:	48 8b 00             	mov    (%rax),%rax
    1cde:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1ce2:	72 17                	jb     1cfb <free+0x4f>
    1ce4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ce8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1cec:	72 2f                	jb     1d1d <free+0x71>
    1cee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cf2:	48 8b 00             	mov    (%rax),%rax
    1cf5:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1cf9:	72 22                	jb     1d1d <free+0x71>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1cfb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cff:	48 8b 00             	mov    (%rax),%rax
    1d02:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1d06:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d0a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1d0e:	73 c7                	jae    1cd7 <free+0x2b>
    1d10:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d14:	48 8b 00             	mov    (%rax),%rax
    1d17:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1d1b:	73 ba                	jae    1cd7 <free+0x2b>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1d1d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d21:	8b 40 08             	mov    0x8(%rax),%eax
    1d24:	89 c0                	mov    %eax,%eax
    1d26:	48 c1 e0 04          	shl    $0x4,%rax
    1d2a:	48 89 c2             	mov    %rax,%rdx
    1d2d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d31:	48 01 c2             	add    %rax,%rdx
    1d34:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d38:	48 8b 00             	mov    (%rax),%rax
    1d3b:	48 39 c2             	cmp    %rax,%rdx
    1d3e:	75 2d                	jne    1d6d <free+0xc1>
    bp->s.size += p->s.ptr->s.size;
    1d40:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d44:	8b 50 08             	mov    0x8(%rax),%edx
    1d47:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d4b:	48 8b 00             	mov    (%rax),%rax
    1d4e:	8b 40 08             	mov    0x8(%rax),%eax
    1d51:	01 c2                	add    %eax,%edx
    1d53:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d57:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1d5a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d5e:	48 8b 00             	mov    (%rax),%rax
    1d61:	48 8b 10             	mov    (%rax),%rdx
    1d64:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d68:	48 89 10             	mov    %rdx,(%rax)
    1d6b:	eb 0e                	jmp    1d7b <free+0xcf>
  } else
    bp->s.ptr = p->s.ptr;
    1d6d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d71:	48 8b 10             	mov    (%rax),%rdx
    1d74:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d78:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    1d7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d7f:	8b 40 08             	mov    0x8(%rax),%eax
    1d82:	89 c0                	mov    %eax,%eax
    1d84:	48 c1 e0 04          	shl    $0x4,%rax
    1d88:	48 89 c2             	mov    %rax,%rdx
    1d8b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d8f:	48 01 d0             	add    %rdx,%rax
    1d92:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1d96:	75 27                	jne    1dbf <free+0x113>
    p->s.size += bp->s.size;
    1d98:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d9c:	8b 50 08             	mov    0x8(%rax),%edx
    1d9f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1da3:	8b 40 08             	mov    0x8(%rax),%eax
    1da6:	01 c2                	add    %eax,%edx
    1da8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1dac:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    1daf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1db3:	48 8b 10             	mov    (%rax),%rdx
    1db6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1dba:	48 89 10             	mov    %rdx,(%rax)
    1dbd:	eb 0b                	jmp    1dca <free+0x11e>
  } else
    p->s.ptr = bp;
    1dbf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1dc3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1dc7:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    1dca:	48 ba 30 22 00 00 00 	movabs $0x2230,%rdx
    1dd1:	00 00 00 
    1dd4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1dd8:	48 89 02             	mov    %rax,(%rdx)
}
    1ddb:	90                   	nop
    1ddc:	c9                   	leave
    1ddd:	c3                   	ret

0000000000001dde <morecore>:

static Header*
morecore(uint nu)
{
    1dde:	55                   	push   %rbp
    1ddf:	48 89 e5             	mov    %rsp,%rbp
    1de2:	48 83 ec 20          	sub    $0x20,%rsp
    1de6:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    1de9:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1df0:	77 07                	ja     1df9 <morecore+0x1b>
    nu = 4096;
    1df2:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    1df9:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1dfc:	48 c1 e0 04          	shl    $0x4,%rax
    1e00:	48 89 c7             	mov    %rax,%rdi
    1e03:	48 b8 6a 16 00 00 00 	movabs $0x166a,%rax
    1e0a:	00 00 00 
    1e0d:	ff d0                	call   *%rax
    1e0f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    1e13:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1e18:	75 07                	jne    1e21 <morecore+0x43>
    return 0;
    1e1a:	b8 00 00 00 00       	mov    $0x0,%eax
    1e1f:	eb 36                	jmp    1e57 <morecore+0x79>
  hp = (Header*)p;
    1e21:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e25:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    1e29:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e2d:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1e30:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    1e33:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e37:	48 83 c0 10          	add    $0x10,%rax
    1e3b:	48 89 c7             	mov    %rax,%rdi
    1e3e:	48 b8 ac 1c 00 00 00 	movabs $0x1cac,%rax
    1e45:	00 00 00 
    1e48:	ff d0                	call   *%rax
  return freep;
    1e4a:	48 b8 30 22 00 00 00 	movabs $0x2230,%rax
    1e51:	00 00 00 
    1e54:	48 8b 00             	mov    (%rax),%rax
}
    1e57:	c9                   	leave
    1e58:	c3                   	ret

0000000000001e59 <malloc>:

void*
malloc(uint nbytes)
{
    1e59:	55                   	push   %rbp
    1e5a:	48 89 e5             	mov    %rsp,%rbp
    1e5d:	48 83 ec 30          	sub    $0x30,%rsp
    1e61:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1e64:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1e67:	48 83 c0 0f          	add    $0xf,%rax
    1e6b:	48 c1 e8 04          	shr    $0x4,%rax
    1e6f:	83 c0 01             	add    $0x1,%eax
    1e72:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    1e75:	48 b8 30 22 00 00 00 	movabs $0x2230,%rax
    1e7c:	00 00 00 
    1e7f:	48 8b 00             	mov    (%rax),%rax
    1e82:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1e86:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1e8b:	75 4a                	jne    1ed7 <malloc+0x7e>
    base.s.ptr = freep = prevp = &base;
    1e8d:	48 b8 20 22 00 00 00 	movabs $0x2220,%rax
    1e94:	00 00 00 
    1e97:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1e9b:	48 ba 30 22 00 00 00 	movabs $0x2230,%rdx
    1ea2:	00 00 00 
    1ea5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ea9:	48 89 02             	mov    %rax,(%rdx)
    1eac:	48 b8 30 22 00 00 00 	movabs $0x2230,%rax
    1eb3:	00 00 00 
    1eb6:	48 8b 00             	mov    (%rax),%rax
    1eb9:	48 ba 20 22 00 00 00 	movabs $0x2220,%rdx
    1ec0:	00 00 00 
    1ec3:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    1ec6:	48 b8 20 22 00 00 00 	movabs $0x2220,%rax
    1ecd:	00 00 00 
    1ed0:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1ed7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1edb:	48 8b 00             	mov    (%rax),%rax
    1ede:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1ee2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ee6:	8b 40 08             	mov    0x8(%rax),%eax
    1ee9:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1eec:	72 65                	jb     1f53 <malloc+0xfa>
      if(p->s.size == nunits)
    1eee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ef2:	8b 40 08             	mov    0x8(%rax),%eax
    1ef5:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1ef8:	75 10                	jne    1f0a <malloc+0xb1>
        prevp->s.ptr = p->s.ptr;
    1efa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1efe:	48 8b 10             	mov    (%rax),%rdx
    1f01:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f05:	48 89 10             	mov    %rdx,(%rax)
    1f08:	eb 2e                	jmp    1f38 <malloc+0xdf>
      else {
        p->s.size -= nunits;
    1f0a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f0e:	8b 40 08             	mov    0x8(%rax),%eax
    1f11:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1f14:	89 c2                	mov    %eax,%edx
    1f16:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f1a:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    1f1d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f21:	8b 40 08             	mov    0x8(%rax),%eax
    1f24:	89 c0                	mov    %eax,%eax
    1f26:	48 c1 e0 04          	shl    $0x4,%rax
    1f2a:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    1f2e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f32:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1f35:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    1f38:	48 ba 30 22 00 00 00 	movabs $0x2230,%rdx
    1f3f:	00 00 00 
    1f42:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f46:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    1f49:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f4d:	48 83 c0 10          	add    $0x10,%rax
    1f51:	eb 4e                	jmp    1fa1 <malloc+0x148>
    }
    if(p == freep)
    1f53:	48 b8 30 22 00 00 00 	movabs $0x2230,%rax
    1f5a:	00 00 00 
    1f5d:	48 8b 00             	mov    (%rax),%rax
    1f60:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1f64:	75 23                	jne    1f89 <malloc+0x130>
      if((p = morecore(nunits)) == 0)
    1f66:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1f69:	89 c7                	mov    %eax,%edi
    1f6b:	48 b8 de 1d 00 00 00 	movabs $0x1dde,%rax
    1f72:	00 00 00 
    1f75:	ff d0                	call   *%rax
    1f77:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1f7b:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1f80:	75 07                	jne    1f89 <malloc+0x130>
        return 0;
    1f82:	b8 00 00 00 00       	mov    $0x0,%eax
    1f87:	eb 18                	jmp    1fa1 <malloc+0x148>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1f89:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f8d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1f91:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f95:	48 8b 00             	mov    (%rax),%rax
    1f98:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1f9c:	e9 41 ff ff ff       	jmp    1ee2 <malloc+0x89>
  }
}
    1fa1:	c9                   	leave
    1fa2:	c3                   	ret
