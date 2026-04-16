
_fsserver:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <copy_path>:
static struct fd_entry fd_table[MAX_REMOTE_FDS];
static struct mem_file files[MAX_MEM_FILES];

static void
copy_path(char *dst, char *src, int n)
{
    1000:	f3 0f 1e fa          	endbr64
    1004:	55                   	push   %rbp
    1005:	48 89 e5             	mov    %rsp,%rbp
    1008:	48 83 ec 28          	sub    $0x28,%rsp
    100c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1010:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    1014:	89 55 dc             	mov    %edx,-0x24(%rbp)
  int i;
  for(i = 0; i < n - 1 && src[i]; i++)
    1017:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    101e:	eb 23                	jmp    1043 <copy_path+0x43>
    dst[i] = src[i];
    1020:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1023:	48 63 d0             	movslq %eax,%rdx
    1026:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    102a:	48 01 d0             	add    %rdx,%rax
    102d:	8b 55 fc             	mov    -0x4(%rbp),%edx
    1030:	48 63 ca             	movslq %edx,%rcx
    1033:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
    1037:	48 01 ca             	add    %rcx,%rdx
    103a:	0f b6 00             	movzbl (%rax),%eax
    103d:	88 02                	mov    %al,(%rdx)
  for(i = 0; i < n - 1 && src[i]; i++)
    103f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1043:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1046:	83 e8 01             	sub    $0x1,%eax
    1049:	39 45 fc             	cmp    %eax,-0x4(%rbp)
    104c:	7d 14                	jge    1062 <copy_path+0x62>
    104e:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1051:	48 63 d0             	movslq %eax,%rdx
    1054:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1058:	48 01 d0             	add    %rdx,%rax
    105b:	0f b6 00             	movzbl (%rax),%eax
    105e:	84 c0                	test   %al,%al
    1060:	75 be                	jne    1020 <copy_path+0x20>
  dst[i] = 0;
    1062:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1065:	48 63 d0             	movslq %eax,%rdx
    1068:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    106c:	48 01 d0             	add    %rdx,%rax
    106f:	c6 00 00             	movb   $0x0,(%rax)
}
    1072:	90                   	nop
    1073:	c9                   	leave
    1074:	c3                   	ret

0000000000001075 <path_equal>:

static int
path_equal(char *a, char *b)
{
    1075:	f3 0f 1e fa          	endbr64
    1079:	55                   	push   %rbp
    107a:	48 89 e5             	mov    %rsp,%rbp
    107d:	48 83 ec 10          	sub    $0x10,%rsp
    1081:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1085:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  return strcmp(a, b) == 0;
    1089:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    108d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1091:	48 89 d6             	mov    %rdx,%rsi
    1094:	48 89 c7             	mov    %rax,%rdi
    1097:	48 b8 95 1d 00 00 00 	movabs $0x1d95,%rax
    109e:	00 00 00 
    10a1:	ff d0                	call   *%rax
    10a3:	85 c0                	test   %eax,%eax
    10a5:	0f 94 c0             	sete   %al
    10a8:	0f b6 c0             	movzbl %al,%eax
}
    10ab:	c9                   	leave
    10ac:	c3                   	ret

00000000000010ad <find_file>:

static int
find_file(char *path)
{
    10ad:	f3 0f 1e fa          	endbr64
    10b1:	55                   	push   %rbp
    10b2:	48 89 e5             	mov    %rsp,%rbp
    10b5:	48 83 ec 20          	sub    $0x20,%rsp
    10b9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int i;
  for(i = 0; i < MAX_MEM_FILES; i++){
    10bd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    10c4:	eb 5f                	jmp    1125 <find_file+0x78>
    if(files[i].used && path_equal(files[i].path, path))
    10c6:	48 ba 00 32 00 00 00 	movabs $0x3200,%rdx
    10cd:	00 00 00 
    10d0:	8b 45 fc             	mov    -0x4(%rbp),%eax
    10d3:	48 98                	cltq
    10d5:	48 69 c0 48 10 00 00 	imul   $0x1048,%rax,%rax
    10dc:	48 01 d0             	add    %rdx,%rax
    10df:	8b 00                	mov    (%rax),%eax
    10e1:	85 c0                	test   %eax,%eax
    10e3:	74 3c                	je     1121 <find_file+0x74>
    10e5:	8b 45 fc             	mov    -0x4(%rbp),%eax
    10e8:	48 98                	cltq
    10ea:	48 69 c0 48 10 00 00 	imul   $0x1048,%rax,%rax
    10f1:	48 ba 00 32 00 00 00 	movabs $0x3200,%rdx
    10f8:	00 00 00 
    10fb:	48 01 d0             	add    %rdx,%rax
    10fe:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1102:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1106:	48 89 c6             	mov    %rax,%rsi
    1109:	48 89 d7             	mov    %rdx,%rdi
    110c:	48 b8 75 10 00 00 00 	movabs $0x1075,%rax
    1113:	00 00 00 
    1116:	ff d0                	call   *%rax
    1118:	85 c0                	test   %eax,%eax
    111a:	74 05                	je     1121 <find_file+0x74>
      return i;
    111c:	8b 45 fc             	mov    -0x4(%rbp),%eax
    111f:	eb 0f                	jmp    1130 <find_file+0x83>
  for(i = 0; i < MAX_MEM_FILES; i++){
    1121:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1125:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
    1129:	7e 9b                	jle    10c6 <find_file+0x19>
  }
  return -1;
    112b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1130:	c9                   	leave
    1131:	c3                   	ret

0000000000001132 <create_file>:

static int
create_file(char *path)
{
    1132:	f3 0f 1e fa          	endbr64
    1136:	55                   	push   %rbp
    1137:	48 89 e5             	mov    %rsp,%rbp
    113a:	48 83 ec 20          	sub    $0x20,%rsp
    113e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int i;
  for(i = 0; i < MAX_MEM_FILES; i++){
    1142:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1149:	e9 e0 00 00 00       	jmp    122e <create_file+0xfc>
    if(!files[i].used){
    114e:	48 ba 00 32 00 00 00 	movabs $0x3200,%rdx
    1155:	00 00 00 
    1158:	8b 45 fc             	mov    -0x4(%rbp),%eax
    115b:	48 98                	cltq
    115d:	48 69 c0 48 10 00 00 	imul   $0x1048,%rax,%rax
    1164:	48 01 d0             	add    %rdx,%rax
    1167:	8b 00                	mov    (%rax),%eax
    1169:	85 c0                	test   %eax,%eax
    116b:	0f 85 b9 00 00 00    	jne    122a <create_file+0xf8>
      files[i].used = 1;
    1171:	48 ba 00 32 00 00 00 	movabs $0x3200,%rdx
    1178:	00 00 00 
    117b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    117e:	48 98                	cltq
    1180:	48 69 c0 48 10 00 00 	imul   $0x1048,%rax,%rax
    1187:	48 01 d0             	add    %rdx,%rax
    118a:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
      files[i].size = 0;
    1190:	48 ba 00 32 00 00 00 	movabs $0x3200,%rdx
    1197:	00 00 00 
    119a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    119d:	48 98                	cltq
    119f:	48 69 c0 48 10 00 00 	imul   $0x1048,%rax,%rax
    11a6:	48 01 d0             	add    %rdx,%rax
    11a9:	48 83 c0 04          	add    $0x4,%rax
    11ad:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
      memset(files[i].data, 0, sizeof(files[i].data));
    11b3:	8b 45 fc             	mov    -0x4(%rbp),%eax
    11b6:	48 98                	cltq
    11b8:	48 69 c0 48 10 00 00 	imul   $0x1048,%rax,%rax
    11bf:	48 8d 50 40          	lea    0x40(%rax),%rdx
    11c3:	48 b8 00 32 00 00 00 	movabs $0x3200,%rax
    11ca:	00 00 00 
    11cd:	48 01 d0             	add    %rdx,%rax
    11d0:	48 83 c0 08          	add    $0x8,%rax
    11d4:	ba 00 10 00 00       	mov    $0x1000,%edx
    11d9:	be 00 00 00 00       	mov    $0x0,%esi
    11de:	48 89 c7             	mov    %rax,%rdi
    11e1:	48 b8 22 1e 00 00 00 	movabs $0x1e22,%rax
    11e8:	00 00 00 
    11eb:	ff d0                	call   *%rax
      copy_path(files[i].path, path, sizeof(files[i].path));
    11ed:	8b 45 fc             	mov    -0x4(%rbp),%eax
    11f0:	48 98                	cltq
    11f2:	48 69 c0 48 10 00 00 	imul   $0x1048,%rax,%rax
    11f9:	48 ba 00 32 00 00 00 	movabs $0x3200,%rdx
    1200:	00 00 00 
    1203:	48 01 d0             	add    %rdx,%rax
    1206:	48 8d 48 08          	lea    0x8(%rax),%rcx
    120a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    120e:	ba 40 00 00 00       	mov    $0x40,%edx
    1213:	48 89 c6             	mov    %rax,%rsi
    1216:	48 89 cf             	mov    %rcx,%rdi
    1219:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1220:	00 00 00 
    1223:	ff d0                	call   *%rax
      return i;
    1225:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1228:	eb 13                	jmp    123d <create_file+0x10b>
  for(i = 0; i < MAX_MEM_FILES; i++){
    122a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    122e:	83 7d fc 1f          	cmpl   $0x1f,-0x4(%rbp)
    1232:	0f 8e 16 ff ff ff    	jle    114e <create_file+0x1c>
    }
  }
  return -1;
    1238:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    123d:	c9                   	leave
    123e:	c3                   	ret

000000000000123f <alloc_remote_fd>:

static int
alloc_remote_fd(int owner_pid, int file_index, int flags)
{
    123f:	f3 0f 1e fa          	endbr64
    1243:	55                   	push   %rbp
    1244:	48 89 e5             	mov    %rsp,%rbp
    1247:	48 83 ec 20          	sub    $0x20,%rsp
    124b:	89 7d ec             	mov    %edi,-0x14(%rbp)
    124e:	89 75 e8             	mov    %esi,-0x18(%rbp)
    1251:	89 55 e4             	mov    %edx,-0x1c(%rbp)
  // final server-side open-file table. Track owner pid, file offset, access
  // mode, inode/file identity, reference count if dup/fork is supported, and
  // cleanup state. Why: once fsserver stops using real_fd from kernel open(),
  // this table becomes the server's source of truth for open files.
  int i;
  for(i = 0; i < MAX_REMOTE_FDS; i++){
    1254:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    125b:	e9 4f 01 00 00       	jmp    13af <alloc_remote_fd+0x170>
    if(!fd_table[i].used){
    1260:	48 b9 00 2c 00 00 00 	movabs $0x2c00,%rcx
    1267:	00 00 00 
    126a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    126d:	48 63 d0             	movslq %eax,%rdx
    1270:	48 89 d0             	mov    %rdx,%rax
    1273:	48 01 c0             	add    %rax,%rax
    1276:	48 01 d0             	add    %rdx,%rax
    1279:	48 c1 e0 03          	shl    $0x3,%rax
    127d:	48 01 c8             	add    %rcx,%rax
    1280:	8b 00                	mov    (%rax),%eax
    1282:	85 c0                	test   %eax,%eax
    1284:	0f 85 21 01 00 00    	jne    13ab <alloc_remote_fd+0x16c>
      fd_table[i].used = 1;
    128a:	48 b9 00 2c 00 00 00 	movabs $0x2c00,%rcx
    1291:	00 00 00 
    1294:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1297:	48 63 d0             	movslq %eax,%rdx
    129a:	48 89 d0             	mov    %rdx,%rax
    129d:	48 01 c0             	add    %rax,%rax
    12a0:	48 01 d0             	add    %rdx,%rax
    12a3:	48 c1 e0 03          	shl    $0x3,%rax
    12a7:	48 01 c8             	add    %rcx,%rax
    12aa:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
      fd_table[i].owner_pid = owner_pid;
    12b0:	48 b9 00 2c 00 00 00 	movabs $0x2c00,%rcx
    12b7:	00 00 00 
    12ba:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12bd:	48 63 d0             	movslq %eax,%rdx
    12c0:	48 89 d0             	mov    %rdx,%rax
    12c3:	48 01 c0             	add    %rax,%rax
    12c6:	48 01 d0             	add    %rdx,%rax
    12c9:	48 c1 e0 03          	shl    $0x3,%rax
    12cd:	48 01 c8             	add    %rcx,%rax
    12d0:	48 8d 50 04          	lea    0x4(%rax),%rdx
    12d4:	8b 45 ec             	mov    -0x14(%rbp),%eax
    12d7:	89 02                	mov    %eax,(%rdx)
      fd_table[i].file_index = file_index;
    12d9:	48 b9 00 2c 00 00 00 	movabs $0x2c00,%rcx
    12e0:	00 00 00 
    12e3:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12e6:	48 63 d0             	movslq %eax,%rdx
    12e9:	48 89 d0             	mov    %rdx,%rax
    12ec:	48 01 c0             	add    %rax,%rax
    12ef:	48 01 d0             	add    %rdx,%rax
    12f2:	48 c1 e0 03          	shl    $0x3,%rax
    12f6:	48 01 c8             	add    %rcx,%rax
    12f9:	48 8d 50 08          	lea    0x8(%rax),%rdx
    12fd:	8b 45 e8             	mov    -0x18(%rbp),%eax
    1300:	89 02                	mov    %eax,(%rdx)
      fd_table[i].off = 0;
    1302:	48 b9 00 2c 00 00 00 	movabs $0x2c00,%rcx
    1309:	00 00 00 
    130c:	8b 45 fc             	mov    -0x4(%rbp),%eax
    130f:	48 63 d0             	movslq %eax,%rdx
    1312:	48 89 d0             	mov    %rdx,%rax
    1315:	48 01 c0             	add    %rax,%rax
    1318:	48 01 d0             	add    %rdx,%rax
    131b:	48 c1 e0 03          	shl    $0x3,%rax
    131f:	48 01 c8             	add    %rcx,%rax
    1322:	48 83 c0 0c          	add    $0xc,%rax
    1326:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
      fd_table[i].readable = !(flags & O_WRONLY);
    132c:	8b 45 e4             	mov    -0x1c(%rbp),%eax
    132f:	83 e0 01             	and    $0x1,%eax
    1332:	85 c0                	test   %eax,%eax
    1334:	0f 94 c0             	sete   %al
    1337:	0f b6 c8             	movzbl %al,%ecx
    133a:	48 be 00 2c 00 00 00 	movabs $0x2c00,%rsi
    1341:	00 00 00 
    1344:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1347:	48 63 d0             	movslq %eax,%rdx
    134a:	48 89 d0             	mov    %rdx,%rax
    134d:	48 01 c0             	add    %rax,%rax
    1350:	48 01 d0             	add    %rdx,%rax
    1353:	48 c1 e0 03          	shl    $0x3,%rax
    1357:	48 01 f0             	add    %rsi,%rax
    135a:	48 83 c0 10          	add    $0x10,%rax
    135e:	89 08                	mov    %ecx,(%rax)
      fd_table[i].writable = (flags & O_WRONLY) || (flags & O_RDWR);
    1360:	8b 45 e4             	mov    -0x1c(%rbp),%eax
    1363:	83 e0 01             	and    $0x1,%eax
    1366:	85 c0                	test   %eax,%eax
    1368:	75 0a                	jne    1374 <alloc_remote_fd+0x135>
    136a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
    136d:	83 e0 02             	and    $0x2,%eax
    1370:	85 c0                	test   %eax,%eax
    1372:	74 07                	je     137b <alloc_remote_fd+0x13c>
    1374:	be 01 00 00 00       	mov    $0x1,%esi
    1379:	eb 05                	jmp    1380 <alloc_remote_fd+0x141>
    137b:	be 00 00 00 00       	mov    $0x0,%esi
    1380:	48 b9 00 2c 00 00 00 	movabs $0x2c00,%rcx
    1387:	00 00 00 
    138a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    138d:	48 63 d0             	movslq %eax,%rdx
    1390:	48 89 d0             	mov    %rdx,%rax
    1393:	48 01 c0             	add    %rax,%rax
    1396:	48 01 d0             	add    %rdx,%rax
    1399:	48 c1 e0 03          	shl    $0x3,%rax
    139d:	48 01 c8             	add    %rcx,%rax
    13a0:	48 83 c0 14          	add    $0x14,%rax
    13a4:	89 30                	mov    %esi,(%rax)
      return i;
    13a6:	8b 45 fc             	mov    -0x4(%rbp),%eax
    13a9:	eb 13                	jmp    13be <alloc_remote_fd+0x17f>
  for(i = 0; i < MAX_REMOTE_FDS; i++){
    13ab:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    13af:	83 7d fc 3f          	cmpl   $0x3f,-0x4(%rbp)
    13b3:	0f 8e a7 fe ff ff    	jle    1260 <alloc_remote_fd+0x21>
    }
  }
  return -1;
    13b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    13be:	c9                   	leave
    13bf:	c3                   	ret

00000000000013c0 <lookup_remote_fd>:

static struct fd_entry*
lookup_remote_fd(int owner_pid, int remote_fd)
{
    13c0:	f3 0f 1e fa          	endbr64
    13c4:	55                   	push   %rbp
    13c5:	48 89 e5             	mov    %rsp,%rbp
    13c8:	48 83 ec 08          	sub    $0x8,%rsp
    13cc:	89 7d fc             	mov    %edi,-0x4(%rbp)
    13cf:	89 75 f8             	mov    %esi,-0x8(%rbp)
  if(remote_fd < 0 || remote_fd >= MAX_REMOTE_FDS)
    13d2:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    13d6:	78 06                	js     13de <lookup_remote_fd+0x1e>
    13d8:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
    13dc:	7e 07                	jle    13e5 <lookup_remote_fd+0x25>
    return 0;
    13de:	b8 00 00 00 00       	mov    $0x0,%eax
    13e3:	eb 7f                	jmp    1464 <lookup_remote_fd+0xa4>
  if(!fd_table[remote_fd].used)
    13e5:	48 b9 00 2c 00 00 00 	movabs $0x2c00,%rcx
    13ec:	00 00 00 
    13ef:	8b 45 f8             	mov    -0x8(%rbp),%eax
    13f2:	48 63 d0             	movslq %eax,%rdx
    13f5:	48 89 d0             	mov    %rdx,%rax
    13f8:	48 01 c0             	add    %rax,%rax
    13fb:	48 01 d0             	add    %rdx,%rax
    13fe:	48 c1 e0 03          	shl    $0x3,%rax
    1402:	48 01 c8             	add    %rcx,%rax
    1405:	8b 00                	mov    (%rax),%eax
    1407:	85 c0                	test   %eax,%eax
    1409:	75 07                	jne    1412 <lookup_remote_fd+0x52>
    return 0;
    140b:	b8 00 00 00 00       	mov    $0x0,%eax
    1410:	eb 52                	jmp    1464 <lookup_remote_fd+0xa4>
  if(fd_table[remote_fd].owner_pid != owner_pid)
    1412:	48 b9 00 2c 00 00 00 	movabs $0x2c00,%rcx
    1419:	00 00 00 
    141c:	8b 45 f8             	mov    -0x8(%rbp),%eax
    141f:	48 63 d0             	movslq %eax,%rdx
    1422:	48 89 d0             	mov    %rdx,%rax
    1425:	48 01 c0             	add    %rax,%rax
    1428:	48 01 d0             	add    %rdx,%rax
    142b:	48 c1 e0 03          	shl    $0x3,%rax
    142f:	48 01 c8             	add    %rcx,%rax
    1432:	48 83 c0 04          	add    $0x4,%rax
    1436:	8b 00                	mov    (%rax),%eax
    1438:	39 45 fc             	cmp    %eax,-0x4(%rbp)
    143b:	74 07                	je     1444 <lookup_remote_fd+0x84>
    return 0;
    143d:	b8 00 00 00 00       	mov    $0x0,%eax
    1442:	eb 20                	jmp    1464 <lookup_remote_fd+0xa4>
  return &fd_table[remote_fd];
    1444:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1447:	48 63 d0             	movslq %eax,%rdx
    144a:	48 89 d0             	mov    %rdx,%rax
    144d:	48 01 c0             	add    %rax,%rax
    1450:	48 01 d0             	add    %rdx,%rax
    1453:	48 c1 e0 03          	shl    $0x3,%rax
    1457:	48 ba 00 2c 00 00 00 	movabs $0x2c00,%rdx
    145e:	00 00 00 
    1461:	48 01 d0             	add    %rdx,%rax
}
    1464:	c9                   	leave
    1465:	c3                   	ret

0000000000001466 <close_all_for_owner>:

static void
close_all_for_owner(int owner_pid)
{
    1466:	f3 0f 1e fa          	endbr64
    146a:	55                   	push   %rbp
    146b:	48 89 e5             	mov    %rsp,%rbp
    146e:	48 83 ec 18          	sub    $0x18,%rsp
    1472:	89 7d ec             	mov    %edi,-0x14(%rbp)
  // DONE(28-client-death-cleanup): What: make cleanup automatic when a client
  // process exits or is killed. Use kernel notification, a reclaim message, or
  // another explicit protocol instead of only manual shutdown. Why: the server
  // must not leak open remote descriptors when clients die unexpectedly.
  int i;
  for(i = 0; i < MAX_REMOTE_FDS; i++){
    1475:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    147c:	eb 7b                	jmp    14f9 <close_all_for_owner+0x93>
    if(fd_table[i].used && fd_table[i].owner_pid == owner_pid){
    147e:	48 b9 00 2c 00 00 00 	movabs $0x2c00,%rcx
    1485:	00 00 00 
    1488:	8b 45 fc             	mov    -0x4(%rbp),%eax
    148b:	48 63 d0             	movslq %eax,%rdx
    148e:	48 89 d0             	mov    %rdx,%rax
    1491:	48 01 c0             	add    %rax,%rax
    1494:	48 01 d0             	add    %rdx,%rax
    1497:	48 c1 e0 03          	shl    $0x3,%rax
    149b:	48 01 c8             	add    %rcx,%rax
    149e:	8b 00                	mov    (%rax),%eax
    14a0:	85 c0                	test   %eax,%eax
    14a2:	74 51                	je     14f5 <close_all_for_owner+0x8f>
    14a4:	48 b9 00 2c 00 00 00 	movabs $0x2c00,%rcx
    14ab:	00 00 00 
    14ae:	8b 45 fc             	mov    -0x4(%rbp),%eax
    14b1:	48 63 d0             	movslq %eax,%rdx
    14b4:	48 89 d0             	mov    %rdx,%rax
    14b7:	48 01 c0             	add    %rax,%rax
    14ba:	48 01 d0             	add    %rdx,%rax
    14bd:	48 c1 e0 03          	shl    $0x3,%rax
    14c1:	48 01 c8             	add    %rcx,%rax
    14c4:	48 83 c0 04          	add    $0x4,%rax
    14c8:	8b 00                	mov    (%rax),%eax
    14ca:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    14cd:	75 26                	jne    14f5 <close_all_for_owner+0x8f>
      fd_table[i].used = 0;
    14cf:	48 b9 00 2c 00 00 00 	movabs $0x2c00,%rcx
    14d6:	00 00 00 
    14d9:	8b 45 fc             	mov    -0x4(%rbp),%eax
    14dc:	48 63 d0             	movslq %eax,%rdx
    14df:	48 89 d0             	mov    %rdx,%rax
    14e2:	48 01 c0             	add    %rax,%rax
    14e5:	48 01 d0             	add    %rdx,%rax
    14e8:	48 c1 e0 03          	shl    $0x3,%rax
    14ec:	48 01 c8             	add    %rcx,%rax
    14ef:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  for(i = 0; i < MAX_REMOTE_FDS; i++){
    14f5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    14f9:	83 7d fc 3f          	cmpl   $0x3f,-0x4(%rbp)
    14fd:	0f 8e 7b ff ff ff    	jle    147e <close_all_for_owner+0x18>
    }
  }
}
    1503:	90                   	nop
    1504:	90                   	nop
    1505:	c9                   	leave
    1506:	c3                   	ret

0000000000001507 <send_reply>:

static void
send_reply(int client_pid, int request_id, int result, int fd, int nbytes, char *data)
{
    1507:	f3 0f 1e fa          	endbr64
    150b:	55                   	push   %rbp
    150c:	48 89 e5             	mov    %rsp,%rbp
    150f:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
    1516:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    151c:	89 b5 18 ff ff ff    	mov    %esi,-0xe8(%rbp)
    1522:	89 95 14 ff ff ff    	mov    %edx,-0xec(%rbp)
    1528:	89 8d 10 ff ff ff    	mov    %ecx,-0xf0(%rbp)
    152e:	44 89 85 0c ff ff ff 	mov    %r8d,-0xf4(%rbp)
    1535:	4c 89 8d 00 ff ff ff 	mov    %r9,-0x100(%rbp)
  // DONE(13-reply-metadata): What: add enough reply metadata for robust clients:
  // original request id, operation type, exact byte count, errno-style failure
  // reason if desired, and continuation state for multi-chunk reads/writes.
  // Why: clients need to match replies to requests and handle partial transfers
  // without guessing.
  memset(&reply, 0, sizeof(reply));
    153c:	48 8d 85 20 ff ff ff 	lea    -0xe0(%rbp),%rax
    1543:	ba e0 00 00 00       	mov    $0xe0,%edx
    1548:	be 00 00 00 00       	mov    $0x0,%esi
    154d:	48 89 c7             	mov    %rax,%rdi
    1550:	48 b8 22 1e 00 00 00 	movabs $0x1e22,%rax
    1557:	00 00 00 
    155a:	ff d0                	call   *%rax
  reply.type = IPC_TYPE_FS_REPLY;
    155c:	c7 85 28 ff ff ff 64 	movl   $0x64,-0xd8(%rbp)
    1563:	00 00 00 
  reply.request_id = request_id;
    1566:	8b 85 18 ff ff ff    	mov    -0xe8(%rbp),%eax
    156c:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%rbp)
  reply.fd = fd;
    1572:	8b 85 10 ff ff ff    	mov    -0xf0(%rbp),%eax
    1578:	89 85 2c ff ff ff    	mov    %eax,-0xd4(%rbp)
  reply.result = result;
    157e:	8b 85 14 ff ff ff    	mov    -0xec(%rbp),%eax
    1584:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%rbp)
  reply.nbytes = nbytes;
    158a:	8b 85 0c ff ff ff    	mov    -0xf4(%rbp),%eax
    1590:	89 85 34 ff ff ff    	mov    %eax,-0xcc(%rbp)

  if(data && nbytes > 0){
    1596:	48 83 bd 00 ff ff ff 	cmpq   $0x0,-0x100(%rbp)
    159d:	00 
    159e:	74 49                	je     15e9 <send_reply+0xe2>
    15a0:	83 bd 0c ff ff ff 00 	cmpl   $0x0,-0xf4(%rbp)
    15a7:	7e 40                	jle    15e9 <send_reply+0xe2>
    if(nbytes > IPC_DATA_SIZE)
    15a9:	81 bd 0c ff ff ff 80 	cmpl   $0x80,-0xf4(%rbp)
    15b0:	00 00 00 
    15b3:	7e 0a                	jle    15bf <send_reply+0xb8>
      nbytes = IPC_DATA_SIZE;
    15b5:	c7 85 0c ff ff ff 80 	movl   $0x80,-0xf4(%rbp)
    15bc:	00 00 00 
    memmove(reply.data, data, nbytes);
    15bf:	8b 95 0c ff ff ff    	mov    -0xf4(%rbp),%edx
    15c5:	48 8b 85 00 ff ff ff 	mov    -0x100(%rbp),%rax
    15cc:	48 8d 8d 20 ff ff ff 	lea    -0xe0(%rbp),%rcx
    15d3:	48 83 c1 60          	add    $0x60,%rcx
    15d7:	48 89 c6             	mov    %rax,%rsi
    15da:	48 89 cf             	mov    %rcx,%rdi
    15dd:	48 b8 f1 1f 00 00 00 	movabs $0x1ff1,%rax
    15e4:	00 00 00 
    15e7:	ff d0                	call   *%rax
  }

  if(send(client_pid, &reply) < 0){
    15e9:	48 8d 95 20 ff ff ff 	lea    -0xe0(%rbp),%rdx
    15f0:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    15f6:	48 89 d6             	mov    %rdx,%rsi
    15f9:	89 c7                	mov    %eax,%edi
    15fb:	48 b8 5b 21 00 00 00 	movabs $0x215b,%rax
    1602:	00 00 00 
    1605:	ff d0                	call   *%rax
    1607:	85 c0                	test   %eax,%eax
    1609:	79 2b                	jns    1636 <send_reply+0x12f>
    printf(1, "fsserver: failed reply to pid %d\n", client_pid);
    160b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1611:	89 c2                	mov    %eax,%edx
    1613:	48 b8 80 2a 00 00 00 	movabs $0x2a80,%rax
    161a:	00 00 00 
    161d:	48 89 c6             	mov    %rax,%rsi
    1620:	bf 01 00 00 00       	mov    $0x1,%edi
    1625:	b8 00 00 00 00       	mov    $0x0,%eax
    162a:	48 b9 68 23 00 00 00 	movabs $0x2368,%rcx
    1631:	00 00 00 
    1634:	ff d1                	call   *%rcx
  }
}
    1636:	90                   	nop
    1637:	c9                   	leave
    1638:	c3                   	ret

0000000000001639 <main>:

int
main(void)
{
    1639:	f3 0f 1e fa          	endbr64
    163d:	55                   	push   %rbp
    163e:	48 89 e5             	mov    %rsp,%rbp
    1641:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
  int file_index;
  int rc;
  int n;
  struct mem_file *mf;

  if(register_fsserver() < 0){
    1648:	48 b8 75 21 00 00 00 	movabs $0x2175,%rax
    164f:	00 00 00 
    1652:	ff d0                	call   *%rax
    1654:	85 c0                	test   %eax,%eax
    1656:	79 2f                	jns    1687 <main+0x4e>
    printf(1, "fsserver: register failed\n");
    1658:	48 b8 a2 2a 00 00 00 	movabs $0x2aa2,%rax
    165f:	00 00 00 
    1662:	48 89 c6             	mov    %rax,%rsi
    1665:	bf 01 00 00 00       	mov    $0x1,%edi
    166a:	b8 00 00 00 00       	mov    $0x0,%eax
    166f:	48 ba 68 23 00 00 00 	movabs $0x2368,%rdx
    1676:	00 00 00 
    1679:	ff d2                	call   *%rdx
    exit();
    167b:	48 b8 57 20 00 00 00 	movabs $0x2057,%rax
    1682:	00 00 00 
    1685:	ff d0                	call   *%rax
  }
  printf(1, "fsserver: started (pid=%d)\n", getpid());
    1687:	48 b8 27 21 00 00 00 	movabs $0x2127,%rax
    168e:	00 00 00 
    1691:	ff d0                	call   *%rax
    1693:	89 c2                	mov    %eax,%edx
    1695:	48 b8 bd 2a 00 00 00 	movabs $0x2abd,%rax
    169c:	00 00 00 
    169f:	48 89 c6             	mov    %rax,%rsi
    16a2:	bf 01 00 00 00       	mov    $0x1,%edi
    16a7:	b8 00 00 00 00       	mov    $0x0,%eax
    16ac:	48 b9 68 23 00 00 00 	movabs $0x2368,%rcx
    16b3:	00 00 00 
    16b6:	ff d1                	call   *%rcx

  for(;;){
    memset(&req, 0, sizeof(req));
    16b8:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
    16bf:	ba e0 00 00 00       	mov    $0xe0,%edx
    16c4:	be 00 00 00 00       	mov    $0x0,%esi
    16c9:	48 89 c7             	mov    %rax,%rdi
    16cc:	48 b8 22 1e 00 00 00 	movabs $0x1e22,%rax
    16d3:	00 00 00 
    16d6:	ff d0                	call   *%rax
    if(recv(&req) < 0){
    16d8:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
    16df:	48 89 c7             	mov    %rax,%rdi
    16e2:	48 b8 68 21 00 00 00 	movabs $0x2168,%rax
    16e9:	00 00 00 
    16ec:	ff d0                	call   *%rax
    16ee:	85 c0                	test   %eax,%eax
    16f0:	79 28                	jns    171a <main+0xe1>
      // DONE(27-daemon-error-policy): What: decide whether recv failures should
      // retry, shut down, or notify the kernel that fsserver is unhealthy. Why:
      // infinite retry is acceptable for a demo but weak for the final project
      // analysis and recovery story.
      printf(1, "fsserver: recv failed\n");
    16f2:	48 b8 d9 2a 00 00 00 	movabs $0x2ad9,%rax
    16f9:	00 00 00 
    16fc:	48 89 c6             	mov    %rax,%rsi
    16ff:	bf 01 00 00 00       	mov    $0x1,%edi
    1704:	b8 00 00 00 00       	mov    $0x0,%eax
    1709:	48 ba 68 23 00 00 00 	movabs $0x2368,%rdx
    1710:	00 00 00 
    1713:	ff d2                	call   *%rdx
      continue;
    1715:	e9 f5 05 00 00       	jmp    1d0f <main+0x6d6>
    }

    if(req.type == IPC_TYPE_FS_SHUTDOWN){
    171a:	8b 85 f8 fe ff ff    	mov    -0x108(%rbp),%eax
    1720:	83 f8 65             	cmp    $0x65,%eax
    1723:	75 7c                	jne    17a1 <main+0x168>
      close_all_for_owner(req.sender_pid);
    1725:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
    172b:	89 c7                	mov    %eax,%edi
    172d:	48 b8 66 14 00 00 00 	movabs $0x1466,%rax
    1734:	00 00 00 
    1737:	ff d0                	call   *%rax
      send_reply(req.sender_pid, req.request_id, 0, -1, 0, 0);
    1739:	8b b5 f4 fe ff ff    	mov    -0x10c(%rbp),%esi
    173f:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
    1745:	41 b9 00 00 00 00    	mov    $0x0,%r9d
    174b:	41 b8 00 00 00 00    	mov    $0x0,%r8d
    1751:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
    1756:	ba 00 00 00 00       	mov    $0x0,%edx
    175b:	89 c7                	mov    %eax,%edi
    175d:	48 b8 07 15 00 00 00 	movabs $0x1507,%rax
    1764:	00 00 00 
    1767:	ff d0                	call   *%rax
      printf(1, "fsserver: shutdown requested by pid %d\n", req.sender_pid);
    1769:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
    176f:	89 c2                	mov    %eax,%edx
    1771:	48 b8 f0 2a 00 00 00 	movabs $0x2af0,%rax
    1778:	00 00 00 
    177b:	48 89 c6             	mov    %rax,%rsi
    177e:	bf 01 00 00 00       	mov    $0x1,%edi
    1783:	b8 00 00 00 00       	mov    $0x0,%eax
    1788:	48 b9 68 23 00 00 00 	movabs $0x2368,%rcx
    178f:	00 00 00 
    1792:	ff d1                	call   *%rcx
      break;
    1794:	90                   	nop
      send_reply(req.sender_pid, req.request_id, -1, req.fd, 0, 0);
      break;
    }
  }

  exit();
    1795:	48 b8 57 20 00 00 00 	movabs $0x2057,%rax
    179c:	00 00 00 
    179f:	ff d0                	call   *%rax
    if(req.type == IPC_TYPE_FS_CLIENT_EXIT){
    17a1:	8b 85 f8 fe ff ff    	mov    -0x108(%rbp),%eax
    17a7:	83 f8 66             	cmp    $0x66,%eax
    17aa:	75 19                	jne    17c5 <main+0x18c>
      close_all_for_owner(req.sender_pid);
    17ac:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
    17b2:	89 c7                	mov    %eax,%edi
    17b4:	48 b8 66 14 00 00 00 	movabs $0x1466,%rax
    17bb:	00 00 00 
    17be:	ff d0                	call   *%rax
      continue;
    17c0:	e9 4a 05 00 00       	jmp    1d0f <main+0x6d6>
    switch(req.type){
    17c5:	8b 85 f8 fe ff ff    	mov    -0x108(%rbp),%eax
    17cb:	83 f8 04             	cmp    $0x4,%eax
    17ce:	0f 84 69 04 00 00    	je     1c3d <main+0x604>
    17d4:	83 f8 04             	cmp    $0x4,%eax
    17d7:	0f 8f fe 04 00 00    	jg     1cdb <main+0x6a2>
    17dd:	83 f8 03             	cmp    $0x3,%eax
    17e0:	0f 84 da 02 00 00    	je     1ac0 <main+0x487>
    17e6:	83 f8 03             	cmp    $0x3,%eax
    17e9:	0f 8f ec 04 00 00    	jg     1cdb <main+0x6a2>
    17ef:	83 f8 01             	cmp    $0x1,%eax
    17f2:	74 0e                	je     1802 <main+0x1c9>
    17f4:	83 f8 02             	cmp    $0x2,%eax
    17f7:	0f 84 1d 01 00 00    	je     191a <main+0x2e1>
    17fd:	e9 d9 04 00 00       	jmp    1cdb <main+0x6a2>
      file_index = find_file(req.path);
    1802:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
    1809:	48 83 c0 20          	add    $0x20,%rax
    180d:	48 89 c7             	mov    %rax,%rdi
    1810:	48 b8 ad 10 00 00 00 	movabs $0x10ad,%rax
    1817:	00 00 00 
    181a:	ff d0                	call   *%rax
    181c:	89 45 fc             	mov    %eax,-0x4(%rbp)
      if(file_index < 0 && (req.flags & O_CREATE))
    181f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1823:	79 2c                	jns    1851 <main+0x218>
    1825:	8b 85 00 ff ff ff    	mov    -0x100(%rbp),%eax
    182b:	25 00 02 00 00       	and    $0x200,%eax
    1830:	85 c0                	test   %eax,%eax
    1832:	74 1d                	je     1851 <main+0x218>
        file_index = create_file(req.path);
    1834:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
    183b:	48 83 c0 20          	add    $0x20,%rax
    183f:	48 89 c7             	mov    %rax,%rdi
    1842:	48 b8 32 11 00 00 00 	movabs $0x1132,%rax
    1849:	00 00 00 
    184c:	ff d0                	call   *%rax
    184e:	89 45 fc             	mov    %eax,-0x4(%rbp)
      if(file_index < 0){
    1851:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1855:	79 35                	jns    188c <main+0x253>
        send_reply(req.sender_pid, req.request_id, -1, -1, 0, 0);
    1857:	8b b5 f4 fe ff ff    	mov    -0x10c(%rbp),%esi
    185d:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
    1863:	41 b9 00 00 00 00    	mov    $0x0,%r9d
    1869:	41 b8 00 00 00 00    	mov    $0x0,%r8d
    186f:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
    1874:	ba ff ff ff ff       	mov    $0xffffffff,%edx
    1879:	89 c7                	mov    %eax,%edi
    187b:	48 b8 07 15 00 00 00 	movabs $0x1507,%rax
    1882:	00 00 00 
    1885:	ff d0                	call   *%rax
        break;
    1887:	e9 83 04 00 00       	jmp    1d0f <main+0x6d6>
      remote_fd = alloc_remote_fd(req.sender_pid, file_index, req.flags);
    188c:	8b 95 00 ff ff ff    	mov    -0x100(%rbp),%edx
    1892:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
    1898:	8b 4d fc             	mov    -0x4(%rbp),%ecx
    189b:	89 ce                	mov    %ecx,%esi
    189d:	89 c7                	mov    %eax,%edi
    189f:	48 b8 3f 12 00 00 00 	movabs $0x123f,%rax
    18a6:	00 00 00 
    18a9:	ff d0                	call   *%rax
    18ab:	89 45 dc             	mov    %eax,-0x24(%rbp)
      if(remote_fd < 0){
    18ae:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
    18b2:	79 35                	jns    18e9 <main+0x2b0>
        send_reply(req.sender_pid, req.request_id, -1, -1, 0, 0);
    18b4:	8b b5 f4 fe ff ff    	mov    -0x10c(%rbp),%esi
    18ba:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
    18c0:	41 b9 00 00 00 00    	mov    $0x0,%r9d
    18c6:	41 b8 00 00 00 00    	mov    $0x0,%r8d
    18cc:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
    18d1:	ba ff ff ff ff       	mov    $0xffffffff,%edx
    18d6:	89 c7                	mov    %eax,%edi
    18d8:	48 b8 07 15 00 00 00 	movabs $0x1507,%rax
    18df:	00 00 00 
    18e2:	ff d0                	call   *%rax
        break;
    18e4:	e9 26 04 00 00       	jmp    1d0f <main+0x6d6>
      send_reply(req.sender_pid, req.request_id, remote_fd, remote_fd, 0, 0);
    18e9:	8b b5 f4 fe ff ff    	mov    -0x10c(%rbp),%esi
    18ef:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
    18f5:	8b 4d dc             	mov    -0x24(%rbp),%ecx
    18f8:	8b 55 dc             	mov    -0x24(%rbp),%edx
    18fb:	41 b9 00 00 00 00    	mov    $0x0,%r9d
    1901:	41 b8 00 00 00 00    	mov    $0x0,%r8d
    1907:	89 c7                	mov    %eax,%edi
    1909:	48 b8 07 15 00 00 00 	movabs $0x1507,%rax
    1910:	00 00 00 
    1913:	ff d0                	call   *%rax
      break;
    1915:	e9 f5 03 00 00       	jmp    1d0f <main+0x6d6>
      ent = lookup_remote_fd(req.sender_pid, req.fd);
    191a:	8b 95 fc fe ff ff    	mov    -0x104(%rbp),%edx
    1920:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
    1926:	89 d6                	mov    %edx,%esi
    1928:	89 c7                	mov    %eax,%edi
    192a:	48 b8 c0 13 00 00 00 	movabs $0x13c0,%rax
    1931:	00 00 00 
    1934:	ff d0                	call   *%rax
    1936:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
      if(ent == 0 || !ent->readable){
    193a:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    193f:	74 0b                	je     194c <main+0x313>
    1941:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1945:	8b 40 10             	mov    0x10(%rax),%eax
    1948:	85 c0                	test   %eax,%eax
    194a:	75 38                	jne    1984 <main+0x34b>
        send_reply(req.sender_pid, req.request_id, -1, req.fd, 0, 0);
    194c:	8b 95 fc fe ff ff    	mov    -0x104(%rbp),%edx
    1952:	8b b5 f4 fe ff ff    	mov    -0x10c(%rbp),%esi
    1958:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
    195e:	41 b9 00 00 00 00    	mov    $0x0,%r9d
    1964:	41 b8 00 00 00 00    	mov    $0x0,%r8d
    196a:	89 d1                	mov    %edx,%ecx
    196c:	ba ff ff ff ff       	mov    $0xffffffff,%edx
    1971:	89 c7                	mov    %eax,%edi
    1973:	48 b8 07 15 00 00 00 	movabs $0x1507,%rax
    197a:	00 00 00 
    197d:	ff d0                	call   *%rax
        break;
    197f:	e9 8b 03 00 00       	jmp    1d0f <main+0x6d6>
      n = req.nbytes;
    1984:	8b 85 04 ff ff ff    	mov    -0xfc(%rbp),%eax
    198a:	89 45 f8             	mov    %eax,-0x8(%rbp)
      if(n < 0)
    198d:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1991:	79 07                	jns    199a <main+0x361>
        n = 0;
    1993:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
      if(n > IPC_DATA_SIZE)
    199a:	81 7d f8 80 00 00 00 	cmpl   $0x80,-0x8(%rbp)
    19a1:	7e 07                	jle    19aa <main+0x371>
        n = IPC_DATA_SIZE;
    19a3:	c7 45 f8 80 00 00 00 	movl   $0x80,-0x8(%rbp)
      mf = &files[ent->file_index];
    19aa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    19ae:	8b 40 08             	mov    0x8(%rax),%eax
    19b1:	48 98                	cltq
    19b3:	48 69 c0 48 10 00 00 	imul   $0x1048,%rax,%rax
    19ba:	48 ba 00 32 00 00 00 	movabs $0x3200,%rdx
    19c1:	00 00 00 
    19c4:	48 01 d0             	add    %rdx,%rax
    19c7:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
      if(ent->off >= mf->size){
    19cb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    19cf:	8b 50 0c             	mov    0xc(%rax),%edx
    19d2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    19d6:	8b 40 04             	mov    0x4(%rax),%eax
    19d9:	39 c2                	cmp    %eax,%edx
    19db:	7c 38                	jl     1a15 <main+0x3dc>
        send_reply(req.sender_pid, req.request_id, 0, req.fd, 0, 0);
    19dd:	8b 95 fc fe ff ff    	mov    -0x104(%rbp),%edx
    19e3:	8b b5 f4 fe ff ff    	mov    -0x10c(%rbp),%esi
    19e9:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
    19ef:	41 b9 00 00 00 00    	mov    $0x0,%r9d
    19f5:	41 b8 00 00 00 00    	mov    $0x0,%r8d
    19fb:	89 d1                	mov    %edx,%ecx
    19fd:	ba 00 00 00 00       	mov    $0x0,%edx
    1a02:	89 c7                	mov    %eax,%edi
    1a04:	48 b8 07 15 00 00 00 	movabs $0x1507,%rax
    1a0b:	00 00 00 
    1a0e:	ff d0                	call   *%rax
        break;
    1a10:	e9 fa 02 00 00       	jmp    1d0f <main+0x6d6>
      if(n > mf->size - ent->off)
    1a15:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1a19:	8b 50 04             	mov    0x4(%rax),%edx
    1a1c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1a20:	8b 40 0c             	mov    0xc(%rax),%eax
    1a23:	29 c2                	sub    %eax,%edx
    1a25:	39 55 f8             	cmp    %edx,-0x8(%rbp)
    1a28:	7e 13                	jle    1a3d <main+0x404>
        n = mf->size - ent->off;
    1a2a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1a2e:	8b 50 04             	mov    0x4(%rax),%edx
    1a31:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1a35:	8b 40 0c             	mov    0xc(%rax),%eax
    1a38:	29 c2                	sub    %eax,%edx
    1a3a:	89 55 f8             	mov    %edx,-0x8(%rbp)
      memmove(req.data, mf->data + ent->off, n);
    1a3d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1a41:	48 8d 50 48          	lea    0x48(%rax),%rdx
    1a45:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1a49:	8b 40 0c             	mov    0xc(%rax),%eax
    1a4c:	48 98                	cltq
    1a4e:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
    1a52:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1a55:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
    1a5c:	48 8d 4a 60          	lea    0x60(%rdx),%rcx
    1a60:	89 c2                	mov    %eax,%edx
    1a62:	48 89 cf             	mov    %rcx,%rdi
    1a65:	48 b8 f1 1f 00 00 00 	movabs $0x1ff1,%rax
    1a6c:	00 00 00 
    1a6f:	ff d0                	call   *%rax
      ent->off += n;
    1a71:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1a75:	8b 50 0c             	mov    0xc(%rax),%edx
    1a78:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1a7b:	01 c2                	add    %eax,%edx
    1a7d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1a81:	89 50 0c             	mov    %edx,0xc(%rax)
      send_reply(req.sender_pid, req.request_id, n, req.fd, n, req.data);
    1a84:	8b 8d fc fe ff ff    	mov    -0x104(%rbp),%ecx
    1a8a:	8b b5 f4 fe ff ff    	mov    -0x10c(%rbp),%esi
    1a90:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
    1a96:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
    1a9d:	4c 8d 42 60          	lea    0x60(%rdx),%r8
    1aa1:	8b 7d f8             	mov    -0x8(%rbp),%edi
    1aa4:	8b 55 f8             	mov    -0x8(%rbp),%edx
    1aa7:	4d 89 c1             	mov    %r8,%r9
    1aaa:	41 89 f8             	mov    %edi,%r8d
    1aad:	89 c7                	mov    %eax,%edi
    1aaf:	48 b8 07 15 00 00 00 	movabs $0x1507,%rax
    1ab6:	00 00 00 
    1ab9:	ff d0                	call   *%rax
      break;
    1abb:	e9 4f 02 00 00       	jmp    1d0f <main+0x6d6>
      ent = lookup_remote_fd(req.sender_pid, req.fd);
    1ac0:	8b 95 fc fe ff ff    	mov    -0x104(%rbp),%edx
    1ac6:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
    1acc:	89 d6                	mov    %edx,%esi
    1ace:	89 c7                	mov    %eax,%edi
    1ad0:	48 b8 c0 13 00 00 00 	movabs $0x13c0,%rax
    1ad7:	00 00 00 
    1ada:	ff d0                	call   *%rax
    1adc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
      if(ent == 0 || !ent->writable){
    1ae0:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1ae5:	74 0b                	je     1af2 <main+0x4b9>
    1ae7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1aeb:	8b 40 14             	mov    0x14(%rax),%eax
    1aee:	85 c0                	test   %eax,%eax
    1af0:	75 38                	jne    1b2a <main+0x4f1>
        send_reply(req.sender_pid, req.request_id, -1, req.fd, 0, 0);
    1af2:	8b 95 fc fe ff ff    	mov    -0x104(%rbp),%edx
    1af8:	8b b5 f4 fe ff ff    	mov    -0x10c(%rbp),%esi
    1afe:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
    1b04:	41 b9 00 00 00 00    	mov    $0x0,%r9d
    1b0a:	41 b8 00 00 00 00    	mov    $0x0,%r8d
    1b10:	89 d1                	mov    %edx,%ecx
    1b12:	ba ff ff ff ff       	mov    $0xffffffff,%edx
    1b17:	89 c7                	mov    %eax,%edi
    1b19:	48 b8 07 15 00 00 00 	movabs $0x1507,%rax
    1b20:	00 00 00 
    1b23:	ff d0                	call   *%rax
        break;
    1b25:	e9 e5 01 00 00       	jmp    1d0f <main+0x6d6>
      n = req.nbytes;
    1b2a:	8b 85 04 ff ff ff    	mov    -0xfc(%rbp),%eax
    1b30:	89 45 f8             	mov    %eax,-0x8(%rbp)
      if(n < 0)
    1b33:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1b37:	79 07                	jns    1b40 <main+0x507>
        n = 0;
    1b39:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
      if(n > IPC_DATA_SIZE)
    1b40:	81 7d f8 80 00 00 00 	cmpl   $0x80,-0x8(%rbp)
    1b47:	7e 07                	jle    1b50 <main+0x517>
        n = IPC_DATA_SIZE;
    1b49:	c7 45 f8 80 00 00 00 	movl   $0x80,-0x8(%rbp)
      mf = &files[ent->file_index];
    1b50:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b54:	8b 40 08             	mov    0x8(%rax),%eax
    1b57:	48 98                	cltq
    1b59:	48 69 c0 48 10 00 00 	imul   $0x1048,%rax,%rax
    1b60:	48 ba 00 32 00 00 00 	movabs $0x3200,%rdx
    1b67:	00 00 00 
    1b6a:	48 01 d0             	add    %rdx,%rax
    1b6d:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
      if(ent->off + n > MAX_FILE_SIZE)
    1b71:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b75:	8b 50 0c             	mov    0xc(%rax),%edx
    1b78:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1b7b:	01 d0                	add    %edx,%eax
    1b7d:	3d 00 10 00 00       	cmp    $0x1000,%eax
    1b82:	7e 11                	jle    1b95 <main+0x55c>
        n = MAX_FILE_SIZE - ent->off;
    1b84:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b88:	8b 40 0c             	mov    0xc(%rax),%eax
    1b8b:	ba 00 10 00 00       	mov    $0x1000,%edx
    1b90:	29 c2                	sub    %eax,%edx
    1b92:	89 55 f8             	mov    %edx,-0x8(%rbp)
      if(n < 0)
    1b95:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1b99:	79 07                	jns    1ba2 <main+0x569>
        n = 0;
    1b9b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
      memmove(mf->data + ent->off, req.data, n);
    1ba2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1ba6:	48 8d 50 48          	lea    0x48(%rax),%rdx
    1baa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bae:	8b 40 0c             	mov    0xc(%rax),%eax
    1bb1:	48 98                	cltq
    1bb3:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
    1bb7:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1bba:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
    1bc1:	48 8d 72 60          	lea    0x60(%rdx),%rsi
    1bc5:	89 c2                	mov    %eax,%edx
    1bc7:	48 89 cf             	mov    %rcx,%rdi
    1bca:	48 b8 f1 1f 00 00 00 	movabs $0x1ff1,%rax
    1bd1:	00 00 00 
    1bd4:	ff d0                	call   *%rax
      ent->off += n;
    1bd6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bda:	8b 50 0c             	mov    0xc(%rax),%edx
    1bdd:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1be0:	01 c2                	add    %eax,%edx
    1be2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1be6:	89 50 0c             	mov    %edx,0xc(%rax)
      if(ent->off > mf->size)
    1be9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bed:	8b 50 0c             	mov    0xc(%rax),%edx
    1bf0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1bf4:	8b 40 04             	mov    0x4(%rax),%eax
    1bf7:	39 c2                	cmp    %eax,%edx
    1bf9:	7e 0e                	jle    1c09 <main+0x5d0>
        mf->size = ent->off;
    1bfb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bff:	8b 50 0c             	mov    0xc(%rax),%edx
    1c02:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1c06:	89 50 04             	mov    %edx,0x4(%rax)
      send_reply(req.sender_pid, req.request_id, n, req.fd, 0, 0);
    1c09:	8b 8d fc fe ff ff    	mov    -0x104(%rbp),%ecx
    1c0f:	8b b5 f4 fe ff ff    	mov    -0x10c(%rbp),%esi
    1c15:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
    1c1b:	8b 55 f8             	mov    -0x8(%rbp),%edx
    1c1e:	41 b9 00 00 00 00    	mov    $0x0,%r9d
    1c24:	41 b8 00 00 00 00    	mov    $0x0,%r8d
    1c2a:	89 c7                	mov    %eax,%edi
    1c2c:	48 b8 07 15 00 00 00 	movabs $0x1507,%rax
    1c33:	00 00 00 
    1c36:	ff d0                	call   *%rax
      break;
    1c38:	e9 d2 00 00 00       	jmp    1d0f <main+0x6d6>
      ent = lookup_remote_fd(req.sender_pid, req.fd);
    1c3d:	8b 95 fc fe ff ff    	mov    -0x104(%rbp),%edx
    1c43:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
    1c49:	89 d6                	mov    %edx,%esi
    1c4b:	89 c7                	mov    %eax,%edi
    1c4d:	48 b8 c0 13 00 00 00 	movabs $0x13c0,%rax
    1c54:	00 00 00 
    1c57:	ff d0                	call   *%rax
    1c59:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
      if(ent == 0){
    1c5d:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1c62:	75 35                	jne    1c99 <main+0x660>
        send_reply(req.sender_pid, req.request_id, -1, req.fd, 0, 0);
    1c64:	8b 95 fc fe ff ff    	mov    -0x104(%rbp),%edx
    1c6a:	8b b5 f4 fe ff ff    	mov    -0x10c(%rbp),%esi
    1c70:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
    1c76:	41 b9 00 00 00 00    	mov    $0x0,%r9d
    1c7c:	41 b8 00 00 00 00    	mov    $0x0,%r8d
    1c82:	89 d1                	mov    %edx,%ecx
    1c84:	ba ff ff ff ff       	mov    $0xffffffff,%edx
    1c89:	89 c7                	mov    %eax,%edi
    1c8b:	48 b8 07 15 00 00 00 	movabs $0x1507,%rax
    1c92:	00 00 00 
    1c95:	ff d0                	call   *%rax
        break;
    1c97:	eb 76                	jmp    1d0f <main+0x6d6>
      ent->used = 0;
    1c99:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c9d:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
      rc = 0;
    1ca3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
      send_reply(req.sender_pid, req.request_id, rc, req.fd, 0, 0);
    1caa:	8b 8d fc fe ff ff    	mov    -0x104(%rbp),%ecx
    1cb0:	8b b5 f4 fe ff ff    	mov    -0x10c(%rbp),%esi
    1cb6:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
    1cbc:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1cbf:	41 b9 00 00 00 00    	mov    $0x0,%r9d
    1cc5:	41 b8 00 00 00 00    	mov    $0x0,%r8d
    1ccb:	89 c7                	mov    %eax,%edi
    1ccd:	48 b8 07 15 00 00 00 	movabs $0x1507,%rax
    1cd4:	00 00 00 
    1cd7:	ff d0                	call   *%rax
      break;
    1cd9:	eb 34                	jmp    1d0f <main+0x6d6>
      send_reply(req.sender_pid, req.request_id, -1, req.fd, 0, 0);
    1cdb:	8b 95 fc fe ff ff    	mov    -0x104(%rbp),%edx
    1ce1:	8b b5 f4 fe ff ff    	mov    -0x10c(%rbp),%esi
    1ce7:	8b 85 f0 fe ff ff    	mov    -0x110(%rbp),%eax
    1ced:	41 b9 00 00 00 00    	mov    $0x0,%r9d
    1cf3:	41 b8 00 00 00 00    	mov    $0x0,%r8d
    1cf9:	89 d1                	mov    %edx,%ecx
    1cfb:	ba ff ff ff ff       	mov    $0xffffffff,%edx
    1d00:	89 c7                	mov    %eax,%edi
    1d02:	48 b8 07 15 00 00 00 	movabs $0x1507,%rax
    1d09:	00 00 00 
    1d0c:	ff d0                	call   *%rax
      break;
    1d0e:	90                   	nop
    memset(&req, 0, sizeof(req));
    1d0f:	e9 a4 f9 ff ff       	jmp    16b8 <main+0x7f>

0000000000001d14 <stosb>:
  stosb(dst, c, n);
  return dst;
}

char*
strchr(const char *s, char c)
    1d14:	f3 0f 1e fa          	endbr64
    1d18:	55                   	push   %rbp
    1d19:	48 89 e5             	mov    %rsp,%rbp
    1d1c:	48 83 ec 10          	sub    $0x10,%rsp
    1d20:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1d24:	89 75 f4             	mov    %esi,-0xc(%rbp)
    1d27:	89 55 f0             	mov    %edx,-0x10(%rbp)
{
    1d2a:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1d2e:	8b 55 f0             	mov    -0x10(%rbp),%edx
    1d31:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1d34:	48 89 ce             	mov    %rcx,%rsi
    1d37:	48 89 f7             	mov    %rsi,%rdi
    1d3a:	89 d1                	mov    %edx,%ecx
    1d3c:	fc                   	cld
    1d3d:	f3 aa                	rep stos %al,%es:(%rdi)
    1d3f:	89 ca                	mov    %ecx,%edx
    1d41:	48 89 fe             	mov    %rdi,%rsi
    1d44:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    1d48:	89 55 f0             	mov    %edx,-0x10(%rbp)
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
    1d4b:	90                   	nop
    1d4c:	c9                   	leave
    1d4d:	c3                   	ret

0000000000001d4e <strcpy>:
{
    1d4e:	f3 0f 1e fa          	endbr64
    1d52:	55                   	push   %rbp
    1d53:	48 89 e5             	mov    %rsp,%rbp
    1d56:	48 83 ec 20          	sub    $0x20,%rsp
    1d5a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1d5e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  os = s;
    1d62:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1d66:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    1d6a:	90                   	nop
    1d6b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1d6f:	48 8d 42 01          	lea    0x1(%rdx),%rax
    1d73:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    1d77:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1d7b:	48 8d 48 01          	lea    0x1(%rax),%rcx
    1d7f:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    1d83:	0f b6 12             	movzbl (%rdx),%edx
    1d86:	88 10                	mov    %dl,(%rax)
    1d88:	0f b6 00             	movzbl (%rax),%eax
    1d8b:	84 c0                	test   %al,%al
    1d8d:	75 dc                	jne    1d6b <strcpy+0x1d>
  return os;
    1d8f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    1d93:	c9                   	leave
    1d94:	c3                   	ret

0000000000001d95 <strcmp>:
{
    1d95:	f3 0f 1e fa          	endbr64
    1d99:	55                   	push   %rbp
    1d9a:	48 89 e5             	mov    %rsp,%rbp
    1d9d:	48 83 ec 10          	sub    $0x10,%rsp
    1da1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1da5:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    1da9:	eb 0a                	jmp    1db5 <strcmp+0x20>
    p++, q++;
    1dab:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1db0:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    1db5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1db9:	0f b6 00             	movzbl (%rax),%eax
    1dbc:	84 c0                	test   %al,%al
    1dbe:	74 12                	je     1dd2 <strcmp+0x3d>
    1dc0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1dc4:	0f b6 10             	movzbl (%rax),%edx
    1dc7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1dcb:	0f b6 00             	movzbl (%rax),%eax
    1dce:	38 c2                	cmp    %al,%dl
    1dd0:	74 d9                	je     1dab <strcmp+0x16>
  return (uchar)*p - (uchar)*q;
    1dd2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1dd6:	0f b6 00             	movzbl (%rax),%eax
    1dd9:	0f b6 d0             	movzbl %al,%edx
    1ddc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1de0:	0f b6 00             	movzbl (%rax),%eax
    1de3:	0f b6 c0             	movzbl %al,%eax
    1de6:	29 c2                	sub    %eax,%edx
    1de8:	89 d0                	mov    %edx,%eax
}
    1dea:	c9                   	leave
    1deb:	c3                   	ret

0000000000001dec <strlen>:
{
    1dec:	f3 0f 1e fa          	endbr64
    1df0:	55                   	push   %rbp
    1df1:	48 89 e5             	mov    %rsp,%rbp
    1df4:	48 83 ec 18          	sub    $0x18,%rsp
    1df8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  for(n = 0; s[n]; n++)
    1dfc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1e03:	eb 04                	jmp    1e09 <strlen+0x1d>
    1e05:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1e09:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1e0c:	48 63 d0             	movslq %eax,%rdx
    1e0f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1e13:	48 01 d0             	add    %rdx,%rax
    1e16:	0f b6 00             	movzbl (%rax),%eax
    1e19:	84 c0                	test   %al,%al
    1e1b:	75 e8                	jne    1e05 <strlen+0x19>
  return n;
    1e1d:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    1e20:	c9                   	leave
    1e21:	c3                   	ret

0000000000001e22 <memset>:
{
    1e22:	f3 0f 1e fa          	endbr64
    1e26:	55                   	push   %rbp
    1e27:	48 89 e5             	mov    %rsp,%rbp
    1e2a:	48 83 ec 10          	sub    $0x10,%rsp
    1e2e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1e32:	89 75 f4             	mov    %esi,-0xc(%rbp)
    1e35:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    1e38:	8b 55 f0             	mov    -0x10(%rbp),%edx
    1e3b:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    1e3e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e42:	89 ce                	mov    %ecx,%esi
    1e44:	48 89 c7             	mov    %rax,%rdi
    1e47:	48 b8 14 1d 00 00 00 	movabs $0x1d14,%rax
    1e4e:	00 00 00 
    1e51:	ff d0                	call   *%rax
  return dst;
    1e53:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    1e57:	c9                   	leave
    1e58:	c3                   	ret

0000000000001e59 <strchr>:
{
    1e59:	f3 0f 1e fa          	endbr64
    1e5d:	55                   	push   %rbp
    1e5e:	48 89 e5             	mov    %rsp,%rbp
    1e61:	48 83 ec 10          	sub    $0x10,%rsp
    1e65:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1e69:	89 f0                	mov    %esi,%eax
    1e6b:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    1e6e:	eb 17                	jmp    1e87 <strchr+0x2e>
    if(*s == c)
    1e70:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e74:	0f b6 00             	movzbl (%rax),%eax
    1e77:	38 45 f4             	cmp    %al,-0xc(%rbp)
    1e7a:	75 06                	jne    1e82 <strchr+0x29>
      return (char*)s;
    1e7c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e80:	eb 15                	jmp    1e97 <strchr+0x3e>
  for(; *s; s++)
    1e82:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1e87:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e8b:	0f b6 00             	movzbl (%rax),%eax
    1e8e:	84 c0                	test   %al,%al
    1e90:	75 de                	jne    1e70 <strchr+0x17>
  return 0;
    1e92:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1e97:	c9                   	leave
    1e98:	c3                   	ret

0000000000001e99 <gets>:

char*
gets(char *buf, int max)
{
    1e99:	f3 0f 1e fa          	endbr64
    1e9d:	55                   	push   %rbp
    1e9e:	48 89 e5             	mov    %rsp,%rbp
    1ea1:	48 83 ec 20          	sub    $0x20,%rsp
    1ea5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1ea9:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1eac:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1eb3:	eb 4f                	jmp    1f04 <gets+0x6b>
    cc = read(0, &c, 1);
    1eb5:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    1eb9:	ba 01 00 00 00       	mov    $0x1,%edx
    1ebe:	48 89 c6             	mov    %rax,%rsi
    1ec1:	bf 00 00 00 00       	mov    $0x0,%edi
    1ec6:	48 b8 7e 20 00 00 00 	movabs $0x207e,%rax
    1ecd:	00 00 00 
    1ed0:	ff d0                	call   *%rax
    1ed2:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    1ed5:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1ed9:	7e 36                	jle    1f11 <gets+0x78>
      break;
    buf[i++] = c;
    1edb:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1ede:	8d 50 01             	lea    0x1(%rax),%edx
    1ee1:	89 55 fc             	mov    %edx,-0x4(%rbp)
    1ee4:	48 63 d0             	movslq %eax,%rdx
    1ee7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1eeb:	48 01 c2             	add    %rax,%rdx
    1eee:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1ef2:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    1ef4:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1ef8:	3c 0a                	cmp    $0xa,%al
    1efa:	74 16                	je     1f12 <gets+0x79>
    1efc:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1f00:	3c 0d                	cmp    $0xd,%al
    1f02:	74 0e                	je     1f12 <gets+0x79>
  for(i=0; i+1 < max; ){
    1f04:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1f07:	83 c0 01             	add    $0x1,%eax
    1f0a:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    1f0d:	7f a6                	jg     1eb5 <gets+0x1c>
    1f0f:	eb 01                	jmp    1f12 <gets+0x79>
      break;
    1f11:	90                   	nop
      break;
  }
  buf[i] = '\0';
    1f12:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1f15:	48 63 d0             	movslq %eax,%rdx
    1f18:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1f1c:	48 01 d0             	add    %rdx,%rax
    1f1f:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    1f22:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    1f26:	c9                   	leave
    1f27:	c3                   	ret

0000000000001f28 <stat>:

int
stat(char *n, struct stat *st)
{
    1f28:	f3 0f 1e fa          	endbr64
    1f2c:	55                   	push   %rbp
    1f2d:	48 89 e5             	mov    %rsp,%rbp
    1f30:	48 83 ec 20          	sub    $0x20,%rsp
    1f34:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1f38:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1f3c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1f40:	be 00 00 00 00       	mov    $0x0,%esi
    1f45:	48 89 c7             	mov    %rax,%rdi
    1f48:	48 b8 bf 20 00 00 00 	movabs $0x20bf,%rax
    1f4f:	00 00 00 
    1f52:	ff d0                	call   *%rax
    1f54:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    1f57:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1f5b:	79 07                	jns    1f64 <stat+0x3c>
    return -1;
    1f5d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1f62:	eb 2f                	jmp    1f93 <stat+0x6b>
  r = fstat(fd, st);
    1f64:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1f68:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1f6b:	48 89 d6             	mov    %rdx,%rsi
    1f6e:	89 c7                	mov    %eax,%edi
    1f70:	48 b8 e6 20 00 00 00 	movabs $0x20e6,%rax
    1f77:	00 00 00 
    1f7a:	ff d0                	call   *%rax
    1f7c:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    1f7f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1f82:	89 c7                	mov    %eax,%edi
    1f84:	48 b8 98 20 00 00 00 	movabs $0x2098,%rax
    1f8b:	00 00 00 
    1f8e:	ff d0                	call   *%rax
  return r;
    1f90:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    1f93:	c9                   	leave
    1f94:	c3                   	ret

0000000000001f95 <atoi>:

int
atoi(const char *s)
{
    1f95:	f3 0f 1e fa          	endbr64
    1f99:	55                   	push   %rbp
    1f9a:	48 89 e5             	mov    %rsp,%rbp
    1f9d:	48 83 ec 18          	sub    $0x18,%rsp
    1fa1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    1fa5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1fac:	eb 28                	jmp    1fd6 <atoi+0x41>
    n = n*10 + *s++ - '0';
    1fae:	8b 55 fc             	mov    -0x4(%rbp),%edx
    1fb1:	89 d0                	mov    %edx,%eax
    1fb3:	c1 e0 02             	shl    $0x2,%eax
    1fb6:	01 d0                	add    %edx,%eax
    1fb8:	01 c0                	add    %eax,%eax
    1fba:	89 c1                	mov    %eax,%ecx
    1fbc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1fc0:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1fc4:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    1fc8:	0f b6 00             	movzbl (%rax),%eax
    1fcb:	0f be c0             	movsbl %al,%eax
    1fce:	01 c8                	add    %ecx,%eax
    1fd0:	83 e8 30             	sub    $0x30,%eax
    1fd3:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1fd6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1fda:	0f b6 00             	movzbl (%rax),%eax
    1fdd:	3c 2f                	cmp    $0x2f,%al
    1fdf:	7e 0b                	jle    1fec <atoi+0x57>
    1fe1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1fe5:	0f b6 00             	movzbl (%rax),%eax
    1fe8:	3c 39                	cmp    $0x39,%al
    1fea:	7e c2                	jle    1fae <atoi+0x19>
  return n;
    1fec:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    1fef:	c9                   	leave
    1ff0:	c3                   	ret

0000000000001ff1 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1ff1:	f3 0f 1e fa          	endbr64
    1ff5:	55                   	push   %rbp
    1ff6:	48 89 e5             	mov    %rsp,%rbp
    1ff9:	48 83 ec 28          	sub    $0x28,%rsp
    1ffd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    2001:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    2005:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    2008:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    200c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    2010:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    2014:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    2018:	eb 1d                	jmp    2037 <memmove+0x46>
    *dst++ = *src++;
    201a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    201e:	48 8d 42 01          	lea    0x1(%rdx),%rax
    2022:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    2026:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    202a:	48 8d 48 01          	lea    0x1(%rax),%rcx
    202e:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    2032:	0f b6 12             	movzbl (%rdx),%edx
    2035:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    2037:	8b 45 dc             	mov    -0x24(%rbp),%eax
    203a:	8d 50 ff             	lea    -0x1(%rax),%edx
    203d:	89 55 dc             	mov    %edx,-0x24(%rbp)
    2040:	85 c0                	test   %eax,%eax
    2042:	7f d6                	jg     201a <memmove+0x29>
  return vdst;
    2044:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    2048:	c9                   	leave
    2049:	c3                   	ret

000000000000204a <fork>:
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    204a:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    2051:	49 89 ca             	mov    %rcx,%r10
    2054:	0f 05                	syscall
    2056:	c3                   	ret

0000000000002057 <exit>:
SYSCALL(exit)
    2057:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    205e:	49 89 ca             	mov    %rcx,%r10
    2061:	0f 05                	syscall
    2063:	c3                   	ret

0000000000002064 <wait>:
SYSCALL(wait)
    2064:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    206b:	49 89 ca             	mov    %rcx,%r10
    206e:	0f 05                	syscall
    2070:	c3                   	ret

0000000000002071 <pipe>:
SYSCALL(pipe)
    2071:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    2078:	49 89 ca             	mov    %rcx,%r10
    207b:	0f 05                	syscall
    207d:	c3                   	ret

000000000000207e <read>:
SYSCALL(read)
    207e:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    2085:	49 89 ca             	mov    %rcx,%r10
    2088:	0f 05                	syscall
    208a:	c3                   	ret

000000000000208b <write>:
SYSCALL(write)
    208b:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    2092:	49 89 ca             	mov    %rcx,%r10
    2095:	0f 05                	syscall
    2097:	c3                   	ret

0000000000002098 <close>:
SYSCALL(close)
    2098:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    209f:	49 89 ca             	mov    %rcx,%r10
    20a2:	0f 05                	syscall
    20a4:	c3                   	ret

00000000000020a5 <kill>:
SYSCALL(kill)
    20a5:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    20ac:	49 89 ca             	mov    %rcx,%r10
    20af:	0f 05                	syscall
    20b1:	c3                   	ret

00000000000020b2 <exec>:
SYSCALL(exec)
    20b2:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    20b9:	49 89 ca             	mov    %rcx,%r10
    20bc:	0f 05                	syscall
    20be:	c3                   	ret

00000000000020bf <open>:
SYSCALL(open)
    20bf:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    20c6:	49 89 ca             	mov    %rcx,%r10
    20c9:	0f 05                	syscall
    20cb:	c3                   	ret

00000000000020cc <mknod>:
SYSCALL(mknod)
    20cc:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    20d3:	49 89 ca             	mov    %rcx,%r10
    20d6:	0f 05                	syscall
    20d8:	c3                   	ret

00000000000020d9 <unlink>:
SYSCALL(unlink)
    20d9:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    20e0:	49 89 ca             	mov    %rcx,%r10
    20e3:	0f 05                	syscall
    20e5:	c3                   	ret

00000000000020e6 <fstat>:
SYSCALL(fstat)
    20e6:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    20ed:	49 89 ca             	mov    %rcx,%r10
    20f0:	0f 05                	syscall
    20f2:	c3                   	ret

00000000000020f3 <link>:
SYSCALL(link)
    20f3:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    20fa:	49 89 ca             	mov    %rcx,%r10
    20fd:	0f 05                	syscall
    20ff:	c3                   	ret

0000000000002100 <mkdir>:
SYSCALL(mkdir)
    2100:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    2107:	49 89 ca             	mov    %rcx,%r10
    210a:	0f 05                	syscall
    210c:	c3                   	ret

000000000000210d <chdir>:
SYSCALL(chdir)
    210d:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    2114:	49 89 ca             	mov    %rcx,%r10
    2117:	0f 05                	syscall
    2119:	c3                   	ret

000000000000211a <dup>:
SYSCALL(dup)
    211a:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    2121:	49 89 ca             	mov    %rcx,%r10
    2124:	0f 05                	syscall
    2126:	c3                   	ret

0000000000002127 <getpid>:
SYSCALL(getpid)
    2127:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    212e:	49 89 ca             	mov    %rcx,%r10
    2131:	0f 05                	syscall
    2133:	c3                   	ret

0000000000002134 <sbrk>:
SYSCALL(sbrk)
    2134:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    213b:	49 89 ca             	mov    %rcx,%r10
    213e:	0f 05                	syscall
    2140:	c3                   	ret

0000000000002141 <sleep>:
SYSCALL(sleep)
    2141:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    2148:	49 89 ca             	mov    %rcx,%r10
    214b:	0f 05                	syscall
    214d:	c3                   	ret

000000000000214e <uptime>:
SYSCALL(uptime)
    214e:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    2155:	49 89 ca             	mov    %rcx,%r10
    2158:	0f 05                	syscall
    215a:	c3                   	ret

000000000000215b <send>:
SYSCALL(send)
    215b:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    2162:	49 89 ca             	mov    %rcx,%r10
    2165:	0f 05                	syscall
    2167:	c3                   	ret

0000000000002168 <recv>:
SYSCALL(recv)
    2168:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    216f:	49 89 ca             	mov    %rcx,%r10
    2172:	0f 05                	syscall
    2174:	c3                   	ret

0000000000002175 <register_fsserver>:
SYSCALL(register_fsserver)
    2175:	48 c7 c0 18 00 00 00 	mov    $0x18,%rax
    217c:	49 89 ca             	mov    %rcx,%r10
    217f:	0f 05                	syscall
    2181:	c3                   	ret

0000000000002182 <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    2182:	f3 0f 1e fa          	endbr64
    2186:	55                   	push   %rbp
    2187:	48 89 e5             	mov    %rsp,%rbp
    218a:	48 83 ec 10          	sub    $0x10,%rsp
    218e:	89 7d fc             	mov    %edi,-0x4(%rbp)
    2191:	89 f0                	mov    %esi,%eax
    2193:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    2196:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    219a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    219d:	ba 01 00 00 00       	mov    $0x1,%edx
    21a2:	48 89 ce             	mov    %rcx,%rsi
    21a5:	89 c7                	mov    %eax,%edi
    21a7:	48 b8 8b 20 00 00 00 	movabs $0x208b,%rax
    21ae:	00 00 00 
    21b1:	ff d0                	call   *%rax
}
    21b3:	90                   	nop
    21b4:	c9                   	leave
    21b5:	c3                   	ret

00000000000021b6 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    21b6:	f3 0f 1e fa          	endbr64
    21ba:	55                   	push   %rbp
    21bb:	48 89 e5             	mov    %rsp,%rbp
    21be:	48 83 ec 20          	sub    $0x20,%rsp
    21c2:	89 7d ec             	mov    %edi,-0x14(%rbp)
    21c5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    21c9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    21d0:	eb 35                	jmp    2207 <print_x64+0x51>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    21d2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    21d6:	48 c1 e8 3c          	shr    $0x3c,%rax
    21da:	48 ba d0 2b 00 00 00 	movabs $0x2bd0,%rdx
    21e1:	00 00 00 
    21e4:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    21e8:	0f be d0             	movsbl %al,%edx
    21eb:	8b 45 ec             	mov    -0x14(%rbp),%eax
    21ee:	89 d6                	mov    %edx,%esi
    21f0:	89 c7                	mov    %eax,%edi
    21f2:	48 b8 82 21 00 00 00 	movabs $0x2182,%rax
    21f9:	00 00 00 
    21fc:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    21fe:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    2202:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    2207:	8b 45 fc             	mov    -0x4(%rbp),%eax
    220a:	83 f8 0f             	cmp    $0xf,%eax
    220d:	76 c3                	jbe    21d2 <print_x64+0x1c>
}
    220f:	90                   	nop
    2210:	90                   	nop
    2211:	c9                   	leave
    2212:	c3                   	ret

0000000000002213 <print_x32>:

  static void
print_x32(int fd, uint x)
{
    2213:	f3 0f 1e fa          	endbr64
    2217:	55                   	push   %rbp
    2218:	48 89 e5             	mov    %rsp,%rbp
    221b:	48 83 ec 20          	sub    $0x20,%rsp
    221f:	89 7d ec             	mov    %edi,-0x14(%rbp)
    2222:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    2225:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    222c:	eb 36                	jmp    2264 <print_x32+0x51>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    222e:	8b 45 e8             	mov    -0x18(%rbp),%eax
    2231:	c1 e8 1c             	shr    $0x1c,%eax
    2234:	89 c2                	mov    %eax,%edx
    2236:	48 b8 d0 2b 00 00 00 	movabs $0x2bd0,%rax
    223d:	00 00 00 
    2240:	89 d2                	mov    %edx,%edx
    2242:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    2246:	0f be d0             	movsbl %al,%edx
    2249:	8b 45 ec             	mov    -0x14(%rbp),%eax
    224c:	89 d6                	mov    %edx,%esi
    224e:	89 c7                	mov    %eax,%edi
    2250:	48 b8 82 21 00 00 00 	movabs $0x2182,%rax
    2257:	00 00 00 
    225a:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    225c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    2260:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    2264:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2267:	83 f8 07             	cmp    $0x7,%eax
    226a:	76 c2                	jbe    222e <print_x32+0x1b>
}
    226c:	90                   	nop
    226d:	90                   	nop
    226e:	c9                   	leave
    226f:	c3                   	ret

0000000000002270 <print_d>:

  static void
print_d(int fd, int v)
{
    2270:	f3 0f 1e fa          	endbr64
    2274:	55                   	push   %rbp
    2275:	48 89 e5             	mov    %rsp,%rbp
    2278:	48 83 ec 30          	sub    $0x30,%rsp
    227c:	89 7d dc             	mov    %edi,-0x24(%rbp)
    227f:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    2282:	8b 45 d8             	mov    -0x28(%rbp),%eax
    2285:	48 98                	cltq
    2287:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    228b:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    228f:	79 04                	jns    2295 <print_d+0x25>
    x = -x;
    2291:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    2295:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    229c:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    22a0:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    22a7:	66 66 66 
    22aa:	48 89 c8             	mov    %rcx,%rax
    22ad:	48 f7 ea             	imul   %rdx
    22b0:	48 c1 fa 02          	sar    $0x2,%rdx
    22b4:	48 89 c8             	mov    %rcx,%rax
    22b7:	48 c1 f8 3f          	sar    $0x3f,%rax
    22bb:	48 29 c2             	sub    %rax,%rdx
    22be:	48 89 d0             	mov    %rdx,%rax
    22c1:	48 c1 e0 02          	shl    $0x2,%rax
    22c5:	48 01 d0             	add    %rdx,%rax
    22c8:	48 01 c0             	add    %rax,%rax
    22cb:	48 29 c1             	sub    %rax,%rcx
    22ce:	48 89 ca             	mov    %rcx,%rdx
    22d1:	8b 45 f4             	mov    -0xc(%rbp),%eax
    22d4:	8d 48 01             	lea    0x1(%rax),%ecx
    22d7:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    22da:	48 b9 d0 2b 00 00 00 	movabs $0x2bd0,%rcx
    22e1:	00 00 00 
    22e4:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    22e8:	48 98                	cltq
    22ea:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    22ee:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    22f2:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    22f9:	66 66 66 
    22fc:	48 89 c8             	mov    %rcx,%rax
    22ff:	48 f7 ea             	imul   %rdx
    2302:	48 89 d0             	mov    %rdx,%rax
    2305:	48 c1 f8 02          	sar    $0x2,%rax
    2309:	48 c1 f9 3f          	sar    $0x3f,%rcx
    230d:	48 89 ca             	mov    %rcx,%rdx
    2310:	48 29 d0             	sub    %rdx,%rax
    2313:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    2317:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    231c:	0f 85 7a ff ff ff    	jne    229c <print_d+0x2c>

  if (v < 0)
    2322:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    2326:	79 32                	jns    235a <print_d+0xea>
    buf[i++] = '-';
    2328:	8b 45 f4             	mov    -0xc(%rbp),%eax
    232b:	8d 50 01             	lea    0x1(%rax),%edx
    232e:	89 55 f4             	mov    %edx,-0xc(%rbp)
    2331:	48 98                	cltq
    2333:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    2338:	eb 20                	jmp    235a <print_d+0xea>
    putc(fd, buf[i]);
    233a:	8b 45 f4             	mov    -0xc(%rbp),%eax
    233d:	48 98                	cltq
    233f:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    2344:	0f be d0             	movsbl %al,%edx
    2347:	8b 45 dc             	mov    -0x24(%rbp),%eax
    234a:	89 d6                	mov    %edx,%esi
    234c:	89 c7                	mov    %eax,%edi
    234e:	48 b8 82 21 00 00 00 	movabs $0x2182,%rax
    2355:	00 00 00 
    2358:	ff d0                	call   *%rax
  while (--i >= 0)
    235a:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    235e:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    2362:	79 d6                	jns    233a <print_d+0xca>
}
    2364:	90                   	nop
    2365:	90                   	nop
    2366:	c9                   	leave
    2367:	c3                   	ret

0000000000002368 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    2368:	f3 0f 1e fa          	endbr64
    236c:	55                   	push   %rbp
    236d:	48 89 e5             	mov    %rsp,%rbp
    2370:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    2377:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    237d:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    2384:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    238b:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    2392:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    2399:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    23a0:	84 c0                	test   %al,%al
    23a2:	74 20                	je     23c4 <printf+0x5c>
    23a4:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    23a8:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    23ac:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    23b0:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    23b4:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    23b8:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    23bc:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    23c0:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    23c4:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    23cb:	00 00 00 
    23ce:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    23d5:	00 00 00 
    23d8:	48 8d 45 10          	lea    0x10(%rbp),%rax
    23dc:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    23e3:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    23ea:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    23f1:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    23f8:	00 00 00 
    23fb:	e9 41 03 00 00       	jmp    2741 <printf+0x3d9>
    if (c != '%') {
    2400:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    2407:	74 24                	je     242d <printf+0xc5>
      putc(fd, c);
    2409:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    240f:	0f be d0             	movsbl %al,%edx
    2412:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    2418:	89 d6                	mov    %edx,%esi
    241a:	89 c7                	mov    %eax,%edi
    241c:	48 b8 82 21 00 00 00 	movabs $0x2182,%rax
    2423:	00 00 00 
    2426:	ff d0                	call   *%rax
      continue;
    2428:	e9 0d 03 00 00       	jmp    273a <printf+0x3d2>
    }
    c = fmt[++i] & 0xff;
    242d:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    2434:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    243a:	48 63 d0             	movslq %eax,%rdx
    243d:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    2444:	48 01 d0             	add    %rdx,%rax
    2447:	0f b6 00             	movzbl (%rax),%eax
    244a:	0f be c0             	movsbl %al,%eax
    244d:	25 ff 00 00 00       	and    $0xff,%eax
    2452:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    2458:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    245f:	0f 84 0f 03 00 00    	je     2774 <printf+0x40c>
      break;
    switch(c) {
    2465:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    246c:	0f 84 74 02 00 00    	je     26e6 <printf+0x37e>
    2472:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    2479:	0f 8c 82 02 00 00    	jl     2701 <printf+0x399>
    247f:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    2486:	0f 8f 75 02 00 00    	jg     2701 <printf+0x399>
    248c:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    2493:	0f 8c 68 02 00 00    	jl     2701 <printf+0x399>
    2499:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    249f:	83 e8 63             	sub    $0x63,%eax
    24a2:	83 f8 15             	cmp    $0x15,%eax
    24a5:	0f 87 56 02 00 00    	ja     2701 <printf+0x399>
    24ab:	89 c0                	mov    %eax,%eax
    24ad:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    24b4:	00 
    24b5:	48 b8 20 2b 00 00 00 	movabs $0x2b20,%rax
    24bc:	00 00 00 
    24bf:	48 01 d0             	add    %rdx,%rax
    24c2:	48 8b 00             	mov    (%rax),%rax
    24c5:	3e ff e0             	notrack jmp *%rax
    case 'c':
      putc(fd, va_arg(ap, int));
    24c8:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    24ce:	83 f8 2f             	cmp    $0x2f,%eax
    24d1:	77 23                	ja     24f6 <printf+0x18e>
    24d3:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    24da:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    24e0:	89 d2                	mov    %edx,%edx
    24e2:	48 01 d0             	add    %rdx,%rax
    24e5:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    24eb:	83 c2 08             	add    $0x8,%edx
    24ee:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    24f4:	eb 12                	jmp    2508 <printf+0x1a0>
    24f6:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    24fd:	48 8d 50 08          	lea    0x8(%rax),%rdx
    2501:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    2508:	8b 00                	mov    (%rax),%eax
    250a:	0f be d0             	movsbl %al,%edx
    250d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    2513:	89 d6                	mov    %edx,%esi
    2515:	89 c7                	mov    %eax,%edi
    2517:	48 b8 82 21 00 00 00 	movabs $0x2182,%rax
    251e:	00 00 00 
    2521:	ff d0                	call   *%rax
      break;
    2523:	e9 12 02 00 00       	jmp    273a <printf+0x3d2>
    case 'd':
      print_d(fd, va_arg(ap, int));
    2528:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    252e:	83 f8 2f             	cmp    $0x2f,%eax
    2531:	77 23                	ja     2556 <printf+0x1ee>
    2533:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    253a:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    2540:	89 d2                	mov    %edx,%edx
    2542:	48 01 d0             	add    %rdx,%rax
    2545:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    254b:	83 c2 08             	add    $0x8,%edx
    254e:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    2554:	eb 12                	jmp    2568 <printf+0x200>
    2556:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    255d:	48 8d 50 08          	lea    0x8(%rax),%rdx
    2561:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    2568:	8b 10                	mov    (%rax),%edx
    256a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    2570:	89 d6                	mov    %edx,%esi
    2572:	89 c7                	mov    %eax,%edi
    2574:	48 b8 70 22 00 00 00 	movabs $0x2270,%rax
    257b:	00 00 00 
    257e:	ff d0                	call   *%rax
      break;
    2580:	e9 b5 01 00 00       	jmp    273a <printf+0x3d2>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    2585:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    258b:	83 f8 2f             	cmp    $0x2f,%eax
    258e:	77 23                	ja     25b3 <printf+0x24b>
    2590:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    2597:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    259d:	89 d2                	mov    %edx,%edx
    259f:	48 01 d0             	add    %rdx,%rax
    25a2:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    25a8:	83 c2 08             	add    $0x8,%edx
    25ab:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    25b1:	eb 12                	jmp    25c5 <printf+0x25d>
    25b3:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    25ba:	48 8d 50 08          	lea    0x8(%rax),%rdx
    25be:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    25c5:	8b 10                	mov    (%rax),%edx
    25c7:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    25cd:	89 d6                	mov    %edx,%esi
    25cf:	89 c7                	mov    %eax,%edi
    25d1:	48 b8 13 22 00 00 00 	movabs $0x2213,%rax
    25d8:	00 00 00 
    25db:	ff d0                	call   *%rax
      break;
    25dd:	e9 58 01 00 00       	jmp    273a <printf+0x3d2>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    25e2:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    25e8:	83 f8 2f             	cmp    $0x2f,%eax
    25eb:	77 23                	ja     2610 <printf+0x2a8>
    25ed:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    25f4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    25fa:	89 d2                	mov    %edx,%edx
    25fc:	48 01 d0             	add    %rdx,%rax
    25ff:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    2605:	83 c2 08             	add    $0x8,%edx
    2608:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    260e:	eb 12                	jmp    2622 <printf+0x2ba>
    2610:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    2617:	48 8d 50 08          	lea    0x8(%rax),%rdx
    261b:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    2622:	48 8b 10             	mov    (%rax),%rdx
    2625:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    262b:	48 89 d6             	mov    %rdx,%rsi
    262e:	89 c7                	mov    %eax,%edi
    2630:	48 b8 b6 21 00 00 00 	movabs $0x21b6,%rax
    2637:	00 00 00 
    263a:	ff d0                	call   *%rax
      break;
    263c:	e9 f9 00 00 00       	jmp    273a <printf+0x3d2>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    2641:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    2647:	83 f8 2f             	cmp    $0x2f,%eax
    264a:	77 23                	ja     266f <printf+0x307>
    264c:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    2653:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    2659:	89 d2                	mov    %edx,%edx
    265b:	48 01 d0             	add    %rdx,%rax
    265e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    2664:	83 c2 08             	add    $0x8,%edx
    2667:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    266d:	eb 12                	jmp    2681 <printf+0x319>
    266f:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    2676:	48 8d 50 08          	lea    0x8(%rax),%rdx
    267a:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    2681:	48 8b 00             	mov    (%rax),%rax
    2684:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    268b:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    2692:	00 
    2693:	75 41                	jne    26d6 <printf+0x36e>
        s = "(null)";
    2695:	48 b8 18 2b 00 00 00 	movabs $0x2b18,%rax
    269c:	00 00 00 
    269f:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    26a6:	eb 2e                	jmp    26d6 <printf+0x36e>
        putc(fd, *(s++));
    26a8:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    26af:	48 8d 50 01          	lea    0x1(%rax),%rdx
    26b3:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    26ba:	0f b6 00             	movzbl (%rax),%eax
    26bd:	0f be d0             	movsbl %al,%edx
    26c0:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    26c6:	89 d6                	mov    %edx,%esi
    26c8:	89 c7                	mov    %eax,%edi
    26ca:	48 b8 82 21 00 00 00 	movabs $0x2182,%rax
    26d1:	00 00 00 
    26d4:	ff d0                	call   *%rax
      while (*s)
    26d6:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    26dd:	0f b6 00             	movzbl (%rax),%eax
    26e0:	84 c0                	test   %al,%al
    26e2:	75 c4                	jne    26a8 <printf+0x340>
      break;
    26e4:	eb 54                	jmp    273a <printf+0x3d2>
    case '%':
      putc(fd, '%');
    26e6:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    26ec:	be 25 00 00 00       	mov    $0x25,%esi
    26f1:	89 c7                	mov    %eax,%edi
    26f3:	48 b8 82 21 00 00 00 	movabs $0x2182,%rax
    26fa:	00 00 00 
    26fd:	ff d0                	call   *%rax
      break;
    26ff:	eb 39                	jmp    273a <printf+0x3d2>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    2701:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    2707:	be 25 00 00 00       	mov    $0x25,%esi
    270c:	89 c7                	mov    %eax,%edi
    270e:	48 b8 82 21 00 00 00 	movabs $0x2182,%rax
    2715:	00 00 00 
    2718:	ff d0                	call   *%rax
      putc(fd, c);
    271a:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    2720:	0f be d0             	movsbl %al,%edx
    2723:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    2729:	89 d6                	mov    %edx,%esi
    272b:	89 c7                	mov    %eax,%edi
    272d:	48 b8 82 21 00 00 00 	movabs $0x2182,%rax
    2734:	00 00 00 
    2737:	ff d0                	call   *%rax
      break;
    2739:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    273a:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    2741:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    2747:	48 63 d0             	movslq %eax,%rdx
    274a:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    2751:	48 01 d0             	add    %rdx,%rax
    2754:	0f b6 00             	movzbl (%rax),%eax
    2757:	0f be c0             	movsbl %al,%eax
    275a:	25 ff 00 00 00       	and    $0xff,%eax
    275f:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    2765:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    276c:	0f 85 8e fc ff ff    	jne    2400 <printf+0x98>
    }
  }
}
    2772:	eb 01                	jmp    2775 <printf+0x40d>
      break;
    2774:	90                   	nop
}
    2775:	90                   	nop
    2776:	c9                   	leave
    2777:	c3                   	ret

0000000000002778 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    2778:	f3 0f 1e fa          	endbr64
    277c:	55                   	push   %rbp
    277d:	48 89 e5             	mov    %rsp,%rbp
    2780:	48 83 ec 18          	sub    $0x18,%rsp
    2784:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    2788:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    278c:	48 83 e8 10          	sub    $0x10,%rax
    2790:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    2794:	48 b8 10 3b 02 00 00 	movabs $0x23b10,%rax
    279b:	00 00 00 
    279e:	48 8b 00             	mov    (%rax),%rax
    27a1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    27a5:	eb 2f                	jmp    27d6 <free+0x5e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    27a7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    27ab:	48 8b 00             	mov    (%rax),%rax
    27ae:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    27b2:	72 17                	jb     27cb <free+0x53>
    27b4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    27b8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    27bc:	72 2f                	jb     27ed <free+0x75>
    27be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    27c2:	48 8b 00             	mov    (%rax),%rax
    27c5:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    27c9:	72 22                	jb     27ed <free+0x75>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    27cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    27cf:	48 8b 00             	mov    (%rax),%rax
    27d2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    27d6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    27da:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    27de:	73 c7                	jae    27a7 <free+0x2f>
    27e0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    27e4:	48 8b 00             	mov    (%rax),%rax
    27e7:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    27eb:	73 ba                	jae    27a7 <free+0x2f>
      break;
  if(bp + bp->s.size == p->s.ptr){
    27ed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    27f1:	8b 40 08             	mov    0x8(%rax),%eax
    27f4:	89 c0                	mov    %eax,%eax
    27f6:	48 c1 e0 04          	shl    $0x4,%rax
    27fa:	48 89 c2             	mov    %rax,%rdx
    27fd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2801:	48 01 c2             	add    %rax,%rdx
    2804:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2808:	48 8b 00             	mov    (%rax),%rax
    280b:	48 39 c2             	cmp    %rax,%rdx
    280e:	75 2d                	jne    283d <free+0xc5>
    bp->s.size += p->s.ptr->s.size;
    2810:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2814:	8b 50 08             	mov    0x8(%rax),%edx
    2817:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    281b:	48 8b 00             	mov    (%rax),%rax
    281e:	8b 40 08             	mov    0x8(%rax),%eax
    2821:	01 c2                	add    %eax,%edx
    2823:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2827:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    282a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    282e:	48 8b 00             	mov    (%rax),%rax
    2831:	48 8b 10             	mov    (%rax),%rdx
    2834:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2838:	48 89 10             	mov    %rdx,(%rax)
    283b:	eb 0e                	jmp    284b <free+0xd3>
  } else
    bp->s.ptr = p->s.ptr;
    283d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2841:	48 8b 10             	mov    (%rax),%rdx
    2844:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2848:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    284b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    284f:	8b 40 08             	mov    0x8(%rax),%eax
    2852:	89 c0                	mov    %eax,%eax
    2854:	48 c1 e0 04          	shl    $0x4,%rax
    2858:	48 89 c2             	mov    %rax,%rdx
    285b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    285f:	48 01 d0             	add    %rdx,%rax
    2862:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    2866:	75 27                	jne    288f <free+0x117>
    p->s.size += bp->s.size;
    2868:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    286c:	8b 50 08             	mov    0x8(%rax),%edx
    286f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2873:	8b 40 08             	mov    0x8(%rax),%eax
    2876:	01 c2                	add    %eax,%edx
    2878:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    287c:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    287f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2883:	48 8b 10             	mov    (%rax),%rdx
    2886:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    288a:	48 89 10             	mov    %rdx,(%rax)
    288d:	eb 0b                	jmp    289a <free+0x122>
  } else
    p->s.ptr = bp;
    288f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2893:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    2897:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    289a:	48 ba 10 3b 02 00 00 	movabs $0x23b10,%rdx
    28a1:	00 00 00 
    28a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    28a8:	48 89 02             	mov    %rax,(%rdx)
}
    28ab:	90                   	nop
    28ac:	c9                   	leave
    28ad:	c3                   	ret

00000000000028ae <morecore>:

static Header*
morecore(uint nu)
{
    28ae:	f3 0f 1e fa          	endbr64
    28b2:	55                   	push   %rbp
    28b3:	48 89 e5             	mov    %rsp,%rbp
    28b6:	48 83 ec 20          	sub    $0x20,%rsp
    28ba:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    28bd:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    28c4:	77 07                	ja     28cd <morecore+0x1f>
    nu = 4096;
    28c6:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    28cd:	8b 45 ec             	mov    -0x14(%rbp),%eax
    28d0:	48 c1 e0 04          	shl    $0x4,%rax
    28d4:	48 89 c7             	mov    %rax,%rdi
    28d7:	48 b8 34 21 00 00 00 	movabs $0x2134,%rax
    28de:	00 00 00 
    28e1:	ff d0                	call   *%rax
    28e3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    28e7:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    28ec:	75 07                	jne    28f5 <morecore+0x47>
    return 0;
    28ee:	b8 00 00 00 00       	mov    $0x0,%eax
    28f3:	eb 36                	jmp    292b <morecore+0x7d>
  hp = (Header*)p;
    28f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    28f9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    28fd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2901:	8b 55 ec             	mov    -0x14(%rbp),%edx
    2904:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    2907:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    290b:	48 83 c0 10          	add    $0x10,%rax
    290f:	48 89 c7             	mov    %rax,%rdi
    2912:	48 b8 78 27 00 00 00 	movabs $0x2778,%rax
    2919:	00 00 00 
    291c:	ff d0                	call   *%rax
  return freep;
    291e:	48 b8 10 3b 02 00 00 	movabs $0x23b10,%rax
    2925:	00 00 00 
    2928:	48 8b 00             	mov    (%rax),%rax
}
    292b:	c9                   	leave
    292c:	c3                   	ret

000000000000292d <malloc>:

void*
malloc(uint nbytes)
{
    292d:	f3 0f 1e fa          	endbr64
    2931:	55                   	push   %rbp
    2932:	48 89 e5             	mov    %rsp,%rbp
    2935:	48 83 ec 30          	sub    $0x30,%rsp
    2939:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    293c:	8b 45 dc             	mov    -0x24(%rbp),%eax
    293f:	48 83 c0 0f          	add    $0xf,%rax
    2943:	48 c1 e8 04          	shr    $0x4,%rax
    2947:	83 c0 01             	add    $0x1,%eax
    294a:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    294d:	48 b8 10 3b 02 00 00 	movabs $0x23b10,%rax
    2954:	00 00 00 
    2957:	48 8b 00             	mov    (%rax),%rax
    295a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    295e:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    2963:	75 4a                	jne    29af <malloc+0x82>
    base.s.ptr = freep = prevp = &base;
    2965:	48 b8 00 3b 02 00 00 	movabs $0x23b00,%rax
    296c:	00 00 00 
    296f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    2973:	48 ba 10 3b 02 00 00 	movabs $0x23b10,%rdx
    297a:	00 00 00 
    297d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2981:	48 89 02             	mov    %rax,(%rdx)
    2984:	48 b8 10 3b 02 00 00 	movabs $0x23b10,%rax
    298b:	00 00 00 
    298e:	48 8b 00             	mov    (%rax),%rax
    2991:	48 ba 00 3b 02 00 00 	movabs $0x23b00,%rdx
    2998:	00 00 00 
    299b:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    299e:	48 b8 00 3b 02 00 00 	movabs $0x23b00,%rax
    29a5:	00 00 00 
    29a8:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    29af:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    29b3:	48 8b 00             	mov    (%rax),%rax
    29b6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    29ba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    29be:	8b 40 08             	mov    0x8(%rax),%eax
    29c1:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    29c4:	72 65                	jb     2a2b <malloc+0xfe>
      if(p->s.size == nunits)
    29c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    29ca:	8b 40 08             	mov    0x8(%rax),%eax
    29cd:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    29d0:	75 10                	jne    29e2 <malloc+0xb5>
        prevp->s.ptr = p->s.ptr;
    29d2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    29d6:	48 8b 10             	mov    (%rax),%rdx
    29d9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    29dd:	48 89 10             	mov    %rdx,(%rax)
    29e0:	eb 2e                	jmp    2a10 <malloc+0xe3>
      else {
        p->s.size -= nunits;
    29e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    29e6:	8b 40 08             	mov    0x8(%rax),%eax
    29e9:	2b 45 ec             	sub    -0x14(%rbp),%eax
    29ec:	89 c2                	mov    %eax,%edx
    29ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    29f2:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    29f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    29f9:	8b 40 08             	mov    0x8(%rax),%eax
    29fc:	89 c0                	mov    %eax,%eax
    29fe:	48 c1 e0 04          	shl    $0x4,%rax
    2a02:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    2a06:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2a0a:	8b 55 ec             	mov    -0x14(%rbp),%edx
    2a0d:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    2a10:	48 ba 10 3b 02 00 00 	movabs $0x23b10,%rdx
    2a17:	00 00 00 
    2a1a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2a1e:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    2a21:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2a25:	48 83 c0 10          	add    $0x10,%rax
    2a29:	eb 4e                	jmp    2a79 <malloc+0x14c>
    }
    if(p == freep)
    2a2b:	48 b8 10 3b 02 00 00 	movabs $0x23b10,%rax
    2a32:	00 00 00 
    2a35:	48 8b 00             	mov    (%rax),%rax
    2a38:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    2a3c:	75 23                	jne    2a61 <malloc+0x134>
      if((p = morecore(nunits)) == 0)
    2a3e:	8b 45 ec             	mov    -0x14(%rbp),%eax
    2a41:	89 c7                	mov    %eax,%edi
    2a43:	48 b8 ae 28 00 00 00 	movabs $0x28ae,%rax
    2a4a:	00 00 00 
    2a4d:	ff d0                	call   *%rax
    2a4f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    2a53:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    2a58:	75 07                	jne    2a61 <malloc+0x134>
        return 0;
    2a5a:	b8 00 00 00 00       	mov    $0x0,%eax
    2a5f:	eb 18                	jmp    2a79 <malloc+0x14c>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    2a61:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2a65:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    2a69:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2a6d:	48 8b 00             	mov    (%rax),%rax
    2a70:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    2a74:	e9 41 ff ff ff       	jmp    29ba <malloc+0x8d>
  }
}
    2a79:	c9                   	leave
    2a7a:	c3                   	ret
