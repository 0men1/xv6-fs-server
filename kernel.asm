
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
ffff800000100015:	f0 10 00             	lock adc %al,(%rax)
ffff800000100018:	00 00                	add    %al,(%rax)
ffff80000010001a:	12 00                	adc    (%rax),%al
ffff80000010001c:	20 00                	and    %al,(%rax)
ffff80000010001e:	10 00                	adc    %al,(%rax)

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
ffff80000010002c:	f3 aa                	rep stos %al,%es:(%rdi)

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
ffff800000100051:	0f 01 15 90 00 10 00 	lgdt   0x100090(%rip)        # ffff8000002000e8 <end+0xe00e8>

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
ffff8000001000ea:	e9 47 55 00 00       	jmp    ffff800000105636 <main>

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
ffff8000001000fc:	e9 60 56 00 00       	jmp    ffff800000105761 <mpenter>

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
ffff80000010011b:	f3 0f 1e fa          	endbr64
ffff80000010011f:	55                   	push   %rbp
ffff800000100120:	48 89 e5             	mov    %rsp,%rbp
ffff800000100123:	48 83 ec 10          	sub    $0x10,%rsp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
ffff800000100127:	48 b8 60 cf 10 00 00 	movabs $0xffff80000010cf60,%rax
ffff80000010012e:	80 ff ff 
ffff800000100131:	48 89 c6             	mov    %rax,%rsi
ffff800000100134:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff80000010013b:	80 ff ff 
ffff80000010013e:	48 89 c7             	mov    %rax,%rdi
ffff800000100141:	48 b8 4f 7e 10 00 00 	movabs $0xffff800000107e4f,%rax
ffff800000100148:	80 ff ff 
ffff80000010014b:	ff d0                	call   *%rax
//PAGEBREAK!

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
ffff80000010014d:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff800000100154:	80 ff ff 
ffff800000100157:	48 b9 08 41 11 00 00 	movabs $0xffff800000114108,%rcx
ffff80000010015e:	80 ff ff 
ffff800000100161:	48 89 88 a0 51 00 00 	mov    %rcx,0x51a0(%rax)
  bcache.head.next = &bcache.head;
ffff800000100168:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff80000010016f:	80 ff ff 
ffff800000100172:	48 89 88 a8 51 00 00 	mov    %rcx,0x51a8(%rax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
ffff800000100179:	48 b8 68 f0 10 00 00 	movabs $0xffff80000010f068,%rax
ffff800000100180:	80 ff ff 
ffff800000100183:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000100187:	e9 8e 00 00 00       	jmp    ffff80000010021a <binit+0xff>
    b->next = bcache.head.next;
ffff80000010018c:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff800000100193:	80 ff ff 
ffff800000100196:	48 8b 90 a8 51 00 00 	mov    0x51a8(%rax),%rdx
ffff80000010019d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001001a1:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    b->prev = &bcache.head;
ffff8000001001a8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001001ac:	48 be 08 41 11 00 00 	movabs $0xffff800000114108,%rsi
ffff8000001001b3:	80 ff ff 
ffff8000001001b6:	48 89 b0 98 00 00 00 	mov    %rsi,0x98(%rax)
    initsleeplock(&b->lock, "buffer");
ffff8000001001bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001001c1:	48 83 c0 10          	add    $0x10,%rax
ffff8000001001c5:	48 ba 67 cf 10 00 00 	movabs $0xffff80000010cf67,%rdx
ffff8000001001cc:	80 ff ff 
ffff8000001001cf:	48 89 d6             	mov    %rdx,%rsi
ffff8000001001d2:	48 89 c7             	mov    %rax,%rdi
ffff8000001001d5:	48 b8 59 7c 10 00 00 	movabs $0xffff800000107c59,%rax
ffff8000001001dc:	80 ff ff 
ffff8000001001df:	ff d0                	call   *%rax
    bcache.head.next->prev = b;
ffff8000001001e1:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff8000001001e8:	80 ff ff 
ffff8000001001eb:	48 8b 80 a8 51 00 00 	mov    0x51a8(%rax),%rax
ffff8000001001f2:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001001f6:	48 89 90 98 00 00 00 	mov    %rdx,0x98(%rax)
    bcache.head.next = b;
ffff8000001001fd:	48 ba 00 f0 10 00 00 	movabs $0xffff80000010f000,%rdx
ffff800000100204:	80 ff ff 
ffff800000100207:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010020b:	48 89 82 a8 51 00 00 	mov    %rax,0x51a8(%rdx)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
ffff800000100212:	48 81 45 f8 b0 02 00 	addq   $0x2b0,-0x8(%rbp)
ffff800000100219:	00 
ffff80000010021a:	48 b8 08 41 11 00 00 	movabs $0xffff800000114108,%rax
ffff800000100221:	80 ff ff 
ffff800000100224:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000100228:	0f 82 5e ff ff ff    	jb     ffff80000010018c <binit+0x71>
  }
}
ffff80000010022e:	90                   	nop
ffff80000010022f:	90                   	nop
ffff800000100230:	c9                   	leave
ffff800000100231:	c3                   	ret

ffff800000100232 <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
ffff800000100232:	f3 0f 1e fa          	endbr64
ffff800000100236:	55                   	push   %rbp
ffff800000100237:	48 89 e5             	mov    %rsp,%rbp
ffff80000010023a:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010023e:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000100241:	89 75 e8             	mov    %esi,-0x18(%rbp)
  struct buf *b;

  acquire(&bcache.lock);
ffff800000100244:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff80000010024b:	80 ff ff 
ffff80000010024e:	48 89 c7             	mov    %rax,%rdi
ffff800000100251:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff800000100258:	80 ff ff 
ffff80000010025b:	ff d0                	call   *%rax

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
ffff80000010025d:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff800000100264:	80 ff ff 
ffff800000100267:	48 8b 80 a8 51 00 00 	mov    0x51a8(%rax),%rax
ffff80000010026e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000100272:	eb 77                	jmp    ffff8000001002eb <bget+0xb9>
    if(b->dev == dev && b->blockno == blockno){
ffff800000100274:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100278:	8b 40 04             	mov    0x4(%rax),%eax
ffff80000010027b:	39 45 ec             	cmp    %eax,-0x14(%rbp)
ffff80000010027e:	75 5c                	jne    ffff8000001002dc <bget+0xaa>
ffff800000100280:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100284:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000100287:	39 45 e8             	cmp    %eax,-0x18(%rbp)
ffff80000010028a:	75 50                	jne    ffff8000001002dc <bget+0xaa>
      b->refcnt++;
ffff80000010028c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100290:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
ffff800000100296:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000100299:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010029d:	89 90 90 00 00 00    	mov    %edx,0x90(%rax)
      release(&bcache.lock);
ffff8000001002a3:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff8000001002aa:	80 ff ff 
ffff8000001002ad:	48 89 c7             	mov    %rax,%rdi
ffff8000001002b0:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff8000001002b7:	80 ff ff 
ffff8000001002ba:	ff d0                	call   *%rax
      acquiresleep(&b->lock);
ffff8000001002bc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001002c0:	48 83 c0 10          	add    $0x10,%rax
ffff8000001002c4:	48 89 c7             	mov    %rax,%rdi
ffff8000001002c7:	48 b8 b5 7c 10 00 00 	movabs $0xffff800000107cb5,%rax
ffff8000001002ce:	80 ff ff 
ffff8000001002d1:	ff d0                	call   *%rax
      return b;
ffff8000001002d3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001002d7:	e9 f6 00 00 00       	jmp    ffff8000001003d2 <bget+0x1a0>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
ffff8000001002dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001002e0:	48 8b 80 a0 00 00 00 	mov    0xa0(%rax),%rax
ffff8000001002e7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001002eb:	48 b8 08 41 11 00 00 	movabs $0xffff800000114108,%rax
ffff8000001002f2:	80 ff ff 
ffff8000001002f5:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff8000001002f9:	0f 85 75 ff ff ff    	jne    ffff800000100274 <bget+0x42>
  }

  // Not cached; recycle some unused buffer and clean buffer
  // "clean" because B_DIRTY and not locked means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
ffff8000001002ff:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff800000100306:	80 ff ff 
ffff800000100309:	48 8b 80 a0 51 00 00 	mov    0x51a0(%rax),%rax
ffff800000100310:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000100314:	e9 8c 00 00 00       	jmp    ffff8000001003a5 <bget+0x173>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
ffff800000100319:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010031d:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
ffff800000100323:	85 c0                	test   %eax,%eax
ffff800000100325:	75 6f                	jne    ffff800000100396 <bget+0x164>
ffff800000100327:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010032b:	8b 00                	mov    (%rax),%eax
ffff80000010032d:	83 e0 04             	and    $0x4,%eax
ffff800000100330:	85 c0                	test   %eax,%eax
ffff800000100332:	75 62                	jne    ffff800000100396 <bget+0x164>
      b->dev = dev;
ffff800000100334:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100338:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff80000010033b:	89 50 04             	mov    %edx,0x4(%rax)
      b->blockno = blockno;
ffff80000010033e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100342:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffff800000100345:	89 50 08             	mov    %edx,0x8(%rax)
      b->flags = 0;
ffff800000100348:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010034c:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
      b->refcnt = 1;
ffff800000100352:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100356:	c7 80 90 00 00 00 01 	movl   $0x1,0x90(%rax)
ffff80000010035d:	00 00 00 
      release(&bcache.lock);
ffff800000100360:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff800000100367:	80 ff ff 
ffff80000010036a:	48 89 c7             	mov    %rax,%rdi
ffff80000010036d:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff800000100374:	80 ff ff 
ffff800000100377:	ff d0                	call   *%rax
      acquiresleep(&b->lock);
ffff800000100379:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010037d:	48 83 c0 10          	add    $0x10,%rax
ffff800000100381:	48 89 c7             	mov    %rax,%rdi
ffff800000100384:	48 b8 b5 7c 10 00 00 	movabs $0xffff800000107cb5,%rax
ffff80000010038b:	80 ff ff 
ffff80000010038e:	ff d0                	call   *%rax
      return b;
ffff800000100390:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100394:	eb 3c                	jmp    ffff8000001003d2 <bget+0x1a0>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
ffff800000100396:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010039a:	48 8b 80 98 00 00 00 	mov    0x98(%rax),%rax
ffff8000001003a1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001003a5:	48 b8 08 41 11 00 00 	movabs $0xffff800000114108,%rax
ffff8000001003ac:	80 ff ff 
ffff8000001003af:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff8000001003b3:	0f 85 60 ff ff ff    	jne    ffff800000100319 <bget+0xe7>
    }
  }
  panic("bget: no buffers");
ffff8000001003b9:	48 b8 6e cf 10 00 00 	movabs $0xffff80000010cf6e,%rax
ffff8000001003c0:	80 ff ff 
ffff8000001003c3:	48 89 c7             	mov    %rax,%rdi
ffff8000001003c6:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff8000001003cd:	80 ff ff 
ffff8000001003d0:	ff d0                	call   *%rax
}
ffff8000001003d2:	c9                   	leave
ffff8000001003d3:	c3                   	ret

ffff8000001003d4 <bread>:

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
ffff8000001003d4:	f3 0f 1e fa          	endbr64
ffff8000001003d8:	55                   	push   %rbp
ffff8000001003d9:	48 89 e5             	mov    %rsp,%rbp
ffff8000001003dc:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001003e0:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff8000001003e3:	89 75 e8             	mov    %esi,-0x18(%rbp)
  struct buf *b;

  b = bget(dev, blockno);
ffff8000001003e6:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffff8000001003e9:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001003ec:	89 d6                	mov    %edx,%esi
ffff8000001003ee:	89 c7                	mov    %eax,%edi
ffff8000001003f0:	48 b8 32 02 10 00 00 	movabs $0xffff800000100232,%rax
ffff8000001003f7:	80 ff ff 
ffff8000001003fa:	ff d0                	call   *%rax
ffff8000001003fc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(!(b->flags & B_VALID)) {
ffff800000100400:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100404:	8b 00                	mov    (%rax),%eax
ffff800000100406:	83 e0 02             	and    $0x2,%eax
ffff800000100409:	85 c0                	test   %eax,%eax
ffff80000010040b:	75 13                	jne    ffff800000100420 <bread+0x4c>
    iderw(b);
ffff80000010040d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100411:	48 89 c7             	mov    %rax,%rdi
ffff800000100414:	48 b8 6b 3e 10 00 00 	movabs $0xffff800000103e6b,%rax
ffff80000010041b:	80 ff ff 
ffff80000010041e:	ff d0                	call   *%rax
  }
  return b;
ffff800000100420:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000100424:	c9                   	leave
ffff800000100425:	c3                   	ret

ffff800000100426 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
ffff800000100426:	f3 0f 1e fa          	endbr64
ffff80000010042a:	55                   	push   %rbp
ffff80000010042b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010042e:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000100432:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  if(!holdingsleep(&b->lock))
ffff800000100436:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010043a:	48 83 c0 10          	add    $0x10,%rax
ffff80000010043e:	48 89 c7             	mov    %rax,%rdi
ffff800000100441:	48 b8 a8 7d 10 00 00 	movabs $0xffff800000107da8,%rax
ffff800000100448:	80 ff ff 
ffff80000010044b:	ff d0                	call   *%rax
ffff80000010044d:	85 c0                	test   %eax,%eax
ffff80000010044f:	75 19                	jne    ffff80000010046a <bwrite+0x44>
    panic("bwrite");
ffff800000100451:	48 b8 7f cf 10 00 00 	movabs $0xffff80000010cf7f,%rax
ffff800000100458:	80 ff ff 
ffff80000010045b:	48 89 c7             	mov    %rax,%rdi
ffff80000010045e:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000100465:	80 ff ff 
ffff800000100468:	ff d0                	call   *%rax
  b->flags |= B_DIRTY;
ffff80000010046a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010046e:	8b 00                	mov    (%rax),%eax
ffff800000100470:	83 c8 04             	or     $0x4,%eax
ffff800000100473:	89 c2                	mov    %eax,%edx
ffff800000100475:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100479:	89 10                	mov    %edx,(%rax)
  iderw(b);
ffff80000010047b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010047f:	48 89 c7             	mov    %rax,%rdi
ffff800000100482:	48 b8 6b 3e 10 00 00 	movabs $0xffff800000103e6b,%rax
ffff800000100489:	80 ff ff 
ffff80000010048c:	ff d0                	call   *%rax
}
ffff80000010048e:	90                   	nop
ffff80000010048f:	c9                   	leave
ffff800000100490:	c3                   	ret

ffff800000100491 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
ffff800000100491:	f3 0f 1e fa          	endbr64
ffff800000100495:	55                   	push   %rbp
ffff800000100496:	48 89 e5             	mov    %rsp,%rbp
ffff800000100499:	48 83 ec 10          	sub    $0x10,%rsp
ffff80000010049d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  if(!holdingsleep(&b->lock))
ffff8000001004a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001004a5:	48 83 c0 10          	add    $0x10,%rax
ffff8000001004a9:	48 89 c7             	mov    %rax,%rdi
ffff8000001004ac:	48 b8 a8 7d 10 00 00 	movabs $0xffff800000107da8,%rax
ffff8000001004b3:	80 ff ff 
ffff8000001004b6:	ff d0                	call   *%rax
ffff8000001004b8:	85 c0                	test   %eax,%eax
ffff8000001004ba:	75 19                	jne    ffff8000001004d5 <brelse+0x44>
    panic("brelse");
ffff8000001004bc:	48 b8 86 cf 10 00 00 	movabs $0xffff80000010cf86,%rax
ffff8000001004c3:	80 ff ff 
ffff8000001004c6:	48 89 c7             	mov    %rax,%rdi
ffff8000001004c9:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff8000001004d0:	80 ff ff 
ffff8000001004d3:	ff d0                	call   *%rax

  releasesleep(&b->lock);
ffff8000001004d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001004d9:	48 83 c0 10          	add    $0x10,%rax
ffff8000001004dd:	48 89 c7             	mov    %rax,%rdi
ffff8000001004e0:	48 b8 3f 7d 10 00 00 	movabs $0xffff800000107d3f,%rax
ffff8000001004e7:	80 ff ff 
ffff8000001004ea:	ff d0                	call   *%rax

  acquire(&bcache.lock);
ffff8000001004ec:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff8000001004f3:	80 ff ff 
ffff8000001004f6:	48 89 c7             	mov    %rax,%rdi
ffff8000001004f9:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff800000100500:	80 ff ff 
ffff800000100503:	ff d0                	call   *%rax
  b->refcnt--;
ffff800000100505:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100509:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
ffff80000010050f:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000100512:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100516:	89 90 90 00 00 00    	mov    %edx,0x90(%rax)
  if (b->refcnt == 0) {
ffff80000010051c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100520:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
ffff800000100526:	85 c0                	test   %eax,%eax
ffff800000100528:	0f 85 9c 00 00 00    	jne    ffff8000001005ca <brelse+0x139>
    // no one is waiting for it.
    b->next->prev = b->prev;
ffff80000010052e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100532:	48 8b 80 a0 00 00 00 	mov    0xa0(%rax),%rax
ffff800000100539:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010053d:	48 8b 92 98 00 00 00 	mov    0x98(%rdx),%rdx
ffff800000100544:	48 89 90 98 00 00 00 	mov    %rdx,0x98(%rax)
    b->prev->next = b->next;
ffff80000010054b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010054f:	48 8b 80 98 00 00 00 	mov    0x98(%rax),%rax
ffff800000100556:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010055a:	48 8b 92 a0 00 00 00 	mov    0xa0(%rdx),%rdx
ffff800000100561:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    b->next = bcache.head.next;
ffff800000100568:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff80000010056f:	80 ff ff 
ffff800000100572:	48 8b 90 a8 51 00 00 	mov    0x51a8(%rax),%rdx
ffff800000100579:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010057d:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    b->prev = &bcache.head;
ffff800000100584:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100588:	48 b9 08 41 11 00 00 	movabs $0xffff800000114108,%rcx
ffff80000010058f:	80 ff ff 
ffff800000100592:	48 89 88 98 00 00 00 	mov    %rcx,0x98(%rax)
    bcache.head.next->prev = b;
ffff800000100599:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff8000001005a0:	80 ff ff 
ffff8000001005a3:	48 8b 80 a8 51 00 00 	mov    0x51a8(%rax),%rax
ffff8000001005aa:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001005ae:	48 89 90 98 00 00 00 	mov    %rdx,0x98(%rax)
    bcache.head.next = b;
ffff8000001005b5:	48 ba 00 f0 10 00 00 	movabs $0xffff80000010f000,%rdx
ffff8000001005bc:	80 ff ff 
ffff8000001005bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001005c3:	48 89 82 a8 51 00 00 	mov    %rax,0x51a8(%rdx)
  }

  release(&bcache.lock);
ffff8000001005ca:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff8000001005d1:	80 ff ff 
ffff8000001005d4:	48 89 c7             	mov    %rax,%rdi
ffff8000001005d7:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff8000001005de:	80 ff ff 
ffff8000001005e1:	ff d0                	call   *%rax
}
ffff8000001005e3:	90                   	nop
ffff8000001005e4:	c9                   	leave
ffff8000001005e5:	c3                   	ret

ffff8000001005e6 <inb>:
// Console input and output.
// Input is from the keyboard or serial port.
// Output is written to the screen and serial port.

#include <stdarg.h>
ffff8000001005e6:	f3 0f 1e fa          	endbr64
ffff8000001005ea:	55                   	push   %rbp
ffff8000001005eb:	48 89 e5             	mov    %rsp,%rbp
ffff8000001005ee:	48 83 ec 18          	sub    $0x18,%rsp
ffff8000001005f2:	89 f8                	mov    %edi,%eax
ffff8000001005f4:	66 89 45 ec          	mov    %ax,-0x14(%rbp)

#include "types.h"
#include "defs.h"
ffff8000001005f8:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff8000001005fc:	89 c2                	mov    %eax,%edx
ffff8000001005fe:	ec                   	in     (%dx),%al
ffff8000001005ff:	88 45 ff             	mov    %al,-0x1(%rbp)
#include "param.h"
ffff800000100602:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
#include "traps.h"
ffff800000100606:	c9                   	leave
ffff800000100607:	c3                   	ret

ffff800000100608 <outb>:
#include "x86.h"

static void consputc(int);

static int panicked = 0;

ffff800000100608:	f3 0f 1e fa          	endbr64
ffff80000010060c:	55                   	push   %rbp
ffff80000010060d:	48 89 e5             	mov    %rsp,%rbp
ffff800000100610:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000100614:	89 fa                	mov    %edi,%edx
ffff800000100616:	89 f0                	mov    %esi,%eax
ffff800000100618:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffff80000010061c:	88 45 f8             	mov    %al,-0x8(%rbp)
static struct {
ffff80000010061f:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffff800000100623:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffff800000100627:	ee                   	out    %al,(%dx)
  struct spinlock lock;
ffff800000100628:	90                   	nop
ffff800000100629:	c9                   	leave
ffff80000010062a:	c3                   	ret

ffff80000010062b <lidt>:

  va_start(ap, fmt);

  locking = cons.locking;
  if (locking)
    acquire(&cons.lock);
ffff80000010062b:	f3 0f 1e fa          	endbr64
ffff80000010062f:	55                   	push   %rbp
ffff800000100630:	48 89 e5             	mov    %rsp,%rbp
ffff800000100633:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000100637:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010063b:	89 75 d4             	mov    %esi,-0x2c(%rbp)

  if (fmt == 0)
ffff80000010063e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000100642:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    panic("null fmt");

ffff800000100646:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff800000100649:	83 e8 01             	sub    $0x1,%eax
ffff80000010064c:	66 89 45 ee          	mov    %ax,-0x12(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
ffff800000100650:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100654:	66 89 45 f0          	mov    %ax,-0x10(%rbp)
    if (c != '%') {
ffff800000100658:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010065c:	48 c1 e8 10          	shr    $0x10,%rax
ffff800000100660:	66 89 45 f2          	mov    %ax,-0xe(%rbp)
      consputc(c);
ffff800000100664:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100668:	48 c1 e8 20          	shr    $0x20,%rax
ffff80000010066c:	66 89 45 f4          	mov    %ax,-0xc(%rbp)
      continue;
ffff800000100670:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100674:	48 c1 e8 30          	shr    $0x30,%rax
ffff800000100678:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
    }
    c = fmt[++i] & 0xff;
ffff80000010067c:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
ffff800000100680:	0f 01 18             	lidt   (%rax)
    if (c == 0)
ffff800000100683:	90                   	nop
ffff800000100684:	c9                   	leave
ffff800000100685:	c3                   	ret

ffff800000100686 <cli>:
        s = "(null)";
      while (*s)
        consputc(*(s++));
      break;
    case '%':
      consputc('%');
ffff800000100686:	f3 0f 1e fa          	endbr64
ffff80000010068a:	55                   	push   %rbp
ffff80000010068b:	48 89 e5             	mov    %rsp,%rbp
      break;
ffff80000010068e:	fa                   	cli
    default:
ffff80000010068f:	90                   	nop
ffff800000100690:	5d                   	pop    %rbp
ffff800000100691:	c3                   	ret

ffff800000100692 <hlt>:
    }
  }

  if (locking)
    release(&cons.lock);
}
ffff800000100692:	f3 0f 1e fa          	endbr64
ffff800000100696:	55                   	push   %rbp
ffff800000100697:	48 89 e5             	mov    %rsp,%rbp

ffff80000010069a:	f4                   	hlt
__attribute__((noreturn))
ffff80000010069b:	90                   	nop
ffff80000010069c:	5d                   	pop    %rbp
ffff80000010069d:	c3                   	ret

ffff80000010069e <print_x64>:
{
ffff80000010069e:	f3 0f 1e fa          	endbr64
ffff8000001006a2:	55                   	push   %rbp
ffff8000001006a3:	48 89 e5             	mov    %rsp,%rbp
ffff8000001006a6:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001006aa:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
ffff8000001006ae:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001006b5:	eb 30                	jmp    ffff8000001006e7 <print_x64+0x49>
    consputc(digits[x >> (sizeof(addr_t) * 8 - 4)]);
ffff8000001006b7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001006bb:	48 c1 e8 3c          	shr    $0x3c,%rax
ffff8000001006bf:	48 ba 00 e0 10 00 00 	movabs $0xffff80000010e000,%rdx
ffff8000001006c6:	80 ff ff 
ffff8000001006c9:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
ffff8000001006cd:	0f be c0             	movsbl %al,%eax
ffff8000001006d0:	89 c7                	mov    %eax,%edi
ffff8000001006d2:	48 b8 19 0f 10 00 00 	movabs $0xffff800000100f19,%rax
ffff8000001006d9:	80 ff ff 
ffff8000001006dc:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
ffff8000001006de:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001006e2:	48 c1 65 e8 04       	shlq   $0x4,-0x18(%rbp)
ffff8000001006e7:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001006ea:	83 f8 0f             	cmp    $0xf,%eax
ffff8000001006ed:	76 c8                	jbe    ffff8000001006b7 <print_x64+0x19>
}
ffff8000001006ef:	90                   	nop
ffff8000001006f0:	90                   	nop
ffff8000001006f1:	c9                   	leave
ffff8000001006f2:	c3                   	ret

ffff8000001006f3 <print_x32>:
{
ffff8000001006f3:	f3 0f 1e fa          	endbr64
ffff8000001006f7:	55                   	push   %rbp
ffff8000001006f8:	48 89 e5             	mov    %rsp,%rbp
ffff8000001006fb:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001006ff:	89 7d ec             	mov    %edi,-0x14(%rbp)
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
ffff800000100702:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000100709:	eb 31                	jmp    ffff80000010073c <print_x32+0x49>
    consputc(digits[x >> (sizeof(uint) * 8 - 4)]);
ffff80000010070b:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff80000010070e:	c1 e8 1c             	shr    $0x1c,%eax
ffff800000100711:	89 c2                	mov    %eax,%edx
ffff800000100713:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff80000010071a:	80 ff ff 
ffff80000010071d:	89 d2                	mov    %edx,%edx
ffff80000010071f:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
ffff800000100723:	0f be c0             	movsbl %al,%eax
ffff800000100726:	89 c7                	mov    %eax,%edi
ffff800000100728:	48 b8 19 0f 10 00 00 	movabs $0xffff800000100f19,%rax
ffff80000010072f:	80 ff ff 
ffff800000100732:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
ffff800000100734:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000100738:	c1 65 ec 04          	shll   $0x4,-0x14(%rbp)
ffff80000010073c:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010073f:	83 f8 07             	cmp    $0x7,%eax
ffff800000100742:	76 c7                	jbe    ffff80000010070b <print_x32+0x18>
}
ffff800000100744:	90                   	nop
ffff800000100745:	90                   	nop
ffff800000100746:	c9                   	leave
ffff800000100747:	c3                   	ret

ffff800000100748 <print_d>:
{
ffff800000100748:	f3 0f 1e fa          	endbr64
ffff80000010074c:	55                   	push   %rbp
ffff80000010074d:	48 89 e5             	mov    %rsp,%rbp
ffff800000100750:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000100754:	89 7d dc             	mov    %edi,-0x24(%rbp)
  int64 x = v;
ffff800000100757:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff80000010075a:	48 98                	cltq
ffff80000010075c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if (v < 0)
ffff800000100760:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
ffff800000100764:	79 04                	jns    ffff80000010076a <print_d+0x22>
    x = -x;
ffff800000100766:	48 f7 5d f8          	negq   -0x8(%rbp)
  int i = 0;
ffff80000010076a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    buf[i++] = digits[x % 10];
ffff800000100771:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff800000100775:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
ffff80000010077c:	66 66 66 
ffff80000010077f:	48 89 c8             	mov    %rcx,%rax
ffff800000100782:	48 f7 ea             	imul   %rdx
ffff800000100785:	48 c1 fa 02          	sar    $0x2,%rdx
ffff800000100789:	48 89 c8             	mov    %rcx,%rax
ffff80000010078c:	48 c1 f8 3f          	sar    $0x3f,%rax
ffff800000100790:	48 29 c2             	sub    %rax,%rdx
ffff800000100793:	48 89 d0             	mov    %rdx,%rax
ffff800000100796:	48 c1 e0 02          	shl    $0x2,%rax
ffff80000010079a:	48 01 d0             	add    %rdx,%rax
ffff80000010079d:	48 01 c0             	add    %rax,%rax
ffff8000001007a0:	48 29 c1             	sub    %rax,%rcx
ffff8000001007a3:	48 89 ca             	mov    %rcx,%rdx
ffff8000001007a6:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff8000001007a9:	8d 48 01             	lea    0x1(%rax),%ecx
ffff8000001007ac:	89 4d f4             	mov    %ecx,-0xc(%rbp)
ffff8000001007af:	48 b9 00 e0 10 00 00 	movabs $0xffff80000010e000,%rcx
ffff8000001007b6:	80 ff ff 
ffff8000001007b9:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
ffff8000001007bd:	48 98                	cltq
ffff8000001007bf:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
ffff8000001007c3:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff8000001007c7:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
ffff8000001007ce:	66 66 66 
ffff8000001007d1:	48 89 c8             	mov    %rcx,%rax
ffff8000001007d4:	48 f7 ea             	imul   %rdx
ffff8000001007d7:	48 89 d0             	mov    %rdx,%rax
ffff8000001007da:	48 c1 f8 02          	sar    $0x2,%rax
ffff8000001007de:	48 c1 f9 3f          	sar    $0x3f,%rcx
ffff8000001007e2:	48 89 ca             	mov    %rcx,%rdx
ffff8000001007e5:	48 29 d0             	sub    %rdx,%rax
ffff8000001007e8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
ffff8000001007ec:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff8000001007f1:	0f 85 7a ff ff ff    	jne    ffff800000100771 <print_d+0x29>
  if (v < 0)
ffff8000001007f7:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
ffff8000001007fb:	79 2d                	jns    ffff80000010082a <print_d+0xe2>
    buf[i++] = '-';
ffff8000001007fd:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000100800:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000100803:	89 55 f4             	mov    %edx,-0xc(%rbp)
ffff800000100806:	48 98                	cltq
ffff800000100808:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)
  while (--i >= 0)
ffff80000010080d:	eb 1b                	jmp    ffff80000010082a <print_d+0xe2>
    consputc(buf[i]);
ffff80000010080f:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000100812:	48 98                	cltq
ffff800000100814:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
ffff800000100819:	0f be c0             	movsbl %al,%eax
ffff80000010081c:	89 c7                	mov    %eax,%edi
ffff80000010081e:	48 b8 19 0f 10 00 00 	movabs $0xffff800000100f19,%rax
ffff800000100825:	80 ff ff 
ffff800000100828:	ff d0                	call   *%rax
  while (--i >= 0)
ffff80000010082a:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
ffff80000010082e:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
ffff800000100832:	79 db                	jns    ffff80000010080f <print_d+0xc7>
}
ffff800000100834:	90                   	nop
ffff800000100835:	90                   	nop
ffff800000100836:	c9                   	leave
ffff800000100837:	c3                   	ret

ffff800000100838 <cprintf>:
{
ffff800000100838:	f3 0f 1e fa          	endbr64
ffff80000010083c:	55                   	push   %rbp
ffff80000010083d:	48 89 e5             	mov    %rsp,%rbp
ffff800000100840:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
ffff800000100847:	48 89 bd 18 ff ff ff 	mov    %rdi,-0xe8(%rbp)
ffff80000010084e:	48 89 b5 58 ff ff ff 	mov    %rsi,-0xa8(%rbp)
ffff800000100855:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
ffff80000010085c:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
ffff800000100863:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
ffff80000010086a:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
ffff800000100871:	84 c0                	test   %al,%al
ffff800000100873:	74 20                	je     ffff800000100895 <cprintf+0x5d>
ffff800000100875:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
ffff800000100879:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
ffff80000010087d:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
ffff800000100881:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
ffff800000100885:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
ffff800000100889:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
ffff80000010088d:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
ffff800000100891:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_start(ap, fmt);
ffff800000100895:	c7 85 20 ff ff ff 08 	movl   $0x8,-0xe0(%rbp)
ffff80000010089c:	00 00 00 
ffff80000010089f:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
ffff8000001008a6:	00 00 00 
ffff8000001008a9:	48 8d 45 10          	lea    0x10(%rbp),%rax
ffff8000001008ad:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
ffff8000001008b4:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
ffff8000001008bb:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  locking = cons.locking;
ffff8000001008c2:	48 b8 c0 44 11 00 00 	movabs $0xffff8000001144c0,%rax
ffff8000001008c9:	80 ff ff 
ffff8000001008cc:	8b 40 68             	mov    0x68(%rax),%eax
ffff8000001008cf:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
  if (locking)
ffff8000001008d5:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
ffff8000001008dc:	74 19                	je     ffff8000001008f7 <cprintf+0xbf>
    acquire(&cons.lock);
ffff8000001008de:	48 b8 c0 44 11 00 00 	movabs $0xffff8000001144c0,%rax
ffff8000001008e5:	80 ff ff 
ffff8000001008e8:	48 89 c7             	mov    %rax,%rdi
ffff8000001008eb:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff8000001008f2:	80 ff ff 
ffff8000001008f5:	ff d0                	call   *%rax
  if (fmt == 0)
ffff8000001008f7:	48 83 bd 18 ff ff ff 	cmpq   $0x0,-0xe8(%rbp)
ffff8000001008fe:	00 
ffff8000001008ff:	75 19                	jne    ffff80000010091a <cprintf+0xe2>
    panic("null fmt");
ffff800000100901:	48 b8 8d cf 10 00 00 	movabs $0xffff80000010cf8d,%rax
ffff800000100908:	80 ff ff 
ffff80000010090b:	48 89 c7             	mov    %rax,%rdi
ffff80000010090e:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000100915:	80 ff ff 
ffff800000100918:	ff d0                	call   *%rax
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
ffff80000010091a:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
ffff800000100921:	00 00 00 
ffff800000100924:	e9 a0 02 00 00       	jmp    ffff800000100bc9 <cprintf+0x391>
    if (c != '%') {
ffff800000100929:	83 bd 38 ff ff ff 25 	cmpl   $0x25,-0xc8(%rbp)
ffff800000100930:	74 19                	je     ffff80000010094b <cprintf+0x113>
      consputc(c);
ffff800000100932:	8b 85 38 ff ff ff    	mov    -0xc8(%rbp),%eax
ffff800000100938:	89 c7                	mov    %eax,%edi
ffff80000010093a:	48 b8 19 0f 10 00 00 	movabs $0xffff800000100f19,%rax
ffff800000100941:	80 ff ff 
ffff800000100944:	ff d0                	call   *%rax
      continue;
ffff800000100946:	e9 77 02 00 00       	jmp    ffff800000100bc2 <cprintf+0x38a>
    c = fmt[++i] & 0xff;
ffff80000010094b:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
ffff800000100952:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
ffff800000100958:	48 63 d0             	movslq %eax,%rdx
ffff80000010095b:	48 8b 85 18 ff ff ff 	mov    -0xe8(%rbp),%rax
ffff800000100962:	48 01 d0             	add    %rdx,%rax
ffff800000100965:	0f b6 00             	movzbl (%rax),%eax
ffff800000100968:	0f be c0             	movsbl %al,%eax
ffff80000010096b:	25 ff 00 00 00       	and    $0xff,%eax
ffff800000100970:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%rbp)
    if (c == 0)
ffff800000100976:	83 bd 38 ff ff ff 00 	cmpl   $0x0,-0xc8(%rbp)
ffff80000010097d:	0f 84 79 02 00 00    	je     ffff800000100bfc <cprintf+0x3c4>
    switch(c) {
ffff800000100983:	83 bd 38 ff ff ff 78 	cmpl   $0x78,-0xc8(%rbp)
ffff80000010098a:	0f 84 b0 00 00 00    	je     ffff800000100a40 <cprintf+0x208>
ffff800000100990:	83 bd 38 ff ff ff 78 	cmpl   $0x78,-0xc8(%rbp)
ffff800000100997:	0f 8f ff 01 00 00    	jg     ffff800000100b9c <cprintf+0x364>
ffff80000010099d:	83 bd 38 ff ff ff 73 	cmpl   $0x73,-0xc8(%rbp)
ffff8000001009a4:	0f 84 42 01 00 00    	je     ffff800000100aec <cprintf+0x2b4>
ffff8000001009aa:	83 bd 38 ff ff ff 73 	cmpl   $0x73,-0xc8(%rbp)
ffff8000001009b1:	0f 8f e5 01 00 00    	jg     ffff800000100b9c <cprintf+0x364>
ffff8000001009b7:	83 bd 38 ff ff ff 70 	cmpl   $0x70,-0xc8(%rbp)
ffff8000001009be:	0f 84 d1 00 00 00    	je     ffff800000100a95 <cprintf+0x25d>
ffff8000001009c4:	83 bd 38 ff ff ff 70 	cmpl   $0x70,-0xc8(%rbp)
ffff8000001009cb:	0f 8f cb 01 00 00    	jg     ffff800000100b9c <cprintf+0x364>
ffff8000001009d1:	83 bd 38 ff ff ff 25 	cmpl   $0x25,-0xc8(%rbp)
ffff8000001009d8:	0f 84 ab 01 00 00    	je     ffff800000100b89 <cprintf+0x351>
ffff8000001009de:	83 bd 38 ff ff ff 64 	cmpl   $0x64,-0xc8(%rbp)
ffff8000001009e5:	0f 85 b1 01 00 00    	jne    ffff800000100b9c <cprintf+0x364>
      print_d(va_arg(ap, int));
ffff8000001009eb:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
ffff8000001009f1:	83 f8 2f             	cmp    $0x2f,%eax
ffff8000001009f4:	77 23                	ja     ffff800000100a19 <cprintf+0x1e1>
ffff8000001009f6:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
ffff8000001009fd:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffff800000100a03:	89 d2                	mov    %edx,%edx
ffff800000100a05:	48 01 d0             	add    %rdx,%rax
ffff800000100a08:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffff800000100a0e:	83 c2 08             	add    $0x8,%edx
ffff800000100a11:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
ffff800000100a17:	eb 12                	jmp    ffff800000100a2b <cprintf+0x1f3>
ffff800000100a19:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
ffff800000100a20:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffff800000100a24:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
ffff800000100a2b:	8b 00                	mov    (%rax),%eax
ffff800000100a2d:	89 c7                	mov    %eax,%edi
ffff800000100a2f:	48 b8 48 07 10 00 00 	movabs $0xffff800000100748,%rax
ffff800000100a36:	80 ff ff 
ffff800000100a39:	ff d0                	call   *%rax
      break;
ffff800000100a3b:	e9 82 01 00 00       	jmp    ffff800000100bc2 <cprintf+0x38a>
      print_x32(va_arg(ap, uint));
ffff800000100a40:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
ffff800000100a46:	83 f8 2f             	cmp    $0x2f,%eax
ffff800000100a49:	77 23                	ja     ffff800000100a6e <cprintf+0x236>
ffff800000100a4b:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
ffff800000100a52:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffff800000100a58:	89 d2                	mov    %edx,%edx
ffff800000100a5a:	48 01 d0             	add    %rdx,%rax
ffff800000100a5d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffff800000100a63:	83 c2 08             	add    $0x8,%edx
ffff800000100a66:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
ffff800000100a6c:	eb 12                	jmp    ffff800000100a80 <cprintf+0x248>
ffff800000100a6e:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
ffff800000100a75:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffff800000100a79:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
ffff800000100a80:	8b 00                	mov    (%rax),%eax
ffff800000100a82:	89 c7                	mov    %eax,%edi
ffff800000100a84:	48 b8 f3 06 10 00 00 	movabs $0xffff8000001006f3,%rax
ffff800000100a8b:	80 ff ff 
ffff800000100a8e:	ff d0                	call   *%rax
      break;
ffff800000100a90:	e9 2d 01 00 00       	jmp    ffff800000100bc2 <cprintf+0x38a>
      print_x64(va_arg(ap, addr_t));
ffff800000100a95:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
ffff800000100a9b:	83 f8 2f             	cmp    $0x2f,%eax
ffff800000100a9e:	77 23                	ja     ffff800000100ac3 <cprintf+0x28b>
ffff800000100aa0:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
ffff800000100aa7:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffff800000100aad:	89 d2                	mov    %edx,%edx
ffff800000100aaf:	48 01 d0             	add    %rdx,%rax
ffff800000100ab2:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffff800000100ab8:	83 c2 08             	add    $0x8,%edx
ffff800000100abb:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
ffff800000100ac1:	eb 12                	jmp    ffff800000100ad5 <cprintf+0x29d>
ffff800000100ac3:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
ffff800000100aca:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffff800000100ace:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
ffff800000100ad5:	48 8b 00             	mov    (%rax),%rax
ffff800000100ad8:	48 89 c7             	mov    %rax,%rdi
ffff800000100adb:	48 b8 9e 06 10 00 00 	movabs $0xffff80000010069e,%rax
ffff800000100ae2:	80 ff ff 
ffff800000100ae5:	ff d0                	call   *%rax
      break;
ffff800000100ae7:	e9 d6 00 00 00       	jmp    ffff800000100bc2 <cprintf+0x38a>
      if ((s = va_arg(ap, char*)) == 0)
ffff800000100aec:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
ffff800000100af2:	83 f8 2f             	cmp    $0x2f,%eax
ffff800000100af5:	77 23                	ja     ffff800000100b1a <cprintf+0x2e2>
ffff800000100af7:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
ffff800000100afe:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffff800000100b04:	89 d2                	mov    %edx,%edx
ffff800000100b06:	48 01 d0             	add    %rdx,%rax
ffff800000100b09:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffff800000100b0f:	83 c2 08             	add    $0x8,%edx
ffff800000100b12:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
ffff800000100b18:	eb 12                	jmp    ffff800000100b2c <cprintf+0x2f4>
ffff800000100b1a:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
ffff800000100b21:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffff800000100b25:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
ffff800000100b2c:	48 8b 00             	mov    (%rax),%rax
ffff800000100b2f:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
ffff800000100b36:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
ffff800000100b3d:	00 
ffff800000100b3e:	75 39                	jne    ffff800000100b79 <cprintf+0x341>
        s = "(null)";
ffff800000100b40:	48 b8 96 cf 10 00 00 	movabs $0xffff80000010cf96,%rax
ffff800000100b47:	80 ff ff 
ffff800000100b4a:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
ffff800000100b51:	eb 26                	jmp    ffff800000100b79 <cprintf+0x341>
        consputc(*(s++));
ffff800000100b53:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
ffff800000100b5a:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff800000100b5e:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
ffff800000100b65:	0f b6 00             	movzbl (%rax),%eax
ffff800000100b68:	0f be c0             	movsbl %al,%eax
ffff800000100b6b:	89 c7                	mov    %eax,%edi
ffff800000100b6d:	48 b8 19 0f 10 00 00 	movabs $0xffff800000100f19,%rax
ffff800000100b74:	80 ff ff 
ffff800000100b77:	ff d0                	call   *%rax
      while (*s)
ffff800000100b79:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
ffff800000100b80:	0f b6 00             	movzbl (%rax),%eax
ffff800000100b83:	84 c0                	test   %al,%al
ffff800000100b85:	75 cc                	jne    ffff800000100b53 <cprintf+0x31b>
      break;
ffff800000100b87:	eb 39                	jmp    ffff800000100bc2 <cprintf+0x38a>
      consputc('%');
ffff800000100b89:	bf 25 00 00 00       	mov    $0x25,%edi
ffff800000100b8e:	48 b8 19 0f 10 00 00 	movabs $0xffff800000100f19,%rax
ffff800000100b95:	80 ff ff 
ffff800000100b98:	ff d0                	call   *%rax
      break;
ffff800000100b9a:	eb 26                	jmp    ffff800000100bc2 <cprintf+0x38a>
      consputc('%');
ffff800000100b9c:	bf 25 00 00 00       	mov    $0x25,%edi
ffff800000100ba1:	48 b8 19 0f 10 00 00 	movabs $0xffff800000100f19,%rax
ffff800000100ba8:	80 ff ff 
ffff800000100bab:	ff d0                	call   *%rax
      consputc(c);
ffff800000100bad:	8b 85 38 ff ff ff    	mov    -0xc8(%rbp),%eax
ffff800000100bb3:	89 c7                	mov    %eax,%edi
ffff800000100bb5:	48 b8 19 0f 10 00 00 	movabs $0xffff800000100f19,%rax
ffff800000100bbc:	80 ff ff 
ffff800000100bbf:	ff d0                	call   *%rax
      break;
ffff800000100bc1:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
ffff800000100bc2:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
ffff800000100bc9:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
ffff800000100bcf:	48 63 d0             	movslq %eax,%rdx
ffff800000100bd2:	48 8b 85 18 ff ff ff 	mov    -0xe8(%rbp),%rax
ffff800000100bd9:	48 01 d0             	add    %rdx,%rax
ffff800000100bdc:	0f b6 00             	movzbl (%rax),%eax
ffff800000100bdf:	0f be c0             	movsbl %al,%eax
ffff800000100be2:	25 ff 00 00 00       	and    $0xff,%eax
ffff800000100be7:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%rbp)
ffff800000100bed:	83 bd 38 ff ff ff 00 	cmpl   $0x0,-0xc8(%rbp)
ffff800000100bf4:	0f 85 2f fd ff ff    	jne    ffff800000100929 <cprintf+0xf1>
ffff800000100bfa:	eb 01                	jmp    ffff800000100bfd <cprintf+0x3c5>
      break;
ffff800000100bfc:	90                   	nop
  if (locking)
ffff800000100bfd:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
ffff800000100c04:	74 19                	je     ffff800000100c1f <cprintf+0x3e7>
    release(&cons.lock);
ffff800000100c06:	48 b8 c0 44 11 00 00 	movabs $0xffff8000001144c0,%rax
ffff800000100c0d:	80 ff ff 
ffff800000100c10:	48 89 c7             	mov    %rax,%rdi
ffff800000100c13:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff800000100c1a:	80 ff ff 
ffff800000100c1d:	ff d0                	call   *%rax
}
ffff800000100c1f:	90                   	nop
ffff800000100c20:	c9                   	leave
ffff800000100c21:	c3                   	ret

ffff800000100c22 <panic>:
  void
panic(char *s)
{
ffff800000100c22:	f3 0f 1e fa          	endbr64
ffff800000100c26:	55                   	push   %rbp
ffff800000100c27:	48 89 e5             	mov    %rsp,%rbp
ffff800000100c2a:	48 83 ec 70          	sub    $0x70,%rsp
ffff800000100c2e:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)
  int i;
  addr_t pcs[10];

  cli();
ffff800000100c32:	48 b8 86 06 10 00 00 	movabs $0xffff800000100686,%rax
ffff800000100c39:	80 ff ff 
ffff800000100c3c:	ff d0                	call   *%rax
  cons.locking = 0;
ffff800000100c3e:	48 b8 c0 44 11 00 00 	movabs $0xffff8000001144c0,%rax
ffff800000100c45:	80 ff ff 
ffff800000100c48:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%rax)
  cprintf("cpu%d: panic: ", cpu->id);
ffff800000100c4f:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000100c56:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000100c5a:	0f b6 00             	movzbl (%rax),%eax
ffff800000100c5d:	0f b6 c0             	movzbl %al,%eax
ffff800000100c60:	89 c6                	mov    %eax,%esi
ffff800000100c62:	48 b8 9d cf 10 00 00 	movabs $0xffff80000010cf9d,%rax
ffff800000100c69:	80 ff ff 
ffff800000100c6c:	48 89 c7             	mov    %rax,%rdi
ffff800000100c6f:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000100c74:	48 ba 38 08 10 00 00 	movabs $0xffff800000100838,%rdx
ffff800000100c7b:	80 ff ff 
ffff800000100c7e:	ff d2                	call   *%rdx
  cprintf(s);
ffff800000100c80:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff800000100c84:	48 89 c7             	mov    %rax,%rdi
ffff800000100c87:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000100c8c:	48 ba 38 08 10 00 00 	movabs $0xffff800000100838,%rdx
ffff800000100c93:	80 ff ff 
ffff800000100c96:	ff d2                	call   *%rdx
  cprintf("\n");
ffff800000100c98:	48 b8 ac cf 10 00 00 	movabs $0xffff80000010cfac,%rax
ffff800000100c9f:	80 ff ff 
ffff800000100ca2:	48 89 c7             	mov    %rax,%rdi
ffff800000100ca5:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000100caa:	48 ba 38 08 10 00 00 	movabs $0xffff800000100838,%rdx
ffff800000100cb1:	80 ff ff 
ffff800000100cb4:	ff d2                	call   *%rdx
  getcallerpcs(&s, pcs);
ffff800000100cb6:	48 8d 55 a0          	lea    -0x60(%rbp),%rdx
ffff800000100cba:	48 8d 45 98          	lea    -0x68(%rbp),%rax
ffff800000100cbe:	48 89 d6             	mov    %rdx,%rsi
ffff800000100cc1:	48 89 c7             	mov    %rax,%rdi
ffff800000100cc4:	48 b8 a6 7f 10 00 00 	movabs $0xffff800000107fa6,%rax
ffff800000100ccb:	80 ff ff 
ffff800000100cce:	ff d0                	call   *%rax
  for (i=0; i<10; i++)
ffff800000100cd0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000100cd7:	eb 2f                	jmp    ffff800000100d08 <panic+0xe6>
    cprintf(" %p\n", pcs[i]);
ffff800000100cd9:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000100cdc:	48 98                	cltq
ffff800000100cde:	48 8b 44 c5 a0       	mov    -0x60(%rbp,%rax,8),%rax
ffff800000100ce3:	48 89 c6             	mov    %rax,%rsi
ffff800000100ce6:	48 b8 ae cf 10 00 00 	movabs $0xffff80000010cfae,%rax
ffff800000100ced:	80 ff ff 
ffff800000100cf0:	48 89 c7             	mov    %rax,%rdi
ffff800000100cf3:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000100cf8:	48 ba 38 08 10 00 00 	movabs $0xffff800000100838,%rdx
ffff800000100cff:	80 ff ff 
ffff800000100d02:	ff d2                	call   *%rdx
  for (i=0; i<10; i++)
ffff800000100d04:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000100d08:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffff800000100d0c:	7e cb                	jle    ffff800000100cd9 <panic+0xb7>
  panicked = 1; // freeze other CPU
ffff800000100d0e:	48 b8 b8 44 11 00 00 	movabs $0xffff8000001144b8,%rax
ffff800000100d15:	80 ff ff 
ffff800000100d18:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
  for (;;)
    hlt();
ffff800000100d1e:	48 b8 92 06 10 00 00 	movabs $0xffff800000100692,%rax
ffff800000100d25:	80 ff ff 
ffff800000100d28:	ff d0                	call   *%rax
ffff800000100d2a:	eb f2                	jmp    ffff800000100d1e <panic+0xfc>

ffff800000100d2c <cgaputc>:
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

  static void
cgaputc(int c)
{
ffff800000100d2c:	f3 0f 1e fa          	endbr64
ffff800000100d30:	55                   	push   %rbp
ffff800000100d31:	48 89 e5             	mov    %rsp,%rbp
ffff800000100d34:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000100d38:	89 7d ec             	mov    %edi,-0x14(%rbp)
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
ffff800000100d3b:	be 0e 00 00 00       	mov    $0xe,%esi
ffff800000100d40:	bf d4 03 00 00       	mov    $0x3d4,%edi
ffff800000100d45:	48 b8 08 06 10 00 00 	movabs $0xffff800000100608,%rax
ffff800000100d4c:	80 ff ff 
ffff800000100d4f:	ff d0                	call   *%rax
  pos = inb(CRTPORT+1) << 8;
ffff800000100d51:	bf d5 03 00 00       	mov    $0x3d5,%edi
ffff800000100d56:	48 b8 e6 05 10 00 00 	movabs $0xffff8000001005e6,%rax
ffff800000100d5d:	80 ff ff 
ffff800000100d60:	ff d0                	call   *%rax
ffff800000100d62:	0f b6 c0             	movzbl %al,%eax
ffff800000100d65:	c1 e0 08             	shl    $0x8,%eax
ffff800000100d68:	89 45 fc             	mov    %eax,-0x4(%rbp)
  outb(CRTPORT, 15);
ffff800000100d6b:	be 0f 00 00 00       	mov    $0xf,%esi
ffff800000100d70:	bf d4 03 00 00       	mov    $0x3d4,%edi
ffff800000100d75:	48 b8 08 06 10 00 00 	movabs $0xffff800000100608,%rax
ffff800000100d7c:	80 ff ff 
ffff800000100d7f:	ff d0                	call   *%rax
  pos |= inb(CRTPORT+1);
ffff800000100d81:	bf d5 03 00 00       	mov    $0x3d5,%edi
ffff800000100d86:	48 b8 e6 05 10 00 00 	movabs $0xffff8000001005e6,%rax
ffff800000100d8d:	80 ff ff 
ffff800000100d90:	ff d0                	call   *%rax
ffff800000100d92:	0f b6 c0             	movzbl %al,%eax
ffff800000100d95:	09 45 fc             	or     %eax,-0x4(%rbp)

  if (c == '\n')
ffff800000100d98:	83 7d ec 0a          	cmpl   $0xa,-0x14(%rbp)
ffff800000100d9c:	75 37                	jne    ffff800000100dd5 <cgaputc+0xa9>
    pos += 80 - pos%80;
ffff800000100d9e:	8b 4d fc             	mov    -0x4(%rbp),%ecx
ffff800000100da1:	48 63 c1             	movslq %ecx,%rax
ffff800000100da4:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
ffff800000100dab:	48 c1 e8 20          	shr    $0x20,%rax
ffff800000100daf:	89 c2                	mov    %eax,%edx
ffff800000100db1:	c1 fa 05             	sar    $0x5,%edx
ffff800000100db4:	89 c8                	mov    %ecx,%eax
ffff800000100db6:	c1 f8 1f             	sar    $0x1f,%eax
ffff800000100db9:	29 c2                	sub    %eax,%edx
ffff800000100dbb:	89 d0                	mov    %edx,%eax
ffff800000100dbd:	c1 e0 02             	shl    $0x2,%eax
ffff800000100dc0:	01 d0                	add    %edx,%eax
ffff800000100dc2:	c1 e0 04             	shl    $0x4,%eax
ffff800000100dc5:	29 c1                	sub    %eax,%ecx
ffff800000100dc7:	89 ca                	mov    %ecx,%edx
ffff800000100dc9:	b8 50 00 00 00       	mov    $0x50,%eax
ffff800000100dce:	29 d0                	sub    %edx,%eax
ffff800000100dd0:	01 45 fc             	add    %eax,-0x4(%rbp)
ffff800000100dd3:	eb 43                	jmp    ffff800000100e18 <cgaputc+0xec>
  else if (c == BACKSPACE) {
ffff800000100dd5:	81 7d ec 00 01 00 00 	cmpl   $0x100,-0x14(%rbp)
ffff800000100ddc:	75 0c                	jne    ffff800000100dea <cgaputc+0xbe>
    if (pos > 0) --pos;
ffff800000100dde:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000100de2:	7e 34                	jle    ffff800000100e18 <cgaputc+0xec>
ffff800000100de4:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
ffff800000100de8:	eb 2e                	jmp    ffff800000100e18 <cgaputc+0xec>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // gray on black
ffff800000100dea:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000100ded:	0f b6 c0             	movzbl %al,%eax
ffff800000100df0:	80 cc 07             	or     $0x7,%ah
ffff800000100df3:	89 c6                	mov    %eax,%esi
ffff800000100df5:	48 b8 18 e0 10 00 00 	movabs $0xffff80000010e018,%rax
ffff800000100dfc:	80 ff ff 
ffff800000100dff:	48 8b 08             	mov    (%rax),%rcx
ffff800000100e02:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000100e05:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000100e08:	89 55 fc             	mov    %edx,-0x4(%rbp)
ffff800000100e0b:	48 98                	cltq
ffff800000100e0d:	48 01 c0             	add    %rax,%rax
ffff800000100e10:	48 01 c8             	add    %rcx,%rax
ffff800000100e13:	89 f2                	mov    %esi,%edx
ffff800000100e15:	66 89 10             	mov    %dx,(%rax)

  if ((pos/80) >= 24){  // Scroll up.
ffff800000100e18:	81 7d fc 7f 07 00 00 	cmpl   $0x77f,-0x4(%rbp)
ffff800000100e1f:	7e 76                	jle    ffff800000100e97 <cgaputc+0x16b>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
ffff800000100e21:	48 b8 18 e0 10 00 00 	movabs $0xffff80000010e018,%rax
ffff800000100e28:	80 ff ff 
ffff800000100e2b:	48 8b 00             	mov    (%rax),%rax
ffff800000100e2e:	48 8d 88 a0 00 00 00 	lea    0xa0(%rax),%rcx
ffff800000100e35:	48 b8 18 e0 10 00 00 	movabs $0xffff80000010e018,%rax
ffff800000100e3c:	80 ff ff 
ffff800000100e3f:	48 8b 00             	mov    (%rax),%rax
ffff800000100e42:	ba 60 0e 00 00       	mov    $0xe60,%edx
ffff800000100e47:	48 89 ce             	mov    %rcx,%rsi
ffff800000100e4a:	48 89 c7             	mov    %rax,%rdi
ffff800000100e4d:	48 b8 4d 83 10 00 00 	movabs $0xffff80000010834d,%rax
ffff800000100e54:	80 ff ff 
ffff800000100e57:	ff d0                	call   *%rax
    pos -= 80;
ffff800000100e59:	83 6d fc 50          	subl   $0x50,-0x4(%rbp)
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
ffff800000100e5d:	b8 80 07 00 00       	mov    $0x780,%eax
ffff800000100e62:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff800000100e65:	48 98                	cltq
ffff800000100e67:	8d 14 00             	lea    (%rax,%rax,1),%edx
ffff800000100e6a:	48 b8 18 e0 10 00 00 	movabs $0xffff80000010e018,%rax
ffff800000100e71:	80 ff ff 
ffff800000100e74:	48 8b 00             	mov    (%rax),%rax
ffff800000100e77:	8b 4d fc             	mov    -0x4(%rbp),%ecx
ffff800000100e7a:	48 63 c9             	movslq %ecx,%rcx
ffff800000100e7d:	48 01 c9             	add    %rcx,%rcx
ffff800000100e80:	48 01 c8             	add    %rcx,%rax
ffff800000100e83:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000100e88:	48 89 c7             	mov    %rax,%rdi
ffff800000100e8b:	48 b8 40 82 10 00 00 	movabs $0xffff800000108240,%rax
ffff800000100e92:	80 ff ff 
ffff800000100e95:	ff d0                	call   *%rax
  }

  outb(CRTPORT, 14);
ffff800000100e97:	be 0e 00 00 00       	mov    $0xe,%esi
ffff800000100e9c:	bf d4 03 00 00       	mov    $0x3d4,%edi
ffff800000100ea1:	48 b8 08 06 10 00 00 	movabs $0xffff800000100608,%rax
ffff800000100ea8:	80 ff ff 
ffff800000100eab:	ff d0                	call   *%rax
  outb(CRTPORT+1, pos>>8);
ffff800000100ead:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000100eb0:	c1 f8 08             	sar    $0x8,%eax
ffff800000100eb3:	0f b6 c0             	movzbl %al,%eax
ffff800000100eb6:	89 c6                	mov    %eax,%esi
ffff800000100eb8:	bf d5 03 00 00       	mov    $0x3d5,%edi
ffff800000100ebd:	48 b8 08 06 10 00 00 	movabs $0xffff800000100608,%rax
ffff800000100ec4:	80 ff ff 
ffff800000100ec7:	ff d0                	call   *%rax
  outb(CRTPORT, 15);
ffff800000100ec9:	be 0f 00 00 00       	mov    $0xf,%esi
ffff800000100ece:	bf d4 03 00 00       	mov    $0x3d4,%edi
ffff800000100ed3:	48 b8 08 06 10 00 00 	movabs $0xffff800000100608,%rax
ffff800000100eda:	80 ff ff 
ffff800000100edd:	ff d0                	call   *%rax
  outb(CRTPORT+1, pos);
ffff800000100edf:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000100ee2:	0f b6 c0             	movzbl %al,%eax
ffff800000100ee5:	89 c6                	mov    %eax,%esi
ffff800000100ee7:	bf d5 03 00 00       	mov    $0x3d5,%edi
ffff800000100eec:	48 b8 08 06 10 00 00 	movabs $0xffff800000100608,%rax
ffff800000100ef3:	80 ff ff 
ffff800000100ef6:	ff d0                	call   *%rax
  crt[pos] = ' ' | 0x0700;
ffff800000100ef8:	48 b8 18 e0 10 00 00 	movabs $0xffff80000010e018,%rax
ffff800000100eff:	80 ff ff 
ffff800000100f02:	48 8b 00             	mov    (%rax),%rax
ffff800000100f05:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000100f08:	48 63 d2             	movslq %edx,%rdx
ffff800000100f0b:	48 01 d2             	add    %rdx,%rdx
ffff800000100f0e:	48 01 d0             	add    %rdx,%rax
ffff800000100f11:	66 c7 00 20 07       	movw   $0x720,(%rax)
}
ffff800000100f16:	90                   	nop
ffff800000100f17:	c9                   	leave
ffff800000100f18:	c3                   	ret

ffff800000100f19 <consputc>:

  void
consputc(int c)
{
ffff800000100f19:	f3 0f 1e fa          	endbr64
ffff800000100f1d:	55                   	push   %rbp
ffff800000100f1e:	48 89 e5             	mov    %rsp,%rbp
ffff800000100f21:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000100f25:	89 7d fc             	mov    %edi,-0x4(%rbp)
  if (panicked) {
ffff800000100f28:	48 b8 b8 44 11 00 00 	movabs $0xffff8000001144b8,%rax
ffff800000100f2f:	80 ff ff 
ffff800000100f32:	8b 00                	mov    (%rax),%eax
ffff800000100f34:	85 c0                	test   %eax,%eax
ffff800000100f36:	74 1a                	je     ffff800000100f52 <consputc+0x39>
    cli();
ffff800000100f38:	48 b8 86 06 10 00 00 	movabs $0xffff800000100686,%rax
ffff800000100f3f:	80 ff ff 
ffff800000100f42:	ff d0                	call   *%rax
    for(;;)
      hlt();
ffff800000100f44:	48 b8 92 06 10 00 00 	movabs $0xffff800000100692,%rax
ffff800000100f4b:	80 ff ff 
ffff800000100f4e:	ff d0                	call   *%rax
ffff800000100f50:	eb f2                	jmp    ffff800000100f44 <consputc+0x2b>
  }

  if (c == BACKSPACE) {
ffff800000100f52:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
ffff800000100f59:	75 35                	jne    ffff800000100f90 <consputc+0x77>
    uartputc('\b'); uartputc(' '); uartputc('\b');
ffff800000100f5b:	bf 08 00 00 00       	mov    $0x8,%edi
ffff800000100f60:	48 b8 31 ae 10 00 00 	movabs $0xffff80000010ae31,%rax
ffff800000100f67:	80 ff ff 
ffff800000100f6a:	ff d0                	call   *%rax
ffff800000100f6c:	bf 20 00 00 00       	mov    $0x20,%edi
ffff800000100f71:	48 b8 31 ae 10 00 00 	movabs $0xffff80000010ae31,%rax
ffff800000100f78:	80 ff ff 
ffff800000100f7b:	ff d0                	call   *%rax
ffff800000100f7d:	bf 08 00 00 00       	mov    $0x8,%edi
ffff800000100f82:	48 b8 31 ae 10 00 00 	movabs $0xffff80000010ae31,%rax
ffff800000100f89:	80 ff ff 
ffff800000100f8c:	ff d0                	call   *%rax
ffff800000100f8e:	eb 11                	jmp    ffff800000100fa1 <consputc+0x88>
  } else
    uartputc(c);
ffff800000100f90:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000100f93:	89 c7                	mov    %eax,%edi
ffff800000100f95:	48 b8 31 ae 10 00 00 	movabs $0xffff80000010ae31,%rax
ffff800000100f9c:	80 ff ff 
ffff800000100f9f:	ff d0                	call   *%rax
  cgaputc(c);
ffff800000100fa1:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000100fa4:	89 c7                	mov    %eax,%edi
ffff800000100fa6:	48 b8 2c 0d 10 00 00 	movabs $0xffff800000100d2c,%rax
ffff800000100fad:	80 ff ff 
ffff800000100fb0:	ff d0                	call   *%rax
}
ffff800000100fb2:	90                   	nop
ffff800000100fb3:	c9                   	leave
ffff800000100fb4:	c3                   	ret

ffff800000100fb5 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

  void
consoleintr(int (*getc)(void))
{
ffff800000100fb5:	f3 0f 1e fa          	endbr64
ffff800000100fb9:	55                   	push   %rbp
ffff800000100fba:	48 89 e5             	mov    %rsp,%rbp
ffff800000100fbd:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000100fc1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int c;

  acquire(&input.lock);
ffff800000100fc5:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff800000100fcc:	80 ff ff 
ffff800000100fcf:	48 89 c7             	mov    %rax,%rdi
ffff800000100fd2:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff800000100fd9:	80 ff ff 
ffff800000100fdc:	ff d0                	call   *%rax
  while((c = getc()) >= 0){
ffff800000100fde:	e9 73 02 00 00       	jmp    ffff800000101256 <consoleintr+0x2a1>
    switch(c){
ffff800000100fe3:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
ffff800000100fe7:	0f 84 fd 00 00 00    	je     ffff8000001010ea <consoleintr+0x135>
ffff800000100fed:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
ffff800000100ff1:	0f 8f 54 01 00 00    	jg     ffff80000010114b <consoleintr+0x196>
ffff800000100ff7:	83 7d fc 1a          	cmpl   $0x1a,-0x4(%rbp)
ffff800000100ffb:	74 2f                	je     ffff80000010102c <consoleintr+0x77>
ffff800000100ffd:	83 7d fc 1a          	cmpl   $0x1a,-0x4(%rbp)
ffff800000101001:	0f 8f 44 01 00 00    	jg     ffff80000010114b <consoleintr+0x196>
ffff800000101007:	83 7d fc 15          	cmpl   $0x15,-0x4(%rbp)
ffff80000010100b:	74 7f                	je     ffff80000010108c <consoleintr+0xd7>
ffff80000010100d:	83 7d fc 15          	cmpl   $0x15,-0x4(%rbp)
ffff800000101011:	0f 8f 34 01 00 00    	jg     ffff80000010114b <consoleintr+0x196>
ffff800000101017:	83 7d fc 08          	cmpl   $0x8,-0x4(%rbp)
ffff80000010101b:	0f 84 c9 00 00 00    	je     ffff8000001010ea <consoleintr+0x135>
ffff800000101021:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
ffff800000101025:	74 20                	je     ffff800000101047 <consoleintr+0x92>
ffff800000101027:	e9 1f 01 00 00       	jmp    ffff80000010114b <consoleintr+0x196>
    case C('Z'): // reboot
      lidt(0,0);
ffff80000010102c:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000101031:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000101036:	48 b8 2b 06 10 00 00 	movabs $0xffff80000010062b,%rax
ffff80000010103d:	80 ff ff 
ffff800000101040:	ff d0                	call   *%rax
      break;
ffff800000101042:	e9 0f 02 00 00       	jmp    ffff800000101256 <consoleintr+0x2a1>
    case C('P'):  // Process listing.
      procdump();
ffff800000101047:	48 b8 1d 75 10 00 00 	movabs $0xffff80000010751d,%rax
ffff80000010104e:	80 ff ff 
ffff800000101051:	ff d0                	call   *%rax
      break;
ffff800000101053:	e9 fe 01 00 00       	jmp    ffff800000101256 <consoleintr+0x2a1>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
          input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
ffff800000101058:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff80000010105f:	80 ff ff 
ffff800000101062:	8b 80 f0 00 00 00    	mov    0xf0(%rax),%eax
ffff800000101068:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff80000010106b:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff800000101072:	80 ff ff 
ffff800000101075:	89 90 f0 00 00 00    	mov    %edx,0xf0(%rax)
        consputc(BACKSPACE);
ffff80000010107b:	bf 00 01 00 00       	mov    $0x100,%edi
ffff800000101080:	48 b8 19 0f 10 00 00 	movabs $0xffff800000100f19,%rax
ffff800000101087:	80 ff ff 
ffff80000010108a:	ff d0                	call   *%rax
      while(input.e != input.w &&
ffff80000010108c:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff800000101093:	80 ff ff 
ffff800000101096:	8b 90 f0 00 00 00    	mov    0xf0(%rax),%edx
ffff80000010109c:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff8000001010a3:	80 ff ff 
ffff8000001010a6:	8b 80 ec 00 00 00    	mov    0xec(%rax),%eax
ffff8000001010ac:	39 c2                	cmp    %eax,%edx
ffff8000001010ae:	0f 84 9b 01 00 00    	je     ffff80000010124f <consoleintr+0x29a>
          input.buf[(input.e-1) % INPUT_BUF] != '\n'){
ffff8000001010b4:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff8000001010bb:	80 ff ff 
ffff8000001010be:	8b 80 f0 00 00 00    	mov    0xf0(%rax),%eax
ffff8000001010c4:	83 e8 01             	sub    $0x1,%eax
ffff8000001010c7:	83 e0 7f             	and    $0x7f,%eax
ffff8000001010ca:	89 c2                	mov    %eax,%edx
ffff8000001010cc:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff8000001010d3:	80 ff ff 
ffff8000001010d6:	89 d2                	mov    %edx,%edx
ffff8000001010d8:	0f b6 44 10 68       	movzbl 0x68(%rax,%rdx,1),%eax
      while(input.e != input.w &&
ffff8000001010dd:	3c 0a                	cmp    $0xa,%al
ffff8000001010df:	0f 85 73 ff ff ff    	jne    ffff800000101058 <consoleintr+0xa3>
      }
      break;
ffff8000001010e5:	e9 65 01 00 00       	jmp    ffff80000010124f <consoleintr+0x29a>
    case C('H'): case '\x7f':  // Backspace
      if (input.e != input.w) {
ffff8000001010ea:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff8000001010f1:	80 ff ff 
ffff8000001010f4:	8b 90 f0 00 00 00    	mov    0xf0(%rax),%edx
ffff8000001010fa:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff800000101101:	80 ff ff 
ffff800000101104:	8b 80 ec 00 00 00    	mov    0xec(%rax),%eax
ffff80000010110a:	39 c2                	cmp    %eax,%edx
ffff80000010110c:	0f 84 40 01 00 00    	je     ffff800000101252 <consoleintr+0x29d>
        input.e--;
ffff800000101112:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff800000101119:	80 ff ff 
ffff80000010111c:	8b 80 f0 00 00 00    	mov    0xf0(%rax),%eax
ffff800000101122:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000101125:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff80000010112c:	80 ff ff 
ffff80000010112f:	89 90 f0 00 00 00    	mov    %edx,0xf0(%rax)
        consputc(BACKSPACE);
ffff800000101135:	bf 00 01 00 00       	mov    $0x100,%edi
ffff80000010113a:	48 b8 19 0f 10 00 00 	movabs $0xffff800000100f19,%rax
ffff800000101141:	80 ff ff 
ffff800000101144:	ff d0                	call   *%rax
      }
      break;
ffff800000101146:	e9 07 01 00 00       	jmp    ffff800000101252 <consoleintr+0x29d>
    default:
      if (c != 0 && input.e-input.r < INPUT_BUF) {
ffff80000010114b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff80000010114f:	0f 84 00 01 00 00    	je     ffff800000101255 <consoleintr+0x2a0>
ffff800000101155:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff80000010115c:	80 ff ff 
ffff80000010115f:	8b 90 f0 00 00 00    	mov    0xf0(%rax),%edx
ffff800000101165:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff80000010116c:	80 ff ff 
ffff80000010116f:	8b 80 e8 00 00 00    	mov    0xe8(%rax),%eax
ffff800000101175:	29 c2                	sub    %eax,%edx
ffff800000101177:	83 fa 7f             	cmp    $0x7f,%edx
ffff80000010117a:	0f 87 d5 00 00 00    	ja     ffff800000101255 <consoleintr+0x2a0>
        c = (c == '\r') ? '\n' : c;
ffff800000101180:	83 7d fc 0d          	cmpl   $0xd,-0x4(%rbp)
ffff800000101184:	74 05                	je     ffff80000010118b <consoleintr+0x1d6>
ffff800000101186:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000101189:	eb 05                	jmp    ffff800000101190 <consoleintr+0x1db>
ffff80000010118b:	b8 0a 00 00 00       	mov    $0xa,%eax
ffff800000101190:	89 45 fc             	mov    %eax,-0x4(%rbp)
        input.buf[input.e++ % INPUT_BUF] = c;
ffff800000101193:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff80000010119a:	80 ff ff 
ffff80000010119d:	8b 80 f0 00 00 00    	mov    0xf0(%rax),%eax
ffff8000001011a3:	8d 50 01             	lea    0x1(%rax),%edx
ffff8000001011a6:	48 b9 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rcx
ffff8000001011ad:	80 ff ff 
ffff8000001011b0:	89 91 f0 00 00 00    	mov    %edx,0xf0(%rcx)
ffff8000001011b6:	83 e0 7f             	and    $0x7f,%eax
ffff8000001011b9:	89 c2                	mov    %eax,%edx
ffff8000001011bb:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001011be:	89 c1                	mov    %eax,%ecx
ffff8000001011c0:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff8000001011c7:	80 ff ff 
ffff8000001011ca:	89 d2                	mov    %edx,%edx
ffff8000001011cc:	88 4c 10 68          	mov    %cl,0x68(%rax,%rdx,1)
        consputc(c);
ffff8000001011d0:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001011d3:	89 c7                	mov    %eax,%edi
ffff8000001011d5:	48 b8 19 0f 10 00 00 	movabs $0xffff800000100f19,%rax
ffff8000001011dc:	80 ff ff 
ffff8000001011df:	ff d0                	call   *%rax
        if (c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF) {
ffff8000001011e1:	83 7d fc 0a          	cmpl   $0xa,-0x4(%rbp)
ffff8000001011e5:	74 2d                	je     ffff800000101214 <consoleintr+0x25f>
ffff8000001011e7:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
ffff8000001011eb:	74 27                	je     ffff800000101214 <consoleintr+0x25f>
ffff8000001011ed:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff8000001011f4:	80 ff ff 
ffff8000001011f7:	8b 90 f0 00 00 00    	mov    0xf0(%rax),%edx
ffff8000001011fd:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff800000101204:	80 ff ff 
ffff800000101207:	8b 80 e8 00 00 00    	mov    0xe8(%rax),%eax
ffff80000010120d:	83 e8 80             	sub    $0xffffff80,%eax
ffff800000101210:	39 c2                	cmp    %eax,%edx
ffff800000101212:	75 41                	jne    ffff800000101255 <consoleintr+0x2a0>
          input.w = input.e;
ffff800000101214:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff80000010121b:	80 ff ff 
ffff80000010121e:	8b 80 f0 00 00 00    	mov    0xf0(%rax),%eax
ffff800000101224:	48 ba c0 43 11 00 00 	movabs $0xffff8000001143c0,%rdx
ffff80000010122b:	80 ff ff 
ffff80000010122e:	89 82 ec 00 00 00    	mov    %eax,0xec(%rdx)
          wakeup(&input.r);
ffff800000101234:	48 b8 a8 44 11 00 00 	movabs $0xffff8000001144a8,%rax
ffff80000010123b:	80 ff ff 
ffff80000010123e:	48 89 c7             	mov    %rax,%rdi
ffff800000101241:	48 b8 07 74 10 00 00 	movabs $0xffff800000107407,%rax
ffff800000101248:	80 ff ff 
ffff80000010124b:	ff d0                	call   *%rax
        }
      }
      break;
ffff80000010124d:	eb 06                	jmp    ffff800000101255 <consoleintr+0x2a0>
      break;
ffff80000010124f:	90                   	nop
ffff800000101250:	eb 04                	jmp    ffff800000101256 <consoleintr+0x2a1>
      break;
ffff800000101252:	90                   	nop
ffff800000101253:	eb 01                	jmp    ffff800000101256 <consoleintr+0x2a1>
      break;
ffff800000101255:	90                   	nop
  while((c = getc()) >= 0){
ffff800000101256:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010125a:	ff d0                	call   *%rax
ffff80000010125c:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff80000010125f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000101263:	0f 89 7a fd ff ff    	jns    ffff800000100fe3 <consoleintr+0x2e>
    }
  }
  release(&input.lock);
ffff800000101269:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff800000101270:	80 ff ff 
ffff800000101273:	48 89 c7             	mov    %rax,%rdi
ffff800000101276:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff80000010127d:	80 ff ff 
ffff800000101280:	ff d0                	call   *%rax
}
ffff800000101282:	90                   	nop
ffff800000101283:	c9                   	leave
ffff800000101284:	c3                   	ret

ffff800000101285 <consoleread>:

  int
consoleread(struct inode *ip, uint off, char *dst, int n)
{
ffff800000101285:	f3 0f 1e fa          	endbr64
ffff800000101289:	55                   	push   %rbp
ffff80000010128a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010128d:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000101291:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000101295:	89 75 e4             	mov    %esi,-0x1c(%rbp)
ffff800000101298:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
ffff80000010129c:	89 4d e0             	mov    %ecx,-0x20(%rbp)
  uint target;
  int c;

  iunlock(ip);
ffff80000010129f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001012a3:	48 89 c7             	mov    %rax,%rdi
ffff8000001012a6:	48 b8 79 2b 10 00 00 	movabs $0xffff800000102b79,%rax
ffff8000001012ad:	80 ff ff 
ffff8000001012b0:	ff d0                	call   *%rax
  target = n;
ffff8000001012b2:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff8000001012b5:	89 45 fc             	mov    %eax,-0x4(%rbp)
  acquire(&input.lock);
ffff8000001012b8:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff8000001012bf:	80 ff ff 
ffff8000001012c2:	48 89 c7             	mov    %rax,%rdi
ffff8000001012c5:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff8000001012cc:	80 ff ff 
ffff8000001012cf:	ff d0                	call   *%rax
  while(n > 0){
ffff8000001012d1:	e9 23 01 00 00       	jmp    ffff8000001013f9 <consoleread+0x174>
    while(input.r == input.w){
      if (proc->killed) {
ffff8000001012d6:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001012dd:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001012e1:	8b 40 40             	mov    0x40(%rax),%eax
ffff8000001012e4:	85 c0                	test   %eax,%eax
ffff8000001012e6:	74 36                	je     ffff80000010131e <consoleread+0x99>
        release(&input.lock);
ffff8000001012e8:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff8000001012ef:	80 ff ff 
ffff8000001012f2:	48 89 c7             	mov    %rax,%rdi
ffff8000001012f5:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff8000001012fc:	80 ff ff 
ffff8000001012ff:	ff d0                	call   *%rax
        ilock(ip);
ffff800000101301:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101305:	48 89 c7             	mov    %rax,%rdi
ffff800000101308:	48 b8 de 29 10 00 00 	movabs $0xffff8000001029de,%rax
ffff80000010130f:	80 ff ff 
ffff800000101312:	ff d0                	call   *%rax
        return -1;
ffff800000101314:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000101319:	e9 21 01 00 00       	jmp    ffff80000010143f <consoleread+0x1ba>
      }
      sleep(&input.r, &input.lock);
ffff80000010131e:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff800000101325:	80 ff ff 
ffff800000101328:	48 89 c6             	mov    %rax,%rsi
ffff80000010132b:	48 b8 a8 44 11 00 00 	movabs $0xffff8000001144a8,%rax
ffff800000101332:	80 ff ff 
ffff800000101335:	48 89 c7             	mov    %rax,%rdi
ffff800000101338:	48 b8 8a 72 10 00 00 	movabs $0xffff80000010728a,%rax
ffff80000010133f:	80 ff ff 
ffff800000101342:	ff d0                	call   *%rax
    while(input.r == input.w){
ffff800000101344:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff80000010134b:	80 ff ff 
ffff80000010134e:	8b 90 e8 00 00 00    	mov    0xe8(%rax),%edx
ffff800000101354:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff80000010135b:	80 ff ff 
ffff80000010135e:	8b 80 ec 00 00 00    	mov    0xec(%rax),%eax
ffff800000101364:	39 c2                	cmp    %eax,%edx
ffff800000101366:	0f 84 6a ff ff ff    	je     ffff8000001012d6 <consoleread+0x51>
    }
    c = input.buf[input.r++ % INPUT_BUF];
ffff80000010136c:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff800000101373:	80 ff ff 
ffff800000101376:	8b 80 e8 00 00 00    	mov    0xe8(%rax),%eax
ffff80000010137c:	8d 50 01             	lea    0x1(%rax),%edx
ffff80000010137f:	48 b9 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rcx
ffff800000101386:	80 ff ff 
ffff800000101389:	89 91 e8 00 00 00    	mov    %edx,0xe8(%rcx)
ffff80000010138f:	83 e0 7f             	and    $0x7f,%eax
ffff800000101392:	89 c2                	mov    %eax,%edx
ffff800000101394:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff80000010139b:	80 ff ff 
ffff80000010139e:	89 d2                	mov    %edx,%edx
ffff8000001013a0:	0f b6 44 10 68       	movzbl 0x68(%rax,%rdx,1),%eax
ffff8000001013a5:	0f be c0             	movsbl %al,%eax
ffff8000001013a8:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if (c == C('D')) {  // EOF
ffff8000001013ab:	83 7d f8 04          	cmpl   $0x4,-0x8(%rbp)
ffff8000001013af:	75 2d                	jne    ffff8000001013de <consoleread+0x159>
      if (n < target) {
ffff8000001013b1:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff8000001013b4:	3b 45 fc             	cmp    -0x4(%rbp),%eax
ffff8000001013b7:	73 4c                	jae    ffff800000101405 <consoleread+0x180>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
ffff8000001013b9:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff8000001013c0:	80 ff ff 
ffff8000001013c3:	8b 80 e8 00 00 00    	mov    0xe8(%rax),%eax
ffff8000001013c9:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff8000001013cc:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff8000001013d3:	80 ff ff 
ffff8000001013d6:	89 90 e8 00 00 00    	mov    %edx,0xe8(%rax)
      }
      break;
ffff8000001013dc:	eb 27                	jmp    ffff800000101405 <consoleread+0x180>
    }
    *dst++ = c;
ffff8000001013de:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001013e2:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff8000001013e6:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
ffff8000001013ea:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffff8000001013ed:	88 10                	mov    %dl,(%rax)
    --n;
ffff8000001013ef:	83 6d e0 01          	subl   $0x1,-0x20(%rbp)
    if (c == '\n')
ffff8000001013f3:	83 7d f8 0a          	cmpl   $0xa,-0x8(%rbp)
ffff8000001013f7:	74 0f                	je     ffff800000101408 <consoleread+0x183>
  while(n > 0){
ffff8000001013f9:	83 7d e0 00          	cmpl   $0x0,-0x20(%rbp)
ffff8000001013fd:	0f 8f 41 ff ff ff    	jg     ffff800000101344 <consoleread+0xbf>
ffff800000101403:	eb 04                	jmp    ffff800000101409 <consoleread+0x184>
      break;
ffff800000101405:	90                   	nop
ffff800000101406:	eb 01                	jmp    ffff800000101409 <consoleread+0x184>
      break;
ffff800000101408:	90                   	nop
  }
  release(&input.lock);
ffff800000101409:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff800000101410:	80 ff ff 
ffff800000101413:	48 89 c7             	mov    %rax,%rdi
ffff800000101416:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff80000010141d:	80 ff ff 
ffff800000101420:	ff d0                	call   *%rax
  ilock(ip);
ffff800000101422:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101426:	48 89 c7             	mov    %rax,%rdi
ffff800000101429:	48 b8 de 29 10 00 00 	movabs $0xffff8000001029de,%rax
ffff800000101430:	80 ff ff 
ffff800000101433:	ff d0                	call   *%rax

  return target - n;
ffff800000101435:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff800000101438:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010143b:	29 c2                	sub    %eax,%edx
ffff80000010143d:	89 d0                	mov    %edx,%eax
}
ffff80000010143f:	c9                   	leave
ffff800000101440:	c3                   	ret

ffff800000101441 <consolewrite>:

  int
consolewrite(struct inode *ip, uint off, char *buf, int n)
{
ffff800000101441:	f3 0f 1e fa          	endbr64
ffff800000101445:	55                   	push   %rbp
ffff800000101446:	48 89 e5             	mov    %rsp,%rbp
ffff800000101449:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010144d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000101451:	89 75 e4             	mov    %esi,-0x1c(%rbp)
ffff800000101454:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
ffff800000101458:	89 4d e0             	mov    %ecx,-0x20(%rbp)
  int i;

  iunlock(ip);
ffff80000010145b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010145f:	48 89 c7             	mov    %rax,%rdi
ffff800000101462:	48 b8 79 2b 10 00 00 	movabs $0xffff800000102b79,%rax
ffff800000101469:	80 ff ff 
ffff80000010146c:	ff d0                	call   *%rax
  acquire(&cons.lock);
ffff80000010146e:	48 b8 c0 44 11 00 00 	movabs $0xffff8000001144c0,%rax
ffff800000101475:	80 ff ff 
ffff800000101478:	48 89 c7             	mov    %rax,%rdi
ffff80000010147b:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff800000101482:	80 ff ff 
ffff800000101485:	ff d0                	call   *%rax
  for(i = 0; i < n; i++)
ffff800000101487:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010148e:	eb 28                	jmp    ffff8000001014b8 <consolewrite+0x77>
    consputc(buf[i] & 0xff);
ffff800000101490:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000101493:	48 63 d0             	movslq %eax,%rdx
ffff800000101496:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010149a:	48 01 d0             	add    %rdx,%rax
ffff80000010149d:	0f b6 00             	movzbl (%rax),%eax
ffff8000001014a0:	0f be c0             	movsbl %al,%eax
ffff8000001014a3:	0f b6 c0             	movzbl %al,%eax
ffff8000001014a6:	89 c7                	mov    %eax,%edi
ffff8000001014a8:	48 b8 19 0f 10 00 00 	movabs $0xffff800000100f19,%rax
ffff8000001014af:	80 ff ff 
ffff8000001014b2:	ff d0                	call   *%rax
  for(i = 0; i < n; i++)
ffff8000001014b4:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001014b8:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001014bb:	3b 45 e0             	cmp    -0x20(%rbp),%eax
ffff8000001014be:	7c d0                	jl     ffff800000101490 <consolewrite+0x4f>
  release(&cons.lock);
ffff8000001014c0:	48 b8 c0 44 11 00 00 	movabs $0xffff8000001144c0,%rax
ffff8000001014c7:	80 ff ff 
ffff8000001014ca:	48 89 c7             	mov    %rax,%rdi
ffff8000001014cd:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff8000001014d4:	80 ff ff 
ffff8000001014d7:	ff d0                	call   *%rax
  ilock(ip);
ffff8000001014d9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001014dd:	48 89 c7             	mov    %rax,%rdi
ffff8000001014e0:	48 b8 de 29 10 00 00 	movabs $0xffff8000001029de,%rax
ffff8000001014e7:	80 ff ff 
ffff8000001014ea:	ff d0                	call   *%rax

  return n;
ffff8000001014ec:	8b 45 e0             	mov    -0x20(%rbp),%eax
}
ffff8000001014ef:	c9                   	leave
ffff8000001014f0:	c3                   	ret

ffff8000001014f1 <consoleinit>:

  void
consoleinit(void)
{
ffff8000001014f1:	f3 0f 1e fa          	endbr64
ffff8000001014f5:	55                   	push   %rbp
ffff8000001014f6:	48 89 e5             	mov    %rsp,%rbp
  initlock(&cons.lock, "console");
ffff8000001014f9:	48 b8 b3 cf 10 00 00 	movabs $0xffff80000010cfb3,%rax
ffff800000101500:	80 ff ff 
ffff800000101503:	48 89 c6             	mov    %rax,%rsi
ffff800000101506:	48 b8 c0 44 11 00 00 	movabs $0xffff8000001144c0,%rax
ffff80000010150d:	80 ff ff 
ffff800000101510:	48 89 c7             	mov    %rax,%rdi
ffff800000101513:	48 b8 4f 7e 10 00 00 	movabs $0xffff800000107e4f,%rax
ffff80000010151a:	80 ff ff 
ffff80000010151d:	ff d0                	call   *%rax
  initlock(&input.lock, "input");
ffff80000010151f:	48 b8 bb cf 10 00 00 	movabs $0xffff80000010cfbb,%rax
ffff800000101526:	80 ff ff 
ffff800000101529:	48 89 c6             	mov    %rax,%rsi
ffff80000010152c:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff800000101533:	80 ff ff 
ffff800000101536:	48 89 c7             	mov    %rax,%rdi
ffff800000101539:	48 b8 4f 7e 10 00 00 	movabs $0xffff800000107e4f,%rax
ffff800000101540:	80 ff ff 
ffff800000101543:	ff d0                	call   *%rax

  devsw[CONSOLE].write = consolewrite;
ffff800000101545:	48 b8 40 45 11 00 00 	movabs $0xffff800000114540,%rax
ffff80000010154c:	80 ff ff 
ffff80000010154f:	48 ba 41 14 10 00 00 	movabs $0xffff800000101441,%rdx
ffff800000101556:	80 ff ff 
ffff800000101559:	48 89 50 18          	mov    %rdx,0x18(%rax)
  devsw[CONSOLE].read = consoleread;
ffff80000010155d:	48 b8 40 45 11 00 00 	movabs $0xffff800000114540,%rax
ffff800000101564:	80 ff ff 
ffff800000101567:	48 b9 85 12 10 00 00 	movabs $0xffff800000101285,%rcx
ffff80000010156e:	80 ff ff 
ffff800000101571:	48 89 48 10          	mov    %rcx,0x10(%rax)
  cons.locking = 1;
ffff800000101575:	48 b8 c0 44 11 00 00 	movabs $0xffff8000001144c0,%rax
ffff80000010157c:	80 ff ff 
ffff80000010157f:	c7 40 68 01 00 00 00 	movl   $0x1,0x68(%rax)

  ioapicenable(IRQ_KBD, 0);
ffff800000101586:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010158b:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000101590:	48 b8 2e 41 10 00 00 	movabs $0xffff80000010412e,%rax
ffff800000101597:	80 ff ff 
ffff80000010159a:	ff d0                	call   *%rax
}
ffff80000010159c:	90                   	nop
ffff80000010159d:	5d                   	pop    %rbp
ffff80000010159e:	c3                   	ret

ffff80000010159f <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
ffff80000010159f:	f3 0f 1e fa          	endbr64
ffff8000001015a3:	55                   	push   %rbp
ffff8000001015a4:	48 89 e5             	mov    %rsp,%rbp
ffff8000001015a7:	48 81 ec 00 02 00 00 	sub    $0x200,%rsp
ffff8000001015ae:	48 89 bd 08 fe ff ff 	mov    %rdi,-0x1f8(%rbp)
ffff8000001015b5:	48 89 b5 00 fe ff ff 	mov    %rsi,-0x200(%rbp)
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  oldpgdir = proc->pgdir;
ffff8000001015bc:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001015c3:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001015c7:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff8000001015cb:	48 89 45 b8          	mov    %rax,-0x48(%rbp)

  begin_op();
ffff8000001015cf:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001015d4:	48 ba e8 50 10 00 00 	movabs $0xffff8000001050e8,%rdx
ffff8000001015db:	80 ff ff 
ffff8000001015de:	ff d2                	call   *%rdx

  if((ip = namei(path)) == 0){
ffff8000001015e0:	48 8b 85 08 fe ff ff 	mov    -0x1f8(%rbp),%rax
ffff8000001015e7:	48 89 c7             	mov    %rax,%rdi
ffff8000001015ea:	48 b8 1d 39 10 00 00 	movabs $0xffff80000010391d,%rax
ffff8000001015f1:	80 ff ff 
ffff8000001015f4:	ff d0                	call   *%rax
ffff8000001015f6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
ffff8000001015fa:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
ffff8000001015ff:	75 1b                	jne    ffff80000010161c <exec+0x7d>
    end_op();
ffff800000101601:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000101606:	48 ba d4 51 10 00 00 	movabs $0xffff8000001051d4,%rdx
ffff80000010160d:	80 ff ff 
ffff800000101610:	ff d2                	call   *%rdx
    return -1;
ffff800000101612:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000101617:	e9 73 05 00 00       	jmp    ffff800000101b8f <exec+0x5f0>
  }
  ilock(ip);
ffff80000010161c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff800000101620:	48 89 c7             	mov    %rax,%rdi
ffff800000101623:	48 b8 de 29 10 00 00 	movabs $0xffff8000001029de,%rax
ffff80000010162a:	80 ff ff 
ffff80000010162d:	ff d0                	call   *%rax
  pgdir = 0;
ffff80000010162f:	48 c7 45 c0 00 00 00 	movq   $0x0,-0x40(%rbp)
ffff800000101636:	00 

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
ffff800000101637:	48 8d b5 50 fe ff ff 	lea    -0x1b0(%rbp),%rsi
ffff80000010163e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff800000101642:	b9 40 00 00 00       	mov    $0x40,%ecx
ffff800000101647:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010164c:	48 89 c7             	mov    %rax,%rdi
ffff80000010164f:	48 b8 63 30 10 00 00 	movabs $0xffff800000103063,%rax
ffff800000101656:	80 ff ff 
ffff800000101659:	ff d0                	call   *%rax
ffff80000010165b:	83 f8 40             	cmp    $0x40,%eax
ffff80000010165e:	0f 85 bc 04 00 00    	jne    ffff800000101b20 <exec+0x581>
    goto bad;
  if(elf.magic != ELF_MAGIC)
ffff800000101664:	8b 85 50 fe ff ff    	mov    -0x1b0(%rbp),%eax
ffff80000010166a:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
ffff80000010166f:	0f 85 ae 04 00 00    	jne    ffff800000101b23 <exec+0x584>
    goto bad;

  if((pgdir = setupkvm()) == 0)
ffff800000101675:	48 b8 1f bf 10 00 00 	movabs $0xffff80000010bf1f,%rax
ffff80000010167c:	80 ff ff 
ffff80000010167f:	ff d0                	call   *%rax
ffff800000101681:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
ffff800000101685:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
ffff80000010168a:	0f 84 96 04 00 00    	je     ffff800000101b26 <exec+0x587>
    goto bad;

  // Load program into memory.
  sz = PGSIZE; // skip the first page
ffff800000101690:	48 c7 45 d8 00 10 00 	movq   $0x1000,-0x28(%rbp)
ffff800000101697:	00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
ffff800000101698:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
ffff80000010169f:	48 8b 85 70 fe ff ff 	mov    -0x190(%rbp),%rax
ffff8000001016a6:	89 45 e8             	mov    %eax,-0x18(%rbp)
ffff8000001016a9:	e9 0f 01 00 00       	jmp    ffff8000001017bd <exec+0x21e>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
ffff8000001016ae:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffff8000001016b1:	48 8d b5 10 fe ff ff 	lea    -0x1f0(%rbp),%rsi
ffff8000001016b8:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff8000001016bc:	b9 38 00 00 00       	mov    $0x38,%ecx
ffff8000001016c1:	48 89 c7             	mov    %rax,%rdi
ffff8000001016c4:	48 b8 63 30 10 00 00 	movabs $0xffff800000103063,%rax
ffff8000001016cb:	80 ff ff 
ffff8000001016ce:	ff d0                	call   *%rax
ffff8000001016d0:	83 f8 38             	cmp    $0x38,%eax
ffff8000001016d3:	0f 85 50 04 00 00    	jne    ffff800000101b29 <exec+0x58a>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
ffff8000001016d9:	8b 85 10 fe ff ff    	mov    -0x1f0(%rbp),%eax
ffff8000001016df:	83 f8 01             	cmp    $0x1,%eax
ffff8000001016e2:	0f 85 c7 00 00 00    	jne    ffff8000001017af <exec+0x210>
      continue;
    if(ph.memsz < ph.filesz)
ffff8000001016e8:	48 8b 95 38 fe ff ff 	mov    -0x1c8(%rbp),%rdx
ffff8000001016ef:	48 8b 85 30 fe ff ff 	mov    -0x1d0(%rbp),%rax
ffff8000001016f6:	48 39 c2             	cmp    %rax,%rdx
ffff8000001016f9:	0f 82 2d 04 00 00    	jb     ffff800000101b2c <exec+0x58d>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
ffff8000001016ff:	48 8b 95 20 fe ff ff 	mov    -0x1e0(%rbp),%rdx
ffff800000101706:	48 8b 85 38 fe ff ff 	mov    -0x1c8(%rbp),%rax
ffff80000010170d:	48 01 c2             	add    %rax,%rdx
ffff800000101710:	48 8b 85 20 fe ff ff 	mov    -0x1e0(%rbp),%rax
ffff800000101717:	48 39 c2             	cmp    %rax,%rdx
ffff80000010171a:	0f 82 0f 04 00 00    	jb     ffff800000101b2f <exec+0x590>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
ffff800000101720:	48 8b 95 20 fe ff ff 	mov    -0x1e0(%rbp),%rdx
ffff800000101727:	48 8b 85 38 fe ff ff 	mov    -0x1c8(%rbp),%rax
ffff80000010172e:	48 01 c2             	add    %rax,%rdx
ffff800000101731:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff800000101735:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff800000101739:	48 89 ce             	mov    %rcx,%rsi
ffff80000010173c:	48 89 c7             	mov    %rax,%rdi
ffff80000010173f:	48 b8 96 c6 10 00 00 	movabs $0xffff80000010c696,%rax
ffff800000101746:	80 ff ff 
ffff800000101749:	ff d0                	call   *%rax
ffff80000010174b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
ffff80000010174f:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
ffff800000101754:	0f 84 d8 03 00 00    	je     ffff800000101b32 <exec+0x593>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
ffff80000010175a:	48 8b 85 20 fe ff ff 	mov    -0x1e0(%rbp),%rax
ffff800000101761:	25 ff 0f 00 00       	and    $0xfff,%eax
ffff800000101766:	48 85 c0             	test   %rax,%rax
ffff800000101769:	0f 85 c6 03 00 00    	jne    ffff800000101b35 <exec+0x596>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
ffff80000010176f:	48 8b 85 30 fe ff ff 	mov    -0x1d0(%rbp),%rax
ffff800000101776:	89 c7                	mov    %eax,%edi
ffff800000101778:	48 8b 85 18 fe ff ff 	mov    -0x1e8(%rbp),%rax
ffff80000010177f:	89 c1                	mov    %eax,%ecx
ffff800000101781:	48 8b 85 20 fe ff ff 	mov    -0x1e0(%rbp),%rax
ffff800000101788:	48 89 c6             	mov    %rax,%rsi
ffff80000010178b:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
ffff80000010178f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff800000101793:	41 89 f8             	mov    %edi,%r8d
ffff800000101796:	48 89 c7             	mov    %rax,%rdi
ffff800000101799:	48 b8 6a c5 10 00 00 	movabs $0xffff80000010c56a,%rax
ffff8000001017a0:	80 ff ff 
ffff8000001017a3:	ff d0                	call   *%rax
ffff8000001017a5:	85 c0                	test   %eax,%eax
ffff8000001017a7:	0f 88 8b 03 00 00    	js     ffff800000101b38 <exec+0x599>
ffff8000001017ad:	eb 01                	jmp    ffff8000001017b0 <exec+0x211>
      continue;
ffff8000001017af:	90                   	nop
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
ffff8000001017b0:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
ffff8000001017b4:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff8000001017b7:	83 c0 38             	add    $0x38,%eax
ffff8000001017ba:	89 45 e8             	mov    %eax,-0x18(%rbp)
ffff8000001017bd:	0f b7 85 88 fe ff ff 	movzwl -0x178(%rbp),%eax
ffff8000001017c4:	0f b7 c0             	movzwl %ax,%eax
ffff8000001017c7:	39 45 ec             	cmp    %eax,-0x14(%rbp)
ffff8000001017ca:	0f 8c de fe ff ff    	jl     ffff8000001016ae <exec+0x10f>
      goto bad;
  }
  iunlockput(ip);
ffff8000001017d0:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff8000001017d4:	48 89 c7             	mov    %rax,%rdi
ffff8000001017d7:	48 b8 e7 2c 10 00 00 	movabs $0xffff800000102ce7,%rax
ffff8000001017de:	80 ff ff 
ffff8000001017e1:	ff d0                	call   *%rax
  end_op();
ffff8000001017e3:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001017e8:	48 ba d4 51 10 00 00 	movabs $0xffff8000001051d4,%rdx
ffff8000001017ef:	80 ff ff 
ffff8000001017f2:	ff d2                	call   *%rdx
  ip = 0;
ffff8000001017f4:	48 c7 45 c8 00 00 00 	movq   $0x0,-0x38(%rbp)
ffff8000001017fb:	00 

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
ffff8000001017fc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000101800:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffff800000101806:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010180c:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
ffff800000101810:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000101814:	48 8d 90 00 20 00 00 	lea    0x2000(%rax),%rdx
ffff80000010181b:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff80000010181f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff800000101823:	48 89 ce             	mov    %rcx,%rsi
ffff800000101826:	48 89 c7             	mov    %rax,%rdi
ffff800000101829:	48 b8 96 c6 10 00 00 	movabs $0xffff80000010c696,%rax
ffff800000101830:	80 ff ff 
ffff800000101833:	ff d0                	call   *%rax
ffff800000101835:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
ffff800000101839:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
ffff80000010183e:	0f 84 f7 02 00 00    	je     ffff800000101b3b <exec+0x59c>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
ffff800000101844:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000101848:	48 2d 00 20 00 00    	sub    $0x2000,%rax
ffff80000010184e:	48 89 c2             	mov    %rax,%rdx
ffff800000101851:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff800000101855:	48 89 d6             	mov    %rdx,%rsi
ffff800000101858:	48 89 c7             	mov    %rax,%rdi
ffff80000010185b:	48 b8 16 cb 10 00 00 	movabs $0xffff80000010cb16,%rax
ffff800000101862:	80 ff ff 
ffff800000101865:	ff d0                	call   *%rax
  sp = sz;
ffff800000101867:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010186b:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
ffff80000010186f:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
ffff800000101876:	00 
ffff800000101877:	e9 c9 00 00 00       	jmp    ffff800000101945 <exec+0x3a6>
    if(argc >= MAXARG)
ffff80000010187c:	48 83 7d e0 1f       	cmpq   $0x1f,-0x20(%rbp)
ffff800000101881:	0f 87 b7 02 00 00    	ja     ffff800000101b3e <exec+0x59f>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~(sizeof(addr_t)-1);
ffff800000101887:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010188b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff800000101892:	00 
ffff800000101893:	48 8b 85 00 fe ff ff 	mov    -0x200(%rbp),%rax
ffff80000010189a:	48 01 d0             	add    %rdx,%rax
ffff80000010189d:	48 8b 00             	mov    (%rax),%rax
ffff8000001018a0:	48 89 c7             	mov    %rax,%rdi
ffff8000001018a3:	48 b8 77 85 10 00 00 	movabs $0xffff800000108577,%rax
ffff8000001018aa:	80 ff ff 
ffff8000001018ad:	ff d0                	call   *%rax
ffff8000001018af:	83 c0 01             	add    $0x1,%eax
ffff8000001018b2:	48 98                	cltq
ffff8000001018b4:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffff8000001018b8:	48 29 c2             	sub    %rax,%rdx
ffff8000001018bb:	48 89 d0             	mov    %rdx,%rax
ffff8000001018be:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
ffff8000001018c2:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
ffff8000001018c6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001018ca:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff8000001018d1:	00 
ffff8000001018d2:	48 8b 85 00 fe ff ff 	mov    -0x200(%rbp),%rax
ffff8000001018d9:	48 01 d0             	add    %rdx,%rax
ffff8000001018dc:	48 8b 00             	mov    (%rax),%rax
ffff8000001018df:	48 89 c7             	mov    %rax,%rdi
ffff8000001018e2:	48 b8 77 85 10 00 00 	movabs $0xffff800000108577,%rax
ffff8000001018e9:	80 ff ff 
ffff8000001018ec:	ff d0                	call   *%rax
ffff8000001018ee:	83 c0 01             	add    $0x1,%eax
ffff8000001018f1:	48 63 c8             	movslq %eax,%rcx
ffff8000001018f4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001018f8:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff8000001018ff:	00 
ffff800000101900:	48 8b 85 00 fe ff ff 	mov    -0x200(%rbp),%rax
ffff800000101907:	48 01 d0             	add    %rdx,%rax
ffff80000010190a:	48 8b 10             	mov    (%rax),%rdx
ffff80000010190d:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
ffff800000101911:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff800000101915:	48 89 c7             	mov    %rax,%rdi
ffff800000101918:	48 b8 94 cd 10 00 00 	movabs $0xffff80000010cd94,%rax
ffff80000010191f:	80 ff ff 
ffff800000101922:	ff d0                	call   *%rax
ffff800000101924:	85 c0                	test   %eax,%eax
ffff800000101926:	0f 88 15 02 00 00    	js     ffff800000101b41 <exec+0x5a2>
      goto bad;
    ustack[1+argc] = sp;
ffff80000010192c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000101930:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff800000101934:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000101938:	48 89 84 d5 90 fe ff 	mov    %rax,-0x170(%rbp,%rdx,8)
ffff80000010193f:	ff 
  for(argc = 0; argv[argc]; argc++) {
ffff800000101940:	48 83 45 e0 01       	addq   $0x1,-0x20(%rbp)
ffff800000101945:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000101949:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff800000101950:	00 
ffff800000101951:	48 8b 85 00 fe ff ff 	mov    -0x200(%rbp),%rax
ffff800000101958:	48 01 d0             	add    %rdx,%rax
ffff80000010195b:	48 8b 00             	mov    (%rax),%rax
ffff80000010195e:	48 85 c0             	test   %rax,%rax
ffff800000101961:	0f 85 15 ff ff ff    	jne    ffff80000010187c <exec+0x2dd>
  }
  ustack[1+argc] = 0;
ffff800000101967:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010196b:	48 83 c0 01          	add    $0x1,%rax
ffff80000010196f:	48 c7 84 c5 90 fe ff 	movq   $0x0,-0x170(%rbp,%rax,8)
ffff800000101976:	ff 00 00 00 00 

  ustack[0] = 0xffffffffffffffff;  // fake return PC
ffff80000010197b:	48 c7 85 90 fe ff ff 	movq   $0xffffffffffffffff,-0x170(%rbp)
ffff800000101982:	ff ff ff ff 

	// argc and argv for main() entry point
  proc->tf->rdi = argc;
ffff800000101986:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010198d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101991:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000101995:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000101999:	48 89 50 30          	mov    %rdx,0x30(%rax)
  proc->tf->rsi = sp - (argc+1)*sizeof(addr_t);
ffff80000010199d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001019a1:	48 83 c0 01          	add    $0x1,%rax
ffff8000001019a5:	48 8d 0c c5 00 00 00 	lea    0x0(,%rax,8),%rcx
ffff8000001019ac:	00 
ffff8000001019ad:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001019b4:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001019b8:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001019bc:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffff8000001019c0:	48 29 ca             	sub    %rcx,%rdx
ffff8000001019c3:	48 89 50 28          	mov    %rdx,0x28(%rax)

  sp -= (1+argc+1) * sizeof(addr_t);
ffff8000001019c7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001019cb:	48 83 c0 02          	add    $0x2,%rax
ffff8000001019cf:	48 c1 e0 03          	shl    $0x3,%rax
ffff8000001019d3:	48 29 45 d0          	sub    %rax,-0x30(%rbp)
  if(copyout(pgdir, sp, ustack, (1+argc+1)*sizeof(addr_t)) < 0)
ffff8000001019d7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001019db:	48 83 c0 02          	add    $0x2,%rax
ffff8000001019df:	48 8d 0c c5 00 00 00 	lea    0x0(,%rax,8),%rcx
ffff8000001019e6:	00 
ffff8000001019e7:	48 8d 95 90 fe ff ff 	lea    -0x170(%rbp),%rdx
ffff8000001019ee:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
ffff8000001019f2:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff8000001019f6:	48 89 c7             	mov    %rax,%rdi
ffff8000001019f9:	48 b8 94 cd 10 00 00 	movabs $0xffff80000010cd94,%rax
ffff800000101a00:	80 ff ff 
ffff800000101a03:	ff d0                	call   *%rax
ffff800000101a05:	85 c0                	test   %eax,%eax
ffff800000101a07:	0f 88 37 01 00 00    	js     ffff800000101b44 <exec+0x5a5>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
ffff800000101a0d:	48 8b 85 08 fe ff ff 	mov    -0x1f8(%rbp),%rax
ffff800000101a14:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000101a18:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101a1c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000101a20:	eb 1c                	jmp    ffff800000101a3e <exec+0x49f>
    if(*s == '/')
ffff800000101a22:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101a26:	0f b6 00             	movzbl (%rax),%eax
ffff800000101a29:	3c 2f                	cmp    $0x2f,%al
ffff800000101a2b:	75 0c                	jne    ffff800000101a39 <exec+0x49a>
      last = s+1;
ffff800000101a2d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101a31:	48 83 c0 01          	add    $0x1,%rax
ffff800000101a35:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(last=s=path; *s; s++)
ffff800000101a39:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffff800000101a3e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101a42:	0f b6 00             	movzbl (%rax),%eax
ffff800000101a45:	84 c0                	test   %al,%al
ffff800000101a47:	75 d9                	jne    ffff800000101a22 <exec+0x483>
  safestrcpy(proc->name, last, sizeof(proc->name));
ffff800000101a49:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101a50:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101a54:	48 8d 88 d0 00 00 00 	lea    0xd0(%rax),%rcx
ffff800000101a5b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000101a5f:	ba 10 00 00 00       	mov    $0x10,%edx
ffff800000101a64:	48 89 c6             	mov    %rax,%rsi
ffff800000101a67:	48 89 cf             	mov    %rcx,%rdi
ffff800000101a6a:	48 b8 10 85 10 00 00 	movabs $0xffff800000108510,%rax
ffff800000101a71:	80 ff ff 
ffff800000101a74:	ff d0                	call   *%rax

  // Commit to the user image.
  proc->pgdir = pgdir;
ffff800000101a76:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101a7d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101a81:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
ffff800000101a85:	48 89 50 08          	mov    %rdx,0x8(%rax)
  proc->sz = sz;
ffff800000101a89:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101a90:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101a94:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff800000101a98:	48 89 10             	mov    %rdx,(%rax)
  proc->tf->rip = elf.entry;  // main
ffff800000101a9b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101aa2:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101aa6:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000101aaa:	48 8b 95 68 fe ff ff 	mov    -0x198(%rbp),%rdx
ffff800000101ab1:	48 89 90 88 00 00 00 	mov    %rdx,0x88(%rax)
  proc->tf->rcx = elf.entry;
ffff800000101ab8:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101abf:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101ac3:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000101ac7:	48 8b 95 68 fe ff ff 	mov    -0x198(%rbp),%rdx
ffff800000101ace:	48 89 50 10          	mov    %rdx,0x10(%rax)
  proc->tf->rsp = sp;
ffff800000101ad2:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101ad9:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101add:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000101ae1:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffff800000101ae5:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
  switchuvm(proc);
ffff800000101aec:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101af3:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101af7:	48 89 c7             	mov    %rax,%rdi
ffff800000101afa:	48 b8 85 c0 10 00 00 	movabs $0xffff80000010c085,%rax
ffff800000101b01:	80 ff ff 
ffff800000101b04:	ff d0                	call   *%rax
  freevm(oldpgdir);
ffff800000101b06:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101b0a:	48 89 c7             	mov    %rax,%rdi
ffff800000101b0d:	48 b8 db c8 10 00 00 	movabs $0xffff80000010c8db,%rax
ffff800000101b14:	80 ff ff 
ffff800000101b17:	ff d0                	call   *%rax
  return 0;
ffff800000101b19:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000101b1e:	eb 6f                	jmp    ffff800000101b8f <exec+0x5f0>
    goto bad;
ffff800000101b20:	90                   	nop
ffff800000101b21:	eb 22                	jmp    ffff800000101b45 <exec+0x5a6>
    goto bad;
ffff800000101b23:	90                   	nop
ffff800000101b24:	eb 1f                	jmp    ffff800000101b45 <exec+0x5a6>
    goto bad;
ffff800000101b26:	90                   	nop
ffff800000101b27:	eb 1c                	jmp    ffff800000101b45 <exec+0x5a6>
      goto bad;
ffff800000101b29:	90                   	nop
ffff800000101b2a:	eb 19                	jmp    ffff800000101b45 <exec+0x5a6>
      goto bad;
ffff800000101b2c:	90                   	nop
ffff800000101b2d:	eb 16                	jmp    ffff800000101b45 <exec+0x5a6>
      goto bad;
ffff800000101b2f:	90                   	nop
ffff800000101b30:	eb 13                	jmp    ffff800000101b45 <exec+0x5a6>
      goto bad;
ffff800000101b32:	90                   	nop
ffff800000101b33:	eb 10                	jmp    ffff800000101b45 <exec+0x5a6>
      goto bad;
ffff800000101b35:	90                   	nop
ffff800000101b36:	eb 0d                	jmp    ffff800000101b45 <exec+0x5a6>
      goto bad;
ffff800000101b38:	90                   	nop
ffff800000101b39:	eb 0a                	jmp    ffff800000101b45 <exec+0x5a6>
    goto bad;
ffff800000101b3b:	90                   	nop
ffff800000101b3c:	eb 07                	jmp    ffff800000101b45 <exec+0x5a6>
      goto bad;
ffff800000101b3e:	90                   	nop
ffff800000101b3f:	eb 04                	jmp    ffff800000101b45 <exec+0x5a6>
      goto bad;
ffff800000101b41:	90                   	nop
ffff800000101b42:	eb 01                	jmp    ffff800000101b45 <exec+0x5a6>
    goto bad;
ffff800000101b44:	90                   	nop

 bad:
  if(pgdir)
ffff800000101b45:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
ffff800000101b4a:	74 13                	je     ffff800000101b5f <exec+0x5c0>
    freevm(pgdir);
ffff800000101b4c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff800000101b50:	48 89 c7             	mov    %rax,%rdi
ffff800000101b53:	48 b8 db c8 10 00 00 	movabs $0xffff80000010c8db,%rax
ffff800000101b5a:	80 ff ff 
ffff800000101b5d:	ff d0                	call   *%rax
  if(ip){
ffff800000101b5f:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
ffff800000101b64:	74 24                	je     ffff800000101b8a <exec+0x5eb>
    iunlockput(ip);
ffff800000101b66:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff800000101b6a:	48 89 c7             	mov    %rax,%rdi
ffff800000101b6d:	48 b8 e7 2c 10 00 00 	movabs $0xffff800000102ce7,%rax
ffff800000101b74:	80 ff ff 
ffff800000101b77:	ff d0                	call   *%rax
    end_op();
ffff800000101b79:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000101b7e:	48 ba d4 51 10 00 00 	movabs $0xffff8000001051d4,%rdx
ffff800000101b85:	80 ff ff 
ffff800000101b88:	ff d2                	call   *%rdx
  }
  return -1;
ffff800000101b8a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000101b8f:	c9                   	leave
ffff800000101b90:	c3                   	ret

ffff800000101b91 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
ffff800000101b91:	f3 0f 1e fa          	endbr64
ffff800000101b95:	55                   	push   %rbp
ffff800000101b96:	48 89 e5             	mov    %rsp,%rbp
  initlock(&ftable.lock, "ftable");
ffff800000101b99:	48 b8 c1 cf 10 00 00 	movabs $0xffff80000010cfc1,%rax
ffff800000101ba0:	80 ff ff 
ffff800000101ba3:	48 89 c6             	mov    %rax,%rsi
ffff800000101ba6:	48 b8 e0 45 11 00 00 	movabs $0xffff8000001145e0,%rax
ffff800000101bad:	80 ff ff 
ffff800000101bb0:	48 89 c7             	mov    %rax,%rdi
ffff800000101bb3:	48 b8 4f 7e 10 00 00 	movabs $0xffff800000107e4f,%rax
ffff800000101bba:	80 ff ff 
ffff800000101bbd:	ff d0                	call   *%rax
}
ffff800000101bbf:	90                   	nop
ffff800000101bc0:	5d                   	pop    %rbp
ffff800000101bc1:	c3                   	ret

ffff800000101bc2 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
ffff800000101bc2:	f3 0f 1e fa          	endbr64
ffff800000101bc6:	55                   	push   %rbp
ffff800000101bc7:	48 89 e5             	mov    %rsp,%rbp
ffff800000101bca:	48 83 ec 10          	sub    $0x10,%rsp
  struct file *f;

  acquire(&ftable.lock);
ffff800000101bce:	48 b8 e0 45 11 00 00 	movabs $0xffff8000001145e0,%rax
ffff800000101bd5:	80 ff ff 
ffff800000101bd8:	48 89 c7             	mov    %rax,%rdi
ffff800000101bdb:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff800000101be2:	80 ff ff 
ffff800000101be5:	ff d0                	call   *%rax
  for(f = ftable.file; f < ftable.file + NFILE; f++){
ffff800000101be7:	48 b8 48 46 11 00 00 	movabs $0xffff800000114648,%rax
ffff800000101bee:	80 ff ff 
ffff800000101bf1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000101bf5:	e9 8d 00 00 00       	jmp    ffff800000101c87 <filealloc+0xc5>
    if(f->ref == 0){
ffff800000101bfa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101bfe:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101c01:	85 c0                	test   %eax,%eax
ffff800000101c03:	75 7d                	jne    ffff800000101c82 <filealloc+0xc0>
      f->ref = 1;
ffff800000101c05:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101c09:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%rax)
      f->type = FD_NONE;
ffff800000101c10:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101c14:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
      f->readable = 0;
ffff800000101c1a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101c1e:	c6 40 08 00          	movb   $0x0,0x8(%rax)
      f->writable = 0;
ffff800000101c22:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101c26:	c6 40 09 00          	movb   $0x0,0x9(%rax)
      f->pipe = 0;
ffff800000101c2a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101c2e:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff800000101c35:	00 
      f->ip = 0;
ffff800000101c36:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101c3a:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
ffff800000101c41:	00 
      f->off = 0;
ffff800000101c42:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101c46:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%rax)
      f->remote_fd = -1;
ffff800000101c4d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101c51:	c7 40 24 ff ff ff ff 	movl   $0xffffffff,0x24(%rax)
      f->remote_owner = -1;
ffff800000101c58:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101c5c:	c7 40 28 ff ff ff ff 	movl   $0xffffffff,0x28(%rax)
      release(&ftable.lock);
ffff800000101c63:	48 b8 e0 45 11 00 00 	movabs $0xffff8000001145e0,%rax
ffff800000101c6a:	80 ff ff 
ffff800000101c6d:	48 89 c7             	mov    %rax,%rdi
ffff800000101c70:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff800000101c77:	80 ff ff 
ffff800000101c7a:	ff d0                	call   *%rax
      return f;
ffff800000101c7c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101c80:	eb 37                	jmp    ffff800000101cb9 <filealloc+0xf7>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
ffff800000101c82:	48 83 45 f8 30       	addq   $0x30,-0x8(%rbp)
ffff800000101c87:	48 b8 08 59 11 00 00 	movabs $0xffff800000115908,%rax
ffff800000101c8e:	80 ff ff 
ffff800000101c91:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000101c95:	0f 82 5f ff ff ff    	jb     ffff800000101bfa <filealloc+0x38>
    }
  }
  release(&ftable.lock);
ffff800000101c9b:	48 b8 e0 45 11 00 00 	movabs $0xffff8000001145e0,%rax
ffff800000101ca2:	80 ff ff 
ffff800000101ca5:	48 89 c7             	mov    %rax,%rdi
ffff800000101ca8:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff800000101caf:	80 ff ff 
ffff800000101cb2:	ff d0                	call   *%rax
  return 0;
ffff800000101cb4:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000101cb9:	c9                   	leave
ffff800000101cba:	c3                   	ret

ffff800000101cbb <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
ffff800000101cbb:	f3 0f 1e fa          	endbr64
ffff800000101cbf:	55                   	push   %rbp
ffff800000101cc0:	48 89 e5             	mov    %rsp,%rbp
ffff800000101cc3:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000101cc7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&ftable.lock);
ffff800000101ccb:	48 b8 e0 45 11 00 00 	movabs $0xffff8000001145e0,%rax
ffff800000101cd2:	80 ff ff 
ffff800000101cd5:	48 89 c7             	mov    %rax,%rdi
ffff800000101cd8:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff800000101cdf:	80 ff ff 
ffff800000101ce2:	ff d0                	call   *%rax
  if(f->ref < 1)
ffff800000101ce4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101ce8:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101ceb:	85 c0                	test   %eax,%eax
ffff800000101ced:	7f 19                	jg     ffff800000101d08 <filedup+0x4d>
    panic("filedup");
ffff800000101cef:	48 b8 c8 cf 10 00 00 	movabs $0xffff80000010cfc8,%rax
ffff800000101cf6:	80 ff ff 
ffff800000101cf9:	48 89 c7             	mov    %rax,%rdi
ffff800000101cfc:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000101d03:	80 ff ff 
ffff800000101d06:	ff d0                	call   *%rax
  f->ref++;
ffff800000101d08:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101d0c:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101d0f:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000101d12:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101d16:	89 50 04             	mov    %edx,0x4(%rax)
  release(&ftable.lock);
ffff800000101d19:	48 b8 e0 45 11 00 00 	movabs $0xffff8000001145e0,%rax
ffff800000101d20:	80 ff ff 
ffff800000101d23:	48 89 c7             	mov    %rax,%rdi
ffff800000101d26:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff800000101d2d:	80 ff ff 
ffff800000101d30:	ff d0                	call   *%rax
  return f;
ffff800000101d32:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000101d36:	c9                   	leave
ffff800000101d37:	c3                   	ret

ffff800000101d38 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
ffff800000101d38:	f3 0f 1e fa          	endbr64
ffff800000101d3c:	55                   	push   %rbp
ffff800000101d3d:	48 89 e5             	mov    %rsp,%rbp
ffff800000101d40:	53                   	push   %rbx
ffff800000101d41:	48 83 ec 48          	sub    $0x48,%rsp
ffff800000101d45:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
  struct file ff;

  acquire(&ftable.lock);
ffff800000101d49:	48 b8 e0 45 11 00 00 	movabs $0xffff8000001145e0,%rax
ffff800000101d50:	80 ff ff 
ffff800000101d53:	48 89 c7             	mov    %rax,%rdi
ffff800000101d56:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff800000101d5d:	80 ff ff 
ffff800000101d60:	ff d0                	call   *%rax
  if(f->ref < 1)
ffff800000101d62:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101d66:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101d69:	85 c0                	test   %eax,%eax
ffff800000101d6b:	7f 19                	jg     ffff800000101d86 <fileclose+0x4e>
    panic("fileclose");
ffff800000101d6d:	48 b8 d0 cf 10 00 00 	movabs $0xffff80000010cfd0,%rax
ffff800000101d74:	80 ff ff 
ffff800000101d77:	48 89 c7             	mov    %rax,%rdi
ffff800000101d7a:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000101d81:	80 ff ff 
ffff800000101d84:	ff d0                	call   *%rax
  if(--f->ref > 0){
ffff800000101d86:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101d8a:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101d8d:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000101d90:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101d94:	89 50 04             	mov    %edx,0x4(%rax)
ffff800000101d97:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101d9b:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101d9e:	85 c0                	test   %eax,%eax
ffff800000101da0:	7e 1e                	jle    ffff800000101dc0 <fileclose+0x88>
    release(&ftable.lock);
ffff800000101da2:	48 b8 e0 45 11 00 00 	movabs $0xffff8000001145e0,%rax
ffff800000101da9:	80 ff ff 
ffff800000101dac:	48 89 c7             	mov    %rax,%rdi
ffff800000101daf:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff800000101db6:	80 ff ff 
ffff800000101db9:	ff d0                	call   *%rax
ffff800000101dbb:	e9 da 00 00 00       	jmp    ffff800000101e9a <fileclose+0x162>
    return;
  }
  ff = *f;
ffff800000101dc0:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101dc4:	48 8b 08             	mov    (%rax),%rcx
ffff800000101dc7:	48 8b 58 08          	mov    0x8(%rax),%rbx
ffff800000101dcb:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
ffff800000101dcf:	48 89 5d c8          	mov    %rbx,-0x38(%rbp)
ffff800000101dd3:	48 8b 48 10          	mov    0x10(%rax),%rcx
ffff800000101dd7:	48 8b 58 18          	mov    0x18(%rax),%rbx
ffff800000101ddb:	48 89 4d d0          	mov    %rcx,-0x30(%rbp)
ffff800000101ddf:	48 89 5d d8          	mov    %rbx,-0x28(%rbp)
ffff800000101de3:	48 8b 50 28          	mov    0x28(%rax),%rdx
ffff800000101de7:	48 8b 40 20          	mov    0x20(%rax),%rax
ffff800000101deb:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff800000101def:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  f->ref = 0;
ffff800000101df3:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101df7:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%rax)
  f->type = FD_NONE;
ffff800000101dfe:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101e02:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  f->remote_fd = -1;
ffff800000101e08:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101e0c:	c7 40 24 ff ff ff ff 	movl   $0xffffffff,0x24(%rax)
  f->remote_owner = -1;
ffff800000101e13:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101e17:	c7 40 28 ff ff ff ff 	movl   $0xffffffff,0x28(%rax)
  release(&ftable.lock);
ffff800000101e1e:	48 b8 e0 45 11 00 00 	movabs $0xffff8000001145e0,%rax
ffff800000101e25:	80 ff ff 
ffff800000101e28:	48 89 c7             	mov    %rax,%rdi
ffff800000101e2b:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff800000101e32:	80 ff ff 
ffff800000101e35:	ff d0                	call   *%rax

  if(ff.type == FD_PIPE)
ffff800000101e37:	8b 45 c0             	mov    -0x40(%rbp),%eax
ffff800000101e3a:	83 f8 01             	cmp    $0x1,%eax
ffff800000101e3d:	75 1e                	jne    ffff800000101e5d <fileclose+0x125>
    pipeclose(ff.pipe, ff.writable);
ffff800000101e3f:	0f b6 45 c9          	movzbl -0x37(%rbp),%eax
ffff800000101e43:	0f be d0             	movsbl %al,%edx
ffff800000101e46:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000101e4a:	89 d6                	mov    %edx,%esi
ffff800000101e4c:	48 89 c7             	mov    %rax,%rdi
ffff800000101e4f:	48 b8 3d 60 10 00 00 	movabs $0xffff80000010603d,%rax
ffff800000101e56:	80 ff ff 
ffff800000101e59:	ff d0                	call   *%rax
ffff800000101e5b:	eb 3d                	jmp    ffff800000101e9a <fileclose+0x162>
  else if(ff.type == FD_INODE){
ffff800000101e5d:	8b 45 c0             	mov    -0x40(%rbp),%eax
ffff800000101e60:	83 f8 02             	cmp    $0x2,%eax
ffff800000101e63:	75 35                	jne    ffff800000101e9a <fileclose+0x162>
    begin_op();
ffff800000101e65:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000101e6a:	48 ba e8 50 10 00 00 	movabs $0xffff8000001050e8,%rdx
ffff800000101e71:	80 ff ff 
ffff800000101e74:	ff d2                	call   *%rdx
    iput(ff.ip);
ffff800000101e76:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000101e7a:	48 89 c7             	mov    %rax,%rdi
ffff800000101e7d:	48 b8 e9 2b 10 00 00 	movabs $0xffff800000102be9,%rax
ffff800000101e84:	80 ff ff 
ffff800000101e87:	ff d0                	call   *%rax
    end_op();
ffff800000101e89:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000101e8e:	48 ba d4 51 10 00 00 	movabs $0xffff8000001051d4,%rdx
ffff800000101e95:	80 ff ff 
ffff800000101e98:	ff d2                	call   *%rdx
  }
  else if(ff.type == FD_REMOTE){
    // Remote cleanup is handled by sys_close(), where the caller can still
    // send an IPC close request to fsserver before dropping the local file.
  }
}
ffff800000101e9a:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
ffff800000101e9e:	c9                   	leave
ffff800000101e9f:	c3                   	ret

ffff800000101ea0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
ffff800000101ea0:	f3 0f 1e fa          	endbr64
ffff800000101ea4:	55                   	push   %rbp
ffff800000101ea5:	48 89 e5             	mov    %rsp,%rbp
ffff800000101ea8:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000101eac:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000101eb0:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(f->type == FD_INODE){
ffff800000101eb4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101eb8:	8b 00                	mov    (%rax),%eax
ffff800000101eba:	83 f8 02             	cmp    $0x2,%eax
ffff800000101ebd:	75 53                	jne    ffff800000101f12 <filestat+0x72>
    ilock(f->ip);
ffff800000101ebf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101ec3:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101ec7:	48 89 c7             	mov    %rax,%rdi
ffff800000101eca:	48 b8 de 29 10 00 00 	movabs $0xffff8000001029de,%rax
ffff800000101ed1:	80 ff ff 
ffff800000101ed4:	ff d0                	call   *%rax
    stati(f->ip, st);
ffff800000101ed6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101eda:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101ede:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000101ee2:	48 89 d6             	mov    %rdx,%rsi
ffff800000101ee5:	48 89 c7             	mov    %rax,%rdi
ffff800000101ee8:	48 b8 f9 2f 10 00 00 	movabs $0xffff800000102ff9,%rax
ffff800000101eef:	80 ff ff 
ffff800000101ef2:	ff d0                	call   *%rax
    iunlock(f->ip);
ffff800000101ef4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101ef8:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101efc:	48 89 c7             	mov    %rax,%rdi
ffff800000101eff:	48 b8 79 2b 10 00 00 	movabs $0xffff800000102b79,%rax
ffff800000101f06:	80 ff ff 
ffff800000101f09:	ff d0                	call   *%rax
    return 0;
ffff800000101f0b:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000101f10:	eb 05                	jmp    ffff800000101f17 <filestat+0x77>
  }
  return -1;
ffff800000101f12:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000101f17:	c9                   	leave
ffff800000101f18:	c3                   	ret

ffff800000101f19 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
ffff800000101f19:	f3 0f 1e fa          	endbr64
ffff800000101f1d:	55                   	push   %rbp
ffff800000101f1e:	48 89 e5             	mov    %rsp,%rbp
ffff800000101f21:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000101f25:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000101f29:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000101f2d:	89 55 dc             	mov    %edx,-0x24(%rbp)
  int r;

  if(f->readable == 0)
ffff800000101f30:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101f34:	0f b6 40 08          	movzbl 0x8(%rax),%eax
ffff800000101f38:	84 c0                	test   %al,%al
ffff800000101f3a:	75 0a                	jne    ffff800000101f46 <fileread+0x2d>
    return -1;
ffff800000101f3c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000101f41:	e9 c9 00 00 00       	jmp    ffff80000010200f <fileread+0xf6>
  if(f->type == FD_PIPE)
ffff800000101f46:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101f4a:	8b 00                	mov    (%rax),%eax
ffff800000101f4c:	83 f8 01             	cmp    $0x1,%eax
ffff800000101f4f:	75 26                	jne    ffff800000101f77 <fileread+0x5e>
    return piperead(f->pipe, addr, n);
ffff800000101f51:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101f55:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000101f59:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffff800000101f5c:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff800000101f60:	48 89 ce             	mov    %rcx,%rsi
ffff800000101f63:	48 89 c7             	mov    %rax,%rdi
ffff800000101f66:	48 b8 58 62 10 00 00 	movabs $0xffff800000106258,%rax
ffff800000101f6d:	80 ff ff 
ffff800000101f70:	ff d0                	call   *%rax
ffff800000101f72:	e9 98 00 00 00       	jmp    ffff80000010200f <fileread+0xf6>
  if(f->type == FD_INODE){
ffff800000101f77:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101f7b:	8b 00                	mov    (%rax),%eax
ffff800000101f7d:	83 f8 02             	cmp    $0x2,%eax
ffff800000101f80:	75 74                	jne    ffff800000101ff6 <fileread+0xdd>
    ilock(f->ip);
ffff800000101f82:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101f86:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101f8a:	48 89 c7             	mov    %rax,%rdi
ffff800000101f8d:	48 b8 de 29 10 00 00 	movabs $0xffff8000001029de,%rax
ffff800000101f94:	80 ff ff 
ffff800000101f97:	ff d0                	call   *%rax
    if((r = readi(f->ip, addr, f->off, n)) > 0)
ffff800000101f99:	8b 4d dc             	mov    -0x24(%rbp),%ecx
ffff800000101f9c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101fa0:	8b 50 20             	mov    0x20(%rax),%edx
ffff800000101fa3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101fa7:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101fab:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
ffff800000101faf:	48 89 c7             	mov    %rax,%rdi
ffff800000101fb2:	48 b8 63 30 10 00 00 	movabs $0xffff800000103063,%rax
ffff800000101fb9:	80 ff ff 
ffff800000101fbc:	ff d0                	call   *%rax
ffff800000101fbe:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000101fc1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000101fc5:	7e 13                	jle    ffff800000101fda <fileread+0xc1>
      f->off += r;
ffff800000101fc7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101fcb:	8b 50 20             	mov    0x20(%rax),%edx
ffff800000101fce:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000101fd1:	01 c2                	add    %eax,%edx
ffff800000101fd3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101fd7:	89 50 20             	mov    %edx,0x20(%rax)
    iunlock(f->ip);
ffff800000101fda:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101fde:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101fe2:	48 89 c7             	mov    %rax,%rdi
ffff800000101fe5:	48 b8 79 2b 10 00 00 	movabs $0xffff800000102b79,%rax
ffff800000101fec:	80 ff ff 
ffff800000101fef:	ff d0                	call   *%rax
    return r;
ffff800000101ff1:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000101ff4:	eb 19                	jmp    ffff80000010200f <fileread+0xf6>
  }
  panic("fileread");
ffff800000101ff6:	48 b8 da cf 10 00 00 	movabs $0xffff80000010cfda,%rax
ffff800000101ffd:	80 ff ff 
ffff800000102000:	48 89 c7             	mov    %rax,%rdi
ffff800000102003:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010200a:	80 ff ff 
ffff80000010200d:	ff d0                	call   *%rax
}
ffff80000010200f:	c9                   	leave
ffff800000102010:	c3                   	ret

ffff800000102011 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
ffff800000102011:	f3 0f 1e fa          	endbr64
ffff800000102015:	55                   	push   %rbp
ffff800000102016:	48 89 e5             	mov    %rsp,%rbp
ffff800000102019:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010201d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000102021:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000102025:	89 55 dc             	mov    %edx,-0x24(%rbp)
  int r;

  if(f->writable == 0)
ffff800000102028:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010202c:	0f b6 40 09          	movzbl 0x9(%rax),%eax
ffff800000102030:	84 c0                	test   %al,%al
ffff800000102032:	75 0a                	jne    ffff80000010203e <filewrite+0x2d>
    return -1;
ffff800000102034:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000102039:	e9 6d 01 00 00       	jmp    ffff8000001021ab <filewrite+0x19a>
  if(f->type == FD_PIPE)
ffff80000010203e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102042:	8b 00                	mov    (%rax),%eax
ffff800000102044:	83 f8 01             	cmp    $0x1,%eax
ffff800000102047:	75 26                	jne    ffff80000010206f <filewrite+0x5e>
    return pipewrite(f->pipe, addr, n);
ffff800000102049:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010204d:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000102051:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffff800000102054:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff800000102058:	48 89 ce             	mov    %rcx,%rsi
ffff80000010205b:	48 89 c7             	mov    %rax,%rdi
ffff80000010205e:	48 b8 14 61 10 00 00 	movabs $0xffff800000106114,%rax
ffff800000102065:	80 ff ff 
ffff800000102068:	ff d0                	call   *%rax
ffff80000010206a:	e9 3c 01 00 00       	jmp    ffff8000001021ab <filewrite+0x19a>
  if(f->type == FD_INODE){
ffff80000010206f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102073:	8b 00                	mov    (%rax),%eax
ffff800000102075:	83 f8 02             	cmp    $0x2,%eax
ffff800000102078:	0f 85 14 01 00 00    	jne    ffff800000102192 <filewrite+0x181>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
ffff80000010207e:	c7 45 f4 00 1a 00 00 	movl   $0x1a00,-0xc(%rbp)
    int i = 0;
ffff800000102085:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    while(i < n){
ffff80000010208c:	e9 de 00 00 00       	jmp    ffff80000010216f <filewrite+0x15e>
      int n1 = n - i;
ffff800000102091:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000102094:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff800000102097:	89 45 f8             	mov    %eax,-0x8(%rbp)
      if(n1 > max)
ffff80000010209a:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff80000010209d:	3b 45 f4             	cmp    -0xc(%rbp),%eax
ffff8000001020a0:	7e 06                	jle    ffff8000001020a8 <filewrite+0x97>
        n1 = max;
ffff8000001020a2:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff8000001020a5:	89 45 f8             	mov    %eax,-0x8(%rbp)

      begin_op();
ffff8000001020a8:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001020ad:	48 ba e8 50 10 00 00 	movabs $0xffff8000001050e8,%rdx
ffff8000001020b4:	80 ff ff 
ffff8000001020b7:	ff d2                	call   *%rdx
      ilock(f->ip);
ffff8000001020b9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001020bd:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff8000001020c1:	48 89 c7             	mov    %rax,%rdi
ffff8000001020c4:	48 b8 de 29 10 00 00 	movabs $0xffff8000001029de,%rax
ffff8000001020cb:	80 ff ff 
ffff8000001020ce:	ff d0                	call   *%rax
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
ffff8000001020d0:	8b 4d f8             	mov    -0x8(%rbp),%ecx
ffff8000001020d3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001020d7:	8b 50 20             	mov    0x20(%rax),%edx
ffff8000001020da:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001020dd:	48 63 f0             	movslq %eax,%rsi
ffff8000001020e0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001020e4:	48 01 c6             	add    %rax,%rsi
ffff8000001020e7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001020eb:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff8000001020ef:	48 89 c7             	mov    %rax,%rdi
ffff8000001020f2:	48 b8 34 32 10 00 00 	movabs $0xffff800000103234,%rax
ffff8000001020f9:	80 ff ff 
ffff8000001020fc:	ff d0                	call   *%rax
ffff8000001020fe:	89 45 f0             	mov    %eax,-0x10(%rbp)
ffff800000102101:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
ffff800000102105:	7e 13                	jle    ffff80000010211a <filewrite+0x109>
        f->off += r;
ffff800000102107:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010210b:	8b 50 20             	mov    0x20(%rax),%edx
ffff80000010210e:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000102111:	01 c2                	add    %eax,%edx
ffff800000102113:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102117:	89 50 20             	mov    %edx,0x20(%rax)
      iunlock(f->ip);
ffff80000010211a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010211e:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000102122:	48 89 c7             	mov    %rax,%rdi
ffff800000102125:	48 b8 79 2b 10 00 00 	movabs $0xffff800000102b79,%rax
ffff80000010212c:	80 ff ff 
ffff80000010212f:	ff d0                	call   *%rax
      end_op();
ffff800000102131:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000102136:	48 ba d4 51 10 00 00 	movabs $0xffff8000001051d4,%rdx
ffff80000010213d:	80 ff ff 
ffff800000102140:	ff d2                	call   *%rdx

      if(r < 0)
ffff800000102142:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
ffff800000102146:	78 35                	js     ffff80000010217d <filewrite+0x16c>
        break;
      if(r != n1)
ffff800000102148:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff80000010214b:	3b 45 f8             	cmp    -0x8(%rbp),%eax
ffff80000010214e:	74 19                	je     ffff800000102169 <filewrite+0x158>
        panic("short filewrite");
ffff800000102150:	48 b8 e3 cf 10 00 00 	movabs $0xffff80000010cfe3,%rax
ffff800000102157:	80 ff ff 
ffff80000010215a:	48 89 c7             	mov    %rax,%rdi
ffff80000010215d:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000102164:	80 ff ff 
ffff800000102167:	ff d0                	call   *%rax
      i += r;
ffff800000102169:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff80000010216c:	01 45 fc             	add    %eax,-0x4(%rbp)
    while(i < n){
ffff80000010216f:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102172:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffff800000102175:	0f 8c 16 ff ff ff    	jl     ffff800000102091 <filewrite+0x80>
ffff80000010217b:	eb 01                	jmp    ffff80000010217e <filewrite+0x16d>
        break;
ffff80000010217d:	90                   	nop
    }
    return i == n ? n : -1;
ffff80000010217e:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102181:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffff800000102184:	75 05                	jne    ffff80000010218b <filewrite+0x17a>
ffff800000102186:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000102189:	eb 20                	jmp    ffff8000001021ab <filewrite+0x19a>
ffff80000010218b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000102190:	eb 19                	jmp    ffff8000001021ab <filewrite+0x19a>
  }
  panic("filewrite");
ffff800000102192:	48 b8 f3 cf 10 00 00 	movabs $0xffff80000010cff3,%rax
ffff800000102199:	80 ff ff 
ffff80000010219c:	48 89 c7             	mov    %rax,%rdi
ffff80000010219f:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff8000001021a6:	80 ff ff 
ffff8000001021a9:	ff d0                	call   *%rax
}
ffff8000001021ab:	c9                   	leave
ffff8000001021ac:	c3                   	ret

ffff8000001021ad <readsb>:
struct superblock sb;

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
ffff8000001021ad:	f3 0f 1e fa          	endbr64
ffff8000001021b1:	55                   	push   %rbp
ffff8000001021b2:	48 89 e5             	mov    %rsp,%rbp
ffff8000001021b5:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001021b9:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff8000001021bc:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  struct buf *bp = bread(dev, 1);
ffff8000001021c0:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001021c3:	be 01 00 00 00       	mov    $0x1,%esi
ffff8000001021c8:	89 c7                	mov    %eax,%edi
ffff8000001021ca:	48 b8 d4 03 10 00 00 	movabs $0xffff8000001003d4,%rax
ffff8000001021d1:	80 ff ff 
ffff8000001021d4:	ff d0                	call   *%rax
ffff8000001021d6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memmove(sb, bp->data, sizeof(*sb));
ffff8000001021da:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001021de:	48 8d 88 b0 00 00 00 	lea    0xb0(%rax),%rcx
ffff8000001021e5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001021e9:	ba 1c 00 00 00       	mov    $0x1c,%edx
ffff8000001021ee:	48 89 ce             	mov    %rcx,%rsi
ffff8000001021f1:	48 89 c7             	mov    %rax,%rdi
ffff8000001021f4:	48 b8 4d 83 10 00 00 	movabs $0xffff80000010834d,%rax
ffff8000001021fb:	80 ff ff 
ffff8000001021fe:	ff d0                	call   *%rax
  brelse(bp);
ffff800000102200:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102204:	48 89 c7             	mov    %rax,%rdi
ffff800000102207:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff80000010220e:	80 ff ff 
ffff800000102211:	ff d0                	call   *%rax
}
ffff800000102213:	90                   	nop
ffff800000102214:	c9                   	leave
ffff800000102215:	c3                   	ret

ffff800000102216 <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
ffff800000102216:	f3 0f 1e fa          	endbr64
ffff80000010221a:	55                   	push   %rbp
ffff80000010221b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010221e:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000102222:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000102225:	89 75 e8             	mov    %esi,-0x18(%rbp)
  struct buf *bp = bread(dev, bno);
ffff800000102228:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffff80000010222b:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff80000010222e:	89 d6                	mov    %edx,%esi
ffff800000102230:	89 c7                	mov    %eax,%edi
ffff800000102232:	48 b8 d4 03 10 00 00 	movabs $0xffff8000001003d4,%rax
ffff800000102239:	80 ff ff 
ffff80000010223c:	ff d0                	call   *%rax
ffff80000010223e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(bp->data, 0, BSIZE);
ffff800000102242:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102246:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff80000010224c:	ba 00 02 00 00       	mov    $0x200,%edx
ffff800000102251:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000102256:	48 89 c7             	mov    %rax,%rdi
ffff800000102259:	48 b8 40 82 10 00 00 	movabs $0xffff800000108240,%rax
ffff800000102260:	80 ff ff 
ffff800000102263:	ff d0                	call   *%rax
  log_write(bp);
ffff800000102265:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102269:	48 89 c7             	mov    %rax,%rdi
ffff80000010226c:	48 b8 85 54 10 00 00 	movabs $0xffff800000105485,%rax
ffff800000102273:	80 ff ff 
ffff800000102276:	ff d0                	call   *%rax
  brelse(bp);
ffff800000102278:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010227c:	48 89 c7             	mov    %rax,%rdi
ffff80000010227f:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff800000102286:	80 ff ff 
ffff800000102289:	ff d0                	call   *%rax
}
ffff80000010228b:	90                   	nop
ffff80000010228c:	c9                   	leave
ffff80000010228d:	c3                   	ret

ffff80000010228e <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
ffff80000010228e:	f3 0f 1e fa          	endbr64
ffff800000102292:	55                   	push   %rbp
ffff800000102293:	48 89 e5             	mov    %rsp,%rbp
ffff800000102296:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010229a:	89 7d dc             	mov    %edi,-0x24(%rbp)
  int b, bi, m;
  struct buf *bp;
  for(b = 0; b < sb.size; b += BPB){
ffff80000010229d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001022a4:	e9 4a 01 00 00       	jmp    ffff8000001023f3 <balloc+0x165>
    bp = bread(dev, BBLOCK(b, sb));
ffff8000001022a9:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001022ac:	8d 90 ff 0f 00 00    	lea    0xfff(%rax),%edx
ffff8000001022b2:	85 c0                	test   %eax,%eax
ffff8000001022b4:	0f 48 c2             	cmovs  %edx,%eax
ffff8000001022b7:	c1 f8 0c             	sar    $0xc,%eax
ffff8000001022ba:	89 c2                	mov    %eax,%edx
ffff8000001022bc:	48 b8 20 59 11 00 00 	movabs $0xffff800000115920,%rax
ffff8000001022c3:	80 ff ff 
ffff8000001022c6:	8b 40 18             	mov    0x18(%rax),%eax
ffff8000001022c9:	01 c2                	add    %eax,%edx
ffff8000001022cb:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff8000001022ce:	89 d6                	mov    %edx,%esi
ffff8000001022d0:	89 c7                	mov    %eax,%edi
ffff8000001022d2:	48 b8 d4 03 10 00 00 	movabs $0xffff8000001003d4,%rax
ffff8000001022d9:	80 ff ff 
ffff8000001022dc:	ff d0                	call   *%rax
ffff8000001022de:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
ffff8000001022e2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
ffff8000001022e9:	e9 c4 00 00 00       	jmp    ffff8000001023b2 <balloc+0x124>
      m = 1 << (bi % 8);
ffff8000001022ee:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff8000001022f1:	83 e0 07             	and    $0x7,%eax
ffff8000001022f4:	ba 01 00 00 00       	mov    $0x1,%edx
ffff8000001022f9:	89 c1                	mov    %eax,%ecx
ffff8000001022fb:	d3 e2                	shl    %cl,%edx
ffff8000001022fd:	89 d0                	mov    %edx,%eax
ffff8000001022ff:	89 45 ec             	mov    %eax,-0x14(%rbp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
ffff800000102302:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000102305:	8d 50 07             	lea    0x7(%rax),%edx
ffff800000102308:	85 c0                	test   %eax,%eax
ffff80000010230a:	0f 48 c2             	cmovs  %edx,%eax
ffff80000010230d:	c1 f8 03             	sar    $0x3,%eax
ffff800000102310:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000102314:	48 98                	cltq
ffff800000102316:	0f b6 84 02 b0 00 00 	movzbl 0xb0(%rdx,%rax,1),%eax
ffff80000010231d:	00 
ffff80000010231e:	0f b6 c0             	movzbl %al,%eax
ffff800000102321:	23 45 ec             	and    -0x14(%rbp),%eax
ffff800000102324:	85 c0                	test   %eax,%eax
ffff800000102326:	0f 85 82 00 00 00    	jne    ffff8000001023ae <balloc+0x120>
        bp->data[bi/8] |= m;  // Mark block in use.
ffff80000010232c:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff80000010232f:	8d 50 07             	lea    0x7(%rax),%edx
ffff800000102332:	85 c0                	test   %eax,%eax
ffff800000102334:	0f 48 c2             	cmovs  %edx,%eax
ffff800000102337:	c1 f8 03             	sar    $0x3,%eax
ffff80000010233a:	89 c1                	mov    %eax,%ecx
ffff80000010233c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000102340:	48 63 c1             	movslq %ecx,%rax
ffff800000102343:	0f b6 84 02 b0 00 00 	movzbl 0xb0(%rdx,%rax,1),%eax
ffff80000010234a:	00 
ffff80000010234b:	89 c2                	mov    %eax,%edx
ffff80000010234d:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000102350:	09 d0                	or     %edx,%eax
ffff800000102352:	89 c6                	mov    %eax,%esi
ffff800000102354:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000102358:	48 63 c1             	movslq %ecx,%rax
ffff80000010235b:	40 88 b4 02 b0 00 00 	mov    %sil,0xb0(%rdx,%rax,1)
ffff800000102362:	00 
        log_write(bp);
ffff800000102363:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102367:	48 89 c7             	mov    %rax,%rdi
ffff80000010236a:	48 b8 85 54 10 00 00 	movabs $0xffff800000105485,%rax
ffff800000102371:	80 ff ff 
ffff800000102374:	ff d0                	call   *%rax
        brelse(bp);
ffff800000102376:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010237a:	48 89 c7             	mov    %rax,%rdi
ffff80000010237d:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff800000102384:	80 ff ff 
ffff800000102387:	ff d0                	call   *%rax
        bzero(dev, b + bi);
ffff800000102389:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010238c:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff80000010238f:	01 c2                	add    %eax,%edx
ffff800000102391:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000102394:	89 d6                	mov    %edx,%esi
ffff800000102396:	89 c7                	mov    %eax,%edi
ffff800000102398:	48 b8 16 22 10 00 00 	movabs $0xffff800000102216,%rax
ffff80000010239f:	80 ff ff 
ffff8000001023a2:	ff d0                	call   *%rax
        return b + bi;
ffff8000001023a4:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001023a7:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff8000001023aa:	01 d0                	add    %edx,%eax
ffff8000001023ac:	eb 75                	jmp    ffff800000102423 <balloc+0x195>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
ffff8000001023ae:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
ffff8000001023b2:	81 7d f8 ff 0f 00 00 	cmpl   $0xfff,-0x8(%rbp)
ffff8000001023b9:	7f 1e                	jg     ffff8000001023d9 <balloc+0x14b>
ffff8000001023bb:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001023be:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff8000001023c1:	01 d0                	add    %edx,%eax
ffff8000001023c3:	89 c2                	mov    %eax,%edx
ffff8000001023c5:	48 b8 20 59 11 00 00 	movabs $0xffff800000115920,%rax
ffff8000001023cc:	80 ff ff 
ffff8000001023cf:	8b 00                	mov    (%rax),%eax
ffff8000001023d1:	39 c2                	cmp    %eax,%edx
ffff8000001023d3:	0f 82 15 ff ff ff    	jb     ffff8000001022ee <balloc+0x60>
      }
    }
    brelse(bp);
ffff8000001023d9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001023dd:	48 89 c7             	mov    %rax,%rdi
ffff8000001023e0:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff8000001023e7:	80 ff ff 
ffff8000001023ea:	ff d0                	call   *%rax
  for(b = 0; b < sb.size; b += BPB){
ffff8000001023ec:	81 45 fc 00 10 00 00 	addl   $0x1000,-0x4(%rbp)
ffff8000001023f3:	48 b8 20 59 11 00 00 	movabs $0xffff800000115920,%rax
ffff8000001023fa:	80 ff ff 
ffff8000001023fd:	8b 00                	mov    (%rax),%eax
ffff8000001023ff:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102402:	39 c2                	cmp    %eax,%edx
ffff800000102404:	0f 82 9f fe ff ff    	jb     ffff8000001022a9 <balloc+0x1b>
  }
  panic("balloc: out of blocks");
ffff80000010240a:	48 b8 fd cf 10 00 00 	movabs $0xffff80000010cffd,%rax
ffff800000102411:	80 ff ff 
ffff800000102414:	48 89 c7             	mov    %rax,%rdi
ffff800000102417:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010241e:	80 ff ff 
ffff800000102421:	ff d0                	call   *%rax
}
ffff800000102423:	c9                   	leave
ffff800000102424:	c3                   	ret

ffff800000102425 <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
ffff800000102425:	f3 0f 1e fa          	endbr64
ffff800000102429:	55                   	push   %rbp
ffff80000010242a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010242d:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000102431:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000102434:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int bi, m;

  readsb(dev, &sb);
ffff800000102437:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff80000010243a:	48 ba 20 59 11 00 00 	movabs $0xffff800000115920,%rdx
ffff800000102441:	80 ff ff 
ffff800000102444:	48 89 d6             	mov    %rdx,%rsi
ffff800000102447:	89 c7                	mov    %eax,%edi
ffff800000102449:	48 b8 ad 21 10 00 00 	movabs $0xffff8000001021ad,%rax
ffff800000102450:	80 ff ff 
ffff800000102453:	ff d0                	call   *%rax
  struct buf *bp = bread(dev, BBLOCK(b, sb));
ffff800000102455:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000102458:	c1 e8 0c             	shr    $0xc,%eax
ffff80000010245b:	89 c2                	mov    %eax,%edx
ffff80000010245d:	48 b8 20 59 11 00 00 	movabs $0xffff800000115920,%rax
ffff800000102464:	80 ff ff 
ffff800000102467:	8b 40 18             	mov    0x18(%rax),%eax
ffff80000010246a:	01 c2                	add    %eax,%edx
ffff80000010246c:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff80000010246f:	89 d6                	mov    %edx,%esi
ffff800000102471:	89 c7                	mov    %eax,%edi
ffff800000102473:	48 b8 d4 03 10 00 00 	movabs $0xffff8000001003d4,%rax
ffff80000010247a:	80 ff ff 
ffff80000010247d:	ff d0                	call   *%rax
ffff80000010247f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  bi = b % BPB;
ffff800000102483:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000102486:	25 ff 0f 00 00       	and    $0xfff,%eax
ffff80000010248b:	89 45 f4             	mov    %eax,-0xc(%rbp)
  m = 1 << (bi % 8);
ffff80000010248e:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000102491:	83 e0 07             	and    $0x7,%eax
ffff800000102494:	ba 01 00 00 00       	mov    $0x1,%edx
ffff800000102499:	89 c1                	mov    %eax,%ecx
ffff80000010249b:	d3 e2                	shl    %cl,%edx
ffff80000010249d:	89 d0                	mov    %edx,%eax
ffff80000010249f:	89 45 f0             	mov    %eax,-0x10(%rbp)
  if((bp->data[bi/8] & m) == 0)
ffff8000001024a2:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff8000001024a5:	8d 50 07             	lea    0x7(%rax),%edx
ffff8000001024a8:	85 c0                	test   %eax,%eax
ffff8000001024aa:	0f 48 c2             	cmovs  %edx,%eax
ffff8000001024ad:	c1 f8 03             	sar    $0x3,%eax
ffff8000001024b0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001024b4:	48 98                	cltq
ffff8000001024b6:	0f b6 84 02 b0 00 00 	movzbl 0xb0(%rdx,%rax,1),%eax
ffff8000001024bd:	00 
ffff8000001024be:	0f b6 c0             	movzbl %al,%eax
ffff8000001024c1:	23 45 f0             	and    -0x10(%rbp),%eax
ffff8000001024c4:	85 c0                	test   %eax,%eax
ffff8000001024c6:	75 19                	jne    ffff8000001024e1 <bfree+0xbc>
    panic("freeing free block");
ffff8000001024c8:	48 b8 13 d0 10 00 00 	movabs $0xffff80000010d013,%rax
ffff8000001024cf:	80 ff ff 
ffff8000001024d2:	48 89 c7             	mov    %rax,%rdi
ffff8000001024d5:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff8000001024dc:	80 ff ff 
ffff8000001024df:	ff d0                	call   *%rax
  bp->data[bi/8] &= ~m;
ffff8000001024e1:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff8000001024e4:	8d 50 07             	lea    0x7(%rax),%edx
ffff8000001024e7:	85 c0                	test   %eax,%eax
ffff8000001024e9:	0f 48 c2             	cmovs  %edx,%eax
ffff8000001024ec:	c1 f8 03             	sar    $0x3,%eax
ffff8000001024ef:	89 c1                	mov    %eax,%ecx
ffff8000001024f1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001024f5:	48 63 c1             	movslq %ecx,%rax
ffff8000001024f8:	0f b6 84 02 b0 00 00 	movzbl 0xb0(%rdx,%rax,1),%eax
ffff8000001024ff:	00 
ffff800000102500:	89 c2                	mov    %eax,%edx
ffff800000102502:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000102505:	f7 d0                	not    %eax
ffff800000102507:	21 d0                	and    %edx,%eax
ffff800000102509:	89 c6                	mov    %eax,%esi
ffff80000010250b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010250f:	48 63 c1             	movslq %ecx,%rax
ffff800000102512:	40 88 b4 02 b0 00 00 	mov    %sil,0xb0(%rdx,%rax,1)
ffff800000102519:	00 
  log_write(bp);
ffff80000010251a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010251e:	48 89 c7             	mov    %rax,%rdi
ffff800000102521:	48 b8 85 54 10 00 00 	movabs $0xffff800000105485,%rax
ffff800000102528:	80 ff ff 
ffff80000010252b:	ff d0                	call   *%rax
  brelse(bp);
ffff80000010252d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102531:	48 89 c7             	mov    %rax,%rdi
ffff800000102534:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff80000010253b:	80 ff ff 
ffff80000010253e:	ff d0                	call   *%rax
}
ffff800000102540:	90                   	nop
ffff800000102541:	c9                   	leave
ffff800000102542:	c3                   	ret

ffff800000102543 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
ffff800000102543:	f3 0f 1e fa          	endbr64
ffff800000102547:	55                   	push   %rbp
ffff800000102548:	48 89 e5             	mov    %rsp,%rbp
ffff80000010254b:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010254f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  int i = 0;
ffff800000102552:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)

  initlock(&icache.lock, "icache");
ffff800000102559:	48 b8 26 d0 10 00 00 	movabs $0xffff80000010d026,%rax
ffff800000102560:	80 ff ff 
ffff800000102563:	48 89 c6             	mov    %rax,%rsi
ffff800000102566:	48 b8 40 59 11 00 00 	movabs $0xffff800000115940,%rax
ffff80000010256d:	80 ff ff 
ffff800000102570:	48 89 c7             	mov    %rax,%rdi
ffff800000102573:	48 b8 4f 7e 10 00 00 	movabs $0xffff800000107e4f,%rax
ffff80000010257a:	80 ff ff 
ffff80000010257d:	ff d0                	call   *%rax
  for(i = 0; i < NINODE; i++) {
ffff80000010257f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000102586:	eb 53                	jmp    ffff8000001025db <iinit+0x98>
    initsleeplock(&icache.inode[i].lock, "inode");
ffff800000102588:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010258b:	48 63 d0             	movslq %eax,%rdx
ffff80000010258e:	48 89 d0             	mov    %rdx,%rax
ffff800000102591:	48 01 c0             	add    %rax,%rax
ffff800000102594:	48 01 d0             	add    %rdx,%rax
ffff800000102597:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010259e:	00 
ffff80000010259f:	48 01 d0             	add    %rdx,%rax
ffff8000001025a2:	48 c1 e0 03          	shl    $0x3,%rax
ffff8000001025a6:	48 8d 50 70          	lea    0x70(%rax),%rdx
ffff8000001025aa:	48 b8 40 59 11 00 00 	movabs $0xffff800000115940,%rax
ffff8000001025b1:	80 ff ff 
ffff8000001025b4:	48 01 d0             	add    %rdx,%rax
ffff8000001025b7:	48 83 c0 08          	add    $0x8,%rax
ffff8000001025bb:	48 ba 2d d0 10 00 00 	movabs $0xffff80000010d02d,%rdx
ffff8000001025c2:	80 ff ff 
ffff8000001025c5:	48 89 d6             	mov    %rdx,%rsi
ffff8000001025c8:	48 89 c7             	mov    %rax,%rdi
ffff8000001025cb:	48 b8 59 7c 10 00 00 	movabs $0xffff800000107c59,%rax
ffff8000001025d2:	80 ff ff 
ffff8000001025d5:	ff d0                	call   *%rax
  for(i = 0; i < NINODE; i++) {
ffff8000001025d7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001025db:	83 7d fc 31          	cmpl   $0x31,-0x4(%rbp)
ffff8000001025df:	7e a7                	jle    ffff800000102588 <iinit+0x45>
  }

  readsb(dev, &sb);
ffff8000001025e1:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001025e4:	48 ba 20 59 11 00 00 	movabs $0xffff800000115920,%rdx
ffff8000001025eb:	80 ff ff 
ffff8000001025ee:	48 89 d6             	mov    %rdx,%rsi
ffff8000001025f1:	89 c7                	mov    %eax,%edi
ffff8000001025f3:	48 b8 ad 21 10 00 00 	movabs $0xffff8000001021ad,%rax
ffff8000001025fa:	80 ff ff 
ffff8000001025fd:	ff d0                	call   *%rax
  /*cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);*/
}
ffff8000001025ff:	90                   	nop
ffff800000102600:	c9                   	leave
ffff800000102601:	c3                   	ret

ffff800000102602 <ialloc>:

// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
ffff800000102602:	f3 0f 1e fa          	endbr64
ffff800000102606:	55                   	push   %rbp
ffff800000102607:	48 89 e5             	mov    %rsp,%rbp
ffff80000010260a:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010260e:	89 7d dc             	mov    %edi,-0x24(%rbp)
ffff800000102611:	89 f0                	mov    %esi,%eax
ffff800000102613:	66 89 45 d8          	mov    %ax,-0x28(%rbp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
ffff800000102617:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
ffff80000010261e:	e9 d8 00 00 00       	jmp    ffff8000001026fb <ialloc+0xf9>
    bp = bread(dev, IBLOCK(inum, sb));
ffff800000102623:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102626:	48 98                	cltq
ffff800000102628:	48 c1 e8 03          	shr    $0x3,%rax
ffff80000010262c:	89 c2                	mov    %eax,%edx
ffff80000010262e:	48 b8 20 59 11 00 00 	movabs $0xffff800000115920,%rax
ffff800000102635:	80 ff ff 
ffff800000102638:	8b 40 14             	mov    0x14(%rax),%eax
ffff80000010263b:	01 c2                	add    %eax,%edx
ffff80000010263d:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000102640:	89 d6                	mov    %edx,%esi
ffff800000102642:	89 c7                	mov    %eax,%edi
ffff800000102644:	48 b8 d4 03 10 00 00 	movabs $0xffff8000001003d4,%rax
ffff80000010264b:	80 ff ff 
ffff80000010264e:	ff d0                	call   *%rax
ffff800000102650:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    dip = (struct dinode*)bp->data + inum%IPB;
ffff800000102654:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102658:	48 8d 90 b0 00 00 00 	lea    0xb0(%rax),%rdx
ffff80000010265f:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102662:	48 98                	cltq
ffff800000102664:	83 e0 07             	and    $0x7,%eax
ffff800000102667:	48 c1 e0 06          	shl    $0x6,%rax
ffff80000010266b:	48 01 d0             	add    %rdx,%rax
ffff80000010266e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if(dip->type == 0){  // a free inode
ffff800000102672:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102676:	0f b7 00             	movzwl (%rax),%eax
ffff800000102679:	66 85 c0             	test   %ax,%ax
ffff80000010267c:	75 66                	jne    ffff8000001026e4 <ialloc+0xe2>
      memset(dip, 0, sizeof(*dip));
ffff80000010267e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102682:	ba 40 00 00 00       	mov    $0x40,%edx
ffff800000102687:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010268c:	48 89 c7             	mov    %rax,%rdi
ffff80000010268f:	48 b8 40 82 10 00 00 	movabs $0xffff800000108240,%rax
ffff800000102696:	80 ff ff 
ffff800000102699:	ff d0                	call   *%rax
      dip->type = type;
ffff80000010269b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010269f:	0f b7 55 d8          	movzwl -0x28(%rbp),%edx
ffff8000001026a3:	66 89 10             	mov    %dx,(%rax)
      log_write(bp);   // mark it allocated on the disk
ffff8000001026a6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001026aa:	48 89 c7             	mov    %rax,%rdi
ffff8000001026ad:	48 b8 85 54 10 00 00 	movabs $0xffff800000105485,%rax
ffff8000001026b4:	80 ff ff 
ffff8000001026b7:	ff d0                	call   *%rax
      brelse(bp);
ffff8000001026b9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001026bd:	48 89 c7             	mov    %rax,%rdi
ffff8000001026c0:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff8000001026c7:	80 ff ff 
ffff8000001026ca:	ff d0                	call   *%rax
      return iget(dev, inum);
ffff8000001026cc:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001026cf:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff8000001026d2:	89 d6                	mov    %edx,%esi
ffff8000001026d4:	89 c7                	mov    %eax,%edi
ffff8000001026d6:	48 b8 44 28 10 00 00 	movabs $0xffff800000102844,%rax
ffff8000001026dd:	80 ff ff 
ffff8000001026e0:	ff d0                	call   *%rax
ffff8000001026e2:	eb 48                	jmp    ffff80000010272c <ialloc+0x12a>
    }
    brelse(bp);
ffff8000001026e4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001026e8:	48 89 c7             	mov    %rax,%rdi
ffff8000001026eb:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff8000001026f2:	80 ff ff 
ffff8000001026f5:	ff d0                	call   *%rax
  for(inum = 1; inum < sb.ninodes; inum++){
ffff8000001026f7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001026fb:	48 b8 20 59 11 00 00 	movabs $0xffff800000115920,%rax
ffff800000102702:	80 ff ff 
ffff800000102705:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000102708:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010270b:	39 c2                	cmp    %eax,%edx
ffff80000010270d:	0f 82 10 ff ff ff    	jb     ffff800000102623 <ialloc+0x21>
  }
  panic("ialloc: no inodes");
ffff800000102713:	48 b8 33 d0 10 00 00 	movabs $0xffff80000010d033,%rax
ffff80000010271a:	80 ff ff 
ffff80000010271d:	48 89 c7             	mov    %rax,%rdi
ffff800000102720:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000102727:	80 ff ff 
ffff80000010272a:	ff d0                	call   *%rax
}
ffff80000010272c:	c9                   	leave
ffff80000010272d:	c3                   	ret

ffff80000010272e <iupdate>:

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
ffff80000010272e:	f3 0f 1e fa          	endbr64
ffff800000102732:	55                   	push   %rbp
ffff800000102733:	48 89 e5             	mov    %rsp,%rbp
ffff800000102736:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010273a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
ffff80000010273e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102742:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000102745:	c1 e8 03             	shr    $0x3,%eax
ffff800000102748:	89 c2                	mov    %eax,%edx
ffff80000010274a:	48 b8 20 59 11 00 00 	movabs $0xffff800000115920,%rax
ffff800000102751:	80 ff ff 
ffff800000102754:	8b 40 14             	mov    0x14(%rax),%eax
ffff800000102757:	01 c2                	add    %eax,%edx
ffff800000102759:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010275d:	8b 00                	mov    (%rax),%eax
ffff80000010275f:	89 d6                	mov    %edx,%esi
ffff800000102761:	89 c7                	mov    %eax,%edi
ffff800000102763:	48 b8 d4 03 10 00 00 	movabs $0xffff8000001003d4,%rax
ffff80000010276a:	80 ff ff 
ffff80000010276d:	ff d0                	call   *%rax
ffff80000010276f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
ffff800000102773:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102777:	48 8d 90 b0 00 00 00 	lea    0xb0(%rax),%rdx
ffff80000010277e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102782:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000102785:	89 c0                	mov    %eax,%eax
ffff800000102787:	83 e0 07             	and    $0x7,%eax
ffff80000010278a:	48 c1 e0 06          	shl    $0x6,%rax
ffff80000010278e:	48 01 d0             	add    %rdx,%rax
ffff800000102791:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  dip->type = ip->type;
ffff800000102795:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102799:	0f b7 90 94 00 00 00 	movzwl 0x94(%rax),%edx
ffff8000001027a0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001027a4:	66 89 10             	mov    %dx,(%rax)
  dip->major = ip->major;
ffff8000001027a7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001027ab:	0f b7 90 96 00 00 00 	movzwl 0x96(%rax),%edx
ffff8000001027b2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001027b6:	66 89 50 02          	mov    %dx,0x2(%rax)
  dip->minor = ip->minor;
ffff8000001027ba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001027be:	0f b7 90 98 00 00 00 	movzwl 0x98(%rax),%edx
ffff8000001027c5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001027c9:	66 89 50 04          	mov    %dx,0x4(%rax)
  dip->nlink = ip->nlink;
ffff8000001027cd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001027d1:	0f b7 90 9a 00 00 00 	movzwl 0x9a(%rax),%edx
ffff8000001027d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001027dc:	66 89 50 06          	mov    %dx,0x6(%rax)
  dip->size = ip->size;
ffff8000001027e0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001027e4:	8b 90 9c 00 00 00    	mov    0x9c(%rax),%edx
ffff8000001027ea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001027ee:	89 50 08             	mov    %edx,0x8(%rax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
ffff8000001027f1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001027f5:	48 8d 88 a0 00 00 00 	lea    0xa0(%rax),%rcx
ffff8000001027fc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102800:	48 83 c0 0c          	add    $0xc,%rax
ffff800000102804:	ba 34 00 00 00       	mov    $0x34,%edx
ffff800000102809:	48 89 ce             	mov    %rcx,%rsi
ffff80000010280c:	48 89 c7             	mov    %rax,%rdi
ffff80000010280f:	48 b8 4d 83 10 00 00 	movabs $0xffff80000010834d,%rax
ffff800000102816:	80 ff ff 
ffff800000102819:	ff d0                	call   *%rax
  log_write(bp);
ffff80000010281b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010281f:	48 89 c7             	mov    %rax,%rdi
ffff800000102822:	48 b8 85 54 10 00 00 	movabs $0xffff800000105485,%rax
ffff800000102829:	80 ff ff 
ffff80000010282c:	ff d0                	call   *%rax
  brelse(bp);
ffff80000010282e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102832:	48 89 c7             	mov    %rax,%rdi
ffff800000102835:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff80000010283c:	80 ff ff 
ffff80000010283f:	ff d0                	call   *%rax
}
ffff800000102841:	90                   	nop
ffff800000102842:	c9                   	leave
ffff800000102843:	c3                   	ret

ffff800000102844 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
ffff800000102844:	f3 0f 1e fa          	endbr64
ffff800000102848:	55                   	push   %rbp
ffff800000102849:	48 89 e5             	mov    %rsp,%rbp
ffff80000010284c:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000102850:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000102853:	89 75 e8             	mov    %esi,-0x18(%rbp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
ffff800000102856:	48 b8 40 59 11 00 00 	movabs $0xffff800000115940,%rax
ffff80000010285d:	80 ff ff 
ffff800000102860:	48 89 c7             	mov    %rax,%rdi
ffff800000102863:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff80000010286a:	80 ff ff 
ffff80000010286d:	ff d0                	call   *%rax

  // Is the inode already cached?
  empty = 0;
ffff80000010286f:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
ffff800000102876:	00 
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
ffff800000102877:	48 b8 a8 59 11 00 00 	movabs $0xffff8000001159a8,%rax
ffff80000010287e:	80 ff ff 
ffff800000102881:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000102885:	eb 77                	jmp    ffff8000001028fe <iget+0xba>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
ffff800000102887:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010288b:	8b 40 08             	mov    0x8(%rax),%eax
ffff80000010288e:	85 c0                	test   %eax,%eax
ffff800000102890:	7e 4a                	jle    ffff8000001028dc <iget+0x98>
ffff800000102892:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102896:	8b 00                	mov    (%rax),%eax
ffff800000102898:	39 45 ec             	cmp    %eax,-0x14(%rbp)
ffff80000010289b:	75 3f                	jne    ffff8000001028dc <iget+0x98>
ffff80000010289d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001028a1:	8b 40 04             	mov    0x4(%rax),%eax
ffff8000001028a4:	39 45 e8             	cmp    %eax,-0x18(%rbp)
ffff8000001028a7:	75 33                	jne    ffff8000001028dc <iget+0x98>
      ip->ref++;
ffff8000001028a9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001028ad:	8b 40 08             	mov    0x8(%rax),%eax
ffff8000001028b0:	8d 50 01             	lea    0x1(%rax),%edx
ffff8000001028b3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001028b7:	89 50 08             	mov    %edx,0x8(%rax)
      release(&icache.lock);
ffff8000001028ba:	48 b8 40 59 11 00 00 	movabs $0xffff800000115940,%rax
ffff8000001028c1:	80 ff ff 
ffff8000001028c4:	48 89 c7             	mov    %rax,%rdi
ffff8000001028c7:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff8000001028ce:	80 ff ff 
ffff8000001028d1:	ff d0                	call   *%rax
      return ip;
ffff8000001028d3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001028d7:	e9 a7 00 00 00       	jmp    ffff800000102983 <iget+0x13f>
    }
    if(empty == 0 && ip->ref == 0) // Remember empty slot.
ffff8000001028dc:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff8000001028e1:	75 13                	jne    ffff8000001028f6 <iget+0xb2>
ffff8000001028e3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001028e7:	8b 40 08             	mov    0x8(%rax),%eax
ffff8000001028ea:	85 c0                	test   %eax,%eax
ffff8000001028ec:	75 08                	jne    ffff8000001028f6 <iget+0xb2>
      empty = ip;
ffff8000001028ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001028f2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
ffff8000001028f6:	48 81 45 f8 d8 00 00 	addq   $0xd8,-0x8(%rbp)
ffff8000001028fd:	00 
ffff8000001028fe:	48 b8 d8 83 11 00 00 	movabs $0xffff8000001183d8,%rax
ffff800000102905:	80 ff ff 
ffff800000102908:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff80000010290c:	0f 82 75 ff ff ff    	jb     ffff800000102887 <iget+0x43>
  }

  // Recycle an inode cache entry.
  if(empty == 0)
ffff800000102912:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000102917:	75 19                	jne    ffff800000102932 <iget+0xee>
    panic("iget: no inodes");
ffff800000102919:	48 b8 45 d0 10 00 00 	movabs $0xffff80000010d045,%rax
ffff800000102920:	80 ff ff 
ffff800000102923:	48 89 c7             	mov    %rax,%rdi
ffff800000102926:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010292d:	80 ff ff 
ffff800000102930:	ff d0                	call   *%rax

  ip = empty;
ffff800000102932:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102936:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  ip->dev = dev;
ffff80000010293a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010293e:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff800000102941:	89 10                	mov    %edx,(%rax)
  ip->inum = inum;
ffff800000102943:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102947:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffff80000010294a:	89 50 04             	mov    %edx,0x4(%rax)
  ip->ref = 1;
ffff80000010294d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102951:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%rax)
  ip->flags = 0;
ffff800000102958:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010295c:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%rax)
ffff800000102963:	00 00 00 
  release(&icache.lock);
ffff800000102966:	48 b8 40 59 11 00 00 	movabs $0xffff800000115940,%rax
ffff80000010296d:	80 ff ff 
ffff800000102970:	48 89 c7             	mov    %rax,%rdi
ffff800000102973:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff80000010297a:	80 ff ff 
ffff80000010297d:	ff d0                	call   *%rax

  return ip;
ffff80000010297f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000102983:	c9                   	leave
ffff800000102984:	c3                   	ret

ffff800000102985 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
ffff800000102985:	f3 0f 1e fa          	endbr64
ffff800000102989:	55                   	push   %rbp
ffff80000010298a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010298d:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000102991:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&icache.lock);
ffff800000102995:	48 b8 40 59 11 00 00 	movabs $0xffff800000115940,%rax
ffff80000010299c:	80 ff ff 
ffff80000010299f:	48 89 c7             	mov    %rax,%rdi
ffff8000001029a2:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff8000001029a9:	80 ff ff 
ffff8000001029ac:	ff d0                	call   *%rax
  ip->ref++;
ffff8000001029ae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001029b2:	8b 40 08             	mov    0x8(%rax),%eax
ffff8000001029b5:	8d 50 01             	lea    0x1(%rax),%edx
ffff8000001029b8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001029bc:	89 50 08             	mov    %edx,0x8(%rax)
  release(&icache.lock);
ffff8000001029bf:	48 b8 40 59 11 00 00 	movabs $0xffff800000115940,%rax
ffff8000001029c6:	80 ff ff 
ffff8000001029c9:	48 89 c7             	mov    %rax,%rdi
ffff8000001029cc:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff8000001029d3:	80 ff ff 
ffff8000001029d6:	ff d0                	call   *%rax
  return ip;
ffff8000001029d8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff8000001029dc:	c9                   	leave
ffff8000001029dd:	c3                   	ret

ffff8000001029de <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
ffff8000001029de:	f3 0f 1e fa          	endbr64
ffff8000001029e2:	55                   	push   %rbp
ffff8000001029e3:	48 89 e5             	mov    %rsp,%rbp
ffff8000001029e6:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001029ea:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
ffff8000001029ee:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff8000001029f3:	74 0b                	je     ffff800000102a00 <ilock+0x22>
ffff8000001029f5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001029f9:	8b 40 08             	mov    0x8(%rax),%eax
ffff8000001029fc:	85 c0                	test   %eax,%eax
ffff8000001029fe:	7f 19                	jg     ffff800000102a19 <ilock+0x3b>
    panic("ilock");
ffff800000102a00:	48 b8 55 d0 10 00 00 	movabs $0xffff80000010d055,%rax
ffff800000102a07:	80 ff ff 
ffff800000102a0a:	48 89 c7             	mov    %rax,%rdi
ffff800000102a0d:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000102a14:	80 ff ff 
ffff800000102a17:	ff d0                	call   *%rax

  acquiresleep(&ip->lock);
ffff800000102a19:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102a1d:	48 83 c0 10          	add    $0x10,%rax
ffff800000102a21:	48 89 c7             	mov    %rax,%rdi
ffff800000102a24:	48 b8 b5 7c 10 00 00 	movabs $0xffff800000107cb5,%rax
ffff800000102a2b:	80 ff ff 
ffff800000102a2e:	ff d0                	call   *%rax

  if(!(ip->flags & I_VALID)){
ffff800000102a30:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102a34:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
ffff800000102a3a:	83 e0 02             	and    $0x2,%eax
ffff800000102a3d:	85 c0                	test   %eax,%eax
ffff800000102a3f:	0f 85 31 01 00 00    	jne    ffff800000102b76 <ilock+0x198>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
ffff800000102a45:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102a49:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000102a4c:	c1 e8 03             	shr    $0x3,%eax
ffff800000102a4f:	89 c2                	mov    %eax,%edx
ffff800000102a51:	48 b8 20 59 11 00 00 	movabs $0xffff800000115920,%rax
ffff800000102a58:	80 ff ff 
ffff800000102a5b:	8b 40 14             	mov    0x14(%rax),%eax
ffff800000102a5e:	01 c2                	add    %eax,%edx
ffff800000102a60:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102a64:	8b 00                	mov    (%rax),%eax
ffff800000102a66:	89 d6                	mov    %edx,%esi
ffff800000102a68:	89 c7                	mov    %eax,%edi
ffff800000102a6a:	48 b8 d4 03 10 00 00 	movabs $0xffff8000001003d4,%rax
ffff800000102a71:	80 ff ff 
ffff800000102a74:	ff d0                	call   *%rax
ffff800000102a76:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
ffff800000102a7a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102a7e:	48 8d 90 b0 00 00 00 	lea    0xb0(%rax),%rdx
ffff800000102a85:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102a89:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000102a8c:	89 c0                	mov    %eax,%eax
ffff800000102a8e:	83 e0 07             	and    $0x7,%eax
ffff800000102a91:	48 c1 e0 06          	shl    $0x6,%rax
ffff800000102a95:	48 01 d0             	add    %rdx,%rax
ffff800000102a98:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    ip->type = dip->type;
ffff800000102a9c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102aa0:	0f b7 10             	movzwl (%rax),%edx
ffff800000102aa3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102aa7:	66 89 90 94 00 00 00 	mov    %dx,0x94(%rax)
    ip->major = dip->major;
ffff800000102aae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102ab2:	0f b7 50 02          	movzwl 0x2(%rax),%edx
ffff800000102ab6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102aba:	66 89 90 96 00 00 00 	mov    %dx,0x96(%rax)
    ip->minor = dip->minor;
ffff800000102ac1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102ac5:	0f b7 50 04          	movzwl 0x4(%rax),%edx
ffff800000102ac9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102acd:	66 89 90 98 00 00 00 	mov    %dx,0x98(%rax)
    ip->nlink = dip->nlink;
ffff800000102ad4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102ad8:	0f b7 50 06          	movzwl 0x6(%rax),%edx
ffff800000102adc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102ae0:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
    ip->size = dip->size;
ffff800000102ae7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102aeb:	8b 50 08             	mov    0x8(%rax),%edx
ffff800000102aee:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102af2:	89 90 9c 00 00 00    	mov    %edx,0x9c(%rax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
ffff800000102af8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102afc:	48 8d 48 0c          	lea    0xc(%rax),%rcx
ffff800000102b00:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102b04:	48 05 a0 00 00 00    	add    $0xa0,%rax
ffff800000102b0a:	ba 34 00 00 00       	mov    $0x34,%edx
ffff800000102b0f:	48 89 ce             	mov    %rcx,%rsi
ffff800000102b12:	48 89 c7             	mov    %rax,%rdi
ffff800000102b15:	48 b8 4d 83 10 00 00 	movabs $0xffff80000010834d,%rax
ffff800000102b1c:	80 ff ff 
ffff800000102b1f:	ff d0                	call   *%rax
    brelse(bp);
ffff800000102b21:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102b25:	48 89 c7             	mov    %rax,%rdi
ffff800000102b28:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff800000102b2f:	80 ff ff 
ffff800000102b32:	ff d0                	call   *%rax
    ip->flags |= I_VALID;
ffff800000102b34:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102b38:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
ffff800000102b3e:	83 c8 02             	or     $0x2,%eax
ffff800000102b41:	89 c2                	mov    %eax,%edx
ffff800000102b43:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102b47:	89 90 90 00 00 00    	mov    %edx,0x90(%rax)
    if(ip->type == 0)
ffff800000102b4d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102b51:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000102b58:	66 85 c0             	test   %ax,%ax
ffff800000102b5b:	75 19                	jne    ffff800000102b76 <ilock+0x198>
      panic("ilock: no type");
ffff800000102b5d:	48 b8 5b d0 10 00 00 	movabs $0xffff80000010d05b,%rax
ffff800000102b64:	80 ff ff 
ffff800000102b67:	48 89 c7             	mov    %rax,%rdi
ffff800000102b6a:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000102b71:	80 ff ff 
ffff800000102b74:	ff d0                	call   *%rax
  }
}
ffff800000102b76:	90                   	nop
ffff800000102b77:	c9                   	leave
ffff800000102b78:	c3                   	ret

ffff800000102b79 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
ffff800000102b79:	f3 0f 1e fa          	endbr64
ffff800000102b7d:	55                   	push   %rbp
ffff800000102b7e:	48 89 e5             	mov    %rsp,%rbp
ffff800000102b81:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000102b85:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
ffff800000102b89:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000102b8e:	74 26                	je     ffff800000102bb6 <iunlock+0x3d>
ffff800000102b90:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102b94:	48 83 c0 10          	add    $0x10,%rax
ffff800000102b98:	48 89 c7             	mov    %rax,%rdi
ffff800000102b9b:	48 b8 a8 7d 10 00 00 	movabs $0xffff800000107da8,%rax
ffff800000102ba2:	80 ff ff 
ffff800000102ba5:	ff d0                	call   *%rax
ffff800000102ba7:	85 c0                	test   %eax,%eax
ffff800000102ba9:	74 0b                	je     ffff800000102bb6 <iunlock+0x3d>
ffff800000102bab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102baf:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000102bb2:	85 c0                	test   %eax,%eax
ffff800000102bb4:	7f 19                	jg     ffff800000102bcf <iunlock+0x56>
    panic("iunlock");
ffff800000102bb6:	48 b8 6a d0 10 00 00 	movabs $0xffff80000010d06a,%rax
ffff800000102bbd:	80 ff ff 
ffff800000102bc0:	48 89 c7             	mov    %rax,%rdi
ffff800000102bc3:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000102bca:	80 ff ff 
ffff800000102bcd:	ff d0                	call   *%rax

  releasesleep(&ip->lock);
ffff800000102bcf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102bd3:	48 83 c0 10          	add    $0x10,%rax
ffff800000102bd7:	48 89 c7             	mov    %rax,%rdi
ffff800000102bda:	48 b8 3f 7d 10 00 00 	movabs $0xffff800000107d3f,%rax
ffff800000102be1:	80 ff ff 
ffff800000102be4:	ff d0                	call   *%rax
}
ffff800000102be6:	90                   	nop
ffff800000102be7:	c9                   	leave
ffff800000102be8:	c3                   	ret

ffff800000102be9 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
ffff800000102be9:	f3 0f 1e fa          	endbr64
ffff800000102bed:	55                   	push   %rbp
ffff800000102bee:	48 89 e5             	mov    %rsp,%rbp
ffff800000102bf1:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000102bf5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&icache.lock);
ffff800000102bf9:	48 b8 40 59 11 00 00 	movabs $0xffff800000115940,%rax
ffff800000102c00:	80 ff ff 
ffff800000102c03:	48 89 c7             	mov    %rax,%rdi
ffff800000102c06:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff800000102c0d:	80 ff ff 
ffff800000102c10:	ff d0                	call   *%rax
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
ffff800000102c12:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102c16:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000102c19:	83 f8 01             	cmp    $0x1,%eax
ffff800000102c1c:	0f 85 98 00 00 00    	jne    ffff800000102cba <iput+0xd1>
ffff800000102c22:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102c26:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
ffff800000102c2c:	83 e0 02             	and    $0x2,%eax
ffff800000102c2f:	85 c0                	test   %eax,%eax
ffff800000102c31:	0f 84 83 00 00 00    	je     ffff800000102cba <iput+0xd1>
ffff800000102c37:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102c3b:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff800000102c42:	66 85 c0             	test   %ax,%ax
ffff800000102c45:	75 73                	jne    ffff800000102cba <iput+0xd1>
    // inode has no links and no other references: truncate and free.
    release(&icache.lock);
ffff800000102c47:	48 b8 40 59 11 00 00 	movabs $0xffff800000115940,%rax
ffff800000102c4e:	80 ff ff 
ffff800000102c51:	48 89 c7             	mov    %rax,%rdi
ffff800000102c54:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff800000102c5b:	80 ff ff 
ffff800000102c5e:	ff d0                	call   *%rax
    itrunc(ip);
ffff800000102c60:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102c64:	48 89 c7             	mov    %rax,%rdi
ffff800000102c67:	48 b8 81 2e 10 00 00 	movabs $0xffff800000102e81,%rax
ffff800000102c6e:	80 ff ff 
ffff800000102c71:	ff d0                	call   *%rax
    ip->type = 0;
ffff800000102c73:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102c77:	66 c7 80 94 00 00 00 	movw   $0x0,0x94(%rax)
ffff800000102c7e:	00 00 
    iupdate(ip);
ffff800000102c80:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102c84:	48 89 c7             	mov    %rax,%rdi
ffff800000102c87:	48 b8 2e 27 10 00 00 	movabs $0xffff80000010272e,%rax
ffff800000102c8e:	80 ff ff 
ffff800000102c91:	ff d0                	call   *%rax
    acquire(&icache.lock);
ffff800000102c93:	48 b8 40 59 11 00 00 	movabs $0xffff800000115940,%rax
ffff800000102c9a:	80 ff ff 
ffff800000102c9d:	48 89 c7             	mov    %rax,%rdi
ffff800000102ca0:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff800000102ca7:	80 ff ff 
ffff800000102caa:	ff d0                	call   *%rax
    ip->flags = 0;
ffff800000102cac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102cb0:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%rax)
ffff800000102cb7:	00 00 00 
  }
  ip->ref--;
ffff800000102cba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102cbe:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000102cc1:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000102cc4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102cc8:	89 50 08             	mov    %edx,0x8(%rax)
  release(&icache.lock);
ffff800000102ccb:	48 b8 40 59 11 00 00 	movabs $0xffff800000115940,%rax
ffff800000102cd2:	80 ff ff 
ffff800000102cd5:	48 89 c7             	mov    %rax,%rdi
ffff800000102cd8:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff800000102cdf:	80 ff ff 
ffff800000102ce2:	ff d0                	call   *%rax
}
ffff800000102ce4:	90                   	nop
ffff800000102ce5:	c9                   	leave
ffff800000102ce6:	c3                   	ret

ffff800000102ce7 <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
ffff800000102ce7:	f3 0f 1e fa          	endbr64
ffff800000102ceb:	55                   	push   %rbp
ffff800000102cec:	48 89 e5             	mov    %rsp,%rbp
ffff800000102cef:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000102cf3:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  iunlock(ip);
ffff800000102cf7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102cfb:	48 89 c7             	mov    %rax,%rdi
ffff800000102cfe:	48 b8 79 2b 10 00 00 	movabs $0xffff800000102b79,%rax
ffff800000102d05:	80 ff ff 
ffff800000102d08:	ff d0                	call   *%rax
  iput(ip);
ffff800000102d0a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102d0e:	48 89 c7             	mov    %rax,%rdi
ffff800000102d11:	48 b8 e9 2b 10 00 00 	movabs $0xffff800000102be9,%rax
ffff800000102d18:	80 ff ff 
ffff800000102d1b:	ff d0                	call   *%rax
}
ffff800000102d1d:	90                   	nop
ffff800000102d1e:	c9                   	leave
ffff800000102d1f:	c3                   	ret

ffff800000102d20 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
ffff800000102d20:	f3 0f 1e fa          	endbr64
ffff800000102d24:	55                   	push   %rbp
ffff800000102d25:	48 89 e5             	mov    %rsp,%rbp
ffff800000102d28:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000102d2c:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000102d30:	89 75 d4             	mov    %esi,-0x2c(%rbp)
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
ffff800000102d33:	83 7d d4 0b          	cmpl   $0xb,-0x2c(%rbp)
ffff800000102d37:	77 47                	ja     ffff800000102d80 <bmap+0x60>
    if((addr = ip->addrs[bn]) == 0)
ffff800000102d39:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102d3d:	8b 55 d4             	mov    -0x2c(%rbp),%edx
ffff800000102d40:	48 83 c2 28          	add    $0x28,%rdx
ffff800000102d44:	8b 04 90             	mov    (%rax,%rdx,4),%eax
ffff800000102d47:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000102d4a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000102d4e:	75 28                	jne    ffff800000102d78 <bmap+0x58>
      ip->addrs[bn] = addr = balloc(ip->dev);
ffff800000102d50:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102d54:	8b 00                	mov    (%rax),%eax
ffff800000102d56:	89 c7                	mov    %eax,%edi
ffff800000102d58:	48 b8 8e 22 10 00 00 	movabs $0xffff80000010228e,%rax
ffff800000102d5f:	80 ff ff 
ffff800000102d62:	ff d0                	call   *%rax
ffff800000102d64:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000102d67:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102d6b:	8b 55 d4             	mov    -0x2c(%rbp),%edx
ffff800000102d6e:	48 8d 4a 28          	lea    0x28(%rdx),%rcx
ffff800000102d72:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102d75:	89 14 88             	mov    %edx,(%rax,%rcx,4)
    return addr;
ffff800000102d78:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102d7b:	e9 ff 00 00 00       	jmp    ffff800000102e7f <bmap+0x15f>
  }
  bn -= NDIRECT;
ffff800000102d80:	83 6d d4 0c          	subl   $0xc,-0x2c(%rbp)

  if(bn < NINDIRECT){
ffff800000102d84:	83 7d d4 7f          	cmpl   $0x7f,-0x2c(%rbp)
ffff800000102d88:	0f 87 d8 00 00 00    	ja     ffff800000102e66 <bmap+0x146>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
ffff800000102d8e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102d92:	8b 80 d0 00 00 00    	mov    0xd0(%rax),%eax
ffff800000102d98:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000102d9b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000102d9f:	75 24                	jne    ffff800000102dc5 <bmap+0xa5>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
ffff800000102da1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102da5:	8b 00                	mov    (%rax),%eax
ffff800000102da7:	89 c7                	mov    %eax,%edi
ffff800000102da9:	48 b8 8e 22 10 00 00 	movabs $0xffff80000010228e,%rax
ffff800000102db0:	80 ff ff 
ffff800000102db3:	ff d0                	call   *%rax
ffff800000102db5:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000102db8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102dbc:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102dbf:	89 90 d0 00 00 00    	mov    %edx,0xd0(%rax)
    bp = bread(ip->dev, addr);
ffff800000102dc5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102dc9:	8b 00                	mov    (%rax),%eax
ffff800000102dcb:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102dce:	89 d6                	mov    %edx,%esi
ffff800000102dd0:	89 c7                	mov    %eax,%edi
ffff800000102dd2:	48 b8 d4 03 10 00 00 	movabs $0xffff8000001003d4,%rax
ffff800000102dd9:	80 ff ff 
ffff800000102ddc:	ff d0                	call   *%rax
ffff800000102dde:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    a = (uint*)bp->data;
ffff800000102de2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102de6:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000102dec:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if((addr = a[bn]) == 0){
ffff800000102df0:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff800000102df3:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff800000102dfa:	00 
ffff800000102dfb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102dff:	48 01 d0             	add    %rdx,%rax
ffff800000102e02:	8b 00                	mov    (%rax),%eax
ffff800000102e04:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000102e07:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000102e0b:	75 41                	jne    ffff800000102e4e <bmap+0x12e>
      a[bn] = addr = balloc(ip->dev);
ffff800000102e0d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102e11:	8b 00                	mov    (%rax),%eax
ffff800000102e13:	89 c7                	mov    %eax,%edi
ffff800000102e15:	48 b8 8e 22 10 00 00 	movabs $0xffff80000010228e,%rax
ffff800000102e1c:	80 ff ff 
ffff800000102e1f:	ff d0                	call   *%rax
ffff800000102e21:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000102e24:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff800000102e27:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff800000102e2e:	00 
ffff800000102e2f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102e33:	48 01 c2             	add    %rax,%rdx
ffff800000102e36:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102e39:	89 02                	mov    %eax,(%rdx)
      log_write(bp);
ffff800000102e3b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102e3f:	48 89 c7             	mov    %rax,%rdi
ffff800000102e42:	48 b8 85 54 10 00 00 	movabs $0xffff800000105485,%rax
ffff800000102e49:	80 ff ff 
ffff800000102e4c:	ff d0                	call   *%rax
    }
    brelse(bp);
ffff800000102e4e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102e52:	48 89 c7             	mov    %rax,%rdi
ffff800000102e55:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff800000102e5c:	80 ff ff 
ffff800000102e5f:	ff d0                	call   *%rax
    return addr;
ffff800000102e61:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102e64:	eb 19                	jmp    ffff800000102e7f <bmap+0x15f>
  }

  panic("bmap: out of range");
ffff800000102e66:	48 b8 72 d0 10 00 00 	movabs $0xffff80000010d072,%rax
ffff800000102e6d:	80 ff ff 
ffff800000102e70:	48 89 c7             	mov    %rax,%rdi
ffff800000102e73:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000102e7a:	80 ff ff 
ffff800000102e7d:	ff d0                	call   *%rax
}
ffff800000102e7f:	c9                   	leave
ffff800000102e80:	c3                   	ret

ffff800000102e81 <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
ffff800000102e81:	f3 0f 1e fa          	endbr64
ffff800000102e85:	55                   	push   %rbp
ffff800000102e86:	48 89 e5             	mov    %rsp,%rbp
ffff800000102e89:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000102e8d:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
ffff800000102e91:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000102e98:	eb 55                	jmp    ffff800000102eef <itrunc+0x6e>
    if(ip->addrs[i]){
ffff800000102e9a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102e9e:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102ea1:	48 63 d2             	movslq %edx,%rdx
ffff800000102ea4:	48 83 c2 28          	add    $0x28,%rdx
ffff800000102ea8:	8b 04 90             	mov    (%rax,%rdx,4),%eax
ffff800000102eab:	85 c0                	test   %eax,%eax
ffff800000102ead:	74 3c                	je     ffff800000102eeb <itrunc+0x6a>
      bfree(ip->dev, ip->addrs[i]);
ffff800000102eaf:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102eb3:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102eb6:	48 63 d2             	movslq %edx,%rdx
ffff800000102eb9:	48 83 c2 28          	add    $0x28,%rdx
ffff800000102ebd:	8b 04 90             	mov    (%rax,%rdx,4),%eax
ffff800000102ec0:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff800000102ec4:	8b 12                	mov    (%rdx),%edx
ffff800000102ec6:	89 c6                	mov    %eax,%esi
ffff800000102ec8:	89 d7                	mov    %edx,%edi
ffff800000102eca:	48 b8 25 24 10 00 00 	movabs $0xffff800000102425,%rax
ffff800000102ed1:	80 ff ff 
ffff800000102ed4:	ff d0                	call   *%rax
      ip->addrs[i] = 0;
ffff800000102ed6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102eda:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102edd:	48 63 d2             	movslq %edx,%rdx
ffff800000102ee0:	48 83 c2 28          	add    $0x28,%rdx
ffff800000102ee4:	c7 04 90 00 00 00 00 	movl   $0x0,(%rax,%rdx,4)
  for(i = 0; i < NDIRECT; i++){
ffff800000102eeb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000102eef:	83 7d fc 0b          	cmpl   $0xb,-0x4(%rbp)
ffff800000102ef3:	7e a5                	jle    ffff800000102e9a <itrunc+0x19>
    }
  }

  if(ip->addrs[NDIRECT]){
ffff800000102ef5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102ef9:	8b 80 d0 00 00 00    	mov    0xd0(%rax),%eax
ffff800000102eff:	85 c0                	test   %eax,%eax
ffff800000102f01:	0f 84 ce 00 00 00    	je     ffff800000102fd5 <itrunc+0x154>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
ffff800000102f07:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102f0b:	8b 90 d0 00 00 00    	mov    0xd0(%rax),%edx
ffff800000102f11:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102f15:	8b 00                	mov    (%rax),%eax
ffff800000102f17:	89 d6                	mov    %edx,%esi
ffff800000102f19:	89 c7                	mov    %eax,%edi
ffff800000102f1b:	48 b8 d4 03 10 00 00 	movabs $0xffff8000001003d4,%rax
ffff800000102f22:	80 ff ff 
ffff800000102f25:	ff d0                	call   *%rax
ffff800000102f27:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    a = (uint*)bp->data;
ffff800000102f2b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102f2f:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000102f35:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for(j = 0; j < NINDIRECT; j++){
ffff800000102f39:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
ffff800000102f40:	eb 4a                	jmp    ffff800000102f8c <itrunc+0x10b>
      if(a[j])
ffff800000102f42:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000102f45:	48 98                	cltq
ffff800000102f47:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff800000102f4e:	00 
ffff800000102f4f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102f53:	48 01 d0             	add    %rdx,%rax
ffff800000102f56:	8b 00                	mov    (%rax),%eax
ffff800000102f58:	85 c0                	test   %eax,%eax
ffff800000102f5a:	74 2c                	je     ffff800000102f88 <itrunc+0x107>
        bfree(ip->dev, a[j]);
ffff800000102f5c:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000102f5f:	48 98                	cltq
ffff800000102f61:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff800000102f68:	00 
ffff800000102f69:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102f6d:	48 01 d0             	add    %rdx,%rax
ffff800000102f70:	8b 00                	mov    (%rax),%eax
ffff800000102f72:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff800000102f76:	8b 12                	mov    (%rdx),%edx
ffff800000102f78:	89 c6                	mov    %eax,%esi
ffff800000102f7a:	89 d7                	mov    %edx,%edi
ffff800000102f7c:	48 b8 25 24 10 00 00 	movabs $0xffff800000102425,%rax
ffff800000102f83:	80 ff ff 
ffff800000102f86:	ff d0                	call   *%rax
    for(j = 0; j < NINDIRECT; j++){
ffff800000102f88:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
ffff800000102f8c:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000102f8f:	83 f8 7f             	cmp    $0x7f,%eax
ffff800000102f92:	76 ae                	jbe    ffff800000102f42 <itrunc+0xc1>
    }
    brelse(bp);
ffff800000102f94:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102f98:	48 89 c7             	mov    %rax,%rdi
ffff800000102f9b:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff800000102fa2:	80 ff ff 
ffff800000102fa5:	ff d0                	call   *%rax
    bfree(ip->dev, ip->addrs[NDIRECT]);
ffff800000102fa7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102fab:	8b 80 d0 00 00 00    	mov    0xd0(%rax),%eax
ffff800000102fb1:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff800000102fb5:	8b 12                	mov    (%rdx),%edx
ffff800000102fb7:	89 c6                	mov    %eax,%esi
ffff800000102fb9:	89 d7                	mov    %edx,%edi
ffff800000102fbb:	48 b8 25 24 10 00 00 	movabs $0xffff800000102425,%rax
ffff800000102fc2:	80 ff ff 
ffff800000102fc5:	ff d0                	call   *%rax
    ip->addrs[NDIRECT] = 0;
ffff800000102fc7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102fcb:	c7 80 d0 00 00 00 00 	movl   $0x0,0xd0(%rax)
ffff800000102fd2:	00 00 00 
  }

  ip->size = 0;
ffff800000102fd5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102fd9:	c7 80 9c 00 00 00 00 	movl   $0x0,0x9c(%rax)
ffff800000102fe0:	00 00 00 
  iupdate(ip);
ffff800000102fe3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102fe7:	48 89 c7             	mov    %rax,%rdi
ffff800000102fea:	48 b8 2e 27 10 00 00 	movabs $0xffff80000010272e,%rax
ffff800000102ff1:	80 ff ff 
ffff800000102ff4:	ff d0                	call   *%rax
}
ffff800000102ff6:	90                   	nop
ffff800000102ff7:	c9                   	leave
ffff800000102ff8:	c3                   	ret

ffff800000102ff9 <stati>:

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
ffff800000102ff9:	f3 0f 1e fa          	endbr64
ffff800000102ffd:	55                   	push   %rbp
ffff800000102ffe:	48 89 e5             	mov    %rsp,%rbp
ffff800000103001:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000103005:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000103009:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  st->dev = ip->dev;
ffff80000010300d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103011:	8b 00                	mov    (%rax),%eax
ffff800000103013:	89 c2                	mov    %eax,%edx
ffff800000103015:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000103019:	89 50 04             	mov    %edx,0x4(%rax)
  st->ino = ip->inum;
ffff80000010301c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103020:	8b 50 04             	mov    0x4(%rax),%edx
ffff800000103023:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000103027:	89 50 08             	mov    %edx,0x8(%rax)
  st->type = ip->type;
ffff80000010302a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010302e:	0f b7 90 94 00 00 00 	movzwl 0x94(%rax),%edx
ffff800000103035:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000103039:	66 89 10             	mov    %dx,(%rax)
  st->nlink = ip->nlink;
ffff80000010303c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103040:	0f b7 90 9a 00 00 00 	movzwl 0x9a(%rax),%edx
ffff800000103047:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010304b:	66 89 50 0c          	mov    %dx,0xc(%rax)
  st->size = ip->size;
ffff80000010304f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103053:	8b 90 9c 00 00 00    	mov    0x9c(%rax),%edx
ffff800000103059:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010305d:	89 50 10             	mov    %edx,0x10(%rax)
}
ffff800000103060:	90                   	nop
ffff800000103061:	c9                   	leave
ffff800000103062:	c3                   	ret

ffff800000103063 <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
ffff800000103063:	f3 0f 1e fa          	endbr64
ffff800000103067:	55                   	push   %rbp
ffff800000103068:	48 89 e5             	mov    %rsp,%rbp
ffff80000010306b:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010306f:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000103073:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff800000103077:	89 55 cc             	mov    %edx,-0x34(%rbp)
ffff80000010307a:	89 4d c8             	mov    %ecx,-0x38(%rbp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
ffff80000010307d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103081:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000103088:	66 83 f8 03          	cmp    $0x3,%ax
ffff80000010308c:	0f 85 8d 00 00 00    	jne    ffff80000010311f <readi+0xbc>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
ffff800000103092:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103096:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff80000010309d:	66 85 c0             	test   %ax,%ax
ffff8000001030a0:	78 38                	js     ffff8000001030da <readi+0x77>
ffff8000001030a2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001030a6:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff8000001030ad:	66 83 f8 09          	cmp    $0x9,%ax
ffff8000001030b1:	7f 27                	jg     ffff8000001030da <readi+0x77>
ffff8000001030b3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001030b7:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff8000001030be:	98                   	cwtl
ffff8000001030bf:	48 ba 40 45 11 00 00 	movabs $0xffff800000114540,%rdx
ffff8000001030c6:	80 ff ff 
ffff8000001030c9:	48 98                	cltq
ffff8000001030cb:	48 c1 e0 04          	shl    $0x4,%rax
ffff8000001030cf:	48 01 d0             	add    %rdx,%rax
ffff8000001030d2:	48 8b 00             	mov    (%rax),%rax
ffff8000001030d5:	48 85 c0             	test   %rax,%rax
ffff8000001030d8:	75 0a                	jne    ffff8000001030e4 <readi+0x81>
      return -1;
ffff8000001030da:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001030df:	e9 4e 01 00 00       	jmp    ffff800000103232 <readi+0x1cf>
    return devsw[ip->major].read(ip, off, dst, n);
ffff8000001030e4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001030e8:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff8000001030ef:	98                   	cwtl
ffff8000001030f0:	48 ba 40 45 11 00 00 	movabs $0xffff800000114540,%rdx
ffff8000001030f7:	80 ff ff 
ffff8000001030fa:	48 98                	cltq
ffff8000001030fc:	48 c1 e0 04          	shl    $0x4,%rax
ffff800000103100:	48 01 d0             	add    %rdx,%rax
ffff800000103103:	4c 8b 00             	mov    (%rax),%r8
ffff800000103106:	8b 4d c8             	mov    -0x38(%rbp),%ecx
ffff800000103109:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffff80000010310d:	8b 75 cc             	mov    -0x34(%rbp),%esi
ffff800000103110:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103114:	48 89 c7             	mov    %rax,%rdi
ffff800000103117:	41 ff d0             	call   *%r8
ffff80000010311a:	e9 13 01 00 00       	jmp    ffff800000103232 <readi+0x1cf>
  }

  if(off > ip->size || off + n < off)
ffff80000010311f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103123:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff800000103129:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffff80000010312c:	72 0d                	jb     ffff80000010313b <readi+0xd8>
ffff80000010312e:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffff800000103131:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff800000103134:	01 d0                	add    %edx,%eax
ffff800000103136:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffff800000103139:	73 0a                	jae    ffff800000103145 <readi+0xe2>
    return -1;
ffff80000010313b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000103140:	e9 ed 00 00 00       	jmp    ffff800000103232 <readi+0x1cf>
  if(off + n > ip->size)
ffff800000103145:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffff800000103148:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff80000010314b:	01 c2                	add    %eax,%edx
ffff80000010314d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103151:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff800000103157:	39 d0                	cmp    %edx,%eax
ffff800000103159:	73 10                	jae    ffff80000010316b <readi+0x108>
    n = ip->size - off;
ffff80000010315b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010315f:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff800000103165:	2b 45 cc             	sub    -0x34(%rbp),%eax
ffff800000103168:	89 45 c8             	mov    %eax,-0x38(%rbp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
ffff80000010316b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000103172:	e9 ac 00 00 00       	jmp    ffff800000103223 <readi+0x1c0>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
ffff800000103177:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff80000010317a:	c1 e8 09             	shr    $0x9,%eax
ffff80000010317d:	89 c2                	mov    %eax,%edx
ffff80000010317f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103183:	89 d6                	mov    %edx,%esi
ffff800000103185:	48 89 c7             	mov    %rax,%rdi
ffff800000103188:	48 b8 20 2d 10 00 00 	movabs $0xffff800000102d20,%rax
ffff80000010318f:	80 ff ff 
ffff800000103192:	ff d0                	call   *%rax
ffff800000103194:	89 c2                	mov    %eax,%edx
ffff800000103196:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010319a:	8b 00                	mov    (%rax),%eax
ffff80000010319c:	89 d6                	mov    %edx,%esi
ffff80000010319e:	89 c7                	mov    %eax,%edi
ffff8000001031a0:	48 b8 d4 03 10 00 00 	movabs $0xffff8000001003d4,%rax
ffff8000001031a7:	80 ff ff 
ffff8000001031aa:	ff d0                	call   *%rax
ffff8000001031ac:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    m = min(n - tot, BSIZE - off%BSIZE);
ffff8000001031b0:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff8000001031b3:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff8000001031b8:	ba 00 02 00 00       	mov    $0x200,%edx
ffff8000001031bd:	29 c2                	sub    %eax,%edx
ffff8000001031bf:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff8000001031c2:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff8000001031c5:	39 c2                	cmp    %eax,%edx
ffff8000001031c7:	0f 46 c2             	cmovbe %edx,%eax
ffff8000001031ca:	89 45 ec             	mov    %eax,-0x14(%rbp)
    memmove(dst, bp->data + off%BSIZE, m);
ffff8000001031cd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001031d1:	48 8d 90 b0 00 00 00 	lea    0xb0(%rax),%rdx
ffff8000001031d8:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff8000001031db:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff8000001031e0:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffff8000001031e4:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff8000001031e7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff8000001031eb:	48 89 ce             	mov    %rcx,%rsi
ffff8000001031ee:	48 89 c7             	mov    %rax,%rdi
ffff8000001031f1:	48 b8 4d 83 10 00 00 	movabs $0xffff80000010834d,%rax
ffff8000001031f8:	80 ff ff 
ffff8000001031fb:	ff d0                	call   *%rax
    brelse(bp);
ffff8000001031fd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000103201:	48 89 c7             	mov    %rax,%rdi
ffff800000103204:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff80000010320b:	80 ff ff 
ffff80000010320e:	ff d0                	call   *%rax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
ffff800000103210:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000103213:	01 45 fc             	add    %eax,-0x4(%rbp)
ffff800000103216:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000103219:	01 45 cc             	add    %eax,-0x34(%rbp)
ffff80000010321c:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff80000010321f:	48 01 45 d0          	add    %rax,-0x30(%rbp)
ffff800000103223:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000103226:	3b 45 c8             	cmp    -0x38(%rbp),%eax
ffff800000103229:	0f 82 48 ff ff ff    	jb     ffff800000103177 <readi+0x114>
  }
  return n;
ffff80000010322f:	8b 45 c8             	mov    -0x38(%rbp),%eax
}
ffff800000103232:	c9                   	leave
ffff800000103233:	c3                   	ret

ffff800000103234 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
ffff800000103234:	f3 0f 1e fa          	endbr64
ffff800000103238:	55                   	push   %rbp
ffff800000103239:	48 89 e5             	mov    %rsp,%rbp
ffff80000010323c:	48 83 ec 40          	sub    $0x40,%rsp
ffff800000103240:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000103244:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff800000103248:	89 55 cc             	mov    %edx,-0x34(%rbp)
ffff80000010324b:	89 4d c8             	mov    %ecx,-0x38(%rbp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
ffff80000010324e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103252:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000103259:	66 83 f8 03          	cmp    $0x3,%ax
ffff80000010325d:	0f 85 95 00 00 00    	jne    ffff8000001032f8 <writei+0xc4>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
ffff800000103263:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103267:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff80000010326e:	66 85 c0             	test   %ax,%ax
ffff800000103271:	78 3c                	js     ffff8000001032af <writei+0x7b>
ffff800000103273:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103277:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff80000010327e:	66 83 f8 09          	cmp    $0x9,%ax
ffff800000103282:	7f 2b                	jg     ffff8000001032af <writei+0x7b>
ffff800000103284:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103288:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff80000010328f:	98                   	cwtl
ffff800000103290:	48 ba 40 45 11 00 00 	movabs $0xffff800000114540,%rdx
ffff800000103297:	80 ff ff 
ffff80000010329a:	48 98                	cltq
ffff80000010329c:	48 c1 e0 04          	shl    $0x4,%rax
ffff8000001032a0:	48 01 d0             	add    %rdx,%rax
ffff8000001032a3:	48 83 c0 08          	add    $0x8,%rax
ffff8000001032a7:	48 8b 00             	mov    (%rax),%rax
ffff8000001032aa:	48 85 c0             	test   %rax,%rax
ffff8000001032ad:	75 0a                	jne    ffff8000001032b9 <writei+0x85>
      return -1;
ffff8000001032af:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001032b4:	e9 8d 01 00 00       	jmp    ffff800000103446 <writei+0x212>
    return devsw[ip->major].write(ip, off, src, n);
ffff8000001032b9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001032bd:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff8000001032c4:	98                   	cwtl
ffff8000001032c5:	48 ba 40 45 11 00 00 	movabs $0xffff800000114540,%rdx
ffff8000001032cc:	80 ff ff 
ffff8000001032cf:	48 98                	cltq
ffff8000001032d1:	48 c1 e0 04          	shl    $0x4,%rax
ffff8000001032d5:	48 01 d0             	add    %rdx,%rax
ffff8000001032d8:	48 83 c0 08          	add    $0x8,%rax
ffff8000001032dc:	4c 8b 00             	mov    (%rax),%r8
ffff8000001032df:	8b 4d c8             	mov    -0x38(%rbp),%ecx
ffff8000001032e2:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffff8000001032e6:	8b 75 cc             	mov    -0x34(%rbp),%esi
ffff8000001032e9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001032ed:	48 89 c7             	mov    %rax,%rdi
ffff8000001032f0:	41 ff d0             	call   *%r8
ffff8000001032f3:	e9 4e 01 00 00       	jmp    ffff800000103446 <writei+0x212>
  }

  if(off > ip->size || off + n < off)
ffff8000001032f8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001032fc:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff800000103302:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffff800000103305:	72 0d                	jb     ffff800000103314 <writei+0xe0>
ffff800000103307:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffff80000010330a:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff80000010330d:	01 d0                	add    %edx,%eax
ffff80000010330f:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffff800000103312:	73 0a                	jae    ffff80000010331e <writei+0xea>
    return -1;
ffff800000103314:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000103319:	e9 28 01 00 00       	jmp    ffff800000103446 <writei+0x212>
  if(off + n > MAXFILE*BSIZE)
ffff80000010331e:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffff800000103321:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff800000103324:	01 d0                	add    %edx,%eax
ffff800000103326:	3d 00 18 01 00       	cmp    $0x11800,%eax
ffff80000010332b:	76 0a                	jbe    ffff800000103337 <writei+0x103>
    return -1;
ffff80000010332d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000103332:	e9 0f 01 00 00       	jmp    ffff800000103446 <writei+0x212>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
ffff800000103337:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010333e:	e9 bf 00 00 00       	jmp    ffff800000103402 <writei+0x1ce>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
ffff800000103343:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff800000103346:	c1 e8 09             	shr    $0x9,%eax
ffff800000103349:	89 c2                	mov    %eax,%edx
ffff80000010334b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010334f:	89 d6                	mov    %edx,%esi
ffff800000103351:	48 89 c7             	mov    %rax,%rdi
ffff800000103354:	48 b8 20 2d 10 00 00 	movabs $0xffff800000102d20,%rax
ffff80000010335b:	80 ff ff 
ffff80000010335e:	ff d0                	call   *%rax
ffff800000103360:	89 c2                	mov    %eax,%edx
ffff800000103362:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103366:	8b 00                	mov    (%rax),%eax
ffff800000103368:	89 d6                	mov    %edx,%esi
ffff80000010336a:	89 c7                	mov    %eax,%edi
ffff80000010336c:	48 b8 d4 03 10 00 00 	movabs $0xffff8000001003d4,%rax
ffff800000103373:	80 ff ff 
ffff800000103376:	ff d0                	call   *%rax
ffff800000103378:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    m = min(n - tot, BSIZE - off%BSIZE);
ffff80000010337c:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff80000010337f:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff800000103384:	ba 00 02 00 00       	mov    $0x200,%edx
ffff800000103389:	29 c2                	sub    %eax,%edx
ffff80000010338b:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff80000010338e:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff800000103391:	39 c2                	cmp    %eax,%edx
ffff800000103393:	0f 46 c2             	cmovbe %edx,%eax
ffff800000103396:	89 45 ec             	mov    %eax,-0x14(%rbp)
    memmove(bp->data + off%BSIZE, src, m);
ffff800000103399:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010339d:	48 8d 90 b0 00 00 00 	lea    0xb0(%rax),%rdx
ffff8000001033a4:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff8000001033a7:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff8000001033ac:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffff8000001033b0:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff8000001033b3:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff8000001033b7:	48 89 c6             	mov    %rax,%rsi
ffff8000001033ba:	48 89 cf             	mov    %rcx,%rdi
ffff8000001033bd:	48 b8 4d 83 10 00 00 	movabs $0xffff80000010834d,%rax
ffff8000001033c4:	80 ff ff 
ffff8000001033c7:	ff d0                	call   *%rax
    log_write(bp);
ffff8000001033c9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001033cd:	48 89 c7             	mov    %rax,%rdi
ffff8000001033d0:	48 b8 85 54 10 00 00 	movabs $0xffff800000105485,%rax
ffff8000001033d7:	80 ff ff 
ffff8000001033da:	ff d0                	call   *%rax
    brelse(bp);
ffff8000001033dc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001033e0:	48 89 c7             	mov    %rax,%rdi
ffff8000001033e3:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff8000001033ea:	80 ff ff 
ffff8000001033ed:	ff d0                	call   *%rax
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
ffff8000001033ef:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001033f2:	01 45 fc             	add    %eax,-0x4(%rbp)
ffff8000001033f5:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001033f8:	01 45 cc             	add    %eax,-0x34(%rbp)
ffff8000001033fb:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001033fe:	48 01 45 d0          	add    %rax,-0x30(%rbp)
ffff800000103402:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000103405:	3b 45 c8             	cmp    -0x38(%rbp),%eax
ffff800000103408:	0f 82 35 ff ff ff    	jb     ffff800000103343 <writei+0x10f>
  }

  if(n > 0 && off > ip->size){
ffff80000010340e:	83 7d c8 00          	cmpl   $0x0,-0x38(%rbp)
ffff800000103412:	74 2f                	je     ffff800000103443 <writei+0x20f>
ffff800000103414:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103418:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff80000010341e:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffff800000103421:	73 20                	jae    ffff800000103443 <writei+0x20f>
    ip->size = off;
ffff800000103423:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103427:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffff80000010342a:	89 90 9c 00 00 00    	mov    %edx,0x9c(%rax)
    iupdate(ip);
ffff800000103430:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103434:	48 89 c7             	mov    %rax,%rdi
ffff800000103437:	48 b8 2e 27 10 00 00 	movabs $0xffff80000010272e,%rax
ffff80000010343e:	80 ff ff 
ffff800000103441:	ff d0                	call   *%rax
  }
  return n;
ffff800000103443:	8b 45 c8             	mov    -0x38(%rbp),%eax
}
ffff800000103446:	c9                   	leave
ffff800000103447:	c3                   	ret

ffff800000103448 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
ffff800000103448:	f3 0f 1e fa          	endbr64
ffff80000010344c:	55                   	push   %rbp
ffff80000010344d:	48 89 e5             	mov    %rsp,%rbp
ffff800000103450:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000103454:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000103458:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  return strncmp(s, t, DIRSIZ);
ffff80000010345c:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffff800000103460:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103464:	ba 0e 00 00 00       	mov    $0xe,%edx
ffff800000103469:	48 89 ce             	mov    %rcx,%rsi
ffff80000010346c:	48 89 c7             	mov    %rax,%rdi
ffff80000010346f:	48 b8 2a 84 10 00 00 	movabs $0xffff80000010842a,%rax
ffff800000103476:	80 ff ff 
ffff800000103479:	ff d0                	call   *%rax
}
ffff80000010347b:	c9                   	leave
ffff80000010347c:	c3                   	ret

ffff80000010347d <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
ffff80000010347d:	f3 0f 1e fa          	endbr64
ffff800000103481:	55                   	push   %rbp
ffff800000103482:	48 89 e5             	mov    %rsp,%rbp
ffff800000103485:	48 83 ec 40          	sub    $0x40,%rsp
ffff800000103489:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010348d:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff800000103491:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
ffff800000103495:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103499:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff8000001034a0:	66 83 f8 01          	cmp    $0x1,%ax
ffff8000001034a4:	74 19                	je     ffff8000001034bf <dirlookup+0x42>
    panic("dirlookup not DIR");
ffff8000001034a6:	48 b8 85 d0 10 00 00 	movabs $0xffff80000010d085,%rax
ffff8000001034ad:	80 ff ff 
ffff8000001034b0:	48 89 c7             	mov    %rax,%rdi
ffff8000001034b3:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff8000001034ba:	80 ff ff 
ffff8000001034bd:	ff d0                	call   *%rax

  for(off = 0; off < dp->size; off += sizeof(de)){
ffff8000001034bf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001034c6:	e9 a2 00 00 00       	jmp    ffff80000010356d <dirlookup+0xf0>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffff8000001034cb:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001034ce:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffff8000001034d2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001034d6:	b9 10 00 00 00       	mov    $0x10,%ecx
ffff8000001034db:	48 89 c7             	mov    %rax,%rdi
ffff8000001034de:	48 b8 63 30 10 00 00 	movabs $0xffff800000103063,%rax
ffff8000001034e5:	80 ff ff 
ffff8000001034e8:	ff d0                	call   *%rax
ffff8000001034ea:	83 f8 10             	cmp    $0x10,%eax
ffff8000001034ed:	74 19                	je     ffff800000103508 <dirlookup+0x8b>
      panic("dirlookup read");
ffff8000001034ef:	48 b8 97 d0 10 00 00 	movabs $0xffff80000010d097,%rax
ffff8000001034f6:	80 ff ff 
ffff8000001034f9:	48 89 c7             	mov    %rax,%rdi
ffff8000001034fc:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000103503:	80 ff ff 
ffff800000103506:	ff d0                	call   *%rax
    if(de.inum == 0)
ffff800000103508:	0f b7 45 e0          	movzwl -0x20(%rbp),%eax
ffff80000010350c:	66 85 c0             	test   %ax,%ax
ffff80000010350f:	74 57                	je     ffff800000103568 <dirlookup+0xeb>
      continue;
    if(namecmp(name, de.name) == 0){
ffff800000103511:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff800000103515:	48 8d 50 02          	lea    0x2(%rax),%rdx
ffff800000103519:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010351d:	48 89 d6             	mov    %rdx,%rsi
ffff800000103520:	48 89 c7             	mov    %rax,%rdi
ffff800000103523:	48 b8 48 34 10 00 00 	movabs $0xffff800000103448,%rax
ffff80000010352a:	80 ff ff 
ffff80000010352d:	ff d0                	call   *%rax
ffff80000010352f:	85 c0                	test   %eax,%eax
ffff800000103531:	75 36                	jne    ffff800000103569 <dirlookup+0xec>
      // entry matches path element
      if(poff)
ffff800000103533:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
ffff800000103538:	74 09                	je     ffff800000103543 <dirlookup+0xc6>
        *poff = off;
ffff80000010353a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010353e:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000103541:	89 10                	mov    %edx,(%rax)
      inum = de.inum;
ffff800000103543:	0f b7 45 e0          	movzwl -0x20(%rbp),%eax
ffff800000103547:	0f b7 c0             	movzwl %ax,%eax
ffff80000010354a:	89 45 f8             	mov    %eax,-0x8(%rbp)
      return iget(dp->dev, inum);
ffff80000010354d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103551:	8b 00                	mov    (%rax),%eax
ffff800000103553:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffff800000103556:	89 d6                	mov    %edx,%esi
ffff800000103558:	89 c7                	mov    %eax,%edi
ffff80000010355a:	48 b8 44 28 10 00 00 	movabs $0xffff800000102844,%rax
ffff800000103561:	80 ff ff 
ffff800000103564:	ff d0                	call   *%rax
ffff800000103566:	eb 1d                	jmp    ffff800000103585 <dirlookup+0x108>
      continue;
ffff800000103568:	90                   	nop
  for(off = 0; off < dp->size; off += sizeof(de)){
ffff800000103569:	83 45 fc 10          	addl   $0x10,-0x4(%rbp)
ffff80000010356d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103571:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff800000103577:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff80000010357a:	0f 82 4b ff ff ff    	jb     ffff8000001034cb <dirlookup+0x4e>
    }
  }

  return 0;
ffff800000103580:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000103585:	c9                   	leave
ffff800000103586:	c3                   	ret

ffff800000103587 <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
ffff800000103587:	f3 0f 1e fa          	endbr64
ffff80000010358b:	55                   	push   %rbp
ffff80000010358c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010358f:	48 83 ec 40          	sub    $0x40,%rsp
ffff800000103593:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000103597:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010359b:	89 55 cc             	mov    %edx,-0x34(%rbp)
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
ffff80000010359e:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
ffff8000001035a2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001035a6:	ba 00 00 00 00       	mov    $0x0,%edx
ffff8000001035ab:	48 89 ce             	mov    %rcx,%rsi
ffff8000001035ae:	48 89 c7             	mov    %rax,%rdi
ffff8000001035b1:	48 b8 7d 34 10 00 00 	movabs $0xffff80000010347d,%rax
ffff8000001035b8:	80 ff ff 
ffff8000001035bb:	ff d0                	call   *%rax
ffff8000001035bd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff8000001035c1:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff8000001035c6:	74 1d                	je     ffff8000001035e5 <dirlink+0x5e>
    iput(ip);
ffff8000001035c8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001035cc:	48 89 c7             	mov    %rax,%rdi
ffff8000001035cf:	48 b8 e9 2b 10 00 00 	movabs $0xffff800000102be9,%rax
ffff8000001035d6:	80 ff ff 
ffff8000001035d9:	ff d0                	call   *%rax
    return -1;
ffff8000001035db:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001035e0:	e9 d8 00 00 00       	jmp    ffff8000001036bd <dirlink+0x136>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
ffff8000001035e5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001035ec:	eb 4f                	jmp    ffff80000010363d <dirlink+0xb6>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffff8000001035ee:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001035f1:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffff8000001035f5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001035f9:	b9 10 00 00 00       	mov    $0x10,%ecx
ffff8000001035fe:	48 89 c7             	mov    %rax,%rdi
ffff800000103601:	48 b8 63 30 10 00 00 	movabs $0xffff800000103063,%rax
ffff800000103608:	80 ff ff 
ffff80000010360b:	ff d0                	call   *%rax
ffff80000010360d:	83 f8 10             	cmp    $0x10,%eax
ffff800000103610:	74 19                	je     ffff80000010362b <dirlink+0xa4>
      panic("dirlink read");
ffff800000103612:	48 b8 a6 d0 10 00 00 	movabs $0xffff80000010d0a6,%rax
ffff800000103619:	80 ff ff 
ffff80000010361c:	48 89 c7             	mov    %rax,%rdi
ffff80000010361f:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000103626:	80 ff ff 
ffff800000103629:	ff d0                	call   *%rax
    if(de.inum == 0)
ffff80000010362b:	0f b7 45 e0          	movzwl -0x20(%rbp),%eax
ffff80000010362f:	66 85 c0             	test   %ax,%ax
ffff800000103632:	74 1c                	je     ffff800000103650 <dirlink+0xc9>
  for(off = 0; off < dp->size; off += sizeof(de)){
ffff800000103634:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000103637:	83 c0 10             	add    $0x10,%eax
ffff80000010363a:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff80000010363d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103641:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff800000103647:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010364a:	39 c2                	cmp    %eax,%edx
ffff80000010364c:	72 a0                	jb     ffff8000001035ee <dirlink+0x67>
ffff80000010364e:	eb 01                	jmp    ffff800000103651 <dirlink+0xca>
      break;
ffff800000103650:	90                   	nop
  }

  strncpy(de.name, name, DIRSIZ);
ffff800000103651:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000103655:	48 8d 55 e0          	lea    -0x20(%rbp),%rdx
ffff800000103659:	48 8d 4a 02          	lea    0x2(%rdx),%rcx
ffff80000010365d:	ba 0e 00 00 00       	mov    $0xe,%edx
ffff800000103662:	48 89 c6             	mov    %rax,%rsi
ffff800000103665:	48 89 cf             	mov    %rcx,%rdi
ffff800000103668:	48 b8 9b 84 10 00 00 	movabs $0xffff80000010849b,%rax
ffff80000010366f:	80 ff ff 
ffff800000103672:	ff d0                	call   *%rax
  de.inum = inum;
ffff800000103674:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff800000103677:	66 89 45 e0          	mov    %ax,-0x20(%rbp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffff80000010367b:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010367e:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffff800000103682:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103686:	b9 10 00 00 00       	mov    $0x10,%ecx
ffff80000010368b:	48 89 c7             	mov    %rax,%rdi
ffff80000010368e:	48 b8 34 32 10 00 00 	movabs $0xffff800000103234,%rax
ffff800000103695:	80 ff ff 
ffff800000103698:	ff d0                	call   *%rax
ffff80000010369a:	83 f8 10             	cmp    $0x10,%eax
ffff80000010369d:	74 19                	je     ffff8000001036b8 <dirlink+0x131>
    panic("dirlink");
ffff80000010369f:	48 b8 b3 d0 10 00 00 	movabs $0xffff80000010d0b3,%rax
ffff8000001036a6:	80 ff ff 
ffff8000001036a9:	48 89 c7             	mov    %rax,%rdi
ffff8000001036ac:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff8000001036b3:	80 ff ff 
ffff8000001036b6:	ff d0                	call   *%rax

  return 0;
ffff8000001036b8:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff8000001036bd:	c9                   	leave
ffff8000001036be:	c3                   	ret

ffff8000001036bf <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
ffff8000001036bf:	f3 0f 1e fa          	endbr64
ffff8000001036c3:	55                   	push   %rbp
ffff8000001036c4:	48 89 e5             	mov    %rsp,%rbp
ffff8000001036c7:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001036cb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff8000001036cf:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *s;
  int len;

  while(*path == '/')
ffff8000001036d3:	eb 05                	jmp    ffff8000001036da <skipelem+0x1b>
    path++;
ffff8000001036d5:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  while(*path == '/')
ffff8000001036da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001036de:	0f b6 00             	movzbl (%rax),%eax
ffff8000001036e1:	3c 2f                	cmp    $0x2f,%al
ffff8000001036e3:	74 f0                	je     ffff8000001036d5 <skipelem+0x16>
  if(*path == 0)
ffff8000001036e5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001036e9:	0f b6 00             	movzbl (%rax),%eax
ffff8000001036ec:	84 c0                	test   %al,%al
ffff8000001036ee:	75 0a                	jne    ffff8000001036fa <skipelem+0x3b>
    return 0;
ffff8000001036f0:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001036f5:	e9 9a 00 00 00       	jmp    ffff800000103794 <skipelem+0xd5>
  s = path;
ffff8000001036fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001036fe:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while(*path != '/' && *path != 0)
ffff800000103702:	eb 05                	jmp    ffff800000103709 <skipelem+0x4a>
    path++;
ffff800000103704:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  while(*path != '/' && *path != 0)
ffff800000103709:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010370d:	0f b6 00             	movzbl (%rax),%eax
ffff800000103710:	3c 2f                	cmp    $0x2f,%al
ffff800000103712:	74 0b                	je     ffff80000010371f <skipelem+0x60>
ffff800000103714:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103718:	0f b6 00             	movzbl (%rax),%eax
ffff80000010371b:	84 c0                	test   %al,%al
ffff80000010371d:	75 e5                	jne    ffff800000103704 <skipelem+0x45>
  len = path - s;
ffff80000010371f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103723:	48 2b 45 f8          	sub    -0x8(%rbp),%rax
ffff800000103727:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(len >= DIRSIZ)
ffff80000010372a:	83 7d f4 0d          	cmpl   $0xd,-0xc(%rbp)
ffff80000010372e:	7e 21                	jle    ffff800000103751 <skipelem+0x92>
    memmove(name, s, DIRSIZ);
ffff800000103730:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff800000103734:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000103738:	ba 0e 00 00 00       	mov    $0xe,%edx
ffff80000010373d:	48 89 ce             	mov    %rcx,%rsi
ffff800000103740:	48 89 c7             	mov    %rax,%rdi
ffff800000103743:	48 b8 4d 83 10 00 00 	movabs $0xffff80000010834d,%rax
ffff80000010374a:	80 ff ff 
ffff80000010374d:	ff d0                	call   *%rax
ffff80000010374f:	eb 34                	jmp    ffff800000103785 <skipelem+0xc6>
  else {
    memmove(name, s, len);
ffff800000103751:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff800000103754:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff800000103758:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010375c:	48 89 ce             	mov    %rcx,%rsi
ffff80000010375f:	48 89 c7             	mov    %rax,%rdi
ffff800000103762:	48 b8 4d 83 10 00 00 	movabs $0xffff80000010834d,%rax
ffff800000103769:	80 ff ff 
ffff80000010376c:	ff d0                	call   *%rax
    name[len] = 0;
ffff80000010376e:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000103771:	48 63 d0             	movslq %eax,%rdx
ffff800000103774:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000103778:	48 01 d0             	add    %rdx,%rax
ffff80000010377b:	c6 00 00             	movb   $0x0,(%rax)
  }
  while(*path == '/')
ffff80000010377e:	eb 05                	jmp    ffff800000103785 <skipelem+0xc6>
    path++;
ffff800000103780:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  while(*path == '/')
ffff800000103785:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103789:	0f b6 00             	movzbl (%rax),%eax
ffff80000010378c:	3c 2f                	cmp    $0x2f,%al
ffff80000010378e:	74 f0                	je     ffff800000103780 <skipelem+0xc1>
  return path;
ffff800000103790:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
ffff800000103794:	c9                   	leave
ffff800000103795:	c3                   	ret

ffff800000103796 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
ffff800000103796:	f3 0f 1e fa          	endbr64
ffff80000010379a:	55                   	push   %rbp
ffff80000010379b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010379e:	48 83 ec 30          	sub    $0x30,%rsp
ffff8000001037a2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff8000001037a6:	89 75 e4             	mov    %esi,-0x1c(%rbp)
ffff8000001037a9:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  struct inode *ip, *next;

  if(*path == '/')
ffff8000001037ad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001037b1:	0f b6 00             	movzbl (%rax),%eax
ffff8000001037b4:	3c 2f                	cmp    $0x2f,%al
ffff8000001037b6:	75 1f                	jne    ffff8000001037d7 <namex+0x41>
    ip = iget(ROOTDEV, ROOTINO);
ffff8000001037b8:	be 01 00 00 00       	mov    $0x1,%esi
ffff8000001037bd:	bf 01 00 00 00       	mov    $0x1,%edi
ffff8000001037c2:	48 b8 44 28 10 00 00 	movabs $0xffff800000102844,%rax
ffff8000001037c9:	80 ff ff 
ffff8000001037cc:	ff d0                	call   *%rax
ffff8000001037ce:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001037d2:	e9 f7 00 00 00       	jmp    ffff8000001038ce <namex+0x138>
  else
    ip = idup(proc->cwd);
ffff8000001037d7:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001037de:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001037e2:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffff8000001037e9:	48 89 c7             	mov    %rax,%rdi
ffff8000001037ec:	48 b8 85 29 10 00 00 	movabs $0xffff800000102985,%rax
ffff8000001037f3:	80 ff ff 
ffff8000001037f6:	ff d0                	call   *%rax
ffff8000001037f8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  while((path = skipelem(path, name)) != 0){
ffff8000001037fc:	e9 cd 00 00 00       	jmp    ffff8000001038ce <namex+0x138>
    ilock(ip);
ffff800000103801:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103805:	48 89 c7             	mov    %rax,%rdi
ffff800000103808:	48 b8 de 29 10 00 00 	movabs $0xffff8000001029de,%rax
ffff80000010380f:	80 ff ff 
ffff800000103812:	ff d0                	call   *%rax
    if(ip->type != T_DIR){
ffff800000103814:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103818:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff80000010381f:	66 83 f8 01          	cmp    $0x1,%ax
ffff800000103823:	74 1d                	je     ffff800000103842 <namex+0xac>
      iunlockput(ip);
ffff800000103825:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103829:	48 89 c7             	mov    %rax,%rdi
ffff80000010382c:	48 b8 e7 2c 10 00 00 	movabs $0xffff800000102ce7,%rax
ffff800000103833:	80 ff ff 
ffff800000103836:	ff d0                	call   *%rax
      return 0;
ffff800000103838:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010383d:	e9 d9 00 00 00       	jmp    ffff80000010391b <namex+0x185>
    }
    if(nameiparent && *path == '\0'){
ffff800000103842:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
ffff800000103846:	74 27                	je     ffff80000010386f <namex+0xd9>
ffff800000103848:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010384c:	0f b6 00             	movzbl (%rax),%eax
ffff80000010384f:	84 c0                	test   %al,%al
ffff800000103851:	75 1c                	jne    ffff80000010386f <namex+0xd9>
      iunlock(ip);  // Stop one level early.
ffff800000103853:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103857:	48 89 c7             	mov    %rax,%rdi
ffff80000010385a:	48 b8 79 2b 10 00 00 	movabs $0xffff800000102b79,%rax
ffff800000103861:	80 ff ff 
ffff800000103864:	ff d0                	call   *%rax
      return ip;
ffff800000103866:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010386a:	e9 ac 00 00 00       	jmp    ffff80000010391b <namex+0x185>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
ffff80000010386f:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff800000103873:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103877:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010387c:	48 89 ce             	mov    %rcx,%rsi
ffff80000010387f:	48 89 c7             	mov    %rax,%rdi
ffff800000103882:	48 b8 7d 34 10 00 00 	movabs $0xffff80000010347d,%rax
ffff800000103889:	80 ff ff 
ffff80000010388c:	ff d0                	call   *%rax
ffff80000010388e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000103892:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000103897:	75 1a                	jne    ffff8000001038b3 <namex+0x11d>
      iunlockput(ip);
ffff800000103899:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010389d:	48 89 c7             	mov    %rax,%rdi
ffff8000001038a0:	48 b8 e7 2c 10 00 00 	movabs $0xffff800000102ce7,%rax
ffff8000001038a7:	80 ff ff 
ffff8000001038aa:	ff d0                	call   *%rax
      return 0;
ffff8000001038ac:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001038b1:	eb 68                	jmp    ffff80000010391b <namex+0x185>
    }
    iunlockput(ip);
ffff8000001038b3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001038b7:	48 89 c7             	mov    %rax,%rdi
ffff8000001038ba:	48 b8 e7 2c 10 00 00 	movabs $0xffff800000102ce7,%rax
ffff8000001038c1:	80 ff ff 
ffff8000001038c4:	ff d0                	call   *%rax
    ip = next;
ffff8000001038c6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001038ca:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((path = skipelem(path, name)) != 0){
ffff8000001038ce:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff8000001038d2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001038d6:	48 89 d6             	mov    %rdx,%rsi
ffff8000001038d9:	48 89 c7             	mov    %rax,%rdi
ffff8000001038dc:	48 b8 bf 36 10 00 00 	movabs $0xffff8000001036bf,%rax
ffff8000001038e3:	80 ff ff 
ffff8000001038e6:	ff d0                	call   *%rax
ffff8000001038e8:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff8000001038ec:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff8000001038f1:	0f 85 0a ff ff ff    	jne    ffff800000103801 <namex+0x6b>
  }
  if(nameiparent){
ffff8000001038f7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
ffff8000001038fb:	74 1a                	je     ffff800000103917 <namex+0x181>
    iput(ip);
ffff8000001038fd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103901:	48 89 c7             	mov    %rax,%rdi
ffff800000103904:	48 b8 e9 2b 10 00 00 	movabs $0xffff800000102be9,%rax
ffff80000010390b:	80 ff ff 
ffff80000010390e:	ff d0                	call   *%rax
    return 0;
ffff800000103910:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000103915:	eb 04                	jmp    ffff80000010391b <namex+0x185>
  }
  return ip;
ffff800000103917:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff80000010391b:	c9                   	leave
ffff80000010391c:	c3                   	ret

ffff80000010391d <namei>:

struct inode*
namei(char *path)
{
ffff80000010391d:	f3 0f 1e fa          	endbr64
ffff800000103921:	55                   	push   %rbp
ffff800000103922:	48 89 e5             	mov    %rsp,%rbp
ffff800000103925:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000103929:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  char name[DIRSIZ];
  return namex(path, 0, name);
ffff80000010392d:	48 8d 55 f2          	lea    -0xe(%rbp),%rdx
ffff800000103931:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103935:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010393a:	48 89 c7             	mov    %rax,%rdi
ffff80000010393d:	48 b8 96 37 10 00 00 	movabs $0xffff800000103796,%rax
ffff800000103944:	80 ff ff 
ffff800000103947:	ff d0                	call   *%rax
}
ffff800000103949:	c9                   	leave
ffff80000010394a:	c3                   	ret

ffff80000010394b <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
ffff80000010394b:	f3 0f 1e fa          	endbr64
ffff80000010394f:	55                   	push   %rbp
ffff800000103950:	48 89 e5             	mov    %rsp,%rbp
ffff800000103953:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000103957:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff80000010395b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  return namex(path, 1, name);
ffff80000010395f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000103963:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103967:	be 01 00 00 00       	mov    $0x1,%esi
ffff80000010396c:	48 89 c7             	mov    %rax,%rdi
ffff80000010396f:	48 b8 96 37 10 00 00 	movabs $0xffff800000103796,%rax
ffff800000103976:	80 ff ff 
ffff800000103979:	ff d0                	call   *%rax
}
ffff80000010397b:	c9                   	leave
ffff80000010397c:	c3                   	ret

ffff80000010397d <inb>:
// Simple PIO-based (non-DMA) IDE driver code.

#include "types.h"
#include "defs.h"
#include "param.h"
ffff80000010397d:	f3 0f 1e fa          	endbr64
ffff800000103981:	55                   	push   %rbp
ffff800000103982:	48 89 e5             	mov    %rsp,%rbp
ffff800000103985:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000103989:	89 f8                	mov    %edi,%eax
ffff80000010398b:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
ffff80000010398f:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff800000103993:	89 c2                	mov    %eax,%edx
ffff800000103995:	ec                   	in     (%dx),%al
ffff800000103996:	88 45 ff             	mov    %al,-0x1(%rbp)
#include "x86.h"
ffff800000103999:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
#include "traps.h"
ffff80000010399d:	c9                   	leave
ffff80000010399e:	c3                   	ret

ffff80000010399f <insl>:
#include "spinlock.h"
#include "sleeplock.h"
#include "fs.h"
#include "buf.h"
ffff80000010399f:	f3 0f 1e fa          	endbr64
ffff8000001039a3:	55                   	push   %rbp
ffff8000001039a4:	48 89 e5             	mov    %rsp,%rbp
ffff8000001039a7:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001039ab:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff8000001039ae:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff8000001039b2:	89 55 f8             	mov    %edx,-0x8(%rbp)

ffff8000001039b5:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001039b8:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffff8000001039bc:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff8000001039bf:	48 89 ce             	mov    %rcx,%rsi
ffff8000001039c2:	48 89 f7             	mov    %rsi,%rdi
ffff8000001039c5:	89 c1                	mov    %eax,%ecx
ffff8000001039c7:	fc                   	cld
ffff8000001039c8:	f3 6d                	rep insl (%dx),%es:(%rdi)
ffff8000001039ca:	89 c8                	mov    %ecx,%eax
ffff8000001039cc:	48 89 fe             	mov    %rdi,%rsi
ffff8000001039cf:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff8000001039d3:	89 45 f8             	mov    %eax,-0x8(%rbp)
#define SECTOR_SIZE   512
#define IDE_BSY       0x80
#define IDE_DRDY      0x40
#define IDE_DF        0x20
ffff8000001039d6:	90                   	nop
ffff8000001039d7:	c9                   	leave
ffff8000001039d8:	c3                   	ret

ffff8000001039d9 <outb>:
#define IDE_ERR       0x01

#define IDE_CMD_READ  0x20
#define IDE_CMD_WRITE 0x30
ffff8000001039d9:	f3 0f 1e fa          	endbr64
ffff8000001039dd:	55                   	push   %rbp
ffff8000001039de:	48 89 e5             	mov    %rsp,%rbp
ffff8000001039e1:	48 83 ec 08          	sub    $0x8,%rsp
ffff8000001039e5:	89 fa                	mov    %edi,%edx
ffff8000001039e7:	89 f0                	mov    %esi,%eax
ffff8000001039e9:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffff8000001039ed:	88 45 f8             	mov    %al,-0x8(%rbp)
#define IDE_CMD_RDMUL 0xc4
ffff8000001039f0:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffff8000001039f4:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffff8000001039f8:	ee                   	out    %al,(%dx)
#define IDE_CMD_WRMUL 0xc5
ffff8000001039f9:	90                   	nop
ffff8000001039fa:	c9                   	leave
ffff8000001039fb:	c3                   	ret

ffff8000001039fc <outsl>:

static struct spinlock idelock;
static struct buf *idequeue;

static int havedisk1;
static void idestart(struct buf*);
ffff8000001039fc:	f3 0f 1e fa          	endbr64
ffff800000103a00:	55                   	push   %rbp
ffff800000103a01:	48 89 e5             	mov    %rsp,%rbp
ffff800000103a04:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000103a08:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff800000103a0b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff800000103a0f:	89 55 f8             	mov    %edx,-0x8(%rbp)

ffff800000103a12:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000103a15:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffff800000103a19:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000103a1c:	48 89 ce             	mov    %rcx,%rsi
ffff800000103a1f:	89 c1                	mov    %eax,%ecx
ffff800000103a21:	fc                   	cld
ffff800000103a22:	f3 6f                	rep outsl %ds:(%rsi),(%dx)
ffff800000103a24:	89 c8                	mov    %ecx,%eax
ffff800000103a26:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff800000103a2a:	89 45 f8             	mov    %eax,-0x8(%rbp)
// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
ffff800000103a2d:	90                   	nop
ffff800000103a2e:	c9                   	leave
ffff800000103a2f:	c3                   	ret

ffff800000103a30 <idewait>:
ffff800000103a30:	f3 0f 1e fa          	endbr64
ffff800000103a34:	55                   	push   %rbp
ffff800000103a35:	48 89 e5             	mov    %rsp,%rbp
ffff800000103a38:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000103a3c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
ffff800000103a3f:	90                   	nop
ffff800000103a40:	bf f7 01 00 00       	mov    $0x1f7,%edi
ffff800000103a45:	48 b8 7d 39 10 00 00 	movabs $0xffff80000010397d,%rax
ffff800000103a4c:	80 ff ff 
ffff800000103a4f:	ff d0                	call   *%rax
ffff800000103a51:	0f b6 c0             	movzbl %al,%eax
ffff800000103a54:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000103a57:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000103a5a:	25 c0 00 00 00       	and    $0xc0,%eax
ffff800000103a5f:	83 f8 40             	cmp    $0x40,%eax
ffff800000103a62:	75 dc                	jne    ffff800000103a40 <idewait+0x10>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
ffff800000103a64:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffff800000103a68:	74 11                	je     ffff800000103a7b <idewait+0x4b>
ffff800000103a6a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000103a6d:	83 e0 21             	and    $0x21,%eax
ffff800000103a70:	85 c0                	test   %eax,%eax
ffff800000103a72:	74 07                	je     ffff800000103a7b <idewait+0x4b>
    return -1;
ffff800000103a74:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000103a79:	eb 05                	jmp    ffff800000103a80 <idewait+0x50>
  return 0;
ffff800000103a7b:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000103a80:	c9                   	leave
ffff800000103a81:	c3                   	ret

ffff800000103a82 <ideinit>:

void
ideinit(void)
{
ffff800000103a82:	f3 0f 1e fa          	endbr64
ffff800000103a86:	55                   	push   %rbp
ffff800000103a87:	48 89 e5             	mov    %rsp,%rbp
ffff800000103a8a:	48 83 ec 10          	sub    $0x10,%rsp
  initlock(&idelock, "ide");
ffff800000103a8e:	48 b8 bb d0 10 00 00 	movabs $0xffff80000010d0bb,%rax
ffff800000103a95:	80 ff ff 
ffff800000103a98:	48 89 c6             	mov    %rax,%rsi
ffff800000103a9b:	48 b8 e0 83 11 00 00 	movabs $0xffff8000001183e0,%rax
ffff800000103aa2:	80 ff ff 
ffff800000103aa5:	48 89 c7             	mov    %rax,%rdi
ffff800000103aa8:	48 b8 4f 7e 10 00 00 	movabs $0xffff800000107e4f,%rax
ffff800000103aaf:	80 ff ff 
ffff800000103ab2:	ff d0                	call   *%rax
  ioapicenable(IRQ_IDE, ncpu - 1);
ffff800000103ab4:	48 b8 40 87 11 00 00 	movabs $0xffff800000118740,%rax
ffff800000103abb:	80 ff ff 
ffff800000103abe:	8b 00                	mov    (%rax),%eax
ffff800000103ac0:	83 e8 01             	sub    $0x1,%eax
ffff800000103ac3:	89 c6                	mov    %eax,%esi
ffff800000103ac5:	bf 0e 00 00 00       	mov    $0xe,%edi
ffff800000103aca:	48 b8 2e 41 10 00 00 	movabs $0xffff80000010412e,%rax
ffff800000103ad1:	80 ff ff 
ffff800000103ad4:	ff d0                	call   *%rax
  idewait(0);
ffff800000103ad6:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000103adb:	48 b8 30 3a 10 00 00 	movabs $0xffff800000103a30,%rax
ffff800000103ae2:	80 ff ff 
ffff800000103ae5:	ff d0                	call   *%rax

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
ffff800000103ae7:	be f0 00 00 00       	mov    $0xf0,%esi
ffff800000103aec:	bf f6 01 00 00       	mov    $0x1f6,%edi
ffff800000103af1:	48 b8 d9 39 10 00 00 	movabs $0xffff8000001039d9,%rax
ffff800000103af8:	80 ff ff 
ffff800000103afb:	ff d0                	call   *%rax
  for(int i=0; i<1000; i++){
ffff800000103afd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000103b04:	eb 2b                	jmp    ffff800000103b31 <ideinit+0xaf>
    if(inb(0x1f7) != 0){
ffff800000103b06:	bf f7 01 00 00       	mov    $0x1f7,%edi
ffff800000103b0b:	48 b8 7d 39 10 00 00 	movabs $0xffff80000010397d,%rax
ffff800000103b12:	80 ff ff 
ffff800000103b15:	ff d0                	call   *%rax
ffff800000103b17:	84 c0                	test   %al,%al
ffff800000103b19:	74 12                	je     ffff800000103b2d <ideinit+0xab>
      havedisk1 = 1;
ffff800000103b1b:	48 b8 50 84 11 00 00 	movabs $0xffff800000118450,%rax
ffff800000103b22:	80 ff ff 
ffff800000103b25:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
      break;
ffff800000103b2b:	eb 0d                	jmp    ffff800000103b3a <ideinit+0xb8>
  for(int i=0; i<1000; i++){
ffff800000103b2d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000103b31:	81 7d fc e7 03 00 00 	cmpl   $0x3e7,-0x4(%rbp)
ffff800000103b38:	7e cc                	jle    ffff800000103b06 <ideinit+0x84>
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
ffff800000103b3a:	be e0 00 00 00       	mov    $0xe0,%esi
ffff800000103b3f:	bf f6 01 00 00       	mov    $0x1f6,%edi
ffff800000103b44:	48 b8 d9 39 10 00 00 	movabs $0xffff8000001039d9,%rax
ffff800000103b4b:	80 ff ff 
ffff800000103b4e:	ff d0                	call   *%rax
}
ffff800000103b50:	90                   	nop
ffff800000103b51:	c9                   	leave
ffff800000103b52:	c3                   	ret

ffff800000103b53 <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
ffff800000103b53:	f3 0f 1e fa          	endbr64
ffff800000103b57:	55                   	push   %rbp
ffff800000103b58:	48 89 e5             	mov    %rsp,%rbp
ffff800000103b5b:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000103b5f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  if(b == 0)
ffff800000103b63:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff800000103b68:	75 19                	jne    ffff800000103b83 <idestart+0x30>
    panic("idestart");
ffff800000103b6a:	48 b8 bf d0 10 00 00 	movabs $0xffff80000010d0bf,%rax
ffff800000103b71:	80 ff ff 
ffff800000103b74:	48 89 c7             	mov    %rax,%rdi
ffff800000103b77:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000103b7e:	80 ff ff 
ffff800000103b81:	ff d0                	call   *%rax
  if(b->blockno >= FSSIZE)
ffff800000103b83:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103b87:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000103b8a:	3d e7 03 00 00       	cmp    $0x3e7,%eax
ffff800000103b8f:	76 19                	jbe    ffff800000103baa <idestart+0x57>
    panic("incorrect blockno");
ffff800000103b91:	48 b8 c8 d0 10 00 00 	movabs $0xffff80000010d0c8,%rax
ffff800000103b98:	80 ff ff 
ffff800000103b9b:	48 89 c7             	mov    %rax,%rdi
ffff800000103b9e:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000103ba5:	80 ff ff 
ffff800000103ba8:	ff d0                	call   *%rax
  int sector_per_block =  BSIZE/SECTOR_SIZE;
ffff800000103baa:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  int sector = b->blockno * sector_per_block;
ffff800000103bb1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103bb5:	8b 50 08             	mov    0x8(%rax),%edx
ffff800000103bb8:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000103bbb:	0f af c2             	imul   %edx,%eax
ffff800000103bbe:	89 45 f8             	mov    %eax,-0x8(%rbp)
  int read_cmd = (sector_per_block == 1) ? IDE_CMD_READ :  IDE_CMD_RDMUL;
ffff800000103bc1:	83 7d fc 01          	cmpl   $0x1,-0x4(%rbp)
ffff800000103bc5:	75 07                	jne    ffff800000103bce <idestart+0x7b>
ffff800000103bc7:	b8 20 00 00 00       	mov    $0x20,%eax
ffff800000103bcc:	eb 05                	jmp    ffff800000103bd3 <idestart+0x80>
ffff800000103bce:	b8 c4 00 00 00       	mov    $0xc4,%eax
ffff800000103bd3:	89 45 f4             	mov    %eax,-0xc(%rbp)
  int write_cmd = (sector_per_block == 1) ? IDE_CMD_WRITE : IDE_CMD_WRMUL;
ffff800000103bd6:	83 7d fc 01          	cmpl   $0x1,-0x4(%rbp)
ffff800000103bda:	75 07                	jne    ffff800000103be3 <idestart+0x90>
ffff800000103bdc:	b8 30 00 00 00       	mov    $0x30,%eax
ffff800000103be1:	eb 05                	jmp    ffff800000103be8 <idestart+0x95>
ffff800000103be3:	b8 c5 00 00 00       	mov    $0xc5,%eax
ffff800000103be8:	89 45 f0             	mov    %eax,-0x10(%rbp)

  if (sector_per_block > 7) panic("idestart");
ffff800000103beb:	83 7d fc 07          	cmpl   $0x7,-0x4(%rbp)
ffff800000103bef:	7e 19                	jle    ffff800000103c0a <idestart+0xb7>
ffff800000103bf1:	48 b8 bf d0 10 00 00 	movabs $0xffff80000010d0bf,%rax
ffff800000103bf8:	80 ff ff 
ffff800000103bfb:	48 89 c7             	mov    %rax,%rdi
ffff800000103bfe:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000103c05:	80 ff ff 
ffff800000103c08:	ff d0                	call   *%rax

  idewait(0);
ffff800000103c0a:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000103c0f:	48 b8 30 3a 10 00 00 	movabs $0xffff800000103a30,%rax
ffff800000103c16:	80 ff ff 
ffff800000103c19:	ff d0                	call   *%rax
  outb(0x3f6, 0);  // generate interrupt
ffff800000103c1b:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000103c20:	bf f6 03 00 00       	mov    $0x3f6,%edi
ffff800000103c25:	48 b8 d9 39 10 00 00 	movabs $0xffff8000001039d9,%rax
ffff800000103c2c:	80 ff ff 
ffff800000103c2f:	ff d0                	call   *%rax
  outb(0x1f2, sector_per_block);  // number of sectors
ffff800000103c31:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000103c34:	0f b6 c0             	movzbl %al,%eax
ffff800000103c37:	89 c6                	mov    %eax,%esi
ffff800000103c39:	bf f2 01 00 00       	mov    $0x1f2,%edi
ffff800000103c3e:	48 b8 d9 39 10 00 00 	movabs $0xffff8000001039d9,%rax
ffff800000103c45:	80 ff ff 
ffff800000103c48:	ff d0                	call   *%rax
  outb(0x1f3, sector & 0xff);
ffff800000103c4a:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000103c4d:	0f b6 c0             	movzbl %al,%eax
ffff800000103c50:	89 c6                	mov    %eax,%esi
ffff800000103c52:	bf f3 01 00 00       	mov    $0x1f3,%edi
ffff800000103c57:	48 b8 d9 39 10 00 00 	movabs $0xffff8000001039d9,%rax
ffff800000103c5e:	80 ff ff 
ffff800000103c61:	ff d0                	call   *%rax
  outb(0x1f4, (sector >> 8) & 0xff);
ffff800000103c63:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000103c66:	c1 f8 08             	sar    $0x8,%eax
ffff800000103c69:	0f b6 c0             	movzbl %al,%eax
ffff800000103c6c:	89 c6                	mov    %eax,%esi
ffff800000103c6e:	bf f4 01 00 00       	mov    $0x1f4,%edi
ffff800000103c73:	48 b8 d9 39 10 00 00 	movabs $0xffff8000001039d9,%rax
ffff800000103c7a:	80 ff ff 
ffff800000103c7d:	ff d0                	call   *%rax
  outb(0x1f5, (sector >> 16) & 0xff);
ffff800000103c7f:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000103c82:	c1 f8 10             	sar    $0x10,%eax
ffff800000103c85:	0f b6 c0             	movzbl %al,%eax
ffff800000103c88:	89 c6                	mov    %eax,%esi
ffff800000103c8a:	bf f5 01 00 00       	mov    $0x1f5,%edi
ffff800000103c8f:	48 b8 d9 39 10 00 00 	movabs $0xffff8000001039d9,%rax
ffff800000103c96:	80 ff ff 
ffff800000103c99:	ff d0                	call   *%rax
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
ffff800000103c9b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103c9f:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000103ca2:	c1 e0 04             	shl    $0x4,%eax
ffff800000103ca5:	83 e0 10             	and    $0x10,%eax
ffff800000103ca8:	89 c2                	mov    %eax,%edx
ffff800000103caa:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000103cad:	c1 f8 18             	sar    $0x18,%eax
ffff800000103cb0:	83 e0 0f             	and    $0xf,%eax
ffff800000103cb3:	09 d0                	or     %edx,%eax
ffff800000103cb5:	83 c8 e0             	or     $0xffffffe0,%eax
ffff800000103cb8:	0f b6 c0             	movzbl %al,%eax
ffff800000103cbb:	89 c6                	mov    %eax,%esi
ffff800000103cbd:	bf f6 01 00 00       	mov    $0x1f6,%edi
ffff800000103cc2:	48 b8 d9 39 10 00 00 	movabs $0xffff8000001039d9,%rax
ffff800000103cc9:	80 ff ff 
ffff800000103ccc:	ff d0                	call   *%rax
  if(b->flags & B_DIRTY){
ffff800000103cce:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103cd2:	8b 00                	mov    (%rax),%eax
ffff800000103cd4:	83 e0 04             	and    $0x4,%eax
ffff800000103cd7:	85 c0                	test   %eax,%eax
ffff800000103cd9:	74 3e                	je     ffff800000103d19 <idestart+0x1c6>
    outb(0x1f7, write_cmd);
ffff800000103cdb:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000103cde:	0f b6 c0             	movzbl %al,%eax
ffff800000103ce1:	89 c6                	mov    %eax,%esi
ffff800000103ce3:	bf f7 01 00 00       	mov    $0x1f7,%edi
ffff800000103ce8:	48 b8 d9 39 10 00 00 	movabs $0xffff8000001039d9,%rax
ffff800000103cef:	80 ff ff 
ffff800000103cf2:	ff d0                	call   *%rax
    outsl(0x1f0, b->data, BSIZE/4);
ffff800000103cf4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103cf8:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000103cfe:	ba 80 00 00 00       	mov    $0x80,%edx
ffff800000103d03:	48 89 c6             	mov    %rax,%rsi
ffff800000103d06:	bf f0 01 00 00       	mov    $0x1f0,%edi
ffff800000103d0b:	48 b8 fc 39 10 00 00 	movabs $0xffff8000001039fc,%rax
ffff800000103d12:	80 ff ff 
ffff800000103d15:	ff d0                	call   *%rax
  } else {
    outb(0x1f7, read_cmd);
  }
}
ffff800000103d17:	eb 19                	jmp    ffff800000103d32 <idestart+0x1df>
    outb(0x1f7, read_cmd);
ffff800000103d19:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000103d1c:	0f b6 c0             	movzbl %al,%eax
ffff800000103d1f:	89 c6                	mov    %eax,%esi
ffff800000103d21:	bf f7 01 00 00       	mov    $0x1f7,%edi
ffff800000103d26:	48 b8 d9 39 10 00 00 	movabs $0xffff8000001039d9,%rax
ffff800000103d2d:	80 ff ff 
ffff800000103d30:	ff d0                	call   *%rax
}
ffff800000103d32:	90                   	nop
ffff800000103d33:	c9                   	leave
ffff800000103d34:	c3                   	ret

ffff800000103d35 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
ffff800000103d35:	f3 0f 1e fa          	endbr64
ffff800000103d39:	55                   	push   %rbp
ffff800000103d3a:	48 89 e5             	mov    %rsp,%rbp
ffff800000103d3d:	48 83 ec 10          	sub    $0x10,%rsp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
ffff800000103d41:	48 b8 e0 83 11 00 00 	movabs $0xffff8000001183e0,%rax
ffff800000103d48:	80 ff ff 
ffff800000103d4b:	48 89 c7             	mov    %rax,%rdi
ffff800000103d4e:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff800000103d55:	80 ff ff 
ffff800000103d58:	ff d0                	call   *%rax
  if((b = idequeue) == 0){
ffff800000103d5a:	48 b8 48 84 11 00 00 	movabs $0xffff800000118448,%rax
ffff800000103d61:	80 ff ff 
ffff800000103d64:	48 8b 00             	mov    (%rax),%rax
ffff800000103d67:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000103d6b:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000103d70:	75 1e                	jne    ffff800000103d90 <ideintr+0x5b>
    release(&idelock);
ffff800000103d72:	48 b8 e0 83 11 00 00 	movabs $0xffff8000001183e0,%rax
ffff800000103d79:	80 ff ff 
ffff800000103d7c:	48 89 c7             	mov    %rax,%rdi
ffff800000103d7f:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff800000103d86:	80 ff ff 
ffff800000103d89:	ff d0                	call   *%rax
    // cprintf("spurious IDE interrupt\n");
    return;
ffff800000103d8b:	e9 d9 00 00 00       	jmp    ffff800000103e69 <ideintr+0x134>
  }
  idequeue = b->qnext;
ffff800000103d90:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103d94:	48 8b 80 a8 00 00 00 	mov    0xa8(%rax),%rax
ffff800000103d9b:	48 ba 48 84 11 00 00 	movabs $0xffff800000118448,%rdx
ffff800000103da2:	80 ff ff 
ffff800000103da5:	48 89 02             	mov    %rax,(%rdx)

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
ffff800000103da8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103dac:	8b 00                	mov    (%rax),%eax
ffff800000103dae:	83 e0 04             	and    $0x4,%eax
ffff800000103db1:	85 c0                	test   %eax,%eax
ffff800000103db3:	75 38                	jne    ffff800000103ded <ideintr+0xb8>
ffff800000103db5:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000103dba:	48 b8 30 3a 10 00 00 	movabs $0xffff800000103a30,%rax
ffff800000103dc1:	80 ff ff 
ffff800000103dc4:	ff d0                	call   *%rax
ffff800000103dc6:	85 c0                	test   %eax,%eax
ffff800000103dc8:	78 23                	js     ffff800000103ded <ideintr+0xb8>
    insl(0x1f0, b->data, BSIZE/4);
ffff800000103dca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103dce:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000103dd4:	ba 80 00 00 00       	mov    $0x80,%edx
ffff800000103dd9:	48 89 c6             	mov    %rax,%rsi
ffff800000103ddc:	bf f0 01 00 00       	mov    $0x1f0,%edi
ffff800000103de1:	48 b8 9f 39 10 00 00 	movabs $0xffff80000010399f,%rax
ffff800000103de8:	80 ff ff 
ffff800000103deb:	ff d0                	call   *%rax

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
ffff800000103ded:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103df1:	8b 00                	mov    (%rax),%eax
ffff800000103df3:	83 c8 02             	or     $0x2,%eax
ffff800000103df6:	89 c2                	mov    %eax,%edx
ffff800000103df8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103dfc:	89 10                	mov    %edx,(%rax)
  b->flags &= ~B_DIRTY;
ffff800000103dfe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103e02:	8b 00                	mov    (%rax),%eax
ffff800000103e04:	83 e0 fb             	and    $0xfffffffb,%eax
ffff800000103e07:	89 c2                	mov    %eax,%edx
ffff800000103e09:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103e0d:	89 10                	mov    %edx,(%rax)
  wakeup(b);
ffff800000103e0f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103e13:	48 89 c7             	mov    %rax,%rdi
ffff800000103e16:	48 b8 07 74 10 00 00 	movabs $0xffff800000107407,%rax
ffff800000103e1d:	80 ff ff 
ffff800000103e20:	ff d0                	call   *%rax

  // Start disk on next buf in queue.
  if(idequeue != 0)
ffff800000103e22:	48 b8 48 84 11 00 00 	movabs $0xffff800000118448,%rax
ffff800000103e29:	80 ff ff 
ffff800000103e2c:	48 8b 00             	mov    (%rax),%rax
ffff800000103e2f:	48 85 c0             	test   %rax,%rax
ffff800000103e32:	74 1c                	je     ffff800000103e50 <ideintr+0x11b>
    idestart(idequeue);
ffff800000103e34:	48 b8 48 84 11 00 00 	movabs $0xffff800000118448,%rax
ffff800000103e3b:	80 ff ff 
ffff800000103e3e:	48 8b 00             	mov    (%rax),%rax
ffff800000103e41:	48 89 c7             	mov    %rax,%rdi
ffff800000103e44:	48 b8 53 3b 10 00 00 	movabs $0xffff800000103b53,%rax
ffff800000103e4b:	80 ff ff 
ffff800000103e4e:	ff d0                	call   *%rax

  release(&idelock);
ffff800000103e50:	48 b8 e0 83 11 00 00 	movabs $0xffff8000001183e0,%rax
ffff800000103e57:	80 ff ff 
ffff800000103e5a:	48 89 c7             	mov    %rax,%rdi
ffff800000103e5d:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff800000103e64:	80 ff ff 
ffff800000103e67:	ff d0                	call   *%rax
}
ffff800000103e69:	c9                   	leave
ffff800000103e6a:	c3                   	ret

ffff800000103e6b <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
ffff800000103e6b:	f3 0f 1e fa          	endbr64
ffff800000103e6f:	55                   	push   %rbp
ffff800000103e70:	48 89 e5             	mov    %rsp,%rbp
ffff800000103e73:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000103e77:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct buf **pp;

  if(!holdingsleep(&b->lock))
ffff800000103e7b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103e7f:	48 83 c0 10          	add    $0x10,%rax
ffff800000103e83:	48 89 c7             	mov    %rax,%rdi
ffff800000103e86:	48 b8 a8 7d 10 00 00 	movabs $0xffff800000107da8,%rax
ffff800000103e8d:	80 ff ff 
ffff800000103e90:	ff d0                	call   *%rax
ffff800000103e92:	85 c0                	test   %eax,%eax
ffff800000103e94:	75 19                	jne    ffff800000103eaf <iderw+0x44>
    panic("iderw: buf not locked");
ffff800000103e96:	48 b8 da d0 10 00 00 	movabs $0xffff80000010d0da,%rax
ffff800000103e9d:	80 ff ff 
ffff800000103ea0:	48 89 c7             	mov    %rax,%rdi
ffff800000103ea3:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000103eaa:	80 ff ff 
ffff800000103ead:	ff d0                	call   *%rax
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
ffff800000103eaf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103eb3:	8b 00                	mov    (%rax),%eax
ffff800000103eb5:	83 e0 06             	and    $0x6,%eax
ffff800000103eb8:	83 f8 02             	cmp    $0x2,%eax
ffff800000103ebb:	75 19                	jne    ffff800000103ed6 <iderw+0x6b>
    panic("iderw: nothing to do");
ffff800000103ebd:	48 b8 f0 d0 10 00 00 	movabs $0xffff80000010d0f0,%rax
ffff800000103ec4:	80 ff ff 
ffff800000103ec7:	48 89 c7             	mov    %rax,%rdi
ffff800000103eca:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000103ed1:	80 ff ff 
ffff800000103ed4:	ff d0                	call   *%rax
  if(b->dev != 0 && !havedisk1)
ffff800000103ed6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103eda:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000103edd:	85 c0                	test   %eax,%eax
ffff800000103edf:	74 29                	je     ffff800000103f0a <iderw+0x9f>
ffff800000103ee1:	48 b8 50 84 11 00 00 	movabs $0xffff800000118450,%rax
ffff800000103ee8:	80 ff ff 
ffff800000103eeb:	8b 00                	mov    (%rax),%eax
ffff800000103eed:	85 c0                	test   %eax,%eax
ffff800000103eef:	75 19                	jne    ffff800000103f0a <iderw+0x9f>
    panic("iderw: ide disk 1 not present");
ffff800000103ef1:	48 b8 05 d1 10 00 00 	movabs $0xffff80000010d105,%rax
ffff800000103ef8:	80 ff ff 
ffff800000103efb:	48 89 c7             	mov    %rax,%rdi
ffff800000103efe:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000103f05:	80 ff ff 
ffff800000103f08:	ff d0                	call   *%rax

  acquire(&idelock);  //DOC:acquire-lock
ffff800000103f0a:	48 b8 e0 83 11 00 00 	movabs $0xffff8000001183e0,%rax
ffff800000103f11:	80 ff ff 
ffff800000103f14:	48 89 c7             	mov    %rax,%rdi
ffff800000103f17:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff800000103f1e:	80 ff ff 
ffff800000103f21:	ff d0                	call   *%rax

  // Append b to idequeue.
  b->qnext = 0;
ffff800000103f23:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103f27:	48 c7 80 a8 00 00 00 	movq   $0x0,0xa8(%rax)
ffff800000103f2e:	00 00 00 00 
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
ffff800000103f32:	48 b8 48 84 11 00 00 	movabs $0xffff800000118448,%rax
ffff800000103f39:	80 ff ff 
ffff800000103f3c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000103f40:	eb 11                	jmp    ffff800000103f53 <iderw+0xe8>
ffff800000103f42:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103f46:	48 8b 00             	mov    (%rax),%rax
ffff800000103f49:	48 05 a8 00 00 00    	add    $0xa8,%rax
ffff800000103f4f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000103f53:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103f57:	48 8b 00             	mov    (%rax),%rax
ffff800000103f5a:	48 85 c0             	test   %rax,%rax
ffff800000103f5d:	75 e3                	jne    ffff800000103f42 <iderw+0xd7>
    ;
  *pp = b;
ffff800000103f5f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103f63:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000103f67:	48 89 10             	mov    %rdx,(%rax)

  // Start disk if necessary.
  if(idequeue == b)
ffff800000103f6a:	48 b8 48 84 11 00 00 	movabs $0xffff800000118448,%rax
ffff800000103f71:	80 ff ff 
ffff800000103f74:	48 8b 00             	mov    (%rax),%rax
ffff800000103f77:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffff800000103f7b:	75 35                	jne    ffff800000103fb2 <iderw+0x147>
    idestart(b);
ffff800000103f7d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103f81:	48 89 c7             	mov    %rax,%rdi
ffff800000103f84:	48 b8 53 3b 10 00 00 	movabs $0xffff800000103b53,%rax
ffff800000103f8b:	80 ff ff 
ffff800000103f8e:	ff d0                	call   *%rax

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
ffff800000103f90:	eb 20                	jmp    ffff800000103fb2 <iderw+0x147>
    sleep(b, &idelock);
ffff800000103f92:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103f96:	48 ba e0 83 11 00 00 	movabs $0xffff8000001183e0,%rdx
ffff800000103f9d:	80 ff ff 
ffff800000103fa0:	48 89 d6             	mov    %rdx,%rsi
ffff800000103fa3:	48 89 c7             	mov    %rax,%rdi
ffff800000103fa6:	48 b8 8a 72 10 00 00 	movabs $0xffff80000010728a,%rax
ffff800000103fad:	80 ff ff 
ffff800000103fb0:	ff d0                	call   *%rax
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
ffff800000103fb2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103fb6:	8b 00                	mov    (%rax),%eax
ffff800000103fb8:	83 e0 06             	and    $0x6,%eax
ffff800000103fbb:	83 f8 02             	cmp    $0x2,%eax
ffff800000103fbe:	75 d2                	jne    ffff800000103f92 <iderw+0x127>
  }

  release(&idelock);
ffff800000103fc0:	48 b8 e0 83 11 00 00 	movabs $0xffff8000001183e0,%rax
ffff800000103fc7:	80 ff ff 
ffff800000103fca:	48 89 c7             	mov    %rax,%rdi
ffff800000103fcd:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff800000103fd4:	80 ff ff 
ffff800000103fd7:	ff d0                	call   *%rax
}
ffff800000103fd9:	90                   	nop
ffff800000103fda:	c9                   	leave
ffff800000103fdb:	c3                   	ret

ffff800000103fdc <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
ffff800000103fdc:	f3 0f 1e fa          	endbr64
ffff800000103fe0:	55                   	push   %rbp
ffff800000103fe1:	48 89 e5             	mov    %rsp,%rbp
ffff800000103fe4:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000103fe8:	89 7d fc             	mov    %edi,-0x4(%rbp)
  ioapic->reg = reg;
ffff800000103feb:	48 b8 58 84 11 00 00 	movabs $0xffff800000118458,%rax
ffff800000103ff2:	80 ff ff 
ffff800000103ff5:	48 8b 00             	mov    (%rax),%rax
ffff800000103ff8:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000103ffb:	89 10                	mov    %edx,(%rax)
  return ioapic->data;
ffff800000103ffd:	48 b8 58 84 11 00 00 	movabs $0xffff800000118458,%rax
ffff800000104004:	80 ff ff 
ffff800000104007:	48 8b 00             	mov    (%rax),%rax
ffff80000010400a:	8b 40 10             	mov    0x10(%rax),%eax
}
ffff80000010400d:	c9                   	leave
ffff80000010400e:	c3                   	ret

ffff80000010400f <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
ffff80000010400f:	f3 0f 1e fa          	endbr64
ffff800000104013:	55                   	push   %rbp
ffff800000104014:	48 89 e5             	mov    %rsp,%rbp
ffff800000104017:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010401b:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff80000010401e:	89 75 f8             	mov    %esi,-0x8(%rbp)
  ioapic->reg = reg;
ffff800000104021:	48 b8 58 84 11 00 00 	movabs $0xffff800000118458,%rax
ffff800000104028:	80 ff ff 
ffff80000010402b:	48 8b 00             	mov    (%rax),%rax
ffff80000010402e:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000104031:	89 10                	mov    %edx,(%rax)
  ioapic->data = data;
ffff800000104033:	48 b8 58 84 11 00 00 	movabs $0xffff800000118458,%rax
ffff80000010403a:	80 ff ff 
ffff80000010403d:	48 8b 00             	mov    (%rax),%rax
ffff800000104040:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffff800000104043:	89 50 10             	mov    %edx,0x10(%rax)
}
ffff800000104046:	90                   	nop
ffff800000104047:	c9                   	leave
ffff800000104048:	c3                   	ret

ffff800000104049 <ioapicinit>:

void
ioapicinit(void)
{
ffff800000104049:	f3 0f 1e fa          	endbr64
ffff80000010404d:	55                   	push   %rbp
ffff80000010404e:	48 89 e5             	mov    %rsp,%rbp
ffff800000104051:	48 83 ec 10          	sub    $0x10,%rsp
  int i, id, maxintr;

  ioapic = P2V((volatile struct ioapic*)IOAPIC);
ffff800000104055:	48 b8 58 84 11 00 00 	movabs $0xffff800000118458,%rax
ffff80000010405c:	80 ff ff 
ffff80000010405f:	48 b9 00 00 c0 fe 00 	movabs $0xffff8000fec00000,%rcx
ffff800000104066:	80 ff ff 
ffff800000104069:	48 89 08             	mov    %rcx,(%rax)
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
ffff80000010406c:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000104071:	48 b8 dc 3f 10 00 00 	movabs $0xffff800000103fdc,%rax
ffff800000104078:	80 ff ff 
ffff80000010407b:	ff d0                	call   *%rax
ffff80000010407d:	c1 e8 10             	shr    $0x10,%eax
ffff800000104080:	25 ff 00 00 00       	and    $0xff,%eax
ffff800000104085:	89 45 f8             	mov    %eax,-0x8(%rbp)
  id = ioapicread(REG_ID) >> 24;
ffff800000104088:	bf 00 00 00 00       	mov    $0x0,%edi
ffff80000010408d:	48 b8 dc 3f 10 00 00 	movabs $0xffff800000103fdc,%rax
ffff800000104094:	80 ff ff 
ffff800000104097:	ff d0                	call   *%rax
ffff800000104099:	c1 e8 18             	shr    $0x18,%eax
ffff80000010409c:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(id != ioapicid)
ffff80000010409f:	48 b8 44 87 11 00 00 	movabs $0xffff800000118744,%rax
ffff8000001040a6:	80 ff ff 
ffff8000001040a9:	0f b6 00             	movzbl (%rax),%eax
ffff8000001040ac:	0f b6 c0             	movzbl %al,%eax
ffff8000001040af:	39 45 f4             	cmp    %eax,-0xc(%rbp)
ffff8000001040b2:	74 1e                	je     ffff8000001040d2 <ioapicinit+0x89>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
ffff8000001040b4:	48 b8 28 d1 10 00 00 	movabs $0xffff80000010d128,%rax
ffff8000001040bb:	80 ff ff 
ffff8000001040be:	48 89 c7             	mov    %rax,%rdi
ffff8000001040c1:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001040c6:	48 ba 38 08 10 00 00 	movabs $0xffff800000100838,%rdx
ffff8000001040cd:	80 ff ff 
ffff8000001040d0:	ff d2                	call   *%rdx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
ffff8000001040d2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001040d9:	eb 47                	jmp    ffff800000104122 <ioapicinit+0xd9>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
ffff8000001040db:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001040de:	83 c0 20             	add    $0x20,%eax
ffff8000001040e1:	0d 00 00 01 00       	or     $0x10000,%eax
ffff8000001040e6:	89 c2                	mov    %eax,%edx
ffff8000001040e8:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001040eb:	83 c0 08             	add    $0x8,%eax
ffff8000001040ee:	01 c0                	add    %eax,%eax
ffff8000001040f0:	89 d6                	mov    %edx,%esi
ffff8000001040f2:	89 c7                	mov    %eax,%edi
ffff8000001040f4:	48 b8 0f 40 10 00 00 	movabs $0xffff80000010400f,%rax
ffff8000001040fb:	80 ff ff 
ffff8000001040fe:	ff d0                	call   *%rax
    ioapicwrite(REG_TABLE+2*i+1, 0);
ffff800000104100:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104103:	83 c0 08             	add    $0x8,%eax
ffff800000104106:	01 c0                	add    %eax,%eax
ffff800000104108:	83 c0 01             	add    $0x1,%eax
ffff80000010410b:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000104110:	89 c7                	mov    %eax,%edi
ffff800000104112:	48 b8 0f 40 10 00 00 	movabs $0xffff80000010400f,%rax
ffff800000104119:	80 ff ff 
ffff80000010411c:	ff d0                	call   *%rax
  for(i = 0; i <= maxintr; i++){
ffff80000010411e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000104122:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104125:	3b 45 f8             	cmp    -0x8(%rbp),%eax
ffff800000104128:	7e b1                	jle    ffff8000001040db <ioapicinit+0x92>
  }
}
ffff80000010412a:	90                   	nop
ffff80000010412b:	90                   	nop
ffff80000010412c:	c9                   	leave
ffff80000010412d:	c3                   	ret

ffff80000010412e <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
ffff80000010412e:	f3 0f 1e fa          	endbr64
ffff800000104132:	55                   	push   %rbp
ffff800000104133:	48 89 e5             	mov    %rsp,%rbp
ffff800000104136:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010413a:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff80000010413d:	89 75 f8             	mov    %esi,-0x8(%rbp)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
ffff800000104140:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104143:	83 c0 20             	add    $0x20,%eax
ffff800000104146:	89 c2                	mov    %eax,%edx
ffff800000104148:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010414b:	83 c0 08             	add    $0x8,%eax
ffff80000010414e:	01 c0                	add    %eax,%eax
ffff800000104150:	89 d6                	mov    %edx,%esi
ffff800000104152:	89 c7                	mov    %eax,%edi
ffff800000104154:	48 b8 0f 40 10 00 00 	movabs $0xffff80000010400f,%rax
ffff80000010415b:	80 ff ff 
ffff80000010415e:	ff d0                	call   *%rax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
ffff800000104160:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000104163:	c1 e0 18             	shl    $0x18,%eax
ffff800000104166:	89 c2                	mov    %eax,%edx
ffff800000104168:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010416b:	83 c0 08             	add    $0x8,%eax
ffff80000010416e:	01 c0                	add    %eax,%eax
ffff800000104170:	83 c0 01             	add    $0x1,%eax
ffff800000104173:	89 d6                	mov    %edx,%esi
ffff800000104175:	89 c7                	mov    %eax,%edi
ffff800000104177:	48 b8 0f 40 10 00 00 	movabs $0xffff80000010400f,%rax
ffff80000010417e:	80 ff ff 
ffff800000104181:	ff d0                	call   *%rax
}
ffff800000104183:	90                   	nop
ffff800000104184:	c9                   	leave
ffff800000104185:	c3                   	ret

ffff800000104186 <kinit1>:
  struct run *freelist;
} kmem;

void
kinit1(void *vstart, void *vend)
{
ffff800000104186:	f3 0f 1e fa          	endbr64
ffff80000010418a:	55                   	push   %rbp
ffff80000010418b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010418e:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000104192:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000104196:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  initlock(&kmem.lock, "kmem");
ffff80000010419a:	48 b8 5a d1 10 00 00 	movabs $0xffff80000010d15a,%rax
ffff8000001041a1:	80 ff ff 
ffff8000001041a4:	48 89 c6             	mov    %rax,%rsi
ffff8000001041a7:	48 b8 60 84 11 00 00 	movabs $0xffff800000118460,%rax
ffff8000001041ae:	80 ff ff 
ffff8000001041b1:	48 89 c7             	mov    %rax,%rdi
ffff8000001041b4:	48 b8 4f 7e 10 00 00 	movabs $0xffff800000107e4f,%rax
ffff8000001041bb:	80 ff ff 
ffff8000001041be:	ff d0                	call   *%rax
  kmem.use_lock = 0;
ffff8000001041c0:	48 b8 60 84 11 00 00 	movabs $0xffff800000118460,%rax
ffff8000001041c7:	80 ff ff 
ffff8000001041ca:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%rax)
  kmem.freelist = 0; // empty
ffff8000001041d1:	48 b8 60 84 11 00 00 	movabs $0xffff800000118460,%rax
ffff8000001041d8:	80 ff ff 
ffff8000001041db:	48 c7 40 70 00 00 00 	movq   $0x0,0x70(%rax)
ffff8000001041e2:	00 
  freerange(vstart, vend);
ffff8000001041e3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff8000001041e7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001041eb:	48 89 d6             	mov    %rdx,%rsi
ffff8000001041ee:	48 89 c7             	mov    %rax,%rdi
ffff8000001041f1:	48 b8 1c 42 10 00 00 	movabs $0xffff80000010421c,%rax
ffff8000001041f8:	80 ff ff 
ffff8000001041fb:	ff d0                	call   *%rax
}
ffff8000001041fd:	90                   	nop
ffff8000001041fe:	c9                   	leave
ffff8000001041ff:	c3                   	ret

ffff800000104200 <kinit2>:

void
kinit2()
{
ffff800000104200:	f3 0f 1e fa          	endbr64
ffff800000104204:	55                   	push   %rbp
ffff800000104205:	48 89 e5             	mov    %rsp,%rbp
  kmem.use_lock = 1;
ffff800000104208:	48 b8 60 84 11 00 00 	movabs $0xffff800000118460,%rax
ffff80000010420f:	80 ff ff 
ffff800000104212:	c7 40 68 01 00 00 00 	movl   $0x1,0x68(%rax)
}
ffff800000104219:	90                   	nop
ffff80000010421a:	5d                   	pop    %rbp
ffff80000010421b:	c3                   	ret

ffff80000010421c <freerange>:

void
freerange(void *vstart, void *vend)
{
ffff80000010421c:	f3 0f 1e fa          	endbr64
ffff800000104220:	55                   	push   %rbp
ffff800000104221:	48 89 e5             	mov    %rsp,%rbp
ffff800000104224:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000104228:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010422c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *p;
  p = (char*)PGROUNDUP((addr_t)vstart);
ffff800000104230:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104234:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffff80000010423a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff800000104240:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
ffff800000104244:	eb 1b                	jmp    ffff800000104261 <freerange+0x45>
    kfree(p);
ffff800000104246:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010424a:	48 89 c7             	mov    %rax,%rdi
ffff80000010424d:	48 b8 75 42 10 00 00 	movabs $0xffff800000104275,%rax
ffff800000104254:	80 ff ff 
ffff800000104257:	ff d0                	call   *%rax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
ffff800000104259:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffff800000104260:	00 
ffff800000104261:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000104265:	48 05 00 10 00 00    	add    $0x1000,%rax
ffff80000010426b:	48 39 45 e0          	cmp    %rax,-0x20(%rbp)
ffff80000010426f:	73 d5                	jae    ffff800000104246 <freerange+0x2a>
}
ffff800000104271:	90                   	nop
ffff800000104272:	90                   	nop
ffff800000104273:	c9                   	leave
ffff800000104274:	c3                   	ret

ffff800000104275 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
ffff800000104275:	f3 0f 1e fa          	endbr64
ffff800000104279:	55                   	push   %rbp
ffff80000010427a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010427d:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000104281:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct run *r;

  if((addr_t)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
ffff800000104285:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104289:	25 ff 0f 00 00       	and    $0xfff,%eax
ffff80000010428e:	48 85 c0             	test   %rax,%rax
ffff800000104291:	75 29                	jne    ffff8000001042bc <kfree+0x47>
ffff800000104293:	48 b8 00 00 12 00 00 	movabs $0xffff800000120000,%rax
ffff80000010429a:	80 ff ff 
ffff80000010429d:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffff8000001042a1:	72 19                	jb     ffff8000001042bc <kfree+0x47>
ffff8000001042a3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001042a7:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff8000001042ae:	80 00 00 
ffff8000001042b1:	48 01 d0             	add    %rdx,%rax
ffff8000001042b4:	48 3d ff ff ff 0d    	cmp    $0xdffffff,%rax
ffff8000001042ba:	76 19                	jbe    ffff8000001042d5 <kfree+0x60>
    panic("kfree");
ffff8000001042bc:	48 b8 5f d1 10 00 00 	movabs $0xffff80000010d15f,%rax
ffff8000001042c3:	80 ff ff 
ffff8000001042c6:	48 89 c7             	mov    %rax,%rdi
ffff8000001042c9:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff8000001042d0:	80 ff ff 
ffff8000001042d3:	ff d0                	call   *%rax

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
ffff8000001042d5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001042d9:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff8000001042de:	be 01 00 00 00       	mov    $0x1,%esi
ffff8000001042e3:	48 89 c7             	mov    %rax,%rdi
ffff8000001042e6:	48 b8 40 82 10 00 00 	movabs $0xffff800000108240,%rax
ffff8000001042ed:	80 ff ff 
ffff8000001042f0:	ff d0                	call   *%rax

  if(kmem.use_lock)
ffff8000001042f2:	48 b8 60 84 11 00 00 	movabs $0xffff800000118460,%rax
ffff8000001042f9:	80 ff ff 
ffff8000001042fc:	8b 40 68             	mov    0x68(%rax),%eax
ffff8000001042ff:	85 c0                	test   %eax,%eax
ffff800000104301:	74 19                	je     ffff80000010431c <kfree+0xa7>
    acquire(&kmem.lock);
ffff800000104303:	48 b8 60 84 11 00 00 	movabs $0xffff800000118460,%rax
ffff80000010430a:	80 ff ff 
ffff80000010430d:	48 89 c7             	mov    %rax,%rdi
ffff800000104310:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff800000104317:	80 ff ff 
ffff80000010431a:	ff d0                	call   *%rax
  r = (struct run*)v;
ffff80000010431c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104320:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  r->next = kmem.freelist;
ffff800000104324:	48 b8 60 84 11 00 00 	movabs $0xffff800000118460,%rax
ffff80000010432b:	80 ff ff 
ffff80000010432e:	48 8b 50 70          	mov    0x70(%rax),%rdx
ffff800000104332:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000104336:	48 89 10             	mov    %rdx,(%rax)
  kmem.freelist = r;
ffff800000104339:	48 ba 60 84 11 00 00 	movabs $0xffff800000118460,%rdx
ffff800000104340:	80 ff ff 
ffff800000104343:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000104347:	48 89 42 70          	mov    %rax,0x70(%rdx)
  if(kmem.use_lock)
ffff80000010434b:	48 b8 60 84 11 00 00 	movabs $0xffff800000118460,%rax
ffff800000104352:	80 ff ff 
ffff800000104355:	8b 40 68             	mov    0x68(%rax),%eax
ffff800000104358:	85 c0                	test   %eax,%eax
ffff80000010435a:	74 19                	je     ffff800000104375 <kfree+0x100>
    release(&kmem.lock);
ffff80000010435c:	48 b8 60 84 11 00 00 	movabs $0xffff800000118460,%rax
ffff800000104363:	80 ff ff 
ffff800000104366:	48 89 c7             	mov    %rax,%rdi
ffff800000104369:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff800000104370:	80 ff ff 
ffff800000104373:	ff d0                	call   *%rax
}
ffff800000104375:	90                   	nop
ffff800000104376:	c9                   	leave
ffff800000104377:	c3                   	ret

ffff800000104378 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
ffff800000104378:	f3 0f 1e fa          	endbr64
ffff80000010437c:	55                   	push   %rbp
ffff80000010437d:	48 89 e5             	mov    %rsp,%rbp
ffff800000104380:	48 83 ec 10          	sub    $0x10,%rsp
  struct run *r;

  if(kmem.use_lock)
ffff800000104384:	48 b8 60 84 11 00 00 	movabs $0xffff800000118460,%rax
ffff80000010438b:	80 ff ff 
ffff80000010438e:	8b 40 68             	mov    0x68(%rax),%eax
ffff800000104391:	85 c0                	test   %eax,%eax
ffff800000104393:	74 19                	je     ffff8000001043ae <kalloc+0x36>
    acquire(&kmem.lock);
ffff800000104395:	48 b8 60 84 11 00 00 	movabs $0xffff800000118460,%rax
ffff80000010439c:	80 ff ff 
ffff80000010439f:	48 89 c7             	mov    %rax,%rdi
ffff8000001043a2:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff8000001043a9:	80 ff ff 
ffff8000001043ac:	ff d0                	call   *%rax
  r = kmem.freelist;
ffff8000001043ae:	48 b8 60 84 11 00 00 	movabs $0xffff800000118460,%rax
ffff8000001043b5:	80 ff ff 
ffff8000001043b8:	48 8b 40 70          	mov    0x70(%rax),%rax
ffff8000001043bc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(r)
ffff8000001043c0:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff8000001043c5:	74 28                	je     ffff8000001043ef <kalloc+0x77>
    kmem.freelist = r->next;
ffff8000001043c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001043cb:	48 8b 00             	mov    (%rax),%rax
ffff8000001043ce:	48 ba 60 84 11 00 00 	movabs $0xffff800000118460,%rdx
ffff8000001043d5:	80 ff ff 
ffff8000001043d8:	48 89 42 70          	mov    %rax,0x70(%rdx)
  else {
    panic("Out of memory!");
  }
  
  if(kmem.use_lock)
ffff8000001043dc:	48 b8 60 84 11 00 00 	movabs $0xffff800000118460,%rax
ffff8000001043e3:	80 ff ff 
ffff8000001043e6:	8b 40 68             	mov    0x68(%rax),%eax
ffff8000001043e9:	85 c0                	test   %eax,%eax
ffff8000001043eb:	74 34                	je     ffff800000104421 <kalloc+0xa9>
ffff8000001043ed:	eb 19                	jmp    ffff800000104408 <kalloc+0x90>
    panic("Out of memory!");
ffff8000001043ef:	48 b8 65 d1 10 00 00 	movabs $0xffff80000010d165,%rax
ffff8000001043f6:	80 ff ff 
ffff8000001043f9:	48 89 c7             	mov    %rax,%rdi
ffff8000001043fc:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000104403:	80 ff ff 
ffff800000104406:	ff d0                	call   *%rax
    release(&kmem.lock);
ffff800000104408:	48 b8 60 84 11 00 00 	movabs $0xffff800000118460,%rax
ffff80000010440f:	80 ff ff 
ffff800000104412:	48 89 c7             	mov    %rax,%rdi
ffff800000104415:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff80000010441c:	80 ff ff 
ffff80000010441f:	ff d0                	call   *%rax
  return (char*)r;
ffff800000104421:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000104425:	c9                   	leave
ffff800000104426:	c3                   	ret

ffff800000104427 <inb>:
#include "types.h"
#include "x86.h"
#include "defs.h"
#include "kbd.h"

ffff800000104427:	f3 0f 1e fa          	endbr64
ffff80000010442b:	55                   	push   %rbp
ffff80000010442c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010442f:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000104433:	89 f8                	mov    %edi,%eax
ffff800000104435:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
int
kbdgetc(void)
{
ffff800000104439:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff80000010443d:	89 c2                	mov    %eax,%edx
ffff80000010443f:	ec                   	in     (%dx),%al
ffff800000104440:	88 45 ff             	mov    %al,-0x1(%rbp)
  static uint shift;
ffff800000104443:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
  static uchar *charcode[4] = {
ffff800000104447:	c9                   	leave
ffff800000104448:	c3                   	ret

ffff800000104449 <kbdgetc>:
{
ffff800000104449:	f3 0f 1e fa          	endbr64
ffff80000010444d:	55                   	push   %rbp
ffff80000010444e:	48 89 e5             	mov    %rsp,%rbp
ffff800000104451:	48 83 ec 10          	sub    $0x10,%rsp
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
ffff800000104455:	bf 64 00 00 00       	mov    $0x64,%edi
ffff80000010445a:	48 b8 27 44 10 00 00 	movabs $0xffff800000104427,%rax
ffff800000104461:	80 ff ff 
ffff800000104464:	ff d0                	call   *%rax
ffff800000104466:	0f b6 c0             	movzbl %al,%eax
ffff800000104469:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if((st & KBS_DIB) == 0)
ffff80000010446c:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff80000010446f:	83 e0 01             	and    $0x1,%eax
ffff800000104472:	85 c0                	test   %eax,%eax
ffff800000104474:	75 0a                	jne    ffff800000104480 <kbdgetc+0x37>
    return -1;
ffff800000104476:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010447b:	e9 ae 01 00 00       	jmp    ffff80000010462e <kbdgetc+0x1e5>
  data = inb(KBDATAP);
ffff800000104480:	bf 60 00 00 00       	mov    $0x60,%edi
ffff800000104485:	48 b8 27 44 10 00 00 	movabs $0xffff800000104427,%rax
ffff80000010448c:	80 ff ff 
ffff80000010448f:	ff d0                	call   *%rax
ffff800000104491:	0f b6 c0             	movzbl %al,%eax
ffff800000104494:	89 45 fc             	mov    %eax,-0x4(%rbp)

  if(data == 0xE0){
ffff800000104497:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%rbp)
ffff80000010449e:	75 27                	jne    ffff8000001044c7 <kbdgetc+0x7e>
    shift |= E0ESC;
ffff8000001044a0:	48 b8 d8 84 11 00 00 	movabs $0xffff8000001184d8,%rax
ffff8000001044a7:	80 ff ff 
ffff8000001044aa:	8b 00                	mov    (%rax),%eax
ffff8000001044ac:	83 c8 40             	or     $0x40,%eax
ffff8000001044af:	89 c2                	mov    %eax,%edx
ffff8000001044b1:	48 b8 d8 84 11 00 00 	movabs $0xffff8000001184d8,%rax
ffff8000001044b8:	80 ff ff 
ffff8000001044bb:	89 10                	mov    %edx,(%rax)
    return 0;
ffff8000001044bd:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001044c2:	e9 67 01 00 00       	jmp    ffff80000010462e <kbdgetc+0x1e5>
  } else if(data & 0x80){
ffff8000001044c7:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001044ca:	25 80 00 00 00       	and    $0x80,%eax
ffff8000001044cf:	85 c0                	test   %eax,%eax
ffff8000001044d1:	74 60                	je     ffff800000104533 <kbdgetc+0xea>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
ffff8000001044d3:	48 b8 d8 84 11 00 00 	movabs $0xffff8000001184d8,%rax
ffff8000001044da:	80 ff ff 
ffff8000001044dd:	8b 00                	mov    (%rax),%eax
ffff8000001044df:	83 e0 40             	and    $0x40,%eax
ffff8000001044e2:	85 c0                	test   %eax,%eax
ffff8000001044e4:	75 08                	jne    ffff8000001044ee <kbdgetc+0xa5>
ffff8000001044e6:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001044e9:	83 e0 7f             	and    $0x7f,%eax
ffff8000001044ec:	eb 03                	jmp    ffff8000001044f1 <kbdgetc+0xa8>
ffff8000001044ee:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001044f1:	89 45 fc             	mov    %eax,-0x4(%rbp)
    shift &= ~(shiftcode[data] | E0ESC);
ffff8000001044f4:	48 ba 20 e0 10 00 00 	movabs $0xffff80000010e020,%rdx
ffff8000001044fb:	80 ff ff 
ffff8000001044fe:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104501:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
ffff800000104505:	83 c8 40             	or     $0x40,%eax
ffff800000104508:	0f b6 c0             	movzbl %al,%eax
ffff80000010450b:	f7 d0                	not    %eax
ffff80000010450d:	89 c2                	mov    %eax,%edx
ffff80000010450f:	48 b8 d8 84 11 00 00 	movabs $0xffff8000001184d8,%rax
ffff800000104516:	80 ff ff 
ffff800000104519:	8b 00                	mov    (%rax),%eax
ffff80000010451b:	21 c2                	and    %eax,%edx
ffff80000010451d:	48 b8 d8 84 11 00 00 	movabs $0xffff8000001184d8,%rax
ffff800000104524:	80 ff ff 
ffff800000104527:	89 10                	mov    %edx,(%rax)
    return 0;
ffff800000104529:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010452e:	e9 fb 00 00 00       	jmp    ffff80000010462e <kbdgetc+0x1e5>
  } else if(shift & E0ESC){
ffff800000104533:	48 b8 d8 84 11 00 00 	movabs $0xffff8000001184d8,%rax
ffff80000010453a:	80 ff ff 
ffff80000010453d:	8b 00                	mov    (%rax),%eax
ffff80000010453f:	83 e0 40             	and    $0x40,%eax
ffff800000104542:	85 c0                	test   %eax,%eax
ffff800000104544:	74 24                	je     ffff80000010456a <kbdgetc+0x121>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
ffff800000104546:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%rbp)
    shift &= ~E0ESC;
ffff80000010454d:	48 b8 d8 84 11 00 00 	movabs $0xffff8000001184d8,%rax
ffff800000104554:	80 ff ff 
ffff800000104557:	8b 00                	mov    (%rax),%eax
ffff800000104559:	83 e0 bf             	and    $0xffffffbf,%eax
ffff80000010455c:	89 c2                	mov    %eax,%edx
ffff80000010455e:	48 b8 d8 84 11 00 00 	movabs $0xffff8000001184d8,%rax
ffff800000104565:	80 ff ff 
ffff800000104568:	89 10                	mov    %edx,(%rax)
  }

  shift |= shiftcode[data];
ffff80000010456a:	48 ba 20 e0 10 00 00 	movabs $0xffff80000010e020,%rdx
ffff800000104571:	80 ff ff 
ffff800000104574:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104577:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
ffff80000010457b:	0f b6 d0             	movzbl %al,%edx
ffff80000010457e:	48 b8 d8 84 11 00 00 	movabs $0xffff8000001184d8,%rax
ffff800000104585:	80 ff ff 
ffff800000104588:	8b 00                	mov    (%rax),%eax
ffff80000010458a:	09 c2                	or     %eax,%edx
ffff80000010458c:	48 b8 d8 84 11 00 00 	movabs $0xffff8000001184d8,%rax
ffff800000104593:	80 ff ff 
ffff800000104596:	89 10                	mov    %edx,(%rax)
  shift ^= togglecode[data];
ffff800000104598:	48 ba 20 e1 10 00 00 	movabs $0xffff80000010e120,%rdx
ffff80000010459f:	80 ff ff 
ffff8000001045a2:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001045a5:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
ffff8000001045a9:	0f b6 d0             	movzbl %al,%edx
ffff8000001045ac:	48 b8 d8 84 11 00 00 	movabs $0xffff8000001184d8,%rax
ffff8000001045b3:	80 ff ff 
ffff8000001045b6:	8b 00                	mov    (%rax),%eax
ffff8000001045b8:	31 c2                	xor    %eax,%edx
ffff8000001045ba:	48 b8 d8 84 11 00 00 	movabs $0xffff8000001184d8,%rax
ffff8000001045c1:	80 ff ff 
ffff8000001045c4:	89 10                	mov    %edx,(%rax)
  c = charcode[shift & (CTL | SHIFT)][data];
ffff8000001045c6:	48 b8 d8 84 11 00 00 	movabs $0xffff8000001184d8,%rax
ffff8000001045cd:	80 ff ff 
ffff8000001045d0:	8b 00                	mov    (%rax),%eax
ffff8000001045d2:	83 e0 03             	and    $0x3,%eax
ffff8000001045d5:	89 c2                	mov    %eax,%edx
ffff8000001045d7:	48 b8 20 e5 10 00 00 	movabs $0xffff80000010e520,%rax
ffff8000001045de:	80 ff ff 
ffff8000001045e1:	89 d2                	mov    %edx,%edx
ffff8000001045e3:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
ffff8000001045e7:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001045ea:	48 01 d0             	add    %rdx,%rax
ffff8000001045ed:	0f b6 00             	movzbl (%rax),%eax
ffff8000001045f0:	0f b6 c0             	movzbl %al,%eax
ffff8000001045f3:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(shift & CAPSLOCK){
ffff8000001045f6:	48 b8 d8 84 11 00 00 	movabs $0xffff8000001184d8,%rax
ffff8000001045fd:	80 ff ff 
ffff800000104600:	8b 00                	mov    (%rax),%eax
ffff800000104602:	83 e0 08             	and    $0x8,%eax
ffff800000104605:	85 c0                	test   %eax,%eax
ffff800000104607:	74 22                	je     ffff80000010462b <kbdgetc+0x1e2>
    if('a' <= c && c <= 'z')
ffff800000104609:	83 7d f8 60          	cmpl   $0x60,-0x8(%rbp)
ffff80000010460d:	76 0c                	jbe    ffff80000010461b <kbdgetc+0x1d2>
ffff80000010460f:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%rbp)
ffff800000104613:	77 06                	ja     ffff80000010461b <kbdgetc+0x1d2>
      c += 'A' - 'a';
ffff800000104615:	83 6d f8 20          	subl   $0x20,-0x8(%rbp)
ffff800000104619:	eb 10                	jmp    ffff80000010462b <kbdgetc+0x1e2>
    else if('A' <= c && c <= 'Z')
ffff80000010461b:	83 7d f8 40          	cmpl   $0x40,-0x8(%rbp)
ffff80000010461f:	76 0a                	jbe    ffff80000010462b <kbdgetc+0x1e2>
ffff800000104621:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%rbp)
ffff800000104625:	77 04                	ja     ffff80000010462b <kbdgetc+0x1e2>
      c += 'a' - 'A';
ffff800000104627:	83 45 f8 20          	addl   $0x20,-0x8(%rbp)
  }
  return c;
ffff80000010462b:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
ffff80000010462e:	c9                   	leave
ffff80000010462f:	c3                   	ret

ffff800000104630 <kbdintr>:

void
kbdintr(void)
{
ffff800000104630:	f3 0f 1e fa          	endbr64
ffff800000104634:	55                   	push   %rbp
ffff800000104635:	48 89 e5             	mov    %rsp,%rbp
  consoleintr(kbdgetc);
ffff800000104638:	48 b8 49 44 10 00 00 	movabs $0xffff800000104449,%rax
ffff80000010463f:	80 ff ff 
ffff800000104642:	48 89 c7             	mov    %rax,%rdi
ffff800000104645:	48 b8 b5 0f 10 00 00 	movabs $0xffff800000100fb5,%rax
ffff80000010464c:	80 ff ff 
ffff80000010464f:	ff d0                	call   *%rax
}
ffff800000104651:	90                   	nop
ffff800000104652:	5d                   	pop    %rbp
ffff800000104653:	c3                   	ret

ffff800000104654 <inb>:
// The local APIC manages internal (non-I/O) interrupts.
// See Chapter 8 & Appendix C of Intel processor manual volume 3.

#include "param.h"
#include "types.h"
ffff800000104654:	f3 0f 1e fa          	endbr64
ffff800000104658:	55                   	push   %rbp
ffff800000104659:	48 89 e5             	mov    %rsp,%rbp
ffff80000010465c:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000104660:	89 f8                	mov    %edi,%eax
ffff800000104662:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
#include "defs.h"
#include "date.h"
#include "memlayout.h"
ffff800000104666:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff80000010466a:	89 c2                	mov    %eax,%edx
ffff80000010466c:	ec                   	in     (%dx),%al
ffff80000010466d:	88 45 ff             	mov    %al,-0x1(%rbp)
#include "traps.h"
ffff800000104670:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
#include "mmu.h"
ffff800000104674:	c9                   	leave
ffff800000104675:	c3                   	ret

ffff800000104676 <outb>:
#define EOI     (0x00B0/4)   // EOI
#define SVR     (0x00F0/4)   // Spurious Interrupt Vector
  #define ENABLE     0x00000100   // Unit Enable
#define ESR     (0x0280/4)   // Error Status
#define ICRLO   (0x0300/4)   // Interrupt Command
  #define INIT       0x00000500   // INIT/RESET
ffff800000104676:	f3 0f 1e fa          	endbr64
ffff80000010467a:	55                   	push   %rbp
ffff80000010467b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010467e:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000104682:	89 fa                	mov    %edi,%edx
ffff800000104684:	89 f0                	mov    %esi,%eax
ffff800000104686:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffff80000010468a:	88 45 f8             	mov    %al,-0x8(%rbp)
  #define STARTUP    0x00000600   // Startup IPI
ffff80000010468d:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffff800000104691:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffff800000104695:	ee                   	out    %al,(%dx)
  #define DELIVS     0x00001000   // Delivery status
ffff800000104696:	90                   	nop
ffff800000104697:	c9                   	leave
ffff800000104698:	c3                   	ret

ffff800000104699 <readeflags>:
cpunum(void)
{
  int apicid, i;

  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
ffff800000104699:	f3 0f 1e fa          	endbr64
ffff80000010469d:	55                   	push   %rbp
ffff80000010469e:	48 89 e5             	mov    %rsp,%rbp
ffff8000001046a1:	48 83 ec 10          	sub    $0x10,%rsp
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
ffff8000001046a5:	9c                   	pushf
ffff8000001046a6:	58                   	pop    %rax
ffff8000001046a7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  // often indirectly through acquire and release.
ffff8000001046ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  if(readeflags()&FL_IF){
ffff8000001046af:	c9                   	leave
ffff8000001046b0:	c3                   	ret

ffff8000001046b1 <lapicw>:
{
ffff8000001046b1:	f3 0f 1e fa          	endbr64
ffff8000001046b5:	55                   	push   %rbp
ffff8000001046b6:	48 89 e5             	mov    %rsp,%rbp
ffff8000001046b9:	48 83 ec 08          	sub    $0x8,%rsp
ffff8000001046bd:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff8000001046c0:	89 75 f8             	mov    %esi,-0x8(%rbp)
  lapic[index] = value;
ffff8000001046c3:	48 b8 e0 84 11 00 00 	movabs $0xffff8000001184e0,%rax
ffff8000001046ca:	80 ff ff 
ffff8000001046cd:	48 8b 00             	mov    (%rax),%rax
ffff8000001046d0:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001046d3:	48 63 d2             	movslq %edx,%rdx
ffff8000001046d6:	48 c1 e2 02          	shl    $0x2,%rdx
ffff8000001046da:	48 01 c2             	add    %rax,%rdx
ffff8000001046dd:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff8000001046e0:	89 02                	mov    %eax,(%rdx)
  lapic[ID];  // wait for write to finish, by reading
ffff8000001046e2:	48 b8 e0 84 11 00 00 	movabs $0xffff8000001184e0,%rax
ffff8000001046e9:	80 ff ff 
ffff8000001046ec:	48 8b 00             	mov    (%rax),%rax
ffff8000001046ef:	48 83 c0 20          	add    $0x20,%rax
ffff8000001046f3:	8b 00                	mov    (%rax),%eax
}
ffff8000001046f5:	90                   	nop
ffff8000001046f6:	c9                   	leave
ffff8000001046f7:	c3                   	ret

ffff8000001046f8 <lapicinit>:
{
ffff8000001046f8:	f3 0f 1e fa          	endbr64
ffff8000001046fc:	55                   	push   %rbp
ffff8000001046fd:	48 89 e5             	mov    %rsp,%rbp
  if(!lapic)
ffff800000104700:	48 b8 e0 84 11 00 00 	movabs $0xffff8000001184e0,%rax
ffff800000104707:	80 ff ff 
ffff80000010470a:	48 8b 00             	mov    (%rax),%rax
ffff80000010470d:	48 85 c0             	test   %rax,%rax
ffff800000104710:	0f 84 71 01 00 00    	je     ffff800000104887 <lapicinit+0x18f>
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
ffff800000104716:	be 3f 01 00 00       	mov    $0x13f,%esi
ffff80000010471b:	bf 3c 00 00 00       	mov    $0x3c,%edi
ffff800000104720:	48 b8 b1 46 10 00 00 	movabs $0xffff8000001046b1,%rax
ffff800000104727:	80 ff ff 
ffff80000010472a:	ff d0                	call   *%rax
  lapicw(TDCR, X1);
ffff80000010472c:	be 0b 00 00 00       	mov    $0xb,%esi
ffff800000104731:	bf f8 00 00 00       	mov    $0xf8,%edi
ffff800000104736:	48 b8 b1 46 10 00 00 	movabs $0xffff8000001046b1,%rax
ffff80000010473d:	80 ff ff 
ffff800000104740:	ff d0                	call   *%rax
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
ffff800000104742:	be 20 00 02 00       	mov    $0x20020,%esi
ffff800000104747:	bf c8 00 00 00       	mov    $0xc8,%edi
ffff80000010474c:	48 b8 b1 46 10 00 00 	movabs $0xffff8000001046b1,%rax
ffff800000104753:	80 ff ff 
ffff800000104756:	ff d0                	call   *%rax
  lapicw(TICR, 10000000);
ffff800000104758:	be 80 96 98 00       	mov    $0x989680,%esi
ffff80000010475d:	bf e0 00 00 00       	mov    $0xe0,%edi
ffff800000104762:	48 b8 b1 46 10 00 00 	movabs $0xffff8000001046b1,%rax
ffff800000104769:	80 ff ff 
ffff80000010476c:	ff d0                	call   *%rax
  lapicw(LINT0, MASKED);
ffff80000010476e:	be 00 00 01 00       	mov    $0x10000,%esi
ffff800000104773:	bf d4 00 00 00       	mov    $0xd4,%edi
ffff800000104778:	48 b8 b1 46 10 00 00 	movabs $0xffff8000001046b1,%rax
ffff80000010477f:	80 ff ff 
ffff800000104782:	ff d0                	call   *%rax
  lapicw(LINT1, MASKED);
ffff800000104784:	be 00 00 01 00       	mov    $0x10000,%esi
ffff800000104789:	bf d8 00 00 00       	mov    $0xd8,%edi
ffff80000010478e:	48 b8 b1 46 10 00 00 	movabs $0xffff8000001046b1,%rax
ffff800000104795:	80 ff ff 
ffff800000104798:	ff d0                	call   *%rax
  if(((lapic[VER]>>16) & 0xFF) >= 4)
ffff80000010479a:	48 b8 e0 84 11 00 00 	movabs $0xffff8000001184e0,%rax
ffff8000001047a1:	80 ff ff 
ffff8000001047a4:	48 8b 00             	mov    (%rax),%rax
ffff8000001047a7:	48 83 c0 30          	add    $0x30,%rax
ffff8000001047ab:	8b 00                	mov    (%rax),%eax
ffff8000001047ad:	25 00 00 fc 00       	and    $0xfc0000,%eax
ffff8000001047b2:	85 c0                	test   %eax,%eax
ffff8000001047b4:	74 16                	je     ffff8000001047cc <lapicinit+0xd4>
    lapicw(PCINT, MASKED);
ffff8000001047b6:	be 00 00 01 00       	mov    $0x10000,%esi
ffff8000001047bb:	bf d0 00 00 00       	mov    $0xd0,%edi
ffff8000001047c0:	48 b8 b1 46 10 00 00 	movabs $0xffff8000001046b1,%rax
ffff8000001047c7:	80 ff ff 
ffff8000001047ca:	ff d0                	call   *%rax
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
ffff8000001047cc:	be 33 00 00 00       	mov    $0x33,%esi
ffff8000001047d1:	bf dc 00 00 00       	mov    $0xdc,%edi
ffff8000001047d6:	48 b8 b1 46 10 00 00 	movabs $0xffff8000001046b1,%rax
ffff8000001047dd:	80 ff ff 
ffff8000001047e0:	ff d0                	call   *%rax
  lapicw(ESR, 0);
ffff8000001047e2:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001047e7:	bf a0 00 00 00       	mov    $0xa0,%edi
ffff8000001047ec:	48 b8 b1 46 10 00 00 	movabs $0xffff8000001046b1,%rax
ffff8000001047f3:	80 ff ff 
ffff8000001047f6:	ff d0                	call   *%rax
  lapicw(ESR, 0);
ffff8000001047f8:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001047fd:	bf a0 00 00 00       	mov    $0xa0,%edi
ffff800000104802:	48 b8 b1 46 10 00 00 	movabs $0xffff8000001046b1,%rax
ffff800000104809:	80 ff ff 
ffff80000010480c:	ff d0                	call   *%rax
  lapicw(EOI, 0);
ffff80000010480e:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000104813:	bf 2c 00 00 00       	mov    $0x2c,%edi
ffff800000104818:	48 b8 b1 46 10 00 00 	movabs $0xffff8000001046b1,%rax
ffff80000010481f:	80 ff ff 
ffff800000104822:	ff d0                	call   *%rax
  lapicw(ICRHI, 0);
ffff800000104824:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000104829:	bf c4 00 00 00       	mov    $0xc4,%edi
ffff80000010482e:	48 b8 b1 46 10 00 00 	movabs $0xffff8000001046b1,%rax
ffff800000104835:	80 ff ff 
ffff800000104838:	ff d0                	call   *%rax
  lapicw(ICRLO, BCAST | INIT | LEVEL);
ffff80000010483a:	be 00 85 08 00       	mov    $0x88500,%esi
ffff80000010483f:	bf c0 00 00 00       	mov    $0xc0,%edi
ffff800000104844:	48 b8 b1 46 10 00 00 	movabs $0xffff8000001046b1,%rax
ffff80000010484b:	80 ff ff 
ffff80000010484e:	ff d0                	call   *%rax
  while(lapic[ICRLO] & DELIVS)
ffff800000104850:	90                   	nop
ffff800000104851:	48 b8 e0 84 11 00 00 	movabs $0xffff8000001184e0,%rax
ffff800000104858:	80 ff ff 
ffff80000010485b:	48 8b 00             	mov    (%rax),%rax
ffff80000010485e:	48 05 00 03 00 00    	add    $0x300,%rax
ffff800000104864:	8b 00                	mov    (%rax),%eax
ffff800000104866:	25 00 10 00 00       	and    $0x1000,%eax
ffff80000010486b:	85 c0                	test   %eax,%eax
ffff80000010486d:	75 e2                	jne    ffff800000104851 <lapicinit+0x159>
  lapicw(TPR, 0);
ffff80000010486f:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000104874:	bf 20 00 00 00       	mov    $0x20,%edi
ffff800000104879:	48 b8 b1 46 10 00 00 	movabs $0xffff8000001046b1,%rax
ffff800000104880:	80 ff ff 
ffff800000104883:	ff d0                	call   *%rax
ffff800000104885:	eb 01                	jmp    ffff800000104888 <lapicinit+0x190>
    return;
ffff800000104887:	90                   	nop
}
ffff800000104888:	5d                   	pop    %rbp
ffff800000104889:	c3                   	ret

ffff80000010488a <cpunum>:
{
ffff80000010488a:	f3 0f 1e fa          	endbr64
ffff80000010488e:	55                   	push   %rbp
ffff80000010488f:	48 89 e5             	mov    %rsp,%rbp
ffff800000104892:	48 83 ec 10          	sub    $0x10,%rsp
  if(readeflags()&FL_IF){
ffff800000104896:	48 b8 99 46 10 00 00 	movabs $0xffff800000104699,%rax
ffff80000010489d:	80 ff ff 
ffff8000001048a0:	ff d0                	call   *%rax
ffff8000001048a2:	25 00 02 00 00       	and    $0x200,%eax
ffff8000001048a7:	48 85 c0             	test   %rax,%rax
ffff8000001048aa:	74 44                	je     ffff8000001048f0 <cpunum+0x66>
    static int n;
    if(n++ == 0)
ffff8000001048ac:	48 b8 e8 84 11 00 00 	movabs $0xffff8000001184e8,%rax
ffff8000001048b3:	80 ff ff 
ffff8000001048b6:	8b 00                	mov    (%rax),%eax
ffff8000001048b8:	8d 50 01             	lea    0x1(%rax),%edx
ffff8000001048bb:	48 b9 e8 84 11 00 00 	movabs $0xffff8000001184e8,%rcx
ffff8000001048c2:	80 ff ff 
ffff8000001048c5:	89 11                	mov    %edx,(%rcx)
ffff8000001048c7:	85 c0                	test   %eax,%eax
ffff8000001048c9:	75 25                	jne    ffff8000001048f0 <cpunum+0x66>
      cprintf("cpu called from %x with interrupts enabled\n",
ffff8000001048cb:	48 8b 45 08          	mov    0x8(%rbp),%rax
ffff8000001048cf:	48 89 c6             	mov    %rax,%rsi
ffff8000001048d2:	48 b8 78 d1 10 00 00 	movabs $0xffff80000010d178,%rax
ffff8000001048d9:	80 ff ff 
ffff8000001048dc:	48 89 c7             	mov    %rax,%rdi
ffff8000001048df:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001048e4:	48 ba 38 08 10 00 00 	movabs $0xffff800000100838,%rdx
ffff8000001048eb:	80 ff ff 
ffff8000001048ee:	ff d2                	call   *%rdx
        __builtin_return_address(0));
  }

  if (!lapic)
ffff8000001048f0:	48 b8 e0 84 11 00 00 	movabs $0xffff8000001184e0,%rax
ffff8000001048f7:	80 ff ff 
ffff8000001048fa:	48 8b 00             	mov    (%rax),%rax
ffff8000001048fd:	48 85 c0             	test   %rax,%rax
ffff800000104900:	75 0a                	jne    ffff80000010490c <cpunum+0x82>
    return 0;
ffff800000104902:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000104907:	e9 85 00 00 00       	jmp    ffff800000104991 <cpunum+0x107>

  apicid = lapic[ID] >> 24;
ffff80000010490c:	48 b8 e0 84 11 00 00 	movabs $0xffff8000001184e0,%rax
ffff800000104913:	80 ff ff 
ffff800000104916:	48 8b 00             	mov    (%rax),%rax
ffff800000104919:	48 83 c0 20          	add    $0x20,%rax
ffff80000010491d:	8b 00                	mov    (%rax),%eax
ffff80000010491f:	c1 e8 18             	shr    $0x18,%eax
ffff800000104922:	89 45 f8             	mov    %eax,-0x8(%rbp)
  for (i = 0; i < ncpu; ++i) {
ffff800000104925:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010492c:	eb 39                	jmp    ffff800000104967 <cpunum+0xdd>
    if (cpus[i].apicid == apicid)
ffff80000010492e:	48 b9 00 86 11 00 00 	movabs $0xffff800000118600,%rcx
ffff800000104935:	80 ff ff 
ffff800000104938:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010493b:	48 63 d0             	movslq %eax,%rdx
ffff80000010493e:	48 89 d0             	mov    %rdx,%rax
ffff800000104941:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000104945:	48 01 d0             	add    %rdx,%rax
ffff800000104948:	48 c1 e0 03          	shl    $0x3,%rax
ffff80000010494c:	48 01 c8             	add    %rcx,%rax
ffff80000010494f:	48 83 c0 01          	add    $0x1,%rax
ffff800000104953:	0f b6 00             	movzbl (%rax),%eax
ffff800000104956:	0f b6 c0             	movzbl %al,%eax
ffff800000104959:	39 45 f8             	cmp    %eax,-0x8(%rbp)
ffff80000010495c:	75 05                	jne    ffff800000104963 <cpunum+0xd9>
      return i;
ffff80000010495e:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104961:	eb 2e                	jmp    ffff800000104991 <cpunum+0x107>
  for (i = 0; i < ncpu; ++i) {
ffff800000104963:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000104967:	48 b8 40 87 11 00 00 	movabs $0xffff800000118740,%rax
ffff80000010496e:	80 ff ff 
ffff800000104971:	8b 00                	mov    (%rax),%eax
ffff800000104973:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000104976:	7c b6                	jl     ffff80000010492e <cpunum+0xa4>
  }
  panic("unknown apicid\n");
ffff800000104978:	48 b8 a4 d1 10 00 00 	movabs $0xffff80000010d1a4,%rax
ffff80000010497f:	80 ff ff 
ffff800000104982:	48 89 c7             	mov    %rax,%rdi
ffff800000104985:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010498c:	80 ff ff 
ffff80000010498f:	ff d0                	call   *%rax
}
ffff800000104991:	c9                   	leave
ffff800000104992:	c3                   	ret

ffff800000104993 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
ffff800000104993:	f3 0f 1e fa          	endbr64
ffff800000104997:	55                   	push   %rbp
ffff800000104998:	48 89 e5             	mov    %rsp,%rbp
  if(lapic)
ffff80000010499b:	48 b8 e0 84 11 00 00 	movabs $0xffff8000001184e0,%rax
ffff8000001049a2:	80 ff ff 
ffff8000001049a5:	48 8b 00             	mov    (%rax),%rax
ffff8000001049a8:	48 85 c0             	test   %rax,%rax
ffff8000001049ab:	74 16                	je     ffff8000001049c3 <lapiceoi+0x30>
    lapicw(EOI, 0);
ffff8000001049ad:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001049b2:	bf 2c 00 00 00       	mov    $0x2c,%edi
ffff8000001049b7:	48 b8 b1 46 10 00 00 	movabs $0xffff8000001046b1,%rax
ffff8000001049be:	80 ff ff 
ffff8000001049c1:	ff d0                	call   *%rax
}
ffff8000001049c3:	90                   	nop
ffff8000001049c4:	5d                   	pop    %rbp
ffff8000001049c5:	c3                   	ret

ffff8000001049c6 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
ffff8000001049c6:	f3 0f 1e fa          	endbr64
ffff8000001049ca:	55                   	push   %rbp
ffff8000001049cb:	48 89 e5             	mov    %rsp,%rbp
ffff8000001049ce:	48 83 ec 08          	sub    $0x8,%rsp
ffff8000001049d2:	89 7d fc             	mov    %edi,-0x4(%rbp)
}
ffff8000001049d5:	90                   	nop
ffff8000001049d6:	c9                   	leave
ffff8000001049d7:	c3                   	ret

ffff8000001049d8 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
ffff8000001049d8:	f3 0f 1e fa          	endbr64
ffff8000001049dc:	55                   	push   %rbp
ffff8000001049dd:	48 89 e5             	mov    %rsp,%rbp
ffff8000001049e0:	48 83 ec 18          	sub    $0x18,%rsp
ffff8000001049e4:	89 f8                	mov    %edi,%eax
ffff8000001049e6:	89 75 e8             	mov    %esi,-0x18(%rbp)
ffff8000001049e9:	88 45 ec             	mov    %al,-0x14(%rbp)
  ushort *wrv;

  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
ffff8000001049ec:	be 0f 00 00 00       	mov    $0xf,%esi
ffff8000001049f1:	bf 70 00 00 00       	mov    $0x70,%edi
ffff8000001049f6:	48 b8 76 46 10 00 00 	movabs $0xffff800000104676,%rax
ffff8000001049fd:	80 ff ff 
ffff800000104a00:	ff d0                	call   *%rax
  outb(CMOS_PORT+1, 0x0A);
ffff800000104a02:	be 0a 00 00 00       	mov    $0xa,%esi
ffff800000104a07:	bf 71 00 00 00       	mov    $0x71,%edi
ffff800000104a0c:	48 b8 76 46 10 00 00 	movabs $0xffff800000104676,%rax
ffff800000104a13:	80 ff ff 
ffff800000104a16:	ff d0                	call   *%rax
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
ffff800000104a18:	48 b8 67 04 00 00 00 	movabs $0xffff800000000467,%rax
ffff800000104a1f:	80 ff ff 
ffff800000104a22:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  wrv[0] = 0;
ffff800000104a26:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104a2a:	66 c7 00 00 00       	movw   $0x0,(%rax)
  wrv[1] = addr >> 4;
ffff800000104a2f:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000104a32:	c1 e8 04             	shr    $0x4,%eax
ffff800000104a35:	89 c2                	mov    %eax,%edx
ffff800000104a37:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104a3b:	48 83 c0 02          	add    $0x2,%rax
ffff800000104a3f:	66 89 10             	mov    %dx,(%rax)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
ffff800000104a42:	0f b6 45 ec          	movzbl -0x14(%rbp),%eax
ffff800000104a46:	c1 e0 18             	shl    $0x18,%eax
ffff800000104a49:	89 c6                	mov    %eax,%esi
ffff800000104a4b:	bf c4 00 00 00       	mov    $0xc4,%edi
ffff800000104a50:	48 b8 b1 46 10 00 00 	movabs $0xffff8000001046b1,%rax
ffff800000104a57:	80 ff ff 
ffff800000104a5a:	ff d0                	call   *%rax
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
ffff800000104a5c:	be 00 c5 00 00       	mov    $0xc500,%esi
ffff800000104a61:	bf c0 00 00 00       	mov    $0xc0,%edi
ffff800000104a66:	48 b8 b1 46 10 00 00 	movabs $0xffff8000001046b1,%rax
ffff800000104a6d:	80 ff ff 
ffff800000104a70:	ff d0                	call   *%rax
  microdelay(200);
ffff800000104a72:	bf c8 00 00 00       	mov    $0xc8,%edi
ffff800000104a77:	48 b8 c6 49 10 00 00 	movabs $0xffff8000001049c6,%rax
ffff800000104a7e:	80 ff ff 
ffff800000104a81:	ff d0                	call   *%rax
  lapicw(ICRLO, INIT | LEVEL);
ffff800000104a83:	be 00 85 00 00       	mov    $0x8500,%esi
ffff800000104a88:	bf c0 00 00 00       	mov    $0xc0,%edi
ffff800000104a8d:	48 b8 b1 46 10 00 00 	movabs $0xffff8000001046b1,%rax
ffff800000104a94:	80 ff ff 
ffff800000104a97:	ff d0                	call   *%rax
  microdelay(100);    // should be 10ms, but too slow in Bochs!
ffff800000104a99:	bf 64 00 00 00       	mov    $0x64,%edi
ffff800000104a9e:	48 b8 c6 49 10 00 00 	movabs $0xffff8000001049c6,%rax
ffff800000104aa5:	80 ff ff 
ffff800000104aa8:	ff d0                	call   *%rax
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
ffff800000104aaa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000104ab1:	eb 4b                	jmp    ffff800000104afe <lapicstartap+0x126>
    lapicw(ICRHI, apicid<<24);
ffff800000104ab3:	0f b6 45 ec          	movzbl -0x14(%rbp),%eax
ffff800000104ab7:	c1 e0 18             	shl    $0x18,%eax
ffff800000104aba:	89 c6                	mov    %eax,%esi
ffff800000104abc:	bf c4 00 00 00       	mov    $0xc4,%edi
ffff800000104ac1:	48 b8 b1 46 10 00 00 	movabs $0xffff8000001046b1,%rax
ffff800000104ac8:	80 ff ff 
ffff800000104acb:	ff d0                	call   *%rax
    lapicw(ICRLO, STARTUP | (addr>>12));
ffff800000104acd:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000104ad0:	c1 e8 0c             	shr    $0xc,%eax
ffff800000104ad3:	80 cc 06             	or     $0x6,%ah
ffff800000104ad6:	89 c6                	mov    %eax,%esi
ffff800000104ad8:	bf c0 00 00 00       	mov    $0xc0,%edi
ffff800000104add:	48 b8 b1 46 10 00 00 	movabs $0xffff8000001046b1,%rax
ffff800000104ae4:	80 ff ff 
ffff800000104ae7:	ff d0                	call   *%rax
    microdelay(200);
ffff800000104ae9:	bf c8 00 00 00       	mov    $0xc8,%edi
ffff800000104aee:	48 b8 c6 49 10 00 00 	movabs $0xffff8000001049c6,%rax
ffff800000104af5:	80 ff ff 
ffff800000104af8:	ff d0                	call   *%rax
  for(i = 0; i < 2; i++){
ffff800000104afa:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000104afe:	83 7d fc 01          	cmpl   $0x1,-0x4(%rbp)
ffff800000104b02:	7e af                	jle    ffff800000104ab3 <lapicstartap+0xdb>
  }
}
ffff800000104b04:	90                   	nop
ffff800000104b05:	90                   	nop
ffff800000104b06:	c9                   	leave
ffff800000104b07:	c3                   	ret

ffff800000104b08 <cmos_read>:
#define DAY     0x07
#define MONTH   0x08
#define YEAR    0x09

static uint cmos_read(uint reg)
{
ffff800000104b08:	f3 0f 1e fa          	endbr64
ffff800000104b0c:	55                   	push   %rbp
ffff800000104b0d:	48 89 e5             	mov    %rsp,%rbp
ffff800000104b10:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000104b14:	89 7d fc             	mov    %edi,-0x4(%rbp)
  outb(CMOS_PORT,  reg);
ffff800000104b17:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104b1a:	0f b6 c0             	movzbl %al,%eax
ffff800000104b1d:	89 c6                	mov    %eax,%esi
ffff800000104b1f:	bf 70 00 00 00       	mov    $0x70,%edi
ffff800000104b24:	48 b8 76 46 10 00 00 	movabs $0xffff800000104676,%rax
ffff800000104b2b:	80 ff ff 
ffff800000104b2e:	ff d0                	call   *%rax
  microdelay(200);
ffff800000104b30:	bf c8 00 00 00       	mov    $0xc8,%edi
ffff800000104b35:	48 b8 c6 49 10 00 00 	movabs $0xffff8000001049c6,%rax
ffff800000104b3c:	80 ff ff 
ffff800000104b3f:	ff d0                	call   *%rax

  return inb(CMOS_RETURN);
ffff800000104b41:	bf 71 00 00 00       	mov    $0x71,%edi
ffff800000104b46:	48 b8 54 46 10 00 00 	movabs $0xffff800000104654,%rax
ffff800000104b4d:	80 ff ff 
ffff800000104b50:	ff d0                	call   *%rax
ffff800000104b52:	0f b6 c0             	movzbl %al,%eax
}
ffff800000104b55:	c9                   	leave
ffff800000104b56:	c3                   	ret

ffff800000104b57 <fill_rtcdate>:

static void fill_rtcdate(struct rtcdate *r)
{
ffff800000104b57:	f3 0f 1e fa          	endbr64
ffff800000104b5b:	55                   	push   %rbp
ffff800000104b5c:	48 89 e5             	mov    %rsp,%rbp
ffff800000104b5f:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000104b63:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  r->second = cmos_read(SECS);
ffff800000104b67:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000104b6c:	48 b8 08 4b 10 00 00 	movabs $0xffff800000104b08,%rax
ffff800000104b73:	80 ff ff 
ffff800000104b76:	ff d0                	call   *%rax
ffff800000104b78:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000104b7c:	89 02                	mov    %eax,(%rdx)
  r->minute = cmos_read(MINS);
ffff800000104b7e:	bf 02 00 00 00       	mov    $0x2,%edi
ffff800000104b83:	48 b8 08 4b 10 00 00 	movabs $0xffff800000104b08,%rax
ffff800000104b8a:	80 ff ff 
ffff800000104b8d:	ff d0                	call   *%rax
ffff800000104b8f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000104b93:	89 42 04             	mov    %eax,0x4(%rdx)
  r->hour   = cmos_read(HOURS);
ffff800000104b96:	bf 04 00 00 00       	mov    $0x4,%edi
ffff800000104b9b:	48 b8 08 4b 10 00 00 	movabs $0xffff800000104b08,%rax
ffff800000104ba2:	80 ff ff 
ffff800000104ba5:	ff d0                	call   *%rax
ffff800000104ba7:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000104bab:	89 42 08             	mov    %eax,0x8(%rdx)
  r->day    = cmos_read(DAY);
ffff800000104bae:	bf 07 00 00 00       	mov    $0x7,%edi
ffff800000104bb3:	48 b8 08 4b 10 00 00 	movabs $0xffff800000104b08,%rax
ffff800000104bba:	80 ff ff 
ffff800000104bbd:	ff d0                	call   *%rax
ffff800000104bbf:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000104bc3:	89 42 0c             	mov    %eax,0xc(%rdx)
  r->month  = cmos_read(MONTH);
ffff800000104bc6:	bf 08 00 00 00       	mov    $0x8,%edi
ffff800000104bcb:	48 b8 08 4b 10 00 00 	movabs $0xffff800000104b08,%rax
ffff800000104bd2:	80 ff ff 
ffff800000104bd5:	ff d0                	call   *%rax
ffff800000104bd7:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000104bdb:	89 42 10             	mov    %eax,0x10(%rdx)
  r->year   = cmos_read(YEAR);
ffff800000104bde:	bf 09 00 00 00       	mov    $0x9,%edi
ffff800000104be3:	48 b8 08 4b 10 00 00 	movabs $0xffff800000104b08,%rax
ffff800000104bea:	80 ff ff 
ffff800000104bed:	ff d0                	call   *%rax
ffff800000104bef:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000104bf3:	89 42 14             	mov    %eax,0x14(%rdx)
}
ffff800000104bf6:	90                   	nop
ffff800000104bf7:	c9                   	leave
ffff800000104bf8:	c3                   	ret

ffff800000104bf9 <cmostime>:
//PAGEBREAK!

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
ffff800000104bf9:	f3 0f 1e fa          	endbr64
ffff800000104bfd:	55                   	push   %rbp
ffff800000104bfe:	48 89 e5             	mov    %rsp,%rbp
ffff800000104c01:	48 83 ec 50          	sub    $0x50,%rsp
ffff800000104c05:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);
ffff800000104c09:	bf 0b 00 00 00       	mov    $0xb,%edi
ffff800000104c0e:	48 b8 08 4b 10 00 00 	movabs $0xffff800000104b08,%rax
ffff800000104c15:	80 ff ff 
ffff800000104c18:	ff d0                	call   *%rax
ffff800000104c1a:	89 45 fc             	mov    %eax,-0x4(%rbp)

  bcd = (sb & (1 << 2)) == 0;
ffff800000104c1d:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104c20:	83 e0 04             	and    $0x4,%eax
ffff800000104c23:	85 c0                	test   %eax,%eax
ffff800000104c25:	0f 94 c0             	sete   %al
ffff800000104c28:	0f b6 c0             	movzbl %al,%eax
ffff800000104c2b:	89 45 f8             	mov    %eax,-0x8(%rbp)

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
ffff800000104c2e:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff800000104c32:	48 89 c7             	mov    %rax,%rdi
ffff800000104c35:	48 b8 57 4b 10 00 00 	movabs $0xffff800000104b57,%rax
ffff800000104c3c:	80 ff ff 
ffff800000104c3f:	ff d0                	call   *%rax
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
ffff800000104c41:	bf 0a 00 00 00       	mov    $0xa,%edi
ffff800000104c46:	48 b8 08 4b 10 00 00 	movabs $0xffff800000104b08,%rax
ffff800000104c4d:	80 ff ff 
ffff800000104c50:	ff d0                	call   *%rax
ffff800000104c52:	25 80 00 00 00       	and    $0x80,%eax
ffff800000104c57:	85 c0                	test   %eax,%eax
ffff800000104c59:	75 38                	jne    ffff800000104c93 <cmostime+0x9a>
        continue;
    fill_rtcdate(&t2);
ffff800000104c5b:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
ffff800000104c5f:	48 89 c7             	mov    %rax,%rdi
ffff800000104c62:	48 b8 57 4b 10 00 00 	movabs $0xffff800000104b57,%rax
ffff800000104c69:	80 ff ff 
ffff800000104c6c:	ff d0                	call   *%rax
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
ffff800000104c6e:	48 8d 4d c0          	lea    -0x40(%rbp),%rcx
ffff800000104c72:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff800000104c76:	ba 18 00 00 00       	mov    $0x18,%edx
ffff800000104c7b:	48 89 ce             	mov    %rcx,%rsi
ffff800000104c7e:	48 89 c7             	mov    %rax,%rdi
ffff800000104c81:	48 b8 da 82 10 00 00 	movabs $0xffff8000001082da,%rax
ffff800000104c88:	80 ff ff 
ffff800000104c8b:	ff d0                	call   *%rax
ffff800000104c8d:	85 c0                	test   %eax,%eax
ffff800000104c8f:	74 05                	je     ffff800000104c96 <cmostime+0x9d>
ffff800000104c91:	eb 9b                	jmp    ffff800000104c2e <cmostime+0x35>
        continue;
ffff800000104c93:	90                   	nop
    fill_rtcdate(&t1);
ffff800000104c94:	eb 98                	jmp    ffff800000104c2e <cmostime+0x35>
      break;
ffff800000104c96:	90                   	nop
  }

  // convert
  if(bcd) {
ffff800000104c97:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
ffff800000104c9b:	0f 84 b4 00 00 00    	je     ffff800000104d55 <cmostime+0x15c>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
ffff800000104ca1:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff800000104ca4:	c1 e8 04             	shr    $0x4,%eax
ffff800000104ca7:	89 c2                	mov    %eax,%edx
ffff800000104ca9:	89 d0                	mov    %edx,%eax
ffff800000104cab:	c1 e0 02             	shl    $0x2,%eax
ffff800000104cae:	01 d0                	add    %edx,%eax
ffff800000104cb0:	01 c0                	add    %eax,%eax
ffff800000104cb2:	89 c2                	mov    %eax,%edx
ffff800000104cb4:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff800000104cb7:	83 e0 0f             	and    $0xf,%eax
ffff800000104cba:	01 d0                	add    %edx,%eax
ffff800000104cbc:	89 45 e0             	mov    %eax,-0x20(%rbp)
    CONV(minute);
ffff800000104cbf:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff800000104cc2:	c1 e8 04             	shr    $0x4,%eax
ffff800000104cc5:	89 c2                	mov    %eax,%edx
ffff800000104cc7:	89 d0                	mov    %edx,%eax
ffff800000104cc9:	c1 e0 02             	shl    $0x2,%eax
ffff800000104ccc:	01 d0                	add    %edx,%eax
ffff800000104cce:	01 c0                	add    %eax,%eax
ffff800000104cd0:	89 c2                	mov    %eax,%edx
ffff800000104cd2:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff800000104cd5:	83 e0 0f             	and    $0xf,%eax
ffff800000104cd8:	01 d0                	add    %edx,%eax
ffff800000104cda:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    CONV(hour  );
ffff800000104cdd:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000104ce0:	c1 e8 04             	shr    $0x4,%eax
ffff800000104ce3:	89 c2                	mov    %eax,%edx
ffff800000104ce5:	89 d0                	mov    %edx,%eax
ffff800000104ce7:	c1 e0 02             	shl    $0x2,%eax
ffff800000104cea:	01 d0                	add    %edx,%eax
ffff800000104cec:	01 c0                	add    %eax,%eax
ffff800000104cee:	89 c2                	mov    %eax,%edx
ffff800000104cf0:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000104cf3:	83 e0 0f             	and    $0xf,%eax
ffff800000104cf6:	01 d0                	add    %edx,%eax
ffff800000104cf8:	89 45 e8             	mov    %eax,-0x18(%rbp)
    CONV(day   );
ffff800000104cfb:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000104cfe:	c1 e8 04             	shr    $0x4,%eax
ffff800000104d01:	89 c2                	mov    %eax,%edx
ffff800000104d03:	89 d0                	mov    %edx,%eax
ffff800000104d05:	c1 e0 02             	shl    $0x2,%eax
ffff800000104d08:	01 d0                	add    %edx,%eax
ffff800000104d0a:	01 c0                	add    %eax,%eax
ffff800000104d0c:	89 c2                	mov    %eax,%edx
ffff800000104d0e:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000104d11:	83 e0 0f             	and    $0xf,%eax
ffff800000104d14:	01 d0                	add    %edx,%eax
ffff800000104d16:	89 45 ec             	mov    %eax,-0x14(%rbp)
    CONV(month );
ffff800000104d19:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000104d1c:	c1 e8 04             	shr    $0x4,%eax
ffff800000104d1f:	89 c2                	mov    %eax,%edx
ffff800000104d21:	89 d0                	mov    %edx,%eax
ffff800000104d23:	c1 e0 02             	shl    $0x2,%eax
ffff800000104d26:	01 d0                	add    %edx,%eax
ffff800000104d28:	01 c0                	add    %eax,%eax
ffff800000104d2a:	89 c2                	mov    %eax,%edx
ffff800000104d2c:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000104d2f:	83 e0 0f             	and    $0xf,%eax
ffff800000104d32:	01 d0                	add    %edx,%eax
ffff800000104d34:	89 45 f0             	mov    %eax,-0x10(%rbp)
    CONV(year  );
ffff800000104d37:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000104d3a:	c1 e8 04             	shr    $0x4,%eax
ffff800000104d3d:	89 c2                	mov    %eax,%edx
ffff800000104d3f:	89 d0                	mov    %edx,%eax
ffff800000104d41:	c1 e0 02             	shl    $0x2,%eax
ffff800000104d44:	01 d0                	add    %edx,%eax
ffff800000104d46:	01 c0                	add    %eax,%eax
ffff800000104d48:	89 c2                	mov    %eax,%edx
ffff800000104d4a:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000104d4d:	83 e0 0f             	and    $0xf,%eax
ffff800000104d50:	01 d0                	add    %edx,%eax
ffff800000104d52:	89 45 f4             	mov    %eax,-0xc(%rbp)
#undef     CONV
  }

  *r = t1;
ffff800000104d55:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
ffff800000104d59:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000104d5d:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000104d61:	48 89 01             	mov    %rax,(%rcx)
ffff800000104d64:	48 89 51 08          	mov    %rdx,0x8(%rcx)
ffff800000104d68:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104d6c:	48 89 41 10          	mov    %rax,0x10(%rcx)
  r->year += 2000;
ffff800000104d70:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000104d74:	8b 40 14             	mov    0x14(%rax),%eax
ffff800000104d77:	8d 90 d0 07 00 00    	lea    0x7d0(%rax),%edx
ffff800000104d7d:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000104d81:	89 50 14             	mov    %edx,0x14(%rax)
}
ffff800000104d84:	90                   	nop
ffff800000104d85:	c9                   	leave
ffff800000104d86:	c3                   	ret

ffff800000104d87 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
ffff800000104d87:	f3 0f 1e fa          	endbr64
ffff800000104d8b:	55                   	push   %rbp
ffff800000104d8c:	48 89 e5             	mov    %rsp,%rbp
ffff800000104d8f:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000104d93:	89 7d dc             	mov    %edi,-0x24(%rbp)
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
ffff800000104d96:	48 b8 b4 d1 10 00 00 	movabs $0xffff80000010d1b4,%rax
ffff800000104d9d:	80 ff ff 
ffff800000104da0:	48 89 c6             	mov    %rax,%rsi
ffff800000104da3:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000104daa:	80 ff ff 
ffff800000104dad:	48 89 c7             	mov    %rax,%rdi
ffff800000104db0:	48 b8 4f 7e 10 00 00 	movabs $0xffff800000107e4f,%rax
ffff800000104db7:	80 ff ff 
ffff800000104dba:	ff d0                	call   *%rax
  readsb(dev, &sb);
ffff800000104dbc:	48 8d 55 e0          	lea    -0x20(%rbp),%rdx
ffff800000104dc0:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000104dc3:	48 89 d6             	mov    %rdx,%rsi
ffff800000104dc6:	89 c7                	mov    %eax,%edi
ffff800000104dc8:	48 b8 ad 21 10 00 00 	movabs $0xffff8000001021ad,%rax
ffff800000104dcf:	80 ff ff 
ffff800000104dd2:	ff d0                	call   *%rax
  log.start = sb.logstart;
ffff800000104dd4:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000104dd7:	89 c2                	mov    %eax,%edx
ffff800000104dd9:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000104de0:	80 ff ff 
ffff800000104de3:	89 50 68             	mov    %edx,0x68(%rax)
  log.size = sb.nlog;
ffff800000104de6:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000104de9:	89 c2                	mov    %eax,%edx
ffff800000104deb:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000104df2:	80 ff ff 
ffff800000104df5:	89 50 6c             	mov    %edx,0x6c(%rax)
  log.dev = dev;
ffff800000104df8:	48 ba 00 85 11 00 00 	movabs $0xffff800000118500,%rdx
ffff800000104dff:	80 ff ff 
ffff800000104e02:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000104e05:	89 42 78             	mov    %eax,0x78(%rdx)
  recover_from_log();
ffff800000104e08:	48 b8 a8 50 10 00 00 	movabs $0xffff8000001050a8,%rax
ffff800000104e0f:	80 ff ff 
ffff800000104e12:	ff d0                	call   *%rax
}
ffff800000104e14:	90                   	nop
ffff800000104e15:	c9                   	leave
ffff800000104e16:	c3                   	ret

ffff800000104e17 <install_trans>:

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
ffff800000104e17:	f3 0f 1e fa          	endbr64
ffff800000104e1b:	55                   	push   %rbp
ffff800000104e1c:	48 89 e5             	mov    %rsp,%rbp
ffff800000104e1f:	48 83 ec 20          	sub    $0x20,%rsp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
ffff800000104e23:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000104e2a:	e9 dc 00 00 00       	jmp    ffff800000104f0b <install_trans+0xf4>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
ffff800000104e2f:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000104e36:	80 ff ff 
ffff800000104e39:	8b 50 68             	mov    0x68(%rax),%edx
ffff800000104e3c:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104e3f:	01 d0                	add    %edx,%eax
ffff800000104e41:	83 c0 01             	add    $0x1,%eax
ffff800000104e44:	89 c2                	mov    %eax,%edx
ffff800000104e46:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000104e4d:	80 ff ff 
ffff800000104e50:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000104e53:	89 d6                	mov    %edx,%esi
ffff800000104e55:	89 c7                	mov    %eax,%edi
ffff800000104e57:	48 b8 d4 03 10 00 00 	movabs $0xffff8000001003d4,%rax
ffff800000104e5e:	80 ff ff 
ffff800000104e61:	ff d0                	call   *%rax
ffff800000104e63:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
ffff800000104e67:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000104e6e:	80 ff ff 
ffff800000104e71:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000104e74:	48 63 d2             	movslq %edx,%rdx
ffff800000104e77:	48 83 c2 1c          	add    $0x1c,%rdx
ffff800000104e7b:	8b 44 90 10          	mov    0x10(%rax,%rdx,4),%eax
ffff800000104e7f:	89 c2                	mov    %eax,%edx
ffff800000104e81:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000104e88:	80 ff ff 
ffff800000104e8b:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000104e8e:	89 d6                	mov    %edx,%esi
ffff800000104e90:	89 c7                	mov    %eax,%edi
ffff800000104e92:	48 b8 d4 03 10 00 00 	movabs $0xffff8000001003d4,%rax
ffff800000104e99:	80 ff ff 
ffff800000104e9c:	ff d0                	call   *%rax
ffff800000104e9e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
ffff800000104ea2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104ea6:	48 8d 88 b0 00 00 00 	lea    0xb0(%rax),%rcx
ffff800000104ead:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104eb1:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000104eb7:	ba 00 02 00 00       	mov    $0x200,%edx
ffff800000104ebc:	48 89 ce             	mov    %rcx,%rsi
ffff800000104ebf:	48 89 c7             	mov    %rax,%rdi
ffff800000104ec2:	48 b8 4d 83 10 00 00 	movabs $0xffff80000010834d,%rax
ffff800000104ec9:	80 ff ff 
ffff800000104ecc:	ff d0                	call   *%rax
    bwrite(dbuf);  // write dst to disk
ffff800000104ece:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104ed2:	48 89 c7             	mov    %rax,%rdi
ffff800000104ed5:	48 b8 26 04 10 00 00 	movabs $0xffff800000100426,%rax
ffff800000104edc:	80 ff ff 
ffff800000104edf:	ff d0                	call   *%rax
    brelse(lbuf);
ffff800000104ee1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104ee5:	48 89 c7             	mov    %rax,%rdi
ffff800000104ee8:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff800000104eef:	80 ff ff 
ffff800000104ef2:	ff d0                	call   *%rax
    brelse(dbuf);
ffff800000104ef4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104ef8:	48 89 c7             	mov    %rax,%rdi
ffff800000104efb:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff800000104f02:	80 ff ff 
ffff800000104f05:	ff d0                	call   *%rax
  for (tail = 0; tail < log.lh.n; tail++) {
ffff800000104f07:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000104f0b:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000104f12:	80 ff ff 
ffff800000104f15:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000104f18:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000104f1b:	0f 8c 0e ff ff ff    	jl     ffff800000104e2f <install_trans+0x18>
  }
}
ffff800000104f21:	90                   	nop
ffff800000104f22:	90                   	nop
ffff800000104f23:	c9                   	leave
ffff800000104f24:	c3                   	ret

ffff800000104f25 <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
ffff800000104f25:	f3 0f 1e fa          	endbr64
ffff800000104f29:	55                   	push   %rbp
ffff800000104f2a:	48 89 e5             	mov    %rsp,%rbp
ffff800000104f2d:	48 83 ec 20          	sub    $0x20,%rsp
  struct buf *buf = bread(log.dev, log.start);
ffff800000104f31:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000104f38:	80 ff ff 
ffff800000104f3b:	8b 40 68             	mov    0x68(%rax),%eax
ffff800000104f3e:	89 c2                	mov    %eax,%edx
ffff800000104f40:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000104f47:	80 ff ff 
ffff800000104f4a:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000104f4d:	89 d6                	mov    %edx,%esi
ffff800000104f4f:	89 c7                	mov    %eax,%edi
ffff800000104f51:	48 b8 d4 03 10 00 00 	movabs $0xffff8000001003d4,%rax
ffff800000104f58:	80 ff ff 
ffff800000104f5b:	ff d0                	call   *%rax
ffff800000104f5d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  struct logheader *lh = (struct logheader *) (buf->data);
ffff800000104f61:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104f65:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000104f6b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  int i;
  log.lh.n = lh->n;
ffff800000104f6f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104f73:	8b 00                	mov    (%rax),%eax
ffff800000104f75:	48 ba 00 85 11 00 00 	movabs $0xffff800000118500,%rdx
ffff800000104f7c:	80 ff ff 
ffff800000104f7f:	89 42 7c             	mov    %eax,0x7c(%rdx)
  for (i = 0; i < log.lh.n; i++) {
ffff800000104f82:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000104f89:	eb 2a                	jmp    ffff800000104fb5 <read_head+0x90>
    log.lh.block[i] = lh->block[i];
ffff800000104f8b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104f8f:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000104f92:	48 63 d2             	movslq %edx,%rdx
ffff800000104f95:	8b 44 90 04          	mov    0x4(%rax,%rdx,4),%eax
ffff800000104f99:	48 ba 00 85 11 00 00 	movabs $0xffff800000118500,%rdx
ffff800000104fa0:	80 ff ff 
ffff800000104fa3:	8b 4d fc             	mov    -0x4(%rbp),%ecx
ffff800000104fa6:	48 63 c9             	movslq %ecx,%rcx
ffff800000104fa9:	48 83 c1 1c          	add    $0x1c,%rcx
ffff800000104fad:	89 44 8a 10          	mov    %eax,0x10(%rdx,%rcx,4)
  for (i = 0; i < log.lh.n; i++) {
ffff800000104fb1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000104fb5:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000104fbc:	80 ff ff 
ffff800000104fbf:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000104fc2:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000104fc5:	7c c4                	jl     ffff800000104f8b <read_head+0x66>
  }
  brelse(buf);
ffff800000104fc7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104fcb:	48 89 c7             	mov    %rax,%rdi
ffff800000104fce:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff800000104fd5:	80 ff ff 
ffff800000104fd8:	ff d0                	call   *%rax
}
ffff800000104fda:	90                   	nop
ffff800000104fdb:	c9                   	leave
ffff800000104fdc:	c3                   	ret

ffff800000104fdd <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
ffff800000104fdd:	f3 0f 1e fa          	endbr64
ffff800000104fe1:	55                   	push   %rbp
ffff800000104fe2:	48 89 e5             	mov    %rsp,%rbp
ffff800000104fe5:	48 83 ec 20          	sub    $0x20,%rsp
  struct buf *buf = bread(log.dev, log.start);
ffff800000104fe9:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000104ff0:	80 ff ff 
ffff800000104ff3:	8b 40 68             	mov    0x68(%rax),%eax
ffff800000104ff6:	89 c2                	mov    %eax,%edx
ffff800000104ff8:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000104fff:	80 ff ff 
ffff800000105002:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000105005:	89 d6                	mov    %edx,%esi
ffff800000105007:	89 c7                	mov    %eax,%edi
ffff800000105009:	48 b8 d4 03 10 00 00 	movabs $0xffff8000001003d4,%rax
ffff800000105010:	80 ff ff 
ffff800000105013:	ff d0                	call   *%rax
ffff800000105015:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  struct logheader *hb = (struct logheader *) (buf->data);
ffff800000105019:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010501d:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000105023:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  int i;
  hb->n = log.lh.n;
ffff800000105027:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff80000010502e:	80 ff ff 
ffff800000105031:	8b 50 7c             	mov    0x7c(%rax),%edx
ffff800000105034:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105038:	89 10                	mov    %edx,(%rax)
  for (i = 0; i < log.lh.n; i++) {
ffff80000010503a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000105041:	eb 2a                	jmp    ffff80000010506d <write_head+0x90>
    hb->block[i] = log.lh.block[i];
ffff800000105043:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff80000010504a:	80 ff ff 
ffff80000010504d:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000105050:	48 63 d2             	movslq %edx,%rdx
ffff800000105053:	48 83 c2 1c          	add    $0x1c,%rdx
ffff800000105057:	8b 4c 90 10          	mov    0x10(%rax,%rdx,4),%ecx
ffff80000010505b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010505f:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000105062:	48 63 d2             	movslq %edx,%rdx
ffff800000105065:	89 4c 90 04          	mov    %ecx,0x4(%rax,%rdx,4)
  for (i = 0; i < log.lh.n; i++) {
ffff800000105069:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff80000010506d:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000105074:	80 ff ff 
ffff800000105077:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff80000010507a:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff80000010507d:	7c c4                	jl     ffff800000105043 <write_head+0x66>
  }
  bwrite(buf);
ffff80000010507f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105083:	48 89 c7             	mov    %rax,%rdi
ffff800000105086:	48 b8 26 04 10 00 00 	movabs $0xffff800000100426,%rax
ffff80000010508d:	80 ff ff 
ffff800000105090:	ff d0                	call   *%rax
  brelse(buf);
ffff800000105092:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105096:	48 89 c7             	mov    %rax,%rdi
ffff800000105099:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff8000001050a0:	80 ff ff 
ffff8000001050a3:	ff d0                	call   *%rax
}
ffff8000001050a5:	90                   	nop
ffff8000001050a6:	c9                   	leave
ffff8000001050a7:	c3                   	ret

ffff8000001050a8 <recover_from_log>:

static void
recover_from_log(void)
{
ffff8000001050a8:	f3 0f 1e fa          	endbr64
ffff8000001050ac:	55                   	push   %rbp
ffff8000001050ad:	48 89 e5             	mov    %rsp,%rbp
  read_head();
ffff8000001050b0:	48 b8 25 4f 10 00 00 	movabs $0xffff800000104f25,%rax
ffff8000001050b7:	80 ff ff 
ffff8000001050ba:	ff d0                	call   *%rax
  install_trans(); // if committed, copy from log to disk
ffff8000001050bc:	48 b8 17 4e 10 00 00 	movabs $0xffff800000104e17,%rax
ffff8000001050c3:	80 ff ff 
ffff8000001050c6:	ff d0                	call   *%rax
  log.lh.n = 0;
ffff8000001050c8:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff8000001050cf:	80 ff ff 
ffff8000001050d2:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%rax)
  write_head(); // clear the log
ffff8000001050d9:	48 b8 dd 4f 10 00 00 	movabs $0xffff800000104fdd,%rax
ffff8000001050e0:	80 ff ff 
ffff8000001050e3:	ff d0                	call   *%rax
}
ffff8000001050e5:	90                   	nop
ffff8000001050e6:	5d                   	pop    %rbp
ffff8000001050e7:	c3                   	ret

ffff8000001050e8 <begin_op>:

// called at the start of each FS system call.
void
begin_op(void)
{
ffff8000001050e8:	f3 0f 1e fa          	endbr64
ffff8000001050ec:	55                   	push   %rbp
ffff8000001050ed:	48 89 e5             	mov    %rsp,%rbp
  acquire(&log.lock);
ffff8000001050f0:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff8000001050f7:	80 ff ff 
ffff8000001050fa:	48 89 c7             	mov    %rax,%rdi
ffff8000001050fd:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff800000105104:	80 ff ff 
ffff800000105107:	ff d0                	call   *%rax
  while(1){
    if(log.committing){
ffff800000105109:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000105110:	80 ff ff 
ffff800000105113:	8b 40 74             	mov    0x74(%rax),%eax
ffff800000105116:	85 c0                	test   %eax,%eax
ffff800000105118:	74 28                	je     ffff800000105142 <begin_op+0x5a>
      sleep(&log, &log.lock);
ffff80000010511a:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000105121:	80 ff ff 
ffff800000105124:	48 89 c6             	mov    %rax,%rsi
ffff800000105127:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff80000010512e:	80 ff ff 
ffff800000105131:	48 89 c7             	mov    %rax,%rdi
ffff800000105134:	48 b8 8a 72 10 00 00 	movabs $0xffff80000010728a,%rax
ffff80000010513b:	80 ff ff 
ffff80000010513e:	ff d0                	call   *%rax
ffff800000105140:	eb c7                	jmp    ffff800000105109 <begin_op+0x21>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
ffff800000105142:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000105149:	80 ff ff 
ffff80000010514c:	8b 48 7c             	mov    0x7c(%rax),%ecx
ffff80000010514f:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000105156:	80 ff ff 
ffff800000105159:	8b 40 70             	mov    0x70(%rax),%eax
ffff80000010515c:	8d 50 01             	lea    0x1(%rax),%edx
ffff80000010515f:	89 d0                	mov    %edx,%eax
ffff800000105161:	c1 e0 02             	shl    $0x2,%eax
ffff800000105164:	01 d0                	add    %edx,%eax
ffff800000105166:	01 c0                	add    %eax,%eax
ffff800000105168:	01 c8                	add    %ecx,%eax
ffff80000010516a:	83 f8 1e             	cmp    $0x1e,%eax
ffff80000010516d:	7e 2b                	jle    ffff80000010519a <begin_op+0xb2>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
ffff80000010516f:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000105176:	80 ff ff 
ffff800000105179:	48 89 c6             	mov    %rax,%rsi
ffff80000010517c:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000105183:	80 ff ff 
ffff800000105186:	48 89 c7             	mov    %rax,%rdi
ffff800000105189:	48 b8 8a 72 10 00 00 	movabs $0xffff80000010728a,%rax
ffff800000105190:	80 ff ff 
ffff800000105193:	ff d0                	call   *%rax
ffff800000105195:	e9 6f ff ff ff       	jmp    ffff800000105109 <begin_op+0x21>
    } else {
      log.outstanding += 1;
ffff80000010519a:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff8000001051a1:	80 ff ff 
ffff8000001051a4:	8b 40 70             	mov    0x70(%rax),%eax
ffff8000001051a7:	8d 50 01             	lea    0x1(%rax),%edx
ffff8000001051aa:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff8000001051b1:	80 ff ff 
ffff8000001051b4:	89 50 70             	mov    %edx,0x70(%rax)
      release(&log.lock);
ffff8000001051b7:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff8000001051be:	80 ff ff 
ffff8000001051c1:	48 89 c7             	mov    %rax,%rdi
ffff8000001051c4:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff8000001051cb:	80 ff ff 
ffff8000001051ce:	ff d0                	call   *%rax
      break;
ffff8000001051d0:	90                   	nop
    }
  }
}
ffff8000001051d1:	90                   	nop
ffff8000001051d2:	5d                   	pop    %rbp
ffff8000001051d3:	c3                   	ret

ffff8000001051d4 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
ffff8000001051d4:	f3 0f 1e fa          	endbr64
ffff8000001051d8:	55                   	push   %rbp
ffff8000001051d9:	48 89 e5             	mov    %rsp,%rbp
ffff8000001051dc:	48 83 ec 10          	sub    $0x10,%rsp
  int do_commit = 0;
ffff8000001051e0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)

  acquire(&log.lock);
ffff8000001051e7:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff8000001051ee:	80 ff ff 
ffff8000001051f1:	48 89 c7             	mov    %rax,%rdi
ffff8000001051f4:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff8000001051fb:	80 ff ff 
ffff8000001051fe:	ff d0                	call   *%rax
  log.outstanding -= 1;
ffff800000105200:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000105207:	80 ff ff 
ffff80000010520a:	8b 40 70             	mov    0x70(%rax),%eax
ffff80000010520d:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000105210:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000105217:	80 ff ff 
ffff80000010521a:	89 50 70             	mov    %edx,0x70(%rax)
  if(log.committing)
ffff80000010521d:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000105224:	80 ff ff 
ffff800000105227:	8b 40 74             	mov    0x74(%rax),%eax
ffff80000010522a:	85 c0                	test   %eax,%eax
ffff80000010522c:	74 19                	je     ffff800000105247 <end_op+0x73>
    panic("log.committing");
ffff80000010522e:	48 b8 b8 d1 10 00 00 	movabs $0xffff80000010d1b8,%rax
ffff800000105235:	80 ff ff 
ffff800000105238:	48 89 c7             	mov    %rax,%rdi
ffff80000010523b:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000105242:	80 ff ff 
ffff800000105245:	ff d0                	call   *%rax
  if(log.outstanding == 0){
ffff800000105247:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff80000010524e:	80 ff ff 
ffff800000105251:	8b 40 70             	mov    0x70(%rax),%eax
ffff800000105254:	85 c0                	test   %eax,%eax
ffff800000105256:	75 1a                	jne    ffff800000105272 <end_op+0x9e>
    do_commit = 1;
ffff800000105258:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
    log.committing = 1;
ffff80000010525f:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000105266:	80 ff ff 
ffff800000105269:	c7 40 74 01 00 00 00 	movl   $0x1,0x74(%rax)
ffff800000105270:	eb 19                	jmp    ffff80000010528b <end_op+0xb7>
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
ffff800000105272:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000105279:	80 ff ff 
ffff80000010527c:	48 89 c7             	mov    %rax,%rdi
ffff80000010527f:	48 b8 07 74 10 00 00 	movabs $0xffff800000107407,%rax
ffff800000105286:	80 ff ff 
ffff800000105289:	ff d0                	call   *%rax
  }
  release(&log.lock);
ffff80000010528b:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000105292:	80 ff ff 
ffff800000105295:	48 89 c7             	mov    %rax,%rdi
ffff800000105298:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff80000010529f:	80 ff ff 
ffff8000001052a2:	ff d0                	call   *%rax

  if(do_commit){
ffff8000001052a4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff8000001052a8:	74 6d                	je     ffff800000105317 <end_op+0x143>
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
ffff8000001052aa:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001052af:	48 ba 28 54 10 00 00 	movabs $0xffff800000105428,%rdx
ffff8000001052b6:	80 ff ff 
ffff8000001052b9:	ff d2                	call   *%rdx
    acquire(&log.lock);
ffff8000001052bb:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff8000001052c2:	80 ff ff 
ffff8000001052c5:	48 89 c7             	mov    %rax,%rdi
ffff8000001052c8:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff8000001052cf:	80 ff ff 
ffff8000001052d2:	ff d0                	call   *%rax
    log.committing = 0;
ffff8000001052d4:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff8000001052db:	80 ff ff 
ffff8000001052de:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%rax)
    wakeup(&log);
ffff8000001052e5:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff8000001052ec:	80 ff ff 
ffff8000001052ef:	48 89 c7             	mov    %rax,%rdi
ffff8000001052f2:	48 b8 07 74 10 00 00 	movabs $0xffff800000107407,%rax
ffff8000001052f9:	80 ff ff 
ffff8000001052fc:	ff d0                	call   *%rax
    release(&log.lock);
ffff8000001052fe:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000105305:	80 ff ff 
ffff800000105308:	48 89 c7             	mov    %rax,%rdi
ffff80000010530b:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff800000105312:	80 ff ff 
ffff800000105315:	ff d0                	call   *%rax
  }
}
ffff800000105317:	90                   	nop
ffff800000105318:	c9                   	leave
ffff800000105319:	c3                   	ret

ffff80000010531a <write_log>:

// Copy modified blocks from cache to log.
static void
write_log(void)
{
ffff80000010531a:	f3 0f 1e fa          	endbr64
ffff80000010531e:	55                   	push   %rbp
ffff80000010531f:	48 89 e5             	mov    %rsp,%rbp
ffff800000105322:	48 83 ec 20          	sub    $0x20,%rsp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
ffff800000105326:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010532d:	e9 dc 00 00 00       	jmp    ffff80000010540e <write_log+0xf4>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
ffff800000105332:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000105339:	80 ff ff 
ffff80000010533c:	8b 50 68             	mov    0x68(%rax),%edx
ffff80000010533f:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000105342:	01 d0                	add    %edx,%eax
ffff800000105344:	83 c0 01             	add    $0x1,%eax
ffff800000105347:	89 c2                	mov    %eax,%edx
ffff800000105349:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000105350:	80 ff ff 
ffff800000105353:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000105356:	89 d6                	mov    %edx,%esi
ffff800000105358:	89 c7                	mov    %eax,%edi
ffff80000010535a:	48 b8 d4 03 10 00 00 	movabs $0xffff8000001003d4,%rax
ffff800000105361:	80 ff ff 
ffff800000105364:	ff d0                	call   *%rax
ffff800000105366:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
ffff80000010536a:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000105371:	80 ff ff 
ffff800000105374:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000105377:	48 63 d2             	movslq %edx,%rdx
ffff80000010537a:	48 83 c2 1c          	add    $0x1c,%rdx
ffff80000010537e:	8b 44 90 10          	mov    0x10(%rax,%rdx,4),%eax
ffff800000105382:	89 c2                	mov    %eax,%edx
ffff800000105384:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff80000010538b:	80 ff ff 
ffff80000010538e:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000105391:	89 d6                	mov    %edx,%esi
ffff800000105393:	89 c7                	mov    %eax,%edi
ffff800000105395:	48 b8 d4 03 10 00 00 	movabs $0xffff8000001003d4,%rax
ffff80000010539c:	80 ff ff 
ffff80000010539f:	ff d0                	call   *%rax
ffff8000001053a1:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    memmove(to->data, from->data, BSIZE);
ffff8000001053a5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001053a9:	48 8d 88 b0 00 00 00 	lea    0xb0(%rax),%rcx
ffff8000001053b0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001053b4:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff8000001053ba:	ba 00 02 00 00       	mov    $0x200,%edx
ffff8000001053bf:	48 89 ce             	mov    %rcx,%rsi
ffff8000001053c2:	48 89 c7             	mov    %rax,%rdi
ffff8000001053c5:	48 b8 4d 83 10 00 00 	movabs $0xffff80000010834d,%rax
ffff8000001053cc:	80 ff ff 
ffff8000001053cf:	ff d0                	call   *%rax
    bwrite(to);  // write the log
ffff8000001053d1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001053d5:	48 89 c7             	mov    %rax,%rdi
ffff8000001053d8:	48 b8 26 04 10 00 00 	movabs $0xffff800000100426,%rax
ffff8000001053df:	80 ff ff 
ffff8000001053e2:	ff d0                	call   *%rax
    brelse(from);
ffff8000001053e4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001053e8:	48 89 c7             	mov    %rax,%rdi
ffff8000001053eb:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff8000001053f2:	80 ff ff 
ffff8000001053f5:	ff d0                	call   *%rax
    brelse(to);
ffff8000001053f7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001053fb:	48 89 c7             	mov    %rax,%rdi
ffff8000001053fe:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff800000105405:	80 ff ff 
ffff800000105408:	ff d0                	call   *%rax
  for (tail = 0; tail < log.lh.n; tail++) {
ffff80000010540a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff80000010540e:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000105415:	80 ff ff 
ffff800000105418:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff80000010541b:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff80000010541e:	0f 8c 0e ff ff ff    	jl     ffff800000105332 <write_log+0x18>
  }
}
ffff800000105424:	90                   	nop
ffff800000105425:	90                   	nop
ffff800000105426:	c9                   	leave
ffff800000105427:	c3                   	ret

ffff800000105428 <commit>:

static void
commit()
{
ffff800000105428:	f3 0f 1e fa          	endbr64
ffff80000010542c:	55                   	push   %rbp
ffff80000010542d:	48 89 e5             	mov    %rsp,%rbp
  if (log.lh.n > 0) {
ffff800000105430:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000105437:	80 ff ff 
ffff80000010543a:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff80000010543d:	85 c0                	test   %eax,%eax
ffff80000010543f:	7e 41                	jle    ffff800000105482 <commit+0x5a>
    write_log();     // Write modified blocks from cache to log
ffff800000105441:	48 b8 1a 53 10 00 00 	movabs $0xffff80000010531a,%rax
ffff800000105448:	80 ff ff 
ffff80000010544b:	ff d0                	call   *%rax
    write_head();    // Write header to disk -- the real commit
ffff80000010544d:	48 b8 dd 4f 10 00 00 	movabs $0xffff800000104fdd,%rax
ffff800000105454:	80 ff ff 
ffff800000105457:	ff d0                	call   *%rax
    install_trans(); // Now install writes to home locations
ffff800000105459:	48 b8 17 4e 10 00 00 	movabs $0xffff800000104e17,%rax
ffff800000105460:	80 ff ff 
ffff800000105463:	ff d0                	call   *%rax
    log.lh.n = 0;
ffff800000105465:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff80000010546c:	80 ff ff 
ffff80000010546f:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%rax)
    write_head();    // Erase the transaction from the log
ffff800000105476:	48 b8 dd 4f 10 00 00 	movabs $0xffff800000104fdd,%rax
ffff80000010547d:	80 ff ff 
ffff800000105480:	ff d0                	call   *%rax
  }
}
ffff800000105482:	90                   	nop
ffff800000105483:	5d                   	pop    %rbp
ffff800000105484:	c3                   	ret

ffff800000105485 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
ffff800000105485:	f3 0f 1e fa          	endbr64
ffff800000105489:	55                   	push   %rbp
ffff80000010548a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010548d:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000105491:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
ffff800000105495:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff80000010549c:	80 ff ff 
ffff80000010549f:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff8000001054a2:	83 f8 1d             	cmp    $0x1d,%eax
ffff8000001054a5:	7f 21                	jg     ffff8000001054c8 <log_write+0x43>
ffff8000001054a7:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff8000001054ae:	80 ff ff 
ffff8000001054b1:	8b 50 7c             	mov    0x7c(%rax),%edx
ffff8000001054b4:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff8000001054bb:	80 ff ff 
ffff8000001054be:	8b 40 6c             	mov    0x6c(%rax),%eax
ffff8000001054c1:	83 e8 01             	sub    $0x1,%eax
ffff8000001054c4:	39 c2                	cmp    %eax,%edx
ffff8000001054c6:	7c 19                	jl     ffff8000001054e1 <log_write+0x5c>
    panic("too big a transaction");
ffff8000001054c8:	48 b8 c7 d1 10 00 00 	movabs $0xffff80000010d1c7,%rax
ffff8000001054cf:	80 ff ff 
ffff8000001054d2:	48 89 c7             	mov    %rax,%rdi
ffff8000001054d5:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff8000001054dc:	80 ff ff 
ffff8000001054df:	ff d0                	call   *%rax
  if (log.outstanding < 1)
ffff8000001054e1:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff8000001054e8:	80 ff ff 
ffff8000001054eb:	8b 40 70             	mov    0x70(%rax),%eax
ffff8000001054ee:	85 c0                	test   %eax,%eax
ffff8000001054f0:	7f 19                	jg     ffff80000010550b <log_write+0x86>
    panic("log_write outside of trans");
ffff8000001054f2:	48 b8 dd d1 10 00 00 	movabs $0xffff80000010d1dd,%rax
ffff8000001054f9:	80 ff ff 
ffff8000001054fc:	48 89 c7             	mov    %rax,%rdi
ffff8000001054ff:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000105506:	80 ff ff 
ffff800000105509:	ff d0                	call   *%rax

  acquire(&log.lock);
ffff80000010550b:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000105512:	80 ff ff 
ffff800000105515:	48 89 c7             	mov    %rax,%rdi
ffff800000105518:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff80000010551f:	80 ff ff 
ffff800000105522:	ff d0                	call   *%rax
  for (i = 0; i < log.lh.n; i++) {
ffff800000105524:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010552b:	eb 29                	jmp    ffff800000105556 <log_write+0xd1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
ffff80000010552d:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000105534:	80 ff ff 
ffff800000105537:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010553a:	48 63 d2             	movslq %edx,%rdx
ffff80000010553d:	48 83 c2 1c          	add    $0x1c,%rdx
ffff800000105541:	8b 44 90 10          	mov    0x10(%rax,%rdx,4),%eax
ffff800000105545:	89 c2                	mov    %eax,%edx
ffff800000105547:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010554b:	8b 40 08             	mov    0x8(%rax),%eax
ffff80000010554e:	39 c2                	cmp    %eax,%edx
ffff800000105550:	74 18                	je     ffff80000010556a <log_write+0xe5>
  for (i = 0; i < log.lh.n; i++) {
ffff800000105552:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000105556:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff80000010555d:	80 ff ff 
ffff800000105560:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000105563:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000105566:	7c c5                	jl     ffff80000010552d <log_write+0xa8>
ffff800000105568:	eb 01                	jmp    ffff80000010556b <log_write+0xe6>
      break;
ffff80000010556a:	90                   	nop
  }
  log.lh.block[i] = b->blockno;
ffff80000010556b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010556f:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000105572:	89 c1                	mov    %eax,%ecx
ffff800000105574:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff80000010557b:	80 ff ff 
ffff80000010557e:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000105581:	48 63 d2             	movslq %edx,%rdx
ffff800000105584:	48 83 c2 1c          	add    $0x1c,%rdx
ffff800000105588:	89 4c 90 10          	mov    %ecx,0x10(%rax,%rdx,4)
  if (i == log.lh.n)
ffff80000010558c:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff800000105593:	80 ff ff 
ffff800000105596:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000105599:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff80000010559c:	75 1d                	jne    ffff8000001055bb <log_write+0x136>
    log.lh.n++;
ffff80000010559e:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff8000001055a5:	80 ff ff 
ffff8000001055a8:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff8000001055ab:	8d 50 01             	lea    0x1(%rax),%edx
ffff8000001055ae:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff8000001055b5:	80 ff ff 
ffff8000001055b8:	89 50 7c             	mov    %edx,0x7c(%rax)
  b->flags |= B_DIRTY; // prevent eviction
ffff8000001055bb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001055bf:	8b 00                	mov    (%rax),%eax
ffff8000001055c1:	83 c8 04             	or     $0x4,%eax
ffff8000001055c4:	89 c2                	mov    %eax,%edx
ffff8000001055c6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001055ca:	89 10                	mov    %edx,(%rax)
  release(&log.lock);
ffff8000001055cc:	48 b8 00 85 11 00 00 	movabs $0xffff800000118500,%rax
ffff8000001055d3:	80 ff ff 
ffff8000001055d6:	48 89 c7             	mov    %rax,%rdi
ffff8000001055d9:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff8000001055e0:	80 ff ff 
ffff8000001055e3:	ff d0                	call   *%rax
}
ffff8000001055e5:	90                   	nop
ffff8000001055e6:	c9                   	leave
ffff8000001055e7:	c3                   	ret

ffff8000001055e8 <v2p>:
#include "x86.h"

static void startothers(void);
static void mpmain(void)  __attribute__((noreturn));
extern pde_t *kpgdir;
extern char end[]; // first address after kernel loaded from ELF file
ffff8000001055e8:	f3 0f 1e fa          	endbr64
ffff8000001055ec:	55                   	push   %rbp
ffff8000001055ed:	48 89 e5             	mov    %rsp,%rbp
ffff8000001055f0:	48 83 ec 08          	sub    $0x8,%rsp
ffff8000001055f4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)

ffff8000001055f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001055fc:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff800000105603:	80 00 00 
ffff800000105606:	48 01 d0             	add    %rdx,%rax
// Bootstrap processor starts running C code here.
ffff800000105609:	c9                   	leave
ffff80000010560a:	c3                   	ret

ffff80000010560b <xchg>:
  asm volatile("hlt");
}

static inline uint
xchg(volatile uint *addr, addr_t newval)
{
ffff80000010560b:	f3 0f 1e fa          	endbr64
ffff80000010560f:	55                   	push   %rbp
ffff800000105610:	48 89 e5             	mov    %rsp,%rbp
ffff800000105613:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000105617:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010561b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
ffff80000010561f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000105623:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105627:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffff80000010562b:	f0 87 02             	lock xchg %eax,(%rdx)
ffff80000010562e:	89 45 fc             	mov    %eax,-0x4(%rbp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
ffff800000105631:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff800000105634:	c9                   	leave
ffff800000105635:	c3                   	ret

ffff800000105636 <main>:
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
ffff800000105636:	f3 0f 1e fa          	endbr64
ffff80000010563a:	55                   	push   %rbp
ffff80000010563b:	48 89 e5             	mov    %rsp,%rbp
  uartearlyinit();
ffff80000010563e:	48 b8 d4 ac 10 00 00 	movabs $0xffff80000010acd4,%rax
ffff800000105645:	80 ff ff 
ffff800000105648:	ff d0                	call   *%rax
  kinit1(end, P2V(PHYSTOP)); // phys page allocator
ffff80000010564a:	48 b8 00 00 00 0e 00 	movabs $0xffff80000e000000,%rax
ffff800000105651:	80 ff ff 
ffff800000105654:	48 89 c6             	mov    %rax,%rsi
ffff800000105657:	48 b8 00 00 12 00 00 	movabs $0xffff800000120000,%rax
ffff80000010565e:	80 ff ff 
ffff800000105661:	48 89 c7             	mov    %rax,%rdi
ffff800000105664:	48 b8 86 41 10 00 00 	movabs $0xffff800000104186,%rax
ffff80000010566b:	80 ff ff 
ffff80000010566e:	ff d0                	call   *%rax
  kvmalloc();      // kernel page table
ffff800000105670:	48 b8 8c bf 10 00 00 	movabs $0xffff80000010bf8c,%rax
ffff800000105677:	80 ff ff 
ffff80000010567a:	ff d0                	call   *%rax
  mpinit();        // detect other processors
ffff80000010567c:	48 b8 63 5c 10 00 00 	movabs $0xffff800000105c63,%rax
ffff800000105683:	80 ff ff 
ffff800000105686:	ff d0                	call   *%rax
  lapicinit();     // interrupt controller
ffff800000105688:	48 b8 f8 46 10 00 00 	movabs $0xffff8000001046f8,%rax
ffff80000010568f:	80 ff ff 
ffff800000105692:	ff d0                	call   *%rax
  tvinit();        // trap vectors
ffff800000105694:	48 b8 32 a8 10 00 00 	movabs $0xffff80000010a832,%rax
ffff80000010569b:	80 ff ff 
ffff80000010569e:	ff d0                	call   *%rax
  seginit();       // segment descriptors
ffff8000001056a0:	48 b8 c9 ba 10 00 00 	movabs $0xffff80000010bac9,%rax
ffff8000001056a7:	80 ff ff 
ffff8000001056aa:	ff d0                	call   *%rax
  cprintf("\ncpu%d: starting Spring 2026 xv6\n\n", cpunum());
ffff8000001056ac:	48 b8 8a 48 10 00 00 	movabs $0xffff80000010488a,%rax
ffff8000001056b3:	80 ff ff 
ffff8000001056b6:	ff d0                	call   *%rax
ffff8000001056b8:	89 c6                	mov    %eax,%esi
ffff8000001056ba:	48 b8 f8 d1 10 00 00 	movabs $0xffff80000010d1f8,%rax
ffff8000001056c1:	80 ff ff 
ffff8000001056c4:	48 89 c7             	mov    %rax,%rdi
ffff8000001056c7:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001056cc:	48 ba 38 08 10 00 00 	movabs $0xffff800000100838,%rdx
ffff8000001056d3:	80 ff ff 
ffff8000001056d6:	ff d2                	call   *%rdx
  ioapicinit();    // another interrupt controller
ffff8000001056d8:	48 b8 49 40 10 00 00 	movabs $0xffff800000104049,%rax
ffff8000001056df:	80 ff ff 
ffff8000001056e2:	ff d0                	call   *%rax
  consoleinit();   // console hardware
ffff8000001056e4:	48 b8 f1 14 10 00 00 	movabs $0xffff8000001014f1,%rax
ffff8000001056eb:	80 ff ff 
ffff8000001056ee:	ff d0                	call   *%rax
  uartinit();      // serial port
ffff8000001056f0:	48 b8 dc ad 10 00 00 	movabs $0xffff80000010addc,%rax
ffff8000001056f7:	80 ff ff 
ffff8000001056fa:	ff d0                	call   *%rax
  pinit();         // process table
ffff8000001056fc:	48 b8 c3 63 10 00 00 	movabs $0xffff8000001063c3,%rax
ffff800000105703:	80 ff ff 
ffff800000105706:	ff d0                	call   *%rax
  binit();         // buffer cache
ffff800000105708:	48 b8 1b 01 10 00 00 	movabs $0xffff80000010011b,%rax
ffff80000010570f:	80 ff ff 
ffff800000105712:	ff d0                	call   *%rax
  fileinit();      // file table
ffff800000105714:	48 b8 91 1b 10 00 00 	movabs $0xffff800000101b91,%rax
ffff80000010571b:	80 ff ff 
ffff80000010571e:	ff d0                	call   *%rax
  ideinit();       // disk
ffff800000105720:	48 b8 82 3a 10 00 00 	movabs $0xffff800000103a82,%rax
ffff800000105727:	80 ff ff 
ffff80000010572a:	ff d0                	call   *%rax
  startothers();   // start other processors
ffff80000010572c:	48 b8 14 58 10 00 00 	movabs $0xffff800000105814,%rax
ffff800000105733:	80 ff ff 
ffff800000105736:	ff d0                	call   *%rax
  kinit2();
ffff800000105738:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010573d:	48 ba 00 42 10 00 00 	movabs $0xffff800000104200,%rdx
ffff800000105744:	80 ff ff 
ffff800000105747:	ff d2                	call   *%rdx
  userinit();      // first user process
ffff800000105749:	48 b8 a7 65 10 00 00 	movabs $0xffff8000001065a7,%rax
ffff800000105750:	80 ff ff 
ffff800000105753:	ff d0                	call   *%rax
  mpmain();        // finish this processor's setup
ffff800000105755:	48 b8 99 57 10 00 00 	movabs $0xffff800000105799,%rax
ffff80000010575c:	80 ff ff 
ffff80000010575f:	ff d0                	call   *%rax

ffff800000105761 <mpenter>:
}

// Other CPUs jump here from entryother.S.
void
mpenter(void)
{
ffff800000105761:	f3 0f 1e fa          	endbr64
ffff800000105765:	55                   	push   %rbp
ffff800000105766:	48 89 e5             	mov    %rsp,%rbp
  switchkvm();
ffff800000105769:	48 b8 99 c3 10 00 00 	movabs $0xffff80000010c399,%rax
ffff800000105770:	80 ff ff 
ffff800000105773:	ff d0                	call   *%rax
  seginit();
ffff800000105775:	48 b8 c9 ba 10 00 00 	movabs $0xffff80000010bac9,%rax
ffff80000010577c:	80 ff ff 
ffff80000010577f:	ff d0                	call   *%rax
  lapicinit();
ffff800000105781:	48 b8 f8 46 10 00 00 	movabs $0xffff8000001046f8,%rax
ffff800000105788:	80 ff ff 
ffff80000010578b:	ff d0                	call   *%rax
  mpmain();
ffff80000010578d:	48 b8 99 57 10 00 00 	movabs $0xffff800000105799,%rax
ffff800000105794:	80 ff ff 
ffff800000105797:	ff d0                	call   *%rax

ffff800000105799 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
ffff800000105799:	f3 0f 1e fa          	endbr64
ffff80000010579d:	55                   	push   %rbp
ffff80000010579e:	48 89 e5             	mov    %rsp,%rbp
  cprintf("cpu%d: starting\n", cpunum());
ffff8000001057a1:	48 b8 8a 48 10 00 00 	movabs $0xffff80000010488a,%rax
ffff8000001057a8:	80 ff ff 
ffff8000001057ab:	ff d0                	call   *%rax
ffff8000001057ad:	89 c6                	mov    %eax,%esi
ffff8000001057af:	48 b8 1b d2 10 00 00 	movabs $0xffff80000010d21b,%rax
ffff8000001057b6:	80 ff ff 
ffff8000001057b9:	48 89 c7             	mov    %rax,%rdi
ffff8000001057bc:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001057c1:	48 ba 38 08 10 00 00 	movabs $0xffff800000100838,%rdx
ffff8000001057c8:	80 ff ff 
ffff8000001057cb:	ff d2                	call   *%rdx
  idtinit();       // load idt register
ffff8000001057cd:	48 b8 06 a8 10 00 00 	movabs $0xffff80000010a806,%rax
ffff8000001057d4:	80 ff ff 
ffff8000001057d7:	ff d0                	call   *%rax
  syscallinit();   // syscall set up
ffff8000001057d9:	48 b8 4e ba 10 00 00 	movabs $0xffff80000010ba4e,%rax
ffff8000001057e0:	80 ff ff 
ffff8000001057e3:	ff d0                	call   *%rax
  xchg(&cpu->started, 1); // tell startothers() we're up
ffff8000001057e5:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff8000001057ec:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001057f0:	48 83 c0 10          	add    $0x10,%rax
ffff8000001057f4:	be 01 00 00 00       	mov    $0x1,%esi
ffff8000001057f9:	48 89 c7             	mov    %rax,%rdi
ffff8000001057fc:	48 b8 0b 56 10 00 00 	movabs $0xffff80000010560b,%rax
ffff800000105803:	80 ff ff 
ffff800000105806:	ff d0                	call   *%rax
  scheduler();     // start running processes
ffff800000105808:	48 b8 74 6f 10 00 00 	movabs $0xffff800000106f74,%rax
ffff80000010580f:	80 ff ff 
ffff800000105812:	ff d0                	call   *%rax

ffff800000105814 <startothers>:
void entry32mp(void);

// Start the non-boot (AP) processors.
static void
startothers(void)
{
ffff800000105814:	f3 0f 1e fa          	endbr64
ffff800000105818:	55                   	push   %rbp
ffff800000105819:	48 89 e5             	mov    %rsp,%rbp
ffff80000010581c:	48 83 ec 20          	sub    $0x20,%rsp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
ffff800000105820:	48 b8 00 70 00 00 00 	movabs $0xffff800000007000,%rax
ffff800000105827:	80 ff ff 
ffff80000010582a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  memmove(code, _binary_entryother_start,
ffff80000010582e:	48 b8 72 00 00 00 00 	movabs $0x72,%rax
ffff800000105835:	00 00 00 
ffff800000105838:	89 c2                	mov    %eax,%edx
ffff80000010583a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010583e:	48 b9 ac ee 10 00 00 	movabs $0xffff80000010eeac,%rcx
ffff800000105845:	80 ff ff 
ffff800000105848:	48 89 ce             	mov    %rcx,%rsi
ffff80000010584b:	48 89 c7             	mov    %rax,%rdi
ffff80000010584e:	48 b8 4d 83 10 00 00 	movabs $0xffff80000010834d,%rax
ffff800000105855:	80 ff ff 
ffff800000105858:	ff d0                	call   *%rax
          (addr_t)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
ffff80000010585a:	48 b8 00 86 11 00 00 	movabs $0xffff800000118600,%rax
ffff800000105861:	80 ff ff 
ffff800000105864:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000105868:	e9 c6 00 00 00       	jmp    ffff800000105933 <startothers+0x11f>
    if(c == cpus+cpunum())  // We've started already.
ffff80000010586d:	48 b8 8a 48 10 00 00 	movabs $0xffff80000010488a,%rax
ffff800000105874:	80 ff ff 
ffff800000105877:	ff d0                	call   *%rax
ffff800000105879:	48 63 d0             	movslq %eax,%rdx
ffff80000010587c:	48 89 d0             	mov    %rdx,%rax
ffff80000010587f:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000105883:	48 01 d0             	add    %rdx,%rax
ffff800000105886:	48 c1 e0 03          	shl    $0x3,%rax
ffff80000010588a:	48 89 c2             	mov    %rax,%rdx
ffff80000010588d:	48 b8 00 86 11 00 00 	movabs $0xffff800000118600,%rax
ffff800000105894:	80 ff ff 
ffff800000105897:	48 01 d0             	add    %rdx,%rax
ffff80000010589a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff80000010589e:	0f 84 89 00 00 00    	je     ffff80000010592d <startothers+0x119>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
ffff8000001058a4:	48 b8 78 43 10 00 00 	movabs $0xffff800000104378,%rax
ffff8000001058ab:	80 ff ff 
ffff8000001058ae:	ff d0                	call   *%rax
ffff8000001058b0:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    *(uint32*)(code-4) = 0x8000; // enough stack to get us to entry64mp
ffff8000001058b4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001058b8:	48 83 e8 04          	sub    $0x4,%rax
ffff8000001058bc:	c7 00 00 80 00 00    	movl   $0x8000,(%rax)
    *(uint32*)(code-8) = v2p(entry32mp);
ffff8000001058c2:	48 b8 49 00 10 00 00 	movabs $0xffff800000100049,%rax
ffff8000001058c9:	80 ff ff 
ffff8000001058cc:	48 89 c7             	mov    %rax,%rdi
ffff8000001058cf:	48 b8 e8 55 10 00 00 	movabs $0xffff8000001055e8,%rax
ffff8000001058d6:	80 ff ff 
ffff8000001058d9:	ff d0                	call   *%rax
ffff8000001058db:	48 89 c2             	mov    %rax,%rdx
ffff8000001058de:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001058e2:	48 83 e8 08          	sub    $0x8,%rax
ffff8000001058e6:	89 10                	mov    %edx,(%rax)
    *(uint64*)(code-16) = (uint64) (stack + KSTACKSIZE);
ffff8000001058e8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001058ec:	48 8d 90 00 10 00 00 	lea    0x1000(%rax),%rdx
ffff8000001058f3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001058f7:	48 83 e8 10          	sub    $0x10,%rax
ffff8000001058fb:	48 89 10             	mov    %rdx,(%rax)

    lapicstartap(c->apicid, V2P(code));
ffff8000001058fe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105902:	89 c2                	mov    %eax,%edx
ffff800000105904:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105908:	0f b6 40 01          	movzbl 0x1(%rax),%eax
ffff80000010590c:	0f b6 c0             	movzbl %al,%eax
ffff80000010590f:	89 d6                	mov    %edx,%esi
ffff800000105911:	89 c7                	mov    %eax,%edi
ffff800000105913:	48 b8 d8 49 10 00 00 	movabs $0xffff8000001049d8,%rax
ffff80000010591a:	80 ff ff 
ffff80000010591d:	ff d0                	call   *%rax

    // wait for cpu to finish mpmain()
    while(c->started == 0)
ffff80000010591f:	90                   	nop
ffff800000105920:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105924:	8b 40 10             	mov    0x10(%rax),%eax
ffff800000105927:	85 c0                	test   %eax,%eax
ffff800000105929:	74 f5                	je     ffff800000105920 <startothers+0x10c>
ffff80000010592b:	eb 01                	jmp    ffff80000010592e <startothers+0x11a>
      continue;
ffff80000010592d:	90                   	nop
  for(c = cpus; c < cpus+ncpu; c++){
ffff80000010592e:	48 83 45 f8 28       	addq   $0x28,-0x8(%rbp)
ffff800000105933:	48 b8 40 87 11 00 00 	movabs $0xffff800000118740,%rax
ffff80000010593a:	80 ff ff 
ffff80000010593d:	8b 00                	mov    (%rax),%eax
ffff80000010593f:	48 63 d0             	movslq %eax,%rdx
ffff800000105942:	48 89 d0             	mov    %rdx,%rax
ffff800000105945:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000105949:	48 01 d0             	add    %rdx,%rax
ffff80000010594c:	48 c1 e0 03          	shl    $0x3,%rax
ffff800000105950:	48 89 c2             	mov    %rax,%rdx
ffff800000105953:	48 b8 00 86 11 00 00 	movabs $0xffff800000118600,%rax
ffff80000010595a:	80 ff ff 
ffff80000010595d:	48 01 d0             	add    %rdx,%rax
ffff800000105960:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000105964:	0f 82 03 ff ff ff    	jb     ffff80000010586d <startothers+0x59>
      ;
  }
}
ffff80000010596a:	90                   	nop
ffff80000010596b:	90                   	nop
ffff80000010596c:	c9                   	leave
ffff80000010596d:	c3                   	ret

ffff80000010596e <inb>:
// Multiprocessor support
// Search memory for MP description structures.
// http://developer.intel.com/design/pentium/datashts/24201606.pdf

#include "types.h"
ffff80000010596e:	f3 0f 1e fa          	endbr64
ffff800000105972:	55                   	push   %rbp
ffff800000105973:	48 89 e5             	mov    %rsp,%rbp
ffff800000105976:	48 83 ec 18          	sub    $0x18,%rsp
ffff80000010597a:	89 f8                	mov    %edi,%eax
ffff80000010597c:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
#include "defs.h"
#include "param.h"
#include "memlayout.h"
ffff800000105980:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff800000105984:	89 c2                	mov    %eax,%edx
ffff800000105986:	ec                   	in     (%dx),%al
ffff800000105987:	88 45 ff             	mov    %al,-0x1(%rbp)
#include "mp.h"
ffff80000010598a:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
#include "x86.h"
ffff80000010598e:	c9                   	leave
ffff80000010598f:	c3                   	ret

ffff800000105990 <outb>:
static uchar
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
ffff800000105990:	f3 0f 1e fa          	endbr64
ffff800000105994:	55                   	push   %rbp
ffff800000105995:	48 89 e5             	mov    %rsp,%rbp
ffff800000105998:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010599c:	89 fa                	mov    %edi,%edx
ffff80000010599e:	89 f0                	mov    %esi,%eax
ffff8000001059a0:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffff8000001059a4:	88 45 f8             	mov    %al,-0x8(%rbp)
  for(i=0; i<len; i++)
ffff8000001059a7:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffff8000001059ab:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffff8000001059af:	ee                   	out    %al,(%dx)
    sum += addr[i];
ffff8000001059b0:	90                   	nop
ffff8000001059b1:	c9                   	leave
ffff8000001059b2:	c3                   	ret

ffff8000001059b3 <sum>:
{
ffff8000001059b3:	f3 0f 1e fa          	endbr64
ffff8000001059b7:	55                   	push   %rbp
ffff8000001059b8:	48 89 e5             	mov    %rsp,%rbp
ffff8000001059bb:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001059bf:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff8000001059c3:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  sum = 0;
ffff8000001059c6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  for(i=0; i<len; i++)
ffff8000001059cd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001059d4:	eb 1a                	jmp    ffff8000001059f0 <sum+0x3d>
    sum += addr[i];
ffff8000001059d6:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001059d9:	48 63 d0             	movslq %eax,%rdx
ffff8000001059dc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001059e0:	48 01 d0             	add    %rdx,%rax
ffff8000001059e3:	0f b6 00             	movzbl (%rax),%eax
ffff8000001059e6:	0f b6 c0             	movzbl %al,%eax
ffff8000001059e9:	01 45 f8             	add    %eax,-0x8(%rbp)
  for(i=0; i<len; i++)
ffff8000001059ec:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001059f0:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001059f3:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
ffff8000001059f6:	7c de                	jl     ffff8000001059d6 <sum+0x23>
  return sum;
ffff8000001059f8:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
ffff8000001059fb:	c9                   	leave
ffff8000001059fc:	c3                   	ret

ffff8000001059fd <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(addr_t a, int len)
{
ffff8000001059fd:	f3 0f 1e fa          	endbr64
ffff800000105a01:	55                   	push   %rbp
ffff800000105a02:	48 89 e5             	mov    %rsp,%rbp
ffff800000105a05:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000105a09:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000105a0d:	89 75 d4             	mov    %esi,-0x2c(%rbp)
  uchar *e, *p, *addr;
  addr = P2V(a);
ffff800000105a10:	48 ba 00 00 00 00 00 	movabs $0xffff800000000000,%rdx
ffff800000105a17:	80 ff ff 
ffff800000105a1a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000105a1e:	48 01 d0             	add    %rdx,%rax
ffff800000105a21:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  e = addr+len;
ffff800000105a25:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff800000105a28:	48 63 d0             	movslq %eax,%rdx
ffff800000105a2b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105a2f:	48 01 d0             	add    %rdx,%rax
ffff800000105a32:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  for(p = addr; p < e; p += sizeof(struct mp))
ffff800000105a36:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105a3a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000105a3e:	eb 50                	jmp    ffff800000105a90 <mpsearch1+0x93>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
ffff800000105a40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105a44:	ba 04 00 00 00       	mov    $0x4,%edx
ffff800000105a49:	48 b9 30 d2 10 00 00 	movabs $0xffff80000010d230,%rcx
ffff800000105a50:	80 ff ff 
ffff800000105a53:	48 89 ce             	mov    %rcx,%rsi
ffff800000105a56:	48 89 c7             	mov    %rax,%rdi
ffff800000105a59:	48 b8 da 82 10 00 00 	movabs $0xffff8000001082da,%rax
ffff800000105a60:	80 ff ff 
ffff800000105a63:	ff d0                	call   *%rax
ffff800000105a65:	85 c0                	test   %eax,%eax
ffff800000105a67:	75 22                	jne    ffff800000105a8b <mpsearch1+0x8e>
ffff800000105a69:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105a6d:	be 10 00 00 00       	mov    $0x10,%esi
ffff800000105a72:	48 89 c7             	mov    %rax,%rdi
ffff800000105a75:	48 b8 b3 59 10 00 00 	movabs $0xffff8000001059b3,%rax
ffff800000105a7c:	80 ff ff 
ffff800000105a7f:	ff d0                	call   *%rax
ffff800000105a81:	84 c0                	test   %al,%al
ffff800000105a83:	75 06                	jne    ffff800000105a8b <mpsearch1+0x8e>
      return (struct mp*)p;
ffff800000105a85:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105a89:	eb 14                	jmp    ffff800000105a9f <mpsearch1+0xa2>
  for(p = addr; p < e; p += sizeof(struct mp))
ffff800000105a8b:	48 83 45 f8 10       	addq   $0x10,-0x8(%rbp)
ffff800000105a90:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105a94:	48 3b 45 e8          	cmp    -0x18(%rbp),%rax
ffff800000105a98:	72 a6                	jb     ffff800000105a40 <mpsearch1+0x43>
  return 0;
ffff800000105a9a:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000105a9f:	c9                   	leave
ffff800000105aa0:	c3                   	ret

ffff800000105aa1 <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
ffff800000105aa1:	f3 0f 1e fa          	endbr64
ffff800000105aa5:	55                   	push   %rbp
ffff800000105aa6:	48 89 e5             	mov    %rsp,%rbp
ffff800000105aa9:	48 83 ec 20          	sub    $0x20,%rsp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
ffff800000105aad:	48 b8 00 04 00 00 00 	movabs $0xffff800000000400,%rax
ffff800000105ab4:	80 ff ff 
ffff800000105ab7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
ffff800000105abb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105abf:	48 83 c0 0f          	add    $0xf,%rax
ffff800000105ac3:	0f b6 00             	movzbl (%rax),%eax
ffff800000105ac6:	0f b6 c0             	movzbl %al,%eax
ffff800000105ac9:	c1 e0 08             	shl    $0x8,%eax
ffff800000105acc:	89 c2                	mov    %eax,%edx
ffff800000105ace:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105ad2:	48 83 c0 0e          	add    $0xe,%rax
ffff800000105ad6:	0f b6 00             	movzbl (%rax),%eax
ffff800000105ad9:	0f b6 c0             	movzbl %al,%eax
ffff800000105adc:	09 d0                	or     %edx,%eax
ffff800000105ade:	c1 e0 04             	shl    $0x4,%eax
ffff800000105ae1:	89 45 f4             	mov    %eax,-0xc(%rbp)
ffff800000105ae4:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
ffff800000105ae8:	74 28                	je     ffff800000105b12 <mpsearch+0x71>
    if((mp = mpsearch1(p, 1024)))
ffff800000105aea:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000105aed:	be 00 04 00 00       	mov    $0x400,%esi
ffff800000105af2:	48 89 c7             	mov    %rax,%rdi
ffff800000105af5:	48 b8 fd 59 10 00 00 	movabs $0xffff8000001059fd,%rax
ffff800000105afc:	80 ff ff 
ffff800000105aff:	ff d0                	call   *%rax
ffff800000105b01:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000105b05:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff800000105b0a:	74 5e                	je     ffff800000105b6a <mpsearch+0xc9>
      return mp;
ffff800000105b0c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105b10:	eb 6e                	jmp    ffff800000105b80 <mpsearch+0xdf>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
ffff800000105b12:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105b16:	48 83 c0 14          	add    $0x14,%rax
ffff800000105b1a:	0f b6 00             	movzbl (%rax),%eax
ffff800000105b1d:	0f b6 c0             	movzbl %al,%eax
ffff800000105b20:	c1 e0 08             	shl    $0x8,%eax
ffff800000105b23:	89 c2                	mov    %eax,%edx
ffff800000105b25:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105b29:	48 83 c0 13          	add    $0x13,%rax
ffff800000105b2d:	0f b6 00             	movzbl (%rax),%eax
ffff800000105b30:	0f b6 c0             	movzbl %al,%eax
ffff800000105b33:	09 d0                	or     %edx,%eax
ffff800000105b35:	c1 e0 0a             	shl    $0xa,%eax
ffff800000105b38:	89 45 f4             	mov    %eax,-0xc(%rbp)
    if((mp = mpsearch1(p-1024, 1024)))
ffff800000105b3b:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000105b3e:	2d 00 04 00 00       	sub    $0x400,%eax
ffff800000105b43:	89 c0                	mov    %eax,%eax
ffff800000105b45:	be 00 04 00 00       	mov    $0x400,%esi
ffff800000105b4a:	48 89 c7             	mov    %rax,%rdi
ffff800000105b4d:	48 b8 fd 59 10 00 00 	movabs $0xffff8000001059fd,%rax
ffff800000105b54:	80 ff ff 
ffff800000105b57:	ff d0                	call   *%rax
ffff800000105b59:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000105b5d:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff800000105b62:	74 06                	je     ffff800000105b6a <mpsearch+0xc9>
      return mp;
ffff800000105b64:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105b68:	eb 16                	jmp    ffff800000105b80 <mpsearch+0xdf>
  }
  return mpsearch1(0xF0000, 0x10000);
ffff800000105b6a:	be 00 00 01 00       	mov    $0x10000,%esi
ffff800000105b6f:	bf 00 00 0f 00       	mov    $0xf0000,%edi
ffff800000105b74:	48 b8 fd 59 10 00 00 	movabs $0xffff8000001059fd,%rax
ffff800000105b7b:	80 ff ff 
ffff800000105b7e:	ff d0                	call   *%rax
}
ffff800000105b80:	c9                   	leave
ffff800000105b81:	c3                   	ret

ffff800000105b82 <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
ffff800000105b82:	f3 0f 1e fa          	endbr64
ffff800000105b86:	55                   	push   %rbp
ffff800000105b87:	48 89 e5             	mov    %rsp,%rbp
ffff800000105b8a:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000105b8e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
ffff800000105b92:	48 b8 a1 5a 10 00 00 	movabs $0xffff800000105aa1,%rax
ffff800000105b99:	80 ff ff 
ffff800000105b9c:	ff d0                	call   *%rax
ffff800000105b9e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000105ba2:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000105ba7:	74 0b                	je     ffff800000105bb4 <mpconfig+0x32>
ffff800000105ba9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105bad:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000105bb0:	85 c0                	test   %eax,%eax
ffff800000105bb2:	75 0a                	jne    ffff800000105bbe <mpconfig+0x3c>
    return 0;
ffff800000105bb4:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105bb9:	e9 a3 00 00 00       	jmp    ffff800000105c61 <mpconfig+0xdf>
  conf = (struct mpconf*) P2V((addr_t) mp->physaddr);
ffff800000105bbe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105bc2:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000105bc5:	89 c2                	mov    %eax,%edx
ffff800000105bc7:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff800000105bce:	80 ff ff 
ffff800000105bd1:	48 01 d0             	add    %rdx,%rax
ffff800000105bd4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  if(memcmp(conf, "PCMP", 4) != 0)
ffff800000105bd8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105bdc:	ba 04 00 00 00       	mov    $0x4,%edx
ffff800000105be1:	48 b9 35 d2 10 00 00 	movabs $0xffff80000010d235,%rcx
ffff800000105be8:	80 ff ff 
ffff800000105beb:	48 89 ce             	mov    %rcx,%rsi
ffff800000105bee:	48 89 c7             	mov    %rax,%rdi
ffff800000105bf1:	48 b8 da 82 10 00 00 	movabs $0xffff8000001082da,%rax
ffff800000105bf8:	80 ff ff 
ffff800000105bfb:	ff d0                	call   *%rax
ffff800000105bfd:	85 c0                	test   %eax,%eax
ffff800000105bff:	74 07                	je     ffff800000105c08 <mpconfig+0x86>
    return 0;
ffff800000105c01:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105c06:	eb 59                	jmp    ffff800000105c61 <mpconfig+0xdf>
  if(conf->version != 1 && conf->version != 4)
ffff800000105c08:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105c0c:	0f b6 40 06          	movzbl 0x6(%rax),%eax
ffff800000105c10:	3c 01                	cmp    $0x1,%al
ffff800000105c12:	74 13                	je     ffff800000105c27 <mpconfig+0xa5>
ffff800000105c14:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105c18:	0f b6 40 06          	movzbl 0x6(%rax),%eax
ffff800000105c1c:	3c 04                	cmp    $0x4,%al
ffff800000105c1e:	74 07                	je     ffff800000105c27 <mpconfig+0xa5>
    return 0;
ffff800000105c20:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105c25:	eb 3a                	jmp    ffff800000105c61 <mpconfig+0xdf>
  if(sum((uchar*)conf, conf->length) != 0)
ffff800000105c27:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105c2b:	0f b7 40 04          	movzwl 0x4(%rax),%eax
ffff800000105c2f:	0f b7 d0             	movzwl %ax,%edx
ffff800000105c32:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105c36:	89 d6                	mov    %edx,%esi
ffff800000105c38:	48 89 c7             	mov    %rax,%rdi
ffff800000105c3b:	48 b8 b3 59 10 00 00 	movabs $0xffff8000001059b3,%rax
ffff800000105c42:	80 ff ff 
ffff800000105c45:	ff d0                	call   *%rax
ffff800000105c47:	84 c0                	test   %al,%al
ffff800000105c49:	74 07                	je     ffff800000105c52 <mpconfig+0xd0>
    return 0;
ffff800000105c4b:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105c50:	eb 0f                	jmp    ffff800000105c61 <mpconfig+0xdf>
  *pmp = mp;
ffff800000105c52:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105c56:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000105c5a:	48 89 10             	mov    %rdx,(%rax)
  return conf;
ffff800000105c5d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
}
ffff800000105c61:	c9                   	leave
ffff800000105c62:	c3                   	ret

ffff800000105c63 <mpinit>:

void
mpinit(void)
{
ffff800000105c63:	f3 0f 1e fa          	endbr64
ffff800000105c67:	55                   	push   %rbp
ffff800000105c68:	48 89 e5             	mov    %rsp,%rbp
ffff800000105c6b:	48 83 ec 30          	sub    $0x30,%rsp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0) {
ffff800000105c6f:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffff800000105c73:	48 89 c7             	mov    %rax,%rdi
ffff800000105c76:	48 b8 82 5b 10 00 00 	movabs $0xffff800000105b82,%rax
ffff800000105c7d:	80 ff ff 
ffff800000105c80:	ff d0                	call   *%rax
ffff800000105c82:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000105c86:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000105c8b:	75 23                	jne    ffff800000105cb0 <mpinit+0x4d>
    cprintf("No other CPUs found.\n");
ffff800000105c8d:	48 b8 3a d2 10 00 00 	movabs $0xffff80000010d23a,%rax
ffff800000105c94:	80 ff ff 
ffff800000105c97:	48 89 c7             	mov    %rax,%rdi
ffff800000105c9a:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105c9f:	48 ba 38 08 10 00 00 	movabs $0xffff800000100838,%rdx
ffff800000105ca6:	80 ff ff 
ffff800000105ca9:	ff d2                	call   *%rdx
ffff800000105cab:	e9 c9 01 00 00       	jmp    ffff800000105e79 <mpinit+0x216>
    return;
  }
  lapic = P2V((addr_t)conf->lapicaddr_p);
ffff800000105cb0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105cb4:	8b 40 24             	mov    0x24(%rax),%eax
ffff800000105cb7:	89 c2                	mov    %eax,%edx
ffff800000105cb9:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff800000105cc0:	80 ff ff 
ffff800000105cc3:	48 01 d0             	add    %rdx,%rax
ffff800000105cc6:	48 89 c2             	mov    %rax,%rdx
ffff800000105cc9:	48 b8 e0 84 11 00 00 	movabs $0xffff8000001184e0,%rax
ffff800000105cd0:	80 ff ff 
ffff800000105cd3:	48 89 10             	mov    %rdx,(%rax)
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
ffff800000105cd6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105cda:	48 83 c0 2c          	add    $0x2c,%rax
ffff800000105cde:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000105ce2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105ce6:	0f b7 40 04          	movzwl 0x4(%rax),%eax
ffff800000105cea:	0f b7 d0             	movzwl %ax,%edx
ffff800000105ced:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105cf1:	48 01 d0             	add    %rdx,%rax
ffff800000105cf4:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000105cf8:	e9 f6 00 00 00       	jmp    ffff800000105df3 <mpinit+0x190>
    switch(*p){
ffff800000105cfd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105d01:	0f b6 00             	movzbl (%rax),%eax
ffff800000105d04:	0f b6 c0             	movzbl %al,%eax
ffff800000105d07:	83 f8 04             	cmp    $0x4,%eax
ffff800000105d0a:	0f 8f ca 00 00 00    	jg     ffff800000105dda <mpinit+0x177>
ffff800000105d10:	83 f8 03             	cmp    $0x3,%eax
ffff800000105d13:	0f 8d ba 00 00 00    	jge    ffff800000105dd3 <mpinit+0x170>
ffff800000105d19:	83 f8 02             	cmp    $0x2,%eax
ffff800000105d1c:	0f 84 8e 00 00 00    	je     ffff800000105db0 <mpinit+0x14d>
ffff800000105d22:	83 f8 02             	cmp    $0x2,%eax
ffff800000105d25:	0f 8f af 00 00 00    	jg     ffff800000105dda <mpinit+0x177>
ffff800000105d2b:	85 c0                	test   %eax,%eax
ffff800000105d2d:	74 0e                	je     ffff800000105d3d <mpinit+0xda>
ffff800000105d2f:	83 f8 01             	cmp    $0x1,%eax
ffff800000105d32:	0f 84 9b 00 00 00    	je     ffff800000105dd3 <mpinit+0x170>
ffff800000105d38:	e9 9d 00 00 00       	jmp    ffff800000105dda <mpinit+0x177>
    case MPPROC:
      proc = (struct mpproc*)p;
ffff800000105d3d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105d41:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
      if(ncpu < NCPU) {
ffff800000105d45:	48 b8 40 87 11 00 00 	movabs $0xffff800000118740,%rax
ffff800000105d4c:	80 ff ff 
ffff800000105d4f:	8b 00                	mov    (%rax),%eax
ffff800000105d51:	83 f8 07             	cmp    $0x7,%eax
ffff800000105d54:	7f 53                	jg     ffff800000105da9 <mpinit+0x146>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
ffff800000105d56:	48 b8 40 87 11 00 00 	movabs $0xffff800000118740,%rax
ffff800000105d5d:	80 ff ff 
ffff800000105d60:	8b 10                	mov    (%rax),%edx
ffff800000105d62:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000105d66:	0f b6 48 01          	movzbl 0x1(%rax),%ecx
ffff800000105d6a:	48 be 00 86 11 00 00 	movabs $0xffff800000118600,%rsi
ffff800000105d71:	80 ff ff 
ffff800000105d74:	48 63 d2             	movslq %edx,%rdx
ffff800000105d77:	48 89 d0             	mov    %rdx,%rax
ffff800000105d7a:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000105d7e:	48 01 d0             	add    %rdx,%rax
ffff800000105d81:	48 c1 e0 03          	shl    $0x3,%rax
ffff800000105d85:	48 01 f0             	add    %rsi,%rax
ffff800000105d88:	48 83 c0 01          	add    $0x1,%rax
ffff800000105d8c:	88 08                	mov    %cl,(%rax)
        ncpu++;
ffff800000105d8e:	48 b8 40 87 11 00 00 	movabs $0xffff800000118740,%rax
ffff800000105d95:	80 ff ff 
ffff800000105d98:	8b 00                	mov    (%rax),%eax
ffff800000105d9a:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000105d9d:	48 b8 40 87 11 00 00 	movabs $0xffff800000118740,%rax
ffff800000105da4:	80 ff ff 
ffff800000105da7:	89 10                	mov    %edx,(%rax)
      }
      p += sizeof(struct mpproc);
ffff800000105da9:	48 83 45 f8 14       	addq   $0x14,-0x8(%rbp)
      continue;
ffff800000105dae:	eb 43                	jmp    ffff800000105df3 <mpinit+0x190>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
ffff800000105db0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105db4:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
      ioapicid = ioapic->apicno;
ffff800000105db8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105dbc:	0f b6 40 01          	movzbl 0x1(%rax),%eax
ffff800000105dc0:	48 ba 44 87 11 00 00 	movabs $0xffff800000118744,%rdx
ffff800000105dc7:	80 ff ff 
ffff800000105dca:	88 02                	mov    %al,(%rdx)
      p += sizeof(struct mpioapic);
ffff800000105dcc:	48 83 45 f8 08       	addq   $0x8,-0x8(%rbp)
      continue;
ffff800000105dd1:	eb 20                	jmp    ffff800000105df3 <mpinit+0x190>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
ffff800000105dd3:	48 83 45 f8 08       	addq   $0x8,-0x8(%rbp)
      continue;
ffff800000105dd8:	eb 19                	jmp    ffff800000105df3 <mpinit+0x190>
    default:
      panic("Major problem parsing mp config.");
ffff800000105dda:	48 b8 50 d2 10 00 00 	movabs $0xffff80000010d250,%rax
ffff800000105de1:	80 ff ff 
ffff800000105de4:	48 89 c7             	mov    %rax,%rdi
ffff800000105de7:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000105dee:	80 ff ff 
ffff800000105df1:	ff d0                	call   *%rax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
ffff800000105df3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105df7:	48 3b 45 e8          	cmp    -0x18(%rbp),%rax
ffff800000105dfb:	0f 82 fc fe ff ff    	jb     ffff800000105cfd <mpinit+0x9a>
      break;
    }
  }
  cprintf("Seems we are SMP, ncpu = %d\n",ncpu);
ffff800000105e01:	48 b8 40 87 11 00 00 	movabs $0xffff800000118740,%rax
ffff800000105e08:	80 ff ff 
ffff800000105e0b:	8b 00                	mov    (%rax),%eax
ffff800000105e0d:	89 c6                	mov    %eax,%esi
ffff800000105e0f:	48 b8 71 d2 10 00 00 	movabs $0xffff80000010d271,%rax
ffff800000105e16:	80 ff ff 
ffff800000105e19:	48 89 c7             	mov    %rax,%rdi
ffff800000105e1c:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105e21:	48 ba 38 08 10 00 00 	movabs $0xffff800000100838,%rdx
ffff800000105e28:	80 ff ff 
ffff800000105e2b:	ff d2                	call   *%rdx
  if(mp->imcrp){
ffff800000105e2d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000105e31:	0f b6 40 0c          	movzbl 0xc(%rax),%eax
ffff800000105e35:	84 c0                	test   %al,%al
ffff800000105e37:	74 40                	je     ffff800000105e79 <mpinit+0x216>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
ffff800000105e39:	be 70 00 00 00       	mov    $0x70,%esi
ffff800000105e3e:	bf 22 00 00 00       	mov    $0x22,%edi
ffff800000105e43:	48 b8 90 59 10 00 00 	movabs $0xffff800000105990,%rax
ffff800000105e4a:	80 ff ff 
ffff800000105e4d:	ff d0                	call   *%rax
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
ffff800000105e4f:	bf 23 00 00 00       	mov    $0x23,%edi
ffff800000105e54:	48 b8 6e 59 10 00 00 	movabs $0xffff80000010596e,%rax
ffff800000105e5b:	80 ff ff 
ffff800000105e5e:	ff d0                	call   *%rax
ffff800000105e60:	83 c8 01             	or     $0x1,%eax
ffff800000105e63:	0f b6 c0             	movzbl %al,%eax
ffff800000105e66:	89 c6                	mov    %eax,%esi
ffff800000105e68:	bf 23 00 00 00       	mov    $0x23,%edi
ffff800000105e6d:	48 b8 90 59 10 00 00 	movabs $0xffff800000105990,%rax
ffff800000105e74:	80 ff ff 
ffff800000105e77:	ff d0                	call   *%rax
  }
}
ffff800000105e79:	c9                   	leave
ffff800000105e7a:	c3                   	ret

ffff800000105e7b <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
ffff800000105e7b:	f3 0f 1e fa          	endbr64
ffff800000105e7f:	55                   	push   %rbp
ffff800000105e80:	48 89 e5             	mov    %rsp,%rbp
ffff800000105e83:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000105e87:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000105e8b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  struct pipe *p;

  p = 0;
ffff800000105e8f:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
ffff800000105e96:	00 
  *f0 = *f1 = 0;
ffff800000105e97:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105e9b:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
ffff800000105ea2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105ea6:	48 8b 10             	mov    (%rax),%rdx
ffff800000105ea9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105ead:	48 89 10             	mov    %rdx,(%rax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
ffff800000105eb0:	48 b8 c2 1b 10 00 00 	movabs $0xffff800000101bc2,%rax
ffff800000105eb7:	80 ff ff 
ffff800000105eba:	ff d0                	call   *%rax
ffff800000105ebc:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000105ec0:	48 89 02             	mov    %rax,(%rdx)
ffff800000105ec3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105ec7:	48 8b 00             	mov    (%rax),%rax
ffff800000105eca:	48 85 c0             	test   %rax,%rax
ffff800000105ecd:	0f 84 01 01 00 00    	je     ffff800000105fd4 <pipealloc+0x159>
ffff800000105ed3:	48 b8 c2 1b 10 00 00 	movabs $0xffff800000101bc2,%rax
ffff800000105eda:	80 ff ff 
ffff800000105edd:	ff d0                	call   *%rax
ffff800000105edf:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000105ee3:	48 89 02             	mov    %rax,(%rdx)
ffff800000105ee6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105eea:	48 8b 00             	mov    (%rax),%rax
ffff800000105eed:	48 85 c0             	test   %rax,%rax
ffff800000105ef0:	0f 84 de 00 00 00    	je     ffff800000105fd4 <pipealloc+0x159>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
ffff800000105ef6:	48 b8 78 43 10 00 00 	movabs $0xffff800000104378,%rax
ffff800000105efd:	80 ff ff 
ffff800000105f00:	ff d0                	call   *%rax
ffff800000105f02:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000105f06:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000105f0b:	0f 84 c6 00 00 00    	je     ffff800000105fd7 <pipealloc+0x15c>
    goto bad;
  p->readopen = 1;
ffff800000105f11:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105f15:	c7 80 70 02 00 00 01 	movl   $0x1,0x270(%rax)
ffff800000105f1c:	00 00 00 
  p->writeopen = 1;
ffff800000105f1f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105f23:	c7 80 74 02 00 00 01 	movl   $0x1,0x274(%rax)
ffff800000105f2a:	00 00 00 
  p->nwrite = 0;
ffff800000105f2d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105f31:	c7 80 6c 02 00 00 00 	movl   $0x0,0x26c(%rax)
ffff800000105f38:	00 00 00 
  p->nread = 0;
ffff800000105f3b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105f3f:	c7 80 68 02 00 00 00 	movl   $0x0,0x268(%rax)
ffff800000105f46:	00 00 00 
  initlock(&p->lock, "pipe");
ffff800000105f49:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105f4d:	48 ba 8e d2 10 00 00 	movabs $0xffff80000010d28e,%rdx
ffff800000105f54:	80 ff ff 
ffff800000105f57:	48 89 d6             	mov    %rdx,%rsi
ffff800000105f5a:	48 89 c7             	mov    %rax,%rdi
ffff800000105f5d:	48 b8 4f 7e 10 00 00 	movabs $0xffff800000107e4f,%rax
ffff800000105f64:	80 ff ff 
ffff800000105f67:	ff d0                	call   *%rax
  (*f0)->type = FD_PIPE;
ffff800000105f69:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f6d:	48 8b 00             	mov    (%rax),%rax
ffff800000105f70:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
  (*f0)->readable = 1;
ffff800000105f76:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f7a:	48 8b 00             	mov    (%rax),%rax
ffff800000105f7d:	c6 40 08 01          	movb   $0x1,0x8(%rax)
  (*f0)->writable = 0;
ffff800000105f81:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f85:	48 8b 00             	mov    (%rax),%rax
ffff800000105f88:	c6 40 09 00          	movb   $0x0,0x9(%rax)
  (*f0)->pipe = p;
ffff800000105f8c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f90:	48 8b 00             	mov    (%rax),%rax
ffff800000105f93:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000105f97:	48 89 50 10          	mov    %rdx,0x10(%rax)
  (*f1)->type = FD_PIPE;
ffff800000105f9b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105f9f:	48 8b 00             	mov    (%rax),%rax
ffff800000105fa2:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
  (*f1)->readable = 0;
ffff800000105fa8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105fac:	48 8b 00             	mov    (%rax),%rax
ffff800000105faf:	c6 40 08 00          	movb   $0x0,0x8(%rax)
  (*f1)->writable = 1;
ffff800000105fb3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105fb7:	48 8b 00             	mov    (%rax),%rax
ffff800000105fba:	c6 40 09 01          	movb   $0x1,0x9(%rax)
  (*f1)->pipe = p;
ffff800000105fbe:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105fc2:	48 8b 00             	mov    (%rax),%rax
ffff800000105fc5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000105fc9:	48 89 50 10          	mov    %rdx,0x10(%rax)
  return 0;
ffff800000105fcd:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105fd2:	eb 67                	jmp    ffff80000010603b <pipealloc+0x1c0>
    goto bad;
ffff800000105fd4:	90                   	nop
ffff800000105fd5:	eb 01                	jmp    ffff800000105fd8 <pipealloc+0x15d>
    goto bad;
ffff800000105fd7:	90                   	nop

//PAGEBREAK: 20
 bad:
  if(p)
ffff800000105fd8:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000105fdd:	74 13                	je     ffff800000105ff2 <pipealloc+0x177>
    kfree((char*)p);
ffff800000105fdf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105fe3:	48 89 c7             	mov    %rax,%rdi
ffff800000105fe6:	48 b8 75 42 10 00 00 	movabs $0xffff800000104275,%rax
ffff800000105fed:	80 ff ff 
ffff800000105ff0:	ff d0                	call   *%rax
  if(*f0)
ffff800000105ff2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105ff6:	48 8b 00             	mov    (%rax),%rax
ffff800000105ff9:	48 85 c0             	test   %rax,%rax
ffff800000105ffc:	74 16                	je     ffff800000106014 <pipealloc+0x199>
    fileclose(*f0);
ffff800000105ffe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106002:	48 8b 00             	mov    (%rax),%rax
ffff800000106005:	48 89 c7             	mov    %rax,%rdi
ffff800000106008:	48 b8 38 1d 10 00 00 	movabs $0xffff800000101d38,%rax
ffff80000010600f:	80 ff ff 
ffff800000106012:	ff d0                	call   *%rax
  if(*f1)
ffff800000106014:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106018:	48 8b 00             	mov    (%rax),%rax
ffff80000010601b:	48 85 c0             	test   %rax,%rax
ffff80000010601e:	74 16                	je     ffff800000106036 <pipealloc+0x1bb>
    fileclose(*f1);
ffff800000106020:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106024:	48 8b 00             	mov    (%rax),%rax
ffff800000106027:	48 89 c7             	mov    %rax,%rdi
ffff80000010602a:	48 b8 38 1d 10 00 00 	movabs $0xffff800000101d38,%rax
ffff800000106031:	80 ff ff 
ffff800000106034:	ff d0                	call   *%rax
  return -1;
ffff800000106036:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff80000010603b:	c9                   	leave
ffff80000010603c:	c3                   	ret

ffff80000010603d <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
ffff80000010603d:	f3 0f 1e fa          	endbr64
ffff800000106041:	55                   	push   %rbp
ffff800000106042:	48 89 e5             	mov    %rsp,%rbp
ffff800000106045:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000106049:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff80000010604d:	89 75 f4             	mov    %esi,-0xc(%rbp)
  acquire(&p->lock);
ffff800000106050:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106054:	48 89 c7             	mov    %rax,%rdi
ffff800000106057:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff80000010605e:	80 ff ff 
ffff800000106061:	ff d0                	call   *%rax
  if(writable){
ffff800000106063:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
ffff800000106067:	74 29                	je     ffff800000106092 <pipeclose+0x55>
    p->writeopen = 0;
ffff800000106069:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010606d:	c7 80 74 02 00 00 00 	movl   $0x0,0x274(%rax)
ffff800000106074:	00 00 00 
    wakeup(&p->nread);
ffff800000106077:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010607b:	48 05 68 02 00 00    	add    $0x268,%rax
ffff800000106081:	48 89 c7             	mov    %rax,%rdi
ffff800000106084:	48 b8 07 74 10 00 00 	movabs $0xffff800000107407,%rax
ffff80000010608b:	80 ff ff 
ffff80000010608e:	ff d0                	call   *%rax
ffff800000106090:	eb 27                	jmp    ffff8000001060b9 <pipeclose+0x7c>
  } else {
    p->readopen = 0;
ffff800000106092:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106096:	c7 80 70 02 00 00 00 	movl   $0x0,0x270(%rax)
ffff80000010609d:	00 00 00 
    wakeup(&p->nwrite);
ffff8000001060a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001060a4:	48 05 6c 02 00 00    	add    $0x26c,%rax
ffff8000001060aa:	48 89 c7             	mov    %rax,%rdi
ffff8000001060ad:	48 b8 07 74 10 00 00 	movabs $0xffff800000107407,%rax
ffff8000001060b4:	80 ff ff 
ffff8000001060b7:	ff d0                	call   *%rax
  }
  if(p->readopen == 0 && p->writeopen == 0){
ffff8000001060b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001060bd:	8b 80 70 02 00 00    	mov    0x270(%rax),%eax
ffff8000001060c3:	85 c0                	test   %eax,%eax
ffff8000001060c5:	75 36                	jne    ffff8000001060fd <pipeclose+0xc0>
ffff8000001060c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001060cb:	8b 80 74 02 00 00    	mov    0x274(%rax),%eax
ffff8000001060d1:	85 c0                	test   %eax,%eax
ffff8000001060d3:	75 28                	jne    ffff8000001060fd <pipeclose+0xc0>
    release(&p->lock);
ffff8000001060d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001060d9:	48 89 c7             	mov    %rax,%rdi
ffff8000001060dc:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff8000001060e3:	80 ff ff 
ffff8000001060e6:	ff d0                	call   *%rax
    kfree((char*)p);
ffff8000001060e8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001060ec:	48 89 c7             	mov    %rax,%rdi
ffff8000001060ef:	48 b8 75 42 10 00 00 	movabs $0xffff800000104275,%rax
ffff8000001060f6:	80 ff ff 
ffff8000001060f9:	ff d0                	call   *%rax
ffff8000001060fb:	eb 14                	jmp    ffff800000106111 <pipeclose+0xd4>
  } else
    release(&p->lock);
ffff8000001060fd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106101:	48 89 c7             	mov    %rax,%rdi
ffff800000106104:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff80000010610b:	80 ff ff 
ffff80000010610e:	ff d0                	call   *%rax
}
ffff800000106110:	90                   	nop
ffff800000106111:	90                   	nop
ffff800000106112:	c9                   	leave
ffff800000106113:	c3                   	ret

ffff800000106114 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
ffff800000106114:	f3 0f 1e fa          	endbr64
ffff800000106118:	55                   	push   %rbp
ffff800000106119:	48 89 e5             	mov    %rsp,%rbp
ffff80000010611c:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000106120:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000106124:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000106128:	89 55 dc             	mov    %edx,-0x24(%rbp)
  int i;

  acquire(&p->lock);
ffff80000010612b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010612f:	48 89 c7             	mov    %rax,%rdi
ffff800000106132:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff800000106139:	80 ff ff 
ffff80000010613c:	ff d0                	call   *%rax
  for(i = 0; i < n; i++){
ffff80000010613e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000106145:	e9 d5 00 00 00       	jmp    ffff80000010621f <pipewrite+0x10b>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
ffff80000010614a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010614e:	8b 80 70 02 00 00    	mov    0x270(%rax),%eax
ffff800000106154:	85 c0                	test   %eax,%eax
ffff800000106156:	74 12                	je     ffff80000010616a <pipewrite+0x56>
ffff800000106158:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010615f:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106163:	8b 40 40             	mov    0x40(%rax),%eax
ffff800000106166:	85 c0                	test   %eax,%eax
ffff800000106168:	74 1d                	je     ffff800000106187 <pipewrite+0x73>
        release(&p->lock);
ffff80000010616a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010616e:	48 89 c7             	mov    %rax,%rdi
ffff800000106171:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff800000106178:	80 ff ff 
ffff80000010617b:	ff d0                	call   *%rax
        return -1;
ffff80000010617d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000106182:	e9 cf 00 00 00       	jmp    ffff800000106256 <pipewrite+0x142>
      }
      wakeup(&p->nread);
ffff800000106187:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010618b:	48 05 68 02 00 00    	add    $0x268,%rax
ffff800000106191:	48 89 c7             	mov    %rax,%rdi
ffff800000106194:	48 b8 07 74 10 00 00 	movabs $0xffff800000107407,%rax
ffff80000010619b:	80 ff ff 
ffff80000010619e:	ff d0                	call   *%rax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
ffff8000001061a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001061a4:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff8000001061a8:	48 81 c2 6c 02 00 00 	add    $0x26c,%rdx
ffff8000001061af:	48 89 c6             	mov    %rax,%rsi
ffff8000001061b2:	48 89 d7             	mov    %rdx,%rdi
ffff8000001061b5:	48 b8 8a 72 10 00 00 	movabs $0xffff80000010728a,%rax
ffff8000001061bc:	80 ff ff 
ffff8000001061bf:	ff d0                	call   *%rax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
ffff8000001061c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001061c5:	8b 90 6c 02 00 00    	mov    0x26c(%rax),%edx
ffff8000001061cb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001061cf:	8b 80 68 02 00 00    	mov    0x268(%rax),%eax
ffff8000001061d5:	05 00 02 00 00       	add    $0x200,%eax
ffff8000001061da:	39 c2                	cmp    %eax,%edx
ffff8000001061dc:	0f 84 68 ff ff ff    	je     ffff80000010614a <pipewrite+0x36>
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
ffff8000001061e2:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001061e5:	48 63 d0             	movslq %eax,%rdx
ffff8000001061e8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001061ec:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
ffff8000001061f0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001061f4:	8b 80 6c 02 00 00    	mov    0x26c(%rax),%eax
ffff8000001061fa:	8d 48 01             	lea    0x1(%rax),%ecx
ffff8000001061fd:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000106201:	89 8a 6c 02 00 00    	mov    %ecx,0x26c(%rdx)
ffff800000106207:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010620c:	89 c1                	mov    %eax,%ecx
ffff80000010620e:	0f b6 16             	movzbl (%rsi),%edx
ffff800000106211:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106215:	89 c9                	mov    %ecx,%ecx
ffff800000106217:	88 54 08 68          	mov    %dl,0x68(%rax,%rcx,1)
  for(i = 0; i < n; i++){
ffff80000010621b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff80000010621f:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000106222:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffff800000106225:	7c 9a                	jl     ffff8000001061c1 <pipewrite+0xad>
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
ffff800000106227:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010622b:	48 05 68 02 00 00    	add    $0x268,%rax
ffff800000106231:	48 89 c7             	mov    %rax,%rdi
ffff800000106234:	48 b8 07 74 10 00 00 	movabs $0xffff800000107407,%rax
ffff80000010623b:	80 ff ff 
ffff80000010623e:	ff d0                	call   *%rax
  release(&p->lock);
ffff800000106240:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106244:	48 89 c7             	mov    %rax,%rdi
ffff800000106247:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff80000010624e:	80 ff ff 
ffff800000106251:	ff d0                	call   *%rax
  return n;
ffff800000106253:	8b 45 dc             	mov    -0x24(%rbp),%eax
}
ffff800000106256:	c9                   	leave
ffff800000106257:	c3                   	ret

ffff800000106258 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
ffff800000106258:	f3 0f 1e fa          	endbr64
ffff80000010625c:	55                   	push   %rbp
ffff80000010625d:	48 89 e5             	mov    %rsp,%rbp
ffff800000106260:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000106264:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000106268:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff80000010626c:	89 55 dc             	mov    %edx,-0x24(%rbp)
  int i;

  acquire(&p->lock);
ffff80000010626f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106273:	48 89 c7             	mov    %rax,%rdi
ffff800000106276:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff80000010627d:	80 ff ff 
ffff800000106280:	ff d0                	call   *%rax
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
ffff800000106282:	eb 50                	jmp    ffff8000001062d4 <piperead+0x7c>
    if(proc->killed){
ffff800000106284:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010628b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010628f:	8b 40 40             	mov    0x40(%rax),%eax
ffff800000106292:	85 c0                	test   %eax,%eax
ffff800000106294:	74 1d                	je     ffff8000001062b3 <piperead+0x5b>
      release(&p->lock);
ffff800000106296:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010629a:	48 89 c7             	mov    %rax,%rdi
ffff80000010629d:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff8000001062a4:	80 ff ff 
ffff8000001062a7:	ff d0                	call   *%rax
      return -1;
ffff8000001062a9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001062ae:	e9 de 00 00 00       	jmp    ffff800000106391 <piperead+0x139>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
ffff8000001062b3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001062b7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff8000001062bb:	48 81 c2 68 02 00 00 	add    $0x268,%rdx
ffff8000001062c2:	48 89 c6             	mov    %rax,%rsi
ffff8000001062c5:	48 89 d7             	mov    %rdx,%rdi
ffff8000001062c8:	48 b8 8a 72 10 00 00 	movabs $0xffff80000010728a,%rax
ffff8000001062cf:	80 ff ff 
ffff8000001062d2:	ff d0                	call   *%rax
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
ffff8000001062d4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001062d8:	8b 90 68 02 00 00    	mov    0x268(%rax),%edx
ffff8000001062de:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001062e2:	8b 80 6c 02 00 00    	mov    0x26c(%rax),%eax
ffff8000001062e8:	39 c2                	cmp    %eax,%edx
ffff8000001062ea:	75 0e                	jne    ffff8000001062fa <piperead+0xa2>
ffff8000001062ec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001062f0:	8b 80 74 02 00 00    	mov    0x274(%rax),%eax
ffff8000001062f6:	85 c0                	test   %eax,%eax
ffff8000001062f8:	75 8a                	jne    ffff800000106284 <piperead+0x2c>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
ffff8000001062fa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000106301:	eb 54                	jmp    ffff800000106357 <piperead+0xff>
    if(p->nread == p->nwrite)
ffff800000106303:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106307:	8b 90 68 02 00 00    	mov    0x268(%rax),%edx
ffff80000010630d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106311:	8b 80 6c 02 00 00    	mov    0x26c(%rax),%eax
ffff800000106317:	39 c2                	cmp    %eax,%edx
ffff800000106319:	74 46                	je     ffff800000106361 <piperead+0x109>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
ffff80000010631b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010631f:	8b 80 68 02 00 00    	mov    0x268(%rax),%eax
ffff800000106325:	8d 48 01             	lea    0x1(%rax),%ecx
ffff800000106328:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff80000010632c:	89 8a 68 02 00 00    	mov    %ecx,0x268(%rdx)
ffff800000106332:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff800000106337:	89 c1                	mov    %eax,%ecx
ffff800000106339:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010633c:	48 63 d0             	movslq %eax,%rdx
ffff80000010633f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106343:	48 01 c2             	add    %rax,%rdx
ffff800000106346:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010634a:	89 c9                	mov    %ecx,%ecx
ffff80000010634c:	0f b6 44 08 68       	movzbl 0x68(%rax,%rcx,1),%eax
ffff800000106351:	88 02                	mov    %al,(%rdx)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
ffff800000106353:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000106357:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010635a:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffff80000010635d:	7c a4                	jl     ffff800000106303 <piperead+0xab>
ffff80000010635f:	eb 01                	jmp    ffff800000106362 <piperead+0x10a>
      break;
ffff800000106361:	90                   	nop
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
ffff800000106362:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106366:	48 05 6c 02 00 00    	add    $0x26c,%rax
ffff80000010636c:	48 89 c7             	mov    %rax,%rdi
ffff80000010636f:	48 b8 07 74 10 00 00 	movabs $0xffff800000107407,%rax
ffff800000106376:	80 ff ff 
ffff800000106379:	ff d0                	call   *%rax
  release(&p->lock);
ffff80000010637b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010637f:	48 89 c7             	mov    %rax,%rdi
ffff800000106382:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff800000106389:	80 ff ff 
ffff80000010638c:	ff d0                	call   *%rax
  return i;
ffff80000010638e:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff800000106391:	c9                   	leave
ffff800000106392:	c3                   	ret

ffff800000106393 <readeflags>:
  inituvm(p->pgdir, _binary_initcode_start,
          (addr_t)_binary_initcode_size);
  p->sz = PGSIZE * 2;
  memset(p->tf, 0, sizeof(*p->tf));

  p->tf->r11 = FL_IF;  // with SYSRET, EFLAGS is in R11
ffff800000106393:	f3 0f 1e fa          	endbr64
ffff800000106397:	55                   	push   %rbp
ffff800000106398:	48 89 e5             	mov    %rsp,%rbp
ffff80000010639b:	48 83 ec 10          	sub    $0x10,%rsp
  p->tf->rsp = p->sz;
  p->tf->rcx = PGSIZE;  // with SYSRET, RIP is in RCX
ffff80000010639f:	9c                   	pushf
ffff8000001063a0:	58                   	pop    %rax
ffff8000001063a1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

ffff8000001063a5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  safestrcpy(p->name, "initcode", sizeof(p->name));
ffff8000001063a9:	c9                   	leave
ffff8000001063aa:	c3                   	ret

ffff8000001063ab <sti>:
}

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int64 n)
ffff8000001063ab:	f3 0f 1e fa          	endbr64
ffff8000001063af:	55                   	push   %rbp
ffff8000001063b0:	48 89 e5             	mov    %rsp,%rbp
{
ffff8000001063b3:	fb                   	sti
  addr_t sz;
ffff8000001063b4:	90                   	nop
ffff8000001063b5:	5d                   	pop    %rbp
ffff8000001063b6:	c3                   	ret

ffff8000001063b7 <hlt>:

  sz = proc->sz;
  if(n > 0){
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
ffff8000001063b7:	f3 0f 1e fa          	endbr64
ffff8000001063bb:	55                   	push   %rbp
ffff8000001063bc:	48 89 e5             	mov    %rsp,%rbp
      return -1;
ffff8000001063bf:	f4                   	hlt
  } else if(n < 0){
ffff8000001063c0:	90                   	nop
ffff8000001063c1:	5d                   	pop    %rbp
ffff8000001063c2:	c3                   	ret

ffff8000001063c3 <pinit>:
{
ffff8000001063c3:	f3 0f 1e fa          	endbr64
ffff8000001063c7:	55                   	push   %rbp
ffff8000001063c8:	48 89 e5             	mov    %rsp,%rbp
  initlock(&ptable.lock, "ptable");
ffff8000001063cb:	48 b8 93 d2 10 00 00 	movabs $0xffff80000010d293,%rax
ffff8000001063d2:	80 ff ff 
ffff8000001063d5:	48 89 c6             	mov    %rax,%rsi
ffff8000001063d8:	48 b8 60 87 11 00 00 	movabs $0xffff800000118760,%rax
ffff8000001063df:	80 ff ff 
ffff8000001063e2:	48 89 c7             	mov    %rax,%rdi
ffff8000001063e5:	48 b8 4f 7e 10 00 00 	movabs $0xffff800000107e4f,%rax
ffff8000001063ec:	80 ff ff 
ffff8000001063ef:	ff d0                	call   *%rax
}
ffff8000001063f1:	90                   	nop
ffff8000001063f2:	5d                   	pop    %rbp
ffff8000001063f3:	c3                   	ret

ffff8000001063f4 <allocproc>:
{
ffff8000001063f4:	f3 0f 1e fa          	endbr64
ffff8000001063f8:	55                   	push   %rbp
ffff8000001063f9:	48 89 e5             	mov    %rsp,%rbp
ffff8000001063fc:	48 83 ec 10          	sub    $0x10,%rsp
  acquire(&ptable.lock);
ffff800000106400:	48 b8 60 87 11 00 00 	movabs $0xffff800000118760,%rax
ffff800000106407:	80 ff ff 
ffff80000010640a:	48 89 c7             	mov    %rax,%rdi
ffff80000010640d:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff800000106414:	80 ff ff 
ffff800000106417:	ff d0                	call   *%rax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffff800000106419:	48 b8 c8 87 11 00 00 	movabs $0xffff8000001187c8,%rax
ffff800000106420:	80 ff ff 
ffff800000106423:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000106427:	eb 13                	jmp    ffff80000010643c <allocproc+0x48>
    if(p->state == UNUSED)
ffff800000106429:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010642d:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106430:	85 c0                	test   %eax,%eax
ffff800000106432:	74 3b                	je     ffff80000010646f <allocproc+0x7b>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffff800000106434:	48 81 45 f8 c8 01 00 	addq   $0x1c8,-0x8(%rbp)
ffff80000010643b:	00 
ffff80000010643c:	48 b8 c8 f9 11 00 00 	movabs $0xffff80000011f9c8,%rax
ffff800000106443:	80 ff ff 
ffff800000106446:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff80000010644a:	72 dd                	jb     ffff800000106429 <allocproc+0x35>
  release(&ptable.lock);
ffff80000010644c:	48 b8 60 87 11 00 00 	movabs $0xffff800000118760,%rax
ffff800000106453:	80 ff ff 
ffff800000106456:	48 89 c7             	mov    %rax,%rdi
ffff800000106459:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff800000106460:	80 ff ff 
ffff800000106463:	ff d0                	call   *%rax
  return 0;
ffff800000106465:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010646a:	e9 36 01 00 00       	jmp    ffff8000001065a5 <allocproc+0x1b1>
      goto found;
ffff80000010646f:	90                   	nop
  p->state = EMBRYO;
ffff800000106470:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106474:	c7 40 18 01 00 00 00 	movl   $0x1,0x18(%rax)
  p->pid = nextpid++;
ffff80000010647b:	48 b8 40 e5 10 00 00 	movabs $0xffff80000010e540,%rax
ffff800000106482:	80 ff ff 
ffff800000106485:	8b 00                	mov    (%rax),%eax
ffff800000106487:	8d 50 01             	lea    0x1(%rax),%edx
ffff80000010648a:	48 b9 40 e5 10 00 00 	movabs $0xffff80000010e540,%rcx
ffff800000106491:	80 ff ff 
ffff800000106494:	89 11                	mov    %edx,(%rcx)
ffff800000106496:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010649a:	89 42 1c             	mov    %eax,0x1c(%rdx)
  release(&ptable.lock);
ffff80000010649d:	48 b8 60 87 11 00 00 	movabs $0xffff800000118760,%rax
ffff8000001064a4:	80 ff ff 
ffff8000001064a7:	48 89 c7             	mov    %rax,%rdi
ffff8000001064aa:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff8000001064b1:	80 ff ff 
ffff8000001064b4:	ff d0                	call   *%rax
  memset(&p->mailbox, 0, sizeof(p->mailbox));
ffff8000001064b6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001064ba:	48 05 e0 00 00 00    	add    $0xe0,%rax
ffff8000001064c0:	ba e0 00 00 00       	mov    $0xe0,%edx
ffff8000001064c5:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001064ca:	48 89 c7             	mov    %rax,%rdi
ffff8000001064cd:	48 b8 40 82 10 00 00 	movabs $0xffff800000108240,%rax
ffff8000001064d4:	80 ff ff 
ffff8000001064d7:	ff d0                	call   *%rax
  p->has_msg = 0;
ffff8000001064d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001064dd:	c7 80 c0 01 00 00 00 	movl   $0x0,0x1c0(%rax)
ffff8000001064e4:	00 00 00 
  if((p->kstack = kalloc()) == 0){
ffff8000001064e7:	48 b8 78 43 10 00 00 	movabs $0xffff800000104378,%rax
ffff8000001064ee:	80 ff ff 
ffff8000001064f1:	ff d0                	call   *%rax
ffff8000001064f3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001064f7:	48 89 42 10          	mov    %rax,0x10(%rdx)
ffff8000001064fb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001064ff:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000106503:	48 85 c0             	test   %rax,%rax
ffff800000106506:	75 15                	jne    ffff80000010651d <allocproc+0x129>
    p->state = UNUSED;
ffff800000106508:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010650c:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
    return 0;
ffff800000106513:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106518:	e9 88 00 00 00       	jmp    ffff8000001065a5 <allocproc+0x1b1>
  sp = p->kstack + KSTACKSIZE;
ffff80000010651d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106521:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000106525:	48 05 00 10 00 00    	add    $0x1000,%rax
ffff80000010652b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  sp -= sizeof *p->tf;
ffff80000010652f:	48 81 6d f0 b0 00 00 	subq   $0xb0,-0x10(%rbp)
ffff800000106536:	00 
  p->tf = (struct trapframe*)sp;
ffff800000106537:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010653b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff80000010653f:	48 89 50 28          	mov    %rdx,0x28(%rax)
  sp -= sizeof(addr_t);
ffff800000106543:	48 83 6d f0 08       	subq   $0x8,-0x10(%rbp)
  *(addr_t*)sp = (addr_t)syscall_trapret;
ffff800000106548:	48 ba af a6 10 00 00 	movabs $0xffff80000010a6af,%rdx
ffff80000010654f:	80 ff ff 
ffff800000106552:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106556:	48 89 10             	mov    %rdx,(%rax)
  sp -= sizeof *p->context;
ffff800000106559:	48 83 6d f0 38       	subq   $0x38,-0x10(%rbp)
  p->context = (struct context*)sp;
ffff80000010655e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106562:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000106566:	48 89 50 30          	mov    %rdx,0x30(%rax)
  memset(p->context, 0, sizeof *p->context);
ffff80000010656a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010656e:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff800000106572:	ba 38 00 00 00       	mov    $0x38,%edx
ffff800000106577:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010657c:	48 89 c7             	mov    %rax,%rdi
ffff80000010657f:	48 b8 40 82 10 00 00 	movabs $0xffff800000108240,%rax
ffff800000106586:	80 ff ff 
ffff800000106589:	ff d0                	call   *%rax
  p->context->rip = (addr_t)forkret;
ffff80000010658b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010658f:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff800000106593:	48 ba 24 72 10 00 00 	movabs $0xffff800000107224,%rdx
ffff80000010659a:	80 ff ff 
ffff80000010659d:	48 89 50 30          	mov    %rdx,0x30(%rax)
  return p;
ffff8000001065a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff8000001065a5:	c9                   	leave
ffff8000001065a6:	c3                   	ret

ffff8000001065a7 <userinit>:
{
ffff8000001065a7:	f3 0f 1e fa          	endbr64
ffff8000001065ab:	55                   	push   %rbp
ffff8000001065ac:	48 89 e5             	mov    %rsp,%rbp
ffff8000001065af:	48 83 ec 10          	sub    $0x10,%rsp
  p = allocproc();
ffff8000001065b3:	48 b8 f4 63 10 00 00 	movabs $0xffff8000001063f4,%rax
ffff8000001065ba:	80 ff ff 
ffff8000001065bd:	ff d0                	call   *%rax
ffff8000001065bf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  initproc = p;
ffff8000001065c3:	48 ba c8 f9 11 00 00 	movabs $0xffff80000011f9c8,%rdx
ffff8000001065ca:	80 ff ff 
ffff8000001065cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001065d1:	48 89 02             	mov    %rax,(%rdx)
  if((p->pgdir = setupkvm()) == 0)
ffff8000001065d4:	48 b8 1f bf 10 00 00 	movabs $0xffff80000010bf1f,%rax
ffff8000001065db:	80 ff ff 
ffff8000001065de:	ff d0                	call   *%rax
ffff8000001065e0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001065e4:	48 89 42 08          	mov    %rax,0x8(%rdx)
ffff8000001065e8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001065ec:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff8000001065f0:	48 85 c0             	test   %rax,%rax
ffff8000001065f3:	75 19                	jne    ffff80000010660e <userinit+0x67>
    panic("userinit: out of memory?");
ffff8000001065f5:	48 b8 9a d2 10 00 00 	movabs $0xffff80000010d29a,%rax
ffff8000001065fc:	80 ff ff 
ffff8000001065ff:	48 89 c7             	mov    %rax,%rdi
ffff800000106602:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000106609:	80 ff ff 
ffff80000010660c:	ff d0                	call   *%rax
  inituvm(p->pgdir, _binary_initcode_start,
ffff80000010660e:	48 b8 40 00 00 00 00 	movabs $0x40,%rax
ffff800000106615:	00 00 00 
ffff800000106618:	89 c2                	mov    %eax,%edx
ffff80000010661a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010661e:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000106622:	48 b9 6c ee 10 00 00 	movabs $0xffff80000010ee6c,%rcx
ffff800000106629:	80 ff ff 
ffff80000010662c:	48 89 ce             	mov    %rcx,%rsi
ffff80000010662f:	48 89 c7             	mov    %rax,%rdi
ffff800000106632:	48 b8 ad c4 10 00 00 	movabs $0xffff80000010c4ad,%rax
ffff800000106639:	80 ff ff 
ffff80000010663c:	ff d0                	call   *%rax
  p->sz = PGSIZE * 2;
ffff80000010663e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106642:	48 c7 00 00 20 00 00 	movq   $0x2000,(%rax)
  memset(p->tf, 0, sizeof(*p->tf));
ffff800000106649:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010664d:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000106651:	ba b0 00 00 00       	mov    $0xb0,%edx
ffff800000106656:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010665b:	48 89 c7             	mov    %rax,%rdi
ffff80000010665e:	48 b8 40 82 10 00 00 	movabs $0xffff800000108240,%rax
ffff800000106665:	80 ff ff 
ffff800000106668:	ff d0                	call   *%rax
  p->tf->r11 = FL_IF;  // with SYSRET, EFLAGS is in R11
ffff80000010666a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010666e:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000106672:	48 c7 40 50 00 02 00 	movq   $0x200,0x50(%rax)
ffff800000106679:	00 
  p->tf->rsp = p->sz;
ffff80000010667a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010667e:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000106682:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000106686:	48 8b 12             	mov    (%rdx),%rdx
ffff800000106689:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
  p->tf->rcx = PGSIZE;  // with SYSRET, RIP is in RCX
ffff800000106690:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106694:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000106698:	48 c7 40 10 00 10 00 	movq   $0x1000,0x10(%rax)
ffff80000010669f:	00 
  safestrcpy(p->name, "initcode", sizeof(p->name));
ffff8000001066a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001066a4:	48 05 d0 00 00 00    	add    $0xd0,%rax
ffff8000001066aa:	ba 10 00 00 00       	mov    $0x10,%edx
ffff8000001066af:	48 b9 b3 d2 10 00 00 	movabs $0xffff80000010d2b3,%rcx
ffff8000001066b6:	80 ff ff 
ffff8000001066b9:	48 89 ce             	mov    %rcx,%rsi
ffff8000001066bc:	48 89 c7             	mov    %rax,%rdi
ffff8000001066bf:	48 b8 10 85 10 00 00 	movabs $0xffff800000108510,%rax
ffff8000001066c6:	80 ff ff 
ffff8000001066c9:	ff d0                	call   *%rax
  p->cwd = namei("/");
ffff8000001066cb:	48 b8 bc d2 10 00 00 	movabs $0xffff80000010d2bc,%rax
ffff8000001066d2:	80 ff ff 
ffff8000001066d5:	48 89 c7             	mov    %rax,%rdi
ffff8000001066d8:	48 b8 1d 39 10 00 00 	movabs $0xffff80000010391d,%rax
ffff8000001066df:	80 ff ff 
ffff8000001066e2:	ff d0                	call   *%rax
ffff8000001066e4:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001066e8:	48 89 82 c8 00 00 00 	mov    %rax,0xc8(%rdx)
  __sync_synchronize();
ffff8000001066ef:	f0 48 83 0c 24 00    	lock orq $0x0,(%rsp)
  p->state = RUNNABLE;
ffff8000001066f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001066f9:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
}
ffff800000106700:	90                   	nop
ffff800000106701:	c9                   	leave
ffff800000106702:	c3                   	ret

ffff800000106703 <growproc>:
{
ffff800000106703:	f3 0f 1e fa          	endbr64
ffff800000106707:	55                   	push   %rbp
ffff800000106708:	48 89 e5             	mov    %rsp,%rbp
ffff80000010670b:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010670f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  sz = proc->sz;
ffff800000106713:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010671a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010671e:	48 8b 00             	mov    (%rax),%rax
ffff800000106721:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(n > 0){
ffff800000106725:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010672a:	7e 42                	jle    ffff80000010676e <growproc+0x6b>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
ffff80000010672c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000106730:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106734:	48 01 c2             	add    %rax,%rdx
ffff800000106737:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010673e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106742:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000106746:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff80000010674a:	48 89 ce             	mov    %rcx,%rsi
ffff80000010674d:	48 89 c7             	mov    %rax,%rdi
ffff800000106750:	48 b8 96 c6 10 00 00 	movabs $0xffff80000010c696,%rax
ffff800000106757:	80 ff ff 
ffff80000010675a:	ff d0                	call   *%rax
ffff80000010675c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000106760:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000106765:	75 50                	jne    ffff8000001067b7 <growproc+0xb4>
      return -1;
ffff800000106767:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010676c:	eb 7a                	jmp    ffff8000001067e8 <growproc+0xe5>
  } else if(n < 0){
ffff80000010676e:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff800000106773:	79 42                	jns    ffff8000001067b7 <growproc+0xb4>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
ffff800000106775:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000106779:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010677d:	48 01 c2             	add    %rax,%rdx
ffff800000106780:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106787:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010678b:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010678f:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff800000106793:	48 89 ce             	mov    %rcx,%rsi
ffff800000106796:	48 89 c7             	mov    %rax,%rdi
ffff800000106799:	48 b8 de c7 10 00 00 	movabs $0xffff80000010c7de,%rax
ffff8000001067a0:	80 ff ff 
ffff8000001067a3:	ff d0                	call   *%rax
ffff8000001067a5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001067a9:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff8000001067ae:	75 07                	jne    ffff8000001067b7 <growproc+0xb4>
      return -1;
ffff8000001067b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001067b5:	eb 31                	jmp    ffff8000001067e8 <growproc+0xe5>
  }
  proc->sz = sz;
ffff8000001067b7:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001067be:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001067c2:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001067c6:	48 89 10             	mov    %rdx,(%rax)
  switchuvm(proc);
ffff8000001067c9:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001067d0:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001067d4:	48 89 c7             	mov    %rax,%rdi
ffff8000001067d7:	48 b8 85 c0 10 00 00 	movabs $0xffff80000010c085,%rax
ffff8000001067de:	80 ff ff 
ffff8000001067e1:	ff d0                	call   *%rax
  return 0;
ffff8000001067e3:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff8000001067e8:	c9                   	leave
ffff8000001067e9:	c3                   	ret

ffff8000001067ea <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
ffff8000001067ea:	f3 0f 1e fa          	endbr64
ffff8000001067ee:	55                   	push   %rbp
ffff8000001067ef:	48 89 e5             	mov    %rsp,%rbp
ffff8000001067f2:	53                   	push   %rbx
ffff8000001067f3:	48 83 ec 28          	sub    $0x28,%rsp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
ffff8000001067f7:	48 b8 f4 63 10 00 00 	movabs $0xffff8000001063f4,%rax
ffff8000001067fe:	80 ff ff 
ffff800000106801:	ff d0                	call   *%rax
ffff800000106803:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff800000106807:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
ffff80000010680c:	75 0a                	jne    ffff800000106818 <fork+0x2e>
    return -1;
ffff80000010680e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000106813:	e9 88 02 00 00       	jmp    ffff800000106aa0 <fork+0x2b6>

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
ffff800000106818:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010681f:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106823:	48 8b 00             	mov    (%rax),%rax
ffff800000106826:	89 c2                	mov    %eax,%edx
ffff800000106828:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010682f:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106833:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000106837:	89 d6                	mov    %edx,%esi
ffff800000106839:	48 89 c7             	mov    %rax,%rdi
ffff80000010683c:	48 b8 85 cb 10 00 00 	movabs $0xffff80000010cb85,%rax
ffff800000106843:	80 ff ff 
ffff800000106846:	ff d0                	call   *%rax
ffff800000106848:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff80000010684c:	48 89 42 08          	mov    %rax,0x8(%rdx)
ffff800000106850:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106854:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000106858:	48 85 c0             	test   %rax,%rax
ffff80000010685b:	75 38                	jne    ffff800000106895 <fork+0xab>
    kfree(np->kstack);
ffff80000010685d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106861:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000106865:	48 89 c7             	mov    %rax,%rdi
ffff800000106868:	48 b8 75 42 10 00 00 	movabs $0xffff800000104275,%rax
ffff80000010686f:	80 ff ff 
ffff800000106872:	ff d0                	call   *%rax
    np->kstack = 0;
ffff800000106874:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106878:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff80000010687f:	00 
    np->state = UNUSED;
ffff800000106880:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106884:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
    return -1;
ffff80000010688b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000106890:	e9 0b 02 00 00       	jmp    ffff800000106aa0 <fork+0x2b6>
  }
  np->sz = proc->sz;
ffff800000106895:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010689c:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001068a0:	48 8b 10             	mov    (%rax),%rdx
ffff8000001068a3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001068a7:	48 89 10             	mov    %rdx,(%rax)
  np->parent = proc;
ffff8000001068aa:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001068b1:	64 48 8b 10          	mov    %fs:(%rax),%rdx
ffff8000001068b5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001068b9:	48 89 50 20          	mov    %rdx,0x20(%rax)
  *np->tf = *proc->tf;
ffff8000001068bd:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001068c4:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001068c8:	48 8b 50 28          	mov    0x28(%rax),%rdx
ffff8000001068cc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001068d0:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001068d4:	48 8b 0a             	mov    (%rdx),%rcx
ffff8000001068d7:	48 8b 5a 08          	mov    0x8(%rdx),%rbx
ffff8000001068db:	48 89 08             	mov    %rcx,(%rax)
ffff8000001068de:	48 89 58 08          	mov    %rbx,0x8(%rax)
ffff8000001068e2:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
ffff8000001068e6:	48 8b 5a 18          	mov    0x18(%rdx),%rbx
ffff8000001068ea:	48 89 48 10          	mov    %rcx,0x10(%rax)
ffff8000001068ee:	48 89 58 18          	mov    %rbx,0x18(%rax)
ffff8000001068f2:	48 8b 4a 20          	mov    0x20(%rdx),%rcx
ffff8000001068f6:	48 8b 5a 28          	mov    0x28(%rdx),%rbx
ffff8000001068fa:	48 89 48 20          	mov    %rcx,0x20(%rax)
ffff8000001068fe:	48 89 58 28          	mov    %rbx,0x28(%rax)
ffff800000106902:	48 8b 4a 30          	mov    0x30(%rdx),%rcx
ffff800000106906:	48 8b 5a 38          	mov    0x38(%rdx),%rbx
ffff80000010690a:	48 89 48 30          	mov    %rcx,0x30(%rax)
ffff80000010690e:	48 89 58 38          	mov    %rbx,0x38(%rax)
ffff800000106912:	48 8b 4a 40          	mov    0x40(%rdx),%rcx
ffff800000106916:	48 8b 5a 48          	mov    0x48(%rdx),%rbx
ffff80000010691a:	48 89 48 40          	mov    %rcx,0x40(%rax)
ffff80000010691e:	48 89 58 48          	mov    %rbx,0x48(%rax)
ffff800000106922:	48 8b 4a 50          	mov    0x50(%rdx),%rcx
ffff800000106926:	48 8b 5a 58          	mov    0x58(%rdx),%rbx
ffff80000010692a:	48 89 48 50          	mov    %rcx,0x50(%rax)
ffff80000010692e:	48 89 58 58          	mov    %rbx,0x58(%rax)
ffff800000106932:	48 8b 4a 60          	mov    0x60(%rdx),%rcx
ffff800000106936:	48 8b 5a 68          	mov    0x68(%rdx),%rbx
ffff80000010693a:	48 89 48 60          	mov    %rcx,0x60(%rax)
ffff80000010693e:	48 89 58 68          	mov    %rbx,0x68(%rax)
ffff800000106942:	48 8b 4a 70          	mov    0x70(%rdx),%rcx
ffff800000106946:	48 8b 5a 78          	mov    0x78(%rdx),%rbx
ffff80000010694a:	48 89 48 70          	mov    %rcx,0x70(%rax)
ffff80000010694e:	48 89 58 78          	mov    %rbx,0x78(%rax)
ffff800000106952:	48 8b 8a 80 00 00 00 	mov    0x80(%rdx),%rcx
ffff800000106959:	48 8b 9a 88 00 00 00 	mov    0x88(%rdx),%rbx
ffff800000106960:	48 89 88 80 00 00 00 	mov    %rcx,0x80(%rax)
ffff800000106967:	48 89 98 88 00 00 00 	mov    %rbx,0x88(%rax)
ffff80000010696e:	48 8b 8a 90 00 00 00 	mov    0x90(%rdx),%rcx
ffff800000106975:	48 8b 9a 98 00 00 00 	mov    0x98(%rdx),%rbx
ffff80000010697c:	48 89 88 90 00 00 00 	mov    %rcx,0x90(%rax)
ffff800000106983:	48 89 98 98 00 00 00 	mov    %rbx,0x98(%rax)
ffff80000010698a:	48 8b 8a a0 00 00 00 	mov    0xa0(%rdx),%rcx
ffff800000106991:	48 8b 9a a8 00 00 00 	mov    0xa8(%rdx),%rbx
ffff800000106998:	48 89 88 a0 00 00 00 	mov    %rcx,0xa0(%rax)
ffff80000010699f:	48 89 98 a8 00 00 00 	mov    %rbx,0xa8(%rax)

  // Clear %rax so that fork returns 0 in the child.
  np->tf->rax = 0;
ffff8000001069a6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001069aa:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001069ae:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)

  for(i = 0; i < NOFILE; i++)
ffff8000001069b5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
ffff8000001069bc:	eb 5f                	jmp    ffff800000106a1d <fork+0x233>
    if(proc->ofile[i])
ffff8000001069be:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001069c5:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001069c9:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff8000001069cc:	48 63 d2             	movslq %edx,%rdx
ffff8000001069cf:	48 83 c2 08          	add    $0x8,%rdx
ffff8000001069d3:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff8000001069d8:	48 85 c0             	test   %rax,%rax
ffff8000001069db:	74 3c                	je     ffff800000106a19 <fork+0x22f>
      np->ofile[i] = filedup(proc->ofile[i]);
ffff8000001069dd:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001069e4:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001069e8:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff8000001069eb:	48 63 d2             	movslq %edx,%rdx
ffff8000001069ee:	48 83 c2 08          	add    $0x8,%rdx
ffff8000001069f2:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff8000001069f7:	48 89 c7             	mov    %rax,%rdi
ffff8000001069fa:	48 b8 bb 1c 10 00 00 	movabs $0xffff800000101cbb,%rax
ffff800000106a01:	80 ff ff 
ffff800000106a04:	ff d0                	call   *%rax
ffff800000106a06:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000106a0a:	8b 4d ec             	mov    -0x14(%rbp),%ecx
ffff800000106a0d:	48 63 c9             	movslq %ecx,%rcx
ffff800000106a10:	48 83 c1 08          	add    $0x8,%rcx
ffff800000106a14:	48 89 44 ca 08       	mov    %rax,0x8(%rdx,%rcx,8)
  for(i = 0; i < NOFILE; i++)
ffff800000106a19:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
ffff800000106a1d:	83 7d ec 0f          	cmpl   $0xf,-0x14(%rbp)
ffff800000106a21:	7e 9b                	jle    ffff8000001069be <fork+0x1d4>
  np->cwd = idup(proc->cwd);
ffff800000106a23:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106a2a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106a2e:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffff800000106a35:	48 89 c7             	mov    %rax,%rdi
ffff800000106a38:	48 b8 85 29 10 00 00 	movabs $0xffff800000102985,%rax
ffff800000106a3f:	80 ff ff 
ffff800000106a42:	ff d0                	call   *%rax
ffff800000106a44:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000106a48:	48 89 82 c8 00 00 00 	mov    %rax,0xc8(%rdx)

  safestrcpy(np->name, proc->name, sizeof(proc->name));
ffff800000106a4f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106a56:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106a5a:	48 8d 88 d0 00 00 00 	lea    0xd0(%rax),%rcx
ffff800000106a61:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106a65:	48 05 d0 00 00 00    	add    $0xd0,%rax
ffff800000106a6b:	ba 10 00 00 00       	mov    $0x10,%edx
ffff800000106a70:	48 89 ce             	mov    %rcx,%rsi
ffff800000106a73:	48 89 c7             	mov    %rax,%rdi
ffff800000106a76:	48 b8 10 85 10 00 00 	movabs $0xffff800000108510,%rax
ffff800000106a7d:	80 ff ff 
ffff800000106a80:	ff d0                	call   *%rax

  pid = np->pid;
ffff800000106a82:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106a86:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff800000106a89:	89 45 dc             	mov    %eax,-0x24(%rbp)

  __sync_synchronize();
ffff800000106a8c:	f0 48 83 0c 24 00    	lock orq $0x0,(%rsp)
  np->state = RUNNABLE;
ffff800000106a92:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106a96:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)

  return pid;
ffff800000106a9d:	8b 45 dc             	mov    -0x24(%rbp),%eax
}
ffff800000106aa0:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
ffff800000106aa4:	c9                   	leave
ffff800000106aa5:	c3                   	ret

ffff800000106aa6 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
ffff800000106aa6:	f3 0f 1e fa          	endbr64
ffff800000106aaa:	55                   	push   %rbp
ffff800000106aab:	48 89 e5             	mov    %rsp,%rbp
ffff800000106aae:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
  struct proc *p;
  int fd;
  struct ipc_msg msg;

  if(proc == initproc)
ffff800000106ab5:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106abc:	64 48 8b 10          	mov    %fs:(%rax),%rdx
ffff800000106ac0:	48 b8 c8 f9 11 00 00 	movabs $0xffff80000011f9c8,%rax
ffff800000106ac7:	80 ff ff 
ffff800000106aca:	48 8b 00             	mov    (%rax),%rax
ffff800000106acd:	48 39 c2             	cmp    %rax,%rdx
ffff800000106ad0:	75 19                	jne    ffff800000106aeb <exit+0x45>
    panic("init exiting");
ffff800000106ad2:	48 b8 be d2 10 00 00 	movabs $0xffff80000010d2be,%rax
ffff800000106ad9:	80 ff ff 
ffff800000106adc:	48 89 c7             	mov    %rax,%rdi
ffff800000106adf:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000106ae6:	80 ff ff 
ffff800000106ae9:	ff d0                	call   *%rax

  // DONE(07-ipc-exit-wakeup): What: before closing resources, wake any process
  // blocked in send() because this process's mailbox was full, and define what
  // happens to an unread message in this process's mailbox. Why: a sender must
  // get a clean failure instead of sleeping forever after the receiver exits.
  if(fsserver_pid > 0 && fsserver_pid != proc->pid){
ffff800000106aeb:	48 b8 44 e5 10 00 00 	movabs $0xffff80000010e544,%rax
ffff800000106af2:	80 ff ff 
ffff800000106af5:	8b 00                	mov    (%rax),%eax
ffff800000106af7:	85 c0                	test   %eax,%eax
ffff800000106af9:	7e 6c                	jle    ffff800000106b67 <exit+0xc1>
ffff800000106afb:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106b02:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106b06:	8b 50 1c             	mov    0x1c(%rax),%edx
ffff800000106b09:	48 b8 44 e5 10 00 00 	movabs $0xffff80000010e544,%rax
ffff800000106b10:	80 ff ff 
ffff800000106b13:	8b 00                	mov    (%rax),%eax
ffff800000106b15:	39 c2                	cmp    %eax,%edx
ffff800000106b17:	74 4e                	je     ffff800000106b67 <exit+0xc1>
    memset(&msg, 0, sizeof(msg));
ffff800000106b19:	48 8d 85 10 ff ff ff 	lea    -0xf0(%rbp),%rax
ffff800000106b20:	ba e0 00 00 00       	mov    $0xe0,%edx
ffff800000106b25:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106b2a:	48 89 c7             	mov    %rax,%rdi
ffff800000106b2d:	48 b8 40 82 10 00 00 	movabs $0xffff800000108240,%rax
ffff800000106b34:	80 ff ff 
ffff800000106b37:	ff d0                	call   *%rax
    msg.type = IPC_TYPE_FS_CLIENT_EXIT;
ffff800000106b39:	c7 85 18 ff ff ff 66 	movl   $0x66,-0xe8(%rbp)
ffff800000106b40:	00 00 00 
    ipc_send_msg(fsserver_pid, &msg);
ffff800000106b43:	48 b8 44 e5 10 00 00 	movabs $0xffff80000010e544,%rax
ffff800000106b4a:	80 ff ff 
ffff800000106b4d:	8b 00                	mov    (%rax),%eax
ffff800000106b4f:	48 8d 95 10 ff ff ff 	lea    -0xf0(%rbp),%rdx
ffff800000106b56:	48 89 d6             	mov    %rdx,%rsi
ffff800000106b59:	89 c7                	mov    %eax,%edi
ffff800000106b5b:	48 b8 8d 77 10 00 00 	movabs $0xffff80000010778d,%rax
ffff800000106b62:	80 ff ff 
ffff800000106b65:	ff d0                	call   *%rax
  }

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
ffff800000106b67:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
ffff800000106b6e:	eb 6a                	jmp    ffff800000106bda <exit+0x134>
    if(proc->ofile[fd]){
ffff800000106b70:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106b77:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106b7b:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff800000106b7e:	48 63 d2             	movslq %edx,%rdx
ffff800000106b81:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106b85:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff800000106b8a:	48 85 c0             	test   %rax,%rax
ffff800000106b8d:	74 47                	je     ffff800000106bd6 <exit+0x130>
      fileclose(proc->ofile[fd]);
ffff800000106b8f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106b96:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106b9a:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff800000106b9d:	48 63 d2             	movslq %edx,%rdx
ffff800000106ba0:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106ba4:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff800000106ba9:	48 89 c7             	mov    %rax,%rdi
ffff800000106bac:	48 b8 38 1d 10 00 00 	movabs $0xffff800000101d38,%rax
ffff800000106bb3:	80 ff ff 
ffff800000106bb6:	ff d0                	call   *%rax
      proc->ofile[fd] = 0;
ffff800000106bb8:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106bbf:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106bc3:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff800000106bc6:	48 63 d2             	movslq %edx,%rdx
ffff800000106bc9:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106bcd:	48 c7 44 d0 08 00 00 	movq   $0x0,0x8(%rax,%rdx,8)
ffff800000106bd4:	00 00 
  for(fd = 0; fd < NOFILE; fd++){
ffff800000106bd6:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
ffff800000106bda:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
ffff800000106bde:	7e 90                	jle    ffff800000106b70 <exit+0xca>
    }
  }

  begin_op();
ffff800000106be0:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106be5:	48 ba e8 50 10 00 00 	movabs $0xffff8000001050e8,%rdx
ffff800000106bec:	80 ff ff 
ffff800000106bef:	ff d2                	call   *%rdx
  iput(proc->cwd);
ffff800000106bf1:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106bf8:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106bfc:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffff800000106c03:	48 89 c7             	mov    %rax,%rdi
ffff800000106c06:	48 b8 e9 2b 10 00 00 	movabs $0xffff800000102be9,%rax
ffff800000106c0d:	80 ff ff 
ffff800000106c10:	ff d0                	call   *%rax
  end_op();
ffff800000106c12:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106c17:	48 ba d4 51 10 00 00 	movabs $0xffff8000001051d4,%rdx
ffff800000106c1e:	80 ff ff 
ffff800000106c21:	ff d2                	call   *%rdx
  proc->cwd = 0;
ffff800000106c23:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106c2a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106c2e:	48 c7 80 c8 00 00 00 	movq   $0x0,0xc8(%rax)
ffff800000106c35:	00 00 00 00 

  acquire(&ptable.lock);
ffff800000106c39:	48 b8 60 87 11 00 00 	movabs $0xffff800000118760,%rax
ffff800000106c40:	80 ff ff 
ffff800000106c43:	48 89 c7             	mov    %rax,%rdi
ffff800000106c46:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff800000106c4d:	80 ff ff 
ffff800000106c50:	ff d0                	call   *%rax

  if(fsserver_pid == proc->pid)
ffff800000106c52:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106c59:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106c5d:	8b 50 1c             	mov    0x1c(%rax),%edx
ffff800000106c60:	48 b8 44 e5 10 00 00 	movabs $0xffff80000010e544,%rax
ffff800000106c67:	80 ff ff 
ffff800000106c6a:	8b 00                	mov    (%rax),%eax
ffff800000106c6c:	39 c2                	cmp    %eax,%edx
ffff800000106c6e:	75 10                	jne    ffff800000106c80 <exit+0x1da>
    fsserver_pid = -1;
ffff800000106c70:	48 b8 44 e5 10 00 00 	movabs $0xffff80000010e544,%rax
ffff800000106c77:	80 ff ff 
ffff800000106c7a:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%rax)

  proc->has_msg = 0;
ffff800000106c80:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106c87:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106c8b:	c7 80 c0 01 00 00 00 	movl   $0x0,0x1c0(%rax)
ffff800000106c92:	00 00 00 
  memset(&proc->mailbox, 0, sizeof(proc->mailbox));
ffff800000106c95:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106c9c:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106ca0:	48 05 e0 00 00 00    	add    $0xe0,%rax
ffff800000106ca6:	ba e0 00 00 00       	mov    $0xe0,%edx
ffff800000106cab:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106cb0:	48 89 c7             	mov    %rax,%rdi
ffff800000106cb3:	48 b8 40 82 10 00 00 	movabs $0xffff800000108240,%rax
ffff800000106cba:	80 ff ff 
ffff800000106cbd:	ff d0                	call   *%rax
  wakeup1(&proc->has_msg);
ffff800000106cbf:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106cc6:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106cca:	48 05 c0 01 00 00    	add    $0x1c0,%rax
ffff800000106cd0:	48 89 c7             	mov    %rax,%rdi
ffff800000106cd3:	48 b8 a6 73 10 00 00 	movabs $0xffff8000001073a6,%rax
ffff800000106cda:	80 ff ff 
ffff800000106cdd:	ff d0                	call   *%rax

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
ffff800000106cdf:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106ce6:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106cea:	48 8b 40 20          	mov    0x20(%rax),%rax
ffff800000106cee:	48 89 c7             	mov    %rax,%rdi
ffff800000106cf1:	48 b8 a6 73 10 00 00 	movabs $0xffff8000001073a6,%rax
ffff800000106cf8:	80 ff ff 
ffff800000106cfb:	ff d0                	call   *%rax

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106cfd:	48 b8 c8 87 11 00 00 	movabs $0xffff8000001187c8,%rax
ffff800000106d04:	80 ff ff 
ffff800000106d07:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000106d0b:	eb 5d                	jmp    ffff800000106d6a <exit+0x2c4>
    if(p->parent == proc){
ffff800000106d0d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106d11:	48 8b 50 20          	mov    0x20(%rax),%rdx
ffff800000106d15:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106d1c:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106d20:	48 39 c2             	cmp    %rax,%rdx
ffff800000106d23:	75 3d                	jne    ffff800000106d62 <exit+0x2bc>
      p->parent = initproc;
ffff800000106d25:	48 b8 c8 f9 11 00 00 	movabs $0xffff80000011f9c8,%rax
ffff800000106d2c:	80 ff ff 
ffff800000106d2f:	48 8b 10             	mov    (%rax),%rdx
ffff800000106d32:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106d36:	48 89 50 20          	mov    %rdx,0x20(%rax)
      if(p->state == ZOMBIE)
ffff800000106d3a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106d3e:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106d41:	83 f8 05             	cmp    $0x5,%eax
ffff800000106d44:	75 1c                	jne    ffff800000106d62 <exit+0x2bc>
        wakeup1(initproc);
ffff800000106d46:	48 b8 c8 f9 11 00 00 	movabs $0xffff80000011f9c8,%rax
ffff800000106d4d:	80 ff ff 
ffff800000106d50:	48 8b 00             	mov    (%rax),%rax
ffff800000106d53:	48 89 c7             	mov    %rax,%rdi
ffff800000106d56:	48 b8 a6 73 10 00 00 	movabs $0xffff8000001073a6,%rax
ffff800000106d5d:	80 ff ff 
ffff800000106d60:	ff d0                	call   *%rax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106d62:	48 81 45 f8 c8 01 00 	addq   $0x1c8,-0x8(%rbp)
ffff800000106d69:	00 
ffff800000106d6a:	48 b8 c8 f9 11 00 00 	movabs $0xffff80000011f9c8,%rax
ffff800000106d71:	80 ff ff 
ffff800000106d74:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000106d78:	72 93                	jb     ffff800000106d0d <exit+0x267>
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
ffff800000106d7a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106d81:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106d85:	c7 40 18 05 00 00 00 	movl   $0x5,0x18(%rax)
  sched();
ffff800000106d8c:	48 b8 ab 70 10 00 00 	movabs $0xffff8000001070ab,%rax
ffff800000106d93:	80 ff ff 
ffff800000106d96:	ff d0                	call   *%rax
  panic("zombie exit");
ffff800000106d98:	48 b8 cb d2 10 00 00 	movabs $0xffff80000010d2cb,%rax
ffff800000106d9f:	80 ff ff 
ffff800000106da2:	48 89 c7             	mov    %rax,%rdi
ffff800000106da5:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000106dac:	80 ff ff 
ffff800000106daf:	ff d0                	call   *%rax

ffff800000106db1 <wait>:
//PAGEBREAK!
// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
ffff800000106db1:	f3 0f 1e fa          	endbr64
ffff800000106db5:	55                   	push   %rbp
ffff800000106db6:	48 89 e5             	mov    %rsp,%rbp
ffff800000106db9:	48 83 ec 10          	sub    $0x10,%rsp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
ffff800000106dbd:	48 b8 60 87 11 00 00 	movabs $0xffff800000118760,%rax
ffff800000106dc4:	80 ff ff 
ffff800000106dc7:	48 89 c7             	mov    %rax,%rdi
ffff800000106dca:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff800000106dd1:	80 ff ff 
ffff800000106dd4:	ff d0                	call   *%rax
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
ffff800000106dd6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106ddd:	48 b8 c8 87 11 00 00 	movabs $0xffff8000001187c8,%rax
ffff800000106de4:	80 ff ff 
ffff800000106de7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000106deb:	e9 0a 01 00 00       	jmp    ffff800000106efa <wait+0x149>
      if(p->parent != proc)
ffff800000106df0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106df4:	48 8b 50 20          	mov    0x20(%rax),%rdx
ffff800000106df8:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106dff:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106e03:	48 39 c2             	cmp    %rax,%rdx
ffff800000106e06:	0f 85 e5 00 00 00    	jne    ffff800000106ef1 <wait+0x140>
        continue;
      havekids = 1;
ffff800000106e0c:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
      if(p->state == ZOMBIE){
ffff800000106e13:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106e17:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106e1a:	83 f8 05             	cmp    $0x5,%eax
ffff800000106e1d:	0f 85 cf 00 00 00    	jne    ffff800000106ef2 <wait+0x141>
        // Found one.
        pid = p->pid;
ffff800000106e23:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106e27:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff800000106e2a:	89 45 f0             	mov    %eax,-0x10(%rbp)
        kfree(p->kstack);
ffff800000106e2d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106e31:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000106e35:	48 89 c7             	mov    %rax,%rdi
ffff800000106e38:	48 b8 75 42 10 00 00 	movabs $0xffff800000104275,%rax
ffff800000106e3f:	80 ff ff 
ffff800000106e42:	ff d0                	call   *%rax
        p->kstack = 0;
ffff800000106e44:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106e48:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff800000106e4f:	00 
        freevm(p->pgdir);
ffff800000106e50:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106e54:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000106e58:	48 89 c7             	mov    %rax,%rdi
ffff800000106e5b:	48 b8 db c8 10 00 00 	movabs $0xffff80000010c8db,%rax
ffff800000106e62:	80 ff ff 
ffff800000106e65:	ff d0                	call   *%rax
        p->pid = 0;
ffff800000106e67:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106e6b:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%rax)
        p->parent = 0;
ffff800000106e72:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106e76:	48 c7 40 20 00 00 00 	movq   $0x0,0x20(%rax)
ffff800000106e7d:	00 
        p->name[0] = 0;
ffff800000106e7e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106e82:	c6 80 d0 00 00 00 00 	movb   $0x0,0xd0(%rax)
        p->killed = 0;
ffff800000106e89:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106e8d:	c7 40 40 00 00 00 00 	movl   $0x0,0x40(%rax)
        // DONE(05-ipc-state-owner): What: clear p->mailbox and p->has_msg
        // before marking this slot UNUSED. Why: this is the cleanup half of the
        // allocproc() initialization work and prevents IPC state from leaking
        // across process lifetimes.
        memset(&p->mailbox, 0, sizeof(p->mailbox));
ffff800000106e94:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106e98:	48 05 e0 00 00 00    	add    $0xe0,%rax
ffff800000106e9e:	ba e0 00 00 00       	mov    $0xe0,%edx
ffff800000106ea3:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106ea8:	48 89 c7             	mov    %rax,%rdi
ffff800000106eab:	48 b8 40 82 10 00 00 	movabs $0xffff800000108240,%rax
ffff800000106eb2:	80 ff ff 
ffff800000106eb5:	ff d0                	call   *%rax
        p->has_msg = 0;
ffff800000106eb7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106ebb:	c7 80 c0 01 00 00 00 	movl   $0x0,0x1c0(%rax)
ffff800000106ec2:	00 00 00 
        p->state = UNUSED;
ffff800000106ec5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106ec9:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
        release(&ptable.lock);
ffff800000106ed0:	48 b8 60 87 11 00 00 	movabs $0xffff800000118760,%rax
ffff800000106ed7:	80 ff ff 
ffff800000106eda:	48 89 c7             	mov    %rax,%rdi
ffff800000106edd:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff800000106ee4:	80 ff ff 
ffff800000106ee7:	ff d0                	call   *%rax
        return pid;
ffff800000106ee9:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000106eec:	e9 81 00 00 00       	jmp    ffff800000106f72 <wait+0x1c1>
        continue;
ffff800000106ef1:	90                   	nop
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106ef2:	48 81 45 f8 c8 01 00 	addq   $0x1c8,-0x8(%rbp)
ffff800000106ef9:	00 
ffff800000106efa:	48 b8 c8 f9 11 00 00 	movabs $0xffff80000011f9c8,%rax
ffff800000106f01:	80 ff ff 
ffff800000106f04:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000106f08:	0f 82 e2 fe ff ff    	jb     ffff800000106df0 <wait+0x3f>
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
ffff800000106f0e:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
ffff800000106f12:	74 12                	je     ffff800000106f26 <wait+0x175>
ffff800000106f14:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106f1b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106f1f:	8b 40 40             	mov    0x40(%rax),%eax
ffff800000106f22:	85 c0                	test   %eax,%eax
ffff800000106f24:	74 20                	je     ffff800000106f46 <wait+0x195>
      release(&ptable.lock);
ffff800000106f26:	48 b8 60 87 11 00 00 	movabs $0xffff800000118760,%rax
ffff800000106f2d:	80 ff ff 
ffff800000106f30:	48 89 c7             	mov    %rax,%rdi
ffff800000106f33:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff800000106f3a:	80 ff ff 
ffff800000106f3d:	ff d0                	call   *%rax
      return -1;
ffff800000106f3f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000106f44:	eb 2c                	jmp    ffff800000106f72 <wait+0x1c1>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
ffff800000106f46:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106f4d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106f51:	48 ba 60 87 11 00 00 	movabs $0xffff800000118760,%rdx
ffff800000106f58:	80 ff ff 
ffff800000106f5b:	48 89 d6             	mov    %rdx,%rsi
ffff800000106f5e:	48 89 c7             	mov    %rax,%rdi
ffff800000106f61:	48 b8 8a 72 10 00 00 	movabs $0xffff80000010728a,%rax
ffff800000106f68:	80 ff ff 
ffff800000106f6b:	ff d0                	call   *%rax
    havekids = 0;
ffff800000106f6d:	e9 64 fe ff ff       	jmp    ffff800000106dd6 <wait+0x25>
  }
}
ffff800000106f72:	c9                   	leave
ffff800000106f73:	c3                   	ret

ffff800000106f74 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
ffff800000106f74:	f3 0f 1e fa          	endbr64
ffff800000106f78:	55                   	push   %rbp
ffff800000106f79:	48 89 e5             	mov    %rsp,%rbp
ffff800000106f7c:	48 83 ec 20          	sub    $0x20,%rsp
  int i = 0;
ffff800000106f80:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  struct proc *p;
  int skipped = 0;
ffff800000106f87:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
  for(;;){
    ++i;
ffff800000106f8e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    // Enable interrupts on this processor.
    sti();
ffff800000106f92:	48 b8 ab 63 10 00 00 	movabs $0xffff8000001063ab,%rax
ffff800000106f99:	80 ff ff 
ffff800000106f9c:	ff d0                	call   *%rax
    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
ffff800000106f9e:	48 b8 60 87 11 00 00 	movabs $0xffff800000118760,%rax
ffff800000106fa5:	80 ff ff 
ffff800000106fa8:	48 89 c7             	mov    %rax,%rdi
ffff800000106fab:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff800000106fb2:	80 ff ff 
ffff800000106fb5:	ff d0                	call   *%rax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106fb7:	48 b8 c8 87 11 00 00 	movabs $0xffff8000001187c8,%rax
ffff800000106fbe:	80 ff ff 
ffff800000106fc1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000106fc5:	e9 92 00 00 00       	jmp    ffff80000010705c <scheduler+0xe8>
      if(p->state != RUNNABLE) {
ffff800000106fca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106fce:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106fd1:	83 f8 03             	cmp    $0x3,%eax
ffff800000106fd4:	74 06                	je     ffff800000106fdc <scheduler+0x68>
        skipped++;
ffff800000106fd6:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
        continue;
ffff800000106fda:	eb 78                	jmp    ffff800000107054 <scheduler+0xe0>
      }
      skipped = 0;
ffff800000106fdc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
ffff800000106fe3:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106fea:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000106fee:	64 48 89 10          	mov    %rdx,%fs:(%rax)
      switchuvm(p);
ffff800000106ff2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106ff6:	48 89 c7             	mov    %rax,%rdi
ffff800000106ff9:	48 b8 85 c0 10 00 00 	movabs $0xffff80000010c085,%rax
ffff800000107000:	80 ff ff 
ffff800000107003:	ff d0                	call   *%rax
      p->state = RUNNING;
ffff800000107005:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107009:	c7 40 18 04 00 00 00 	movl   $0x4,0x18(%rax)
      swtch(&cpu->scheduler, p->context);
ffff800000107010:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107014:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff800000107018:	48 c7 c2 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rdx
ffff80000010701f:	64 48 8b 12          	mov    %fs:(%rdx),%rdx
ffff800000107023:	48 83 c2 08          	add    $0x8,%rdx
ffff800000107027:	48 89 c6             	mov    %rax,%rsi
ffff80000010702a:	48 89 d7             	mov    %rdx,%rdi
ffff80000010702d:	48 b8 ad 85 10 00 00 	movabs $0xffff8000001085ad,%rax
ffff800000107034:	80 ff ff 
ffff800000107037:	ff d0                	call   *%rax
      switchkvm();
ffff800000107039:	48 b8 99 c3 10 00 00 	movabs $0xffff80000010c399,%rax
ffff800000107040:	80 ff ff 
ffff800000107043:	ff d0                	call   *%rax

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
ffff800000107045:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010704c:	64 48 c7 00 00 00 00 	movq   $0x0,%fs:(%rax)
ffff800000107053:	00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000107054:	48 81 45 f0 c8 01 00 	addq   $0x1c8,-0x10(%rbp)
ffff80000010705b:	00 
ffff80000010705c:	48 b8 c8 f9 11 00 00 	movabs $0xffff80000011f9c8,%rax
ffff800000107063:	80 ff ff 
ffff800000107066:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff80000010706a:	0f 82 5a ff ff ff    	jb     ffff800000106fca <scheduler+0x56>
    }
    release(&ptable.lock);
ffff800000107070:	48 b8 60 87 11 00 00 	movabs $0xffff800000118760,%rax
ffff800000107077:	80 ff ff 
ffff80000010707a:	48 89 c7             	mov    %rax,%rdi
ffff80000010707d:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff800000107084:	80 ff ff 
ffff800000107087:	ff d0                	call   *%rax
    if (skipped > NPROC) {
ffff800000107089:	83 7d ec 40          	cmpl   $0x40,-0x14(%rbp)
ffff80000010708d:	0f 8e fb fe ff ff    	jle    ffff800000106f8e <scheduler+0x1a>
      hlt();
ffff800000107093:	48 b8 b7 63 10 00 00 	movabs $0xffff8000001063b7,%rax
ffff80000010709a:	80 ff ff 
ffff80000010709d:	ff d0                	call   *%rax
      skipped = 0;
ffff80000010709f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    ++i;
ffff8000001070a6:	e9 e3 fe ff ff       	jmp    ffff800000106f8e <scheduler+0x1a>

ffff8000001070ab <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
ffff8000001070ab:	f3 0f 1e fa          	endbr64
ffff8000001070af:	55                   	push   %rbp
ffff8000001070b0:	48 89 e5             	mov    %rsp,%rbp
ffff8000001070b3:	48 83 ec 10          	sub    $0x10,%rsp
  int intena;


  if(!holding(&ptable.lock))
ffff8000001070b7:	48 b8 60 87 11 00 00 	movabs $0xffff800000118760,%rax
ffff8000001070be:	80 ff ff 
ffff8000001070c1:	48 89 c7             	mov    %rax,%rdi
ffff8000001070c4:	48 b8 7c 80 10 00 00 	movabs $0xffff80000010807c,%rax
ffff8000001070cb:	80 ff ff 
ffff8000001070ce:	ff d0                	call   *%rax
ffff8000001070d0:	85 c0                	test   %eax,%eax
ffff8000001070d2:	75 19                	jne    ffff8000001070ed <sched+0x42>
    panic("sched ptable.lock");
ffff8000001070d4:	48 b8 d7 d2 10 00 00 	movabs $0xffff80000010d2d7,%rax
ffff8000001070db:	80 ff ff 
ffff8000001070de:	48 89 c7             	mov    %rax,%rdi
ffff8000001070e1:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff8000001070e8:	80 ff ff 
ffff8000001070eb:	ff d0                	call   *%rax
  if(cpu->ncli != 1)
ffff8000001070ed:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff8000001070f4:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001070f8:	8b 40 14             	mov    0x14(%rax),%eax
ffff8000001070fb:	83 f8 01             	cmp    $0x1,%eax
ffff8000001070fe:	74 19                	je     ffff800000107119 <sched+0x6e>
    panic("sched locks");
ffff800000107100:	48 b8 e9 d2 10 00 00 	movabs $0xffff80000010d2e9,%rax
ffff800000107107:	80 ff ff 
ffff80000010710a:	48 89 c7             	mov    %rax,%rdi
ffff80000010710d:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000107114:	80 ff ff 
ffff800000107117:	ff d0                	call   *%rax
  if(proc->state == RUNNING)
ffff800000107119:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107120:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107124:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000107127:	83 f8 04             	cmp    $0x4,%eax
ffff80000010712a:	75 19                	jne    ffff800000107145 <sched+0x9a>
    panic("sched running");
ffff80000010712c:	48 b8 f5 d2 10 00 00 	movabs $0xffff80000010d2f5,%rax
ffff800000107133:	80 ff ff 
ffff800000107136:	48 89 c7             	mov    %rax,%rdi
ffff800000107139:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000107140:	80 ff ff 
ffff800000107143:	ff d0                	call   *%rax
  if(readeflags()&FL_IF)
ffff800000107145:	48 b8 93 63 10 00 00 	movabs $0xffff800000106393,%rax
ffff80000010714c:	80 ff ff 
ffff80000010714f:	ff d0                	call   *%rax
ffff800000107151:	25 00 02 00 00       	and    $0x200,%eax
ffff800000107156:	48 85 c0             	test   %rax,%rax
ffff800000107159:	74 19                	je     ffff800000107174 <sched+0xc9>
    panic("sched interruptible");
ffff80000010715b:	48 b8 03 d3 10 00 00 	movabs $0xffff80000010d303,%rax
ffff800000107162:	80 ff ff 
ffff800000107165:	48 89 c7             	mov    %rax,%rdi
ffff800000107168:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010716f:	80 ff ff 
ffff800000107172:	ff d0                	call   *%rax
  intena = cpu->intena;
ffff800000107174:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff80000010717b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010717f:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000107182:	89 45 fc             	mov    %eax,-0x4(%rbp)
  swtch(&proc->context, cpu->scheduler);
ffff800000107185:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff80000010718c:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107190:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000107194:	48 c7 c2 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rdx
ffff80000010719b:	64 48 8b 12          	mov    %fs:(%rdx),%rdx
ffff80000010719f:	48 83 c2 30          	add    $0x30,%rdx
ffff8000001071a3:	48 89 c6             	mov    %rax,%rsi
ffff8000001071a6:	48 89 d7             	mov    %rdx,%rdi
ffff8000001071a9:	48 b8 ad 85 10 00 00 	movabs $0xffff8000001085ad,%rax
ffff8000001071b0:	80 ff ff 
ffff8000001071b3:	ff d0                	call   *%rax
  cpu->intena = intena;
ffff8000001071b5:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff8000001071bc:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001071c0:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001071c3:	89 50 18             	mov    %edx,0x18(%rax)
}
ffff8000001071c6:	90                   	nop
ffff8000001071c7:	c9                   	leave
ffff8000001071c8:	c3                   	ret

ffff8000001071c9 <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
ffff8000001071c9:	f3 0f 1e fa          	endbr64
ffff8000001071cd:	55                   	push   %rbp
ffff8000001071ce:	48 89 e5             	mov    %rsp,%rbp
  acquire(&ptable.lock);  //DOC: yieldlock
ffff8000001071d1:	48 b8 60 87 11 00 00 	movabs $0xffff800000118760,%rax
ffff8000001071d8:	80 ff ff 
ffff8000001071db:	48 89 c7             	mov    %rax,%rdi
ffff8000001071de:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff8000001071e5:	80 ff ff 
ffff8000001071e8:	ff d0                	call   *%rax
  proc->state = RUNNABLE;
ffff8000001071ea:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001071f1:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001071f5:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
  sched();
ffff8000001071fc:	48 b8 ab 70 10 00 00 	movabs $0xffff8000001070ab,%rax
ffff800000107203:	80 ff ff 
ffff800000107206:	ff d0                	call   *%rax
  release(&ptable.lock);
ffff800000107208:	48 b8 60 87 11 00 00 	movabs $0xffff800000118760,%rax
ffff80000010720f:	80 ff ff 
ffff800000107212:	48 89 c7             	mov    %rax,%rdi
ffff800000107215:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff80000010721c:	80 ff ff 
ffff80000010721f:	ff d0                	call   *%rax
}
ffff800000107221:	90                   	nop
ffff800000107222:	5d                   	pop    %rbp
ffff800000107223:	c3                   	ret

ffff800000107224 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
ffff800000107224:	f3 0f 1e fa          	endbr64
ffff800000107228:	55                   	push   %rbp
ffff800000107229:	48 89 e5             	mov    %rsp,%rbp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
ffff80000010722c:	48 b8 60 87 11 00 00 	movabs $0xffff800000118760,%rax
ffff800000107233:	80 ff ff 
ffff800000107236:	48 89 c7             	mov    %rax,%rdi
ffff800000107239:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff800000107240:	80 ff ff 
ffff800000107243:	ff d0                	call   *%rax

  if (first) {
ffff800000107245:	48 b8 48 e5 10 00 00 	movabs $0xffff80000010e548,%rax
ffff80000010724c:	80 ff ff 
ffff80000010724f:	8b 00                	mov    (%rax),%eax
ffff800000107251:	85 c0                	test   %eax,%eax
ffff800000107253:	74 32                	je     ffff800000107287 <forkret+0x63>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
ffff800000107255:	48 b8 48 e5 10 00 00 	movabs $0xffff80000010e548,%rax
ffff80000010725c:	80 ff ff 
ffff80000010725f:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    iinit(ROOTDEV);
ffff800000107265:	bf 01 00 00 00       	mov    $0x1,%edi
ffff80000010726a:	48 b8 43 25 10 00 00 	movabs $0xffff800000102543,%rax
ffff800000107271:	80 ff ff 
ffff800000107274:	ff d0                	call   *%rax
    initlog(ROOTDEV);
ffff800000107276:	bf 01 00 00 00       	mov    $0x1,%edi
ffff80000010727b:	48 b8 87 4d 10 00 00 	movabs $0xffff800000104d87,%rax
ffff800000107282:	80 ff ff 
ffff800000107285:	ff d0                	call   *%rax
  }

  // Return to "caller", actually trapret (see allocproc).
}
ffff800000107287:	90                   	nop
ffff800000107288:	5d                   	pop    %rbp
ffff800000107289:	c3                   	ret

ffff80000010728a <sleep>:
//PAGEBREAK!
// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
ffff80000010728a:	f3 0f 1e fa          	endbr64
ffff80000010728e:	55                   	push   %rbp
ffff80000010728f:	48 89 e5             	mov    %rsp,%rbp
ffff800000107292:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107296:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff80000010729a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(proc == 0)
ffff80000010729e:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001072a5:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001072a9:	48 85 c0             	test   %rax,%rax
ffff8000001072ac:	75 19                	jne    ffff8000001072c7 <sleep+0x3d>
    panic("sleep");
ffff8000001072ae:	48 b8 17 d3 10 00 00 	movabs $0xffff80000010d317,%rax
ffff8000001072b5:	80 ff ff 
ffff8000001072b8:	48 89 c7             	mov    %rax,%rdi
ffff8000001072bb:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff8000001072c2:	80 ff ff 
ffff8000001072c5:	ff d0                	call   *%rax

  if(lk == 0)
ffff8000001072c7:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff8000001072cc:	75 19                	jne    ffff8000001072e7 <sleep+0x5d>
    panic("sleep without lk");
ffff8000001072ce:	48 b8 1d d3 10 00 00 	movabs $0xffff80000010d31d,%rax
ffff8000001072d5:	80 ff ff 
ffff8000001072d8:	48 89 c7             	mov    %rax,%rdi
ffff8000001072db:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff8000001072e2:	80 ff ff 
ffff8000001072e5:	ff d0                	call   *%rax
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
ffff8000001072e7:	48 b8 60 87 11 00 00 	movabs $0xffff800000118760,%rax
ffff8000001072ee:	80 ff ff 
ffff8000001072f1:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff8000001072f5:	74 2c                	je     ffff800000107323 <sleep+0x99>
    acquire(&ptable.lock);  //DOC: sleeplock1
ffff8000001072f7:	48 b8 60 87 11 00 00 	movabs $0xffff800000118760,%rax
ffff8000001072fe:	80 ff ff 
ffff800000107301:	48 89 c7             	mov    %rax,%rdi
ffff800000107304:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff80000010730b:	80 ff ff 
ffff80000010730e:	ff d0                	call   *%rax
    release(lk);
ffff800000107310:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107314:	48 89 c7             	mov    %rax,%rdi
ffff800000107317:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff80000010731e:	80 ff ff 
ffff800000107321:	ff d0                	call   *%rax
  }

  // Go to sleep.
  proc->chan = chan;
ffff800000107323:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010732a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010732e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000107332:	48 89 50 38          	mov    %rdx,0x38(%rax)
  proc->state = SLEEPING;
ffff800000107336:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010733d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107341:	c7 40 18 02 00 00 00 	movl   $0x2,0x18(%rax)
  sched();
ffff800000107348:	48 b8 ab 70 10 00 00 	movabs $0xffff8000001070ab,%rax
ffff80000010734f:	80 ff ff 
ffff800000107352:	ff d0                	call   *%rax

  // Tidy up.
  proc->chan = 0;
ffff800000107354:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010735b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010735f:	48 c7 40 38 00 00 00 	movq   $0x0,0x38(%rax)
ffff800000107366:	00 

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
ffff800000107367:	48 b8 60 87 11 00 00 	movabs $0xffff800000118760,%rax
ffff80000010736e:	80 ff ff 
ffff800000107371:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff800000107375:	74 2c                	je     ffff8000001073a3 <sleep+0x119>
    release(&ptable.lock);
ffff800000107377:	48 b8 60 87 11 00 00 	movabs $0xffff800000118760,%rax
ffff80000010737e:	80 ff ff 
ffff800000107381:	48 89 c7             	mov    %rax,%rdi
ffff800000107384:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff80000010738b:	80 ff ff 
ffff80000010738e:	ff d0                	call   *%rax
    acquire(lk);
ffff800000107390:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107394:	48 89 c7             	mov    %rax,%rdi
ffff800000107397:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff80000010739e:	80 ff ff 
ffff8000001073a1:	ff d0                	call   *%rax
  }
}
ffff8000001073a3:	90                   	nop
ffff8000001073a4:	c9                   	leave
ffff8000001073a5:	c3                   	ret

ffff8000001073a6 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
ffff8000001073a6:	f3 0f 1e fa          	endbr64
ffff8000001073aa:	55                   	push   %rbp
ffff8000001073ab:	48 89 e5             	mov    %rsp,%rbp
ffff8000001073ae:	48 83 ec 18          	sub    $0x18,%rsp
ffff8000001073b2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffff8000001073b6:	48 b8 c8 87 11 00 00 	movabs $0xffff8000001187c8,%rax
ffff8000001073bd:	80 ff ff 
ffff8000001073c0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001073c4:	eb 2d                	jmp    ffff8000001073f3 <wakeup1+0x4d>
    if(p->state == SLEEPING && p->chan == chan)
ffff8000001073c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001073ca:	8b 40 18             	mov    0x18(%rax),%eax
ffff8000001073cd:	83 f8 02             	cmp    $0x2,%eax
ffff8000001073d0:	75 19                	jne    ffff8000001073eb <wakeup1+0x45>
ffff8000001073d2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001073d6:	48 8b 40 38          	mov    0x38(%rax),%rax
ffff8000001073da:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffff8000001073de:	75 0b                	jne    ffff8000001073eb <wakeup1+0x45>
      p->state = RUNNABLE;
ffff8000001073e0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001073e4:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffff8000001073eb:	48 81 45 f8 c8 01 00 	addq   $0x1c8,-0x8(%rbp)
ffff8000001073f2:	00 
ffff8000001073f3:	48 b8 c8 f9 11 00 00 	movabs $0xffff80000011f9c8,%rax
ffff8000001073fa:	80 ff ff 
ffff8000001073fd:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000107401:	72 c3                	jb     ffff8000001073c6 <wakeup1+0x20>
}
ffff800000107403:	90                   	nop
ffff800000107404:	90                   	nop
ffff800000107405:	c9                   	leave
ffff800000107406:	c3                   	ret

ffff800000107407 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
ffff800000107407:	f3 0f 1e fa          	endbr64
ffff80000010740b:	55                   	push   %rbp
ffff80000010740c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010740f:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107413:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&ptable.lock);
ffff800000107417:	48 b8 60 87 11 00 00 	movabs $0xffff800000118760,%rax
ffff80000010741e:	80 ff ff 
ffff800000107421:	48 89 c7             	mov    %rax,%rdi
ffff800000107424:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff80000010742b:	80 ff ff 
ffff80000010742e:	ff d0                	call   *%rax
  wakeup1(chan);
ffff800000107430:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107434:	48 89 c7             	mov    %rax,%rdi
ffff800000107437:	48 b8 a6 73 10 00 00 	movabs $0xffff8000001073a6,%rax
ffff80000010743e:	80 ff ff 
ffff800000107441:	ff d0                	call   *%rax
  release(&ptable.lock);
ffff800000107443:	48 b8 60 87 11 00 00 	movabs $0xffff800000118760,%rax
ffff80000010744a:	80 ff ff 
ffff80000010744d:	48 89 c7             	mov    %rax,%rdi
ffff800000107450:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff800000107457:	80 ff ff 
ffff80000010745a:	ff d0                	call   *%rax
}
ffff80000010745c:	90                   	nop
ffff80000010745d:	c9                   	leave
ffff80000010745e:	c3                   	ret

ffff80000010745f <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
ffff80000010745f:	f3 0f 1e fa          	endbr64
ffff800000107463:	55                   	push   %rbp
ffff800000107464:	48 89 e5             	mov    %rsp,%rbp
ffff800000107467:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010746b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  struct proc *p;

  acquire(&ptable.lock);
ffff80000010746e:	48 b8 60 87 11 00 00 	movabs $0xffff800000118760,%rax
ffff800000107475:	80 ff ff 
ffff800000107478:	48 89 c7             	mov    %rax,%rdi
ffff80000010747b:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff800000107482:	80 ff ff 
ffff800000107485:	ff d0                	call   *%rax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000107487:	48 b8 c8 87 11 00 00 	movabs $0xffff8000001187c8,%rax
ffff80000010748e:	80 ff ff 
ffff800000107491:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000107495:	eb 56                	jmp    ffff8000001074ed <kill+0x8e>
    if(p->pid == pid){
ffff800000107497:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010749b:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff80000010749e:	39 45 ec             	cmp    %eax,-0x14(%rbp)
ffff8000001074a1:	75 42                	jne    ffff8000001074e5 <kill+0x86>
      p->killed = 1;
ffff8000001074a3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001074a7:	c7 40 40 01 00 00 00 	movl   $0x1,0x40(%rax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
ffff8000001074ae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001074b2:	8b 40 18             	mov    0x18(%rax),%eax
ffff8000001074b5:	83 f8 02             	cmp    $0x2,%eax
ffff8000001074b8:	75 0b                	jne    ffff8000001074c5 <kill+0x66>
        p->state = RUNNABLE;
ffff8000001074ba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001074be:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
      release(&ptable.lock);
ffff8000001074c5:	48 b8 60 87 11 00 00 	movabs $0xffff800000118760,%rax
ffff8000001074cc:	80 ff ff 
ffff8000001074cf:	48 89 c7             	mov    %rax,%rdi
ffff8000001074d2:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff8000001074d9:	80 ff ff 
ffff8000001074dc:	ff d0                	call   *%rax
      return 0;
ffff8000001074de:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001074e3:	eb 36                	jmp    ffff80000010751b <kill+0xbc>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff8000001074e5:	48 81 45 f8 c8 01 00 	addq   $0x1c8,-0x8(%rbp)
ffff8000001074ec:	00 
ffff8000001074ed:	48 b8 c8 f9 11 00 00 	movabs $0xffff80000011f9c8,%rax
ffff8000001074f4:	80 ff ff 
ffff8000001074f7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff8000001074fb:	72 9a                	jb     ffff800000107497 <kill+0x38>
    }
  }
  release(&ptable.lock);
ffff8000001074fd:	48 b8 60 87 11 00 00 	movabs $0xffff800000118760,%rax
ffff800000107504:	80 ff ff 
ffff800000107507:	48 89 c7             	mov    %rax,%rdi
ffff80000010750a:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff800000107511:	80 ff ff 
ffff800000107514:	ff d0                	call   *%rax
  return -1;
ffff800000107516:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff80000010751b:	c9                   	leave
ffff80000010751c:	c3                   	ret

ffff80000010751d <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
ffff80000010751d:	f3 0f 1e fa          	endbr64
ffff800000107521:	55                   	push   %rbp
ffff800000107522:	48 89 e5             	mov    %rsp,%rbp
ffff800000107525:	48 83 ec 70          	sub    $0x70,%rsp
  int i;
  struct proc *p;
  char *state;
  addr_t pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000107529:	48 b8 c8 87 11 00 00 	movabs $0xffff8000001187c8,%rax
ffff800000107530:	80 ff ff 
ffff800000107533:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000107537:	e9 44 01 00 00       	jmp    ffff800000107680 <procdump+0x163>
    if(p->state == UNUSED)
ffff80000010753c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107540:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000107543:	85 c0                	test   %eax,%eax
ffff800000107545:	0f 84 2c 01 00 00    	je     ffff800000107677 <procdump+0x15a>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
ffff80000010754b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010754f:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000107552:	83 f8 05             	cmp    $0x5,%eax
ffff800000107555:	77 39                	ja     ffff800000107590 <procdump+0x73>
ffff800000107557:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010755b:	8b 50 18             	mov    0x18(%rax),%edx
ffff80000010755e:	48 b8 60 e5 10 00 00 	movabs $0xffff80000010e560,%rax
ffff800000107565:	80 ff ff 
ffff800000107568:	89 d2                	mov    %edx,%edx
ffff80000010756a:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
ffff80000010756e:	48 85 c0             	test   %rax,%rax
ffff800000107571:	74 1d                	je     ffff800000107590 <procdump+0x73>
      state = states[p->state];
ffff800000107573:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107577:	8b 50 18             	mov    0x18(%rax),%edx
ffff80000010757a:	48 b8 60 e5 10 00 00 	movabs $0xffff80000010e560,%rax
ffff800000107581:	80 ff ff 
ffff800000107584:	89 d2                	mov    %edx,%edx
ffff800000107586:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
ffff80000010758a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010758e:	eb 0e                	jmp    ffff80000010759e <procdump+0x81>
    else
      state = "???";
ffff800000107590:	48 b8 2e d3 10 00 00 	movabs $0xffff80000010d32e,%rax
ffff800000107597:	80 ff ff 
ffff80000010759a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    cprintf("%d %s %s", p->pid, state, p->name);
ffff80000010759e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001075a2:	48 8d 88 d0 00 00 00 	lea    0xd0(%rax),%rcx
ffff8000001075a9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001075ad:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff8000001075b0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff8000001075b4:	89 c6                	mov    %eax,%esi
ffff8000001075b6:	48 b8 32 d3 10 00 00 	movabs $0xffff80000010d332,%rax
ffff8000001075bd:	80 ff ff 
ffff8000001075c0:	48 89 c7             	mov    %rax,%rdi
ffff8000001075c3:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001075c8:	49 b8 38 08 10 00 00 	movabs $0xffff800000100838,%r8
ffff8000001075cf:	80 ff ff 
ffff8000001075d2:	41 ff d0             	call   *%r8
    if(p->state == SLEEPING){
ffff8000001075d5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001075d9:	8b 40 18             	mov    0x18(%rax),%eax
ffff8000001075dc:	83 f8 02             	cmp    $0x2,%eax
ffff8000001075df:	75 76                	jne    ffff800000107657 <procdump+0x13a>
      getstackpcs((addr_t*)p->context->rbp+2, pc);
ffff8000001075e1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001075e5:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff8000001075e9:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001075ed:	48 83 c0 10          	add    $0x10,%rax
ffff8000001075f1:	48 89 c2             	mov    %rax,%rdx
ffff8000001075f4:	48 8d 45 90          	lea    -0x70(%rbp),%rax
ffff8000001075f8:	48 89 c6             	mov    %rax,%rsi
ffff8000001075fb:	48 89 d7             	mov    %rdx,%rdi
ffff8000001075fe:	48 b8 de 7f 10 00 00 	movabs $0xffff800000107fde,%rax
ffff800000107605:	80 ff ff 
ffff800000107608:	ff d0                	call   *%rax
      for(i=0; i<10 && pc[i] != 0; i++)
ffff80000010760a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000107611:	eb 2f                	jmp    ffff800000107642 <procdump+0x125>
        cprintf(" %p", pc[i]);
ffff800000107613:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000107616:	48 98                	cltq
ffff800000107618:	48 8b 44 c5 90       	mov    -0x70(%rbp,%rax,8),%rax
ffff80000010761d:	48 89 c6             	mov    %rax,%rsi
ffff800000107620:	48 b8 3b d3 10 00 00 	movabs $0xffff80000010d33b,%rax
ffff800000107627:	80 ff ff 
ffff80000010762a:	48 89 c7             	mov    %rax,%rdi
ffff80000010762d:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000107632:	48 ba 38 08 10 00 00 	movabs $0xffff800000100838,%rdx
ffff800000107639:	80 ff ff 
ffff80000010763c:	ff d2                	call   *%rdx
      for(i=0; i<10 && pc[i] != 0; i++)
ffff80000010763e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000107642:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffff800000107646:	7f 0f                	jg     ffff800000107657 <procdump+0x13a>
ffff800000107648:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010764b:	48 98                	cltq
ffff80000010764d:	48 8b 44 c5 90       	mov    -0x70(%rbp,%rax,8),%rax
ffff800000107652:	48 85 c0             	test   %rax,%rax
ffff800000107655:	75 bc                	jne    ffff800000107613 <procdump+0xf6>
    }
    cprintf("\n");
ffff800000107657:	48 b8 3f d3 10 00 00 	movabs $0xffff80000010d33f,%rax
ffff80000010765e:	80 ff ff 
ffff800000107661:	48 89 c7             	mov    %rax,%rdi
ffff800000107664:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000107669:	48 ba 38 08 10 00 00 	movabs $0xffff800000100838,%rdx
ffff800000107670:	80 ff ff 
ffff800000107673:	ff d2                	call   *%rdx
ffff800000107675:	eb 01                	jmp    ffff800000107678 <procdump+0x15b>
      continue;
ffff800000107677:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000107678:	48 81 45 f0 c8 01 00 	addq   $0x1c8,-0x10(%rbp)
ffff80000010767f:	00 
ffff800000107680:	48 b8 c8 f9 11 00 00 	movabs $0xffff80000011f9c8,%rax
ffff800000107687:	80 ff ff 
ffff80000010768a:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff80000010768e:	0f 82 a8 fe ff ff    	jb     ffff80000010753c <procdump+0x1f>
  }
}
ffff800000107694:	90                   	nop
ffff800000107695:	90                   	nop
ffff800000107696:	c9                   	leave
ffff800000107697:	c3                   	ret

ffff800000107698 <valid_ipc_msg>:

static int
valid_ipc_msg(struct ipc_msg *msg)
{
ffff800000107698:	f3 0f 1e fa          	endbr64
ffff80000010769c:	55                   	push   %rbp
ffff80000010769d:	48 89 e5             	mov    %rsp,%rbp
ffff8000001076a0:	48 83 ec 08          	sub    $0x8,%rsp
ffff8000001076a4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
	if(msg->nbytes < 0 || msg->nbytes > IPC_DATA_SIZE)
ffff8000001076a8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001076ac:	8b 40 14             	mov    0x14(%rax),%eax
ffff8000001076af:	85 c0                	test   %eax,%eax
ffff8000001076b1:	78 0e                	js     ffff8000001076c1 <valid_ipc_msg+0x29>
ffff8000001076b3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001076b7:	8b 40 14             	mov    0x14(%rax),%eax
ffff8000001076ba:	3d 80 00 00 00       	cmp    $0x80,%eax
ffff8000001076bf:	7e 07                	jle    ffff8000001076c8 <valid_ipc_msg+0x30>
		return 0;
ffff8000001076c1:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001076c6:	eb 26                	jmp    ffff8000001076ee <valid_ipc_msg+0x56>
	switch(msg->type){
ffff8000001076c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001076cc:	8b 40 08             	mov    0x8(%rax),%eax
ffff8000001076cf:	83 f8 04             	cmp    $0x4,%eax
ffff8000001076d2:	7f 06                	jg     ffff8000001076da <valid_ipc_msg+0x42>
ffff8000001076d4:	85 c0                	test   %eax,%eax
ffff8000001076d6:	7f 0a                	jg     ffff8000001076e2 <valid_ipc_msg+0x4a>
ffff8000001076d8:	eb 0f                	jmp    ffff8000001076e9 <valid_ipc_msg+0x51>
ffff8000001076da:	83 e8 64             	sub    $0x64,%eax
ffff8000001076dd:	83 f8 02             	cmp    $0x2,%eax
ffff8000001076e0:	77 07                	ja     ffff8000001076e9 <valid_ipc_msg+0x51>
	case IPC_TYPE_FS_WRITE:
	case IPC_TYPE_FS_CLOSE:
	case IPC_TYPE_FS_REPLY:
	case IPC_TYPE_FS_SHUTDOWN:
	case IPC_TYPE_FS_CLIENT_EXIT:
		return 1;
ffff8000001076e2:	b8 01 00 00 00       	mov    $0x1,%eax
ffff8000001076e7:	eb 05                	jmp    ffff8000001076ee <valid_ipc_msg+0x56>
	default:
		return 0;
ffff8000001076e9:	b8 00 00 00 00       	mov    $0x0,%eax
	}
}
ffff8000001076ee:	c9                   	leave
ffff8000001076ef:	c3                   	ret

ffff8000001076f0 <register_fsserver>:

int
register_fsserver(void)
{
ffff8000001076f0:	f3 0f 1e fa          	endbr64
ffff8000001076f4:	55                   	push   %rbp
ffff8000001076f5:	48 89 e5             	mov    %rsp,%rbp
	acquire(&ptable.lock);
ffff8000001076f8:	48 b8 60 87 11 00 00 	movabs $0xffff800000118760,%rax
ffff8000001076ff:	80 ff ff 
ffff800000107702:	48 89 c7             	mov    %rax,%rdi
ffff800000107705:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff80000010770c:	80 ff ff 
ffff80000010770f:	ff d0                	call   *%rax
	fsserver_pid = proc->pid;
ffff800000107711:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107718:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010771c:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff80000010771f:	48 ba 44 e5 10 00 00 	movabs $0xffff80000010e544,%rdx
ffff800000107726:	80 ff ff 
ffff800000107729:	89 02                	mov    %eax,(%rdx)
	release(&ptable.lock);
ffff80000010772b:	48 b8 60 87 11 00 00 	movabs $0xffff800000118760,%rax
ffff800000107732:	80 ff ff 
ffff800000107735:	48 89 c7             	mov    %rax,%rdi
ffff800000107738:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff80000010773f:	80 ff ff 
ffff800000107742:	ff d0                	call   *%rax
	return 0;
ffff800000107744:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000107749:	5d                   	pop    %rbp
ffff80000010774a:	c3                   	ret

ffff80000010774b <get_fsserver_pid>:

int
get_fsserver_pid(void)
{
ffff80000010774b:	f3 0f 1e fa          	endbr64
ffff80000010774f:	55                   	push   %rbp
ffff800000107750:	48 89 e5             	mov    %rsp,%rbp
	return fsserver_pid;
ffff800000107753:	48 b8 44 e5 10 00 00 	movabs $0xffff80000010e544,%rax
ffff80000010775a:	80 ff ff 
ffff80000010775d:	8b 00                	mov    (%rax),%eax
}
ffff80000010775f:	5d                   	pop    %rbp
ffff800000107760:	c3                   	ret

ffff800000107761 <is_fsserver>:

int
is_fsserver(void)
{
ffff800000107761:	f3 0f 1e fa          	endbr64
ffff800000107765:	55                   	push   %rbp
ffff800000107766:	48 89 e5             	mov    %rsp,%rbp
	return fsserver_pid == proc->pid;
ffff800000107769:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107770:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107774:	8b 50 1c             	mov    0x1c(%rax),%edx
ffff800000107777:	48 b8 44 e5 10 00 00 	movabs $0xffff80000010e544,%rax
ffff80000010777e:	80 ff ff 
ffff800000107781:	8b 00                	mov    (%rax),%eax
ffff800000107783:	39 c2                	cmp    %eax,%edx
ffff800000107785:	0f 94 c0             	sete   %al
ffff800000107788:	0f b6 c0             	movzbl %al,%eax
}
ffff80000010778b:	5d                   	pop    %rbp
ffff80000010778c:	c3                   	ret

ffff80000010778d <ipc_send_msg>:

int
ipc_send_msg(int pid, struct ipc_msg *msg)
{
ffff80000010778d:	f3 0f 1e fa          	endbr64
ffff800000107791:	55                   	push   %rbp
ffff800000107792:	48 89 e5             	mov    %rsp,%rbp
ffff800000107795:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
ffff80000010779c:	89 bd 0c ff ff ff    	mov    %edi,-0xf4(%rbp)
ffff8000001077a2:	48 89 b5 00 ff ff ff 	mov    %rsi,-0x100(%rbp)
	struct proc *target_p;
	struct ipc_msg kmsg;

	if(msg == 0)
ffff8000001077a9:	48 83 bd 00 ff ff ff 	cmpq   $0x0,-0x100(%rbp)
ffff8000001077b0:	00 
ffff8000001077b1:	75 0a                	jne    ffff8000001077bd <ipc_send_msg+0x30>
		return -1;
ffff8000001077b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001077b8:	e9 1e 02 00 00       	jmp    ffff8000001079db <ipc_send_msg+0x24e>

	memmove(&kmsg, msg, sizeof(kmsg));
ffff8000001077bd:	48 8b 8d 00 ff ff ff 	mov    -0x100(%rbp),%rcx
ffff8000001077c4:	48 8d 85 10 ff ff ff 	lea    -0xf0(%rbp),%rax
ffff8000001077cb:	ba e0 00 00 00       	mov    $0xe0,%edx
ffff8000001077d0:	48 89 ce             	mov    %rcx,%rsi
ffff8000001077d3:	48 89 c7             	mov    %rax,%rdi
ffff8000001077d6:	48 b8 4d 83 10 00 00 	movabs $0xffff80000010834d,%rax
ffff8000001077dd:	80 ff ff 
ffff8000001077e0:	ff d0                	call   *%rax
	kmsg.sender_pid = proc->pid;
ffff8000001077e2:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001077e9:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001077ed:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff8000001077f0:	89 85 10 ff ff ff    	mov    %eax,-0xf0(%rbp)

	if(!valid_ipc_msg(&kmsg))
ffff8000001077f6:	48 8d 85 10 ff ff ff 	lea    -0xf0(%rbp),%rax
ffff8000001077fd:	48 89 c7             	mov    %rax,%rdi
ffff800000107800:	48 b8 98 76 10 00 00 	movabs $0xffff800000107698,%rax
ffff800000107807:	80 ff ff 
ffff80000010780a:	ff d0                	call   *%rax
ffff80000010780c:	85 c0                	test   %eax,%eax
ffff80000010780e:	75 0a                	jne    ffff80000010781a <ipc_send_msg+0x8d>
		return -1;
ffff800000107810:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000107815:	e9 c1 01 00 00       	jmp    ffff8000001079db <ipc_send_msg+0x24e>

	acquire(&ptable.lock);
ffff80000010781a:	48 b8 60 87 11 00 00 	movabs $0xffff800000118760,%rax
ffff800000107821:	80 ff ff 
ffff800000107824:	48 89 c7             	mov    %rax,%rdi
ffff800000107827:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff80000010782e:	80 ff ff 
ffff800000107831:	ff d0                	call   *%rax
	for (target_p = ptable.proc; target_p < &ptable.proc[NPROC]; target_p++) {
ffff800000107833:	48 b8 c8 87 11 00 00 	movabs $0xffff8000001187c8,%rax
ffff80000010783a:	80 ff ff 
ffff80000010783d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000107841:	eb 17                	jmp    ffff80000010785a <ipc_send_msg+0xcd>
		if (target_p->pid == pid) {
ffff800000107843:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107847:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff80000010784a:	39 85 0c ff ff ff    	cmp    %eax,-0xf4(%rbp)
ffff800000107850:	74 3b                	je     ffff80000010788d <ipc_send_msg+0x100>
	for (target_p = ptable.proc; target_p < &ptable.proc[NPROC]; target_p++) {
ffff800000107852:	48 81 45 f8 c8 01 00 	addq   $0x1c8,-0x8(%rbp)
ffff800000107859:	00 
ffff80000010785a:	48 b8 c8 f9 11 00 00 	movabs $0xffff80000011f9c8,%rax
ffff800000107861:	80 ff ff 
ffff800000107864:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000107868:	72 d9                	jb     ffff800000107843 <ipc_send_msg+0xb6>
			goto found;
		}
	}
	release(&ptable.lock);
ffff80000010786a:	48 b8 60 87 11 00 00 	movabs $0xffff800000118760,%rax
ffff800000107871:	80 ff ff 
ffff800000107874:	48 89 c7             	mov    %rax,%rdi
ffff800000107877:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff80000010787e:	80 ff ff 
ffff800000107881:	ff d0                	call   *%rax

	return -1;
ffff800000107883:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000107888:	e9 4e 01 00 00       	jmp    ffff8000001079db <ipc_send_msg+0x24e>
			goto found;
ffff80000010788d:	90                   	nop

found:
	// DONE(09-send-target-state): What: reject sends to UNUSED, EMBRYO, ZOMBIE,
	// or killed processes. Why: a PID match alone is not enough because the
	// target may be exiting or already dead while another process is sending.
	if(target_p->state == UNUSED || target_p->state == EMBRYO ||
ffff80000010788e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107892:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000107895:	85 c0                	test   %eax,%eax
ffff800000107897:	74 27                	je     ffff8000001078c0 <ipc_send_msg+0x133>
ffff800000107899:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010789d:	8b 40 18             	mov    0x18(%rax),%eax
ffff8000001078a0:	83 f8 01             	cmp    $0x1,%eax
ffff8000001078a3:	74 1b                	je     ffff8000001078c0 <ipc_send_msg+0x133>
	   target_p->state == ZOMBIE || target_p->killed){
ffff8000001078a5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001078a9:	8b 40 18             	mov    0x18(%rax),%eax
	if(target_p->state == UNUSED || target_p->state == EMBRYO ||
ffff8000001078ac:	83 f8 05             	cmp    $0x5,%eax
ffff8000001078af:	74 0f                	je     ffff8000001078c0 <ipc_send_msg+0x133>
	   target_p->state == ZOMBIE || target_p->killed){
ffff8000001078b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001078b5:	8b 40 40             	mov    0x40(%rax),%eax
ffff8000001078b8:	85 c0                	test   %eax,%eax
ffff8000001078ba:	0f 84 a0 00 00 00    	je     ffff800000107960 <ipc_send_msg+0x1d3>
		release(&ptable.lock);
ffff8000001078c0:	48 b8 60 87 11 00 00 	movabs $0xffff800000118760,%rax
ffff8000001078c7:	80 ff ff 
ffff8000001078ca:	48 89 c7             	mov    %rax,%rdi
ffff8000001078cd:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff8000001078d4:	80 ff ff 
ffff8000001078d7:	ff d0                	call   *%rax
		return -1;
ffff8000001078d9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001078de:	e9 f8 00 00 00       	jmp    ffff8000001079db <ipc_send_msg+0x24e>

	while(target_p->has_msg == 1){
		// DONE(10-send-blocking): What: if the target exits while this sender is
		// sleeping on target_p->has_msg, wake this sender and return -1. Why:
		// multi-client fsserver tests should fail cleanly instead of hanging.
		if(proc->killed || target_p->state == UNUSED ||
ffff8000001078e3:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001078ea:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001078ee:	8b 40 40             	mov    0x40(%rax),%eax
ffff8000001078f1:	85 c0                	test   %eax,%eax
ffff8000001078f3:	75 22                	jne    ffff800000107917 <ipc_send_msg+0x18a>
ffff8000001078f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001078f9:	8b 40 18             	mov    0x18(%rax),%eax
ffff8000001078fc:	85 c0                	test   %eax,%eax
ffff8000001078fe:	74 17                	je     ffff800000107917 <ipc_send_msg+0x18a>
		   target_p->state == ZOMBIE || target_p->killed){
ffff800000107900:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107904:	8b 40 18             	mov    0x18(%rax),%eax
		if(proc->killed || target_p->state == UNUSED ||
ffff800000107907:	83 f8 05             	cmp    $0x5,%eax
ffff80000010790a:	74 0b                	je     ffff800000107917 <ipc_send_msg+0x18a>
		   target_p->state == ZOMBIE || target_p->killed){
ffff80000010790c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107910:	8b 40 40             	mov    0x40(%rax),%eax
ffff800000107913:	85 c0                	test   %eax,%eax
ffff800000107915:	74 23                	je     ffff80000010793a <ipc_send_msg+0x1ad>
			release(&ptable.lock);
ffff800000107917:	48 b8 60 87 11 00 00 	movabs $0xffff800000118760,%rax
ffff80000010791e:	80 ff ff 
ffff800000107921:	48 89 c7             	mov    %rax,%rdi
ffff800000107924:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff80000010792b:	80 ff ff 
ffff80000010792e:	ff d0                	call   *%rax
			return -1;
ffff800000107930:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000107935:	e9 a1 00 00 00       	jmp    ffff8000001079db <ipc_send_msg+0x24e>
		}
		sleep(&target_p->has_msg, &ptable.lock); 
ffff80000010793a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010793e:	48 05 c0 01 00 00    	add    $0x1c0,%rax
ffff800000107944:	48 ba 60 87 11 00 00 	movabs $0xffff800000118760,%rdx
ffff80000010794b:	80 ff ff 
ffff80000010794e:	48 89 d6             	mov    %rdx,%rsi
ffff800000107951:	48 89 c7             	mov    %rax,%rdi
ffff800000107954:	48 b8 8a 72 10 00 00 	movabs $0xffff80000010728a,%rax
ffff80000010795b:	80 ff ff 
ffff80000010795e:	ff d0                	call   *%rax
	while(target_p->has_msg == 1){
ffff800000107960:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107964:	8b 80 c0 01 00 00    	mov    0x1c0(%rax),%eax
ffff80000010796a:	83 f8 01             	cmp    $0x1,%eax
ffff80000010796d:	0f 84 70 ff ff ff    	je     ffff8000001078e3 <ipc_send_msg+0x156>
	}

	memmove(&target_p->mailbox, &kmsg, sizeof(struct ipc_msg));
ffff800000107973:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107977:	48 8d 88 e0 00 00 00 	lea    0xe0(%rax),%rcx
ffff80000010797e:	48 8d 85 10 ff ff ff 	lea    -0xf0(%rbp),%rax
ffff800000107985:	ba e0 00 00 00       	mov    $0xe0,%edx
ffff80000010798a:	48 89 c6             	mov    %rax,%rsi
ffff80000010798d:	48 89 cf             	mov    %rcx,%rdi
ffff800000107990:	48 b8 4d 83 10 00 00 	movabs $0xffff80000010834d,%rax
ffff800000107997:	80 ff ff 
ffff80000010799a:	ff d0                	call   *%rax
	target_p->has_msg = 1;
ffff80000010799c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001079a0:	c7 80 c0 01 00 00 01 	movl   $0x1,0x1c0(%rax)
ffff8000001079a7:	00 00 00 

	// DONE(11-ipc-queue-policy): What: decide whether this one-slot mailbox is
	// enough for the final demo; if not, replace it with a bounded per-process
	// queue. Why: a real fsserver may receive requests from multiple clients and
	// should not be fragile under simple concurrency.
	wakeup1(target_p); 
ffff8000001079aa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001079ae:	48 89 c7             	mov    %rax,%rdi
ffff8000001079b1:	48 b8 a6 73 10 00 00 	movabs $0xffff8000001073a6,%rax
ffff8000001079b8:	80 ff ff 
ffff8000001079bb:	ff d0                	call   *%rax
	release(&ptable.lock);
ffff8000001079bd:	48 b8 60 87 11 00 00 	movabs $0xffff800000118760,%rax
ffff8000001079c4:	80 ff ff 
ffff8000001079c7:	48 89 c7             	mov    %rax,%rdi
ffff8000001079ca:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff8000001079d1:	80 ff ff 
ffff8000001079d4:	ff d0                	call   *%rax

	return 0;
ffff8000001079d6:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff8000001079db:	c9                   	leave
ffff8000001079dc:	c3                   	ret

ffff8000001079dd <send>:

int
send(int pid, void* msg) {
ffff8000001079dd:	f3 0f 1e fa          	endbr64
ffff8000001079e1:	55                   	push   %rbp
ffff8000001079e2:	48 89 e5             	mov    %rsp,%rbp
ffff8000001079e5:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
ffff8000001079ec:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
ffff8000001079f2:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)

	// DONE(08-send-validation): What: keep copyin() before taking ptable.lock,
	// then validate that msg points to a full struct ipc_msg and that the
	// requested message type is legal for the caller. Why: syscall rerouting
	// will depend on send() rejecting malformed or unauthorized FS messages.
	if (copyin(proc->pgdir, (void*)&kmsg, (addr_t)msg, sizeof(struct ipc_msg)) < 0) {
ffff8000001079f9:	48 8b 95 10 ff ff ff 	mov    -0xf0(%rbp),%rdx
ffff800000107a00:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107a07:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107a0b:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000107a0f:	48 8d b5 20 ff ff ff 	lea    -0xe0(%rbp),%rsi
ffff800000107a16:	b9 e0 00 00 00       	mov    $0xe0,%ecx
ffff800000107a1b:	48 89 c7             	mov    %rax,%rdi
ffff800000107a1e:	48 b8 7f ce 10 00 00 	movabs $0xffff80000010ce7f,%rax
ffff800000107a25:	80 ff ff 
ffff800000107a28:	ff d0                	call   *%rax
ffff800000107a2a:	85 c0                	test   %eax,%eax
ffff800000107a2c:	79 07                	jns    ffff800000107a35 <send+0x58>
		return -1;
ffff800000107a2e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000107a33:	eb 1e                	jmp    ffff800000107a53 <send+0x76>
	}

	return ipc_send_msg(pid, &kmsg);
ffff800000107a35:	48 8d 95 20 ff ff ff 	lea    -0xe0(%rbp),%rdx
ffff800000107a3c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
ffff800000107a42:	48 89 d6             	mov    %rdx,%rsi
ffff800000107a45:	89 c7                	mov    %eax,%edi
ffff800000107a47:	48 b8 8d 77 10 00 00 	movabs $0xffff80000010778d,%rax
ffff800000107a4e:	80 ff ff 
ffff800000107a51:	ff d0                	call   *%rax
}
ffff800000107a53:	c9                   	leave
ffff800000107a54:	c3                   	ret

ffff800000107a55 <ipc_recv_msg>:

int
ipc_recv_msg(struct ipc_msg *msg)
{
ffff800000107a55:	f3 0f 1e fa          	endbr64
ffff800000107a59:	55                   	push   %rbp
ffff800000107a5a:	48 89 e5             	mov    %rsp,%rbp
ffff800000107a5d:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
ffff800000107a64:	48 89 bd 18 ff ff ff 	mov    %rdi,-0xe8(%rbp)

	// DONE(06-recv-snapshot): What: copy proc->mailbox into a local kernel
	// variable while holding ptable.lock, then clear has_msg, release the lock,
	// and copy that local snapshot out to user space. Why: another sender should
	// not be able to overwrite proc->mailbox before copyout() finishes.
	if(msg == 0)
ffff800000107a6b:	48 83 bd 18 ff ff ff 	cmpq   $0x0,-0xe8(%rbp)
ffff800000107a72:	00 
ffff800000107a73:	75 0a                	jne    ffff800000107a7f <ipc_recv_msg+0x2a>
		return -1;
ffff800000107a75:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000107a7a:	e9 5e 01 00 00       	jmp    ffff800000107bdd <ipc_recv_msg+0x188>

	acquire(&ptable.lock);
ffff800000107a7f:	48 b8 60 87 11 00 00 	movabs $0xffff800000118760,%rax
ffff800000107a86:	80 ff ff 
ffff800000107a89:	48 89 c7             	mov    %rax,%rdi
ffff800000107a8c:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff800000107a93:	80 ff ff 
ffff800000107a96:	ff d0                	call   *%rax

	while(proc->has_msg == 0){
ffff800000107a98:	eb 5c                	jmp    ffff800000107af6 <ipc_recv_msg+0xa1>
		if(proc->killed){
ffff800000107a9a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107aa1:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107aa5:	8b 40 40             	mov    0x40(%rax),%eax
ffff800000107aa8:	85 c0                	test   %eax,%eax
ffff800000107aaa:	74 23                	je     ffff800000107acf <ipc_recv_msg+0x7a>
			release(&ptable.lock);
ffff800000107aac:	48 b8 60 87 11 00 00 	movabs $0xffff800000118760,%rax
ffff800000107ab3:	80 ff ff 
ffff800000107ab6:	48 89 c7             	mov    %rax,%rdi
ffff800000107ab9:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff800000107ac0:	80 ff ff 
ffff800000107ac3:	ff d0                	call   *%rax
			return -1;
ffff800000107ac5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000107aca:	e9 0e 01 00 00       	jmp    ffff800000107bdd <ipc_recv_msg+0x188>
		}
		sleep(proc, &ptable.lock);
ffff800000107acf:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107ad6:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107ada:	48 ba 60 87 11 00 00 	movabs $0xffff800000118760,%rdx
ffff800000107ae1:	80 ff ff 
ffff800000107ae4:	48 89 d6             	mov    %rdx,%rsi
ffff800000107ae7:	48 89 c7             	mov    %rax,%rdi
ffff800000107aea:	48 b8 8a 72 10 00 00 	movabs $0xffff80000010728a,%rax
ffff800000107af1:	80 ff ff 
ffff800000107af4:	ff d0                	call   *%rax
	while(proc->has_msg == 0){
ffff800000107af6:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107afd:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107b01:	8b 80 c0 01 00 00    	mov    0x1c0(%rax),%eax
ffff800000107b07:	85 c0                	test   %eax,%eax
ffff800000107b09:	74 8f                	je     ffff800000107a9a <ipc_recv_msg+0x45>
	}


	memmove(&kmsg, &proc->mailbox, sizeof(kmsg));
ffff800000107b0b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107b12:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107b16:	48 8d 88 e0 00 00 00 	lea    0xe0(%rax),%rcx
ffff800000107b1d:	48 8d 85 20 ff ff ff 	lea    -0xe0(%rbp),%rax
ffff800000107b24:	ba e0 00 00 00       	mov    $0xe0,%edx
ffff800000107b29:	48 89 ce             	mov    %rcx,%rsi
ffff800000107b2c:	48 89 c7             	mov    %rax,%rdi
ffff800000107b2f:	48 b8 4d 83 10 00 00 	movabs $0xffff80000010834d,%rax
ffff800000107b36:	80 ff ff 
ffff800000107b39:	ff d0                	call   *%rax
	proc->has_msg = 0;
ffff800000107b3b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107b42:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107b46:	c7 80 c0 01 00 00 00 	movl   $0x0,0x1c0(%rax)
ffff800000107b4d:	00 00 00 
	memset(&proc->mailbox, 0, sizeof(proc->mailbox));
ffff800000107b50:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107b57:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107b5b:	48 05 e0 00 00 00    	add    $0xe0,%rax
ffff800000107b61:	ba e0 00 00 00       	mov    $0xe0,%edx
ffff800000107b66:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000107b6b:	48 89 c7             	mov    %rax,%rdi
ffff800000107b6e:	48 b8 40 82 10 00 00 	movabs $0xffff800000108240,%rax
ffff800000107b75:	80 ff ff 
ffff800000107b78:	ff d0                	call   *%rax
	wakeup1(&proc->has_msg);
ffff800000107b7a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107b81:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107b85:	48 05 c0 01 00 00    	add    $0x1c0,%rax
ffff800000107b8b:	48 89 c7             	mov    %rax,%rdi
ffff800000107b8e:	48 b8 a6 73 10 00 00 	movabs $0xffff8000001073a6,%rax
ffff800000107b95:	80 ff ff 
ffff800000107b98:	ff d0                	call   *%rax
	release(&ptable.lock);
ffff800000107b9a:	48 b8 60 87 11 00 00 	movabs $0xffff800000118760,%rax
ffff800000107ba1:	80 ff ff 
ffff800000107ba4:	48 89 c7             	mov    %rax,%rdi
ffff800000107ba7:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff800000107bae:	80 ff ff 
ffff800000107bb1:	ff d0                	call   *%rax

	memmove(msg, &kmsg, sizeof(kmsg));
ffff800000107bb3:	48 8d 8d 20 ff ff ff 	lea    -0xe0(%rbp),%rcx
ffff800000107bba:	48 8b 85 18 ff ff ff 	mov    -0xe8(%rbp),%rax
ffff800000107bc1:	ba e0 00 00 00       	mov    $0xe0,%edx
ffff800000107bc6:	48 89 ce             	mov    %rcx,%rsi
ffff800000107bc9:	48 89 c7             	mov    %rax,%rdi
ffff800000107bcc:	48 b8 4d 83 10 00 00 	movabs $0xffff80000010834d,%rax
ffff800000107bd3:	80 ff ff 
ffff800000107bd6:	ff d0                	call   *%rax

	return 0;
ffff800000107bd8:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000107bdd:	c9                   	leave
ffff800000107bde:	c3                   	ret

ffff800000107bdf <recv>:

int
recv(void *msg) {
ffff800000107bdf:	f3 0f 1e fa          	endbr64
ffff800000107be3:	55                   	push   %rbp
ffff800000107be4:	48 89 e5             	mov    %rsp,%rbp
ffff800000107be7:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
ffff800000107bee:	48 89 bd 18 ff ff ff 	mov    %rdi,-0xe8(%rbp)
	struct ipc_msg kmsg;

	if(ipc_recv_msg(&kmsg) < 0)
ffff800000107bf5:	48 8d 85 20 ff ff ff 	lea    -0xe0(%rbp),%rax
ffff800000107bfc:	48 89 c7             	mov    %rax,%rdi
ffff800000107bff:	48 b8 55 7a 10 00 00 	movabs $0xffff800000107a55,%rax
ffff800000107c06:	80 ff ff 
ffff800000107c09:	ff d0                	call   *%rax
ffff800000107c0b:	85 c0                	test   %eax,%eax
ffff800000107c0d:	79 07                	jns    ffff800000107c16 <recv+0x37>
		return -1;
ffff800000107c0f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000107c14:	eb 41                	jmp    ffff800000107c57 <recv+0x78>

	if(copyout(proc->pgdir, (addr_t)msg, (char*)&kmsg, sizeof(struct ipc_msg)) < 0)
ffff800000107c16:	48 8b b5 18 ff ff ff 	mov    -0xe8(%rbp),%rsi
ffff800000107c1d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107c24:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107c28:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000107c2c:	48 8d 95 20 ff ff ff 	lea    -0xe0(%rbp),%rdx
ffff800000107c33:	b9 e0 00 00 00       	mov    $0xe0,%ecx
ffff800000107c38:	48 89 c7             	mov    %rax,%rdi
ffff800000107c3b:	48 b8 94 cd 10 00 00 	movabs $0xffff80000010cd94,%rax
ffff800000107c42:	80 ff ff 
ffff800000107c45:	ff d0                	call   *%rax
ffff800000107c47:	85 c0                	test   %eax,%eax
ffff800000107c49:	79 07                	jns    ffff800000107c52 <recv+0x73>
		return -1;
ffff800000107c4b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000107c50:	eb 05                	jmp    ffff800000107c57 <recv+0x78>

	return 0;
ffff800000107c52:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000107c57:	c9                   	leave
ffff800000107c58:	c3                   	ret

ffff800000107c59 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
ffff800000107c59:	f3 0f 1e fa          	endbr64
ffff800000107c5d:	55                   	push   %rbp
ffff800000107c5e:	48 89 e5             	mov    %rsp,%rbp
ffff800000107c61:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107c65:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107c69:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  initlock(&lk->lk, "sleep lock");
ffff800000107c6d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107c71:	48 83 c0 08          	add    $0x8,%rax
ffff800000107c75:	48 ba 6b d3 10 00 00 	movabs $0xffff80000010d36b,%rdx
ffff800000107c7c:	80 ff ff 
ffff800000107c7f:	48 89 d6             	mov    %rdx,%rsi
ffff800000107c82:	48 89 c7             	mov    %rax,%rdi
ffff800000107c85:	48 b8 4f 7e 10 00 00 	movabs $0xffff800000107e4f,%rax
ffff800000107c8c:	80 ff ff 
ffff800000107c8f:	ff d0                	call   *%rax
  lk->name = name;
ffff800000107c91:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107c95:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000107c99:	48 89 50 70          	mov    %rdx,0x70(%rax)
  lk->locked = 0;
ffff800000107c9d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107ca1:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  lk->pid = 0;
ffff800000107ca7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107cab:	c7 40 78 00 00 00 00 	movl   $0x0,0x78(%rax)
}
ffff800000107cb2:	90                   	nop
ffff800000107cb3:	c9                   	leave
ffff800000107cb4:	c3                   	ret

ffff800000107cb5 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
ffff800000107cb5:	f3 0f 1e fa          	endbr64
ffff800000107cb9:	55                   	push   %rbp
ffff800000107cba:	48 89 e5             	mov    %rsp,%rbp
ffff800000107cbd:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107cc1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&lk->lk);
ffff800000107cc5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107cc9:	48 83 c0 08          	add    $0x8,%rax
ffff800000107ccd:	48 89 c7             	mov    %rax,%rdi
ffff800000107cd0:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff800000107cd7:	80 ff ff 
ffff800000107cda:	ff d0                	call   *%rax
  while (lk->locked)
ffff800000107cdc:	eb 1e                	jmp    ffff800000107cfc <acquiresleep+0x47>
    sleep(lk, &lk->lk);
ffff800000107cde:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107ce2:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffff800000107ce6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107cea:	48 89 d6             	mov    %rdx,%rsi
ffff800000107ced:	48 89 c7             	mov    %rax,%rdi
ffff800000107cf0:	48 b8 8a 72 10 00 00 	movabs $0xffff80000010728a,%rax
ffff800000107cf7:	80 ff ff 
ffff800000107cfa:	ff d0                	call   *%rax
  while (lk->locked)
ffff800000107cfc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107d00:	8b 00                	mov    (%rax),%eax
ffff800000107d02:	85 c0                	test   %eax,%eax
ffff800000107d04:	75 d8                	jne    ffff800000107cde <acquiresleep+0x29>
  lk->locked = 1;
ffff800000107d06:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107d0a:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
  lk->pid = proc->pid;
ffff800000107d10:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107d17:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107d1b:	8b 50 1c             	mov    0x1c(%rax),%edx
ffff800000107d1e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107d22:	89 50 78             	mov    %edx,0x78(%rax)
  release(&lk->lk);
ffff800000107d25:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107d29:	48 83 c0 08          	add    $0x8,%rax
ffff800000107d2d:	48 89 c7             	mov    %rax,%rdi
ffff800000107d30:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff800000107d37:	80 ff ff 
ffff800000107d3a:	ff d0                	call   *%rax
}
ffff800000107d3c:	90                   	nop
ffff800000107d3d:	c9                   	leave
ffff800000107d3e:	c3                   	ret

ffff800000107d3f <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
ffff800000107d3f:	f3 0f 1e fa          	endbr64
ffff800000107d43:	55                   	push   %rbp
ffff800000107d44:	48 89 e5             	mov    %rsp,%rbp
ffff800000107d47:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107d4b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&lk->lk);
ffff800000107d4f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107d53:	48 83 c0 08          	add    $0x8,%rax
ffff800000107d57:	48 89 c7             	mov    %rax,%rdi
ffff800000107d5a:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff800000107d61:	80 ff ff 
ffff800000107d64:	ff d0                	call   *%rax
  lk->locked = 0;
ffff800000107d66:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107d6a:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  lk->pid = 0;
ffff800000107d70:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107d74:	c7 40 78 00 00 00 00 	movl   $0x0,0x78(%rax)
  wakeup(lk);
ffff800000107d7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107d7f:	48 89 c7             	mov    %rax,%rdi
ffff800000107d82:	48 b8 07 74 10 00 00 	movabs $0xffff800000107407,%rax
ffff800000107d89:	80 ff ff 
ffff800000107d8c:	ff d0                	call   *%rax
  release(&lk->lk);
ffff800000107d8e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107d92:	48 83 c0 08          	add    $0x8,%rax
ffff800000107d96:	48 89 c7             	mov    %rax,%rdi
ffff800000107d99:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff800000107da0:	80 ff ff 
ffff800000107da3:	ff d0                	call   *%rax
}
ffff800000107da5:	90                   	nop
ffff800000107da6:	c9                   	leave
ffff800000107da7:	c3                   	ret

ffff800000107da8 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
ffff800000107da8:	f3 0f 1e fa          	endbr64
ffff800000107dac:	55                   	push   %rbp
ffff800000107dad:	48 89 e5             	mov    %rsp,%rbp
ffff800000107db0:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000107db4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  acquire(&lk->lk);
ffff800000107db8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107dbc:	48 83 c0 08          	add    $0x8,%rax
ffff800000107dc0:	48 89 c7             	mov    %rax,%rdi
ffff800000107dc3:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff800000107dca:	80 ff ff 
ffff800000107dcd:	ff d0                	call   *%rax
  int r = lk->locked;
ffff800000107dcf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107dd3:	8b 00                	mov    (%rax),%eax
ffff800000107dd5:	89 45 fc             	mov    %eax,-0x4(%rbp)
  release(&lk->lk);
ffff800000107dd8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107ddc:	48 83 c0 08          	add    $0x8,%rax
ffff800000107de0:	48 89 c7             	mov    %rax,%rdi
ffff800000107de3:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff800000107dea:	80 ff ff 
ffff800000107ded:	ff d0                	call   *%rax
  return r;
ffff800000107def:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff800000107df2:	c9                   	leave
ffff800000107df3:	c3                   	ret

ffff800000107df4 <readeflags>:
  return lock->locked && lock->cpu == cpu;
}

// Pushcli/popcli are like cli/sti except that they are matched:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.
ffff800000107df4:	f3 0f 1e fa          	endbr64
ffff800000107df8:	55                   	push   %rbp
ffff800000107df9:	48 89 e5             	mov    %rsp,%rbp
ffff800000107dfc:	48 83 ec 10          	sub    $0x10,%rsp
void
pushcli(void)
ffff800000107e00:	9c                   	pushf
ffff800000107e01:	58                   	pop    %rax
ffff800000107e02:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
{
ffff800000107e06:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  int eflags;
ffff800000107e0a:	c9                   	leave
ffff800000107e0b:	c3                   	ret

ffff800000107e0c <cli>:

  eflags = readeflags();
  cli();
  if(cpu->ncli == 0)
ffff800000107e0c:	f3 0f 1e fa          	endbr64
ffff800000107e10:	55                   	push   %rbp
ffff800000107e11:	48 89 e5             	mov    %rsp,%rbp
    cpu->intena = eflags & FL_IF;
ffff800000107e14:	fa                   	cli
  cpu->ncli += 1;
ffff800000107e15:	90                   	nop
ffff800000107e16:	5d                   	pop    %rbp
ffff800000107e17:	c3                   	ret

ffff800000107e18 <sti>:
}

void
popcli(void)
ffff800000107e18:	f3 0f 1e fa          	endbr64
ffff800000107e1c:	55                   	push   %rbp
ffff800000107e1d:	48 89 e5             	mov    %rsp,%rbp
{
ffff800000107e20:	fb                   	sti
  if(readeflags()&FL_IF)
ffff800000107e21:	90                   	nop
ffff800000107e22:	5d                   	pop    %rbp
ffff800000107e23:	c3                   	ret

ffff800000107e24 <xchg>:
    sti();
}
ffff800000107e24:	f3 0f 1e fa          	endbr64
ffff800000107e28:	55                   	push   %rbp
ffff800000107e29:	48 89 e5             	mov    %rsp,%rbp
ffff800000107e2c:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000107e30:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107e34:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000107e38:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000107e3c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000107e40:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffff800000107e44:	f0 87 02             	lock xchg %eax,(%rdx)
ffff800000107e47:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000107e4a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000107e4d:	c9                   	leave
ffff800000107e4e:	c3                   	ret

ffff800000107e4f <initlock>:
{
ffff800000107e4f:	f3 0f 1e fa          	endbr64
ffff800000107e53:	55                   	push   %rbp
ffff800000107e54:	48 89 e5             	mov    %rsp,%rbp
ffff800000107e57:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107e5b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107e5f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  lk->name = name;
ffff800000107e63:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107e67:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000107e6b:	48 89 50 08          	mov    %rdx,0x8(%rax)
  lk->locked = 0;
ffff800000107e6f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107e73:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  lk->cpu = 0;
ffff800000107e79:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107e7d:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff800000107e84:	00 
}
ffff800000107e85:	90                   	nop
ffff800000107e86:	c9                   	leave
ffff800000107e87:	c3                   	ret

ffff800000107e88 <acquire>:
{
ffff800000107e88:	f3 0f 1e fa          	endbr64
ffff800000107e8c:	55                   	push   %rbp
ffff800000107e8d:	48 89 e5             	mov    %rsp,%rbp
ffff800000107e90:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107e94:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  pushcli(); // disable interrupts to avoid deadlock.
ffff800000107e98:	48 b8 bc 80 10 00 00 	movabs $0xffff8000001080bc,%rax
ffff800000107e9f:	80 ff ff 
ffff800000107ea2:	ff d0                	call   *%rax
  if(holding(lk))
ffff800000107ea4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107ea8:	48 89 c7             	mov    %rax,%rdi
ffff800000107eab:	48 b8 7c 80 10 00 00 	movabs $0xffff80000010807c,%rax
ffff800000107eb2:	80 ff ff 
ffff800000107eb5:	ff d0                	call   *%rax
ffff800000107eb7:	85 c0                	test   %eax,%eax
ffff800000107eb9:	74 19                	je     ffff800000107ed4 <acquire+0x4c>
    panic("acquire");
ffff800000107ebb:	48 b8 76 d3 10 00 00 	movabs $0xffff80000010d376,%rax
ffff800000107ec2:	80 ff ff 
ffff800000107ec5:	48 89 c7             	mov    %rax,%rdi
ffff800000107ec8:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000107ecf:	80 ff ff 
ffff800000107ed2:	ff d0                	call   *%rax
  while(xchg(&lk->locked, 1) != 0)
ffff800000107ed4:	90                   	nop
ffff800000107ed5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107ed9:	be 01 00 00 00       	mov    $0x1,%esi
ffff800000107ede:	48 89 c7             	mov    %rax,%rdi
ffff800000107ee1:	48 b8 24 7e 10 00 00 	movabs $0xffff800000107e24,%rax
ffff800000107ee8:	80 ff ff 
ffff800000107eeb:	ff d0                	call   *%rax
ffff800000107eed:	85 c0                	test   %eax,%eax
ffff800000107eef:	75 e4                	jne    ffff800000107ed5 <acquire+0x4d>
  __sync_synchronize();
ffff800000107ef1:	f0 48 83 0c 24 00    	lock orq $0x0,(%rsp)
  lk->cpu = cpu;
ffff800000107ef7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107efb:	48 c7 c2 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rdx
ffff800000107f02:	64 48 8b 12          	mov    %fs:(%rdx),%rdx
ffff800000107f06:	48 89 50 10          	mov    %rdx,0x10(%rax)
  getcallerpcs(&lk, lk->pcs);
ffff800000107f0a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107f0e:	48 8d 50 18          	lea    0x18(%rax),%rdx
ffff800000107f12:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff800000107f16:	48 89 d6             	mov    %rdx,%rsi
ffff800000107f19:	48 89 c7             	mov    %rax,%rdi
ffff800000107f1c:	48 b8 a6 7f 10 00 00 	movabs $0xffff800000107fa6,%rax
ffff800000107f23:	80 ff ff 
ffff800000107f26:	ff d0                	call   *%rax
}
ffff800000107f28:	90                   	nop
ffff800000107f29:	c9                   	leave
ffff800000107f2a:	c3                   	ret

ffff800000107f2b <release>:
{
ffff800000107f2b:	f3 0f 1e fa          	endbr64
ffff800000107f2f:	55                   	push   %rbp
ffff800000107f30:	48 89 e5             	mov    %rsp,%rbp
ffff800000107f33:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107f37:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  if(!holding(lk))
ffff800000107f3b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107f3f:	48 89 c7             	mov    %rax,%rdi
ffff800000107f42:	48 b8 7c 80 10 00 00 	movabs $0xffff80000010807c,%rax
ffff800000107f49:	80 ff ff 
ffff800000107f4c:	ff d0                	call   *%rax
ffff800000107f4e:	85 c0                	test   %eax,%eax
ffff800000107f50:	75 19                	jne    ffff800000107f6b <release+0x40>
    panic("release");
ffff800000107f52:	48 b8 7e d3 10 00 00 	movabs $0xffff80000010d37e,%rax
ffff800000107f59:	80 ff ff 
ffff800000107f5c:	48 89 c7             	mov    %rax,%rdi
ffff800000107f5f:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000107f66:	80 ff ff 
ffff800000107f69:	ff d0                	call   *%rax
  lk->pcs[0] = 0;
ffff800000107f6b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107f6f:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
ffff800000107f76:	00 
  lk->cpu = 0;
ffff800000107f77:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107f7b:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff800000107f82:	00 
  __sync_synchronize();
ffff800000107f83:	f0 48 83 0c 24 00    	lock orq $0x0,(%rsp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
ffff800000107f89:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107f8d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000107f91:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  popcli();
ffff800000107f97:	48 b8 2e 81 10 00 00 	movabs $0xffff80000010812e,%rax
ffff800000107f9e:	80 ff ff 
ffff800000107fa1:	ff d0                	call   *%rax
}
ffff800000107fa3:	90                   	nop
ffff800000107fa4:	c9                   	leave
ffff800000107fa5:	c3                   	ret

ffff800000107fa6 <getcallerpcs>:
{
ffff800000107fa6:	f3 0f 1e fa          	endbr64
ffff800000107faa:	55                   	push   %rbp
ffff800000107fab:	48 89 e5             	mov    %rsp,%rbp
ffff800000107fae:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000107fb2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107fb6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  asm volatile("mov %%rbp, %0" : "=r" (rbp));
ffff800000107fba:	48 89 e8             	mov    %rbp,%rax
ffff800000107fbd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  getstackpcs(rbp, pcs);
ffff800000107fc1:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000107fc5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107fc9:	48 89 d6             	mov    %rdx,%rsi
ffff800000107fcc:	48 89 c7             	mov    %rax,%rdi
ffff800000107fcf:	48 b8 de 7f 10 00 00 	movabs $0xffff800000107fde,%rax
ffff800000107fd6:	80 ff ff 
ffff800000107fd9:	ff d0                	call   *%rax
}
ffff800000107fdb:	90                   	nop
ffff800000107fdc:	c9                   	leave
ffff800000107fdd:	c3                   	ret

ffff800000107fde <getstackpcs>:
{
ffff800000107fde:	f3 0f 1e fa          	endbr64
ffff800000107fe2:	55                   	push   %rbp
ffff800000107fe3:	48 89 e5             	mov    %rsp,%rbp
ffff800000107fe6:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000107fea:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107fee:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  for(i = 0; i < 10; i++){
ffff800000107ff2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000107ff9:	eb 50                	jmp    ffff80000010804b <getstackpcs+0x6d>
    if(rbp == 0 || rbp < (addr_t*)KERNBASE || rbp == (addr_t*)0xffffffff)
ffff800000107ffb:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff800000108000:	74 70                	je     ffff800000108072 <getstackpcs+0x94>
ffff800000108002:	48 b8 ff ff ff ff ff 	movabs $0xffff7fffffffffff,%rax
ffff800000108009:	7f ff ff 
ffff80000010800c:	48 3b 45 e8          	cmp    -0x18(%rbp),%rax
ffff800000108010:	73 60                	jae    ffff800000108072 <getstackpcs+0x94>
ffff800000108012:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108017:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffff80000010801b:	74 55                	je     ffff800000108072 <getstackpcs+0x94>
    pcs[i] = rbp[1];     // saved %rip
ffff80000010801d:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000108020:	48 98                	cltq
ffff800000108022:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff800000108029:	00 
ffff80000010802a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010802e:	48 01 c2             	add    %rax,%rdx
ffff800000108031:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000108035:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000108039:	48 89 02             	mov    %rax,(%rdx)
    rbp = (addr_t*)rbp[0]; // saved %rbp
ffff80000010803c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000108040:	48 8b 00             	mov    (%rax),%rax
ffff800000108043:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  for(i = 0; i < 10; i++){
ffff800000108047:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff80000010804b:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffff80000010804f:	7e aa                	jle    ffff800000107ffb <getstackpcs+0x1d>
  for(; i < 10; i++)
ffff800000108051:	eb 1f                	jmp    ffff800000108072 <getstackpcs+0x94>
    pcs[i] = 0;
ffff800000108053:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000108056:	48 98                	cltq
ffff800000108058:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010805f:	00 
ffff800000108060:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000108064:	48 01 d0             	add    %rdx,%rax
ffff800000108067:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  for(; i < 10; i++)
ffff80000010806e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000108072:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffff800000108076:	7e db                	jle    ffff800000108053 <getstackpcs+0x75>
}
ffff800000108078:	90                   	nop
ffff800000108079:	90                   	nop
ffff80000010807a:	c9                   	leave
ffff80000010807b:	c3                   	ret

ffff80000010807c <holding>:
{
ffff80000010807c:	f3 0f 1e fa          	endbr64
ffff800000108080:	55                   	push   %rbp
ffff800000108081:	48 89 e5             	mov    %rsp,%rbp
ffff800000108084:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000108088:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  return lock->locked && lock->cpu == cpu;
ffff80000010808c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108090:	8b 00                	mov    (%rax),%eax
ffff800000108092:	85 c0                	test   %eax,%eax
ffff800000108094:	74 1f                	je     ffff8000001080b5 <holding+0x39>
ffff800000108096:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010809a:	48 8b 50 10          	mov    0x10(%rax),%rdx
ffff80000010809e:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff8000001080a5:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001080a9:	48 39 c2             	cmp    %rax,%rdx
ffff8000001080ac:	75 07                	jne    ffff8000001080b5 <holding+0x39>
ffff8000001080ae:	b8 01 00 00 00       	mov    $0x1,%eax
ffff8000001080b3:	eb 05                	jmp    ffff8000001080ba <holding+0x3e>
ffff8000001080b5:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff8000001080ba:	c9                   	leave
ffff8000001080bb:	c3                   	ret

ffff8000001080bc <pushcli>:
{
ffff8000001080bc:	f3 0f 1e fa          	endbr64
ffff8000001080c0:	55                   	push   %rbp
ffff8000001080c1:	48 89 e5             	mov    %rsp,%rbp
ffff8000001080c4:	48 83 ec 10          	sub    $0x10,%rsp
  eflags = readeflags();
ffff8000001080c8:	48 b8 f4 7d 10 00 00 	movabs $0xffff800000107df4,%rax
ffff8000001080cf:	80 ff ff 
ffff8000001080d2:	ff d0                	call   *%rax
ffff8000001080d4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  cli();
ffff8000001080d7:	48 b8 0c 7e 10 00 00 	movabs $0xffff800000107e0c,%rax
ffff8000001080de:	80 ff ff 
ffff8000001080e1:	ff d0                	call   *%rax
  if(cpu->ncli == 0)
ffff8000001080e3:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff8000001080ea:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001080ee:	8b 40 14             	mov    0x14(%rax),%eax
ffff8000001080f1:	85 c0                	test   %eax,%eax
ffff8000001080f3:	75 17                	jne    ffff80000010810c <pushcli+0x50>
    cpu->intena = eflags & FL_IF;
ffff8000001080f5:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff8000001080fc:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108100:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000108103:	81 e2 00 02 00 00    	and    $0x200,%edx
ffff800000108109:	89 50 18             	mov    %edx,0x18(%rax)
  cpu->ncli += 1;
ffff80000010810c:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000108113:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108117:	8b 50 14             	mov    0x14(%rax),%edx
ffff80000010811a:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000108121:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108125:	83 c2 01             	add    $0x1,%edx
ffff800000108128:	89 50 14             	mov    %edx,0x14(%rax)
}
ffff80000010812b:	90                   	nop
ffff80000010812c:	c9                   	leave
ffff80000010812d:	c3                   	ret

ffff80000010812e <popcli>:
{
ffff80000010812e:	f3 0f 1e fa          	endbr64
ffff800000108132:	55                   	push   %rbp
ffff800000108133:	48 89 e5             	mov    %rsp,%rbp
  if(readeflags()&FL_IF)
ffff800000108136:	48 b8 f4 7d 10 00 00 	movabs $0xffff800000107df4,%rax
ffff80000010813d:	80 ff ff 
ffff800000108140:	ff d0                	call   *%rax
ffff800000108142:	25 00 02 00 00       	and    $0x200,%eax
ffff800000108147:	48 85 c0             	test   %rax,%rax
ffff80000010814a:	74 19                	je     ffff800000108165 <popcli+0x37>
    panic("popcli - interruptible");
ffff80000010814c:	48 b8 86 d3 10 00 00 	movabs $0xffff80000010d386,%rax
ffff800000108153:	80 ff ff 
ffff800000108156:	48 89 c7             	mov    %rax,%rdi
ffff800000108159:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000108160:	80 ff ff 
ffff800000108163:	ff d0                	call   *%rax
  if(--cpu->ncli < 0)
ffff800000108165:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff80000010816c:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108170:	8b 50 14             	mov    0x14(%rax),%edx
ffff800000108173:	83 ea 01             	sub    $0x1,%edx
ffff800000108176:	89 50 14             	mov    %edx,0x14(%rax)
ffff800000108179:	8b 40 14             	mov    0x14(%rax),%eax
ffff80000010817c:	85 c0                	test   %eax,%eax
ffff80000010817e:	79 19                	jns    ffff800000108199 <popcli+0x6b>
    panic("popcli");
ffff800000108180:	48 b8 9d d3 10 00 00 	movabs $0xffff80000010d39d,%rax
ffff800000108187:	80 ff ff 
ffff80000010818a:	48 89 c7             	mov    %rax,%rdi
ffff80000010818d:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000108194:	80 ff ff 
ffff800000108197:	ff d0                	call   *%rax
  if(cpu->ncli == 0 && cpu->intena)
ffff800000108199:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff8000001081a0:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001081a4:	8b 40 14             	mov    0x14(%rax),%eax
ffff8000001081a7:	85 c0                	test   %eax,%eax
ffff8000001081a9:	75 1e                	jne    ffff8000001081c9 <popcli+0x9b>
ffff8000001081ab:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff8000001081b2:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001081b6:	8b 40 18             	mov    0x18(%rax),%eax
ffff8000001081b9:	85 c0                	test   %eax,%eax
ffff8000001081bb:	74 0c                	je     ffff8000001081c9 <popcli+0x9b>
    sti();
ffff8000001081bd:	48 b8 18 7e 10 00 00 	movabs $0xffff800000107e18,%rax
ffff8000001081c4:	80 ff ff 
ffff8000001081c7:	ff d0                	call   *%rax
}
ffff8000001081c9:	90                   	nop
ffff8000001081ca:	5d                   	pop    %rbp
ffff8000001081cb:	c3                   	ret

ffff8000001081cc <stosb>:
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
ffff8000001081cc:	f3 0f 1e fa          	endbr64
ffff8000001081d0:	55                   	push   %rbp
ffff8000001081d1:	48 89 e5             	mov    %rsp,%rbp
ffff8000001081d4:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001081d8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff8000001081dc:	89 75 f4             	mov    %esi,-0xc(%rbp)
ffff8000001081df:	89 55 f0             	mov    %edx,-0x10(%rbp)
    while(n-- > 0)
ffff8000001081e2:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff8000001081e6:	8b 55 f0             	mov    -0x10(%rbp),%edx
ffff8000001081e9:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff8000001081ec:	48 89 ce             	mov    %rcx,%rsi
ffff8000001081ef:	48 89 f7             	mov    %rsi,%rdi
ffff8000001081f2:	89 d1                	mov    %edx,%ecx
ffff8000001081f4:	fc                   	cld
ffff8000001081f5:	f3 aa                	rep stos %al,%es:(%rdi)
ffff8000001081f7:	89 ca                	mov    %ecx,%edx
ffff8000001081f9:	48 89 fe             	mov    %rdi,%rsi
ffff8000001081fc:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
ffff800000108200:	89 55 f0             	mov    %edx,-0x10(%rbp)
      *d++ = *s++;

  return dst;
}
ffff800000108203:	90                   	nop
ffff800000108204:	c9                   	leave
ffff800000108205:	c3                   	ret

ffff800000108206 <stosl>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
ffff800000108206:	f3 0f 1e fa          	endbr64
ffff80000010820a:	55                   	push   %rbp
ffff80000010820b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010820e:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000108212:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000108216:	89 75 f4             	mov    %esi,-0xc(%rbp)
ffff800000108219:	89 55 f0             	mov    %edx,-0x10(%rbp)
{
ffff80000010821c:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff800000108220:	8b 55 f0             	mov    -0x10(%rbp),%edx
ffff800000108223:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000108226:	48 89 ce             	mov    %rcx,%rsi
ffff800000108229:	48 89 f7             	mov    %rsi,%rdi
ffff80000010822c:	89 d1                	mov    %edx,%ecx
ffff80000010822e:	fc                   	cld
ffff80000010822f:	f3 ab                	rep stos %eax,%es:(%rdi)
ffff800000108231:	89 ca                	mov    %ecx,%edx
ffff800000108233:	48 89 fe             	mov    %rdi,%rsi
ffff800000108236:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
ffff80000010823a:	89 55 f0             	mov    %edx,-0x10(%rbp)
  return memmove(dst, src, n);
}

int
ffff80000010823d:	90                   	nop
ffff80000010823e:	c9                   	leave
ffff80000010823f:	c3                   	ret

ffff800000108240 <memset>:
{
ffff800000108240:	f3 0f 1e fa          	endbr64
ffff800000108244:	55                   	push   %rbp
ffff800000108245:	48 89 e5             	mov    %rsp,%rbp
ffff800000108248:	48 83 ec 18          	sub    $0x18,%rsp
ffff80000010824c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000108250:	89 75 f4             	mov    %esi,-0xc(%rbp)
ffff800000108253:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  if ((addr_t)dst%4 == 0 && n%4 == 0){
ffff800000108257:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010825b:	83 e0 03             	and    $0x3,%eax
ffff80000010825e:	48 85 c0             	test   %rax,%rax
ffff800000108261:	75 53                	jne    ffff8000001082b6 <memset+0x76>
ffff800000108263:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000108267:	83 e0 03             	and    $0x3,%eax
ffff80000010826a:	48 85 c0             	test   %rax,%rax
ffff80000010826d:	75 47                	jne    ffff8000001082b6 <memset+0x76>
    c &= 0xFF;
ffff80000010826f:	81 65 f4 ff 00 00 00 	andl   $0xff,-0xc(%rbp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
ffff800000108276:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010827a:	48 c1 e8 02          	shr    $0x2,%rax
ffff80000010827e:	89 c6                	mov    %eax,%esi
ffff800000108280:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000108283:	c1 e0 18             	shl    $0x18,%eax
ffff800000108286:	89 c2                	mov    %eax,%edx
ffff800000108288:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff80000010828b:	c1 e0 10             	shl    $0x10,%eax
ffff80000010828e:	09 c2                	or     %eax,%edx
ffff800000108290:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000108293:	c1 e0 08             	shl    $0x8,%eax
ffff800000108296:	09 d0                	or     %edx,%eax
ffff800000108298:	0b 45 f4             	or     -0xc(%rbp),%eax
ffff80000010829b:	89 c1                	mov    %eax,%ecx
ffff80000010829d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001082a1:	89 f2                	mov    %esi,%edx
ffff8000001082a3:	89 ce                	mov    %ecx,%esi
ffff8000001082a5:	48 89 c7             	mov    %rax,%rdi
ffff8000001082a8:	48 b8 06 82 10 00 00 	movabs $0xffff800000108206,%rax
ffff8000001082af:	80 ff ff 
ffff8000001082b2:	ff d0                	call   *%rax
ffff8000001082b4:	eb 1e                	jmp    ffff8000001082d4 <memset+0x94>
    stosb(dst, c, n);
ffff8000001082b6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001082ba:	89 c2                	mov    %eax,%edx
ffff8000001082bc:	8b 4d f4             	mov    -0xc(%rbp),%ecx
ffff8000001082bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001082c3:	89 ce                	mov    %ecx,%esi
ffff8000001082c5:	48 89 c7             	mov    %rax,%rdi
ffff8000001082c8:	48 b8 cc 81 10 00 00 	movabs $0xffff8000001081cc,%rax
ffff8000001082cf:	80 ff ff 
ffff8000001082d2:	ff d0                	call   *%rax
  return dst;
ffff8000001082d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff8000001082d8:	c9                   	leave
ffff8000001082d9:	c3                   	ret

ffff8000001082da <memcmp>:
{
ffff8000001082da:	f3 0f 1e fa          	endbr64
ffff8000001082de:	55                   	push   %rbp
ffff8000001082df:	48 89 e5             	mov    %rsp,%rbp
ffff8000001082e2:	48 83 ec 28          	sub    $0x28,%rsp
ffff8000001082e6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff8000001082ea:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff8000001082ee:	89 55 dc             	mov    %edx,-0x24(%rbp)
  s1 = v1;
ffff8000001082f1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001082f5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  s2 = v2;
ffff8000001082f9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001082fd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0){
ffff800000108301:	eb 34                	jmp    ffff800000108337 <memcmp+0x5d>
    if(*s1 != *s2)
ffff800000108303:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108307:	0f b6 10             	movzbl (%rax),%edx
ffff80000010830a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010830e:	0f b6 00             	movzbl (%rax),%eax
ffff800000108311:	38 c2                	cmp    %al,%dl
ffff800000108313:	74 18                	je     ffff80000010832d <memcmp+0x53>
      return *s1 - *s2;
ffff800000108315:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108319:	0f b6 00             	movzbl (%rax),%eax
ffff80000010831c:	0f b6 d0             	movzbl %al,%edx
ffff80000010831f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108323:	0f b6 00             	movzbl (%rax),%eax
ffff800000108326:	0f b6 c0             	movzbl %al,%eax
ffff800000108329:	29 c2                	sub    %eax,%edx
ffff80000010832b:	eb 1c                	jmp    ffff800000108349 <memcmp+0x6f>
    s1++, s2++;
ffff80000010832d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffff800000108332:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(n-- > 0){
ffff800000108337:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff80000010833a:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff80000010833d:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000108340:	85 c0                	test   %eax,%eax
ffff800000108342:	75 bf                	jne    ffff800000108303 <memcmp+0x29>
  return 0;
ffff800000108344:	ba 00 00 00 00       	mov    $0x0,%edx
}
ffff800000108349:	89 d0                	mov    %edx,%eax
ffff80000010834b:	c9                   	leave
ffff80000010834c:	c3                   	ret

ffff80000010834d <memmove>:
{
ffff80000010834d:	f3 0f 1e fa          	endbr64
ffff800000108351:	55                   	push   %rbp
ffff800000108352:	48 89 e5             	mov    %rsp,%rbp
ffff800000108355:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000108359:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010835d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000108361:	89 55 dc             	mov    %edx,-0x24(%rbp)
  s = src;
ffff800000108364:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000108368:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  d = dst;
ffff80000010836c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000108370:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  if(s < d && s + n > d){
ffff800000108374:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108378:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
ffff80000010837c:	73 63                	jae    ffff8000001083e1 <memmove+0x94>
ffff80000010837e:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffff800000108381:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108385:	48 01 d0             	add    %rdx,%rax
ffff800000108388:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff80000010838c:	73 53                	jae    ffff8000001083e1 <memmove+0x94>
    s += n;
ffff80000010838e:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000108391:	48 01 45 f8          	add    %rax,-0x8(%rbp)
    d += n;
ffff800000108395:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000108398:	48 01 45 f0          	add    %rax,-0x10(%rbp)
    while(n-- > 0)
ffff80000010839c:	eb 17                	jmp    ffff8000001083b5 <memmove+0x68>
      *--d = *--s;
ffff80000010839e:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
ffff8000001083a3:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
ffff8000001083a8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001083ac:	0f b6 10             	movzbl (%rax),%edx
ffff8000001083af:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001083b3:	88 10                	mov    %dl,(%rax)
    while(n-- > 0)
ffff8000001083b5:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff8000001083b8:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff8000001083bb:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff8000001083be:	85 c0                	test   %eax,%eax
ffff8000001083c0:	75 dc                	jne    ffff80000010839e <memmove+0x51>
  if(s < d && s + n > d){
ffff8000001083c2:	eb 2a                	jmp    ffff8000001083ee <memmove+0xa1>
      *d++ = *s++;
ffff8000001083c4:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001083c8:	48 8d 42 01          	lea    0x1(%rdx),%rax
ffff8000001083cc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001083d0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001083d4:	48 8d 48 01          	lea    0x1(%rax),%rcx
ffff8000001083d8:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
ffff8000001083dc:	0f b6 12             	movzbl (%rdx),%edx
ffff8000001083df:	88 10                	mov    %dl,(%rax)
    while(n-- > 0)
ffff8000001083e1:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff8000001083e4:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff8000001083e7:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff8000001083ea:	85 c0                	test   %eax,%eax
ffff8000001083ec:	75 d6                	jne    ffff8000001083c4 <memmove+0x77>
  return dst;
ffff8000001083ee:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
ffff8000001083f2:	c9                   	leave
ffff8000001083f3:	c3                   	ret

ffff8000001083f4 <memcpy>:
{
ffff8000001083f4:	f3 0f 1e fa          	endbr64
ffff8000001083f8:	55                   	push   %rbp
ffff8000001083f9:	48 89 e5             	mov    %rsp,%rbp
ffff8000001083fc:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000108400:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000108404:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff800000108408:	89 55 ec             	mov    %edx,-0x14(%rbp)
  return memmove(dst, src, n);
ffff80000010840b:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff80000010840e:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffff800000108412:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108416:	48 89 ce             	mov    %rcx,%rsi
ffff800000108419:	48 89 c7             	mov    %rax,%rdi
ffff80000010841c:	48 b8 4d 83 10 00 00 	movabs $0xffff80000010834d,%rax
ffff800000108423:	80 ff ff 
ffff800000108426:	ff d0                	call   *%rax
}
ffff800000108428:	c9                   	leave
ffff800000108429:	c3                   	ret

ffff80000010842a <strncmp>:
strncmp(const char *p, const char *q, uint n)
{
ffff80000010842a:	f3 0f 1e fa          	endbr64
ffff80000010842e:	55                   	push   %rbp
ffff80000010842f:	48 89 e5             	mov    %rsp,%rbp
ffff800000108432:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000108436:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff80000010843a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff80000010843e:	89 55 ec             	mov    %edx,-0x14(%rbp)
  while(n > 0 && *p && *p == *q)
ffff800000108441:	eb 0e                	jmp    ffff800000108451 <strncmp+0x27>
    n--, p++, q++;
ffff800000108443:	83 6d ec 01          	subl   $0x1,-0x14(%rbp)
ffff800000108447:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffff80000010844c:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(n > 0 && *p && *p == *q)
ffff800000108451:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffff800000108455:	74 1d                	je     ffff800000108474 <strncmp+0x4a>
ffff800000108457:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010845b:	0f b6 00             	movzbl (%rax),%eax
ffff80000010845e:	84 c0                	test   %al,%al
ffff800000108460:	74 12                	je     ffff800000108474 <strncmp+0x4a>
ffff800000108462:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108466:	0f b6 10             	movzbl (%rax),%edx
ffff800000108469:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010846d:	0f b6 00             	movzbl (%rax),%eax
ffff800000108470:	38 c2                	cmp    %al,%dl
ffff800000108472:	74 cf                	je     ffff800000108443 <strncmp+0x19>
  if(n == 0)
ffff800000108474:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffff800000108478:	75 07                	jne    ffff800000108481 <strncmp+0x57>
    return 0;
ffff80000010847a:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010847f:	eb 16                	jmp    ffff800000108497 <strncmp+0x6d>
  return (uchar)*p - (uchar)*q;
ffff800000108481:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108485:	0f b6 00             	movzbl (%rax),%eax
ffff800000108488:	0f b6 d0             	movzbl %al,%edx
ffff80000010848b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010848f:	0f b6 00             	movzbl (%rax),%eax
ffff800000108492:	0f b6 c0             	movzbl %al,%eax
ffff800000108495:	29 c2                	sub    %eax,%edx
}
ffff800000108497:	89 d0                	mov    %edx,%eax
ffff800000108499:	c9                   	leave
ffff80000010849a:	c3                   	ret

ffff80000010849b <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
ffff80000010849b:	f3 0f 1e fa          	endbr64
ffff80000010849f:	55                   	push   %rbp
ffff8000001084a0:	48 89 e5             	mov    %rsp,%rbp
ffff8000001084a3:	48 83 ec 28          	sub    $0x28,%rsp
ffff8000001084a7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff8000001084ab:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff8000001084af:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *os = s;
ffff8000001084b2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001084b6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while(n-- > 0 && (*s++ = *t++) != 0)
ffff8000001084ba:	90                   	nop
ffff8000001084bb:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff8000001084be:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff8000001084c1:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff8000001084c4:	85 c0                	test   %eax,%eax
ffff8000001084c6:	7e 35                	jle    ffff8000001084fd <strncpy+0x62>
ffff8000001084c8:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff8000001084cc:	48 8d 42 01          	lea    0x1(%rdx),%rax
ffff8000001084d0:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff8000001084d4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001084d8:	48 8d 48 01          	lea    0x1(%rax),%rcx
ffff8000001084dc:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
ffff8000001084e0:	0f b6 12             	movzbl (%rdx),%edx
ffff8000001084e3:	88 10                	mov    %dl,(%rax)
ffff8000001084e5:	0f b6 00             	movzbl (%rax),%eax
ffff8000001084e8:	84 c0                	test   %al,%al
ffff8000001084ea:	75 cf                	jne    ffff8000001084bb <strncpy+0x20>
    ;
  while(n-- > 0)
ffff8000001084ec:	eb 0f                	jmp    ffff8000001084fd <strncpy+0x62>
    *s++ = 0;
ffff8000001084ee:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001084f2:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff8000001084f6:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
ffff8000001084fa:	c6 00 00             	movb   $0x0,(%rax)
  while(n-- > 0)
ffff8000001084fd:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000108500:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000108503:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000108506:	85 c0                	test   %eax,%eax
ffff800000108508:	7f e4                	jg     ffff8000001084ee <strncpy+0x53>
  return os;
ffff80000010850a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff80000010850e:	c9                   	leave
ffff80000010850f:	c3                   	ret

ffff800000108510 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
ffff800000108510:	f3 0f 1e fa          	endbr64
ffff800000108514:	55                   	push   %rbp
ffff800000108515:	48 89 e5             	mov    %rsp,%rbp
ffff800000108518:	48 83 ec 28          	sub    $0x28,%rsp
ffff80000010851c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000108520:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000108524:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *os = s;
ffff800000108527:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010852b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(n <= 0)
ffff80000010852f:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
ffff800000108533:	7f 06                	jg     ffff80000010853b <safestrcpy+0x2b>
    return os;
ffff800000108535:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108539:	eb 3a                	jmp    ffff800000108575 <safestrcpy+0x65>
  while(--n > 0 && (*s++ = *t++) != 0)
ffff80000010853b:	90                   	nop
ffff80000010853c:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
ffff800000108540:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
ffff800000108544:	7e 24                	jle    ffff80000010856a <safestrcpy+0x5a>
ffff800000108546:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff80000010854a:	48 8d 42 01          	lea    0x1(%rdx),%rax
ffff80000010854e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff800000108552:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000108556:	48 8d 48 01          	lea    0x1(%rax),%rcx
ffff80000010855a:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
ffff80000010855e:	0f b6 12             	movzbl (%rdx),%edx
ffff800000108561:	88 10                	mov    %dl,(%rax)
ffff800000108563:	0f b6 00             	movzbl (%rax),%eax
ffff800000108566:	84 c0                	test   %al,%al
ffff800000108568:	75 d2                	jne    ffff80000010853c <safestrcpy+0x2c>
    ;
  *s = 0;
ffff80000010856a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010856e:	c6 00 00             	movb   $0x0,(%rax)
  return os;
ffff800000108571:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000108575:	c9                   	leave
ffff800000108576:	c3                   	ret

ffff800000108577 <strlen>:

int
strlen(const char *s)
{
ffff800000108577:	f3 0f 1e fa          	endbr64
ffff80000010857b:	55                   	push   %rbp
ffff80000010857c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010857f:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000108583:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
ffff800000108587:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010858e:	eb 04                	jmp    ffff800000108594 <strlen+0x1d>
ffff800000108590:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000108594:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000108597:	48 63 d0             	movslq %eax,%rdx
ffff80000010859a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010859e:	48 01 d0             	add    %rdx,%rax
ffff8000001085a1:	0f b6 00             	movzbl (%rax),%eax
ffff8000001085a4:	84 c0                	test   %al,%al
ffff8000001085a6:	75 e8                	jne    ffff800000108590 <strlen+0x19>
    ;
  return n;
ffff8000001085a8:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff8000001085ab:	c9                   	leave
ffff8000001085ac:	c3                   	ret

ffff8000001085ad <swtch>:
# and then load register context from new.

.global swtch
swtch:
  # Save old callee-save registers
  pushq   %rbp
ffff8000001085ad:	55                   	push   %rbp
  pushq   %rbx
ffff8000001085ae:	53                   	push   %rbx
  pushq   %r12
ffff8000001085af:	41 54                	push   %r12
  pushq   %r13
ffff8000001085b1:	41 55                	push   %r13
  pushq   %r14
ffff8000001085b3:	41 56                	push   %r14
  pushq   %r15
ffff8000001085b5:	41 57                	push   %r15

  # Switch stacks
  movq    %rsp, (%rdi)
ffff8000001085b7:	48 89 27             	mov    %rsp,(%rdi)
  movq    %rsi, %rsp
ffff8000001085ba:	48 89 f4             	mov    %rsi,%rsp

  # Load new callee-save registers
  popq    %r15
ffff8000001085bd:	41 5f                	pop    %r15
  popq    %r14
ffff8000001085bf:	41 5e                	pop    %r14
  popq    %r13
ffff8000001085c1:	41 5d                	pop    %r13
  popq    %r12
ffff8000001085c3:	41 5c                	pop    %r12
  popq    %rbx
ffff8000001085c5:	5b                   	pop    %rbx
  popq    %rbp
ffff8000001085c6:	5d                   	pop    %rbp

  retq #??
ffff8000001085c7:	c3                   	ret

ffff8000001085c8 <fetchint>:
#include "syscall.h"

// Fetch the int at addr from the current process.
int
fetchint(addr_t addr, int *ip)
{
ffff8000001085c8:	f3 0f 1e fa          	endbr64
ffff8000001085cc:	55                   	push   %rbp
ffff8000001085cd:	48 89 e5             	mov    %rsp,%rbp
ffff8000001085d0:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001085d4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff8000001085d8:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(addr < PGSIZE || addr >= proc->sz || addr+sizeof(int) > proc->sz)
ffff8000001085dc:	48 81 7d f8 ff 0f 00 	cmpq   $0xfff,-0x8(%rbp)
ffff8000001085e3:	00 
ffff8000001085e4:	76 2f                	jbe    ffff800000108615 <fetchint+0x4d>
ffff8000001085e6:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001085ed:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001085f1:	48 8b 00             	mov    (%rax),%rax
ffff8000001085f4:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff8000001085f8:	73 1b                	jae    ffff800000108615 <fetchint+0x4d>
ffff8000001085fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001085fe:	48 8d 50 04          	lea    0x4(%rax),%rdx
ffff800000108602:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108609:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010860d:	48 8b 00             	mov    (%rax),%rax
ffff800000108610:	48 39 d0             	cmp    %rdx,%rax
ffff800000108613:	73 07                	jae    ffff80000010861c <fetchint+0x54>
    return -1;
ffff800000108615:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010861a:	eb 11                	jmp    ffff80000010862d <fetchint+0x65>
  *ip = *(int*)(addr);
ffff80000010861c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108620:	8b 10                	mov    (%rax),%edx
ffff800000108622:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108626:	89 10                	mov    %edx,(%rax)
  return 0;
ffff800000108628:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010862d:	c9                   	leave
ffff80000010862e:	c3                   	ret

ffff80000010862f <fetchaddr>:

int
fetchaddr(addr_t addr, addr_t *ip)
{
ffff80000010862f:	f3 0f 1e fa          	endbr64
ffff800000108633:	55                   	push   %rbp
ffff800000108634:	48 89 e5             	mov    %rsp,%rbp
ffff800000108637:	48 83 ec 10          	sub    $0x10,%rsp
ffff80000010863b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff80000010863f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(addr < PGSIZE || addr >= proc->sz || addr+sizeof(addr_t) > proc->sz)
ffff800000108643:	48 81 7d f8 ff 0f 00 	cmpq   $0xfff,-0x8(%rbp)
ffff80000010864a:	00 
ffff80000010864b:	76 2f                	jbe    ffff80000010867c <fetchaddr+0x4d>
ffff80000010864d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108654:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108658:	48 8b 00             	mov    (%rax),%rax
ffff80000010865b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff80000010865f:	73 1b                	jae    ffff80000010867c <fetchaddr+0x4d>
ffff800000108661:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108665:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffff800000108669:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108670:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108674:	48 8b 00             	mov    (%rax),%rax
ffff800000108677:	48 39 d0             	cmp    %rdx,%rax
ffff80000010867a:	73 07                	jae    ffff800000108683 <fetchaddr+0x54>
    return -1;
ffff80000010867c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108681:	eb 13                	jmp    ffff800000108696 <fetchaddr+0x67>
  *ip = *(addr_t*)(addr);
ffff800000108683:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108687:	48 8b 10             	mov    (%rax),%rdx
ffff80000010868a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010868e:	48 89 10             	mov    %rdx,(%rax)
  return 0;
ffff800000108691:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000108696:	c9                   	leave
ffff800000108697:	c3                   	ret

ffff800000108698 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(addr_t addr, char **pp)
{
ffff800000108698:	f3 0f 1e fa          	endbr64
ffff80000010869c:	55                   	push   %rbp
ffff80000010869d:	48 89 e5             	mov    %rsp,%rbp
ffff8000001086a0:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001086a4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff8000001086a8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *s, *ep;

  if(addr < PGSIZE || addr >= proc->sz)
ffff8000001086ac:	48 81 7d e8 ff 0f 00 	cmpq   $0xfff,-0x18(%rbp)
ffff8000001086b3:	00 
ffff8000001086b4:	76 14                	jbe    ffff8000001086ca <fetchstr+0x32>
ffff8000001086b6:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001086bd:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001086c1:	48 8b 00             	mov    (%rax),%rax
ffff8000001086c4:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffff8000001086c8:	72 07                	jb     ffff8000001086d1 <fetchstr+0x39>
    return -1;
ffff8000001086ca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001086cf:	eb 5b                	jmp    ffff80000010872c <fetchstr+0x94>
  *pp = (char*)addr;
ffff8000001086d1:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff8000001086d5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001086d9:	48 89 10             	mov    %rdx,(%rax)
  ep = (char*)proc->sz;
ffff8000001086dc:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001086e3:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001086e7:	48 8b 00             	mov    (%rax),%rax
ffff8000001086ea:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(s = *pp; s < ep; s++)
ffff8000001086ee:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001086f2:	48 8b 00             	mov    (%rax),%rax
ffff8000001086f5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001086f9:	eb 22                	jmp    ffff80000010871d <fetchstr+0x85>
    if(*s == 0)
ffff8000001086fb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001086ff:	0f b6 00             	movzbl (%rax),%eax
ffff800000108702:	84 c0                	test   %al,%al
ffff800000108704:	75 12                	jne    ffff800000108718 <fetchstr+0x80>
      return s - *pp;
ffff800000108706:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010870a:	48 8b 00             	mov    (%rax),%rax
ffff80000010870d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000108711:	48 29 c2             	sub    %rax,%rdx
ffff800000108714:	89 d0                	mov    %edx,%eax
ffff800000108716:	eb 14                	jmp    ffff80000010872c <fetchstr+0x94>
  for(s = *pp; s < ep; s++)
ffff800000108718:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffff80000010871d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108721:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
ffff800000108725:	72 d4                	jb     ffff8000001086fb <fetchstr+0x63>
  return -1;
ffff800000108727:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff80000010872c:	c9                   	leave
ffff80000010872d:	c3                   	ret

ffff80000010872e <fetcharg>:

static addr_t
fetcharg(int n)
{
ffff80000010872e:	f3 0f 1e fa          	endbr64
ffff800000108732:	55                   	push   %rbp
ffff800000108733:	48 89 e5             	mov    %rsp,%rbp
ffff800000108736:	48 83 ec 10          	sub    $0x10,%rsp
ffff80000010873a:	89 7d fc             	mov    %edi,-0x4(%rbp)
  switch (n) {
ffff80000010873d:	83 7d fc 05          	cmpl   $0x5,-0x4(%rbp)
ffff800000108741:	0f 87 9f 00 00 00    	ja     ffff8000001087e6 <fetcharg+0xb8>
ffff800000108747:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010874a:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff800000108751:	00 
ffff800000108752:	48 b8 b8 d3 10 00 00 	movabs $0xffff80000010d3b8,%rax
ffff800000108759:	80 ff ff 
ffff80000010875c:	48 01 d0             	add    %rdx,%rax
ffff80000010875f:	48 8b 00             	mov    (%rax),%rax
ffff800000108762:	3e ff e0             	notrack jmp *%rax
  case 0: return proc->tf->rdi;
ffff800000108765:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010876c:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108770:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000108774:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff800000108778:	e9 82 00 00 00       	jmp    ffff8000001087ff <fetcharg+0xd1>
  case 1: return proc->tf->rsi;
ffff80000010877d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108784:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108788:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff80000010878c:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000108790:	eb 6d                	jmp    ffff8000001087ff <fetcharg+0xd1>
  case 2: return proc->tf->rdx;
ffff800000108792:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108799:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010879d:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001087a1:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff8000001087a5:	eb 58                	jmp    ffff8000001087ff <fetcharg+0xd1>
  case 3: return proc->tf->r10;
ffff8000001087a7:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001087ae:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001087b2:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001087b6:	48 8b 40 48          	mov    0x48(%rax),%rax
ffff8000001087ba:	eb 43                	jmp    ffff8000001087ff <fetcharg+0xd1>
  case 4: return proc->tf->r8;
ffff8000001087bc:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001087c3:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001087c7:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001087cb:	48 8b 40 38          	mov    0x38(%rax),%rax
ffff8000001087cf:	eb 2e                	jmp    ffff8000001087ff <fetcharg+0xd1>
  case 5: return proc->tf->r9;
ffff8000001087d1:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001087d8:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001087dc:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001087e0:	48 8b 40 40          	mov    0x40(%rax),%rax
ffff8000001087e4:	eb 19                	jmp    ffff8000001087ff <fetcharg+0xd1>
  }
  panic("failed fetch");
ffff8000001087e6:	48 b8 a8 d3 10 00 00 	movabs $0xffff80000010d3a8,%rax
ffff8000001087ed:	80 ff ff 
ffff8000001087f0:	48 89 c7             	mov    %rax,%rdi
ffff8000001087f3:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff8000001087fa:	80 ff ff 
ffff8000001087fd:	ff d0                	call   *%rax
}
ffff8000001087ff:	c9                   	leave
ffff800000108800:	c3                   	ret

ffff800000108801 <argint>:

int
argint(int n, int *ip)
{
ffff800000108801:	f3 0f 1e fa          	endbr64
ffff800000108805:	55                   	push   %rbp
ffff800000108806:	48 89 e5             	mov    %rsp,%rbp
ffff800000108809:	48 83 ec 10          	sub    $0x10,%rsp
ffff80000010880d:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff800000108810:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  *ip = fetcharg(n);
ffff800000108814:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000108817:	89 c7                	mov    %eax,%edi
ffff800000108819:	48 b8 2e 87 10 00 00 	movabs $0xffff80000010872e,%rax
ffff800000108820:	80 ff ff 
ffff800000108823:	ff d0                	call   *%rax
ffff800000108825:	89 c2                	mov    %eax,%edx
ffff800000108827:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010882b:	89 10                	mov    %edx,(%rax)
  return 0;
ffff80000010882d:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000108832:	c9                   	leave
ffff800000108833:	c3                   	ret

ffff800000108834 <argaddr>:

addr_t
argaddr(int n, addr_t *ip)
{
ffff800000108834:	f3 0f 1e fa          	endbr64
ffff800000108838:	55                   	push   %rbp
ffff800000108839:	48 89 e5             	mov    %rsp,%rbp
ffff80000010883c:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000108840:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff800000108843:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  *ip = fetcharg(n);
ffff800000108847:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010884a:	89 c7                	mov    %eax,%edi
ffff80000010884c:	48 b8 2e 87 10 00 00 	movabs $0xffff80000010872e,%rax
ffff800000108853:	80 ff ff 
ffff800000108856:	ff d0                	call   *%rax
ffff800000108858:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff80000010885c:	48 89 02             	mov    %rax,(%rdx)
  return 0;
ffff80000010885f:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000108864:	c9                   	leave
ffff800000108865:	c3                   	ret

ffff800000108866 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
addr_t
argptr(int n, char **pp, int size)
{
ffff800000108866:	f3 0f 1e fa          	endbr64
ffff80000010886a:	55                   	push   %rbp
ffff80000010886b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010886e:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000108872:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000108875:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000108879:	89 55 e8             	mov    %edx,-0x18(%rbp)
  addr_t i;

  if(argaddr(n, &i) < 0)
ffff80000010887c:	48 8d 55 f8          	lea    -0x8(%rbp),%rdx
ffff800000108880:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000108883:	48 89 d6             	mov    %rdx,%rsi
ffff800000108886:	89 c7                	mov    %eax,%edi
ffff800000108888:	48 b8 34 88 10 00 00 	movabs $0xffff800000108834,%rax
ffff80000010888f:	80 ff ff 
ffff800000108892:	ff d0                	call   *%rax
    return -1;
  if(size < 0 || (uint)i >= proc->sz || (uint)i+size > proc->sz)
ffff800000108894:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
ffff800000108898:	78 39                	js     ffff8000001088d3 <argptr+0x6d>
ffff80000010889a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010889e:	89 c2                	mov    %eax,%edx
ffff8000001088a0:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001088a7:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001088ab:	48 8b 00             	mov    (%rax),%rax
ffff8000001088ae:	48 39 c2             	cmp    %rax,%rdx
ffff8000001088b1:	73 20                	jae    ffff8000001088d3 <argptr+0x6d>
ffff8000001088b3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001088b7:	89 c2                	mov    %eax,%edx
ffff8000001088b9:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff8000001088bc:	01 d0                	add    %edx,%eax
ffff8000001088be:	89 c2                	mov    %eax,%edx
ffff8000001088c0:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001088c7:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001088cb:	48 8b 00             	mov    (%rax),%rax
ffff8000001088ce:	48 39 d0             	cmp    %rdx,%rax
ffff8000001088d1:	73 09                	jae    ffff8000001088dc <argptr+0x76>
    return -1;
ffff8000001088d3:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
ffff8000001088da:	eb 13                	jmp    ffff8000001088ef <argptr+0x89>
  *pp = (char*)i;
ffff8000001088dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001088e0:	48 89 c2             	mov    %rax,%rdx
ffff8000001088e3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001088e7:	48 89 10             	mov    %rdx,(%rax)
  return 0;
ffff8000001088ea:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff8000001088ef:	c9                   	leave
ffff8000001088f0:	c3                   	ret

ffff8000001088f1 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
ffff8000001088f1:	f3 0f 1e fa          	endbr64
ffff8000001088f5:	55                   	push   %rbp
ffff8000001088f6:	48 89 e5             	mov    %rsp,%rbp
ffff8000001088f9:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001088fd:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000108900:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int addr;
  if(argint(n, &addr) < 0)
ffff800000108904:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
ffff800000108908:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff80000010890b:	48 89 d6             	mov    %rdx,%rsi
ffff80000010890e:	89 c7                	mov    %eax,%edi
ffff800000108910:	48 b8 01 88 10 00 00 	movabs $0xffff800000108801,%rax
ffff800000108917:	80 ff ff 
ffff80000010891a:	ff d0                	call   *%rax
ffff80000010891c:	85 c0                	test   %eax,%eax
ffff80000010891e:	79 07                	jns    ffff800000108927 <argstr+0x36>
    return -1;
ffff800000108920:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108925:	eb 1b                	jmp    ffff800000108942 <argstr+0x51>
  return fetchstr(addr, pp);
ffff800000108927:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010892a:	48 98                	cltq
ffff80000010892c:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000108930:	48 89 d6             	mov    %rdx,%rsi
ffff800000108933:	48 89 c7             	mov    %rax,%rdi
ffff800000108936:	48 b8 98 86 10 00 00 	movabs $0xffff800000108698,%rax
ffff80000010893d:	80 ff ff 
ffff800000108940:	ff d0                	call   *%rax
}
ffff800000108942:	c9                   	leave
ffff800000108943:	c3                   	ret

ffff800000108944 <syscall>:
	[SYS_register_fsserver] sys_register_fsserver
};

void
syscall(struct trapframe *tf)
{
ffff800000108944:	f3 0f 1e fa          	endbr64
ffff800000108948:	55                   	push   %rbp
ffff800000108949:	48 89 e5             	mov    %rsp,%rbp
ffff80000010894c:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000108950:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  proc->tf = tf;
ffff800000108954:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010895b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010895f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000108963:	48 89 50 28          	mov    %rdx,0x28(%rax)
  uint64 num = proc->tf->rax;
ffff800000108967:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010896e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108972:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000108976:	48 8b 00             	mov    (%rax),%rax
ffff800000108979:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if (num > 0 && num < NELEM(syscalls) && syscalls[num]) {
ffff80000010897d:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000108982:	74 3b                	je     ffff8000001089bf <syscall+0x7b>
ffff800000108984:	48 83 7d f8 18       	cmpq   $0x18,-0x8(%rbp)
ffff800000108989:	77 34                	ja     ffff8000001089bf <syscall+0x7b>
ffff80000010898b:	48 ba a0 e5 10 00 00 	movabs $0xffff80000010e5a0,%rdx
ffff800000108992:	80 ff ff 
ffff800000108995:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108999:	48 8b 04 c2          	mov    (%rdx,%rax,8),%rax
ffff80000010899d:	48 85 c0             	test   %rax,%rax
ffff8000001089a0:	74 1d                	je     ffff8000001089bf <syscall+0x7b>
    tf->rax = syscalls[num]();
ffff8000001089a2:	48 ba a0 e5 10 00 00 	movabs $0xffff80000010e5a0,%rdx
ffff8000001089a9:	80 ff ff 
ffff8000001089ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001089b0:	48 8b 04 c2          	mov    (%rdx,%rax,8),%rax
ffff8000001089b4:	ff d0                	call   *%rax
ffff8000001089b6:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff8000001089ba:	48 89 02             	mov    %rax,(%rdx)
ffff8000001089bd:	eb 56                	jmp    ffff800000108a15 <syscall+0xd1>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
ffff8000001089bf:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001089c6:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001089ca:	48 8d b0 d0 00 00 00 	lea    0xd0(%rax),%rsi
ffff8000001089d1:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001089d8:	64 48 8b 00          	mov    %fs:(%rax),%rax
    cprintf("%d %s: unknown sys call %d\n",
ffff8000001089dc:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff8000001089df:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001089e3:	48 89 d1             	mov    %rdx,%rcx
ffff8000001089e6:	48 89 f2             	mov    %rsi,%rdx
ffff8000001089e9:	89 c6                	mov    %eax,%esi
ffff8000001089eb:	48 b8 e8 d3 10 00 00 	movabs $0xffff80000010d3e8,%rax
ffff8000001089f2:	80 ff ff 
ffff8000001089f5:	48 89 c7             	mov    %rax,%rdi
ffff8000001089f8:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001089fd:	49 b8 38 08 10 00 00 	movabs $0xffff800000100838,%r8
ffff800000108a04:	80 ff ff 
ffff800000108a07:	41 ff d0             	call   *%r8
    tf->rax = -1;
ffff800000108a0a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000108a0e:	48 c7 00 ff ff ff ff 	movq   $0xffffffffffffffff,(%rax)
  }
  if (proc->killed)
ffff800000108a15:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108a1c:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108a20:	8b 40 40             	mov    0x40(%rax),%eax
ffff800000108a23:	85 c0                	test   %eax,%eax
ffff800000108a25:	74 0c                	je     ffff800000108a33 <syscall+0xef>
    exit();
ffff800000108a27:	48 b8 a6 6a 10 00 00 	movabs $0xffff800000106aa6,%rax
ffff800000108a2e:	80 ff ff 
ffff800000108a31:	ff d0                	call   *%rax
}
ffff800000108a33:	90                   	nop
ffff800000108a34:	c9                   	leave
ffff800000108a35:	c3                   	ret

ffff800000108a36 <fsserver_active>:

static int next_fs_request_id = 1;

static int
fsserver_active(void)
{
ffff800000108a36:	f3 0f 1e fa          	endbr64
ffff800000108a3a:	55                   	push   %rbp
ffff800000108a3b:	48 89 e5             	mov    %rsp,%rbp
  return get_fsserver_pid() > 0 && !is_fsserver();
ffff800000108a3e:	48 b8 4b 77 10 00 00 	movabs $0xffff80000010774b,%rax
ffff800000108a45:	80 ff ff 
ffff800000108a48:	ff d0                	call   *%rax
ffff800000108a4a:	85 c0                	test   %eax,%eax
ffff800000108a4c:	7e 17                	jle    ffff800000108a65 <fsserver_active+0x2f>
ffff800000108a4e:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff800000108a55:	80 ff ff 
ffff800000108a58:	ff d0                	call   *%rax
ffff800000108a5a:	85 c0                	test   %eax,%eax
ffff800000108a5c:	75 07                	jne    ffff800000108a65 <fsserver_active+0x2f>
ffff800000108a5e:	b8 01 00 00 00       	mov    $0x1,%eax
ffff800000108a63:	eb 05                	jmp    ffff800000108a6a <fsserver_active+0x34>
ffff800000108a65:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000108a6a:	5d                   	pop    %rbp
ffff800000108a6b:	c3                   	ret

ffff800000108a6c <fs_ipc_call>:

static int
fs_ipc_call(struct ipc_msg *req, struct ipc_msg *reply)
{
ffff800000108a6c:	f3 0f 1e fa          	endbr64
ffff800000108a70:	55                   	push   %rbp
ffff800000108a71:	48 89 e5             	mov    %rsp,%rbp
ffff800000108a74:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000108a78:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000108a7c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int server_pid;
  int request_id;

  server_pid = get_fsserver_pid();
ffff800000108a80:	48 b8 4b 77 10 00 00 	movabs $0xffff80000010774b,%rax
ffff800000108a87:	80 ff ff 
ffff800000108a8a:	ff d0                	call   *%rax
ffff800000108a8c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(server_pid < 0)
ffff800000108a8f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000108a93:	79 0a                	jns    ffff800000108a9f <fs_ipc_call+0x33>
    return -1;
ffff800000108a95:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108a9a:	e9 85 00 00 00       	jmp    ffff800000108b24 <fs_ipc_call+0xb8>

  request_id = __sync_fetch_and_add(&next_fs_request_id, 1);
ffff800000108a9f:	48 b8 68 e6 10 00 00 	movabs $0xffff80000010e668,%rax
ffff800000108aa6:	80 ff ff 
ffff800000108aa9:	ba 01 00 00 00       	mov    $0x1,%edx
ffff800000108aae:	f0 0f c1 10          	lock xadd %edx,(%rax)
ffff800000108ab2:	89 55 f8             	mov    %edx,-0x8(%rbp)
  req->request_id = request_id;
ffff800000108ab5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000108ab9:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffff800000108abc:	89 50 04             	mov    %edx,0x4(%rax)

  if(ipc_send_msg(server_pid, req) < 0)
ffff800000108abf:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000108ac3:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000108ac6:	48 89 d6             	mov    %rdx,%rsi
ffff800000108ac9:	89 c7                	mov    %eax,%edi
ffff800000108acb:	48 b8 8d 77 10 00 00 	movabs $0xffff80000010778d,%rax
ffff800000108ad2:	80 ff ff 
ffff800000108ad5:	ff d0                	call   *%rax
ffff800000108ad7:	85 c0                	test   %eax,%eax
ffff800000108ad9:	79 07                	jns    ffff800000108ae2 <fs_ipc_call+0x76>
    return -1;
ffff800000108adb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108ae0:	eb 42                	jmp    ffff800000108b24 <fs_ipc_call+0xb8>
  if(ipc_recv_msg(reply) < 0)
ffff800000108ae2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000108ae6:	48 89 c7             	mov    %rax,%rdi
ffff800000108ae9:	48 b8 55 7a 10 00 00 	movabs $0xffff800000107a55,%rax
ffff800000108af0:	80 ff ff 
ffff800000108af3:	ff d0                	call   *%rax
ffff800000108af5:	85 c0                	test   %eax,%eax
ffff800000108af7:	79 07                	jns    ffff800000108b00 <fs_ipc_call+0x94>
    return -1;
ffff800000108af9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108afe:	eb 24                	jmp    ffff800000108b24 <fs_ipc_call+0xb8>
  if(reply->type != IPC_TYPE_FS_REPLY || reply->request_id != request_id)
ffff800000108b00:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000108b04:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000108b07:	83 f8 64             	cmp    $0x64,%eax
ffff800000108b0a:	75 0c                	jne    ffff800000108b18 <fs_ipc_call+0xac>
ffff800000108b0c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000108b10:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000108b13:	39 45 f8             	cmp    %eax,-0x8(%rbp)
ffff800000108b16:	74 07                	je     ffff800000108b1f <fs_ipc_call+0xb3>
    return -1;
ffff800000108b18:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108b1d:	eb 05                	jmp    ffff800000108b24 <fs_ipc_call+0xb8>
  return 0;
ffff800000108b1f:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000108b24:	c9                   	leave
ffff800000108b25:	c3                   	ret

ffff800000108b26 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
ffff800000108b26:	f3 0f 1e fa          	endbr64
ffff800000108b2a:	55                   	push   %rbp
ffff800000108b2b:	48 89 e5             	mov    %rsp,%rbp
ffff800000108b2e:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000108b32:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000108b35:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000108b39:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
ffff800000108b3d:	48 8d 55 f4          	lea    -0xc(%rbp),%rdx
ffff800000108b41:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000108b44:	48 89 d6             	mov    %rdx,%rsi
ffff800000108b47:	89 c7                	mov    %eax,%edi
ffff800000108b49:	48 b8 01 88 10 00 00 	movabs $0xffff800000108801,%rax
ffff800000108b50:	80 ff ff 
ffff800000108b53:	ff d0                	call   *%rax
ffff800000108b55:	85 c0                	test   %eax,%eax
ffff800000108b57:	79 07                	jns    ffff800000108b60 <argfd+0x3a>
    return -1;
ffff800000108b59:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108b5e:	eb 62                	jmp    ffff800000108bc2 <argfd+0x9c>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
ffff800000108b60:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000108b63:	85 c0                	test   %eax,%eax
ffff800000108b65:	78 2d                	js     ffff800000108b94 <argfd+0x6e>
ffff800000108b67:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000108b6a:	83 f8 0f             	cmp    $0xf,%eax
ffff800000108b6d:	7f 25                	jg     ffff800000108b94 <argfd+0x6e>
ffff800000108b6f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108b76:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108b7a:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff800000108b7d:	48 63 d2             	movslq %edx,%rdx
ffff800000108b80:	48 83 c2 08          	add    $0x8,%rdx
ffff800000108b84:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff800000108b89:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000108b8d:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000108b92:	75 07                	jne    ffff800000108b9b <argfd+0x75>
    return -1;
ffff800000108b94:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108b99:	eb 27                	jmp    ffff800000108bc2 <argfd+0x9c>
  if(pfd)
ffff800000108b9b:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
ffff800000108ba0:	74 09                	je     ffff800000108bab <argfd+0x85>
    *pfd = fd;
ffff800000108ba2:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff800000108ba5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000108ba9:	89 10                	mov    %edx,(%rax)
  if(pf)
ffff800000108bab:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
ffff800000108bb0:	74 0b                	je     ffff800000108bbd <argfd+0x97>
    *pf = f;
ffff800000108bb2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000108bb6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000108bba:	48 89 10             	mov    %rdx,(%rax)
  return 0;
ffff800000108bbd:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000108bc2:	c9                   	leave
ffff800000108bc3:	c3                   	ret

ffff800000108bc4 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
ffff800000108bc4:	f3 0f 1e fa          	endbr64
ffff800000108bc8:	55                   	push   %rbp
ffff800000108bc9:	48 89 e5             	mov    %rsp,%rbp
ffff800000108bcc:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000108bd0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
ffff800000108bd4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000108bdb:	eb 46                	jmp    ffff800000108c23 <fdalloc+0x5f>
    if(proc->ofile[fd] == 0){
ffff800000108bdd:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108be4:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108be8:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000108beb:	48 63 d2             	movslq %edx,%rdx
ffff800000108bee:	48 83 c2 08          	add    $0x8,%rdx
ffff800000108bf2:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff800000108bf7:	48 85 c0             	test   %rax,%rax
ffff800000108bfa:	75 23                	jne    ffff800000108c1f <fdalloc+0x5b>
      proc->ofile[fd] = f;
ffff800000108bfc:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108c03:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108c07:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000108c0a:	48 63 d2             	movslq %edx,%rdx
ffff800000108c0d:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
ffff800000108c11:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000108c15:	48 89 54 c8 08       	mov    %rdx,0x8(%rax,%rcx,8)
      return fd;
ffff800000108c1a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000108c1d:	eb 0f                	jmp    ffff800000108c2e <fdalloc+0x6a>
  for(fd = 0; fd < NOFILE; fd++){
ffff800000108c1f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000108c23:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
ffff800000108c27:	7e b4                	jle    ffff800000108bdd <fdalloc+0x19>
    }
  }
  return -1;
ffff800000108c29:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000108c2e:	c9                   	leave
ffff800000108c2f:	c3                   	ret

ffff800000108c30 <sys_dup>:

int
sys_dup(void)
{
ffff800000108c30:	f3 0f 1e fa          	endbr64
ffff800000108c34:	55                   	push   %rbp
ffff800000108c35:	48 89 e5             	mov    %rsp,%rbp
ffff800000108c38:	48 83 ec 10          	sub    $0x10,%rsp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
ffff800000108c3c:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff800000108c40:	48 89 c2             	mov    %rax,%rdx
ffff800000108c43:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000108c48:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000108c4d:	48 b8 26 8b 10 00 00 	movabs $0xffff800000108b26,%rax
ffff800000108c54:	80 ff ff 
ffff800000108c57:	ff d0                	call   *%rax
ffff800000108c59:	85 c0                	test   %eax,%eax
ffff800000108c5b:	79 07                	jns    ffff800000108c64 <sys_dup+0x34>
    return -1;
ffff800000108c5d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108c62:	eb 4b                	jmp    ffff800000108caf <sys_dup+0x7f>
  if(f->type == FD_REMOTE)
ffff800000108c64:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108c68:	8b 00                	mov    (%rax),%eax
ffff800000108c6a:	83 f8 03             	cmp    $0x3,%eax
ffff800000108c6d:	75 07                	jne    ffff800000108c76 <sys_dup+0x46>
    return -1;
ffff800000108c6f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108c74:	eb 39                	jmp    ffff800000108caf <sys_dup+0x7f>
  if((fd=fdalloc(f)) < 0)
ffff800000108c76:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108c7a:	48 89 c7             	mov    %rax,%rdi
ffff800000108c7d:	48 b8 c4 8b 10 00 00 	movabs $0xffff800000108bc4,%rax
ffff800000108c84:	80 ff ff 
ffff800000108c87:	ff d0                	call   *%rax
ffff800000108c89:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000108c8c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000108c90:	79 07                	jns    ffff800000108c99 <sys_dup+0x69>
    return -1;
ffff800000108c92:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108c97:	eb 16                	jmp    ffff800000108caf <sys_dup+0x7f>
  filedup(f);
ffff800000108c99:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108c9d:	48 89 c7             	mov    %rax,%rdi
ffff800000108ca0:	48 b8 bb 1c 10 00 00 	movabs $0xffff800000101cbb,%rax
ffff800000108ca7:	80 ff ff 
ffff800000108caa:	ff d0                	call   *%rax
  return fd;
ffff800000108cac:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff800000108caf:	c9                   	leave
ffff800000108cb0:	c3                   	ret

ffff800000108cb1 <sys_read>:

int
sys_read(void)
{
ffff800000108cb1:	f3 0f 1e fa          	endbr64
ffff800000108cb5:	55                   	push   %rbp
ffff800000108cb6:	48 89 e5             	mov    %rsp,%rbp
ffff800000108cb9:	48 81 ec e0 01 00 00 	sub    $0x1e0,%rsp
  // DONE(18-reroute-read): What: when fd is a remote fsserver file, validate
  // the user buffer and byte count, send IPC_TYPE_FS_READ, wait for
  // IPC_TYPE_FS_REPLY, and copy returned bytes into p. Why: normal user programs
  // should call read() unchanged while the kernel forwards regular-file work to
  // fsserver. Keep pipe/device reads local unless the design moves them too.
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
ffff800000108cc0:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff800000108cc4:	48 89 c2             	mov    %rax,%rdx
ffff800000108cc7:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000108ccc:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000108cd1:	48 b8 26 8b 10 00 00 	movabs $0xffff800000108b26,%rax
ffff800000108cd8:	80 ff ff 
ffff800000108cdb:	ff d0                	call   *%rax
ffff800000108cdd:	85 c0                	test   %eax,%eax
ffff800000108cdf:	78 48                	js     ffff800000108d29 <sys_read+0x78>
ffff800000108ce1:	48 8d 45 ec          	lea    -0x14(%rbp),%rax
ffff800000108ce5:	48 89 c6             	mov    %rax,%rsi
ffff800000108ce8:	bf 02 00 00 00       	mov    $0x2,%edi
ffff800000108ced:	48 b8 01 88 10 00 00 	movabs $0xffff800000108801,%rax
ffff800000108cf4:	80 ff ff 
ffff800000108cf7:	ff d0                	call   *%rax
ffff800000108cf9:	85 c0                	test   %eax,%eax
ffff800000108cfb:	78 2c                	js     ffff800000108d29 <sys_read+0x78>
ffff800000108cfd:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff800000108d00:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff800000108d04:	48 89 c6             	mov    %rax,%rsi
ffff800000108d07:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000108d0c:	48 b8 66 88 10 00 00 	movabs $0xffff800000108866,%rax
ffff800000108d13:	80 ff ff 
ffff800000108d16:	ff d0                	call   *%rax
    return -1;
  if(f->type == FD_REMOTE){
ffff800000108d18:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108d1c:	8b 00                	mov    (%rax),%eax
ffff800000108d1e:	83 f8 03             	cmp    $0x3,%eax
ffff800000108d21:	0f 85 47 01 00 00    	jne    ffff800000108e6e <sys_read+0x1bd>
ffff800000108d27:	eb 0a                	jmp    ffff800000108d33 <sys_read+0x82>
    return -1;
ffff800000108d29:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108d2e:	e9 58 01 00 00       	jmp    ffff800000108e8b <sys_read+0x1da>
    struct ipc_msg req;
    struct ipc_msg reply;
    int total;
    int chunk;

    total = 0;
ffff800000108d33:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    while(total < n){
ffff800000108d3a:	e9 18 01 00 00       	jmp    ffff800000108e57 <sys_read+0x1a6>
      chunk = n - total;
ffff800000108d3f:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000108d42:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff800000108d45:	89 45 f8             	mov    %eax,-0x8(%rbp)
      if(chunk > IPC_DATA_SIZE)
ffff800000108d48:	81 7d f8 80 00 00 00 	cmpl   $0x80,-0x8(%rbp)
ffff800000108d4f:	7e 07                	jle    ffff800000108d58 <sys_read+0xa7>
        chunk = IPC_DATA_SIZE;
ffff800000108d51:	c7 45 f8 80 00 00 00 	movl   $0x80,-0x8(%rbp)

      memset(&req, 0, sizeof(req));
ffff800000108d58:	48 8d 85 20 fe ff ff 	lea    -0x1e0(%rbp),%rax
ffff800000108d5f:	ba e0 00 00 00       	mov    $0xe0,%edx
ffff800000108d64:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000108d69:	48 89 c7             	mov    %rax,%rdi
ffff800000108d6c:	48 b8 40 82 10 00 00 	movabs $0xffff800000108240,%rax
ffff800000108d73:	80 ff ff 
ffff800000108d76:	ff d0                	call   *%rax
      req.type = IPC_TYPE_FS_READ;
ffff800000108d78:	c7 85 28 fe ff ff 02 	movl   $0x2,-0x1d8(%rbp)
ffff800000108d7f:	00 00 00 
      req.fd = f->remote_fd;
ffff800000108d82:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108d86:	8b 40 24             	mov    0x24(%rax),%eax
ffff800000108d89:	89 85 2c fe ff ff    	mov    %eax,-0x1d4(%rbp)
      req.nbytes = chunk;
ffff800000108d8f:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000108d92:	89 85 34 fe ff ff    	mov    %eax,-0x1cc(%rbp)

      if(fs_ipc_call(&req, &reply) < 0 || reply.result < 0)
ffff800000108d98:	48 8d 95 00 ff ff ff 	lea    -0x100(%rbp),%rdx
ffff800000108d9f:	48 8d 85 20 fe ff ff 	lea    -0x1e0(%rbp),%rax
ffff800000108da6:	48 89 d6             	mov    %rdx,%rsi
ffff800000108da9:	48 89 c7             	mov    %rax,%rdi
ffff800000108dac:	48 b8 6c 8a 10 00 00 	movabs $0xffff800000108a6c,%rax
ffff800000108db3:	80 ff ff 
ffff800000108db6:	ff d0                	call   *%rax
ffff800000108db8:	85 c0                	test   %eax,%eax
ffff800000108dba:	78 0a                	js     ffff800000108dc6 <sys_read+0x115>
ffff800000108dbc:	8b 85 18 ff ff ff    	mov    -0xe8(%rbp),%eax
ffff800000108dc2:	85 c0                	test   %eax,%eax
ffff800000108dc4:	79 18                	jns    ffff800000108dde <sys_read+0x12d>
        return total > 0 ? total : -1;
ffff800000108dc6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000108dca:	7e 08                	jle    ffff800000108dd4 <sys_read+0x123>
ffff800000108dcc:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000108dcf:	e9 b7 00 00 00       	jmp    ffff800000108e8b <sys_read+0x1da>
ffff800000108dd4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108dd9:	e9 ad 00 00 00       	jmp    ffff800000108e8b <sys_read+0x1da>
      if(reply.nbytes > reply.result)
ffff800000108dde:	8b 95 14 ff ff ff    	mov    -0xec(%rbp),%edx
ffff800000108de4:	8b 85 18 ff ff ff    	mov    -0xe8(%rbp),%eax
ffff800000108dea:	39 c2                	cmp    %eax,%edx
ffff800000108dec:	7e 18                	jle    ffff800000108e06 <sys_read+0x155>
        return total > 0 ? total : -1;
ffff800000108dee:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000108df2:	7e 08                	jle    ffff800000108dfc <sys_read+0x14b>
ffff800000108df4:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000108df7:	e9 8f 00 00 00       	jmp    ffff800000108e8b <sys_read+0x1da>
ffff800000108dfc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108e01:	e9 85 00 00 00       	jmp    ffff800000108e8b <sys_read+0x1da>
      if(reply.result == 0)
ffff800000108e06:	8b 85 18 ff ff ff    	mov    -0xe8(%rbp),%eax
ffff800000108e0c:	85 c0                	test   %eax,%eax
ffff800000108e0e:	74 55                	je     ffff800000108e65 <sys_read+0x1b4>
        break;

      memmove(p + total, reply.data, reply.result);
ffff800000108e10:	8b 85 18 ff ff ff    	mov    -0xe8(%rbp),%eax
ffff800000108e16:	89 c6                	mov    %eax,%esi
ffff800000108e18:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000108e1c:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000108e1f:	48 98                	cltq
ffff800000108e21:	48 01 d0             	add    %rdx,%rax
ffff800000108e24:	48 8d 95 00 ff ff ff 	lea    -0x100(%rbp),%rdx
ffff800000108e2b:	48 8d 4a 60          	lea    0x60(%rdx),%rcx
ffff800000108e2f:	89 f2                	mov    %esi,%edx
ffff800000108e31:	48 89 ce             	mov    %rcx,%rsi
ffff800000108e34:	48 89 c7             	mov    %rax,%rdi
ffff800000108e37:	48 b8 4d 83 10 00 00 	movabs $0xffff80000010834d,%rax
ffff800000108e3e:	80 ff ff 
ffff800000108e41:	ff d0                	call   *%rax
      total += reply.result;
ffff800000108e43:	8b 85 18 ff ff ff    	mov    -0xe8(%rbp),%eax
ffff800000108e49:	01 45 fc             	add    %eax,-0x4(%rbp)

      if(reply.result < chunk)
ffff800000108e4c:	8b 85 18 ff ff ff    	mov    -0xe8(%rbp),%eax
ffff800000108e52:	39 45 f8             	cmp    %eax,-0x8(%rbp)
ffff800000108e55:	7f 11                	jg     ffff800000108e68 <sys_read+0x1b7>
    while(total < n){
ffff800000108e57:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000108e5a:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000108e5d:	0f 8c dc fe ff ff    	jl     ffff800000108d3f <sys_read+0x8e>
ffff800000108e63:	eb 04                	jmp    ffff800000108e69 <sys_read+0x1b8>
        break;
ffff800000108e65:	90                   	nop
ffff800000108e66:	eb 01                	jmp    ffff800000108e69 <sys_read+0x1b8>
        break;
ffff800000108e68:	90                   	nop
    }
    return total;
ffff800000108e69:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000108e6c:	eb 1d                	jmp    ffff800000108e8b <sys_read+0x1da>
  }
  return fileread(f, p, n);
ffff800000108e6e:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff800000108e71:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff800000108e75:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108e79:	48 89 ce             	mov    %rcx,%rsi
ffff800000108e7c:	48 89 c7             	mov    %rax,%rdi
ffff800000108e7f:	48 b8 19 1f 10 00 00 	movabs $0xffff800000101f19,%rax
ffff800000108e86:	80 ff ff 
ffff800000108e89:	ff d0                	call   *%rax
}
ffff800000108e8b:	c9                   	leave
ffff800000108e8c:	c3                   	ret

ffff800000108e8d <sys_write>:

int
sys_write(void)
{
ffff800000108e8d:	f3 0f 1e fa          	endbr64
ffff800000108e91:	55                   	push   %rbp
ffff800000108e92:	48 89 e5             	mov    %rsp,%rbp
ffff800000108e95:	48 81 ec e0 01 00 00 	sub    $0x1e0,%rsp

  // DONE(19-reroute-write): What: when fd is a remote fsserver file, gather the
  // user buffer into one or more IPC_DATA_SIZE payloads, send IPC_TYPE_FS_WRITE,
  // and return the fsserver result. Why: write() must preserve the normal xv6
  // API while moving regular-file writes through IPC.
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
ffff800000108e9c:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff800000108ea0:	48 89 c2             	mov    %rax,%rdx
ffff800000108ea3:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000108ea8:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000108ead:	48 b8 26 8b 10 00 00 	movabs $0xffff800000108b26,%rax
ffff800000108eb4:	80 ff ff 
ffff800000108eb7:	ff d0                	call   *%rax
ffff800000108eb9:	85 c0                	test   %eax,%eax
ffff800000108ebb:	78 48                	js     ffff800000108f05 <sys_write+0x78>
ffff800000108ebd:	48 8d 45 ec          	lea    -0x14(%rbp),%rax
ffff800000108ec1:	48 89 c6             	mov    %rax,%rsi
ffff800000108ec4:	bf 02 00 00 00       	mov    $0x2,%edi
ffff800000108ec9:	48 b8 01 88 10 00 00 	movabs $0xffff800000108801,%rax
ffff800000108ed0:	80 ff ff 
ffff800000108ed3:	ff d0                	call   *%rax
ffff800000108ed5:	85 c0                	test   %eax,%eax
ffff800000108ed7:	78 2c                	js     ffff800000108f05 <sys_write+0x78>
ffff800000108ed9:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff800000108edc:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff800000108ee0:	48 89 c6             	mov    %rax,%rsi
ffff800000108ee3:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000108ee8:	48 b8 66 88 10 00 00 	movabs $0xffff800000108866,%rax
ffff800000108eef:	80 ff ff 
ffff800000108ef2:	ff d0                	call   *%rax
    return -1;
  if(f->type == FD_REMOTE){
ffff800000108ef4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108ef8:	8b 00                	mov    (%rax),%eax
ffff800000108efa:	83 f8 03             	cmp    $0x3,%eax
ffff800000108efd:	0f 85 13 01 00 00    	jne    ffff800000109016 <sys_write+0x189>
ffff800000108f03:	eb 0a                	jmp    ffff800000108f0f <sys_write+0x82>
    return -1;
ffff800000108f05:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108f0a:	e9 24 01 00 00       	jmp    ffff800000109033 <sys_write+0x1a6>
    struct ipc_msg req;
    struct ipc_msg reply;
    int total;
    int chunk;

    total = 0;
ffff800000108f0f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    while(total < n){
ffff800000108f16:	e9 e4 00 00 00       	jmp    ffff800000108fff <sys_write+0x172>
      chunk = n - total;
ffff800000108f1b:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000108f1e:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff800000108f21:	89 45 f8             	mov    %eax,-0x8(%rbp)
      if(chunk > IPC_DATA_SIZE)
ffff800000108f24:	81 7d f8 80 00 00 00 	cmpl   $0x80,-0x8(%rbp)
ffff800000108f2b:	7e 07                	jle    ffff800000108f34 <sys_write+0xa7>
        chunk = IPC_DATA_SIZE;
ffff800000108f2d:	c7 45 f8 80 00 00 00 	movl   $0x80,-0x8(%rbp)

      memset(&req, 0, sizeof(req));
ffff800000108f34:	48 8d 85 20 fe ff ff 	lea    -0x1e0(%rbp),%rax
ffff800000108f3b:	ba e0 00 00 00       	mov    $0xe0,%edx
ffff800000108f40:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000108f45:	48 89 c7             	mov    %rax,%rdi
ffff800000108f48:	48 b8 40 82 10 00 00 	movabs $0xffff800000108240,%rax
ffff800000108f4f:	80 ff ff 
ffff800000108f52:	ff d0                	call   *%rax
      req.type = IPC_TYPE_FS_WRITE;
ffff800000108f54:	c7 85 28 fe ff ff 03 	movl   $0x3,-0x1d8(%rbp)
ffff800000108f5b:	00 00 00 
      req.fd = f->remote_fd;
ffff800000108f5e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108f62:	8b 40 24             	mov    0x24(%rax),%eax
ffff800000108f65:	89 85 2c fe ff ff    	mov    %eax,-0x1d4(%rbp)
      req.nbytes = chunk;
ffff800000108f6b:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000108f6e:	89 85 34 fe ff ff    	mov    %eax,-0x1cc(%rbp)
      memmove(req.data, p + total, chunk);
ffff800000108f74:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000108f77:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff800000108f7b:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000108f7e:	48 63 d2             	movslq %edx,%rdx
ffff800000108f81:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
ffff800000108f85:	48 8d 95 20 fe ff ff 	lea    -0x1e0(%rbp),%rdx
ffff800000108f8c:	48 8d 4a 60          	lea    0x60(%rdx),%rcx
ffff800000108f90:	89 c2                	mov    %eax,%edx
ffff800000108f92:	48 89 cf             	mov    %rcx,%rdi
ffff800000108f95:	48 b8 4d 83 10 00 00 	movabs $0xffff80000010834d,%rax
ffff800000108f9c:	80 ff ff 
ffff800000108f9f:	ff d0                	call   *%rax

      if(fs_ipc_call(&req, &reply) < 0 || reply.result < 0)
ffff800000108fa1:	48 8d 95 00 ff ff ff 	lea    -0x100(%rbp),%rdx
ffff800000108fa8:	48 8d 85 20 fe ff ff 	lea    -0x1e0(%rbp),%rax
ffff800000108faf:	48 89 d6             	mov    %rdx,%rsi
ffff800000108fb2:	48 89 c7             	mov    %rax,%rdi
ffff800000108fb5:	48 b8 6c 8a 10 00 00 	movabs $0xffff800000108a6c,%rax
ffff800000108fbc:	80 ff ff 
ffff800000108fbf:	ff d0                	call   *%rax
ffff800000108fc1:	85 c0                	test   %eax,%eax
ffff800000108fc3:	78 0a                	js     ffff800000108fcf <sys_write+0x142>
ffff800000108fc5:	8b 85 18 ff ff ff    	mov    -0xe8(%rbp),%eax
ffff800000108fcb:	85 c0                	test   %eax,%eax
ffff800000108fcd:	79 12                	jns    ffff800000108fe1 <sys_write+0x154>
        return total > 0 ? total : -1;
ffff800000108fcf:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000108fd3:	7e 05                	jle    ffff800000108fda <sys_write+0x14d>
ffff800000108fd5:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000108fd8:	eb 59                	jmp    ffff800000109033 <sys_write+0x1a6>
ffff800000108fda:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108fdf:	eb 52                	jmp    ffff800000109033 <sys_write+0x1a6>
      if(reply.result == 0)
ffff800000108fe1:	8b 85 18 ff ff ff    	mov    -0xe8(%rbp),%eax
ffff800000108fe7:	85 c0                	test   %eax,%eax
ffff800000108fe9:	74 22                	je     ffff80000010900d <sys_write+0x180>
        break;
      total += reply.result;
ffff800000108feb:	8b 85 18 ff ff ff    	mov    -0xe8(%rbp),%eax
ffff800000108ff1:	01 45 fc             	add    %eax,-0x4(%rbp)
      if(reply.result < chunk)
ffff800000108ff4:	8b 85 18 ff ff ff    	mov    -0xe8(%rbp),%eax
ffff800000108ffa:	39 45 f8             	cmp    %eax,-0x8(%rbp)
ffff800000108ffd:	7f 11                	jg     ffff800000109010 <sys_write+0x183>
    while(total < n){
ffff800000108fff:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000109002:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000109005:	0f 8c 10 ff ff ff    	jl     ffff800000108f1b <sys_write+0x8e>
ffff80000010900b:	eb 04                	jmp    ffff800000109011 <sys_write+0x184>
        break;
ffff80000010900d:	90                   	nop
ffff80000010900e:	eb 01                	jmp    ffff800000109011 <sys_write+0x184>
        break;
ffff800000109010:	90                   	nop
    }
    return total;
ffff800000109011:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000109014:	eb 1d                	jmp    ffff800000109033 <sys_write+0x1a6>
  }
  return filewrite(f, p, n);
ffff800000109016:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff800000109019:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff80000010901d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109021:	48 89 ce             	mov    %rcx,%rsi
ffff800000109024:	48 89 c7             	mov    %rax,%rdi
ffff800000109027:	48 b8 11 20 10 00 00 	movabs $0xffff800000102011,%rax
ffff80000010902e:	80 ff ff 
ffff800000109031:	ff d0                	call   *%rax
}
ffff800000109033:	c9                   	leave
ffff800000109034:	c3                   	ret

ffff800000109035 <sys_close>:

int
sys_close(void)
{
ffff800000109035:	f3 0f 1e fa          	endbr64
ffff800000109039:	55                   	push   %rbp
ffff80000010903a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010903d:	48 81 ec d0 01 00 00 	sub    $0x1d0,%rsp

  // DONE(17-reroute-close): What: if fd is a remote fsserver descriptor, send
  // IPC_TYPE_FS_CLOSE and clear client-side descriptor state only after the
  // server confirms or returns a defined error. Why: close() owns cleanup, so
  // stale remote descriptors here will leak server-side file state.
  if(argfd(0, &fd, &f) < 0)
ffff800000109044:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
ffff800000109048:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff80000010904c:	48 89 c6             	mov    %rax,%rsi
ffff80000010904f:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000109054:	48 b8 26 8b 10 00 00 	movabs $0xffff800000108b26,%rax
ffff80000010905b:	80 ff ff 
ffff80000010905e:	ff d0                	call   *%rax
ffff800000109060:	85 c0                	test   %eax,%eax
ffff800000109062:	79 0a                	jns    ffff80000010906e <sys_close+0x39>
    return -1;
ffff800000109064:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109069:	e9 e6 00 00 00       	jmp    ffff800000109154 <sys_close+0x11f>
  if(f->type == FD_REMOTE){
ffff80000010906e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109072:	8b 00                	mov    (%rax),%eax
ffff800000109074:	83 f8 03             	cmp    $0x3,%eax
ffff800000109077:	0f 85 a1 00 00 00    	jne    ffff80000010911e <sys_close+0xe9>
    struct ipc_msg req;
    struct ipc_msg reply;
    int result;

    memset(&req, 0, sizeof(req));
ffff80000010907d:	48 8d 85 30 fe ff ff 	lea    -0x1d0(%rbp),%rax
ffff800000109084:	ba e0 00 00 00       	mov    $0xe0,%edx
ffff800000109089:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010908e:	48 89 c7             	mov    %rax,%rdi
ffff800000109091:	48 b8 40 82 10 00 00 	movabs $0xffff800000108240,%rax
ffff800000109098:	80 ff ff 
ffff80000010909b:	ff d0                	call   *%rax
    req.type = IPC_TYPE_FS_CLOSE;
ffff80000010909d:	c7 85 38 fe ff ff 04 	movl   $0x4,-0x1c8(%rbp)
ffff8000001090a4:	00 00 00 
    req.fd = f->remote_fd;
ffff8000001090a7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001090ab:	8b 40 24             	mov    0x24(%rax),%eax
ffff8000001090ae:	89 85 3c fe ff ff    	mov    %eax,-0x1c4(%rbp)

    result = -1;
ffff8000001090b4:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
    if(fs_ipc_call(&req, &reply) == 0)
ffff8000001090bb:	48 8d 95 10 ff ff ff 	lea    -0xf0(%rbp),%rdx
ffff8000001090c2:	48 8d 85 30 fe ff ff 	lea    -0x1d0(%rbp),%rax
ffff8000001090c9:	48 89 d6             	mov    %rdx,%rsi
ffff8000001090cc:	48 89 c7             	mov    %rax,%rdi
ffff8000001090cf:	48 b8 6c 8a 10 00 00 	movabs $0xffff800000108a6c,%rax
ffff8000001090d6:	80 ff ff 
ffff8000001090d9:	ff d0                	call   *%rax
ffff8000001090db:	85 c0                	test   %eax,%eax
ffff8000001090dd:	75 09                	jne    ffff8000001090e8 <sys_close+0xb3>
      result = reply.result;
ffff8000001090df:	8b 85 28 ff ff ff    	mov    -0xd8(%rbp),%eax
ffff8000001090e5:	89 45 fc             	mov    %eax,-0x4(%rbp)

    proc->ofile[fd] = 0;
ffff8000001090e8:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001090ef:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001090f3:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffff8000001090f6:	48 63 d2             	movslq %edx,%rdx
ffff8000001090f9:	48 83 c2 08          	add    $0x8,%rdx
ffff8000001090fd:	48 c7 44 d0 08 00 00 	movq   $0x0,0x8(%rax,%rdx,8)
ffff800000109104:	00 00 
    fileclose(f);
ffff800000109106:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010910a:	48 89 c7             	mov    %rax,%rdi
ffff80000010910d:	48 b8 38 1d 10 00 00 	movabs $0xffff800000101d38,%rax
ffff800000109114:	80 ff ff 
ffff800000109117:	ff d0                	call   *%rax
    return result;
ffff800000109119:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010911c:	eb 36                	jmp    ffff800000109154 <sys_close+0x11f>
  }
  proc->ofile[fd] = 0;
ffff80000010911e:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109125:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109129:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffff80000010912c:	48 63 d2             	movslq %edx,%rdx
ffff80000010912f:	48 83 c2 08          	add    $0x8,%rdx
ffff800000109133:	48 c7 44 d0 08 00 00 	movq   $0x0,0x8(%rax,%rdx,8)
ffff80000010913a:	00 00 
  fileclose(f);
ffff80000010913c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109140:	48 89 c7             	mov    %rax,%rdi
ffff800000109143:	48 b8 38 1d 10 00 00 	movabs $0xffff800000101d38,%rax
ffff80000010914a:	80 ff ff 
ffff80000010914d:	ff d0                	call   *%rax
  return 0;
ffff80000010914f:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000109154:	c9                   	leave
ffff800000109155:	c3                   	ret

ffff800000109156 <sys_fstat>:

int
sys_fstat(void)
{
ffff800000109156:	f3 0f 1e fa          	endbr64
ffff80000010915a:	55                   	push   %rbp
ffff80000010915b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010915e:	48 83 ec 10          	sub    $0x10,%rsp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
ffff800000109162:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff800000109166:	48 89 c2             	mov    %rax,%rdx
ffff800000109169:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010916e:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000109173:	48 b8 26 8b 10 00 00 	movabs $0xffff800000108b26,%rax
ffff80000010917a:	80 ff ff 
ffff80000010917d:	ff d0                	call   *%rax
ffff80000010917f:	85 c0                	test   %eax,%eax
ffff800000109181:	78 39                	js     ffff8000001091bc <sys_fstat+0x66>
ffff800000109183:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff800000109187:	ba 14 00 00 00       	mov    $0x14,%edx
ffff80000010918c:	48 89 c6             	mov    %rax,%rsi
ffff80000010918f:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000109194:	48 b8 66 88 10 00 00 	movabs $0xffff800000108866,%rax
ffff80000010919b:	80 ff ff 
ffff80000010919e:	ff d0                	call   *%rax
    return -1;
  return filestat(f, st);
ffff8000001091a0:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff8000001091a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001091a8:	48 89 d6             	mov    %rdx,%rsi
ffff8000001091ab:	48 89 c7             	mov    %rax,%rdi
ffff8000001091ae:	48 b8 a0 1e 10 00 00 	movabs $0xffff800000101ea0,%rax
ffff8000001091b5:	80 ff ff 
ffff8000001091b8:	ff d0                	call   *%rax
ffff8000001091ba:	eb 05                	jmp    ffff8000001091c1 <sys_fstat+0x6b>
    return -1;
ffff8000001091bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff8000001091c1:	c9                   	leave
ffff8000001091c2:	c3                   	ret

ffff8000001091c3 <isdirempty>:

static int
isdirempty(struct inode *dp)
{
ffff8000001091c3:	f3 0f 1e fa          	endbr64
ffff8000001091c7:	55                   	push   %rbp
ffff8000001091c8:	48 89 e5             	mov    %rsp,%rbp
ffff8000001091cb:	48 83 ec 30          	sub    $0x30,%rsp
ffff8000001091cf:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  int off;
  struct dirent de;
  // Is the directory dp empty except for "." and ".." ?
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
ffff8000001091d3:	c7 45 fc 20 00 00 00 	movl   $0x20,-0x4(%rbp)
ffff8000001091da:	eb 56                	jmp    ffff800000109232 <isdirempty+0x6f>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffff8000001091dc:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001091df:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffff8000001091e3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001091e7:	b9 10 00 00 00       	mov    $0x10,%ecx
ffff8000001091ec:	48 89 c7             	mov    %rax,%rdi
ffff8000001091ef:	48 b8 63 30 10 00 00 	movabs $0xffff800000103063,%rax
ffff8000001091f6:	80 ff ff 
ffff8000001091f9:	ff d0                	call   *%rax
ffff8000001091fb:	83 f8 10             	cmp    $0x10,%eax
ffff8000001091fe:	74 19                	je     ffff800000109219 <isdirempty+0x56>
      panic("isdirempty: readi");
ffff800000109200:	48 b8 04 d4 10 00 00 	movabs $0xffff80000010d404,%rax
ffff800000109207:	80 ff ff 
ffff80000010920a:	48 89 c7             	mov    %rax,%rdi
ffff80000010920d:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000109214:	80 ff ff 
ffff800000109217:	ff d0                	call   *%rax
    if(de.inum != 0)
ffff800000109219:	0f b7 45 e0          	movzwl -0x20(%rbp),%eax
ffff80000010921d:	66 85 c0             	test   %ax,%ax
ffff800000109220:	74 07                	je     ffff800000109229 <isdirempty+0x66>
      return 0;
ffff800000109222:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109227:	eb 1f                	jmp    ffff800000109248 <isdirempty+0x85>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
ffff800000109229:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010922c:	83 c0 10             	add    $0x10,%eax
ffff80000010922f:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000109232:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000109236:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff80000010923c:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010923f:	39 c2                	cmp    %eax,%edx
ffff800000109241:	72 99                	jb     ffff8000001091dc <isdirempty+0x19>
  }
  return 1;
ffff800000109243:	b8 01 00 00 00       	mov    $0x1,%eax
}
ffff800000109248:	c9                   	leave
ffff800000109249:	c3                   	ret

ffff80000010924a <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
ffff80000010924a:	f3 0f 1e fa          	endbr64
ffff80000010924e:	55                   	push   %rbp
ffff80000010924f:	48 89 e5             	mov    %rsp,%rbp
ffff800000109252:	48 83 ec 30          	sub    $0x30,%rsp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
ffff800000109256:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffff80000010925a:	48 89 c6             	mov    %rax,%rsi
ffff80000010925d:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000109262:	48 b8 f1 88 10 00 00 	movabs $0xffff8000001088f1,%rax
ffff800000109269:	80 ff ff 
ffff80000010926c:	ff d0                	call   *%rax
ffff80000010926e:	85 c0                	test   %eax,%eax
ffff800000109270:	78 1c                	js     ffff80000010928e <sys_link+0x44>
ffff800000109272:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
ffff800000109276:	48 89 c6             	mov    %rax,%rsi
ffff800000109279:	bf 01 00 00 00       	mov    $0x1,%edi
ffff80000010927e:	48 b8 f1 88 10 00 00 	movabs $0xffff8000001088f1,%rax
ffff800000109285:	80 ff ff 
ffff800000109288:	ff d0                	call   *%rax
ffff80000010928a:	85 c0                	test   %eax,%eax
ffff80000010928c:	79 0a                	jns    ffff800000109298 <sys_link+0x4e>
    return -1;
ffff80000010928e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109293:	e9 0c 02 00 00       	jmp    ffff8000001094a4 <sys_link+0x25a>

  begin_op();
ffff800000109298:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010929d:	48 ba e8 50 10 00 00 	movabs $0xffff8000001050e8,%rdx
ffff8000001092a4:	80 ff ff 
ffff8000001092a7:	ff d2                	call   *%rdx
  if((ip = namei(old)) == 0){
ffff8000001092a9:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff8000001092ad:	48 89 c7             	mov    %rax,%rdi
ffff8000001092b0:	48 b8 1d 39 10 00 00 	movabs $0xffff80000010391d,%rax
ffff8000001092b7:	80 ff ff 
ffff8000001092ba:	ff d0                	call   *%rax
ffff8000001092bc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001092c0:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff8000001092c5:	75 1b                	jne    ffff8000001092e2 <sys_link+0x98>
    end_op();
ffff8000001092c7:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001092cc:	48 ba d4 51 10 00 00 	movabs $0xffff8000001051d4,%rdx
ffff8000001092d3:	80 ff ff 
ffff8000001092d6:	ff d2                	call   *%rdx
    return -1;
ffff8000001092d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001092dd:	e9 c2 01 00 00       	jmp    ffff8000001094a4 <sys_link+0x25a>
  }

  ilock(ip);
ffff8000001092e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001092e6:	48 89 c7             	mov    %rax,%rdi
ffff8000001092e9:	48 b8 de 29 10 00 00 	movabs $0xffff8000001029de,%rax
ffff8000001092f0:	80 ff ff 
ffff8000001092f3:	ff d0                	call   *%rax
  if(ip->type == T_DIR){
ffff8000001092f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001092f9:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000109300:	66 83 f8 01          	cmp    $0x1,%ax
ffff800000109304:	75 2e                	jne    ffff800000109334 <sys_link+0xea>
    iunlockput(ip);
ffff800000109306:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010930a:	48 89 c7             	mov    %rax,%rdi
ffff80000010930d:	48 b8 e7 2c 10 00 00 	movabs $0xffff800000102ce7,%rax
ffff800000109314:	80 ff ff 
ffff800000109317:	ff d0                	call   *%rax
    end_op();
ffff800000109319:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010931e:	48 ba d4 51 10 00 00 	movabs $0xffff8000001051d4,%rdx
ffff800000109325:	80 ff ff 
ffff800000109328:	ff d2                	call   *%rdx
    return -1;
ffff80000010932a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010932f:	e9 70 01 00 00       	jmp    ffff8000001094a4 <sys_link+0x25a>
  }

  ip->nlink++;
ffff800000109334:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109338:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff80000010933f:	83 c0 01             	add    $0x1,%eax
ffff800000109342:	89 c2                	mov    %eax,%edx
ffff800000109344:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109348:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
  iupdate(ip);
ffff80000010934f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109353:	48 89 c7             	mov    %rax,%rdi
ffff800000109356:	48 b8 2e 27 10 00 00 	movabs $0xffff80000010272e,%rax
ffff80000010935d:	80 ff ff 
ffff800000109360:	ff d0                	call   *%rax
  iunlock(ip);
ffff800000109362:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109366:	48 89 c7             	mov    %rax,%rdi
ffff800000109369:	48 b8 79 2b 10 00 00 	movabs $0xffff800000102b79,%rax
ffff800000109370:	80 ff ff 
ffff800000109373:	ff d0                	call   *%rax

  if((dp = nameiparent(new, name)) == 0)
ffff800000109375:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000109379:	48 8d 55 e2          	lea    -0x1e(%rbp),%rdx
ffff80000010937d:	48 89 d6             	mov    %rdx,%rsi
ffff800000109380:	48 89 c7             	mov    %rax,%rdi
ffff800000109383:	48 b8 4b 39 10 00 00 	movabs $0xffff80000010394b,%rax
ffff80000010938a:	80 ff ff 
ffff80000010938d:	ff d0                	call   *%rax
ffff80000010938f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000109393:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000109398:	0f 84 9b 00 00 00    	je     ffff800000109439 <sys_link+0x1ef>
    goto bad;
  ilock(dp);
ffff80000010939e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001093a2:	48 89 c7             	mov    %rax,%rdi
ffff8000001093a5:	48 b8 de 29 10 00 00 	movabs $0xffff8000001029de,%rax
ffff8000001093ac:	80 ff ff 
ffff8000001093af:	ff d0                	call   *%rax
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
ffff8000001093b1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001093b5:	8b 10                	mov    (%rax),%edx
ffff8000001093b7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001093bb:	8b 00                	mov    (%rax),%eax
ffff8000001093bd:	39 c2                	cmp    %eax,%edx
ffff8000001093bf:	75 25                	jne    ffff8000001093e6 <sys_link+0x19c>
ffff8000001093c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001093c5:	8b 50 04             	mov    0x4(%rax),%edx
ffff8000001093c8:	48 8d 4d e2          	lea    -0x1e(%rbp),%rcx
ffff8000001093cc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001093d0:	48 89 ce             	mov    %rcx,%rsi
ffff8000001093d3:	48 89 c7             	mov    %rax,%rdi
ffff8000001093d6:	48 b8 87 35 10 00 00 	movabs $0xffff800000103587,%rax
ffff8000001093dd:	80 ff ff 
ffff8000001093e0:	ff d0                	call   *%rax
ffff8000001093e2:	85 c0                	test   %eax,%eax
ffff8000001093e4:	79 15                	jns    ffff8000001093fb <sys_link+0x1b1>
    iunlockput(dp);
ffff8000001093e6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001093ea:	48 89 c7             	mov    %rax,%rdi
ffff8000001093ed:	48 b8 e7 2c 10 00 00 	movabs $0xffff800000102ce7,%rax
ffff8000001093f4:	80 ff ff 
ffff8000001093f7:	ff d0                	call   *%rax
    goto bad;
ffff8000001093f9:	eb 3f                	jmp    ffff80000010943a <sys_link+0x1f0>
  }
  iunlockput(dp);
ffff8000001093fb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001093ff:	48 89 c7             	mov    %rax,%rdi
ffff800000109402:	48 b8 e7 2c 10 00 00 	movabs $0xffff800000102ce7,%rax
ffff800000109409:	80 ff ff 
ffff80000010940c:	ff d0                	call   *%rax
  iput(ip);
ffff80000010940e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109412:	48 89 c7             	mov    %rax,%rdi
ffff800000109415:	48 b8 e9 2b 10 00 00 	movabs $0xffff800000102be9,%rax
ffff80000010941c:	80 ff ff 
ffff80000010941f:	ff d0                	call   *%rax

  end_op();
ffff800000109421:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109426:	48 ba d4 51 10 00 00 	movabs $0xffff8000001051d4,%rdx
ffff80000010942d:	80 ff ff 
ffff800000109430:	ff d2                	call   *%rdx

  return 0;
ffff800000109432:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109437:	eb 6b                	jmp    ffff8000001094a4 <sys_link+0x25a>
    goto bad;
ffff800000109439:	90                   	nop

bad:
  ilock(ip);
ffff80000010943a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010943e:	48 89 c7             	mov    %rax,%rdi
ffff800000109441:	48 b8 de 29 10 00 00 	movabs $0xffff8000001029de,%rax
ffff800000109448:	80 ff ff 
ffff80000010944b:	ff d0                	call   *%rax
  ip->nlink--;
ffff80000010944d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109451:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff800000109458:	83 e8 01             	sub    $0x1,%eax
ffff80000010945b:	89 c2                	mov    %eax,%edx
ffff80000010945d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109461:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
  iupdate(ip);
ffff800000109468:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010946c:	48 89 c7             	mov    %rax,%rdi
ffff80000010946f:	48 b8 2e 27 10 00 00 	movabs $0xffff80000010272e,%rax
ffff800000109476:	80 ff ff 
ffff800000109479:	ff d0                	call   *%rax
  iunlockput(ip);
ffff80000010947b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010947f:	48 89 c7             	mov    %rax,%rdi
ffff800000109482:	48 b8 e7 2c 10 00 00 	movabs $0xffff800000102ce7,%rax
ffff800000109489:	80 ff ff 
ffff80000010948c:	ff d0                	call   *%rax
  end_op();
ffff80000010948e:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109493:	48 ba d4 51 10 00 00 	movabs $0xffff8000001051d4,%rdx
ffff80000010949a:	80 ff ff 
ffff80000010949d:	ff d2                	call   *%rdx
  return -1;
ffff80000010949f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff8000001094a4:	c9                   	leave
ffff8000001094a5:	c3                   	ret

ffff8000001094a6 <sys_unlink>:
//PAGEBREAK!

int
sys_unlink(void)
{
ffff8000001094a6:	f3 0f 1e fa          	endbr64
ffff8000001094aa:	55                   	push   %rbp
ffff8000001094ab:	48 89 e5             	mov    %rsp,%rbp
ffff8000001094ae:	48 83 ec 40          	sub    $0x40,%rsp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
ffff8000001094b2:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
ffff8000001094b6:	48 89 c6             	mov    %rax,%rsi
ffff8000001094b9:	bf 00 00 00 00       	mov    $0x0,%edi
ffff8000001094be:	48 b8 f1 88 10 00 00 	movabs $0xffff8000001088f1,%rax
ffff8000001094c5:	80 ff ff 
ffff8000001094c8:	ff d0                	call   *%rax
ffff8000001094ca:	85 c0                	test   %eax,%eax
ffff8000001094cc:	79 0a                	jns    ffff8000001094d8 <sys_unlink+0x32>
    return -1;
ffff8000001094ce:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001094d3:	e9 8f 02 00 00       	jmp    ffff800000109767 <sys_unlink+0x2c1>

  begin_op();
ffff8000001094d8:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001094dd:	48 ba e8 50 10 00 00 	movabs $0xffff8000001050e8,%rdx
ffff8000001094e4:	80 ff ff 
ffff8000001094e7:	ff d2                	call   *%rdx
  if((dp = nameiparent(path, name)) == 0){
ffff8000001094e9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff8000001094ed:	48 8d 55 d2          	lea    -0x2e(%rbp),%rdx
ffff8000001094f1:	48 89 d6             	mov    %rdx,%rsi
ffff8000001094f4:	48 89 c7             	mov    %rax,%rdi
ffff8000001094f7:	48 b8 4b 39 10 00 00 	movabs $0xffff80000010394b,%rax
ffff8000001094fe:	80 ff ff 
ffff800000109501:	ff d0                	call   *%rax
ffff800000109503:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000109507:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff80000010950c:	75 1b                	jne    ffff800000109529 <sys_unlink+0x83>
    end_op();
ffff80000010950e:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109513:	48 ba d4 51 10 00 00 	movabs $0xffff8000001051d4,%rdx
ffff80000010951a:	80 ff ff 
ffff80000010951d:	ff d2                	call   *%rdx
    return -1;
ffff80000010951f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109524:	e9 3e 02 00 00       	jmp    ffff800000109767 <sys_unlink+0x2c1>
  }

  ilock(dp);
ffff800000109529:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010952d:	48 89 c7             	mov    %rax,%rdi
ffff800000109530:	48 b8 de 29 10 00 00 	movabs $0xffff8000001029de,%rax
ffff800000109537:	80 ff ff 
ffff80000010953a:	ff d0                	call   *%rax

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
ffff80000010953c:	48 8d 45 d2          	lea    -0x2e(%rbp),%rax
ffff800000109540:	48 ba 16 d4 10 00 00 	movabs $0xffff80000010d416,%rdx
ffff800000109547:	80 ff ff 
ffff80000010954a:	48 89 d6             	mov    %rdx,%rsi
ffff80000010954d:	48 89 c7             	mov    %rax,%rdi
ffff800000109550:	48 b8 48 34 10 00 00 	movabs $0xffff800000103448,%rax
ffff800000109557:	80 ff ff 
ffff80000010955a:	ff d0                	call   *%rax
ffff80000010955c:	85 c0                	test   %eax,%eax
ffff80000010955e:	0f 84 d6 01 00 00    	je     ffff80000010973a <sys_unlink+0x294>
ffff800000109564:	48 8d 45 d2          	lea    -0x2e(%rbp),%rax
ffff800000109568:	48 ba 18 d4 10 00 00 	movabs $0xffff80000010d418,%rdx
ffff80000010956f:	80 ff ff 
ffff800000109572:	48 89 d6             	mov    %rdx,%rsi
ffff800000109575:	48 89 c7             	mov    %rax,%rdi
ffff800000109578:	48 b8 48 34 10 00 00 	movabs $0xffff800000103448,%rax
ffff80000010957f:	80 ff ff 
ffff800000109582:	ff d0                	call   *%rax
ffff800000109584:	85 c0                	test   %eax,%eax
ffff800000109586:	0f 84 ae 01 00 00    	je     ffff80000010973a <sys_unlink+0x294>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
ffff80000010958c:	48 8d 55 c4          	lea    -0x3c(%rbp),%rdx
ffff800000109590:	48 8d 4d d2          	lea    -0x2e(%rbp),%rcx
ffff800000109594:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109598:	48 89 ce             	mov    %rcx,%rsi
ffff80000010959b:	48 89 c7             	mov    %rax,%rdi
ffff80000010959e:	48 b8 7d 34 10 00 00 	movabs $0xffff80000010347d,%rax
ffff8000001095a5:	80 ff ff 
ffff8000001095a8:	ff d0                	call   *%rax
ffff8000001095aa:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff8000001095ae:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff8000001095b3:	0f 84 84 01 00 00    	je     ffff80000010973d <sys_unlink+0x297>
    goto bad;
  ilock(ip);
ffff8000001095b9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001095bd:	48 89 c7             	mov    %rax,%rdi
ffff8000001095c0:	48 b8 de 29 10 00 00 	movabs $0xffff8000001029de,%rax
ffff8000001095c7:	80 ff ff 
ffff8000001095ca:	ff d0                	call   *%rax

  if(ip->nlink < 1)
ffff8000001095cc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001095d0:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff8000001095d7:	66 85 c0             	test   %ax,%ax
ffff8000001095da:	7f 19                	jg     ffff8000001095f5 <sys_unlink+0x14f>
    panic("unlink: nlink < 1");
ffff8000001095dc:	48 b8 1b d4 10 00 00 	movabs $0xffff80000010d41b,%rax
ffff8000001095e3:	80 ff ff 
ffff8000001095e6:	48 89 c7             	mov    %rax,%rdi
ffff8000001095e9:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff8000001095f0:	80 ff ff 
ffff8000001095f3:	ff d0                	call   *%rax
  if(ip->type == T_DIR && !isdirempty(ip)){
ffff8000001095f5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001095f9:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000109600:	66 83 f8 01          	cmp    $0x1,%ax
ffff800000109604:	75 2f                	jne    ffff800000109635 <sys_unlink+0x18f>
ffff800000109606:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010960a:	48 89 c7             	mov    %rax,%rdi
ffff80000010960d:	48 b8 c3 91 10 00 00 	movabs $0xffff8000001091c3,%rax
ffff800000109614:	80 ff ff 
ffff800000109617:	ff d0                	call   *%rax
ffff800000109619:	85 c0                	test   %eax,%eax
ffff80000010961b:	75 18                	jne    ffff800000109635 <sys_unlink+0x18f>
    iunlockput(ip);
ffff80000010961d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109621:	48 89 c7             	mov    %rax,%rdi
ffff800000109624:	48 b8 e7 2c 10 00 00 	movabs $0xffff800000102ce7,%rax
ffff80000010962b:	80 ff ff 
ffff80000010962e:	ff d0                	call   *%rax
    goto bad;
ffff800000109630:	e9 09 01 00 00       	jmp    ffff80000010973e <sys_unlink+0x298>
  }

  memset(&de, 0, sizeof(de));
ffff800000109635:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff800000109639:	ba 10 00 00 00       	mov    $0x10,%edx
ffff80000010963e:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000109643:	48 89 c7             	mov    %rax,%rdi
ffff800000109646:	48 b8 40 82 10 00 00 	movabs $0xffff800000108240,%rax
ffff80000010964d:	80 ff ff 
ffff800000109650:	ff d0                	call   *%rax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffff800000109652:	8b 55 c4             	mov    -0x3c(%rbp),%edx
ffff800000109655:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffff800000109659:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010965d:	b9 10 00 00 00       	mov    $0x10,%ecx
ffff800000109662:	48 89 c7             	mov    %rax,%rdi
ffff800000109665:	48 b8 34 32 10 00 00 	movabs $0xffff800000103234,%rax
ffff80000010966c:	80 ff ff 
ffff80000010966f:	ff d0                	call   *%rax
ffff800000109671:	83 f8 10             	cmp    $0x10,%eax
ffff800000109674:	74 19                	je     ffff80000010968f <sys_unlink+0x1e9>
    panic("unlink: writei");
ffff800000109676:	48 b8 2d d4 10 00 00 	movabs $0xffff80000010d42d,%rax
ffff80000010967d:	80 ff ff 
ffff800000109680:	48 89 c7             	mov    %rax,%rdi
ffff800000109683:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010968a:	80 ff ff 
ffff80000010968d:	ff d0                	call   *%rax
  if(ip->type == T_DIR){
ffff80000010968f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109693:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff80000010969a:	66 83 f8 01          	cmp    $0x1,%ax
ffff80000010969e:	75 2e                	jne    ffff8000001096ce <sys_unlink+0x228>
    dp->nlink--;
ffff8000001096a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001096a4:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff8000001096ab:	83 e8 01             	sub    $0x1,%eax
ffff8000001096ae:	89 c2                	mov    %eax,%edx
ffff8000001096b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001096b4:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
    iupdate(dp);
ffff8000001096bb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001096bf:	48 89 c7             	mov    %rax,%rdi
ffff8000001096c2:	48 b8 2e 27 10 00 00 	movabs $0xffff80000010272e,%rax
ffff8000001096c9:	80 ff ff 
ffff8000001096cc:	ff d0                	call   *%rax
  }
  iunlockput(dp);
ffff8000001096ce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001096d2:	48 89 c7             	mov    %rax,%rdi
ffff8000001096d5:	48 b8 e7 2c 10 00 00 	movabs $0xffff800000102ce7,%rax
ffff8000001096dc:	80 ff ff 
ffff8000001096df:	ff d0                	call   *%rax

  ip->nlink--;
ffff8000001096e1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001096e5:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff8000001096ec:	83 e8 01             	sub    $0x1,%eax
ffff8000001096ef:	89 c2                	mov    %eax,%edx
ffff8000001096f1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001096f5:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
  iupdate(ip);
ffff8000001096fc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109700:	48 89 c7             	mov    %rax,%rdi
ffff800000109703:	48 b8 2e 27 10 00 00 	movabs $0xffff80000010272e,%rax
ffff80000010970a:	80 ff ff 
ffff80000010970d:	ff d0                	call   *%rax
  iunlockput(ip);
ffff80000010970f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109713:	48 89 c7             	mov    %rax,%rdi
ffff800000109716:	48 b8 e7 2c 10 00 00 	movabs $0xffff800000102ce7,%rax
ffff80000010971d:	80 ff ff 
ffff800000109720:	ff d0                	call   *%rax

  end_op();
ffff800000109722:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109727:	48 ba d4 51 10 00 00 	movabs $0xffff8000001051d4,%rdx
ffff80000010972e:	80 ff ff 
ffff800000109731:	ff d2                	call   *%rdx

  return 0;
ffff800000109733:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109738:	eb 2d                	jmp    ffff800000109767 <sys_unlink+0x2c1>
    goto bad;
ffff80000010973a:	90                   	nop
ffff80000010973b:	eb 01                	jmp    ffff80000010973e <sys_unlink+0x298>
    goto bad;
ffff80000010973d:	90                   	nop

bad:
  iunlockput(dp);
ffff80000010973e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109742:	48 89 c7             	mov    %rax,%rdi
ffff800000109745:	48 b8 e7 2c 10 00 00 	movabs $0xffff800000102ce7,%rax
ffff80000010974c:	80 ff ff 
ffff80000010974f:	ff d0                	call   *%rax
  end_op();
ffff800000109751:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109756:	48 ba d4 51 10 00 00 	movabs $0xffff8000001051d4,%rdx
ffff80000010975d:	80 ff ff 
ffff800000109760:	ff d2                	call   *%rdx
  return -1;
ffff800000109762:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000109767:	c9                   	leave
ffff800000109768:	c3                   	ret

ffff800000109769 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
ffff800000109769:	f3 0f 1e fa          	endbr64
ffff80000010976d:	55                   	push   %rbp
ffff80000010976e:	48 89 e5             	mov    %rsp,%rbp
ffff800000109771:	48 83 ec 50          	sub    $0x50,%rsp
ffff800000109775:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
ffff800000109779:	89 c8                	mov    %ecx,%eax
ffff80000010977b:	89 f1                	mov    %esi,%ecx
ffff80000010977d:	66 89 4d c4          	mov    %cx,-0x3c(%rbp)
ffff800000109781:	66 89 55 c0          	mov    %dx,-0x40(%rbp)
ffff800000109785:	66 89 45 bc          	mov    %ax,-0x44(%rbp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
ffff800000109789:	48 8d 55 de          	lea    -0x22(%rbp),%rdx
ffff80000010978d:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff800000109791:	48 89 d6             	mov    %rdx,%rsi
ffff800000109794:	48 89 c7             	mov    %rax,%rdi
ffff800000109797:	48 b8 4b 39 10 00 00 	movabs $0xffff80000010394b,%rax
ffff80000010979e:	80 ff ff 
ffff8000001097a1:	ff d0                	call   *%rax
ffff8000001097a3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001097a7:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff8000001097ac:	75 0a                	jne    ffff8000001097b8 <create+0x4f>
    return 0;
ffff8000001097ae:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001097b3:	e9 2c 02 00 00       	jmp    ffff8000001099e4 <create+0x27b>
  ilock(dp);
ffff8000001097b8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001097bc:	48 89 c7             	mov    %rax,%rdi
ffff8000001097bf:	48 b8 de 29 10 00 00 	movabs $0xffff8000001029de,%rax
ffff8000001097c6:	80 ff ff 
ffff8000001097c9:	ff d0                	call   *%rax

  if((ip = dirlookup(dp, name, &off)) != 0){
ffff8000001097cb:	48 8d 55 ec          	lea    -0x14(%rbp),%rdx
ffff8000001097cf:	48 8d 4d de          	lea    -0x22(%rbp),%rcx
ffff8000001097d3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001097d7:	48 89 ce             	mov    %rcx,%rsi
ffff8000001097da:	48 89 c7             	mov    %rax,%rdi
ffff8000001097dd:	48 b8 7d 34 10 00 00 	movabs $0xffff80000010347d,%rax
ffff8000001097e4:	80 ff ff 
ffff8000001097e7:	ff d0                	call   *%rax
ffff8000001097e9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff8000001097ed:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff8000001097f2:	74 64                	je     ffff800000109858 <create+0xef>
    iunlockput(dp);
ffff8000001097f4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001097f8:	48 89 c7             	mov    %rax,%rdi
ffff8000001097fb:	48 b8 e7 2c 10 00 00 	movabs $0xffff800000102ce7,%rax
ffff800000109802:	80 ff ff 
ffff800000109805:	ff d0                	call   *%rax
    ilock(ip);
ffff800000109807:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010980b:	48 89 c7             	mov    %rax,%rdi
ffff80000010980e:	48 b8 de 29 10 00 00 	movabs $0xffff8000001029de,%rax
ffff800000109815:	80 ff ff 
ffff800000109818:	ff d0                	call   *%rax
    if(type == T_FILE && ip->type == T_FILE)
ffff80000010981a:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%rbp)
ffff80000010981f:	75 1a                	jne    ffff80000010983b <create+0xd2>
ffff800000109821:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109825:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff80000010982c:	66 83 f8 02          	cmp    $0x2,%ax
ffff800000109830:	75 09                	jne    ffff80000010983b <create+0xd2>
      return ip;
ffff800000109832:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109836:	e9 a9 01 00 00       	jmp    ffff8000001099e4 <create+0x27b>
    iunlockput(ip);
ffff80000010983b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010983f:	48 89 c7             	mov    %rax,%rdi
ffff800000109842:	48 b8 e7 2c 10 00 00 	movabs $0xffff800000102ce7,%rax
ffff800000109849:	80 ff ff 
ffff80000010984c:	ff d0                	call   *%rax
    return 0;
ffff80000010984e:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109853:	e9 8c 01 00 00       	jmp    ffff8000001099e4 <create+0x27b>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
ffff800000109858:	0f bf 55 c4          	movswl -0x3c(%rbp),%edx
ffff80000010985c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109860:	8b 00                	mov    (%rax),%eax
ffff800000109862:	89 d6                	mov    %edx,%esi
ffff800000109864:	89 c7                	mov    %eax,%edi
ffff800000109866:	48 b8 02 26 10 00 00 	movabs $0xffff800000102602,%rax
ffff80000010986d:	80 ff ff 
ffff800000109870:	ff d0                	call   *%rax
ffff800000109872:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000109876:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010987b:	75 19                	jne    ffff800000109896 <create+0x12d>
    panic("create: ialloc");
ffff80000010987d:	48 b8 3c d4 10 00 00 	movabs $0xffff80000010d43c,%rax
ffff800000109884:	80 ff ff 
ffff800000109887:	48 89 c7             	mov    %rax,%rdi
ffff80000010988a:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000109891:	80 ff ff 
ffff800000109894:	ff d0                	call   *%rax

  ilock(ip);
ffff800000109896:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010989a:	48 89 c7             	mov    %rax,%rdi
ffff80000010989d:	48 b8 de 29 10 00 00 	movabs $0xffff8000001029de,%rax
ffff8000001098a4:	80 ff ff 
ffff8000001098a7:	ff d0                	call   *%rax
  ip->major = major;
ffff8000001098a9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001098ad:	0f b7 55 c0          	movzwl -0x40(%rbp),%edx
ffff8000001098b1:	66 89 90 96 00 00 00 	mov    %dx,0x96(%rax)
  ip->minor = minor;
ffff8000001098b8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001098bc:	0f b7 55 bc          	movzwl -0x44(%rbp),%edx
ffff8000001098c0:	66 89 90 98 00 00 00 	mov    %dx,0x98(%rax)
  ip->nlink = 1;
ffff8000001098c7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001098cb:	66 c7 80 9a 00 00 00 	movw   $0x1,0x9a(%rax)
ffff8000001098d2:	01 00 
  iupdate(ip);
ffff8000001098d4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001098d8:	48 89 c7             	mov    %rax,%rdi
ffff8000001098db:	48 b8 2e 27 10 00 00 	movabs $0xffff80000010272e,%rax
ffff8000001098e2:	80 ff ff 
ffff8000001098e5:	ff d0                	call   *%rax

  if(type == T_DIR){  // Create . and .. entries.
ffff8000001098e7:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%rbp)
ffff8000001098ec:	0f 85 9d 00 00 00    	jne    ffff80000010998f <create+0x226>
    dp->nlink++;  // for ".."
ffff8000001098f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001098f6:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff8000001098fd:	83 c0 01             	add    $0x1,%eax
ffff800000109900:	89 c2                	mov    %eax,%edx
ffff800000109902:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109906:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
    iupdate(dp);
ffff80000010990d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109911:	48 89 c7             	mov    %rax,%rdi
ffff800000109914:	48 b8 2e 27 10 00 00 	movabs $0xffff80000010272e,%rax
ffff80000010991b:	80 ff ff 
ffff80000010991e:	ff d0                	call   *%rax
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
ffff800000109920:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109924:	8b 50 04             	mov    0x4(%rax),%edx
ffff800000109927:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010992b:	48 b9 16 d4 10 00 00 	movabs $0xffff80000010d416,%rcx
ffff800000109932:	80 ff ff 
ffff800000109935:	48 89 ce             	mov    %rcx,%rsi
ffff800000109938:	48 89 c7             	mov    %rax,%rdi
ffff80000010993b:	48 b8 87 35 10 00 00 	movabs $0xffff800000103587,%rax
ffff800000109942:	80 ff ff 
ffff800000109945:	ff d0                	call   *%rax
ffff800000109947:	85 c0                	test   %eax,%eax
ffff800000109949:	78 2b                	js     ffff800000109976 <create+0x20d>
ffff80000010994b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010994f:	8b 50 04             	mov    0x4(%rax),%edx
ffff800000109952:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109956:	48 b9 18 d4 10 00 00 	movabs $0xffff80000010d418,%rcx
ffff80000010995d:	80 ff ff 
ffff800000109960:	48 89 ce             	mov    %rcx,%rsi
ffff800000109963:	48 89 c7             	mov    %rax,%rdi
ffff800000109966:	48 b8 87 35 10 00 00 	movabs $0xffff800000103587,%rax
ffff80000010996d:	80 ff ff 
ffff800000109970:	ff d0                	call   *%rax
ffff800000109972:	85 c0                	test   %eax,%eax
ffff800000109974:	79 19                	jns    ffff80000010998f <create+0x226>
      panic("create dots");
ffff800000109976:	48 b8 4b d4 10 00 00 	movabs $0xffff80000010d44b,%rax
ffff80000010997d:	80 ff ff 
ffff800000109980:	48 89 c7             	mov    %rax,%rdi
ffff800000109983:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010998a:	80 ff ff 
ffff80000010998d:	ff d0                	call   *%rax
  }

  if(dirlink(dp, name, ip->inum) < 0)
ffff80000010998f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109993:	8b 50 04             	mov    0x4(%rax),%edx
ffff800000109996:	48 8d 4d de          	lea    -0x22(%rbp),%rcx
ffff80000010999a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010999e:	48 89 ce             	mov    %rcx,%rsi
ffff8000001099a1:	48 89 c7             	mov    %rax,%rdi
ffff8000001099a4:	48 b8 87 35 10 00 00 	movabs $0xffff800000103587,%rax
ffff8000001099ab:	80 ff ff 
ffff8000001099ae:	ff d0                	call   *%rax
ffff8000001099b0:	85 c0                	test   %eax,%eax
ffff8000001099b2:	79 19                	jns    ffff8000001099cd <create+0x264>
    panic("create: dirlink");
ffff8000001099b4:	48 b8 57 d4 10 00 00 	movabs $0xffff80000010d457,%rax
ffff8000001099bb:	80 ff ff 
ffff8000001099be:	48 89 c7             	mov    %rax,%rdi
ffff8000001099c1:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff8000001099c8:	80 ff ff 
ffff8000001099cb:	ff d0                	call   *%rax

  iunlockput(dp);
ffff8000001099cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001099d1:	48 89 c7             	mov    %rax,%rdi
ffff8000001099d4:	48 b8 e7 2c 10 00 00 	movabs $0xffff800000102ce7,%rax
ffff8000001099db:	80 ff ff 
ffff8000001099de:	ff d0                	call   *%rax

  return ip;
ffff8000001099e0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
}
ffff8000001099e4:	c9                   	leave
ffff8000001099e5:	c3                   	ret

ffff8000001099e6 <sys_open>:

int
sys_open(void)
{
ffff8000001099e6:	f3 0f 1e fa          	endbr64
ffff8000001099ea:	55                   	push   %rbp
ffff8000001099eb:	48 89 e5             	mov    %rsp,%rbp
ffff8000001099ee:	48 81 ec f0 01 00 00 	sub    $0x1f0,%rsp
  // IPC_TYPE_FS_OPEN request once fsserver registration and remote descriptors
  // exist. Validate/copy the path, send flags, receive a remote fd, and install
  // client-side state that read/write/close can recognize as remote. Why: this
  // is the first point where normal user programs stop calling kernel FS logic
  // directly. Avoid recursively rerouting calls made by fsserver itself.
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
ffff8000001099f5:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff8000001099f9:	48 89 c6             	mov    %rax,%rsi
ffff8000001099fc:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000109a01:	48 b8 f1 88 10 00 00 	movabs $0xffff8000001088f1,%rax
ffff800000109a08:	80 ff ff 
ffff800000109a0b:	ff d0                	call   *%rax
ffff800000109a0d:	85 c0                	test   %eax,%eax
ffff800000109a0f:	78 1c                	js     ffff800000109a2d <sys_open+0x47>
ffff800000109a11:	48 8d 45 dc          	lea    -0x24(%rbp),%rax
ffff800000109a15:	48 89 c6             	mov    %rax,%rsi
ffff800000109a18:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000109a1d:	48 b8 01 88 10 00 00 	movabs $0xffff800000108801,%rax
ffff800000109a24:	80 ff ff 
ffff800000109a27:	ff d0                	call   *%rax
ffff800000109a29:	85 c0                	test   %eax,%eax
ffff800000109a2b:	79 0a                	jns    ffff800000109a37 <sys_open+0x51>
    return -1;
ffff800000109a2d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109a32:	e9 01 04 00 00       	jmp    ffff800000109e38 <sys_open+0x452>

  if(fsserver_active()){
ffff800000109a37:	48 b8 36 8a 10 00 00 	movabs $0xffff800000108a36,%rax
ffff800000109a3e:	80 ff ff 
ffff800000109a41:	ff d0                	call   *%rax
ffff800000109a43:	85 c0                	test   %eax,%eax
ffff800000109a45:	0f 84 f2 01 00 00    	je     ffff800000109c3d <sys_open+0x257>
    struct ipc_msg req;
    struct ipc_msg reply;

    if(strlen(path) >= IPC_PATH_SIZE)
ffff800000109a4b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000109a4f:	48 89 c7             	mov    %rax,%rdi
ffff800000109a52:	48 b8 77 85 10 00 00 	movabs $0xffff800000108577,%rax
ffff800000109a59:	80 ff ff 
ffff800000109a5c:	ff d0                	call   *%rax
ffff800000109a5e:	83 f8 3f             	cmp    $0x3f,%eax
ffff800000109a61:	7e 0a                	jle    ffff800000109a6d <sys_open+0x87>
      return -1;
ffff800000109a63:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109a68:	e9 cb 03 00 00       	jmp    ffff800000109e38 <sys_open+0x452>

    memset(&req, 0, sizeof(req));
ffff800000109a6d:	48 8d 85 10 fe ff ff 	lea    -0x1f0(%rbp),%rax
ffff800000109a74:	ba e0 00 00 00       	mov    $0xe0,%edx
ffff800000109a79:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000109a7e:	48 89 c7             	mov    %rax,%rdi
ffff800000109a81:	48 b8 40 82 10 00 00 	movabs $0xffff800000108240,%rax
ffff800000109a88:	80 ff ff 
ffff800000109a8b:	ff d0                	call   *%rax
    req.type = IPC_TYPE_FS_OPEN;
ffff800000109a8d:	c7 85 18 fe ff ff 01 	movl   $0x1,-0x1e8(%rbp)
ffff800000109a94:	00 00 00 
    req.flags = omode;
ffff800000109a97:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000109a9a:	89 85 20 fe ff ff    	mov    %eax,-0x1e0(%rbp)
    safestrcpy(req.path, path, sizeof(req.path));
ffff800000109aa0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000109aa4:	48 8d 95 10 fe ff ff 	lea    -0x1f0(%rbp),%rdx
ffff800000109aab:	48 8d 4a 20          	lea    0x20(%rdx),%rcx
ffff800000109aaf:	ba 40 00 00 00       	mov    $0x40,%edx
ffff800000109ab4:	48 89 c6             	mov    %rax,%rsi
ffff800000109ab7:	48 89 cf             	mov    %rcx,%rdi
ffff800000109aba:	48 b8 10 85 10 00 00 	movabs $0xffff800000108510,%rax
ffff800000109ac1:	80 ff ff 
ffff800000109ac4:	ff d0                	call   *%rax

    if(fs_ipc_call(&req, &reply) < 0 || reply.result < 0)
ffff800000109ac6:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
ffff800000109acd:	48 8d 85 10 fe ff ff 	lea    -0x1f0(%rbp),%rax
ffff800000109ad4:	48 89 d6             	mov    %rdx,%rsi
ffff800000109ad7:	48 89 c7             	mov    %rax,%rdi
ffff800000109ada:	48 b8 6c 8a 10 00 00 	movabs $0xffff800000108a6c,%rax
ffff800000109ae1:	80 ff ff 
ffff800000109ae4:	ff d0                	call   *%rax
ffff800000109ae6:	85 c0                	test   %eax,%eax
ffff800000109ae8:	78 0a                	js     ffff800000109af4 <sys_open+0x10e>
ffff800000109aea:	8b 85 08 ff ff ff    	mov    -0xf8(%rbp),%eax
ffff800000109af0:	85 c0                	test   %eax,%eax
ffff800000109af2:	79 0a                	jns    ffff800000109afe <sys_open+0x118>
      return -1;
ffff800000109af4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109af9:	e9 3a 03 00 00       	jmp    ffff800000109e38 <sys_open+0x452>

    if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
ffff800000109afe:	48 b8 c2 1b 10 00 00 	movabs $0xffff800000101bc2,%rax
ffff800000109b05:	80 ff ff 
ffff800000109b08:	ff d0                	call   *%rax
ffff800000109b0a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000109b0e:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000109b13:	74 1c                	je     ffff800000109b31 <sys_open+0x14b>
ffff800000109b15:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109b19:	48 89 c7             	mov    %rax,%rdi
ffff800000109b1c:	48 b8 c4 8b 10 00 00 	movabs $0xffff800000108bc4,%rax
ffff800000109b23:	80 ff ff 
ffff800000109b26:	ff d0                	call   *%rax
ffff800000109b28:	89 45 ec             	mov    %eax,-0x14(%rbp)
ffff800000109b2b:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffff800000109b2f:	79 7a                	jns    ffff800000109bab <sys_open+0x1c5>
      if(f)
ffff800000109b31:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000109b36:	74 13                	je     ffff800000109b4b <sys_open+0x165>
        fileclose(f);
ffff800000109b38:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109b3c:	48 89 c7             	mov    %rax,%rdi
ffff800000109b3f:	48 b8 38 1d 10 00 00 	movabs $0xffff800000101d38,%rax
ffff800000109b46:	80 ff ff 
ffff800000109b49:	ff d0                	call   *%rax

      memset(&req, 0, sizeof(req));
ffff800000109b4b:	48 8d 85 10 fe ff ff 	lea    -0x1f0(%rbp),%rax
ffff800000109b52:	ba e0 00 00 00       	mov    $0xe0,%edx
ffff800000109b57:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000109b5c:	48 89 c7             	mov    %rax,%rdi
ffff800000109b5f:	48 b8 40 82 10 00 00 	movabs $0xffff800000108240,%rax
ffff800000109b66:	80 ff ff 
ffff800000109b69:	ff d0                	call   *%rax
      req.type = IPC_TYPE_FS_CLOSE;
ffff800000109b6b:	c7 85 18 fe ff ff 04 	movl   $0x4,-0x1e8(%rbp)
ffff800000109b72:	00 00 00 
      req.fd = reply.fd;
ffff800000109b75:	8b 85 fc fe ff ff    	mov    -0x104(%rbp),%eax
ffff800000109b7b:	89 85 1c fe ff ff    	mov    %eax,-0x1e4(%rbp)
      fs_ipc_call(&req, &reply);
ffff800000109b81:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
ffff800000109b88:	48 8d 85 10 fe ff ff 	lea    -0x1f0(%rbp),%rax
ffff800000109b8f:	48 89 d6             	mov    %rdx,%rsi
ffff800000109b92:	48 89 c7             	mov    %rax,%rdi
ffff800000109b95:	48 b8 6c 8a 10 00 00 	movabs $0xffff800000108a6c,%rax
ffff800000109b9c:	80 ff ff 
ffff800000109b9f:	ff d0                	call   *%rax
      return -1;
ffff800000109ba1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109ba6:	e9 8d 02 00 00       	jmp    ffff800000109e38 <sys_open+0x452>
    }

    f->type = FD_REMOTE;
ffff800000109bab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109baf:	c7 00 03 00 00 00    	movl   $0x3,(%rax)
    f->ip = 0;
ffff800000109bb5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109bb9:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
ffff800000109bc0:	00 
    f->pipe = 0;
ffff800000109bc1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109bc5:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff800000109bcc:	00 
    f->off = 0;
ffff800000109bcd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109bd1:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%rax)
    f->remote_fd = reply.fd;
ffff800000109bd8:	8b 95 fc fe ff ff    	mov    -0x104(%rbp),%edx
ffff800000109bde:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109be2:	89 50 24             	mov    %edx,0x24(%rax)
    f->remote_owner = get_fsserver_pid();
ffff800000109be5:	48 b8 4b 77 10 00 00 	movabs $0xffff80000010774b,%rax
ffff800000109bec:	80 ff ff 
ffff800000109bef:	ff d0                	call   *%rax
ffff800000109bf1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000109bf5:	89 42 28             	mov    %eax,0x28(%rdx)
    f->readable = !(omode & O_WRONLY);
ffff800000109bf8:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000109bfb:	83 e0 01             	and    $0x1,%eax
ffff800000109bfe:	85 c0                	test   %eax,%eax
ffff800000109c00:	0f 94 c0             	sete   %al
ffff800000109c03:	89 c2                	mov    %eax,%edx
ffff800000109c05:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109c09:	88 50 08             	mov    %dl,0x8(%rax)
    f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
ffff800000109c0c:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000109c0f:	83 e0 01             	and    $0x1,%eax
ffff800000109c12:	85 c0                	test   %eax,%eax
ffff800000109c14:	75 0a                	jne    ffff800000109c20 <sys_open+0x23a>
ffff800000109c16:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000109c19:	83 e0 02             	and    $0x2,%eax
ffff800000109c1c:	85 c0                	test   %eax,%eax
ffff800000109c1e:	74 07                	je     ffff800000109c27 <sys_open+0x241>
ffff800000109c20:	b8 01 00 00 00       	mov    $0x1,%eax
ffff800000109c25:	eb 05                	jmp    ffff800000109c2c <sys_open+0x246>
ffff800000109c27:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109c2c:	89 c2                	mov    %eax,%edx
ffff800000109c2e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109c32:	88 50 09             	mov    %dl,0x9(%rax)
    return fd;
ffff800000109c35:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000109c38:	e9 fb 01 00 00       	jmp    ffff800000109e38 <sys_open+0x452>
  }

  begin_op();
ffff800000109c3d:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109c42:	48 ba e8 50 10 00 00 	movabs $0xffff8000001050e8,%rdx
ffff800000109c49:	80 ff ff 
ffff800000109c4c:	ff d2                	call   *%rdx

  if(omode & O_CREATE){
ffff800000109c4e:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000109c51:	25 00 02 00 00       	and    $0x200,%eax
ffff800000109c56:	85 c0                	test   %eax,%eax
ffff800000109c58:	74 4c                	je     ffff800000109ca6 <sys_open+0x2c0>
    ip = create(path, T_FILE, 0, 0);
ffff800000109c5a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000109c5e:	b9 00 00 00 00       	mov    $0x0,%ecx
ffff800000109c63:	ba 00 00 00 00       	mov    $0x0,%edx
ffff800000109c68:	be 02 00 00 00       	mov    $0x2,%esi
ffff800000109c6d:	48 89 c7             	mov    %rax,%rdi
ffff800000109c70:	48 b8 69 97 10 00 00 	movabs $0xffff800000109769,%rax
ffff800000109c77:	80 ff ff 
ffff800000109c7a:	ff d0                	call   *%rax
ffff800000109c7c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(ip == 0){
ffff800000109c80:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000109c85:	0f 85 ad 00 00 00    	jne    ffff800000109d38 <sys_open+0x352>
      end_op();
ffff800000109c8b:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109c90:	48 ba d4 51 10 00 00 	movabs $0xffff8000001051d4,%rdx
ffff800000109c97:	80 ff ff 
ffff800000109c9a:	ff d2                	call   *%rdx
      return -1;
ffff800000109c9c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109ca1:	e9 92 01 00 00       	jmp    ffff800000109e38 <sys_open+0x452>
    }
  } else {
    if((ip = namei(path)) == 0){
ffff800000109ca6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000109caa:	48 89 c7             	mov    %rax,%rdi
ffff800000109cad:	48 b8 1d 39 10 00 00 	movabs $0xffff80000010391d,%rax
ffff800000109cb4:	80 ff ff 
ffff800000109cb7:	ff d0                	call   *%rax
ffff800000109cb9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000109cbd:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000109cc2:	75 1b                	jne    ffff800000109cdf <sys_open+0x2f9>
      end_op();
ffff800000109cc4:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109cc9:	48 ba d4 51 10 00 00 	movabs $0xffff8000001051d4,%rdx
ffff800000109cd0:	80 ff ff 
ffff800000109cd3:	ff d2                	call   *%rdx
      return -1;
ffff800000109cd5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109cda:	e9 59 01 00 00       	jmp    ffff800000109e38 <sys_open+0x452>
    }
    ilock(ip);
ffff800000109cdf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109ce3:	48 89 c7             	mov    %rax,%rdi
ffff800000109ce6:	48 b8 de 29 10 00 00 	movabs $0xffff8000001029de,%rax
ffff800000109ced:	80 ff ff 
ffff800000109cf0:	ff d0                	call   *%rax
    if(ip->type == T_DIR && omode != O_RDONLY){
ffff800000109cf2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109cf6:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000109cfd:	66 83 f8 01          	cmp    $0x1,%ax
ffff800000109d01:	75 35                	jne    ffff800000109d38 <sys_open+0x352>
ffff800000109d03:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000109d06:	85 c0                	test   %eax,%eax
ffff800000109d08:	74 2e                	je     ffff800000109d38 <sys_open+0x352>
      iunlockput(ip);
ffff800000109d0a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109d0e:	48 89 c7             	mov    %rax,%rdi
ffff800000109d11:	48 b8 e7 2c 10 00 00 	movabs $0xffff800000102ce7,%rax
ffff800000109d18:	80 ff ff 
ffff800000109d1b:	ff d0                	call   *%rax
      end_op();
ffff800000109d1d:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109d22:	48 ba d4 51 10 00 00 	movabs $0xffff8000001051d4,%rdx
ffff800000109d29:	80 ff ff 
ffff800000109d2c:	ff d2                	call   *%rdx
      return -1;
ffff800000109d2e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109d33:	e9 00 01 00 00       	jmp    ffff800000109e38 <sys_open+0x452>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
ffff800000109d38:	48 b8 c2 1b 10 00 00 	movabs $0xffff800000101bc2,%rax
ffff800000109d3f:	80 ff ff 
ffff800000109d42:	ff d0                	call   *%rax
ffff800000109d44:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000109d48:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000109d4d:	74 1c                	je     ffff800000109d6b <sys_open+0x385>
ffff800000109d4f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109d53:	48 89 c7             	mov    %rax,%rdi
ffff800000109d56:	48 b8 c4 8b 10 00 00 	movabs $0xffff800000108bc4,%rax
ffff800000109d5d:	80 ff ff 
ffff800000109d60:	ff d0                	call   *%rax
ffff800000109d62:	89 45 ec             	mov    %eax,-0x14(%rbp)
ffff800000109d65:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffff800000109d69:	79 48                	jns    ffff800000109db3 <sys_open+0x3cd>
    if(f)
ffff800000109d6b:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000109d70:	74 13                	je     ffff800000109d85 <sys_open+0x39f>
      fileclose(f);
ffff800000109d72:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109d76:	48 89 c7             	mov    %rax,%rdi
ffff800000109d79:	48 b8 38 1d 10 00 00 	movabs $0xffff800000101d38,%rax
ffff800000109d80:	80 ff ff 
ffff800000109d83:	ff d0                	call   *%rax
    iunlockput(ip);
ffff800000109d85:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109d89:	48 89 c7             	mov    %rax,%rdi
ffff800000109d8c:	48 b8 e7 2c 10 00 00 	movabs $0xffff800000102ce7,%rax
ffff800000109d93:	80 ff ff 
ffff800000109d96:	ff d0                	call   *%rax
    end_op();
ffff800000109d98:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109d9d:	48 ba d4 51 10 00 00 	movabs $0xffff8000001051d4,%rdx
ffff800000109da4:	80 ff ff 
ffff800000109da7:	ff d2                	call   *%rdx
    return -1;
ffff800000109da9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109dae:	e9 85 00 00 00       	jmp    ffff800000109e38 <sys_open+0x452>
  }
  iunlock(ip);
ffff800000109db3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109db7:	48 89 c7             	mov    %rax,%rdi
ffff800000109dba:	48 b8 79 2b 10 00 00 	movabs $0xffff800000102b79,%rax
ffff800000109dc1:	80 ff ff 
ffff800000109dc4:	ff d0                	call   *%rax
  end_op();
ffff800000109dc6:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109dcb:	48 ba d4 51 10 00 00 	movabs $0xffff8000001051d4,%rdx
ffff800000109dd2:	80 ff ff 
ffff800000109dd5:	ff d2                	call   *%rdx

  f->type = FD_INODE;
ffff800000109dd7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109ddb:	c7 00 02 00 00 00    	movl   $0x2,(%rax)
  f->ip = ip;
ffff800000109de1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109de5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000109de9:	48 89 50 18          	mov    %rdx,0x18(%rax)
  f->off = 0;
ffff800000109ded:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109df1:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%rax)
  f->readable = !(omode & O_WRONLY);
ffff800000109df8:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000109dfb:	83 e0 01             	and    $0x1,%eax
ffff800000109dfe:	85 c0                	test   %eax,%eax
ffff800000109e00:	0f 94 c0             	sete   %al
ffff800000109e03:	89 c2                	mov    %eax,%edx
ffff800000109e05:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109e09:	88 50 08             	mov    %dl,0x8(%rax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
ffff800000109e0c:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000109e0f:	83 e0 01             	and    $0x1,%eax
ffff800000109e12:	85 c0                	test   %eax,%eax
ffff800000109e14:	75 0a                	jne    ffff800000109e20 <sys_open+0x43a>
ffff800000109e16:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000109e19:	83 e0 02             	and    $0x2,%eax
ffff800000109e1c:	85 c0                	test   %eax,%eax
ffff800000109e1e:	74 07                	je     ffff800000109e27 <sys_open+0x441>
ffff800000109e20:	b8 01 00 00 00       	mov    $0x1,%eax
ffff800000109e25:	eb 05                	jmp    ffff800000109e2c <sys_open+0x446>
ffff800000109e27:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109e2c:	89 c2                	mov    %eax,%edx
ffff800000109e2e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109e32:	88 50 09             	mov    %dl,0x9(%rax)
  return fd;
ffff800000109e35:	8b 45 ec             	mov    -0x14(%rbp),%eax
}
ffff800000109e38:	c9                   	leave
ffff800000109e39:	c3                   	ret

ffff800000109e3a <sys_mkdir>:

int
sys_mkdir(void)
{
ffff800000109e3a:	f3 0f 1e fa          	endbr64
ffff800000109e3e:	55                   	push   %rbp
ffff800000109e3f:	48 89 e5             	mov    %rsp,%rbp
ffff800000109e42:	48 83 ec 10          	sub    $0x10,%rsp
  char *path;
  struct inode *ip;

  begin_op();
ffff800000109e46:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109e4b:	48 ba e8 50 10 00 00 	movabs $0xffff8000001050e8,%rdx
ffff800000109e52:	80 ff ff 
ffff800000109e55:	ff d2                	call   *%rdx
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
ffff800000109e57:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff800000109e5b:	48 89 c6             	mov    %rax,%rsi
ffff800000109e5e:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000109e63:	48 b8 f1 88 10 00 00 	movabs $0xffff8000001088f1,%rax
ffff800000109e6a:	80 ff ff 
ffff800000109e6d:	ff d0                	call   *%rax
ffff800000109e6f:	85 c0                	test   %eax,%eax
ffff800000109e71:	78 2d                	js     ffff800000109ea0 <sys_mkdir+0x66>
ffff800000109e73:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109e77:	b9 00 00 00 00       	mov    $0x0,%ecx
ffff800000109e7c:	ba 00 00 00 00       	mov    $0x0,%edx
ffff800000109e81:	be 01 00 00 00       	mov    $0x1,%esi
ffff800000109e86:	48 89 c7             	mov    %rax,%rdi
ffff800000109e89:	48 b8 69 97 10 00 00 	movabs $0xffff800000109769,%rax
ffff800000109e90:	80 ff ff 
ffff800000109e93:	ff d0                	call   *%rax
ffff800000109e95:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000109e99:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000109e9e:	75 18                	jne    ffff800000109eb8 <sys_mkdir+0x7e>
    end_op();
ffff800000109ea0:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109ea5:	48 ba d4 51 10 00 00 	movabs $0xffff8000001051d4,%rdx
ffff800000109eac:	80 ff ff 
ffff800000109eaf:	ff d2                	call   *%rdx
    return -1;
ffff800000109eb1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109eb6:	eb 29                	jmp    ffff800000109ee1 <sys_mkdir+0xa7>
  }
  iunlockput(ip);
ffff800000109eb8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109ebc:	48 89 c7             	mov    %rax,%rdi
ffff800000109ebf:	48 b8 e7 2c 10 00 00 	movabs $0xffff800000102ce7,%rax
ffff800000109ec6:	80 ff ff 
ffff800000109ec9:	ff d0                	call   *%rax
  end_op();
ffff800000109ecb:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109ed0:	48 ba d4 51 10 00 00 	movabs $0xffff8000001051d4,%rdx
ffff800000109ed7:	80 ff ff 
ffff800000109eda:	ff d2                	call   *%rdx
  return 0;
ffff800000109edc:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000109ee1:	c9                   	leave
ffff800000109ee2:	c3                   	ret

ffff800000109ee3 <sys_mknod>:

int
sys_mknod(void)
{
ffff800000109ee3:	f3 0f 1e fa          	endbr64
ffff800000109ee7:	55                   	push   %rbp
ffff800000109ee8:	48 89 e5             	mov    %rsp,%rbp
ffff800000109eeb:	48 83 ec 20          	sub    $0x20,%rsp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
ffff800000109eef:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109ef4:	48 ba e8 50 10 00 00 	movabs $0xffff8000001050e8,%rdx
ffff800000109efb:	80 ff ff 
ffff800000109efe:	ff d2                	call   *%rdx
  if((argstr(0, &path)) < 0 ||
ffff800000109f00:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff800000109f04:	48 89 c6             	mov    %rax,%rsi
ffff800000109f07:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000109f0c:	48 b8 f1 88 10 00 00 	movabs $0xffff8000001088f1,%rax
ffff800000109f13:	80 ff ff 
ffff800000109f16:	ff d0                	call   *%rax
ffff800000109f18:	85 c0                	test   %eax,%eax
ffff800000109f1a:	78 67                	js     ffff800000109f83 <sys_mknod+0xa0>
     argint(1, &major) < 0 ||
ffff800000109f1c:	48 8d 45 ec          	lea    -0x14(%rbp),%rax
ffff800000109f20:	48 89 c6             	mov    %rax,%rsi
ffff800000109f23:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000109f28:	48 b8 01 88 10 00 00 	movabs $0xffff800000108801,%rax
ffff800000109f2f:	80 ff ff 
ffff800000109f32:	ff d0                	call   *%rax
  if((argstr(0, &path)) < 0 ||
ffff800000109f34:	85 c0                	test   %eax,%eax
ffff800000109f36:	78 4b                	js     ffff800000109f83 <sys_mknod+0xa0>
     argint(2, &minor) < 0 ||
ffff800000109f38:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffff800000109f3c:	48 89 c6             	mov    %rax,%rsi
ffff800000109f3f:	bf 02 00 00 00       	mov    $0x2,%edi
ffff800000109f44:	48 b8 01 88 10 00 00 	movabs $0xffff800000108801,%rax
ffff800000109f4b:	80 ff ff 
ffff800000109f4e:	ff d0                	call   *%rax
     argint(1, &major) < 0 ||
ffff800000109f50:	85 c0                	test   %eax,%eax
ffff800000109f52:	78 2f                	js     ffff800000109f83 <sys_mknod+0xa0>
     (ip = create(path, T_DEV, major, minor)) == 0){
ffff800000109f54:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000109f57:	0f bf c8             	movswl %ax,%ecx
ffff800000109f5a:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000109f5d:	0f bf d0             	movswl %ax,%edx
ffff800000109f60:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109f64:	be 03 00 00 00       	mov    $0x3,%esi
ffff800000109f69:	48 89 c7             	mov    %rax,%rdi
ffff800000109f6c:	48 b8 69 97 10 00 00 	movabs $0xffff800000109769,%rax
ffff800000109f73:	80 ff ff 
ffff800000109f76:	ff d0                	call   *%rax
ffff800000109f78:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
     argint(2, &minor) < 0 ||
ffff800000109f7c:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000109f81:	75 18                	jne    ffff800000109f9b <sys_mknod+0xb8>
    end_op();
ffff800000109f83:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109f88:	48 ba d4 51 10 00 00 	movabs $0xffff8000001051d4,%rdx
ffff800000109f8f:	80 ff ff 
ffff800000109f92:	ff d2                	call   *%rdx
    return -1;
ffff800000109f94:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109f99:	eb 29                	jmp    ffff800000109fc4 <sys_mknod+0xe1>
  }
  iunlockput(ip);
ffff800000109f9b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109f9f:	48 89 c7             	mov    %rax,%rdi
ffff800000109fa2:	48 b8 e7 2c 10 00 00 	movabs $0xffff800000102ce7,%rax
ffff800000109fa9:	80 ff ff 
ffff800000109fac:	ff d0                	call   *%rax
  end_op();
ffff800000109fae:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109fb3:	48 ba d4 51 10 00 00 	movabs $0xffff8000001051d4,%rdx
ffff800000109fba:	80 ff ff 
ffff800000109fbd:	ff d2                	call   *%rdx
  return 0;
ffff800000109fbf:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000109fc4:	c9                   	leave
ffff800000109fc5:	c3                   	ret

ffff800000109fc6 <sys_chdir>:

int
sys_chdir(void)
{
ffff800000109fc6:	f3 0f 1e fa          	endbr64
ffff800000109fca:	55                   	push   %rbp
ffff800000109fcb:	48 89 e5             	mov    %rsp,%rbp
ffff800000109fce:	48 83 ec 10          	sub    $0x10,%rsp
  char *path;
  struct inode *ip;

  begin_op();
ffff800000109fd2:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109fd7:	48 ba e8 50 10 00 00 	movabs $0xffff8000001050e8,%rdx
ffff800000109fde:	80 ff ff 
ffff800000109fe1:	ff d2                	call   *%rdx
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
ffff800000109fe3:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff800000109fe7:	48 89 c6             	mov    %rax,%rsi
ffff800000109fea:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000109fef:	48 b8 f1 88 10 00 00 	movabs $0xffff8000001088f1,%rax
ffff800000109ff6:	80 ff ff 
ffff800000109ff9:	ff d0                	call   *%rax
ffff800000109ffb:	85 c0                	test   %eax,%eax
ffff800000109ffd:	78 1e                	js     ffff80000010a01d <sys_chdir+0x57>
ffff800000109fff:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010a003:	48 89 c7             	mov    %rax,%rdi
ffff80000010a006:	48 b8 1d 39 10 00 00 	movabs $0xffff80000010391d,%rax
ffff80000010a00d:	80 ff ff 
ffff80000010a010:	ff d0                	call   *%rax
ffff80000010a012:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010a016:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff80000010a01b:	75 1b                	jne    ffff80000010a038 <sys_chdir+0x72>
    end_op();
ffff80000010a01d:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010a022:	48 ba d4 51 10 00 00 	movabs $0xffff8000001051d4,%rdx
ffff80000010a029:	80 ff ff 
ffff80000010a02c:	ff d2                	call   *%rdx
    return -1;
ffff80000010a02e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010a033:	e9 af 00 00 00       	jmp    ffff80000010a0e7 <sys_chdir+0x121>
  }
  ilock(ip);
ffff80000010a038:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a03c:	48 89 c7             	mov    %rax,%rdi
ffff80000010a03f:	48 b8 de 29 10 00 00 	movabs $0xffff8000001029de,%rax
ffff80000010a046:	80 ff ff 
ffff80000010a049:	ff d0                	call   *%rax
  if(ip->type != T_DIR){
ffff80000010a04b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a04f:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff80000010a056:	66 83 f8 01          	cmp    $0x1,%ax
ffff80000010a05a:	74 2b                	je     ffff80000010a087 <sys_chdir+0xc1>
    iunlockput(ip);
ffff80000010a05c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a060:	48 89 c7             	mov    %rax,%rdi
ffff80000010a063:	48 b8 e7 2c 10 00 00 	movabs $0xffff800000102ce7,%rax
ffff80000010a06a:	80 ff ff 
ffff80000010a06d:	ff d0                	call   *%rax
    end_op();
ffff80000010a06f:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010a074:	48 ba d4 51 10 00 00 	movabs $0xffff8000001051d4,%rdx
ffff80000010a07b:	80 ff ff 
ffff80000010a07e:	ff d2                	call   *%rdx
    return -1;
ffff80000010a080:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010a085:	eb 60                	jmp    ffff80000010a0e7 <sys_chdir+0x121>
  }
  iunlock(ip);
ffff80000010a087:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a08b:	48 89 c7             	mov    %rax,%rdi
ffff80000010a08e:	48 b8 79 2b 10 00 00 	movabs $0xffff800000102b79,%rax
ffff80000010a095:	80 ff ff 
ffff80000010a098:	ff d0                	call   *%rax
  iput(proc->cwd);
ffff80000010a09a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010a0a1:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010a0a5:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffff80000010a0ac:	48 89 c7             	mov    %rax,%rdi
ffff80000010a0af:	48 b8 e9 2b 10 00 00 	movabs $0xffff800000102be9,%rax
ffff80000010a0b6:	80 ff ff 
ffff80000010a0b9:	ff d0                	call   *%rax
  end_op();
ffff80000010a0bb:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010a0c0:	48 ba d4 51 10 00 00 	movabs $0xffff8000001051d4,%rdx
ffff80000010a0c7:	80 ff ff 
ffff80000010a0ca:	ff d2                	call   *%rdx
  proc->cwd = ip;
ffff80000010a0cc:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010a0d3:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010a0d7:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010a0db:	48 89 90 c8 00 00 00 	mov    %rdx,0xc8(%rax)
  return 0;
ffff80000010a0e2:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010a0e7:	c9                   	leave
ffff80000010a0e8:	c3                   	ret

ffff80000010a0e9 <sys_exec>:

int
sys_exec(void)
{
ffff80000010a0e9:	f3 0f 1e fa          	endbr64
ffff80000010a0ed:	55                   	push   %rbp
ffff80000010a0ee:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a0f1:	48 81 ec 20 01 00 00 	sub    $0x120,%rsp
  char *path, *argv[MAXARG];
  int i;
  addr_t uargv, uarg;

  if(argstr(0, &path) < 0 || argaddr(1, &uargv) < 0){
ffff80000010a0f8:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff80000010a0fc:	48 89 c6             	mov    %rax,%rsi
ffff80000010a0ff:	bf 00 00 00 00       	mov    $0x0,%edi
ffff80000010a104:	48 b8 f1 88 10 00 00 	movabs $0xffff8000001088f1,%rax
ffff80000010a10b:	80 ff ff 
ffff80000010a10e:	ff d0                	call   *%rax
ffff80000010a110:	85 c0                	test   %eax,%eax
ffff80000010a112:	78 44                	js     ffff80000010a158 <sys_exec+0x6f>
ffff80000010a114:	48 8d 85 e8 fe ff ff 	lea    -0x118(%rbp),%rax
ffff80000010a11b:	48 89 c6             	mov    %rax,%rsi
ffff80000010a11e:	bf 01 00 00 00       	mov    $0x1,%edi
ffff80000010a123:	48 b8 34 88 10 00 00 	movabs $0xffff800000108834,%rax
ffff80000010a12a:	80 ff ff 
ffff80000010a12d:	ff d0                	call   *%rax
    return -1;
  }
  memset(argv, 0, sizeof(argv));
ffff80000010a12f:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
ffff80000010a136:	ba 00 01 00 00       	mov    $0x100,%edx
ffff80000010a13b:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010a140:	48 89 c7             	mov    %rax,%rdi
ffff80000010a143:	48 b8 40 82 10 00 00 	movabs $0xffff800000108240,%rax
ffff80000010a14a:	80 ff ff 
ffff80000010a14d:	ff d0                	call   *%rax
  for(i=0;; i++){
ffff80000010a14f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010a156:	eb 0a                	jmp    ffff80000010a162 <sys_exec+0x79>
    return -1;
ffff80000010a158:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010a15d:	e9 cb 00 00 00       	jmp    ffff80000010a22d <sys_exec+0x144>
    if(i >= NELEM(argv))
ffff80000010a162:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010a165:	83 f8 1f             	cmp    $0x1f,%eax
ffff80000010a168:	76 0a                	jbe    ffff80000010a174 <sys_exec+0x8b>
      return -1;
ffff80000010a16a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010a16f:	e9 b9 00 00 00       	jmp    ffff80000010a22d <sys_exec+0x144>
    if(fetchaddr(uargv+(sizeof(addr_t))*i, (addr_t*)&uarg) < 0)
ffff80000010a174:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010a177:	48 98                	cltq
ffff80000010a179:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010a180:	00 
ffff80000010a181:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
ffff80000010a188:	48 01 c2             	add    %rax,%rdx
ffff80000010a18b:	48 8d 85 e0 fe ff ff 	lea    -0x120(%rbp),%rax
ffff80000010a192:	48 89 c6             	mov    %rax,%rsi
ffff80000010a195:	48 89 d7             	mov    %rdx,%rdi
ffff80000010a198:	48 b8 2f 86 10 00 00 	movabs $0xffff80000010862f,%rax
ffff80000010a19f:	80 ff ff 
ffff80000010a1a2:	ff d0                	call   *%rax
ffff80000010a1a4:	85 c0                	test   %eax,%eax
ffff80000010a1a6:	79 07                	jns    ffff80000010a1af <sys_exec+0xc6>
      return -1;
ffff80000010a1a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010a1ad:	eb 7e                	jmp    ffff80000010a22d <sys_exec+0x144>
    if(uarg == 0){
ffff80000010a1af:	48 8b 85 e0 fe ff ff 	mov    -0x120(%rbp),%rax
ffff80000010a1b6:	48 85 c0             	test   %rax,%rax
ffff80000010a1b9:	75 31                	jne    ffff80000010a1ec <sys_exec+0x103>
      argv[i] = 0;
ffff80000010a1bb:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010a1be:	48 98                	cltq
ffff80000010a1c0:	48 c7 84 c5 f0 fe ff 	movq   $0x0,-0x110(%rbp,%rax,8)
ffff80000010a1c7:	ff 00 00 00 00 
      break;
ffff80000010a1cc:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
ffff80000010a1cd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010a1d1:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
ffff80000010a1d8:	48 89 d6             	mov    %rdx,%rsi
ffff80000010a1db:	48 89 c7             	mov    %rax,%rdi
ffff80000010a1de:	48 b8 9f 15 10 00 00 	movabs $0xffff80000010159f,%rax
ffff80000010a1e5:	80 ff ff 
ffff80000010a1e8:	ff d0                	call   *%rax
ffff80000010a1ea:	eb 41                	jmp    ffff80000010a22d <sys_exec+0x144>
    if(fetchstr(uarg, &argv[i]) < 0)
ffff80000010a1ec:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
ffff80000010a1f3:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010a1f6:	48 63 d2             	movslq %edx,%rdx
ffff80000010a1f9:	48 c1 e2 03          	shl    $0x3,%rdx
ffff80000010a1fd:	48 01 c2             	add    %rax,%rdx
ffff80000010a200:	48 8b 85 e0 fe ff ff 	mov    -0x120(%rbp),%rax
ffff80000010a207:	48 89 d6             	mov    %rdx,%rsi
ffff80000010a20a:	48 89 c7             	mov    %rax,%rdi
ffff80000010a20d:	48 b8 98 86 10 00 00 	movabs $0xffff800000108698,%rax
ffff80000010a214:	80 ff ff 
ffff80000010a217:	ff d0                	call   *%rax
ffff80000010a219:	85 c0                	test   %eax,%eax
ffff80000010a21b:	79 07                	jns    ffff80000010a224 <sys_exec+0x13b>
      return -1;
ffff80000010a21d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010a222:	eb 09                	jmp    ffff80000010a22d <sys_exec+0x144>
  for(i=0;; i++){
ffff80000010a224:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    if(i >= NELEM(argv))
ffff80000010a228:	e9 35 ff ff ff       	jmp    ffff80000010a162 <sys_exec+0x79>
}
ffff80000010a22d:	c9                   	leave
ffff80000010a22e:	c3                   	ret

ffff80000010a22f <sys_pipe>:

int
sys_pipe(void)
{
ffff80000010a22f:	f3 0f 1e fa          	endbr64
ffff80000010a233:	55                   	push   %rbp
ffff80000010a234:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a237:	48 83 ec 20          	sub    $0x20,%rsp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
ffff80000010a23b:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff80000010a23f:	ba 08 00 00 00       	mov    $0x8,%edx
ffff80000010a244:	48 89 c6             	mov    %rax,%rsi
ffff80000010a247:	bf 00 00 00 00       	mov    $0x0,%edi
ffff80000010a24c:	48 b8 66 88 10 00 00 	movabs $0xffff800000108866,%rax
ffff80000010a253:	80 ff ff 
ffff80000010a256:	ff d0                	call   *%rax
    return -1;
  if(pipealloc(&rf, &wf) < 0)
ffff80000010a258:	48 8d 55 e0          	lea    -0x20(%rbp),%rdx
ffff80000010a25c:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffff80000010a260:	48 89 d6             	mov    %rdx,%rsi
ffff80000010a263:	48 89 c7             	mov    %rax,%rdi
ffff80000010a266:	48 b8 7b 5e 10 00 00 	movabs $0xffff800000105e7b,%rax
ffff80000010a26d:	80 ff ff 
ffff80000010a270:	ff d0                	call   *%rax
ffff80000010a272:	85 c0                	test   %eax,%eax
ffff80000010a274:	79 0a                	jns    ffff80000010a280 <sys_pipe+0x51>
    return -1;
ffff80000010a276:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010a27b:	e9 ab 00 00 00       	jmp    ffff80000010a32b <sys_pipe+0xfc>
  fd0 = -1;
ffff80000010a280:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
ffff80000010a287:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a28b:	48 89 c7             	mov    %rax,%rdi
ffff80000010a28e:	48 b8 c4 8b 10 00 00 	movabs $0xffff800000108bc4,%rax
ffff80000010a295:	80 ff ff 
ffff80000010a298:	ff d0                	call   *%rax
ffff80000010a29a:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff80000010a29d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff80000010a2a1:	78 1c                	js     ffff80000010a2bf <sys_pipe+0x90>
ffff80000010a2a3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010a2a7:	48 89 c7             	mov    %rax,%rdi
ffff80000010a2aa:	48 b8 c4 8b 10 00 00 	movabs $0xffff800000108bc4,%rax
ffff80000010a2b1:	80 ff ff 
ffff80000010a2b4:	ff d0                	call   *%rax
ffff80000010a2b6:	89 45 f8             	mov    %eax,-0x8(%rbp)
ffff80000010a2b9:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
ffff80000010a2bd:	79 51                	jns    ffff80000010a310 <sys_pipe+0xe1>
    if(fd0 >= 0)
ffff80000010a2bf:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff80000010a2c3:	78 1e                	js     ffff80000010a2e3 <sys_pipe+0xb4>
      proc->ofile[fd0] = 0;
ffff80000010a2c5:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010a2cc:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010a2d0:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010a2d3:	48 63 d2             	movslq %edx,%rdx
ffff80000010a2d6:	48 83 c2 08          	add    $0x8,%rdx
ffff80000010a2da:	48 c7 44 d0 08 00 00 	movq   $0x0,0x8(%rax,%rdx,8)
ffff80000010a2e1:	00 00 
    fileclose(rf);
ffff80000010a2e3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a2e7:	48 89 c7             	mov    %rax,%rdi
ffff80000010a2ea:	48 b8 38 1d 10 00 00 	movabs $0xffff800000101d38,%rax
ffff80000010a2f1:	80 ff ff 
ffff80000010a2f4:	ff d0                	call   *%rax
    fileclose(wf);
ffff80000010a2f6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010a2fa:	48 89 c7             	mov    %rax,%rdi
ffff80000010a2fd:	48 b8 38 1d 10 00 00 	movabs $0xffff800000101d38,%rax
ffff80000010a304:	80 ff ff 
ffff80000010a307:	ff d0                	call   *%rax
    return -1;
ffff80000010a309:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010a30e:	eb 1b                	jmp    ffff80000010a32b <sys_pipe+0xfc>
  }
  fd[0] = fd0;
ffff80000010a310:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010a314:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010a317:	89 10                	mov    %edx,(%rax)
  fd[1] = fd1;
ffff80000010a319:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010a31d:	48 8d 50 04          	lea    0x4(%rax),%rdx
ffff80000010a321:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff80000010a324:	89 02                	mov    %eax,(%rdx)
  return 0;
ffff80000010a326:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010a32b:	c9                   	leave
ffff80000010a32c:	c3                   	ret

ffff80000010a32d <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
ffff80000010a32d:	f3 0f 1e fa          	endbr64
ffff80000010a331:	55                   	push   %rbp
ffff80000010a332:	48 89 e5             	mov    %rsp,%rbp
  return fork();
ffff80000010a335:	48 b8 ea 67 10 00 00 	movabs $0xffff8000001067ea,%rax
ffff80000010a33c:	80 ff ff 
ffff80000010a33f:	ff d0                	call   *%rax
}
ffff80000010a341:	5d                   	pop    %rbp
ffff80000010a342:	c3                   	ret

ffff80000010a343 <sys_exit>:

int
sys_exit(void)
{
ffff80000010a343:	f3 0f 1e fa          	endbr64
ffff80000010a347:	55                   	push   %rbp
ffff80000010a348:	48 89 e5             	mov    %rsp,%rbp
  exit();
ffff80000010a34b:	48 b8 a6 6a 10 00 00 	movabs $0xffff800000106aa6,%rax
ffff80000010a352:	80 ff ff 
ffff80000010a355:	ff d0                	call   *%rax
  return 0;  // not reached
ffff80000010a357:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010a35c:	5d                   	pop    %rbp
ffff80000010a35d:	c3                   	ret

ffff80000010a35e <sys_wait>:

int
sys_wait(void)
{
ffff80000010a35e:	f3 0f 1e fa          	endbr64
ffff80000010a362:	55                   	push   %rbp
ffff80000010a363:	48 89 e5             	mov    %rsp,%rbp
  return wait();
ffff80000010a366:	48 b8 b1 6d 10 00 00 	movabs $0xffff800000106db1,%rax
ffff80000010a36d:	80 ff ff 
ffff80000010a370:	ff d0                	call   *%rax
}
ffff80000010a372:	5d                   	pop    %rbp
ffff80000010a373:	c3                   	ret

ffff80000010a374 <sys_kill>:

int
sys_kill(void)
{
ffff80000010a374:	f3 0f 1e fa          	endbr64
ffff80000010a378:	55                   	push   %rbp
ffff80000010a379:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a37c:	48 83 ec 10          	sub    $0x10,%rsp
  int pid;

  if(argint(0, &pid) < 0)
ffff80000010a380:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
ffff80000010a384:	48 89 c6             	mov    %rax,%rsi
ffff80000010a387:	bf 00 00 00 00       	mov    $0x0,%edi
ffff80000010a38c:	48 b8 01 88 10 00 00 	movabs $0xffff800000108801,%rax
ffff80000010a393:	80 ff ff 
ffff80000010a396:	ff d0                	call   *%rax
ffff80000010a398:	85 c0                	test   %eax,%eax
ffff80000010a39a:	79 07                	jns    ffff80000010a3a3 <sys_kill+0x2f>
    return -1;
ffff80000010a39c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010a3a1:	eb 11                	jmp    ffff80000010a3b4 <sys_kill+0x40>
  return kill(pid);
ffff80000010a3a3:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010a3a6:	89 c7                	mov    %eax,%edi
ffff80000010a3a8:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
ffff80000010a3af:	80 ff ff 
ffff80000010a3b2:	ff d0                	call   *%rax
}
ffff80000010a3b4:	c9                   	leave
ffff80000010a3b5:	c3                   	ret

ffff80000010a3b6 <sys_getpid>:

int
sys_getpid(void)
{
ffff80000010a3b6:	f3 0f 1e fa          	endbr64
ffff80000010a3ba:	55                   	push   %rbp
ffff80000010a3bb:	48 89 e5             	mov    %rsp,%rbp
  return proc->pid;
ffff80000010a3be:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010a3c5:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010a3c9:	8b 40 1c             	mov    0x1c(%rax),%eax
}
ffff80000010a3cc:	5d                   	pop    %rbp
ffff80000010a3cd:	c3                   	ret

ffff80000010a3ce <sys_sbrk>:

addr_t
sys_sbrk(void)
{
ffff80000010a3ce:	f3 0f 1e fa          	endbr64
ffff80000010a3d2:	55                   	push   %rbp
ffff80000010a3d3:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a3d6:	48 83 ec 10          	sub    $0x10,%rsp
  addr_t addr;
  addr_t n;

  argaddr(0, &n);
ffff80000010a3da:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff80000010a3de:	48 89 c6             	mov    %rax,%rsi
ffff80000010a3e1:	bf 00 00 00 00       	mov    $0x0,%edi
ffff80000010a3e6:	48 b8 34 88 10 00 00 	movabs $0xffff800000108834,%rax
ffff80000010a3ed:	80 ff ff 
ffff80000010a3f0:	ff d0                	call   *%rax
  addr = proc->sz;
ffff80000010a3f2:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010a3f9:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010a3fd:	48 8b 00             	mov    (%rax),%rax
ffff80000010a400:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(growproc(n) < 0)
ffff80000010a404:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010a408:	48 89 c7             	mov    %rax,%rdi
ffff80000010a40b:	48 b8 03 67 10 00 00 	movabs $0xffff800000106703,%rax
ffff80000010a412:	80 ff ff 
ffff80000010a415:	ff d0                	call   *%rax
ffff80000010a417:	85 c0                	test   %eax,%eax
ffff80000010a419:	79 09                	jns    ffff80000010a424 <sys_sbrk+0x56>
    return -1;
ffff80000010a41b:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
ffff80000010a422:	eb 04                	jmp    ffff80000010a428 <sys_sbrk+0x5a>
  return addr;
ffff80000010a424:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff80000010a428:	c9                   	leave
ffff80000010a429:	c3                   	ret

ffff80000010a42a <sys_sleep>:

int
sys_sleep(void)
{
ffff80000010a42a:	f3 0f 1e fa          	endbr64
ffff80000010a42e:	55                   	push   %rbp
ffff80000010a42f:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a432:	48 83 ec 10          	sub    $0x10,%rsp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
ffff80000010a436:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff80000010a43a:	48 89 c6             	mov    %rax,%rsi
ffff80000010a43d:	bf 00 00 00 00       	mov    $0x0,%edi
ffff80000010a442:	48 b8 01 88 10 00 00 	movabs $0xffff800000108801,%rax
ffff80000010a449:	80 ff ff 
ffff80000010a44c:	ff d0                	call   *%rax
ffff80000010a44e:	85 c0                	test   %eax,%eax
ffff80000010a450:	79 0a                	jns    ffff80000010a45c <sys_sleep+0x32>
    return -1;
ffff80000010a452:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010a457:	e9 b6 00 00 00       	jmp    ffff80000010a512 <sys_sleep+0xe8>
  acquire(&tickslock);
ffff80000010a45c:	48 b8 00 fa 11 00 00 	movabs $0xffff80000011fa00,%rax
ffff80000010a463:	80 ff ff 
ffff80000010a466:	48 89 c7             	mov    %rax,%rdi
ffff80000010a469:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff80000010a470:	80 ff ff 
ffff80000010a473:	ff d0                	call   *%rax
  ticks0 = ticks;
ffff80000010a475:	48 b8 68 fa 11 00 00 	movabs $0xffff80000011fa68,%rax
ffff80000010a47c:	80 ff ff 
ffff80000010a47f:	8b 00                	mov    (%rax),%eax
ffff80000010a481:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while(ticks - ticks0 < n){
ffff80000010a484:	eb 58                	jmp    ffff80000010a4de <sys_sleep+0xb4>
    if(proc->killed){
ffff80000010a486:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010a48d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010a491:	8b 40 40             	mov    0x40(%rax),%eax
ffff80000010a494:	85 c0                	test   %eax,%eax
ffff80000010a496:	74 20                	je     ffff80000010a4b8 <sys_sleep+0x8e>
      release(&tickslock);
ffff80000010a498:	48 b8 00 fa 11 00 00 	movabs $0xffff80000011fa00,%rax
ffff80000010a49f:	80 ff ff 
ffff80000010a4a2:	48 89 c7             	mov    %rax,%rdi
ffff80000010a4a5:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff80000010a4ac:	80 ff ff 
ffff80000010a4af:	ff d0                	call   *%rax
      return -1;
ffff80000010a4b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010a4b6:	eb 5a                	jmp    ffff80000010a512 <sys_sleep+0xe8>
    }
    sleep(&ticks, &tickslock);
ffff80000010a4b8:	48 b8 00 fa 11 00 00 	movabs $0xffff80000011fa00,%rax
ffff80000010a4bf:	80 ff ff 
ffff80000010a4c2:	48 89 c6             	mov    %rax,%rsi
ffff80000010a4c5:	48 b8 68 fa 11 00 00 	movabs $0xffff80000011fa68,%rax
ffff80000010a4cc:	80 ff ff 
ffff80000010a4cf:	48 89 c7             	mov    %rax,%rdi
ffff80000010a4d2:	48 b8 8a 72 10 00 00 	movabs $0xffff80000010728a,%rax
ffff80000010a4d9:	80 ff ff 
ffff80000010a4dc:	ff d0                	call   *%rax
  while(ticks - ticks0 < n){
ffff80000010a4de:	48 b8 68 fa 11 00 00 	movabs $0xffff80000011fa68,%rax
ffff80000010a4e5:	80 ff ff 
ffff80000010a4e8:	8b 00                	mov    (%rax),%eax
ffff80000010a4ea:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff80000010a4ed:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffff80000010a4f0:	39 d0                	cmp    %edx,%eax
ffff80000010a4f2:	72 92                	jb     ffff80000010a486 <sys_sleep+0x5c>
  }
  release(&tickslock);
ffff80000010a4f4:	48 b8 00 fa 11 00 00 	movabs $0xffff80000011fa00,%rax
ffff80000010a4fb:	80 ff ff 
ffff80000010a4fe:	48 89 c7             	mov    %rax,%rdi
ffff80000010a501:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff80000010a508:	80 ff ff 
ffff80000010a50b:	ff d0                	call   *%rax
  return 0;
ffff80000010a50d:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010a512:	c9                   	leave
ffff80000010a513:	c3                   	ret

ffff80000010a514 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
ffff80000010a514:	f3 0f 1e fa          	endbr64
ffff80000010a518:	55                   	push   %rbp
ffff80000010a519:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a51c:	48 83 ec 10          	sub    $0x10,%rsp
  uint xticks;

  acquire(&tickslock);
ffff80000010a520:	48 b8 00 fa 11 00 00 	movabs $0xffff80000011fa00,%rax
ffff80000010a527:	80 ff ff 
ffff80000010a52a:	48 89 c7             	mov    %rax,%rdi
ffff80000010a52d:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff80000010a534:	80 ff ff 
ffff80000010a537:	ff d0                	call   *%rax
  xticks = ticks;
ffff80000010a539:	48 b8 68 fa 11 00 00 	movabs $0xffff80000011fa68,%rax
ffff80000010a540:	80 ff ff 
ffff80000010a543:	8b 00                	mov    (%rax),%eax
ffff80000010a545:	89 45 fc             	mov    %eax,-0x4(%rbp)
  release(&tickslock);
ffff80000010a548:	48 b8 00 fa 11 00 00 	movabs $0xffff80000011fa00,%rax
ffff80000010a54f:	80 ff ff 
ffff80000010a552:	48 89 c7             	mov    %rax,%rdi
ffff80000010a555:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff80000010a55c:	80 ff ff 
ffff80000010a55f:	ff d0                	call   *%rax
  return xticks;
ffff80000010a561:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff80000010a564:	c9                   	leave
ffff80000010a565:	c3                   	ret

ffff80000010a566 <sys_send>:

int
sys_send(void)
{
ffff80000010a566:	f3 0f 1e fa          	endbr64
ffff80000010a56a:	55                   	push   %rbp
ffff80000010a56b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a56e:	48 83 ec 10          	sub    $0x10,%rsp
	int pid;
	char* msg;

	if (argint(0, &pid) < 0 || argptr(1, &msg, sizeof(struct ipc_msg)) < 0) 
ffff80000010a572:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
ffff80000010a576:	48 89 c6             	mov    %rax,%rsi
ffff80000010a579:	bf 00 00 00 00       	mov    $0x0,%edi
ffff80000010a57e:	48 b8 01 88 10 00 00 	movabs $0xffff800000108801,%rax
ffff80000010a585:	80 ff ff 
ffff80000010a588:	ff d0                	call   *%rax
ffff80000010a58a:	85 c0                	test   %eax,%eax
ffff80000010a58c:	78 37                	js     ffff80000010a5c5 <sys_send+0x5f>
ffff80000010a58e:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff80000010a592:	ba e0 00 00 00       	mov    $0xe0,%edx
ffff80000010a597:	48 89 c6             	mov    %rax,%rsi
ffff80000010a59a:	bf 01 00 00 00       	mov    $0x1,%edi
ffff80000010a59f:	48 b8 66 88 10 00 00 	movabs $0xffff800000108866,%rax
ffff80000010a5a6:	80 ff ff 
ffff80000010a5a9:	ff d0                	call   *%rax
		return -1;

	return send(pid, msg);
ffff80000010a5ab:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff80000010a5af:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010a5b2:	48 89 d6             	mov    %rdx,%rsi
ffff80000010a5b5:	89 c7                	mov    %eax,%edi
ffff80000010a5b7:	48 b8 dd 79 10 00 00 	movabs $0xffff8000001079dd,%rax
ffff80000010a5be:	80 ff ff 
ffff80000010a5c1:	ff d0                	call   *%rax
ffff80000010a5c3:	eb 05                	jmp    ffff80000010a5ca <sys_send+0x64>
		return -1;
ffff80000010a5c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff80000010a5ca:	c9                   	leave
ffff80000010a5cb:	c3                   	ret

ffff80000010a5cc <sys_recv>:

int
sys_recv(void)
{
ffff80000010a5cc:	f3 0f 1e fa          	endbr64
ffff80000010a5d0:	55                   	push   %rbp
ffff80000010a5d1:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a5d4:	48 83 ec 10          	sub    $0x10,%rsp
	char *msg;
	if (argptr(0, &msg, sizeof(struct ipc_msg)) < 0) 
ffff80000010a5d8:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff80000010a5dc:	ba e0 00 00 00       	mov    $0xe0,%edx
ffff80000010a5e1:	48 89 c6             	mov    %rax,%rsi
ffff80000010a5e4:	bf 00 00 00 00       	mov    $0x0,%edi
ffff80000010a5e9:	48 b8 66 88 10 00 00 	movabs $0xffff800000108866,%rax
ffff80000010a5f0:	80 ff ff 
ffff80000010a5f3:	ff d0                	call   *%rax
		return -1;

	return recv(msg);
ffff80000010a5f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a5f9:	48 89 c7             	mov    %rax,%rdi
ffff80000010a5fc:	48 b8 df 7b 10 00 00 	movabs $0xffff800000107bdf,%rax
ffff80000010a603:	80 ff ff 
ffff80000010a606:	ff d0                	call   *%rax
}
ffff80000010a608:	c9                   	leave
ffff80000010a609:	c3                   	ret

ffff80000010a60a <sys_register_fsserver>:

int
sys_register_fsserver(void)
{
ffff80000010a60a:	f3 0f 1e fa          	endbr64
ffff80000010a60e:	55                   	push   %rbp
ffff80000010a60f:	48 89 e5             	mov    %rsp,%rbp
	return register_fsserver();
ffff80000010a612:	48 b8 f0 76 10 00 00 	movabs $0xffff8000001076f0,%rax
ffff80000010a619:	80 ff ff 
ffff80000010a61c:	ff d0                	call   *%rax
}
ffff80000010a61e:	5d                   	pop    %rbp
ffff80000010a61f:	c3                   	ret

ffff80000010a620 <alltraps>:
# vectors.S sends all traps here.
.global alltraps
alltraps:
  # Build trap frame.
  pushq   %r15
ffff80000010a620:	41 57                	push   %r15
  pushq   %r14
ffff80000010a622:	41 56                	push   %r14
  pushq   %r13
ffff80000010a624:	41 55                	push   %r13
  pushq   %r12
ffff80000010a626:	41 54                	push   %r12
  pushq   %r11
ffff80000010a628:	41 53                	push   %r11
  pushq   %r10
ffff80000010a62a:	41 52                	push   %r10
  pushq   %r9
ffff80000010a62c:	41 51                	push   %r9
  pushq   %r8
ffff80000010a62e:	41 50                	push   %r8
  pushq   %rdi
ffff80000010a630:	57                   	push   %rdi
  pushq   %rsi
ffff80000010a631:	56                   	push   %rsi
  pushq   %rbp
ffff80000010a632:	55                   	push   %rbp
  pushq   %rdx
ffff80000010a633:	52                   	push   %rdx
  pushq   %rcx
ffff80000010a634:	51                   	push   %rcx
  pushq   %rbx
ffff80000010a635:	53                   	push   %rbx
  pushq   %rax
ffff80000010a636:	50                   	push   %rax

  movq    %rsp, %rdi  # frame in arg1
ffff80000010a637:	48 89 e7             	mov    %rsp,%rdi
  callq   trap
ffff80000010a63a:	e8 8f 02 00 00       	call   ffff80000010a8ce <trap>

ffff80000010a63f <trapret>:
# Return falls through to trapret...

.global trapret
trapret:
  popq    %rax
ffff80000010a63f:	58                   	pop    %rax
  popq    %rbx
ffff80000010a640:	5b                   	pop    %rbx
  popq    %rcx
ffff80000010a641:	59                   	pop    %rcx
  popq    %rdx
ffff80000010a642:	5a                   	pop    %rdx
  popq    %rbp
ffff80000010a643:	5d                   	pop    %rbp
  popq    %rsi
ffff80000010a644:	5e                   	pop    %rsi
  popq    %rdi
ffff80000010a645:	5f                   	pop    %rdi
  popq    %r8
ffff80000010a646:	41 58                	pop    %r8
  popq    %r9
ffff80000010a648:	41 59                	pop    %r9
  popq    %r10
ffff80000010a64a:	41 5a                	pop    %r10
  popq    %r11
ffff80000010a64c:	41 5b                	pop    %r11
  popq    %r12
ffff80000010a64e:	41 5c                	pop    %r12
  popq    %r13
ffff80000010a650:	41 5d                	pop    %r13
  popq    %r14
ffff80000010a652:	41 5e                	pop    %r14
  popq    %r15
ffff80000010a654:	41 5f                	pop    %r15

  addq    $16, %rsp  # discard trapnum and errorcode
ffff80000010a656:	48 83 c4 10          	add    $0x10,%rsp
  iretq
ffff80000010a65a:	48 cf                	iretq

ffff80000010a65c <syscall_entry>:
.global syscall_entry
syscall_entry:
  # switch to kernel stack. With the syscall instruction,
  # this is a kernel resposibility
  # store %rsp on the top of proc->kstack,
  movq    %rax, %fs:(0)      # save %rax above __thread vars
ffff80000010a65c:	64 48 89 04 25 00 00 	mov    %rax,%fs:0x0
ffff80000010a663:	00 00 
  movq    %fs:(-8), %rax     # %fs:(-8) is proc (the last __thread)
ffff80000010a665:	64 48 8b 04 25 f8 ff 	mov    %fs:0xfffffffffffffff8,%rax
ffff80000010a66c:	ff ff 
  movq    0x10(%rax), %rax   # get proc->kstack (see struct proc)
ffff80000010a66e:	48 8b 40 10          	mov    0x10(%rax),%rax
  addq    $(4096-16), %rax   # %rax points to tf->rsp
ffff80000010a672:	48 05 f0 0f 00 00    	add    $0xff0,%rax
  movq    %rsp, (%rax)       # save user rsp to tf->rsp
ffff80000010a678:	48 89 20             	mov    %rsp,(%rax)
  movq    %rax, %rsp         # switch to the kstack
ffff80000010a67b:	48 89 c4             	mov    %rax,%rsp
  movq    %fs:(0), %rax      # restore %rax
ffff80000010a67e:	64 48 8b 04 25 00 00 	mov    %fs:0x0,%rax
ffff80000010a685:	00 00 

  pushq   %r11         # rflags
ffff80000010a687:	41 53                	push   %r11
  pushq   $0           # cs is ignored
ffff80000010a689:	6a 00                	push   $0x0
  pushq   %rcx         # rip (next user insn)
ffff80000010a68b:	51                   	push   %rcx

  pushq   $0           # err
ffff80000010a68c:	6a 00                	push   $0x0
  pushq   $0           # trapno ignored
ffff80000010a68e:	6a 00                	push   $0x0

  pushq   %r15
ffff80000010a690:	41 57                	push   %r15
  pushq   %r14
ffff80000010a692:	41 56                	push   %r14
  pushq   %r13
ffff80000010a694:	41 55                	push   %r13
  pushq   %r12
ffff80000010a696:	41 54                	push   %r12
  pushq   %r11
ffff80000010a698:	41 53                	push   %r11
  pushq   %r10
ffff80000010a69a:	41 52                	push   %r10
  pushq   %r9
ffff80000010a69c:	41 51                	push   %r9
  pushq   %r8
ffff80000010a69e:	41 50                	push   %r8
  pushq   %rdi
ffff80000010a6a0:	57                   	push   %rdi
  pushq   %rsi
ffff80000010a6a1:	56                   	push   %rsi
  pushq   %rbp
ffff80000010a6a2:	55                   	push   %rbp
  pushq   %rdx
ffff80000010a6a3:	52                   	push   %rdx
  pushq   %rcx
ffff80000010a6a4:	51                   	push   %rcx
  pushq   %rbx
ffff80000010a6a5:	53                   	push   %rbx
  pushq   %rax
ffff80000010a6a6:	50                   	push   %rax

  movq    %rsp, %rdi  # frame in arg1
ffff80000010a6a7:	48 89 e7             	mov    %rsp,%rdi
  callq   syscall
ffff80000010a6aa:	e8 95 e2 ff ff       	call   ffff800000108944 <syscall>

ffff80000010a6af <syscall_trapret>:
# Return falls through to syscall_trapret...
#PAGEBREAK!

.global syscall_trapret
syscall_trapret:
  popq    %rax
ffff80000010a6af:	58                   	pop    %rax
  popq    %rbx
ffff80000010a6b0:	5b                   	pop    %rbx
  popq    %rcx
ffff80000010a6b1:	59                   	pop    %rcx
  popq    %rdx
ffff80000010a6b2:	5a                   	pop    %rdx
  popq    %rbp
ffff80000010a6b3:	5d                   	pop    %rbp
  popq    %rsi
ffff80000010a6b4:	5e                   	pop    %rsi
  popq    %rdi
ffff80000010a6b5:	5f                   	pop    %rdi
  popq    %r8
ffff80000010a6b6:	41 58                	pop    %r8
  popq    %r9
ffff80000010a6b8:	41 59                	pop    %r9
  popq    %r10
ffff80000010a6ba:	41 5a                	pop    %r10
  popq    %r11
ffff80000010a6bc:	41 5b                	pop    %r11
  popq    %r12
ffff80000010a6be:	41 5c                	pop    %r12
  popq    %r13
ffff80000010a6c0:	41 5d                	pop    %r13
  popq    %r14
ffff80000010a6c2:	41 5e                	pop    %r14
  popq    %r15
ffff80000010a6c4:	41 5f                	pop    %r15

  addq    $40, %rsp  # discard trapnum, errorcode, rip, cs and rflags
ffff80000010a6c6:	48 83 c4 28          	add    $0x28,%rsp

  # to make sure we don't get any interrupts on the user stack while in
  # supervisor mode. this is actually slightly unsafe still,
  # since some interrupts are nonmaskable.
  # See https://www.felixcloutier.com/x86/sysret
  cli
ffff80000010a6ca:	fa                   	cli
  movq    (%rsp), %rsp  # restore the user stack
ffff80000010a6cb:	48 8b 24 24          	mov    (%rsp),%rsp
  sysretq
ffff80000010a6cf:	48 0f 07             	sysretq

ffff80000010a6d2 <lidt>:
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
ffff80000010a6d2:	f3 0f 1e fa          	endbr64
ffff80000010a6d6:	55                   	push   %rbp
ffff80000010a6d7:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a6da:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010a6de:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010a6e2:	89 75 d4             	mov    %esi,-0x2c(%rbp)
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d rip %p (cr2=0x%p)\n",
ffff80000010a6e5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010a6e9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
              tf->trapno, cpunum(), tf->rip, rcr2());
      if (proc)
ffff80000010a6ed:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff80000010a6f0:	83 e8 01             	sub    $0x1,%eax
ffff80000010a6f3:	66 89 45 ee          	mov    %ax,-0x12(%rbp)
        cprintf("proc id: %d\n", proc->pid);
ffff80000010a6f7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a6fb:	66 89 45 f0          	mov    %ax,-0x10(%rbp)
      panic("trap");
ffff80000010a6ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a703:	48 c1 e8 10          	shr    $0x10,%rax
ffff80000010a707:	66 89 45 f2          	mov    %ax,-0xe(%rbp)
    }
ffff80000010a70b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a70f:	48 c1 e8 20          	shr    $0x20,%rax
ffff80000010a713:	66 89 45 f4          	mov    %ax,-0xc(%rbp)
    // In user space, assume process misbehaved.
ffff80000010a717:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a71b:	48 c1 e8 30          	shr    $0x30,%rax
ffff80000010a71f:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
            "rip 0x%p addr 0x%p--kill proc\n",
ffff80000010a723:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
ffff80000010a727:	0f 01 18             	lidt   (%rax)
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->rip,
ffff80000010a72a:	90                   	nop
ffff80000010a72b:	c9                   	leave
ffff80000010a72c:	c3                   	ret

ffff80000010a72d <rcr2>:
ffff80000010a72d:	f3 0f 1e fa          	endbr64
ffff80000010a731:	55                   	push   %rbp
ffff80000010a732:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a735:	48 83 ec 10          	sub    $0x10,%rsp
ffff80000010a739:	0f 20 d0             	mov    %cr2,%rax
ffff80000010a73c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010a740:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a744:	c9                   	leave
ffff80000010a745:	c3                   	ret

ffff80000010a746 <mkgate>:
{
ffff80000010a746:	f3 0f 1e fa          	endbr64
ffff80000010a74a:	55                   	push   %rbp
ffff80000010a74b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a74e:	48 83 ec 28          	sub    $0x28,%rsp
ffff80000010a752:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010a756:	89 75 e4             	mov    %esi,-0x1c(%rbp)
ffff80000010a759:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
ffff80000010a75d:	89 4d e0             	mov    %ecx,-0x20(%rbp)
  uint64 addr = (uint64) kva;
ffff80000010a760:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010a764:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  n *= 4;
ffff80000010a768:	c1 65 e4 02          	shll   $0x2,-0x1c(%rbp)
  idt[n+0] = (addr & 0xFFFF) | (KERNEL_CS << 16);
ffff80000010a76c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a770:	0f b7 d0             	movzwl %ax,%edx
ffff80000010a773:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff80000010a776:	48 8d 0c 85 00 00 00 	lea    0x0(,%rax,4),%rcx
ffff80000010a77d:	00 
ffff80000010a77e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a782:	48 01 c8             	add    %rcx,%rax
ffff80000010a785:	81 ca 00 00 08 00    	or     $0x80000,%edx
ffff80000010a78b:	89 10                	mov    %edx,(%rax)
  idt[n+1] = (addr & 0xFFFF0000) | 0x8E00 | ((pl & 3) << 13);
ffff80000010a78d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a791:	66 b8 00 00          	mov    $0x0,%ax
ffff80000010a795:	89 c2                	mov    %eax,%edx
ffff80000010a797:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff80000010a79a:	c1 e0 0d             	shl    $0xd,%eax
ffff80000010a79d:	25 00 60 00 00       	and    $0x6000,%eax
ffff80000010a7a2:	09 c2                	or     %eax,%edx
ffff80000010a7a4:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff80000010a7a7:	83 c0 01             	add    $0x1,%eax
ffff80000010a7aa:	89 c0                	mov    %eax,%eax
ffff80000010a7ac:	48 8d 0c 85 00 00 00 	lea    0x0(,%rax,4),%rcx
ffff80000010a7b3:	00 
ffff80000010a7b4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a7b8:	48 01 c8             	add    %rcx,%rax
ffff80000010a7bb:	80 ce 8e             	or     $0x8e,%dh
ffff80000010a7be:	89 10                	mov    %edx,(%rax)
  idt[n+2] = addr >> 32;
ffff80000010a7c0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a7c4:	48 c1 e8 20          	shr    $0x20,%rax
ffff80000010a7c8:	48 89 c1             	mov    %rax,%rcx
ffff80000010a7cb:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff80000010a7ce:	83 c0 02             	add    $0x2,%eax
ffff80000010a7d1:	89 c0                	mov    %eax,%eax
ffff80000010a7d3:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff80000010a7da:	00 
ffff80000010a7db:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a7df:	48 01 d0             	add    %rdx,%rax
ffff80000010a7e2:	89 ca                	mov    %ecx,%edx
ffff80000010a7e4:	89 10                	mov    %edx,(%rax)
  idt[n+3] = 0;
ffff80000010a7e6:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff80000010a7e9:	83 c0 03             	add    $0x3,%eax
ffff80000010a7ec:	89 c0                	mov    %eax,%eax
ffff80000010a7ee:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff80000010a7f5:	00 
ffff80000010a7f6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a7fa:	48 01 d0             	add    %rdx,%rax
ffff80000010a7fd:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
}
ffff80000010a803:	90                   	nop
ffff80000010a804:	c9                   	leave
ffff80000010a805:	c3                   	ret

ffff80000010a806 <idtinit>:
{
ffff80000010a806:	f3 0f 1e fa          	endbr64
ffff80000010a80a:	55                   	push   %rbp
ffff80000010a80b:	48 89 e5             	mov    %rsp,%rbp
  lidt((void*) idt, PGSIZE);
ffff80000010a80e:	48 b8 e0 f9 11 00 00 	movabs $0xffff80000011f9e0,%rax
ffff80000010a815:	80 ff ff 
ffff80000010a818:	48 8b 00             	mov    (%rax),%rax
ffff80000010a81b:	be 00 10 00 00       	mov    $0x1000,%esi
ffff80000010a820:	48 89 c7             	mov    %rax,%rdi
ffff80000010a823:	48 b8 d2 a6 10 00 00 	movabs $0xffff80000010a6d2,%rax
ffff80000010a82a:	80 ff ff 
ffff80000010a82d:	ff d0                	call   *%rax
}
ffff80000010a82f:	90                   	nop
ffff80000010a830:	5d                   	pop    %rbp
ffff80000010a831:	c3                   	ret

ffff80000010a832 <tvinit>:
{
ffff80000010a832:	f3 0f 1e fa          	endbr64
ffff80000010a836:	55                   	push   %rbp
ffff80000010a837:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a83a:	48 83 ec 10          	sub    $0x10,%rsp
  idt = (uint*) kalloc();
ffff80000010a83e:	48 b8 78 43 10 00 00 	movabs $0xffff800000104378,%rax
ffff80000010a845:	80 ff ff 
ffff80000010a848:	ff d0                	call   *%rax
ffff80000010a84a:	48 ba e0 f9 11 00 00 	movabs $0xffff80000011f9e0,%rdx
ffff80000010a851:	80 ff ff 
ffff80000010a854:	48 89 02             	mov    %rax,(%rdx)
  memset(idt, 0, PGSIZE);
ffff80000010a857:	48 b8 e0 f9 11 00 00 	movabs $0xffff80000011f9e0,%rax
ffff80000010a85e:	80 ff ff 
ffff80000010a861:	48 8b 00             	mov    (%rax),%rax
ffff80000010a864:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010a869:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010a86e:	48 89 c7             	mov    %rax,%rdi
ffff80000010a871:	48 b8 40 82 10 00 00 	movabs $0xffff800000108240,%rax
ffff80000010a878:	80 ff ff 
ffff80000010a87b:	ff d0                	call   *%rax
  for (n = 0; n < 256; n++)
ffff80000010a87d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010a884:	eb 3b                	jmp    ffff80000010a8c1 <tvinit+0x8f>
    mkgate(idt, n, vectors[n], 0);
ffff80000010a886:	48 ba 6c e6 10 00 00 	movabs $0xffff80000010e66c,%rdx
ffff80000010a88d:	80 ff ff 
ffff80000010a890:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010a893:	48 98                	cltq
ffff80000010a895:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
ffff80000010a899:	8b 75 fc             	mov    -0x4(%rbp),%esi
ffff80000010a89c:	48 b8 e0 f9 11 00 00 	movabs $0xffff80000011f9e0,%rax
ffff80000010a8a3:	80 ff ff 
ffff80000010a8a6:	48 8b 00             	mov    (%rax),%rax
ffff80000010a8a9:	b9 00 00 00 00       	mov    $0x0,%ecx
ffff80000010a8ae:	48 89 c7             	mov    %rax,%rdi
ffff80000010a8b1:	48 b8 46 a7 10 00 00 	movabs $0xffff80000010a746,%rax
ffff80000010a8b8:	80 ff ff 
ffff80000010a8bb:	ff d0                	call   *%rax
  for (n = 0; n < 256; n++)
ffff80000010a8bd:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff80000010a8c1:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
ffff80000010a8c8:	7e bc                	jle    ffff80000010a886 <tvinit+0x54>
}
ffff80000010a8ca:	90                   	nop
ffff80000010a8cb:	90                   	nop
ffff80000010a8cc:	c9                   	leave
ffff80000010a8cd:	c3                   	ret

ffff80000010a8ce <trap>:
{
ffff80000010a8ce:	f3 0f 1e fa          	endbr64
ffff80000010a8d2:	55                   	push   %rbp
ffff80000010a8d3:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a8d6:	41 54                	push   %r12
ffff80000010a8d8:	53                   	push   %rbx
ffff80000010a8d9:	48 83 ec 10          	sub    $0x10,%rsp
ffff80000010a8dd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  switch(tf->trapno){
ffff80000010a8e1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a8e5:	48 8b 40 78          	mov    0x78(%rax),%rax
ffff80000010a8e9:	48 83 e8 20          	sub    $0x20,%rax
ffff80000010a8ed:	48 83 f8 1f          	cmp    $0x1f,%rax
ffff80000010a8f1:	0f 87 53 01 00 00    	ja     ffff80000010aa4a <trap+0x17c>
ffff80000010a8f7:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010a8fe:	00 
ffff80000010a8ff:	48 b8 20 d5 10 00 00 	movabs $0xffff80000010d520,%rax
ffff80000010a906:	80 ff ff 
ffff80000010a909:	48 01 d0             	add    %rdx,%rax
ffff80000010a90c:	48 8b 00             	mov    (%rax),%rax
ffff80000010a90f:	3e ff e0             	notrack jmp *%rax
    if(cpunum() == 0){
ffff80000010a912:	48 b8 8a 48 10 00 00 	movabs $0xffff80000010488a,%rax
ffff80000010a919:	80 ff ff 
ffff80000010a91c:	ff d0                	call   *%rax
ffff80000010a91e:	85 c0                	test   %eax,%eax
ffff80000010a920:	75 66                	jne    ffff80000010a988 <trap+0xba>
      acquire(&tickslock);
ffff80000010a922:	48 b8 00 fa 11 00 00 	movabs $0xffff80000011fa00,%rax
ffff80000010a929:	80 ff ff 
ffff80000010a92c:	48 89 c7             	mov    %rax,%rdi
ffff80000010a92f:	48 b8 88 7e 10 00 00 	movabs $0xffff800000107e88,%rax
ffff80000010a936:	80 ff ff 
ffff80000010a939:	ff d0                	call   *%rax
      ticks++;
ffff80000010a93b:	48 b8 68 fa 11 00 00 	movabs $0xffff80000011fa68,%rax
ffff80000010a942:	80 ff ff 
ffff80000010a945:	8b 00                	mov    (%rax),%eax
ffff80000010a947:	8d 50 01             	lea    0x1(%rax),%edx
ffff80000010a94a:	48 b8 68 fa 11 00 00 	movabs $0xffff80000011fa68,%rax
ffff80000010a951:	80 ff ff 
ffff80000010a954:	89 10                	mov    %edx,(%rax)
      wakeup(&ticks);
ffff80000010a956:	48 b8 68 fa 11 00 00 	movabs $0xffff80000011fa68,%rax
ffff80000010a95d:	80 ff ff 
ffff80000010a960:	48 89 c7             	mov    %rax,%rdi
ffff80000010a963:	48 b8 07 74 10 00 00 	movabs $0xffff800000107407,%rax
ffff80000010a96a:	80 ff ff 
ffff80000010a96d:	ff d0                	call   *%rax
      release(&tickslock);
ffff80000010a96f:	48 b8 00 fa 11 00 00 	movabs $0xffff80000011fa00,%rax
ffff80000010a976:	80 ff ff 
ffff80000010a979:	48 89 c7             	mov    %rax,%rdi
ffff80000010a97c:	48 b8 2b 7f 10 00 00 	movabs $0xffff800000107f2b,%rax
ffff80000010a983:	80 ff ff 
ffff80000010a986:	ff d0                	call   *%rax
    lapiceoi();
ffff80000010a988:	48 b8 93 49 10 00 00 	movabs $0xffff800000104993,%rax
ffff80000010a98f:	80 ff ff 
ffff80000010a992:	ff d0                	call   *%rax
    break;
ffff80000010a994:	e9 2b 02 00 00       	jmp    ffff80000010abc4 <trap+0x2f6>
    ideintr();
ffff80000010a999:	48 b8 35 3d 10 00 00 	movabs $0xffff800000103d35,%rax
ffff80000010a9a0:	80 ff ff 
ffff80000010a9a3:	ff d0                	call   *%rax
    lapiceoi();
ffff80000010a9a5:	48 b8 93 49 10 00 00 	movabs $0xffff800000104993,%rax
ffff80000010a9ac:	80 ff ff 
ffff80000010a9af:	ff d0                	call   *%rax
    break;
ffff80000010a9b1:	e9 0e 02 00 00       	jmp    ffff80000010abc4 <trap+0x2f6>
    kbdintr();
ffff80000010a9b6:	48 b8 30 46 10 00 00 	movabs $0xffff800000104630,%rax
ffff80000010a9bd:	80 ff ff 
ffff80000010a9c0:	ff d0                	call   *%rax
    lapiceoi();
ffff80000010a9c2:	48 b8 93 49 10 00 00 	movabs $0xffff800000104993,%rax
ffff80000010a9c9:	80 ff ff 
ffff80000010a9cc:	ff d0                	call   *%rax
    break;
ffff80000010a9ce:	e9 f1 01 00 00       	jmp    ffff80000010abc4 <trap+0x2f6>
    uartintr();
ffff80000010a9d3:	48 b8 04 af 10 00 00 	movabs $0xffff80000010af04,%rax
ffff80000010a9da:	80 ff ff 
ffff80000010a9dd:	ff d0                	call   *%rax
    lapiceoi();
ffff80000010a9df:	48 b8 93 49 10 00 00 	movabs $0xffff800000104993,%rax
ffff80000010a9e6:	80 ff ff 
ffff80000010a9e9:	ff d0                	call   *%rax
    break;
ffff80000010a9eb:	e9 d4 01 00 00       	jmp    ffff80000010abc4 <trap+0x2f6>
    cprintf("cpu%d: spurious interrupt at %p:%p\n",
ffff80000010a9f0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a9f4:	4c 8b a0 88 00 00 00 	mov    0x88(%rax),%r12
ffff80000010a9fb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a9ff:	48 8b 98 90 00 00 00 	mov    0x90(%rax),%rbx
ffff80000010aa06:	48 b8 8a 48 10 00 00 	movabs $0xffff80000010488a,%rax
ffff80000010aa0d:	80 ff ff 
ffff80000010aa10:	ff d0                	call   *%rax
ffff80000010aa12:	4c 89 e1             	mov    %r12,%rcx
ffff80000010aa15:	48 89 da             	mov    %rbx,%rdx
ffff80000010aa18:	89 c6                	mov    %eax,%esi
ffff80000010aa1a:	48 b8 68 d4 10 00 00 	movabs $0xffff80000010d468,%rax
ffff80000010aa21:	80 ff ff 
ffff80000010aa24:	48 89 c7             	mov    %rax,%rdi
ffff80000010aa27:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010aa2c:	49 b8 38 08 10 00 00 	movabs $0xffff800000100838,%r8
ffff80000010aa33:	80 ff ff 
ffff80000010aa36:	41 ff d0             	call   *%r8
    lapiceoi();
ffff80000010aa39:	48 b8 93 49 10 00 00 	movabs $0xffff800000104993,%rax
ffff80000010aa40:	80 ff ff 
ffff80000010aa43:	ff d0                	call   *%rax
    break;
ffff80000010aa45:	e9 7a 01 00 00       	jmp    ffff80000010abc4 <trap+0x2f6>
    if(proc == 0 || (tf->cs&3) == 0){
ffff80000010aa4a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010aa51:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010aa55:	48 85 c0             	test   %rax,%rax
ffff80000010aa58:	74 17                	je     ffff80000010aa71 <trap+0x1a3>
ffff80000010aa5a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010aa5e:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
ffff80000010aa65:	83 e0 03             	and    $0x3,%eax
ffff80000010aa68:	48 85 c0             	test   %rax,%rax
ffff80000010aa6b:	0f 85 af 00 00 00    	jne    ffff80000010ab20 <trap+0x252>
      cprintf("unexpected trap %d from cpu %d rip %p (cr2=0x%p)\n",
ffff80000010aa71:	48 b8 2d a7 10 00 00 	movabs $0xffff80000010a72d,%rax
ffff80000010aa78:	80 ff ff 
ffff80000010aa7b:	ff d0                	call   *%rax
ffff80000010aa7d:	49 89 c4             	mov    %rax,%r12
ffff80000010aa80:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010aa84:	48 8b 98 88 00 00 00 	mov    0x88(%rax),%rbx
ffff80000010aa8b:	48 b8 8a 48 10 00 00 	movabs $0xffff80000010488a,%rax
ffff80000010aa92:	80 ff ff 
ffff80000010aa95:	ff d0                	call   *%rax
ffff80000010aa97:	89 c2                	mov    %eax,%edx
ffff80000010aa99:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010aa9d:	48 8b 40 78          	mov    0x78(%rax),%rax
ffff80000010aaa1:	4d 89 e0             	mov    %r12,%r8
ffff80000010aaa4:	48 89 d9             	mov    %rbx,%rcx
ffff80000010aaa7:	48 89 c6             	mov    %rax,%rsi
ffff80000010aaaa:	48 b8 90 d4 10 00 00 	movabs $0xffff80000010d490,%rax
ffff80000010aab1:	80 ff ff 
ffff80000010aab4:	48 89 c7             	mov    %rax,%rdi
ffff80000010aab7:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010aabc:	49 b9 38 08 10 00 00 	movabs $0xffff800000100838,%r9
ffff80000010aac3:	80 ff ff 
ffff80000010aac6:	41 ff d1             	call   *%r9
      if (proc)
ffff80000010aac9:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010aad0:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010aad4:	48 85 c0             	test   %rax,%rax
ffff80000010aad7:	74 2e                	je     ffff80000010ab07 <trap+0x239>
        cprintf("proc id: %d\n", proc->pid);
ffff80000010aad9:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010aae0:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010aae4:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff80000010aae7:	89 c6                	mov    %eax,%esi
ffff80000010aae9:	48 b8 c2 d4 10 00 00 	movabs $0xffff80000010d4c2,%rax
ffff80000010aaf0:	80 ff ff 
ffff80000010aaf3:	48 89 c7             	mov    %rax,%rdi
ffff80000010aaf6:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010aafb:	48 ba 38 08 10 00 00 	movabs $0xffff800000100838,%rdx
ffff80000010ab02:	80 ff ff 
ffff80000010ab05:	ff d2                	call   *%rdx
      panic("trap");
ffff80000010ab07:	48 b8 cf d4 10 00 00 	movabs $0xffff80000010d4cf,%rax
ffff80000010ab0e:	80 ff ff 
ffff80000010ab11:	48 89 c7             	mov    %rax,%rdi
ffff80000010ab14:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010ab1b:	80 ff ff 
ffff80000010ab1e:	ff d0                	call   *%rax
    cprintf("pid %d %s: trap %d err %d on cpu %d "
ffff80000010ab20:	48 b8 2d a7 10 00 00 	movabs $0xffff80000010a72d,%rax
ffff80000010ab27:	80 ff ff 
ffff80000010ab2a:	ff d0                	call   *%rax
ffff80000010ab2c:	48 89 c3             	mov    %rax,%rbx
ffff80000010ab2f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010ab33:	4c 8b a0 88 00 00 00 	mov    0x88(%rax),%r12
ffff80000010ab3a:	48 b8 8a 48 10 00 00 	movabs $0xffff80000010488a,%rax
ffff80000010ab41:	80 ff ff 
ffff80000010ab44:	ff d0                	call   *%rax
ffff80000010ab46:	89 c1                	mov    %eax,%ecx
ffff80000010ab48:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010ab4c:	48 8b b8 80 00 00 00 	mov    0x80(%rax),%rdi
ffff80000010ab53:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010ab57:	48 8b 50 78          	mov    0x78(%rax),%rdx
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->rip,
ffff80000010ab5b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010ab62:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010ab66:	48 8d b0 d0 00 00 00 	lea    0xd0(%rax),%rsi
ffff80000010ab6d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010ab74:	64 48 8b 00          	mov    %fs:(%rax),%rax
    cprintf("pid %d %s: trap %d err %d on cpu %d "
ffff80000010ab78:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff80000010ab7b:	53                   	push   %rbx
ffff80000010ab7c:	41 54                	push   %r12
ffff80000010ab7e:	41 89 c9             	mov    %ecx,%r9d
ffff80000010ab81:	49 89 f8             	mov    %rdi,%r8
ffff80000010ab84:	48 89 d1             	mov    %rdx,%rcx
ffff80000010ab87:	48 89 f2             	mov    %rsi,%rdx
ffff80000010ab8a:	89 c6                	mov    %eax,%esi
ffff80000010ab8c:	48 b8 d8 d4 10 00 00 	movabs $0xffff80000010d4d8,%rax
ffff80000010ab93:	80 ff ff 
ffff80000010ab96:	48 89 c7             	mov    %rax,%rdi
ffff80000010ab99:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010ab9e:	49 ba 38 08 10 00 00 	movabs $0xffff800000100838,%r10
ffff80000010aba5:	80 ff ff 
ffff80000010aba8:	41 ff d2             	call   *%r10
ffff80000010abab:	48 83 c4 10          	add    $0x10,%rsp
    proc->killed = 1;
ffff80000010abaf:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010abb6:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010abba:	c7 40 40 01 00 00 00 	movl   $0x1,0x40(%rax)
ffff80000010abc1:	eb 01                	jmp    ffff80000010abc4 <trap+0x2f6>
    break;
ffff80000010abc3:	90                   	nop
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
ffff80000010abc4:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010abcb:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010abcf:	48 85 c0             	test   %rax,%rax
ffff80000010abd2:	74 32                	je     ffff80000010ac06 <trap+0x338>
ffff80000010abd4:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010abdb:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010abdf:	8b 40 40             	mov    0x40(%rax),%eax
ffff80000010abe2:	85 c0                	test   %eax,%eax
ffff80000010abe4:	74 20                	je     ffff80000010ac06 <trap+0x338>
ffff80000010abe6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010abea:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
ffff80000010abf1:	83 e0 03             	and    $0x3,%eax
ffff80000010abf4:	48 83 f8 03          	cmp    $0x3,%rax
ffff80000010abf8:	75 0c                	jne    ffff80000010ac06 <trap+0x338>
    exit();
ffff80000010abfa:	48 b8 a6 6a 10 00 00 	movabs $0xffff800000106aa6,%rax
ffff80000010ac01:	80 ff ff 
ffff80000010ac04:	ff d0                	call   *%rax
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
ffff80000010ac06:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010ac0d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010ac11:	48 85 c0             	test   %rax,%rax
ffff80000010ac14:	74 2d                	je     ffff80000010ac43 <trap+0x375>
ffff80000010ac16:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010ac1d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010ac21:	8b 40 18             	mov    0x18(%rax),%eax
ffff80000010ac24:	83 f8 04             	cmp    $0x4,%eax
ffff80000010ac27:	75 1a                	jne    ffff80000010ac43 <trap+0x375>
ffff80000010ac29:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010ac2d:	48 8b 40 78          	mov    0x78(%rax),%rax
ffff80000010ac31:	48 83 f8 20          	cmp    $0x20,%rax
ffff80000010ac35:	75 0c                	jne    ffff80000010ac43 <trap+0x375>
    yield();
ffff80000010ac37:	48 b8 c9 71 10 00 00 	movabs $0xffff8000001071c9,%rax
ffff80000010ac3e:	80 ff ff 
ffff80000010ac41:	ff d0                	call   *%rax
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
ffff80000010ac43:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010ac4a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010ac4e:	48 85 c0             	test   %rax,%rax
ffff80000010ac51:	74 32                	je     ffff80000010ac85 <trap+0x3b7>
ffff80000010ac53:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010ac5a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010ac5e:	8b 40 40             	mov    0x40(%rax),%eax
ffff80000010ac61:	85 c0                	test   %eax,%eax
ffff80000010ac63:	74 20                	je     ffff80000010ac85 <trap+0x3b7>
ffff80000010ac65:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010ac69:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
ffff80000010ac70:	83 e0 03             	and    $0x3,%eax
ffff80000010ac73:	48 83 f8 03          	cmp    $0x3,%rax
ffff80000010ac77:	75 0c                	jne    ffff80000010ac85 <trap+0x3b7>
    exit();
ffff80000010ac79:	48 b8 a6 6a 10 00 00 	movabs $0xffff800000106aa6,%rax
ffff80000010ac80:	80 ff ff 
ffff80000010ac83:	ff d0                	call   *%rax
}
ffff80000010ac85:	90                   	nop
ffff80000010ac86:	48 8d 65 f0          	lea    -0x10(%rbp),%rsp
ffff80000010ac8a:	5b                   	pop    %rbx
ffff80000010ac8b:	41 5c                	pop    %r12
ffff80000010ac8d:	5d                   	pop    %rbp
ffff80000010ac8e:	c3                   	ret

ffff80000010ac8f <inb>:
// Intel 8250 serial port (UART).

#include "types.h"
#include "defs.h"
#include "param.h"
ffff80000010ac8f:	f3 0f 1e fa          	endbr64
ffff80000010ac93:	55                   	push   %rbp
ffff80000010ac94:	48 89 e5             	mov    %rsp,%rbp
ffff80000010ac97:	48 83 ec 18          	sub    $0x18,%rsp
ffff80000010ac9b:	89 f8                	mov    %edi,%eax
ffff80000010ac9d:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
#include "traps.h"
#include "spinlock.h"
#include "sleeplock.h"
ffff80000010aca1:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff80000010aca5:	89 c2                	mov    %eax,%edx
ffff80000010aca7:	ec                   	in     (%dx),%al
ffff80000010aca8:	88 45 ff             	mov    %al,-0x1(%rbp)
#include "fs.h"
ffff80000010acab:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
#include "file.h"
ffff80000010acaf:	c9                   	leave
ffff80000010acb0:	c3                   	ret

ffff80000010acb1 <outb>:

void
uartearlyinit(void)
{
  char *p;

ffff80000010acb1:	f3 0f 1e fa          	endbr64
ffff80000010acb5:	55                   	push   %rbp
ffff80000010acb6:	48 89 e5             	mov    %rsp,%rbp
ffff80000010acb9:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010acbd:	89 fa                	mov    %edi,%edx
ffff80000010acbf:	89 f0                	mov    %esi,%eax
ffff80000010acc1:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffff80000010acc5:	88 45 f8             	mov    %al,-0x8(%rbp)
  // Turn off the FIFO
ffff80000010acc8:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffff80000010accc:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffff80000010acd0:	ee                   	out    %al,(%dx)
  outb(COM1+2, 0);
ffff80000010acd1:	90                   	nop
ffff80000010acd2:	c9                   	leave
ffff80000010acd3:	c3                   	ret

ffff80000010acd4 <uartearlyinit>:
{
ffff80000010acd4:	f3 0f 1e fa          	endbr64
ffff80000010acd8:	55                   	push   %rbp
ffff80000010acd9:	48 89 e5             	mov    %rsp,%rbp
ffff80000010acdc:	48 83 ec 10          	sub    $0x10,%rsp
  outb(COM1+2, 0);
ffff80000010ace0:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010ace5:	bf fa 03 00 00       	mov    $0x3fa,%edi
ffff80000010acea:	48 b8 b1 ac 10 00 00 	movabs $0xffff80000010acb1,%rax
ffff80000010acf1:	80 ff ff 
ffff80000010acf4:	ff d0                	call   *%rax

  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
ffff80000010acf6:	be 80 00 00 00       	mov    $0x80,%esi
ffff80000010acfb:	bf fb 03 00 00       	mov    $0x3fb,%edi
ffff80000010ad00:	48 b8 b1 ac 10 00 00 	movabs $0xffff80000010acb1,%rax
ffff80000010ad07:	80 ff ff 
ffff80000010ad0a:	ff d0                	call   *%rax
  outb(COM1+0, 115200/9600);
ffff80000010ad0c:	be 0c 00 00 00       	mov    $0xc,%esi
ffff80000010ad11:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffff80000010ad16:	48 b8 b1 ac 10 00 00 	movabs $0xffff80000010acb1,%rax
ffff80000010ad1d:	80 ff ff 
ffff80000010ad20:	ff d0                	call   *%rax
  outb(COM1+1, 0);
ffff80000010ad22:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010ad27:	bf f9 03 00 00       	mov    $0x3f9,%edi
ffff80000010ad2c:	48 b8 b1 ac 10 00 00 	movabs $0xffff80000010acb1,%rax
ffff80000010ad33:	80 ff ff 
ffff80000010ad36:	ff d0                	call   *%rax
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
ffff80000010ad38:	be 03 00 00 00       	mov    $0x3,%esi
ffff80000010ad3d:	bf fb 03 00 00       	mov    $0x3fb,%edi
ffff80000010ad42:	48 b8 b1 ac 10 00 00 	movabs $0xffff80000010acb1,%rax
ffff80000010ad49:	80 ff ff 
ffff80000010ad4c:	ff d0                	call   *%rax
  outb(COM1+4, 0);
ffff80000010ad4e:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010ad53:	bf fc 03 00 00       	mov    $0x3fc,%edi
ffff80000010ad58:	48 b8 b1 ac 10 00 00 	movabs $0xffff80000010acb1,%rax
ffff80000010ad5f:	80 ff ff 
ffff80000010ad62:	ff d0                	call   *%rax
  outb(COM1+1, 0x01);    // Enable receive interrupts.
ffff80000010ad64:	be 01 00 00 00       	mov    $0x1,%esi
ffff80000010ad69:	bf f9 03 00 00       	mov    $0x3f9,%edi
ffff80000010ad6e:	48 b8 b1 ac 10 00 00 	movabs $0xffff80000010acb1,%rax
ffff80000010ad75:	80 ff ff 
ffff80000010ad78:	ff d0                	call   *%rax

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
ffff80000010ad7a:	bf fd 03 00 00       	mov    $0x3fd,%edi
ffff80000010ad7f:	48 b8 8f ac 10 00 00 	movabs $0xffff80000010ac8f,%rax
ffff80000010ad86:	80 ff ff 
ffff80000010ad89:	ff d0                	call   *%rax
ffff80000010ad8b:	3c ff                	cmp    $0xff,%al
ffff80000010ad8d:	74 4a                	je     ffff80000010add9 <uartearlyinit+0x105>
    return;
  uart = 1;
ffff80000010ad8f:	48 b8 6c fa 11 00 00 	movabs $0xffff80000011fa6c,%rax
ffff80000010ad96:	80 ff ff 
ffff80000010ad99:	c7 00 01 00 00 00    	movl   $0x1,(%rax)



  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
ffff80000010ad9f:	48 b8 20 d6 10 00 00 	movabs $0xffff80000010d620,%rax
ffff80000010ada6:	80 ff ff 
ffff80000010ada9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010adad:	eb 1d                	jmp    ffff80000010adcc <uartearlyinit+0xf8>
    uartputc(*p);
ffff80000010adaf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010adb3:	0f b6 00             	movzbl (%rax),%eax
ffff80000010adb6:	0f be c0             	movsbl %al,%eax
ffff80000010adb9:	89 c7                	mov    %eax,%edi
ffff80000010adbb:	48 b8 31 ae 10 00 00 	movabs $0xffff80000010ae31,%rax
ffff80000010adc2:	80 ff ff 
ffff80000010adc5:	ff d0                	call   *%rax
  for(p="xv6...\n"; *p; p++)
ffff80000010adc7:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffff80000010adcc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010add0:	0f b6 00             	movzbl (%rax),%eax
ffff80000010add3:	84 c0                	test   %al,%al
ffff80000010add5:	75 d8                	jne    ffff80000010adaf <uartearlyinit+0xdb>
ffff80000010add7:	eb 01                	jmp    ffff80000010adda <uartearlyinit+0x106>
    return;
ffff80000010add9:	90                   	nop
}
ffff80000010adda:	c9                   	leave
ffff80000010addb:	c3                   	ret

ffff80000010addc <uartinit>:

void
uartinit(void)
{
ffff80000010addc:	f3 0f 1e fa          	endbr64
ffff80000010ade0:	55                   	push   %rbp
ffff80000010ade1:	48 89 e5             	mov    %rsp,%rbp
  if(!uart)
ffff80000010ade4:	48 b8 6c fa 11 00 00 	movabs $0xffff80000011fa6c,%rax
ffff80000010adeb:	80 ff ff 
ffff80000010adee:	8b 00                	mov    (%rax),%eax
ffff80000010adf0:	85 c0                	test   %eax,%eax
ffff80000010adf2:	74 3a                	je     ffff80000010ae2e <uartinit+0x52>
    return;

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
ffff80000010adf4:	bf fa 03 00 00       	mov    $0x3fa,%edi
ffff80000010adf9:	48 b8 8f ac 10 00 00 	movabs $0xffff80000010ac8f,%rax
ffff80000010ae00:	80 ff ff 
ffff80000010ae03:	ff d0                	call   *%rax
  inb(COM1+0);
ffff80000010ae05:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffff80000010ae0a:	48 b8 8f ac 10 00 00 	movabs $0xffff80000010ac8f,%rax
ffff80000010ae11:	80 ff ff 
ffff80000010ae14:	ff d0                	call   *%rax
  ioapicenable(IRQ_COM1, 0);
ffff80000010ae16:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010ae1b:	bf 04 00 00 00       	mov    $0x4,%edi
ffff80000010ae20:	48 b8 2e 41 10 00 00 	movabs $0xffff80000010412e,%rax
ffff80000010ae27:	80 ff ff 
ffff80000010ae2a:	ff d0                	call   *%rax
ffff80000010ae2c:	eb 01                	jmp    ffff80000010ae2f <uartinit+0x53>
    return;
ffff80000010ae2e:	90                   	nop

}
ffff80000010ae2f:	5d                   	pop    %rbp
ffff80000010ae30:	c3                   	ret

ffff80000010ae31 <uartputc>:
void
uartputc(int c)
{
ffff80000010ae31:	f3 0f 1e fa          	endbr64
ffff80000010ae35:	55                   	push   %rbp
ffff80000010ae36:	48 89 e5             	mov    %rsp,%rbp
ffff80000010ae39:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010ae3d:	89 7d ec             	mov    %edi,-0x14(%rbp)
  int i;

  if(!uart)
ffff80000010ae40:	48 b8 6c fa 11 00 00 	movabs $0xffff80000011fa6c,%rax
ffff80000010ae47:	80 ff ff 
ffff80000010ae4a:	8b 00                	mov    (%rax),%eax
ffff80000010ae4c:	85 c0                	test   %eax,%eax
ffff80000010ae4e:	74 5a                	je     ffff80000010aeaa <uartputc+0x79>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
ffff80000010ae50:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010ae57:	eb 15                	jmp    ffff80000010ae6e <uartputc+0x3d>
    microdelay(10);
ffff80000010ae59:	bf 0a 00 00 00       	mov    $0xa,%edi
ffff80000010ae5e:	48 b8 c6 49 10 00 00 	movabs $0xffff8000001049c6,%rax
ffff80000010ae65:	80 ff ff 
ffff80000010ae68:	ff d0                	call   *%rax
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
ffff80000010ae6a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff80000010ae6e:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
ffff80000010ae72:	7f 1b                	jg     ffff80000010ae8f <uartputc+0x5e>
ffff80000010ae74:	bf fd 03 00 00       	mov    $0x3fd,%edi
ffff80000010ae79:	48 b8 8f ac 10 00 00 	movabs $0xffff80000010ac8f,%rax
ffff80000010ae80:	80 ff ff 
ffff80000010ae83:	ff d0                	call   *%rax
ffff80000010ae85:	0f b6 c0             	movzbl %al,%eax
ffff80000010ae88:	83 e0 20             	and    $0x20,%eax
ffff80000010ae8b:	85 c0                	test   %eax,%eax
ffff80000010ae8d:	74 ca                	je     ffff80000010ae59 <uartputc+0x28>
  outb(COM1+0, c);
ffff80000010ae8f:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff80000010ae92:	0f b6 c0             	movzbl %al,%eax
ffff80000010ae95:	89 c6                	mov    %eax,%esi
ffff80000010ae97:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffff80000010ae9c:	48 b8 b1 ac 10 00 00 	movabs $0xffff80000010acb1,%rax
ffff80000010aea3:	80 ff ff 
ffff80000010aea6:	ff d0                	call   *%rax
ffff80000010aea8:	eb 01                	jmp    ffff80000010aeab <uartputc+0x7a>
    return;
ffff80000010aeaa:	90                   	nop
}
ffff80000010aeab:	c9                   	leave
ffff80000010aeac:	c3                   	ret

ffff80000010aead <uartgetc>:

static int
uartgetc(void)
{
ffff80000010aead:	f3 0f 1e fa          	endbr64
ffff80000010aeb1:	55                   	push   %rbp
ffff80000010aeb2:	48 89 e5             	mov    %rsp,%rbp
  if(!uart)
ffff80000010aeb5:	48 b8 6c fa 11 00 00 	movabs $0xffff80000011fa6c,%rax
ffff80000010aebc:	80 ff ff 
ffff80000010aebf:	8b 00                	mov    (%rax),%eax
ffff80000010aec1:	85 c0                	test   %eax,%eax
ffff80000010aec3:	75 07                	jne    ffff80000010aecc <uartgetc+0x1f>
    return -1;
ffff80000010aec5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010aeca:	eb 36                	jmp    ffff80000010af02 <uartgetc+0x55>
  if(!(inb(COM1+5) & 0x01))
ffff80000010aecc:	bf fd 03 00 00       	mov    $0x3fd,%edi
ffff80000010aed1:	48 b8 8f ac 10 00 00 	movabs $0xffff80000010ac8f,%rax
ffff80000010aed8:	80 ff ff 
ffff80000010aedb:	ff d0                	call   *%rax
ffff80000010aedd:	0f b6 c0             	movzbl %al,%eax
ffff80000010aee0:	83 e0 01             	and    $0x1,%eax
ffff80000010aee3:	85 c0                	test   %eax,%eax
ffff80000010aee5:	75 07                	jne    ffff80000010aeee <uartgetc+0x41>
    return -1;
ffff80000010aee7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010aeec:	eb 14                	jmp    ffff80000010af02 <uartgetc+0x55>
  return inb(COM1+0);
ffff80000010aeee:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffff80000010aef3:	48 b8 8f ac 10 00 00 	movabs $0xffff80000010ac8f,%rax
ffff80000010aefa:	80 ff ff 
ffff80000010aefd:	ff d0                	call   *%rax
ffff80000010aeff:	0f b6 c0             	movzbl %al,%eax
}
ffff80000010af02:	5d                   	pop    %rbp
ffff80000010af03:	c3                   	ret

ffff80000010af04 <uartintr>:

void
uartintr(void)
{
ffff80000010af04:	f3 0f 1e fa          	endbr64
ffff80000010af08:	55                   	push   %rbp
ffff80000010af09:	48 89 e5             	mov    %rsp,%rbp
  consoleintr(uartgetc);
ffff80000010af0c:	48 b8 ad ae 10 00 00 	movabs $0xffff80000010aead,%rax
ffff80000010af13:	80 ff ff 
ffff80000010af16:	48 89 c7             	mov    %rax,%rdi
ffff80000010af19:	48 b8 b5 0f 10 00 00 	movabs $0xffff800000100fb5,%rax
ffff80000010af20:	80 ff ff 
ffff80000010af23:	ff d0                	call   *%rax
}
ffff80000010af25:	90                   	nop
ffff80000010af26:	5d                   	pop    %rbp
ffff80000010af27:	c3                   	ret

ffff80000010af28 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.global alltraps
vector0:
  push $0
ffff80000010af28:	6a 00                	push   $0x0
  push $0
ffff80000010af2a:	6a 00                	push   $0x0
  jmp alltraps
ffff80000010af2c:	e9 ef f6 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010af31 <vector1>:
vector1:
  push $0
ffff80000010af31:	6a 00                	push   $0x0
  push $1
ffff80000010af33:	6a 01                	push   $0x1
  jmp alltraps
ffff80000010af35:	e9 e6 f6 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010af3a <vector2>:
vector2:
  push $0
ffff80000010af3a:	6a 00                	push   $0x0
  push $2
ffff80000010af3c:	6a 02                	push   $0x2
  jmp alltraps
ffff80000010af3e:	e9 dd f6 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010af43 <vector3>:
vector3:
  push $0
ffff80000010af43:	6a 00                	push   $0x0
  push $3
ffff80000010af45:	6a 03                	push   $0x3
  jmp alltraps
ffff80000010af47:	e9 d4 f6 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010af4c <vector4>:
vector4:
  push $0
ffff80000010af4c:	6a 00                	push   $0x0
  push $4
ffff80000010af4e:	6a 04                	push   $0x4
  jmp alltraps
ffff80000010af50:	e9 cb f6 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010af55 <vector5>:
vector5:
  push $0
ffff80000010af55:	6a 00                	push   $0x0
  push $5
ffff80000010af57:	6a 05                	push   $0x5
  jmp alltraps
ffff80000010af59:	e9 c2 f6 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010af5e <vector6>:
vector6:
  push $0
ffff80000010af5e:	6a 00                	push   $0x0
  push $6
ffff80000010af60:	6a 06                	push   $0x6
  jmp alltraps
ffff80000010af62:	e9 b9 f6 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010af67 <vector7>:
vector7:
  push $0
ffff80000010af67:	6a 00                	push   $0x0
  push $7
ffff80000010af69:	6a 07                	push   $0x7
  jmp alltraps
ffff80000010af6b:	e9 b0 f6 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010af70 <vector8>:
vector8:
  push $8
ffff80000010af70:	6a 08                	push   $0x8
  jmp alltraps
ffff80000010af72:	e9 a9 f6 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010af77 <vector9>:
vector9:
  push $0
ffff80000010af77:	6a 00                	push   $0x0
  push $9
ffff80000010af79:	6a 09                	push   $0x9
  jmp alltraps
ffff80000010af7b:	e9 a0 f6 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010af80 <vector10>:
vector10:
  push $10
ffff80000010af80:	6a 0a                	push   $0xa
  jmp alltraps
ffff80000010af82:	e9 99 f6 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010af87 <vector11>:
vector11:
  push $11
ffff80000010af87:	6a 0b                	push   $0xb
  jmp alltraps
ffff80000010af89:	e9 92 f6 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010af8e <vector12>:
vector12:
  push $12
ffff80000010af8e:	6a 0c                	push   $0xc
  jmp alltraps
ffff80000010af90:	e9 8b f6 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010af95 <vector13>:
vector13:
  push $13
ffff80000010af95:	6a 0d                	push   $0xd
  jmp alltraps
ffff80000010af97:	e9 84 f6 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010af9c <vector14>:
vector14:
  push $14
ffff80000010af9c:	6a 0e                	push   $0xe
  jmp alltraps
ffff80000010af9e:	e9 7d f6 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010afa3 <vector15>:
vector15:
  push $0
ffff80000010afa3:	6a 00                	push   $0x0
  push $15
ffff80000010afa5:	6a 0f                	push   $0xf
  jmp alltraps
ffff80000010afa7:	e9 74 f6 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010afac <vector16>:
vector16:
  push $0
ffff80000010afac:	6a 00                	push   $0x0
  push $16
ffff80000010afae:	6a 10                	push   $0x10
  jmp alltraps
ffff80000010afb0:	e9 6b f6 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010afb5 <vector17>:
vector17:
  push $17
ffff80000010afb5:	6a 11                	push   $0x11
  jmp alltraps
ffff80000010afb7:	e9 64 f6 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010afbc <vector18>:
vector18:
  push $0
ffff80000010afbc:	6a 00                	push   $0x0
  push $18
ffff80000010afbe:	6a 12                	push   $0x12
  jmp alltraps
ffff80000010afc0:	e9 5b f6 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010afc5 <vector19>:
vector19:
  push $0
ffff80000010afc5:	6a 00                	push   $0x0
  push $19
ffff80000010afc7:	6a 13                	push   $0x13
  jmp alltraps
ffff80000010afc9:	e9 52 f6 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010afce <vector20>:
vector20:
  push $0
ffff80000010afce:	6a 00                	push   $0x0
  push $20
ffff80000010afd0:	6a 14                	push   $0x14
  jmp alltraps
ffff80000010afd2:	e9 49 f6 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010afd7 <vector21>:
vector21:
  push $0
ffff80000010afd7:	6a 00                	push   $0x0
  push $21
ffff80000010afd9:	6a 15                	push   $0x15
  jmp alltraps
ffff80000010afdb:	e9 40 f6 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010afe0 <vector22>:
vector22:
  push $0
ffff80000010afe0:	6a 00                	push   $0x0
  push $22
ffff80000010afe2:	6a 16                	push   $0x16
  jmp alltraps
ffff80000010afe4:	e9 37 f6 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010afe9 <vector23>:
vector23:
  push $0
ffff80000010afe9:	6a 00                	push   $0x0
  push $23
ffff80000010afeb:	6a 17                	push   $0x17
  jmp alltraps
ffff80000010afed:	e9 2e f6 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010aff2 <vector24>:
vector24:
  push $0
ffff80000010aff2:	6a 00                	push   $0x0
  push $24
ffff80000010aff4:	6a 18                	push   $0x18
  jmp alltraps
ffff80000010aff6:	e9 25 f6 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010affb <vector25>:
vector25:
  push $0
ffff80000010affb:	6a 00                	push   $0x0
  push $25
ffff80000010affd:	6a 19                	push   $0x19
  jmp alltraps
ffff80000010afff:	e9 1c f6 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b004 <vector26>:
vector26:
  push $0
ffff80000010b004:	6a 00                	push   $0x0
  push $26
ffff80000010b006:	6a 1a                	push   $0x1a
  jmp alltraps
ffff80000010b008:	e9 13 f6 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b00d <vector27>:
vector27:
  push $0
ffff80000010b00d:	6a 00                	push   $0x0
  push $27
ffff80000010b00f:	6a 1b                	push   $0x1b
  jmp alltraps
ffff80000010b011:	e9 0a f6 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b016 <vector28>:
vector28:
  push $0
ffff80000010b016:	6a 00                	push   $0x0
  push $28
ffff80000010b018:	6a 1c                	push   $0x1c
  jmp alltraps
ffff80000010b01a:	e9 01 f6 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b01f <vector29>:
vector29:
  push $0
ffff80000010b01f:	6a 00                	push   $0x0
  push $29
ffff80000010b021:	6a 1d                	push   $0x1d
  jmp alltraps
ffff80000010b023:	e9 f8 f5 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b028 <vector30>:
vector30:
  push $0
ffff80000010b028:	6a 00                	push   $0x0
  push $30
ffff80000010b02a:	6a 1e                	push   $0x1e
  jmp alltraps
ffff80000010b02c:	e9 ef f5 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b031 <vector31>:
vector31:
  push $0
ffff80000010b031:	6a 00                	push   $0x0
  push $31
ffff80000010b033:	6a 1f                	push   $0x1f
  jmp alltraps
ffff80000010b035:	e9 e6 f5 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b03a <vector32>:
vector32:
  push $0
ffff80000010b03a:	6a 00                	push   $0x0
  push $32
ffff80000010b03c:	6a 20                	push   $0x20
  jmp alltraps
ffff80000010b03e:	e9 dd f5 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b043 <vector33>:
vector33:
  push $0
ffff80000010b043:	6a 00                	push   $0x0
  push $33
ffff80000010b045:	6a 21                	push   $0x21
  jmp alltraps
ffff80000010b047:	e9 d4 f5 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b04c <vector34>:
vector34:
  push $0
ffff80000010b04c:	6a 00                	push   $0x0
  push $34
ffff80000010b04e:	6a 22                	push   $0x22
  jmp alltraps
ffff80000010b050:	e9 cb f5 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b055 <vector35>:
vector35:
  push $0
ffff80000010b055:	6a 00                	push   $0x0
  push $35
ffff80000010b057:	6a 23                	push   $0x23
  jmp alltraps
ffff80000010b059:	e9 c2 f5 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b05e <vector36>:
vector36:
  push $0
ffff80000010b05e:	6a 00                	push   $0x0
  push $36
ffff80000010b060:	6a 24                	push   $0x24
  jmp alltraps
ffff80000010b062:	e9 b9 f5 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b067 <vector37>:
vector37:
  push $0
ffff80000010b067:	6a 00                	push   $0x0
  push $37
ffff80000010b069:	6a 25                	push   $0x25
  jmp alltraps
ffff80000010b06b:	e9 b0 f5 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b070 <vector38>:
vector38:
  push $0
ffff80000010b070:	6a 00                	push   $0x0
  push $38
ffff80000010b072:	6a 26                	push   $0x26
  jmp alltraps
ffff80000010b074:	e9 a7 f5 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b079 <vector39>:
vector39:
  push $0
ffff80000010b079:	6a 00                	push   $0x0
  push $39
ffff80000010b07b:	6a 27                	push   $0x27
  jmp alltraps
ffff80000010b07d:	e9 9e f5 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b082 <vector40>:
vector40:
  push $0
ffff80000010b082:	6a 00                	push   $0x0
  push $40
ffff80000010b084:	6a 28                	push   $0x28
  jmp alltraps
ffff80000010b086:	e9 95 f5 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b08b <vector41>:
vector41:
  push $0
ffff80000010b08b:	6a 00                	push   $0x0
  push $41
ffff80000010b08d:	6a 29                	push   $0x29
  jmp alltraps
ffff80000010b08f:	e9 8c f5 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b094 <vector42>:
vector42:
  push $0
ffff80000010b094:	6a 00                	push   $0x0
  push $42
ffff80000010b096:	6a 2a                	push   $0x2a
  jmp alltraps
ffff80000010b098:	e9 83 f5 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b09d <vector43>:
vector43:
  push $0
ffff80000010b09d:	6a 00                	push   $0x0
  push $43
ffff80000010b09f:	6a 2b                	push   $0x2b
  jmp alltraps
ffff80000010b0a1:	e9 7a f5 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b0a6 <vector44>:
vector44:
  push $0
ffff80000010b0a6:	6a 00                	push   $0x0
  push $44
ffff80000010b0a8:	6a 2c                	push   $0x2c
  jmp alltraps
ffff80000010b0aa:	e9 71 f5 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b0af <vector45>:
vector45:
  push $0
ffff80000010b0af:	6a 00                	push   $0x0
  push $45
ffff80000010b0b1:	6a 2d                	push   $0x2d
  jmp alltraps
ffff80000010b0b3:	e9 68 f5 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b0b8 <vector46>:
vector46:
  push $0
ffff80000010b0b8:	6a 00                	push   $0x0
  push $46
ffff80000010b0ba:	6a 2e                	push   $0x2e
  jmp alltraps
ffff80000010b0bc:	e9 5f f5 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b0c1 <vector47>:
vector47:
  push $0
ffff80000010b0c1:	6a 00                	push   $0x0
  push $47
ffff80000010b0c3:	6a 2f                	push   $0x2f
  jmp alltraps
ffff80000010b0c5:	e9 56 f5 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b0ca <vector48>:
vector48:
  push $0
ffff80000010b0ca:	6a 00                	push   $0x0
  push $48
ffff80000010b0cc:	6a 30                	push   $0x30
  jmp alltraps
ffff80000010b0ce:	e9 4d f5 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b0d3 <vector49>:
vector49:
  push $0
ffff80000010b0d3:	6a 00                	push   $0x0
  push $49
ffff80000010b0d5:	6a 31                	push   $0x31
  jmp alltraps
ffff80000010b0d7:	e9 44 f5 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b0dc <vector50>:
vector50:
  push $0
ffff80000010b0dc:	6a 00                	push   $0x0
  push $50
ffff80000010b0de:	6a 32                	push   $0x32
  jmp alltraps
ffff80000010b0e0:	e9 3b f5 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b0e5 <vector51>:
vector51:
  push $0
ffff80000010b0e5:	6a 00                	push   $0x0
  push $51
ffff80000010b0e7:	6a 33                	push   $0x33
  jmp alltraps
ffff80000010b0e9:	e9 32 f5 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b0ee <vector52>:
vector52:
  push $0
ffff80000010b0ee:	6a 00                	push   $0x0
  push $52
ffff80000010b0f0:	6a 34                	push   $0x34
  jmp alltraps
ffff80000010b0f2:	e9 29 f5 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b0f7 <vector53>:
vector53:
  push $0
ffff80000010b0f7:	6a 00                	push   $0x0
  push $53
ffff80000010b0f9:	6a 35                	push   $0x35
  jmp alltraps
ffff80000010b0fb:	e9 20 f5 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b100 <vector54>:
vector54:
  push $0
ffff80000010b100:	6a 00                	push   $0x0
  push $54
ffff80000010b102:	6a 36                	push   $0x36
  jmp alltraps
ffff80000010b104:	e9 17 f5 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b109 <vector55>:
vector55:
  push $0
ffff80000010b109:	6a 00                	push   $0x0
  push $55
ffff80000010b10b:	6a 37                	push   $0x37
  jmp alltraps
ffff80000010b10d:	e9 0e f5 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b112 <vector56>:
vector56:
  push $0
ffff80000010b112:	6a 00                	push   $0x0
  push $56
ffff80000010b114:	6a 38                	push   $0x38
  jmp alltraps
ffff80000010b116:	e9 05 f5 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b11b <vector57>:
vector57:
  push $0
ffff80000010b11b:	6a 00                	push   $0x0
  push $57
ffff80000010b11d:	6a 39                	push   $0x39
  jmp alltraps
ffff80000010b11f:	e9 fc f4 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b124 <vector58>:
vector58:
  push $0
ffff80000010b124:	6a 00                	push   $0x0
  push $58
ffff80000010b126:	6a 3a                	push   $0x3a
  jmp alltraps
ffff80000010b128:	e9 f3 f4 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b12d <vector59>:
vector59:
  push $0
ffff80000010b12d:	6a 00                	push   $0x0
  push $59
ffff80000010b12f:	6a 3b                	push   $0x3b
  jmp alltraps
ffff80000010b131:	e9 ea f4 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b136 <vector60>:
vector60:
  push $0
ffff80000010b136:	6a 00                	push   $0x0
  push $60
ffff80000010b138:	6a 3c                	push   $0x3c
  jmp alltraps
ffff80000010b13a:	e9 e1 f4 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b13f <vector61>:
vector61:
  push $0
ffff80000010b13f:	6a 00                	push   $0x0
  push $61
ffff80000010b141:	6a 3d                	push   $0x3d
  jmp alltraps
ffff80000010b143:	e9 d8 f4 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b148 <vector62>:
vector62:
  push $0
ffff80000010b148:	6a 00                	push   $0x0
  push $62
ffff80000010b14a:	6a 3e                	push   $0x3e
  jmp alltraps
ffff80000010b14c:	e9 cf f4 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b151 <vector63>:
vector63:
  push $0
ffff80000010b151:	6a 00                	push   $0x0
  push $63
ffff80000010b153:	6a 3f                	push   $0x3f
  jmp alltraps
ffff80000010b155:	e9 c6 f4 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b15a <vector64>:
vector64:
  push $0
ffff80000010b15a:	6a 00                	push   $0x0
  push $64
ffff80000010b15c:	6a 40                	push   $0x40
  jmp alltraps
ffff80000010b15e:	e9 bd f4 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b163 <vector65>:
vector65:
  push $0
ffff80000010b163:	6a 00                	push   $0x0
  push $65
ffff80000010b165:	6a 41                	push   $0x41
  jmp alltraps
ffff80000010b167:	e9 b4 f4 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b16c <vector66>:
vector66:
  push $0
ffff80000010b16c:	6a 00                	push   $0x0
  push $66
ffff80000010b16e:	6a 42                	push   $0x42
  jmp alltraps
ffff80000010b170:	e9 ab f4 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b175 <vector67>:
vector67:
  push $0
ffff80000010b175:	6a 00                	push   $0x0
  push $67
ffff80000010b177:	6a 43                	push   $0x43
  jmp alltraps
ffff80000010b179:	e9 a2 f4 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b17e <vector68>:
vector68:
  push $0
ffff80000010b17e:	6a 00                	push   $0x0
  push $68
ffff80000010b180:	6a 44                	push   $0x44
  jmp alltraps
ffff80000010b182:	e9 99 f4 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b187 <vector69>:
vector69:
  push $0
ffff80000010b187:	6a 00                	push   $0x0
  push $69
ffff80000010b189:	6a 45                	push   $0x45
  jmp alltraps
ffff80000010b18b:	e9 90 f4 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b190 <vector70>:
vector70:
  push $0
ffff80000010b190:	6a 00                	push   $0x0
  push $70
ffff80000010b192:	6a 46                	push   $0x46
  jmp alltraps
ffff80000010b194:	e9 87 f4 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b199 <vector71>:
vector71:
  push $0
ffff80000010b199:	6a 00                	push   $0x0
  push $71
ffff80000010b19b:	6a 47                	push   $0x47
  jmp alltraps
ffff80000010b19d:	e9 7e f4 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b1a2 <vector72>:
vector72:
  push $0
ffff80000010b1a2:	6a 00                	push   $0x0
  push $72
ffff80000010b1a4:	6a 48                	push   $0x48
  jmp alltraps
ffff80000010b1a6:	e9 75 f4 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b1ab <vector73>:
vector73:
  push $0
ffff80000010b1ab:	6a 00                	push   $0x0
  push $73
ffff80000010b1ad:	6a 49                	push   $0x49
  jmp alltraps
ffff80000010b1af:	e9 6c f4 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b1b4 <vector74>:
vector74:
  push $0
ffff80000010b1b4:	6a 00                	push   $0x0
  push $74
ffff80000010b1b6:	6a 4a                	push   $0x4a
  jmp alltraps
ffff80000010b1b8:	e9 63 f4 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b1bd <vector75>:
vector75:
  push $0
ffff80000010b1bd:	6a 00                	push   $0x0
  push $75
ffff80000010b1bf:	6a 4b                	push   $0x4b
  jmp alltraps
ffff80000010b1c1:	e9 5a f4 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b1c6 <vector76>:
vector76:
  push $0
ffff80000010b1c6:	6a 00                	push   $0x0
  push $76
ffff80000010b1c8:	6a 4c                	push   $0x4c
  jmp alltraps
ffff80000010b1ca:	e9 51 f4 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b1cf <vector77>:
vector77:
  push $0
ffff80000010b1cf:	6a 00                	push   $0x0
  push $77
ffff80000010b1d1:	6a 4d                	push   $0x4d
  jmp alltraps
ffff80000010b1d3:	e9 48 f4 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b1d8 <vector78>:
vector78:
  push $0
ffff80000010b1d8:	6a 00                	push   $0x0
  push $78
ffff80000010b1da:	6a 4e                	push   $0x4e
  jmp alltraps
ffff80000010b1dc:	e9 3f f4 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b1e1 <vector79>:
vector79:
  push $0
ffff80000010b1e1:	6a 00                	push   $0x0
  push $79
ffff80000010b1e3:	6a 4f                	push   $0x4f
  jmp alltraps
ffff80000010b1e5:	e9 36 f4 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b1ea <vector80>:
vector80:
  push $0
ffff80000010b1ea:	6a 00                	push   $0x0
  push $80
ffff80000010b1ec:	6a 50                	push   $0x50
  jmp alltraps
ffff80000010b1ee:	e9 2d f4 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b1f3 <vector81>:
vector81:
  push $0
ffff80000010b1f3:	6a 00                	push   $0x0
  push $81
ffff80000010b1f5:	6a 51                	push   $0x51
  jmp alltraps
ffff80000010b1f7:	e9 24 f4 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b1fc <vector82>:
vector82:
  push $0
ffff80000010b1fc:	6a 00                	push   $0x0
  push $82
ffff80000010b1fe:	6a 52                	push   $0x52
  jmp alltraps
ffff80000010b200:	e9 1b f4 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b205 <vector83>:
vector83:
  push $0
ffff80000010b205:	6a 00                	push   $0x0
  push $83
ffff80000010b207:	6a 53                	push   $0x53
  jmp alltraps
ffff80000010b209:	e9 12 f4 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b20e <vector84>:
vector84:
  push $0
ffff80000010b20e:	6a 00                	push   $0x0
  push $84
ffff80000010b210:	6a 54                	push   $0x54
  jmp alltraps
ffff80000010b212:	e9 09 f4 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b217 <vector85>:
vector85:
  push $0
ffff80000010b217:	6a 00                	push   $0x0
  push $85
ffff80000010b219:	6a 55                	push   $0x55
  jmp alltraps
ffff80000010b21b:	e9 00 f4 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b220 <vector86>:
vector86:
  push $0
ffff80000010b220:	6a 00                	push   $0x0
  push $86
ffff80000010b222:	6a 56                	push   $0x56
  jmp alltraps
ffff80000010b224:	e9 f7 f3 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b229 <vector87>:
vector87:
  push $0
ffff80000010b229:	6a 00                	push   $0x0
  push $87
ffff80000010b22b:	6a 57                	push   $0x57
  jmp alltraps
ffff80000010b22d:	e9 ee f3 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b232 <vector88>:
vector88:
  push $0
ffff80000010b232:	6a 00                	push   $0x0
  push $88
ffff80000010b234:	6a 58                	push   $0x58
  jmp alltraps
ffff80000010b236:	e9 e5 f3 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b23b <vector89>:
vector89:
  push $0
ffff80000010b23b:	6a 00                	push   $0x0
  push $89
ffff80000010b23d:	6a 59                	push   $0x59
  jmp alltraps
ffff80000010b23f:	e9 dc f3 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b244 <vector90>:
vector90:
  push $0
ffff80000010b244:	6a 00                	push   $0x0
  push $90
ffff80000010b246:	6a 5a                	push   $0x5a
  jmp alltraps
ffff80000010b248:	e9 d3 f3 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b24d <vector91>:
vector91:
  push $0
ffff80000010b24d:	6a 00                	push   $0x0
  push $91
ffff80000010b24f:	6a 5b                	push   $0x5b
  jmp alltraps
ffff80000010b251:	e9 ca f3 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b256 <vector92>:
vector92:
  push $0
ffff80000010b256:	6a 00                	push   $0x0
  push $92
ffff80000010b258:	6a 5c                	push   $0x5c
  jmp alltraps
ffff80000010b25a:	e9 c1 f3 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b25f <vector93>:
vector93:
  push $0
ffff80000010b25f:	6a 00                	push   $0x0
  push $93
ffff80000010b261:	6a 5d                	push   $0x5d
  jmp alltraps
ffff80000010b263:	e9 b8 f3 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b268 <vector94>:
vector94:
  push $0
ffff80000010b268:	6a 00                	push   $0x0
  push $94
ffff80000010b26a:	6a 5e                	push   $0x5e
  jmp alltraps
ffff80000010b26c:	e9 af f3 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b271 <vector95>:
vector95:
  push $0
ffff80000010b271:	6a 00                	push   $0x0
  push $95
ffff80000010b273:	6a 5f                	push   $0x5f
  jmp alltraps
ffff80000010b275:	e9 a6 f3 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b27a <vector96>:
vector96:
  push $0
ffff80000010b27a:	6a 00                	push   $0x0
  push $96
ffff80000010b27c:	6a 60                	push   $0x60
  jmp alltraps
ffff80000010b27e:	e9 9d f3 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b283 <vector97>:
vector97:
  push $0
ffff80000010b283:	6a 00                	push   $0x0
  push $97
ffff80000010b285:	6a 61                	push   $0x61
  jmp alltraps
ffff80000010b287:	e9 94 f3 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b28c <vector98>:
vector98:
  push $0
ffff80000010b28c:	6a 00                	push   $0x0
  push $98
ffff80000010b28e:	6a 62                	push   $0x62
  jmp alltraps
ffff80000010b290:	e9 8b f3 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b295 <vector99>:
vector99:
  push $0
ffff80000010b295:	6a 00                	push   $0x0
  push $99
ffff80000010b297:	6a 63                	push   $0x63
  jmp alltraps
ffff80000010b299:	e9 82 f3 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b29e <vector100>:
vector100:
  push $0
ffff80000010b29e:	6a 00                	push   $0x0
  push $100
ffff80000010b2a0:	6a 64                	push   $0x64
  jmp alltraps
ffff80000010b2a2:	e9 79 f3 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b2a7 <vector101>:
vector101:
  push $0
ffff80000010b2a7:	6a 00                	push   $0x0
  push $101
ffff80000010b2a9:	6a 65                	push   $0x65
  jmp alltraps
ffff80000010b2ab:	e9 70 f3 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b2b0 <vector102>:
vector102:
  push $0
ffff80000010b2b0:	6a 00                	push   $0x0
  push $102
ffff80000010b2b2:	6a 66                	push   $0x66
  jmp alltraps
ffff80000010b2b4:	e9 67 f3 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b2b9 <vector103>:
vector103:
  push $0
ffff80000010b2b9:	6a 00                	push   $0x0
  push $103
ffff80000010b2bb:	6a 67                	push   $0x67
  jmp alltraps
ffff80000010b2bd:	e9 5e f3 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b2c2 <vector104>:
vector104:
  push $0
ffff80000010b2c2:	6a 00                	push   $0x0
  push $104
ffff80000010b2c4:	6a 68                	push   $0x68
  jmp alltraps
ffff80000010b2c6:	e9 55 f3 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b2cb <vector105>:
vector105:
  push $0
ffff80000010b2cb:	6a 00                	push   $0x0
  push $105
ffff80000010b2cd:	6a 69                	push   $0x69
  jmp alltraps
ffff80000010b2cf:	e9 4c f3 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b2d4 <vector106>:
vector106:
  push $0
ffff80000010b2d4:	6a 00                	push   $0x0
  push $106
ffff80000010b2d6:	6a 6a                	push   $0x6a
  jmp alltraps
ffff80000010b2d8:	e9 43 f3 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b2dd <vector107>:
vector107:
  push $0
ffff80000010b2dd:	6a 00                	push   $0x0
  push $107
ffff80000010b2df:	6a 6b                	push   $0x6b
  jmp alltraps
ffff80000010b2e1:	e9 3a f3 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b2e6 <vector108>:
vector108:
  push $0
ffff80000010b2e6:	6a 00                	push   $0x0
  push $108
ffff80000010b2e8:	6a 6c                	push   $0x6c
  jmp alltraps
ffff80000010b2ea:	e9 31 f3 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b2ef <vector109>:
vector109:
  push $0
ffff80000010b2ef:	6a 00                	push   $0x0
  push $109
ffff80000010b2f1:	6a 6d                	push   $0x6d
  jmp alltraps
ffff80000010b2f3:	e9 28 f3 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b2f8 <vector110>:
vector110:
  push $0
ffff80000010b2f8:	6a 00                	push   $0x0
  push $110
ffff80000010b2fa:	6a 6e                	push   $0x6e
  jmp alltraps
ffff80000010b2fc:	e9 1f f3 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b301 <vector111>:
vector111:
  push $0
ffff80000010b301:	6a 00                	push   $0x0
  push $111
ffff80000010b303:	6a 6f                	push   $0x6f
  jmp alltraps
ffff80000010b305:	e9 16 f3 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b30a <vector112>:
vector112:
  push $0
ffff80000010b30a:	6a 00                	push   $0x0
  push $112
ffff80000010b30c:	6a 70                	push   $0x70
  jmp alltraps
ffff80000010b30e:	e9 0d f3 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b313 <vector113>:
vector113:
  push $0
ffff80000010b313:	6a 00                	push   $0x0
  push $113
ffff80000010b315:	6a 71                	push   $0x71
  jmp alltraps
ffff80000010b317:	e9 04 f3 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b31c <vector114>:
vector114:
  push $0
ffff80000010b31c:	6a 00                	push   $0x0
  push $114
ffff80000010b31e:	6a 72                	push   $0x72
  jmp alltraps
ffff80000010b320:	e9 fb f2 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b325 <vector115>:
vector115:
  push $0
ffff80000010b325:	6a 00                	push   $0x0
  push $115
ffff80000010b327:	6a 73                	push   $0x73
  jmp alltraps
ffff80000010b329:	e9 f2 f2 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b32e <vector116>:
vector116:
  push $0
ffff80000010b32e:	6a 00                	push   $0x0
  push $116
ffff80000010b330:	6a 74                	push   $0x74
  jmp alltraps
ffff80000010b332:	e9 e9 f2 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b337 <vector117>:
vector117:
  push $0
ffff80000010b337:	6a 00                	push   $0x0
  push $117
ffff80000010b339:	6a 75                	push   $0x75
  jmp alltraps
ffff80000010b33b:	e9 e0 f2 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b340 <vector118>:
vector118:
  push $0
ffff80000010b340:	6a 00                	push   $0x0
  push $118
ffff80000010b342:	6a 76                	push   $0x76
  jmp alltraps
ffff80000010b344:	e9 d7 f2 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b349 <vector119>:
vector119:
  push $0
ffff80000010b349:	6a 00                	push   $0x0
  push $119
ffff80000010b34b:	6a 77                	push   $0x77
  jmp alltraps
ffff80000010b34d:	e9 ce f2 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b352 <vector120>:
vector120:
  push $0
ffff80000010b352:	6a 00                	push   $0x0
  push $120
ffff80000010b354:	6a 78                	push   $0x78
  jmp alltraps
ffff80000010b356:	e9 c5 f2 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b35b <vector121>:
vector121:
  push $0
ffff80000010b35b:	6a 00                	push   $0x0
  push $121
ffff80000010b35d:	6a 79                	push   $0x79
  jmp alltraps
ffff80000010b35f:	e9 bc f2 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b364 <vector122>:
vector122:
  push $0
ffff80000010b364:	6a 00                	push   $0x0
  push $122
ffff80000010b366:	6a 7a                	push   $0x7a
  jmp alltraps
ffff80000010b368:	e9 b3 f2 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b36d <vector123>:
vector123:
  push $0
ffff80000010b36d:	6a 00                	push   $0x0
  push $123
ffff80000010b36f:	6a 7b                	push   $0x7b
  jmp alltraps
ffff80000010b371:	e9 aa f2 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b376 <vector124>:
vector124:
  push $0
ffff80000010b376:	6a 00                	push   $0x0
  push $124
ffff80000010b378:	6a 7c                	push   $0x7c
  jmp alltraps
ffff80000010b37a:	e9 a1 f2 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b37f <vector125>:
vector125:
  push $0
ffff80000010b37f:	6a 00                	push   $0x0
  push $125
ffff80000010b381:	6a 7d                	push   $0x7d
  jmp alltraps
ffff80000010b383:	e9 98 f2 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b388 <vector126>:
vector126:
  push $0
ffff80000010b388:	6a 00                	push   $0x0
  push $126
ffff80000010b38a:	6a 7e                	push   $0x7e
  jmp alltraps
ffff80000010b38c:	e9 8f f2 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b391 <vector127>:
vector127:
  push $0
ffff80000010b391:	6a 00                	push   $0x0
  push $127
ffff80000010b393:	6a 7f                	push   $0x7f
  jmp alltraps
ffff80000010b395:	e9 86 f2 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b39a <vector128>:
vector128:
  push $0
ffff80000010b39a:	6a 00                	push   $0x0
  push $128
ffff80000010b39c:	68 80 00 00 00       	push   $0x80
  jmp alltraps
ffff80000010b3a1:	e9 7a f2 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b3a6 <vector129>:
vector129:
  push $0
ffff80000010b3a6:	6a 00                	push   $0x0
  push $129
ffff80000010b3a8:	68 81 00 00 00       	push   $0x81
  jmp alltraps
ffff80000010b3ad:	e9 6e f2 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b3b2 <vector130>:
vector130:
  push $0
ffff80000010b3b2:	6a 00                	push   $0x0
  push $130
ffff80000010b3b4:	68 82 00 00 00       	push   $0x82
  jmp alltraps
ffff80000010b3b9:	e9 62 f2 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b3be <vector131>:
vector131:
  push $0
ffff80000010b3be:	6a 00                	push   $0x0
  push $131
ffff80000010b3c0:	68 83 00 00 00       	push   $0x83
  jmp alltraps
ffff80000010b3c5:	e9 56 f2 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b3ca <vector132>:
vector132:
  push $0
ffff80000010b3ca:	6a 00                	push   $0x0
  push $132
ffff80000010b3cc:	68 84 00 00 00       	push   $0x84
  jmp alltraps
ffff80000010b3d1:	e9 4a f2 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b3d6 <vector133>:
vector133:
  push $0
ffff80000010b3d6:	6a 00                	push   $0x0
  push $133
ffff80000010b3d8:	68 85 00 00 00       	push   $0x85
  jmp alltraps
ffff80000010b3dd:	e9 3e f2 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b3e2 <vector134>:
vector134:
  push $0
ffff80000010b3e2:	6a 00                	push   $0x0
  push $134
ffff80000010b3e4:	68 86 00 00 00       	push   $0x86
  jmp alltraps
ffff80000010b3e9:	e9 32 f2 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b3ee <vector135>:
vector135:
  push $0
ffff80000010b3ee:	6a 00                	push   $0x0
  push $135
ffff80000010b3f0:	68 87 00 00 00       	push   $0x87
  jmp alltraps
ffff80000010b3f5:	e9 26 f2 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b3fa <vector136>:
vector136:
  push $0
ffff80000010b3fa:	6a 00                	push   $0x0
  push $136
ffff80000010b3fc:	68 88 00 00 00       	push   $0x88
  jmp alltraps
ffff80000010b401:	e9 1a f2 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b406 <vector137>:
vector137:
  push $0
ffff80000010b406:	6a 00                	push   $0x0
  push $137
ffff80000010b408:	68 89 00 00 00       	push   $0x89
  jmp alltraps
ffff80000010b40d:	e9 0e f2 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b412 <vector138>:
vector138:
  push $0
ffff80000010b412:	6a 00                	push   $0x0
  push $138
ffff80000010b414:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
ffff80000010b419:	e9 02 f2 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b41e <vector139>:
vector139:
  push $0
ffff80000010b41e:	6a 00                	push   $0x0
  push $139
ffff80000010b420:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
ffff80000010b425:	e9 f6 f1 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b42a <vector140>:
vector140:
  push $0
ffff80000010b42a:	6a 00                	push   $0x0
  push $140
ffff80000010b42c:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
ffff80000010b431:	e9 ea f1 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b436 <vector141>:
vector141:
  push $0
ffff80000010b436:	6a 00                	push   $0x0
  push $141
ffff80000010b438:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
ffff80000010b43d:	e9 de f1 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b442 <vector142>:
vector142:
  push $0
ffff80000010b442:	6a 00                	push   $0x0
  push $142
ffff80000010b444:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
ffff80000010b449:	e9 d2 f1 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b44e <vector143>:
vector143:
  push $0
ffff80000010b44e:	6a 00                	push   $0x0
  push $143
ffff80000010b450:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
ffff80000010b455:	e9 c6 f1 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b45a <vector144>:
vector144:
  push $0
ffff80000010b45a:	6a 00                	push   $0x0
  push $144
ffff80000010b45c:	68 90 00 00 00       	push   $0x90
  jmp alltraps
ffff80000010b461:	e9 ba f1 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b466 <vector145>:
vector145:
  push $0
ffff80000010b466:	6a 00                	push   $0x0
  push $145
ffff80000010b468:	68 91 00 00 00       	push   $0x91
  jmp alltraps
ffff80000010b46d:	e9 ae f1 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b472 <vector146>:
vector146:
  push $0
ffff80000010b472:	6a 00                	push   $0x0
  push $146
ffff80000010b474:	68 92 00 00 00       	push   $0x92
  jmp alltraps
ffff80000010b479:	e9 a2 f1 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b47e <vector147>:
vector147:
  push $0
ffff80000010b47e:	6a 00                	push   $0x0
  push $147
ffff80000010b480:	68 93 00 00 00       	push   $0x93
  jmp alltraps
ffff80000010b485:	e9 96 f1 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b48a <vector148>:
vector148:
  push $0
ffff80000010b48a:	6a 00                	push   $0x0
  push $148
ffff80000010b48c:	68 94 00 00 00       	push   $0x94
  jmp alltraps
ffff80000010b491:	e9 8a f1 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b496 <vector149>:
vector149:
  push $0
ffff80000010b496:	6a 00                	push   $0x0
  push $149
ffff80000010b498:	68 95 00 00 00       	push   $0x95
  jmp alltraps
ffff80000010b49d:	e9 7e f1 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b4a2 <vector150>:
vector150:
  push $0
ffff80000010b4a2:	6a 00                	push   $0x0
  push $150
ffff80000010b4a4:	68 96 00 00 00       	push   $0x96
  jmp alltraps
ffff80000010b4a9:	e9 72 f1 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b4ae <vector151>:
vector151:
  push $0
ffff80000010b4ae:	6a 00                	push   $0x0
  push $151
ffff80000010b4b0:	68 97 00 00 00       	push   $0x97
  jmp alltraps
ffff80000010b4b5:	e9 66 f1 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b4ba <vector152>:
vector152:
  push $0
ffff80000010b4ba:	6a 00                	push   $0x0
  push $152
ffff80000010b4bc:	68 98 00 00 00       	push   $0x98
  jmp alltraps
ffff80000010b4c1:	e9 5a f1 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b4c6 <vector153>:
vector153:
  push $0
ffff80000010b4c6:	6a 00                	push   $0x0
  push $153
ffff80000010b4c8:	68 99 00 00 00       	push   $0x99
  jmp alltraps
ffff80000010b4cd:	e9 4e f1 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b4d2 <vector154>:
vector154:
  push $0
ffff80000010b4d2:	6a 00                	push   $0x0
  push $154
ffff80000010b4d4:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
ffff80000010b4d9:	e9 42 f1 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b4de <vector155>:
vector155:
  push $0
ffff80000010b4de:	6a 00                	push   $0x0
  push $155
ffff80000010b4e0:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
ffff80000010b4e5:	e9 36 f1 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b4ea <vector156>:
vector156:
  push $0
ffff80000010b4ea:	6a 00                	push   $0x0
  push $156
ffff80000010b4ec:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
ffff80000010b4f1:	e9 2a f1 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b4f6 <vector157>:
vector157:
  push $0
ffff80000010b4f6:	6a 00                	push   $0x0
  push $157
ffff80000010b4f8:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
ffff80000010b4fd:	e9 1e f1 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b502 <vector158>:
vector158:
  push $0
ffff80000010b502:	6a 00                	push   $0x0
  push $158
ffff80000010b504:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
ffff80000010b509:	e9 12 f1 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b50e <vector159>:
vector159:
  push $0
ffff80000010b50e:	6a 00                	push   $0x0
  push $159
ffff80000010b510:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
ffff80000010b515:	e9 06 f1 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b51a <vector160>:
vector160:
  push $0
ffff80000010b51a:	6a 00                	push   $0x0
  push $160
ffff80000010b51c:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
ffff80000010b521:	e9 fa f0 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b526 <vector161>:
vector161:
  push $0
ffff80000010b526:	6a 00                	push   $0x0
  push $161
ffff80000010b528:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
ffff80000010b52d:	e9 ee f0 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b532 <vector162>:
vector162:
  push $0
ffff80000010b532:	6a 00                	push   $0x0
  push $162
ffff80000010b534:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
ffff80000010b539:	e9 e2 f0 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b53e <vector163>:
vector163:
  push $0
ffff80000010b53e:	6a 00                	push   $0x0
  push $163
ffff80000010b540:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
ffff80000010b545:	e9 d6 f0 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b54a <vector164>:
vector164:
  push $0
ffff80000010b54a:	6a 00                	push   $0x0
  push $164
ffff80000010b54c:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
ffff80000010b551:	e9 ca f0 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b556 <vector165>:
vector165:
  push $0
ffff80000010b556:	6a 00                	push   $0x0
  push $165
ffff80000010b558:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
ffff80000010b55d:	e9 be f0 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b562 <vector166>:
vector166:
  push $0
ffff80000010b562:	6a 00                	push   $0x0
  push $166
ffff80000010b564:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
ffff80000010b569:	e9 b2 f0 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b56e <vector167>:
vector167:
  push $0
ffff80000010b56e:	6a 00                	push   $0x0
  push $167
ffff80000010b570:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
ffff80000010b575:	e9 a6 f0 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b57a <vector168>:
vector168:
  push $0
ffff80000010b57a:	6a 00                	push   $0x0
  push $168
ffff80000010b57c:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
ffff80000010b581:	e9 9a f0 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b586 <vector169>:
vector169:
  push $0
ffff80000010b586:	6a 00                	push   $0x0
  push $169
ffff80000010b588:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
ffff80000010b58d:	e9 8e f0 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b592 <vector170>:
vector170:
  push $0
ffff80000010b592:	6a 00                	push   $0x0
  push $170
ffff80000010b594:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
ffff80000010b599:	e9 82 f0 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b59e <vector171>:
vector171:
  push $0
ffff80000010b59e:	6a 00                	push   $0x0
  push $171
ffff80000010b5a0:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
ffff80000010b5a5:	e9 76 f0 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b5aa <vector172>:
vector172:
  push $0
ffff80000010b5aa:	6a 00                	push   $0x0
  push $172
ffff80000010b5ac:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
ffff80000010b5b1:	e9 6a f0 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b5b6 <vector173>:
vector173:
  push $0
ffff80000010b5b6:	6a 00                	push   $0x0
  push $173
ffff80000010b5b8:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
ffff80000010b5bd:	e9 5e f0 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b5c2 <vector174>:
vector174:
  push $0
ffff80000010b5c2:	6a 00                	push   $0x0
  push $174
ffff80000010b5c4:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
ffff80000010b5c9:	e9 52 f0 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b5ce <vector175>:
vector175:
  push $0
ffff80000010b5ce:	6a 00                	push   $0x0
  push $175
ffff80000010b5d0:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
ffff80000010b5d5:	e9 46 f0 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b5da <vector176>:
vector176:
  push $0
ffff80000010b5da:	6a 00                	push   $0x0
  push $176
ffff80000010b5dc:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
ffff80000010b5e1:	e9 3a f0 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b5e6 <vector177>:
vector177:
  push $0
ffff80000010b5e6:	6a 00                	push   $0x0
  push $177
ffff80000010b5e8:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
ffff80000010b5ed:	e9 2e f0 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b5f2 <vector178>:
vector178:
  push $0
ffff80000010b5f2:	6a 00                	push   $0x0
  push $178
ffff80000010b5f4:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
ffff80000010b5f9:	e9 22 f0 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b5fe <vector179>:
vector179:
  push $0
ffff80000010b5fe:	6a 00                	push   $0x0
  push $179
ffff80000010b600:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
ffff80000010b605:	e9 16 f0 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b60a <vector180>:
vector180:
  push $0
ffff80000010b60a:	6a 00                	push   $0x0
  push $180
ffff80000010b60c:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
ffff80000010b611:	e9 0a f0 ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b616 <vector181>:
vector181:
  push $0
ffff80000010b616:	6a 00                	push   $0x0
  push $181
ffff80000010b618:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
ffff80000010b61d:	e9 fe ef ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b622 <vector182>:
vector182:
  push $0
ffff80000010b622:	6a 00                	push   $0x0
  push $182
ffff80000010b624:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
ffff80000010b629:	e9 f2 ef ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b62e <vector183>:
vector183:
  push $0
ffff80000010b62e:	6a 00                	push   $0x0
  push $183
ffff80000010b630:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
ffff80000010b635:	e9 e6 ef ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b63a <vector184>:
vector184:
  push $0
ffff80000010b63a:	6a 00                	push   $0x0
  push $184
ffff80000010b63c:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
ffff80000010b641:	e9 da ef ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b646 <vector185>:
vector185:
  push $0
ffff80000010b646:	6a 00                	push   $0x0
  push $185
ffff80000010b648:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
ffff80000010b64d:	e9 ce ef ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b652 <vector186>:
vector186:
  push $0
ffff80000010b652:	6a 00                	push   $0x0
  push $186
ffff80000010b654:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
ffff80000010b659:	e9 c2 ef ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b65e <vector187>:
vector187:
  push $0
ffff80000010b65e:	6a 00                	push   $0x0
  push $187
ffff80000010b660:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
ffff80000010b665:	e9 b6 ef ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b66a <vector188>:
vector188:
  push $0
ffff80000010b66a:	6a 00                	push   $0x0
  push $188
ffff80000010b66c:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
ffff80000010b671:	e9 aa ef ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b676 <vector189>:
vector189:
  push $0
ffff80000010b676:	6a 00                	push   $0x0
  push $189
ffff80000010b678:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
ffff80000010b67d:	e9 9e ef ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b682 <vector190>:
vector190:
  push $0
ffff80000010b682:	6a 00                	push   $0x0
  push $190
ffff80000010b684:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
ffff80000010b689:	e9 92 ef ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b68e <vector191>:
vector191:
  push $0
ffff80000010b68e:	6a 00                	push   $0x0
  push $191
ffff80000010b690:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
ffff80000010b695:	e9 86 ef ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b69a <vector192>:
vector192:
  push $0
ffff80000010b69a:	6a 00                	push   $0x0
  push $192
ffff80000010b69c:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
ffff80000010b6a1:	e9 7a ef ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b6a6 <vector193>:
vector193:
  push $0
ffff80000010b6a6:	6a 00                	push   $0x0
  push $193
ffff80000010b6a8:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
ffff80000010b6ad:	e9 6e ef ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b6b2 <vector194>:
vector194:
  push $0
ffff80000010b6b2:	6a 00                	push   $0x0
  push $194
ffff80000010b6b4:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
ffff80000010b6b9:	e9 62 ef ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b6be <vector195>:
vector195:
  push $0
ffff80000010b6be:	6a 00                	push   $0x0
  push $195
ffff80000010b6c0:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
ffff80000010b6c5:	e9 56 ef ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b6ca <vector196>:
vector196:
  push $0
ffff80000010b6ca:	6a 00                	push   $0x0
  push $196
ffff80000010b6cc:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
ffff80000010b6d1:	e9 4a ef ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b6d6 <vector197>:
vector197:
  push $0
ffff80000010b6d6:	6a 00                	push   $0x0
  push $197
ffff80000010b6d8:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
ffff80000010b6dd:	e9 3e ef ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b6e2 <vector198>:
vector198:
  push $0
ffff80000010b6e2:	6a 00                	push   $0x0
  push $198
ffff80000010b6e4:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
ffff80000010b6e9:	e9 32 ef ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b6ee <vector199>:
vector199:
  push $0
ffff80000010b6ee:	6a 00                	push   $0x0
  push $199
ffff80000010b6f0:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
ffff80000010b6f5:	e9 26 ef ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b6fa <vector200>:
vector200:
  push $0
ffff80000010b6fa:	6a 00                	push   $0x0
  push $200
ffff80000010b6fc:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
ffff80000010b701:	e9 1a ef ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b706 <vector201>:
vector201:
  push $0
ffff80000010b706:	6a 00                	push   $0x0
  push $201
ffff80000010b708:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
ffff80000010b70d:	e9 0e ef ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b712 <vector202>:
vector202:
  push $0
ffff80000010b712:	6a 00                	push   $0x0
  push $202
ffff80000010b714:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
ffff80000010b719:	e9 02 ef ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b71e <vector203>:
vector203:
  push $0
ffff80000010b71e:	6a 00                	push   $0x0
  push $203
ffff80000010b720:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
ffff80000010b725:	e9 f6 ee ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b72a <vector204>:
vector204:
  push $0
ffff80000010b72a:	6a 00                	push   $0x0
  push $204
ffff80000010b72c:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
ffff80000010b731:	e9 ea ee ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b736 <vector205>:
vector205:
  push $0
ffff80000010b736:	6a 00                	push   $0x0
  push $205
ffff80000010b738:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
ffff80000010b73d:	e9 de ee ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b742 <vector206>:
vector206:
  push $0
ffff80000010b742:	6a 00                	push   $0x0
  push $206
ffff80000010b744:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
ffff80000010b749:	e9 d2 ee ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b74e <vector207>:
vector207:
  push $0
ffff80000010b74e:	6a 00                	push   $0x0
  push $207
ffff80000010b750:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
ffff80000010b755:	e9 c6 ee ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b75a <vector208>:
vector208:
  push $0
ffff80000010b75a:	6a 00                	push   $0x0
  push $208
ffff80000010b75c:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
ffff80000010b761:	e9 ba ee ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b766 <vector209>:
vector209:
  push $0
ffff80000010b766:	6a 00                	push   $0x0
  push $209
ffff80000010b768:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
ffff80000010b76d:	e9 ae ee ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b772 <vector210>:
vector210:
  push $0
ffff80000010b772:	6a 00                	push   $0x0
  push $210
ffff80000010b774:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
ffff80000010b779:	e9 a2 ee ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b77e <vector211>:
vector211:
  push $0
ffff80000010b77e:	6a 00                	push   $0x0
  push $211
ffff80000010b780:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
ffff80000010b785:	e9 96 ee ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b78a <vector212>:
vector212:
  push $0
ffff80000010b78a:	6a 00                	push   $0x0
  push $212
ffff80000010b78c:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
ffff80000010b791:	e9 8a ee ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b796 <vector213>:
vector213:
  push $0
ffff80000010b796:	6a 00                	push   $0x0
  push $213
ffff80000010b798:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
ffff80000010b79d:	e9 7e ee ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b7a2 <vector214>:
vector214:
  push $0
ffff80000010b7a2:	6a 00                	push   $0x0
  push $214
ffff80000010b7a4:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
ffff80000010b7a9:	e9 72 ee ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b7ae <vector215>:
vector215:
  push $0
ffff80000010b7ae:	6a 00                	push   $0x0
  push $215
ffff80000010b7b0:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
ffff80000010b7b5:	e9 66 ee ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b7ba <vector216>:
vector216:
  push $0
ffff80000010b7ba:	6a 00                	push   $0x0
  push $216
ffff80000010b7bc:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
ffff80000010b7c1:	e9 5a ee ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b7c6 <vector217>:
vector217:
  push $0
ffff80000010b7c6:	6a 00                	push   $0x0
  push $217
ffff80000010b7c8:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
ffff80000010b7cd:	e9 4e ee ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b7d2 <vector218>:
vector218:
  push $0
ffff80000010b7d2:	6a 00                	push   $0x0
  push $218
ffff80000010b7d4:	68 da 00 00 00       	push   $0xda
  jmp alltraps
ffff80000010b7d9:	e9 42 ee ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b7de <vector219>:
vector219:
  push $0
ffff80000010b7de:	6a 00                	push   $0x0
  push $219
ffff80000010b7e0:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
ffff80000010b7e5:	e9 36 ee ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b7ea <vector220>:
vector220:
  push $0
ffff80000010b7ea:	6a 00                	push   $0x0
  push $220
ffff80000010b7ec:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
ffff80000010b7f1:	e9 2a ee ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b7f6 <vector221>:
vector221:
  push $0
ffff80000010b7f6:	6a 00                	push   $0x0
  push $221
ffff80000010b7f8:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
ffff80000010b7fd:	e9 1e ee ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b802 <vector222>:
vector222:
  push $0
ffff80000010b802:	6a 00                	push   $0x0
  push $222
ffff80000010b804:	68 de 00 00 00       	push   $0xde
  jmp alltraps
ffff80000010b809:	e9 12 ee ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b80e <vector223>:
vector223:
  push $0
ffff80000010b80e:	6a 00                	push   $0x0
  push $223
ffff80000010b810:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
ffff80000010b815:	e9 06 ee ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b81a <vector224>:
vector224:
  push $0
ffff80000010b81a:	6a 00                	push   $0x0
  push $224
ffff80000010b81c:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
ffff80000010b821:	e9 fa ed ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b826 <vector225>:
vector225:
  push $0
ffff80000010b826:	6a 00                	push   $0x0
  push $225
ffff80000010b828:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
ffff80000010b82d:	e9 ee ed ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b832 <vector226>:
vector226:
  push $0
ffff80000010b832:	6a 00                	push   $0x0
  push $226
ffff80000010b834:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
ffff80000010b839:	e9 e2 ed ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b83e <vector227>:
vector227:
  push $0
ffff80000010b83e:	6a 00                	push   $0x0
  push $227
ffff80000010b840:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
ffff80000010b845:	e9 d6 ed ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b84a <vector228>:
vector228:
  push $0
ffff80000010b84a:	6a 00                	push   $0x0
  push $228
ffff80000010b84c:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
ffff80000010b851:	e9 ca ed ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b856 <vector229>:
vector229:
  push $0
ffff80000010b856:	6a 00                	push   $0x0
  push $229
ffff80000010b858:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
ffff80000010b85d:	e9 be ed ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b862 <vector230>:
vector230:
  push $0
ffff80000010b862:	6a 00                	push   $0x0
  push $230
ffff80000010b864:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
ffff80000010b869:	e9 b2 ed ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b86e <vector231>:
vector231:
  push $0
ffff80000010b86e:	6a 00                	push   $0x0
  push $231
ffff80000010b870:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
ffff80000010b875:	e9 a6 ed ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b87a <vector232>:
vector232:
  push $0
ffff80000010b87a:	6a 00                	push   $0x0
  push $232
ffff80000010b87c:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
ffff80000010b881:	e9 9a ed ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b886 <vector233>:
vector233:
  push $0
ffff80000010b886:	6a 00                	push   $0x0
  push $233
ffff80000010b888:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
ffff80000010b88d:	e9 8e ed ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b892 <vector234>:
vector234:
  push $0
ffff80000010b892:	6a 00                	push   $0x0
  push $234
ffff80000010b894:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
ffff80000010b899:	e9 82 ed ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b89e <vector235>:
vector235:
  push $0
ffff80000010b89e:	6a 00                	push   $0x0
  push $235
ffff80000010b8a0:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
ffff80000010b8a5:	e9 76 ed ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b8aa <vector236>:
vector236:
  push $0
ffff80000010b8aa:	6a 00                	push   $0x0
  push $236
ffff80000010b8ac:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
ffff80000010b8b1:	e9 6a ed ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b8b6 <vector237>:
vector237:
  push $0
ffff80000010b8b6:	6a 00                	push   $0x0
  push $237
ffff80000010b8b8:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
ffff80000010b8bd:	e9 5e ed ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b8c2 <vector238>:
vector238:
  push $0
ffff80000010b8c2:	6a 00                	push   $0x0
  push $238
ffff80000010b8c4:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
ffff80000010b8c9:	e9 52 ed ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b8ce <vector239>:
vector239:
  push $0
ffff80000010b8ce:	6a 00                	push   $0x0
  push $239
ffff80000010b8d0:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
ffff80000010b8d5:	e9 46 ed ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b8da <vector240>:
vector240:
  push $0
ffff80000010b8da:	6a 00                	push   $0x0
  push $240
ffff80000010b8dc:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
ffff80000010b8e1:	e9 3a ed ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b8e6 <vector241>:
vector241:
  push $0
ffff80000010b8e6:	6a 00                	push   $0x0
  push $241
ffff80000010b8e8:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
ffff80000010b8ed:	e9 2e ed ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b8f2 <vector242>:
vector242:
  push $0
ffff80000010b8f2:	6a 00                	push   $0x0
  push $242
ffff80000010b8f4:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
ffff80000010b8f9:	e9 22 ed ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b8fe <vector243>:
vector243:
  push $0
ffff80000010b8fe:	6a 00                	push   $0x0
  push $243
ffff80000010b900:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
ffff80000010b905:	e9 16 ed ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b90a <vector244>:
vector244:
  push $0
ffff80000010b90a:	6a 00                	push   $0x0
  push $244
ffff80000010b90c:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
ffff80000010b911:	e9 0a ed ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b916 <vector245>:
vector245:
  push $0
ffff80000010b916:	6a 00                	push   $0x0
  push $245
ffff80000010b918:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
ffff80000010b91d:	e9 fe ec ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b922 <vector246>:
vector246:
  push $0
ffff80000010b922:	6a 00                	push   $0x0
  push $246
ffff80000010b924:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
ffff80000010b929:	e9 f2 ec ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b92e <vector247>:
vector247:
  push $0
ffff80000010b92e:	6a 00                	push   $0x0
  push $247
ffff80000010b930:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
ffff80000010b935:	e9 e6 ec ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b93a <vector248>:
vector248:
  push $0
ffff80000010b93a:	6a 00                	push   $0x0
  push $248
ffff80000010b93c:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
ffff80000010b941:	e9 da ec ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b946 <vector249>:
vector249:
  push $0
ffff80000010b946:	6a 00                	push   $0x0
  push $249
ffff80000010b948:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
ffff80000010b94d:	e9 ce ec ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b952 <vector250>:
vector250:
  push $0
ffff80000010b952:	6a 00                	push   $0x0
  push $250
ffff80000010b954:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
ffff80000010b959:	e9 c2 ec ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b95e <vector251>:
vector251:
  push $0
ffff80000010b95e:	6a 00                	push   $0x0
  push $251
ffff80000010b960:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
ffff80000010b965:	e9 b6 ec ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b96a <vector252>:
vector252:
  push $0
ffff80000010b96a:	6a 00                	push   $0x0
  push $252
ffff80000010b96c:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
ffff80000010b971:	e9 aa ec ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b976 <vector253>:
vector253:
  push $0
ffff80000010b976:	6a 00                	push   $0x0
  push $253
ffff80000010b978:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
ffff80000010b97d:	e9 9e ec ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b982 <vector254>:
vector254:
  push $0
ffff80000010b982:	6a 00                	push   $0x0
  push $254
ffff80000010b984:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
ffff80000010b989:	e9 92 ec ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b98e <vector255>:
vector255:
  push $0
ffff80000010b98e:	6a 00                	push   $0x0
  push $255
ffff80000010b990:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
ffff80000010b995:	e9 86 ec ff ff       	jmp    ffff80000010a620 <alltraps>

ffff80000010b99a <lgdt>:

  addr = (uint64) tss;
  gdt[0] =  (struct segdesc) {};

  gdt[SEG_KCODE] = SEG((STA_X|STA_R), 0, 0, APP_SEG, !DPL_USER, 1);
  gdt[SEG_KDATA] = SEG(STA_W, 0, 0, APP_SEG, !DPL_USER, 0);
ffff80000010b99a:	f3 0f 1e fa          	endbr64
ffff80000010b99e:	55                   	push   %rbp
ffff80000010b99f:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b9a2:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010b9a6:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010b9aa:	89 75 d4             	mov    %esi,-0x2c(%rbp)
  gdt[SEG_UCODE32] = (struct segdesc) {}; // required by syscall/sysret
  gdt[SEG_UDATA] = SEG(STA_W, 0, 0, APP_SEG, DPL_USER, 0);
ffff80000010b9ad:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b9b1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  gdt[SEG_UCODE] = SEG((STA_X|STA_R), 0, 0, APP_SEG, DPL_USER, 1);
  gdt[SEG_KCPU]  = (struct segdesc) {};
ffff80000010b9b5:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff80000010b9b8:	83 e8 01             	sub    $0x1,%eax
ffff80000010b9bb:	66 89 45 ee          	mov    %ax,-0x12(%rbp)
  // TSS: See IA32 SDM Figure 7-4
ffff80000010b9bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b9c3:	66 89 45 f0          	mov    %ax,-0x10(%rbp)
  gdt[SEG_TSS]   = SEG(STS_T64A, 0xb, addr, !APP_SEG, DPL_USER, 0);
ffff80000010b9c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b9cb:	48 c1 e8 10          	shr    $0x10,%rax
ffff80000010b9cf:	66 89 45 f2          	mov    %ax,-0xe(%rbp)
  gdt[SEG_TSS+1] = SEG(0, addr >> 32, addr >> 48, 0, 0, 0);
ffff80000010b9d3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b9d7:	48 c1 e8 20          	shr    $0x20,%rax
ffff80000010b9db:	66 89 45 f4          	mov    %ax,-0xc(%rbp)

ffff80000010b9df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b9e3:	48 c1 e8 30          	shr    $0x30,%rax
ffff80000010b9e7:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
  lgdt((void*) gdt, (NSEGS+1) * sizeof(struct segdesc));

ffff80000010b9eb:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
ffff80000010b9ef:	0f 01 10             	lgdt   (%rax)
  ltr(SEG_TSS << 3);
ffff80000010b9f2:	90                   	nop
ffff80000010b9f3:	c9                   	leave
ffff80000010b9f4:	c3                   	ret

ffff80000010b9f5 <ltr>:
//   data..KERNBASE+PHYSTOP: mapped to V2P(data)..PHYSTOP,
//                                  rw data + free physical memory
//   0xfe000000..0: mapped direct (devices such as ioapic)
//
// The kernel allocates physical memory for its heap and for user memory
// between V2P(end) and the end of physical memory (PHYSTOP)
ffff80000010b9f5:	f3 0f 1e fa          	endbr64
ffff80000010b9f9:	55                   	push   %rbp
ffff80000010b9fa:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b9fd:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010ba01:	89 f8                	mov    %edi,%eax
ffff80000010ba03:	66 89 45 fc          	mov    %ax,-0x4(%rbp)
// (directly addressable from end..P2V(PHYSTOP)).
ffff80000010ba07:	0f b7 45 fc          	movzwl -0x4(%rbp),%eax
ffff80000010ba0b:	0f 00 d8             	ltr    %eax

ffff80000010ba0e:	90                   	nop
ffff80000010ba0f:	c9                   	leave
ffff80000010ba10:	c3                   	ret

ffff80000010ba11 <lcr3>:
  const addr_t stktop = (addr_t)p->kstack + KSTACKSIZE;
  tss[1] = (uint)stktop; // https://wiki.osdev.org/Task_State_Segment
  tss[2] = (uint)(stktop >> 32);
  lcr3(v2p(p->pgdir));
  popcli();
}
ffff80000010ba11:	f3 0f 1e fa          	endbr64
ffff80000010ba15:	55                   	push   %rbp
ffff80000010ba16:	48 89 e5             	mov    %rsp,%rbp
ffff80000010ba19:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010ba1d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)

ffff80000010ba21:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010ba25:	0f 22 d8             	mov    %rax,%cr3
// Return the address of the PTE in page table pgdir
ffff80000010ba28:	90                   	nop
ffff80000010ba29:	c9                   	leave
ffff80000010ba2a:	c3                   	ret

ffff80000010ba2b <v2p>:
#define KERNBASE 0xFFFF800000000000 // First kernel virtual address

#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__
static inline addr_t v2p(void *a) {
ffff80000010ba2b:	f3 0f 1e fa          	endbr64
ffff80000010ba2f:	55                   	push   %rbp
ffff80000010ba30:	48 89 e5             	mov    %rsp,%rbp
ffff80000010ba33:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010ba37:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  return ((addr_t) (a)) - ((addr_t)KERNBASE);
ffff80000010ba3b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010ba3f:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010ba46:	80 00 00 
ffff80000010ba49:	48 01 d0             	add    %rdx,%rax
}
ffff80000010ba4c:	c9                   	leave
ffff80000010ba4d:	c3                   	ret

ffff80000010ba4e <syscallinit>:
{
ffff80000010ba4e:	f3 0f 1e fa          	endbr64
ffff80000010ba52:	55                   	push   %rbp
ffff80000010ba53:	48 89 e5             	mov    %rsp,%rbp
  wrmsr(MSR_STAR,
ffff80000010ba56:	48 b8 00 00 00 00 08 	movabs $0x1b000800000000,%rax
ffff80000010ba5d:	00 1b 00 
ffff80000010ba60:	48 89 c6             	mov    %rax,%rsi
ffff80000010ba63:	bf 81 00 00 c0       	mov    $0xc0000081,%edi
ffff80000010ba68:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010ba6f:	80 ff ff 
ffff80000010ba72:	ff d0                	call   *%rax
  wrmsr(MSR_LSTAR, (addr_t)syscall_entry);
ffff80000010ba74:	48 b8 5c a6 10 00 00 	movabs $0xffff80000010a65c,%rax
ffff80000010ba7b:	80 ff ff 
ffff80000010ba7e:	48 89 c6             	mov    %rax,%rsi
ffff80000010ba81:	bf 82 00 00 c0       	mov    $0xc0000082,%edi
ffff80000010ba86:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010ba8d:	80 ff ff 
ffff80000010ba90:	ff d0                	call   *%rax
  wrmsr(MSR_CSTAR, (addr_t)ignore_sysret);
ffff80000010ba92:	48 b8 11 01 10 00 00 	movabs $0xffff800000100111,%rax
ffff80000010ba99:	80 ff ff 
ffff80000010ba9c:	48 89 c6             	mov    %rax,%rsi
ffff80000010ba9f:	bf 83 00 00 c0       	mov    $0xc0000083,%edi
ffff80000010baa4:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010baab:	80 ff ff 
ffff80000010baae:	ff d0                	call   *%rax
  wrmsr(MSR_SFMASK, FL_TF|FL_DF|FL_IF|FL_IOPL_3|FL_AC|FL_NT);
ffff80000010bab0:	be 00 77 04 00       	mov    $0x47700,%esi
ffff80000010bab5:	bf 84 00 00 c0       	mov    $0xc0000084,%edi
ffff80000010baba:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010bac1:	80 ff ff 
ffff80000010bac4:	ff d0                	call   *%rax
}
ffff80000010bac6:	90                   	nop
ffff80000010bac7:	5d                   	pop    %rbp
ffff80000010bac8:	c3                   	ret

ffff80000010bac9 <seginit>:
{
ffff80000010bac9:	f3 0f 1e fa          	endbr64
ffff80000010bacd:	55                   	push   %rbp
ffff80000010bace:	48 89 e5             	mov    %rsp,%rbp
ffff80000010bad1:	48 83 ec 30          	sub    $0x30,%rsp
  local = kalloc();
ffff80000010bad5:	48 b8 78 43 10 00 00 	movabs $0xffff800000104378,%rax
ffff80000010badc:	80 ff ff 
ffff80000010badf:	ff d0                	call   *%rax
ffff80000010bae1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(local, 0, PGSIZE);
ffff80000010bae5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010bae9:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010baee:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010baf3:	48 89 c7             	mov    %rax,%rdi
ffff80000010baf6:	48 b8 40 82 10 00 00 	movabs $0xffff800000108240,%rax
ffff80000010bafd:	80 ff ff 
ffff80000010bb00:	ff d0                	call   *%rax
  gdt = (struct segdesc*) local;
ffff80000010bb02:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010bb06:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  tss = (uint*) (((char*) local) + 1024);
ffff80000010bb0a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010bb0e:	48 05 00 04 00 00    	add    $0x400,%rax
ffff80000010bb14:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  tss[16] = 0x00680000; // IO Map Base = End of TSS
ffff80000010bb18:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bb1c:	48 83 c0 40          	add    $0x40,%rax
ffff80000010bb20:	c7 00 00 00 68 00    	movl   $0x680000,(%rax)
  wrmsr(0xC0000100, ((uint64) local) + 2048);
ffff80000010bb26:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010bb2a:	48 05 00 08 00 00    	add    $0x800,%rax
ffff80000010bb30:	48 89 c6             	mov    %rax,%rsi
ffff80000010bb33:	bf 00 01 00 c0       	mov    $0xc0000100,%edi
ffff80000010bb38:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010bb3f:	80 ff ff 
ffff80000010bb42:	ff d0                	call   *%rax
  c = &cpus[cpunum()];
ffff80000010bb44:	48 b8 8a 48 10 00 00 	movabs $0xffff80000010488a,%rax
ffff80000010bb4b:	80 ff ff 
ffff80000010bb4e:	ff d0                	call   *%rax
ffff80000010bb50:	48 63 d0             	movslq %eax,%rdx
ffff80000010bb53:	48 89 d0             	mov    %rdx,%rax
ffff80000010bb56:	48 c1 e0 02          	shl    $0x2,%rax
ffff80000010bb5a:	48 01 d0             	add    %rdx,%rax
ffff80000010bb5d:	48 c1 e0 03          	shl    $0x3,%rax
ffff80000010bb61:	48 ba 00 86 11 00 00 	movabs $0xffff800000118600,%rdx
ffff80000010bb68:	80 ff ff 
ffff80000010bb6b:	48 01 d0             	add    %rdx,%rax
ffff80000010bb6e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  c->local = local;
ffff80000010bb72:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010bb76:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010bb7a:	48 89 50 20          	mov    %rdx,0x20(%rax)
  cpu = c;
ffff80000010bb7e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010bb82:	64 48 89 04 25 f0 ff 	mov    %rax,%fs:0xfffffffffffffff0
ffff80000010bb89:	ff ff 
  proc = 0;
ffff80000010bb8b:	64 48 c7 04 25 f8 ff 	movq   $0x0,%fs:0xfffffffffffffff8
ffff80000010bb92:	ff ff 00 00 00 00 
  addr = (uint64) tss;
ffff80000010bb98:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bb9c:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  gdt[0] =  (struct segdesc) {};
ffff80000010bba0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bba4:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  gdt[SEG_KCODE] = SEG((STA_X|STA_R), 0, 0, APP_SEG, !DPL_USER, 1);
ffff80000010bbab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bbaf:	48 83 c0 08          	add    $0x8,%rax
ffff80000010bbb3:	66 c7 00 00 00       	movw   $0x0,(%rax)
ffff80000010bbb8:	66 c7 40 02 00 00    	movw   $0x0,0x2(%rax)
ffff80000010bbbe:	c6 40 04 00          	movb   $0x0,0x4(%rax)
ffff80000010bbc2:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010bbc6:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010bbc9:	83 ca 0a             	or     $0xa,%edx
ffff80000010bbcc:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010bbcf:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010bbd3:	83 ca 10             	or     $0x10,%edx
ffff80000010bbd6:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010bbd9:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010bbdd:	83 e2 9f             	and    $0xffffff9f,%edx
ffff80000010bbe0:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010bbe3:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010bbe7:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010bbea:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010bbed:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010bbf1:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010bbf4:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010bbf7:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010bbfb:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010bbfe:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010bc01:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010bc05:	83 ca 20             	or     $0x20,%edx
ffff80000010bc08:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010bc0b:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010bc0f:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010bc12:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010bc15:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010bc19:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010bc1c:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010bc1f:	c6 40 07 00          	movb   $0x0,0x7(%rax)
  gdt[SEG_KDATA] = SEG(STA_W, 0, 0, APP_SEG, !DPL_USER, 0);
ffff80000010bc23:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bc27:	48 83 c0 10          	add    $0x10,%rax
ffff80000010bc2b:	66 c7 00 00 00       	movw   $0x0,(%rax)
ffff80000010bc30:	66 c7 40 02 00 00    	movw   $0x0,0x2(%rax)
ffff80000010bc36:	c6 40 04 00          	movb   $0x0,0x4(%rax)
ffff80000010bc3a:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010bc3e:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010bc41:	83 ca 02             	or     $0x2,%edx
ffff80000010bc44:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010bc47:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010bc4b:	83 ca 10             	or     $0x10,%edx
ffff80000010bc4e:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010bc51:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010bc55:	83 e2 9f             	and    $0xffffff9f,%edx
ffff80000010bc58:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010bc5b:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010bc5f:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010bc62:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010bc65:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010bc69:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010bc6c:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010bc6f:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010bc73:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010bc76:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010bc79:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010bc7d:	83 e2 df             	and    $0xffffffdf,%edx
ffff80000010bc80:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010bc83:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010bc87:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010bc8a:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010bc8d:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010bc91:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010bc94:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010bc97:	c6 40 07 00          	movb   $0x0,0x7(%rax)
  gdt[SEG_UCODE32] = (struct segdesc) {}; // required by syscall/sysret
ffff80000010bc9b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bc9f:	48 83 c0 18          	add    $0x18,%rax
ffff80000010bca3:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  gdt[SEG_UDATA] = SEG(STA_W, 0, 0, APP_SEG, DPL_USER, 0);
ffff80000010bcaa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bcae:	48 83 c0 20          	add    $0x20,%rax
ffff80000010bcb2:	66 c7 00 00 00       	movw   $0x0,(%rax)
ffff80000010bcb7:	66 c7 40 02 00 00    	movw   $0x0,0x2(%rax)
ffff80000010bcbd:	c6 40 04 00          	movb   $0x0,0x4(%rax)
ffff80000010bcc1:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010bcc5:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010bcc8:	83 ca 02             	or     $0x2,%edx
ffff80000010bccb:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010bcce:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010bcd2:	83 ca 10             	or     $0x10,%edx
ffff80000010bcd5:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010bcd8:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010bcdc:	83 ca 60             	or     $0x60,%edx
ffff80000010bcdf:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010bce2:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010bce6:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010bce9:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010bcec:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010bcf0:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010bcf3:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010bcf6:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010bcfa:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010bcfd:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010bd00:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010bd04:	83 e2 df             	and    $0xffffffdf,%edx
ffff80000010bd07:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010bd0a:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010bd0e:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010bd11:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010bd14:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010bd18:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010bd1b:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010bd1e:	c6 40 07 00          	movb   $0x0,0x7(%rax)
  gdt[SEG_UCODE] = SEG((STA_X|STA_R), 0, 0, APP_SEG, DPL_USER, 1);
ffff80000010bd22:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bd26:	48 83 c0 28          	add    $0x28,%rax
ffff80000010bd2a:	66 c7 00 00 00       	movw   $0x0,(%rax)
ffff80000010bd2f:	66 c7 40 02 00 00    	movw   $0x0,0x2(%rax)
ffff80000010bd35:	c6 40 04 00          	movb   $0x0,0x4(%rax)
ffff80000010bd39:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010bd3d:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010bd40:	83 ca 0a             	or     $0xa,%edx
ffff80000010bd43:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010bd46:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010bd4a:	83 ca 10             	or     $0x10,%edx
ffff80000010bd4d:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010bd50:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010bd54:	83 ca 60             	or     $0x60,%edx
ffff80000010bd57:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010bd5a:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010bd5e:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010bd61:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010bd64:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010bd68:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010bd6b:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010bd6e:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010bd72:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010bd75:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010bd78:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010bd7c:	83 ca 20             	or     $0x20,%edx
ffff80000010bd7f:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010bd82:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010bd86:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010bd89:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010bd8c:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010bd90:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010bd93:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010bd96:	c6 40 07 00          	movb   $0x0,0x7(%rax)
  gdt[SEG_KCPU]  = (struct segdesc) {};
ffff80000010bd9a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bd9e:	48 83 c0 30          	add    $0x30,%rax
ffff80000010bda2:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  gdt[SEG_TSS]   = SEG(STS_T64A, 0xb, addr, !APP_SEG, DPL_USER, 0);
ffff80000010bda9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bdad:	48 83 c0 38          	add    $0x38,%rax
ffff80000010bdb1:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010bdb5:	89 d7                	mov    %edx,%edi
ffff80000010bdb7:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010bdbb:	48 c1 ea 10          	shr    $0x10,%rdx
ffff80000010bdbf:	89 d6                	mov    %edx,%esi
ffff80000010bdc1:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010bdc5:	48 c1 ea 18          	shr    $0x18,%rdx
ffff80000010bdc9:	89 d1                	mov    %edx,%ecx
ffff80000010bdcb:	66 c7 00 0b 00       	movw   $0xb,(%rax)
ffff80000010bdd0:	66 89 78 02          	mov    %di,0x2(%rax)
ffff80000010bdd4:	40 88 70 04          	mov    %sil,0x4(%rax)
ffff80000010bdd8:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010bddc:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010bddf:	83 ca 09             	or     $0x9,%edx
ffff80000010bde2:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010bde5:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010bde9:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010bdec:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010bdef:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010bdf3:	83 ca 60             	or     $0x60,%edx
ffff80000010bdf6:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010bdf9:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010bdfd:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010be00:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010be03:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010be07:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010be0a:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010be0d:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010be11:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010be14:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010be17:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010be1b:	83 e2 df             	and    $0xffffffdf,%edx
ffff80000010be1e:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010be21:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010be25:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010be28:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010be2b:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010be2f:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010be32:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010be35:	88 48 07             	mov    %cl,0x7(%rax)
  gdt[SEG_TSS+1] = SEG(0, addr >> 32, addr >> 48, 0, 0, 0);
ffff80000010be38:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010be3c:	48 83 c0 40          	add    $0x40,%rax
ffff80000010be40:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010be44:	48 c1 ea 20          	shr    $0x20,%rdx
ffff80000010be48:	41 89 d1             	mov    %edx,%r9d
ffff80000010be4b:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010be4f:	48 c1 ea 30          	shr    $0x30,%rdx
ffff80000010be53:	41 89 d0             	mov    %edx,%r8d
ffff80000010be56:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010be5a:	48 c1 ea 30          	shr    $0x30,%rdx
ffff80000010be5e:	48 c1 ea 10          	shr    $0x10,%rdx
ffff80000010be62:	89 d7                	mov    %edx,%edi
ffff80000010be64:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010be68:	48 c1 ea 20          	shr    $0x20,%rdx
ffff80000010be6c:	48 c1 ea 3c          	shr    $0x3c,%rdx
ffff80000010be70:	83 e2 0f             	and    $0xf,%edx
ffff80000010be73:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff80000010be77:	48 c1 e9 30          	shr    $0x30,%rcx
ffff80000010be7b:	48 c1 e9 18          	shr    $0x18,%rcx
ffff80000010be7f:	89 ce                	mov    %ecx,%esi
ffff80000010be81:	66 44 89 08          	mov    %r9w,(%rax)
ffff80000010be85:	66 44 89 40 02       	mov    %r8w,0x2(%rax)
ffff80000010be8a:	40 88 78 04          	mov    %dil,0x4(%rax)
ffff80000010be8e:	0f b6 48 05          	movzbl 0x5(%rax),%ecx
ffff80000010be92:	83 e1 f0             	and    $0xfffffff0,%ecx
ffff80000010be95:	88 48 05             	mov    %cl,0x5(%rax)
ffff80000010be98:	0f b6 48 05          	movzbl 0x5(%rax),%ecx
ffff80000010be9c:	83 e1 ef             	and    $0xffffffef,%ecx
ffff80000010be9f:	88 48 05             	mov    %cl,0x5(%rax)
ffff80000010bea2:	0f b6 48 05          	movzbl 0x5(%rax),%ecx
ffff80000010bea6:	83 e1 9f             	and    $0xffffff9f,%ecx
ffff80000010bea9:	88 48 05             	mov    %cl,0x5(%rax)
ffff80000010beac:	0f b6 48 05          	movzbl 0x5(%rax),%ecx
ffff80000010beb0:	83 c9 80             	or     $0xffffff80,%ecx
ffff80000010beb3:	88 48 05             	mov    %cl,0x5(%rax)
ffff80000010beb6:	89 d1                	mov    %edx,%ecx
ffff80000010beb8:	83 e1 0f             	and    $0xf,%ecx
ffff80000010bebb:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010bebf:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010bec2:	09 ca                	or     %ecx,%edx
ffff80000010bec4:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010bec7:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010becb:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010bece:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010bed1:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010bed5:	83 e2 df             	and    $0xffffffdf,%edx
ffff80000010bed8:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010bedb:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010bedf:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010bee2:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010bee5:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010bee9:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010beec:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010beef:	40 88 70 07          	mov    %sil,0x7(%rax)
  lgdt((void*) gdt, (NSEGS+1) * sizeof(struct segdesc));
ffff80000010bef3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bef7:	be 48 00 00 00       	mov    $0x48,%esi
ffff80000010befc:	48 89 c7             	mov    %rax,%rdi
ffff80000010beff:	48 b8 9a b9 10 00 00 	movabs $0xffff80000010b99a,%rax
ffff80000010bf06:	80 ff ff 
ffff80000010bf09:	ff d0                	call   *%rax
  ltr(SEG_TSS << 3);
ffff80000010bf0b:	bf 38 00 00 00       	mov    $0x38,%edi
ffff80000010bf10:	48 b8 f5 b9 10 00 00 	movabs $0xffff80000010b9f5,%rax
ffff80000010bf17:	80 ff ff 
ffff80000010bf1a:	ff d0                	call   *%rax
};
ffff80000010bf1c:	90                   	nop
ffff80000010bf1d:	c9                   	leave
ffff80000010bf1e:	c3                   	ret

ffff80000010bf1f <setupkvm>:
{
ffff80000010bf1f:	f3 0f 1e fa          	endbr64
ffff80000010bf23:	55                   	push   %rbp
ffff80000010bf24:	48 89 e5             	mov    %rsp,%rbp
ffff80000010bf27:	48 83 ec 10          	sub    $0x10,%rsp
  pml4e_t *pml4 = (pml4e_t*) kalloc();
ffff80000010bf2b:	48 b8 78 43 10 00 00 	movabs $0xffff800000104378,%rax
ffff80000010bf32:	80 ff ff 
ffff80000010bf35:	ff d0                	call   *%rax
ffff80000010bf37:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(pml4, 0, PGSIZE);
ffff80000010bf3b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010bf3f:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010bf44:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010bf49:	48 89 c7             	mov    %rax,%rdi
ffff80000010bf4c:	48 b8 40 82 10 00 00 	movabs $0xffff800000108240,%rax
ffff80000010bf53:	80 ff ff 
ffff80000010bf56:	ff d0                	call   *%rax
  pml4[256] = v2p(kpdpt) | PTE_P | PTE_W;
ffff80000010bf58:	48 b8 80 fa 11 00 00 	movabs $0xffff80000011fa80,%rax
ffff80000010bf5f:	80 ff ff 
ffff80000010bf62:	48 8b 00             	mov    (%rax),%rax
ffff80000010bf65:	48 89 c7             	mov    %rax,%rdi
ffff80000010bf68:	48 b8 2b ba 10 00 00 	movabs $0xffff80000010ba2b,%rax
ffff80000010bf6f:	80 ff ff 
ffff80000010bf72:	ff d0                	call   *%rax
ffff80000010bf74:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010bf78:	48 81 c2 00 08 00 00 	add    $0x800,%rdx
ffff80000010bf7f:	48 83 c8 03          	or     $0x3,%rax
ffff80000010bf83:	48 89 02             	mov    %rax,(%rdx)
  return pml4;
ffff80000010bf86:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
};
ffff80000010bf8a:	c9                   	leave
ffff80000010bf8b:	c3                   	ret

ffff80000010bf8c <kvmalloc>:
{
ffff80000010bf8c:	f3 0f 1e fa          	endbr64
ffff80000010bf90:	55                   	push   %rbp
ffff80000010bf91:	48 89 e5             	mov    %rsp,%rbp
  kpml4 = (pml4e_t*) kalloc();
ffff80000010bf94:	48 b8 78 43 10 00 00 	movabs $0xffff800000104378,%rax
ffff80000010bf9b:	80 ff ff 
ffff80000010bf9e:	ff d0                	call   *%rax
ffff80000010bfa0:	48 ba 78 fa 11 00 00 	movabs $0xffff80000011fa78,%rdx
ffff80000010bfa7:	80 ff ff 
ffff80000010bfaa:	48 89 02             	mov    %rax,(%rdx)
  memset(kpml4, 0, PGSIZE);
ffff80000010bfad:	48 b8 78 fa 11 00 00 	movabs $0xffff80000011fa78,%rax
ffff80000010bfb4:	80 ff ff 
ffff80000010bfb7:	48 8b 00             	mov    (%rax),%rax
ffff80000010bfba:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010bfbf:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010bfc4:	48 89 c7             	mov    %rax,%rdi
ffff80000010bfc7:	48 b8 40 82 10 00 00 	movabs $0xffff800000108240,%rax
ffff80000010bfce:	80 ff ff 
ffff80000010bfd1:	ff d0                	call   *%rax
  kpdpt = (pde_t*) kalloc();
ffff80000010bfd3:	48 b8 78 43 10 00 00 	movabs $0xffff800000104378,%rax
ffff80000010bfda:	80 ff ff 
ffff80000010bfdd:	ff d0                	call   *%rax
ffff80000010bfdf:	48 ba 80 fa 11 00 00 	movabs $0xffff80000011fa80,%rdx
ffff80000010bfe6:	80 ff ff 
ffff80000010bfe9:	48 89 02             	mov    %rax,(%rdx)
  memset(kpdpt, 0, PGSIZE);
ffff80000010bfec:	48 b8 80 fa 11 00 00 	movabs $0xffff80000011fa80,%rax
ffff80000010bff3:	80 ff ff 
ffff80000010bff6:	48 8b 00             	mov    (%rax),%rax
ffff80000010bff9:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010bffe:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010c003:	48 89 c7             	mov    %rax,%rdi
ffff80000010c006:	48 b8 40 82 10 00 00 	movabs $0xffff800000108240,%rax
ffff80000010c00d:	80 ff ff 
ffff80000010c010:	ff d0                	call   *%rax
  kpml4[PMX(KERNBASE)] = v2p(kpdpt) | PTE_P | PTE_W;
ffff80000010c012:	48 b8 80 fa 11 00 00 	movabs $0xffff80000011fa80,%rax
ffff80000010c019:	80 ff ff 
ffff80000010c01c:	48 8b 00             	mov    (%rax),%rax
ffff80000010c01f:	48 89 c7             	mov    %rax,%rdi
ffff80000010c022:	48 b8 2b ba 10 00 00 	movabs $0xffff80000010ba2b,%rax
ffff80000010c029:	80 ff ff 
ffff80000010c02c:	ff d0                	call   *%rax
ffff80000010c02e:	48 ba 78 fa 11 00 00 	movabs $0xffff80000011fa78,%rdx
ffff80000010c035:	80 ff ff 
ffff80000010c038:	48 8b 12             	mov    (%rdx),%rdx
ffff80000010c03b:	48 81 c2 00 08 00 00 	add    $0x800,%rdx
ffff80000010c042:	48 83 c8 03          	or     $0x3,%rax
ffff80000010c046:	48 89 02             	mov    %rax,(%rdx)
  kpdpt[0] = 0 | PTE_PS | PTE_P | PTE_W;
ffff80000010c049:	48 b8 80 fa 11 00 00 	movabs $0xffff80000011fa80,%rax
ffff80000010c050:	80 ff ff 
ffff80000010c053:	48 8b 00             	mov    (%rax),%rax
ffff80000010c056:	48 c7 00 83 00 00 00 	movq   $0x83,(%rax)
  kpdpt[3] = 0xC0000000 | PTE_PS | PTE_P | PTE_W | PTE_PWT | PTE_PCD;
ffff80000010c05d:	48 b8 80 fa 11 00 00 	movabs $0xffff80000011fa80,%rax
ffff80000010c064:	80 ff ff 
ffff80000010c067:	48 8b 00             	mov    (%rax),%rax
ffff80000010c06a:	48 83 c0 18          	add    $0x18,%rax
ffff80000010c06e:	b9 9b 00 00 c0       	mov    $0xc000009b,%ecx
ffff80000010c073:	48 89 08             	mov    %rcx,(%rax)
  switchkvm();
ffff80000010c076:	48 b8 99 c3 10 00 00 	movabs $0xffff80000010c399,%rax
ffff80000010c07d:	80 ff ff 
ffff80000010c080:	ff d0                	call   *%rax
}
ffff80000010c082:	90                   	nop
ffff80000010c083:	5d                   	pop    %rbp
ffff80000010c084:	c3                   	ret

ffff80000010c085 <switchuvm>:
{
ffff80000010c085:	f3 0f 1e fa          	endbr64
ffff80000010c089:	55                   	push   %rbp
ffff80000010c08a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010c08d:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010c091:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  pushcli();
ffff80000010c095:	48 b8 bc 80 10 00 00 	movabs $0xffff8000001080bc,%rax
ffff80000010c09c:	80 ff ff 
ffff80000010c09f:	ff d0                	call   *%rax
  if(p->pgdir == 0)
ffff80000010c0a1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c0a5:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010c0a9:	48 85 c0             	test   %rax,%rax
ffff80000010c0ac:	75 19                	jne    ffff80000010c0c7 <switchuvm+0x42>
    panic("switchuvm: no pgdir");
ffff80000010c0ae:	48 b8 28 d6 10 00 00 	movabs $0xffff80000010d628,%rax
ffff80000010c0b5:	80 ff ff 
ffff80000010c0b8:	48 89 c7             	mov    %rax,%rdi
ffff80000010c0bb:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010c0c2:	80 ff ff 
ffff80000010c0c5:	ff d0                	call   *%rax
  uint *tss = (uint*) (((char*) cpu->local) + 1024);
ffff80000010c0c7:	64 48 8b 04 25 f0 ff 	mov    %fs:0xfffffffffffffff0,%rax
ffff80000010c0ce:	ff ff 
ffff80000010c0d0:	48 8b 40 20          	mov    0x20(%rax),%rax
ffff80000010c0d4:	48 05 00 04 00 00    	add    $0x400,%rax
ffff80000010c0da:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  const addr_t stktop = (addr_t)p->kstack + KSTACKSIZE;
ffff80000010c0de:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c0e2:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff80000010c0e6:	48 05 00 10 00 00    	add    $0x1000,%rax
ffff80000010c0ec:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  tss[1] = (uint)stktop; // https://wiki.osdev.org/Task_State_Segment
ffff80000010c0f0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c0f4:	48 83 c0 04          	add    $0x4,%rax
ffff80000010c0f8:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff80000010c0fc:	89 10                	mov    %edx,(%rax)
  tss[2] = (uint)(stktop >> 32);
ffff80000010c0fe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c102:	48 c1 e8 20          	shr    $0x20,%rax
ffff80000010c106:	48 89 c2             	mov    %rax,%rdx
ffff80000010c109:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c10d:	48 83 c0 08          	add    $0x8,%rax
ffff80000010c111:	89 10                	mov    %edx,(%rax)
  lcr3(v2p(p->pgdir));
ffff80000010c113:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c117:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010c11b:	48 89 c7             	mov    %rax,%rdi
ffff80000010c11e:	48 b8 2b ba 10 00 00 	movabs $0xffff80000010ba2b,%rax
ffff80000010c125:	80 ff ff 
ffff80000010c128:	ff d0                	call   *%rax
ffff80000010c12a:	48 89 c7             	mov    %rax,%rdi
ffff80000010c12d:	48 b8 11 ba 10 00 00 	movabs $0xffff80000010ba11,%rax
ffff80000010c134:	80 ff ff 
ffff80000010c137:	ff d0                	call   *%rax
  popcli();
ffff80000010c139:	48 b8 2e 81 10 00 00 	movabs $0xffff80000010812e,%rax
ffff80000010c140:	80 ff ff 
ffff80000010c143:	ff d0                	call   *%rax
}
ffff80000010c145:	90                   	nop
ffff80000010c146:	c9                   	leave
ffff80000010c147:	c3                   	ret

ffff80000010c148 <walkpgdir>:
// In 64-bit mode, the page table has four levels: PML4, PDPT, PD and PT
// For each level, we dereference the correct entry, or allocate and
// initialize entry if the PTE_P bit is not set
static pte_t *
walkpgdir(pde_t *pml4, const void *va, int alloc)
{
ffff80000010c148:	f3 0f 1e fa          	endbr64
ffff80000010c14c:	55                   	push   %rbp
ffff80000010c14d:	48 89 e5             	mov    %rsp,%rbp
ffff80000010c150:	48 83 ec 50          	sub    $0x50,%rsp
ffff80000010c154:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
ffff80000010c158:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
ffff80000010c15c:	89 55 bc             	mov    %edx,-0x44(%rbp)
  pml4e_t *pml4e;
  pdpe_t *pdp, *pdpe;
  pde_t *pde, *pd, *pgtab;

  // from the PML4, find or allocate the appropriate PDP table
  pml4e = &pml4[PMX(va)];
ffff80000010c15f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010c163:	48 c1 e8 27          	shr    $0x27,%rax
ffff80000010c167:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010c16c:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010c173:	00 
ffff80000010c174:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010c178:	48 01 d0             	add    %rdx,%rax
ffff80000010c17b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  if(*pml4e & PTE_P)
ffff80000010c17f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010c183:	48 8b 00             	mov    (%rax),%rax
ffff80000010c186:	83 e0 01             	and    $0x1,%eax
ffff80000010c189:	48 85 c0             	test   %rax,%rax
ffff80000010c18c:	74 23                	je     ffff80000010c1b1 <walkpgdir+0x69>
    pdp = (pdpe_t*)P2V(PTE_ADDR(*pml4e));
ffff80000010c18e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010c192:	48 8b 00             	mov    (%rax),%rax
ffff80000010c195:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010c19b:	48 89 c2             	mov    %rax,%rdx
ffff80000010c19e:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010c1a5:	80 ff ff 
ffff80000010c1a8:	48 01 d0             	add    %rdx,%rax
ffff80000010c1ab:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010c1af:	eb 63                	jmp    ffff80000010c214 <walkpgdir+0xcc>
  else {
    if(!alloc || (pdp = (pdpe_t*)kalloc()) == 0)
ffff80000010c1b1:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
ffff80000010c1b5:	74 17                	je     ffff80000010c1ce <walkpgdir+0x86>
ffff80000010c1b7:	48 b8 78 43 10 00 00 	movabs $0xffff800000104378,%rax
ffff80000010c1be:	80 ff ff 
ffff80000010c1c1:	ff d0                	call   *%rax
ffff80000010c1c3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010c1c7:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff80000010c1cc:	75 0a                	jne    ffff80000010c1d8 <walkpgdir+0x90>
      return 0;
ffff80000010c1ce:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010c1d3:	e9 bf 01 00 00       	jmp    ffff80000010c397 <walkpgdir+0x24f>
    memset(pdp, 0, PGSIZE);
ffff80000010c1d8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c1dc:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010c1e1:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010c1e6:	48 89 c7             	mov    %rax,%rdi
ffff80000010c1e9:	48 b8 40 82 10 00 00 	movabs $0xffff800000108240,%rax
ffff80000010c1f0:	80 ff ff 
ffff80000010c1f3:	ff d0                	call   *%rax
    *pml4e = V2P(pdp) | PTE_P | PTE_W | PTE_U;
ffff80000010c1f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c1f9:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010c200:	80 00 00 
ffff80000010c203:	48 01 d0             	add    %rdx,%rax
ffff80000010c206:	48 83 c8 07          	or     $0x7,%rax
ffff80000010c20a:	48 89 c2             	mov    %rax,%rdx
ffff80000010c20d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010c211:	48 89 10             	mov    %rdx,(%rax)
  }

  //from the PDP, find or allocate the appropriate PD (page directory)
  pdpe = &pdp[PDPX(va)];
ffff80000010c214:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010c218:	48 c1 e8 1e          	shr    $0x1e,%rax
ffff80000010c21c:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010c221:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010c228:	00 
ffff80000010c229:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c22d:	48 01 d0             	add    %rdx,%rax
ffff80000010c230:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  if(*pdpe & PTE_P)
ffff80000010c234:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010c238:	48 8b 00             	mov    (%rax),%rax
ffff80000010c23b:	83 e0 01             	and    $0x1,%eax
ffff80000010c23e:	48 85 c0             	test   %rax,%rax
ffff80000010c241:	74 23                	je     ffff80000010c266 <walkpgdir+0x11e>
    pd = (pde_t*)P2V(PTE_ADDR(*pdpe));
ffff80000010c243:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010c247:	48 8b 00             	mov    (%rax),%rax
ffff80000010c24a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010c250:	48 89 c2             	mov    %rax,%rdx
ffff80000010c253:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010c25a:	80 ff ff 
ffff80000010c25d:	48 01 d0             	add    %rdx,%rax
ffff80000010c260:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010c264:	eb 63                	jmp    ffff80000010c2c9 <walkpgdir+0x181>
  else {
    if(!alloc || (pd = (pde_t*)kalloc()) == 0)//allocate page table
ffff80000010c266:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
ffff80000010c26a:	74 17                	je     ffff80000010c283 <walkpgdir+0x13b>
ffff80000010c26c:	48 b8 78 43 10 00 00 	movabs $0xffff800000104378,%rax
ffff80000010c273:	80 ff ff 
ffff80000010c276:	ff d0                	call   *%rax
ffff80000010c278:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010c27c:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010c281:	75 0a                	jne    ffff80000010c28d <walkpgdir+0x145>
      return 0;
ffff80000010c283:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010c288:	e9 0a 01 00 00       	jmp    ffff80000010c397 <walkpgdir+0x24f>
    memset(pd, 0, PGSIZE);
ffff80000010c28d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c291:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010c296:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010c29b:	48 89 c7             	mov    %rax,%rdi
ffff80000010c29e:	48 b8 40 82 10 00 00 	movabs $0xffff800000108240,%rax
ffff80000010c2a5:	80 ff ff 
ffff80000010c2a8:	ff d0                	call   *%rax
    *pdpe = V2P(pd) | PTE_P | PTE_W | PTE_U;
ffff80000010c2aa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c2ae:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010c2b5:	80 00 00 
ffff80000010c2b8:	48 01 d0             	add    %rdx,%rax
ffff80000010c2bb:	48 83 c8 07          	or     $0x7,%rax
ffff80000010c2bf:	48 89 c2             	mov    %rax,%rdx
ffff80000010c2c2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010c2c6:	48 89 10             	mov    %rdx,(%rax)
  }

  // from the PD, find or allocate the appropriate page table
  pde = &pd[PDX(va)];
ffff80000010c2c9:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010c2cd:	48 c1 e8 15          	shr    $0x15,%rax
ffff80000010c2d1:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010c2d6:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010c2dd:	00 
ffff80000010c2de:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c2e2:	48 01 d0             	add    %rdx,%rax
ffff80000010c2e5:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  if(*pde & PTE_P)
ffff80000010c2e9:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010c2ed:	48 8b 00             	mov    (%rax),%rax
ffff80000010c2f0:	83 e0 01             	and    $0x1,%eax
ffff80000010c2f3:	48 85 c0             	test   %rax,%rax
ffff80000010c2f6:	74 23                	je     ffff80000010c31b <walkpgdir+0x1d3>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
ffff80000010c2f8:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010c2fc:	48 8b 00             	mov    (%rax),%rax
ffff80000010c2ff:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010c305:	48 89 c2             	mov    %rax,%rdx
ffff80000010c308:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010c30f:	80 ff ff 
ffff80000010c312:	48 01 d0             	add    %rdx,%rax
ffff80000010c315:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010c319:	eb 60                	jmp    ffff80000010c37b <walkpgdir+0x233>
  else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)//allocate page table
ffff80000010c31b:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
ffff80000010c31f:	74 17                	je     ffff80000010c338 <walkpgdir+0x1f0>
ffff80000010c321:	48 b8 78 43 10 00 00 	movabs $0xffff800000104378,%rax
ffff80000010c328:	80 ff ff 
ffff80000010c32b:	ff d0                	call   *%rax
ffff80000010c32d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010c331:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010c336:	75 07                	jne    ffff80000010c33f <walkpgdir+0x1f7>
      return 0;
ffff80000010c338:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010c33d:	eb 58                	jmp    ffff80000010c397 <walkpgdir+0x24f>
    memset(pgtab, 0, PGSIZE);
ffff80000010c33f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c343:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010c348:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010c34d:	48 89 c7             	mov    %rax,%rdi
ffff80000010c350:	48 b8 40 82 10 00 00 	movabs $0xffff800000108240,%rax
ffff80000010c357:	80 ff ff 
ffff80000010c35a:	ff d0                	call   *%rax
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
ffff80000010c35c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c360:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010c367:	80 00 00 
ffff80000010c36a:	48 01 d0             	add    %rdx,%rax
ffff80000010c36d:	48 83 c8 07          	or     $0x7,%rax
ffff80000010c371:	48 89 c2             	mov    %rax,%rdx
ffff80000010c374:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010c378:	48 89 10             	mov    %rdx,(%rax)
  }

  return &pgtab[PTX(va)];
ffff80000010c37b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010c37f:	48 c1 e8 0c          	shr    $0xc,%rax
ffff80000010c383:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010c388:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010c38f:	00 
ffff80000010c390:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c394:	48 01 d0             	add    %rdx,%rax
}
ffff80000010c397:	c9                   	leave
ffff80000010c398:	c3                   	ret

ffff80000010c399 <switchkvm>:

void
switchkvm(void)
{
ffff80000010c399:	f3 0f 1e fa          	endbr64
ffff80000010c39d:	55                   	push   %rbp
ffff80000010c39e:	48 89 e5             	mov    %rsp,%rbp
  lcr3(v2p(kpml4));
ffff80000010c3a1:	48 b8 78 fa 11 00 00 	movabs $0xffff80000011fa78,%rax
ffff80000010c3a8:	80 ff ff 
ffff80000010c3ab:	48 8b 00             	mov    (%rax),%rax
ffff80000010c3ae:	48 89 c7             	mov    %rax,%rdi
ffff80000010c3b1:	48 b8 2b ba 10 00 00 	movabs $0xffff80000010ba2b,%rax
ffff80000010c3b8:	80 ff ff 
ffff80000010c3bb:	ff d0                	call   *%rax
ffff80000010c3bd:	48 89 c7             	mov    %rax,%rdi
ffff80000010c3c0:	48 b8 11 ba 10 00 00 	movabs $0xffff80000010ba11,%rax
ffff80000010c3c7:	80 ff ff 
ffff80000010c3ca:	ff d0                	call   *%rax
}
ffff80000010c3cc:	90                   	nop
ffff80000010c3cd:	5d                   	pop    %rbp
ffff80000010c3ce:	c3                   	ret

ffff80000010c3cf <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
int
mappages(pde_t *pgdir, void *va, addr_t size, addr_t pa, int perm)
{
ffff80000010c3cf:	f3 0f 1e fa          	endbr64
ffff80000010c3d3:	55                   	push   %rbp
ffff80000010c3d4:	48 89 e5             	mov    %rsp,%rbp
ffff80000010c3d7:	48 83 ec 50          	sub    $0x50,%rsp
ffff80000010c3db:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010c3df:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010c3e3:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
ffff80000010c3e7:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
ffff80000010c3eb:	44 89 45 bc          	mov    %r8d,-0x44(%rbp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((addr_t)va);
ffff80000010c3ef:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010c3f3:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010c3f9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  last = (char*)PGROUNDDOWN(((addr_t)va) + size - 1);
ffff80000010c3fd:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffff80000010c401:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010c405:	48 01 d0             	add    %rdx,%rax
ffff80000010c408:	48 83 e8 01          	sub    $0x1,%rax
ffff80000010c40c:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010c412:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
ffff80000010c416:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff80000010c41a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010c41e:	ba 01 00 00 00       	mov    $0x1,%edx
ffff80000010c423:	48 89 ce             	mov    %rcx,%rsi
ffff80000010c426:	48 89 c7             	mov    %rax,%rdi
ffff80000010c429:	48 b8 48 c1 10 00 00 	movabs $0xffff80000010c148,%rax
ffff80000010c430:	80 ff ff 
ffff80000010c433:	ff d0                	call   *%rax
ffff80000010c435:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010c439:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010c43e:	75 07                	jne    ffff80000010c447 <mappages+0x78>
      return -1;
ffff80000010c440:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010c445:	eb 64                	jmp    ffff80000010c4ab <mappages+0xdc>
    if(*pte & PTE_P)
ffff80000010c447:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c44b:	48 8b 00             	mov    (%rax),%rax
ffff80000010c44e:	83 e0 01             	and    $0x1,%eax
ffff80000010c451:	48 85 c0             	test   %rax,%rax
ffff80000010c454:	74 19                	je     ffff80000010c46f <mappages+0xa0>
      panic("remap");
ffff80000010c456:	48 b8 3c d6 10 00 00 	movabs $0xffff80000010d63c,%rax
ffff80000010c45d:	80 ff ff 
ffff80000010c460:	48 89 c7             	mov    %rax,%rdi
ffff80000010c463:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010c46a:	80 ff ff 
ffff80000010c46d:	ff d0                	call   *%rax
    *pte = pa | perm | PTE_P;
ffff80000010c46f:	8b 45 bc             	mov    -0x44(%rbp),%eax
ffff80000010c472:	48 98                	cltq
ffff80000010c474:	48 0b 45 c0          	or     -0x40(%rbp),%rax
ffff80000010c478:	48 83 c8 01          	or     $0x1,%rax
ffff80000010c47c:	48 89 c2             	mov    %rax,%rdx
ffff80000010c47f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c483:	48 89 10             	mov    %rdx,(%rax)
    if(a == last)
ffff80000010c486:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c48a:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
ffff80000010c48e:	74 15                	je     ffff80000010c4a5 <mappages+0xd6>
      break;
    a += PGSIZE;
ffff80000010c490:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffff80000010c497:	00 
    pa += PGSIZE;
ffff80000010c498:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
ffff80000010c49f:	00 
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
ffff80000010c4a0:	e9 71 ff ff ff       	jmp    ffff80000010c416 <mappages+0x47>
      break;
ffff80000010c4a5:	90                   	nop
  }
  return 0;
ffff80000010c4a6:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010c4ab:	c9                   	leave
ffff80000010c4ac:	c3                   	ret

ffff80000010c4ad <inituvm>:

// Load the initcode into address 0x1000 (4KB) of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
ffff80000010c4ad:	f3 0f 1e fa          	endbr64
ffff80000010c4b1:	55                   	push   %rbp
ffff80000010c4b2:	48 89 e5             	mov    %rsp,%rbp
ffff80000010c4b5:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010c4b9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010c4bd:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff80000010c4c1:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *mem;

  if(sz >= PGSIZE)
ffff80000010c4c4:	81 7d dc ff 0f 00 00 	cmpl   $0xfff,-0x24(%rbp)
ffff80000010c4cb:	76 19                	jbe    ffff80000010c4e6 <inituvm+0x39>
    panic("inituvm: more than a page");
ffff80000010c4cd:	48 b8 42 d6 10 00 00 	movabs $0xffff80000010d642,%rax
ffff80000010c4d4:	80 ff ff 
ffff80000010c4d7:	48 89 c7             	mov    %rax,%rdi
ffff80000010c4da:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010c4e1:	80 ff ff 
ffff80000010c4e4:	ff d0                	call   *%rax

  mem = kalloc();
ffff80000010c4e6:	48 b8 78 43 10 00 00 	movabs $0xffff800000104378,%rax
ffff80000010c4ed:	80 ff ff 
ffff80000010c4f0:	ff d0                	call   *%rax
ffff80000010c4f2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(mem, 0, PGSIZE);
ffff80000010c4f6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c4fa:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010c4ff:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010c504:	48 89 c7             	mov    %rax,%rdi
ffff80000010c507:	48 b8 40 82 10 00 00 	movabs $0xffff800000108240,%rax
ffff80000010c50e:	80 ff ff 
ffff80000010c511:	ff d0                	call   *%rax
  mappages(pgdir, (void *)PGSIZE, PGSIZE, V2P(mem), PTE_W|PTE_U);
ffff80000010c513:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c517:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010c51e:	80 00 00 
ffff80000010c521:	48 01 c2             	add    %rax,%rdx
ffff80000010c524:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c528:	41 b8 06 00 00 00    	mov    $0x6,%r8d
ffff80000010c52e:	48 89 d1             	mov    %rdx,%rcx
ffff80000010c531:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010c536:	be 00 10 00 00       	mov    $0x1000,%esi
ffff80000010c53b:	48 89 c7             	mov    %rax,%rdi
ffff80000010c53e:	48 b8 cf c3 10 00 00 	movabs $0xffff80000010c3cf,%rax
ffff80000010c545:	80 ff ff 
ffff80000010c548:	ff d0                	call   *%rax

  memmove(mem, init, sz);
ffff80000010c54a:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffff80000010c54d:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff80000010c551:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c555:	48 89 ce             	mov    %rcx,%rsi
ffff80000010c558:	48 89 c7             	mov    %rax,%rdi
ffff80000010c55b:	48 b8 4d 83 10 00 00 	movabs $0xffff80000010834d,%rax
ffff80000010c562:	80 ff ff 
ffff80000010c565:	ff d0                	call   *%rax
}
ffff80000010c567:	90                   	nop
ffff80000010c568:	c9                   	leave
ffff80000010c569:	c3                   	ret

ffff80000010c56a <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
ffff80000010c56a:	f3 0f 1e fa          	endbr64
ffff80000010c56e:	55                   	push   %rbp
ffff80000010c56f:	48 89 e5             	mov    %rsp,%rbp
ffff80000010c572:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010c576:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010c57a:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010c57e:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
ffff80000010c582:	89 4d c4             	mov    %ecx,-0x3c(%rbp)
ffff80000010c585:	44 89 45 c0          	mov    %r8d,-0x40(%rbp)
  uint i, n;
  addr_t pa;
  pte_t *pte;

  if((addr_t) addr % PGSIZE != 0)
ffff80000010c589:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010c58d:	25 ff 0f 00 00       	and    $0xfff,%eax
ffff80000010c592:	48 85 c0             	test   %rax,%rax
ffff80000010c595:	74 19                	je     ffff80000010c5b0 <loaduvm+0x46>
    panic("loaduvm: addr must be page aligned");
ffff80000010c597:	48 b8 60 d6 10 00 00 	movabs $0xffff80000010d660,%rax
ffff80000010c59e:	80 ff ff 
ffff80000010c5a1:	48 89 c7             	mov    %rax,%rdi
ffff80000010c5a4:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010c5ab:	80 ff ff 
ffff80000010c5ae:	ff d0                	call   *%rax
  for(i = 0; i < sz; i += PGSIZE){
ffff80000010c5b0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010c5b7:	e9 c7 00 00 00       	jmp    ffff80000010c683 <loaduvm+0x119>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
ffff80000010c5bc:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010c5bf:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010c5c3:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffff80000010c5c7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010c5cb:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010c5d0:	48 89 ce             	mov    %rcx,%rsi
ffff80000010c5d3:	48 89 c7             	mov    %rax,%rdi
ffff80000010c5d6:	48 b8 48 c1 10 00 00 	movabs $0xffff80000010c148,%rax
ffff80000010c5dd:	80 ff ff 
ffff80000010c5e0:	ff d0                	call   *%rax
ffff80000010c5e2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010c5e6:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010c5eb:	75 19                	jne    ffff80000010c606 <loaduvm+0x9c>
      panic("loaduvm: address should exist");
ffff80000010c5ed:	48 b8 83 d6 10 00 00 	movabs $0xffff80000010d683,%rax
ffff80000010c5f4:	80 ff ff 
ffff80000010c5f7:	48 89 c7             	mov    %rax,%rdi
ffff80000010c5fa:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010c601:	80 ff ff 
ffff80000010c604:	ff d0                	call   *%rax
    pa = PTE_ADDR(*pte);
ffff80000010c606:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c60a:	48 8b 00             	mov    (%rax),%rax
ffff80000010c60d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010c613:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if(sz - i < PGSIZE)
ffff80000010c617:	8b 45 c0             	mov    -0x40(%rbp),%eax
ffff80000010c61a:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff80000010c61d:	3d ff 0f 00 00       	cmp    $0xfff,%eax
ffff80000010c622:	77 0b                	ja     ffff80000010c62f <loaduvm+0xc5>
      n = sz - i;
ffff80000010c624:	8b 45 c0             	mov    -0x40(%rbp),%eax
ffff80000010c627:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff80000010c62a:	89 45 f8             	mov    %eax,-0x8(%rbp)
ffff80000010c62d:	eb 07                	jmp    ffff80000010c636 <loaduvm+0xcc>
    else
      n = PGSIZE;
ffff80000010c62f:	c7 45 f8 00 10 00 00 	movl   $0x1000,-0x8(%rbp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
ffff80000010c636:	8b 55 c4             	mov    -0x3c(%rbp),%edx
ffff80000010c639:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010c63c:	8d 34 02             	lea    (%rdx,%rax,1),%esi
ffff80000010c63f:	48 ba 00 00 00 00 00 	movabs $0xffff800000000000,%rdx
ffff80000010c646:	80 ff ff 
ffff80000010c649:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c64d:	48 01 d0             	add    %rdx,%rax
ffff80000010c650:	48 89 c7             	mov    %rax,%rdi
ffff80000010c653:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffff80000010c656:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010c65a:	89 d1                	mov    %edx,%ecx
ffff80000010c65c:	89 f2                	mov    %esi,%edx
ffff80000010c65e:	48 89 fe             	mov    %rdi,%rsi
ffff80000010c661:	48 89 c7             	mov    %rax,%rdi
ffff80000010c664:	48 b8 63 30 10 00 00 	movabs $0xffff800000103063,%rax
ffff80000010c66b:	80 ff ff 
ffff80000010c66e:	ff d0                	call   *%rax
ffff80000010c670:	39 45 f8             	cmp    %eax,-0x8(%rbp)
ffff80000010c673:	74 07                	je     ffff80000010c67c <loaduvm+0x112>
      return -1;
ffff80000010c675:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010c67a:	eb 18                	jmp    ffff80000010c694 <loaduvm+0x12a>
  for(i = 0; i < sz; i += PGSIZE){
ffff80000010c67c:	81 45 fc 00 10 00 00 	addl   $0x1000,-0x4(%rbp)
ffff80000010c683:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010c686:	3b 45 c0             	cmp    -0x40(%rbp),%eax
ffff80000010c689:	0f 82 2d ff ff ff    	jb     ffff80000010c5bc <loaduvm+0x52>
  }
  return 0;
ffff80000010c68f:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010c694:	c9                   	leave
ffff80000010c695:	c3                   	ret

ffff80000010c696 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
uint64
allocuvm(pde_t *pgdir, uint64 oldsz, uint64 newsz)
{
ffff80000010c696:	f3 0f 1e fa          	endbr64
ffff80000010c69a:	55                   	push   %rbp
ffff80000010c69b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010c69e:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010c6a2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010c6a6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff80000010c6aa:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  char *mem;
  addr_t a;

  if(newsz >= KERNBASE)
ffff80000010c6ae:	48 b8 ff ff ff ff ff 	movabs $0xffff7fffffffffff,%rax
ffff80000010c6b5:	7f ff ff 
ffff80000010c6b8:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
ffff80000010c6bc:	73 0a                	jae    ffff80000010c6c8 <allocuvm+0x32>
    return 0;
ffff80000010c6be:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010c6c3:	e9 14 01 00 00       	jmp    ffff80000010c7dc <allocuvm+0x146>
  if(newsz < oldsz)
ffff80000010c6c8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010c6cc:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
ffff80000010c6d0:	73 09                	jae    ffff80000010c6db <allocuvm+0x45>
    return oldsz;
ffff80000010c6d2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010c6d6:	e9 01 01 00 00       	jmp    ffff80000010c7dc <allocuvm+0x146>

  a = PGROUNDUP(oldsz);
ffff80000010c6db:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010c6df:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffff80000010c6e5:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010c6eb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  for(; a < newsz; a += PGSIZE){
ffff80000010c6ef:	e9 d6 00 00 00       	jmp    ffff80000010c7ca <allocuvm+0x134>
    mem = kalloc();
ffff80000010c6f4:	48 b8 78 43 10 00 00 	movabs $0xffff800000104378,%rax
ffff80000010c6fb:	80 ff ff 
ffff80000010c6fe:	ff d0                	call   *%rax
ffff80000010c700:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if(mem == 0){
ffff80000010c704:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010c709:	75 28                	jne    ffff80000010c733 <allocuvm+0x9d>
      //cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
ffff80000010c70b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff80000010c70f:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff80000010c713:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c717:	48 89 ce             	mov    %rcx,%rsi
ffff80000010c71a:	48 89 c7             	mov    %rax,%rdi
ffff80000010c71d:	48 b8 de c7 10 00 00 	movabs $0xffff80000010c7de,%rax
ffff80000010c724:	80 ff ff 
ffff80000010c727:	ff d0                	call   *%rax
      return 0;
ffff80000010c729:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010c72e:	e9 a9 00 00 00       	jmp    ffff80000010c7dc <allocuvm+0x146>
    }
    memset(mem, 0, PGSIZE);
ffff80000010c733:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c737:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010c73c:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010c741:	48 89 c7             	mov    %rax,%rdi
ffff80000010c744:	48 b8 40 82 10 00 00 	movabs $0xffff800000108240,%rax
ffff80000010c74b:	80 ff ff 
ffff80000010c74e:	ff d0                	call   *%rax
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
ffff80000010c750:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c754:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010c75b:	80 00 00 
ffff80000010c75e:	48 01 c2             	add    %rax,%rdx
ffff80000010c761:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
ffff80000010c765:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c769:	41 b8 06 00 00 00    	mov    $0x6,%r8d
ffff80000010c76f:	48 89 d1             	mov    %rdx,%rcx
ffff80000010c772:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010c777:	48 89 c7             	mov    %rax,%rdi
ffff80000010c77a:	48 b8 cf c3 10 00 00 	movabs $0xffff80000010c3cf,%rax
ffff80000010c781:	80 ff ff 
ffff80000010c784:	ff d0                	call   *%rax
ffff80000010c786:	85 c0                	test   %eax,%eax
ffff80000010c788:	79 38                	jns    ffff80000010c7c2 <allocuvm+0x12c>
      //cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
ffff80000010c78a:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff80000010c78e:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff80000010c792:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c796:	48 89 ce             	mov    %rcx,%rsi
ffff80000010c799:	48 89 c7             	mov    %rax,%rdi
ffff80000010c79c:	48 b8 de c7 10 00 00 	movabs $0xffff80000010c7de,%rax
ffff80000010c7a3:	80 ff ff 
ffff80000010c7a6:	ff d0                	call   *%rax
      kfree(mem);
ffff80000010c7a8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c7ac:	48 89 c7             	mov    %rax,%rdi
ffff80000010c7af:	48 b8 75 42 10 00 00 	movabs $0xffff800000104275,%rax
ffff80000010c7b6:	80 ff ff 
ffff80000010c7b9:	ff d0                	call   *%rax
      return 0;
ffff80000010c7bb:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010c7c0:	eb 1a                	jmp    ffff80000010c7dc <allocuvm+0x146>
  for(; a < newsz; a += PGSIZE){
ffff80000010c7c2:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffff80000010c7c9:	00 
ffff80000010c7ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c7ce:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
ffff80000010c7d2:	0f 82 1c ff ff ff    	jb     ffff80000010c6f4 <allocuvm+0x5e>
    }
  }
  return newsz;
ffff80000010c7d8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
}
ffff80000010c7dc:	c9                   	leave
ffff80000010c7dd:	c3                   	ret

ffff80000010c7de <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
deallocuvm(pde_t *pgdir, uint64 oldsz, uint64 newsz)
{
ffff80000010c7de:	f3 0f 1e fa          	endbr64
ffff80000010c7e2:	55                   	push   %rbp
ffff80000010c7e3:	48 89 e5             	mov    %rsp,%rbp
ffff80000010c7e6:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010c7ea:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010c7ee:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010c7f2:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  pte_t *pte;
  addr_t a, pa;

  if(newsz >= oldsz)
ffff80000010c7f6:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010c7fa:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
ffff80000010c7fe:	72 09                	jb     ffff80000010c809 <deallocuvm+0x2b>
    return oldsz;
ffff80000010c800:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010c804:	e9 d0 00 00 00       	jmp    ffff80000010c8d9 <deallocuvm+0xfb>

  a = PGROUNDUP(newsz);
ffff80000010c809:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010c80d:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffff80000010c813:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010c819:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  for(; a  < oldsz; a += PGSIZE){
ffff80000010c81d:	e9 a5 00 00 00       	jmp    ffff80000010c8c7 <deallocuvm+0xe9>
    pte = walkpgdir(pgdir, (char*)a, 0);
ffff80000010c822:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff80000010c826:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010c82a:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010c82f:	48 89 ce             	mov    %rcx,%rsi
ffff80000010c832:	48 89 c7             	mov    %rax,%rdi
ffff80000010c835:	48 b8 48 c1 10 00 00 	movabs $0xffff80000010c148,%rax
ffff80000010c83c:	80 ff ff 
ffff80000010c83f:	ff d0                	call   *%rax
ffff80000010c841:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if(pte && (*pte & PTE_P) != 0){
ffff80000010c845:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010c84a:	74 73                	je     ffff80000010c8bf <deallocuvm+0xe1>
ffff80000010c84c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c850:	48 8b 00             	mov    (%rax),%rax
ffff80000010c853:	83 e0 01             	and    $0x1,%eax
ffff80000010c856:	48 85 c0             	test   %rax,%rax
ffff80000010c859:	74 64                	je     ffff80000010c8bf <deallocuvm+0xe1>
      pa = PTE_ADDR(*pte);
ffff80000010c85b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c85f:	48 8b 00             	mov    (%rax),%rax
ffff80000010c862:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010c868:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
      if(pa == 0)
ffff80000010c86c:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010c871:	75 19                	jne    ffff80000010c88c <deallocuvm+0xae>
        panic("kfree");
ffff80000010c873:	48 b8 a1 d6 10 00 00 	movabs $0xffff80000010d6a1,%rax
ffff80000010c87a:	80 ff ff 
ffff80000010c87d:	48 89 c7             	mov    %rax,%rdi
ffff80000010c880:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010c887:	80 ff ff 
ffff80000010c88a:	ff d0                	call   *%rax
      char *v = P2V(pa);
ffff80000010c88c:	48 ba 00 00 00 00 00 	movabs $0xffff800000000000,%rdx
ffff80000010c893:	80 ff ff 
ffff80000010c896:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c89a:	48 01 d0             	add    %rdx,%rax
ffff80000010c89d:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
      kfree(v);
ffff80000010c8a1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010c8a5:	48 89 c7             	mov    %rax,%rdi
ffff80000010c8a8:	48 b8 75 42 10 00 00 	movabs $0xffff800000104275,%rax
ffff80000010c8af:	80 ff ff 
ffff80000010c8b2:	ff d0                	call   *%rax
      *pte = 0;
ffff80000010c8b4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c8b8:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  for(; a  < oldsz; a += PGSIZE){
ffff80000010c8bf:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffff80000010c8c6:	00 
ffff80000010c8c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c8cb:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
ffff80000010c8cf:	0f 82 4d ff ff ff    	jb     ffff80000010c822 <deallocuvm+0x44>
    }
  }
  return newsz;
ffff80000010c8d5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
}
ffff80000010c8d9:	c9                   	leave
ffff80000010c8da:	c3                   	ret

ffff80000010c8db <freevm>:

// Free all the pages mapped by, and all the memory used for,
// this page table
void
freevm(pml4e_t *pml4)
{
ffff80000010c8db:	f3 0f 1e fa          	endbr64
ffff80000010c8df:	55                   	push   %rbp
ffff80000010c8e0:	48 89 e5             	mov    %rsp,%rbp
ffff80000010c8e3:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010c8e7:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  uint i, j, k, l;
  pde_t *pdp, *pd, *pt;

  if(pml4 == 0)
ffff80000010c8eb:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
ffff80000010c8f0:	75 19                	jne    ffff80000010c90b <freevm+0x30>
    panic("freevm: no pgdir");
ffff80000010c8f2:	48 b8 a7 d6 10 00 00 	movabs $0xffff80000010d6a7,%rax
ffff80000010c8f9:	80 ff ff 
ffff80000010c8fc:	48 89 c7             	mov    %rax,%rdi
ffff80000010c8ff:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010c906:	80 ff ff 
ffff80000010c909:	ff d0                	call   *%rax

  // then need to loop through pml4 entry
  for(i = 0; i < (NPDENTRIES/2); i++){
ffff80000010c90b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010c912:	e9 dc 01 00 00       	jmp    ffff80000010caf3 <freevm+0x218>
    if(pml4[i] & PTE_P){
ffff80000010c917:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010c91a:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010c921:	00 
ffff80000010c922:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010c926:	48 01 d0             	add    %rdx,%rax
ffff80000010c929:	48 8b 00             	mov    (%rax),%rax
ffff80000010c92c:	83 e0 01             	and    $0x1,%eax
ffff80000010c92f:	48 85 c0             	test   %rax,%rax
ffff80000010c932:	0f 84 b7 01 00 00    	je     ffff80000010caef <freevm+0x214>
      pdp = (pdpe_t*)P2V(PTE_ADDR(pml4[i]));
ffff80000010c938:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010c93b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010c942:	00 
ffff80000010c943:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010c947:	48 01 d0             	add    %rdx,%rax
ffff80000010c94a:	48 8b 00             	mov    (%rax),%rax
ffff80000010c94d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010c953:	48 89 c2             	mov    %rax,%rdx
ffff80000010c956:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010c95d:	80 ff ff 
ffff80000010c960:	48 01 d0             	add    %rdx,%rax
ffff80000010c963:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

      // and every entry in the corresponding pdpt
      for(j = 0; j < NPDENTRIES; j++){
ffff80000010c967:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
ffff80000010c96e:	e9 5c 01 00 00       	jmp    ffff80000010cacf <freevm+0x1f4>
        if(pdp[j] & PTE_P){
ffff80000010c973:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff80000010c976:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010c97d:	00 
ffff80000010c97e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c982:	48 01 d0             	add    %rdx,%rax
ffff80000010c985:	48 8b 00             	mov    (%rax),%rax
ffff80000010c988:	83 e0 01             	and    $0x1,%eax
ffff80000010c98b:	48 85 c0             	test   %rax,%rax
ffff80000010c98e:	0f 84 37 01 00 00    	je     ffff80000010cacb <freevm+0x1f0>
          pd = (pde_t*)P2V(PTE_ADDR(pdp[j]));
ffff80000010c994:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff80000010c997:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010c99e:	00 
ffff80000010c99f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c9a3:	48 01 d0             	add    %rdx,%rax
ffff80000010c9a6:	48 8b 00             	mov    (%rax),%rax
ffff80000010c9a9:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010c9af:	48 89 c2             	mov    %rax,%rdx
ffff80000010c9b2:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010c9b9:	80 ff ff 
ffff80000010c9bc:	48 01 d0             	add    %rdx,%rax
ffff80000010c9bf:	48 89 45 e0          	mov    %rax,-0x20(%rbp)

          // and every entry in the corresponding page directory
          for(k = 0; k < (NPDENTRIES); k++){
ffff80000010c9c3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
ffff80000010c9ca:	e9 dc 00 00 00       	jmp    ffff80000010caab <freevm+0x1d0>
            if(pd[k] & PTE_P) {
ffff80000010c9cf:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff80000010c9d2:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010c9d9:	00 
ffff80000010c9da:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010c9de:	48 01 d0             	add    %rdx,%rax
ffff80000010c9e1:	48 8b 00             	mov    (%rax),%rax
ffff80000010c9e4:	83 e0 01             	and    $0x1,%eax
ffff80000010c9e7:	48 85 c0             	test   %rax,%rax
ffff80000010c9ea:	0f 84 b7 00 00 00    	je     ffff80000010caa7 <freevm+0x1cc>
              pt = (pde_t*)P2V(PTE_ADDR(pd[k]));
ffff80000010c9f0:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff80000010c9f3:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010c9fa:	00 
ffff80000010c9fb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010c9ff:	48 01 d0             	add    %rdx,%rax
ffff80000010ca02:	48 8b 00             	mov    (%rax),%rax
ffff80000010ca05:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010ca0b:	48 89 c2             	mov    %rax,%rdx
ffff80000010ca0e:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010ca15:	80 ff ff 
ffff80000010ca18:	48 01 d0             	add    %rdx,%rax
ffff80000010ca1b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

              // and every entry in the corresponding page table
              for(l = 0; l < (NPDENTRIES); l++){
ffff80000010ca1f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
ffff80000010ca26:	eb 63                	jmp    ffff80000010ca8b <freevm+0x1b0>
                if(pt[l] & PTE_P) {
ffff80000010ca28:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff80000010ca2b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010ca32:	00 
ffff80000010ca33:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010ca37:	48 01 d0             	add    %rdx,%rax
ffff80000010ca3a:	48 8b 00             	mov    (%rax),%rax
ffff80000010ca3d:	83 e0 01             	and    $0x1,%eax
ffff80000010ca40:	48 85 c0             	test   %rax,%rax
ffff80000010ca43:	74 42                	je     ffff80000010ca87 <freevm+0x1ac>
                  char * v = P2V(PTE_ADDR(pt[l]));
ffff80000010ca45:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff80000010ca48:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010ca4f:	00 
ffff80000010ca50:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010ca54:	48 01 d0             	add    %rdx,%rax
ffff80000010ca57:	48 8b 00             	mov    (%rax),%rax
ffff80000010ca5a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010ca60:	48 89 c2             	mov    %rax,%rdx
ffff80000010ca63:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010ca6a:	80 ff ff 
ffff80000010ca6d:	48 01 d0             	add    %rdx,%rax
ffff80000010ca70:	48 89 45 d0          	mov    %rax,-0x30(%rbp)

                  kfree((char*)v);
ffff80000010ca74:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010ca78:	48 89 c7             	mov    %rax,%rdi
ffff80000010ca7b:	48 b8 75 42 10 00 00 	movabs $0xffff800000104275,%rax
ffff80000010ca82:	80 ff ff 
ffff80000010ca85:	ff d0                	call   *%rax
              for(l = 0; l < (NPDENTRIES); l++){
ffff80000010ca87:	83 45 f0 01          	addl   $0x1,-0x10(%rbp)
ffff80000010ca8b:	81 7d f0 ff 01 00 00 	cmpl   $0x1ff,-0x10(%rbp)
ffff80000010ca92:	76 94                	jbe    ffff80000010ca28 <freevm+0x14d>
                }
              }
              //freeing every page table
              kfree((char*)pt);
ffff80000010ca94:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010ca98:	48 89 c7             	mov    %rax,%rdi
ffff80000010ca9b:	48 b8 75 42 10 00 00 	movabs $0xffff800000104275,%rax
ffff80000010caa2:	80 ff ff 
ffff80000010caa5:	ff d0                	call   *%rax
          for(k = 0; k < (NPDENTRIES); k++){
ffff80000010caa7:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
ffff80000010caab:	81 7d f4 ff 01 00 00 	cmpl   $0x1ff,-0xc(%rbp)
ffff80000010cab2:	0f 86 17 ff ff ff    	jbe    ffff80000010c9cf <freevm+0xf4>
            }
          }
          // freeing every page directory
          kfree((char*)pd);
ffff80000010cab8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010cabc:	48 89 c7             	mov    %rax,%rdi
ffff80000010cabf:	48 b8 75 42 10 00 00 	movabs $0xffff800000104275,%rax
ffff80000010cac6:	80 ff ff 
ffff80000010cac9:	ff d0                	call   *%rax
      for(j = 0; j < NPDENTRIES; j++){
ffff80000010cacb:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
ffff80000010cacf:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
ffff80000010cad6:	0f 86 97 fe ff ff    	jbe    ffff80000010c973 <freevm+0x98>
        }
      }
      // freeing every page directory pointer table
      kfree((char*)pdp);
ffff80000010cadc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010cae0:	48 89 c7             	mov    %rax,%rdi
ffff80000010cae3:	48 b8 75 42 10 00 00 	movabs $0xffff800000104275,%rax
ffff80000010caea:	80 ff ff 
ffff80000010caed:	ff d0                	call   *%rax
  for(i = 0; i < (NPDENTRIES/2); i++){
ffff80000010caef:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff80000010caf3:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
ffff80000010cafa:	0f 86 17 fe ff ff    	jbe    ffff80000010c917 <freevm+0x3c>
    }
  }
  // freeing the pml4
  kfree((char*)pml4);
ffff80000010cb00:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010cb04:	48 89 c7             	mov    %rax,%rdi
ffff80000010cb07:	48 b8 75 42 10 00 00 	movabs $0xffff800000104275,%rax
ffff80000010cb0e:	80 ff ff 
ffff80000010cb11:	ff d0                	call   *%rax
}
ffff80000010cb13:	90                   	nop
ffff80000010cb14:	c9                   	leave
ffff80000010cb15:	c3                   	ret

ffff80000010cb16 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pml4e_t *pgdir, char *uva)
{
ffff80000010cb16:	f3 0f 1e fa          	endbr64
ffff80000010cb1a:	55                   	push   %rbp
ffff80000010cb1b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010cb1e:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010cb22:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010cb26:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
ffff80000010cb2a:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff80000010cb2e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010cb32:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010cb37:	48 89 ce             	mov    %rcx,%rsi
ffff80000010cb3a:	48 89 c7             	mov    %rax,%rdi
ffff80000010cb3d:	48 b8 48 c1 10 00 00 	movabs $0xffff80000010c148,%rax
ffff80000010cb44:	80 ff ff 
ffff80000010cb47:	ff d0                	call   *%rax
ffff80000010cb49:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(pte == 0)
ffff80000010cb4d:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff80000010cb52:	75 19                	jne    ffff80000010cb6d <clearpteu+0x57>
    panic("clearpteu");
ffff80000010cb54:	48 b8 b8 d6 10 00 00 	movabs $0xffff80000010d6b8,%rax
ffff80000010cb5b:	80 ff ff 
ffff80000010cb5e:	48 89 c7             	mov    %rax,%rdi
ffff80000010cb61:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010cb68:	80 ff ff 
ffff80000010cb6b:	ff d0                	call   *%rax
  *pte &= ~PTE_U;
ffff80000010cb6d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010cb71:	48 8b 00             	mov    (%rax),%rax
ffff80000010cb74:	48 83 e0 fb          	and    $0xfffffffffffffffb,%rax
ffff80000010cb78:	48 89 c2             	mov    %rax,%rdx
ffff80000010cb7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010cb7f:	48 89 10             	mov    %rdx,(%rax)
}
ffff80000010cb82:	90                   	nop
ffff80000010cb83:	c9                   	leave
ffff80000010cb84:	c3                   	ret

ffff80000010cb85 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pml4e_t *pgdir, uint sz)
{
ffff80000010cb85:	f3 0f 1e fa          	endbr64
ffff80000010cb89:	55                   	push   %rbp
ffff80000010cb8a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010cb8d:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010cb91:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
ffff80000010cb95:	89 75 c4             	mov    %esi,-0x3c(%rbp)
  pde_t *d;
  pte_t *pte;
  addr_t pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
ffff80000010cb98:	48 b8 1f bf 10 00 00 	movabs $0xffff80000010bf1f,%rax
ffff80000010cb9f:	80 ff ff 
ffff80000010cba2:	ff d0                	call   *%rax
ffff80000010cba4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010cba8:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010cbad:	75 0a                	jne    ffff80000010cbb9 <copyuvm+0x34>
    return 0;
ffff80000010cbaf:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010cbb4:	e9 57 01 00 00       	jmp    ffff80000010cd10 <copyuvm+0x18b>
  for(i = PGSIZE; i < sz; i += PGSIZE){
ffff80000010cbb9:	48 c7 45 f8 00 10 00 	movq   $0x1000,-0x8(%rbp)
ffff80000010cbc0:	00 
ffff80000010cbc1:	e9 1b 01 00 00       	jmp    ffff80000010cce1 <copyuvm+0x15c>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
ffff80000010cbc6:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff80000010cbca:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010cbce:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010cbd3:	48 89 ce             	mov    %rcx,%rsi
ffff80000010cbd6:	48 89 c7             	mov    %rax,%rdi
ffff80000010cbd9:	48 b8 48 c1 10 00 00 	movabs $0xffff80000010c148,%rax
ffff80000010cbe0:	80 ff ff 
ffff80000010cbe3:	ff d0                	call   *%rax
ffff80000010cbe5:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010cbe9:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010cbee:	75 19                	jne    ffff80000010cc09 <copyuvm+0x84>
      panic("copyuvm: pte should exist");
ffff80000010cbf0:	48 b8 c2 d6 10 00 00 	movabs $0xffff80000010d6c2,%rax
ffff80000010cbf7:	80 ff ff 
ffff80000010cbfa:	48 89 c7             	mov    %rax,%rdi
ffff80000010cbfd:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010cc04:	80 ff ff 
ffff80000010cc07:	ff d0                	call   *%rax
    if(!(*pte & PTE_P))
ffff80000010cc09:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010cc0d:	48 8b 00             	mov    (%rax),%rax
ffff80000010cc10:	83 e0 01             	and    $0x1,%eax
ffff80000010cc13:	48 85 c0             	test   %rax,%rax
ffff80000010cc16:	75 19                	jne    ffff80000010cc31 <copyuvm+0xac>
      panic("copyuvm: page not present");
ffff80000010cc18:	48 b8 dc d6 10 00 00 	movabs $0xffff80000010d6dc,%rax
ffff80000010cc1f:	80 ff ff 
ffff80000010cc22:	48 89 c7             	mov    %rax,%rdi
ffff80000010cc25:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010cc2c:	80 ff ff 
ffff80000010cc2f:	ff d0                	call   *%rax
    pa = PTE_ADDR(*pte);
ffff80000010cc31:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010cc35:	48 8b 00             	mov    (%rax),%rax
ffff80000010cc38:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010cc3e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    flags = PTE_FLAGS(*pte);
ffff80000010cc42:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010cc46:	48 8b 00             	mov    (%rax),%rax
ffff80000010cc49:	25 ff 0f 00 00       	and    $0xfff,%eax
ffff80000010cc4e:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    if((mem = kalloc()) == 0)
ffff80000010cc52:	48 b8 78 43 10 00 00 	movabs $0xffff800000104378,%rax
ffff80000010cc59:	80 ff ff 
ffff80000010cc5c:	ff d0                	call   *%rax
ffff80000010cc5e:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
ffff80000010cc62:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
ffff80000010cc67:	0f 84 87 00 00 00    	je     ffff80000010ccf4 <copyuvm+0x16f>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
ffff80000010cc6d:	48 ba 00 00 00 00 00 	movabs $0xffff800000000000,%rdx
ffff80000010cc74:	80 ff ff 
ffff80000010cc77:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010cc7b:	48 01 d0             	add    %rdx,%rax
ffff80000010cc7e:	48 89 c1             	mov    %rax,%rcx
ffff80000010cc81:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010cc85:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010cc8a:	48 89 ce             	mov    %rcx,%rsi
ffff80000010cc8d:	48 89 c7             	mov    %rax,%rdi
ffff80000010cc90:	48 b8 4d 83 10 00 00 	movabs $0xffff80000010834d,%rax
ffff80000010cc97:	80 ff ff 
ffff80000010cc9a:	ff d0                	call   *%rax
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
ffff80000010cc9c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010cca0:	89 c1                	mov    %eax,%ecx
ffff80000010cca2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010cca6:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010ccad:	80 00 00 
ffff80000010ccb0:	48 01 c2             	add    %rax,%rdx
ffff80000010ccb3:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
ffff80000010ccb7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010ccbb:	41 89 c8             	mov    %ecx,%r8d
ffff80000010ccbe:	48 89 d1             	mov    %rdx,%rcx
ffff80000010ccc1:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010ccc6:	48 89 c7             	mov    %rax,%rdi
ffff80000010ccc9:	48 b8 cf c3 10 00 00 	movabs $0xffff80000010c3cf,%rax
ffff80000010ccd0:	80 ff ff 
ffff80000010ccd3:	ff d0                	call   *%rax
ffff80000010ccd5:	85 c0                	test   %eax,%eax
ffff80000010ccd7:	78 1e                	js     ffff80000010ccf7 <copyuvm+0x172>
  for(i = PGSIZE; i < sz; i += PGSIZE){
ffff80000010ccd9:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffff80000010cce0:	00 
ffff80000010cce1:	8b 45 c4             	mov    -0x3c(%rbp),%eax
ffff80000010cce4:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff80000010cce8:	0f 82 d8 fe ff ff    	jb     ffff80000010cbc6 <copyuvm+0x41>
      goto bad;
  }
  return d;
ffff80000010ccee:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010ccf2:	eb 1c                	jmp    ffff80000010cd10 <copyuvm+0x18b>
      goto bad;
ffff80000010ccf4:	90                   	nop
ffff80000010ccf5:	eb 01                	jmp    ffff80000010ccf8 <copyuvm+0x173>
      goto bad;
ffff80000010ccf7:	90                   	nop

bad:
  freevm(d);
ffff80000010ccf8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010ccfc:	48 89 c7             	mov    %rax,%rdi
ffff80000010ccff:	48 b8 db c8 10 00 00 	movabs $0xffff80000010c8db,%rax
ffff80000010cd06:	80 ff ff 
ffff80000010cd09:	ff d0                	call   *%rax
  return 0;
ffff80000010cd0b:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010cd10:	c9                   	leave
ffff80000010cd11:	c3                   	ret

ffff80000010cd12 <uva2ka>:

// Map user virtual address to kernel address.
char*
uva2ka(pml4e_t *pgdir, char *uva)
{
ffff80000010cd12:	f3 0f 1e fa          	endbr64
ffff80000010cd16:	55                   	push   %rbp
ffff80000010cd17:	48 89 e5             	mov    %rsp,%rbp
ffff80000010cd1a:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010cd1e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010cd22:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
ffff80000010cd26:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff80000010cd2a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010cd2e:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010cd33:	48 89 ce             	mov    %rcx,%rsi
ffff80000010cd36:	48 89 c7             	mov    %rax,%rdi
ffff80000010cd39:	48 b8 48 c1 10 00 00 	movabs $0xffff80000010c148,%rax
ffff80000010cd40:	80 ff ff 
ffff80000010cd43:	ff d0                	call   *%rax
ffff80000010cd45:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if((*pte & PTE_P) == 0)
ffff80000010cd49:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010cd4d:	48 8b 00             	mov    (%rax),%rax
ffff80000010cd50:	83 e0 01             	and    $0x1,%eax
ffff80000010cd53:	48 85 c0             	test   %rax,%rax
ffff80000010cd56:	75 07                	jne    ffff80000010cd5f <uva2ka+0x4d>
    return 0;
ffff80000010cd58:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010cd5d:	eb 33                	jmp    ffff80000010cd92 <uva2ka+0x80>
  if((*pte & PTE_U) == 0)
ffff80000010cd5f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010cd63:	48 8b 00             	mov    (%rax),%rax
ffff80000010cd66:	83 e0 04             	and    $0x4,%eax
ffff80000010cd69:	48 85 c0             	test   %rax,%rax
ffff80000010cd6c:	75 07                	jne    ffff80000010cd75 <uva2ka+0x63>
    return 0;
ffff80000010cd6e:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010cd73:	eb 1d                	jmp    ffff80000010cd92 <uva2ka+0x80>
  return (char*)P2V(PTE_ADDR(*pte));
ffff80000010cd75:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010cd79:	48 8b 00             	mov    (%rax),%rax
ffff80000010cd7c:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010cd82:	48 89 c2             	mov    %rax,%rdx
ffff80000010cd85:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010cd8c:	80 ff ff 
ffff80000010cd8f:	48 01 d0             	add    %rdx,%rax
}
ffff80000010cd92:	c9                   	leave
ffff80000010cd93:	c3                   	ret

ffff80000010cd94 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pml4e_t *pgdir, addr_t va, void *p, uint64 len)
{
ffff80000010cd94:	f3 0f 1e fa          	endbr64
ffff80000010cd98:	55                   	push   %rbp
ffff80000010cd99:	48 89 e5             	mov    %rsp,%rbp
ffff80000010cd9c:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010cda0:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010cda4:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010cda8:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
ffff80000010cdac:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
  char *buf, *pa0;
  addr_t n, va0;

  buf = (char*)p;
ffff80000010cdb0:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010cdb4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while(len > 0){
ffff80000010cdb8:	e9 b0 00 00 00       	jmp    ffff80000010ce6d <copyout+0xd9>
    va0 = PGROUNDDOWN(va);
ffff80000010cdbd:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010cdc1:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010cdc7:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    pa0 = uva2ka(pgdir, (char*)va0);
ffff80000010cdcb:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff80000010cdcf:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010cdd3:	48 89 d6             	mov    %rdx,%rsi
ffff80000010cdd6:	48 89 c7             	mov    %rax,%rdi
ffff80000010cdd9:	48 b8 12 cd 10 00 00 	movabs $0xffff80000010cd12,%rax
ffff80000010cde0:	80 ff ff 
ffff80000010cde3:	ff d0                	call   *%rax
ffff80000010cde5:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    if(pa0 == 0)
ffff80000010cde9:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
ffff80000010cdee:	75 0a                	jne    ffff80000010cdfa <copyout+0x66>
      return -1;
ffff80000010cdf0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010cdf5:	e9 83 00 00 00       	jmp    ffff80000010ce7d <copyout+0xe9>
    n = PGSIZE - (va - va0);
ffff80000010cdfa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010cdfe:	48 2b 45 d0          	sub    -0x30(%rbp),%rax
ffff80000010ce02:	48 05 00 10 00 00    	add    $0x1000,%rax
ffff80000010ce08:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if(n > len)
ffff80000010ce0c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010ce10:	48 39 45 c0          	cmp    %rax,-0x40(%rbp)
ffff80000010ce14:	73 08                	jae    ffff80000010ce1e <copyout+0x8a>
      n = len;
ffff80000010ce16:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010ce1a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    memmove(pa0 + (va - va0), buf, n);
ffff80000010ce1e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010ce22:	89 c6                	mov    %eax,%esi
ffff80000010ce24:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010ce28:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
ffff80000010ce2c:	48 89 c2             	mov    %rax,%rdx
ffff80000010ce2f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010ce33:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffff80000010ce37:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010ce3b:	89 f2                	mov    %esi,%edx
ffff80000010ce3d:	48 89 c6             	mov    %rax,%rsi
ffff80000010ce40:	48 89 cf             	mov    %rcx,%rdi
ffff80000010ce43:	48 b8 4d 83 10 00 00 	movabs $0xffff80000010834d,%rax
ffff80000010ce4a:	80 ff ff 
ffff80000010ce4d:	ff d0                	call   *%rax
    len -= n;
ffff80000010ce4f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010ce53:	48 29 45 c0          	sub    %rax,-0x40(%rbp)
    buf += n;
ffff80000010ce57:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010ce5b:	48 01 45 f8          	add    %rax,-0x8(%rbp)
    va = va0 + PGSIZE;
ffff80000010ce5f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010ce63:	48 05 00 10 00 00    	add    $0x1000,%rax
ffff80000010ce69:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  while(len > 0){
ffff80000010ce6d:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
ffff80000010ce72:	0f 85 45 ff ff ff    	jne    ffff80000010cdbd <copyout+0x29>
  }
  return 0;
ffff80000010ce78:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010ce7d:	c9                   	leave
ffff80000010ce7e:	c3                   	ret

ffff80000010ce7f <copyin>:


int
copyin(pml4e_t *pgdir, void *dst, addr_t srcva, uint64 len)
{
ffff80000010ce7f:	f3 0f 1e fa          	endbr64
ffff80000010ce83:	55                   	push   %rbp
ffff80000010ce84:	48 89 e5             	mov    %rsp,%rbp
ffff80000010ce87:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010ce8b:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010ce8f:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010ce93:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
ffff80000010ce97:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    // buffer validation/copying subtly wrong even if current tests use low
    // addresses.
    char *pa0;
    addr_t n, va0;

    while(len > 0){
ffff80000010ce9b:	e9 a8 00 00 00       	jmp    ffff80000010cf48 <copyin+0xc9>
        // Round down to the start of the page containing srcva
        va0 = (uint)PGROUNDDOWN(srcva);
ffff80000010cea0:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010cea4:	89 c0                	mov    %eax,%eax
ffff80000010cea6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
ffff80000010ceab:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

        // Translate that user page to a kernel-accessible address
        pa0 = uva2ka(pgdir, (char*)va0);
ffff80000010ceaf:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff80000010ceb3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010ceb7:	48 89 d6             	mov    %rdx,%rsi
ffff80000010ceba:	48 89 c7             	mov    %rax,%rdi
ffff80000010cebd:	48 b8 12 cd 10 00 00 	movabs $0xffff80000010cd12,%rax
ffff80000010cec4:	80 ff ff 
ffff80000010cec7:	ff d0                	call   *%rax
ffff80000010cec9:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        if(pa0 == 0)
ffff80000010cecd:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010ced2:	75 07                	jne    ffff80000010cedb <copyin+0x5c>
            return -1;   // page doesn't exist or not user-accessible
ffff80000010ced4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010ced9:	eb 7d                	jmp    ffff80000010cf58 <copyin+0xd9>

        // How many bytes can we copy from this page without crossing into the next?
        n = PGSIZE - (srcva - va0);
ffff80000010cedb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010cedf:	48 2b 45 c8          	sub    -0x38(%rbp),%rax
ffff80000010cee3:	48 05 00 10 00 00    	add    $0x1000,%rax
ffff80000010cee9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        if(n > len)
ffff80000010ceed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010cef1:	48 39 45 c0          	cmp    %rax,-0x40(%rbp)
ffff80000010cef5:	73 08                	jae    ffff80000010ceff <copyin+0x80>
            n = len;
ffff80000010cef7:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010cefb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

        // pa0 is the start of the page; offset into it by (srcva - va0)
        memmove(dst, pa0 + (srcva - va0), n);
ffff80000010ceff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010cf03:	89 c6                	mov    %eax,%esi
ffff80000010cf05:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010cf09:	48 2b 45 f0          	sub    -0x10(%rbp),%rax
ffff80000010cf0d:	48 89 c2             	mov    %rax,%rdx
ffff80000010cf10:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010cf14:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffff80000010cf18:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010cf1c:	89 f2                	mov    %esi,%edx
ffff80000010cf1e:	48 89 ce             	mov    %rcx,%rsi
ffff80000010cf21:	48 89 c7             	mov    %rax,%rdi
ffff80000010cf24:	48 b8 4d 83 10 00 00 	movabs $0xffff80000010834d,%rax
ffff80000010cf2b:	80 ff ff 
ffff80000010cf2e:	ff d0                	call   *%rax

        len   -= n;
ffff80000010cf30:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010cf34:	48 29 45 c0          	sub    %rax,-0x40(%rbp)
        dst   += n;
ffff80000010cf38:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010cf3c:	48 01 45 d0          	add    %rax,-0x30(%rbp)
        srcva += n;    // advance to next page if len still > 0
ffff80000010cf40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010cf44:	48 01 45 c8          	add    %rax,-0x38(%rbp)
    while(len > 0){
ffff80000010cf48:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
ffff80000010cf4d:	0f 85 4d ff ff ff    	jne    ffff80000010cea0 <copyin+0x21>
    }
    return 0;
ffff80000010cf53:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010cf58:	c9                   	leave
ffff80000010cf59:	c3                   	ret
