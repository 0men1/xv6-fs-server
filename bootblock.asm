
bootblocktmp.o:     file format elf32-i386


Disassembly of section .text:

00007c00 <start>:
    7c00:	fa                   	cli
    7c01:	31 c0                	xor    %eax,%eax
    7c03:	8e d8                	mov    %eax,%ds
    7c05:	8e c0                	mov    %eax,%es
    7c07:	8e d0                	mov    %eax,%ss

00007c09 <seta20.1>:
    7c09:	e4 64                	in     $0x64,%al
    7c0b:	a8 02                	test   $0x2,%al
    7c0d:	75 fa                	jne    7c09 <seta20.1>
    7c0f:	b0 d1                	mov    $0xd1,%al
    7c11:	e6 64                	out    %al,$0x64

00007c13 <seta20.2>:
    7c13:	e4 64                	in     $0x64,%al
    7c15:	a8 02                	test   $0x2,%al
    7c17:	75 fa                	jne    7c13 <seta20.2>
    7c19:	b0 df                	mov    $0xdf,%al
    7c1b:	e6 60                	out    %al,$0x60
    7c1d:	0f 01 16             	lgdtl  (%esi)
    7c20:	68 7c 0f 20 c0       	push   $0xc0200f7c
    7c25:	66 83 c8 01          	or     $0x1,%ax
    7c29:	0f 22 c0             	mov    %eax,%cr0
    7c2c:	ea                   	.byte 0xea
    7c2d:	31 7c 08 00          	xor    %edi,0x0(%eax,%ecx,1)

00007c31 <start32>:
    7c31:	66 b8 10 00          	mov    $0x10,%ax
    7c35:	8e d8                	mov    %eax,%ds
    7c37:	8e c0                	mov    %eax,%es
    7c39:	8e d0                	mov    %eax,%ss
    7c3b:	66 b8 00 00          	mov    $0x0,%ax
    7c3f:	8e e0                	mov    %eax,%fs
    7c41:	8e e8                	mov    %eax,%gs
    7c43:	bc 00 7c 00 00       	mov    $0x7c00,%esp
    7c48:	e8 d4 00 00 00       	call   7d21 <bootmain>

00007c4d <spin>:
    7c4d:	eb fe                	jmp    7c4d <spin>
    7c4f:	90                   	nop

00007c50 <gdt>:
	...
    7c58:	ff                   	(bad)
    7c59:	ff 00                	incl   (%eax)
    7c5b:	00 00                	add    %al,(%eax)
    7c5d:	9a cf 00 ff ff 00 00 	lcall  $0x0,$0xffff00cf
    7c64:	00                   	.byte 0
    7c65:	92                   	xchg   %eax,%edx
    7c66:	cf                   	iret
	...

00007c68 <gdtdesc>:
    7c68:	17                   	pop    %ss
    7c69:	00 50 7c             	add    %dl,0x7c(%eax)
	...

00007c6e <waitdisk>:
    7c6e:	ba f7 01 00 00       	mov    $0x1f7,%edx
    7c73:	ec                   	in     (%dx),%al
    7c74:	83 e0 c0             	and    $0xffffffc0,%eax
    7c77:	3c 40                	cmp    $0x40,%al
    7c79:	75 f8                	jne    7c73 <waitdisk+0x5>
    7c7b:	c3                   	ret

00007c7c <readsect>:
    7c7c:	57                   	push   %edi
    7c7d:	53                   	push   %ebx
    7c7e:	8b 5c 24 10          	mov    0x10(%esp),%ebx
    7c82:	e8 e7 ff ff ff       	call   7c6e <waitdisk>
    7c87:	b8 01 00 00 00       	mov    $0x1,%eax
    7c8c:	ba f2 01 00 00       	mov    $0x1f2,%edx
    7c91:	ee                   	out    %al,(%dx)
    7c92:	ba f3 01 00 00       	mov    $0x1f3,%edx
    7c97:	89 d8                	mov    %ebx,%eax
    7c99:	ee                   	out    %al,(%dx)
    7c9a:	89 d8                	mov    %ebx,%eax
    7c9c:	c1 e8 08             	shr    $0x8,%eax
    7c9f:	ba f4 01 00 00       	mov    $0x1f4,%edx
    7ca4:	ee                   	out    %al,(%dx)
    7ca5:	89 d8                	mov    %ebx,%eax
    7ca7:	c1 e8 10             	shr    $0x10,%eax
    7caa:	ba f5 01 00 00       	mov    $0x1f5,%edx
    7caf:	ee                   	out    %al,(%dx)
    7cb0:	89 d8                	mov    %ebx,%eax
    7cb2:	c1 e8 18             	shr    $0x18,%eax
    7cb5:	83 c8 e0             	or     $0xffffffe0,%eax
    7cb8:	ba f6 01 00 00       	mov    $0x1f6,%edx
    7cbd:	ee                   	out    %al,(%dx)
    7cbe:	b8 20 00 00 00       	mov    $0x20,%eax
    7cc3:	ba f7 01 00 00       	mov    $0x1f7,%edx
    7cc8:	ee                   	out    %al,(%dx)
    7cc9:	e8 a0 ff ff ff       	call   7c6e <waitdisk>
    7cce:	8b 7c 24 0c          	mov    0xc(%esp),%edi
    7cd2:	b9 80 00 00 00       	mov    $0x80,%ecx
    7cd7:	ba f0 01 00 00       	mov    $0x1f0,%edx
    7cdc:	fc                   	cld
    7cdd:	f3 6d                	rep insl (%dx),%es:(%edi)
    7cdf:	5b                   	pop    %ebx
    7ce0:	5f                   	pop    %edi
    7ce1:	c3                   	ret

00007ce2 <readseg>:
    7ce2:	57                   	push   %edi
    7ce3:	56                   	push   %esi
    7ce4:	53                   	push   %ebx
    7ce5:	8b 5c 24 10          	mov    0x10(%esp),%ebx
    7ce9:	8b 74 24 18          	mov    0x18(%esp),%esi
    7ced:	89 df                	mov    %ebx,%edi
    7cef:	03 7c 24 14          	add    0x14(%esp),%edi
    7cf3:	89 f0                	mov    %esi,%eax
    7cf5:	25 ff 01 00 00       	and    $0x1ff,%eax
    7cfa:	29 c3                	sub    %eax,%ebx
    7cfc:	c1 ee 09             	shr    $0x9,%esi
    7cff:	83 c6 01             	add    $0x1,%esi
    7d02:	39 fb                	cmp    %edi,%ebx
    7d04:	73 17                	jae    7d1d <readseg+0x3b>
    7d06:	56                   	push   %esi
    7d07:	53                   	push   %ebx
    7d08:	e8 6f ff ff ff       	call   7c7c <readsect>
    7d0d:	81 c3 00 02 00 00    	add    $0x200,%ebx
    7d13:	83 c6 01             	add    $0x1,%esi
    7d16:	83 c4 08             	add    $0x8,%esp
    7d19:	39 fb                	cmp    %edi,%ebx
    7d1b:	72 e9                	jb     7d06 <readseg+0x24>
    7d1d:	5b                   	pop    %ebx
    7d1e:	5e                   	pop    %esi
    7d1f:	5f                   	pop    %edi
    7d20:	c3                   	ret

00007d21 <bootmain>:
    7d21:	57                   	push   %edi
    7d22:	56                   	push   %esi
    7d23:	53                   	push   %ebx
    7d24:	6a 00                	push   $0x0
    7d26:	68 00 20 00 00       	push   $0x2000
    7d2b:	68 00 00 01 00       	push   $0x10000
    7d30:	e8 ad ff ff ff       	call   7ce2 <readseg>
    7d35:	83 c4 0c             	add    $0xc,%esp
    7d38:	b8 00 00 01 00       	mov    $0x10000,%eax
    7d3d:	eb 0a                	jmp    7d49 <bootmain+0x28>
    7d3f:	83 c0 04             	add    $0x4,%eax
    7d42:	3d 00 20 01 00       	cmp    $0x12000,%eax
    7d47:	74 2f                	je     7d78 <bootmain+0x57>
    7d49:	89 c3                	mov    %eax,%ebx
    7d4b:	81 38 02 b0 ad 1b    	cmpl   $0x1badb002,(%eax)
    7d51:	75 ec                	jne    7d3f <bootmain+0x1e>
    7d53:	8b 50 08             	mov    0x8(%eax),%edx
    7d56:	03 50 04             	add    0x4(%eax),%edx
    7d59:	81 fa fe 4f 52 e4    	cmp    $0xe4524ffe,%edx
    7d5f:	75 de                	jne    7d3f <bootmain+0x1e>
    7d61:	f6 40 06 01          	testb  $0x1,0x6(%eax)
    7d65:	74 11                	je     7d78 <bootmain+0x57>
    7d67:	8b 50 10             	mov    0x10(%eax),%edx
    7d6a:	8b 48 0c             	mov    0xc(%eax),%ecx
    7d6d:	39 d1                	cmp    %edx,%ecx
    7d6f:	72 07                	jb     7d78 <bootmain+0x57>
    7d71:	8b 70 14             	mov    0x14(%eax),%esi
    7d74:	39 d6                	cmp    %edx,%esi
    7d76:	73 04                	jae    7d7c <bootmain+0x5b>
    7d78:	5b                   	pop    %ebx
    7d79:	5e                   	pop    %esi
    7d7a:	5f                   	pop    %edi
    7d7b:	c3                   	ret
    7d7c:	8d 84 02 00 00 ff ff 	lea    -0x10000(%edx,%eax,1),%eax
    7d83:	29 c8                	sub    %ecx,%eax
    7d85:	50                   	push   %eax
    7d86:	29 d6                	sub    %edx,%esi
    7d88:	56                   	push   %esi
    7d89:	52                   	push   %edx
    7d8a:	e8 53 ff ff ff       	call   7ce2 <readseg>
    7d8f:	8b 4b 18             	mov    0x18(%ebx),%ecx
    7d92:	8b 43 14             	mov    0x14(%ebx),%eax
    7d95:	83 c4 0c             	add    $0xc,%esp
    7d98:	39 c8                	cmp    %ecx,%eax
    7d9a:	73 0c                	jae    7da8 <bootmain+0x87>
    7d9c:	29 c1                	sub    %eax,%ecx
    7d9e:	89 c7                	mov    %eax,%edi
    7da0:	b8 00 00 00 00       	mov    $0x0,%eax
    7da5:	fc                   	cld
    7da6:	f3 aa                	rep stos %al,%es:(%edi)
    7da8:	ff 53 1c             	call   *0x1c(%ebx)
    7dab:	eb cb                	jmp    7d78 <bootmain+0x57>
