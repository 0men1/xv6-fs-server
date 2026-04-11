
kernel:     file format elf64-x86-64


Disassembly of section .text:

ffff800000100000 <begin>:
ffff800000100000:	02 b0 ad 1b 00 00    	add    0x1bad(%rax),%dh
ffff800000100006:	01 00                	add    %eax,(%rax)
ffff800000100008:	fe 4f 51             	decb   0x51(%rdi)
ffff80000010000b:	e4 00                	in     $0x0,%al
ffff80000010000d:	00 10                	add    %dl,(%rax)
ffff80000010000f:	00 00                	add    %al,(%rax)
ffff800000100011:	00 10                	add    %dl,(%rax)
ffff800000100013:	00 00                	add    %al,(%rax)
ffff800000100015:	e0 10                	loopne ffff800000100027 <mboot_entry+0x7>
ffff800000100017:	00 00                	add    %al,(%rax)
ffff800000100019:	d0 11                	rclb   $1,(%rcx)
ffff80000010001b:	00 20                	add    %ah,(%rax)
ffff80000010001d:	00 10                	add    %dl,(%rax)
	...

ffff800000100020 <mboot_entry>:
  .long mboot_entry_addr

.code32
mboot_entry:
# zero 2 pages for our bootstrap page tables
  xor     %eax, %eax    # value=0
ffff800000100020:	31 c0                	xor    %eax,%eax
  mov     $0x1000, %edi # starting at 4096
ffff800000100022:	bf 00 10 00 00       	mov    $0x1000,%edi
  mov     $0x2000, %ecx # size=8192
ffff800000100027:	b9 00 20 00 00       	mov    $0x2000,%ecx
  rep     stosb         # memset(4096, 0, 8192)
ffff80000010002c:	f3 aa                	rep stos %al,(%rdi)

# map both virtual address 0 and KERNBASE to the same PDPT
# note: 32-bit operations manipulating 64-bit page table
# PML4T[0] -> 0x2000 (PDPT)
# PML4T[256] -> 0x2000 (PDPT)
  mov     $(0x2000 | PTE_P | PTE_W), %eax
ffff80000010002e:	b8 03 20 00 00       	mov    $0x2003,%eax
  mov     %eax, 0x1000  # PML4T[0]
ffff800000100033:	a3 00 10 00 00 a3 00 	movabs %eax,0x1800a300001000
ffff80000010003a:	18 00 
  mov     %eax, 0x1800  # PML4T[256]
ffff80000010003c:	00 b8 83 00 00 00    	add    %bh,0x83(%rax)

# PDPT[0] -> 0x0 (1 GB flat map page)
  mov     $(0x0 | PTE_P | PTE_PS | PTE_W), %eax
  mov     %eax, 0x2000  # PDPT[0]
ffff800000100042:	a3                   	.byte 0xa3
ffff800000100043:	00 20                	add    %ah,(%rax)
ffff800000100045:	00 00                	add    %al,(%rax)

# Clear ebx for initial processor boot.
# When secondary processors boot, they'll call through
# entry32mp (from entryother), but with a nonzero ebx.
# We'll reuse these bootstrap pagetables and GDT.
  xor     %ebx, %ebx
ffff800000100047:	31 db                	xor    %ebx,%ebx

ffff800000100049 <entry32mp>:

.global entry32mp
entry32mp:
# CR3 -> 0x1000 (PML4T)
  mov     $0x1000, %eax
ffff800000100049:	b8 00 10 00 00       	mov    $0x1000,%eax
  mov     %eax, %cr3
ffff80000010004e:	0f 22 d8             	mov    %rax,%cr3

  lgdt    (gdtr64 - mboot_header + mboot_load_addr)
ffff800000100051:	0f 01 15 90 00 10 00 	lgdt   0x100090(%rip)        # ffff8000002000e8 <end+0xe30e8>

# PAE is required for 64-bit paging: CR4.PAE=1
  mov     %cr4, %eax
ffff800000100058:	0f 20 e0             	mov    %cr4,%rax
  bts     $5, %eax
ffff80000010005b:	0f ba e8 05          	bts    $0x5,%eax
  mov     %eax, %cr4
ffff80000010005f:	0f 22 e0             	mov    %rax,%cr4

# access EFER Model specific register
  mov     $MSR_EFER, %ecx
ffff800000100062:	b9 80 00 00 c0       	mov    $0xc0000080,%ecx
  rdmsr
ffff800000100067:	0f 32                	rdmsr
  bts     $0, %eax #enable system call extensions
ffff800000100069:	0f ba e8 00          	bts    $0x0,%eax
  bts     $8, %eax #enable long mode
ffff80000010006d:	0f ba e8 08          	bts    $0x8,%eax
  wrmsr
ffff800000100071:	0f 30                	wrmsr

# enable paging
  mov     %cr0, %eax
ffff800000100073:	0f 20 c0             	mov    %cr0,%rax
  orl     $(CR0_PG | CR0_WP | CR0_MP), %eax
ffff800000100076:	0d 02 00 01 80       	or     $0x80010002,%eax
  mov     %eax, %cr0
ffff80000010007b:	0f 22 c0             	mov    %rax,%cr0

# shift to 64bit segment
  ljmp    $8, $(entry64low - mboot_header + mboot_load_addr)
ffff80000010007e:	ea                   	(bad)
ffff80000010007f:	c0 00 10             	rolb   $0x10,(%rax)
ffff800000100082:	00 08                	add    %cl,(%rax)
ffff800000100084:	00 66 66             	add    %ah,0x66(%rsi)
ffff800000100087:	2e 0f 1f 84 00 00 00 	cs nopl 0x0(%rax,%rax,1)
ffff80000010008e:	00 00 

ffff800000100090 <gdtr64>:
ffff800000100090:	17                   	(bad)
ffff800000100091:	00 a0 00 10 00 00    	add    %ah,0x1000(%rax)
ffff800000100097:	00 00                	add    %al,(%rax)
ffff800000100099:	00 90 0f 1f 44 00    	add    %dl,0x441f0f(%rax)
	...

ffff8000001000a0 <gdt64_begin>:
	...
ffff8000001000ac:	00 98 20 00 00 00    	add    %bl,0x20(%rax)
ffff8000001000b2:	00 00                	add    %al,(%rax)
ffff8000001000b4:	00                   	.byte 0
ffff8000001000b5:	90                   	nop
	...

ffff8000001000b8 <gdt64_end>:
ffff8000001000b8:	90                   	nop
ffff8000001000b9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

ffff8000001000c0 <entry64low>:
gdt64_end:

.align 16
.code64
entry64low:
  movabs  $entry64high, %rax
ffff8000001000c0:	48 b8 cc 00 10 00 00 	movabs $0xffff8000001000cc,%rax
ffff8000001000c7:	80 ff ff 
  jmp     *%rax
ffff8000001000ca:	ff e0                	jmp    *%rax

ffff8000001000cc <_start>:
.global _start
_start:
entry64high:

# ensure data segment registers are sane
  xor     %rax, %rax
ffff8000001000cc:	48 31 c0             	xor    %rax,%rax
  mov     %ax, %ss
ffff8000001000cf:	8e d0                	mov    %eax,%ss
  mov     %ax, %ds
ffff8000001000d1:	8e d8                	mov    %eax,%ds
  mov     %ax, %es
ffff8000001000d3:	8e c0                	mov    %eax,%es
  mov     %ax, %fs
ffff8000001000d5:	8e e0                	mov    %eax,%fs
  mov     %ax, %gs
ffff8000001000d7:	8e e8                	mov    %eax,%gs
  # mov     %cr4, %rax
  # or      $(CR4_PAE | CR4_OSXFSR | CR4_OSXMMEXCPT) , %rax
  # mov     %rax, %cr4

# check to see if we're booting a secondary core
  test    %ebx, %ebx
ffff8000001000d9:	85 db                	test   %ebx,%ebx
  jnz     entry64mp  # jump if booting a secondary code
ffff8000001000db:	75 14                	jne    ffff8000001000f1 <entry64mp>
# setup initial stack
  movabs  $0xFFFF800000010000, %rax
ffff8000001000dd:	48 b8 00 00 01 00 00 	movabs $0xffff800000010000,%rax
ffff8000001000e4:	80 ff ff 
  mov     %rax, %rsp
ffff8000001000e7:	48 89 c4             	mov    %rax,%rsp

# enter main()
  jmp     main  # end of initial (the first) core ASM
ffff8000001000ea:	e9 fb 52 00 00       	jmp    ffff8000001053ea <main>

ffff8000001000ef <__deadloop>:

.global __deadloop
__deadloop:
# we should never return here...
  jmp     .
ffff8000001000ef:	eb fe                	jmp    ffff8000001000ef <__deadloop>

ffff8000001000f1 <entry64mp>:

entry64mp:
# obtain kstack from data block before entryother
  mov     $0x7000, %rax
ffff8000001000f1:	48 c7 c0 00 70 00 00 	mov    $0x7000,%rax
  mov     -16(%rax), %rsp
ffff8000001000f8:	48 8b 60 f0          	mov    -0x10(%rax),%rsp
  jmp     mpenter  # end of secondary code ASM
ffff8000001000fc:	e9 0d 54 00 00       	jmp    ffff80000010550e <mpenter>

ffff800000100101 <wrmsr>:

.global wrmsr
wrmsr:
  mov     %rdi, %rcx     # arg0 -> msrnum
ffff800000100101:	48 89 f9             	mov    %rdi,%rcx
  mov     %rsi, %rax     # val.low -> eax
ffff800000100104:	48 89 f0             	mov    %rsi,%rax
  shr     $32, %rsi
ffff800000100107:	48 c1 ee 20          	shr    $0x20,%rsi
  mov     %rsi, %rdx     # val.high -> edx
ffff80000010010b:	48 89 f2             	mov    %rsi,%rdx
  wrmsr
ffff80000010010e:	0f 30                	wrmsr
  retq
ffff800000100110:	c3                   	ret

ffff800000100111 <ignore_sysret>:

.global ignore_sysret
ignore_sysret: #return error code 38, meaning function unimplemented
  mov     $-38, %rax
ffff800000100111:	48 c7 c0 da ff ff ff 	mov    $0xffffffffffffffda,%rax
  sysretq
ffff800000100118:	48 0f 07             	sysretq

ffff80000010011b <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
ffff80000010011b:	55                   	push   %rbp
ffff80000010011c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010011f:	48 83 ec 10          	sub    $0x10,%rsp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
ffff800000100123:	48 ba 58 c0 10 00 00 	movabs $0xffff80000010c058,%rdx
ffff80000010012a:	80 ff ff 
ffff80000010012d:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff800000100134:	80 ff ff 
ffff800000100137:	48 89 d6             	mov    %rdx,%rsi
ffff80000010013a:	48 89 c7             	mov    %rax,%rdi
ffff80000010013d:	48 b8 05 77 10 00 00 	movabs $0xffff800000107705,%rax
ffff800000100144:	80 ff ff 
ffff800000100147:	ff d0                	call   *%rax
//PAGEBREAK!

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
ffff800000100149:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff800000100150:	80 ff ff 
ffff800000100153:	48 b9 08 31 11 00 00 	movabs $0xffff800000113108,%rcx
ffff80000010015a:	80 ff ff 
ffff80000010015d:	48 89 88 a0 51 00 00 	mov    %rcx,0x51a0(%rax)
  bcache.head.next = &bcache.head;
ffff800000100164:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff80000010016b:	80 ff ff 
ffff80000010016e:	48 89 88 a8 51 00 00 	mov    %rcx,0x51a8(%rax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
ffff800000100175:	48 b8 68 e0 10 00 00 	movabs $0xffff80000010e068,%rax
ffff80000010017c:	80 ff ff 
ffff80000010017f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000100183:	e9 8e 00 00 00       	jmp    ffff800000100216 <binit+0xfb>
    b->next = bcache.head.next;
ffff800000100188:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff80000010018f:	80 ff ff 
ffff800000100192:	48 8b 90 a8 51 00 00 	mov    0x51a8(%rax),%rdx
ffff800000100199:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010019d:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    b->prev = &bcache.head;
ffff8000001001a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001001a8:	48 be 08 31 11 00 00 	movabs $0xffff800000113108,%rsi
ffff8000001001af:	80 ff ff 
ffff8000001001b2:	48 89 b0 98 00 00 00 	mov    %rsi,0x98(%rax)
    initsleeplock(&b->lock, "buffer");
ffff8000001001b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001001bd:	48 83 c0 10          	add    $0x10,%rax
ffff8000001001c1:	48 ba 5f c0 10 00 00 	movabs $0xffff80000010c05f,%rdx
ffff8000001001c8:	80 ff ff 
ffff8000001001cb:	48 89 d6             	mov    %rdx,%rsi
ffff8000001001ce:	48 89 c7             	mov    %rax,%rdi
ffff8000001001d1:	48 b8 2f 75 10 00 00 	movabs $0xffff80000010752f,%rax
ffff8000001001d8:	80 ff ff 
ffff8000001001db:	ff d0                	call   *%rax
    bcache.head.next->prev = b;
ffff8000001001dd:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff8000001001e4:	80 ff ff 
ffff8000001001e7:	48 8b 80 a8 51 00 00 	mov    0x51a8(%rax),%rax
ffff8000001001ee:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001001f2:	48 89 90 98 00 00 00 	mov    %rdx,0x98(%rax)
    bcache.head.next = b;
ffff8000001001f9:	48 ba 00 e0 10 00 00 	movabs $0xffff80000010e000,%rdx
ffff800000100200:	80 ff ff 
ffff800000100203:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100207:	48 89 82 a8 51 00 00 	mov    %rax,0x51a8(%rdx)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
ffff80000010020e:	48 81 45 f8 b0 02 00 	addq   $0x2b0,-0x8(%rbp)
ffff800000100215:	00 
ffff800000100216:	48 b8 08 31 11 00 00 	movabs $0xffff800000113108,%rax
ffff80000010021d:	80 ff ff 
ffff800000100220:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000100224:	0f 82 5e ff ff ff    	jb     ffff800000100188 <binit+0x6d>
  }
}
ffff80000010022a:	90                   	nop
ffff80000010022b:	90                   	nop
ffff80000010022c:	c9                   	leave
ffff80000010022d:	c3                   	ret

ffff80000010022e <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
ffff80000010022e:	55                   	push   %rbp
ffff80000010022f:	48 89 e5             	mov    %rsp,%rbp
ffff800000100232:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000100236:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000100239:	89 75 e8             	mov    %esi,-0x18(%rbp)
  struct buf *b;

  acquire(&bcache.lock);
ffff80000010023c:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff800000100243:	80 ff ff 
ffff800000100246:	48 89 c7             	mov    %rax,%rdi
ffff800000100249:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff800000100250:	80 ff ff 
ffff800000100253:	ff d0                	call   *%rax

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
ffff800000100255:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff80000010025c:	80 ff ff 
ffff80000010025f:	48 8b 80 a8 51 00 00 	mov    0x51a8(%rax),%rax
ffff800000100266:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010026a:	eb 77                	jmp    ffff8000001002e3 <bget+0xb5>
    if(b->dev == dev && b->blockno == blockno){
ffff80000010026c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100270:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000100273:	39 45 ec             	cmp    %eax,-0x14(%rbp)
ffff800000100276:	75 5c                	jne    ffff8000001002d4 <bget+0xa6>
ffff800000100278:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010027c:	8b 40 08             	mov    0x8(%rax),%eax
ffff80000010027f:	39 45 e8             	cmp    %eax,-0x18(%rbp)
ffff800000100282:	75 50                	jne    ffff8000001002d4 <bget+0xa6>
      b->refcnt++;
ffff800000100284:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100288:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
ffff80000010028e:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000100291:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100295:	89 90 90 00 00 00    	mov    %edx,0x90(%rax)
      release(&bcache.lock);
ffff80000010029b:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff8000001002a2:	80 ff ff 
ffff8000001002a5:	48 89 c7             	mov    %rax,%rdi
ffff8000001002a8:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff8000001002af:	80 ff ff 
ffff8000001002b2:	ff d0                	call   *%rax
      acquiresleep(&b->lock);
ffff8000001002b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001002b8:	48 83 c0 10          	add    $0x10,%rax
ffff8000001002bc:	48 89 c7             	mov    %rax,%rdi
ffff8000001002bf:	48 b8 87 75 10 00 00 	movabs $0xffff800000107587,%rax
ffff8000001002c6:	80 ff ff 
ffff8000001002c9:	ff d0                	call   *%rax
      return b;
ffff8000001002cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001002cf:	e9 f6 00 00 00       	jmp    ffff8000001003ca <bget+0x19c>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
ffff8000001002d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001002d8:	48 8b 80 a0 00 00 00 	mov    0xa0(%rax),%rax
ffff8000001002df:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001002e3:	48 b8 08 31 11 00 00 	movabs $0xffff800000113108,%rax
ffff8000001002ea:	80 ff ff 
ffff8000001002ed:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff8000001002f1:	0f 85 75 ff ff ff    	jne    ffff80000010026c <bget+0x3e>
  }

  // Not cached; recycle some unused buffer and clean buffer
  // "clean" because B_DIRTY and not locked means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
ffff8000001002f7:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff8000001002fe:	80 ff ff 
ffff800000100301:	48 8b 80 a0 51 00 00 	mov    0x51a0(%rax),%rax
ffff800000100308:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010030c:	e9 8c 00 00 00       	jmp    ffff80000010039d <bget+0x16f>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
ffff800000100311:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100315:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
ffff80000010031b:	85 c0                	test   %eax,%eax
ffff80000010031d:	75 6f                	jne    ffff80000010038e <bget+0x160>
ffff80000010031f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100323:	8b 00                	mov    (%rax),%eax
ffff800000100325:	83 e0 04             	and    $0x4,%eax
ffff800000100328:	85 c0                	test   %eax,%eax
ffff80000010032a:	75 62                	jne    ffff80000010038e <bget+0x160>
      b->dev = dev;
ffff80000010032c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100330:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff800000100333:	89 50 04             	mov    %edx,0x4(%rax)
      b->blockno = blockno;
ffff800000100336:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010033a:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffff80000010033d:	89 50 08             	mov    %edx,0x8(%rax)
      b->flags = 0;
ffff800000100340:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100344:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
      b->refcnt = 1;
ffff80000010034a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010034e:	c7 80 90 00 00 00 01 	movl   $0x1,0x90(%rax)
ffff800000100355:	00 00 00 
      release(&bcache.lock);
ffff800000100358:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff80000010035f:	80 ff ff 
ffff800000100362:	48 89 c7             	mov    %rax,%rdi
ffff800000100365:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff80000010036c:	80 ff ff 
ffff80000010036f:	ff d0                	call   *%rax
      acquiresleep(&b->lock);
ffff800000100371:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100375:	48 83 c0 10          	add    $0x10,%rax
ffff800000100379:	48 89 c7             	mov    %rax,%rdi
ffff80000010037c:	48 b8 87 75 10 00 00 	movabs $0xffff800000107587,%rax
ffff800000100383:	80 ff ff 
ffff800000100386:	ff d0                	call   *%rax
      return b;
ffff800000100388:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010038c:	eb 3c                	jmp    ffff8000001003ca <bget+0x19c>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
ffff80000010038e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100392:	48 8b 80 98 00 00 00 	mov    0x98(%rax),%rax
ffff800000100399:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010039d:	48 b8 08 31 11 00 00 	movabs $0xffff800000113108,%rax
ffff8000001003a4:	80 ff ff 
ffff8000001003a7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff8000001003ab:	0f 85 60 ff ff ff    	jne    ffff800000100311 <bget+0xe3>
    }
  }
  panic("bget: no buffers");
ffff8000001003b1:	48 b8 66 c0 10 00 00 	movabs $0xffff80000010c066,%rax
ffff8000001003b8:	80 ff ff 
ffff8000001003bb:	48 89 c7             	mov    %rax,%rdi
ffff8000001003be:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001003c5:	80 ff ff 
ffff8000001003c8:	ff d0                	call   *%rax
}
ffff8000001003ca:	c9                   	leave
ffff8000001003cb:	c3                   	ret

ffff8000001003cc <bread>:

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
ffff8000001003cc:	55                   	push   %rbp
ffff8000001003cd:	48 89 e5             	mov    %rsp,%rbp
ffff8000001003d0:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001003d4:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff8000001003d7:	89 75 e8             	mov    %esi,-0x18(%rbp)
  struct buf *b;

  b = bget(dev, blockno);
ffff8000001003da:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffff8000001003dd:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001003e0:	89 d6                	mov    %edx,%esi
ffff8000001003e2:	89 c7                	mov    %eax,%edi
ffff8000001003e4:	48 b8 2e 02 10 00 00 	movabs $0xffff80000010022e,%rax
ffff8000001003eb:	80 ff ff 
ffff8000001003ee:	ff d0                	call   *%rax
ffff8000001003f0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(!(b->flags & B_VALID)) {
ffff8000001003f4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001003f8:	8b 00                	mov    (%rax),%eax
ffff8000001003fa:	83 e0 02             	and    $0x2,%eax
ffff8000001003fd:	85 c0                	test   %eax,%eax
ffff8000001003ff:	75 13                	jne    ffff800000100414 <bread+0x48>
    iderw(b);
ffff800000100401:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100405:	48 89 c7             	mov    %rax,%rdi
ffff800000100408:	48 b8 bb 3c 10 00 00 	movabs $0xffff800000103cbb,%rax
ffff80000010040f:	80 ff ff 
ffff800000100412:	ff d0                	call   *%rax
  }
  return b;
ffff800000100414:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000100418:	c9                   	leave
ffff800000100419:	c3                   	ret

ffff80000010041a <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
ffff80000010041a:	55                   	push   %rbp
ffff80000010041b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010041e:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000100422:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  if(!holdingsleep(&b->lock))
ffff800000100426:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010042a:	48 83 c0 10          	add    $0x10,%rax
ffff80000010042e:	48 89 c7             	mov    %rax,%rdi
ffff800000100431:	48 b8 72 76 10 00 00 	movabs $0xffff800000107672,%rax
ffff800000100438:	80 ff ff 
ffff80000010043b:	ff d0                	call   *%rax
ffff80000010043d:	85 c0                	test   %eax,%eax
ffff80000010043f:	75 19                	jne    ffff80000010045a <bwrite+0x40>
    panic("bwrite");
ffff800000100441:	48 b8 77 c0 10 00 00 	movabs $0xffff80000010c077,%rax
ffff800000100448:	80 ff ff 
ffff80000010044b:	48 89 c7             	mov    %rax,%rdi
ffff80000010044e:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000100455:	80 ff ff 
ffff800000100458:	ff d0                	call   *%rax
  b->flags |= B_DIRTY;
ffff80000010045a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010045e:	8b 00                	mov    (%rax),%eax
ffff800000100460:	83 c8 04             	or     $0x4,%eax
ffff800000100463:	89 c2                	mov    %eax,%edx
ffff800000100465:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100469:	89 10                	mov    %edx,(%rax)
  iderw(b);
ffff80000010046b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010046f:	48 89 c7             	mov    %rax,%rdi
ffff800000100472:	48 b8 bb 3c 10 00 00 	movabs $0xffff800000103cbb,%rax
ffff800000100479:	80 ff ff 
ffff80000010047c:	ff d0                	call   *%rax
}
ffff80000010047e:	90                   	nop
ffff80000010047f:	c9                   	leave
ffff800000100480:	c3                   	ret

ffff800000100481 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
ffff800000100481:	55                   	push   %rbp
ffff800000100482:	48 89 e5             	mov    %rsp,%rbp
ffff800000100485:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000100489:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  if(!holdingsleep(&b->lock))
ffff80000010048d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100491:	48 83 c0 10          	add    $0x10,%rax
ffff800000100495:	48 89 c7             	mov    %rax,%rdi
ffff800000100498:	48 b8 72 76 10 00 00 	movabs $0xffff800000107672,%rax
ffff80000010049f:	80 ff ff 
ffff8000001004a2:	ff d0                	call   *%rax
ffff8000001004a4:	85 c0                	test   %eax,%eax
ffff8000001004a6:	75 19                	jne    ffff8000001004c1 <brelse+0x40>
    panic("brelse");
ffff8000001004a8:	48 b8 7e c0 10 00 00 	movabs $0xffff80000010c07e,%rax
ffff8000001004af:	80 ff ff 
ffff8000001004b2:	48 89 c7             	mov    %rax,%rdi
ffff8000001004b5:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001004bc:	80 ff ff 
ffff8000001004bf:	ff d0                	call   *%rax

  releasesleep(&b->lock);
ffff8000001004c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001004c5:	48 83 c0 10          	add    $0x10,%rax
ffff8000001004c9:	48 89 c7             	mov    %rax,%rdi
ffff8000001004cc:	48 b8 0d 76 10 00 00 	movabs $0xffff80000010760d,%rax
ffff8000001004d3:	80 ff ff 
ffff8000001004d6:	ff d0                	call   *%rax

  acquire(&bcache.lock);
ffff8000001004d8:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff8000001004df:	80 ff ff 
ffff8000001004e2:	48 89 c7             	mov    %rax,%rdi
ffff8000001004e5:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff8000001004ec:	80 ff ff 
ffff8000001004ef:	ff d0                	call   *%rax
  b->refcnt--;
ffff8000001004f1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001004f5:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
ffff8000001004fb:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff8000001004fe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100502:	89 90 90 00 00 00    	mov    %edx,0x90(%rax)
  if (b->refcnt == 0) {
ffff800000100508:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010050c:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
ffff800000100512:	85 c0                	test   %eax,%eax
ffff800000100514:	0f 85 9c 00 00 00    	jne    ffff8000001005b6 <brelse+0x135>
    // no one is waiting for it.
    b->next->prev = b->prev;
ffff80000010051a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010051e:	48 8b 80 a0 00 00 00 	mov    0xa0(%rax),%rax
ffff800000100525:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000100529:	48 8b 92 98 00 00 00 	mov    0x98(%rdx),%rdx
ffff800000100530:	48 89 90 98 00 00 00 	mov    %rdx,0x98(%rax)
    b->prev->next = b->next;
ffff800000100537:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010053b:	48 8b 80 98 00 00 00 	mov    0x98(%rax),%rax
ffff800000100542:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000100546:	48 8b 92 a0 00 00 00 	mov    0xa0(%rdx),%rdx
ffff80000010054d:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    b->next = bcache.head.next;
ffff800000100554:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff80000010055b:	80 ff ff 
ffff80000010055e:	48 8b 90 a8 51 00 00 	mov    0x51a8(%rax),%rdx
ffff800000100565:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100569:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    b->prev = &bcache.head;
ffff800000100570:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100574:	48 b9 08 31 11 00 00 	movabs $0xffff800000113108,%rcx
ffff80000010057b:	80 ff ff 
ffff80000010057e:	48 89 88 98 00 00 00 	mov    %rcx,0x98(%rax)
    bcache.head.next->prev = b;
ffff800000100585:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff80000010058c:	80 ff ff 
ffff80000010058f:	48 8b 80 a8 51 00 00 	mov    0x51a8(%rax),%rax
ffff800000100596:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010059a:	48 89 90 98 00 00 00 	mov    %rdx,0x98(%rax)
    bcache.head.next = b;
ffff8000001005a1:	48 ba 00 e0 10 00 00 	movabs $0xffff80000010e000,%rdx
ffff8000001005a8:	80 ff ff 
ffff8000001005ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001005af:	48 89 82 a8 51 00 00 	mov    %rax,0x51a8(%rdx)
  }

  release(&bcache.lock);
ffff8000001005b6:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff8000001005bd:	80 ff ff 
ffff8000001005c0:	48 89 c7             	mov    %rax,%rdi
ffff8000001005c3:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff8000001005ca:	80 ff ff 
ffff8000001005cd:	ff d0                	call   *%rax
}
ffff8000001005cf:	90                   	nop
ffff8000001005d0:	c9                   	leave
ffff8000001005d1:	c3                   	ret

ffff8000001005d2 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
ffff8000001005d2:	55                   	push   %rbp
ffff8000001005d3:	48 89 e5             	mov    %rsp,%rbp
ffff8000001005d6:	48 83 ec 18          	sub    $0x18,%rsp
ffff8000001005da:	89 f8                	mov    %edi,%eax
ffff8000001005dc:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
ffff8000001005e0:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff8000001005e4:	89 c2                	mov    %eax,%edx
ffff8000001005e6:	ec                   	in     (%dx),%al
ffff8000001005e7:	88 45 ff             	mov    %al,-0x1(%rbp)
  return data;
ffff8000001005ea:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
}
ffff8000001005ee:	c9                   	leave
ffff8000001005ef:	c3                   	ret

ffff8000001005f0 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
ffff8000001005f0:	55                   	push   %rbp
ffff8000001005f1:	48 89 e5             	mov    %rsp,%rbp
ffff8000001005f4:	48 83 ec 08          	sub    $0x8,%rsp
ffff8000001005f8:	89 fa                	mov    %edi,%edx
ffff8000001005fa:	89 f0                	mov    %esi,%eax
ffff8000001005fc:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffff800000100600:	88 45 f8             	mov    %al,-0x8(%rbp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
ffff800000100603:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffff800000100607:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffff80000010060b:	ee                   	out    %al,(%dx)
}
ffff80000010060c:	90                   	nop
ffff80000010060d:	c9                   	leave
ffff80000010060e:	c3                   	ret

ffff80000010060f <lidt>:

struct gatedesc;

static inline void
lidt(struct gatedesc *p, int size)
{
ffff80000010060f:	55                   	push   %rbp
ffff800000100610:	48 89 e5             	mov    %rsp,%rbp
ffff800000100613:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000100617:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010061b:	89 75 d4             	mov    %esi,-0x2c(%rbp)
  volatile ushort pd[5];
  addr_t addr = (addr_t)p;
ffff80000010061e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000100622:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  pd[0] = size-1;
ffff800000100626:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff800000100629:	83 e8 01             	sub    $0x1,%eax
ffff80000010062c:	66 89 45 ee          	mov    %ax,-0x12(%rbp)
  pd[1] = addr;
ffff800000100630:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100634:	66 89 45 f0          	mov    %ax,-0x10(%rbp)
  pd[2] = addr >> 16;
ffff800000100638:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010063c:	48 c1 e8 10          	shr    $0x10,%rax
ffff800000100640:	66 89 45 f2          	mov    %ax,-0xe(%rbp)
  pd[3] = addr >> 32;
ffff800000100644:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100648:	48 c1 e8 20          	shr    $0x20,%rax
ffff80000010064c:	66 89 45 f4          	mov    %ax,-0xc(%rbp)
  pd[4] = addr >> 48;
ffff800000100650:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100654:	48 c1 e8 30          	shr    $0x30,%rax
ffff800000100658:	66 89 45 f6          	mov    %ax,-0xa(%rbp)

  asm volatile("lidt (%0)" : : "r" (pd));
ffff80000010065c:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
ffff800000100660:	0f 01 18             	lidt   (%rax)
}
ffff800000100663:	90                   	nop
ffff800000100664:	c9                   	leave
ffff800000100665:	c3                   	ret

ffff800000100666 <cli>:
  return eflags;
}

static inline void
cli(void)
{
ffff800000100666:	55                   	push   %rbp
ffff800000100667:	48 89 e5             	mov    %rsp,%rbp
  asm volatile("cli");
ffff80000010066a:	fa                   	cli
}
ffff80000010066b:	90                   	nop
ffff80000010066c:	5d                   	pop    %rbp
ffff80000010066d:	c3                   	ret

ffff80000010066e <hlt>:
  asm volatile("sti");
}

static inline void
hlt(void)
{
ffff80000010066e:	55                   	push   %rbp
ffff80000010066f:	48 89 e5             	mov    %rsp,%rbp
  asm volatile("hlt");
ffff800000100672:	f4                   	hlt
}
ffff800000100673:	90                   	nop
ffff800000100674:	5d                   	pop    %rbp
ffff800000100675:	c3                   	ret

ffff800000100676 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(addr_t x)
{
ffff800000100676:	55                   	push   %rbp
ffff800000100677:	48 89 e5             	mov    %rsp,%rbp
ffff80000010067a:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010067e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
ffff800000100682:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000100689:	eb 30                	jmp    ffff8000001006bb <print_x64+0x45>
    consputc(digits[x >> (sizeof(addr_t) * 8 - 4)]);
ffff80000010068b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010068f:	48 c1 e8 3c          	shr    $0x3c,%rax
ffff800000100693:	48 ba 00 d0 10 00 00 	movabs $0xffff80000010d000,%rdx
ffff80000010069a:	80 ff ff 
ffff80000010069d:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
ffff8000001006a1:	0f be c0             	movsbl %al,%eax
ffff8000001006a4:	89 c7                	mov    %eax,%edi
ffff8000001006a6:	48 b8 d7 0e 10 00 00 	movabs $0xffff800000100ed7,%rax
ffff8000001006ad:	80 ff ff 
ffff8000001006b0:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
ffff8000001006b2:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001006b6:	48 c1 65 e8 04       	shlq   $0x4,-0x18(%rbp)
ffff8000001006bb:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001006be:	83 f8 0f             	cmp    $0xf,%eax
ffff8000001006c1:	76 c8                	jbe    ffff80000010068b <print_x64+0x15>
}
ffff8000001006c3:	90                   	nop
ffff8000001006c4:	90                   	nop
ffff8000001006c5:	c9                   	leave
ffff8000001006c6:	c3                   	ret

ffff8000001006c7 <print_x32>:

  static void
print_x32(uint x)
{
ffff8000001006c7:	55                   	push   %rbp
ffff8000001006c8:	48 89 e5             	mov    %rsp,%rbp
ffff8000001006cb:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001006cf:	89 7d ec             	mov    %edi,-0x14(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
ffff8000001006d2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001006d9:	eb 31                	jmp    ffff80000010070c <print_x32+0x45>
    consputc(digits[x >> (sizeof(uint) * 8 - 4)]);
ffff8000001006db:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001006de:	c1 e8 1c             	shr    $0x1c,%eax
ffff8000001006e1:	89 c2                	mov    %eax,%edx
ffff8000001006e3:	48 b8 00 d0 10 00 00 	movabs $0xffff80000010d000,%rax
ffff8000001006ea:	80 ff ff 
ffff8000001006ed:	89 d2                	mov    %edx,%edx
ffff8000001006ef:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
ffff8000001006f3:	0f be c0             	movsbl %al,%eax
ffff8000001006f6:	89 c7                	mov    %eax,%edi
ffff8000001006f8:	48 b8 d7 0e 10 00 00 	movabs $0xffff800000100ed7,%rax
ffff8000001006ff:	80 ff ff 
ffff800000100702:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
ffff800000100704:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000100708:	c1 65 ec 04          	shll   $0x4,-0x14(%rbp)
ffff80000010070c:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010070f:	83 f8 07             	cmp    $0x7,%eax
ffff800000100712:	76 c7                	jbe    ffff8000001006db <print_x32+0x14>
}
ffff800000100714:	90                   	nop
ffff800000100715:	90                   	nop
ffff800000100716:	c9                   	leave
ffff800000100717:	c3                   	ret

ffff800000100718 <print_d>:

  static void
print_d(int v)
{
ffff800000100718:	55                   	push   %rbp
ffff800000100719:	48 89 e5             	mov    %rsp,%rbp
ffff80000010071c:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000100720:	89 7d dc             	mov    %edi,-0x24(%rbp)
  char buf[16];
  int64 x = v;
ffff800000100723:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000100726:	48 98                	cltq
ffff800000100728:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
ffff80000010072c:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
ffff800000100730:	79 04                	jns    ffff800000100736 <print_d+0x1e>
    x = -x;
ffff800000100732:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
ffff800000100736:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
ffff80000010073d:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff800000100741:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
ffff800000100748:	66 66 66 
ffff80000010074b:	48 89 c8             	mov    %rcx,%rax
ffff80000010074e:	48 f7 ea             	imul   %rdx
ffff800000100751:	48 c1 fa 02          	sar    $0x2,%rdx
ffff800000100755:	48 89 c8             	mov    %rcx,%rax
ffff800000100758:	48 c1 f8 3f          	sar    $0x3f,%rax
ffff80000010075c:	48 29 c2             	sub    %rax,%rdx
ffff80000010075f:	48 89 d0             	mov    %rdx,%rax
ffff800000100762:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000100766:	48 01 d0             	add    %rdx,%rax
ffff800000100769:	48 01 c0             	add    %rax,%rax
ffff80000010076c:	48 29 c1             	sub    %rax,%rcx
ffff80000010076f:	48 89 ca             	mov    %rcx,%rdx
ffff800000100772:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000100775:	8d 48 01             	lea    0x1(%rax),%ecx
ffff800000100778:	89 4d f4             	mov    %ecx,-0xc(%rbp)
ffff80000010077b:	48 b9 00 d0 10 00 00 	movabs $0xffff80000010d000,%rcx
ffff800000100782:	80 ff ff 
ffff800000100785:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
ffff800000100789:	48 98                	cltq
ffff80000010078b:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
ffff80000010078f:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff800000100793:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
ffff80000010079a:	66 66 66 
ffff80000010079d:	48 89 c8             	mov    %rcx,%rax
ffff8000001007a0:	48 f7 ea             	imul   %rdx
ffff8000001007a3:	48 89 d0             	mov    %rdx,%rax
ffff8000001007a6:	48 c1 f8 02          	sar    $0x2,%rax
ffff8000001007aa:	48 c1 f9 3f          	sar    $0x3f,%rcx
ffff8000001007ae:	48 89 ca             	mov    %rcx,%rdx
ffff8000001007b1:	48 29 d0             	sub    %rdx,%rax
ffff8000001007b4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
ffff8000001007b8:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff8000001007bd:	0f 85 7a ff ff ff    	jne    ffff80000010073d <print_d+0x25>

  if (v < 0)
ffff8000001007c3:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
ffff8000001007c7:	79 2d                	jns    ffff8000001007f6 <print_d+0xde>
    buf[i++] = '-';
ffff8000001007c9:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff8000001007cc:	8d 50 01             	lea    0x1(%rax),%edx
ffff8000001007cf:	89 55 f4             	mov    %edx,-0xc(%rbp)
ffff8000001007d2:	48 98                	cltq
ffff8000001007d4:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
ffff8000001007d9:	eb 1b                	jmp    ffff8000001007f6 <print_d+0xde>
    consputc(buf[i]);
ffff8000001007db:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff8000001007de:	48 98                	cltq
ffff8000001007e0:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
ffff8000001007e5:	0f be c0             	movsbl %al,%eax
ffff8000001007e8:	89 c7                	mov    %eax,%edi
ffff8000001007ea:	48 b8 d7 0e 10 00 00 	movabs $0xffff800000100ed7,%rax
ffff8000001007f1:	80 ff ff 
ffff8000001007f4:	ff d0                	call   *%rax
  while (--i >= 0)
ffff8000001007f6:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
ffff8000001007fa:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
ffff8000001007fe:	79 db                	jns    ffff8000001007db <print_d+0xc3>
}
ffff800000100800:	90                   	nop
ffff800000100801:	90                   	nop
ffff800000100802:	c9                   	leave
ffff800000100803:	c3                   	ret

ffff800000100804 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
  void
cprintf(char *fmt, ...)
{
ffff800000100804:	55                   	push   %rbp
ffff800000100805:	48 89 e5             	mov    %rsp,%rbp
ffff800000100808:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
ffff80000010080f:	48 89 bd 18 ff ff ff 	mov    %rdi,-0xe8(%rbp)
ffff800000100816:	48 89 b5 58 ff ff ff 	mov    %rsi,-0xa8(%rbp)
ffff80000010081d:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
ffff800000100824:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
ffff80000010082b:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
ffff800000100832:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
ffff800000100839:	84 c0                	test   %al,%al
ffff80000010083b:	74 20                	je     ffff80000010085d <cprintf+0x59>
ffff80000010083d:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
ffff800000100841:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
ffff800000100845:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
ffff800000100849:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
ffff80000010084d:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
ffff800000100851:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
ffff800000100855:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
ffff800000100859:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c, locking;
  char *s;

  va_start(ap, fmt);
ffff80000010085d:	c7 85 20 ff ff ff 08 	movl   $0x8,-0xe0(%rbp)
ffff800000100864:	00 00 00 
ffff800000100867:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
ffff80000010086e:	00 00 00 
ffff800000100871:	48 8d 45 10          	lea    0x10(%rbp),%rax
ffff800000100875:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
ffff80000010087c:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
ffff800000100883:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  locking = cons.locking;
ffff80000010088a:	48 b8 c0 34 11 00 00 	movabs $0xffff8000001134c0,%rax
ffff800000100891:	80 ff ff 
ffff800000100894:	8b 40 68             	mov    0x68(%rax),%eax
ffff800000100897:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
  if (locking)
ffff80000010089d:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
ffff8000001008a4:	74 19                	je     ffff8000001008bf <cprintf+0xbb>
    acquire(&cons.lock);
ffff8000001008a6:	48 b8 c0 34 11 00 00 	movabs $0xffff8000001134c0,%rax
ffff8000001008ad:	80 ff ff 
ffff8000001008b0:	48 89 c7             	mov    %rax,%rdi
ffff8000001008b3:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff8000001008ba:	80 ff ff 
ffff8000001008bd:	ff d0                	call   *%rax

  if (fmt == 0)
ffff8000001008bf:	48 83 bd 18 ff ff ff 	cmpq   $0x0,-0xe8(%rbp)
ffff8000001008c6:	00 
ffff8000001008c7:	75 19                	jne    ffff8000001008e2 <cprintf+0xde>
    panic("null fmt");
ffff8000001008c9:	48 b8 85 c0 10 00 00 	movabs $0xffff80000010c085,%rax
ffff8000001008d0:	80 ff ff 
ffff8000001008d3:	48 89 c7             	mov    %rax,%rdi
ffff8000001008d6:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001008dd:	80 ff ff 
ffff8000001008e0:	ff d0                	call   *%rax

  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
ffff8000001008e2:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
ffff8000001008e9:	00 00 00 
ffff8000001008ec:	e9 a0 02 00 00       	jmp    ffff800000100b91 <cprintf+0x38d>
    if (c != '%') {
ffff8000001008f1:	83 bd 38 ff ff ff 25 	cmpl   $0x25,-0xc8(%rbp)
ffff8000001008f8:	74 19                	je     ffff800000100913 <cprintf+0x10f>
      consputc(c);
ffff8000001008fa:	8b 85 38 ff ff ff    	mov    -0xc8(%rbp),%eax
ffff800000100900:	89 c7                	mov    %eax,%edi
ffff800000100902:	48 b8 d7 0e 10 00 00 	movabs $0xffff800000100ed7,%rax
ffff800000100909:	80 ff ff 
ffff80000010090c:	ff d0                	call   *%rax
      continue;
ffff80000010090e:	e9 77 02 00 00       	jmp    ffff800000100b8a <cprintf+0x386>
    }
    c = fmt[++i] & 0xff;
ffff800000100913:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
ffff80000010091a:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
ffff800000100920:	48 63 d0             	movslq %eax,%rdx
ffff800000100923:	48 8b 85 18 ff ff ff 	mov    -0xe8(%rbp),%rax
ffff80000010092a:	48 01 d0             	add    %rdx,%rax
ffff80000010092d:	0f b6 00             	movzbl (%rax),%eax
ffff800000100930:	0f be c0             	movsbl %al,%eax
ffff800000100933:	25 ff 00 00 00       	and    $0xff,%eax
ffff800000100938:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%rbp)
    if (c == 0)
ffff80000010093e:	83 bd 38 ff ff ff 00 	cmpl   $0x0,-0xc8(%rbp)
ffff800000100945:	0f 84 79 02 00 00    	je     ffff800000100bc4 <cprintf+0x3c0>
      break;
    switch(c) {
ffff80000010094b:	83 bd 38 ff ff ff 78 	cmpl   $0x78,-0xc8(%rbp)
ffff800000100952:	0f 84 b0 00 00 00    	je     ffff800000100a08 <cprintf+0x204>
ffff800000100958:	83 bd 38 ff ff ff 78 	cmpl   $0x78,-0xc8(%rbp)
ffff80000010095f:	0f 8f ff 01 00 00    	jg     ffff800000100b64 <cprintf+0x360>
ffff800000100965:	83 bd 38 ff ff ff 73 	cmpl   $0x73,-0xc8(%rbp)
ffff80000010096c:	0f 84 42 01 00 00    	je     ffff800000100ab4 <cprintf+0x2b0>
ffff800000100972:	83 bd 38 ff ff ff 73 	cmpl   $0x73,-0xc8(%rbp)
ffff800000100979:	0f 8f e5 01 00 00    	jg     ffff800000100b64 <cprintf+0x360>
ffff80000010097f:	83 bd 38 ff ff ff 70 	cmpl   $0x70,-0xc8(%rbp)
ffff800000100986:	0f 84 d1 00 00 00    	je     ffff800000100a5d <cprintf+0x259>
ffff80000010098c:	83 bd 38 ff ff ff 70 	cmpl   $0x70,-0xc8(%rbp)
ffff800000100993:	0f 8f cb 01 00 00    	jg     ffff800000100b64 <cprintf+0x360>
ffff800000100999:	83 bd 38 ff ff ff 25 	cmpl   $0x25,-0xc8(%rbp)
ffff8000001009a0:	0f 84 ab 01 00 00    	je     ffff800000100b51 <cprintf+0x34d>
ffff8000001009a6:	83 bd 38 ff ff ff 64 	cmpl   $0x64,-0xc8(%rbp)
ffff8000001009ad:	0f 85 b1 01 00 00    	jne    ffff800000100b64 <cprintf+0x360>
    case 'd':
      print_d(va_arg(ap, int));
ffff8000001009b3:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
ffff8000001009b9:	83 f8 2f             	cmp    $0x2f,%eax
ffff8000001009bc:	77 23                	ja     ffff8000001009e1 <cprintf+0x1dd>
ffff8000001009be:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
ffff8000001009c5:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffff8000001009cb:	89 d2                	mov    %edx,%edx
ffff8000001009cd:	48 01 d0             	add    %rdx,%rax
ffff8000001009d0:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffff8000001009d6:	83 c2 08             	add    $0x8,%edx
ffff8000001009d9:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
ffff8000001009df:	eb 12                	jmp    ffff8000001009f3 <cprintf+0x1ef>
ffff8000001009e1:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
ffff8000001009e8:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffff8000001009ec:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
ffff8000001009f3:	8b 00                	mov    (%rax),%eax
ffff8000001009f5:	89 c7                	mov    %eax,%edi
ffff8000001009f7:	48 b8 18 07 10 00 00 	movabs $0xffff800000100718,%rax
ffff8000001009fe:	80 ff ff 
ffff800000100a01:	ff d0                	call   *%rax
      break;
ffff800000100a03:	e9 82 01 00 00       	jmp    ffff800000100b8a <cprintf+0x386>
    case 'x':
      print_x32(va_arg(ap, uint));
ffff800000100a08:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
ffff800000100a0e:	83 f8 2f             	cmp    $0x2f,%eax
ffff800000100a11:	77 23                	ja     ffff800000100a36 <cprintf+0x232>
ffff800000100a13:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
ffff800000100a1a:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffff800000100a20:	89 d2                	mov    %edx,%edx
ffff800000100a22:	48 01 d0             	add    %rdx,%rax
ffff800000100a25:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffff800000100a2b:	83 c2 08             	add    $0x8,%edx
ffff800000100a2e:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
ffff800000100a34:	eb 12                	jmp    ffff800000100a48 <cprintf+0x244>
ffff800000100a36:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
ffff800000100a3d:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffff800000100a41:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
ffff800000100a48:	8b 00                	mov    (%rax),%eax
ffff800000100a4a:	89 c7                	mov    %eax,%edi
ffff800000100a4c:	48 b8 c7 06 10 00 00 	movabs $0xffff8000001006c7,%rax
ffff800000100a53:	80 ff ff 
ffff800000100a56:	ff d0                	call   *%rax
      break;
ffff800000100a58:	e9 2d 01 00 00       	jmp    ffff800000100b8a <cprintf+0x386>
    case 'p':
      print_x64(va_arg(ap, addr_t));
ffff800000100a5d:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
ffff800000100a63:	83 f8 2f             	cmp    $0x2f,%eax
ffff800000100a66:	77 23                	ja     ffff800000100a8b <cprintf+0x287>
ffff800000100a68:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
ffff800000100a6f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffff800000100a75:	89 d2                	mov    %edx,%edx
ffff800000100a77:	48 01 d0             	add    %rdx,%rax
ffff800000100a7a:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffff800000100a80:	83 c2 08             	add    $0x8,%edx
ffff800000100a83:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
ffff800000100a89:	eb 12                	jmp    ffff800000100a9d <cprintf+0x299>
ffff800000100a8b:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
ffff800000100a92:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffff800000100a96:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
ffff800000100a9d:	48 8b 00             	mov    (%rax),%rax
ffff800000100aa0:	48 89 c7             	mov    %rax,%rdi
ffff800000100aa3:	48 b8 76 06 10 00 00 	movabs $0xffff800000100676,%rax
ffff800000100aaa:	80 ff ff 
ffff800000100aad:	ff d0                	call   *%rax
      break;
ffff800000100aaf:	e9 d6 00 00 00       	jmp    ffff800000100b8a <cprintf+0x386>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
ffff800000100ab4:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
ffff800000100aba:	83 f8 2f             	cmp    $0x2f,%eax
ffff800000100abd:	77 23                	ja     ffff800000100ae2 <cprintf+0x2de>
ffff800000100abf:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
ffff800000100ac6:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffff800000100acc:	89 d2                	mov    %edx,%edx
ffff800000100ace:	48 01 d0             	add    %rdx,%rax
ffff800000100ad1:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffff800000100ad7:	83 c2 08             	add    $0x8,%edx
ffff800000100ada:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
ffff800000100ae0:	eb 12                	jmp    ffff800000100af4 <cprintf+0x2f0>
ffff800000100ae2:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
ffff800000100ae9:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffff800000100aed:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
ffff800000100af4:	48 8b 00             	mov    (%rax),%rax
ffff800000100af7:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
ffff800000100afe:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
ffff800000100b05:	00 
ffff800000100b06:	75 39                	jne    ffff800000100b41 <cprintf+0x33d>
        s = "(null)";
ffff800000100b08:	48 b8 8e c0 10 00 00 	movabs $0xffff80000010c08e,%rax
ffff800000100b0f:	80 ff ff 
ffff800000100b12:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
ffff800000100b19:	eb 26                	jmp    ffff800000100b41 <cprintf+0x33d>
        consputc(*(s++));
ffff800000100b1b:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
ffff800000100b22:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff800000100b26:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
ffff800000100b2d:	0f b6 00             	movzbl (%rax),%eax
ffff800000100b30:	0f be c0             	movsbl %al,%eax
ffff800000100b33:	89 c7                	mov    %eax,%edi
ffff800000100b35:	48 b8 d7 0e 10 00 00 	movabs $0xffff800000100ed7,%rax
ffff800000100b3c:	80 ff ff 
ffff800000100b3f:	ff d0                	call   *%rax
      while (*s)
ffff800000100b41:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
ffff800000100b48:	0f b6 00             	movzbl (%rax),%eax
ffff800000100b4b:	84 c0                	test   %al,%al
ffff800000100b4d:	75 cc                	jne    ffff800000100b1b <cprintf+0x317>
      break;
ffff800000100b4f:	eb 39                	jmp    ffff800000100b8a <cprintf+0x386>
    case '%':
      consputc('%');
ffff800000100b51:	bf 25 00 00 00       	mov    $0x25,%edi
ffff800000100b56:	48 b8 d7 0e 10 00 00 	movabs $0xffff800000100ed7,%rax
ffff800000100b5d:	80 ff ff 
ffff800000100b60:	ff d0                	call   *%rax
      break;
ffff800000100b62:	eb 26                	jmp    ffff800000100b8a <cprintf+0x386>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
ffff800000100b64:	bf 25 00 00 00       	mov    $0x25,%edi
ffff800000100b69:	48 b8 d7 0e 10 00 00 	movabs $0xffff800000100ed7,%rax
ffff800000100b70:	80 ff ff 
ffff800000100b73:	ff d0                	call   *%rax
      consputc(c);
ffff800000100b75:	8b 85 38 ff ff ff    	mov    -0xc8(%rbp),%eax
ffff800000100b7b:	89 c7                	mov    %eax,%edi
ffff800000100b7d:	48 b8 d7 0e 10 00 00 	movabs $0xffff800000100ed7,%rax
ffff800000100b84:	80 ff ff 
ffff800000100b87:	ff d0                	call   *%rax
      break;
ffff800000100b89:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
ffff800000100b8a:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
ffff800000100b91:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
ffff800000100b97:	48 63 d0             	movslq %eax,%rdx
ffff800000100b9a:	48 8b 85 18 ff ff ff 	mov    -0xe8(%rbp),%rax
ffff800000100ba1:	48 01 d0             	add    %rdx,%rax
ffff800000100ba4:	0f b6 00             	movzbl (%rax),%eax
ffff800000100ba7:	0f be c0             	movsbl %al,%eax
ffff800000100baa:	25 ff 00 00 00       	and    $0xff,%eax
ffff800000100baf:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%rbp)
ffff800000100bb5:	83 bd 38 ff ff ff 00 	cmpl   $0x0,-0xc8(%rbp)
ffff800000100bbc:	0f 85 2f fd ff ff    	jne    ffff8000001008f1 <cprintf+0xed>
ffff800000100bc2:	eb 01                	jmp    ffff800000100bc5 <cprintf+0x3c1>
      break;
ffff800000100bc4:	90                   	nop
    }
  }

  if (locking)
ffff800000100bc5:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
ffff800000100bcc:	74 19                	je     ffff800000100be7 <cprintf+0x3e3>
    release(&cons.lock);
ffff800000100bce:	48 b8 c0 34 11 00 00 	movabs $0xffff8000001134c0,%rax
ffff800000100bd5:	80 ff ff 
ffff800000100bd8:	48 89 c7             	mov    %rax,%rdi
ffff800000100bdb:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000100be2:	80 ff ff 
ffff800000100be5:	ff d0                	call   *%rax
}
ffff800000100be7:	90                   	nop
ffff800000100be8:	c9                   	leave
ffff800000100be9:	c3                   	ret

ffff800000100bea <panic>:

__attribute__((noreturn))
  void
panic(char *s)
{
ffff800000100bea:	55                   	push   %rbp
ffff800000100beb:	48 89 e5             	mov    %rsp,%rbp
ffff800000100bee:	48 83 ec 70          	sub    $0x70,%rsp
ffff800000100bf2:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)
  int i;
  addr_t pcs[10];

  cli();
ffff800000100bf6:	48 b8 66 06 10 00 00 	movabs $0xffff800000100666,%rax
ffff800000100bfd:	80 ff ff 
ffff800000100c00:	ff d0                	call   *%rax
  cons.locking = 0;
ffff800000100c02:	48 b8 c0 34 11 00 00 	movabs $0xffff8000001134c0,%rax
ffff800000100c09:	80 ff ff 
ffff800000100c0c:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%rax)
  cprintf("cpu%d: panic: ", cpu->id);
ffff800000100c13:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000100c1a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000100c1e:	0f b6 00             	movzbl (%rax),%eax
ffff800000100c21:	0f b6 c0             	movzbl %al,%eax
ffff800000100c24:	48 ba 95 c0 10 00 00 	movabs $0xffff80000010c095,%rdx
ffff800000100c2b:	80 ff ff 
ffff800000100c2e:	89 c6                	mov    %eax,%esi
ffff800000100c30:	48 89 d7             	mov    %rdx,%rdi
ffff800000100c33:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000100c38:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000100c3f:	80 ff ff 
ffff800000100c42:	ff d2                	call   *%rdx
  cprintf(s);
ffff800000100c44:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff800000100c48:	48 89 c7             	mov    %rax,%rdi
ffff800000100c4b:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000100c50:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000100c57:	80 ff ff 
ffff800000100c5a:	ff d2                	call   *%rdx
  cprintf("\n");
ffff800000100c5c:	48 b8 a4 c0 10 00 00 	movabs $0xffff80000010c0a4,%rax
ffff800000100c63:	80 ff ff 
ffff800000100c66:	48 89 c7             	mov    %rax,%rdi
ffff800000100c69:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000100c6e:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000100c75:	80 ff ff 
ffff800000100c78:	ff d2                	call   *%rdx
  getcallerpcs(&s, pcs);
ffff800000100c7a:	48 8d 55 a0          	lea    -0x60(%rbp),%rdx
ffff800000100c7e:	48 8d 45 98          	lea    -0x68(%rbp),%rax
ffff800000100c82:	48 89 d6             	mov    %rdx,%rsi
ffff800000100c85:	48 89 c7             	mov    %rax,%rdi
ffff800000100c88:	48 b8 50 78 10 00 00 	movabs $0xffff800000107850,%rax
ffff800000100c8f:	80 ff ff 
ffff800000100c92:	ff d0                	call   *%rax
  for (i=0; i<10; i++)
ffff800000100c94:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000100c9b:	eb 2f                	jmp    ffff800000100ccc <panic+0xe2>
    cprintf(" %p\n", pcs[i]);
ffff800000100c9d:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000100ca0:	48 98                	cltq
ffff800000100ca2:	48 8b 44 c5 a0       	mov    -0x60(%rbp,%rax,8),%rax
ffff800000100ca7:	48 ba a6 c0 10 00 00 	movabs $0xffff80000010c0a6,%rdx
ffff800000100cae:	80 ff ff 
ffff800000100cb1:	48 89 c6             	mov    %rax,%rsi
ffff800000100cb4:	48 89 d7             	mov    %rdx,%rdi
ffff800000100cb7:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000100cbc:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000100cc3:	80 ff ff 
ffff800000100cc6:	ff d2                	call   *%rdx
  for (i=0; i<10; i++)
ffff800000100cc8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000100ccc:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffff800000100cd0:	7e cb                	jle    ffff800000100c9d <panic+0xb3>
  panicked = 1; // freeze other CPU
ffff800000100cd2:	48 b8 b8 34 11 00 00 	movabs $0xffff8000001134b8,%rax
ffff800000100cd9:	80 ff ff 
ffff800000100cdc:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
  for (;;)
    hlt();
ffff800000100ce2:	48 b8 6e 06 10 00 00 	movabs $0xffff80000010066e,%rax
ffff800000100ce9:	80 ff ff 
ffff800000100cec:	ff d0                	call   *%rax
ffff800000100cee:	eb f2                	jmp    ffff800000100ce2 <panic+0xf8>

ffff800000100cf0 <cgaputc>:
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

  static void
cgaputc(int c)
{
ffff800000100cf0:	55                   	push   %rbp
ffff800000100cf1:	48 89 e5             	mov    %rsp,%rbp
ffff800000100cf4:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000100cf8:	89 7d ec             	mov    %edi,-0x14(%rbp)
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
ffff800000100cfb:	be 0e 00 00 00       	mov    $0xe,%esi
ffff800000100d00:	bf d4 03 00 00       	mov    $0x3d4,%edi
ffff800000100d05:	48 b8 f0 05 10 00 00 	movabs $0xffff8000001005f0,%rax
ffff800000100d0c:	80 ff ff 
ffff800000100d0f:	ff d0                	call   *%rax
  pos = inb(CRTPORT+1) << 8;
ffff800000100d11:	bf d5 03 00 00       	mov    $0x3d5,%edi
ffff800000100d16:	48 b8 d2 05 10 00 00 	movabs $0xffff8000001005d2,%rax
ffff800000100d1d:	80 ff ff 
ffff800000100d20:	ff d0                	call   *%rax
ffff800000100d22:	0f b6 c0             	movzbl %al,%eax
ffff800000100d25:	c1 e0 08             	shl    $0x8,%eax
ffff800000100d28:	89 45 fc             	mov    %eax,-0x4(%rbp)
  outb(CRTPORT, 15);
ffff800000100d2b:	be 0f 00 00 00       	mov    $0xf,%esi
ffff800000100d30:	bf d4 03 00 00       	mov    $0x3d4,%edi
ffff800000100d35:	48 b8 f0 05 10 00 00 	movabs $0xffff8000001005f0,%rax
ffff800000100d3c:	80 ff ff 
ffff800000100d3f:	ff d0                	call   *%rax
  pos |= inb(CRTPORT+1);
ffff800000100d41:	bf d5 03 00 00       	mov    $0x3d5,%edi
ffff800000100d46:	48 b8 d2 05 10 00 00 	movabs $0xffff8000001005d2,%rax
ffff800000100d4d:	80 ff ff 
ffff800000100d50:	ff d0                	call   *%rax
ffff800000100d52:	0f b6 c0             	movzbl %al,%eax
ffff800000100d55:	09 45 fc             	or     %eax,-0x4(%rbp)

  if (c == '\n')
ffff800000100d58:	83 7d ec 0a          	cmpl   $0xa,-0x14(%rbp)
ffff800000100d5c:	75 37                	jne    ffff800000100d95 <cgaputc+0xa5>
    pos += 80 - pos%80;
ffff800000100d5e:	8b 4d fc             	mov    -0x4(%rbp),%ecx
ffff800000100d61:	48 63 c1             	movslq %ecx,%rax
ffff800000100d64:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
ffff800000100d6b:	48 c1 e8 20          	shr    $0x20,%rax
ffff800000100d6f:	89 c2                	mov    %eax,%edx
ffff800000100d71:	c1 fa 05             	sar    $0x5,%edx
ffff800000100d74:	89 c8                	mov    %ecx,%eax
ffff800000100d76:	c1 f8 1f             	sar    $0x1f,%eax
ffff800000100d79:	29 c2                	sub    %eax,%edx
ffff800000100d7b:	89 d0                	mov    %edx,%eax
ffff800000100d7d:	c1 e0 02             	shl    $0x2,%eax
ffff800000100d80:	01 d0                	add    %edx,%eax
ffff800000100d82:	c1 e0 04             	shl    $0x4,%eax
ffff800000100d85:	29 c1                	sub    %eax,%ecx
ffff800000100d87:	89 ca                	mov    %ecx,%edx
ffff800000100d89:	b8 50 00 00 00       	mov    $0x50,%eax
ffff800000100d8e:	29 d0                	sub    %edx,%eax
ffff800000100d90:	01 45 fc             	add    %eax,-0x4(%rbp)
ffff800000100d93:	eb 43                	jmp    ffff800000100dd8 <cgaputc+0xe8>
  else if (c == BACKSPACE) {
ffff800000100d95:	81 7d ec 00 01 00 00 	cmpl   $0x100,-0x14(%rbp)
ffff800000100d9c:	75 0c                	jne    ffff800000100daa <cgaputc+0xba>
    if (pos > 0) --pos;
ffff800000100d9e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000100da2:	7e 34                	jle    ffff800000100dd8 <cgaputc+0xe8>
ffff800000100da4:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
ffff800000100da8:	eb 2e                	jmp    ffff800000100dd8 <cgaputc+0xe8>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // gray on black
ffff800000100daa:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000100dad:	0f b6 c0             	movzbl %al,%eax
ffff800000100db0:	80 cc 07             	or     $0x7,%ah
ffff800000100db3:	89 c6                	mov    %eax,%esi
ffff800000100db5:	48 b8 18 d0 10 00 00 	movabs $0xffff80000010d018,%rax
ffff800000100dbc:	80 ff ff 
ffff800000100dbf:	48 8b 08             	mov    (%rax),%rcx
ffff800000100dc2:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000100dc5:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000100dc8:	89 55 fc             	mov    %edx,-0x4(%rbp)
ffff800000100dcb:	48 98                	cltq
ffff800000100dcd:	48 01 c0             	add    %rax,%rax
ffff800000100dd0:	48 01 c8             	add    %rcx,%rax
ffff800000100dd3:	89 f2                	mov    %esi,%edx
ffff800000100dd5:	66 89 10             	mov    %dx,(%rax)

  if ((pos/80) >= 24){  // Scroll up.
ffff800000100dd8:	81 7d fc 7f 07 00 00 	cmpl   $0x77f,-0x4(%rbp)
ffff800000100ddf:	7e 74                	jle    ffff800000100e55 <cgaputc+0x165>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
ffff800000100de1:	48 b8 18 d0 10 00 00 	movabs $0xffff80000010d018,%rax
ffff800000100de8:	80 ff ff 
ffff800000100deb:	48 8b 00             	mov    (%rax),%rax
ffff800000100dee:	48 8d 88 a0 00 00 00 	lea    0xa0(%rax),%rcx
ffff800000100df5:	48 b8 18 d0 10 00 00 	movabs $0xffff80000010d018,%rax
ffff800000100dfc:	80 ff ff 
ffff800000100dff:	48 8b 00             	mov    (%rax),%rax
ffff800000100e02:	ba 60 0e 00 00       	mov    $0xe60,%edx
ffff800000100e07:	48 89 ce             	mov    %rcx,%rsi
ffff800000100e0a:	48 89 c7             	mov    %rax,%rdi
ffff800000100e0d:	48 b8 d3 7b 10 00 00 	movabs $0xffff800000107bd3,%rax
ffff800000100e14:	80 ff ff 
ffff800000100e17:	ff d0                	call   *%rax
    pos -= 80;
ffff800000100e19:	83 6d fc 50          	subl   $0x50,-0x4(%rbp)
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
ffff800000100e1d:	b8 80 07 00 00       	mov    $0x780,%eax
ffff800000100e22:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff800000100e25:	8d 14 00             	lea    (%rax,%rax,1),%edx
ffff800000100e28:	48 b8 18 d0 10 00 00 	movabs $0xffff80000010d018,%rax
ffff800000100e2f:	80 ff ff 
ffff800000100e32:	48 8b 00             	mov    (%rax),%rax
ffff800000100e35:	8b 4d fc             	mov    -0x4(%rbp),%ecx
ffff800000100e38:	48 63 c9             	movslq %ecx,%rcx
ffff800000100e3b:	48 01 c9             	add    %rcx,%rcx
ffff800000100e3e:	48 01 c8             	add    %rcx,%rax
ffff800000100e41:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000100e46:	48 89 c7             	mov    %rax,%rdi
ffff800000100e49:	48 b8 ce 7a 10 00 00 	movabs $0xffff800000107ace,%rax
ffff800000100e50:	80 ff ff 
ffff800000100e53:	ff d0                	call   *%rax
  }

  outb(CRTPORT, 14);
ffff800000100e55:	be 0e 00 00 00       	mov    $0xe,%esi
ffff800000100e5a:	bf d4 03 00 00       	mov    $0x3d4,%edi
ffff800000100e5f:	48 b8 f0 05 10 00 00 	movabs $0xffff8000001005f0,%rax
ffff800000100e66:	80 ff ff 
ffff800000100e69:	ff d0                	call   *%rax
  outb(CRTPORT+1, pos>>8);
ffff800000100e6b:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000100e6e:	c1 f8 08             	sar    $0x8,%eax
ffff800000100e71:	0f b6 c0             	movzbl %al,%eax
ffff800000100e74:	89 c6                	mov    %eax,%esi
ffff800000100e76:	bf d5 03 00 00       	mov    $0x3d5,%edi
ffff800000100e7b:	48 b8 f0 05 10 00 00 	movabs $0xffff8000001005f0,%rax
ffff800000100e82:	80 ff ff 
ffff800000100e85:	ff d0                	call   *%rax
  outb(CRTPORT, 15);
ffff800000100e87:	be 0f 00 00 00       	mov    $0xf,%esi
ffff800000100e8c:	bf d4 03 00 00       	mov    $0x3d4,%edi
ffff800000100e91:	48 b8 f0 05 10 00 00 	movabs $0xffff8000001005f0,%rax
ffff800000100e98:	80 ff ff 
ffff800000100e9b:	ff d0                	call   *%rax
  outb(CRTPORT+1, pos);
ffff800000100e9d:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000100ea0:	0f b6 c0             	movzbl %al,%eax
ffff800000100ea3:	89 c6                	mov    %eax,%esi
ffff800000100ea5:	bf d5 03 00 00       	mov    $0x3d5,%edi
ffff800000100eaa:	48 b8 f0 05 10 00 00 	movabs $0xffff8000001005f0,%rax
ffff800000100eb1:	80 ff ff 
ffff800000100eb4:	ff d0                	call   *%rax
  crt[pos] = ' ' | 0x0700;
ffff800000100eb6:	48 b8 18 d0 10 00 00 	movabs $0xffff80000010d018,%rax
ffff800000100ebd:	80 ff ff 
ffff800000100ec0:	48 8b 00             	mov    (%rax),%rax
ffff800000100ec3:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000100ec6:	48 63 d2             	movslq %edx,%rdx
ffff800000100ec9:	48 01 d2             	add    %rdx,%rdx
ffff800000100ecc:	48 01 d0             	add    %rdx,%rax
ffff800000100ecf:	66 c7 00 20 07       	movw   $0x720,(%rax)
}
ffff800000100ed4:	90                   	nop
ffff800000100ed5:	c9                   	leave
ffff800000100ed6:	c3                   	ret

ffff800000100ed7 <consputc>:

  void
consputc(int c)
{
ffff800000100ed7:	55                   	push   %rbp
ffff800000100ed8:	48 89 e5             	mov    %rsp,%rbp
ffff800000100edb:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000100edf:	89 7d fc             	mov    %edi,-0x4(%rbp)
  if (panicked) {
ffff800000100ee2:	48 b8 b8 34 11 00 00 	movabs $0xffff8000001134b8,%rax
ffff800000100ee9:	80 ff ff 
ffff800000100eec:	8b 00                	mov    (%rax),%eax
ffff800000100eee:	85 c0                	test   %eax,%eax
ffff800000100ef0:	74 1a                	je     ffff800000100f0c <consputc+0x35>
    cli();
ffff800000100ef2:	48 b8 66 06 10 00 00 	movabs $0xffff800000100666,%rax
ffff800000100ef9:	80 ff ff 
ffff800000100efc:	ff d0                	call   *%rax
    for(;;)
      hlt();
ffff800000100efe:	48 b8 6e 06 10 00 00 	movabs $0xffff80000010066e,%rax
ffff800000100f05:	80 ff ff 
ffff800000100f08:	ff d0                	call   *%rax
ffff800000100f0a:	eb f2                	jmp    ffff800000100efe <consputc+0x27>
  }

  if (c == BACKSPACE) {
ffff800000100f0c:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
ffff800000100f13:	75 35                	jne    ffff800000100f4a <consputc+0x73>
    uartputc('\b'); uartputc(' '); uartputc('\b');
ffff800000100f15:	bf 08 00 00 00       	mov    $0x8,%edi
ffff800000100f1a:	48 b8 99 9f 10 00 00 	movabs $0xffff800000109f99,%rax
ffff800000100f21:	80 ff ff 
ffff800000100f24:	ff d0                	call   *%rax
ffff800000100f26:	bf 20 00 00 00       	mov    $0x20,%edi
ffff800000100f2b:	48 b8 99 9f 10 00 00 	movabs $0xffff800000109f99,%rax
ffff800000100f32:	80 ff ff 
ffff800000100f35:	ff d0                	call   *%rax
ffff800000100f37:	bf 08 00 00 00       	mov    $0x8,%edi
ffff800000100f3c:	48 b8 99 9f 10 00 00 	movabs $0xffff800000109f99,%rax
ffff800000100f43:	80 ff ff 
ffff800000100f46:	ff d0                	call   *%rax
ffff800000100f48:	eb 11                	jmp    ffff800000100f5b <consputc+0x84>
  } else
    uartputc(c);
ffff800000100f4a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000100f4d:	89 c7                	mov    %eax,%edi
ffff800000100f4f:	48 b8 99 9f 10 00 00 	movabs $0xffff800000109f99,%rax
ffff800000100f56:	80 ff ff 
ffff800000100f59:	ff d0                	call   *%rax
  cgaputc(c);
ffff800000100f5b:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000100f5e:	89 c7                	mov    %eax,%edi
ffff800000100f60:	48 b8 f0 0c 10 00 00 	movabs $0xffff800000100cf0,%rax
ffff800000100f67:	80 ff ff 
ffff800000100f6a:	ff d0                	call   *%rax
}
ffff800000100f6c:	90                   	nop
ffff800000100f6d:	c9                   	leave
ffff800000100f6e:	c3                   	ret

ffff800000100f6f <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

  void
consoleintr(int (*getc)(void))
{
ffff800000100f6f:	55                   	push   %rbp
ffff800000100f70:	48 89 e5             	mov    %rsp,%rbp
ffff800000100f73:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000100f77:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int c;

  acquire(&input.lock);
ffff800000100f7b:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000100f82:	80 ff ff 
ffff800000100f85:	48 89 c7             	mov    %rax,%rdi
ffff800000100f88:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff800000100f8f:	80 ff ff 
ffff800000100f92:	ff d0                	call   *%rax
  while((c = getc()) >= 0){
ffff800000100f94:	e9 6d 02 00 00       	jmp    ffff800000101206 <consoleintr+0x297>
    switch(c){
ffff800000100f99:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
ffff800000100f9d:	0f 84 fd 00 00 00    	je     ffff8000001010a0 <consoleintr+0x131>
ffff800000100fa3:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
ffff800000100fa7:	0f 8f 54 01 00 00    	jg     ffff800000101101 <consoleintr+0x192>
ffff800000100fad:	83 7d fc 1a          	cmpl   $0x1a,-0x4(%rbp)
ffff800000100fb1:	74 2f                	je     ffff800000100fe2 <consoleintr+0x73>
ffff800000100fb3:	83 7d fc 1a          	cmpl   $0x1a,-0x4(%rbp)
ffff800000100fb7:	0f 8f 44 01 00 00    	jg     ffff800000101101 <consoleintr+0x192>
ffff800000100fbd:	83 7d fc 15          	cmpl   $0x15,-0x4(%rbp)
ffff800000100fc1:	74 7f                	je     ffff800000101042 <consoleintr+0xd3>
ffff800000100fc3:	83 7d fc 15          	cmpl   $0x15,-0x4(%rbp)
ffff800000100fc7:	0f 8f 34 01 00 00    	jg     ffff800000101101 <consoleintr+0x192>
ffff800000100fcd:	83 7d fc 08          	cmpl   $0x8,-0x4(%rbp)
ffff800000100fd1:	0f 84 c9 00 00 00    	je     ffff8000001010a0 <consoleintr+0x131>
ffff800000100fd7:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
ffff800000100fdb:	74 20                	je     ffff800000100ffd <consoleintr+0x8e>
ffff800000100fdd:	e9 1f 01 00 00       	jmp    ffff800000101101 <consoleintr+0x192>
    case C('Z'): // reboot
      lidt(0,0);
ffff800000100fe2:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000100fe7:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000100fec:	48 b8 0f 06 10 00 00 	movabs $0xffff80000010060f,%rax
ffff800000100ff3:	80 ff ff 
ffff800000100ff6:	ff d0                	call   *%rax
      break;
ffff800000100ff8:	e9 09 02 00 00       	jmp    ffff800000101206 <consoleintr+0x297>
    case C('P'):  // Process listing.
      procdump();
ffff800000100ffd:	48 b8 d4 70 10 00 00 	movabs $0xffff8000001070d4,%rax
ffff800000101004:	80 ff ff 
ffff800000101007:	ff d0                	call   *%rax
      break;
ffff800000101009:	e9 f8 01 00 00       	jmp    ffff800000101206 <consoleintr+0x297>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
          input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
ffff80000010100e:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000101015:	80 ff ff 
ffff800000101018:	8b 80 f0 00 00 00    	mov    0xf0(%rax),%eax
ffff80000010101e:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000101021:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000101028:	80 ff ff 
ffff80000010102b:	89 90 f0 00 00 00    	mov    %edx,0xf0(%rax)
        consputc(BACKSPACE);
ffff800000101031:	bf 00 01 00 00       	mov    $0x100,%edi
ffff800000101036:	48 b8 d7 0e 10 00 00 	movabs $0xffff800000100ed7,%rax
ffff80000010103d:	80 ff ff 
ffff800000101040:	ff d0                	call   *%rax
      while(input.e != input.w &&
ffff800000101042:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000101049:	80 ff ff 
ffff80000010104c:	8b 90 f0 00 00 00    	mov    0xf0(%rax),%edx
ffff800000101052:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000101059:	80 ff ff 
ffff80000010105c:	8b 80 ec 00 00 00    	mov    0xec(%rax),%eax
ffff800000101062:	39 c2                	cmp    %eax,%edx
ffff800000101064:	0f 84 95 01 00 00    	je     ffff8000001011ff <consoleintr+0x290>
          input.buf[(input.e-1) % INPUT_BUF] != '\n'){
ffff80000010106a:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000101071:	80 ff ff 
ffff800000101074:	8b 80 f0 00 00 00    	mov    0xf0(%rax),%eax
ffff80000010107a:	83 e8 01             	sub    $0x1,%eax
ffff80000010107d:	83 e0 7f             	and    $0x7f,%eax
ffff800000101080:	89 c2                	mov    %eax,%edx
ffff800000101082:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000101089:	80 ff ff 
ffff80000010108c:	89 d2                	mov    %edx,%edx
ffff80000010108e:	0f b6 44 10 68       	movzbl 0x68(%rax,%rdx,1),%eax
      while(input.e != input.w &&
ffff800000101093:	3c 0a                	cmp    $0xa,%al
ffff800000101095:	0f 85 73 ff ff ff    	jne    ffff80000010100e <consoleintr+0x9f>
      }
      break;
ffff80000010109b:	e9 5f 01 00 00       	jmp    ffff8000001011ff <consoleintr+0x290>
    case C('H'): case '\x7f':  // Backspace
      if (input.e != input.w) {
ffff8000001010a0:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff8000001010a7:	80 ff ff 
ffff8000001010aa:	8b 90 f0 00 00 00    	mov    0xf0(%rax),%edx
ffff8000001010b0:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff8000001010b7:	80 ff ff 
ffff8000001010ba:	8b 80 ec 00 00 00    	mov    0xec(%rax),%eax
ffff8000001010c0:	39 c2                	cmp    %eax,%edx
ffff8000001010c2:	0f 84 3a 01 00 00    	je     ffff800000101202 <consoleintr+0x293>
        input.e--;
ffff8000001010c8:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff8000001010cf:	80 ff ff 
ffff8000001010d2:	8b 80 f0 00 00 00    	mov    0xf0(%rax),%eax
ffff8000001010d8:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff8000001010db:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff8000001010e2:	80 ff ff 
ffff8000001010e5:	89 90 f0 00 00 00    	mov    %edx,0xf0(%rax)
        consputc(BACKSPACE);
ffff8000001010eb:	bf 00 01 00 00       	mov    $0x100,%edi
ffff8000001010f0:	48 b8 d7 0e 10 00 00 	movabs $0xffff800000100ed7,%rax
ffff8000001010f7:	80 ff ff 
ffff8000001010fa:	ff d0                	call   *%rax
      }
      break;
ffff8000001010fc:	e9 01 01 00 00       	jmp    ffff800000101202 <consoleintr+0x293>
    default:
      if (c != 0 && input.e-input.r < INPUT_BUF) {
ffff800000101101:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000101105:	0f 84 fa 00 00 00    	je     ffff800000101205 <consoleintr+0x296>
ffff80000010110b:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000101112:	80 ff ff 
ffff800000101115:	8b 90 f0 00 00 00    	mov    0xf0(%rax),%edx
ffff80000010111b:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000101122:	80 ff ff 
ffff800000101125:	8b 80 e8 00 00 00    	mov    0xe8(%rax),%eax
ffff80000010112b:	29 c2                	sub    %eax,%edx
ffff80000010112d:	83 fa 7f             	cmp    $0x7f,%edx
ffff800000101130:	0f 87 cf 00 00 00    	ja     ffff800000101205 <consoleintr+0x296>
        c = (c == '\r') ? '\n' : c;
ffff800000101136:	83 7d fc 0d          	cmpl   $0xd,-0x4(%rbp)
ffff80000010113a:	75 07                	jne    ffff800000101143 <consoleintr+0x1d4>
ffff80000010113c:	c7 45 fc 0a 00 00 00 	movl   $0xa,-0x4(%rbp)
        input.buf[input.e++ % INPUT_BUF] = c;
ffff800000101143:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff80000010114a:	80 ff ff 
ffff80000010114d:	8b 80 f0 00 00 00    	mov    0xf0(%rax),%eax
ffff800000101153:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000101156:	48 b9 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rcx
ffff80000010115d:	80 ff ff 
ffff800000101160:	89 91 f0 00 00 00    	mov    %edx,0xf0(%rcx)
ffff800000101166:	83 e0 7f             	and    $0x7f,%eax
ffff800000101169:	89 c2                	mov    %eax,%edx
ffff80000010116b:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010116e:	89 c1                	mov    %eax,%ecx
ffff800000101170:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000101177:	80 ff ff 
ffff80000010117a:	89 d2                	mov    %edx,%edx
ffff80000010117c:	88 4c 10 68          	mov    %cl,0x68(%rax,%rdx,1)
        consputc(c);
ffff800000101180:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000101183:	89 c7                	mov    %eax,%edi
ffff800000101185:	48 b8 d7 0e 10 00 00 	movabs $0xffff800000100ed7,%rax
ffff80000010118c:	80 ff ff 
ffff80000010118f:	ff d0                	call   *%rax
        if (c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF) {
ffff800000101191:	83 7d fc 0a          	cmpl   $0xa,-0x4(%rbp)
ffff800000101195:	74 2d                	je     ffff8000001011c4 <consoleintr+0x255>
ffff800000101197:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
ffff80000010119b:	74 27                	je     ffff8000001011c4 <consoleintr+0x255>
ffff80000010119d:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff8000001011a4:	80 ff ff 
ffff8000001011a7:	8b 90 f0 00 00 00    	mov    0xf0(%rax),%edx
ffff8000001011ad:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff8000001011b4:	80 ff ff 
ffff8000001011b7:	8b 80 e8 00 00 00    	mov    0xe8(%rax),%eax
ffff8000001011bd:	83 e8 80             	sub    $0xffffff80,%eax
ffff8000001011c0:	39 c2                	cmp    %eax,%edx
ffff8000001011c2:	75 41                	jne    ffff800000101205 <consoleintr+0x296>
          input.w = input.e;
ffff8000001011c4:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff8000001011cb:	80 ff ff 
ffff8000001011ce:	8b 80 f0 00 00 00    	mov    0xf0(%rax),%eax
ffff8000001011d4:	48 ba c0 33 11 00 00 	movabs $0xffff8000001133c0,%rdx
ffff8000001011db:	80 ff ff 
ffff8000001011de:	89 82 ec 00 00 00    	mov    %eax,0xec(%rdx)
          wakeup(&input.r);
ffff8000001011e4:	48 b8 a8 34 11 00 00 	movabs $0xffff8000001134a8,%rax
ffff8000001011eb:	80 ff ff 
ffff8000001011ee:	48 89 c7             	mov    %rax,%rdi
ffff8000001011f1:	48 b8 c6 6f 10 00 00 	movabs $0xffff800000106fc6,%rax
ffff8000001011f8:	80 ff ff 
ffff8000001011fb:	ff d0                	call   *%rax
        }
      }
      break;
ffff8000001011fd:	eb 06                	jmp    ffff800000101205 <consoleintr+0x296>
      break;
ffff8000001011ff:	90                   	nop
ffff800000101200:	eb 04                	jmp    ffff800000101206 <consoleintr+0x297>
      break;
ffff800000101202:	90                   	nop
ffff800000101203:	eb 01                	jmp    ffff800000101206 <consoleintr+0x297>
      break;
ffff800000101205:	90                   	nop
  while((c = getc()) >= 0){
ffff800000101206:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010120a:	ff d0                	call   *%rax
ffff80000010120c:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff80000010120f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000101213:	0f 89 80 fd ff ff    	jns    ffff800000100f99 <consoleintr+0x2a>
    }
  }
  release(&input.lock);
ffff800000101219:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000101220:	80 ff ff 
ffff800000101223:	48 89 c7             	mov    %rax,%rdi
ffff800000101226:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff80000010122d:	80 ff ff 
ffff800000101230:	ff d0                	call   *%rax
}
ffff800000101232:	90                   	nop
ffff800000101233:	c9                   	leave
ffff800000101234:	c3                   	ret

ffff800000101235 <consoleread>:

  int
consoleread(struct inode *ip, uint off, char *dst, int n)
{
ffff800000101235:	55                   	push   %rbp
ffff800000101236:	48 89 e5             	mov    %rsp,%rbp
ffff800000101239:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010123d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000101241:	89 75 e4             	mov    %esi,-0x1c(%rbp)
ffff800000101244:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
ffff800000101248:	89 4d e0             	mov    %ecx,-0x20(%rbp)
  uint target;
  int c;

  iunlock(ip);
ffff80000010124b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010124f:	48 89 c7             	mov    %rax,%rdi
ffff800000101252:	48 b8 23 2a 10 00 00 	movabs $0xffff800000102a23,%rax
ffff800000101259:	80 ff ff 
ffff80000010125c:	ff d0                	call   *%rax
  target = n;
ffff80000010125e:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff800000101261:	89 45 fc             	mov    %eax,-0x4(%rbp)
  acquire(&input.lock);
ffff800000101264:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff80000010126b:	80 ff ff 
ffff80000010126e:	48 89 c7             	mov    %rax,%rdi
ffff800000101271:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff800000101278:	80 ff ff 
ffff80000010127b:	ff d0                	call   *%rax
  while(n > 0){
ffff80000010127d:	e9 23 01 00 00       	jmp    ffff8000001013a5 <consoleread+0x170>
    while(input.r == input.w){
      if (proc->killed) {
ffff800000101282:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101289:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010128d:	8b 40 40             	mov    0x40(%rax),%eax
ffff800000101290:	85 c0                	test   %eax,%eax
ffff800000101292:	74 36                	je     ffff8000001012ca <consoleread+0x95>
        release(&input.lock);
ffff800000101294:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff80000010129b:	80 ff ff 
ffff80000010129e:	48 89 c7             	mov    %rax,%rdi
ffff8000001012a1:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff8000001012a8:	80 ff ff 
ffff8000001012ab:	ff d0                	call   *%rax
        ilock(ip);
ffff8000001012ad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001012b1:	48 89 c7             	mov    %rax,%rdi
ffff8000001012b4:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff8000001012bb:	80 ff ff 
ffff8000001012be:	ff d0                	call   *%rax
        return -1;
ffff8000001012c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001012c5:	e9 21 01 00 00       	jmp    ffff8000001013eb <consoleread+0x1b6>
      }
      sleep(&input.r, &input.lock);
ffff8000001012ca:	48 ba c0 33 11 00 00 	movabs $0xffff8000001133c0,%rdx
ffff8000001012d1:	80 ff ff 
ffff8000001012d4:	48 b8 a8 34 11 00 00 	movabs $0xffff8000001134a8,%rax
ffff8000001012db:	80 ff ff 
ffff8000001012de:	48 89 d6             	mov    %rdx,%rsi
ffff8000001012e1:	48 89 c7             	mov    %rax,%rdi
ffff8000001012e4:	48 b8 51 6e 10 00 00 	movabs $0xffff800000106e51,%rax
ffff8000001012eb:	80 ff ff 
ffff8000001012ee:	ff d0                	call   *%rax
    while(input.r == input.w){
ffff8000001012f0:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff8000001012f7:	80 ff ff 
ffff8000001012fa:	8b 90 e8 00 00 00    	mov    0xe8(%rax),%edx
ffff800000101300:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000101307:	80 ff ff 
ffff80000010130a:	8b 80 ec 00 00 00    	mov    0xec(%rax),%eax
ffff800000101310:	39 c2                	cmp    %eax,%edx
ffff800000101312:	0f 84 6a ff ff ff    	je     ffff800000101282 <consoleread+0x4d>
    }
    c = input.buf[input.r++ % INPUT_BUF];
ffff800000101318:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff80000010131f:	80 ff ff 
ffff800000101322:	8b 80 e8 00 00 00    	mov    0xe8(%rax),%eax
ffff800000101328:	8d 50 01             	lea    0x1(%rax),%edx
ffff80000010132b:	48 b9 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rcx
ffff800000101332:	80 ff ff 
ffff800000101335:	89 91 e8 00 00 00    	mov    %edx,0xe8(%rcx)
ffff80000010133b:	83 e0 7f             	and    $0x7f,%eax
ffff80000010133e:	89 c2                	mov    %eax,%edx
ffff800000101340:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000101347:	80 ff ff 
ffff80000010134a:	89 d2                	mov    %edx,%edx
ffff80000010134c:	0f b6 44 10 68       	movzbl 0x68(%rax,%rdx,1),%eax
ffff800000101351:	0f be c0             	movsbl %al,%eax
ffff800000101354:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if (c == C('D')) {  // EOF
ffff800000101357:	83 7d f8 04          	cmpl   $0x4,-0x8(%rbp)
ffff80000010135b:	75 2d                	jne    ffff80000010138a <consoleread+0x155>
      if (n < target) {
ffff80000010135d:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff800000101360:	3b 45 fc             	cmp    -0x4(%rbp),%eax
ffff800000101363:	73 4c                	jae    ffff8000001013b1 <consoleread+0x17c>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
ffff800000101365:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff80000010136c:	80 ff ff 
ffff80000010136f:	8b 80 e8 00 00 00    	mov    0xe8(%rax),%eax
ffff800000101375:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000101378:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff80000010137f:	80 ff ff 
ffff800000101382:	89 90 e8 00 00 00    	mov    %edx,0xe8(%rax)
      }
      break;
ffff800000101388:	eb 27                	jmp    ffff8000001013b1 <consoleread+0x17c>
    }
    *dst++ = c;
ffff80000010138a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010138e:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff800000101392:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
ffff800000101396:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffff800000101399:	88 10                	mov    %dl,(%rax)
    --n;
ffff80000010139b:	83 6d e0 01          	subl   $0x1,-0x20(%rbp)
    if (c == '\n')
ffff80000010139f:	83 7d f8 0a          	cmpl   $0xa,-0x8(%rbp)
ffff8000001013a3:	74 0f                	je     ffff8000001013b4 <consoleread+0x17f>
  while(n > 0){
ffff8000001013a5:	83 7d e0 00          	cmpl   $0x0,-0x20(%rbp)
ffff8000001013a9:	0f 8f 41 ff ff ff    	jg     ffff8000001012f0 <consoleread+0xbb>
ffff8000001013af:	eb 04                	jmp    ffff8000001013b5 <consoleread+0x180>
      break;
ffff8000001013b1:	90                   	nop
ffff8000001013b2:	eb 01                	jmp    ffff8000001013b5 <consoleread+0x180>
      break;
ffff8000001013b4:	90                   	nop
  }
  release(&input.lock);
ffff8000001013b5:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff8000001013bc:	80 ff ff 
ffff8000001013bf:	48 89 c7             	mov    %rax,%rdi
ffff8000001013c2:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff8000001013c9:	80 ff ff 
ffff8000001013cc:	ff d0                	call   *%rax
  ilock(ip);
ffff8000001013ce:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001013d2:	48 89 c7             	mov    %rax,%rdi
ffff8000001013d5:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff8000001013dc:	80 ff ff 
ffff8000001013df:	ff d0                	call   *%rax

  return target - n;
ffff8000001013e1:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff8000001013e4:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001013e7:	29 c2                	sub    %eax,%edx
ffff8000001013e9:	89 d0                	mov    %edx,%eax
}
ffff8000001013eb:	c9                   	leave
ffff8000001013ec:	c3                   	ret

ffff8000001013ed <consolewrite>:

  int
consolewrite(struct inode *ip, uint off, char *buf, int n)
{
ffff8000001013ed:	55                   	push   %rbp
ffff8000001013ee:	48 89 e5             	mov    %rsp,%rbp
ffff8000001013f1:	48 83 ec 30          	sub    $0x30,%rsp
ffff8000001013f5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff8000001013f9:	89 75 e4             	mov    %esi,-0x1c(%rbp)
ffff8000001013fc:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
ffff800000101400:	89 4d e0             	mov    %ecx,-0x20(%rbp)
  int i;

  iunlock(ip);
ffff800000101403:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101407:	48 89 c7             	mov    %rax,%rdi
ffff80000010140a:	48 b8 23 2a 10 00 00 	movabs $0xffff800000102a23,%rax
ffff800000101411:	80 ff ff 
ffff800000101414:	ff d0                	call   *%rax
  acquire(&cons.lock);
ffff800000101416:	48 b8 c0 34 11 00 00 	movabs $0xffff8000001134c0,%rax
ffff80000010141d:	80 ff ff 
ffff800000101420:	48 89 c7             	mov    %rax,%rdi
ffff800000101423:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff80000010142a:	80 ff ff 
ffff80000010142d:	ff d0                	call   *%rax
  for(i = 0; i < n; i++)
ffff80000010142f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000101436:	eb 28                	jmp    ffff800000101460 <consolewrite+0x73>
    consputc(buf[i] & 0xff);
ffff800000101438:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010143b:	48 63 d0             	movslq %eax,%rdx
ffff80000010143e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000101442:	48 01 d0             	add    %rdx,%rax
ffff800000101445:	0f b6 00             	movzbl (%rax),%eax
ffff800000101448:	0f be c0             	movsbl %al,%eax
ffff80000010144b:	0f b6 c0             	movzbl %al,%eax
ffff80000010144e:	89 c7                	mov    %eax,%edi
ffff800000101450:	48 b8 d7 0e 10 00 00 	movabs $0xffff800000100ed7,%rax
ffff800000101457:	80 ff ff 
ffff80000010145a:	ff d0                	call   *%rax
  for(i = 0; i < n; i++)
ffff80000010145c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000101460:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000101463:	3b 45 e0             	cmp    -0x20(%rbp),%eax
ffff800000101466:	7c d0                	jl     ffff800000101438 <consolewrite+0x4b>
  release(&cons.lock);
ffff800000101468:	48 b8 c0 34 11 00 00 	movabs $0xffff8000001134c0,%rax
ffff80000010146f:	80 ff ff 
ffff800000101472:	48 89 c7             	mov    %rax,%rdi
ffff800000101475:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff80000010147c:	80 ff ff 
ffff80000010147f:	ff d0                	call   *%rax
  ilock(ip);
ffff800000101481:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101485:	48 89 c7             	mov    %rax,%rdi
ffff800000101488:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff80000010148f:	80 ff ff 
ffff800000101492:	ff d0                	call   *%rax

  return n;
ffff800000101494:	8b 45 e0             	mov    -0x20(%rbp),%eax
}
ffff800000101497:	c9                   	leave
ffff800000101498:	c3                   	ret

ffff800000101499 <consoleinit>:

  void
consoleinit(void)
{
ffff800000101499:	55                   	push   %rbp
ffff80000010149a:	48 89 e5             	mov    %rsp,%rbp
  initlock(&cons.lock, "console");
ffff80000010149d:	48 ba ab c0 10 00 00 	movabs $0xffff80000010c0ab,%rdx
ffff8000001014a4:	80 ff ff 
ffff8000001014a7:	48 b8 c0 34 11 00 00 	movabs $0xffff8000001134c0,%rax
ffff8000001014ae:	80 ff ff 
ffff8000001014b1:	48 89 d6             	mov    %rdx,%rsi
ffff8000001014b4:	48 89 c7             	mov    %rax,%rdi
ffff8000001014b7:	48 b8 05 77 10 00 00 	movabs $0xffff800000107705,%rax
ffff8000001014be:	80 ff ff 
ffff8000001014c1:	ff d0                	call   *%rax
  initlock(&input.lock, "input");
ffff8000001014c3:	48 ba b3 c0 10 00 00 	movabs $0xffff80000010c0b3,%rdx
ffff8000001014ca:	80 ff ff 
ffff8000001014cd:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff8000001014d4:	80 ff ff 
ffff8000001014d7:	48 89 d6             	mov    %rdx,%rsi
ffff8000001014da:	48 89 c7             	mov    %rax,%rdi
ffff8000001014dd:	48 b8 05 77 10 00 00 	movabs $0xffff800000107705,%rax
ffff8000001014e4:	80 ff ff 
ffff8000001014e7:	ff d0                	call   *%rax

  devsw[CONSOLE].write = consolewrite;
ffff8000001014e9:	48 b8 40 35 11 00 00 	movabs $0xffff800000113540,%rax
ffff8000001014f0:	80 ff ff 
ffff8000001014f3:	48 b9 ed 13 10 00 00 	movabs $0xffff8000001013ed,%rcx
ffff8000001014fa:	80 ff ff 
ffff8000001014fd:	48 89 48 18          	mov    %rcx,0x18(%rax)
  devsw[CONSOLE].read = consoleread;
ffff800000101501:	48 b8 40 35 11 00 00 	movabs $0xffff800000113540,%rax
ffff800000101508:	80 ff ff 
ffff80000010150b:	48 b9 35 12 10 00 00 	movabs $0xffff800000101235,%rcx
ffff800000101512:	80 ff ff 
ffff800000101515:	48 89 48 10          	mov    %rcx,0x10(%rax)
  cons.locking = 1;
ffff800000101519:	48 b8 c0 34 11 00 00 	movabs $0xffff8000001134c0,%rax
ffff800000101520:	80 ff ff 
ffff800000101523:	c7 40 68 01 00 00 00 	movl   $0x1,0x68(%rax)

  ioapicenable(IRQ_KBD, 0);
ffff80000010152a:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010152f:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000101534:	48 b8 6e 3f 10 00 00 	movabs $0xffff800000103f6e,%rax
ffff80000010153b:	80 ff ff 
ffff80000010153e:	ff d0                	call   *%rax
}
ffff800000101540:	90                   	nop
ffff800000101541:	5d                   	pop    %rbp
ffff800000101542:	c3                   	ret

ffff800000101543 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
ffff800000101543:	55                   	push   %rbp
ffff800000101544:	48 89 e5             	mov    %rsp,%rbp
ffff800000101547:	48 81 ec 00 02 00 00 	sub    $0x200,%rsp
ffff80000010154e:	48 89 bd 08 fe ff ff 	mov    %rdi,-0x1f8(%rbp)
ffff800000101555:	48 89 b5 00 fe ff ff 	mov    %rsi,-0x200(%rbp)
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  oldpgdir = proc->pgdir;
ffff80000010155c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101563:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101567:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010156b:	48 89 45 b8          	mov    %rax,-0x48(%rbp)

  begin_op();
ffff80000010156f:	48 b8 bd 4e 10 00 00 	movabs $0xffff800000104ebd,%rax
ffff800000101576:	80 ff ff 
ffff800000101579:	ff d0                	call   *%rax

  if((ip = namei(path)) == 0){
ffff80000010157b:	48 8b 85 08 fe ff ff 	mov    -0x1f8(%rbp),%rax
ffff800000101582:	48 89 c7             	mov    %rax,%rdi
ffff800000101585:	48 b8 93 37 10 00 00 	movabs $0xffff800000103793,%rax
ffff80000010158c:	80 ff ff 
ffff80000010158f:	ff d0                	call   *%rax
ffff800000101591:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
ffff800000101595:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
ffff80000010159a:	75 16                	jne    ffff8000001015b2 <exec+0x6f>
    end_op();
ffff80000010159c:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff8000001015a3:	80 ff ff 
ffff8000001015a6:	ff d0                	call   *%rax
    return -1;
ffff8000001015a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001015ad:	e9 69 05 00 00       	jmp    ffff800000101b1b <exec+0x5d8>
  }
  ilock(ip);
ffff8000001015b2:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff8000001015b6:	48 89 c7             	mov    %rax,%rdi
ffff8000001015b9:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff8000001015c0:	80 ff ff 
ffff8000001015c3:	ff d0                	call   *%rax
  pgdir = 0;
ffff8000001015c5:	48 c7 45 c0 00 00 00 	movq   $0x0,-0x40(%rbp)
ffff8000001015cc:	00 

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
ffff8000001015cd:	48 8d b5 50 fe ff ff 	lea    -0x1b0(%rbp),%rsi
ffff8000001015d4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff8000001015d8:	b9 40 00 00 00       	mov    $0x40,%ecx
ffff8000001015dd:	ba 00 00 00 00       	mov    $0x0,%edx
ffff8000001015e2:	48 89 c7             	mov    %rax,%rdi
ffff8000001015e5:	48 b8 f5 2e 10 00 00 	movabs $0xffff800000102ef5,%rax
ffff8000001015ec:	80 ff ff 
ffff8000001015ef:	ff d0                	call   *%rax
ffff8000001015f1:	83 f8 40             	cmp    $0x40,%eax
ffff8000001015f4:	0f 85 b7 04 00 00    	jne    ffff800000101ab1 <exec+0x56e>
    goto bad;
  if(elf.magic != ELF_MAGIC)
ffff8000001015fa:	8b 85 50 fe ff ff    	mov    -0x1b0(%rbp),%eax
ffff800000101600:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
ffff800000101605:	0f 85 a9 04 00 00    	jne    ffff800000101ab4 <exec+0x571>
    goto bad;

  if((pgdir = setupkvm()) == 0)
ffff80000010160b:	48 b8 63 b0 10 00 00 	movabs $0xffff80000010b063,%rax
ffff800000101612:	80 ff ff 
ffff800000101615:	ff d0                	call   *%rax
ffff800000101617:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
ffff80000010161b:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
ffff800000101620:	0f 84 91 04 00 00    	je     ffff800000101ab7 <exec+0x574>
    goto bad;

  // Load program into memory.
  sz = PGSIZE; // skip the first page
ffff800000101626:	48 c7 45 d8 00 10 00 	movq   $0x1000,-0x28(%rbp)
ffff80000010162d:	00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
ffff80000010162e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
ffff800000101635:	48 8b 85 70 fe ff ff 	mov    -0x190(%rbp),%rax
ffff80000010163c:	89 45 e8             	mov    %eax,-0x18(%rbp)
ffff80000010163f:	e9 0f 01 00 00       	jmp    ffff800000101753 <exec+0x210>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
ffff800000101644:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffff800000101647:	48 8d b5 10 fe ff ff 	lea    -0x1f0(%rbp),%rsi
ffff80000010164e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff800000101652:	b9 38 00 00 00       	mov    $0x38,%ecx
ffff800000101657:	48 89 c7             	mov    %rax,%rdi
ffff80000010165a:	48 b8 f5 2e 10 00 00 	movabs $0xffff800000102ef5,%rax
ffff800000101661:	80 ff ff 
ffff800000101664:	ff d0                	call   *%rax
ffff800000101666:	83 f8 38             	cmp    $0x38,%eax
ffff800000101669:	0f 85 4b 04 00 00    	jne    ffff800000101aba <exec+0x577>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
ffff80000010166f:	8b 85 10 fe ff ff    	mov    -0x1f0(%rbp),%eax
ffff800000101675:	83 f8 01             	cmp    $0x1,%eax
ffff800000101678:	0f 85 c7 00 00 00    	jne    ffff800000101745 <exec+0x202>
      continue;
    if(ph.memsz < ph.filesz)
ffff80000010167e:	48 8b 95 38 fe ff ff 	mov    -0x1c8(%rbp),%rdx
ffff800000101685:	48 8b 85 30 fe ff ff 	mov    -0x1d0(%rbp),%rax
ffff80000010168c:	48 39 c2             	cmp    %rax,%rdx
ffff80000010168f:	0f 82 28 04 00 00    	jb     ffff800000101abd <exec+0x57a>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
ffff800000101695:	48 8b 95 20 fe ff ff 	mov    -0x1e0(%rbp),%rdx
ffff80000010169c:	48 8b 85 38 fe ff ff 	mov    -0x1c8(%rbp),%rax
ffff8000001016a3:	48 01 c2             	add    %rax,%rdx
ffff8000001016a6:	48 8b 85 20 fe ff ff 	mov    -0x1e0(%rbp),%rax
ffff8000001016ad:	48 39 c2             	cmp    %rax,%rdx
ffff8000001016b0:	0f 82 0a 04 00 00    	jb     ffff800000101ac0 <exec+0x57d>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
ffff8000001016b6:	48 8b 95 20 fe ff ff 	mov    -0x1e0(%rbp),%rdx
ffff8000001016bd:	48 8b 85 38 fe ff ff 	mov    -0x1c8(%rbp),%rax
ffff8000001016c4:	48 01 c2             	add    %rax,%rdx
ffff8000001016c7:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff8000001016cb:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff8000001016cf:	48 89 ce             	mov    %rcx,%rsi
ffff8000001016d2:	48 89 c7             	mov    %rax,%rdi
ffff8000001016d5:	48 b8 ba b7 10 00 00 	movabs $0xffff80000010b7ba,%rax
ffff8000001016dc:	80 ff ff 
ffff8000001016df:	ff d0                	call   *%rax
ffff8000001016e1:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
ffff8000001016e5:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
ffff8000001016ea:	0f 84 d3 03 00 00    	je     ffff800000101ac3 <exec+0x580>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
ffff8000001016f0:	48 8b 85 20 fe ff ff 	mov    -0x1e0(%rbp),%rax
ffff8000001016f7:	25 ff 0f 00 00       	and    $0xfff,%eax
ffff8000001016fc:	48 85 c0             	test   %rax,%rax
ffff8000001016ff:	0f 85 c1 03 00 00    	jne    ffff800000101ac6 <exec+0x583>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
ffff800000101705:	48 8b 85 30 fe ff ff 	mov    -0x1d0(%rbp),%rax
ffff80000010170c:	89 c7                	mov    %eax,%edi
ffff80000010170e:	48 8b 85 18 fe ff ff 	mov    -0x1e8(%rbp),%rax
ffff800000101715:	89 c1                	mov    %eax,%ecx
ffff800000101717:	48 8b 85 20 fe ff ff 	mov    -0x1e0(%rbp),%rax
ffff80000010171e:	48 89 c6             	mov    %rax,%rsi
ffff800000101721:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
ffff800000101725:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff800000101729:	41 89 f8             	mov    %edi,%r8d
ffff80000010172c:	48 89 c7             	mov    %rax,%rdi
ffff80000010172f:	48 b8 92 b6 10 00 00 	movabs $0xffff80000010b692,%rax
ffff800000101736:	80 ff ff 
ffff800000101739:	ff d0                	call   *%rax
ffff80000010173b:	85 c0                	test   %eax,%eax
ffff80000010173d:	0f 88 86 03 00 00    	js     ffff800000101ac9 <exec+0x586>
ffff800000101743:	eb 01                	jmp    ffff800000101746 <exec+0x203>
      continue;
ffff800000101745:	90                   	nop
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
ffff800000101746:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
ffff80000010174a:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff80000010174d:	83 c0 38             	add    $0x38,%eax
ffff800000101750:	89 45 e8             	mov    %eax,-0x18(%rbp)
ffff800000101753:	0f b7 85 88 fe ff ff 	movzwl -0x178(%rbp),%eax
ffff80000010175a:	0f b7 c0             	movzwl %ax,%eax
ffff80000010175d:	39 45 ec             	cmp    %eax,-0x14(%rbp)
ffff800000101760:	0f 8c de fe ff ff    	jl     ffff800000101644 <exec+0x101>
      goto bad;
  }
  iunlockput(ip);
ffff800000101766:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010176a:	48 89 c7             	mov    %rax,%rdi
ffff80000010176d:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000101774:	80 ff ff 
ffff800000101777:	ff d0                	call   *%rax
  end_op();
ffff800000101779:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff800000101780:	80 ff ff 
ffff800000101783:	ff d0                	call   *%rax
  ip = 0;
ffff800000101785:	48 c7 45 c8 00 00 00 	movq   $0x0,-0x38(%rbp)
ffff80000010178c:	00 

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
ffff80000010178d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000101791:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffff800000101797:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010179d:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
ffff8000001017a1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001017a5:	48 8d 90 00 20 00 00 	lea    0x2000(%rax),%rdx
ffff8000001017ac:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff8000001017b0:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff8000001017b4:	48 89 ce             	mov    %rcx,%rsi
ffff8000001017b7:	48 89 c7             	mov    %rax,%rdi
ffff8000001017ba:	48 b8 ba b7 10 00 00 	movabs $0xffff80000010b7ba,%rax
ffff8000001017c1:	80 ff ff 
ffff8000001017c4:	ff d0                	call   *%rax
ffff8000001017c6:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
ffff8000001017ca:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
ffff8000001017cf:	0f 84 f7 02 00 00    	je     ffff800000101acc <exec+0x589>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
ffff8000001017d5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001017d9:	48 2d 00 20 00 00    	sub    $0x2000,%rax
ffff8000001017df:	48 89 c2             	mov    %rax,%rdx
ffff8000001017e2:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff8000001017e6:	48 89 d6             	mov    %rdx,%rsi
ffff8000001017e9:	48 89 c7             	mov    %rax,%rdi
ffff8000001017ec:	48 b8 2e bc 10 00 00 	movabs $0xffff80000010bc2e,%rax
ffff8000001017f3:	80 ff ff 
ffff8000001017f6:	ff d0                	call   *%rax
  sp = sz;
ffff8000001017f8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001017fc:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
ffff800000101800:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
ffff800000101807:	00 
ffff800000101808:	e9 c9 00 00 00       	jmp    ffff8000001018d6 <exec+0x393>
    if(argc >= MAXARG)
ffff80000010180d:	48 83 7d e0 1f       	cmpq   $0x1f,-0x20(%rbp)
ffff800000101812:	0f 87 b7 02 00 00    	ja     ffff800000101acf <exec+0x58c>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~(sizeof(addr_t)-1);
ffff800000101818:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010181c:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff800000101823:	00 
ffff800000101824:	48 8b 85 00 fe ff ff 	mov    -0x200(%rbp),%rax
ffff80000010182b:	48 01 d0             	add    %rdx,%rax
ffff80000010182e:	48 8b 00             	mov    (%rax),%rax
ffff800000101831:	48 89 c7             	mov    %rax,%rdi
ffff800000101834:	48 b8 e9 7d 10 00 00 	movabs $0xffff800000107de9,%rax
ffff80000010183b:	80 ff ff 
ffff80000010183e:	ff d0                	call   *%rax
ffff800000101840:	83 c0 01             	add    $0x1,%eax
ffff800000101843:	48 98                	cltq
ffff800000101845:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffff800000101849:	48 29 c2             	sub    %rax,%rdx
ffff80000010184c:	48 89 d0             	mov    %rdx,%rax
ffff80000010184f:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
ffff800000101853:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
ffff800000101857:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010185b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff800000101862:	00 
ffff800000101863:	48 8b 85 00 fe ff ff 	mov    -0x200(%rbp),%rax
ffff80000010186a:	48 01 d0             	add    %rdx,%rax
ffff80000010186d:	48 8b 00             	mov    (%rax),%rax
ffff800000101870:	48 89 c7             	mov    %rax,%rdi
ffff800000101873:	48 b8 e9 7d 10 00 00 	movabs $0xffff800000107de9,%rax
ffff80000010187a:	80 ff ff 
ffff80000010187d:	ff d0                	call   *%rax
ffff80000010187f:	83 c0 01             	add    $0x1,%eax
ffff800000101882:	48 63 c8             	movslq %eax,%rcx
ffff800000101885:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000101889:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff800000101890:	00 
ffff800000101891:	48 8b 85 00 fe ff ff 	mov    -0x200(%rbp),%rax
ffff800000101898:	48 01 d0             	add    %rdx,%rax
ffff80000010189b:	48 8b 10             	mov    (%rax),%rdx
ffff80000010189e:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
ffff8000001018a2:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff8000001018a6:	48 89 c7             	mov    %rax,%rdi
ffff8000001018a9:	48 b8 a0 be 10 00 00 	movabs $0xffff80000010bea0,%rax
ffff8000001018b0:	80 ff ff 
ffff8000001018b3:	ff d0                	call   *%rax
ffff8000001018b5:	85 c0                	test   %eax,%eax
ffff8000001018b7:	0f 88 15 02 00 00    	js     ffff800000101ad2 <exec+0x58f>
      goto bad;
    ustack[1+argc] = sp;
ffff8000001018bd:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001018c1:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff8000001018c5:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff8000001018c9:	48 89 84 d5 90 fe ff 	mov    %rax,-0x170(%rbp,%rdx,8)
ffff8000001018d0:	ff 
  for(argc = 0; argv[argc]; argc++) {
ffff8000001018d1:	48 83 45 e0 01       	addq   $0x1,-0x20(%rbp)
ffff8000001018d6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001018da:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff8000001018e1:	00 
ffff8000001018e2:	48 8b 85 00 fe ff ff 	mov    -0x200(%rbp),%rax
ffff8000001018e9:	48 01 d0             	add    %rdx,%rax
ffff8000001018ec:	48 8b 00             	mov    (%rax),%rax
ffff8000001018ef:	48 85 c0             	test   %rax,%rax
ffff8000001018f2:	0f 85 15 ff ff ff    	jne    ffff80000010180d <exec+0x2ca>
  }
  ustack[1+argc] = 0;
ffff8000001018f8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001018fc:	48 83 c0 01          	add    $0x1,%rax
ffff800000101900:	48 c7 84 c5 90 fe ff 	movq   $0x0,-0x170(%rbp,%rax,8)
ffff800000101907:	ff 00 00 00 00 

  ustack[0] = 0xffffffffffffffff;  // fake return PC
ffff80000010190c:	48 c7 85 90 fe ff ff 	movq   $0xffffffffffffffff,-0x170(%rbp)
ffff800000101913:	ff ff ff ff 

	// argc and argv for main() entry point
  proc->tf->rdi = argc;
ffff800000101917:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010191e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101922:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000101926:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff80000010192a:	48 89 50 30          	mov    %rdx,0x30(%rax)
  proc->tf->rsi = sp - (argc+1)*sizeof(addr_t);
ffff80000010192e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000101932:	48 83 c0 01          	add    $0x1,%rax
ffff800000101936:	48 8d 0c c5 00 00 00 	lea    0x0(,%rax,8),%rcx
ffff80000010193d:	00 
ffff80000010193e:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101945:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101949:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff80000010194d:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffff800000101951:	48 29 ca             	sub    %rcx,%rdx
ffff800000101954:	48 89 50 28          	mov    %rdx,0x28(%rax)

  sp -= (1+argc+1) * sizeof(addr_t);
ffff800000101958:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010195c:	48 83 c0 02          	add    $0x2,%rax
ffff800000101960:	48 c1 e0 03          	shl    $0x3,%rax
ffff800000101964:	48 29 45 d0          	sub    %rax,-0x30(%rbp)
  if(copyout(pgdir, sp, ustack, (1+argc+1)*sizeof(addr_t)) < 0)
ffff800000101968:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010196c:	48 83 c0 02          	add    $0x2,%rax
ffff800000101970:	48 8d 0c c5 00 00 00 	lea    0x0(,%rax,8),%rcx
ffff800000101977:	00 
ffff800000101978:	48 8d 95 90 fe ff ff 	lea    -0x170(%rbp),%rdx
ffff80000010197f:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
ffff800000101983:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff800000101987:	48 89 c7             	mov    %rax,%rdi
ffff80000010198a:	48 b8 a0 be 10 00 00 	movabs $0xffff80000010bea0,%rax
ffff800000101991:	80 ff ff 
ffff800000101994:	ff d0                	call   *%rax
ffff800000101996:	85 c0                	test   %eax,%eax
ffff800000101998:	0f 88 37 01 00 00    	js     ffff800000101ad5 <exec+0x592>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
ffff80000010199e:	48 8b 85 08 fe ff ff 	mov    -0x1f8(%rbp),%rax
ffff8000001019a5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001019a9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001019ad:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff8000001019b1:	eb 1c                	jmp    ffff8000001019cf <exec+0x48c>
    if(*s == '/')
ffff8000001019b3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001019b7:	0f b6 00             	movzbl (%rax),%eax
ffff8000001019ba:	3c 2f                	cmp    $0x2f,%al
ffff8000001019bc:	75 0c                	jne    ffff8000001019ca <exec+0x487>
      last = s+1;
ffff8000001019be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001019c2:	48 83 c0 01          	add    $0x1,%rax
ffff8000001019c6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(last=s=path; *s; s++)
ffff8000001019ca:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffff8000001019cf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001019d3:	0f b6 00             	movzbl (%rax),%eax
ffff8000001019d6:	84 c0                	test   %al,%al
ffff8000001019d8:	75 d9                	jne    ffff8000001019b3 <exec+0x470>
  safestrcpy(proc->name, last, sizeof(proc->name));
ffff8000001019da:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001019e1:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001019e5:	48 8d 88 d0 00 00 00 	lea    0xd0(%rax),%rcx
ffff8000001019ec:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001019f0:	ba 10 00 00 00       	mov    $0x10,%edx
ffff8000001019f5:	48 89 c6             	mov    %rax,%rsi
ffff8000001019f8:	48 89 cf             	mov    %rcx,%rdi
ffff8000001019fb:	48 b8 86 7d 10 00 00 	movabs $0xffff800000107d86,%rax
ffff800000101a02:	80 ff ff 
ffff800000101a05:	ff d0                	call   *%rax

  // Commit to the user image.
  proc->pgdir = pgdir;
ffff800000101a07:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101a0e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101a12:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
ffff800000101a16:	48 89 50 08          	mov    %rdx,0x8(%rax)
  proc->sz = sz;
ffff800000101a1a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101a21:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101a25:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff800000101a29:	48 89 10             	mov    %rdx,(%rax)
  proc->tf->rip = elf.entry;  // main
ffff800000101a2c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101a33:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101a37:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000101a3b:	48 8b 95 68 fe ff ff 	mov    -0x198(%rbp),%rdx
ffff800000101a42:	48 89 90 88 00 00 00 	mov    %rdx,0x88(%rax)
  proc->tf->rcx = elf.entry;
ffff800000101a49:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101a50:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101a54:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000101a58:	48 8b 95 68 fe ff ff 	mov    -0x198(%rbp),%rdx
ffff800000101a5f:	48 89 50 10          	mov    %rdx,0x10(%rax)
  proc->tf->rsp = sp;
ffff800000101a63:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101a6a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101a6e:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000101a72:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffff800000101a76:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
  switchuvm(proc);
ffff800000101a7d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101a84:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101a88:	48 89 c7             	mov    %rax,%rdi
ffff800000101a8b:	48 b8 c1 b1 10 00 00 	movabs $0xffff80000010b1c1,%rax
ffff800000101a92:	80 ff ff 
ffff800000101a95:	ff d0                	call   *%rax
  freevm(oldpgdir);
ffff800000101a97:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101a9b:	48 89 c7             	mov    %rax,%rdi
ffff800000101a9e:	48 b8 f7 b9 10 00 00 	movabs $0xffff80000010b9f7,%rax
ffff800000101aa5:	80 ff ff 
ffff800000101aa8:	ff d0                	call   *%rax
  return 0;
ffff800000101aaa:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000101aaf:	eb 6a                	jmp    ffff800000101b1b <exec+0x5d8>
    goto bad;
ffff800000101ab1:	90                   	nop
ffff800000101ab2:	eb 22                	jmp    ffff800000101ad6 <exec+0x593>
    goto bad;
ffff800000101ab4:	90                   	nop
ffff800000101ab5:	eb 1f                	jmp    ffff800000101ad6 <exec+0x593>
    goto bad;
ffff800000101ab7:	90                   	nop
ffff800000101ab8:	eb 1c                	jmp    ffff800000101ad6 <exec+0x593>
      goto bad;
ffff800000101aba:	90                   	nop
ffff800000101abb:	eb 19                	jmp    ffff800000101ad6 <exec+0x593>
      goto bad;
ffff800000101abd:	90                   	nop
ffff800000101abe:	eb 16                	jmp    ffff800000101ad6 <exec+0x593>
      goto bad;
ffff800000101ac0:	90                   	nop
ffff800000101ac1:	eb 13                	jmp    ffff800000101ad6 <exec+0x593>
      goto bad;
ffff800000101ac3:	90                   	nop
ffff800000101ac4:	eb 10                	jmp    ffff800000101ad6 <exec+0x593>
      goto bad;
ffff800000101ac6:	90                   	nop
ffff800000101ac7:	eb 0d                	jmp    ffff800000101ad6 <exec+0x593>
      goto bad;
ffff800000101ac9:	90                   	nop
ffff800000101aca:	eb 0a                	jmp    ffff800000101ad6 <exec+0x593>
    goto bad;
ffff800000101acc:	90                   	nop
ffff800000101acd:	eb 07                	jmp    ffff800000101ad6 <exec+0x593>
      goto bad;
ffff800000101acf:	90                   	nop
ffff800000101ad0:	eb 04                	jmp    ffff800000101ad6 <exec+0x593>
      goto bad;
ffff800000101ad2:	90                   	nop
ffff800000101ad3:	eb 01                	jmp    ffff800000101ad6 <exec+0x593>
    goto bad;
ffff800000101ad5:	90                   	nop

 bad:
  if(pgdir)
ffff800000101ad6:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
ffff800000101adb:	74 13                	je     ffff800000101af0 <exec+0x5ad>
    freevm(pgdir);
ffff800000101add:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff800000101ae1:	48 89 c7             	mov    %rax,%rdi
ffff800000101ae4:	48 b8 f7 b9 10 00 00 	movabs $0xffff80000010b9f7,%rax
ffff800000101aeb:	80 ff ff 
ffff800000101aee:	ff d0                	call   *%rax
  if(ip){
ffff800000101af0:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
ffff800000101af5:	74 1f                	je     ffff800000101b16 <exec+0x5d3>
    iunlockput(ip);
ffff800000101af7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff800000101afb:	48 89 c7             	mov    %rax,%rdi
ffff800000101afe:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000101b05:	80 ff ff 
ffff800000101b08:	ff d0                	call   *%rax
    end_op();
ffff800000101b0a:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff800000101b11:	80 ff ff 
ffff800000101b14:	ff d0                	call   *%rax
  }
  return -1;
ffff800000101b16:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000101b1b:	c9                   	leave
ffff800000101b1c:	c3                   	ret

ffff800000101b1d <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
ffff800000101b1d:	55                   	push   %rbp
ffff800000101b1e:	48 89 e5             	mov    %rsp,%rbp
  initlock(&ftable.lock, "ftable");
ffff800000101b21:	48 ba b9 c0 10 00 00 	movabs $0xffff80000010c0b9,%rdx
ffff800000101b28:	80 ff ff 
ffff800000101b2b:	48 b8 e0 35 11 00 00 	movabs $0xffff8000001135e0,%rax
ffff800000101b32:	80 ff ff 
ffff800000101b35:	48 89 d6             	mov    %rdx,%rsi
ffff800000101b38:	48 89 c7             	mov    %rax,%rdi
ffff800000101b3b:	48 b8 05 77 10 00 00 	movabs $0xffff800000107705,%rax
ffff800000101b42:	80 ff ff 
ffff800000101b45:	ff d0                	call   *%rax
}
ffff800000101b47:	90                   	nop
ffff800000101b48:	5d                   	pop    %rbp
ffff800000101b49:	c3                   	ret

ffff800000101b4a <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
ffff800000101b4a:	55                   	push   %rbp
ffff800000101b4b:	48 89 e5             	mov    %rsp,%rbp
ffff800000101b4e:	48 83 ec 10          	sub    $0x10,%rsp
  struct file *f;

  acquire(&ftable.lock);
ffff800000101b52:	48 b8 e0 35 11 00 00 	movabs $0xffff8000001135e0,%rax
ffff800000101b59:	80 ff ff 
ffff800000101b5c:	48 89 c7             	mov    %rax,%rdi
ffff800000101b5f:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff800000101b66:	80 ff ff 
ffff800000101b69:	ff d0                	call   *%rax
  for(f = ftable.file; f < ftable.file + NFILE; f++){
ffff800000101b6b:	48 b8 48 36 11 00 00 	movabs $0xffff800000113648,%rax
ffff800000101b72:	80 ff ff 
ffff800000101b75:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000101b79:	eb 3a                	jmp    ffff800000101bb5 <filealloc+0x6b>
    if(f->ref == 0){
ffff800000101b7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101b7f:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101b82:	85 c0                	test   %eax,%eax
ffff800000101b84:	75 2a                	jne    ffff800000101bb0 <filealloc+0x66>
      f->ref = 1;
ffff800000101b86:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101b8a:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%rax)
      release(&ftable.lock);
ffff800000101b91:	48 b8 e0 35 11 00 00 	movabs $0xffff8000001135e0,%rax
ffff800000101b98:	80 ff ff 
ffff800000101b9b:	48 89 c7             	mov    %rax,%rdi
ffff800000101b9e:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000101ba5:	80 ff ff 
ffff800000101ba8:	ff d0                	call   *%rax
      return f;
ffff800000101baa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101bae:	eb 33                	jmp    ffff800000101be3 <filealloc+0x99>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
ffff800000101bb0:	48 83 45 f8 28       	addq   $0x28,-0x8(%rbp)
ffff800000101bb5:	48 b8 e8 45 11 00 00 	movabs $0xffff8000001145e8,%rax
ffff800000101bbc:	80 ff ff 
ffff800000101bbf:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000101bc3:	72 b6                	jb     ffff800000101b7b <filealloc+0x31>
    }
  }
  release(&ftable.lock);
ffff800000101bc5:	48 b8 e0 35 11 00 00 	movabs $0xffff8000001135e0,%rax
ffff800000101bcc:	80 ff ff 
ffff800000101bcf:	48 89 c7             	mov    %rax,%rdi
ffff800000101bd2:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000101bd9:	80 ff ff 
ffff800000101bdc:	ff d0                	call   *%rax
  return 0;
ffff800000101bde:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000101be3:	c9                   	leave
ffff800000101be4:	c3                   	ret

ffff800000101be5 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
ffff800000101be5:	55                   	push   %rbp
ffff800000101be6:	48 89 e5             	mov    %rsp,%rbp
ffff800000101be9:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000101bed:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&ftable.lock);
ffff800000101bf1:	48 b8 e0 35 11 00 00 	movabs $0xffff8000001135e0,%rax
ffff800000101bf8:	80 ff ff 
ffff800000101bfb:	48 89 c7             	mov    %rax,%rdi
ffff800000101bfe:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff800000101c05:	80 ff ff 
ffff800000101c08:	ff d0                	call   *%rax
  if(f->ref < 1)
ffff800000101c0a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101c0e:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101c11:	85 c0                	test   %eax,%eax
ffff800000101c13:	7f 19                	jg     ffff800000101c2e <filedup+0x49>
    panic("filedup");
ffff800000101c15:	48 b8 c0 c0 10 00 00 	movabs $0xffff80000010c0c0,%rax
ffff800000101c1c:	80 ff ff 
ffff800000101c1f:	48 89 c7             	mov    %rax,%rdi
ffff800000101c22:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000101c29:	80 ff ff 
ffff800000101c2c:	ff d0                	call   *%rax
  f->ref++;
ffff800000101c2e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101c32:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101c35:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000101c38:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101c3c:	89 50 04             	mov    %edx,0x4(%rax)
  release(&ftable.lock);
ffff800000101c3f:	48 b8 e0 35 11 00 00 	movabs $0xffff8000001135e0,%rax
ffff800000101c46:	80 ff ff 
ffff800000101c49:	48 89 c7             	mov    %rax,%rdi
ffff800000101c4c:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000101c53:	80 ff ff 
ffff800000101c56:	ff d0                	call   *%rax
  return f;
ffff800000101c58:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000101c5c:	c9                   	leave
ffff800000101c5d:	c3                   	ret

ffff800000101c5e <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
ffff800000101c5e:	55                   	push   %rbp
ffff800000101c5f:	48 89 e5             	mov    %rsp,%rbp
ffff800000101c62:	53                   	push   %rbx
ffff800000101c63:	48 83 ec 48          	sub    $0x48,%rsp
ffff800000101c67:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
  struct file ff;

  acquire(&ftable.lock);
ffff800000101c6b:	48 b8 e0 35 11 00 00 	movabs $0xffff8000001135e0,%rax
ffff800000101c72:	80 ff ff 
ffff800000101c75:	48 89 c7             	mov    %rax,%rdi
ffff800000101c78:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff800000101c7f:	80 ff ff 
ffff800000101c82:	ff d0                	call   *%rax
  if(f->ref < 1)
ffff800000101c84:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101c88:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101c8b:	85 c0                	test   %eax,%eax
ffff800000101c8d:	7f 19                	jg     ffff800000101ca8 <fileclose+0x4a>
    panic("fileclose");
ffff800000101c8f:	48 b8 c8 c0 10 00 00 	movabs $0xffff80000010c0c8,%rax
ffff800000101c96:	80 ff ff 
ffff800000101c99:	48 89 c7             	mov    %rax,%rdi
ffff800000101c9c:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000101ca3:	80 ff ff 
ffff800000101ca6:	ff d0                	call   *%rax
  if(--f->ref > 0){
ffff800000101ca8:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101cac:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101caf:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000101cb2:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101cb6:	89 50 04             	mov    %edx,0x4(%rax)
ffff800000101cb9:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101cbd:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101cc0:	85 c0                	test   %eax,%eax
ffff800000101cc2:	7e 1e                	jle    ffff800000101ce2 <fileclose+0x84>
    release(&ftable.lock);
ffff800000101cc4:	48 b8 e0 35 11 00 00 	movabs $0xffff8000001135e0,%rax
ffff800000101ccb:	80 ff ff 
ffff800000101cce:	48 89 c7             	mov    %rax,%rdi
ffff800000101cd1:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000101cd8:	80 ff ff 
ffff800000101cdb:	ff d0                	call   *%rax
ffff800000101cdd:	e9 b2 00 00 00       	jmp    ffff800000101d94 <fileclose+0x136>
    return;
  }
  ff = *f;
ffff800000101ce2:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101ce6:	48 8b 08             	mov    (%rax),%rcx
ffff800000101ce9:	48 8b 58 08          	mov    0x8(%rax),%rbx
ffff800000101ced:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
ffff800000101cf1:	48 89 5d c8          	mov    %rbx,-0x38(%rbp)
ffff800000101cf5:	48 8b 48 10          	mov    0x10(%rax),%rcx
ffff800000101cf9:	48 8b 58 18          	mov    0x18(%rax),%rbx
ffff800000101cfd:	48 89 4d d0          	mov    %rcx,-0x30(%rbp)
ffff800000101d01:	48 89 5d d8          	mov    %rbx,-0x28(%rbp)
ffff800000101d05:	48 8b 40 20          	mov    0x20(%rax),%rax
ffff800000101d09:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  f->ref = 0;
ffff800000101d0d:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101d11:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%rax)
  f->type = FD_NONE;
ffff800000101d18:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101d1c:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  release(&ftable.lock);
ffff800000101d22:	48 b8 e0 35 11 00 00 	movabs $0xffff8000001135e0,%rax
ffff800000101d29:	80 ff ff 
ffff800000101d2c:	48 89 c7             	mov    %rax,%rdi
ffff800000101d2f:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000101d36:	80 ff ff 
ffff800000101d39:	ff d0                	call   *%rax

  if(ff.type == FD_PIPE)
ffff800000101d3b:	8b 45 c0             	mov    -0x40(%rbp),%eax
ffff800000101d3e:	83 f8 01             	cmp    $0x1,%eax
ffff800000101d41:	75 1e                	jne    ffff800000101d61 <fileclose+0x103>
    pipeclose(ff.pipe, ff.writable);
ffff800000101d43:	0f b6 45 c9          	movzbl -0x37(%rbp),%eax
ffff800000101d47:	0f be d0             	movsbl %al,%edx
ffff800000101d4a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000101d4e:	89 d6                	mov    %edx,%esi
ffff800000101d50:	48 89 c7             	mov    %rax,%rdi
ffff800000101d53:	48 b8 c0 5d 10 00 00 	movabs $0xffff800000105dc0,%rax
ffff800000101d5a:	80 ff ff 
ffff800000101d5d:	ff d0                	call   *%rax
ffff800000101d5f:	eb 33                	jmp    ffff800000101d94 <fileclose+0x136>
  else if(ff.type == FD_INODE){
ffff800000101d61:	8b 45 c0             	mov    -0x40(%rbp),%eax
ffff800000101d64:	83 f8 02             	cmp    $0x2,%eax
ffff800000101d67:	75 2b                	jne    ffff800000101d94 <fileclose+0x136>
    begin_op();
ffff800000101d69:	48 b8 bd 4e 10 00 00 	movabs $0xffff800000104ebd,%rax
ffff800000101d70:	80 ff ff 
ffff800000101d73:	ff d0                	call   *%rax
    iput(ff.ip);
ffff800000101d75:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000101d79:	48 89 c7             	mov    %rax,%rdi
ffff800000101d7c:	48 b8 8f 2a 10 00 00 	movabs $0xffff800000102a8f,%rax
ffff800000101d83:	80 ff ff 
ffff800000101d86:	ff d0                	call   *%rax
    end_op();
ffff800000101d88:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff800000101d8f:	80 ff ff 
ffff800000101d92:	ff d0                	call   *%rax
  }
}
ffff800000101d94:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
ffff800000101d98:	c9                   	leave
ffff800000101d99:	c3                   	ret

ffff800000101d9a <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
ffff800000101d9a:	55                   	push   %rbp
ffff800000101d9b:	48 89 e5             	mov    %rsp,%rbp
ffff800000101d9e:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000101da2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000101da6:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(f->type == FD_INODE){
ffff800000101daa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101dae:	8b 00                	mov    (%rax),%eax
ffff800000101db0:	83 f8 02             	cmp    $0x2,%eax
ffff800000101db3:	75 53                	jne    ffff800000101e08 <filestat+0x6e>
    ilock(f->ip);
ffff800000101db5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101db9:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101dbd:	48 89 c7             	mov    %rax,%rdi
ffff800000101dc0:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff800000101dc7:	80 ff ff 
ffff800000101dca:	ff d0                	call   *%rax
    stati(f->ip, st);
ffff800000101dcc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101dd0:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101dd4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000101dd8:	48 89 d6             	mov    %rdx,%rsi
ffff800000101ddb:	48 89 c7             	mov    %rax,%rdi
ffff800000101dde:	48 b8 8f 2e 10 00 00 	movabs $0xffff800000102e8f,%rax
ffff800000101de5:	80 ff ff 
ffff800000101de8:	ff d0                	call   *%rax
    iunlock(f->ip);
ffff800000101dea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101dee:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101df2:	48 89 c7             	mov    %rax,%rdi
ffff800000101df5:	48 b8 23 2a 10 00 00 	movabs $0xffff800000102a23,%rax
ffff800000101dfc:	80 ff ff 
ffff800000101dff:	ff d0                	call   *%rax
    return 0;
ffff800000101e01:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000101e06:	eb 05                	jmp    ffff800000101e0d <filestat+0x73>
  }
  return -1;
ffff800000101e08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000101e0d:	c9                   	leave
ffff800000101e0e:	c3                   	ret

ffff800000101e0f <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
ffff800000101e0f:	55                   	push   %rbp
ffff800000101e10:	48 89 e5             	mov    %rsp,%rbp
ffff800000101e13:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000101e17:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000101e1b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000101e1f:	89 55 dc             	mov    %edx,-0x24(%rbp)
  int r;

  if(f->readable == 0)
ffff800000101e22:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101e26:	0f b6 40 08          	movzbl 0x8(%rax),%eax
ffff800000101e2a:	84 c0                	test   %al,%al
ffff800000101e2c:	75 0a                	jne    ffff800000101e38 <fileread+0x29>
    return -1;
ffff800000101e2e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000101e33:	e9 c9 00 00 00       	jmp    ffff800000101f01 <fileread+0xf2>
  if(f->type == FD_PIPE)
ffff800000101e38:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101e3c:	8b 00                	mov    (%rax),%eax
ffff800000101e3e:	83 f8 01             	cmp    $0x1,%eax
ffff800000101e41:	75 26                	jne    ffff800000101e69 <fileread+0x5a>
    return piperead(f->pipe, addr, n);
ffff800000101e43:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101e47:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000101e4b:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffff800000101e4e:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff800000101e52:	48 89 ce             	mov    %rcx,%rsi
ffff800000101e55:	48 89 c7             	mov    %rax,%rdi
ffff800000101e58:	48 b8 d3 5f 10 00 00 	movabs $0xffff800000105fd3,%rax
ffff800000101e5f:	80 ff ff 
ffff800000101e62:	ff d0                	call   *%rax
ffff800000101e64:	e9 98 00 00 00       	jmp    ffff800000101f01 <fileread+0xf2>
  if(f->type == FD_INODE){
ffff800000101e69:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101e6d:	8b 00                	mov    (%rax),%eax
ffff800000101e6f:	83 f8 02             	cmp    $0x2,%eax
ffff800000101e72:	75 74                	jne    ffff800000101ee8 <fileread+0xd9>
    ilock(f->ip);
ffff800000101e74:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101e78:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101e7c:	48 89 c7             	mov    %rax,%rdi
ffff800000101e7f:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff800000101e86:	80 ff ff 
ffff800000101e89:	ff d0                	call   *%rax
    if((r = readi(f->ip, addr, f->off, n)) > 0)
ffff800000101e8b:	8b 4d dc             	mov    -0x24(%rbp),%ecx
ffff800000101e8e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101e92:	8b 50 20             	mov    0x20(%rax),%edx
ffff800000101e95:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101e99:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101e9d:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
ffff800000101ea1:	48 89 c7             	mov    %rax,%rdi
ffff800000101ea4:	48 b8 f5 2e 10 00 00 	movabs $0xffff800000102ef5,%rax
ffff800000101eab:	80 ff ff 
ffff800000101eae:	ff d0                	call   *%rax
ffff800000101eb0:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000101eb3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000101eb7:	7e 13                	jle    ffff800000101ecc <fileread+0xbd>
      f->off += r;
ffff800000101eb9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101ebd:	8b 50 20             	mov    0x20(%rax),%edx
ffff800000101ec0:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000101ec3:	01 c2                	add    %eax,%edx
ffff800000101ec5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101ec9:	89 50 20             	mov    %edx,0x20(%rax)
    iunlock(f->ip);
ffff800000101ecc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101ed0:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101ed4:	48 89 c7             	mov    %rax,%rdi
ffff800000101ed7:	48 b8 23 2a 10 00 00 	movabs $0xffff800000102a23,%rax
ffff800000101ede:	80 ff ff 
ffff800000101ee1:	ff d0                	call   *%rax
    return r;
ffff800000101ee3:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000101ee6:	eb 19                	jmp    ffff800000101f01 <fileread+0xf2>
  }
  panic("fileread");
ffff800000101ee8:	48 b8 d2 c0 10 00 00 	movabs $0xffff80000010c0d2,%rax
ffff800000101eef:	80 ff ff 
ffff800000101ef2:	48 89 c7             	mov    %rax,%rdi
ffff800000101ef5:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000101efc:	80 ff ff 
ffff800000101eff:	ff d0                	call   *%rax
}
ffff800000101f01:	c9                   	leave
ffff800000101f02:	c3                   	ret

ffff800000101f03 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
ffff800000101f03:	55                   	push   %rbp
ffff800000101f04:	48 89 e5             	mov    %rsp,%rbp
ffff800000101f07:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000101f0b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000101f0f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000101f13:	89 55 dc             	mov    %edx,-0x24(%rbp)
  int r;

  if(f->writable == 0)
ffff800000101f16:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101f1a:	0f b6 40 09          	movzbl 0x9(%rax),%eax
ffff800000101f1e:	84 c0                	test   %al,%al
ffff800000101f20:	75 0a                	jne    ffff800000101f2c <filewrite+0x29>
    return -1;
ffff800000101f22:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000101f27:	e9 63 01 00 00       	jmp    ffff80000010208f <filewrite+0x18c>
  if(f->type == FD_PIPE)
ffff800000101f2c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101f30:	8b 00                	mov    (%rax),%eax
ffff800000101f32:	83 f8 01             	cmp    $0x1,%eax
ffff800000101f35:	75 26                	jne    ffff800000101f5d <filewrite+0x5a>
    return pipewrite(f->pipe, addr, n);
ffff800000101f37:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101f3b:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000101f3f:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffff800000101f42:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff800000101f46:	48 89 ce             	mov    %rcx,%rsi
ffff800000101f49:	48 89 c7             	mov    %rax,%rdi
ffff800000101f4c:	48 b8 93 5e 10 00 00 	movabs $0xffff800000105e93,%rax
ffff800000101f53:	80 ff ff 
ffff800000101f56:	ff d0                	call   *%rax
ffff800000101f58:	e9 32 01 00 00       	jmp    ffff80000010208f <filewrite+0x18c>
  if(f->type == FD_INODE){
ffff800000101f5d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101f61:	8b 00                	mov    (%rax),%eax
ffff800000101f63:	83 f8 02             	cmp    $0x2,%eax
ffff800000101f66:	0f 85 0a 01 00 00    	jne    ffff800000102076 <filewrite+0x173>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
ffff800000101f6c:	c7 45 f4 00 1a 00 00 	movl   $0x1a00,-0xc(%rbp)
    int i = 0;
ffff800000101f73:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    while(i < n){
ffff800000101f7a:	e9 d4 00 00 00       	jmp    ffff800000102053 <filewrite+0x150>
      int n1 = n - i;
ffff800000101f7f:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000101f82:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff800000101f85:	89 45 f8             	mov    %eax,-0x8(%rbp)
      if(n1 > max)
ffff800000101f88:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000101f8b:	3b 45 f4             	cmp    -0xc(%rbp),%eax
ffff800000101f8e:	7e 06                	jle    ffff800000101f96 <filewrite+0x93>
        n1 = max;
ffff800000101f90:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000101f93:	89 45 f8             	mov    %eax,-0x8(%rbp)

      begin_op();
ffff800000101f96:	48 b8 bd 4e 10 00 00 	movabs $0xffff800000104ebd,%rax
ffff800000101f9d:	80 ff ff 
ffff800000101fa0:	ff d0                	call   *%rax
      ilock(f->ip);
ffff800000101fa2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101fa6:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101faa:	48 89 c7             	mov    %rax,%rdi
ffff800000101fad:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff800000101fb4:	80 ff ff 
ffff800000101fb7:	ff d0                	call   *%rax
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
ffff800000101fb9:	8b 4d f8             	mov    -0x8(%rbp),%ecx
ffff800000101fbc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101fc0:	8b 50 20             	mov    0x20(%rax),%edx
ffff800000101fc3:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000101fc6:	48 63 f0             	movslq %eax,%rsi
ffff800000101fc9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000101fcd:	48 01 c6             	add    %rax,%rsi
ffff800000101fd0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101fd4:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101fd8:	48 89 c7             	mov    %rax,%rdi
ffff800000101fdb:	48 b8 c2 30 10 00 00 	movabs $0xffff8000001030c2,%rax
ffff800000101fe2:	80 ff ff 
ffff800000101fe5:	ff d0                	call   *%rax
ffff800000101fe7:	89 45 f0             	mov    %eax,-0x10(%rbp)
ffff800000101fea:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
ffff800000101fee:	7e 13                	jle    ffff800000102003 <filewrite+0x100>
        f->off += r;
ffff800000101ff0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101ff4:	8b 50 20             	mov    0x20(%rax),%edx
ffff800000101ff7:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000101ffa:	01 c2                	add    %eax,%edx
ffff800000101ffc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102000:	89 50 20             	mov    %edx,0x20(%rax)
      iunlock(f->ip);
ffff800000102003:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102007:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff80000010200b:	48 89 c7             	mov    %rax,%rdi
ffff80000010200e:	48 b8 23 2a 10 00 00 	movabs $0xffff800000102a23,%rax
ffff800000102015:	80 ff ff 
ffff800000102018:	ff d0                	call   *%rax
      end_op();
ffff80000010201a:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff800000102021:	80 ff ff 
ffff800000102024:	ff d0                	call   *%rax

      if(r < 0)
ffff800000102026:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
ffff80000010202a:	78 35                	js     ffff800000102061 <filewrite+0x15e>
        break;
      if(r != n1)
ffff80000010202c:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff80000010202f:	3b 45 f8             	cmp    -0x8(%rbp),%eax
ffff800000102032:	74 19                	je     ffff80000010204d <filewrite+0x14a>
        panic("short filewrite");
ffff800000102034:	48 b8 db c0 10 00 00 	movabs $0xffff80000010c0db,%rax
ffff80000010203b:	80 ff ff 
ffff80000010203e:	48 89 c7             	mov    %rax,%rdi
ffff800000102041:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000102048:	80 ff ff 
ffff80000010204b:	ff d0                	call   *%rax
      i += r;
ffff80000010204d:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000102050:	01 45 fc             	add    %eax,-0x4(%rbp)
    while(i < n){
ffff800000102053:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102056:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffff800000102059:	0f 8c 20 ff ff ff    	jl     ffff800000101f7f <filewrite+0x7c>
ffff80000010205f:	eb 01                	jmp    ffff800000102062 <filewrite+0x15f>
        break;
ffff800000102061:	90                   	nop
    }
    return i == n ? n : -1;
ffff800000102062:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102065:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffff800000102068:	75 05                	jne    ffff80000010206f <filewrite+0x16c>
ffff80000010206a:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff80000010206d:	eb 20                	jmp    ffff80000010208f <filewrite+0x18c>
ffff80000010206f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000102074:	eb 19                	jmp    ffff80000010208f <filewrite+0x18c>
  }
  panic("filewrite");
ffff800000102076:	48 b8 eb c0 10 00 00 	movabs $0xffff80000010c0eb,%rax
ffff80000010207d:	80 ff ff 
ffff800000102080:	48 89 c7             	mov    %rax,%rdi
ffff800000102083:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010208a:	80 ff ff 
ffff80000010208d:	ff d0                	call   *%rax
}
ffff80000010208f:	c9                   	leave
ffff800000102090:	c3                   	ret

ffff800000102091 <readsb>:
struct superblock sb;

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
ffff800000102091:	55                   	push   %rbp
ffff800000102092:	48 89 e5             	mov    %rsp,%rbp
ffff800000102095:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000102099:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff80000010209c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  struct buf *bp = bread(dev, 1);
ffff8000001020a0:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001020a3:	be 01 00 00 00       	mov    $0x1,%esi
ffff8000001020a8:	89 c7                	mov    %eax,%edi
ffff8000001020aa:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff8000001020b1:	80 ff ff 
ffff8000001020b4:	ff d0                	call   *%rax
ffff8000001020b6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memmove(sb, bp->data, sizeof(*sb));
ffff8000001020ba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001020be:	48 8d 88 b0 00 00 00 	lea    0xb0(%rax),%rcx
ffff8000001020c5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001020c9:	ba 1c 00 00 00       	mov    $0x1c,%edx
ffff8000001020ce:	48 89 ce             	mov    %rcx,%rsi
ffff8000001020d1:	48 89 c7             	mov    %rax,%rdi
ffff8000001020d4:	48 b8 d3 7b 10 00 00 	movabs $0xffff800000107bd3,%rax
ffff8000001020db:	80 ff ff 
ffff8000001020de:	ff d0                	call   *%rax
  brelse(bp);
ffff8000001020e0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001020e4:	48 89 c7             	mov    %rax,%rdi
ffff8000001020e7:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff8000001020ee:	80 ff ff 
ffff8000001020f1:	ff d0                	call   *%rax
}
ffff8000001020f3:	90                   	nop
ffff8000001020f4:	c9                   	leave
ffff8000001020f5:	c3                   	ret

ffff8000001020f6 <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
ffff8000001020f6:	55                   	push   %rbp
ffff8000001020f7:	48 89 e5             	mov    %rsp,%rbp
ffff8000001020fa:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001020fe:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000102101:	89 75 e8             	mov    %esi,-0x18(%rbp)
  struct buf *bp = bread(dev, bno);
ffff800000102104:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffff800000102107:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff80000010210a:	89 d6                	mov    %edx,%esi
ffff80000010210c:	89 c7                	mov    %eax,%edi
ffff80000010210e:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000102115:	80 ff ff 
ffff800000102118:	ff d0                	call   *%rax
ffff80000010211a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(bp->data, 0, BSIZE);
ffff80000010211e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102122:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000102128:	ba 00 02 00 00       	mov    $0x200,%edx
ffff80000010212d:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000102132:	48 89 c7             	mov    %rax,%rdi
ffff800000102135:	48 b8 ce 7a 10 00 00 	movabs $0xffff800000107ace,%rax
ffff80000010213c:	80 ff ff 
ffff80000010213f:	ff d0                	call   *%rax
  log_write(bp);
ffff800000102141:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102145:	48 89 c7             	mov    %rax,%rdi
ffff800000102148:	48 b8 45 52 10 00 00 	movabs $0xffff800000105245,%rax
ffff80000010214f:	80 ff ff 
ffff800000102152:	ff d0                	call   *%rax
  brelse(bp);
ffff800000102154:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102158:	48 89 c7             	mov    %rax,%rdi
ffff80000010215b:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000102162:	80 ff ff 
ffff800000102165:	ff d0                	call   *%rax
}
ffff800000102167:	90                   	nop
ffff800000102168:	c9                   	leave
ffff800000102169:	c3                   	ret

ffff80000010216a <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
ffff80000010216a:	55                   	push   %rbp
ffff80000010216b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010216e:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000102172:	89 7d dc             	mov    %edi,-0x24(%rbp)
  int b, bi, m;
  struct buf *bp;
  for(b = 0; b < sb.size; b += BPB){
ffff800000102175:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010217c:	e9 4a 01 00 00       	jmp    ffff8000001022cb <balloc+0x161>
    bp = bread(dev, BBLOCK(b, sb));
ffff800000102181:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102184:	8d 90 ff 0f 00 00    	lea    0xfff(%rax),%edx
ffff80000010218a:	85 c0                	test   %eax,%eax
ffff80000010218c:	0f 48 c2             	cmovs  %edx,%eax
ffff80000010218f:	c1 f8 0c             	sar    $0xc,%eax
ffff800000102192:	89 c2                	mov    %eax,%edx
ffff800000102194:	48 b8 00 46 11 00 00 	movabs $0xffff800000114600,%rax
ffff80000010219b:	80 ff ff 
ffff80000010219e:	8b 40 18             	mov    0x18(%rax),%eax
ffff8000001021a1:	01 c2                	add    %eax,%edx
ffff8000001021a3:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff8000001021a6:	89 d6                	mov    %edx,%esi
ffff8000001021a8:	89 c7                	mov    %eax,%edi
ffff8000001021aa:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff8000001021b1:	80 ff ff 
ffff8000001021b4:	ff d0                	call   *%rax
ffff8000001021b6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
ffff8000001021ba:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
ffff8000001021c1:	e9 c4 00 00 00       	jmp    ffff80000010228a <balloc+0x120>
      m = 1 << (bi % 8);
ffff8000001021c6:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff8000001021c9:	83 e0 07             	and    $0x7,%eax
ffff8000001021cc:	ba 01 00 00 00       	mov    $0x1,%edx
ffff8000001021d1:	89 c1                	mov    %eax,%ecx
ffff8000001021d3:	d3 e2                	shl    %cl,%edx
ffff8000001021d5:	89 d0                	mov    %edx,%eax
ffff8000001021d7:	89 45 ec             	mov    %eax,-0x14(%rbp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
ffff8000001021da:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff8000001021dd:	8d 50 07             	lea    0x7(%rax),%edx
ffff8000001021e0:	85 c0                	test   %eax,%eax
ffff8000001021e2:	0f 48 c2             	cmovs  %edx,%eax
ffff8000001021e5:	c1 f8 03             	sar    $0x3,%eax
ffff8000001021e8:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff8000001021ec:	48 98                	cltq
ffff8000001021ee:	0f b6 84 02 b0 00 00 	movzbl 0xb0(%rdx,%rax,1),%eax
ffff8000001021f5:	00 
ffff8000001021f6:	0f b6 c0             	movzbl %al,%eax
ffff8000001021f9:	23 45 ec             	and    -0x14(%rbp),%eax
ffff8000001021fc:	85 c0                	test   %eax,%eax
ffff8000001021fe:	0f 85 82 00 00 00    	jne    ffff800000102286 <balloc+0x11c>
        bp->data[bi/8] |= m;  // Mark block in use.
ffff800000102204:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000102207:	8d 50 07             	lea    0x7(%rax),%edx
ffff80000010220a:	85 c0                	test   %eax,%eax
ffff80000010220c:	0f 48 c2             	cmovs  %edx,%eax
ffff80000010220f:	c1 f8 03             	sar    $0x3,%eax
ffff800000102212:	89 c1                	mov    %eax,%ecx
ffff800000102214:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000102218:	48 63 c1             	movslq %ecx,%rax
ffff80000010221b:	0f b6 84 02 b0 00 00 	movzbl 0xb0(%rdx,%rax,1),%eax
ffff800000102222:	00 
ffff800000102223:	89 c2                	mov    %eax,%edx
ffff800000102225:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000102228:	09 d0                	or     %edx,%eax
ffff80000010222a:	89 c6                	mov    %eax,%esi
ffff80000010222c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000102230:	48 63 c1             	movslq %ecx,%rax
ffff800000102233:	40 88 b4 02 b0 00 00 	mov    %sil,0xb0(%rdx,%rax,1)
ffff80000010223a:	00 
        log_write(bp);
ffff80000010223b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010223f:	48 89 c7             	mov    %rax,%rdi
ffff800000102242:	48 b8 45 52 10 00 00 	movabs $0xffff800000105245,%rax
ffff800000102249:	80 ff ff 
ffff80000010224c:	ff d0                	call   *%rax
        brelse(bp);
ffff80000010224e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102252:	48 89 c7             	mov    %rax,%rdi
ffff800000102255:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff80000010225c:	80 ff ff 
ffff80000010225f:	ff d0                	call   *%rax
        bzero(dev, b + bi);
ffff800000102261:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102264:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000102267:	01 c2                	add    %eax,%edx
ffff800000102269:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff80000010226c:	89 d6                	mov    %edx,%esi
ffff80000010226e:	89 c7                	mov    %eax,%edi
ffff800000102270:	48 b8 f6 20 10 00 00 	movabs $0xffff8000001020f6,%rax
ffff800000102277:	80 ff ff 
ffff80000010227a:	ff d0                	call   *%rax
        return b + bi;
ffff80000010227c:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010227f:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000102282:	01 d0                	add    %edx,%eax
ffff800000102284:	eb 75                	jmp    ffff8000001022fb <balloc+0x191>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
ffff800000102286:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
ffff80000010228a:	81 7d f8 ff 0f 00 00 	cmpl   $0xfff,-0x8(%rbp)
ffff800000102291:	7f 1e                	jg     ffff8000001022b1 <balloc+0x147>
ffff800000102293:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102296:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000102299:	01 d0                	add    %edx,%eax
ffff80000010229b:	89 c2                	mov    %eax,%edx
ffff80000010229d:	48 b8 00 46 11 00 00 	movabs $0xffff800000114600,%rax
ffff8000001022a4:	80 ff ff 
ffff8000001022a7:	8b 00                	mov    (%rax),%eax
ffff8000001022a9:	39 c2                	cmp    %eax,%edx
ffff8000001022ab:	0f 82 15 ff ff ff    	jb     ffff8000001021c6 <balloc+0x5c>
      }
    }
    brelse(bp);
ffff8000001022b1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001022b5:	48 89 c7             	mov    %rax,%rdi
ffff8000001022b8:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff8000001022bf:	80 ff ff 
ffff8000001022c2:	ff d0                	call   *%rax
  for(b = 0; b < sb.size; b += BPB){
ffff8000001022c4:	81 45 fc 00 10 00 00 	addl   $0x1000,-0x4(%rbp)
ffff8000001022cb:	48 b8 00 46 11 00 00 	movabs $0xffff800000114600,%rax
ffff8000001022d2:	80 ff ff 
ffff8000001022d5:	8b 00                	mov    (%rax),%eax
ffff8000001022d7:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001022da:	39 c2                	cmp    %eax,%edx
ffff8000001022dc:	0f 82 9f fe ff ff    	jb     ffff800000102181 <balloc+0x17>
  }
  panic("balloc: out of blocks");
ffff8000001022e2:	48 b8 f5 c0 10 00 00 	movabs $0xffff80000010c0f5,%rax
ffff8000001022e9:	80 ff ff 
ffff8000001022ec:	48 89 c7             	mov    %rax,%rdi
ffff8000001022ef:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001022f6:	80 ff ff 
ffff8000001022f9:	ff d0                	call   *%rax
}
ffff8000001022fb:	c9                   	leave
ffff8000001022fc:	c3                   	ret

ffff8000001022fd <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
ffff8000001022fd:	55                   	push   %rbp
ffff8000001022fe:	48 89 e5             	mov    %rsp,%rbp
ffff800000102301:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000102305:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000102308:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int bi, m;

  readsb(dev, &sb);
ffff80000010230b:	48 ba 00 46 11 00 00 	movabs $0xffff800000114600,%rdx
ffff800000102312:	80 ff ff 
ffff800000102315:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000102318:	48 89 d6             	mov    %rdx,%rsi
ffff80000010231b:	89 c7                	mov    %eax,%edi
ffff80000010231d:	48 b8 91 20 10 00 00 	movabs $0xffff800000102091,%rax
ffff800000102324:	80 ff ff 
ffff800000102327:	ff d0                	call   *%rax
  struct buf *bp = bread(dev, BBLOCK(b, sb));
ffff800000102329:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff80000010232c:	c1 e8 0c             	shr    $0xc,%eax
ffff80000010232f:	89 c2                	mov    %eax,%edx
ffff800000102331:	48 b8 00 46 11 00 00 	movabs $0xffff800000114600,%rax
ffff800000102338:	80 ff ff 
ffff80000010233b:	8b 40 18             	mov    0x18(%rax),%eax
ffff80000010233e:	01 c2                	add    %eax,%edx
ffff800000102340:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000102343:	89 d6                	mov    %edx,%esi
ffff800000102345:	89 c7                	mov    %eax,%edi
ffff800000102347:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff80000010234e:	80 ff ff 
ffff800000102351:	ff d0                	call   *%rax
ffff800000102353:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  bi = b % BPB;
ffff800000102357:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff80000010235a:	25 ff 0f 00 00       	and    $0xfff,%eax
ffff80000010235f:	89 45 f4             	mov    %eax,-0xc(%rbp)
  m = 1 << (bi % 8);
ffff800000102362:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000102365:	83 e0 07             	and    $0x7,%eax
ffff800000102368:	ba 01 00 00 00       	mov    $0x1,%edx
ffff80000010236d:	89 c1                	mov    %eax,%ecx
ffff80000010236f:	d3 e2                	shl    %cl,%edx
ffff800000102371:	89 d0                	mov    %edx,%eax
ffff800000102373:	89 45 f0             	mov    %eax,-0x10(%rbp)
  if((bp->data[bi/8] & m) == 0)
ffff800000102376:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000102379:	8d 50 07             	lea    0x7(%rax),%edx
ffff80000010237c:	85 c0                	test   %eax,%eax
ffff80000010237e:	0f 48 c2             	cmovs  %edx,%eax
ffff800000102381:	c1 f8 03             	sar    $0x3,%eax
ffff800000102384:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000102388:	48 98                	cltq
ffff80000010238a:	0f b6 84 02 b0 00 00 	movzbl 0xb0(%rdx,%rax,1),%eax
ffff800000102391:	00 
ffff800000102392:	0f b6 c0             	movzbl %al,%eax
ffff800000102395:	23 45 f0             	and    -0x10(%rbp),%eax
ffff800000102398:	85 c0                	test   %eax,%eax
ffff80000010239a:	75 19                	jne    ffff8000001023b5 <bfree+0xb8>
    panic("freeing free block");
ffff80000010239c:	48 b8 0b c1 10 00 00 	movabs $0xffff80000010c10b,%rax
ffff8000001023a3:	80 ff ff 
ffff8000001023a6:	48 89 c7             	mov    %rax,%rdi
ffff8000001023a9:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001023b0:	80 ff ff 
ffff8000001023b3:	ff d0                	call   *%rax
  bp->data[bi/8] &= ~m;
ffff8000001023b5:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff8000001023b8:	8d 50 07             	lea    0x7(%rax),%edx
ffff8000001023bb:	85 c0                	test   %eax,%eax
ffff8000001023bd:	0f 48 c2             	cmovs  %edx,%eax
ffff8000001023c0:	c1 f8 03             	sar    $0x3,%eax
ffff8000001023c3:	89 c1                	mov    %eax,%ecx
ffff8000001023c5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001023c9:	48 63 c1             	movslq %ecx,%rax
ffff8000001023cc:	0f b6 84 02 b0 00 00 	movzbl 0xb0(%rdx,%rax,1),%eax
ffff8000001023d3:	00 
ffff8000001023d4:	89 c2                	mov    %eax,%edx
ffff8000001023d6:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff8000001023d9:	f7 d0                	not    %eax
ffff8000001023db:	21 d0                	and    %edx,%eax
ffff8000001023dd:	89 c6                	mov    %eax,%esi
ffff8000001023df:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001023e3:	48 63 c1             	movslq %ecx,%rax
ffff8000001023e6:	40 88 b4 02 b0 00 00 	mov    %sil,0xb0(%rdx,%rax,1)
ffff8000001023ed:	00 
  log_write(bp);
ffff8000001023ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001023f2:	48 89 c7             	mov    %rax,%rdi
ffff8000001023f5:	48 b8 45 52 10 00 00 	movabs $0xffff800000105245,%rax
ffff8000001023fc:	80 ff ff 
ffff8000001023ff:	ff d0                	call   *%rax
  brelse(bp);
ffff800000102401:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102405:	48 89 c7             	mov    %rax,%rdi
ffff800000102408:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff80000010240f:	80 ff ff 
ffff800000102412:	ff d0                	call   *%rax
}
ffff800000102414:	90                   	nop
ffff800000102415:	c9                   	leave
ffff800000102416:	c3                   	ret

ffff800000102417 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
ffff800000102417:	55                   	push   %rbp
ffff800000102418:	48 89 e5             	mov    %rsp,%rbp
ffff80000010241b:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010241f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  int i = 0;
ffff800000102422:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)

  initlock(&icache.lock, "icache");
ffff800000102429:	48 ba 1e c1 10 00 00 	movabs $0xffff80000010c11e,%rdx
ffff800000102430:	80 ff ff 
ffff800000102433:	48 b8 20 46 11 00 00 	movabs $0xffff800000114620,%rax
ffff80000010243a:	80 ff ff 
ffff80000010243d:	48 89 d6             	mov    %rdx,%rsi
ffff800000102440:	48 89 c7             	mov    %rax,%rdi
ffff800000102443:	48 b8 05 77 10 00 00 	movabs $0xffff800000107705,%rax
ffff80000010244a:	80 ff ff 
ffff80000010244d:	ff d0                	call   *%rax
  for(i = 0; i < NINODE; i++) {
ffff80000010244f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000102456:	eb 41                	jmp    ffff800000102499 <iinit+0x82>
    initsleeplock(&icache.inode[i].lock, "inode");
ffff800000102458:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010245b:	48 98                	cltq
ffff80000010245d:	48 69 c0 d8 00 00 00 	imul   $0xd8,%rax,%rax
ffff800000102464:	48 8d 50 70          	lea    0x70(%rax),%rdx
ffff800000102468:	48 b8 20 46 11 00 00 	movabs $0xffff800000114620,%rax
ffff80000010246f:	80 ff ff 
ffff800000102472:	48 01 d0             	add    %rdx,%rax
ffff800000102475:	48 83 c0 08          	add    $0x8,%rax
ffff800000102479:	48 ba 25 c1 10 00 00 	movabs $0xffff80000010c125,%rdx
ffff800000102480:	80 ff ff 
ffff800000102483:	48 89 d6             	mov    %rdx,%rsi
ffff800000102486:	48 89 c7             	mov    %rax,%rdi
ffff800000102489:	48 b8 2f 75 10 00 00 	movabs $0xffff80000010752f,%rax
ffff800000102490:	80 ff ff 
ffff800000102493:	ff d0                	call   *%rax
  for(i = 0; i < NINODE; i++) {
ffff800000102495:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000102499:	83 7d fc 31          	cmpl   $0x31,-0x4(%rbp)
ffff80000010249d:	7e b9                	jle    ffff800000102458 <iinit+0x41>
  }

  readsb(dev, &sb);
ffff80000010249f:	48 ba 00 46 11 00 00 	movabs $0xffff800000114600,%rdx
ffff8000001024a6:	80 ff ff 
ffff8000001024a9:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001024ac:	48 89 d6             	mov    %rdx,%rsi
ffff8000001024af:	89 c7                	mov    %eax,%edi
ffff8000001024b1:	48 b8 91 20 10 00 00 	movabs $0xffff800000102091,%rax
ffff8000001024b8:	80 ff ff 
ffff8000001024bb:	ff d0                	call   *%rax
  /*cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);*/
}
ffff8000001024bd:	90                   	nop
ffff8000001024be:	c9                   	leave
ffff8000001024bf:	c3                   	ret

ffff8000001024c0 <ialloc>:

// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
ffff8000001024c0:	55                   	push   %rbp
ffff8000001024c1:	48 89 e5             	mov    %rsp,%rbp
ffff8000001024c4:	48 83 ec 30          	sub    $0x30,%rsp
ffff8000001024c8:	89 7d dc             	mov    %edi,-0x24(%rbp)
ffff8000001024cb:	89 f0                	mov    %esi,%eax
ffff8000001024cd:	66 89 45 d8          	mov    %ax,-0x28(%rbp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
ffff8000001024d1:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
ffff8000001024d8:	e9 d8 00 00 00       	jmp    ffff8000001025b5 <ialloc+0xf5>
    bp = bread(dev, IBLOCK(inum, sb));
ffff8000001024dd:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001024e0:	48 98                	cltq
ffff8000001024e2:	48 c1 e8 03          	shr    $0x3,%rax
ffff8000001024e6:	89 c2                	mov    %eax,%edx
ffff8000001024e8:	48 b8 00 46 11 00 00 	movabs $0xffff800000114600,%rax
ffff8000001024ef:	80 ff ff 
ffff8000001024f2:	8b 40 14             	mov    0x14(%rax),%eax
ffff8000001024f5:	01 c2                	add    %eax,%edx
ffff8000001024f7:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff8000001024fa:	89 d6                	mov    %edx,%esi
ffff8000001024fc:	89 c7                	mov    %eax,%edi
ffff8000001024fe:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000102505:	80 ff ff 
ffff800000102508:	ff d0                	call   *%rax
ffff80000010250a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    dip = (struct dinode*)bp->data + inum%IPB;
ffff80000010250e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102512:	48 8d 90 b0 00 00 00 	lea    0xb0(%rax),%rdx
ffff800000102519:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010251c:	48 98                	cltq
ffff80000010251e:	83 e0 07             	and    $0x7,%eax
ffff800000102521:	48 c1 e0 06          	shl    $0x6,%rax
ffff800000102525:	48 01 d0             	add    %rdx,%rax
ffff800000102528:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if(dip->type == 0){  // a free inode
ffff80000010252c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102530:	0f b7 00             	movzwl (%rax),%eax
ffff800000102533:	66 85 c0             	test   %ax,%ax
ffff800000102536:	75 66                	jne    ffff80000010259e <ialloc+0xde>
      memset(dip, 0, sizeof(*dip));
ffff800000102538:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010253c:	ba 40 00 00 00       	mov    $0x40,%edx
ffff800000102541:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000102546:	48 89 c7             	mov    %rax,%rdi
ffff800000102549:	48 b8 ce 7a 10 00 00 	movabs $0xffff800000107ace,%rax
ffff800000102550:	80 ff ff 
ffff800000102553:	ff d0                	call   *%rax
      dip->type = type;
ffff800000102555:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102559:	0f b7 55 d8          	movzwl -0x28(%rbp),%edx
ffff80000010255d:	66 89 10             	mov    %dx,(%rax)
      log_write(bp);   // mark it allocated on the disk
ffff800000102560:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102564:	48 89 c7             	mov    %rax,%rdi
ffff800000102567:	48 b8 45 52 10 00 00 	movabs $0xffff800000105245,%rax
ffff80000010256e:	80 ff ff 
ffff800000102571:	ff d0                	call   *%rax
      brelse(bp);
ffff800000102573:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102577:	48 89 c7             	mov    %rax,%rdi
ffff80000010257a:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000102581:	80 ff ff 
ffff800000102584:	ff d0                	call   *%rax
      return iget(dev, inum);
ffff800000102586:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102589:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff80000010258c:	89 d6                	mov    %edx,%esi
ffff80000010258e:	89 c7                	mov    %eax,%edi
ffff800000102590:	48 b8 fa 26 10 00 00 	movabs $0xffff8000001026fa,%rax
ffff800000102597:	80 ff ff 
ffff80000010259a:	ff d0                	call   *%rax
ffff80000010259c:	eb 48                	jmp    ffff8000001025e6 <ialloc+0x126>
    }
    brelse(bp);
ffff80000010259e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001025a2:	48 89 c7             	mov    %rax,%rdi
ffff8000001025a5:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff8000001025ac:	80 ff ff 
ffff8000001025af:	ff d0                	call   *%rax
  for(inum = 1; inum < sb.ninodes; inum++){
ffff8000001025b1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001025b5:	48 b8 00 46 11 00 00 	movabs $0xffff800000114600,%rax
ffff8000001025bc:	80 ff ff 
ffff8000001025bf:	8b 40 08             	mov    0x8(%rax),%eax
ffff8000001025c2:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001025c5:	39 c2                	cmp    %eax,%edx
ffff8000001025c7:	0f 82 10 ff ff ff    	jb     ffff8000001024dd <ialloc+0x1d>
  }
  panic("ialloc: no inodes");
ffff8000001025cd:	48 b8 2b c1 10 00 00 	movabs $0xffff80000010c12b,%rax
ffff8000001025d4:	80 ff ff 
ffff8000001025d7:	48 89 c7             	mov    %rax,%rdi
ffff8000001025da:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001025e1:	80 ff ff 
ffff8000001025e4:	ff d0                	call   *%rax
}
ffff8000001025e6:	c9                   	leave
ffff8000001025e7:	c3                   	ret

ffff8000001025e8 <iupdate>:

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
ffff8000001025e8:	55                   	push   %rbp
ffff8000001025e9:	48 89 e5             	mov    %rsp,%rbp
ffff8000001025ec:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001025f0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
ffff8000001025f4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001025f8:	8b 40 04             	mov    0x4(%rax),%eax
ffff8000001025fb:	c1 e8 03             	shr    $0x3,%eax
ffff8000001025fe:	89 c2                	mov    %eax,%edx
ffff800000102600:	48 b8 00 46 11 00 00 	movabs $0xffff800000114600,%rax
ffff800000102607:	80 ff ff 
ffff80000010260a:	8b 40 14             	mov    0x14(%rax),%eax
ffff80000010260d:	01 c2                	add    %eax,%edx
ffff80000010260f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102613:	8b 00                	mov    (%rax),%eax
ffff800000102615:	89 d6                	mov    %edx,%esi
ffff800000102617:	89 c7                	mov    %eax,%edi
ffff800000102619:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000102620:	80 ff ff 
ffff800000102623:	ff d0                	call   *%rax
ffff800000102625:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
ffff800000102629:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010262d:	48 8d 90 b0 00 00 00 	lea    0xb0(%rax),%rdx
ffff800000102634:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102638:	8b 40 04             	mov    0x4(%rax),%eax
ffff80000010263b:	89 c0                	mov    %eax,%eax
ffff80000010263d:	83 e0 07             	and    $0x7,%eax
ffff800000102640:	48 c1 e0 06          	shl    $0x6,%rax
ffff800000102644:	48 01 d0             	add    %rdx,%rax
ffff800000102647:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  dip->type = ip->type;
ffff80000010264b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010264f:	0f b7 90 94 00 00 00 	movzwl 0x94(%rax),%edx
ffff800000102656:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010265a:	66 89 10             	mov    %dx,(%rax)
  dip->major = ip->major;
ffff80000010265d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102661:	0f b7 90 96 00 00 00 	movzwl 0x96(%rax),%edx
ffff800000102668:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010266c:	66 89 50 02          	mov    %dx,0x2(%rax)
  dip->minor = ip->minor;
ffff800000102670:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102674:	0f b7 90 98 00 00 00 	movzwl 0x98(%rax),%edx
ffff80000010267b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010267f:	66 89 50 04          	mov    %dx,0x4(%rax)
  dip->nlink = ip->nlink;
ffff800000102683:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102687:	0f b7 90 9a 00 00 00 	movzwl 0x9a(%rax),%edx
ffff80000010268e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102692:	66 89 50 06          	mov    %dx,0x6(%rax)
  dip->size = ip->size;
ffff800000102696:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010269a:	8b 90 9c 00 00 00    	mov    0x9c(%rax),%edx
ffff8000001026a0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001026a4:	89 50 08             	mov    %edx,0x8(%rax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
ffff8000001026a7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001026ab:	48 8d 88 a0 00 00 00 	lea    0xa0(%rax),%rcx
ffff8000001026b2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001026b6:	48 83 c0 0c          	add    $0xc,%rax
ffff8000001026ba:	ba 34 00 00 00       	mov    $0x34,%edx
ffff8000001026bf:	48 89 ce             	mov    %rcx,%rsi
ffff8000001026c2:	48 89 c7             	mov    %rax,%rdi
ffff8000001026c5:	48 b8 d3 7b 10 00 00 	movabs $0xffff800000107bd3,%rax
ffff8000001026cc:	80 ff ff 
ffff8000001026cf:	ff d0                	call   *%rax
  log_write(bp);
ffff8000001026d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001026d5:	48 89 c7             	mov    %rax,%rdi
ffff8000001026d8:	48 b8 45 52 10 00 00 	movabs $0xffff800000105245,%rax
ffff8000001026df:	80 ff ff 
ffff8000001026e2:	ff d0                	call   *%rax
  brelse(bp);
ffff8000001026e4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001026e8:	48 89 c7             	mov    %rax,%rdi
ffff8000001026eb:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff8000001026f2:	80 ff ff 
ffff8000001026f5:	ff d0                	call   *%rax
}
ffff8000001026f7:	90                   	nop
ffff8000001026f8:	c9                   	leave
ffff8000001026f9:	c3                   	ret

ffff8000001026fa <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
ffff8000001026fa:	55                   	push   %rbp
ffff8000001026fb:	48 89 e5             	mov    %rsp,%rbp
ffff8000001026fe:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000102702:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000102705:	89 75 e8             	mov    %esi,-0x18(%rbp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
ffff800000102708:	48 b8 20 46 11 00 00 	movabs $0xffff800000114620,%rax
ffff80000010270f:	80 ff ff 
ffff800000102712:	48 89 c7             	mov    %rax,%rdi
ffff800000102715:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff80000010271c:	80 ff ff 
ffff80000010271f:	ff d0                	call   *%rax

  // Is the inode already cached?
  empty = 0;
ffff800000102721:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
ffff800000102728:	00 
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
ffff800000102729:	48 b8 88 46 11 00 00 	movabs $0xffff800000114688,%rax
ffff800000102730:	80 ff ff 
ffff800000102733:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000102737:	eb 77                	jmp    ffff8000001027b0 <iget+0xb6>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
ffff800000102739:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010273d:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000102740:	85 c0                	test   %eax,%eax
ffff800000102742:	7e 4a                	jle    ffff80000010278e <iget+0x94>
ffff800000102744:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102748:	8b 00                	mov    (%rax),%eax
ffff80000010274a:	39 45 ec             	cmp    %eax,-0x14(%rbp)
ffff80000010274d:	75 3f                	jne    ffff80000010278e <iget+0x94>
ffff80000010274f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102753:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000102756:	39 45 e8             	cmp    %eax,-0x18(%rbp)
ffff800000102759:	75 33                	jne    ffff80000010278e <iget+0x94>
      ip->ref++;
ffff80000010275b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010275f:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000102762:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000102765:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102769:	89 50 08             	mov    %edx,0x8(%rax)
      release(&icache.lock);
ffff80000010276c:	48 b8 20 46 11 00 00 	movabs $0xffff800000114620,%rax
ffff800000102773:	80 ff ff 
ffff800000102776:	48 89 c7             	mov    %rax,%rdi
ffff800000102779:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000102780:	80 ff ff 
ffff800000102783:	ff d0                	call   *%rax
      return ip;
ffff800000102785:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102789:	e9 a7 00 00 00       	jmp    ffff800000102835 <iget+0x13b>
    }
    if(empty == 0 && ip->ref == 0) // Remember empty slot.
ffff80000010278e:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000102793:	75 13                	jne    ffff8000001027a8 <iget+0xae>
ffff800000102795:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102799:	8b 40 08             	mov    0x8(%rax),%eax
ffff80000010279c:	85 c0                	test   %eax,%eax
ffff80000010279e:	75 08                	jne    ffff8000001027a8 <iget+0xae>
      empty = ip;
ffff8000001027a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001027a4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
ffff8000001027a8:	48 81 45 f8 d8 00 00 	addq   $0xd8,-0x8(%rbp)
ffff8000001027af:	00 
ffff8000001027b0:	48 b8 b8 70 11 00 00 	movabs $0xffff8000001170b8,%rax
ffff8000001027b7:	80 ff ff 
ffff8000001027ba:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff8000001027be:	0f 82 75 ff ff ff    	jb     ffff800000102739 <iget+0x3f>
  }

  // Recycle an inode cache entry.
  if(empty == 0)
ffff8000001027c4:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff8000001027c9:	75 19                	jne    ffff8000001027e4 <iget+0xea>
    panic("iget: no inodes");
ffff8000001027cb:	48 b8 3d c1 10 00 00 	movabs $0xffff80000010c13d,%rax
ffff8000001027d2:	80 ff ff 
ffff8000001027d5:	48 89 c7             	mov    %rax,%rdi
ffff8000001027d8:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001027df:	80 ff ff 
ffff8000001027e2:	ff d0                	call   *%rax

  ip = empty;
ffff8000001027e4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001027e8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  ip->dev = dev;
ffff8000001027ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001027f0:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff8000001027f3:	89 10                	mov    %edx,(%rax)
  ip->inum = inum;
ffff8000001027f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001027f9:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffff8000001027fc:	89 50 04             	mov    %edx,0x4(%rax)
  ip->ref = 1;
ffff8000001027ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102803:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%rax)
  ip->flags = 0;
ffff80000010280a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010280e:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%rax)
ffff800000102815:	00 00 00 
  release(&icache.lock);
ffff800000102818:	48 b8 20 46 11 00 00 	movabs $0xffff800000114620,%rax
ffff80000010281f:	80 ff ff 
ffff800000102822:	48 89 c7             	mov    %rax,%rdi
ffff800000102825:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff80000010282c:	80 ff ff 
ffff80000010282f:	ff d0                	call   *%rax

  return ip;
ffff800000102831:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000102835:	c9                   	leave
ffff800000102836:	c3                   	ret

ffff800000102837 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
ffff800000102837:	55                   	push   %rbp
ffff800000102838:	48 89 e5             	mov    %rsp,%rbp
ffff80000010283b:	48 83 ec 10          	sub    $0x10,%rsp
ffff80000010283f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&icache.lock);
ffff800000102843:	48 b8 20 46 11 00 00 	movabs $0xffff800000114620,%rax
ffff80000010284a:	80 ff ff 
ffff80000010284d:	48 89 c7             	mov    %rax,%rdi
ffff800000102850:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff800000102857:	80 ff ff 
ffff80000010285a:	ff d0                	call   *%rax
  ip->ref++;
ffff80000010285c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102860:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000102863:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000102866:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010286a:	89 50 08             	mov    %edx,0x8(%rax)
  release(&icache.lock);
ffff80000010286d:	48 b8 20 46 11 00 00 	movabs $0xffff800000114620,%rax
ffff800000102874:	80 ff ff 
ffff800000102877:	48 89 c7             	mov    %rax,%rdi
ffff80000010287a:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000102881:	80 ff ff 
ffff800000102884:	ff d0                	call   *%rax
  return ip;
ffff800000102886:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff80000010288a:	c9                   	leave
ffff80000010288b:	c3                   	ret

ffff80000010288c <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
ffff80000010288c:	55                   	push   %rbp
ffff80000010288d:	48 89 e5             	mov    %rsp,%rbp
ffff800000102890:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000102894:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
ffff800000102898:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010289d:	74 0b                	je     ffff8000001028aa <ilock+0x1e>
ffff80000010289f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001028a3:	8b 40 08             	mov    0x8(%rax),%eax
ffff8000001028a6:	85 c0                	test   %eax,%eax
ffff8000001028a8:	7f 19                	jg     ffff8000001028c3 <ilock+0x37>
    panic("ilock");
ffff8000001028aa:	48 b8 4d c1 10 00 00 	movabs $0xffff80000010c14d,%rax
ffff8000001028b1:	80 ff ff 
ffff8000001028b4:	48 89 c7             	mov    %rax,%rdi
ffff8000001028b7:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001028be:	80 ff ff 
ffff8000001028c1:	ff d0                	call   *%rax

  acquiresleep(&ip->lock);
ffff8000001028c3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001028c7:	48 83 c0 10          	add    $0x10,%rax
ffff8000001028cb:	48 89 c7             	mov    %rax,%rdi
ffff8000001028ce:	48 b8 87 75 10 00 00 	movabs $0xffff800000107587,%rax
ffff8000001028d5:	80 ff ff 
ffff8000001028d8:	ff d0                	call   *%rax

  if(!(ip->flags & I_VALID)){
ffff8000001028da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001028de:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
ffff8000001028e4:	83 e0 02             	and    $0x2,%eax
ffff8000001028e7:	85 c0                	test   %eax,%eax
ffff8000001028e9:	0f 85 31 01 00 00    	jne    ffff800000102a20 <ilock+0x194>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
ffff8000001028ef:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001028f3:	8b 40 04             	mov    0x4(%rax),%eax
ffff8000001028f6:	c1 e8 03             	shr    $0x3,%eax
ffff8000001028f9:	89 c2                	mov    %eax,%edx
ffff8000001028fb:	48 b8 00 46 11 00 00 	movabs $0xffff800000114600,%rax
ffff800000102902:	80 ff ff 
ffff800000102905:	8b 40 14             	mov    0x14(%rax),%eax
ffff800000102908:	01 c2                	add    %eax,%edx
ffff80000010290a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010290e:	8b 00                	mov    (%rax),%eax
ffff800000102910:	89 d6                	mov    %edx,%esi
ffff800000102912:	89 c7                	mov    %eax,%edi
ffff800000102914:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff80000010291b:	80 ff ff 
ffff80000010291e:	ff d0                	call   *%rax
ffff800000102920:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
ffff800000102924:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102928:	48 8d 90 b0 00 00 00 	lea    0xb0(%rax),%rdx
ffff80000010292f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102933:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000102936:	89 c0                	mov    %eax,%eax
ffff800000102938:	83 e0 07             	and    $0x7,%eax
ffff80000010293b:	48 c1 e0 06          	shl    $0x6,%rax
ffff80000010293f:	48 01 d0             	add    %rdx,%rax
ffff800000102942:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    ip->type = dip->type;
ffff800000102946:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010294a:	0f b7 10             	movzwl (%rax),%edx
ffff80000010294d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102951:	66 89 90 94 00 00 00 	mov    %dx,0x94(%rax)
    ip->major = dip->major;
ffff800000102958:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010295c:	0f b7 50 02          	movzwl 0x2(%rax),%edx
ffff800000102960:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102964:	66 89 90 96 00 00 00 	mov    %dx,0x96(%rax)
    ip->minor = dip->minor;
ffff80000010296b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010296f:	0f b7 50 04          	movzwl 0x4(%rax),%edx
ffff800000102973:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102977:	66 89 90 98 00 00 00 	mov    %dx,0x98(%rax)
    ip->nlink = dip->nlink;
ffff80000010297e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102982:	0f b7 50 06          	movzwl 0x6(%rax),%edx
ffff800000102986:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010298a:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
    ip->size = dip->size;
ffff800000102991:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102995:	8b 50 08             	mov    0x8(%rax),%edx
ffff800000102998:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010299c:	89 90 9c 00 00 00    	mov    %edx,0x9c(%rax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
ffff8000001029a2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001029a6:	48 8d 48 0c          	lea    0xc(%rax),%rcx
ffff8000001029aa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001029ae:	48 05 a0 00 00 00    	add    $0xa0,%rax
ffff8000001029b4:	ba 34 00 00 00       	mov    $0x34,%edx
ffff8000001029b9:	48 89 ce             	mov    %rcx,%rsi
ffff8000001029bc:	48 89 c7             	mov    %rax,%rdi
ffff8000001029bf:	48 b8 d3 7b 10 00 00 	movabs $0xffff800000107bd3,%rax
ffff8000001029c6:	80 ff ff 
ffff8000001029c9:	ff d0                	call   *%rax
    brelse(bp);
ffff8000001029cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001029cf:	48 89 c7             	mov    %rax,%rdi
ffff8000001029d2:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff8000001029d9:	80 ff ff 
ffff8000001029dc:	ff d0                	call   *%rax
    ip->flags |= I_VALID;
ffff8000001029de:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001029e2:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
ffff8000001029e8:	83 c8 02             	or     $0x2,%eax
ffff8000001029eb:	89 c2                	mov    %eax,%edx
ffff8000001029ed:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001029f1:	89 90 90 00 00 00    	mov    %edx,0x90(%rax)
    if(ip->type == 0)
ffff8000001029f7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001029fb:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000102a02:	66 85 c0             	test   %ax,%ax
ffff800000102a05:	75 19                	jne    ffff800000102a20 <ilock+0x194>
      panic("ilock: no type");
ffff800000102a07:	48 b8 53 c1 10 00 00 	movabs $0xffff80000010c153,%rax
ffff800000102a0e:	80 ff ff 
ffff800000102a11:	48 89 c7             	mov    %rax,%rdi
ffff800000102a14:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000102a1b:	80 ff ff 
ffff800000102a1e:	ff d0                	call   *%rax
  }
}
ffff800000102a20:	90                   	nop
ffff800000102a21:	c9                   	leave
ffff800000102a22:	c3                   	ret

ffff800000102a23 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
ffff800000102a23:	55                   	push   %rbp
ffff800000102a24:	48 89 e5             	mov    %rsp,%rbp
ffff800000102a27:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000102a2b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
ffff800000102a2f:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000102a34:	74 26                	je     ffff800000102a5c <iunlock+0x39>
ffff800000102a36:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102a3a:	48 83 c0 10          	add    $0x10,%rax
ffff800000102a3e:	48 89 c7             	mov    %rax,%rdi
ffff800000102a41:	48 b8 72 76 10 00 00 	movabs $0xffff800000107672,%rax
ffff800000102a48:	80 ff ff 
ffff800000102a4b:	ff d0                	call   *%rax
ffff800000102a4d:	85 c0                	test   %eax,%eax
ffff800000102a4f:	74 0b                	je     ffff800000102a5c <iunlock+0x39>
ffff800000102a51:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102a55:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000102a58:	85 c0                	test   %eax,%eax
ffff800000102a5a:	7f 19                	jg     ffff800000102a75 <iunlock+0x52>
    panic("iunlock");
ffff800000102a5c:	48 b8 62 c1 10 00 00 	movabs $0xffff80000010c162,%rax
ffff800000102a63:	80 ff ff 
ffff800000102a66:	48 89 c7             	mov    %rax,%rdi
ffff800000102a69:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000102a70:	80 ff ff 
ffff800000102a73:	ff d0                	call   *%rax

  releasesleep(&ip->lock);
ffff800000102a75:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102a79:	48 83 c0 10          	add    $0x10,%rax
ffff800000102a7d:	48 89 c7             	mov    %rax,%rdi
ffff800000102a80:	48 b8 0d 76 10 00 00 	movabs $0xffff80000010760d,%rax
ffff800000102a87:	80 ff ff 
ffff800000102a8a:	ff d0                	call   *%rax
}
ffff800000102a8c:	90                   	nop
ffff800000102a8d:	c9                   	leave
ffff800000102a8e:	c3                   	ret

ffff800000102a8f <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
ffff800000102a8f:	55                   	push   %rbp
ffff800000102a90:	48 89 e5             	mov    %rsp,%rbp
ffff800000102a93:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000102a97:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&icache.lock);
ffff800000102a9b:	48 b8 20 46 11 00 00 	movabs $0xffff800000114620,%rax
ffff800000102aa2:	80 ff ff 
ffff800000102aa5:	48 89 c7             	mov    %rax,%rdi
ffff800000102aa8:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff800000102aaf:	80 ff ff 
ffff800000102ab2:	ff d0                	call   *%rax
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
ffff800000102ab4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102ab8:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000102abb:	83 f8 01             	cmp    $0x1,%eax
ffff800000102abe:	0f 85 98 00 00 00    	jne    ffff800000102b5c <iput+0xcd>
ffff800000102ac4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102ac8:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
ffff800000102ace:	83 e0 02             	and    $0x2,%eax
ffff800000102ad1:	85 c0                	test   %eax,%eax
ffff800000102ad3:	0f 84 83 00 00 00    	je     ffff800000102b5c <iput+0xcd>
ffff800000102ad9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102add:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff800000102ae4:	66 85 c0             	test   %ax,%ax
ffff800000102ae7:	75 73                	jne    ffff800000102b5c <iput+0xcd>
    // inode has no links and no other references: truncate and free.
    release(&icache.lock);
ffff800000102ae9:	48 b8 20 46 11 00 00 	movabs $0xffff800000114620,%rax
ffff800000102af0:	80 ff ff 
ffff800000102af3:	48 89 c7             	mov    %rax,%rdi
ffff800000102af6:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000102afd:	80 ff ff 
ffff800000102b00:	ff d0                	call   *%rax
    itrunc(ip);
ffff800000102b02:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102b06:	48 89 c7             	mov    %rax,%rdi
ffff800000102b09:	48 b8 1b 2d 10 00 00 	movabs $0xffff800000102d1b,%rax
ffff800000102b10:	80 ff ff 
ffff800000102b13:	ff d0                	call   *%rax
    ip->type = 0;
ffff800000102b15:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102b19:	66 c7 80 94 00 00 00 	movw   $0x0,0x94(%rax)
ffff800000102b20:	00 00 
    iupdate(ip);
ffff800000102b22:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102b26:	48 89 c7             	mov    %rax,%rdi
ffff800000102b29:	48 b8 e8 25 10 00 00 	movabs $0xffff8000001025e8,%rax
ffff800000102b30:	80 ff ff 
ffff800000102b33:	ff d0                	call   *%rax
    acquire(&icache.lock);
ffff800000102b35:	48 b8 20 46 11 00 00 	movabs $0xffff800000114620,%rax
ffff800000102b3c:	80 ff ff 
ffff800000102b3f:	48 89 c7             	mov    %rax,%rdi
ffff800000102b42:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff800000102b49:	80 ff ff 
ffff800000102b4c:	ff d0                	call   *%rax
    ip->flags = 0;
ffff800000102b4e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102b52:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%rax)
ffff800000102b59:	00 00 00 
  }
  ip->ref--;
ffff800000102b5c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102b60:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000102b63:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000102b66:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102b6a:	89 50 08             	mov    %edx,0x8(%rax)
  release(&icache.lock);
ffff800000102b6d:	48 b8 20 46 11 00 00 	movabs $0xffff800000114620,%rax
ffff800000102b74:	80 ff ff 
ffff800000102b77:	48 89 c7             	mov    %rax,%rdi
ffff800000102b7a:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000102b81:	80 ff ff 
ffff800000102b84:	ff d0                	call   *%rax
}
ffff800000102b86:	90                   	nop
ffff800000102b87:	c9                   	leave
ffff800000102b88:	c3                   	ret

ffff800000102b89 <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
ffff800000102b89:	55                   	push   %rbp
ffff800000102b8a:	48 89 e5             	mov    %rsp,%rbp
ffff800000102b8d:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000102b91:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  iunlock(ip);
ffff800000102b95:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102b99:	48 89 c7             	mov    %rax,%rdi
ffff800000102b9c:	48 b8 23 2a 10 00 00 	movabs $0xffff800000102a23,%rax
ffff800000102ba3:	80 ff ff 
ffff800000102ba6:	ff d0                	call   *%rax
  iput(ip);
ffff800000102ba8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102bac:	48 89 c7             	mov    %rax,%rdi
ffff800000102baf:	48 b8 8f 2a 10 00 00 	movabs $0xffff800000102a8f,%rax
ffff800000102bb6:	80 ff ff 
ffff800000102bb9:	ff d0                	call   *%rax
}
ffff800000102bbb:	90                   	nop
ffff800000102bbc:	c9                   	leave
ffff800000102bbd:	c3                   	ret

ffff800000102bbe <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
ffff800000102bbe:	55                   	push   %rbp
ffff800000102bbf:	48 89 e5             	mov    %rsp,%rbp
ffff800000102bc2:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000102bc6:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000102bca:	89 75 d4             	mov    %esi,-0x2c(%rbp)
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
ffff800000102bcd:	83 7d d4 0b          	cmpl   $0xb,-0x2c(%rbp)
ffff800000102bd1:	77 47                	ja     ffff800000102c1a <bmap+0x5c>
    if((addr = ip->addrs[bn]) == 0)
ffff800000102bd3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102bd7:	8b 55 d4             	mov    -0x2c(%rbp),%edx
ffff800000102bda:	48 83 c2 28          	add    $0x28,%rdx
ffff800000102bde:	8b 04 90             	mov    (%rax,%rdx,4),%eax
ffff800000102be1:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000102be4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000102be8:	75 28                	jne    ffff800000102c12 <bmap+0x54>
      ip->addrs[bn] = addr = balloc(ip->dev);
ffff800000102bea:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102bee:	8b 00                	mov    (%rax),%eax
ffff800000102bf0:	89 c7                	mov    %eax,%edi
ffff800000102bf2:	48 b8 6a 21 10 00 00 	movabs $0xffff80000010216a,%rax
ffff800000102bf9:	80 ff ff 
ffff800000102bfc:	ff d0                	call   *%rax
ffff800000102bfe:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000102c01:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102c05:	8b 55 d4             	mov    -0x2c(%rbp),%edx
ffff800000102c08:	48 8d 4a 28          	lea    0x28(%rdx),%rcx
ffff800000102c0c:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102c0f:	89 14 88             	mov    %edx,(%rax,%rcx,4)
    return addr;
ffff800000102c12:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102c15:	e9 ff 00 00 00       	jmp    ffff800000102d19 <bmap+0x15b>
  }
  bn -= NDIRECT;
ffff800000102c1a:	83 6d d4 0c          	subl   $0xc,-0x2c(%rbp)

  if(bn < NINDIRECT){
ffff800000102c1e:	83 7d d4 7f          	cmpl   $0x7f,-0x2c(%rbp)
ffff800000102c22:	0f 87 d8 00 00 00    	ja     ffff800000102d00 <bmap+0x142>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
ffff800000102c28:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102c2c:	8b 80 d0 00 00 00    	mov    0xd0(%rax),%eax
ffff800000102c32:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000102c35:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000102c39:	75 24                	jne    ffff800000102c5f <bmap+0xa1>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
ffff800000102c3b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102c3f:	8b 00                	mov    (%rax),%eax
ffff800000102c41:	89 c7                	mov    %eax,%edi
ffff800000102c43:	48 b8 6a 21 10 00 00 	movabs $0xffff80000010216a,%rax
ffff800000102c4a:	80 ff ff 
ffff800000102c4d:	ff d0                	call   *%rax
ffff800000102c4f:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000102c52:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102c56:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102c59:	89 90 d0 00 00 00    	mov    %edx,0xd0(%rax)
    bp = bread(ip->dev, addr);
ffff800000102c5f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102c63:	8b 00                	mov    (%rax),%eax
ffff800000102c65:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102c68:	89 d6                	mov    %edx,%esi
ffff800000102c6a:	89 c7                	mov    %eax,%edi
ffff800000102c6c:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000102c73:	80 ff ff 
ffff800000102c76:	ff d0                	call   *%rax
ffff800000102c78:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    a = (uint*)bp->data;
ffff800000102c7c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102c80:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000102c86:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if((addr = a[bn]) == 0){
ffff800000102c8a:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff800000102c8d:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff800000102c94:	00 
ffff800000102c95:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102c99:	48 01 d0             	add    %rdx,%rax
ffff800000102c9c:	8b 00                	mov    (%rax),%eax
ffff800000102c9e:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000102ca1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000102ca5:	75 41                	jne    ffff800000102ce8 <bmap+0x12a>
      a[bn] = addr = balloc(ip->dev);
ffff800000102ca7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102cab:	8b 00                	mov    (%rax),%eax
ffff800000102cad:	89 c7                	mov    %eax,%edi
ffff800000102caf:	48 b8 6a 21 10 00 00 	movabs $0xffff80000010216a,%rax
ffff800000102cb6:	80 ff ff 
ffff800000102cb9:	ff d0                	call   *%rax
ffff800000102cbb:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000102cbe:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff800000102cc1:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff800000102cc8:	00 
ffff800000102cc9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102ccd:	48 01 c2             	add    %rax,%rdx
ffff800000102cd0:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102cd3:	89 02                	mov    %eax,(%rdx)
      log_write(bp);
ffff800000102cd5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102cd9:	48 89 c7             	mov    %rax,%rdi
ffff800000102cdc:	48 b8 45 52 10 00 00 	movabs $0xffff800000105245,%rax
ffff800000102ce3:	80 ff ff 
ffff800000102ce6:	ff d0                	call   *%rax
    }
    brelse(bp);
ffff800000102ce8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102cec:	48 89 c7             	mov    %rax,%rdi
ffff800000102cef:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000102cf6:	80 ff ff 
ffff800000102cf9:	ff d0                	call   *%rax
    return addr;
ffff800000102cfb:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102cfe:	eb 19                	jmp    ffff800000102d19 <bmap+0x15b>
  }

  panic("bmap: out of range");
ffff800000102d00:	48 b8 6a c1 10 00 00 	movabs $0xffff80000010c16a,%rax
ffff800000102d07:	80 ff ff 
ffff800000102d0a:	48 89 c7             	mov    %rax,%rdi
ffff800000102d0d:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000102d14:	80 ff ff 
ffff800000102d17:	ff d0                	call   *%rax
}
ffff800000102d19:	c9                   	leave
ffff800000102d1a:	c3                   	ret

ffff800000102d1b <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
ffff800000102d1b:	55                   	push   %rbp
ffff800000102d1c:	48 89 e5             	mov    %rsp,%rbp
ffff800000102d1f:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000102d23:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
ffff800000102d27:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000102d2e:	eb 55                	jmp    ffff800000102d85 <itrunc+0x6a>
    if(ip->addrs[i]){
ffff800000102d30:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102d34:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102d37:	48 63 d2             	movslq %edx,%rdx
ffff800000102d3a:	48 83 c2 28          	add    $0x28,%rdx
ffff800000102d3e:	8b 04 90             	mov    (%rax,%rdx,4),%eax
ffff800000102d41:	85 c0                	test   %eax,%eax
ffff800000102d43:	74 3c                	je     ffff800000102d81 <itrunc+0x66>
      bfree(ip->dev, ip->addrs[i]);
ffff800000102d45:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102d49:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102d4c:	48 63 d2             	movslq %edx,%rdx
ffff800000102d4f:	48 83 c2 28          	add    $0x28,%rdx
ffff800000102d53:	8b 04 90             	mov    (%rax,%rdx,4),%eax
ffff800000102d56:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff800000102d5a:	8b 12                	mov    (%rdx),%edx
ffff800000102d5c:	89 c6                	mov    %eax,%esi
ffff800000102d5e:	89 d7                	mov    %edx,%edi
ffff800000102d60:	48 b8 fd 22 10 00 00 	movabs $0xffff8000001022fd,%rax
ffff800000102d67:	80 ff ff 
ffff800000102d6a:	ff d0                	call   *%rax
      ip->addrs[i] = 0;
ffff800000102d6c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102d70:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102d73:	48 63 d2             	movslq %edx,%rdx
ffff800000102d76:	48 83 c2 28          	add    $0x28,%rdx
ffff800000102d7a:	c7 04 90 00 00 00 00 	movl   $0x0,(%rax,%rdx,4)
  for(i = 0; i < NDIRECT; i++){
ffff800000102d81:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000102d85:	83 7d fc 0b          	cmpl   $0xb,-0x4(%rbp)
ffff800000102d89:	7e a5                	jle    ffff800000102d30 <itrunc+0x15>
    }
  }

  if(ip->addrs[NDIRECT]){
ffff800000102d8b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102d8f:	8b 80 d0 00 00 00    	mov    0xd0(%rax),%eax
ffff800000102d95:	85 c0                	test   %eax,%eax
ffff800000102d97:	0f 84 ce 00 00 00    	je     ffff800000102e6b <itrunc+0x150>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
ffff800000102d9d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102da1:	8b 90 d0 00 00 00    	mov    0xd0(%rax),%edx
ffff800000102da7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102dab:	8b 00                	mov    (%rax),%eax
ffff800000102dad:	89 d6                	mov    %edx,%esi
ffff800000102daf:	89 c7                	mov    %eax,%edi
ffff800000102db1:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000102db8:	80 ff ff 
ffff800000102dbb:	ff d0                	call   *%rax
ffff800000102dbd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    a = (uint*)bp->data;
ffff800000102dc1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102dc5:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000102dcb:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for(j = 0; j < NINDIRECT; j++){
ffff800000102dcf:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
ffff800000102dd6:	eb 4a                	jmp    ffff800000102e22 <itrunc+0x107>
      if(a[j])
ffff800000102dd8:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000102ddb:	48 98                	cltq
ffff800000102ddd:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff800000102de4:	00 
ffff800000102de5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102de9:	48 01 d0             	add    %rdx,%rax
ffff800000102dec:	8b 00                	mov    (%rax),%eax
ffff800000102dee:	85 c0                	test   %eax,%eax
ffff800000102df0:	74 2c                	je     ffff800000102e1e <itrunc+0x103>
        bfree(ip->dev, a[j]);
ffff800000102df2:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000102df5:	48 98                	cltq
ffff800000102df7:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff800000102dfe:	00 
ffff800000102dff:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102e03:	48 01 d0             	add    %rdx,%rax
ffff800000102e06:	8b 00                	mov    (%rax),%eax
ffff800000102e08:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff800000102e0c:	8b 12                	mov    (%rdx),%edx
ffff800000102e0e:	89 c6                	mov    %eax,%esi
ffff800000102e10:	89 d7                	mov    %edx,%edi
ffff800000102e12:	48 b8 fd 22 10 00 00 	movabs $0xffff8000001022fd,%rax
ffff800000102e19:	80 ff ff 
ffff800000102e1c:	ff d0                	call   *%rax
    for(j = 0; j < NINDIRECT; j++){
ffff800000102e1e:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
ffff800000102e22:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000102e25:	83 f8 7f             	cmp    $0x7f,%eax
ffff800000102e28:	76 ae                	jbe    ffff800000102dd8 <itrunc+0xbd>
    }
    brelse(bp);
ffff800000102e2a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102e2e:	48 89 c7             	mov    %rax,%rdi
ffff800000102e31:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000102e38:	80 ff ff 
ffff800000102e3b:	ff d0                	call   *%rax
    bfree(ip->dev, ip->addrs[NDIRECT]);
ffff800000102e3d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102e41:	8b 80 d0 00 00 00    	mov    0xd0(%rax),%eax
ffff800000102e47:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff800000102e4b:	8b 12                	mov    (%rdx),%edx
ffff800000102e4d:	89 c6                	mov    %eax,%esi
ffff800000102e4f:	89 d7                	mov    %edx,%edi
ffff800000102e51:	48 b8 fd 22 10 00 00 	movabs $0xffff8000001022fd,%rax
ffff800000102e58:	80 ff ff 
ffff800000102e5b:	ff d0                	call   *%rax
    ip->addrs[NDIRECT] = 0;
ffff800000102e5d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102e61:	c7 80 d0 00 00 00 00 	movl   $0x0,0xd0(%rax)
ffff800000102e68:	00 00 00 
  }

  ip->size = 0;
ffff800000102e6b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102e6f:	c7 80 9c 00 00 00 00 	movl   $0x0,0x9c(%rax)
ffff800000102e76:	00 00 00 
  iupdate(ip);
ffff800000102e79:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102e7d:	48 89 c7             	mov    %rax,%rdi
ffff800000102e80:	48 b8 e8 25 10 00 00 	movabs $0xffff8000001025e8,%rax
ffff800000102e87:	80 ff ff 
ffff800000102e8a:	ff d0                	call   *%rax
}
ffff800000102e8c:	90                   	nop
ffff800000102e8d:	c9                   	leave
ffff800000102e8e:	c3                   	ret

ffff800000102e8f <stati>:

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
ffff800000102e8f:	55                   	push   %rbp
ffff800000102e90:	48 89 e5             	mov    %rsp,%rbp
ffff800000102e93:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000102e97:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000102e9b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  st->dev = ip->dev;
ffff800000102e9f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102ea3:	8b 00                	mov    (%rax),%eax
ffff800000102ea5:	89 c2                	mov    %eax,%edx
ffff800000102ea7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102eab:	89 50 04             	mov    %edx,0x4(%rax)
  st->ino = ip->inum;
ffff800000102eae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102eb2:	8b 50 04             	mov    0x4(%rax),%edx
ffff800000102eb5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102eb9:	89 50 08             	mov    %edx,0x8(%rax)
  st->type = ip->type;
ffff800000102ebc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102ec0:	0f b7 90 94 00 00 00 	movzwl 0x94(%rax),%edx
ffff800000102ec7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102ecb:	66 89 10             	mov    %dx,(%rax)
  st->nlink = ip->nlink;
ffff800000102ece:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102ed2:	0f b7 90 9a 00 00 00 	movzwl 0x9a(%rax),%edx
ffff800000102ed9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102edd:	66 89 50 0c          	mov    %dx,0xc(%rax)
  st->size = ip->size;
ffff800000102ee1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102ee5:	8b 90 9c 00 00 00    	mov    0x9c(%rax),%edx
ffff800000102eeb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102eef:	89 50 10             	mov    %edx,0x10(%rax)
}
ffff800000102ef2:	90                   	nop
ffff800000102ef3:	c9                   	leave
ffff800000102ef4:	c3                   	ret

ffff800000102ef5 <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
ffff800000102ef5:	55                   	push   %rbp
ffff800000102ef6:	48 89 e5             	mov    %rsp,%rbp
ffff800000102ef9:	48 83 ec 40          	sub    $0x40,%rsp
ffff800000102efd:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000102f01:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff800000102f05:	89 55 cc             	mov    %edx,-0x34(%rbp)
ffff800000102f08:	89 4d c8             	mov    %ecx,-0x38(%rbp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
ffff800000102f0b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102f0f:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000102f16:	66 83 f8 03          	cmp    $0x3,%ax
ffff800000102f1a:	0f 85 8d 00 00 00    	jne    ffff800000102fad <readi+0xb8>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
ffff800000102f20:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102f24:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff800000102f2b:	66 85 c0             	test   %ax,%ax
ffff800000102f2e:	78 38                	js     ffff800000102f68 <readi+0x73>
ffff800000102f30:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102f34:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff800000102f3b:	66 83 f8 09          	cmp    $0x9,%ax
ffff800000102f3f:	7f 27                	jg     ffff800000102f68 <readi+0x73>
ffff800000102f41:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102f45:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff800000102f4c:	98                   	cwtl
ffff800000102f4d:	48 ba 40 35 11 00 00 	movabs $0xffff800000113540,%rdx
ffff800000102f54:	80 ff ff 
ffff800000102f57:	48 98                	cltq
ffff800000102f59:	48 c1 e0 04          	shl    $0x4,%rax
ffff800000102f5d:	48 01 d0             	add    %rdx,%rax
ffff800000102f60:	48 8b 00             	mov    (%rax),%rax
ffff800000102f63:	48 85 c0             	test   %rax,%rax
ffff800000102f66:	75 0a                	jne    ffff800000102f72 <readi+0x7d>
      return -1;
ffff800000102f68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000102f6d:	e9 4e 01 00 00       	jmp    ffff8000001030c0 <readi+0x1cb>
    return devsw[ip->major].read(ip, off, dst, n);
ffff800000102f72:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102f76:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff800000102f7d:	98                   	cwtl
ffff800000102f7e:	48 ba 40 35 11 00 00 	movabs $0xffff800000113540,%rdx
ffff800000102f85:	80 ff ff 
ffff800000102f88:	48 98                	cltq
ffff800000102f8a:	48 c1 e0 04          	shl    $0x4,%rax
ffff800000102f8e:	48 01 d0             	add    %rdx,%rax
ffff800000102f91:	4c 8b 00             	mov    (%rax),%r8
ffff800000102f94:	8b 4d c8             	mov    -0x38(%rbp),%ecx
ffff800000102f97:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffff800000102f9b:	8b 75 cc             	mov    -0x34(%rbp),%esi
ffff800000102f9e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102fa2:	48 89 c7             	mov    %rax,%rdi
ffff800000102fa5:	41 ff d0             	call   *%r8
ffff800000102fa8:	e9 13 01 00 00       	jmp    ffff8000001030c0 <readi+0x1cb>
  }

  if(off > ip->size || off + n < off)
ffff800000102fad:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102fb1:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff800000102fb7:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffff800000102fba:	72 0d                	jb     ffff800000102fc9 <readi+0xd4>
ffff800000102fbc:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffff800000102fbf:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff800000102fc2:	01 d0                	add    %edx,%eax
ffff800000102fc4:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffff800000102fc7:	73 0a                	jae    ffff800000102fd3 <readi+0xde>
    return -1;
ffff800000102fc9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000102fce:	e9 ed 00 00 00       	jmp    ffff8000001030c0 <readi+0x1cb>
  if(off + n > ip->size)
ffff800000102fd3:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffff800000102fd6:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff800000102fd9:	01 c2                	add    %eax,%edx
ffff800000102fdb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102fdf:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff800000102fe5:	39 d0                	cmp    %edx,%eax
ffff800000102fe7:	73 10                	jae    ffff800000102ff9 <readi+0x104>
    n = ip->size - off;
ffff800000102fe9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102fed:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff800000102ff3:	2b 45 cc             	sub    -0x34(%rbp),%eax
ffff800000102ff6:	89 45 c8             	mov    %eax,-0x38(%rbp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
ffff800000102ff9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000103000:	e9 ac 00 00 00       	jmp    ffff8000001030b1 <readi+0x1bc>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
ffff800000103005:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff800000103008:	c1 e8 09             	shr    $0x9,%eax
ffff80000010300b:	89 c2                	mov    %eax,%edx
ffff80000010300d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103011:	89 d6                	mov    %edx,%esi
ffff800000103013:	48 89 c7             	mov    %rax,%rdi
ffff800000103016:	48 b8 be 2b 10 00 00 	movabs $0xffff800000102bbe,%rax
ffff80000010301d:	80 ff ff 
ffff800000103020:	ff d0                	call   *%rax
ffff800000103022:	89 c2                	mov    %eax,%edx
ffff800000103024:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103028:	8b 00                	mov    (%rax),%eax
ffff80000010302a:	89 d6                	mov    %edx,%esi
ffff80000010302c:	89 c7                	mov    %eax,%edi
ffff80000010302e:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000103035:	80 ff ff 
ffff800000103038:	ff d0                	call   *%rax
ffff80000010303a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    m = min(n - tot, BSIZE - off%BSIZE);
ffff80000010303e:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff800000103041:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff800000103046:	ba 00 02 00 00       	mov    $0x200,%edx
ffff80000010304b:	29 c2                	sub    %eax,%edx
ffff80000010304d:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff800000103050:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff800000103053:	39 c2                	cmp    %eax,%edx
ffff800000103055:	0f 46 c2             	cmovbe %edx,%eax
ffff800000103058:	89 45 ec             	mov    %eax,-0x14(%rbp)
    memmove(dst, bp->data + off%BSIZE, m);
ffff80000010305b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010305f:	48 8d 90 b0 00 00 00 	lea    0xb0(%rax),%rdx
ffff800000103066:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff800000103069:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010306e:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffff800000103072:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff800000103075:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000103079:	48 89 ce             	mov    %rcx,%rsi
ffff80000010307c:	48 89 c7             	mov    %rax,%rdi
ffff80000010307f:	48 b8 d3 7b 10 00 00 	movabs $0xffff800000107bd3,%rax
ffff800000103086:	80 ff ff 
ffff800000103089:	ff d0                	call   *%rax
    brelse(bp);
ffff80000010308b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010308f:	48 89 c7             	mov    %rax,%rdi
ffff800000103092:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000103099:	80 ff ff 
ffff80000010309c:	ff d0                	call   *%rax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
ffff80000010309e:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001030a1:	01 45 fc             	add    %eax,-0x4(%rbp)
ffff8000001030a4:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001030a7:	01 45 cc             	add    %eax,-0x34(%rbp)
ffff8000001030aa:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001030ad:	48 01 45 d0          	add    %rax,-0x30(%rbp)
ffff8000001030b1:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001030b4:	3b 45 c8             	cmp    -0x38(%rbp),%eax
ffff8000001030b7:	0f 82 48 ff ff ff    	jb     ffff800000103005 <readi+0x110>
  }
  return n;
ffff8000001030bd:	8b 45 c8             	mov    -0x38(%rbp),%eax
}
ffff8000001030c0:	c9                   	leave
ffff8000001030c1:	c3                   	ret

ffff8000001030c2 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
ffff8000001030c2:	55                   	push   %rbp
ffff8000001030c3:	48 89 e5             	mov    %rsp,%rbp
ffff8000001030c6:	48 83 ec 40          	sub    $0x40,%rsp
ffff8000001030ca:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff8000001030ce:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff8000001030d2:	89 55 cc             	mov    %edx,-0x34(%rbp)
ffff8000001030d5:	89 4d c8             	mov    %ecx,-0x38(%rbp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
ffff8000001030d8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001030dc:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff8000001030e3:	66 83 f8 03          	cmp    $0x3,%ax
ffff8000001030e7:	0f 85 95 00 00 00    	jne    ffff800000103182 <writei+0xc0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
ffff8000001030ed:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001030f1:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff8000001030f8:	66 85 c0             	test   %ax,%ax
ffff8000001030fb:	78 3c                	js     ffff800000103139 <writei+0x77>
ffff8000001030fd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103101:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff800000103108:	66 83 f8 09          	cmp    $0x9,%ax
ffff80000010310c:	7f 2b                	jg     ffff800000103139 <writei+0x77>
ffff80000010310e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103112:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff800000103119:	98                   	cwtl
ffff80000010311a:	48 ba 40 35 11 00 00 	movabs $0xffff800000113540,%rdx
ffff800000103121:	80 ff ff 
ffff800000103124:	48 98                	cltq
ffff800000103126:	48 c1 e0 04          	shl    $0x4,%rax
ffff80000010312a:	48 01 d0             	add    %rdx,%rax
ffff80000010312d:	48 83 c0 08          	add    $0x8,%rax
ffff800000103131:	48 8b 00             	mov    (%rax),%rax
ffff800000103134:	48 85 c0             	test   %rax,%rax
ffff800000103137:	75 0a                	jne    ffff800000103143 <writei+0x81>
      return -1;
ffff800000103139:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010313e:	e9 8d 01 00 00       	jmp    ffff8000001032d0 <writei+0x20e>
    return devsw[ip->major].write(ip, off, src, n);
ffff800000103143:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103147:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff80000010314e:	98                   	cwtl
ffff80000010314f:	48 ba 40 35 11 00 00 	movabs $0xffff800000113540,%rdx
ffff800000103156:	80 ff ff 
ffff800000103159:	48 98                	cltq
ffff80000010315b:	48 c1 e0 04          	shl    $0x4,%rax
ffff80000010315f:	48 01 d0             	add    %rdx,%rax
ffff800000103162:	48 83 c0 08          	add    $0x8,%rax
ffff800000103166:	4c 8b 00             	mov    (%rax),%r8
ffff800000103169:	8b 4d c8             	mov    -0x38(%rbp),%ecx
ffff80000010316c:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffff800000103170:	8b 75 cc             	mov    -0x34(%rbp),%esi
ffff800000103173:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103177:	48 89 c7             	mov    %rax,%rdi
ffff80000010317a:	41 ff d0             	call   *%r8
ffff80000010317d:	e9 4e 01 00 00       	jmp    ffff8000001032d0 <writei+0x20e>
  }

  if(off > ip->size || off + n < off)
ffff800000103182:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103186:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff80000010318c:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffff80000010318f:	72 0d                	jb     ffff80000010319e <writei+0xdc>
ffff800000103191:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffff800000103194:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff800000103197:	01 d0                	add    %edx,%eax
ffff800000103199:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffff80000010319c:	73 0a                	jae    ffff8000001031a8 <writei+0xe6>
    return -1;
ffff80000010319e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001031a3:	e9 28 01 00 00       	jmp    ffff8000001032d0 <writei+0x20e>
  if(off + n > MAXFILE*BSIZE)
ffff8000001031a8:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffff8000001031ab:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff8000001031ae:	01 d0                	add    %edx,%eax
ffff8000001031b0:	3d 00 18 01 00       	cmp    $0x11800,%eax
ffff8000001031b5:	76 0a                	jbe    ffff8000001031c1 <writei+0xff>
    return -1;
ffff8000001031b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001031bc:	e9 0f 01 00 00       	jmp    ffff8000001032d0 <writei+0x20e>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
ffff8000001031c1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001031c8:	e9 bf 00 00 00       	jmp    ffff80000010328c <writei+0x1ca>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
ffff8000001031cd:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff8000001031d0:	c1 e8 09             	shr    $0x9,%eax
ffff8000001031d3:	89 c2                	mov    %eax,%edx
ffff8000001031d5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001031d9:	89 d6                	mov    %edx,%esi
ffff8000001031db:	48 89 c7             	mov    %rax,%rdi
ffff8000001031de:	48 b8 be 2b 10 00 00 	movabs $0xffff800000102bbe,%rax
ffff8000001031e5:	80 ff ff 
ffff8000001031e8:	ff d0                	call   *%rax
ffff8000001031ea:	89 c2                	mov    %eax,%edx
ffff8000001031ec:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001031f0:	8b 00                	mov    (%rax),%eax
ffff8000001031f2:	89 d6                	mov    %edx,%esi
ffff8000001031f4:	89 c7                	mov    %eax,%edi
ffff8000001031f6:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff8000001031fd:	80 ff ff 
ffff800000103200:	ff d0                	call   *%rax
ffff800000103202:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    m = min(n - tot, BSIZE - off%BSIZE);
ffff800000103206:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff800000103209:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010320e:	ba 00 02 00 00       	mov    $0x200,%edx
ffff800000103213:	29 c2                	sub    %eax,%edx
ffff800000103215:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff800000103218:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff80000010321b:	39 c2                	cmp    %eax,%edx
ffff80000010321d:	0f 46 c2             	cmovbe %edx,%eax
ffff800000103220:	89 45 ec             	mov    %eax,-0x14(%rbp)
    memmove(bp->data + off%BSIZE, src, m);
ffff800000103223:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000103227:	48 8d 90 b0 00 00 00 	lea    0xb0(%rax),%rdx
ffff80000010322e:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff800000103231:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff800000103236:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffff80000010323a:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff80000010323d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000103241:	48 89 c6             	mov    %rax,%rsi
ffff800000103244:	48 89 cf             	mov    %rcx,%rdi
ffff800000103247:	48 b8 d3 7b 10 00 00 	movabs $0xffff800000107bd3,%rax
ffff80000010324e:	80 ff ff 
ffff800000103251:	ff d0                	call   *%rax
    log_write(bp);
ffff800000103253:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000103257:	48 89 c7             	mov    %rax,%rdi
ffff80000010325a:	48 b8 45 52 10 00 00 	movabs $0xffff800000105245,%rax
ffff800000103261:	80 ff ff 
ffff800000103264:	ff d0                	call   *%rax
    brelse(bp);
ffff800000103266:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010326a:	48 89 c7             	mov    %rax,%rdi
ffff80000010326d:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000103274:	80 ff ff 
ffff800000103277:	ff d0                	call   *%rax
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
ffff800000103279:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff80000010327c:	01 45 fc             	add    %eax,-0x4(%rbp)
ffff80000010327f:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000103282:	01 45 cc             	add    %eax,-0x34(%rbp)
ffff800000103285:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000103288:	48 01 45 d0          	add    %rax,-0x30(%rbp)
ffff80000010328c:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010328f:	3b 45 c8             	cmp    -0x38(%rbp),%eax
ffff800000103292:	0f 82 35 ff ff ff    	jb     ffff8000001031cd <writei+0x10b>
  }

  if(n > 0 && off > ip->size){
ffff800000103298:	83 7d c8 00          	cmpl   $0x0,-0x38(%rbp)
ffff80000010329c:	74 2f                	je     ffff8000001032cd <writei+0x20b>
ffff80000010329e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001032a2:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff8000001032a8:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffff8000001032ab:	73 20                	jae    ffff8000001032cd <writei+0x20b>
    ip->size = off;
ffff8000001032ad:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001032b1:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffff8000001032b4:	89 90 9c 00 00 00    	mov    %edx,0x9c(%rax)
    iupdate(ip);
ffff8000001032ba:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001032be:	48 89 c7             	mov    %rax,%rdi
ffff8000001032c1:	48 b8 e8 25 10 00 00 	movabs $0xffff8000001025e8,%rax
ffff8000001032c8:	80 ff ff 
ffff8000001032cb:	ff d0                	call   *%rax
  }
  return n;
ffff8000001032cd:	8b 45 c8             	mov    -0x38(%rbp),%eax
}
ffff8000001032d0:	c9                   	leave
ffff8000001032d1:	c3                   	ret

ffff8000001032d2 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
ffff8000001032d2:	55                   	push   %rbp
ffff8000001032d3:	48 89 e5             	mov    %rsp,%rbp
ffff8000001032d6:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001032da:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff8000001032de:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  return strncmp(s, t, DIRSIZ);
ffff8000001032e2:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffff8000001032e6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001032ea:	ba 0e 00 00 00       	mov    $0xe,%edx
ffff8000001032ef:	48 89 ce             	mov    %rcx,%rsi
ffff8000001032f2:	48 89 c7             	mov    %rax,%rdi
ffff8000001032f5:	48 b8 a8 7c 10 00 00 	movabs $0xffff800000107ca8,%rax
ffff8000001032fc:	80 ff ff 
ffff8000001032ff:	ff d0                	call   *%rax
}
ffff800000103301:	c9                   	leave
ffff800000103302:	c3                   	ret

ffff800000103303 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
ffff800000103303:	55                   	push   %rbp
ffff800000103304:	48 89 e5             	mov    %rsp,%rbp
ffff800000103307:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010330b:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010330f:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff800000103313:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
ffff800000103317:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010331b:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000103322:	66 83 f8 01          	cmp    $0x1,%ax
ffff800000103326:	74 19                	je     ffff800000103341 <dirlookup+0x3e>
    panic("dirlookup not DIR");
ffff800000103328:	48 b8 7d c1 10 00 00 	movabs $0xffff80000010c17d,%rax
ffff80000010332f:	80 ff ff 
ffff800000103332:	48 89 c7             	mov    %rax,%rdi
ffff800000103335:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010333c:	80 ff ff 
ffff80000010333f:	ff d0                	call   *%rax

  for(off = 0; off < dp->size; off += sizeof(de)){
ffff800000103341:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000103348:	e9 a2 00 00 00       	jmp    ffff8000001033ef <dirlookup+0xec>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffff80000010334d:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000103350:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffff800000103354:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103358:	b9 10 00 00 00       	mov    $0x10,%ecx
ffff80000010335d:	48 89 c7             	mov    %rax,%rdi
ffff800000103360:	48 b8 f5 2e 10 00 00 	movabs $0xffff800000102ef5,%rax
ffff800000103367:	80 ff ff 
ffff80000010336a:	ff d0                	call   *%rax
ffff80000010336c:	83 f8 10             	cmp    $0x10,%eax
ffff80000010336f:	74 19                	je     ffff80000010338a <dirlookup+0x87>
      panic("dirlookup read");
ffff800000103371:	48 b8 8f c1 10 00 00 	movabs $0xffff80000010c18f,%rax
ffff800000103378:	80 ff ff 
ffff80000010337b:	48 89 c7             	mov    %rax,%rdi
ffff80000010337e:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000103385:	80 ff ff 
ffff800000103388:	ff d0                	call   *%rax
    if(de.inum == 0)
ffff80000010338a:	0f b7 45 e0          	movzwl -0x20(%rbp),%eax
ffff80000010338e:	66 85 c0             	test   %ax,%ax
ffff800000103391:	74 57                	je     ffff8000001033ea <dirlookup+0xe7>
      continue;
    if(namecmp(name, de.name) == 0){
ffff800000103393:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff800000103397:	48 8d 50 02          	lea    0x2(%rax),%rdx
ffff80000010339b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010339f:	48 89 d6             	mov    %rdx,%rsi
ffff8000001033a2:	48 89 c7             	mov    %rax,%rdi
ffff8000001033a5:	48 b8 d2 32 10 00 00 	movabs $0xffff8000001032d2,%rax
ffff8000001033ac:	80 ff ff 
ffff8000001033af:	ff d0                	call   *%rax
ffff8000001033b1:	85 c0                	test   %eax,%eax
ffff8000001033b3:	75 36                	jne    ffff8000001033eb <dirlookup+0xe8>
      // entry matches path element
      if(poff)
ffff8000001033b5:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
ffff8000001033ba:	74 09                	je     ffff8000001033c5 <dirlookup+0xc2>
        *poff = off;
ffff8000001033bc:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff8000001033c0:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001033c3:	89 10                	mov    %edx,(%rax)
      inum = de.inum;
ffff8000001033c5:	0f b7 45 e0          	movzwl -0x20(%rbp),%eax
ffff8000001033c9:	0f b7 c0             	movzwl %ax,%eax
ffff8000001033cc:	89 45 f8             	mov    %eax,-0x8(%rbp)
      return iget(dp->dev, inum);
ffff8000001033cf:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001033d3:	8b 00                	mov    (%rax),%eax
ffff8000001033d5:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffff8000001033d8:	89 d6                	mov    %edx,%esi
ffff8000001033da:	89 c7                	mov    %eax,%edi
ffff8000001033dc:	48 b8 fa 26 10 00 00 	movabs $0xffff8000001026fa,%rax
ffff8000001033e3:	80 ff ff 
ffff8000001033e6:	ff d0                	call   *%rax
ffff8000001033e8:	eb 1d                	jmp    ffff800000103407 <dirlookup+0x104>
      continue;
ffff8000001033ea:	90                   	nop
  for(off = 0; off < dp->size; off += sizeof(de)){
ffff8000001033eb:	83 45 fc 10          	addl   $0x10,-0x4(%rbp)
ffff8000001033ef:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001033f3:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff8000001033f9:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff8000001033fc:	0f 82 4b ff ff ff    	jb     ffff80000010334d <dirlookup+0x4a>
    }
  }

  return 0;
ffff800000103402:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000103407:	c9                   	leave
ffff800000103408:	c3                   	ret

ffff800000103409 <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
ffff800000103409:	55                   	push   %rbp
ffff80000010340a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010340d:	48 83 ec 40          	sub    $0x40,%rsp
ffff800000103411:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000103415:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff800000103419:	89 55 cc             	mov    %edx,-0x34(%rbp)
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
ffff80000010341c:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
ffff800000103420:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103424:	ba 00 00 00 00       	mov    $0x0,%edx
ffff800000103429:	48 89 ce             	mov    %rcx,%rsi
ffff80000010342c:	48 89 c7             	mov    %rax,%rdi
ffff80000010342f:	48 b8 03 33 10 00 00 	movabs $0xffff800000103303,%rax
ffff800000103436:	80 ff ff 
ffff800000103439:	ff d0                	call   *%rax
ffff80000010343b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010343f:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000103444:	74 1d                	je     ffff800000103463 <dirlink+0x5a>
    iput(ip);
ffff800000103446:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010344a:	48 89 c7             	mov    %rax,%rdi
ffff80000010344d:	48 b8 8f 2a 10 00 00 	movabs $0xffff800000102a8f,%rax
ffff800000103454:	80 ff ff 
ffff800000103457:	ff d0                	call   *%rax
    return -1;
ffff800000103459:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010345e:	e9 d8 00 00 00       	jmp    ffff80000010353b <dirlink+0x132>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
ffff800000103463:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010346a:	eb 4f                	jmp    ffff8000001034bb <dirlink+0xb2>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffff80000010346c:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010346f:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffff800000103473:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103477:	b9 10 00 00 00       	mov    $0x10,%ecx
ffff80000010347c:	48 89 c7             	mov    %rax,%rdi
ffff80000010347f:	48 b8 f5 2e 10 00 00 	movabs $0xffff800000102ef5,%rax
ffff800000103486:	80 ff ff 
ffff800000103489:	ff d0                	call   *%rax
ffff80000010348b:	83 f8 10             	cmp    $0x10,%eax
ffff80000010348e:	74 19                	je     ffff8000001034a9 <dirlink+0xa0>
      panic("dirlink read");
ffff800000103490:	48 b8 9e c1 10 00 00 	movabs $0xffff80000010c19e,%rax
ffff800000103497:	80 ff ff 
ffff80000010349a:	48 89 c7             	mov    %rax,%rdi
ffff80000010349d:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001034a4:	80 ff ff 
ffff8000001034a7:	ff d0                	call   *%rax
    if(de.inum == 0)
ffff8000001034a9:	0f b7 45 e0          	movzwl -0x20(%rbp),%eax
ffff8000001034ad:	66 85 c0             	test   %ax,%ax
ffff8000001034b0:	74 1c                	je     ffff8000001034ce <dirlink+0xc5>
  for(off = 0; off < dp->size; off += sizeof(de)){
ffff8000001034b2:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001034b5:	83 c0 10             	add    $0x10,%eax
ffff8000001034b8:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff8000001034bb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001034bf:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff8000001034c5:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001034c8:	39 c2                	cmp    %eax,%edx
ffff8000001034ca:	72 a0                	jb     ffff80000010346c <dirlink+0x63>
ffff8000001034cc:	eb 01                	jmp    ffff8000001034cf <dirlink+0xc6>
      break;
ffff8000001034ce:	90                   	nop
  }

  strncpy(de.name, name, DIRSIZ);
ffff8000001034cf:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff8000001034d3:	48 8d 55 e0          	lea    -0x20(%rbp),%rdx
ffff8000001034d7:	48 8d 4a 02          	lea    0x2(%rdx),%rcx
ffff8000001034db:	ba 0e 00 00 00       	mov    $0xe,%edx
ffff8000001034e0:	48 89 c6             	mov    %rax,%rsi
ffff8000001034e3:	48 89 cf             	mov    %rcx,%rdi
ffff8000001034e6:	48 b8 15 7d 10 00 00 	movabs $0xffff800000107d15,%rax
ffff8000001034ed:	80 ff ff 
ffff8000001034f0:	ff d0                	call   *%rax
  de.inum = inum;
ffff8000001034f2:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff8000001034f5:	66 89 45 e0          	mov    %ax,-0x20(%rbp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffff8000001034f9:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001034fc:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffff800000103500:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103504:	b9 10 00 00 00       	mov    $0x10,%ecx
ffff800000103509:	48 89 c7             	mov    %rax,%rdi
ffff80000010350c:	48 b8 c2 30 10 00 00 	movabs $0xffff8000001030c2,%rax
ffff800000103513:	80 ff ff 
ffff800000103516:	ff d0                	call   *%rax
ffff800000103518:	83 f8 10             	cmp    $0x10,%eax
ffff80000010351b:	74 19                	je     ffff800000103536 <dirlink+0x12d>
    panic("dirlink");
ffff80000010351d:	48 b8 ab c1 10 00 00 	movabs $0xffff80000010c1ab,%rax
ffff800000103524:	80 ff ff 
ffff800000103527:	48 89 c7             	mov    %rax,%rdi
ffff80000010352a:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000103531:	80 ff ff 
ffff800000103534:	ff d0                	call   *%rax

  return 0;
ffff800000103536:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010353b:	c9                   	leave
ffff80000010353c:	c3                   	ret

ffff80000010353d <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
ffff80000010353d:	55                   	push   %rbp
ffff80000010353e:	48 89 e5             	mov    %rsp,%rbp
ffff800000103541:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000103545:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000103549:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *s;
  int len;

  while(*path == '/')
ffff80000010354d:	eb 05                	jmp    ffff800000103554 <skipelem+0x17>
    path++;
ffff80000010354f:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  while(*path == '/')
ffff800000103554:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103558:	0f b6 00             	movzbl (%rax),%eax
ffff80000010355b:	3c 2f                	cmp    $0x2f,%al
ffff80000010355d:	74 f0                	je     ffff80000010354f <skipelem+0x12>
  if(*path == 0)
ffff80000010355f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103563:	0f b6 00             	movzbl (%rax),%eax
ffff800000103566:	84 c0                	test   %al,%al
ffff800000103568:	75 0a                	jne    ffff800000103574 <skipelem+0x37>
    return 0;
ffff80000010356a:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010356f:	e9 9a 00 00 00       	jmp    ffff80000010360e <skipelem+0xd1>
  s = path;
ffff800000103574:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103578:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while(*path != '/' && *path != 0)
ffff80000010357c:	eb 05                	jmp    ffff800000103583 <skipelem+0x46>
    path++;
ffff80000010357e:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  while(*path != '/' && *path != 0)
ffff800000103583:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103587:	0f b6 00             	movzbl (%rax),%eax
ffff80000010358a:	3c 2f                	cmp    $0x2f,%al
ffff80000010358c:	74 0b                	je     ffff800000103599 <skipelem+0x5c>
ffff80000010358e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103592:	0f b6 00             	movzbl (%rax),%eax
ffff800000103595:	84 c0                	test   %al,%al
ffff800000103597:	75 e5                	jne    ffff80000010357e <skipelem+0x41>
  len = path - s;
ffff800000103599:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010359d:	48 2b 45 f8          	sub    -0x8(%rbp),%rax
ffff8000001035a1:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(len >= DIRSIZ)
ffff8000001035a4:	83 7d f4 0d          	cmpl   $0xd,-0xc(%rbp)
ffff8000001035a8:	7e 21                	jle    ffff8000001035cb <skipelem+0x8e>
    memmove(name, s, DIRSIZ);
ffff8000001035aa:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff8000001035ae:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001035b2:	ba 0e 00 00 00       	mov    $0xe,%edx
ffff8000001035b7:	48 89 ce             	mov    %rcx,%rsi
ffff8000001035ba:	48 89 c7             	mov    %rax,%rdi
ffff8000001035bd:	48 b8 d3 7b 10 00 00 	movabs $0xffff800000107bd3,%rax
ffff8000001035c4:	80 ff ff 
ffff8000001035c7:	ff d0                	call   *%rax
ffff8000001035c9:	eb 34                	jmp    ffff8000001035ff <skipelem+0xc2>
  else {
    memmove(name, s, len);
ffff8000001035cb:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff8000001035ce:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff8000001035d2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001035d6:	48 89 ce             	mov    %rcx,%rsi
ffff8000001035d9:	48 89 c7             	mov    %rax,%rdi
ffff8000001035dc:	48 b8 d3 7b 10 00 00 	movabs $0xffff800000107bd3,%rax
ffff8000001035e3:	80 ff ff 
ffff8000001035e6:	ff d0                	call   *%rax
    name[len] = 0;
ffff8000001035e8:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff8000001035eb:	48 63 d0             	movslq %eax,%rdx
ffff8000001035ee:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001035f2:	48 01 d0             	add    %rdx,%rax
ffff8000001035f5:	c6 00 00             	movb   $0x0,(%rax)
  }
  while(*path == '/')
ffff8000001035f8:	eb 05                	jmp    ffff8000001035ff <skipelem+0xc2>
    path++;
ffff8000001035fa:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  while(*path == '/')
ffff8000001035ff:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103603:	0f b6 00             	movzbl (%rax),%eax
ffff800000103606:	3c 2f                	cmp    $0x2f,%al
ffff800000103608:	74 f0                	je     ffff8000001035fa <skipelem+0xbd>
  return path;
ffff80000010360a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
ffff80000010360e:	c9                   	leave
ffff80000010360f:	c3                   	ret

ffff800000103610 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
ffff800000103610:	55                   	push   %rbp
ffff800000103611:	48 89 e5             	mov    %rsp,%rbp
ffff800000103614:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000103618:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010361c:	89 75 e4             	mov    %esi,-0x1c(%rbp)
ffff80000010361f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  struct inode *ip, *next;

  if(*path == '/')
ffff800000103623:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103627:	0f b6 00             	movzbl (%rax),%eax
ffff80000010362a:	3c 2f                	cmp    $0x2f,%al
ffff80000010362c:	75 1f                	jne    ffff80000010364d <namex+0x3d>
    ip = iget(ROOTDEV, ROOTINO);
ffff80000010362e:	be 01 00 00 00       	mov    $0x1,%esi
ffff800000103633:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000103638:	48 b8 fa 26 10 00 00 	movabs $0xffff8000001026fa,%rax
ffff80000010363f:	80 ff ff 
ffff800000103642:	ff d0                	call   *%rax
ffff800000103644:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000103648:	e9 f7 00 00 00       	jmp    ffff800000103744 <namex+0x134>
  else
    ip = idup(proc->cwd);
ffff80000010364d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000103654:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000103658:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffff80000010365f:	48 89 c7             	mov    %rax,%rdi
ffff800000103662:	48 b8 37 28 10 00 00 	movabs $0xffff800000102837,%rax
ffff800000103669:	80 ff ff 
ffff80000010366c:	ff d0                	call   *%rax
ffff80000010366e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  while((path = skipelem(path, name)) != 0){
ffff800000103672:	e9 cd 00 00 00       	jmp    ffff800000103744 <namex+0x134>
    ilock(ip);
ffff800000103677:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010367b:	48 89 c7             	mov    %rax,%rdi
ffff80000010367e:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff800000103685:	80 ff ff 
ffff800000103688:	ff d0                	call   *%rax
    if(ip->type != T_DIR){
ffff80000010368a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010368e:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000103695:	66 83 f8 01          	cmp    $0x1,%ax
ffff800000103699:	74 1d                	je     ffff8000001036b8 <namex+0xa8>
      iunlockput(ip);
ffff80000010369b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010369f:	48 89 c7             	mov    %rax,%rdi
ffff8000001036a2:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff8000001036a9:	80 ff ff 
ffff8000001036ac:	ff d0                	call   *%rax
      return 0;
ffff8000001036ae:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001036b3:	e9 d9 00 00 00       	jmp    ffff800000103791 <namex+0x181>
    }
    if(nameiparent && *path == '\0'){
ffff8000001036b8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
ffff8000001036bc:	74 27                	je     ffff8000001036e5 <namex+0xd5>
ffff8000001036be:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001036c2:	0f b6 00             	movzbl (%rax),%eax
ffff8000001036c5:	84 c0                	test   %al,%al
ffff8000001036c7:	75 1c                	jne    ffff8000001036e5 <namex+0xd5>
      iunlock(ip);  // Stop one level early.
ffff8000001036c9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001036cd:	48 89 c7             	mov    %rax,%rdi
ffff8000001036d0:	48 b8 23 2a 10 00 00 	movabs $0xffff800000102a23,%rax
ffff8000001036d7:	80 ff ff 
ffff8000001036da:	ff d0                	call   *%rax
      return ip;
ffff8000001036dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001036e0:	e9 ac 00 00 00       	jmp    ffff800000103791 <namex+0x181>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
ffff8000001036e5:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff8000001036e9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001036ed:	ba 00 00 00 00       	mov    $0x0,%edx
ffff8000001036f2:	48 89 ce             	mov    %rcx,%rsi
ffff8000001036f5:	48 89 c7             	mov    %rax,%rdi
ffff8000001036f8:	48 b8 03 33 10 00 00 	movabs $0xffff800000103303,%rax
ffff8000001036ff:	80 ff ff 
ffff800000103702:	ff d0                	call   *%rax
ffff800000103704:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000103708:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010370d:	75 1a                	jne    ffff800000103729 <namex+0x119>
      iunlockput(ip);
ffff80000010370f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103713:	48 89 c7             	mov    %rax,%rdi
ffff800000103716:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff80000010371d:	80 ff ff 
ffff800000103720:	ff d0                	call   *%rax
      return 0;
ffff800000103722:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000103727:	eb 68                	jmp    ffff800000103791 <namex+0x181>
    }
    iunlockput(ip);
ffff800000103729:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010372d:	48 89 c7             	mov    %rax,%rdi
ffff800000103730:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000103737:	80 ff ff 
ffff80000010373a:	ff d0                	call   *%rax
    ip = next;
ffff80000010373c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000103740:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((path = skipelem(path, name)) != 0){
ffff800000103744:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff800000103748:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010374c:	48 89 d6             	mov    %rdx,%rsi
ffff80000010374f:	48 89 c7             	mov    %rax,%rdi
ffff800000103752:	48 b8 3d 35 10 00 00 	movabs $0xffff80000010353d,%rax
ffff800000103759:	80 ff ff 
ffff80000010375c:	ff d0                	call   *%rax
ffff80000010375e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000103762:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff800000103767:	0f 85 0a ff ff ff    	jne    ffff800000103677 <namex+0x67>
  }
  if(nameiparent){
ffff80000010376d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
ffff800000103771:	74 1a                	je     ffff80000010378d <namex+0x17d>
    iput(ip);
ffff800000103773:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103777:	48 89 c7             	mov    %rax,%rdi
ffff80000010377a:	48 b8 8f 2a 10 00 00 	movabs $0xffff800000102a8f,%rax
ffff800000103781:	80 ff ff 
ffff800000103784:	ff d0                	call   *%rax
    return 0;
ffff800000103786:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010378b:	eb 04                	jmp    ffff800000103791 <namex+0x181>
  }
  return ip;
ffff80000010378d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000103791:	c9                   	leave
ffff800000103792:	c3                   	ret

ffff800000103793 <namei>:

struct inode*
namei(char *path)
{
ffff800000103793:	55                   	push   %rbp
ffff800000103794:	48 89 e5             	mov    %rsp,%rbp
ffff800000103797:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010379b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  char name[DIRSIZ];
  return namex(path, 0, name);
ffff80000010379f:	48 8d 55 f2          	lea    -0xe(%rbp),%rdx
ffff8000001037a3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001037a7:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001037ac:	48 89 c7             	mov    %rax,%rdi
ffff8000001037af:	48 b8 10 36 10 00 00 	movabs $0xffff800000103610,%rax
ffff8000001037b6:	80 ff ff 
ffff8000001037b9:	ff d0                	call   *%rax
}
ffff8000001037bb:	c9                   	leave
ffff8000001037bc:	c3                   	ret

ffff8000001037bd <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
ffff8000001037bd:	55                   	push   %rbp
ffff8000001037be:	48 89 e5             	mov    %rsp,%rbp
ffff8000001037c1:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001037c5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff8000001037c9:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  return namex(path, 1, name);
ffff8000001037cd:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff8000001037d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001037d5:	be 01 00 00 00       	mov    $0x1,%esi
ffff8000001037da:	48 89 c7             	mov    %rax,%rdi
ffff8000001037dd:	48 b8 10 36 10 00 00 	movabs $0xffff800000103610,%rax
ffff8000001037e4:	80 ff ff 
ffff8000001037e7:	ff d0                	call   *%rax
}
ffff8000001037e9:	c9                   	leave
ffff8000001037ea:	c3                   	ret

ffff8000001037eb <inb>:
{
ffff8000001037eb:	55                   	push   %rbp
ffff8000001037ec:	48 89 e5             	mov    %rsp,%rbp
ffff8000001037ef:	48 83 ec 18          	sub    $0x18,%rsp
ffff8000001037f3:	89 f8                	mov    %edi,%eax
ffff8000001037f5:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
ffff8000001037f9:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff8000001037fd:	89 c2                	mov    %eax,%edx
ffff8000001037ff:	ec                   	in     (%dx),%al
ffff800000103800:	88 45 ff             	mov    %al,-0x1(%rbp)
  return data;
ffff800000103803:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
}
ffff800000103807:	c9                   	leave
ffff800000103808:	c3                   	ret

ffff800000103809 <insl>:
{
ffff800000103809:	55                   	push   %rbp
ffff80000010380a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010380d:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000103811:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff800000103814:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff800000103818:	89 55 f8             	mov    %edx,-0x8(%rbp)
  asm volatile("cld; rep insl" :
ffff80000010381b:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010381e:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffff800000103822:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000103825:	48 89 ce             	mov    %rcx,%rsi
ffff800000103828:	48 89 f7             	mov    %rsi,%rdi
ffff80000010382b:	89 c1                	mov    %eax,%ecx
ffff80000010382d:	fc                   	cld
ffff80000010382e:	f3 6d                	rep insl (%dx),(%rdi)
ffff800000103830:	89 c8                	mov    %ecx,%eax
ffff800000103832:	48 89 fe             	mov    %rdi,%rsi
ffff800000103835:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff800000103839:	89 45 f8             	mov    %eax,-0x8(%rbp)
}
ffff80000010383c:	90                   	nop
ffff80000010383d:	c9                   	leave
ffff80000010383e:	c3                   	ret

ffff80000010383f <outb>:
{
ffff80000010383f:	55                   	push   %rbp
ffff800000103840:	48 89 e5             	mov    %rsp,%rbp
ffff800000103843:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000103847:	89 fa                	mov    %edi,%edx
ffff800000103849:	89 f0                	mov    %esi,%eax
ffff80000010384b:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffff80000010384f:	88 45 f8             	mov    %al,-0x8(%rbp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
ffff800000103852:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffff800000103856:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffff80000010385a:	ee                   	out    %al,(%dx)
}
ffff80000010385b:	90                   	nop
ffff80000010385c:	c9                   	leave
ffff80000010385d:	c3                   	ret

ffff80000010385e <outsl>:
{
ffff80000010385e:	55                   	push   %rbp
ffff80000010385f:	48 89 e5             	mov    %rsp,%rbp
ffff800000103862:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000103866:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff800000103869:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff80000010386d:	89 55 f8             	mov    %edx,-0x8(%rbp)
  asm volatile("cld; rep outsl" :
ffff800000103870:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000103873:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffff800000103877:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff80000010387a:	48 89 ce             	mov    %rcx,%rsi
ffff80000010387d:	89 c1                	mov    %eax,%ecx
ffff80000010387f:	fc                   	cld
ffff800000103880:	f3 6f                	rep outsl (%rsi),(%dx)
ffff800000103882:	89 c8                	mov    %ecx,%eax
ffff800000103884:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff800000103888:	89 45 f8             	mov    %eax,-0x8(%rbp)
}
ffff80000010388b:	90                   	nop
ffff80000010388c:	c9                   	leave
ffff80000010388d:	c3                   	ret

ffff80000010388e <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
ffff80000010388e:	55                   	push   %rbp
ffff80000010388f:	48 89 e5             	mov    %rsp,%rbp
ffff800000103892:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000103896:	89 7d ec             	mov    %edi,-0x14(%rbp)
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
ffff800000103899:	90                   	nop
ffff80000010389a:	bf f7 01 00 00       	mov    $0x1f7,%edi
ffff80000010389f:	48 b8 eb 37 10 00 00 	movabs $0xffff8000001037eb,%rax
ffff8000001038a6:	80 ff ff 
ffff8000001038a9:	ff d0                	call   *%rax
ffff8000001038ab:	0f b6 c0             	movzbl %al,%eax
ffff8000001038ae:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff8000001038b1:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001038b4:	25 c0 00 00 00       	and    $0xc0,%eax
ffff8000001038b9:	83 f8 40             	cmp    $0x40,%eax
ffff8000001038bc:	75 dc                	jne    ffff80000010389a <idewait+0xc>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
ffff8000001038be:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffff8000001038c2:	74 11                	je     ffff8000001038d5 <idewait+0x47>
ffff8000001038c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001038c7:	83 e0 21             	and    $0x21,%eax
ffff8000001038ca:	85 c0                	test   %eax,%eax
ffff8000001038cc:	74 07                	je     ffff8000001038d5 <idewait+0x47>
    return -1;
ffff8000001038ce:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001038d3:	eb 05                	jmp    ffff8000001038da <idewait+0x4c>
  return 0;
ffff8000001038d5:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff8000001038da:	c9                   	leave
ffff8000001038db:	c3                   	ret

ffff8000001038dc <ideinit>:

void
ideinit(void)
{
ffff8000001038dc:	55                   	push   %rbp
ffff8000001038dd:	48 89 e5             	mov    %rsp,%rbp
ffff8000001038e0:	48 83 ec 10          	sub    $0x10,%rsp
  initlock(&idelock, "ide");
ffff8000001038e4:	48 ba b3 c1 10 00 00 	movabs $0xffff80000010c1b3,%rdx
ffff8000001038eb:	80 ff ff 
ffff8000001038ee:	48 b8 c0 70 11 00 00 	movabs $0xffff8000001170c0,%rax
ffff8000001038f5:	80 ff ff 
ffff8000001038f8:	48 89 d6             	mov    %rdx,%rsi
ffff8000001038fb:	48 89 c7             	mov    %rax,%rdi
ffff8000001038fe:	48 b8 05 77 10 00 00 	movabs $0xffff800000107705,%rax
ffff800000103905:	80 ff ff 
ffff800000103908:	ff d0                	call   *%rax
  ioapicenable(IRQ_IDE, ncpu - 1);
ffff80000010390a:	48 b8 20 74 11 00 00 	movabs $0xffff800000117420,%rax
ffff800000103911:	80 ff ff 
ffff800000103914:	8b 00                	mov    (%rax),%eax
ffff800000103916:	83 e8 01             	sub    $0x1,%eax
ffff800000103919:	89 c6                	mov    %eax,%esi
ffff80000010391b:	bf 0e 00 00 00       	mov    $0xe,%edi
ffff800000103920:	48 b8 6e 3f 10 00 00 	movabs $0xffff800000103f6e,%rax
ffff800000103927:	80 ff ff 
ffff80000010392a:	ff d0                	call   *%rax
  idewait(0);
ffff80000010392c:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000103931:	48 b8 8e 38 10 00 00 	movabs $0xffff80000010388e,%rax
ffff800000103938:	80 ff ff 
ffff80000010393b:	ff d0                	call   *%rax

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
ffff80000010393d:	be f0 00 00 00       	mov    $0xf0,%esi
ffff800000103942:	bf f6 01 00 00       	mov    $0x1f6,%edi
ffff800000103947:	48 b8 3f 38 10 00 00 	movabs $0xffff80000010383f,%rax
ffff80000010394e:	80 ff ff 
ffff800000103951:	ff d0                	call   *%rax
  for(int i=0; i<1000; i++){
ffff800000103953:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010395a:	eb 2b                	jmp    ffff800000103987 <ideinit+0xab>
    if(inb(0x1f7) != 0){
ffff80000010395c:	bf f7 01 00 00       	mov    $0x1f7,%edi
ffff800000103961:	48 b8 eb 37 10 00 00 	movabs $0xffff8000001037eb,%rax
ffff800000103968:	80 ff ff 
ffff80000010396b:	ff d0                	call   *%rax
ffff80000010396d:	84 c0                	test   %al,%al
ffff80000010396f:	74 12                	je     ffff800000103983 <ideinit+0xa7>
      havedisk1 = 1;
ffff800000103971:	48 b8 30 71 11 00 00 	movabs $0xffff800000117130,%rax
ffff800000103978:	80 ff ff 
ffff80000010397b:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
      break;
ffff800000103981:	eb 0d                	jmp    ffff800000103990 <ideinit+0xb4>
  for(int i=0; i<1000; i++){
ffff800000103983:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000103987:	81 7d fc e7 03 00 00 	cmpl   $0x3e7,-0x4(%rbp)
ffff80000010398e:	7e cc                	jle    ffff80000010395c <ideinit+0x80>
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
ffff800000103990:	be e0 00 00 00       	mov    $0xe0,%esi
ffff800000103995:	bf f6 01 00 00       	mov    $0x1f6,%edi
ffff80000010399a:	48 b8 3f 38 10 00 00 	movabs $0xffff80000010383f,%rax
ffff8000001039a1:	80 ff ff 
ffff8000001039a4:	ff d0                	call   *%rax
}
ffff8000001039a6:	90                   	nop
ffff8000001039a7:	c9                   	leave
ffff8000001039a8:	c3                   	ret

ffff8000001039a9 <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
ffff8000001039a9:	55                   	push   %rbp
ffff8000001039aa:	48 89 e5             	mov    %rsp,%rbp
ffff8000001039ad:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001039b1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  if(b == 0)
ffff8000001039b5:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff8000001039ba:	75 19                	jne    ffff8000001039d5 <idestart+0x2c>
    panic("idestart");
ffff8000001039bc:	48 b8 b7 c1 10 00 00 	movabs $0xffff80000010c1b7,%rax
ffff8000001039c3:	80 ff ff 
ffff8000001039c6:	48 89 c7             	mov    %rax,%rdi
ffff8000001039c9:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001039d0:	80 ff ff 
ffff8000001039d3:	ff d0                	call   *%rax
  if(b->blockno >= FSSIZE)
ffff8000001039d5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001039d9:	8b 40 08             	mov    0x8(%rax),%eax
ffff8000001039dc:	3d e7 03 00 00       	cmp    $0x3e7,%eax
ffff8000001039e1:	76 19                	jbe    ffff8000001039fc <idestart+0x53>
    panic("incorrect blockno");
ffff8000001039e3:	48 b8 c0 c1 10 00 00 	movabs $0xffff80000010c1c0,%rax
ffff8000001039ea:	80 ff ff 
ffff8000001039ed:	48 89 c7             	mov    %rax,%rdi
ffff8000001039f0:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001039f7:	80 ff ff 
ffff8000001039fa:	ff d0                	call   *%rax
  int sector_per_block =  BSIZE/SECTOR_SIZE;
ffff8000001039fc:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
  int sector = b->blockno * sector_per_block;
ffff800000103a03:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103a07:	8b 50 08             	mov    0x8(%rax),%edx
ffff800000103a0a:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000103a0d:	0f af c2             	imul   %edx,%eax
ffff800000103a10:	89 45 f0             	mov    %eax,-0x10(%rbp)
  int read_cmd = (sector_per_block == 1) ? IDE_CMD_READ :  IDE_CMD_RDMUL;
ffff800000103a13:	83 7d f4 01          	cmpl   $0x1,-0xc(%rbp)
ffff800000103a17:	75 09                	jne    ffff800000103a22 <idestart+0x79>
ffff800000103a19:	c7 45 fc 20 00 00 00 	movl   $0x20,-0x4(%rbp)
ffff800000103a20:	eb 07                	jmp    ffff800000103a29 <idestart+0x80>
ffff800000103a22:	c7 45 fc c4 00 00 00 	movl   $0xc4,-0x4(%rbp)
  int write_cmd = (sector_per_block == 1) ? IDE_CMD_WRITE : IDE_CMD_WRMUL;
ffff800000103a29:	83 7d f4 01          	cmpl   $0x1,-0xc(%rbp)
ffff800000103a2d:	75 09                	jne    ffff800000103a38 <idestart+0x8f>
ffff800000103a2f:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
ffff800000103a36:	eb 07                	jmp    ffff800000103a3f <idestart+0x96>
ffff800000103a38:	c7 45 f8 c5 00 00 00 	movl   $0xc5,-0x8(%rbp)

  if (sector_per_block > 7) panic("idestart");
ffff800000103a3f:	83 7d f4 07          	cmpl   $0x7,-0xc(%rbp)
ffff800000103a43:	7e 19                	jle    ffff800000103a5e <idestart+0xb5>
ffff800000103a45:	48 b8 b7 c1 10 00 00 	movabs $0xffff80000010c1b7,%rax
ffff800000103a4c:	80 ff ff 
ffff800000103a4f:	48 89 c7             	mov    %rax,%rdi
ffff800000103a52:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000103a59:	80 ff ff 
ffff800000103a5c:	ff d0                	call   *%rax

  idewait(0);
ffff800000103a5e:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000103a63:	48 b8 8e 38 10 00 00 	movabs $0xffff80000010388e,%rax
ffff800000103a6a:	80 ff ff 
ffff800000103a6d:	ff d0                	call   *%rax
  outb(0x3f6, 0);  // generate interrupt
ffff800000103a6f:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000103a74:	bf f6 03 00 00       	mov    $0x3f6,%edi
ffff800000103a79:	48 b8 3f 38 10 00 00 	movabs $0xffff80000010383f,%rax
ffff800000103a80:	80 ff ff 
ffff800000103a83:	ff d0                	call   *%rax
  outb(0x1f2, sector_per_block);  // number of sectors
ffff800000103a85:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000103a88:	0f b6 c0             	movzbl %al,%eax
ffff800000103a8b:	89 c6                	mov    %eax,%esi
ffff800000103a8d:	bf f2 01 00 00       	mov    $0x1f2,%edi
ffff800000103a92:	48 b8 3f 38 10 00 00 	movabs $0xffff80000010383f,%rax
ffff800000103a99:	80 ff ff 
ffff800000103a9c:	ff d0                	call   *%rax
  outb(0x1f3, sector & 0xff);
ffff800000103a9e:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000103aa1:	0f b6 c0             	movzbl %al,%eax
ffff800000103aa4:	89 c6                	mov    %eax,%esi
ffff800000103aa6:	bf f3 01 00 00       	mov    $0x1f3,%edi
ffff800000103aab:	48 b8 3f 38 10 00 00 	movabs $0xffff80000010383f,%rax
ffff800000103ab2:	80 ff ff 
ffff800000103ab5:	ff d0                	call   *%rax
  outb(0x1f4, (sector >> 8) & 0xff);
ffff800000103ab7:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000103aba:	c1 f8 08             	sar    $0x8,%eax
ffff800000103abd:	0f b6 c0             	movzbl %al,%eax
ffff800000103ac0:	89 c6                	mov    %eax,%esi
ffff800000103ac2:	bf f4 01 00 00       	mov    $0x1f4,%edi
ffff800000103ac7:	48 b8 3f 38 10 00 00 	movabs $0xffff80000010383f,%rax
ffff800000103ace:	80 ff ff 
ffff800000103ad1:	ff d0                	call   *%rax
  outb(0x1f5, (sector >> 16) & 0xff);
ffff800000103ad3:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000103ad6:	c1 f8 10             	sar    $0x10,%eax
ffff800000103ad9:	0f b6 c0             	movzbl %al,%eax
ffff800000103adc:	89 c6                	mov    %eax,%esi
ffff800000103ade:	bf f5 01 00 00       	mov    $0x1f5,%edi
ffff800000103ae3:	48 b8 3f 38 10 00 00 	movabs $0xffff80000010383f,%rax
ffff800000103aea:	80 ff ff 
ffff800000103aed:	ff d0                	call   *%rax
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
ffff800000103aef:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103af3:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000103af6:	c1 e0 04             	shl    $0x4,%eax
ffff800000103af9:	83 e0 10             	and    $0x10,%eax
ffff800000103afc:	89 c2                	mov    %eax,%edx
ffff800000103afe:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000103b01:	c1 f8 18             	sar    $0x18,%eax
ffff800000103b04:	83 e0 0f             	and    $0xf,%eax
ffff800000103b07:	09 d0                	or     %edx,%eax
ffff800000103b09:	83 c8 e0             	or     $0xffffffe0,%eax
ffff800000103b0c:	0f b6 c0             	movzbl %al,%eax
ffff800000103b0f:	89 c6                	mov    %eax,%esi
ffff800000103b11:	bf f6 01 00 00       	mov    $0x1f6,%edi
ffff800000103b16:	48 b8 3f 38 10 00 00 	movabs $0xffff80000010383f,%rax
ffff800000103b1d:	80 ff ff 
ffff800000103b20:	ff d0                	call   *%rax
  if(b->flags & B_DIRTY){
ffff800000103b22:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103b26:	8b 00                	mov    (%rax),%eax
ffff800000103b28:	83 e0 04             	and    $0x4,%eax
ffff800000103b2b:	85 c0                	test   %eax,%eax
ffff800000103b2d:	74 3e                	je     ffff800000103b6d <idestart+0x1c4>
    outb(0x1f7, write_cmd);
ffff800000103b2f:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000103b32:	0f b6 c0             	movzbl %al,%eax
ffff800000103b35:	89 c6                	mov    %eax,%esi
ffff800000103b37:	bf f7 01 00 00       	mov    $0x1f7,%edi
ffff800000103b3c:	48 b8 3f 38 10 00 00 	movabs $0xffff80000010383f,%rax
ffff800000103b43:	80 ff ff 
ffff800000103b46:	ff d0                	call   *%rax
    outsl(0x1f0, b->data, BSIZE/4);
ffff800000103b48:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103b4c:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000103b52:	ba 80 00 00 00       	mov    $0x80,%edx
ffff800000103b57:	48 89 c6             	mov    %rax,%rsi
ffff800000103b5a:	bf f0 01 00 00       	mov    $0x1f0,%edi
ffff800000103b5f:	48 b8 5e 38 10 00 00 	movabs $0xffff80000010385e,%rax
ffff800000103b66:	80 ff ff 
ffff800000103b69:	ff d0                	call   *%rax
  } else {
    outb(0x1f7, read_cmd);
  }
}
ffff800000103b6b:	eb 19                	jmp    ffff800000103b86 <idestart+0x1dd>
    outb(0x1f7, read_cmd);
ffff800000103b6d:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000103b70:	0f b6 c0             	movzbl %al,%eax
ffff800000103b73:	89 c6                	mov    %eax,%esi
ffff800000103b75:	bf f7 01 00 00       	mov    $0x1f7,%edi
ffff800000103b7a:	48 b8 3f 38 10 00 00 	movabs $0xffff80000010383f,%rax
ffff800000103b81:	80 ff ff 
ffff800000103b84:	ff d0                	call   *%rax
}
ffff800000103b86:	90                   	nop
ffff800000103b87:	c9                   	leave
ffff800000103b88:	c3                   	ret

ffff800000103b89 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
ffff800000103b89:	55                   	push   %rbp
ffff800000103b8a:	48 89 e5             	mov    %rsp,%rbp
ffff800000103b8d:	48 83 ec 10          	sub    $0x10,%rsp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
ffff800000103b91:	48 b8 c0 70 11 00 00 	movabs $0xffff8000001170c0,%rax
ffff800000103b98:	80 ff ff 
ffff800000103b9b:	48 89 c7             	mov    %rax,%rdi
ffff800000103b9e:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff800000103ba5:	80 ff ff 
ffff800000103ba8:	ff d0                	call   *%rax
  if((b = idequeue) == 0){
ffff800000103baa:	48 b8 28 71 11 00 00 	movabs $0xffff800000117128,%rax
ffff800000103bb1:	80 ff ff 
ffff800000103bb4:	48 8b 00             	mov    (%rax),%rax
ffff800000103bb7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000103bbb:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000103bc0:	75 1e                	jne    ffff800000103be0 <ideintr+0x57>
    release(&idelock);
ffff800000103bc2:	48 b8 c0 70 11 00 00 	movabs $0xffff8000001170c0,%rax
ffff800000103bc9:	80 ff ff 
ffff800000103bcc:	48 89 c7             	mov    %rax,%rdi
ffff800000103bcf:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000103bd6:	80 ff ff 
ffff800000103bd9:	ff d0                	call   *%rax
    // cprintf("spurious IDE interrupt\n");
    return;
ffff800000103bdb:	e9 d9 00 00 00       	jmp    ffff800000103cb9 <ideintr+0x130>
  }
  idequeue = b->qnext;
ffff800000103be0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103be4:	48 8b 80 a8 00 00 00 	mov    0xa8(%rax),%rax
ffff800000103beb:	48 ba 28 71 11 00 00 	movabs $0xffff800000117128,%rdx
ffff800000103bf2:	80 ff ff 
ffff800000103bf5:	48 89 02             	mov    %rax,(%rdx)

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
ffff800000103bf8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103bfc:	8b 00                	mov    (%rax),%eax
ffff800000103bfe:	83 e0 04             	and    $0x4,%eax
ffff800000103c01:	85 c0                	test   %eax,%eax
ffff800000103c03:	75 38                	jne    ffff800000103c3d <ideintr+0xb4>
ffff800000103c05:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000103c0a:	48 b8 8e 38 10 00 00 	movabs $0xffff80000010388e,%rax
ffff800000103c11:	80 ff ff 
ffff800000103c14:	ff d0                	call   *%rax
ffff800000103c16:	85 c0                	test   %eax,%eax
ffff800000103c18:	78 23                	js     ffff800000103c3d <ideintr+0xb4>
    insl(0x1f0, b->data, BSIZE/4);
ffff800000103c1a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103c1e:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000103c24:	ba 80 00 00 00       	mov    $0x80,%edx
ffff800000103c29:	48 89 c6             	mov    %rax,%rsi
ffff800000103c2c:	bf f0 01 00 00       	mov    $0x1f0,%edi
ffff800000103c31:	48 b8 09 38 10 00 00 	movabs $0xffff800000103809,%rax
ffff800000103c38:	80 ff ff 
ffff800000103c3b:	ff d0                	call   *%rax

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
ffff800000103c3d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103c41:	8b 00                	mov    (%rax),%eax
ffff800000103c43:	83 c8 02             	or     $0x2,%eax
ffff800000103c46:	89 c2                	mov    %eax,%edx
ffff800000103c48:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103c4c:	89 10                	mov    %edx,(%rax)
  b->flags &= ~B_DIRTY;
ffff800000103c4e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103c52:	8b 00                	mov    (%rax),%eax
ffff800000103c54:	83 e0 fb             	and    $0xfffffffb,%eax
ffff800000103c57:	89 c2                	mov    %eax,%edx
ffff800000103c59:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103c5d:	89 10                	mov    %edx,(%rax)
  wakeup(b);
ffff800000103c5f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103c63:	48 89 c7             	mov    %rax,%rdi
ffff800000103c66:	48 b8 c6 6f 10 00 00 	movabs $0xffff800000106fc6,%rax
ffff800000103c6d:	80 ff ff 
ffff800000103c70:	ff d0                	call   *%rax

  // Start disk on next buf in queue.
  if(idequeue != 0)
ffff800000103c72:	48 b8 28 71 11 00 00 	movabs $0xffff800000117128,%rax
ffff800000103c79:	80 ff ff 
ffff800000103c7c:	48 8b 00             	mov    (%rax),%rax
ffff800000103c7f:	48 85 c0             	test   %rax,%rax
ffff800000103c82:	74 1c                	je     ffff800000103ca0 <ideintr+0x117>
    idestart(idequeue);
ffff800000103c84:	48 b8 28 71 11 00 00 	movabs $0xffff800000117128,%rax
ffff800000103c8b:	80 ff ff 
ffff800000103c8e:	48 8b 00             	mov    (%rax),%rax
ffff800000103c91:	48 89 c7             	mov    %rax,%rdi
ffff800000103c94:	48 b8 a9 39 10 00 00 	movabs $0xffff8000001039a9,%rax
ffff800000103c9b:	80 ff ff 
ffff800000103c9e:	ff d0                	call   *%rax

  release(&idelock);
ffff800000103ca0:	48 b8 c0 70 11 00 00 	movabs $0xffff8000001170c0,%rax
ffff800000103ca7:	80 ff ff 
ffff800000103caa:	48 89 c7             	mov    %rax,%rdi
ffff800000103cad:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000103cb4:	80 ff ff 
ffff800000103cb7:	ff d0                	call   *%rax
}
ffff800000103cb9:	c9                   	leave
ffff800000103cba:	c3                   	ret

ffff800000103cbb <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
ffff800000103cbb:	55                   	push   %rbp
ffff800000103cbc:	48 89 e5             	mov    %rsp,%rbp
ffff800000103cbf:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000103cc3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct buf **pp;

  if(!holdingsleep(&b->lock))
ffff800000103cc7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103ccb:	48 83 c0 10          	add    $0x10,%rax
ffff800000103ccf:	48 89 c7             	mov    %rax,%rdi
ffff800000103cd2:	48 b8 72 76 10 00 00 	movabs $0xffff800000107672,%rax
ffff800000103cd9:	80 ff ff 
ffff800000103cdc:	ff d0                	call   *%rax
ffff800000103cde:	85 c0                	test   %eax,%eax
ffff800000103ce0:	75 19                	jne    ffff800000103cfb <iderw+0x40>
    panic("iderw: buf not locked");
ffff800000103ce2:	48 b8 d2 c1 10 00 00 	movabs $0xffff80000010c1d2,%rax
ffff800000103ce9:	80 ff ff 
ffff800000103cec:	48 89 c7             	mov    %rax,%rdi
ffff800000103cef:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000103cf6:	80 ff ff 
ffff800000103cf9:	ff d0                	call   *%rax
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
ffff800000103cfb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103cff:	8b 00                	mov    (%rax),%eax
ffff800000103d01:	83 e0 06             	and    $0x6,%eax
ffff800000103d04:	83 f8 02             	cmp    $0x2,%eax
ffff800000103d07:	75 19                	jne    ffff800000103d22 <iderw+0x67>
    panic("iderw: nothing to do");
ffff800000103d09:	48 b8 e8 c1 10 00 00 	movabs $0xffff80000010c1e8,%rax
ffff800000103d10:	80 ff ff 
ffff800000103d13:	48 89 c7             	mov    %rax,%rdi
ffff800000103d16:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000103d1d:	80 ff ff 
ffff800000103d20:	ff d0                	call   *%rax
  if(b->dev != 0 && !havedisk1)
ffff800000103d22:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103d26:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000103d29:	85 c0                	test   %eax,%eax
ffff800000103d2b:	74 29                	je     ffff800000103d56 <iderw+0x9b>
ffff800000103d2d:	48 b8 30 71 11 00 00 	movabs $0xffff800000117130,%rax
ffff800000103d34:	80 ff ff 
ffff800000103d37:	8b 00                	mov    (%rax),%eax
ffff800000103d39:	85 c0                	test   %eax,%eax
ffff800000103d3b:	75 19                	jne    ffff800000103d56 <iderw+0x9b>
    panic("iderw: ide disk 1 not present");
ffff800000103d3d:	48 b8 fd c1 10 00 00 	movabs $0xffff80000010c1fd,%rax
ffff800000103d44:	80 ff ff 
ffff800000103d47:	48 89 c7             	mov    %rax,%rdi
ffff800000103d4a:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000103d51:	80 ff ff 
ffff800000103d54:	ff d0                	call   *%rax

  acquire(&idelock);  //DOC:acquire-lock
ffff800000103d56:	48 b8 c0 70 11 00 00 	movabs $0xffff8000001170c0,%rax
ffff800000103d5d:	80 ff ff 
ffff800000103d60:	48 89 c7             	mov    %rax,%rdi
ffff800000103d63:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff800000103d6a:	80 ff ff 
ffff800000103d6d:	ff d0                	call   *%rax

  // Append b to idequeue.
  b->qnext = 0;
ffff800000103d6f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103d73:	48 c7 80 a8 00 00 00 	movq   $0x0,0xa8(%rax)
ffff800000103d7a:	00 00 00 00 
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
ffff800000103d7e:	48 b8 28 71 11 00 00 	movabs $0xffff800000117128,%rax
ffff800000103d85:	80 ff ff 
ffff800000103d88:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000103d8c:	eb 11                	jmp    ffff800000103d9f <iderw+0xe4>
ffff800000103d8e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103d92:	48 8b 00             	mov    (%rax),%rax
ffff800000103d95:	48 05 a8 00 00 00    	add    $0xa8,%rax
ffff800000103d9b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000103d9f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103da3:	48 8b 00             	mov    (%rax),%rax
ffff800000103da6:	48 85 c0             	test   %rax,%rax
ffff800000103da9:	75 e3                	jne    ffff800000103d8e <iderw+0xd3>
    ;
  *pp = b;
ffff800000103dab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103daf:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000103db3:	48 89 10             	mov    %rdx,(%rax)

  // Start disk if necessary.
  if(idequeue == b)
ffff800000103db6:	48 b8 28 71 11 00 00 	movabs $0xffff800000117128,%rax
ffff800000103dbd:	80 ff ff 
ffff800000103dc0:	48 8b 00             	mov    (%rax),%rax
ffff800000103dc3:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffff800000103dc7:	75 35                	jne    ffff800000103dfe <iderw+0x143>
    idestart(b);
ffff800000103dc9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103dcd:	48 89 c7             	mov    %rax,%rdi
ffff800000103dd0:	48 b8 a9 39 10 00 00 	movabs $0xffff8000001039a9,%rax
ffff800000103dd7:	80 ff ff 
ffff800000103dda:	ff d0                	call   *%rax

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
ffff800000103ddc:	eb 20                	jmp    ffff800000103dfe <iderw+0x143>
    sleep(b, &idelock);
ffff800000103dde:	48 ba c0 70 11 00 00 	movabs $0xffff8000001170c0,%rdx
ffff800000103de5:	80 ff ff 
ffff800000103de8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103dec:	48 89 d6             	mov    %rdx,%rsi
ffff800000103def:	48 89 c7             	mov    %rax,%rdi
ffff800000103df2:	48 b8 51 6e 10 00 00 	movabs $0xffff800000106e51,%rax
ffff800000103df9:	80 ff ff 
ffff800000103dfc:	ff d0                	call   *%rax
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
ffff800000103dfe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103e02:	8b 00                	mov    (%rax),%eax
ffff800000103e04:	83 e0 06             	and    $0x6,%eax
ffff800000103e07:	83 f8 02             	cmp    $0x2,%eax
ffff800000103e0a:	75 d2                	jne    ffff800000103dde <iderw+0x123>
  }

  release(&idelock);
ffff800000103e0c:	48 b8 c0 70 11 00 00 	movabs $0xffff8000001170c0,%rax
ffff800000103e13:	80 ff ff 
ffff800000103e16:	48 89 c7             	mov    %rax,%rdi
ffff800000103e19:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000103e20:	80 ff ff 
ffff800000103e23:	ff d0                	call   *%rax
}
ffff800000103e25:	90                   	nop
ffff800000103e26:	c9                   	leave
ffff800000103e27:	c3                   	ret

ffff800000103e28 <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
ffff800000103e28:	55                   	push   %rbp
ffff800000103e29:	48 89 e5             	mov    %rsp,%rbp
ffff800000103e2c:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000103e30:	89 7d fc             	mov    %edi,-0x4(%rbp)
  ioapic->reg = reg;
ffff800000103e33:	48 b8 38 71 11 00 00 	movabs $0xffff800000117138,%rax
ffff800000103e3a:	80 ff ff 
ffff800000103e3d:	48 8b 00             	mov    (%rax),%rax
ffff800000103e40:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000103e43:	89 10                	mov    %edx,(%rax)
  return ioapic->data;
ffff800000103e45:	48 b8 38 71 11 00 00 	movabs $0xffff800000117138,%rax
ffff800000103e4c:	80 ff ff 
ffff800000103e4f:	48 8b 00             	mov    (%rax),%rax
ffff800000103e52:	8b 40 10             	mov    0x10(%rax),%eax
}
ffff800000103e55:	c9                   	leave
ffff800000103e56:	c3                   	ret

ffff800000103e57 <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
ffff800000103e57:	55                   	push   %rbp
ffff800000103e58:	48 89 e5             	mov    %rsp,%rbp
ffff800000103e5b:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000103e5f:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff800000103e62:	89 75 f8             	mov    %esi,-0x8(%rbp)
  ioapic->reg = reg;
ffff800000103e65:	48 b8 38 71 11 00 00 	movabs $0xffff800000117138,%rax
ffff800000103e6c:	80 ff ff 
ffff800000103e6f:	48 8b 00             	mov    (%rax),%rax
ffff800000103e72:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000103e75:	89 10                	mov    %edx,(%rax)
  ioapic->data = data;
ffff800000103e77:	48 b8 38 71 11 00 00 	movabs $0xffff800000117138,%rax
ffff800000103e7e:	80 ff ff 
ffff800000103e81:	48 8b 00             	mov    (%rax),%rax
ffff800000103e84:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffff800000103e87:	89 50 10             	mov    %edx,0x10(%rax)
}
ffff800000103e8a:	90                   	nop
ffff800000103e8b:	c9                   	leave
ffff800000103e8c:	c3                   	ret

ffff800000103e8d <ioapicinit>:

void
ioapicinit(void)
{
ffff800000103e8d:	55                   	push   %rbp
ffff800000103e8e:	48 89 e5             	mov    %rsp,%rbp
ffff800000103e91:	48 83 ec 10          	sub    $0x10,%rsp
  int i, id, maxintr;

  ioapic = P2V((volatile struct ioapic*)IOAPIC);
ffff800000103e95:	48 b8 38 71 11 00 00 	movabs $0xffff800000117138,%rax
ffff800000103e9c:	80 ff ff 
ffff800000103e9f:	48 b9 00 00 c0 fe 00 	movabs $0xffff8000fec00000,%rcx
ffff800000103ea6:	80 ff ff 
ffff800000103ea9:	48 89 08             	mov    %rcx,(%rax)
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
ffff800000103eac:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000103eb1:	48 b8 28 3e 10 00 00 	movabs $0xffff800000103e28,%rax
ffff800000103eb8:	80 ff ff 
ffff800000103ebb:	ff d0                	call   *%rax
ffff800000103ebd:	c1 e8 10             	shr    $0x10,%eax
ffff800000103ec0:	25 ff 00 00 00       	and    $0xff,%eax
ffff800000103ec5:	89 45 f8             	mov    %eax,-0x8(%rbp)
  id = ioapicread(REG_ID) >> 24;
ffff800000103ec8:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000103ecd:	48 b8 28 3e 10 00 00 	movabs $0xffff800000103e28,%rax
ffff800000103ed4:	80 ff ff 
ffff800000103ed7:	ff d0                	call   *%rax
ffff800000103ed9:	c1 e8 18             	shr    $0x18,%eax
ffff800000103edc:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(id != ioapicid)
ffff800000103edf:	48 b8 24 74 11 00 00 	movabs $0xffff800000117424,%rax
ffff800000103ee6:	80 ff ff 
ffff800000103ee9:	0f b6 00             	movzbl (%rax),%eax
ffff800000103eec:	0f b6 c0             	movzbl %al,%eax
ffff800000103eef:	39 45 f4             	cmp    %eax,-0xc(%rbp)
ffff800000103ef2:	74 1e                	je     ffff800000103f12 <ioapicinit+0x85>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
ffff800000103ef4:	48 b8 20 c2 10 00 00 	movabs $0xffff80000010c220,%rax
ffff800000103efb:	80 ff ff 
ffff800000103efe:	48 89 c7             	mov    %rax,%rdi
ffff800000103f01:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000103f06:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000103f0d:	80 ff ff 
ffff800000103f10:	ff d2                	call   *%rdx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
ffff800000103f12:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000103f19:	eb 47                	jmp    ffff800000103f62 <ioapicinit+0xd5>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
ffff800000103f1b:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000103f1e:	83 c0 20             	add    $0x20,%eax
ffff800000103f21:	0d 00 00 01 00       	or     $0x10000,%eax
ffff800000103f26:	89 c2                	mov    %eax,%edx
ffff800000103f28:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000103f2b:	83 c0 08             	add    $0x8,%eax
ffff800000103f2e:	01 c0                	add    %eax,%eax
ffff800000103f30:	89 d6                	mov    %edx,%esi
ffff800000103f32:	89 c7                	mov    %eax,%edi
ffff800000103f34:	48 b8 57 3e 10 00 00 	movabs $0xffff800000103e57,%rax
ffff800000103f3b:	80 ff ff 
ffff800000103f3e:	ff d0                	call   *%rax
    ioapicwrite(REG_TABLE+2*i+1, 0);
ffff800000103f40:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000103f43:	83 c0 08             	add    $0x8,%eax
ffff800000103f46:	01 c0                	add    %eax,%eax
ffff800000103f48:	83 c0 01             	add    $0x1,%eax
ffff800000103f4b:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000103f50:	89 c7                	mov    %eax,%edi
ffff800000103f52:	48 b8 57 3e 10 00 00 	movabs $0xffff800000103e57,%rax
ffff800000103f59:	80 ff ff 
ffff800000103f5c:	ff d0                	call   *%rax
  for(i = 0; i <= maxintr; i++){
ffff800000103f5e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000103f62:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000103f65:	3b 45 f8             	cmp    -0x8(%rbp),%eax
ffff800000103f68:	7e b1                	jle    ffff800000103f1b <ioapicinit+0x8e>
  }
}
ffff800000103f6a:	90                   	nop
ffff800000103f6b:	90                   	nop
ffff800000103f6c:	c9                   	leave
ffff800000103f6d:	c3                   	ret

ffff800000103f6e <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
ffff800000103f6e:	55                   	push   %rbp
ffff800000103f6f:	48 89 e5             	mov    %rsp,%rbp
ffff800000103f72:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000103f76:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff800000103f79:	89 75 f8             	mov    %esi,-0x8(%rbp)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
ffff800000103f7c:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000103f7f:	83 c0 20             	add    $0x20,%eax
ffff800000103f82:	89 c2                	mov    %eax,%edx
ffff800000103f84:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000103f87:	83 c0 08             	add    $0x8,%eax
ffff800000103f8a:	01 c0                	add    %eax,%eax
ffff800000103f8c:	89 d6                	mov    %edx,%esi
ffff800000103f8e:	89 c7                	mov    %eax,%edi
ffff800000103f90:	48 b8 57 3e 10 00 00 	movabs $0xffff800000103e57,%rax
ffff800000103f97:	80 ff ff 
ffff800000103f9a:	ff d0                	call   *%rax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
ffff800000103f9c:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000103f9f:	c1 e0 18             	shl    $0x18,%eax
ffff800000103fa2:	89 c2                	mov    %eax,%edx
ffff800000103fa4:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000103fa7:	83 c0 08             	add    $0x8,%eax
ffff800000103faa:	01 c0                	add    %eax,%eax
ffff800000103fac:	83 c0 01             	add    $0x1,%eax
ffff800000103faf:	89 d6                	mov    %edx,%esi
ffff800000103fb1:	89 c7                	mov    %eax,%edi
ffff800000103fb3:	48 b8 57 3e 10 00 00 	movabs $0xffff800000103e57,%rax
ffff800000103fba:	80 ff ff 
ffff800000103fbd:	ff d0                	call   *%rax
}
ffff800000103fbf:	90                   	nop
ffff800000103fc0:	c9                   	leave
ffff800000103fc1:	c3                   	ret

ffff800000103fc2 <kinit1>:
  struct run *freelist;
} kmem;

void
kinit1(void *vstart, void *vend)
{
ffff800000103fc2:	55                   	push   %rbp
ffff800000103fc3:	48 89 e5             	mov    %rsp,%rbp
ffff800000103fc6:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000103fca:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000103fce:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  initlock(&kmem.lock, "kmem");
ffff800000103fd2:	48 ba 52 c2 10 00 00 	movabs $0xffff80000010c252,%rdx
ffff800000103fd9:	80 ff ff 
ffff800000103fdc:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff800000103fe3:	80 ff ff 
ffff800000103fe6:	48 89 d6             	mov    %rdx,%rsi
ffff800000103fe9:	48 89 c7             	mov    %rax,%rdi
ffff800000103fec:	48 b8 05 77 10 00 00 	movabs $0xffff800000107705,%rax
ffff800000103ff3:	80 ff ff 
ffff800000103ff6:	ff d0                	call   *%rax
  kmem.use_lock = 0;
ffff800000103ff8:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff800000103fff:	80 ff ff 
ffff800000104002:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%rax)
  kmem.freelist = 0; // empty
ffff800000104009:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff800000104010:	80 ff ff 
ffff800000104013:	48 c7 40 70 00 00 00 	movq   $0x0,0x70(%rax)
ffff80000010401a:	00 
  freerange(vstart, vend);
ffff80000010401b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff80000010401f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000104023:	48 89 d6             	mov    %rdx,%rsi
ffff800000104026:	48 89 c7             	mov    %rax,%rdi
ffff800000104029:	48 b8 50 40 10 00 00 	movabs $0xffff800000104050,%rax
ffff800000104030:	80 ff ff 
ffff800000104033:	ff d0                	call   *%rax
}
ffff800000104035:	90                   	nop
ffff800000104036:	c9                   	leave
ffff800000104037:	c3                   	ret

ffff800000104038 <kinit2>:

void
kinit2()
{
ffff800000104038:	55                   	push   %rbp
ffff800000104039:	48 89 e5             	mov    %rsp,%rbp
  kmem.use_lock = 1;
ffff80000010403c:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff800000104043:	80 ff ff 
ffff800000104046:	c7 40 68 01 00 00 00 	movl   $0x1,0x68(%rax)
}
ffff80000010404d:	90                   	nop
ffff80000010404e:	5d                   	pop    %rbp
ffff80000010404f:	c3                   	ret

ffff800000104050 <freerange>:

void
freerange(void *vstart, void *vend)
{
ffff800000104050:	55                   	push   %rbp
ffff800000104051:	48 89 e5             	mov    %rsp,%rbp
ffff800000104054:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000104058:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010405c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *p;
  p = (char*)PGROUNDUP((addr_t)vstart);
ffff800000104060:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104064:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffff80000010406a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff800000104070:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
ffff800000104074:	eb 1b                	jmp    ffff800000104091 <freerange+0x41>
    kfree(p);
ffff800000104076:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010407a:	48 89 c7             	mov    %rax,%rdi
ffff80000010407d:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff800000104084:	80 ff ff 
ffff800000104087:	ff d0                	call   *%rax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
ffff800000104089:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffff800000104090:	00 
ffff800000104091:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000104095:	48 05 00 10 00 00    	add    $0x1000,%rax
ffff80000010409b:	48 39 45 e0          	cmp    %rax,-0x20(%rbp)
ffff80000010409f:	73 d5                	jae    ffff800000104076 <freerange+0x26>
}
ffff8000001040a1:	90                   	nop
ffff8000001040a2:	90                   	nop
ffff8000001040a3:	c9                   	leave
ffff8000001040a4:	c3                   	ret

ffff8000001040a5 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
ffff8000001040a5:	55                   	push   %rbp
ffff8000001040a6:	48 89 e5             	mov    %rsp,%rbp
ffff8000001040a9:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001040ad:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct run *r;

  if((addr_t)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
ffff8000001040b1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001040b5:	25 ff 0f 00 00       	and    $0xfff,%eax
ffff8000001040ba:	48 85 c0             	test   %rax,%rax
ffff8000001040bd:	75 29                	jne    ffff8000001040e8 <kfree+0x43>
ffff8000001040bf:	48 b8 00 d0 11 00 00 	movabs $0xffff80000011d000,%rax
ffff8000001040c6:	80 ff ff 
ffff8000001040c9:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffff8000001040cd:	72 19                	jb     ffff8000001040e8 <kfree+0x43>
ffff8000001040cf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001040d3:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff8000001040da:	80 00 00 
ffff8000001040dd:	48 01 d0             	add    %rdx,%rax
ffff8000001040e0:	48 3d ff ff ff 0d    	cmp    $0xdffffff,%rax
ffff8000001040e6:	76 19                	jbe    ffff800000104101 <kfree+0x5c>
    panic("kfree");
ffff8000001040e8:	48 b8 57 c2 10 00 00 	movabs $0xffff80000010c257,%rax
ffff8000001040ef:	80 ff ff 
ffff8000001040f2:	48 89 c7             	mov    %rax,%rdi
ffff8000001040f5:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001040fc:	80 ff ff 
ffff8000001040ff:	ff d0                	call   *%rax

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
ffff800000104101:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104105:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010410a:	be 01 00 00 00       	mov    $0x1,%esi
ffff80000010410f:	48 89 c7             	mov    %rax,%rdi
ffff800000104112:	48 b8 ce 7a 10 00 00 	movabs $0xffff800000107ace,%rax
ffff800000104119:	80 ff ff 
ffff80000010411c:	ff d0                	call   *%rax

  if(kmem.use_lock)
ffff80000010411e:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff800000104125:	80 ff ff 
ffff800000104128:	8b 40 68             	mov    0x68(%rax),%eax
ffff80000010412b:	85 c0                	test   %eax,%eax
ffff80000010412d:	74 19                	je     ffff800000104148 <kfree+0xa3>
    acquire(&kmem.lock);
ffff80000010412f:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff800000104136:	80 ff ff 
ffff800000104139:	48 89 c7             	mov    %rax,%rdi
ffff80000010413c:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff800000104143:	80 ff ff 
ffff800000104146:	ff d0                	call   *%rax
  r = (struct run*)v;
ffff800000104148:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010414c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  r->next = kmem.freelist;
ffff800000104150:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff800000104157:	80 ff ff 
ffff80000010415a:	48 8b 50 70          	mov    0x70(%rax),%rdx
ffff80000010415e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000104162:	48 89 10             	mov    %rdx,(%rax)
  kmem.freelist = r;
ffff800000104165:	48 ba 40 71 11 00 00 	movabs $0xffff800000117140,%rdx
ffff80000010416c:	80 ff ff 
ffff80000010416f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000104173:	48 89 42 70          	mov    %rax,0x70(%rdx)
  if(kmem.use_lock)
ffff800000104177:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff80000010417e:	80 ff ff 
ffff800000104181:	8b 40 68             	mov    0x68(%rax),%eax
ffff800000104184:	85 c0                	test   %eax,%eax
ffff800000104186:	74 19                	je     ffff8000001041a1 <kfree+0xfc>
    release(&kmem.lock);
ffff800000104188:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff80000010418f:	80 ff ff 
ffff800000104192:	48 89 c7             	mov    %rax,%rdi
ffff800000104195:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff80000010419c:	80 ff ff 
ffff80000010419f:	ff d0                	call   *%rax
}
ffff8000001041a1:	90                   	nop
ffff8000001041a2:	c9                   	leave
ffff8000001041a3:	c3                   	ret

ffff8000001041a4 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
ffff8000001041a4:	55                   	push   %rbp
ffff8000001041a5:	48 89 e5             	mov    %rsp,%rbp
ffff8000001041a8:	48 83 ec 10          	sub    $0x10,%rsp
  struct run *r;

  if(kmem.use_lock)
ffff8000001041ac:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff8000001041b3:	80 ff ff 
ffff8000001041b6:	8b 40 68             	mov    0x68(%rax),%eax
ffff8000001041b9:	85 c0                	test   %eax,%eax
ffff8000001041bb:	74 19                	je     ffff8000001041d6 <kalloc+0x32>
    acquire(&kmem.lock);
ffff8000001041bd:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff8000001041c4:	80 ff ff 
ffff8000001041c7:	48 89 c7             	mov    %rax,%rdi
ffff8000001041ca:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff8000001041d1:	80 ff ff 
ffff8000001041d4:	ff d0                	call   *%rax
  r = kmem.freelist;
ffff8000001041d6:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff8000001041dd:	80 ff ff 
ffff8000001041e0:	48 8b 40 70          	mov    0x70(%rax),%rax
ffff8000001041e4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(r)
ffff8000001041e8:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff8000001041ed:	74 28                	je     ffff800000104217 <kalloc+0x73>
    kmem.freelist = r->next;
ffff8000001041ef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001041f3:	48 8b 00             	mov    (%rax),%rax
ffff8000001041f6:	48 ba 40 71 11 00 00 	movabs $0xffff800000117140,%rdx
ffff8000001041fd:	80 ff ff 
ffff800000104200:	48 89 42 70          	mov    %rax,0x70(%rdx)
  else {
    panic("Out of memory!");
  }
  
  if(kmem.use_lock)
ffff800000104204:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff80000010420b:	80 ff ff 
ffff80000010420e:	8b 40 68             	mov    0x68(%rax),%eax
ffff800000104211:	85 c0                	test   %eax,%eax
ffff800000104213:	74 34                	je     ffff800000104249 <kalloc+0xa5>
ffff800000104215:	eb 19                	jmp    ffff800000104230 <kalloc+0x8c>
    panic("Out of memory!");
ffff800000104217:	48 b8 5d c2 10 00 00 	movabs $0xffff80000010c25d,%rax
ffff80000010421e:	80 ff ff 
ffff800000104221:	48 89 c7             	mov    %rax,%rdi
ffff800000104224:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010422b:	80 ff ff 
ffff80000010422e:	ff d0                	call   *%rax
    release(&kmem.lock);
ffff800000104230:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff800000104237:	80 ff ff 
ffff80000010423a:	48 89 c7             	mov    %rax,%rdi
ffff80000010423d:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000104244:	80 ff ff 
ffff800000104247:	ff d0                	call   *%rax
  return (char*)r;
ffff800000104249:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff80000010424d:	c9                   	leave
ffff80000010424e:	c3                   	ret

ffff80000010424f <inb>:
{
ffff80000010424f:	55                   	push   %rbp
ffff800000104250:	48 89 e5             	mov    %rsp,%rbp
ffff800000104253:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000104257:	89 f8                	mov    %edi,%eax
ffff800000104259:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
ffff80000010425d:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff800000104261:	89 c2                	mov    %eax,%edx
ffff800000104263:	ec                   	in     (%dx),%al
ffff800000104264:	88 45 ff             	mov    %al,-0x1(%rbp)
  return data;
ffff800000104267:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
}
ffff80000010426b:	c9                   	leave
ffff80000010426c:	c3                   	ret

ffff80000010426d <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
ffff80000010426d:	55                   	push   %rbp
ffff80000010426e:	48 89 e5             	mov    %rsp,%rbp
ffff800000104271:	48 83 ec 10          	sub    $0x10,%rsp
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
ffff800000104275:	bf 64 00 00 00       	mov    $0x64,%edi
ffff80000010427a:	48 b8 4f 42 10 00 00 	movabs $0xffff80000010424f,%rax
ffff800000104281:	80 ff ff 
ffff800000104284:	ff d0                	call   *%rax
ffff800000104286:	0f b6 c0             	movzbl %al,%eax
ffff800000104289:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if((st & KBS_DIB) == 0)
ffff80000010428c:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff80000010428f:	83 e0 01             	and    $0x1,%eax
ffff800000104292:	85 c0                	test   %eax,%eax
ffff800000104294:	75 0a                	jne    ffff8000001042a0 <kbdgetc+0x33>
    return -1;
ffff800000104296:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010429b:	e9 a4 01 00 00       	jmp    ffff800000104444 <kbdgetc+0x1d7>
  data = inb(KBDATAP);
ffff8000001042a0:	bf 60 00 00 00       	mov    $0x60,%edi
ffff8000001042a5:	48 b8 4f 42 10 00 00 	movabs $0xffff80000010424f,%rax
ffff8000001042ac:	80 ff ff 
ffff8000001042af:	ff d0                	call   *%rax
ffff8000001042b1:	0f b6 c0             	movzbl %al,%eax
ffff8000001042b4:	89 45 fc             	mov    %eax,-0x4(%rbp)

  if(data == 0xE0){
ffff8000001042b7:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%rbp)
ffff8000001042be:	75 27                	jne    ffff8000001042e7 <kbdgetc+0x7a>
    shift |= E0ESC;
ffff8000001042c0:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff8000001042c7:	80 ff ff 
ffff8000001042ca:	8b 00                	mov    (%rax),%eax
ffff8000001042cc:	83 c8 40             	or     $0x40,%eax
ffff8000001042cf:	89 c2                	mov    %eax,%edx
ffff8000001042d1:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff8000001042d8:	80 ff ff 
ffff8000001042db:	89 10                	mov    %edx,(%rax)
    return 0;
ffff8000001042dd:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001042e2:	e9 5d 01 00 00       	jmp    ffff800000104444 <kbdgetc+0x1d7>
  } else if(data & 0x80){
ffff8000001042e7:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001042ea:	25 80 00 00 00       	and    $0x80,%eax
ffff8000001042ef:	85 c0                	test   %eax,%eax
ffff8000001042f1:	74 56                	je     ffff800000104349 <kbdgetc+0xdc>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
ffff8000001042f3:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff8000001042fa:	80 ff ff 
ffff8000001042fd:	8b 00                	mov    (%rax),%eax
ffff8000001042ff:	83 e0 40             	and    $0x40,%eax
ffff800000104302:	85 c0                	test   %eax,%eax
ffff800000104304:	75 04                	jne    ffff80000010430a <kbdgetc+0x9d>
ffff800000104306:	83 65 fc 7f          	andl   $0x7f,-0x4(%rbp)
    shift &= ~(shiftcode[data] | E0ESC);
ffff80000010430a:	48 ba 20 d0 10 00 00 	movabs $0xffff80000010d020,%rdx
ffff800000104311:	80 ff ff 
ffff800000104314:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104317:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
ffff80000010431b:	83 c8 40             	or     $0x40,%eax
ffff80000010431e:	0f b6 c0             	movzbl %al,%eax
ffff800000104321:	f7 d0                	not    %eax
ffff800000104323:	89 c2                	mov    %eax,%edx
ffff800000104325:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff80000010432c:	80 ff ff 
ffff80000010432f:	8b 00                	mov    (%rax),%eax
ffff800000104331:	21 c2                	and    %eax,%edx
ffff800000104333:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff80000010433a:	80 ff ff 
ffff80000010433d:	89 10                	mov    %edx,(%rax)
    return 0;
ffff80000010433f:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000104344:	e9 fb 00 00 00       	jmp    ffff800000104444 <kbdgetc+0x1d7>
  } else if(shift & E0ESC){
ffff800000104349:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff800000104350:	80 ff ff 
ffff800000104353:	8b 00                	mov    (%rax),%eax
ffff800000104355:	83 e0 40             	and    $0x40,%eax
ffff800000104358:	85 c0                	test   %eax,%eax
ffff80000010435a:	74 24                	je     ffff800000104380 <kbdgetc+0x113>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
ffff80000010435c:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%rbp)
    shift &= ~E0ESC;
ffff800000104363:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff80000010436a:	80 ff ff 
ffff80000010436d:	8b 00                	mov    (%rax),%eax
ffff80000010436f:	83 e0 bf             	and    $0xffffffbf,%eax
ffff800000104372:	89 c2                	mov    %eax,%edx
ffff800000104374:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff80000010437b:	80 ff ff 
ffff80000010437e:	89 10                	mov    %edx,(%rax)
  }

  shift |= shiftcode[data];
ffff800000104380:	48 ba 20 d0 10 00 00 	movabs $0xffff80000010d020,%rdx
ffff800000104387:	80 ff ff 
ffff80000010438a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010438d:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
ffff800000104391:	0f b6 d0             	movzbl %al,%edx
ffff800000104394:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff80000010439b:	80 ff ff 
ffff80000010439e:	8b 00                	mov    (%rax),%eax
ffff8000001043a0:	09 c2                	or     %eax,%edx
ffff8000001043a2:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff8000001043a9:	80 ff ff 
ffff8000001043ac:	89 10                	mov    %edx,(%rax)
  shift ^= togglecode[data];
ffff8000001043ae:	48 ba 20 d1 10 00 00 	movabs $0xffff80000010d120,%rdx
ffff8000001043b5:	80 ff ff 
ffff8000001043b8:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001043bb:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
ffff8000001043bf:	0f b6 d0             	movzbl %al,%edx
ffff8000001043c2:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff8000001043c9:	80 ff ff 
ffff8000001043cc:	8b 00                	mov    (%rax),%eax
ffff8000001043ce:	31 c2                	xor    %eax,%edx
ffff8000001043d0:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff8000001043d7:	80 ff ff 
ffff8000001043da:	89 10                	mov    %edx,(%rax)
  c = charcode[shift & (CTL | SHIFT)][data];
ffff8000001043dc:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff8000001043e3:	80 ff ff 
ffff8000001043e6:	8b 00                	mov    (%rax),%eax
ffff8000001043e8:	83 e0 03             	and    $0x3,%eax
ffff8000001043eb:	89 c2                	mov    %eax,%edx
ffff8000001043ed:	48 b8 20 d5 10 00 00 	movabs $0xffff80000010d520,%rax
ffff8000001043f4:	80 ff ff 
ffff8000001043f7:	89 d2                	mov    %edx,%edx
ffff8000001043f9:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
ffff8000001043fd:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104400:	48 01 d0             	add    %rdx,%rax
ffff800000104403:	0f b6 00             	movzbl (%rax),%eax
ffff800000104406:	0f b6 c0             	movzbl %al,%eax
ffff800000104409:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(shift & CAPSLOCK){
ffff80000010440c:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff800000104413:	80 ff ff 
ffff800000104416:	8b 00                	mov    (%rax),%eax
ffff800000104418:	83 e0 08             	and    $0x8,%eax
ffff80000010441b:	85 c0                	test   %eax,%eax
ffff80000010441d:	74 22                	je     ffff800000104441 <kbdgetc+0x1d4>
    if('a' <= c && c <= 'z')
ffff80000010441f:	83 7d f8 60          	cmpl   $0x60,-0x8(%rbp)
ffff800000104423:	76 0c                	jbe    ffff800000104431 <kbdgetc+0x1c4>
ffff800000104425:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%rbp)
ffff800000104429:	77 06                	ja     ffff800000104431 <kbdgetc+0x1c4>
      c += 'A' - 'a';
ffff80000010442b:	83 6d f8 20          	subl   $0x20,-0x8(%rbp)
ffff80000010442f:	eb 10                	jmp    ffff800000104441 <kbdgetc+0x1d4>
    else if('A' <= c && c <= 'Z')
ffff800000104431:	83 7d f8 40          	cmpl   $0x40,-0x8(%rbp)
ffff800000104435:	76 0a                	jbe    ffff800000104441 <kbdgetc+0x1d4>
ffff800000104437:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%rbp)
ffff80000010443b:	77 04                	ja     ffff800000104441 <kbdgetc+0x1d4>
      c += 'a' - 'A';
ffff80000010443d:	83 45 f8 20          	addl   $0x20,-0x8(%rbp)
  }
  return c;
ffff800000104441:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
ffff800000104444:	c9                   	leave
ffff800000104445:	c3                   	ret

ffff800000104446 <kbdintr>:

void
kbdintr(void)
{
ffff800000104446:	55                   	push   %rbp
ffff800000104447:	48 89 e5             	mov    %rsp,%rbp
  consoleintr(kbdgetc);
ffff80000010444a:	48 b8 6d 42 10 00 00 	movabs $0xffff80000010426d,%rax
ffff800000104451:	80 ff ff 
ffff800000104454:	48 89 c7             	mov    %rax,%rdi
ffff800000104457:	48 b8 6f 0f 10 00 00 	movabs $0xffff800000100f6f,%rax
ffff80000010445e:	80 ff ff 
ffff800000104461:	ff d0                	call   *%rax
}
ffff800000104463:	90                   	nop
ffff800000104464:	5d                   	pop    %rbp
ffff800000104465:	c3                   	ret

ffff800000104466 <inb>:
{
ffff800000104466:	55                   	push   %rbp
ffff800000104467:	48 89 e5             	mov    %rsp,%rbp
ffff80000010446a:	48 83 ec 18          	sub    $0x18,%rsp
ffff80000010446e:	89 f8                	mov    %edi,%eax
ffff800000104470:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
ffff800000104474:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff800000104478:	89 c2                	mov    %eax,%edx
ffff80000010447a:	ec                   	in     (%dx),%al
ffff80000010447b:	88 45 ff             	mov    %al,-0x1(%rbp)
  return data;
ffff80000010447e:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
}
ffff800000104482:	c9                   	leave
ffff800000104483:	c3                   	ret

ffff800000104484 <outb>:
{
ffff800000104484:	55                   	push   %rbp
ffff800000104485:	48 89 e5             	mov    %rsp,%rbp
ffff800000104488:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010448c:	89 fa                	mov    %edi,%edx
ffff80000010448e:	89 f0                	mov    %esi,%eax
ffff800000104490:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffff800000104494:	88 45 f8             	mov    %al,-0x8(%rbp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
ffff800000104497:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffff80000010449b:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffff80000010449f:	ee                   	out    %al,(%dx)
}
ffff8000001044a0:	90                   	nop
ffff8000001044a1:	c9                   	leave
ffff8000001044a2:	c3                   	ret

ffff8000001044a3 <readeflags>:
{
ffff8000001044a3:	55                   	push   %rbp
ffff8000001044a4:	48 89 e5             	mov    %rsp,%rbp
ffff8000001044a7:	48 83 ec 10          	sub    $0x10,%rsp
  asm volatile("pushf; pop %0" : "=r" (eflags));
ffff8000001044ab:	9c                   	pushf
ffff8000001044ac:	58                   	pop    %rax
ffff8000001044ad:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  return eflags;
ffff8000001044b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff8000001044b5:	c9                   	leave
ffff8000001044b6:	c3                   	ret

ffff8000001044b7 <lapicw>:

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
ffff8000001044b7:	55                   	push   %rbp
ffff8000001044b8:	48 89 e5             	mov    %rsp,%rbp
ffff8000001044bb:	48 83 ec 08          	sub    $0x8,%rsp
ffff8000001044bf:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff8000001044c2:	89 75 f8             	mov    %esi,-0x8(%rbp)
  lapic[index] = value;
ffff8000001044c5:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff8000001044cc:	80 ff ff 
ffff8000001044cf:	48 8b 00             	mov    (%rax),%rax
ffff8000001044d2:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001044d5:	48 63 d2             	movslq %edx,%rdx
ffff8000001044d8:	48 c1 e2 02          	shl    $0x2,%rdx
ffff8000001044dc:	48 01 c2             	add    %rax,%rdx
ffff8000001044df:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff8000001044e2:	89 02                	mov    %eax,(%rdx)
  lapic[ID];  // wait for write to finish, by reading
ffff8000001044e4:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff8000001044eb:	80 ff ff 
ffff8000001044ee:	48 8b 00             	mov    (%rax),%rax
ffff8000001044f1:	48 83 c0 20          	add    $0x20,%rax
ffff8000001044f5:	8b 00                	mov    (%rax),%eax
}
ffff8000001044f7:	90                   	nop
ffff8000001044f8:	c9                   	leave
ffff8000001044f9:	c3                   	ret

ffff8000001044fa <lapicinit>:

void
lapicinit(void)
{
ffff8000001044fa:	55                   	push   %rbp
ffff8000001044fb:	48 89 e5             	mov    %rsp,%rbp
  if(!lapic)
ffff8000001044fe:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff800000104505:	80 ff ff 
ffff800000104508:	48 8b 00             	mov    (%rax),%rax
ffff80000010450b:	48 85 c0             	test   %rax,%rax
ffff80000010450e:	0f 84 71 01 00 00    	je     ffff800000104685 <lapicinit+0x18b>
    return;

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
ffff800000104514:	be 3f 01 00 00       	mov    $0x13f,%esi
ffff800000104519:	bf 3c 00 00 00       	mov    $0x3c,%edi
ffff80000010451e:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff800000104525:	80 ff ff 
ffff800000104528:	ff d0                	call   *%rax

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
ffff80000010452a:	be 0b 00 00 00       	mov    $0xb,%esi
ffff80000010452f:	bf f8 00 00 00       	mov    $0xf8,%edi
ffff800000104534:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff80000010453b:	80 ff ff 
ffff80000010453e:	ff d0                	call   *%rax
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
ffff800000104540:	be 20 00 02 00       	mov    $0x20020,%esi
ffff800000104545:	bf c8 00 00 00       	mov    $0xc8,%edi
ffff80000010454a:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff800000104551:	80 ff ff 
ffff800000104554:	ff d0                	call   *%rax
  lapicw(TICR, 10000000);
ffff800000104556:	be 80 96 98 00       	mov    $0x989680,%esi
ffff80000010455b:	bf e0 00 00 00       	mov    $0xe0,%edi
ffff800000104560:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff800000104567:	80 ff ff 
ffff80000010456a:	ff d0                	call   *%rax

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
ffff80000010456c:	be 00 00 01 00       	mov    $0x10000,%esi
ffff800000104571:	bf d4 00 00 00       	mov    $0xd4,%edi
ffff800000104576:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff80000010457d:	80 ff ff 
ffff800000104580:	ff d0                	call   *%rax
  lapicw(LINT1, MASKED);
ffff800000104582:	be 00 00 01 00       	mov    $0x10000,%esi
ffff800000104587:	bf d8 00 00 00       	mov    $0xd8,%edi
ffff80000010458c:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff800000104593:	80 ff ff 
ffff800000104596:	ff d0                	call   *%rax

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
ffff800000104598:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff80000010459f:	80 ff ff 
ffff8000001045a2:	48 8b 00             	mov    (%rax),%rax
ffff8000001045a5:	48 83 c0 30          	add    $0x30,%rax
ffff8000001045a9:	8b 00                	mov    (%rax),%eax
ffff8000001045ab:	25 00 00 fc 00       	and    $0xfc0000,%eax
ffff8000001045b0:	85 c0                	test   %eax,%eax
ffff8000001045b2:	74 16                	je     ffff8000001045ca <lapicinit+0xd0>
    lapicw(PCINT, MASKED);
ffff8000001045b4:	be 00 00 01 00       	mov    $0x10000,%esi
ffff8000001045b9:	bf d0 00 00 00       	mov    $0xd0,%edi
ffff8000001045be:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff8000001045c5:	80 ff ff 
ffff8000001045c8:	ff d0                	call   *%rax

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
ffff8000001045ca:	be 33 00 00 00       	mov    $0x33,%esi
ffff8000001045cf:	bf dc 00 00 00       	mov    $0xdc,%edi
ffff8000001045d4:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff8000001045db:	80 ff ff 
ffff8000001045de:	ff d0                	call   *%rax

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
ffff8000001045e0:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001045e5:	bf a0 00 00 00       	mov    $0xa0,%edi
ffff8000001045ea:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff8000001045f1:	80 ff ff 
ffff8000001045f4:	ff d0                	call   *%rax
  lapicw(ESR, 0);
ffff8000001045f6:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001045fb:	bf a0 00 00 00       	mov    $0xa0,%edi
ffff800000104600:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff800000104607:	80 ff ff 
ffff80000010460a:	ff d0                	call   *%rax

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
ffff80000010460c:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000104611:	bf 2c 00 00 00       	mov    $0x2c,%edi
ffff800000104616:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff80000010461d:	80 ff ff 
ffff800000104620:	ff d0                	call   *%rax

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
ffff800000104622:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000104627:	bf c4 00 00 00       	mov    $0xc4,%edi
ffff80000010462c:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff800000104633:	80 ff ff 
ffff800000104636:	ff d0                	call   *%rax
  lapicw(ICRLO, BCAST | INIT | LEVEL);
ffff800000104638:	be 00 85 08 00       	mov    $0x88500,%esi
ffff80000010463d:	bf c0 00 00 00       	mov    $0xc0,%edi
ffff800000104642:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff800000104649:	80 ff ff 
ffff80000010464c:	ff d0                	call   *%rax
  while(lapic[ICRLO] & DELIVS)
ffff80000010464e:	90                   	nop
ffff80000010464f:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff800000104656:	80 ff ff 
ffff800000104659:	48 8b 00             	mov    (%rax),%rax
ffff80000010465c:	48 05 00 03 00 00    	add    $0x300,%rax
ffff800000104662:	8b 00                	mov    (%rax),%eax
ffff800000104664:	25 00 10 00 00       	and    $0x1000,%eax
ffff800000104669:	85 c0                	test   %eax,%eax
ffff80000010466b:	75 e2                	jne    ffff80000010464f <lapicinit+0x155>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
ffff80000010466d:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000104672:	bf 20 00 00 00       	mov    $0x20,%edi
ffff800000104677:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff80000010467e:	80 ff ff 
ffff800000104681:	ff d0                	call   *%rax
ffff800000104683:	eb 01                	jmp    ffff800000104686 <lapicinit+0x18c>
    return;
ffff800000104685:	90                   	nop
}
ffff800000104686:	5d                   	pop    %rbp
ffff800000104687:	c3                   	ret

ffff800000104688 <cpunum>:

int
cpunum(void)
{
ffff800000104688:	55                   	push   %rbp
ffff800000104689:	48 89 e5             	mov    %rsp,%rbp
ffff80000010468c:	48 83 ec 10          	sub    $0x10,%rsp
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
ffff800000104690:	48 b8 a3 44 10 00 00 	movabs $0xffff8000001044a3,%rax
ffff800000104697:	80 ff ff 
ffff80000010469a:	ff d0                	call   *%rax
ffff80000010469c:	25 00 02 00 00       	and    $0x200,%eax
ffff8000001046a1:	48 85 c0             	test   %rax,%rax
ffff8000001046a4:	74 47                	je     ffff8000001046ed <cpunum+0x65>
    static int n;
    if(n++ == 0)
ffff8000001046a6:	48 b8 c8 71 11 00 00 	movabs $0xffff8000001171c8,%rax
ffff8000001046ad:	80 ff ff 
ffff8000001046b0:	8b 00                	mov    (%rax),%eax
ffff8000001046b2:	8d 50 01             	lea    0x1(%rax),%edx
ffff8000001046b5:	48 b9 c8 71 11 00 00 	movabs $0xffff8000001171c8,%rcx
ffff8000001046bc:	80 ff ff 
ffff8000001046bf:	89 11                	mov    %edx,(%rcx)
ffff8000001046c1:	85 c0                	test   %eax,%eax
ffff8000001046c3:	75 28                	jne    ffff8000001046ed <cpunum+0x65>
      cprintf("cpu called from %x with interrupts enabled\n",
ffff8000001046c5:	48 8b 45 08          	mov    0x8(%rbp),%rax
ffff8000001046c9:	48 89 c2             	mov    %rax,%rdx
ffff8000001046cc:	48 b8 70 c2 10 00 00 	movabs $0xffff80000010c270,%rax
ffff8000001046d3:	80 ff ff 
ffff8000001046d6:	48 89 d6             	mov    %rdx,%rsi
ffff8000001046d9:	48 89 c7             	mov    %rax,%rdi
ffff8000001046dc:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001046e1:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff8000001046e8:	80 ff ff 
ffff8000001046eb:	ff d2                	call   *%rdx
        __builtin_return_address(0));
  }

  if (!lapic)
ffff8000001046ed:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff8000001046f4:	80 ff ff 
ffff8000001046f7:	48 8b 00             	mov    (%rax),%rax
ffff8000001046fa:	48 85 c0             	test   %rax,%rax
ffff8000001046fd:	75 0a                	jne    ffff800000104709 <cpunum+0x81>
    return 0;
ffff8000001046ff:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000104704:	e9 85 00 00 00       	jmp    ffff80000010478e <cpunum+0x106>

  apicid = lapic[ID] >> 24;
ffff800000104709:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff800000104710:	80 ff ff 
ffff800000104713:	48 8b 00             	mov    (%rax),%rax
ffff800000104716:	48 83 c0 20          	add    $0x20,%rax
ffff80000010471a:	8b 00                	mov    (%rax),%eax
ffff80000010471c:	c1 e8 18             	shr    $0x18,%eax
ffff80000010471f:	89 45 f8             	mov    %eax,-0x8(%rbp)
  for (i = 0; i < ncpu; ++i) {
ffff800000104722:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000104729:	eb 39                	jmp    ffff800000104764 <cpunum+0xdc>
    if (cpus[i].apicid == apicid)
ffff80000010472b:	48 b9 e0 72 11 00 00 	movabs $0xffff8000001172e0,%rcx
ffff800000104732:	80 ff ff 
ffff800000104735:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104738:	48 63 d0             	movslq %eax,%rdx
ffff80000010473b:	48 89 d0             	mov    %rdx,%rax
ffff80000010473e:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000104742:	48 01 d0             	add    %rdx,%rax
ffff800000104745:	48 c1 e0 03          	shl    $0x3,%rax
ffff800000104749:	48 01 c8             	add    %rcx,%rax
ffff80000010474c:	48 83 c0 01          	add    $0x1,%rax
ffff800000104750:	0f b6 00             	movzbl (%rax),%eax
ffff800000104753:	0f b6 c0             	movzbl %al,%eax
ffff800000104756:	39 45 f8             	cmp    %eax,-0x8(%rbp)
ffff800000104759:	75 05                	jne    ffff800000104760 <cpunum+0xd8>
      return i;
ffff80000010475b:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010475e:	eb 2e                	jmp    ffff80000010478e <cpunum+0x106>
  for (i = 0; i < ncpu; ++i) {
ffff800000104760:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000104764:	48 b8 20 74 11 00 00 	movabs $0xffff800000117420,%rax
ffff80000010476b:	80 ff ff 
ffff80000010476e:	8b 00                	mov    (%rax),%eax
ffff800000104770:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000104773:	7c b6                	jl     ffff80000010472b <cpunum+0xa3>
  }
  panic("unknown apicid\n");
ffff800000104775:	48 b8 9c c2 10 00 00 	movabs $0xffff80000010c29c,%rax
ffff80000010477c:	80 ff ff 
ffff80000010477f:	48 89 c7             	mov    %rax,%rdi
ffff800000104782:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000104789:	80 ff ff 
ffff80000010478c:	ff d0                	call   *%rax
}
ffff80000010478e:	c9                   	leave
ffff80000010478f:	c3                   	ret

ffff800000104790 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
ffff800000104790:	55                   	push   %rbp
ffff800000104791:	48 89 e5             	mov    %rsp,%rbp
  if(lapic)
ffff800000104794:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff80000010479b:	80 ff ff 
ffff80000010479e:	48 8b 00             	mov    (%rax),%rax
ffff8000001047a1:	48 85 c0             	test   %rax,%rax
ffff8000001047a4:	74 16                	je     ffff8000001047bc <lapiceoi+0x2c>
    lapicw(EOI, 0);
ffff8000001047a6:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001047ab:	bf 2c 00 00 00       	mov    $0x2c,%edi
ffff8000001047b0:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff8000001047b7:	80 ff ff 
ffff8000001047ba:	ff d0                	call   *%rax
}
ffff8000001047bc:	90                   	nop
ffff8000001047bd:	5d                   	pop    %rbp
ffff8000001047be:	c3                   	ret

ffff8000001047bf <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
ffff8000001047bf:	55                   	push   %rbp
ffff8000001047c0:	48 89 e5             	mov    %rsp,%rbp
ffff8000001047c3:	48 83 ec 08          	sub    $0x8,%rsp
ffff8000001047c7:	89 7d fc             	mov    %edi,-0x4(%rbp)
}
ffff8000001047ca:	90                   	nop
ffff8000001047cb:	c9                   	leave
ffff8000001047cc:	c3                   	ret

ffff8000001047cd <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
ffff8000001047cd:	55                   	push   %rbp
ffff8000001047ce:	48 89 e5             	mov    %rsp,%rbp
ffff8000001047d1:	48 83 ec 18          	sub    $0x18,%rsp
ffff8000001047d5:	89 f8                	mov    %edi,%eax
ffff8000001047d7:	89 75 e8             	mov    %esi,-0x18(%rbp)
ffff8000001047da:	88 45 ec             	mov    %al,-0x14(%rbp)
  ushort *wrv;

  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
ffff8000001047dd:	be 0f 00 00 00       	mov    $0xf,%esi
ffff8000001047e2:	bf 70 00 00 00       	mov    $0x70,%edi
ffff8000001047e7:	48 b8 84 44 10 00 00 	movabs $0xffff800000104484,%rax
ffff8000001047ee:	80 ff ff 
ffff8000001047f1:	ff d0                	call   *%rax
  outb(CMOS_PORT+1, 0x0A);
ffff8000001047f3:	be 0a 00 00 00       	mov    $0xa,%esi
ffff8000001047f8:	bf 71 00 00 00       	mov    $0x71,%edi
ffff8000001047fd:	48 b8 84 44 10 00 00 	movabs $0xffff800000104484,%rax
ffff800000104804:	80 ff ff 
ffff800000104807:	ff d0                	call   *%rax
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
ffff800000104809:	48 b8 67 04 00 00 00 	movabs $0xffff800000000467,%rax
ffff800000104810:	80 ff ff 
ffff800000104813:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  wrv[0] = 0;
ffff800000104817:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010481b:	66 c7 00 00 00       	movw   $0x0,(%rax)
  wrv[1] = addr >> 4;
ffff800000104820:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000104823:	c1 e8 04             	shr    $0x4,%eax
ffff800000104826:	89 c2                	mov    %eax,%edx
ffff800000104828:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010482c:	48 83 c0 02          	add    $0x2,%rax
ffff800000104830:	66 89 10             	mov    %dx,(%rax)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
ffff800000104833:	0f b6 45 ec          	movzbl -0x14(%rbp),%eax
ffff800000104837:	c1 e0 18             	shl    $0x18,%eax
ffff80000010483a:	89 c6                	mov    %eax,%esi
ffff80000010483c:	bf c4 00 00 00       	mov    $0xc4,%edi
ffff800000104841:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff800000104848:	80 ff ff 
ffff80000010484b:	ff d0                	call   *%rax
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
ffff80000010484d:	be 00 c5 00 00       	mov    $0xc500,%esi
ffff800000104852:	bf c0 00 00 00       	mov    $0xc0,%edi
ffff800000104857:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff80000010485e:	80 ff ff 
ffff800000104861:	ff d0                	call   *%rax
  microdelay(200);
ffff800000104863:	bf c8 00 00 00       	mov    $0xc8,%edi
ffff800000104868:	48 b8 bf 47 10 00 00 	movabs $0xffff8000001047bf,%rax
ffff80000010486f:	80 ff ff 
ffff800000104872:	ff d0                	call   *%rax
  lapicw(ICRLO, INIT | LEVEL);
ffff800000104874:	be 00 85 00 00       	mov    $0x8500,%esi
ffff800000104879:	bf c0 00 00 00       	mov    $0xc0,%edi
ffff80000010487e:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff800000104885:	80 ff ff 
ffff800000104888:	ff d0                	call   *%rax
  microdelay(100);    // should be 10ms, but too slow in Bochs!
ffff80000010488a:	bf 64 00 00 00       	mov    $0x64,%edi
ffff80000010488f:	48 b8 bf 47 10 00 00 	movabs $0xffff8000001047bf,%rax
ffff800000104896:	80 ff ff 
ffff800000104899:	ff d0                	call   *%rax
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
ffff80000010489b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001048a2:	eb 4b                	jmp    ffff8000001048ef <lapicstartap+0x122>
    lapicw(ICRHI, apicid<<24);
ffff8000001048a4:	0f b6 45 ec          	movzbl -0x14(%rbp),%eax
ffff8000001048a8:	c1 e0 18             	shl    $0x18,%eax
ffff8000001048ab:	89 c6                	mov    %eax,%esi
ffff8000001048ad:	bf c4 00 00 00       	mov    $0xc4,%edi
ffff8000001048b2:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff8000001048b9:	80 ff ff 
ffff8000001048bc:	ff d0                	call   *%rax
    lapicw(ICRLO, STARTUP | (addr>>12));
ffff8000001048be:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff8000001048c1:	c1 e8 0c             	shr    $0xc,%eax
ffff8000001048c4:	80 cc 06             	or     $0x6,%ah
ffff8000001048c7:	89 c6                	mov    %eax,%esi
ffff8000001048c9:	bf c0 00 00 00       	mov    $0xc0,%edi
ffff8000001048ce:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff8000001048d5:	80 ff ff 
ffff8000001048d8:	ff d0                	call   *%rax
    microdelay(200);
ffff8000001048da:	bf c8 00 00 00       	mov    $0xc8,%edi
ffff8000001048df:	48 b8 bf 47 10 00 00 	movabs $0xffff8000001047bf,%rax
ffff8000001048e6:	80 ff ff 
ffff8000001048e9:	ff d0                	call   *%rax
  for(i = 0; i < 2; i++){
ffff8000001048eb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001048ef:	83 7d fc 01          	cmpl   $0x1,-0x4(%rbp)
ffff8000001048f3:	7e af                	jle    ffff8000001048a4 <lapicstartap+0xd7>
  }
}
ffff8000001048f5:	90                   	nop
ffff8000001048f6:	90                   	nop
ffff8000001048f7:	c9                   	leave
ffff8000001048f8:	c3                   	ret

ffff8000001048f9 <cmos_read>:
#define DAY     0x07
#define MONTH   0x08
#define YEAR    0x09

static uint cmos_read(uint reg)
{
ffff8000001048f9:	55                   	push   %rbp
ffff8000001048fa:	48 89 e5             	mov    %rsp,%rbp
ffff8000001048fd:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000104901:	89 7d fc             	mov    %edi,-0x4(%rbp)
  outb(CMOS_PORT,  reg);
ffff800000104904:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104907:	0f b6 c0             	movzbl %al,%eax
ffff80000010490a:	89 c6                	mov    %eax,%esi
ffff80000010490c:	bf 70 00 00 00       	mov    $0x70,%edi
ffff800000104911:	48 b8 84 44 10 00 00 	movabs $0xffff800000104484,%rax
ffff800000104918:	80 ff ff 
ffff80000010491b:	ff d0                	call   *%rax
  microdelay(200);
ffff80000010491d:	bf c8 00 00 00       	mov    $0xc8,%edi
ffff800000104922:	48 b8 bf 47 10 00 00 	movabs $0xffff8000001047bf,%rax
ffff800000104929:	80 ff ff 
ffff80000010492c:	ff d0                	call   *%rax

  return inb(CMOS_RETURN);
ffff80000010492e:	bf 71 00 00 00       	mov    $0x71,%edi
ffff800000104933:	48 b8 66 44 10 00 00 	movabs $0xffff800000104466,%rax
ffff80000010493a:	80 ff ff 
ffff80000010493d:	ff d0                	call   *%rax
ffff80000010493f:	0f b6 c0             	movzbl %al,%eax
}
ffff800000104942:	c9                   	leave
ffff800000104943:	c3                   	ret

ffff800000104944 <fill_rtcdate>:

static void fill_rtcdate(struct rtcdate *r)
{
ffff800000104944:	55                   	push   %rbp
ffff800000104945:	48 89 e5             	mov    %rsp,%rbp
ffff800000104948:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010494c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  r->second = cmos_read(SECS);
ffff800000104950:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000104955:	48 b8 f9 48 10 00 00 	movabs $0xffff8000001048f9,%rax
ffff80000010495c:	80 ff ff 
ffff80000010495f:	ff d0                	call   *%rax
ffff800000104961:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000104965:	89 02                	mov    %eax,(%rdx)
  r->minute = cmos_read(MINS);
ffff800000104967:	bf 02 00 00 00       	mov    $0x2,%edi
ffff80000010496c:	48 b8 f9 48 10 00 00 	movabs $0xffff8000001048f9,%rax
ffff800000104973:	80 ff ff 
ffff800000104976:	ff d0                	call   *%rax
ffff800000104978:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010497c:	89 42 04             	mov    %eax,0x4(%rdx)
  r->hour   = cmos_read(HOURS);
ffff80000010497f:	bf 04 00 00 00       	mov    $0x4,%edi
ffff800000104984:	48 b8 f9 48 10 00 00 	movabs $0xffff8000001048f9,%rax
ffff80000010498b:	80 ff ff 
ffff80000010498e:	ff d0                	call   *%rax
ffff800000104990:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000104994:	89 42 08             	mov    %eax,0x8(%rdx)
  r->day    = cmos_read(DAY);
ffff800000104997:	bf 07 00 00 00       	mov    $0x7,%edi
ffff80000010499c:	48 b8 f9 48 10 00 00 	movabs $0xffff8000001048f9,%rax
ffff8000001049a3:	80 ff ff 
ffff8000001049a6:	ff d0                	call   *%rax
ffff8000001049a8:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001049ac:	89 42 0c             	mov    %eax,0xc(%rdx)
  r->month  = cmos_read(MONTH);
ffff8000001049af:	bf 08 00 00 00       	mov    $0x8,%edi
ffff8000001049b4:	48 b8 f9 48 10 00 00 	movabs $0xffff8000001048f9,%rax
ffff8000001049bb:	80 ff ff 
ffff8000001049be:	ff d0                	call   *%rax
ffff8000001049c0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001049c4:	89 42 10             	mov    %eax,0x10(%rdx)
  r->year   = cmos_read(YEAR);
ffff8000001049c7:	bf 09 00 00 00       	mov    $0x9,%edi
ffff8000001049cc:	48 b8 f9 48 10 00 00 	movabs $0xffff8000001048f9,%rax
ffff8000001049d3:	80 ff ff 
ffff8000001049d6:	ff d0                	call   *%rax
ffff8000001049d8:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001049dc:	89 42 14             	mov    %eax,0x14(%rdx)
}
ffff8000001049df:	90                   	nop
ffff8000001049e0:	c9                   	leave
ffff8000001049e1:	c3                   	ret

ffff8000001049e2 <cmostime>:
//PAGEBREAK!

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
ffff8000001049e2:	55                   	push   %rbp
ffff8000001049e3:	48 89 e5             	mov    %rsp,%rbp
ffff8000001049e6:	48 83 ec 50          	sub    $0x50,%rsp
ffff8000001049ea:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);
ffff8000001049ee:	bf 0b 00 00 00       	mov    $0xb,%edi
ffff8000001049f3:	48 b8 f9 48 10 00 00 	movabs $0xffff8000001048f9,%rax
ffff8000001049fa:	80 ff ff 
ffff8000001049fd:	ff d0                	call   *%rax
ffff8000001049ff:	89 45 fc             	mov    %eax,-0x4(%rbp)

  bcd = (sb & (1 << 2)) == 0;
ffff800000104a02:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104a05:	83 e0 04             	and    $0x4,%eax
ffff800000104a08:	c1 e8 02             	shr    $0x2,%eax
ffff800000104a0b:	83 e0 01             	and    $0x1,%eax
ffff800000104a0e:	83 f0 01             	xor    $0x1,%eax
ffff800000104a11:	0f b6 c0             	movzbl %al,%eax
ffff800000104a14:	89 45 f8             	mov    %eax,-0x8(%rbp)

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
ffff800000104a17:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff800000104a1b:	48 89 c7             	mov    %rax,%rdi
ffff800000104a1e:	48 b8 44 49 10 00 00 	movabs $0xffff800000104944,%rax
ffff800000104a25:	80 ff ff 
ffff800000104a28:	ff d0                	call   *%rax
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
ffff800000104a2a:	bf 0a 00 00 00       	mov    $0xa,%edi
ffff800000104a2f:	48 b8 f9 48 10 00 00 	movabs $0xffff8000001048f9,%rax
ffff800000104a36:	80 ff ff 
ffff800000104a39:	ff d0                	call   *%rax
ffff800000104a3b:	25 80 00 00 00       	and    $0x80,%eax
ffff800000104a40:	85 c0                	test   %eax,%eax
ffff800000104a42:	75 38                	jne    ffff800000104a7c <cmostime+0x9a>
        continue;
    fill_rtcdate(&t2);
ffff800000104a44:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
ffff800000104a48:	48 89 c7             	mov    %rax,%rdi
ffff800000104a4b:	48 b8 44 49 10 00 00 	movabs $0xffff800000104944,%rax
ffff800000104a52:	80 ff ff 
ffff800000104a55:	ff d0                	call   *%rax
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
ffff800000104a57:	48 8d 4d c0          	lea    -0x40(%rbp),%rcx
ffff800000104a5b:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff800000104a5f:	ba 18 00 00 00       	mov    $0x18,%edx
ffff800000104a64:	48 89 ce             	mov    %rcx,%rsi
ffff800000104a67:	48 89 c7             	mov    %rax,%rdi
ffff800000104a6a:	48 b8 64 7b 10 00 00 	movabs $0xffff800000107b64,%rax
ffff800000104a71:	80 ff ff 
ffff800000104a74:	ff d0                	call   *%rax
ffff800000104a76:	85 c0                	test   %eax,%eax
ffff800000104a78:	74 05                	je     ffff800000104a7f <cmostime+0x9d>
ffff800000104a7a:	eb 9b                	jmp    ffff800000104a17 <cmostime+0x35>
        continue;
ffff800000104a7c:	90                   	nop
    fill_rtcdate(&t1);
ffff800000104a7d:	eb 98                	jmp    ffff800000104a17 <cmostime+0x35>
      break;
ffff800000104a7f:	90                   	nop
  }

  // convert
  if(bcd) {
ffff800000104a80:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
ffff800000104a84:	0f 84 b4 00 00 00    	je     ffff800000104b3e <cmostime+0x15c>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
ffff800000104a8a:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff800000104a8d:	c1 e8 04             	shr    $0x4,%eax
ffff800000104a90:	89 c2                	mov    %eax,%edx
ffff800000104a92:	89 d0                	mov    %edx,%eax
ffff800000104a94:	c1 e0 02             	shl    $0x2,%eax
ffff800000104a97:	01 d0                	add    %edx,%eax
ffff800000104a99:	01 c0                	add    %eax,%eax
ffff800000104a9b:	89 c2                	mov    %eax,%edx
ffff800000104a9d:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff800000104aa0:	83 e0 0f             	and    $0xf,%eax
ffff800000104aa3:	01 d0                	add    %edx,%eax
ffff800000104aa5:	89 45 e0             	mov    %eax,-0x20(%rbp)
    CONV(minute);
ffff800000104aa8:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff800000104aab:	c1 e8 04             	shr    $0x4,%eax
ffff800000104aae:	89 c2                	mov    %eax,%edx
ffff800000104ab0:	89 d0                	mov    %edx,%eax
ffff800000104ab2:	c1 e0 02             	shl    $0x2,%eax
ffff800000104ab5:	01 d0                	add    %edx,%eax
ffff800000104ab7:	01 c0                	add    %eax,%eax
ffff800000104ab9:	89 c2                	mov    %eax,%edx
ffff800000104abb:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff800000104abe:	83 e0 0f             	and    $0xf,%eax
ffff800000104ac1:	01 d0                	add    %edx,%eax
ffff800000104ac3:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    CONV(hour  );
ffff800000104ac6:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000104ac9:	c1 e8 04             	shr    $0x4,%eax
ffff800000104acc:	89 c2                	mov    %eax,%edx
ffff800000104ace:	89 d0                	mov    %edx,%eax
ffff800000104ad0:	c1 e0 02             	shl    $0x2,%eax
ffff800000104ad3:	01 d0                	add    %edx,%eax
ffff800000104ad5:	01 c0                	add    %eax,%eax
ffff800000104ad7:	89 c2                	mov    %eax,%edx
ffff800000104ad9:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000104adc:	83 e0 0f             	and    $0xf,%eax
ffff800000104adf:	01 d0                	add    %edx,%eax
ffff800000104ae1:	89 45 e8             	mov    %eax,-0x18(%rbp)
    CONV(day   );
ffff800000104ae4:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000104ae7:	c1 e8 04             	shr    $0x4,%eax
ffff800000104aea:	89 c2                	mov    %eax,%edx
ffff800000104aec:	89 d0                	mov    %edx,%eax
ffff800000104aee:	c1 e0 02             	shl    $0x2,%eax
ffff800000104af1:	01 d0                	add    %edx,%eax
ffff800000104af3:	01 c0                	add    %eax,%eax
ffff800000104af5:	89 c2                	mov    %eax,%edx
ffff800000104af7:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000104afa:	83 e0 0f             	and    $0xf,%eax
ffff800000104afd:	01 d0                	add    %edx,%eax
ffff800000104aff:	89 45 ec             	mov    %eax,-0x14(%rbp)
    CONV(month );
ffff800000104b02:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000104b05:	c1 e8 04             	shr    $0x4,%eax
ffff800000104b08:	89 c2                	mov    %eax,%edx
ffff800000104b0a:	89 d0                	mov    %edx,%eax
ffff800000104b0c:	c1 e0 02             	shl    $0x2,%eax
ffff800000104b0f:	01 d0                	add    %edx,%eax
ffff800000104b11:	01 c0                	add    %eax,%eax
ffff800000104b13:	89 c2                	mov    %eax,%edx
ffff800000104b15:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000104b18:	83 e0 0f             	and    $0xf,%eax
ffff800000104b1b:	01 d0                	add    %edx,%eax
ffff800000104b1d:	89 45 f0             	mov    %eax,-0x10(%rbp)
    CONV(year  );
ffff800000104b20:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000104b23:	c1 e8 04             	shr    $0x4,%eax
ffff800000104b26:	89 c2                	mov    %eax,%edx
ffff800000104b28:	89 d0                	mov    %edx,%eax
ffff800000104b2a:	c1 e0 02             	shl    $0x2,%eax
ffff800000104b2d:	01 d0                	add    %edx,%eax
ffff800000104b2f:	01 c0                	add    %eax,%eax
ffff800000104b31:	89 c2                	mov    %eax,%edx
ffff800000104b33:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000104b36:	83 e0 0f             	and    $0xf,%eax
ffff800000104b39:	01 d0                	add    %edx,%eax
ffff800000104b3b:	89 45 f4             	mov    %eax,-0xc(%rbp)
#undef     CONV
  }

  *r = t1;
ffff800000104b3e:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
ffff800000104b42:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000104b46:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000104b4a:	48 89 01             	mov    %rax,(%rcx)
ffff800000104b4d:	48 89 51 08          	mov    %rdx,0x8(%rcx)
ffff800000104b51:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104b55:	48 89 41 10          	mov    %rax,0x10(%rcx)
  r->year += 2000;
ffff800000104b59:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000104b5d:	8b 40 14             	mov    0x14(%rax),%eax
ffff800000104b60:	8d 90 d0 07 00 00    	lea    0x7d0(%rax),%edx
ffff800000104b66:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000104b6a:	89 50 14             	mov    %edx,0x14(%rax)
}
ffff800000104b6d:	90                   	nop
ffff800000104b6e:	c9                   	leave
ffff800000104b6f:	c3                   	ret

ffff800000104b70 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
ffff800000104b70:	55                   	push   %rbp
ffff800000104b71:	48 89 e5             	mov    %rsp,%rbp
ffff800000104b74:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000104b78:	89 7d dc             	mov    %edi,-0x24(%rbp)
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
ffff800000104b7b:	48 ba ac c2 10 00 00 	movabs $0xffff80000010c2ac,%rdx
ffff800000104b82:	80 ff ff 
ffff800000104b85:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104b8c:	80 ff ff 
ffff800000104b8f:	48 89 d6             	mov    %rdx,%rsi
ffff800000104b92:	48 89 c7             	mov    %rax,%rdi
ffff800000104b95:	48 b8 05 77 10 00 00 	movabs $0xffff800000107705,%rax
ffff800000104b9c:	80 ff ff 
ffff800000104b9f:	ff d0                	call   *%rax
  readsb(dev, &sb);
ffff800000104ba1:	48 8d 55 e0          	lea    -0x20(%rbp),%rdx
ffff800000104ba5:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000104ba8:	48 89 d6             	mov    %rdx,%rsi
ffff800000104bab:	89 c7                	mov    %eax,%edi
ffff800000104bad:	48 b8 91 20 10 00 00 	movabs $0xffff800000102091,%rax
ffff800000104bb4:	80 ff ff 
ffff800000104bb7:	ff d0                	call   *%rax
  log.start = sb.logstart;
ffff800000104bb9:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000104bbc:	89 c2                	mov    %eax,%edx
ffff800000104bbe:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104bc5:	80 ff ff 
ffff800000104bc8:	89 50 68             	mov    %edx,0x68(%rax)
  log.size = sb.nlog;
ffff800000104bcb:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000104bce:	89 c2                	mov    %eax,%edx
ffff800000104bd0:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104bd7:	80 ff ff 
ffff800000104bda:	89 50 6c             	mov    %edx,0x6c(%rax)
  log.dev = dev;
ffff800000104bdd:	48 ba e0 71 11 00 00 	movabs $0xffff8000001171e0,%rdx
ffff800000104be4:	80 ff ff 
ffff800000104be7:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000104bea:	89 42 78             	mov    %eax,0x78(%rdx)
  recover_from_log();
ffff800000104bed:	48 b8 81 4e 10 00 00 	movabs $0xffff800000104e81,%rax
ffff800000104bf4:	80 ff ff 
ffff800000104bf7:	ff d0                	call   *%rax
}
ffff800000104bf9:	90                   	nop
ffff800000104bfa:	c9                   	leave
ffff800000104bfb:	c3                   	ret

ffff800000104bfc <install_trans>:

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
ffff800000104bfc:	55                   	push   %rbp
ffff800000104bfd:	48 89 e5             	mov    %rsp,%rbp
ffff800000104c00:	48 83 ec 20          	sub    $0x20,%rsp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
ffff800000104c04:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000104c0b:	e9 dc 00 00 00       	jmp    ffff800000104cec <install_trans+0xf0>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
ffff800000104c10:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104c17:	80 ff ff 
ffff800000104c1a:	8b 50 68             	mov    0x68(%rax),%edx
ffff800000104c1d:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104c20:	01 d0                	add    %edx,%eax
ffff800000104c22:	83 c0 01             	add    $0x1,%eax
ffff800000104c25:	89 c2                	mov    %eax,%edx
ffff800000104c27:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104c2e:	80 ff ff 
ffff800000104c31:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000104c34:	89 d6                	mov    %edx,%esi
ffff800000104c36:	89 c7                	mov    %eax,%edi
ffff800000104c38:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000104c3f:	80 ff ff 
ffff800000104c42:	ff d0                	call   *%rax
ffff800000104c44:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
ffff800000104c48:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104c4f:	80 ff ff 
ffff800000104c52:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000104c55:	48 63 d2             	movslq %edx,%rdx
ffff800000104c58:	48 83 c2 1c          	add    $0x1c,%rdx
ffff800000104c5c:	8b 44 90 10          	mov    0x10(%rax,%rdx,4),%eax
ffff800000104c60:	89 c2                	mov    %eax,%edx
ffff800000104c62:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104c69:	80 ff ff 
ffff800000104c6c:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000104c6f:	89 d6                	mov    %edx,%esi
ffff800000104c71:	89 c7                	mov    %eax,%edi
ffff800000104c73:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000104c7a:	80 ff ff 
ffff800000104c7d:	ff d0                	call   *%rax
ffff800000104c7f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
ffff800000104c83:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104c87:	48 8d 88 b0 00 00 00 	lea    0xb0(%rax),%rcx
ffff800000104c8e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104c92:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000104c98:	ba 00 02 00 00       	mov    $0x200,%edx
ffff800000104c9d:	48 89 ce             	mov    %rcx,%rsi
ffff800000104ca0:	48 89 c7             	mov    %rax,%rdi
ffff800000104ca3:	48 b8 d3 7b 10 00 00 	movabs $0xffff800000107bd3,%rax
ffff800000104caa:	80 ff ff 
ffff800000104cad:	ff d0                	call   *%rax
    bwrite(dbuf);  // write dst to disk
ffff800000104caf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104cb3:	48 89 c7             	mov    %rax,%rdi
ffff800000104cb6:	48 b8 1a 04 10 00 00 	movabs $0xffff80000010041a,%rax
ffff800000104cbd:	80 ff ff 
ffff800000104cc0:	ff d0                	call   *%rax
    brelse(lbuf);
ffff800000104cc2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104cc6:	48 89 c7             	mov    %rax,%rdi
ffff800000104cc9:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000104cd0:	80 ff ff 
ffff800000104cd3:	ff d0                	call   *%rax
    brelse(dbuf);
ffff800000104cd5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104cd9:	48 89 c7             	mov    %rax,%rdi
ffff800000104cdc:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000104ce3:	80 ff ff 
ffff800000104ce6:	ff d0                	call   *%rax
  for (tail = 0; tail < log.lh.n; tail++) {
ffff800000104ce8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000104cec:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104cf3:	80 ff ff 
ffff800000104cf6:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000104cf9:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000104cfc:	0f 8c 0e ff ff ff    	jl     ffff800000104c10 <install_trans+0x14>
  }
}
ffff800000104d02:	90                   	nop
ffff800000104d03:	90                   	nop
ffff800000104d04:	c9                   	leave
ffff800000104d05:	c3                   	ret

ffff800000104d06 <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
ffff800000104d06:	55                   	push   %rbp
ffff800000104d07:	48 89 e5             	mov    %rsp,%rbp
ffff800000104d0a:	48 83 ec 20          	sub    $0x20,%rsp
  struct buf *buf = bread(log.dev, log.start);
ffff800000104d0e:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104d15:	80 ff ff 
ffff800000104d18:	8b 40 68             	mov    0x68(%rax),%eax
ffff800000104d1b:	89 c2                	mov    %eax,%edx
ffff800000104d1d:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104d24:	80 ff ff 
ffff800000104d27:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000104d2a:	89 d6                	mov    %edx,%esi
ffff800000104d2c:	89 c7                	mov    %eax,%edi
ffff800000104d2e:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000104d35:	80 ff ff 
ffff800000104d38:	ff d0                	call   *%rax
ffff800000104d3a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  struct logheader *lh = (struct logheader *) (buf->data);
ffff800000104d3e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104d42:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000104d48:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  int i;
  log.lh.n = lh->n;
ffff800000104d4c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104d50:	8b 00                	mov    (%rax),%eax
ffff800000104d52:	48 ba e0 71 11 00 00 	movabs $0xffff8000001171e0,%rdx
ffff800000104d59:	80 ff ff 
ffff800000104d5c:	89 42 7c             	mov    %eax,0x7c(%rdx)
  for (i = 0; i < log.lh.n; i++) {
ffff800000104d5f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000104d66:	eb 2a                	jmp    ffff800000104d92 <read_head+0x8c>
    log.lh.block[i] = lh->block[i];
ffff800000104d68:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104d6c:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000104d6f:	48 63 d2             	movslq %edx,%rdx
ffff800000104d72:	8b 44 90 04          	mov    0x4(%rax,%rdx,4),%eax
ffff800000104d76:	48 ba e0 71 11 00 00 	movabs $0xffff8000001171e0,%rdx
ffff800000104d7d:	80 ff ff 
ffff800000104d80:	8b 4d fc             	mov    -0x4(%rbp),%ecx
ffff800000104d83:	48 63 c9             	movslq %ecx,%rcx
ffff800000104d86:	48 83 c1 1c          	add    $0x1c,%rcx
ffff800000104d8a:	89 44 8a 10          	mov    %eax,0x10(%rdx,%rcx,4)
  for (i = 0; i < log.lh.n; i++) {
ffff800000104d8e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000104d92:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104d99:	80 ff ff 
ffff800000104d9c:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000104d9f:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000104da2:	7c c4                	jl     ffff800000104d68 <read_head+0x62>
  }
  brelse(buf);
ffff800000104da4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104da8:	48 89 c7             	mov    %rax,%rdi
ffff800000104dab:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000104db2:	80 ff ff 
ffff800000104db5:	ff d0                	call   *%rax
}
ffff800000104db7:	90                   	nop
ffff800000104db8:	c9                   	leave
ffff800000104db9:	c3                   	ret

ffff800000104dba <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
ffff800000104dba:	55                   	push   %rbp
ffff800000104dbb:	48 89 e5             	mov    %rsp,%rbp
ffff800000104dbe:	48 83 ec 20          	sub    $0x20,%rsp
  struct buf *buf = bread(log.dev, log.start);
ffff800000104dc2:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104dc9:	80 ff ff 
ffff800000104dcc:	8b 40 68             	mov    0x68(%rax),%eax
ffff800000104dcf:	89 c2                	mov    %eax,%edx
ffff800000104dd1:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104dd8:	80 ff ff 
ffff800000104ddb:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000104dde:	89 d6                	mov    %edx,%esi
ffff800000104de0:	89 c7                	mov    %eax,%edi
ffff800000104de2:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000104de9:	80 ff ff 
ffff800000104dec:	ff d0                	call   *%rax
ffff800000104dee:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  struct logheader *hb = (struct logheader *) (buf->data);
ffff800000104df2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104df6:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000104dfc:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  int i;
  hb->n = log.lh.n;
ffff800000104e00:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104e07:	80 ff ff 
ffff800000104e0a:	8b 50 7c             	mov    0x7c(%rax),%edx
ffff800000104e0d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104e11:	89 10                	mov    %edx,(%rax)
  for (i = 0; i < log.lh.n; i++) {
ffff800000104e13:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000104e1a:	eb 2a                	jmp    ffff800000104e46 <write_head+0x8c>
    hb->block[i] = log.lh.block[i];
ffff800000104e1c:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104e23:	80 ff ff 
ffff800000104e26:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000104e29:	48 63 d2             	movslq %edx,%rdx
ffff800000104e2c:	48 83 c2 1c          	add    $0x1c,%rdx
ffff800000104e30:	8b 4c 90 10          	mov    0x10(%rax,%rdx,4),%ecx
ffff800000104e34:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104e38:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000104e3b:	48 63 d2             	movslq %edx,%rdx
ffff800000104e3e:	89 4c 90 04          	mov    %ecx,0x4(%rax,%rdx,4)
  for (i = 0; i < log.lh.n; i++) {
ffff800000104e42:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000104e46:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104e4d:	80 ff ff 
ffff800000104e50:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000104e53:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000104e56:	7c c4                	jl     ffff800000104e1c <write_head+0x62>
  }
  bwrite(buf);
ffff800000104e58:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104e5c:	48 89 c7             	mov    %rax,%rdi
ffff800000104e5f:	48 b8 1a 04 10 00 00 	movabs $0xffff80000010041a,%rax
ffff800000104e66:	80 ff ff 
ffff800000104e69:	ff d0                	call   *%rax
  brelse(buf);
ffff800000104e6b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104e6f:	48 89 c7             	mov    %rax,%rdi
ffff800000104e72:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000104e79:	80 ff ff 
ffff800000104e7c:	ff d0                	call   *%rax
}
ffff800000104e7e:	90                   	nop
ffff800000104e7f:	c9                   	leave
ffff800000104e80:	c3                   	ret

ffff800000104e81 <recover_from_log>:

static void
recover_from_log(void)
{
ffff800000104e81:	55                   	push   %rbp
ffff800000104e82:	48 89 e5             	mov    %rsp,%rbp
  read_head();
ffff800000104e85:	48 b8 06 4d 10 00 00 	movabs $0xffff800000104d06,%rax
ffff800000104e8c:	80 ff ff 
ffff800000104e8f:	ff d0                	call   *%rax
  install_trans(); // if committed, copy from log to disk
ffff800000104e91:	48 b8 fc 4b 10 00 00 	movabs $0xffff800000104bfc,%rax
ffff800000104e98:	80 ff ff 
ffff800000104e9b:	ff d0                	call   *%rax
  log.lh.n = 0;
ffff800000104e9d:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104ea4:	80 ff ff 
ffff800000104ea7:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%rax)
  write_head(); // clear the log
ffff800000104eae:	48 b8 ba 4d 10 00 00 	movabs $0xffff800000104dba,%rax
ffff800000104eb5:	80 ff ff 
ffff800000104eb8:	ff d0                	call   *%rax
}
ffff800000104eba:	90                   	nop
ffff800000104ebb:	5d                   	pop    %rbp
ffff800000104ebc:	c3                   	ret

ffff800000104ebd <begin_op>:

// called at the start of each FS system call.
void
begin_op(void)
{
ffff800000104ebd:	55                   	push   %rbp
ffff800000104ebe:	48 89 e5             	mov    %rsp,%rbp
  acquire(&log.lock);
ffff800000104ec1:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104ec8:	80 ff ff 
ffff800000104ecb:	48 89 c7             	mov    %rax,%rdi
ffff800000104ece:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff800000104ed5:	80 ff ff 
ffff800000104ed8:	ff d0                	call   *%rax
  while(1){
    if(log.committing){
ffff800000104eda:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104ee1:	80 ff ff 
ffff800000104ee4:	8b 40 74             	mov    0x74(%rax),%eax
ffff800000104ee7:	85 c0                	test   %eax,%eax
ffff800000104ee9:	74 28                	je     ffff800000104f13 <begin_op+0x56>
      sleep(&log, &log.lock);
ffff800000104eeb:	48 ba e0 71 11 00 00 	movabs $0xffff8000001171e0,%rdx
ffff800000104ef2:	80 ff ff 
ffff800000104ef5:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104efc:	80 ff ff 
ffff800000104eff:	48 89 d6             	mov    %rdx,%rsi
ffff800000104f02:	48 89 c7             	mov    %rax,%rdi
ffff800000104f05:	48 b8 51 6e 10 00 00 	movabs $0xffff800000106e51,%rax
ffff800000104f0c:	80 ff ff 
ffff800000104f0f:	ff d0                	call   *%rax
ffff800000104f11:	eb c7                	jmp    ffff800000104eda <begin_op+0x1d>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
ffff800000104f13:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104f1a:	80 ff ff 
ffff800000104f1d:	8b 48 7c             	mov    0x7c(%rax),%ecx
ffff800000104f20:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104f27:	80 ff ff 
ffff800000104f2a:	8b 40 70             	mov    0x70(%rax),%eax
ffff800000104f2d:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000104f30:	89 d0                	mov    %edx,%eax
ffff800000104f32:	c1 e0 02             	shl    $0x2,%eax
ffff800000104f35:	01 d0                	add    %edx,%eax
ffff800000104f37:	01 c0                	add    %eax,%eax
ffff800000104f39:	01 c8                	add    %ecx,%eax
ffff800000104f3b:	83 f8 1e             	cmp    $0x1e,%eax
ffff800000104f3e:	7e 2b                	jle    ffff800000104f6b <begin_op+0xae>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
ffff800000104f40:	48 ba e0 71 11 00 00 	movabs $0xffff8000001171e0,%rdx
ffff800000104f47:	80 ff ff 
ffff800000104f4a:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104f51:	80 ff ff 
ffff800000104f54:	48 89 d6             	mov    %rdx,%rsi
ffff800000104f57:	48 89 c7             	mov    %rax,%rdi
ffff800000104f5a:	48 b8 51 6e 10 00 00 	movabs $0xffff800000106e51,%rax
ffff800000104f61:	80 ff ff 
ffff800000104f64:	ff d0                	call   *%rax
ffff800000104f66:	e9 6f ff ff ff       	jmp    ffff800000104eda <begin_op+0x1d>
    } else {
      log.outstanding += 1;
ffff800000104f6b:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104f72:	80 ff ff 
ffff800000104f75:	8b 40 70             	mov    0x70(%rax),%eax
ffff800000104f78:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000104f7b:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104f82:	80 ff ff 
ffff800000104f85:	89 50 70             	mov    %edx,0x70(%rax)
      release(&log.lock);
ffff800000104f88:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104f8f:	80 ff ff 
ffff800000104f92:	48 89 c7             	mov    %rax,%rdi
ffff800000104f95:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000104f9c:	80 ff ff 
ffff800000104f9f:	ff d0                	call   *%rax
      break;
ffff800000104fa1:	90                   	nop
    }
  }
}
ffff800000104fa2:	90                   	nop
ffff800000104fa3:	5d                   	pop    %rbp
ffff800000104fa4:	c3                   	ret

ffff800000104fa5 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
ffff800000104fa5:	55                   	push   %rbp
ffff800000104fa6:	48 89 e5             	mov    %rsp,%rbp
ffff800000104fa9:	48 83 ec 10          	sub    $0x10,%rsp
  int do_commit = 0;
ffff800000104fad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)

  acquire(&log.lock);
ffff800000104fb4:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104fbb:	80 ff ff 
ffff800000104fbe:	48 89 c7             	mov    %rax,%rdi
ffff800000104fc1:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff800000104fc8:	80 ff ff 
ffff800000104fcb:	ff d0                	call   *%rax
  log.outstanding -= 1;
ffff800000104fcd:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104fd4:	80 ff ff 
ffff800000104fd7:	8b 40 70             	mov    0x70(%rax),%eax
ffff800000104fda:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000104fdd:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104fe4:	80 ff ff 
ffff800000104fe7:	89 50 70             	mov    %edx,0x70(%rax)
  if(log.committing)
ffff800000104fea:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104ff1:	80 ff ff 
ffff800000104ff4:	8b 40 74             	mov    0x74(%rax),%eax
ffff800000104ff7:	85 c0                	test   %eax,%eax
ffff800000104ff9:	74 19                	je     ffff800000105014 <end_op+0x6f>
    panic("log.committing");
ffff800000104ffb:	48 b8 b0 c2 10 00 00 	movabs $0xffff80000010c2b0,%rax
ffff800000105002:	80 ff ff 
ffff800000105005:	48 89 c7             	mov    %rax,%rdi
ffff800000105008:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010500f:	80 ff ff 
ffff800000105012:	ff d0                	call   *%rax
  if(log.outstanding == 0){
ffff800000105014:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010501b:	80 ff ff 
ffff80000010501e:	8b 40 70             	mov    0x70(%rax),%eax
ffff800000105021:	85 c0                	test   %eax,%eax
ffff800000105023:	75 1a                	jne    ffff80000010503f <end_op+0x9a>
    do_commit = 1;
ffff800000105025:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
    log.committing = 1;
ffff80000010502c:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105033:	80 ff ff 
ffff800000105036:	c7 40 74 01 00 00 00 	movl   $0x1,0x74(%rax)
ffff80000010503d:	eb 19                	jmp    ffff800000105058 <end_op+0xb3>
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
ffff80000010503f:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105046:	80 ff ff 
ffff800000105049:	48 89 c7             	mov    %rax,%rdi
ffff80000010504c:	48 b8 c6 6f 10 00 00 	movabs $0xffff800000106fc6,%rax
ffff800000105053:	80 ff ff 
ffff800000105056:	ff d0                	call   *%rax
  }
  release(&log.lock);
ffff800000105058:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010505f:	80 ff ff 
ffff800000105062:	48 89 c7             	mov    %rax,%rdi
ffff800000105065:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff80000010506c:	80 ff ff 
ffff80000010506f:	ff d0                	call   *%rax

  if(do_commit){
ffff800000105071:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000105075:	74 68                	je     ffff8000001050df <end_op+0x13a>
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
ffff800000105077:	48 b8 ec 51 10 00 00 	movabs $0xffff8000001051ec,%rax
ffff80000010507e:	80 ff ff 
ffff800000105081:	ff d0                	call   *%rax
    acquire(&log.lock);
ffff800000105083:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010508a:	80 ff ff 
ffff80000010508d:	48 89 c7             	mov    %rax,%rdi
ffff800000105090:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff800000105097:	80 ff ff 
ffff80000010509a:	ff d0                	call   *%rax
    log.committing = 0;
ffff80000010509c:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001050a3:	80 ff ff 
ffff8000001050a6:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%rax)
    wakeup(&log);
ffff8000001050ad:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001050b4:	80 ff ff 
ffff8000001050b7:	48 89 c7             	mov    %rax,%rdi
ffff8000001050ba:	48 b8 c6 6f 10 00 00 	movabs $0xffff800000106fc6,%rax
ffff8000001050c1:	80 ff ff 
ffff8000001050c4:	ff d0                	call   *%rax
    release(&log.lock);
ffff8000001050c6:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001050cd:	80 ff ff 
ffff8000001050d0:	48 89 c7             	mov    %rax,%rdi
ffff8000001050d3:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff8000001050da:	80 ff ff 
ffff8000001050dd:	ff d0                	call   *%rax
  }
}
ffff8000001050df:	90                   	nop
ffff8000001050e0:	c9                   	leave
ffff8000001050e1:	c3                   	ret

ffff8000001050e2 <write_log>:

// Copy modified blocks from cache to log.
static void
write_log(void)
{
ffff8000001050e2:	55                   	push   %rbp
ffff8000001050e3:	48 89 e5             	mov    %rsp,%rbp
ffff8000001050e6:	48 83 ec 20          	sub    $0x20,%rsp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
ffff8000001050ea:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001050f1:	e9 dc 00 00 00       	jmp    ffff8000001051d2 <write_log+0xf0>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
ffff8000001050f6:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001050fd:	80 ff ff 
ffff800000105100:	8b 50 68             	mov    0x68(%rax),%edx
ffff800000105103:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000105106:	01 d0                	add    %edx,%eax
ffff800000105108:	83 c0 01             	add    $0x1,%eax
ffff80000010510b:	89 c2                	mov    %eax,%edx
ffff80000010510d:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105114:	80 ff ff 
ffff800000105117:	8b 40 78             	mov    0x78(%rax),%eax
ffff80000010511a:	89 d6                	mov    %edx,%esi
ffff80000010511c:	89 c7                	mov    %eax,%edi
ffff80000010511e:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000105125:	80 ff ff 
ffff800000105128:	ff d0                	call   *%rax
ffff80000010512a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
ffff80000010512e:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105135:	80 ff ff 
ffff800000105138:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010513b:	48 63 d2             	movslq %edx,%rdx
ffff80000010513e:	48 83 c2 1c          	add    $0x1c,%rdx
ffff800000105142:	8b 44 90 10          	mov    0x10(%rax,%rdx,4),%eax
ffff800000105146:	89 c2                	mov    %eax,%edx
ffff800000105148:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010514f:	80 ff ff 
ffff800000105152:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000105155:	89 d6                	mov    %edx,%esi
ffff800000105157:	89 c7                	mov    %eax,%edi
ffff800000105159:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000105160:	80 ff ff 
ffff800000105163:	ff d0                	call   *%rax
ffff800000105165:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    memmove(to->data, from->data, BSIZE);
ffff800000105169:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010516d:	48 8d 88 b0 00 00 00 	lea    0xb0(%rax),%rcx
ffff800000105174:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105178:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff80000010517e:	ba 00 02 00 00       	mov    $0x200,%edx
ffff800000105183:	48 89 ce             	mov    %rcx,%rsi
ffff800000105186:	48 89 c7             	mov    %rax,%rdi
ffff800000105189:	48 b8 d3 7b 10 00 00 	movabs $0xffff800000107bd3,%rax
ffff800000105190:	80 ff ff 
ffff800000105193:	ff d0                	call   *%rax
    bwrite(to);  // write the log
ffff800000105195:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105199:	48 89 c7             	mov    %rax,%rdi
ffff80000010519c:	48 b8 1a 04 10 00 00 	movabs $0xffff80000010041a,%rax
ffff8000001051a3:	80 ff ff 
ffff8000001051a6:	ff d0                	call   *%rax
    brelse(from);
ffff8000001051a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001051ac:	48 89 c7             	mov    %rax,%rdi
ffff8000001051af:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff8000001051b6:	80 ff ff 
ffff8000001051b9:	ff d0                	call   *%rax
    brelse(to);
ffff8000001051bb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001051bf:	48 89 c7             	mov    %rax,%rdi
ffff8000001051c2:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff8000001051c9:	80 ff ff 
ffff8000001051cc:	ff d0                	call   *%rax
  for (tail = 0; tail < log.lh.n; tail++) {
ffff8000001051ce:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001051d2:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001051d9:	80 ff ff 
ffff8000001051dc:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff8000001051df:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff8000001051e2:	0f 8c 0e ff ff ff    	jl     ffff8000001050f6 <write_log+0x14>
  }
}
ffff8000001051e8:	90                   	nop
ffff8000001051e9:	90                   	nop
ffff8000001051ea:	c9                   	leave
ffff8000001051eb:	c3                   	ret

ffff8000001051ec <commit>:

static void
commit()
{
ffff8000001051ec:	55                   	push   %rbp
ffff8000001051ed:	48 89 e5             	mov    %rsp,%rbp
  if (log.lh.n > 0) {
ffff8000001051f0:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001051f7:	80 ff ff 
ffff8000001051fa:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff8000001051fd:	85 c0                	test   %eax,%eax
ffff8000001051ff:	7e 41                	jle    ffff800000105242 <commit+0x56>
    write_log();     // Write modified blocks from cache to log
ffff800000105201:	48 b8 e2 50 10 00 00 	movabs $0xffff8000001050e2,%rax
ffff800000105208:	80 ff ff 
ffff80000010520b:	ff d0                	call   *%rax
    write_head();    // Write header to disk -- the real commit
ffff80000010520d:	48 b8 ba 4d 10 00 00 	movabs $0xffff800000104dba,%rax
ffff800000105214:	80 ff ff 
ffff800000105217:	ff d0                	call   *%rax
    install_trans(); // Now install writes to home locations
ffff800000105219:	48 b8 fc 4b 10 00 00 	movabs $0xffff800000104bfc,%rax
ffff800000105220:	80 ff ff 
ffff800000105223:	ff d0                	call   *%rax
    log.lh.n = 0;
ffff800000105225:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010522c:	80 ff ff 
ffff80000010522f:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%rax)
    write_head();    // Erase the transaction from the log
ffff800000105236:	48 b8 ba 4d 10 00 00 	movabs $0xffff800000104dba,%rax
ffff80000010523d:	80 ff ff 
ffff800000105240:	ff d0                	call   *%rax
  }
}
ffff800000105242:	90                   	nop
ffff800000105243:	5d                   	pop    %rbp
ffff800000105244:	c3                   	ret

ffff800000105245 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
ffff800000105245:	55                   	push   %rbp
ffff800000105246:	48 89 e5             	mov    %rsp,%rbp
ffff800000105249:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010524d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
ffff800000105251:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105258:	80 ff ff 
ffff80000010525b:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff80000010525e:	83 f8 1d             	cmp    $0x1d,%eax
ffff800000105261:	7f 21                	jg     ffff800000105284 <log_write+0x3f>
ffff800000105263:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010526a:	80 ff ff 
ffff80000010526d:	8b 50 7c             	mov    0x7c(%rax),%edx
ffff800000105270:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105277:	80 ff ff 
ffff80000010527a:	8b 40 6c             	mov    0x6c(%rax),%eax
ffff80000010527d:	83 e8 01             	sub    $0x1,%eax
ffff800000105280:	39 c2                	cmp    %eax,%edx
ffff800000105282:	7c 19                	jl     ffff80000010529d <log_write+0x58>
    panic("too big a transaction");
ffff800000105284:	48 b8 bf c2 10 00 00 	movabs $0xffff80000010c2bf,%rax
ffff80000010528b:	80 ff ff 
ffff80000010528e:	48 89 c7             	mov    %rax,%rdi
ffff800000105291:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000105298:	80 ff ff 
ffff80000010529b:	ff d0                	call   *%rax
  if (log.outstanding < 1)
ffff80000010529d:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001052a4:	80 ff ff 
ffff8000001052a7:	8b 40 70             	mov    0x70(%rax),%eax
ffff8000001052aa:	85 c0                	test   %eax,%eax
ffff8000001052ac:	7f 19                	jg     ffff8000001052c7 <log_write+0x82>
    panic("log_write outside of trans");
ffff8000001052ae:	48 b8 d5 c2 10 00 00 	movabs $0xffff80000010c2d5,%rax
ffff8000001052b5:	80 ff ff 
ffff8000001052b8:	48 89 c7             	mov    %rax,%rdi
ffff8000001052bb:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001052c2:	80 ff ff 
ffff8000001052c5:	ff d0                	call   *%rax

  acquire(&log.lock);
ffff8000001052c7:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001052ce:	80 ff ff 
ffff8000001052d1:	48 89 c7             	mov    %rax,%rdi
ffff8000001052d4:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff8000001052db:	80 ff ff 
ffff8000001052de:	ff d0                	call   *%rax
  for (i = 0; i < log.lh.n; i++) {
ffff8000001052e0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001052e7:	eb 29                	jmp    ffff800000105312 <log_write+0xcd>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
ffff8000001052e9:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001052f0:	80 ff ff 
ffff8000001052f3:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001052f6:	48 63 d2             	movslq %edx,%rdx
ffff8000001052f9:	48 83 c2 1c          	add    $0x1c,%rdx
ffff8000001052fd:	8b 44 90 10          	mov    0x10(%rax,%rdx,4),%eax
ffff800000105301:	89 c2                	mov    %eax,%edx
ffff800000105303:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105307:	8b 40 08             	mov    0x8(%rax),%eax
ffff80000010530a:	39 c2                	cmp    %eax,%edx
ffff80000010530c:	74 18                	je     ffff800000105326 <log_write+0xe1>
  for (i = 0; i < log.lh.n; i++) {
ffff80000010530e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000105312:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105319:	80 ff ff 
ffff80000010531c:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff80000010531f:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000105322:	7c c5                	jl     ffff8000001052e9 <log_write+0xa4>
ffff800000105324:	eb 01                	jmp    ffff800000105327 <log_write+0xe2>
      break;
ffff800000105326:	90                   	nop
  }
  log.lh.block[i] = b->blockno;
ffff800000105327:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010532b:	8b 40 08             	mov    0x8(%rax),%eax
ffff80000010532e:	89 c1                	mov    %eax,%ecx
ffff800000105330:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105337:	80 ff ff 
ffff80000010533a:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010533d:	48 63 d2             	movslq %edx,%rdx
ffff800000105340:	48 83 c2 1c          	add    $0x1c,%rdx
ffff800000105344:	89 4c 90 10          	mov    %ecx,0x10(%rax,%rdx,4)
  if (i == log.lh.n)
ffff800000105348:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010534f:	80 ff ff 
ffff800000105352:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000105355:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000105358:	75 1d                	jne    ffff800000105377 <log_write+0x132>
    log.lh.n++;
ffff80000010535a:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105361:	80 ff ff 
ffff800000105364:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000105367:	8d 50 01             	lea    0x1(%rax),%edx
ffff80000010536a:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105371:	80 ff ff 
ffff800000105374:	89 50 7c             	mov    %edx,0x7c(%rax)
  b->flags |= B_DIRTY; // prevent eviction
ffff800000105377:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010537b:	8b 00                	mov    (%rax),%eax
ffff80000010537d:	83 c8 04             	or     $0x4,%eax
ffff800000105380:	89 c2                	mov    %eax,%edx
ffff800000105382:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105386:	89 10                	mov    %edx,(%rax)
  release(&log.lock);
ffff800000105388:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010538f:	80 ff ff 
ffff800000105392:	48 89 c7             	mov    %rax,%rdi
ffff800000105395:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff80000010539c:	80 ff ff 
ffff80000010539f:	ff d0                	call   *%rax
}
ffff8000001053a1:	90                   	nop
ffff8000001053a2:	c9                   	leave
ffff8000001053a3:	c3                   	ret

ffff8000001053a4 <v2p>:
#define KERNBASE 0xFFFF800000000000 // First kernel virtual address

#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__
static inline addr_t v2p(void *a) {
ffff8000001053a4:	55                   	push   %rbp
ffff8000001053a5:	48 89 e5             	mov    %rsp,%rbp
ffff8000001053a8:	48 83 ec 08          	sub    $0x8,%rsp
ffff8000001053ac:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  return ((addr_t) (a)) - ((addr_t)KERNBASE);
ffff8000001053b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001053b4:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff8000001053bb:	80 00 00 
ffff8000001053be:	48 01 d0             	add    %rdx,%rax
}
ffff8000001053c1:	c9                   	leave
ffff8000001053c2:	c3                   	ret

ffff8000001053c3 <xchg>:

static inline uint
xchg(volatile uint *addr, addr_t newval)
{
ffff8000001053c3:	55                   	push   %rbp
ffff8000001053c4:	48 89 e5             	mov    %rsp,%rbp
ffff8000001053c7:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001053cb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff8000001053cf:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
ffff8000001053d3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff8000001053d7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001053db:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffff8000001053df:	f0 87 02             	lock xchg %eax,(%rdx)
ffff8000001053e2:	89 45 fc             	mov    %eax,-0x4(%rbp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
ffff8000001053e5:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff8000001053e8:	c9                   	leave
ffff8000001053e9:	c3                   	ret

ffff8000001053ea <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
ffff8000001053ea:	55                   	push   %rbp
ffff8000001053eb:	48 89 e5             	mov    %rsp,%rbp
  uartearlyinit();
ffff8000001053ee:	48 b8 44 9e 10 00 00 	movabs $0xffff800000109e44,%rax
ffff8000001053f5:	80 ff ff 
ffff8000001053f8:	ff d0                	call   *%rax
  kinit1(end, P2V(PHYSTOP)); // phys page allocator
ffff8000001053fa:	48 ba 00 00 00 0e 00 	movabs $0xffff80000e000000,%rdx
ffff800000105401:	80 ff ff 
ffff800000105404:	48 b8 00 d0 11 00 00 	movabs $0xffff80000011d000,%rax
ffff80000010540b:	80 ff ff 
ffff80000010540e:	48 89 d6             	mov    %rdx,%rsi
ffff800000105411:	48 89 c7             	mov    %rax,%rdi
ffff800000105414:	48 b8 c2 3f 10 00 00 	movabs $0xffff800000103fc2,%rax
ffff80000010541b:	80 ff ff 
ffff80000010541e:	ff d0                	call   *%rax
  kvmalloc();      // kernel page table
ffff800000105420:	48 b8 cc b0 10 00 00 	movabs $0xffff80000010b0cc,%rax
ffff800000105427:	80 ff ff 
ffff80000010542a:	ff d0                	call   *%rax
  mpinit();        // detect other processors
ffff80000010542c:	48 b8 ee 59 10 00 00 	movabs $0xffff8000001059ee,%rax
ffff800000105433:	80 ff ff 
ffff800000105436:	ff d0                	call   *%rax
  lapicinit();     // interrupt controller
ffff800000105438:	48 b8 fa 44 10 00 00 	movabs $0xffff8000001044fa,%rax
ffff80000010543f:	80 ff ff 
ffff800000105442:	ff d0                	call   *%rax
  tvinit();        // trap vectors
ffff800000105444:	48 b8 6b 99 10 00 00 	movabs $0xffff80000010996b,%rax
ffff80000010544b:	80 ff ff 
ffff80000010544e:	ff d0                	call   *%rax
  seginit();       // segment descriptors
ffff800000105450:	48 b8 11 ac 10 00 00 	movabs $0xffff80000010ac11,%rax
ffff800000105457:	80 ff ff 
ffff80000010545a:	ff d0                	call   *%rax
  cprintf("\ncpu%d: starting Spring 2026 xv6\n\n", cpunum());
ffff80000010545c:	48 b8 88 46 10 00 00 	movabs $0xffff800000104688,%rax
ffff800000105463:	80 ff ff 
ffff800000105466:	ff d0                	call   *%rax
ffff800000105468:	89 c2                	mov    %eax,%edx
ffff80000010546a:	48 b8 f0 c2 10 00 00 	movabs $0xffff80000010c2f0,%rax
ffff800000105471:	80 ff ff 
ffff800000105474:	89 d6                	mov    %edx,%esi
ffff800000105476:	48 89 c7             	mov    %rax,%rdi
ffff800000105479:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010547e:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000105485:	80 ff ff 
ffff800000105488:	ff d2                	call   *%rdx
  ioapicinit();    // another interrupt controller
ffff80000010548a:	48 b8 8d 3e 10 00 00 	movabs $0xffff800000103e8d,%rax
ffff800000105491:	80 ff ff 
ffff800000105494:	ff d0                	call   *%rax
  consoleinit();   // console hardware
ffff800000105496:	48 b8 99 14 10 00 00 	movabs $0xffff800000101499,%rax
ffff80000010549d:	80 ff ff 
ffff8000001054a0:	ff d0                	call   *%rax
  uartinit();      // serial port
ffff8000001054a2:	48 b8 48 9f 10 00 00 	movabs $0xffff800000109f48,%rax
ffff8000001054a9:	80 ff ff 
ffff8000001054ac:	ff d0                	call   *%rax
  pinit();         // process table
ffff8000001054ae:	48 b8 2e 61 10 00 00 	movabs $0xffff80000010612e,%rax
ffff8000001054b5:	80 ff ff 
ffff8000001054b8:	ff d0                	call   *%rax
  binit();         // buffer cache
ffff8000001054ba:	48 b8 1b 01 10 00 00 	movabs $0xffff80000010011b,%rax
ffff8000001054c1:	80 ff ff 
ffff8000001054c4:	ff d0                	call   *%rax
  fileinit();      // file table
ffff8000001054c6:	48 b8 1d 1b 10 00 00 	movabs $0xffff800000101b1d,%rax
ffff8000001054cd:	80 ff ff 
ffff8000001054d0:	ff d0                	call   *%rax
  ideinit();       // disk
ffff8000001054d2:	48 b8 dc 38 10 00 00 	movabs $0xffff8000001038dc,%rax
ffff8000001054d9:	80 ff ff 
ffff8000001054dc:	ff d0                	call   *%rax
  startothers();   // start other processors
ffff8000001054de:	48 b8 bb 55 10 00 00 	movabs $0xffff8000001055bb,%rax
ffff8000001054e5:	80 ff ff 
ffff8000001054e8:	ff d0                	call   *%rax
  kinit2();
ffff8000001054ea:	48 b8 38 40 10 00 00 	movabs $0xffff800000104038,%rax
ffff8000001054f1:	80 ff ff 
ffff8000001054f4:	ff d0                	call   *%rax
  userinit();      // first user process
ffff8000001054f6:	48 b8 d9 62 10 00 00 	movabs $0xffff8000001062d9,%rax
ffff8000001054fd:	80 ff ff 
ffff800000105500:	ff d0                	call   *%rax
  mpmain();        // finish this processor's setup
ffff800000105502:	48 b8 42 55 10 00 00 	movabs $0xffff800000105542,%rax
ffff800000105509:	80 ff ff 
ffff80000010550c:	ff d0                	call   *%rax

ffff80000010550e <mpenter>:
}

// Other CPUs jump here from entryother.S.
void
mpenter(void)
{
ffff80000010550e:	55                   	push   %rbp
ffff80000010550f:	48 89 e5             	mov    %rsp,%rbp
  switchkvm();
ffff800000105512:	48 b8 cd b4 10 00 00 	movabs $0xffff80000010b4cd,%rax
ffff800000105519:	80 ff ff 
ffff80000010551c:	ff d0                	call   *%rax
  seginit();
ffff80000010551e:	48 b8 11 ac 10 00 00 	movabs $0xffff80000010ac11,%rax
ffff800000105525:	80 ff ff 
ffff800000105528:	ff d0                	call   *%rax
  lapicinit();
ffff80000010552a:	48 b8 fa 44 10 00 00 	movabs $0xffff8000001044fa,%rax
ffff800000105531:	80 ff ff 
ffff800000105534:	ff d0                	call   *%rax
  mpmain();
ffff800000105536:	48 b8 42 55 10 00 00 	movabs $0xffff800000105542,%rax
ffff80000010553d:	80 ff ff 
ffff800000105540:	ff d0                	call   *%rax

ffff800000105542 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
ffff800000105542:	55                   	push   %rbp
ffff800000105543:	48 89 e5             	mov    %rsp,%rbp
  cprintf("cpu%d: starting\n", cpunum());
ffff800000105546:	48 b8 88 46 10 00 00 	movabs $0xffff800000104688,%rax
ffff80000010554d:	80 ff ff 
ffff800000105550:	ff d0                	call   *%rax
ffff800000105552:	89 c2                	mov    %eax,%edx
ffff800000105554:	48 b8 13 c3 10 00 00 	movabs $0xffff80000010c313,%rax
ffff80000010555b:	80 ff ff 
ffff80000010555e:	89 d6                	mov    %edx,%esi
ffff800000105560:	48 89 c7             	mov    %rax,%rdi
ffff800000105563:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105568:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff80000010556f:	80 ff ff 
ffff800000105572:	ff d2                	call   *%rdx
  idtinit();       // load idt register
ffff800000105574:	48 b8 43 99 10 00 00 	movabs $0xffff800000109943,%rax
ffff80000010557b:	80 ff ff 
ffff80000010557e:	ff d0                	call   *%rax
  syscallinit();   // syscall set up
ffff800000105580:	48 b8 9a ab 10 00 00 	movabs $0xffff80000010ab9a,%rax
ffff800000105587:	80 ff ff 
ffff80000010558a:	ff d0                	call   *%rax
  xchg(&cpu->started, 1); // tell startothers() we're up
ffff80000010558c:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000105593:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000105597:	48 83 c0 10          	add    $0x10,%rax
ffff80000010559b:	be 01 00 00 00       	mov    $0x1,%esi
ffff8000001055a0:	48 89 c7             	mov    %rax,%rdi
ffff8000001055a3:	48 b8 c3 53 10 00 00 	movabs $0xffff8000001053c3,%rax
ffff8000001055aa:	80 ff ff 
ffff8000001055ad:	ff d0                	call   *%rax
  scheduler();     // start running processes
ffff8000001055af:	48 b8 4b 6b 10 00 00 	movabs $0xffff800000106b4b,%rax
ffff8000001055b6:	80 ff ff 
ffff8000001055b9:	ff d0                	call   *%rax

ffff8000001055bb <startothers>:
void entry32mp(void);

// Start the non-boot (AP) processors.
static void
startothers(void)
{
ffff8000001055bb:	55                   	push   %rbp
ffff8000001055bc:	48 89 e5             	mov    %rsp,%rbp
ffff8000001055bf:	48 83 ec 20          	sub    $0x20,%rsp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
ffff8000001055c3:	48 b8 00 70 00 00 00 	movabs $0xffff800000007000,%rax
ffff8000001055ca:	80 ff ff 
ffff8000001055cd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  memmove(code, _binary_entryother_start,
ffff8000001055d1:	48 b8 72 00 00 00 00 	movabs $0x72,%rax
ffff8000001055d8:	00 00 00 
ffff8000001055db:	89 c2                	mov    %eax,%edx
ffff8000001055dd:	48 b9 a0 de 10 00 00 	movabs $0xffff80000010dea0,%rcx
ffff8000001055e4:	80 ff ff 
ffff8000001055e7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001055eb:	48 89 ce             	mov    %rcx,%rsi
ffff8000001055ee:	48 89 c7             	mov    %rax,%rdi
ffff8000001055f1:	48 b8 d3 7b 10 00 00 	movabs $0xffff800000107bd3,%rax
ffff8000001055f8:	80 ff ff 
ffff8000001055fb:	ff d0                	call   *%rax
          (addr_t)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
ffff8000001055fd:	48 b8 e0 72 11 00 00 	movabs $0xffff8000001172e0,%rax
ffff800000105604:	80 ff ff 
ffff800000105607:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010560b:	e9 c6 00 00 00       	jmp    ffff8000001056d6 <startothers+0x11b>
    if(c == cpus+cpunum())  // We've started already.
ffff800000105610:	48 b8 88 46 10 00 00 	movabs $0xffff800000104688,%rax
ffff800000105617:	80 ff ff 
ffff80000010561a:	ff d0                	call   *%rax
ffff80000010561c:	48 63 d0             	movslq %eax,%rdx
ffff80000010561f:	48 89 d0             	mov    %rdx,%rax
ffff800000105622:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000105626:	48 01 d0             	add    %rdx,%rax
ffff800000105629:	48 c1 e0 03          	shl    $0x3,%rax
ffff80000010562d:	48 89 c2             	mov    %rax,%rdx
ffff800000105630:	48 b8 e0 72 11 00 00 	movabs $0xffff8000001172e0,%rax
ffff800000105637:	80 ff ff 
ffff80000010563a:	48 01 d0             	add    %rdx,%rax
ffff80000010563d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000105641:	0f 84 89 00 00 00    	je     ffff8000001056d0 <startothers+0x115>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
ffff800000105647:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010564e:	80 ff ff 
ffff800000105651:	ff d0                	call   *%rax
ffff800000105653:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    *(uint32*)(code-4) = 0x8000; // enough stack to get us to entry64mp
ffff800000105657:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010565b:	48 83 e8 04          	sub    $0x4,%rax
ffff80000010565f:	c7 00 00 80 00 00    	movl   $0x8000,(%rax)
    *(uint32*)(code-8) = v2p(entry32mp);
ffff800000105665:	48 b8 49 00 10 00 00 	movabs $0xffff800000100049,%rax
ffff80000010566c:	80 ff ff 
ffff80000010566f:	48 89 c7             	mov    %rax,%rdi
ffff800000105672:	48 b8 a4 53 10 00 00 	movabs $0xffff8000001053a4,%rax
ffff800000105679:	80 ff ff 
ffff80000010567c:	ff d0                	call   *%rax
ffff80000010567e:	48 89 c2             	mov    %rax,%rdx
ffff800000105681:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105685:	48 83 e8 08          	sub    $0x8,%rax
ffff800000105689:	89 10                	mov    %edx,(%rax)
    *(uint64*)(code-16) = (uint64) (stack + KSTACKSIZE);
ffff80000010568b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010568f:	48 8d 90 00 10 00 00 	lea    0x1000(%rax),%rdx
ffff800000105696:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010569a:	48 83 e8 10          	sub    $0x10,%rax
ffff80000010569e:	48 89 10             	mov    %rdx,(%rax)

    lapicstartap(c->apicid, V2P(code));
ffff8000001056a1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001056a5:	89 c2                	mov    %eax,%edx
ffff8000001056a7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001056ab:	0f b6 40 01          	movzbl 0x1(%rax),%eax
ffff8000001056af:	0f b6 c0             	movzbl %al,%eax
ffff8000001056b2:	89 d6                	mov    %edx,%esi
ffff8000001056b4:	89 c7                	mov    %eax,%edi
ffff8000001056b6:	48 b8 cd 47 10 00 00 	movabs $0xffff8000001047cd,%rax
ffff8000001056bd:	80 ff ff 
ffff8000001056c0:	ff d0                	call   *%rax

    // wait for cpu to finish mpmain()
    while(c->started == 0)
ffff8000001056c2:	90                   	nop
ffff8000001056c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001056c7:	8b 40 10             	mov    0x10(%rax),%eax
ffff8000001056ca:	85 c0                	test   %eax,%eax
ffff8000001056cc:	74 f5                	je     ffff8000001056c3 <startothers+0x108>
ffff8000001056ce:	eb 01                	jmp    ffff8000001056d1 <startothers+0x116>
      continue;
ffff8000001056d0:	90                   	nop
  for(c = cpus; c < cpus+ncpu; c++){
ffff8000001056d1:	48 83 45 f8 28       	addq   $0x28,-0x8(%rbp)
ffff8000001056d6:	48 b8 20 74 11 00 00 	movabs $0xffff800000117420,%rax
ffff8000001056dd:	80 ff ff 
ffff8000001056e0:	8b 00                	mov    (%rax),%eax
ffff8000001056e2:	48 63 d0             	movslq %eax,%rdx
ffff8000001056e5:	48 89 d0             	mov    %rdx,%rax
ffff8000001056e8:	48 c1 e0 02          	shl    $0x2,%rax
ffff8000001056ec:	48 01 d0             	add    %rdx,%rax
ffff8000001056ef:	48 c1 e0 03          	shl    $0x3,%rax
ffff8000001056f3:	48 89 c2             	mov    %rax,%rdx
ffff8000001056f6:	48 b8 e0 72 11 00 00 	movabs $0xffff8000001172e0,%rax
ffff8000001056fd:	80 ff ff 
ffff800000105700:	48 01 d0             	add    %rdx,%rax
ffff800000105703:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000105707:	0f 82 03 ff ff ff    	jb     ffff800000105610 <startothers+0x55>
      ;
  }
}
ffff80000010570d:	90                   	nop
ffff80000010570e:	90                   	nop
ffff80000010570f:	c9                   	leave
ffff800000105710:	c3                   	ret

ffff800000105711 <inb>:
{
ffff800000105711:	55                   	push   %rbp
ffff800000105712:	48 89 e5             	mov    %rsp,%rbp
ffff800000105715:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000105719:	89 f8                	mov    %edi,%eax
ffff80000010571b:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
ffff80000010571f:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff800000105723:	89 c2                	mov    %eax,%edx
ffff800000105725:	ec                   	in     (%dx),%al
ffff800000105726:	88 45 ff             	mov    %al,-0x1(%rbp)
  return data;
ffff800000105729:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
}
ffff80000010572d:	c9                   	leave
ffff80000010572e:	c3                   	ret

ffff80000010572f <outb>:
{
ffff80000010572f:	55                   	push   %rbp
ffff800000105730:	48 89 e5             	mov    %rsp,%rbp
ffff800000105733:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000105737:	89 fa                	mov    %edi,%edx
ffff800000105739:	89 f0                	mov    %esi,%eax
ffff80000010573b:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffff80000010573f:	88 45 f8             	mov    %al,-0x8(%rbp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
ffff800000105742:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffff800000105746:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffff80000010574a:	ee                   	out    %al,(%dx)
}
ffff80000010574b:	90                   	nop
ffff80000010574c:	c9                   	leave
ffff80000010574d:	c3                   	ret

ffff80000010574e <sum>:
int ncpu;
uchar ioapicid;

static uchar
sum(uchar *addr, int len)
{
ffff80000010574e:	55                   	push   %rbp
ffff80000010574f:	48 89 e5             	mov    %rsp,%rbp
ffff800000105752:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000105756:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010575a:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, sum;

  sum = 0;
ffff80000010575d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  for(i=0; i<len; i++)
ffff800000105764:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010576b:	eb 1a                	jmp    ffff800000105787 <sum+0x39>
    sum += addr[i];
ffff80000010576d:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000105770:	48 63 d0             	movslq %eax,%rdx
ffff800000105773:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105777:	48 01 d0             	add    %rdx,%rax
ffff80000010577a:	0f b6 00             	movzbl (%rax),%eax
ffff80000010577d:	0f b6 c0             	movzbl %al,%eax
ffff800000105780:	01 45 f8             	add    %eax,-0x8(%rbp)
  for(i=0; i<len; i++)
ffff800000105783:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000105787:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010578a:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
ffff80000010578d:	7c de                	jl     ffff80000010576d <sum+0x1f>
  return sum;
ffff80000010578f:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
ffff800000105792:	c9                   	leave
ffff800000105793:	c3                   	ret

ffff800000105794 <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(addr_t a, int len)
{
ffff800000105794:	55                   	push   %rbp
ffff800000105795:	48 89 e5             	mov    %rsp,%rbp
ffff800000105798:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010579c:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff8000001057a0:	89 75 d4             	mov    %esi,-0x2c(%rbp)
  uchar *e, *p, *addr;
  addr = P2V(a);
ffff8000001057a3:	48 ba 00 00 00 00 00 	movabs $0xffff800000000000,%rdx
ffff8000001057aa:	80 ff ff 
ffff8000001057ad:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001057b1:	48 01 d0             	add    %rdx,%rax
ffff8000001057b4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  e = addr+len;
ffff8000001057b8:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff8000001057bb:	48 63 d0             	movslq %eax,%rdx
ffff8000001057be:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001057c2:	48 01 d0             	add    %rdx,%rax
ffff8000001057c5:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  for(p = addr; p < e; p += sizeof(struct mp))
ffff8000001057c9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001057cd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001057d1:	eb 50                	jmp    ffff800000105823 <mpsearch1+0x8f>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
ffff8000001057d3:	48 b9 28 c3 10 00 00 	movabs $0xffff80000010c328,%rcx
ffff8000001057da:	80 ff ff 
ffff8000001057dd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001057e1:	ba 04 00 00 00       	mov    $0x4,%edx
ffff8000001057e6:	48 89 ce             	mov    %rcx,%rsi
ffff8000001057e9:	48 89 c7             	mov    %rax,%rdi
ffff8000001057ec:	48 b8 64 7b 10 00 00 	movabs $0xffff800000107b64,%rax
ffff8000001057f3:	80 ff ff 
ffff8000001057f6:	ff d0                	call   *%rax
ffff8000001057f8:	85 c0                	test   %eax,%eax
ffff8000001057fa:	75 22                	jne    ffff80000010581e <mpsearch1+0x8a>
ffff8000001057fc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105800:	be 10 00 00 00       	mov    $0x10,%esi
ffff800000105805:	48 89 c7             	mov    %rax,%rdi
ffff800000105808:	48 b8 4e 57 10 00 00 	movabs $0xffff80000010574e,%rax
ffff80000010580f:	80 ff ff 
ffff800000105812:	ff d0                	call   *%rax
ffff800000105814:	84 c0                	test   %al,%al
ffff800000105816:	75 06                	jne    ffff80000010581e <mpsearch1+0x8a>
      return (struct mp*)p;
ffff800000105818:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010581c:	eb 14                	jmp    ffff800000105832 <mpsearch1+0x9e>
  for(p = addr; p < e; p += sizeof(struct mp))
ffff80000010581e:	48 83 45 f8 10       	addq   $0x10,-0x8(%rbp)
ffff800000105823:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105827:	48 3b 45 e8          	cmp    -0x18(%rbp),%rax
ffff80000010582b:	72 a6                	jb     ffff8000001057d3 <mpsearch1+0x3f>
  return 0;
ffff80000010582d:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000105832:	c9                   	leave
ffff800000105833:	c3                   	ret

ffff800000105834 <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
ffff800000105834:	55                   	push   %rbp
ffff800000105835:	48 89 e5             	mov    %rsp,%rbp
ffff800000105838:	48 83 ec 20          	sub    $0x20,%rsp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
ffff80000010583c:	48 b8 00 04 00 00 00 	movabs $0xffff800000000400,%rax
ffff800000105843:	80 ff ff 
ffff800000105846:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
ffff80000010584a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010584e:	48 83 c0 0f          	add    $0xf,%rax
ffff800000105852:	0f b6 00             	movzbl (%rax),%eax
ffff800000105855:	0f b6 c0             	movzbl %al,%eax
ffff800000105858:	c1 e0 08             	shl    $0x8,%eax
ffff80000010585b:	89 c2                	mov    %eax,%edx
ffff80000010585d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105861:	48 83 c0 0e          	add    $0xe,%rax
ffff800000105865:	0f b6 00             	movzbl (%rax),%eax
ffff800000105868:	0f b6 c0             	movzbl %al,%eax
ffff80000010586b:	09 d0                	or     %edx,%eax
ffff80000010586d:	c1 e0 04             	shl    $0x4,%eax
ffff800000105870:	89 45 f4             	mov    %eax,-0xc(%rbp)
ffff800000105873:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
ffff800000105877:	74 28                	je     ffff8000001058a1 <mpsearch+0x6d>
    if((mp = mpsearch1(p, 1024)))
ffff800000105879:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff80000010587c:	be 00 04 00 00       	mov    $0x400,%esi
ffff800000105881:	48 89 c7             	mov    %rax,%rdi
ffff800000105884:	48 b8 94 57 10 00 00 	movabs $0xffff800000105794,%rax
ffff80000010588b:	80 ff ff 
ffff80000010588e:	ff d0                	call   *%rax
ffff800000105890:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000105894:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff800000105899:	74 5e                	je     ffff8000001058f9 <mpsearch+0xc5>
      return mp;
ffff80000010589b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010589f:	eb 6e                	jmp    ffff80000010590f <mpsearch+0xdb>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
ffff8000001058a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001058a5:	48 83 c0 14          	add    $0x14,%rax
ffff8000001058a9:	0f b6 00             	movzbl (%rax),%eax
ffff8000001058ac:	0f b6 c0             	movzbl %al,%eax
ffff8000001058af:	c1 e0 08             	shl    $0x8,%eax
ffff8000001058b2:	89 c2                	mov    %eax,%edx
ffff8000001058b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001058b8:	48 83 c0 13          	add    $0x13,%rax
ffff8000001058bc:	0f b6 00             	movzbl (%rax),%eax
ffff8000001058bf:	0f b6 c0             	movzbl %al,%eax
ffff8000001058c2:	09 d0                	or     %edx,%eax
ffff8000001058c4:	c1 e0 0a             	shl    $0xa,%eax
ffff8000001058c7:	89 45 f4             	mov    %eax,-0xc(%rbp)
    if((mp = mpsearch1(p-1024, 1024)))
ffff8000001058ca:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff8000001058cd:	2d 00 04 00 00       	sub    $0x400,%eax
ffff8000001058d2:	89 c0                	mov    %eax,%eax
ffff8000001058d4:	be 00 04 00 00       	mov    $0x400,%esi
ffff8000001058d9:	48 89 c7             	mov    %rax,%rdi
ffff8000001058dc:	48 b8 94 57 10 00 00 	movabs $0xffff800000105794,%rax
ffff8000001058e3:	80 ff ff 
ffff8000001058e6:	ff d0                	call   *%rax
ffff8000001058e8:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff8000001058ec:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff8000001058f1:	74 06                	je     ffff8000001058f9 <mpsearch+0xc5>
      return mp;
ffff8000001058f3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001058f7:	eb 16                	jmp    ffff80000010590f <mpsearch+0xdb>
  }
  return mpsearch1(0xF0000, 0x10000);
ffff8000001058f9:	be 00 00 01 00       	mov    $0x10000,%esi
ffff8000001058fe:	bf 00 00 0f 00       	mov    $0xf0000,%edi
ffff800000105903:	48 b8 94 57 10 00 00 	movabs $0xffff800000105794,%rax
ffff80000010590a:	80 ff ff 
ffff80000010590d:	ff d0                	call   *%rax
}
ffff80000010590f:	c9                   	leave
ffff800000105910:	c3                   	ret

ffff800000105911 <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
ffff800000105911:	55                   	push   %rbp
ffff800000105912:	48 89 e5             	mov    %rsp,%rbp
ffff800000105915:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000105919:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
ffff80000010591d:	48 b8 34 58 10 00 00 	movabs $0xffff800000105834,%rax
ffff800000105924:	80 ff ff 
ffff800000105927:	ff d0                	call   *%rax
ffff800000105929:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010592d:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000105932:	74 0b                	je     ffff80000010593f <mpconfig+0x2e>
ffff800000105934:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105938:	8b 40 04             	mov    0x4(%rax),%eax
ffff80000010593b:	85 c0                	test   %eax,%eax
ffff80000010593d:	75 0a                	jne    ffff800000105949 <mpconfig+0x38>
    return 0;
ffff80000010593f:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105944:	e9 a3 00 00 00       	jmp    ffff8000001059ec <mpconfig+0xdb>
  conf = (struct mpconf*) P2V((addr_t) mp->physaddr);
ffff800000105949:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010594d:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000105950:	89 c2                	mov    %eax,%edx
ffff800000105952:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff800000105959:	80 ff ff 
ffff80000010595c:	48 01 d0             	add    %rdx,%rax
ffff80000010595f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  if(memcmp(conf, "PCMP", 4) != 0)
ffff800000105963:	48 b9 2d c3 10 00 00 	movabs $0xffff80000010c32d,%rcx
ffff80000010596a:	80 ff ff 
ffff80000010596d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105971:	ba 04 00 00 00       	mov    $0x4,%edx
ffff800000105976:	48 89 ce             	mov    %rcx,%rsi
ffff800000105979:	48 89 c7             	mov    %rax,%rdi
ffff80000010597c:	48 b8 64 7b 10 00 00 	movabs $0xffff800000107b64,%rax
ffff800000105983:	80 ff ff 
ffff800000105986:	ff d0                	call   *%rax
ffff800000105988:	85 c0                	test   %eax,%eax
ffff80000010598a:	74 07                	je     ffff800000105993 <mpconfig+0x82>
    return 0;
ffff80000010598c:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105991:	eb 59                	jmp    ffff8000001059ec <mpconfig+0xdb>
  if(conf->version != 1 && conf->version != 4)
ffff800000105993:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105997:	0f b6 40 06          	movzbl 0x6(%rax),%eax
ffff80000010599b:	3c 01                	cmp    $0x1,%al
ffff80000010599d:	74 13                	je     ffff8000001059b2 <mpconfig+0xa1>
ffff80000010599f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001059a3:	0f b6 40 06          	movzbl 0x6(%rax),%eax
ffff8000001059a7:	3c 04                	cmp    $0x4,%al
ffff8000001059a9:	74 07                	je     ffff8000001059b2 <mpconfig+0xa1>
    return 0;
ffff8000001059ab:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001059b0:	eb 3a                	jmp    ffff8000001059ec <mpconfig+0xdb>
  if(sum((uchar*)conf, conf->length) != 0)
ffff8000001059b2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001059b6:	0f b7 40 04          	movzwl 0x4(%rax),%eax
ffff8000001059ba:	0f b7 d0             	movzwl %ax,%edx
ffff8000001059bd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001059c1:	89 d6                	mov    %edx,%esi
ffff8000001059c3:	48 89 c7             	mov    %rax,%rdi
ffff8000001059c6:	48 b8 4e 57 10 00 00 	movabs $0xffff80000010574e,%rax
ffff8000001059cd:	80 ff ff 
ffff8000001059d0:	ff d0                	call   *%rax
ffff8000001059d2:	84 c0                	test   %al,%al
ffff8000001059d4:	74 07                	je     ffff8000001059dd <mpconfig+0xcc>
    return 0;
ffff8000001059d6:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001059db:	eb 0f                	jmp    ffff8000001059ec <mpconfig+0xdb>
  *pmp = mp;
ffff8000001059dd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001059e1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001059e5:	48 89 10             	mov    %rdx,(%rax)
  return conf;
ffff8000001059e8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
}
ffff8000001059ec:	c9                   	leave
ffff8000001059ed:	c3                   	ret

ffff8000001059ee <mpinit>:

void
mpinit(void)
{
ffff8000001059ee:	55                   	push   %rbp
ffff8000001059ef:	48 89 e5             	mov    %rsp,%rbp
ffff8000001059f2:	48 83 ec 30          	sub    $0x30,%rsp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0) {
ffff8000001059f6:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffff8000001059fa:	48 89 c7             	mov    %rax,%rdi
ffff8000001059fd:	48 b8 11 59 10 00 00 	movabs $0xffff800000105911,%rax
ffff800000105a04:	80 ff ff 
ffff800000105a07:	ff d0                	call   *%rax
ffff800000105a09:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000105a0d:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000105a12:	75 23                	jne    ffff800000105a37 <mpinit+0x49>
    cprintf("No other CPUs found.\n");
ffff800000105a14:	48 b8 32 c3 10 00 00 	movabs $0xffff80000010c332,%rax
ffff800000105a1b:	80 ff ff 
ffff800000105a1e:	48 89 c7             	mov    %rax,%rdi
ffff800000105a21:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105a26:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000105a2d:	80 ff ff 
ffff800000105a30:	ff d2                	call   *%rdx
ffff800000105a32:	e9 c9 01 00 00       	jmp    ffff800000105c00 <mpinit+0x212>
    return;
  }
  lapic = P2V((addr_t)conf->lapicaddr_p);
ffff800000105a37:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105a3b:	8b 40 24             	mov    0x24(%rax),%eax
ffff800000105a3e:	89 c2                	mov    %eax,%edx
ffff800000105a40:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff800000105a47:	80 ff ff 
ffff800000105a4a:	48 01 d0             	add    %rdx,%rax
ffff800000105a4d:	48 89 c2             	mov    %rax,%rdx
ffff800000105a50:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff800000105a57:	80 ff ff 
ffff800000105a5a:	48 89 10             	mov    %rdx,(%rax)
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
ffff800000105a5d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105a61:	48 83 c0 2c          	add    $0x2c,%rax
ffff800000105a65:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000105a69:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105a6d:	0f b7 40 04          	movzwl 0x4(%rax),%eax
ffff800000105a71:	0f b7 d0             	movzwl %ax,%edx
ffff800000105a74:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105a78:	48 01 d0             	add    %rdx,%rax
ffff800000105a7b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000105a7f:	e9 f6 00 00 00       	jmp    ffff800000105b7a <mpinit+0x18c>
    switch(*p){
ffff800000105a84:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105a88:	0f b6 00             	movzbl (%rax),%eax
ffff800000105a8b:	0f b6 c0             	movzbl %al,%eax
ffff800000105a8e:	83 f8 04             	cmp    $0x4,%eax
ffff800000105a91:	0f 8f ca 00 00 00    	jg     ffff800000105b61 <mpinit+0x173>
ffff800000105a97:	83 f8 03             	cmp    $0x3,%eax
ffff800000105a9a:	0f 8d ba 00 00 00    	jge    ffff800000105b5a <mpinit+0x16c>
ffff800000105aa0:	83 f8 02             	cmp    $0x2,%eax
ffff800000105aa3:	0f 84 8e 00 00 00    	je     ffff800000105b37 <mpinit+0x149>
ffff800000105aa9:	83 f8 02             	cmp    $0x2,%eax
ffff800000105aac:	0f 8f af 00 00 00    	jg     ffff800000105b61 <mpinit+0x173>
ffff800000105ab2:	85 c0                	test   %eax,%eax
ffff800000105ab4:	74 0e                	je     ffff800000105ac4 <mpinit+0xd6>
ffff800000105ab6:	83 f8 01             	cmp    $0x1,%eax
ffff800000105ab9:	0f 84 9b 00 00 00    	je     ffff800000105b5a <mpinit+0x16c>
ffff800000105abf:	e9 9d 00 00 00       	jmp    ffff800000105b61 <mpinit+0x173>
    case MPPROC:
      proc = (struct mpproc*)p;
ffff800000105ac4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105ac8:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
      if(ncpu < NCPU) {
ffff800000105acc:	48 b8 20 74 11 00 00 	movabs $0xffff800000117420,%rax
ffff800000105ad3:	80 ff ff 
ffff800000105ad6:	8b 00                	mov    (%rax),%eax
ffff800000105ad8:	83 f8 07             	cmp    $0x7,%eax
ffff800000105adb:	7f 53                	jg     ffff800000105b30 <mpinit+0x142>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
ffff800000105add:	48 b8 20 74 11 00 00 	movabs $0xffff800000117420,%rax
ffff800000105ae4:	80 ff ff 
ffff800000105ae7:	8b 10                	mov    (%rax),%edx
ffff800000105ae9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000105aed:	0f b6 48 01          	movzbl 0x1(%rax),%ecx
ffff800000105af1:	48 be e0 72 11 00 00 	movabs $0xffff8000001172e0,%rsi
ffff800000105af8:	80 ff ff 
ffff800000105afb:	48 63 d2             	movslq %edx,%rdx
ffff800000105afe:	48 89 d0             	mov    %rdx,%rax
ffff800000105b01:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000105b05:	48 01 d0             	add    %rdx,%rax
ffff800000105b08:	48 c1 e0 03          	shl    $0x3,%rax
ffff800000105b0c:	48 01 f0             	add    %rsi,%rax
ffff800000105b0f:	48 83 c0 01          	add    $0x1,%rax
ffff800000105b13:	88 08                	mov    %cl,(%rax)
        ncpu++;
ffff800000105b15:	48 b8 20 74 11 00 00 	movabs $0xffff800000117420,%rax
ffff800000105b1c:	80 ff ff 
ffff800000105b1f:	8b 00                	mov    (%rax),%eax
ffff800000105b21:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000105b24:	48 b8 20 74 11 00 00 	movabs $0xffff800000117420,%rax
ffff800000105b2b:	80 ff ff 
ffff800000105b2e:	89 10                	mov    %edx,(%rax)
      }
      p += sizeof(struct mpproc);
ffff800000105b30:	48 83 45 f8 14       	addq   $0x14,-0x8(%rbp)
      continue;
ffff800000105b35:	eb 43                	jmp    ffff800000105b7a <mpinit+0x18c>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
ffff800000105b37:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105b3b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
      ioapicid = ioapic->apicno;
ffff800000105b3f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105b43:	0f b6 40 01          	movzbl 0x1(%rax),%eax
ffff800000105b47:	48 ba 24 74 11 00 00 	movabs $0xffff800000117424,%rdx
ffff800000105b4e:	80 ff ff 
ffff800000105b51:	88 02                	mov    %al,(%rdx)
      p += sizeof(struct mpioapic);
ffff800000105b53:	48 83 45 f8 08       	addq   $0x8,-0x8(%rbp)
      continue;
ffff800000105b58:	eb 20                	jmp    ffff800000105b7a <mpinit+0x18c>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
ffff800000105b5a:	48 83 45 f8 08       	addq   $0x8,-0x8(%rbp)
      continue;
ffff800000105b5f:	eb 19                	jmp    ffff800000105b7a <mpinit+0x18c>
    default:
      panic("Major problem parsing mp config.");
ffff800000105b61:	48 b8 48 c3 10 00 00 	movabs $0xffff80000010c348,%rax
ffff800000105b68:	80 ff ff 
ffff800000105b6b:	48 89 c7             	mov    %rax,%rdi
ffff800000105b6e:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000105b75:	80 ff ff 
ffff800000105b78:	ff d0                	call   *%rax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
ffff800000105b7a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105b7e:	48 3b 45 e8          	cmp    -0x18(%rbp),%rax
ffff800000105b82:	0f 82 fc fe ff ff    	jb     ffff800000105a84 <mpinit+0x96>
      break;
    }
  }
  cprintf("Seems we are SMP, ncpu = %d\n",ncpu);
ffff800000105b88:	48 b8 20 74 11 00 00 	movabs $0xffff800000117420,%rax
ffff800000105b8f:	80 ff ff 
ffff800000105b92:	8b 00                	mov    (%rax),%eax
ffff800000105b94:	48 ba 69 c3 10 00 00 	movabs $0xffff80000010c369,%rdx
ffff800000105b9b:	80 ff ff 
ffff800000105b9e:	89 c6                	mov    %eax,%esi
ffff800000105ba0:	48 89 d7             	mov    %rdx,%rdi
ffff800000105ba3:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105ba8:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000105baf:	80 ff ff 
ffff800000105bb2:	ff d2                	call   *%rdx
  if(mp->imcrp){
ffff800000105bb4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000105bb8:	0f b6 40 0c          	movzbl 0xc(%rax),%eax
ffff800000105bbc:	84 c0                	test   %al,%al
ffff800000105bbe:	74 40                	je     ffff800000105c00 <mpinit+0x212>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
ffff800000105bc0:	be 70 00 00 00       	mov    $0x70,%esi
ffff800000105bc5:	bf 22 00 00 00       	mov    $0x22,%edi
ffff800000105bca:	48 b8 2f 57 10 00 00 	movabs $0xffff80000010572f,%rax
ffff800000105bd1:	80 ff ff 
ffff800000105bd4:	ff d0                	call   *%rax
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
ffff800000105bd6:	bf 23 00 00 00       	mov    $0x23,%edi
ffff800000105bdb:	48 b8 11 57 10 00 00 	movabs $0xffff800000105711,%rax
ffff800000105be2:	80 ff ff 
ffff800000105be5:	ff d0                	call   *%rax
ffff800000105be7:	83 c8 01             	or     $0x1,%eax
ffff800000105bea:	0f b6 c0             	movzbl %al,%eax
ffff800000105bed:	89 c6                	mov    %eax,%esi
ffff800000105bef:	bf 23 00 00 00       	mov    $0x23,%edi
ffff800000105bf4:	48 b8 2f 57 10 00 00 	movabs $0xffff80000010572f,%rax
ffff800000105bfb:	80 ff ff 
ffff800000105bfe:	ff d0                	call   *%rax
  }
}
ffff800000105c00:	c9                   	leave
ffff800000105c01:	c3                   	ret

ffff800000105c02 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
ffff800000105c02:	55                   	push   %rbp
ffff800000105c03:	48 89 e5             	mov    %rsp,%rbp
ffff800000105c06:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000105c0a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000105c0e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  struct pipe *p;

  p = 0;
ffff800000105c12:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
ffff800000105c19:	00 
  *f0 = *f1 = 0;
ffff800000105c1a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105c1e:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
ffff800000105c25:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105c29:	48 8b 10             	mov    (%rax),%rdx
ffff800000105c2c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105c30:	48 89 10             	mov    %rdx,(%rax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
ffff800000105c33:	48 b8 4a 1b 10 00 00 	movabs $0xffff800000101b4a,%rax
ffff800000105c3a:	80 ff ff 
ffff800000105c3d:	ff d0                	call   *%rax
ffff800000105c3f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000105c43:	48 89 02             	mov    %rax,(%rdx)
ffff800000105c46:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105c4a:	48 8b 00             	mov    (%rax),%rax
ffff800000105c4d:	48 85 c0             	test   %rax,%rax
ffff800000105c50:	0f 84 01 01 00 00    	je     ffff800000105d57 <pipealloc+0x155>
ffff800000105c56:	48 b8 4a 1b 10 00 00 	movabs $0xffff800000101b4a,%rax
ffff800000105c5d:	80 ff ff 
ffff800000105c60:	ff d0                	call   *%rax
ffff800000105c62:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000105c66:	48 89 02             	mov    %rax,(%rdx)
ffff800000105c69:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105c6d:	48 8b 00             	mov    (%rax),%rax
ffff800000105c70:	48 85 c0             	test   %rax,%rax
ffff800000105c73:	0f 84 de 00 00 00    	je     ffff800000105d57 <pipealloc+0x155>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
ffff800000105c79:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff800000105c80:	80 ff ff 
ffff800000105c83:	ff d0                	call   *%rax
ffff800000105c85:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000105c89:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000105c8e:	0f 84 c6 00 00 00    	je     ffff800000105d5a <pipealloc+0x158>
    goto bad;
  p->readopen = 1;
ffff800000105c94:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105c98:	c7 80 70 02 00 00 01 	movl   $0x1,0x270(%rax)
ffff800000105c9f:	00 00 00 
  p->writeopen = 1;
ffff800000105ca2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105ca6:	c7 80 74 02 00 00 01 	movl   $0x1,0x274(%rax)
ffff800000105cad:	00 00 00 
  p->nwrite = 0;
ffff800000105cb0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105cb4:	c7 80 6c 02 00 00 00 	movl   $0x0,0x26c(%rax)
ffff800000105cbb:	00 00 00 
  p->nread = 0;
ffff800000105cbe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105cc2:	c7 80 68 02 00 00 00 	movl   $0x0,0x268(%rax)
ffff800000105cc9:	00 00 00 
  initlock(&p->lock, "pipe");
ffff800000105ccc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105cd0:	48 ba 86 c3 10 00 00 	movabs $0xffff80000010c386,%rdx
ffff800000105cd7:	80 ff ff 
ffff800000105cda:	48 89 d6             	mov    %rdx,%rsi
ffff800000105cdd:	48 89 c7             	mov    %rax,%rdi
ffff800000105ce0:	48 b8 05 77 10 00 00 	movabs $0xffff800000107705,%rax
ffff800000105ce7:	80 ff ff 
ffff800000105cea:	ff d0                	call   *%rax
  (*f0)->type = FD_PIPE;
ffff800000105cec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105cf0:	48 8b 00             	mov    (%rax),%rax
ffff800000105cf3:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
  (*f0)->readable = 1;
ffff800000105cf9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105cfd:	48 8b 00             	mov    (%rax),%rax
ffff800000105d00:	c6 40 08 01          	movb   $0x1,0x8(%rax)
  (*f0)->writable = 0;
ffff800000105d04:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105d08:	48 8b 00             	mov    (%rax),%rax
ffff800000105d0b:	c6 40 09 00          	movb   $0x0,0x9(%rax)
  (*f0)->pipe = p;
ffff800000105d0f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105d13:	48 8b 00             	mov    (%rax),%rax
ffff800000105d16:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000105d1a:	48 89 50 10          	mov    %rdx,0x10(%rax)
  (*f1)->type = FD_PIPE;
ffff800000105d1e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105d22:	48 8b 00             	mov    (%rax),%rax
ffff800000105d25:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
  (*f1)->readable = 0;
ffff800000105d2b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105d2f:	48 8b 00             	mov    (%rax),%rax
ffff800000105d32:	c6 40 08 00          	movb   $0x0,0x8(%rax)
  (*f1)->writable = 1;
ffff800000105d36:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105d3a:	48 8b 00             	mov    (%rax),%rax
ffff800000105d3d:	c6 40 09 01          	movb   $0x1,0x9(%rax)
  (*f1)->pipe = p;
ffff800000105d41:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105d45:	48 8b 00             	mov    (%rax),%rax
ffff800000105d48:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000105d4c:	48 89 50 10          	mov    %rdx,0x10(%rax)
  return 0;
ffff800000105d50:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105d55:	eb 67                	jmp    ffff800000105dbe <pipealloc+0x1bc>
    goto bad;
ffff800000105d57:	90                   	nop
ffff800000105d58:	eb 01                	jmp    ffff800000105d5b <pipealloc+0x159>
    goto bad;
ffff800000105d5a:	90                   	nop

//PAGEBREAK: 20
 bad:
  if(p)
ffff800000105d5b:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000105d60:	74 13                	je     ffff800000105d75 <pipealloc+0x173>
    kfree((char*)p);
ffff800000105d62:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105d66:	48 89 c7             	mov    %rax,%rdi
ffff800000105d69:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff800000105d70:	80 ff ff 
ffff800000105d73:	ff d0                	call   *%rax
  if(*f0)
ffff800000105d75:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105d79:	48 8b 00             	mov    (%rax),%rax
ffff800000105d7c:	48 85 c0             	test   %rax,%rax
ffff800000105d7f:	74 16                	je     ffff800000105d97 <pipealloc+0x195>
    fileclose(*f0);
ffff800000105d81:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105d85:	48 8b 00             	mov    (%rax),%rax
ffff800000105d88:	48 89 c7             	mov    %rax,%rdi
ffff800000105d8b:	48 b8 5e 1c 10 00 00 	movabs $0xffff800000101c5e,%rax
ffff800000105d92:	80 ff ff 
ffff800000105d95:	ff d0                	call   *%rax
  if(*f1)
ffff800000105d97:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105d9b:	48 8b 00             	mov    (%rax),%rax
ffff800000105d9e:	48 85 c0             	test   %rax,%rax
ffff800000105da1:	74 16                	je     ffff800000105db9 <pipealloc+0x1b7>
    fileclose(*f1);
ffff800000105da3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105da7:	48 8b 00             	mov    (%rax),%rax
ffff800000105daa:	48 89 c7             	mov    %rax,%rdi
ffff800000105dad:	48 b8 5e 1c 10 00 00 	movabs $0xffff800000101c5e,%rax
ffff800000105db4:	80 ff ff 
ffff800000105db7:	ff d0                	call   *%rax
  return -1;
ffff800000105db9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000105dbe:	c9                   	leave
ffff800000105dbf:	c3                   	ret

ffff800000105dc0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
ffff800000105dc0:	55                   	push   %rbp
ffff800000105dc1:	48 89 e5             	mov    %rsp,%rbp
ffff800000105dc4:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000105dc8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000105dcc:	89 75 f4             	mov    %esi,-0xc(%rbp)
  acquire(&p->lock);
ffff800000105dcf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105dd3:	48 89 c7             	mov    %rax,%rdi
ffff800000105dd6:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff800000105ddd:	80 ff ff 
ffff800000105de0:	ff d0                	call   *%rax
  if(writable){
ffff800000105de2:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
ffff800000105de6:	74 29                	je     ffff800000105e11 <pipeclose+0x51>
    p->writeopen = 0;
ffff800000105de8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105dec:	c7 80 74 02 00 00 00 	movl   $0x0,0x274(%rax)
ffff800000105df3:	00 00 00 
    wakeup(&p->nread);
ffff800000105df6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105dfa:	48 05 68 02 00 00    	add    $0x268,%rax
ffff800000105e00:	48 89 c7             	mov    %rax,%rdi
ffff800000105e03:	48 b8 c6 6f 10 00 00 	movabs $0xffff800000106fc6,%rax
ffff800000105e0a:	80 ff ff 
ffff800000105e0d:	ff d0                	call   *%rax
ffff800000105e0f:	eb 27                	jmp    ffff800000105e38 <pipeclose+0x78>
  } else {
    p->readopen = 0;
ffff800000105e11:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105e15:	c7 80 70 02 00 00 00 	movl   $0x0,0x270(%rax)
ffff800000105e1c:	00 00 00 
    wakeup(&p->nwrite);
ffff800000105e1f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105e23:	48 05 6c 02 00 00    	add    $0x26c,%rax
ffff800000105e29:	48 89 c7             	mov    %rax,%rdi
ffff800000105e2c:	48 b8 c6 6f 10 00 00 	movabs $0xffff800000106fc6,%rax
ffff800000105e33:	80 ff ff 
ffff800000105e36:	ff d0                	call   *%rax
  }
  if(p->readopen == 0 && p->writeopen == 0){
ffff800000105e38:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105e3c:	8b 80 70 02 00 00    	mov    0x270(%rax),%eax
ffff800000105e42:	85 c0                	test   %eax,%eax
ffff800000105e44:	75 36                	jne    ffff800000105e7c <pipeclose+0xbc>
ffff800000105e46:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105e4a:	8b 80 74 02 00 00    	mov    0x274(%rax),%eax
ffff800000105e50:	85 c0                	test   %eax,%eax
ffff800000105e52:	75 28                	jne    ffff800000105e7c <pipeclose+0xbc>
    release(&p->lock);
ffff800000105e54:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105e58:	48 89 c7             	mov    %rax,%rdi
ffff800000105e5b:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000105e62:	80 ff ff 
ffff800000105e65:	ff d0                	call   *%rax
    kfree((char*)p);
ffff800000105e67:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105e6b:	48 89 c7             	mov    %rax,%rdi
ffff800000105e6e:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff800000105e75:	80 ff ff 
ffff800000105e78:	ff d0                	call   *%rax
ffff800000105e7a:	eb 14                	jmp    ffff800000105e90 <pipeclose+0xd0>
  } else
    release(&p->lock);
ffff800000105e7c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105e80:	48 89 c7             	mov    %rax,%rdi
ffff800000105e83:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000105e8a:	80 ff ff 
ffff800000105e8d:	ff d0                	call   *%rax
}
ffff800000105e8f:	90                   	nop
ffff800000105e90:	90                   	nop
ffff800000105e91:	c9                   	leave
ffff800000105e92:	c3                   	ret

ffff800000105e93 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
ffff800000105e93:	55                   	push   %rbp
ffff800000105e94:	48 89 e5             	mov    %rsp,%rbp
ffff800000105e97:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000105e9b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000105e9f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000105ea3:	89 55 dc             	mov    %edx,-0x24(%rbp)
  int i;

  acquire(&p->lock);
ffff800000105ea6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105eaa:	48 89 c7             	mov    %rax,%rdi
ffff800000105ead:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff800000105eb4:	80 ff ff 
ffff800000105eb7:	ff d0                	call   *%rax
  for(i = 0; i < n; i++){
ffff800000105eb9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000105ec0:	e9 d5 00 00 00       	jmp    ffff800000105f9a <pipewrite+0x107>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
ffff800000105ec5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105ec9:	8b 80 70 02 00 00    	mov    0x270(%rax),%eax
ffff800000105ecf:	85 c0                	test   %eax,%eax
ffff800000105ed1:	74 12                	je     ffff800000105ee5 <pipewrite+0x52>
ffff800000105ed3:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000105eda:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000105ede:	8b 40 40             	mov    0x40(%rax),%eax
ffff800000105ee1:	85 c0                	test   %eax,%eax
ffff800000105ee3:	74 1d                	je     ffff800000105f02 <pipewrite+0x6f>
        release(&p->lock);
ffff800000105ee5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105ee9:	48 89 c7             	mov    %rax,%rdi
ffff800000105eec:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000105ef3:	80 ff ff 
ffff800000105ef6:	ff d0                	call   *%rax
        return -1;
ffff800000105ef8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000105efd:	e9 cf 00 00 00       	jmp    ffff800000105fd1 <pipewrite+0x13e>
      }
      wakeup(&p->nread);
ffff800000105f02:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f06:	48 05 68 02 00 00    	add    $0x268,%rax
ffff800000105f0c:	48 89 c7             	mov    %rax,%rdi
ffff800000105f0f:	48 b8 c6 6f 10 00 00 	movabs $0xffff800000106fc6,%rax
ffff800000105f16:	80 ff ff 
ffff800000105f19:	ff d0                	call   *%rax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
ffff800000105f1b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f1f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000105f23:	48 81 c2 6c 02 00 00 	add    $0x26c,%rdx
ffff800000105f2a:	48 89 c6             	mov    %rax,%rsi
ffff800000105f2d:	48 89 d7             	mov    %rdx,%rdi
ffff800000105f30:	48 b8 51 6e 10 00 00 	movabs $0xffff800000106e51,%rax
ffff800000105f37:	80 ff ff 
ffff800000105f3a:	ff d0                	call   *%rax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
ffff800000105f3c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f40:	8b 90 6c 02 00 00    	mov    0x26c(%rax),%edx
ffff800000105f46:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f4a:	8b 80 68 02 00 00    	mov    0x268(%rax),%eax
ffff800000105f50:	05 00 02 00 00       	add    $0x200,%eax
ffff800000105f55:	39 c2                	cmp    %eax,%edx
ffff800000105f57:	0f 84 68 ff ff ff    	je     ffff800000105ec5 <pipewrite+0x32>
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
ffff800000105f5d:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000105f60:	48 63 d0             	movslq %eax,%rdx
ffff800000105f63:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105f67:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
ffff800000105f6b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f6f:	8b 80 6c 02 00 00    	mov    0x26c(%rax),%eax
ffff800000105f75:	8d 48 01             	lea    0x1(%rax),%ecx
ffff800000105f78:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000105f7c:	89 8a 6c 02 00 00    	mov    %ecx,0x26c(%rdx)
ffff800000105f82:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff800000105f87:	89 c1                	mov    %eax,%ecx
ffff800000105f89:	0f b6 16             	movzbl (%rsi),%edx
ffff800000105f8c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f90:	89 c9                	mov    %ecx,%ecx
ffff800000105f92:	88 54 08 68          	mov    %dl,0x68(%rax,%rcx,1)
  for(i = 0; i < n; i++){
ffff800000105f96:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000105f9a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000105f9d:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffff800000105fa0:	7c 9a                	jl     ffff800000105f3c <pipewrite+0xa9>
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
ffff800000105fa2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105fa6:	48 05 68 02 00 00    	add    $0x268,%rax
ffff800000105fac:	48 89 c7             	mov    %rax,%rdi
ffff800000105faf:	48 b8 c6 6f 10 00 00 	movabs $0xffff800000106fc6,%rax
ffff800000105fb6:	80 ff ff 
ffff800000105fb9:	ff d0                	call   *%rax
  release(&p->lock);
ffff800000105fbb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105fbf:	48 89 c7             	mov    %rax,%rdi
ffff800000105fc2:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000105fc9:	80 ff ff 
ffff800000105fcc:	ff d0                	call   *%rax
  return n;
ffff800000105fce:	8b 45 dc             	mov    -0x24(%rbp),%eax
}
ffff800000105fd1:	c9                   	leave
ffff800000105fd2:	c3                   	ret

ffff800000105fd3 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
ffff800000105fd3:	55                   	push   %rbp
ffff800000105fd4:	48 89 e5             	mov    %rsp,%rbp
ffff800000105fd7:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000105fdb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000105fdf:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000105fe3:	89 55 dc             	mov    %edx,-0x24(%rbp)
  int i;

  acquire(&p->lock);
ffff800000105fe6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105fea:	48 89 c7             	mov    %rax,%rdi
ffff800000105fed:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff800000105ff4:	80 ff ff 
ffff800000105ff7:	ff d0                	call   *%rax
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
ffff800000105ff9:	eb 50                	jmp    ffff80000010604b <piperead+0x78>
    if(proc->killed){
ffff800000105ffb:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106002:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106006:	8b 40 40             	mov    0x40(%rax),%eax
ffff800000106009:	85 c0                	test   %eax,%eax
ffff80000010600b:	74 1d                	je     ffff80000010602a <piperead+0x57>
      release(&p->lock);
ffff80000010600d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106011:	48 89 c7             	mov    %rax,%rdi
ffff800000106014:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff80000010601b:	80 ff ff 
ffff80000010601e:	ff d0                	call   *%rax
      return -1;
ffff800000106020:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000106025:	e9 de 00 00 00       	jmp    ffff800000106108 <piperead+0x135>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
ffff80000010602a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010602e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000106032:	48 81 c2 68 02 00 00 	add    $0x268,%rdx
ffff800000106039:	48 89 c6             	mov    %rax,%rsi
ffff80000010603c:	48 89 d7             	mov    %rdx,%rdi
ffff80000010603f:	48 b8 51 6e 10 00 00 	movabs $0xffff800000106e51,%rax
ffff800000106046:	80 ff ff 
ffff800000106049:	ff d0                	call   *%rax
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
ffff80000010604b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010604f:	8b 90 68 02 00 00    	mov    0x268(%rax),%edx
ffff800000106055:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106059:	8b 80 6c 02 00 00    	mov    0x26c(%rax),%eax
ffff80000010605f:	39 c2                	cmp    %eax,%edx
ffff800000106061:	75 0e                	jne    ffff800000106071 <piperead+0x9e>
ffff800000106063:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106067:	8b 80 74 02 00 00    	mov    0x274(%rax),%eax
ffff80000010606d:	85 c0                	test   %eax,%eax
ffff80000010606f:	75 8a                	jne    ffff800000105ffb <piperead+0x28>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
ffff800000106071:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000106078:	eb 54                	jmp    ffff8000001060ce <piperead+0xfb>
    if(p->nread == p->nwrite)
ffff80000010607a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010607e:	8b 90 68 02 00 00    	mov    0x268(%rax),%edx
ffff800000106084:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106088:	8b 80 6c 02 00 00    	mov    0x26c(%rax),%eax
ffff80000010608e:	39 c2                	cmp    %eax,%edx
ffff800000106090:	74 46                	je     ffff8000001060d8 <piperead+0x105>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
ffff800000106092:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106096:	8b 80 68 02 00 00    	mov    0x268(%rax),%eax
ffff80000010609c:	8d 48 01             	lea    0x1(%rax),%ecx
ffff80000010609f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff8000001060a3:	89 8a 68 02 00 00    	mov    %ecx,0x268(%rdx)
ffff8000001060a9:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff8000001060ae:	89 c1                	mov    %eax,%ecx
ffff8000001060b0:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001060b3:	48 63 d0             	movslq %eax,%rdx
ffff8000001060b6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001060ba:	48 01 c2             	add    %rax,%rdx
ffff8000001060bd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001060c1:	89 c9                	mov    %ecx,%ecx
ffff8000001060c3:	0f b6 44 08 68       	movzbl 0x68(%rax,%rcx,1),%eax
ffff8000001060c8:	88 02                	mov    %al,(%rdx)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
ffff8000001060ca:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001060ce:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001060d1:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffff8000001060d4:	7c a4                	jl     ffff80000010607a <piperead+0xa7>
ffff8000001060d6:	eb 01                	jmp    ffff8000001060d9 <piperead+0x106>
      break;
ffff8000001060d8:	90                   	nop
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
ffff8000001060d9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001060dd:	48 05 6c 02 00 00    	add    $0x26c,%rax
ffff8000001060e3:	48 89 c7             	mov    %rax,%rdi
ffff8000001060e6:	48 b8 c6 6f 10 00 00 	movabs $0xffff800000106fc6,%rax
ffff8000001060ed:	80 ff ff 
ffff8000001060f0:	ff d0                	call   *%rax
  release(&p->lock);
ffff8000001060f2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001060f6:	48 89 c7             	mov    %rax,%rdi
ffff8000001060f9:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000106100:	80 ff ff 
ffff800000106103:	ff d0                	call   *%rax
  return i;
ffff800000106105:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff800000106108:	c9                   	leave
ffff800000106109:	c3                   	ret

ffff80000010610a <readeflags>:
{
ffff80000010610a:	55                   	push   %rbp
ffff80000010610b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010610e:	48 83 ec 10          	sub    $0x10,%rsp
  asm volatile("pushf; pop %0" : "=r" (eflags));
ffff800000106112:	9c                   	pushf
ffff800000106113:	58                   	pop    %rax
ffff800000106114:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  return eflags;
ffff800000106118:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff80000010611c:	c9                   	leave
ffff80000010611d:	c3                   	ret

ffff80000010611e <sti>:
{
ffff80000010611e:	55                   	push   %rbp
ffff80000010611f:	48 89 e5             	mov    %rsp,%rbp
  asm volatile("sti");
ffff800000106122:	fb                   	sti
}
ffff800000106123:	90                   	nop
ffff800000106124:	5d                   	pop    %rbp
ffff800000106125:	c3                   	ret

ffff800000106126 <hlt>:
{
ffff800000106126:	55                   	push   %rbp
ffff800000106127:	48 89 e5             	mov    %rsp,%rbp
  asm volatile("hlt");
ffff80000010612a:	f4                   	hlt
}
ffff80000010612b:	90                   	nop
ffff80000010612c:	5d                   	pop    %rbp
ffff80000010612d:	c3                   	ret

ffff80000010612e <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
ffff80000010612e:	55                   	push   %rbp
ffff80000010612f:	48 89 e5             	mov    %rsp,%rbp
  initlock(&ptable.lock, "ptable");
ffff800000106132:	48 ba 8b c3 10 00 00 	movabs $0xffff80000010c38b,%rdx
ffff800000106139:	80 ff ff 
ffff80000010613c:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106143:	80 ff ff 
ffff800000106146:	48 89 d6             	mov    %rdx,%rsi
ffff800000106149:	48 89 c7             	mov    %rax,%rdi
ffff80000010614c:	48 b8 05 77 10 00 00 	movabs $0xffff800000107705,%rax
ffff800000106153:	80 ff ff 
ffff800000106156:	ff d0                	call   *%rax
}
ffff800000106158:	90                   	nop
ffff800000106159:	5d                   	pop    %rbp
ffff80000010615a:	c3                   	ret

ffff80000010615b <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
ffff80000010615b:	55                   	push   %rbp
ffff80000010615c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010615f:	48 83 ec 10          	sub    $0x10,%rsp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
ffff800000106163:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff80000010616a:	80 ff ff 
ffff80000010616d:	48 89 c7             	mov    %rax,%rdi
ffff800000106170:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff800000106177:	80 ff ff 
ffff80000010617a:	ff d0                	call   *%rax

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffff80000010617c:	48 b8 a8 74 11 00 00 	movabs $0xffff8000001174a8,%rax
ffff800000106183:	80 ff ff 
ffff800000106186:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010618a:	eb 13                	jmp    ffff80000010619f <allocproc+0x44>
    if(p->state == UNUSED)
ffff80000010618c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106190:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106193:	85 c0                	test   %eax,%eax
ffff800000106195:	74 3b                	je     ffff8000001061d2 <allocproc+0x77>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffff800000106197:	48 81 45 f8 30 01 00 	addq   $0x130,-0x8(%rbp)
ffff80000010619e:	00 
ffff80000010619f:	48 b8 a8 c0 11 00 00 	movabs $0xffff80000011c0a8,%rax
ffff8000001061a6:	80 ff ff 
ffff8000001061a9:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff8000001061ad:	72 dd                	jb     ffff80000010618c <allocproc+0x31>
      goto found;

  release(&ptable.lock);
ffff8000001061af:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff8000001061b6:	80 ff ff 
ffff8000001061b9:	48 89 c7             	mov    %rax,%rdi
ffff8000001061bc:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff8000001061c3:	80 ff ff 
ffff8000001061c6:	ff d0                	call   *%rax
  return 0;
ffff8000001061c8:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001061cd:	e9 05 01 00 00       	jmp    ffff8000001062d7 <allocproc+0x17c>
      goto found;
ffff8000001061d2:	90                   	nop

found:
  p->state = EMBRYO;
ffff8000001061d3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001061d7:	c7 40 18 01 00 00 00 	movl   $0x1,0x18(%rax)
  p->pid = nextpid++;
ffff8000001061de:	48 b8 40 d5 10 00 00 	movabs $0xffff80000010d540,%rax
ffff8000001061e5:	80 ff ff 
ffff8000001061e8:	8b 00                	mov    (%rax),%eax
ffff8000001061ea:	8d 50 01             	lea    0x1(%rax),%edx
ffff8000001061ed:	48 b9 40 d5 10 00 00 	movabs $0xffff80000010d540,%rcx
ffff8000001061f4:	80 ff ff 
ffff8000001061f7:	89 11                	mov    %edx,(%rcx)
ffff8000001061f9:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001061fd:	89 42 1c             	mov    %eax,0x1c(%rdx)

  release(&ptable.lock);
ffff800000106200:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106207:	80 ff ff 
ffff80000010620a:	48 89 c7             	mov    %rax,%rdi
ffff80000010620d:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000106214:	80 ff ff 
ffff800000106217:	ff d0                	call   *%rax

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
ffff800000106219:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff800000106220:	80 ff ff 
ffff800000106223:	ff d0                	call   *%rax
ffff800000106225:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000106229:	48 89 42 10          	mov    %rax,0x10(%rdx)
ffff80000010622d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106231:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000106235:	48 85 c0             	test   %rax,%rax
ffff800000106238:	75 15                	jne    ffff80000010624f <allocproc+0xf4>
    p->state = UNUSED;
ffff80000010623a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010623e:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
    return 0;
ffff800000106245:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010624a:	e9 88 00 00 00       	jmp    ffff8000001062d7 <allocproc+0x17c>
  }
  sp = p->kstack + KSTACKSIZE;
ffff80000010624f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106253:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000106257:	48 05 00 10 00 00    	add    $0x1000,%rax
ffff80000010625d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
ffff800000106261:	48 81 6d f0 b0 00 00 	subq   $0xb0,-0x10(%rbp)
ffff800000106268:	00 
  p->tf = (struct trapframe*)sp;
ffff800000106269:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010626d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000106271:	48 89 50 28          	mov    %rdx,0x28(%rax)

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= sizeof(addr_t);
ffff800000106275:	48 83 6d f0 08       	subq   $0x8,-0x10(%rbp)
  *(addr_t*)sp = (addr_t)syscall_trapret;
ffff80000010627a:	48 ba f8 97 10 00 00 	movabs $0xffff8000001097f8,%rdx
ffff800000106281:	80 ff ff 
ffff800000106284:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106288:	48 89 10             	mov    %rdx,(%rax)

  sp -= sizeof *p->context;
ffff80000010628b:	48 83 6d f0 38       	subq   $0x38,-0x10(%rbp)
  p->context = (struct context*)sp;
ffff800000106290:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106294:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000106298:	48 89 50 30          	mov    %rdx,0x30(%rax)
  memset(p->context, 0, sizeof *p->context);
ffff80000010629c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001062a0:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff8000001062a4:	ba 38 00 00 00       	mov    $0x38,%edx
ffff8000001062a9:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001062ae:	48 89 c7             	mov    %rax,%rdi
ffff8000001062b1:	48 b8 ce 7a 10 00 00 	movabs $0xffff800000107ace,%rax
ffff8000001062b8:	80 ff ff 
ffff8000001062bb:	ff d0                	call   *%rax
  p->context->rip = (addr_t)forkret;
ffff8000001062bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001062c1:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff8000001062c5:	48 ba ef 6d 10 00 00 	movabs $0xffff800000106def,%rdx
ffff8000001062cc:	80 ff ff 
ffff8000001062cf:	48 89 50 30          	mov    %rdx,0x30(%rax)

  return p;
ffff8000001062d3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff8000001062d7:	c9                   	leave
ffff8000001062d8:	c3                   	ret

ffff8000001062d9 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
ffff8000001062d9:	55                   	push   %rbp
ffff8000001062da:	48 89 e5             	mov    %rsp,%rbp
ffff8000001062dd:	48 83 ec 10          	sub    $0x10,%rsp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
  p = allocproc();
ffff8000001062e1:	48 b8 5b 61 10 00 00 	movabs $0xffff80000010615b,%rax
ffff8000001062e8:	80 ff ff 
ffff8000001062eb:	ff d0                	call   *%rax
ffff8000001062ed:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  initproc = p;
ffff8000001062f1:	48 ba a8 c0 11 00 00 	movabs $0xffff80000011c0a8,%rdx
ffff8000001062f8:	80 ff ff 
ffff8000001062fb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001062ff:	48 89 02             	mov    %rax,(%rdx)
  if((p->pgdir = setupkvm()) == 0)
ffff800000106302:	48 b8 63 b0 10 00 00 	movabs $0xffff80000010b063,%rax
ffff800000106309:	80 ff ff 
ffff80000010630c:	ff d0                	call   *%rax
ffff80000010630e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000106312:	48 89 42 08          	mov    %rax,0x8(%rdx)
ffff800000106316:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010631a:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010631e:	48 85 c0             	test   %rax,%rax
ffff800000106321:	75 19                	jne    ffff80000010633c <userinit+0x63>
    panic("userinit: out of memory?");
ffff800000106323:	48 b8 92 c3 10 00 00 	movabs $0xffff80000010c392,%rax
ffff80000010632a:	80 ff ff 
ffff80000010632d:	48 89 c7             	mov    %rax,%rdi
ffff800000106330:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106337:	80 ff ff 
ffff80000010633a:	ff d0                	call   *%rax

  inituvm(p->pgdir, _binary_initcode_start,
ffff80000010633c:	48 b8 40 00 00 00 00 	movabs $0x40,%rax
ffff800000106343:	00 00 00 
ffff800000106346:	89 c2                	mov    %eax,%edx
ffff800000106348:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010634c:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000106350:	48 b9 60 de 10 00 00 	movabs $0xffff80000010de60,%rcx
ffff800000106357:	80 ff ff 
ffff80000010635a:	48 89 ce             	mov    %rcx,%rsi
ffff80000010635d:	48 89 c7             	mov    %rax,%rdi
ffff800000106360:	48 b8 d9 b5 10 00 00 	movabs $0xffff80000010b5d9,%rax
ffff800000106367:	80 ff ff 
ffff80000010636a:	ff d0                	call   *%rax
          (addr_t)_binary_initcode_size);
  p->sz = PGSIZE * 2;
ffff80000010636c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106370:	48 c7 00 00 20 00 00 	movq   $0x2000,(%rax)
  memset(p->tf, 0, sizeof(*p->tf));
ffff800000106377:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010637b:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff80000010637f:	ba b0 00 00 00       	mov    $0xb0,%edx
ffff800000106384:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106389:	48 89 c7             	mov    %rax,%rdi
ffff80000010638c:	48 b8 ce 7a 10 00 00 	movabs $0xffff800000107ace,%rax
ffff800000106393:	80 ff ff 
ffff800000106396:	ff d0                	call   *%rax

  p->tf->r11 = FL_IF;  // with SYSRET, EFLAGS is in R11
ffff800000106398:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010639c:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001063a0:	48 c7 40 50 00 02 00 	movq   $0x200,0x50(%rax)
ffff8000001063a7:	00 
  p->tf->rsp = p->sz;
ffff8000001063a8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001063ac:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001063b0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001063b4:	48 8b 12             	mov    (%rdx),%rdx
ffff8000001063b7:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
  p->tf->rcx = PGSIZE;  // with SYSRET, RIP is in RCX
ffff8000001063be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001063c2:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001063c6:	48 c7 40 10 00 10 00 	movq   $0x1000,0x10(%rax)
ffff8000001063cd:	00 

  safestrcpy(p->name, "initcode", sizeof(p->name));
ffff8000001063ce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001063d2:	48 05 d0 00 00 00    	add    $0xd0,%rax
ffff8000001063d8:	48 b9 ab c3 10 00 00 	movabs $0xffff80000010c3ab,%rcx
ffff8000001063df:	80 ff ff 
ffff8000001063e2:	ba 10 00 00 00       	mov    $0x10,%edx
ffff8000001063e7:	48 89 ce             	mov    %rcx,%rsi
ffff8000001063ea:	48 89 c7             	mov    %rax,%rdi
ffff8000001063ed:	48 b8 86 7d 10 00 00 	movabs $0xffff800000107d86,%rax
ffff8000001063f4:	80 ff ff 
ffff8000001063f7:	ff d0                	call   *%rax
  p->cwd = namei("/");
ffff8000001063f9:	48 b8 b4 c3 10 00 00 	movabs $0xffff80000010c3b4,%rax
ffff800000106400:	80 ff ff 
ffff800000106403:	48 89 c7             	mov    %rax,%rdi
ffff800000106406:	48 b8 93 37 10 00 00 	movabs $0xffff800000103793,%rax
ffff80000010640d:	80 ff ff 
ffff800000106410:	ff d0                	call   *%rax
ffff800000106412:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000106416:	48 89 82 c8 00 00 00 	mov    %rax,0xc8(%rdx)

  __sync_synchronize();
ffff80000010641d:	f0 48 83 0c 24 00    	lock orq $0x0,(%rsp)
  p->state = RUNNABLE;
ffff800000106423:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106427:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
}
ffff80000010642e:	90                   	nop
ffff80000010642f:	c9                   	leave
ffff800000106430:	c3                   	ret

ffff800000106431 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int64 n)
{
ffff800000106431:	55                   	push   %rbp
ffff800000106432:	48 89 e5             	mov    %rsp,%rbp
ffff800000106435:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000106439:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  addr_t sz;

  sz = proc->sz;
ffff80000010643d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106444:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106448:	48 8b 00             	mov    (%rax),%rax
ffff80000010644b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(n > 0){
ffff80000010644f:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff800000106454:	7e 42                	jle    ffff800000106498 <growproc+0x67>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
ffff800000106456:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff80000010645a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010645e:	48 01 c2             	add    %rax,%rdx
ffff800000106461:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106468:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010646c:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000106470:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff800000106474:	48 89 ce             	mov    %rcx,%rsi
ffff800000106477:	48 89 c7             	mov    %rax,%rdi
ffff80000010647a:	48 b8 ba b7 10 00 00 	movabs $0xffff80000010b7ba,%rax
ffff800000106481:	80 ff ff 
ffff800000106484:	ff d0                	call   *%rax
ffff800000106486:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010648a:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff80000010648f:	75 50                	jne    ffff8000001064e1 <growproc+0xb0>
      return -1;
ffff800000106491:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000106496:	eb 7a                	jmp    ffff800000106512 <growproc+0xe1>
  } else if(n < 0){
ffff800000106498:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010649d:	79 42                	jns    ffff8000001064e1 <growproc+0xb0>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
ffff80000010649f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff8000001064a3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001064a7:	48 01 c2             	add    %rax,%rdx
ffff8000001064aa:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001064b1:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001064b5:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff8000001064b9:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff8000001064bd:	48 89 ce             	mov    %rcx,%rsi
ffff8000001064c0:	48 89 c7             	mov    %rax,%rdi
ffff8000001064c3:	48 b8 fe b8 10 00 00 	movabs $0xffff80000010b8fe,%rax
ffff8000001064ca:	80 ff ff 
ffff8000001064cd:	ff d0                	call   *%rax
ffff8000001064cf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001064d3:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff8000001064d8:	75 07                	jne    ffff8000001064e1 <growproc+0xb0>
      return -1;
ffff8000001064da:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001064df:	eb 31                	jmp    ffff800000106512 <growproc+0xe1>
  }
  proc->sz = sz;
ffff8000001064e1:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001064e8:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001064ec:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001064f0:	48 89 10             	mov    %rdx,(%rax)
  switchuvm(proc);
ffff8000001064f3:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001064fa:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001064fe:	48 89 c7             	mov    %rax,%rdi
ffff800000106501:	48 b8 c1 b1 10 00 00 	movabs $0xffff80000010b1c1,%rax
ffff800000106508:	80 ff ff 
ffff80000010650b:	ff d0                	call   *%rax
  return 0;
ffff80000010650d:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000106512:	c9                   	leave
ffff800000106513:	c3                   	ret

ffff800000106514 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
ffff800000106514:	55                   	push   %rbp
ffff800000106515:	48 89 e5             	mov    %rsp,%rbp
ffff800000106518:	53                   	push   %rbx
ffff800000106519:	48 83 ec 28          	sub    $0x28,%rsp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
ffff80000010651d:	48 b8 5b 61 10 00 00 	movabs $0xffff80000010615b,%rax
ffff800000106524:	80 ff ff 
ffff800000106527:	ff d0                	call   *%rax
ffff800000106529:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff80000010652d:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
ffff800000106532:	75 0a                	jne    ffff80000010653e <fork+0x2a>
    return -1;
ffff800000106534:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000106539:	e9 88 02 00 00       	jmp    ffff8000001067c6 <fork+0x2b2>

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
ffff80000010653e:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106545:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106549:	48 8b 00             	mov    (%rax),%rax
ffff80000010654c:	89 c2                	mov    %eax,%edx
ffff80000010654e:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106555:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106559:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010655d:	89 d6                	mov    %edx,%esi
ffff80000010655f:	48 89 c7             	mov    %rax,%rdi
ffff800000106562:	48 b8 99 bc 10 00 00 	movabs $0xffff80000010bc99,%rax
ffff800000106569:	80 ff ff 
ffff80000010656c:	ff d0                	call   *%rax
ffff80000010656e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000106572:	48 89 42 08          	mov    %rax,0x8(%rdx)
ffff800000106576:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010657a:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010657e:	48 85 c0             	test   %rax,%rax
ffff800000106581:	75 38                	jne    ffff8000001065bb <fork+0xa7>
    kfree(np->kstack);
ffff800000106583:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106587:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff80000010658b:	48 89 c7             	mov    %rax,%rdi
ffff80000010658e:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff800000106595:	80 ff ff 
ffff800000106598:	ff d0                	call   *%rax
    np->kstack = 0;
ffff80000010659a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010659e:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff8000001065a5:	00 
    np->state = UNUSED;
ffff8000001065a6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001065aa:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
    return -1;
ffff8000001065b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001065b6:	e9 0b 02 00 00       	jmp    ffff8000001067c6 <fork+0x2b2>
  }
  np->sz = proc->sz;
ffff8000001065bb:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001065c2:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001065c6:	48 8b 10             	mov    (%rax),%rdx
ffff8000001065c9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001065cd:	48 89 10             	mov    %rdx,(%rax)
  np->parent = proc;
ffff8000001065d0:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001065d7:	64 48 8b 10          	mov    %fs:(%rax),%rdx
ffff8000001065db:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001065df:	48 89 50 20          	mov    %rdx,0x20(%rax)
  *np->tf = *proc->tf;
ffff8000001065e3:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001065ea:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001065ee:	48 8b 50 28          	mov    0x28(%rax),%rdx
ffff8000001065f2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001065f6:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001065fa:	48 8b 0a             	mov    (%rdx),%rcx
ffff8000001065fd:	48 8b 5a 08          	mov    0x8(%rdx),%rbx
ffff800000106601:	48 89 08             	mov    %rcx,(%rax)
ffff800000106604:	48 89 58 08          	mov    %rbx,0x8(%rax)
ffff800000106608:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
ffff80000010660c:	48 8b 5a 18          	mov    0x18(%rdx),%rbx
ffff800000106610:	48 89 48 10          	mov    %rcx,0x10(%rax)
ffff800000106614:	48 89 58 18          	mov    %rbx,0x18(%rax)
ffff800000106618:	48 8b 4a 20          	mov    0x20(%rdx),%rcx
ffff80000010661c:	48 8b 5a 28          	mov    0x28(%rdx),%rbx
ffff800000106620:	48 89 48 20          	mov    %rcx,0x20(%rax)
ffff800000106624:	48 89 58 28          	mov    %rbx,0x28(%rax)
ffff800000106628:	48 8b 4a 30          	mov    0x30(%rdx),%rcx
ffff80000010662c:	48 8b 5a 38          	mov    0x38(%rdx),%rbx
ffff800000106630:	48 89 48 30          	mov    %rcx,0x30(%rax)
ffff800000106634:	48 89 58 38          	mov    %rbx,0x38(%rax)
ffff800000106638:	48 8b 4a 40          	mov    0x40(%rdx),%rcx
ffff80000010663c:	48 8b 5a 48          	mov    0x48(%rdx),%rbx
ffff800000106640:	48 89 48 40          	mov    %rcx,0x40(%rax)
ffff800000106644:	48 89 58 48          	mov    %rbx,0x48(%rax)
ffff800000106648:	48 8b 4a 50          	mov    0x50(%rdx),%rcx
ffff80000010664c:	48 8b 5a 58          	mov    0x58(%rdx),%rbx
ffff800000106650:	48 89 48 50          	mov    %rcx,0x50(%rax)
ffff800000106654:	48 89 58 58          	mov    %rbx,0x58(%rax)
ffff800000106658:	48 8b 4a 60          	mov    0x60(%rdx),%rcx
ffff80000010665c:	48 8b 5a 68          	mov    0x68(%rdx),%rbx
ffff800000106660:	48 89 48 60          	mov    %rcx,0x60(%rax)
ffff800000106664:	48 89 58 68          	mov    %rbx,0x68(%rax)
ffff800000106668:	48 8b 4a 70          	mov    0x70(%rdx),%rcx
ffff80000010666c:	48 8b 5a 78          	mov    0x78(%rdx),%rbx
ffff800000106670:	48 89 48 70          	mov    %rcx,0x70(%rax)
ffff800000106674:	48 89 58 78          	mov    %rbx,0x78(%rax)
ffff800000106678:	48 8b 8a 80 00 00 00 	mov    0x80(%rdx),%rcx
ffff80000010667f:	48 8b 9a 88 00 00 00 	mov    0x88(%rdx),%rbx
ffff800000106686:	48 89 88 80 00 00 00 	mov    %rcx,0x80(%rax)
ffff80000010668d:	48 89 98 88 00 00 00 	mov    %rbx,0x88(%rax)
ffff800000106694:	48 8b 8a 90 00 00 00 	mov    0x90(%rdx),%rcx
ffff80000010669b:	48 8b 9a 98 00 00 00 	mov    0x98(%rdx),%rbx
ffff8000001066a2:	48 89 88 90 00 00 00 	mov    %rcx,0x90(%rax)
ffff8000001066a9:	48 89 98 98 00 00 00 	mov    %rbx,0x98(%rax)
ffff8000001066b0:	48 8b 8a a0 00 00 00 	mov    0xa0(%rdx),%rcx
ffff8000001066b7:	48 8b 9a a8 00 00 00 	mov    0xa8(%rdx),%rbx
ffff8000001066be:	48 89 88 a0 00 00 00 	mov    %rcx,0xa0(%rax)
ffff8000001066c5:	48 89 98 a8 00 00 00 	mov    %rbx,0xa8(%rax)

  // Clear %rax so that fork returns 0 in the child.
  np->tf->rax = 0;
ffff8000001066cc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001066d0:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001066d4:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)

  for(i = 0; i < NOFILE; i++)
ffff8000001066db:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
ffff8000001066e2:	eb 5f                	jmp    ffff800000106743 <fork+0x22f>
    if(proc->ofile[i])
ffff8000001066e4:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001066eb:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001066ef:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff8000001066f2:	48 63 d2             	movslq %edx,%rdx
ffff8000001066f5:	48 83 c2 08          	add    $0x8,%rdx
ffff8000001066f9:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff8000001066fe:	48 85 c0             	test   %rax,%rax
ffff800000106701:	74 3c                	je     ffff80000010673f <fork+0x22b>
      np->ofile[i] = filedup(proc->ofile[i]);
ffff800000106703:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010670a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010670e:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff800000106711:	48 63 d2             	movslq %edx,%rdx
ffff800000106714:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106718:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff80000010671d:	48 89 c7             	mov    %rax,%rdi
ffff800000106720:	48 b8 e5 1b 10 00 00 	movabs $0xffff800000101be5,%rax
ffff800000106727:	80 ff ff 
ffff80000010672a:	ff d0                	call   *%rax
ffff80000010672c:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000106730:	8b 4d ec             	mov    -0x14(%rbp),%ecx
ffff800000106733:	48 63 c9             	movslq %ecx,%rcx
ffff800000106736:	48 83 c1 08          	add    $0x8,%rcx
ffff80000010673a:	48 89 44 ca 08       	mov    %rax,0x8(%rdx,%rcx,8)
  for(i = 0; i < NOFILE; i++)
ffff80000010673f:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
ffff800000106743:	83 7d ec 0f          	cmpl   $0xf,-0x14(%rbp)
ffff800000106747:	7e 9b                	jle    ffff8000001066e4 <fork+0x1d0>
  np->cwd = idup(proc->cwd);
ffff800000106749:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106750:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106754:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffff80000010675b:	48 89 c7             	mov    %rax,%rdi
ffff80000010675e:	48 b8 37 28 10 00 00 	movabs $0xffff800000102837,%rax
ffff800000106765:	80 ff ff 
ffff800000106768:	ff d0                	call   *%rax
ffff80000010676a:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff80000010676e:	48 89 82 c8 00 00 00 	mov    %rax,0xc8(%rdx)

  safestrcpy(np->name, proc->name, sizeof(proc->name));
ffff800000106775:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010677c:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106780:	48 8d 88 d0 00 00 00 	lea    0xd0(%rax),%rcx
ffff800000106787:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010678b:	48 05 d0 00 00 00    	add    $0xd0,%rax
ffff800000106791:	ba 10 00 00 00       	mov    $0x10,%edx
ffff800000106796:	48 89 ce             	mov    %rcx,%rsi
ffff800000106799:	48 89 c7             	mov    %rax,%rdi
ffff80000010679c:	48 b8 86 7d 10 00 00 	movabs $0xffff800000107d86,%rax
ffff8000001067a3:	80 ff ff 
ffff8000001067a6:	ff d0                	call   *%rax

  pid = np->pid;
ffff8000001067a8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001067ac:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff8000001067af:	89 45 dc             	mov    %eax,-0x24(%rbp)

  __sync_synchronize();
ffff8000001067b2:	f0 48 83 0c 24 00    	lock orq $0x0,(%rsp)
  np->state = RUNNABLE;
ffff8000001067b8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001067bc:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)

  return pid;
ffff8000001067c3:	8b 45 dc             	mov    -0x24(%rbp),%eax
}
ffff8000001067c6:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
ffff8000001067ca:	c9                   	leave
ffff8000001067cb:	c3                   	ret

ffff8000001067cc <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
ffff8000001067cc:	55                   	push   %rbp
ffff8000001067cd:	48 89 e5             	mov    %rsp,%rbp
ffff8000001067d0:	48 83 ec 10          	sub    $0x10,%rsp
  struct proc *p;
  int fd;

  if(proc == initproc)
ffff8000001067d4:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001067db:	64 48 8b 10          	mov    %fs:(%rax),%rdx
ffff8000001067df:	48 b8 a8 c0 11 00 00 	movabs $0xffff80000011c0a8,%rax
ffff8000001067e6:	80 ff ff 
ffff8000001067e9:	48 8b 00             	mov    (%rax),%rax
ffff8000001067ec:	48 39 c2             	cmp    %rax,%rdx
ffff8000001067ef:	75 19                	jne    ffff80000010680a <exit+0x3e>
    panic("init exiting");
ffff8000001067f1:	48 b8 b6 c3 10 00 00 	movabs $0xffff80000010c3b6,%rax
ffff8000001067f8:	80 ff ff 
ffff8000001067fb:	48 89 c7             	mov    %rax,%rdi
ffff8000001067fe:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106805:	80 ff ff 
ffff800000106808:	ff d0                	call   *%rax

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
ffff80000010680a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
ffff800000106811:	eb 6a                	jmp    ffff80000010687d <exit+0xb1>
    if(proc->ofile[fd]){
ffff800000106813:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010681a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010681e:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff800000106821:	48 63 d2             	movslq %edx,%rdx
ffff800000106824:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106828:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff80000010682d:	48 85 c0             	test   %rax,%rax
ffff800000106830:	74 47                	je     ffff800000106879 <exit+0xad>
      fileclose(proc->ofile[fd]);
ffff800000106832:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106839:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010683d:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff800000106840:	48 63 d2             	movslq %edx,%rdx
ffff800000106843:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106847:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff80000010684c:	48 89 c7             	mov    %rax,%rdi
ffff80000010684f:	48 b8 5e 1c 10 00 00 	movabs $0xffff800000101c5e,%rax
ffff800000106856:	80 ff ff 
ffff800000106859:	ff d0                	call   *%rax
      proc->ofile[fd] = 0;
ffff80000010685b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106862:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106866:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff800000106869:	48 63 d2             	movslq %edx,%rdx
ffff80000010686c:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106870:	48 c7 44 d0 08 00 00 	movq   $0x0,0x8(%rax,%rdx,8)
ffff800000106877:	00 00 
  for(fd = 0; fd < NOFILE; fd++){
ffff800000106879:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
ffff80000010687d:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
ffff800000106881:	7e 90                	jle    ffff800000106813 <exit+0x47>
    }
  }

  begin_op();
ffff800000106883:	48 b8 bd 4e 10 00 00 	movabs $0xffff800000104ebd,%rax
ffff80000010688a:	80 ff ff 
ffff80000010688d:	ff d0                	call   *%rax
  iput(proc->cwd);
ffff80000010688f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106896:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010689a:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffff8000001068a1:	48 89 c7             	mov    %rax,%rdi
ffff8000001068a4:	48 b8 8f 2a 10 00 00 	movabs $0xffff800000102a8f,%rax
ffff8000001068ab:	80 ff ff 
ffff8000001068ae:	ff d0                	call   *%rax
  end_op();
ffff8000001068b0:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff8000001068b7:	80 ff ff 
ffff8000001068ba:	ff d0                	call   *%rax
  proc->cwd = 0;
ffff8000001068bc:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001068c3:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001068c7:	48 c7 80 c8 00 00 00 	movq   $0x0,0xc8(%rax)
ffff8000001068ce:	00 00 00 00 

  acquire(&ptable.lock);
ffff8000001068d2:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff8000001068d9:	80 ff ff 
ffff8000001068dc:	48 89 c7             	mov    %rax,%rdi
ffff8000001068df:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff8000001068e6:	80 ff ff 
ffff8000001068e9:	ff d0                	call   *%rax

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
ffff8000001068eb:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001068f2:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001068f6:	48 8b 40 20          	mov    0x20(%rax),%rax
ffff8000001068fa:	48 89 c7             	mov    %rax,%rdi
ffff8000001068fd:	48 b8 69 6f 10 00 00 	movabs $0xffff800000106f69,%rax
ffff800000106904:	80 ff ff 
ffff800000106907:	ff d0                	call   *%rax

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106909:	48 b8 a8 74 11 00 00 	movabs $0xffff8000001174a8,%rax
ffff800000106910:	80 ff ff 
ffff800000106913:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000106917:	eb 5d                	jmp    ffff800000106976 <exit+0x1aa>
    if(p->parent == proc){
ffff800000106919:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010691d:	48 8b 50 20          	mov    0x20(%rax),%rdx
ffff800000106921:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106928:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010692c:	48 39 c2             	cmp    %rax,%rdx
ffff80000010692f:	75 3d                	jne    ffff80000010696e <exit+0x1a2>
      p->parent = initproc;
ffff800000106931:	48 b8 a8 c0 11 00 00 	movabs $0xffff80000011c0a8,%rax
ffff800000106938:	80 ff ff 
ffff80000010693b:	48 8b 10             	mov    (%rax),%rdx
ffff80000010693e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106942:	48 89 50 20          	mov    %rdx,0x20(%rax)
      if(p->state == ZOMBIE)
ffff800000106946:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010694a:	8b 40 18             	mov    0x18(%rax),%eax
ffff80000010694d:	83 f8 05             	cmp    $0x5,%eax
ffff800000106950:	75 1c                	jne    ffff80000010696e <exit+0x1a2>
        wakeup1(initproc);
ffff800000106952:	48 b8 a8 c0 11 00 00 	movabs $0xffff80000011c0a8,%rax
ffff800000106959:	80 ff ff 
ffff80000010695c:	48 8b 00             	mov    (%rax),%rax
ffff80000010695f:	48 89 c7             	mov    %rax,%rdi
ffff800000106962:	48 b8 69 6f 10 00 00 	movabs $0xffff800000106f69,%rax
ffff800000106969:	80 ff ff 
ffff80000010696c:	ff d0                	call   *%rax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff80000010696e:	48 81 45 f8 30 01 00 	addq   $0x130,-0x8(%rbp)
ffff800000106975:	00 
ffff800000106976:	48 b8 a8 c0 11 00 00 	movabs $0xffff80000011c0a8,%rax
ffff80000010697d:	80 ff ff 
ffff800000106980:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000106984:	72 93                	jb     ffff800000106919 <exit+0x14d>
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
ffff800000106986:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010698d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106991:	c7 40 18 05 00 00 00 	movl   $0x5,0x18(%rax)
  sched();
ffff800000106998:	48 b8 7e 6c 10 00 00 	movabs $0xffff800000106c7e,%rax
ffff80000010699f:	80 ff ff 
ffff8000001069a2:	ff d0                	call   *%rax
  panic("zombie exit");
ffff8000001069a4:	48 b8 c3 c3 10 00 00 	movabs $0xffff80000010c3c3,%rax
ffff8000001069ab:	80 ff ff 
ffff8000001069ae:	48 89 c7             	mov    %rax,%rdi
ffff8000001069b1:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001069b8:	80 ff ff 
ffff8000001069bb:	ff d0                	call   *%rax

ffff8000001069bd <wait>:
//PAGEBREAK!
// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
ffff8000001069bd:	55                   	push   %rbp
ffff8000001069be:	48 89 e5             	mov    %rsp,%rbp
ffff8000001069c1:	48 83 ec 10          	sub    $0x10,%rsp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
ffff8000001069c5:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff8000001069cc:	80 ff ff 
ffff8000001069cf:	48 89 c7             	mov    %rax,%rdi
ffff8000001069d2:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff8000001069d9:	80 ff ff 
ffff8000001069dc:	ff d0                	call   *%rax
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
ffff8000001069de:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff8000001069e5:	48 b8 a8 74 11 00 00 	movabs $0xffff8000001174a8,%rax
ffff8000001069ec:	80 ff ff 
ffff8000001069ef:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001069f3:	e9 d9 00 00 00       	jmp    ffff800000106ad1 <wait+0x114>
      if(p->parent != proc)
ffff8000001069f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001069fc:	48 8b 50 20          	mov    0x20(%rax),%rdx
ffff800000106a00:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106a07:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106a0b:	48 39 c2             	cmp    %rax,%rdx
ffff800000106a0e:	0f 85 b4 00 00 00    	jne    ffff800000106ac8 <wait+0x10b>
        continue;
      havekids = 1;
ffff800000106a14:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
      if(p->state == ZOMBIE){
ffff800000106a1b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106a1f:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106a22:	83 f8 05             	cmp    $0x5,%eax
ffff800000106a25:	0f 85 9e 00 00 00    	jne    ffff800000106ac9 <wait+0x10c>
        // Found one.
        pid = p->pid;
ffff800000106a2b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106a2f:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff800000106a32:	89 45 f0             	mov    %eax,-0x10(%rbp)
        kfree(p->kstack);
ffff800000106a35:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106a39:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000106a3d:	48 89 c7             	mov    %rax,%rdi
ffff800000106a40:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff800000106a47:	80 ff ff 
ffff800000106a4a:	ff d0                	call   *%rax
        p->kstack = 0;
ffff800000106a4c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106a50:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff800000106a57:	00 
        freevm(p->pgdir);
ffff800000106a58:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106a5c:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000106a60:	48 89 c7             	mov    %rax,%rdi
ffff800000106a63:	48 b8 f7 b9 10 00 00 	movabs $0xffff80000010b9f7,%rax
ffff800000106a6a:	80 ff ff 
ffff800000106a6d:	ff d0                	call   *%rax
        p->pid = 0;
ffff800000106a6f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106a73:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%rax)
        p->parent = 0;
ffff800000106a7a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106a7e:	48 c7 40 20 00 00 00 	movq   $0x0,0x20(%rax)
ffff800000106a85:	00 
        p->name[0] = 0;
ffff800000106a86:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106a8a:	c6 80 d0 00 00 00 00 	movb   $0x0,0xd0(%rax)
        p->killed = 0;
ffff800000106a91:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106a95:	c7 40 40 00 00 00 00 	movl   $0x0,0x40(%rax)
        p->state = UNUSED;
ffff800000106a9c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106aa0:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
        release(&ptable.lock);
ffff800000106aa7:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106aae:	80 ff ff 
ffff800000106ab1:	48 89 c7             	mov    %rax,%rdi
ffff800000106ab4:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000106abb:	80 ff ff 
ffff800000106abe:	ff d0                	call   *%rax
        return pid;
ffff800000106ac0:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000106ac3:	e9 81 00 00 00       	jmp    ffff800000106b49 <wait+0x18c>
        continue;
ffff800000106ac8:	90                   	nop
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106ac9:	48 81 45 f8 30 01 00 	addq   $0x130,-0x8(%rbp)
ffff800000106ad0:	00 
ffff800000106ad1:	48 b8 a8 c0 11 00 00 	movabs $0xffff80000011c0a8,%rax
ffff800000106ad8:	80 ff ff 
ffff800000106adb:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000106adf:	0f 82 13 ff ff ff    	jb     ffff8000001069f8 <wait+0x3b>
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
ffff800000106ae5:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
ffff800000106ae9:	74 12                	je     ffff800000106afd <wait+0x140>
ffff800000106aeb:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106af2:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106af6:	8b 40 40             	mov    0x40(%rax),%eax
ffff800000106af9:	85 c0                	test   %eax,%eax
ffff800000106afb:	74 20                	je     ffff800000106b1d <wait+0x160>
      release(&ptable.lock);
ffff800000106afd:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106b04:	80 ff ff 
ffff800000106b07:	48 89 c7             	mov    %rax,%rdi
ffff800000106b0a:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000106b11:	80 ff ff 
ffff800000106b14:	ff d0                	call   *%rax
      return -1;
ffff800000106b16:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000106b1b:	eb 2c                	jmp    ffff800000106b49 <wait+0x18c>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
ffff800000106b1d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106b24:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106b28:	48 ba 40 74 11 00 00 	movabs $0xffff800000117440,%rdx
ffff800000106b2f:	80 ff ff 
ffff800000106b32:	48 89 d6             	mov    %rdx,%rsi
ffff800000106b35:	48 89 c7             	mov    %rax,%rdi
ffff800000106b38:	48 b8 51 6e 10 00 00 	movabs $0xffff800000106e51,%rax
ffff800000106b3f:	80 ff ff 
ffff800000106b42:	ff d0                	call   *%rax
    havekids = 0;
ffff800000106b44:	e9 95 fe ff ff       	jmp    ffff8000001069de <wait+0x21>
  }
}
ffff800000106b49:	c9                   	leave
ffff800000106b4a:	c3                   	ret

ffff800000106b4b <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
ffff800000106b4b:	55                   	push   %rbp
ffff800000106b4c:	48 89 e5             	mov    %rsp,%rbp
ffff800000106b4f:	48 83 ec 20          	sub    $0x20,%rsp
  int i = 0;
ffff800000106b53:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  struct proc *p;
  int skipped = 0;
ffff800000106b5a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
  for(;;){
    ++i;
ffff800000106b61:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    // Enable interrupts on this processor.
    sti();
ffff800000106b65:	48 b8 1e 61 10 00 00 	movabs $0xffff80000010611e,%rax
ffff800000106b6c:	80 ff ff 
ffff800000106b6f:	ff d0                	call   *%rax
    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
ffff800000106b71:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106b78:	80 ff ff 
ffff800000106b7b:	48 89 c7             	mov    %rax,%rdi
ffff800000106b7e:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff800000106b85:	80 ff ff 
ffff800000106b88:	ff d0                	call   *%rax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106b8a:	48 b8 a8 74 11 00 00 	movabs $0xffff8000001174a8,%rax
ffff800000106b91:	80 ff ff 
ffff800000106b94:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000106b98:	e9 92 00 00 00       	jmp    ffff800000106c2f <scheduler+0xe4>
      if(p->state != RUNNABLE) {
ffff800000106b9d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106ba1:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106ba4:	83 f8 03             	cmp    $0x3,%eax
ffff800000106ba7:	74 06                	je     ffff800000106baf <scheduler+0x64>
        skipped++;
ffff800000106ba9:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
        continue;
ffff800000106bad:	eb 78                	jmp    ffff800000106c27 <scheduler+0xdc>
      }
      skipped = 0;
ffff800000106baf:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
ffff800000106bb6:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106bbd:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000106bc1:	64 48 89 10          	mov    %rdx,%fs:(%rax)
      switchuvm(p);
ffff800000106bc5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106bc9:	48 89 c7             	mov    %rax,%rdi
ffff800000106bcc:	48 b8 c1 b1 10 00 00 	movabs $0xffff80000010b1c1,%rax
ffff800000106bd3:	80 ff ff 
ffff800000106bd6:	ff d0                	call   *%rax
      p->state = RUNNING;
ffff800000106bd8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106bdc:	c7 40 18 04 00 00 00 	movl   $0x4,0x18(%rax)
      swtch(&cpu->scheduler, p->context);
ffff800000106be3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106be7:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff800000106beb:	48 c7 c2 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rdx
ffff800000106bf2:	64 48 8b 12          	mov    %fs:(%rdx),%rdx
ffff800000106bf6:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106bfa:	48 89 c6             	mov    %rax,%rsi
ffff800000106bfd:	48 89 d7             	mov    %rdx,%rdi
ffff800000106c00:	48 b8 1b 7e 10 00 00 	movabs $0xffff800000107e1b,%rax
ffff800000106c07:	80 ff ff 
ffff800000106c0a:	ff d0                	call   *%rax
      switchkvm();
ffff800000106c0c:	48 b8 cd b4 10 00 00 	movabs $0xffff80000010b4cd,%rax
ffff800000106c13:	80 ff ff 
ffff800000106c16:	ff d0                	call   *%rax

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
ffff800000106c18:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106c1f:	64 48 c7 00 00 00 00 	movq   $0x0,%fs:(%rax)
ffff800000106c26:	00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106c27:	48 81 45 f0 30 01 00 	addq   $0x130,-0x10(%rbp)
ffff800000106c2e:	00 
ffff800000106c2f:	48 b8 a8 c0 11 00 00 	movabs $0xffff80000011c0a8,%rax
ffff800000106c36:	80 ff ff 
ffff800000106c39:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff800000106c3d:	0f 82 5a ff ff ff    	jb     ffff800000106b9d <scheduler+0x52>
    }
    release(&ptable.lock);
ffff800000106c43:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106c4a:	80 ff ff 
ffff800000106c4d:	48 89 c7             	mov    %rax,%rdi
ffff800000106c50:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000106c57:	80 ff ff 
ffff800000106c5a:	ff d0                	call   *%rax
    if (skipped > NPROC) {
ffff800000106c5c:	83 7d ec 40          	cmpl   $0x40,-0x14(%rbp)
ffff800000106c60:	0f 8e fb fe ff ff    	jle    ffff800000106b61 <scheduler+0x16>
      hlt();
ffff800000106c66:	48 b8 26 61 10 00 00 	movabs $0xffff800000106126,%rax
ffff800000106c6d:	80 ff ff 
ffff800000106c70:	ff d0                	call   *%rax
      skipped = 0;
ffff800000106c72:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    ++i;
ffff800000106c79:	e9 e3 fe ff ff       	jmp    ffff800000106b61 <scheduler+0x16>

ffff800000106c7e <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
ffff800000106c7e:	55                   	push   %rbp
ffff800000106c7f:	48 89 e5             	mov    %rsp,%rbp
ffff800000106c82:	48 83 ec 10          	sub    $0x10,%rsp
  int intena;


  if(!holding(&ptable.lock))
ffff800000106c86:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106c8d:	80 ff ff 
ffff800000106c90:	48 89 c7             	mov    %rax,%rdi
ffff800000106c93:	48 b8 1e 79 10 00 00 	movabs $0xffff80000010791e,%rax
ffff800000106c9a:	80 ff ff 
ffff800000106c9d:	ff d0                	call   *%rax
ffff800000106c9f:	85 c0                	test   %eax,%eax
ffff800000106ca1:	75 19                	jne    ffff800000106cbc <sched+0x3e>
    panic("sched ptable.lock");
ffff800000106ca3:	48 b8 cf c3 10 00 00 	movabs $0xffff80000010c3cf,%rax
ffff800000106caa:	80 ff ff 
ffff800000106cad:	48 89 c7             	mov    %rax,%rdi
ffff800000106cb0:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106cb7:	80 ff ff 
ffff800000106cba:	ff d0                	call   *%rax
  if(cpu->ncli != 1)
ffff800000106cbc:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000106cc3:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106cc7:	8b 40 14             	mov    0x14(%rax),%eax
ffff800000106cca:	83 f8 01             	cmp    $0x1,%eax
ffff800000106ccd:	74 19                	je     ffff800000106ce8 <sched+0x6a>
    panic("sched locks");
ffff800000106ccf:	48 b8 e1 c3 10 00 00 	movabs $0xffff80000010c3e1,%rax
ffff800000106cd6:	80 ff ff 
ffff800000106cd9:	48 89 c7             	mov    %rax,%rdi
ffff800000106cdc:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106ce3:	80 ff ff 
ffff800000106ce6:	ff d0                	call   *%rax
  if(proc->state == RUNNING)
ffff800000106ce8:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106cef:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106cf3:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106cf6:	83 f8 04             	cmp    $0x4,%eax
ffff800000106cf9:	75 19                	jne    ffff800000106d14 <sched+0x96>
    panic("sched running");
ffff800000106cfb:	48 b8 ed c3 10 00 00 	movabs $0xffff80000010c3ed,%rax
ffff800000106d02:	80 ff ff 
ffff800000106d05:	48 89 c7             	mov    %rax,%rdi
ffff800000106d08:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106d0f:	80 ff ff 
ffff800000106d12:	ff d0                	call   *%rax
  if(readeflags()&FL_IF)
ffff800000106d14:	48 b8 0a 61 10 00 00 	movabs $0xffff80000010610a,%rax
ffff800000106d1b:	80 ff ff 
ffff800000106d1e:	ff d0                	call   *%rax
ffff800000106d20:	25 00 02 00 00       	and    $0x200,%eax
ffff800000106d25:	48 85 c0             	test   %rax,%rax
ffff800000106d28:	74 19                	je     ffff800000106d43 <sched+0xc5>
    panic("sched interruptible");
ffff800000106d2a:	48 b8 fb c3 10 00 00 	movabs $0xffff80000010c3fb,%rax
ffff800000106d31:	80 ff ff 
ffff800000106d34:	48 89 c7             	mov    %rax,%rdi
ffff800000106d37:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106d3e:	80 ff ff 
ffff800000106d41:	ff d0                	call   *%rax
  intena = cpu->intena;
ffff800000106d43:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000106d4a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106d4e:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106d51:	89 45 fc             	mov    %eax,-0x4(%rbp)
  swtch(&proc->context, cpu->scheduler);
ffff800000106d54:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000106d5b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106d5f:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000106d63:	48 c7 c2 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rdx
ffff800000106d6a:	64 48 8b 12          	mov    %fs:(%rdx),%rdx
ffff800000106d6e:	48 83 c2 30          	add    $0x30,%rdx
ffff800000106d72:	48 89 c6             	mov    %rax,%rsi
ffff800000106d75:	48 89 d7             	mov    %rdx,%rdi
ffff800000106d78:	48 b8 1b 7e 10 00 00 	movabs $0xffff800000107e1b,%rax
ffff800000106d7f:	80 ff ff 
ffff800000106d82:	ff d0                	call   *%rax
  cpu->intena = intena;
ffff800000106d84:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000106d8b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106d8f:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000106d92:	89 50 18             	mov    %edx,0x18(%rax)
}
ffff800000106d95:	90                   	nop
ffff800000106d96:	c9                   	leave
ffff800000106d97:	c3                   	ret

ffff800000106d98 <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
ffff800000106d98:	55                   	push   %rbp
ffff800000106d99:	48 89 e5             	mov    %rsp,%rbp
  acquire(&ptable.lock);  //DOC: yieldlock
ffff800000106d9c:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106da3:	80 ff ff 
ffff800000106da6:	48 89 c7             	mov    %rax,%rdi
ffff800000106da9:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff800000106db0:	80 ff ff 
ffff800000106db3:	ff d0                	call   *%rax
  proc->state = RUNNABLE;
ffff800000106db5:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106dbc:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106dc0:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
  sched();
ffff800000106dc7:	48 b8 7e 6c 10 00 00 	movabs $0xffff800000106c7e,%rax
ffff800000106dce:	80 ff ff 
ffff800000106dd1:	ff d0                	call   *%rax
  release(&ptable.lock);
ffff800000106dd3:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106dda:	80 ff ff 
ffff800000106ddd:	48 89 c7             	mov    %rax,%rdi
ffff800000106de0:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000106de7:	80 ff ff 
ffff800000106dea:	ff d0                	call   *%rax
}
ffff800000106dec:	90                   	nop
ffff800000106ded:	5d                   	pop    %rbp
ffff800000106dee:	c3                   	ret

ffff800000106def <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
ffff800000106def:	55                   	push   %rbp
ffff800000106df0:	48 89 e5             	mov    %rsp,%rbp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
ffff800000106df3:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106dfa:	80 ff ff 
ffff800000106dfd:	48 89 c7             	mov    %rax,%rdi
ffff800000106e00:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000106e07:	80 ff ff 
ffff800000106e0a:	ff d0                	call   *%rax

  if (first) {
ffff800000106e0c:	48 b8 44 d5 10 00 00 	movabs $0xffff80000010d544,%rax
ffff800000106e13:	80 ff ff 
ffff800000106e16:	8b 00                	mov    (%rax),%eax
ffff800000106e18:	85 c0                	test   %eax,%eax
ffff800000106e1a:	74 32                	je     ffff800000106e4e <forkret+0x5f>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
ffff800000106e1c:	48 b8 44 d5 10 00 00 	movabs $0xffff80000010d544,%rax
ffff800000106e23:	80 ff ff 
ffff800000106e26:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    iinit(ROOTDEV);
ffff800000106e2c:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000106e31:	48 b8 17 24 10 00 00 	movabs $0xffff800000102417,%rax
ffff800000106e38:	80 ff ff 
ffff800000106e3b:	ff d0                	call   *%rax
    initlog(ROOTDEV);
ffff800000106e3d:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000106e42:	48 b8 70 4b 10 00 00 	movabs $0xffff800000104b70,%rax
ffff800000106e49:	80 ff ff 
ffff800000106e4c:	ff d0                	call   *%rax
  }

  // Return to "caller", actually trapret (see allocproc).
}
ffff800000106e4e:	90                   	nop
ffff800000106e4f:	5d                   	pop    %rbp
ffff800000106e50:	c3                   	ret

ffff800000106e51 <sleep>:
//PAGEBREAK!
// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
ffff800000106e51:	55                   	push   %rbp
ffff800000106e52:	48 89 e5             	mov    %rsp,%rbp
ffff800000106e55:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000106e59:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000106e5d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(proc == 0)
ffff800000106e61:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106e68:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106e6c:	48 85 c0             	test   %rax,%rax
ffff800000106e6f:	75 19                	jne    ffff800000106e8a <sleep+0x39>
    panic("sleep");
ffff800000106e71:	48 b8 0f c4 10 00 00 	movabs $0xffff80000010c40f,%rax
ffff800000106e78:	80 ff ff 
ffff800000106e7b:	48 89 c7             	mov    %rax,%rdi
ffff800000106e7e:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106e85:	80 ff ff 
ffff800000106e88:	ff d0                	call   *%rax

  if(lk == 0)
ffff800000106e8a:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000106e8f:	75 19                	jne    ffff800000106eaa <sleep+0x59>
    panic("sleep without lk");
ffff800000106e91:	48 b8 15 c4 10 00 00 	movabs $0xffff80000010c415,%rax
ffff800000106e98:	80 ff ff 
ffff800000106e9b:	48 89 c7             	mov    %rax,%rdi
ffff800000106e9e:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106ea5:	80 ff ff 
ffff800000106ea8:	ff d0                	call   *%rax
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
ffff800000106eaa:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106eb1:	80 ff ff 
ffff800000106eb4:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff800000106eb8:	74 2c                	je     ffff800000106ee6 <sleep+0x95>
    acquire(&ptable.lock);  //DOC: sleeplock1
ffff800000106eba:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106ec1:	80 ff ff 
ffff800000106ec4:	48 89 c7             	mov    %rax,%rdi
ffff800000106ec7:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff800000106ece:	80 ff ff 
ffff800000106ed1:	ff d0                	call   *%rax
    release(lk);
ffff800000106ed3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106ed7:	48 89 c7             	mov    %rax,%rdi
ffff800000106eda:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000106ee1:	80 ff ff 
ffff800000106ee4:	ff d0                	call   *%rax
  }

  // Go to sleep.
  proc->chan = chan;
ffff800000106ee6:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106eed:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106ef1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000106ef5:	48 89 50 38          	mov    %rdx,0x38(%rax)
  proc->state = SLEEPING;
ffff800000106ef9:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106f00:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106f04:	c7 40 18 02 00 00 00 	movl   $0x2,0x18(%rax)
  sched();
ffff800000106f0b:	48 b8 7e 6c 10 00 00 	movabs $0xffff800000106c7e,%rax
ffff800000106f12:	80 ff ff 
ffff800000106f15:	ff d0                	call   *%rax

  // Tidy up.
  proc->chan = 0;
ffff800000106f17:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106f1e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106f22:	48 c7 40 38 00 00 00 	movq   $0x0,0x38(%rax)
ffff800000106f29:	00 

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
ffff800000106f2a:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106f31:	80 ff ff 
ffff800000106f34:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff800000106f38:	74 2c                	je     ffff800000106f66 <sleep+0x115>
    release(&ptable.lock);
ffff800000106f3a:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106f41:	80 ff ff 
ffff800000106f44:	48 89 c7             	mov    %rax,%rdi
ffff800000106f47:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000106f4e:	80 ff ff 
ffff800000106f51:	ff d0                	call   *%rax
    acquire(lk);
ffff800000106f53:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106f57:	48 89 c7             	mov    %rax,%rdi
ffff800000106f5a:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff800000106f61:	80 ff ff 
ffff800000106f64:	ff d0                	call   *%rax
  }
}
ffff800000106f66:	90                   	nop
ffff800000106f67:	c9                   	leave
ffff800000106f68:	c3                   	ret

ffff800000106f69 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
ffff800000106f69:	55                   	push   %rbp
ffff800000106f6a:	48 89 e5             	mov    %rsp,%rbp
ffff800000106f6d:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000106f71:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffff800000106f75:	48 b8 a8 74 11 00 00 	movabs $0xffff8000001174a8,%rax
ffff800000106f7c:	80 ff ff 
ffff800000106f7f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000106f83:	eb 2d                	jmp    ffff800000106fb2 <wakeup1+0x49>
    if(p->state == SLEEPING && p->chan == chan)
ffff800000106f85:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106f89:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106f8c:	83 f8 02             	cmp    $0x2,%eax
ffff800000106f8f:	75 19                	jne    ffff800000106faa <wakeup1+0x41>
ffff800000106f91:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106f95:	48 8b 40 38          	mov    0x38(%rax),%rax
ffff800000106f99:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffff800000106f9d:	75 0b                	jne    ffff800000106faa <wakeup1+0x41>
      p->state = RUNNABLE;
ffff800000106f9f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106fa3:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffff800000106faa:	48 81 45 f8 30 01 00 	addq   $0x130,-0x8(%rbp)
ffff800000106fb1:	00 
ffff800000106fb2:	48 b8 a8 c0 11 00 00 	movabs $0xffff80000011c0a8,%rax
ffff800000106fb9:	80 ff ff 
ffff800000106fbc:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000106fc0:	72 c3                	jb     ffff800000106f85 <wakeup1+0x1c>
}
ffff800000106fc2:	90                   	nop
ffff800000106fc3:	90                   	nop
ffff800000106fc4:	c9                   	leave
ffff800000106fc5:	c3                   	ret

ffff800000106fc6 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
ffff800000106fc6:	55                   	push   %rbp
ffff800000106fc7:	48 89 e5             	mov    %rsp,%rbp
ffff800000106fca:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000106fce:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&ptable.lock);
ffff800000106fd2:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106fd9:	80 ff ff 
ffff800000106fdc:	48 89 c7             	mov    %rax,%rdi
ffff800000106fdf:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff800000106fe6:	80 ff ff 
ffff800000106fe9:	ff d0                	call   *%rax
  wakeup1(chan);
ffff800000106feb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106fef:	48 89 c7             	mov    %rax,%rdi
ffff800000106ff2:	48 b8 69 6f 10 00 00 	movabs $0xffff800000106f69,%rax
ffff800000106ff9:	80 ff ff 
ffff800000106ffc:	ff d0                	call   *%rax
  release(&ptable.lock);
ffff800000106ffe:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000107005:	80 ff ff 
ffff800000107008:	48 89 c7             	mov    %rax,%rdi
ffff80000010700b:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000107012:	80 ff ff 
ffff800000107015:	ff d0                	call   *%rax
}
ffff800000107017:	90                   	nop
ffff800000107018:	c9                   	leave
ffff800000107019:	c3                   	ret

ffff80000010701a <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
ffff80000010701a:	55                   	push   %rbp
ffff80000010701b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010701e:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000107022:	89 7d ec             	mov    %edi,-0x14(%rbp)
  struct proc *p;

  acquire(&ptable.lock);
ffff800000107025:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff80000010702c:	80 ff ff 
ffff80000010702f:	48 89 c7             	mov    %rax,%rdi
ffff800000107032:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff800000107039:	80 ff ff 
ffff80000010703c:	ff d0                	call   *%rax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff80000010703e:	48 b8 a8 74 11 00 00 	movabs $0xffff8000001174a8,%rax
ffff800000107045:	80 ff ff 
ffff800000107048:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010704c:	eb 56                	jmp    ffff8000001070a4 <kill+0x8a>
    if(p->pid == pid){
ffff80000010704e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107052:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff800000107055:	39 45 ec             	cmp    %eax,-0x14(%rbp)
ffff800000107058:	75 42                	jne    ffff80000010709c <kill+0x82>
      p->killed = 1;
ffff80000010705a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010705e:	c7 40 40 01 00 00 00 	movl   $0x1,0x40(%rax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
ffff800000107065:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107069:	8b 40 18             	mov    0x18(%rax),%eax
ffff80000010706c:	83 f8 02             	cmp    $0x2,%eax
ffff80000010706f:	75 0b                	jne    ffff80000010707c <kill+0x62>
        p->state = RUNNABLE;
ffff800000107071:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107075:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
      release(&ptable.lock);
ffff80000010707c:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000107083:	80 ff ff 
ffff800000107086:	48 89 c7             	mov    %rax,%rdi
ffff800000107089:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000107090:	80 ff ff 
ffff800000107093:	ff d0                	call   *%rax
      return 0;
ffff800000107095:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010709a:	eb 36                	jmp    ffff8000001070d2 <kill+0xb8>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff80000010709c:	48 81 45 f8 30 01 00 	addq   $0x130,-0x8(%rbp)
ffff8000001070a3:	00 
ffff8000001070a4:	48 b8 a8 c0 11 00 00 	movabs $0xffff80000011c0a8,%rax
ffff8000001070ab:	80 ff ff 
ffff8000001070ae:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff8000001070b2:	72 9a                	jb     ffff80000010704e <kill+0x34>
    }
  }
  release(&ptable.lock);
ffff8000001070b4:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff8000001070bb:	80 ff ff 
ffff8000001070be:	48 89 c7             	mov    %rax,%rdi
ffff8000001070c1:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff8000001070c8:	80 ff ff 
ffff8000001070cb:	ff d0                	call   *%rax
  return -1;
ffff8000001070cd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff8000001070d2:	c9                   	leave
ffff8000001070d3:	c3                   	ret

ffff8000001070d4 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
ffff8000001070d4:	55                   	push   %rbp
ffff8000001070d5:	48 89 e5             	mov    %rsp,%rbp
ffff8000001070d8:	48 83 ec 70          	sub    $0x70,%rsp
  int i;
  struct proc *p;
  char *state;
  addr_t pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff8000001070dc:	48 b8 a8 74 11 00 00 	movabs $0xffff8000001174a8,%rax
ffff8000001070e3:	80 ff ff 
ffff8000001070e6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff8000001070ea:	e9 41 01 00 00       	jmp    ffff800000107230 <procdump+0x15c>
    if(p->state == UNUSED)
ffff8000001070ef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001070f3:	8b 40 18             	mov    0x18(%rax),%eax
ffff8000001070f6:	85 c0                	test   %eax,%eax
ffff8000001070f8:	0f 84 29 01 00 00    	je     ffff800000107227 <procdump+0x153>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
ffff8000001070fe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107102:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000107105:	83 f8 05             	cmp    $0x5,%eax
ffff800000107108:	77 39                	ja     ffff800000107143 <procdump+0x6f>
ffff80000010710a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010710e:	8b 50 18             	mov    0x18(%rax),%edx
ffff800000107111:	48 b8 60 d5 10 00 00 	movabs $0xffff80000010d560,%rax
ffff800000107118:	80 ff ff 
ffff80000010711b:	89 d2                	mov    %edx,%edx
ffff80000010711d:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
ffff800000107121:	48 85 c0             	test   %rax,%rax
ffff800000107124:	74 1d                	je     ffff800000107143 <procdump+0x6f>
      state = states[p->state];
ffff800000107126:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010712a:	8b 50 18             	mov    0x18(%rax),%edx
ffff80000010712d:	48 b8 60 d5 10 00 00 	movabs $0xffff80000010d560,%rax
ffff800000107134:	80 ff ff 
ffff800000107137:	89 d2                	mov    %edx,%edx
ffff800000107139:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
ffff80000010713d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000107141:	eb 0e                	jmp    ffff800000107151 <procdump+0x7d>
    else
      state = "???";
ffff800000107143:	48 b8 26 c4 10 00 00 	movabs $0xffff80000010c426,%rax
ffff80000010714a:	80 ff ff 
ffff80000010714d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    cprintf("%d %s %s", p->pid, state, p->name);
ffff800000107151:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107155:	48 8d 88 d0 00 00 00 	lea    0xd0(%rax),%rcx
ffff80000010715c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107160:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff800000107163:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000107167:	48 bf 2a c4 10 00 00 	movabs $0xffff80000010c42a,%rdi
ffff80000010716e:	80 ff ff 
ffff800000107171:	89 c6                	mov    %eax,%esi
ffff800000107173:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000107178:	49 b8 04 08 10 00 00 	movabs $0xffff800000100804,%r8
ffff80000010717f:	80 ff ff 
ffff800000107182:	41 ff d0             	call   *%r8
    if(p->state == SLEEPING){
ffff800000107185:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107189:	8b 40 18             	mov    0x18(%rax),%eax
ffff80000010718c:	83 f8 02             	cmp    $0x2,%eax
ffff80000010718f:	75 76                	jne    ffff800000107207 <procdump+0x133>
      getstackpcs((addr_t*)p->context->rbp+2, pc);
ffff800000107191:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107195:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff800000107199:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff80000010719d:	48 83 c0 10          	add    $0x10,%rax
ffff8000001071a1:	48 89 c2             	mov    %rax,%rdx
ffff8000001071a4:	48 8d 45 90          	lea    -0x70(%rbp),%rax
ffff8000001071a8:	48 89 c6             	mov    %rax,%rsi
ffff8000001071ab:	48 89 d7             	mov    %rdx,%rdi
ffff8000001071ae:	48 b8 84 78 10 00 00 	movabs $0xffff800000107884,%rax
ffff8000001071b5:	80 ff ff 
ffff8000001071b8:	ff d0                	call   *%rax
      for(i=0; i<10 && pc[i] != 0; i++)
ffff8000001071ba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001071c1:	eb 2f                	jmp    ffff8000001071f2 <procdump+0x11e>
        cprintf(" %p", pc[i]);
ffff8000001071c3:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001071c6:	48 98                	cltq
ffff8000001071c8:	48 8b 44 c5 90       	mov    -0x70(%rbp,%rax,8),%rax
ffff8000001071cd:	48 ba 33 c4 10 00 00 	movabs $0xffff80000010c433,%rdx
ffff8000001071d4:	80 ff ff 
ffff8000001071d7:	48 89 c6             	mov    %rax,%rsi
ffff8000001071da:	48 89 d7             	mov    %rdx,%rdi
ffff8000001071dd:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001071e2:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff8000001071e9:	80 ff ff 
ffff8000001071ec:	ff d2                	call   *%rdx
      for(i=0; i<10 && pc[i] != 0; i++)
ffff8000001071ee:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001071f2:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffff8000001071f6:	7f 0f                	jg     ffff800000107207 <procdump+0x133>
ffff8000001071f8:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001071fb:	48 98                	cltq
ffff8000001071fd:	48 8b 44 c5 90       	mov    -0x70(%rbp,%rax,8),%rax
ffff800000107202:	48 85 c0             	test   %rax,%rax
ffff800000107205:	75 bc                	jne    ffff8000001071c3 <procdump+0xef>
    }
    cprintf("\n");
ffff800000107207:	48 b8 37 c4 10 00 00 	movabs $0xffff80000010c437,%rax
ffff80000010720e:	80 ff ff 
ffff800000107211:	48 89 c7             	mov    %rax,%rdi
ffff800000107214:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000107219:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000107220:	80 ff ff 
ffff800000107223:	ff d2                	call   *%rdx
ffff800000107225:	eb 01                	jmp    ffff800000107228 <procdump+0x154>
      continue;
ffff800000107227:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000107228:	48 81 45 f0 30 01 00 	addq   $0x130,-0x10(%rbp)
ffff80000010722f:	00 
ffff800000107230:	48 b8 a8 c0 11 00 00 	movabs $0xffff80000011c0a8,%rax
ffff800000107237:	80 ff ff 
ffff80000010723a:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff80000010723e:	0f 82 ab fe ff ff    	jb     ffff8000001070ef <procdump+0x1b>
  }
}
ffff800000107244:	90                   	nop
ffff800000107245:	90                   	nop
ffff800000107246:	c9                   	leave
ffff800000107247:	c3                   	ret

ffff800000107248 <send>:

int send(int pid, void* msg) {
ffff800000107248:	55                   	push   %rbp
ffff800000107249:	48 89 e5             	mov    %rsp,%rbp
ffff80000010724c:	48 83 ec 70          	sub    $0x70,%rsp
ffff800000107250:	89 7d 9c             	mov    %edi,-0x64(%rbp)
ffff800000107253:	48 89 75 90          	mov    %rsi,-0x70(%rbp)
	struct proc *target_p;
	struct ipc_msg kmsg;

	if (copyin(proc->pgdir, (void*)&kmsg, (addr_t)msg, sizeof(struct ipc_msg)) < 0) {
ffff800000107257:	48 8b 55 90          	mov    -0x70(%rbp),%rdx
ffff80000010725b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107262:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107266:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010726a:	48 8d 75 a0          	lea    -0x60(%rbp),%rsi
ffff80000010726e:	b9 4c 00 00 00       	mov    $0x4c,%ecx
ffff800000107273:	48 89 c7             	mov    %rax,%rdi
ffff800000107276:	48 b8 87 bf 10 00 00 	movabs $0xffff80000010bf87,%rax
ffff80000010727d:	80 ff ff 
ffff800000107280:	ff d0                	call   *%rax
ffff800000107282:	85 c0                	test   %eax,%eax
ffff800000107284:	79 0a                	jns    ffff800000107290 <send+0x48>
		return -1;
ffff800000107286:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010728b:	e9 53 01 00 00       	jmp    ffff8000001073e3 <send+0x19b>
	}

	kmsg.sender_pid = proc->pid;
ffff800000107290:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107297:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010729b:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff80000010729e:	89 45 a0             	mov    %eax,-0x60(%rbp)

	acquire(&ptable.lock);
ffff8000001072a1:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff8000001072a8:	80 ff ff 
ffff8000001072ab:	48 89 c7             	mov    %rax,%rdi
ffff8000001072ae:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff8000001072b5:	80 ff ff 
ffff8000001072b8:	ff d0                	call   *%rax
	for (target_p = ptable.proc; target_p < &ptable.proc[NPROC]; target_p++) {
ffff8000001072ba:	48 b8 a8 74 11 00 00 	movabs $0xffff8000001174a8,%rax
ffff8000001072c1:	80 ff ff 
ffff8000001072c4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001072c8:	eb 14                	jmp    ffff8000001072de <send+0x96>
		if (target_p->pid == pid) {
ffff8000001072ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001072ce:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff8000001072d1:	39 45 9c             	cmp    %eax,-0x64(%rbp)
ffff8000001072d4:	74 3b                	je     ffff800000107311 <send+0xc9>
	for (target_p = ptable.proc; target_p < &ptable.proc[NPROC]; target_p++) {
ffff8000001072d6:	48 81 45 f8 30 01 00 	addq   $0x130,-0x8(%rbp)
ffff8000001072dd:	00 
ffff8000001072de:	48 b8 a8 c0 11 00 00 	movabs $0xffff80000011c0a8,%rax
ffff8000001072e5:	80 ff ff 
ffff8000001072e8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff8000001072ec:	72 dc                	jb     ffff8000001072ca <send+0x82>
			goto found;
		}
	}
	release(&ptable.lock);
ffff8000001072ee:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff8000001072f5:	80 ff ff 
ffff8000001072f8:	48 89 c7             	mov    %rax,%rdi
ffff8000001072fb:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000107302:	80 ff ff 
ffff800000107305:	ff d0                	call   *%rax

	return -1;
ffff800000107307:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010730c:	e9 d2 00 00 00       	jmp    ffff8000001073e3 <send+0x19b>
			goto found;
ffff800000107311:	90                   	nop

found:
	while(target_p->has_msg == 1){
ffff800000107312:	eb 5b                	jmp    ffff80000010736f <send+0x127>
		if(proc->killed){
ffff800000107314:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010731b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010731f:	8b 40 40             	mov    0x40(%rax),%eax
ffff800000107322:	85 c0                	test   %eax,%eax
ffff800000107324:	74 23                	je     ffff800000107349 <send+0x101>
			release(&ptable.lock);
ffff800000107326:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff80000010732d:	80 ff ff 
ffff800000107330:	48 89 c7             	mov    %rax,%rdi
ffff800000107333:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff80000010733a:	80 ff ff 
ffff80000010733d:	ff d0                	call   *%rax
			return -1;
ffff80000010733f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000107344:	e9 9a 00 00 00       	jmp    ffff8000001073e3 <send+0x19b>
		}
		sleep(&target_p->has_msg, &ptable.lock); 
ffff800000107349:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010734d:	48 05 2c 01 00 00    	add    $0x12c,%rax
ffff800000107353:	48 ba 40 74 11 00 00 	movabs $0xffff800000117440,%rdx
ffff80000010735a:	80 ff ff 
ffff80000010735d:	48 89 d6             	mov    %rdx,%rsi
ffff800000107360:	48 89 c7             	mov    %rax,%rdi
ffff800000107363:	48 b8 51 6e 10 00 00 	movabs $0xffff800000106e51,%rax
ffff80000010736a:	80 ff ff 
ffff80000010736d:	ff d0                	call   *%rax
	while(target_p->has_msg == 1){
ffff80000010736f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107373:	8b 80 2c 01 00 00    	mov    0x12c(%rax),%eax
ffff800000107379:	83 f8 01             	cmp    $0x1,%eax
ffff80000010737c:	74 96                	je     ffff800000107314 <send+0xcc>
	}

	memmove(&target_p->mailbox, &kmsg, sizeof(struct ipc_msg));
ffff80000010737e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107382:	48 8d 88 e0 00 00 00 	lea    0xe0(%rax),%rcx
ffff800000107389:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
ffff80000010738d:	ba 4c 00 00 00       	mov    $0x4c,%edx
ffff800000107392:	48 89 c6             	mov    %rax,%rsi
ffff800000107395:	48 89 cf             	mov    %rcx,%rdi
ffff800000107398:	48 b8 d3 7b 10 00 00 	movabs $0xffff800000107bd3,%rax
ffff80000010739f:	80 ff ff 
ffff8000001073a2:	ff d0                	call   *%rax
	target_p->has_msg = 1;
ffff8000001073a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001073a8:	c7 80 2c 01 00 00 01 	movl   $0x1,0x12c(%rax)
ffff8000001073af:	00 00 00 

	wakeup1(target_p); 
ffff8000001073b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001073b6:	48 89 c7             	mov    %rax,%rdi
ffff8000001073b9:	48 b8 69 6f 10 00 00 	movabs $0xffff800000106f69,%rax
ffff8000001073c0:	80 ff ff 
ffff8000001073c3:	ff d0                	call   *%rax
	release(&ptable.lock);
ffff8000001073c5:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff8000001073cc:	80 ff ff 
ffff8000001073cf:	48 89 c7             	mov    %rax,%rdi
ffff8000001073d2:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff8000001073d9:	80 ff ff 
ffff8000001073dc:	ff d0                	call   *%rax

	return 0;
ffff8000001073de:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff8000001073e3:	c9                   	leave
ffff8000001073e4:	c3                   	ret

ffff8000001073e5 <recv>:

int recv(void *msg) {
ffff8000001073e5:	55                   	push   %rbp
ffff8000001073e6:	48 89 e5             	mov    %rsp,%rbp
ffff8000001073e9:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001073ed:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
	acquire(&ptable.lock);
ffff8000001073f1:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff8000001073f8:	80 ff ff 
ffff8000001073fb:	48 89 c7             	mov    %rax,%rdi
ffff8000001073fe:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff800000107405:	80 ff ff 
ffff800000107408:	ff d0                	call   *%rax

	while(proc->has_msg == 0){
ffff80000010740a:	eb 5c                	jmp    ffff800000107468 <recv+0x83>
		if(proc->killed){
ffff80000010740c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107413:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107417:	8b 40 40             	mov    0x40(%rax),%eax
ffff80000010741a:	85 c0                	test   %eax,%eax
ffff80000010741c:	74 23                	je     ffff800000107441 <recv+0x5c>
			release(&ptable.lock);
ffff80000010741e:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000107425:	80 ff ff 
ffff800000107428:	48 89 c7             	mov    %rax,%rdi
ffff80000010742b:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000107432:	80 ff ff 
ffff800000107435:	ff d0                	call   *%rax
			return -1;
ffff800000107437:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010743c:	e9 ec 00 00 00       	jmp    ffff80000010752d <recv+0x148>
		}
		sleep(proc, &ptable.lock);
ffff800000107441:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107448:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010744c:	48 ba 40 74 11 00 00 	movabs $0xffff800000117440,%rdx
ffff800000107453:	80 ff ff 
ffff800000107456:	48 89 d6             	mov    %rdx,%rsi
ffff800000107459:	48 89 c7             	mov    %rax,%rdi
ffff80000010745c:	48 b8 51 6e 10 00 00 	movabs $0xffff800000106e51,%rax
ffff800000107463:	80 ff ff 
ffff800000107466:	ff d0                	call   *%rax
	while(proc->has_msg == 0){
ffff800000107468:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010746f:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107473:	8b 80 2c 01 00 00    	mov    0x12c(%rax),%eax
ffff800000107479:	85 c0                	test   %eax,%eax
ffff80000010747b:	74 8f                	je     ffff80000010740c <recv+0x27>
	}


	proc->has_msg = 0;
ffff80000010747d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107484:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107488:	c7 80 2c 01 00 00 00 	movl   $0x0,0x12c(%rax)
ffff80000010748f:	00 00 00 
	wakeup1(&proc->has_msg);
ffff800000107492:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107499:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010749d:	48 05 2c 01 00 00    	add    $0x12c,%rax
ffff8000001074a3:	48 89 c7             	mov    %rax,%rdi
ffff8000001074a6:	48 b8 69 6f 10 00 00 	movabs $0xffff800000106f69,%rax
ffff8000001074ad:	80 ff ff 
ffff8000001074b0:	ff d0                	call   *%rax
	release(&ptable.lock);
ffff8000001074b2:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff8000001074b9:	80 ff ff 
ffff8000001074bc:	48 89 c7             	mov    %rax,%rdi
ffff8000001074bf:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff8000001074c6:	80 ff ff 
ffff8000001074c9:	ff d0                	call   *%rax

	if(copyout(proc->pgdir, (addr_t)msg, (char*)&proc->mailbox, sizeof(struct ipc_msg)) < 0){
ffff8000001074cb:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001074d2:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001074d6:	48 8d 90 e0 00 00 00 	lea    0xe0(%rax),%rdx
ffff8000001074dd:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
ffff8000001074e1:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001074e8:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001074ec:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff8000001074f0:	b9 4c 00 00 00       	mov    $0x4c,%ecx
ffff8000001074f5:	48 89 c7             	mov    %rax,%rdi
ffff8000001074f8:	48 b8 a0 be 10 00 00 	movabs $0xffff80000010bea0,%rax
ffff8000001074ff:	80 ff ff 
ffff800000107502:	ff d0                	call   *%rax
ffff800000107504:	85 c0                	test   %eax,%eax
ffff800000107506:	79 20                	jns    ffff800000107528 <recv+0x143>
		release(&ptable.lock);
ffff800000107508:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff80000010750f:	80 ff ff 
ffff800000107512:	48 89 c7             	mov    %rax,%rdi
ffff800000107515:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff80000010751c:	80 ff ff 
ffff80000010751f:	ff d0                	call   *%rax
		return -1;
ffff800000107521:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000107526:	eb 05                	jmp    ffff80000010752d <recv+0x148>
	}

	return 0;
ffff800000107528:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010752d:	c9                   	leave
ffff80000010752e:	c3                   	ret

ffff80000010752f <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
ffff80000010752f:	55                   	push   %rbp
ffff800000107530:	48 89 e5             	mov    %rsp,%rbp
ffff800000107533:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107537:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff80000010753b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  initlock(&lk->lk, "sleep lock");
ffff80000010753f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107543:	48 83 c0 08          	add    $0x8,%rax
ffff800000107547:	48 ba 63 c4 10 00 00 	movabs $0xffff80000010c463,%rdx
ffff80000010754e:	80 ff ff 
ffff800000107551:	48 89 d6             	mov    %rdx,%rsi
ffff800000107554:	48 89 c7             	mov    %rax,%rdi
ffff800000107557:	48 b8 05 77 10 00 00 	movabs $0xffff800000107705,%rax
ffff80000010755e:	80 ff ff 
ffff800000107561:	ff d0                	call   *%rax
  lk->name = name;
ffff800000107563:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107567:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff80000010756b:	48 89 50 70          	mov    %rdx,0x70(%rax)
  lk->locked = 0;
ffff80000010756f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107573:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  lk->pid = 0;
ffff800000107579:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010757d:	c7 40 78 00 00 00 00 	movl   $0x0,0x78(%rax)
}
ffff800000107584:	90                   	nop
ffff800000107585:	c9                   	leave
ffff800000107586:	c3                   	ret

ffff800000107587 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
ffff800000107587:	55                   	push   %rbp
ffff800000107588:	48 89 e5             	mov    %rsp,%rbp
ffff80000010758b:	48 83 ec 10          	sub    $0x10,%rsp
ffff80000010758f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&lk->lk);
ffff800000107593:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107597:	48 83 c0 08          	add    $0x8,%rax
ffff80000010759b:	48 89 c7             	mov    %rax,%rdi
ffff80000010759e:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff8000001075a5:	80 ff ff 
ffff8000001075a8:	ff d0                	call   *%rax
  while (lk->locked)
ffff8000001075aa:	eb 1e                	jmp    ffff8000001075ca <acquiresleep+0x43>
    sleep(lk, &lk->lk);
ffff8000001075ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001075b0:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffff8000001075b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001075b8:	48 89 d6             	mov    %rdx,%rsi
ffff8000001075bb:	48 89 c7             	mov    %rax,%rdi
ffff8000001075be:	48 b8 51 6e 10 00 00 	movabs $0xffff800000106e51,%rax
ffff8000001075c5:	80 ff ff 
ffff8000001075c8:	ff d0                	call   *%rax
  while (lk->locked)
ffff8000001075ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001075ce:	8b 00                	mov    (%rax),%eax
ffff8000001075d0:	85 c0                	test   %eax,%eax
ffff8000001075d2:	75 d8                	jne    ffff8000001075ac <acquiresleep+0x25>
  lk->locked = 1;
ffff8000001075d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001075d8:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
  lk->pid = proc->pid;
ffff8000001075de:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001075e5:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001075e9:	8b 50 1c             	mov    0x1c(%rax),%edx
ffff8000001075ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001075f0:	89 50 78             	mov    %edx,0x78(%rax)
  release(&lk->lk);
ffff8000001075f3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001075f7:	48 83 c0 08          	add    $0x8,%rax
ffff8000001075fb:	48 89 c7             	mov    %rax,%rdi
ffff8000001075fe:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000107605:	80 ff ff 
ffff800000107608:	ff d0                	call   *%rax
}
ffff80000010760a:	90                   	nop
ffff80000010760b:	c9                   	leave
ffff80000010760c:	c3                   	ret

ffff80000010760d <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
ffff80000010760d:	55                   	push   %rbp
ffff80000010760e:	48 89 e5             	mov    %rsp,%rbp
ffff800000107611:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107615:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&lk->lk);
ffff800000107619:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010761d:	48 83 c0 08          	add    $0x8,%rax
ffff800000107621:	48 89 c7             	mov    %rax,%rdi
ffff800000107624:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff80000010762b:	80 ff ff 
ffff80000010762e:	ff d0                	call   *%rax
  lk->locked = 0;
ffff800000107630:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107634:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  lk->pid = 0;
ffff80000010763a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010763e:	c7 40 78 00 00 00 00 	movl   $0x0,0x78(%rax)
  wakeup(lk);
ffff800000107645:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107649:	48 89 c7             	mov    %rax,%rdi
ffff80000010764c:	48 b8 c6 6f 10 00 00 	movabs $0xffff800000106fc6,%rax
ffff800000107653:	80 ff ff 
ffff800000107656:	ff d0                	call   *%rax
  release(&lk->lk);
ffff800000107658:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010765c:	48 83 c0 08          	add    $0x8,%rax
ffff800000107660:	48 89 c7             	mov    %rax,%rdi
ffff800000107663:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff80000010766a:	80 ff ff 
ffff80000010766d:	ff d0                	call   *%rax
}
ffff80000010766f:	90                   	nop
ffff800000107670:	c9                   	leave
ffff800000107671:	c3                   	ret

ffff800000107672 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
ffff800000107672:	55                   	push   %rbp
ffff800000107673:	48 89 e5             	mov    %rsp,%rbp
ffff800000107676:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010767a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  acquire(&lk->lk);
ffff80000010767e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107682:	48 83 c0 08          	add    $0x8,%rax
ffff800000107686:	48 89 c7             	mov    %rax,%rdi
ffff800000107689:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff800000107690:	80 ff ff 
ffff800000107693:	ff d0                	call   *%rax
  int r = lk->locked;
ffff800000107695:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107699:	8b 00                	mov    (%rax),%eax
ffff80000010769b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  release(&lk->lk);
ffff80000010769e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001076a2:	48 83 c0 08          	add    $0x8,%rax
ffff8000001076a6:	48 89 c7             	mov    %rax,%rdi
ffff8000001076a9:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff8000001076b0:	80 ff ff 
ffff8000001076b3:	ff d0                	call   *%rax
  return r;
ffff8000001076b5:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff8000001076b8:	c9                   	leave
ffff8000001076b9:	c3                   	ret

ffff8000001076ba <readeflags>:
{
ffff8000001076ba:	55                   	push   %rbp
ffff8000001076bb:	48 89 e5             	mov    %rsp,%rbp
ffff8000001076be:	48 83 ec 10          	sub    $0x10,%rsp
  asm volatile("pushf; pop %0" : "=r" (eflags));
ffff8000001076c2:	9c                   	pushf
ffff8000001076c3:	58                   	pop    %rax
ffff8000001076c4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  return eflags;
ffff8000001076c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff8000001076cc:	c9                   	leave
ffff8000001076cd:	c3                   	ret

ffff8000001076ce <cli>:
{
ffff8000001076ce:	55                   	push   %rbp
ffff8000001076cf:	48 89 e5             	mov    %rsp,%rbp
  asm volatile("cli");
ffff8000001076d2:	fa                   	cli
}
ffff8000001076d3:	90                   	nop
ffff8000001076d4:	5d                   	pop    %rbp
ffff8000001076d5:	c3                   	ret

ffff8000001076d6 <sti>:
{
ffff8000001076d6:	55                   	push   %rbp
ffff8000001076d7:	48 89 e5             	mov    %rsp,%rbp
  asm volatile("sti");
ffff8000001076da:	fb                   	sti
}
ffff8000001076db:	90                   	nop
ffff8000001076dc:	5d                   	pop    %rbp
ffff8000001076dd:	c3                   	ret

ffff8000001076de <xchg>:
{
ffff8000001076de:	55                   	push   %rbp
ffff8000001076df:	48 89 e5             	mov    %rsp,%rbp
ffff8000001076e2:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001076e6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff8000001076ea:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  asm volatile("lock; xchgl %0, %1" :
ffff8000001076ee:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff8000001076f2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001076f6:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffff8000001076fa:	f0 87 02             	lock xchg %eax,(%rdx)
ffff8000001076fd:	89 45 fc             	mov    %eax,-0x4(%rbp)
  return result;
ffff800000107700:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff800000107703:	c9                   	leave
ffff800000107704:	c3                   	ret

ffff800000107705 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
ffff800000107705:	55                   	push   %rbp
ffff800000107706:	48 89 e5             	mov    %rsp,%rbp
ffff800000107709:	48 83 ec 10          	sub    $0x10,%rsp
ffff80000010770d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107711:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  lk->name = name;
ffff800000107715:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107719:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff80000010771d:	48 89 50 08          	mov    %rdx,0x8(%rax)
  lk->locked = 0;
ffff800000107721:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107725:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  lk->cpu = 0;
ffff80000010772b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010772f:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff800000107736:	00 
}
ffff800000107737:	90                   	nop
ffff800000107738:	c9                   	leave
ffff800000107739:	c3                   	ret

ffff80000010773a <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
ffff80000010773a:	55                   	push   %rbp
ffff80000010773b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010773e:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107742:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  pushcli(); // disable interrupts to avoid deadlock.
ffff800000107746:	48 b8 5a 79 10 00 00 	movabs $0xffff80000010795a,%rax
ffff80000010774d:	80 ff ff 
ffff800000107750:	ff d0                	call   *%rax
  if(holding(lk))
ffff800000107752:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107756:	48 89 c7             	mov    %rax,%rdi
ffff800000107759:	48 b8 1e 79 10 00 00 	movabs $0xffff80000010791e,%rax
ffff800000107760:	80 ff ff 
ffff800000107763:	ff d0                	call   *%rax
ffff800000107765:	85 c0                	test   %eax,%eax
ffff800000107767:	74 19                	je     ffff800000107782 <acquire+0x48>
    panic("acquire");
ffff800000107769:	48 b8 6e c4 10 00 00 	movabs $0xffff80000010c46e,%rax
ffff800000107770:	80 ff ff 
ffff800000107773:	48 89 c7             	mov    %rax,%rdi
ffff800000107776:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010777d:	80 ff ff 
ffff800000107780:	ff d0                	call   *%rax

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
ffff800000107782:	90                   	nop
ffff800000107783:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107787:	be 01 00 00 00       	mov    $0x1,%esi
ffff80000010778c:	48 89 c7             	mov    %rax,%rdi
ffff80000010778f:	48 b8 de 76 10 00 00 	movabs $0xffff8000001076de,%rax
ffff800000107796:	80 ff ff 
ffff800000107799:	ff d0                	call   *%rax
ffff80000010779b:	85 c0                	test   %eax,%eax
ffff80000010779d:	75 e4                	jne    ffff800000107783 <acquire+0x49>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
ffff80000010779f:	f0 48 83 0c 24 00    	lock orq $0x0,(%rsp)

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
ffff8000001077a5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001077a9:	48 c7 c2 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rdx
ffff8000001077b0:	64 48 8b 12          	mov    %fs:(%rdx),%rdx
ffff8000001077b4:	48 89 50 10          	mov    %rdx,0x10(%rax)
  getcallerpcs(&lk, lk->pcs);
ffff8000001077b8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001077bc:	48 8d 50 18          	lea    0x18(%rax),%rdx
ffff8000001077c0:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff8000001077c4:	48 89 d6             	mov    %rdx,%rsi
ffff8000001077c7:	48 89 c7             	mov    %rax,%rdi
ffff8000001077ca:	48 b8 50 78 10 00 00 	movabs $0xffff800000107850,%rax
ffff8000001077d1:	80 ff ff 
ffff8000001077d4:	ff d0                	call   *%rax
}
ffff8000001077d6:	90                   	nop
ffff8000001077d7:	c9                   	leave
ffff8000001077d8:	c3                   	ret

ffff8000001077d9 <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
ffff8000001077d9:	55                   	push   %rbp
ffff8000001077da:	48 89 e5             	mov    %rsp,%rbp
ffff8000001077dd:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001077e1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  if(!holding(lk))
ffff8000001077e5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001077e9:	48 89 c7             	mov    %rax,%rdi
ffff8000001077ec:	48 b8 1e 79 10 00 00 	movabs $0xffff80000010791e,%rax
ffff8000001077f3:	80 ff ff 
ffff8000001077f6:	ff d0                	call   *%rax
ffff8000001077f8:	85 c0                	test   %eax,%eax
ffff8000001077fa:	75 19                	jne    ffff800000107815 <release+0x3c>
    panic("release");
ffff8000001077fc:	48 b8 76 c4 10 00 00 	movabs $0xffff80000010c476,%rax
ffff800000107803:	80 ff ff 
ffff800000107806:	48 89 c7             	mov    %rax,%rdi
ffff800000107809:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000107810:	80 ff ff 
ffff800000107813:	ff d0                	call   *%rax

  lk->pcs[0] = 0;
ffff800000107815:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107819:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
ffff800000107820:	00 
  lk->cpu = 0;
ffff800000107821:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107825:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff80000010782c:	00 
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
ffff80000010782d:	f0 48 83 0c 24 00    	lock orq $0x0,(%rsp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
ffff800000107833:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107837:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010783b:	c7 00 00 00 00 00    	movl   $0x0,(%rax)

  popcli();
ffff800000107841:	48 b8 c8 79 10 00 00 	movabs $0xffff8000001079c8,%rax
ffff800000107848:	80 ff ff 
ffff80000010784b:	ff d0                	call   *%rax
}
ffff80000010784d:	90                   	nop
ffff80000010784e:	c9                   	leave
ffff80000010784f:	c3                   	ret

ffff800000107850 <getcallerpcs>:

// Record the current call stack in pcs[] by following the %rbp chain.
void
getcallerpcs(void *v, addr_t pcs[])
{
ffff800000107850:	55                   	push   %rbp
ffff800000107851:	48 89 e5             	mov    %rsp,%rbp
ffff800000107854:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000107858:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010785c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  addr_t *rbp;

  asm volatile("mov %%rbp, %0" : "=r" (rbp));
ffff800000107860:	48 89 e8             	mov    %rbp,%rax
ffff800000107863:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  getstackpcs(rbp, pcs);
ffff800000107867:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff80000010786b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010786f:	48 89 d6             	mov    %rdx,%rsi
ffff800000107872:	48 89 c7             	mov    %rax,%rdi
ffff800000107875:	48 b8 84 78 10 00 00 	movabs $0xffff800000107884,%rax
ffff80000010787c:	80 ff ff 
ffff80000010787f:	ff d0                	call   *%rax
}
ffff800000107881:	90                   	nop
ffff800000107882:	c9                   	leave
ffff800000107883:	c3                   	ret

ffff800000107884 <getstackpcs>:

void
getstackpcs(addr_t *rbp, addr_t pcs[])
{
ffff800000107884:	55                   	push   %rbp
ffff800000107885:	48 89 e5             	mov    %rsp,%rbp
ffff800000107888:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010788c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107890:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;

  for(i = 0; i < 10; i++){
ffff800000107894:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010789b:	eb 50                	jmp    ffff8000001078ed <getstackpcs+0x69>
    if(rbp == 0 || rbp < (addr_t*)KERNBASE || rbp == (addr_t*)0xffffffff)
ffff80000010789d:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff8000001078a2:	74 70                	je     ffff800000107914 <getstackpcs+0x90>
ffff8000001078a4:	48 b8 ff ff ff ff ff 	movabs $0xffff7fffffffffff,%rax
ffff8000001078ab:	7f ff ff 
ffff8000001078ae:	48 3b 45 e8          	cmp    -0x18(%rbp),%rax
ffff8000001078b2:	73 60                	jae    ffff800000107914 <getstackpcs+0x90>
ffff8000001078b4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001078b9:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffff8000001078bd:	74 55                	je     ffff800000107914 <getstackpcs+0x90>
      break;
    pcs[i] = rbp[1];     // saved %rip
ffff8000001078bf:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001078c2:	48 98                	cltq
ffff8000001078c4:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff8000001078cb:	00 
ffff8000001078cc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001078d0:	48 01 c2             	add    %rax,%rdx
ffff8000001078d3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001078d7:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff8000001078db:	48 89 02             	mov    %rax,(%rdx)
    rbp = (addr_t*)rbp[0]; // saved %rbp
ffff8000001078de:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001078e2:	48 8b 00             	mov    (%rax),%rax
ffff8000001078e5:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  for(i = 0; i < 10; i++){
ffff8000001078e9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001078ed:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffff8000001078f1:	7e aa                	jle    ffff80000010789d <getstackpcs+0x19>
  }
  for(; i < 10; i++)
ffff8000001078f3:	eb 1f                	jmp    ffff800000107914 <getstackpcs+0x90>
    pcs[i] = 0;
ffff8000001078f5:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001078f8:	48 98                	cltq
ffff8000001078fa:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff800000107901:	00 
ffff800000107902:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000107906:	48 01 d0             	add    %rdx,%rax
ffff800000107909:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  for(; i < 10; i++)
ffff800000107910:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000107914:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffff800000107918:	7e db                	jle    ffff8000001078f5 <getstackpcs+0x71>
}
ffff80000010791a:	90                   	nop
ffff80000010791b:	90                   	nop
ffff80000010791c:	c9                   	leave
ffff80000010791d:	c3                   	ret

ffff80000010791e <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
ffff80000010791e:	55                   	push   %rbp
ffff80000010791f:	48 89 e5             	mov    %rsp,%rbp
ffff800000107922:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000107926:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  return lock->locked && lock->cpu == cpu;
ffff80000010792a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010792e:	8b 00                	mov    (%rax),%eax
ffff800000107930:	85 c0                	test   %eax,%eax
ffff800000107932:	74 1f                	je     ffff800000107953 <holding+0x35>
ffff800000107934:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107938:	48 8b 50 10          	mov    0x10(%rax),%rdx
ffff80000010793c:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000107943:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107947:	48 39 c2             	cmp    %rax,%rdx
ffff80000010794a:	75 07                	jne    ffff800000107953 <holding+0x35>
ffff80000010794c:	b8 01 00 00 00       	mov    $0x1,%eax
ffff800000107951:	eb 05                	jmp    ffff800000107958 <holding+0x3a>
ffff800000107953:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000107958:	c9                   	leave
ffff800000107959:	c3                   	ret

ffff80000010795a <pushcli>:
// Pushcli/popcli are like cli/sti except that they are matched:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.
void
pushcli(void)
{
ffff80000010795a:	55                   	push   %rbp
ffff80000010795b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010795e:	48 83 ec 10          	sub    $0x10,%rsp
  int eflags;

  eflags = readeflags();
ffff800000107962:	48 b8 ba 76 10 00 00 	movabs $0xffff8000001076ba,%rax
ffff800000107969:	80 ff ff 
ffff80000010796c:	ff d0                	call   *%rax
ffff80000010796e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  cli();
ffff800000107971:	48 b8 ce 76 10 00 00 	movabs $0xffff8000001076ce,%rax
ffff800000107978:	80 ff ff 
ffff80000010797b:	ff d0                	call   *%rax
  if(cpu->ncli == 0)
ffff80000010797d:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000107984:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107988:	8b 40 14             	mov    0x14(%rax),%eax
ffff80000010798b:	85 c0                	test   %eax,%eax
ffff80000010798d:	75 17                	jne    ffff8000001079a6 <pushcli+0x4c>
    cpu->intena = eflags & FL_IF;
ffff80000010798f:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000107996:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010799a:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010799d:	81 e2 00 02 00 00    	and    $0x200,%edx
ffff8000001079a3:	89 50 18             	mov    %edx,0x18(%rax)
  cpu->ncli += 1;
ffff8000001079a6:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff8000001079ad:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001079b1:	8b 50 14             	mov    0x14(%rax),%edx
ffff8000001079b4:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff8000001079bb:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001079bf:	83 c2 01             	add    $0x1,%edx
ffff8000001079c2:	89 50 14             	mov    %edx,0x14(%rax)
}
ffff8000001079c5:	90                   	nop
ffff8000001079c6:	c9                   	leave
ffff8000001079c7:	c3                   	ret

ffff8000001079c8 <popcli>:

void
popcli(void)
{
ffff8000001079c8:	55                   	push   %rbp
ffff8000001079c9:	48 89 e5             	mov    %rsp,%rbp
  if(readeflags()&FL_IF)
ffff8000001079cc:	48 b8 ba 76 10 00 00 	movabs $0xffff8000001076ba,%rax
ffff8000001079d3:	80 ff ff 
ffff8000001079d6:	ff d0                	call   *%rax
ffff8000001079d8:	25 00 02 00 00       	and    $0x200,%eax
ffff8000001079dd:	48 85 c0             	test   %rax,%rax
ffff8000001079e0:	74 19                	je     ffff8000001079fb <popcli+0x33>
    panic("popcli - interruptible");
ffff8000001079e2:	48 b8 7e c4 10 00 00 	movabs $0xffff80000010c47e,%rax
ffff8000001079e9:	80 ff ff 
ffff8000001079ec:	48 89 c7             	mov    %rax,%rdi
ffff8000001079ef:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001079f6:	80 ff ff 
ffff8000001079f9:	ff d0                	call   *%rax
  if(--cpu->ncli < 0)
ffff8000001079fb:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000107a02:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107a06:	8b 50 14             	mov    0x14(%rax),%edx
ffff800000107a09:	83 ea 01             	sub    $0x1,%edx
ffff800000107a0c:	89 50 14             	mov    %edx,0x14(%rax)
ffff800000107a0f:	8b 40 14             	mov    0x14(%rax),%eax
ffff800000107a12:	85 c0                	test   %eax,%eax
ffff800000107a14:	79 19                	jns    ffff800000107a2f <popcli+0x67>
    panic("popcli");
ffff800000107a16:	48 b8 95 c4 10 00 00 	movabs $0xffff80000010c495,%rax
ffff800000107a1d:	80 ff ff 
ffff800000107a20:	48 89 c7             	mov    %rax,%rdi
ffff800000107a23:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000107a2a:	80 ff ff 
ffff800000107a2d:	ff d0                	call   *%rax
  if(cpu->ncli == 0 && cpu->intena)
ffff800000107a2f:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000107a36:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107a3a:	8b 40 14             	mov    0x14(%rax),%eax
ffff800000107a3d:	85 c0                	test   %eax,%eax
ffff800000107a3f:	75 1e                	jne    ffff800000107a5f <popcli+0x97>
ffff800000107a41:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000107a48:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107a4c:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000107a4f:	85 c0                	test   %eax,%eax
ffff800000107a51:	74 0c                	je     ffff800000107a5f <popcli+0x97>
    sti();
ffff800000107a53:	48 b8 d6 76 10 00 00 	movabs $0xffff8000001076d6,%rax
ffff800000107a5a:	80 ff ff 
ffff800000107a5d:	ff d0                	call   *%rax
}
ffff800000107a5f:	90                   	nop
ffff800000107a60:	5d                   	pop    %rbp
ffff800000107a61:	c3                   	ret

ffff800000107a62 <stosb>:
{
ffff800000107a62:	55                   	push   %rbp
ffff800000107a63:	48 89 e5             	mov    %rsp,%rbp
ffff800000107a66:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107a6a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107a6e:	89 75 f4             	mov    %esi,-0xc(%rbp)
ffff800000107a71:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
ffff800000107a74:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff800000107a78:	8b 55 f0             	mov    -0x10(%rbp),%edx
ffff800000107a7b:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000107a7e:	48 89 ce             	mov    %rcx,%rsi
ffff800000107a81:	48 89 f7             	mov    %rsi,%rdi
ffff800000107a84:	89 d1                	mov    %edx,%ecx
ffff800000107a86:	fc                   	cld
ffff800000107a87:	f3 aa                	rep stos %al,(%rdi)
ffff800000107a89:	89 ca                	mov    %ecx,%edx
ffff800000107a8b:	48 89 fe             	mov    %rdi,%rsi
ffff800000107a8e:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
ffff800000107a92:	89 55 f0             	mov    %edx,-0x10(%rbp)
}
ffff800000107a95:	90                   	nop
ffff800000107a96:	c9                   	leave
ffff800000107a97:	c3                   	ret

ffff800000107a98 <stosl>:
{
ffff800000107a98:	55                   	push   %rbp
ffff800000107a99:	48 89 e5             	mov    %rsp,%rbp
ffff800000107a9c:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107aa0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107aa4:	89 75 f4             	mov    %esi,-0xc(%rbp)
ffff800000107aa7:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosl" :
ffff800000107aaa:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff800000107aae:	8b 55 f0             	mov    -0x10(%rbp),%edx
ffff800000107ab1:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000107ab4:	48 89 ce             	mov    %rcx,%rsi
ffff800000107ab7:	48 89 f7             	mov    %rsi,%rdi
ffff800000107aba:	89 d1                	mov    %edx,%ecx
ffff800000107abc:	fc                   	cld
ffff800000107abd:	f3 ab                	rep stos %eax,(%rdi)
ffff800000107abf:	89 ca                	mov    %ecx,%edx
ffff800000107ac1:	48 89 fe             	mov    %rdi,%rsi
ffff800000107ac4:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
ffff800000107ac8:	89 55 f0             	mov    %edx,-0x10(%rbp)
}
ffff800000107acb:	90                   	nop
ffff800000107acc:	c9                   	leave
ffff800000107acd:	c3                   	ret

ffff800000107ace <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint64 n)
{
ffff800000107ace:	55                   	push   %rbp
ffff800000107acf:	48 89 e5             	mov    %rsp,%rbp
ffff800000107ad2:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000107ad6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107ada:	89 75 f4             	mov    %esi,-0xc(%rbp)
ffff800000107add:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  if ((addr_t)dst%4 == 0 && n%4 == 0){
ffff800000107ae1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107ae5:	83 e0 03             	and    $0x3,%eax
ffff800000107ae8:	48 85 c0             	test   %rax,%rax
ffff800000107aeb:	75 53                	jne    ffff800000107b40 <memset+0x72>
ffff800000107aed:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107af1:	83 e0 03             	and    $0x3,%eax
ffff800000107af4:	48 85 c0             	test   %rax,%rax
ffff800000107af7:	75 47                	jne    ffff800000107b40 <memset+0x72>
    c &= 0xFF;
ffff800000107af9:	81 65 f4 ff 00 00 00 	andl   $0xff,-0xc(%rbp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
ffff800000107b00:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107b04:	48 c1 e8 02          	shr    $0x2,%rax
ffff800000107b08:	89 c6                	mov    %eax,%esi
ffff800000107b0a:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000107b0d:	c1 e0 18             	shl    $0x18,%eax
ffff800000107b10:	89 c2                	mov    %eax,%edx
ffff800000107b12:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000107b15:	c1 e0 10             	shl    $0x10,%eax
ffff800000107b18:	09 c2                	or     %eax,%edx
ffff800000107b1a:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000107b1d:	c1 e0 08             	shl    $0x8,%eax
ffff800000107b20:	09 d0                	or     %edx,%eax
ffff800000107b22:	0b 45 f4             	or     -0xc(%rbp),%eax
ffff800000107b25:	89 c1                	mov    %eax,%ecx
ffff800000107b27:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107b2b:	89 f2                	mov    %esi,%edx
ffff800000107b2d:	89 ce                	mov    %ecx,%esi
ffff800000107b2f:	48 89 c7             	mov    %rax,%rdi
ffff800000107b32:	48 b8 98 7a 10 00 00 	movabs $0xffff800000107a98,%rax
ffff800000107b39:	80 ff ff 
ffff800000107b3c:	ff d0                	call   *%rax
ffff800000107b3e:	eb 1e                	jmp    ffff800000107b5e <memset+0x90>
  } else
    stosb(dst, c, n);
ffff800000107b40:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107b44:	89 c2                	mov    %eax,%edx
ffff800000107b46:	8b 4d f4             	mov    -0xc(%rbp),%ecx
ffff800000107b49:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107b4d:	89 ce                	mov    %ecx,%esi
ffff800000107b4f:	48 89 c7             	mov    %rax,%rdi
ffff800000107b52:	48 b8 62 7a 10 00 00 	movabs $0xffff800000107a62,%rax
ffff800000107b59:	80 ff ff 
ffff800000107b5c:	ff d0                	call   *%rax
  return dst;
ffff800000107b5e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000107b62:	c9                   	leave
ffff800000107b63:	c3                   	ret

ffff800000107b64 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
ffff800000107b64:	55                   	push   %rbp
ffff800000107b65:	48 89 e5             	mov    %rsp,%rbp
ffff800000107b68:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000107b6c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107b70:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000107b74:	89 55 dc             	mov    %edx,-0x24(%rbp)
  const uchar *s1, *s2;

  s1 = v1;
ffff800000107b77:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107b7b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  s2 = v2;
ffff800000107b7f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000107b83:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0){
ffff800000107b87:	eb 34                	jmp    ffff800000107bbd <memcmp+0x59>
    if(*s1 != *s2)
ffff800000107b89:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107b8d:	0f b6 10             	movzbl (%rax),%edx
ffff800000107b90:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107b94:	0f b6 00             	movzbl (%rax),%eax
ffff800000107b97:	38 c2                	cmp    %al,%dl
ffff800000107b99:	74 18                	je     ffff800000107bb3 <memcmp+0x4f>
      return *s1 - *s2;
ffff800000107b9b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107b9f:	0f b6 00             	movzbl (%rax),%eax
ffff800000107ba2:	0f b6 d0             	movzbl %al,%edx
ffff800000107ba5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107ba9:	0f b6 00             	movzbl (%rax),%eax
ffff800000107bac:	0f b6 c0             	movzbl %al,%eax
ffff800000107baf:	29 c2                	sub    %eax,%edx
ffff800000107bb1:	eb 1c                	jmp    ffff800000107bcf <memcmp+0x6b>
    s1++, s2++;
ffff800000107bb3:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffff800000107bb8:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(n-- > 0){
ffff800000107bbd:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107bc0:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000107bc3:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000107bc6:	85 c0                	test   %eax,%eax
ffff800000107bc8:	75 bf                	jne    ffff800000107b89 <memcmp+0x25>
  }

  return 0;
ffff800000107bca:	ba 00 00 00 00       	mov    $0x0,%edx
}
ffff800000107bcf:	89 d0                	mov    %edx,%eax
ffff800000107bd1:	c9                   	leave
ffff800000107bd2:	c3                   	ret

ffff800000107bd3 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
ffff800000107bd3:	55                   	push   %rbp
ffff800000107bd4:	48 89 e5             	mov    %rsp,%rbp
ffff800000107bd7:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000107bdb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107bdf:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000107be3:	89 55 dc             	mov    %edx,-0x24(%rbp)
  const char *s;
  char *d;

  s = src;
ffff800000107be6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000107bea:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  d = dst;
ffff800000107bee:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107bf2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  if(s < d && s + n > d){
ffff800000107bf6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107bfa:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
ffff800000107bfe:	73 63                	jae    ffff800000107c63 <memmove+0x90>
ffff800000107c00:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffff800000107c03:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107c07:	48 01 d0             	add    %rdx,%rax
ffff800000107c0a:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff800000107c0e:	73 53                	jae    ffff800000107c63 <memmove+0x90>
    s += n;
ffff800000107c10:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107c13:	48 01 45 f8          	add    %rax,-0x8(%rbp)
    d += n;
ffff800000107c17:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107c1a:	48 01 45 f0          	add    %rax,-0x10(%rbp)
    while(n-- > 0)
ffff800000107c1e:	eb 17                	jmp    ffff800000107c37 <memmove+0x64>
      *--d = *--s;
ffff800000107c20:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
ffff800000107c25:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
ffff800000107c2a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107c2e:	0f b6 10             	movzbl (%rax),%edx
ffff800000107c31:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107c35:	88 10                	mov    %dl,(%rax)
    while(n-- > 0)
ffff800000107c37:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107c3a:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000107c3d:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000107c40:	85 c0                	test   %eax,%eax
ffff800000107c42:	75 dc                	jne    ffff800000107c20 <memmove+0x4d>
  if(s < d && s + n > d){
ffff800000107c44:	eb 2a                	jmp    ffff800000107c70 <memmove+0x9d>
  } else
    while(n-- > 0)
      *d++ = *s++;
ffff800000107c46:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000107c4a:	48 8d 42 01          	lea    0x1(%rdx),%rax
ffff800000107c4e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000107c52:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107c56:	48 8d 48 01          	lea    0x1(%rax),%rcx
ffff800000107c5a:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
ffff800000107c5e:	0f b6 12             	movzbl (%rdx),%edx
ffff800000107c61:	88 10                	mov    %dl,(%rax)
    while(n-- > 0)
ffff800000107c63:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107c66:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000107c69:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000107c6c:	85 c0                	test   %eax,%eax
ffff800000107c6e:	75 d6                	jne    ffff800000107c46 <memmove+0x73>

  return dst;
ffff800000107c70:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
ffff800000107c74:	c9                   	leave
ffff800000107c75:	c3                   	ret

ffff800000107c76 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
ffff800000107c76:	55                   	push   %rbp
ffff800000107c77:	48 89 e5             	mov    %rsp,%rbp
ffff800000107c7a:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000107c7e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107c82:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff800000107c86:	89 55 ec             	mov    %edx,-0x14(%rbp)
  return memmove(dst, src, n);
ffff800000107c89:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff800000107c8c:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffff800000107c90:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107c94:	48 89 ce             	mov    %rcx,%rsi
ffff800000107c97:	48 89 c7             	mov    %rax,%rdi
ffff800000107c9a:	48 b8 d3 7b 10 00 00 	movabs $0xffff800000107bd3,%rax
ffff800000107ca1:	80 ff ff 
ffff800000107ca4:	ff d0                	call   *%rax
}
ffff800000107ca6:	c9                   	leave
ffff800000107ca7:	c3                   	ret

ffff800000107ca8 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
ffff800000107ca8:	55                   	push   %rbp
ffff800000107ca9:	48 89 e5             	mov    %rsp,%rbp
ffff800000107cac:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000107cb0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107cb4:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff800000107cb8:	89 55 ec             	mov    %edx,-0x14(%rbp)
  while(n > 0 && *p && *p == *q)
ffff800000107cbb:	eb 0e                	jmp    ffff800000107ccb <strncmp+0x23>
    n--, p++, q++;
ffff800000107cbd:	83 6d ec 01          	subl   $0x1,-0x14(%rbp)
ffff800000107cc1:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffff800000107cc6:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(n > 0 && *p && *p == *q)
ffff800000107ccb:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffff800000107ccf:	74 1d                	je     ffff800000107cee <strncmp+0x46>
ffff800000107cd1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107cd5:	0f b6 00             	movzbl (%rax),%eax
ffff800000107cd8:	84 c0                	test   %al,%al
ffff800000107cda:	74 12                	je     ffff800000107cee <strncmp+0x46>
ffff800000107cdc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107ce0:	0f b6 10             	movzbl (%rax),%edx
ffff800000107ce3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107ce7:	0f b6 00             	movzbl (%rax),%eax
ffff800000107cea:	38 c2                	cmp    %al,%dl
ffff800000107cec:	74 cf                	je     ffff800000107cbd <strncmp+0x15>
  if(n == 0)
ffff800000107cee:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffff800000107cf2:	75 07                	jne    ffff800000107cfb <strncmp+0x53>
    return 0;
ffff800000107cf4:	ba 00 00 00 00       	mov    $0x0,%edx
ffff800000107cf9:	eb 16                	jmp    ffff800000107d11 <strncmp+0x69>
  return (uchar)*p - (uchar)*q;
ffff800000107cfb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107cff:	0f b6 00             	movzbl (%rax),%eax
ffff800000107d02:	0f b6 d0             	movzbl %al,%edx
ffff800000107d05:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107d09:	0f b6 00             	movzbl (%rax),%eax
ffff800000107d0c:	0f b6 c0             	movzbl %al,%eax
ffff800000107d0f:	29 c2                	sub    %eax,%edx
}
ffff800000107d11:	89 d0                	mov    %edx,%eax
ffff800000107d13:	c9                   	leave
ffff800000107d14:	c3                   	ret

ffff800000107d15 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
ffff800000107d15:	55                   	push   %rbp
ffff800000107d16:	48 89 e5             	mov    %rsp,%rbp
ffff800000107d19:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000107d1d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107d21:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000107d25:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *os = s;
ffff800000107d28:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107d2c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while(n-- > 0 && (*s++ = *t++) != 0)
ffff800000107d30:	90                   	nop
ffff800000107d31:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107d34:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000107d37:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000107d3a:	85 c0                	test   %eax,%eax
ffff800000107d3c:	7e 35                	jle    ffff800000107d73 <strncpy+0x5e>
ffff800000107d3e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000107d42:	48 8d 42 01          	lea    0x1(%rdx),%rax
ffff800000107d46:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff800000107d4a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107d4e:	48 8d 48 01          	lea    0x1(%rax),%rcx
ffff800000107d52:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
ffff800000107d56:	0f b6 12             	movzbl (%rdx),%edx
ffff800000107d59:	88 10                	mov    %dl,(%rax)
ffff800000107d5b:	0f b6 00             	movzbl (%rax),%eax
ffff800000107d5e:	84 c0                	test   %al,%al
ffff800000107d60:	75 cf                	jne    ffff800000107d31 <strncpy+0x1c>
    ;
  while(n-- > 0)
ffff800000107d62:	eb 0f                	jmp    ffff800000107d73 <strncpy+0x5e>
    *s++ = 0;
ffff800000107d64:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107d68:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff800000107d6c:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
ffff800000107d70:	c6 00 00             	movb   $0x0,(%rax)
  while(n-- > 0)
ffff800000107d73:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107d76:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000107d79:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000107d7c:	85 c0                	test   %eax,%eax
ffff800000107d7e:	7f e4                	jg     ffff800000107d64 <strncpy+0x4f>
  return os;
ffff800000107d80:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000107d84:	c9                   	leave
ffff800000107d85:	c3                   	ret

ffff800000107d86 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
ffff800000107d86:	55                   	push   %rbp
ffff800000107d87:	48 89 e5             	mov    %rsp,%rbp
ffff800000107d8a:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000107d8e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107d92:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000107d96:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *os = s;
ffff800000107d99:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107d9d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(n <= 0)
ffff800000107da1:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
ffff800000107da5:	7f 06                	jg     ffff800000107dad <safestrcpy+0x27>
    return os;
ffff800000107da7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107dab:	eb 3a                	jmp    ffff800000107de7 <safestrcpy+0x61>
  while(--n > 0 && (*s++ = *t++) != 0)
ffff800000107dad:	90                   	nop
ffff800000107dae:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
ffff800000107db2:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
ffff800000107db6:	7e 24                	jle    ffff800000107ddc <safestrcpy+0x56>
ffff800000107db8:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000107dbc:	48 8d 42 01          	lea    0x1(%rdx),%rax
ffff800000107dc0:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff800000107dc4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107dc8:	48 8d 48 01          	lea    0x1(%rax),%rcx
ffff800000107dcc:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
ffff800000107dd0:	0f b6 12             	movzbl (%rdx),%edx
ffff800000107dd3:	88 10                	mov    %dl,(%rax)
ffff800000107dd5:	0f b6 00             	movzbl (%rax),%eax
ffff800000107dd8:	84 c0                	test   %al,%al
ffff800000107dda:	75 d2                	jne    ffff800000107dae <safestrcpy+0x28>
    ;
  *s = 0;
ffff800000107ddc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107de0:	c6 00 00             	movb   $0x0,(%rax)
  return os;
ffff800000107de3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000107de7:	c9                   	leave
ffff800000107de8:	c3                   	ret

ffff800000107de9 <strlen>:

int
strlen(const char *s)
{
ffff800000107de9:	55                   	push   %rbp
ffff800000107dea:	48 89 e5             	mov    %rsp,%rbp
ffff800000107ded:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000107df1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
ffff800000107df5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000107dfc:	eb 04                	jmp    ffff800000107e02 <strlen+0x19>
ffff800000107dfe:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000107e02:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000107e05:	48 63 d0             	movslq %eax,%rdx
ffff800000107e08:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107e0c:	48 01 d0             	add    %rdx,%rax
ffff800000107e0f:	0f b6 00             	movzbl (%rax),%eax
ffff800000107e12:	84 c0                	test   %al,%al
ffff800000107e14:	75 e8                	jne    ffff800000107dfe <strlen+0x15>
    ;
  return n;
ffff800000107e16:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff800000107e19:	c9                   	leave
ffff800000107e1a:	c3                   	ret

ffff800000107e1b <swtch>:
# and then load register context from new.

.global swtch
swtch:
  # Save old callee-save registers
  pushq   %rbp
ffff800000107e1b:	55                   	push   %rbp
  pushq   %rbx
ffff800000107e1c:	53                   	push   %rbx
  pushq   %r12
ffff800000107e1d:	41 54                	push   %r12
  pushq   %r13
ffff800000107e1f:	41 55                	push   %r13
  pushq   %r14
ffff800000107e21:	41 56                	push   %r14
  pushq   %r15
ffff800000107e23:	41 57                	push   %r15

  # Switch stacks
  movq    %rsp, (%rdi)
ffff800000107e25:	48 89 27             	mov    %rsp,(%rdi)
  movq    %rsi, %rsp
ffff800000107e28:	48 89 f4             	mov    %rsi,%rsp

  # Load new callee-save registers
  popq    %r15
ffff800000107e2b:	41 5f                	pop    %r15
  popq    %r14
ffff800000107e2d:	41 5e                	pop    %r14
  popq    %r13
ffff800000107e2f:	41 5d                	pop    %r13
  popq    %r12
ffff800000107e31:	41 5c                	pop    %r12
  popq    %rbx
ffff800000107e33:	5b                   	pop    %rbx
  popq    %rbp
ffff800000107e34:	5d                   	pop    %rbp

  retq #??
ffff800000107e35:	c3                   	ret

ffff800000107e36 <fetchint>:
#include "syscall.h"

// Fetch the int at addr from the current process.
int
fetchint(addr_t addr, int *ip)
{
ffff800000107e36:	55                   	push   %rbp
ffff800000107e37:	48 89 e5             	mov    %rsp,%rbp
ffff800000107e3a:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107e3e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107e42:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(addr < PGSIZE || addr >= proc->sz || addr+sizeof(int) > proc->sz)
ffff800000107e46:	48 81 7d f8 ff 0f 00 	cmpq   $0xfff,-0x8(%rbp)
ffff800000107e4d:	00 
ffff800000107e4e:	76 2f                	jbe    ffff800000107e7f <fetchint+0x49>
ffff800000107e50:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107e57:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107e5b:	48 8b 00             	mov    (%rax),%rax
ffff800000107e5e:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000107e62:	73 1b                	jae    ffff800000107e7f <fetchint+0x49>
ffff800000107e64:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107e68:	48 8d 50 04          	lea    0x4(%rax),%rdx
ffff800000107e6c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107e73:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107e77:	48 8b 00             	mov    (%rax),%rax
ffff800000107e7a:	48 39 d0             	cmp    %rdx,%rax
ffff800000107e7d:	73 07                	jae    ffff800000107e86 <fetchint+0x50>
    return -1;
ffff800000107e7f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000107e84:	eb 11                	jmp    ffff800000107e97 <fetchint+0x61>
  *ip = *(int*)(addr);
ffff800000107e86:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107e8a:	8b 10                	mov    (%rax),%edx
ffff800000107e8c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107e90:	89 10                	mov    %edx,(%rax)
  return 0;
ffff800000107e92:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000107e97:	c9                   	leave
ffff800000107e98:	c3                   	ret

ffff800000107e99 <fetchaddr>:

int
fetchaddr(addr_t addr, addr_t *ip)
{
ffff800000107e99:	55                   	push   %rbp
ffff800000107e9a:	48 89 e5             	mov    %rsp,%rbp
ffff800000107e9d:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107ea1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107ea5:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(addr < PGSIZE || addr >= proc->sz || addr+sizeof(addr_t) > proc->sz)
ffff800000107ea9:	48 81 7d f8 ff 0f 00 	cmpq   $0xfff,-0x8(%rbp)
ffff800000107eb0:	00 
ffff800000107eb1:	76 2f                	jbe    ffff800000107ee2 <fetchaddr+0x49>
ffff800000107eb3:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107eba:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107ebe:	48 8b 00             	mov    (%rax),%rax
ffff800000107ec1:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000107ec5:	73 1b                	jae    ffff800000107ee2 <fetchaddr+0x49>
ffff800000107ec7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107ecb:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffff800000107ecf:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107ed6:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107eda:	48 8b 00             	mov    (%rax),%rax
ffff800000107edd:	48 39 d0             	cmp    %rdx,%rax
ffff800000107ee0:	73 07                	jae    ffff800000107ee9 <fetchaddr+0x50>
    return -1;
ffff800000107ee2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000107ee7:	eb 13                	jmp    ffff800000107efc <fetchaddr+0x63>
  *ip = *(addr_t*)(addr);
ffff800000107ee9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107eed:	48 8b 10             	mov    (%rax),%rdx
ffff800000107ef0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107ef4:	48 89 10             	mov    %rdx,(%rax)
  return 0;
ffff800000107ef7:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000107efc:	c9                   	leave
ffff800000107efd:	c3                   	ret

ffff800000107efe <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(addr_t addr, char **pp)
{
ffff800000107efe:	55                   	push   %rbp
ffff800000107eff:	48 89 e5             	mov    %rsp,%rbp
ffff800000107f02:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000107f06:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107f0a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *s, *ep;

  if(addr < PGSIZE || addr >= proc->sz)
ffff800000107f0e:	48 81 7d e8 ff 0f 00 	cmpq   $0xfff,-0x18(%rbp)
ffff800000107f15:	00 
ffff800000107f16:	76 14                	jbe    ffff800000107f2c <fetchstr+0x2e>
ffff800000107f18:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107f1f:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107f23:	48 8b 00             	mov    (%rax),%rax
ffff800000107f26:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffff800000107f2a:	72 07                	jb     ffff800000107f33 <fetchstr+0x35>
    return -1;
ffff800000107f2c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000107f31:	eb 5b                	jmp    ffff800000107f8e <fetchstr+0x90>
  *pp = (char*)addr;
ffff800000107f33:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000107f37:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000107f3b:	48 89 10             	mov    %rdx,(%rax)
  ep = (char*)proc->sz;
ffff800000107f3e:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107f45:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107f49:	48 8b 00             	mov    (%rax),%rax
ffff800000107f4c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(s = *pp; s < ep; s++)
ffff800000107f50:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000107f54:	48 8b 00             	mov    (%rax),%rax
ffff800000107f57:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000107f5b:	eb 22                	jmp    ffff800000107f7f <fetchstr+0x81>
    if(*s == 0)
ffff800000107f5d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107f61:	0f b6 00             	movzbl (%rax),%eax
ffff800000107f64:	84 c0                	test   %al,%al
ffff800000107f66:	75 12                	jne    ffff800000107f7a <fetchstr+0x7c>
      return s - *pp;
ffff800000107f68:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000107f6c:	48 8b 00             	mov    (%rax),%rax
ffff800000107f6f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000107f73:	48 29 c2             	sub    %rax,%rdx
ffff800000107f76:	89 d0                	mov    %edx,%eax
ffff800000107f78:	eb 14                	jmp    ffff800000107f8e <fetchstr+0x90>
  for(s = *pp; s < ep; s++)
ffff800000107f7a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffff800000107f7f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107f83:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
ffff800000107f87:	72 d4                	jb     ffff800000107f5d <fetchstr+0x5f>
  return -1;
ffff800000107f89:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000107f8e:	c9                   	leave
ffff800000107f8f:	c3                   	ret

ffff800000107f90 <fetcharg>:

static addr_t
fetcharg(int n)
{
ffff800000107f90:	55                   	push   %rbp
ffff800000107f91:	48 89 e5             	mov    %rsp,%rbp
ffff800000107f94:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107f98:	89 7d fc             	mov    %edi,-0x4(%rbp)
  switch (n) {
ffff800000107f9b:	83 7d fc 05          	cmpl   $0x5,-0x4(%rbp)
ffff800000107f9f:	0f 84 bb 00 00 00    	je     ffff800000108060 <fetcharg+0xd0>
ffff800000107fa5:	83 7d fc 05          	cmpl   $0x5,-0x4(%rbp)
ffff800000107fa9:	0f 8f c6 00 00 00    	jg     ffff800000108075 <fetcharg+0xe5>
ffff800000107faf:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
ffff800000107fb3:	0f 84 92 00 00 00    	je     ffff80000010804b <fetcharg+0xbb>
ffff800000107fb9:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
ffff800000107fbd:	0f 8f b2 00 00 00    	jg     ffff800000108075 <fetcharg+0xe5>
ffff800000107fc3:	83 7d fc 03          	cmpl   $0x3,-0x4(%rbp)
ffff800000107fc7:	74 6d                	je     ffff800000108036 <fetcharg+0xa6>
ffff800000107fc9:	83 7d fc 03          	cmpl   $0x3,-0x4(%rbp)
ffff800000107fcd:	0f 8f a2 00 00 00    	jg     ffff800000108075 <fetcharg+0xe5>
ffff800000107fd3:	83 7d fc 02          	cmpl   $0x2,-0x4(%rbp)
ffff800000107fd7:	74 48                	je     ffff800000108021 <fetcharg+0x91>
ffff800000107fd9:	83 7d fc 02          	cmpl   $0x2,-0x4(%rbp)
ffff800000107fdd:	0f 8f 92 00 00 00    	jg     ffff800000108075 <fetcharg+0xe5>
ffff800000107fe3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000107fe7:	74 0b                	je     ffff800000107ff4 <fetcharg+0x64>
ffff800000107fe9:	83 7d fc 01          	cmpl   $0x1,-0x4(%rbp)
ffff800000107fed:	74 1d                	je     ffff80000010800c <fetcharg+0x7c>
ffff800000107fef:	e9 81 00 00 00       	jmp    ffff800000108075 <fetcharg+0xe5>
  case 0: return proc->tf->rdi;
ffff800000107ff4:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107ffb:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107fff:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000108003:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff800000108007:	e9 82 00 00 00       	jmp    ffff80000010808e <fetcharg+0xfe>
  case 1: return proc->tf->rsi;
ffff80000010800c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108013:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108017:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff80000010801b:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff80000010801f:	eb 6d                	jmp    ffff80000010808e <fetcharg+0xfe>
  case 2: return proc->tf->rdx;
ffff800000108021:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108028:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010802c:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000108030:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000108034:	eb 58                	jmp    ffff80000010808e <fetcharg+0xfe>
  case 3: return proc->tf->r10;
ffff800000108036:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010803d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108041:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000108045:	48 8b 40 48          	mov    0x48(%rax),%rax
ffff800000108049:	eb 43                	jmp    ffff80000010808e <fetcharg+0xfe>
  case 4: return proc->tf->r8;
ffff80000010804b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108052:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108056:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff80000010805a:	48 8b 40 38          	mov    0x38(%rax),%rax
ffff80000010805e:	eb 2e                	jmp    ffff80000010808e <fetcharg+0xfe>
  case 5: return proc->tf->r9;
ffff800000108060:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108067:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010806b:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff80000010806f:	48 8b 40 40          	mov    0x40(%rax),%rax
ffff800000108073:	eb 19                	jmp    ffff80000010808e <fetcharg+0xfe>
  }
  panic("failed fetch");
ffff800000108075:	48 b8 9c c4 10 00 00 	movabs $0xffff80000010c49c,%rax
ffff80000010807c:	80 ff ff 
ffff80000010807f:	48 89 c7             	mov    %rax,%rdi
ffff800000108082:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000108089:	80 ff ff 
ffff80000010808c:	ff d0                	call   *%rax
}
ffff80000010808e:	c9                   	leave
ffff80000010808f:	c3                   	ret

ffff800000108090 <argint>:

int
argint(int n, int *ip)
{
ffff800000108090:	55                   	push   %rbp
ffff800000108091:	48 89 e5             	mov    %rsp,%rbp
ffff800000108094:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000108098:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff80000010809b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  *ip = fetcharg(n);
ffff80000010809f:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001080a2:	89 c7                	mov    %eax,%edi
ffff8000001080a4:	48 b8 90 7f 10 00 00 	movabs $0xffff800000107f90,%rax
ffff8000001080ab:	80 ff ff 
ffff8000001080ae:	ff d0                	call   *%rax
ffff8000001080b0:	89 c2                	mov    %eax,%edx
ffff8000001080b2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001080b6:	89 10                	mov    %edx,(%rax)
  return 0;
ffff8000001080b8:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff8000001080bd:	c9                   	leave
ffff8000001080be:	c3                   	ret

ffff8000001080bf <argaddr>:

addr_t
argaddr(int n, addr_t *ip)
{
ffff8000001080bf:	55                   	push   %rbp
ffff8000001080c0:	48 89 e5             	mov    %rsp,%rbp
ffff8000001080c3:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001080c7:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff8000001080ca:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  *ip = fetcharg(n);
ffff8000001080ce:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001080d1:	89 c7                	mov    %eax,%edi
ffff8000001080d3:	48 b8 90 7f 10 00 00 	movabs $0xffff800000107f90,%rax
ffff8000001080da:	80 ff ff 
ffff8000001080dd:	ff d0                	call   *%rax
ffff8000001080df:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff8000001080e3:	48 89 02             	mov    %rax,(%rdx)
  return 0;
ffff8000001080e6:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff8000001080eb:	c9                   	leave
ffff8000001080ec:	c3                   	ret

ffff8000001080ed <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
addr_t
argptr(int n, char **pp, int size)
{
ffff8000001080ed:	55                   	push   %rbp
ffff8000001080ee:	48 89 e5             	mov    %rsp,%rbp
ffff8000001080f1:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001080f5:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff8000001080f8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff8000001080fc:	89 55 e8             	mov    %edx,-0x18(%rbp)
  addr_t i;

  if(argaddr(n, &i) < 0)
ffff8000001080ff:	48 8d 55 f8          	lea    -0x8(%rbp),%rdx
ffff800000108103:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000108106:	48 89 d6             	mov    %rdx,%rsi
ffff800000108109:	89 c7                	mov    %eax,%edi
ffff80000010810b:	48 b8 bf 80 10 00 00 	movabs $0xffff8000001080bf,%rax
ffff800000108112:	80 ff ff 
ffff800000108115:	ff d0                	call   *%rax
    return -1;
  if(size < 0 || (uint)i >= proc->sz || (uint)i+size > proc->sz)
ffff800000108117:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
ffff80000010811b:	78 39                	js     ffff800000108156 <argptr+0x69>
ffff80000010811d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108121:	89 c2                	mov    %eax,%edx
ffff800000108123:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010812a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010812e:	48 8b 00             	mov    (%rax),%rax
ffff800000108131:	48 39 c2             	cmp    %rax,%rdx
ffff800000108134:	73 20                	jae    ffff800000108156 <argptr+0x69>
ffff800000108136:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010813a:	89 c2                	mov    %eax,%edx
ffff80000010813c:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff80000010813f:	01 d0                	add    %edx,%eax
ffff800000108141:	89 c2                	mov    %eax,%edx
ffff800000108143:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010814a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010814e:	48 8b 00             	mov    (%rax),%rax
ffff800000108151:	48 39 d0             	cmp    %rdx,%rax
ffff800000108154:	73 09                	jae    ffff80000010815f <argptr+0x72>
    return -1;
ffff800000108156:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
ffff80000010815d:	eb 13                	jmp    ffff800000108172 <argptr+0x85>
  *pp = (char*)i;
ffff80000010815f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108163:	48 89 c2             	mov    %rax,%rdx
ffff800000108166:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010816a:	48 89 10             	mov    %rdx,(%rax)
  return 0;
ffff80000010816d:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000108172:	c9                   	leave
ffff800000108173:	c3                   	ret

ffff800000108174 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
ffff800000108174:	55                   	push   %rbp
ffff800000108175:	48 89 e5             	mov    %rsp,%rbp
ffff800000108178:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010817c:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff80000010817f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int addr;
  if(argint(n, &addr) < 0)
ffff800000108183:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
ffff800000108187:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff80000010818a:	48 89 d6             	mov    %rdx,%rsi
ffff80000010818d:	89 c7                	mov    %eax,%edi
ffff80000010818f:	48 b8 90 80 10 00 00 	movabs $0xffff800000108090,%rax
ffff800000108196:	80 ff ff 
ffff800000108199:	ff d0                	call   *%rax
ffff80000010819b:	85 c0                	test   %eax,%eax
ffff80000010819d:	79 07                	jns    ffff8000001081a6 <argstr+0x32>
    return -1;
ffff80000010819f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001081a4:	eb 1b                	jmp    ffff8000001081c1 <argstr+0x4d>
  return fetchstr(addr, pp);
ffff8000001081a6:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001081a9:	48 98                	cltq
ffff8000001081ab:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff8000001081af:	48 89 d6             	mov    %rdx,%rsi
ffff8000001081b2:	48 89 c7             	mov    %rax,%rdi
ffff8000001081b5:	48 b8 fe 7e 10 00 00 	movabs $0xffff800000107efe,%rax
ffff8000001081bc:	80 ff ff 
ffff8000001081bf:	ff d0                	call   *%rax
}
ffff8000001081c1:	c9                   	leave
ffff8000001081c2:	c3                   	ret

ffff8000001081c3 <syscall>:
	[SYS_recv] sys_recv
};

void
syscall(struct trapframe *tf)
{
ffff8000001081c3:	55                   	push   %rbp
ffff8000001081c4:	48 89 e5             	mov    %rsp,%rbp
ffff8000001081c7:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001081cb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  proc->tf = tf;
ffff8000001081cf:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001081d6:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001081da:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff8000001081de:	48 89 50 28          	mov    %rdx,0x28(%rax)
  uint64 num = proc->tf->rax;
ffff8000001081e2:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001081e9:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001081ed:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001081f1:	48 8b 00             	mov    (%rax),%rax
ffff8000001081f4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if (num > 0 && num < NELEM(syscalls) && syscalls[num]) {
ffff8000001081f8:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff8000001081fd:	74 3b                	je     ffff80000010823a <syscall+0x77>
ffff8000001081ff:	48 83 7d f8 17       	cmpq   $0x17,-0x8(%rbp)
ffff800000108204:	77 34                	ja     ffff80000010823a <syscall+0x77>
ffff800000108206:	48 ba a0 d5 10 00 00 	movabs $0xffff80000010d5a0,%rdx
ffff80000010820d:	80 ff ff 
ffff800000108210:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108214:	48 8b 04 c2          	mov    (%rdx,%rax,8),%rax
ffff800000108218:	48 85 c0             	test   %rax,%rax
ffff80000010821b:	74 1d                	je     ffff80000010823a <syscall+0x77>
    tf->rax = syscalls[num]();
ffff80000010821d:	48 ba a0 d5 10 00 00 	movabs $0xffff80000010d5a0,%rdx
ffff800000108224:	80 ff ff 
ffff800000108227:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010822b:	48 8b 04 c2          	mov    (%rdx,%rax,8),%rax
ffff80000010822f:	ff d0                	call   *%rax
ffff800000108231:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000108235:	48 89 02             	mov    %rax,(%rdx)
ffff800000108238:	eb 53                	jmp    ffff80000010828d <syscall+0xca>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
ffff80000010823a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108241:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108245:	48 8d b0 d0 00 00 00 	lea    0xd0(%rax),%rsi
ffff80000010824c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108253:	64 48 8b 00          	mov    %fs:(%rax),%rax
    cprintf("%d %s: unknown sys call %d\n",
ffff800000108257:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff80000010825a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010825e:	48 bf a9 c4 10 00 00 	movabs $0xffff80000010c4a9,%rdi
ffff800000108265:	80 ff ff 
ffff800000108268:	48 89 d1             	mov    %rdx,%rcx
ffff80000010826b:	48 89 f2             	mov    %rsi,%rdx
ffff80000010826e:	89 c6                	mov    %eax,%esi
ffff800000108270:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108275:	49 b8 04 08 10 00 00 	movabs $0xffff800000100804,%r8
ffff80000010827c:	80 ff ff 
ffff80000010827f:	41 ff d0             	call   *%r8
    tf->rax = -1;
ffff800000108282:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000108286:	48 c7 00 ff ff ff ff 	movq   $0xffffffffffffffff,(%rax)
  }
  if (proc->killed)
ffff80000010828d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108294:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108298:	8b 40 40             	mov    0x40(%rax),%eax
ffff80000010829b:	85 c0                	test   %eax,%eax
ffff80000010829d:	74 0c                	je     ffff8000001082ab <syscall+0xe8>
    exit();
ffff80000010829f:	48 b8 cc 67 10 00 00 	movabs $0xffff8000001067cc,%rax
ffff8000001082a6:	80 ff ff 
ffff8000001082a9:	ff d0                	call   *%rax
}
ffff8000001082ab:	90                   	nop
ffff8000001082ac:	c9                   	leave
ffff8000001082ad:	c3                   	ret

ffff8000001082ae <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
ffff8000001082ae:	55                   	push   %rbp
ffff8000001082af:	48 89 e5             	mov    %rsp,%rbp
ffff8000001082b2:	48 83 ec 30          	sub    $0x30,%rsp
ffff8000001082b6:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff8000001082b9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff8000001082bd:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
ffff8000001082c1:	48 8d 55 f4          	lea    -0xc(%rbp),%rdx
ffff8000001082c5:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001082c8:	48 89 d6             	mov    %rdx,%rsi
ffff8000001082cb:	89 c7                	mov    %eax,%edi
ffff8000001082cd:	48 b8 90 80 10 00 00 	movabs $0xffff800000108090,%rax
ffff8000001082d4:	80 ff ff 
ffff8000001082d7:	ff d0                	call   *%rax
ffff8000001082d9:	85 c0                	test   %eax,%eax
ffff8000001082db:	79 07                	jns    ffff8000001082e4 <argfd+0x36>
    return -1;
ffff8000001082dd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001082e2:	eb 62                	jmp    ffff800000108346 <argfd+0x98>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
ffff8000001082e4:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff8000001082e7:	85 c0                	test   %eax,%eax
ffff8000001082e9:	78 2d                	js     ffff800000108318 <argfd+0x6a>
ffff8000001082eb:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff8000001082ee:	83 f8 0f             	cmp    $0xf,%eax
ffff8000001082f1:	7f 25                	jg     ffff800000108318 <argfd+0x6a>
ffff8000001082f3:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001082fa:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001082fe:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff800000108301:	48 63 d2             	movslq %edx,%rdx
ffff800000108304:	48 83 c2 08          	add    $0x8,%rdx
ffff800000108308:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff80000010830d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000108311:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000108316:	75 07                	jne    ffff80000010831f <argfd+0x71>
    return -1;
ffff800000108318:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010831d:	eb 27                	jmp    ffff800000108346 <argfd+0x98>
  if(pfd)
ffff80000010831f:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
ffff800000108324:	74 09                	je     ffff80000010832f <argfd+0x81>
    *pfd = fd;
ffff800000108326:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff800000108329:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010832d:	89 10                	mov    %edx,(%rax)
  if(pf)
ffff80000010832f:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
ffff800000108334:	74 0b                	je     ffff800000108341 <argfd+0x93>
    *pf = f;
ffff800000108336:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010833a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010833e:	48 89 10             	mov    %rdx,(%rax)
  return 0;
ffff800000108341:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000108346:	c9                   	leave
ffff800000108347:	c3                   	ret

ffff800000108348 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
ffff800000108348:	55                   	push   %rbp
ffff800000108349:	48 89 e5             	mov    %rsp,%rbp
ffff80000010834c:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000108350:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
ffff800000108354:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010835b:	eb 46                	jmp    ffff8000001083a3 <fdalloc+0x5b>
    if(proc->ofile[fd] == 0){
ffff80000010835d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108364:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108368:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010836b:	48 63 d2             	movslq %edx,%rdx
ffff80000010836e:	48 83 c2 08          	add    $0x8,%rdx
ffff800000108372:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff800000108377:	48 85 c0             	test   %rax,%rax
ffff80000010837a:	75 23                	jne    ffff80000010839f <fdalloc+0x57>
      proc->ofile[fd] = f;
ffff80000010837c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108383:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108387:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010838a:	48 63 d2             	movslq %edx,%rdx
ffff80000010838d:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
ffff800000108391:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000108395:	48 89 54 c8 08       	mov    %rdx,0x8(%rax,%rcx,8)
      return fd;
ffff80000010839a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010839d:	eb 0f                	jmp    ffff8000001083ae <fdalloc+0x66>
  for(fd = 0; fd < NOFILE; fd++){
ffff80000010839f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001083a3:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
ffff8000001083a7:	7e b4                	jle    ffff80000010835d <fdalloc+0x15>
    }
  }
  return -1;
ffff8000001083a9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff8000001083ae:	c9                   	leave
ffff8000001083af:	c3                   	ret

ffff8000001083b0 <sys_dup>:

int
sys_dup(void)
{
ffff8000001083b0:	55                   	push   %rbp
ffff8000001083b1:	48 89 e5             	mov    %rsp,%rbp
ffff8000001083b4:	48 83 ec 10          	sub    $0x10,%rsp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
ffff8000001083b8:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff8000001083bc:	48 89 c2             	mov    %rax,%rdx
ffff8000001083bf:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001083c4:	bf 00 00 00 00       	mov    $0x0,%edi
ffff8000001083c9:	48 b8 ae 82 10 00 00 	movabs $0xffff8000001082ae,%rax
ffff8000001083d0:	80 ff ff 
ffff8000001083d3:	ff d0                	call   *%rax
ffff8000001083d5:	85 c0                	test   %eax,%eax
ffff8000001083d7:	79 07                	jns    ffff8000001083e0 <sys_dup+0x30>
    return -1;
ffff8000001083d9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001083de:	eb 39                	jmp    ffff800000108419 <sys_dup+0x69>
  if((fd=fdalloc(f)) < 0)
ffff8000001083e0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001083e4:	48 89 c7             	mov    %rax,%rdi
ffff8000001083e7:	48 b8 48 83 10 00 00 	movabs $0xffff800000108348,%rax
ffff8000001083ee:	80 ff ff 
ffff8000001083f1:	ff d0                	call   *%rax
ffff8000001083f3:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff8000001083f6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff8000001083fa:	79 07                	jns    ffff800000108403 <sys_dup+0x53>
    return -1;
ffff8000001083fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108401:	eb 16                	jmp    ffff800000108419 <sys_dup+0x69>
  filedup(f);
ffff800000108403:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108407:	48 89 c7             	mov    %rax,%rdi
ffff80000010840a:	48 b8 e5 1b 10 00 00 	movabs $0xffff800000101be5,%rax
ffff800000108411:	80 ff ff 
ffff800000108414:	ff d0                	call   *%rax
  return fd;
ffff800000108416:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff800000108419:	c9                   	leave
ffff80000010841a:	c3                   	ret

ffff80000010841b <sys_read>:

int
sys_read(void)
{
ffff80000010841b:	55                   	push   %rbp
ffff80000010841c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010841f:	48 83 ec 20          	sub    $0x20,%rsp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
ffff800000108423:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff800000108427:	48 89 c2             	mov    %rax,%rdx
ffff80000010842a:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010842f:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000108434:	48 b8 ae 82 10 00 00 	movabs $0xffff8000001082ae,%rax
ffff80000010843b:	80 ff ff 
ffff80000010843e:	ff d0                	call   *%rax
ffff800000108440:	85 c0                	test   %eax,%eax
ffff800000108442:	78 56                	js     ffff80000010849a <sys_read+0x7f>
ffff800000108444:	48 8d 45 f4          	lea    -0xc(%rbp),%rax
ffff800000108448:	48 89 c6             	mov    %rax,%rsi
ffff80000010844b:	bf 02 00 00 00       	mov    $0x2,%edi
ffff800000108450:	48 b8 90 80 10 00 00 	movabs $0xffff800000108090,%rax
ffff800000108457:	80 ff ff 
ffff80000010845a:	ff d0                	call   *%rax
ffff80000010845c:	85 c0                	test   %eax,%eax
ffff80000010845e:	78 3a                	js     ffff80000010849a <sys_read+0x7f>
ffff800000108460:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff800000108463:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffff800000108467:	48 89 c6             	mov    %rax,%rsi
ffff80000010846a:	bf 01 00 00 00       	mov    $0x1,%edi
ffff80000010846f:	48 b8 ed 80 10 00 00 	movabs $0xffff8000001080ed,%rax
ffff800000108476:	80 ff ff 
ffff800000108479:	ff d0                	call   *%rax
    return -1;
  return fileread(f, p, n);
ffff80000010847b:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff80000010847e:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffff800000108482:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108486:	48 89 ce             	mov    %rcx,%rsi
ffff800000108489:	48 89 c7             	mov    %rax,%rdi
ffff80000010848c:	48 b8 0f 1e 10 00 00 	movabs $0xffff800000101e0f,%rax
ffff800000108493:	80 ff ff 
ffff800000108496:	ff d0                	call   *%rax
ffff800000108498:	eb 05                	jmp    ffff80000010849f <sys_read+0x84>
    return -1;
ffff80000010849a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff80000010849f:	c9                   	leave
ffff8000001084a0:	c3                   	ret

ffff8000001084a1 <sys_write>:

int
sys_write(void)
{
ffff8000001084a1:	55                   	push   %rbp
ffff8000001084a2:	48 89 e5             	mov    %rsp,%rbp
ffff8000001084a5:	48 83 ec 20          	sub    $0x20,%rsp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
ffff8000001084a9:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff8000001084ad:	48 89 c2             	mov    %rax,%rdx
ffff8000001084b0:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001084b5:	bf 00 00 00 00       	mov    $0x0,%edi
ffff8000001084ba:	48 b8 ae 82 10 00 00 	movabs $0xffff8000001082ae,%rax
ffff8000001084c1:	80 ff ff 
ffff8000001084c4:	ff d0                	call   *%rax
ffff8000001084c6:	85 c0                	test   %eax,%eax
ffff8000001084c8:	78 56                	js     ffff800000108520 <sys_write+0x7f>
ffff8000001084ca:	48 8d 45 f4          	lea    -0xc(%rbp),%rax
ffff8000001084ce:	48 89 c6             	mov    %rax,%rsi
ffff8000001084d1:	bf 02 00 00 00       	mov    $0x2,%edi
ffff8000001084d6:	48 b8 90 80 10 00 00 	movabs $0xffff800000108090,%rax
ffff8000001084dd:	80 ff ff 
ffff8000001084e0:	ff d0                	call   *%rax
ffff8000001084e2:	85 c0                	test   %eax,%eax
ffff8000001084e4:	78 3a                	js     ffff800000108520 <sys_write+0x7f>
ffff8000001084e6:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff8000001084e9:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffff8000001084ed:	48 89 c6             	mov    %rax,%rsi
ffff8000001084f0:	bf 01 00 00 00       	mov    $0x1,%edi
ffff8000001084f5:	48 b8 ed 80 10 00 00 	movabs $0xffff8000001080ed,%rax
ffff8000001084fc:	80 ff ff 
ffff8000001084ff:	ff d0                	call   *%rax
    return -1;
  return filewrite(f, p, n);
ffff800000108501:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff800000108504:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffff800000108508:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010850c:	48 89 ce             	mov    %rcx,%rsi
ffff80000010850f:	48 89 c7             	mov    %rax,%rdi
ffff800000108512:	48 b8 03 1f 10 00 00 	movabs $0xffff800000101f03,%rax
ffff800000108519:	80 ff ff 
ffff80000010851c:	ff d0                	call   *%rax
ffff80000010851e:	eb 05                	jmp    ffff800000108525 <sys_write+0x84>
    return -1;
ffff800000108520:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000108525:	c9                   	leave
ffff800000108526:	c3                   	ret

ffff800000108527 <sys_close>:

int
sys_close(void)
{
ffff800000108527:	55                   	push   %rbp
ffff800000108528:	48 89 e5             	mov    %rsp,%rbp
ffff80000010852b:	48 83 ec 10          	sub    $0x10,%rsp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
ffff80000010852f:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
ffff800000108533:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
ffff800000108537:	48 89 c6             	mov    %rax,%rsi
ffff80000010853a:	bf 00 00 00 00       	mov    $0x0,%edi
ffff80000010853f:	48 b8 ae 82 10 00 00 	movabs $0xffff8000001082ae,%rax
ffff800000108546:	80 ff ff 
ffff800000108549:	ff d0                	call   *%rax
ffff80000010854b:	85 c0                	test   %eax,%eax
ffff80000010854d:	79 07                	jns    ffff800000108556 <sys_close+0x2f>
    return -1;
ffff80000010854f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108554:	eb 36                	jmp    ffff80000010858c <sys_close+0x65>
  proc->ofile[fd] = 0;
ffff800000108556:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010855d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108561:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000108564:	48 63 d2             	movslq %edx,%rdx
ffff800000108567:	48 83 c2 08          	add    $0x8,%rdx
ffff80000010856b:	48 c7 44 d0 08 00 00 	movq   $0x0,0x8(%rax,%rdx,8)
ffff800000108572:	00 00 
  fileclose(f);
ffff800000108574:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108578:	48 89 c7             	mov    %rax,%rdi
ffff80000010857b:	48 b8 5e 1c 10 00 00 	movabs $0xffff800000101c5e,%rax
ffff800000108582:	80 ff ff 
ffff800000108585:	ff d0                	call   *%rax
  return 0;
ffff800000108587:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010858c:	c9                   	leave
ffff80000010858d:	c3                   	ret

ffff80000010858e <sys_fstat>:

int
sys_fstat(void)
{
ffff80000010858e:	55                   	push   %rbp
ffff80000010858f:	48 89 e5             	mov    %rsp,%rbp
ffff800000108592:	48 83 ec 10          	sub    $0x10,%rsp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
ffff800000108596:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff80000010859a:	48 89 c2             	mov    %rax,%rdx
ffff80000010859d:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001085a2:	bf 00 00 00 00       	mov    $0x0,%edi
ffff8000001085a7:	48 b8 ae 82 10 00 00 	movabs $0xffff8000001082ae,%rax
ffff8000001085ae:	80 ff ff 
ffff8000001085b1:	ff d0                	call   *%rax
ffff8000001085b3:	85 c0                	test   %eax,%eax
ffff8000001085b5:	78 39                	js     ffff8000001085f0 <sys_fstat+0x62>
ffff8000001085b7:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff8000001085bb:	ba 14 00 00 00       	mov    $0x14,%edx
ffff8000001085c0:	48 89 c6             	mov    %rax,%rsi
ffff8000001085c3:	bf 01 00 00 00       	mov    $0x1,%edi
ffff8000001085c8:	48 b8 ed 80 10 00 00 	movabs $0xffff8000001080ed,%rax
ffff8000001085cf:	80 ff ff 
ffff8000001085d2:	ff d0                	call   *%rax
    return -1;
  return filestat(f, st);
ffff8000001085d4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff8000001085d8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001085dc:	48 89 d6             	mov    %rdx,%rsi
ffff8000001085df:	48 89 c7             	mov    %rax,%rdi
ffff8000001085e2:	48 b8 9a 1d 10 00 00 	movabs $0xffff800000101d9a,%rax
ffff8000001085e9:	80 ff ff 
ffff8000001085ec:	ff d0                	call   *%rax
ffff8000001085ee:	eb 05                	jmp    ffff8000001085f5 <sys_fstat+0x67>
    return -1;
ffff8000001085f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff8000001085f5:	c9                   	leave
ffff8000001085f6:	c3                   	ret

ffff8000001085f7 <isdirempty>:

static int
isdirempty(struct inode *dp)
{
ffff8000001085f7:	55                   	push   %rbp
ffff8000001085f8:	48 89 e5             	mov    %rsp,%rbp
ffff8000001085fb:	48 83 ec 30          	sub    $0x30,%rsp
ffff8000001085ff:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  int off;
  struct dirent de;
  // Is the directory dp empty except for "." and ".." ?
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
ffff800000108603:	c7 45 fc 20 00 00 00 	movl   $0x20,-0x4(%rbp)
ffff80000010860a:	eb 56                	jmp    ffff800000108662 <isdirempty+0x6b>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffff80000010860c:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010860f:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffff800000108613:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000108617:	b9 10 00 00 00       	mov    $0x10,%ecx
ffff80000010861c:	48 89 c7             	mov    %rax,%rdi
ffff80000010861f:	48 b8 f5 2e 10 00 00 	movabs $0xffff800000102ef5,%rax
ffff800000108626:	80 ff ff 
ffff800000108629:	ff d0                	call   *%rax
ffff80000010862b:	83 f8 10             	cmp    $0x10,%eax
ffff80000010862e:	74 19                	je     ffff800000108649 <isdirempty+0x52>
      panic("isdirempty: readi");
ffff800000108630:	48 b8 c5 c4 10 00 00 	movabs $0xffff80000010c4c5,%rax
ffff800000108637:	80 ff ff 
ffff80000010863a:	48 89 c7             	mov    %rax,%rdi
ffff80000010863d:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000108644:	80 ff ff 
ffff800000108647:	ff d0                	call   *%rax
    if(de.inum != 0)
ffff800000108649:	0f b7 45 e0          	movzwl -0x20(%rbp),%eax
ffff80000010864d:	66 85 c0             	test   %ax,%ax
ffff800000108650:	74 07                	je     ffff800000108659 <isdirempty+0x62>
      return 0;
ffff800000108652:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108657:	eb 1f                	jmp    ffff800000108678 <isdirempty+0x81>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
ffff800000108659:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010865c:	83 c0 10             	add    $0x10,%eax
ffff80000010865f:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000108662:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000108666:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff80000010866c:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010866f:	39 c2                	cmp    %eax,%edx
ffff800000108671:	72 99                	jb     ffff80000010860c <isdirempty+0x15>
  }
  return 1;
ffff800000108673:	b8 01 00 00 00       	mov    $0x1,%eax
}
ffff800000108678:	c9                   	leave
ffff800000108679:	c3                   	ret

ffff80000010867a <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
ffff80000010867a:	55                   	push   %rbp
ffff80000010867b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010867e:	48 83 ec 30          	sub    $0x30,%rsp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
ffff800000108682:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffff800000108686:	48 89 c6             	mov    %rax,%rsi
ffff800000108689:	bf 00 00 00 00       	mov    $0x0,%edi
ffff80000010868e:	48 b8 74 81 10 00 00 	movabs $0xffff800000108174,%rax
ffff800000108695:	80 ff ff 
ffff800000108698:	ff d0                	call   *%rax
ffff80000010869a:	85 c0                	test   %eax,%eax
ffff80000010869c:	78 1c                	js     ffff8000001086ba <sys_link+0x40>
ffff80000010869e:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
ffff8000001086a2:	48 89 c6             	mov    %rax,%rsi
ffff8000001086a5:	bf 01 00 00 00       	mov    $0x1,%edi
ffff8000001086aa:	48 b8 74 81 10 00 00 	movabs $0xffff800000108174,%rax
ffff8000001086b1:	80 ff ff 
ffff8000001086b4:	ff d0                	call   *%rax
ffff8000001086b6:	85 c0                	test   %eax,%eax
ffff8000001086b8:	79 0a                	jns    ffff8000001086c4 <sys_link+0x4a>
    return -1;
ffff8000001086ba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001086bf:	e9 f3 01 00 00       	jmp    ffff8000001088b7 <sys_link+0x23d>

  begin_op();
ffff8000001086c4:	48 b8 bd 4e 10 00 00 	movabs $0xffff800000104ebd,%rax
ffff8000001086cb:	80 ff ff 
ffff8000001086ce:	ff d0                	call   *%rax
  if((ip = namei(old)) == 0){
ffff8000001086d0:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff8000001086d4:	48 89 c7             	mov    %rax,%rdi
ffff8000001086d7:	48 b8 93 37 10 00 00 	movabs $0xffff800000103793,%rax
ffff8000001086de:	80 ff ff 
ffff8000001086e1:	ff d0                	call   *%rax
ffff8000001086e3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001086e7:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff8000001086ec:	75 16                	jne    ffff800000108704 <sys_link+0x8a>
    end_op();
ffff8000001086ee:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff8000001086f5:	80 ff ff 
ffff8000001086f8:	ff d0                	call   *%rax
    return -1;
ffff8000001086fa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001086ff:	e9 b3 01 00 00       	jmp    ffff8000001088b7 <sys_link+0x23d>
  }

  ilock(ip);
ffff800000108704:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108708:	48 89 c7             	mov    %rax,%rdi
ffff80000010870b:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff800000108712:	80 ff ff 
ffff800000108715:	ff d0                	call   *%rax
  if(ip->type == T_DIR){
ffff800000108717:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010871b:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000108722:	66 83 f8 01          	cmp    $0x1,%ax
ffff800000108726:	75 29                	jne    ffff800000108751 <sys_link+0xd7>
    iunlockput(ip);
ffff800000108728:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010872c:	48 89 c7             	mov    %rax,%rdi
ffff80000010872f:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000108736:	80 ff ff 
ffff800000108739:	ff d0                	call   *%rax
    end_op();
ffff80000010873b:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff800000108742:	80 ff ff 
ffff800000108745:	ff d0                	call   *%rax
    return -1;
ffff800000108747:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010874c:	e9 66 01 00 00       	jmp    ffff8000001088b7 <sys_link+0x23d>
  }

  ip->nlink++;
ffff800000108751:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108755:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff80000010875c:	83 c0 01             	add    $0x1,%eax
ffff80000010875f:	89 c2                	mov    %eax,%edx
ffff800000108761:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108765:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
  iupdate(ip);
ffff80000010876c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108770:	48 89 c7             	mov    %rax,%rdi
ffff800000108773:	48 b8 e8 25 10 00 00 	movabs $0xffff8000001025e8,%rax
ffff80000010877a:	80 ff ff 
ffff80000010877d:	ff d0                	call   *%rax
  iunlock(ip);
ffff80000010877f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108783:	48 89 c7             	mov    %rax,%rdi
ffff800000108786:	48 b8 23 2a 10 00 00 	movabs $0xffff800000102a23,%rax
ffff80000010878d:	80 ff ff 
ffff800000108790:	ff d0                	call   *%rax

  if((dp = nameiparent(new, name)) == 0)
ffff800000108792:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000108796:	48 8d 55 e2          	lea    -0x1e(%rbp),%rdx
ffff80000010879a:	48 89 d6             	mov    %rdx,%rsi
ffff80000010879d:	48 89 c7             	mov    %rax,%rdi
ffff8000001087a0:	48 b8 bd 37 10 00 00 	movabs $0xffff8000001037bd,%rax
ffff8000001087a7:	80 ff ff 
ffff8000001087aa:	ff d0                	call   *%rax
ffff8000001087ac:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff8000001087b0:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff8000001087b5:	0f 84 96 00 00 00    	je     ffff800000108851 <sys_link+0x1d7>
    goto bad;
  ilock(dp);
ffff8000001087bb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001087bf:	48 89 c7             	mov    %rax,%rdi
ffff8000001087c2:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff8000001087c9:	80 ff ff 
ffff8000001087cc:	ff d0                	call   *%rax
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
ffff8000001087ce:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001087d2:	8b 10                	mov    (%rax),%edx
ffff8000001087d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001087d8:	8b 00                	mov    (%rax),%eax
ffff8000001087da:	39 c2                	cmp    %eax,%edx
ffff8000001087dc:	75 25                	jne    ffff800000108803 <sys_link+0x189>
ffff8000001087de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001087e2:	8b 50 04             	mov    0x4(%rax),%edx
ffff8000001087e5:	48 8d 4d e2          	lea    -0x1e(%rbp),%rcx
ffff8000001087e9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001087ed:	48 89 ce             	mov    %rcx,%rsi
ffff8000001087f0:	48 89 c7             	mov    %rax,%rdi
ffff8000001087f3:	48 b8 09 34 10 00 00 	movabs $0xffff800000103409,%rax
ffff8000001087fa:	80 ff ff 
ffff8000001087fd:	ff d0                	call   *%rax
ffff8000001087ff:	85 c0                	test   %eax,%eax
ffff800000108801:	79 15                	jns    ffff800000108818 <sys_link+0x19e>
    iunlockput(dp);
ffff800000108803:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108807:	48 89 c7             	mov    %rax,%rdi
ffff80000010880a:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000108811:	80 ff ff 
ffff800000108814:	ff d0                	call   *%rax
    goto bad;
ffff800000108816:	eb 3a                	jmp    ffff800000108852 <sys_link+0x1d8>
  }
  iunlockput(dp);
ffff800000108818:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010881c:	48 89 c7             	mov    %rax,%rdi
ffff80000010881f:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000108826:	80 ff ff 
ffff800000108829:	ff d0                	call   *%rax
  iput(ip);
ffff80000010882b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010882f:	48 89 c7             	mov    %rax,%rdi
ffff800000108832:	48 b8 8f 2a 10 00 00 	movabs $0xffff800000102a8f,%rax
ffff800000108839:	80 ff ff 
ffff80000010883c:	ff d0                	call   *%rax

  end_op();
ffff80000010883e:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff800000108845:	80 ff ff 
ffff800000108848:	ff d0                	call   *%rax

  return 0;
ffff80000010884a:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010884f:	eb 66                	jmp    ffff8000001088b7 <sys_link+0x23d>
    goto bad;
ffff800000108851:	90                   	nop

bad:
  ilock(ip);
ffff800000108852:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108856:	48 89 c7             	mov    %rax,%rdi
ffff800000108859:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff800000108860:	80 ff ff 
ffff800000108863:	ff d0                	call   *%rax
  ip->nlink--;
ffff800000108865:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108869:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff800000108870:	83 e8 01             	sub    $0x1,%eax
ffff800000108873:	89 c2                	mov    %eax,%edx
ffff800000108875:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108879:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
  iupdate(ip);
ffff800000108880:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108884:	48 89 c7             	mov    %rax,%rdi
ffff800000108887:	48 b8 e8 25 10 00 00 	movabs $0xffff8000001025e8,%rax
ffff80000010888e:	80 ff ff 
ffff800000108891:	ff d0                	call   *%rax
  iunlockput(ip);
ffff800000108893:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108897:	48 89 c7             	mov    %rax,%rdi
ffff80000010889a:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff8000001088a1:	80 ff ff 
ffff8000001088a4:	ff d0                	call   *%rax
  end_op();
ffff8000001088a6:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff8000001088ad:	80 ff ff 
ffff8000001088b0:	ff d0                	call   *%rax
  return -1;
ffff8000001088b2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff8000001088b7:	c9                   	leave
ffff8000001088b8:	c3                   	ret

ffff8000001088b9 <sys_unlink>:
//PAGEBREAK!

int
sys_unlink(void)
{
ffff8000001088b9:	55                   	push   %rbp
ffff8000001088ba:	48 89 e5             	mov    %rsp,%rbp
ffff8000001088bd:	48 83 ec 40          	sub    $0x40,%rsp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
ffff8000001088c1:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
ffff8000001088c5:	48 89 c6             	mov    %rax,%rsi
ffff8000001088c8:	bf 00 00 00 00       	mov    $0x0,%edi
ffff8000001088cd:	48 b8 74 81 10 00 00 	movabs $0xffff800000108174,%rax
ffff8000001088d4:	80 ff ff 
ffff8000001088d7:	ff d0                	call   *%rax
ffff8000001088d9:	85 c0                	test   %eax,%eax
ffff8000001088db:	79 0a                	jns    ffff8000001088e7 <sys_unlink+0x2e>
    return -1;
ffff8000001088dd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001088e2:	e9 7b 02 00 00       	jmp    ffff800000108b62 <sys_unlink+0x2a9>

  begin_op();
ffff8000001088e7:	48 b8 bd 4e 10 00 00 	movabs $0xffff800000104ebd,%rax
ffff8000001088ee:	80 ff ff 
ffff8000001088f1:	ff d0                	call   *%rax
  if((dp = nameiparent(path, name)) == 0){
ffff8000001088f3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff8000001088f7:	48 8d 55 d2          	lea    -0x2e(%rbp),%rdx
ffff8000001088fb:	48 89 d6             	mov    %rdx,%rsi
ffff8000001088fe:	48 89 c7             	mov    %rax,%rdi
ffff800000108901:	48 b8 bd 37 10 00 00 	movabs $0xffff8000001037bd,%rax
ffff800000108908:	80 ff ff 
ffff80000010890b:	ff d0                	call   *%rax
ffff80000010890d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000108911:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000108916:	75 16                	jne    ffff80000010892e <sys_unlink+0x75>
    end_op();
ffff800000108918:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff80000010891f:	80 ff ff 
ffff800000108922:	ff d0                	call   *%rax
    return -1;
ffff800000108924:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108929:	e9 34 02 00 00       	jmp    ffff800000108b62 <sys_unlink+0x2a9>
  }

  ilock(dp);
ffff80000010892e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108932:	48 89 c7             	mov    %rax,%rdi
ffff800000108935:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff80000010893c:	80 ff ff 
ffff80000010893f:	ff d0                	call   *%rax

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
ffff800000108941:	48 ba d7 c4 10 00 00 	movabs $0xffff80000010c4d7,%rdx
ffff800000108948:	80 ff ff 
ffff80000010894b:	48 8d 45 d2          	lea    -0x2e(%rbp),%rax
ffff80000010894f:	48 89 d6             	mov    %rdx,%rsi
ffff800000108952:	48 89 c7             	mov    %rax,%rdi
ffff800000108955:	48 b8 d2 32 10 00 00 	movabs $0xffff8000001032d2,%rax
ffff80000010895c:	80 ff ff 
ffff80000010895f:	ff d0                	call   *%rax
ffff800000108961:	85 c0                	test   %eax,%eax
ffff800000108963:	0f 84 d1 01 00 00    	je     ffff800000108b3a <sys_unlink+0x281>
ffff800000108969:	48 ba d9 c4 10 00 00 	movabs $0xffff80000010c4d9,%rdx
ffff800000108970:	80 ff ff 
ffff800000108973:	48 8d 45 d2          	lea    -0x2e(%rbp),%rax
ffff800000108977:	48 89 d6             	mov    %rdx,%rsi
ffff80000010897a:	48 89 c7             	mov    %rax,%rdi
ffff80000010897d:	48 b8 d2 32 10 00 00 	movabs $0xffff8000001032d2,%rax
ffff800000108984:	80 ff ff 
ffff800000108987:	ff d0                	call   *%rax
ffff800000108989:	85 c0                	test   %eax,%eax
ffff80000010898b:	0f 84 a9 01 00 00    	je     ffff800000108b3a <sys_unlink+0x281>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
ffff800000108991:	48 8d 55 c4          	lea    -0x3c(%rbp),%rdx
ffff800000108995:	48 8d 4d d2          	lea    -0x2e(%rbp),%rcx
ffff800000108999:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010899d:	48 89 ce             	mov    %rcx,%rsi
ffff8000001089a0:	48 89 c7             	mov    %rax,%rdi
ffff8000001089a3:	48 b8 03 33 10 00 00 	movabs $0xffff800000103303,%rax
ffff8000001089aa:	80 ff ff 
ffff8000001089ad:	ff d0                	call   *%rax
ffff8000001089af:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff8000001089b3:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff8000001089b8:	0f 84 7f 01 00 00    	je     ffff800000108b3d <sys_unlink+0x284>
    goto bad;
  ilock(ip);
ffff8000001089be:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001089c2:	48 89 c7             	mov    %rax,%rdi
ffff8000001089c5:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff8000001089cc:	80 ff ff 
ffff8000001089cf:	ff d0                	call   *%rax

  if(ip->nlink < 1)
ffff8000001089d1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001089d5:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff8000001089dc:	66 85 c0             	test   %ax,%ax
ffff8000001089df:	7f 19                	jg     ffff8000001089fa <sys_unlink+0x141>
    panic("unlink: nlink < 1");
ffff8000001089e1:	48 b8 dc c4 10 00 00 	movabs $0xffff80000010c4dc,%rax
ffff8000001089e8:	80 ff ff 
ffff8000001089eb:	48 89 c7             	mov    %rax,%rdi
ffff8000001089ee:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001089f5:	80 ff ff 
ffff8000001089f8:	ff d0                	call   *%rax
  if(ip->type == T_DIR && !isdirempty(ip)){
ffff8000001089fa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001089fe:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000108a05:	66 83 f8 01          	cmp    $0x1,%ax
ffff800000108a09:	75 2f                	jne    ffff800000108a3a <sys_unlink+0x181>
ffff800000108a0b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108a0f:	48 89 c7             	mov    %rax,%rdi
ffff800000108a12:	48 b8 f7 85 10 00 00 	movabs $0xffff8000001085f7,%rax
ffff800000108a19:	80 ff ff 
ffff800000108a1c:	ff d0                	call   *%rax
ffff800000108a1e:	85 c0                	test   %eax,%eax
ffff800000108a20:	75 18                	jne    ffff800000108a3a <sys_unlink+0x181>
    iunlockput(ip);
ffff800000108a22:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108a26:	48 89 c7             	mov    %rax,%rdi
ffff800000108a29:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000108a30:	80 ff ff 
ffff800000108a33:	ff d0                	call   *%rax
    goto bad;
ffff800000108a35:	e9 04 01 00 00       	jmp    ffff800000108b3e <sys_unlink+0x285>
  }

  memset(&de, 0, sizeof(de));
ffff800000108a3a:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff800000108a3e:	ba 10 00 00 00       	mov    $0x10,%edx
ffff800000108a43:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000108a48:	48 89 c7             	mov    %rax,%rdi
ffff800000108a4b:	48 b8 ce 7a 10 00 00 	movabs $0xffff800000107ace,%rax
ffff800000108a52:	80 ff ff 
ffff800000108a55:	ff d0                	call   *%rax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffff800000108a57:	8b 55 c4             	mov    -0x3c(%rbp),%edx
ffff800000108a5a:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffff800000108a5e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108a62:	b9 10 00 00 00       	mov    $0x10,%ecx
ffff800000108a67:	48 89 c7             	mov    %rax,%rdi
ffff800000108a6a:	48 b8 c2 30 10 00 00 	movabs $0xffff8000001030c2,%rax
ffff800000108a71:	80 ff ff 
ffff800000108a74:	ff d0                	call   *%rax
ffff800000108a76:	83 f8 10             	cmp    $0x10,%eax
ffff800000108a79:	74 19                	je     ffff800000108a94 <sys_unlink+0x1db>
    panic("unlink: writei");
ffff800000108a7b:	48 b8 ee c4 10 00 00 	movabs $0xffff80000010c4ee,%rax
ffff800000108a82:	80 ff ff 
ffff800000108a85:	48 89 c7             	mov    %rax,%rdi
ffff800000108a88:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000108a8f:	80 ff ff 
ffff800000108a92:	ff d0                	call   *%rax
  if(ip->type == T_DIR){
ffff800000108a94:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108a98:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000108a9f:	66 83 f8 01          	cmp    $0x1,%ax
ffff800000108aa3:	75 2e                	jne    ffff800000108ad3 <sys_unlink+0x21a>
    dp->nlink--;
ffff800000108aa5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108aa9:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff800000108ab0:	83 e8 01             	sub    $0x1,%eax
ffff800000108ab3:	89 c2                	mov    %eax,%edx
ffff800000108ab5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108ab9:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
    iupdate(dp);
ffff800000108ac0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108ac4:	48 89 c7             	mov    %rax,%rdi
ffff800000108ac7:	48 b8 e8 25 10 00 00 	movabs $0xffff8000001025e8,%rax
ffff800000108ace:	80 ff ff 
ffff800000108ad1:	ff d0                	call   *%rax
  }
  iunlockput(dp);
ffff800000108ad3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108ad7:	48 89 c7             	mov    %rax,%rdi
ffff800000108ada:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000108ae1:	80 ff ff 
ffff800000108ae4:	ff d0                	call   *%rax

  ip->nlink--;
ffff800000108ae6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108aea:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff800000108af1:	83 e8 01             	sub    $0x1,%eax
ffff800000108af4:	89 c2                	mov    %eax,%edx
ffff800000108af6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108afa:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
  iupdate(ip);
ffff800000108b01:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108b05:	48 89 c7             	mov    %rax,%rdi
ffff800000108b08:	48 b8 e8 25 10 00 00 	movabs $0xffff8000001025e8,%rax
ffff800000108b0f:	80 ff ff 
ffff800000108b12:	ff d0                	call   *%rax
  iunlockput(ip);
ffff800000108b14:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108b18:	48 89 c7             	mov    %rax,%rdi
ffff800000108b1b:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000108b22:	80 ff ff 
ffff800000108b25:	ff d0                	call   *%rax

  end_op();
ffff800000108b27:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff800000108b2e:	80 ff ff 
ffff800000108b31:	ff d0                	call   *%rax

  return 0;
ffff800000108b33:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108b38:	eb 28                	jmp    ffff800000108b62 <sys_unlink+0x2a9>
    goto bad;
ffff800000108b3a:	90                   	nop
ffff800000108b3b:	eb 01                	jmp    ffff800000108b3e <sys_unlink+0x285>
    goto bad;
ffff800000108b3d:	90                   	nop

bad:
  iunlockput(dp);
ffff800000108b3e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108b42:	48 89 c7             	mov    %rax,%rdi
ffff800000108b45:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000108b4c:	80 ff ff 
ffff800000108b4f:	ff d0                	call   *%rax
  end_op();
ffff800000108b51:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff800000108b58:	80 ff ff 
ffff800000108b5b:	ff d0                	call   *%rax
  return -1;
ffff800000108b5d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000108b62:	c9                   	leave
ffff800000108b63:	c3                   	ret

ffff800000108b64 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
ffff800000108b64:	55                   	push   %rbp
ffff800000108b65:	48 89 e5             	mov    %rsp,%rbp
ffff800000108b68:	48 83 ec 50          	sub    $0x50,%rsp
ffff800000108b6c:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
ffff800000108b70:	89 c8                	mov    %ecx,%eax
ffff800000108b72:	89 f1                	mov    %esi,%ecx
ffff800000108b74:	66 89 4d c4          	mov    %cx,-0x3c(%rbp)
ffff800000108b78:	66 89 55 c0          	mov    %dx,-0x40(%rbp)
ffff800000108b7c:	66 89 45 bc          	mov    %ax,-0x44(%rbp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
ffff800000108b80:	48 8d 55 de          	lea    -0x22(%rbp),%rdx
ffff800000108b84:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff800000108b88:	48 89 d6             	mov    %rdx,%rsi
ffff800000108b8b:	48 89 c7             	mov    %rax,%rdi
ffff800000108b8e:	48 b8 bd 37 10 00 00 	movabs $0xffff8000001037bd,%rax
ffff800000108b95:	80 ff ff 
ffff800000108b98:	ff d0                	call   *%rax
ffff800000108b9a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000108b9e:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000108ba3:	75 0a                	jne    ffff800000108baf <create+0x4b>
    return 0;
ffff800000108ba5:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108baa:	e9 2c 02 00 00       	jmp    ffff800000108ddb <create+0x277>
  ilock(dp);
ffff800000108baf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108bb3:	48 89 c7             	mov    %rax,%rdi
ffff800000108bb6:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff800000108bbd:	80 ff ff 
ffff800000108bc0:	ff d0                	call   *%rax

  if((ip = dirlookup(dp, name, &off)) != 0){
ffff800000108bc2:	48 8d 55 ec          	lea    -0x14(%rbp),%rdx
ffff800000108bc6:	48 8d 4d de          	lea    -0x22(%rbp),%rcx
ffff800000108bca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108bce:	48 89 ce             	mov    %rcx,%rsi
ffff800000108bd1:	48 89 c7             	mov    %rax,%rdi
ffff800000108bd4:	48 b8 03 33 10 00 00 	movabs $0xffff800000103303,%rax
ffff800000108bdb:	80 ff ff 
ffff800000108bde:	ff d0                	call   *%rax
ffff800000108be0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000108be4:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000108be9:	74 64                	je     ffff800000108c4f <create+0xeb>
    iunlockput(dp);
ffff800000108beb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108bef:	48 89 c7             	mov    %rax,%rdi
ffff800000108bf2:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000108bf9:	80 ff ff 
ffff800000108bfc:	ff d0                	call   *%rax
    ilock(ip);
ffff800000108bfe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108c02:	48 89 c7             	mov    %rax,%rdi
ffff800000108c05:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff800000108c0c:	80 ff ff 
ffff800000108c0f:	ff d0                	call   *%rax
    if(type == T_FILE && ip->type == T_FILE)
ffff800000108c11:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%rbp)
ffff800000108c16:	75 1a                	jne    ffff800000108c32 <create+0xce>
ffff800000108c18:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108c1c:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000108c23:	66 83 f8 02          	cmp    $0x2,%ax
ffff800000108c27:	75 09                	jne    ffff800000108c32 <create+0xce>
      return ip;
ffff800000108c29:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108c2d:	e9 a9 01 00 00       	jmp    ffff800000108ddb <create+0x277>
    iunlockput(ip);
ffff800000108c32:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108c36:	48 89 c7             	mov    %rax,%rdi
ffff800000108c39:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000108c40:	80 ff ff 
ffff800000108c43:	ff d0                	call   *%rax
    return 0;
ffff800000108c45:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108c4a:	e9 8c 01 00 00       	jmp    ffff800000108ddb <create+0x277>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
ffff800000108c4f:	0f bf 55 c4          	movswl -0x3c(%rbp),%edx
ffff800000108c53:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108c57:	8b 00                	mov    (%rax),%eax
ffff800000108c59:	89 d6                	mov    %edx,%esi
ffff800000108c5b:	89 c7                	mov    %eax,%edi
ffff800000108c5d:	48 b8 c0 24 10 00 00 	movabs $0xffff8000001024c0,%rax
ffff800000108c64:	80 ff ff 
ffff800000108c67:	ff d0                	call   *%rax
ffff800000108c69:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000108c6d:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000108c72:	75 19                	jne    ffff800000108c8d <create+0x129>
    panic("create: ialloc");
ffff800000108c74:	48 b8 fd c4 10 00 00 	movabs $0xffff80000010c4fd,%rax
ffff800000108c7b:	80 ff ff 
ffff800000108c7e:	48 89 c7             	mov    %rax,%rdi
ffff800000108c81:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000108c88:	80 ff ff 
ffff800000108c8b:	ff d0                	call   *%rax

  ilock(ip);
ffff800000108c8d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108c91:	48 89 c7             	mov    %rax,%rdi
ffff800000108c94:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff800000108c9b:	80 ff ff 
ffff800000108c9e:	ff d0                	call   *%rax
  ip->major = major;
ffff800000108ca0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108ca4:	0f b7 55 c0          	movzwl -0x40(%rbp),%edx
ffff800000108ca8:	66 89 90 96 00 00 00 	mov    %dx,0x96(%rax)
  ip->minor = minor;
ffff800000108caf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108cb3:	0f b7 55 bc          	movzwl -0x44(%rbp),%edx
ffff800000108cb7:	66 89 90 98 00 00 00 	mov    %dx,0x98(%rax)
  ip->nlink = 1;
ffff800000108cbe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108cc2:	66 c7 80 9a 00 00 00 	movw   $0x1,0x9a(%rax)
ffff800000108cc9:	01 00 
  iupdate(ip);
ffff800000108ccb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108ccf:	48 89 c7             	mov    %rax,%rdi
ffff800000108cd2:	48 b8 e8 25 10 00 00 	movabs $0xffff8000001025e8,%rax
ffff800000108cd9:	80 ff ff 
ffff800000108cdc:	ff d0                	call   *%rax

  if(type == T_DIR){  // Create . and .. entries.
ffff800000108cde:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%rbp)
ffff800000108ce3:	0f 85 9d 00 00 00    	jne    ffff800000108d86 <create+0x222>
    dp->nlink++;  // for ".."
ffff800000108ce9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108ced:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff800000108cf4:	83 c0 01             	add    $0x1,%eax
ffff800000108cf7:	89 c2                	mov    %eax,%edx
ffff800000108cf9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108cfd:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
    iupdate(dp);
ffff800000108d04:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108d08:	48 89 c7             	mov    %rax,%rdi
ffff800000108d0b:	48 b8 e8 25 10 00 00 	movabs $0xffff8000001025e8,%rax
ffff800000108d12:	80 ff ff 
ffff800000108d15:	ff d0                	call   *%rax
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
ffff800000108d17:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108d1b:	8b 50 04             	mov    0x4(%rax),%edx
ffff800000108d1e:	48 b9 d7 c4 10 00 00 	movabs $0xffff80000010c4d7,%rcx
ffff800000108d25:	80 ff ff 
ffff800000108d28:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108d2c:	48 89 ce             	mov    %rcx,%rsi
ffff800000108d2f:	48 89 c7             	mov    %rax,%rdi
ffff800000108d32:	48 b8 09 34 10 00 00 	movabs $0xffff800000103409,%rax
ffff800000108d39:	80 ff ff 
ffff800000108d3c:	ff d0                	call   *%rax
ffff800000108d3e:	85 c0                	test   %eax,%eax
ffff800000108d40:	78 2b                	js     ffff800000108d6d <create+0x209>
ffff800000108d42:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108d46:	8b 50 04             	mov    0x4(%rax),%edx
ffff800000108d49:	48 b9 d9 c4 10 00 00 	movabs $0xffff80000010c4d9,%rcx
ffff800000108d50:	80 ff ff 
ffff800000108d53:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108d57:	48 89 ce             	mov    %rcx,%rsi
ffff800000108d5a:	48 89 c7             	mov    %rax,%rdi
ffff800000108d5d:	48 b8 09 34 10 00 00 	movabs $0xffff800000103409,%rax
ffff800000108d64:	80 ff ff 
ffff800000108d67:	ff d0                	call   *%rax
ffff800000108d69:	85 c0                	test   %eax,%eax
ffff800000108d6b:	79 19                	jns    ffff800000108d86 <create+0x222>
      panic("create dots");
ffff800000108d6d:	48 b8 0c c5 10 00 00 	movabs $0xffff80000010c50c,%rax
ffff800000108d74:	80 ff ff 
ffff800000108d77:	48 89 c7             	mov    %rax,%rdi
ffff800000108d7a:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000108d81:	80 ff ff 
ffff800000108d84:	ff d0                	call   *%rax
  }

  if(dirlink(dp, name, ip->inum) < 0)
ffff800000108d86:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108d8a:	8b 50 04             	mov    0x4(%rax),%edx
ffff800000108d8d:	48 8d 4d de          	lea    -0x22(%rbp),%rcx
ffff800000108d91:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108d95:	48 89 ce             	mov    %rcx,%rsi
ffff800000108d98:	48 89 c7             	mov    %rax,%rdi
ffff800000108d9b:	48 b8 09 34 10 00 00 	movabs $0xffff800000103409,%rax
ffff800000108da2:	80 ff ff 
ffff800000108da5:	ff d0                	call   *%rax
ffff800000108da7:	85 c0                	test   %eax,%eax
ffff800000108da9:	79 19                	jns    ffff800000108dc4 <create+0x260>
    panic("create: dirlink");
ffff800000108dab:	48 b8 18 c5 10 00 00 	movabs $0xffff80000010c518,%rax
ffff800000108db2:	80 ff ff 
ffff800000108db5:	48 89 c7             	mov    %rax,%rdi
ffff800000108db8:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000108dbf:	80 ff ff 
ffff800000108dc2:	ff d0                	call   *%rax

  iunlockput(dp);
ffff800000108dc4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108dc8:	48 89 c7             	mov    %rax,%rdi
ffff800000108dcb:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000108dd2:	80 ff ff 
ffff800000108dd5:	ff d0                	call   *%rax

  return ip;
ffff800000108dd7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
}
ffff800000108ddb:	c9                   	leave
ffff800000108ddc:	c3                   	ret

ffff800000108ddd <sys_open>:

int
sys_open(void)
{
ffff800000108ddd:	55                   	push   %rbp
ffff800000108dde:	48 89 e5             	mov    %rsp,%rbp
ffff800000108de1:	48 83 ec 30          	sub    $0x30,%rsp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
ffff800000108de5:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff800000108de9:	48 89 c6             	mov    %rax,%rsi
ffff800000108dec:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000108df1:	48 b8 74 81 10 00 00 	movabs $0xffff800000108174,%rax
ffff800000108df8:	80 ff ff 
ffff800000108dfb:	ff d0                	call   *%rax
ffff800000108dfd:	85 c0                	test   %eax,%eax
ffff800000108dff:	78 1c                	js     ffff800000108e1d <sys_open+0x40>
ffff800000108e01:	48 8d 45 dc          	lea    -0x24(%rbp),%rax
ffff800000108e05:	48 89 c6             	mov    %rax,%rsi
ffff800000108e08:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000108e0d:	48 b8 90 80 10 00 00 	movabs $0xffff800000108090,%rax
ffff800000108e14:	80 ff ff 
ffff800000108e17:	ff d0                	call   *%rax
ffff800000108e19:	85 c0                	test   %eax,%eax
ffff800000108e1b:	79 0a                	jns    ffff800000108e27 <sys_open+0x4a>
    return -1;
ffff800000108e1d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108e22:	e9 de 01 00 00       	jmp    ffff800000109005 <sys_open+0x228>

  begin_op();
ffff800000108e27:	48 b8 bd 4e 10 00 00 	movabs $0xffff800000104ebd,%rax
ffff800000108e2e:	80 ff ff 
ffff800000108e31:	ff d0                	call   *%rax

  if(omode & O_CREATE){
ffff800000108e33:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000108e36:	25 00 02 00 00       	and    $0x200,%eax
ffff800000108e3b:	85 c0                	test   %eax,%eax
ffff800000108e3d:	74 47                	je     ffff800000108e86 <sys_open+0xa9>
    ip = create(path, T_FILE, 0, 0);
ffff800000108e3f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000108e43:	b9 00 00 00 00       	mov    $0x0,%ecx
ffff800000108e48:	ba 00 00 00 00       	mov    $0x0,%edx
ffff800000108e4d:	be 02 00 00 00       	mov    $0x2,%esi
ffff800000108e52:	48 89 c7             	mov    %rax,%rdi
ffff800000108e55:	48 b8 64 8b 10 00 00 	movabs $0xffff800000108b64,%rax
ffff800000108e5c:	80 ff ff 
ffff800000108e5f:	ff d0                	call   *%rax
ffff800000108e61:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(ip == 0){
ffff800000108e65:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000108e6a:	0f 85 9e 00 00 00    	jne    ffff800000108f0e <sys_open+0x131>
      end_op();
ffff800000108e70:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff800000108e77:	80 ff ff 
ffff800000108e7a:	ff d0                	call   *%rax
      return -1;
ffff800000108e7c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108e81:	e9 7f 01 00 00       	jmp    ffff800000109005 <sys_open+0x228>
    }
  } else {
    if((ip = namei(path)) == 0){
ffff800000108e86:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000108e8a:	48 89 c7             	mov    %rax,%rdi
ffff800000108e8d:	48 b8 93 37 10 00 00 	movabs $0xffff800000103793,%rax
ffff800000108e94:	80 ff ff 
ffff800000108e97:	ff d0                	call   *%rax
ffff800000108e99:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000108e9d:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000108ea2:	75 16                	jne    ffff800000108eba <sys_open+0xdd>
      end_op();
ffff800000108ea4:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff800000108eab:	80 ff ff 
ffff800000108eae:	ff d0                	call   *%rax
      return -1;
ffff800000108eb0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108eb5:	e9 4b 01 00 00       	jmp    ffff800000109005 <sys_open+0x228>
    }
    ilock(ip);
ffff800000108eba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108ebe:	48 89 c7             	mov    %rax,%rdi
ffff800000108ec1:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff800000108ec8:	80 ff ff 
ffff800000108ecb:	ff d0                	call   *%rax
    if(ip->type == T_DIR && omode != O_RDONLY){
ffff800000108ecd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108ed1:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000108ed8:	66 83 f8 01          	cmp    $0x1,%ax
ffff800000108edc:	75 30                	jne    ffff800000108f0e <sys_open+0x131>
ffff800000108ede:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000108ee1:	85 c0                	test   %eax,%eax
ffff800000108ee3:	74 29                	je     ffff800000108f0e <sys_open+0x131>
      iunlockput(ip);
ffff800000108ee5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108ee9:	48 89 c7             	mov    %rax,%rdi
ffff800000108eec:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000108ef3:	80 ff ff 
ffff800000108ef6:	ff d0                	call   *%rax
      end_op();
ffff800000108ef8:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff800000108eff:	80 ff ff 
ffff800000108f02:	ff d0                	call   *%rax
      return -1;
ffff800000108f04:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108f09:	e9 f7 00 00 00       	jmp    ffff800000109005 <sys_open+0x228>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
ffff800000108f0e:	48 b8 4a 1b 10 00 00 	movabs $0xffff800000101b4a,%rax
ffff800000108f15:	80 ff ff 
ffff800000108f18:	ff d0                	call   *%rax
ffff800000108f1a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000108f1e:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000108f23:	74 1c                	je     ffff800000108f41 <sys_open+0x164>
ffff800000108f25:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108f29:	48 89 c7             	mov    %rax,%rdi
ffff800000108f2c:	48 b8 48 83 10 00 00 	movabs $0xffff800000108348,%rax
ffff800000108f33:	80 ff ff 
ffff800000108f36:	ff d0                	call   *%rax
ffff800000108f38:	89 45 ec             	mov    %eax,-0x14(%rbp)
ffff800000108f3b:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffff800000108f3f:	79 43                	jns    ffff800000108f84 <sys_open+0x1a7>
    if(f)
ffff800000108f41:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000108f46:	74 13                	je     ffff800000108f5b <sys_open+0x17e>
      fileclose(f);
ffff800000108f48:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108f4c:	48 89 c7             	mov    %rax,%rdi
ffff800000108f4f:	48 b8 5e 1c 10 00 00 	movabs $0xffff800000101c5e,%rax
ffff800000108f56:	80 ff ff 
ffff800000108f59:	ff d0                	call   *%rax
    iunlockput(ip);
ffff800000108f5b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108f5f:	48 89 c7             	mov    %rax,%rdi
ffff800000108f62:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000108f69:	80 ff ff 
ffff800000108f6c:	ff d0                	call   *%rax
    end_op();
ffff800000108f6e:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff800000108f75:	80 ff ff 
ffff800000108f78:	ff d0                	call   *%rax
    return -1;
ffff800000108f7a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108f7f:	e9 81 00 00 00       	jmp    ffff800000109005 <sys_open+0x228>
  }
  iunlock(ip);
ffff800000108f84:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108f88:	48 89 c7             	mov    %rax,%rdi
ffff800000108f8b:	48 b8 23 2a 10 00 00 	movabs $0xffff800000102a23,%rax
ffff800000108f92:	80 ff ff 
ffff800000108f95:	ff d0                	call   *%rax
  end_op();
ffff800000108f97:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff800000108f9e:	80 ff ff 
ffff800000108fa1:	ff d0                	call   *%rax

  f->type = FD_INODE;
ffff800000108fa3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108fa7:	c7 00 02 00 00 00    	movl   $0x2,(%rax)
  f->ip = ip;
ffff800000108fad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108fb1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000108fb5:	48 89 50 18          	mov    %rdx,0x18(%rax)
  f->off = 0;
ffff800000108fb9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108fbd:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%rax)
  f->readable = !(omode & O_WRONLY);
ffff800000108fc4:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000108fc7:	83 e0 01             	and    $0x1,%eax
ffff800000108fca:	83 e0 01             	and    $0x1,%eax
ffff800000108fcd:	83 f0 01             	xor    $0x1,%eax
ffff800000108fd0:	89 c2                	mov    %eax,%edx
ffff800000108fd2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108fd6:	88 50 08             	mov    %dl,0x8(%rax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
ffff800000108fd9:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000108fdc:	83 e0 01             	and    $0x1,%eax
ffff800000108fdf:	85 c0                	test   %eax,%eax
ffff800000108fe1:	75 0a                	jne    ffff800000108fed <sys_open+0x210>
ffff800000108fe3:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000108fe6:	83 e0 02             	and    $0x2,%eax
ffff800000108fe9:	85 c0                	test   %eax,%eax
ffff800000108feb:	74 07                	je     ffff800000108ff4 <sys_open+0x217>
ffff800000108fed:	b8 01 00 00 00       	mov    $0x1,%eax
ffff800000108ff2:	eb 05                	jmp    ffff800000108ff9 <sys_open+0x21c>
ffff800000108ff4:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108ff9:	89 c2                	mov    %eax,%edx
ffff800000108ffb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108fff:	88 50 09             	mov    %dl,0x9(%rax)
  return fd;
ffff800000109002:	8b 45 ec             	mov    -0x14(%rbp),%eax
}
ffff800000109005:	c9                   	leave
ffff800000109006:	c3                   	ret

ffff800000109007 <sys_mkdir>:

int
sys_mkdir(void)
{
ffff800000109007:	55                   	push   %rbp
ffff800000109008:	48 89 e5             	mov    %rsp,%rbp
ffff80000010900b:	48 83 ec 10          	sub    $0x10,%rsp
  char *path;
  struct inode *ip;

  begin_op();
ffff80000010900f:	48 b8 bd 4e 10 00 00 	movabs $0xffff800000104ebd,%rax
ffff800000109016:	80 ff ff 
ffff800000109019:	ff d0                	call   *%rax
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
ffff80000010901b:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff80000010901f:	48 89 c6             	mov    %rax,%rsi
ffff800000109022:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000109027:	48 b8 74 81 10 00 00 	movabs $0xffff800000108174,%rax
ffff80000010902e:	80 ff ff 
ffff800000109031:	ff d0                	call   *%rax
ffff800000109033:	85 c0                	test   %eax,%eax
ffff800000109035:	78 2d                	js     ffff800000109064 <sys_mkdir+0x5d>
ffff800000109037:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010903b:	b9 00 00 00 00       	mov    $0x0,%ecx
ffff800000109040:	ba 00 00 00 00       	mov    $0x0,%edx
ffff800000109045:	be 01 00 00 00       	mov    $0x1,%esi
ffff80000010904a:	48 89 c7             	mov    %rax,%rdi
ffff80000010904d:	48 b8 64 8b 10 00 00 	movabs $0xffff800000108b64,%rax
ffff800000109054:	80 ff ff 
ffff800000109057:	ff d0                	call   *%rax
ffff800000109059:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010905d:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000109062:	75 13                	jne    ffff800000109077 <sys_mkdir+0x70>
    end_op();
ffff800000109064:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff80000010906b:	80 ff ff 
ffff80000010906e:	ff d0                	call   *%rax
    return -1;
ffff800000109070:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109075:	eb 24                	jmp    ffff80000010909b <sys_mkdir+0x94>
  }
  iunlockput(ip);
ffff800000109077:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010907b:	48 89 c7             	mov    %rax,%rdi
ffff80000010907e:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000109085:	80 ff ff 
ffff800000109088:	ff d0                	call   *%rax
  end_op();
ffff80000010908a:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff800000109091:	80 ff ff 
ffff800000109094:	ff d0                	call   *%rax
  return 0;
ffff800000109096:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010909b:	c9                   	leave
ffff80000010909c:	c3                   	ret

ffff80000010909d <sys_mknod>:

int
sys_mknod(void)
{
ffff80000010909d:	55                   	push   %rbp
ffff80000010909e:	48 89 e5             	mov    %rsp,%rbp
ffff8000001090a1:	48 83 ec 20          	sub    $0x20,%rsp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
ffff8000001090a5:	48 b8 bd 4e 10 00 00 	movabs $0xffff800000104ebd,%rax
ffff8000001090ac:	80 ff ff 
ffff8000001090af:	ff d0                	call   *%rax
  if((argstr(0, &path)) < 0 ||
ffff8000001090b1:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff8000001090b5:	48 89 c6             	mov    %rax,%rsi
ffff8000001090b8:	bf 00 00 00 00       	mov    $0x0,%edi
ffff8000001090bd:	48 b8 74 81 10 00 00 	movabs $0xffff800000108174,%rax
ffff8000001090c4:	80 ff ff 
ffff8000001090c7:	ff d0                	call   *%rax
ffff8000001090c9:	85 c0                	test   %eax,%eax
ffff8000001090cb:	78 67                	js     ffff800000109134 <sys_mknod+0x97>
     argint(1, &major) < 0 ||
ffff8000001090cd:	48 8d 45 ec          	lea    -0x14(%rbp),%rax
ffff8000001090d1:	48 89 c6             	mov    %rax,%rsi
ffff8000001090d4:	bf 01 00 00 00       	mov    $0x1,%edi
ffff8000001090d9:	48 b8 90 80 10 00 00 	movabs $0xffff800000108090,%rax
ffff8000001090e0:	80 ff ff 
ffff8000001090e3:	ff d0                	call   *%rax
  if((argstr(0, &path)) < 0 ||
ffff8000001090e5:	85 c0                	test   %eax,%eax
ffff8000001090e7:	78 4b                	js     ffff800000109134 <sys_mknod+0x97>
     argint(2, &minor) < 0 ||
ffff8000001090e9:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffff8000001090ed:	48 89 c6             	mov    %rax,%rsi
ffff8000001090f0:	bf 02 00 00 00       	mov    $0x2,%edi
ffff8000001090f5:	48 b8 90 80 10 00 00 	movabs $0xffff800000108090,%rax
ffff8000001090fc:	80 ff ff 
ffff8000001090ff:	ff d0                	call   *%rax
     argint(1, &major) < 0 ||
ffff800000109101:	85 c0                	test   %eax,%eax
ffff800000109103:	78 2f                	js     ffff800000109134 <sys_mknod+0x97>
     (ip = create(path, T_DEV, major, minor)) == 0){
ffff800000109105:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000109108:	0f bf c8             	movswl %ax,%ecx
ffff80000010910b:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff80000010910e:	0f bf d0             	movswl %ax,%edx
ffff800000109111:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109115:	be 03 00 00 00       	mov    $0x3,%esi
ffff80000010911a:	48 89 c7             	mov    %rax,%rdi
ffff80000010911d:	48 b8 64 8b 10 00 00 	movabs $0xffff800000108b64,%rax
ffff800000109124:	80 ff ff 
ffff800000109127:	ff d0                	call   *%rax
ffff800000109129:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
     argint(2, &minor) < 0 ||
ffff80000010912d:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000109132:	75 13                	jne    ffff800000109147 <sys_mknod+0xaa>
    end_op();
ffff800000109134:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff80000010913b:	80 ff ff 
ffff80000010913e:	ff d0                	call   *%rax
    return -1;
ffff800000109140:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109145:	eb 24                	jmp    ffff80000010916b <sys_mknod+0xce>
  }
  iunlockput(ip);
ffff800000109147:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010914b:	48 89 c7             	mov    %rax,%rdi
ffff80000010914e:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000109155:	80 ff ff 
ffff800000109158:	ff d0                	call   *%rax
  end_op();
ffff80000010915a:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff800000109161:	80 ff ff 
ffff800000109164:	ff d0                	call   *%rax
  return 0;
ffff800000109166:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010916b:	c9                   	leave
ffff80000010916c:	c3                   	ret

ffff80000010916d <sys_chdir>:

int
sys_chdir(void)
{
ffff80000010916d:	55                   	push   %rbp
ffff80000010916e:	48 89 e5             	mov    %rsp,%rbp
ffff800000109171:	48 83 ec 10          	sub    $0x10,%rsp
  char *path;
  struct inode *ip;

  begin_op();
ffff800000109175:	48 b8 bd 4e 10 00 00 	movabs $0xffff800000104ebd,%rax
ffff80000010917c:	80 ff ff 
ffff80000010917f:	ff d0                	call   *%rax
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
ffff800000109181:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff800000109185:	48 89 c6             	mov    %rax,%rsi
ffff800000109188:	bf 00 00 00 00       	mov    $0x0,%edi
ffff80000010918d:	48 b8 74 81 10 00 00 	movabs $0xffff800000108174,%rax
ffff800000109194:	80 ff ff 
ffff800000109197:	ff d0                	call   *%rax
ffff800000109199:	85 c0                	test   %eax,%eax
ffff80000010919b:	78 1e                	js     ffff8000001091bb <sys_chdir+0x4e>
ffff80000010919d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001091a1:	48 89 c7             	mov    %rax,%rdi
ffff8000001091a4:	48 b8 93 37 10 00 00 	movabs $0xffff800000103793,%rax
ffff8000001091ab:	80 ff ff 
ffff8000001091ae:	ff d0                	call   *%rax
ffff8000001091b0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001091b4:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff8000001091b9:	75 16                	jne    ffff8000001091d1 <sys_chdir+0x64>
    end_op();
ffff8000001091bb:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff8000001091c2:	80 ff ff 
ffff8000001091c5:	ff d0                	call   *%rax
    return -1;
ffff8000001091c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001091cc:	e9 a5 00 00 00       	jmp    ffff800000109276 <sys_chdir+0x109>
  }
  ilock(ip);
ffff8000001091d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001091d5:	48 89 c7             	mov    %rax,%rdi
ffff8000001091d8:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff8000001091df:	80 ff ff 
ffff8000001091e2:	ff d0                	call   *%rax
  if(ip->type != T_DIR){
ffff8000001091e4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001091e8:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff8000001091ef:	66 83 f8 01          	cmp    $0x1,%ax
ffff8000001091f3:	74 26                	je     ffff80000010921b <sys_chdir+0xae>
    iunlockput(ip);
ffff8000001091f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001091f9:	48 89 c7             	mov    %rax,%rdi
ffff8000001091fc:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000109203:	80 ff ff 
ffff800000109206:	ff d0                	call   *%rax
    end_op();
ffff800000109208:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff80000010920f:	80 ff ff 
ffff800000109212:	ff d0                	call   *%rax
    return -1;
ffff800000109214:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109219:	eb 5b                	jmp    ffff800000109276 <sys_chdir+0x109>
  }
  iunlock(ip);
ffff80000010921b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010921f:	48 89 c7             	mov    %rax,%rdi
ffff800000109222:	48 b8 23 2a 10 00 00 	movabs $0xffff800000102a23,%rax
ffff800000109229:	80 ff ff 
ffff80000010922c:	ff d0                	call   *%rax
  iput(proc->cwd);
ffff80000010922e:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109235:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109239:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffff800000109240:	48 89 c7             	mov    %rax,%rdi
ffff800000109243:	48 b8 8f 2a 10 00 00 	movabs $0xffff800000102a8f,%rax
ffff80000010924a:	80 ff ff 
ffff80000010924d:	ff d0                	call   *%rax
  end_op();
ffff80000010924f:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff800000109256:	80 ff ff 
ffff800000109259:	ff d0                	call   *%rax
  proc->cwd = ip;
ffff80000010925b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109262:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109266:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010926a:	48 89 90 c8 00 00 00 	mov    %rdx,0xc8(%rax)
  return 0;
ffff800000109271:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000109276:	c9                   	leave
ffff800000109277:	c3                   	ret

ffff800000109278 <sys_exec>:

int
sys_exec(void)
{
ffff800000109278:	55                   	push   %rbp
ffff800000109279:	48 89 e5             	mov    %rsp,%rbp
ffff80000010927c:	48 81 ec 20 01 00 00 	sub    $0x120,%rsp
  char *path, *argv[MAXARG];
  int i;
  addr_t uargv, uarg;

  if(argstr(0, &path) < 0 || argaddr(1, &uargv) < 0){
ffff800000109283:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff800000109287:	48 89 c6             	mov    %rax,%rsi
ffff80000010928a:	bf 00 00 00 00       	mov    $0x0,%edi
ffff80000010928f:	48 b8 74 81 10 00 00 	movabs $0xffff800000108174,%rax
ffff800000109296:	80 ff ff 
ffff800000109299:	ff d0                	call   *%rax
ffff80000010929b:	85 c0                	test   %eax,%eax
ffff80000010929d:	78 44                	js     ffff8000001092e3 <sys_exec+0x6b>
ffff80000010929f:	48 8d 85 e8 fe ff ff 	lea    -0x118(%rbp),%rax
ffff8000001092a6:	48 89 c6             	mov    %rax,%rsi
ffff8000001092a9:	bf 01 00 00 00       	mov    $0x1,%edi
ffff8000001092ae:	48 b8 bf 80 10 00 00 	movabs $0xffff8000001080bf,%rax
ffff8000001092b5:	80 ff ff 
ffff8000001092b8:	ff d0                	call   *%rax
    return -1;
  }
  memset(argv, 0, sizeof(argv));
ffff8000001092ba:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
ffff8000001092c1:	ba 00 01 00 00       	mov    $0x100,%edx
ffff8000001092c6:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001092cb:	48 89 c7             	mov    %rax,%rdi
ffff8000001092ce:	48 b8 ce 7a 10 00 00 	movabs $0xffff800000107ace,%rax
ffff8000001092d5:	80 ff ff 
ffff8000001092d8:	ff d0                	call   *%rax
  for(i=0;; i++){
ffff8000001092da:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001092e1:	eb 0a                	jmp    ffff8000001092ed <sys_exec+0x75>
    return -1;
ffff8000001092e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001092e8:	e9 cb 00 00 00       	jmp    ffff8000001093b8 <sys_exec+0x140>
    if(i >= NELEM(argv))
ffff8000001092ed:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001092f0:	83 f8 1f             	cmp    $0x1f,%eax
ffff8000001092f3:	76 0a                	jbe    ffff8000001092ff <sys_exec+0x87>
      return -1;
ffff8000001092f5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001092fa:	e9 b9 00 00 00       	jmp    ffff8000001093b8 <sys_exec+0x140>
    if(fetchaddr(uargv+(sizeof(addr_t))*i, (addr_t*)&uarg) < 0)
ffff8000001092ff:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000109302:	48 98                	cltq
ffff800000109304:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010930b:	00 
ffff80000010930c:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
ffff800000109313:	48 01 c2             	add    %rax,%rdx
ffff800000109316:	48 8d 85 e0 fe ff ff 	lea    -0x120(%rbp),%rax
ffff80000010931d:	48 89 c6             	mov    %rax,%rsi
ffff800000109320:	48 89 d7             	mov    %rdx,%rdi
ffff800000109323:	48 b8 99 7e 10 00 00 	movabs $0xffff800000107e99,%rax
ffff80000010932a:	80 ff ff 
ffff80000010932d:	ff d0                	call   *%rax
ffff80000010932f:	85 c0                	test   %eax,%eax
ffff800000109331:	79 07                	jns    ffff80000010933a <sys_exec+0xc2>
      return -1;
ffff800000109333:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109338:	eb 7e                	jmp    ffff8000001093b8 <sys_exec+0x140>
    if(uarg == 0){
ffff80000010933a:	48 8b 85 e0 fe ff ff 	mov    -0x120(%rbp),%rax
ffff800000109341:	48 85 c0             	test   %rax,%rax
ffff800000109344:	75 31                	jne    ffff800000109377 <sys_exec+0xff>
      argv[i] = 0;
ffff800000109346:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000109349:	48 98                	cltq
ffff80000010934b:	48 c7 84 c5 f0 fe ff 	movq   $0x0,-0x110(%rbp,%rax,8)
ffff800000109352:	ff 00 00 00 00 
      break;
ffff800000109357:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
ffff800000109358:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010935c:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
ffff800000109363:	48 89 d6             	mov    %rdx,%rsi
ffff800000109366:	48 89 c7             	mov    %rax,%rdi
ffff800000109369:	48 b8 43 15 10 00 00 	movabs $0xffff800000101543,%rax
ffff800000109370:	80 ff ff 
ffff800000109373:	ff d0                	call   *%rax
ffff800000109375:	eb 41                	jmp    ffff8000001093b8 <sys_exec+0x140>
    if(fetchstr(uarg, &argv[i]) < 0)
ffff800000109377:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
ffff80000010937e:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000109381:	48 63 d2             	movslq %edx,%rdx
ffff800000109384:	48 c1 e2 03          	shl    $0x3,%rdx
ffff800000109388:	48 01 c2             	add    %rax,%rdx
ffff80000010938b:	48 8b 85 e0 fe ff ff 	mov    -0x120(%rbp),%rax
ffff800000109392:	48 89 d6             	mov    %rdx,%rsi
ffff800000109395:	48 89 c7             	mov    %rax,%rdi
ffff800000109398:	48 b8 fe 7e 10 00 00 	movabs $0xffff800000107efe,%rax
ffff80000010939f:	80 ff ff 
ffff8000001093a2:	ff d0                	call   *%rax
ffff8000001093a4:	85 c0                	test   %eax,%eax
ffff8000001093a6:	79 07                	jns    ffff8000001093af <sys_exec+0x137>
      return -1;
ffff8000001093a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001093ad:	eb 09                	jmp    ffff8000001093b8 <sys_exec+0x140>
  for(i=0;; i++){
ffff8000001093af:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    if(i >= NELEM(argv))
ffff8000001093b3:	e9 35 ff ff ff       	jmp    ffff8000001092ed <sys_exec+0x75>
}
ffff8000001093b8:	c9                   	leave
ffff8000001093b9:	c3                   	ret

ffff8000001093ba <sys_pipe>:

int
sys_pipe(void)
{
ffff8000001093ba:	55                   	push   %rbp
ffff8000001093bb:	48 89 e5             	mov    %rsp,%rbp
ffff8000001093be:	48 83 ec 20          	sub    $0x20,%rsp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
ffff8000001093c2:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff8000001093c6:	ba 08 00 00 00       	mov    $0x8,%edx
ffff8000001093cb:	48 89 c6             	mov    %rax,%rsi
ffff8000001093ce:	bf 00 00 00 00       	mov    $0x0,%edi
ffff8000001093d3:	48 b8 ed 80 10 00 00 	movabs $0xffff8000001080ed,%rax
ffff8000001093da:	80 ff ff 
ffff8000001093dd:	ff d0                	call   *%rax
    return -1;
  if(pipealloc(&rf, &wf) < 0)
ffff8000001093df:	48 8d 55 e0          	lea    -0x20(%rbp),%rdx
ffff8000001093e3:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffff8000001093e7:	48 89 d6             	mov    %rdx,%rsi
ffff8000001093ea:	48 89 c7             	mov    %rax,%rdi
ffff8000001093ed:	48 b8 02 5c 10 00 00 	movabs $0xffff800000105c02,%rax
ffff8000001093f4:	80 ff ff 
ffff8000001093f7:	ff d0                	call   *%rax
ffff8000001093f9:	85 c0                	test   %eax,%eax
ffff8000001093fb:	79 0a                	jns    ffff800000109407 <sys_pipe+0x4d>
    return -1;
ffff8000001093fd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109402:	e9 ab 00 00 00       	jmp    ffff8000001094b2 <sys_pipe+0xf8>
  fd0 = -1;
ffff800000109407:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
ffff80000010940e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109412:	48 89 c7             	mov    %rax,%rdi
ffff800000109415:	48 b8 48 83 10 00 00 	movabs $0xffff800000108348,%rax
ffff80000010941c:	80 ff ff 
ffff80000010941f:	ff d0                	call   *%rax
ffff800000109421:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000109424:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000109428:	78 1c                	js     ffff800000109446 <sys_pipe+0x8c>
ffff80000010942a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010942e:	48 89 c7             	mov    %rax,%rdi
ffff800000109431:	48 b8 48 83 10 00 00 	movabs $0xffff800000108348,%rax
ffff800000109438:	80 ff ff 
ffff80000010943b:	ff d0                	call   *%rax
ffff80000010943d:	89 45 f8             	mov    %eax,-0x8(%rbp)
ffff800000109440:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
ffff800000109444:	79 51                	jns    ffff800000109497 <sys_pipe+0xdd>
    if(fd0 >= 0)
ffff800000109446:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff80000010944a:	78 1e                	js     ffff80000010946a <sys_pipe+0xb0>
      proc->ofile[fd0] = 0;
ffff80000010944c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109453:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109457:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010945a:	48 63 d2             	movslq %edx,%rdx
ffff80000010945d:	48 83 c2 08          	add    $0x8,%rdx
ffff800000109461:	48 c7 44 d0 08 00 00 	movq   $0x0,0x8(%rax,%rdx,8)
ffff800000109468:	00 00 
    fileclose(rf);
ffff80000010946a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010946e:	48 89 c7             	mov    %rax,%rdi
ffff800000109471:	48 b8 5e 1c 10 00 00 	movabs $0xffff800000101c5e,%rax
ffff800000109478:	80 ff ff 
ffff80000010947b:	ff d0                	call   *%rax
    fileclose(wf);
ffff80000010947d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000109481:	48 89 c7             	mov    %rax,%rdi
ffff800000109484:	48 b8 5e 1c 10 00 00 	movabs $0xffff800000101c5e,%rax
ffff80000010948b:	80 ff ff 
ffff80000010948e:	ff d0                	call   *%rax
    return -1;
ffff800000109490:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109495:	eb 1b                	jmp    ffff8000001094b2 <sys_pipe+0xf8>
  }
  fd[0] = fd0;
ffff800000109497:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010949b:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010949e:	89 10                	mov    %edx,(%rax)
  fd[1] = fd1;
ffff8000001094a0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001094a4:	48 8d 50 04          	lea    0x4(%rax),%rdx
ffff8000001094a8:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff8000001094ab:	89 02                	mov    %eax,(%rdx)
  return 0;
ffff8000001094ad:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff8000001094b2:	c9                   	leave
ffff8000001094b3:	c3                   	ret

ffff8000001094b4 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
ffff8000001094b4:	55                   	push   %rbp
ffff8000001094b5:	48 89 e5             	mov    %rsp,%rbp
  return fork();
ffff8000001094b8:	48 b8 14 65 10 00 00 	movabs $0xffff800000106514,%rax
ffff8000001094bf:	80 ff ff 
ffff8000001094c2:	ff d0                	call   *%rax
}
ffff8000001094c4:	5d                   	pop    %rbp
ffff8000001094c5:	c3                   	ret

ffff8000001094c6 <sys_exit>:

int
sys_exit(void)
{
ffff8000001094c6:	55                   	push   %rbp
ffff8000001094c7:	48 89 e5             	mov    %rsp,%rbp
  exit();
ffff8000001094ca:	48 b8 cc 67 10 00 00 	movabs $0xffff8000001067cc,%rax
ffff8000001094d1:	80 ff ff 
ffff8000001094d4:	ff d0                	call   *%rax
  return 0;  // not reached
ffff8000001094d6:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff8000001094db:	5d                   	pop    %rbp
ffff8000001094dc:	c3                   	ret

ffff8000001094dd <sys_wait>:

int
sys_wait(void)
{
ffff8000001094dd:	55                   	push   %rbp
ffff8000001094de:	48 89 e5             	mov    %rsp,%rbp
  return wait();
ffff8000001094e1:	48 b8 bd 69 10 00 00 	movabs $0xffff8000001069bd,%rax
ffff8000001094e8:	80 ff ff 
ffff8000001094eb:	ff d0                	call   *%rax
}
ffff8000001094ed:	5d                   	pop    %rbp
ffff8000001094ee:	c3                   	ret

ffff8000001094ef <sys_kill>:

int
sys_kill(void)
{
ffff8000001094ef:	55                   	push   %rbp
ffff8000001094f0:	48 89 e5             	mov    %rsp,%rbp
ffff8000001094f3:	48 83 ec 10          	sub    $0x10,%rsp
  int pid;

  if(argint(0, &pid) < 0)
ffff8000001094f7:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
ffff8000001094fb:	48 89 c6             	mov    %rax,%rsi
ffff8000001094fe:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000109503:	48 b8 90 80 10 00 00 	movabs $0xffff800000108090,%rax
ffff80000010950a:	80 ff ff 
ffff80000010950d:	ff d0                	call   *%rax
ffff80000010950f:	85 c0                	test   %eax,%eax
ffff800000109511:	79 07                	jns    ffff80000010951a <sys_kill+0x2b>
    return -1;
ffff800000109513:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109518:	eb 11                	jmp    ffff80000010952b <sys_kill+0x3c>
  return kill(pid);
ffff80000010951a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010951d:	89 c7                	mov    %eax,%edi
ffff80000010951f:	48 b8 1a 70 10 00 00 	movabs $0xffff80000010701a,%rax
ffff800000109526:	80 ff ff 
ffff800000109529:	ff d0                	call   *%rax
}
ffff80000010952b:	c9                   	leave
ffff80000010952c:	c3                   	ret

ffff80000010952d <sys_getpid>:

int
sys_getpid(void)
{
ffff80000010952d:	55                   	push   %rbp
ffff80000010952e:	48 89 e5             	mov    %rsp,%rbp
  return proc->pid;
ffff800000109531:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109538:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010953c:	8b 40 1c             	mov    0x1c(%rax),%eax
}
ffff80000010953f:	5d                   	pop    %rbp
ffff800000109540:	c3                   	ret

ffff800000109541 <sys_sbrk>:

addr_t
sys_sbrk(void)
{
ffff800000109541:	55                   	push   %rbp
ffff800000109542:	48 89 e5             	mov    %rsp,%rbp
ffff800000109545:	48 83 ec 10          	sub    $0x10,%rsp
  addr_t addr;
  addr_t n;

  argaddr(0, &n);
ffff800000109549:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff80000010954d:	48 89 c6             	mov    %rax,%rsi
ffff800000109550:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000109555:	48 b8 bf 80 10 00 00 	movabs $0xffff8000001080bf,%rax
ffff80000010955c:	80 ff ff 
ffff80000010955f:	ff d0                	call   *%rax
  addr = proc->sz;
ffff800000109561:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109568:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010956c:	48 8b 00             	mov    (%rax),%rax
ffff80000010956f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(growproc(n) < 0)
ffff800000109573:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109577:	48 89 c7             	mov    %rax,%rdi
ffff80000010957a:	48 b8 31 64 10 00 00 	movabs $0xffff800000106431,%rax
ffff800000109581:	80 ff ff 
ffff800000109584:	ff d0                	call   *%rax
ffff800000109586:	85 c0                	test   %eax,%eax
ffff800000109588:	79 09                	jns    ffff800000109593 <sys_sbrk+0x52>
    return -1;
ffff80000010958a:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
ffff800000109591:	eb 04                	jmp    ffff800000109597 <sys_sbrk+0x56>
  return addr;
ffff800000109593:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000109597:	c9                   	leave
ffff800000109598:	c3                   	ret

ffff800000109599 <sys_sleep>:

int
sys_sleep(void)
{
ffff800000109599:	55                   	push   %rbp
ffff80000010959a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010959d:	48 83 ec 10          	sub    $0x10,%rsp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
ffff8000001095a1:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff8000001095a5:	48 89 c6             	mov    %rax,%rsi
ffff8000001095a8:	bf 00 00 00 00       	mov    $0x0,%edi
ffff8000001095ad:	48 b8 90 80 10 00 00 	movabs $0xffff800000108090,%rax
ffff8000001095b4:	80 ff ff 
ffff8000001095b7:	ff d0                	call   *%rax
ffff8000001095b9:	85 c0                	test   %eax,%eax
ffff8000001095bb:	79 0a                	jns    ffff8000001095c7 <sys_sleep+0x2e>
    return -1;
ffff8000001095bd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001095c2:	e9 b6 00 00 00       	jmp    ffff80000010967d <sys_sleep+0xe4>
  acquire(&tickslock);
ffff8000001095c7:	48 b8 e0 c0 11 00 00 	movabs $0xffff80000011c0e0,%rax
ffff8000001095ce:	80 ff ff 
ffff8000001095d1:	48 89 c7             	mov    %rax,%rdi
ffff8000001095d4:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff8000001095db:	80 ff ff 
ffff8000001095de:	ff d0                	call   *%rax
  ticks0 = ticks;
ffff8000001095e0:	48 b8 48 c1 11 00 00 	movabs $0xffff80000011c148,%rax
ffff8000001095e7:	80 ff ff 
ffff8000001095ea:	8b 00                	mov    (%rax),%eax
ffff8000001095ec:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while(ticks - ticks0 < n){
ffff8000001095ef:	eb 58                	jmp    ffff800000109649 <sys_sleep+0xb0>
    if(proc->killed){
ffff8000001095f1:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001095f8:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001095fc:	8b 40 40             	mov    0x40(%rax),%eax
ffff8000001095ff:	85 c0                	test   %eax,%eax
ffff800000109601:	74 20                	je     ffff800000109623 <sys_sleep+0x8a>
      release(&tickslock);
ffff800000109603:	48 b8 e0 c0 11 00 00 	movabs $0xffff80000011c0e0,%rax
ffff80000010960a:	80 ff ff 
ffff80000010960d:	48 89 c7             	mov    %rax,%rdi
ffff800000109610:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000109617:	80 ff ff 
ffff80000010961a:	ff d0                	call   *%rax
      return -1;
ffff80000010961c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109621:	eb 5a                	jmp    ffff80000010967d <sys_sleep+0xe4>
    }
    sleep(&ticks, &tickslock);
ffff800000109623:	48 ba e0 c0 11 00 00 	movabs $0xffff80000011c0e0,%rdx
ffff80000010962a:	80 ff ff 
ffff80000010962d:	48 b8 48 c1 11 00 00 	movabs $0xffff80000011c148,%rax
ffff800000109634:	80 ff ff 
ffff800000109637:	48 89 d6             	mov    %rdx,%rsi
ffff80000010963a:	48 89 c7             	mov    %rax,%rdi
ffff80000010963d:	48 b8 51 6e 10 00 00 	movabs $0xffff800000106e51,%rax
ffff800000109644:	80 ff ff 
ffff800000109647:	ff d0                	call   *%rax
  while(ticks - ticks0 < n){
ffff800000109649:	48 b8 48 c1 11 00 00 	movabs $0xffff80000011c148,%rax
ffff800000109650:	80 ff ff 
ffff800000109653:	8b 00                	mov    (%rax),%eax
ffff800000109655:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff800000109658:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffff80000010965b:	39 d0                	cmp    %edx,%eax
ffff80000010965d:	72 92                	jb     ffff8000001095f1 <sys_sleep+0x58>
  }
  release(&tickslock);
ffff80000010965f:	48 b8 e0 c0 11 00 00 	movabs $0xffff80000011c0e0,%rax
ffff800000109666:	80 ff ff 
ffff800000109669:	48 89 c7             	mov    %rax,%rdi
ffff80000010966c:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000109673:	80 ff ff 
ffff800000109676:	ff d0                	call   *%rax
  return 0;
ffff800000109678:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010967d:	c9                   	leave
ffff80000010967e:	c3                   	ret

ffff80000010967f <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
ffff80000010967f:	55                   	push   %rbp
ffff800000109680:	48 89 e5             	mov    %rsp,%rbp
ffff800000109683:	48 83 ec 10          	sub    $0x10,%rsp
  uint xticks;

  acquire(&tickslock);
ffff800000109687:	48 b8 e0 c0 11 00 00 	movabs $0xffff80000011c0e0,%rax
ffff80000010968e:	80 ff ff 
ffff800000109691:	48 89 c7             	mov    %rax,%rdi
ffff800000109694:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff80000010969b:	80 ff ff 
ffff80000010969e:	ff d0                	call   *%rax
  xticks = ticks;
ffff8000001096a0:	48 b8 48 c1 11 00 00 	movabs $0xffff80000011c148,%rax
ffff8000001096a7:	80 ff ff 
ffff8000001096aa:	8b 00                	mov    (%rax),%eax
ffff8000001096ac:	89 45 fc             	mov    %eax,-0x4(%rbp)
  release(&tickslock);
ffff8000001096af:	48 b8 e0 c0 11 00 00 	movabs $0xffff80000011c0e0,%rax
ffff8000001096b6:	80 ff ff 
ffff8000001096b9:	48 89 c7             	mov    %rax,%rdi
ffff8000001096bc:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff8000001096c3:	80 ff ff 
ffff8000001096c6:	ff d0                	call   *%rax
  return xticks;
ffff8000001096c8:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff8000001096cb:	c9                   	leave
ffff8000001096cc:	c3                   	ret

ffff8000001096cd <sys_send>:

int
sys_send(void)
{
ffff8000001096cd:	55                   	push   %rbp
ffff8000001096ce:	48 89 e5             	mov    %rsp,%rbp
ffff8000001096d1:	48 83 ec 10          	sub    $0x10,%rsp
	int pid;
	char* msg;

	if (argint(0, &pid) < 0 || argptr(1, &msg, sizeof(struct ipc_msg)) < 0) 
ffff8000001096d5:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
ffff8000001096d9:	48 89 c6             	mov    %rax,%rsi
ffff8000001096dc:	bf 00 00 00 00       	mov    $0x0,%edi
ffff8000001096e1:	48 b8 90 80 10 00 00 	movabs $0xffff800000108090,%rax
ffff8000001096e8:	80 ff ff 
ffff8000001096eb:	ff d0                	call   *%rax
ffff8000001096ed:	85 c0                	test   %eax,%eax
ffff8000001096ef:	78 37                	js     ffff800000109728 <sys_send+0x5b>
ffff8000001096f1:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff8000001096f5:	ba 4c 00 00 00       	mov    $0x4c,%edx
ffff8000001096fa:	48 89 c6             	mov    %rax,%rsi
ffff8000001096fd:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000109702:	48 b8 ed 80 10 00 00 	movabs $0xffff8000001080ed,%rax
ffff800000109709:	80 ff ff 
ffff80000010970c:	ff d0                	call   *%rax
		return -1;

	return send(pid, msg);
ffff80000010970e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000109712:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000109715:	48 89 d6             	mov    %rdx,%rsi
ffff800000109718:	89 c7                	mov    %eax,%edi
ffff80000010971a:	48 b8 48 72 10 00 00 	movabs $0xffff800000107248,%rax
ffff800000109721:	80 ff ff 
ffff800000109724:	ff d0                	call   *%rax
ffff800000109726:	eb 05                	jmp    ffff80000010972d <sys_send+0x60>
		return -1;
ffff800000109728:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff80000010972d:	c9                   	leave
ffff80000010972e:	c3                   	ret

ffff80000010972f <sys_recv>:

int
sys_recv(void)
{
ffff80000010972f:	55                   	push   %rbp
ffff800000109730:	48 89 e5             	mov    %rsp,%rbp
ffff800000109733:	48 83 ec 10          	sub    $0x10,%rsp
	char *msg;
	if (argptr(0, &msg, sizeof(struct ipc_msg)) < 0) 
ffff800000109737:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff80000010973b:	ba 4c 00 00 00       	mov    $0x4c,%edx
ffff800000109740:	48 89 c6             	mov    %rax,%rsi
ffff800000109743:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000109748:	48 b8 ed 80 10 00 00 	movabs $0xffff8000001080ed,%rax
ffff80000010974f:	80 ff ff 
ffff800000109752:	ff d0                	call   *%rax
		return -1;

	return recv(msg);
ffff800000109754:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109758:	48 89 c7             	mov    %rax,%rdi
ffff80000010975b:	48 b8 e5 73 10 00 00 	movabs $0xffff8000001073e5,%rax
ffff800000109762:	80 ff ff 
ffff800000109765:	ff d0                	call   *%rax
}
ffff800000109767:	c9                   	leave
ffff800000109768:	c3                   	ret

ffff800000109769 <alltraps>:
# vectors.S sends all traps here.
.global alltraps
alltraps:
  # Build trap frame.
  pushq   %r15
ffff800000109769:	41 57                	push   %r15
  pushq   %r14
ffff80000010976b:	41 56                	push   %r14
  pushq   %r13
ffff80000010976d:	41 55                	push   %r13
  pushq   %r12
ffff80000010976f:	41 54                	push   %r12
  pushq   %r11
ffff800000109771:	41 53                	push   %r11
  pushq   %r10
ffff800000109773:	41 52                	push   %r10
  pushq   %r9
ffff800000109775:	41 51                	push   %r9
  pushq   %r8
ffff800000109777:	41 50                	push   %r8
  pushq   %rdi
ffff800000109779:	57                   	push   %rdi
  pushq   %rsi
ffff80000010977a:	56                   	push   %rsi
  pushq   %rbp
ffff80000010977b:	55                   	push   %rbp
  pushq   %rdx
ffff80000010977c:	52                   	push   %rdx
  pushq   %rcx
ffff80000010977d:	51                   	push   %rcx
  pushq   %rbx
ffff80000010977e:	53                   	push   %rbx
  pushq   %rax
ffff80000010977f:	50                   	push   %rax

  movq    %rsp, %rdi  # frame in arg1
ffff800000109780:	48 89 e7             	mov    %rsp,%rdi
  callq   trap
ffff800000109783:	e8 7b 02 00 00       	call   ffff800000109a03 <trap>

ffff800000109788 <trapret>:
# Return falls through to trapret...

.global trapret
trapret:
  popq    %rax
ffff800000109788:	58                   	pop    %rax
  popq    %rbx
ffff800000109789:	5b                   	pop    %rbx
  popq    %rcx
ffff80000010978a:	59                   	pop    %rcx
  popq    %rdx
ffff80000010978b:	5a                   	pop    %rdx
  popq    %rbp
ffff80000010978c:	5d                   	pop    %rbp
  popq    %rsi
ffff80000010978d:	5e                   	pop    %rsi
  popq    %rdi
ffff80000010978e:	5f                   	pop    %rdi
  popq    %r8
ffff80000010978f:	41 58                	pop    %r8
  popq    %r9
ffff800000109791:	41 59                	pop    %r9
  popq    %r10
ffff800000109793:	41 5a                	pop    %r10
  popq    %r11
ffff800000109795:	41 5b                	pop    %r11
  popq    %r12
ffff800000109797:	41 5c                	pop    %r12
  popq    %r13
ffff800000109799:	41 5d                	pop    %r13
  popq    %r14
ffff80000010979b:	41 5e                	pop    %r14
  popq    %r15
ffff80000010979d:	41 5f                	pop    %r15

  addq    $16, %rsp  # discard trapnum and errorcode
ffff80000010979f:	48 83 c4 10          	add    $0x10,%rsp
  iretq
ffff8000001097a3:	48 cf                	iretq

ffff8000001097a5 <syscall_entry>:
.global syscall_entry
syscall_entry:
  # switch to kernel stack. With the syscall instruction,
  # this is a kernel resposibility
  # store %rsp on the top of proc->kstack,
  movq    %rax, %fs:(0)      # save %rax above __thread vars
ffff8000001097a5:	64 48 89 04 25 00 00 	mov    %rax,%fs:0x0
ffff8000001097ac:	00 00 
  movq    %fs:(-8), %rax     # %fs:(-8) is proc (the last __thread)
ffff8000001097ae:	64 48 8b 04 25 f8 ff 	mov    %fs:0xfffffffffffffff8,%rax
ffff8000001097b5:	ff ff 
  movq    0x10(%rax), %rax   # get proc->kstack (see struct proc)
ffff8000001097b7:	48 8b 40 10          	mov    0x10(%rax),%rax
  addq    $(4096-16), %rax   # %rax points to tf->rsp
ffff8000001097bb:	48 05 f0 0f 00 00    	add    $0xff0,%rax
  movq    %rsp, (%rax)       # save user rsp to tf->rsp
ffff8000001097c1:	48 89 20             	mov    %rsp,(%rax)
  movq    %rax, %rsp         # switch to the kstack
ffff8000001097c4:	48 89 c4             	mov    %rax,%rsp
  movq    %fs:(0), %rax      # restore %rax
ffff8000001097c7:	64 48 8b 04 25 00 00 	mov    %fs:0x0,%rax
ffff8000001097ce:	00 00 

  pushq   %r11         # rflags
ffff8000001097d0:	41 53                	push   %r11
  pushq   $0           # cs is ignored
ffff8000001097d2:	6a 00                	push   $0x0
  pushq   %rcx         # rip (next user insn)
ffff8000001097d4:	51                   	push   %rcx

  pushq   $0           # err
ffff8000001097d5:	6a 00                	push   $0x0
  pushq   $0           # trapno ignored
ffff8000001097d7:	6a 00                	push   $0x0

  pushq   %r15
ffff8000001097d9:	41 57                	push   %r15
  pushq   %r14
ffff8000001097db:	41 56                	push   %r14
  pushq   %r13
ffff8000001097dd:	41 55                	push   %r13
  pushq   %r12
ffff8000001097df:	41 54                	push   %r12
  pushq   %r11
ffff8000001097e1:	41 53                	push   %r11
  pushq   %r10
ffff8000001097e3:	41 52                	push   %r10
  pushq   %r9
ffff8000001097e5:	41 51                	push   %r9
  pushq   %r8
ffff8000001097e7:	41 50                	push   %r8
  pushq   %rdi
ffff8000001097e9:	57                   	push   %rdi
  pushq   %rsi
ffff8000001097ea:	56                   	push   %rsi
  pushq   %rbp
ffff8000001097eb:	55                   	push   %rbp
  pushq   %rdx
ffff8000001097ec:	52                   	push   %rdx
  pushq   %rcx
ffff8000001097ed:	51                   	push   %rcx
  pushq   %rbx
ffff8000001097ee:	53                   	push   %rbx
  pushq   %rax
ffff8000001097ef:	50                   	push   %rax

  movq    %rsp, %rdi  # frame in arg1
ffff8000001097f0:	48 89 e7             	mov    %rsp,%rdi
  callq   syscall
ffff8000001097f3:	e8 cb e9 ff ff       	call   ffff8000001081c3 <syscall>

ffff8000001097f8 <syscall_trapret>:
# Return falls through to syscall_trapret...
#PAGEBREAK!

.global syscall_trapret
syscall_trapret:
  popq    %rax
ffff8000001097f8:	58                   	pop    %rax
  popq    %rbx
ffff8000001097f9:	5b                   	pop    %rbx
  popq    %rcx
ffff8000001097fa:	59                   	pop    %rcx
  popq    %rdx
ffff8000001097fb:	5a                   	pop    %rdx
  popq    %rbp
ffff8000001097fc:	5d                   	pop    %rbp
  popq    %rsi
ffff8000001097fd:	5e                   	pop    %rsi
  popq    %rdi
ffff8000001097fe:	5f                   	pop    %rdi
  popq    %r8
ffff8000001097ff:	41 58                	pop    %r8
  popq    %r9
ffff800000109801:	41 59                	pop    %r9
  popq    %r10
ffff800000109803:	41 5a                	pop    %r10
  popq    %r11
ffff800000109805:	41 5b                	pop    %r11
  popq    %r12
ffff800000109807:	41 5c                	pop    %r12
  popq    %r13
ffff800000109809:	41 5d                	pop    %r13
  popq    %r14
ffff80000010980b:	41 5e                	pop    %r14
  popq    %r15
ffff80000010980d:	41 5f                	pop    %r15

  addq    $40, %rsp  # discard trapnum, errorcode, rip, cs and rflags
ffff80000010980f:	48 83 c4 28          	add    $0x28,%rsp

  # to make sure we don't get any interrupts on the user stack while in
  # supervisor mode. this is actually slightly unsafe still,
  # since some interrupts are nonmaskable.
  # See https://www.felixcloutier.com/x86/sysret
  cli
ffff800000109813:	fa                   	cli
  movq    (%rsp), %rsp  # restore the user stack
ffff800000109814:	48 8b 24 24          	mov    (%rsp),%rsp
  sysretq
ffff800000109818:	48 0f 07             	sysretq

ffff80000010981b <lidt>:
{
ffff80000010981b:	55                   	push   %rbp
ffff80000010981c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010981f:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000109823:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000109827:	89 75 d4             	mov    %esi,-0x2c(%rbp)
  addr_t addr = (addr_t)p;
ffff80000010982a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010982e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  pd[0] = size-1;
ffff800000109832:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff800000109835:	83 e8 01             	sub    $0x1,%eax
ffff800000109838:	66 89 45 ee          	mov    %ax,-0x12(%rbp)
  pd[1] = addr;
ffff80000010983c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109840:	66 89 45 f0          	mov    %ax,-0x10(%rbp)
  pd[2] = addr >> 16;
ffff800000109844:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109848:	48 c1 e8 10          	shr    $0x10,%rax
ffff80000010984c:	66 89 45 f2          	mov    %ax,-0xe(%rbp)
  pd[3] = addr >> 32;
ffff800000109850:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109854:	48 c1 e8 20          	shr    $0x20,%rax
ffff800000109858:	66 89 45 f4          	mov    %ax,-0xc(%rbp)
  pd[4] = addr >> 48;
ffff80000010985c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109860:	48 c1 e8 30          	shr    $0x30,%rax
ffff800000109864:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
  asm volatile("lidt (%0)" : : "r" (pd));
ffff800000109868:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
ffff80000010986c:	0f 01 18             	lidt   (%rax)
}
ffff80000010986f:	90                   	nop
ffff800000109870:	c9                   	leave
ffff800000109871:	c3                   	ret

ffff800000109872 <rcr2>:

static inline addr_t
rcr2(void)
{
ffff800000109872:	55                   	push   %rbp
ffff800000109873:	48 89 e5             	mov    %rsp,%rbp
ffff800000109876:	48 83 ec 10          	sub    $0x10,%rsp
  addr_t val;
  asm volatile("mov %%cr2,%0" : "=r" (val));
ffff80000010987a:	0f 20 d0             	mov    %cr2,%rax
ffff80000010987d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  return val;
ffff800000109881:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000109885:	c9                   	leave
ffff800000109886:	c3                   	ret

ffff800000109887 <mkgate>:
struct spinlock tickslock;
uint ticks;

static void
mkgate(uint *idt, uint n, addr_t kva, uint pl)
{
ffff800000109887:	55                   	push   %rbp
ffff800000109888:	48 89 e5             	mov    %rsp,%rbp
ffff80000010988b:	48 83 ec 28          	sub    $0x28,%rsp
ffff80000010988f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000109893:	89 75 e4             	mov    %esi,-0x1c(%rbp)
ffff800000109896:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
ffff80000010989a:	89 4d e0             	mov    %ecx,-0x20(%rbp)
  uint64 addr = (uint64) kva;
ffff80000010989d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001098a1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  n *= 4;
ffff8000001098a5:	c1 65 e4 02          	shll   $0x2,-0x1c(%rbp)
  idt[n+0] = (addr & 0xFFFF) | (KERNEL_CS << 16);
ffff8000001098a9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001098ad:	0f b7 d0             	movzwl %ax,%edx
ffff8000001098b0:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff8000001098b3:	48 8d 0c 85 00 00 00 	lea    0x0(,%rax,4),%rcx
ffff8000001098ba:	00 
ffff8000001098bb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001098bf:	48 01 c8             	add    %rcx,%rax
ffff8000001098c2:	81 ca 00 00 08 00    	or     $0x80000,%edx
ffff8000001098c8:	89 10                	mov    %edx,(%rax)
  idt[n+1] = (addr & 0xFFFF0000) | 0x8E00 | ((pl & 3) << 13);
ffff8000001098ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001098ce:	66 b8 00 00          	mov    $0x0,%ax
ffff8000001098d2:	89 c2                	mov    %eax,%edx
ffff8000001098d4:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff8000001098d7:	c1 e0 0d             	shl    $0xd,%eax
ffff8000001098da:	25 00 60 00 00       	and    $0x6000,%eax
ffff8000001098df:	09 c2                	or     %eax,%edx
ffff8000001098e1:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff8000001098e4:	83 c0 01             	add    $0x1,%eax
ffff8000001098e7:	89 c0                	mov    %eax,%eax
ffff8000001098e9:	48 8d 0c 85 00 00 00 	lea    0x0(,%rax,4),%rcx
ffff8000001098f0:	00 
ffff8000001098f1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001098f5:	48 01 c8             	add    %rcx,%rax
ffff8000001098f8:	80 ce 8e             	or     $0x8e,%dh
ffff8000001098fb:	89 10                	mov    %edx,(%rax)
  idt[n+2] = addr >> 32;
ffff8000001098fd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109901:	48 c1 e8 20          	shr    $0x20,%rax
ffff800000109905:	48 89 c1             	mov    %rax,%rcx
ffff800000109908:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff80000010990b:	83 c0 02             	add    $0x2,%eax
ffff80000010990e:	89 c0                	mov    %eax,%eax
ffff800000109910:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff800000109917:	00 
ffff800000109918:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010991c:	48 01 d0             	add    %rdx,%rax
ffff80000010991f:	89 ca                	mov    %ecx,%edx
ffff800000109921:	89 10                	mov    %edx,(%rax)
  idt[n+3] = 0;
ffff800000109923:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff800000109926:	83 c0 03             	add    $0x3,%eax
ffff800000109929:	89 c0                	mov    %eax,%eax
ffff80000010992b:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff800000109932:	00 
ffff800000109933:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109937:	48 01 d0             	add    %rdx,%rax
ffff80000010993a:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
}
ffff800000109940:	90                   	nop
ffff800000109941:	c9                   	leave
ffff800000109942:	c3                   	ret

ffff800000109943 <idtinit>:

void idtinit(void)
{
ffff800000109943:	55                   	push   %rbp
ffff800000109944:	48 89 e5             	mov    %rsp,%rbp
  lidt((void*) idt, PGSIZE);
ffff800000109947:	48 b8 c0 c0 11 00 00 	movabs $0xffff80000011c0c0,%rax
ffff80000010994e:	80 ff ff 
ffff800000109951:	48 8b 00             	mov    (%rax),%rax
ffff800000109954:	be 00 10 00 00       	mov    $0x1000,%esi
ffff800000109959:	48 89 c7             	mov    %rax,%rdi
ffff80000010995c:	48 b8 1b 98 10 00 00 	movabs $0xffff80000010981b,%rax
ffff800000109963:	80 ff ff 
ffff800000109966:	ff d0                	call   *%rax
}
ffff800000109968:	90                   	nop
ffff800000109969:	5d                   	pop    %rbp
ffff80000010996a:	c3                   	ret

ffff80000010996b <tvinit>:

void tvinit(void)
{
ffff80000010996b:	55                   	push   %rbp
ffff80000010996c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010996f:	48 83 ec 10          	sub    $0x10,%rsp
  int n;
  idt = (uint*) kalloc();
ffff800000109973:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010997a:	80 ff ff 
ffff80000010997d:	ff d0                	call   *%rax
ffff80000010997f:	48 ba c0 c0 11 00 00 	movabs $0xffff80000011c0c0,%rdx
ffff800000109986:	80 ff ff 
ffff800000109989:	48 89 02             	mov    %rax,(%rdx)
  memset(idt, 0, PGSIZE);
ffff80000010998c:	48 b8 c0 c0 11 00 00 	movabs $0xffff80000011c0c0,%rax
ffff800000109993:	80 ff ff 
ffff800000109996:	48 8b 00             	mov    (%rax),%rax
ffff800000109999:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010999e:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001099a3:	48 89 c7             	mov    %rax,%rdi
ffff8000001099a6:	48 b8 ce 7a 10 00 00 	movabs $0xffff800000107ace,%rax
ffff8000001099ad:	80 ff ff 
ffff8000001099b0:	ff d0                	call   *%rax

  for (n = 0; n < 256; n++)
ffff8000001099b2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001099b9:	eb 3b                	jmp    ffff8000001099f6 <tvinit+0x8b>
    mkgate(idt, n, vectors[n], 0);
ffff8000001099bb:	48 ba 60 d6 10 00 00 	movabs $0xffff80000010d660,%rdx
ffff8000001099c2:	80 ff ff 
ffff8000001099c5:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001099c8:	48 98                	cltq
ffff8000001099ca:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
ffff8000001099ce:	8b 75 fc             	mov    -0x4(%rbp),%esi
ffff8000001099d1:	48 b8 c0 c0 11 00 00 	movabs $0xffff80000011c0c0,%rax
ffff8000001099d8:	80 ff ff 
ffff8000001099db:	48 8b 00             	mov    (%rax),%rax
ffff8000001099de:	b9 00 00 00 00       	mov    $0x0,%ecx
ffff8000001099e3:	48 89 c7             	mov    %rax,%rdi
ffff8000001099e6:	48 b8 87 98 10 00 00 	movabs $0xffff800000109887,%rax
ffff8000001099ed:	80 ff ff 
ffff8000001099f0:	ff d0                	call   *%rax
  for (n = 0; n < 256; n++)
ffff8000001099f2:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001099f6:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
ffff8000001099fd:	7e bc                	jle    ffff8000001099bb <tvinit+0x50>
}
ffff8000001099ff:	90                   	nop
ffff800000109a00:	90                   	nop
ffff800000109a01:	c9                   	leave
ffff800000109a02:	c3                   	ret

ffff800000109a03 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
ffff800000109a03:	55                   	push   %rbp
ffff800000109a04:	48 89 e5             	mov    %rsp,%rbp
ffff800000109a07:	41 54                	push   %r12
ffff800000109a09:	53                   	push   %rbx
ffff800000109a0a:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000109a0e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  switch(tf->trapno){
ffff800000109a12:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109a16:	48 8b 40 78          	mov    0x78(%rax),%rax
ffff800000109a1a:	48 83 f8 3f          	cmp    $0x3f,%rax
ffff800000109a1e:	0f 84 4d 01 00 00    	je     ffff800000109b71 <trap+0x16e>
ffff800000109a24:	48 83 f8 3f          	cmp    $0x3f,%rax
ffff800000109a28:	0f 87 9d 01 00 00    	ja     ffff800000109bcb <trap+0x1c8>
ffff800000109a2e:	48 83 f8 2f          	cmp    $0x2f,%rax
ffff800000109a32:	0f 84 03 03 00 00    	je     ffff800000109d3b <trap+0x338>
ffff800000109a38:	48 83 f8 2f          	cmp    $0x2f,%rax
ffff800000109a3c:	0f 87 89 01 00 00    	ja     ffff800000109bcb <trap+0x1c8>
ffff800000109a42:	48 83 f8 2e          	cmp    $0x2e,%rax
ffff800000109a46:	0f 84 ce 00 00 00    	je     ffff800000109b1a <trap+0x117>
ffff800000109a4c:	48 83 f8 2e          	cmp    $0x2e,%rax
ffff800000109a50:	0f 87 75 01 00 00    	ja     ffff800000109bcb <trap+0x1c8>
ffff800000109a56:	48 83 f8 27          	cmp    $0x27,%rax
ffff800000109a5a:	0f 84 11 01 00 00    	je     ffff800000109b71 <trap+0x16e>
ffff800000109a60:	48 83 f8 27          	cmp    $0x27,%rax
ffff800000109a64:	0f 87 61 01 00 00    	ja     ffff800000109bcb <trap+0x1c8>
ffff800000109a6a:	48 83 f8 24          	cmp    $0x24,%rax
ffff800000109a6e:	0f 84 e0 00 00 00    	je     ffff800000109b54 <trap+0x151>
ffff800000109a74:	48 83 f8 24          	cmp    $0x24,%rax
ffff800000109a78:	0f 87 4d 01 00 00    	ja     ffff800000109bcb <trap+0x1c8>
ffff800000109a7e:	48 83 f8 20          	cmp    $0x20,%rax
ffff800000109a82:	74 0f                	je     ffff800000109a93 <trap+0x90>
ffff800000109a84:	48 83 f8 21          	cmp    $0x21,%rax
ffff800000109a88:	0f 84 a9 00 00 00    	je     ffff800000109b37 <trap+0x134>
ffff800000109a8e:	e9 38 01 00 00       	jmp    ffff800000109bcb <trap+0x1c8>
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
ffff800000109a93:	48 b8 88 46 10 00 00 	movabs $0xffff800000104688,%rax
ffff800000109a9a:	80 ff ff 
ffff800000109a9d:	ff d0                	call   *%rax
ffff800000109a9f:	85 c0                	test   %eax,%eax
ffff800000109aa1:	75 66                	jne    ffff800000109b09 <trap+0x106>
      acquire(&tickslock);
ffff800000109aa3:	48 b8 e0 c0 11 00 00 	movabs $0xffff80000011c0e0,%rax
ffff800000109aaa:	80 ff ff 
ffff800000109aad:	48 89 c7             	mov    %rax,%rdi
ffff800000109ab0:	48 b8 3a 77 10 00 00 	movabs $0xffff80000010773a,%rax
ffff800000109ab7:	80 ff ff 
ffff800000109aba:	ff d0                	call   *%rax
      ticks++;
ffff800000109abc:	48 b8 48 c1 11 00 00 	movabs $0xffff80000011c148,%rax
ffff800000109ac3:	80 ff ff 
ffff800000109ac6:	8b 00                	mov    (%rax),%eax
ffff800000109ac8:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000109acb:	48 b8 48 c1 11 00 00 	movabs $0xffff80000011c148,%rax
ffff800000109ad2:	80 ff ff 
ffff800000109ad5:	89 10                	mov    %edx,(%rax)
      wakeup(&ticks);
ffff800000109ad7:	48 b8 48 c1 11 00 00 	movabs $0xffff80000011c148,%rax
ffff800000109ade:	80 ff ff 
ffff800000109ae1:	48 89 c7             	mov    %rax,%rdi
ffff800000109ae4:	48 b8 c6 6f 10 00 00 	movabs $0xffff800000106fc6,%rax
ffff800000109aeb:	80 ff ff 
ffff800000109aee:	ff d0                	call   *%rax
      release(&tickslock);
ffff800000109af0:	48 b8 e0 c0 11 00 00 	movabs $0xffff80000011c0e0,%rax
ffff800000109af7:	80 ff ff 
ffff800000109afa:	48 89 c7             	mov    %rax,%rdi
ffff800000109afd:	48 b8 d9 77 10 00 00 	movabs $0xffff8000001077d9,%rax
ffff800000109b04:	80 ff ff 
ffff800000109b07:	ff d0                	call   *%rax
    }
    lapiceoi();
ffff800000109b09:	48 b8 90 47 10 00 00 	movabs $0xffff800000104790,%rax
ffff800000109b10:	80 ff ff 
ffff800000109b13:	ff d0                	call   *%rax
    break;
ffff800000109b15:	e9 22 02 00 00       	jmp    ffff800000109d3c <trap+0x339>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
ffff800000109b1a:	48 b8 89 3b 10 00 00 	movabs $0xffff800000103b89,%rax
ffff800000109b21:	80 ff ff 
ffff800000109b24:	ff d0                	call   *%rax
    lapiceoi();
ffff800000109b26:	48 b8 90 47 10 00 00 	movabs $0xffff800000104790,%rax
ffff800000109b2d:	80 ff ff 
ffff800000109b30:	ff d0                	call   *%rax
    break;
ffff800000109b32:	e9 05 02 00 00       	jmp    ffff800000109d3c <trap+0x339>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
ffff800000109b37:	48 b8 46 44 10 00 00 	movabs $0xffff800000104446,%rax
ffff800000109b3e:	80 ff ff 
ffff800000109b41:	ff d0                	call   *%rax
    lapiceoi();
ffff800000109b43:	48 b8 90 47 10 00 00 	movabs $0xffff800000104790,%rax
ffff800000109b4a:	80 ff ff 
ffff800000109b4d:	ff d0                	call   *%rax
    break;
ffff800000109b4f:	e9 e8 01 00 00       	jmp    ffff800000109d3c <trap+0x339>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
ffff800000109b54:	48 b8 64 a0 10 00 00 	movabs $0xffff80000010a064,%rax
ffff800000109b5b:	80 ff ff 
ffff800000109b5e:	ff d0                	call   *%rax
    lapiceoi();
ffff800000109b60:	48 b8 90 47 10 00 00 	movabs $0xffff800000104790,%rax
ffff800000109b67:	80 ff ff 
ffff800000109b6a:	ff d0                	call   *%rax
    break;
ffff800000109b6c:	e9 cb 01 00 00       	jmp    ffff800000109d3c <trap+0x339>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %p:%p\n",
ffff800000109b71:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109b75:	4c 8b a0 88 00 00 00 	mov    0x88(%rax),%r12
ffff800000109b7c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109b80:	48 8b 98 90 00 00 00 	mov    0x90(%rax),%rbx
ffff800000109b87:	48 b8 88 46 10 00 00 	movabs $0xffff800000104688,%rax
ffff800000109b8e:	80 ff ff 
ffff800000109b91:	ff d0                	call   *%rax
ffff800000109b93:	89 c6                	mov    %eax,%esi
ffff800000109b95:	48 b8 28 c5 10 00 00 	movabs $0xffff80000010c528,%rax
ffff800000109b9c:	80 ff ff 
ffff800000109b9f:	4c 89 e1             	mov    %r12,%rcx
ffff800000109ba2:	48 89 da             	mov    %rbx,%rdx
ffff800000109ba5:	48 89 c7             	mov    %rax,%rdi
ffff800000109ba8:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109bad:	49 b8 04 08 10 00 00 	movabs $0xffff800000100804,%r8
ffff800000109bb4:	80 ff ff 
ffff800000109bb7:	41 ff d0             	call   *%r8
            cpunum(), tf->cs, tf->rip);
    lapiceoi();
ffff800000109bba:	48 b8 90 47 10 00 00 	movabs $0xffff800000104790,%rax
ffff800000109bc1:	80 ff ff 
ffff800000109bc4:	ff d0                	call   *%rax
    break;
ffff800000109bc6:	e9 71 01 00 00       	jmp    ffff800000109d3c <trap+0x339>

  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
ffff800000109bcb:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109bd2:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109bd6:	48 85 c0             	test   %rax,%rax
ffff800000109bd9:	74 17                	je     ffff800000109bf2 <trap+0x1ef>
ffff800000109bdb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109bdf:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
ffff800000109be6:	83 e0 03             	and    $0x3,%eax
ffff800000109be9:	48 85 c0             	test   %rax,%rax
ffff800000109bec:	0f 85 ac 00 00 00    	jne    ffff800000109c9e <trap+0x29b>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d rip %p (cr2=0x%p)\n",
ffff800000109bf2:	48 b8 72 98 10 00 00 	movabs $0xffff800000109872,%rax
ffff800000109bf9:	80 ff ff 
ffff800000109bfc:	ff d0                	call   *%rax
ffff800000109bfe:	49 89 c4             	mov    %rax,%r12
ffff800000109c01:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109c05:	48 8b 98 88 00 00 00 	mov    0x88(%rax),%rbx
ffff800000109c0c:	48 b8 88 46 10 00 00 	movabs $0xffff800000104688,%rax
ffff800000109c13:	80 ff ff 
ffff800000109c16:	ff d0                	call   *%rax
ffff800000109c18:	89 c2                	mov    %eax,%edx
ffff800000109c1a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109c1e:	48 8b 40 78          	mov    0x78(%rax),%rax
ffff800000109c22:	48 bf 50 c5 10 00 00 	movabs $0xffff80000010c550,%rdi
ffff800000109c29:	80 ff ff 
ffff800000109c2c:	4d 89 e0             	mov    %r12,%r8
ffff800000109c2f:	48 89 d9             	mov    %rbx,%rcx
ffff800000109c32:	48 89 c6             	mov    %rax,%rsi
ffff800000109c35:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109c3a:	49 b9 04 08 10 00 00 	movabs $0xffff800000100804,%r9
ffff800000109c41:	80 ff ff 
ffff800000109c44:	41 ff d1             	call   *%r9
              tf->trapno, cpunum(), tf->rip, rcr2());
      if (proc)
ffff800000109c47:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109c4e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109c52:	48 85 c0             	test   %rax,%rax
ffff800000109c55:	74 2e                	je     ffff800000109c85 <trap+0x282>
        cprintf("proc id: %d\n", proc->pid);
ffff800000109c57:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109c5e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109c62:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff800000109c65:	48 ba 82 c5 10 00 00 	movabs $0xffff80000010c582,%rdx
ffff800000109c6c:	80 ff ff 
ffff800000109c6f:	89 c6                	mov    %eax,%esi
ffff800000109c71:	48 89 d7             	mov    %rdx,%rdi
ffff800000109c74:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109c79:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000109c80:	80 ff ff 
ffff800000109c83:	ff d2                	call   *%rdx
      panic("trap");
ffff800000109c85:	48 b8 8f c5 10 00 00 	movabs $0xffff80000010c58f,%rax
ffff800000109c8c:	80 ff ff 
ffff800000109c8f:	48 89 c7             	mov    %rax,%rdi
ffff800000109c92:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000109c99:	80 ff ff 
ffff800000109c9c:	ff d0                	call   *%rax
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
ffff800000109c9e:	48 b8 72 98 10 00 00 	movabs $0xffff800000109872,%rax
ffff800000109ca5:	80 ff ff 
ffff800000109ca8:	ff d0                	call   *%rax
ffff800000109caa:	48 89 c3             	mov    %rax,%rbx
ffff800000109cad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109cb1:	4c 8b a0 88 00 00 00 	mov    0x88(%rax),%r12
ffff800000109cb8:	48 b8 88 46 10 00 00 	movabs $0xffff800000104688,%rax
ffff800000109cbf:	80 ff ff 
ffff800000109cc2:	ff d0                	call   *%rax
ffff800000109cc4:	89 c1                	mov    %eax,%ecx
ffff800000109cc6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109cca:	4c 8b 80 80 00 00 00 	mov    0x80(%rax),%r8
ffff800000109cd1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109cd5:	48 8b 50 78          	mov    0x78(%rax),%rdx
            "rip 0x%p addr 0x%p--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->rip,
ffff800000109cd9:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109ce0:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109ce4:	48 8d b0 d0 00 00 00 	lea    0xd0(%rax),%rsi
ffff800000109ceb:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109cf2:	64 48 8b 00          	mov    %fs:(%rax),%rax
    cprintf("pid %d %s: trap %d err %d on cpu %d "
ffff800000109cf6:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff800000109cf9:	48 bf 98 c5 10 00 00 	movabs $0xffff80000010c598,%rdi
ffff800000109d00:	80 ff ff 
ffff800000109d03:	53                   	push   %rbx
ffff800000109d04:	41 54                	push   %r12
ffff800000109d06:	41 89 c9             	mov    %ecx,%r9d
ffff800000109d09:	48 89 d1             	mov    %rdx,%rcx
ffff800000109d0c:	48 89 f2             	mov    %rsi,%rdx
ffff800000109d0f:	89 c6                	mov    %eax,%esi
ffff800000109d11:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109d16:	49 ba 04 08 10 00 00 	movabs $0xffff800000100804,%r10
ffff800000109d1d:	80 ff ff 
ffff800000109d20:	41 ff d2             	call   *%r10
ffff800000109d23:	48 83 c4 10          	add    $0x10,%rsp
            rcr2());
    proc->killed = 1;
ffff800000109d27:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109d2e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109d32:	c7 40 40 01 00 00 00 	movl   $0x1,0x40(%rax)
ffff800000109d39:	eb 01                	jmp    ffff800000109d3c <trap+0x339>
    break;
ffff800000109d3b:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
ffff800000109d3c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109d43:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109d47:	48 85 c0             	test   %rax,%rax
ffff800000109d4a:	74 32                	je     ffff800000109d7e <trap+0x37b>
ffff800000109d4c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109d53:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109d57:	8b 40 40             	mov    0x40(%rax),%eax
ffff800000109d5a:	85 c0                	test   %eax,%eax
ffff800000109d5c:	74 20                	je     ffff800000109d7e <trap+0x37b>
ffff800000109d5e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109d62:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
ffff800000109d69:	83 e0 03             	and    $0x3,%eax
ffff800000109d6c:	48 83 f8 03          	cmp    $0x3,%rax
ffff800000109d70:	75 0c                	jne    ffff800000109d7e <trap+0x37b>
    exit();
ffff800000109d72:	48 b8 cc 67 10 00 00 	movabs $0xffff8000001067cc,%rax
ffff800000109d79:	80 ff ff 
ffff800000109d7c:	ff d0                	call   *%rax

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
ffff800000109d7e:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109d85:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109d89:	48 85 c0             	test   %rax,%rax
ffff800000109d8c:	74 2d                	je     ffff800000109dbb <trap+0x3b8>
ffff800000109d8e:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109d95:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109d99:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000109d9c:	83 f8 04             	cmp    $0x4,%eax
ffff800000109d9f:	75 1a                	jne    ffff800000109dbb <trap+0x3b8>
ffff800000109da1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109da5:	48 8b 40 78          	mov    0x78(%rax),%rax
ffff800000109da9:	48 83 f8 20          	cmp    $0x20,%rax
ffff800000109dad:	75 0c                	jne    ffff800000109dbb <trap+0x3b8>
    yield();
ffff800000109daf:	48 b8 98 6d 10 00 00 	movabs $0xffff800000106d98,%rax
ffff800000109db6:	80 ff ff 
ffff800000109db9:	ff d0                	call   *%rax

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
ffff800000109dbb:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109dc2:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109dc6:	48 85 c0             	test   %rax,%rax
ffff800000109dc9:	74 32                	je     ffff800000109dfd <trap+0x3fa>
ffff800000109dcb:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109dd2:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109dd6:	8b 40 40             	mov    0x40(%rax),%eax
ffff800000109dd9:	85 c0                	test   %eax,%eax
ffff800000109ddb:	74 20                	je     ffff800000109dfd <trap+0x3fa>
ffff800000109ddd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109de1:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
ffff800000109de8:	83 e0 03             	and    $0x3,%eax
ffff800000109deb:	48 83 f8 03          	cmp    $0x3,%rax
ffff800000109def:	75 0c                	jne    ffff800000109dfd <trap+0x3fa>
    exit();
ffff800000109df1:	48 b8 cc 67 10 00 00 	movabs $0xffff8000001067cc,%rax
ffff800000109df8:	80 ff ff 
ffff800000109dfb:	ff d0                	call   *%rax
}
ffff800000109dfd:	90                   	nop
ffff800000109dfe:	48 8d 65 f0          	lea    -0x10(%rbp),%rsp
ffff800000109e02:	5b                   	pop    %rbx
ffff800000109e03:	41 5c                	pop    %r12
ffff800000109e05:	5d                   	pop    %rbp
ffff800000109e06:	c3                   	ret

ffff800000109e07 <inb>:
{
ffff800000109e07:	55                   	push   %rbp
ffff800000109e08:	48 89 e5             	mov    %rsp,%rbp
ffff800000109e0b:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000109e0f:	89 f8                	mov    %edi,%eax
ffff800000109e11:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
ffff800000109e15:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff800000109e19:	89 c2                	mov    %eax,%edx
ffff800000109e1b:	ec                   	in     (%dx),%al
ffff800000109e1c:	88 45 ff             	mov    %al,-0x1(%rbp)
  return data;
ffff800000109e1f:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
}
ffff800000109e23:	c9                   	leave
ffff800000109e24:	c3                   	ret

ffff800000109e25 <outb>:
{
ffff800000109e25:	55                   	push   %rbp
ffff800000109e26:	48 89 e5             	mov    %rsp,%rbp
ffff800000109e29:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000109e2d:	89 fa                	mov    %edi,%edx
ffff800000109e2f:	89 f0                	mov    %esi,%eax
ffff800000109e31:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffff800000109e35:	88 45 f8             	mov    %al,-0x8(%rbp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
ffff800000109e38:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffff800000109e3c:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffff800000109e40:	ee                   	out    %al,(%dx)
}
ffff800000109e41:	90                   	nop
ffff800000109e42:	c9                   	leave
ffff800000109e43:	c3                   	ret

ffff800000109e44 <uartearlyinit>:

static int uart;    // is there a uart?

void
uartearlyinit(void)
{
ffff800000109e44:	55                   	push   %rbp
ffff800000109e45:	48 89 e5             	mov    %rsp,%rbp
ffff800000109e48:	48 83 ec 10          	sub    $0x10,%rsp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
ffff800000109e4c:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000109e51:	bf fa 03 00 00       	mov    $0x3fa,%edi
ffff800000109e56:	48 b8 25 9e 10 00 00 	movabs $0xffff800000109e25,%rax
ffff800000109e5d:	80 ff ff 
ffff800000109e60:	ff d0                	call   *%rax

  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
ffff800000109e62:	be 80 00 00 00       	mov    $0x80,%esi
ffff800000109e67:	bf fb 03 00 00       	mov    $0x3fb,%edi
ffff800000109e6c:	48 b8 25 9e 10 00 00 	movabs $0xffff800000109e25,%rax
ffff800000109e73:	80 ff ff 
ffff800000109e76:	ff d0                	call   *%rax
  outb(COM1+0, 115200/9600);
ffff800000109e78:	be 0c 00 00 00       	mov    $0xc,%esi
ffff800000109e7d:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffff800000109e82:	48 b8 25 9e 10 00 00 	movabs $0xffff800000109e25,%rax
ffff800000109e89:	80 ff ff 
ffff800000109e8c:	ff d0                	call   *%rax
  outb(COM1+1, 0);
ffff800000109e8e:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000109e93:	bf f9 03 00 00       	mov    $0x3f9,%edi
ffff800000109e98:	48 b8 25 9e 10 00 00 	movabs $0xffff800000109e25,%rax
ffff800000109e9f:	80 ff ff 
ffff800000109ea2:	ff d0                	call   *%rax
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
ffff800000109ea4:	be 03 00 00 00       	mov    $0x3,%esi
ffff800000109ea9:	bf fb 03 00 00       	mov    $0x3fb,%edi
ffff800000109eae:	48 b8 25 9e 10 00 00 	movabs $0xffff800000109e25,%rax
ffff800000109eb5:	80 ff ff 
ffff800000109eb8:	ff d0                	call   *%rax
  outb(COM1+4, 0);
ffff800000109eba:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000109ebf:	bf fc 03 00 00       	mov    $0x3fc,%edi
ffff800000109ec4:	48 b8 25 9e 10 00 00 	movabs $0xffff800000109e25,%rax
ffff800000109ecb:	80 ff ff 
ffff800000109ece:	ff d0                	call   *%rax
  outb(COM1+1, 0x01);    // Enable receive interrupts.
ffff800000109ed0:	be 01 00 00 00       	mov    $0x1,%esi
ffff800000109ed5:	bf f9 03 00 00       	mov    $0x3f9,%edi
ffff800000109eda:	48 b8 25 9e 10 00 00 	movabs $0xffff800000109e25,%rax
ffff800000109ee1:	80 ff ff 
ffff800000109ee4:	ff d0                	call   *%rax

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
ffff800000109ee6:	bf fd 03 00 00       	mov    $0x3fd,%edi
ffff800000109eeb:	48 b8 07 9e 10 00 00 	movabs $0xffff800000109e07,%rax
ffff800000109ef2:	80 ff ff 
ffff800000109ef5:	ff d0                	call   *%rax
ffff800000109ef7:	3c ff                	cmp    $0xff,%al
ffff800000109ef9:	74 4a                	je     ffff800000109f45 <uartearlyinit+0x101>
    return;
  uart = 1;
ffff800000109efb:	48 b8 4c c1 11 00 00 	movabs $0xffff80000011c14c,%rax
ffff800000109f02:	80 ff ff 
ffff800000109f05:	c7 00 01 00 00 00    	movl   $0x1,(%rax)



  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
ffff800000109f0b:	48 b8 db c5 10 00 00 	movabs $0xffff80000010c5db,%rax
ffff800000109f12:	80 ff ff 
ffff800000109f15:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000109f19:	eb 1d                	jmp    ffff800000109f38 <uartearlyinit+0xf4>
    uartputc(*p);
ffff800000109f1b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109f1f:	0f b6 00             	movzbl (%rax),%eax
ffff800000109f22:	0f be c0             	movsbl %al,%eax
ffff800000109f25:	89 c7                	mov    %eax,%edi
ffff800000109f27:	48 b8 99 9f 10 00 00 	movabs $0xffff800000109f99,%rax
ffff800000109f2e:	80 ff ff 
ffff800000109f31:	ff d0                	call   *%rax
  for(p="xv6...\n"; *p; p++)
ffff800000109f33:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffff800000109f38:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109f3c:	0f b6 00             	movzbl (%rax),%eax
ffff800000109f3f:	84 c0                	test   %al,%al
ffff800000109f41:	75 d8                	jne    ffff800000109f1b <uartearlyinit+0xd7>
ffff800000109f43:	eb 01                	jmp    ffff800000109f46 <uartearlyinit+0x102>
    return;
ffff800000109f45:	90                   	nop
}
ffff800000109f46:	c9                   	leave
ffff800000109f47:	c3                   	ret

ffff800000109f48 <uartinit>:

void
uartinit(void)
{
ffff800000109f48:	55                   	push   %rbp
ffff800000109f49:	48 89 e5             	mov    %rsp,%rbp
  if(!uart)
ffff800000109f4c:	48 b8 4c c1 11 00 00 	movabs $0xffff80000011c14c,%rax
ffff800000109f53:	80 ff ff 
ffff800000109f56:	8b 00                	mov    (%rax),%eax
ffff800000109f58:	85 c0                	test   %eax,%eax
ffff800000109f5a:	74 3a                	je     ffff800000109f96 <uartinit+0x4e>
    return;

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
ffff800000109f5c:	bf fa 03 00 00       	mov    $0x3fa,%edi
ffff800000109f61:	48 b8 07 9e 10 00 00 	movabs $0xffff800000109e07,%rax
ffff800000109f68:	80 ff ff 
ffff800000109f6b:	ff d0                	call   *%rax
  inb(COM1+0);
ffff800000109f6d:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffff800000109f72:	48 b8 07 9e 10 00 00 	movabs $0xffff800000109e07,%rax
ffff800000109f79:	80 ff ff 
ffff800000109f7c:	ff d0                	call   *%rax
  ioapicenable(IRQ_COM1, 0);
ffff800000109f7e:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000109f83:	bf 04 00 00 00       	mov    $0x4,%edi
ffff800000109f88:	48 b8 6e 3f 10 00 00 	movabs $0xffff800000103f6e,%rax
ffff800000109f8f:	80 ff ff 
ffff800000109f92:	ff d0                	call   *%rax
ffff800000109f94:	eb 01                	jmp    ffff800000109f97 <uartinit+0x4f>
    return;
ffff800000109f96:	90                   	nop

}
ffff800000109f97:	5d                   	pop    %rbp
ffff800000109f98:	c3                   	ret

ffff800000109f99 <uartputc>:
void
uartputc(int c)
{
ffff800000109f99:	55                   	push   %rbp
ffff800000109f9a:	48 89 e5             	mov    %rsp,%rbp
ffff800000109f9d:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000109fa1:	89 7d ec             	mov    %edi,-0x14(%rbp)
  int i;

  if(!uart)
ffff800000109fa4:	48 b8 4c c1 11 00 00 	movabs $0xffff80000011c14c,%rax
ffff800000109fab:	80 ff ff 
ffff800000109fae:	8b 00                	mov    (%rax),%eax
ffff800000109fb0:	85 c0                	test   %eax,%eax
ffff800000109fb2:	74 5a                	je     ffff80000010a00e <uartputc+0x75>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
ffff800000109fb4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000109fbb:	eb 15                	jmp    ffff800000109fd2 <uartputc+0x39>
    microdelay(10);
ffff800000109fbd:	bf 0a 00 00 00       	mov    $0xa,%edi
ffff800000109fc2:	48 b8 bf 47 10 00 00 	movabs $0xffff8000001047bf,%rax
ffff800000109fc9:	80 ff ff 
ffff800000109fcc:	ff d0                	call   *%rax
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
ffff800000109fce:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000109fd2:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
ffff800000109fd6:	7f 1b                	jg     ffff800000109ff3 <uartputc+0x5a>
ffff800000109fd8:	bf fd 03 00 00       	mov    $0x3fd,%edi
ffff800000109fdd:	48 b8 07 9e 10 00 00 	movabs $0xffff800000109e07,%rax
ffff800000109fe4:	80 ff ff 
ffff800000109fe7:	ff d0                	call   *%rax
ffff800000109fe9:	0f b6 c0             	movzbl %al,%eax
ffff800000109fec:	83 e0 20             	and    $0x20,%eax
ffff800000109fef:	85 c0                	test   %eax,%eax
ffff800000109ff1:	74 ca                	je     ffff800000109fbd <uartputc+0x24>
  outb(COM1+0, c);
ffff800000109ff3:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000109ff6:	0f b6 c0             	movzbl %al,%eax
ffff800000109ff9:	89 c6                	mov    %eax,%esi
ffff800000109ffb:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffff80000010a000:	48 b8 25 9e 10 00 00 	movabs $0xffff800000109e25,%rax
ffff80000010a007:	80 ff ff 
ffff80000010a00a:	ff d0                	call   *%rax
ffff80000010a00c:	eb 01                	jmp    ffff80000010a00f <uartputc+0x76>
    return;
ffff80000010a00e:	90                   	nop
}
ffff80000010a00f:	c9                   	leave
ffff80000010a010:	c3                   	ret

ffff80000010a011 <uartgetc>:

static int
uartgetc(void)
{
ffff80000010a011:	55                   	push   %rbp
ffff80000010a012:	48 89 e5             	mov    %rsp,%rbp
  if(!uart)
ffff80000010a015:	48 b8 4c c1 11 00 00 	movabs $0xffff80000011c14c,%rax
ffff80000010a01c:	80 ff ff 
ffff80000010a01f:	8b 00                	mov    (%rax),%eax
ffff80000010a021:	85 c0                	test   %eax,%eax
ffff80000010a023:	75 07                	jne    ffff80000010a02c <uartgetc+0x1b>
    return -1;
ffff80000010a025:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010a02a:	eb 36                	jmp    ffff80000010a062 <uartgetc+0x51>
  if(!(inb(COM1+5) & 0x01))
ffff80000010a02c:	bf fd 03 00 00       	mov    $0x3fd,%edi
ffff80000010a031:	48 b8 07 9e 10 00 00 	movabs $0xffff800000109e07,%rax
ffff80000010a038:	80 ff ff 
ffff80000010a03b:	ff d0                	call   *%rax
ffff80000010a03d:	0f b6 c0             	movzbl %al,%eax
ffff80000010a040:	83 e0 01             	and    $0x1,%eax
ffff80000010a043:	85 c0                	test   %eax,%eax
ffff80000010a045:	75 07                	jne    ffff80000010a04e <uartgetc+0x3d>
    return -1;
ffff80000010a047:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010a04c:	eb 14                	jmp    ffff80000010a062 <uartgetc+0x51>
  return inb(COM1+0);
ffff80000010a04e:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffff80000010a053:	48 b8 07 9e 10 00 00 	movabs $0xffff800000109e07,%rax
ffff80000010a05a:	80 ff ff 
ffff80000010a05d:	ff d0                	call   *%rax
ffff80000010a05f:	0f b6 c0             	movzbl %al,%eax
}
ffff80000010a062:	5d                   	pop    %rbp
ffff80000010a063:	c3                   	ret

ffff80000010a064 <uartintr>:

void
uartintr(void)
{
ffff80000010a064:	55                   	push   %rbp
ffff80000010a065:	48 89 e5             	mov    %rsp,%rbp
  consoleintr(uartgetc);
ffff80000010a068:	48 b8 11 a0 10 00 00 	movabs $0xffff80000010a011,%rax
ffff80000010a06f:	80 ff ff 
ffff80000010a072:	48 89 c7             	mov    %rax,%rdi
ffff80000010a075:	48 b8 6f 0f 10 00 00 	movabs $0xffff800000100f6f,%rax
ffff80000010a07c:	80 ff ff 
ffff80000010a07f:	ff d0                	call   *%rax
}
ffff80000010a081:	90                   	nop
ffff80000010a082:	5d                   	pop    %rbp
ffff80000010a083:	c3                   	ret

ffff80000010a084 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.global alltraps
vector0:
  push $0
ffff80000010a084:	6a 00                	push   $0x0
  push $0
ffff80000010a086:	6a 00                	push   $0x0
  jmp alltraps
ffff80000010a088:	e9 dc f6 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a08d <vector1>:
vector1:
  push $0
ffff80000010a08d:	6a 00                	push   $0x0
  push $1
ffff80000010a08f:	6a 01                	push   $0x1
  jmp alltraps
ffff80000010a091:	e9 d3 f6 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a096 <vector2>:
vector2:
  push $0
ffff80000010a096:	6a 00                	push   $0x0
  push $2
ffff80000010a098:	6a 02                	push   $0x2
  jmp alltraps
ffff80000010a09a:	e9 ca f6 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a09f <vector3>:
vector3:
  push $0
ffff80000010a09f:	6a 00                	push   $0x0
  push $3
ffff80000010a0a1:	6a 03                	push   $0x3
  jmp alltraps
ffff80000010a0a3:	e9 c1 f6 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a0a8 <vector4>:
vector4:
  push $0
ffff80000010a0a8:	6a 00                	push   $0x0
  push $4
ffff80000010a0aa:	6a 04                	push   $0x4
  jmp alltraps
ffff80000010a0ac:	e9 b8 f6 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a0b1 <vector5>:
vector5:
  push $0
ffff80000010a0b1:	6a 00                	push   $0x0
  push $5
ffff80000010a0b3:	6a 05                	push   $0x5
  jmp alltraps
ffff80000010a0b5:	e9 af f6 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a0ba <vector6>:
vector6:
  push $0
ffff80000010a0ba:	6a 00                	push   $0x0
  push $6
ffff80000010a0bc:	6a 06                	push   $0x6
  jmp alltraps
ffff80000010a0be:	e9 a6 f6 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a0c3 <vector7>:
vector7:
  push $0
ffff80000010a0c3:	6a 00                	push   $0x0
  push $7
ffff80000010a0c5:	6a 07                	push   $0x7
  jmp alltraps
ffff80000010a0c7:	e9 9d f6 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a0cc <vector8>:
vector8:
  push $8
ffff80000010a0cc:	6a 08                	push   $0x8
  jmp alltraps
ffff80000010a0ce:	e9 96 f6 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a0d3 <vector9>:
vector9:
  push $0
ffff80000010a0d3:	6a 00                	push   $0x0
  push $9
ffff80000010a0d5:	6a 09                	push   $0x9
  jmp alltraps
ffff80000010a0d7:	e9 8d f6 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a0dc <vector10>:
vector10:
  push $10
ffff80000010a0dc:	6a 0a                	push   $0xa
  jmp alltraps
ffff80000010a0de:	e9 86 f6 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a0e3 <vector11>:
vector11:
  push $11
ffff80000010a0e3:	6a 0b                	push   $0xb
  jmp alltraps
ffff80000010a0e5:	e9 7f f6 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a0ea <vector12>:
vector12:
  push $12
ffff80000010a0ea:	6a 0c                	push   $0xc
  jmp alltraps
ffff80000010a0ec:	e9 78 f6 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a0f1 <vector13>:
vector13:
  push $13
ffff80000010a0f1:	6a 0d                	push   $0xd
  jmp alltraps
ffff80000010a0f3:	e9 71 f6 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a0f8 <vector14>:
vector14:
  push $14
ffff80000010a0f8:	6a 0e                	push   $0xe
  jmp alltraps
ffff80000010a0fa:	e9 6a f6 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a0ff <vector15>:
vector15:
  push $0
ffff80000010a0ff:	6a 00                	push   $0x0
  push $15
ffff80000010a101:	6a 0f                	push   $0xf
  jmp alltraps
ffff80000010a103:	e9 61 f6 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a108 <vector16>:
vector16:
  push $0
ffff80000010a108:	6a 00                	push   $0x0
  push $16
ffff80000010a10a:	6a 10                	push   $0x10
  jmp alltraps
ffff80000010a10c:	e9 58 f6 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a111 <vector17>:
vector17:
  push $17
ffff80000010a111:	6a 11                	push   $0x11
  jmp alltraps
ffff80000010a113:	e9 51 f6 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a118 <vector18>:
vector18:
  push $0
ffff80000010a118:	6a 00                	push   $0x0
  push $18
ffff80000010a11a:	6a 12                	push   $0x12
  jmp alltraps
ffff80000010a11c:	e9 48 f6 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a121 <vector19>:
vector19:
  push $0
ffff80000010a121:	6a 00                	push   $0x0
  push $19
ffff80000010a123:	6a 13                	push   $0x13
  jmp alltraps
ffff80000010a125:	e9 3f f6 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a12a <vector20>:
vector20:
  push $0
ffff80000010a12a:	6a 00                	push   $0x0
  push $20
ffff80000010a12c:	6a 14                	push   $0x14
  jmp alltraps
ffff80000010a12e:	e9 36 f6 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a133 <vector21>:
vector21:
  push $0
ffff80000010a133:	6a 00                	push   $0x0
  push $21
ffff80000010a135:	6a 15                	push   $0x15
  jmp alltraps
ffff80000010a137:	e9 2d f6 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a13c <vector22>:
vector22:
  push $0
ffff80000010a13c:	6a 00                	push   $0x0
  push $22
ffff80000010a13e:	6a 16                	push   $0x16
  jmp alltraps
ffff80000010a140:	e9 24 f6 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a145 <vector23>:
vector23:
  push $0
ffff80000010a145:	6a 00                	push   $0x0
  push $23
ffff80000010a147:	6a 17                	push   $0x17
  jmp alltraps
ffff80000010a149:	e9 1b f6 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a14e <vector24>:
vector24:
  push $0
ffff80000010a14e:	6a 00                	push   $0x0
  push $24
ffff80000010a150:	6a 18                	push   $0x18
  jmp alltraps
ffff80000010a152:	e9 12 f6 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a157 <vector25>:
vector25:
  push $0
ffff80000010a157:	6a 00                	push   $0x0
  push $25
ffff80000010a159:	6a 19                	push   $0x19
  jmp alltraps
ffff80000010a15b:	e9 09 f6 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a160 <vector26>:
vector26:
  push $0
ffff80000010a160:	6a 00                	push   $0x0
  push $26
ffff80000010a162:	6a 1a                	push   $0x1a
  jmp alltraps
ffff80000010a164:	e9 00 f6 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a169 <vector27>:
vector27:
  push $0
ffff80000010a169:	6a 00                	push   $0x0
  push $27
ffff80000010a16b:	6a 1b                	push   $0x1b
  jmp alltraps
ffff80000010a16d:	e9 f7 f5 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a172 <vector28>:
vector28:
  push $0
ffff80000010a172:	6a 00                	push   $0x0
  push $28
ffff80000010a174:	6a 1c                	push   $0x1c
  jmp alltraps
ffff80000010a176:	e9 ee f5 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a17b <vector29>:
vector29:
  push $0
ffff80000010a17b:	6a 00                	push   $0x0
  push $29
ffff80000010a17d:	6a 1d                	push   $0x1d
  jmp alltraps
ffff80000010a17f:	e9 e5 f5 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a184 <vector30>:
vector30:
  push $0
ffff80000010a184:	6a 00                	push   $0x0
  push $30
ffff80000010a186:	6a 1e                	push   $0x1e
  jmp alltraps
ffff80000010a188:	e9 dc f5 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a18d <vector31>:
vector31:
  push $0
ffff80000010a18d:	6a 00                	push   $0x0
  push $31
ffff80000010a18f:	6a 1f                	push   $0x1f
  jmp alltraps
ffff80000010a191:	e9 d3 f5 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a196 <vector32>:
vector32:
  push $0
ffff80000010a196:	6a 00                	push   $0x0
  push $32
ffff80000010a198:	6a 20                	push   $0x20
  jmp alltraps
ffff80000010a19a:	e9 ca f5 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a19f <vector33>:
vector33:
  push $0
ffff80000010a19f:	6a 00                	push   $0x0
  push $33
ffff80000010a1a1:	6a 21                	push   $0x21
  jmp alltraps
ffff80000010a1a3:	e9 c1 f5 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a1a8 <vector34>:
vector34:
  push $0
ffff80000010a1a8:	6a 00                	push   $0x0
  push $34
ffff80000010a1aa:	6a 22                	push   $0x22
  jmp alltraps
ffff80000010a1ac:	e9 b8 f5 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a1b1 <vector35>:
vector35:
  push $0
ffff80000010a1b1:	6a 00                	push   $0x0
  push $35
ffff80000010a1b3:	6a 23                	push   $0x23
  jmp alltraps
ffff80000010a1b5:	e9 af f5 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a1ba <vector36>:
vector36:
  push $0
ffff80000010a1ba:	6a 00                	push   $0x0
  push $36
ffff80000010a1bc:	6a 24                	push   $0x24
  jmp alltraps
ffff80000010a1be:	e9 a6 f5 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a1c3 <vector37>:
vector37:
  push $0
ffff80000010a1c3:	6a 00                	push   $0x0
  push $37
ffff80000010a1c5:	6a 25                	push   $0x25
  jmp alltraps
ffff80000010a1c7:	e9 9d f5 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a1cc <vector38>:
vector38:
  push $0
ffff80000010a1cc:	6a 00                	push   $0x0
  push $38
ffff80000010a1ce:	6a 26                	push   $0x26
  jmp alltraps
ffff80000010a1d0:	e9 94 f5 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a1d5 <vector39>:
vector39:
  push $0
ffff80000010a1d5:	6a 00                	push   $0x0
  push $39
ffff80000010a1d7:	6a 27                	push   $0x27
  jmp alltraps
ffff80000010a1d9:	e9 8b f5 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a1de <vector40>:
vector40:
  push $0
ffff80000010a1de:	6a 00                	push   $0x0
  push $40
ffff80000010a1e0:	6a 28                	push   $0x28
  jmp alltraps
ffff80000010a1e2:	e9 82 f5 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a1e7 <vector41>:
vector41:
  push $0
ffff80000010a1e7:	6a 00                	push   $0x0
  push $41
ffff80000010a1e9:	6a 29                	push   $0x29
  jmp alltraps
ffff80000010a1eb:	e9 79 f5 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a1f0 <vector42>:
vector42:
  push $0
ffff80000010a1f0:	6a 00                	push   $0x0
  push $42
ffff80000010a1f2:	6a 2a                	push   $0x2a
  jmp alltraps
ffff80000010a1f4:	e9 70 f5 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a1f9 <vector43>:
vector43:
  push $0
ffff80000010a1f9:	6a 00                	push   $0x0
  push $43
ffff80000010a1fb:	6a 2b                	push   $0x2b
  jmp alltraps
ffff80000010a1fd:	e9 67 f5 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a202 <vector44>:
vector44:
  push $0
ffff80000010a202:	6a 00                	push   $0x0
  push $44
ffff80000010a204:	6a 2c                	push   $0x2c
  jmp alltraps
ffff80000010a206:	e9 5e f5 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a20b <vector45>:
vector45:
  push $0
ffff80000010a20b:	6a 00                	push   $0x0
  push $45
ffff80000010a20d:	6a 2d                	push   $0x2d
  jmp alltraps
ffff80000010a20f:	e9 55 f5 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a214 <vector46>:
vector46:
  push $0
ffff80000010a214:	6a 00                	push   $0x0
  push $46
ffff80000010a216:	6a 2e                	push   $0x2e
  jmp alltraps
ffff80000010a218:	e9 4c f5 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a21d <vector47>:
vector47:
  push $0
ffff80000010a21d:	6a 00                	push   $0x0
  push $47
ffff80000010a21f:	6a 2f                	push   $0x2f
  jmp alltraps
ffff80000010a221:	e9 43 f5 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a226 <vector48>:
vector48:
  push $0
ffff80000010a226:	6a 00                	push   $0x0
  push $48
ffff80000010a228:	6a 30                	push   $0x30
  jmp alltraps
ffff80000010a22a:	e9 3a f5 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a22f <vector49>:
vector49:
  push $0
ffff80000010a22f:	6a 00                	push   $0x0
  push $49
ffff80000010a231:	6a 31                	push   $0x31
  jmp alltraps
ffff80000010a233:	e9 31 f5 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a238 <vector50>:
vector50:
  push $0
ffff80000010a238:	6a 00                	push   $0x0
  push $50
ffff80000010a23a:	6a 32                	push   $0x32
  jmp alltraps
ffff80000010a23c:	e9 28 f5 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a241 <vector51>:
vector51:
  push $0
ffff80000010a241:	6a 00                	push   $0x0
  push $51
ffff80000010a243:	6a 33                	push   $0x33
  jmp alltraps
ffff80000010a245:	e9 1f f5 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a24a <vector52>:
vector52:
  push $0
ffff80000010a24a:	6a 00                	push   $0x0
  push $52
ffff80000010a24c:	6a 34                	push   $0x34
  jmp alltraps
ffff80000010a24e:	e9 16 f5 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a253 <vector53>:
vector53:
  push $0
ffff80000010a253:	6a 00                	push   $0x0
  push $53
ffff80000010a255:	6a 35                	push   $0x35
  jmp alltraps
ffff80000010a257:	e9 0d f5 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a25c <vector54>:
vector54:
  push $0
ffff80000010a25c:	6a 00                	push   $0x0
  push $54
ffff80000010a25e:	6a 36                	push   $0x36
  jmp alltraps
ffff80000010a260:	e9 04 f5 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a265 <vector55>:
vector55:
  push $0
ffff80000010a265:	6a 00                	push   $0x0
  push $55
ffff80000010a267:	6a 37                	push   $0x37
  jmp alltraps
ffff80000010a269:	e9 fb f4 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a26e <vector56>:
vector56:
  push $0
ffff80000010a26e:	6a 00                	push   $0x0
  push $56
ffff80000010a270:	6a 38                	push   $0x38
  jmp alltraps
ffff80000010a272:	e9 f2 f4 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a277 <vector57>:
vector57:
  push $0
ffff80000010a277:	6a 00                	push   $0x0
  push $57
ffff80000010a279:	6a 39                	push   $0x39
  jmp alltraps
ffff80000010a27b:	e9 e9 f4 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a280 <vector58>:
vector58:
  push $0
ffff80000010a280:	6a 00                	push   $0x0
  push $58
ffff80000010a282:	6a 3a                	push   $0x3a
  jmp alltraps
ffff80000010a284:	e9 e0 f4 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a289 <vector59>:
vector59:
  push $0
ffff80000010a289:	6a 00                	push   $0x0
  push $59
ffff80000010a28b:	6a 3b                	push   $0x3b
  jmp alltraps
ffff80000010a28d:	e9 d7 f4 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a292 <vector60>:
vector60:
  push $0
ffff80000010a292:	6a 00                	push   $0x0
  push $60
ffff80000010a294:	6a 3c                	push   $0x3c
  jmp alltraps
ffff80000010a296:	e9 ce f4 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a29b <vector61>:
vector61:
  push $0
ffff80000010a29b:	6a 00                	push   $0x0
  push $61
ffff80000010a29d:	6a 3d                	push   $0x3d
  jmp alltraps
ffff80000010a29f:	e9 c5 f4 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a2a4 <vector62>:
vector62:
  push $0
ffff80000010a2a4:	6a 00                	push   $0x0
  push $62
ffff80000010a2a6:	6a 3e                	push   $0x3e
  jmp alltraps
ffff80000010a2a8:	e9 bc f4 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a2ad <vector63>:
vector63:
  push $0
ffff80000010a2ad:	6a 00                	push   $0x0
  push $63
ffff80000010a2af:	6a 3f                	push   $0x3f
  jmp alltraps
ffff80000010a2b1:	e9 b3 f4 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a2b6 <vector64>:
vector64:
  push $0
ffff80000010a2b6:	6a 00                	push   $0x0
  push $64
ffff80000010a2b8:	6a 40                	push   $0x40
  jmp alltraps
ffff80000010a2ba:	e9 aa f4 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a2bf <vector65>:
vector65:
  push $0
ffff80000010a2bf:	6a 00                	push   $0x0
  push $65
ffff80000010a2c1:	6a 41                	push   $0x41
  jmp alltraps
ffff80000010a2c3:	e9 a1 f4 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a2c8 <vector66>:
vector66:
  push $0
ffff80000010a2c8:	6a 00                	push   $0x0
  push $66
ffff80000010a2ca:	6a 42                	push   $0x42
  jmp alltraps
ffff80000010a2cc:	e9 98 f4 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a2d1 <vector67>:
vector67:
  push $0
ffff80000010a2d1:	6a 00                	push   $0x0
  push $67
ffff80000010a2d3:	6a 43                	push   $0x43
  jmp alltraps
ffff80000010a2d5:	e9 8f f4 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a2da <vector68>:
vector68:
  push $0
ffff80000010a2da:	6a 00                	push   $0x0
  push $68
ffff80000010a2dc:	6a 44                	push   $0x44
  jmp alltraps
ffff80000010a2de:	e9 86 f4 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a2e3 <vector69>:
vector69:
  push $0
ffff80000010a2e3:	6a 00                	push   $0x0
  push $69
ffff80000010a2e5:	6a 45                	push   $0x45
  jmp alltraps
ffff80000010a2e7:	e9 7d f4 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a2ec <vector70>:
vector70:
  push $0
ffff80000010a2ec:	6a 00                	push   $0x0
  push $70
ffff80000010a2ee:	6a 46                	push   $0x46
  jmp alltraps
ffff80000010a2f0:	e9 74 f4 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a2f5 <vector71>:
vector71:
  push $0
ffff80000010a2f5:	6a 00                	push   $0x0
  push $71
ffff80000010a2f7:	6a 47                	push   $0x47
  jmp alltraps
ffff80000010a2f9:	e9 6b f4 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a2fe <vector72>:
vector72:
  push $0
ffff80000010a2fe:	6a 00                	push   $0x0
  push $72
ffff80000010a300:	6a 48                	push   $0x48
  jmp alltraps
ffff80000010a302:	e9 62 f4 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a307 <vector73>:
vector73:
  push $0
ffff80000010a307:	6a 00                	push   $0x0
  push $73
ffff80000010a309:	6a 49                	push   $0x49
  jmp alltraps
ffff80000010a30b:	e9 59 f4 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a310 <vector74>:
vector74:
  push $0
ffff80000010a310:	6a 00                	push   $0x0
  push $74
ffff80000010a312:	6a 4a                	push   $0x4a
  jmp alltraps
ffff80000010a314:	e9 50 f4 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a319 <vector75>:
vector75:
  push $0
ffff80000010a319:	6a 00                	push   $0x0
  push $75
ffff80000010a31b:	6a 4b                	push   $0x4b
  jmp alltraps
ffff80000010a31d:	e9 47 f4 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a322 <vector76>:
vector76:
  push $0
ffff80000010a322:	6a 00                	push   $0x0
  push $76
ffff80000010a324:	6a 4c                	push   $0x4c
  jmp alltraps
ffff80000010a326:	e9 3e f4 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a32b <vector77>:
vector77:
  push $0
ffff80000010a32b:	6a 00                	push   $0x0
  push $77
ffff80000010a32d:	6a 4d                	push   $0x4d
  jmp alltraps
ffff80000010a32f:	e9 35 f4 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a334 <vector78>:
vector78:
  push $0
ffff80000010a334:	6a 00                	push   $0x0
  push $78
ffff80000010a336:	6a 4e                	push   $0x4e
  jmp alltraps
ffff80000010a338:	e9 2c f4 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a33d <vector79>:
vector79:
  push $0
ffff80000010a33d:	6a 00                	push   $0x0
  push $79
ffff80000010a33f:	6a 4f                	push   $0x4f
  jmp alltraps
ffff80000010a341:	e9 23 f4 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a346 <vector80>:
vector80:
  push $0
ffff80000010a346:	6a 00                	push   $0x0
  push $80
ffff80000010a348:	6a 50                	push   $0x50
  jmp alltraps
ffff80000010a34a:	e9 1a f4 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a34f <vector81>:
vector81:
  push $0
ffff80000010a34f:	6a 00                	push   $0x0
  push $81
ffff80000010a351:	6a 51                	push   $0x51
  jmp alltraps
ffff80000010a353:	e9 11 f4 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a358 <vector82>:
vector82:
  push $0
ffff80000010a358:	6a 00                	push   $0x0
  push $82
ffff80000010a35a:	6a 52                	push   $0x52
  jmp alltraps
ffff80000010a35c:	e9 08 f4 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a361 <vector83>:
vector83:
  push $0
ffff80000010a361:	6a 00                	push   $0x0
  push $83
ffff80000010a363:	6a 53                	push   $0x53
  jmp alltraps
ffff80000010a365:	e9 ff f3 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a36a <vector84>:
vector84:
  push $0
ffff80000010a36a:	6a 00                	push   $0x0
  push $84
ffff80000010a36c:	6a 54                	push   $0x54
  jmp alltraps
ffff80000010a36e:	e9 f6 f3 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a373 <vector85>:
vector85:
  push $0
ffff80000010a373:	6a 00                	push   $0x0
  push $85
ffff80000010a375:	6a 55                	push   $0x55
  jmp alltraps
ffff80000010a377:	e9 ed f3 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a37c <vector86>:
vector86:
  push $0
ffff80000010a37c:	6a 00                	push   $0x0
  push $86
ffff80000010a37e:	6a 56                	push   $0x56
  jmp alltraps
ffff80000010a380:	e9 e4 f3 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a385 <vector87>:
vector87:
  push $0
ffff80000010a385:	6a 00                	push   $0x0
  push $87
ffff80000010a387:	6a 57                	push   $0x57
  jmp alltraps
ffff80000010a389:	e9 db f3 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a38e <vector88>:
vector88:
  push $0
ffff80000010a38e:	6a 00                	push   $0x0
  push $88
ffff80000010a390:	6a 58                	push   $0x58
  jmp alltraps
ffff80000010a392:	e9 d2 f3 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a397 <vector89>:
vector89:
  push $0
ffff80000010a397:	6a 00                	push   $0x0
  push $89
ffff80000010a399:	6a 59                	push   $0x59
  jmp alltraps
ffff80000010a39b:	e9 c9 f3 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a3a0 <vector90>:
vector90:
  push $0
ffff80000010a3a0:	6a 00                	push   $0x0
  push $90
ffff80000010a3a2:	6a 5a                	push   $0x5a
  jmp alltraps
ffff80000010a3a4:	e9 c0 f3 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a3a9 <vector91>:
vector91:
  push $0
ffff80000010a3a9:	6a 00                	push   $0x0
  push $91
ffff80000010a3ab:	6a 5b                	push   $0x5b
  jmp alltraps
ffff80000010a3ad:	e9 b7 f3 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a3b2 <vector92>:
vector92:
  push $0
ffff80000010a3b2:	6a 00                	push   $0x0
  push $92
ffff80000010a3b4:	6a 5c                	push   $0x5c
  jmp alltraps
ffff80000010a3b6:	e9 ae f3 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a3bb <vector93>:
vector93:
  push $0
ffff80000010a3bb:	6a 00                	push   $0x0
  push $93
ffff80000010a3bd:	6a 5d                	push   $0x5d
  jmp alltraps
ffff80000010a3bf:	e9 a5 f3 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a3c4 <vector94>:
vector94:
  push $0
ffff80000010a3c4:	6a 00                	push   $0x0
  push $94
ffff80000010a3c6:	6a 5e                	push   $0x5e
  jmp alltraps
ffff80000010a3c8:	e9 9c f3 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a3cd <vector95>:
vector95:
  push $0
ffff80000010a3cd:	6a 00                	push   $0x0
  push $95
ffff80000010a3cf:	6a 5f                	push   $0x5f
  jmp alltraps
ffff80000010a3d1:	e9 93 f3 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a3d6 <vector96>:
vector96:
  push $0
ffff80000010a3d6:	6a 00                	push   $0x0
  push $96
ffff80000010a3d8:	6a 60                	push   $0x60
  jmp alltraps
ffff80000010a3da:	e9 8a f3 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a3df <vector97>:
vector97:
  push $0
ffff80000010a3df:	6a 00                	push   $0x0
  push $97
ffff80000010a3e1:	6a 61                	push   $0x61
  jmp alltraps
ffff80000010a3e3:	e9 81 f3 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a3e8 <vector98>:
vector98:
  push $0
ffff80000010a3e8:	6a 00                	push   $0x0
  push $98
ffff80000010a3ea:	6a 62                	push   $0x62
  jmp alltraps
ffff80000010a3ec:	e9 78 f3 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a3f1 <vector99>:
vector99:
  push $0
ffff80000010a3f1:	6a 00                	push   $0x0
  push $99
ffff80000010a3f3:	6a 63                	push   $0x63
  jmp alltraps
ffff80000010a3f5:	e9 6f f3 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a3fa <vector100>:
vector100:
  push $0
ffff80000010a3fa:	6a 00                	push   $0x0
  push $100
ffff80000010a3fc:	6a 64                	push   $0x64
  jmp alltraps
ffff80000010a3fe:	e9 66 f3 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a403 <vector101>:
vector101:
  push $0
ffff80000010a403:	6a 00                	push   $0x0
  push $101
ffff80000010a405:	6a 65                	push   $0x65
  jmp alltraps
ffff80000010a407:	e9 5d f3 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a40c <vector102>:
vector102:
  push $0
ffff80000010a40c:	6a 00                	push   $0x0
  push $102
ffff80000010a40e:	6a 66                	push   $0x66
  jmp alltraps
ffff80000010a410:	e9 54 f3 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a415 <vector103>:
vector103:
  push $0
ffff80000010a415:	6a 00                	push   $0x0
  push $103
ffff80000010a417:	6a 67                	push   $0x67
  jmp alltraps
ffff80000010a419:	e9 4b f3 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a41e <vector104>:
vector104:
  push $0
ffff80000010a41e:	6a 00                	push   $0x0
  push $104
ffff80000010a420:	6a 68                	push   $0x68
  jmp alltraps
ffff80000010a422:	e9 42 f3 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a427 <vector105>:
vector105:
  push $0
ffff80000010a427:	6a 00                	push   $0x0
  push $105
ffff80000010a429:	6a 69                	push   $0x69
  jmp alltraps
ffff80000010a42b:	e9 39 f3 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a430 <vector106>:
vector106:
  push $0
ffff80000010a430:	6a 00                	push   $0x0
  push $106
ffff80000010a432:	6a 6a                	push   $0x6a
  jmp alltraps
ffff80000010a434:	e9 30 f3 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a439 <vector107>:
vector107:
  push $0
ffff80000010a439:	6a 00                	push   $0x0
  push $107
ffff80000010a43b:	6a 6b                	push   $0x6b
  jmp alltraps
ffff80000010a43d:	e9 27 f3 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a442 <vector108>:
vector108:
  push $0
ffff80000010a442:	6a 00                	push   $0x0
  push $108
ffff80000010a444:	6a 6c                	push   $0x6c
  jmp alltraps
ffff80000010a446:	e9 1e f3 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a44b <vector109>:
vector109:
  push $0
ffff80000010a44b:	6a 00                	push   $0x0
  push $109
ffff80000010a44d:	6a 6d                	push   $0x6d
  jmp alltraps
ffff80000010a44f:	e9 15 f3 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a454 <vector110>:
vector110:
  push $0
ffff80000010a454:	6a 00                	push   $0x0
  push $110
ffff80000010a456:	6a 6e                	push   $0x6e
  jmp alltraps
ffff80000010a458:	e9 0c f3 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a45d <vector111>:
vector111:
  push $0
ffff80000010a45d:	6a 00                	push   $0x0
  push $111
ffff80000010a45f:	6a 6f                	push   $0x6f
  jmp alltraps
ffff80000010a461:	e9 03 f3 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a466 <vector112>:
vector112:
  push $0
ffff80000010a466:	6a 00                	push   $0x0
  push $112
ffff80000010a468:	6a 70                	push   $0x70
  jmp alltraps
ffff80000010a46a:	e9 fa f2 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a46f <vector113>:
vector113:
  push $0
ffff80000010a46f:	6a 00                	push   $0x0
  push $113
ffff80000010a471:	6a 71                	push   $0x71
  jmp alltraps
ffff80000010a473:	e9 f1 f2 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a478 <vector114>:
vector114:
  push $0
ffff80000010a478:	6a 00                	push   $0x0
  push $114
ffff80000010a47a:	6a 72                	push   $0x72
  jmp alltraps
ffff80000010a47c:	e9 e8 f2 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a481 <vector115>:
vector115:
  push $0
ffff80000010a481:	6a 00                	push   $0x0
  push $115
ffff80000010a483:	6a 73                	push   $0x73
  jmp alltraps
ffff80000010a485:	e9 df f2 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a48a <vector116>:
vector116:
  push $0
ffff80000010a48a:	6a 00                	push   $0x0
  push $116
ffff80000010a48c:	6a 74                	push   $0x74
  jmp alltraps
ffff80000010a48e:	e9 d6 f2 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a493 <vector117>:
vector117:
  push $0
ffff80000010a493:	6a 00                	push   $0x0
  push $117
ffff80000010a495:	6a 75                	push   $0x75
  jmp alltraps
ffff80000010a497:	e9 cd f2 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a49c <vector118>:
vector118:
  push $0
ffff80000010a49c:	6a 00                	push   $0x0
  push $118
ffff80000010a49e:	6a 76                	push   $0x76
  jmp alltraps
ffff80000010a4a0:	e9 c4 f2 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a4a5 <vector119>:
vector119:
  push $0
ffff80000010a4a5:	6a 00                	push   $0x0
  push $119
ffff80000010a4a7:	6a 77                	push   $0x77
  jmp alltraps
ffff80000010a4a9:	e9 bb f2 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a4ae <vector120>:
vector120:
  push $0
ffff80000010a4ae:	6a 00                	push   $0x0
  push $120
ffff80000010a4b0:	6a 78                	push   $0x78
  jmp alltraps
ffff80000010a4b2:	e9 b2 f2 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a4b7 <vector121>:
vector121:
  push $0
ffff80000010a4b7:	6a 00                	push   $0x0
  push $121
ffff80000010a4b9:	6a 79                	push   $0x79
  jmp alltraps
ffff80000010a4bb:	e9 a9 f2 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a4c0 <vector122>:
vector122:
  push $0
ffff80000010a4c0:	6a 00                	push   $0x0
  push $122
ffff80000010a4c2:	6a 7a                	push   $0x7a
  jmp alltraps
ffff80000010a4c4:	e9 a0 f2 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a4c9 <vector123>:
vector123:
  push $0
ffff80000010a4c9:	6a 00                	push   $0x0
  push $123
ffff80000010a4cb:	6a 7b                	push   $0x7b
  jmp alltraps
ffff80000010a4cd:	e9 97 f2 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a4d2 <vector124>:
vector124:
  push $0
ffff80000010a4d2:	6a 00                	push   $0x0
  push $124
ffff80000010a4d4:	6a 7c                	push   $0x7c
  jmp alltraps
ffff80000010a4d6:	e9 8e f2 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a4db <vector125>:
vector125:
  push $0
ffff80000010a4db:	6a 00                	push   $0x0
  push $125
ffff80000010a4dd:	6a 7d                	push   $0x7d
  jmp alltraps
ffff80000010a4df:	e9 85 f2 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a4e4 <vector126>:
vector126:
  push $0
ffff80000010a4e4:	6a 00                	push   $0x0
  push $126
ffff80000010a4e6:	6a 7e                	push   $0x7e
  jmp alltraps
ffff80000010a4e8:	e9 7c f2 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a4ed <vector127>:
vector127:
  push $0
ffff80000010a4ed:	6a 00                	push   $0x0
  push $127
ffff80000010a4ef:	6a 7f                	push   $0x7f
  jmp alltraps
ffff80000010a4f1:	e9 73 f2 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a4f6 <vector128>:
vector128:
  push $0
ffff80000010a4f6:	6a 00                	push   $0x0
  push $128
ffff80000010a4f8:	68 80 00 00 00       	push   $0x80
  jmp alltraps
ffff80000010a4fd:	e9 67 f2 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a502 <vector129>:
vector129:
  push $0
ffff80000010a502:	6a 00                	push   $0x0
  push $129
ffff80000010a504:	68 81 00 00 00       	push   $0x81
  jmp alltraps
ffff80000010a509:	e9 5b f2 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a50e <vector130>:
vector130:
  push $0
ffff80000010a50e:	6a 00                	push   $0x0
  push $130
ffff80000010a510:	68 82 00 00 00       	push   $0x82
  jmp alltraps
ffff80000010a515:	e9 4f f2 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a51a <vector131>:
vector131:
  push $0
ffff80000010a51a:	6a 00                	push   $0x0
  push $131
ffff80000010a51c:	68 83 00 00 00       	push   $0x83
  jmp alltraps
ffff80000010a521:	e9 43 f2 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a526 <vector132>:
vector132:
  push $0
ffff80000010a526:	6a 00                	push   $0x0
  push $132
ffff80000010a528:	68 84 00 00 00       	push   $0x84
  jmp alltraps
ffff80000010a52d:	e9 37 f2 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a532 <vector133>:
vector133:
  push $0
ffff80000010a532:	6a 00                	push   $0x0
  push $133
ffff80000010a534:	68 85 00 00 00       	push   $0x85
  jmp alltraps
ffff80000010a539:	e9 2b f2 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a53e <vector134>:
vector134:
  push $0
ffff80000010a53e:	6a 00                	push   $0x0
  push $134
ffff80000010a540:	68 86 00 00 00       	push   $0x86
  jmp alltraps
ffff80000010a545:	e9 1f f2 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a54a <vector135>:
vector135:
  push $0
ffff80000010a54a:	6a 00                	push   $0x0
  push $135
ffff80000010a54c:	68 87 00 00 00       	push   $0x87
  jmp alltraps
ffff80000010a551:	e9 13 f2 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a556 <vector136>:
vector136:
  push $0
ffff80000010a556:	6a 00                	push   $0x0
  push $136
ffff80000010a558:	68 88 00 00 00       	push   $0x88
  jmp alltraps
ffff80000010a55d:	e9 07 f2 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a562 <vector137>:
vector137:
  push $0
ffff80000010a562:	6a 00                	push   $0x0
  push $137
ffff80000010a564:	68 89 00 00 00       	push   $0x89
  jmp alltraps
ffff80000010a569:	e9 fb f1 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a56e <vector138>:
vector138:
  push $0
ffff80000010a56e:	6a 00                	push   $0x0
  push $138
ffff80000010a570:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
ffff80000010a575:	e9 ef f1 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a57a <vector139>:
vector139:
  push $0
ffff80000010a57a:	6a 00                	push   $0x0
  push $139
ffff80000010a57c:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
ffff80000010a581:	e9 e3 f1 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a586 <vector140>:
vector140:
  push $0
ffff80000010a586:	6a 00                	push   $0x0
  push $140
ffff80000010a588:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
ffff80000010a58d:	e9 d7 f1 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a592 <vector141>:
vector141:
  push $0
ffff80000010a592:	6a 00                	push   $0x0
  push $141
ffff80000010a594:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
ffff80000010a599:	e9 cb f1 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a59e <vector142>:
vector142:
  push $0
ffff80000010a59e:	6a 00                	push   $0x0
  push $142
ffff80000010a5a0:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
ffff80000010a5a5:	e9 bf f1 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a5aa <vector143>:
vector143:
  push $0
ffff80000010a5aa:	6a 00                	push   $0x0
  push $143
ffff80000010a5ac:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
ffff80000010a5b1:	e9 b3 f1 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a5b6 <vector144>:
vector144:
  push $0
ffff80000010a5b6:	6a 00                	push   $0x0
  push $144
ffff80000010a5b8:	68 90 00 00 00       	push   $0x90
  jmp alltraps
ffff80000010a5bd:	e9 a7 f1 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a5c2 <vector145>:
vector145:
  push $0
ffff80000010a5c2:	6a 00                	push   $0x0
  push $145
ffff80000010a5c4:	68 91 00 00 00       	push   $0x91
  jmp alltraps
ffff80000010a5c9:	e9 9b f1 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a5ce <vector146>:
vector146:
  push $0
ffff80000010a5ce:	6a 00                	push   $0x0
  push $146
ffff80000010a5d0:	68 92 00 00 00       	push   $0x92
  jmp alltraps
ffff80000010a5d5:	e9 8f f1 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a5da <vector147>:
vector147:
  push $0
ffff80000010a5da:	6a 00                	push   $0x0
  push $147
ffff80000010a5dc:	68 93 00 00 00       	push   $0x93
  jmp alltraps
ffff80000010a5e1:	e9 83 f1 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a5e6 <vector148>:
vector148:
  push $0
ffff80000010a5e6:	6a 00                	push   $0x0
  push $148
ffff80000010a5e8:	68 94 00 00 00       	push   $0x94
  jmp alltraps
ffff80000010a5ed:	e9 77 f1 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a5f2 <vector149>:
vector149:
  push $0
ffff80000010a5f2:	6a 00                	push   $0x0
  push $149
ffff80000010a5f4:	68 95 00 00 00       	push   $0x95
  jmp alltraps
ffff80000010a5f9:	e9 6b f1 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a5fe <vector150>:
vector150:
  push $0
ffff80000010a5fe:	6a 00                	push   $0x0
  push $150
ffff80000010a600:	68 96 00 00 00       	push   $0x96
  jmp alltraps
ffff80000010a605:	e9 5f f1 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a60a <vector151>:
vector151:
  push $0
ffff80000010a60a:	6a 00                	push   $0x0
  push $151
ffff80000010a60c:	68 97 00 00 00       	push   $0x97
  jmp alltraps
ffff80000010a611:	e9 53 f1 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a616 <vector152>:
vector152:
  push $0
ffff80000010a616:	6a 00                	push   $0x0
  push $152
ffff80000010a618:	68 98 00 00 00       	push   $0x98
  jmp alltraps
ffff80000010a61d:	e9 47 f1 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a622 <vector153>:
vector153:
  push $0
ffff80000010a622:	6a 00                	push   $0x0
  push $153
ffff80000010a624:	68 99 00 00 00       	push   $0x99
  jmp alltraps
ffff80000010a629:	e9 3b f1 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a62e <vector154>:
vector154:
  push $0
ffff80000010a62e:	6a 00                	push   $0x0
  push $154
ffff80000010a630:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
ffff80000010a635:	e9 2f f1 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a63a <vector155>:
vector155:
  push $0
ffff80000010a63a:	6a 00                	push   $0x0
  push $155
ffff80000010a63c:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
ffff80000010a641:	e9 23 f1 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a646 <vector156>:
vector156:
  push $0
ffff80000010a646:	6a 00                	push   $0x0
  push $156
ffff80000010a648:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
ffff80000010a64d:	e9 17 f1 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a652 <vector157>:
vector157:
  push $0
ffff80000010a652:	6a 00                	push   $0x0
  push $157
ffff80000010a654:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
ffff80000010a659:	e9 0b f1 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a65e <vector158>:
vector158:
  push $0
ffff80000010a65e:	6a 00                	push   $0x0
  push $158
ffff80000010a660:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
ffff80000010a665:	e9 ff f0 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a66a <vector159>:
vector159:
  push $0
ffff80000010a66a:	6a 00                	push   $0x0
  push $159
ffff80000010a66c:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
ffff80000010a671:	e9 f3 f0 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a676 <vector160>:
vector160:
  push $0
ffff80000010a676:	6a 00                	push   $0x0
  push $160
ffff80000010a678:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
ffff80000010a67d:	e9 e7 f0 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a682 <vector161>:
vector161:
  push $0
ffff80000010a682:	6a 00                	push   $0x0
  push $161
ffff80000010a684:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
ffff80000010a689:	e9 db f0 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a68e <vector162>:
vector162:
  push $0
ffff80000010a68e:	6a 00                	push   $0x0
  push $162
ffff80000010a690:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
ffff80000010a695:	e9 cf f0 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a69a <vector163>:
vector163:
  push $0
ffff80000010a69a:	6a 00                	push   $0x0
  push $163
ffff80000010a69c:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
ffff80000010a6a1:	e9 c3 f0 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a6a6 <vector164>:
vector164:
  push $0
ffff80000010a6a6:	6a 00                	push   $0x0
  push $164
ffff80000010a6a8:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
ffff80000010a6ad:	e9 b7 f0 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a6b2 <vector165>:
vector165:
  push $0
ffff80000010a6b2:	6a 00                	push   $0x0
  push $165
ffff80000010a6b4:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
ffff80000010a6b9:	e9 ab f0 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a6be <vector166>:
vector166:
  push $0
ffff80000010a6be:	6a 00                	push   $0x0
  push $166
ffff80000010a6c0:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
ffff80000010a6c5:	e9 9f f0 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a6ca <vector167>:
vector167:
  push $0
ffff80000010a6ca:	6a 00                	push   $0x0
  push $167
ffff80000010a6cc:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
ffff80000010a6d1:	e9 93 f0 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a6d6 <vector168>:
vector168:
  push $0
ffff80000010a6d6:	6a 00                	push   $0x0
  push $168
ffff80000010a6d8:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
ffff80000010a6dd:	e9 87 f0 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a6e2 <vector169>:
vector169:
  push $0
ffff80000010a6e2:	6a 00                	push   $0x0
  push $169
ffff80000010a6e4:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
ffff80000010a6e9:	e9 7b f0 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a6ee <vector170>:
vector170:
  push $0
ffff80000010a6ee:	6a 00                	push   $0x0
  push $170
ffff80000010a6f0:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
ffff80000010a6f5:	e9 6f f0 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a6fa <vector171>:
vector171:
  push $0
ffff80000010a6fa:	6a 00                	push   $0x0
  push $171
ffff80000010a6fc:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
ffff80000010a701:	e9 63 f0 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a706 <vector172>:
vector172:
  push $0
ffff80000010a706:	6a 00                	push   $0x0
  push $172
ffff80000010a708:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
ffff80000010a70d:	e9 57 f0 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a712 <vector173>:
vector173:
  push $0
ffff80000010a712:	6a 00                	push   $0x0
  push $173
ffff80000010a714:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
ffff80000010a719:	e9 4b f0 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a71e <vector174>:
vector174:
  push $0
ffff80000010a71e:	6a 00                	push   $0x0
  push $174
ffff80000010a720:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
ffff80000010a725:	e9 3f f0 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a72a <vector175>:
vector175:
  push $0
ffff80000010a72a:	6a 00                	push   $0x0
  push $175
ffff80000010a72c:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
ffff80000010a731:	e9 33 f0 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a736 <vector176>:
vector176:
  push $0
ffff80000010a736:	6a 00                	push   $0x0
  push $176
ffff80000010a738:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
ffff80000010a73d:	e9 27 f0 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a742 <vector177>:
vector177:
  push $0
ffff80000010a742:	6a 00                	push   $0x0
  push $177
ffff80000010a744:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
ffff80000010a749:	e9 1b f0 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a74e <vector178>:
vector178:
  push $0
ffff80000010a74e:	6a 00                	push   $0x0
  push $178
ffff80000010a750:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
ffff80000010a755:	e9 0f f0 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a75a <vector179>:
vector179:
  push $0
ffff80000010a75a:	6a 00                	push   $0x0
  push $179
ffff80000010a75c:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
ffff80000010a761:	e9 03 f0 ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a766 <vector180>:
vector180:
  push $0
ffff80000010a766:	6a 00                	push   $0x0
  push $180
ffff80000010a768:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
ffff80000010a76d:	e9 f7 ef ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a772 <vector181>:
vector181:
  push $0
ffff80000010a772:	6a 00                	push   $0x0
  push $181
ffff80000010a774:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
ffff80000010a779:	e9 eb ef ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a77e <vector182>:
vector182:
  push $0
ffff80000010a77e:	6a 00                	push   $0x0
  push $182
ffff80000010a780:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
ffff80000010a785:	e9 df ef ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a78a <vector183>:
vector183:
  push $0
ffff80000010a78a:	6a 00                	push   $0x0
  push $183
ffff80000010a78c:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
ffff80000010a791:	e9 d3 ef ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a796 <vector184>:
vector184:
  push $0
ffff80000010a796:	6a 00                	push   $0x0
  push $184
ffff80000010a798:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
ffff80000010a79d:	e9 c7 ef ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a7a2 <vector185>:
vector185:
  push $0
ffff80000010a7a2:	6a 00                	push   $0x0
  push $185
ffff80000010a7a4:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
ffff80000010a7a9:	e9 bb ef ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a7ae <vector186>:
vector186:
  push $0
ffff80000010a7ae:	6a 00                	push   $0x0
  push $186
ffff80000010a7b0:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
ffff80000010a7b5:	e9 af ef ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a7ba <vector187>:
vector187:
  push $0
ffff80000010a7ba:	6a 00                	push   $0x0
  push $187
ffff80000010a7bc:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
ffff80000010a7c1:	e9 a3 ef ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a7c6 <vector188>:
vector188:
  push $0
ffff80000010a7c6:	6a 00                	push   $0x0
  push $188
ffff80000010a7c8:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
ffff80000010a7cd:	e9 97 ef ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a7d2 <vector189>:
vector189:
  push $0
ffff80000010a7d2:	6a 00                	push   $0x0
  push $189
ffff80000010a7d4:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
ffff80000010a7d9:	e9 8b ef ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a7de <vector190>:
vector190:
  push $0
ffff80000010a7de:	6a 00                	push   $0x0
  push $190
ffff80000010a7e0:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
ffff80000010a7e5:	e9 7f ef ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a7ea <vector191>:
vector191:
  push $0
ffff80000010a7ea:	6a 00                	push   $0x0
  push $191
ffff80000010a7ec:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
ffff80000010a7f1:	e9 73 ef ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a7f6 <vector192>:
vector192:
  push $0
ffff80000010a7f6:	6a 00                	push   $0x0
  push $192
ffff80000010a7f8:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
ffff80000010a7fd:	e9 67 ef ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a802 <vector193>:
vector193:
  push $0
ffff80000010a802:	6a 00                	push   $0x0
  push $193
ffff80000010a804:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
ffff80000010a809:	e9 5b ef ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a80e <vector194>:
vector194:
  push $0
ffff80000010a80e:	6a 00                	push   $0x0
  push $194
ffff80000010a810:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
ffff80000010a815:	e9 4f ef ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a81a <vector195>:
vector195:
  push $0
ffff80000010a81a:	6a 00                	push   $0x0
  push $195
ffff80000010a81c:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
ffff80000010a821:	e9 43 ef ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a826 <vector196>:
vector196:
  push $0
ffff80000010a826:	6a 00                	push   $0x0
  push $196
ffff80000010a828:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
ffff80000010a82d:	e9 37 ef ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a832 <vector197>:
vector197:
  push $0
ffff80000010a832:	6a 00                	push   $0x0
  push $197
ffff80000010a834:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
ffff80000010a839:	e9 2b ef ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a83e <vector198>:
vector198:
  push $0
ffff80000010a83e:	6a 00                	push   $0x0
  push $198
ffff80000010a840:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
ffff80000010a845:	e9 1f ef ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a84a <vector199>:
vector199:
  push $0
ffff80000010a84a:	6a 00                	push   $0x0
  push $199
ffff80000010a84c:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
ffff80000010a851:	e9 13 ef ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a856 <vector200>:
vector200:
  push $0
ffff80000010a856:	6a 00                	push   $0x0
  push $200
ffff80000010a858:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
ffff80000010a85d:	e9 07 ef ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a862 <vector201>:
vector201:
  push $0
ffff80000010a862:	6a 00                	push   $0x0
  push $201
ffff80000010a864:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
ffff80000010a869:	e9 fb ee ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a86e <vector202>:
vector202:
  push $0
ffff80000010a86e:	6a 00                	push   $0x0
  push $202
ffff80000010a870:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
ffff80000010a875:	e9 ef ee ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a87a <vector203>:
vector203:
  push $0
ffff80000010a87a:	6a 00                	push   $0x0
  push $203
ffff80000010a87c:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
ffff80000010a881:	e9 e3 ee ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a886 <vector204>:
vector204:
  push $0
ffff80000010a886:	6a 00                	push   $0x0
  push $204
ffff80000010a888:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
ffff80000010a88d:	e9 d7 ee ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a892 <vector205>:
vector205:
  push $0
ffff80000010a892:	6a 00                	push   $0x0
  push $205
ffff80000010a894:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
ffff80000010a899:	e9 cb ee ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a89e <vector206>:
vector206:
  push $0
ffff80000010a89e:	6a 00                	push   $0x0
  push $206
ffff80000010a8a0:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
ffff80000010a8a5:	e9 bf ee ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a8aa <vector207>:
vector207:
  push $0
ffff80000010a8aa:	6a 00                	push   $0x0
  push $207
ffff80000010a8ac:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
ffff80000010a8b1:	e9 b3 ee ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a8b6 <vector208>:
vector208:
  push $0
ffff80000010a8b6:	6a 00                	push   $0x0
  push $208
ffff80000010a8b8:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
ffff80000010a8bd:	e9 a7 ee ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a8c2 <vector209>:
vector209:
  push $0
ffff80000010a8c2:	6a 00                	push   $0x0
  push $209
ffff80000010a8c4:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
ffff80000010a8c9:	e9 9b ee ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a8ce <vector210>:
vector210:
  push $0
ffff80000010a8ce:	6a 00                	push   $0x0
  push $210
ffff80000010a8d0:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
ffff80000010a8d5:	e9 8f ee ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a8da <vector211>:
vector211:
  push $0
ffff80000010a8da:	6a 00                	push   $0x0
  push $211
ffff80000010a8dc:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
ffff80000010a8e1:	e9 83 ee ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a8e6 <vector212>:
vector212:
  push $0
ffff80000010a8e6:	6a 00                	push   $0x0
  push $212
ffff80000010a8e8:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
ffff80000010a8ed:	e9 77 ee ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a8f2 <vector213>:
vector213:
  push $0
ffff80000010a8f2:	6a 00                	push   $0x0
  push $213
ffff80000010a8f4:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
ffff80000010a8f9:	e9 6b ee ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a8fe <vector214>:
vector214:
  push $0
ffff80000010a8fe:	6a 00                	push   $0x0
  push $214
ffff80000010a900:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
ffff80000010a905:	e9 5f ee ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a90a <vector215>:
vector215:
  push $0
ffff80000010a90a:	6a 00                	push   $0x0
  push $215
ffff80000010a90c:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
ffff80000010a911:	e9 53 ee ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a916 <vector216>:
vector216:
  push $0
ffff80000010a916:	6a 00                	push   $0x0
  push $216
ffff80000010a918:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
ffff80000010a91d:	e9 47 ee ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a922 <vector217>:
vector217:
  push $0
ffff80000010a922:	6a 00                	push   $0x0
  push $217
ffff80000010a924:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
ffff80000010a929:	e9 3b ee ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a92e <vector218>:
vector218:
  push $0
ffff80000010a92e:	6a 00                	push   $0x0
  push $218
ffff80000010a930:	68 da 00 00 00       	push   $0xda
  jmp alltraps
ffff80000010a935:	e9 2f ee ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a93a <vector219>:
vector219:
  push $0
ffff80000010a93a:	6a 00                	push   $0x0
  push $219
ffff80000010a93c:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
ffff80000010a941:	e9 23 ee ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a946 <vector220>:
vector220:
  push $0
ffff80000010a946:	6a 00                	push   $0x0
  push $220
ffff80000010a948:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
ffff80000010a94d:	e9 17 ee ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a952 <vector221>:
vector221:
  push $0
ffff80000010a952:	6a 00                	push   $0x0
  push $221
ffff80000010a954:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
ffff80000010a959:	e9 0b ee ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a95e <vector222>:
vector222:
  push $0
ffff80000010a95e:	6a 00                	push   $0x0
  push $222
ffff80000010a960:	68 de 00 00 00       	push   $0xde
  jmp alltraps
ffff80000010a965:	e9 ff ed ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a96a <vector223>:
vector223:
  push $0
ffff80000010a96a:	6a 00                	push   $0x0
  push $223
ffff80000010a96c:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
ffff80000010a971:	e9 f3 ed ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a976 <vector224>:
vector224:
  push $0
ffff80000010a976:	6a 00                	push   $0x0
  push $224
ffff80000010a978:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
ffff80000010a97d:	e9 e7 ed ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a982 <vector225>:
vector225:
  push $0
ffff80000010a982:	6a 00                	push   $0x0
  push $225
ffff80000010a984:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
ffff80000010a989:	e9 db ed ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a98e <vector226>:
vector226:
  push $0
ffff80000010a98e:	6a 00                	push   $0x0
  push $226
ffff80000010a990:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
ffff80000010a995:	e9 cf ed ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a99a <vector227>:
vector227:
  push $0
ffff80000010a99a:	6a 00                	push   $0x0
  push $227
ffff80000010a99c:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
ffff80000010a9a1:	e9 c3 ed ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a9a6 <vector228>:
vector228:
  push $0
ffff80000010a9a6:	6a 00                	push   $0x0
  push $228
ffff80000010a9a8:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
ffff80000010a9ad:	e9 b7 ed ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a9b2 <vector229>:
vector229:
  push $0
ffff80000010a9b2:	6a 00                	push   $0x0
  push $229
ffff80000010a9b4:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
ffff80000010a9b9:	e9 ab ed ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a9be <vector230>:
vector230:
  push $0
ffff80000010a9be:	6a 00                	push   $0x0
  push $230
ffff80000010a9c0:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
ffff80000010a9c5:	e9 9f ed ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a9ca <vector231>:
vector231:
  push $0
ffff80000010a9ca:	6a 00                	push   $0x0
  push $231
ffff80000010a9cc:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
ffff80000010a9d1:	e9 93 ed ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a9d6 <vector232>:
vector232:
  push $0
ffff80000010a9d6:	6a 00                	push   $0x0
  push $232
ffff80000010a9d8:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
ffff80000010a9dd:	e9 87 ed ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a9e2 <vector233>:
vector233:
  push $0
ffff80000010a9e2:	6a 00                	push   $0x0
  push $233
ffff80000010a9e4:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
ffff80000010a9e9:	e9 7b ed ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a9ee <vector234>:
vector234:
  push $0
ffff80000010a9ee:	6a 00                	push   $0x0
  push $234
ffff80000010a9f0:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
ffff80000010a9f5:	e9 6f ed ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010a9fa <vector235>:
vector235:
  push $0
ffff80000010a9fa:	6a 00                	push   $0x0
  push $235
ffff80000010a9fc:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
ffff80000010aa01:	e9 63 ed ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010aa06 <vector236>:
vector236:
  push $0
ffff80000010aa06:	6a 00                	push   $0x0
  push $236
ffff80000010aa08:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
ffff80000010aa0d:	e9 57 ed ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010aa12 <vector237>:
vector237:
  push $0
ffff80000010aa12:	6a 00                	push   $0x0
  push $237
ffff80000010aa14:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
ffff80000010aa19:	e9 4b ed ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010aa1e <vector238>:
vector238:
  push $0
ffff80000010aa1e:	6a 00                	push   $0x0
  push $238
ffff80000010aa20:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
ffff80000010aa25:	e9 3f ed ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010aa2a <vector239>:
vector239:
  push $0
ffff80000010aa2a:	6a 00                	push   $0x0
  push $239
ffff80000010aa2c:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
ffff80000010aa31:	e9 33 ed ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010aa36 <vector240>:
vector240:
  push $0
ffff80000010aa36:	6a 00                	push   $0x0
  push $240
ffff80000010aa38:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
ffff80000010aa3d:	e9 27 ed ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010aa42 <vector241>:
vector241:
  push $0
ffff80000010aa42:	6a 00                	push   $0x0
  push $241
ffff80000010aa44:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
ffff80000010aa49:	e9 1b ed ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010aa4e <vector242>:
vector242:
  push $0
ffff80000010aa4e:	6a 00                	push   $0x0
  push $242
ffff80000010aa50:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
ffff80000010aa55:	e9 0f ed ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010aa5a <vector243>:
vector243:
  push $0
ffff80000010aa5a:	6a 00                	push   $0x0
  push $243
ffff80000010aa5c:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
ffff80000010aa61:	e9 03 ed ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010aa66 <vector244>:
vector244:
  push $0
ffff80000010aa66:	6a 00                	push   $0x0
  push $244
ffff80000010aa68:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
ffff80000010aa6d:	e9 f7 ec ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010aa72 <vector245>:
vector245:
  push $0
ffff80000010aa72:	6a 00                	push   $0x0
  push $245
ffff80000010aa74:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
ffff80000010aa79:	e9 eb ec ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010aa7e <vector246>:
vector246:
  push $0
ffff80000010aa7e:	6a 00                	push   $0x0
  push $246
ffff80000010aa80:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
ffff80000010aa85:	e9 df ec ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010aa8a <vector247>:
vector247:
  push $0
ffff80000010aa8a:	6a 00                	push   $0x0
  push $247
ffff80000010aa8c:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
ffff80000010aa91:	e9 d3 ec ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010aa96 <vector248>:
vector248:
  push $0
ffff80000010aa96:	6a 00                	push   $0x0
  push $248
ffff80000010aa98:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
ffff80000010aa9d:	e9 c7 ec ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010aaa2 <vector249>:
vector249:
  push $0
ffff80000010aaa2:	6a 00                	push   $0x0
  push $249
ffff80000010aaa4:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
ffff80000010aaa9:	e9 bb ec ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010aaae <vector250>:
vector250:
  push $0
ffff80000010aaae:	6a 00                	push   $0x0
  push $250
ffff80000010aab0:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
ffff80000010aab5:	e9 af ec ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010aaba <vector251>:
vector251:
  push $0
ffff80000010aaba:	6a 00                	push   $0x0
  push $251
ffff80000010aabc:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
ffff80000010aac1:	e9 a3 ec ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010aac6 <vector252>:
vector252:
  push $0
ffff80000010aac6:	6a 00                	push   $0x0
  push $252
ffff80000010aac8:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
ffff80000010aacd:	e9 97 ec ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010aad2 <vector253>:
vector253:
  push $0
ffff80000010aad2:	6a 00                	push   $0x0
  push $253
ffff80000010aad4:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
ffff80000010aad9:	e9 8b ec ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010aade <vector254>:
vector254:
  push $0
ffff80000010aade:	6a 00                	push   $0x0
  push $254
ffff80000010aae0:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
ffff80000010aae5:	e9 7f ec ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010aaea <vector255>:
vector255:
  push $0
ffff80000010aaea:	6a 00                	push   $0x0
  push $255
ffff80000010aaec:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
ffff80000010aaf1:	e9 73 ec ff ff       	jmp    ffff800000109769 <alltraps>

ffff80000010aaf6 <lgdt>:
{
ffff80000010aaf6:	55                   	push   %rbp
ffff80000010aaf7:	48 89 e5             	mov    %rsp,%rbp
ffff80000010aafa:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010aafe:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010ab02:	89 75 d4             	mov    %esi,-0x2c(%rbp)
  addr_t addr = (addr_t)p;
ffff80000010ab05:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010ab09:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  pd[0] = size-1;
ffff80000010ab0d:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff80000010ab10:	83 e8 01             	sub    $0x1,%eax
ffff80000010ab13:	66 89 45 ee          	mov    %ax,-0x12(%rbp)
  pd[1] = addr;
ffff80000010ab17:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010ab1b:	66 89 45 f0          	mov    %ax,-0x10(%rbp)
  pd[2] = addr >> 16;
ffff80000010ab1f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010ab23:	48 c1 e8 10          	shr    $0x10,%rax
ffff80000010ab27:	66 89 45 f2          	mov    %ax,-0xe(%rbp)
  pd[3] = addr >> 32;
ffff80000010ab2b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010ab2f:	48 c1 e8 20          	shr    $0x20,%rax
ffff80000010ab33:	66 89 45 f4          	mov    %ax,-0xc(%rbp)
  pd[4] = addr >> 48;
ffff80000010ab37:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010ab3b:	48 c1 e8 30          	shr    $0x30,%rax
ffff80000010ab3f:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
  asm volatile("lgdt (%0)" : : "r" (pd));
ffff80000010ab43:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
ffff80000010ab47:	0f 01 10             	lgdt   (%rax)
}
ffff80000010ab4a:	90                   	nop
ffff80000010ab4b:	c9                   	leave
ffff80000010ab4c:	c3                   	ret

ffff80000010ab4d <ltr>:
{
ffff80000010ab4d:	55                   	push   %rbp
ffff80000010ab4e:	48 89 e5             	mov    %rsp,%rbp
ffff80000010ab51:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010ab55:	89 f8                	mov    %edi,%eax
ffff80000010ab57:	66 89 45 fc          	mov    %ax,-0x4(%rbp)
  asm volatile("ltr %0" : : "r" (sel));
ffff80000010ab5b:	0f b7 45 fc          	movzwl -0x4(%rbp),%eax
ffff80000010ab5f:	0f 00 d8             	ltr    %eax
}
ffff80000010ab62:	90                   	nop
ffff80000010ab63:	c9                   	leave
ffff80000010ab64:	c3                   	ret

ffff80000010ab65 <lcr3>:

static inline void
lcr3(addr_t val)
{
ffff80000010ab65:	55                   	push   %rbp
ffff80000010ab66:	48 89 e5             	mov    %rsp,%rbp
ffff80000010ab69:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010ab6d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  asm volatile("mov %0,%%cr3" : : "r" (val));
ffff80000010ab71:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010ab75:	0f 22 d8             	mov    %rax,%cr3
}
ffff80000010ab78:	90                   	nop
ffff80000010ab79:	c9                   	leave
ffff80000010ab7a:	c3                   	ret

ffff80000010ab7b <v2p>:
static inline addr_t v2p(void *a) {
ffff80000010ab7b:	55                   	push   %rbp
ffff80000010ab7c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010ab7f:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010ab83:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  return ((addr_t) (a)) - ((addr_t)KERNBASE);
ffff80000010ab87:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010ab8b:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010ab92:	80 00 00 
ffff80000010ab95:	48 01 d0             	add    %rdx,%rax
}
ffff80000010ab98:	c9                   	leave
ffff80000010ab99:	c3                   	ret

ffff80000010ab9a <syscallinit>:
static pml4e_t *kpml4;
static pdpe_t *kpdpt;

void
syscallinit(void)
{
ffff80000010ab9a:	55                   	push   %rbp
ffff80000010ab9b:	48 89 e5             	mov    %rsp,%rbp
  // the MSR/SYSRET wants the segment for 32-bit user data
  // next up is 64-bit user data, then code
  // This is simply the way the sysret instruction
  // is designed to work (it assumes they follow).
  wrmsr(MSR_STAR,
ffff80000010ab9e:	48 b8 00 00 00 00 08 	movabs $0x1b000800000000,%rax
ffff80000010aba5:	00 1b 00 
ffff80000010aba8:	48 89 c6             	mov    %rax,%rsi
ffff80000010abab:	bf 81 00 00 c0       	mov    $0xc0000081,%edi
ffff80000010abb0:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010abb7:	80 ff ff 
ffff80000010abba:	ff d0                	call   *%rax
    ((((uint64)USER32_CS) << 48) | ((uint64)KERNEL_CS << 32)));
  wrmsr(MSR_LSTAR, (addr_t)syscall_entry);
ffff80000010abbc:	48 b8 a5 97 10 00 00 	movabs $0xffff8000001097a5,%rax
ffff80000010abc3:	80 ff ff 
ffff80000010abc6:	48 89 c6             	mov    %rax,%rsi
ffff80000010abc9:	bf 82 00 00 c0       	mov    $0xc0000082,%edi
ffff80000010abce:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010abd5:	80 ff ff 
ffff80000010abd8:	ff d0                	call   *%rax
  wrmsr(MSR_CSTAR, (addr_t)ignore_sysret);
ffff80000010abda:	48 b8 11 01 10 00 00 	movabs $0xffff800000100111,%rax
ffff80000010abe1:	80 ff ff 
ffff80000010abe4:	48 89 c6             	mov    %rax,%rsi
ffff80000010abe7:	bf 83 00 00 c0       	mov    $0xc0000083,%edi
ffff80000010abec:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010abf3:	80 ff ff 
ffff80000010abf6:	ff d0                	call   *%rax

  wrmsr(MSR_SFMASK, FL_TF|FL_DF|FL_IF|FL_IOPL_3|FL_AC|FL_NT);
ffff80000010abf8:	be 00 77 04 00       	mov    $0x47700,%esi
ffff80000010abfd:	bf 84 00 00 c0       	mov    $0xc0000084,%edi
ffff80000010ac02:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010ac09:	80 ff ff 
ffff80000010ac0c:	ff d0                	call   *%rax
}
ffff80000010ac0e:	90                   	nop
ffff80000010ac0f:	5d                   	pop    %rbp
ffff80000010ac10:	c3                   	ret

ffff80000010ac11 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
ffff80000010ac11:	55                   	push   %rbp
ffff80000010ac12:	48 89 e5             	mov    %rsp,%rbp
ffff80000010ac15:	48 83 ec 30          	sub    $0x30,%rsp
  uint64 addr;
  void *local;
  struct cpu *c;

  // create a page for cpu local storage
  local = kalloc();
ffff80000010ac19:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010ac20:	80 ff ff 
ffff80000010ac23:	ff d0                	call   *%rax
ffff80000010ac25:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(local, 0, PGSIZE);
ffff80000010ac29:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010ac2d:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010ac32:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010ac37:	48 89 c7             	mov    %rax,%rdi
ffff80000010ac3a:	48 b8 ce 7a 10 00 00 	movabs $0xffff800000107ace,%rax
ffff80000010ac41:	80 ff ff 
ffff80000010ac44:	ff d0                	call   *%rax

  gdt = (struct segdesc*) local;
ffff80000010ac46:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010ac4a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  tss = (uint*) (((char*) local) + 1024);
ffff80000010ac4e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010ac52:	48 05 00 04 00 00    	add    $0x400,%rax
ffff80000010ac58:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  tss[16] = 0x00680000; // IO Map Base = End of TSS
ffff80000010ac5c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010ac60:	48 83 c0 40          	add    $0x40,%rax
ffff80000010ac64:	c7 00 00 00 68 00    	movl   $0x680000,(%rax)

  // point FS smack in the middle of our local storage page
  wrmsr(0xC0000100, ((uint64) local) + 2048);
ffff80000010ac6a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010ac6e:	48 05 00 08 00 00    	add    $0x800,%rax
ffff80000010ac74:	48 89 c6             	mov    %rax,%rsi
ffff80000010ac77:	bf 00 01 00 c0       	mov    $0xc0000100,%edi
ffff80000010ac7c:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010ac83:	80 ff ff 
ffff80000010ac86:	ff d0                	call   *%rax

  c = &cpus[cpunum()];
ffff80000010ac88:	48 b8 88 46 10 00 00 	movabs $0xffff800000104688,%rax
ffff80000010ac8f:	80 ff ff 
ffff80000010ac92:	ff d0                	call   *%rax
ffff80000010ac94:	48 63 d0             	movslq %eax,%rdx
ffff80000010ac97:	48 89 d0             	mov    %rdx,%rax
ffff80000010ac9a:	48 c1 e0 02          	shl    $0x2,%rax
ffff80000010ac9e:	48 01 d0             	add    %rdx,%rax
ffff80000010aca1:	48 c1 e0 03          	shl    $0x3,%rax
ffff80000010aca5:	48 ba e0 72 11 00 00 	movabs $0xffff8000001172e0,%rdx
ffff80000010acac:	80 ff ff 
ffff80000010acaf:	48 01 d0             	add    %rdx,%rax
ffff80000010acb2:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  c->local = local;
ffff80000010acb6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010acba:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010acbe:	48 89 50 20          	mov    %rdx,0x20(%rax)

  cpu = c;
ffff80000010acc2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010acc6:	64 48 89 04 25 f0 ff 	mov    %rax,%fs:0xfffffffffffffff0
ffff80000010accd:	ff ff 
  proc = 0;
ffff80000010accf:	64 48 c7 04 25 f8 ff 	movq   $0x0,%fs:0xfffffffffffffff8
ffff80000010acd6:	ff ff 00 00 00 00 

  addr = (uint64) tss;
ffff80000010acdc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010ace0:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  gdt[0] =  (struct segdesc) {};
ffff80000010ace4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010ace8:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)

  gdt[SEG_KCODE] = SEG((STA_X|STA_R), 0, 0, APP_SEG, !DPL_USER, 1);
ffff80000010acef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010acf3:	48 83 c0 08          	add    $0x8,%rax
ffff80000010acf7:	66 c7 00 00 00       	movw   $0x0,(%rax)
ffff80000010acfc:	66 c7 40 02 00 00    	movw   $0x0,0x2(%rax)
ffff80000010ad02:	c6 40 04 00          	movb   $0x0,0x4(%rax)
ffff80000010ad06:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010ad0a:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010ad0d:	83 ca 0a             	or     $0xa,%edx
ffff80000010ad10:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010ad13:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010ad17:	83 ca 10             	or     $0x10,%edx
ffff80000010ad1a:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010ad1d:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010ad21:	83 e2 9f             	and    $0xffffff9f,%edx
ffff80000010ad24:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010ad27:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010ad2b:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010ad2e:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010ad31:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010ad35:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010ad38:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010ad3b:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010ad3f:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010ad42:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010ad45:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010ad49:	83 ca 20             	or     $0x20,%edx
ffff80000010ad4c:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010ad4f:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010ad53:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010ad56:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010ad59:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010ad5d:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010ad60:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010ad63:	c6 40 07 00          	movb   $0x0,0x7(%rax)
  gdt[SEG_KDATA] = SEG(STA_W, 0, 0, APP_SEG, !DPL_USER, 0);
ffff80000010ad67:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010ad6b:	48 83 c0 10          	add    $0x10,%rax
ffff80000010ad6f:	66 c7 00 00 00       	movw   $0x0,(%rax)
ffff80000010ad74:	66 c7 40 02 00 00    	movw   $0x0,0x2(%rax)
ffff80000010ad7a:	c6 40 04 00          	movb   $0x0,0x4(%rax)
ffff80000010ad7e:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010ad82:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010ad85:	83 ca 02             	or     $0x2,%edx
ffff80000010ad88:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010ad8b:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010ad8f:	83 ca 10             	or     $0x10,%edx
ffff80000010ad92:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010ad95:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010ad99:	83 e2 9f             	and    $0xffffff9f,%edx
ffff80000010ad9c:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010ad9f:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010ada3:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010ada6:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010ada9:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010adad:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010adb0:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010adb3:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010adb7:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010adba:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010adbd:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010adc1:	83 e2 df             	and    $0xffffffdf,%edx
ffff80000010adc4:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010adc7:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010adcb:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010adce:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010add1:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010add5:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010add8:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010addb:	c6 40 07 00          	movb   $0x0,0x7(%rax)
  gdt[SEG_UCODE32] = (struct segdesc) {}; // required by syscall/sysret
ffff80000010addf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010ade3:	48 83 c0 18          	add    $0x18,%rax
ffff80000010ade7:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  gdt[SEG_UDATA] = SEG(STA_W, 0, 0, APP_SEG, DPL_USER, 0);
ffff80000010adee:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010adf2:	48 83 c0 20          	add    $0x20,%rax
ffff80000010adf6:	66 c7 00 00 00       	movw   $0x0,(%rax)
ffff80000010adfb:	66 c7 40 02 00 00    	movw   $0x0,0x2(%rax)
ffff80000010ae01:	c6 40 04 00          	movb   $0x0,0x4(%rax)
ffff80000010ae05:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010ae09:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010ae0c:	83 ca 02             	or     $0x2,%edx
ffff80000010ae0f:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010ae12:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010ae16:	83 ca 10             	or     $0x10,%edx
ffff80000010ae19:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010ae1c:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010ae20:	83 ca 60             	or     $0x60,%edx
ffff80000010ae23:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010ae26:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010ae2a:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010ae2d:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010ae30:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010ae34:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010ae37:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010ae3a:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010ae3e:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010ae41:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010ae44:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010ae48:	83 e2 df             	and    $0xffffffdf,%edx
ffff80000010ae4b:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010ae4e:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010ae52:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010ae55:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010ae58:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010ae5c:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010ae5f:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010ae62:	c6 40 07 00          	movb   $0x0,0x7(%rax)
  gdt[SEG_UCODE] = SEG((STA_X|STA_R), 0, 0, APP_SEG, DPL_USER, 1);
ffff80000010ae66:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010ae6a:	48 83 c0 28          	add    $0x28,%rax
ffff80000010ae6e:	66 c7 00 00 00       	movw   $0x0,(%rax)
ffff80000010ae73:	66 c7 40 02 00 00    	movw   $0x0,0x2(%rax)
ffff80000010ae79:	c6 40 04 00          	movb   $0x0,0x4(%rax)
ffff80000010ae7d:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010ae81:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010ae84:	83 ca 0a             	or     $0xa,%edx
ffff80000010ae87:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010ae8a:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010ae8e:	83 ca 10             	or     $0x10,%edx
ffff80000010ae91:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010ae94:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010ae98:	83 ca 60             	or     $0x60,%edx
ffff80000010ae9b:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010ae9e:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010aea2:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010aea5:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010aea8:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010aeac:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010aeaf:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010aeb2:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010aeb6:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010aeb9:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010aebc:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010aec0:	83 ca 20             	or     $0x20,%edx
ffff80000010aec3:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010aec6:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010aeca:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010aecd:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010aed0:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010aed4:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010aed7:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010aeda:	c6 40 07 00          	movb   $0x0,0x7(%rax)
  gdt[SEG_KCPU]  = (struct segdesc) {};
ffff80000010aede:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010aee2:	48 83 c0 30          	add    $0x30,%rax
ffff80000010aee6:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  // TSS: See IA32 SDM Figure 7-4
  gdt[SEG_TSS]   = SEG(STS_T64A, 0xb, addr, !APP_SEG, DPL_USER, 0);
ffff80000010aeed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010aef1:	48 83 c0 38          	add    $0x38,%rax
ffff80000010aef5:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010aef9:	89 d7                	mov    %edx,%edi
ffff80000010aefb:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010aeff:	48 c1 ea 10          	shr    $0x10,%rdx
ffff80000010af03:	89 d6                	mov    %edx,%esi
ffff80000010af05:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010af09:	48 c1 ea 18          	shr    $0x18,%rdx
ffff80000010af0d:	89 d1                	mov    %edx,%ecx
ffff80000010af0f:	66 c7 00 0b 00       	movw   $0xb,(%rax)
ffff80000010af14:	66 89 78 02          	mov    %di,0x2(%rax)
ffff80000010af18:	40 88 70 04          	mov    %sil,0x4(%rax)
ffff80000010af1c:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010af20:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010af23:	83 ca 09             	or     $0x9,%edx
ffff80000010af26:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010af29:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010af2d:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010af30:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010af33:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010af37:	83 ca 60             	or     $0x60,%edx
ffff80000010af3a:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010af3d:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010af41:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010af44:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010af47:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010af4b:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010af4e:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010af51:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010af55:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010af58:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010af5b:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010af5f:	83 e2 df             	and    $0xffffffdf,%edx
ffff80000010af62:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010af65:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010af69:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010af6c:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010af6f:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010af73:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010af76:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010af79:	88 48 07             	mov    %cl,0x7(%rax)
  gdt[SEG_TSS+1] = SEG(0, addr >> 32, addr >> 48, 0, 0, 0);
ffff80000010af7c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010af80:	48 83 c0 40          	add    $0x40,%rax
ffff80000010af84:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010af88:	48 c1 ea 20          	shr    $0x20,%rdx
ffff80000010af8c:	41 89 d1             	mov    %edx,%r9d
ffff80000010af8f:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010af93:	48 c1 ea 30          	shr    $0x30,%rdx
ffff80000010af97:	41 89 d0             	mov    %edx,%r8d
ffff80000010af9a:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010af9e:	48 c1 ea 30          	shr    $0x30,%rdx
ffff80000010afa2:	48 c1 ea 10          	shr    $0x10,%rdx
ffff80000010afa6:	89 d7                	mov    %edx,%edi
ffff80000010afa8:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010afac:	48 c1 ea 20          	shr    $0x20,%rdx
ffff80000010afb0:	48 c1 ea 3c          	shr    $0x3c,%rdx
ffff80000010afb4:	83 e2 0f             	and    $0xf,%edx
ffff80000010afb7:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff80000010afbb:	48 c1 e9 30          	shr    $0x30,%rcx
ffff80000010afbf:	48 c1 e9 18          	shr    $0x18,%rcx
ffff80000010afc3:	89 ce                	mov    %ecx,%esi
ffff80000010afc5:	66 44 89 08          	mov    %r9w,(%rax)
ffff80000010afc9:	66 44 89 40 02       	mov    %r8w,0x2(%rax)
ffff80000010afce:	40 88 78 04          	mov    %dil,0x4(%rax)
ffff80000010afd2:	0f b6 48 05          	movzbl 0x5(%rax),%ecx
ffff80000010afd6:	83 e1 f0             	and    $0xfffffff0,%ecx
ffff80000010afd9:	88 48 05             	mov    %cl,0x5(%rax)
ffff80000010afdc:	0f b6 48 05          	movzbl 0x5(%rax),%ecx
ffff80000010afe0:	83 e1 ef             	and    $0xffffffef,%ecx
ffff80000010afe3:	88 48 05             	mov    %cl,0x5(%rax)
ffff80000010afe6:	0f b6 48 05          	movzbl 0x5(%rax),%ecx
ffff80000010afea:	83 e1 9f             	and    $0xffffff9f,%ecx
ffff80000010afed:	88 48 05             	mov    %cl,0x5(%rax)
ffff80000010aff0:	0f b6 48 05          	movzbl 0x5(%rax),%ecx
ffff80000010aff4:	83 c9 80             	or     $0xffffff80,%ecx
ffff80000010aff7:	88 48 05             	mov    %cl,0x5(%rax)
ffff80000010affa:	89 d1                	mov    %edx,%ecx
ffff80000010affc:	83 e1 0f             	and    $0xf,%ecx
ffff80000010afff:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b003:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010b006:	09 ca                	or     %ecx,%edx
ffff80000010b008:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b00b:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b00f:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010b012:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b015:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b019:	83 e2 df             	and    $0xffffffdf,%edx
ffff80000010b01c:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b01f:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b023:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010b026:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b029:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b02d:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010b030:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b033:	40 88 70 07          	mov    %sil,0x7(%rax)

  lgdt((void*) gdt, (NSEGS+1) * sizeof(struct segdesc));
ffff80000010b037:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b03b:	be 48 00 00 00       	mov    $0x48,%esi
ffff80000010b040:	48 89 c7             	mov    %rax,%rdi
ffff80000010b043:	48 b8 f6 aa 10 00 00 	movabs $0xffff80000010aaf6,%rax
ffff80000010b04a:	80 ff ff 
ffff80000010b04d:	ff d0                	call   *%rax

  ltr(SEG_TSS << 3);
ffff80000010b04f:	bf 38 00 00 00       	mov    $0x38,%edi
ffff80000010b054:	48 b8 4d ab 10 00 00 	movabs $0xffff80000010ab4d,%rax
ffff80000010b05b:	80 ff ff 
ffff80000010b05e:	ff d0                	call   *%rax
};
ffff80000010b060:	90                   	nop
ffff80000010b061:	c9                   	leave
ffff80000010b062:	c3                   	ret

ffff80000010b063 <setupkvm>:
// (directly addressable from end..P2V(PHYSTOP)).


pml4e_t*
setupkvm(void)
{
ffff80000010b063:	55                   	push   %rbp
ffff80000010b064:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b067:	48 83 ec 10          	sub    $0x10,%rsp
  pml4e_t *pml4 = (pml4e_t*) kalloc();
ffff80000010b06b:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010b072:	80 ff ff 
ffff80000010b075:	ff d0                	call   *%rax
ffff80000010b077:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(pml4, 0, PGSIZE);
ffff80000010b07b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b07f:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b084:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b089:	48 89 c7             	mov    %rax,%rdi
ffff80000010b08c:	48 b8 ce 7a 10 00 00 	movabs $0xffff800000107ace,%rax
ffff80000010b093:	80 ff ff 
ffff80000010b096:	ff d0                	call   *%rax
  pml4[256] = v2p(kpdpt) | PTE_P | PTE_W;
ffff80000010b098:	48 b8 60 c1 11 00 00 	movabs $0xffff80000011c160,%rax
ffff80000010b09f:	80 ff ff 
ffff80000010b0a2:	48 8b 00             	mov    (%rax),%rax
ffff80000010b0a5:	48 89 c7             	mov    %rax,%rdi
ffff80000010b0a8:	48 b8 7b ab 10 00 00 	movabs $0xffff80000010ab7b,%rax
ffff80000010b0af:	80 ff ff 
ffff80000010b0b2:	ff d0                	call   *%rax
ffff80000010b0b4:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010b0b8:	48 81 c2 00 08 00 00 	add    $0x800,%rdx
ffff80000010b0bf:	48 83 c8 03          	or     $0x3,%rax
ffff80000010b0c3:	48 89 02             	mov    %rax,(%rdx)
  return pml4;
ffff80000010b0c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
};
ffff80000010b0ca:	c9                   	leave
ffff80000010b0cb:	c3                   	ret

ffff80000010b0cc <kvmalloc>:
//
// linear map the first 4GB of physical memory starting
// at 0xFFFF800000000000
void
kvmalloc(void)
{
ffff80000010b0cc:	55                   	push   %rbp
ffff80000010b0cd:	48 89 e5             	mov    %rsp,%rbp
  kpml4 = (pml4e_t*) kalloc();
ffff80000010b0d0:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010b0d7:	80 ff ff 
ffff80000010b0da:	ff d0                	call   *%rax
ffff80000010b0dc:	48 ba 58 c1 11 00 00 	movabs $0xffff80000011c158,%rdx
ffff80000010b0e3:	80 ff ff 
ffff80000010b0e6:	48 89 02             	mov    %rax,(%rdx)
  memset(kpml4, 0, PGSIZE);
ffff80000010b0e9:	48 b8 58 c1 11 00 00 	movabs $0xffff80000011c158,%rax
ffff80000010b0f0:	80 ff ff 
ffff80000010b0f3:	48 8b 00             	mov    (%rax),%rax
ffff80000010b0f6:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b0fb:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b100:	48 89 c7             	mov    %rax,%rdi
ffff80000010b103:	48 b8 ce 7a 10 00 00 	movabs $0xffff800000107ace,%rax
ffff80000010b10a:	80 ff ff 
ffff80000010b10d:	ff d0                	call   *%rax

  // the kernel memory region starts at KERNBASE and up
  // allocate one PDPT at the bottom of that range.
  kpdpt = (pde_t*) kalloc();
ffff80000010b10f:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010b116:	80 ff ff 
ffff80000010b119:	ff d0                	call   *%rax
ffff80000010b11b:	48 ba 60 c1 11 00 00 	movabs $0xffff80000011c160,%rdx
ffff80000010b122:	80 ff ff 
ffff80000010b125:	48 89 02             	mov    %rax,(%rdx)
  memset(kpdpt, 0, PGSIZE);
ffff80000010b128:	48 b8 60 c1 11 00 00 	movabs $0xffff80000011c160,%rax
ffff80000010b12f:	80 ff ff 
ffff80000010b132:	48 8b 00             	mov    (%rax),%rax
ffff80000010b135:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b13a:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b13f:	48 89 c7             	mov    %rax,%rdi
ffff80000010b142:	48 b8 ce 7a 10 00 00 	movabs $0xffff800000107ace,%rax
ffff80000010b149:	80 ff ff 
ffff80000010b14c:	ff d0                	call   *%rax
  kpml4[PMX(KERNBASE)] = v2p(kpdpt) | PTE_P | PTE_W;
ffff80000010b14e:	48 b8 60 c1 11 00 00 	movabs $0xffff80000011c160,%rax
ffff80000010b155:	80 ff ff 
ffff80000010b158:	48 8b 00             	mov    (%rax),%rax
ffff80000010b15b:	48 89 c7             	mov    %rax,%rdi
ffff80000010b15e:	48 b8 7b ab 10 00 00 	movabs $0xffff80000010ab7b,%rax
ffff80000010b165:	80 ff ff 
ffff80000010b168:	ff d0                	call   *%rax
ffff80000010b16a:	48 ba 58 c1 11 00 00 	movabs $0xffff80000011c158,%rdx
ffff80000010b171:	80 ff ff 
ffff80000010b174:	48 8b 12             	mov    (%rdx),%rdx
ffff80000010b177:	48 81 c2 00 08 00 00 	add    $0x800,%rdx
ffff80000010b17e:	48 83 c8 03          	or     $0x3,%rax
ffff80000010b182:	48 89 02             	mov    %rax,(%rdx)

  // direct map first GB of physical addresses to KERNBASE
  kpdpt[0] = 0 | PTE_PS | PTE_P | PTE_W;
ffff80000010b185:	48 b8 60 c1 11 00 00 	movabs $0xffff80000011c160,%rax
ffff80000010b18c:	80 ff ff 
ffff80000010b18f:	48 8b 00             	mov    (%rax),%rax
ffff80000010b192:	48 c7 00 83 00 00 00 	movq   $0x83,(%rax)

  // direct map 4th GB of physical addresses to KERNBASE+3GB
  // this is a very lazy way to map IO memory (for lapic and ioapic)
  // PTE_PWT and PTE_PCD for memory mapped I/O correctness.
  kpdpt[3] = 0xC0000000 | PTE_PS | PTE_P | PTE_W | PTE_PWT | PTE_PCD;
ffff80000010b199:	48 b8 60 c1 11 00 00 	movabs $0xffff80000011c160,%rax
ffff80000010b1a0:	80 ff ff 
ffff80000010b1a3:	48 8b 00             	mov    (%rax),%rax
ffff80000010b1a6:	48 83 c0 18          	add    $0x18,%rax
ffff80000010b1aa:	b9 9b 00 00 c0       	mov    $0xc000009b,%ecx
ffff80000010b1af:	48 89 08             	mov    %rcx,(%rax)

  switchkvm();
ffff80000010b1b2:	48 b8 cd b4 10 00 00 	movabs $0xffff80000010b4cd,%rax
ffff80000010b1b9:	80 ff ff 
ffff80000010b1bc:	ff d0                	call   *%rax
}
ffff80000010b1be:	90                   	nop
ffff80000010b1bf:	5d                   	pop    %rbp
ffff80000010b1c0:	c3                   	ret

ffff80000010b1c1 <switchuvm>:

void
switchuvm(struct proc *p)
{
ffff80000010b1c1:	55                   	push   %rbp
ffff80000010b1c2:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b1c5:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010b1c9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  pushcli();
ffff80000010b1cd:	48 b8 5a 79 10 00 00 	movabs $0xffff80000010795a,%rax
ffff80000010b1d4:	80 ff ff 
ffff80000010b1d7:	ff d0                	call   *%rax
  if(p->pgdir == 0)
ffff80000010b1d9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b1dd:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010b1e1:	48 85 c0             	test   %rax,%rax
ffff80000010b1e4:	75 19                	jne    ffff80000010b1ff <switchuvm+0x3e>
    panic("switchuvm: no pgdir");
ffff80000010b1e6:	48 b8 e8 c5 10 00 00 	movabs $0xffff80000010c5e8,%rax
ffff80000010b1ed:	80 ff ff 
ffff80000010b1f0:	48 89 c7             	mov    %rax,%rdi
ffff80000010b1f3:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010b1fa:	80 ff ff 
ffff80000010b1fd:	ff d0                	call   *%rax
  uint *tss = (uint*) (((char*) cpu->local) + 1024);
ffff80000010b1ff:	64 48 8b 04 25 f0 ff 	mov    %fs:0xfffffffffffffff0,%rax
ffff80000010b206:	ff ff 
ffff80000010b208:	48 8b 40 20          	mov    0x20(%rax),%rax
ffff80000010b20c:	48 05 00 04 00 00    	add    $0x400,%rax
ffff80000010b212:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  const addr_t stktop = (addr_t)p->kstack + KSTACKSIZE;
ffff80000010b216:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b21a:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff80000010b21e:	48 05 00 10 00 00    	add    $0x1000,%rax
ffff80000010b224:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  tss[1] = (uint)stktop; // https://wiki.osdev.org/Task_State_Segment
ffff80000010b228:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b22c:	48 83 c0 04          	add    $0x4,%rax
ffff80000010b230:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff80000010b234:	89 10                	mov    %edx,(%rax)
  tss[2] = (uint)(stktop >> 32);
ffff80000010b236:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b23a:	48 c1 e8 20          	shr    $0x20,%rax
ffff80000010b23e:	48 89 c2             	mov    %rax,%rdx
ffff80000010b241:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b245:	48 83 c0 08          	add    $0x8,%rax
ffff80000010b249:	89 10                	mov    %edx,(%rax)
  lcr3(v2p(p->pgdir));
ffff80000010b24b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b24f:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010b253:	48 89 c7             	mov    %rax,%rdi
ffff80000010b256:	48 b8 7b ab 10 00 00 	movabs $0xffff80000010ab7b,%rax
ffff80000010b25d:	80 ff ff 
ffff80000010b260:	ff d0                	call   *%rax
ffff80000010b262:	48 89 c7             	mov    %rax,%rdi
ffff80000010b265:	48 b8 65 ab 10 00 00 	movabs $0xffff80000010ab65,%rax
ffff80000010b26c:	80 ff ff 
ffff80000010b26f:	ff d0                	call   *%rax
  popcli();
ffff80000010b271:	48 b8 c8 79 10 00 00 	movabs $0xffff8000001079c8,%rax
ffff80000010b278:	80 ff ff 
ffff80000010b27b:	ff d0                	call   *%rax
}
ffff80000010b27d:	90                   	nop
ffff80000010b27e:	c9                   	leave
ffff80000010b27f:	c3                   	ret

ffff80000010b280 <walkpgdir>:
// In 64-bit mode, the page table has four levels: PML4, PDPT, PD and PT
// For each level, we dereference the correct entry, or allocate and
// initialize entry if the PTE_P bit is not set
static pte_t *
walkpgdir(pde_t *pml4, const void *va, int alloc)
{
ffff80000010b280:	55                   	push   %rbp
ffff80000010b281:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b284:	48 83 ec 50          	sub    $0x50,%rsp
ffff80000010b288:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
ffff80000010b28c:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
ffff80000010b290:	89 55 bc             	mov    %edx,-0x44(%rbp)
  pml4e_t *pml4e;
  pdpe_t *pdp, *pdpe;
  pde_t *pde, *pd, *pgtab;

  // from the PML4, find or allocate the appropriate PDP table
  pml4e = &pml4[PMX(va)];
ffff80000010b293:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010b297:	48 c1 e8 27          	shr    $0x27,%rax
ffff80000010b29b:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010b2a0:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010b2a7:	00 
ffff80000010b2a8:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010b2ac:	48 01 d0             	add    %rdx,%rax
ffff80000010b2af:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  if(*pml4e & PTE_P)
ffff80000010b2b3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010b2b7:	48 8b 00             	mov    (%rax),%rax
ffff80000010b2ba:	83 e0 01             	and    $0x1,%eax
ffff80000010b2bd:	48 85 c0             	test   %rax,%rax
ffff80000010b2c0:	74 23                	je     ffff80000010b2e5 <walkpgdir+0x65>
    pdp = (pdpe_t*)P2V(PTE_ADDR(*pml4e));
ffff80000010b2c2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010b2c6:	48 8b 00             	mov    (%rax),%rax
ffff80000010b2c9:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b2cf:	48 89 c2             	mov    %rax,%rdx
ffff80000010b2d2:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010b2d9:	80 ff ff 
ffff80000010b2dc:	48 01 d0             	add    %rdx,%rax
ffff80000010b2df:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010b2e3:	eb 63                	jmp    ffff80000010b348 <walkpgdir+0xc8>
  else {
    if(!alloc || (pdp = (pdpe_t*)kalloc()) == 0)
ffff80000010b2e5:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
ffff80000010b2e9:	74 17                	je     ffff80000010b302 <walkpgdir+0x82>
ffff80000010b2eb:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010b2f2:	80 ff ff 
ffff80000010b2f5:	ff d0                	call   *%rax
ffff80000010b2f7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010b2fb:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff80000010b300:	75 0a                	jne    ffff80000010b30c <walkpgdir+0x8c>
      return 0;
ffff80000010b302:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010b307:	e9 bf 01 00 00       	jmp    ffff80000010b4cb <walkpgdir+0x24b>
    memset(pdp, 0, PGSIZE);
ffff80000010b30c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b310:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b315:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b31a:	48 89 c7             	mov    %rax,%rdi
ffff80000010b31d:	48 b8 ce 7a 10 00 00 	movabs $0xffff800000107ace,%rax
ffff80000010b324:	80 ff ff 
ffff80000010b327:	ff d0                	call   *%rax
    *pml4e = V2P(pdp) | PTE_P | PTE_W | PTE_U;
ffff80000010b329:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b32d:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010b334:	80 00 00 
ffff80000010b337:	48 01 d0             	add    %rdx,%rax
ffff80000010b33a:	48 83 c8 07          	or     $0x7,%rax
ffff80000010b33e:	48 89 c2             	mov    %rax,%rdx
ffff80000010b341:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010b345:	48 89 10             	mov    %rdx,(%rax)
  }

  //from the PDP, find or allocate the appropriate PD (page directory)
  pdpe = &pdp[PDPX(va)];
ffff80000010b348:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010b34c:	48 c1 e8 1e          	shr    $0x1e,%rax
ffff80000010b350:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010b355:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010b35c:	00 
ffff80000010b35d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b361:	48 01 d0             	add    %rdx,%rax
ffff80000010b364:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  if(*pdpe & PTE_P)
ffff80000010b368:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b36c:	48 8b 00             	mov    (%rax),%rax
ffff80000010b36f:	83 e0 01             	and    $0x1,%eax
ffff80000010b372:	48 85 c0             	test   %rax,%rax
ffff80000010b375:	74 23                	je     ffff80000010b39a <walkpgdir+0x11a>
    pd = (pde_t*)P2V(PTE_ADDR(*pdpe));
ffff80000010b377:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b37b:	48 8b 00             	mov    (%rax),%rax
ffff80000010b37e:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b384:	48 89 c2             	mov    %rax,%rdx
ffff80000010b387:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010b38e:	80 ff ff 
ffff80000010b391:	48 01 d0             	add    %rdx,%rax
ffff80000010b394:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010b398:	eb 63                	jmp    ffff80000010b3fd <walkpgdir+0x17d>
  else {
    if(!alloc || (pd = (pde_t*)kalloc()) == 0)//allocate page table
ffff80000010b39a:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
ffff80000010b39e:	74 17                	je     ffff80000010b3b7 <walkpgdir+0x137>
ffff80000010b3a0:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010b3a7:	80 ff ff 
ffff80000010b3aa:	ff d0                	call   *%rax
ffff80000010b3ac:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010b3b0:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010b3b5:	75 0a                	jne    ffff80000010b3c1 <walkpgdir+0x141>
      return 0;
ffff80000010b3b7:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010b3bc:	e9 0a 01 00 00       	jmp    ffff80000010b4cb <walkpgdir+0x24b>
    memset(pd, 0, PGSIZE);
ffff80000010b3c1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b3c5:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b3ca:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b3cf:	48 89 c7             	mov    %rax,%rdi
ffff80000010b3d2:	48 b8 ce 7a 10 00 00 	movabs $0xffff800000107ace,%rax
ffff80000010b3d9:	80 ff ff 
ffff80000010b3dc:	ff d0                	call   *%rax
    *pdpe = V2P(pd) | PTE_P | PTE_W | PTE_U;
ffff80000010b3de:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b3e2:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010b3e9:	80 00 00 
ffff80000010b3ec:	48 01 d0             	add    %rdx,%rax
ffff80000010b3ef:	48 83 c8 07          	or     $0x7,%rax
ffff80000010b3f3:	48 89 c2             	mov    %rax,%rdx
ffff80000010b3f6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b3fa:	48 89 10             	mov    %rdx,(%rax)
  }

  // from the PD, find or allocate the appropriate page table
  pde = &pd[PDX(va)];
ffff80000010b3fd:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010b401:	48 c1 e8 15          	shr    $0x15,%rax
ffff80000010b405:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010b40a:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010b411:	00 
ffff80000010b412:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b416:	48 01 d0             	add    %rdx,%rax
ffff80000010b419:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  if(*pde & PTE_P)
ffff80000010b41d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010b421:	48 8b 00             	mov    (%rax),%rax
ffff80000010b424:	83 e0 01             	and    $0x1,%eax
ffff80000010b427:	48 85 c0             	test   %rax,%rax
ffff80000010b42a:	74 23                	je     ffff80000010b44f <walkpgdir+0x1cf>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
ffff80000010b42c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010b430:	48 8b 00             	mov    (%rax),%rax
ffff80000010b433:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b439:	48 89 c2             	mov    %rax,%rdx
ffff80000010b43c:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010b443:	80 ff ff 
ffff80000010b446:	48 01 d0             	add    %rdx,%rax
ffff80000010b449:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010b44d:	eb 60                	jmp    ffff80000010b4af <walkpgdir+0x22f>
  else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)//allocate page table
ffff80000010b44f:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
ffff80000010b453:	74 17                	je     ffff80000010b46c <walkpgdir+0x1ec>
ffff80000010b455:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010b45c:	80 ff ff 
ffff80000010b45f:	ff d0                	call   *%rax
ffff80000010b461:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010b465:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010b46a:	75 07                	jne    ffff80000010b473 <walkpgdir+0x1f3>
      return 0;
ffff80000010b46c:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010b471:	eb 58                	jmp    ffff80000010b4cb <walkpgdir+0x24b>
    memset(pgtab, 0, PGSIZE);
ffff80000010b473:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b477:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b47c:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b481:	48 89 c7             	mov    %rax,%rdi
ffff80000010b484:	48 b8 ce 7a 10 00 00 	movabs $0xffff800000107ace,%rax
ffff80000010b48b:	80 ff ff 
ffff80000010b48e:	ff d0                	call   *%rax
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
ffff80000010b490:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b494:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010b49b:	80 00 00 
ffff80000010b49e:	48 01 d0             	add    %rdx,%rax
ffff80000010b4a1:	48 83 c8 07          	or     $0x7,%rax
ffff80000010b4a5:	48 89 c2             	mov    %rax,%rdx
ffff80000010b4a8:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010b4ac:	48 89 10             	mov    %rdx,(%rax)
  }

  return &pgtab[PTX(va)];
ffff80000010b4af:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010b4b3:	48 c1 e8 0c          	shr    $0xc,%rax
ffff80000010b4b7:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010b4bc:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010b4c3:	00 
ffff80000010b4c4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b4c8:	48 01 d0             	add    %rdx,%rax
}
ffff80000010b4cb:	c9                   	leave
ffff80000010b4cc:	c3                   	ret

ffff80000010b4cd <switchkvm>:

void
switchkvm(void)
{
ffff80000010b4cd:	55                   	push   %rbp
ffff80000010b4ce:	48 89 e5             	mov    %rsp,%rbp
  lcr3(v2p(kpml4));
ffff80000010b4d1:	48 b8 58 c1 11 00 00 	movabs $0xffff80000011c158,%rax
ffff80000010b4d8:	80 ff ff 
ffff80000010b4db:	48 8b 00             	mov    (%rax),%rax
ffff80000010b4de:	48 89 c7             	mov    %rax,%rdi
ffff80000010b4e1:	48 b8 7b ab 10 00 00 	movabs $0xffff80000010ab7b,%rax
ffff80000010b4e8:	80 ff ff 
ffff80000010b4eb:	ff d0                	call   *%rax
ffff80000010b4ed:	48 89 c7             	mov    %rax,%rdi
ffff80000010b4f0:	48 b8 65 ab 10 00 00 	movabs $0xffff80000010ab65,%rax
ffff80000010b4f7:	80 ff ff 
ffff80000010b4fa:	ff d0                	call   *%rax
}
ffff80000010b4fc:	90                   	nop
ffff80000010b4fd:	5d                   	pop    %rbp
ffff80000010b4fe:	c3                   	ret

ffff80000010b4ff <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
int
mappages(pde_t *pgdir, void *va, addr_t size, addr_t pa, int perm)
{
ffff80000010b4ff:	55                   	push   %rbp
ffff80000010b500:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b503:	48 83 ec 50          	sub    $0x50,%rsp
ffff80000010b507:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010b50b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010b50f:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
ffff80000010b513:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
ffff80000010b517:	44 89 45 bc          	mov    %r8d,-0x44(%rbp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((addr_t)va);
ffff80000010b51b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010b51f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b525:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  last = (char*)PGROUNDDOWN(((addr_t)va) + size - 1);
ffff80000010b529:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffff80000010b52d:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010b531:	48 01 d0             	add    %rdx,%rax
ffff80000010b534:	48 83 e8 01          	sub    $0x1,%rax
ffff80000010b538:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b53e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
ffff80000010b542:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff80000010b546:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b54a:	ba 01 00 00 00       	mov    $0x1,%edx
ffff80000010b54f:	48 89 ce             	mov    %rcx,%rsi
ffff80000010b552:	48 89 c7             	mov    %rax,%rdi
ffff80000010b555:	48 b8 80 b2 10 00 00 	movabs $0xffff80000010b280,%rax
ffff80000010b55c:	80 ff ff 
ffff80000010b55f:	ff d0                	call   *%rax
ffff80000010b561:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010b565:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010b56a:	75 07                	jne    ffff80000010b573 <mappages+0x74>
      return -1;
ffff80000010b56c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010b571:	eb 64                	jmp    ffff80000010b5d7 <mappages+0xd8>
    if(*pte & PTE_P)
ffff80000010b573:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b577:	48 8b 00             	mov    (%rax),%rax
ffff80000010b57a:	83 e0 01             	and    $0x1,%eax
ffff80000010b57d:	48 85 c0             	test   %rax,%rax
ffff80000010b580:	74 19                	je     ffff80000010b59b <mappages+0x9c>
      panic("remap");
ffff80000010b582:	48 b8 fc c5 10 00 00 	movabs $0xffff80000010c5fc,%rax
ffff80000010b589:	80 ff ff 
ffff80000010b58c:	48 89 c7             	mov    %rax,%rdi
ffff80000010b58f:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010b596:	80 ff ff 
ffff80000010b599:	ff d0                	call   *%rax
    *pte = pa | perm | PTE_P;
ffff80000010b59b:	8b 45 bc             	mov    -0x44(%rbp),%eax
ffff80000010b59e:	48 98                	cltq
ffff80000010b5a0:	48 0b 45 c0          	or     -0x40(%rbp),%rax
ffff80000010b5a4:	48 83 c8 01          	or     $0x1,%rax
ffff80000010b5a8:	48 89 c2             	mov    %rax,%rdx
ffff80000010b5ab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b5af:	48 89 10             	mov    %rdx,(%rax)
    if(a == last)
ffff80000010b5b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b5b6:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
ffff80000010b5ba:	74 15                	je     ffff80000010b5d1 <mappages+0xd2>
      break;
    a += PGSIZE;
ffff80000010b5bc:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffff80000010b5c3:	00 
    pa += PGSIZE;
ffff80000010b5c4:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
ffff80000010b5cb:	00 
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
ffff80000010b5cc:	e9 71 ff ff ff       	jmp    ffff80000010b542 <mappages+0x43>
      break;
ffff80000010b5d1:	90                   	nop
  }
  return 0;
ffff80000010b5d2:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010b5d7:	c9                   	leave
ffff80000010b5d8:	c3                   	ret

ffff80000010b5d9 <inituvm>:

// Load the initcode into address 0x1000 (4KB) of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
ffff80000010b5d9:	55                   	push   %rbp
ffff80000010b5da:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b5dd:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010b5e1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010b5e5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff80000010b5e9:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *mem;

  if(sz >= PGSIZE)
ffff80000010b5ec:	81 7d dc ff 0f 00 00 	cmpl   $0xfff,-0x24(%rbp)
ffff80000010b5f3:	76 19                	jbe    ffff80000010b60e <inituvm+0x35>
    panic("inituvm: more than a page");
ffff80000010b5f5:	48 b8 02 c6 10 00 00 	movabs $0xffff80000010c602,%rax
ffff80000010b5fc:	80 ff ff 
ffff80000010b5ff:	48 89 c7             	mov    %rax,%rdi
ffff80000010b602:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010b609:	80 ff ff 
ffff80000010b60c:	ff d0                	call   *%rax

  mem = kalloc();
ffff80000010b60e:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010b615:	80 ff ff 
ffff80000010b618:	ff d0                	call   *%rax
ffff80000010b61a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(mem, 0, PGSIZE);
ffff80000010b61e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b622:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b627:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b62c:	48 89 c7             	mov    %rax,%rdi
ffff80000010b62f:	48 b8 ce 7a 10 00 00 	movabs $0xffff800000107ace,%rax
ffff80000010b636:	80 ff ff 
ffff80000010b639:	ff d0                	call   *%rax
  mappages(pgdir, (void *)PGSIZE, PGSIZE, V2P(mem), PTE_W|PTE_U);
ffff80000010b63b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b63f:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010b646:	80 00 00 
ffff80000010b649:	48 01 c2             	add    %rax,%rdx
ffff80000010b64c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b650:	41 b8 06 00 00 00    	mov    $0x6,%r8d
ffff80000010b656:	48 89 d1             	mov    %rdx,%rcx
ffff80000010b659:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b65e:	be 00 10 00 00       	mov    $0x1000,%esi
ffff80000010b663:	48 89 c7             	mov    %rax,%rdi
ffff80000010b666:	48 b8 ff b4 10 00 00 	movabs $0xffff80000010b4ff,%rax
ffff80000010b66d:	80 ff ff 
ffff80000010b670:	ff d0                	call   *%rax

  memmove(mem, init, sz);
ffff80000010b672:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffff80000010b675:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff80000010b679:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b67d:	48 89 ce             	mov    %rcx,%rsi
ffff80000010b680:	48 89 c7             	mov    %rax,%rdi
ffff80000010b683:	48 b8 d3 7b 10 00 00 	movabs $0xffff800000107bd3,%rax
ffff80000010b68a:	80 ff ff 
ffff80000010b68d:	ff d0                	call   *%rax
}
ffff80000010b68f:	90                   	nop
ffff80000010b690:	c9                   	leave
ffff80000010b691:	c3                   	ret

ffff80000010b692 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
ffff80000010b692:	55                   	push   %rbp
ffff80000010b693:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b696:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010b69a:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010b69e:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010b6a2:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
ffff80000010b6a6:	89 4d c4             	mov    %ecx,-0x3c(%rbp)
ffff80000010b6a9:	44 89 45 c0          	mov    %r8d,-0x40(%rbp)
  uint i, n;
  addr_t pa;
  pte_t *pte;

  if((addr_t) addr % PGSIZE != 0)
ffff80000010b6ad:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010b6b1:	25 ff 0f 00 00       	and    $0xfff,%eax
ffff80000010b6b6:	48 85 c0             	test   %rax,%rax
ffff80000010b6b9:	74 19                	je     ffff80000010b6d4 <loaduvm+0x42>
    panic("loaduvm: addr must be page aligned");
ffff80000010b6bb:	48 b8 20 c6 10 00 00 	movabs $0xffff80000010c620,%rax
ffff80000010b6c2:	80 ff ff 
ffff80000010b6c5:	48 89 c7             	mov    %rax,%rdi
ffff80000010b6c8:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010b6cf:	80 ff ff 
ffff80000010b6d2:	ff d0                	call   *%rax
  for(i = 0; i < sz; i += PGSIZE){
ffff80000010b6d4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010b6db:	e9 c7 00 00 00       	jmp    ffff80000010b7a7 <loaduvm+0x115>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
ffff80000010b6e0:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010b6e3:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010b6e7:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffff80000010b6eb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b6ef:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010b6f4:	48 89 ce             	mov    %rcx,%rsi
ffff80000010b6f7:	48 89 c7             	mov    %rax,%rdi
ffff80000010b6fa:	48 b8 80 b2 10 00 00 	movabs $0xffff80000010b280,%rax
ffff80000010b701:	80 ff ff 
ffff80000010b704:	ff d0                	call   *%rax
ffff80000010b706:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010b70a:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010b70f:	75 19                	jne    ffff80000010b72a <loaduvm+0x98>
      panic("loaduvm: address should exist");
ffff80000010b711:	48 b8 43 c6 10 00 00 	movabs $0xffff80000010c643,%rax
ffff80000010b718:	80 ff ff 
ffff80000010b71b:	48 89 c7             	mov    %rax,%rdi
ffff80000010b71e:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010b725:	80 ff ff 
ffff80000010b728:	ff d0                	call   *%rax
    pa = PTE_ADDR(*pte);
ffff80000010b72a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b72e:	48 8b 00             	mov    (%rax),%rax
ffff80000010b731:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b737:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if(sz - i < PGSIZE)
ffff80000010b73b:	8b 45 c0             	mov    -0x40(%rbp),%eax
ffff80000010b73e:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff80000010b741:	3d ff 0f 00 00       	cmp    $0xfff,%eax
ffff80000010b746:	77 0b                	ja     ffff80000010b753 <loaduvm+0xc1>
      n = sz - i;
ffff80000010b748:	8b 45 c0             	mov    -0x40(%rbp),%eax
ffff80000010b74b:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff80000010b74e:	89 45 f8             	mov    %eax,-0x8(%rbp)
ffff80000010b751:	eb 07                	jmp    ffff80000010b75a <loaduvm+0xc8>
    else
      n = PGSIZE;
ffff80000010b753:	c7 45 f8 00 10 00 00 	movl   $0x1000,-0x8(%rbp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
ffff80000010b75a:	8b 55 c4             	mov    -0x3c(%rbp),%edx
ffff80000010b75d:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010b760:	8d 34 02             	lea    (%rdx,%rax,1),%esi
ffff80000010b763:	48 ba 00 00 00 00 00 	movabs $0xffff800000000000,%rdx
ffff80000010b76a:	80 ff ff 
ffff80000010b76d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b771:	48 01 d0             	add    %rdx,%rax
ffff80000010b774:	48 89 c7             	mov    %rax,%rdi
ffff80000010b777:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffff80000010b77a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010b77e:	89 d1                	mov    %edx,%ecx
ffff80000010b780:	89 f2                	mov    %esi,%edx
ffff80000010b782:	48 89 fe             	mov    %rdi,%rsi
ffff80000010b785:	48 89 c7             	mov    %rax,%rdi
ffff80000010b788:	48 b8 f5 2e 10 00 00 	movabs $0xffff800000102ef5,%rax
ffff80000010b78f:	80 ff ff 
ffff80000010b792:	ff d0                	call   *%rax
ffff80000010b794:	39 45 f8             	cmp    %eax,-0x8(%rbp)
ffff80000010b797:	74 07                	je     ffff80000010b7a0 <loaduvm+0x10e>
      return -1;
ffff80000010b799:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010b79e:	eb 18                	jmp    ffff80000010b7b8 <loaduvm+0x126>
  for(i = 0; i < sz; i += PGSIZE){
ffff80000010b7a0:	81 45 fc 00 10 00 00 	addl   $0x1000,-0x4(%rbp)
ffff80000010b7a7:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010b7aa:	3b 45 c0             	cmp    -0x40(%rbp),%eax
ffff80000010b7ad:	0f 82 2d ff ff ff    	jb     ffff80000010b6e0 <loaduvm+0x4e>
  }
  return 0;
ffff80000010b7b3:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010b7b8:	c9                   	leave
ffff80000010b7b9:	c3                   	ret

ffff80000010b7ba <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
uint64
allocuvm(pde_t *pgdir, uint64 oldsz, uint64 newsz)
{
ffff80000010b7ba:	55                   	push   %rbp
ffff80000010b7bb:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b7be:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010b7c2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010b7c6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff80000010b7ca:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  char *mem;
  addr_t a;

  if(newsz >= KERNBASE)
ffff80000010b7ce:	48 b8 ff ff ff ff ff 	movabs $0xffff7fffffffffff,%rax
ffff80000010b7d5:	7f ff ff 
ffff80000010b7d8:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
ffff80000010b7dc:	73 0a                	jae    ffff80000010b7e8 <allocuvm+0x2e>
    return 0;
ffff80000010b7de:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010b7e3:	e9 14 01 00 00       	jmp    ffff80000010b8fc <allocuvm+0x142>
  if(newsz < oldsz)
ffff80000010b7e8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b7ec:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
ffff80000010b7f0:	73 09                	jae    ffff80000010b7fb <allocuvm+0x41>
    return oldsz;
ffff80000010b7f2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010b7f6:	e9 01 01 00 00       	jmp    ffff80000010b8fc <allocuvm+0x142>

  a = PGROUNDUP(oldsz);
ffff80000010b7fb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010b7ff:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffff80000010b805:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b80b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  for(; a < newsz; a += PGSIZE){
ffff80000010b80f:	e9 d6 00 00 00       	jmp    ffff80000010b8ea <allocuvm+0x130>
    mem = kalloc();
ffff80000010b814:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010b81b:	80 ff ff 
ffff80000010b81e:	ff d0                	call   *%rax
ffff80000010b820:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if(mem == 0){
ffff80000010b824:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010b829:	75 28                	jne    ffff80000010b853 <allocuvm+0x99>
      //cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
ffff80000010b82b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff80000010b82f:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff80000010b833:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b837:	48 89 ce             	mov    %rcx,%rsi
ffff80000010b83a:	48 89 c7             	mov    %rax,%rdi
ffff80000010b83d:	48 b8 fe b8 10 00 00 	movabs $0xffff80000010b8fe,%rax
ffff80000010b844:	80 ff ff 
ffff80000010b847:	ff d0                	call   *%rax
      return 0;
ffff80000010b849:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010b84e:	e9 a9 00 00 00       	jmp    ffff80000010b8fc <allocuvm+0x142>
    }
    memset(mem, 0, PGSIZE);
ffff80000010b853:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b857:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b85c:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b861:	48 89 c7             	mov    %rax,%rdi
ffff80000010b864:	48 b8 ce 7a 10 00 00 	movabs $0xffff800000107ace,%rax
ffff80000010b86b:	80 ff ff 
ffff80000010b86e:	ff d0                	call   *%rax
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
ffff80000010b870:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b874:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010b87b:	80 00 00 
ffff80000010b87e:	48 01 c2             	add    %rax,%rdx
ffff80000010b881:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
ffff80000010b885:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b889:	41 b8 06 00 00 00    	mov    $0x6,%r8d
ffff80000010b88f:	48 89 d1             	mov    %rdx,%rcx
ffff80000010b892:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b897:	48 89 c7             	mov    %rax,%rdi
ffff80000010b89a:	48 b8 ff b4 10 00 00 	movabs $0xffff80000010b4ff,%rax
ffff80000010b8a1:	80 ff ff 
ffff80000010b8a4:	ff d0                	call   *%rax
ffff80000010b8a6:	85 c0                	test   %eax,%eax
ffff80000010b8a8:	79 38                	jns    ffff80000010b8e2 <allocuvm+0x128>
      //cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
ffff80000010b8aa:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff80000010b8ae:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff80000010b8b2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b8b6:	48 89 ce             	mov    %rcx,%rsi
ffff80000010b8b9:	48 89 c7             	mov    %rax,%rdi
ffff80000010b8bc:	48 b8 fe b8 10 00 00 	movabs $0xffff80000010b8fe,%rax
ffff80000010b8c3:	80 ff ff 
ffff80000010b8c6:	ff d0                	call   *%rax
      kfree(mem);
ffff80000010b8c8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b8cc:	48 89 c7             	mov    %rax,%rdi
ffff80000010b8cf:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff80000010b8d6:	80 ff ff 
ffff80000010b8d9:	ff d0                	call   *%rax
      return 0;
ffff80000010b8db:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010b8e0:	eb 1a                	jmp    ffff80000010b8fc <allocuvm+0x142>
  for(; a < newsz; a += PGSIZE){
ffff80000010b8e2:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffff80000010b8e9:	00 
ffff80000010b8ea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b8ee:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
ffff80000010b8f2:	0f 82 1c ff ff ff    	jb     ffff80000010b814 <allocuvm+0x5a>
    }
  }
  return newsz;
ffff80000010b8f8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
}
ffff80000010b8fc:	c9                   	leave
ffff80000010b8fd:	c3                   	ret

ffff80000010b8fe <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
deallocuvm(pde_t *pgdir, uint64 oldsz, uint64 newsz)
{
ffff80000010b8fe:	55                   	push   %rbp
ffff80000010b8ff:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b902:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010b906:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010b90a:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010b90e:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  pte_t *pte;
  addr_t a, pa;

  if(newsz >= oldsz)
ffff80000010b912:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010b916:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
ffff80000010b91a:	72 09                	jb     ffff80000010b925 <deallocuvm+0x27>
    return oldsz;
ffff80000010b91c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010b920:	e9 d0 00 00 00       	jmp    ffff80000010b9f5 <deallocuvm+0xf7>

  a = PGROUNDUP(newsz);
ffff80000010b925:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010b929:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffff80000010b92f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b935:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  for(; a  < oldsz; a += PGSIZE){
ffff80000010b939:	e9 a5 00 00 00       	jmp    ffff80000010b9e3 <deallocuvm+0xe5>
    pte = walkpgdir(pgdir, (char*)a, 0);
ffff80000010b93e:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff80000010b942:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b946:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010b94b:	48 89 ce             	mov    %rcx,%rsi
ffff80000010b94e:	48 89 c7             	mov    %rax,%rdi
ffff80000010b951:	48 b8 80 b2 10 00 00 	movabs $0xffff80000010b280,%rax
ffff80000010b958:	80 ff ff 
ffff80000010b95b:	ff d0                	call   *%rax
ffff80000010b95d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if(pte && (*pte & PTE_P) != 0){
ffff80000010b961:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010b966:	74 73                	je     ffff80000010b9db <deallocuvm+0xdd>
ffff80000010b968:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b96c:	48 8b 00             	mov    (%rax),%rax
ffff80000010b96f:	83 e0 01             	and    $0x1,%eax
ffff80000010b972:	48 85 c0             	test   %rax,%rax
ffff80000010b975:	74 64                	je     ffff80000010b9db <deallocuvm+0xdd>
      pa = PTE_ADDR(*pte);
ffff80000010b977:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b97b:	48 8b 00             	mov    (%rax),%rax
ffff80000010b97e:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b984:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
      if(pa == 0)
ffff80000010b988:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010b98d:	75 19                	jne    ffff80000010b9a8 <deallocuvm+0xaa>
        panic("kfree");
ffff80000010b98f:	48 b8 61 c6 10 00 00 	movabs $0xffff80000010c661,%rax
ffff80000010b996:	80 ff ff 
ffff80000010b999:	48 89 c7             	mov    %rax,%rdi
ffff80000010b99c:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010b9a3:	80 ff ff 
ffff80000010b9a6:	ff d0                	call   *%rax
      char *v = P2V(pa);
ffff80000010b9a8:	48 ba 00 00 00 00 00 	movabs $0xffff800000000000,%rdx
ffff80000010b9af:	80 ff ff 
ffff80000010b9b2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b9b6:	48 01 d0             	add    %rdx,%rax
ffff80000010b9b9:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
      kfree(v);
ffff80000010b9bd:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010b9c1:	48 89 c7             	mov    %rax,%rdi
ffff80000010b9c4:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff80000010b9cb:	80 ff ff 
ffff80000010b9ce:	ff d0                	call   *%rax
      *pte = 0;
ffff80000010b9d0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b9d4:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  for(; a  < oldsz; a += PGSIZE){
ffff80000010b9db:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffff80000010b9e2:	00 
ffff80000010b9e3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b9e7:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
ffff80000010b9eb:	0f 82 4d ff ff ff    	jb     ffff80000010b93e <deallocuvm+0x40>
    }
  }
  return newsz;
ffff80000010b9f1:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
}
ffff80000010b9f5:	c9                   	leave
ffff80000010b9f6:	c3                   	ret

ffff80000010b9f7 <freevm>:

// Free all the pages mapped by, and all the memory used for,
// this page table
void
freevm(pml4e_t *pml4)
{
ffff80000010b9f7:	55                   	push   %rbp
ffff80000010b9f8:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b9fb:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010b9ff:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  uint i, j, k, l;
  pde_t *pdp, *pd, *pt;

  if(pml4 == 0)
ffff80000010ba03:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
ffff80000010ba08:	75 19                	jne    ffff80000010ba23 <freevm+0x2c>
    panic("freevm: no pgdir");
ffff80000010ba0a:	48 b8 67 c6 10 00 00 	movabs $0xffff80000010c667,%rax
ffff80000010ba11:	80 ff ff 
ffff80000010ba14:	48 89 c7             	mov    %rax,%rdi
ffff80000010ba17:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010ba1e:	80 ff ff 
ffff80000010ba21:	ff d0                	call   *%rax

  // then need to loop through pml4 entry
  for(i = 0; i < (NPDENTRIES/2); i++){
ffff80000010ba23:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010ba2a:	e9 dc 01 00 00       	jmp    ffff80000010bc0b <freevm+0x214>
    if(pml4[i] & PTE_P){
ffff80000010ba2f:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010ba32:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010ba39:	00 
ffff80000010ba3a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010ba3e:	48 01 d0             	add    %rdx,%rax
ffff80000010ba41:	48 8b 00             	mov    (%rax),%rax
ffff80000010ba44:	83 e0 01             	and    $0x1,%eax
ffff80000010ba47:	48 85 c0             	test   %rax,%rax
ffff80000010ba4a:	0f 84 b7 01 00 00    	je     ffff80000010bc07 <freevm+0x210>
      pdp = (pdpe_t*)P2V(PTE_ADDR(pml4[i]));
ffff80000010ba50:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010ba53:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010ba5a:	00 
ffff80000010ba5b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010ba5f:	48 01 d0             	add    %rdx,%rax
ffff80000010ba62:	48 8b 00             	mov    (%rax),%rax
ffff80000010ba65:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010ba6b:	48 89 c2             	mov    %rax,%rdx
ffff80000010ba6e:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010ba75:	80 ff ff 
ffff80000010ba78:	48 01 d0             	add    %rdx,%rax
ffff80000010ba7b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

      // and every entry in the corresponding pdpt
      for(j = 0; j < NPDENTRIES; j++){
ffff80000010ba7f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
ffff80000010ba86:	e9 5c 01 00 00       	jmp    ffff80000010bbe7 <freevm+0x1f0>
        if(pdp[j] & PTE_P){
ffff80000010ba8b:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff80000010ba8e:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010ba95:	00 
ffff80000010ba96:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010ba9a:	48 01 d0             	add    %rdx,%rax
ffff80000010ba9d:	48 8b 00             	mov    (%rax),%rax
ffff80000010baa0:	83 e0 01             	and    $0x1,%eax
ffff80000010baa3:	48 85 c0             	test   %rax,%rax
ffff80000010baa6:	0f 84 37 01 00 00    	je     ffff80000010bbe3 <freevm+0x1ec>
          pd = (pde_t*)P2V(PTE_ADDR(pdp[j]));
ffff80000010baac:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff80000010baaf:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010bab6:	00 
ffff80000010bab7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010babb:	48 01 d0             	add    %rdx,%rax
ffff80000010babe:	48 8b 00             	mov    (%rax),%rax
ffff80000010bac1:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010bac7:	48 89 c2             	mov    %rax,%rdx
ffff80000010baca:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010bad1:	80 ff ff 
ffff80000010bad4:	48 01 d0             	add    %rdx,%rax
ffff80000010bad7:	48 89 45 e0          	mov    %rax,-0x20(%rbp)

          // and every entry in the corresponding page directory
          for(k = 0; k < (NPDENTRIES); k++){
ffff80000010badb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
ffff80000010bae2:	e9 dc 00 00 00       	jmp    ffff80000010bbc3 <freevm+0x1cc>
            if(pd[k] & PTE_P) {
ffff80000010bae7:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff80000010baea:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010baf1:	00 
ffff80000010baf2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010baf6:	48 01 d0             	add    %rdx,%rax
ffff80000010baf9:	48 8b 00             	mov    (%rax),%rax
ffff80000010bafc:	83 e0 01             	and    $0x1,%eax
ffff80000010baff:	48 85 c0             	test   %rax,%rax
ffff80000010bb02:	0f 84 b7 00 00 00    	je     ffff80000010bbbf <freevm+0x1c8>
              pt = (pde_t*)P2V(PTE_ADDR(pd[k]));
ffff80000010bb08:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff80000010bb0b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010bb12:	00 
ffff80000010bb13:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010bb17:	48 01 d0             	add    %rdx,%rax
ffff80000010bb1a:	48 8b 00             	mov    (%rax),%rax
ffff80000010bb1d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010bb23:	48 89 c2             	mov    %rax,%rdx
ffff80000010bb26:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010bb2d:	80 ff ff 
ffff80000010bb30:	48 01 d0             	add    %rdx,%rax
ffff80000010bb33:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

              // and every entry in the corresponding page table
              for(l = 0; l < (NPDENTRIES); l++){
ffff80000010bb37:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
ffff80000010bb3e:	eb 63                	jmp    ffff80000010bba3 <freevm+0x1ac>
                if(pt[l] & PTE_P) {
ffff80000010bb40:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff80000010bb43:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010bb4a:	00 
ffff80000010bb4b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010bb4f:	48 01 d0             	add    %rdx,%rax
ffff80000010bb52:	48 8b 00             	mov    (%rax),%rax
ffff80000010bb55:	83 e0 01             	and    $0x1,%eax
ffff80000010bb58:	48 85 c0             	test   %rax,%rax
ffff80000010bb5b:	74 42                	je     ffff80000010bb9f <freevm+0x1a8>
                  char * v = P2V(PTE_ADDR(pt[l]));
ffff80000010bb5d:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff80000010bb60:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010bb67:	00 
ffff80000010bb68:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010bb6c:	48 01 d0             	add    %rdx,%rax
ffff80000010bb6f:	48 8b 00             	mov    (%rax),%rax
ffff80000010bb72:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010bb78:	48 89 c2             	mov    %rax,%rdx
ffff80000010bb7b:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010bb82:	80 ff ff 
ffff80000010bb85:	48 01 d0             	add    %rdx,%rax
ffff80000010bb88:	48 89 45 d0          	mov    %rax,-0x30(%rbp)

                  kfree((char*)v);
ffff80000010bb8c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010bb90:	48 89 c7             	mov    %rax,%rdi
ffff80000010bb93:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff80000010bb9a:	80 ff ff 
ffff80000010bb9d:	ff d0                	call   *%rax
              for(l = 0; l < (NPDENTRIES); l++){
ffff80000010bb9f:	83 45 f0 01          	addl   $0x1,-0x10(%rbp)
ffff80000010bba3:	81 7d f0 ff 01 00 00 	cmpl   $0x1ff,-0x10(%rbp)
ffff80000010bbaa:	76 94                	jbe    ffff80000010bb40 <freevm+0x149>
                }
              }
              //freeing every page table
              kfree((char*)pt);
ffff80000010bbac:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010bbb0:	48 89 c7             	mov    %rax,%rdi
ffff80000010bbb3:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff80000010bbba:	80 ff ff 
ffff80000010bbbd:	ff d0                	call   *%rax
          for(k = 0; k < (NPDENTRIES); k++){
ffff80000010bbbf:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
ffff80000010bbc3:	81 7d f4 ff 01 00 00 	cmpl   $0x1ff,-0xc(%rbp)
ffff80000010bbca:	0f 86 17 ff ff ff    	jbe    ffff80000010bae7 <freevm+0xf0>
            }
          }
          // freeing every page directory
          kfree((char*)pd);
ffff80000010bbd0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010bbd4:	48 89 c7             	mov    %rax,%rdi
ffff80000010bbd7:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff80000010bbde:	80 ff ff 
ffff80000010bbe1:	ff d0                	call   *%rax
      for(j = 0; j < NPDENTRIES; j++){
ffff80000010bbe3:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
ffff80000010bbe7:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
ffff80000010bbee:	0f 86 97 fe ff ff    	jbe    ffff80000010ba8b <freevm+0x94>
        }
      }
      // freeing every page directory pointer table
      kfree((char*)pdp);
ffff80000010bbf4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bbf8:	48 89 c7             	mov    %rax,%rdi
ffff80000010bbfb:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff80000010bc02:	80 ff ff 
ffff80000010bc05:	ff d0                	call   *%rax
  for(i = 0; i < (NPDENTRIES/2); i++){
ffff80000010bc07:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff80000010bc0b:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
ffff80000010bc12:	0f 86 17 fe ff ff    	jbe    ffff80000010ba2f <freevm+0x38>
    }
  }
  // freeing the pml4
  kfree((char*)pml4);
ffff80000010bc18:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010bc1c:	48 89 c7             	mov    %rax,%rdi
ffff80000010bc1f:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff80000010bc26:	80 ff ff 
ffff80000010bc29:	ff d0                	call   *%rax
}
ffff80000010bc2b:	90                   	nop
ffff80000010bc2c:	c9                   	leave
ffff80000010bc2d:	c3                   	ret

ffff80000010bc2e <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pml4e_t *pgdir, char *uva)
{
ffff80000010bc2e:	55                   	push   %rbp
ffff80000010bc2f:	48 89 e5             	mov    %rsp,%rbp
ffff80000010bc32:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010bc36:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010bc3a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
ffff80000010bc3e:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff80000010bc42:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bc46:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010bc4b:	48 89 ce             	mov    %rcx,%rsi
ffff80000010bc4e:	48 89 c7             	mov    %rax,%rdi
ffff80000010bc51:	48 b8 80 b2 10 00 00 	movabs $0xffff80000010b280,%rax
ffff80000010bc58:	80 ff ff 
ffff80000010bc5b:	ff d0                	call   *%rax
ffff80000010bc5d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(pte == 0)
ffff80000010bc61:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff80000010bc66:	75 19                	jne    ffff80000010bc81 <clearpteu+0x53>
    panic("clearpteu");
ffff80000010bc68:	48 b8 78 c6 10 00 00 	movabs $0xffff80000010c678,%rax
ffff80000010bc6f:	80 ff ff 
ffff80000010bc72:	48 89 c7             	mov    %rax,%rdi
ffff80000010bc75:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010bc7c:	80 ff ff 
ffff80000010bc7f:	ff d0                	call   *%rax
  *pte &= ~PTE_U;
ffff80000010bc81:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010bc85:	48 8b 00             	mov    (%rax),%rax
ffff80000010bc88:	48 83 e0 fb          	and    $0xfffffffffffffffb,%rax
ffff80000010bc8c:	48 89 c2             	mov    %rax,%rdx
ffff80000010bc8f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010bc93:	48 89 10             	mov    %rdx,(%rax)
}
ffff80000010bc96:	90                   	nop
ffff80000010bc97:	c9                   	leave
ffff80000010bc98:	c3                   	ret

ffff80000010bc99 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pml4e_t *pgdir, uint sz)
{
ffff80000010bc99:	55                   	push   %rbp
ffff80000010bc9a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010bc9d:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010bca1:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
ffff80000010bca5:	89 75 c4             	mov    %esi,-0x3c(%rbp)
  pde_t *d;
  pte_t *pte;
  addr_t pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
ffff80000010bca8:	48 b8 63 b0 10 00 00 	movabs $0xffff80000010b063,%rax
ffff80000010bcaf:	80 ff ff 
ffff80000010bcb2:	ff d0                	call   *%rax
ffff80000010bcb4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010bcb8:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010bcbd:	75 0a                	jne    ffff80000010bcc9 <copyuvm+0x30>
    return 0;
ffff80000010bcbf:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010bcc4:	e9 57 01 00 00       	jmp    ffff80000010be20 <copyuvm+0x187>
  for(i = PGSIZE; i < sz; i += PGSIZE){
ffff80000010bcc9:	48 c7 45 f8 00 10 00 	movq   $0x1000,-0x8(%rbp)
ffff80000010bcd0:	00 
ffff80000010bcd1:	e9 1b 01 00 00       	jmp    ffff80000010bdf1 <copyuvm+0x158>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
ffff80000010bcd6:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff80000010bcda:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010bcde:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010bce3:	48 89 ce             	mov    %rcx,%rsi
ffff80000010bce6:	48 89 c7             	mov    %rax,%rdi
ffff80000010bce9:	48 b8 80 b2 10 00 00 	movabs $0xffff80000010b280,%rax
ffff80000010bcf0:	80 ff ff 
ffff80000010bcf3:	ff d0                	call   *%rax
ffff80000010bcf5:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010bcf9:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010bcfe:	75 19                	jne    ffff80000010bd19 <copyuvm+0x80>
      panic("copyuvm: pte should exist");
ffff80000010bd00:	48 b8 82 c6 10 00 00 	movabs $0xffff80000010c682,%rax
ffff80000010bd07:	80 ff ff 
ffff80000010bd0a:	48 89 c7             	mov    %rax,%rdi
ffff80000010bd0d:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010bd14:	80 ff ff 
ffff80000010bd17:	ff d0                	call   *%rax
    if(!(*pte & PTE_P))
ffff80000010bd19:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bd1d:	48 8b 00             	mov    (%rax),%rax
ffff80000010bd20:	83 e0 01             	and    $0x1,%eax
ffff80000010bd23:	48 85 c0             	test   %rax,%rax
ffff80000010bd26:	75 19                	jne    ffff80000010bd41 <copyuvm+0xa8>
      panic("copyuvm: page not present");
ffff80000010bd28:	48 b8 9c c6 10 00 00 	movabs $0xffff80000010c69c,%rax
ffff80000010bd2f:	80 ff ff 
ffff80000010bd32:	48 89 c7             	mov    %rax,%rdi
ffff80000010bd35:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010bd3c:	80 ff ff 
ffff80000010bd3f:	ff d0                	call   *%rax
    pa = PTE_ADDR(*pte);
ffff80000010bd41:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bd45:	48 8b 00             	mov    (%rax),%rax
ffff80000010bd48:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010bd4e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    flags = PTE_FLAGS(*pte);
ffff80000010bd52:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bd56:	48 8b 00             	mov    (%rax),%rax
ffff80000010bd59:	25 ff 0f 00 00       	and    $0xfff,%eax
ffff80000010bd5e:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    if((mem = kalloc()) == 0)
ffff80000010bd62:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010bd69:	80 ff ff 
ffff80000010bd6c:	ff d0                	call   *%rax
ffff80000010bd6e:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
ffff80000010bd72:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
ffff80000010bd77:	0f 84 87 00 00 00    	je     ffff80000010be04 <copyuvm+0x16b>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
ffff80000010bd7d:	48 ba 00 00 00 00 00 	movabs $0xffff800000000000,%rdx
ffff80000010bd84:	80 ff ff 
ffff80000010bd87:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010bd8b:	48 01 d0             	add    %rdx,%rax
ffff80000010bd8e:	48 89 c1             	mov    %rax,%rcx
ffff80000010bd91:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010bd95:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010bd9a:	48 89 ce             	mov    %rcx,%rsi
ffff80000010bd9d:	48 89 c7             	mov    %rax,%rdi
ffff80000010bda0:	48 b8 d3 7b 10 00 00 	movabs $0xffff800000107bd3,%rax
ffff80000010bda7:	80 ff ff 
ffff80000010bdaa:	ff d0                	call   *%rax
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
ffff80000010bdac:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010bdb0:	89 c1                	mov    %eax,%ecx
ffff80000010bdb2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010bdb6:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010bdbd:	80 00 00 
ffff80000010bdc0:	48 01 c2             	add    %rax,%rdx
ffff80000010bdc3:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
ffff80000010bdc7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bdcb:	41 89 c8             	mov    %ecx,%r8d
ffff80000010bdce:	48 89 d1             	mov    %rdx,%rcx
ffff80000010bdd1:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010bdd6:	48 89 c7             	mov    %rax,%rdi
ffff80000010bdd9:	48 b8 ff b4 10 00 00 	movabs $0xffff80000010b4ff,%rax
ffff80000010bde0:	80 ff ff 
ffff80000010bde3:	ff d0                	call   *%rax
ffff80000010bde5:	85 c0                	test   %eax,%eax
ffff80000010bde7:	78 1e                	js     ffff80000010be07 <copyuvm+0x16e>
  for(i = PGSIZE; i < sz; i += PGSIZE){
ffff80000010bde9:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffff80000010bdf0:	00 
ffff80000010bdf1:	8b 45 c4             	mov    -0x3c(%rbp),%eax
ffff80000010bdf4:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff80000010bdf8:	0f 82 d8 fe ff ff    	jb     ffff80000010bcd6 <copyuvm+0x3d>
      goto bad;
  }
  return d;
ffff80000010bdfe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010be02:	eb 1c                	jmp    ffff80000010be20 <copyuvm+0x187>
      goto bad;
ffff80000010be04:	90                   	nop
ffff80000010be05:	eb 01                	jmp    ffff80000010be08 <copyuvm+0x16f>
      goto bad;
ffff80000010be07:	90                   	nop

bad:
  freevm(d);
ffff80000010be08:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010be0c:	48 89 c7             	mov    %rax,%rdi
ffff80000010be0f:	48 b8 f7 b9 10 00 00 	movabs $0xffff80000010b9f7,%rax
ffff80000010be16:	80 ff ff 
ffff80000010be19:	ff d0                	call   *%rax
  return 0;
ffff80000010be1b:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010be20:	c9                   	leave
ffff80000010be21:	c3                   	ret

ffff80000010be22 <uva2ka>:

// Map user virtual address to kernel address.
char*
uva2ka(pml4e_t *pgdir, char *uva)
{
ffff80000010be22:	55                   	push   %rbp
ffff80000010be23:	48 89 e5             	mov    %rsp,%rbp
ffff80000010be26:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010be2a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010be2e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
ffff80000010be32:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff80000010be36:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010be3a:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010be3f:	48 89 ce             	mov    %rcx,%rsi
ffff80000010be42:	48 89 c7             	mov    %rax,%rdi
ffff80000010be45:	48 b8 80 b2 10 00 00 	movabs $0xffff80000010b280,%rax
ffff80000010be4c:	80 ff ff 
ffff80000010be4f:	ff d0                	call   *%rax
ffff80000010be51:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if((*pte & PTE_P) == 0)
ffff80000010be55:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010be59:	48 8b 00             	mov    (%rax),%rax
ffff80000010be5c:	83 e0 01             	and    $0x1,%eax
ffff80000010be5f:	48 85 c0             	test   %rax,%rax
ffff80000010be62:	75 07                	jne    ffff80000010be6b <uva2ka+0x49>
    return 0;
ffff80000010be64:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010be69:	eb 33                	jmp    ffff80000010be9e <uva2ka+0x7c>
  if((*pte & PTE_U) == 0)
ffff80000010be6b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010be6f:	48 8b 00             	mov    (%rax),%rax
ffff80000010be72:	83 e0 04             	and    $0x4,%eax
ffff80000010be75:	48 85 c0             	test   %rax,%rax
ffff80000010be78:	75 07                	jne    ffff80000010be81 <uva2ka+0x5f>
    return 0;
ffff80000010be7a:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010be7f:	eb 1d                	jmp    ffff80000010be9e <uva2ka+0x7c>
  return (char*)P2V(PTE_ADDR(*pte));
ffff80000010be81:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010be85:	48 8b 00             	mov    (%rax),%rax
ffff80000010be88:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010be8e:	48 89 c2             	mov    %rax,%rdx
ffff80000010be91:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010be98:	80 ff ff 
ffff80000010be9b:	48 01 d0             	add    %rdx,%rax
}
ffff80000010be9e:	c9                   	leave
ffff80000010be9f:	c3                   	ret

ffff80000010bea0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pml4e_t *pgdir, addr_t va, void *p, uint64 len)
{
ffff80000010bea0:	55                   	push   %rbp
ffff80000010bea1:	48 89 e5             	mov    %rsp,%rbp
ffff80000010bea4:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010bea8:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010beac:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010beb0:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
ffff80000010beb4:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
  char *buf, *pa0;
  addr_t n, va0;

  buf = (char*)p;
ffff80000010beb8:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010bebc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while(len > 0){
ffff80000010bec0:	e9 b0 00 00 00       	jmp    ffff80000010bf75 <copyout+0xd5>
    va0 = PGROUNDDOWN(va);
ffff80000010bec5:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010bec9:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010becf:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    pa0 = uva2ka(pgdir, (char*)va0);
ffff80000010bed3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff80000010bed7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010bedb:	48 89 d6             	mov    %rdx,%rsi
ffff80000010bede:	48 89 c7             	mov    %rax,%rdi
ffff80000010bee1:	48 b8 22 be 10 00 00 	movabs $0xffff80000010be22,%rax
ffff80000010bee8:	80 ff ff 
ffff80000010beeb:	ff d0                	call   *%rax
ffff80000010beed:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    if(pa0 == 0)
ffff80000010bef1:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
ffff80000010bef6:	75 0a                	jne    ffff80000010bf02 <copyout+0x62>
      return -1;
ffff80000010bef8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010befd:	e9 83 00 00 00       	jmp    ffff80000010bf85 <copyout+0xe5>
    n = PGSIZE - (va - va0);
ffff80000010bf02:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bf06:	48 2b 45 d0          	sub    -0x30(%rbp),%rax
ffff80000010bf0a:	48 05 00 10 00 00    	add    $0x1000,%rax
ffff80000010bf10:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if(n > len)
ffff80000010bf14:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bf18:	48 39 45 c0          	cmp    %rax,-0x40(%rbp)
ffff80000010bf1c:	73 08                	jae    ffff80000010bf26 <copyout+0x86>
      n = len;
ffff80000010bf1e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010bf22:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    memmove(pa0 + (va - va0), buf, n);
ffff80000010bf26:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bf2a:	89 c6                	mov    %eax,%esi
ffff80000010bf2c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010bf30:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
ffff80000010bf34:	48 89 c2             	mov    %rax,%rdx
ffff80000010bf37:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010bf3b:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffff80000010bf3f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010bf43:	89 f2                	mov    %esi,%edx
ffff80000010bf45:	48 89 c6             	mov    %rax,%rsi
ffff80000010bf48:	48 89 cf             	mov    %rcx,%rdi
ffff80000010bf4b:	48 b8 d3 7b 10 00 00 	movabs $0xffff800000107bd3,%rax
ffff80000010bf52:	80 ff ff 
ffff80000010bf55:	ff d0                	call   *%rax
    len -= n;
ffff80000010bf57:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bf5b:	48 29 45 c0          	sub    %rax,-0x40(%rbp)
    buf += n;
ffff80000010bf5f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bf63:	48 01 45 f8          	add    %rax,-0x8(%rbp)
    va = va0 + PGSIZE;
ffff80000010bf67:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bf6b:	48 05 00 10 00 00    	add    $0x1000,%rax
ffff80000010bf71:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  while(len > 0){
ffff80000010bf75:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
ffff80000010bf7a:	0f 85 45 ff ff ff    	jne    ffff80000010bec5 <copyout+0x25>
  }
  return 0;
ffff80000010bf80:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010bf85:	c9                   	leave
ffff80000010bf86:	c3                   	ret

ffff80000010bf87 <copyin>:


int
copyin(pml4e_t *pgdir, void *dst, addr_t srcva, uint64 len)
{
ffff80000010bf87:	55                   	push   %rbp
ffff80000010bf88:	48 89 e5             	mov    %rsp,%rbp
ffff80000010bf8b:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010bf8f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010bf93:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff80000010bf97:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
ffff80000010bf9b:	48 89 4d d0          	mov    %rcx,-0x30(%rbp)
    char *pa0;
    uint n, va0;

    while(len > 0){
ffff80000010bf9f:	e9 9d 00 00 00       	jmp    ffff80000010c041 <copyin+0xba>
        // Round down to the start of the page containing srcva
        va0 = (uint)PGROUNDDOWN(srcva);
ffff80000010bfa4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010bfa8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
ffff80000010bfad:	89 45 f8             	mov    %eax,-0x8(%rbp)

        // Translate that user page to a kernel-accessible address
        pa0 = uva2ka(pgdir, (char*)va0);
ffff80000010bfb0:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff80000010bfb3:	48 89 c2             	mov    %rax,%rdx
ffff80000010bfb6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bfba:	48 89 d6             	mov    %rdx,%rsi
ffff80000010bfbd:	48 89 c7             	mov    %rax,%rdi
ffff80000010bfc0:	48 b8 22 be 10 00 00 	movabs $0xffff80000010be22,%rax
ffff80000010bfc7:	80 ff ff 
ffff80000010bfca:	ff d0                	call   *%rax
ffff80000010bfcc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        if(pa0 == 0)
ffff80000010bfd0:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010bfd5:	75 07                	jne    ffff80000010bfde <copyin+0x57>
            return -1;   // page doesn't exist or not user-accessible
ffff80000010bfd7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010bfdc:	eb 73                	jmp    ffff80000010c051 <copyin+0xca>

        // How many bytes can we copy from this page without crossing into the next?
        n = PGSIZE - (srcva - va0);
ffff80000010bfde:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010bfe2:	89 c2                	mov    %eax,%edx
ffff80000010bfe4:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff80000010bfe7:	29 d0                	sub    %edx,%eax
ffff80000010bfe9:	05 00 10 00 00       	add    $0x1000,%eax
ffff80000010bfee:	89 45 fc             	mov    %eax,-0x4(%rbp)
        if(n > len)
ffff80000010bff1:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010bff4:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
ffff80000010bff8:	73 07                	jae    ffff80000010c001 <copyin+0x7a>
            n = len;
ffff80000010bffa:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010bffe:	89 45 fc             	mov    %eax,-0x4(%rbp)

        // pa0 is the start of the page; offset into it by (srcva - va0)
        memmove(dst, pa0 + (srcva - va0), n);
ffff80000010c001:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff80000010c004:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010c008:	48 29 c2             	sub    %rax,%rdx
ffff80000010c00b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c00f:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffff80000010c013:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010c016:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010c01a:	48 89 ce             	mov    %rcx,%rsi
ffff80000010c01d:	48 89 c7             	mov    %rax,%rdi
ffff80000010c020:	48 b8 d3 7b 10 00 00 	movabs $0xffff800000107bd3,%rax
ffff80000010c027:	80 ff ff 
ffff80000010c02a:	ff d0                	call   *%rax

        len   -= n;
ffff80000010c02c:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010c02f:	48 29 45 d0          	sub    %rax,-0x30(%rbp)
        dst   += n;
ffff80000010c033:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010c036:	48 01 45 e0          	add    %rax,-0x20(%rbp)
        srcva += n;    // advance to next page if len still > 0
ffff80000010c03a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010c03d:	48 01 45 d8          	add    %rax,-0x28(%rbp)
    while(len > 0){
ffff80000010c041:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
ffff80000010c046:	0f 85 58 ff ff ff    	jne    ffff80000010bfa4 <copyin+0x1d>
    }
    return 0;
ffff80000010c04c:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010c051:	c9                   	leave
ffff80000010c052:	c3                   	ret
