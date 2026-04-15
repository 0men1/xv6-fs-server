
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
ffff800000100019:	f0 11 00             	lock adc %eax,(%rax)
ffff80000010001c:	20 00                	and    %al,(%rax)
ffff80000010001e:	10 00                	adc    %al,(%rax)

ffff800000100020 <mboot_entry>:
ffff800000100020:	31 c0                	xor    %eax,%eax
ffff800000100022:	bf 00 10 00 00       	mov    $0x1000,%edi
ffff800000100027:	b9 00 20 00 00       	mov    $0x2000,%ecx
ffff80000010002c:	f3 aa                	rep stos %al,%es:(%rdi)
ffff80000010002e:	b8 03 20 00 00       	mov    $0x2003,%eax
ffff800000100033:	a3 00 10 00 00 a3 00 	movabs %eax,0x1800a300001000
ffff80000010003a:	18 00 
ffff80000010003c:	00 b8 83 00 00 00    	add    %bh,0x83(%rax)
ffff800000100042:	a3                   	.byte 0xa3
ffff800000100043:	00 20                	add    %ah,(%rax)
ffff800000100045:	00 00                	add    %al,(%rax)
ffff800000100047:	31 db                	xor    %ebx,%ebx

ffff800000100049 <entry32mp>:
ffff800000100049:	b8 00 10 00 00       	mov    $0x1000,%eax
ffff80000010004e:	0f 22 d8             	mov    %rax,%cr3
ffff800000100051:	0f 01 15 90 00 10 00 	lgdt   0x100090(%rip)        # ffff8000002000e8 <end+0xe10e8>
ffff800000100058:	0f 20 e0             	mov    %cr4,%rax
ffff80000010005b:	0f ba e8 05          	bts    $0x5,%eax
ffff80000010005f:	0f 22 e0             	mov    %rax,%cr4
ffff800000100062:	b9 80 00 00 c0       	mov    $0xc0000080,%ecx
ffff800000100067:	0f 32                	rdmsr
ffff800000100069:	0f ba e8 00          	bts    $0x0,%eax
ffff80000010006d:	0f ba e8 08          	bts    $0x8,%eax
ffff800000100071:	0f 30                	wrmsr
ffff800000100073:	0f 20 c0             	mov    %cr0,%rax
ffff800000100076:	0d 02 00 01 80       	or     $0x80010002,%eax
ffff80000010007b:	0f 22 c0             	mov    %rax,%cr0
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
ffff8000001000c0:	48 b8 cc 00 10 00 00 	movabs $0xffff8000001000cc,%rax
ffff8000001000c7:	80 ff ff 
ffff8000001000ca:	ff e0                	jmp    *%rax

ffff8000001000cc <_start>:
ffff8000001000cc:	48 31 c0             	xor    %rax,%rax
ffff8000001000cf:	8e d0                	mov    %eax,%ss
ffff8000001000d1:	8e d8                	mov    %eax,%ds
ffff8000001000d3:	8e c0                	mov    %eax,%es
ffff8000001000d5:	8e e0                	mov    %eax,%fs
ffff8000001000d7:	8e e8                	mov    %eax,%gs
ffff8000001000d9:	85 db                	test   %ebx,%ebx
ffff8000001000db:	75 14                	jne    ffff8000001000f1 <entry64mp>
ffff8000001000dd:	48 b8 00 00 01 00 00 	movabs $0xffff800000010000,%rax
ffff8000001000e4:	80 ff ff 
ffff8000001000e7:	48 89 c4             	mov    %rax,%rsp
ffff8000001000ea:	e9 cf 54 00 00       	jmp    ffff8000001055be <main>

ffff8000001000ef <__deadloop>:
ffff8000001000ef:	eb fe                	jmp    ffff8000001000ef <__deadloop>

ffff8000001000f1 <entry64mp>:
ffff8000001000f1:	48 c7 c0 00 70 00 00 	mov    $0x7000,%rax
ffff8000001000f8:	48 8b 60 f0          	mov    -0x10(%rax),%rsp
ffff8000001000fc:	e9 e8 55 00 00       	jmp    ffff8000001056e9 <mpenter>

ffff800000100101 <wrmsr>:
ffff800000100101:	48 89 f9             	mov    %rdi,%rcx
ffff800000100104:	48 89 f0             	mov    %rsi,%rax
ffff800000100107:	48 c1 ee 20          	shr    $0x20,%rsi
ffff80000010010b:	48 89 f2             	mov    %rsi,%rdx
ffff80000010010e:	0f 30                	wrmsr
ffff800000100110:	c3                   	ret

ffff800000100111 <ignore_sysret>:
ffff800000100111:	48 c7 c0 da ff ff ff 	mov    $0xffffffffffffffda,%rax
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
ffff800000100127:	48 b8 50 c4 10 00 00 	movabs $0xffff80000010c450,%rax
ffff80000010012e:	80 ff ff 
ffff800000100131:	48 89 c6             	mov    %rax,%rsi
ffff800000100134:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff80000010013b:	80 ff ff 
ffff80000010013e:	48 89 c7             	mov    %rax,%rdi
ffff800000100141:	48 b8 96 79 10 00 00 	movabs $0xffff800000107996,%rax
ffff800000100148:	80 ff ff 
ffff80000010014b:	ff d0                	call   *%rax
//PAGEBREAK!

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
ffff80000010014d:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff800000100154:	80 ff ff 
ffff800000100157:	48 b9 08 31 11 00 00 	movabs $0xffff800000113108,%rcx
ffff80000010015e:	80 ff ff 
ffff800000100161:	48 89 88 a0 51 00 00 	mov    %rcx,0x51a0(%rax)
  bcache.head.next = &bcache.head;
ffff800000100168:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff80000010016f:	80 ff ff 
ffff800000100172:	48 89 88 a8 51 00 00 	mov    %rcx,0x51a8(%rax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
ffff800000100179:	48 b8 68 e0 10 00 00 	movabs $0xffff80000010e068,%rax
ffff800000100180:	80 ff ff 
ffff800000100183:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000100187:	e9 8e 00 00 00       	jmp    ffff80000010021a <binit+0xff>
    b->next = bcache.head.next;
ffff80000010018c:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff800000100193:	80 ff ff 
ffff800000100196:	48 8b 90 a8 51 00 00 	mov    0x51a8(%rax),%rdx
ffff80000010019d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001001a1:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    b->prev = &bcache.head;
ffff8000001001a8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001001ac:	48 be 08 31 11 00 00 	movabs $0xffff800000113108,%rsi
ffff8000001001b3:	80 ff ff 
ffff8000001001b6:	48 89 b0 98 00 00 00 	mov    %rsi,0x98(%rax)
    initsleeplock(&b->lock, "buffer");
ffff8000001001bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001001c1:	48 83 c0 10          	add    $0x10,%rax
ffff8000001001c5:	48 ba 57 c4 10 00 00 	movabs $0xffff80000010c457,%rdx
ffff8000001001cc:	80 ff ff 
ffff8000001001cf:	48 89 d6             	mov    %rdx,%rsi
ffff8000001001d2:	48 89 c7             	mov    %rax,%rdi
ffff8000001001d5:	48 b8 a0 77 10 00 00 	movabs $0xffff8000001077a0,%rax
ffff8000001001dc:	80 ff ff 
ffff8000001001df:	ff d0                	call   *%rax
    bcache.head.next->prev = b;
ffff8000001001e1:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff8000001001e8:	80 ff ff 
ffff8000001001eb:	48 8b 80 a8 51 00 00 	mov    0x51a8(%rax),%rax
ffff8000001001f2:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001001f6:	48 89 90 98 00 00 00 	mov    %rdx,0x98(%rax)
    bcache.head.next = b;
ffff8000001001fd:	48 ba 00 e0 10 00 00 	movabs $0xffff80000010e000,%rdx
ffff800000100204:	80 ff ff 
ffff800000100207:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010020b:	48 89 82 a8 51 00 00 	mov    %rax,0x51a8(%rdx)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
ffff800000100212:	48 81 45 f8 b0 02 00 	addq   $0x2b0,-0x8(%rbp)
ffff800000100219:	00 
ffff80000010021a:	48 b8 08 31 11 00 00 	movabs $0xffff800000113108,%rax
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
ffff800000100244:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff80000010024b:	80 ff ff 
ffff80000010024e:	48 89 c7             	mov    %rax,%rdi
ffff800000100251:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff800000100258:	80 ff ff 
ffff80000010025b:	ff d0                	call   *%rax

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
ffff80000010025d:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
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
ffff8000001002a3:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff8000001002aa:	80 ff ff 
ffff8000001002ad:	48 89 c7             	mov    %rax,%rdi
ffff8000001002b0:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff8000001002b7:	80 ff ff 
ffff8000001002ba:	ff d0                	call   *%rax
      acquiresleep(&b->lock);
ffff8000001002bc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001002c0:	48 83 c0 10          	add    $0x10,%rax
ffff8000001002c4:	48 89 c7             	mov    %rax,%rdi
ffff8000001002c7:	48 b8 fc 77 10 00 00 	movabs $0xffff8000001077fc,%rax
ffff8000001002ce:	80 ff ff 
ffff8000001002d1:	ff d0                	call   *%rax
      return b;
ffff8000001002d3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001002d7:	e9 f6 00 00 00       	jmp    ffff8000001003d2 <bget+0x1a0>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
ffff8000001002dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001002e0:	48 8b 80 a0 00 00 00 	mov    0xa0(%rax),%rax
ffff8000001002e7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001002eb:	48 b8 08 31 11 00 00 	movabs $0xffff800000113108,%rax
ffff8000001002f2:	80 ff ff 
ffff8000001002f5:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff8000001002f9:	0f 85 75 ff ff ff    	jne    ffff800000100274 <bget+0x42>
  }

  // Not cached; recycle some unused buffer and clean buffer
  // "clean" because B_DIRTY and not locked means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
ffff8000001002ff:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
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
ffff800000100360:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff800000100367:	80 ff ff 
ffff80000010036a:	48 89 c7             	mov    %rax,%rdi
ffff80000010036d:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff800000100374:	80 ff ff 
ffff800000100377:	ff d0                	call   *%rax
      acquiresleep(&b->lock);
ffff800000100379:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010037d:	48 83 c0 10          	add    $0x10,%rax
ffff800000100381:	48 89 c7             	mov    %rax,%rdi
ffff800000100384:	48 b8 fc 77 10 00 00 	movabs $0xffff8000001077fc,%rax
ffff80000010038b:	80 ff ff 
ffff80000010038e:	ff d0                	call   *%rax
      return b;
ffff800000100390:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100394:	eb 3c                	jmp    ffff8000001003d2 <bget+0x1a0>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
ffff800000100396:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010039a:	48 8b 80 98 00 00 00 	mov    0x98(%rax),%rax
ffff8000001003a1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001003a5:	48 b8 08 31 11 00 00 	movabs $0xffff800000113108,%rax
ffff8000001003ac:	80 ff ff 
ffff8000001003af:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff8000001003b3:	0f 85 60 ff ff ff    	jne    ffff800000100319 <bget+0xe7>
    }
  }
  panic("bget: no buffers");
ffff8000001003b9:	48 b8 5e c4 10 00 00 	movabs $0xffff80000010c45e,%rax
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
ffff800000100414:	48 b8 f3 3d 10 00 00 	movabs $0xffff800000103df3,%rax
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
ffff800000100441:	48 b8 ef 78 10 00 00 	movabs $0xffff8000001078ef,%rax
ffff800000100448:	80 ff ff 
ffff80000010044b:	ff d0                	call   *%rax
ffff80000010044d:	85 c0                	test   %eax,%eax
ffff80000010044f:	75 19                	jne    ffff80000010046a <bwrite+0x44>
    panic("bwrite");
ffff800000100451:	48 b8 6f c4 10 00 00 	movabs $0xffff80000010c46f,%rax
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
ffff800000100482:	48 b8 f3 3d 10 00 00 	movabs $0xffff800000103df3,%rax
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
ffff8000001004ac:	48 b8 ef 78 10 00 00 	movabs $0xffff8000001078ef,%rax
ffff8000001004b3:	80 ff ff 
ffff8000001004b6:	ff d0                	call   *%rax
ffff8000001004b8:	85 c0                	test   %eax,%eax
ffff8000001004ba:	75 19                	jne    ffff8000001004d5 <brelse+0x44>
    panic("brelse");
ffff8000001004bc:	48 b8 76 c4 10 00 00 	movabs $0xffff80000010c476,%rax
ffff8000001004c3:	80 ff ff 
ffff8000001004c6:	48 89 c7             	mov    %rax,%rdi
ffff8000001004c9:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff8000001004d0:	80 ff ff 
ffff8000001004d3:	ff d0                	call   *%rax

  releasesleep(&b->lock);
ffff8000001004d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001004d9:	48 83 c0 10          	add    $0x10,%rax
ffff8000001004dd:	48 89 c7             	mov    %rax,%rdi
ffff8000001004e0:	48 b8 86 78 10 00 00 	movabs $0xffff800000107886,%rax
ffff8000001004e7:	80 ff ff 
ffff8000001004ea:	ff d0                	call   *%rax

  acquire(&bcache.lock);
ffff8000001004ec:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff8000001004f3:	80 ff ff 
ffff8000001004f6:	48 89 c7             	mov    %rax,%rdi
ffff8000001004f9:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
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
ffff800000100568:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff80000010056f:	80 ff ff 
ffff800000100572:	48 8b 90 a8 51 00 00 	mov    0x51a8(%rax),%rdx
ffff800000100579:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010057d:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    b->prev = &bcache.head;
ffff800000100584:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100588:	48 b9 08 31 11 00 00 	movabs $0xffff800000113108,%rcx
ffff80000010058f:	80 ff ff 
ffff800000100592:	48 89 88 98 00 00 00 	mov    %rcx,0x98(%rax)
    bcache.head.next->prev = b;
ffff800000100599:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff8000001005a0:	80 ff ff 
ffff8000001005a3:	48 8b 80 a8 51 00 00 	mov    0x51a8(%rax),%rax
ffff8000001005aa:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001005ae:	48 89 90 98 00 00 00 	mov    %rdx,0x98(%rax)
    bcache.head.next = b;
ffff8000001005b5:	48 ba 00 e0 10 00 00 	movabs $0xffff80000010e000,%rdx
ffff8000001005bc:	80 ff ff 
ffff8000001005bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001005c3:	48 89 82 a8 51 00 00 	mov    %rax,0x51a8(%rdx)
  }

  release(&bcache.lock);
ffff8000001005ca:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff8000001005d1:	80 ff ff 
ffff8000001005d4:	48 89 c7             	mov    %rax,%rdi
ffff8000001005d7:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
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
ffff8000001006bf:	48 ba 00 d0 10 00 00 	movabs $0xffff80000010d000,%rdx
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
ffff800000100713:	48 b8 00 d0 10 00 00 	movabs $0xffff80000010d000,%rax
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
ffff8000001007af:	48 b9 00 d0 10 00 00 	movabs $0xffff80000010d000,%rcx
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
ffff8000001008c2:	48 b8 c0 34 11 00 00 	movabs $0xffff8000001134c0,%rax
ffff8000001008c9:	80 ff ff 
ffff8000001008cc:	8b 40 68             	mov    0x68(%rax),%eax
ffff8000001008cf:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
  if (locking)
ffff8000001008d5:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
ffff8000001008dc:	74 19                	je     ffff8000001008f7 <cprintf+0xbf>
    acquire(&cons.lock);
ffff8000001008de:	48 b8 c0 34 11 00 00 	movabs $0xffff8000001134c0,%rax
ffff8000001008e5:	80 ff ff 
ffff8000001008e8:	48 89 c7             	mov    %rax,%rdi
ffff8000001008eb:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff8000001008f2:	80 ff ff 
ffff8000001008f5:	ff d0                	call   *%rax
  if (fmt == 0)
ffff8000001008f7:	48 83 bd 18 ff ff ff 	cmpq   $0x0,-0xe8(%rbp)
ffff8000001008fe:	00 
ffff8000001008ff:	75 19                	jne    ffff80000010091a <cprintf+0xe2>
    panic("null fmt");
ffff800000100901:	48 b8 7d c4 10 00 00 	movabs $0xffff80000010c47d,%rax
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
ffff800000100b40:	48 b8 86 c4 10 00 00 	movabs $0xffff80000010c486,%rax
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
ffff800000100c06:	48 b8 c0 34 11 00 00 	movabs $0xffff8000001134c0,%rax
ffff800000100c0d:	80 ff ff 
ffff800000100c10:	48 89 c7             	mov    %rax,%rdi
ffff800000100c13:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
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
ffff800000100c3e:	48 b8 c0 34 11 00 00 	movabs $0xffff8000001134c0,%rax
ffff800000100c45:	80 ff ff 
ffff800000100c48:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%rax)
  cprintf("cpu%d: panic: ", cpu->id);
ffff800000100c4f:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000100c56:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000100c5a:	0f b6 00             	movzbl (%rax),%eax
ffff800000100c5d:	0f b6 c0             	movzbl %al,%eax
ffff800000100c60:	89 c6                	mov    %eax,%esi
ffff800000100c62:	48 b8 8d c4 10 00 00 	movabs $0xffff80000010c48d,%rax
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
ffff800000100c98:	48 b8 9c c4 10 00 00 	movabs $0xffff80000010c49c,%rax
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
ffff800000100cc4:	48 b8 ed 7a 10 00 00 	movabs $0xffff800000107aed,%rax
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
ffff800000100ce6:	48 b8 9e c4 10 00 00 	movabs $0xffff80000010c49e,%rax
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
ffff800000100d0e:	48 b8 b8 34 11 00 00 	movabs $0xffff8000001134b8,%rax
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
ffff800000100df5:	48 b8 18 d0 10 00 00 	movabs $0xffff80000010d018,%rax
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
ffff800000100e21:	48 b8 18 d0 10 00 00 	movabs $0xffff80000010d018,%rax
ffff800000100e28:	80 ff ff 
ffff800000100e2b:	48 8b 00             	mov    (%rax),%rax
ffff800000100e2e:	48 8d 88 a0 00 00 00 	lea    0xa0(%rax),%rcx
ffff800000100e35:	48 b8 18 d0 10 00 00 	movabs $0xffff80000010d018,%rax
ffff800000100e3c:	80 ff ff 
ffff800000100e3f:	48 8b 00             	mov    (%rax),%rax
ffff800000100e42:	ba 60 0e 00 00       	mov    $0xe60,%edx
ffff800000100e47:	48 89 ce             	mov    %rcx,%rsi
ffff800000100e4a:	48 89 c7             	mov    %rax,%rdi
ffff800000100e4d:	48 b8 94 7e 10 00 00 	movabs $0xffff800000107e94,%rax
ffff800000100e54:	80 ff ff 
ffff800000100e57:	ff d0                	call   *%rax
    pos -= 80;
ffff800000100e59:	83 6d fc 50          	subl   $0x50,-0x4(%rbp)
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
ffff800000100e5d:	b8 80 07 00 00       	mov    $0x780,%eax
ffff800000100e62:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff800000100e65:	48 98                	cltq
ffff800000100e67:	8d 14 00             	lea    (%rax,%rax,1),%edx
ffff800000100e6a:	48 b8 18 d0 10 00 00 	movabs $0xffff80000010d018,%rax
ffff800000100e71:	80 ff ff 
ffff800000100e74:	48 8b 00             	mov    (%rax),%rax
ffff800000100e77:	8b 4d fc             	mov    -0x4(%rbp),%ecx
ffff800000100e7a:	48 63 c9             	movslq %ecx,%rcx
ffff800000100e7d:	48 01 c9             	add    %rcx,%rcx
ffff800000100e80:	48 01 c8             	add    %rcx,%rax
ffff800000100e83:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000100e88:	48 89 c7             	mov    %rax,%rdi
ffff800000100e8b:	48 b8 87 7d 10 00 00 	movabs $0xffff800000107d87,%rax
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
ffff800000100ef8:	48 b8 18 d0 10 00 00 	movabs $0xffff80000010d018,%rax
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
ffff800000100f28:	48 b8 b8 34 11 00 00 	movabs $0xffff8000001134b8,%rax
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
ffff800000100f60:	48 b8 31 a3 10 00 00 	movabs $0xffff80000010a331,%rax
ffff800000100f67:	80 ff ff 
ffff800000100f6a:	ff d0                	call   *%rax
ffff800000100f6c:	bf 20 00 00 00       	mov    $0x20,%edi
ffff800000100f71:	48 b8 31 a3 10 00 00 	movabs $0xffff80000010a331,%rax
ffff800000100f78:	80 ff ff 
ffff800000100f7b:	ff d0                	call   *%rax
ffff800000100f7d:	bf 08 00 00 00       	mov    $0x8,%edi
ffff800000100f82:	48 b8 31 a3 10 00 00 	movabs $0xffff80000010a331,%rax
ffff800000100f89:	80 ff ff 
ffff800000100f8c:	ff d0                	call   *%rax
ffff800000100f8e:	eb 11                	jmp    ffff800000100fa1 <consputc+0x88>
  } else
    uartputc(c);
ffff800000100f90:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000100f93:	89 c7                	mov    %eax,%edi
ffff800000100f95:	48 b8 31 a3 10 00 00 	movabs $0xffff80000010a331,%rax
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
ffff800000100fc5:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000100fcc:	80 ff ff 
ffff800000100fcf:	48 89 c7             	mov    %rax,%rdi
ffff800000100fd2:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
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
ffff800000101047:	48 b8 37 73 10 00 00 	movabs $0xffff800000107337,%rax
ffff80000010104e:	80 ff ff 
ffff800000101051:	ff d0                	call   *%rax
      break;
ffff800000101053:	e9 fe 01 00 00       	jmp    ffff800000101256 <consoleintr+0x2a1>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
          input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
ffff800000101058:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff80000010105f:	80 ff ff 
ffff800000101062:	8b 80 f0 00 00 00    	mov    0xf0(%rax),%eax
ffff800000101068:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff80000010106b:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000101072:	80 ff ff 
ffff800000101075:	89 90 f0 00 00 00    	mov    %edx,0xf0(%rax)
        consputc(BACKSPACE);
ffff80000010107b:	bf 00 01 00 00       	mov    $0x100,%edi
ffff800000101080:	48 b8 19 0f 10 00 00 	movabs $0xffff800000100f19,%rax
ffff800000101087:	80 ff ff 
ffff80000010108a:	ff d0                	call   *%rax
      while(input.e != input.w &&
ffff80000010108c:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000101093:	80 ff ff 
ffff800000101096:	8b 90 f0 00 00 00    	mov    0xf0(%rax),%edx
ffff80000010109c:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff8000001010a3:	80 ff ff 
ffff8000001010a6:	8b 80 ec 00 00 00    	mov    0xec(%rax),%eax
ffff8000001010ac:	39 c2                	cmp    %eax,%edx
ffff8000001010ae:	0f 84 9b 01 00 00    	je     ffff80000010124f <consoleintr+0x29a>
          input.buf[(input.e-1) % INPUT_BUF] != '\n'){
ffff8000001010b4:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff8000001010bb:	80 ff ff 
ffff8000001010be:	8b 80 f0 00 00 00    	mov    0xf0(%rax),%eax
ffff8000001010c4:	83 e8 01             	sub    $0x1,%eax
ffff8000001010c7:	83 e0 7f             	and    $0x7f,%eax
ffff8000001010ca:	89 c2                	mov    %eax,%edx
ffff8000001010cc:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
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
ffff8000001010ea:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff8000001010f1:	80 ff ff 
ffff8000001010f4:	8b 90 f0 00 00 00    	mov    0xf0(%rax),%edx
ffff8000001010fa:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000101101:	80 ff ff 
ffff800000101104:	8b 80 ec 00 00 00    	mov    0xec(%rax),%eax
ffff80000010110a:	39 c2                	cmp    %eax,%edx
ffff80000010110c:	0f 84 40 01 00 00    	je     ffff800000101252 <consoleintr+0x29d>
        input.e--;
ffff800000101112:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000101119:	80 ff ff 
ffff80000010111c:	8b 80 f0 00 00 00    	mov    0xf0(%rax),%eax
ffff800000101122:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000101125:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
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
ffff800000101155:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff80000010115c:	80 ff ff 
ffff80000010115f:	8b 90 f0 00 00 00    	mov    0xf0(%rax),%edx
ffff800000101165:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
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
ffff800000101193:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff80000010119a:	80 ff ff 
ffff80000010119d:	8b 80 f0 00 00 00    	mov    0xf0(%rax),%eax
ffff8000001011a3:	8d 50 01             	lea    0x1(%rax),%edx
ffff8000001011a6:	48 b9 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rcx
ffff8000001011ad:	80 ff ff 
ffff8000001011b0:	89 91 f0 00 00 00    	mov    %edx,0xf0(%rcx)
ffff8000001011b6:	83 e0 7f             	and    $0x7f,%eax
ffff8000001011b9:	89 c2                	mov    %eax,%edx
ffff8000001011bb:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001011be:	89 c1                	mov    %eax,%ecx
ffff8000001011c0:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
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
ffff8000001011ed:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff8000001011f4:	80 ff ff 
ffff8000001011f7:	8b 90 f0 00 00 00    	mov    0xf0(%rax),%edx
ffff8000001011fd:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000101204:	80 ff ff 
ffff800000101207:	8b 80 e8 00 00 00    	mov    0xe8(%rax),%eax
ffff80000010120d:	83 e8 80             	sub    $0xffffff80,%eax
ffff800000101210:	39 c2                	cmp    %eax,%edx
ffff800000101212:	75 41                	jne    ffff800000101255 <consoleintr+0x2a0>
          input.w = input.e;
ffff800000101214:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff80000010121b:	80 ff ff 
ffff80000010121e:	8b 80 f0 00 00 00    	mov    0xf0(%rax),%eax
ffff800000101224:	48 ba c0 33 11 00 00 	movabs $0xffff8000001133c0,%rdx
ffff80000010122b:	80 ff ff 
ffff80000010122e:	89 82 ec 00 00 00    	mov    %eax,0xec(%rdx)
          wakeup(&input.r);
ffff800000101234:	48 b8 a8 34 11 00 00 	movabs $0xffff8000001134a8,%rax
ffff80000010123b:	80 ff ff 
ffff80000010123e:	48 89 c7             	mov    %rax,%rdi
ffff800000101241:	48 b8 21 72 10 00 00 	movabs $0xffff800000107221,%rax
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
ffff800000101269:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000101270:	80 ff ff 
ffff800000101273:	48 89 c7             	mov    %rax,%rdi
ffff800000101276:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
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
ffff8000001012a6:	48 b8 01 2b 10 00 00 	movabs $0xffff800000102b01,%rax
ffff8000001012ad:	80 ff ff 
ffff8000001012b0:	ff d0                	call   *%rax
  target = n;
ffff8000001012b2:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff8000001012b5:	89 45 fc             	mov    %eax,-0x4(%rbp)
  acquire(&input.lock);
ffff8000001012b8:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff8000001012bf:	80 ff ff 
ffff8000001012c2:	48 89 c7             	mov    %rax,%rdi
ffff8000001012c5:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
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
ffff8000001012e8:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff8000001012ef:	80 ff ff 
ffff8000001012f2:	48 89 c7             	mov    %rax,%rdi
ffff8000001012f5:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff8000001012fc:	80 ff ff 
ffff8000001012ff:	ff d0                	call   *%rax
        ilock(ip);
ffff800000101301:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101305:	48 89 c7             	mov    %rax,%rdi
ffff800000101308:	48 b8 66 29 10 00 00 	movabs $0xffff800000102966,%rax
ffff80000010130f:	80 ff ff 
ffff800000101312:	ff d0                	call   *%rax
        return -1;
ffff800000101314:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000101319:	e9 21 01 00 00       	jmp    ffff80000010143f <consoleread+0x1ba>
      }
      sleep(&input.r, &input.lock);
ffff80000010131e:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000101325:	80 ff ff 
ffff800000101328:	48 89 c6             	mov    %rax,%rsi
ffff80000010132b:	48 b8 a8 34 11 00 00 	movabs $0xffff8000001134a8,%rax
ffff800000101332:	80 ff ff 
ffff800000101335:	48 89 c7             	mov    %rax,%rdi
ffff800000101338:	48 b8 a4 70 10 00 00 	movabs $0xffff8000001070a4,%rax
ffff80000010133f:	80 ff ff 
ffff800000101342:	ff d0                	call   *%rax
    while(input.r == input.w){
ffff800000101344:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff80000010134b:	80 ff ff 
ffff80000010134e:	8b 90 e8 00 00 00    	mov    0xe8(%rax),%edx
ffff800000101354:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff80000010135b:	80 ff ff 
ffff80000010135e:	8b 80 ec 00 00 00    	mov    0xec(%rax),%eax
ffff800000101364:	39 c2                	cmp    %eax,%edx
ffff800000101366:	0f 84 6a ff ff ff    	je     ffff8000001012d6 <consoleread+0x51>
    }
    c = input.buf[input.r++ % INPUT_BUF];
ffff80000010136c:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000101373:	80 ff ff 
ffff800000101376:	8b 80 e8 00 00 00    	mov    0xe8(%rax),%eax
ffff80000010137c:	8d 50 01             	lea    0x1(%rax),%edx
ffff80000010137f:	48 b9 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rcx
ffff800000101386:	80 ff ff 
ffff800000101389:	89 91 e8 00 00 00    	mov    %edx,0xe8(%rcx)
ffff80000010138f:	83 e0 7f             	and    $0x7f,%eax
ffff800000101392:	89 c2                	mov    %eax,%edx
ffff800000101394:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
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
ffff8000001013b9:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff8000001013c0:	80 ff ff 
ffff8000001013c3:	8b 80 e8 00 00 00    	mov    0xe8(%rax),%eax
ffff8000001013c9:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff8000001013cc:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
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
ffff800000101409:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000101410:	80 ff ff 
ffff800000101413:	48 89 c7             	mov    %rax,%rdi
ffff800000101416:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff80000010141d:	80 ff ff 
ffff800000101420:	ff d0                	call   *%rax
  ilock(ip);
ffff800000101422:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101426:	48 89 c7             	mov    %rax,%rdi
ffff800000101429:	48 b8 66 29 10 00 00 	movabs $0xffff800000102966,%rax
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
ffff800000101462:	48 b8 01 2b 10 00 00 	movabs $0xffff800000102b01,%rax
ffff800000101469:	80 ff ff 
ffff80000010146c:	ff d0                	call   *%rax
  acquire(&cons.lock);
ffff80000010146e:	48 b8 c0 34 11 00 00 	movabs $0xffff8000001134c0,%rax
ffff800000101475:	80 ff ff 
ffff800000101478:	48 89 c7             	mov    %rax,%rdi
ffff80000010147b:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
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
ffff8000001014c0:	48 b8 c0 34 11 00 00 	movabs $0xffff8000001134c0,%rax
ffff8000001014c7:	80 ff ff 
ffff8000001014ca:	48 89 c7             	mov    %rax,%rdi
ffff8000001014cd:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff8000001014d4:	80 ff ff 
ffff8000001014d7:	ff d0                	call   *%rax
  ilock(ip);
ffff8000001014d9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001014dd:	48 89 c7             	mov    %rax,%rdi
ffff8000001014e0:	48 b8 66 29 10 00 00 	movabs $0xffff800000102966,%rax
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
ffff8000001014f9:	48 b8 a3 c4 10 00 00 	movabs $0xffff80000010c4a3,%rax
ffff800000101500:	80 ff ff 
ffff800000101503:	48 89 c6             	mov    %rax,%rsi
ffff800000101506:	48 b8 c0 34 11 00 00 	movabs $0xffff8000001134c0,%rax
ffff80000010150d:	80 ff ff 
ffff800000101510:	48 89 c7             	mov    %rax,%rdi
ffff800000101513:	48 b8 96 79 10 00 00 	movabs $0xffff800000107996,%rax
ffff80000010151a:	80 ff ff 
ffff80000010151d:	ff d0                	call   *%rax
  initlock(&input.lock, "input");
ffff80000010151f:	48 b8 ab c4 10 00 00 	movabs $0xffff80000010c4ab,%rax
ffff800000101526:	80 ff ff 
ffff800000101529:	48 89 c6             	mov    %rax,%rsi
ffff80000010152c:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000101533:	80 ff ff 
ffff800000101536:	48 89 c7             	mov    %rax,%rdi
ffff800000101539:	48 b8 96 79 10 00 00 	movabs $0xffff800000107996,%rax
ffff800000101540:	80 ff ff 
ffff800000101543:	ff d0                	call   *%rax

  devsw[CONSOLE].write = consolewrite;
ffff800000101545:	48 b8 40 35 11 00 00 	movabs $0xffff800000113540,%rax
ffff80000010154c:	80 ff ff 
ffff80000010154f:	48 ba 41 14 10 00 00 	movabs $0xffff800000101441,%rdx
ffff800000101556:	80 ff ff 
ffff800000101559:	48 89 50 18          	mov    %rdx,0x18(%rax)
  devsw[CONSOLE].read = consoleread;
ffff80000010155d:	48 b8 40 35 11 00 00 	movabs $0xffff800000113540,%rax
ffff800000101564:	80 ff ff 
ffff800000101567:	48 b9 85 12 10 00 00 	movabs $0xffff800000101285,%rcx
ffff80000010156e:	80 ff ff 
ffff800000101571:	48 89 48 10          	mov    %rcx,0x10(%rax)
  cons.locking = 1;
ffff800000101575:	48 b8 c0 34 11 00 00 	movabs $0xffff8000001134c0,%rax
ffff80000010157c:	80 ff ff 
ffff80000010157f:	c7 40 68 01 00 00 00 	movl   $0x1,0x68(%rax)

  ioapicenable(IRQ_KBD, 0);
ffff800000101586:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010158b:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000101590:	48 b8 b6 40 10 00 00 	movabs $0xffff8000001040b6,%rax
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
ffff8000001015d4:	48 ba 70 50 10 00 00 	movabs $0xffff800000105070,%rdx
ffff8000001015db:	80 ff ff 
ffff8000001015de:	ff d2                	call   *%rdx

  if((ip = namei(path)) == 0){
ffff8000001015e0:	48 8b 85 08 fe ff ff 	mov    -0x1f8(%rbp),%rax
ffff8000001015e7:	48 89 c7             	mov    %rax,%rdi
ffff8000001015ea:	48 b8 a5 38 10 00 00 	movabs $0xffff8000001038a5,%rax
ffff8000001015f1:	80 ff ff 
ffff8000001015f4:	ff d0                	call   *%rax
ffff8000001015f6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
ffff8000001015fa:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
ffff8000001015ff:	75 1b                	jne    ffff80000010161c <exec+0x7d>
    end_op();
ffff800000101601:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000101606:	48 ba 5c 51 10 00 00 	movabs $0xffff80000010515c,%rdx
ffff80000010160d:	80 ff ff 
ffff800000101610:	ff d2                	call   *%rdx
    return -1;
ffff800000101612:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000101617:	e9 73 05 00 00       	jmp    ffff800000101b8f <exec+0x5f0>
  }
  ilock(ip);
ffff80000010161c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff800000101620:	48 89 c7             	mov    %rax,%rdi
ffff800000101623:	48 b8 66 29 10 00 00 	movabs $0xffff800000102966,%rax
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
ffff80000010164f:	48 b8 eb 2f 10 00 00 	movabs $0xffff800000102feb,%rax
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
ffff800000101675:	48 b8 1f b4 10 00 00 	movabs $0xffff80000010b41f,%rax
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
ffff8000001016c4:	48 b8 eb 2f 10 00 00 	movabs $0xffff800000102feb,%rax
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
ffff80000010173f:	48 b8 96 bb 10 00 00 	movabs $0xffff80000010bb96,%rax
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
ffff800000101799:	48 b8 6a ba 10 00 00 	movabs $0xffff80000010ba6a,%rax
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
ffff8000001017d7:	48 b8 6f 2c 10 00 00 	movabs $0xffff800000102c6f,%rax
ffff8000001017de:	80 ff ff 
ffff8000001017e1:	ff d0                	call   *%rax
  end_op();
ffff8000001017e3:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001017e8:	48 ba 5c 51 10 00 00 	movabs $0xffff80000010515c,%rdx
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
ffff800000101829:	48 b8 96 bb 10 00 00 	movabs $0xffff80000010bb96,%rax
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
ffff80000010185b:	48 b8 16 c0 10 00 00 	movabs $0xffff80000010c016,%rax
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
ffff8000001018a3:	48 b8 be 80 10 00 00 	movabs $0xffff8000001080be,%rax
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
ffff8000001018e2:	48 b8 be 80 10 00 00 	movabs $0xffff8000001080be,%rax
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
ffff800000101918:	48 b8 94 c2 10 00 00 	movabs $0xffff80000010c294,%rax
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
ffff8000001019f9:	48 b8 94 c2 10 00 00 	movabs $0xffff80000010c294,%rax
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
ffff800000101a6a:	48 b8 57 80 10 00 00 	movabs $0xffff800000108057,%rax
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
ffff800000101afa:	48 b8 85 b5 10 00 00 	movabs $0xffff80000010b585,%rax
ffff800000101b01:	80 ff ff 
ffff800000101b04:	ff d0                	call   *%rax
  freevm(oldpgdir);
ffff800000101b06:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101b0a:	48 89 c7             	mov    %rax,%rdi
ffff800000101b0d:	48 b8 db bd 10 00 00 	movabs $0xffff80000010bddb,%rax
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
ffff800000101b53:	48 b8 db bd 10 00 00 	movabs $0xffff80000010bddb,%rax
ffff800000101b5a:	80 ff ff 
ffff800000101b5d:	ff d0                	call   *%rax
  if(ip){
ffff800000101b5f:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
ffff800000101b64:	74 24                	je     ffff800000101b8a <exec+0x5eb>
    iunlockput(ip);
ffff800000101b66:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff800000101b6a:	48 89 c7             	mov    %rax,%rdi
ffff800000101b6d:	48 b8 6f 2c 10 00 00 	movabs $0xffff800000102c6f,%rax
ffff800000101b74:	80 ff ff 
ffff800000101b77:	ff d0                	call   *%rax
    end_op();
ffff800000101b79:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000101b7e:	48 ba 5c 51 10 00 00 	movabs $0xffff80000010515c,%rdx
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
ffff800000101b99:	48 b8 b1 c4 10 00 00 	movabs $0xffff80000010c4b1,%rax
ffff800000101ba0:	80 ff ff 
ffff800000101ba3:	48 89 c6             	mov    %rax,%rsi
ffff800000101ba6:	48 b8 e0 35 11 00 00 	movabs $0xffff8000001135e0,%rax
ffff800000101bad:	80 ff ff 
ffff800000101bb0:	48 89 c7             	mov    %rax,%rdi
ffff800000101bb3:	48 b8 96 79 10 00 00 	movabs $0xffff800000107996,%rax
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
ffff800000101bce:	48 b8 e0 35 11 00 00 	movabs $0xffff8000001135e0,%rax
ffff800000101bd5:	80 ff ff 
ffff800000101bd8:	48 89 c7             	mov    %rax,%rdi
ffff800000101bdb:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff800000101be2:	80 ff ff 
ffff800000101be5:	ff d0                	call   *%rax
  for(f = ftable.file; f < ftable.file + NFILE; f++){
ffff800000101be7:	48 b8 48 36 11 00 00 	movabs $0xffff800000113648,%rax
ffff800000101bee:	80 ff ff 
ffff800000101bf1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000101bf5:	eb 3a                	jmp    ffff800000101c31 <filealloc+0x6f>
    if(f->ref == 0){
ffff800000101bf7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101bfb:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101bfe:	85 c0                	test   %eax,%eax
ffff800000101c00:	75 2a                	jne    ffff800000101c2c <filealloc+0x6a>
      f->ref = 1;
ffff800000101c02:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101c06:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%rax)
      release(&ftable.lock);
ffff800000101c0d:	48 b8 e0 35 11 00 00 	movabs $0xffff8000001135e0,%rax
ffff800000101c14:	80 ff ff 
ffff800000101c17:	48 89 c7             	mov    %rax,%rdi
ffff800000101c1a:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff800000101c21:	80 ff ff 
ffff800000101c24:	ff d0                	call   *%rax
      return f;
ffff800000101c26:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101c2a:	eb 33                	jmp    ffff800000101c5f <filealloc+0x9d>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
ffff800000101c2c:	48 83 45 f8 28       	addq   $0x28,-0x8(%rbp)
ffff800000101c31:	48 b8 e8 45 11 00 00 	movabs $0xffff8000001145e8,%rax
ffff800000101c38:	80 ff ff 
ffff800000101c3b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000101c3f:	72 b6                	jb     ffff800000101bf7 <filealloc+0x35>
    }
  }
  release(&ftable.lock);
ffff800000101c41:	48 b8 e0 35 11 00 00 	movabs $0xffff8000001135e0,%rax
ffff800000101c48:	80 ff ff 
ffff800000101c4b:	48 89 c7             	mov    %rax,%rdi
ffff800000101c4e:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff800000101c55:	80 ff ff 
ffff800000101c58:	ff d0                	call   *%rax
  return 0;
ffff800000101c5a:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000101c5f:	c9                   	leave
ffff800000101c60:	c3                   	ret

ffff800000101c61 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
ffff800000101c61:	f3 0f 1e fa          	endbr64
ffff800000101c65:	55                   	push   %rbp
ffff800000101c66:	48 89 e5             	mov    %rsp,%rbp
ffff800000101c69:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000101c6d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&ftable.lock);
ffff800000101c71:	48 b8 e0 35 11 00 00 	movabs $0xffff8000001135e0,%rax
ffff800000101c78:	80 ff ff 
ffff800000101c7b:	48 89 c7             	mov    %rax,%rdi
ffff800000101c7e:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff800000101c85:	80 ff ff 
ffff800000101c88:	ff d0                	call   *%rax
  if(f->ref < 1)
ffff800000101c8a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101c8e:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101c91:	85 c0                	test   %eax,%eax
ffff800000101c93:	7f 19                	jg     ffff800000101cae <filedup+0x4d>
    panic("filedup");
ffff800000101c95:	48 b8 b8 c4 10 00 00 	movabs $0xffff80000010c4b8,%rax
ffff800000101c9c:	80 ff ff 
ffff800000101c9f:	48 89 c7             	mov    %rax,%rdi
ffff800000101ca2:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000101ca9:	80 ff ff 
ffff800000101cac:	ff d0                	call   *%rax
  f->ref++;
ffff800000101cae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101cb2:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101cb5:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000101cb8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101cbc:	89 50 04             	mov    %edx,0x4(%rax)
  release(&ftable.lock);
ffff800000101cbf:	48 b8 e0 35 11 00 00 	movabs $0xffff8000001135e0,%rax
ffff800000101cc6:	80 ff ff 
ffff800000101cc9:	48 89 c7             	mov    %rax,%rdi
ffff800000101ccc:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff800000101cd3:	80 ff ff 
ffff800000101cd6:	ff d0                	call   *%rax
  return f;
ffff800000101cd8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000101cdc:	c9                   	leave
ffff800000101cdd:	c3                   	ret

ffff800000101cde <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
ffff800000101cde:	f3 0f 1e fa          	endbr64
ffff800000101ce2:	55                   	push   %rbp
ffff800000101ce3:	48 89 e5             	mov    %rsp,%rbp
ffff800000101ce6:	53                   	push   %rbx
ffff800000101ce7:	48 83 ec 48          	sub    $0x48,%rsp
ffff800000101ceb:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
  struct file ff;

  acquire(&ftable.lock);
ffff800000101cef:	48 b8 e0 35 11 00 00 	movabs $0xffff8000001135e0,%rax
ffff800000101cf6:	80 ff ff 
ffff800000101cf9:	48 89 c7             	mov    %rax,%rdi
ffff800000101cfc:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff800000101d03:	80 ff ff 
ffff800000101d06:	ff d0                	call   *%rax
  if(f->ref < 1)
ffff800000101d08:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101d0c:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101d0f:	85 c0                	test   %eax,%eax
ffff800000101d11:	7f 19                	jg     ffff800000101d2c <fileclose+0x4e>
    panic("fileclose");
ffff800000101d13:	48 b8 c0 c4 10 00 00 	movabs $0xffff80000010c4c0,%rax
ffff800000101d1a:	80 ff ff 
ffff800000101d1d:	48 89 c7             	mov    %rax,%rdi
ffff800000101d20:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000101d27:	80 ff ff 
ffff800000101d2a:	ff d0                	call   *%rax
  if(--f->ref > 0){
ffff800000101d2c:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101d30:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101d33:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000101d36:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101d3a:	89 50 04             	mov    %edx,0x4(%rax)
ffff800000101d3d:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101d41:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101d44:	85 c0                	test   %eax,%eax
ffff800000101d46:	7e 1e                	jle    ffff800000101d66 <fileclose+0x88>
    release(&ftable.lock);
ffff800000101d48:	48 b8 e0 35 11 00 00 	movabs $0xffff8000001135e0,%rax
ffff800000101d4f:	80 ff ff 
ffff800000101d52:	48 89 c7             	mov    %rax,%rdi
ffff800000101d55:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff800000101d5c:	80 ff ff 
ffff800000101d5f:	ff d0                	call   *%rax
ffff800000101d61:	e9 bc 00 00 00       	jmp    ffff800000101e22 <fileclose+0x144>
    return;
  }
  ff = *f;
ffff800000101d66:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101d6a:	48 8b 08             	mov    (%rax),%rcx
ffff800000101d6d:	48 8b 58 08          	mov    0x8(%rax),%rbx
ffff800000101d71:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
ffff800000101d75:	48 89 5d c8          	mov    %rbx,-0x38(%rbp)
ffff800000101d79:	48 8b 48 10          	mov    0x10(%rax),%rcx
ffff800000101d7d:	48 8b 58 18          	mov    0x18(%rax),%rbx
ffff800000101d81:	48 89 4d d0          	mov    %rcx,-0x30(%rbp)
ffff800000101d85:	48 89 5d d8          	mov    %rbx,-0x28(%rbp)
ffff800000101d89:	48 8b 40 20          	mov    0x20(%rax),%rax
ffff800000101d8d:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  f->ref = 0;
ffff800000101d91:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101d95:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%rax)
  f->type = FD_NONE;
ffff800000101d9c:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101da0:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  release(&ftable.lock);
ffff800000101da6:	48 b8 e0 35 11 00 00 	movabs $0xffff8000001135e0,%rax
ffff800000101dad:	80 ff ff 
ffff800000101db0:	48 89 c7             	mov    %rax,%rdi
ffff800000101db3:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff800000101dba:	80 ff ff 
ffff800000101dbd:	ff d0                	call   *%rax

  if(ff.type == FD_PIPE)
ffff800000101dbf:	8b 45 c0             	mov    -0x40(%rbp),%eax
ffff800000101dc2:	83 f8 01             	cmp    $0x1,%eax
ffff800000101dc5:	75 1e                	jne    ffff800000101de5 <fileclose+0x107>
    pipeclose(ff.pipe, ff.writable);
ffff800000101dc7:	0f b6 45 c9          	movzbl -0x37(%rbp),%eax
ffff800000101dcb:	0f be d0             	movsbl %al,%edx
ffff800000101dce:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000101dd2:	89 d6                	mov    %edx,%esi
ffff800000101dd4:	48 89 c7             	mov    %rax,%rdi
ffff800000101dd7:	48 b8 c5 5f 10 00 00 	movabs $0xffff800000105fc5,%rax
ffff800000101dde:	80 ff ff 
ffff800000101de1:	ff d0                	call   *%rax
ffff800000101de3:	eb 3d                	jmp    ffff800000101e22 <fileclose+0x144>
  else if(ff.type == FD_INODE){
ffff800000101de5:	8b 45 c0             	mov    -0x40(%rbp),%eax
ffff800000101de8:	83 f8 02             	cmp    $0x2,%eax
ffff800000101deb:	75 35                	jne    ffff800000101e22 <fileclose+0x144>
    begin_op();
ffff800000101ded:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000101df2:	48 ba 70 50 10 00 00 	movabs $0xffff800000105070,%rdx
ffff800000101df9:	80 ff ff 
ffff800000101dfc:	ff d2                	call   *%rdx
    iput(ff.ip);
ffff800000101dfe:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000101e02:	48 89 c7             	mov    %rax,%rdi
ffff800000101e05:	48 b8 71 2b 10 00 00 	movabs $0xffff800000102b71,%rax
ffff800000101e0c:	80 ff ff 
ffff800000101e0f:	ff d0                	call   *%rax
    end_op();
ffff800000101e11:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000101e16:	48 ba 5c 51 10 00 00 	movabs $0xffff80000010515c,%rdx
ffff800000101e1d:	80 ff ff 
ffff800000101e20:	ff d2                	call   *%rdx
  }
}
ffff800000101e22:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
ffff800000101e26:	c9                   	leave
ffff800000101e27:	c3                   	ret

ffff800000101e28 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
ffff800000101e28:	f3 0f 1e fa          	endbr64
ffff800000101e2c:	55                   	push   %rbp
ffff800000101e2d:	48 89 e5             	mov    %rsp,%rbp
ffff800000101e30:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000101e34:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000101e38:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(f->type == FD_INODE){
ffff800000101e3c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101e40:	8b 00                	mov    (%rax),%eax
ffff800000101e42:	83 f8 02             	cmp    $0x2,%eax
ffff800000101e45:	75 53                	jne    ffff800000101e9a <filestat+0x72>
    ilock(f->ip);
ffff800000101e47:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101e4b:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101e4f:	48 89 c7             	mov    %rax,%rdi
ffff800000101e52:	48 b8 66 29 10 00 00 	movabs $0xffff800000102966,%rax
ffff800000101e59:	80 ff ff 
ffff800000101e5c:	ff d0                	call   *%rax
    stati(f->ip, st);
ffff800000101e5e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101e62:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101e66:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000101e6a:	48 89 d6             	mov    %rdx,%rsi
ffff800000101e6d:	48 89 c7             	mov    %rax,%rdi
ffff800000101e70:	48 b8 81 2f 10 00 00 	movabs $0xffff800000102f81,%rax
ffff800000101e77:	80 ff ff 
ffff800000101e7a:	ff d0                	call   *%rax
    iunlock(f->ip);
ffff800000101e7c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101e80:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101e84:	48 89 c7             	mov    %rax,%rdi
ffff800000101e87:	48 b8 01 2b 10 00 00 	movabs $0xffff800000102b01,%rax
ffff800000101e8e:	80 ff ff 
ffff800000101e91:	ff d0                	call   *%rax
    return 0;
ffff800000101e93:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000101e98:	eb 05                	jmp    ffff800000101e9f <filestat+0x77>
  }
  return -1;
ffff800000101e9a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000101e9f:	c9                   	leave
ffff800000101ea0:	c3                   	ret

ffff800000101ea1 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
ffff800000101ea1:	f3 0f 1e fa          	endbr64
ffff800000101ea5:	55                   	push   %rbp
ffff800000101ea6:	48 89 e5             	mov    %rsp,%rbp
ffff800000101ea9:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000101ead:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000101eb1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000101eb5:	89 55 dc             	mov    %edx,-0x24(%rbp)
  int r;

  if(f->readable == 0)
ffff800000101eb8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101ebc:	0f b6 40 08          	movzbl 0x8(%rax),%eax
ffff800000101ec0:	84 c0                	test   %al,%al
ffff800000101ec2:	75 0a                	jne    ffff800000101ece <fileread+0x2d>
    return -1;
ffff800000101ec4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000101ec9:	e9 c9 00 00 00       	jmp    ffff800000101f97 <fileread+0xf6>
  if(f->type == FD_PIPE)
ffff800000101ece:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101ed2:	8b 00                	mov    (%rax),%eax
ffff800000101ed4:	83 f8 01             	cmp    $0x1,%eax
ffff800000101ed7:	75 26                	jne    ffff800000101eff <fileread+0x5e>
    return piperead(f->pipe, addr, n);
ffff800000101ed9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101edd:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000101ee1:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffff800000101ee4:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff800000101ee8:	48 89 ce             	mov    %rcx,%rsi
ffff800000101eeb:	48 89 c7             	mov    %rax,%rdi
ffff800000101eee:	48 b8 e0 61 10 00 00 	movabs $0xffff8000001061e0,%rax
ffff800000101ef5:	80 ff ff 
ffff800000101ef8:	ff d0                	call   *%rax
ffff800000101efa:	e9 98 00 00 00       	jmp    ffff800000101f97 <fileread+0xf6>
  if(f->type == FD_INODE){
ffff800000101eff:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101f03:	8b 00                	mov    (%rax),%eax
ffff800000101f05:	83 f8 02             	cmp    $0x2,%eax
ffff800000101f08:	75 74                	jne    ffff800000101f7e <fileread+0xdd>
    ilock(f->ip);
ffff800000101f0a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101f0e:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101f12:	48 89 c7             	mov    %rax,%rdi
ffff800000101f15:	48 b8 66 29 10 00 00 	movabs $0xffff800000102966,%rax
ffff800000101f1c:	80 ff ff 
ffff800000101f1f:	ff d0                	call   *%rax
    if((r = readi(f->ip, addr, f->off, n)) > 0)
ffff800000101f21:	8b 4d dc             	mov    -0x24(%rbp),%ecx
ffff800000101f24:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101f28:	8b 50 20             	mov    0x20(%rax),%edx
ffff800000101f2b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101f2f:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101f33:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
ffff800000101f37:	48 89 c7             	mov    %rax,%rdi
ffff800000101f3a:	48 b8 eb 2f 10 00 00 	movabs $0xffff800000102feb,%rax
ffff800000101f41:	80 ff ff 
ffff800000101f44:	ff d0                	call   *%rax
ffff800000101f46:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000101f49:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000101f4d:	7e 13                	jle    ffff800000101f62 <fileread+0xc1>
      f->off += r;
ffff800000101f4f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101f53:	8b 50 20             	mov    0x20(%rax),%edx
ffff800000101f56:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000101f59:	01 c2                	add    %eax,%edx
ffff800000101f5b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101f5f:	89 50 20             	mov    %edx,0x20(%rax)
    iunlock(f->ip);
ffff800000101f62:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101f66:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101f6a:	48 89 c7             	mov    %rax,%rdi
ffff800000101f6d:	48 b8 01 2b 10 00 00 	movabs $0xffff800000102b01,%rax
ffff800000101f74:	80 ff ff 
ffff800000101f77:	ff d0                	call   *%rax
    return r;
ffff800000101f79:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000101f7c:	eb 19                	jmp    ffff800000101f97 <fileread+0xf6>
  }
  panic("fileread");
ffff800000101f7e:	48 b8 ca c4 10 00 00 	movabs $0xffff80000010c4ca,%rax
ffff800000101f85:	80 ff ff 
ffff800000101f88:	48 89 c7             	mov    %rax,%rdi
ffff800000101f8b:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000101f92:	80 ff ff 
ffff800000101f95:	ff d0                	call   *%rax
}
ffff800000101f97:	c9                   	leave
ffff800000101f98:	c3                   	ret

ffff800000101f99 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
ffff800000101f99:	f3 0f 1e fa          	endbr64
ffff800000101f9d:	55                   	push   %rbp
ffff800000101f9e:	48 89 e5             	mov    %rsp,%rbp
ffff800000101fa1:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000101fa5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000101fa9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000101fad:	89 55 dc             	mov    %edx,-0x24(%rbp)
  int r;

  if(f->writable == 0)
ffff800000101fb0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101fb4:	0f b6 40 09          	movzbl 0x9(%rax),%eax
ffff800000101fb8:	84 c0                	test   %al,%al
ffff800000101fba:	75 0a                	jne    ffff800000101fc6 <filewrite+0x2d>
    return -1;
ffff800000101fbc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000101fc1:	e9 6d 01 00 00       	jmp    ffff800000102133 <filewrite+0x19a>
  if(f->type == FD_PIPE)
ffff800000101fc6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101fca:	8b 00                	mov    (%rax),%eax
ffff800000101fcc:	83 f8 01             	cmp    $0x1,%eax
ffff800000101fcf:	75 26                	jne    ffff800000101ff7 <filewrite+0x5e>
    return pipewrite(f->pipe, addr, n);
ffff800000101fd1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101fd5:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000101fd9:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffff800000101fdc:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff800000101fe0:	48 89 ce             	mov    %rcx,%rsi
ffff800000101fe3:	48 89 c7             	mov    %rax,%rdi
ffff800000101fe6:	48 b8 9c 60 10 00 00 	movabs $0xffff80000010609c,%rax
ffff800000101fed:	80 ff ff 
ffff800000101ff0:	ff d0                	call   *%rax
ffff800000101ff2:	e9 3c 01 00 00       	jmp    ffff800000102133 <filewrite+0x19a>
  if(f->type == FD_INODE){
ffff800000101ff7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101ffb:	8b 00                	mov    (%rax),%eax
ffff800000101ffd:	83 f8 02             	cmp    $0x2,%eax
ffff800000102000:	0f 85 14 01 00 00    	jne    ffff80000010211a <filewrite+0x181>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
ffff800000102006:	c7 45 f4 00 1a 00 00 	movl   $0x1a00,-0xc(%rbp)
    int i = 0;
ffff80000010200d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    while(i < n){
ffff800000102014:	e9 de 00 00 00       	jmp    ffff8000001020f7 <filewrite+0x15e>
      int n1 = n - i;
ffff800000102019:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff80000010201c:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff80000010201f:	89 45 f8             	mov    %eax,-0x8(%rbp)
      if(n1 > max)
ffff800000102022:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000102025:	3b 45 f4             	cmp    -0xc(%rbp),%eax
ffff800000102028:	7e 06                	jle    ffff800000102030 <filewrite+0x97>
        n1 = max;
ffff80000010202a:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff80000010202d:	89 45 f8             	mov    %eax,-0x8(%rbp)

      begin_op();
ffff800000102030:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000102035:	48 ba 70 50 10 00 00 	movabs $0xffff800000105070,%rdx
ffff80000010203c:	80 ff ff 
ffff80000010203f:	ff d2                	call   *%rdx
      ilock(f->ip);
ffff800000102041:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102045:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000102049:	48 89 c7             	mov    %rax,%rdi
ffff80000010204c:	48 b8 66 29 10 00 00 	movabs $0xffff800000102966,%rax
ffff800000102053:	80 ff ff 
ffff800000102056:	ff d0                	call   *%rax
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
ffff800000102058:	8b 4d f8             	mov    -0x8(%rbp),%ecx
ffff80000010205b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010205f:	8b 50 20             	mov    0x20(%rax),%edx
ffff800000102062:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102065:	48 63 f0             	movslq %eax,%rsi
ffff800000102068:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010206c:	48 01 c6             	add    %rax,%rsi
ffff80000010206f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102073:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000102077:	48 89 c7             	mov    %rax,%rdi
ffff80000010207a:	48 b8 bc 31 10 00 00 	movabs $0xffff8000001031bc,%rax
ffff800000102081:	80 ff ff 
ffff800000102084:	ff d0                	call   *%rax
ffff800000102086:	89 45 f0             	mov    %eax,-0x10(%rbp)
ffff800000102089:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
ffff80000010208d:	7e 13                	jle    ffff8000001020a2 <filewrite+0x109>
        f->off += r;
ffff80000010208f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102093:	8b 50 20             	mov    0x20(%rax),%edx
ffff800000102096:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000102099:	01 c2                	add    %eax,%edx
ffff80000010209b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010209f:	89 50 20             	mov    %edx,0x20(%rax)
      iunlock(f->ip);
ffff8000001020a2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001020a6:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff8000001020aa:	48 89 c7             	mov    %rax,%rdi
ffff8000001020ad:	48 b8 01 2b 10 00 00 	movabs $0xffff800000102b01,%rax
ffff8000001020b4:	80 ff ff 
ffff8000001020b7:	ff d0                	call   *%rax
      end_op();
ffff8000001020b9:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001020be:	48 ba 5c 51 10 00 00 	movabs $0xffff80000010515c,%rdx
ffff8000001020c5:	80 ff ff 
ffff8000001020c8:	ff d2                	call   *%rdx

      if(r < 0)
ffff8000001020ca:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
ffff8000001020ce:	78 35                	js     ffff800000102105 <filewrite+0x16c>
        break;
      if(r != n1)
ffff8000001020d0:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff8000001020d3:	3b 45 f8             	cmp    -0x8(%rbp),%eax
ffff8000001020d6:	74 19                	je     ffff8000001020f1 <filewrite+0x158>
        panic("short filewrite");
ffff8000001020d8:	48 b8 d3 c4 10 00 00 	movabs $0xffff80000010c4d3,%rax
ffff8000001020df:	80 ff ff 
ffff8000001020e2:	48 89 c7             	mov    %rax,%rdi
ffff8000001020e5:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff8000001020ec:	80 ff ff 
ffff8000001020ef:	ff d0                	call   *%rax
      i += r;
ffff8000001020f1:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff8000001020f4:	01 45 fc             	add    %eax,-0x4(%rbp)
    while(i < n){
ffff8000001020f7:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001020fa:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffff8000001020fd:	0f 8c 16 ff ff ff    	jl     ffff800000102019 <filewrite+0x80>
ffff800000102103:	eb 01                	jmp    ffff800000102106 <filewrite+0x16d>
        break;
ffff800000102105:	90                   	nop
    }
    return i == n ? n : -1;
ffff800000102106:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102109:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffff80000010210c:	75 05                	jne    ffff800000102113 <filewrite+0x17a>
ffff80000010210e:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000102111:	eb 20                	jmp    ffff800000102133 <filewrite+0x19a>
ffff800000102113:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000102118:	eb 19                	jmp    ffff800000102133 <filewrite+0x19a>
  }
  panic("filewrite");
ffff80000010211a:	48 b8 e3 c4 10 00 00 	movabs $0xffff80000010c4e3,%rax
ffff800000102121:	80 ff ff 
ffff800000102124:	48 89 c7             	mov    %rax,%rdi
ffff800000102127:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010212e:	80 ff ff 
ffff800000102131:	ff d0                	call   *%rax
}
ffff800000102133:	c9                   	leave
ffff800000102134:	c3                   	ret

ffff800000102135 <readsb>:
struct superblock sb;

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
ffff800000102135:	f3 0f 1e fa          	endbr64
ffff800000102139:	55                   	push   %rbp
ffff80000010213a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010213d:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000102141:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000102144:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  struct buf *bp = bread(dev, 1);
ffff800000102148:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff80000010214b:	be 01 00 00 00       	mov    $0x1,%esi
ffff800000102150:	89 c7                	mov    %eax,%edi
ffff800000102152:	48 b8 d4 03 10 00 00 	movabs $0xffff8000001003d4,%rax
ffff800000102159:	80 ff ff 
ffff80000010215c:	ff d0                	call   *%rax
ffff80000010215e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memmove(sb, bp->data, sizeof(*sb));
ffff800000102162:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102166:	48 8d 88 b0 00 00 00 	lea    0xb0(%rax),%rcx
ffff80000010216d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000102171:	ba 1c 00 00 00       	mov    $0x1c,%edx
ffff800000102176:	48 89 ce             	mov    %rcx,%rsi
ffff800000102179:	48 89 c7             	mov    %rax,%rdi
ffff80000010217c:	48 b8 94 7e 10 00 00 	movabs $0xffff800000107e94,%rax
ffff800000102183:	80 ff ff 
ffff800000102186:	ff d0                	call   *%rax
  brelse(bp);
ffff800000102188:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010218c:	48 89 c7             	mov    %rax,%rdi
ffff80000010218f:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff800000102196:	80 ff ff 
ffff800000102199:	ff d0                	call   *%rax
}
ffff80000010219b:	90                   	nop
ffff80000010219c:	c9                   	leave
ffff80000010219d:	c3                   	ret

ffff80000010219e <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
ffff80000010219e:	f3 0f 1e fa          	endbr64
ffff8000001021a2:	55                   	push   %rbp
ffff8000001021a3:	48 89 e5             	mov    %rsp,%rbp
ffff8000001021a6:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001021aa:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff8000001021ad:	89 75 e8             	mov    %esi,-0x18(%rbp)
  struct buf *bp = bread(dev, bno);
ffff8000001021b0:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffff8000001021b3:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001021b6:	89 d6                	mov    %edx,%esi
ffff8000001021b8:	89 c7                	mov    %eax,%edi
ffff8000001021ba:	48 b8 d4 03 10 00 00 	movabs $0xffff8000001003d4,%rax
ffff8000001021c1:	80 ff ff 
ffff8000001021c4:	ff d0                	call   *%rax
ffff8000001021c6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(bp->data, 0, BSIZE);
ffff8000001021ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001021ce:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff8000001021d4:	ba 00 02 00 00       	mov    $0x200,%edx
ffff8000001021d9:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001021de:	48 89 c7             	mov    %rax,%rdi
ffff8000001021e1:	48 b8 87 7d 10 00 00 	movabs $0xffff800000107d87,%rax
ffff8000001021e8:	80 ff ff 
ffff8000001021eb:	ff d0                	call   *%rax
  log_write(bp);
ffff8000001021ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001021f1:	48 89 c7             	mov    %rax,%rdi
ffff8000001021f4:	48 b8 0d 54 10 00 00 	movabs $0xffff80000010540d,%rax
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

ffff800000102216 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
ffff800000102216:	f3 0f 1e fa          	endbr64
ffff80000010221a:	55                   	push   %rbp
ffff80000010221b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010221e:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000102222:	89 7d dc             	mov    %edi,-0x24(%rbp)
  int b, bi, m;
  struct buf *bp;
  for(b = 0; b < sb.size; b += BPB){
ffff800000102225:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010222c:	e9 4a 01 00 00       	jmp    ffff80000010237b <balloc+0x165>
    bp = bread(dev, BBLOCK(b, sb));
ffff800000102231:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102234:	8d 90 ff 0f 00 00    	lea    0xfff(%rax),%edx
ffff80000010223a:	85 c0                	test   %eax,%eax
ffff80000010223c:	0f 48 c2             	cmovs  %edx,%eax
ffff80000010223f:	c1 f8 0c             	sar    $0xc,%eax
ffff800000102242:	89 c2                	mov    %eax,%edx
ffff800000102244:	48 b8 00 46 11 00 00 	movabs $0xffff800000114600,%rax
ffff80000010224b:	80 ff ff 
ffff80000010224e:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000102251:	01 c2                	add    %eax,%edx
ffff800000102253:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000102256:	89 d6                	mov    %edx,%esi
ffff800000102258:	89 c7                	mov    %eax,%edi
ffff80000010225a:	48 b8 d4 03 10 00 00 	movabs $0xffff8000001003d4,%rax
ffff800000102261:	80 ff ff 
ffff800000102264:	ff d0                	call   *%rax
ffff800000102266:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
ffff80000010226a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
ffff800000102271:	e9 c4 00 00 00       	jmp    ffff80000010233a <balloc+0x124>
      m = 1 << (bi % 8);
ffff800000102276:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000102279:	83 e0 07             	and    $0x7,%eax
ffff80000010227c:	ba 01 00 00 00       	mov    $0x1,%edx
ffff800000102281:	89 c1                	mov    %eax,%ecx
ffff800000102283:	d3 e2                	shl    %cl,%edx
ffff800000102285:	89 d0                	mov    %edx,%eax
ffff800000102287:	89 45 ec             	mov    %eax,-0x14(%rbp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
ffff80000010228a:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff80000010228d:	8d 50 07             	lea    0x7(%rax),%edx
ffff800000102290:	85 c0                	test   %eax,%eax
ffff800000102292:	0f 48 c2             	cmovs  %edx,%eax
ffff800000102295:	c1 f8 03             	sar    $0x3,%eax
ffff800000102298:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff80000010229c:	48 98                	cltq
ffff80000010229e:	0f b6 84 02 b0 00 00 	movzbl 0xb0(%rdx,%rax,1),%eax
ffff8000001022a5:	00 
ffff8000001022a6:	0f b6 c0             	movzbl %al,%eax
ffff8000001022a9:	23 45 ec             	and    -0x14(%rbp),%eax
ffff8000001022ac:	85 c0                	test   %eax,%eax
ffff8000001022ae:	0f 85 82 00 00 00    	jne    ffff800000102336 <balloc+0x120>
        bp->data[bi/8] |= m;  // Mark block in use.
ffff8000001022b4:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff8000001022b7:	8d 50 07             	lea    0x7(%rax),%edx
ffff8000001022ba:	85 c0                	test   %eax,%eax
ffff8000001022bc:	0f 48 c2             	cmovs  %edx,%eax
ffff8000001022bf:	c1 f8 03             	sar    $0x3,%eax
ffff8000001022c2:	89 c1                	mov    %eax,%ecx
ffff8000001022c4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff8000001022c8:	48 63 c1             	movslq %ecx,%rax
ffff8000001022cb:	0f b6 84 02 b0 00 00 	movzbl 0xb0(%rdx,%rax,1),%eax
ffff8000001022d2:	00 
ffff8000001022d3:	89 c2                	mov    %eax,%edx
ffff8000001022d5:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001022d8:	09 d0                	or     %edx,%eax
ffff8000001022da:	89 c6                	mov    %eax,%esi
ffff8000001022dc:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff8000001022e0:	48 63 c1             	movslq %ecx,%rax
ffff8000001022e3:	40 88 b4 02 b0 00 00 	mov    %sil,0xb0(%rdx,%rax,1)
ffff8000001022ea:	00 
        log_write(bp);
ffff8000001022eb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001022ef:	48 89 c7             	mov    %rax,%rdi
ffff8000001022f2:	48 b8 0d 54 10 00 00 	movabs $0xffff80000010540d,%rax
ffff8000001022f9:	80 ff ff 
ffff8000001022fc:	ff d0                	call   *%rax
        brelse(bp);
ffff8000001022fe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102302:	48 89 c7             	mov    %rax,%rdi
ffff800000102305:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff80000010230c:	80 ff ff 
ffff80000010230f:	ff d0                	call   *%rax
        bzero(dev, b + bi);
ffff800000102311:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102314:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000102317:	01 c2                	add    %eax,%edx
ffff800000102319:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff80000010231c:	89 d6                	mov    %edx,%esi
ffff80000010231e:	89 c7                	mov    %eax,%edi
ffff800000102320:	48 b8 9e 21 10 00 00 	movabs $0xffff80000010219e,%rax
ffff800000102327:	80 ff ff 
ffff80000010232a:	ff d0                	call   *%rax
        return b + bi;
ffff80000010232c:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010232f:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000102332:	01 d0                	add    %edx,%eax
ffff800000102334:	eb 75                	jmp    ffff8000001023ab <balloc+0x195>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
ffff800000102336:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
ffff80000010233a:	81 7d f8 ff 0f 00 00 	cmpl   $0xfff,-0x8(%rbp)
ffff800000102341:	7f 1e                	jg     ffff800000102361 <balloc+0x14b>
ffff800000102343:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102346:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000102349:	01 d0                	add    %edx,%eax
ffff80000010234b:	89 c2                	mov    %eax,%edx
ffff80000010234d:	48 b8 00 46 11 00 00 	movabs $0xffff800000114600,%rax
ffff800000102354:	80 ff ff 
ffff800000102357:	8b 00                	mov    (%rax),%eax
ffff800000102359:	39 c2                	cmp    %eax,%edx
ffff80000010235b:	0f 82 15 ff ff ff    	jb     ffff800000102276 <balloc+0x60>
      }
    }
    brelse(bp);
ffff800000102361:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102365:	48 89 c7             	mov    %rax,%rdi
ffff800000102368:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff80000010236f:	80 ff ff 
ffff800000102372:	ff d0                	call   *%rax
  for(b = 0; b < sb.size; b += BPB){
ffff800000102374:	81 45 fc 00 10 00 00 	addl   $0x1000,-0x4(%rbp)
ffff80000010237b:	48 b8 00 46 11 00 00 	movabs $0xffff800000114600,%rax
ffff800000102382:	80 ff ff 
ffff800000102385:	8b 00                	mov    (%rax),%eax
ffff800000102387:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010238a:	39 c2                	cmp    %eax,%edx
ffff80000010238c:	0f 82 9f fe ff ff    	jb     ffff800000102231 <balloc+0x1b>
  }
  panic("balloc: out of blocks");
ffff800000102392:	48 b8 ed c4 10 00 00 	movabs $0xffff80000010c4ed,%rax
ffff800000102399:	80 ff ff 
ffff80000010239c:	48 89 c7             	mov    %rax,%rdi
ffff80000010239f:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff8000001023a6:	80 ff ff 
ffff8000001023a9:	ff d0                	call   *%rax
}
ffff8000001023ab:	c9                   	leave
ffff8000001023ac:	c3                   	ret

ffff8000001023ad <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
ffff8000001023ad:	f3 0f 1e fa          	endbr64
ffff8000001023b1:	55                   	push   %rbp
ffff8000001023b2:	48 89 e5             	mov    %rsp,%rbp
ffff8000001023b5:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001023b9:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff8000001023bc:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int bi, m;

  readsb(dev, &sb);
ffff8000001023bf:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001023c2:	48 ba 00 46 11 00 00 	movabs $0xffff800000114600,%rdx
ffff8000001023c9:	80 ff ff 
ffff8000001023cc:	48 89 d6             	mov    %rdx,%rsi
ffff8000001023cf:	89 c7                	mov    %eax,%edi
ffff8000001023d1:	48 b8 35 21 10 00 00 	movabs $0xffff800000102135,%rax
ffff8000001023d8:	80 ff ff 
ffff8000001023db:	ff d0                	call   *%rax
  struct buf *bp = bread(dev, BBLOCK(b, sb));
ffff8000001023dd:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff8000001023e0:	c1 e8 0c             	shr    $0xc,%eax
ffff8000001023e3:	89 c2                	mov    %eax,%edx
ffff8000001023e5:	48 b8 00 46 11 00 00 	movabs $0xffff800000114600,%rax
ffff8000001023ec:	80 ff ff 
ffff8000001023ef:	8b 40 18             	mov    0x18(%rax),%eax
ffff8000001023f2:	01 c2                	add    %eax,%edx
ffff8000001023f4:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001023f7:	89 d6                	mov    %edx,%esi
ffff8000001023f9:	89 c7                	mov    %eax,%edi
ffff8000001023fb:	48 b8 d4 03 10 00 00 	movabs $0xffff8000001003d4,%rax
ffff800000102402:	80 ff ff 
ffff800000102405:	ff d0                	call   *%rax
ffff800000102407:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  bi = b % BPB;
ffff80000010240b:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff80000010240e:	25 ff 0f 00 00       	and    $0xfff,%eax
ffff800000102413:	89 45 f4             	mov    %eax,-0xc(%rbp)
  m = 1 << (bi % 8);
ffff800000102416:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000102419:	83 e0 07             	and    $0x7,%eax
ffff80000010241c:	ba 01 00 00 00       	mov    $0x1,%edx
ffff800000102421:	89 c1                	mov    %eax,%ecx
ffff800000102423:	d3 e2                	shl    %cl,%edx
ffff800000102425:	89 d0                	mov    %edx,%eax
ffff800000102427:	89 45 f0             	mov    %eax,-0x10(%rbp)
  if((bp->data[bi/8] & m) == 0)
ffff80000010242a:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff80000010242d:	8d 50 07             	lea    0x7(%rax),%edx
ffff800000102430:	85 c0                	test   %eax,%eax
ffff800000102432:	0f 48 c2             	cmovs  %edx,%eax
ffff800000102435:	c1 f8 03             	sar    $0x3,%eax
ffff800000102438:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010243c:	48 98                	cltq
ffff80000010243e:	0f b6 84 02 b0 00 00 	movzbl 0xb0(%rdx,%rax,1),%eax
ffff800000102445:	00 
ffff800000102446:	0f b6 c0             	movzbl %al,%eax
ffff800000102449:	23 45 f0             	and    -0x10(%rbp),%eax
ffff80000010244c:	85 c0                	test   %eax,%eax
ffff80000010244e:	75 19                	jne    ffff800000102469 <bfree+0xbc>
    panic("freeing free block");
ffff800000102450:	48 b8 03 c5 10 00 00 	movabs $0xffff80000010c503,%rax
ffff800000102457:	80 ff ff 
ffff80000010245a:	48 89 c7             	mov    %rax,%rdi
ffff80000010245d:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000102464:	80 ff ff 
ffff800000102467:	ff d0                	call   *%rax
  bp->data[bi/8] &= ~m;
ffff800000102469:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff80000010246c:	8d 50 07             	lea    0x7(%rax),%edx
ffff80000010246f:	85 c0                	test   %eax,%eax
ffff800000102471:	0f 48 c2             	cmovs  %edx,%eax
ffff800000102474:	c1 f8 03             	sar    $0x3,%eax
ffff800000102477:	89 c1                	mov    %eax,%ecx
ffff800000102479:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010247d:	48 63 c1             	movslq %ecx,%rax
ffff800000102480:	0f b6 84 02 b0 00 00 	movzbl 0xb0(%rdx,%rax,1),%eax
ffff800000102487:	00 
ffff800000102488:	89 c2                	mov    %eax,%edx
ffff80000010248a:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff80000010248d:	f7 d0                	not    %eax
ffff80000010248f:	21 d0                	and    %edx,%eax
ffff800000102491:	89 c6                	mov    %eax,%esi
ffff800000102493:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000102497:	48 63 c1             	movslq %ecx,%rax
ffff80000010249a:	40 88 b4 02 b0 00 00 	mov    %sil,0xb0(%rdx,%rax,1)
ffff8000001024a1:	00 
  log_write(bp);
ffff8000001024a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001024a6:	48 89 c7             	mov    %rax,%rdi
ffff8000001024a9:	48 b8 0d 54 10 00 00 	movabs $0xffff80000010540d,%rax
ffff8000001024b0:	80 ff ff 
ffff8000001024b3:	ff d0                	call   *%rax
  brelse(bp);
ffff8000001024b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001024b9:	48 89 c7             	mov    %rax,%rdi
ffff8000001024bc:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff8000001024c3:	80 ff ff 
ffff8000001024c6:	ff d0                	call   *%rax
}
ffff8000001024c8:	90                   	nop
ffff8000001024c9:	c9                   	leave
ffff8000001024ca:	c3                   	ret

ffff8000001024cb <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
ffff8000001024cb:	f3 0f 1e fa          	endbr64
ffff8000001024cf:	55                   	push   %rbp
ffff8000001024d0:	48 89 e5             	mov    %rsp,%rbp
ffff8000001024d3:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001024d7:	89 7d ec             	mov    %edi,-0x14(%rbp)
  int i = 0;
ffff8000001024da:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)

  initlock(&icache.lock, "icache");
ffff8000001024e1:	48 b8 16 c5 10 00 00 	movabs $0xffff80000010c516,%rax
ffff8000001024e8:	80 ff ff 
ffff8000001024eb:	48 89 c6             	mov    %rax,%rsi
ffff8000001024ee:	48 b8 20 46 11 00 00 	movabs $0xffff800000114620,%rax
ffff8000001024f5:	80 ff ff 
ffff8000001024f8:	48 89 c7             	mov    %rax,%rdi
ffff8000001024fb:	48 b8 96 79 10 00 00 	movabs $0xffff800000107996,%rax
ffff800000102502:	80 ff ff 
ffff800000102505:	ff d0                	call   *%rax
  for(i = 0; i < NINODE; i++) {
ffff800000102507:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010250e:	eb 53                	jmp    ffff800000102563 <iinit+0x98>
    initsleeplock(&icache.inode[i].lock, "inode");
ffff800000102510:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102513:	48 63 d0             	movslq %eax,%rdx
ffff800000102516:	48 89 d0             	mov    %rdx,%rax
ffff800000102519:	48 01 c0             	add    %rax,%rax
ffff80000010251c:	48 01 d0             	add    %rdx,%rax
ffff80000010251f:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff800000102526:	00 
ffff800000102527:	48 01 d0             	add    %rdx,%rax
ffff80000010252a:	48 c1 e0 03          	shl    $0x3,%rax
ffff80000010252e:	48 8d 50 70          	lea    0x70(%rax),%rdx
ffff800000102532:	48 b8 20 46 11 00 00 	movabs $0xffff800000114620,%rax
ffff800000102539:	80 ff ff 
ffff80000010253c:	48 01 d0             	add    %rdx,%rax
ffff80000010253f:	48 83 c0 08          	add    $0x8,%rax
ffff800000102543:	48 ba 1d c5 10 00 00 	movabs $0xffff80000010c51d,%rdx
ffff80000010254a:	80 ff ff 
ffff80000010254d:	48 89 d6             	mov    %rdx,%rsi
ffff800000102550:	48 89 c7             	mov    %rax,%rdi
ffff800000102553:	48 b8 a0 77 10 00 00 	movabs $0xffff8000001077a0,%rax
ffff80000010255a:	80 ff ff 
ffff80000010255d:	ff d0                	call   *%rax
  for(i = 0; i < NINODE; i++) {
ffff80000010255f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000102563:	83 7d fc 31          	cmpl   $0x31,-0x4(%rbp)
ffff800000102567:	7e a7                	jle    ffff800000102510 <iinit+0x45>
  }

  readsb(dev, &sb);
ffff800000102569:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff80000010256c:	48 ba 00 46 11 00 00 	movabs $0xffff800000114600,%rdx
ffff800000102573:	80 ff ff 
ffff800000102576:	48 89 d6             	mov    %rdx,%rsi
ffff800000102579:	89 c7                	mov    %eax,%edi
ffff80000010257b:	48 b8 35 21 10 00 00 	movabs $0xffff800000102135,%rax
ffff800000102582:	80 ff ff 
ffff800000102585:	ff d0                	call   *%rax
  /*cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);*/
}
ffff800000102587:	90                   	nop
ffff800000102588:	c9                   	leave
ffff800000102589:	c3                   	ret

ffff80000010258a <ialloc>:

// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
ffff80000010258a:	f3 0f 1e fa          	endbr64
ffff80000010258e:	55                   	push   %rbp
ffff80000010258f:	48 89 e5             	mov    %rsp,%rbp
ffff800000102592:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000102596:	89 7d dc             	mov    %edi,-0x24(%rbp)
ffff800000102599:	89 f0                	mov    %esi,%eax
ffff80000010259b:	66 89 45 d8          	mov    %ax,-0x28(%rbp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
ffff80000010259f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
ffff8000001025a6:	e9 d8 00 00 00       	jmp    ffff800000102683 <ialloc+0xf9>
    bp = bread(dev, IBLOCK(inum, sb));
ffff8000001025ab:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001025ae:	48 98                	cltq
ffff8000001025b0:	48 c1 e8 03          	shr    $0x3,%rax
ffff8000001025b4:	89 c2                	mov    %eax,%edx
ffff8000001025b6:	48 b8 00 46 11 00 00 	movabs $0xffff800000114600,%rax
ffff8000001025bd:	80 ff ff 
ffff8000001025c0:	8b 40 14             	mov    0x14(%rax),%eax
ffff8000001025c3:	01 c2                	add    %eax,%edx
ffff8000001025c5:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff8000001025c8:	89 d6                	mov    %edx,%esi
ffff8000001025ca:	89 c7                	mov    %eax,%edi
ffff8000001025cc:	48 b8 d4 03 10 00 00 	movabs $0xffff8000001003d4,%rax
ffff8000001025d3:	80 ff ff 
ffff8000001025d6:	ff d0                	call   *%rax
ffff8000001025d8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    dip = (struct dinode*)bp->data + inum%IPB;
ffff8000001025dc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001025e0:	48 8d 90 b0 00 00 00 	lea    0xb0(%rax),%rdx
ffff8000001025e7:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001025ea:	48 98                	cltq
ffff8000001025ec:	83 e0 07             	and    $0x7,%eax
ffff8000001025ef:	48 c1 e0 06          	shl    $0x6,%rax
ffff8000001025f3:	48 01 d0             	add    %rdx,%rax
ffff8000001025f6:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if(dip->type == 0){  // a free inode
ffff8000001025fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001025fe:	0f b7 00             	movzwl (%rax),%eax
ffff800000102601:	66 85 c0             	test   %ax,%ax
ffff800000102604:	75 66                	jne    ffff80000010266c <ialloc+0xe2>
      memset(dip, 0, sizeof(*dip));
ffff800000102606:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010260a:	ba 40 00 00 00       	mov    $0x40,%edx
ffff80000010260f:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000102614:	48 89 c7             	mov    %rax,%rdi
ffff800000102617:	48 b8 87 7d 10 00 00 	movabs $0xffff800000107d87,%rax
ffff80000010261e:	80 ff ff 
ffff800000102621:	ff d0                	call   *%rax
      dip->type = type;
ffff800000102623:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102627:	0f b7 55 d8          	movzwl -0x28(%rbp),%edx
ffff80000010262b:	66 89 10             	mov    %dx,(%rax)
      log_write(bp);   // mark it allocated on the disk
ffff80000010262e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102632:	48 89 c7             	mov    %rax,%rdi
ffff800000102635:	48 b8 0d 54 10 00 00 	movabs $0xffff80000010540d,%rax
ffff80000010263c:	80 ff ff 
ffff80000010263f:	ff d0                	call   *%rax
      brelse(bp);
ffff800000102641:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102645:	48 89 c7             	mov    %rax,%rdi
ffff800000102648:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff80000010264f:	80 ff ff 
ffff800000102652:	ff d0                	call   *%rax
      return iget(dev, inum);
ffff800000102654:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102657:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff80000010265a:	89 d6                	mov    %edx,%esi
ffff80000010265c:	89 c7                	mov    %eax,%edi
ffff80000010265e:	48 b8 cc 27 10 00 00 	movabs $0xffff8000001027cc,%rax
ffff800000102665:	80 ff ff 
ffff800000102668:	ff d0                	call   *%rax
ffff80000010266a:	eb 48                	jmp    ffff8000001026b4 <ialloc+0x12a>
    }
    brelse(bp);
ffff80000010266c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102670:	48 89 c7             	mov    %rax,%rdi
ffff800000102673:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff80000010267a:	80 ff ff 
ffff80000010267d:	ff d0                	call   *%rax
  for(inum = 1; inum < sb.ninodes; inum++){
ffff80000010267f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000102683:	48 b8 00 46 11 00 00 	movabs $0xffff800000114600,%rax
ffff80000010268a:	80 ff ff 
ffff80000010268d:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000102690:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102693:	39 c2                	cmp    %eax,%edx
ffff800000102695:	0f 82 10 ff ff ff    	jb     ffff8000001025ab <ialloc+0x21>
  }
  panic("ialloc: no inodes");
ffff80000010269b:	48 b8 23 c5 10 00 00 	movabs $0xffff80000010c523,%rax
ffff8000001026a2:	80 ff ff 
ffff8000001026a5:	48 89 c7             	mov    %rax,%rdi
ffff8000001026a8:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff8000001026af:	80 ff ff 
ffff8000001026b2:	ff d0                	call   *%rax
}
ffff8000001026b4:	c9                   	leave
ffff8000001026b5:	c3                   	ret

ffff8000001026b6 <iupdate>:

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
ffff8000001026b6:	f3 0f 1e fa          	endbr64
ffff8000001026ba:	55                   	push   %rbp
ffff8000001026bb:	48 89 e5             	mov    %rsp,%rbp
ffff8000001026be:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001026c2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
ffff8000001026c6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001026ca:	8b 40 04             	mov    0x4(%rax),%eax
ffff8000001026cd:	c1 e8 03             	shr    $0x3,%eax
ffff8000001026d0:	89 c2                	mov    %eax,%edx
ffff8000001026d2:	48 b8 00 46 11 00 00 	movabs $0xffff800000114600,%rax
ffff8000001026d9:	80 ff ff 
ffff8000001026dc:	8b 40 14             	mov    0x14(%rax),%eax
ffff8000001026df:	01 c2                	add    %eax,%edx
ffff8000001026e1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001026e5:	8b 00                	mov    (%rax),%eax
ffff8000001026e7:	89 d6                	mov    %edx,%esi
ffff8000001026e9:	89 c7                	mov    %eax,%edi
ffff8000001026eb:	48 b8 d4 03 10 00 00 	movabs $0xffff8000001003d4,%rax
ffff8000001026f2:	80 ff ff 
ffff8000001026f5:	ff d0                	call   *%rax
ffff8000001026f7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
ffff8000001026fb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001026ff:	48 8d 90 b0 00 00 00 	lea    0xb0(%rax),%rdx
ffff800000102706:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010270a:	8b 40 04             	mov    0x4(%rax),%eax
ffff80000010270d:	89 c0                	mov    %eax,%eax
ffff80000010270f:	83 e0 07             	and    $0x7,%eax
ffff800000102712:	48 c1 e0 06          	shl    $0x6,%rax
ffff800000102716:	48 01 d0             	add    %rdx,%rax
ffff800000102719:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  dip->type = ip->type;
ffff80000010271d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102721:	0f b7 90 94 00 00 00 	movzwl 0x94(%rax),%edx
ffff800000102728:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010272c:	66 89 10             	mov    %dx,(%rax)
  dip->major = ip->major;
ffff80000010272f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102733:	0f b7 90 96 00 00 00 	movzwl 0x96(%rax),%edx
ffff80000010273a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010273e:	66 89 50 02          	mov    %dx,0x2(%rax)
  dip->minor = ip->minor;
ffff800000102742:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102746:	0f b7 90 98 00 00 00 	movzwl 0x98(%rax),%edx
ffff80000010274d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102751:	66 89 50 04          	mov    %dx,0x4(%rax)
  dip->nlink = ip->nlink;
ffff800000102755:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102759:	0f b7 90 9a 00 00 00 	movzwl 0x9a(%rax),%edx
ffff800000102760:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102764:	66 89 50 06          	mov    %dx,0x6(%rax)
  dip->size = ip->size;
ffff800000102768:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010276c:	8b 90 9c 00 00 00    	mov    0x9c(%rax),%edx
ffff800000102772:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102776:	89 50 08             	mov    %edx,0x8(%rax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
ffff800000102779:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010277d:	48 8d 88 a0 00 00 00 	lea    0xa0(%rax),%rcx
ffff800000102784:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102788:	48 83 c0 0c          	add    $0xc,%rax
ffff80000010278c:	ba 34 00 00 00       	mov    $0x34,%edx
ffff800000102791:	48 89 ce             	mov    %rcx,%rsi
ffff800000102794:	48 89 c7             	mov    %rax,%rdi
ffff800000102797:	48 b8 94 7e 10 00 00 	movabs $0xffff800000107e94,%rax
ffff80000010279e:	80 ff ff 
ffff8000001027a1:	ff d0                	call   *%rax
  log_write(bp);
ffff8000001027a3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001027a7:	48 89 c7             	mov    %rax,%rdi
ffff8000001027aa:	48 b8 0d 54 10 00 00 	movabs $0xffff80000010540d,%rax
ffff8000001027b1:	80 ff ff 
ffff8000001027b4:	ff d0                	call   *%rax
  brelse(bp);
ffff8000001027b6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001027ba:	48 89 c7             	mov    %rax,%rdi
ffff8000001027bd:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff8000001027c4:	80 ff ff 
ffff8000001027c7:	ff d0                	call   *%rax
}
ffff8000001027c9:	90                   	nop
ffff8000001027ca:	c9                   	leave
ffff8000001027cb:	c3                   	ret

ffff8000001027cc <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
ffff8000001027cc:	f3 0f 1e fa          	endbr64
ffff8000001027d0:	55                   	push   %rbp
ffff8000001027d1:	48 89 e5             	mov    %rsp,%rbp
ffff8000001027d4:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001027d8:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff8000001027db:	89 75 e8             	mov    %esi,-0x18(%rbp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
ffff8000001027de:	48 b8 20 46 11 00 00 	movabs $0xffff800000114620,%rax
ffff8000001027e5:	80 ff ff 
ffff8000001027e8:	48 89 c7             	mov    %rax,%rdi
ffff8000001027eb:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff8000001027f2:	80 ff ff 
ffff8000001027f5:	ff d0                	call   *%rax

  // Is the inode already cached?
  empty = 0;
ffff8000001027f7:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
ffff8000001027fe:	00 
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
ffff8000001027ff:	48 b8 88 46 11 00 00 	movabs $0xffff800000114688,%rax
ffff800000102806:	80 ff ff 
ffff800000102809:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010280d:	eb 77                	jmp    ffff800000102886 <iget+0xba>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
ffff80000010280f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102813:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000102816:	85 c0                	test   %eax,%eax
ffff800000102818:	7e 4a                	jle    ffff800000102864 <iget+0x98>
ffff80000010281a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010281e:	8b 00                	mov    (%rax),%eax
ffff800000102820:	39 45 ec             	cmp    %eax,-0x14(%rbp)
ffff800000102823:	75 3f                	jne    ffff800000102864 <iget+0x98>
ffff800000102825:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102829:	8b 40 04             	mov    0x4(%rax),%eax
ffff80000010282c:	39 45 e8             	cmp    %eax,-0x18(%rbp)
ffff80000010282f:	75 33                	jne    ffff800000102864 <iget+0x98>
      ip->ref++;
ffff800000102831:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102835:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000102838:	8d 50 01             	lea    0x1(%rax),%edx
ffff80000010283b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010283f:	89 50 08             	mov    %edx,0x8(%rax)
      release(&icache.lock);
ffff800000102842:	48 b8 20 46 11 00 00 	movabs $0xffff800000114620,%rax
ffff800000102849:	80 ff ff 
ffff80000010284c:	48 89 c7             	mov    %rax,%rdi
ffff80000010284f:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff800000102856:	80 ff ff 
ffff800000102859:	ff d0                	call   *%rax
      return ip;
ffff80000010285b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010285f:	e9 a7 00 00 00       	jmp    ffff80000010290b <iget+0x13f>
    }
    if(empty == 0 && ip->ref == 0) // Remember empty slot.
ffff800000102864:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000102869:	75 13                	jne    ffff80000010287e <iget+0xb2>
ffff80000010286b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010286f:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000102872:	85 c0                	test   %eax,%eax
ffff800000102874:	75 08                	jne    ffff80000010287e <iget+0xb2>
      empty = ip;
ffff800000102876:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010287a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
ffff80000010287e:	48 81 45 f8 d8 00 00 	addq   $0xd8,-0x8(%rbp)
ffff800000102885:	00 
ffff800000102886:	48 b8 b8 70 11 00 00 	movabs $0xffff8000001170b8,%rax
ffff80000010288d:	80 ff ff 
ffff800000102890:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000102894:	0f 82 75 ff ff ff    	jb     ffff80000010280f <iget+0x43>
  }

  // Recycle an inode cache entry.
  if(empty == 0)
ffff80000010289a:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010289f:	75 19                	jne    ffff8000001028ba <iget+0xee>
    panic("iget: no inodes");
ffff8000001028a1:	48 b8 35 c5 10 00 00 	movabs $0xffff80000010c535,%rax
ffff8000001028a8:	80 ff ff 
ffff8000001028ab:	48 89 c7             	mov    %rax,%rdi
ffff8000001028ae:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff8000001028b5:	80 ff ff 
ffff8000001028b8:	ff d0                	call   *%rax

  ip = empty;
ffff8000001028ba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001028be:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  ip->dev = dev;
ffff8000001028c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001028c6:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff8000001028c9:	89 10                	mov    %edx,(%rax)
  ip->inum = inum;
ffff8000001028cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001028cf:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffff8000001028d2:	89 50 04             	mov    %edx,0x4(%rax)
  ip->ref = 1;
ffff8000001028d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001028d9:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%rax)
  ip->flags = 0;
ffff8000001028e0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001028e4:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%rax)
ffff8000001028eb:	00 00 00 
  release(&icache.lock);
ffff8000001028ee:	48 b8 20 46 11 00 00 	movabs $0xffff800000114620,%rax
ffff8000001028f5:	80 ff ff 
ffff8000001028f8:	48 89 c7             	mov    %rax,%rdi
ffff8000001028fb:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff800000102902:	80 ff ff 
ffff800000102905:	ff d0                	call   *%rax

  return ip;
ffff800000102907:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff80000010290b:	c9                   	leave
ffff80000010290c:	c3                   	ret

ffff80000010290d <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
ffff80000010290d:	f3 0f 1e fa          	endbr64
ffff800000102911:	55                   	push   %rbp
ffff800000102912:	48 89 e5             	mov    %rsp,%rbp
ffff800000102915:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000102919:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&icache.lock);
ffff80000010291d:	48 b8 20 46 11 00 00 	movabs $0xffff800000114620,%rax
ffff800000102924:	80 ff ff 
ffff800000102927:	48 89 c7             	mov    %rax,%rdi
ffff80000010292a:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff800000102931:	80 ff ff 
ffff800000102934:	ff d0                	call   *%rax
  ip->ref++;
ffff800000102936:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010293a:	8b 40 08             	mov    0x8(%rax),%eax
ffff80000010293d:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000102940:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102944:	89 50 08             	mov    %edx,0x8(%rax)
  release(&icache.lock);
ffff800000102947:	48 b8 20 46 11 00 00 	movabs $0xffff800000114620,%rax
ffff80000010294e:	80 ff ff 
ffff800000102951:	48 89 c7             	mov    %rax,%rdi
ffff800000102954:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff80000010295b:	80 ff ff 
ffff80000010295e:	ff d0                	call   *%rax
  return ip;
ffff800000102960:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000102964:	c9                   	leave
ffff800000102965:	c3                   	ret

ffff800000102966 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
ffff800000102966:	f3 0f 1e fa          	endbr64
ffff80000010296a:	55                   	push   %rbp
ffff80000010296b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010296e:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000102972:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
ffff800000102976:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010297b:	74 0b                	je     ffff800000102988 <ilock+0x22>
ffff80000010297d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102981:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000102984:	85 c0                	test   %eax,%eax
ffff800000102986:	7f 19                	jg     ffff8000001029a1 <ilock+0x3b>
    panic("ilock");
ffff800000102988:	48 b8 45 c5 10 00 00 	movabs $0xffff80000010c545,%rax
ffff80000010298f:	80 ff ff 
ffff800000102992:	48 89 c7             	mov    %rax,%rdi
ffff800000102995:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010299c:	80 ff ff 
ffff80000010299f:	ff d0                	call   *%rax

  acquiresleep(&ip->lock);
ffff8000001029a1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001029a5:	48 83 c0 10          	add    $0x10,%rax
ffff8000001029a9:	48 89 c7             	mov    %rax,%rdi
ffff8000001029ac:	48 b8 fc 77 10 00 00 	movabs $0xffff8000001077fc,%rax
ffff8000001029b3:	80 ff ff 
ffff8000001029b6:	ff d0                	call   *%rax

  if(!(ip->flags & I_VALID)){
ffff8000001029b8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001029bc:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
ffff8000001029c2:	83 e0 02             	and    $0x2,%eax
ffff8000001029c5:	85 c0                	test   %eax,%eax
ffff8000001029c7:	0f 85 31 01 00 00    	jne    ffff800000102afe <ilock+0x198>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
ffff8000001029cd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001029d1:	8b 40 04             	mov    0x4(%rax),%eax
ffff8000001029d4:	c1 e8 03             	shr    $0x3,%eax
ffff8000001029d7:	89 c2                	mov    %eax,%edx
ffff8000001029d9:	48 b8 00 46 11 00 00 	movabs $0xffff800000114600,%rax
ffff8000001029e0:	80 ff ff 
ffff8000001029e3:	8b 40 14             	mov    0x14(%rax),%eax
ffff8000001029e6:	01 c2                	add    %eax,%edx
ffff8000001029e8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001029ec:	8b 00                	mov    (%rax),%eax
ffff8000001029ee:	89 d6                	mov    %edx,%esi
ffff8000001029f0:	89 c7                	mov    %eax,%edi
ffff8000001029f2:	48 b8 d4 03 10 00 00 	movabs $0xffff8000001003d4,%rax
ffff8000001029f9:	80 ff ff 
ffff8000001029fc:	ff d0                	call   *%rax
ffff8000001029fe:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
ffff800000102a02:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102a06:	48 8d 90 b0 00 00 00 	lea    0xb0(%rax),%rdx
ffff800000102a0d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102a11:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000102a14:	89 c0                	mov    %eax,%eax
ffff800000102a16:	83 e0 07             	and    $0x7,%eax
ffff800000102a19:	48 c1 e0 06          	shl    $0x6,%rax
ffff800000102a1d:	48 01 d0             	add    %rdx,%rax
ffff800000102a20:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    ip->type = dip->type;
ffff800000102a24:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102a28:	0f b7 10             	movzwl (%rax),%edx
ffff800000102a2b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102a2f:	66 89 90 94 00 00 00 	mov    %dx,0x94(%rax)
    ip->major = dip->major;
ffff800000102a36:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102a3a:	0f b7 50 02          	movzwl 0x2(%rax),%edx
ffff800000102a3e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102a42:	66 89 90 96 00 00 00 	mov    %dx,0x96(%rax)
    ip->minor = dip->minor;
ffff800000102a49:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102a4d:	0f b7 50 04          	movzwl 0x4(%rax),%edx
ffff800000102a51:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102a55:	66 89 90 98 00 00 00 	mov    %dx,0x98(%rax)
    ip->nlink = dip->nlink;
ffff800000102a5c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102a60:	0f b7 50 06          	movzwl 0x6(%rax),%edx
ffff800000102a64:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102a68:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
    ip->size = dip->size;
ffff800000102a6f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102a73:	8b 50 08             	mov    0x8(%rax),%edx
ffff800000102a76:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102a7a:	89 90 9c 00 00 00    	mov    %edx,0x9c(%rax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
ffff800000102a80:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102a84:	48 8d 48 0c          	lea    0xc(%rax),%rcx
ffff800000102a88:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102a8c:	48 05 a0 00 00 00    	add    $0xa0,%rax
ffff800000102a92:	ba 34 00 00 00       	mov    $0x34,%edx
ffff800000102a97:	48 89 ce             	mov    %rcx,%rsi
ffff800000102a9a:	48 89 c7             	mov    %rax,%rdi
ffff800000102a9d:	48 b8 94 7e 10 00 00 	movabs $0xffff800000107e94,%rax
ffff800000102aa4:	80 ff ff 
ffff800000102aa7:	ff d0                	call   *%rax
    brelse(bp);
ffff800000102aa9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102aad:	48 89 c7             	mov    %rax,%rdi
ffff800000102ab0:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff800000102ab7:	80 ff ff 
ffff800000102aba:	ff d0                	call   *%rax
    ip->flags |= I_VALID;
ffff800000102abc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102ac0:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
ffff800000102ac6:	83 c8 02             	or     $0x2,%eax
ffff800000102ac9:	89 c2                	mov    %eax,%edx
ffff800000102acb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102acf:	89 90 90 00 00 00    	mov    %edx,0x90(%rax)
    if(ip->type == 0)
ffff800000102ad5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102ad9:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000102ae0:	66 85 c0             	test   %ax,%ax
ffff800000102ae3:	75 19                	jne    ffff800000102afe <ilock+0x198>
      panic("ilock: no type");
ffff800000102ae5:	48 b8 4b c5 10 00 00 	movabs $0xffff80000010c54b,%rax
ffff800000102aec:	80 ff ff 
ffff800000102aef:	48 89 c7             	mov    %rax,%rdi
ffff800000102af2:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000102af9:	80 ff ff 
ffff800000102afc:	ff d0                	call   *%rax
  }
}
ffff800000102afe:	90                   	nop
ffff800000102aff:	c9                   	leave
ffff800000102b00:	c3                   	ret

ffff800000102b01 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
ffff800000102b01:	f3 0f 1e fa          	endbr64
ffff800000102b05:	55                   	push   %rbp
ffff800000102b06:	48 89 e5             	mov    %rsp,%rbp
ffff800000102b09:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000102b0d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
ffff800000102b11:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000102b16:	74 26                	je     ffff800000102b3e <iunlock+0x3d>
ffff800000102b18:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102b1c:	48 83 c0 10          	add    $0x10,%rax
ffff800000102b20:	48 89 c7             	mov    %rax,%rdi
ffff800000102b23:	48 b8 ef 78 10 00 00 	movabs $0xffff8000001078ef,%rax
ffff800000102b2a:	80 ff ff 
ffff800000102b2d:	ff d0                	call   *%rax
ffff800000102b2f:	85 c0                	test   %eax,%eax
ffff800000102b31:	74 0b                	je     ffff800000102b3e <iunlock+0x3d>
ffff800000102b33:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102b37:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000102b3a:	85 c0                	test   %eax,%eax
ffff800000102b3c:	7f 19                	jg     ffff800000102b57 <iunlock+0x56>
    panic("iunlock");
ffff800000102b3e:	48 b8 5a c5 10 00 00 	movabs $0xffff80000010c55a,%rax
ffff800000102b45:	80 ff ff 
ffff800000102b48:	48 89 c7             	mov    %rax,%rdi
ffff800000102b4b:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000102b52:	80 ff ff 
ffff800000102b55:	ff d0                	call   *%rax

  releasesleep(&ip->lock);
ffff800000102b57:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102b5b:	48 83 c0 10          	add    $0x10,%rax
ffff800000102b5f:	48 89 c7             	mov    %rax,%rdi
ffff800000102b62:	48 b8 86 78 10 00 00 	movabs $0xffff800000107886,%rax
ffff800000102b69:	80 ff ff 
ffff800000102b6c:	ff d0                	call   *%rax
}
ffff800000102b6e:	90                   	nop
ffff800000102b6f:	c9                   	leave
ffff800000102b70:	c3                   	ret

ffff800000102b71 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
ffff800000102b71:	f3 0f 1e fa          	endbr64
ffff800000102b75:	55                   	push   %rbp
ffff800000102b76:	48 89 e5             	mov    %rsp,%rbp
ffff800000102b79:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000102b7d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&icache.lock);
ffff800000102b81:	48 b8 20 46 11 00 00 	movabs $0xffff800000114620,%rax
ffff800000102b88:	80 ff ff 
ffff800000102b8b:	48 89 c7             	mov    %rax,%rdi
ffff800000102b8e:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff800000102b95:	80 ff ff 
ffff800000102b98:	ff d0                	call   *%rax
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
ffff800000102b9a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102b9e:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000102ba1:	83 f8 01             	cmp    $0x1,%eax
ffff800000102ba4:	0f 85 98 00 00 00    	jne    ffff800000102c42 <iput+0xd1>
ffff800000102baa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102bae:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
ffff800000102bb4:	83 e0 02             	and    $0x2,%eax
ffff800000102bb7:	85 c0                	test   %eax,%eax
ffff800000102bb9:	0f 84 83 00 00 00    	je     ffff800000102c42 <iput+0xd1>
ffff800000102bbf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102bc3:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff800000102bca:	66 85 c0             	test   %ax,%ax
ffff800000102bcd:	75 73                	jne    ffff800000102c42 <iput+0xd1>
    // inode has no links and no other references: truncate and free.
    release(&icache.lock);
ffff800000102bcf:	48 b8 20 46 11 00 00 	movabs $0xffff800000114620,%rax
ffff800000102bd6:	80 ff ff 
ffff800000102bd9:	48 89 c7             	mov    %rax,%rdi
ffff800000102bdc:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff800000102be3:	80 ff ff 
ffff800000102be6:	ff d0                	call   *%rax
    itrunc(ip);
ffff800000102be8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102bec:	48 89 c7             	mov    %rax,%rdi
ffff800000102bef:	48 b8 09 2e 10 00 00 	movabs $0xffff800000102e09,%rax
ffff800000102bf6:	80 ff ff 
ffff800000102bf9:	ff d0                	call   *%rax
    ip->type = 0;
ffff800000102bfb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102bff:	66 c7 80 94 00 00 00 	movw   $0x0,0x94(%rax)
ffff800000102c06:	00 00 
    iupdate(ip);
ffff800000102c08:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102c0c:	48 89 c7             	mov    %rax,%rdi
ffff800000102c0f:	48 b8 b6 26 10 00 00 	movabs $0xffff8000001026b6,%rax
ffff800000102c16:	80 ff ff 
ffff800000102c19:	ff d0                	call   *%rax
    acquire(&icache.lock);
ffff800000102c1b:	48 b8 20 46 11 00 00 	movabs $0xffff800000114620,%rax
ffff800000102c22:	80 ff ff 
ffff800000102c25:	48 89 c7             	mov    %rax,%rdi
ffff800000102c28:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff800000102c2f:	80 ff ff 
ffff800000102c32:	ff d0                	call   *%rax
    ip->flags = 0;
ffff800000102c34:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102c38:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%rax)
ffff800000102c3f:	00 00 00 
  }
  ip->ref--;
ffff800000102c42:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102c46:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000102c49:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000102c4c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102c50:	89 50 08             	mov    %edx,0x8(%rax)
  release(&icache.lock);
ffff800000102c53:	48 b8 20 46 11 00 00 	movabs $0xffff800000114620,%rax
ffff800000102c5a:	80 ff ff 
ffff800000102c5d:	48 89 c7             	mov    %rax,%rdi
ffff800000102c60:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff800000102c67:	80 ff ff 
ffff800000102c6a:	ff d0                	call   *%rax
}
ffff800000102c6c:	90                   	nop
ffff800000102c6d:	c9                   	leave
ffff800000102c6e:	c3                   	ret

ffff800000102c6f <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
ffff800000102c6f:	f3 0f 1e fa          	endbr64
ffff800000102c73:	55                   	push   %rbp
ffff800000102c74:	48 89 e5             	mov    %rsp,%rbp
ffff800000102c77:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000102c7b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  iunlock(ip);
ffff800000102c7f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102c83:	48 89 c7             	mov    %rax,%rdi
ffff800000102c86:	48 b8 01 2b 10 00 00 	movabs $0xffff800000102b01,%rax
ffff800000102c8d:	80 ff ff 
ffff800000102c90:	ff d0                	call   *%rax
  iput(ip);
ffff800000102c92:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102c96:	48 89 c7             	mov    %rax,%rdi
ffff800000102c99:	48 b8 71 2b 10 00 00 	movabs $0xffff800000102b71,%rax
ffff800000102ca0:	80 ff ff 
ffff800000102ca3:	ff d0                	call   *%rax
}
ffff800000102ca5:	90                   	nop
ffff800000102ca6:	c9                   	leave
ffff800000102ca7:	c3                   	ret

ffff800000102ca8 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
ffff800000102ca8:	f3 0f 1e fa          	endbr64
ffff800000102cac:	55                   	push   %rbp
ffff800000102cad:	48 89 e5             	mov    %rsp,%rbp
ffff800000102cb0:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000102cb4:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000102cb8:	89 75 d4             	mov    %esi,-0x2c(%rbp)
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
ffff800000102cbb:	83 7d d4 0b          	cmpl   $0xb,-0x2c(%rbp)
ffff800000102cbf:	77 47                	ja     ffff800000102d08 <bmap+0x60>
    if((addr = ip->addrs[bn]) == 0)
ffff800000102cc1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102cc5:	8b 55 d4             	mov    -0x2c(%rbp),%edx
ffff800000102cc8:	48 83 c2 28          	add    $0x28,%rdx
ffff800000102ccc:	8b 04 90             	mov    (%rax,%rdx,4),%eax
ffff800000102ccf:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000102cd2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000102cd6:	75 28                	jne    ffff800000102d00 <bmap+0x58>
      ip->addrs[bn] = addr = balloc(ip->dev);
ffff800000102cd8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102cdc:	8b 00                	mov    (%rax),%eax
ffff800000102cde:	89 c7                	mov    %eax,%edi
ffff800000102ce0:	48 b8 16 22 10 00 00 	movabs $0xffff800000102216,%rax
ffff800000102ce7:	80 ff ff 
ffff800000102cea:	ff d0                	call   *%rax
ffff800000102cec:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000102cef:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102cf3:	8b 55 d4             	mov    -0x2c(%rbp),%edx
ffff800000102cf6:	48 8d 4a 28          	lea    0x28(%rdx),%rcx
ffff800000102cfa:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102cfd:	89 14 88             	mov    %edx,(%rax,%rcx,4)
    return addr;
ffff800000102d00:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102d03:	e9 ff 00 00 00       	jmp    ffff800000102e07 <bmap+0x15f>
  }
  bn -= NDIRECT;
ffff800000102d08:	83 6d d4 0c          	subl   $0xc,-0x2c(%rbp)

  if(bn < NINDIRECT){
ffff800000102d0c:	83 7d d4 7f          	cmpl   $0x7f,-0x2c(%rbp)
ffff800000102d10:	0f 87 d8 00 00 00    	ja     ffff800000102dee <bmap+0x146>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
ffff800000102d16:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102d1a:	8b 80 d0 00 00 00    	mov    0xd0(%rax),%eax
ffff800000102d20:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000102d23:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000102d27:	75 24                	jne    ffff800000102d4d <bmap+0xa5>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
ffff800000102d29:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102d2d:	8b 00                	mov    (%rax),%eax
ffff800000102d2f:	89 c7                	mov    %eax,%edi
ffff800000102d31:	48 b8 16 22 10 00 00 	movabs $0xffff800000102216,%rax
ffff800000102d38:	80 ff ff 
ffff800000102d3b:	ff d0                	call   *%rax
ffff800000102d3d:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000102d40:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102d44:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102d47:	89 90 d0 00 00 00    	mov    %edx,0xd0(%rax)
    bp = bread(ip->dev, addr);
ffff800000102d4d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102d51:	8b 00                	mov    (%rax),%eax
ffff800000102d53:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102d56:	89 d6                	mov    %edx,%esi
ffff800000102d58:	89 c7                	mov    %eax,%edi
ffff800000102d5a:	48 b8 d4 03 10 00 00 	movabs $0xffff8000001003d4,%rax
ffff800000102d61:	80 ff ff 
ffff800000102d64:	ff d0                	call   *%rax
ffff800000102d66:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    a = (uint*)bp->data;
ffff800000102d6a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102d6e:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000102d74:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if((addr = a[bn]) == 0){
ffff800000102d78:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff800000102d7b:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff800000102d82:	00 
ffff800000102d83:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102d87:	48 01 d0             	add    %rdx,%rax
ffff800000102d8a:	8b 00                	mov    (%rax),%eax
ffff800000102d8c:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000102d8f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000102d93:	75 41                	jne    ffff800000102dd6 <bmap+0x12e>
      a[bn] = addr = balloc(ip->dev);
ffff800000102d95:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102d99:	8b 00                	mov    (%rax),%eax
ffff800000102d9b:	89 c7                	mov    %eax,%edi
ffff800000102d9d:	48 b8 16 22 10 00 00 	movabs $0xffff800000102216,%rax
ffff800000102da4:	80 ff ff 
ffff800000102da7:	ff d0                	call   *%rax
ffff800000102da9:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000102dac:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff800000102daf:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff800000102db6:	00 
ffff800000102db7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102dbb:	48 01 c2             	add    %rax,%rdx
ffff800000102dbe:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102dc1:	89 02                	mov    %eax,(%rdx)
      log_write(bp);
ffff800000102dc3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102dc7:	48 89 c7             	mov    %rax,%rdi
ffff800000102dca:	48 b8 0d 54 10 00 00 	movabs $0xffff80000010540d,%rax
ffff800000102dd1:	80 ff ff 
ffff800000102dd4:	ff d0                	call   *%rax
    }
    brelse(bp);
ffff800000102dd6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102dda:	48 89 c7             	mov    %rax,%rdi
ffff800000102ddd:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff800000102de4:	80 ff ff 
ffff800000102de7:	ff d0                	call   *%rax
    return addr;
ffff800000102de9:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102dec:	eb 19                	jmp    ffff800000102e07 <bmap+0x15f>
  }

  panic("bmap: out of range");
ffff800000102dee:	48 b8 62 c5 10 00 00 	movabs $0xffff80000010c562,%rax
ffff800000102df5:	80 ff ff 
ffff800000102df8:	48 89 c7             	mov    %rax,%rdi
ffff800000102dfb:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000102e02:	80 ff ff 
ffff800000102e05:	ff d0                	call   *%rax
}
ffff800000102e07:	c9                   	leave
ffff800000102e08:	c3                   	ret

ffff800000102e09 <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
ffff800000102e09:	f3 0f 1e fa          	endbr64
ffff800000102e0d:	55                   	push   %rbp
ffff800000102e0e:	48 89 e5             	mov    %rsp,%rbp
ffff800000102e11:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000102e15:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
ffff800000102e19:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000102e20:	eb 55                	jmp    ffff800000102e77 <itrunc+0x6e>
    if(ip->addrs[i]){
ffff800000102e22:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102e26:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102e29:	48 63 d2             	movslq %edx,%rdx
ffff800000102e2c:	48 83 c2 28          	add    $0x28,%rdx
ffff800000102e30:	8b 04 90             	mov    (%rax,%rdx,4),%eax
ffff800000102e33:	85 c0                	test   %eax,%eax
ffff800000102e35:	74 3c                	je     ffff800000102e73 <itrunc+0x6a>
      bfree(ip->dev, ip->addrs[i]);
ffff800000102e37:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102e3b:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102e3e:	48 63 d2             	movslq %edx,%rdx
ffff800000102e41:	48 83 c2 28          	add    $0x28,%rdx
ffff800000102e45:	8b 04 90             	mov    (%rax,%rdx,4),%eax
ffff800000102e48:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff800000102e4c:	8b 12                	mov    (%rdx),%edx
ffff800000102e4e:	89 c6                	mov    %eax,%esi
ffff800000102e50:	89 d7                	mov    %edx,%edi
ffff800000102e52:	48 b8 ad 23 10 00 00 	movabs $0xffff8000001023ad,%rax
ffff800000102e59:	80 ff ff 
ffff800000102e5c:	ff d0                	call   *%rax
      ip->addrs[i] = 0;
ffff800000102e5e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102e62:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102e65:	48 63 d2             	movslq %edx,%rdx
ffff800000102e68:	48 83 c2 28          	add    $0x28,%rdx
ffff800000102e6c:	c7 04 90 00 00 00 00 	movl   $0x0,(%rax,%rdx,4)
  for(i = 0; i < NDIRECT; i++){
ffff800000102e73:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000102e77:	83 7d fc 0b          	cmpl   $0xb,-0x4(%rbp)
ffff800000102e7b:	7e a5                	jle    ffff800000102e22 <itrunc+0x19>
    }
  }

  if(ip->addrs[NDIRECT]){
ffff800000102e7d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102e81:	8b 80 d0 00 00 00    	mov    0xd0(%rax),%eax
ffff800000102e87:	85 c0                	test   %eax,%eax
ffff800000102e89:	0f 84 ce 00 00 00    	je     ffff800000102f5d <itrunc+0x154>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
ffff800000102e8f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102e93:	8b 90 d0 00 00 00    	mov    0xd0(%rax),%edx
ffff800000102e99:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102e9d:	8b 00                	mov    (%rax),%eax
ffff800000102e9f:	89 d6                	mov    %edx,%esi
ffff800000102ea1:	89 c7                	mov    %eax,%edi
ffff800000102ea3:	48 b8 d4 03 10 00 00 	movabs $0xffff8000001003d4,%rax
ffff800000102eaa:	80 ff ff 
ffff800000102ead:	ff d0                	call   *%rax
ffff800000102eaf:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    a = (uint*)bp->data;
ffff800000102eb3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102eb7:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000102ebd:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for(j = 0; j < NINDIRECT; j++){
ffff800000102ec1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
ffff800000102ec8:	eb 4a                	jmp    ffff800000102f14 <itrunc+0x10b>
      if(a[j])
ffff800000102eca:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000102ecd:	48 98                	cltq
ffff800000102ecf:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff800000102ed6:	00 
ffff800000102ed7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102edb:	48 01 d0             	add    %rdx,%rax
ffff800000102ede:	8b 00                	mov    (%rax),%eax
ffff800000102ee0:	85 c0                	test   %eax,%eax
ffff800000102ee2:	74 2c                	je     ffff800000102f10 <itrunc+0x107>
        bfree(ip->dev, a[j]);
ffff800000102ee4:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000102ee7:	48 98                	cltq
ffff800000102ee9:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff800000102ef0:	00 
ffff800000102ef1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102ef5:	48 01 d0             	add    %rdx,%rax
ffff800000102ef8:	8b 00                	mov    (%rax),%eax
ffff800000102efa:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff800000102efe:	8b 12                	mov    (%rdx),%edx
ffff800000102f00:	89 c6                	mov    %eax,%esi
ffff800000102f02:	89 d7                	mov    %edx,%edi
ffff800000102f04:	48 b8 ad 23 10 00 00 	movabs $0xffff8000001023ad,%rax
ffff800000102f0b:	80 ff ff 
ffff800000102f0e:	ff d0                	call   *%rax
    for(j = 0; j < NINDIRECT; j++){
ffff800000102f10:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
ffff800000102f14:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000102f17:	83 f8 7f             	cmp    $0x7f,%eax
ffff800000102f1a:	76 ae                	jbe    ffff800000102eca <itrunc+0xc1>
    }
    brelse(bp);
ffff800000102f1c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102f20:	48 89 c7             	mov    %rax,%rdi
ffff800000102f23:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff800000102f2a:	80 ff ff 
ffff800000102f2d:	ff d0                	call   *%rax
    bfree(ip->dev, ip->addrs[NDIRECT]);
ffff800000102f2f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102f33:	8b 80 d0 00 00 00    	mov    0xd0(%rax),%eax
ffff800000102f39:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff800000102f3d:	8b 12                	mov    (%rdx),%edx
ffff800000102f3f:	89 c6                	mov    %eax,%esi
ffff800000102f41:	89 d7                	mov    %edx,%edi
ffff800000102f43:	48 b8 ad 23 10 00 00 	movabs $0xffff8000001023ad,%rax
ffff800000102f4a:	80 ff ff 
ffff800000102f4d:	ff d0                	call   *%rax
    ip->addrs[NDIRECT] = 0;
ffff800000102f4f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102f53:	c7 80 d0 00 00 00 00 	movl   $0x0,0xd0(%rax)
ffff800000102f5a:	00 00 00 
  }

  ip->size = 0;
ffff800000102f5d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102f61:	c7 80 9c 00 00 00 00 	movl   $0x0,0x9c(%rax)
ffff800000102f68:	00 00 00 
  iupdate(ip);
ffff800000102f6b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102f6f:	48 89 c7             	mov    %rax,%rdi
ffff800000102f72:	48 b8 b6 26 10 00 00 	movabs $0xffff8000001026b6,%rax
ffff800000102f79:	80 ff ff 
ffff800000102f7c:	ff d0                	call   *%rax
}
ffff800000102f7e:	90                   	nop
ffff800000102f7f:	c9                   	leave
ffff800000102f80:	c3                   	ret

ffff800000102f81 <stati>:

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
ffff800000102f81:	f3 0f 1e fa          	endbr64
ffff800000102f85:	55                   	push   %rbp
ffff800000102f86:	48 89 e5             	mov    %rsp,%rbp
ffff800000102f89:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000102f8d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000102f91:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  st->dev = ip->dev;
ffff800000102f95:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102f99:	8b 00                	mov    (%rax),%eax
ffff800000102f9b:	89 c2                	mov    %eax,%edx
ffff800000102f9d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102fa1:	89 50 04             	mov    %edx,0x4(%rax)
  st->ino = ip->inum;
ffff800000102fa4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102fa8:	8b 50 04             	mov    0x4(%rax),%edx
ffff800000102fab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102faf:	89 50 08             	mov    %edx,0x8(%rax)
  st->type = ip->type;
ffff800000102fb2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102fb6:	0f b7 90 94 00 00 00 	movzwl 0x94(%rax),%edx
ffff800000102fbd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102fc1:	66 89 10             	mov    %dx,(%rax)
  st->nlink = ip->nlink;
ffff800000102fc4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102fc8:	0f b7 90 9a 00 00 00 	movzwl 0x9a(%rax),%edx
ffff800000102fcf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102fd3:	66 89 50 0c          	mov    %dx,0xc(%rax)
  st->size = ip->size;
ffff800000102fd7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102fdb:	8b 90 9c 00 00 00    	mov    0x9c(%rax),%edx
ffff800000102fe1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102fe5:	89 50 10             	mov    %edx,0x10(%rax)
}
ffff800000102fe8:	90                   	nop
ffff800000102fe9:	c9                   	leave
ffff800000102fea:	c3                   	ret

ffff800000102feb <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
ffff800000102feb:	f3 0f 1e fa          	endbr64
ffff800000102fef:	55                   	push   %rbp
ffff800000102ff0:	48 89 e5             	mov    %rsp,%rbp
ffff800000102ff3:	48 83 ec 40          	sub    $0x40,%rsp
ffff800000102ff7:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000102ffb:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff800000102fff:	89 55 cc             	mov    %edx,-0x34(%rbp)
ffff800000103002:	89 4d c8             	mov    %ecx,-0x38(%rbp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
ffff800000103005:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103009:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000103010:	66 83 f8 03          	cmp    $0x3,%ax
ffff800000103014:	0f 85 8d 00 00 00    	jne    ffff8000001030a7 <readi+0xbc>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
ffff80000010301a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010301e:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff800000103025:	66 85 c0             	test   %ax,%ax
ffff800000103028:	78 38                	js     ffff800000103062 <readi+0x77>
ffff80000010302a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010302e:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff800000103035:	66 83 f8 09          	cmp    $0x9,%ax
ffff800000103039:	7f 27                	jg     ffff800000103062 <readi+0x77>
ffff80000010303b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010303f:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff800000103046:	98                   	cwtl
ffff800000103047:	48 ba 40 35 11 00 00 	movabs $0xffff800000113540,%rdx
ffff80000010304e:	80 ff ff 
ffff800000103051:	48 98                	cltq
ffff800000103053:	48 c1 e0 04          	shl    $0x4,%rax
ffff800000103057:	48 01 d0             	add    %rdx,%rax
ffff80000010305a:	48 8b 00             	mov    (%rax),%rax
ffff80000010305d:	48 85 c0             	test   %rax,%rax
ffff800000103060:	75 0a                	jne    ffff80000010306c <readi+0x81>
      return -1;
ffff800000103062:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000103067:	e9 4e 01 00 00       	jmp    ffff8000001031ba <readi+0x1cf>
    return devsw[ip->major].read(ip, off, dst, n);
ffff80000010306c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103070:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff800000103077:	98                   	cwtl
ffff800000103078:	48 ba 40 35 11 00 00 	movabs $0xffff800000113540,%rdx
ffff80000010307f:	80 ff ff 
ffff800000103082:	48 98                	cltq
ffff800000103084:	48 c1 e0 04          	shl    $0x4,%rax
ffff800000103088:	48 01 d0             	add    %rdx,%rax
ffff80000010308b:	4c 8b 00             	mov    (%rax),%r8
ffff80000010308e:	8b 4d c8             	mov    -0x38(%rbp),%ecx
ffff800000103091:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffff800000103095:	8b 75 cc             	mov    -0x34(%rbp),%esi
ffff800000103098:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010309c:	48 89 c7             	mov    %rax,%rdi
ffff80000010309f:	41 ff d0             	call   *%r8
ffff8000001030a2:	e9 13 01 00 00       	jmp    ffff8000001031ba <readi+0x1cf>
  }

  if(off > ip->size || off + n < off)
ffff8000001030a7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001030ab:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff8000001030b1:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffff8000001030b4:	72 0d                	jb     ffff8000001030c3 <readi+0xd8>
ffff8000001030b6:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffff8000001030b9:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff8000001030bc:	01 d0                	add    %edx,%eax
ffff8000001030be:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffff8000001030c1:	73 0a                	jae    ffff8000001030cd <readi+0xe2>
    return -1;
ffff8000001030c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001030c8:	e9 ed 00 00 00       	jmp    ffff8000001031ba <readi+0x1cf>
  if(off + n > ip->size)
ffff8000001030cd:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffff8000001030d0:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff8000001030d3:	01 c2                	add    %eax,%edx
ffff8000001030d5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001030d9:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff8000001030df:	39 d0                	cmp    %edx,%eax
ffff8000001030e1:	73 10                	jae    ffff8000001030f3 <readi+0x108>
    n = ip->size - off;
ffff8000001030e3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001030e7:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff8000001030ed:	2b 45 cc             	sub    -0x34(%rbp),%eax
ffff8000001030f0:	89 45 c8             	mov    %eax,-0x38(%rbp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
ffff8000001030f3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001030fa:	e9 ac 00 00 00       	jmp    ffff8000001031ab <readi+0x1c0>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
ffff8000001030ff:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff800000103102:	c1 e8 09             	shr    $0x9,%eax
ffff800000103105:	89 c2                	mov    %eax,%edx
ffff800000103107:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010310b:	89 d6                	mov    %edx,%esi
ffff80000010310d:	48 89 c7             	mov    %rax,%rdi
ffff800000103110:	48 b8 a8 2c 10 00 00 	movabs $0xffff800000102ca8,%rax
ffff800000103117:	80 ff ff 
ffff80000010311a:	ff d0                	call   *%rax
ffff80000010311c:	89 c2                	mov    %eax,%edx
ffff80000010311e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103122:	8b 00                	mov    (%rax),%eax
ffff800000103124:	89 d6                	mov    %edx,%esi
ffff800000103126:	89 c7                	mov    %eax,%edi
ffff800000103128:	48 b8 d4 03 10 00 00 	movabs $0xffff8000001003d4,%rax
ffff80000010312f:	80 ff ff 
ffff800000103132:	ff d0                	call   *%rax
ffff800000103134:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    m = min(n - tot, BSIZE - off%BSIZE);
ffff800000103138:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff80000010313b:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff800000103140:	ba 00 02 00 00       	mov    $0x200,%edx
ffff800000103145:	29 c2                	sub    %eax,%edx
ffff800000103147:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff80000010314a:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff80000010314d:	39 c2                	cmp    %eax,%edx
ffff80000010314f:	0f 46 c2             	cmovbe %edx,%eax
ffff800000103152:	89 45 ec             	mov    %eax,-0x14(%rbp)
    memmove(dst, bp->data + off%BSIZE, m);
ffff800000103155:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000103159:	48 8d 90 b0 00 00 00 	lea    0xb0(%rax),%rdx
ffff800000103160:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff800000103163:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff800000103168:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffff80000010316c:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff80000010316f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000103173:	48 89 ce             	mov    %rcx,%rsi
ffff800000103176:	48 89 c7             	mov    %rax,%rdi
ffff800000103179:	48 b8 94 7e 10 00 00 	movabs $0xffff800000107e94,%rax
ffff800000103180:	80 ff ff 
ffff800000103183:	ff d0                	call   *%rax
    brelse(bp);
ffff800000103185:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000103189:	48 89 c7             	mov    %rax,%rdi
ffff80000010318c:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff800000103193:	80 ff ff 
ffff800000103196:	ff d0                	call   *%rax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
ffff800000103198:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff80000010319b:	01 45 fc             	add    %eax,-0x4(%rbp)
ffff80000010319e:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001031a1:	01 45 cc             	add    %eax,-0x34(%rbp)
ffff8000001031a4:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001031a7:	48 01 45 d0          	add    %rax,-0x30(%rbp)
ffff8000001031ab:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001031ae:	3b 45 c8             	cmp    -0x38(%rbp),%eax
ffff8000001031b1:	0f 82 48 ff ff ff    	jb     ffff8000001030ff <readi+0x114>
  }
  return n;
ffff8000001031b7:	8b 45 c8             	mov    -0x38(%rbp),%eax
}
ffff8000001031ba:	c9                   	leave
ffff8000001031bb:	c3                   	ret

ffff8000001031bc <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
ffff8000001031bc:	f3 0f 1e fa          	endbr64
ffff8000001031c0:	55                   	push   %rbp
ffff8000001031c1:	48 89 e5             	mov    %rsp,%rbp
ffff8000001031c4:	48 83 ec 40          	sub    $0x40,%rsp
ffff8000001031c8:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff8000001031cc:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff8000001031d0:	89 55 cc             	mov    %edx,-0x34(%rbp)
ffff8000001031d3:	89 4d c8             	mov    %ecx,-0x38(%rbp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
ffff8000001031d6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001031da:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff8000001031e1:	66 83 f8 03          	cmp    $0x3,%ax
ffff8000001031e5:	0f 85 95 00 00 00    	jne    ffff800000103280 <writei+0xc4>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
ffff8000001031eb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001031ef:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff8000001031f6:	66 85 c0             	test   %ax,%ax
ffff8000001031f9:	78 3c                	js     ffff800000103237 <writei+0x7b>
ffff8000001031fb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001031ff:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff800000103206:	66 83 f8 09          	cmp    $0x9,%ax
ffff80000010320a:	7f 2b                	jg     ffff800000103237 <writei+0x7b>
ffff80000010320c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103210:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff800000103217:	98                   	cwtl
ffff800000103218:	48 ba 40 35 11 00 00 	movabs $0xffff800000113540,%rdx
ffff80000010321f:	80 ff ff 
ffff800000103222:	48 98                	cltq
ffff800000103224:	48 c1 e0 04          	shl    $0x4,%rax
ffff800000103228:	48 01 d0             	add    %rdx,%rax
ffff80000010322b:	48 83 c0 08          	add    $0x8,%rax
ffff80000010322f:	48 8b 00             	mov    (%rax),%rax
ffff800000103232:	48 85 c0             	test   %rax,%rax
ffff800000103235:	75 0a                	jne    ffff800000103241 <writei+0x85>
      return -1;
ffff800000103237:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010323c:	e9 8d 01 00 00       	jmp    ffff8000001033ce <writei+0x212>
    return devsw[ip->major].write(ip, off, src, n);
ffff800000103241:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103245:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff80000010324c:	98                   	cwtl
ffff80000010324d:	48 ba 40 35 11 00 00 	movabs $0xffff800000113540,%rdx
ffff800000103254:	80 ff ff 
ffff800000103257:	48 98                	cltq
ffff800000103259:	48 c1 e0 04          	shl    $0x4,%rax
ffff80000010325d:	48 01 d0             	add    %rdx,%rax
ffff800000103260:	48 83 c0 08          	add    $0x8,%rax
ffff800000103264:	4c 8b 00             	mov    (%rax),%r8
ffff800000103267:	8b 4d c8             	mov    -0x38(%rbp),%ecx
ffff80000010326a:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffff80000010326e:	8b 75 cc             	mov    -0x34(%rbp),%esi
ffff800000103271:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103275:	48 89 c7             	mov    %rax,%rdi
ffff800000103278:	41 ff d0             	call   *%r8
ffff80000010327b:	e9 4e 01 00 00       	jmp    ffff8000001033ce <writei+0x212>
  }

  if(off > ip->size || off + n < off)
ffff800000103280:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103284:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff80000010328a:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffff80000010328d:	72 0d                	jb     ffff80000010329c <writei+0xe0>
ffff80000010328f:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffff800000103292:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff800000103295:	01 d0                	add    %edx,%eax
ffff800000103297:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffff80000010329a:	73 0a                	jae    ffff8000001032a6 <writei+0xea>
    return -1;
ffff80000010329c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001032a1:	e9 28 01 00 00       	jmp    ffff8000001033ce <writei+0x212>
  if(off + n > MAXFILE*BSIZE)
ffff8000001032a6:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffff8000001032a9:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff8000001032ac:	01 d0                	add    %edx,%eax
ffff8000001032ae:	3d 00 18 01 00       	cmp    $0x11800,%eax
ffff8000001032b3:	76 0a                	jbe    ffff8000001032bf <writei+0x103>
    return -1;
ffff8000001032b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001032ba:	e9 0f 01 00 00       	jmp    ffff8000001033ce <writei+0x212>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
ffff8000001032bf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001032c6:	e9 bf 00 00 00       	jmp    ffff80000010338a <writei+0x1ce>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
ffff8000001032cb:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff8000001032ce:	c1 e8 09             	shr    $0x9,%eax
ffff8000001032d1:	89 c2                	mov    %eax,%edx
ffff8000001032d3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001032d7:	89 d6                	mov    %edx,%esi
ffff8000001032d9:	48 89 c7             	mov    %rax,%rdi
ffff8000001032dc:	48 b8 a8 2c 10 00 00 	movabs $0xffff800000102ca8,%rax
ffff8000001032e3:	80 ff ff 
ffff8000001032e6:	ff d0                	call   *%rax
ffff8000001032e8:	89 c2                	mov    %eax,%edx
ffff8000001032ea:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001032ee:	8b 00                	mov    (%rax),%eax
ffff8000001032f0:	89 d6                	mov    %edx,%esi
ffff8000001032f2:	89 c7                	mov    %eax,%edi
ffff8000001032f4:	48 b8 d4 03 10 00 00 	movabs $0xffff8000001003d4,%rax
ffff8000001032fb:	80 ff ff 
ffff8000001032fe:	ff d0                	call   *%rax
ffff800000103300:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    m = min(n - tot, BSIZE - off%BSIZE);
ffff800000103304:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff800000103307:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010330c:	ba 00 02 00 00       	mov    $0x200,%edx
ffff800000103311:	29 c2                	sub    %eax,%edx
ffff800000103313:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff800000103316:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff800000103319:	39 c2                	cmp    %eax,%edx
ffff80000010331b:	0f 46 c2             	cmovbe %edx,%eax
ffff80000010331e:	89 45 ec             	mov    %eax,-0x14(%rbp)
    memmove(bp->data + off%BSIZE, src, m);
ffff800000103321:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000103325:	48 8d 90 b0 00 00 00 	lea    0xb0(%rax),%rdx
ffff80000010332c:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff80000010332f:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff800000103334:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffff800000103338:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff80000010333b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010333f:	48 89 c6             	mov    %rax,%rsi
ffff800000103342:	48 89 cf             	mov    %rcx,%rdi
ffff800000103345:	48 b8 94 7e 10 00 00 	movabs $0xffff800000107e94,%rax
ffff80000010334c:	80 ff ff 
ffff80000010334f:	ff d0                	call   *%rax
    log_write(bp);
ffff800000103351:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000103355:	48 89 c7             	mov    %rax,%rdi
ffff800000103358:	48 b8 0d 54 10 00 00 	movabs $0xffff80000010540d,%rax
ffff80000010335f:	80 ff ff 
ffff800000103362:	ff d0                	call   *%rax
    brelse(bp);
ffff800000103364:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000103368:	48 89 c7             	mov    %rax,%rdi
ffff80000010336b:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff800000103372:	80 ff ff 
ffff800000103375:	ff d0                	call   *%rax
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
ffff800000103377:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff80000010337a:	01 45 fc             	add    %eax,-0x4(%rbp)
ffff80000010337d:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000103380:	01 45 cc             	add    %eax,-0x34(%rbp)
ffff800000103383:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000103386:	48 01 45 d0          	add    %rax,-0x30(%rbp)
ffff80000010338a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010338d:	3b 45 c8             	cmp    -0x38(%rbp),%eax
ffff800000103390:	0f 82 35 ff ff ff    	jb     ffff8000001032cb <writei+0x10f>
  }

  if(n > 0 && off > ip->size){
ffff800000103396:	83 7d c8 00          	cmpl   $0x0,-0x38(%rbp)
ffff80000010339a:	74 2f                	je     ffff8000001033cb <writei+0x20f>
ffff80000010339c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001033a0:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff8000001033a6:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffff8000001033a9:	73 20                	jae    ffff8000001033cb <writei+0x20f>
    ip->size = off;
ffff8000001033ab:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001033af:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffff8000001033b2:	89 90 9c 00 00 00    	mov    %edx,0x9c(%rax)
    iupdate(ip);
ffff8000001033b8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001033bc:	48 89 c7             	mov    %rax,%rdi
ffff8000001033bf:	48 b8 b6 26 10 00 00 	movabs $0xffff8000001026b6,%rax
ffff8000001033c6:	80 ff ff 
ffff8000001033c9:	ff d0                	call   *%rax
  }
  return n;
ffff8000001033cb:	8b 45 c8             	mov    -0x38(%rbp),%eax
}
ffff8000001033ce:	c9                   	leave
ffff8000001033cf:	c3                   	ret

ffff8000001033d0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
ffff8000001033d0:	f3 0f 1e fa          	endbr64
ffff8000001033d4:	55                   	push   %rbp
ffff8000001033d5:	48 89 e5             	mov    %rsp,%rbp
ffff8000001033d8:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001033dc:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff8000001033e0:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  return strncmp(s, t, DIRSIZ);
ffff8000001033e4:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffff8000001033e8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001033ec:	ba 0e 00 00 00       	mov    $0xe,%edx
ffff8000001033f1:	48 89 ce             	mov    %rcx,%rsi
ffff8000001033f4:	48 89 c7             	mov    %rax,%rdi
ffff8000001033f7:	48 b8 71 7f 10 00 00 	movabs $0xffff800000107f71,%rax
ffff8000001033fe:	80 ff ff 
ffff800000103401:	ff d0                	call   *%rax
}
ffff800000103403:	c9                   	leave
ffff800000103404:	c3                   	ret

ffff800000103405 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
ffff800000103405:	f3 0f 1e fa          	endbr64
ffff800000103409:	55                   	push   %rbp
ffff80000010340a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010340d:	48 83 ec 40          	sub    $0x40,%rsp
ffff800000103411:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000103415:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff800000103419:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
ffff80000010341d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103421:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000103428:	66 83 f8 01          	cmp    $0x1,%ax
ffff80000010342c:	74 19                	je     ffff800000103447 <dirlookup+0x42>
    panic("dirlookup not DIR");
ffff80000010342e:	48 b8 75 c5 10 00 00 	movabs $0xffff80000010c575,%rax
ffff800000103435:	80 ff ff 
ffff800000103438:	48 89 c7             	mov    %rax,%rdi
ffff80000010343b:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000103442:	80 ff ff 
ffff800000103445:	ff d0                	call   *%rax

  for(off = 0; off < dp->size; off += sizeof(de)){
ffff800000103447:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010344e:	e9 a2 00 00 00       	jmp    ffff8000001034f5 <dirlookup+0xf0>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffff800000103453:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000103456:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffff80000010345a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010345e:	b9 10 00 00 00       	mov    $0x10,%ecx
ffff800000103463:	48 89 c7             	mov    %rax,%rdi
ffff800000103466:	48 b8 eb 2f 10 00 00 	movabs $0xffff800000102feb,%rax
ffff80000010346d:	80 ff ff 
ffff800000103470:	ff d0                	call   *%rax
ffff800000103472:	83 f8 10             	cmp    $0x10,%eax
ffff800000103475:	74 19                	je     ffff800000103490 <dirlookup+0x8b>
      panic("dirlookup read");
ffff800000103477:	48 b8 87 c5 10 00 00 	movabs $0xffff80000010c587,%rax
ffff80000010347e:	80 ff ff 
ffff800000103481:	48 89 c7             	mov    %rax,%rdi
ffff800000103484:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010348b:	80 ff ff 
ffff80000010348e:	ff d0                	call   *%rax
    if(de.inum == 0)
ffff800000103490:	0f b7 45 e0          	movzwl -0x20(%rbp),%eax
ffff800000103494:	66 85 c0             	test   %ax,%ax
ffff800000103497:	74 57                	je     ffff8000001034f0 <dirlookup+0xeb>
      continue;
    if(namecmp(name, de.name) == 0){
ffff800000103499:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff80000010349d:	48 8d 50 02          	lea    0x2(%rax),%rdx
ffff8000001034a1:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff8000001034a5:	48 89 d6             	mov    %rdx,%rsi
ffff8000001034a8:	48 89 c7             	mov    %rax,%rdi
ffff8000001034ab:	48 b8 d0 33 10 00 00 	movabs $0xffff8000001033d0,%rax
ffff8000001034b2:	80 ff ff 
ffff8000001034b5:	ff d0                	call   *%rax
ffff8000001034b7:	85 c0                	test   %eax,%eax
ffff8000001034b9:	75 36                	jne    ffff8000001034f1 <dirlookup+0xec>
      // entry matches path element
      if(poff)
ffff8000001034bb:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
ffff8000001034c0:	74 09                	je     ffff8000001034cb <dirlookup+0xc6>
        *poff = off;
ffff8000001034c2:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff8000001034c6:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001034c9:	89 10                	mov    %edx,(%rax)
      inum = de.inum;
ffff8000001034cb:	0f b7 45 e0          	movzwl -0x20(%rbp),%eax
ffff8000001034cf:	0f b7 c0             	movzwl %ax,%eax
ffff8000001034d2:	89 45 f8             	mov    %eax,-0x8(%rbp)
      return iget(dp->dev, inum);
ffff8000001034d5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001034d9:	8b 00                	mov    (%rax),%eax
ffff8000001034db:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffff8000001034de:	89 d6                	mov    %edx,%esi
ffff8000001034e0:	89 c7                	mov    %eax,%edi
ffff8000001034e2:	48 b8 cc 27 10 00 00 	movabs $0xffff8000001027cc,%rax
ffff8000001034e9:	80 ff ff 
ffff8000001034ec:	ff d0                	call   *%rax
ffff8000001034ee:	eb 1d                	jmp    ffff80000010350d <dirlookup+0x108>
      continue;
ffff8000001034f0:	90                   	nop
  for(off = 0; off < dp->size; off += sizeof(de)){
ffff8000001034f1:	83 45 fc 10          	addl   $0x10,-0x4(%rbp)
ffff8000001034f5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001034f9:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff8000001034ff:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000103502:	0f 82 4b ff ff ff    	jb     ffff800000103453 <dirlookup+0x4e>
    }
  }

  return 0;
ffff800000103508:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010350d:	c9                   	leave
ffff80000010350e:	c3                   	ret

ffff80000010350f <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
ffff80000010350f:	f3 0f 1e fa          	endbr64
ffff800000103513:	55                   	push   %rbp
ffff800000103514:	48 89 e5             	mov    %rsp,%rbp
ffff800000103517:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010351b:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010351f:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff800000103523:	89 55 cc             	mov    %edx,-0x34(%rbp)
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
ffff800000103526:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
ffff80000010352a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010352e:	ba 00 00 00 00       	mov    $0x0,%edx
ffff800000103533:	48 89 ce             	mov    %rcx,%rsi
ffff800000103536:	48 89 c7             	mov    %rax,%rdi
ffff800000103539:	48 b8 05 34 10 00 00 	movabs $0xffff800000103405,%rax
ffff800000103540:	80 ff ff 
ffff800000103543:	ff d0                	call   *%rax
ffff800000103545:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000103549:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010354e:	74 1d                	je     ffff80000010356d <dirlink+0x5e>
    iput(ip);
ffff800000103550:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000103554:	48 89 c7             	mov    %rax,%rdi
ffff800000103557:	48 b8 71 2b 10 00 00 	movabs $0xffff800000102b71,%rax
ffff80000010355e:	80 ff ff 
ffff800000103561:	ff d0                	call   *%rax
    return -1;
ffff800000103563:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000103568:	e9 d8 00 00 00       	jmp    ffff800000103645 <dirlink+0x136>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
ffff80000010356d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000103574:	eb 4f                	jmp    ffff8000001035c5 <dirlink+0xb6>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffff800000103576:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000103579:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffff80000010357d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103581:	b9 10 00 00 00       	mov    $0x10,%ecx
ffff800000103586:	48 89 c7             	mov    %rax,%rdi
ffff800000103589:	48 b8 eb 2f 10 00 00 	movabs $0xffff800000102feb,%rax
ffff800000103590:	80 ff ff 
ffff800000103593:	ff d0                	call   *%rax
ffff800000103595:	83 f8 10             	cmp    $0x10,%eax
ffff800000103598:	74 19                	je     ffff8000001035b3 <dirlink+0xa4>
      panic("dirlink read");
ffff80000010359a:	48 b8 96 c5 10 00 00 	movabs $0xffff80000010c596,%rax
ffff8000001035a1:	80 ff ff 
ffff8000001035a4:	48 89 c7             	mov    %rax,%rdi
ffff8000001035a7:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff8000001035ae:	80 ff ff 
ffff8000001035b1:	ff d0                	call   *%rax
    if(de.inum == 0)
ffff8000001035b3:	0f b7 45 e0          	movzwl -0x20(%rbp),%eax
ffff8000001035b7:	66 85 c0             	test   %ax,%ax
ffff8000001035ba:	74 1c                	je     ffff8000001035d8 <dirlink+0xc9>
  for(off = 0; off < dp->size; off += sizeof(de)){
ffff8000001035bc:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001035bf:	83 c0 10             	add    $0x10,%eax
ffff8000001035c2:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff8000001035c5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001035c9:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff8000001035cf:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001035d2:	39 c2                	cmp    %eax,%edx
ffff8000001035d4:	72 a0                	jb     ffff800000103576 <dirlink+0x67>
ffff8000001035d6:	eb 01                	jmp    ffff8000001035d9 <dirlink+0xca>
      break;
ffff8000001035d8:	90                   	nop
  }

  strncpy(de.name, name, DIRSIZ);
ffff8000001035d9:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff8000001035dd:	48 8d 55 e0          	lea    -0x20(%rbp),%rdx
ffff8000001035e1:	48 8d 4a 02          	lea    0x2(%rdx),%rcx
ffff8000001035e5:	ba 0e 00 00 00       	mov    $0xe,%edx
ffff8000001035ea:	48 89 c6             	mov    %rax,%rsi
ffff8000001035ed:	48 89 cf             	mov    %rcx,%rdi
ffff8000001035f0:	48 b8 e2 7f 10 00 00 	movabs $0xffff800000107fe2,%rax
ffff8000001035f7:	80 ff ff 
ffff8000001035fa:	ff d0                	call   *%rax
  de.inum = inum;
ffff8000001035fc:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff8000001035ff:	66 89 45 e0          	mov    %ax,-0x20(%rbp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffff800000103603:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000103606:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffff80000010360a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010360e:	b9 10 00 00 00       	mov    $0x10,%ecx
ffff800000103613:	48 89 c7             	mov    %rax,%rdi
ffff800000103616:	48 b8 bc 31 10 00 00 	movabs $0xffff8000001031bc,%rax
ffff80000010361d:	80 ff ff 
ffff800000103620:	ff d0                	call   *%rax
ffff800000103622:	83 f8 10             	cmp    $0x10,%eax
ffff800000103625:	74 19                	je     ffff800000103640 <dirlink+0x131>
    panic("dirlink");
ffff800000103627:	48 b8 a3 c5 10 00 00 	movabs $0xffff80000010c5a3,%rax
ffff80000010362e:	80 ff ff 
ffff800000103631:	48 89 c7             	mov    %rax,%rdi
ffff800000103634:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010363b:	80 ff ff 
ffff80000010363e:	ff d0                	call   *%rax

  return 0;
ffff800000103640:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000103645:	c9                   	leave
ffff800000103646:	c3                   	ret

ffff800000103647 <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
ffff800000103647:	f3 0f 1e fa          	endbr64
ffff80000010364b:	55                   	push   %rbp
ffff80000010364c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010364f:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000103653:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000103657:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *s;
  int len;

  while(*path == '/')
ffff80000010365b:	eb 05                	jmp    ffff800000103662 <skipelem+0x1b>
    path++;
ffff80000010365d:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  while(*path == '/')
ffff800000103662:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103666:	0f b6 00             	movzbl (%rax),%eax
ffff800000103669:	3c 2f                	cmp    $0x2f,%al
ffff80000010366b:	74 f0                	je     ffff80000010365d <skipelem+0x16>
  if(*path == 0)
ffff80000010366d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103671:	0f b6 00             	movzbl (%rax),%eax
ffff800000103674:	84 c0                	test   %al,%al
ffff800000103676:	75 0a                	jne    ffff800000103682 <skipelem+0x3b>
    return 0;
ffff800000103678:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010367d:	e9 9a 00 00 00       	jmp    ffff80000010371c <skipelem+0xd5>
  s = path;
ffff800000103682:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103686:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while(*path != '/' && *path != 0)
ffff80000010368a:	eb 05                	jmp    ffff800000103691 <skipelem+0x4a>
    path++;
ffff80000010368c:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  while(*path != '/' && *path != 0)
ffff800000103691:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103695:	0f b6 00             	movzbl (%rax),%eax
ffff800000103698:	3c 2f                	cmp    $0x2f,%al
ffff80000010369a:	74 0b                	je     ffff8000001036a7 <skipelem+0x60>
ffff80000010369c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001036a0:	0f b6 00             	movzbl (%rax),%eax
ffff8000001036a3:	84 c0                	test   %al,%al
ffff8000001036a5:	75 e5                	jne    ffff80000010368c <skipelem+0x45>
  len = path - s;
ffff8000001036a7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001036ab:	48 2b 45 f8          	sub    -0x8(%rbp),%rax
ffff8000001036af:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(len >= DIRSIZ)
ffff8000001036b2:	83 7d f4 0d          	cmpl   $0xd,-0xc(%rbp)
ffff8000001036b6:	7e 21                	jle    ffff8000001036d9 <skipelem+0x92>
    memmove(name, s, DIRSIZ);
ffff8000001036b8:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff8000001036bc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001036c0:	ba 0e 00 00 00       	mov    $0xe,%edx
ffff8000001036c5:	48 89 ce             	mov    %rcx,%rsi
ffff8000001036c8:	48 89 c7             	mov    %rax,%rdi
ffff8000001036cb:	48 b8 94 7e 10 00 00 	movabs $0xffff800000107e94,%rax
ffff8000001036d2:	80 ff ff 
ffff8000001036d5:	ff d0                	call   *%rax
ffff8000001036d7:	eb 34                	jmp    ffff80000010370d <skipelem+0xc6>
  else {
    memmove(name, s, len);
ffff8000001036d9:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff8000001036dc:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff8000001036e0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001036e4:	48 89 ce             	mov    %rcx,%rsi
ffff8000001036e7:	48 89 c7             	mov    %rax,%rdi
ffff8000001036ea:	48 b8 94 7e 10 00 00 	movabs $0xffff800000107e94,%rax
ffff8000001036f1:	80 ff ff 
ffff8000001036f4:	ff d0                	call   *%rax
    name[len] = 0;
ffff8000001036f6:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff8000001036f9:	48 63 d0             	movslq %eax,%rdx
ffff8000001036fc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000103700:	48 01 d0             	add    %rdx,%rax
ffff800000103703:	c6 00 00             	movb   $0x0,(%rax)
  }
  while(*path == '/')
ffff800000103706:	eb 05                	jmp    ffff80000010370d <skipelem+0xc6>
    path++;
ffff800000103708:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  while(*path == '/')
ffff80000010370d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103711:	0f b6 00             	movzbl (%rax),%eax
ffff800000103714:	3c 2f                	cmp    $0x2f,%al
ffff800000103716:	74 f0                	je     ffff800000103708 <skipelem+0xc1>
  return path;
ffff800000103718:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
ffff80000010371c:	c9                   	leave
ffff80000010371d:	c3                   	ret

ffff80000010371e <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
ffff80000010371e:	f3 0f 1e fa          	endbr64
ffff800000103722:	55                   	push   %rbp
ffff800000103723:	48 89 e5             	mov    %rsp,%rbp
ffff800000103726:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010372a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010372e:	89 75 e4             	mov    %esi,-0x1c(%rbp)
ffff800000103731:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  struct inode *ip, *next;

  if(*path == '/')
ffff800000103735:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103739:	0f b6 00             	movzbl (%rax),%eax
ffff80000010373c:	3c 2f                	cmp    $0x2f,%al
ffff80000010373e:	75 1f                	jne    ffff80000010375f <namex+0x41>
    ip = iget(ROOTDEV, ROOTINO);
ffff800000103740:	be 01 00 00 00       	mov    $0x1,%esi
ffff800000103745:	bf 01 00 00 00       	mov    $0x1,%edi
ffff80000010374a:	48 b8 cc 27 10 00 00 	movabs $0xffff8000001027cc,%rax
ffff800000103751:	80 ff ff 
ffff800000103754:	ff d0                	call   *%rax
ffff800000103756:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010375a:	e9 f7 00 00 00       	jmp    ffff800000103856 <namex+0x138>
  else
    ip = idup(proc->cwd);
ffff80000010375f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000103766:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010376a:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffff800000103771:	48 89 c7             	mov    %rax,%rdi
ffff800000103774:	48 b8 0d 29 10 00 00 	movabs $0xffff80000010290d,%rax
ffff80000010377b:	80 ff ff 
ffff80000010377e:	ff d0                	call   *%rax
ffff800000103780:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  while((path = skipelem(path, name)) != 0){
ffff800000103784:	e9 cd 00 00 00       	jmp    ffff800000103856 <namex+0x138>
    ilock(ip);
ffff800000103789:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010378d:	48 89 c7             	mov    %rax,%rdi
ffff800000103790:	48 b8 66 29 10 00 00 	movabs $0xffff800000102966,%rax
ffff800000103797:	80 ff ff 
ffff80000010379a:	ff d0                	call   *%rax
    if(ip->type != T_DIR){
ffff80000010379c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001037a0:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff8000001037a7:	66 83 f8 01          	cmp    $0x1,%ax
ffff8000001037ab:	74 1d                	je     ffff8000001037ca <namex+0xac>
      iunlockput(ip);
ffff8000001037ad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001037b1:	48 89 c7             	mov    %rax,%rdi
ffff8000001037b4:	48 b8 6f 2c 10 00 00 	movabs $0xffff800000102c6f,%rax
ffff8000001037bb:	80 ff ff 
ffff8000001037be:	ff d0                	call   *%rax
      return 0;
ffff8000001037c0:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001037c5:	e9 d9 00 00 00       	jmp    ffff8000001038a3 <namex+0x185>
    }
    if(nameiparent && *path == '\0'){
ffff8000001037ca:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
ffff8000001037ce:	74 27                	je     ffff8000001037f7 <namex+0xd9>
ffff8000001037d0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001037d4:	0f b6 00             	movzbl (%rax),%eax
ffff8000001037d7:	84 c0                	test   %al,%al
ffff8000001037d9:	75 1c                	jne    ffff8000001037f7 <namex+0xd9>
      iunlock(ip);  // Stop one level early.
ffff8000001037db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001037df:	48 89 c7             	mov    %rax,%rdi
ffff8000001037e2:	48 b8 01 2b 10 00 00 	movabs $0xffff800000102b01,%rax
ffff8000001037e9:	80 ff ff 
ffff8000001037ec:	ff d0                	call   *%rax
      return ip;
ffff8000001037ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001037f2:	e9 ac 00 00 00       	jmp    ffff8000001038a3 <namex+0x185>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
ffff8000001037f7:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff8000001037fb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001037ff:	ba 00 00 00 00       	mov    $0x0,%edx
ffff800000103804:	48 89 ce             	mov    %rcx,%rsi
ffff800000103807:	48 89 c7             	mov    %rax,%rdi
ffff80000010380a:	48 b8 05 34 10 00 00 	movabs $0xffff800000103405,%rax
ffff800000103811:	80 ff ff 
ffff800000103814:	ff d0                	call   *%rax
ffff800000103816:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010381a:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010381f:	75 1a                	jne    ffff80000010383b <namex+0x11d>
      iunlockput(ip);
ffff800000103821:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103825:	48 89 c7             	mov    %rax,%rdi
ffff800000103828:	48 b8 6f 2c 10 00 00 	movabs $0xffff800000102c6f,%rax
ffff80000010382f:	80 ff ff 
ffff800000103832:	ff d0                	call   *%rax
      return 0;
ffff800000103834:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000103839:	eb 68                	jmp    ffff8000001038a3 <namex+0x185>
    }
    iunlockput(ip);
ffff80000010383b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010383f:	48 89 c7             	mov    %rax,%rdi
ffff800000103842:	48 b8 6f 2c 10 00 00 	movabs $0xffff800000102c6f,%rax
ffff800000103849:	80 ff ff 
ffff80000010384c:	ff d0                	call   *%rax
    ip = next;
ffff80000010384e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000103852:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((path = skipelem(path, name)) != 0){
ffff800000103856:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010385a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010385e:	48 89 d6             	mov    %rdx,%rsi
ffff800000103861:	48 89 c7             	mov    %rax,%rdi
ffff800000103864:	48 b8 47 36 10 00 00 	movabs $0xffff800000103647,%rax
ffff80000010386b:	80 ff ff 
ffff80000010386e:	ff d0                	call   *%rax
ffff800000103870:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000103874:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff800000103879:	0f 85 0a ff ff ff    	jne    ffff800000103789 <namex+0x6b>
  }
  if(nameiparent){
ffff80000010387f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
ffff800000103883:	74 1a                	je     ffff80000010389f <namex+0x181>
    iput(ip);
ffff800000103885:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103889:	48 89 c7             	mov    %rax,%rdi
ffff80000010388c:	48 b8 71 2b 10 00 00 	movabs $0xffff800000102b71,%rax
ffff800000103893:	80 ff ff 
ffff800000103896:	ff d0                	call   *%rax
    return 0;
ffff800000103898:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010389d:	eb 04                	jmp    ffff8000001038a3 <namex+0x185>
  }
  return ip;
ffff80000010389f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff8000001038a3:	c9                   	leave
ffff8000001038a4:	c3                   	ret

ffff8000001038a5 <namei>:

struct inode*
namei(char *path)
{
ffff8000001038a5:	f3 0f 1e fa          	endbr64
ffff8000001038a9:	55                   	push   %rbp
ffff8000001038aa:	48 89 e5             	mov    %rsp,%rbp
ffff8000001038ad:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001038b1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  char name[DIRSIZ];
  return namex(path, 0, name);
ffff8000001038b5:	48 8d 55 f2          	lea    -0xe(%rbp),%rdx
ffff8000001038b9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001038bd:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001038c2:	48 89 c7             	mov    %rax,%rdi
ffff8000001038c5:	48 b8 1e 37 10 00 00 	movabs $0xffff80000010371e,%rax
ffff8000001038cc:	80 ff ff 
ffff8000001038cf:	ff d0                	call   *%rax
}
ffff8000001038d1:	c9                   	leave
ffff8000001038d2:	c3                   	ret

ffff8000001038d3 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
ffff8000001038d3:	f3 0f 1e fa          	endbr64
ffff8000001038d7:	55                   	push   %rbp
ffff8000001038d8:	48 89 e5             	mov    %rsp,%rbp
ffff8000001038db:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001038df:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff8000001038e3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  return namex(path, 1, name);
ffff8000001038e7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff8000001038eb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001038ef:	be 01 00 00 00       	mov    $0x1,%esi
ffff8000001038f4:	48 89 c7             	mov    %rax,%rdi
ffff8000001038f7:	48 b8 1e 37 10 00 00 	movabs $0xffff80000010371e,%rax
ffff8000001038fe:	80 ff ff 
ffff800000103901:	ff d0                	call   *%rax
}
ffff800000103903:	c9                   	leave
ffff800000103904:	c3                   	ret

ffff800000103905 <inb>:
// Simple PIO-based (non-DMA) IDE driver code.

#include "types.h"
#include "defs.h"
#include "param.h"
ffff800000103905:	f3 0f 1e fa          	endbr64
ffff800000103909:	55                   	push   %rbp
ffff80000010390a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010390d:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000103911:	89 f8                	mov    %edi,%eax
ffff800000103913:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
ffff800000103917:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff80000010391b:	89 c2                	mov    %eax,%edx
ffff80000010391d:	ec                   	in     (%dx),%al
ffff80000010391e:	88 45 ff             	mov    %al,-0x1(%rbp)
#include "x86.h"
ffff800000103921:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
#include "traps.h"
ffff800000103925:	c9                   	leave
ffff800000103926:	c3                   	ret

ffff800000103927 <insl>:
#include "spinlock.h"
#include "sleeplock.h"
#include "fs.h"
#include "buf.h"
ffff800000103927:	f3 0f 1e fa          	endbr64
ffff80000010392b:	55                   	push   %rbp
ffff80000010392c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010392f:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000103933:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff800000103936:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff80000010393a:	89 55 f8             	mov    %edx,-0x8(%rbp)

ffff80000010393d:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000103940:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffff800000103944:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000103947:	48 89 ce             	mov    %rcx,%rsi
ffff80000010394a:	48 89 f7             	mov    %rsi,%rdi
ffff80000010394d:	89 c1                	mov    %eax,%ecx
ffff80000010394f:	fc                   	cld
ffff800000103950:	f3 6d                	rep insl (%dx),%es:(%rdi)
ffff800000103952:	89 c8                	mov    %ecx,%eax
ffff800000103954:	48 89 fe             	mov    %rdi,%rsi
ffff800000103957:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff80000010395b:	89 45 f8             	mov    %eax,-0x8(%rbp)
#define SECTOR_SIZE   512
#define IDE_BSY       0x80
#define IDE_DRDY      0x40
#define IDE_DF        0x20
ffff80000010395e:	90                   	nop
ffff80000010395f:	c9                   	leave
ffff800000103960:	c3                   	ret

ffff800000103961 <outb>:
#define IDE_ERR       0x01

#define IDE_CMD_READ  0x20
#define IDE_CMD_WRITE 0x30
ffff800000103961:	f3 0f 1e fa          	endbr64
ffff800000103965:	55                   	push   %rbp
ffff800000103966:	48 89 e5             	mov    %rsp,%rbp
ffff800000103969:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010396d:	89 fa                	mov    %edi,%edx
ffff80000010396f:	89 f0                	mov    %esi,%eax
ffff800000103971:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffff800000103975:	88 45 f8             	mov    %al,-0x8(%rbp)
#define IDE_CMD_RDMUL 0xc4
ffff800000103978:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffff80000010397c:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffff800000103980:	ee                   	out    %al,(%dx)
#define IDE_CMD_WRMUL 0xc5
ffff800000103981:	90                   	nop
ffff800000103982:	c9                   	leave
ffff800000103983:	c3                   	ret

ffff800000103984 <outsl>:

static struct spinlock idelock;
static struct buf *idequeue;

static int havedisk1;
static void idestart(struct buf*);
ffff800000103984:	f3 0f 1e fa          	endbr64
ffff800000103988:	55                   	push   %rbp
ffff800000103989:	48 89 e5             	mov    %rsp,%rbp
ffff80000010398c:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000103990:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff800000103993:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff800000103997:	89 55 f8             	mov    %edx,-0x8(%rbp)

ffff80000010399a:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010399d:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffff8000001039a1:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff8000001039a4:	48 89 ce             	mov    %rcx,%rsi
ffff8000001039a7:	89 c1                	mov    %eax,%ecx
ffff8000001039a9:	fc                   	cld
ffff8000001039aa:	f3 6f                	rep outsl %ds:(%rsi),(%dx)
ffff8000001039ac:	89 c8                	mov    %ecx,%eax
ffff8000001039ae:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff8000001039b2:	89 45 f8             	mov    %eax,-0x8(%rbp)
// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
ffff8000001039b5:	90                   	nop
ffff8000001039b6:	c9                   	leave
ffff8000001039b7:	c3                   	ret

ffff8000001039b8 <idewait>:
ffff8000001039b8:	f3 0f 1e fa          	endbr64
ffff8000001039bc:	55                   	push   %rbp
ffff8000001039bd:	48 89 e5             	mov    %rsp,%rbp
ffff8000001039c0:	48 83 ec 18          	sub    $0x18,%rsp
ffff8000001039c4:	89 7d ec             	mov    %edi,-0x14(%rbp)
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
ffff8000001039c7:	90                   	nop
ffff8000001039c8:	bf f7 01 00 00       	mov    $0x1f7,%edi
ffff8000001039cd:	48 b8 05 39 10 00 00 	movabs $0xffff800000103905,%rax
ffff8000001039d4:	80 ff ff 
ffff8000001039d7:	ff d0                	call   *%rax
ffff8000001039d9:	0f b6 c0             	movzbl %al,%eax
ffff8000001039dc:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff8000001039df:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001039e2:	25 c0 00 00 00       	and    $0xc0,%eax
ffff8000001039e7:	83 f8 40             	cmp    $0x40,%eax
ffff8000001039ea:	75 dc                	jne    ffff8000001039c8 <idewait+0x10>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
ffff8000001039ec:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffff8000001039f0:	74 11                	je     ffff800000103a03 <idewait+0x4b>
ffff8000001039f2:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001039f5:	83 e0 21             	and    $0x21,%eax
ffff8000001039f8:	85 c0                	test   %eax,%eax
ffff8000001039fa:	74 07                	je     ffff800000103a03 <idewait+0x4b>
    return -1;
ffff8000001039fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000103a01:	eb 05                	jmp    ffff800000103a08 <idewait+0x50>
  return 0;
ffff800000103a03:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000103a08:	c9                   	leave
ffff800000103a09:	c3                   	ret

ffff800000103a0a <ideinit>:

void
ideinit(void)
{
ffff800000103a0a:	f3 0f 1e fa          	endbr64
ffff800000103a0e:	55                   	push   %rbp
ffff800000103a0f:	48 89 e5             	mov    %rsp,%rbp
ffff800000103a12:	48 83 ec 10          	sub    $0x10,%rsp
  initlock(&idelock, "ide");
ffff800000103a16:	48 b8 ab c5 10 00 00 	movabs $0xffff80000010c5ab,%rax
ffff800000103a1d:	80 ff ff 
ffff800000103a20:	48 89 c6             	mov    %rax,%rsi
ffff800000103a23:	48 b8 c0 70 11 00 00 	movabs $0xffff8000001170c0,%rax
ffff800000103a2a:	80 ff ff 
ffff800000103a2d:	48 89 c7             	mov    %rax,%rdi
ffff800000103a30:	48 b8 96 79 10 00 00 	movabs $0xffff800000107996,%rax
ffff800000103a37:	80 ff ff 
ffff800000103a3a:	ff d0                	call   *%rax
  ioapicenable(IRQ_IDE, ncpu - 1);
ffff800000103a3c:	48 b8 20 74 11 00 00 	movabs $0xffff800000117420,%rax
ffff800000103a43:	80 ff ff 
ffff800000103a46:	8b 00                	mov    (%rax),%eax
ffff800000103a48:	83 e8 01             	sub    $0x1,%eax
ffff800000103a4b:	89 c6                	mov    %eax,%esi
ffff800000103a4d:	bf 0e 00 00 00       	mov    $0xe,%edi
ffff800000103a52:	48 b8 b6 40 10 00 00 	movabs $0xffff8000001040b6,%rax
ffff800000103a59:	80 ff ff 
ffff800000103a5c:	ff d0                	call   *%rax
  idewait(0);
ffff800000103a5e:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000103a63:	48 b8 b8 39 10 00 00 	movabs $0xffff8000001039b8,%rax
ffff800000103a6a:	80 ff ff 
ffff800000103a6d:	ff d0                	call   *%rax

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
ffff800000103a6f:	be f0 00 00 00       	mov    $0xf0,%esi
ffff800000103a74:	bf f6 01 00 00       	mov    $0x1f6,%edi
ffff800000103a79:	48 b8 61 39 10 00 00 	movabs $0xffff800000103961,%rax
ffff800000103a80:	80 ff ff 
ffff800000103a83:	ff d0                	call   *%rax
  for(int i=0; i<1000; i++){
ffff800000103a85:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000103a8c:	eb 2b                	jmp    ffff800000103ab9 <ideinit+0xaf>
    if(inb(0x1f7) != 0){
ffff800000103a8e:	bf f7 01 00 00       	mov    $0x1f7,%edi
ffff800000103a93:	48 b8 05 39 10 00 00 	movabs $0xffff800000103905,%rax
ffff800000103a9a:	80 ff ff 
ffff800000103a9d:	ff d0                	call   *%rax
ffff800000103a9f:	84 c0                	test   %al,%al
ffff800000103aa1:	74 12                	je     ffff800000103ab5 <ideinit+0xab>
      havedisk1 = 1;
ffff800000103aa3:	48 b8 30 71 11 00 00 	movabs $0xffff800000117130,%rax
ffff800000103aaa:	80 ff ff 
ffff800000103aad:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
      break;
ffff800000103ab3:	eb 0d                	jmp    ffff800000103ac2 <ideinit+0xb8>
  for(int i=0; i<1000; i++){
ffff800000103ab5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000103ab9:	81 7d fc e7 03 00 00 	cmpl   $0x3e7,-0x4(%rbp)
ffff800000103ac0:	7e cc                	jle    ffff800000103a8e <ideinit+0x84>
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
ffff800000103ac2:	be e0 00 00 00       	mov    $0xe0,%esi
ffff800000103ac7:	bf f6 01 00 00       	mov    $0x1f6,%edi
ffff800000103acc:	48 b8 61 39 10 00 00 	movabs $0xffff800000103961,%rax
ffff800000103ad3:	80 ff ff 
ffff800000103ad6:	ff d0                	call   *%rax
}
ffff800000103ad8:	90                   	nop
ffff800000103ad9:	c9                   	leave
ffff800000103ada:	c3                   	ret

ffff800000103adb <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
ffff800000103adb:	f3 0f 1e fa          	endbr64
ffff800000103adf:	55                   	push   %rbp
ffff800000103ae0:	48 89 e5             	mov    %rsp,%rbp
ffff800000103ae3:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000103ae7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  if(b == 0)
ffff800000103aeb:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff800000103af0:	75 19                	jne    ffff800000103b0b <idestart+0x30>
    panic("idestart");
ffff800000103af2:	48 b8 af c5 10 00 00 	movabs $0xffff80000010c5af,%rax
ffff800000103af9:	80 ff ff 
ffff800000103afc:	48 89 c7             	mov    %rax,%rdi
ffff800000103aff:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000103b06:	80 ff ff 
ffff800000103b09:	ff d0                	call   *%rax
  if(b->blockno >= FSSIZE)
ffff800000103b0b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103b0f:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000103b12:	3d e7 03 00 00       	cmp    $0x3e7,%eax
ffff800000103b17:	76 19                	jbe    ffff800000103b32 <idestart+0x57>
    panic("incorrect blockno");
ffff800000103b19:	48 b8 b8 c5 10 00 00 	movabs $0xffff80000010c5b8,%rax
ffff800000103b20:	80 ff ff 
ffff800000103b23:	48 89 c7             	mov    %rax,%rdi
ffff800000103b26:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000103b2d:	80 ff ff 
ffff800000103b30:	ff d0                	call   *%rax
  int sector_per_block =  BSIZE/SECTOR_SIZE;
ffff800000103b32:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  int sector = b->blockno * sector_per_block;
ffff800000103b39:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103b3d:	8b 50 08             	mov    0x8(%rax),%edx
ffff800000103b40:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000103b43:	0f af c2             	imul   %edx,%eax
ffff800000103b46:	89 45 f8             	mov    %eax,-0x8(%rbp)
  int read_cmd = (sector_per_block == 1) ? IDE_CMD_READ :  IDE_CMD_RDMUL;
ffff800000103b49:	83 7d fc 01          	cmpl   $0x1,-0x4(%rbp)
ffff800000103b4d:	75 07                	jne    ffff800000103b56 <idestart+0x7b>
ffff800000103b4f:	b8 20 00 00 00       	mov    $0x20,%eax
ffff800000103b54:	eb 05                	jmp    ffff800000103b5b <idestart+0x80>
ffff800000103b56:	b8 c4 00 00 00       	mov    $0xc4,%eax
ffff800000103b5b:	89 45 f4             	mov    %eax,-0xc(%rbp)
  int write_cmd = (sector_per_block == 1) ? IDE_CMD_WRITE : IDE_CMD_WRMUL;
ffff800000103b5e:	83 7d fc 01          	cmpl   $0x1,-0x4(%rbp)
ffff800000103b62:	75 07                	jne    ffff800000103b6b <idestart+0x90>
ffff800000103b64:	b8 30 00 00 00       	mov    $0x30,%eax
ffff800000103b69:	eb 05                	jmp    ffff800000103b70 <idestart+0x95>
ffff800000103b6b:	b8 c5 00 00 00       	mov    $0xc5,%eax
ffff800000103b70:	89 45 f0             	mov    %eax,-0x10(%rbp)

  if (sector_per_block > 7) panic("idestart");
ffff800000103b73:	83 7d fc 07          	cmpl   $0x7,-0x4(%rbp)
ffff800000103b77:	7e 19                	jle    ffff800000103b92 <idestart+0xb7>
ffff800000103b79:	48 b8 af c5 10 00 00 	movabs $0xffff80000010c5af,%rax
ffff800000103b80:	80 ff ff 
ffff800000103b83:	48 89 c7             	mov    %rax,%rdi
ffff800000103b86:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000103b8d:	80 ff ff 
ffff800000103b90:	ff d0                	call   *%rax

  idewait(0);
ffff800000103b92:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000103b97:	48 b8 b8 39 10 00 00 	movabs $0xffff8000001039b8,%rax
ffff800000103b9e:	80 ff ff 
ffff800000103ba1:	ff d0                	call   *%rax
  outb(0x3f6, 0);  // generate interrupt
ffff800000103ba3:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000103ba8:	bf f6 03 00 00       	mov    $0x3f6,%edi
ffff800000103bad:	48 b8 61 39 10 00 00 	movabs $0xffff800000103961,%rax
ffff800000103bb4:	80 ff ff 
ffff800000103bb7:	ff d0                	call   *%rax
  outb(0x1f2, sector_per_block);  // number of sectors
ffff800000103bb9:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000103bbc:	0f b6 c0             	movzbl %al,%eax
ffff800000103bbf:	89 c6                	mov    %eax,%esi
ffff800000103bc1:	bf f2 01 00 00       	mov    $0x1f2,%edi
ffff800000103bc6:	48 b8 61 39 10 00 00 	movabs $0xffff800000103961,%rax
ffff800000103bcd:	80 ff ff 
ffff800000103bd0:	ff d0                	call   *%rax
  outb(0x1f3, sector & 0xff);
ffff800000103bd2:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000103bd5:	0f b6 c0             	movzbl %al,%eax
ffff800000103bd8:	89 c6                	mov    %eax,%esi
ffff800000103bda:	bf f3 01 00 00       	mov    $0x1f3,%edi
ffff800000103bdf:	48 b8 61 39 10 00 00 	movabs $0xffff800000103961,%rax
ffff800000103be6:	80 ff ff 
ffff800000103be9:	ff d0                	call   *%rax
  outb(0x1f4, (sector >> 8) & 0xff);
ffff800000103beb:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000103bee:	c1 f8 08             	sar    $0x8,%eax
ffff800000103bf1:	0f b6 c0             	movzbl %al,%eax
ffff800000103bf4:	89 c6                	mov    %eax,%esi
ffff800000103bf6:	bf f4 01 00 00       	mov    $0x1f4,%edi
ffff800000103bfb:	48 b8 61 39 10 00 00 	movabs $0xffff800000103961,%rax
ffff800000103c02:	80 ff ff 
ffff800000103c05:	ff d0                	call   *%rax
  outb(0x1f5, (sector >> 16) & 0xff);
ffff800000103c07:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000103c0a:	c1 f8 10             	sar    $0x10,%eax
ffff800000103c0d:	0f b6 c0             	movzbl %al,%eax
ffff800000103c10:	89 c6                	mov    %eax,%esi
ffff800000103c12:	bf f5 01 00 00       	mov    $0x1f5,%edi
ffff800000103c17:	48 b8 61 39 10 00 00 	movabs $0xffff800000103961,%rax
ffff800000103c1e:	80 ff ff 
ffff800000103c21:	ff d0                	call   *%rax
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
ffff800000103c23:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103c27:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000103c2a:	c1 e0 04             	shl    $0x4,%eax
ffff800000103c2d:	83 e0 10             	and    $0x10,%eax
ffff800000103c30:	89 c2                	mov    %eax,%edx
ffff800000103c32:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000103c35:	c1 f8 18             	sar    $0x18,%eax
ffff800000103c38:	83 e0 0f             	and    $0xf,%eax
ffff800000103c3b:	09 d0                	or     %edx,%eax
ffff800000103c3d:	83 c8 e0             	or     $0xffffffe0,%eax
ffff800000103c40:	0f b6 c0             	movzbl %al,%eax
ffff800000103c43:	89 c6                	mov    %eax,%esi
ffff800000103c45:	bf f6 01 00 00       	mov    $0x1f6,%edi
ffff800000103c4a:	48 b8 61 39 10 00 00 	movabs $0xffff800000103961,%rax
ffff800000103c51:	80 ff ff 
ffff800000103c54:	ff d0                	call   *%rax
  if(b->flags & B_DIRTY){
ffff800000103c56:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103c5a:	8b 00                	mov    (%rax),%eax
ffff800000103c5c:	83 e0 04             	and    $0x4,%eax
ffff800000103c5f:	85 c0                	test   %eax,%eax
ffff800000103c61:	74 3e                	je     ffff800000103ca1 <idestart+0x1c6>
    outb(0x1f7, write_cmd);
ffff800000103c63:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000103c66:	0f b6 c0             	movzbl %al,%eax
ffff800000103c69:	89 c6                	mov    %eax,%esi
ffff800000103c6b:	bf f7 01 00 00       	mov    $0x1f7,%edi
ffff800000103c70:	48 b8 61 39 10 00 00 	movabs $0xffff800000103961,%rax
ffff800000103c77:	80 ff ff 
ffff800000103c7a:	ff d0                	call   *%rax
    outsl(0x1f0, b->data, BSIZE/4);
ffff800000103c7c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103c80:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000103c86:	ba 80 00 00 00       	mov    $0x80,%edx
ffff800000103c8b:	48 89 c6             	mov    %rax,%rsi
ffff800000103c8e:	bf f0 01 00 00       	mov    $0x1f0,%edi
ffff800000103c93:	48 b8 84 39 10 00 00 	movabs $0xffff800000103984,%rax
ffff800000103c9a:	80 ff ff 
ffff800000103c9d:	ff d0                	call   *%rax
  } else {
    outb(0x1f7, read_cmd);
  }
}
ffff800000103c9f:	eb 19                	jmp    ffff800000103cba <idestart+0x1df>
    outb(0x1f7, read_cmd);
ffff800000103ca1:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000103ca4:	0f b6 c0             	movzbl %al,%eax
ffff800000103ca7:	89 c6                	mov    %eax,%esi
ffff800000103ca9:	bf f7 01 00 00       	mov    $0x1f7,%edi
ffff800000103cae:	48 b8 61 39 10 00 00 	movabs $0xffff800000103961,%rax
ffff800000103cb5:	80 ff ff 
ffff800000103cb8:	ff d0                	call   *%rax
}
ffff800000103cba:	90                   	nop
ffff800000103cbb:	c9                   	leave
ffff800000103cbc:	c3                   	ret

ffff800000103cbd <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
ffff800000103cbd:	f3 0f 1e fa          	endbr64
ffff800000103cc1:	55                   	push   %rbp
ffff800000103cc2:	48 89 e5             	mov    %rsp,%rbp
ffff800000103cc5:	48 83 ec 10          	sub    $0x10,%rsp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
ffff800000103cc9:	48 b8 c0 70 11 00 00 	movabs $0xffff8000001170c0,%rax
ffff800000103cd0:	80 ff ff 
ffff800000103cd3:	48 89 c7             	mov    %rax,%rdi
ffff800000103cd6:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff800000103cdd:	80 ff ff 
ffff800000103ce0:	ff d0                	call   *%rax
  if((b = idequeue) == 0){
ffff800000103ce2:	48 b8 28 71 11 00 00 	movabs $0xffff800000117128,%rax
ffff800000103ce9:	80 ff ff 
ffff800000103cec:	48 8b 00             	mov    (%rax),%rax
ffff800000103cef:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000103cf3:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000103cf8:	75 1e                	jne    ffff800000103d18 <ideintr+0x5b>
    release(&idelock);
ffff800000103cfa:	48 b8 c0 70 11 00 00 	movabs $0xffff8000001170c0,%rax
ffff800000103d01:	80 ff ff 
ffff800000103d04:	48 89 c7             	mov    %rax,%rdi
ffff800000103d07:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff800000103d0e:	80 ff ff 
ffff800000103d11:	ff d0                	call   *%rax
    // cprintf("spurious IDE interrupt\n");
    return;
ffff800000103d13:	e9 d9 00 00 00       	jmp    ffff800000103df1 <ideintr+0x134>
  }
  idequeue = b->qnext;
ffff800000103d18:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103d1c:	48 8b 80 a8 00 00 00 	mov    0xa8(%rax),%rax
ffff800000103d23:	48 ba 28 71 11 00 00 	movabs $0xffff800000117128,%rdx
ffff800000103d2a:	80 ff ff 
ffff800000103d2d:	48 89 02             	mov    %rax,(%rdx)

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
ffff800000103d30:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103d34:	8b 00                	mov    (%rax),%eax
ffff800000103d36:	83 e0 04             	and    $0x4,%eax
ffff800000103d39:	85 c0                	test   %eax,%eax
ffff800000103d3b:	75 38                	jne    ffff800000103d75 <ideintr+0xb8>
ffff800000103d3d:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000103d42:	48 b8 b8 39 10 00 00 	movabs $0xffff8000001039b8,%rax
ffff800000103d49:	80 ff ff 
ffff800000103d4c:	ff d0                	call   *%rax
ffff800000103d4e:	85 c0                	test   %eax,%eax
ffff800000103d50:	78 23                	js     ffff800000103d75 <ideintr+0xb8>
    insl(0x1f0, b->data, BSIZE/4);
ffff800000103d52:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103d56:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000103d5c:	ba 80 00 00 00       	mov    $0x80,%edx
ffff800000103d61:	48 89 c6             	mov    %rax,%rsi
ffff800000103d64:	bf f0 01 00 00       	mov    $0x1f0,%edi
ffff800000103d69:	48 b8 27 39 10 00 00 	movabs $0xffff800000103927,%rax
ffff800000103d70:	80 ff ff 
ffff800000103d73:	ff d0                	call   *%rax

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
ffff800000103d75:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103d79:	8b 00                	mov    (%rax),%eax
ffff800000103d7b:	83 c8 02             	or     $0x2,%eax
ffff800000103d7e:	89 c2                	mov    %eax,%edx
ffff800000103d80:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103d84:	89 10                	mov    %edx,(%rax)
  b->flags &= ~B_DIRTY;
ffff800000103d86:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103d8a:	8b 00                	mov    (%rax),%eax
ffff800000103d8c:	83 e0 fb             	and    $0xfffffffb,%eax
ffff800000103d8f:	89 c2                	mov    %eax,%edx
ffff800000103d91:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103d95:	89 10                	mov    %edx,(%rax)
  wakeup(b);
ffff800000103d97:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103d9b:	48 89 c7             	mov    %rax,%rdi
ffff800000103d9e:	48 b8 21 72 10 00 00 	movabs $0xffff800000107221,%rax
ffff800000103da5:	80 ff ff 
ffff800000103da8:	ff d0                	call   *%rax

  // Start disk on next buf in queue.
  if(idequeue != 0)
ffff800000103daa:	48 b8 28 71 11 00 00 	movabs $0xffff800000117128,%rax
ffff800000103db1:	80 ff ff 
ffff800000103db4:	48 8b 00             	mov    (%rax),%rax
ffff800000103db7:	48 85 c0             	test   %rax,%rax
ffff800000103dba:	74 1c                	je     ffff800000103dd8 <ideintr+0x11b>
    idestart(idequeue);
ffff800000103dbc:	48 b8 28 71 11 00 00 	movabs $0xffff800000117128,%rax
ffff800000103dc3:	80 ff ff 
ffff800000103dc6:	48 8b 00             	mov    (%rax),%rax
ffff800000103dc9:	48 89 c7             	mov    %rax,%rdi
ffff800000103dcc:	48 b8 db 3a 10 00 00 	movabs $0xffff800000103adb,%rax
ffff800000103dd3:	80 ff ff 
ffff800000103dd6:	ff d0                	call   *%rax

  release(&idelock);
ffff800000103dd8:	48 b8 c0 70 11 00 00 	movabs $0xffff8000001170c0,%rax
ffff800000103ddf:	80 ff ff 
ffff800000103de2:	48 89 c7             	mov    %rax,%rdi
ffff800000103de5:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff800000103dec:	80 ff ff 
ffff800000103def:	ff d0                	call   *%rax
}
ffff800000103df1:	c9                   	leave
ffff800000103df2:	c3                   	ret

ffff800000103df3 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
ffff800000103df3:	f3 0f 1e fa          	endbr64
ffff800000103df7:	55                   	push   %rbp
ffff800000103df8:	48 89 e5             	mov    %rsp,%rbp
ffff800000103dfb:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000103dff:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct buf **pp;

  if(!holdingsleep(&b->lock))
ffff800000103e03:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103e07:	48 83 c0 10          	add    $0x10,%rax
ffff800000103e0b:	48 89 c7             	mov    %rax,%rdi
ffff800000103e0e:	48 b8 ef 78 10 00 00 	movabs $0xffff8000001078ef,%rax
ffff800000103e15:	80 ff ff 
ffff800000103e18:	ff d0                	call   *%rax
ffff800000103e1a:	85 c0                	test   %eax,%eax
ffff800000103e1c:	75 19                	jne    ffff800000103e37 <iderw+0x44>
    panic("iderw: buf not locked");
ffff800000103e1e:	48 b8 ca c5 10 00 00 	movabs $0xffff80000010c5ca,%rax
ffff800000103e25:	80 ff ff 
ffff800000103e28:	48 89 c7             	mov    %rax,%rdi
ffff800000103e2b:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000103e32:	80 ff ff 
ffff800000103e35:	ff d0                	call   *%rax
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
ffff800000103e37:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103e3b:	8b 00                	mov    (%rax),%eax
ffff800000103e3d:	83 e0 06             	and    $0x6,%eax
ffff800000103e40:	83 f8 02             	cmp    $0x2,%eax
ffff800000103e43:	75 19                	jne    ffff800000103e5e <iderw+0x6b>
    panic("iderw: nothing to do");
ffff800000103e45:	48 b8 e0 c5 10 00 00 	movabs $0xffff80000010c5e0,%rax
ffff800000103e4c:	80 ff ff 
ffff800000103e4f:	48 89 c7             	mov    %rax,%rdi
ffff800000103e52:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000103e59:	80 ff ff 
ffff800000103e5c:	ff d0                	call   *%rax
  if(b->dev != 0 && !havedisk1)
ffff800000103e5e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103e62:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000103e65:	85 c0                	test   %eax,%eax
ffff800000103e67:	74 29                	je     ffff800000103e92 <iderw+0x9f>
ffff800000103e69:	48 b8 30 71 11 00 00 	movabs $0xffff800000117130,%rax
ffff800000103e70:	80 ff ff 
ffff800000103e73:	8b 00                	mov    (%rax),%eax
ffff800000103e75:	85 c0                	test   %eax,%eax
ffff800000103e77:	75 19                	jne    ffff800000103e92 <iderw+0x9f>
    panic("iderw: ide disk 1 not present");
ffff800000103e79:	48 b8 f5 c5 10 00 00 	movabs $0xffff80000010c5f5,%rax
ffff800000103e80:	80 ff ff 
ffff800000103e83:	48 89 c7             	mov    %rax,%rdi
ffff800000103e86:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000103e8d:	80 ff ff 
ffff800000103e90:	ff d0                	call   *%rax

  acquire(&idelock);  //DOC:acquire-lock
ffff800000103e92:	48 b8 c0 70 11 00 00 	movabs $0xffff8000001170c0,%rax
ffff800000103e99:	80 ff ff 
ffff800000103e9c:	48 89 c7             	mov    %rax,%rdi
ffff800000103e9f:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff800000103ea6:	80 ff ff 
ffff800000103ea9:	ff d0                	call   *%rax

  // Append b to idequeue.
  b->qnext = 0;
ffff800000103eab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103eaf:	48 c7 80 a8 00 00 00 	movq   $0x0,0xa8(%rax)
ffff800000103eb6:	00 00 00 00 
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
ffff800000103eba:	48 b8 28 71 11 00 00 	movabs $0xffff800000117128,%rax
ffff800000103ec1:	80 ff ff 
ffff800000103ec4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000103ec8:	eb 11                	jmp    ffff800000103edb <iderw+0xe8>
ffff800000103eca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103ece:	48 8b 00             	mov    (%rax),%rax
ffff800000103ed1:	48 05 a8 00 00 00    	add    $0xa8,%rax
ffff800000103ed7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000103edb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103edf:	48 8b 00             	mov    (%rax),%rax
ffff800000103ee2:	48 85 c0             	test   %rax,%rax
ffff800000103ee5:	75 e3                	jne    ffff800000103eca <iderw+0xd7>
    ;
  *pp = b;
ffff800000103ee7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103eeb:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000103eef:	48 89 10             	mov    %rdx,(%rax)

  // Start disk if necessary.
  if(idequeue == b)
ffff800000103ef2:	48 b8 28 71 11 00 00 	movabs $0xffff800000117128,%rax
ffff800000103ef9:	80 ff ff 
ffff800000103efc:	48 8b 00             	mov    (%rax),%rax
ffff800000103eff:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffff800000103f03:	75 35                	jne    ffff800000103f3a <iderw+0x147>
    idestart(b);
ffff800000103f05:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103f09:	48 89 c7             	mov    %rax,%rdi
ffff800000103f0c:	48 b8 db 3a 10 00 00 	movabs $0xffff800000103adb,%rax
ffff800000103f13:	80 ff ff 
ffff800000103f16:	ff d0                	call   *%rax

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
ffff800000103f18:	eb 20                	jmp    ffff800000103f3a <iderw+0x147>
    sleep(b, &idelock);
ffff800000103f1a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103f1e:	48 ba c0 70 11 00 00 	movabs $0xffff8000001170c0,%rdx
ffff800000103f25:	80 ff ff 
ffff800000103f28:	48 89 d6             	mov    %rdx,%rsi
ffff800000103f2b:	48 89 c7             	mov    %rax,%rdi
ffff800000103f2e:	48 b8 a4 70 10 00 00 	movabs $0xffff8000001070a4,%rax
ffff800000103f35:	80 ff ff 
ffff800000103f38:	ff d0                	call   *%rax
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
ffff800000103f3a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103f3e:	8b 00                	mov    (%rax),%eax
ffff800000103f40:	83 e0 06             	and    $0x6,%eax
ffff800000103f43:	83 f8 02             	cmp    $0x2,%eax
ffff800000103f46:	75 d2                	jne    ffff800000103f1a <iderw+0x127>
  }

  release(&idelock);
ffff800000103f48:	48 b8 c0 70 11 00 00 	movabs $0xffff8000001170c0,%rax
ffff800000103f4f:	80 ff ff 
ffff800000103f52:	48 89 c7             	mov    %rax,%rdi
ffff800000103f55:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff800000103f5c:	80 ff ff 
ffff800000103f5f:	ff d0                	call   *%rax
}
ffff800000103f61:	90                   	nop
ffff800000103f62:	c9                   	leave
ffff800000103f63:	c3                   	ret

ffff800000103f64 <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
ffff800000103f64:	f3 0f 1e fa          	endbr64
ffff800000103f68:	55                   	push   %rbp
ffff800000103f69:	48 89 e5             	mov    %rsp,%rbp
ffff800000103f6c:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000103f70:	89 7d fc             	mov    %edi,-0x4(%rbp)
  ioapic->reg = reg;
ffff800000103f73:	48 b8 38 71 11 00 00 	movabs $0xffff800000117138,%rax
ffff800000103f7a:	80 ff ff 
ffff800000103f7d:	48 8b 00             	mov    (%rax),%rax
ffff800000103f80:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000103f83:	89 10                	mov    %edx,(%rax)
  return ioapic->data;
ffff800000103f85:	48 b8 38 71 11 00 00 	movabs $0xffff800000117138,%rax
ffff800000103f8c:	80 ff ff 
ffff800000103f8f:	48 8b 00             	mov    (%rax),%rax
ffff800000103f92:	8b 40 10             	mov    0x10(%rax),%eax
}
ffff800000103f95:	c9                   	leave
ffff800000103f96:	c3                   	ret

ffff800000103f97 <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
ffff800000103f97:	f3 0f 1e fa          	endbr64
ffff800000103f9b:	55                   	push   %rbp
ffff800000103f9c:	48 89 e5             	mov    %rsp,%rbp
ffff800000103f9f:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000103fa3:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff800000103fa6:	89 75 f8             	mov    %esi,-0x8(%rbp)
  ioapic->reg = reg;
ffff800000103fa9:	48 b8 38 71 11 00 00 	movabs $0xffff800000117138,%rax
ffff800000103fb0:	80 ff ff 
ffff800000103fb3:	48 8b 00             	mov    (%rax),%rax
ffff800000103fb6:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000103fb9:	89 10                	mov    %edx,(%rax)
  ioapic->data = data;
ffff800000103fbb:	48 b8 38 71 11 00 00 	movabs $0xffff800000117138,%rax
ffff800000103fc2:	80 ff ff 
ffff800000103fc5:	48 8b 00             	mov    (%rax),%rax
ffff800000103fc8:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffff800000103fcb:	89 50 10             	mov    %edx,0x10(%rax)
}
ffff800000103fce:	90                   	nop
ffff800000103fcf:	c9                   	leave
ffff800000103fd0:	c3                   	ret

ffff800000103fd1 <ioapicinit>:

void
ioapicinit(void)
{
ffff800000103fd1:	f3 0f 1e fa          	endbr64
ffff800000103fd5:	55                   	push   %rbp
ffff800000103fd6:	48 89 e5             	mov    %rsp,%rbp
ffff800000103fd9:	48 83 ec 10          	sub    $0x10,%rsp
  int i, id, maxintr;

  ioapic = P2V((volatile struct ioapic*)IOAPIC);
ffff800000103fdd:	48 b8 38 71 11 00 00 	movabs $0xffff800000117138,%rax
ffff800000103fe4:	80 ff ff 
ffff800000103fe7:	48 b9 00 00 c0 fe 00 	movabs $0xffff8000fec00000,%rcx
ffff800000103fee:	80 ff ff 
ffff800000103ff1:	48 89 08             	mov    %rcx,(%rax)
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
ffff800000103ff4:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000103ff9:	48 b8 64 3f 10 00 00 	movabs $0xffff800000103f64,%rax
ffff800000104000:	80 ff ff 
ffff800000104003:	ff d0                	call   *%rax
ffff800000104005:	c1 e8 10             	shr    $0x10,%eax
ffff800000104008:	25 ff 00 00 00       	and    $0xff,%eax
ffff80000010400d:	89 45 f8             	mov    %eax,-0x8(%rbp)
  id = ioapicread(REG_ID) >> 24;
ffff800000104010:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000104015:	48 b8 64 3f 10 00 00 	movabs $0xffff800000103f64,%rax
ffff80000010401c:	80 ff ff 
ffff80000010401f:	ff d0                	call   *%rax
ffff800000104021:	c1 e8 18             	shr    $0x18,%eax
ffff800000104024:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(id != ioapicid)
ffff800000104027:	48 b8 24 74 11 00 00 	movabs $0xffff800000117424,%rax
ffff80000010402e:	80 ff ff 
ffff800000104031:	0f b6 00             	movzbl (%rax),%eax
ffff800000104034:	0f b6 c0             	movzbl %al,%eax
ffff800000104037:	39 45 f4             	cmp    %eax,-0xc(%rbp)
ffff80000010403a:	74 1e                	je     ffff80000010405a <ioapicinit+0x89>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
ffff80000010403c:	48 b8 18 c6 10 00 00 	movabs $0xffff80000010c618,%rax
ffff800000104043:	80 ff ff 
ffff800000104046:	48 89 c7             	mov    %rax,%rdi
ffff800000104049:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010404e:	48 ba 38 08 10 00 00 	movabs $0xffff800000100838,%rdx
ffff800000104055:	80 ff ff 
ffff800000104058:	ff d2                	call   *%rdx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
ffff80000010405a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000104061:	eb 47                	jmp    ffff8000001040aa <ioapicinit+0xd9>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
ffff800000104063:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104066:	83 c0 20             	add    $0x20,%eax
ffff800000104069:	0d 00 00 01 00       	or     $0x10000,%eax
ffff80000010406e:	89 c2                	mov    %eax,%edx
ffff800000104070:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104073:	83 c0 08             	add    $0x8,%eax
ffff800000104076:	01 c0                	add    %eax,%eax
ffff800000104078:	89 d6                	mov    %edx,%esi
ffff80000010407a:	89 c7                	mov    %eax,%edi
ffff80000010407c:	48 b8 97 3f 10 00 00 	movabs $0xffff800000103f97,%rax
ffff800000104083:	80 ff ff 
ffff800000104086:	ff d0                	call   *%rax
    ioapicwrite(REG_TABLE+2*i+1, 0);
ffff800000104088:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010408b:	83 c0 08             	add    $0x8,%eax
ffff80000010408e:	01 c0                	add    %eax,%eax
ffff800000104090:	83 c0 01             	add    $0x1,%eax
ffff800000104093:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000104098:	89 c7                	mov    %eax,%edi
ffff80000010409a:	48 b8 97 3f 10 00 00 	movabs $0xffff800000103f97,%rax
ffff8000001040a1:	80 ff ff 
ffff8000001040a4:	ff d0                	call   *%rax
  for(i = 0; i <= maxintr; i++){
ffff8000001040a6:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001040aa:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001040ad:	3b 45 f8             	cmp    -0x8(%rbp),%eax
ffff8000001040b0:	7e b1                	jle    ffff800000104063 <ioapicinit+0x92>
  }
}
ffff8000001040b2:	90                   	nop
ffff8000001040b3:	90                   	nop
ffff8000001040b4:	c9                   	leave
ffff8000001040b5:	c3                   	ret

ffff8000001040b6 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
ffff8000001040b6:	f3 0f 1e fa          	endbr64
ffff8000001040ba:	55                   	push   %rbp
ffff8000001040bb:	48 89 e5             	mov    %rsp,%rbp
ffff8000001040be:	48 83 ec 08          	sub    $0x8,%rsp
ffff8000001040c2:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff8000001040c5:	89 75 f8             	mov    %esi,-0x8(%rbp)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
ffff8000001040c8:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001040cb:	83 c0 20             	add    $0x20,%eax
ffff8000001040ce:	89 c2                	mov    %eax,%edx
ffff8000001040d0:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001040d3:	83 c0 08             	add    $0x8,%eax
ffff8000001040d6:	01 c0                	add    %eax,%eax
ffff8000001040d8:	89 d6                	mov    %edx,%esi
ffff8000001040da:	89 c7                	mov    %eax,%edi
ffff8000001040dc:	48 b8 97 3f 10 00 00 	movabs $0xffff800000103f97,%rax
ffff8000001040e3:	80 ff ff 
ffff8000001040e6:	ff d0                	call   *%rax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
ffff8000001040e8:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff8000001040eb:	c1 e0 18             	shl    $0x18,%eax
ffff8000001040ee:	89 c2                	mov    %eax,%edx
ffff8000001040f0:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001040f3:	83 c0 08             	add    $0x8,%eax
ffff8000001040f6:	01 c0                	add    %eax,%eax
ffff8000001040f8:	83 c0 01             	add    $0x1,%eax
ffff8000001040fb:	89 d6                	mov    %edx,%esi
ffff8000001040fd:	89 c7                	mov    %eax,%edi
ffff8000001040ff:	48 b8 97 3f 10 00 00 	movabs $0xffff800000103f97,%rax
ffff800000104106:	80 ff ff 
ffff800000104109:	ff d0                	call   *%rax
}
ffff80000010410b:	90                   	nop
ffff80000010410c:	c9                   	leave
ffff80000010410d:	c3                   	ret

ffff80000010410e <kinit1>:
  struct run *freelist;
} kmem;

void
kinit1(void *vstart, void *vend)
{
ffff80000010410e:	f3 0f 1e fa          	endbr64
ffff800000104112:	55                   	push   %rbp
ffff800000104113:	48 89 e5             	mov    %rsp,%rbp
ffff800000104116:	48 83 ec 10          	sub    $0x10,%rsp
ffff80000010411a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff80000010411e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  initlock(&kmem.lock, "kmem");
ffff800000104122:	48 b8 4a c6 10 00 00 	movabs $0xffff80000010c64a,%rax
ffff800000104129:	80 ff ff 
ffff80000010412c:	48 89 c6             	mov    %rax,%rsi
ffff80000010412f:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff800000104136:	80 ff ff 
ffff800000104139:	48 89 c7             	mov    %rax,%rdi
ffff80000010413c:	48 b8 96 79 10 00 00 	movabs $0xffff800000107996,%rax
ffff800000104143:	80 ff ff 
ffff800000104146:	ff d0                	call   *%rax
  kmem.use_lock = 0;
ffff800000104148:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff80000010414f:	80 ff ff 
ffff800000104152:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%rax)
  kmem.freelist = 0; // empty
ffff800000104159:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff800000104160:	80 ff ff 
ffff800000104163:	48 c7 40 70 00 00 00 	movq   $0x0,0x70(%rax)
ffff80000010416a:	00 
  freerange(vstart, vend);
ffff80000010416b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff80000010416f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000104173:	48 89 d6             	mov    %rdx,%rsi
ffff800000104176:	48 89 c7             	mov    %rax,%rdi
ffff800000104179:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff800000104180:	80 ff ff 
ffff800000104183:	ff d0                	call   *%rax
}
ffff800000104185:	90                   	nop
ffff800000104186:	c9                   	leave
ffff800000104187:	c3                   	ret

ffff800000104188 <kinit2>:

void
kinit2()
{
ffff800000104188:	f3 0f 1e fa          	endbr64
ffff80000010418c:	55                   	push   %rbp
ffff80000010418d:	48 89 e5             	mov    %rsp,%rbp
  kmem.use_lock = 1;
ffff800000104190:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff800000104197:	80 ff ff 
ffff80000010419a:	c7 40 68 01 00 00 00 	movl   $0x1,0x68(%rax)
}
ffff8000001041a1:	90                   	nop
ffff8000001041a2:	5d                   	pop    %rbp
ffff8000001041a3:	c3                   	ret

ffff8000001041a4 <freerange>:

void
freerange(void *vstart, void *vend)
{
ffff8000001041a4:	f3 0f 1e fa          	endbr64
ffff8000001041a8:	55                   	push   %rbp
ffff8000001041a9:	48 89 e5             	mov    %rsp,%rbp
ffff8000001041ac:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001041b0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff8000001041b4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *p;
  p = (char*)PGROUNDUP((addr_t)vstart);
ffff8000001041b8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001041bc:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffff8000001041c2:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff8000001041c8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
ffff8000001041cc:	eb 1b                	jmp    ffff8000001041e9 <freerange+0x45>
    kfree(p);
ffff8000001041ce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001041d2:	48 89 c7             	mov    %rax,%rdi
ffff8000001041d5:	48 b8 fd 41 10 00 00 	movabs $0xffff8000001041fd,%rax
ffff8000001041dc:	80 ff ff 
ffff8000001041df:	ff d0                	call   *%rax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
ffff8000001041e1:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffff8000001041e8:	00 
ffff8000001041e9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001041ed:	48 05 00 10 00 00    	add    $0x1000,%rax
ffff8000001041f3:	48 39 45 e0          	cmp    %rax,-0x20(%rbp)
ffff8000001041f7:	73 d5                	jae    ffff8000001041ce <freerange+0x2a>
}
ffff8000001041f9:	90                   	nop
ffff8000001041fa:	90                   	nop
ffff8000001041fb:	c9                   	leave
ffff8000001041fc:	c3                   	ret

ffff8000001041fd <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
ffff8000001041fd:	f3 0f 1e fa          	endbr64
ffff800000104201:	55                   	push   %rbp
ffff800000104202:	48 89 e5             	mov    %rsp,%rbp
ffff800000104205:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000104209:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct run *r;

  if((addr_t)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
ffff80000010420d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104211:	25 ff 0f 00 00       	and    $0xfff,%eax
ffff800000104216:	48 85 c0             	test   %rax,%rax
ffff800000104219:	75 29                	jne    ffff800000104244 <kfree+0x47>
ffff80000010421b:	48 b8 00 f0 11 00 00 	movabs $0xffff80000011f000,%rax
ffff800000104222:	80 ff ff 
ffff800000104225:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffff800000104229:	72 19                	jb     ffff800000104244 <kfree+0x47>
ffff80000010422b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010422f:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff800000104236:	80 00 00 
ffff800000104239:	48 01 d0             	add    %rdx,%rax
ffff80000010423c:	48 3d ff ff ff 0d    	cmp    $0xdffffff,%rax
ffff800000104242:	76 19                	jbe    ffff80000010425d <kfree+0x60>
    panic("kfree");
ffff800000104244:	48 b8 4f c6 10 00 00 	movabs $0xffff80000010c64f,%rax
ffff80000010424b:	80 ff ff 
ffff80000010424e:	48 89 c7             	mov    %rax,%rdi
ffff800000104251:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000104258:	80 ff ff 
ffff80000010425b:	ff d0                	call   *%rax

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
ffff80000010425d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104261:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff800000104266:	be 01 00 00 00       	mov    $0x1,%esi
ffff80000010426b:	48 89 c7             	mov    %rax,%rdi
ffff80000010426e:	48 b8 87 7d 10 00 00 	movabs $0xffff800000107d87,%rax
ffff800000104275:	80 ff ff 
ffff800000104278:	ff d0                	call   *%rax

  if(kmem.use_lock)
ffff80000010427a:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff800000104281:	80 ff ff 
ffff800000104284:	8b 40 68             	mov    0x68(%rax),%eax
ffff800000104287:	85 c0                	test   %eax,%eax
ffff800000104289:	74 19                	je     ffff8000001042a4 <kfree+0xa7>
    acquire(&kmem.lock);
ffff80000010428b:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff800000104292:	80 ff ff 
ffff800000104295:	48 89 c7             	mov    %rax,%rdi
ffff800000104298:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff80000010429f:	80 ff ff 
ffff8000001042a2:	ff d0                	call   *%rax
  r = (struct run*)v;
ffff8000001042a4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001042a8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  r->next = kmem.freelist;
ffff8000001042ac:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff8000001042b3:	80 ff ff 
ffff8000001042b6:	48 8b 50 70          	mov    0x70(%rax),%rdx
ffff8000001042ba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001042be:	48 89 10             	mov    %rdx,(%rax)
  kmem.freelist = r;
ffff8000001042c1:	48 ba 40 71 11 00 00 	movabs $0xffff800000117140,%rdx
ffff8000001042c8:	80 ff ff 
ffff8000001042cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001042cf:	48 89 42 70          	mov    %rax,0x70(%rdx)
  if(kmem.use_lock)
ffff8000001042d3:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff8000001042da:	80 ff ff 
ffff8000001042dd:	8b 40 68             	mov    0x68(%rax),%eax
ffff8000001042e0:	85 c0                	test   %eax,%eax
ffff8000001042e2:	74 19                	je     ffff8000001042fd <kfree+0x100>
    release(&kmem.lock);
ffff8000001042e4:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff8000001042eb:	80 ff ff 
ffff8000001042ee:	48 89 c7             	mov    %rax,%rdi
ffff8000001042f1:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff8000001042f8:	80 ff ff 
ffff8000001042fb:	ff d0                	call   *%rax
}
ffff8000001042fd:	90                   	nop
ffff8000001042fe:	c9                   	leave
ffff8000001042ff:	c3                   	ret

ffff800000104300 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
ffff800000104300:	f3 0f 1e fa          	endbr64
ffff800000104304:	55                   	push   %rbp
ffff800000104305:	48 89 e5             	mov    %rsp,%rbp
ffff800000104308:	48 83 ec 10          	sub    $0x10,%rsp
  struct run *r;

  if(kmem.use_lock)
ffff80000010430c:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff800000104313:	80 ff ff 
ffff800000104316:	8b 40 68             	mov    0x68(%rax),%eax
ffff800000104319:	85 c0                	test   %eax,%eax
ffff80000010431b:	74 19                	je     ffff800000104336 <kalloc+0x36>
    acquire(&kmem.lock);
ffff80000010431d:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff800000104324:	80 ff ff 
ffff800000104327:	48 89 c7             	mov    %rax,%rdi
ffff80000010432a:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff800000104331:	80 ff ff 
ffff800000104334:	ff d0                	call   *%rax
  r = kmem.freelist;
ffff800000104336:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff80000010433d:	80 ff ff 
ffff800000104340:	48 8b 40 70          	mov    0x70(%rax),%rax
ffff800000104344:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(r)
ffff800000104348:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff80000010434d:	74 28                	je     ffff800000104377 <kalloc+0x77>
    kmem.freelist = r->next;
ffff80000010434f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000104353:	48 8b 00             	mov    (%rax),%rax
ffff800000104356:	48 ba 40 71 11 00 00 	movabs $0xffff800000117140,%rdx
ffff80000010435d:	80 ff ff 
ffff800000104360:	48 89 42 70          	mov    %rax,0x70(%rdx)
  else {
    panic("Out of memory!");
  }
  
  if(kmem.use_lock)
ffff800000104364:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff80000010436b:	80 ff ff 
ffff80000010436e:	8b 40 68             	mov    0x68(%rax),%eax
ffff800000104371:	85 c0                	test   %eax,%eax
ffff800000104373:	74 34                	je     ffff8000001043a9 <kalloc+0xa9>
ffff800000104375:	eb 19                	jmp    ffff800000104390 <kalloc+0x90>
    panic("Out of memory!");
ffff800000104377:	48 b8 55 c6 10 00 00 	movabs $0xffff80000010c655,%rax
ffff80000010437e:	80 ff ff 
ffff800000104381:	48 89 c7             	mov    %rax,%rdi
ffff800000104384:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010438b:	80 ff ff 
ffff80000010438e:	ff d0                	call   *%rax
    release(&kmem.lock);
ffff800000104390:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff800000104397:	80 ff ff 
ffff80000010439a:	48 89 c7             	mov    %rax,%rdi
ffff80000010439d:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff8000001043a4:	80 ff ff 
ffff8000001043a7:	ff d0                	call   *%rax
  return (char*)r;
ffff8000001043a9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff8000001043ad:	c9                   	leave
ffff8000001043ae:	c3                   	ret

ffff8000001043af <inb>:
#include "types.h"
#include "x86.h"
#include "defs.h"
#include "kbd.h"

ffff8000001043af:	f3 0f 1e fa          	endbr64
ffff8000001043b3:	55                   	push   %rbp
ffff8000001043b4:	48 89 e5             	mov    %rsp,%rbp
ffff8000001043b7:	48 83 ec 18          	sub    $0x18,%rsp
ffff8000001043bb:	89 f8                	mov    %edi,%eax
ffff8000001043bd:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
int
kbdgetc(void)
{
ffff8000001043c1:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff8000001043c5:	89 c2                	mov    %eax,%edx
ffff8000001043c7:	ec                   	in     (%dx),%al
ffff8000001043c8:	88 45 ff             	mov    %al,-0x1(%rbp)
  static uint shift;
ffff8000001043cb:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
  static uchar *charcode[4] = {
ffff8000001043cf:	c9                   	leave
ffff8000001043d0:	c3                   	ret

ffff8000001043d1 <kbdgetc>:
{
ffff8000001043d1:	f3 0f 1e fa          	endbr64
ffff8000001043d5:	55                   	push   %rbp
ffff8000001043d6:	48 89 e5             	mov    %rsp,%rbp
ffff8000001043d9:	48 83 ec 10          	sub    $0x10,%rsp
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
ffff8000001043dd:	bf 64 00 00 00       	mov    $0x64,%edi
ffff8000001043e2:	48 b8 af 43 10 00 00 	movabs $0xffff8000001043af,%rax
ffff8000001043e9:	80 ff ff 
ffff8000001043ec:	ff d0                	call   *%rax
ffff8000001043ee:	0f b6 c0             	movzbl %al,%eax
ffff8000001043f1:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if((st & KBS_DIB) == 0)
ffff8000001043f4:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff8000001043f7:	83 e0 01             	and    $0x1,%eax
ffff8000001043fa:	85 c0                	test   %eax,%eax
ffff8000001043fc:	75 0a                	jne    ffff800000104408 <kbdgetc+0x37>
    return -1;
ffff8000001043fe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000104403:	e9 ae 01 00 00       	jmp    ffff8000001045b6 <kbdgetc+0x1e5>
  data = inb(KBDATAP);
ffff800000104408:	bf 60 00 00 00       	mov    $0x60,%edi
ffff80000010440d:	48 b8 af 43 10 00 00 	movabs $0xffff8000001043af,%rax
ffff800000104414:	80 ff ff 
ffff800000104417:	ff d0                	call   *%rax
ffff800000104419:	0f b6 c0             	movzbl %al,%eax
ffff80000010441c:	89 45 fc             	mov    %eax,-0x4(%rbp)

  if(data == 0xE0){
ffff80000010441f:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%rbp)
ffff800000104426:	75 27                	jne    ffff80000010444f <kbdgetc+0x7e>
    shift |= E0ESC;
ffff800000104428:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff80000010442f:	80 ff ff 
ffff800000104432:	8b 00                	mov    (%rax),%eax
ffff800000104434:	83 c8 40             	or     $0x40,%eax
ffff800000104437:	89 c2                	mov    %eax,%edx
ffff800000104439:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff800000104440:	80 ff ff 
ffff800000104443:	89 10                	mov    %edx,(%rax)
    return 0;
ffff800000104445:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010444a:	e9 67 01 00 00       	jmp    ffff8000001045b6 <kbdgetc+0x1e5>
  } else if(data & 0x80){
ffff80000010444f:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104452:	25 80 00 00 00       	and    $0x80,%eax
ffff800000104457:	85 c0                	test   %eax,%eax
ffff800000104459:	74 60                	je     ffff8000001044bb <kbdgetc+0xea>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
ffff80000010445b:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff800000104462:	80 ff ff 
ffff800000104465:	8b 00                	mov    (%rax),%eax
ffff800000104467:	83 e0 40             	and    $0x40,%eax
ffff80000010446a:	85 c0                	test   %eax,%eax
ffff80000010446c:	75 08                	jne    ffff800000104476 <kbdgetc+0xa5>
ffff80000010446e:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104471:	83 e0 7f             	and    $0x7f,%eax
ffff800000104474:	eb 03                	jmp    ffff800000104479 <kbdgetc+0xa8>
ffff800000104476:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104479:	89 45 fc             	mov    %eax,-0x4(%rbp)
    shift &= ~(shiftcode[data] | E0ESC);
ffff80000010447c:	48 ba 20 d0 10 00 00 	movabs $0xffff80000010d020,%rdx
ffff800000104483:	80 ff ff 
ffff800000104486:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104489:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
ffff80000010448d:	83 c8 40             	or     $0x40,%eax
ffff800000104490:	0f b6 c0             	movzbl %al,%eax
ffff800000104493:	f7 d0                	not    %eax
ffff800000104495:	89 c2                	mov    %eax,%edx
ffff800000104497:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff80000010449e:	80 ff ff 
ffff8000001044a1:	8b 00                	mov    (%rax),%eax
ffff8000001044a3:	21 c2                	and    %eax,%edx
ffff8000001044a5:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff8000001044ac:	80 ff ff 
ffff8000001044af:	89 10                	mov    %edx,(%rax)
    return 0;
ffff8000001044b1:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001044b6:	e9 fb 00 00 00       	jmp    ffff8000001045b6 <kbdgetc+0x1e5>
  } else if(shift & E0ESC){
ffff8000001044bb:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff8000001044c2:	80 ff ff 
ffff8000001044c5:	8b 00                	mov    (%rax),%eax
ffff8000001044c7:	83 e0 40             	and    $0x40,%eax
ffff8000001044ca:	85 c0                	test   %eax,%eax
ffff8000001044cc:	74 24                	je     ffff8000001044f2 <kbdgetc+0x121>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
ffff8000001044ce:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%rbp)
    shift &= ~E0ESC;
ffff8000001044d5:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff8000001044dc:	80 ff ff 
ffff8000001044df:	8b 00                	mov    (%rax),%eax
ffff8000001044e1:	83 e0 bf             	and    $0xffffffbf,%eax
ffff8000001044e4:	89 c2                	mov    %eax,%edx
ffff8000001044e6:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff8000001044ed:	80 ff ff 
ffff8000001044f0:	89 10                	mov    %edx,(%rax)
  }

  shift |= shiftcode[data];
ffff8000001044f2:	48 ba 20 d0 10 00 00 	movabs $0xffff80000010d020,%rdx
ffff8000001044f9:	80 ff ff 
ffff8000001044fc:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001044ff:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
ffff800000104503:	0f b6 d0             	movzbl %al,%edx
ffff800000104506:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff80000010450d:	80 ff ff 
ffff800000104510:	8b 00                	mov    (%rax),%eax
ffff800000104512:	09 c2                	or     %eax,%edx
ffff800000104514:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff80000010451b:	80 ff ff 
ffff80000010451e:	89 10                	mov    %edx,(%rax)
  shift ^= togglecode[data];
ffff800000104520:	48 ba 20 d1 10 00 00 	movabs $0xffff80000010d120,%rdx
ffff800000104527:	80 ff ff 
ffff80000010452a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010452d:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
ffff800000104531:	0f b6 d0             	movzbl %al,%edx
ffff800000104534:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff80000010453b:	80 ff ff 
ffff80000010453e:	8b 00                	mov    (%rax),%eax
ffff800000104540:	31 c2                	xor    %eax,%edx
ffff800000104542:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff800000104549:	80 ff ff 
ffff80000010454c:	89 10                	mov    %edx,(%rax)
  c = charcode[shift & (CTL | SHIFT)][data];
ffff80000010454e:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff800000104555:	80 ff ff 
ffff800000104558:	8b 00                	mov    (%rax),%eax
ffff80000010455a:	83 e0 03             	and    $0x3,%eax
ffff80000010455d:	89 c2                	mov    %eax,%edx
ffff80000010455f:	48 b8 20 d5 10 00 00 	movabs $0xffff80000010d520,%rax
ffff800000104566:	80 ff ff 
ffff800000104569:	89 d2                	mov    %edx,%edx
ffff80000010456b:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
ffff80000010456f:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104572:	48 01 d0             	add    %rdx,%rax
ffff800000104575:	0f b6 00             	movzbl (%rax),%eax
ffff800000104578:	0f b6 c0             	movzbl %al,%eax
ffff80000010457b:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(shift & CAPSLOCK){
ffff80000010457e:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff800000104585:	80 ff ff 
ffff800000104588:	8b 00                	mov    (%rax),%eax
ffff80000010458a:	83 e0 08             	and    $0x8,%eax
ffff80000010458d:	85 c0                	test   %eax,%eax
ffff80000010458f:	74 22                	je     ffff8000001045b3 <kbdgetc+0x1e2>
    if('a' <= c && c <= 'z')
ffff800000104591:	83 7d f8 60          	cmpl   $0x60,-0x8(%rbp)
ffff800000104595:	76 0c                	jbe    ffff8000001045a3 <kbdgetc+0x1d2>
ffff800000104597:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%rbp)
ffff80000010459b:	77 06                	ja     ffff8000001045a3 <kbdgetc+0x1d2>
      c += 'A' - 'a';
ffff80000010459d:	83 6d f8 20          	subl   $0x20,-0x8(%rbp)
ffff8000001045a1:	eb 10                	jmp    ffff8000001045b3 <kbdgetc+0x1e2>
    else if('A' <= c && c <= 'Z')
ffff8000001045a3:	83 7d f8 40          	cmpl   $0x40,-0x8(%rbp)
ffff8000001045a7:	76 0a                	jbe    ffff8000001045b3 <kbdgetc+0x1e2>
ffff8000001045a9:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%rbp)
ffff8000001045ad:	77 04                	ja     ffff8000001045b3 <kbdgetc+0x1e2>
      c += 'a' - 'A';
ffff8000001045af:	83 45 f8 20          	addl   $0x20,-0x8(%rbp)
  }
  return c;
ffff8000001045b3:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
ffff8000001045b6:	c9                   	leave
ffff8000001045b7:	c3                   	ret

ffff8000001045b8 <kbdintr>:

void
kbdintr(void)
{
ffff8000001045b8:	f3 0f 1e fa          	endbr64
ffff8000001045bc:	55                   	push   %rbp
ffff8000001045bd:	48 89 e5             	mov    %rsp,%rbp
  consoleintr(kbdgetc);
ffff8000001045c0:	48 b8 d1 43 10 00 00 	movabs $0xffff8000001043d1,%rax
ffff8000001045c7:	80 ff ff 
ffff8000001045ca:	48 89 c7             	mov    %rax,%rdi
ffff8000001045cd:	48 b8 b5 0f 10 00 00 	movabs $0xffff800000100fb5,%rax
ffff8000001045d4:	80 ff ff 
ffff8000001045d7:	ff d0                	call   *%rax
}
ffff8000001045d9:	90                   	nop
ffff8000001045da:	5d                   	pop    %rbp
ffff8000001045db:	c3                   	ret

ffff8000001045dc <inb>:
// The local APIC manages internal (non-I/O) interrupts.
// See Chapter 8 & Appendix C of Intel processor manual volume 3.

#include "param.h"
#include "types.h"
ffff8000001045dc:	f3 0f 1e fa          	endbr64
ffff8000001045e0:	55                   	push   %rbp
ffff8000001045e1:	48 89 e5             	mov    %rsp,%rbp
ffff8000001045e4:	48 83 ec 18          	sub    $0x18,%rsp
ffff8000001045e8:	89 f8                	mov    %edi,%eax
ffff8000001045ea:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
#include "defs.h"
#include "date.h"
#include "memlayout.h"
ffff8000001045ee:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff8000001045f2:	89 c2                	mov    %eax,%edx
ffff8000001045f4:	ec                   	in     (%dx),%al
ffff8000001045f5:	88 45 ff             	mov    %al,-0x1(%rbp)
#include "traps.h"
ffff8000001045f8:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
#include "mmu.h"
ffff8000001045fc:	c9                   	leave
ffff8000001045fd:	c3                   	ret

ffff8000001045fe <outb>:
#define EOI     (0x00B0/4)   // EOI
#define SVR     (0x00F0/4)   // Spurious Interrupt Vector
  #define ENABLE     0x00000100   // Unit Enable
#define ESR     (0x0280/4)   // Error Status
#define ICRLO   (0x0300/4)   // Interrupt Command
  #define INIT       0x00000500   // INIT/RESET
ffff8000001045fe:	f3 0f 1e fa          	endbr64
ffff800000104602:	55                   	push   %rbp
ffff800000104603:	48 89 e5             	mov    %rsp,%rbp
ffff800000104606:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010460a:	89 fa                	mov    %edi,%edx
ffff80000010460c:	89 f0                	mov    %esi,%eax
ffff80000010460e:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffff800000104612:	88 45 f8             	mov    %al,-0x8(%rbp)
  #define STARTUP    0x00000600   // Startup IPI
ffff800000104615:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffff800000104619:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffff80000010461d:	ee                   	out    %al,(%dx)
  #define DELIVS     0x00001000   // Delivery status
ffff80000010461e:	90                   	nop
ffff80000010461f:	c9                   	leave
ffff800000104620:	c3                   	ret

ffff800000104621 <readeflags>:
cpunum(void)
{
  int apicid, i;

  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
ffff800000104621:	f3 0f 1e fa          	endbr64
ffff800000104625:	55                   	push   %rbp
ffff800000104626:	48 89 e5             	mov    %rsp,%rbp
ffff800000104629:	48 83 ec 10          	sub    $0x10,%rsp
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
ffff80000010462d:	9c                   	pushf
ffff80000010462e:	58                   	pop    %rax
ffff80000010462f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  // often indirectly through acquire and release.
ffff800000104633:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  if(readeflags()&FL_IF){
ffff800000104637:	c9                   	leave
ffff800000104638:	c3                   	ret

ffff800000104639 <lapicw>:
{
ffff800000104639:	f3 0f 1e fa          	endbr64
ffff80000010463d:	55                   	push   %rbp
ffff80000010463e:	48 89 e5             	mov    %rsp,%rbp
ffff800000104641:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000104645:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff800000104648:	89 75 f8             	mov    %esi,-0x8(%rbp)
  lapic[index] = value;
ffff80000010464b:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff800000104652:	80 ff ff 
ffff800000104655:	48 8b 00             	mov    (%rax),%rax
ffff800000104658:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010465b:	48 63 d2             	movslq %edx,%rdx
ffff80000010465e:	48 c1 e2 02          	shl    $0x2,%rdx
ffff800000104662:	48 01 c2             	add    %rax,%rdx
ffff800000104665:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000104668:	89 02                	mov    %eax,(%rdx)
  lapic[ID];  // wait for write to finish, by reading
ffff80000010466a:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff800000104671:	80 ff ff 
ffff800000104674:	48 8b 00             	mov    (%rax),%rax
ffff800000104677:	48 83 c0 20          	add    $0x20,%rax
ffff80000010467b:	8b 00                	mov    (%rax),%eax
}
ffff80000010467d:	90                   	nop
ffff80000010467e:	c9                   	leave
ffff80000010467f:	c3                   	ret

ffff800000104680 <lapicinit>:
{
ffff800000104680:	f3 0f 1e fa          	endbr64
ffff800000104684:	55                   	push   %rbp
ffff800000104685:	48 89 e5             	mov    %rsp,%rbp
  if(!lapic)
ffff800000104688:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff80000010468f:	80 ff ff 
ffff800000104692:	48 8b 00             	mov    (%rax),%rax
ffff800000104695:	48 85 c0             	test   %rax,%rax
ffff800000104698:	0f 84 71 01 00 00    	je     ffff80000010480f <lapicinit+0x18f>
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
ffff80000010469e:	be 3f 01 00 00       	mov    $0x13f,%esi
ffff8000001046a3:	bf 3c 00 00 00       	mov    $0x3c,%edi
ffff8000001046a8:	48 b8 39 46 10 00 00 	movabs $0xffff800000104639,%rax
ffff8000001046af:	80 ff ff 
ffff8000001046b2:	ff d0                	call   *%rax
  lapicw(TDCR, X1);
ffff8000001046b4:	be 0b 00 00 00       	mov    $0xb,%esi
ffff8000001046b9:	bf f8 00 00 00       	mov    $0xf8,%edi
ffff8000001046be:	48 b8 39 46 10 00 00 	movabs $0xffff800000104639,%rax
ffff8000001046c5:	80 ff ff 
ffff8000001046c8:	ff d0                	call   *%rax
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
ffff8000001046ca:	be 20 00 02 00       	mov    $0x20020,%esi
ffff8000001046cf:	bf c8 00 00 00       	mov    $0xc8,%edi
ffff8000001046d4:	48 b8 39 46 10 00 00 	movabs $0xffff800000104639,%rax
ffff8000001046db:	80 ff ff 
ffff8000001046de:	ff d0                	call   *%rax
  lapicw(TICR, 10000000);
ffff8000001046e0:	be 80 96 98 00       	mov    $0x989680,%esi
ffff8000001046e5:	bf e0 00 00 00       	mov    $0xe0,%edi
ffff8000001046ea:	48 b8 39 46 10 00 00 	movabs $0xffff800000104639,%rax
ffff8000001046f1:	80 ff ff 
ffff8000001046f4:	ff d0                	call   *%rax
  lapicw(LINT0, MASKED);
ffff8000001046f6:	be 00 00 01 00       	mov    $0x10000,%esi
ffff8000001046fb:	bf d4 00 00 00       	mov    $0xd4,%edi
ffff800000104700:	48 b8 39 46 10 00 00 	movabs $0xffff800000104639,%rax
ffff800000104707:	80 ff ff 
ffff80000010470a:	ff d0                	call   *%rax
  lapicw(LINT1, MASKED);
ffff80000010470c:	be 00 00 01 00       	mov    $0x10000,%esi
ffff800000104711:	bf d8 00 00 00       	mov    $0xd8,%edi
ffff800000104716:	48 b8 39 46 10 00 00 	movabs $0xffff800000104639,%rax
ffff80000010471d:	80 ff ff 
ffff800000104720:	ff d0                	call   *%rax
  if(((lapic[VER]>>16) & 0xFF) >= 4)
ffff800000104722:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff800000104729:	80 ff ff 
ffff80000010472c:	48 8b 00             	mov    (%rax),%rax
ffff80000010472f:	48 83 c0 30          	add    $0x30,%rax
ffff800000104733:	8b 00                	mov    (%rax),%eax
ffff800000104735:	25 00 00 fc 00       	and    $0xfc0000,%eax
ffff80000010473a:	85 c0                	test   %eax,%eax
ffff80000010473c:	74 16                	je     ffff800000104754 <lapicinit+0xd4>
    lapicw(PCINT, MASKED);
ffff80000010473e:	be 00 00 01 00       	mov    $0x10000,%esi
ffff800000104743:	bf d0 00 00 00       	mov    $0xd0,%edi
ffff800000104748:	48 b8 39 46 10 00 00 	movabs $0xffff800000104639,%rax
ffff80000010474f:	80 ff ff 
ffff800000104752:	ff d0                	call   *%rax
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
ffff800000104754:	be 33 00 00 00       	mov    $0x33,%esi
ffff800000104759:	bf dc 00 00 00       	mov    $0xdc,%edi
ffff80000010475e:	48 b8 39 46 10 00 00 	movabs $0xffff800000104639,%rax
ffff800000104765:	80 ff ff 
ffff800000104768:	ff d0                	call   *%rax
  lapicw(ESR, 0);
ffff80000010476a:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010476f:	bf a0 00 00 00       	mov    $0xa0,%edi
ffff800000104774:	48 b8 39 46 10 00 00 	movabs $0xffff800000104639,%rax
ffff80000010477b:	80 ff ff 
ffff80000010477e:	ff d0                	call   *%rax
  lapicw(ESR, 0);
ffff800000104780:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000104785:	bf a0 00 00 00       	mov    $0xa0,%edi
ffff80000010478a:	48 b8 39 46 10 00 00 	movabs $0xffff800000104639,%rax
ffff800000104791:	80 ff ff 
ffff800000104794:	ff d0                	call   *%rax
  lapicw(EOI, 0);
ffff800000104796:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010479b:	bf 2c 00 00 00       	mov    $0x2c,%edi
ffff8000001047a0:	48 b8 39 46 10 00 00 	movabs $0xffff800000104639,%rax
ffff8000001047a7:	80 ff ff 
ffff8000001047aa:	ff d0                	call   *%rax
  lapicw(ICRHI, 0);
ffff8000001047ac:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001047b1:	bf c4 00 00 00       	mov    $0xc4,%edi
ffff8000001047b6:	48 b8 39 46 10 00 00 	movabs $0xffff800000104639,%rax
ffff8000001047bd:	80 ff ff 
ffff8000001047c0:	ff d0                	call   *%rax
  lapicw(ICRLO, BCAST | INIT | LEVEL);
ffff8000001047c2:	be 00 85 08 00       	mov    $0x88500,%esi
ffff8000001047c7:	bf c0 00 00 00       	mov    $0xc0,%edi
ffff8000001047cc:	48 b8 39 46 10 00 00 	movabs $0xffff800000104639,%rax
ffff8000001047d3:	80 ff ff 
ffff8000001047d6:	ff d0                	call   *%rax
  while(lapic[ICRLO] & DELIVS)
ffff8000001047d8:	90                   	nop
ffff8000001047d9:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff8000001047e0:	80 ff ff 
ffff8000001047e3:	48 8b 00             	mov    (%rax),%rax
ffff8000001047e6:	48 05 00 03 00 00    	add    $0x300,%rax
ffff8000001047ec:	8b 00                	mov    (%rax),%eax
ffff8000001047ee:	25 00 10 00 00       	and    $0x1000,%eax
ffff8000001047f3:	85 c0                	test   %eax,%eax
ffff8000001047f5:	75 e2                	jne    ffff8000001047d9 <lapicinit+0x159>
  lapicw(TPR, 0);
ffff8000001047f7:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001047fc:	bf 20 00 00 00       	mov    $0x20,%edi
ffff800000104801:	48 b8 39 46 10 00 00 	movabs $0xffff800000104639,%rax
ffff800000104808:	80 ff ff 
ffff80000010480b:	ff d0                	call   *%rax
ffff80000010480d:	eb 01                	jmp    ffff800000104810 <lapicinit+0x190>
    return;
ffff80000010480f:	90                   	nop
}
ffff800000104810:	5d                   	pop    %rbp
ffff800000104811:	c3                   	ret

ffff800000104812 <cpunum>:
{
ffff800000104812:	f3 0f 1e fa          	endbr64
ffff800000104816:	55                   	push   %rbp
ffff800000104817:	48 89 e5             	mov    %rsp,%rbp
ffff80000010481a:	48 83 ec 10          	sub    $0x10,%rsp
  if(readeflags()&FL_IF){
ffff80000010481e:	48 b8 21 46 10 00 00 	movabs $0xffff800000104621,%rax
ffff800000104825:	80 ff ff 
ffff800000104828:	ff d0                	call   *%rax
ffff80000010482a:	25 00 02 00 00       	and    $0x200,%eax
ffff80000010482f:	48 85 c0             	test   %rax,%rax
ffff800000104832:	74 44                	je     ffff800000104878 <cpunum+0x66>
    static int n;
    if(n++ == 0)
ffff800000104834:	48 b8 c8 71 11 00 00 	movabs $0xffff8000001171c8,%rax
ffff80000010483b:	80 ff ff 
ffff80000010483e:	8b 00                	mov    (%rax),%eax
ffff800000104840:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000104843:	48 b9 c8 71 11 00 00 	movabs $0xffff8000001171c8,%rcx
ffff80000010484a:	80 ff ff 
ffff80000010484d:	89 11                	mov    %edx,(%rcx)
ffff80000010484f:	85 c0                	test   %eax,%eax
ffff800000104851:	75 25                	jne    ffff800000104878 <cpunum+0x66>
      cprintf("cpu called from %x with interrupts enabled\n",
ffff800000104853:	48 8b 45 08          	mov    0x8(%rbp),%rax
ffff800000104857:	48 89 c6             	mov    %rax,%rsi
ffff80000010485a:	48 b8 68 c6 10 00 00 	movabs $0xffff80000010c668,%rax
ffff800000104861:	80 ff ff 
ffff800000104864:	48 89 c7             	mov    %rax,%rdi
ffff800000104867:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010486c:	48 ba 38 08 10 00 00 	movabs $0xffff800000100838,%rdx
ffff800000104873:	80 ff ff 
ffff800000104876:	ff d2                	call   *%rdx
        __builtin_return_address(0));
  }

  if (!lapic)
ffff800000104878:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff80000010487f:	80 ff ff 
ffff800000104882:	48 8b 00             	mov    (%rax),%rax
ffff800000104885:	48 85 c0             	test   %rax,%rax
ffff800000104888:	75 0a                	jne    ffff800000104894 <cpunum+0x82>
    return 0;
ffff80000010488a:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010488f:	e9 85 00 00 00       	jmp    ffff800000104919 <cpunum+0x107>

  apicid = lapic[ID] >> 24;
ffff800000104894:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff80000010489b:	80 ff ff 
ffff80000010489e:	48 8b 00             	mov    (%rax),%rax
ffff8000001048a1:	48 83 c0 20          	add    $0x20,%rax
ffff8000001048a5:	8b 00                	mov    (%rax),%eax
ffff8000001048a7:	c1 e8 18             	shr    $0x18,%eax
ffff8000001048aa:	89 45 f8             	mov    %eax,-0x8(%rbp)
  for (i = 0; i < ncpu; ++i) {
ffff8000001048ad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001048b4:	eb 39                	jmp    ffff8000001048ef <cpunum+0xdd>
    if (cpus[i].apicid == apicid)
ffff8000001048b6:	48 b9 e0 72 11 00 00 	movabs $0xffff8000001172e0,%rcx
ffff8000001048bd:	80 ff ff 
ffff8000001048c0:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001048c3:	48 63 d0             	movslq %eax,%rdx
ffff8000001048c6:	48 89 d0             	mov    %rdx,%rax
ffff8000001048c9:	48 c1 e0 02          	shl    $0x2,%rax
ffff8000001048cd:	48 01 d0             	add    %rdx,%rax
ffff8000001048d0:	48 c1 e0 03          	shl    $0x3,%rax
ffff8000001048d4:	48 01 c8             	add    %rcx,%rax
ffff8000001048d7:	48 83 c0 01          	add    $0x1,%rax
ffff8000001048db:	0f b6 00             	movzbl (%rax),%eax
ffff8000001048de:	0f b6 c0             	movzbl %al,%eax
ffff8000001048e1:	39 45 f8             	cmp    %eax,-0x8(%rbp)
ffff8000001048e4:	75 05                	jne    ffff8000001048eb <cpunum+0xd9>
      return i;
ffff8000001048e6:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001048e9:	eb 2e                	jmp    ffff800000104919 <cpunum+0x107>
  for (i = 0; i < ncpu; ++i) {
ffff8000001048eb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001048ef:	48 b8 20 74 11 00 00 	movabs $0xffff800000117420,%rax
ffff8000001048f6:	80 ff ff 
ffff8000001048f9:	8b 00                	mov    (%rax),%eax
ffff8000001048fb:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff8000001048fe:	7c b6                	jl     ffff8000001048b6 <cpunum+0xa4>
  }
  panic("unknown apicid\n");
ffff800000104900:	48 b8 94 c6 10 00 00 	movabs $0xffff80000010c694,%rax
ffff800000104907:	80 ff ff 
ffff80000010490a:	48 89 c7             	mov    %rax,%rdi
ffff80000010490d:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000104914:	80 ff ff 
ffff800000104917:	ff d0                	call   *%rax
}
ffff800000104919:	c9                   	leave
ffff80000010491a:	c3                   	ret

ffff80000010491b <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
ffff80000010491b:	f3 0f 1e fa          	endbr64
ffff80000010491f:	55                   	push   %rbp
ffff800000104920:	48 89 e5             	mov    %rsp,%rbp
  if(lapic)
ffff800000104923:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff80000010492a:	80 ff ff 
ffff80000010492d:	48 8b 00             	mov    (%rax),%rax
ffff800000104930:	48 85 c0             	test   %rax,%rax
ffff800000104933:	74 16                	je     ffff80000010494b <lapiceoi+0x30>
    lapicw(EOI, 0);
ffff800000104935:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010493a:	bf 2c 00 00 00       	mov    $0x2c,%edi
ffff80000010493f:	48 b8 39 46 10 00 00 	movabs $0xffff800000104639,%rax
ffff800000104946:	80 ff ff 
ffff800000104949:	ff d0                	call   *%rax
}
ffff80000010494b:	90                   	nop
ffff80000010494c:	5d                   	pop    %rbp
ffff80000010494d:	c3                   	ret

ffff80000010494e <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
ffff80000010494e:	f3 0f 1e fa          	endbr64
ffff800000104952:	55                   	push   %rbp
ffff800000104953:	48 89 e5             	mov    %rsp,%rbp
ffff800000104956:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010495a:	89 7d fc             	mov    %edi,-0x4(%rbp)
}
ffff80000010495d:	90                   	nop
ffff80000010495e:	c9                   	leave
ffff80000010495f:	c3                   	ret

ffff800000104960 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
ffff800000104960:	f3 0f 1e fa          	endbr64
ffff800000104964:	55                   	push   %rbp
ffff800000104965:	48 89 e5             	mov    %rsp,%rbp
ffff800000104968:	48 83 ec 18          	sub    $0x18,%rsp
ffff80000010496c:	89 f8                	mov    %edi,%eax
ffff80000010496e:	89 75 e8             	mov    %esi,-0x18(%rbp)
ffff800000104971:	88 45 ec             	mov    %al,-0x14(%rbp)
  ushort *wrv;

  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
ffff800000104974:	be 0f 00 00 00       	mov    $0xf,%esi
ffff800000104979:	bf 70 00 00 00       	mov    $0x70,%edi
ffff80000010497e:	48 b8 fe 45 10 00 00 	movabs $0xffff8000001045fe,%rax
ffff800000104985:	80 ff ff 
ffff800000104988:	ff d0                	call   *%rax
  outb(CMOS_PORT+1, 0x0A);
ffff80000010498a:	be 0a 00 00 00       	mov    $0xa,%esi
ffff80000010498f:	bf 71 00 00 00       	mov    $0x71,%edi
ffff800000104994:	48 b8 fe 45 10 00 00 	movabs $0xffff8000001045fe,%rax
ffff80000010499b:	80 ff ff 
ffff80000010499e:	ff d0                	call   *%rax
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
ffff8000001049a0:	48 b8 67 04 00 00 00 	movabs $0xffff800000000467,%rax
ffff8000001049a7:	80 ff ff 
ffff8000001049aa:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  wrv[0] = 0;
ffff8000001049ae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001049b2:	66 c7 00 00 00       	movw   $0x0,(%rax)
  wrv[1] = addr >> 4;
ffff8000001049b7:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff8000001049ba:	c1 e8 04             	shr    $0x4,%eax
ffff8000001049bd:	89 c2                	mov    %eax,%edx
ffff8000001049bf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001049c3:	48 83 c0 02          	add    $0x2,%rax
ffff8000001049c7:	66 89 10             	mov    %dx,(%rax)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
ffff8000001049ca:	0f b6 45 ec          	movzbl -0x14(%rbp),%eax
ffff8000001049ce:	c1 e0 18             	shl    $0x18,%eax
ffff8000001049d1:	89 c6                	mov    %eax,%esi
ffff8000001049d3:	bf c4 00 00 00       	mov    $0xc4,%edi
ffff8000001049d8:	48 b8 39 46 10 00 00 	movabs $0xffff800000104639,%rax
ffff8000001049df:	80 ff ff 
ffff8000001049e2:	ff d0                	call   *%rax
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
ffff8000001049e4:	be 00 c5 00 00       	mov    $0xc500,%esi
ffff8000001049e9:	bf c0 00 00 00       	mov    $0xc0,%edi
ffff8000001049ee:	48 b8 39 46 10 00 00 	movabs $0xffff800000104639,%rax
ffff8000001049f5:	80 ff ff 
ffff8000001049f8:	ff d0                	call   *%rax
  microdelay(200);
ffff8000001049fa:	bf c8 00 00 00       	mov    $0xc8,%edi
ffff8000001049ff:	48 b8 4e 49 10 00 00 	movabs $0xffff80000010494e,%rax
ffff800000104a06:	80 ff ff 
ffff800000104a09:	ff d0                	call   *%rax
  lapicw(ICRLO, INIT | LEVEL);
ffff800000104a0b:	be 00 85 00 00       	mov    $0x8500,%esi
ffff800000104a10:	bf c0 00 00 00       	mov    $0xc0,%edi
ffff800000104a15:	48 b8 39 46 10 00 00 	movabs $0xffff800000104639,%rax
ffff800000104a1c:	80 ff ff 
ffff800000104a1f:	ff d0                	call   *%rax
  microdelay(100);    // should be 10ms, but too slow in Bochs!
ffff800000104a21:	bf 64 00 00 00       	mov    $0x64,%edi
ffff800000104a26:	48 b8 4e 49 10 00 00 	movabs $0xffff80000010494e,%rax
ffff800000104a2d:	80 ff ff 
ffff800000104a30:	ff d0                	call   *%rax
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
ffff800000104a32:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000104a39:	eb 4b                	jmp    ffff800000104a86 <lapicstartap+0x126>
    lapicw(ICRHI, apicid<<24);
ffff800000104a3b:	0f b6 45 ec          	movzbl -0x14(%rbp),%eax
ffff800000104a3f:	c1 e0 18             	shl    $0x18,%eax
ffff800000104a42:	89 c6                	mov    %eax,%esi
ffff800000104a44:	bf c4 00 00 00       	mov    $0xc4,%edi
ffff800000104a49:	48 b8 39 46 10 00 00 	movabs $0xffff800000104639,%rax
ffff800000104a50:	80 ff ff 
ffff800000104a53:	ff d0                	call   *%rax
    lapicw(ICRLO, STARTUP | (addr>>12));
ffff800000104a55:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000104a58:	c1 e8 0c             	shr    $0xc,%eax
ffff800000104a5b:	80 cc 06             	or     $0x6,%ah
ffff800000104a5e:	89 c6                	mov    %eax,%esi
ffff800000104a60:	bf c0 00 00 00       	mov    $0xc0,%edi
ffff800000104a65:	48 b8 39 46 10 00 00 	movabs $0xffff800000104639,%rax
ffff800000104a6c:	80 ff ff 
ffff800000104a6f:	ff d0                	call   *%rax
    microdelay(200);
ffff800000104a71:	bf c8 00 00 00       	mov    $0xc8,%edi
ffff800000104a76:	48 b8 4e 49 10 00 00 	movabs $0xffff80000010494e,%rax
ffff800000104a7d:	80 ff ff 
ffff800000104a80:	ff d0                	call   *%rax
  for(i = 0; i < 2; i++){
ffff800000104a82:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000104a86:	83 7d fc 01          	cmpl   $0x1,-0x4(%rbp)
ffff800000104a8a:	7e af                	jle    ffff800000104a3b <lapicstartap+0xdb>
  }
}
ffff800000104a8c:	90                   	nop
ffff800000104a8d:	90                   	nop
ffff800000104a8e:	c9                   	leave
ffff800000104a8f:	c3                   	ret

ffff800000104a90 <cmos_read>:
#define DAY     0x07
#define MONTH   0x08
#define YEAR    0x09

static uint cmos_read(uint reg)
{
ffff800000104a90:	f3 0f 1e fa          	endbr64
ffff800000104a94:	55                   	push   %rbp
ffff800000104a95:	48 89 e5             	mov    %rsp,%rbp
ffff800000104a98:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000104a9c:	89 7d fc             	mov    %edi,-0x4(%rbp)
  outb(CMOS_PORT,  reg);
ffff800000104a9f:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104aa2:	0f b6 c0             	movzbl %al,%eax
ffff800000104aa5:	89 c6                	mov    %eax,%esi
ffff800000104aa7:	bf 70 00 00 00       	mov    $0x70,%edi
ffff800000104aac:	48 b8 fe 45 10 00 00 	movabs $0xffff8000001045fe,%rax
ffff800000104ab3:	80 ff ff 
ffff800000104ab6:	ff d0                	call   *%rax
  microdelay(200);
ffff800000104ab8:	bf c8 00 00 00       	mov    $0xc8,%edi
ffff800000104abd:	48 b8 4e 49 10 00 00 	movabs $0xffff80000010494e,%rax
ffff800000104ac4:	80 ff ff 
ffff800000104ac7:	ff d0                	call   *%rax

  return inb(CMOS_RETURN);
ffff800000104ac9:	bf 71 00 00 00       	mov    $0x71,%edi
ffff800000104ace:	48 b8 dc 45 10 00 00 	movabs $0xffff8000001045dc,%rax
ffff800000104ad5:	80 ff ff 
ffff800000104ad8:	ff d0                	call   *%rax
ffff800000104ada:	0f b6 c0             	movzbl %al,%eax
}
ffff800000104add:	c9                   	leave
ffff800000104ade:	c3                   	ret

ffff800000104adf <fill_rtcdate>:

static void fill_rtcdate(struct rtcdate *r)
{
ffff800000104adf:	f3 0f 1e fa          	endbr64
ffff800000104ae3:	55                   	push   %rbp
ffff800000104ae4:	48 89 e5             	mov    %rsp,%rbp
ffff800000104ae7:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000104aeb:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  r->second = cmos_read(SECS);
ffff800000104aef:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000104af4:	48 b8 90 4a 10 00 00 	movabs $0xffff800000104a90,%rax
ffff800000104afb:	80 ff ff 
ffff800000104afe:	ff d0                	call   *%rax
ffff800000104b00:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000104b04:	89 02                	mov    %eax,(%rdx)
  r->minute = cmos_read(MINS);
ffff800000104b06:	bf 02 00 00 00       	mov    $0x2,%edi
ffff800000104b0b:	48 b8 90 4a 10 00 00 	movabs $0xffff800000104a90,%rax
ffff800000104b12:	80 ff ff 
ffff800000104b15:	ff d0                	call   *%rax
ffff800000104b17:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000104b1b:	89 42 04             	mov    %eax,0x4(%rdx)
  r->hour   = cmos_read(HOURS);
ffff800000104b1e:	bf 04 00 00 00       	mov    $0x4,%edi
ffff800000104b23:	48 b8 90 4a 10 00 00 	movabs $0xffff800000104a90,%rax
ffff800000104b2a:	80 ff ff 
ffff800000104b2d:	ff d0                	call   *%rax
ffff800000104b2f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000104b33:	89 42 08             	mov    %eax,0x8(%rdx)
  r->day    = cmos_read(DAY);
ffff800000104b36:	bf 07 00 00 00       	mov    $0x7,%edi
ffff800000104b3b:	48 b8 90 4a 10 00 00 	movabs $0xffff800000104a90,%rax
ffff800000104b42:	80 ff ff 
ffff800000104b45:	ff d0                	call   *%rax
ffff800000104b47:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000104b4b:	89 42 0c             	mov    %eax,0xc(%rdx)
  r->month  = cmos_read(MONTH);
ffff800000104b4e:	bf 08 00 00 00       	mov    $0x8,%edi
ffff800000104b53:	48 b8 90 4a 10 00 00 	movabs $0xffff800000104a90,%rax
ffff800000104b5a:	80 ff ff 
ffff800000104b5d:	ff d0                	call   *%rax
ffff800000104b5f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000104b63:	89 42 10             	mov    %eax,0x10(%rdx)
  r->year   = cmos_read(YEAR);
ffff800000104b66:	bf 09 00 00 00       	mov    $0x9,%edi
ffff800000104b6b:	48 b8 90 4a 10 00 00 	movabs $0xffff800000104a90,%rax
ffff800000104b72:	80 ff ff 
ffff800000104b75:	ff d0                	call   *%rax
ffff800000104b77:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000104b7b:	89 42 14             	mov    %eax,0x14(%rdx)
}
ffff800000104b7e:	90                   	nop
ffff800000104b7f:	c9                   	leave
ffff800000104b80:	c3                   	ret

ffff800000104b81 <cmostime>:
//PAGEBREAK!

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
ffff800000104b81:	f3 0f 1e fa          	endbr64
ffff800000104b85:	55                   	push   %rbp
ffff800000104b86:	48 89 e5             	mov    %rsp,%rbp
ffff800000104b89:	48 83 ec 50          	sub    $0x50,%rsp
ffff800000104b8d:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);
ffff800000104b91:	bf 0b 00 00 00       	mov    $0xb,%edi
ffff800000104b96:	48 b8 90 4a 10 00 00 	movabs $0xffff800000104a90,%rax
ffff800000104b9d:	80 ff ff 
ffff800000104ba0:	ff d0                	call   *%rax
ffff800000104ba2:	89 45 fc             	mov    %eax,-0x4(%rbp)

  bcd = (sb & (1 << 2)) == 0;
ffff800000104ba5:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104ba8:	83 e0 04             	and    $0x4,%eax
ffff800000104bab:	85 c0                	test   %eax,%eax
ffff800000104bad:	0f 94 c0             	sete   %al
ffff800000104bb0:	0f b6 c0             	movzbl %al,%eax
ffff800000104bb3:	89 45 f8             	mov    %eax,-0x8(%rbp)

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
ffff800000104bb6:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff800000104bba:	48 89 c7             	mov    %rax,%rdi
ffff800000104bbd:	48 b8 df 4a 10 00 00 	movabs $0xffff800000104adf,%rax
ffff800000104bc4:	80 ff ff 
ffff800000104bc7:	ff d0                	call   *%rax
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
ffff800000104bc9:	bf 0a 00 00 00       	mov    $0xa,%edi
ffff800000104bce:	48 b8 90 4a 10 00 00 	movabs $0xffff800000104a90,%rax
ffff800000104bd5:	80 ff ff 
ffff800000104bd8:	ff d0                	call   *%rax
ffff800000104bda:	25 80 00 00 00       	and    $0x80,%eax
ffff800000104bdf:	85 c0                	test   %eax,%eax
ffff800000104be1:	75 38                	jne    ffff800000104c1b <cmostime+0x9a>
        continue;
    fill_rtcdate(&t2);
ffff800000104be3:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
ffff800000104be7:	48 89 c7             	mov    %rax,%rdi
ffff800000104bea:	48 b8 df 4a 10 00 00 	movabs $0xffff800000104adf,%rax
ffff800000104bf1:	80 ff ff 
ffff800000104bf4:	ff d0                	call   *%rax
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
ffff800000104bf6:	48 8d 4d c0          	lea    -0x40(%rbp),%rcx
ffff800000104bfa:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff800000104bfe:	ba 18 00 00 00       	mov    $0x18,%edx
ffff800000104c03:	48 89 ce             	mov    %rcx,%rsi
ffff800000104c06:	48 89 c7             	mov    %rax,%rdi
ffff800000104c09:	48 b8 21 7e 10 00 00 	movabs $0xffff800000107e21,%rax
ffff800000104c10:	80 ff ff 
ffff800000104c13:	ff d0                	call   *%rax
ffff800000104c15:	85 c0                	test   %eax,%eax
ffff800000104c17:	74 05                	je     ffff800000104c1e <cmostime+0x9d>
ffff800000104c19:	eb 9b                	jmp    ffff800000104bb6 <cmostime+0x35>
        continue;
ffff800000104c1b:	90                   	nop
    fill_rtcdate(&t1);
ffff800000104c1c:	eb 98                	jmp    ffff800000104bb6 <cmostime+0x35>
      break;
ffff800000104c1e:	90                   	nop
  }

  // convert
  if(bcd) {
ffff800000104c1f:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
ffff800000104c23:	0f 84 b4 00 00 00    	je     ffff800000104cdd <cmostime+0x15c>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
ffff800000104c29:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff800000104c2c:	c1 e8 04             	shr    $0x4,%eax
ffff800000104c2f:	89 c2                	mov    %eax,%edx
ffff800000104c31:	89 d0                	mov    %edx,%eax
ffff800000104c33:	c1 e0 02             	shl    $0x2,%eax
ffff800000104c36:	01 d0                	add    %edx,%eax
ffff800000104c38:	01 c0                	add    %eax,%eax
ffff800000104c3a:	89 c2                	mov    %eax,%edx
ffff800000104c3c:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff800000104c3f:	83 e0 0f             	and    $0xf,%eax
ffff800000104c42:	01 d0                	add    %edx,%eax
ffff800000104c44:	89 45 e0             	mov    %eax,-0x20(%rbp)
    CONV(minute);
ffff800000104c47:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff800000104c4a:	c1 e8 04             	shr    $0x4,%eax
ffff800000104c4d:	89 c2                	mov    %eax,%edx
ffff800000104c4f:	89 d0                	mov    %edx,%eax
ffff800000104c51:	c1 e0 02             	shl    $0x2,%eax
ffff800000104c54:	01 d0                	add    %edx,%eax
ffff800000104c56:	01 c0                	add    %eax,%eax
ffff800000104c58:	89 c2                	mov    %eax,%edx
ffff800000104c5a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff800000104c5d:	83 e0 0f             	and    $0xf,%eax
ffff800000104c60:	01 d0                	add    %edx,%eax
ffff800000104c62:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    CONV(hour  );
ffff800000104c65:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000104c68:	c1 e8 04             	shr    $0x4,%eax
ffff800000104c6b:	89 c2                	mov    %eax,%edx
ffff800000104c6d:	89 d0                	mov    %edx,%eax
ffff800000104c6f:	c1 e0 02             	shl    $0x2,%eax
ffff800000104c72:	01 d0                	add    %edx,%eax
ffff800000104c74:	01 c0                	add    %eax,%eax
ffff800000104c76:	89 c2                	mov    %eax,%edx
ffff800000104c78:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000104c7b:	83 e0 0f             	and    $0xf,%eax
ffff800000104c7e:	01 d0                	add    %edx,%eax
ffff800000104c80:	89 45 e8             	mov    %eax,-0x18(%rbp)
    CONV(day   );
ffff800000104c83:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000104c86:	c1 e8 04             	shr    $0x4,%eax
ffff800000104c89:	89 c2                	mov    %eax,%edx
ffff800000104c8b:	89 d0                	mov    %edx,%eax
ffff800000104c8d:	c1 e0 02             	shl    $0x2,%eax
ffff800000104c90:	01 d0                	add    %edx,%eax
ffff800000104c92:	01 c0                	add    %eax,%eax
ffff800000104c94:	89 c2                	mov    %eax,%edx
ffff800000104c96:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000104c99:	83 e0 0f             	and    $0xf,%eax
ffff800000104c9c:	01 d0                	add    %edx,%eax
ffff800000104c9e:	89 45 ec             	mov    %eax,-0x14(%rbp)
    CONV(month );
ffff800000104ca1:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000104ca4:	c1 e8 04             	shr    $0x4,%eax
ffff800000104ca7:	89 c2                	mov    %eax,%edx
ffff800000104ca9:	89 d0                	mov    %edx,%eax
ffff800000104cab:	c1 e0 02             	shl    $0x2,%eax
ffff800000104cae:	01 d0                	add    %edx,%eax
ffff800000104cb0:	01 c0                	add    %eax,%eax
ffff800000104cb2:	89 c2                	mov    %eax,%edx
ffff800000104cb4:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000104cb7:	83 e0 0f             	and    $0xf,%eax
ffff800000104cba:	01 d0                	add    %edx,%eax
ffff800000104cbc:	89 45 f0             	mov    %eax,-0x10(%rbp)
    CONV(year  );
ffff800000104cbf:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000104cc2:	c1 e8 04             	shr    $0x4,%eax
ffff800000104cc5:	89 c2                	mov    %eax,%edx
ffff800000104cc7:	89 d0                	mov    %edx,%eax
ffff800000104cc9:	c1 e0 02             	shl    $0x2,%eax
ffff800000104ccc:	01 d0                	add    %edx,%eax
ffff800000104cce:	01 c0                	add    %eax,%eax
ffff800000104cd0:	89 c2                	mov    %eax,%edx
ffff800000104cd2:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000104cd5:	83 e0 0f             	and    $0xf,%eax
ffff800000104cd8:	01 d0                	add    %edx,%eax
ffff800000104cda:	89 45 f4             	mov    %eax,-0xc(%rbp)
#undef     CONV
  }

  *r = t1;
ffff800000104cdd:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
ffff800000104ce1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000104ce5:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000104ce9:	48 89 01             	mov    %rax,(%rcx)
ffff800000104cec:	48 89 51 08          	mov    %rdx,0x8(%rcx)
ffff800000104cf0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104cf4:	48 89 41 10          	mov    %rax,0x10(%rcx)
  r->year += 2000;
ffff800000104cf8:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000104cfc:	8b 40 14             	mov    0x14(%rax),%eax
ffff800000104cff:	8d 90 d0 07 00 00    	lea    0x7d0(%rax),%edx
ffff800000104d05:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000104d09:	89 50 14             	mov    %edx,0x14(%rax)
}
ffff800000104d0c:	90                   	nop
ffff800000104d0d:	c9                   	leave
ffff800000104d0e:	c3                   	ret

ffff800000104d0f <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
ffff800000104d0f:	f3 0f 1e fa          	endbr64
ffff800000104d13:	55                   	push   %rbp
ffff800000104d14:	48 89 e5             	mov    %rsp,%rbp
ffff800000104d17:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000104d1b:	89 7d dc             	mov    %edi,-0x24(%rbp)
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
ffff800000104d1e:	48 b8 a4 c6 10 00 00 	movabs $0xffff80000010c6a4,%rax
ffff800000104d25:	80 ff ff 
ffff800000104d28:	48 89 c6             	mov    %rax,%rsi
ffff800000104d2b:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104d32:	80 ff ff 
ffff800000104d35:	48 89 c7             	mov    %rax,%rdi
ffff800000104d38:	48 b8 96 79 10 00 00 	movabs $0xffff800000107996,%rax
ffff800000104d3f:	80 ff ff 
ffff800000104d42:	ff d0                	call   *%rax
  readsb(dev, &sb);
ffff800000104d44:	48 8d 55 e0          	lea    -0x20(%rbp),%rdx
ffff800000104d48:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000104d4b:	48 89 d6             	mov    %rdx,%rsi
ffff800000104d4e:	89 c7                	mov    %eax,%edi
ffff800000104d50:	48 b8 35 21 10 00 00 	movabs $0xffff800000102135,%rax
ffff800000104d57:	80 ff ff 
ffff800000104d5a:	ff d0                	call   *%rax
  log.start = sb.logstart;
ffff800000104d5c:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000104d5f:	89 c2                	mov    %eax,%edx
ffff800000104d61:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104d68:	80 ff ff 
ffff800000104d6b:	89 50 68             	mov    %edx,0x68(%rax)
  log.size = sb.nlog;
ffff800000104d6e:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000104d71:	89 c2                	mov    %eax,%edx
ffff800000104d73:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104d7a:	80 ff ff 
ffff800000104d7d:	89 50 6c             	mov    %edx,0x6c(%rax)
  log.dev = dev;
ffff800000104d80:	48 ba e0 71 11 00 00 	movabs $0xffff8000001171e0,%rdx
ffff800000104d87:	80 ff ff 
ffff800000104d8a:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000104d8d:	89 42 78             	mov    %eax,0x78(%rdx)
  recover_from_log();
ffff800000104d90:	48 b8 30 50 10 00 00 	movabs $0xffff800000105030,%rax
ffff800000104d97:	80 ff ff 
ffff800000104d9a:	ff d0                	call   *%rax
}
ffff800000104d9c:	90                   	nop
ffff800000104d9d:	c9                   	leave
ffff800000104d9e:	c3                   	ret

ffff800000104d9f <install_trans>:

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
ffff800000104d9f:	f3 0f 1e fa          	endbr64
ffff800000104da3:	55                   	push   %rbp
ffff800000104da4:	48 89 e5             	mov    %rsp,%rbp
ffff800000104da7:	48 83 ec 20          	sub    $0x20,%rsp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
ffff800000104dab:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000104db2:	e9 dc 00 00 00       	jmp    ffff800000104e93 <install_trans+0xf4>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
ffff800000104db7:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104dbe:	80 ff ff 
ffff800000104dc1:	8b 50 68             	mov    0x68(%rax),%edx
ffff800000104dc4:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104dc7:	01 d0                	add    %edx,%eax
ffff800000104dc9:	83 c0 01             	add    $0x1,%eax
ffff800000104dcc:	89 c2                	mov    %eax,%edx
ffff800000104dce:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104dd5:	80 ff ff 
ffff800000104dd8:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000104ddb:	89 d6                	mov    %edx,%esi
ffff800000104ddd:	89 c7                	mov    %eax,%edi
ffff800000104ddf:	48 b8 d4 03 10 00 00 	movabs $0xffff8000001003d4,%rax
ffff800000104de6:	80 ff ff 
ffff800000104de9:	ff d0                	call   *%rax
ffff800000104deb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
ffff800000104def:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104df6:	80 ff ff 
ffff800000104df9:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000104dfc:	48 63 d2             	movslq %edx,%rdx
ffff800000104dff:	48 83 c2 1c          	add    $0x1c,%rdx
ffff800000104e03:	8b 44 90 10          	mov    0x10(%rax,%rdx,4),%eax
ffff800000104e07:	89 c2                	mov    %eax,%edx
ffff800000104e09:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104e10:	80 ff ff 
ffff800000104e13:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000104e16:	89 d6                	mov    %edx,%esi
ffff800000104e18:	89 c7                	mov    %eax,%edi
ffff800000104e1a:	48 b8 d4 03 10 00 00 	movabs $0xffff8000001003d4,%rax
ffff800000104e21:	80 ff ff 
ffff800000104e24:	ff d0                	call   *%rax
ffff800000104e26:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
ffff800000104e2a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104e2e:	48 8d 88 b0 00 00 00 	lea    0xb0(%rax),%rcx
ffff800000104e35:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104e39:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000104e3f:	ba 00 02 00 00       	mov    $0x200,%edx
ffff800000104e44:	48 89 ce             	mov    %rcx,%rsi
ffff800000104e47:	48 89 c7             	mov    %rax,%rdi
ffff800000104e4a:	48 b8 94 7e 10 00 00 	movabs $0xffff800000107e94,%rax
ffff800000104e51:	80 ff ff 
ffff800000104e54:	ff d0                	call   *%rax
    bwrite(dbuf);  // write dst to disk
ffff800000104e56:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104e5a:	48 89 c7             	mov    %rax,%rdi
ffff800000104e5d:	48 b8 26 04 10 00 00 	movabs $0xffff800000100426,%rax
ffff800000104e64:	80 ff ff 
ffff800000104e67:	ff d0                	call   *%rax
    brelse(lbuf);
ffff800000104e69:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104e6d:	48 89 c7             	mov    %rax,%rdi
ffff800000104e70:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff800000104e77:	80 ff ff 
ffff800000104e7a:	ff d0                	call   *%rax
    brelse(dbuf);
ffff800000104e7c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104e80:	48 89 c7             	mov    %rax,%rdi
ffff800000104e83:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff800000104e8a:	80 ff ff 
ffff800000104e8d:	ff d0                	call   *%rax
  for (tail = 0; tail < log.lh.n; tail++) {
ffff800000104e8f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000104e93:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104e9a:	80 ff ff 
ffff800000104e9d:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000104ea0:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000104ea3:	0f 8c 0e ff ff ff    	jl     ffff800000104db7 <install_trans+0x18>
  }
}
ffff800000104ea9:	90                   	nop
ffff800000104eaa:	90                   	nop
ffff800000104eab:	c9                   	leave
ffff800000104eac:	c3                   	ret

ffff800000104ead <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
ffff800000104ead:	f3 0f 1e fa          	endbr64
ffff800000104eb1:	55                   	push   %rbp
ffff800000104eb2:	48 89 e5             	mov    %rsp,%rbp
ffff800000104eb5:	48 83 ec 20          	sub    $0x20,%rsp
  struct buf *buf = bread(log.dev, log.start);
ffff800000104eb9:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104ec0:	80 ff ff 
ffff800000104ec3:	8b 40 68             	mov    0x68(%rax),%eax
ffff800000104ec6:	89 c2                	mov    %eax,%edx
ffff800000104ec8:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104ecf:	80 ff ff 
ffff800000104ed2:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000104ed5:	89 d6                	mov    %edx,%esi
ffff800000104ed7:	89 c7                	mov    %eax,%edi
ffff800000104ed9:	48 b8 d4 03 10 00 00 	movabs $0xffff8000001003d4,%rax
ffff800000104ee0:	80 ff ff 
ffff800000104ee3:	ff d0                	call   *%rax
ffff800000104ee5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  struct logheader *lh = (struct logheader *) (buf->data);
ffff800000104ee9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104eed:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000104ef3:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  int i;
  log.lh.n = lh->n;
ffff800000104ef7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104efb:	8b 00                	mov    (%rax),%eax
ffff800000104efd:	48 ba e0 71 11 00 00 	movabs $0xffff8000001171e0,%rdx
ffff800000104f04:	80 ff ff 
ffff800000104f07:	89 42 7c             	mov    %eax,0x7c(%rdx)
  for (i = 0; i < log.lh.n; i++) {
ffff800000104f0a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000104f11:	eb 2a                	jmp    ffff800000104f3d <read_head+0x90>
    log.lh.block[i] = lh->block[i];
ffff800000104f13:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104f17:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000104f1a:	48 63 d2             	movslq %edx,%rdx
ffff800000104f1d:	8b 44 90 04          	mov    0x4(%rax,%rdx,4),%eax
ffff800000104f21:	48 ba e0 71 11 00 00 	movabs $0xffff8000001171e0,%rdx
ffff800000104f28:	80 ff ff 
ffff800000104f2b:	8b 4d fc             	mov    -0x4(%rbp),%ecx
ffff800000104f2e:	48 63 c9             	movslq %ecx,%rcx
ffff800000104f31:	48 83 c1 1c          	add    $0x1c,%rcx
ffff800000104f35:	89 44 8a 10          	mov    %eax,0x10(%rdx,%rcx,4)
  for (i = 0; i < log.lh.n; i++) {
ffff800000104f39:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000104f3d:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104f44:	80 ff ff 
ffff800000104f47:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000104f4a:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000104f4d:	7c c4                	jl     ffff800000104f13 <read_head+0x66>
  }
  brelse(buf);
ffff800000104f4f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104f53:	48 89 c7             	mov    %rax,%rdi
ffff800000104f56:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff800000104f5d:	80 ff ff 
ffff800000104f60:	ff d0                	call   *%rax
}
ffff800000104f62:	90                   	nop
ffff800000104f63:	c9                   	leave
ffff800000104f64:	c3                   	ret

ffff800000104f65 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
ffff800000104f65:	f3 0f 1e fa          	endbr64
ffff800000104f69:	55                   	push   %rbp
ffff800000104f6a:	48 89 e5             	mov    %rsp,%rbp
ffff800000104f6d:	48 83 ec 20          	sub    $0x20,%rsp
  struct buf *buf = bread(log.dev, log.start);
ffff800000104f71:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104f78:	80 ff ff 
ffff800000104f7b:	8b 40 68             	mov    0x68(%rax),%eax
ffff800000104f7e:	89 c2                	mov    %eax,%edx
ffff800000104f80:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104f87:	80 ff ff 
ffff800000104f8a:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000104f8d:	89 d6                	mov    %edx,%esi
ffff800000104f8f:	89 c7                	mov    %eax,%edi
ffff800000104f91:	48 b8 d4 03 10 00 00 	movabs $0xffff8000001003d4,%rax
ffff800000104f98:	80 ff ff 
ffff800000104f9b:	ff d0                	call   *%rax
ffff800000104f9d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  struct logheader *hb = (struct logheader *) (buf->data);
ffff800000104fa1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104fa5:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000104fab:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  int i;
  hb->n = log.lh.n;
ffff800000104faf:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104fb6:	80 ff ff 
ffff800000104fb9:	8b 50 7c             	mov    0x7c(%rax),%edx
ffff800000104fbc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104fc0:	89 10                	mov    %edx,(%rax)
  for (i = 0; i < log.lh.n; i++) {
ffff800000104fc2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000104fc9:	eb 2a                	jmp    ffff800000104ff5 <write_head+0x90>
    hb->block[i] = log.lh.block[i];
ffff800000104fcb:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104fd2:	80 ff ff 
ffff800000104fd5:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000104fd8:	48 63 d2             	movslq %edx,%rdx
ffff800000104fdb:	48 83 c2 1c          	add    $0x1c,%rdx
ffff800000104fdf:	8b 4c 90 10          	mov    0x10(%rax,%rdx,4),%ecx
ffff800000104fe3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104fe7:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000104fea:	48 63 d2             	movslq %edx,%rdx
ffff800000104fed:	89 4c 90 04          	mov    %ecx,0x4(%rax,%rdx,4)
  for (i = 0; i < log.lh.n; i++) {
ffff800000104ff1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000104ff5:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104ffc:	80 ff ff 
ffff800000104fff:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000105002:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000105005:	7c c4                	jl     ffff800000104fcb <write_head+0x66>
  }
  bwrite(buf);
ffff800000105007:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010500b:	48 89 c7             	mov    %rax,%rdi
ffff80000010500e:	48 b8 26 04 10 00 00 	movabs $0xffff800000100426,%rax
ffff800000105015:	80 ff ff 
ffff800000105018:	ff d0                	call   *%rax
  brelse(buf);
ffff80000010501a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010501e:	48 89 c7             	mov    %rax,%rdi
ffff800000105021:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff800000105028:	80 ff ff 
ffff80000010502b:	ff d0                	call   *%rax
}
ffff80000010502d:	90                   	nop
ffff80000010502e:	c9                   	leave
ffff80000010502f:	c3                   	ret

ffff800000105030 <recover_from_log>:

static void
recover_from_log(void)
{
ffff800000105030:	f3 0f 1e fa          	endbr64
ffff800000105034:	55                   	push   %rbp
ffff800000105035:	48 89 e5             	mov    %rsp,%rbp
  read_head();
ffff800000105038:	48 b8 ad 4e 10 00 00 	movabs $0xffff800000104ead,%rax
ffff80000010503f:	80 ff ff 
ffff800000105042:	ff d0                	call   *%rax
  install_trans(); // if committed, copy from log to disk
ffff800000105044:	48 b8 9f 4d 10 00 00 	movabs $0xffff800000104d9f,%rax
ffff80000010504b:	80 ff ff 
ffff80000010504e:	ff d0                	call   *%rax
  log.lh.n = 0;
ffff800000105050:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105057:	80 ff ff 
ffff80000010505a:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%rax)
  write_head(); // clear the log
ffff800000105061:	48 b8 65 4f 10 00 00 	movabs $0xffff800000104f65,%rax
ffff800000105068:	80 ff ff 
ffff80000010506b:	ff d0                	call   *%rax
}
ffff80000010506d:	90                   	nop
ffff80000010506e:	5d                   	pop    %rbp
ffff80000010506f:	c3                   	ret

ffff800000105070 <begin_op>:

// called at the start of each FS system call.
void
begin_op(void)
{
ffff800000105070:	f3 0f 1e fa          	endbr64
ffff800000105074:	55                   	push   %rbp
ffff800000105075:	48 89 e5             	mov    %rsp,%rbp
  acquire(&log.lock);
ffff800000105078:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010507f:	80 ff ff 
ffff800000105082:	48 89 c7             	mov    %rax,%rdi
ffff800000105085:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff80000010508c:	80 ff ff 
ffff80000010508f:	ff d0                	call   *%rax
  while(1){
    if(log.committing){
ffff800000105091:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105098:	80 ff ff 
ffff80000010509b:	8b 40 74             	mov    0x74(%rax),%eax
ffff80000010509e:	85 c0                	test   %eax,%eax
ffff8000001050a0:	74 28                	je     ffff8000001050ca <begin_op+0x5a>
      sleep(&log, &log.lock);
ffff8000001050a2:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001050a9:	80 ff ff 
ffff8000001050ac:	48 89 c6             	mov    %rax,%rsi
ffff8000001050af:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001050b6:	80 ff ff 
ffff8000001050b9:	48 89 c7             	mov    %rax,%rdi
ffff8000001050bc:	48 b8 a4 70 10 00 00 	movabs $0xffff8000001070a4,%rax
ffff8000001050c3:	80 ff ff 
ffff8000001050c6:	ff d0                	call   *%rax
ffff8000001050c8:	eb c7                	jmp    ffff800000105091 <begin_op+0x21>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
ffff8000001050ca:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001050d1:	80 ff ff 
ffff8000001050d4:	8b 48 7c             	mov    0x7c(%rax),%ecx
ffff8000001050d7:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001050de:	80 ff ff 
ffff8000001050e1:	8b 40 70             	mov    0x70(%rax),%eax
ffff8000001050e4:	8d 50 01             	lea    0x1(%rax),%edx
ffff8000001050e7:	89 d0                	mov    %edx,%eax
ffff8000001050e9:	c1 e0 02             	shl    $0x2,%eax
ffff8000001050ec:	01 d0                	add    %edx,%eax
ffff8000001050ee:	01 c0                	add    %eax,%eax
ffff8000001050f0:	01 c8                	add    %ecx,%eax
ffff8000001050f2:	83 f8 1e             	cmp    $0x1e,%eax
ffff8000001050f5:	7e 2b                	jle    ffff800000105122 <begin_op+0xb2>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
ffff8000001050f7:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001050fe:	80 ff ff 
ffff800000105101:	48 89 c6             	mov    %rax,%rsi
ffff800000105104:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010510b:	80 ff ff 
ffff80000010510e:	48 89 c7             	mov    %rax,%rdi
ffff800000105111:	48 b8 a4 70 10 00 00 	movabs $0xffff8000001070a4,%rax
ffff800000105118:	80 ff ff 
ffff80000010511b:	ff d0                	call   *%rax
ffff80000010511d:	e9 6f ff ff ff       	jmp    ffff800000105091 <begin_op+0x21>
    } else {
      log.outstanding += 1;
ffff800000105122:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105129:	80 ff ff 
ffff80000010512c:	8b 40 70             	mov    0x70(%rax),%eax
ffff80000010512f:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000105132:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105139:	80 ff ff 
ffff80000010513c:	89 50 70             	mov    %edx,0x70(%rax)
      release(&log.lock);
ffff80000010513f:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105146:	80 ff ff 
ffff800000105149:	48 89 c7             	mov    %rax,%rdi
ffff80000010514c:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff800000105153:	80 ff ff 
ffff800000105156:	ff d0                	call   *%rax
      break;
ffff800000105158:	90                   	nop
    }
  }
}
ffff800000105159:	90                   	nop
ffff80000010515a:	5d                   	pop    %rbp
ffff80000010515b:	c3                   	ret

ffff80000010515c <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
ffff80000010515c:	f3 0f 1e fa          	endbr64
ffff800000105160:	55                   	push   %rbp
ffff800000105161:	48 89 e5             	mov    %rsp,%rbp
ffff800000105164:	48 83 ec 10          	sub    $0x10,%rsp
  int do_commit = 0;
ffff800000105168:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)

  acquire(&log.lock);
ffff80000010516f:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105176:	80 ff ff 
ffff800000105179:	48 89 c7             	mov    %rax,%rdi
ffff80000010517c:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff800000105183:	80 ff ff 
ffff800000105186:	ff d0                	call   *%rax
  log.outstanding -= 1;
ffff800000105188:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010518f:	80 ff ff 
ffff800000105192:	8b 40 70             	mov    0x70(%rax),%eax
ffff800000105195:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000105198:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010519f:	80 ff ff 
ffff8000001051a2:	89 50 70             	mov    %edx,0x70(%rax)
  if(log.committing)
ffff8000001051a5:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001051ac:	80 ff ff 
ffff8000001051af:	8b 40 74             	mov    0x74(%rax),%eax
ffff8000001051b2:	85 c0                	test   %eax,%eax
ffff8000001051b4:	74 19                	je     ffff8000001051cf <end_op+0x73>
    panic("log.committing");
ffff8000001051b6:	48 b8 a8 c6 10 00 00 	movabs $0xffff80000010c6a8,%rax
ffff8000001051bd:	80 ff ff 
ffff8000001051c0:	48 89 c7             	mov    %rax,%rdi
ffff8000001051c3:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff8000001051ca:	80 ff ff 
ffff8000001051cd:	ff d0                	call   *%rax
  if(log.outstanding == 0){
ffff8000001051cf:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001051d6:	80 ff ff 
ffff8000001051d9:	8b 40 70             	mov    0x70(%rax),%eax
ffff8000001051dc:	85 c0                	test   %eax,%eax
ffff8000001051de:	75 1a                	jne    ffff8000001051fa <end_op+0x9e>
    do_commit = 1;
ffff8000001051e0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
    log.committing = 1;
ffff8000001051e7:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001051ee:	80 ff ff 
ffff8000001051f1:	c7 40 74 01 00 00 00 	movl   $0x1,0x74(%rax)
ffff8000001051f8:	eb 19                	jmp    ffff800000105213 <end_op+0xb7>
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
ffff8000001051fa:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105201:	80 ff ff 
ffff800000105204:	48 89 c7             	mov    %rax,%rdi
ffff800000105207:	48 b8 21 72 10 00 00 	movabs $0xffff800000107221,%rax
ffff80000010520e:	80 ff ff 
ffff800000105211:	ff d0                	call   *%rax
  }
  release(&log.lock);
ffff800000105213:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010521a:	80 ff ff 
ffff80000010521d:	48 89 c7             	mov    %rax,%rdi
ffff800000105220:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff800000105227:	80 ff ff 
ffff80000010522a:	ff d0                	call   *%rax

  if(do_commit){
ffff80000010522c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000105230:	74 6d                	je     ffff80000010529f <end_op+0x143>
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
ffff800000105232:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105237:	48 ba b0 53 10 00 00 	movabs $0xffff8000001053b0,%rdx
ffff80000010523e:	80 ff ff 
ffff800000105241:	ff d2                	call   *%rdx
    acquire(&log.lock);
ffff800000105243:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010524a:	80 ff ff 
ffff80000010524d:	48 89 c7             	mov    %rax,%rdi
ffff800000105250:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff800000105257:	80 ff ff 
ffff80000010525a:	ff d0                	call   *%rax
    log.committing = 0;
ffff80000010525c:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105263:	80 ff ff 
ffff800000105266:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%rax)
    wakeup(&log);
ffff80000010526d:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105274:	80 ff ff 
ffff800000105277:	48 89 c7             	mov    %rax,%rdi
ffff80000010527a:	48 b8 21 72 10 00 00 	movabs $0xffff800000107221,%rax
ffff800000105281:	80 ff ff 
ffff800000105284:	ff d0                	call   *%rax
    release(&log.lock);
ffff800000105286:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010528d:	80 ff ff 
ffff800000105290:	48 89 c7             	mov    %rax,%rdi
ffff800000105293:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff80000010529a:	80 ff ff 
ffff80000010529d:	ff d0                	call   *%rax
  }
}
ffff80000010529f:	90                   	nop
ffff8000001052a0:	c9                   	leave
ffff8000001052a1:	c3                   	ret

ffff8000001052a2 <write_log>:

// Copy modified blocks from cache to log.
static void
write_log(void)
{
ffff8000001052a2:	f3 0f 1e fa          	endbr64
ffff8000001052a6:	55                   	push   %rbp
ffff8000001052a7:	48 89 e5             	mov    %rsp,%rbp
ffff8000001052aa:	48 83 ec 20          	sub    $0x20,%rsp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
ffff8000001052ae:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001052b5:	e9 dc 00 00 00       	jmp    ffff800000105396 <write_log+0xf4>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
ffff8000001052ba:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001052c1:	80 ff ff 
ffff8000001052c4:	8b 50 68             	mov    0x68(%rax),%edx
ffff8000001052c7:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001052ca:	01 d0                	add    %edx,%eax
ffff8000001052cc:	83 c0 01             	add    $0x1,%eax
ffff8000001052cf:	89 c2                	mov    %eax,%edx
ffff8000001052d1:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001052d8:	80 ff ff 
ffff8000001052db:	8b 40 78             	mov    0x78(%rax),%eax
ffff8000001052de:	89 d6                	mov    %edx,%esi
ffff8000001052e0:	89 c7                	mov    %eax,%edi
ffff8000001052e2:	48 b8 d4 03 10 00 00 	movabs $0xffff8000001003d4,%rax
ffff8000001052e9:	80 ff ff 
ffff8000001052ec:	ff d0                	call   *%rax
ffff8000001052ee:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
ffff8000001052f2:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001052f9:	80 ff ff 
ffff8000001052fc:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001052ff:	48 63 d2             	movslq %edx,%rdx
ffff800000105302:	48 83 c2 1c          	add    $0x1c,%rdx
ffff800000105306:	8b 44 90 10          	mov    0x10(%rax,%rdx,4),%eax
ffff80000010530a:	89 c2                	mov    %eax,%edx
ffff80000010530c:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105313:	80 ff ff 
ffff800000105316:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000105319:	89 d6                	mov    %edx,%esi
ffff80000010531b:	89 c7                	mov    %eax,%edi
ffff80000010531d:	48 b8 d4 03 10 00 00 	movabs $0xffff8000001003d4,%rax
ffff800000105324:	80 ff ff 
ffff800000105327:	ff d0                	call   *%rax
ffff800000105329:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    memmove(to->data, from->data, BSIZE);
ffff80000010532d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105331:	48 8d 88 b0 00 00 00 	lea    0xb0(%rax),%rcx
ffff800000105338:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010533c:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000105342:	ba 00 02 00 00       	mov    $0x200,%edx
ffff800000105347:	48 89 ce             	mov    %rcx,%rsi
ffff80000010534a:	48 89 c7             	mov    %rax,%rdi
ffff80000010534d:	48 b8 94 7e 10 00 00 	movabs $0xffff800000107e94,%rax
ffff800000105354:	80 ff ff 
ffff800000105357:	ff d0                	call   *%rax
    bwrite(to);  // write the log
ffff800000105359:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010535d:	48 89 c7             	mov    %rax,%rdi
ffff800000105360:	48 b8 26 04 10 00 00 	movabs $0xffff800000100426,%rax
ffff800000105367:	80 ff ff 
ffff80000010536a:	ff d0                	call   *%rax
    brelse(from);
ffff80000010536c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105370:	48 89 c7             	mov    %rax,%rdi
ffff800000105373:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff80000010537a:	80 ff ff 
ffff80000010537d:	ff d0                	call   *%rax
    brelse(to);
ffff80000010537f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105383:	48 89 c7             	mov    %rax,%rdi
ffff800000105386:	48 b8 91 04 10 00 00 	movabs $0xffff800000100491,%rax
ffff80000010538d:	80 ff ff 
ffff800000105390:	ff d0                	call   *%rax
  for (tail = 0; tail < log.lh.n; tail++) {
ffff800000105392:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000105396:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010539d:	80 ff ff 
ffff8000001053a0:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff8000001053a3:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff8000001053a6:	0f 8c 0e ff ff ff    	jl     ffff8000001052ba <write_log+0x18>
  }
}
ffff8000001053ac:	90                   	nop
ffff8000001053ad:	90                   	nop
ffff8000001053ae:	c9                   	leave
ffff8000001053af:	c3                   	ret

ffff8000001053b0 <commit>:

static void
commit()
{
ffff8000001053b0:	f3 0f 1e fa          	endbr64
ffff8000001053b4:	55                   	push   %rbp
ffff8000001053b5:	48 89 e5             	mov    %rsp,%rbp
  if (log.lh.n > 0) {
ffff8000001053b8:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001053bf:	80 ff ff 
ffff8000001053c2:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff8000001053c5:	85 c0                	test   %eax,%eax
ffff8000001053c7:	7e 41                	jle    ffff80000010540a <commit+0x5a>
    write_log();     // Write modified blocks from cache to log
ffff8000001053c9:	48 b8 a2 52 10 00 00 	movabs $0xffff8000001052a2,%rax
ffff8000001053d0:	80 ff ff 
ffff8000001053d3:	ff d0                	call   *%rax
    write_head();    // Write header to disk -- the real commit
ffff8000001053d5:	48 b8 65 4f 10 00 00 	movabs $0xffff800000104f65,%rax
ffff8000001053dc:	80 ff ff 
ffff8000001053df:	ff d0                	call   *%rax
    install_trans(); // Now install writes to home locations
ffff8000001053e1:	48 b8 9f 4d 10 00 00 	movabs $0xffff800000104d9f,%rax
ffff8000001053e8:	80 ff ff 
ffff8000001053eb:	ff d0                	call   *%rax
    log.lh.n = 0;
ffff8000001053ed:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001053f4:	80 ff ff 
ffff8000001053f7:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%rax)
    write_head();    // Erase the transaction from the log
ffff8000001053fe:	48 b8 65 4f 10 00 00 	movabs $0xffff800000104f65,%rax
ffff800000105405:	80 ff ff 
ffff800000105408:	ff d0                	call   *%rax
  }
}
ffff80000010540a:	90                   	nop
ffff80000010540b:	5d                   	pop    %rbp
ffff80000010540c:	c3                   	ret

ffff80000010540d <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
ffff80000010540d:	f3 0f 1e fa          	endbr64
ffff800000105411:	55                   	push   %rbp
ffff800000105412:	48 89 e5             	mov    %rsp,%rbp
ffff800000105415:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000105419:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
ffff80000010541d:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105424:	80 ff ff 
ffff800000105427:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff80000010542a:	83 f8 1d             	cmp    $0x1d,%eax
ffff80000010542d:	7f 21                	jg     ffff800000105450 <log_write+0x43>
ffff80000010542f:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105436:	80 ff ff 
ffff800000105439:	8b 50 7c             	mov    0x7c(%rax),%edx
ffff80000010543c:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105443:	80 ff ff 
ffff800000105446:	8b 40 6c             	mov    0x6c(%rax),%eax
ffff800000105449:	83 e8 01             	sub    $0x1,%eax
ffff80000010544c:	39 c2                	cmp    %eax,%edx
ffff80000010544e:	7c 19                	jl     ffff800000105469 <log_write+0x5c>
    panic("too big a transaction");
ffff800000105450:	48 b8 b7 c6 10 00 00 	movabs $0xffff80000010c6b7,%rax
ffff800000105457:	80 ff ff 
ffff80000010545a:	48 89 c7             	mov    %rax,%rdi
ffff80000010545d:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000105464:	80 ff ff 
ffff800000105467:	ff d0                	call   *%rax
  if (log.outstanding < 1)
ffff800000105469:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105470:	80 ff ff 
ffff800000105473:	8b 40 70             	mov    0x70(%rax),%eax
ffff800000105476:	85 c0                	test   %eax,%eax
ffff800000105478:	7f 19                	jg     ffff800000105493 <log_write+0x86>
    panic("log_write outside of trans");
ffff80000010547a:	48 b8 cd c6 10 00 00 	movabs $0xffff80000010c6cd,%rax
ffff800000105481:	80 ff ff 
ffff800000105484:	48 89 c7             	mov    %rax,%rdi
ffff800000105487:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010548e:	80 ff ff 
ffff800000105491:	ff d0                	call   *%rax

  acquire(&log.lock);
ffff800000105493:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010549a:	80 ff ff 
ffff80000010549d:	48 89 c7             	mov    %rax,%rdi
ffff8000001054a0:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff8000001054a7:	80 ff ff 
ffff8000001054aa:	ff d0                	call   *%rax
  for (i = 0; i < log.lh.n; i++) {
ffff8000001054ac:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001054b3:	eb 29                	jmp    ffff8000001054de <log_write+0xd1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
ffff8000001054b5:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001054bc:	80 ff ff 
ffff8000001054bf:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001054c2:	48 63 d2             	movslq %edx,%rdx
ffff8000001054c5:	48 83 c2 1c          	add    $0x1c,%rdx
ffff8000001054c9:	8b 44 90 10          	mov    0x10(%rax,%rdx,4),%eax
ffff8000001054cd:	89 c2                	mov    %eax,%edx
ffff8000001054cf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001054d3:	8b 40 08             	mov    0x8(%rax),%eax
ffff8000001054d6:	39 c2                	cmp    %eax,%edx
ffff8000001054d8:	74 18                	je     ffff8000001054f2 <log_write+0xe5>
  for (i = 0; i < log.lh.n; i++) {
ffff8000001054da:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001054de:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001054e5:	80 ff ff 
ffff8000001054e8:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff8000001054eb:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff8000001054ee:	7c c5                	jl     ffff8000001054b5 <log_write+0xa8>
ffff8000001054f0:	eb 01                	jmp    ffff8000001054f3 <log_write+0xe6>
      break;
ffff8000001054f2:	90                   	nop
  }
  log.lh.block[i] = b->blockno;
ffff8000001054f3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001054f7:	8b 40 08             	mov    0x8(%rax),%eax
ffff8000001054fa:	89 c1                	mov    %eax,%ecx
ffff8000001054fc:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105503:	80 ff ff 
ffff800000105506:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000105509:	48 63 d2             	movslq %edx,%rdx
ffff80000010550c:	48 83 c2 1c          	add    $0x1c,%rdx
ffff800000105510:	89 4c 90 10          	mov    %ecx,0x10(%rax,%rdx,4)
  if (i == log.lh.n)
ffff800000105514:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010551b:	80 ff ff 
ffff80000010551e:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000105521:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000105524:	75 1d                	jne    ffff800000105543 <log_write+0x136>
    log.lh.n++;
ffff800000105526:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010552d:	80 ff ff 
ffff800000105530:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000105533:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000105536:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010553d:	80 ff ff 
ffff800000105540:	89 50 7c             	mov    %edx,0x7c(%rax)
  b->flags |= B_DIRTY; // prevent eviction
ffff800000105543:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105547:	8b 00                	mov    (%rax),%eax
ffff800000105549:	83 c8 04             	or     $0x4,%eax
ffff80000010554c:	89 c2                	mov    %eax,%edx
ffff80000010554e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105552:	89 10                	mov    %edx,(%rax)
  release(&log.lock);
ffff800000105554:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010555b:	80 ff ff 
ffff80000010555e:	48 89 c7             	mov    %rax,%rdi
ffff800000105561:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff800000105568:	80 ff ff 
ffff80000010556b:	ff d0                	call   *%rax
}
ffff80000010556d:	90                   	nop
ffff80000010556e:	c9                   	leave
ffff80000010556f:	c3                   	ret

ffff800000105570 <v2p>:
#include "x86.h"

static void startothers(void);
static void mpmain(void)  __attribute__((noreturn));
extern pde_t *kpgdir;
extern char end[]; // first address after kernel loaded from ELF file
ffff800000105570:	f3 0f 1e fa          	endbr64
ffff800000105574:	55                   	push   %rbp
ffff800000105575:	48 89 e5             	mov    %rsp,%rbp
ffff800000105578:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010557c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)

ffff800000105580:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105584:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010558b:	80 00 00 
ffff80000010558e:	48 01 d0             	add    %rdx,%rax
// Bootstrap processor starts running C code here.
ffff800000105591:	c9                   	leave
ffff800000105592:	c3                   	ret

ffff800000105593 <xchg>:
  asm volatile("hlt");
}

static inline uint
xchg(volatile uint *addr, addr_t newval)
{
ffff800000105593:	f3 0f 1e fa          	endbr64
ffff800000105597:	55                   	push   %rbp
ffff800000105598:	48 89 e5             	mov    %rsp,%rbp
ffff80000010559b:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010559f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff8000001055a3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
ffff8000001055a7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff8000001055ab:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001055af:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffff8000001055b3:	f0 87 02             	lock xchg %eax,(%rdx)
ffff8000001055b6:	89 45 fc             	mov    %eax,-0x4(%rbp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
ffff8000001055b9:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff8000001055bc:	c9                   	leave
ffff8000001055bd:	c3                   	ret

ffff8000001055be <main>:
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
ffff8000001055be:	f3 0f 1e fa          	endbr64
ffff8000001055c2:	55                   	push   %rbp
ffff8000001055c3:	48 89 e5             	mov    %rsp,%rbp
  uartearlyinit();
ffff8000001055c6:	48 b8 d4 a1 10 00 00 	movabs $0xffff80000010a1d4,%rax
ffff8000001055cd:	80 ff ff 
ffff8000001055d0:	ff d0                	call   *%rax
  kinit1(end, P2V(PHYSTOP)); // phys page allocator
ffff8000001055d2:	48 b8 00 00 00 0e 00 	movabs $0xffff80000e000000,%rax
ffff8000001055d9:	80 ff ff 
ffff8000001055dc:	48 89 c6             	mov    %rax,%rsi
ffff8000001055df:	48 b8 00 f0 11 00 00 	movabs $0xffff80000011f000,%rax
ffff8000001055e6:	80 ff ff 
ffff8000001055e9:	48 89 c7             	mov    %rax,%rdi
ffff8000001055ec:	48 b8 0e 41 10 00 00 	movabs $0xffff80000010410e,%rax
ffff8000001055f3:	80 ff ff 
ffff8000001055f6:	ff d0                	call   *%rax
  kvmalloc();      // kernel page table
ffff8000001055f8:	48 b8 8c b4 10 00 00 	movabs $0xffff80000010b48c,%rax
ffff8000001055ff:	80 ff ff 
ffff800000105602:	ff d0                	call   *%rax
  mpinit();        // detect other processors
ffff800000105604:	48 b8 eb 5b 10 00 00 	movabs $0xffff800000105beb,%rax
ffff80000010560b:	80 ff ff 
ffff80000010560e:	ff d0                	call   *%rax
  lapicinit();     // interrupt controller
ffff800000105610:	48 b8 80 46 10 00 00 	movabs $0xffff800000104680,%rax
ffff800000105617:	80 ff ff 
ffff80000010561a:	ff d0                	call   *%rax
  tvinit();        // trap vectors
ffff80000010561c:	48 b8 32 9d 10 00 00 	movabs $0xffff800000109d32,%rax
ffff800000105623:	80 ff ff 
ffff800000105626:	ff d0                	call   *%rax
  seginit();       // segment descriptors
ffff800000105628:	48 b8 c9 af 10 00 00 	movabs $0xffff80000010afc9,%rax
ffff80000010562f:	80 ff ff 
ffff800000105632:	ff d0                	call   *%rax
  cprintf("\ncpu%d: starting Spring 2026 xv6\n\n", cpunum());
ffff800000105634:	48 b8 12 48 10 00 00 	movabs $0xffff800000104812,%rax
ffff80000010563b:	80 ff ff 
ffff80000010563e:	ff d0                	call   *%rax
ffff800000105640:	89 c6                	mov    %eax,%esi
ffff800000105642:	48 b8 e8 c6 10 00 00 	movabs $0xffff80000010c6e8,%rax
ffff800000105649:	80 ff ff 
ffff80000010564c:	48 89 c7             	mov    %rax,%rdi
ffff80000010564f:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105654:	48 ba 38 08 10 00 00 	movabs $0xffff800000100838,%rdx
ffff80000010565b:	80 ff ff 
ffff80000010565e:	ff d2                	call   *%rdx
  ioapicinit();    // another interrupt controller
ffff800000105660:	48 b8 d1 3f 10 00 00 	movabs $0xffff800000103fd1,%rax
ffff800000105667:	80 ff ff 
ffff80000010566a:	ff d0                	call   *%rax
  consoleinit();   // console hardware
ffff80000010566c:	48 b8 f1 14 10 00 00 	movabs $0xffff8000001014f1,%rax
ffff800000105673:	80 ff ff 
ffff800000105676:	ff d0                	call   *%rax
  uartinit();      // serial port
ffff800000105678:	48 b8 dc a2 10 00 00 	movabs $0xffff80000010a2dc,%rax
ffff80000010567f:	80 ff ff 
ffff800000105682:	ff d0                	call   *%rax
  pinit();         // process table
ffff800000105684:	48 b8 4b 63 10 00 00 	movabs $0xffff80000010634b,%rax
ffff80000010568b:	80 ff ff 
ffff80000010568e:	ff d0                	call   *%rax
  binit();         // buffer cache
ffff800000105690:	48 b8 1b 01 10 00 00 	movabs $0xffff80000010011b,%rax
ffff800000105697:	80 ff ff 
ffff80000010569a:	ff d0                	call   *%rax
  fileinit();      // file table
ffff80000010569c:	48 b8 91 1b 10 00 00 	movabs $0xffff800000101b91,%rax
ffff8000001056a3:	80 ff ff 
ffff8000001056a6:	ff d0                	call   *%rax
  ideinit();       // disk
ffff8000001056a8:	48 b8 0a 3a 10 00 00 	movabs $0xffff800000103a0a,%rax
ffff8000001056af:	80 ff ff 
ffff8000001056b2:	ff d0                	call   *%rax
  startothers();   // start other processors
ffff8000001056b4:	48 b8 9c 57 10 00 00 	movabs $0xffff80000010579c,%rax
ffff8000001056bb:	80 ff ff 
ffff8000001056be:	ff d0                	call   *%rax
  kinit2();
ffff8000001056c0:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001056c5:	48 ba 88 41 10 00 00 	movabs $0xffff800000104188,%rdx
ffff8000001056cc:	80 ff ff 
ffff8000001056cf:	ff d2                	call   *%rdx
  userinit();      // first user process
ffff8000001056d1:	48 b8 fe 64 10 00 00 	movabs $0xffff8000001064fe,%rax
ffff8000001056d8:	80 ff ff 
ffff8000001056db:	ff d0                	call   *%rax
  mpmain();        // finish this processor's setup
ffff8000001056dd:	48 b8 21 57 10 00 00 	movabs $0xffff800000105721,%rax
ffff8000001056e4:	80 ff ff 
ffff8000001056e7:	ff d0                	call   *%rax

ffff8000001056e9 <mpenter>:
}

// Other CPUs jump here from entryother.S.
void
mpenter(void)
{
ffff8000001056e9:	f3 0f 1e fa          	endbr64
ffff8000001056ed:	55                   	push   %rbp
ffff8000001056ee:	48 89 e5             	mov    %rsp,%rbp
  switchkvm();
ffff8000001056f1:	48 b8 99 b8 10 00 00 	movabs $0xffff80000010b899,%rax
ffff8000001056f8:	80 ff ff 
ffff8000001056fb:	ff d0                	call   *%rax
  seginit();
ffff8000001056fd:	48 b8 c9 af 10 00 00 	movabs $0xffff80000010afc9,%rax
ffff800000105704:	80 ff ff 
ffff800000105707:	ff d0                	call   *%rax
  lapicinit();
ffff800000105709:	48 b8 80 46 10 00 00 	movabs $0xffff800000104680,%rax
ffff800000105710:	80 ff ff 
ffff800000105713:	ff d0                	call   *%rax
  mpmain();
ffff800000105715:	48 b8 21 57 10 00 00 	movabs $0xffff800000105721,%rax
ffff80000010571c:	80 ff ff 
ffff80000010571f:	ff d0                	call   *%rax

ffff800000105721 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
ffff800000105721:	f3 0f 1e fa          	endbr64
ffff800000105725:	55                   	push   %rbp
ffff800000105726:	48 89 e5             	mov    %rsp,%rbp
  cprintf("cpu%d: starting\n", cpunum());
ffff800000105729:	48 b8 12 48 10 00 00 	movabs $0xffff800000104812,%rax
ffff800000105730:	80 ff ff 
ffff800000105733:	ff d0                	call   *%rax
ffff800000105735:	89 c6                	mov    %eax,%esi
ffff800000105737:	48 b8 0b c7 10 00 00 	movabs $0xffff80000010c70b,%rax
ffff80000010573e:	80 ff ff 
ffff800000105741:	48 89 c7             	mov    %rax,%rdi
ffff800000105744:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105749:	48 ba 38 08 10 00 00 	movabs $0xffff800000100838,%rdx
ffff800000105750:	80 ff ff 
ffff800000105753:	ff d2                	call   *%rdx
  idtinit();       // load idt register
ffff800000105755:	48 b8 06 9d 10 00 00 	movabs $0xffff800000109d06,%rax
ffff80000010575c:	80 ff ff 
ffff80000010575f:	ff d0                	call   *%rax
  syscallinit();   // syscall set up
ffff800000105761:	48 b8 4e af 10 00 00 	movabs $0xffff80000010af4e,%rax
ffff800000105768:	80 ff ff 
ffff80000010576b:	ff d0                	call   *%rax
  xchg(&cpu->started, 1); // tell startothers() we're up
ffff80000010576d:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000105774:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000105778:	48 83 c0 10          	add    $0x10,%rax
ffff80000010577c:	be 01 00 00 00       	mov    $0x1,%esi
ffff800000105781:	48 89 c7             	mov    %rax,%rdi
ffff800000105784:	48 b8 93 55 10 00 00 	movabs $0xffff800000105593,%rax
ffff80000010578b:	80 ff ff 
ffff80000010578e:	ff d0                	call   *%rax
  scheduler();     // start running processes
ffff800000105790:	48 b8 8e 6d 10 00 00 	movabs $0xffff800000106d8e,%rax
ffff800000105797:	80 ff ff 
ffff80000010579a:	ff d0                	call   *%rax

ffff80000010579c <startothers>:
void entry32mp(void);

// Start the non-boot (AP) processors.
static void
startothers(void)
{
ffff80000010579c:	f3 0f 1e fa          	endbr64
ffff8000001057a0:	55                   	push   %rbp
ffff8000001057a1:	48 89 e5             	mov    %rsp,%rbp
ffff8000001057a4:	48 83 ec 20          	sub    $0x20,%rsp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
ffff8000001057a8:	48 b8 00 70 00 00 00 	movabs $0xffff800000007000,%rax
ffff8000001057af:	80 ff ff 
ffff8000001057b2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  memmove(code, _binary_entryother_start,
ffff8000001057b6:	48 b8 72 00 00 00 00 	movabs $0x72,%rax
ffff8000001057bd:	00 00 00 
ffff8000001057c0:	89 c2                	mov    %eax,%edx
ffff8000001057c2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001057c6:	48 b9 a0 de 10 00 00 	movabs $0xffff80000010dea0,%rcx
ffff8000001057cd:	80 ff ff 
ffff8000001057d0:	48 89 ce             	mov    %rcx,%rsi
ffff8000001057d3:	48 89 c7             	mov    %rax,%rdi
ffff8000001057d6:	48 b8 94 7e 10 00 00 	movabs $0xffff800000107e94,%rax
ffff8000001057dd:	80 ff ff 
ffff8000001057e0:	ff d0                	call   *%rax
          (addr_t)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
ffff8000001057e2:	48 b8 e0 72 11 00 00 	movabs $0xffff8000001172e0,%rax
ffff8000001057e9:	80 ff ff 
ffff8000001057ec:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001057f0:	e9 c6 00 00 00       	jmp    ffff8000001058bb <startothers+0x11f>
    if(c == cpus+cpunum())  // We've started already.
ffff8000001057f5:	48 b8 12 48 10 00 00 	movabs $0xffff800000104812,%rax
ffff8000001057fc:	80 ff ff 
ffff8000001057ff:	ff d0                	call   *%rax
ffff800000105801:	48 63 d0             	movslq %eax,%rdx
ffff800000105804:	48 89 d0             	mov    %rdx,%rax
ffff800000105807:	48 c1 e0 02          	shl    $0x2,%rax
ffff80000010580b:	48 01 d0             	add    %rdx,%rax
ffff80000010580e:	48 c1 e0 03          	shl    $0x3,%rax
ffff800000105812:	48 89 c2             	mov    %rax,%rdx
ffff800000105815:	48 b8 e0 72 11 00 00 	movabs $0xffff8000001172e0,%rax
ffff80000010581c:	80 ff ff 
ffff80000010581f:	48 01 d0             	add    %rdx,%rax
ffff800000105822:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000105826:	0f 84 89 00 00 00    	je     ffff8000001058b5 <startothers+0x119>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
ffff80000010582c:	48 b8 00 43 10 00 00 	movabs $0xffff800000104300,%rax
ffff800000105833:	80 ff ff 
ffff800000105836:	ff d0                	call   *%rax
ffff800000105838:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    *(uint32*)(code-4) = 0x8000; // enough stack to get us to entry64mp
ffff80000010583c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105840:	48 83 e8 04          	sub    $0x4,%rax
ffff800000105844:	c7 00 00 80 00 00    	movl   $0x8000,(%rax)
    *(uint32*)(code-8) = v2p(entry32mp);
ffff80000010584a:	48 b8 49 00 10 00 00 	movabs $0xffff800000100049,%rax
ffff800000105851:	80 ff ff 
ffff800000105854:	48 89 c7             	mov    %rax,%rdi
ffff800000105857:	48 b8 70 55 10 00 00 	movabs $0xffff800000105570,%rax
ffff80000010585e:	80 ff ff 
ffff800000105861:	ff d0                	call   *%rax
ffff800000105863:	48 89 c2             	mov    %rax,%rdx
ffff800000105866:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010586a:	48 83 e8 08          	sub    $0x8,%rax
ffff80000010586e:	89 10                	mov    %edx,(%rax)
    *(uint64*)(code-16) = (uint64) (stack + KSTACKSIZE);
ffff800000105870:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105874:	48 8d 90 00 10 00 00 	lea    0x1000(%rax),%rdx
ffff80000010587b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010587f:	48 83 e8 10          	sub    $0x10,%rax
ffff800000105883:	48 89 10             	mov    %rdx,(%rax)

    lapicstartap(c->apicid, V2P(code));
ffff800000105886:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010588a:	89 c2                	mov    %eax,%edx
ffff80000010588c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105890:	0f b6 40 01          	movzbl 0x1(%rax),%eax
ffff800000105894:	0f b6 c0             	movzbl %al,%eax
ffff800000105897:	89 d6                	mov    %edx,%esi
ffff800000105899:	89 c7                	mov    %eax,%edi
ffff80000010589b:	48 b8 60 49 10 00 00 	movabs $0xffff800000104960,%rax
ffff8000001058a2:	80 ff ff 
ffff8000001058a5:	ff d0                	call   *%rax

    // wait for cpu to finish mpmain()
    while(c->started == 0)
ffff8000001058a7:	90                   	nop
ffff8000001058a8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001058ac:	8b 40 10             	mov    0x10(%rax),%eax
ffff8000001058af:	85 c0                	test   %eax,%eax
ffff8000001058b1:	74 f5                	je     ffff8000001058a8 <startothers+0x10c>
ffff8000001058b3:	eb 01                	jmp    ffff8000001058b6 <startothers+0x11a>
      continue;
ffff8000001058b5:	90                   	nop
  for(c = cpus; c < cpus+ncpu; c++){
ffff8000001058b6:	48 83 45 f8 28       	addq   $0x28,-0x8(%rbp)
ffff8000001058bb:	48 b8 20 74 11 00 00 	movabs $0xffff800000117420,%rax
ffff8000001058c2:	80 ff ff 
ffff8000001058c5:	8b 00                	mov    (%rax),%eax
ffff8000001058c7:	48 63 d0             	movslq %eax,%rdx
ffff8000001058ca:	48 89 d0             	mov    %rdx,%rax
ffff8000001058cd:	48 c1 e0 02          	shl    $0x2,%rax
ffff8000001058d1:	48 01 d0             	add    %rdx,%rax
ffff8000001058d4:	48 c1 e0 03          	shl    $0x3,%rax
ffff8000001058d8:	48 89 c2             	mov    %rax,%rdx
ffff8000001058db:	48 b8 e0 72 11 00 00 	movabs $0xffff8000001172e0,%rax
ffff8000001058e2:	80 ff ff 
ffff8000001058e5:	48 01 d0             	add    %rdx,%rax
ffff8000001058e8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff8000001058ec:	0f 82 03 ff ff ff    	jb     ffff8000001057f5 <startothers+0x59>
      ;
  }
}
ffff8000001058f2:	90                   	nop
ffff8000001058f3:	90                   	nop
ffff8000001058f4:	c9                   	leave
ffff8000001058f5:	c3                   	ret

ffff8000001058f6 <inb>:
// Multiprocessor support
// Search memory for MP description structures.
// http://developer.intel.com/design/pentium/datashts/24201606.pdf

#include "types.h"
ffff8000001058f6:	f3 0f 1e fa          	endbr64
ffff8000001058fa:	55                   	push   %rbp
ffff8000001058fb:	48 89 e5             	mov    %rsp,%rbp
ffff8000001058fe:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000105902:	89 f8                	mov    %edi,%eax
ffff800000105904:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
#include "defs.h"
#include "param.h"
#include "memlayout.h"
ffff800000105908:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff80000010590c:	89 c2                	mov    %eax,%edx
ffff80000010590e:	ec                   	in     (%dx),%al
ffff80000010590f:	88 45 ff             	mov    %al,-0x1(%rbp)
#include "mp.h"
ffff800000105912:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
#include "x86.h"
ffff800000105916:	c9                   	leave
ffff800000105917:	c3                   	ret

ffff800000105918 <outb>:
static uchar
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
ffff800000105918:	f3 0f 1e fa          	endbr64
ffff80000010591c:	55                   	push   %rbp
ffff80000010591d:	48 89 e5             	mov    %rsp,%rbp
ffff800000105920:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000105924:	89 fa                	mov    %edi,%edx
ffff800000105926:	89 f0                	mov    %esi,%eax
ffff800000105928:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffff80000010592c:	88 45 f8             	mov    %al,-0x8(%rbp)
  for(i=0; i<len; i++)
ffff80000010592f:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffff800000105933:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffff800000105937:	ee                   	out    %al,(%dx)
    sum += addr[i];
ffff800000105938:	90                   	nop
ffff800000105939:	c9                   	leave
ffff80000010593a:	c3                   	ret

ffff80000010593b <sum>:
{
ffff80000010593b:	f3 0f 1e fa          	endbr64
ffff80000010593f:	55                   	push   %rbp
ffff800000105940:	48 89 e5             	mov    %rsp,%rbp
ffff800000105943:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000105947:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010594b:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  sum = 0;
ffff80000010594e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  for(i=0; i<len; i++)
ffff800000105955:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010595c:	eb 1a                	jmp    ffff800000105978 <sum+0x3d>
    sum += addr[i];
ffff80000010595e:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000105961:	48 63 d0             	movslq %eax,%rdx
ffff800000105964:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105968:	48 01 d0             	add    %rdx,%rax
ffff80000010596b:	0f b6 00             	movzbl (%rax),%eax
ffff80000010596e:	0f b6 c0             	movzbl %al,%eax
ffff800000105971:	01 45 f8             	add    %eax,-0x8(%rbp)
  for(i=0; i<len; i++)
ffff800000105974:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000105978:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010597b:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
ffff80000010597e:	7c de                	jl     ffff80000010595e <sum+0x23>
  return sum;
ffff800000105980:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
ffff800000105983:	c9                   	leave
ffff800000105984:	c3                   	ret

ffff800000105985 <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(addr_t a, int len)
{
ffff800000105985:	f3 0f 1e fa          	endbr64
ffff800000105989:	55                   	push   %rbp
ffff80000010598a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010598d:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000105991:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000105995:	89 75 d4             	mov    %esi,-0x2c(%rbp)
  uchar *e, *p, *addr;
  addr = P2V(a);
ffff800000105998:	48 ba 00 00 00 00 00 	movabs $0xffff800000000000,%rdx
ffff80000010599f:	80 ff ff 
ffff8000001059a2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001059a6:	48 01 d0             	add    %rdx,%rax
ffff8000001059a9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  e = addr+len;
ffff8000001059ad:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff8000001059b0:	48 63 d0             	movslq %eax,%rdx
ffff8000001059b3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001059b7:	48 01 d0             	add    %rdx,%rax
ffff8000001059ba:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  for(p = addr; p < e; p += sizeof(struct mp))
ffff8000001059be:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001059c2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001059c6:	eb 50                	jmp    ffff800000105a18 <mpsearch1+0x93>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
ffff8000001059c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001059cc:	ba 04 00 00 00       	mov    $0x4,%edx
ffff8000001059d1:	48 b9 20 c7 10 00 00 	movabs $0xffff80000010c720,%rcx
ffff8000001059d8:	80 ff ff 
ffff8000001059db:	48 89 ce             	mov    %rcx,%rsi
ffff8000001059de:	48 89 c7             	mov    %rax,%rdi
ffff8000001059e1:	48 b8 21 7e 10 00 00 	movabs $0xffff800000107e21,%rax
ffff8000001059e8:	80 ff ff 
ffff8000001059eb:	ff d0                	call   *%rax
ffff8000001059ed:	85 c0                	test   %eax,%eax
ffff8000001059ef:	75 22                	jne    ffff800000105a13 <mpsearch1+0x8e>
ffff8000001059f1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001059f5:	be 10 00 00 00       	mov    $0x10,%esi
ffff8000001059fa:	48 89 c7             	mov    %rax,%rdi
ffff8000001059fd:	48 b8 3b 59 10 00 00 	movabs $0xffff80000010593b,%rax
ffff800000105a04:	80 ff ff 
ffff800000105a07:	ff d0                	call   *%rax
ffff800000105a09:	84 c0                	test   %al,%al
ffff800000105a0b:	75 06                	jne    ffff800000105a13 <mpsearch1+0x8e>
      return (struct mp*)p;
ffff800000105a0d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105a11:	eb 14                	jmp    ffff800000105a27 <mpsearch1+0xa2>
  for(p = addr; p < e; p += sizeof(struct mp))
ffff800000105a13:	48 83 45 f8 10       	addq   $0x10,-0x8(%rbp)
ffff800000105a18:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105a1c:	48 3b 45 e8          	cmp    -0x18(%rbp),%rax
ffff800000105a20:	72 a6                	jb     ffff8000001059c8 <mpsearch1+0x43>
  return 0;
ffff800000105a22:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000105a27:	c9                   	leave
ffff800000105a28:	c3                   	ret

ffff800000105a29 <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
ffff800000105a29:	f3 0f 1e fa          	endbr64
ffff800000105a2d:	55                   	push   %rbp
ffff800000105a2e:	48 89 e5             	mov    %rsp,%rbp
ffff800000105a31:	48 83 ec 20          	sub    $0x20,%rsp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
ffff800000105a35:	48 b8 00 04 00 00 00 	movabs $0xffff800000000400,%rax
ffff800000105a3c:	80 ff ff 
ffff800000105a3f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
ffff800000105a43:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105a47:	48 83 c0 0f          	add    $0xf,%rax
ffff800000105a4b:	0f b6 00             	movzbl (%rax),%eax
ffff800000105a4e:	0f b6 c0             	movzbl %al,%eax
ffff800000105a51:	c1 e0 08             	shl    $0x8,%eax
ffff800000105a54:	89 c2                	mov    %eax,%edx
ffff800000105a56:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105a5a:	48 83 c0 0e          	add    $0xe,%rax
ffff800000105a5e:	0f b6 00             	movzbl (%rax),%eax
ffff800000105a61:	0f b6 c0             	movzbl %al,%eax
ffff800000105a64:	09 d0                	or     %edx,%eax
ffff800000105a66:	c1 e0 04             	shl    $0x4,%eax
ffff800000105a69:	89 45 f4             	mov    %eax,-0xc(%rbp)
ffff800000105a6c:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
ffff800000105a70:	74 28                	je     ffff800000105a9a <mpsearch+0x71>
    if((mp = mpsearch1(p, 1024)))
ffff800000105a72:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000105a75:	be 00 04 00 00       	mov    $0x400,%esi
ffff800000105a7a:	48 89 c7             	mov    %rax,%rdi
ffff800000105a7d:	48 b8 85 59 10 00 00 	movabs $0xffff800000105985,%rax
ffff800000105a84:	80 ff ff 
ffff800000105a87:	ff d0                	call   *%rax
ffff800000105a89:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000105a8d:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff800000105a92:	74 5e                	je     ffff800000105af2 <mpsearch+0xc9>
      return mp;
ffff800000105a94:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105a98:	eb 6e                	jmp    ffff800000105b08 <mpsearch+0xdf>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
ffff800000105a9a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105a9e:	48 83 c0 14          	add    $0x14,%rax
ffff800000105aa2:	0f b6 00             	movzbl (%rax),%eax
ffff800000105aa5:	0f b6 c0             	movzbl %al,%eax
ffff800000105aa8:	c1 e0 08             	shl    $0x8,%eax
ffff800000105aab:	89 c2                	mov    %eax,%edx
ffff800000105aad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105ab1:	48 83 c0 13          	add    $0x13,%rax
ffff800000105ab5:	0f b6 00             	movzbl (%rax),%eax
ffff800000105ab8:	0f b6 c0             	movzbl %al,%eax
ffff800000105abb:	09 d0                	or     %edx,%eax
ffff800000105abd:	c1 e0 0a             	shl    $0xa,%eax
ffff800000105ac0:	89 45 f4             	mov    %eax,-0xc(%rbp)
    if((mp = mpsearch1(p-1024, 1024)))
ffff800000105ac3:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000105ac6:	2d 00 04 00 00       	sub    $0x400,%eax
ffff800000105acb:	89 c0                	mov    %eax,%eax
ffff800000105acd:	be 00 04 00 00       	mov    $0x400,%esi
ffff800000105ad2:	48 89 c7             	mov    %rax,%rdi
ffff800000105ad5:	48 b8 85 59 10 00 00 	movabs $0xffff800000105985,%rax
ffff800000105adc:	80 ff ff 
ffff800000105adf:	ff d0                	call   *%rax
ffff800000105ae1:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000105ae5:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff800000105aea:	74 06                	je     ffff800000105af2 <mpsearch+0xc9>
      return mp;
ffff800000105aec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105af0:	eb 16                	jmp    ffff800000105b08 <mpsearch+0xdf>
  }
  return mpsearch1(0xF0000, 0x10000);
ffff800000105af2:	be 00 00 01 00       	mov    $0x10000,%esi
ffff800000105af7:	bf 00 00 0f 00       	mov    $0xf0000,%edi
ffff800000105afc:	48 b8 85 59 10 00 00 	movabs $0xffff800000105985,%rax
ffff800000105b03:	80 ff ff 
ffff800000105b06:	ff d0                	call   *%rax
}
ffff800000105b08:	c9                   	leave
ffff800000105b09:	c3                   	ret

ffff800000105b0a <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
ffff800000105b0a:	f3 0f 1e fa          	endbr64
ffff800000105b0e:	55                   	push   %rbp
ffff800000105b0f:	48 89 e5             	mov    %rsp,%rbp
ffff800000105b12:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000105b16:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
ffff800000105b1a:	48 b8 29 5a 10 00 00 	movabs $0xffff800000105a29,%rax
ffff800000105b21:	80 ff ff 
ffff800000105b24:	ff d0                	call   *%rax
ffff800000105b26:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000105b2a:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000105b2f:	74 0b                	je     ffff800000105b3c <mpconfig+0x32>
ffff800000105b31:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105b35:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000105b38:	85 c0                	test   %eax,%eax
ffff800000105b3a:	75 0a                	jne    ffff800000105b46 <mpconfig+0x3c>
    return 0;
ffff800000105b3c:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105b41:	e9 a3 00 00 00       	jmp    ffff800000105be9 <mpconfig+0xdf>
  conf = (struct mpconf*) P2V((addr_t) mp->physaddr);
ffff800000105b46:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105b4a:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000105b4d:	89 c2                	mov    %eax,%edx
ffff800000105b4f:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff800000105b56:	80 ff ff 
ffff800000105b59:	48 01 d0             	add    %rdx,%rax
ffff800000105b5c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  if(memcmp(conf, "PCMP", 4) != 0)
ffff800000105b60:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105b64:	ba 04 00 00 00       	mov    $0x4,%edx
ffff800000105b69:	48 b9 25 c7 10 00 00 	movabs $0xffff80000010c725,%rcx
ffff800000105b70:	80 ff ff 
ffff800000105b73:	48 89 ce             	mov    %rcx,%rsi
ffff800000105b76:	48 89 c7             	mov    %rax,%rdi
ffff800000105b79:	48 b8 21 7e 10 00 00 	movabs $0xffff800000107e21,%rax
ffff800000105b80:	80 ff ff 
ffff800000105b83:	ff d0                	call   *%rax
ffff800000105b85:	85 c0                	test   %eax,%eax
ffff800000105b87:	74 07                	je     ffff800000105b90 <mpconfig+0x86>
    return 0;
ffff800000105b89:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105b8e:	eb 59                	jmp    ffff800000105be9 <mpconfig+0xdf>
  if(conf->version != 1 && conf->version != 4)
ffff800000105b90:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105b94:	0f b6 40 06          	movzbl 0x6(%rax),%eax
ffff800000105b98:	3c 01                	cmp    $0x1,%al
ffff800000105b9a:	74 13                	je     ffff800000105baf <mpconfig+0xa5>
ffff800000105b9c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105ba0:	0f b6 40 06          	movzbl 0x6(%rax),%eax
ffff800000105ba4:	3c 04                	cmp    $0x4,%al
ffff800000105ba6:	74 07                	je     ffff800000105baf <mpconfig+0xa5>
    return 0;
ffff800000105ba8:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105bad:	eb 3a                	jmp    ffff800000105be9 <mpconfig+0xdf>
  if(sum((uchar*)conf, conf->length) != 0)
ffff800000105baf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105bb3:	0f b7 40 04          	movzwl 0x4(%rax),%eax
ffff800000105bb7:	0f b7 d0             	movzwl %ax,%edx
ffff800000105bba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105bbe:	89 d6                	mov    %edx,%esi
ffff800000105bc0:	48 89 c7             	mov    %rax,%rdi
ffff800000105bc3:	48 b8 3b 59 10 00 00 	movabs $0xffff80000010593b,%rax
ffff800000105bca:	80 ff ff 
ffff800000105bcd:	ff d0                	call   *%rax
ffff800000105bcf:	84 c0                	test   %al,%al
ffff800000105bd1:	74 07                	je     ffff800000105bda <mpconfig+0xd0>
    return 0;
ffff800000105bd3:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105bd8:	eb 0f                	jmp    ffff800000105be9 <mpconfig+0xdf>
  *pmp = mp;
ffff800000105bda:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105bde:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000105be2:	48 89 10             	mov    %rdx,(%rax)
  return conf;
ffff800000105be5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
}
ffff800000105be9:	c9                   	leave
ffff800000105bea:	c3                   	ret

ffff800000105beb <mpinit>:

void
mpinit(void)
{
ffff800000105beb:	f3 0f 1e fa          	endbr64
ffff800000105bef:	55                   	push   %rbp
ffff800000105bf0:	48 89 e5             	mov    %rsp,%rbp
ffff800000105bf3:	48 83 ec 30          	sub    $0x30,%rsp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0) {
ffff800000105bf7:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffff800000105bfb:	48 89 c7             	mov    %rax,%rdi
ffff800000105bfe:	48 b8 0a 5b 10 00 00 	movabs $0xffff800000105b0a,%rax
ffff800000105c05:	80 ff ff 
ffff800000105c08:	ff d0                	call   *%rax
ffff800000105c0a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000105c0e:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000105c13:	75 23                	jne    ffff800000105c38 <mpinit+0x4d>
    cprintf("No other CPUs found.\n");
ffff800000105c15:	48 b8 2a c7 10 00 00 	movabs $0xffff80000010c72a,%rax
ffff800000105c1c:	80 ff ff 
ffff800000105c1f:	48 89 c7             	mov    %rax,%rdi
ffff800000105c22:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105c27:	48 ba 38 08 10 00 00 	movabs $0xffff800000100838,%rdx
ffff800000105c2e:	80 ff ff 
ffff800000105c31:	ff d2                	call   *%rdx
ffff800000105c33:	e9 c9 01 00 00       	jmp    ffff800000105e01 <mpinit+0x216>
    return;
  }
  lapic = P2V((addr_t)conf->lapicaddr_p);
ffff800000105c38:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105c3c:	8b 40 24             	mov    0x24(%rax),%eax
ffff800000105c3f:	89 c2                	mov    %eax,%edx
ffff800000105c41:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff800000105c48:	80 ff ff 
ffff800000105c4b:	48 01 d0             	add    %rdx,%rax
ffff800000105c4e:	48 89 c2             	mov    %rax,%rdx
ffff800000105c51:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff800000105c58:	80 ff ff 
ffff800000105c5b:	48 89 10             	mov    %rdx,(%rax)
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
ffff800000105c5e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105c62:	48 83 c0 2c          	add    $0x2c,%rax
ffff800000105c66:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000105c6a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105c6e:	0f b7 40 04          	movzwl 0x4(%rax),%eax
ffff800000105c72:	0f b7 d0             	movzwl %ax,%edx
ffff800000105c75:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105c79:	48 01 d0             	add    %rdx,%rax
ffff800000105c7c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000105c80:	e9 f6 00 00 00       	jmp    ffff800000105d7b <mpinit+0x190>
    switch(*p){
ffff800000105c85:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105c89:	0f b6 00             	movzbl (%rax),%eax
ffff800000105c8c:	0f b6 c0             	movzbl %al,%eax
ffff800000105c8f:	83 f8 04             	cmp    $0x4,%eax
ffff800000105c92:	0f 8f ca 00 00 00    	jg     ffff800000105d62 <mpinit+0x177>
ffff800000105c98:	83 f8 03             	cmp    $0x3,%eax
ffff800000105c9b:	0f 8d ba 00 00 00    	jge    ffff800000105d5b <mpinit+0x170>
ffff800000105ca1:	83 f8 02             	cmp    $0x2,%eax
ffff800000105ca4:	0f 84 8e 00 00 00    	je     ffff800000105d38 <mpinit+0x14d>
ffff800000105caa:	83 f8 02             	cmp    $0x2,%eax
ffff800000105cad:	0f 8f af 00 00 00    	jg     ffff800000105d62 <mpinit+0x177>
ffff800000105cb3:	85 c0                	test   %eax,%eax
ffff800000105cb5:	74 0e                	je     ffff800000105cc5 <mpinit+0xda>
ffff800000105cb7:	83 f8 01             	cmp    $0x1,%eax
ffff800000105cba:	0f 84 9b 00 00 00    	je     ffff800000105d5b <mpinit+0x170>
ffff800000105cc0:	e9 9d 00 00 00       	jmp    ffff800000105d62 <mpinit+0x177>
    case MPPROC:
      proc = (struct mpproc*)p;
ffff800000105cc5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105cc9:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
      if(ncpu < NCPU) {
ffff800000105ccd:	48 b8 20 74 11 00 00 	movabs $0xffff800000117420,%rax
ffff800000105cd4:	80 ff ff 
ffff800000105cd7:	8b 00                	mov    (%rax),%eax
ffff800000105cd9:	83 f8 07             	cmp    $0x7,%eax
ffff800000105cdc:	7f 53                	jg     ffff800000105d31 <mpinit+0x146>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
ffff800000105cde:	48 b8 20 74 11 00 00 	movabs $0xffff800000117420,%rax
ffff800000105ce5:	80 ff ff 
ffff800000105ce8:	8b 10                	mov    (%rax),%edx
ffff800000105cea:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000105cee:	0f b6 48 01          	movzbl 0x1(%rax),%ecx
ffff800000105cf2:	48 be e0 72 11 00 00 	movabs $0xffff8000001172e0,%rsi
ffff800000105cf9:	80 ff ff 
ffff800000105cfc:	48 63 d2             	movslq %edx,%rdx
ffff800000105cff:	48 89 d0             	mov    %rdx,%rax
ffff800000105d02:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000105d06:	48 01 d0             	add    %rdx,%rax
ffff800000105d09:	48 c1 e0 03          	shl    $0x3,%rax
ffff800000105d0d:	48 01 f0             	add    %rsi,%rax
ffff800000105d10:	48 83 c0 01          	add    $0x1,%rax
ffff800000105d14:	88 08                	mov    %cl,(%rax)
        ncpu++;
ffff800000105d16:	48 b8 20 74 11 00 00 	movabs $0xffff800000117420,%rax
ffff800000105d1d:	80 ff ff 
ffff800000105d20:	8b 00                	mov    (%rax),%eax
ffff800000105d22:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000105d25:	48 b8 20 74 11 00 00 	movabs $0xffff800000117420,%rax
ffff800000105d2c:	80 ff ff 
ffff800000105d2f:	89 10                	mov    %edx,(%rax)
      }
      p += sizeof(struct mpproc);
ffff800000105d31:	48 83 45 f8 14       	addq   $0x14,-0x8(%rbp)
      continue;
ffff800000105d36:	eb 43                	jmp    ffff800000105d7b <mpinit+0x190>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
ffff800000105d38:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105d3c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
      ioapicid = ioapic->apicno;
ffff800000105d40:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105d44:	0f b6 40 01          	movzbl 0x1(%rax),%eax
ffff800000105d48:	48 ba 24 74 11 00 00 	movabs $0xffff800000117424,%rdx
ffff800000105d4f:	80 ff ff 
ffff800000105d52:	88 02                	mov    %al,(%rdx)
      p += sizeof(struct mpioapic);
ffff800000105d54:	48 83 45 f8 08       	addq   $0x8,-0x8(%rbp)
      continue;
ffff800000105d59:	eb 20                	jmp    ffff800000105d7b <mpinit+0x190>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
ffff800000105d5b:	48 83 45 f8 08       	addq   $0x8,-0x8(%rbp)
      continue;
ffff800000105d60:	eb 19                	jmp    ffff800000105d7b <mpinit+0x190>
    default:
      panic("Major problem parsing mp config.");
ffff800000105d62:	48 b8 40 c7 10 00 00 	movabs $0xffff80000010c740,%rax
ffff800000105d69:	80 ff ff 
ffff800000105d6c:	48 89 c7             	mov    %rax,%rdi
ffff800000105d6f:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000105d76:	80 ff ff 
ffff800000105d79:	ff d0                	call   *%rax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
ffff800000105d7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105d7f:	48 3b 45 e8          	cmp    -0x18(%rbp),%rax
ffff800000105d83:	0f 82 fc fe ff ff    	jb     ffff800000105c85 <mpinit+0x9a>
      break;
    }
  }
  cprintf("Seems we are SMP, ncpu = %d\n",ncpu);
ffff800000105d89:	48 b8 20 74 11 00 00 	movabs $0xffff800000117420,%rax
ffff800000105d90:	80 ff ff 
ffff800000105d93:	8b 00                	mov    (%rax),%eax
ffff800000105d95:	89 c6                	mov    %eax,%esi
ffff800000105d97:	48 b8 61 c7 10 00 00 	movabs $0xffff80000010c761,%rax
ffff800000105d9e:	80 ff ff 
ffff800000105da1:	48 89 c7             	mov    %rax,%rdi
ffff800000105da4:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105da9:	48 ba 38 08 10 00 00 	movabs $0xffff800000100838,%rdx
ffff800000105db0:	80 ff ff 
ffff800000105db3:	ff d2                	call   *%rdx
  if(mp->imcrp){
ffff800000105db5:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000105db9:	0f b6 40 0c          	movzbl 0xc(%rax),%eax
ffff800000105dbd:	84 c0                	test   %al,%al
ffff800000105dbf:	74 40                	je     ffff800000105e01 <mpinit+0x216>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
ffff800000105dc1:	be 70 00 00 00       	mov    $0x70,%esi
ffff800000105dc6:	bf 22 00 00 00       	mov    $0x22,%edi
ffff800000105dcb:	48 b8 18 59 10 00 00 	movabs $0xffff800000105918,%rax
ffff800000105dd2:	80 ff ff 
ffff800000105dd5:	ff d0                	call   *%rax
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
ffff800000105dd7:	bf 23 00 00 00       	mov    $0x23,%edi
ffff800000105ddc:	48 b8 f6 58 10 00 00 	movabs $0xffff8000001058f6,%rax
ffff800000105de3:	80 ff ff 
ffff800000105de6:	ff d0                	call   *%rax
ffff800000105de8:	83 c8 01             	or     $0x1,%eax
ffff800000105deb:	0f b6 c0             	movzbl %al,%eax
ffff800000105dee:	89 c6                	mov    %eax,%esi
ffff800000105df0:	bf 23 00 00 00       	mov    $0x23,%edi
ffff800000105df5:	48 b8 18 59 10 00 00 	movabs $0xffff800000105918,%rax
ffff800000105dfc:	80 ff ff 
ffff800000105dff:	ff d0                	call   *%rax
  }
}
ffff800000105e01:	c9                   	leave
ffff800000105e02:	c3                   	ret

ffff800000105e03 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
ffff800000105e03:	f3 0f 1e fa          	endbr64
ffff800000105e07:	55                   	push   %rbp
ffff800000105e08:	48 89 e5             	mov    %rsp,%rbp
ffff800000105e0b:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000105e0f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000105e13:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  struct pipe *p;

  p = 0;
ffff800000105e17:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
ffff800000105e1e:	00 
  *f0 = *f1 = 0;
ffff800000105e1f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105e23:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
ffff800000105e2a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105e2e:	48 8b 10             	mov    (%rax),%rdx
ffff800000105e31:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105e35:	48 89 10             	mov    %rdx,(%rax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
ffff800000105e38:	48 b8 c2 1b 10 00 00 	movabs $0xffff800000101bc2,%rax
ffff800000105e3f:	80 ff ff 
ffff800000105e42:	ff d0                	call   *%rax
ffff800000105e44:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000105e48:	48 89 02             	mov    %rax,(%rdx)
ffff800000105e4b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105e4f:	48 8b 00             	mov    (%rax),%rax
ffff800000105e52:	48 85 c0             	test   %rax,%rax
ffff800000105e55:	0f 84 01 01 00 00    	je     ffff800000105f5c <pipealloc+0x159>
ffff800000105e5b:	48 b8 c2 1b 10 00 00 	movabs $0xffff800000101bc2,%rax
ffff800000105e62:	80 ff ff 
ffff800000105e65:	ff d0                	call   *%rax
ffff800000105e67:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000105e6b:	48 89 02             	mov    %rax,(%rdx)
ffff800000105e6e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105e72:	48 8b 00             	mov    (%rax),%rax
ffff800000105e75:	48 85 c0             	test   %rax,%rax
ffff800000105e78:	0f 84 de 00 00 00    	je     ffff800000105f5c <pipealloc+0x159>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
ffff800000105e7e:	48 b8 00 43 10 00 00 	movabs $0xffff800000104300,%rax
ffff800000105e85:	80 ff ff 
ffff800000105e88:	ff d0                	call   *%rax
ffff800000105e8a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000105e8e:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000105e93:	0f 84 c6 00 00 00    	je     ffff800000105f5f <pipealloc+0x15c>
    goto bad;
  p->readopen = 1;
ffff800000105e99:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105e9d:	c7 80 70 02 00 00 01 	movl   $0x1,0x270(%rax)
ffff800000105ea4:	00 00 00 
  p->writeopen = 1;
ffff800000105ea7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105eab:	c7 80 74 02 00 00 01 	movl   $0x1,0x274(%rax)
ffff800000105eb2:	00 00 00 
  p->nwrite = 0;
ffff800000105eb5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105eb9:	c7 80 6c 02 00 00 00 	movl   $0x0,0x26c(%rax)
ffff800000105ec0:	00 00 00 
  p->nread = 0;
ffff800000105ec3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105ec7:	c7 80 68 02 00 00 00 	movl   $0x0,0x268(%rax)
ffff800000105ece:	00 00 00 
  initlock(&p->lock, "pipe");
ffff800000105ed1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105ed5:	48 ba 7e c7 10 00 00 	movabs $0xffff80000010c77e,%rdx
ffff800000105edc:	80 ff ff 
ffff800000105edf:	48 89 d6             	mov    %rdx,%rsi
ffff800000105ee2:	48 89 c7             	mov    %rax,%rdi
ffff800000105ee5:	48 b8 96 79 10 00 00 	movabs $0xffff800000107996,%rax
ffff800000105eec:	80 ff ff 
ffff800000105eef:	ff d0                	call   *%rax
  (*f0)->type = FD_PIPE;
ffff800000105ef1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105ef5:	48 8b 00             	mov    (%rax),%rax
ffff800000105ef8:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
  (*f0)->readable = 1;
ffff800000105efe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f02:	48 8b 00             	mov    (%rax),%rax
ffff800000105f05:	c6 40 08 01          	movb   $0x1,0x8(%rax)
  (*f0)->writable = 0;
ffff800000105f09:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f0d:	48 8b 00             	mov    (%rax),%rax
ffff800000105f10:	c6 40 09 00          	movb   $0x0,0x9(%rax)
  (*f0)->pipe = p;
ffff800000105f14:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f18:	48 8b 00             	mov    (%rax),%rax
ffff800000105f1b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000105f1f:	48 89 50 10          	mov    %rdx,0x10(%rax)
  (*f1)->type = FD_PIPE;
ffff800000105f23:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105f27:	48 8b 00             	mov    (%rax),%rax
ffff800000105f2a:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
  (*f1)->readable = 0;
ffff800000105f30:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105f34:	48 8b 00             	mov    (%rax),%rax
ffff800000105f37:	c6 40 08 00          	movb   $0x0,0x8(%rax)
  (*f1)->writable = 1;
ffff800000105f3b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105f3f:	48 8b 00             	mov    (%rax),%rax
ffff800000105f42:	c6 40 09 01          	movb   $0x1,0x9(%rax)
  (*f1)->pipe = p;
ffff800000105f46:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105f4a:	48 8b 00             	mov    (%rax),%rax
ffff800000105f4d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000105f51:	48 89 50 10          	mov    %rdx,0x10(%rax)
  return 0;
ffff800000105f55:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105f5a:	eb 67                	jmp    ffff800000105fc3 <pipealloc+0x1c0>
    goto bad;
ffff800000105f5c:	90                   	nop
ffff800000105f5d:	eb 01                	jmp    ffff800000105f60 <pipealloc+0x15d>
    goto bad;
ffff800000105f5f:	90                   	nop

//PAGEBREAK: 20
 bad:
  if(p)
ffff800000105f60:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000105f65:	74 13                	je     ffff800000105f7a <pipealloc+0x177>
    kfree((char*)p);
ffff800000105f67:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105f6b:	48 89 c7             	mov    %rax,%rdi
ffff800000105f6e:	48 b8 fd 41 10 00 00 	movabs $0xffff8000001041fd,%rax
ffff800000105f75:	80 ff ff 
ffff800000105f78:	ff d0                	call   *%rax
  if(*f0)
ffff800000105f7a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f7e:	48 8b 00             	mov    (%rax),%rax
ffff800000105f81:	48 85 c0             	test   %rax,%rax
ffff800000105f84:	74 16                	je     ffff800000105f9c <pipealloc+0x199>
    fileclose(*f0);
ffff800000105f86:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f8a:	48 8b 00             	mov    (%rax),%rax
ffff800000105f8d:	48 89 c7             	mov    %rax,%rdi
ffff800000105f90:	48 b8 de 1c 10 00 00 	movabs $0xffff800000101cde,%rax
ffff800000105f97:	80 ff ff 
ffff800000105f9a:	ff d0                	call   *%rax
  if(*f1)
ffff800000105f9c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105fa0:	48 8b 00             	mov    (%rax),%rax
ffff800000105fa3:	48 85 c0             	test   %rax,%rax
ffff800000105fa6:	74 16                	je     ffff800000105fbe <pipealloc+0x1bb>
    fileclose(*f1);
ffff800000105fa8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105fac:	48 8b 00             	mov    (%rax),%rax
ffff800000105faf:	48 89 c7             	mov    %rax,%rdi
ffff800000105fb2:	48 b8 de 1c 10 00 00 	movabs $0xffff800000101cde,%rax
ffff800000105fb9:	80 ff ff 
ffff800000105fbc:	ff d0                	call   *%rax
  return -1;
ffff800000105fbe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000105fc3:	c9                   	leave
ffff800000105fc4:	c3                   	ret

ffff800000105fc5 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
ffff800000105fc5:	f3 0f 1e fa          	endbr64
ffff800000105fc9:	55                   	push   %rbp
ffff800000105fca:	48 89 e5             	mov    %rsp,%rbp
ffff800000105fcd:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000105fd1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000105fd5:	89 75 f4             	mov    %esi,-0xc(%rbp)
  acquire(&p->lock);
ffff800000105fd8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105fdc:	48 89 c7             	mov    %rax,%rdi
ffff800000105fdf:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff800000105fe6:	80 ff ff 
ffff800000105fe9:	ff d0                	call   *%rax
  if(writable){
ffff800000105feb:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
ffff800000105fef:	74 29                	je     ffff80000010601a <pipeclose+0x55>
    p->writeopen = 0;
ffff800000105ff1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105ff5:	c7 80 74 02 00 00 00 	movl   $0x0,0x274(%rax)
ffff800000105ffc:	00 00 00 
    wakeup(&p->nread);
ffff800000105fff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106003:	48 05 68 02 00 00    	add    $0x268,%rax
ffff800000106009:	48 89 c7             	mov    %rax,%rdi
ffff80000010600c:	48 b8 21 72 10 00 00 	movabs $0xffff800000107221,%rax
ffff800000106013:	80 ff ff 
ffff800000106016:	ff d0                	call   *%rax
ffff800000106018:	eb 27                	jmp    ffff800000106041 <pipeclose+0x7c>
  } else {
    p->readopen = 0;
ffff80000010601a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010601e:	c7 80 70 02 00 00 00 	movl   $0x0,0x270(%rax)
ffff800000106025:	00 00 00 
    wakeup(&p->nwrite);
ffff800000106028:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010602c:	48 05 6c 02 00 00    	add    $0x26c,%rax
ffff800000106032:	48 89 c7             	mov    %rax,%rdi
ffff800000106035:	48 b8 21 72 10 00 00 	movabs $0xffff800000107221,%rax
ffff80000010603c:	80 ff ff 
ffff80000010603f:	ff d0                	call   *%rax
  }
  if(p->readopen == 0 && p->writeopen == 0){
ffff800000106041:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106045:	8b 80 70 02 00 00    	mov    0x270(%rax),%eax
ffff80000010604b:	85 c0                	test   %eax,%eax
ffff80000010604d:	75 36                	jne    ffff800000106085 <pipeclose+0xc0>
ffff80000010604f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106053:	8b 80 74 02 00 00    	mov    0x274(%rax),%eax
ffff800000106059:	85 c0                	test   %eax,%eax
ffff80000010605b:	75 28                	jne    ffff800000106085 <pipeclose+0xc0>
    release(&p->lock);
ffff80000010605d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106061:	48 89 c7             	mov    %rax,%rdi
ffff800000106064:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff80000010606b:	80 ff ff 
ffff80000010606e:	ff d0                	call   *%rax
    kfree((char*)p);
ffff800000106070:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106074:	48 89 c7             	mov    %rax,%rdi
ffff800000106077:	48 b8 fd 41 10 00 00 	movabs $0xffff8000001041fd,%rax
ffff80000010607e:	80 ff ff 
ffff800000106081:	ff d0                	call   *%rax
ffff800000106083:	eb 14                	jmp    ffff800000106099 <pipeclose+0xd4>
  } else
    release(&p->lock);
ffff800000106085:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106089:	48 89 c7             	mov    %rax,%rdi
ffff80000010608c:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff800000106093:	80 ff ff 
ffff800000106096:	ff d0                	call   *%rax
}
ffff800000106098:	90                   	nop
ffff800000106099:	90                   	nop
ffff80000010609a:	c9                   	leave
ffff80000010609b:	c3                   	ret

ffff80000010609c <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
ffff80000010609c:	f3 0f 1e fa          	endbr64
ffff8000001060a0:	55                   	push   %rbp
ffff8000001060a1:	48 89 e5             	mov    %rsp,%rbp
ffff8000001060a4:	48 83 ec 30          	sub    $0x30,%rsp
ffff8000001060a8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff8000001060ac:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff8000001060b0:	89 55 dc             	mov    %edx,-0x24(%rbp)
  int i;

  acquire(&p->lock);
ffff8000001060b3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001060b7:	48 89 c7             	mov    %rax,%rdi
ffff8000001060ba:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff8000001060c1:	80 ff ff 
ffff8000001060c4:	ff d0                	call   *%rax
  for(i = 0; i < n; i++){
ffff8000001060c6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001060cd:	e9 d5 00 00 00       	jmp    ffff8000001061a7 <pipewrite+0x10b>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
ffff8000001060d2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001060d6:	8b 80 70 02 00 00    	mov    0x270(%rax),%eax
ffff8000001060dc:	85 c0                	test   %eax,%eax
ffff8000001060de:	74 12                	je     ffff8000001060f2 <pipewrite+0x56>
ffff8000001060e0:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001060e7:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001060eb:	8b 40 40             	mov    0x40(%rax),%eax
ffff8000001060ee:	85 c0                	test   %eax,%eax
ffff8000001060f0:	74 1d                	je     ffff80000010610f <pipewrite+0x73>
        release(&p->lock);
ffff8000001060f2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001060f6:	48 89 c7             	mov    %rax,%rdi
ffff8000001060f9:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff800000106100:	80 ff ff 
ffff800000106103:	ff d0                	call   *%rax
        return -1;
ffff800000106105:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010610a:	e9 cf 00 00 00       	jmp    ffff8000001061de <pipewrite+0x142>
      }
      wakeup(&p->nread);
ffff80000010610f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106113:	48 05 68 02 00 00    	add    $0x268,%rax
ffff800000106119:	48 89 c7             	mov    %rax,%rdi
ffff80000010611c:	48 b8 21 72 10 00 00 	movabs $0xffff800000107221,%rax
ffff800000106123:	80 ff ff 
ffff800000106126:	ff d0                	call   *%rax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
ffff800000106128:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010612c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000106130:	48 81 c2 6c 02 00 00 	add    $0x26c,%rdx
ffff800000106137:	48 89 c6             	mov    %rax,%rsi
ffff80000010613a:	48 89 d7             	mov    %rdx,%rdi
ffff80000010613d:	48 b8 a4 70 10 00 00 	movabs $0xffff8000001070a4,%rax
ffff800000106144:	80 ff ff 
ffff800000106147:	ff d0                	call   *%rax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
ffff800000106149:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010614d:	8b 90 6c 02 00 00    	mov    0x26c(%rax),%edx
ffff800000106153:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106157:	8b 80 68 02 00 00    	mov    0x268(%rax),%eax
ffff80000010615d:	05 00 02 00 00       	add    $0x200,%eax
ffff800000106162:	39 c2                	cmp    %eax,%edx
ffff800000106164:	0f 84 68 ff ff ff    	je     ffff8000001060d2 <pipewrite+0x36>
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
ffff80000010616a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010616d:	48 63 d0             	movslq %eax,%rdx
ffff800000106170:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106174:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
ffff800000106178:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010617c:	8b 80 6c 02 00 00    	mov    0x26c(%rax),%eax
ffff800000106182:	8d 48 01             	lea    0x1(%rax),%ecx
ffff800000106185:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000106189:	89 8a 6c 02 00 00    	mov    %ecx,0x26c(%rdx)
ffff80000010618f:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff800000106194:	89 c1                	mov    %eax,%ecx
ffff800000106196:	0f b6 16             	movzbl (%rsi),%edx
ffff800000106199:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010619d:	89 c9                	mov    %ecx,%ecx
ffff80000010619f:	88 54 08 68          	mov    %dl,0x68(%rax,%rcx,1)
  for(i = 0; i < n; i++){
ffff8000001061a3:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001061a7:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001061aa:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffff8000001061ad:	7c 9a                	jl     ffff800000106149 <pipewrite+0xad>
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
ffff8000001061af:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001061b3:	48 05 68 02 00 00    	add    $0x268,%rax
ffff8000001061b9:	48 89 c7             	mov    %rax,%rdi
ffff8000001061bc:	48 b8 21 72 10 00 00 	movabs $0xffff800000107221,%rax
ffff8000001061c3:	80 ff ff 
ffff8000001061c6:	ff d0                	call   *%rax
  release(&p->lock);
ffff8000001061c8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001061cc:	48 89 c7             	mov    %rax,%rdi
ffff8000001061cf:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff8000001061d6:	80 ff ff 
ffff8000001061d9:	ff d0                	call   *%rax
  return n;
ffff8000001061db:	8b 45 dc             	mov    -0x24(%rbp),%eax
}
ffff8000001061de:	c9                   	leave
ffff8000001061df:	c3                   	ret

ffff8000001061e0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
ffff8000001061e0:	f3 0f 1e fa          	endbr64
ffff8000001061e4:	55                   	push   %rbp
ffff8000001061e5:	48 89 e5             	mov    %rsp,%rbp
ffff8000001061e8:	48 83 ec 30          	sub    $0x30,%rsp
ffff8000001061ec:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff8000001061f0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff8000001061f4:	89 55 dc             	mov    %edx,-0x24(%rbp)
  int i;

  acquire(&p->lock);
ffff8000001061f7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001061fb:	48 89 c7             	mov    %rax,%rdi
ffff8000001061fe:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff800000106205:	80 ff ff 
ffff800000106208:	ff d0                	call   *%rax
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
ffff80000010620a:	eb 50                	jmp    ffff80000010625c <piperead+0x7c>
    if(proc->killed){
ffff80000010620c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106213:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106217:	8b 40 40             	mov    0x40(%rax),%eax
ffff80000010621a:	85 c0                	test   %eax,%eax
ffff80000010621c:	74 1d                	je     ffff80000010623b <piperead+0x5b>
      release(&p->lock);
ffff80000010621e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106222:	48 89 c7             	mov    %rax,%rdi
ffff800000106225:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff80000010622c:	80 ff ff 
ffff80000010622f:	ff d0                	call   *%rax
      return -1;
ffff800000106231:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000106236:	e9 de 00 00 00       	jmp    ffff800000106319 <piperead+0x139>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
ffff80000010623b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010623f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000106243:	48 81 c2 68 02 00 00 	add    $0x268,%rdx
ffff80000010624a:	48 89 c6             	mov    %rax,%rsi
ffff80000010624d:	48 89 d7             	mov    %rdx,%rdi
ffff800000106250:	48 b8 a4 70 10 00 00 	movabs $0xffff8000001070a4,%rax
ffff800000106257:	80 ff ff 
ffff80000010625a:	ff d0                	call   *%rax
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
ffff80000010625c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106260:	8b 90 68 02 00 00    	mov    0x268(%rax),%edx
ffff800000106266:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010626a:	8b 80 6c 02 00 00    	mov    0x26c(%rax),%eax
ffff800000106270:	39 c2                	cmp    %eax,%edx
ffff800000106272:	75 0e                	jne    ffff800000106282 <piperead+0xa2>
ffff800000106274:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106278:	8b 80 74 02 00 00    	mov    0x274(%rax),%eax
ffff80000010627e:	85 c0                	test   %eax,%eax
ffff800000106280:	75 8a                	jne    ffff80000010620c <piperead+0x2c>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
ffff800000106282:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000106289:	eb 54                	jmp    ffff8000001062df <piperead+0xff>
    if(p->nread == p->nwrite)
ffff80000010628b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010628f:	8b 90 68 02 00 00    	mov    0x268(%rax),%edx
ffff800000106295:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106299:	8b 80 6c 02 00 00    	mov    0x26c(%rax),%eax
ffff80000010629f:	39 c2                	cmp    %eax,%edx
ffff8000001062a1:	74 46                	je     ffff8000001062e9 <piperead+0x109>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
ffff8000001062a3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001062a7:	8b 80 68 02 00 00    	mov    0x268(%rax),%eax
ffff8000001062ad:	8d 48 01             	lea    0x1(%rax),%ecx
ffff8000001062b0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff8000001062b4:	89 8a 68 02 00 00    	mov    %ecx,0x268(%rdx)
ffff8000001062ba:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff8000001062bf:	89 c1                	mov    %eax,%ecx
ffff8000001062c1:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001062c4:	48 63 d0             	movslq %eax,%rdx
ffff8000001062c7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001062cb:	48 01 c2             	add    %rax,%rdx
ffff8000001062ce:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001062d2:	89 c9                	mov    %ecx,%ecx
ffff8000001062d4:	0f b6 44 08 68       	movzbl 0x68(%rax,%rcx,1),%eax
ffff8000001062d9:	88 02                	mov    %al,(%rdx)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
ffff8000001062db:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001062df:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001062e2:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffff8000001062e5:	7c a4                	jl     ffff80000010628b <piperead+0xab>
ffff8000001062e7:	eb 01                	jmp    ffff8000001062ea <piperead+0x10a>
      break;
ffff8000001062e9:	90                   	nop
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
ffff8000001062ea:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001062ee:	48 05 6c 02 00 00    	add    $0x26c,%rax
ffff8000001062f4:	48 89 c7             	mov    %rax,%rdi
ffff8000001062f7:	48 b8 21 72 10 00 00 	movabs $0xffff800000107221,%rax
ffff8000001062fe:	80 ff ff 
ffff800000106301:	ff d0                	call   *%rax
  release(&p->lock);
ffff800000106303:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106307:	48 89 c7             	mov    %rax,%rdi
ffff80000010630a:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff800000106311:	80 ff ff 
ffff800000106314:	ff d0                	call   *%rax
  return i;
ffff800000106316:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff800000106319:	c9                   	leave
ffff80000010631a:	c3                   	ret

ffff80000010631b <readeflags>:
  p->tf->rcx = PGSIZE;  // with SYSRET, RIP is in RCX

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");

  __sync_synchronize();
ffff80000010631b:	f3 0f 1e fa          	endbr64
ffff80000010631f:	55                   	push   %rbp
ffff800000106320:	48 89 e5             	mov    %rsp,%rbp
ffff800000106323:	48 83 ec 10          	sub    $0x10,%rsp
  p->state = RUNNABLE;
}
ffff800000106327:	9c                   	pushf
ffff800000106328:	58                   	pop    %rax
ffff800000106329:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

ffff80000010632d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
// Grow current process's memory by n bytes.
ffff800000106331:	c9                   	leave
ffff800000106332:	c3                   	ret

ffff800000106333 <sti>:
  addr_t sz;

  sz = proc->sz;
  if(n > 0){
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
ffff800000106333:	f3 0f 1e fa          	endbr64
ffff800000106337:	55                   	push   %rbp
ffff800000106338:	48 89 e5             	mov    %rsp,%rbp
  } else if(n < 0){
ffff80000010633b:	fb                   	sti
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
ffff80000010633c:	90                   	nop
ffff80000010633d:	5d                   	pop    %rbp
ffff80000010633e:	c3                   	ret

ffff80000010633f <hlt>:
      return -1;
  }
  proc->sz = sz;
  switchuvm(proc);
ffff80000010633f:	f3 0f 1e fa          	endbr64
ffff800000106343:	55                   	push   %rbp
ffff800000106344:	48 89 e5             	mov    %rsp,%rbp
  return 0;
ffff800000106347:	f4                   	hlt
}
ffff800000106348:	90                   	nop
ffff800000106349:	5d                   	pop    %rbp
ffff80000010634a:	c3                   	ret

ffff80000010634b <pinit>:
{
ffff80000010634b:	f3 0f 1e fa          	endbr64
ffff80000010634f:	55                   	push   %rbp
ffff800000106350:	48 89 e5             	mov    %rsp,%rbp
  initlock(&ptable.lock, "ptable");
ffff800000106353:	48 b8 83 c7 10 00 00 	movabs $0xffff80000010c783,%rax
ffff80000010635a:	80 ff ff 
ffff80000010635d:	48 89 c6             	mov    %rax,%rsi
ffff800000106360:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106367:	80 ff ff 
ffff80000010636a:	48 89 c7             	mov    %rax,%rdi
ffff80000010636d:	48 b8 96 79 10 00 00 	movabs $0xffff800000107996,%rax
ffff800000106374:	80 ff ff 
ffff800000106377:	ff d0                	call   *%rax
}
ffff800000106379:	90                   	nop
ffff80000010637a:	5d                   	pop    %rbp
ffff80000010637b:	c3                   	ret

ffff80000010637c <allocproc>:
{
ffff80000010637c:	f3 0f 1e fa          	endbr64
ffff800000106380:	55                   	push   %rbp
ffff800000106381:	48 89 e5             	mov    %rsp,%rbp
ffff800000106384:	48 83 ec 10          	sub    $0x10,%rsp
  acquire(&ptable.lock);
ffff800000106388:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff80000010638f:	80 ff ff 
ffff800000106392:	48 89 c7             	mov    %rax,%rdi
ffff800000106395:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff80000010639c:	80 ff ff 
ffff80000010639f:	ff d0                	call   *%rax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffff8000001063a1:	48 b8 a8 74 11 00 00 	movabs $0xffff8000001174a8,%rax
ffff8000001063a8:	80 ff ff 
ffff8000001063ab:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001063af:	eb 13                	jmp    ffff8000001063c4 <allocproc+0x48>
    if(p->state == UNUSED)
ffff8000001063b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001063b5:	8b 40 18             	mov    0x18(%rax),%eax
ffff8000001063b8:	85 c0                	test   %eax,%eax
ffff8000001063ba:	74 3b                	je     ffff8000001063f7 <allocproc+0x7b>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffff8000001063bc:	48 81 45 f8 c0 01 00 	addq   $0x1c0,-0x8(%rbp)
ffff8000001063c3:	00 
ffff8000001063c4:	48 b8 a8 e4 11 00 00 	movabs $0xffff80000011e4a8,%rax
ffff8000001063cb:	80 ff ff 
ffff8000001063ce:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff8000001063d2:	72 dd                	jb     ffff8000001063b1 <allocproc+0x35>
  release(&ptable.lock);
ffff8000001063d4:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff8000001063db:	80 ff ff 
ffff8000001063de:	48 89 c7             	mov    %rax,%rdi
ffff8000001063e1:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff8000001063e8:	80 ff ff 
ffff8000001063eb:	ff d0                	call   *%rax
  return 0;
ffff8000001063ed:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001063f2:	e9 05 01 00 00       	jmp    ffff8000001064fc <allocproc+0x180>
      goto found;
ffff8000001063f7:	90                   	nop
  p->state = EMBRYO;
ffff8000001063f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001063fc:	c7 40 18 01 00 00 00 	movl   $0x1,0x18(%rax)
  p->pid = nextpid++;
ffff800000106403:	48 b8 40 d5 10 00 00 	movabs $0xffff80000010d540,%rax
ffff80000010640a:	80 ff ff 
ffff80000010640d:	8b 00                	mov    (%rax),%eax
ffff80000010640f:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000106412:	48 b9 40 d5 10 00 00 	movabs $0xffff80000010d540,%rcx
ffff800000106419:	80 ff ff 
ffff80000010641c:	89 11                	mov    %edx,(%rcx)
ffff80000010641e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000106422:	89 42 1c             	mov    %eax,0x1c(%rdx)
  release(&ptable.lock);
ffff800000106425:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff80000010642c:	80 ff ff 
ffff80000010642f:	48 89 c7             	mov    %rax,%rdi
ffff800000106432:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff800000106439:	80 ff ff 
ffff80000010643c:	ff d0                	call   *%rax
  if((p->kstack = kalloc()) == 0){
ffff80000010643e:	48 b8 00 43 10 00 00 	movabs $0xffff800000104300,%rax
ffff800000106445:	80 ff ff 
ffff800000106448:	ff d0                	call   *%rax
ffff80000010644a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010644e:	48 89 42 10          	mov    %rax,0x10(%rdx)
ffff800000106452:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106456:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff80000010645a:	48 85 c0             	test   %rax,%rax
ffff80000010645d:	75 15                	jne    ffff800000106474 <allocproc+0xf8>
    p->state = UNUSED;
ffff80000010645f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106463:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
    return 0;
ffff80000010646a:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010646f:	e9 88 00 00 00       	jmp    ffff8000001064fc <allocproc+0x180>
  sp = p->kstack + KSTACKSIZE;
ffff800000106474:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106478:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff80000010647c:	48 05 00 10 00 00    	add    $0x1000,%rax
ffff800000106482:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  sp -= sizeof *p->tf;
ffff800000106486:	48 81 6d f0 b0 00 00 	subq   $0xb0,-0x10(%rbp)
ffff80000010648d:	00 
  p->tf = (struct trapframe*)sp;
ffff80000010648e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106492:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000106496:	48 89 50 28          	mov    %rdx,0x28(%rax)
  sp -= sizeof(addr_t);
ffff80000010649a:	48 83 6d f0 08       	subq   $0x8,-0x10(%rbp)
  *(addr_t*)sp = (addr_t)syscall_trapret;
ffff80000010649f:	48 ba af 9b 10 00 00 	movabs $0xffff800000109baf,%rdx
ffff8000001064a6:	80 ff ff 
ffff8000001064a9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001064ad:	48 89 10             	mov    %rdx,(%rax)
  sp -= sizeof *p->context;
ffff8000001064b0:	48 83 6d f0 38       	subq   $0x38,-0x10(%rbp)
  p->context = (struct context*)sp;
ffff8000001064b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001064b9:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff8000001064bd:	48 89 50 30          	mov    %rdx,0x30(%rax)
  memset(p->context, 0, sizeof *p->context);
ffff8000001064c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001064c5:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff8000001064c9:	ba 38 00 00 00       	mov    $0x38,%edx
ffff8000001064ce:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001064d3:	48 89 c7             	mov    %rax,%rdi
ffff8000001064d6:	48 b8 87 7d 10 00 00 	movabs $0xffff800000107d87,%rax
ffff8000001064dd:	80 ff ff 
ffff8000001064e0:	ff d0                	call   *%rax
  p->context->rip = (addr_t)forkret;
ffff8000001064e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001064e6:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff8000001064ea:	48 ba 3e 70 10 00 00 	movabs $0xffff80000010703e,%rdx
ffff8000001064f1:	80 ff ff 
ffff8000001064f4:	48 89 50 30          	mov    %rdx,0x30(%rax)
  return p;
ffff8000001064f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff8000001064fc:	c9                   	leave
ffff8000001064fd:	c3                   	ret

ffff8000001064fe <userinit>:
{
ffff8000001064fe:	f3 0f 1e fa          	endbr64
ffff800000106502:	55                   	push   %rbp
ffff800000106503:	48 89 e5             	mov    %rsp,%rbp
ffff800000106506:	48 83 ec 10          	sub    $0x10,%rsp
  p = allocproc();
ffff80000010650a:	48 b8 7c 63 10 00 00 	movabs $0xffff80000010637c,%rax
ffff800000106511:	80 ff ff 
ffff800000106514:	ff d0                	call   *%rax
ffff800000106516:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  initproc = p;
ffff80000010651a:	48 ba a8 e4 11 00 00 	movabs $0xffff80000011e4a8,%rdx
ffff800000106521:	80 ff ff 
ffff800000106524:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106528:	48 89 02             	mov    %rax,(%rdx)
  if((p->pgdir = setupkvm()) == 0)
ffff80000010652b:	48 b8 1f b4 10 00 00 	movabs $0xffff80000010b41f,%rax
ffff800000106532:	80 ff ff 
ffff800000106535:	ff d0                	call   *%rax
ffff800000106537:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010653b:	48 89 42 08          	mov    %rax,0x8(%rdx)
ffff80000010653f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106543:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000106547:	48 85 c0             	test   %rax,%rax
ffff80000010654a:	75 19                	jne    ffff800000106565 <userinit+0x67>
    panic("userinit: out of memory?");
ffff80000010654c:	48 b8 8a c7 10 00 00 	movabs $0xffff80000010c78a,%rax
ffff800000106553:	80 ff ff 
ffff800000106556:	48 89 c7             	mov    %rax,%rdi
ffff800000106559:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000106560:	80 ff ff 
ffff800000106563:	ff d0                	call   *%rax
  inituvm(p->pgdir, _binary_initcode_start,
ffff800000106565:	48 b8 40 00 00 00 00 	movabs $0x40,%rax
ffff80000010656c:	00 00 00 
ffff80000010656f:	89 c2                	mov    %eax,%edx
ffff800000106571:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106575:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000106579:	48 b9 60 de 10 00 00 	movabs $0xffff80000010de60,%rcx
ffff800000106580:	80 ff ff 
ffff800000106583:	48 89 ce             	mov    %rcx,%rsi
ffff800000106586:	48 89 c7             	mov    %rax,%rdi
ffff800000106589:	48 b8 ad b9 10 00 00 	movabs $0xffff80000010b9ad,%rax
ffff800000106590:	80 ff ff 
ffff800000106593:	ff d0                	call   *%rax
  p->sz = PGSIZE * 2;
ffff800000106595:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106599:	48 c7 00 00 20 00 00 	movq   $0x2000,(%rax)
  memset(p->tf, 0, sizeof(*p->tf));
ffff8000001065a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001065a4:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001065a8:	ba b0 00 00 00       	mov    $0xb0,%edx
ffff8000001065ad:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001065b2:	48 89 c7             	mov    %rax,%rdi
ffff8000001065b5:	48 b8 87 7d 10 00 00 	movabs $0xffff800000107d87,%rax
ffff8000001065bc:	80 ff ff 
ffff8000001065bf:	ff d0                	call   *%rax
  p->tf->r11 = FL_IF;  // with SYSRET, EFLAGS is in R11
ffff8000001065c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001065c5:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001065c9:	48 c7 40 50 00 02 00 	movq   $0x200,0x50(%rax)
ffff8000001065d0:	00 
  p->tf->rsp = p->sz;
ffff8000001065d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001065d5:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001065d9:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001065dd:	48 8b 12             	mov    (%rdx),%rdx
ffff8000001065e0:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
  p->tf->rcx = PGSIZE;  // with SYSRET, RIP is in RCX
ffff8000001065e7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001065eb:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001065ef:	48 c7 40 10 00 10 00 	movq   $0x1000,0x10(%rax)
ffff8000001065f6:	00 
  safestrcpy(p->name, "initcode", sizeof(p->name));
ffff8000001065f7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001065fb:	48 05 d0 00 00 00    	add    $0xd0,%rax
ffff800000106601:	ba 10 00 00 00       	mov    $0x10,%edx
ffff800000106606:	48 b9 a3 c7 10 00 00 	movabs $0xffff80000010c7a3,%rcx
ffff80000010660d:	80 ff ff 
ffff800000106610:	48 89 ce             	mov    %rcx,%rsi
ffff800000106613:	48 89 c7             	mov    %rax,%rdi
ffff800000106616:	48 b8 57 80 10 00 00 	movabs $0xffff800000108057,%rax
ffff80000010661d:	80 ff ff 
ffff800000106620:	ff d0                	call   *%rax
  p->cwd = namei("/");
ffff800000106622:	48 b8 ac c7 10 00 00 	movabs $0xffff80000010c7ac,%rax
ffff800000106629:	80 ff ff 
ffff80000010662c:	48 89 c7             	mov    %rax,%rdi
ffff80000010662f:	48 b8 a5 38 10 00 00 	movabs $0xffff8000001038a5,%rax
ffff800000106636:	80 ff ff 
ffff800000106639:	ff d0                	call   *%rax
ffff80000010663b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010663f:	48 89 82 c8 00 00 00 	mov    %rax,0xc8(%rdx)
  __sync_synchronize();
ffff800000106646:	f0 48 83 0c 24 00    	lock orq $0x0,(%rsp)
  p->state = RUNNABLE;
ffff80000010664c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106650:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
}
ffff800000106657:	90                   	nop
ffff800000106658:	c9                   	leave
ffff800000106659:	c3                   	ret

ffff80000010665a <growproc>:
{
ffff80000010665a:	f3 0f 1e fa          	endbr64
ffff80000010665e:	55                   	push   %rbp
ffff80000010665f:	48 89 e5             	mov    %rsp,%rbp
ffff800000106662:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000106666:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  sz = proc->sz;
ffff80000010666a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106671:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106675:	48 8b 00             	mov    (%rax),%rax
ffff800000106678:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(n > 0){
ffff80000010667c:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff800000106681:	7e 42                	jle    ffff8000001066c5 <growproc+0x6b>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
ffff800000106683:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000106687:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010668b:	48 01 c2             	add    %rax,%rdx
ffff80000010668e:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106695:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106699:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010669d:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff8000001066a1:	48 89 ce             	mov    %rcx,%rsi
ffff8000001066a4:	48 89 c7             	mov    %rax,%rdi
ffff8000001066a7:	48 b8 96 bb 10 00 00 	movabs $0xffff80000010bb96,%rax
ffff8000001066ae:	80 ff ff 
ffff8000001066b1:	ff d0                	call   *%rax
ffff8000001066b3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001066b7:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff8000001066bc:	75 50                	jne    ffff80000010670e <growproc+0xb4>
      return -1;
ffff8000001066be:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001066c3:	eb 7a                	jmp    ffff80000010673f <growproc+0xe5>
  } else if(n < 0){
ffff8000001066c5:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff8000001066ca:	79 42                	jns    ffff80000010670e <growproc+0xb4>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
ffff8000001066cc:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff8000001066d0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001066d4:	48 01 c2             	add    %rax,%rdx
ffff8000001066d7:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001066de:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001066e2:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff8000001066e6:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff8000001066ea:	48 89 ce             	mov    %rcx,%rsi
ffff8000001066ed:	48 89 c7             	mov    %rax,%rdi
ffff8000001066f0:	48 b8 de bc 10 00 00 	movabs $0xffff80000010bcde,%rax
ffff8000001066f7:	80 ff ff 
ffff8000001066fa:	ff d0                	call   *%rax
ffff8000001066fc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000106700:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000106705:	75 07                	jne    ffff80000010670e <growproc+0xb4>
      return -1;
ffff800000106707:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010670c:	eb 31                	jmp    ffff80000010673f <growproc+0xe5>
  proc->sz = sz;
ffff80000010670e:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106715:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106719:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010671d:	48 89 10             	mov    %rdx,(%rax)
  switchuvm(proc);
ffff800000106720:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106727:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010672b:	48 89 c7             	mov    %rax,%rdi
ffff80000010672e:	48 b8 85 b5 10 00 00 	movabs $0xffff80000010b585,%rax
ffff800000106735:	80 ff ff 
ffff800000106738:	ff d0                	call   *%rax
  return 0;
ffff80000010673a:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010673f:	c9                   	leave
ffff800000106740:	c3                   	ret

ffff800000106741 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
ffff800000106741:	f3 0f 1e fa          	endbr64
ffff800000106745:	55                   	push   %rbp
ffff800000106746:	48 89 e5             	mov    %rsp,%rbp
ffff800000106749:	53                   	push   %rbx
ffff80000010674a:	48 83 ec 28          	sub    $0x28,%rsp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
ffff80000010674e:	48 b8 7c 63 10 00 00 	movabs $0xffff80000010637c,%rax
ffff800000106755:	80 ff ff 
ffff800000106758:	ff d0                	call   *%rax
ffff80000010675a:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff80000010675e:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
ffff800000106763:	75 0a                	jne    ffff80000010676f <fork+0x2e>
    return -1;
ffff800000106765:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010676a:	e9 88 02 00 00       	jmp    ffff8000001069f7 <fork+0x2b6>

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
ffff80000010676f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106776:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010677a:	48 8b 00             	mov    (%rax),%rax
ffff80000010677d:	89 c2                	mov    %eax,%edx
ffff80000010677f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106786:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010678a:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010678e:	89 d6                	mov    %edx,%esi
ffff800000106790:	48 89 c7             	mov    %rax,%rdi
ffff800000106793:	48 b8 85 c0 10 00 00 	movabs $0xffff80000010c085,%rax
ffff80000010679a:	80 ff ff 
ffff80000010679d:	ff d0                	call   *%rax
ffff80000010679f:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff8000001067a3:	48 89 42 08          	mov    %rax,0x8(%rdx)
ffff8000001067a7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001067ab:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff8000001067af:	48 85 c0             	test   %rax,%rax
ffff8000001067b2:	75 38                	jne    ffff8000001067ec <fork+0xab>
    kfree(np->kstack);
ffff8000001067b4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001067b8:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff8000001067bc:	48 89 c7             	mov    %rax,%rdi
ffff8000001067bf:	48 b8 fd 41 10 00 00 	movabs $0xffff8000001041fd,%rax
ffff8000001067c6:	80 ff ff 
ffff8000001067c9:	ff d0                	call   *%rax
    np->kstack = 0;
ffff8000001067cb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001067cf:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff8000001067d6:	00 
    np->state = UNUSED;
ffff8000001067d7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001067db:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
    return -1;
ffff8000001067e2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001067e7:	e9 0b 02 00 00       	jmp    ffff8000001069f7 <fork+0x2b6>
  }
  np->sz = proc->sz;
ffff8000001067ec:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001067f3:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001067f7:	48 8b 10             	mov    (%rax),%rdx
ffff8000001067fa:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001067fe:	48 89 10             	mov    %rdx,(%rax)
  np->parent = proc;
ffff800000106801:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106808:	64 48 8b 10          	mov    %fs:(%rax),%rdx
ffff80000010680c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106810:	48 89 50 20          	mov    %rdx,0x20(%rax)
  *np->tf = *proc->tf;
ffff800000106814:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010681b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010681f:	48 8b 50 28          	mov    0x28(%rax),%rdx
ffff800000106823:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106827:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff80000010682b:	48 8b 0a             	mov    (%rdx),%rcx
ffff80000010682e:	48 8b 5a 08          	mov    0x8(%rdx),%rbx
ffff800000106832:	48 89 08             	mov    %rcx,(%rax)
ffff800000106835:	48 89 58 08          	mov    %rbx,0x8(%rax)
ffff800000106839:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
ffff80000010683d:	48 8b 5a 18          	mov    0x18(%rdx),%rbx
ffff800000106841:	48 89 48 10          	mov    %rcx,0x10(%rax)
ffff800000106845:	48 89 58 18          	mov    %rbx,0x18(%rax)
ffff800000106849:	48 8b 4a 20          	mov    0x20(%rdx),%rcx
ffff80000010684d:	48 8b 5a 28          	mov    0x28(%rdx),%rbx
ffff800000106851:	48 89 48 20          	mov    %rcx,0x20(%rax)
ffff800000106855:	48 89 58 28          	mov    %rbx,0x28(%rax)
ffff800000106859:	48 8b 4a 30          	mov    0x30(%rdx),%rcx
ffff80000010685d:	48 8b 5a 38          	mov    0x38(%rdx),%rbx
ffff800000106861:	48 89 48 30          	mov    %rcx,0x30(%rax)
ffff800000106865:	48 89 58 38          	mov    %rbx,0x38(%rax)
ffff800000106869:	48 8b 4a 40          	mov    0x40(%rdx),%rcx
ffff80000010686d:	48 8b 5a 48          	mov    0x48(%rdx),%rbx
ffff800000106871:	48 89 48 40          	mov    %rcx,0x40(%rax)
ffff800000106875:	48 89 58 48          	mov    %rbx,0x48(%rax)
ffff800000106879:	48 8b 4a 50          	mov    0x50(%rdx),%rcx
ffff80000010687d:	48 8b 5a 58          	mov    0x58(%rdx),%rbx
ffff800000106881:	48 89 48 50          	mov    %rcx,0x50(%rax)
ffff800000106885:	48 89 58 58          	mov    %rbx,0x58(%rax)
ffff800000106889:	48 8b 4a 60          	mov    0x60(%rdx),%rcx
ffff80000010688d:	48 8b 5a 68          	mov    0x68(%rdx),%rbx
ffff800000106891:	48 89 48 60          	mov    %rcx,0x60(%rax)
ffff800000106895:	48 89 58 68          	mov    %rbx,0x68(%rax)
ffff800000106899:	48 8b 4a 70          	mov    0x70(%rdx),%rcx
ffff80000010689d:	48 8b 5a 78          	mov    0x78(%rdx),%rbx
ffff8000001068a1:	48 89 48 70          	mov    %rcx,0x70(%rax)
ffff8000001068a5:	48 89 58 78          	mov    %rbx,0x78(%rax)
ffff8000001068a9:	48 8b 8a 80 00 00 00 	mov    0x80(%rdx),%rcx
ffff8000001068b0:	48 8b 9a 88 00 00 00 	mov    0x88(%rdx),%rbx
ffff8000001068b7:	48 89 88 80 00 00 00 	mov    %rcx,0x80(%rax)
ffff8000001068be:	48 89 98 88 00 00 00 	mov    %rbx,0x88(%rax)
ffff8000001068c5:	48 8b 8a 90 00 00 00 	mov    0x90(%rdx),%rcx
ffff8000001068cc:	48 8b 9a 98 00 00 00 	mov    0x98(%rdx),%rbx
ffff8000001068d3:	48 89 88 90 00 00 00 	mov    %rcx,0x90(%rax)
ffff8000001068da:	48 89 98 98 00 00 00 	mov    %rbx,0x98(%rax)
ffff8000001068e1:	48 8b 8a a0 00 00 00 	mov    0xa0(%rdx),%rcx
ffff8000001068e8:	48 8b 9a a8 00 00 00 	mov    0xa8(%rdx),%rbx
ffff8000001068ef:	48 89 88 a0 00 00 00 	mov    %rcx,0xa0(%rax)
ffff8000001068f6:	48 89 98 a8 00 00 00 	mov    %rbx,0xa8(%rax)

  // Clear %rax so that fork returns 0 in the child.
  np->tf->rax = 0;
ffff8000001068fd:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106901:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000106905:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)

  for(i = 0; i < NOFILE; i++)
ffff80000010690c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
ffff800000106913:	eb 5f                	jmp    ffff800000106974 <fork+0x233>
    if(proc->ofile[i])
ffff800000106915:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010691c:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106920:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff800000106923:	48 63 d2             	movslq %edx,%rdx
ffff800000106926:	48 83 c2 08          	add    $0x8,%rdx
ffff80000010692a:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff80000010692f:	48 85 c0             	test   %rax,%rax
ffff800000106932:	74 3c                	je     ffff800000106970 <fork+0x22f>
      np->ofile[i] = filedup(proc->ofile[i]);
ffff800000106934:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010693b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010693f:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff800000106942:	48 63 d2             	movslq %edx,%rdx
ffff800000106945:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106949:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff80000010694e:	48 89 c7             	mov    %rax,%rdi
ffff800000106951:	48 b8 61 1c 10 00 00 	movabs $0xffff800000101c61,%rax
ffff800000106958:	80 ff ff 
ffff80000010695b:	ff d0                	call   *%rax
ffff80000010695d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000106961:	8b 4d ec             	mov    -0x14(%rbp),%ecx
ffff800000106964:	48 63 c9             	movslq %ecx,%rcx
ffff800000106967:	48 83 c1 08          	add    $0x8,%rcx
ffff80000010696b:	48 89 44 ca 08       	mov    %rax,0x8(%rdx,%rcx,8)
  for(i = 0; i < NOFILE; i++)
ffff800000106970:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
ffff800000106974:	83 7d ec 0f          	cmpl   $0xf,-0x14(%rbp)
ffff800000106978:	7e 9b                	jle    ffff800000106915 <fork+0x1d4>
  np->cwd = idup(proc->cwd);
ffff80000010697a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106981:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106985:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffff80000010698c:	48 89 c7             	mov    %rax,%rdi
ffff80000010698f:	48 b8 0d 29 10 00 00 	movabs $0xffff80000010290d,%rax
ffff800000106996:	80 ff ff 
ffff800000106999:	ff d0                	call   *%rax
ffff80000010699b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff80000010699f:	48 89 82 c8 00 00 00 	mov    %rax,0xc8(%rdx)

  safestrcpy(np->name, proc->name, sizeof(proc->name));
ffff8000001069a6:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001069ad:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001069b1:	48 8d 88 d0 00 00 00 	lea    0xd0(%rax),%rcx
ffff8000001069b8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001069bc:	48 05 d0 00 00 00    	add    $0xd0,%rax
ffff8000001069c2:	ba 10 00 00 00       	mov    $0x10,%edx
ffff8000001069c7:	48 89 ce             	mov    %rcx,%rsi
ffff8000001069ca:	48 89 c7             	mov    %rax,%rdi
ffff8000001069cd:	48 b8 57 80 10 00 00 	movabs $0xffff800000108057,%rax
ffff8000001069d4:	80 ff ff 
ffff8000001069d7:	ff d0                	call   *%rax

  pid = np->pid;
ffff8000001069d9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001069dd:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff8000001069e0:	89 45 dc             	mov    %eax,-0x24(%rbp)

  __sync_synchronize();
ffff8000001069e3:	f0 48 83 0c 24 00    	lock orq $0x0,(%rsp)
  np->state = RUNNABLE;
ffff8000001069e9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001069ed:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)

  return pid;
ffff8000001069f4:	8b 45 dc             	mov    -0x24(%rbp),%eax
}
ffff8000001069f7:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
ffff8000001069fb:	c9                   	leave
ffff8000001069fc:	c3                   	ret

ffff8000001069fd <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
ffff8000001069fd:	f3 0f 1e fa          	endbr64
ffff800000106a01:	55                   	push   %rbp
ffff800000106a02:	48 89 e5             	mov    %rsp,%rbp
ffff800000106a05:	48 83 ec 10          	sub    $0x10,%rsp
  struct proc *p;
  int fd;

  if(proc == initproc)
ffff800000106a09:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106a10:	64 48 8b 10          	mov    %fs:(%rax),%rdx
ffff800000106a14:	48 b8 a8 e4 11 00 00 	movabs $0xffff80000011e4a8,%rax
ffff800000106a1b:	80 ff ff 
ffff800000106a1e:	48 8b 00             	mov    (%rax),%rax
ffff800000106a21:	48 39 c2             	cmp    %rax,%rdx
ffff800000106a24:	75 19                	jne    ffff800000106a3f <exit+0x42>
    panic("init exiting");
ffff800000106a26:	48 b8 ae c7 10 00 00 	movabs $0xffff80000010c7ae,%rax
ffff800000106a2d:	80 ff ff 
ffff800000106a30:	48 89 c7             	mov    %rax,%rdi
ffff800000106a33:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000106a3a:	80 ff ff 
ffff800000106a3d:	ff d0                	call   *%rax

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
ffff800000106a3f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
ffff800000106a46:	eb 6a                	jmp    ffff800000106ab2 <exit+0xb5>
    if(proc->ofile[fd]){
ffff800000106a48:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106a4f:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106a53:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff800000106a56:	48 63 d2             	movslq %edx,%rdx
ffff800000106a59:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106a5d:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff800000106a62:	48 85 c0             	test   %rax,%rax
ffff800000106a65:	74 47                	je     ffff800000106aae <exit+0xb1>
      fileclose(proc->ofile[fd]);
ffff800000106a67:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106a6e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106a72:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff800000106a75:	48 63 d2             	movslq %edx,%rdx
ffff800000106a78:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106a7c:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff800000106a81:	48 89 c7             	mov    %rax,%rdi
ffff800000106a84:	48 b8 de 1c 10 00 00 	movabs $0xffff800000101cde,%rax
ffff800000106a8b:	80 ff ff 
ffff800000106a8e:	ff d0                	call   *%rax
      proc->ofile[fd] = 0;
ffff800000106a90:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106a97:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106a9b:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff800000106a9e:	48 63 d2             	movslq %edx,%rdx
ffff800000106aa1:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106aa5:	48 c7 44 d0 08 00 00 	movq   $0x0,0x8(%rax,%rdx,8)
ffff800000106aac:	00 00 
  for(fd = 0; fd < NOFILE; fd++){
ffff800000106aae:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
ffff800000106ab2:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
ffff800000106ab6:	7e 90                	jle    ffff800000106a48 <exit+0x4b>
    }
  }

  begin_op();
ffff800000106ab8:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106abd:	48 ba 70 50 10 00 00 	movabs $0xffff800000105070,%rdx
ffff800000106ac4:	80 ff ff 
ffff800000106ac7:	ff d2                	call   *%rdx
  iput(proc->cwd);
ffff800000106ac9:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106ad0:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106ad4:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffff800000106adb:	48 89 c7             	mov    %rax,%rdi
ffff800000106ade:	48 b8 71 2b 10 00 00 	movabs $0xffff800000102b71,%rax
ffff800000106ae5:	80 ff ff 
ffff800000106ae8:	ff d0                	call   *%rax
  end_op();
ffff800000106aea:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106aef:	48 ba 5c 51 10 00 00 	movabs $0xffff80000010515c,%rdx
ffff800000106af6:	80 ff ff 
ffff800000106af9:	ff d2                	call   *%rdx
  proc->cwd = 0;
ffff800000106afb:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106b02:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106b06:	48 c7 80 c8 00 00 00 	movq   $0x0,0xc8(%rax)
ffff800000106b0d:	00 00 00 00 

  acquire(&ptable.lock);
ffff800000106b11:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106b18:	80 ff ff 
ffff800000106b1b:	48 89 c7             	mov    %rax,%rdi
ffff800000106b1e:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff800000106b25:	80 ff ff 
ffff800000106b28:	ff d0                	call   *%rax

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
ffff800000106b2a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106b31:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106b35:	48 8b 40 20          	mov    0x20(%rax),%rax
ffff800000106b39:	48 89 c7             	mov    %rax,%rdi
ffff800000106b3c:	48 b8 c0 71 10 00 00 	movabs $0xffff8000001071c0,%rax
ffff800000106b43:	80 ff ff 
ffff800000106b46:	ff d0                	call   *%rax

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106b48:	48 b8 a8 74 11 00 00 	movabs $0xffff8000001174a8,%rax
ffff800000106b4f:	80 ff ff 
ffff800000106b52:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000106b56:	eb 5d                	jmp    ffff800000106bb5 <exit+0x1b8>
    if(p->parent == proc){
ffff800000106b58:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106b5c:	48 8b 50 20          	mov    0x20(%rax),%rdx
ffff800000106b60:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106b67:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106b6b:	48 39 c2             	cmp    %rax,%rdx
ffff800000106b6e:	75 3d                	jne    ffff800000106bad <exit+0x1b0>
      p->parent = initproc;
ffff800000106b70:	48 b8 a8 e4 11 00 00 	movabs $0xffff80000011e4a8,%rax
ffff800000106b77:	80 ff ff 
ffff800000106b7a:	48 8b 10             	mov    (%rax),%rdx
ffff800000106b7d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106b81:	48 89 50 20          	mov    %rdx,0x20(%rax)
      if(p->state == ZOMBIE)
ffff800000106b85:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106b89:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106b8c:	83 f8 05             	cmp    $0x5,%eax
ffff800000106b8f:	75 1c                	jne    ffff800000106bad <exit+0x1b0>
        wakeup1(initproc);
ffff800000106b91:	48 b8 a8 e4 11 00 00 	movabs $0xffff80000011e4a8,%rax
ffff800000106b98:	80 ff ff 
ffff800000106b9b:	48 8b 00             	mov    (%rax),%rax
ffff800000106b9e:	48 89 c7             	mov    %rax,%rdi
ffff800000106ba1:	48 b8 c0 71 10 00 00 	movabs $0xffff8000001071c0,%rax
ffff800000106ba8:	80 ff ff 
ffff800000106bab:	ff d0                	call   *%rax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106bad:	48 81 45 f8 c0 01 00 	addq   $0x1c0,-0x8(%rbp)
ffff800000106bb4:	00 
ffff800000106bb5:	48 b8 a8 e4 11 00 00 	movabs $0xffff80000011e4a8,%rax
ffff800000106bbc:	80 ff ff 
ffff800000106bbf:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000106bc3:	72 93                	jb     ffff800000106b58 <exit+0x15b>
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
ffff800000106bc5:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106bcc:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106bd0:	c7 40 18 05 00 00 00 	movl   $0x5,0x18(%rax)
  sched();
ffff800000106bd7:	48 b8 c5 6e 10 00 00 	movabs $0xffff800000106ec5,%rax
ffff800000106bde:	80 ff ff 
ffff800000106be1:	ff d0                	call   *%rax
  panic("zombie exit");
ffff800000106be3:	48 b8 bb c7 10 00 00 	movabs $0xffff80000010c7bb,%rax
ffff800000106bea:	80 ff ff 
ffff800000106bed:	48 89 c7             	mov    %rax,%rdi
ffff800000106bf0:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000106bf7:	80 ff ff 
ffff800000106bfa:	ff d0                	call   *%rax

ffff800000106bfc <wait>:
//PAGEBREAK!
// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
ffff800000106bfc:	f3 0f 1e fa          	endbr64
ffff800000106c00:	55                   	push   %rbp
ffff800000106c01:	48 89 e5             	mov    %rsp,%rbp
ffff800000106c04:	48 83 ec 10          	sub    $0x10,%rsp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
ffff800000106c08:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106c0f:	80 ff ff 
ffff800000106c12:	48 89 c7             	mov    %rax,%rdi
ffff800000106c15:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff800000106c1c:	80 ff ff 
ffff800000106c1f:	ff d0                	call   *%rax
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
ffff800000106c21:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106c28:	48 b8 a8 74 11 00 00 	movabs $0xffff8000001174a8,%rax
ffff800000106c2f:	80 ff ff 
ffff800000106c32:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000106c36:	e9 d9 00 00 00       	jmp    ffff800000106d14 <wait+0x118>
      if(p->parent != proc)
ffff800000106c3b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106c3f:	48 8b 50 20          	mov    0x20(%rax),%rdx
ffff800000106c43:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106c4a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106c4e:	48 39 c2             	cmp    %rax,%rdx
ffff800000106c51:	0f 85 b4 00 00 00    	jne    ffff800000106d0b <wait+0x10f>
        continue;
      havekids = 1;
ffff800000106c57:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
      if(p->state == ZOMBIE){
ffff800000106c5e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106c62:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106c65:	83 f8 05             	cmp    $0x5,%eax
ffff800000106c68:	0f 85 9e 00 00 00    	jne    ffff800000106d0c <wait+0x110>
        // Found one.
        pid = p->pid;
ffff800000106c6e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106c72:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff800000106c75:	89 45 f0             	mov    %eax,-0x10(%rbp)
        kfree(p->kstack);
ffff800000106c78:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106c7c:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000106c80:	48 89 c7             	mov    %rax,%rdi
ffff800000106c83:	48 b8 fd 41 10 00 00 	movabs $0xffff8000001041fd,%rax
ffff800000106c8a:	80 ff ff 
ffff800000106c8d:	ff d0                	call   *%rax
        p->kstack = 0;
ffff800000106c8f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106c93:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff800000106c9a:	00 
        freevm(p->pgdir);
ffff800000106c9b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106c9f:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000106ca3:	48 89 c7             	mov    %rax,%rdi
ffff800000106ca6:	48 b8 db bd 10 00 00 	movabs $0xffff80000010bddb,%rax
ffff800000106cad:	80 ff ff 
ffff800000106cb0:	ff d0                	call   *%rax
        p->pid = 0;
ffff800000106cb2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106cb6:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%rax)
        p->parent = 0;
ffff800000106cbd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106cc1:	48 c7 40 20 00 00 00 	movq   $0x0,0x20(%rax)
ffff800000106cc8:	00 
        p->name[0] = 0;
ffff800000106cc9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106ccd:	c6 80 d0 00 00 00 00 	movb   $0x0,0xd0(%rax)
        p->killed = 0;
ffff800000106cd4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106cd8:	c7 40 40 00 00 00 00 	movl   $0x0,0x40(%rax)
        p->state = UNUSED;
ffff800000106cdf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106ce3:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
        release(&ptable.lock);
ffff800000106cea:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106cf1:	80 ff ff 
ffff800000106cf4:	48 89 c7             	mov    %rax,%rdi
ffff800000106cf7:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff800000106cfe:	80 ff ff 
ffff800000106d01:	ff d0                	call   *%rax
        return pid;
ffff800000106d03:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000106d06:	e9 81 00 00 00       	jmp    ffff800000106d8c <wait+0x190>
        continue;
ffff800000106d0b:	90                   	nop
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106d0c:	48 81 45 f8 c0 01 00 	addq   $0x1c0,-0x8(%rbp)
ffff800000106d13:	00 
ffff800000106d14:	48 b8 a8 e4 11 00 00 	movabs $0xffff80000011e4a8,%rax
ffff800000106d1b:	80 ff ff 
ffff800000106d1e:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000106d22:	0f 82 13 ff ff ff    	jb     ffff800000106c3b <wait+0x3f>
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
ffff800000106d28:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
ffff800000106d2c:	74 12                	je     ffff800000106d40 <wait+0x144>
ffff800000106d2e:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106d35:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106d39:	8b 40 40             	mov    0x40(%rax),%eax
ffff800000106d3c:	85 c0                	test   %eax,%eax
ffff800000106d3e:	74 20                	je     ffff800000106d60 <wait+0x164>
      release(&ptable.lock);
ffff800000106d40:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106d47:	80 ff ff 
ffff800000106d4a:	48 89 c7             	mov    %rax,%rdi
ffff800000106d4d:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff800000106d54:	80 ff ff 
ffff800000106d57:	ff d0                	call   *%rax
      return -1;
ffff800000106d59:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000106d5e:	eb 2c                	jmp    ffff800000106d8c <wait+0x190>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
ffff800000106d60:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106d67:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106d6b:	48 ba 40 74 11 00 00 	movabs $0xffff800000117440,%rdx
ffff800000106d72:	80 ff ff 
ffff800000106d75:	48 89 d6             	mov    %rdx,%rsi
ffff800000106d78:	48 89 c7             	mov    %rax,%rdi
ffff800000106d7b:	48 b8 a4 70 10 00 00 	movabs $0xffff8000001070a4,%rax
ffff800000106d82:	80 ff ff 
ffff800000106d85:	ff d0                	call   *%rax
    havekids = 0;
ffff800000106d87:	e9 95 fe ff ff       	jmp    ffff800000106c21 <wait+0x25>
  }
}
ffff800000106d8c:	c9                   	leave
ffff800000106d8d:	c3                   	ret

ffff800000106d8e <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
ffff800000106d8e:	f3 0f 1e fa          	endbr64
ffff800000106d92:	55                   	push   %rbp
ffff800000106d93:	48 89 e5             	mov    %rsp,%rbp
ffff800000106d96:	48 83 ec 20          	sub    $0x20,%rsp
  int i = 0;
ffff800000106d9a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  struct proc *p;
  int skipped = 0;
ffff800000106da1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
  for(;;){
    ++i;
ffff800000106da8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    // Enable interrupts on this processor.
    sti();
ffff800000106dac:	48 b8 33 63 10 00 00 	movabs $0xffff800000106333,%rax
ffff800000106db3:	80 ff ff 
ffff800000106db6:	ff d0                	call   *%rax
    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
ffff800000106db8:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106dbf:	80 ff ff 
ffff800000106dc2:	48 89 c7             	mov    %rax,%rdi
ffff800000106dc5:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff800000106dcc:	80 ff ff 
ffff800000106dcf:	ff d0                	call   *%rax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106dd1:	48 b8 a8 74 11 00 00 	movabs $0xffff8000001174a8,%rax
ffff800000106dd8:	80 ff ff 
ffff800000106ddb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000106ddf:	e9 92 00 00 00       	jmp    ffff800000106e76 <scheduler+0xe8>
      if(p->state != RUNNABLE) {
ffff800000106de4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106de8:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106deb:	83 f8 03             	cmp    $0x3,%eax
ffff800000106dee:	74 06                	je     ffff800000106df6 <scheduler+0x68>
        skipped++;
ffff800000106df0:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
        continue;
ffff800000106df4:	eb 78                	jmp    ffff800000106e6e <scheduler+0xe0>
      }
      skipped = 0;
ffff800000106df6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
ffff800000106dfd:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106e04:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000106e08:	64 48 89 10          	mov    %rdx,%fs:(%rax)
      switchuvm(p);
ffff800000106e0c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106e10:	48 89 c7             	mov    %rax,%rdi
ffff800000106e13:	48 b8 85 b5 10 00 00 	movabs $0xffff80000010b585,%rax
ffff800000106e1a:	80 ff ff 
ffff800000106e1d:	ff d0                	call   *%rax
      p->state = RUNNING;
ffff800000106e1f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106e23:	c7 40 18 04 00 00 00 	movl   $0x4,0x18(%rax)
      swtch(&cpu->scheduler, p->context);
ffff800000106e2a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106e2e:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff800000106e32:	48 c7 c2 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rdx
ffff800000106e39:	64 48 8b 12          	mov    %fs:(%rdx),%rdx
ffff800000106e3d:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106e41:	48 89 c6             	mov    %rax,%rsi
ffff800000106e44:	48 89 d7             	mov    %rdx,%rdi
ffff800000106e47:	48 b8 f4 80 10 00 00 	movabs $0xffff8000001080f4,%rax
ffff800000106e4e:	80 ff ff 
ffff800000106e51:	ff d0                	call   *%rax
      switchkvm();
ffff800000106e53:	48 b8 99 b8 10 00 00 	movabs $0xffff80000010b899,%rax
ffff800000106e5a:	80 ff ff 
ffff800000106e5d:	ff d0                	call   *%rax

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
ffff800000106e5f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106e66:	64 48 c7 00 00 00 00 	movq   $0x0,%fs:(%rax)
ffff800000106e6d:	00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106e6e:	48 81 45 f0 c0 01 00 	addq   $0x1c0,-0x10(%rbp)
ffff800000106e75:	00 
ffff800000106e76:	48 b8 a8 e4 11 00 00 	movabs $0xffff80000011e4a8,%rax
ffff800000106e7d:	80 ff ff 
ffff800000106e80:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff800000106e84:	0f 82 5a ff ff ff    	jb     ffff800000106de4 <scheduler+0x56>
    }
    release(&ptable.lock);
ffff800000106e8a:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106e91:	80 ff ff 
ffff800000106e94:	48 89 c7             	mov    %rax,%rdi
ffff800000106e97:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff800000106e9e:	80 ff ff 
ffff800000106ea1:	ff d0                	call   *%rax
    if (skipped > NPROC) {
ffff800000106ea3:	83 7d ec 40          	cmpl   $0x40,-0x14(%rbp)
ffff800000106ea7:	0f 8e fb fe ff ff    	jle    ffff800000106da8 <scheduler+0x1a>
      hlt();
ffff800000106ead:	48 b8 3f 63 10 00 00 	movabs $0xffff80000010633f,%rax
ffff800000106eb4:	80 ff ff 
ffff800000106eb7:	ff d0                	call   *%rax
      skipped = 0;
ffff800000106eb9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    ++i;
ffff800000106ec0:	e9 e3 fe ff ff       	jmp    ffff800000106da8 <scheduler+0x1a>

ffff800000106ec5 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
ffff800000106ec5:	f3 0f 1e fa          	endbr64
ffff800000106ec9:	55                   	push   %rbp
ffff800000106eca:	48 89 e5             	mov    %rsp,%rbp
ffff800000106ecd:	48 83 ec 10          	sub    $0x10,%rsp
  int intena;


  if(!holding(&ptable.lock))
ffff800000106ed1:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106ed8:	80 ff ff 
ffff800000106edb:	48 89 c7             	mov    %rax,%rdi
ffff800000106ede:	48 b8 c3 7b 10 00 00 	movabs $0xffff800000107bc3,%rax
ffff800000106ee5:	80 ff ff 
ffff800000106ee8:	ff d0                	call   *%rax
ffff800000106eea:	85 c0                	test   %eax,%eax
ffff800000106eec:	75 19                	jne    ffff800000106f07 <sched+0x42>
    panic("sched ptable.lock");
ffff800000106eee:	48 b8 c7 c7 10 00 00 	movabs $0xffff80000010c7c7,%rax
ffff800000106ef5:	80 ff ff 
ffff800000106ef8:	48 89 c7             	mov    %rax,%rdi
ffff800000106efb:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000106f02:	80 ff ff 
ffff800000106f05:	ff d0                	call   *%rax
  if(cpu->ncli != 1)
ffff800000106f07:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000106f0e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106f12:	8b 40 14             	mov    0x14(%rax),%eax
ffff800000106f15:	83 f8 01             	cmp    $0x1,%eax
ffff800000106f18:	74 19                	je     ffff800000106f33 <sched+0x6e>
    panic("sched locks");
ffff800000106f1a:	48 b8 d9 c7 10 00 00 	movabs $0xffff80000010c7d9,%rax
ffff800000106f21:	80 ff ff 
ffff800000106f24:	48 89 c7             	mov    %rax,%rdi
ffff800000106f27:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000106f2e:	80 ff ff 
ffff800000106f31:	ff d0                	call   *%rax
  if(proc->state == RUNNING)
ffff800000106f33:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106f3a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106f3e:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106f41:	83 f8 04             	cmp    $0x4,%eax
ffff800000106f44:	75 19                	jne    ffff800000106f5f <sched+0x9a>
    panic("sched running");
ffff800000106f46:	48 b8 e5 c7 10 00 00 	movabs $0xffff80000010c7e5,%rax
ffff800000106f4d:	80 ff ff 
ffff800000106f50:	48 89 c7             	mov    %rax,%rdi
ffff800000106f53:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000106f5a:	80 ff ff 
ffff800000106f5d:	ff d0                	call   *%rax
  if(readeflags()&FL_IF)
ffff800000106f5f:	48 b8 1b 63 10 00 00 	movabs $0xffff80000010631b,%rax
ffff800000106f66:	80 ff ff 
ffff800000106f69:	ff d0                	call   *%rax
ffff800000106f6b:	25 00 02 00 00       	and    $0x200,%eax
ffff800000106f70:	48 85 c0             	test   %rax,%rax
ffff800000106f73:	74 19                	je     ffff800000106f8e <sched+0xc9>
    panic("sched interruptible");
ffff800000106f75:	48 b8 f3 c7 10 00 00 	movabs $0xffff80000010c7f3,%rax
ffff800000106f7c:	80 ff ff 
ffff800000106f7f:	48 89 c7             	mov    %rax,%rdi
ffff800000106f82:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000106f89:	80 ff ff 
ffff800000106f8c:	ff d0                	call   *%rax
  intena = cpu->intena;
ffff800000106f8e:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000106f95:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106f99:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106f9c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  swtch(&proc->context, cpu->scheduler);
ffff800000106f9f:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000106fa6:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106faa:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000106fae:	48 c7 c2 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rdx
ffff800000106fb5:	64 48 8b 12          	mov    %fs:(%rdx),%rdx
ffff800000106fb9:	48 83 c2 30          	add    $0x30,%rdx
ffff800000106fbd:	48 89 c6             	mov    %rax,%rsi
ffff800000106fc0:	48 89 d7             	mov    %rdx,%rdi
ffff800000106fc3:	48 b8 f4 80 10 00 00 	movabs $0xffff8000001080f4,%rax
ffff800000106fca:	80 ff ff 
ffff800000106fcd:	ff d0                	call   *%rax
  cpu->intena = intena;
ffff800000106fcf:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000106fd6:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106fda:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000106fdd:	89 50 18             	mov    %edx,0x18(%rax)
}
ffff800000106fe0:	90                   	nop
ffff800000106fe1:	c9                   	leave
ffff800000106fe2:	c3                   	ret

ffff800000106fe3 <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
ffff800000106fe3:	f3 0f 1e fa          	endbr64
ffff800000106fe7:	55                   	push   %rbp
ffff800000106fe8:	48 89 e5             	mov    %rsp,%rbp
  acquire(&ptable.lock);  //DOC: yieldlock
ffff800000106feb:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106ff2:	80 ff ff 
ffff800000106ff5:	48 89 c7             	mov    %rax,%rdi
ffff800000106ff8:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff800000106fff:	80 ff ff 
ffff800000107002:	ff d0                	call   *%rax
  proc->state = RUNNABLE;
ffff800000107004:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010700b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010700f:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
  sched();
ffff800000107016:	48 b8 c5 6e 10 00 00 	movabs $0xffff800000106ec5,%rax
ffff80000010701d:	80 ff ff 
ffff800000107020:	ff d0                	call   *%rax
  release(&ptable.lock);
ffff800000107022:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000107029:	80 ff ff 
ffff80000010702c:	48 89 c7             	mov    %rax,%rdi
ffff80000010702f:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff800000107036:	80 ff ff 
ffff800000107039:	ff d0                	call   *%rax
}
ffff80000010703b:	90                   	nop
ffff80000010703c:	5d                   	pop    %rbp
ffff80000010703d:	c3                   	ret

ffff80000010703e <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
ffff80000010703e:	f3 0f 1e fa          	endbr64
ffff800000107042:	55                   	push   %rbp
ffff800000107043:	48 89 e5             	mov    %rsp,%rbp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
ffff800000107046:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff80000010704d:	80 ff ff 
ffff800000107050:	48 89 c7             	mov    %rax,%rdi
ffff800000107053:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff80000010705a:	80 ff ff 
ffff80000010705d:	ff d0                	call   *%rax

  if (first) {
ffff80000010705f:	48 b8 44 d5 10 00 00 	movabs $0xffff80000010d544,%rax
ffff800000107066:	80 ff ff 
ffff800000107069:	8b 00                	mov    (%rax),%eax
ffff80000010706b:	85 c0                	test   %eax,%eax
ffff80000010706d:	74 32                	je     ffff8000001070a1 <forkret+0x63>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
ffff80000010706f:	48 b8 44 d5 10 00 00 	movabs $0xffff80000010d544,%rax
ffff800000107076:	80 ff ff 
ffff800000107079:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    iinit(ROOTDEV);
ffff80000010707f:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000107084:	48 b8 cb 24 10 00 00 	movabs $0xffff8000001024cb,%rax
ffff80000010708b:	80 ff ff 
ffff80000010708e:	ff d0                	call   *%rax
    initlog(ROOTDEV);
ffff800000107090:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000107095:	48 b8 0f 4d 10 00 00 	movabs $0xffff800000104d0f,%rax
ffff80000010709c:	80 ff ff 
ffff80000010709f:	ff d0                	call   *%rax
  }

  // Return to "caller", actually trapret (see allocproc).
}
ffff8000001070a1:	90                   	nop
ffff8000001070a2:	5d                   	pop    %rbp
ffff8000001070a3:	c3                   	ret

ffff8000001070a4 <sleep>:
//PAGEBREAK!
// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
ffff8000001070a4:	f3 0f 1e fa          	endbr64
ffff8000001070a8:	55                   	push   %rbp
ffff8000001070a9:	48 89 e5             	mov    %rsp,%rbp
ffff8000001070ac:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001070b0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff8000001070b4:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(proc == 0)
ffff8000001070b8:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001070bf:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001070c3:	48 85 c0             	test   %rax,%rax
ffff8000001070c6:	75 19                	jne    ffff8000001070e1 <sleep+0x3d>
    panic("sleep");
ffff8000001070c8:	48 b8 07 c8 10 00 00 	movabs $0xffff80000010c807,%rax
ffff8000001070cf:	80 ff ff 
ffff8000001070d2:	48 89 c7             	mov    %rax,%rdi
ffff8000001070d5:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff8000001070dc:	80 ff ff 
ffff8000001070df:	ff d0                	call   *%rax

  if(lk == 0)
ffff8000001070e1:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff8000001070e6:	75 19                	jne    ffff800000107101 <sleep+0x5d>
    panic("sleep without lk");
ffff8000001070e8:	48 b8 0d c8 10 00 00 	movabs $0xffff80000010c80d,%rax
ffff8000001070ef:	80 ff ff 
ffff8000001070f2:	48 89 c7             	mov    %rax,%rdi
ffff8000001070f5:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff8000001070fc:	80 ff ff 
ffff8000001070ff:	ff d0                	call   *%rax
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
ffff800000107101:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000107108:	80 ff ff 
ffff80000010710b:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff80000010710f:	74 2c                	je     ffff80000010713d <sleep+0x99>
    acquire(&ptable.lock);  //DOC: sleeplock1
ffff800000107111:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000107118:	80 ff ff 
ffff80000010711b:	48 89 c7             	mov    %rax,%rdi
ffff80000010711e:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff800000107125:	80 ff ff 
ffff800000107128:	ff d0                	call   *%rax
    release(lk);
ffff80000010712a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010712e:	48 89 c7             	mov    %rax,%rdi
ffff800000107131:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff800000107138:	80 ff ff 
ffff80000010713b:	ff d0                	call   *%rax
  }

  // Go to sleep.
  proc->chan = chan;
ffff80000010713d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107144:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107148:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010714c:	48 89 50 38          	mov    %rdx,0x38(%rax)
  proc->state = SLEEPING;
ffff800000107150:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107157:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010715b:	c7 40 18 02 00 00 00 	movl   $0x2,0x18(%rax)
  sched();
ffff800000107162:	48 b8 c5 6e 10 00 00 	movabs $0xffff800000106ec5,%rax
ffff800000107169:	80 ff ff 
ffff80000010716c:	ff d0                	call   *%rax

  // Tidy up.
  proc->chan = 0;
ffff80000010716e:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107175:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107179:	48 c7 40 38 00 00 00 	movq   $0x0,0x38(%rax)
ffff800000107180:	00 

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
ffff800000107181:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000107188:	80 ff ff 
ffff80000010718b:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff80000010718f:	74 2c                	je     ffff8000001071bd <sleep+0x119>
    release(&ptable.lock);
ffff800000107191:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000107198:	80 ff ff 
ffff80000010719b:	48 89 c7             	mov    %rax,%rdi
ffff80000010719e:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff8000001071a5:	80 ff ff 
ffff8000001071a8:	ff d0                	call   *%rax
    acquire(lk);
ffff8000001071aa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001071ae:	48 89 c7             	mov    %rax,%rdi
ffff8000001071b1:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff8000001071b8:	80 ff ff 
ffff8000001071bb:	ff d0                	call   *%rax
  }
}
ffff8000001071bd:	90                   	nop
ffff8000001071be:	c9                   	leave
ffff8000001071bf:	c3                   	ret

ffff8000001071c0 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
ffff8000001071c0:	f3 0f 1e fa          	endbr64
ffff8000001071c4:	55                   	push   %rbp
ffff8000001071c5:	48 89 e5             	mov    %rsp,%rbp
ffff8000001071c8:	48 83 ec 18          	sub    $0x18,%rsp
ffff8000001071cc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffff8000001071d0:	48 b8 a8 74 11 00 00 	movabs $0xffff8000001174a8,%rax
ffff8000001071d7:	80 ff ff 
ffff8000001071da:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001071de:	eb 2d                	jmp    ffff80000010720d <wakeup1+0x4d>
    if(p->state == SLEEPING && p->chan == chan)
ffff8000001071e0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001071e4:	8b 40 18             	mov    0x18(%rax),%eax
ffff8000001071e7:	83 f8 02             	cmp    $0x2,%eax
ffff8000001071ea:	75 19                	jne    ffff800000107205 <wakeup1+0x45>
ffff8000001071ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001071f0:	48 8b 40 38          	mov    0x38(%rax),%rax
ffff8000001071f4:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffff8000001071f8:	75 0b                	jne    ffff800000107205 <wakeup1+0x45>
      p->state = RUNNABLE;
ffff8000001071fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001071fe:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffff800000107205:	48 81 45 f8 c0 01 00 	addq   $0x1c0,-0x8(%rbp)
ffff80000010720c:	00 
ffff80000010720d:	48 b8 a8 e4 11 00 00 	movabs $0xffff80000011e4a8,%rax
ffff800000107214:	80 ff ff 
ffff800000107217:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff80000010721b:	72 c3                	jb     ffff8000001071e0 <wakeup1+0x20>
}
ffff80000010721d:	90                   	nop
ffff80000010721e:	90                   	nop
ffff80000010721f:	c9                   	leave
ffff800000107220:	c3                   	ret

ffff800000107221 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
ffff800000107221:	f3 0f 1e fa          	endbr64
ffff800000107225:	55                   	push   %rbp
ffff800000107226:	48 89 e5             	mov    %rsp,%rbp
ffff800000107229:	48 83 ec 10          	sub    $0x10,%rsp
ffff80000010722d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&ptable.lock);
ffff800000107231:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000107238:	80 ff ff 
ffff80000010723b:	48 89 c7             	mov    %rax,%rdi
ffff80000010723e:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff800000107245:	80 ff ff 
ffff800000107248:	ff d0                	call   *%rax
  wakeup1(chan);
ffff80000010724a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010724e:	48 89 c7             	mov    %rax,%rdi
ffff800000107251:	48 b8 c0 71 10 00 00 	movabs $0xffff8000001071c0,%rax
ffff800000107258:	80 ff ff 
ffff80000010725b:	ff d0                	call   *%rax
  release(&ptable.lock);
ffff80000010725d:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000107264:	80 ff ff 
ffff800000107267:	48 89 c7             	mov    %rax,%rdi
ffff80000010726a:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff800000107271:	80 ff ff 
ffff800000107274:	ff d0                	call   *%rax
}
ffff800000107276:	90                   	nop
ffff800000107277:	c9                   	leave
ffff800000107278:	c3                   	ret

ffff800000107279 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
ffff800000107279:	f3 0f 1e fa          	endbr64
ffff80000010727d:	55                   	push   %rbp
ffff80000010727e:	48 89 e5             	mov    %rsp,%rbp
ffff800000107281:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000107285:	89 7d ec             	mov    %edi,-0x14(%rbp)
  struct proc *p;

  acquire(&ptable.lock);
ffff800000107288:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff80000010728f:	80 ff ff 
ffff800000107292:	48 89 c7             	mov    %rax,%rdi
ffff800000107295:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff80000010729c:	80 ff ff 
ffff80000010729f:	ff d0                	call   *%rax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff8000001072a1:	48 b8 a8 74 11 00 00 	movabs $0xffff8000001174a8,%rax
ffff8000001072a8:	80 ff ff 
ffff8000001072ab:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001072af:	eb 56                	jmp    ffff800000107307 <kill+0x8e>
    if(p->pid == pid){
ffff8000001072b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001072b5:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff8000001072b8:	39 45 ec             	cmp    %eax,-0x14(%rbp)
ffff8000001072bb:	75 42                	jne    ffff8000001072ff <kill+0x86>
      p->killed = 1;
ffff8000001072bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001072c1:	c7 40 40 01 00 00 00 	movl   $0x1,0x40(%rax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
ffff8000001072c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001072cc:	8b 40 18             	mov    0x18(%rax),%eax
ffff8000001072cf:	83 f8 02             	cmp    $0x2,%eax
ffff8000001072d2:	75 0b                	jne    ffff8000001072df <kill+0x66>
        p->state = RUNNABLE;
ffff8000001072d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001072d8:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
      release(&ptable.lock);
ffff8000001072df:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff8000001072e6:	80 ff ff 
ffff8000001072e9:	48 89 c7             	mov    %rax,%rdi
ffff8000001072ec:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff8000001072f3:	80 ff ff 
ffff8000001072f6:	ff d0                	call   *%rax
      return 0;
ffff8000001072f8:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001072fd:	eb 36                	jmp    ffff800000107335 <kill+0xbc>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff8000001072ff:	48 81 45 f8 c0 01 00 	addq   $0x1c0,-0x8(%rbp)
ffff800000107306:	00 
ffff800000107307:	48 b8 a8 e4 11 00 00 	movabs $0xffff80000011e4a8,%rax
ffff80000010730e:	80 ff ff 
ffff800000107311:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000107315:	72 9a                	jb     ffff8000001072b1 <kill+0x38>
    }
  }
  release(&ptable.lock);
ffff800000107317:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff80000010731e:	80 ff ff 
ffff800000107321:	48 89 c7             	mov    %rax,%rdi
ffff800000107324:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff80000010732b:	80 ff ff 
ffff80000010732e:	ff d0                	call   *%rax
  return -1;
ffff800000107330:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000107335:	c9                   	leave
ffff800000107336:	c3                   	ret

ffff800000107337 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
ffff800000107337:	f3 0f 1e fa          	endbr64
ffff80000010733b:	55                   	push   %rbp
ffff80000010733c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010733f:	48 83 ec 70          	sub    $0x70,%rsp
  int i;
  struct proc *p;
  char *state;
  addr_t pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000107343:	48 b8 a8 74 11 00 00 	movabs $0xffff8000001174a8,%rax
ffff80000010734a:	80 ff ff 
ffff80000010734d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000107351:	e9 44 01 00 00       	jmp    ffff80000010749a <procdump+0x163>
    if(p->state == UNUSED)
ffff800000107356:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010735a:	8b 40 18             	mov    0x18(%rax),%eax
ffff80000010735d:	85 c0                	test   %eax,%eax
ffff80000010735f:	0f 84 2c 01 00 00    	je     ffff800000107491 <procdump+0x15a>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
ffff800000107365:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107369:	8b 40 18             	mov    0x18(%rax),%eax
ffff80000010736c:	83 f8 05             	cmp    $0x5,%eax
ffff80000010736f:	77 39                	ja     ffff8000001073aa <procdump+0x73>
ffff800000107371:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107375:	8b 50 18             	mov    0x18(%rax),%edx
ffff800000107378:	48 b8 60 d5 10 00 00 	movabs $0xffff80000010d560,%rax
ffff80000010737f:	80 ff ff 
ffff800000107382:	89 d2                	mov    %edx,%edx
ffff800000107384:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
ffff800000107388:	48 85 c0             	test   %rax,%rax
ffff80000010738b:	74 1d                	je     ffff8000001073aa <procdump+0x73>
      state = states[p->state];
ffff80000010738d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107391:	8b 50 18             	mov    0x18(%rax),%edx
ffff800000107394:	48 b8 60 d5 10 00 00 	movabs $0xffff80000010d560,%rax
ffff80000010739b:	80 ff ff 
ffff80000010739e:	89 d2                	mov    %edx,%edx
ffff8000001073a0:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
ffff8000001073a4:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff8000001073a8:	eb 0e                	jmp    ffff8000001073b8 <procdump+0x81>
    else
      state = "???";
ffff8000001073aa:	48 b8 1e c8 10 00 00 	movabs $0xffff80000010c81e,%rax
ffff8000001073b1:	80 ff ff 
ffff8000001073b4:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    cprintf("%d %s %s", p->pid, state, p->name);
ffff8000001073b8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001073bc:	48 8d 88 d0 00 00 00 	lea    0xd0(%rax),%rcx
ffff8000001073c3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001073c7:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff8000001073ca:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff8000001073ce:	89 c6                	mov    %eax,%esi
ffff8000001073d0:	48 b8 22 c8 10 00 00 	movabs $0xffff80000010c822,%rax
ffff8000001073d7:	80 ff ff 
ffff8000001073da:	48 89 c7             	mov    %rax,%rdi
ffff8000001073dd:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001073e2:	49 b8 38 08 10 00 00 	movabs $0xffff800000100838,%r8
ffff8000001073e9:	80 ff ff 
ffff8000001073ec:	41 ff d0             	call   *%r8
    if(p->state == SLEEPING){
ffff8000001073ef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001073f3:	8b 40 18             	mov    0x18(%rax),%eax
ffff8000001073f6:	83 f8 02             	cmp    $0x2,%eax
ffff8000001073f9:	75 76                	jne    ffff800000107471 <procdump+0x13a>
      getstackpcs((addr_t*)p->context->rbp+2, pc);
ffff8000001073fb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001073ff:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff800000107403:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000107407:	48 83 c0 10          	add    $0x10,%rax
ffff80000010740b:	48 89 c2             	mov    %rax,%rdx
ffff80000010740e:	48 8d 45 90          	lea    -0x70(%rbp),%rax
ffff800000107412:	48 89 c6             	mov    %rax,%rsi
ffff800000107415:	48 89 d7             	mov    %rdx,%rdi
ffff800000107418:	48 b8 25 7b 10 00 00 	movabs $0xffff800000107b25,%rax
ffff80000010741f:	80 ff ff 
ffff800000107422:	ff d0                	call   *%rax
      for(i=0; i<10 && pc[i] != 0; i++)
ffff800000107424:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010742b:	eb 2f                	jmp    ffff80000010745c <procdump+0x125>
        cprintf(" %p", pc[i]);
ffff80000010742d:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000107430:	48 98                	cltq
ffff800000107432:	48 8b 44 c5 90       	mov    -0x70(%rbp,%rax,8),%rax
ffff800000107437:	48 89 c6             	mov    %rax,%rsi
ffff80000010743a:	48 b8 2b c8 10 00 00 	movabs $0xffff80000010c82b,%rax
ffff800000107441:	80 ff ff 
ffff800000107444:	48 89 c7             	mov    %rax,%rdi
ffff800000107447:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010744c:	48 ba 38 08 10 00 00 	movabs $0xffff800000100838,%rdx
ffff800000107453:	80 ff ff 
ffff800000107456:	ff d2                	call   *%rdx
      for(i=0; i<10 && pc[i] != 0; i++)
ffff800000107458:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff80000010745c:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffff800000107460:	7f 0f                	jg     ffff800000107471 <procdump+0x13a>
ffff800000107462:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000107465:	48 98                	cltq
ffff800000107467:	48 8b 44 c5 90       	mov    -0x70(%rbp,%rax,8),%rax
ffff80000010746c:	48 85 c0             	test   %rax,%rax
ffff80000010746f:	75 bc                	jne    ffff80000010742d <procdump+0xf6>
    }
    cprintf("\n");
ffff800000107471:	48 b8 2f c8 10 00 00 	movabs $0xffff80000010c82f,%rax
ffff800000107478:	80 ff ff 
ffff80000010747b:	48 89 c7             	mov    %rax,%rdi
ffff80000010747e:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000107483:	48 ba 38 08 10 00 00 	movabs $0xffff800000100838,%rdx
ffff80000010748a:	80 ff ff 
ffff80000010748d:	ff d2                	call   *%rdx
ffff80000010748f:	eb 01                	jmp    ffff800000107492 <procdump+0x15b>
      continue;
ffff800000107491:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000107492:	48 81 45 f0 c0 01 00 	addq   $0x1c0,-0x10(%rbp)
ffff800000107499:	00 
ffff80000010749a:	48 b8 a8 e4 11 00 00 	movabs $0xffff80000011e4a8,%rax
ffff8000001074a1:	80 ff ff 
ffff8000001074a4:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff8000001074a8:	0f 82 a8 fe ff ff    	jb     ffff800000107356 <procdump+0x1f>
  }
}
ffff8000001074ae:	90                   	nop
ffff8000001074af:	90                   	nop
ffff8000001074b0:	c9                   	leave
ffff8000001074b1:	c3                   	ret

ffff8000001074b2 <send>:

int send(int pid, void* msg) {
ffff8000001074b2:	f3 0f 1e fa          	endbr64
ffff8000001074b6:	55                   	push   %rbp
ffff8000001074b7:	48 89 e5             	mov    %rsp,%rbp
ffff8000001074ba:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
ffff8000001074c1:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
ffff8000001074c7:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
	struct proc *target_p;
	struct ipc_msg kmsg;

	if (copyin(proc->pgdir, (void*)&kmsg, (addr_t)msg, sizeof(struct ipc_msg)) < 0) {
ffff8000001074ce:	48 8b 95 10 ff ff ff 	mov    -0xf0(%rbp),%rdx
ffff8000001074d5:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001074dc:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001074e0:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff8000001074e4:	48 8d b5 20 ff ff ff 	lea    -0xe0(%rbp),%rsi
ffff8000001074eb:	b9 d8 00 00 00       	mov    $0xd8,%ecx
ffff8000001074f0:	48 89 c7             	mov    %rax,%rdi
ffff8000001074f3:	48 b8 7f c3 10 00 00 	movabs $0xffff80000010c37f,%rax
ffff8000001074fa:	80 ff ff 
ffff8000001074fd:	ff d0                	call   *%rax
ffff8000001074ff:	85 c0                	test   %eax,%eax
ffff800000107501:	79 0a                	jns    ffff80000010750d <send+0x5b>
		return -1;
ffff800000107503:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000107508:	e9 5c 01 00 00       	jmp    ffff800000107669 <send+0x1b7>
	}

	kmsg.sender_pid = proc->pid;
ffff80000010750d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107514:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107518:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff80000010751b:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%rbp)

	acquire(&ptable.lock);
ffff800000107521:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000107528:	80 ff ff 
ffff80000010752b:	48 89 c7             	mov    %rax,%rdi
ffff80000010752e:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff800000107535:	80 ff ff 
ffff800000107538:	ff d0                	call   *%rax
	for (target_p = ptable.proc; target_p < &ptable.proc[NPROC]; target_p++) {
ffff80000010753a:	48 b8 a8 74 11 00 00 	movabs $0xffff8000001174a8,%rax
ffff800000107541:	80 ff ff 
ffff800000107544:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000107548:	eb 17                	jmp    ffff800000107561 <send+0xaf>
		if (target_p->pid == pid) {
ffff80000010754a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010754e:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff800000107551:	39 85 1c ff ff ff    	cmp    %eax,-0xe4(%rbp)
ffff800000107557:	74 3b                	je     ffff800000107594 <send+0xe2>
	for (target_p = ptable.proc; target_p < &ptable.proc[NPROC]; target_p++) {
ffff800000107559:	48 81 45 f8 c0 01 00 	addq   $0x1c0,-0x8(%rbp)
ffff800000107560:	00 
ffff800000107561:	48 b8 a8 e4 11 00 00 	movabs $0xffff80000011e4a8,%rax
ffff800000107568:	80 ff ff 
ffff80000010756b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff80000010756f:	72 d9                	jb     ffff80000010754a <send+0x98>
			goto found;
		}
	}
	release(&ptable.lock);
ffff800000107571:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000107578:	80 ff ff 
ffff80000010757b:	48 89 c7             	mov    %rax,%rdi
ffff80000010757e:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff800000107585:	80 ff ff 
ffff800000107588:	ff d0                	call   *%rax

	return -1;
ffff80000010758a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010758f:	e9 d5 00 00 00       	jmp    ffff800000107669 <send+0x1b7>
			goto found;
ffff800000107594:	90                   	nop

found:
	while(target_p->has_msg == 1){
ffff800000107595:	eb 5b                	jmp    ffff8000001075f2 <send+0x140>
		if(proc->killed){
ffff800000107597:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010759e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001075a2:	8b 40 40             	mov    0x40(%rax),%eax
ffff8000001075a5:	85 c0                	test   %eax,%eax
ffff8000001075a7:	74 23                	je     ffff8000001075cc <send+0x11a>
			release(&ptable.lock);
ffff8000001075a9:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff8000001075b0:	80 ff ff 
ffff8000001075b3:	48 89 c7             	mov    %rax,%rdi
ffff8000001075b6:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff8000001075bd:	80 ff ff 
ffff8000001075c0:	ff d0                	call   *%rax
			return -1;
ffff8000001075c2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001075c7:	e9 9d 00 00 00       	jmp    ffff800000107669 <send+0x1b7>
		}
		sleep(&target_p->has_msg, &ptable.lock); 
ffff8000001075cc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001075d0:	48 05 b8 01 00 00    	add    $0x1b8,%rax
ffff8000001075d6:	48 ba 40 74 11 00 00 	movabs $0xffff800000117440,%rdx
ffff8000001075dd:	80 ff ff 
ffff8000001075e0:	48 89 d6             	mov    %rdx,%rsi
ffff8000001075e3:	48 89 c7             	mov    %rax,%rdi
ffff8000001075e6:	48 b8 a4 70 10 00 00 	movabs $0xffff8000001070a4,%rax
ffff8000001075ed:	80 ff ff 
ffff8000001075f0:	ff d0                	call   *%rax
	while(target_p->has_msg == 1){
ffff8000001075f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001075f6:	8b 80 b8 01 00 00    	mov    0x1b8(%rax),%eax
ffff8000001075fc:	83 f8 01             	cmp    $0x1,%eax
ffff8000001075ff:	74 96                	je     ffff800000107597 <send+0xe5>
	}

	memmove(&target_p->mailbox, &kmsg, sizeof(struct ipc_msg));
ffff800000107601:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107605:	48 8d 88 e0 00 00 00 	lea    0xe0(%rax),%rcx
ffff80000010760c:	48 8d 85 20 ff ff ff 	lea    -0xe0(%rbp),%rax
ffff800000107613:	ba d8 00 00 00       	mov    $0xd8,%edx
ffff800000107618:	48 89 c6             	mov    %rax,%rsi
ffff80000010761b:	48 89 cf             	mov    %rcx,%rdi
ffff80000010761e:	48 b8 94 7e 10 00 00 	movabs $0xffff800000107e94,%rax
ffff800000107625:	80 ff ff 
ffff800000107628:	ff d0                	call   *%rax
	target_p->has_msg = 1;
ffff80000010762a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010762e:	c7 80 b8 01 00 00 01 	movl   $0x1,0x1b8(%rax)
ffff800000107635:	00 00 00 

	wakeup1(target_p); 
ffff800000107638:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010763c:	48 89 c7             	mov    %rax,%rdi
ffff80000010763f:	48 b8 c0 71 10 00 00 	movabs $0xffff8000001071c0,%rax
ffff800000107646:	80 ff ff 
ffff800000107649:	ff d0                	call   *%rax
	release(&ptable.lock);
ffff80000010764b:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000107652:	80 ff ff 
ffff800000107655:	48 89 c7             	mov    %rax,%rdi
ffff800000107658:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff80000010765f:	80 ff ff 
ffff800000107662:	ff d0                	call   *%rax

	return 0;
ffff800000107664:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000107669:	c9                   	leave
ffff80000010766a:	c3                   	ret

ffff80000010766b <recv>:

int recv(void *msg) {
ffff80000010766b:	f3 0f 1e fa          	endbr64
ffff80000010766f:	55                   	push   %rbp
ffff800000107670:	48 89 e5             	mov    %rsp,%rbp
ffff800000107673:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107677:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
	acquire(&ptable.lock);
ffff80000010767b:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000107682:	80 ff ff 
ffff800000107685:	48 89 c7             	mov    %rax,%rdi
ffff800000107688:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff80000010768f:	80 ff ff 
ffff800000107692:	ff d0                	call   *%rax

	while(proc->has_msg == 0){
ffff800000107694:	eb 5c                	jmp    ffff8000001076f2 <recv+0x87>
		if(proc->killed){
ffff800000107696:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010769d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001076a1:	8b 40 40             	mov    0x40(%rax),%eax
ffff8000001076a4:	85 c0                	test   %eax,%eax
ffff8000001076a6:	74 23                	je     ffff8000001076cb <recv+0x60>
			release(&ptable.lock);
ffff8000001076a8:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff8000001076af:	80 ff ff 
ffff8000001076b2:	48 89 c7             	mov    %rax,%rdi
ffff8000001076b5:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff8000001076bc:	80 ff ff 
ffff8000001076bf:	ff d0                	call   *%rax
			return -1;
ffff8000001076c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001076c6:	e9 d3 00 00 00       	jmp    ffff80000010779e <recv+0x133>
		}
		sleep(proc, &ptable.lock);
ffff8000001076cb:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001076d2:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001076d6:	48 ba 40 74 11 00 00 	movabs $0xffff800000117440,%rdx
ffff8000001076dd:	80 ff ff 
ffff8000001076e0:	48 89 d6             	mov    %rdx,%rsi
ffff8000001076e3:	48 89 c7             	mov    %rax,%rdi
ffff8000001076e6:	48 b8 a4 70 10 00 00 	movabs $0xffff8000001070a4,%rax
ffff8000001076ed:	80 ff ff 
ffff8000001076f0:	ff d0                	call   *%rax
	while(proc->has_msg == 0){
ffff8000001076f2:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001076f9:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001076fd:	8b 80 b8 01 00 00    	mov    0x1b8(%rax),%eax
ffff800000107703:	85 c0                	test   %eax,%eax
ffff800000107705:	74 8f                	je     ffff800000107696 <recv+0x2b>
	}


	proc->has_msg = 0;
ffff800000107707:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010770e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107712:	c7 80 b8 01 00 00 00 	movl   $0x0,0x1b8(%rax)
ffff800000107719:	00 00 00 
	wakeup1(&proc->has_msg);
ffff80000010771c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107723:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107727:	48 05 b8 01 00 00    	add    $0x1b8,%rax
ffff80000010772d:	48 89 c7             	mov    %rax,%rdi
ffff800000107730:	48 b8 c0 71 10 00 00 	movabs $0xffff8000001071c0,%rax
ffff800000107737:	80 ff ff 
ffff80000010773a:	ff d0                	call   *%rax
	release(&ptable.lock);
ffff80000010773c:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000107743:	80 ff ff 
ffff800000107746:	48 89 c7             	mov    %rax,%rdi
ffff800000107749:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff800000107750:	80 ff ff 
ffff800000107753:	ff d0                	call   *%rax

	if(copyout(proc->pgdir, (addr_t)msg, (char*)&proc->mailbox, sizeof(struct ipc_msg)) < 0)
ffff800000107755:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010775c:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107760:	48 8d 90 e0 00 00 00 	lea    0xe0(%rax),%rdx
ffff800000107767:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
ffff80000010776b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107772:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107776:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010777a:	b9 d8 00 00 00       	mov    $0xd8,%ecx
ffff80000010777f:	48 89 c7             	mov    %rax,%rdi
ffff800000107782:	48 b8 94 c2 10 00 00 	movabs $0xffff80000010c294,%rax
ffff800000107789:	80 ff ff 
ffff80000010778c:	ff d0                	call   *%rax
ffff80000010778e:	85 c0                	test   %eax,%eax
ffff800000107790:	79 07                	jns    ffff800000107799 <recv+0x12e>
		return -1;
ffff800000107792:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000107797:	eb 05                	jmp    ffff80000010779e <recv+0x133>

	return 0;
ffff800000107799:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010779e:	c9                   	leave
ffff80000010779f:	c3                   	ret

ffff8000001077a0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
ffff8000001077a0:	f3 0f 1e fa          	endbr64
ffff8000001077a4:	55                   	push   %rbp
ffff8000001077a5:	48 89 e5             	mov    %rsp,%rbp
ffff8000001077a8:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001077ac:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff8000001077b0:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  initlock(&lk->lk, "sleep lock");
ffff8000001077b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001077b8:	48 83 c0 08          	add    $0x8,%rax
ffff8000001077bc:	48 ba 5b c8 10 00 00 	movabs $0xffff80000010c85b,%rdx
ffff8000001077c3:	80 ff ff 
ffff8000001077c6:	48 89 d6             	mov    %rdx,%rsi
ffff8000001077c9:	48 89 c7             	mov    %rax,%rdi
ffff8000001077cc:	48 b8 96 79 10 00 00 	movabs $0xffff800000107996,%rax
ffff8000001077d3:	80 ff ff 
ffff8000001077d6:	ff d0                	call   *%rax
  lk->name = name;
ffff8000001077d8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001077dc:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff8000001077e0:	48 89 50 70          	mov    %rdx,0x70(%rax)
  lk->locked = 0;
ffff8000001077e4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001077e8:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  lk->pid = 0;
ffff8000001077ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001077f2:	c7 40 78 00 00 00 00 	movl   $0x0,0x78(%rax)
}
ffff8000001077f9:	90                   	nop
ffff8000001077fa:	c9                   	leave
ffff8000001077fb:	c3                   	ret

ffff8000001077fc <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
ffff8000001077fc:	f3 0f 1e fa          	endbr64
ffff800000107800:	55                   	push   %rbp
ffff800000107801:	48 89 e5             	mov    %rsp,%rbp
ffff800000107804:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107808:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&lk->lk);
ffff80000010780c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107810:	48 83 c0 08          	add    $0x8,%rax
ffff800000107814:	48 89 c7             	mov    %rax,%rdi
ffff800000107817:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff80000010781e:	80 ff ff 
ffff800000107821:	ff d0                	call   *%rax
  while (lk->locked)
ffff800000107823:	eb 1e                	jmp    ffff800000107843 <acquiresleep+0x47>
    sleep(lk, &lk->lk);
ffff800000107825:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107829:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffff80000010782d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107831:	48 89 d6             	mov    %rdx,%rsi
ffff800000107834:	48 89 c7             	mov    %rax,%rdi
ffff800000107837:	48 b8 a4 70 10 00 00 	movabs $0xffff8000001070a4,%rax
ffff80000010783e:	80 ff ff 
ffff800000107841:	ff d0                	call   *%rax
  while (lk->locked)
ffff800000107843:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107847:	8b 00                	mov    (%rax),%eax
ffff800000107849:	85 c0                	test   %eax,%eax
ffff80000010784b:	75 d8                	jne    ffff800000107825 <acquiresleep+0x29>
  lk->locked = 1;
ffff80000010784d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107851:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
  lk->pid = proc->pid;
ffff800000107857:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010785e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107862:	8b 50 1c             	mov    0x1c(%rax),%edx
ffff800000107865:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107869:	89 50 78             	mov    %edx,0x78(%rax)
  release(&lk->lk);
ffff80000010786c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107870:	48 83 c0 08          	add    $0x8,%rax
ffff800000107874:	48 89 c7             	mov    %rax,%rdi
ffff800000107877:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff80000010787e:	80 ff ff 
ffff800000107881:	ff d0                	call   *%rax
}
ffff800000107883:	90                   	nop
ffff800000107884:	c9                   	leave
ffff800000107885:	c3                   	ret

ffff800000107886 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
ffff800000107886:	f3 0f 1e fa          	endbr64
ffff80000010788a:	55                   	push   %rbp
ffff80000010788b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010788e:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107892:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&lk->lk);
ffff800000107896:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010789a:	48 83 c0 08          	add    $0x8,%rax
ffff80000010789e:	48 89 c7             	mov    %rax,%rdi
ffff8000001078a1:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff8000001078a8:	80 ff ff 
ffff8000001078ab:	ff d0                	call   *%rax
  lk->locked = 0;
ffff8000001078ad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001078b1:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  lk->pid = 0;
ffff8000001078b7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001078bb:	c7 40 78 00 00 00 00 	movl   $0x0,0x78(%rax)
  wakeup(lk);
ffff8000001078c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001078c6:	48 89 c7             	mov    %rax,%rdi
ffff8000001078c9:	48 b8 21 72 10 00 00 	movabs $0xffff800000107221,%rax
ffff8000001078d0:	80 ff ff 
ffff8000001078d3:	ff d0                	call   *%rax
  release(&lk->lk);
ffff8000001078d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001078d9:	48 83 c0 08          	add    $0x8,%rax
ffff8000001078dd:	48 89 c7             	mov    %rax,%rdi
ffff8000001078e0:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff8000001078e7:	80 ff ff 
ffff8000001078ea:	ff d0                	call   *%rax
}
ffff8000001078ec:	90                   	nop
ffff8000001078ed:	c9                   	leave
ffff8000001078ee:	c3                   	ret

ffff8000001078ef <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
ffff8000001078ef:	f3 0f 1e fa          	endbr64
ffff8000001078f3:	55                   	push   %rbp
ffff8000001078f4:	48 89 e5             	mov    %rsp,%rbp
ffff8000001078f7:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001078fb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  acquire(&lk->lk);
ffff8000001078ff:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107903:	48 83 c0 08          	add    $0x8,%rax
ffff800000107907:	48 89 c7             	mov    %rax,%rdi
ffff80000010790a:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff800000107911:	80 ff ff 
ffff800000107914:	ff d0                	call   *%rax
  int r = lk->locked;
ffff800000107916:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010791a:	8b 00                	mov    (%rax),%eax
ffff80000010791c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  release(&lk->lk);
ffff80000010791f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107923:	48 83 c0 08          	add    $0x8,%rax
ffff800000107927:	48 89 c7             	mov    %rax,%rdi
ffff80000010792a:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff800000107931:	80 ff ff 
ffff800000107934:	ff d0                	call   *%rax
  return r;
ffff800000107936:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff800000107939:	c9                   	leave
ffff80000010793a:	c3                   	ret

ffff80000010793b <readeflags>:
  return lock->locked && lock->cpu == cpu;
}

// Pushcli/popcli are like cli/sti except that they are matched:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.
ffff80000010793b:	f3 0f 1e fa          	endbr64
ffff80000010793f:	55                   	push   %rbp
ffff800000107940:	48 89 e5             	mov    %rsp,%rbp
ffff800000107943:	48 83 ec 10          	sub    $0x10,%rsp
void
pushcli(void)
ffff800000107947:	9c                   	pushf
ffff800000107948:	58                   	pop    %rax
ffff800000107949:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
{
ffff80000010794d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  int eflags;
ffff800000107951:	c9                   	leave
ffff800000107952:	c3                   	ret

ffff800000107953 <cli>:

  eflags = readeflags();
  cli();
  if(cpu->ncli == 0)
ffff800000107953:	f3 0f 1e fa          	endbr64
ffff800000107957:	55                   	push   %rbp
ffff800000107958:	48 89 e5             	mov    %rsp,%rbp
    cpu->intena = eflags & FL_IF;
ffff80000010795b:	fa                   	cli
  cpu->ncli += 1;
ffff80000010795c:	90                   	nop
ffff80000010795d:	5d                   	pop    %rbp
ffff80000010795e:	c3                   	ret

ffff80000010795f <sti>:
}

void
popcli(void)
ffff80000010795f:	f3 0f 1e fa          	endbr64
ffff800000107963:	55                   	push   %rbp
ffff800000107964:	48 89 e5             	mov    %rsp,%rbp
{
ffff800000107967:	fb                   	sti
  if(readeflags()&FL_IF)
ffff800000107968:	90                   	nop
ffff800000107969:	5d                   	pop    %rbp
ffff80000010796a:	c3                   	ret

ffff80000010796b <xchg>:
    sti();
}
ffff80000010796b:	f3 0f 1e fa          	endbr64
ffff80000010796f:	55                   	push   %rbp
ffff800000107970:	48 89 e5             	mov    %rsp,%rbp
ffff800000107973:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000107977:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010797b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff80000010797f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000107983:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000107987:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffff80000010798b:	f0 87 02             	lock xchg %eax,(%rdx)
ffff80000010798e:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000107991:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000107994:	c9                   	leave
ffff800000107995:	c3                   	ret

ffff800000107996 <initlock>:
{
ffff800000107996:	f3 0f 1e fa          	endbr64
ffff80000010799a:	55                   	push   %rbp
ffff80000010799b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010799e:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001079a2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff8000001079a6:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  lk->name = name;
ffff8000001079aa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001079ae:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff8000001079b2:	48 89 50 08          	mov    %rdx,0x8(%rax)
  lk->locked = 0;
ffff8000001079b6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001079ba:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  lk->cpu = 0;
ffff8000001079c0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001079c4:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff8000001079cb:	00 
}
ffff8000001079cc:	90                   	nop
ffff8000001079cd:	c9                   	leave
ffff8000001079ce:	c3                   	ret

ffff8000001079cf <acquire>:
{
ffff8000001079cf:	f3 0f 1e fa          	endbr64
ffff8000001079d3:	55                   	push   %rbp
ffff8000001079d4:	48 89 e5             	mov    %rsp,%rbp
ffff8000001079d7:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001079db:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  pushcli(); // disable interrupts to avoid deadlock.
ffff8000001079df:	48 b8 03 7c 10 00 00 	movabs $0xffff800000107c03,%rax
ffff8000001079e6:	80 ff ff 
ffff8000001079e9:	ff d0                	call   *%rax
  if(holding(lk))
ffff8000001079eb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001079ef:	48 89 c7             	mov    %rax,%rdi
ffff8000001079f2:	48 b8 c3 7b 10 00 00 	movabs $0xffff800000107bc3,%rax
ffff8000001079f9:	80 ff ff 
ffff8000001079fc:	ff d0                	call   *%rax
ffff8000001079fe:	85 c0                	test   %eax,%eax
ffff800000107a00:	74 19                	je     ffff800000107a1b <acquire+0x4c>
    panic("acquire");
ffff800000107a02:	48 b8 66 c8 10 00 00 	movabs $0xffff80000010c866,%rax
ffff800000107a09:	80 ff ff 
ffff800000107a0c:	48 89 c7             	mov    %rax,%rdi
ffff800000107a0f:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000107a16:	80 ff ff 
ffff800000107a19:	ff d0                	call   *%rax
  while(xchg(&lk->locked, 1) != 0)
ffff800000107a1b:	90                   	nop
ffff800000107a1c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107a20:	be 01 00 00 00       	mov    $0x1,%esi
ffff800000107a25:	48 89 c7             	mov    %rax,%rdi
ffff800000107a28:	48 b8 6b 79 10 00 00 	movabs $0xffff80000010796b,%rax
ffff800000107a2f:	80 ff ff 
ffff800000107a32:	ff d0                	call   *%rax
ffff800000107a34:	85 c0                	test   %eax,%eax
ffff800000107a36:	75 e4                	jne    ffff800000107a1c <acquire+0x4d>
  __sync_synchronize();
ffff800000107a38:	f0 48 83 0c 24 00    	lock orq $0x0,(%rsp)
  lk->cpu = cpu;
ffff800000107a3e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107a42:	48 c7 c2 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rdx
ffff800000107a49:	64 48 8b 12          	mov    %fs:(%rdx),%rdx
ffff800000107a4d:	48 89 50 10          	mov    %rdx,0x10(%rax)
  getcallerpcs(&lk, lk->pcs);
ffff800000107a51:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107a55:	48 8d 50 18          	lea    0x18(%rax),%rdx
ffff800000107a59:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff800000107a5d:	48 89 d6             	mov    %rdx,%rsi
ffff800000107a60:	48 89 c7             	mov    %rax,%rdi
ffff800000107a63:	48 b8 ed 7a 10 00 00 	movabs $0xffff800000107aed,%rax
ffff800000107a6a:	80 ff ff 
ffff800000107a6d:	ff d0                	call   *%rax
}
ffff800000107a6f:	90                   	nop
ffff800000107a70:	c9                   	leave
ffff800000107a71:	c3                   	ret

ffff800000107a72 <release>:
{
ffff800000107a72:	f3 0f 1e fa          	endbr64
ffff800000107a76:	55                   	push   %rbp
ffff800000107a77:	48 89 e5             	mov    %rsp,%rbp
ffff800000107a7a:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107a7e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  if(!holding(lk))
ffff800000107a82:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107a86:	48 89 c7             	mov    %rax,%rdi
ffff800000107a89:	48 b8 c3 7b 10 00 00 	movabs $0xffff800000107bc3,%rax
ffff800000107a90:	80 ff ff 
ffff800000107a93:	ff d0                	call   *%rax
ffff800000107a95:	85 c0                	test   %eax,%eax
ffff800000107a97:	75 19                	jne    ffff800000107ab2 <release+0x40>
    panic("release");
ffff800000107a99:	48 b8 6e c8 10 00 00 	movabs $0xffff80000010c86e,%rax
ffff800000107aa0:	80 ff ff 
ffff800000107aa3:	48 89 c7             	mov    %rax,%rdi
ffff800000107aa6:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000107aad:	80 ff ff 
ffff800000107ab0:	ff d0                	call   *%rax
  lk->pcs[0] = 0;
ffff800000107ab2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107ab6:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
ffff800000107abd:	00 
  lk->cpu = 0;
ffff800000107abe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107ac2:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff800000107ac9:	00 
  __sync_synchronize();
ffff800000107aca:	f0 48 83 0c 24 00    	lock orq $0x0,(%rsp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
ffff800000107ad0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107ad4:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000107ad8:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  popcli();
ffff800000107ade:	48 b8 75 7c 10 00 00 	movabs $0xffff800000107c75,%rax
ffff800000107ae5:	80 ff ff 
ffff800000107ae8:	ff d0                	call   *%rax
}
ffff800000107aea:	90                   	nop
ffff800000107aeb:	c9                   	leave
ffff800000107aec:	c3                   	ret

ffff800000107aed <getcallerpcs>:
{
ffff800000107aed:	f3 0f 1e fa          	endbr64
ffff800000107af1:	55                   	push   %rbp
ffff800000107af2:	48 89 e5             	mov    %rsp,%rbp
ffff800000107af5:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000107af9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107afd:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  asm volatile("mov %%rbp, %0" : "=r" (rbp));
ffff800000107b01:	48 89 e8             	mov    %rbp,%rax
ffff800000107b04:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  getstackpcs(rbp, pcs);
ffff800000107b08:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000107b0c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107b10:	48 89 d6             	mov    %rdx,%rsi
ffff800000107b13:	48 89 c7             	mov    %rax,%rdi
ffff800000107b16:	48 b8 25 7b 10 00 00 	movabs $0xffff800000107b25,%rax
ffff800000107b1d:	80 ff ff 
ffff800000107b20:	ff d0                	call   *%rax
}
ffff800000107b22:	90                   	nop
ffff800000107b23:	c9                   	leave
ffff800000107b24:	c3                   	ret

ffff800000107b25 <getstackpcs>:
{
ffff800000107b25:	f3 0f 1e fa          	endbr64
ffff800000107b29:	55                   	push   %rbp
ffff800000107b2a:	48 89 e5             	mov    %rsp,%rbp
ffff800000107b2d:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000107b31:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107b35:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  for(i = 0; i < 10; i++){
ffff800000107b39:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000107b40:	eb 50                	jmp    ffff800000107b92 <getstackpcs+0x6d>
    if(rbp == 0 || rbp < (addr_t*)KERNBASE || rbp == (addr_t*)0xffffffff)
ffff800000107b42:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff800000107b47:	74 70                	je     ffff800000107bb9 <getstackpcs+0x94>
ffff800000107b49:	48 b8 ff ff ff ff ff 	movabs $0xffff7fffffffffff,%rax
ffff800000107b50:	7f ff ff 
ffff800000107b53:	48 3b 45 e8          	cmp    -0x18(%rbp),%rax
ffff800000107b57:	73 60                	jae    ffff800000107bb9 <getstackpcs+0x94>
ffff800000107b59:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000107b5e:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffff800000107b62:	74 55                	je     ffff800000107bb9 <getstackpcs+0x94>
    pcs[i] = rbp[1];     // saved %rip
ffff800000107b64:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000107b67:	48 98                	cltq
ffff800000107b69:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff800000107b70:	00 
ffff800000107b71:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000107b75:	48 01 c2             	add    %rax,%rdx
ffff800000107b78:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107b7c:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000107b80:	48 89 02             	mov    %rax,(%rdx)
    rbp = (addr_t*)rbp[0]; // saved %rbp
ffff800000107b83:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107b87:	48 8b 00             	mov    (%rax),%rax
ffff800000107b8a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  for(i = 0; i < 10; i++){
ffff800000107b8e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000107b92:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffff800000107b96:	7e aa                	jle    ffff800000107b42 <getstackpcs+0x1d>
  for(; i < 10; i++)
ffff800000107b98:	eb 1f                	jmp    ffff800000107bb9 <getstackpcs+0x94>
    pcs[i] = 0;
ffff800000107b9a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000107b9d:	48 98                	cltq
ffff800000107b9f:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff800000107ba6:	00 
ffff800000107ba7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000107bab:	48 01 d0             	add    %rdx,%rax
ffff800000107bae:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  for(; i < 10; i++)
ffff800000107bb5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000107bb9:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffff800000107bbd:	7e db                	jle    ffff800000107b9a <getstackpcs+0x75>
}
ffff800000107bbf:	90                   	nop
ffff800000107bc0:	90                   	nop
ffff800000107bc1:	c9                   	leave
ffff800000107bc2:	c3                   	ret

ffff800000107bc3 <holding>:
{
ffff800000107bc3:	f3 0f 1e fa          	endbr64
ffff800000107bc7:	55                   	push   %rbp
ffff800000107bc8:	48 89 e5             	mov    %rsp,%rbp
ffff800000107bcb:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000107bcf:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  return lock->locked && lock->cpu == cpu;
ffff800000107bd3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107bd7:	8b 00                	mov    (%rax),%eax
ffff800000107bd9:	85 c0                	test   %eax,%eax
ffff800000107bdb:	74 1f                	je     ffff800000107bfc <holding+0x39>
ffff800000107bdd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107be1:	48 8b 50 10          	mov    0x10(%rax),%rdx
ffff800000107be5:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000107bec:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107bf0:	48 39 c2             	cmp    %rax,%rdx
ffff800000107bf3:	75 07                	jne    ffff800000107bfc <holding+0x39>
ffff800000107bf5:	b8 01 00 00 00       	mov    $0x1,%eax
ffff800000107bfa:	eb 05                	jmp    ffff800000107c01 <holding+0x3e>
ffff800000107bfc:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000107c01:	c9                   	leave
ffff800000107c02:	c3                   	ret

ffff800000107c03 <pushcli>:
{
ffff800000107c03:	f3 0f 1e fa          	endbr64
ffff800000107c07:	55                   	push   %rbp
ffff800000107c08:	48 89 e5             	mov    %rsp,%rbp
ffff800000107c0b:	48 83 ec 10          	sub    $0x10,%rsp
  eflags = readeflags();
ffff800000107c0f:	48 b8 3b 79 10 00 00 	movabs $0xffff80000010793b,%rax
ffff800000107c16:	80 ff ff 
ffff800000107c19:	ff d0                	call   *%rax
ffff800000107c1b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  cli();
ffff800000107c1e:	48 b8 53 79 10 00 00 	movabs $0xffff800000107953,%rax
ffff800000107c25:	80 ff ff 
ffff800000107c28:	ff d0                	call   *%rax
  if(cpu->ncli == 0)
ffff800000107c2a:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000107c31:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107c35:	8b 40 14             	mov    0x14(%rax),%eax
ffff800000107c38:	85 c0                	test   %eax,%eax
ffff800000107c3a:	75 17                	jne    ffff800000107c53 <pushcli+0x50>
    cpu->intena = eflags & FL_IF;
ffff800000107c3c:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000107c43:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107c47:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000107c4a:	81 e2 00 02 00 00    	and    $0x200,%edx
ffff800000107c50:	89 50 18             	mov    %edx,0x18(%rax)
  cpu->ncli += 1;
ffff800000107c53:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000107c5a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107c5e:	8b 50 14             	mov    0x14(%rax),%edx
ffff800000107c61:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000107c68:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107c6c:	83 c2 01             	add    $0x1,%edx
ffff800000107c6f:	89 50 14             	mov    %edx,0x14(%rax)
}
ffff800000107c72:	90                   	nop
ffff800000107c73:	c9                   	leave
ffff800000107c74:	c3                   	ret

ffff800000107c75 <popcli>:
{
ffff800000107c75:	f3 0f 1e fa          	endbr64
ffff800000107c79:	55                   	push   %rbp
ffff800000107c7a:	48 89 e5             	mov    %rsp,%rbp
  if(readeflags()&FL_IF)
ffff800000107c7d:	48 b8 3b 79 10 00 00 	movabs $0xffff80000010793b,%rax
ffff800000107c84:	80 ff ff 
ffff800000107c87:	ff d0                	call   *%rax
ffff800000107c89:	25 00 02 00 00       	and    $0x200,%eax
ffff800000107c8e:	48 85 c0             	test   %rax,%rax
ffff800000107c91:	74 19                	je     ffff800000107cac <popcli+0x37>
    panic("popcli - interruptible");
ffff800000107c93:	48 b8 76 c8 10 00 00 	movabs $0xffff80000010c876,%rax
ffff800000107c9a:	80 ff ff 
ffff800000107c9d:	48 89 c7             	mov    %rax,%rdi
ffff800000107ca0:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000107ca7:	80 ff ff 
ffff800000107caa:	ff d0                	call   *%rax
  if(--cpu->ncli < 0)
ffff800000107cac:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000107cb3:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107cb7:	8b 50 14             	mov    0x14(%rax),%edx
ffff800000107cba:	83 ea 01             	sub    $0x1,%edx
ffff800000107cbd:	89 50 14             	mov    %edx,0x14(%rax)
ffff800000107cc0:	8b 40 14             	mov    0x14(%rax),%eax
ffff800000107cc3:	85 c0                	test   %eax,%eax
ffff800000107cc5:	79 19                	jns    ffff800000107ce0 <popcli+0x6b>
    panic("popcli");
ffff800000107cc7:	48 b8 8d c8 10 00 00 	movabs $0xffff80000010c88d,%rax
ffff800000107cce:	80 ff ff 
ffff800000107cd1:	48 89 c7             	mov    %rax,%rdi
ffff800000107cd4:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000107cdb:	80 ff ff 
ffff800000107cde:	ff d0                	call   *%rax
  if(cpu->ncli == 0 && cpu->intena)
ffff800000107ce0:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000107ce7:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107ceb:	8b 40 14             	mov    0x14(%rax),%eax
ffff800000107cee:	85 c0                	test   %eax,%eax
ffff800000107cf0:	75 1e                	jne    ffff800000107d10 <popcli+0x9b>
ffff800000107cf2:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000107cf9:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107cfd:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000107d00:	85 c0                	test   %eax,%eax
ffff800000107d02:	74 0c                	je     ffff800000107d10 <popcli+0x9b>
    sti();
ffff800000107d04:	48 b8 5f 79 10 00 00 	movabs $0xffff80000010795f,%rax
ffff800000107d0b:	80 ff ff 
ffff800000107d0e:	ff d0                	call   *%rax
}
ffff800000107d10:	90                   	nop
ffff800000107d11:	5d                   	pop    %rbp
ffff800000107d12:	c3                   	ret

ffff800000107d13 <stosb>:
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
ffff800000107d13:	f3 0f 1e fa          	endbr64
ffff800000107d17:	55                   	push   %rbp
ffff800000107d18:	48 89 e5             	mov    %rsp,%rbp
ffff800000107d1b:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107d1f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107d23:	89 75 f4             	mov    %esi,-0xc(%rbp)
ffff800000107d26:	89 55 f0             	mov    %edx,-0x10(%rbp)
    while(n-- > 0)
ffff800000107d29:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff800000107d2d:	8b 55 f0             	mov    -0x10(%rbp),%edx
ffff800000107d30:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000107d33:	48 89 ce             	mov    %rcx,%rsi
ffff800000107d36:	48 89 f7             	mov    %rsi,%rdi
ffff800000107d39:	89 d1                	mov    %edx,%ecx
ffff800000107d3b:	fc                   	cld
ffff800000107d3c:	f3 aa                	rep stos %al,%es:(%rdi)
ffff800000107d3e:	89 ca                	mov    %ecx,%edx
ffff800000107d40:	48 89 fe             	mov    %rdi,%rsi
ffff800000107d43:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
ffff800000107d47:	89 55 f0             	mov    %edx,-0x10(%rbp)
      *d++ = *s++;

  return dst;
}
ffff800000107d4a:	90                   	nop
ffff800000107d4b:	c9                   	leave
ffff800000107d4c:	c3                   	ret

ffff800000107d4d <stosl>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
ffff800000107d4d:	f3 0f 1e fa          	endbr64
ffff800000107d51:	55                   	push   %rbp
ffff800000107d52:	48 89 e5             	mov    %rsp,%rbp
ffff800000107d55:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107d59:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107d5d:	89 75 f4             	mov    %esi,-0xc(%rbp)
ffff800000107d60:	89 55 f0             	mov    %edx,-0x10(%rbp)
{
ffff800000107d63:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff800000107d67:	8b 55 f0             	mov    -0x10(%rbp),%edx
ffff800000107d6a:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000107d6d:	48 89 ce             	mov    %rcx,%rsi
ffff800000107d70:	48 89 f7             	mov    %rsi,%rdi
ffff800000107d73:	89 d1                	mov    %edx,%ecx
ffff800000107d75:	fc                   	cld
ffff800000107d76:	f3 ab                	rep stos %eax,%es:(%rdi)
ffff800000107d78:	89 ca                	mov    %ecx,%edx
ffff800000107d7a:	48 89 fe             	mov    %rdi,%rsi
ffff800000107d7d:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
ffff800000107d81:	89 55 f0             	mov    %edx,-0x10(%rbp)
  return memmove(dst, src, n);
}

int
ffff800000107d84:	90                   	nop
ffff800000107d85:	c9                   	leave
ffff800000107d86:	c3                   	ret

ffff800000107d87 <memset>:
{
ffff800000107d87:	f3 0f 1e fa          	endbr64
ffff800000107d8b:	55                   	push   %rbp
ffff800000107d8c:	48 89 e5             	mov    %rsp,%rbp
ffff800000107d8f:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000107d93:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107d97:	89 75 f4             	mov    %esi,-0xc(%rbp)
ffff800000107d9a:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  if ((addr_t)dst%4 == 0 && n%4 == 0){
ffff800000107d9e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107da2:	83 e0 03             	and    $0x3,%eax
ffff800000107da5:	48 85 c0             	test   %rax,%rax
ffff800000107da8:	75 53                	jne    ffff800000107dfd <memset+0x76>
ffff800000107daa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107dae:	83 e0 03             	and    $0x3,%eax
ffff800000107db1:	48 85 c0             	test   %rax,%rax
ffff800000107db4:	75 47                	jne    ffff800000107dfd <memset+0x76>
    c &= 0xFF;
ffff800000107db6:	81 65 f4 ff 00 00 00 	andl   $0xff,-0xc(%rbp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
ffff800000107dbd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107dc1:	48 c1 e8 02          	shr    $0x2,%rax
ffff800000107dc5:	89 c6                	mov    %eax,%esi
ffff800000107dc7:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000107dca:	c1 e0 18             	shl    $0x18,%eax
ffff800000107dcd:	89 c2                	mov    %eax,%edx
ffff800000107dcf:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000107dd2:	c1 e0 10             	shl    $0x10,%eax
ffff800000107dd5:	09 c2                	or     %eax,%edx
ffff800000107dd7:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000107dda:	c1 e0 08             	shl    $0x8,%eax
ffff800000107ddd:	09 d0                	or     %edx,%eax
ffff800000107ddf:	0b 45 f4             	or     -0xc(%rbp),%eax
ffff800000107de2:	89 c1                	mov    %eax,%ecx
ffff800000107de4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107de8:	89 f2                	mov    %esi,%edx
ffff800000107dea:	89 ce                	mov    %ecx,%esi
ffff800000107dec:	48 89 c7             	mov    %rax,%rdi
ffff800000107def:	48 b8 4d 7d 10 00 00 	movabs $0xffff800000107d4d,%rax
ffff800000107df6:	80 ff ff 
ffff800000107df9:	ff d0                	call   *%rax
ffff800000107dfb:	eb 1e                	jmp    ffff800000107e1b <memset+0x94>
    stosb(dst, c, n);
ffff800000107dfd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107e01:	89 c2                	mov    %eax,%edx
ffff800000107e03:	8b 4d f4             	mov    -0xc(%rbp),%ecx
ffff800000107e06:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107e0a:	89 ce                	mov    %ecx,%esi
ffff800000107e0c:	48 89 c7             	mov    %rax,%rdi
ffff800000107e0f:	48 b8 13 7d 10 00 00 	movabs $0xffff800000107d13,%rax
ffff800000107e16:	80 ff ff 
ffff800000107e19:	ff d0                	call   *%rax
  return dst;
ffff800000107e1b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000107e1f:	c9                   	leave
ffff800000107e20:	c3                   	ret

ffff800000107e21 <memcmp>:
{
ffff800000107e21:	f3 0f 1e fa          	endbr64
ffff800000107e25:	55                   	push   %rbp
ffff800000107e26:	48 89 e5             	mov    %rsp,%rbp
ffff800000107e29:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000107e2d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107e31:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000107e35:	89 55 dc             	mov    %edx,-0x24(%rbp)
  s1 = v1;
ffff800000107e38:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107e3c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  s2 = v2;
ffff800000107e40:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000107e44:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0){
ffff800000107e48:	eb 34                	jmp    ffff800000107e7e <memcmp+0x5d>
    if(*s1 != *s2)
ffff800000107e4a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107e4e:	0f b6 10             	movzbl (%rax),%edx
ffff800000107e51:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107e55:	0f b6 00             	movzbl (%rax),%eax
ffff800000107e58:	38 c2                	cmp    %al,%dl
ffff800000107e5a:	74 18                	je     ffff800000107e74 <memcmp+0x53>
      return *s1 - *s2;
ffff800000107e5c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107e60:	0f b6 00             	movzbl (%rax),%eax
ffff800000107e63:	0f b6 d0             	movzbl %al,%edx
ffff800000107e66:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107e6a:	0f b6 00             	movzbl (%rax),%eax
ffff800000107e6d:	0f b6 c0             	movzbl %al,%eax
ffff800000107e70:	29 c2                	sub    %eax,%edx
ffff800000107e72:	eb 1c                	jmp    ffff800000107e90 <memcmp+0x6f>
    s1++, s2++;
ffff800000107e74:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffff800000107e79:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(n-- > 0){
ffff800000107e7e:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107e81:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000107e84:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000107e87:	85 c0                	test   %eax,%eax
ffff800000107e89:	75 bf                	jne    ffff800000107e4a <memcmp+0x29>
  return 0;
ffff800000107e8b:	ba 00 00 00 00       	mov    $0x0,%edx
}
ffff800000107e90:	89 d0                	mov    %edx,%eax
ffff800000107e92:	c9                   	leave
ffff800000107e93:	c3                   	ret

ffff800000107e94 <memmove>:
{
ffff800000107e94:	f3 0f 1e fa          	endbr64
ffff800000107e98:	55                   	push   %rbp
ffff800000107e99:	48 89 e5             	mov    %rsp,%rbp
ffff800000107e9c:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000107ea0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107ea4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000107ea8:	89 55 dc             	mov    %edx,-0x24(%rbp)
  s = src;
ffff800000107eab:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000107eaf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  d = dst;
ffff800000107eb3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107eb7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  if(s < d && s + n > d){
ffff800000107ebb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107ebf:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
ffff800000107ec3:	73 63                	jae    ffff800000107f28 <memmove+0x94>
ffff800000107ec5:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffff800000107ec8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107ecc:	48 01 d0             	add    %rdx,%rax
ffff800000107ecf:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff800000107ed3:	73 53                	jae    ffff800000107f28 <memmove+0x94>
    s += n;
ffff800000107ed5:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107ed8:	48 01 45 f8          	add    %rax,-0x8(%rbp)
    d += n;
ffff800000107edc:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107edf:	48 01 45 f0          	add    %rax,-0x10(%rbp)
    while(n-- > 0)
ffff800000107ee3:	eb 17                	jmp    ffff800000107efc <memmove+0x68>
      *--d = *--s;
ffff800000107ee5:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
ffff800000107eea:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
ffff800000107eef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107ef3:	0f b6 10             	movzbl (%rax),%edx
ffff800000107ef6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107efa:	88 10                	mov    %dl,(%rax)
    while(n-- > 0)
ffff800000107efc:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107eff:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000107f02:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000107f05:	85 c0                	test   %eax,%eax
ffff800000107f07:	75 dc                	jne    ffff800000107ee5 <memmove+0x51>
  if(s < d && s + n > d){
ffff800000107f09:	eb 2a                	jmp    ffff800000107f35 <memmove+0xa1>
      *d++ = *s++;
ffff800000107f0b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000107f0f:	48 8d 42 01          	lea    0x1(%rdx),%rax
ffff800000107f13:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000107f17:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107f1b:	48 8d 48 01          	lea    0x1(%rax),%rcx
ffff800000107f1f:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
ffff800000107f23:	0f b6 12             	movzbl (%rdx),%edx
ffff800000107f26:	88 10                	mov    %dl,(%rax)
    while(n-- > 0)
ffff800000107f28:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107f2b:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000107f2e:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000107f31:	85 c0                	test   %eax,%eax
ffff800000107f33:	75 d6                	jne    ffff800000107f0b <memmove+0x77>
  return dst;
ffff800000107f35:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
ffff800000107f39:	c9                   	leave
ffff800000107f3a:	c3                   	ret

ffff800000107f3b <memcpy>:
{
ffff800000107f3b:	f3 0f 1e fa          	endbr64
ffff800000107f3f:	55                   	push   %rbp
ffff800000107f40:	48 89 e5             	mov    %rsp,%rbp
ffff800000107f43:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000107f47:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107f4b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff800000107f4f:	89 55 ec             	mov    %edx,-0x14(%rbp)
  return memmove(dst, src, n);
ffff800000107f52:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff800000107f55:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffff800000107f59:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107f5d:	48 89 ce             	mov    %rcx,%rsi
ffff800000107f60:	48 89 c7             	mov    %rax,%rdi
ffff800000107f63:	48 b8 94 7e 10 00 00 	movabs $0xffff800000107e94,%rax
ffff800000107f6a:	80 ff ff 
ffff800000107f6d:	ff d0                	call   *%rax
}
ffff800000107f6f:	c9                   	leave
ffff800000107f70:	c3                   	ret

ffff800000107f71 <strncmp>:
strncmp(const char *p, const char *q, uint n)
{
ffff800000107f71:	f3 0f 1e fa          	endbr64
ffff800000107f75:	55                   	push   %rbp
ffff800000107f76:	48 89 e5             	mov    %rsp,%rbp
ffff800000107f79:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000107f7d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107f81:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff800000107f85:	89 55 ec             	mov    %edx,-0x14(%rbp)
  while(n > 0 && *p && *p == *q)
ffff800000107f88:	eb 0e                	jmp    ffff800000107f98 <strncmp+0x27>
    n--, p++, q++;
ffff800000107f8a:	83 6d ec 01          	subl   $0x1,-0x14(%rbp)
ffff800000107f8e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffff800000107f93:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(n > 0 && *p && *p == *q)
ffff800000107f98:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffff800000107f9c:	74 1d                	je     ffff800000107fbb <strncmp+0x4a>
ffff800000107f9e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107fa2:	0f b6 00             	movzbl (%rax),%eax
ffff800000107fa5:	84 c0                	test   %al,%al
ffff800000107fa7:	74 12                	je     ffff800000107fbb <strncmp+0x4a>
ffff800000107fa9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107fad:	0f b6 10             	movzbl (%rax),%edx
ffff800000107fb0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107fb4:	0f b6 00             	movzbl (%rax),%eax
ffff800000107fb7:	38 c2                	cmp    %al,%dl
ffff800000107fb9:	74 cf                	je     ffff800000107f8a <strncmp+0x19>
  if(n == 0)
ffff800000107fbb:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffff800000107fbf:	75 07                	jne    ffff800000107fc8 <strncmp+0x57>
    return 0;
ffff800000107fc1:	ba 00 00 00 00       	mov    $0x0,%edx
ffff800000107fc6:	eb 16                	jmp    ffff800000107fde <strncmp+0x6d>
  return (uchar)*p - (uchar)*q;
ffff800000107fc8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107fcc:	0f b6 00             	movzbl (%rax),%eax
ffff800000107fcf:	0f b6 d0             	movzbl %al,%edx
ffff800000107fd2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107fd6:	0f b6 00             	movzbl (%rax),%eax
ffff800000107fd9:	0f b6 c0             	movzbl %al,%eax
ffff800000107fdc:	29 c2                	sub    %eax,%edx
}
ffff800000107fde:	89 d0                	mov    %edx,%eax
ffff800000107fe0:	c9                   	leave
ffff800000107fe1:	c3                   	ret

ffff800000107fe2 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
ffff800000107fe2:	f3 0f 1e fa          	endbr64
ffff800000107fe6:	55                   	push   %rbp
ffff800000107fe7:	48 89 e5             	mov    %rsp,%rbp
ffff800000107fea:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000107fee:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107ff2:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000107ff6:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *os = s;
ffff800000107ff9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107ffd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while(n-- > 0 && (*s++ = *t++) != 0)
ffff800000108001:	90                   	nop
ffff800000108002:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000108005:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000108008:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff80000010800b:	85 c0                	test   %eax,%eax
ffff80000010800d:	7e 35                	jle    ffff800000108044 <strncpy+0x62>
ffff80000010800f:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000108013:	48 8d 42 01          	lea    0x1(%rdx),%rax
ffff800000108017:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff80000010801b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010801f:	48 8d 48 01          	lea    0x1(%rax),%rcx
ffff800000108023:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
ffff800000108027:	0f b6 12             	movzbl (%rdx),%edx
ffff80000010802a:	88 10                	mov    %dl,(%rax)
ffff80000010802c:	0f b6 00             	movzbl (%rax),%eax
ffff80000010802f:	84 c0                	test   %al,%al
ffff800000108031:	75 cf                	jne    ffff800000108002 <strncpy+0x20>
    ;
  while(n-- > 0)
ffff800000108033:	eb 0f                	jmp    ffff800000108044 <strncpy+0x62>
    *s++ = 0;
ffff800000108035:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000108039:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff80000010803d:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
ffff800000108041:	c6 00 00             	movb   $0x0,(%rax)
  while(n-- > 0)
ffff800000108044:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000108047:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff80000010804a:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff80000010804d:	85 c0                	test   %eax,%eax
ffff80000010804f:	7f e4                	jg     ffff800000108035 <strncpy+0x53>
  return os;
ffff800000108051:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000108055:	c9                   	leave
ffff800000108056:	c3                   	ret

ffff800000108057 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
ffff800000108057:	f3 0f 1e fa          	endbr64
ffff80000010805b:	55                   	push   %rbp
ffff80000010805c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010805f:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000108063:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000108067:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff80000010806b:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *os = s;
ffff80000010806e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000108072:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(n <= 0)
ffff800000108076:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
ffff80000010807a:	7f 06                	jg     ffff800000108082 <safestrcpy+0x2b>
    return os;
ffff80000010807c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108080:	eb 3a                	jmp    ffff8000001080bc <safestrcpy+0x65>
  while(--n > 0 && (*s++ = *t++) != 0)
ffff800000108082:	90                   	nop
ffff800000108083:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
ffff800000108087:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
ffff80000010808b:	7e 24                	jle    ffff8000001080b1 <safestrcpy+0x5a>
ffff80000010808d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000108091:	48 8d 42 01          	lea    0x1(%rdx),%rax
ffff800000108095:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff800000108099:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010809d:	48 8d 48 01          	lea    0x1(%rax),%rcx
ffff8000001080a1:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
ffff8000001080a5:	0f b6 12             	movzbl (%rdx),%edx
ffff8000001080a8:	88 10                	mov    %dl,(%rax)
ffff8000001080aa:	0f b6 00             	movzbl (%rax),%eax
ffff8000001080ad:	84 c0                	test   %al,%al
ffff8000001080af:	75 d2                	jne    ffff800000108083 <safestrcpy+0x2c>
    ;
  *s = 0;
ffff8000001080b1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001080b5:	c6 00 00             	movb   $0x0,(%rax)
  return os;
ffff8000001080b8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff8000001080bc:	c9                   	leave
ffff8000001080bd:	c3                   	ret

ffff8000001080be <strlen>:

int
strlen(const char *s)
{
ffff8000001080be:	f3 0f 1e fa          	endbr64
ffff8000001080c2:	55                   	push   %rbp
ffff8000001080c3:	48 89 e5             	mov    %rsp,%rbp
ffff8000001080c6:	48 83 ec 18          	sub    $0x18,%rsp
ffff8000001080ca:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
ffff8000001080ce:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001080d5:	eb 04                	jmp    ffff8000001080db <strlen+0x1d>
ffff8000001080d7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001080db:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001080de:	48 63 d0             	movslq %eax,%rdx
ffff8000001080e1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001080e5:	48 01 d0             	add    %rdx,%rax
ffff8000001080e8:	0f b6 00             	movzbl (%rax),%eax
ffff8000001080eb:	84 c0                	test   %al,%al
ffff8000001080ed:	75 e8                	jne    ffff8000001080d7 <strlen+0x19>
    ;
  return n;
ffff8000001080ef:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff8000001080f2:	c9                   	leave
ffff8000001080f3:	c3                   	ret

ffff8000001080f4 <swtch>:
ffff8000001080f4:	55                   	push   %rbp
ffff8000001080f5:	53                   	push   %rbx
ffff8000001080f6:	41 54                	push   %r12
ffff8000001080f8:	41 55                	push   %r13
ffff8000001080fa:	41 56                	push   %r14
ffff8000001080fc:	41 57                	push   %r15
ffff8000001080fe:	48 89 27             	mov    %rsp,(%rdi)
ffff800000108101:	48 89 f4             	mov    %rsi,%rsp
ffff800000108104:	41 5f                	pop    %r15
ffff800000108106:	41 5e                	pop    %r14
ffff800000108108:	41 5d                	pop    %r13
ffff80000010810a:	41 5c                	pop    %r12
ffff80000010810c:	5b                   	pop    %rbx
ffff80000010810d:	5d                   	pop    %rbp
ffff80000010810e:	c3                   	ret

ffff80000010810f <fetchint>:
#include "syscall.h"

// Fetch the int at addr from the current process.
int
fetchint(addr_t addr, int *ip)
{
ffff80000010810f:	f3 0f 1e fa          	endbr64
ffff800000108113:	55                   	push   %rbp
ffff800000108114:	48 89 e5             	mov    %rsp,%rbp
ffff800000108117:	48 83 ec 10          	sub    $0x10,%rsp
ffff80000010811b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff80000010811f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(addr < PGSIZE || addr >= proc->sz || addr+sizeof(int) > proc->sz)
ffff800000108123:	48 81 7d f8 ff 0f 00 	cmpq   $0xfff,-0x8(%rbp)
ffff80000010812a:	00 
ffff80000010812b:	76 2f                	jbe    ffff80000010815c <fetchint+0x4d>
ffff80000010812d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108134:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108138:	48 8b 00             	mov    (%rax),%rax
ffff80000010813b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff80000010813f:	73 1b                	jae    ffff80000010815c <fetchint+0x4d>
ffff800000108141:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108145:	48 8d 50 04          	lea    0x4(%rax),%rdx
ffff800000108149:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108150:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108154:	48 8b 00             	mov    (%rax),%rax
ffff800000108157:	48 39 d0             	cmp    %rdx,%rax
ffff80000010815a:	73 07                	jae    ffff800000108163 <fetchint+0x54>
    return -1;
ffff80000010815c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108161:	eb 11                	jmp    ffff800000108174 <fetchint+0x65>
  *ip = *(int*)(addr);
ffff800000108163:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108167:	8b 10                	mov    (%rax),%edx
ffff800000108169:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010816d:	89 10                	mov    %edx,(%rax)
  return 0;
ffff80000010816f:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000108174:	c9                   	leave
ffff800000108175:	c3                   	ret

ffff800000108176 <fetchaddr>:

int
fetchaddr(addr_t addr, addr_t *ip)
{
ffff800000108176:	f3 0f 1e fa          	endbr64
ffff80000010817a:	55                   	push   %rbp
ffff80000010817b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010817e:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000108182:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000108186:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(addr < PGSIZE || addr >= proc->sz || addr+sizeof(addr_t) > proc->sz)
ffff80000010818a:	48 81 7d f8 ff 0f 00 	cmpq   $0xfff,-0x8(%rbp)
ffff800000108191:	00 
ffff800000108192:	76 2f                	jbe    ffff8000001081c3 <fetchaddr+0x4d>
ffff800000108194:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010819b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010819f:	48 8b 00             	mov    (%rax),%rax
ffff8000001081a2:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff8000001081a6:	73 1b                	jae    ffff8000001081c3 <fetchaddr+0x4d>
ffff8000001081a8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001081ac:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffff8000001081b0:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001081b7:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001081bb:	48 8b 00             	mov    (%rax),%rax
ffff8000001081be:	48 39 d0             	cmp    %rdx,%rax
ffff8000001081c1:	73 07                	jae    ffff8000001081ca <fetchaddr+0x54>
    return -1;
ffff8000001081c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001081c8:	eb 13                	jmp    ffff8000001081dd <fetchaddr+0x67>
  *ip = *(addr_t*)(addr);
ffff8000001081ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001081ce:	48 8b 10             	mov    (%rax),%rdx
ffff8000001081d1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001081d5:	48 89 10             	mov    %rdx,(%rax)
  return 0;
ffff8000001081d8:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff8000001081dd:	c9                   	leave
ffff8000001081de:	c3                   	ret

ffff8000001081df <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(addr_t addr, char **pp)
{
ffff8000001081df:	f3 0f 1e fa          	endbr64
ffff8000001081e3:	55                   	push   %rbp
ffff8000001081e4:	48 89 e5             	mov    %rsp,%rbp
ffff8000001081e7:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001081eb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff8000001081ef:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *s, *ep;

  if(addr < PGSIZE || addr >= proc->sz)
ffff8000001081f3:	48 81 7d e8 ff 0f 00 	cmpq   $0xfff,-0x18(%rbp)
ffff8000001081fa:	00 
ffff8000001081fb:	76 14                	jbe    ffff800000108211 <fetchstr+0x32>
ffff8000001081fd:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108204:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108208:	48 8b 00             	mov    (%rax),%rax
ffff80000010820b:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffff80000010820f:	72 07                	jb     ffff800000108218 <fetchstr+0x39>
    return -1;
ffff800000108211:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108216:	eb 5b                	jmp    ffff800000108273 <fetchstr+0x94>
  *pp = (char*)addr;
ffff800000108218:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff80000010821c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000108220:	48 89 10             	mov    %rdx,(%rax)
  ep = (char*)proc->sz;
ffff800000108223:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010822a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010822e:	48 8b 00             	mov    (%rax),%rax
ffff800000108231:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(s = *pp; s < ep; s++)
ffff800000108235:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000108239:	48 8b 00             	mov    (%rax),%rax
ffff80000010823c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000108240:	eb 22                	jmp    ffff800000108264 <fetchstr+0x85>
    if(*s == 0)
ffff800000108242:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108246:	0f b6 00             	movzbl (%rax),%eax
ffff800000108249:	84 c0                	test   %al,%al
ffff80000010824b:	75 12                	jne    ffff80000010825f <fetchstr+0x80>
      return s - *pp;
ffff80000010824d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000108251:	48 8b 00             	mov    (%rax),%rax
ffff800000108254:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000108258:	48 29 c2             	sub    %rax,%rdx
ffff80000010825b:	89 d0                	mov    %edx,%eax
ffff80000010825d:	eb 14                	jmp    ffff800000108273 <fetchstr+0x94>
  for(s = *pp; s < ep; s++)
ffff80000010825f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffff800000108264:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108268:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
ffff80000010826c:	72 d4                	jb     ffff800000108242 <fetchstr+0x63>
  return -1;
ffff80000010826e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000108273:	c9                   	leave
ffff800000108274:	c3                   	ret

ffff800000108275 <fetcharg>:

static addr_t
fetcharg(int n)
{
ffff800000108275:	f3 0f 1e fa          	endbr64
ffff800000108279:	55                   	push   %rbp
ffff80000010827a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010827d:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000108281:	89 7d fc             	mov    %edi,-0x4(%rbp)
  switch (n) {
ffff800000108284:	83 7d fc 05          	cmpl   $0x5,-0x4(%rbp)
ffff800000108288:	0f 87 9f 00 00 00    	ja     ffff80000010832d <fetcharg+0xb8>
ffff80000010828e:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000108291:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff800000108298:	00 
ffff800000108299:	48 b8 a8 c8 10 00 00 	movabs $0xffff80000010c8a8,%rax
ffff8000001082a0:	80 ff ff 
ffff8000001082a3:	48 01 d0             	add    %rdx,%rax
ffff8000001082a6:	48 8b 00             	mov    (%rax),%rax
ffff8000001082a9:	3e ff e0             	notrack jmp *%rax
  case 0: return proc->tf->rdi;
ffff8000001082ac:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001082b3:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001082b7:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001082bb:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff8000001082bf:	e9 82 00 00 00       	jmp    ffff800000108346 <fetcharg+0xd1>
  case 1: return proc->tf->rsi;
ffff8000001082c4:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001082cb:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001082cf:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001082d3:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001082d7:	eb 6d                	jmp    ffff800000108346 <fetcharg+0xd1>
  case 2: return proc->tf->rdx;
ffff8000001082d9:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001082e0:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001082e4:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001082e8:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff8000001082ec:	eb 58                	jmp    ffff800000108346 <fetcharg+0xd1>
  case 3: return proc->tf->r10;
ffff8000001082ee:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001082f5:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001082f9:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001082fd:	48 8b 40 48          	mov    0x48(%rax),%rax
ffff800000108301:	eb 43                	jmp    ffff800000108346 <fetcharg+0xd1>
  case 4: return proc->tf->r8;
ffff800000108303:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010830a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010830e:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000108312:	48 8b 40 38          	mov    0x38(%rax),%rax
ffff800000108316:	eb 2e                	jmp    ffff800000108346 <fetcharg+0xd1>
  case 5: return proc->tf->r9;
ffff800000108318:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010831f:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108323:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000108327:	48 8b 40 40          	mov    0x40(%rax),%rax
ffff80000010832b:	eb 19                	jmp    ffff800000108346 <fetcharg+0xd1>
  }
  panic("failed fetch");
ffff80000010832d:	48 b8 98 c8 10 00 00 	movabs $0xffff80000010c898,%rax
ffff800000108334:	80 ff ff 
ffff800000108337:	48 89 c7             	mov    %rax,%rdi
ffff80000010833a:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000108341:	80 ff ff 
ffff800000108344:	ff d0                	call   *%rax
}
ffff800000108346:	c9                   	leave
ffff800000108347:	c3                   	ret

ffff800000108348 <argint>:

int
argint(int n, int *ip)
{
ffff800000108348:	f3 0f 1e fa          	endbr64
ffff80000010834c:	55                   	push   %rbp
ffff80000010834d:	48 89 e5             	mov    %rsp,%rbp
ffff800000108350:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000108354:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff800000108357:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  *ip = fetcharg(n);
ffff80000010835b:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010835e:	89 c7                	mov    %eax,%edi
ffff800000108360:	48 b8 75 82 10 00 00 	movabs $0xffff800000108275,%rax
ffff800000108367:	80 ff ff 
ffff80000010836a:	ff d0                	call   *%rax
ffff80000010836c:	89 c2                	mov    %eax,%edx
ffff80000010836e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108372:	89 10                	mov    %edx,(%rax)
  return 0;
ffff800000108374:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000108379:	c9                   	leave
ffff80000010837a:	c3                   	ret

ffff80000010837b <argaddr>:

addr_t
argaddr(int n, addr_t *ip)
{
ffff80000010837b:	f3 0f 1e fa          	endbr64
ffff80000010837f:	55                   	push   %rbp
ffff800000108380:	48 89 e5             	mov    %rsp,%rbp
ffff800000108383:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000108387:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff80000010838a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  *ip = fetcharg(n);
ffff80000010838e:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000108391:	89 c7                	mov    %eax,%edi
ffff800000108393:	48 b8 75 82 10 00 00 	movabs $0xffff800000108275,%rax
ffff80000010839a:	80 ff ff 
ffff80000010839d:	ff d0                	call   *%rax
ffff80000010839f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff8000001083a3:	48 89 02             	mov    %rax,(%rdx)
  return 0;
ffff8000001083a6:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff8000001083ab:	c9                   	leave
ffff8000001083ac:	c3                   	ret

ffff8000001083ad <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
addr_t
argptr(int n, char **pp, int size)
{
ffff8000001083ad:	f3 0f 1e fa          	endbr64
ffff8000001083b1:	55                   	push   %rbp
ffff8000001083b2:	48 89 e5             	mov    %rsp,%rbp
ffff8000001083b5:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001083b9:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff8000001083bc:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff8000001083c0:	89 55 e8             	mov    %edx,-0x18(%rbp)
  addr_t i;

  if(argaddr(n, &i) < 0)
ffff8000001083c3:	48 8d 55 f8          	lea    -0x8(%rbp),%rdx
ffff8000001083c7:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001083ca:	48 89 d6             	mov    %rdx,%rsi
ffff8000001083cd:	89 c7                	mov    %eax,%edi
ffff8000001083cf:	48 b8 7b 83 10 00 00 	movabs $0xffff80000010837b,%rax
ffff8000001083d6:	80 ff ff 
ffff8000001083d9:	ff d0                	call   *%rax
    return -1;
  if(size < 0 || (uint)i >= proc->sz || (uint)i+size > proc->sz)
ffff8000001083db:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
ffff8000001083df:	78 39                	js     ffff80000010841a <argptr+0x6d>
ffff8000001083e1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001083e5:	89 c2                	mov    %eax,%edx
ffff8000001083e7:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001083ee:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001083f2:	48 8b 00             	mov    (%rax),%rax
ffff8000001083f5:	48 39 c2             	cmp    %rax,%rdx
ffff8000001083f8:	73 20                	jae    ffff80000010841a <argptr+0x6d>
ffff8000001083fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001083fe:	89 c2                	mov    %eax,%edx
ffff800000108400:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000108403:	01 d0                	add    %edx,%eax
ffff800000108405:	89 c2                	mov    %eax,%edx
ffff800000108407:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010840e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108412:	48 8b 00             	mov    (%rax),%rax
ffff800000108415:	48 39 d0             	cmp    %rdx,%rax
ffff800000108418:	73 09                	jae    ffff800000108423 <argptr+0x76>
    return -1;
ffff80000010841a:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
ffff800000108421:	eb 13                	jmp    ffff800000108436 <argptr+0x89>
  *pp = (char*)i;
ffff800000108423:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108427:	48 89 c2             	mov    %rax,%rdx
ffff80000010842a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010842e:	48 89 10             	mov    %rdx,(%rax)
  return 0;
ffff800000108431:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000108436:	c9                   	leave
ffff800000108437:	c3                   	ret

ffff800000108438 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
ffff800000108438:	f3 0f 1e fa          	endbr64
ffff80000010843c:	55                   	push   %rbp
ffff80000010843d:	48 89 e5             	mov    %rsp,%rbp
ffff800000108440:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000108444:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000108447:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int addr;
  if(argint(n, &addr) < 0)
ffff80000010844b:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
ffff80000010844f:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000108452:	48 89 d6             	mov    %rdx,%rsi
ffff800000108455:	89 c7                	mov    %eax,%edi
ffff800000108457:	48 b8 48 83 10 00 00 	movabs $0xffff800000108348,%rax
ffff80000010845e:	80 ff ff 
ffff800000108461:	ff d0                	call   *%rax
ffff800000108463:	85 c0                	test   %eax,%eax
ffff800000108465:	79 07                	jns    ffff80000010846e <argstr+0x36>
    return -1;
ffff800000108467:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010846c:	eb 1b                	jmp    ffff800000108489 <argstr+0x51>
  return fetchstr(addr, pp);
ffff80000010846e:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000108471:	48 98                	cltq
ffff800000108473:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000108477:	48 89 d6             	mov    %rdx,%rsi
ffff80000010847a:	48 89 c7             	mov    %rax,%rdi
ffff80000010847d:	48 b8 df 81 10 00 00 	movabs $0xffff8000001081df,%rax
ffff800000108484:	80 ff ff 
ffff800000108487:	ff d0                	call   *%rax
}
ffff800000108489:	c9                   	leave
ffff80000010848a:	c3                   	ret

ffff80000010848b <syscall>:
	[SYS_recv] sys_recv
};

void
syscall(struct trapframe *tf)
{
ffff80000010848b:	f3 0f 1e fa          	endbr64
ffff80000010848f:	55                   	push   %rbp
ffff800000108490:	48 89 e5             	mov    %rsp,%rbp
ffff800000108493:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000108497:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  proc->tf = tf;
ffff80000010849b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001084a2:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001084a6:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff8000001084aa:	48 89 50 28          	mov    %rdx,0x28(%rax)
  uint64 num = proc->tf->rax;
ffff8000001084ae:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001084b5:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001084b9:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001084bd:	48 8b 00             	mov    (%rax),%rax
ffff8000001084c0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if (num > 0 && num < NELEM(syscalls) && syscalls[num]) {
ffff8000001084c4:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff8000001084c9:	74 3b                	je     ffff800000108506 <syscall+0x7b>
ffff8000001084cb:	48 83 7d f8 17       	cmpq   $0x17,-0x8(%rbp)
ffff8000001084d0:	77 34                	ja     ffff800000108506 <syscall+0x7b>
ffff8000001084d2:	48 ba a0 d5 10 00 00 	movabs $0xffff80000010d5a0,%rdx
ffff8000001084d9:	80 ff ff 
ffff8000001084dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001084e0:	48 8b 04 c2          	mov    (%rdx,%rax,8),%rax
ffff8000001084e4:	48 85 c0             	test   %rax,%rax
ffff8000001084e7:	74 1d                	je     ffff800000108506 <syscall+0x7b>
    tf->rax = syscalls[num]();
ffff8000001084e9:	48 ba a0 d5 10 00 00 	movabs $0xffff80000010d5a0,%rdx
ffff8000001084f0:	80 ff ff 
ffff8000001084f3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001084f7:	48 8b 04 c2          	mov    (%rdx,%rax,8),%rax
ffff8000001084fb:	ff d0                	call   *%rax
ffff8000001084fd:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000108501:	48 89 02             	mov    %rax,(%rdx)
ffff800000108504:	eb 56                	jmp    ffff80000010855c <syscall+0xd1>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
ffff800000108506:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010850d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108511:	48 8d b0 d0 00 00 00 	lea    0xd0(%rax),%rsi
ffff800000108518:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010851f:	64 48 8b 00          	mov    %fs:(%rax),%rax
    cprintf("%d %s: unknown sys call %d\n",
ffff800000108523:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff800000108526:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010852a:	48 89 d1             	mov    %rdx,%rcx
ffff80000010852d:	48 89 f2             	mov    %rsi,%rdx
ffff800000108530:	89 c6                	mov    %eax,%esi
ffff800000108532:	48 b8 d8 c8 10 00 00 	movabs $0xffff80000010c8d8,%rax
ffff800000108539:	80 ff ff 
ffff80000010853c:	48 89 c7             	mov    %rax,%rdi
ffff80000010853f:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108544:	49 b8 38 08 10 00 00 	movabs $0xffff800000100838,%r8
ffff80000010854b:	80 ff ff 
ffff80000010854e:	41 ff d0             	call   *%r8
    tf->rax = -1;
ffff800000108551:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000108555:	48 c7 00 ff ff ff ff 	movq   $0xffffffffffffffff,(%rax)
  }
  if (proc->killed)
ffff80000010855c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108563:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108567:	8b 40 40             	mov    0x40(%rax),%eax
ffff80000010856a:	85 c0                	test   %eax,%eax
ffff80000010856c:	74 0c                	je     ffff80000010857a <syscall+0xef>
    exit();
ffff80000010856e:	48 b8 fd 69 10 00 00 	movabs $0xffff8000001069fd,%rax
ffff800000108575:	80 ff ff 
ffff800000108578:	ff d0                	call   *%rax
}
ffff80000010857a:	90                   	nop
ffff80000010857b:	c9                   	leave
ffff80000010857c:	c3                   	ret

ffff80000010857d <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
ffff80000010857d:	f3 0f 1e fa          	endbr64
ffff800000108581:	55                   	push   %rbp
ffff800000108582:	48 89 e5             	mov    %rsp,%rbp
ffff800000108585:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000108589:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff80000010858c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000108590:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
ffff800000108594:	48 8d 55 f4          	lea    -0xc(%rbp),%rdx
ffff800000108598:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff80000010859b:	48 89 d6             	mov    %rdx,%rsi
ffff80000010859e:	89 c7                	mov    %eax,%edi
ffff8000001085a0:	48 b8 48 83 10 00 00 	movabs $0xffff800000108348,%rax
ffff8000001085a7:	80 ff ff 
ffff8000001085aa:	ff d0                	call   *%rax
ffff8000001085ac:	85 c0                	test   %eax,%eax
ffff8000001085ae:	79 07                	jns    ffff8000001085b7 <argfd+0x3a>
    return -1;
ffff8000001085b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001085b5:	eb 62                	jmp    ffff800000108619 <argfd+0x9c>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
ffff8000001085b7:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff8000001085ba:	85 c0                	test   %eax,%eax
ffff8000001085bc:	78 2d                	js     ffff8000001085eb <argfd+0x6e>
ffff8000001085be:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff8000001085c1:	83 f8 0f             	cmp    $0xf,%eax
ffff8000001085c4:	7f 25                	jg     ffff8000001085eb <argfd+0x6e>
ffff8000001085c6:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001085cd:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001085d1:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff8000001085d4:	48 63 d2             	movslq %edx,%rdx
ffff8000001085d7:	48 83 c2 08          	add    $0x8,%rdx
ffff8000001085db:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff8000001085e0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001085e4:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff8000001085e9:	75 07                	jne    ffff8000001085f2 <argfd+0x75>
    return -1;
ffff8000001085eb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001085f0:	eb 27                	jmp    ffff800000108619 <argfd+0x9c>
  if(pfd)
ffff8000001085f2:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
ffff8000001085f7:	74 09                	je     ffff800000108602 <argfd+0x85>
    *pfd = fd;
ffff8000001085f9:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff8000001085fc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000108600:	89 10                	mov    %edx,(%rax)
  if(pf)
ffff800000108602:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
ffff800000108607:	74 0b                	je     ffff800000108614 <argfd+0x97>
    *pf = f;
ffff800000108609:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010860d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000108611:	48 89 10             	mov    %rdx,(%rax)
  return 0;
ffff800000108614:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000108619:	c9                   	leave
ffff80000010861a:	c3                   	ret

ffff80000010861b <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
ffff80000010861b:	f3 0f 1e fa          	endbr64
ffff80000010861f:	55                   	push   %rbp
ffff800000108620:	48 89 e5             	mov    %rsp,%rbp
ffff800000108623:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000108627:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
ffff80000010862b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000108632:	eb 46                	jmp    ffff80000010867a <fdalloc+0x5f>
    if(proc->ofile[fd] == 0){
ffff800000108634:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010863b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010863f:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000108642:	48 63 d2             	movslq %edx,%rdx
ffff800000108645:	48 83 c2 08          	add    $0x8,%rdx
ffff800000108649:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff80000010864e:	48 85 c0             	test   %rax,%rax
ffff800000108651:	75 23                	jne    ffff800000108676 <fdalloc+0x5b>
      proc->ofile[fd] = f;
ffff800000108653:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010865a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010865e:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000108661:	48 63 d2             	movslq %edx,%rdx
ffff800000108664:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
ffff800000108668:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff80000010866c:	48 89 54 c8 08       	mov    %rdx,0x8(%rax,%rcx,8)
      return fd;
ffff800000108671:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000108674:	eb 0f                	jmp    ffff800000108685 <fdalloc+0x6a>
  for(fd = 0; fd < NOFILE; fd++){
ffff800000108676:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff80000010867a:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
ffff80000010867e:	7e b4                	jle    ffff800000108634 <fdalloc+0x19>
    }
  }
  return -1;
ffff800000108680:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000108685:	c9                   	leave
ffff800000108686:	c3                   	ret

ffff800000108687 <sys_dup>:

int
sys_dup(void)
{
ffff800000108687:	f3 0f 1e fa          	endbr64
ffff80000010868b:	55                   	push   %rbp
ffff80000010868c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010868f:	48 83 ec 10          	sub    $0x10,%rsp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
ffff800000108693:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff800000108697:	48 89 c2             	mov    %rax,%rdx
ffff80000010869a:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010869f:	bf 00 00 00 00       	mov    $0x0,%edi
ffff8000001086a4:	48 b8 7d 85 10 00 00 	movabs $0xffff80000010857d,%rax
ffff8000001086ab:	80 ff ff 
ffff8000001086ae:	ff d0                	call   *%rax
ffff8000001086b0:	85 c0                	test   %eax,%eax
ffff8000001086b2:	79 07                	jns    ffff8000001086bb <sys_dup+0x34>
    return -1;
ffff8000001086b4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001086b9:	eb 39                	jmp    ffff8000001086f4 <sys_dup+0x6d>
  if((fd=fdalloc(f)) < 0)
ffff8000001086bb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001086bf:	48 89 c7             	mov    %rax,%rdi
ffff8000001086c2:	48 b8 1b 86 10 00 00 	movabs $0xffff80000010861b,%rax
ffff8000001086c9:	80 ff ff 
ffff8000001086cc:	ff d0                	call   *%rax
ffff8000001086ce:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff8000001086d1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff8000001086d5:	79 07                	jns    ffff8000001086de <sys_dup+0x57>
    return -1;
ffff8000001086d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001086dc:	eb 16                	jmp    ffff8000001086f4 <sys_dup+0x6d>
  filedup(f);
ffff8000001086de:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001086e2:	48 89 c7             	mov    %rax,%rdi
ffff8000001086e5:	48 b8 61 1c 10 00 00 	movabs $0xffff800000101c61,%rax
ffff8000001086ec:	80 ff ff 
ffff8000001086ef:	ff d0                	call   *%rax
  return fd;
ffff8000001086f1:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff8000001086f4:	c9                   	leave
ffff8000001086f5:	c3                   	ret

ffff8000001086f6 <sys_read>:

int
sys_read(void)
{
ffff8000001086f6:	f3 0f 1e fa          	endbr64
ffff8000001086fa:	55                   	push   %rbp
ffff8000001086fb:	48 89 e5             	mov    %rsp,%rbp
ffff8000001086fe:	48 83 ec 20          	sub    $0x20,%rsp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
ffff800000108702:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff800000108706:	48 89 c2             	mov    %rax,%rdx
ffff800000108709:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010870e:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000108713:	48 b8 7d 85 10 00 00 	movabs $0xffff80000010857d,%rax
ffff80000010871a:	80 ff ff 
ffff80000010871d:	ff d0                	call   *%rax
ffff80000010871f:	85 c0                	test   %eax,%eax
ffff800000108721:	78 56                	js     ffff800000108779 <sys_read+0x83>
ffff800000108723:	48 8d 45 f4          	lea    -0xc(%rbp),%rax
ffff800000108727:	48 89 c6             	mov    %rax,%rsi
ffff80000010872a:	bf 02 00 00 00       	mov    $0x2,%edi
ffff80000010872f:	48 b8 48 83 10 00 00 	movabs $0xffff800000108348,%rax
ffff800000108736:	80 ff ff 
ffff800000108739:	ff d0                	call   *%rax
ffff80000010873b:	85 c0                	test   %eax,%eax
ffff80000010873d:	78 3a                	js     ffff800000108779 <sys_read+0x83>
ffff80000010873f:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff800000108742:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffff800000108746:	48 89 c6             	mov    %rax,%rsi
ffff800000108749:	bf 01 00 00 00       	mov    $0x1,%edi
ffff80000010874e:	48 b8 ad 83 10 00 00 	movabs $0xffff8000001083ad,%rax
ffff800000108755:	80 ff ff 
ffff800000108758:	ff d0                	call   *%rax
    return -1;
  return fileread(f, p, n);
ffff80000010875a:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff80000010875d:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffff800000108761:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108765:	48 89 ce             	mov    %rcx,%rsi
ffff800000108768:	48 89 c7             	mov    %rax,%rdi
ffff80000010876b:	48 b8 a1 1e 10 00 00 	movabs $0xffff800000101ea1,%rax
ffff800000108772:	80 ff ff 
ffff800000108775:	ff d0                	call   *%rax
ffff800000108777:	eb 05                	jmp    ffff80000010877e <sys_read+0x88>
    return -1;
ffff800000108779:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff80000010877e:	c9                   	leave
ffff80000010877f:	c3                   	ret

ffff800000108780 <sys_write>:

int
sys_write(void)
{
ffff800000108780:	f3 0f 1e fa          	endbr64
ffff800000108784:	55                   	push   %rbp
ffff800000108785:	48 89 e5             	mov    %rsp,%rbp
ffff800000108788:	48 83 ec 20          	sub    $0x20,%rsp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
ffff80000010878c:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff800000108790:	48 89 c2             	mov    %rax,%rdx
ffff800000108793:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000108798:	bf 00 00 00 00       	mov    $0x0,%edi
ffff80000010879d:	48 b8 7d 85 10 00 00 	movabs $0xffff80000010857d,%rax
ffff8000001087a4:	80 ff ff 
ffff8000001087a7:	ff d0                	call   *%rax
ffff8000001087a9:	85 c0                	test   %eax,%eax
ffff8000001087ab:	78 56                	js     ffff800000108803 <sys_write+0x83>
ffff8000001087ad:	48 8d 45 f4          	lea    -0xc(%rbp),%rax
ffff8000001087b1:	48 89 c6             	mov    %rax,%rsi
ffff8000001087b4:	bf 02 00 00 00       	mov    $0x2,%edi
ffff8000001087b9:	48 b8 48 83 10 00 00 	movabs $0xffff800000108348,%rax
ffff8000001087c0:	80 ff ff 
ffff8000001087c3:	ff d0                	call   *%rax
ffff8000001087c5:	85 c0                	test   %eax,%eax
ffff8000001087c7:	78 3a                	js     ffff800000108803 <sys_write+0x83>
ffff8000001087c9:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff8000001087cc:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffff8000001087d0:	48 89 c6             	mov    %rax,%rsi
ffff8000001087d3:	bf 01 00 00 00       	mov    $0x1,%edi
ffff8000001087d8:	48 b8 ad 83 10 00 00 	movabs $0xffff8000001083ad,%rax
ffff8000001087df:	80 ff ff 
ffff8000001087e2:	ff d0                	call   *%rax
    return -1;
  return filewrite(f, p, n);
ffff8000001087e4:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff8000001087e7:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffff8000001087eb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001087ef:	48 89 ce             	mov    %rcx,%rsi
ffff8000001087f2:	48 89 c7             	mov    %rax,%rdi
ffff8000001087f5:	48 b8 99 1f 10 00 00 	movabs $0xffff800000101f99,%rax
ffff8000001087fc:	80 ff ff 
ffff8000001087ff:	ff d0                	call   *%rax
ffff800000108801:	eb 05                	jmp    ffff800000108808 <sys_write+0x88>
    return -1;
ffff800000108803:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000108808:	c9                   	leave
ffff800000108809:	c3                   	ret

ffff80000010880a <sys_close>:

int
sys_close(void)
{
ffff80000010880a:	f3 0f 1e fa          	endbr64
ffff80000010880e:	55                   	push   %rbp
ffff80000010880f:	48 89 e5             	mov    %rsp,%rbp
ffff800000108812:	48 83 ec 10          	sub    $0x10,%rsp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
ffff800000108816:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
ffff80000010881a:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
ffff80000010881e:	48 89 c6             	mov    %rax,%rsi
ffff800000108821:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000108826:	48 b8 7d 85 10 00 00 	movabs $0xffff80000010857d,%rax
ffff80000010882d:	80 ff ff 
ffff800000108830:	ff d0                	call   *%rax
ffff800000108832:	85 c0                	test   %eax,%eax
ffff800000108834:	79 07                	jns    ffff80000010883d <sys_close+0x33>
    return -1;
ffff800000108836:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010883b:	eb 36                	jmp    ffff800000108873 <sys_close+0x69>
  proc->ofile[fd] = 0;
ffff80000010883d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108844:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108848:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010884b:	48 63 d2             	movslq %edx,%rdx
ffff80000010884e:	48 83 c2 08          	add    $0x8,%rdx
ffff800000108852:	48 c7 44 d0 08 00 00 	movq   $0x0,0x8(%rax,%rdx,8)
ffff800000108859:	00 00 
  fileclose(f);
ffff80000010885b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010885f:	48 89 c7             	mov    %rax,%rdi
ffff800000108862:	48 b8 de 1c 10 00 00 	movabs $0xffff800000101cde,%rax
ffff800000108869:	80 ff ff 
ffff80000010886c:	ff d0                	call   *%rax
  return 0;
ffff80000010886e:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000108873:	c9                   	leave
ffff800000108874:	c3                   	ret

ffff800000108875 <sys_fstat>:

int
sys_fstat(void)
{
ffff800000108875:	f3 0f 1e fa          	endbr64
ffff800000108879:	55                   	push   %rbp
ffff80000010887a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010887d:	48 83 ec 10          	sub    $0x10,%rsp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
ffff800000108881:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff800000108885:	48 89 c2             	mov    %rax,%rdx
ffff800000108888:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010888d:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000108892:	48 b8 7d 85 10 00 00 	movabs $0xffff80000010857d,%rax
ffff800000108899:	80 ff ff 
ffff80000010889c:	ff d0                	call   *%rax
ffff80000010889e:	85 c0                	test   %eax,%eax
ffff8000001088a0:	78 39                	js     ffff8000001088db <sys_fstat+0x66>
ffff8000001088a2:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff8000001088a6:	ba 14 00 00 00       	mov    $0x14,%edx
ffff8000001088ab:	48 89 c6             	mov    %rax,%rsi
ffff8000001088ae:	bf 01 00 00 00       	mov    $0x1,%edi
ffff8000001088b3:	48 b8 ad 83 10 00 00 	movabs $0xffff8000001083ad,%rax
ffff8000001088ba:	80 ff ff 
ffff8000001088bd:	ff d0                	call   *%rax
    return -1;
  return filestat(f, st);
ffff8000001088bf:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff8000001088c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001088c7:	48 89 d6             	mov    %rdx,%rsi
ffff8000001088ca:	48 89 c7             	mov    %rax,%rdi
ffff8000001088cd:	48 b8 28 1e 10 00 00 	movabs $0xffff800000101e28,%rax
ffff8000001088d4:	80 ff ff 
ffff8000001088d7:	ff d0                	call   *%rax
ffff8000001088d9:	eb 05                	jmp    ffff8000001088e0 <sys_fstat+0x6b>
    return -1;
ffff8000001088db:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff8000001088e0:	c9                   	leave
ffff8000001088e1:	c3                   	ret

ffff8000001088e2 <isdirempty>:

static int
isdirempty(struct inode *dp)
{
ffff8000001088e2:	f3 0f 1e fa          	endbr64
ffff8000001088e6:	55                   	push   %rbp
ffff8000001088e7:	48 89 e5             	mov    %rsp,%rbp
ffff8000001088ea:	48 83 ec 30          	sub    $0x30,%rsp
ffff8000001088ee:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  int off;
  struct dirent de;
  // Is the directory dp empty except for "." and ".." ?
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
ffff8000001088f2:	c7 45 fc 20 00 00 00 	movl   $0x20,-0x4(%rbp)
ffff8000001088f9:	eb 56                	jmp    ffff800000108951 <isdirempty+0x6f>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffff8000001088fb:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001088fe:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffff800000108902:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000108906:	b9 10 00 00 00       	mov    $0x10,%ecx
ffff80000010890b:	48 89 c7             	mov    %rax,%rdi
ffff80000010890e:	48 b8 eb 2f 10 00 00 	movabs $0xffff800000102feb,%rax
ffff800000108915:	80 ff ff 
ffff800000108918:	ff d0                	call   *%rax
ffff80000010891a:	83 f8 10             	cmp    $0x10,%eax
ffff80000010891d:	74 19                	je     ffff800000108938 <isdirempty+0x56>
      panic("isdirempty: readi");
ffff80000010891f:	48 b8 f4 c8 10 00 00 	movabs $0xffff80000010c8f4,%rax
ffff800000108926:	80 ff ff 
ffff800000108929:	48 89 c7             	mov    %rax,%rdi
ffff80000010892c:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000108933:	80 ff ff 
ffff800000108936:	ff d0                	call   *%rax
    if(de.inum != 0)
ffff800000108938:	0f b7 45 e0          	movzwl -0x20(%rbp),%eax
ffff80000010893c:	66 85 c0             	test   %ax,%ax
ffff80000010893f:	74 07                	je     ffff800000108948 <isdirempty+0x66>
      return 0;
ffff800000108941:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108946:	eb 1f                	jmp    ffff800000108967 <isdirempty+0x85>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
ffff800000108948:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010894b:	83 c0 10             	add    $0x10,%eax
ffff80000010894e:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000108951:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000108955:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff80000010895b:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010895e:	39 c2                	cmp    %eax,%edx
ffff800000108960:	72 99                	jb     ffff8000001088fb <isdirempty+0x19>
  }
  return 1;
ffff800000108962:	b8 01 00 00 00       	mov    $0x1,%eax
}
ffff800000108967:	c9                   	leave
ffff800000108968:	c3                   	ret

ffff800000108969 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
ffff800000108969:	f3 0f 1e fa          	endbr64
ffff80000010896d:	55                   	push   %rbp
ffff80000010896e:	48 89 e5             	mov    %rsp,%rbp
ffff800000108971:	48 83 ec 30          	sub    $0x30,%rsp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
ffff800000108975:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffff800000108979:	48 89 c6             	mov    %rax,%rsi
ffff80000010897c:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000108981:	48 b8 38 84 10 00 00 	movabs $0xffff800000108438,%rax
ffff800000108988:	80 ff ff 
ffff80000010898b:	ff d0                	call   *%rax
ffff80000010898d:	85 c0                	test   %eax,%eax
ffff80000010898f:	78 1c                	js     ffff8000001089ad <sys_link+0x44>
ffff800000108991:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
ffff800000108995:	48 89 c6             	mov    %rax,%rsi
ffff800000108998:	bf 01 00 00 00       	mov    $0x1,%edi
ffff80000010899d:	48 b8 38 84 10 00 00 	movabs $0xffff800000108438,%rax
ffff8000001089a4:	80 ff ff 
ffff8000001089a7:	ff d0                	call   *%rax
ffff8000001089a9:	85 c0                	test   %eax,%eax
ffff8000001089ab:	79 0a                	jns    ffff8000001089b7 <sys_link+0x4e>
    return -1;
ffff8000001089ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001089b2:	e9 0c 02 00 00       	jmp    ffff800000108bc3 <sys_link+0x25a>

  begin_op();
ffff8000001089b7:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001089bc:	48 ba 70 50 10 00 00 	movabs $0xffff800000105070,%rdx
ffff8000001089c3:	80 ff ff 
ffff8000001089c6:	ff d2                	call   *%rdx
  if((ip = namei(old)) == 0){
ffff8000001089c8:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff8000001089cc:	48 89 c7             	mov    %rax,%rdi
ffff8000001089cf:	48 b8 a5 38 10 00 00 	movabs $0xffff8000001038a5,%rax
ffff8000001089d6:	80 ff ff 
ffff8000001089d9:	ff d0                	call   *%rax
ffff8000001089db:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001089df:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff8000001089e4:	75 1b                	jne    ffff800000108a01 <sys_link+0x98>
    end_op();
ffff8000001089e6:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001089eb:	48 ba 5c 51 10 00 00 	movabs $0xffff80000010515c,%rdx
ffff8000001089f2:	80 ff ff 
ffff8000001089f5:	ff d2                	call   *%rdx
    return -1;
ffff8000001089f7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001089fc:	e9 c2 01 00 00       	jmp    ffff800000108bc3 <sys_link+0x25a>
  }

  ilock(ip);
ffff800000108a01:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108a05:	48 89 c7             	mov    %rax,%rdi
ffff800000108a08:	48 b8 66 29 10 00 00 	movabs $0xffff800000102966,%rax
ffff800000108a0f:	80 ff ff 
ffff800000108a12:	ff d0                	call   *%rax
  if(ip->type == T_DIR){
ffff800000108a14:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108a18:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000108a1f:	66 83 f8 01          	cmp    $0x1,%ax
ffff800000108a23:	75 2e                	jne    ffff800000108a53 <sys_link+0xea>
    iunlockput(ip);
ffff800000108a25:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108a29:	48 89 c7             	mov    %rax,%rdi
ffff800000108a2c:	48 b8 6f 2c 10 00 00 	movabs $0xffff800000102c6f,%rax
ffff800000108a33:	80 ff ff 
ffff800000108a36:	ff d0                	call   *%rax
    end_op();
ffff800000108a38:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108a3d:	48 ba 5c 51 10 00 00 	movabs $0xffff80000010515c,%rdx
ffff800000108a44:	80 ff ff 
ffff800000108a47:	ff d2                	call   *%rdx
    return -1;
ffff800000108a49:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108a4e:	e9 70 01 00 00       	jmp    ffff800000108bc3 <sys_link+0x25a>
  }

  ip->nlink++;
ffff800000108a53:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108a57:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff800000108a5e:	83 c0 01             	add    $0x1,%eax
ffff800000108a61:	89 c2                	mov    %eax,%edx
ffff800000108a63:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108a67:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
  iupdate(ip);
ffff800000108a6e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108a72:	48 89 c7             	mov    %rax,%rdi
ffff800000108a75:	48 b8 b6 26 10 00 00 	movabs $0xffff8000001026b6,%rax
ffff800000108a7c:	80 ff ff 
ffff800000108a7f:	ff d0                	call   *%rax
  iunlock(ip);
ffff800000108a81:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108a85:	48 89 c7             	mov    %rax,%rdi
ffff800000108a88:	48 b8 01 2b 10 00 00 	movabs $0xffff800000102b01,%rax
ffff800000108a8f:	80 ff ff 
ffff800000108a92:	ff d0                	call   *%rax

  if((dp = nameiparent(new, name)) == 0)
ffff800000108a94:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000108a98:	48 8d 55 e2          	lea    -0x1e(%rbp),%rdx
ffff800000108a9c:	48 89 d6             	mov    %rdx,%rsi
ffff800000108a9f:	48 89 c7             	mov    %rax,%rdi
ffff800000108aa2:	48 b8 d3 38 10 00 00 	movabs $0xffff8000001038d3,%rax
ffff800000108aa9:	80 ff ff 
ffff800000108aac:	ff d0                	call   *%rax
ffff800000108aae:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000108ab2:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000108ab7:	0f 84 9b 00 00 00    	je     ffff800000108b58 <sys_link+0x1ef>
    goto bad;
  ilock(dp);
ffff800000108abd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108ac1:	48 89 c7             	mov    %rax,%rdi
ffff800000108ac4:	48 b8 66 29 10 00 00 	movabs $0xffff800000102966,%rax
ffff800000108acb:	80 ff ff 
ffff800000108ace:	ff d0                	call   *%rax
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
ffff800000108ad0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108ad4:	8b 10                	mov    (%rax),%edx
ffff800000108ad6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108ada:	8b 00                	mov    (%rax),%eax
ffff800000108adc:	39 c2                	cmp    %eax,%edx
ffff800000108ade:	75 25                	jne    ffff800000108b05 <sys_link+0x19c>
ffff800000108ae0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108ae4:	8b 50 04             	mov    0x4(%rax),%edx
ffff800000108ae7:	48 8d 4d e2          	lea    -0x1e(%rbp),%rcx
ffff800000108aeb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108aef:	48 89 ce             	mov    %rcx,%rsi
ffff800000108af2:	48 89 c7             	mov    %rax,%rdi
ffff800000108af5:	48 b8 0f 35 10 00 00 	movabs $0xffff80000010350f,%rax
ffff800000108afc:	80 ff ff 
ffff800000108aff:	ff d0                	call   *%rax
ffff800000108b01:	85 c0                	test   %eax,%eax
ffff800000108b03:	79 15                	jns    ffff800000108b1a <sys_link+0x1b1>
    iunlockput(dp);
ffff800000108b05:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108b09:	48 89 c7             	mov    %rax,%rdi
ffff800000108b0c:	48 b8 6f 2c 10 00 00 	movabs $0xffff800000102c6f,%rax
ffff800000108b13:	80 ff ff 
ffff800000108b16:	ff d0                	call   *%rax
    goto bad;
ffff800000108b18:	eb 3f                	jmp    ffff800000108b59 <sys_link+0x1f0>
  }
  iunlockput(dp);
ffff800000108b1a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108b1e:	48 89 c7             	mov    %rax,%rdi
ffff800000108b21:	48 b8 6f 2c 10 00 00 	movabs $0xffff800000102c6f,%rax
ffff800000108b28:	80 ff ff 
ffff800000108b2b:	ff d0                	call   *%rax
  iput(ip);
ffff800000108b2d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108b31:	48 89 c7             	mov    %rax,%rdi
ffff800000108b34:	48 b8 71 2b 10 00 00 	movabs $0xffff800000102b71,%rax
ffff800000108b3b:	80 ff ff 
ffff800000108b3e:	ff d0                	call   *%rax

  end_op();
ffff800000108b40:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108b45:	48 ba 5c 51 10 00 00 	movabs $0xffff80000010515c,%rdx
ffff800000108b4c:	80 ff ff 
ffff800000108b4f:	ff d2                	call   *%rdx

  return 0;
ffff800000108b51:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108b56:	eb 6b                	jmp    ffff800000108bc3 <sys_link+0x25a>
    goto bad;
ffff800000108b58:	90                   	nop

bad:
  ilock(ip);
ffff800000108b59:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108b5d:	48 89 c7             	mov    %rax,%rdi
ffff800000108b60:	48 b8 66 29 10 00 00 	movabs $0xffff800000102966,%rax
ffff800000108b67:	80 ff ff 
ffff800000108b6a:	ff d0                	call   *%rax
  ip->nlink--;
ffff800000108b6c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108b70:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff800000108b77:	83 e8 01             	sub    $0x1,%eax
ffff800000108b7a:	89 c2                	mov    %eax,%edx
ffff800000108b7c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108b80:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
  iupdate(ip);
ffff800000108b87:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108b8b:	48 89 c7             	mov    %rax,%rdi
ffff800000108b8e:	48 b8 b6 26 10 00 00 	movabs $0xffff8000001026b6,%rax
ffff800000108b95:	80 ff ff 
ffff800000108b98:	ff d0                	call   *%rax
  iunlockput(ip);
ffff800000108b9a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108b9e:	48 89 c7             	mov    %rax,%rdi
ffff800000108ba1:	48 b8 6f 2c 10 00 00 	movabs $0xffff800000102c6f,%rax
ffff800000108ba8:	80 ff ff 
ffff800000108bab:	ff d0                	call   *%rax
  end_op();
ffff800000108bad:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108bb2:	48 ba 5c 51 10 00 00 	movabs $0xffff80000010515c,%rdx
ffff800000108bb9:	80 ff ff 
ffff800000108bbc:	ff d2                	call   *%rdx
  return -1;
ffff800000108bbe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000108bc3:	c9                   	leave
ffff800000108bc4:	c3                   	ret

ffff800000108bc5 <sys_unlink>:
//PAGEBREAK!

int
sys_unlink(void)
{
ffff800000108bc5:	f3 0f 1e fa          	endbr64
ffff800000108bc9:	55                   	push   %rbp
ffff800000108bca:	48 89 e5             	mov    %rsp,%rbp
ffff800000108bcd:	48 83 ec 40          	sub    $0x40,%rsp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
ffff800000108bd1:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
ffff800000108bd5:	48 89 c6             	mov    %rax,%rsi
ffff800000108bd8:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000108bdd:	48 b8 38 84 10 00 00 	movabs $0xffff800000108438,%rax
ffff800000108be4:	80 ff ff 
ffff800000108be7:	ff d0                	call   *%rax
ffff800000108be9:	85 c0                	test   %eax,%eax
ffff800000108beb:	79 0a                	jns    ffff800000108bf7 <sys_unlink+0x32>
    return -1;
ffff800000108bed:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108bf2:	e9 8f 02 00 00       	jmp    ffff800000108e86 <sys_unlink+0x2c1>

  begin_op();
ffff800000108bf7:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108bfc:	48 ba 70 50 10 00 00 	movabs $0xffff800000105070,%rdx
ffff800000108c03:	80 ff ff 
ffff800000108c06:	ff d2                	call   *%rdx
  if((dp = nameiparent(path, name)) == 0){
ffff800000108c08:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff800000108c0c:	48 8d 55 d2          	lea    -0x2e(%rbp),%rdx
ffff800000108c10:	48 89 d6             	mov    %rdx,%rsi
ffff800000108c13:	48 89 c7             	mov    %rax,%rdi
ffff800000108c16:	48 b8 d3 38 10 00 00 	movabs $0xffff8000001038d3,%rax
ffff800000108c1d:	80 ff ff 
ffff800000108c20:	ff d0                	call   *%rax
ffff800000108c22:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000108c26:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000108c2b:	75 1b                	jne    ffff800000108c48 <sys_unlink+0x83>
    end_op();
ffff800000108c2d:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108c32:	48 ba 5c 51 10 00 00 	movabs $0xffff80000010515c,%rdx
ffff800000108c39:	80 ff ff 
ffff800000108c3c:	ff d2                	call   *%rdx
    return -1;
ffff800000108c3e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108c43:	e9 3e 02 00 00       	jmp    ffff800000108e86 <sys_unlink+0x2c1>
  }

  ilock(dp);
ffff800000108c48:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108c4c:	48 89 c7             	mov    %rax,%rdi
ffff800000108c4f:	48 b8 66 29 10 00 00 	movabs $0xffff800000102966,%rax
ffff800000108c56:	80 ff ff 
ffff800000108c59:	ff d0                	call   *%rax

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
ffff800000108c5b:	48 8d 45 d2          	lea    -0x2e(%rbp),%rax
ffff800000108c5f:	48 ba 06 c9 10 00 00 	movabs $0xffff80000010c906,%rdx
ffff800000108c66:	80 ff ff 
ffff800000108c69:	48 89 d6             	mov    %rdx,%rsi
ffff800000108c6c:	48 89 c7             	mov    %rax,%rdi
ffff800000108c6f:	48 b8 d0 33 10 00 00 	movabs $0xffff8000001033d0,%rax
ffff800000108c76:	80 ff ff 
ffff800000108c79:	ff d0                	call   *%rax
ffff800000108c7b:	85 c0                	test   %eax,%eax
ffff800000108c7d:	0f 84 d6 01 00 00    	je     ffff800000108e59 <sys_unlink+0x294>
ffff800000108c83:	48 8d 45 d2          	lea    -0x2e(%rbp),%rax
ffff800000108c87:	48 ba 08 c9 10 00 00 	movabs $0xffff80000010c908,%rdx
ffff800000108c8e:	80 ff ff 
ffff800000108c91:	48 89 d6             	mov    %rdx,%rsi
ffff800000108c94:	48 89 c7             	mov    %rax,%rdi
ffff800000108c97:	48 b8 d0 33 10 00 00 	movabs $0xffff8000001033d0,%rax
ffff800000108c9e:	80 ff ff 
ffff800000108ca1:	ff d0                	call   *%rax
ffff800000108ca3:	85 c0                	test   %eax,%eax
ffff800000108ca5:	0f 84 ae 01 00 00    	je     ffff800000108e59 <sys_unlink+0x294>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
ffff800000108cab:	48 8d 55 c4          	lea    -0x3c(%rbp),%rdx
ffff800000108caf:	48 8d 4d d2          	lea    -0x2e(%rbp),%rcx
ffff800000108cb3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108cb7:	48 89 ce             	mov    %rcx,%rsi
ffff800000108cba:	48 89 c7             	mov    %rax,%rdi
ffff800000108cbd:	48 b8 05 34 10 00 00 	movabs $0xffff800000103405,%rax
ffff800000108cc4:	80 ff ff 
ffff800000108cc7:	ff d0                	call   *%rax
ffff800000108cc9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000108ccd:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000108cd2:	0f 84 84 01 00 00    	je     ffff800000108e5c <sys_unlink+0x297>
    goto bad;
  ilock(ip);
ffff800000108cd8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108cdc:	48 89 c7             	mov    %rax,%rdi
ffff800000108cdf:	48 b8 66 29 10 00 00 	movabs $0xffff800000102966,%rax
ffff800000108ce6:	80 ff ff 
ffff800000108ce9:	ff d0                	call   *%rax

  if(ip->nlink < 1)
ffff800000108ceb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108cef:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff800000108cf6:	66 85 c0             	test   %ax,%ax
ffff800000108cf9:	7f 19                	jg     ffff800000108d14 <sys_unlink+0x14f>
    panic("unlink: nlink < 1");
ffff800000108cfb:	48 b8 0b c9 10 00 00 	movabs $0xffff80000010c90b,%rax
ffff800000108d02:	80 ff ff 
ffff800000108d05:	48 89 c7             	mov    %rax,%rdi
ffff800000108d08:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000108d0f:	80 ff ff 
ffff800000108d12:	ff d0                	call   *%rax
  if(ip->type == T_DIR && !isdirempty(ip)){
ffff800000108d14:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108d18:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000108d1f:	66 83 f8 01          	cmp    $0x1,%ax
ffff800000108d23:	75 2f                	jne    ffff800000108d54 <sys_unlink+0x18f>
ffff800000108d25:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108d29:	48 89 c7             	mov    %rax,%rdi
ffff800000108d2c:	48 b8 e2 88 10 00 00 	movabs $0xffff8000001088e2,%rax
ffff800000108d33:	80 ff ff 
ffff800000108d36:	ff d0                	call   *%rax
ffff800000108d38:	85 c0                	test   %eax,%eax
ffff800000108d3a:	75 18                	jne    ffff800000108d54 <sys_unlink+0x18f>
    iunlockput(ip);
ffff800000108d3c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108d40:	48 89 c7             	mov    %rax,%rdi
ffff800000108d43:	48 b8 6f 2c 10 00 00 	movabs $0xffff800000102c6f,%rax
ffff800000108d4a:	80 ff ff 
ffff800000108d4d:	ff d0                	call   *%rax
    goto bad;
ffff800000108d4f:	e9 09 01 00 00       	jmp    ffff800000108e5d <sys_unlink+0x298>
  }

  memset(&de, 0, sizeof(de));
ffff800000108d54:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff800000108d58:	ba 10 00 00 00       	mov    $0x10,%edx
ffff800000108d5d:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000108d62:	48 89 c7             	mov    %rax,%rdi
ffff800000108d65:	48 b8 87 7d 10 00 00 	movabs $0xffff800000107d87,%rax
ffff800000108d6c:	80 ff ff 
ffff800000108d6f:	ff d0                	call   *%rax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffff800000108d71:	8b 55 c4             	mov    -0x3c(%rbp),%edx
ffff800000108d74:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffff800000108d78:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108d7c:	b9 10 00 00 00       	mov    $0x10,%ecx
ffff800000108d81:	48 89 c7             	mov    %rax,%rdi
ffff800000108d84:	48 b8 bc 31 10 00 00 	movabs $0xffff8000001031bc,%rax
ffff800000108d8b:	80 ff ff 
ffff800000108d8e:	ff d0                	call   *%rax
ffff800000108d90:	83 f8 10             	cmp    $0x10,%eax
ffff800000108d93:	74 19                	je     ffff800000108dae <sys_unlink+0x1e9>
    panic("unlink: writei");
ffff800000108d95:	48 b8 1d c9 10 00 00 	movabs $0xffff80000010c91d,%rax
ffff800000108d9c:	80 ff ff 
ffff800000108d9f:	48 89 c7             	mov    %rax,%rdi
ffff800000108da2:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000108da9:	80 ff ff 
ffff800000108dac:	ff d0                	call   *%rax
  if(ip->type == T_DIR){
ffff800000108dae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108db2:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000108db9:	66 83 f8 01          	cmp    $0x1,%ax
ffff800000108dbd:	75 2e                	jne    ffff800000108ded <sys_unlink+0x228>
    dp->nlink--;
ffff800000108dbf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108dc3:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff800000108dca:	83 e8 01             	sub    $0x1,%eax
ffff800000108dcd:	89 c2                	mov    %eax,%edx
ffff800000108dcf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108dd3:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
    iupdate(dp);
ffff800000108dda:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108dde:	48 89 c7             	mov    %rax,%rdi
ffff800000108de1:	48 b8 b6 26 10 00 00 	movabs $0xffff8000001026b6,%rax
ffff800000108de8:	80 ff ff 
ffff800000108deb:	ff d0                	call   *%rax
  }
  iunlockput(dp);
ffff800000108ded:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108df1:	48 89 c7             	mov    %rax,%rdi
ffff800000108df4:	48 b8 6f 2c 10 00 00 	movabs $0xffff800000102c6f,%rax
ffff800000108dfb:	80 ff ff 
ffff800000108dfe:	ff d0                	call   *%rax

  ip->nlink--;
ffff800000108e00:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108e04:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff800000108e0b:	83 e8 01             	sub    $0x1,%eax
ffff800000108e0e:	89 c2                	mov    %eax,%edx
ffff800000108e10:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108e14:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
  iupdate(ip);
ffff800000108e1b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108e1f:	48 89 c7             	mov    %rax,%rdi
ffff800000108e22:	48 b8 b6 26 10 00 00 	movabs $0xffff8000001026b6,%rax
ffff800000108e29:	80 ff ff 
ffff800000108e2c:	ff d0                	call   *%rax
  iunlockput(ip);
ffff800000108e2e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108e32:	48 89 c7             	mov    %rax,%rdi
ffff800000108e35:	48 b8 6f 2c 10 00 00 	movabs $0xffff800000102c6f,%rax
ffff800000108e3c:	80 ff ff 
ffff800000108e3f:	ff d0                	call   *%rax

  end_op();
ffff800000108e41:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108e46:	48 ba 5c 51 10 00 00 	movabs $0xffff80000010515c,%rdx
ffff800000108e4d:	80 ff ff 
ffff800000108e50:	ff d2                	call   *%rdx

  return 0;
ffff800000108e52:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108e57:	eb 2d                	jmp    ffff800000108e86 <sys_unlink+0x2c1>
    goto bad;
ffff800000108e59:	90                   	nop
ffff800000108e5a:	eb 01                	jmp    ffff800000108e5d <sys_unlink+0x298>
    goto bad;
ffff800000108e5c:	90                   	nop

bad:
  iunlockput(dp);
ffff800000108e5d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108e61:	48 89 c7             	mov    %rax,%rdi
ffff800000108e64:	48 b8 6f 2c 10 00 00 	movabs $0xffff800000102c6f,%rax
ffff800000108e6b:	80 ff ff 
ffff800000108e6e:	ff d0                	call   *%rax
  end_op();
ffff800000108e70:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108e75:	48 ba 5c 51 10 00 00 	movabs $0xffff80000010515c,%rdx
ffff800000108e7c:	80 ff ff 
ffff800000108e7f:	ff d2                	call   *%rdx
  return -1;
ffff800000108e81:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000108e86:	c9                   	leave
ffff800000108e87:	c3                   	ret

ffff800000108e88 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
ffff800000108e88:	f3 0f 1e fa          	endbr64
ffff800000108e8c:	55                   	push   %rbp
ffff800000108e8d:	48 89 e5             	mov    %rsp,%rbp
ffff800000108e90:	48 83 ec 50          	sub    $0x50,%rsp
ffff800000108e94:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
ffff800000108e98:	89 c8                	mov    %ecx,%eax
ffff800000108e9a:	89 f1                	mov    %esi,%ecx
ffff800000108e9c:	66 89 4d c4          	mov    %cx,-0x3c(%rbp)
ffff800000108ea0:	66 89 55 c0          	mov    %dx,-0x40(%rbp)
ffff800000108ea4:	66 89 45 bc          	mov    %ax,-0x44(%rbp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
ffff800000108ea8:	48 8d 55 de          	lea    -0x22(%rbp),%rdx
ffff800000108eac:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff800000108eb0:	48 89 d6             	mov    %rdx,%rsi
ffff800000108eb3:	48 89 c7             	mov    %rax,%rdi
ffff800000108eb6:	48 b8 d3 38 10 00 00 	movabs $0xffff8000001038d3,%rax
ffff800000108ebd:	80 ff ff 
ffff800000108ec0:	ff d0                	call   *%rax
ffff800000108ec2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000108ec6:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000108ecb:	75 0a                	jne    ffff800000108ed7 <create+0x4f>
    return 0;
ffff800000108ecd:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108ed2:	e9 2c 02 00 00       	jmp    ffff800000109103 <create+0x27b>
  ilock(dp);
ffff800000108ed7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108edb:	48 89 c7             	mov    %rax,%rdi
ffff800000108ede:	48 b8 66 29 10 00 00 	movabs $0xffff800000102966,%rax
ffff800000108ee5:	80 ff ff 
ffff800000108ee8:	ff d0                	call   *%rax

  if((ip = dirlookup(dp, name, &off)) != 0){
ffff800000108eea:	48 8d 55 ec          	lea    -0x14(%rbp),%rdx
ffff800000108eee:	48 8d 4d de          	lea    -0x22(%rbp),%rcx
ffff800000108ef2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108ef6:	48 89 ce             	mov    %rcx,%rsi
ffff800000108ef9:	48 89 c7             	mov    %rax,%rdi
ffff800000108efc:	48 b8 05 34 10 00 00 	movabs $0xffff800000103405,%rax
ffff800000108f03:	80 ff ff 
ffff800000108f06:	ff d0                	call   *%rax
ffff800000108f08:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000108f0c:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000108f11:	74 64                	je     ffff800000108f77 <create+0xef>
    iunlockput(dp);
ffff800000108f13:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108f17:	48 89 c7             	mov    %rax,%rdi
ffff800000108f1a:	48 b8 6f 2c 10 00 00 	movabs $0xffff800000102c6f,%rax
ffff800000108f21:	80 ff ff 
ffff800000108f24:	ff d0                	call   *%rax
    ilock(ip);
ffff800000108f26:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108f2a:	48 89 c7             	mov    %rax,%rdi
ffff800000108f2d:	48 b8 66 29 10 00 00 	movabs $0xffff800000102966,%rax
ffff800000108f34:	80 ff ff 
ffff800000108f37:	ff d0                	call   *%rax
    if(type == T_FILE && ip->type == T_FILE)
ffff800000108f39:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%rbp)
ffff800000108f3e:	75 1a                	jne    ffff800000108f5a <create+0xd2>
ffff800000108f40:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108f44:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000108f4b:	66 83 f8 02          	cmp    $0x2,%ax
ffff800000108f4f:	75 09                	jne    ffff800000108f5a <create+0xd2>
      return ip;
ffff800000108f51:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108f55:	e9 a9 01 00 00       	jmp    ffff800000109103 <create+0x27b>
    iunlockput(ip);
ffff800000108f5a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108f5e:	48 89 c7             	mov    %rax,%rdi
ffff800000108f61:	48 b8 6f 2c 10 00 00 	movabs $0xffff800000102c6f,%rax
ffff800000108f68:	80 ff ff 
ffff800000108f6b:	ff d0                	call   *%rax
    return 0;
ffff800000108f6d:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108f72:	e9 8c 01 00 00       	jmp    ffff800000109103 <create+0x27b>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
ffff800000108f77:	0f bf 55 c4          	movswl -0x3c(%rbp),%edx
ffff800000108f7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108f7f:	8b 00                	mov    (%rax),%eax
ffff800000108f81:	89 d6                	mov    %edx,%esi
ffff800000108f83:	89 c7                	mov    %eax,%edi
ffff800000108f85:	48 b8 8a 25 10 00 00 	movabs $0xffff80000010258a,%rax
ffff800000108f8c:	80 ff ff 
ffff800000108f8f:	ff d0                	call   *%rax
ffff800000108f91:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000108f95:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000108f9a:	75 19                	jne    ffff800000108fb5 <create+0x12d>
    panic("create: ialloc");
ffff800000108f9c:	48 b8 2c c9 10 00 00 	movabs $0xffff80000010c92c,%rax
ffff800000108fa3:	80 ff ff 
ffff800000108fa6:	48 89 c7             	mov    %rax,%rdi
ffff800000108fa9:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff800000108fb0:	80 ff ff 
ffff800000108fb3:	ff d0                	call   *%rax

  ilock(ip);
ffff800000108fb5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108fb9:	48 89 c7             	mov    %rax,%rdi
ffff800000108fbc:	48 b8 66 29 10 00 00 	movabs $0xffff800000102966,%rax
ffff800000108fc3:	80 ff ff 
ffff800000108fc6:	ff d0                	call   *%rax
  ip->major = major;
ffff800000108fc8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108fcc:	0f b7 55 c0          	movzwl -0x40(%rbp),%edx
ffff800000108fd0:	66 89 90 96 00 00 00 	mov    %dx,0x96(%rax)
  ip->minor = minor;
ffff800000108fd7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108fdb:	0f b7 55 bc          	movzwl -0x44(%rbp),%edx
ffff800000108fdf:	66 89 90 98 00 00 00 	mov    %dx,0x98(%rax)
  ip->nlink = 1;
ffff800000108fe6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108fea:	66 c7 80 9a 00 00 00 	movw   $0x1,0x9a(%rax)
ffff800000108ff1:	01 00 
  iupdate(ip);
ffff800000108ff3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108ff7:	48 89 c7             	mov    %rax,%rdi
ffff800000108ffa:	48 b8 b6 26 10 00 00 	movabs $0xffff8000001026b6,%rax
ffff800000109001:	80 ff ff 
ffff800000109004:	ff d0                	call   *%rax

  if(type == T_DIR){  // Create . and .. entries.
ffff800000109006:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%rbp)
ffff80000010900b:	0f 85 9d 00 00 00    	jne    ffff8000001090ae <create+0x226>
    dp->nlink++;  // for ".."
ffff800000109011:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109015:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff80000010901c:	83 c0 01             	add    $0x1,%eax
ffff80000010901f:	89 c2                	mov    %eax,%edx
ffff800000109021:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109025:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
    iupdate(dp);
ffff80000010902c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109030:	48 89 c7             	mov    %rax,%rdi
ffff800000109033:	48 b8 b6 26 10 00 00 	movabs $0xffff8000001026b6,%rax
ffff80000010903a:	80 ff ff 
ffff80000010903d:	ff d0                	call   *%rax
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
ffff80000010903f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109043:	8b 50 04             	mov    0x4(%rax),%edx
ffff800000109046:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010904a:	48 b9 06 c9 10 00 00 	movabs $0xffff80000010c906,%rcx
ffff800000109051:	80 ff ff 
ffff800000109054:	48 89 ce             	mov    %rcx,%rsi
ffff800000109057:	48 89 c7             	mov    %rax,%rdi
ffff80000010905a:	48 b8 0f 35 10 00 00 	movabs $0xffff80000010350f,%rax
ffff800000109061:	80 ff ff 
ffff800000109064:	ff d0                	call   *%rax
ffff800000109066:	85 c0                	test   %eax,%eax
ffff800000109068:	78 2b                	js     ffff800000109095 <create+0x20d>
ffff80000010906a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010906e:	8b 50 04             	mov    0x4(%rax),%edx
ffff800000109071:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109075:	48 b9 08 c9 10 00 00 	movabs $0xffff80000010c908,%rcx
ffff80000010907c:	80 ff ff 
ffff80000010907f:	48 89 ce             	mov    %rcx,%rsi
ffff800000109082:	48 89 c7             	mov    %rax,%rdi
ffff800000109085:	48 b8 0f 35 10 00 00 	movabs $0xffff80000010350f,%rax
ffff80000010908c:	80 ff ff 
ffff80000010908f:	ff d0                	call   *%rax
ffff800000109091:	85 c0                	test   %eax,%eax
ffff800000109093:	79 19                	jns    ffff8000001090ae <create+0x226>
      panic("create dots");
ffff800000109095:	48 b8 3b c9 10 00 00 	movabs $0xffff80000010c93b,%rax
ffff80000010909c:	80 ff ff 
ffff80000010909f:	48 89 c7             	mov    %rax,%rdi
ffff8000001090a2:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff8000001090a9:	80 ff ff 
ffff8000001090ac:	ff d0                	call   *%rax
  }

  if(dirlink(dp, name, ip->inum) < 0)
ffff8000001090ae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001090b2:	8b 50 04             	mov    0x4(%rax),%edx
ffff8000001090b5:	48 8d 4d de          	lea    -0x22(%rbp),%rcx
ffff8000001090b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001090bd:	48 89 ce             	mov    %rcx,%rsi
ffff8000001090c0:	48 89 c7             	mov    %rax,%rdi
ffff8000001090c3:	48 b8 0f 35 10 00 00 	movabs $0xffff80000010350f,%rax
ffff8000001090ca:	80 ff ff 
ffff8000001090cd:	ff d0                	call   *%rax
ffff8000001090cf:	85 c0                	test   %eax,%eax
ffff8000001090d1:	79 19                	jns    ffff8000001090ec <create+0x264>
    panic("create: dirlink");
ffff8000001090d3:	48 b8 47 c9 10 00 00 	movabs $0xffff80000010c947,%rax
ffff8000001090da:	80 ff ff 
ffff8000001090dd:	48 89 c7             	mov    %rax,%rdi
ffff8000001090e0:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff8000001090e7:	80 ff ff 
ffff8000001090ea:	ff d0                	call   *%rax

  iunlockput(dp);
ffff8000001090ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001090f0:	48 89 c7             	mov    %rax,%rdi
ffff8000001090f3:	48 b8 6f 2c 10 00 00 	movabs $0xffff800000102c6f,%rax
ffff8000001090fa:	80 ff ff 
ffff8000001090fd:	ff d0                	call   *%rax

  return ip;
ffff8000001090ff:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
}
ffff800000109103:	c9                   	leave
ffff800000109104:	c3                   	ret

ffff800000109105 <sys_open>:

int
sys_open(void)
{
ffff800000109105:	f3 0f 1e fa          	endbr64
ffff800000109109:	55                   	push   %rbp
ffff80000010910a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010910d:	48 83 ec 30          	sub    $0x30,%rsp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
ffff800000109111:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff800000109115:	48 89 c6             	mov    %rax,%rsi
ffff800000109118:	bf 00 00 00 00       	mov    $0x0,%edi
ffff80000010911d:	48 b8 38 84 10 00 00 	movabs $0xffff800000108438,%rax
ffff800000109124:	80 ff ff 
ffff800000109127:	ff d0                	call   *%rax
ffff800000109129:	85 c0                	test   %eax,%eax
ffff80000010912b:	78 1c                	js     ffff800000109149 <sys_open+0x44>
ffff80000010912d:	48 8d 45 dc          	lea    -0x24(%rbp),%rax
ffff800000109131:	48 89 c6             	mov    %rax,%rsi
ffff800000109134:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000109139:	48 b8 48 83 10 00 00 	movabs $0xffff800000108348,%rax
ffff800000109140:	80 ff ff 
ffff800000109143:	ff d0                	call   *%rax
ffff800000109145:	85 c0                	test   %eax,%eax
ffff800000109147:	79 0a                	jns    ffff800000109153 <sys_open+0x4e>
    return -1;
ffff800000109149:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010914e:	e9 fb 01 00 00       	jmp    ffff80000010934e <sys_open+0x249>

  begin_op();
ffff800000109153:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109158:	48 ba 70 50 10 00 00 	movabs $0xffff800000105070,%rdx
ffff80000010915f:	80 ff ff 
ffff800000109162:	ff d2                	call   *%rdx

  if(omode & O_CREATE){
ffff800000109164:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000109167:	25 00 02 00 00       	and    $0x200,%eax
ffff80000010916c:	85 c0                	test   %eax,%eax
ffff80000010916e:	74 4c                	je     ffff8000001091bc <sys_open+0xb7>
    ip = create(path, T_FILE, 0, 0);
ffff800000109170:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000109174:	b9 00 00 00 00       	mov    $0x0,%ecx
ffff800000109179:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010917e:	be 02 00 00 00       	mov    $0x2,%esi
ffff800000109183:	48 89 c7             	mov    %rax,%rdi
ffff800000109186:	48 b8 88 8e 10 00 00 	movabs $0xffff800000108e88,%rax
ffff80000010918d:	80 ff ff 
ffff800000109190:	ff d0                	call   *%rax
ffff800000109192:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(ip == 0){
ffff800000109196:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff80000010919b:	0f 85 ad 00 00 00    	jne    ffff80000010924e <sys_open+0x149>
      end_op();
ffff8000001091a1:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001091a6:	48 ba 5c 51 10 00 00 	movabs $0xffff80000010515c,%rdx
ffff8000001091ad:	80 ff ff 
ffff8000001091b0:	ff d2                	call   *%rdx
      return -1;
ffff8000001091b2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001091b7:	e9 92 01 00 00       	jmp    ffff80000010934e <sys_open+0x249>
    }
  } else {
    if((ip = namei(path)) == 0){
ffff8000001091bc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001091c0:	48 89 c7             	mov    %rax,%rdi
ffff8000001091c3:	48 b8 a5 38 10 00 00 	movabs $0xffff8000001038a5,%rax
ffff8000001091ca:	80 ff ff 
ffff8000001091cd:	ff d0                	call   *%rax
ffff8000001091cf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001091d3:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff8000001091d8:	75 1b                	jne    ffff8000001091f5 <sys_open+0xf0>
      end_op();
ffff8000001091da:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001091df:	48 ba 5c 51 10 00 00 	movabs $0xffff80000010515c,%rdx
ffff8000001091e6:	80 ff ff 
ffff8000001091e9:	ff d2                	call   *%rdx
      return -1;
ffff8000001091eb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001091f0:	e9 59 01 00 00       	jmp    ffff80000010934e <sys_open+0x249>
    }
    ilock(ip);
ffff8000001091f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001091f9:	48 89 c7             	mov    %rax,%rdi
ffff8000001091fc:	48 b8 66 29 10 00 00 	movabs $0xffff800000102966,%rax
ffff800000109203:	80 ff ff 
ffff800000109206:	ff d0                	call   *%rax
    if(ip->type == T_DIR && omode != O_RDONLY){
ffff800000109208:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010920c:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000109213:	66 83 f8 01          	cmp    $0x1,%ax
ffff800000109217:	75 35                	jne    ffff80000010924e <sys_open+0x149>
ffff800000109219:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff80000010921c:	85 c0                	test   %eax,%eax
ffff80000010921e:	74 2e                	je     ffff80000010924e <sys_open+0x149>
      iunlockput(ip);
ffff800000109220:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109224:	48 89 c7             	mov    %rax,%rdi
ffff800000109227:	48 b8 6f 2c 10 00 00 	movabs $0xffff800000102c6f,%rax
ffff80000010922e:	80 ff ff 
ffff800000109231:	ff d0                	call   *%rax
      end_op();
ffff800000109233:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109238:	48 ba 5c 51 10 00 00 	movabs $0xffff80000010515c,%rdx
ffff80000010923f:	80 ff ff 
ffff800000109242:	ff d2                	call   *%rdx
      return -1;
ffff800000109244:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109249:	e9 00 01 00 00       	jmp    ffff80000010934e <sys_open+0x249>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
ffff80000010924e:	48 b8 c2 1b 10 00 00 	movabs $0xffff800000101bc2,%rax
ffff800000109255:	80 ff ff 
ffff800000109258:	ff d0                	call   *%rax
ffff80000010925a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010925e:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000109263:	74 1c                	je     ffff800000109281 <sys_open+0x17c>
ffff800000109265:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109269:	48 89 c7             	mov    %rax,%rdi
ffff80000010926c:	48 b8 1b 86 10 00 00 	movabs $0xffff80000010861b,%rax
ffff800000109273:	80 ff ff 
ffff800000109276:	ff d0                	call   *%rax
ffff800000109278:	89 45 ec             	mov    %eax,-0x14(%rbp)
ffff80000010927b:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffff80000010927f:	79 48                	jns    ffff8000001092c9 <sys_open+0x1c4>
    if(f)
ffff800000109281:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000109286:	74 13                	je     ffff80000010929b <sys_open+0x196>
      fileclose(f);
ffff800000109288:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010928c:	48 89 c7             	mov    %rax,%rdi
ffff80000010928f:	48 b8 de 1c 10 00 00 	movabs $0xffff800000101cde,%rax
ffff800000109296:	80 ff ff 
ffff800000109299:	ff d0                	call   *%rax
    iunlockput(ip);
ffff80000010929b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010929f:	48 89 c7             	mov    %rax,%rdi
ffff8000001092a2:	48 b8 6f 2c 10 00 00 	movabs $0xffff800000102c6f,%rax
ffff8000001092a9:	80 ff ff 
ffff8000001092ac:	ff d0                	call   *%rax
    end_op();
ffff8000001092ae:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001092b3:	48 ba 5c 51 10 00 00 	movabs $0xffff80000010515c,%rdx
ffff8000001092ba:	80 ff ff 
ffff8000001092bd:	ff d2                	call   *%rdx
    return -1;
ffff8000001092bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001092c4:	e9 85 00 00 00       	jmp    ffff80000010934e <sys_open+0x249>
  }
  iunlock(ip);
ffff8000001092c9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001092cd:	48 89 c7             	mov    %rax,%rdi
ffff8000001092d0:	48 b8 01 2b 10 00 00 	movabs $0xffff800000102b01,%rax
ffff8000001092d7:	80 ff ff 
ffff8000001092da:	ff d0                	call   *%rax
  end_op();
ffff8000001092dc:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001092e1:	48 ba 5c 51 10 00 00 	movabs $0xffff80000010515c,%rdx
ffff8000001092e8:	80 ff ff 
ffff8000001092eb:	ff d2                	call   *%rdx

  f->type = FD_INODE;
ffff8000001092ed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001092f1:	c7 00 02 00 00 00    	movl   $0x2,(%rax)
  f->ip = ip;
ffff8000001092f7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001092fb:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001092ff:	48 89 50 18          	mov    %rdx,0x18(%rax)
  f->off = 0;
ffff800000109303:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109307:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%rax)
  f->readable = !(omode & O_WRONLY);
ffff80000010930e:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000109311:	83 e0 01             	and    $0x1,%eax
ffff800000109314:	85 c0                	test   %eax,%eax
ffff800000109316:	0f 94 c0             	sete   %al
ffff800000109319:	89 c2                	mov    %eax,%edx
ffff80000010931b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010931f:	88 50 08             	mov    %dl,0x8(%rax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
ffff800000109322:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000109325:	83 e0 01             	and    $0x1,%eax
ffff800000109328:	85 c0                	test   %eax,%eax
ffff80000010932a:	75 0a                	jne    ffff800000109336 <sys_open+0x231>
ffff80000010932c:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff80000010932f:	83 e0 02             	and    $0x2,%eax
ffff800000109332:	85 c0                	test   %eax,%eax
ffff800000109334:	74 07                	je     ffff80000010933d <sys_open+0x238>
ffff800000109336:	b8 01 00 00 00       	mov    $0x1,%eax
ffff80000010933b:	eb 05                	jmp    ffff800000109342 <sys_open+0x23d>
ffff80000010933d:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109342:	89 c2                	mov    %eax,%edx
ffff800000109344:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109348:	88 50 09             	mov    %dl,0x9(%rax)
  return fd;
ffff80000010934b:	8b 45 ec             	mov    -0x14(%rbp),%eax
}
ffff80000010934e:	c9                   	leave
ffff80000010934f:	c3                   	ret

ffff800000109350 <sys_mkdir>:

int
sys_mkdir(void)
{
ffff800000109350:	f3 0f 1e fa          	endbr64
ffff800000109354:	55                   	push   %rbp
ffff800000109355:	48 89 e5             	mov    %rsp,%rbp
ffff800000109358:	48 83 ec 10          	sub    $0x10,%rsp
  char *path;
  struct inode *ip;

  begin_op();
ffff80000010935c:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109361:	48 ba 70 50 10 00 00 	movabs $0xffff800000105070,%rdx
ffff800000109368:	80 ff ff 
ffff80000010936b:	ff d2                	call   *%rdx
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
ffff80000010936d:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff800000109371:	48 89 c6             	mov    %rax,%rsi
ffff800000109374:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000109379:	48 b8 38 84 10 00 00 	movabs $0xffff800000108438,%rax
ffff800000109380:	80 ff ff 
ffff800000109383:	ff d0                	call   *%rax
ffff800000109385:	85 c0                	test   %eax,%eax
ffff800000109387:	78 2d                	js     ffff8000001093b6 <sys_mkdir+0x66>
ffff800000109389:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010938d:	b9 00 00 00 00       	mov    $0x0,%ecx
ffff800000109392:	ba 00 00 00 00       	mov    $0x0,%edx
ffff800000109397:	be 01 00 00 00       	mov    $0x1,%esi
ffff80000010939c:	48 89 c7             	mov    %rax,%rdi
ffff80000010939f:	48 b8 88 8e 10 00 00 	movabs $0xffff800000108e88,%rax
ffff8000001093a6:	80 ff ff 
ffff8000001093a9:	ff d0                	call   *%rax
ffff8000001093ab:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001093af:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff8000001093b4:	75 18                	jne    ffff8000001093ce <sys_mkdir+0x7e>
    end_op();
ffff8000001093b6:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001093bb:	48 ba 5c 51 10 00 00 	movabs $0xffff80000010515c,%rdx
ffff8000001093c2:	80 ff ff 
ffff8000001093c5:	ff d2                	call   *%rdx
    return -1;
ffff8000001093c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001093cc:	eb 29                	jmp    ffff8000001093f7 <sys_mkdir+0xa7>
  }
  iunlockput(ip);
ffff8000001093ce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001093d2:	48 89 c7             	mov    %rax,%rdi
ffff8000001093d5:	48 b8 6f 2c 10 00 00 	movabs $0xffff800000102c6f,%rax
ffff8000001093dc:	80 ff ff 
ffff8000001093df:	ff d0                	call   *%rax
  end_op();
ffff8000001093e1:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001093e6:	48 ba 5c 51 10 00 00 	movabs $0xffff80000010515c,%rdx
ffff8000001093ed:	80 ff ff 
ffff8000001093f0:	ff d2                	call   *%rdx
  return 0;
ffff8000001093f2:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff8000001093f7:	c9                   	leave
ffff8000001093f8:	c3                   	ret

ffff8000001093f9 <sys_mknod>:

int
sys_mknod(void)
{
ffff8000001093f9:	f3 0f 1e fa          	endbr64
ffff8000001093fd:	55                   	push   %rbp
ffff8000001093fe:	48 89 e5             	mov    %rsp,%rbp
ffff800000109401:	48 83 ec 20          	sub    $0x20,%rsp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
ffff800000109405:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010940a:	48 ba 70 50 10 00 00 	movabs $0xffff800000105070,%rdx
ffff800000109411:	80 ff ff 
ffff800000109414:	ff d2                	call   *%rdx
  if((argstr(0, &path)) < 0 ||
ffff800000109416:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff80000010941a:	48 89 c6             	mov    %rax,%rsi
ffff80000010941d:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000109422:	48 b8 38 84 10 00 00 	movabs $0xffff800000108438,%rax
ffff800000109429:	80 ff ff 
ffff80000010942c:	ff d0                	call   *%rax
ffff80000010942e:	85 c0                	test   %eax,%eax
ffff800000109430:	78 67                	js     ffff800000109499 <sys_mknod+0xa0>
     argint(1, &major) < 0 ||
ffff800000109432:	48 8d 45 ec          	lea    -0x14(%rbp),%rax
ffff800000109436:	48 89 c6             	mov    %rax,%rsi
ffff800000109439:	bf 01 00 00 00       	mov    $0x1,%edi
ffff80000010943e:	48 b8 48 83 10 00 00 	movabs $0xffff800000108348,%rax
ffff800000109445:	80 ff ff 
ffff800000109448:	ff d0                	call   *%rax
  if((argstr(0, &path)) < 0 ||
ffff80000010944a:	85 c0                	test   %eax,%eax
ffff80000010944c:	78 4b                	js     ffff800000109499 <sys_mknod+0xa0>
     argint(2, &minor) < 0 ||
ffff80000010944e:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffff800000109452:	48 89 c6             	mov    %rax,%rsi
ffff800000109455:	bf 02 00 00 00       	mov    $0x2,%edi
ffff80000010945a:	48 b8 48 83 10 00 00 	movabs $0xffff800000108348,%rax
ffff800000109461:	80 ff ff 
ffff800000109464:	ff d0                	call   *%rax
     argint(1, &major) < 0 ||
ffff800000109466:	85 c0                	test   %eax,%eax
ffff800000109468:	78 2f                	js     ffff800000109499 <sys_mknod+0xa0>
     (ip = create(path, T_DEV, major, minor)) == 0){
ffff80000010946a:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff80000010946d:	0f bf c8             	movswl %ax,%ecx
ffff800000109470:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000109473:	0f bf d0             	movswl %ax,%edx
ffff800000109476:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010947a:	be 03 00 00 00       	mov    $0x3,%esi
ffff80000010947f:	48 89 c7             	mov    %rax,%rdi
ffff800000109482:	48 b8 88 8e 10 00 00 	movabs $0xffff800000108e88,%rax
ffff800000109489:	80 ff ff 
ffff80000010948c:	ff d0                	call   *%rax
ffff80000010948e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
     argint(2, &minor) < 0 ||
ffff800000109492:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000109497:	75 18                	jne    ffff8000001094b1 <sys_mknod+0xb8>
    end_op();
ffff800000109499:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010949e:	48 ba 5c 51 10 00 00 	movabs $0xffff80000010515c,%rdx
ffff8000001094a5:	80 ff ff 
ffff8000001094a8:	ff d2                	call   *%rdx
    return -1;
ffff8000001094aa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001094af:	eb 29                	jmp    ffff8000001094da <sys_mknod+0xe1>
  }
  iunlockput(ip);
ffff8000001094b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001094b5:	48 89 c7             	mov    %rax,%rdi
ffff8000001094b8:	48 b8 6f 2c 10 00 00 	movabs $0xffff800000102c6f,%rax
ffff8000001094bf:	80 ff ff 
ffff8000001094c2:	ff d0                	call   *%rax
  end_op();
ffff8000001094c4:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001094c9:	48 ba 5c 51 10 00 00 	movabs $0xffff80000010515c,%rdx
ffff8000001094d0:	80 ff ff 
ffff8000001094d3:	ff d2                	call   *%rdx
  return 0;
ffff8000001094d5:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff8000001094da:	c9                   	leave
ffff8000001094db:	c3                   	ret

ffff8000001094dc <sys_chdir>:

int
sys_chdir(void)
{
ffff8000001094dc:	f3 0f 1e fa          	endbr64
ffff8000001094e0:	55                   	push   %rbp
ffff8000001094e1:	48 89 e5             	mov    %rsp,%rbp
ffff8000001094e4:	48 83 ec 10          	sub    $0x10,%rsp
  char *path;
  struct inode *ip;

  begin_op();
ffff8000001094e8:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001094ed:	48 ba 70 50 10 00 00 	movabs $0xffff800000105070,%rdx
ffff8000001094f4:	80 ff ff 
ffff8000001094f7:	ff d2                	call   *%rdx
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
ffff8000001094f9:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff8000001094fd:	48 89 c6             	mov    %rax,%rsi
ffff800000109500:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000109505:	48 b8 38 84 10 00 00 	movabs $0xffff800000108438,%rax
ffff80000010950c:	80 ff ff 
ffff80000010950f:	ff d0                	call   *%rax
ffff800000109511:	85 c0                	test   %eax,%eax
ffff800000109513:	78 1e                	js     ffff800000109533 <sys_chdir+0x57>
ffff800000109515:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109519:	48 89 c7             	mov    %rax,%rdi
ffff80000010951c:	48 b8 a5 38 10 00 00 	movabs $0xffff8000001038a5,%rax
ffff800000109523:	80 ff ff 
ffff800000109526:	ff d0                	call   *%rax
ffff800000109528:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010952c:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000109531:	75 1b                	jne    ffff80000010954e <sys_chdir+0x72>
    end_op();
ffff800000109533:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109538:	48 ba 5c 51 10 00 00 	movabs $0xffff80000010515c,%rdx
ffff80000010953f:	80 ff ff 
ffff800000109542:	ff d2                	call   *%rdx
    return -1;
ffff800000109544:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109549:	e9 af 00 00 00       	jmp    ffff8000001095fd <sys_chdir+0x121>
  }
  ilock(ip);
ffff80000010954e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109552:	48 89 c7             	mov    %rax,%rdi
ffff800000109555:	48 b8 66 29 10 00 00 	movabs $0xffff800000102966,%rax
ffff80000010955c:	80 ff ff 
ffff80000010955f:	ff d0                	call   *%rax
  if(ip->type != T_DIR){
ffff800000109561:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109565:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff80000010956c:	66 83 f8 01          	cmp    $0x1,%ax
ffff800000109570:	74 2b                	je     ffff80000010959d <sys_chdir+0xc1>
    iunlockput(ip);
ffff800000109572:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109576:	48 89 c7             	mov    %rax,%rdi
ffff800000109579:	48 b8 6f 2c 10 00 00 	movabs $0xffff800000102c6f,%rax
ffff800000109580:	80 ff ff 
ffff800000109583:	ff d0                	call   *%rax
    end_op();
ffff800000109585:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010958a:	48 ba 5c 51 10 00 00 	movabs $0xffff80000010515c,%rdx
ffff800000109591:	80 ff ff 
ffff800000109594:	ff d2                	call   *%rdx
    return -1;
ffff800000109596:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010959b:	eb 60                	jmp    ffff8000001095fd <sys_chdir+0x121>
  }
  iunlock(ip);
ffff80000010959d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001095a1:	48 89 c7             	mov    %rax,%rdi
ffff8000001095a4:	48 b8 01 2b 10 00 00 	movabs $0xffff800000102b01,%rax
ffff8000001095ab:	80 ff ff 
ffff8000001095ae:	ff d0                	call   *%rax
  iput(proc->cwd);
ffff8000001095b0:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001095b7:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001095bb:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffff8000001095c2:	48 89 c7             	mov    %rax,%rdi
ffff8000001095c5:	48 b8 71 2b 10 00 00 	movabs $0xffff800000102b71,%rax
ffff8000001095cc:	80 ff ff 
ffff8000001095cf:	ff d0                	call   *%rax
  end_op();
ffff8000001095d1:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001095d6:	48 ba 5c 51 10 00 00 	movabs $0xffff80000010515c,%rdx
ffff8000001095dd:	80 ff ff 
ffff8000001095e0:	ff d2                	call   *%rdx
  proc->cwd = ip;
ffff8000001095e2:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001095e9:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001095ed:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001095f1:	48 89 90 c8 00 00 00 	mov    %rdx,0xc8(%rax)
  return 0;
ffff8000001095f8:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff8000001095fd:	c9                   	leave
ffff8000001095fe:	c3                   	ret

ffff8000001095ff <sys_exec>:

int
sys_exec(void)
{
ffff8000001095ff:	f3 0f 1e fa          	endbr64
ffff800000109603:	55                   	push   %rbp
ffff800000109604:	48 89 e5             	mov    %rsp,%rbp
ffff800000109607:	48 81 ec 20 01 00 00 	sub    $0x120,%rsp
  char *path, *argv[MAXARG];
  int i;
  addr_t uargv, uarg;

  if(argstr(0, &path) < 0 || argaddr(1, &uargv) < 0){
ffff80000010960e:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff800000109612:	48 89 c6             	mov    %rax,%rsi
ffff800000109615:	bf 00 00 00 00       	mov    $0x0,%edi
ffff80000010961a:	48 b8 38 84 10 00 00 	movabs $0xffff800000108438,%rax
ffff800000109621:	80 ff ff 
ffff800000109624:	ff d0                	call   *%rax
ffff800000109626:	85 c0                	test   %eax,%eax
ffff800000109628:	78 44                	js     ffff80000010966e <sys_exec+0x6f>
ffff80000010962a:	48 8d 85 e8 fe ff ff 	lea    -0x118(%rbp),%rax
ffff800000109631:	48 89 c6             	mov    %rax,%rsi
ffff800000109634:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000109639:	48 b8 7b 83 10 00 00 	movabs $0xffff80000010837b,%rax
ffff800000109640:	80 ff ff 
ffff800000109643:	ff d0                	call   *%rax
    return -1;
  }
  memset(argv, 0, sizeof(argv));
ffff800000109645:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
ffff80000010964c:	ba 00 01 00 00       	mov    $0x100,%edx
ffff800000109651:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000109656:	48 89 c7             	mov    %rax,%rdi
ffff800000109659:	48 b8 87 7d 10 00 00 	movabs $0xffff800000107d87,%rax
ffff800000109660:	80 ff ff 
ffff800000109663:	ff d0                	call   *%rax
  for(i=0;; i++){
ffff800000109665:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010966c:	eb 0a                	jmp    ffff800000109678 <sys_exec+0x79>
    return -1;
ffff80000010966e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109673:	e9 cb 00 00 00       	jmp    ffff800000109743 <sys_exec+0x144>
    if(i >= NELEM(argv))
ffff800000109678:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010967b:	83 f8 1f             	cmp    $0x1f,%eax
ffff80000010967e:	76 0a                	jbe    ffff80000010968a <sys_exec+0x8b>
      return -1;
ffff800000109680:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109685:	e9 b9 00 00 00       	jmp    ffff800000109743 <sys_exec+0x144>
    if(fetchaddr(uargv+(sizeof(addr_t))*i, (addr_t*)&uarg) < 0)
ffff80000010968a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010968d:	48 98                	cltq
ffff80000010968f:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff800000109696:	00 
ffff800000109697:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
ffff80000010969e:	48 01 c2             	add    %rax,%rdx
ffff8000001096a1:	48 8d 85 e0 fe ff ff 	lea    -0x120(%rbp),%rax
ffff8000001096a8:	48 89 c6             	mov    %rax,%rsi
ffff8000001096ab:	48 89 d7             	mov    %rdx,%rdi
ffff8000001096ae:	48 b8 76 81 10 00 00 	movabs $0xffff800000108176,%rax
ffff8000001096b5:	80 ff ff 
ffff8000001096b8:	ff d0                	call   *%rax
ffff8000001096ba:	85 c0                	test   %eax,%eax
ffff8000001096bc:	79 07                	jns    ffff8000001096c5 <sys_exec+0xc6>
      return -1;
ffff8000001096be:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001096c3:	eb 7e                	jmp    ffff800000109743 <sys_exec+0x144>
    if(uarg == 0){
ffff8000001096c5:	48 8b 85 e0 fe ff ff 	mov    -0x120(%rbp),%rax
ffff8000001096cc:	48 85 c0             	test   %rax,%rax
ffff8000001096cf:	75 31                	jne    ffff800000109702 <sys_exec+0x103>
      argv[i] = 0;
ffff8000001096d1:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001096d4:	48 98                	cltq
ffff8000001096d6:	48 c7 84 c5 f0 fe ff 	movq   $0x0,-0x110(%rbp,%rax,8)
ffff8000001096dd:	ff 00 00 00 00 
      break;
ffff8000001096e2:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
ffff8000001096e3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001096e7:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
ffff8000001096ee:	48 89 d6             	mov    %rdx,%rsi
ffff8000001096f1:	48 89 c7             	mov    %rax,%rdi
ffff8000001096f4:	48 b8 9f 15 10 00 00 	movabs $0xffff80000010159f,%rax
ffff8000001096fb:	80 ff ff 
ffff8000001096fe:	ff d0                	call   *%rax
ffff800000109700:	eb 41                	jmp    ffff800000109743 <sys_exec+0x144>
    if(fetchstr(uarg, &argv[i]) < 0)
ffff800000109702:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
ffff800000109709:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010970c:	48 63 d2             	movslq %edx,%rdx
ffff80000010970f:	48 c1 e2 03          	shl    $0x3,%rdx
ffff800000109713:	48 01 c2             	add    %rax,%rdx
ffff800000109716:	48 8b 85 e0 fe ff ff 	mov    -0x120(%rbp),%rax
ffff80000010971d:	48 89 d6             	mov    %rdx,%rsi
ffff800000109720:	48 89 c7             	mov    %rax,%rdi
ffff800000109723:	48 b8 df 81 10 00 00 	movabs $0xffff8000001081df,%rax
ffff80000010972a:	80 ff ff 
ffff80000010972d:	ff d0                	call   *%rax
ffff80000010972f:	85 c0                	test   %eax,%eax
ffff800000109731:	79 07                	jns    ffff80000010973a <sys_exec+0x13b>
      return -1;
ffff800000109733:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109738:	eb 09                	jmp    ffff800000109743 <sys_exec+0x144>
  for(i=0;; i++){
ffff80000010973a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    if(i >= NELEM(argv))
ffff80000010973e:	e9 35 ff ff ff       	jmp    ffff800000109678 <sys_exec+0x79>
}
ffff800000109743:	c9                   	leave
ffff800000109744:	c3                   	ret

ffff800000109745 <sys_pipe>:

int
sys_pipe(void)
{
ffff800000109745:	f3 0f 1e fa          	endbr64
ffff800000109749:	55                   	push   %rbp
ffff80000010974a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010974d:	48 83 ec 20          	sub    $0x20,%rsp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
ffff800000109751:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff800000109755:	ba 08 00 00 00       	mov    $0x8,%edx
ffff80000010975a:	48 89 c6             	mov    %rax,%rsi
ffff80000010975d:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000109762:	48 b8 ad 83 10 00 00 	movabs $0xffff8000001083ad,%rax
ffff800000109769:	80 ff ff 
ffff80000010976c:	ff d0                	call   *%rax
    return -1;
  if(pipealloc(&rf, &wf) < 0)
ffff80000010976e:	48 8d 55 e0          	lea    -0x20(%rbp),%rdx
ffff800000109772:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffff800000109776:	48 89 d6             	mov    %rdx,%rsi
ffff800000109779:	48 89 c7             	mov    %rax,%rdi
ffff80000010977c:	48 b8 03 5e 10 00 00 	movabs $0xffff800000105e03,%rax
ffff800000109783:	80 ff ff 
ffff800000109786:	ff d0                	call   *%rax
ffff800000109788:	85 c0                	test   %eax,%eax
ffff80000010978a:	79 0a                	jns    ffff800000109796 <sys_pipe+0x51>
    return -1;
ffff80000010978c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109791:	e9 ab 00 00 00       	jmp    ffff800000109841 <sys_pipe+0xfc>
  fd0 = -1;
ffff800000109796:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
ffff80000010979d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001097a1:	48 89 c7             	mov    %rax,%rdi
ffff8000001097a4:	48 b8 1b 86 10 00 00 	movabs $0xffff80000010861b,%rax
ffff8000001097ab:	80 ff ff 
ffff8000001097ae:	ff d0                	call   *%rax
ffff8000001097b0:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff8000001097b3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff8000001097b7:	78 1c                	js     ffff8000001097d5 <sys_pipe+0x90>
ffff8000001097b9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001097bd:	48 89 c7             	mov    %rax,%rdi
ffff8000001097c0:	48 b8 1b 86 10 00 00 	movabs $0xffff80000010861b,%rax
ffff8000001097c7:	80 ff ff 
ffff8000001097ca:	ff d0                	call   *%rax
ffff8000001097cc:	89 45 f8             	mov    %eax,-0x8(%rbp)
ffff8000001097cf:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
ffff8000001097d3:	79 51                	jns    ffff800000109826 <sys_pipe+0xe1>
    if(fd0 >= 0)
ffff8000001097d5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff8000001097d9:	78 1e                	js     ffff8000001097f9 <sys_pipe+0xb4>
      proc->ofile[fd0] = 0;
ffff8000001097db:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001097e2:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001097e6:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001097e9:	48 63 d2             	movslq %edx,%rdx
ffff8000001097ec:	48 83 c2 08          	add    $0x8,%rdx
ffff8000001097f0:	48 c7 44 d0 08 00 00 	movq   $0x0,0x8(%rax,%rdx,8)
ffff8000001097f7:	00 00 
    fileclose(rf);
ffff8000001097f9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001097fd:	48 89 c7             	mov    %rax,%rdi
ffff800000109800:	48 b8 de 1c 10 00 00 	movabs $0xffff800000101cde,%rax
ffff800000109807:	80 ff ff 
ffff80000010980a:	ff d0                	call   *%rax
    fileclose(wf);
ffff80000010980c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000109810:	48 89 c7             	mov    %rax,%rdi
ffff800000109813:	48 b8 de 1c 10 00 00 	movabs $0xffff800000101cde,%rax
ffff80000010981a:	80 ff ff 
ffff80000010981d:	ff d0                	call   *%rax
    return -1;
ffff80000010981f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109824:	eb 1b                	jmp    ffff800000109841 <sys_pipe+0xfc>
  }
  fd[0] = fd0;
ffff800000109826:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010982a:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010982d:	89 10                	mov    %edx,(%rax)
  fd[1] = fd1;
ffff80000010982f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109833:	48 8d 50 04          	lea    0x4(%rax),%rdx
ffff800000109837:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff80000010983a:	89 02                	mov    %eax,(%rdx)
  return 0;
ffff80000010983c:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000109841:	c9                   	leave
ffff800000109842:	c3                   	ret

ffff800000109843 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
ffff800000109843:	f3 0f 1e fa          	endbr64
ffff800000109847:	55                   	push   %rbp
ffff800000109848:	48 89 e5             	mov    %rsp,%rbp
  return fork();
ffff80000010984b:	48 b8 41 67 10 00 00 	movabs $0xffff800000106741,%rax
ffff800000109852:	80 ff ff 
ffff800000109855:	ff d0                	call   *%rax
}
ffff800000109857:	5d                   	pop    %rbp
ffff800000109858:	c3                   	ret

ffff800000109859 <sys_exit>:

int
sys_exit(void)
{
ffff800000109859:	f3 0f 1e fa          	endbr64
ffff80000010985d:	55                   	push   %rbp
ffff80000010985e:	48 89 e5             	mov    %rsp,%rbp
  exit();
ffff800000109861:	48 b8 fd 69 10 00 00 	movabs $0xffff8000001069fd,%rax
ffff800000109868:	80 ff ff 
ffff80000010986b:	ff d0                	call   *%rax
  return 0;  // not reached
ffff80000010986d:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000109872:	5d                   	pop    %rbp
ffff800000109873:	c3                   	ret

ffff800000109874 <sys_wait>:

int
sys_wait(void)
{
ffff800000109874:	f3 0f 1e fa          	endbr64
ffff800000109878:	55                   	push   %rbp
ffff800000109879:	48 89 e5             	mov    %rsp,%rbp
  return wait();
ffff80000010987c:	48 b8 fc 6b 10 00 00 	movabs $0xffff800000106bfc,%rax
ffff800000109883:	80 ff ff 
ffff800000109886:	ff d0                	call   *%rax
}
ffff800000109888:	5d                   	pop    %rbp
ffff800000109889:	c3                   	ret

ffff80000010988a <sys_kill>:

int
sys_kill(void)
{
ffff80000010988a:	f3 0f 1e fa          	endbr64
ffff80000010988e:	55                   	push   %rbp
ffff80000010988f:	48 89 e5             	mov    %rsp,%rbp
ffff800000109892:	48 83 ec 10          	sub    $0x10,%rsp
  int pid;

  if(argint(0, &pid) < 0)
ffff800000109896:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
ffff80000010989a:	48 89 c6             	mov    %rax,%rsi
ffff80000010989d:	bf 00 00 00 00       	mov    $0x0,%edi
ffff8000001098a2:	48 b8 48 83 10 00 00 	movabs $0xffff800000108348,%rax
ffff8000001098a9:	80 ff ff 
ffff8000001098ac:	ff d0                	call   *%rax
ffff8000001098ae:	85 c0                	test   %eax,%eax
ffff8000001098b0:	79 07                	jns    ffff8000001098b9 <sys_kill+0x2f>
    return -1;
ffff8000001098b2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001098b7:	eb 11                	jmp    ffff8000001098ca <sys_kill+0x40>
  return kill(pid);
ffff8000001098b9:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001098bc:	89 c7                	mov    %eax,%edi
ffff8000001098be:	48 b8 79 72 10 00 00 	movabs $0xffff800000107279,%rax
ffff8000001098c5:	80 ff ff 
ffff8000001098c8:	ff d0                	call   *%rax
}
ffff8000001098ca:	c9                   	leave
ffff8000001098cb:	c3                   	ret

ffff8000001098cc <sys_getpid>:

int
sys_getpid(void)
{
ffff8000001098cc:	f3 0f 1e fa          	endbr64
ffff8000001098d0:	55                   	push   %rbp
ffff8000001098d1:	48 89 e5             	mov    %rsp,%rbp
  return proc->pid;
ffff8000001098d4:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001098db:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001098df:	8b 40 1c             	mov    0x1c(%rax),%eax
}
ffff8000001098e2:	5d                   	pop    %rbp
ffff8000001098e3:	c3                   	ret

ffff8000001098e4 <sys_sbrk>:

addr_t
sys_sbrk(void)
{
ffff8000001098e4:	f3 0f 1e fa          	endbr64
ffff8000001098e8:	55                   	push   %rbp
ffff8000001098e9:	48 89 e5             	mov    %rsp,%rbp
ffff8000001098ec:	48 83 ec 10          	sub    $0x10,%rsp
  addr_t addr;
  addr_t n;

  argaddr(0, &n);
ffff8000001098f0:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff8000001098f4:	48 89 c6             	mov    %rax,%rsi
ffff8000001098f7:	bf 00 00 00 00       	mov    $0x0,%edi
ffff8000001098fc:	48 b8 7b 83 10 00 00 	movabs $0xffff80000010837b,%rax
ffff800000109903:	80 ff ff 
ffff800000109906:	ff d0                	call   *%rax
  addr = proc->sz;
ffff800000109908:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010990f:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109913:	48 8b 00             	mov    (%rax),%rax
ffff800000109916:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(growproc(n) < 0)
ffff80000010991a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010991e:	48 89 c7             	mov    %rax,%rdi
ffff800000109921:	48 b8 5a 66 10 00 00 	movabs $0xffff80000010665a,%rax
ffff800000109928:	80 ff ff 
ffff80000010992b:	ff d0                	call   *%rax
ffff80000010992d:	85 c0                	test   %eax,%eax
ffff80000010992f:	79 09                	jns    ffff80000010993a <sys_sbrk+0x56>
    return -1;
ffff800000109931:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
ffff800000109938:	eb 04                	jmp    ffff80000010993e <sys_sbrk+0x5a>
  return addr;
ffff80000010993a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff80000010993e:	c9                   	leave
ffff80000010993f:	c3                   	ret

ffff800000109940 <sys_sleep>:

int
sys_sleep(void)
{
ffff800000109940:	f3 0f 1e fa          	endbr64
ffff800000109944:	55                   	push   %rbp
ffff800000109945:	48 89 e5             	mov    %rsp,%rbp
ffff800000109948:	48 83 ec 10          	sub    $0x10,%rsp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
ffff80000010994c:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff800000109950:	48 89 c6             	mov    %rax,%rsi
ffff800000109953:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000109958:	48 b8 48 83 10 00 00 	movabs $0xffff800000108348,%rax
ffff80000010995f:	80 ff ff 
ffff800000109962:	ff d0                	call   *%rax
ffff800000109964:	85 c0                	test   %eax,%eax
ffff800000109966:	79 0a                	jns    ffff800000109972 <sys_sleep+0x32>
    return -1;
ffff800000109968:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010996d:	e9 b6 00 00 00       	jmp    ffff800000109a28 <sys_sleep+0xe8>
  acquire(&tickslock);
ffff800000109972:	48 b8 e0 e4 11 00 00 	movabs $0xffff80000011e4e0,%rax
ffff800000109979:	80 ff ff 
ffff80000010997c:	48 89 c7             	mov    %rax,%rdi
ffff80000010997f:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff800000109986:	80 ff ff 
ffff800000109989:	ff d0                	call   *%rax
  ticks0 = ticks;
ffff80000010998b:	48 b8 48 e5 11 00 00 	movabs $0xffff80000011e548,%rax
ffff800000109992:	80 ff ff 
ffff800000109995:	8b 00                	mov    (%rax),%eax
ffff800000109997:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while(ticks - ticks0 < n){
ffff80000010999a:	eb 58                	jmp    ffff8000001099f4 <sys_sleep+0xb4>
    if(proc->killed){
ffff80000010999c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001099a3:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001099a7:	8b 40 40             	mov    0x40(%rax),%eax
ffff8000001099aa:	85 c0                	test   %eax,%eax
ffff8000001099ac:	74 20                	je     ffff8000001099ce <sys_sleep+0x8e>
      release(&tickslock);
ffff8000001099ae:	48 b8 e0 e4 11 00 00 	movabs $0xffff80000011e4e0,%rax
ffff8000001099b5:	80 ff ff 
ffff8000001099b8:	48 89 c7             	mov    %rax,%rdi
ffff8000001099bb:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff8000001099c2:	80 ff ff 
ffff8000001099c5:	ff d0                	call   *%rax
      return -1;
ffff8000001099c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001099cc:	eb 5a                	jmp    ffff800000109a28 <sys_sleep+0xe8>
    }
    sleep(&ticks, &tickslock);
ffff8000001099ce:	48 b8 e0 e4 11 00 00 	movabs $0xffff80000011e4e0,%rax
ffff8000001099d5:	80 ff ff 
ffff8000001099d8:	48 89 c6             	mov    %rax,%rsi
ffff8000001099db:	48 b8 48 e5 11 00 00 	movabs $0xffff80000011e548,%rax
ffff8000001099e2:	80 ff ff 
ffff8000001099e5:	48 89 c7             	mov    %rax,%rdi
ffff8000001099e8:	48 b8 a4 70 10 00 00 	movabs $0xffff8000001070a4,%rax
ffff8000001099ef:	80 ff ff 
ffff8000001099f2:	ff d0                	call   *%rax
  while(ticks - ticks0 < n){
ffff8000001099f4:	48 b8 48 e5 11 00 00 	movabs $0xffff80000011e548,%rax
ffff8000001099fb:	80 ff ff 
ffff8000001099fe:	8b 00                	mov    (%rax),%eax
ffff800000109a00:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff800000109a03:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffff800000109a06:	39 d0                	cmp    %edx,%eax
ffff800000109a08:	72 92                	jb     ffff80000010999c <sys_sleep+0x5c>
  }
  release(&tickslock);
ffff800000109a0a:	48 b8 e0 e4 11 00 00 	movabs $0xffff80000011e4e0,%rax
ffff800000109a11:	80 ff ff 
ffff800000109a14:	48 89 c7             	mov    %rax,%rdi
ffff800000109a17:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff800000109a1e:	80 ff ff 
ffff800000109a21:	ff d0                	call   *%rax
  return 0;
ffff800000109a23:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000109a28:	c9                   	leave
ffff800000109a29:	c3                   	ret

ffff800000109a2a <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
ffff800000109a2a:	f3 0f 1e fa          	endbr64
ffff800000109a2e:	55                   	push   %rbp
ffff800000109a2f:	48 89 e5             	mov    %rsp,%rbp
ffff800000109a32:	48 83 ec 10          	sub    $0x10,%rsp
  uint xticks;

  acquire(&tickslock);
ffff800000109a36:	48 b8 e0 e4 11 00 00 	movabs $0xffff80000011e4e0,%rax
ffff800000109a3d:	80 ff ff 
ffff800000109a40:	48 89 c7             	mov    %rax,%rdi
ffff800000109a43:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff800000109a4a:	80 ff ff 
ffff800000109a4d:	ff d0                	call   *%rax
  xticks = ticks;
ffff800000109a4f:	48 b8 48 e5 11 00 00 	movabs $0xffff80000011e548,%rax
ffff800000109a56:	80 ff ff 
ffff800000109a59:	8b 00                	mov    (%rax),%eax
ffff800000109a5b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  release(&tickslock);
ffff800000109a5e:	48 b8 e0 e4 11 00 00 	movabs $0xffff80000011e4e0,%rax
ffff800000109a65:	80 ff ff 
ffff800000109a68:	48 89 c7             	mov    %rax,%rdi
ffff800000109a6b:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff800000109a72:	80 ff ff 
ffff800000109a75:	ff d0                	call   *%rax
  return xticks;
ffff800000109a77:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff800000109a7a:	c9                   	leave
ffff800000109a7b:	c3                   	ret

ffff800000109a7c <sys_send>:

int
sys_send(void)
{
ffff800000109a7c:	f3 0f 1e fa          	endbr64
ffff800000109a80:	55                   	push   %rbp
ffff800000109a81:	48 89 e5             	mov    %rsp,%rbp
ffff800000109a84:	48 83 ec 10          	sub    $0x10,%rsp
	int pid;
	char* msg;

	if (argint(0, &pid) < 0 || argptr(1, &msg, sizeof(struct ipc_msg)) < 0) 
ffff800000109a88:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
ffff800000109a8c:	48 89 c6             	mov    %rax,%rsi
ffff800000109a8f:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000109a94:	48 b8 48 83 10 00 00 	movabs $0xffff800000108348,%rax
ffff800000109a9b:	80 ff ff 
ffff800000109a9e:	ff d0                	call   *%rax
ffff800000109aa0:	85 c0                	test   %eax,%eax
ffff800000109aa2:	78 37                	js     ffff800000109adb <sys_send+0x5f>
ffff800000109aa4:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff800000109aa8:	ba d8 00 00 00       	mov    $0xd8,%edx
ffff800000109aad:	48 89 c6             	mov    %rax,%rsi
ffff800000109ab0:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000109ab5:	48 b8 ad 83 10 00 00 	movabs $0xffff8000001083ad,%rax
ffff800000109abc:	80 ff ff 
ffff800000109abf:	ff d0                	call   *%rax
		return -1;

	return send(pid, msg);
ffff800000109ac1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000109ac5:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000109ac8:	48 89 d6             	mov    %rdx,%rsi
ffff800000109acb:	89 c7                	mov    %eax,%edi
ffff800000109acd:	48 b8 b2 74 10 00 00 	movabs $0xffff8000001074b2,%rax
ffff800000109ad4:	80 ff ff 
ffff800000109ad7:	ff d0                	call   *%rax
ffff800000109ad9:	eb 05                	jmp    ffff800000109ae0 <sys_send+0x64>
		return -1;
ffff800000109adb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000109ae0:	c9                   	leave
ffff800000109ae1:	c3                   	ret

ffff800000109ae2 <sys_recv>:

int
sys_recv(void)
{
ffff800000109ae2:	f3 0f 1e fa          	endbr64
ffff800000109ae6:	55                   	push   %rbp
ffff800000109ae7:	48 89 e5             	mov    %rsp,%rbp
ffff800000109aea:	48 83 ec 10          	sub    $0x10,%rsp
	char *msg;
	if (argptr(0, &msg, sizeof(struct ipc_msg)) < 0) 
ffff800000109aee:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff800000109af2:	ba d8 00 00 00       	mov    $0xd8,%edx
ffff800000109af7:	48 89 c6             	mov    %rax,%rsi
ffff800000109afa:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000109aff:	48 b8 ad 83 10 00 00 	movabs $0xffff8000001083ad,%rax
ffff800000109b06:	80 ff ff 
ffff800000109b09:	ff d0                	call   *%rax
		return -1;

	return recv(msg);
ffff800000109b0b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109b0f:	48 89 c7             	mov    %rax,%rdi
ffff800000109b12:	48 b8 6b 76 10 00 00 	movabs $0xffff80000010766b,%rax
ffff800000109b19:	80 ff ff 
ffff800000109b1c:	ff d0                	call   *%rax
}
ffff800000109b1e:	c9                   	leave
ffff800000109b1f:	c3                   	ret

ffff800000109b20 <alltraps>:
ffff800000109b20:	41 57                	push   %r15
ffff800000109b22:	41 56                	push   %r14
ffff800000109b24:	41 55                	push   %r13
ffff800000109b26:	41 54                	push   %r12
ffff800000109b28:	41 53                	push   %r11
ffff800000109b2a:	41 52                	push   %r10
ffff800000109b2c:	41 51                	push   %r9
ffff800000109b2e:	41 50                	push   %r8
ffff800000109b30:	57                   	push   %rdi
ffff800000109b31:	56                   	push   %rsi
ffff800000109b32:	55                   	push   %rbp
ffff800000109b33:	52                   	push   %rdx
ffff800000109b34:	51                   	push   %rcx
ffff800000109b35:	53                   	push   %rbx
ffff800000109b36:	50                   	push   %rax
ffff800000109b37:	48 89 e7             	mov    %rsp,%rdi
ffff800000109b3a:	e8 8f 02 00 00       	call   ffff800000109dce <trap>

ffff800000109b3f <trapret>:
ffff800000109b3f:	58                   	pop    %rax
ffff800000109b40:	5b                   	pop    %rbx
ffff800000109b41:	59                   	pop    %rcx
ffff800000109b42:	5a                   	pop    %rdx
ffff800000109b43:	5d                   	pop    %rbp
ffff800000109b44:	5e                   	pop    %rsi
ffff800000109b45:	5f                   	pop    %rdi
ffff800000109b46:	41 58                	pop    %r8
ffff800000109b48:	41 59                	pop    %r9
ffff800000109b4a:	41 5a                	pop    %r10
ffff800000109b4c:	41 5b                	pop    %r11
ffff800000109b4e:	41 5c                	pop    %r12
ffff800000109b50:	41 5d                	pop    %r13
ffff800000109b52:	41 5e                	pop    %r14
ffff800000109b54:	41 5f                	pop    %r15
ffff800000109b56:	48 83 c4 10          	add    $0x10,%rsp
ffff800000109b5a:	48 cf                	iretq

ffff800000109b5c <syscall_entry>:
ffff800000109b5c:	64 48 89 04 25 00 00 	mov    %rax,%fs:0x0
ffff800000109b63:	00 00 
ffff800000109b65:	64 48 8b 04 25 f8 ff 	mov    %fs:0xfffffffffffffff8,%rax
ffff800000109b6c:	ff ff 
ffff800000109b6e:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000109b72:	48 05 f0 0f 00 00    	add    $0xff0,%rax
ffff800000109b78:	48 89 20             	mov    %rsp,(%rax)
ffff800000109b7b:	48 89 c4             	mov    %rax,%rsp
ffff800000109b7e:	64 48 8b 04 25 00 00 	mov    %fs:0x0,%rax
ffff800000109b85:	00 00 
ffff800000109b87:	41 53                	push   %r11
ffff800000109b89:	6a 00                	push   $0x0
ffff800000109b8b:	51                   	push   %rcx
ffff800000109b8c:	6a 00                	push   $0x0
ffff800000109b8e:	6a 00                	push   $0x0
ffff800000109b90:	41 57                	push   %r15
ffff800000109b92:	41 56                	push   %r14
ffff800000109b94:	41 55                	push   %r13
ffff800000109b96:	41 54                	push   %r12
ffff800000109b98:	41 53                	push   %r11
ffff800000109b9a:	41 52                	push   %r10
ffff800000109b9c:	41 51                	push   %r9
ffff800000109b9e:	41 50                	push   %r8
ffff800000109ba0:	57                   	push   %rdi
ffff800000109ba1:	56                   	push   %rsi
ffff800000109ba2:	55                   	push   %rbp
ffff800000109ba3:	52                   	push   %rdx
ffff800000109ba4:	51                   	push   %rcx
ffff800000109ba5:	53                   	push   %rbx
ffff800000109ba6:	50                   	push   %rax
ffff800000109ba7:	48 89 e7             	mov    %rsp,%rdi
ffff800000109baa:	e8 dc e8 ff ff       	call   ffff80000010848b <syscall>

ffff800000109baf <syscall_trapret>:
ffff800000109baf:	58                   	pop    %rax
ffff800000109bb0:	5b                   	pop    %rbx
ffff800000109bb1:	59                   	pop    %rcx
ffff800000109bb2:	5a                   	pop    %rdx
ffff800000109bb3:	5d                   	pop    %rbp
ffff800000109bb4:	5e                   	pop    %rsi
ffff800000109bb5:	5f                   	pop    %rdi
ffff800000109bb6:	41 58                	pop    %r8
ffff800000109bb8:	41 59                	pop    %r9
ffff800000109bba:	41 5a                	pop    %r10
ffff800000109bbc:	41 5b                	pop    %r11
ffff800000109bbe:	41 5c                	pop    %r12
ffff800000109bc0:	41 5d                	pop    %r13
ffff800000109bc2:	41 5e                	pop    %r14
ffff800000109bc4:	41 5f                	pop    %r15
ffff800000109bc6:	48 83 c4 28          	add    $0x28,%rsp
ffff800000109bca:	fa                   	cli
ffff800000109bcb:	48 8b 24 24          	mov    (%rsp),%rsp
ffff800000109bcf:	48 0f 07             	sysretq

ffff800000109bd2 <lidt>:
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
ffff800000109bd2:	f3 0f 1e fa          	endbr64
ffff800000109bd6:	55                   	push   %rbp
ffff800000109bd7:	48 89 e5             	mov    %rsp,%rbp
ffff800000109bda:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000109bde:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000109be2:	89 75 d4             	mov    %esi,-0x2c(%rbp)
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d rip %p (cr2=0x%p)\n",
ffff800000109be5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000109be9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
              tf->trapno, cpunum(), tf->rip, rcr2());
      if (proc)
ffff800000109bed:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff800000109bf0:	83 e8 01             	sub    $0x1,%eax
ffff800000109bf3:	66 89 45 ee          	mov    %ax,-0x12(%rbp)
        cprintf("proc id: %d\n", proc->pid);
ffff800000109bf7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109bfb:	66 89 45 f0          	mov    %ax,-0x10(%rbp)
      panic("trap");
ffff800000109bff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109c03:	48 c1 e8 10          	shr    $0x10,%rax
ffff800000109c07:	66 89 45 f2          	mov    %ax,-0xe(%rbp)
    }
ffff800000109c0b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109c0f:	48 c1 e8 20          	shr    $0x20,%rax
ffff800000109c13:	66 89 45 f4          	mov    %ax,-0xc(%rbp)
    // In user space, assume process misbehaved.
ffff800000109c17:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109c1b:	48 c1 e8 30          	shr    $0x30,%rax
ffff800000109c1f:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
            "rip 0x%p addr 0x%p--kill proc\n",
ffff800000109c23:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
ffff800000109c27:	0f 01 18             	lidt   (%rax)
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->rip,
ffff800000109c2a:	90                   	nop
ffff800000109c2b:	c9                   	leave
ffff800000109c2c:	c3                   	ret

ffff800000109c2d <rcr2>:
ffff800000109c2d:	f3 0f 1e fa          	endbr64
ffff800000109c31:	55                   	push   %rbp
ffff800000109c32:	48 89 e5             	mov    %rsp,%rbp
ffff800000109c35:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000109c39:	0f 20 d0             	mov    %cr2,%rax
ffff800000109c3c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000109c40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109c44:	c9                   	leave
ffff800000109c45:	c3                   	ret

ffff800000109c46 <mkgate>:
{
ffff800000109c46:	f3 0f 1e fa          	endbr64
ffff800000109c4a:	55                   	push   %rbp
ffff800000109c4b:	48 89 e5             	mov    %rsp,%rbp
ffff800000109c4e:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000109c52:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000109c56:	89 75 e4             	mov    %esi,-0x1c(%rbp)
ffff800000109c59:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
ffff800000109c5d:	89 4d e0             	mov    %ecx,-0x20(%rbp)
  uint64 addr = (uint64) kva;
ffff800000109c60:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000109c64:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  n *= 4;
ffff800000109c68:	c1 65 e4 02          	shll   $0x2,-0x1c(%rbp)
  idt[n+0] = (addr & 0xFFFF) | (KERNEL_CS << 16);
ffff800000109c6c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109c70:	0f b7 d0             	movzwl %ax,%edx
ffff800000109c73:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff800000109c76:	48 8d 0c 85 00 00 00 	lea    0x0(,%rax,4),%rcx
ffff800000109c7d:	00 
ffff800000109c7e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109c82:	48 01 c8             	add    %rcx,%rax
ffff800000109c85:	81 ca 00 00 08 00    	or     $0x80000,%edx
ffff800000109c8b:	89 10                	mov    %edx,(%rax)
  idt[n+1] = (addr & 0xFFFF0000) | 0x8E00 | ((pl & 3) << 13);
ffff800000109c8d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109c91:	66 b8 00 00          	mov    $0x0,%ax
ffff800000109c95:	89 c2                	mov    %eax,%edx
ffff800000109c97:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff800000109c9a:	c1 e0 0d             	shl    $0xd,%eax
ffff800000109c9d:	25 00 60 00 00       	and    $0x6000,%eax
ffff800000109ca2:	09 c2                	or     %eax,%edx
ffff800000109ca4:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff800000109ca7:	83 c0 01             	add    $0x1,%eax
ffff800000109caa:	89 c0                	mov    %eax,%eax
ffff800000109cac:	48 8d 0c 85 00 00 00 	lea    0x0(,%rax,4),%rcx
ffff800000109cb3:	00 
ffff800000109cb4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109cb8:	48 01 c8             	add    %rcx,%rax
ffff800000109cbb:	80 ce 8e             	or     $0x8e,%dh
ffff800000109cbe:	89 10                	mov    %edx,(%rax)
  idt[n+2] = addr >> 32;
ffff800000109cc0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109cc4:	48 c1 e8 20          	shr    $0x20,%rax
ffff800000109cc8:	48 89 c1             	mov    %rax,%rcx
ffff800000109ccb:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff800000109cce:	83 c0 02             	add    $0x2,%eax
ffff800000109cd1:	89 c0                	mov    %eax,%eax
ffff800000109cd3:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff800000109cda:	00 
ffff800000109cdb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109cdf:	48 01 d0             	add    %rdx,%rax
ffff800000109ce2:	89 ca                	mov    %ecx,%edx
ffff800000109ce4:	89 10                	mov    %edx,(%rax)
  idt[n+3] = 0;
ffff800000109ce6:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff800000109ce9:	83 c0 03             	add    $0x3,%eax
ffff800000109cec:	89 c0                	mov    %eax,%eax
ffff800000109cee:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff800000109cf5:	00 
ffff800000109cf6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109cfa:	48 01 d0             	add    %rdx,%rax
ffff800000109cfd:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
}
ffff800000109d03:	90                   	nop
ffff800000109d04:	c9                   	leave
ffff800000109d05:	c3                   	ret

ffff800000109d06 <idtinit>:
{
ffff800000109d06:	f3 0f 1e fa          	endbr64
ffff800000109d0a:	55                   	push   %rbp
ffff800000109d0b:	48 89 e5             	mov    %rsp,%rbp
  lidt((void*) idt, PGSIZE);
ffff800000109d0e:	48 b8 c0 e4 11 00 00 	movabs $0xffff80000011e4c0,%rax
ffff800000109d15:	80 ff ff 
ffff800000109d18:	48 8b 00             	mov    (%rax),%rax
ffff800000109d1b:	be 00 10 00 00       	mov    $0x1000,%esi
ffff800000109d20:	48 89 c7             	mov    %rax,%rdi
ffff800000109d23:	48 b8 d2 9b 10 00 00 	movabs $0xffff800000109bd2,%rax
ffff800000109d2a:	80 ff ff 
ffff800000109d2d:	ff d0                	call   *%rax
}
ffff800000109d2f:	90                   	nop
ffff800000109d30:	5d                   	pop    %rbp
ffff800000109d31:	c3                   	ret

ffff800000109d32 <tvinit>:
{
ffff800000109d32:	f3 0f 1e fa          	endbr64
ffff800000109d36:	55                   	push   %rbp
ffff800000109d37:	48 89 e5             	mov    %rsp,%rbp
ffff800000109d3a:	48 83 ec 10          	sub    $0x10,%rsp
  idt = (uint*) kalloc();
ffff800000109d3e:	48 b8 00 43 10 00 00 	movabs $0xffff800000104300,%rax
ffff800000109d45:	80 ff ff 
ffff800000109d48:	ff d0                	call   *%rax
ffff800000109d4a:	48 ba c0 e4 11 00 00 	movabs $0xffff80000011e4c0,%rdx
ffff800000109d51:	80 ff ff 
ffff800000109d54:	48 89 02             	mov    %rax,(%rdx)
  memset(idt, 0, PGSIZE);
ffff800000109d57:	48 b8 c0 e4 11 00 00 	movabs $0xffff80000011e4c0,%rax
ffff800000109d5e:	80 ff ff 
ffff800000109d61:	48 8b 00             	mov    (%rax),%rax
ffff800000109d64:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff800000109d69:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000109d6e:	48 89 c7             	mov    %rax,%rdi
ffff800000109d71:	48 b8 87 7d 10 00 00 	movabs $0xffff800000107d87,%rax
ffff800000109d78:	80 ff ff 
ffff800000109d7b:	ff d0                	call   *%rax
  for (n = 0; n < 256; n++)
ffff800000109d7d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000109d84:	eb 3b                	jmp    ffff800000109dc1 <tvinit+0x8f>
    mkgate(idt, n, vectors[n], 0);
ffff800000109d86:	48 ba 60 d6 10 00 00 	movabs $0xffff80000010d660,%rdx
ffff800000109d8d:	80 ff ff 
ffff800000109d90:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000109d93:	48 98                	cltq
ffff800000109d95:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
ffff800000109d99:	8b 75 fc             	mov    -0x4(%rbp),%esi
ffff800000109d9c:	48 b8 c0 e4 11 00 00 	movabs $0xffff80000011e4c0,%rax
ffff800000109da3:	80 ff ff 
ffff800000109da6:	48 8b 00             	mov    (%rax),%rax
ffff800000109da9:	b9 00 00 00 00       	mov    $0x0,%ecx
ffff800000109dae:	48 89 c7             	mov    %rax,%rdi
ffff800000109db1:	48 b8 46 9c 10 00 00 	movabs $0xffff800000109c46,%rax
ffff800000109db8:	80 ff ff 
ffff800000109dbb:	ff d0                	call   *%rax
  for (n = 0; n < 256; n++)
ffff800000109dbd:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000109dc1:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
ffff800000109dc8:	7e bc                	jle    ffff800000109d86 <tvinit+0x54>
}
ffff800000109dca:	90                   	nop
ffff800000109dcb:	90                   	nop
ffff800000109dcc:	c9                   	leave
ffff800000109dcd:	c3                   	ret

ffff800000109dce <trap>:
{
ffff800000109dce:	f3 0f 1e fa          	endbr64
ffff800000109dd2:	55                   	push   %rbp
ffff800000109dd3:	48 89 e5             	mov    %rsp,%rbp
ffff800000109dd6:	41 54                	push   %r12
ffff800000109dd8:	53                   	push   %rbx
ffff800000109dd9:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000109ddd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  switch(tf->trapno){
ffff800000109de1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109de5:	48 8b 40 78          	mov    0x78(%rax),%rax
ffff800000109de9:	48 83 e8 20          	sub    $0x20,%rax
ffff800000109ded:	48 83 f8 1f          	cmp    $0x1f,%rax
ffff800000109df1:	0f 87 53 01 00 00    	ja     ffff800000109f4a <trap+0x17c>
ffff800000109df7:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff800000109dfe:	00 
ffff800000109dff:	48 b8 10 ca 10 00 00 	movabs $0xffff80000010ca10,%rax
ffff800000109e06:	80 ff ff 
ffff800000109e09:	48 01 d0             	add    %rdx,%rax
ffff800000109e0c:	48 8b 00             	mov    (%rax),%rax
ffff800000109e0f:	3e ff e0             	notrack jmp *%rax
    if(cpunum() == 0){
ffff800000109e12:	48 b8 12 48 10 00 00 	movabs $0xffff800000104812,%rax
ffff800000109e19:	80 ff ff 
ffff800000109e1c:	ff d0                	call   *%rax
ffff800000109e1e:	85 c0                	test   %eax,%eax
ffff800000109e20:	75 66                	jne    ffff800000109e88 <trap+0xba>
      acquire(&tickslock);
ffff800000109e22:	48 b8 e0 e4 11 00 00 	movabs $0xffff80000011e4e0,%rax
ffff800000109e29:	80 ff ff 
ffff800000109e2c:	48 89 c7             	mov    %rax,%rdi
ffff800000109e2f:	48 b8 cf 79 10 00 00 	movabs $0xffff8000001079cf,%rax
ffff800000109e36:	80 ff ff 
ffff800000109e39:	ff d0                	call   *%rax
      ticks++;
ffff800000109e3b:	48 b8 48 e5 11 00 00 	movabs $0xffff80000011e548,%rax
ffff800000109e42:	80 ff ff 
ffff800000109e45:	8b 00                	mov    (%rax),%eax
ffff800000109e47:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000109e4a:	48 b8 48 e5 11 00 00 	movabs $0xffff80000011e548,%rax
ffff800000109e51:	80 ff ff 
ffff800000109e54:	89 10                	mov    %edx,(%rax)
      wakeup(&ticks);
ffff800000109e56:	48 b8 48 e5 11 00 00 	movabs $0xffff80000011e548,%rax
ffff800000109e5d:	80 ff ff 
ffff800000109e60:	48 89 c7             	mov    %rax,%rdi
ffff800000109e63:	48 b8 21 72 10 00 00 	movabs $0xffff800000107221,%rax
ffff800000109e6a:	80 ff ff 
ffff800000109e6d:	ff d0                	call   *%rax
      release(&tickslock);
ffff800000109e6f:	48 b8 e0 e4 11 00 00 	movabs $0xffff80000011e4e0,%rax
ffff800000109e76:	80 ff ff 
ffff800000109e79:	48 89 c7             	mov    %rax,%rdi
ffff800000109e7c:	48 b8 72 7a 10 00 00 	movabs $0xffff800000107a72,%rax
ffff800000109e83:	80 ff ff 
ffff800000109e86:	ff d0                	call   *%rax
    lapiceoi();
ffff800000109e88:	48 b8 1b 49 10 00 00 	movabs $0xffff80000010491b,%rax
ffff800000109e8f:	80 ff ff 
ffff800000109e92:	ff d0                	call   *%rax
    break;
ffff800000109e94:	e9 2b 02 00 00       	jmp    ffff80000010a0c4 <trap+0x2f6>
    ideintr();
ffff800000109e99:	48 b8 bd 3c 10 00 00 	movabs $0xffff800000103cbd,%rax
ffff800000109ea0:	80 ff ff 
ffff800000109ea3:	ff d0                	call   *%rax
    lapiceoi();
ffff800000109ea5:	48 b8 1b 49 10 00 00 	movabs $0xffff80000010491b,%rax
ffff800000109eac:	80 ff ff 
ffff800000109eaf:	ff d0                	call   *%rax
    break;
ffff800000109eb1:	e9 0e 02 00 00       	jmp    ffff80000010a0c4 <trap+0x2f6>
    kbdintr();
ffff800000109eb6:	48 b8 b8 45 10 00 00 	movabs $0xffff8000001045b8,%rax
ffff800000109ebd:	80 ff ff 
ffff800000109ec0:	ff d0                	call   *%rax
    lapiceoi();
ffff800000109ec2:	48 b8 1b 49 10 00 00 	movabs $0xffff80000010491b,%rax
ffff800000109ec9:	80 ff ff 
ffff800000109ecc:	ff d0                	call   *%rax
    break;
ffff800000109ece:	e9 f1 01 00 00       	jmp    ffff80000010a0c4 <trap+0x2f6>
    uartintr();
ffff800000109ed3:	48 b8 04 a4 10 00 00 	movabs $0xffff80000010a404,%rax
ffff800000109eda:	80 ff ff 
ffff800000109edd:	ff d0                	call   *%rax
    lapiceoi();
ffff800000109edf:	48 b8 1b 49 10 00 00 	movabs $0xffff80000010491b,%rax
ffff800000109ee6:	80 ff ff 
ffff800000109ee9:	ff d0                	call   *%rax
    break;
ffff800000109eeb:	e9 d4 01 00 00       	jmp    ffff80000010a0c4 <trap+0x2f6>
    cprintf("cpu%d: spurious interrupt at %p:%p\n",
ffff800000109ef0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109ef4:	4c 8b a0 88 00 00 00 	mov    0x88(%rax),%r12
ffff800000109efb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109eff:	48 8b 98 90 00 00 00 	mov    0x90(%rax),%rbx
ffff800000109f06:	48 b8 12 48 10 00 00 	movabs $0xffff800000104812,%rax
ffff800000109f0d:	80 ff ff 
ffff800000109f10:	ff d0                	call   *%rax
ffff800000109f12:	4c 89 e1             	mov    %r12,%rcx
ffff800000109f15:	48 89 da             	mov    %rbx,%rdx
ffff800000109f18:	89 c6                	mov    %eax,%esi
ffff800000109f1a:	48 b8 58 c9 10 00 00 	movabs $0xffff80000010c958,%rax
ffff800000109f21:	80 ff ff 
ffff800000109f24:	48 89 c7             	mov    %rax,%rdi
ffff800000109f27:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109f2c:	49 b8 38 08 10 00 00 	movabs $0xffff800000100838,%r8
ffff800000109f33:	80 ff ff 
ffff800000109f36:	41 ff d0             	call   *%r8
    lapiceoi();
ffff800000109f39:	48 b8 1b 49 10 00 00 	movabs $0xffff80000010491b,%rax
ffff800000109f40:	80 ff ff 
ffff800000109f43:	ff d0                	call   *%rax
    break;
ffff800000109f45:	e9 7a 01 00 00       	jmp    ffff80000010a0c4 <trap+0x2f6>
    if(proc == 0 || (tf->cs&3) == 0){
ffff800000109f4a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109f51:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109f55:	48 85 c0             	test   %rax,%rax
ffff800000109f58:	74 17                	je     ffff800000109f71 <trap+0x1a3>
ffff800000109f5a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109f5e:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
ffff800000109f65:	83 e0 03             	and    $0x3,%eax
ffff800000109f68:	48 85 c0             	test   %rax,%rax
ffff800000109f6b:	0f 85 af 00 00 00    	jne    ffff80000010a020 <trap+0x252>
      cprintf("unexpected trap %d from cpu %d rip %p (cr2=0x%p)\n",
ffff800000109f71:	48 b8 2d 9c 10 00 00 	movabs $0xffff800000109c2d,%rax
ffff800000109f78:	80 ff ff 
ffff800000109f7b:	ff d0                	call   *%rax
ffff800000109f7d:	49 89 c4             	mov    %rax,%r12
ffff800000109f80:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109f84:	48 8b 98 88 00 00 00 	mov    0x88(%rax),%rbx
ffff800000109f8b:	48 b8 12 48 10 00 00 	movabs $0xffff800000104812,%rax
ffff800000109f92:	80 ff ff 
ffff800000109f95:	ff d0                	call   *%rax
ffff800000109f97:	89 c2                	mov    %eax,%edx
ffff800000109f99:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109f9d:	48 8b 40 78          	mov    0x78(%rax),%rax
ffff800000109fa1:	4d 89 e0             	mov    %r12,%r8
ffff800000109fa4:	48 89 d9             	mov    %rbx,%rcx
ffff800000109fa7:	48 89 c6             	mov    %rax,%rsi
ffff800000109faa:	48 b8 80 c9 10 00 00 	movabs $0xffff80000010c980,%rax
ffff800000109fb1:	80 ff ff 
ffff800000109fb4:	48 89 c7             	mov    %rax,%rdi
ffff800000109fb7:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109fbc:	49 b9 38 08 10 00 00 	movabs $0xffff800000100838,%r9
ffff800000109fc3:	80 ff ff 
ffff800000109fc6:	41 ff d1             	call   *%r9
      if (proc)
ffff800000109fc9:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109fd0:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109fd4:	48 85 c0             	test   %rax,%rax
ffff800000109fd7:	74 2e                	je     ffff80000010a007 <trap+0x239>
        cprintf("proc id: %d\n", proc->pid);
ffff800000109fd9:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109fe0:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109fe4:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff800000109fe7:	89 c6                	mov    %eax,%esi
ffff800000109fe9:	48 b8 b2 c9 10 00 00 	movabs $0xffff80000010c9b2,%rax
ffff800000109ff0:	80 ff ff 
ffff800000109ff3:	48 89 c7             	mov    %rax,%rdi
ffff800000109ff6:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109ffb:	48 ba 38 08 10 00 00 	movabs $0xffff800000100838,%rdx
ffff80000010a002:	80 ff ff 
ffff80000010a005:	ff d2                	call   *%rdx
      panic("trap");
ffff80000010a007:	48 b8 bf c9 10 00 00 	movabs $0xffff80000010c9bf,%rax
ffff80000010a00e:	80 ff ff 
ffff80000010a011:	48 89 c7             	mov    %rax,%rdi
ffff80000010a014:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010a01b:	80 ff ff 
ffff80000010a01e:	ff d0                	call   *%rax
    cprintf("pid %d %s: trap %d err %d on cpu %d "
ffff80000010a020:	48 b8 2d 9c 10 00 00 	movabs $0xffff800000109c2d,%rax
ffff80000010a027:	80 ff ff 
ffff80000010a02a:	ff d0                	call   *%rax
ffff80000010a02c:	48 89 c3             	mov    %rax,%rbx
ffff80000010a02f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a033:	4c 8b a0 88 00 00 00 	mov    0x88(%rax),%r12
ffff80000010a03a:	48 b8 12 48 10 00 00 	movabs $0xffff800000104812,%rax
ffff80000010a041:	80 ff ff 
ffff80000010a044:	ff d0                	call   *%rax
ffff80000010a046:	89 c1                	mov    %eax,%ecx
ffff80000010a048:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a04c:	48 8b b8 80 00 00 00 	mov    0x80(%rax),%rdi
ffff80000010a053:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a057:	48 8b 50 78          	mov    0x78(%rax),%rdx
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->rip,
ffff80000010a05b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010a062:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010a066:	48 8d b0 d0 00 00 00 	lea    0xd0(%rax),%rsi
ffff80000010a06d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010a074:	64 48 8b 00          	mov    %fs:(%rax),%rax
    cprintf("pid %d %s: trap %d err %d on cpu %d "
ffff80000010a078:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff80000010a07b:	53                   	push   %rbx
ffff80000010a07c:	41 54                	push   %r12
ffff80000010a07e:	41 89 c9             	mov    %ecx,%r9d
ffff80000010a081:	49 89 f8             	mov    %rdi,%r8
ffff80000010a084:	48 89 d1             	mov    %rdx,%rcx
ffff80000010a087:	48 89 f2             	mov    %rsi,%rdx
ffff80000010a08a:	89 c6                	mov    %eax,%esi
ffff80000010a08c:	48 b8 c8 c9 10 00 00 	movabs $0xffff80000010c9c8,%rax
ffff80000010a093:	80 ff ff 
ffff80000010a096:	48 89 c7             	mov    %rax,%rdi
ffff80000010a099:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010a09e:	49 ba 38 08 10 00 00 	movabs $0xffff800000100838,%r10
ffff80000010a0a5:	80 ff ff 
ffff80000010a0a8:	41 ff d2             	call   *%r10
ffff80000010a0ab:	48 83 c4 10          	add    $0x10,%rsp
    proc->killed = 1;
ffff80000010a0af:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010a0b6:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010a0ba:	c7 40 40 01 00 00 00 	movl   $0x1,0x40(%rax)
ffff80000010a0c1:	eb 01                	jmp    ffff80000010a0c4 <trap+0x2f6>
    break;
ffff80000010a0c3:	90                   	nop
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
ffff80000010a0c4:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010a0cb:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010a0cf:	48 85 c0             	test   %rax,%rax
ffff80000010a0d2:	74 32                	je     ffff80000010a106 <trap+0x338>
ffff80000010a0d4:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010a0db:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010a0df:	8b 40 40             	mov    0x40(%rax),%eax
ffff80000010a0e2:	85 c0                	test   %eax,%eax
ffff80000010a0e4:	74 20                	je     ffff80000010a106 <trap+0x338>
ffff80000010a0e6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a0ea:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
ffff80000010a0f1:	83 e0 03             	and    $0x3,%eax
ffff80000010a0f4:	48 83 f8 03          	cmp    $0x3,%rax
ffff80000010a0f8:	75 0c                	jne    ffff80000010a106 <trap+0x338>
    exit();
ffff80000010a0fa:	48 b8 fd 69 10 00 00 	movabs $0xffff8000001069fd,%rax
ffff80000010a101:	80 ff ff 
ffff80000010a104:	ff d0                	call   *%rax
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
ffff80000010a106:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010a10d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010a111:	48 85 c0             	test   %rax,%rax
ffff80000010a114:	74 2d                	je     ffff80000010a143 <trap+0x375>
ffff80000010a116:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010a11d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010a121:	8b 40 18             	mov    0x18(%rax),%eax
ffff80000010a124:	83 f8 04             	cmp    $0x4,%eax
ffff80000010a127:	75 1a                	jne    ffff80000010a143 <trap+0x375>
ffff80000010a129:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a12d:	48 8b 40 78          	mov    0x78(%rax),%rax
ffff80000010a131:	48 83 f8 20          	cmp    $0x20,%rax
ffff80000010a135:	75 0c                	jne    ffff80000010a143 <trap+0x375>
    yield();
ffff80000010a137:	48 b8 e3 6f 10 00 00 	movabs $0xffff800000106fe3,%rax
ffff80000010a13e:	80 ff ff 
ffff80000010a141:	ff d0                	call   *%rax
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
ffff80000010a143:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010a14a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010a14e:	48 85 c0             	test   %rax,%rax
ffff80000010a151:	74 32                	je     ffff80000010a185 <trap+0x3b7>
ffff80000010a153:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010a15a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010a15e:	8b 40 40             	mov    0x40(%rax),%eax
ffff80000010a161:	85 c0                	test   %eax,%eax
ffff80000010a163:	74 20                	je     ffff80000010a185 <trap+0x3b7>
ffff80000010a165:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a169:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
ffff80000010a170:	83 e0 03             	and    $0x3,%eax
ffff80000010a173:	48 83 f8 03          	cmp    $0x3,%rax
ffff80000010a177:	75 0c                	jne    ffff80000010a185 <trap+0x3b7>
    exit();
ffff80000010a179:	48 b8 fd 69 10 00 00 	movabs $0xffff8000001069fd,%rax
ffff80000010a180:	80 ff ff 
ffff80000010a183:	ff d0                	call   *%rax
}
ffff80000010a185:	90                   	nop
ffff80000010a186:	48 8d 65 f0          	lea    -0x10(%rbp),%rsp
ffff80000010a18a:	5b                   	pop    %rbx
ffff80000010a18b:	41 5c                	pop    %r12
ffff80000010a18d:	5d                   	pop    %rbp
ffff80000010a18e:	c3                   	ret

ffff80000010a18f <inb>:
// Intel 8250 serial port (UART).

#include "types.h"
#include "defs.h"
#include "param.h"
ffff80000010a18f:	f3 0f 1e fa          	endbr64
ffff80000010a193:	55                   	push   %rbp
ffff80000010a194:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a197:	48 83 ec 18          	sub    $0x18,%rsp
ffff80000010a19b:	89 f8                	mov    %edi,%eax
ffff80000010a19d:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
#include "traps.h"
#include "spinlock.h"
#include "sleeplock.h"
ffff80000010a1a1:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff80000010a1a5:	89 c2                	mov    %eax,%edx
ffff80000010a1a7:	ec                   	in     (%dx),%al
ffff80000010a1a8:	88 45 ff             	mov    %al,-0x1(%rbp)
#include "fs.h"
ffff80000010a1ab:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
#include "file.h"
ffff80000010a1af:	c9                   	leave
ffff80000010a1b0:	c3                   	ret

ffff80000010a1b1 <outb>:

void
uartearlyinit(void)
{
  char *p;

ffff80000010a1b1:	f3 0f 1e fa          	endbr64
ffff80000010a1b5:	55                   	push   %rbp
ffff80000010a1b6:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a1b9:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010a1bd:	89 fa                	mov    %edi,%edx
ffff80000010a1bf:	89 f0                	mov    %esi,%eax
ffff80000010a1c1:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffff80000010a1c5:	88 45 f8             	mov    %al,-0x8(%rbp)
  // Turn off the FIFO
ffff80000010a1c8:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffff80000010a1cc:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffff80000010a1d0:	ee                   	out    %al,(%dx)
  outb(COM1+2, 0);
ffff80000010a1d1:	90                   	nop
ffff80000010a1d2:	c9                   	leave
ffff80000010a1d3:	c3                   	ret

ffff80000010a1d4 <uartearlyinit>:
{
ffff80000010a1d4:	f3 0f 1e fa          	endbr64
ffff80000010a1d8:	55                   	push   %rbp
ffff80000010a1d9:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a1dc:	48 83 ec 10          	sub    $0x10,%rsp
  outb(COM1+2, 0);
ffff80000010a1e0:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010a1e5:	bf fa 03 00 00       	mov    $0x3fa,%edi
ffff80000010a1ea:	48 b8 b1 a1 10 00 00 	movabs $0xffff80000010a1b1,%rax
ffff80000010a1f1:	80 ff ff 
ffff80000010a1f4:	ff d0                	call   *%rax

  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
ffff80000010a1f6:	be 80 00 00 00       	mov    $0x80,%esi
ffff80000010a1fb:	bf fb 03 00 00       	mov    $0x3fb,%edi
ffff80000010a200:	48 b8 b1 a1 10 00 00 	movabs $0xffff80000010a1b1,%rax
ffff80000010a207:	80 ff ff 
ffff80000010a20a:	ff d0                	call   *%rax
  outb(COM1+0, 115200/9600);
ffff80000010a20c:	be 0c 00 00 00       	mov    $0xc,%esi
ffff80000010a211:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffff80000010a216:	48 b8 b1 a1 10 00 00 	movabs $0xffff80000010a1b1,%rax
ffff80000010a21d:	80 ff ff 
ffff80000010a220:	ff d0                	call   *%rax
  outb(COM1+1, 0);
ffff80000010a222:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010a227:	bf f9 03 00 00       	mov    $0x3f9,%edi
ffff80000010a22c:	48 b8 b1 a1 10 00 00 	movabs $0xffff80000010a1b1,%rax
ffff80000010a233:	80 ff ff 
ffff80000010a236:	ff d0                	call   *%rax
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
ffff80000010a238:	be 03 00 00 00       	mov    $0x3,%esi
ffff80000010a23d:	bf fb 03 00 00       	mov    $0x3fb,%edi
ffff80000010a242:	48 b8 b1 a1 10 00 00 	movabs $0xffff80000010a1b1,%rax
ffff80000010a249:	80 ff ff 
ffff80000010a24c:	ff d0                	call   *%rax
  outb(COM1+4, 0);
ffff80000010a24e:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010a253:	bf fc 03 00 00       	mov    $0x3fc,%edi
ffff80000010a258:	48 b8 b1 a1 10 00 00 	movabs $0xffff80000010a1b1,%rax
ffff80000010a25f:	80 ff ff 
ffff80000010a262:	ff d0                	call   *%rax
  outb(COM1+1, 0x01);    // Enable receive interrupts.
ffff80000010a264:	be 01 00 00 00       	mov    $0x1,%esi
ffff80000010a269:	bf f9 03 00 00       	mov    $0x3f9,%edi
ffff80000010a26e:	48 b8 b1 a1 10 00 00 	movabs $0xffff80000010a1b1,%rax
ffff80000010a275:	80 ff ff 
ffff80000010a278:	ff d0                	call   *%rax

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
ffff80000010a27a:	bf fd 03 00 00       	mov    $0x3fd,%edi
ffff80000010a27f:	48 b8 8f a1 10 00 00 	movabs $0xffff80000010a18f,%rax
ffff80000010a286:	80 ff ff 
ffff80000010a289:	ff d0                	call   *%rax
ffff80000010a28b:	3c ff                	cmp    $0xff,%al
ffff80000010a28d:	74 4a                	je     ffff80000010a2d9 <uartearlyinit+0x105>
    return;
  uart = 1;
ffff80000010a28f:	48 b8 4c e5 11 00 00 	movabs $0xffff80000011e54c,%rax
ffff80000010a296:	80 ff ff 
ffff80000010a299:	c7 00 01 00 00 00    	movl   $0x1,(%rax)



  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
ffff80000010a29f:	48 b8 10 cb 10 00 00 	movabs $0xffff80000010cb10,%rax
ffff80000010a2a6:	80 ff ff 
ffff80000010a2a9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010a2ad:	eb 1d                	jmp    ffff80000010a2cc <uartearlyinit+0xf8>
    uartputc(*p);
ffff80000010a2af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a2b3:	0f b6 00             	movzbl (%rax),%eax
ffff80000010a2b6:	0f be c0             	movsbl %al,%eax
ffff80000010a2b9:	89 c7                	mov    %eax,%edi
ffff80000010a2bb:	48 b8 31 a3 10 00 00 	movabs $0xffff80000010a331,%rax
ffff80000010a2c2:	80 ff ff 
ffff80000010a2c5:	ff d0                	call   *%rax
  for(p="xv6...\n"; *p; p++)
ffff80000010a2c7:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffff80000010a2cc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a2d0:	0f b6 00             	movzbl (%rax),%eax
ffff80000010a2d3:	84 c0                	test   %al,%al
ffff80000010a2d5:	75 d8                	jne    ffff80000010a2af <uartearlyinit+0xdb>
ffff80000010a2d7:	eb 01                	jmp    ffff80000010a2da <uartearlyinit+0x106>
    return;
ffff80000010a2d9:	90                   	nop
}
ffff80000010a2da:	c9                   	leave
ffff80000010a2db:	c3                   	ret

ffff80000010a2dc <uartinit>:

void
uartinit(void)
{
ffff80000010a2dc:	f3 0f 1e fa          	endbr64
ffff80000010a2e0:	55                   	push   %rbp
ffff80000010a2e1:	48 89 e5             	mov    %rsp,%rbp
  if(!uart)
ffff80000010a2e4:	48 b8 4c e5 11 00 00 	movabs $0xffff80000011e54c,%rax
ffff80000010a2eb:	80 ff ff 
ffff80000010a2ee:	8b 00                	mov    (%rax),%eax
ffff80000010a2f0:	85 c0                	test   %eax,%eax
ffff80000010a2f2:	74 3a                	je     ffff80000010a32e <uartinit+0x52>
    return;

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
ffff80000010a2f4:	bf fa 03 00 00       	mov    $0x3fa,%edi
ffff80000010a2f9:	48 b8 8f a1 10 00 00 	movabs $0xffff80000010a18f,%rax
ffff80000010a300:	80 ff ff 
ffff80000010a303:	ff d0                	call   *%rax
  inb(COM1+0);
ffff80000010a305:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffff80000010a30a:	48 b8 8f a1 10 00 00 	movabs $0xffff80000010a18f,%rax
ffff80000010a311:	80 ff ff 
ffff80000010a314:	ff d0                	call   *%rax
  ioapicenable(IRQ_COM1, 0);
ffff80000010a316:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010a31b:	bf 04 00 00 00       	mov    $0x4,%edi
ffff80000010a320:	48 b8 b6 40 10 00 00 	movabs $0xffff8000001040b6,%rax
ffff80000010a327:	80 ff ff 
ffff80000010a32a:	ff d0                	call   *%rax
ffff80000010a32c:	eb 01                	jmp    ffff80000010a32f <uartinit+0x53>
    return;
ffff80000010a32e:	90                   	nop

}
ffff80000010a32f:	5d                   	pop    %rbp
ffff80000010a330:	c3                   	ret

ffff80000010a331 <uartputc>:
void
uartputc(int c)
{
ffff80000010a331:	f3 0f 1e fa          	endbr64
ffff80000010a335:	55                   	push   %rbp
ffff80000010a336:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a339:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010a33d:	89 7d ec             	mov    %edi,-0x14(%rbp)
  int i;

  if(!uart)
ffff80000010a340:	48 b8 4c e5 11 00 00 	movabs $0xffff80000011e54c,%rax
ffff80000010a347:	80 ff ff 
ffff80000010a34a:	8b 00                	mov    (%rax),%eax
ffff80000010a34c:	85 c0                	test   %eax,%eax
ffff80000010a34e:	74 5a                	je     ffff80000010a3aa <uartputc+0x79>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
ffff80000010a350:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010a357:	eb 15                	jmp    ffff80000010a36e <uartputc+0x3d>
    microdelay(10);
ffff80000010a359:	bf 0a 00 00 00       	mov    $0xa,%edi
ffff80000010a35e:	48 b8 4e 49 10 00 00 	movabs $0xffff80000010494e,%rax
ffff80000010a365:	80 ff ff 
ffff80000010a368:	ff d0                	call   *%rax
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
ffff80000010a36a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff80000010a36e:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
ffff80000010a372:	7f 1b                	jg     ffff80000010a38f <uartputc+0x5e>
ffff80000010a374:	bf fd 03 00 00       	mov    $0x3fd,%edi
ffff80000010a379:	48 b8 8f a1 10 00 00 	movabs $0xffff80000010a18f,%rax
ffff80000010a380:	80 ff ff 
ffff80000010a383:	ff d0                	call   *%rax
ffff80000010a385:	0f b6 c0             	movzbl %al,%eax
ffff80000010a388:	83 e0 20             	and    $0x20,%eax
ffff80000010a38b:	85 c0                	test   %eax,%eax
ffff80000010a38d:	74 ca                	je     ffff80000010a359 <uartputc+0x28>
  outb(COM1+0, c);
ffff80000010a38f:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff80000010a392:	0f b6 c0             	movzbl %al,%eax
ffff80000010a395:	89 c6                	mov    %eax,%esi
ffff80000010a397:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffff80000010a39c:	48 b8 b1 a1 10 00 00 	movabs $0xffff80000010a1b1,%rax
ffff80000010a3a3:	80 ff ff 
ffff80000010a3a6:	ff d0                	call   *%rax
ffff80000010a3a8:	eb 01                	jmp    ffff80000010a3ab <uartputc+0x7a>
    return;
ffff80000010a3aa:	90                   	nop
}
ffff80000010a3ab:	c9                   	leave
ffff80000010a3ac:	c3                   	ret

ffff80000010a3ad <uartgetc>:

static int
uartgetc(void)
{
ffff80000010a3ad:	f3 0f 1e fa          	endbr64
ffff80000010a3b1:	55                   	push   %rbp
ffff80000010a3b2:	48 89 e5             	mov    %rsp,%rbp
  if(!uart)
ffff80000010a3b5:	48 b8 4c e5 11 00 00 	movabs $0xffff80000011e54c,%rax
ffff80000010a3bc:	80 ff ff 
ffff80000010a3bf:	8b 00                	mov    (%rax),%eax
ffff80000010a3c1:	85 c0                	test   %eax,%eax
ffff80000010a3c3:	75 07                	jne    ffff80000010a3cc <uartgetc+0x1f>
    return -1;
ffff80000010a3c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010a3ca:	eb 36                	jmp    ffff80000010a402 <uartgetc+0x55>
  if(!(inb(COM1+5) & 0x01))
ffff80000010a3cc:	bf fd 03 00 00       	mov    $0x3fd,%edi
ffff80000010a3d1:	48 b8 8f a1 10 00 00 	movabs $0xffff80000010a18f,%rax
ffff80000010a3d8:	80 ff ff 
ffff80000010a3db:	ff d0                	call   *%rax
ffff80000010a3dd:	0f b6 c0             	movzbl %al,%eax
ffff80000010a3e0:	83 e0 01             	and    $0x1,%eax
ffff80000010a3e3:	85 c0                	test   %eax,%eax
ffff80000010a3e5:	75 07                	jne    ffff80000010a3ee <uartgetc+0x41>
    return -1;
ffff80000010a3e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010a3ec:	eb 14                	jmp    ffff80000010a402 <uartgetc+0x55>
  return inb(COM1+0);
ffff80000010a3ee:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffff80000010a3f3:	48 b8 8f a1 10 00 00 	movabs $0xffff80000010a18f,%rax
ffff80000010a3fa:	80 ff ff 
ffff80000010a3fd:	ff d0                	call   *%rax
ffff80000010a3ff:	0f b6 c0             	movzbl %al,%eax
}
ffff80000010a402:	5d                   	pop    %rbp
ffff80000010a403:	c3                   	ret

ffff80000010a404 <uartintr>:

void
uartintr(void)
{
ffff80000010a404:	f3 0f 1e fa          	endbr64
ffff80000010a408:	55                   	push   %rbp
ffff80000010a409:	48 89 e5             	mov    %rsp,%rbp
  consoleintr(uartgetc);
ffff80000010a40c:	48 b8 ad a3 10 00 00 	movabs $0xffff80000010a3ad,%rax
ffff80000010a413:	80 ff ff 
ffff80000010a416:	48 89 c7             	mov    %rax,%rdi
ffff80000010a419:	48 b8 b5 0f 10 00 00 	movabs $0xffff800000100fb5,%rax
ffff80000010a420:	80 ff ff 
ffff80000010a423:	ff d0                	call   *%rax
}
ffff80000010a425:	90                   	nop
ffff80000010a426:	5d                   	pop    %rbp
ffff80000010a427:	c3                   	ret

ffff80000010a428 <vector0>:
ffff80000010a428:	6a 00                	push   $0x0
ffff80000010a42a:	6a 00                	push   $0x0
ffff80000010a42c:	e9 ef f6 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a431 <vector1>:
ffff80000010a431:	6a 00                	push   $0x0
ffff80000010a433:	6a 01                	push   $0x1
ffff80000010a435:	e9 e6 f6 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a43a <vector2>:
ffff80000010a43a:	6a 00                	push   $0x0
ffff80000010a43c:	6a 02                	push   $0x2
ffff80000010a43e:	e9 dd f6 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a443 <vector3>:
ffff80000010a443:	6a 00                	push   $0x0
ffff80000010a445:	6a 03                	push   $0x3
ffff80000010a447:	e9 d4 f6 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a44c <vector4>:
ffff80000010a44c:	6a 00                	push   $0x0
ffff80000010a44e:	6a 04                	push   $0x4
ffff80000010a450:	e9 cb f6 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a455 <vector5>:
ffff80000010a455:	6a 00                	push   $0x0
ffff80000010a457:	6a 05                	push   $0x5
ffff80000010a459:	e9 c2 f6 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a45e <vector6>:
ffff80000010a45e:	6a 00                	push   $0x0
ffff80000010a460:	6a 06                	push   $0x6
ffff80000010a462:	e9 b9 f6 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a467 <vector7>:
ffff80000010a467:	6a 00                	push   $0x0
ffff80000010a469:	6a 07                	push   $0x7
ffff80000010a46b:	e9 b0 f6 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a470 <vector8>:
ffff80000010a470:	6a 08                	push   $0x8
ffff80000010a472:	e9 a9 f6 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a477 <vector9>:
ffff80000010a477:	6a 00                	push   $0x0
ffff80000010a479:	6a 09                	push   $0x9
ffff80000010a47b:	e9 a0 f6 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a480 <vector10>:
ffff80000010a480:	6a 0a                	push   $0xa
ffff80000010a482:	e9 99 f6 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a487 <vector11>:
ffff80000010a487:	6a 0b                	push   $0xb
ffff80000010a489:	e9 92 f6 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a48e <vector12>:
ffff80000010a48e:	6a 0c                	push   $0xc
ffff80000010a490:	e9 8b f6 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a495 <vector13>:
ffff80000010a495:	6a 0d                	push   $0xd
ffff80000010a497:	e9 84 f6 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a49c <vector14>:
ffff80000010a49c:	6a 0e                	push   $0xe
ffff80000010a49e:	e9 7d f6 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a4a3 <vector15>:
ffff80000010a4a3:	6a 00                	push   $0x0
ffff80000010a4a5:	6a 0f                	push   $0xf
ffff80000010a4a7:	e9 74 f6 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a4ac <vector16>:
ffff80000010a4ac:	6a 00                	push   $0x0
ffff80000010a4ae:	6a 10                	push   $0x10
ffff80000010a4b0:	e9 6b f6 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a4b5 <vector17>:
ffff80000010a4b5:	6a 11                	push   $0x11
ffff80000010a4b7:	e9 64 f6 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a4bc <vector18>:
ffff80000010a4bc:	6a 00                	push   $0x0
ffff80000010a4be:	6a 12                	push   $0x12
ffff80000010a4c0:	e9 5b f6 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a4c5 <vector19>:
ffff80000010a4c5:	6a 00                	push   $0x0
ffff80000010a4c7:	6a 13                	push   $0x13
ffff80000010a4c9:	e9 52 f6 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a4ce <vector20>:
ffff80000010a4ce:	6a 00                	push   $0x0
ffff80000010a4d0:	6a 14                	push   $0x14
ffff80000010a4d2:	e9 49 f6 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a4d7 <vector21>:
ffff80000010a4d7:	6a 00                	push   $0x0
ffff80000010a4d9:	6a 15                	push   $0x15
ffff80000010a4db:	e9 40 f6 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a4e0 <vector22>:
ffff80000010a4e0:	6a 00                	push   $0x0
ffff80000010a4e2:	6a 16                	push   $0x16
ffff80000010a4e4:	e9 37 f6 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a4e9 <vector23>:
ffff80000010a4e9:	6a 00                	push   $0x0
ffff80000010a4eb:	6a 17                	push   $0x17
ffff80000010a4ed:	e9 2e f6 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a4f2 <vector24>:
ffff80000010a4f2:	6a 00                	push   $0x0
ffff80000010a4f4:	6a 18                	push   $0x18
ffff80000010a4f6:	e9 25 f6 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a4fb <vector25>:
ffff80000010a4fb:	6a 00                	push   $0x0
ffff80000010a4fd:	6a 19                	push   $0x19
ffff80000010a4ff:	e9 1c f6 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a504 <vector26>:
ffff80000010a504:	6a 00                	push   $0x0
ffff80000010a506:	6a 1a                	push   $0x1a
ffff80000010a508:	e9 13 f6 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a50d <vector27>:
ffff80000010a50d:	6a 00                	push   $0x0
ffff80000010a50f:	6a 1b                	push   $0x1b
ffff80000010a511:	e9 0a f6 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a516 <vector28>:
ffff80000010a516:	6a 00                	push   $0x0
ffff80000010a518:	6a 1c                	push   $0x1c
ffff80000010a51a:	e9 01 f6 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a51f <vector29>:
ffff80000010a51f:	6a 00                	push   $0x0
ffff80000010a521:	6a 1d                	push   $0x1d
ffff80000010a523:	e9 f8 f5 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a528 <vector30>:
ffff80000010a528:	6a 00                	push   $0x0
ffff80000010a52a:	6a 1e                	push   $0x1e
ffff80000010a52c:	e9 ef f5 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a531 <vector31>:
ffff80000010a531:	6a 00                	push   $0x0
ffff80000010a533:	6a 1f                	push   $0x1f
ffff80000010a535:	e9 e6 f5 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a53a <vector32>:
ffff80000010a53a:	6a 00                	push   $0x0
ffff80000010a53c:	6a 20                	push   $0x20
ffff80000010a53e:	e9 dd f5 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a543 <vector33>:
ffff80000010a543:	6a 00                	push   $0x0
ffff80000010a545:	6a 21                	push   $0x21
ffff80000010a547:	e9 d4 f5 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a54c <vector34>:
ffff80000010a54c:	6a 00                	push   $0x0
ffff80000010a54e:	6a 22                	push   $0x22
ffff80000010a550:	e9 cb f5 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a555 <vector35>:
ffff80000010a555:	6a 00                	push   $0x0
ffff80000010a557:	6a 23                	push   $0x23
ffff80000010a559:	e9 c2 f5 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a55e <vector36>:
ffff80000010a55e:	6a 00                	push   $0x0
ffff80000010a560:	6a 24                	push   $0x24
ffff80000010a562:	e9 b9 f5 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a567 <vector37>:
ffff80000010a567:	6a 00                	push   $0x0
ffff80000010a569:	6a 25                	push   $0x25
ffff80000010a56b:	e9 b0 f5 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a570 <vector38>:
ffff80000010a570:	6a 00                	push   $0x0
ffff80000010a572:	6a 26                	push   $0x26
ffff80000010a574:	e9 a7 f5 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a579 <vector39>:
ffff80000010a579:	6a 00                	push   $0x0
ffff80000010a57b:	6a 27                	push   $0x27
ffff80000010a57d:	e9 9e f5 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a582 <vector40>:
ffff80000010a582:	6a 00                	push   $0x0
ffff80000010a584:	6a 28                	push   $0x28
ffff80000010a586:	e9 95 f5 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a58b <vector41>:
ffff80000010a58b:	6a 00                	push   $0x0
ffff80000010a58d:	6a 29                	push   $0x29
ffff80000010a58f:	e9 8c f5 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a594 <vector42>:
ffff80000010a594:	6a 00                	push   $0x0
ffff80000010a596:	6a 2a                	push   $0x2a
ffff80000010a598:	e9 83 f5 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a59d <vector43>:
ffff80000010a59d:	6a 00                	push   $0x0
ffff80000010a59f:	6a 2b                	push   $0x2b
ffff80000010a5a1:	e9 7a f5 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a5a6 <vector44>:
ffff80000010a5a6:	6a 00                	push   $0x0
ffff80000010a5a8:	6a 2c                	push   $0x2c
ffff80000010a5aa:	e9 71 f5 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a5af <vector45>:
ffff80000010a5af:	6a 00                	push   $0x0
ffff80000010a5b1:	6a 2d                	push   $0x2d
ffff80000010a5b3:	e9 68 f5 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a5b8 <vector46>:
ffff80000010a5b8:	6a 00                	push   $0x0
ffff80000010a5ba:	6a 2e                	push   $0x2e
ffff80000010a5bc:	e9 5f f5 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a5c1 <vector47>:
ffff80000010a5c1:	6a 00                	push   $0x0
ffff80000010a5c3:	6a 2f                	push   $0x2f
ffff80000010a5c5:	e9 56 f5 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a5ca <vector48>:
ffff80000010a5ca:	6a 00                	push   $0x0
ffff80000010a5cc:	6a 30                	push   $0x30
ffff80000010a5ce:	e9 4d f5 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a5d3 <vector49>:
ffff80000010a5d3:	6a 00                	push   $0x0
ffff80000010a5d5:	6a 31                	push   $0x31
ffff80000010a5d7:	e9 44 f5 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a5dc <vector50>:
ffff80000010a5dc:	6a 00                	push   $0x0
ffff80000010a5de:	6a 32                	push   $0x32
ffff80000010a5e0:	e9 3b f5 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a5e5 <vector51>:
ffff80000010a5e5:	6a 00                	push   $0x0
ffff80000010a5e7:	6a 33                	push   $0x33
ffff80000010a5e9:	e9 32 f5 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a5ee <vector52>:
ffff80000010a5ee:	6a 00                	push   $0x0
ffff80000010a5f0:	6a 34                	push   $0x34
ffff80000010a5f2:	e9 29 f5 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a5f7 <vector53>:
ffff80000010a5f7:	6a 00                	push   $0x0
ffff80000010a5f9:	6a 35                	push   $0x35
ffff80000010a5fb:	e9 20 f5 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a600 <vector54>:
ffff80000010a600:	6a 00                	push   $0x0
ffff80000010a602:	6a 36                	push   $0x36
ffff80000010a604:	e9 17 f5 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a609 <vector55>:
ffff80000010a609:	6a 00                	push   $0x0
ffff80000010a60b:	6a 37                	push   $0x37
ffff80000010a60d:	e9 0e f5 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a612 <vector56>:
ffff80000010a612:	6a 00                	push   $0x0
ffff80000010a614:	6a 38                	push   $0x38
ffff80000010a616:	e9 05 f5 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a61b <vector57>:
ffff80000010a61b:	6a 00                	push   $0x0
ffff80000010a61d:	6a 39                	push   $0x39
ffff80000010a61f:	e9 fc f4 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a624 <vector58>:
ffff80000010a624:	6a 00                	push   $0x0
ffff80000010a626:	6a 3a                	push   $0x3a
ffff80000010a628:	e9 f3 f4 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a62d <vector59>:
ffff80000010a62d:	6a 00                	push   $0x0
ffff80000010a62f:	6a 3b                	push   $0x3b
ffff80000010a631:	e9 ea f4 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a636 <vector60>:
ffff80000010a636:	6a 00                	push   $0x0
ffff80000010a638:	6a 3c                	push   $0x3c
ffff80000010a63a:	e9 e1 f4 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a63f <vector61>:
ffff80000010a63f:	6a 00                	push   $0x0
ffff80000010a641:	6a 3d                	push   $0x3d
ffff80000010a643:	e9 d8 f4 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a648 <vector62>:
ffff80000010a648:	6a 00                	push   $0x0
ffff80000010a64a:	6a 3e                	push   $0x3e
ffff80000010a64c:	e9 cf f4 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a651 <vector63>:
ffff80000010a651:	6a 00                	push   $0x0
ffff80000010a653:	6a 3f                	push   $0x3f
ffff80000010a655:	e9 c6 f4 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a65a <vector64>:
ffff80000010a65a:	6a 00                	push   $0x0
ffff80000010a65c:	6a 40                	push   $0x40
ffff80000010a65e:	e9 bd f4 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a663 <vector65>:
ffff80000010a663:	6a 00                	push   $0x0
ffff80000010a665:	6a 41                	push   $0x41
ffff80000010a667:	e9 b4 f4 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a66c <vector66>:
ffff80000010a66c:	6a 00                	push   $0x0
ffff80000010a66e:	6a 42                	push   $0x42
ffff80000010a670:	e9 ab f4 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a675 <vector67>:
ffff80000010a675:	6a 00                	push   $0x0
ffff80000010a677:	6a 43                	push   $0x43
ffff80000010a679:	e9 a2 f4 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a67e <vector68>:
ffff80000010a67e:	6a 00                	push   $0x0
ffff80000010a680:	6a 44                	push   $0x44
ffff80000010a682:	e9 99 f4 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a687 <vector69>:
ffff80000010a687:	6a 00                	push   $0x0
ffff80000010a689:	6a 45                	push   $0x45
ffff80000010a68b:	e9 90 f4 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a690 <vector70>:
ffff80000010a690:	6a 00                	push   $0x0
ffff80000010a692:	6a 46                	push   $0x46
ffff80000010a694:	e9 87 f4 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a699 <vector71>:
ffff80000010a699:	6a 00                	push   $0x0
ffff80000010a69b:	6a 47                	push   $0x47
ffff80000010a69d:	e9 7e f4 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a6a2 <vector72>:
ffff80000010a6a2:	6a 00                	push   $0x0
ffff80000010a6a4:	6a 48                	push   $0x48
ffff80000010a6a6:	e9 75 f4 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a6ab <vector73>:
ffff80000010a6ab:	6a 00                	push   $0x0
ffff80000010a6ad:	6a 49                	push   $0x49
ffff80000010a6af:	e9 6c f4 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a6b4 <vector74>:
ffff80000010a6b4:	6a 00                	push   $0x0
ffff80000010a6b6:	6a 4a                	push   $0x4a
ffff80000010a6b8:	e9 63 f4 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a6bd <vector75>:
ffff80000010a6bd:	6a 00                	push   $0x0
ffff80000010a6bf:	6a 4b                	push   $0x4b
ffff80000010a6c1:	e9 5a f4 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a6c6 <vector76>:
ffff80000010a6c6:	6a 00                	push   $0x0
ffff80000010a6c8:	6a 4c                	push   $0x4c
ffff80000010a6ca:	e9 51 f4 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a6cf <vector77>:
ffff80000010a6cf:	6a 00                	push   $0x0
ffff80000010a6d1:	6a 4d                	push   $0x4d
ffff80000010a6d3:	e9 48 f4 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a6d8 <vector78>:
ffff80000010a6d8:	6a 00                	push   $0x0
ffff80000010a6da:	6a 4e                	push   $0x4e
ffff80000010a6dc:	e9 3f f4 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a6e1 <vector79>:
ffff80000010a6e1:	6a 00                	push   $0x0
ffff80000010a6e3:	6a 4f                	push   $0x4f
ffff80000010a6e5:	e9 36 f4 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a6ea <vector80>:
ffff80000010a6ea:	6a 00                	push   $0x0
ffff80000010a6ec:	6a 50                	push   $0x50
ffff80000010a6ee:	e9 2d f4 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a6f3 <vector81>:
ffff80000010a6f3:	6a 00                	push   $0x0
ffff80000010a6f5:	6a 51                	push   $0x51
ffff80000010a6f7:	e9 24 f4 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a6fc <vector82>:
ffff80000010a6fc:	6a 00                	push   $0x0
ffff80000010a6fe:	6a 52                	push   $0x52
ffff80000010a700:	e9 1b f4 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a705 <vector83>:
ffff80000010a705:	6a 00                	push   $0x0
ffff80000010a707:	6a 53                	push   $0x53
ffff80000010a709:	e9 12 f4 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a70e <vector84>:
ffff80000010a70e:	6a 00                	push   $0x0
ffff80000010a710:	6a 54                	push   $0x54
ffff80000010a712:	e9 09 f4 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a717 <vector85>:
ffff80000010a717:	6a 00                	push   $0x0
ffff80000010a719:	6a 55                	push   $0x55
ffff80000010a71b:	e9 00 f4 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a720 <vector86>:
ffff80000010a720:	6a 00                	push   $0x0
ffff80000010a722:	6a 56                	push   $0x56
ffff80000010a724:	e9 f7 f3 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a729 <vector87>:
ffff80000010a729:	6a 00                	push   $0x0
ffff80000010a72b:	6a 57                	push   $0x57
ffff80000010a72d:	e9 ee f3 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a732 <vector88>:
ffff80000010a732:	6a 00                	push   $0x0
ffff80000010a734:	6a 58                	push   $0x58
ffff80000010a736:	e9 e5 f3 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a73b <vector89>:
ffff80000010a73b:	6a 00                	push   $0x0
ffff80000010a73d:	6a 59                	push   $0x59
ffff80000010a73f:	e9 dc f3 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a744 <vector90>:
ffff80000010a744:	6a 00                	push   $0x0
ffff80000010a746:	6a 5a                	push   $0x5a
ffff80000010a748:	e9 d3 f3 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a74d <vector91>:
ffff80000010a74d:	6a 00                	push   $0x0
ffff80000010a74f:	6a 5b                	push   $0x5b
ffff80000010a751:	e9 ca f3 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a756 <vector92>:
ffff80000010a756:	6a 00                	push   $0x0
ffff80000010a758:	6a 5c                	push   $0x5c
ffff80000010a75a:	e9 c1 f3 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a75f <vector93>:
ffff80000010a75f:	6a 00                	push   $0x0
ffff80000010a761:	6a 5d                	push   $0x5d
ffff80000010a763:	e9 b8 f3 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a768 <vector94>:
ffff80000010a768:	6a 00                	push   $0x0
ffff80000010a76a:	6a 5e                	push   $0x5e
ffff80000010a76c:	e9 af f3 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a771 <vector95>:
ffff80000010a771:	6a 00                	push   $0x0
ffff80000010a773:	6a 5f                	push   $0x5f
ffff80000010a775:	e9 a6 f3 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a77a <vector96>:
ffff80000010a77a:	6a 00                	push   $0x0
ffff80000010a77c:	6a 60                	push   $0x60
ffff80000010a77e:	e9 9d f3 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a783 <vector97>:
ffff80000010a783:	6a 00                	push   $0x0
ffff80000010a785:	6a 61                	push   $0x61
ffff80000010a787:	e9 94 f3 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a78c <vector98>:
ffff80000010a78c:	6a 00                	push   $0x0
ffff80000010a78e:	6a 62                	push   $0x62
ffff80000010a790:	e9 8b f3 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a795 <vector99>:
ffff80000010a795:	6a 00                	push   $0x0
ffff80000010a797:	6a 63                	push   $0x63
ffff80000010a799:	e9 82 f3 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a79e <vector100>:
ffff80000010a79e:	6a 00                	push   $0x0
ffff80000010a7a0:	6a 64                	push   $0x64
ffff80000010a7a2:	e9 79 f3 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a7a7 <vector101>:
ffff80000010a7a7:	6a 00                	push   $0x0
ffff80000010a7a9:	6a 65                	push   $0x65
ffff80000010a7ab:	e9 70 f3 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a7b0 <vector102>:
ffff80000010a7b0:	6a 00                	push   $0x0
ffff80000010a7b2:	6a 66                	push   $0x66
ffff80000010a7b4:	e9 67 f3 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a7b9 <vector103>:
ffff80000010a7b9:	6a 00                	push   $0x0
ffff80000010a7bb:	6a 67                	push   $0x67
ffff80000010a7bd:	e9 5e f3 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a7c2 <vector104>:
ffff80000010a7c2:	6a 00                	push   $0x0
ffff80000010a7c4:	6a 68                	push   $0x68
ffff80000010a7c6:	e9 55 f3 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a7cb <vector105>:
ffff80000010a7cb:	6a 00                	push   $0x0
ffff80000010a7cd:	6a 69                	push   $0x69
ffff80000010a7cf:	e9 4c f3 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a7d4 <vector106>:
ffff80000010a7d4:	6a 00                	push   $0x0
ffff80000010a7d6:	6a 6a                	push   $0x6a
ffff80000010a7d8:	e9 43 f3 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a7dd <vector107>:
ffff80000010a7dd:	6a 00                	push   $0x0
ffff80000010a7df:	6a 6b                	push   $0x6b
ffff80000010a7e1:	e9 3a f3 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a7e6 <vector108>:
ffff80000010a7e6:	6a 00                	push   $0x0
ffff80000010a7e8:	6a 6c                	push   $0x6c
ffff80000010a7ea:	e9 31 f3 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a7ef <vector109>:
ffff80000010a7ef:	6a 00                	push   $0x0
ffff80000010a7f1:	6a 6d                	push   $0x6d
ffff80000010a7f3:	e9 28 f3 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a7f8 <vector110>:
ffff80000010a7f8:	6a 00                	push   $0x0
ffff80000010a7fa:	6a 6e                	push   $0x6e
ffff80000010a7fc:	e9 1f f3 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a801 <vector111>:
ffff80000010a801:	6a 00                	push   $0x0
ffff80000010a803:	6a 6f                	push   $0x6f
ffff80000010a805:	e9 16 f3 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a80a <vector112>:
ffff80000010a80a:	6a 00                	push   $0x0
ffff80000010a80c:	6a 70                	push   $0x70
ffff80000010a80e:	e9 0d f3 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a813 <vector113>:
ffff80000010a813:	6a 00                	push   $0x0
ffff80000010a815:	6a 71                	push   $0x71
ffff80000010a817:	e9 04 f3 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a81c <vector114>:
ffff80000010a81c:	6a 00                	push   $0x0
ffff80000010a81e:	6a 72                	push   $0x72
ffff80000010a820:	e9 fb f2 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a825 <vector115>:
ffff80000010a825:	6a 00                	push   $0x0
ffff80000010a827:	6a 73                	push   $0x73
ffff80000010a829:	e9 f2 f2 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a82e <vector116>:
ffff80000010a82e:	6a 00                	push   $0x0
ffff80000010a830:	6a 74                	push   $0x74
ffff80000010a832:	e9 e9 f2 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a837 <vector117>:
ffff80000010a837:	6a 00                	push   $0x0
ffff80000010a839:	6a 75                	push   $0x75
ffff80000010a83b:	e9 e0 f2 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a840 <vector118>:
ffff80000010a840:	6a 00                	push   $0x0
ffff80000010a842:	6a 76                	push   $0x76
ffff80000010a844:	e9 d7 f2 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a849 <vector119>:
ffff80000010a849:	6a 00                	push   $0x0
ffff80000010a84b:	6a 77                	push   $0x77
ffff80000010a84d:	e9 ce f2 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a852 <vector120>:
ffff80000010a852:	6a 00                	push   $0x0
ffff80000010a854:	6a 78                	push   $0x78
ffff80000010a856:	e9 c5 f2 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a85b <vector121>:
ffff80000010a85b:	6a 00                	push   $0x0
ffff80000010a85d:	6a 79                	push   $0x79
ffff80000010a85f:	e9 bc f2 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a864 <vector122>:
ffff80000010a864:	6a 00                	push   $0x0
ffff80000010a866:	6a 7a                	push   $0x7a
ffff80000010a868:	e9 b3 f2 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a86d <vector123>:
ffff80000010a86d:	6a 00                	push   $0x0
ffff80000010a86f:	6a 7b                	push   $0x7b
ffff80000010a871:	e9 aa f2 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a876 <vector124>:
ffff80000010a876:	6a 00                	push   $0x0
ffff80000010a878:	6a 7c                	push   $0x7c
ffff80000010a87a:	e9 a1 f2 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a87f <vector125>:
ffff80000010a87f:	6a 00                	push   $0x0
ffff80000010a881:	6a 7d                	push   $0x7d
ffff80000010a883:	e9 98 f2 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a888 <vector126>:
ffff80000010a888:	6a 00                	push   $0x0
ffff80000010a88a:	6a 7e                	push   $0x7e
ffff80000010a88c:	e9 8f f2 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a891 <vector127>:
ffff80000010a891:	6a 00                	push   $0x0
ffff80000010a893:	6a 7f                	push   $0x7f
ffff80000010a895:	e9 86 f2 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a89a <vector128>:
ffff80000010a89a:	6a 00                	push   $0x0
ffff80000010a89c:	68 80 00 00 00       	push   $0x80
ffff80000010a8a1:	e9 7a f2 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a8a6 <vector129>:
ffff80000010a8a6:	6a 00                	push   $0x0
ffff80000010a8a8:	68 81 00 00 00       	push   $0x81
ffff80000010a8ad:	e9 6e f2 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a8b2 <vector130>:
ffff80000010a8b2:	6a 00                	push   $0x0
ffff80000010a8b4:	68 82 00 00 00       	push   $0x82
ffff80000010a8b9:	e9 62 f2 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a8be <vector131>:
ffff80000010a8be:	6a 00                	push   $0x0
ffff80000010a8c0:	68 83 00 00 00       	push   $0x83
ffff80000010a8c5:	e9 56 f2 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a8ca <vector132>:
ffff80000010a8ca:	6a 00                	push   $0x0
ffff80000010a8cc:	68 84 00 00 00       	push   $0x84
ffff80000010a8d1:	e9 4a f2 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a8d6 <vector133>:
ffff80000010a8d6:	6a 00                	push   $0x0
ffff80000010a8d8:	68 85 00 00 00       	push   $0x85
ffff80000010a8dd:	e9 3e f2 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a8e2 <vector134>:
ffff80000010a8e2:	6a 00                	push   $0x0
ffff80000010a8e4:	68 86 00 00 00       	push   $0x86
ffff80000010a8e9:	e9 32 f2 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a8ee <vector135>:
ffff80000010a8ee:	6a 00                	push   $0x0
ffff80000010a8f0:	68 87 00 00 00       	push   $0x87
ffff80000010a8f5:	e9 26 f2 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a8fa <vector136>:
ffff80000010a8fa:	6a 00                	push   $0x0
ffff80000010a8fc:	68 88 00 00 00       	push   $0x88
ffff80000010a901:	e9 1a f2 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a906 <vector137>:
ffff80000010a906:	6a 00                	push   $0x0
ffff80000010a908:	68 89 00 00 00       	push   $0x89
ffff80000010a90d:	e9 0e f2 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a912 <vector138>:
ffff80000010a912:	6a 00                	push   $0x0
ffff80000010a914:	68 8a 00 00 00       	push   $0x8a
ffff80000010a919:	e9 02 f2 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a91e <vector139>:
ffff80000010a91e:	6a 00                	push   $0x0
ffff80000010a920:	68 8b 00 00 00       	push   $0x8b
ffff80000010a925:	e9 f6 f1 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a92a <vector140>:
ffff80000010a92a:	6a 00                	push   $0x0
ffff80000010a92c:	68 8c 00 00 00       	push   $0x8c
ffff80000010a931:	e9 ea f1 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a936 <vector141>:
ffff80000010a936:	6a 00                	push   $0x0
ffff80000010a938:	68 8d 00 00 00       	push   $0x8d
ffff80000010a93d:	e9 de f1 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a942 <vector142>:
ffff80000010a942:	6a 00                	push   $0x0
ffff80000010a944:	68 8e 00 00 00       	push   $0x8e
ffff80000010a949:	e9 d2 f1 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a94e <vector143>:
ffff80000010a94e:	6a 00                	push   $0x0
ffff80000010a950:	68 8f 00 00 00       	push   $0x8f
ffff80000010a955:	e9 c6 f1 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a95a <vector144>:
ffff80000010a95a:	6a 00                	push   $0x0
ffff80000010a95c:	68 90 00 00 00       	push   $0x90
ffff80000010a961:	e9 ba f1 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a966 <vector145>:
ffff80000010a966:	6a 00                	push   $0x0
ffff80000010a968:	68 91 00 00 00       	push   $0x91
ffff80000010a96d:	e9 ae f1 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a972 <vector146>:
ffff80000010a972:	6a 00                	push   $0x0
ffff80000010a974:	68 92 00 00 00       	push   $0x92
ffff80000010a979:	e9 a2 f1 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a97e <vector147>:
ffff80000010a97e:	6a 00                	push   $0x0
ffff80000010a980:	68 93 00 00 00       	push   $0x93
ffff80000010a985:	e9 96 f1 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a98a <vector148>:
ffff80000010a98a:	6a 00                	push   $0x0
ffff80000010a98c:	68 94 00 00 00       	push   $0x94
ffff80000010a991:	e9 8a f1 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a996 <vector149>:
ffff80000010a996:	6a 00                	push   $0x0
ffff80000010a998:	68 95 00 00 00       	push   $0x95
ffff80000010a99d:	e9 7e f1 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a9a2 <vector150>:
ffff80000010a9a2:	6a 00                	push   $0x0
ffff80000010a9a4:	68 96 00 00 00       	push   $0x96
ffff80000010a9a9:	e9 72 f1 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a9ae <vector151>:
ffff80000010a9ae:	6a 00                	push   $0x0
ffff80000010a9b0:	68 97 00 00 00       	push   $0x97
ffff80000010a9b5:	e9 66 f1 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a9ba <vector152>:
ffff80000010a9ba:	6a 00                	push   $0x0
ffff80000010a9bc:	68 98 00 00 00       	push   $0x98
ffff80000010a9c1:	e9 5a f1 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a9c6 <vector153>:
ffff80000010a9c6:	6a 00                	push   $0x0
ffff80000010a9c8:	68 99 00 00 00       	push   $0x99
ffff80000010a9cd:	e9 4e f1 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a9d2 <vector154>:
ffff80000010a9d2:	6a 00                	push   $0x0
ffff80000010a9d4:	68 9a 00 00 00       	push   $0x9a
ffff80000010a9d9:	e9 42 f1 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a9de <vector155>:
ffff80000010a9de:	6a 00                	push   $0x0
ffff80000010a9e0:	68 9b 00 00 00       	push   $0x9b
ffff80000010a9e5:	e9 36 f1 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a9ea <vector156>:
ffff80000010a9ea:	6a 00                	push   $0x0
ffff80000010a9ec:	68 9c 00 00 00       	push   $0x9c
ffff80000010a9f1:	e9 2a f1 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010a9f6 <vector157>:
ffff80000010a9f6:	6a 00                	push   $0x0
ffff80000010a9f8:	68 9d 00 00 00       	push   $0x9d
ffff80000010a9fd:	e9 1e f1 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010aa02 <vector158>:
ffff80000010aa02:	6a 00                	push   $0x0
ffff80000010aa04:	68 9e 00 00 00       	push   $0x9e
ffff80000010aa09:	e9 12 f1 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010aa0e <vector159>:
ffff80000010aa0e:	6a 00                	push   $0x0
ffff80000010aa10:	68 9f 00 00 00       	push   $0x9f
ffff80000010aa15:	e9 06 f1 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010aa1a <vector160>:
ffff80000010aa1a:	6a 00                	push   $0x0
ffff80000010aa1c:	68 a0 00 00 00       	push   $0xa0
ffff80000010aa21:	e9 fa f0 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010aa26 <vector161>:
ffff80000010aa26:	6a 00                	push   $0x0
ffff80000010aa28:	68 a1 00 00 00       	push   $0xa1
ffff80000010aa2d:	e9 ee f0 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010aa32 <vector162>:
ffff80000010aa32:	6a 00                	push   $0x0
ffff80000010aa34:	68 a2 00 00 00       	push   $0xa2
ffff80000010aa39:	e9 e2 f0 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010aa3e <vector163>:
ffff80000010aa3e:	6a 00                	push   $0x0
ffff80000010aa40:	68 a3 00 00 00       	push   $0xa3
ffff80000010aa45:	e9 d6 f0 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010aa4a <vector164>:
ffff80000010aa4a:	6a 00                	push   $0x0
ffff80000010aa4c:	68 a4 00 00 00       	push   $0xa4
ffff80000010aa51:	e9 ca f0 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010aa56 <vector165>:
ffff80000010aa56:	6a 00                	push   $0x0
ffff80000010aa58:	68 a5 00 00 00       	push   $0xa5
ffff80000010aa5d:	e9 be f0 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010aa62 <vector166>:
ffff80000010aa62:	6a 00                	push   $0x0
ffff80000010aa64:	68 a6 00 00 00       	push   $0xa6
ffff80000010aa69:	e9 b2 f0 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010aa6e <vector167>:
ffff80000010aa6e:	6a 00                	push   $0x0
ffff80000010aa70:	68 a7 00 00 00       	push   $0xa7
ffff80000010aa75:	e9 a6 f0 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010aa7a <vector168>:
ffff80000010aa7a:	6a 00                	push   $0x0
ffff80000010aa7c:	68 a8 00 00 00       	push   $0xa8
ffff80000010aa81:	e9 9a f0 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010aa86 <vector169>:
ffff80000010aa86:	6a 00                	push   $0x0
ffff80000010aa88:	68 a9 00 00 00       	push   $0xa9
ffff80000010aa8d:	e9 8e f0 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010aa92 <vector170>:
ffff80000010aa92:	6a 00                	push   $0x0
ffff80000010aa94:	68 aa 00 00 00       	push   $0xaa
ffff80000010aa99:	e9 82 f0 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010aa9e <vector171>:
ffff80000010aa9e:	6a 00                	push   $0x0
ffff80000010aaa0:	68 ab 00 00 00       	push   $0xab
ffff80000010aaa5:	e9 76 f0 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010aaaa <vector172>:
ffff80000010aaaa:	6a 00                	push   $0x0
ffff80000010aaac:	68 ac 00 00 00       	push   $0xac
ffff80000010aab1:	e9 6a f0 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010aab6 <vector173>:
ffff80000010aab6:	6a 00                	push   $0x0
ffff80000010aab8:	68 ad 00 00 00       	push   $0xad
ffff80000010aabd:	e9 5e f0 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010aac2 <vector174>:
ffff80000010aac2:	6a 00                	push   $0x0
ffff80000010aac4:	68 ae 00 00 00       	push   $0xae
ffff80000010aac9:	e9 52 f0 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010aace <vector175>:
ffff80000010aace:	6a 00                	push   $0x0
ffff80000010aad0:	68 af 00 00 00       	push   $0xaf
ffff80000010aad5:	e9 46 f0 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010aada <vector176>:
ffff80000010aada:	6a 00                	push   $0x0
ffff80000010aadc:	68 b0 00 00 00       	push   $0xb0
ffff80000010aae1:	e9 3a f0 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010aae6 <vector177>:
ffff80000010aae6:	6a 00                	push   $0x0
ffff80000010aae8:	68 b1 00 00 00       	push   $0xb1
ffff80000010aaed:	e9 2e f0 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010aaf2 <vector178>:
ffff80000010aaf2:	6a 00                	push   $0x0
ffff80000010aaf4:	68 b2 00 00 00       	push   $0xb2
ffff80000010aaf9:	e9 22 f0 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010aafe <vector179>:
ffff80000010aafe:	6a 00                	push   $0x0
ffff80000010ab00:	68 b3 00 00 00       	push   $0xb3
ffff80000010ab05:	e9 16 f0 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ab0a <vector180>:
ffff80000010ab0a:	6a 00                	push   $0x0
ffff80000010ab0c:	68 b4 00 00 00       	push   $0xb4
ffff80000010ab11:	e9 0a f0 ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ab16 <vector181>:
ffff80000010ab16:	6a 00                	push   $0x0
ffff80000010ab18:	68 b5 00 00 00       	push   $0xb5
ffff80000010ab1d:	e9 fe ef ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ab22 <vector182>:
ffff80000010ab22:	6a 00                	push   $0x0
ffff80000010ab24:	68 b6 00 00 00       	push   $0xb6
ffff80000010ab29:	e9 f2 ef ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ab2e <vector183>:
ffff80000010ab2e:	6a 00                	push   $0x0
ffff80000010ab30:	68 b7 00 00 00       	push   $0xb7
ffff80000010ab35:	e9 e6 ef ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ab3a <vector184>:
ffff80000010ab3a:	6a 00                	push   $0x0
ffff80000010ab3c:	68 b8 00 00 00       	push   $0xb8
ffff80000010ab41:	e9 da ef ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ab46 <vector185>:
ffff80000010ab46:	6a 00                	push   $0x0
ffff80000010ab48:	68 b9 00 00 00       	push   $0xb9
ffff80000010ab4d:	e9 ce ef ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ab52 <vector186>:
ffff80000010ab52:	6a 00                	push   $0x0
ffff80000010ab54:	68 ba 00 00 00       	push   $0xba
ffff80000010ab59:	e9 c2 ef ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ab5e <vector187>:
ffff80000010ab5e:	6a 00                	push   $0x0
ffff80000010ab60:	68 bb 00 00 00       	push   $0xbb
ffff80000010ab65:	e9 b6 ef ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ab6a <vector188>:
ffff80000010ab6a:	6a 00                	push   $0x0
ffff80000010ab6c:	68 bc 00 00 00       	push   $0xbc
ffff80000010ab71:	e9 aa ef ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ab76 <vector189>:
ffff80000010ab76:	6a 00                	push   $0x0
ffff80000010ab78:	68 bd 00 00 00       	push   $0xbd
ffff80000010ab7d:	e9 9e ef ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ab82 <vector190>:
ffff80000010ab82:	6a 00                	push   $0x0
ffff80000010ab84:	68 be 00 00 00       	push   $0xbe
ffff80000010ab89:	e9 92 ef ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ab8e <vector191>:
ffff80000010ab8e:	6a 00                	push   $0x0
ffff80000010ab90:	68 bf 00 00 00       	push   $0xbf
ffff80000010ab95:	e9 86 ef ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ab9a <vector192>:
ffff80000010ab9a:	6a 00                	push   $0x0
ffff80000010ab9c:	68 c0 00 00 00       	push   $0xc0
ffff80000010aba1:	e9 7a ef ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010aba6 <vector193>:
ffff80000010aba6:	6a 00                	push   $0x0
ffff80000010aba8:	68 c1 00 00 00       	push   $0xc1
ffff80000010abad:	e9 6e ef ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010abb2 <vector194>:
ffff80000010abb2:	6a 00                	push   $0x0
ffff80000010abb4:	68 c2 00 00 00       	push   $0xc2
ffff80000010abb9:	e9 62 ef ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010abbe <vector195>:
ffff80000010abbe:	6a 00                	push   $0x0
ffff80000010abc0:	68 c3 00 00 00       	push   $0xc3
ffff80000010abc5:	e9 56 ef ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010abca <vector196>:
ffff80000010abca:	6a 00                	push   $0x0
ffff80000010abcc:	68 c4 00 00 00       	push   $0xc4
ffff80000010abd1:	e9 4a ef ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010abd6 <vector197>:
ffff80000010abd6:	6a 00                	push   $0x0
ffff80000010abd8:	68 c5 00 00 00       	push   $0xc5
ffff80000010abdd:	e9 3e ef ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010abe2 <vector198>:
ffff80000010abe2:	6a 00                	push   $0x0
ffff80000010abe4:	68 c6 00 00 00       	push   $0xc6
ffff80000010abe9:	e9 32 ef ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010abee <vector199>:
ffff80000010abee:	6a 00                	push   $0x0
ffff80000010abf0:	68 c7 00 00 00       	push   $0xc7
ffff80000010abf5:	e9 26 ef ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010abfa <vector200>:
ffff80000010abfa:	6a 00                	push   $0x0
ffff80000010abfc:	68 c8 00 00 00       	push   $0xc8
ffff80000010ac01:	e9 1a ef ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ac06 <vector201>:
ffff80000010ac06:	6a 00                	push   $0x0
ffff80000010ac08:	68 c9 00 00 00       	push   $0xc9
ffff80000010ac0d:	e9 0e ef ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ac12 <vector202>:
ffff80000010ac12:	6a 00                	push   $0x0
ffff80000010ac14:	68 ca 00 00 00       	push   $0xca
ffff80000010ac19:	e9 02 ef ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ac1e <vector203>:
ffff80000010ac1e:	6a 00                	push   $0x0
ffff80000010ac20:	68 cb 00 00 00       	push   $0xcb
ffff80000010ac25:	e9 f6 ee ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ac2a <vector204>:
ffff80000010ac2a:	6a 00                	push   $0x0
ffff80000010ac2c:	68 cc 00 00 00       	push   $0xcc
ffff80000010ac31:	e9 ea ee ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ac36 <vector205>:
ffff80000010ac36:	6a 00                	push   $0x0
ffff80000010ac38:	68 cd 00 00 00       	push   $0xcd
ffff80000010ac3d:	e9 de ee ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ac42 <vector206>:
ffff80000010ac42:	6a 00                	push   $0x0
ffff80000010ac44:	68 ce 00 00 00       	push   $0xce
ffff80000010ac49:	e9 d2 ee ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ac4e <vector207>:
ffff80000010ac4e:	6a 00                	push   $0x0
ffff80000010ac50:	68 cf 00 00 00       	push   $0xcf
ffff80000010ac55:	e9 c6 ee ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ac5a <vector208>:
ffff80000010ac5a:	6a 00                	push   $0x0
ffff80000010ac5c:	68 d0 00 00 00       	push   $0xd0
ffff80000010ac61:	e9 ba ee ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ac66 <vector209>:
ffff80000010ac66:	6a 00                	push   $0x0
ffff80000010ac68:	68 d1 00 00 00       	push   $0xd1
ffff80000010ac6d:	e9 ae ee ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ac72 <vector210>:
ffff80000010ac72:	6a 00                	push   $0x0
ffff80000010ac74:	68 d2 00 00 00       	push   $0xd2
ffff80000010ac79:	e9 a2 ee ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ac7e <vector211>:
ffff80000010ac7e:	6a 00                	push   $0x0
ffff80000010ac80:	68 d3 00 00 00       	push   $0xd3
ffff80000010ac85:	e9 96 ee ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ac8a <vector212>:
ffff80000010ac8a:	6a 00                	push   $0x0
ffff80000010ac8c:	68 d4 00 00 00       	push   $0xd4
ffff80000010ac91:	e9 8a ee ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ac96 <vector213>:
ffff80000010ac96:	6a 00                	push   $0x0
ffff80000010ac98:	68 d5 00 00 00       	push   $0xd5
ffff80000010ac9d:	e9 7e ee ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010aca2 <vector214>:
ffff80000010aca2:	6a 00                	push   $0x0
ffff80000010aca4:	68 d6 00 00 00       	push   $0xd6
ffff80000010aca9:	e9 72 ee ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010acae <vector215>:
ffff80000010acae:	6a 00                	push   $0x0
ffff80000010acb0:	68 d7 00 00 00       	push   $0xd7
ffff80000010acb5:	e9 66 ee ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010acba <vector216>:
ffff80000010acba:	6a 00                	push   $0x0
ffff80000010acbc:	68 d8 00 00 00       	push   $0xd8
ffff80000010acc1:	e9 5a ee ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010acc6 <vector217>:
ffff80000010acc6:	6a 00                	push   $0x0
ffff80000010acc8:	68 d9 00 00 00       	push   $0xd9
ffff80000010accd:	e9 4e ee ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010acd2 <vector218>:
ffff80000010acd2:	6a 00                	push   $0x0
ffff80000010acd4:	68 da 00 00 00       	push   $0xda
ffff80000010acd9:	e9 42 ee ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010acde <vector219>:
ffff80000010acde:	6a 00                	push   $0x0
ffff80000010ace0:	68 db 00 00 00       	push   $0xdb
ffff80000010ace5:	e9 36 ee ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010acea <vector220>:
ffff80000010acea:	6a 00                	push   $0x0
ffff80000010acec:	68 dc 00 00 00       	push   $0xdc
ffff80000010acf1:	e9 2a ee ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010acf6 <vector221>:
ffff80000010acf6:	6a 00                	push   $0x0
ffff80000010acf8:	68 dd 00 00 00       	push   $0xdd
ffff80000010acfd:	e9 1e ee ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ad02 <vector222>:
ffff80000010ad02:	6a 00                	push   $0x0
ffff80000010ad04:	68 de 00 00 00       	push   $0xde
ffff80000010ad09:	e9 12 ee ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ad0e <vector223>:
ffff80000010ad0e:	6a 00                	push   $0x0
ffff80000010ad10:	68 df 00 00 00       	push   $0xdf
ffff80000010ad15:	e9 06 ee ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ad1a <vector224>:
ffff80000010ad1a:	6a 00                	push   $0x0
ffff80000010ad1c:	68 e0 00 00 00       	push   $0xe0
ffff80000010ad21:	e9 fa ed ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ad26 <vector225>:
ffff80000010ad26:	6a 00                	push   $0x0
ffff80000010ad28:	68 e1 00 00 00       	push   $0xe1
ffff80000010ad2d:	e9 ee ed ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ad32 <vector226>:
ffff80000010ad32:	6a 00                	push   $0x0
ffff80000010ad34:	68 e2 00 00 00       	push   $0xe2
ffff80000010ad39:	e9 e2 ed ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ad3e <vector227>:
ffff80000010ad3e:	6a 00                	push   $0x0
ffff80000010ad40:	68 e3 00 00 00       	push   $0xe3
ffff80000010ad45:	e9 d6 ed ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ad4a <vector228>:
ffff80000010ad4a:	6a 00                	push   $0x0
ffff80000010ad4c:	68 e4 00 00 00       	push   $0xe4
ffff80000010ad51:	e9 ca ed ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ad56 <vector229>:
ffff80000010ad56:	6a 00                	push   $0x0
ffff80000010ad58:	68 e5 00 00 00       	push   $0xe5
ffff80000010ad5d:	e9 be ed ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ad62 <vector230>:
ffff80000010ad62:	6a 00                	push   $0x0
ffff80000010ad64:	68 e6 00 00 00       	push   $0xe6
ffff80000010ad69:	e9 b2 ed ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ad6e <vector231>:
ffff80000010ad6e:	6a 00                	push   $0x0
ffff80000010ad70:	68 e7 00 00 00       	push   $0xe7
ffff80000010ad75:	e9 a6 ed ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ad7a <vector232>:
ffff80000010ad7a:	6a 00                	push   $0x0
ffff80000010ad7c:	68 e8 00 00 00       	push   $0xe8
ffff80000010ad81:	e9 9a ed ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ad86 <vector233>:
ffff80000010ad86:	6a 00                	push   $0x0
ffff80000010ad88:	68 e9 00 00 00       	push   $0xe9
ffff80000010ad8d:	e9 8e ed ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ad92 <vector234>:
ffff80000010ad92:	6a 00                	push   $0x0
ffff80000010ad94:	68 ea 00 00 00       	push   $0xea
ffff80000010ad99:	e9 82 ed ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ad9e <vector235>:
ffff80000010ad9e:	6a 00                	push   $0x0
ffff80000010ada0:	68 eb 00 00 00       	push   $0xeb
ffff80000010ada5:	e9 76 ed ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010adaa <vector236>:
ffff80000010adaa:	6a 00                	push   $0x0
ffff80000010adac:	68 ec 00 00 00       	push   $0xec
ffff80000010adb1:	e9 6a ed ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010adb6 <vector237>:
ffff80000010adb6:	6a 00                	push   $0x0
ffff80000010adb8:	68 ed 00 00 00       	push   $0xed
ffff80000010adbd:	e9 5e ed ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010adc2 <vector238>:
ffff80000010adc2:	6a 00                	push   $0x0
ffff80000010adc4:	68 ee 00 00 00       	push   $0xee
ffff80000010adc9:	e9 52 ed ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010adce <vector239>:
ffff80000010adce:	6a 00                	push   $0x0
ffff80000010add0:	68 ef 00 00 00       	push   $0xef
ffff80000010add5:	e9 46 ed ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010adda <vector240>:
ffff80000010adda:	6a 00                	push   $0x0
ffff80000010addc:	68 f0 00 00 00       	push   $0xf0
ffff80000010ade1:	e9 3a ed ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ade6 <vector241>:
ffff80000010ade6:	6a 00                	push   $0x0
ffff80000010ade8:	68 f1 00 00 00       	push   $0xf1
ffff80000010aded:	e9 2e ed ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010adf2 <vector242>:
ffff80000010adf2:	6a 00                	push   $0x0
ffff80000010adf4:	68 f2 00 00 00       	push   $0xf2
ffff80000010adf9:	e9 22 ed ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010adfe <vector243>:
ffff80000010adfe:	6a 00                	push   $0x0
ffff80000010ae00:	68 f3 00 00 00       	push   $0xf3
ffff80000010ae05:	e9 16 ed ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ae0a <vector244>:
ffff80000010ae0a:	6a 00                	push   $0x0
ffff80000010ae0c:	68 f4 00 00 00       	push   $0xf4
ffff80000010ae11:	e9 0a ed ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ae16 <vector245>:
ffff80000010ae16:	6a 00                	push   $0x0
ffff80000010ae18:	68 f5 00 00 00       	push   $0xf5
ffff80000010ae1d:	e9 fe ec ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ae22 <vector246>:
ffff80000010ae22:	6a 00                	push   $0x0
ffff80000010ae24:	68 f6 00 00 00       	push   $0xf6
ffff80000010ae29:	e9 f2 ec ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ae2e <vector247>:
ffff80000010ae2e:	6a 00                	push   $0x0
ffff80000010ae30:	68 f7 00 00 00       	push   $0xf7
ffff80000010ae35:	e9 e6 ec ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ae3a <vector248>:
ffff80000010ae3a:	6a 00                	push   $0x0
ffff80000010ae3c:	68 f8 00 00 00       	push   $0xf8
ffff80000010ae41:	e9 da ec ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ae46 <vector249>:
ffff80000010ae46:	6a 00                	push   $0x0
ffff80000010ae48:	68 f9 00 00 00       	push   $0xf9
ffff80000010ae4d:	e9 ce ec ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ae52 <vector250>:
ffff80000010ae52:	6a 00                	push   $0x0
ffff80000010ae54:	68 fa 00 00 00       	push   $0xfa
ffff80000010ae59:	e9 c2 ec ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ae5e <vector251>:
ffff80000010ae5e:	6a 00                	push   $0x0
ffff80000010ae60:	68 fb 00 00 00       	push   $0xfb
ffff80000010ae65:	e9 b6 ec ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ae6a <vector252>:
ffff80000010ae6a:	6a 00                	push   $0x0
ffff80000010ae6c:	68 fc 00 00 00       	push   $0xfc
ffff80000010ae71:	e9 aa ec ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ae76 <vector253>:
ffff80000010ae76:	6a 00                	push   $0x0
ffff80000010ae78:	68 fd 00 00 00       	push   $0xfd
ffff80000010ae7d:	e9 9e ec ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ae82 <vector254>:
ffff80000010ae82:	6a 00                	push   $0x0
ffff80000010ae84:	68 fe 00 00 00       	push   $0xfe
ffff80000010ae89:	e9 92 ec ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ae8e <vector255>:
ffff80000010ae8e:	6a 00                	push   $0x0
ffff80000010ae90:	68 ff 00 00 00       	push   $0xff
ffff80000010ae95:	e9 86 ec ff ff       	jmp    ffff800000109b20 <alltraps>

ffff80000010ae9a <lgdt>:

  addr = (uint64) tss;
  gdt[0] =  (struct segdesc) {};

  gdt[SEG_KCODE] = SEG((STA_X|STA_R), 0, 0, APP_SEG, !DPL_USER, 1);
  gdt[SEG_KDATA] = SEG(STA_W, 0, 0, APP_SEG, !DPL_USER, 0);
ffff80000010ae9a:	f3 0f 1e fa          	endbr64
ffff80000010ae9e:	55                   	push   %rbp
ffff80000010ae9f:	48 89 e5             	mov    %rsp,%rbp
ffff80000010aea2:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010aea6:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010aeaa:	89 75 d4             	mov    %esi,-0x2c(%rbp)
  gdt[SEG_UCODE32] = (struct segdesc) {}; // required by syscall/sysret
  gdt[SEG_UDATA] = SEG(STA_W, 0, 0, APP_SEG, DPL_USER, 0);
ffff80000010aead:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010aeb1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  gdt[SEG_UCODE] = SEG((STA_X|STA_R), 0, 0, APP_SEG, DPL_USER, 1);
  gdt[SEG_KCPU]  = (struct segdesc) {};
ffff80000010aeb5:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff80000010aeb8:	83 e8 01             	sub    $0x1,%eax
ffff80000010aebb:	66 89 45 ee          	mov    %ax,-0x12(%rbp)
  // TSS: See IA32 SDM Figure 7-4
ffff80000010aebf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010aec3:	66 89 45 f0          	mov    %ax,-0x10(%rbp)
  gdt[SEG_TSS]   = SEG(STS_T64A, 0xb, addr, !APP_SEG, DPL_USER, 0);
ffff80000010aec7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010aecb:	48 c1 e8 10          	shr    $0x10,%rax
ffff80000010aecf:	66 89 45 f2          	mov    %ax,-0xe(%rbp)
  gdt[SEG_TSS+1] = SEG(0, addr >> 32, addr >> 48, 0, 0, 0);
ffff80000010aed3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010aed7:	48 c1 e8 20          	shr    $0x20,%rax
ffff80000010aedb:	66 89 45 f4          	mov    %ax,-0xc(%rbp)

ffff80000010aedf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010aee3:	48 c1 e8 30          	shr    $0x30,%rax
ffff80000010aee7:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
  lgdt((void*) gdt, (NSEGS+1) * sizeof(struct segdesc));

ffff80000010aeeb:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
ffff80000010aeef:	0f 01 10             	lgdt   (%rax)
  ltr(SEG_TSS << 3);
ffff80000010aef2:	90                   	nop
ffff80000010aef3:	c9                   	leave
ffff80000010aef4:	c3                   	ret

ffff80000010aef5 <ltr>:
//   data..KERNBASE+PHYSTOP: mapped to V2P(data)..PHYSTOP,
//                                  rw data + free physical memory
//   0xfe000000..0: mapped direct (devices such as ioapic)
//
// The kernel allocates physical memory for its heap and for user memory
// between V2P(end) and the end of physical memory (PHYSTOP)
ffff80000010aef5:	f3 0f 1e fa          	endbr64
ffff80000010aef9:	55                   	push   %rbp
ffff80000010aefa:	48 89 e5             	mov    %rsp,%rbp
ffff80000010aefd:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010af01:	89 f8                	mov    %edi,%eax
ffff80000010af03:	66 89 45 fc          	mov    %ax,-0x4(%rbp)
// (directly addressable from end..P2V(PHYSTOP)).
ffff80000010af07:	0f b7 45 fc          	movzwl -0x4(%rbp),%eax
ffff80000010af0b:	0f 00 d8             	ltr    %eax

ffff80000010af0e:	90                   	nop
ffff80000010af0f:	c9                   	leave
ffff80000010af10:	c3                   	ret

ffff80000010af11 <lcr3>:
  const addr_t stktop = (addr_t)p->kstack + KSTACKSIZE;
  tss[1] = (uint)stktop; // https://wiki.osdev.org/Task_State_Segment
  tss[2] = (uint)(stktop >> 32);
  lcr3(v2p(p->pgdir));
  popcli();
}
ffff80000010af11:	f3 0f 1e fa          	endbr64
ffff80000010af15:	55                   	push   %rbp
ffff80000010af16:	48 89 e5             	mov    %rsp,%rbp
ffff80000010af19:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010af1d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)

ffff80000010af21:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010af25:	0f 22 d8             	mov    %rax,%cr3
// Return the address of the PTE in page table pgdir
ffff80000010af28:	90                   	nop
ffff80000010af29:	c9                   	leave
ffff80000010af2a:	c3                   	ret

ffff80000010af2b <v2p>:
#define KERNBASE 0xFFFF800000000000 // First kernel virtual address

#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__
static inline addr_t v2p(void *a) {
ffff80000010af2b:	f3 0f 1e fa          	endbr64
ffff80000010af2f:	55                   	push   %rbp
ffff80000010af30:	48 89 e5             	mov    %rsp,%rbp
ffff80000010af33:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010af37:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  return ((addr_t) (a)) - ((addr_t)KERNBASE);
ffff80000010af3b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010af3f:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010af46:	80 00 00 
ffff80000010af49:	48 01 d0             	add    %rdx,%rax
}
ffff80000010af4c:	c9                   	leave
ffff80000010af4d:	c3                   	ret

ffff80000010af4e <syscallinit>:
{
ffff80000010af4e:	f3 0f 1e fa          	endbr64
ffff80000010af52:	55                   	push   %rbp
ffff80000010af53:	48 89 e5             	mov    %rsp,%rbp
  wrmsr(MSR_STAR,
ffff80000010af56:	48 b8 00 00 00 00 08 	movabs $0x1b000800000000,%rax
ffff80000010af5d:	00 1b 00 
ffff80000010af60:	48 89 c6             	mov    %rax,%rsi
ffff80000010af63:	bf 81 00 00 c0       	mov    $0xc0000081,%edi
ffff80000010af68:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010af6f:	80 ff ff 
ffff80000010af72:	ff d0                	call   *%rax
  wrmsr(MSR_LSTAR, (addr_t)syscall_entry);
ffff80000010af74:	48 b8 5c 9b 10 00 00 	movabs $0xffff800000109b5c,%rax
ffff80000010af7b:	80 ff ff 
ffff80000010af7e:	48 89 c6             	mov    %rax,%rsi
ffff80000010af81:	bf 82 00 00 c0       	mov    $0xc0000082,%edi
ffff80000010af86:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010af8d:	80 ff ff 
ffff80000010af90:	ff d0                	call   *%rax
  wrmsr(MSR_CSTAR, (addr_t)ignore_sysret);
ffff80000010af92:	48 b8 11 01 10 00 00 	movabs $0xffff800000100111,%rax
ffff80000010af99:	80 ff ff 
ffff80000010af9c:	48 89 c6             	mov    %rax,%rsi
ffff80000010af9f:	bf 83 00 00 c0       	mov    $0xc0000083,%edi
ffff80000010afa4:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010afab:	80 ff ff 
ffff80000010afae:	ff d0                	call   *%rax
  wrmsr(MSR_SFMASK, FL_TF|FL_DF|FL_IF|FL_IOPL_3|FL_AC|FL_NT);
ffff80000010afb0:	be 00 77 04 00       	mov    $0x47700,%esi
ffff80000010afb5:	bf 84 00 00 c0       	mov    $0xc0000084,%edi
ffff80000010afba:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010afc1:	80 ff ff 
ffff80000010afc4:	ff d0                	call   *%rax
}
ffff80000010afc6:	90                   	nop
ffff80000010afc7:	5d                   	pop    %rbp
ffff80000010afc8:	c3                   	ret

ffff80000010afc9 <seginit>:
{
ffff80000010afc9:	f3 0f 1e fa          	endbr64
ffff80000010afcd:	55                   	push   %rbp
ffff80000010afce:	48 89 e5             	mov    %rsp,%rbp
ffff80000010afd1:	48 83 ec 30          	sub    $0x30,%rsp
  local = kalloc();
ffff80000010afd5:	48 b8 00 43 10 00 00 	movabs $0xffff800000104300,%rax
ffff80000010afdc:	80 ff ff 
ffff80000010afdf:	ff d0                	call   *%rax
ffff80000010afe1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(local, 0, PGSIZE);
ffff80000010afe5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010afe9:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010afee:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010aff3:	48 89 c7             	mov    %rax,%rdi
ffff80000010aff6:	48 b8 87 7d 10 00 00 	movabs $0xffff800000107d87,%rax
ffff80000010affd:	80 ff ff 
ffff80000010b000:	ff d0                	call   *%rax
  gdt = (struct segdesc*) local;
ffff80000010b002:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b006:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  tss = (uint*) (((char*) local) + 1024);
ffff80000010b00a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b00e:	48 05 00 04 00 00    	add    $0x400,%rax
ffff80000010b014:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  tss[16] = 0x00680000; // IO Map Base = End of TSS
ffff80000010b018:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b01c:	48 83 c0 40          	add    $0x40,%rax
ffff80000010b020:	c7 00 00 00 68 00    	movl   $0x680000,(%rax)
  wrmsr(0xC0000100, ((uint64) local) + 2048);
ffff80000010b026:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b02a:	48 05 00 08 00 00    	add    $0x800,%rax
ffff80000010b030:	48 89 c6             	mov    %rax,%rsi
ffff80000010b033:	bf 00 01 00 c0       	mov    $0xc0000100,%edi
ffff80000010b038:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010b03f:	80 ff ff 
ffff80000010b042:	ff d0                	call   *%rax
  c = &cpus[cpunum()];
ffff80000010b044:	48 b8 12 48 10 00 00 	movabs $0xffff800000104812,%rax
ffff80000010b04b:	80 ff ff 
ffff80000010b04e:	ff d0                	call   *%rax
ffff80000010b050:	48 63 d0             	movslq %eax,%rdx
ffff80000010b053:	48 89 d0             	mov    %rdx,%rax
ffff80000010b056:	48 c1 e0 02          	shl    $0x2,%rax
ffff80000010b05a:	48 01 d0             	add    %rdx,%rax
ffff80000010b05d:	48 c1 e0 03          	shl    $0x3,%rax
ffff80000010b061:	48 ba e0 72 11 00 00 	movabs $0xffff8000001172e0,%rdx
ffff80000010b068:	80 ff ff 
ffff80000010b06b:	48 01 d0             	add    %rdx,%rax
ffff80000010b06e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  c->local = local;
ffff80000010b072:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010b076:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010b07a:	48 89 50 20          	mov    %rdx,0x20(%rax)
  cpu = c;
ffff80000010b07e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010b082:	64 48 89 04 25 f0 ff 	mov    %rax,%fs:0xfffffffffffffff0
ffff80000010b089:	ff ff 
  proc = 0;
ffff80000010b08b:	64 48 c7 04 25 f8 ff 	movq   $0x0,%fs:0xfffffffffffffff8
ffff80000010b092:	ff ff 00 00 00 00 
  addr = (uint64) tss;
ffff80000010b098:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b09c:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  gdt[0] =  (struct segdesc) {};
ffff80000010b0a0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b0a4:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  gdt[SEG_KCODE] = SEG((STA_X|STA_R), 0, 0, APP_SEG, !DPL_USER, 1);
ffff80000010b0ab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b0af:	48 83 c0 08          	add    $0x8,%rax
ffff80000010b0b3:	66 c7 00 00 00       	movw   $0x0,(%rax)
ffff80000010b0b8:	66 c7 40 02 00 00    	movw   $0x0,0x2(%rax)
ffff80000010b0be:	c6 40 04 00          	movb   $0x0,0x4(%rax)
ffff80000010b0c2:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b0c6:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010b0c9:	83 ca 0a             	or     $0xa,%edx
ffff80000010b0cc:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b0cf:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b0d3:	83 ca 10             	or     $0x10,%edx
ffff80000010b0d6:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b0d9:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b0dd:	83 e2 9f             	and    $0xffffff9f,%edx
ffff80000010b0e0:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b0e3:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b0e7:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010b0ea:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b0ed:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b0f1:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010b0f4:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b0f7:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b0fb:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010b0fe:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b101:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b105:	83 ca 20             	or     $0x20,%edx
ffff80000010b108:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b10b:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b10f:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010b112:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b115:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b119:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010b11c:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b11f:	c6 40 07 00          	movb   $0x0,0x7(%rax)
  gdt[SEG_KDATA] = SEG(STA_W, 0, 0, APP_SEG, !DPL_USER, 0);
ffff80000010b123:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b127:	48 83 c0 10          	add    $0x10,%rax
ffff80000010b12b:	66 c7 00 00 00       	movw   $0x0,(%rax)
ffff80000010b130:	66 c7 40 02 00 00    	movw   $0x0,0x2(%rax)
ffff80000010b136:	c6 40 04 00          	movb   $0x0,0x4(%rax)
ffff80000010b13a:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b13e:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010b141:	83 ca 02             	or     $0x2,%edx
ffff80000010b144:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b147:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b14b:	83 ca 10             	or     $0x10,%edx
ffff80000010b14e:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b151:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b155:	83 e2 9f             	and    $0xffffff9f,%edx
ffff80000010b158:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b15b:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b15f:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010b162:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b165:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b169:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010b16c:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b16f:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b173:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010b176:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b179:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b17d:	83 e2 df             	and    $0xffffffdf,%edx
ffff80000010b180:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b183:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b187:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010b18a:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b18d:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b191:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010b194:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b197:	c6 40 07 00          	movb   $0x0,0x7(%rax)
  gdt[SEG_UCODE32] = (struct segdesc) {}; // required by syscall/sysret
ffff80000010b19b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b19f:	48 83 c0 18          	add    $0x18,%rax
ffff80000010b1a3:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  gdt[SEG_UDATA] = SEG(STA_W, 0, 0, APP_SEG, DPL_USER, 0);
ffff80000010b1aa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b1ae:	48 83 c0 20          	add    $0x20,%rax
ffff80000010b1b2:	66 c7 00 00 00       	movw   $0x0,(%rax)
ffff80000010b1b7:	66 c7 40 02 00 00    	movw   $0x0,0x2(%rax)
ffff80000010b1bd:	c6 40 04 00          	movb   $0x0,0x4(%rax)
ffff80000010b1c1:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b1c5:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010b1c8:	83 ca 02             	or     $0x2,%edx
ffff80000010b1cb:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b1ce:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b1d2:	83 ca 10             	or     $0x10,%edx
ffff80000010b1d5:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b1d8:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b1dc:	83 ca 60             	or     $0x60,%edx
ffff80000010b1df:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b1e2:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b1e6:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010b1e9:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b1ec:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b1f0:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010b1f3:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b1f6:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b1fa:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010b1fd:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b200:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b204:	83 e2 df             	and    $0xffffffdf,%edx
ffff80000010b207:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b20a:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b20e:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010b211:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b214:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b218:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010b21b:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b21e:	c6 40 07 00          	movb   $0x0,0x7(%rax)
  gdt[SEG_UCODE] = SEG((STA_X|STA_R), 0, 0, APP_SEG, DPL_USER, 1);
ffff80000010b222:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b226:	48 83 c0 28          	add    $0x28,%rax
ffff80000010b22a:	66 c7 00 00 00       	movw   $0x0,(%rax)
ffff80000010b22f:	66 c7 40 02 00 00    	movw   $0x0,0x2(%rax)
ffff80000010b235:	c6 40 04 00          	movb   $0x0,0x4(%rax)
ffff80000010b239:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b23d:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010b240:	83 ca 0a             	or     $0xa,%edx
ffff80000010b243:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b246:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b24a:	83 ca 10             	or     $0x10,%edx
ffff80000010b24d:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b250:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b254:	83 ca 60             	or     $0x60,%edx
ffff80000010b257:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b25a:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b25e:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010b261:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b264:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b268:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010b26b:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b26e:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b272:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010b275:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b278:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b27c:	83 ca 20             	or     $0x20,%edx
ffff80000010b27f:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b282:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b286:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010b289:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b28c:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b290:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010b293:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b296:	c6 40 07 00          	movb   $0x0,0x7(%rax)
  gdt[SEG_KCPU]  = (struct segdesc) {};
ffff80000010b29a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b29e:	48 83 c0 30          	add    $0x30,%rax
ffff80000010b2a2:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  gdt[SEG_TSS]   = SEG(STS_T64A, 0xb, addr, !APP_SEG, DPL_USER, 0);
ffff80000010b2a9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b2ad:	48 83 c0 38          	add    $0x38,%rax
ffff80000010b2b1:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010b2b5:	89 d7                	mov    %edx,%edi
ffff80000010b2b7:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010b2bb:	48 c1 ea 10          	shr    $0x10,%rdx
ffff80000010b2bf:	89 d6                	mov    %edx,%esi
ffff80000010b2c1:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010b2c5:	48 c1 ea 18          	shr    $0x18,%rdx
ffff80000010b2c9:	89 d1                	mov    %edx,%ecx
ffff80000010b2cb:	66 c7 00 0b 00       	movw   $0xb,(%rax)
ffff80000010b2d0:	66 89 78 02          	mov    %di,0x2(%rax)
ffff80000010b2d4:	40 88 70 04          	mov    %sil,0x4(%rax)
ffff80000010b2d8:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b2dc:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010b2df:	83 ca 09             	or     $0x9,%edx
ffff80000010b2e2:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b2e5:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b2e9:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010b2ec:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b2ef:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b2f3:	83 ca 60             	or     $0x60,%edx
ffff80000010b2f6:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b2f9:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b2fd:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010b300:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b303:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b307:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010b30a:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b30d:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b311:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010b314:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b317:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b31b:	83 e2 df             	and    $0xffffffdf,%edx
ffff80000010b31e:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b321:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b325:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010b328:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b32b:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b32f:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010b332:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b335:	88 48 07             	mov    %cl,0x7(%rax)
  gdt[SEG_TSS+1] = SEG(0, addr >> 32, addr >> 48, 0, 0, 0);
ffff80000010b338:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b33c:	48 83 c0 40          	add    $0x40,%rax
ffff80000010b340:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010b344:	48 c1 ea 20          	shr    $0x20,%rdx
ffff80000010b348:	41 89 d1             	mov    %edx,%r9d
ffff80000010b34b:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010b34f:	48 c1 ea 30          	shr    $0x30,%rdx
ffff80000010b353:	41 89 d0             	mov    %edx,%r8d
ffff80000010b356:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010b35a:	48 c1 ea 30          	shr    $0x30,%rdx
ffff80000010b35e:	48 c1 ea 10          	shr    $0x10,%rdx
ffff80000010b362:	89 d7                	mov    %edx,%edi
ffff80000010b364:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010b368:	48 c1 ea 20          	shr    $0x20,%rdx
ffff80000010b36c:	48 c1 ea 3c          	shr    $0x3c,%rdx
ffff80000010b370:	83 e2 0f             	and    $0xf,%edx
ffff80000010b373:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff80000010b377:	48 c1 e9 30          	shr    $0x30,%rcx
ffff80000010b37b:	48 c1 e9 18          	shr    $0x18,%rcx
ffff80000010b37f:	89 ce                	mov    %ecx,%esi
ffff80000010b381:	66 44 89 08          	mov    %r9w,(%rax)
ffff80000010b385:	66 44 89 40 02       	mov    %r8w,0x2(%rax)
ffff80000010b38a:	40 88 78 04          	mov    %dil,0x4(%rax)
ffff80000010b38e:	0f b6 48 05          	movzbl 0x5(%rax),%ecx
ffff80000010b392:	83 e1 f0             	and    $0xfffffff0,%ecx
ffff80000010b395:	88 48 05             	mov    %cl,0x5(%rax)
ffff80000010b398:	0f b6 48 05          	movzbl 0x5(%rax),%ecx
ffff80000010b39c:	83 e1 ef             	and    $0xffffffef,%ecx
ffff80000010b39f:	88 48 05             	mov    %cl,0x5(%rax)
ffff80000010b3a2:	0f b6 48 05          	movzbl 0x5(%rax),%ecx
ffff80000010b3a6:	83 e1 9f             	and    $0xffffff9f,%ecx
ffff80000010b3a9:	88 48 05             	mov    %cl,0x5(%rax)
ffff80000010b3ac:	0f b6 48 05          	movzbl 0x5(%rax),%ecx
ffff80000010b3b0:	83 c9 80             	or     $0xffffff80,%ecx
ffff80000010b3b3:	88 48 05             	mov    %cl,0x5(%rax)
ffff80000010b3b6:	89 d1                	mov    %edx,%ecx
ffff80000010b3b8:	83 e1 0f             	and    $0xf,%ecx
ffff80000010b3bb:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b3bf:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010b3c2:	09 ca                	or     %ecx,%edx
ffff80000010b3c4:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b3c7:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b3cb:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010b3ce:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b3d1:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b3d5:	83 e2 df             	and    $0xffffffdf,%edx
ffff80000010b3d8:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b3db:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b3df:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010b3e2:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b3e5:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b3e9:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010b3ec:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b3ef:	40 88 70 07          	mov    %sil,0x7(%rax)
  lgdt((void*) gdt, (NSEGS+1) * sizeof(struct segdesc));
ffff80000010b3f3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b3f7:	be 48 00 00 00       	mov    $0x48,%esi
ffff80000010b3fc:	48 89 c7             	mov    %rax,%rdi
ffff80000010b3ff:	48 b8 9a ae 10 00 00 	movabs $0xffff80000010ae9a,%rax
ffff80000010b406:	80 ff ff 
ffff80000010b409:	ff d0                	call   *%rax
  ltr(SEG_TSS << 3);
ffff80000010b40b:	bf 38 00 00 00       	mov    $0x38,%edi
ffff80000010b410:	48 b8 f5 ae 10 00 00 	movabs $0xffff80000010aef5,%rax
ffff80000010b417:	80 ff ff 
ffff80000010b41a:	ff d0                	call   *%rax
};
ffff80000010b41c:	90                   	nop
ffff80000010b41d:	c9                   	leave
ffff80000010b41e:	c3                   	ret

ffff80000010b41f <setupkvm>:
{
ffff80000010b41f:	f3 0f 1e fa          	endbr64
ffff80000010b423:	55                   	push   %rbp
ffff80000010b424:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b427:	48 83 ec 10          	sub    $0x10,%rsp
  pml4e_t *pml4 = (pml4e_t*) kalloc();
ffff80000010b42b:	48 b8 00 43 10 00 00 	movabs $0xffff800000104300,%rax
ffff80000010b432:	80 ff ff 
ffff80000010b435:	ff d0                	call   *%rax
ffff80000010b437:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(pml4, 0, PGSIZE);
ffff80000010b43b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b43f:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b444:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b449:	48 89 c7             	mov    %rax,%rdi
ffff80000010b44c:	48 b8 87 7d 10 00 00 	movabs $0xffff800000107d87,%rax
ffff80000010b453:	80 ff ff 
ffff80000010b456:	ff d0                	call   *%rax
  pml4[256] = v2p(kpdpt) | PTE_P | PTE_W;
ffff80000010b458:	48 b8 60 e5 11 00 00 	movabs $0xffff80000011e560,%rax
ffff80000010b45f:	80 ff ff 
ffff80000010b462:	48 8b 00             	mov    (%rax),%rax
ffff80000010b465:	48 89 c7             	mov    %rax,%rdi
ffff80000010b468:	48 b8 2b af 10 00 00 	movabs $0xffff80000010af2b,%rax
ffff80000010b46f:	80 ff ff 
ffff80000010b472:	ff d0                	call   *%rax
ffff80000010b474:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010b478:	48 81 c2 00 08 00 00 	add    $0x800,%rdx
ffff80000010b47f:	48 83 c8 03          	or     $0x3,%rax
ffff80000010b483:	48 89 02             	mov    %rax,(%rdx)
  return pml4;
ffff80000010b486:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
};
ffff80000010b48a:	c9                   	leave
ffff80000010b48b:	c3                   	ret

ffff80000010b48c <kvmalloc>:
{
ffff80000010b48c:	f3 0f 1e fa          	endbr64
ffff80000010b490:	55                   	push   %rbp
ffff80000010b491:	48 89 e5             	mov    %rsp,%rbp
  kpml4 = (pml4e_t*) kalloc();
ffff80000010b494:	48 b8 00 43 10 00 00 	movabs $0xffff800000104300,%rax
ffff80000010b49b:	80 ff ff 
ffff80000010b49e:	ff d0                	call   *%rax
ffff80000010b4a0:	48 ba 58 e5 11 00 00 	movabs $0xffff80000011e558,%rdx
ffff80000010b4a7:	80 ff ff 
ffff80000010b4aa:	48 89 02             	mov    %rax,(%rdx)
  memset(kpml4, 0, PGSIZE);
ffff80000010b4ad:	48 b8 58 e5 11 00 00 	movabs $0xffff80000011e558,%rax
ffff80000010b4b4:	80 ff ff 
ffff80000010b4b7:	48 8b 00             	mov    (%rax),%rax
ffff80000010b4ba:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b4bf:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b4c4:	48 89 c7             	mov    %rax,%rdi
ffff80000010b4c7:	48 b8 87 7d 10 00 00 	movabs $0xffff800000107d87,%rax
ffff80000010b4ce:	80 ff ff 
ffff80000010b4d1:	ff d0                	call   *%rax
  kpdpt = (pde_t*) kalloc();
ffff80000010b4d3:	48 b8 00 43 10 00 00 	movabs $0xffff800000104300,%rax
ffff80000010b4da:	80 ff ff 
ffff80000010b4dd:	ff d0                	call   *%rax
ffff80000010b4df:	48 ba 60 e5 11 00 00 	movabs $0xffff80000011e560,%rdx
ffff80000010b4e6:	80 ff ff 
ffff80000010b4e9:	48 89 02             	mov    %rax,(%rdx)
  memset(kpdpt, 0, PGSIZE);
ffff80000010b4ec:	48 b8 60 e5 11 00 00 	movabs $0xffff80000011e560,%rax
ffff80000010b4f3:	80 ff ff 
ffff80000010b4f6:	48 8b 00             	mov    (%rax),%rax
ffff80000010b4f9:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b4fe:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b503:	48 89 c7             	mov    %rax,%rdi
ffff80000010b506:	48 b8 87 7d 10 00 00 	movabs $0xffff800000107d87,%rax
ffff80000010b50d:	80 ff ff 
ffff80000010b510:	ff d0                	call   *%rax
  kpml4[PMX(KERNBASE)] = v2p(kpdpt) | PTE_P | PTE_W;
ffff80000010b512:	48 b8 60 e5 11 00 00 	movabs $0xffff80000011e560,%rax
ffff80000010b519:	80 ff ff 
ffff80000010b51c:	48 8b 00             	mov    (%rax),%rax
ffff80000010b51f:	48 89 c7             	mov    %rax,%rdi
ffff80000010b522:	48 b8 2b af 10 00 00 	movabs $0xffff80000010af2b,%rax
ffff80000010b529:	80 ff ff 
ffff80000010b52c:	ff d0                	call   *%rax
ffff80000010b52e:	48 ba 58 e5 11 00 00 	movabs $0xffff80000011e558,%rdx
ffff80000010b535:	80 ff ff 
ffff80000010b538:	48 8b 12             	mov    (%rdx),%rdx
ffff80000010b53b:	48 81 c2 00 08 00 00 	add    $0x800,%rdx
ffff80000010b542:	48 83 c8 03          	or     $0x3,%rax
ffff80000010b546:	48 89 02             	mov    %rax,(%rdx)
  kpdpt[0] = 0 | PTE_PS | PTE_P | PTE_W;
ffff80000010b549:	48 b8 60 e5 11 00 00 	movabs $0xffff80000011e560,%rax
ffff80000010b550:	80 ff ff 
ffff80000010b553:	48 8b 00             	mov    (%rax),%rax
ffff80000010b556:	48 c7 00 83 00 00 00 	movq   $0x83,(%rax)
  kpdpt[3] = 0xC0000000 | PTE_PS | PTE_P | PTE_W | PTE_PWT | PTE_PCD;
ffff80000010b55d:	48 b8 60 e5 11 00 00 	movabs $0xffff80000011e560,%rax
ffff80000010b564:	80 ff ff 
ffff80000010b567:	48 8b 00             	mov    (%rax),%rax
ffff80000010b56a:	48 83 c0 18          	add    $0x18,%rax
ffff80000010b56e:	b9 9b 00 00 c0       	mov    $0xc000009b,%ecx
ffff80000010b573:	48 89 08             	mov    %rcx,(%rax)
  switchkvm();
ffff80000010b576:	48 b8 99 b8 10 00 00 	movabs $0xffff80000010b899,%rax
ffff80000010b57d:	80 ff ff 
ffff80000010b580:	ff d0                	call   *%rax
}
ffff80000010b582:	90                   	nop
ffff80000010b583:	5d                   	pop    %rbp
ffff80000010b584:	c3                   	ret

ffff80000010b585 <switchuvm>:
{
ffff80000010b585:	f3 0f 1e fa          	endbr64
ffff80000010b589:	55                   	push   %rbp
ffff80000010b58a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b58d:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010b591:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  pushcli();
ffff80000010b595:	48 b8 03 7c 10 00 00 	movabs $0xffff800000107c03,%rax
ffff80000010b59c:	80 ff ff 
ffff80000010b59f:	ff d0                	call   *%rax
  if(p->pgdir == 0)
ffff80000010b5a1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b5a5:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010b5a9:	48 85 c0             	test   %rax,%rax
ffff80000010b5ac:	75 19                	jne    ffff80000010b5c7 <switchuvm+0x42>
    panic("switchuvm: no pgdir");
ffff80000010b5ae:	48 b8 18 cb 10 00 00 	movabs $0xffff80000010cb18,%rax
ffff80000010b5b5:	80 ff ff 
ffff80000010b5b8:	48 89 c7             	mov    %rax,%rdi
ffff80000010b5bb:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010b5c2:	80 ff ff 
ffff80000010b5c5:	ff d0                	call   *%rax
  uint *tss = (uint*) (((char*) cpu->local) + 1024);
ffff80000010b5c7:	64 48 8b 04 25 f0 ff 	mov    %fs:0xfffffffffffffff0,%rax
ffff80000010b5ce:	ff ff 
ffff80000010b5d0:	48 8b 40 20          	mov    0x20(%rax),%rax
ffff80000010b5d4:	48 05 00 04 00 00    	add    $0x400,%rax
ffff80000010b5da:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  const addr_t stktop = (addr_t)p->kstack + KSTACKSIZE;
ffff80000010b5de:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b5e2:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff80000010b5e6:	48 05 00 10 00 00    	add    $0x1000,%rax
ffff80000010b5ec:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  tss[1] = (uint)stktop; // https://wiki.osdev.org/Task_State_Segment
ffff80000010b5f0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b5f4:	48 83 c0 04          	add    $0x4,%rax
ffff80000010b5f8:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff80000010b5fc:	89 10                	mov    %edx,(%rax)
  tss[2] = (uint)(stktop >> 32);
ffff80000010b5fe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b602:	48 c1 e8 20          	shr    $0x20,%rax
ffff80000010b606:	48 89 c2             	mov    %rax,%rdx
ffff80000010b609:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b60d:	48 83 c0 08          	add    $0x8,%rax
ffff80000010b611:	89 10                	mov    %edx,(%rax)
  lcr3(v2p(p->pgdir));
ffff80000010b613:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b617:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010b61b:	48 89 c7             	mov    %rax,%rdi
ffff80000010b61e:	48 b8 2b af 10 00 00 	movabs $0xffff80000010af2b,%rax
ffff80000010b625:	80 ff ff 
ffff80000010b628:	ff d0                	call   *%rax
ffff80000010b62a:	48 89 c7             	mov    %rax,%rdi
ffff80000010b62d:	48 b8 11 af 10 00 00 	movabs $0xffff80000010af11,%rax
ffff80000010b634:	80 ff ff 
ffff80000010b637:	ff d0                	call   *%rax
  popcli();
ffff80000010b639:	48 b8 75 7c 10 00 00 	movabs $0xffff800000107c75,%rax
ffff80000010b640:	80 ff ff 
ffff80000010b643:	ff d0                	call   *%rax
}
ffff80000010b645:	90                   	nop
ffff80000010b646:	c9                   	leave
ffff80000010b647:	c3                   	ret

ffff80000010b648 <walkpgdir>:
// In 64-bit mode, the page table has four levels: PML4, PDPT, PD and PT
// For each level, we dereference the correct entry, or allocate and
// initialize entry if the PTE_P bit is not set
static pte_t *
walkpgdir(pde_t *pml4, const void *va, int alloc)
{
ffff80000010b648:	f3 0f 1e fa          	endbr64
ffff80000010b64c:	55                   	push   %rbp
ffff80000010b64d:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b650:	48 83 ec 50          	sub    $0x50,%rsp
ffff80000010b654:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
ffff80000010b658:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
ffff80000010b65c:	89 55 bc             	mov    %edx,-0x44(%rbp)
  pml4e_t *pml4e;
  pdpe_t *pdp, *pdpe;
  pde_t *pde, *pd, *pgtab;

  // from the PML4, find or allocate the appropriate PDP table
  pml4e = &pml4[PMX(va)];
ffff80000010b65f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010b663:	48 c1 e8 27          	shr    $0x27,%rax
ffff80000010b667:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010b66c:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010b673:	00 
ffff80000010b674:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010b678:	48 01 d0             	add    %rdx,%rax
ffff80000010b67b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  if(*pml4e & PTE_P)
ffff80000010b67f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010b683:	48 8b 00             	mov    (%rax),%rax
ffff80000010b686:	83 e0 01             	and    $0x1,%eax
ffff80000010b689:	48 85 c0             	test   %rax,%rax
ffff80000010b68c:	74 23                	je     ffff80000010b6b1 <walkpgdir+0x69>
    pdp = (pdpe_t*)P2V(PTE_ADDR(*pml4e));
ffff80000010b68e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010b692:	48 8b 00             	mov    (%rax),%rax
ffff80000010b695:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b69b:	48 89 c2             	mov    %rax,%rdx
ffff80000010b69e:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010b6a5:	80 ff ff 
ffff80000010b6a8:	48 01 d0             	add    %rdx,%rax
ffff80000010b6ab:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010b6af:	eb 63                	jmp    ffff80000010b714 <walkpgdir+0xcc>
  else {
    if(!alloc || (pdp = (pdpe_t*)kalloc()) == 0)
ffff80000010b6b1:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
ffff80000010b6b5:	74 17                	je     ffff80000010b6ce <walkpgdir+0x86>
ffff80000010b6b7:	48 b8 00 43 10 00 00 	movabs $0xffff800000104300,%rax
ffff80000010b6be:	80 ff ff 
ffff80000010b6c1:	ff d0                	call   *%rax
ffff80000010b6c3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010b6c7:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff80000010b6cc:	75 0a                	jne    ffff80000010b6d8 <walkpgdir+0x90>
      return 0;
ffff80000010b6ce:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010b6d3:	e9 bf 01 00 00       	jmp    ffff80000010b897 <walkpgdir+0x24f>
    memset(pdp, 0, PGSIZE);
ffff80000010b6d8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b6dc:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b6e1:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b6e6:	48 89 c7             	mov    %rax,%rdi
ffff80000010b6e9:	48 b8 87 7d 10 00 00 	movabs $0xffff800000107d87,%rax
ffff80000010b6f0:	80 ff ff 
ffff80000010b6f3:	ff d0                	call   *%rax
    *pml4e = V2P(pdp) | PTE_P | PTE_W | PTE_U;
ffff80000010b6f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b6f9:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010b700:	80 00 00 
ffff80000010b703:	48 01 d0             	add    %rdx,%rax
ffff80000010b706:	48 83 c8 07          	or     $0x7,%rax
ffff80000010b70a:	48 89 c2             	mov    %rax,%rdx
ffff80000010b70d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010b711:	48 89 10             	mov    %rdx,(%rax)
  }

  //from the PDP, find or allocate the appropriate PD (page directory)
  pdpe = &pdp[PDPX(va)];
ffff80000010b714:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010b718:	48 c1 e8 1e          	shr    $0x1e,%rax
ffff80000010b71c:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010b721:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010b728:	00 
ffff80000010b729:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b72d:	48 01 d0             	add    %rdx,%rax
ffff80000010b730:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  if(*pdpe & PTE_P)
ffff80000010b734:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b738:	48 8b 00             	mov    (%rax),%rax
ffff80000010b73b:	83 e0 01             	and    $0x1,%eax
ffff80000010b73e:	48 85 c0             	test   %rax,%rax
ffff80000010b741:	74 23                	je     ffff80000010b766 <walkpgdir+0x11e>
    pd = (pde_t*)P2V(PTE_ADDR(*pdpe));
ffff80000010b743:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b747:	48 8b 00             	mov    (%rax),%rax
ffff80000010b74a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b750:	48 89 c2             	mov    %rax,%rdx
ffff80000010b753:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010b75a:	80 ff ff 
ffff80000010b75d:	48 01 d0             	add    %rdx,%rax
ffff80000010b760:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010b764:	eb 63                	jmp    ffff80000010b7c9 <walkpgdir+0x181>
  else {
    if(!alloc || (pd = (pde_t*)kalloc()) == 0)//allocate page table
ffff80000010b766:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
ffff80000010b76a:	74 17                	je     ffff80000010b783 <walkpgdir+0x13b>
ffff80000010b76c:	48 b8 00 43 10 00 00 	movabs $0xffff800000104300,%rax
ffff80000010b773:	80 ff ff 
ffff80000010b776:	ff d0                	call   *%rax
ffff80000010b778:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010b77c:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010b781:	75 0a                	jne    ffff80000010b78d <walkpgdir+0x145>
      return 0;
ffff80000010b783:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010b788:	e9 0a 01 00 00       	jmp    ffff80000010b897 <walkpgdir+0x24f>
    memset(pd, 0, PGSIZE);
ffff80000010b78d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b791:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b796:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b79b:	48 89 c7             	mov    %rax,%rdi
ffff80000010b79e:	48 b8 87 7d 10 00 00 	movabs $0xffff800000107d87,%rax
ffff80000010b7a5:	80 ff ff 
ffff80000010b7a8:	ff d0                	call   *%rax
    *pdpe = V2P(pd) | PTE_P | PTE_W | PTE_U;
ffff80000010b7aa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b7ae:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010b7b5:	80 00 00 
ffff80000010b7b8:	48 01 d0             	add    %rdx,%rax
ffff80000010b7bb:	48 83 c8 07          	or     $0x7,%rax
ffff80000010b7bf:	48 89 c2             	mov    %rax,%rdx
ffff80000010b7c2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b7c6:	48 89 10             	mov    %rdx,(%rax)
  }

  // from the PD, find or allocate the appropriate page table
  pde = &pd[PDX(va)];
ffff80000010b7c9:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010b7cd:	48 c1 e8 15          	shr    $0x15,%rax
ffff80000010b7d1:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010b7d6:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010b7dd:	00 
ffff80000010b7de:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b7e2:	48 01 d0             	add    %rdx,%rax
ffff80000010b7e5:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  if(*pde & PTE_P)
ffff80000010b7e9:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010b7ed:	48 8b 00             	mov    (%rax),%rax
ffff80000010b7f0:	83 e0 01             	and    $0x1,%eax
ffff80000010b7f3:	48 85 c0             	test   %rax,%rax
ffff80000010b7f6:	74 23                	je     ffff80000010b81b <walkpgdir+0x1d3>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
ffff80000010b7f8:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010b7fc:	48 8b 00             	mov    (%rax),%rax
ffff80000010b7ff:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b805:	48 89 c2             	mov    %rax,%rdx
ffff80000010b808:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010b80f:	80 ff ff 
ffff80000010b812:	48 01 d0             	add    %rdx,%rax
ffff80000010b815:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010b819:	eb 60                	jmp    ffff80000010b87b <walkpgdir+0x233>
  else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)//allocate page table
ffff80000010b81b:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
ffff80000010b81f:	74 17                	je     ffff80000010b838 <walkpgdir+0x1f0>
ffff80000010b821:	48 b8 00 43 10 00 00 	movabs $0xffff800000104300,%rax
ffff80000010b828:	80 ff ff 
ffff80000010b82b:	ff d0                	call   *%rax
ffff80000010b82d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010b831:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010b836:	75 07                	jne    ffff80000010b83f <walkpgdir+0x1f7>
      return 0;
ffff80000010b838:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010b83d:	eb 58                	jmp    ffff80000010b897 <walkpgdir+0x24f>
    memset(pgtab, 0, PGSIZE);
ffff80000010b83f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b843:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b848:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b84d:	48 89 c7             	mov    %rax,%rdi
ffff80000010b850:	48 b8 87 7d 10 00 00 	movabs $0xffff800000107d87,%rax
ffff80000010b857:	80 ff ff 
ffff80000010b85a:	ff d0                	call   *%rax
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
ffff80000010b85c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b860:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010b867:	80 00 00 
ffff80000010b86a:	48 01 d0             	add    %rdx,%rax
ffff80000010b86d:	48 83 c8 07          	or     $0x7,%rax
ffff80000010b871:	48 89 c2             	mov    %rax,%rdx
ffff80000010b874:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010b878:	48 89 10             	mov    %rdx,(%rax)
  }

  return &pgtab[PTX(va)];
ffff80000010b87b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010b87f:	48 c1 e8 0c          	shr    $0xc,%rax
ffff80000010b883:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010b888:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010b88f:	00 
ffff80000010b890:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b894:	48 01 d0             	add    %rdx,%rax
}
ffff80000010b897:	c9                   	leave
ffff80000010b898:	c3                   	ret

ffff80000010b899 <switchkvm>:

void
switchkvm(void)
{
ffff80000010b899:	f3 0f 1e fa          	endbr64
ffff80000010b89d:	55                   	push   %rbp
ffff80000010b89e:	48 89 e5             	mov    %rsp,%rbp
  lcr3(v2p(kpml4));
ffff80000010b8a1:	48 b8 58 e5 11 00 00 	movabs $0xffff80000011e558,%rax
ffff80000010b8a8:	80 ff ff 
ffff80000010b8ab:	48 8b 00             	mov    (%rax),%rax
ffff80000010b8ae:	48 89 c7             	mov    %rax,%rdi
ffff80000010b8b1:	48 b8 2b af 10 00 00 	movabs $0xffff80000010af2b,%rax
ffff80000010b8b8:	80 ff ff 
ffff80000010b8bb:	ff d0                	call   *%rax
ffff80000010b8bd:	48 89 c7             	mov    %rax,%rdi
ffff80000010b8c0:	48 b8 11 af 10 00 00 	movabs $0xffff80000010af11,%rax
ffff80000010b8c7:	80 ff ff 
ffff80000010b8ca:	ff d0                	call   *%rax
}
ffff80000010b8cc:	90                   	nop
ffff80000010b8cd:	5d                   	pop    %rbp
ffff80000010b8ce:	c3                   	ret

ffff80000010b8cf <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
int
mappages(pde_t *pgdir, void *va, addr_t size, addr_t pa, int perm)
{
ffff80000010b8cf:	f3 0f 1e fa          	endbr64
ffff80000010b8d3:	55                   	push   %rbp
ffff80000010b8d4:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b8d7:	48 83 ec 50          	sub    $0x50,%rsp
ffff80000010b8db:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010b8df:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010b8e3:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
ffff80000010b8e7:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
ffff80000010b8eb:	44 89 45 bc          	mov    %r8d,-0x44(%rbp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((addr_t)va);
ffff80000010b8ef:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010b8f3:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b8f9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  last = (char*)PGROUNDDOWN(((addr_t)va) + size - 1);
ffff80000010b8fd:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffff80000010b901:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010b905:	48 01 d0             	add    %rdx,%rax
ffff80000010b908:	48 83 e8 01          	sub    $0x1,%rax
ffff80000010b90c:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b912:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
ffff80000010b916:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff80000010b91a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b91e:	ba 01 00 00 00       	mov    $0x1,%edx
ffff80000010b923:	48 89 ce             	mov    %rcx,%rsi
ffff80000010b926:	48 89 c7             	mov    %rax,%rdi
ffff80000010b929:	48 b8 48 b6 10 00 00 	movabs $0xffff80000010b648,%rax
ffff80000010b930:	80 ff ff 
ffff80000010b933:	ff d0                	call   *%rax
ffff80000010b935:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010b939:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010b93e:	75 07                	jne    ffff80000010b947 <mappages+0x78>
      return -1;
ffff80000010b940:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010b945:	eb 64                	jmp    ffff80000010b9ab <mappages+0xdc>
    if(*pte & PTE_P)
ffff80000010b947:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b94b:	48 8b 00             	mov    (%rax),%rax
ffff80000010b94e:	83 e0 01             	and    $0x1,%eax
ffff80000010b951:	48 85 c0             	test   %rax,%rax
ffff80000010b954:	74 19                	je     ffff80000010b96f <mappages+0xa0>
      panic("remap");
ffff80000010b956:	48 b8 2c cb 10 00 00 	movabs $0xffff80000010cb2c,%rax
ffff80000010b95d:	80 ff ff 
ffff80000010b960:	48 89 c7             	mov    %rax,%rdi
ffff80000010b963:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010b96a:	80 ff ff 
ffff80000010b96d:	ff d0                	call   *%rax
    *pte = pa | perm | PTE_P;
ffff80000010b96f:	8b 45 bc             	mov    -0x44(%rbp),%eax
ffff80000010b972:	48 98                	cltq
ffff80000010b974:	48 0b 45 c0          	or     -0x40(%rbp),%rax
ffff80000010b978:	48 83 c8 01          	or     $0x1,%rax
ffff80000010b97c:	48 89 c2             	mov    %rax,%rdx
ffff80000010b97f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b983:	48 89 10             	mov    %rdx,(%rax)
    if(a == last)
ffff80000010b986:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b98a:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
ffff80000010b98e:	74 15                	je     ffff80000010b9a5 <mappages+0xd6>
      break;
    a += PGSIZE;
ffff80000010b990:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffff80000010b997:	00 
    pa += PGSIZE;
ffff80000010b998:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
ffff80000010b99f:	00 
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
ffff80000010b9a0:	e9 71 ff ff ff       	jmp    ffff80000010b916 <mappages+0x47>
      break;
ffff80000010b9a5:	90                   	nop
  }
  return 0;
ffff80000010b9a6:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010b9ab:	c9                   	leave
ffff80000010b9ac:	c3                   	ret

ffff80000010b9ad <inituvm>:

// Load the initcode into address 0x1000 (4KB) of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
ffff80000010b9ad:	f3 0f 1e fa          	endbr64
ffff80000010b9b1:	55                   	push   %rbp
ffff80000010b9b2:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b9b5:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010b9b9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010b9bd:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff80000010b9c1:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *mem;

  if(sz >= PGSIZE)
ffff80000010b9c4:	81 7d dc ff 0f 00 00 	cmpl   $0xfff,-0x24(%rbp)
ffff80000010b9cb:	76 19                	jbe    ffff80000010b9e6 <inituvm+0x39>
    panic("inituvm: more than a page");
ffff80000010b9cd:	48 b8 32 cb 10 00 00 	movabs $0xffff80000010cb32,%rax
ffff80000010b9d4:	80 ff ff 
ffff80000010b9d7:	48 89 c7             	mov    %rax,%rdi
ffff80000010b9da:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010b9e1:	80 ff ff 
ffff80000010b9e4:	ff d0                	call   *%rax

  mem = kalloc();
ffff80000010b9e6:	48 b8 00 43 10 00 00 	movabs $0xffff800000104300,%rax
ffff80000010b9ed:	80 ff ff 
ffff80000010b9f0:	ff d0                	call   *%rax
ffff80000010b9f2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(mem, 0, PGSIZE);
ffff80000010b9f6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b9fa:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b9ff:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010ba04:	48 89 c7             	mov    %rax,%rdi
ffff80000010ba07:	48 b8 87 7d 10 00 00 	movabs $0xffff800000107d87,%rax
ffff80000010ba0e:	80 ff ff 
ffff80000010ba11:	ff d0                	call   *%rax
  mappages(pgdir, (void *)PGSIZE, PGSIZE, V2P(mem), PTE_W|PTE_U);
ffff80000010ba13:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010ba17:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010ba1e:	80 00 00 
ffff80000010ba21:	48 01 c2             	add    %rax,%rdx
ffff80000010ba24:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010ba28:	41 b8 06 00 00 00    	mov    $0x6,%r8d
ffff80000010ba2e:	48 89 d1             	mov    %rdx,%rcx
ffff80000010ba31:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010ba36:	be 00 10 00 00       	mov    $0x1000,%esi
ffff80000010ba3b:	48 89 c7             	mov    %rax,%rdi
ffff80000010ba3e:	48 b8 cf b8 10 00 00 	movabs $0xffff80000010b8cf,%rax
ffff80000010ba45:	80 ff ff 
ffff80000010ba48:	ff d0                	call   *%rax

  memmove(mem, init, sz);
ffff80000010ba4a:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffff80000010ba4d:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff80000010ba51:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010ba55:	48 89 ce             	mov    %rcx,%rsi
ffff80000010ba58:	48 89 c7             	mov    %rax,%rdi
ffff80000010ba5b:	48 b8 94 7e 10 00 00 	movabs $0xffff800000107e94,%rax
ffff80000010ba62:	80 ff ff 
ffff80000010ba65:	ff d0                	call   *%rax
}
ffff80000010ba67:	90                   	nop
ffff80000010ba68:	c9                   	leave
ffff80000010ba69:	c3                   	ret

ffff80000010ba6a <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
ffff80000010ba6a:	f3 0f 1e fa          	endbr64
ffff80000010ba6e:	55                   	push   %rbp
ffff80000010ba6f:	48 89 e5             	mov    %rsp,%rbp
ffff80000010ba72:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010ba76:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010ba7a:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010ba7e:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
ffff80000010ba82:	89 4d c4             	mov    %ecx,-0x3c(%rbp)
ffff80000010ba85:	44 89 45 c0          	mov    %r8d,-0x40(%rbp)
  uint i, n;
  addr_t pa;
  pte_t *pte;

  if((addr_t) addr % PGSIZE != 0)
ffff80000010ba89:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010ba8d:	25 ff 0f 00 00       	and    $0xfff,%eax
ffff80000010ba92:	48 85 c0             	test   %rax,%rax
ffff80000010ba95:	74 19                	je     ffff80000010bab0 <loaduvm+0x46>
    panic("loaduvm: addr must be page aligned");
ffff80000010ba97:	48 b8 50 cb 10 00 00 	movabs $0xffff80000010cb50,%rax
ffff80000010ba9e:	80 ff ff 
ffff80000010baa1:	48 89 c7             	mov    %rax,%rdi
ffff80000010baa4:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010baab:	80 ff ff 
ffff80000010baae:	ff d0                	call   *%rax
  for(i = 0; i < sz; i += PGSIZE){
ffff80000010bab0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010bab7:	e9 c7 00 00 00       	jmp    ffff80000010bb83 <loaduvm+0x119>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
ffff80000010babc:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010babf:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010bac3:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffff80000010bac7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010bacb:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010bad0:	48 89 ce             	mov    %rcx,%rsi
ffff80000010bad3:	48 89 c7             	mov    %rax,%rdi
ffff80000010bad6:	48 b8 48 b6 10 00 00 	movabs $0xffff80000010b648,%rax
ffff80000010badd:	80 ff ff 
ffff80000010bae0:	ff d0                	call   *%rax
ffff80000010bae2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010bae6:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010baeb:	75 19                	jne    ffff80000010bb06 <loaduvm+0x9c>
      panic("loaduvm: address should exist");
ffff80000010baed:	48 b8 73 cb 10 00 00 	movabs $0xffff80000010cb73,%rax
ffff80000010baf4:	80 ff ff 
ffff80000010baf7:	48 89 c7             	mov    %rax,%rdi
ffff80000010bafa:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010bb01:	80 ff ff 
ffff80000010bb04:	ff d0                	call   *%rax
    pa = PTE_ADDR(*pte);
ffff80000010bb06:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bb0a:	48 8b 00             	mov    (%rax),%rax
ffff80000010bb0d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010bb13:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if(sz - i < PGSIZE)
ffff80000010bb17:	8b 45 c0             	mov    -0x40(%rbp),%eax
ffff80000010bb1a:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff80000010bb1d:	3d ff 0f 00 00       	cmp    $0xfff,%eax
ffff80000010bb22:	77 0b                	ja     ffff80000010bb2f <loaduvm+0xc5>
      n = sz - i;
ffff80000010bb24:	8b 45 c0             	mov    -0x40(%rbp),%eax
ffff80000010bb27:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff80000010bb2a:	89 45 f8             	mov    %eax,-0x8(%rbp)
ffff80000010bb2d:	eb 07                	jmp    ffff80000010bb36 <loaduvm+0xcc>
    else
      n = PGSIZE;
ffff80000010bb2f:	c7 45 f8 00 10 00 00 	movl   $0x1000,-0x8(%rbp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
ffff80000010bb36:	8b 55 c4             	mov    -0x3c(%rbp),%edx
ffff80000010bb39:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010bb3c:	8d 34 02             	lea    (%rdx,%rax,1),%esi
ffff80000010bb3f:	48 ba 00 00 00 00 00 	movabs $0xffff800000000000,%rdx
ffff80000010bb46:	80 ff ff 
ffff80000010bb49:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bb4d:	48 01 d0             	add    %rdx,%rax
ffff80000010bb50:	48 89 c7             	mov    %rax,%rdi
ffff80000010bb53:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffff80000010bb56:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010bb5a:	89 d1                	mov    %edx,%ecx
ffff80000010bb5c:	89 f2                	mov    %esi,%edx
ffff80000010bb5e:	48 89 fe             	mov    %rdi,%rsi
ffff80000010bb61:	48 89 c7             	mov    %rax,%rdi
ffff80000010bb64:	48 b8 eb 2f 10 00 00 	movabs $0xffff800000102feb,%rax
ffff80000010bb6b:	80 ff ff 
ffff80000010bb6e:	ff d0                	call   *%rax
ffff80000010bb70:	39 45 f8             	cmp    %eax,-0x8(%rbp)
ffff80000010bb73:	74 07                	je     ffff80000010bb7c <loaduvm+0x112>
      return -1;
ffff80000010bb75:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010bb7a:	eb 18                	jmp    ffff80000010bb94 <loaduvm+0x12a>
  for(i = 0; i < sz; i += PGSIZE){
ffff80000010bb7c:	81 45 fc 00 10 00 00 	addl   $0x1000,-0x4(%rbp)
ffff80000010bb83:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010bb86:	3b 45 c0             	cmp    -0x40(%rbp),%eax
ffff80000010bb89:	0f 82 2d ff ff ff    	jb     ffff80000010babc <loaduvm+0x52>
  }
  return 0;
ffff80000010bb8f:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010bb94:	c9                   	leave
ffff80000010bb95:	c3                   	ret

ffff80000010bb96 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
uint64
allocuvm(pde_t *pgdir, uint64 oldsz, uint64 newsz)
{
ffff80000010bb96:	f3 0f 1e fa          	endbr64
ffff80000010bb9a:	55                   	push   %rbp
ffff80000010bb9b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010bb9e:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010bba2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010bba6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff80000010bbaa:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  char *mem;
  addr_t a;

  if(newsz >= KERNBASE)
ffff80000010bbae:	48 b8 ff ff ff ff ff 	movabs $0xffff7fffffffffff,%rax
ffff80000010bbb5:	7f ff ff 
ffff80000010bbb8:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
ffff80000010bbbc:	73 0a                	jae    ffff80000010bbc8 <allocuvm+0x32>
    return 0;
ffff80000010bbbe:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010bbc3:	e9 14 01 00 00       	jmp    ffff80000010bcdc <allocuvm+0x146>
  if(newsz < oldsz)
ffff80000010bbc8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010bbcc:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
ffff80000010bbd0:	73 09                	jae    ffff80000010bbdb <allocuvm+0x45>
    return oldsz;
ffff80000010bbd2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010bbd6:	e9 01 01 00 00       	jmp    ffff80000010bcdc <allocuvm+0x146>

  a = PGROUNDUP(oldsz);
ffff80000010bbdb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010bbdf:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffff80000010bbe5:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010bbeb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  for(; a < newsz; a += PGSIZE){
ffff80000010bbef:	e9 d6 00 00 00       	jmp    ffff80000010bcca <allocuvm+0x134>
    mem = kalloc();
ffff80000010bbf4:	48 b8 00 43 10 00 00 	movabs $0xffff800000104300,%rax
ffff80000010bbfb:	80 ff ff 
ffff80000010bbfe:	ff d0                	call   *%rax
ffff80000010bc00:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if(mem == 0){
ffff80000010bc04:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010bc09:	75 28                	jne    ffff80000010bc33 <allocuvm+0x9d>
      //cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
ffff80000010bc0b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff80000010bc0f:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff80000010bc13:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bc17:	48 89 ce             	mov    %rcx,%rsi
ffff80000010bc1a:	48 89 c7             	mov    %rax,%rdi
ffff80000010bc1d:	48 b8 de bc 10 00 00 	movabs $0xffff80000010bcde,%rax
ffff80000010bc24:	80 ff ff 
ffff80000010bc27:	ff d0                	call   *%rax
      return 0;
ffff80000010bc29:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010bc2e:	e9 a9 00 00 00       	jmp    ffff80000010bcdc <allocuvm+0x146>
    }
    memset(mem, 0, PGSIZE);
ffff80000010bc33:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bc37:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010bc3c:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010bc41:	48 89 c7             	mov    %rax,%rdi
ffff80000010bc44:	48 b8 87 7d 10 00 00 	movabs $0xffff800000107d87,%rax
ffff80000010bc4b:	80 ff ff 
ffff80000010bc4e:	ff d0                	call   *%rax
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
ffff80000010bc50:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bc54:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010bc5b:	80 00 00 
ffff80000010bc5e:	48 01 c2             	add    %rax,%rdx
ffff80000010bc61:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
ffff80000010bc65:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bc69:	41 b8 06 00 00 00    	mov    $0x6,%r8d
ffff80000010bc6f:	48 89 d1             	mov    %rdx,%rcx
ffff80000010bc72:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010bc77:	48 89 c7             	mov    %rax,%rdi
ffff80000010bc7a:	48 b8 cf b8 10 00 00 	movabs $0xffff80000010b8cf,%rax
ffff80000010bc81:	80 ff ff 
ffff80000010bc84:	ff d0                	call   *%rax
ffff80000010bc86:	85 c0                	test   %eax,%eax
ffff80000010bc88:	79 38                	jns    ffff80000010bcc2 <allocuvm+0x12c>
      //cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
ffff80000010bc8a:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff80000010bc8e:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff80000010bc92:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bc96:	48 89 ce             	mov    %rcx,%rsi
ffff80000010bc99:	48 89 c7             	mov    %rax,%rdi
ffff80000010bc9c:	48 b8 de bc 10 00 00 	movabs $0xffff80000010bcde,%rax
ffff80000010bca3:	80 ff ff 
ffff80000010bca6:	ff d0                	call   *%rax
      kfree(mem);
ffff80000010bca8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bcac:	48 89 c7             	mov    %rax,%rdi
ffff80000010bcaf:	48 b8 fd 41 10 00 00 	movabs $0xffff8000001041fd,%rax
ffff80000010bcb6:	80 ff ff 
ffff80000010bcb9:	ff d0                	call   *%rax
      return 0;
ffff80000010bcbb:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010bcc0:	eb 1a                	jmp    ffff80000010bcdc <allocuvm+0x146>
  for(; a < newsz; a += PGSIZE){
ffff80000010bcc2:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffff80000010bcc9:	00 
ffff80000010bcca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010bcce:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
ffff80000010bcd2:	0f 82 1c ff ff ff    	jb     ffff80000010bbf4 <allocuvm+0x5e>
    }
  }
  return newsz;
ffff80000010bcd8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
}
ffff80000010bcdc:	c9                   	leave
ffff80000010bcdd:	c3                   	ret

ffff80000010bcde <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
deallocuvm(pde_t *pgdir, uint64 oldsz, uint64 newsz)
{
ffff80000010bcde:	f3 0f 1e fa          	endbr64
ffff80000010bce2:	55                   	push   %rbp
ffff80000010bce3:	48 89 e5             	mov    %rsp,%rbp
ffff80000010bce6:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010bcea:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010bcee:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010bcf2:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  pte_t *pte;
  addr_t a, pa;

  if(newsz >= oldsz)
ffff80000010bcf6:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010bcfa:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
ffff80000010bcfe:	72 09                	jb     ffff80000010bd09 <deallocuvm+0x2b>
    return oldsz;
ffff80000010bd00:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010bd04:	e9 d0 00 00 00       	jmp    ffff80000010bdd9 <deallocuvm+0xfb>

  a = PGROUNDUP(newsz);
ffff80000010bd09:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010bd0d:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffff80000010bd13:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010bd19:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  for(; a  < oldsz; a += PGSIZE){
ffff80000010bd1d:	e9 a5 00 00 00       	jmp    ffff80000010bdc7 <deallocuvm+0xe9>
    pte = walkpgdir(pgdir, (char*)a, 0);
ffff80000010bd22:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff80000010bd26:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010bd2a:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010bd2f:	48 89 ce             	mov    %rcx,%rsi
ffff80000010bd32:	48 89 c7             	mov    %rax,%rdi
ffff80000010bd35:	48 b8 48 b6 10 00 00 	movabs $0xffff80000010b648,%rax
ffff80000010bd3c:	80 ff ff 
ffff80000010bd3f:	ff d0                	call   *%rax
ffff80000010bd41:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if(pte && (*pte & PTE_P) != 0){
ffff80000010bd45:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010bd4a:	74 73                	je     ffff80000010bdbf <deallocuvm+0xe1>
ffff80000010bd4c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bd50:	48 8b 00             	mov    (%rax),%rax
ffff80000010bd53:	83 e0 01             	and    $0x1,%eax
ffff80000010bd56:	48 85 c0             	test   %rax,%rax
ffff80000010bd59:	74 64                	je     ffff80000010bdbf <deallocuvm+0xe1>
      pa = PTE_ADDR(*pte);
ffff80000010bd5b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bd5f:	48 8b 00             	mov    (%rax),%rax
ffff80000010bd62:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010bd68:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
      if(pa == 0)
ffff80000010bd6c:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010bd71:	75 19                	jne    ffff80000010bd8c <deallocuvm+0xae>
        panic("kfree");
ffff80000010bd73:	48 b8 91 cb 10 00 00 	movabs $0xffff80000010cb91,%rax
ffff80000010bd7a:	80 ff ff 
ffff80000010bd7d:	48 89 c7             	mov    %rax,%rdi
ffff80000010bd80:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010bd87:	80 ff ff 
ffff80000010bd8a:	ff d0                	call   *%rax
      char *v = P2V(pa);
ffff80000010bd8c:	48 ba 00 00 00 00 00 	movabs $0xffff800000000000,%rdx
ffff80000010bd93:	80 ff ff 
ffff80000010bd96:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bd9a:	48 01 d0             	add    %rdx,%rax
ffff80000010bd9d:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
      kfree(v);
ffff80000010bda1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010bda5:	48 89 c7             	mov    %rax,%rdi
ffff80000010bda8:	48 b8 fd 41 10 00 00 	movabs $0xffff8000001041fd,%rax
ffff80000010bdaf:	80 ff ff 
ffff80000010bdb2:	ff d0                	call   *%rax
      *pte = 0;
ffff80000010bdb4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bdb8:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  for(; a  < oldsz; a += PGSIZE){
ffff80000010bdbf:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffff80000010bdc6:	00 
ffff80000010bdc7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010bdcb:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
ffff80000010bdcf:	0f 82 4d ff ff ff    	jb     ffff80000010bd22 <deallocuvm+0x44>
    }
  }
  return newsz;
ffff80000010bdd5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
}
ffff80000010bdd9:	c9                   	leave
ffff80000010bdda:	c3                   	ret

ffff80000010bddb <freevm>:

// Free all the pages mapped by, and all the memory used for,
// this page table
void
freevm(pml4e_t *pml4)
{
ffff80000010bddb:	f3 0f 1e fa          	endbr64
ffff80000010bddf:	55                   	push   %rbp
ffff80000010bde0:	48 89 e5             	mov    %rsp,%rbp
ffff80000010bde3:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010bde7:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  uint i, j, k, l;
  pde_t *pdp, *pd, *pt;

  if(pml4 == 0)
ffff80000010bdeb:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
ffff80000010bdf0:	75 19                	jne    ffff80000010be0b <freevm+0x30>
    panic("freevm: no pgdir");
ffff80000010bdf2:	48 b8 97 cb 10 00 00 	movabs $0xffff80000010cb97,%rax
ffff80000010bdf9:	80 ff ff 
ffff80000010bdfc:	48 89 c7             	mov    %rax,%rdi
ffff80000010bdff:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010be06:	80 ff ff 
ffff80000010be09:	ff d0                	call   *%rax

  // then need to loop through pml4 entry
  for(i = 0; i < (NPDENTRIES/2); i++){
ffff80000010be0b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010be12:	e9 dc 01 00 00       	jmp    ffff80000010bff3 <freevm+0x218>
    if(pml4[i] & PTE_P){
ffff80000010be17:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010be1a:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010be21:	00 
ffff80000010be22:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010be26:	48 01 d0             	add    %rdx,%rax
ffff80000010be29:	48 8b 00             	mov    (%rax),%rax
ffff80000010be2c:	83 e0 01             	and    $0x1,%eax
ffff80000010be2f:	48 85 c0             	test   %rax,%rax
ffff80000010be32:	0f 84 b7 01 00 00    	je     ffff80000010bfef <freevm+0x214>
      pdp = (pdpe_t*)P2V(PTE_ADDR(pml4[i]));
ffff80000010be38:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010be3b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010be42:	00 
ffff80000010be43:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010be47:	48 01 d0             	add    %rdx,%rax
ffff80000010be4a:	48 8b 00             	mov    (%rax),%rax
ffff80000010be4d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010be53:	48 89 c2             	mov    %rax,%rdx
ffff80000010be56:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010be5d:	80 ff ff 
ffff80000010be60:	48 01 d0             	add    %rdx,%rax
ffff80000010be63:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

      // and every entry in the corresponding pdpt
      for(j = 0; j < NPDENTRIES; j++){
ffff80000010be67:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
ffff80000010be6e:	e9 5c 01 00 00       	jmp    ffff80000010bfcf <freevm+0x1f4>
        if(pdp[j] & PTE_P){
ffff80000010be73:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff80000010be76:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010be7d:	00 
ffff80000010be7e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010be82:	48 01 d0             	add    %rdx,%rax
ffff80000010be85:	48 8b 00             	mov    (%rax),%rax
ffff80000010be88:	83 e0 01             	and    $0x1,%eax
ffff80000010be8b:	48 85 c0             	test   %rax,%rax
ffff80000010be8e:	0f 84 37 01 00 00    	je     ffff80000010bfcb <freevm+0x1f0>
          pd = (pde_t*)P2V(PTE_ADDR(pdp[j]));
ffff80000010be94:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff80000010be97:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010be9e:	00 
ffff80000010be9f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bea3:	48 01 d0             	add    %rdx,%rax
ffff80000010bea6:	48 8b 00             	mov    (%rax),%rax
ffff80000010bea9:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010beaf:	48 89 c2             	mov    %rax,%rdx
ffff80000010beb2:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010beb9:	80 ff ff 
ffff80000010bebc:	48 01 d0             	add    %rdx,%rax
ffff80000010bebf:	48 89 45 e0          	mov    %rax,-0x20(%rbp)

          // and every entry in the corresponding page directory
          for(k = 0; k < (NPDENTRIES); k++){
ffff80000010bec3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
ffff80000010beca:	e9 dc 00 00 00       	jmp    ffff80000010bfab <freevm+0x1d0>
            if(pd[k] & PTE_P) {
ffff80000010becf:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff80000010bed2:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010bed9:	00 
ffff80000010beda:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010bede:	48 01 d0             	add    %rdx,%rax
ffff80000010bee1:	48 8b 00             	mov    (%rax),%rax
ffff80000010bee4:	83 e0 01             	and    $0x1,%eax
ffff80000010bee7:	48 85 c0             	test   %rax,%rax
ffff80000010beea:	0f 84 b7 00 00 00    	je     ffff80000010bfa7 <freevm+0x1cc>
              pt = (pde_t*)P2V(PTE_ADDR(pd[k]));
ffff80000010bef0:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff80000010bef3:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010befa:	00 
ffff80000010befb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010beff:	48 01 d0             	add    %rdx,%rax
ffff80000010bf02:	48 8b 00             	mov    (%rax),%rax
ffff80000010bf05:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010bf0b:	48 89 c2             	mov    %rax,%rdx
ffff80000010bf0e:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010bf15:	80 ff ff 
ffff80000010bf18:	48 01 d0             	add    %rdx,%rax
ffff80000010bf1b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

              // and every entry in the corresponding page table
              for(l = 0; l < (NPDENTRIES); l++){
ffff80000010bf1f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
ffff80000010bf26:	eb 63                	jmp    ffff80000010bf8b <freevm+0x1b0>
                if(pt[l] & PTE_P) {
ffff80000010bf28:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff80000010bf2b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010bf32:	00 
ffff80000010bf33:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010bf37:	48 01 d0             	add    %rdx,%rax
ffff80000010bf3a:	48 8b 00             	mov    (%rax),%rax
ffff80000010bf3d:	83 e0 01             	and    $0x1,%eax
ffff80000010bf40:	48 85 c0             	test   %rax,%rax
ffff80000010bf43:	74 42                	je     ffff80000010bf87 <freevm+0x1ac>
                  char * v = P2V(PTE_ADDR(pt[l]));
ffff80000010bf45:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff80000010bf48:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010bf4f:	00 
ffff80000010bf50:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010bf54:	48 01 d0             	add    %rdx,%rax
ffff80000010bf57:	48 8b 00             	mov    (%rax),%rax
ffff80000010bf5a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010bf60:	48 89 c2             	mov    %rax,%rdx
ffff80000010bf63:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010bf6a:	80 ff ff 
ffff80000010bf6d:	48 01 d0             	add    %rdx,%rax
ffff80000010bf70:	48 89 45 d0          	mov    %rax,-0x30(%rbp)

                  kfree((char*)v);
ffff80000010bf74:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010bf78:	48 89 c7             	mov    %rax,%rdi
ffff80000010bf7b:	48 b8 fd 41 10 00 00 	movabs $0xffff8000001041fd,%rax
ffff80000010bf82:	80 ff ff 
ffff80000010bf85:	ff d0                	call   *%rax
              for(l = 0; l < (NPDENTRIES); l++){
ffff80000010bf87:	83 45 f0 01          	addl   $0x1,-0x10(%rbp)
ffff80000010bf8b:	81 7d f0 ff 01 00 00 	cmpl   $0x1ff,-0x10(%rbp)
ffff80000010bf92:	76 94                	jbe    ffff80000010bf28 <freevm+0x14d>
                }
              }
              //freeing every page table
              kfree((char*)pt);
ffff80000010bf94:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010bf98:	48 89 c7             	mov    %rax,%rdi
ffff80000010bf9b:	48 b8 fd 41 10 00 00 	movabs $0xffff8000001041fd,%rax
ffff80000010bfa2:	80 ff ff 
ffff80000010bfa5:	ff d0                	call   *%rax
          for(k = 0; k < (NPDENTRIES); k++){
ffff80000010bfa7:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
ffff80000010bfab:	81 7d f4 ff 01 00 00 	cmpl   $0x1ff,-0xc(%rbp)
ffff80000010bfb2:	0f 86 17 ff ff ff    	jbe    ffff80000010becf <freevm+0xf4>
            }
          }
          // freeing every page directory
          kfree((char*)pd);
ffff80000010bfb8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010bfbc:	48 89 c7             	mov    %rax,%rdi
ffff80000010bfbf:	48 b8 fd 41 10 00 00 	movabs $0xffff8000001041fd,%rax
ffff80000010bfc6:	80 ff ff 
ffff80000010bfc9:	ff d0                	call   *%rax
      for(j = 0; j < NPDENTRIES; j++){
ffff80000010bfcb:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
ffff80000010bfcf:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
ffff80000010bfd6:	0f 86 97 fe ff ff    	jbe    ffff80000010be73 <freevm+0x98>
        }
      }
      // freeing every page directory pointer table
      kfree((char*)pdp);
ffff80000010bfdc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bfe0:	48 89 c7             	mov    %rax,%rdi
ffff80000010bfe3:	48 b8 fd 41 10 00 00 	movabs $0xffff8000001041fd,%rax
ffff80000010bfea:	80 ff ff 
ffff80000010bfed:	ff d0                	call   *%rax
  for(i = 0; i < (NPDENTRIES/2); i++){
ffff80000010bfef:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff80000010bff3:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
ffff80000010bffa:	0f 86 17 fe ff ff    	jbe    ffff80000010be17 <freevm+0x3c>
    }
  }
  // freeing the pml4
  kfree((char*)pml4);
ffff80000010c000:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010c004:	48 89 c7             	mov    %rax,%rdi
ffff80000010c007:	48 b8 fd 41 10 00 00 	movabs $0xffff8000001041fd,%rax
ffff80000010c00e:	80 ff ff 
ffff80000010c011:	ff d0                	call   *%rax
}
ffff80000010c013:	90                   	nop
ffff80000010c014:	c9                   	leave
ffff80000010c015:	c3                   	ret

ffff80000010c016 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pml4e_t *pgdir, char *uva)
{
ffff80000010c016:	f3 0f 1e fa          	endbr64
ffff80000010c01a:	55                   	push   %rbp
ffff80000010c01b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010c01e:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010c022:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010c026:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
ffff80000010c02a:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff80000010c02e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c032:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010c037:	48 89 ce             	mov    %rcx,%rsi
ffff80000010c03a:	48 89 c7             	mov    %rax,%rdi
ffff80000010c03d:	48 b8 48 b6 10 00 00 	movabs $0xffff80000010b648,%rax
ffff80000010c044:	80 ff ff 
ffff80000010c047:	ff d0                	call   *%rax
ffff80000010c049:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(pte == 0)
ffff80000010c04d:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff80000010c052:	75 19                	jne    ffff80000010c06d <clearpteu+0x57>
    panic("clearpteu");
ffff80000010c054:	48 b8 a8 cb 10 00 00 	movabs $0xffff80000010cba8,%rax
ffff80000010c05b:	80 ff ff 
ffff80000010c05e:	48 89 c7             	mov    %rax,%rdi
ffff80000010c061:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010c068:	80 ff ff 
ffff80000010c06b:	ff d0                	call   *%rax
  *pte &= ~PTE_U;
ffff80000010c06d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c071:	48 8b 00             	mov    (%rax),%rax
ffff80000010c074:	48 83 e0 fb          	and    $0xfffffffffffffffb,%rax
ffff80000010c078:	48 89 c2             	mov    %rax,%rdx
ffff80000010c07b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c07f:	48 89 10             	mov    %rdx,(%rax)
}
ffff80000010c082:	90                   	nop
ffff80000010c083:	c9                   	leave
ffff80000010c084:	c3                   	ret

ffff80000010c085 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pml4e_t *pgdir, uint sz)
{
ffff80000010c085:	f3 0f 1e fa          	endbr64
ffff80000010c089:	55                   	push   %rbp
ffff80000010c08a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010c08d:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010c091:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
ffff80000010c095:	89 75 c4             	mov    %esi,-0x3c(%rbp)
  pde_t *d;
  pte_t *pte;
  addr_t pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
ffff80000010c098:	48 b8 1f b4 10 00 00 	movabs $0xffff80000010b41f,%rax
ffff80000010c09f:	80 ff ff 
ffff80000010c0a2:	ff d0                	call   *%rax
ffff80000010c0a4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010c0a8:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010c0ad:	75 0a                	jne    ffff80000010c0b9 <copyuvm+0x34>
    return 0;
ffff80000010c0af:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010c0b4:	e9 57 01 00 00       	jmp    ffff80000010c210 <copyuvm+0x18b>
  for(i = PGSIZE; i < sz; i += PGSIZE){
ffff80000010c0b9:	48 c7 45 f8 00 10 00 	movq   $0x1000,-0x8(%rbp)
ffff80000010c0c0:	00 
ffff80000010c0c1:	e9 1b 01 00 00       	jmp    ffff80000010c1e1 <copyuvm+0x15c>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
ffff80000010c0c6:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff80000010c0ca:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010c0ce:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010c0d3:	48 89 ce             	mov    %rcx,%rsi
ffff80000010c0d6:	48 89 c7             	mov    %rax,%rdi
ffff80000010c0d9:	48 b8 48 b6 10 00 00 	movabs $0xffff80000010b648,%rax
ffff80000010c0e0:	80 ff ff 
ffff80000010c0e3:	ff d0                	call   *%rax
ffff80000010c0e5:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010c0e9:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010c0ee:	75 19                	jne    ffff80000010c109 <copyuvm+0x84>
      panic("copyuvm: pte should exist");
ffff80000010c0f0:	48 b8 b2 cb 10 00 00 	movabs $0xffff80000010cbb2,%rax
ffff80000010c0f7:	80 ff ff 
ffff80000010c0fa:	48 89 c7             	mov    %rax,%rdi
ffff80000010c0fd:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010c104:	80 ff ff 
ffff80000010c107:	ff d0                	call   *%rax
    if(!(*pte & PTE_P))
ffff80000010c109:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c10d:	48 8b 00             	mov    (%rax),%rax
ffff80000010c110:	83 e0 01             	and    $0x1,%eax
ffff80000010c113:	48 85 c0             	test   %rax,%rax
ffff80000010c116:	75 19                	jne    ffff80000010c131 <copyuvm+0xac>
      panic("copyuvm: page not present");
ffff80000010c118:	48 b8 cc cb 10 00 00 	movabs $0xffff80000010cbcc,%rax
ffff80000010c11f:	80 ff ff 
ffff80000010c122:	48 89 c7             	mov    %rax,%rdi
ffff80000010c125:	48 b8 22 0c 10 00 00 	movabs $0xffff800000100c22,%rax
ffff80000010c12c:	80 ff ff 
ffff80000010c12f:	ff d0                	call   *%rax
    pa = PTE_ADDR(*pte);
ffff80000010c131:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c135:	48 8b 00             	mov    (%rax),%rax
ffff80000010c138:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010c13e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    flags = PTE_FLAGS(*pte);
ffff80000010c142:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c146:	48 8b 00             	mov    (%rax),%rax
ffff80000010c149:	25 ff 0f 00 00       	and    $0xfff,%eax
ffff80000010c14e:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    if((mem = kalloc()) == 0)
ffff80000010c152:	48 b8 00 43 10 00 00 	movabs $0xffff800000104300,%rax
ffff80000010c159:	80 ff ff 
ffff80000010c15c:	ff d0                	call   *%rax
ffff80000010c15e:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
ffff80000010c162:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
ffff80000010c167:	0f 84 87 00 00 00    	je     ffff80000010c1f4 <copyuvm+0x16f>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
ffff80000010c16d:	48 ba 00 00 00 00 00 	movabs $0xffff800000000000,%rdx
ffff80000010c174:	80 ff ff 
ffff80000010c177:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010c17b:	48 01 d0             	add    %rdx,%rax
ffff80000010c17e:	48 89 c1             	mov    %rax,%rcx
ffff80000010c181:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010c185:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010c18a:	48 89 ce             	mov    %rcx,%rsi
ffff80000010c18d:	48 89 c7             	mov    %rax,%rdi
ffff80000010c190:	48 b8 94 7e 10 00 00 	movabs $0xffff800000107e94,%rax
ffff80000010c197:	80 ff ff 
ffff80000010c19a:	ff d0                	call   *%rax
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
ffff80000010c19c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010c1a0:	89 c1                	mov    %eax,%ecx
ffff80000010c1a2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010c1a6:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010c1ad:	80 00 00 
ffff80000010c1b0:	48 01 c2             	add    %rax,%rdx
ffff80000010c1b3:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
ffff80000010c1b7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c1bb:	41 89 c8             	mov    %ecx,%r8d
ffff80000010c1be:	48 89 d1             	mov    %rdx,%rcx
ffff80000010c1c1:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010c1c6:	48 89 c7             	mov    %rax,%rdi
ffff80000010c1c9:	48 b8 cf b8 10 00 00 	movabs $0xffff80000010b8cf,%rax
ffff80000010c1d0:	80 ff ff 
ffff80000010c1d3:	ff d0                	call   *%rax
ffff80000010c1d5:	85 c0                	test   %eax,%eax
ffff80000010c1d7:	78 1e                	js     ffff80000010c1f7 <copyuvm+0x172>
  for(i = PGSIZE; i < sz; i += PGSIZE){
ffff80000010c1d9:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffff80000010c1e0:	00 
ffff80000010c1e1:	8b 45 c4             	mov    -0x3c(%rbp),%eax
ffff80000010c1e4:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff80000010c1e8:	0f 82 d8 fe ff ff    	jb     ffff80000010c0c6 <copyuvm+0x41>
      goto bad;
  }
  return d;
ffff80000010c1ee:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c1f2:	eb 1c                	jmp    ffff80000010c210 <copyuvm+0x18b>
      goto bad;
ffff80000010c1f4:	90                   	nop
ffff80000010c1f5:	eb 01                	jmp    ffff80000010c1f8 <copyuvm+0x173>
      goto bad;
ffff80000010c1f7:	90                   	nop

bad:
  freevm(d);
ffff80000010c1f8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c1fc:	48 89 c7             	mov    %rax,%rdi
ffff80000010c1ff:	48 b8 db bd 10 00 00 	movabs $0xffff80000010bddb,%rax
ffff80000010c206:	80 ff ff 
ffff80000010c209:	ff d0                	call   *%rax
  return 0;
ffff80000010c20b:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010c210:	c9                   	leave
ffff80000010c211:	c3                   	ret

ffff80000010c212 <uva2ka>:

// Map user virtual address to kernel address.
char*
uva2ka(pml4e_t *pgdir, char *uva)
{
ffff80000010c212:	f3 0f 1e fa          	endbr64
ffff80000010c216:	55                   	push   %rbp
ffff80000010c217:	48 89 e5             	mov    %rsp,%rbp
ffff80000010c21a:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010c21e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010c222:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
ffff80000010c226:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff80000010c22a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c22e:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010c233:	48 89 ce             	mov    %rcx,%rsi
ffff80000010c236:	48 89 c7             	mov    %rax,%rdi
ffff80000010c239:	48 b8 48 b6 10 00 00 	movabs $0xffff80000010b648,%rax
ffff80000010c240:	80 ff ff 
ffff80000010c243:	ff d0                	call   *%rax
ffff80000010c245:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if((*pte & PTE_P) == 0)
ffff80000010c249:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c24d:	48 8b 00             	mov    (%rax),%rax
ffff80000010c250:	83 e0 01             	and    $0x1,%eax
ffff80000010c253:	48 85 c0             	test   %rax,%rax
ffff80000010c256:	75 07                	jne    ffff80000010c25f <uva2ka+0x4d>
    return 0;
ffff80000010c258:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010c25d:	eb 33                	jmp    ffff80000010c292 <uva2ka+0x80>
  if((*pte & PTE_U) == 0)
ffff80000010c25f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c263:	48 8b 00             	mov    (%rax),%rax
ffff80000010c266:	83 e0 04             	and    $0x4,%eax
ffff80000010c269:	48 85 c0             	test   %rax,%rax
ffff80000010c26c:	75 07                	jne    ffff80000010c275 <uva2ka+0x63>
    return 0;
ffff80000010c26e:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010c273:	eb 1d                	jmp    ffff80000010c292 <uva2ka+0x80>
  return (char*)P2V(PTE_ADDR(*pte));
ffff80000010c275:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c279:	48 8b 00             	mov    (%rax),%rax
ffff80000010c27c:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010c282:	48 89 c2             	mov    %rax,%rdx
ffff80000010c285:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010c28c:	80 ff ff 
ffff80000010c28f:	48 01 d0             	add    %rdx,%rax
}
ffff80000010c292:	c9                   	leave
ffff80000010c293:	c3                   	ret

ffff80000010c294 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pml4e_t *pgdir, addr_t va, void *p, uint64 len)
{
ffff80000010c294:	f3 0f 1e fa          	endbr64
ffff80000010c298:	55                   	push   %rbp
ffff80000010c299:	48 89 e5             	mov    %rsp,%rbp
ffff80000010c29c:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010c2a0:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010c2a4:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010c2a8:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
ffff80000010c2ac:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
  char *buf, *pa0;
  addr_t n, va0;

  buf = (char*)p;
ffff80000010c2b0:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010c2b4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while(len > 0){
ffff80000010c2b8:	e9 b0 00 00 00       	jmp    ffff80000010c36d <copyout+0xd9>
    va0 = PGROUNDDOWN(va);
ffff80000010c2bd:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010c2c1:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010c2c7:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    pa0 = uva2ka(pgdir, (char*)va0);
ffff80000010c2cb:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff80000010c2cf:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010c2d3:	48 89 d6             	mov    %rdx,%rsi
ffff80000010c2d6:	48 89 c7             	mov    %rax,%rdi
ffff80000010c2d9:	48 b8 12 c2 10 00 00 	movabs $0xffff80000010c212,%rax
ffff80000010c2e0:	80 ff ff 
ffff80000010c2e3:	ff d0                	call   *%rax
ffff80000010c2e5:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    if(pa0 == 0)
ffff80000010c2e9:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
ffff80000010c2ee:	75 0a                	jne    ffff80000010c2fa <copyout+0x66>
      return -1;
ffff80000010c2f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010c2f5:	e9 83 00 00 00       	jmp    ffff80000010c37d <copyout+0xe9>
    n = PGSIZE - (va - va0);
ffff80000010c2fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c2fe:	48 2b 45 d0          	sub    -0x30(%rbp),%rax
ffff80000010c302:	48 05 00 10 00 00    	add    $0x1000,%rax
ffff80000010c308:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if(n > len)
ffff80000010c30c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c310:	48 39 45 c0          	cmp    %rax,-0x40(%rbp)
ffff80000010c314:	73 08                	jae    ffff80000010c31e <copyout+0x8a>
      n = len;
ffff80000010c316:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010c31a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    memmove(pa0 + (va - va0), buf, n);
ffff80000010c31e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c322:	89 c6                	mov    %eax,%esi
ffff80000010c324:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010c328:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
ffff80000010c32c:	48 89 c2             	mov    %rax,%rdx
ffff80000010c32f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010c333:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffff80000010c337:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c33b:	89 f2                	mov    %esi,%edx
ffff80000010c33d:	48 89 c6             	mov    %rax,%rsi
ffff80000010c340:	48 89 cf             	mov    %rcx,%rdi
ffff80000010c343:	48 b8 94 7e 10 00 00 	movabs $0xffff800000107e94,%rax
ffff80000010c34a:	80 ff ff 
ffff80000010c34d:	ff d0                	call   *%rax
    len -= n;
ffff80000010c34f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c353:	48 29 45 c0          	sub    %rax,-0x40(%rbp)
    buf += n;
ffff80000010c357:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c35b:	48 01 45 f8          	add    %rax,-0x8(%rbp)
    va = va0 + PGSIZE;
ffff80000010c35f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c363:	48 05 00 10 00 00    	add    $0x1000,%rax
ffff80000010c369:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  while(len > 0){
ffff80000010c36d:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
ffff80000010c372:	0f 85 45 ff ff ff    	jne    ffff80000010c2bd <copyout+0x29>
  }
  return 0;
ffff80000010c378:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010c37d:	c9                   	leave
ffff80000010c37e:	c3                   	ret

ffff80000010c37f <copyin>:


int
copyin(pml4e_t *pgdir, void *dst, addr_t srcva, uint64 len)
{
ffff80000010c37f:	f3 0f 1e fa          	endbr64
ffff80000010c383:	55                   	push   %rbp
ffff80000010c384:	48 89 e5             	mov    %rsp,%rbp
ffff80000010c387:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010c38b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010c38f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff80000010c393:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
ffff80000010c397:	48 89 4d d0          	mov    %rcx,-0x30(%rbp)
    char *pa0;
    uint n, va0;

    while(len > 0){
ffff80000010c39b:	e9 9d 00 00 00       	jmp    ffff80000010c43d <copyin+0xbe>
        // Round down to the start of the page containing srcva
        va0 = (uint)PGROUNDDOWN(srcva);
ffff80000010c3a0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010c3a4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
ffff80000010c3a9:	89 45 f8             	mov    %eax,-0x8(%rbp)

        // Translate that user page to a kernel-accessible address
        pa0 = uva2ka(pgdir, (char*)va0);
ffff80000010c3ac:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff80000010c3af:	48 89 c2             	mov    %rax,%rdx
ffff80000010c3b2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c3b6:	48 89 d6             	mov    %rdx,%rsi
ffff80000010c3b9:	48 89 c7             	mov    %rax,%rdi
ffff80000010c3bc:	48 b8 12 c2 10 00 00 	movabs $0xffff80000010c212,%rax
ffff80000010c3c3:	80 ff ff 
ffff80000010c3c6:	ff d0                	call   *%rax
ffff80000010c3c8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        if(pa0 == 0)
ffff80000010c3cc:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010c3d1:	75 07                	jne    ffff80000010c3da <copyin+0x5b>
            return -1;   // page doesn't exist or not user-accessible
ffff80000010c3d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010c3d8:	eb 73                	jmp    ffff80000010c44d <copyin+0xce>

        // How many bytes can we copy from this page without crossing into the next?
        n = PGSIZE - (srcva - va0);
ffff80000010c3da:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010c3de:	89 c2                	mov    %eax,%edx
ffff80000010c3e0:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff80000010c3e3:	29 d0                	sub    %edx,%eax
ffff80000010c3e5:	05 00 10 00 00       	add    $0x1000,%eax
ffff80000010c3ea:	89 45 fc             	mov    %eax,-0x4(%rbp)
        if(n > len)
ffff80000010c3ed:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010c3f0:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
ffff80000010c3f4:	73 07                	jae    ffff80000010c3fd <copyin+0x7e>
            n = len;
ffff80000010c3f6:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010c3fa:	89 45 fc             	mov    %eax,-0x4(%rbp)

        // pa0 is the start of the page; offset into it by (srcva - va0)
        memmove(dst, pa0 + (srcva - va0), n);
ffff80000010c3fd:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff80000010c400:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010c404:	48 29 c2             	sub    %rax,%rdx
ffff80000010c407:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c40b:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffff80000010c40f:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010c412:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010c416:	48 89 ce             	mov    %rcx,%rsi
ffff80000010c419:	48 89 c7             	mov    %rax,%rdi
ffff80000010c41c:	48 b8 94 7e 10 00 00 	movabs $0xffff800000107e94,%rax
ffff80000010c423:	80 ff ff 
ffff80000010c426:	ff d0                	call   *%rax

        len   -= n;
ffff80000010c428:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010c42b:	48 29 45 d0          	sub    %rax,-0x30(%rbp)
        dst   += n;
ffff80000010c42f:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010c432:	48 01 45 e0          	add    %rax,-0x20(%rbp)
        srcva += n;    // advance to next page if len still > 0
ffff80000010c436:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010c439:	48 01 45 d8          	add    %rax,-0x28(%rbp)
    while(len > 0){
ffff80000010c43d:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
ffff80000010c442:	0f 85 58 ff ff ff    	jne    ffff80000010c3a0 <copyin+0x21>
    }
    return 0;
ffff80000010c448:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010c44d:	c9                   	leave
ffff80000010c44e:	c3                   	ret
