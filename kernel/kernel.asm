
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0001e117          	auipc	sp,0x1e
    80000004:	14010113          	add	sp,sp,320 # 8001e140 <stack0>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	add	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	5ba050ef          	jal	800055d0 <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    8000001c:	1101                	add	sp,sp,-32
    8000001e:	ec06                	sd	ra,24(sp)
    80000020:	e822                	sd	s0,16(sp)
    80000022:	e426                	sd	s1,8(sp)
    80000024:	e04a                	sd	s2,0(sp)
    80000026:	1000                	add	s0,sp,32
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    80000028:	03451793          	sll	a5,a0,0x34
    8000002c:	ebb9                	bnez	a5,80000082 <kfree+0x66>
    8000002e:	84aa                	mv	s1,a0
    80000030:	00026797          	auipc	a5,0x26
    80000034:	21078793          	add	a5,a5,528 # 80026240 <end>
    80000038:	04f56563          	bltu	a0,a5,80000082 <kfree+0x66>
    8000003c:	47c5                	li	a5,17
    8000003e:	07ee                	sll	a5,a5,0x1b
    80000040:	04f57163          	bgeu	a0,a5,80000082 <kfree+0x66>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    80000044:	6605                	lui	a2,0x1
    80000046:	4585                	li	a1,1
    80000048:	00000097          	auipc	ra,0x0
    8000004c:	132080e7          	jalr	306(ra) # 8000017a <memset>

  r = (struct run*)pa;

  acquire(&kmem.lock);
    80000050:	00009917          	auipc	s2,0x9
    80000054:	fe090913          	add	s2,s2,-32 # 80009030 <kmem>
    80000058:	854a                	mv	a0,s2
    8000005a:	00006097          	auipc	ra,0x6
    8000005e:	f58080e7          	jalr	-168(ra) # 80005fb2 <acquire>
  r->next = kmem.freelist;
    80000062:	01893783          	ld	a5,24(s2)
    80000066:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80000068:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    8000006c:	854a                	mv	a0,s2
    8000006e:	00006097          	auipc	ra,0x6
    80000072:	ff8080e7          	jalr	-8(ra) # 80006066 <release>
}
    80000076:	60e2                	ld	ra,24(sp)
    80000078:	6442                	ld	s0,16(sp)
    8000007a:	64a2                	ld	s1,8(sp)
    8000007c:	6902                	ld	s2,0(sp)
    8000007e:	6105                	add	sp,sp,32
    80000080:	8082                	ret
    panic("kfree");
    80000082:	00008517          	auipc	a0,0x8
    80000086:	f8e50513          	add	a0,a0,-114 # 80008010 <etext+0x10>
    8000008a:	00006097          	auipc	ra,0x6
    8000008e:	9f0080e7          	jalr	-1552(ra) # 80005a7a <panic>

0000000080000092 <freerange>:
{
    80000092:	7179                	add	sp,sp,-48
    80000094:	f406                	sd	ra,40(sp)
    80000096:	f022                	sd	s0,32(sp)
    80000098:	ec26                	sd	s1,24(sp)
    8000009a:	e84a                	sd	s2,16(sp)
    8000009c:	e44e                	sd	s3,8(sp)
    8000009e:	e052                	sd	s4,0(sp)
    800000a0:	1800                	add	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    800000a2:	6785                	lui	a5,0x1
    800000a4:	fff78713          	add	a4,a5,-1 # fff <_entry-0x7ffff001>
    800000a8:	00e504b3          	add	s1,a0,a4
    800000ac:	777d                	lui	a4,0xfffff
    800000ae:	8cf9                	and	s1,s1,a4
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000b0:	94be                	add	s1,s1,a5
    800000b2:	0095ee63          	bltu	a1,s1,800000ce <freerange+0x3c>
    800000b6:	892e                	mv	s2,a1
    kfree(p);
    800000b8:	7a7d                	lui	s4,0xfffff
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000ba:	6985                	lui	s3,0x1
    kfree(p);
    800000bc:	01448533          	add	a0,s1,s4
    800000c0:	00000097          	auipc	ra,0x0
    800000c4:	f5c080e7          	jalr	-164(ra) # 8000001c <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000c8:	94ce                	add	s1,s1,s3
    800000ca:	fe9979e3          	bgeu	s2,s1,800000bc <freerange+0x2a>
}
    800000ce:	70a2                	ld	ra,40(sp)
    800000d0:	7402                	ld	s0,32(sp)
    800000d2:	64e2                	ld	s1,24(sp)
    800000d4:	6942                	ld	s2,16(sp)
    800000d6:	69a2                	ld	s3,8(sp)
    800000d8:	6a02                	ld	s4,0(sp)
    800000da:	6145                	add	sp,sp,48
    800000dc:	8082                	ret

00000000800000de <kinit>:
{
    800000de:	1141                	add	sp,sp,-16
    800000e0:	e406                	sd	ra,8(sp)
    800000e2:	e022                	sd	s0,0(sp)
    800000e4:	0800                	add	s0,sp,16
  initlock(&kmem.lock, "kmem");
    800000e6:	00008597          	auipc	a1,0x8
    800000ea:	f3258593          	add	a1,a1,-206 # 80008018 <etext+0x18>
    800000ee:	00009517          	auipc	a0,0x9
    800000f2:	f4250513          	add	a0,a0,-190 # 80009030 <kmem>
    800000f6:	00006097          	auipc	ra,0x6
    800000fa:	e2c080e7          	jalr	-468(ra) # 80005f22 <initlock>
  freerange(end, (void*)PHYSTOP);
    800000fe:	45c5                	li	a1,17
    80000100:	05ee                	sll	a1,a1,0x1b
    80000102:	00026517          	auipc	a0,0x26
    80000106:	13e50513          	add	a0,a0,318 # 80026240 <end>
    8000010a:	00000097          	auipc	ra,0x0
    8000010e:	f88080e7          	jalr	-120(ra) # 80000092 <freerange>
}
    80000112:	60a2                	ld	ra,8(sp)
    80000114:	6402                	ld	s0,0(sp)
    80000116:	0141                	add	sp,sp,16
    80000118:	8082                	ret

000000008000011a <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    8000011a:	1101                	add	sp,sp,-32
    8000011c:	ec06                	sd	ra,24(sp)
    8000011e:	e822                	sd	s0,16(sp)
    80000120:	e426                	sd	s1,8(sp)
    80000122:	1000                	add	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80000124:	00009497          	auipc	s1,0x9
    80000128:	f0c48493          	add	s1,s1,-244 # 80009030 <kmem>
    8000012c:	8526                	mv	a0,s1
    8000012e:	00006097          	auipc	ra,0x6
    80000132:	e84080e7          	jalr	-380(ra) # 80005fb2 <acquire>
  r = kmem.freelist;
    80000136:	6c84                	ld	s1,24(s1)
  if(r)
    80000138:	c885                	beqz	s1,80000168 <kalloc+0x4e>
    kmem.freelist = r->next;
    8000013a:	609c                	ld	a5,0(s1)
    8000013c:	00009517          	auipc	a0,0x9
    80000140:	ef450513          	add	a0,a0,-268 # 80009030 <kmem>
    80000144:	ed1c                	sd	a5,24(a0)
  release(&kmem.lock);
    80000146:	00006097          	auipc	ra,0x6
    8000014a:	f20080e7          	jalr	-224(ra) # 80006066 <release>

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
    8000014e:	6605                	lui	a2,0x1
    80000150:	4595                	li	a1,5
    80000152:	8526                	mv	a0,s1
    80000154:	00000097          	auipc	ra,0x0
    80000158:	026080e7          	jalr	38(ra) # 8000017a <memset>
  return (void*)r;
}
    8000015c:	8526                	mv	a0,s1
    8000015e:	60e2                	ld	ra,24(sp)
    80000160:	6442                	ld	s0,16(sp)
    80000162:	64a2                	ld	s1,8(sp)
    80000164:	6105                	add	sp,sp,32
    80000166:	8082                	ret
  release(&kmem.lock);
    80000168:	00009517          	auipc	a0,0x9
    8000016c:	ec850513          	add	a0,a0,-312 # 80009030 <kmem>
    80000170:	00006097          	auipc	ra,0x6
    80000174:	ef6080e7          	jalr	-266(ra) # 80006066 <release>
  if(r)
    80000178:	b7d5                	j	8000015c <kalloc+0x42>

000000008000017a <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    8000017a:	1141                	add	sp,sp,-16
    8000017c:	e422                	sd	s0,8(sp)
    8000017e:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    80000180:	ca19                	beqz	a2,80000196 <memset+0x1c>
    80000182:	87aa                	mv	a5,a0
    80000184:	1602                	sll	a2,a2,0x20
    80000186:	9201                	srl	a2,a2,0x20
    80000188:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    8000018c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    80000190:	0785                	add	a5,a5,1
    80000192:	fee79de3          	bne	a5,a4,8000018c <memset+0x12>
  }
  return dst;
}
    80000196:	6422                	ld	s0,8(sp)
    80000198:	0141                	add	sp,sp,16
    8000019a:	8082                	ret

000000008000019c <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    8000019c:	1141                	add	sp,sp,-16
    8000019e:	e422                	sd	s0,8(sp)
    800001a0:	0800                	add	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    800001a2:	ca05                	beqz	a2,800001d2 <memcmp+0x36>
    800001a4:	fff6069b          	addw	a3,a2,-1 # fff <_entry-0x7ffff001>
    800001a8:	1682                	sll	a3,a3,0x20
    800001aa:	9281                	srl	a3,a3,0x20
    800001ac:	0685                	add	a3,a3,1
    800001ae:	96aa                	add	a3,a3,a0
    if(*s1 != *s2)
    800001b0:	00054783          	lbu	a5,0(a0)
    800001b4:	0005c703          	lbu	a4,0(a1)
    800001b8:	00e79863          	bne	a5,a4,800001c8 <memcmp+0x2c>
      return *s1 - *s2;
    s1++, s2++;
    800001bc:	0505                	add	a0,a0,1
    800001be:	0585                	add	a1,a1,1
  while(n-- > 0){
    800001c0:	fed518e3          	bne	a0,a3,800001b0 <memcmp+0x14>
  }

  return 0;
    800001c4:	4501                	li	a0,0
    800001c6:	a019                	j	800001cc <memcmp+0x30>
      return *s1 - *s2;
    800001c8:	40e7853b          	subw	a0,a5,a4
}
    800001cc:	6422                	ld	s0,8(sp)
    800001ce:	0141                	add	sp,sp,16
    800001d0:	8082                	ret
  return 0;
    800001d2:	4501                	li	a0,0
    800001d4:	bfe5                	j	800001cc <memcmp+0x30>

00000000800001d6 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    800001d6:	1141                	add	sp,sp,-16
    800001d8:	e422                	sd	s0,8(sp)
    800001da:	0800                	add	s0,sp,16
  const char *s;
  char *d;

  if(n == 0)
    800001dc:	c205                	beqz	a2,800001fc <memmove+0x26>
    return dst;
  
  s = src;
  d = dst;
  if(s < d && s + n > d){
    800001de:	02a5e263          	bltu	a1,a0,80000202 <memmove+0x2c>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    800001e2:	1602                	sll	a2,a2,0x20
    800001e4:	9201                	srl	a2,a2,0x20
    800001e6:	00c587b3          	add	a5,a1,a2
{
    800001ea:	872a                	mv	a4,a0
      *d++ = *s++;
    800001ec:	0585                	add	a1,a1,1
    800001ee:	0705                	add	a4,a4,1 # fffffffffffff001 <end+0xffffffff7ffd8dc1>
    800001f0:	fff5c683          	lbu	a3,-1(a1)
    800001f4:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    800001f8:	fef59ae3          	bne	a1,a5,800001ec <memmove+0x16>

  return dst;
}
    800001fc:	6422                	ld	s0,8(sp)
    800001fe:	0141                	add	sp,sp,16
    80000200:	8082                	ret
  if(s < d && s + n > d){
    80000202:	02061693          	sll	a3,a2,0x20
    80000206:	9281                	srl	a3,a3,0x20
    80000208:	00d58733          	add	a4,a1,a3
    8000020c:	fce57be3          	bgeu	a0,a4,800001e2 <memmove+0xc>
    d += n;
    80000210:	96aa                	add	a3,a3,a0
    while(n-- > 0)
    80000212:	fff6079b          	addw	a5,a2,-1
    80000216:	1782                	sll	a5,a5,0x20
    80000218:	9381                	srl	a5,a5,0x20
    8000021a:	fff7c793          	not	a5,a5
    8000021e:	97ba                	add	a5,a5,a4
      *--d = *--s;
    80000220:	177d                	add	a4,a4,-1
    80000222:	16fd                	add	a3,a3,-1
    80000224:	00074603          	lbu	a2,0(a4)
    80000228:	00c68023          	sb	a2,0(a3)
    while(n-- > 0)
    8000022c:	fee79ae3          	bne	a5,a4,80000220 <memmove+0x4a>
    80000230:	b7f1                	j	800001fc <memmove+0x26>

0000000080000232 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    80000232:	1141                	add	sp,sp,-16
    80000234:	e406                	sd	ra,8(sp)
    80000236:	e022                	sd	s0,0(sp)
    80000238:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
    8000023a:	00000097          	auipc	ra,0x0
    8000023e:	f9c080e7          	jalr	-100(ra) # 800001d6 <memmove>
}
    80000242:	60a2                	ld	ra,8(sp)
    80000244:	6402                	ld	s0,0(sp)
    80000246:	0141                	add	sp,sp,16
    80000248:	8082                	ret

000000008000024a <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    8000024a:	1141                	add	sp,sp,-16
    8000024c:	e422                	sd	s0,8(sp)
    8000024e:	0800                	add	s0,sp,16
  while(n > 0 && *p && *p == *q)
    80000250:	ce11                	beqz	a2,8000026c <strncmp+0x22>
    80000252:	00054783          	lbu	a5,0(a0)
    80000256:	cf89                	beqz	a5,80000270 <strncmp+0x26>
    80000258:	0005c703          	lbu	a4,0(a1)
    8000025c:	00f71a63          	bne	a4,a5,80000270 <strncmp+0x26>
    n--, p++, q++;
    80000260:	367d                	addw	a2,a2,-1
    80000262:	0505                	add	a0,a0,1
    80000264:	0585                	add	a1,a1,1
  while(n > 0 && *p && *p == *q)
    80000266:	f675                	bnez	a2,80000252 <strncmp+0x8>
  if(n == 0)
    return 0;
    80000268:	4501                	li	a0,0
    8000026a:	a809                	j	8000027c <strncmp+0x32>
    8000026c:	4501                	li	a0,0
    8000026e:	a039                	j	8000027c <strncmp+0x32>
  if(n == 0)
    80000270:	ca09                	beqz	a2,80000282 <strncmp+0x38>
  return (uchar)*p - (uchar)*q;
    80000272:	00054503          	lbu	a0,0(a0)
    80000276:	0005c783          	lbu	a5,0(a1)
    8000027a:	9d1d                	subw	a0,a0,a5
}
    8000027c:	6422                	ld	s0,8(sp)
    8000027e:	0141                	add	sp,sp,16
    80000280:	8082                	ret
    return 0;
    80000282:	4501                	li	a0,0
    80000284:	bfe5                	j	8000027c <strncmp+0x32>

0000000080000286 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    80000286:	1141                	add	sp,sp,-16
    80000288:	e422                	sd	s0,8(sp)
    8000028a:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    8000028c:	87aa                	mv	a5,a0
    8000028e:	86b2                	mv	a3,a2
    80000290:	367d                	addw	a2,a2,-1
    80000292:	00d05963          	blez	a3,800002a4 <strncpy+0x1e>
    80000296:	0785                	add	a5,a5,1
    80000298:	0005c703          	lbu	a4,0(a1)
    8000029c:	fee78fa3          	sb	a4,-1(a5)
    800002a0:	0585                	add	a1,a1,1
    800002a2:	f775                	bnez	a4,8000028e <strncpy+0x8>
    ;
  while(n-- > 0)
    800002a4:	873e                	mv	a4,a5
    800002a6:	9fb5                	addw	a5,a5,a3
    800002a8:	37fd                	addw	a5,a5,-1
    800002aa:	00c05963          	blez	a2,800002bc <strncpy+0x36>
    *s++ = 0;
    800002ae:	0705                	add	a4,a4,1
    800002b0:	fe070fa3          	sb	zero,-1(a4)
  while(n-- > 0)
    800002b4:	40e786bb          	subw	a3,a5,a4
    800002b8:	fed04be3          	bgtz	a3,800002ae <strncpy+0x28>
  return os;
}
    800002bc:	6422                	ld	s0,8(sp)
    800002be:	0141                	add	sp,sp,16
    800002c0:	8082                	ret

00000000800002c2 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    800002c2:	1141                	add	sp,sp,-16
    800002c4:	e422                	sd	s0,8(sp)
    800002c6:	0800                	add	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    800002c8:	02c05363          	blez	a2,800002ee <safestrcpy+0x2c>
    800002cc:	fff6069b          	addw	a3,a2,-1
    800002d0:	1682                	sll	a3,a3,0x20
    800002d2:	9281                	srl	a3,a3,0x20
    800002d4:	96ae                	add	a3,a3,a1
    800002d6:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    800002d8:	00d58963          	beq	a1,a3,800002ea <safestrcpy+0x28>
    800002dc:	0585                	add	a1,a1,1
    800002de:	0785                	add	a5,a5,1
    800002e0:	fff5c703          	lbu	a4,-1(a1)
    800002e4:	fee78fa3          	sb	a4,-1(a5)
    800002e8:	fb65                	bnez	a4,800002d8 <safestrcpy+0x16>
    ;
  *s = 0;
    800002ea:	00078023          	sb	zero,0(a5)
  return os;
}
    800002ee:	6422                	ld	s0,8(sp)
    800002f0:	0141                	add	sp,sp,16
    800002f2:	8082                	ret

00000000800002f4 <strlen>:

int
strlen(const char *s)
{
    800002f4:	1141                	add	sp,sp,-16
    800002f6:	e422                	sd	s0,8(sp)
    800002f8:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    800002fa:	00054783          	lbu	a5,0(a0)
    800002fe:	cf91                	beqz	a5,8000031a <strlen+0x26>
    80000300:	0505                	add	a0,a0,1
    80000302:	87aa                	mv	a5,a0
    80000304:	86be                	mv	a3,a5
    80000306:	0785                	add	a5,a5,1
    80000308:	fff7c703          	lbu	a4,-1(a5)
    8000030c:	ff65                	bnez	a4,80000304 <strlen+0x10>
    8000030e:	40a6853b          	subw	a0,a3,a0
    80000312:	2505                	addw	a0,a0,1
    ;
  return n;
}
    80000314:	6422                	ld	s0,8(sp)
    80000316:	0141                	add	sp,sp,16
    80000318:	8082                	ret
  for(n = 0; s[n]; n++)
    8000031a:	4501                	li	a0,0
    8000031c:	bfe5                	j	80000314 <strlen+0x20>

000000008000031e <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    8000031e:	1141                	add	sp,sp,-16
    80000320:	e406                	sd	ra,8(sp)
    80000322:	e022                	sd	s0,0(sp)
    80000324:	0800                	add	s0,sp,16
  if(cpuid() == 0){
    80000326:	00001097          	auipc	ra,0x1
    8000032a:	af0080e7          	jalr	-1296(ra) # 80000e16 <cpuid>
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
    8000032e:	00009717          	auipc	a4,0x9
    80000332:	cd270713          	add	a4,a4,-814 # 80009000 <started>
  if(cpuid() == 0){
    80000336:	c139                	beqz	a0,8000037c <main+0x5e>
    while(started == 0)
    80000338:	431c                	lw	a5,0(a4)
    8000033a:	2781                	sext.w	a5,a5
    8000033c:	dff5                	beqz	a5,80000338 <main+0x1a>
      ;
    __sync_synchronize();
    8000033e:	0ff0000f          	fence
    printf("hart %d starting\n", cpuid());
    80000342:	00001097          	auipc	ra,0x1
    80000346:	ad4080e7          	jalr	-1324(ra) # 80000e16 <cpuid>
    8000034a:	85aa                	mv	a1,a0
    8000034c:	00008517          	auipc	a0,0x8
    80000350:	cec50513          	add	a0,a0,-788 # 80008038 <etext+0x38>
    80000354:	00005097          	auipc	ra,0x5
    80000358:	770080e7          	jalr	1904(ra) # 80005ac4 <printf>
    kvminithart();    // turn on paging
    8000035c:	00000097          	auipc	ra,0x0
    80000360:	0d8080e7          	jalr	216(ra) # 80000434 <kvminithart>
    trapinithart();   // install kernel trap vector
    80000364:	00001097          	auipc	ra,0x1
    80000368:	734080e7          	jalr	1844(ra) # 80001a98 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    8000036c:	00005097          	auipc	ra,0x5
    80000370:	c44080e7          	jalr	-956(ra) # 80004fb0 <plicinithart>
  }

  scheduler();        
    80000374:	00001097          	auipc	ra,0x1
    80000378:	fe0080e7          	jalr	-32(ra) # 80001354 <scheduler>
    consoleinit();
    8000037c:	00005097          	auipc	ra,0x5
    80000380:	60e080e7          	jalr	1550(ra) # 8000598a <consoleinit>
    printfinit();
    80000384:	00006097          	auipc	ra,0x6
    80000388:	920080e7          	jalr	-1760(ra) # 80005ca4 <printfinit>
    printf("\n");
    8000038c:	00008517          	auipc	a0,0x8
    80000390:	cbc50513          	add	a0,a0,-836 # 80008048 <etext+0x48>
    80000394:	00005097          	auipc	ra,0x5
    80000398:	730080e7          	jalr	1840(ra) # 80005ac4 <printf>
    printf("xv6 kernel is booting\n");
    8000039c:	00008517          	auipc	a0,0x8
    800003a0:	c8450513          	add	a0,a0,-892 # 80008020 <etext+0x20>
    800003a4:	00005097          	auipc	ra,0x5
    800003a8:	720080e7          	jalr	1824(ra) # 80005ac4 <printf>
    printf("\n");
    800003ac:	00008517          	auipc	a0,0x8
    800003b0:	c9c50513          	add	a0,a0,-868 # 80008048 <etext+0x48>
    800003b4:	00005097          	auipc	ra,0x5
    800003b8:	710080e7          	jalr	1808(ra) # 80005ac4 <printf>
    kinit();         // physical page allocator
    800003bc:	00000097          	auipc	ra,0x0
    800003c0:	d22080e7          	jalr	-734(ra) # 800000de <kinit>
    kvminit();       // create kernel page table
    800003c4:	00000097          	auipc	ra,0x0
    800003c8:	322080e7          	jalr	802(ra) # 800006e6 <kvminit>
    kvminithart();   // turn on paging
    800003cc:	00000097          	auipc	ra,0x0
    800003d0:	068080e7          	jalr	104(ra) # 80000434 <kvminithart>
    procinit();      // process table
    800003d4:	00001097          	auipc	ra,0x1
    800003d8:	992080e7          	jalr	-1646(ra) # 80000d66 <procinit>
    trapinit();      // trap vectors
    800003dc:	00001097          	auipc	ra,0x1
    800003e0:	694080e7          	jalr	1684(ra) # 80001a70 <trapinit>
    trapinithart();  // install kernel trap vector
    800003e4:	00001097          	auipc	ra,0x1
    800003e8:	6b4080e7          	jalr	1716(ra) # 80001a98 <trapinithart>
    plicinit();      // set up interrupt controller
    800003ec:	00005097          	auipc	ra,0x5
    800003f0:	bae080e7          	jalr	-1106(ra) # 80004f9a <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    800003f4:	00005097          	auipc	ra,0x5
    800003f8:	bbc080e7          	jalr	-1092(ra) # 80004fb0 <plicinithart>
    binit();         // buffer cache
    800003fc:	00002097          	auipc	ra,0x2
    80000400:	de2080e7          	jalr	-542(ra) # 800021de <binit>
    iinit();         // inode table
    80000404:	00002097          	auipc	ra,0x2
    80000408:	46e080e7          	jalr	1134(ra) # 80002872 <iinit>
    fileinit();      // file table
    8000040c:	00003097          	auipc	ra,0x3
    80000410:	3f0080e7          	jalr	1008(ra) # 800037fc <fileinit>
    virtio_disk_init(); // emulated hard disk
    80000414:	00005097          	auipc	ra,0x5
    80000418:	cbc080e7          	jalr	-836(ra) # 800050d0 <virtio_disk_init>
    userinit();      // first user process
    8000041c:	00001097          	auipc	ra,0x1
    80000420:	cfe080e7          	jalr	-770(ra) # 8000111a <userinit>
    __sync_synchronize();
    80000424:	0ff0000f          	fence
    started = 1;
    80000428:	4785                	li	a5,1
    8000042a:	00009717          	auipc	a4,0x9
    8000042e:	bcf72b23          	sw	a5,-1066(a4) # 80009000 <started>
    80000432:	b789                	j	80000374 <main+0x56>

0000000080000434 <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    80000434:	1141                	add	sp,sp,-16
    80000436:	e422                	sd	s0,8(sp)
    80000438:	0800                	add	s0,sp,16
  w_satp(MAKE_SATP(kernel_pagetable));
    8000043a:	00009797          	auipc	a5,0x9
    8000043e:	bce7b783          	ld	a5,-1074(a5) # 80009008 <kernel_pagetable>
    80000442:	83b1                	srl	a5,a5,0xc
    80000444:	577d                	li	a4,-1
    80000446:	177e                	sll	a4,a4,0x3f
    80000448:	8fd9                	or	a5,a5,a4
// supervisor address translation and protection;
// holds the address of the page table.
static inline void 
w_satp(uint64 x)
{
  asm volatile("csrw satp, %0" : : "r" (x));
    8000044a:	18079073          	csrw	satp,a5
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    8000044e:	12000073          	sfence.vma
  sfence_vma();
}
    80000452:	6422                	ld	s0,8(sp)
    80000454:	0141                	add	sp,sp,16
    80000456:	8082                	ret

0000000080000458 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    80000458:	7139                	add	sp,sp,-64
    8000045a:	fc06                	sd	ra,56(sp)
    8000045c:	f822                	sd	s0,48(sp)
    8000045e:	f426                	sd	s1,40(sp)
    80000460:	f04a                	sd	s2,32(sp)
    80000462:	ec4e                	sd	s3,24(sp)
    80000464:	e852                	sd	s4,16(sp)
    80000466:	e456                	sd	s5,8(sp)
    80000468:	e05a                	sd	s6,0(sp)
    8000046a:	0080                	add	s0,sp,64
    8000046c:	84aa                	mv	s1,a0
    8000046e:	89ae                	mv	s3,a1
    80000470:	8ab2                	mv	s5,a2
  if(va >= MAXVA)
    80000472:	57fd                	li	a5,-1
    80000474:	83e9                	srl	a5,a5,0x1a
    80000476:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    80000478:	4b31                	li	s6,12
  if(va >= MAXVA)
    8000047a:	04b7f263          	bgeu	a5,a1,800004be <walk+0x66>
    panic("walk");
    8000047e:	00008517          	auipc	a0,0x8
    80000482:	bd250513          	add	a0,a0,-1070 # 80008050 <etext+0x50>
    80000486:	00005097          	auipc	ra,0x5
    8000048a:	5f4080e7          	jalr	1524(ra) # 80005a7a <panic>
    pte_t *pte = &pagetable[PX(level, va)];
    if(*pte & PTE_V) {
      pagetable = (pagetable_t)PTE2PA(*pte);
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    8000048e:	060a8663          	beqz	s5,800004fa <walk+0xa2>
    80000492:	00000097          	auipc	ra,0x0
    80000496:	c88080e7          	jalr	-888(ra) # 8000011a <kalloc>
    8000049a:	84aa                	mv	s1,a0
    8000049c:	c529                	beqz	a0,800004e6 <walk+0x8e>
        return 0;
      memset(pagetable, 0, PGSIZE);
    8000049e:	6605                	lui	a2,0x1
    800004a0:	4581                	li	a1,0
    800004a2:	00000097          	auipc	ra,0x0
    800004a6:	cd8080e7          	jalr	-808(ra) # 8000017a <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    800004aa:	00c4d793          	srl	a5,s1,0xc
    800004ae:	07aa                	sll	a5,a5,0xa
    800004b0:	0017e793          	or	a5,a5,1
    800004b4:	00f93023          	sd	a5,0(s2)
  for(int level = 2; level > 0; level--) {
    800004b8:	3a5d                	addw	s4,s4,-9 # ffffffffffffeff7 <end+0xffffffff7ffd8db7>
    800004ba:	036a0063          	beq	s4,s6,800004da <walk+0x82>
    pte_t *pte = &pagetable[PX(level, va)];
    800004be:	0149d933          	srl	s2,s3,s4
    800004c2:	1ff97913          	and	s2,s2,511
    800004c6:	090e                	sll	s2,s2,0x3
    800004c8:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    800004ca:	00093483          	ld	s1,0(s2)
    800004ce:	0014f793          	and	a5,s1,1
    800004d2:	dfd5                	beqz	a5,8000048e <walk+0x36>
      pagetable = (pagetable_t)PTE2PA(*pte);
    800004d4:	80a9                	srl	s1,s1,0xa
    800004d6:	04b2                	sll	s1,s1,0xc
    800004d8:	b7c5                	j	800004b8 <walk+0x60>
    }
  }
  return &pagetable[PX(0, va)];
    800004da:	00c9d513          	srl	a0,s3,0xc
    800004de:	1ff57513          	and	a0,a0,511
    800004e2:	050e                	sll	a0,a0,0x3
    800004e4:	9526                	add	a0,a0,s1
}
    800004e6:	70e2                	ld	ra,56(sp)
    800004e8:	7442                	ld	s0,48(sp)
    800004ea:	74a2                	ld	s1,40(sp)
    800004ec:	7902                	ld	s2,32(sp)
    800004ee:	69e2                	ld	s3,24(sp)
    800004f0:	6a42                	ld	s4,16(sp)
    800004f2:	6aa2                	ld	s5,8(sp)
    800004f4:	6b02                	ld	s6,0(sp)
    800004f6:	6121                	add	sp,sp,64
    800004f8:	8082                	ret
        return 0;
    800004fa:	4501                	li	a0,0
    800004fc:	b7ed                	j	800004e6 <walk+0x8e>

00000000800004fe <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    800004fe:	57fd                	li	a5,-1
    80000500:	83e9                	srl	a5,a5,0x1a
    80000502:	00b7f463          	bgeu	a5,a1,8000050a <walkaddr+0xc>
    return 0;
    80000506:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    80000508:	8082                	ret
{
    8000050a:	1141                	add	sp,sp,-16
    8000050c:	e406                	sd	ra,8(sp)
    8000050e:	e022                	sd	s0,0(sp)
    80000510:	0800                	add	s0,sp,16
  pte = walk(pagetable, va, 0);
    80000512:	4601                	li	a2,0
    80000514:	00000097          	auipc	ra,0x0
    80000518:	f44080e7          	jalr	-188(ra) # 80000458 <walk>
  if(pte == 0)
    8000051c:	c105                	beqz	a0,8000053c <walkaddr+0x3e>
  if((*pte & PTE_V) == 0)
    8000051e:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    80000520:	0117f693          	and	a3,a5,17
    80000524:	4745                	li	a4,17
    return 0;
    80000526:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    80000528:	00e68663          	beq	a3,a4,80000534 <walkaddr+0x36>
}
    8000052c:	60a2                	ld	ra,8(sp)
    8000052e:	6402                	ld	s0,0(sp)
    80000530:	0141                	add	sp,sp,16
    80000532:	8082                	ret
  pa = PTE2PA(*pte);
    80000534:	83a9                	srl	a5,a5,0xa
    80000536:	00c79513          	sll	a0,a5,0xc
  return pa;
    8000053a:	bfcd                	j	8000052c <walkaddr+0x2e>
    return 0;
    8000053c:	4501                	li	a0,0
    8000053e:	b7fd                	j	8000052c <walkaddr+0x2e>

0000000080000540 <mappages>:
// physical addresses starting at pa. va and size might not
// be page-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    80000540:	715d                	add	sp,sp,-80
    80000542:	e486                	sd	ra,72(sp)
    80000544:	e0a2                	sd	s0,64(sp)
    80000546:	fc26                	sd	s1,56(sp)
    80000548:	f84a                	sd	s2,48(sp)
    8000054a:	f44e                	sd	s3,40(sp)
    8000054c:	f052                	sd	s4,32(sp)
    8000054e:	ec56                	sd	s5,24(sp)
    80000550:	e85a                	sd	s6,16(sp)
    80000552:	e45e                	sd	s7,8(sp)
    80000554:	0880                	add	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if(size == 0)
    80000556:	c639                	beqz	a2,800005a4 <mappages+0x64>
    80000558:	8aaa                	mv	s5,a0
    8000055a:	8b3a                	mv	s6,a4
    panic("mappages: size");
  
  a = PGROUNDDOWN(va);
    8000055c:	777d                	lui	a4,0xfffff
    8000055e:	00e5f7b3          	and	a5,a1,a4
  last = PGROUNDDOWN(va + size - 1);
    80000562:	fff58993          	add	s3,a1,-1
    80000566:	99b2                	add	s3,s3,a2
    80000568:	00e9f9b3          	and	s3,s3,a4
  a = PGROUNDDOWN(va);
    8000056c:	893e                	mv	s2,a5
    8000056e:	40f68a33          	sub	s4,a3,a5
    if(*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    80000572:	6b85                	lui	s7,0x1
    80000574:	012a04b3          	add	s1,s4,s2
    if((pte = walk(pagetable, a, 1)) == 0)
    80000578:	4605                	li	a2,1
    8000057a:	85ca                	mv	a1,s2
    8000057c:	8556                	mv	a0,s5
    8000057e:	00000097          	auipc	ra,0x0
    80000582:	eda080e7          	jalr	-294(ra) # 80000458 <walk>
    80000586:	cd1d                	beqz	a0,800005c4 <mappages+0x84>
    if(*pte & PTE_V)
    80000588:	611c                	ld	a5,0(a0)
    8000058a:	8b85                	and	a5,a5,1
    8000058c:	e785                	bnez	a5,800005b4 <mappages+0x74>
    *pte = PA2PTE(pa) | perm | PTE_V;
    8000058e:	80b1                	srl	s1,s1,0xc
    80000590:	04aa                	sll	s1,s1,0xa
    80000592:	0164e4b3          	or	s1,s1,s6
    80000596:	0014e493          	or	s1,s1,1
    8000059a:	e104                	sd	s1,0(a0)
    if(a == last)
    8000059c:	05390063          	beq	s2,s3,800005dc <mappages+0x9c>
    a += PGSIZE;
    800005a0:	995e                	add	s2,s2,s7
    if((pte = walk(pagetable, a, 1)) == 0)
    800005a2:	bfc9                	j	80000574 <mappages+0x34>
    panic("mappages: size");
    800005a4:	00008517          	auipc	a0,0x8
    800005a8:	ab450513          	add	a0,a0,-1356 # 80008058 <etext+0x58>
    800005ac:	00005097          	auipc	ra,0x5
    800005b0:	4ce080e7          	jalr	1230(ra) # 80005a7a <panic>
      panic("mappages: remap");
    800005b4:	00008517          	auipc	a0,0x8
    800005b8:	ab450513          	add	a0,a0,-1356 # 80008068 <etext+0x68>
    800005bc:	00005097          	auipc	ra,0x5
    800005c0:	4be080e7          	jalr	1214(ra) # 80005a7a <panic>
      return -1;
    800005c4:	557d                	li	a0,-1
    pa += PGSIZE;
  }
  return 0;
}
    800005c6:	60a6                	ld	ra,72(sp)
    800005c8:	6406                	ld	s0,64(sp)
    800005ca:	74e2                	ld	s1,56(sp)
    800005cc:	7942                	ld	s2,48(sp)
    800005ce:	79a2                	ld	s3,40(sp)
    800005d0:	7a02                	ld	s4,32(sp)
    800005d2:	6ae2                	ld	s5,24(sp)
    800005d4:	6b42                	ld	s6,16(sp)
    800005d6:	6ba2                	ld	s7,8(sp)
    800005d8:	6161                	add	sp,sp,80
    800005da:	8082                	ret
  return 0;
    800005dc:	4501                	li	a0,0
    800005de:	b7e5                	j	800005c6 <mappages+0x86>

00000000800005e0 <kvmmap>:
{
    800005e0:	1141                	add	sp,sp,-16
    800005e2:	e406                	sd	ra,8(sp)
    800005e4:	e022                	sd	s0,0(sp)
    800005e6:	0800                	add	s0,sp,16
    800005e8:	87b6                	mv	a5,a3
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    800005ea:	86b2                	mv	a3,a2
    800005ec:	863e                	mv	a2,a5
    800005ee:	00000097          	auipc	ra,0x0
    800005f2:	f52080e7          	jalr	-174(ra) # 80000540 <mappages>
    800005f6:	e509                	bnez	a0,80000600 <kvmmap+0x20>
}
    800005f8:	60a2                	ld	ra,8(sp)
    800005fa:	6402                	ld	s0,0(sp)
    800005fc:	0141                	add	sp,sp,16
    800005fe:	8082                	ret
    panic("kvmmap");
    80000600:	00008517          	auipc	a0,0x8
    80000604:	a7850513          	add	a0,a0,-1416 # 80008078 <etext+0x78>
    80000608:	00005097          	auipc	ra,0x5
    8000060c:	472080e7          	jalr	1138(ra) # 80005a7a <panic>

0000000080000610 <kvmmake>:
{
    80000610:	1101                	add	sp,sp,-32
    80000612:	ec06                	sd	ra,24(sp)
    80000614:	e822                	sd	s0,16(sp)
    80000616:	e426                	sd	s1,8(sp)
    80000618:	e04a                	sd	s2,0(sp)
    8000061a:	1000                	add	s0,sp,32
  kpgtbl = (pagetable_t) kalloc();
    8000061c:	00000097          	auipc	ra,0x0
    80000620:	afe080e7          	jalr	-1282(ra) # 8000011a <kalloc>
    80000624:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    80000626:	6605                	lui	a2,0x1
    80000628:	4581                	li	a1,0
    8000062a:	00000097          	auipc	ra,0x0
    8000062e:	b50080e7          	jalr	-1200(ra) # 8000017a <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    80000632:	4719                	li	a4,6
    80000634:	6685                	lui	a3,0x1
    80000636:	10000637          	lui	a2,0x10000
    8000063a:	100005b7          	lui	a1,0x10000
    8000063e:	8526                	mv	a0,s1
    80000640:	00000097          	auipc	ra,0x0
    80000644:	fa0080e7          	jalr	-96(ra) # 800005e0 <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    80000648:	4719                	li	a4,6
    8000064a:	6685                	lui	a3,0x1
    8000064c:	10001637          	lui	a2,0x10001
    80000650:	100015b7          	lui	a1,0x10001
    80000654:	8526                	mv	a0,s1
    80000656:	00000097          	auipc	ra,0x0
    8000065a:	f8a080e7          	jalr	-118(ra) # 800005e0 <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    8000065e:	4719                	li	a4,6
    80000660:	004006b7          	lui	a3,0x400
    80000664:	0c000637          	lui	a2,0xc000
    80000668:	0c0005b7          	lui	a1,0xc000
    8000066c:	8526                	mv	a0,s1
    8000066e:	00000097          	auipc	ra,0x0
    80000672:	f72080e7          	jalr	-142(ra) # 800005e0 <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    80000676:	00008917          	auipc	s2,0x8
    8000067a:	98a90913          	add	s2,s2,-1654 # 80008000 <etext>
    8000067e:	4729                	li	a4,10
    80000680:	80008697          	auipc	a3,0x80008
    80000684:	98068693          	add	a3,a3,-1664 # 8000 <_entry-0x7fff8000>
    80000688:	4605                	li	a2,1
    8000068a:	067e                	sll	a2,a2,0x1f
    8000068c:	85b2                	mv	a1,a2
    8000068e:	8526                	mv	a0,s1
    80000690:	00000097          	auipc	ra,0x0
    80000694:	f50080e7          	jalr	-176(ra) # 800005e0 <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    80000698:	4719                	li	a4,6
    8000069a:	46c5                	li	a3,17
    8000069c:	06ee                	sll	a3,a3,0x1b
    8000069e:	412686b3          	sub	a3,a3,s2
    800006a2:	864a                	mv	a2,s2
    800006a4:	85ca                	mv	a1,s2
    800006a6:	8526                	mv	a0,s1
    800006a8:	00000097          	auipc	ra,0x0
    800006ac:	f38080e7          	jalr	-200(ra) # 800005e0 <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    800006b0:	4729                	li	a4,10
    800006b2:	6685                	lui	a3,0x1
    800006b4:	00007617          	auipc	a2,0x7
    800006b8:	94c60613          	add	a2,a2,-1716 # 80007000 <_trampoline>
    800006bc:	040005b7          	lui	a1,0x4000
    800006c0:	15fd                	add	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    800006c2:	05b2                	sll	a1,a1,0xc
    800006c4:	8526                	mv	a0,s1
    800006c6:	00000097          	auipc	ra,0x0
    800006ca:	f1a080e7          	jalr	-230(ra) # 800005e0 <kvmmap>
  proc_mapstacks(kpgtbl);
    800006ce:	8526                	mv	a0,s1
    800006d0:	00000097          	auipc	ra,0x0
    800006d4:	600080e7          	jalr	1536(ra) # 80000cd0 <proc_mapstacks>
}
    800006d8:	8526                	mv	a0,s1
    800006da:	60e2                	ld	ra,24(sp)
    800006dc:	6442                	ld	s0,16(sp)
    800006de:	64a2                	ld	s1,8(sp)
    800006e0:	6902                	ld	s2,0(sp)
    800006e2:	6105                	add	sp,sp,32
    800006e4:	8082                	ret

00000000800006e6 <kvminit>:
{
    800006e6:	1141                	add	sp,sp,-16
    800006e8:	e406                	sd	ra,8(sp)
    800006ea:	e022                	sd	s0,0(sp)
    800006ec:	0800                	add	s0,sp,16
  kernel_pagetable = kvmmake();
    800006ee:	00000097          	auipc	ra,0x0
    800006f2:	f22080e7          	jalr	-222(ra) # 80000610 <kvmmake>
    800006f6:	00009797          	auipc	a5,0x9
    800006fa:	90a7b923          	sd	a0,-1774(a5) # 80009008 <kernel_pagetable>
}
    800006fe:	60a2                	ld	ra,8(sp)
    80000700:	6402                	ld	s0,0(sp)
    80000702:	0141                	add	sp,sp,16
    80000704:	8082                	ret

0000000080000706 <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    80000706:	715d                	add	sp,sp,-80
    80000708:	e486                	sd	ra,72(sp)
    8000070a:	e0a2                	sd	s0,64(sp)
    8000070c:	fc26                	sd	s1,56(sp)
    8000070e:	f84a                	sd	s2,48(sp)
    80000710:	f44e                	sd	s3,40(sp)
    80000712:	f052                	sd	s4,32(sp)
    80000714:	ec56                	sd	s5,24(sp)
    80000716:	e85a                	sd	s6,16(sp)
    80000718:	e45e                	sd	s7,8(sp)
    8000071a:	0880                	add	s0,sp,80
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    8000071c:	03459793          	sll	a5,a1,0x34
    80000720:	e795                	bnez	a5,8000074c <uvmunmap+0x46>
    80000722:	8a2a                	mv	s4,a0
    80000724:	892e                	mv	s2,a1
    80000726:	8ab6                	mv	s5,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80000728:	0632                	sll	a2,a2,0xc
    8000072a:	00b609b3          	add	s3,a2,a1
    if((pte = walk(pagetable, a, 0)) == 0)
      panic("uvmunmap: walk");
    if((*pte & PTE_V) == 0)
      panic("uvmunmap: not mapped");
    if(PTE_FLAGS(*pte) == PTE_V)
    8000072e:	4b85                	li	s7,1
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80000730:	6b05                	lui	s6,0x1
    80000732:	0735e263          	bltu	a1,s3,80000796 <uvmunmap+0x90>
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
  }
}
    80000736:	60a6                	ld	ra,72(sp)
    80000738:	6406                	ld	s0,64(sp)
    8000073a:	74e2                	ld	s1,56(sp)
    8000073c:	7942                	ld	s2,48(sp)
    8000073e:	79a2                	ld	s3,40(sp)
    80000740:	7a02                	ld	s4,32(sp)
    80000742:	6ae2                	ld	s5,24(sp)
    80000744:	6b42                	ld	s6,16(sp)
    80000746:	6ba2                	ld	s7,8(sp)
    80000748:	6161                	add	sp,sp,80
    8000074a:	8082                	ret
    panic("uvmunmap: not aligned");
    8000074c:	00008517          	auipc	a0,0x8
    80000750:	93450513          	add	a0,a0,-1740 # 80008080 <etext+0x80>
    80000754:	00005097          	auipc	ra,0x5
    80000758:	326080e7          	jalr	806(ra) # 80005a7a <panic>
      panic("uvmunmap: walk");
    8000075c:	00008517          	auipc	a0,0x8
    80000760:	93c50513          	add	a0,a0,-1732 # 80008098 <etext+0x98>
    80000764:	00005097          	auipc	ra,0x5
    80000768:	316080e7          	jalr	790(ra) # 80005a7a <panic>
      panic("uvmunmap: not mapped");
    8000076c:	00008517          	auipc	a0,0x8
    80000770:	93c50513          	add	a0,a0,-1732 # 800080a8 <etext+0xa8>
    80000774:	00005097          	auipc	ra,0x5
    80000778:	306080e7          	jalr	774(ra) # 80005a7a <panic>
      panic("uvmunmap: not a leaf");
    8000077c:	00008517          	auipc	a0,0x8
    80000780:	94450513          	add	a0,a0,-1724 # 800080c0 <etext+0xc0>
    80000784:	00005097          	auipc	ra,0x5
    80000788:	2f6080e7          	jalr	758(ra) # 80005a7a <panic>
    *pte = 0;
    8000078c:	0004b023          	sd	zero,0(s1)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80000790:	995a                	add	s2,s2,s6
    80000792:	fb3972e3          	bgeu	s2,s3,80000736 <uvmunmap+0x30>
    if((pte = walk(pagetable, a, 0)) == 0)
    80000796:	4601                	li	a2,0
    80000798:	85ca                	mv	a1,s2
    8000079a:	8552                	mv	a0,s4
    8000079c:	00000097          	auipc	ra,0x0
    800007a0:	cbc080e7          	jalr	-836(ra) # 80000458 <walk>
    800007a4:	84aa                	mv	s1,a0
    800007a6:	d95d                	beqz	a0,8000075c <uvmunmap+0x56>
    if((*pte & PTE_V) == 0)
    800007a8:	6108                	ld	a0,0(a0)
    800007aa:	00157793          	and	a5,a0,1
    800007ae:	dfdd                	beqz	a5,8000076c <uvmunmap+0x66>
    if(PTE_FLAGS(*pte) == PTE_V)
    800007b0:	3ff57793          	and	a5,a0,1023
    800007b4:	fd7784e3          	beq	a5,s7,8000077c <uvmunmap+0x76>
    if(do_free){
    800007b8:	fc0a8ae3          	beqz	s5,8000078c <uvmunmap+0x86>
      uint64 pa = PTE2PA(*pte);
    800007bc:	8129                	srl	a0,a0,0xa
      kfree((void*)pa);
    800007be:	0532                	sll	a0,a0,0xc
    800007c0:	00000097          	auipc	ra,0x0
    800007c4:	85c080e7          	jalr	-1956(ra) # 8000001c <kfree>
    800007c8:	b7d1                	j	8000078c <uvmunmap+0x86>

00000000800007ca <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    800007ca:	1101                	add	sp,sp,-32
    800007cc:	ec06                	sd	ra,24(sp)
    800007ce:	e822                	sd	s0,16(sp)
    800007d0:	e426                	sd	s1,8(sp)
    800007d2:	1000                	add	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    800007d4:	00000097          	auipc	ra,0x0
    800007d8:	946080e7          	jalr	-1722(ra) # 8000011a <kalloc>
    800007dc:	84aa                	mv	s1,a0
  if(pagetable == 0)
    800007de:	c519                	beqz	a0,800007ec <uvmcreate+0x22>
    return 0;
  memset(pagetable, 0, PGSIZE);
    800007e0:	6605                	lui	a2,0x1
    800007e2:	4581                	li	a1,0
    800007e4:	00000097          	auipc	ra,0x0
    800007e8:	996080e7          	jalr	-1642(ra) # 8000017a <memset>
  return pagetable;
}
    800007ec:	8526                	mv	a0,s1
    800007ee:	60e2                	ld	ra,24(sp)
    800007f0:	6442                	ld	s0,16(sp)
    800007f2:	64a2                	ld	s1,8(sp)
    800007f4:	6105                	add	sp,sp,32
    800007f6:	8082                	ret

00000000800007f8 <uvminit>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvminit(pagetable_t pagetable, uchar *src, uint sz)
{
    800007f8:	7179                	add	sp,sp,-48
    800007fa:	f406                	sd	ra,40(sp)
    800007fc:	f022                	sd	s0,32(sp)
    800007fe:	ec26                	sd	s1,24(sp)
    80000800:	e84a                	sd	s2,16(sp)
    80000802:	e44e                	sd	s3,8(sp)
    80000804:	e052                	sd	s4,0(sp)
    80000806:	1800                	add	s0,sp,48
  char *mem;

  if(sz >= PGSIZE)
    80000808:	6785                	lui	a5,0x1
    8000080a:	04f67863          	bgeu	a2,a5,8000085a <uvminit+0x62>
    8000080e:	8a2a                	mv	s4,a0
    80000810:	89ae                	mv	s3,a1
    80000812:	84b2                	mv	s1,a2
    panic("inituvm: more than a page");
  mem = kalloc();
    80000814:	00000097          	auipc	ra,0x0
    80000818:	906080e7          	jalr	-1786(ra) # 8000011a <kalloc>
    8000081c:	892a                	mv	s2,a0
  memset(mem, 0, PGSIZE);
    8000081e:	6605                	lui	a2,0x1
    80000820:	4581                	li	a1,0
    80000822:	00000097          	auipc	ra,0x0
    80000826:	958080e7          	jalr	-1704(ra) # 8000017a <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    8000082a:	4779                	li	a4,30
    8000082c:	86ca                	mv	a3,s2
    8000082e:	6605                	lui	a2,0x1
    80000830:	4581                	li	a1,0
    80000832:	8552                	mv	a0,s4
    80000834:	00000097          	auipc	ra,0x0
    80000838:	d0c080e7          	jalr	-756(ra) # 80000540 <mappages>
  memmove(mem, src, sz);
    8000083c:	8626                	mv	a2,s1
    8000083e:	85ce                	mv	a1,s3
    80000840:	854a                	mv	a0,s2
    80000842:	00000097          	auipc	ra,0x0
    80000846:	994080e7          	jalr	-1644(ra) # 800001d6 <memmove>
}
    8000084a:	70a2                	ld	ra,40(sp)
    8000084c:	7402                	ld	s0,32(sp)
    8000084e:	64e2                	ld	s1,24(sp)
    80000850:	6942                	ld	s2,16(sp)
    80000852:	69a2                	ld	s3,8(sp)
    80000854:	6a02                	ld	s4,0(sp)
    80000856:	6145                	add	sp,sp,48
    80000858:	8082                	ret
    panic("inituvm: more than a page");
    8000085a:	00008517          	auipc	a0,0x8
    8000085e:	87e50513          	add	a0,a0,-1922 # 800080d8 <etext+0xd8>
    80000862:	00005097          	auipc	ra,0x5
    80000866:	218080e7          	jalr	536(ra) # 80005a7a <panic>

000000008000086a <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    8000086a:	1101                	add	sp,sp,-32
    8000086c:	ec06                	sd	ra,24(sp)
    8000086e:	e822                	sd	s0,16(sp)
    80000870:	e426                	sd	s1,8(sp)
    80000872:	1000                	add	s0,sp,32
  if(newsz >= oldsz)
    return oldsz;
    80000874:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    80000876:	00b67d63          	bgeu	a2,a1,80000890 <uvmdealloc+0x26>
    8000087a:	84b2                	mv	s1,a2

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    8000087c:	6785                	lui	a5,0x1
    8000087e:	17fd                	add	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000880:	00f60733          	add	a4,a2,a5
    80000884:	76fd                	lui	a3,0xfffff
    80000886:	8f75                	and	a4,a4,a3
    80000888:	97ae                	add	a5,a5,a1
    8000088a:	8ff5                	and	a5,a5,a3
    8000088c:	00f76863          	bltu	a4,a5,8000089c <uvmdealloc+0x32>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    80000890:	8526                	mv	a0,s1
    80000892:	60e2                	ld	ra,24(sp)
    80000894:	6442                	ld	s0,16(sp)
    80000896:	64a2                	ld	s1,8(sp)
    80000898:	6105                	add	sp,sp,32
    8000089a:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    8000089c:	8f99                	sub	a5,a5,a4
    8000089e:	83b1                	srl	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    800008a0:	4685                	li	a3,1
    800008a2:	0007861b          	sext.w	a2,a5
    800008a6:	85ba                	mv	a1,a4
    800008a8:	00000097          	auipc	ra,0x0
    800008ac:	e5e080e7          	jalr	-418(ra) # 80000706 <uvmunmap>
    800008b0:	b7c5                	j	80000890 <uvmdealloc+0x26>

00000000800008b2 <uvmalloc>:
  if(newsz < oldsz)
    800008b2:	0ab66163          	bltu	a2,a1,80000954 <uvmalloc+0xa2>
{
    800008b6:	7139                	add	sp,sp,-64
    800008b8:	fc06                	sd	ra,56(sp)
    800008ba:	f822                	sd	s0,48(sp)
    800008bc:	f426                	sd	s1,40(sp)
    800008be:	f04a                	sd	s2,32(sp)
    800008c0:	ec4e                	sd	s3,24(sp)
    800008c2:	e852                	sd	s4,16(sp)
    800008c4:	e456                	sd	s5,8(sp)
    800008c6:	0080                	add	s0,sp,64
    800008c8:	8aaa                	mv	s5,a0
    800008ca:	8a32                	mv	s4,a2
  oldsz = PGROUNDUP(oldsz);
    800008cc:	6785                	lui	a5,0x1
    800008ce:	17fd                	add	a5,a5,-1 # fff <_entry-0x7ffff001>
    800008d0:	95be                	add	a1,a1,a5
    800008d2:	77fd                	lui	a5,0xfffff
    800008d4:	00f5f9b3          	and	s3,a1,a5
  for(a = oldsz; a < newsz; a += PGSIZE){
    800008d8:	08c9f063          	bgeu	s3,a2,80000958 <uvmalloc+0xa6>
    800008dc:	894e                	mv	s2,s3
    mem = kalloc();
    800008de:	00000097          	auipc	ra,0x0
    800008e2:	83c080e7          	jalr	-1988(ra) # 8000011a <kalloc>
    800008e6:	84aa                	mv	s1,a0
    if(mem == 0){
    800008e8:	c51d                	beqz	a0,80000916 <uvmalloc+0x64>
    memset(mem, 0, PGSIZE);
    800008ea:	6605                	lui	a2,0x1
    800008ec:	4581                	li	a1,0
    800008ee:	00000097          	auipc	ra,0x0
    800008f2:	88c080e7          	jalr	-1908(ra) # 8000017a <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_W|PTE_X|PTE_R|PTE_U) != 0){
    800008f6:	4779                	li	a4,30
    800008f8:	86a6                	mv	a3,s1
    800008fa:	6605                	lui	a2,0x1
    800008fc:	85ca                	mv	a1,s2
    800008fe:	8556                	mv	a0,s5
    80000900:	00000097          	auipc	ra,0x0
    80000904:	c40080e7          	jalr	-960(ra) # 80000540 <mappages>
    80000908:	e905                	bnez	a0,80000938 <uvmalloc+0x86>
  for(a = oldsz; a < newsz; a += PGSIZE){
    8000090a:	6785                	lui	a5,0x1
    8000090c:	993e                	add	s2,s2,a5
    8000090e:	fd4968e3          	bltu	s2,s4,800008de <uvmalloc+0x2c>
  return newsz;
    80000912:	8552                	mv	a0,s4
    80000914:	a809                	j	80000926 <uvmalloc+0x74>
      uvmdealloc(pagetable, a, oldsz);
    80000916:	864e                	mv	a2,s3
    80000918:	85ca                	mv	a1,s2
    8000091a:	8556                	mv	a0,s5
    8000091c:	00000097          	auipc	ra,0x0
    80000920:	f4e080e7          	jalr	-178(ra) # 8000086a <uvmdealloc>
      return 0;
    80000924:	4501                	li	a0,0
}
    80000926:	70e2                	ld	ra,56(sp)
    80000928:	7442                	ld	s0,48(sp)
    8000092a:	74a2                	ld	s1,40(sp)
    8000092c:	7902                	ld	s2,32(sp)
    8000092e:	69e2                	ld	s3,24(sp)
    80000930:	6a42                	ld	s4,16(sp)
    80000932:	6aa2                	ld	s5,8(sp)
    80000934:	6121                	add	sp,sp,64
    80000936:	8082                	ret
      kfree(mem);
    80000938:	8526                	mv	a0,s1
    8000093a:	fffff097          	auipc	ra,0xfffff
    8000093e:	6e2080e7          	jalr	1762(ra) # 8000001c <kfree>
      uvmdealloc(pagetable, a, oldsz);
    80000942:	864e                	mv	a2,s3
    80000944:	85ca                	mv	a1,s2
    80000946:	8556                	mv	a0,s5
    80000948:	00000097          	auipc	ra,0x0
    8000094c:	f22080e7          	jalr	-222(ra) # 8000086a <uvmdealloc>
      return 0;
    80000950:	4501                	li	a0,0
    80000952:	bfd1                	j	80000926 <uvmalloc+0x74>
    return oldsz;
    80000954:	852e                	mv	a0,a1
}
    80000956:	8082                	ret
  return newsz;
    80000958:	8532                	mv	a0,a2
    8000095a:	b7f1                	j	80000926 <uvmalloc+0x74>

000000008000095c <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    8000095c:	7179                	add	sp,sp,-48
    8000095e:	f406                	sd	ra,40(sp)
    80000960:	f022                	sd	s0,32(sp)
    80000962:	ec26                	sd	s1,24(sp)
    80000964:	e84a                	sd	s2,16(sp)
    80000966:	e44e                	sd	s3,8(sp)
    80000968:	e052                	sd	s4,0(sp)
    8000096a:	1800                	add	s0,sp,48
    8000096c:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    8000096e:	84aa                	mv	s1,a0
    80000970:	6905                	lui	s2,0x1
    80000972:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80000974:	4985                	li	s3,1
    80000976:	a829                	j	80000990 <freewalk+0x34>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    80000978:	83a9                	srl	a5,a5,0xa
      freewalk((pagetable_t)child);
    8000097a:	00c79513          	sll	a0,a5,0xc
    8000097e:	00000097          	auipc	ra,0x0
    80000982:	fde080e7          	jalr	-34(ra) # 8000095c <freewalk>
      pagetable[i] = 0;
    80000986:	0004b023          	sd	zero,0(s1)
  for(int i = 0; i < 512; i++){
    8000098a:	04a1                	add	s1,s1,8
    8000098c:	03248163          	beq	s1,s2,800009ae <freewalk+0x52>
    pte_t pte = pagetable[i];
    80000990:	609c                	ld	a5,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80000992:	00f7f713          	and	a4,a5,15
    80000996:	ff3701e3          	beq	a4,s3,80000978 <freewalk+0x1c>
    } else if(pte & PTE_V){
    8000099a:	8b85                	and	a5,a5,1
    8000099c:	d7fd                	beqz	a5,8000098a <freewalk+0x2e>
      panic("freewalk: leaf");
    8000099e:	00007517          	auipc	a0,0x7
    800009a2:	75a50513          	add	a0,a0,1882 # 800080f8 <etext+0xf8>
    800009a6:	00005097          	auipc	ra,0x5
    800009aa:	0d4080e7          	jalr	212(ra) # 80005a7a <panic>
    }
  }
  kfree((void*)pagetable);
    800009ae:	8552                	mv	a0,s4
    800009b0:	fffff097          	auipc	ra,0xfffff
    800009b4:	66c080e7          	jalr	1644(ra) # 8000001c <kfree>
}
    800009b8:	70a2                	ld	ra,40(sp)
    800009ba:	7402                	ld	s0,32(sp)
    800009bc:	64e2                	ld	s1,24(sp)
    800009be:	6942                	ld	s2,16(sp)
    800009c0:	69a2                	ld	s3,8(sp)
    800009c2:	6a02                	ld	s4,0(sp)
    800009c4:	6145                	add	sp,sp,48
    800009c6:	8082                	ret

00000000800009c8 <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    800009c8:	1101                	add	sp,sp,-32
    800009ca:	ec06                	sd	ra,24(sp)
    800009cc:	e822                	sd	s0,16(sp)
    800009ce:	e426                	sd	s1,8(sp)
    800009d0:	1000                	add	s0,sp,32
    800009d2:	84aa                	mv	s1,a0
  if(sz > 0)
    800009d4:	e999                	bnez	a1,800009ea <uvmfree+0x22>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    800009d6:	8526                	mv	a0,s1
    800009d8:	00000097          	auipc	ra,0x0
    800009dc:	f84080e7          	jalr	-124(ra) # 8000095c <freewalk>
}
    800009e0:	60e2                	ld	ra,24(sp)
    800009e2:	6442                	ld	s0,16(sp)
    800009e4:	64a2                	ld	s1,8(sp)
    800009e6:	6105                	add	sp,sp,32
    800009e8:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    800009ea:	6785                	lui	a5,0x1
    800009ec:	17fd                	add	a5,a5,-1 # fff <_entry-0x7ffff001>
    800009ee:	95be                	add	a1,a1,a5
    800009f0:	4685                	li	a3,1
    800009f2:	00c5d613          	srl	a2,a1,0xc
    800009f6:	4581                	li	a1,0
    800009f8:	00000097          	auipc	ra,0x0
    800009fc:	d0e080e7          	jalr	-754(ra) # 80000706 <uvmunmap>
    80000a00:	bfd9                	j	800009d6 <uvmfree+0xe>

0000000080000a02 <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    80000a02:	c679                	beqz	a2,80000ad0 <uvmcopy+0xce>
{
    80000a04:	715d                	add	sp,sp,-80
    80000a06:	e486                	sd	ra,72(sp)
    80000a08:	e0a2                	sd	s0,64(sp)
    80000a0a:	fc26                	sd	s1,56(sp)
    80000a0c:	f84a                	sd	s2,48(sp)
    80000a0e:	f44e                	sd	s3,40(sp)
    80000a10:	f052                	sd	s4,32(sp)
    80000a12:	ec56                	sd	s5,24(sp)
    80000a14:	e85a                	sd	s6,16(sp)
    80000a16:	e45e                	sd	s7,8(sp)
    80000a18:	0880                	add	s0,sp,80
    80000a1a:	8b2a                	mv	s6,a0
    80000a1c:	8aae                	mv	s5,a1
    80000a1e:	8a32                	mv	s4,a2
  for(i = 0; i < sz; i += PGSIZE){
    80000a20:	4981                	li	s3,0
    if((pte = walk(old, i, 0)) == 0)
    80000a22:	4601                	li	a2,0
    80000a24:	85ce                	mv	a1,s3
    80000a26:	855a                	mv	a0,s6
    80000a28:	00000097          	auipc	ra,0x0
    80000a2c:	a30080e7          	jalr	-1488(ra) # 80000458 <walk>
    80000a30:	c531                	beqz	a0,80000a7c <uvmcopy+0x7a>
      panic("uvmcopy: pte should exist");
    if((*pte & PTE_V) == 0)
    80000a32:	6118                	ld	a4,0(a0)
    80000a34:	00177793          	and	a5,a4,1
    80000a38:	cbb1                	beqz	a5,80000a8c <uvmcopy+0x8a>
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);
    80000a3a:	00a75593          	srl	a1,a4,0xa
    80000a3e:	00c59b93          	sll	s7,a1,0xc
    flags = PTE_FLAGS(*pte);
    80000a42:	3ff77493          	and	s1,a4,1023
    if((mem = kalloc()) == 0)
    80000a46:	fffff097          	auipc	ra,0xfffff
    80000a4a:	6d4080e7          	jalr	1748(ra) # 8000011a <kalloc>
    80000a4e:	892a                	mv	s2,a0
    80000a50:	c939                	beqz	a0,80000aa6 <uvmcopy+0xa4>
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    80000a52:	6605                	lui	a2,0x1
    80000a54:	85de                	mv	a1,s7
    80000a56:	fffff097          	auipc	ra,0xfffff
    80000a5a:	780080e7          	jalr	1920(ra) # 800001d6 <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    80000a5e:	8726                	mv	a4,s1
    80000a60:	86ca                	mv	a3,s2
    80000a62:	6605                	lui	a2,0x1
    80000a64:	85ce                	mv	a1,s3
    80000a66:	8556                	mv	a0,s5
    80000a68:	00000097          	auipc	ra,0x0
    80000a6c:	ad8080e7          	jalr	-1320(ra) # 80000540 <mappages>
    80000a70:	e515                	bnez	a0,80000a9c <uvmcopy+0x9a>
  for(i = 0; i < sz; i += PGSIZE){
    80000a72:	6785                	lui	a5,0x1
    80000a74:	99be                	add	s3,s3,a5
    80000a76:	fb49e6e3          	bltu	s3,s4,80000a22 <uvmcopy+0x20>
    80000a7a:	a081                	j	80000aba <uvmcopy+0xb8>
      panic("uvmcopy: pte should exist");
    80000a7c:	00007517          	auipc	a0,0x7
    80000a80:	68c50513          	add	a0,a0,1676 # 80008108 <etext+0x108>
    80000a84:	00005097          	auipc	ra,0x5
    80000a88:	ff6080e7          	jalr	-10(ra) # 80005a7a <panic>
      panic("uvmcopy: page not present");
    80000a8c:	00007517          	auipc	a0,0x7
    80000a90:	69c50513          	add	a0,a0,1692 # 80008128 <etext+0x128>
    80000a94:	00005097          	auipc	ra,0x5
    80000a98:	fe6080e7          	jalr	-26(ra) # 80005a7a <panic>
      kfree(mem);
    80000a9c:	854a                	mv	a0,s2
    80000a9e:	fffff097          	auipc	ra,0xfffff
    80000aa2:	57e080e7          	jalr	1406(ra) # 8000001c <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    80000aa6:	4685                	li	a3,1
    80000aa8:	00c9d613          	srl	a2,s3,0xc
    80000aac:	4581                	li	a1,0
    80000aae:	8556                	mv	a0,s5
    80000ab0:	00000097          	auipc	ra,0x0
    80000ab4:	c56080e7          	jalr	-938(ra) # 80000706 <uvmunmap>
  return -1;
    80000ab8:	557d                	li	a0,-1
}
    80000aba:	60a6                	ld	ra,72(sp)
    80000abc:	6406                	ld	s0,64(sp)
    80000abe:	74e2                	ld	s1,56(sp)
    80000ac0:	7942                	ld	s2,48(sp)
    80000ac2:	79a2                	ld	s3,40(sp)
    80000ac4:	7a02                	ld	s4,32(sp)
    80000ac6:	6ae2                	ld	s5,24(sp)
    80000ac8:	6b42                	ld	s6,16(sp)
    80000aca:	6ba2                	ld	s7,8(sp)
    80000acc:	6161                	add	sp,sp,80
    80000ace:	8082                	ret
  return 0;
    80000ad0:	4501                	li	a0,0
}
    80000ad2:	8082                	ret

0000000080000ad4 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80000ad4:	1141                	add	sp,sp,-16
    80000ad6:	e406                	sd	ra,8(sp)
    80000ad8:	e022                	sd	s0,0(sp)
    80000ada:	0800                	add	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    80000adc:	4601                	li	a2,0
    80000ade:	00000097          	auipc	ra,0x0
    80000ae2:	97a080e7          	jalr	-1670(ra) # 80000458 <walk>
  if(pte == 0)
    80000ae6:	c901                	beqz	a0,80000af6 <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    80000ae8:	611c                	ld	a5,0(a0)
    80000aea:	9bbd                	and	a5,a5,-17
    80000aec:	e11c                	sd	a5,0(a0)
}
    80000aee:	60a2                	ld	ra,8(sp)
    80000af0:	6402                	ld	s0,0(sp)
    80000af2:	0141                	add	sp,sp,16
    80000af4:	8082                	ret
    panic("uvmclear");
    80000af6:	00007517          	auipc	a0,0x7
    80000afa:	65250513          	add	a0,a0,1618 # 80008148 <etext+0x148>
    80000afe:	00005097          	auipc	ra,0x5
    80000b02:	f7c080e7          	jalr	-132(ra) # 80005a7a <panic>

0000000080000b06 <copyout>:
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80000b06:	c6bd                	beqz	a3,80000b74 <copyout+0x6e>
{
    80000b08:	715d                	add	sp,sp,-80
    80000b0a:	e486                	sd	ra,72(sp)
    80000b0c:	e0a2                	sd	s0,64(sp)
    80000b0e:	fc26                	sd	s1,56(sp)
    80000b10:	f84a                	sd	s2,48(sp)
    80000b12:	f44e                	sd	s3,40(sp)
    80000b14:	f052                	sd	s4,32(sp)
    80000b16:	ec56                	sd	s5,24(sp)
    80000b18:	e85a                	sd	s6,16(sp)
    80000b1a:	e45e                	sd	s7,8(sp)
    80000b1c:	e062                	sd	s8,0(sp)
    80000b1e:	0880                	add	s0,sp,80
    80000b20:	8b2a                	mv	s6,a0
    80000b22:	8c2e                	mv	s8,a1
    80000b24:	8a32                	mv	s4,a2
    80000b26:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    80000b28:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (dstva - va0);
    80000b2a:	6a85                	lui	s5,0x1
    80000b2c:	a015                	j	80000b50 <copyout+0x4a>
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80000b2e:	9562                	add	a0,a0,s8
    80000b30:	0004861b          	sext.w	a2,s1
    80000b34:	85d2                	mv	a1,s4
    80000b36:	41250533          	sub	a0,a0,s2
    80000b3a:	fffff097          	auipc	ra,0xfffff
    80000b3e:	69c080e7          	jalr	1692(ra) # 800001d6 <memmove>

    len -= n;
    80000b42:	409989b3          	sub	s3,s3,s1
    src += n;
    80000b46:	9a26                	add	s4,s4,s1
    dstva = va0 + PGSIZE;
    80000b48:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80000b4c:	02098263          	beqz	s3,80000b70 <copyout+0x6a>
    va0 = PGROUNDDOWN(dstva);
    80000b50:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000b54:	85ca                	mv	a1,s2
    80000b56:	855a                	mv	a0,s6
    80000b58:	00000097          	auipc	ra,0x0
    80000b5c:	9a6080e7          	jalr	-1626(ra) # 800004fe <walkaddr>
    if(pa0 == 0)
    80000b60:	cd01                	beqz	a0,80000b78 <copyout+0x72>
    n = PGSIZE - (dstva - va0);
    80000b62:	418904b3          	sub	s1,s2,s8
    80000b66:	94d6                	add	s1,s1,s5
    80000b68:	fc99f3e3          	bgeu	s3,s1,80000b2e <copyout+0x28>
    80000b6c:	84ce                	mv	s1,s3
    80000b6e:	b7c1                	j	80000b2e <copyout+0x28>
  }
  return 0;
    80000b70:	4501                	li	a0,0
    80000b72:	a021                	j	80000b7a <copyout+0x74>
    80000b74:	4501                	li	a0,0
}
    80000b76:	8082                	ret
      return -1;
    80000b78:	557d                	li	a0,-1
}
    80000b7a:	60a6                	ld	ra,72(sp)
    80000b7c:	6406                	ld	s0,64(sp)
    80000b7e:	74e2                	ld	s1,56(sp)
    80000b80:	7942                	ld	s2,48(sp)
    80000b82:	79a2                	ld	s3,40(sp)
    80000b84:	7a02                	ld	s4,32(sp)
    80000b86:	6ae2                	ld	s5,24(sp)
    80000b88:	6b42                	ld	s6,16(sp)
    80000b8a:	6ba2                	ld	s7,8(sp)
    80000b8c:	6c02                	ld	s8,0(sp)
    80000b8e:	6161                	add	sp,sp,80
    80000b90:	8082                	ret

0000000080000b92 <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80000b92:	caa5                	beqz	a3,80000c02 <copyin+0x70>
{
    80000b94:	715d                	add	sp,sp,-80
    80000b96:	e486                	sd	ra,72(sp)
    80000b98:	e0a2                	sd	s0,64(sp)
    80000b9a:	fc26                	sd	s1,56(sp)
    80000b9c:	f84a                	sd	s2,48(sp)
    80000b9e:	f44e                	sd	s3,40(sp)
    80000ba0:	f052                	sd	s4,32(sp)
    80000ba2:	ec56                	sd	s5,24(sp)
    80000ba4:	e85a                	sd	s6,16(sp)
    80000ba6:	e45e                	sd	s7,8(sp)
    80000ba8:	e062                	sd	s8,0(sp)
    80000baa:	0880                	add	s0,sp,80
    80000bac:	8b2a                	mv	s6,a0
    80000bae:	8a2e                	mv	s4,a1
    80000bb0:	8c32                	mv	s8,a2
    80000bb2:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80000bb4:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000bb6:	6a85                	lui	s5,0x1
    80000bb8:	a01d                	j	80000bde <copyin+0x4c>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80000bba:	018505b3          	add	a1,a0,s8
    80000bbe:	0004861b          	sext.w	a2,s1
    80000bc2:	412585b3          	sub	a1,a1,s2
    80000bc6:	8552                	mv	a0,s4
    80000bc8:	fffff097          	auipc	ra,0xfffff
    80000bcc:	60e080e7          	jalr	1550(ra) # 800001d6 <memmove>

    len -= n;
    80000bd0:	409989b3          	sub	s3,s3,s1
    dst += n;
    80000bd4:	9a26                	add	s4,s4,s1
    srcva = va0 + PGSIZE;
    80000bd6:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80000bda:	02098263          	beqz	s3,80000bfe <copyin+0x6c>
    va0 = PGROUNDDOWN(srcva);
    80000bde:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000be2:	85ca                	mv	a1,s2
    80000be4:	855a                	mv	a0,s6
    80000be6:	00000097          	auipc	ra,0x0
    80000bea:	918080e7          	jalr	-1768(ra) # 800004fe <walkaddr>
    if(pa0 == 0)
    80000bee:	cd01                	beqz	a0,80000c06 <copyin+0x74>
    n = PGSIZE - (srcva - va0);
    80000bf0:	418904b3          	sub	s1,s2,s8
    80000bf4:	94d6                	add	s1,s1,s5
    80000bf6:	fc99f2e3          	bgeu	s3,s1,80000bba <copyin+0x28>
    80000bfa:	84ce                	mv	s1,s3
    80000bfc:	bf7d                	j	80000bba <copyin+0x28>
  }
  return 0;
    80000bfe:	4501                	li	a0,0
    80000c00:	a021                	j	80000c08 <copyin+0x76>
    80000c02:	4501                	li	a0,0
}
    80000c04:	8082                	ret
      return -1;
    80000c06:	557d                	li	a0,-1
}
    80000c08:	60a6                	ld	ra,72(sp)
    80000c0a:	6406                	ld	s0,64(sp)
    80000c0c:	74e2                	ld	s1,56(sp)
    80000c0e:	7942                	ld	s2,48(sp)
    80000c10:	79a2                	ld	s3,40(sp)
    80000c12:	7a02                	ld	s4,32(sp)
    80000c14:	6ae2                	ld	s5,24(sp)
    80000c16:	6b42                	ld	s6,16(sp)
    80000c18:	6ba2                	ld	s7,8(sp)
    80000c1a:	6c02                	ld	s8,0(sp)
    80000c1c:	6161                	add	sp,sp,80
    80000c1e:	8082                	ret

0000000080000c20 <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    80000c20:	c2dd                	beqz	a3,80000cc6 <copyinstr+0xa6>
{
    80000c22:	715d                	add	sp,sp,-80
    80000c24:	e486                	sd	ra,72(sp)
    80000c26:	e0a2                	sd	s0,64(sp)
    80000c28:	fc26                	sd	s1,56(sp)
    80000c2a:	f84a                	sd	s2,48(sp)
    80000c2c:	f44e                	sd	s3,40(sp)
    80000c2e:	f052                	sd	s4,32(sp)
    80000c30:	ec56                	sd	s5,24(sp)
    80000c32:	e85a                	sd	s6,16(sp)
    80000c34:	e45e                	sd	s7,8(sp)
    80000c36:	0880                	add	s0,sp,80
    80000c38:	8a2a                	mv	s4,a0
    80000c3a:	8b2e                	mv	s6,a1
    80000c3c:	8bb2                	mv	s7,a2
    80000c3e:	84b6                	mv	s1,a3
    va0 = PGROUNDDOWN(srcva);
    80000c40:	7afd                	lui	s5,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000c42:	6985                	lui	s3,0x1
    80000c44:	a02d                	j	80000c6e <copyinstr+0x4e>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    80000c46:	00078023          	sb	zero,0(a5) # 1000 <_entry-0x7ffff000>
    80000c4a:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    80000c4c:	37fd                	addw	a5,a5,-1
    80000c4e:	0007851b          	sext.w	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    80000c52:	60a6                	ld	ra,72(sp)
    80000c54:	6406                	ld	s0,64(sp)
    80000c56:	74e2                	ld	s1,56(sp)
    80000c58:	7942                	ld	s2,48(sp)
    80000c5a:	79a2                	ld	s3,40(sp)
    80000c5c:	7a02                	ld	s4,32(sp)
    80000c5e:	6ae2                	ld	s5,24(sp)
    80000c60:	6b42                	ld	s6,16(sp)
    80000c62:	6ba2                	ld	s7,8(sp)
    80000c64:	6161                	add	sp,sp,80
    80000c66:	8082                	ret
    srcva = va0 + PGSIZE;
    80000c68:	01390bb3          	add	s7,s2,s3
  while(got_null == 0 && max > 0){
    80000c6c:	c8a9                	beqz	s1,80000cbe <copyinstr+0x9e>
    va0 = PGROUNDDOWN(srcva);
    80000c6e:	015bf933          	and	s2,s7,s5
    pa0 = walkaddr(pagetable, va0);
    80000c72:	85ca                	mv	a1,s2
    80000c74:	8552                	mv	a0,s4
    80000c76:	00000097          	auipc	ra,0x0
    80000c7a:	888080e7          	jalr	-1912(ra) # 800004fe <walkaddr>
    if(pa0 == 0)
    80000c7e:	c131                	beqz	a0,80000cc2 <copyinstr+0xa2>
    n = PGSIZE - (srcva - va0);
    80000c80:	417906b3          	sub	a3,s2,s7
    80000c84:	96ce                	add	a3,a3,s3
    80000c86:	00d4f363          	bgeu	s1,a3,80000c8c <copyinstr+0x6c>
    80000c8a:	86a6                	mv	a3,s1
    char *p = (char *) (pa0 + (srcva - va0));
    80000c8c:	955e                	add	a0,a0,s7
    80000c8e:	41250533          	sub	a0,a0,s2
    while(n > 0){
    80000c92:	daf9                	beqz	a3,80000c68 <copyinstr+0x48>
    80000c94:	87da                	mv	a5,s6
    80000c96:	885a                	mv	a6,s6
      if(*p == '\0'){
    80000c98:	41650633          	sub	a2,a0,s6
    while(n > 0){
    80000c9c:	96da                	add	a3,a3,s6
    80000c9e:	85be                	mv	a1,a5
      if(*p == '\0'){
    80000ca0:	00f60733          	add	a4,a2,a5
    80000ca4:	00074703          	lbu	a4,0(a4) # fffffffffffff000 <end+0xffffffff7ffd8dc0>
    80000ca8:	df59                	beqz	a4,80000c46 <copyinstr+0x26>
        *dst = *p;
    80000caa:	00e78023          	sb	a4,0(a5)
      dst++;
    80000cae:	0785                	add	a5,a5,1
    while(n > 0){
    80000cb0:	fed797e3          	bne	a5,a3,80000c9e <copyinstr+0x7e>
    80000cb4:	14fd                	add	s1,s1,-1
    80000cb6:	94c2                	add	s1,s1,a6
      --max;
    80000cb8:	8c8d                	sub	s1,s1,a1
      dst++;
    80000cba:	8b3e                	mv	s6,a5
    80000cbc:	b775                	j	80000c68 <copyinstr+0x48>
    80000cbe:	4781                	li	a5,0
    80000cc0:	b771                	j	80000c4c <copyinstr+0x2c>
      return -1;
    80000cc2:	557d                	li	a0,-1
    80000cc4:	b779                	j	80000c52 <copyinstr+0x32>
  int got_null = 0;
    80000cc6:	4781                	li	a5,0
  if(got_null){
    80000cc8:	37fd                	addw	a5,a5,-1
    80000cca:	0007851b          	sext.w	a0,a5
}
    80000cce:	8082                	ret

0000000080000cd0 <proc_mapstacks>:

// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl) {
    80000cd0:	7139                	add	sp,sp,-64
    80000cd2:	fc06                	sd	ra,56(sp)
    80000cd4:	f822                	sd	s0,48(sp)
    80000cd6:	f426                	sd	s1,40(sp)
    80000cd8:	f04a                	sd	s2,32(sp)
    80000cda:	ec4e                	sd	s3,24(sp)
    80000cdc:	e852                	sd	s4,16(sp)
    80000cde:	e456                	sd	s5,8(sp)
    80000ce0:	e05a                	sd	s6,0(sp)
    80000ce2:	0080                	add	s0,sp,64
    80000ce4:	89aa                	mv	s3,a0
  struct proc *p;
  
  for(p = proc; p < &proc[NPROC]; p++) {
    80000ce6:	00008497          	auipc	s1,0x8
    80000cea:	79a48493          	add	s1,s1,1946 # 80009480 <proc>
    char *pa = kalloc();
    if(pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int) (p - proc));
    80000cee:	8b26                	mv	s6,s1
    80000cf0:	00007a97          	auipc	s5,0x7
    80000cf4:	310a8a93          	add	s5,s5,784 # 80008000 <etext>
    80000cf8:	04000937          	lui	s2,0x4000
    80000cfc:	197d                	add	s2,s2,-1 # 3ffffff <_entry-0x7c000001>
    80000cfe:	0932                	sll	s2,s2,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80000d00:	0000ea17          	auipc	s4,0xe
    80000d04:	180a0a13          	add	s4,s4,384 # 8000ee80 <tickslock>
    char *pa = kalloc();
    80000d08:	fffff097          	auipc	ra,0xfffff
    80000d0c:	412080e7          	jalr	1042(ra) # 8000011a <kalloc>
    80000d10:	862a                	mv	a2,a0
    if(pa == 0)
    80000d12:	c131                	beqz	a0,80000d56 <proc_mapstacks+0x86>
    uint64 va = KSTACK((int) (p - proc));
    80000d14:	416485b3          	sub	a1,s1,s6
    80000d18:	858d                	sra	a1,a1,0x3
    80000d1a:	000ab783          	ld	a5,0(s5)
    80000d1e:	02f585b3          	mul	a1,a1,a5
    80000d22:	2585                	addw	a1,a1,1
    80000d24:	00d5959b          	sllw	a1,a1,0xd
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000d28:	4719                	li	a4,6
    80000d2a:	6685                	lui	a3,0x1
    80000d2c:	40b905b3          	sub	a1,s2,a1
    80000d30:	854e                	mv	a0,s3
    80000d32:	00000097          	auipc	ra,0x0
    80000d36:	8ae080e7          	jalr	-1874(ra) # 800005e0 <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000d3a:	16848493          	add	s1,s1,360
    80000d3e:	fd4495e3          	bne	s1,s4,80000d08 <proc_mapstacks+0x38>
  }
}
    80000d42:	70e2                	ld	ra,56(sp)
    80000d44:	7442                	ld	s0,48(sp)
    80000d46:	74a2                	ld	s1,40(sp)
    80000d48:	7902                	ld	s2,32(sp)
    80000d4a:	69e2                	ld	s3,24(sp)
    80000d4c:	6a42                	ld	s4,16(sp)
    80000d4e:	6aa2                	ld	s5,8(sp)
    80000d50:	6b02                	ld	s6,0(sp)
    80000d52:	6121                	add	sp,sp,64
    80000d54:	8082                	ret
      panic("kalloc");
    80000d56:	00007517          	auipc	a0,0x7
    80000d5a:	40250513          	add	a0,a0,1026 # 80008158 <etext+0x158>
    80000d5e:	00005097          	auipc	ra,0x5
    80000d62:	d1c080e7          	jalr	-740(ra) # 80005a7a <panic>

0000000080000d66 <procinit>:

// initialize the proc table at boot time.
void
procinit(void)
{
    80000d66:	7139                	add	sp,sp,-64
    80000d68:	fc06                	sd	ra,56(sp)
    80000d6a:	f822                	sd	s0,48(sp)
    80000d6c:	f426                	sd	s1,40(sp)
    80000d6e:	f04a                	sd	s2,32(sp)
    80000d70:	ec4e                	sd	s3,24(sp)
    80000d72:	e852                	sd	s4,16(sp)
    80000d74:	e456                	sd	s5,8(sp)
    80000d76:	e05a                	sd	s6,0(sp)
    80000d78:	0080                	add	s0,sp,64
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    80000d7a:	00007597          	auipc	a1,0x7
    80000d7e:	3e658593          	add	a1,a1,998 # 80008160 <etext+0x160>
    80000d82:	00008517          	auipc	a0,0x8
    80000d86:	2ce50513          	add	a0,a0,718 # 80009050 <pid_lock>
    80000d8a:	00005097          	auipc	ra,0x5
    80000d8e:	198080e7          	jalr	408(ra) # 80005f22 <initlock>
  initlock(&wait_lock, "wait_lock");
    80000d92:	00007597          	auipc	a1,0x7
    80000d96:	3d658593          	add	a1,a1,982 # 80008168 <etext+0x168>
    80000d9a:	00008517          	auipc	a0,0x8
    80000d9e:	2ce50513          	add	a0,a0,718 # 80009068 <wait_lock>
    80000da2:	00005097          	auipc	ra,0x5
    80000da6:	180080e7          	jalr	384(ra) # 80005f22 <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000daa:	00008497          	auipc	s1,0x8
    80000dae:	6d648493          	add	s1,s1,1750 # 80009480 <proc>
      initlock(&p->lock, "proc");
    80000db2:	00007b17          	auipc	s6,0x7
    80000db6:	3c6b0b13          	add	s6,s6,966 # 80008178 <etext+0x178>
      p->kstack = KSTACK((int) (p - proc));
    80000dba:	8aa6                	mv	s5,s1
    80000dbc:	00007a17          	auipc	s4,0x7
    80000dc0:	244a0a13          	add	s4,s4,580 # 80008000 <etext>
    80000dc4:	04000937          	lui	s2,0x4000
    80000dc8:	197d                	add	s2,s2,-1 # 3ffffff <_entry-0x7c000001>
    80000dca:	0932                	sll	s2,s2,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80000dcc:	0000e997          	auipc	s3,0xe
    80000dd0:	0b498993          	add	s3,s3,180 # 8000ee80 <tickslock>
      initlock(&p->lock, "proc");
    80000dd4:	85da                	mv	a1,s6
    80000dd6:	8526                	mv	a0,s1
    80000dd8:	00005097          	auipc	ra,0x5
    80000ddc:	14a080e7          	jalr	330(ra) # 80005f22 <initlock>
      p->kstack = KSTACK((int) (p - proc));
    80000de0:	415487b3          	sub	a5,s1,s5
    80000de4:	878d                	sra	a5,a5,0x3
    80000de6:	000a3703          	ld	a4,0(s4)
    80000dea:	02e787b3          	mul	a5,a5,a4
    80000dee:	2785                	addw	a5,a5,1
    80000df0:	00d7979b          	sllw	a5,a5,0xd
    80000df4:	40f907b3          	sub	a5,s2,a5
    80000df8:	e0bc                	sd	a5,64(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    80000dfa:	16848493          	add	s1,s1,360
    80000dfe:	fd349be3          	bne	s1,s3,80000dd4 <procinit+0x6e>
  }
}
    80000e02:	70e2                	ld	ra,56(sp)
    80000e04:	7442                	ld	s0,48(sp)
    80000e06:	74a2                	ld	s1,40(sp)
    80000e08:	7902                	ld	s2,32(sp)
    80000e0a:	69e2                	ld	s3,24(sp)
    80000e0c:	6a42                	ld	s4,16(sp)
    80000e0e:	6aa2                	ld	s5,8(sp)
    80000e10:	6b02                	ld	s6,0(sp)
    80000e12:	6121                	add	sp,sp,64
    80000e14:	8082                	ret

0000000080000e16 <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    80000e16:	1141                	add	sp,sp,-16
    80000e18:	e422                	sd	s0,8(sp)
    80000e1a:	0800                	add	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80000e1c:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    80000e1e:	2501                	sext.w	a0,a0
    80000e20:	6422                	ld	s0,8(sp)
    80000e22:	0141                	add	sp,sp,16
    80000e24:	8082                	ret

0000000080000e26 <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void) {
    80000e26:	1141                	add	sp,sp,-16
    80000e28:	e422                	sd	s0,8(sp)
    80000e2a:	0800                	add	s0,sp,16
    80000e2c:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    80000e2e:	2781                	sext.w	a5,a5
    80000e30:	079e                	sll	a5,a5,0x7
  return c;
}
    80000e32:	00008517          	auipc	a0,0x8
    80000e36:	24e50513          	add	a0,a0,590 # 80009080 <cpus>
    80000e3a:	953e                	add	a0,a0,a5
    80000e3c:	6422                	ld	s0,8(sp)
    80000e3e:	0141                	add	sp,sp,16
    80000e40:	8082                	ret

0000000080000e42 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void) {
    80000e42:	1101                	add	sp,sp,-32
    80000e44:	ec06                	sd	ra,24(sp)
    80000e46:	e822                	sd	s0,16(sp)
    80000e48:	e426                	sd	s1,8(sp)
    80000e4a:	1000                	add	s0,sp,32
  push_off();
    80000e4c:	00005097          	auipc	ra,0x5
    80000e50:	11a080e7          	jalr	282(ra) # 80005f66 <push_off>
    80000e54:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    80000e56:	2781                	sext.w	a5,a5
    80000e58:	079e                	sll	a5,a5,0x7
    80000e5a:	00008717          	auipc	a4,0x8
    80000e5e:	1f670713          	add	a4,a4,502 # 80009050 <pid_lock>
    80000e62:	97ba                	add	a5,a5,a4
    80000e64:	7b84                	ld	s1,48(a5)
  pop_off();
    80000e66:	00005097          	auipc	ra,0x5
    80000e6a:	1a0080e7          	jalr	416(ra) # 80006006 <pop_off>
  return p;
}
    80000e6e:	8526                	mv	a0,s1
    80000e70:	60e2                	ld	ra,24(sp)
    80000e72:	6442                	ld	s0,16(sp)
    80000e74:	64a2                	ld	s1,8(sp)
    80000e76:	6105                	add	sp,sp,32
    80000e78:	8082                	ret

0000000080000e7a <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    80000e7a:	1141                	add	sp,sp,-16
    80000e7c:	e406                	sd	ra,8(sp)
    80000e7e:	e022                	sd	s0,0(sp)
    80000e80:	0800                	add	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    80000e82:	00000097          	auipc	ra,0x0
    80000e86:	fc0080e7          	jalr	-64(ra) # 80000e42 <myproc>
    80000e8a:	00005097          	auipc	ra,0x5
    80000e8e:	1dc080e7          	jalr	476(ra) # 80006066 <release>

  if (first) {
    80000e92:	00008797          	auipc	a5,0x8
    80000e96:	97e7a783          	lw	a5,-1666(a5) # 80008810 <first.1>
    80000e9a:	eb89                	bnez	a5,80000eac <forkret+0x32>
    // be run from main().
    first = 0;
    fsinit(ROOTDEV);
  }

  usertrapret();
    80000e9c:	00001097          	auipc	ra,0x1
    80000ea0:	c14080e7          	jalr	-1004(ra) # 80001ab0 <usertrapret>
}
    80000ea4:	60a2                	ld	ra,8(sp)
    80000ea6:	6402                	ld	s0,0(sp)
    80000ea8:	0141                	add	sp,sp,16
    80000eaa:	8082                	ret
    first = 0;
    80000eac:	00008797          	auipc	a5,0x8
    80000eb0:	9607a223          	sw	zero,-1692(a5) # 80008810 <first.1>
    fsinit(ROOTDEV);
    80000eb4:	4505                	li	a0,1
    80000eb6:	00002097          	auipc	ra,0x2
    80000eba:	93c080e7          	jalr	-1732(ra) # 800027f2 <fsinit>
    80000ebe:	bff9                	j	80000e9c <forkret+0x22>

0000000080000ec0 <allocpid>:
allocpid() {
    80000ec0:	1101                	add	sp,sp,-32
    80000ec2:	ec06                	sd	ra,24(sp)
    80000ec4:	e822                	sd	s0,16(sp)
    80000ec6:	e426                	sd	s1,8(sp)
    80000ec8:	e04a                	sd	s2,0(sp)
    80000eca:	1000                	add	s0,sp,32
  acquire(&pid_lock);
    80000ecc:	00008917          	auipc	s2,0x8
    80000ed0:	18490913          	add	s2,s2,388 # 80009050 <pid_lock>
    80000ed4:	854a                	mv	a0,s2
    80000ed6:	00005097          	auipc	ra,0x5
    80000eda:	0dc080e7          	jalr	220(ra) # 80005fb2 <acquire>
  pid = nextpid;
    80000ede:	00008797          	auipc	a5,0x8
    80000ee2:	93678793          	add	a5,a5,-1738 # 80008814 <nextpid>
    80000ee6:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80000ee8:	0014871b          	addw	a4,s1,1
    80000eec:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80000eee:	854a                	mv	a0,s2
    80000ef0:	00005097          	auipc	ra,0x5
    80000ef4:	176080e7          	jalr	374(ra) # 80006066 <release>
}
    80000ef8:	8526                	mv	a0,s1
    80000efa:	60e2                	ld	ra,24(sp)
    80000efc:	6442                	ld	s0,16(sp)
    80000efe:	64a2                	ld	s1,8(sp)
    80000f00:	6902                	ld	s2,0(sp)
    80000f02:	6105                	add	sp,sp,32
    80000f04:	8082                	ret

0000000080000f06 <proc_pagetable>:
{
    80000f06:	1101                	add	sp,sp,-32
    80000f08:	ec06                	sd	ra,24(sp)
    80000f0a:	e822                	sd	s0,16(sp)
    80000f0c:	e426                	sd	s1,8(sp)
    80000f0e:	e04a                	sd	s2,0(sp)
    80000f10:	1000                	add	s0,sp,32
    80000f12:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    80000f14:	00000097          	auipc	ra,0x0
    80000f18:	8b6080e7          	jalr	-1866(ra) # 800007ca <uvmcreate>
    80000f1c:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80000f1e:	c121                	beqz	a0,80000f5e <proc_pagetable+0x58>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80000f20:	4729                	li	a4,10
    80000f22:	00006697          	auipc	a3,0x6
    80000f26:	0de68693          	add	a3,a3,222 # 80007000 <_trampoline>
    80000f2a:	6605                	lui	a2,0x1
    80000f2c:	040005b7          	lui	a1,0x4000
    80000f30:	15fd                	add	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000f32:	05b2                	sll	a1,a1,0xc
    80000f34:	fffff097          	auipc	ra,0xfffff
    80000f38:	60c080e7          	jalr	1548(ra) # 80000540 <mappages>
    80000f3c:	02054863          	bltz	a0,80000f6c <proc_pagetable+0x66>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80000f40:	4719                	li	a4,6
    80000f42:	05893683          	ld	a3,88(s2)
    80000f46:	6605                	lui	a2,0x1
    80000f48:	020005b7          	lui	a1,0x2000
    80000f4c:	15fd                	add	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80000f4e:	05b6                	sll	a1,a1,0xd
    80000f50:	8526                	mv	a0,s1
    80000f52:	fffff097          	auipc	ra,0xfffff
    80000f56:	5ee080e7          	jalr	1518(ra) # 80000540 <mappages>
    80000f5a:	02054163          	bltz	a0,80000f7c <proc_pagetable+0x76>
}
    80000f5e:	8526                	mv	a0,s1
    80000f60:	60e2                	ld	ra,24(sp)
    80000f62:	6442                	ld	s0,16(sp)
    80000f64:	64a2                	ld	s1,8(sp)
    80000f66:	6902                	ld	s2,0(sp)
    80000f68:	6105                	add	sp,sp,32
    80000f6a:	8082                	ret
    uvmfree(pagetable, 0);
    80000f6c:	4581                	li	a1,0
    80000f6e:	8526                	mv	a0,s1
    80000f70:	00000097          	auipc	ra,0x0
    80000f74:	a58080e7          	jalr	-1448(ra) # 800009c8 <uvmfree>
    return 0;
    80000f78:	4481                	li	s1,0
    80000f7a:	b7d5                	j	80000f5e <proc_pagetable+0x58>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80000f7c:	4681                	li	a3,0
    80000f7e:	4605                	li	a2,1
    80000f80:	040005b7          	lui	a1,0x4000
    80000f84:	15fd                	add	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000f86:	05b2                	sll	a1,a1,0xc
    80000f88:	8526                	mv	a0,s1
    80000f8a:	fffff097          	auipc	ra,0xfffff
    80000f8e:	77c080e7          	jalr	1916(ra) # 80000706 <uvmunmap>
    uvmfree(pagetable, 0);
    80000f92:	4581                	li	a1,0
    80000f94:	8526                	mv	a0,s1
    80000f96:	00000097          	auipc	ra,0x0
    80000f9a:	a32080e7          	jalr	-1486(ra) # 800009c8 <uvmfree>
    return 0;
    80000f9e:	4481                	li	s1,0
    80000fa0:	bf7d                	j	80000f5e <proc_pagetable+0x58>

0000000080000fa2 <proc_freepagetable>:
{
    80000fa2:	1101                	add	sp,sp,-32
    80000fa4:	ec06                	sd	ra,24(sp)
    80000fa6:	e822                	sd	s0,16(sp)
    80000fa8:	e426                	sd	s1,8(sp)
    80000faa:	e04a                	sd	s2,0(sp)
    80000fac:	1000                	add	s0,sp,32
    80000fae:	84aa                	mv	s1,a0
    80000fb0:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80000fb2:	4681                	li	a3,0
    80000fb4:	4605                	li	a2,1
    80000fb6:	040005b7          	lui	a1,0x4000
    80000fba:	15fd                	add	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000fbc:	05b2                	sll	a1,a1,0xc
    80000fbe:	fffff097          	auipc	ra,0xfffff
    80000fc2:	748080e7          	jalr	1864(ra) # 80000706 <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80000fc6:	4681                	li	a3,0
    80000fc8:	4605                	li	a2,1
    80000fca:	020005b7          	lui	a1,0x2000
    80000fce:	15fd                	add	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80000fd0:	05b6                	sll	a1,a1,0xd
    80000fd2:	8526                	mv	a0,s1
    80000fd4:	fffff097          	auipc	ra,0xfffff
    80000fd8:	732080e7          	jalr	1842(ra) # 80000706 <uvmunmap>
  uvmfree(pagetable, sz);
    80000fdc:	85ca                	mv	a1,s2
    80000fde:	8526                	mv	a0,s1
    80000fe0:	00000097          	auipc	ra,0x0
    80000fe4:	9e8080e7          	jalr	-1560(ra) # 800009c8 <uvmfree>
}
    80000fe8:	60e2                	ld	ra,24(sp)
    80000fea:	6442                	ld	s0,16(sp)
    80000fec:	64a2                	ld	s1,8(sp)
    80000fee:	6902                	ld	s2,0(sp)
    80000ff0:	6105                	add	sp,sp,32
    80000ff2:	8082                	ret

0000000080000ff4 <freeproc>:
{
    80000ff4:	1101                	add	sp,sp,-32
    80000ff6:	ec06                	sd	ra,24(sp)
    80000ff8:	e822                	sd	s0,16(sp)
    80000ffa:	e426                	sd	s1,8(sp)
    80000ffc:	1000                	add	s0,sp,32
    80000ffe:	84aa                	mv	s1,a0
  if(p->trapframe)
    80001000:	6d28                	ld	a0,88(a0)
    80001002:	c509                	beqz	a0,8000100c <freeproc+0x18>
    kfree((void*)p->trapframe);
    80001004:	fffff097          	auipc	ra,0xfffff
    80001008:	018080e7          	jalr	24(ra) # 8000001c <kfree>
  p->trapframe = 0;
    8000100c:	0404bc23          	sd	zero,88(s1)
  if(p->pagetable)
    80001010:	68a8                	ld	a0,80(s1)
    80001012:	c511                	beqz	a0,8000101e <freeproc+0x2a>
    proc_freepagetable(p->pagetable, p->sz);
    80001014:	64ac                	ld	a1,72(s1)
    80001016:	00000097          	auipc	ra,0x0
    8000101a:	f8c080e7          	jalr	-116(ra) # 80000fa2 <proc_freepagetable>
  p->pagetable = 0;
    8000101e:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    80001022:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    80001026:	0204a823          	sw	zero,48(s1)
  p->parent = 0;
    8000102a:	0204bc23          	sd	zero,56(s1)
  p->name[0] = 0;
    8000102e:	14048c23          	sb	zero,344(s1)
  p->chan = 0;
    80001032:	0204b023          	sd	zero,32(s1)
  p->killed = 0;
    80001036:	0204a423          	sw	zero,40(s1)
  p->xstate = 0;
    8000103a:	0204a623          	sw	zero,44(s1)
  p->state = UNUSED;
    8000103e:	0004ac23          	sw	zero,24(s1)
}
    80001042:	60e2                	ld	ra,24(sp)
    80001044:	6442                	ld	s0,16(sp)
    80001046:	64a2                	ld	s1,8(sp)
    80001048:	6105                	add	sp,sp,32
    8000104a:	8082                	ret

000000008000104c <allocproc>:
{
    8000104c:	1101                	add	sp,sp,-32
    8000104e:	ec06                	sd	ra,24(sp)
    80001050:	e822                	sd	s0,16(sp)
    80001052:	e426                	sd	s1,8(sp)
    80001054:	e04a                	sd	s2,0(sp)
    80001056:	1000                	add	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    80001058:	00008497          	auipc	s1,0x8
    8000105c:	42848493          	add	s1,s1,1064 # 80009480 <proc>
    80001060:	0000e917          	auipc	s2,0xe
    80001064:	e2090913          	add	s2,s2,-480 # 8000ee80 <tickslock>
    acquire(&p->lock);
    80001068:	8526                	mv	a0,s1
    8000106a:	00005097          	auipc	ra,0x5
    8000106e:	f48080e7          	jalr	-184(ra) # 80005fb2 <acquire>
    if(p->state == UNUSED) {
    80001072:	4c9c                	lw	a5,24(s1)
    80001074:	cf81                	beqz	a5,8000108c <allocproc+0x40>
      release(&p->lock);
    80001076:	8526                	mv	a0,s1
    80001078:	00005097          	auipc	ra,0x5
    8000107c:	fee080e7          	jalr	-18(ra) # 80006066 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001080:	16848493          	add	s1,s1,360
    80001084:	ff2492e3          	bne	s1,s2,80001068 <allocproc+0x1c>
  return 0;
    80001088:	4481                	li	s1,0
    8000108a:	a889                	j	800010dc <allocproc+0x90>
  p->pid = allocpid();
    8000108c:	00000097          	auipc	ra,0x0
    80001090:	e34080e7          	jalr	-460(ra) # 80000ec0 <allocpid>
    80001094:	d888                	sw	a0,48(s1)
  p->state = USED;
    80001096:	4785                	li	a5,1
    80001098:	cc9c                	sw	a5,24(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    8000109a:	fffff097          	auipc	ra,0xfffff
    8000109e:	080080e7          	jalr	128(ra) # 8000011a <kalloc>
    800010a2:	892a                	mv	s2,a0
    800010a4:	eca8                	sd	a0,88(s1)
    800010a6:	c131                	beqz	a0,800010ea <allocproc+0x9e>
  p->pagetable = proc_pagetable(p);
    800010a8:	8526                	mv	a0,s1
    800010aa:	00000097          	auipc	ra,0x0
    800010ae:	e5c080e7          	jalr	-420(ra) # 80000f06 <proc_pagetable>
    800010b2:	892a                	mv	s2,a0
    800010b4:	e8a8                	sd	a0,80(s1)
  if(p->pagetable == 0){
    800010b6:	c531                	beqz	a0,80001102 <allocproc+0xb6>
  memset(&p->context, 0, sizeof(p->context));
    800010b8:	07000613          	li	a2,112
    800010bc:	4581                	li	a1,0
    800010be:	06048513          	add	a0,s1,96
    800010c2:	fffff097          	auipc	ra,0xfffff
    800010c6:	0b8080e7          	jalr	184(ra) # 8000017a <memset>
  p->context.ra = (uint64)forkret;
    800010ca:	00000797          	auipc	a5,0x0
    800010ce:	db078793          	add	a5,a5,-592 # 80000e7a <forkret>
    800010d2:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PGSIZE;
    800010d4:	60bc                	ld	a5,64(s1)
    800010d6:	6705                	lui	a4,0x1
    800010d8:	97ba                	add	a5,a5,a4
    800010da:	f4bc                	sd	a5,104(s1)
}
    800010dc:	8526                	mv	a0,s1
    800010de:	60e2                	ld	ra,24(sp)
    800010e0:	6442                	ld	s0,16(sp)
    800010e2:	64a2                	ld	s1,8(sp)
    800010e4:	6902                	ld	s2,0(sp)
    800010e6:	6105                	add	sp,sp,32
    800010e8:	8082                	ret
    freeproc(p);
    800010ea:	8526                	mv	a0,s1
    800010ec:	00000097          	auipc	ra,0x0
    800010f0:	f08080e7          	jalr	-248(ra) # 80000ff4 <freeproc>
    release(&p->lock);
    800010f4:	8526                	mv	a0,s1
    800010f6:	00005097          	auipc	ra,0x5
    800010fa:	f70080e7          	jalr	-144(ra) # 80006066 <release>
    return 0;
    800010fe:	84ca                	mv	s1,s2
    80001100:	bff1                	j	800010dc <allocproc+0x90>
    freeproc(p);
    80001102:	8526                	mv	a0,s1
    80001104:	00000097          	auipc	ra,0x0
    80001108:	ef0080e7          	jalr	-272(ra) # 80000ff4 <freeproc>
    release(&p->lock);
    8000110c:	8526                	mv	a0,s1
    8000110e:	00005097          	auipc	ra,0x5
    80001112:	f58080e7          	jalr	-168(ra) # 80006066 <release>
    return 0;
    80001116:	84ca                	mv	s1,s2
    80001118:	b7d1                	j	800010dc <allocproc+0x90>

000000008000111a <userinit>:
{
    8000111a:	1101                	add	sp,sp,-32
    8000111c:	ec06                	sd	ra,24(sp)
    8000111e:	e822                	sd	s0,16(sp)
    80001120:	e426                	sd	s1,8(sp)
    80001122:	1000                	add	s0,sp,32
  p = allocproc();
    80001124:	00000097          	auipc	ra,0x0
    80001128:	f28080e7          	jalr	-216(ra) # 8000104c <allocproc>
    8000112c:	84aa                	mv	s1,a0
  initproc = p;
    8000112e:	00008797          	auipc	a5,0x8
    80001132:	eea7b123          	sd	a0,-286(a5) # 80009010 <initproc>
  uvminit(p->pagetable, initcode, sizeof(initcode));
    80001136:	03400613          	li	a2,52
    8000113a:	00007597          	auipc	a1,0x7
    8000113e:	6e658593          	add	a1,a1,1766 # 80008820 <initcode>
    80001142:	6928                	ld	a0,80(a0)
    80001144:	fffff097          	auipc	ra,0xfffff
    80001148:	6b4080e7          	jalr	1716(ra) # 800007f8 <uvminit>
  p->sz = PGSIZE;
    8000114c:	6785                	lui	a5,0x1
    8000114e:	e4bc                	sd	a5,72(s1)
  p->trapframe->epc = 0;      // user program counter
    80001150:	6cb8                	ld	a4,88(s1)
    80001152:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->trapframe->sp = PGSIZE;  // user stack pointer
    80001156:	6cb8                	ld	a4,88(s1)
    80001158:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    8000115a:	4641                	li	a2,16
    8000115c:	00007597          	auipc	a1,0x7
    80001160:	02458593          	add	a1,a1,36 # 80008180 <etext+0x180>
    80001164:	15848513          	add	a0,s1,344
    80001168:	fffff097          	auipc	ra,0xfffff
    8000116c:	15a080e7          	jalr	346(ra) # 800002c2 <safestrcpy>
  p->cwd = namei("/");
    80001170:	00007517          	auipc	a0,0x7
    80001174:	02050513          	add	a0,a0,32 # 80008190 <etext+0x190>
    80001178:	00002097          	auipc	ra,0x2
    8000117c:	0a4080e7          	jalr	164(ra) # 8000321c <namei>
    80001180:	14a4b823          	sd	a0,336(s1)
  p->state = RUNNABLE;
    80001184:	478d                	li	a5,3
    80001186:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    80001188:	8526                	mv	a0,s1
    8000118a:	00005097          	auipc	ra,0x5
    8000118e:	edc080e7          	jalr	-292(ra) # 80006066 <release>
}
    80001192:	60e2                	ld	ra,24(sp)
    80001194:	6442                	ld	s0,16(sp)
    80001196:	64a2                	ld	s1,8(sp)
    80001198:	6105                	add	sp,sp,32
    8000119a:	8082                	ret

000000008000119c <growproc>:
{
    8000119c:	1101                	add	sp,sp,-32
    8000119e:	ec06                	sd	ra,24(sp)
    800011a0:	e822                	sd	s0,16(sp)
    800011a2:	e426                	sd	s1,8(sp)
    800011a4:	e04a                	sd	s2,0(sp)
    800011a6:	1000                	add	s0,sp,32
    800011a8:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    800011aa:	00000097          	auipc	ra,0x0
    800011ae:	c98080e7          	jalr	-872(ra) # 80000e42 <myproc>
    800011b2:	892a                	mv	s2,a0
  sz = p->sz;
    800011b4:	652c                	ld	a1,72(a0)
    800011b6:	0005879b          	sext.w	a5,a1
  if(n > 0){
    800011ba:	00904f63          	bgtz	s1,800011d8 <growproc+0x3c>
  } else if(n < 0){
    800011be:	0204cd63          	bltz	s1,800011f8 <growproc+0x5c>
  p->sz = sz;
    800011c2:	1782                	sll	a5,a5,0x20
    800011c4:	9381                	srl	a5,a5,0x20
    800011c6:	04f93423          	sd	a5,72(s2)
  return 0;
    800011ca:	4501                	li	a0,0
}
    800011cc:	60e2                	ld	ra,24(sp)
    800011ce:	6442                	ld	s0,16(sp)
    800011d0:	64a2                	ld	s1,8(sp)
    800011d2:	6902                	ld	s2,0(sp)
    800011d4:	6105                	add	sp,sp,32
    800011d6:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n)) == 0) {
    800011d8:	00f4863b          	addw	a2,s1,a5
    800011dc:	1602                	sll	a2,a2,0x20
    800011de:	9201                	srl	a2,a2,0x20
    800011e0:	1582                	sll	a1,a1,0x20
    800011e2:	9181                	srl	a1,a1,0x20
    800011e4:	6928                	ld	a0,80(a0)
    800011e6:	fffff097          	auipc	ra,0xfffff
    800011ea:	6cc080e7          	jalr	1740(ra) # 800008b2 <uvmalloc>
    800011ee:	0005079b          	sext.w	a5,a0
    800011f2:	fbe1                	bnez	a5,800011c2 <growproc+0x26>
      return -1;
    800011f4:	557d                	li	a0,-1
    800011f6:	bfd9                	j	800011cc <growproc+0x30>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    800011f8:	00f4863b          	addw	a2,s1,a5
    800011fc:	1602                	sll	a2,a2,0x20
    800011fe:	9201                	srl	a2,a2,0x20
    80001200:	1582                	sll	a1,a1,0x20
    80001202:	9181                	srl	a1,a1,0x20
    80001204:	6928                	ld	a0,80(a0)
    80001206:	fffff097          	auipc	ra,0xfffff
    8000120a:	664080e7          	jalr	1636(ra) # 8000086a <uvmdealloc>
    8000120e:	0005079b          	sext.w	a5,a0
    80001212:	bf45                	j	800011c2 <growproc+0x26>

0000000080001214 <fork>:
{
    80001214:	7139                	add	sp,sp,-64
    80001216:	fc06                	sd	ra,56(sp)
    80001218:	f822                	sd	s0,48(sp)
    8000121a:	f426                	sd	s1,40(sp)
    8000121c:	f04a                	sd	s2,32(sp)
    8000121e:	ec4e                	sd	s3,24(sp)
    80001220:	e852                	sd	s4,16(sp)
    80001222:	e456                	sd	s5,8(sp)
    80001224:	0080                	add	s0,sp,64
  struct proc *p = myproc();
    80001226:	00000097          	auipc	ra,0x0
    8000122a:	c1c080e7          	jalr	-996(ra) # 80000e42 <myproc>
    8000122e:	8aaa                	mv	s5,a0
  if((np = allocproc()) == 0){
    80001230:	00000097          	auipc	ra,0x0
    80001234:	e1c080e7          	jalr	-484(ra) # 8000104c <allocproc>
    80001238:	10050c63          	beqz	a0,80001350 <fork+0x13c>
    8000123c:	8a2a                	mv	s4,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    8000123e:	048ab603          	ld	a2,72(s5)
    80001242:	692c                	ld	a1,80(a0)
    80001244:	050ab503          	ld	a0,80(s5)
    80001248:	fffff097          	auipc	ra,0xfffff
    8000124c:	7ba080e7          	jalr	1978(ra) # 80000a02 <uvmcopy>
    80001250:	04054863          	bltz	a0,800012a0 <fork+0x8c>
  np->sz = p->sz;
    80001254:	048ab783          	ld	a5,72(s5)
    80001258:	04fa3423          	sd	a5,72(s4)
  *(np->trapframe) = *(p->trapframe);
    8000125c:	058ab683          	ld	a3,88(s5)
    80001260:	87b6                	mv	a5,a3
    80001262:	058a3703          	ld	a4,88(s4)
    80001266:	12068693          	add	a3,a3,288
    8000126a:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    8000126e:	6788                	ld	a0,8(a5)
    80001270:	6b8c                	ld	a1,16(a5)
    80001272:	6f90                	ld	a2,24(a5)
    80001274:	01073023          	sd	a6,0(a4)
    80001278:	e708                	sd	a0,8(a4)
    8000127a:	eb0c                	sd	a1,16(a4)
    8000127c:	ef10                	sd	a2,24(a4)
    8000127e:	02078793          	add	a5,a5,32
    80001282:	02070713          	add	a4,a4,32
    80001286:	fed792e3          	bne	a5,a3,8000126a <fork+0x56>
  np->trapframe->a0 = 0;
    8000128a:	058a3783          	ld	a5,88(s4)
    8000128e:	0607b823          	sd	zero,112(a5)
  for(i = 0; i < NOFILE; i++)
    80001292:	0d0a8493          	add	s1,s5,208
    80001296:	0d0a0913          	add	s2,s4,208
    8000129a:	150a8993          	add	s3,s5,336
    8000129e:	a00d                	j	800012c0 <fork+0xac>
    freeproc(np);
    800012a0:	8552                	mv	a0,s4
    800012a2:	00000097          	auipc	ra,0x0
    800012a6:	d52080e7          	jalr	-686(ra) # 80000ff4 <freeproc>
    release(&np->lock);
    800012aa:	8552                	mv	a0,s4
    800012ac:	00005097          	auipc	ra,0x5
    800012b0:	dba080e7          	jalr	-582(ra) # 80006066 <release>
    return -1;
    800012b4:	597d                	li	s2,-1
    800012b6:	a059                	j	8000133c <fork+0x128>
  for(i = 0; i < NOFILE; i++)
    800012b8:	04a1                	add	s1,s1,8
    800012ba:	0921                	add	s2,s2,8
    800012bc:	01348b63          	beq	s1,s3,800012d2 <fork+0xbe>
    if(p->ofile[i])
    800012c0:	6088                	ld	a0,0(s1)
    800012c2:	d97d                	beqz	a0,800012b8 <fork+0xa4>
      np->ofile[i] = filedup(p->ofile[i]);
    800012c4:	00002097          	auipc	ra,0x2
    800012c8:	5ca080e7          	jalr	1482(ra) # 8000388e <filedup>
    800012cc:	00a93023          	sd	a0,0(s2)
    800012d0:	b7e5                	j	800012b8 <fork+0xa4>
  np->cwd = idup(p->cwd);
    800012d2:	150ab503          	ld	a0,336(s5)
    800012d6:	00001097          	auipc	ra,0x1
    800012da:	752080e7          	jalr	1874(ra) # 80002a28 <idup>
    800012de:	14aa3823          	sd	a0,336(s4)
  safestrcpy(np->name, p->name, sizeof(p->name));
    800012e2:	4641                	li	a2,16
    800012e4:	158a8593          	add	a1,s5,344
    800012e8:	158a0513          	add	a0,s4,344
    800012ec:	fffff097          	auipc	ra,0xfffff
    800012f0:	fd6080e7          	jalr	-42(ra) # 800002c2 <safestrcpy>
  pid = np->pid;
    800012f4:	030a2903          	lw	s2,48(s4)
  release(&np->lock);
    800012f8:	8552                	mv	a0,s4
    800012fa:	00005097          	auipc	ra,0x5
    800012fe:	d6c080e7          	jalr	-660(ra) # 80006066 <release>
  acquire(&wait_lock);
    80001302:	00008497          	auipc	s1,0x8
    80001306:	d6648493          	add	s1,s1,-666 # 80009068 <wait_lock>
    8000130a:	8526                	mv	a0,s1
    8000130c:	00005097          	auipc	ra,0x5
    80001310:	ca6080e7          	jalr	-858(ra) # 80005fb2 <acquire>
  np->parent = p;
    80001314:	035a3c23          	sd	s5,56(s4)
  release(&wait_lock);
    80001318:	8526                	mv	a0,s1
    8000131a:	00005097          	auipc	ra,0x5
    8000131e:	d4c080e7          	jalr	-692(ra) # 80006066 <release>
  acquire(&np->lock);
    80001322:	8552                	mv	a0,s4
    80001324:	00005097          	auipc	ra,0x5
    80001328:	c8e080e7          	jalr	-882(ra) # 80005fb2 <acquire>
  np->state = RUNNABLE;
    8000132c:	478d                	li	a5,3
    8000132e:	00fa2c23          	sw	a5,24(s4)
  release(&np->lock);
    80001332:	8552                	mv	a0,s4
    80001334:	00005097          	auipc	ra,0x5
    80001338:	d32080e7          	jalr	-718(ra) # 80006066 <release>
}
    8000133c:	854a                	mv	a0,s2
    8000133e:	70e2                	ld	ra,56(sp)
    80001340:	7442                	ld	s0,48(sp)
    80001342:	74a2                	ld	s1,40(sp)
    80001344:	7902                	ld	s2,32(sp)
    80001346:	69e2                	ld	s3,24(sp)
    80001348:	6a42                	ld	s4,16(sp)
    8000134a:	6aa2                	ld	s5,8(sp)
    8000134c:	6121                	add	sp,sp,64
    8000134e:	8082                	ret
    return -1;
    80001350:	597d                	li	s2,-1
    80001352:	b7ed                	j	8000133c <fork+0x128>

0000000080001354 <scheduler>:
{
    80001354:	7139                	add	sp,sp,-64
    80001356:	fc06                	sd	ra,56(sp)
    80001358:	f822                	sd	s0,48(sp)
    8000135a:	f426                	sd	s1,40(sp)
    8000135c:	f04a                	sd	s2,32(sp)
    8000135e:	ec4e                	sd	s3,24(sp)
    80001360:	e852                	sd	s4,16(sp)
    80001362:	e456                	sd	s5,8(sp)
    80001364:	e05a                	sd	s6,0(sp)
    80001366:	0080                	add	s0,sp,64
    80001368:	8792                	mv	a5,tp
  int id = r_tp();
    8000136a:	2781                	sext.w	a5,a5
  c->proc = 0;
    8000136c:	00779a93          	sll	s5,a5,0x7
    80001370:	00008717          	auipc	a4,0x8
    80001374:	ce070713          	add	a4,a4,-800 # 80009050 <pid_lock>
    80001378:	9756                	add	a4,a4,s5
    8000137a:	02073823          	sd	zero,48(a4)
        swtch(&c->context, &p->context);
    8000137e:	00008717          	auipc	a4,0x8
    80001382:	d0a70713          	add	a4,a4,-758 # 80009088 <cpus+0x8>
    80001386:	9aba                	add	s5,s5,a4
      if(p->state == RUNNABLE) {
    80001388:	498d                	li	s3,3
        p->state = RUNNING;
    8000138a:	4b11                	li	s6,4
        c->proc = p;
    8000138c:	079e                	sll	a5,a5,0x7
    8000138e:	00008a17          	auipc	s4,0x8
    80001392:	cc2a0a13          	add	s4,s4,-830 # 80009050 <pid_lock>
    80001396:	9a3e                	add	s4,s4,a5
    for(p = proc; p < &proc[NPROC]; p++) {
    80001398:	0000e917          	auipc	s2,0xe
    8000139c:	ae890913          	add	s2,s2,-1304 # 8000ee80 <tickslock>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800013a0:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800013a4:	0027e793          	or	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800013a8:	10079073          	csrw	sstatus,a5
    800013ac:	00008497          	auipc	s1,0x8
    800013b0:	0d448493          	add	s1,s1,212 # 80009480 <proc>
    800013b4:	a811                	j	800013c8 <scheduler+0x74>
      release(&p->lock);
    800013b6:	8526                	mv	a0,s1
    800013b8:	00005097          	auipc	ra,0x5
    800013bc:	cae080e7          	jalr	-850(ra) # 80006066 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    800013c0:	16848493          	add	s1,s1,360
    800013c4:	fd248ee3          	beq	s1,s2,800013a0 <scheduler+0x4c>
      acquire(&p->lock);
    800013c8:	8526                	mv	a0,s1
    800013ca:	00005097          	auipc	ra,0x5
    800013ce:	be8080e7          	jalr	-1048(ra) # 80005fb2 <acquire>
      if(p->state == RUNNABLE) {
    800013d2:	4c9c                	lw	a5,24(s1)
    800013d4:	ff3791e3          	bne	a5,s3,800013b6 <scheduler+0x62>
        p->state = RUNNING;
    800013d8:	0164ac23          	sw	s6,24(s1)
        c->proc = p;
    800013dc:	029a3823          	sd	s1,48(s4)
        swtch(&c->context, &p->context);
    800013e0:	06048593          	add	a1,s1,96
    800013e4:	8556                	mv	a0,s5
    800013e6:	00000097          	auipc	ra,0x0
    800013ea:	620080e7          	jalr	1568(ra) # 80001a06 <swtch>
        c->proc = 0;
    800013ee:	020a3823          	sd	zero,48(s4)
    800013f2:	b7d1                	j	800013b6 <scheduler+0x62>

00000000800013f4 <sched>:
{
    800013f4:	7179                	add	sp,sp,-48
    800013f6:	f406                	sd	ra,40(sp)
    800013f8:	f022                	sd	s0,32(sp)
    800013fa:	ec26                	sd	s1,24(sp)
    800013fc:	e84a                	sd	s2,16(sp)
    800013fe:	e44e                	sd	s3,8(sp)
    80001400:	1800                	add	s0,sp,48
  struct proc *p = myproc();
    80001402:	00000097          	auipc	ra,0x0
    80001406:	a40080e7          	jalr	-1472(ra) # 80000e42 <myproc>
    8000140a:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    8000140c:	00005097          	auipc	ra,0x5
    80001410:	b2c080e7          	jalr	-1236(ra) # 80005f38 <holding>
    80001414:	c93d                	beqz	a0,8000148a <sched+0x96>
  asm volatile("mv %0, tp" : "=r" (x) );
    80001416:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    80001418:	2781                	sext.w	a5,a5
    8000141a:	079e                	sll	a5,a5,0x7
    8000141c:	00008717          	auipc	a4,0x8
    80001420:	c3470713          	add	a4,a4,-972 # 80009050 <pid_lock>
    80001424:	97ba                	add	a5,a5,a4
    80001426:	0a87a703          	lw	a4,168(a5)
    8000142a:	4785                	li	a5,1
    8000142c:	06f71763          	bne	a4,a5,8000149a <sched+0xa6>
  if(p->state == RUNNING)
    80001430:	4c98                	lw	a4,24(s1)
    80001432:	4791                	li	a5,4
    80001434:	06f70b63          	beq	a4,a5,800014aa <sched+0xb6>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001438:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    8000143c:	8b89                	and	a5,a5,2
  if(intr_get())
    8000143e:	efb5                	bnez	a5,800014ba <sched+0xc6>
  asm volatile("mv %0, tp" : "=r" (x) );
    80001440:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    80001442:	00008917          	auipc	s2,0x8
    80001446:	c0e90913          	add	s2,s2,-1010 # 80009050 <pid_lock>
    8000144a:	2781                	sext.w	a5,a5
    8000144c:	079e                	sll	a5,a5,0x7
    8000144e:	97ca                	add	a5,a5,s2
    80001450:	0ac7a983          	lw	s3,172(a5)
    80001454:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    80001456:	2781                	sext.w	a5,a5
    80001458:	079e                	sll	a5,a5,0x7
    8000145a:	00008597          	auipc	a1,0x8
    8000145e:	c2e58593          	add	a1,a1,-978 # 80009088 <cpus+0x8>
    80001462:	95be                	add	a1,a1,a5
    80001464:	06048513          	add	a0,s1,96
    80001468:	00000097          	auipc	ra,0x0
    8000146c:	59e080e7          	jalr	1438(ra) # 80001a06 <swtch>
    80001470:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    80001472:	2781                	sext.w	a5,a5
    80001474:	079e                	sll	a5,a5,0x7
    80001476:	993e                	add	s2,s2,a5
    80001478:	0b392623          	sw	s3,172(s2)
}
    8000147c:	70a2                	ld	ra,40(sp)
    8000147e:	7402                	ld	s0,32(sp)
    80001480:	64e2                	ld	s1,24(sp)
    80001482:	6942                	ld	s2,16(sp)
    80001484:	69a2                	ld	s3,8(sp)
    80001486:	6145                	add	sp,sp,48
    80001488:	8082                	ret
    panic("sched p->lock");
    8000148a:	00007517          	auipc	a0,0x7
    8000148e:	d0e50513          	add	a0,a0,-754 # 80008198 <etext+0x198>
    80001492:	00004097          	auipc	ra,0x4
    80001496:	5e8080e7          	jalr	1512(ra) # 80005a7a <panic>
    panic("sched locks");
    8000149a:	00007517          	auipc	a0,0x7
    8000149e:	d0e50513          	add	a0,a0,-754 # 800081a8 <etext+0x1a8>
    800014a2:	00004097          	auipc	ra,0x4
    800014a6:	5d8080e7          	jalr	1496(ra) # 80005a7a <panic>
    panic("sched running");
    800014aa:	00007517          	auipc	a0,0x7
    800014ae:	d0e50513          	add	a0,a0,-754 # 800081b8 <etext+0x1b8>
    800014b2:	00004097          	auipc	ra,0x4
    800014b6:	5c8080e7          	jalr	1480(ra) # 80005a7a <panic>
    panic("sched interruptible");
    800014ba:	00007517          	auipc	a0,0x7
    800014be:	d0e50513          	add	a0,a0,-754 # 800081c8 <etext+0x1c8>
    800014c2:	00004097          	auipc	ra,0x4
    800014c6:	5b8080e7          	jalr	1464(ra) # 80005a7a <panic>

00000000800014ca <yield>:
{
    800014ca:	1101                	add	sp,sp,-32
    800014cc:	ec06                	sd	ra,24(sp)
    800014ce:	e822                	sd	s0,16(sp)
    800014d0:	e426                	sd	s1,8(sp)
    800014d2:	1000                	add	s0,sp,32
  struct proc *p = myproc();
    800014d4:	00000097          	auipc	ra,0x0
    800014d8:	96e080e7          	jalr	-1682(ra) # 80000e42 <myproc>
    800014dc:	84aa                	mv	s1,a0
  acquire(&p->lock);
    800014de:	00005097          	auipc	ra,0x5
    800014e2:	ad4080e7          	jalr	-1324(ra) # 80005fb2 <acquire>
  p->state = RUNNABLE;
    800014e6:	478d                	li	a5,3
    800014e8:	cc9c                	sw	a5,24(s1)
  sched();
    800014ea:	00000097          	auipc	ra,0x0
    800014ee:	f0a080e7          	jalr	-246(ra) # 800013f4 <sched>
  release(&p->lock);
    800014f2:	8526                	mv	a0,s1
    800014f4:	00005097          	auipc	ra,0x5
    800014f8:	b72080e7          	jalr	-1166(ra) # 80006066 <release>
}
    800014fc:	60e2                	ld	ra,24(sp)
    800014fe:	6442                	ld	s0,16(sp)
    80001500:	64a2                	ld	s1,8(sp)
    80001502:	6105                	add	sp,sp,32
    80001504:	8082                	ret

0000000080001506 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    80001506:	7179                	add	sp,sp,-48
    80001508:	f406                	sd	ra,40(sp)
    8000150a:	f022                	sd	s0,32(sp)
    8000150c:	ec26                	sd	s1,24(sp)
    8000150e:	e84a                	sd	s2,16(sp)
    80001510:	e44e                	sd	s3,8(sp)
    80001512:	1800                	add	s0,sp,48
    80001514:	89aa                	mv	s3,a0
    80001516:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80001518:	00000097          	auipc	ra,0x0
    8000151c:	92a080e7          	jalr	-1750(ra) # 80000e42 <myproc>
    80001520:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    80001522:	00005097          	auipc	ra,0x5
    80001526:	a90080e7          	jalr	-1392(ra) # 80005fb2 <acquire>
  release(lk);
    8000152a:	854a                	mv	a0,s2
    8000152c:	00005097          	auipc	ra,0x5
    80001530:	b3a080e7          	jalr	-1222(ra) # 80006066 <release>

  // Go to sleep.
  p->chan = chan;
    80001534:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    80001538:	4789                	li	a5,2
    8000153a:	cc9c                	sw	a5,24(s1)

  sched();
    8000153c:	00000097          	auipc	ra,0x0
    80001540:	eb8080e7          	jalr	-328(ra) # 800013f4 <sched>

  // Tidy up.
  p->chan = 0;
    80001544:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release(&p->lock);
    80001548:	8526                	mv	a0,s1
    8000154a:	00005097          	auipc	ra,0x5
    8000154e:	b1c080e7          	jalr	-1252(ra) # 80006066 <release>
  acquire(lk);
    80001552:	854a                	mv	a0,s2
    80001554:	00005097          	auipc	ra,0x5
    80001558:	a5e080e7          	jalr	-1442(ra) # 80005fb2 <acquire>
}
    8000155c:	70a2                	ld	ra,40(sp)
    8000155e:	7402                	ld	s0,32(sp)
    80001560:	64e2                	ld	s1,24(sp)
    80001562:	6942                	ld	s2,16(sp)
    80001564:	69a2                	ld	s3,8(sp)
    80001566:	6145                	add	sp,sp,48
    80001568:	8082                	ret

000000008000156a <wait>:
{
    8000156a:	715d                	add	sp,sp,-80
    8000156c:	e486                	sd	ra,72(sp)
    8000156e:	e0a2                	sd	s0,64(sp)
    80001570:	fc26                	sd	s1,56(sp)
    80001572:	f84a                	sd	s2,48(sp)
    80001574:	f44e                	sd	s3,40(sp)
    80001576:	f052                	sd	s4,32(sp)
    80001578:	ec56                	sd	s5,24(sp)
    8000157a:	e85a                	sd	s6,16(sp)
    8000157c:	e45e                	sd	s7,8(sp)
    8000157e:	e062                	sd	s8,0(sp)
    80001580:	0880                	add	s0,sp,80
    80001582:	8b2a                	mv	s6,a0
  struct proc *p = myproc();
    80001584:	00000097          	auipc	ra,0x0
    80001588:	8be080e7          	jalr	-1858(ra) # 80000e42 <myproc>
    8000158c:	892a                	mv	s2,a0
  acquire(&wait_lock);
    8000158e:	00008517          	auipc	a0,0x8
    80001592:	ada50513          	add	a0,a0,-1318 # 80009068 <wait_lock>
    80001596:	00005097          	auipc	ra,0x5
    8000159a:	a1c080e7          	jalr	-1508(ra) # 80005fb2 <acquire>
    havekids = 0;
    8000159e:	4b81                	li	s7,0
        if(np->state == ZOMBIE){
    800015a0:	4a15                	li	s4,5
        havekids = 1;
    800015a2:	4a85                	li	s5,1
    for(np = proc; np < &proc[NPROC]; np++){
    800015a4:	0000e997          	auipc	s3,0xe
    800015a8:	8dc98993          	add	s3,s3,-1828 # 8000ee80 <tickslock>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    800015ac:	00008c17          	auipc	s8,0x8
    800015b0:	abcc0c13          	add	s8,s8,-1348 # 80009068 <wait_lock>
    800015b4:	a87d                	j	80001672 <wait+0x108>
          pid = np->pid;
    800015b6:	0304a983          	lw	s3,48(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&np->xstate,
    800015ba:	000b0e63          	beqz	s6,800015d6 <wait+0x6c>
    800015be:	4691                	li	a3,4
    800015c0:	02c48613          	add	a2,s1,44
    800015c4:	85da                	mv	a1,s6
    800015c6:	05093503          	ld	a0,80(s2)
    800015ca:	fffff097          	auipc	ra,0xfffff
    800015ce:	53c080e7          	jalr	1340(ra) # 80000b06 <copyout>
    800015d2:	04054163          	bltz	a0,80001614 <wait+0xaa>
          freeproc(np);
    800015d6:	8526                	mv	a0,s1
    800015d8:	00000097          	auipc	ra,0x0
    800015dc:	a1c080e7          	jalr	-1508(ra) # 80000ff4 <freeproc>
          release(&np->lock);
    800015e0:	8526                	mv	a0,s1
    800015e2:	00005097          	auipc	ra,0x5
    800015e6:	a84080e7          	jalr	-1404(ra) # 80006066 <release>
          release(&wait_lock);
    800015ea:	00008517          	auipc	a0,0x8
    800015ee:	a7e50513          	add	a0,a0,-1410 # 80009068 <wait_lock>
    800015f2:	00005097          	auipc	ra,0x5
    800015f6:	a74080e7          	jalr	-1420(ra) # 80006066 <release>
}
    800015fa:	854e                	mv	a0,s3
    800015fc:	60a6                	ld	ra,72(sp)
    800015fe:	6406                	ld	s0,64(sp)
    80001600:	74e2                	ld	s1,56(sp)
    80001602:	7942                	ld	s2,48(sp)
    80001604:	79a2                	ld	s3,40(sp)
    80001606:	7a02                	ld	s4,32(sp)
    80001608:	6ae2                	ld	s5,24(sp)
    8000160a:	6b42                	ld	s6,16(sp)
    8000160c:	6ba2                	ld	s7,8(sp)
    8000160e:	6c02                	ld	s8,0(sp)
    80001610:	6161                	add	sp,sp,80
    80001612:	8082                	ret
            release(&np->lock);
    80001614:	8526                	mv	a0,s1
    80001616:	00005097          	auipc	ra,0x5
    8000161a:	a50080e7          	jalr	-1456(ra) # 80006066 <release>
            release(&wait_lock);
    8000161e:	00008517          	auipc	a0,0x8
    80001622:	a4a50513          	add	a0,a0,-1462 # 80009068 <wait_lock>
    80001626:	00005097          	auipc	ra,0x5
    8000162a:	a40080e7          	jalr	-1472(ra) # 80006066 <release>
            return -1;
    8000162e:	59fd                	li	s3,-1
    80001630:	b7e9                	j	800015fa <wait+0x90>
    for(np = proc; np < &proc[NPROC]; np++){
    80001632:	16848493          	add	s1,s1,360
    80001636:	03348463          	beq	s1,s3,8000165e <wait+0xf4>
      if(np->parent == p){
    8000163a:	7c9c                	ld	a5,56(s1)
    8000163c:	ff279be3          	bne	a5,s2,80001632 <wait+0xc8>
        acquire(&np->lock);
    80001640:	8526                	mv	a0,s1
    80001642:	00005097          	auipc	ra,0x5
    80001646:	970080e7          	jalr	-1680(ra) # 80005fb2 <acquire>
        if(np->state == ZOMBIE){
    8000164a:	4c9c                	lw	a5,24(s1)
    8000164c:	f74785e3          	beq	a5,s4,800015b6 <wait+0x4c>
        release(&np->lock);
    80001650:	8526                	mv	a0,s1
    80001652:	00005097          	auipc	ra,0x5
    80001656:	a14080e7          	jalr	-1516(ra) # 80006066 <release>
        havekids = 1;
    8000165a:	8756                	mv	a4,s5
    8000165c:	bfd9                	j	80001632 <wait+0xc8>
    if(!havekids || p->killed){
    8000165e:	c305                	beqz	a4,8000167e <wait+0x114>
    80001660:	02892783          	lw	a5,40(s2)
    80001664:	ef89                	bnez	a5,8000167e <wait+0x114>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80001666:	85e2                	mv	a1,s8
    80001668:	854a                	mv	a0,s2
    8000166a:	00000097          	auipc	ra,0x0
    8000166e:	e9c080e7          	jalr	-356(ra) # 80001506 <sleep>
    havekids = 0;
    80001672:	875e                	mv	a4,s7
    for(np = proc; np < &proc[NPROC]; np++){
    80001674:	00008497          	auipc	s1,0x8
    80001678:	e0c48493          	add	s1,s1,-500 # 80009480 <proc>
    8000167c:	bf7d                	j	8000163a <wait+0xd0>
      release(&wait_lock);
    8000167e:	00008517          	auipc	a0,0x8
    80001682:	9ea50513          	add	a0,a0,-1558 # 80009068 <wait_lock>
    80001686:	00005097          	auipc	ra,0x5
    8000168a:	9e0080e7          	jalr	-1568(ra) # 80006066 <release>
      return -1;
    8000168e:	59fd                	li	s3,-1
    80001690:	b7ad                	j	800015fa <wait+0x90>

0000000080001692 <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    80001692:	7139                	add	sp,sp,-64
    80001694:	fc06                	sd	ra,56(sp)
    80001696:	f822                	sd	s0,48(sp)
    80001698:	f426                	sd	s1,40(sp)
    8000169a:	f04a                	sd	s2,32(sp)
    8000169c:	ec4e                	sd	s3,24(sp)
    8000169e:	e852                	sd	s4,16(sp)
    800016a0:	e456                	sd	s5,8(sp)
    800016a2:	0080                	add	s0,sp,64
    800016a4:	8a2a                	mv	s4,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    800016a6:	00008497          	auipc	s1,0x8
    800016aa:	dda48493          	add	s1,s1,-550 # 80009480 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    800016ae:	4989                	li	s3,2
        p->state = RUNNABLE;
    800016b0:	4a8d                	li	s5,3
  for(p = proc; p < &proc[NPROC]; p++) {
    800016b2:	0000d917          	auipc	s2,0xd
    800016b6:	7ce90913          	add	s2,s2,1998 # 8000ee80 <tickslock>
    800016ba:	a811                	j	800016ce <wakeup+0x3c>
      }
      release(&p->lock);
    800016bc:	8526                	mv	a0,s1
    800016be:	00005097          	auipc	ra,0x5
    800016c2:	9a8080e7          	jalr	-1624(ra) # 80006066 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    800016c6:	16848493          	add	s1,s1,360
    800016ca:	03248663          	beq	s1,s2,800016f6 <wakeup+0x64>
    if(p != myproc()){
    800016ce:	fffff097          	auipc	ra,0xfffff
    800016d2:	774080e7          	jalr	1908(ra) # 80000e42 <myproc>
    800016d6:	fea488e3          	beq	s1,a0,800016c6 <wakeup+0x34>
      acquire(&p->lock);
    800016da:	8526                	mv	a0,s1
    800016dc:	00005097          	auipc	ra,0x5
    800016e0:	8d6080e7          	jalr	-1834(ra) # 80005fb2 <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    800016e4:	4c9c                	lw	a5,24(s1)
    800016e6:	fd379be3          	bne	a5,s3,800016bc <wakeup+0x2a>
    800016ea:	709c                	ld	a5,32(s1)
    800016ec:	fd4798e3          	bne	a5,s4,800016bc <wakeup+0x2a>
        p->state = RUNNABLE;
    800016f0:	0154ac23          	sw	s5,24(s1)
    800016f4:	b7e1                	j	800016bc <wakeup+0x2a>
    }
  }
}
    800016f6:	70e2                	ld	ra,56(sp)
    800016f8:	7442                	ld	s0,48(sp)
    800016fa:	74a2                	ld	s1,40(sp)
    800016fc:	7902                	ld	s2,32(sp)
    800016fe:	69e2                	ld	s3,24(sp)
    80001700:	6a42                	ld	s4,16(sp)
    80001702:	6aa2                	ld	s5,8(sp)
    80001704:	6121                	add	sp,sp,64
    80001706:	8082                	ret

0000000080001708 <reparent>:
{
    80001708:	7179                	add	sp,sp,-48
    8000170a:	f406                	sd	ra,40(sp)
    8000170c:	f022                	sd	s0,32(sp)
    8000170e:	ec26                	sd	s1,24(sp)
    80001710:	e84a                	sd	s2,16(sp)
    80001712:	e44e                	sd	s3,8(sp)
    80001714:	e052                	sd	s4,0(sp)
    80001716:	1800                	add	s0,sp,48
    80001718:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    8000171a:	00008497          	auipc	s1,0x8
    8000171e:	d6648493          	add	s1,s1,-666 # 80009480 <proc>
      pp->parent = initproc;
    80001722:	00008a17          	auipc	s4,0x8
    80001726:	8eea0a13          	add	s4,s4,-1810 # 80009010 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    8000172a:	0000d997          	auipc	s3,0xd
    8000172e:	75698993          	add	s3,s3,1878 # 8000ee80 <tickslock>
    80001732:	a029                	j	8000173c <reparent+0x34>
    80001734:	16848493          	add	s1,s1,360
    80001738:	01348d63          	beq	s1,s3,80001752 <reparent+0x4a>
    if(pp->parent == p){
    8000173c:	7c9c                	ld	a5,56(s1)
    8000173e:	ff279be3          	bne	a5,s2,80001734 <reparent+0x2c>
      pp->parent = initproc;
    80001742:	000a3503          	ld	a0,0(s4)
    80001746:	fc88                	sd	a0,56(s1)
      wakeup(initproc);
    80001748:	00000097          	auipc	ra,0x0
    8000174c:	f4a080e7          	jalr	-182(ra) # 80001692 <wakeup>
    80001750:	b7d5                	j	80001734 <reparent+0x2c>
}
    80001752:	70a2                	ld	ra,40(sp)
    80001754:	7402                	ld	s0,32(sp)
    80001756:	64e2                	ld	s1,24(sp)
    80001758:	6942                	ld	s2,16(sp)
    8000175a:	69a2                	ld	s3,8(sp)
    8000175c:	6a02                	ld	s4,0(sp)
    8000175e:	6145                	add	sp,sp,48
    80001760:	8082                	ret

0000000080001762 <exit>:
{
    80001762:	7179                	add	sp,sp,-48
    80001764:	f406                	sd	ra,40(sp)
    80001766:	f022                	sd	s0,32(sp)
    80001768:	ec26                	sd	s1,24(sp)
    8000176a:	e84a                	sd	s2,16(sp)
    8000176c:	e44e                	sd	s3,8(sp)
    8000176e:	e052                	sd	s4,0(sp)
    80001770:	1800                	add	s0,sp,48
    80001772:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    80001774:	fffff097          	auipc	ra,0xfffff
    80001778:	6ce080e7          	jalr	1742(ra) # 80000e42 <myproc>
    8000177c:	89aa                	mv	s3,a0
  if(p == initproc)
    8000177e:	00008797          	auipc	a5,0x8
    80001782:	8927b783          	ld	a5,-1902(a5) # 80009010 <initproc>
    80001786:	0d050493          	add	s1,a0,208
    8000178a:	15050913          	add	s2,a0,336
    8000178e:	02a79363          	bne	a5,a0,800017b4 <exit+0x52>
    panic("init exiting");
    80001792:	00007517          	auipc	a0,0x7
    80001796:	a4e50513          	add	a0,a0,-1458 # 800081e0 <etext+0x1e0>
    8000179a:	00004097          	auipc	ra,0x4
    8000179e:	2e0080e7          	jalr	736(ra) # 80005a7a <panic>
      fileclose(f);
    800017a2:	00002097          	auipc	ra,0x2
    800017a6:	13e080e7          	jalr	318(ra) # 800038e0 <fileclose>
      p->ofile[fd] = 0;
    800017aa:	0004b023          	sd	zero,0(s1)
  for(int fd = 0; fd < NOFILE; fd++){
    800017ae:	04a1                	add	s1,s1,8
    800017b0:	01248563          	beq	s1,s2,800017ba <exit+0x58>
    if(p->ofile[fd]){
    800017b4:	6088                	ld	a0,0(s1)
    800017b6:	f575                	bnez	a0,800017a2 <exit+0x40>
    800017b8:	bfdd                	j	800017ae <exit+0x4c>
  begin_op();
    800017ba:	00002097          	auipc	ra,0x2
    800017be:	c62080e7          	jalr	-926(ra) # 8000341c <begin_op>
  iput(p->cwd);
    800017c2:	1509b503          	ld	a0,336(s3)
    800017c6:	00001097          	auipc	ra,0x1
    800017ca:	45a080e7          	jalr	1114(ra) # 80002c20 <iput>
  end_op();
    800017ce:	00002097          	auipc	ra,0x2
    800017d2:	cc8080e7          	jalr	-824(ra) # 80003496 <end_op>
  p->cwd = 0;
    800017d6:	1409b823          	sd	zero,336(s3)
  acquire(&wait_lock);
    800017da:	00008497          	auipc	s1,0x8
    800017de:	88e48493          	add	s1,s1,-1906 # 80009068 <wait_lock>
    800017e2:	8526                	mv	a0,s1
    800017e4:	00004097          	auipc	ra,0x4
    800017e8:	7ce080e7          	jalr	1998(ra) # 80005fb2 <acquire>
  reparent(p);
    800017ec:	854e                	mv	a0,s3
    800017ee:	00000097          	auipc	ra,0x0
    800017f2:	f1a080e7          	jalr	-230(ra) # 80001708 <reparent>
  wakeup(p->parent);
    800017f6:	0389b503          	ld	a0,56(s3)
    800017fa:	00000097          	auipc	ra,0x0
    800017fe:	e98080e7          	jalr	-360(ra) # 80001692 <wakeup>
  acquire(&p->lock);
    80001802:	854e                	mv	a0,s3
    80001804:	00004097          	auipc	ra,0x4
    80001808:	7ae080e7          	jalr	1966(ra) # 80005fb2 <acquire>
  p->xstate = status;
    8000180c:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    80001810:	4795                	li	a5,5
    80001812:	00f9ac23          	sw	a5,24(s3)
  release(&wait_lock);
    80001816:	8526                	mv	a0,s1
    80001818:	00005097          	auipc	ra,0x5
    8000181c:	84e080e7          	jalr	-1970(ra) # 80006066 <release>
  sched();
    80001820:	00000097          	auipc	ra,0x0
    80001824:	bd4080e7          	jalr	-1068(ra) # 800013f4 <sched>
  panic("zombie exit");
    80001828:	00007517          	auipc	a0,0x7
    8000182c:	9c850513          	add	a0,a0,-1592 # 800081f0 <etext+0x1f0>
    80001830:	00004097          	auipc	ra,0x4
    80001834:	24a080e7          	jalr	586(ra) # 80005a7a <panic>

0000000080001838 <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    80001838:	7179                	add	sp,sp,-48
    8000183a:	f406                	sd	ra,40(sp)
    8000183c:	f022                	sd	s0,32(sp)
    8000183e:	ec26                	sd	s1,24(sp)
    80001840:	e84a                	sd	s2,16(sp)
    80001842:	e44e                	sd	s3,8(sp)
    80001844:	1800                	add	s0,sp,48
    80001846:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    80001848:	00008497          	auipc	s1,0x8
    8000184c:	c3848493          	add	s1,s1,-968 # 80009480 <proc>
    80001850:	0000d997          	auipc	s3,0xd
    80001854:	63098993          	add	s3,s3,1584 # 8000ee80 <tickslock>
    acquire(&p->lock);
    80001858:	8526                	mv	a0,s1
    8000185a:	00004097          	auipc	ra,0x4
    8000185e:	758080e7          	jalr	1880(ra) # 80005fb2 <acquire>
    if(p->pid == pid){
    80001862:	589c                	lw	a5,48(s1)
    80001864:	01278d63          	beq	a5,s2,8000187e <kill+0x46>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    80001868:	8526                	mv	a0,s1
    8000186a:	00004097          	auipc	ra,0x4
    8000186e:	7fc080e7          	jalr	2044(ra) # 80006066 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    80001872:	16848493          	add	s1,s1,360
    80001876:	ff3491e3          	bne	s1,s3,80001858 <kill+0x20>
  }
  return -1;
    8000187a:	557d                	li	a0,-1
    8000187c:	a829                	j	80001896 <kill+0x5e>
      p->killed = 1;
    8000187e:	4785                	li	a5,1
    80001880:	d49c                	sw	a5,40(s1)
      if(p->state == SLEEPING){
    80001882:	4c98                	lw	a4,24(s1)
    80001884:	4789                	li	a5,2
    80001886:	00f70f63          	beq	a4,a5,800018a4 <kill+0x6c>
      release(&p->lock);
    8000188a:	8526                	mv	a0,s1
    8000188c:	00004097          	auipc	ra,0x4
    80001890:	7da080e7          	jalr	2010(ra) # 80006066 <release>
      return 0;
    80001894:	4501                	li	a0,0
}
    80001896:	70a2                	ld	ra,40(sp)
    80001898:	7402                	ld	s0,32(sp)
    8000189a:	64e2                	ld	s1,24(sp)
    8000189c:	6942                	ld	s2,16(sp)
    8000189e:	69a2                	ld	s3,8(sp)
    800018a0:	6145                	add	sp,sp,48
    800018a2:	8082                	ret
        p->state = RUNNABLE;
    800018a4:	478d                	li	a5,3
    800018a6:	cc9c                	sw	a5,24(s1)
    800018a8:	b7cd                	j	8000188a <kill+0x52>

00000000800018aa <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    800018aa:	7179                	add	sp,sp,-48
    800018ac:	f406                	sd	ra,40(sp)
    800018ae:	f022                	sd	s0,32(sp)
    800018b0:	ec26                	sd	s1,24(sp)
    800018b2:	e84a                	sd	s2,16(sp)
    800018b4:	e44e                	sd	s3,8(sp)
    800018b6:	e052                	sd	s4,0(sp)
    800018b8:	1800                	add	s0,sp,48
    800018ba:	84aa                	mv	s1,a0
    800018bc:	892e                	mv	s2,a1
    800018be:	89b2                	mv	s3,a2
    800018c0:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    800018c2:	fffff097          	auipc	ra,0xfffff
    800018c6:	580080e7          	jalr	1408(ra) # 80000e42 <myproc>
  if(user_dst){
    800018ca:	c08d                	beqz	s1,800018ec <either_copyout+0x42>
    return copyout(p->pagetable, dst, src, len);
    800018cc:	86d2                	mv	a3,s4
    800018ce:	864e                	mv	a2,s3
    800018d0:	85ca                	mv	a1,s2
    800018d2:	6928                	ld	a0,80(a0)
    800018d4:	fffff097          	auipc	ra,0xfffff
    800018d8:	232080e7          	jalr	562(ra) # 80000b06 <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    800018dc:	70a2                	ld	ra,40(sp)
    800018de:	7402                	ld	s0,32(sp)
    800018e0:	64e2                	ld	s1,24(sp)
    800018e2:	6942                	ld	s2,16(sp)
    800018e4:	69a2                	ld	s3,8(sp)
    800018e6:	6a02                	ld	s4,0(sp)
    800018e8:	6145                	add	sp,sp,48
    800018ea:	8082                	ret
    memmove((char *)dst, src, len);
    800018ec:	000a061b          	sext.w	a2,s4
    800018f0:	85ce                	mv	a1,s3
    800018f2:	854a                	mv	a0,s2
    800018f4:	fffff097          	auipc	ra,0xfffff
    800018f8:	8e2080e7          	jalr	-1822(ra) # 800001d6 <memmove>
    return 0;
    800018fc:	8526                	mv	a0,s1
    800018fe:	bff9                	j	800018dc <either_copyout+0x32>

0000000080001900 <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    80001900:	7179                	add	sp,sp,-48
    80001902:	f406                	sd	ra,40(sp)
    80001904:	f022                	sd	s0,32(sp)
    80001906:	ec26                	sd	s1,24(sp)
    80001908:	e84a                	sd	s2,16(sp)
    8000190a:	e44e                	sd	s3,8(sp)
    8000190c:	e052                	sd	s4,0(sp)
    8000190e:	1800                	add	s0,sp,48
    80001910:	892a                	mv	s2,a0
    80001912:	84ae                	mv	s1,a1
    80001914:	89b2                	mv	s3,a2
    80001916:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80001918:	fffff097          	auipc	ra,0xfffff
    8000191c:	52a080e7          	jalr	1322(ra) # 80000e42 <myproc>
  if(user_src){
    80001920:	c08d                	beqz	s1,80001942 <either_copyin+0x42>
    return copyin(p->pagetable, dst, src, len);
    80001922:	86d2                	mv	a3,s4
    80001924:	864e                	mv	a2,s3
    80001926:	85ca                	mv	a1,s2
    80001928:	6928                	ld	a0,80(a0)
    8000192a:	fffff097          	auipc	ra,0xfffff
    8000192e:	268080e7          	jalr	616(ra) # 80000b92 <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    80001932:	70a2                	ld	ra,40(sp)
    80001934:	7402                	ld	s0,32(sp)
    80001936:	64e2                	ld	s1,24(sp)
    80001938:	6942                	ld	s2,16(sp)
    8000193a:	69a2                	ld	s3,8(sp)
    8000193c:	6a02                	ld	s4,0(sp)
    8000193e:	6145                	add	sp,sp,48
    80001940:	8082                	ret
    memmove(dst, (char*)src, len);
    80001942:	000a061b          	sext.w	a2,s4
    80001946:	85ce                	mv	a1,s3
    80001948:	854a                	mv	a0,s2
    8000194a:	fffff097          	auipc	ra,0xfffff
    8000194e:	88c080e7          	jalr	-1908(ra) # 800001d6 <memmove>
    return 0;
    80001952:	8526                	mv	a0,s1
    80001954:	bff9                	j	80001932 <either_copyin+0x32>

0000000080001956 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80001956:	715d                	add	sp,sp,-80
    80001958:	e486                	sd	ra,72(sp)
    8000195a:	e0a2                	sd	s0,64(sp)
    8000195c:	fc26                	sd	s1,56(sp)
    8000195e:	f84a                	sd	s2,48(sp)
    80001960:	f44e                	sd	s3,40(sp)
    80001962:	f052                	sd	s4,32(sp)
    80001964:	ec56                	sd	s5,24(sp)
    80001966:	e85a                	sd	s6,16(sp)
    80001968:	e45e                	sd	s7,8(sp)
    8000196a:	0880                	add	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    8000196c:	00006517          	auipc	a0,0x6
    80001970:	6dc50513          	add	a0,a0,1756 # 80008048 <etext+0x48>
    80001974:	00004097          	auipc	ra,0x4
    80001978:	150080e7          	jalr	336(ra) # 80005ac4 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    8000197c:	00008497          	auipc	s1,0x8
    80001980:	c5c48493          	add	s1,s1,-932 # 800095d8 <proc+0x158>
    80001984:	0000d917          	auipc	s2,0xd
    80001988:	65490913          	add	s2,s2,1620 # 8000efd8 <bcache+0x140>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    8000198c:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    8000198e:	00007997          	auipc	s3,0x7
    80001992:	87298993          	add	s3,s3,-1934 # 80008200 <etext+0x200>
    printf("%d %s %s", p->pid, state, p->name);
    80001996:	00007a97          	auipc	s5,0x7
    8000199a:	872a8a93          	add	s5,s5,-1934 # 80008208 <etext+0x208>
    printf("\n");
    8000199e:	00006a17          	auipc	s4,0x6
    800019a2:	6aaa0a13          	add	s4,s4,1706 # 80008048 <etext+0x48>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    800019a6:	00007b97          	auipc	s7,0x7
    800019aa:	89ab8b93          	add	s7,s7,-1894 # 80008240 <states.0>
    800019ae:	a00d                	j	800019d0 <procdump+0x7a>
    printf("%d %s %s", p->pid, state, p->name);
    800019b0:	ed86a583          	lw	a1,-296(a3)
    800019b4:	8556                	mv	a0,s5
    800019b6:	00004097          	auipc	ra,0x4
    800019ba:	10e080e7          	jalr	270(ra) # 80005ac4 <printf>
    printf("\n");
    800019be:	8552                	mv	a0,s4
    800019c0:	00004097          	auipc	ra,0x4
    800019c4:	104080e7          	jalr	260(ra) # 80005ac4 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    800019c8:	16848493          	add	s1,s1,360
    800019cc:	03248263          	beq	s1,s2,800019f0 <procdump+0x9a>
    if(p->state == UNUSED)
    800019d0:	86a6                	mv	a3,s1
    800019d2:	ec04a783          	lw	a5,-320(s1)
    800019d6:	dbed                	beqz	a5,800019c8 <procdump+0x72>
      state = "???";
    800019d8:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    800019da:	fcfb6be3          	bltu	s6,a5,800019b0 <procdump+0x5a>
    800019de:	02079713          	sll	a4,a5,0x20
    800019e2:	01d75793          	srl	a5,a4,0x1d
    800019e6:	97de                	add	a5,a5,s7
    800019e8:	6390                	ld	a2,0(a5)
    800019ea:	f279                	bnez	a2,800019b0 <procdump+0x5a>
      state = "???";
    800019ec:	864e                	mv	a2,s3
    800019ee:	b7c9                	j	800019b0 <procdump+0x5a>
  }
}
    800019f0:	60a6                	ld	ra,72(sp)
    800019f2:	6406                	ld	s0,64(sp)
    800019f4:	74e2                	ld	s1,56(sp)
    800019f6:	7942                	ld	s2,48(sp)
    800019f8:	79a2                	ld	s3,40(sp)
    800019fa:	7a02                	ld	s4,32(sp)
    800019fc:	6ae2                	ld	s5,24(sp)
    800019fe:	6b42                	ld	s6,16(sp)
    80001a00:	6ba2                	ld	s7,8(sp)
    80001a02:	6161                	add	sp,sp,80
    80001a04:	8082                	ret

0000000080001a06 <swtch>:
    80001a06:	00153023          	sd	ra,0(a0)
    80001a0a:	00253423          	sd	sp,8(a0)
    80001a0e:	e900                	sd	s0,16(a0)
    80001a10:	ed04                	sd	s1,24(a0)
    80001a12:	03253023          	sd	s2,32(a0)
    80001a16:	03353423          	sd	s3,40(a0)
    80001a1a:	03453823          	sd	s4,48(a0)
    80001a1e:	03553c23          	sd	s5,56(a0)
    80001a22:	05653023          	sd	s6,64(a0)
    80001a26:	05753423          	sd	s7,72(a0)
    80001a2a:	05853823          	sd	s8,80(a0)
    80001a2e:	05953c23          	sd	s9,88(a0)
    80001a32:	07a53023          	sd	s10,96(a0)
    80001a36:	07b53423          	sd	s11,104(a0)
    80001a3a:	0005b083          	ld	ra,0(a1)
    80001a3e:	0085b103          	ld	sp,8(a1)
    80001a42:	6980                	ld	s0,16(a1)
    80001a44:	6d84                	ld	s1,24(a1)
    80001a46:	0205b903          	ld	s2,32(a1)
    80001a4a:	0285b983          	ld	s3,40(a1)
    80001a4e:	0305ba03          	ld	s4,48(a1)
    80001a52:	0385ba83          	ld	s5,56(a1)
    80001a56:	0405bb03          	ld	s6,64(a1)
    80001a5a:	0485bb83          	ld	s7,72(a1)
    80001a5e:	0505bc03          	ld	s8,80(a1)
    80001a62:	0585bc83          	ld	s9,88(a1)
    80001a66:	0605bd03          	ld	s10,96(a1)
    80001a6a:	0685bd83          	ld	s11,104(a1)
    80001a6e:	8082                	ret

0000000080001a70 <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80001a70:	1141                	add	sp,sp,-16
    80001a72:	e406                	sd	ra,8(sp)
    80001a74:	e022                	sd	s0,0(sp)
    80001a76:	0800                	add	s0,sp,16
  initlock(&tickslock, "time");
    80001a78:	00006597          	auipc	a1,0x6
    80001a7c:	7f858593          	add	a1,a1,2040 # 80008270 <states.0+0x30>
    80001a80:	0000d517          	auipc	a0,0xd
    80001a84:	40050513          	add	a0,a0,1024 # 8000ee80 <tickslock>
    80001a88:	00004097          	auipc	ra,0x4
    80001a8c:	49a080e7          	jalr	1178(ra) # 80005f22 <initlock>
}
    80001a90:	60a2                	ld	ra,8(sp)
    80001a92:	6402                	ld	s0,0(sp)
    80001a94:	0141                	add	sp,sp,16
    80001a96:	8082                	ret

0000000080001a98 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80001a98:	1141                	add	sp,sp,-16
    80001a9a:	e422                	sd	s0,8(sp)
    80001a9c:	0800                	add	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001a9e:	00003797          	auipc	a5,0x3
    80001aa2:	44278793          	add	a5,a5,1090 # 80004ee0 <kernelvec>
    80001aa6:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    80001aaa:	6422                	ld	s0,8(sp)
    80001aac:	0141                	add	sp,sp,16
    80001aae:	8082                	ret

0000000080001ab0 <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80001ab0:	1141                	add	sp,sp,-16
    80001ab2:	e406                	sd	ra,8(sp)
    80001ab4:	e022                	sd	s0,0(sp)
    80001ab6:	0800                	add	s0,sp,16
  struct proc *p = myproc();
    80001ab8:	fffff097          	auipc	ra,0xfffff
    80001abc:	38a080e7          	jalr	906(ra) # 80000e42 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001ac0:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80001ac4:	9bf5                	and	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001ac6:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to trampoline.S
  w_stvec(TRAMPOLINE + (uservec - trampoline));
    80001aca:	00005697          	auipc	a3,0x5
    80001ace:	53668693          	add	a3,a3,1334 # 80007000 <_trampoline>
    80001ad2:	00005717          	auipc	a4,0x5
    80001ad6:	52e70713          	add	a4,a4,1326 # 80007000 <_trampoline>
    80001ada:	8f15                	sub	a4,a4,a3
    80001adc:	040007b7          	lui	a5,0x4000
    80001ae0:	17fd                	add	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    80001ae2:	07b2                	sll	a5,a5,0xc
    80001ae4:	973e                	add	a4,a4,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001ae6:	10571073          	csrw	stvec,a4

  // set up trapframe values that uservec will need when
  // the process next re-enters the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80001aea:	6d38                	ld	a4,88(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    80001aec:	18002673          	csrr	a2,satp
    80001af0:	e310                	sd	a2,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80001af2:	6d30                	ld	a2,88(a0)
    80001af4:	6138                	ld	a4,64(a0)
    80001af6:	6585                	lui	a1,0x1
    80001af8:	972e                	add	a4,a4,a1
    80001afa:	e618                	sd	a4,8(a2)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80001afc:	6d38                	ld	a4,88(a0)
    80001afe:	00000617          	auipc	a2,0x0
    80001b02:	13c60613          	add	a2,a2,316 # 80001c3a <usertrap>
    80001b06:	eb10                	sd	a2,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80001b08:	6d38                	ld	a4,88(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    80001b0a:	8612                	mv	a2,tp
    80001b0c:	f310                	sd	a2,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001b0e:	10002773          	csrr	a4,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80001b12:	eff77713          	and	a4,a4,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80001b16:	02076713          	or	a4,a4,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001b1a:	10071073          	csrw	sstatus,a4
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80001b1e:	6d38                	ld	a4,88(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001b20:	6f18                	ld	a4,24(a4)
    80001b22:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80001b26:	692c                	ld	a1,80(a0)
    80001b28:	81b1                	srl	a1,a1,0xc

  // jump to trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 fn = TRAMPOLINE + (userret - trampoline);
    80001b2a:	00005717          	auipc	a4,0x5
    80001b2e:	56670713          	add	a4,a4,1382 # 80007090 <userret>
    80001b32:	8f15                	sub	a4,a4,a3
    80001b34:	97ba                	add	a5,a5,a4
  ((void (*)(uint64,uint64))fn)(TRAPFRAME, satp);
    80001b36:	577d                	li	a4,-1
    80001b38:	177e                	sll	a4,a4,0x3f
    80001b3a:	8dd9                	or	a1,a1,a4
    80001b3c:	02000537          	lui	a0,0x2000
    80001b40:	157d                	add	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    80001b42:	0536                	sll	a0,a0,0xd
    80001b44:	9782                	jalr	a5
}
    80001b46:	60a2                	ld	ra,8(sp)
    80001b48:	6402                	ld	s0,0(sp)
    80001b4a:	0141                	add	sp,sp,16
    80001b4c:	8082                	ret

0000000080001b4e <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    80001b4e:	1101                	add	sp,sp,-32
    80001b50:	ec06                	sd	ra,24(sp)
    80001b52:	e822                	sd	s0,16(sp)
    80001b54:	e426                	sd	s1,8(sp)
    80001b56:	1000                	add	s0,sp,32
  acquire(&tickslock);
    80001b58:	0000d497          	auipc	s1,0xd
    80001b5c:	32848493          	add	s1,s1,808 # 8000ee80 <tickslock>
    80001b60:	8526                	mv	a0,s1
    80001b62:	00004097          	auipc	ra,0x4
    80001b66:	450080e7          	jalr	1104(ra) # 80005fb2 <acquire>
  ticks++;
    80001b6a:	00007517          	auipc	a0,0x7
    80001b6e:	4ae50513          	add	a0,a0,1198 # 80009018 <ticks>
    80001b72:	411c                	lw	a5,0(a0)
    80001b74:	2785                	addw	a5,a5,1
    80001b76:	c11c                	sw	a5,0(a0)
  wakeup(&ticks);
    80001b78:	00000097          	auipc	ra,0x0
    80001b7c:	b1a080e7          	jalr	-1254(ra) # 80001692 <wakeup>
  release(&tickslock);
    80001b80:	8526                	mv	a0,s1
    80001b82:	00004097          	auipc	ra,0x4
    80001b86:	4e4080e7          	jalr	1252(ra) # 80006066 <release>
}
    80001b8a:	60e2                	ld	ra,24(sp)
    80001b8c:	6442                	ld	s0,16(sp)
    80001b8e:	64a2                	ld	s1,8(sp)
    80001b90:	6105                	add	sp,sp,32
    80001b92:	8082                	ret

0000000080001b94 <devintr>:
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001b94:	142027f3          	csrr	a5,scause
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);

    return 2;
  } else {
    return 0;
    80001b98:	4501                	li	a0,0
  if((scause & 0x8000000000000000L) &&
    80001b9a:	0807df63          	bgez	a5,80001c38 <devintr+0xa4>
{
    80001b9e:	1101                	add	sp,sp,-32
    80001ba0:	ec06                	sd	ra,24(sp)
    80001ba2:	e822                	sd	s0,16(sp)
    80001ba4:	e426                	sd	s1,8(sp)
    80001ba6:	1000                	add	s0,sp,32
     (scause & 0xff) == 9){
    80001ba8:	0ff7f713          	zext.b	a4,a5
  if((scause & 0x8000000000000000L) &&
    80001bac:	46a5                	li	a3,9
    80001bae:	00d70d63          	beq	a4,a3,80001bc8 <devintr+0x34>
  } else if(scause == 0x8000000000000001L){
    80001bb2:	577d                	li	a4,-1
    80001bb4:	177e                	sll	a4,a4,0x3f
    80001bb6:	0705                	add	a4,a4,1
    return 0;
    80001bb8:	4501                	li	a0,0
  } else if(scause == 0x8000000000000001L){
    80001bba:	04e78e63          	beq	a5,a4,80001c16 <devintr+0x82>
  }
}
    80001bbe:	60e2                	ld	ra,24(sp)
    80001bc0:	6442                	ld	s0,16(sp)
    80001bc2:	64a2                	ld	s1,8(sp)
    80001bc4:	6105                	add	sp,sp,32
    80001bc6:	8082                	ret
    int irq = plic_claim();
    80001bc8:	00003097          	auipc	ra,0x3
    80001bcc:	420080e7          	jalr	1056(ra) # 80004fe8 <plic_claim>
    80001bd0:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    80001bd2:	47a9                	li	a5,10
    80001bd4:	02f50763          	beq	a0,a5,80001c02 <devintr+0x6e>
    } else if(irq == VIRTIO0_IRQ){
    80001bd8:	4785                	li	a5,1
    80001bda:	02f50963          	beq	a0,a5,80001c0c <devintr+0x78>
    return 1;
    80001bde:	4505                	li	a0,1
    } else if(irq){
    80001be0:	dcf9                	beqz	s1,80001bbe <devintr+0x2a>
      printf("unexpected interrupt irq=%d\n", irq);
    80001be2:	85a6                	mv	a1,s1
    80001be4:	00006517          	auipc	a0,0x6
    80001be8:	69450513          	add	a0,a0,1684 # 80008278 <states.0+0x38>
    80001bec:	00004097          	auipc	ra,0x4
    80001bf0:	ed8080e7          	jalr	-296(ra) # 80005ac4 <printf>
      plic_complete(irq);
    80001bf4:	8526                	mv	a0,s1
    80001bf6:	00003097          	auipc	ra,0x3
    80001bfa:	416080e7          	jalr	1046(ra) # 8000500c <plic_complete>
    return 1;
    80001bfe:	4505                	li	a0,1
    80001c00:	bf7d                	j	80001bbe <devintr+0x2a>
      uartintr();
    80001c02:	00004097          	auipc	ra,0x4
    80001c06:	2d0080e7          	jalr	720(ra) # 80005ed2 <uartintr>
    if(irq)
    80001c0a:	b7ed                	j	80001bf4 <devintr+0x60>
      virtio_disk_intr();
    80001c0c:	00004097          	auipc	ra,0x4
    80001c10:	88a080e7          	jalr	-1910(ra) # 80005496 <virtio_disk_intr>
    if(irq)
    80001c14:	b7c5                	j	80001bf4 <devintr+0x60>
    if(cpuid() == 0){
    80001c16:	fffff097          	auipc	ra,0xfffff
    80001c1a:	200080e7          	jalr	512(ra) # 80000e16 <cpuid>
    80001c1e:	c901                	beqz	a0,80001c2e <devintr+0x9a>
  asm volatile("csrr %0, sip" : "=r" (x) );
    80001c20:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    80001c24:	9bf5                	and	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    80001c26:	14479073          	csrw	sip,a5
    return 2;
    80001c2a:	4509                	li	a0,2
    80001c2c:	bf49                	j	80001bbe <devintr+0x2a>
      clockintr();
    80001c2e:	00000097          	auipc	ra,0x0
    80001c32:	f20080e7          	jalr	-224(ra) # 80001b4e <clockintr>
    80001c36:	b7ed                	j	80001c20 <devintr+0x8c>
}
    80001c38:	8082                	ret

0000000080001c3a <usertrap>:
{
    80001c3a:	1101                	add	sp,sp,-32
    80001c3c:	ec06                	sd	ra,24(sp)
    80001c3e:	e822                	sd	s0,16(sp)
    80001c40:	e426                	sd	s1,8(sp)
    80001c42:	e04a                	sd	s2,0(sp)
    80001c44:	1000                	add	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001c46:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    80001c4a:	1007f793          	and	a5,a5,256
    80001c4e:	e3ad                	bnez	a5,80001cb0 <usertrap+0x76>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001c50:	00003797          	auipc	a5,0x3
    80001c54:	29078793          	add	a5,a5,656 # 80004ee0 <kernelvec>
    80001c58:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    80001c5c:	fffff097          	auipc	ra,0xfffff
    80001c60:	1e6080e7          	jalr	486(ra) # 80000e42 <myproc>
    80001c64:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80001c66:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001c68:	14102773          	csrr	a4,sepc
    80001c6c:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001c6e:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    80001c72:	47a1                	li	a5,8
    80001c74:	04f71c63          	bne	a4,a5,80001ccc <usertrap+0x92>
    if(p->killed)
    80001c78:	551c                	lw	a5,40(a0)
    80001c7a:	e3b9                	bnez	a5,80001cc0 <usertrap+0x86>
    p->trapframe->epc += 4;
    80001c7c:	6cb8                	ld	a4,88(s1)
    80001c7e:	6f1c                	ld	a5,24(a4)
    80001c80:	0791                	add	a5,a5,4
    80001c82:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001c84:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001c88:	0027e793          	or	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001c8c:	10079073          	csrw	sstatus,a5
    syscall();
    80001c90:	00000097          	auipc	ra,0x0
    80001c94:	2e0080e7          	jalr	736(ra) # 80001f70 <syscall>
  if(p->killed)
    80001c98:	549c                	lw	a5,40(s1)
    80001c9a:	ebc1                	bnez	a5,80001d2a <usertrap+0xf0>
  usertrapret();
    80001c9c:	00000097          	auipc	ra,0x0
    80001ca0:	e14080e7          	jalr	-492(ra) # 80001ab0 <usertrapret>
}
    80001ca4:	60e2                	ld	ra,24(sp)
    80001ca6:	6442                	ld	s0,16(sp)
    80001ca8:	64a2                	ld	s1,8(sp)
    80001caa:	6902                	ld	s2,0(sp)
    80001cac:	6105                	add	sp,sp,32
    80001cae:	8082                	ret
    panic("usertrap: not from user mode");
    80001cb0:	00006517          	auipc	a0,0x6
    80001cb4:	5e850513          	add	a0,a0,1512 # 80008298 <states.0+0x58>
    80001cb8:	00004097          	auipc	ra,0x4
    80001cbc:	dc2080e7          	jalr	-574(ra) # 80005a7a <panic>
      exit(-1);
    80001cc0:	557d                	li	a0,-1
    80001cc2:	00000097          	auipc	ra,0x0
    80001cc6:	aa0080e7          	jalr	-1376(ra) # 80001762 <exit>
    80001cca:	bf4d                	j	80001c7c <usertrap+0x42>
  } else if((which_dev = devintr()) != 0){
    80001ccc:	00000097          	auipc	ra,0x0
    80001cd0:	ec8080e7          	jalr	-312(ra) # 80001b94 <devintr>
    80001cd4:	892a                	mv	s2,a0
    80001cd6:	c501                	beqz	a0,80001cde <usertrap+0xa4>
  if(p->killed)
    80001cd8:	549c                	lw	a5,40(s1)
    80001cda:	c3a1                	beqz	a5,80001d1a <usertrap+0xe0>
    80001cdc:	a815                	j	80001d10 <usertrap+0xd6>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001cde:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80001ce2:	5890                	lw	a2,48(s1)
    80001ce4:	00006517          	auipc	a0,0x6
    80001ce8:	5d450513          	add	a0,a0,1492 # 800082b8 <states.0+0x78>
    80001cec:	00004097          	auipc	ra,0x4
    80001cf0:	dd8080e7          	jalr	-552(ra) # 80005ac4 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001cf4:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001cf8:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001cfc:	00006517          	auipc	a0,0x6
    80001d00:	5ec50513          	add	a0,a0,1516 # 800082e8 <states.0+0xa8>
    80001d04:	00004097          	auipc	ra,0x4
    80001d08:	dc0080e7          	jalr	-576(ra) # 80005ac4 <printf>
    p->killed = 1;
    80001d0c:	4785                	li	a5,1
    80001d0e:	d49c                	sw	a5,40(s1)
    exit(-1);
    80001d10:	557d                	li	a0,-1
    80001d12:	00000097          	auipc	ra,0x0
    80001d16:	a50080e7          	jalr	-1456(ra) # 80001762 <exit>
  if(which_dev == 2)
    80001d1a:	4789                	li	a5,2
    80001d1c:	f8f910e3          	bne	s2,a5,80001c9c <usertrap+0x62>
    yield();
    80001d20:	fffff097          	auipc	ra,0xfffff
    80001d24:	7aa080e7          	jalr	1962(ra) # 800014ca <yield>
    80001d28:	bf95                	j	80001c9c <usertrap+0x62>
  int which_dev = 0;
    80001d2a:	4901                	li	s2,0
    80001d2c:	b7d5                	j	80001d10 <usertrap+0xd6>

0000000080001d2e <kerneltrap>:
{
    80001d2e:	7179                	add	sp,sp,-48
    80001d30:	f406                	sd	ra,40(sp)
    80001d32:	f022                	sd	s0,32(sp)
    80001d34:	ec26                	sd	s1,24(sp)
    80001d36:	e84a                	sd	s2,16(sp)
    80001d38:	e44e                	sd	s3,8(sp)
    80001d3a:	1800                	add	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001d3c:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001d40:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001d44:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80001d48:	1004f793          	and	a5,s1,256
    80001d4c:	cb85                	beqz	a5,80001d7c <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001d4e:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001d52:	8b89                	and	a5,a5,2
  if(intr_get() != 0)
    80001d54:	ef85                	bnez	a5,80001d8c <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    80001d56:	00000097          	auipc	ra,0x0
    80001d5a:	e3e080e7          	jalr	-450(ra) # 80001b94 <devintr>
    80001d5e:	cd1d                	beqz	a0,80001d9c <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80001d60:	4789                	li	a5,2
    80001d62:	06f50a63          	beq	a0,a5,80001dd6 <kerneltrap+0xa8>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001d66:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001d6a:	10049073          	csrw	sstatus,s1
}
    80001d6e:	70a2                	ld	ra,40(sp)
    80001d70:	7402                	ld	s0,32(sp)
    80001d72:	64e2                	ld	s1,24(sp)
    80001d74:	6942                	ld	s2,16(sp)
    80001d76:	69a2                	ld	s3,8(sp)
    80001d78:	6145                	add	sp,sp,48
    80001d7a:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80001d7c:	00006517          	auipc	a0,0x6
    80001d80:	58c50513          	add	a0,a0,1420 # 80008308 <states.0+0xc8>
    80001d84:	00004097          	auipc	ra,0x4
    80001d88:	cf6080e7          	jalr	-778(ra) # 80005a7a <panic>
    panic("kerneltrap: interrupts enabled");
    80001d8c:	00006517          	auipc	a0,0x6
    80001d90:	5a450513          	add	a0,a0,1444 # 80008330 <states.0+0xf0>
    80001d94:	00004097          	auipc	ra,0x4
    80001d98:	ce6080e7          	jalr	-794(ra) # 80005a7a <panic>
    printf("scause %p\n", scause);
    80001d9c:	85ce                	mv	a1,s3
    80001d9e:	00006517          	auipc	a0,0x6
    80001da2:	5b250513          	add	a0,a0,1458 # 80008350 <states.0+0x110>
    80001da6:	00004097          	auipc	ra,0x4
    80001daa:	d1e080e7          	jalr	-738(ra) # 80005ac4 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001dae:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001db2:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001db6:	00006517          	auipc	a0,0x6
    80001dba:	5aa50513          	add	a0,a0,1450 # 80008360 <states.0+0x120>
    80001dbe:	00004097          	auipc	ra,0x4
    80001dc2:	d06080e7          	jalr	-762(ra) # 80005ac4 <printf>
    panic("kerneltrap");
    80001dc6:	00006517          	auipc	a0,0x6
    80001dca:	5b250513          	add	a0,a0,1458 # 80008378 <states.0+0x138>
    80001dce:	00004097          	auipc	ra,0x4
    80001dd2:	cac080e7          	jalr	-852(ra) # 80005a7a <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80001dd6:	fffff097          	auipc	ra,0xfffff
    80001dda:	06c080e7          	jalr	108(ra) # 80000e42 <myproc>
    80001dde:	d541                	beqz	a0,80001d66 <kerneltrap+0x38>
    80001de0:	fffff097          	auipc	ra,0xfffff
    80001de4:	062080e7          	jalr	98(ra) # 80000e42 <myproc>
    80001de8:	4d18                	lw	a4,24(a0)
    80001dea:	4791                	li	a5,4
    80001dec:	f6f71de3          	bne	a4,a5,80001d66 <kerneltrap+0x38>
    yield();
    80001df0:	fffff097          	auipc	ra,0xfffff
    80001df4:	6da080e7          	jalr	1754(ra) # 800014ca <yield>
    80001df8:	b7bd                	j	80001d66 <kerneltrap+0x38>

0000000080001dfa <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80001dfa:	1101                	add	sp,sp,-32
    80001dfc:	ec06                	sd	ra,24(sp)
    80001dfe:	e822                	sd	s0,16(sp)
    80001e00:	e426                	sd	s1,8(sp)
    80001e02:	1000                	add	s0,sp,32
    80001e04:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80001e06:	fffff097          	auipc	ra,0xfffff
    80001e0a:	03c080e7          	jalr	60(ra) # 80000e42 <myproc>
  switch (n) {
    80001e0e:	4795                	li	a5,5
    80001e10:	0497e163          	bltu	a5,s1,80001e52 <argraw+0x58>
    80001e14:	048a                	sll	s1,s1,0x2
    80001e16:	00006717          	auipc	a4,0x6
    80001e1a:	59a70713          	add	a4,a4,1434 # 800083b0 <states.0+0x170>
    80001e1e:	94ba                	add	s1,s1,a4
    80001e20:	409c                	lw	a5,0(s1)
    80001e22:	97ba                	add	a5,a5,a4
    80001e24:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80001e26:	6d3c                	ld	a5,88(a0)
    80001e28:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80001e2a:	60e2                	ld	ra,24(sp)
    80001e2c:	6442                	ld	s0,16(sp)
    80001e2e:	64a2                	ld	s1,8(sp)
    80001e30:	6105                	add	sp,sp,32
    80001e32:	8082                	ret
    return p->trapframe->a1;
    80001e34:	6d3c                	ld	a5,88(a0)
    80001e36:	7fa8                	ld	a0,120(a5)
    80001e38:	bfcd                	j	80001e2a <argraw+0x30>
    return p->trapframe->a2;
    80001e3a:	6d3c                	ld	a5,88(a0)
    80001e3c:	63c8                	ld	a0,128(a5)
    80001e3e:	b7f5                	j	80001e2a <argraw+0x30>
    return p->trapframe->a3;
    80001e40:	6d3c                	ld	a5,88(a0)
    80001e42:	67c8                	ld	a0,136(a5)
    80001e44:	b7dd                	j	80001e2a <argraw+0x30>
    return p->trapframe->a4;
    80001e46:	6d3c                	ld	a5,88(a0)
    80001e48:	6bc8                	ld	a0,144(a5)
    80001e4a:	b7c5                	j	80001e2a <argraw+0x30>
    return p->trapframe->a5;
    80001e4c:	6d3c                	ld	a5,88(a0)
    80001e4e:	6fc8                	ld	a0,152(a5)
    80001e50:	bfe9                	j	80001e2a <argraw+0x30>
  panic("argraw");
    80001e52:	00006517          	auipc	a0,0x6
    80001e56:	53650513          	add	a0,a0,1334 # 80008388 <states.0+0x148>
    80001e5a:	00004097          	auipc	ra,0x4
    80001e5e:	c20080e7          	jalr	-992(ra) # 80005a7a <panic>

0000000080001e62 <fetchaddr>:
{
    80001e62:	1101                	add	sp,sp,-32
    80001e64:	ec06                	sd	ra,24(sp)
    80001e66:	e822                	sd	s0,16(sp)
    80001e68:	e426                	sd	s1,8(sp)
    80001e6a:	e04a                	sd	s2,0(sp)
    80001e6c:	1000                	add	s0,sp,32
    80001e6e:	84aa                	mv	s1,a0
    80001e70:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80001e72:	fffff097          	auipc	ra,0xfffff
    80001e76:	fd0080e7          	jalr	-48(ra) # 80000e42 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz)
    80001e7a:	653c                	ld	a5,72(a0)
    80001e7c:	02f4f863          	bgeu	s1,a5,80001eac <fetchaddr+0x4a>
    80001e80:	00848713          	add	a4,s1,8
    80001e84:	02e7e663          	bltu	a5,a4,80001eb0 <fetchaddr+0x4e>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80001e88:	46a1                	li	a3,8
    80001e8a:	8626                	mv	a2,s1
    80001e8c:	85ca                	mv	a1,s2
    80001e8e:	6928                	ld	a0,80(a0)
    80001e90:	fffff097          	auipc	ra,0xfffff
    80001e94:	d02080e7          	jalr	-766(ra) # 80000b92 <copyin>
    80001e98:	00a03533          	snez	a0,a0
    80001e9c:	40a00533          	neg	a0,a0
}
    80001ea0:	60e2                	ld	ra,24(sp)
    80001ea2:	6442                	ld	s0,16(sp)
    80001ea4:	64a2                	ld	s1,8(sp)
    80001ea6:	6902                	ld	s2,0(sp)
    80001ea8:	6105                	add	sp,sp,32
    80001eaa:	8082                	ret
    return -1;
    80001eac:	557d                	li	a0,-1
    80001eae:	bfcd                	j	80001ea0 <fetchaddr+0x3e>
    80001eb0:	557d                	li	a0,-1
    80001eb2:	b7fd                	j	80001ea0 <fetchaddr+0x3e>

0000000080001eb4 <fetchstr>:
{
    80001eb4:	7179                	add	sp,sp,-48
    80001eb6:	f406                	sd	ra,40(sp)
    80001eb8:	f022                	sd	s0,32(sp)
    80001eba:	ec26                	sd	s1,24(sp)
    80001ebc:	e84a                	sd	s2,16(sp)
    80001ebe:	e44e                	sd	s3,8(sp)
    80001ec0:	1800                	add	s0,sp,48
    80001ec2:	892a                	mv	s2,a0
    80001ec4:	84ae                	mv	s1,a1
    80001ec6:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    80001ec8:	fffff097          	auipc	ra,0xfffff
    80001ecc:	f7a080e7          	jalr	-134(ra) # 80000e42 <myproc>
  int err = copyinstr(p->pagetable, buf, addr, max);
    80001ed0:	86ce                	mv	a3,s3
    80001ed2:	864a                	mv	a2,s2
    80001ed4:	85a6                	mv	a1,s1
    80001ed6:	6928                	ld	a0,80(a0)
    80001ed8:	fffff097          	auipc	ra,0xfffff
    80001edc:	d48080e7          	jalr	-696(ra) # 80000c20 <copyinstr>
  if(err < 0)
    80001ee0:	00054763          	bltz	a0,80001eee <fetchstr+0x3a>
  return strlen(buf);
    80001ee4:	8526                	mv	a0,s1
    80001ee6:	ffffe097          	auipc	ra,0xffffe
    80001eea:	40e080e7          	jalr	1038(ra) # 800002f4 <strlen>
}
    80001eee:	70a2                	ld	ra,40(sp)
    80001ef0:	7402                	ld	s0,32(sp)
    80001ef2:	64e2                	ld	s1,24(sp)
    80001ef4:	6942                	ld	s2,16(sp)
    80001ef6:	69a2                	ld	s3,8(sp)
    80001ef8:	6145                	add	sp,sp,48
    80001efa:	8082                	ret

0000000080001efc <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
    80001efc:	1101                	add	sp,sp,-32
    80001efe:	ec06                	sd	ra,24(sp)
    80001f00:	e822                	sd	s0,16(sp)
    80001f02:	e426                	sd	s1,8(sp)
    80001f04:	1000                	add	s0,sp,32
    80001f06:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80001f08:	00000097          	auipc	ra,0x0
    80001f0c:	ef2080e7          	jalr	-270(ra) # 80001dfa <argraw>
    80001f10:	c088                	sw	a0,0(s1)
  return 0;
}
    80001f12:	4501                	li	a0,0
    80001f14:	60e2                	ld	ra,24(sp)
    80001f16:	6442                	ld	s0,16(sp)
    80001f18:	64a2                	ld	s1,8(sp)
    80001f1a:	6105                	add	sp,sp,32
    80001f1c:	8082                	ret

0000000080001f1e <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
int
argaddr(int n, uint64 *ip)
{
    80001f1e:	1101                	add	sp,sp,-32
    80001f20:	ec06                	sd	ra,24(sp)
    80001f22:	e822                	sd	s0,16(sp)
    80001f24:	e426                	sd	s1,8(sp)
    80001f26:	1000                	add	s0,sp,32
    80001f28:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80001f2a:	00000097          	auipc	ra,0x0
    80001f2e:	ed0080e7          	jalr	-304(ra) # 80001dfa <argraw>
    80001f32:	e088                	sd	a0,0(s1)
  return 0;
}
    80001f34:	4501                	li	a0,0
    80001f36:	60e2                	ld	ra,24(sp)
    80001f38:	6442                	ld	s0,16(sp)
    80001f3a:	64a2                	ld	s1,8(sp)
    80001f3c:	6105                	add	sp,sp,32
    80001f3e:	8082                	ret

0000000080001f40 <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80001f40:	1101                	add	sp,sp,-32
    80001f42:	ec06                	sd	ra,24(sp)
    80001f44:	e822                	sd	s0,16(sp)
    80001f46:	e426                	sd	s1,8(sp)
    80001f48:	e04a                	sd	s2,0(sp)
    80001f4a:	1000                	add	s0,sp,32
    80001f4c:	84ae                	mv	s1,a1
    80001f4e:	8932                	mv	s2,a2
  *ip = argraw(n);
    80001f50:	00000097          	auipc	ra,0x0
    80001f54:	eaa080e7          	jalr	-342(ra) # 80001dfa <argraw>
  uint64 addr;
  if(argaddr(n, &addr) < 0)
    return -1;
  return fetchstr(addr, buf, max);
    80001f58:	864a                	mv	a2,s2
    80001f5a:	85a6                	mv	a1,s1
    80001f5c:	00000097          	auipc	ra,0x0
    80001f60:	f58080e7          	jalr	-168(ra) # 80001eb4 <fetchstr>
}
    80001f64:	60e2                	ld	ra,24(sp)
    80001f66:	6442                	ld	s0,16(sp)
    80001f68:	64a2                	ld	s1,8(sp)
    80001f6a:	6902                	ld	s2,0(sp)
    80001f6c:	6105                	add	sp,sp,32
    80001f6e:	8082                	ret

0000000080001f70 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
    80001f70:	1101                	add	sp,sp,-32
    80001f72:	ec06                	sd	ra,24(sp)
    80001f74:	e822                	sd	s0,16(sp)
    80001f76:	e426                	sd	s1,8(sp)
    80001f78:	e04a                	sd	s2,0(sp)
    80001f7a:	1000                	add	s0,sp,32
  int num;
  struct proc *p = myproc();
    80001f7c:	fffff097          	auipc	ra,0xfffff
    80001f80:	ec6080e7          	jalr	-314(ra) # 80000e42 <myproc>
    80001f84:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    80001f86:	05853903          	ld	s2,88(a0)
    80001f8a:	0a893783          	ld	a5,168(s2)
    80001f8e:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80001f92:	37fd                	addw	a5,a5,-1
    80001f94:	4751                	li	a4,20
    80001f96:	00f76f63          	bltu	a4,a5,80001fb4 <syscall+0x44>
    80001f9a:	00369713          	sll	a4,a3,0x3
    80001f9e:	00006797          	auipc	a5,0x6
    80001fa2:	42a78793          	add	a5,a5,1066 # 800083c8 <syscalls>
    80001fa6:	97ba                	add	a5,a5,a4
    80001fa8:	639c                	ld	a5,0(a5)
    80001faa:	c789                	beqz	a5,80001fb4 <syscall+0x44>
    p->trapframe->a0 = syscalls[num]();
    80001fac:	9782                	jalr	a5
    80001fae:	06a93823          	sd	a0,112(s2)
    80001fb2:	a839                	j	80001fd0 <syscall+0x60>
  } else {
    printf("%d %s: unknown sys call %d\n",
    80001fb4:	15848613          	add	a2,s1,344
    80001fb8:	588c                	lw	a1,48(s1)
    80001fba:	00006517          	auipc	a0,0x6
    80001fbe:	3d650513          	add	a0,a0,982 # 80008390 <states.0+0x150>
    80001fc2:	00004097          	auipc	ra,0x4
    80001fc6:	b02080e7          	jalr	-1278(ra) # 80005ac4 <printf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    80001fca:	6cbc                	ld	a5,88(s1)
    80001fcc:	577d                	li	a4,-1
    80001fce:	fbb8                	sd	a4,112(a5)
  }
}
    80001fd0:	60e2                	ld	ra,24(sp)
    80001fd2:	6442                	ld	s0,16(sp)
    80001fd4:	64a2                	ld	s1,8(sp)
    80001fd6:	6902                	ld	s2,0(sp)
    80001fd8:	6105                	add	sp,sp,32
    80001fda:	8082                	ret

0000000080001fdc <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    80001fdc:	1101                	add	sp,sp,-32
    80001fde:	ec06                	sd	ra,24(sp)
    80001fe0:	e822                	sd	s0,16(sp)
    80001fe2:	1000                	add	s0,sp,32
  int n;
  if(argint(0, &n) < 0)
    80001fe4:	fec40593          	add	a1,s0,-20
    80001fe8:	4501                	li	a0,0
    80001fea:	00000097          	auipc	ra,0x0
    80001fee:	f12080e7          	jalr	-238(ra) # 80001efc <argint>
    return -1;
    80001ff2:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    80001ff4:	00054963          	bltz	a0,80002006 <sys_exit+0x2a>
  exit(n);
    80001ff8:	fec42503          	lw	a0,-20(s0)
    80001ffc:	fffff097          	auipc	ra,0xfffff
    80002000:	766080e7          	jalr	1894(ra) # 80001762 <exit>
  return 0;  // not reached
    80002004:	4781                	li	a5,0
}
    80002006:	853e                	mv	a0,a5
    80002008:	60e2                	ld	ra,24(sp)
    8000200a:	6442                	ld	s0,16(sp)
    8000200c:	6105                	add	sp,sp,32
    8000200e:	8082                	ret

0000000080002010 <sys_getpid>:

uint64
sys_getpid(void)
{
    80002010:	1141                	add	sp,sp,-16
    80002012:	e406                	sd	ra,8(sp)
    80002014:	e022                	sd	s0,0(sp)
    80002016:	0800                	add	s0,sp,16
  return myproc()->pid;
    80002018:	fffff097          	auipc	ra,0xfffff
    8000201c:	e2a080e7          	jalr	-470(ra) # 80000e42 <myproc>
}
    80002020:	5908                	lw	a0,48(a0)
    80002022:	60a2                	ld	ra,8(sp)
    80002024:	6402                	ld	s0,0(sp)
    80002026:	0141                	add	sp,sp,16
    80002028:	8082                	ret

000000008000202a <sys_fork>:

uint64
sys_fork(void)
{
    8000202a:	1141                	add	sp,sp,-16
    8000202c:	e406                	sd	ra,8(sp)
    8000202e:	e022                	sd	s0,0(sp)
    80002030:	0800                	add	s0,sp,16
  return fork();
    80002032:	fffff097          	auipc	ra,0xfffff
    80002036:	1e2080e7          	jalr	482(ra) # 80001214 <fork>
}
    8000203a:	60a2                	ld	ra,8(sp)
    8000203c:	6402                	ld	s0,0(sp)
    8000203e:	0141                	add	sp,sp,16
    80002040:	8082                	ret

0000000080002042 <sys_wait>:

uint64
sys_wait(void)
{
    80002042:	1101                	add	sp,sp,-32
    80002044:	ec06                	sd	ra,24(sp)
    80002046:	e822                	sd	s0,16(sp)
    80002048:	1000                	add	s0,sp,32
  uint64 p;
  if(argaddr(0, &p) < 0)
    8000204a:	fe840593          	add	a1,s0,-24
    8000204e:	4501                	li	a0,0
    80002050:	00000097          	auipc	ra,0x0
    80002054:	ece080e7          	jalr	-306(ra) # 80001f1e <argaddr>
    80002058:	87aa                	mv	a5,a0
    return -1;
    8000205a:	557d                	li	a0,-1
  if(argaddr(0, &p) < 0)
    8000205c:	0007c863          	bltz	a5,8000206c <sys_wait+0x2a>
  return wait(p);
    80002060:	fe843503          	ld	a0,-24(s0)
    80002064:	fffff097          	auipc	ra,0xfffff
    80002068:	506080e7          	jalr	1286(ra) # 8000156a <wait>
}
    8000206c:	60e2                	ld	ra,24(sp)
    8000206e:	6442                	ld	s0,16(sp)
    80002070:	6105                	add	sp,sp,32
    80002072:	8082                	ret

0000000080002074 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80002074:	7179                	add	sp,sp,-48
    80002076:	f406                	sd	ra,40(sp)
    80002078:	f022                	sd	s0,32(sp)
    8000207a:	ec26                	sd	s1,24(sp)
    8000207c:	1800                	add	s0,sp,48
  int addr;
  int n;

  if(argint(0, &n) < 0)
    8000207e:	fdc40593          	add	a1,s0,-36
    80002082:	4501                	li	a0,0
    80002084:	00000097          	auipc	ra,0x0
    80002088:	e78080e7          	jalr	-392(ra) # 80001efc <argint>
    8000208c:	87aa                	mv	a5,a0
    return -1;
    8000208e:	557d                	li	a0,-1
  if(argint(0, &n) < 0)
    80002090:	0207c063          	bltz	a5,800020b0 <sys_sbrk+0x3c>
  addr = myproc()->sz;
    80002094:	fffff097          	auipc	ra,0xfffff
    80002098:	dae080e7          	jalr	-594(ra) # 80000e42 <myproc>
    8000209c:	4524                	lw	s1,72(a0)
  if(growproc(n) < 0)
    8000209e:	fdc42503          	lw	a0,-36(s0)
    800020a2:	fffff097          	auipc	ra,0xfffff
    800020a6:	0fa080e7          	jalr	250(ra) # 8000119c <growproc>
    800020aa:	00054863          	bltz	a0,800020ba <sys_sbrk+0x46>
    return -1;
  return addr;
    800020ae:	8526                	mv	a0,s1
}
    800020b0:	70a2                	ld	ra,40(sp)
    800020b2:	7402                	ld	s0,32(sp)
    800020b4:	64e2                	ld	s1,24(sp)
    800020b6:	6145                	add	sp,sp,48
    800020b8:	8082                	ret
    return -1;
    800020ba:	557d                	li	a0,-1
    800020bc:	bfd5                	j	800020b0 <sys_sbrk+0x3c>

00000000800020be <sys_sleep>:

uint64
sys_sleep(void)
{
    800020be:	7139                	add	sp,sp,-64
    800020c0:	fc06                	sd	ra,56(sp)
    800020c2:	f822                	sd	s0,48(sp)
    800020c4:	f426                	sd	s1,40(sp)
    800020c6:	f04a                	sd	s2,32(sp)
    800020c8:	ec4e                	sd	s3,24(sp)
    800020ca:	0080                	add	s0,sp,64
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    800020cc:	fcc40593          	add	a1,s0,-52
    800020d0:	4501                	li	a0,0
    800020d2:	00000097          	auipc	ra,0x0
    800020d6:	e2a080e7          	jalr	-470(ra) # 80001efc <argint>
    return -1;
    800020da:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    800020dc:	06054563          	bltz	a0,80002146 <sys_sleep+0x88>
  acquire(&tickslock);
    800020e0:	0000d517          	auipc	a0,0xd
    800020e4:	da050513          	add	a0,a0,-608 # 8000ee80 <tickslock>
    800020e8:	00004097          	auipc	ra,0x4
    800020ec:	eca080e7          	jalr	-310(ra) # 80005fb2 <acquire>
  ticks0 = ticks;
    800020f0:	00007917          	auipc	s2,0x7
    800020f4:	f2892903          	lw	s2,-216(s2) # 80009018 <ticks>
  while(ticks - ticks0 < n){
    800020f8:	fcc42783          	lw	a5,-52(s0)
    800020fc:	cf85                	beqz	a5,80002134 <sys_sleep+0x76>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    800020fe:	0000d997          	auipc	s3,0xd
    80002102:	d8298993          	add	s3,s3,-638 # 8000ee80 <tickslock>
    80002106:	00007497          	auipc	s1,0x7
    8000210a:	f1248493          	add	s1,s1,-238 # 80009018 <ticks>
    if(myproc()->killed){
    8000210e:	fffff097          	auipc	ra,0xfffff
    80002112:	d34080e7          	jalr	-716(ra) # 80000e42 <myproc>
    80002116:	551c                	lw	a5,40(a0)
    80002118:	ef9d                	bnez	a5,80002156 <sys_sleep+0x98>
    sleep(&ticks, &tickslock);
    8000211a:	85ce                	mv	a1,s3
    8000211c:	8526                	mv	a0,s1
    8000211e:	fffff097          	auipc	ra,0xfffff
    80002122:	3e8080e7          	jalr	1000(ra) # 80001506 <sleep>
  while(ticks - ticks0 < n){
    80002126:	409c                	lw	a5,0(s1)
    80002128:	412787bb          	subw	a5,a5,s2
    8000212c:	fcc42703          	lw	a4,-52(s0)
    80002130:	fce7efe3          	bltu	a5,a4,8000210e <sys_sleep+0x50>
  }
  release(&tickslock);
    80002134:	0000d517          	auipc	a0,0xd
    80002138:	d4c50513          	add	a0,a0,-692 # 8000ee80 <tickslock>
    8000213c:	00004097          	auipc	ra,0x4
    80002140:	f2a080e7          	jalr	-214(ra) # 80006066 <release>
  return 0;
    80002144:	4781                	li	a5,0
}
    80002146:	853e                	mv	a0,a5
    80002148:	70e2                	ld	ra,56(sp)
    8000214a:	7442                	ld	s0,48(sp)
    8000214c:	74a2                	ld	s1,40(sp)
    8000214e:	7902                	ld	s2,32(sp)
    80002150:	69e2                	ld	s3,24(sp)
    80002152:	6121                	add	sp,sp,64
    80002154:	8082                	ret
      release(&tickslock);
    80002156:	0000d517          	auipc	a0,0xd
    8000215a:	d2a50513          	add	a0,a0,-726 # 8000ee80 <tickslock>
    8000215e:	00004097          	auipc	ra,0x4
    80002162:	f08080e7          	jalr	-248(ra) # 80006066 <release>
      return -1;
    80002166:	57fd                	li	a5,-1
    80002168:	bff9                	j	80002146 <sys_sleep+0x88>

000000008000216a <sys_kill>:

uint64
sys_kill(void)
{
    8000216a:	1101                	add	sp,sp,-32
    8000216c:	ec06                	sd	ra,24(sp)
    8000216e:	e822                	sd	s0,16(sp)
    80002170:	1000                	add	s0,sp,32
  int pid;

  if(argint(0, &pid) < 0)
    80002172:	fec40593          	add	a1,s0,-20
    80002176:	4501                	li	a0,0
    80002178:	00000097          	auipc	ra,0x0
    8000217c:	d84080e7          	jalr	-636(ra) # 80001efc <argint>
    80002180:	87aa                	mv	a5,a0
    return -1;
    80002182:	557d                	li	a0,-1
  if(argint(0, &pid) < 0)
    80002184:	0007c863          	bltz	a5,80002194 <sys_kill+0x2a>
  return kill(pid);
    80002188:	fec42503          	lw	a0,-20(s0)
    8000218c:	fffff097          	auipc	ra,0xfffff
    80002190:	6ac080e7          	jalr	1708(ra) # 80001838 <kill>
}
    80002194:	60e2                	ld	ra,24(sp)
    80002196:	6442                	ld	s0,16(sp)
    80002198:	6105                	add	sp,sp,32
    8000219a:	8082                	ret

000000008000219c <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    8000219c:	1101                	add	sp,sp,-32
    8000219e:	ec06                	sd	ra,24(sp)
    800021a0:	e822                	sd	s0,16(sp)
    800021a2:	e426                	sd	s1,8(sp)
    800021a4:	1000                	add	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    800021a6:	0000d517          	auipc	a0,0xd
    800021aa:	cda50513          	add	a0,a0,-806 # 8000ee80 <tickslock>
    800021ae:	00004097          	auipc	ra,0x4
    800021b2:	e04080e7          	jalr	-508(ra) # 80005fb2 <acquire>
  xticks = ticks;
    800021b6:	00007497          	auipc	s1,0x7
    800021ba:	e624a483          	lw	s1,-414(s1) # 80009018 <ticks>
  release(&tickslock);
    800021be:	0000d517          	auipc	a0,0xd
    800021c2:	cc250513          	add	a0,a0,-830 # 8000ee80 <tickslock>
    800021c6:	00004097          	auipc	ra,0x4
    800021ca:	ea0080e7          	jalr	-352(ra) # 80006066 <release>
  return xticks;
}
    800021ce:	02049513          	sll	a0,s1,0x20
    800021d2:	9101                	srl	a0,a0,0x20
    800021d4:	60e2                	ld	ra,24(sp)
    800021d6:	6442                	ld	s0,16(sp)
    800021d8:	64a2                	ld	s1,8(sp)
    800021da:	6105                	add	sp,sp,32
    800021dc:	8082                	ret

00000000800021de <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    800021de:	7179                	add	sp,sp,-48
    800021e0:	f406                	sd	ra,40(sp)
    800021e2:	f022                	sd	s0,32(sp)
    800021e4:	ec26                	sd	s1,24(sp)
    800021e6:	e84a                	sd	s2,16(sp)
    800021e8:	e44e                	sd	s3,8(sp)
    800021ea:	e052                	sd	s4,0(sp)
    800021ec:	1800                	add	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    800021ee:	00006597          	auipc	a1,0x6
    800021f2:	28a58593          	add	a1,a1,650 # 80008478 <syscalls+0xb0>
    800021f6:	0000d517          	auipc	a0,0xd
    800021fa:	ca250513          	add	a0,a0,-862 # 8000ee98 <bcache>
    800021fe:	00004097          	auipc	ra,0x4
    80002202:	d24080e7          	jalr	-732(ra) # 80005f22 <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80002206:	00015797          	auipc	a5,0x15
    8000220a:	c9278793          	add	a5,a5,-878 # 80016e98 <bcache+0x8000>
    8000220e:	00015717          	auipc	a4,0x15
    80002212:	ef270713          	add	a4,a4,-270 # 80017100 <bcache+0x8268>
    80002216:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    8000221a:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    8000221e:	0000d497          	auipc	s1,0xd
    80002222:	c9248493          	add	s1,s1,-878 # 8000eeb0 <bcache+0x18>
    b->next = bcache.head.next;
    80002226:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    80002228:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    8000222a:	00006a17          	auipc	s4,0x6
    8000222e:	256a0a13          	add	s4,s4,598 # 80008480 <syscalls+0xb8>
    b->next = bcache.head.next;
    80002232:	2b893783          	ld	a5,696(s2)
    80002236:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    80002238:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    8000223c:	85d2                	mv	a1,s4
    8000223e:	01048513          	add	a0,s1,16
    80002242:	00001097          	auipc	ra,0x1
    80002246:	490080e7          	jalr	1168(ra) # 800036d2 <initsleeplock>
    bcache.head.next->prev = b;
    8000224a:	2b893783          	ld	a5,696(s2)
    8000224e:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    80002250:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002254:	45848493          	add	s1,s1,1112
    80002258:	fd349de3          	bne	s1,s3,80002232 <binit+0x54>
  }
}
    8000225c:	70a2                	ld	ra,40(sp)
    8000225e:	7402                	ld	s0,32(sp)
    80002260:	64e2                	ld	s1,24(sp)
    80002262:	6942                	ld	s2,16(sp)
    80002264:	69a2                	ld	s3,8(sp)
    80002266:	6a02                	ld	s4,0(sp)
    80002268:	6145                	add	sp,sp,48
    8000226a:	8082                	ret

000000008000226c <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    8000226c:	7179                	add	sp,sp,-48
    8000226e:	f406                	sd	ra,40(sp)
    80002270:	f022                	sd	s0,32(sp)
    80002272:	ec26                	sd	s1,24(sp)
    80002274:	e84a                	sd	s2,16(sp)
    80002276:	e44e                	sd	s3,8(sp)
    80002278:	1800                	add	s0,sp,48
    8000227a:	892a                	mv	s2,a0
    8000227c:	89ae                	mv	s3,a1
  acquire(&bcache.lock);
    8000227e:	0000d517          	auipc	a0,0xd
    80002282:	c1a50513          	add	a0,a0,-998 # 8000ee98 <bcache>
    80002286:	00004097          	auipc	ra,0x4
    8000228a:	d2c080e7          	jalr	-724(ra) # 80005fb2 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    8000228e:	00015497          	auipc	s1,0x15
    80002292:	ec24b483          	ld	s1,-318(s1) # 80017150 <bcache+0x82b8>
    80002296:	00015797          	auipc	a5,0x15
    8000229a:	e6a78793          	add	a5,a5,-406 # 80017100 <bcache+0x8268>
    8000229e:	02f48f63          	beq	s1,a5,800022dc <bread+0x70>
    800022a2:	873e                	mv	a4,a5
    800022a4:	a021                	j	800022ac <bread+0x40>
    800022a6:	68a4                	ld	s1,80(s1)
    800022a8:	02e48a63          	beq	s1,a4,800022dc <bread+0x70>
    if(b->dev == dev && b->blockno == blockno){
    800022ac:	449c                	lw	a5,8(s1)
    800022ae:	ff279ce3          	bne	a5,s2,800022a6 <bread+0x3a>
    800022b2:	44dc                	lw	a5,12(s1)
    800022b4:	ff3799e3          	bne	a5,s3,800022a6 <bread+0x3a>
      b->refcnt++;
    800022b8:	40bc                	lw	a5,64(s1)
    800022ba:	2785                	addw	a5,a5,1
    800022bc:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    800022be:	0000d517          	auipc	a0,0xd
    800022c2:	bda50513          	add	a0,a0,-1062 # 8000ee98 <bcache>
    800022c6:	00004097          	auipc	ra,0x4
    800022ca:	da0080e7          	jalr	-608(ra) # 80006066 <release>
      acquiresleep(&b->lock);
    800022ce:	01048513          	add	a0,s1,16
    800022d2:	00001097          	auipc	ra,0x1
    800022d6:	43a080e7          	jalr	1082(ra) # 8000370c <acquiresleep>
      return b;
    800022da:	a8b9                	j	80002338 <bread+0xcc>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    800022dc:	00015497          	auipc	s1,0x15
    800022e0:	e6c4b483          	ld	s1,-404(s1) # 80017148 <bcache+0x82b0>
    800022e4:	00015797          	auipc	a5,0x15
    800022e8:	e1c78793          	add	a5,a5,-484 # 80017100 <bcache+0x8268>
    800022ec:	00f48863          	beq	s1,a5,800022fc <bread+0x90>
    800022f0:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    800022f2:	40bc                	lw	a5,64(s1)
    800022f4:	cf81                	beqz	a5,8000230c <bread+0xa0>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    800022f6:	64a4                	ld	s1,72(s1)
    800022f8:	fee49de3          	bne	s1,a4,800022f2 <bread+0x86>
  panic("bget: no buffers");
    800022fc:	00006517          	auipc	a0,0x6
    80002300:	18c50513          	add	a0,a0,396 # 80008488 <syscalls+0xc0>
    80002304:	00003097          	auipc	ra,0x3
    80002308:	776080e7          	jalr	1910(ra) # 80005a7a <panic>
      b->dev = dev;
    8000230c:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    80002310:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    80002314:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    80002318:	4785                	li	a5,1
    8000231a:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    8000231c:	0000d517          	auipc	a0,0xd
    80002320:	b7c50513          	add	a0,a0,-1156 # 8000ee98 <bcache>
    80002324:	00004097          	auipc	ra,0x4
    80002328:	d42080e7          	jalr	-702(ra) # 80006066 <release>
      acquiresleep(&b->lock);
    8000232c:	01048513          	add	a0,s1,16
    80002330:	00001097          	auipc	ra,0x1
    80002334:	3dc080e7          	jalr	988(ra) # 8000370c <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    80002338:	409c                	lw	a5,0(s1)
    8000233a:	cb89                	beqz	a5,8000234c <bread+0xe0>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    8000233c:	8526                	mv	a0,s1
    8000233e:	70a2                	ld	ra,40(sp)
    80002340:	7402                	ld	s0,32(sp)
    80002342:	64e2                	ld	s1,24(sp)
    80002344:	6942                	ld	s2,16(sp)
    80002346:	69a2                	ld	s3,8(sp)
    80002348:	6145                	add	sp,sp,48
    8000234a:	8082                	ret
    virtio_disk_rw(b, 0);
    8000234c:	4581                	li	a1,0
    8000234e:	8526                	mv	a0,s1
    80002350:	00003097          	auipc	ra,0x3
    80002354:	ec2080e7          	jalr	-318(ra) # 80005212 <virtio_disk_rw>
    b->valid = 1;
    80002358:	4785                	li	a5,1
    8000235a:	c09c                	sw	a5,0(s1)
  return b;
    8000235c:	b7c5                	j	8000233c <bread+0xd0>

000000008000235e <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    8000235e:	1101                	add	sp,sp,-32
    80002360:	ec06                	sd	ra,24(sp)
    80002362:	e822                	sd	s0,16(sp)
    80002364:	e426                	sd	s1,8(sp)
    80002366:	1000                	add	s0,sp,32
    80002368:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    8000236a:	0541                	add	a0,a0,16
    8000236c:	00001097          	auipc	ra,0x1
    80002370:	43a080e7          	jalr	1082(ra) # 800037a6 <holdingsleep>
    80002374:	cd01                	beqz	a0,8000238c <bwrite+0x2e>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    80002376:	4585                	li	a1,1
    80002378:	8526                	mv	a0,s1
    8000237a:	00003097          	auipc	ra,0x3
    8000237e:	e98080e7          	jalr	-360(ra) # 80005212 <virtio_disk_rw>
}
    80002382:	60e2                	ld	ra,24(sp)
    80002384:	6442                	ld	s0,16(sp)
    80002386:	64a2                	ld	s1,8(sp)
    80002388:	6105                	add	sp,sp,32
    8000238a:	8082                	ret
    panic("bwrite");
    8000238c:	00006517          	auipc	a0,0x6
    80002390:	11450513          	add	a0,a0,276 # 800084a0 <syscalls+0xd8>
    80002394:	00003097          	auipc	ra,0x3
    80002398:	6e6080e7          	jalr	1766(ra) # 80005a7a <panic>

000000008000239c <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    8000239c:	1101                	add	sp,sp,-32
    8000239e:	ec06                	sd	ra,24(sp)
    800023a0:	e822                	sd	s0,16(sp)
    800023a2:	e426                	sd	s1,8(sp)
    800023a4:	e04a                	sd	s2,0(sp)
    800023a6:	1000                	add	s0,sp,32
    800023a8:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    800023aa:	01050913          	add	s2,a0,16
    800023ae:	854a                	mv	a0,s2
    800023b0:	00001097          	auipc	ra,0x1
    800023b4:	3f6080e7          	jalr	1014(ra) # 800037a6 <holdingsleep>
    800023b8:	c925                	beqz	a0,80002428 <brelse+0x8c>
    panic("brelse");

  releasesleep(&b->lock);
    800023ba:	854a                	mv	a0,s2
    800023bc:	00001097          	auipc	ra,0x1
    800023c0:	3a6080e7          	jalr	934(ra) # 80003762 <releasesleep>

  acquire(&bcache.lock);
    800023c4:	0000d517          	auipc	a0,0xd
    800023c8:	ad450513          	add	a0,a0,-1324 # 8000ee98 <bcache>
    800023cc:	00004097          	auipc	ra,0x4
    800023d0:	be6080e7          	jalr	-1050(ra) # 80005fb2 <acquire>
  b->refcnt--;
    800023d4:	40bc                	lw	a5,64(s1)
    800023d6:	37fd                	addw	a5,a5,-1
    800023d8:	0007871b          	sext.w	a4,a5
    800023dc:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    800023de:	e71d                	bnez	a4,8000240c <brelse+0x70>
    // no one is waiting for it.
    b->next->prev = b->prev;
    800023e0:	68b8                	ld	a4,80(s1)
    800023e2:	64bc                	ld	a5,72(s1)
    800023e4:	e73c                	sd	a5,72(a4)
    b->prev->next = b->next;
    800023e6:	68b8                	ld	a4,80(s1)
    800023e8:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    800023ea:	00015797          	auipc	a5,0x15
    800023ee:	aae78793          	add	a5,a5,-1362 # 80016e98 <bcache+0x8000>
    800023f2:	2b87b703          	ld	a4,696(a5)
    800023f6:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    800023f8:	00015717          	auipc	a4,0x15
    800023fc:	d0870713          	add	a4,a4,-760 # 80017100 <bcache+0x8268>
    80002400:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    80002402:	2b87b703          	ld	a4,696(a5)
    80002406:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    80002408:	2a97bc23          	sd	s1,696(a5)
  }
  
  release(&bcache.lock);
    8000240c:	0000d517          	auipc	a0,0xd
    80002410:	a8c50513          	add	a0,a0,-1396 # 8000ee98 <bcache>
    80002414:	00004097          	auipc	ra,0x4
    80002418:	c52080e7          	jalr	-942(ra) # 80006066 <release>
}
    8000241c:	60e2                	ld	ra,24(sp)
    8000241e:	6442                	ld	s0,16(sp)
    80002420:	64a2                	ld	s1,8(sp)
    80002422:	6902                	ld	s2,0(sp)
    80002424:	6105                	add	sp,sp,32
    80002426:	8082                	ret
    panic("brelse");
    80002428:	00006517          	auipc	a0,0x6
    8000242c:	08050513          	add	a0,a0,128 # 800084a8 <syscalls+0xe0>
    80002430:	00003097          	auipc	ra,0x3
    80002434:	64a080e7          	jalr	1610(ra) # 80005a7a <panic>

0000000080002438 <bpin>:

void
bpin(struct buf *b) {
    80002438:	1101                	add	sp,sp,-32
    8000243a:	ec06                	sd	ra,24(sp)
    8000243c:	e822                	sd	s0,16(sp)
    8000243e:	e426                	sd	s1,8(sp)
    80002440:	1000                	add	s0,sp,32
    80002442:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80002444:	0000d517          	auipc	a0,0xd
    80002448:	a5450513          	add	a0,a0,-1452 # 8000ee98 <bcache>
    8000244c:	00004097          	auipc	ra,0x4
    80002450:	b66080e7          	jalr	-1178(ra) # 80005fb2 <acquire>
  b->refcnt++;
    80002454:	40bc                	lw	a5,64(s1)
    80002456:	2785                	addw	a5,a5,1
    80002458:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    8000245a:	0000d517          	auipc	a0,0xd
    8000245e:	a3e50513          	add	a0,a0,-1474 # 8000ee98 <bcache>
    80002462:	00004097          	auipc	ra,0x4
    80002466:	c04080e7          	jalr	-1020(ra) # 80006066 <release>
}
    8000246a:	60e2                	ld	ra,24(sp)
    8000246c:	6442                	ld	s0,16(sp)
    8000246e:	64a2                	ld	s1,8(sp)
    80002470:	6105                	add	sp,sp,32
    80002472:	8082                	ret

0000000080002474 <bunpin>:

void
bunpin(struct buf *b) {
    80002474:	1101                	add	sp,sp,-32
    80002476:	ec06                	sd	ra,24(sp)
    80002478:	e822                	sd	s0,16(sp)
    8000247a:	e426                	sd	s1,8(sp)
    8000247c:	1000                	add	s0,sp,32
    8000247e:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80002480:	0000d517          	auipc	a0,0xd
    80002484:	a1850513          	add	a0,a0,-1512 # 8000ee98 <bcache>
    80002488:	00004097          	auipc	ra,0x4
    8000248c:	b2a080e7          	jalr	-1238(ra) # 80005fb2 <acquire>
  b->refcnt--;
    80002490:	40bc                	lw	a5,64(s1)
    80002492:	37fd                	addw	a5,a5,-1
    80002494:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    80002496:	0000d517          	auipc	a0,0xd
    8000249a:	a0250513          	add	a0,a0,-1534 # 8000ee98 <bcache>
    8000249e:	00004097          	auipc	ra,0x4
    800024a2:	bc8080e7          	jalr	-1080(ra) # 80006066 <release>
}
    800024a6:	60e2                	ld	ra,24(sp)
    800024a8:	6442                	ld	s0,16(sp)
    800024aa:	64a2                	ld	s1,8(sp)
    800024ac:	6105                	add	sp,sp,32
    800024ae:	8082                	ret

00000000800024b0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    800024b0:	1101                	add	sp,sp,-32
    800024b2:	ec06                	sd	ra,24(sp)
    800024b4:	e822                	sd	s0,16(sp)
    800024b6:	e426                	sd	s1,8(sp)
    800024b8:	e04a                	sd	s2,0(sp)
    800024ba:	1000                	add	s0,sp,32
    800024bc:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    800024be:	00d5d59b          	srlw	a1,a1,0xd
    800024c2:	00015797          	auipc	a5,0x15
    800024c6:	0b27a783          	lw	a5,178(a5) # 80017574 <sb+0x1c>
    800024ca:	9dbd                	addw	a1,a1,a5
    800024cc:	00000097          	auipc	ra,0x0
    800024d0:	da0080e7          	jalr	-608(ra) # 8000226c <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    800024d4:	0074f713          	and	a4,s1,7
    800024d8:	4785                	li	a5,1
    800024da:	00e797bb          	sllw	a5,a5,a4
  if((bp->data[bi/8] & m) == 0)
    800024de:	14ce                	sll	s1,s1,0x33
    800024e0:	90d9                	srl	s1,s1,0x36
    800024e2:	00950733          	add	a4,a0,s1
    800024e6:	05874703          	lbu	a4,88(a4)
    800024ea:	00e7f6b3          	and	a3,a5,a4
    800024ee:	c69d                	beqz	a3,8000251c <bfree+0x6c>
    800024f0:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    800024f2:	94aa                	add	s1,s1,a0
    800024f4:	fff7c793          	not	a5,a5
    800024f8:	8f7d                	and	a4,a4,a5
    800024fa:	04e48c23          	sb	a4,88(s1)
  log_write(bp);
    800024fe:	00001097          	auipc	ra,0x1
    80002502:	0f0080e7          	jalr	240(ra) # 800035ee <log_write>
  brelse(bp);
    80002506:	854a                	mv	a0,s2
    80002508:	00000097          	auipc	ra,0x0
    8000250c:	e94080e7          	jalr	-364(ra) # 8000239c <brelse>
}
    80002510:	60e2                	ld	ra,24(sp)
    80002512:	6442                	ld	s0,16(sp)
    80002514:	64a2                	ld	s1,8(sp)
    80002516:	6902                	ld	s2,0(sp)
    80002518:	6105                	add	sp,sp,32
    8000251a:	8082                	ret
    panic("freeing free block");
    8000251c:	00006517          	auipc	a0,0x6
    80002520:	f9450513          	add	a0,a0,-108 # 800084b0 <syscalls+0xe8>
    80002524:	00003097          	auipc	ra,0x3
    80002528:	556080e7          	jalr	1366(ra) # 80005a7a <panic>

000000008000252c <balloc>:
{
    8000252c:	711d                	add	sp,sp,-96
    8000252e:	ec86                	sd	ra,88(sp)
    80002530:	e8a2                	sd	s0,80(sp)
    80002532:	e4a6                	sd	s1,72(sp)
    80002534:	e0ca                	sd	s2,64(sp)
    80002536:	fc4e                	sd	s3,56(sp)
    80002538:	f852                	sd	s4,48(sp)
    8000253a:	f456                	sd	s5,40(sp)
    8000253c:	f05a                	sd	s6,32(sp)
    8000253e:	ec5e                	sd	s7,24(sp)
    80002540:	e862                	sd	s8,16(sp)
    80002542:	e466                	sd	s9,8(sp)
    80002544:	1080                	add	s0,sp,96
  for(b = 0; b < sb.size; b += BPB){
    80002546:	00015797          	auipc	a5,0x15
    8000254a:	0167a783          	lw	a5,22(a5) # 8001755c <sb+0x4>
    8000254e:	cbc1                	beqz	a5,800025de <balloc+0xb2>
    80002550:	8baa                	mv	s7,a0
    80002552:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    80002554:	00015b17          	auipc	s6,0x15
    80002558:	004b0b13          	add	s6,s6,4 # 80017558 <sb>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000255c:	4c01                	li	s8,0
      m = 1 << (bi % 8);
    8000255e:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002560:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    80002562:	6c89                	lui	s9,0x2
    80002564:	a831                	j	80002580 <balloc+0x54>
    brelse(bp);
    80002566:	854a                	mv	a0,s2
    80002568:	00000097          	auipc	ra,0x0
    8000256c:	e34080e7          	jalr	-460(ra) # 8000239c <brelse>
  for(b = 0; b < sb.size; b += BPB){
    80002570:	015c87bb          	addw	a5,s9,s5
    80002574:	00078a9b          	sext.w	s5,a5
    80002578:	004b2703          	lw	a4,4(s6)
    8000257c:	06eaf163          	bgeu	s5,a4,800025de <balloc+0xb2>
    bp = bread(dev, BBLOCK(b, sb));
    80002580:	41fad79b          	sraw	a5,s5,0x1f
    80002584:	0137d79b          	srlw	a5,a5,0x13
    80002588:	015787bb          	addw	a5,a5,s5
    8000258c:	40d7d79b          	sraw	a5,a5,0xd
    80002590:	01cb2583          	lw	a1,28(s6)
    80002594:	9dbd                	addw	a1,a1,a5
    80002596:	855e                	mv	a0,s7
    80002598:	00000097          	auipc	ra,0x0
    8000259c:	cd4080e7          	jalr	-812(ra) # 8000226c <bread>
    800025a0:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800025a2:	004b2503          	lw	a0,4(s6)
    800025a6:	000a849b          	sext.w	s1,s5
    800025aa:	8762                	mv	a4,s8
    800025ac:	faa4fde3          	bgeu	s1,a0,80002566 <balloc+0x3a>
      m = 1 << (bi % 8);
    800025b0:	00777693          	and	a3,a4,7
    800025b4:	00d996bb          	sllw	a3,s3,a3
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    800025b8:	41f7579b          	sraw	a5,a4,0x1f
    800025bc:	01d7d79b          	srlw	a5,a5,0x1d
    800025c0:	9fb9                	addw	a5,a5,a4
    800025c2:	4037d79b          	sraw	a5,a5,0x3
    800025c6:	00f90633          	add	a2,s2,a5
    800025ca:	05864603          	lbu	a2,88(a2)
    800025ce:	00c6f5b3          	and	a1,a3,a2
    800025d2:	cd91                	beqz	a1,800025ee <balloc+0xc2>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800025d4:	2705                	addw	a4,a4,1
    800025d6:	2485                	addw	s1,s1,1
    800025d8:	fd471ae3          	bne	a4,s4,800025ac <balloc+0x80>
    800025dc:	b769                	j	80002566 <balloc+0x3a>
  panic("balloc: out of blocks");
    800025de:	00006517          	auipc	a0,0x6
    800025e2:	eea50513          	add	a0,a0,-278 # 800084c8 <syscalls+0x100>
    800025e6:	00003097          	auipc	ra,0x3
    800025ea:	494080e7          	jalr	1172(ra) # 80005a7a <panic>
        bp->data[bi/8] |= m;  // Mark block in use.
    800025ee:	97ca                	add	a5,a5,s2
    800025f0:	8e55                	or	a2,a2,a3
    800025f2:	04c78c23          	sb	a2,88(a5)
        log_write(bp);
    800025f6:	854a                	mv	a0,s2
    800025f8:	00001097          	auipc	ra,0x1
    800025fc:	ff6080e7          	jalr	-10(ra) # 800035ee <log_write>
        brelse(bp);
    80002600:	854a                	mv	a0,s2
    80002602:	00000097          	auipc	ra,0x0
    80002606:	d9a080e7          	jalr	-614(ra) # 8000239c <brelse>
  bp = bread(dev, bno);
    8000260a:	85a6                	mv	a1,s1
    8000260c:	855e                	mv	a0,s7
    8000260e:	00000097          	auipc	ra,0x0
    80002612:	c5e080e7          	jalr	-930(ra) # 8000226c <bread>
    80002616:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    80002618:	40000613          	li	a2,1024
    8000261c:	4581                	li	a1,0
    8000261e:	05850513          	add	a0,a0,88
    80002622:	ffffe097          	auipc	ra,0xffffe
    80002626:	b58080e7          	jalr	-1192(ra) # 8000017a <memset>
  log_write(bp);
    8000262a:	854a                	mv	a0,s2
    8000262c:	00001097          	auipc	ra,0x1
    80002630:	fc2080e7          	jalr	-62(ra) # 800035ee <log_write>
  brelse(bp);
    80002634:	854a                	mv	a0,s2
    80002636:	00000097          	auipc	ra,0x0
    8000263a:	d66080e7          	jalr	-666(ra) # 8000239c <brelse>
}
    8000263e:	8526                	mv	a0,s1
    80002640:	60e6                	ld	ra,88(sp)
    80002642:	6446                	ld	s0,80(sp)
    80002644:	64a6                	ld	s1,72(sp)
    80002646:	6906                	ld	s2,64(sp)
    80002648:	79e2                	ld	s3,56(sp)
    8000264a:	7a42                	ld	s4,48(sp)
    8000264c:	7aa2                	ld	s5,40(sp)
    8000264e:	7b02                	ld	s6,32(sp)
    80002650:	6be2                	ld	s7,24(sp)
    80002652:	6c42                	ld	s8,16(sp)
    80002654:	6ca2                	ld	s9,8(sp)
    80002656:	6125                	add	sp,sp,96
    80002658:	8082                	ret

000000008000265a <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
    8000265a:	7179                	add	sp,sp,-48
    8000265c:	f406                	sd	ra,40(sp)
    8000265e:	f022                	sd	s0,32(sp)
    80002660:	ec26                	sd	s1,24(sp)
    80002662:	e84a                	sd	s2,16(sp)
    80002664:	e44e                	sd	s3,8(sp)
    80002666:	e052                	sd	s4,0(sp)
    80002668:	1800                	add	s0,sp,48
    8000266a:	892a                	mv	s2,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    8000266c:	47ad                	li	a5,11
    8000266e:	04b7fe63          	bgeu	a5,a1,800026ca <bmap+0x70>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
    80002672:	ff45849b          	addw	s1,a1,-12
    80002676:	0004871b          	sext.w	a4,s1

  if(bn < NINDIRECT){
    8000267a:	0ff00793          	li	a5,255
    8000267e:	0ae7e463          	bltu	a5,a4,80002726 <bmap+0xcc>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
    80002682:	08052583          	lw	a1,128(a0)
    80002686:	c5b5                	beqz	a1,800026f2 <bmap+0x98>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    80002688:	00092503          	lw	a0,0(s2)
    8000268c:	00000097          	auipc	ra,0x0
    80002690:	be0080e7          	jalr	-1056(ra) # 8000226c <bread>
    80002694:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    80002696:	05850793          	add	a5,a0,88
    if((addr = a[bn]) == 0){
    8000269a:	02049713          	sll	a4,s1,0x20
    8000269e:	01e75593          	srl	a1,a4,0x1e
    800026a2:	00b784b3          	add	s1,a5,a1
    800026a6:	0004a983          	lw	s3,0(s1)
    800026aa:	04098e63          	beqz	s3,80002706 <bmap+0xac>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
    800026ae:	8552                	mv	a0,s4
    800026b0:	00000097          	auipc	ra,0x0
    800026b4:	cec080e7          	jalr	-788(ra) # 8000239c <brelse>
    return addr;
  }

  panic("bmap: out of range");
}
    800026b8:	854e                	mv	a0,s3
    800026ba:	70a2                	ld	ra,40(sp)
    800026bc:	7402                	ld	s0,32(sp)
    800026be:	64e2                	ld	s1,24(sp)
    800026c0:	6942                	ld	s2,16(sp)
    800026c2:	69a2                	ld	s3,8(sp)
    800026c4:	6a02                	ld	s4,0(sp)
    800026c6:	6145                	add	sp,sp,48
    800026c8:	8082                	ret
    if((addr = ip->addrs[bn]) == 0)
    800026ca:	02059793          	sll	a5,a1,0x20
    800026ce:	01e7d593          	srl	a1,a5,0x1e
    800026d2:	00b504b3          	add	s1,a0,a1
    800026d6:	0504a983          	lw	s3,80(s1)
    800026da:	fc099fe3          	bnez	s3,800026b8 <bmap+0x5e>
      ip->addrs[bn] = addr = balloc(ip->dev);
    800026de:	4108                	lw	a0,0(a0)
    800026e0:	00000097          	auipc	ra,0x0
    800026e4:	e4c080e7          	jalr	-436(ra) # 8000252c <balloc>
    800026e8:	0005099b          	sext.w	s3,a0
    800026ec:	0534a823          	sw	s3,80(s1)
    800026f0:	b7e1                	j	800026b8 <bmap+0x5e>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    800026f2:	4108                	lw	a0,0(a0)
    800026f4:	00000097          	auipc	ra,0x0
    800026f8:	e38080e7          	jalr	-456(ra) # 8000252c <balloc>
    800026fc:	0005059b          	sext.w	a1,a0
    80002700:	08b92023          	sw	a1,128(s2)
    80002704:	b751                	j	80002688 <bmap+0x2e>
      a[bn] = addr = balloc(ip->dev);
    80002706:	00092503          	lw	a0,0(s2)
    8000270a:	00000097          	auipc	ra,0x0
    8000270e:	e22080e7          	jalr	-478(ra) # 8000252c <balloc>
    80002712:	0005099b          	sext.w	s3,a0
    80002716:	0134a023          	sw	s3,0(s1)
      log_write(bp);
    8000271a:	8552                	mv	a0,s4
    8000271c:	00001097          	auipc	ra,0x1
    80002720:	ed2080e7          	jalr	-302(ra) # 800035ee <log_write>
    80002724:	b769                	j	800026ae <bmap+0x54>
  panic("bmap: out of range");
    80002726:	00006517          	auipc	a0,0x6
    8000272a:	dba50513          	add	a0,a0,-582 # 800084e0 <syscalls+0x118>
    8000272e:	00003097          	auipc	ra,0x3
    80002732:	34c080e7          	jalr	844(ra) # 80005a7a <panic>

0000000080002736 <iget>:
{
    80002736:	7179                	add	sp,sp,-48
    80002738:	f406                	sd	ra,40(sp)
    8000273a:	f022                	sd	s0,32(sp)
    8000273c:	ec26                	sd	s1,24(sp)
    8000273e:	e84a                	sd	s2,16(sp)
    80002740:	e44e                	sd	s3,8(sp)
    80002742:	e052                	sd	s4,0(sp)
    80002744:	1800                	add	s0,sp,48
    80002746:	89aa                	mv	s3,a0
    80002748:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    8000274a:	00015517          	auipc	a0,0x15
    8000274e:	e2e50513          	add	a0,a0,-466 # 80017578 <itable>
    80002752:	00004097          	auipc	ra,0x4
    80002756:	860080e7          	jalr	-1952(ra) # 80005fb2 <acquire>
  empty = 0;
    8000275a:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    8000275c:	00015497          	auipc	s1,0x15
    80002760:	e3448493          	add	s1,s1,-460 # 80017590 <itable+0x18>
    80002764:	00017697          	auipc	a3,0x17
    80002768:	8bc68693          	add	a3,a3,-1860 # 80019020 <log>
    8000276c:	a039                	j	8000277a <iget+0x44>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    8000276e:	02090b63          	beqz	s2,800027a4 <iget+0x6e>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80002772:	08848493          	add	s1,s1,136
    80002776:	02d48a63          	beq	s1,a3,800027aa <iget+0x74>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    8000277a:	449c                	lw	a5,8(s1)
    8000277c:	fef059e3          	blez	a5,8000276e <iget+0x38>
    80002780:	4098                	lw	a4,0(s1)
    80002782:	ff3716e3          	bne	a4,s3,8000276e <iget+0x38>
    80002786:	40d8                	lw	a4,4(s1)
    80002788:	ff4713e3          	bne	a4,s4,8000276e <iget+0x38>
      ip->ref++;
    8000278c:	2785                	addw	a5,a5,1
    8000278e:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    80002790:	00015517          	auipc	a0,0x15
    80002794:	de850513          	add	a0,a0,-536 # 80017578 <itable>
    80002798:	00004097          	auipc	ra,0x4
    8000279c:	8ce080e7          	jalr	-1842(ra) # 80006066 <release>
      return ip;
    800027a0:	8926                	mv	s2,s1
    800027a2:	a03d                	j	800027d0 <iget+0x9a>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    800027a4:	f7f9                	bnez	a5,80002772 <iget+0x3c>
    800027a6:	8926                	mv	s2,s1
    800027a8:	b7e9                	j	80002772 <iget+0x3c>
  if(empty == 0)
    800027aa:	02090c63          	beqz	s2,800027e2 <iget+0xac>
  ip->dev = dev;
    800027ae:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    800027b2:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    800027b6:	4785                	li	a5,1
    800027b8:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    800027bc:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    800027c0:	00015517          	auipc	a0,0x15
    800027c4:	db850513          	add	a0,a0,-584 # 80017578 <itable>
    800027c8:	00004097          	auipc	ra,0x4
    800027cc:	89e080e7          	jalr	-1890(ra) # 80006066 <release>
}
    800027d0:	854a                	mv	a0,s2
    800027d2:	70a2                	ld	ra,40(sp)
    800027d4:	7402                	ld	s0,32(sp)
    800027d6:	64e2                	ld	s1,24(sp)
    800027d8:	6942                	ld	s2,16(sp)
    800027da:	69a2                	ld	s3,8(sp)
    800027dc:	6a02                	ld	s4,0(sp)
    800027de:	6145                	add	sp,sp,48
    800027e0:	8082                	ret
    panic("iget: no inodes");
    800027e2:	00006517          	auipc	a0,0x6
    800027e6:	d1650513          	add	a0,a0,-746 # 800084f8 <syscalls+0x130>
    800027ea:	00003097          	auipc	ra,0x3
    800027ee:	290080e7          	jalr	656(ra) # 80005a7a <panic>

00000000800027f2 <fsinit>:
fsinit(int dev) {
    800027f2:	7179                	add	sp,sp,-48
    800027f4:	f406                	sd	ra,40(sp)
    800027f6:	f022                	sd	s0,32(sp)
    800027f8:	ec26                	sd	s1,24(sp)
    800027fa:	e84a                	sd	s2,16(sp)
    800027fc:	e44e                	sd	s3,8(sp)
    800027fe:	1800                	add	s0,sp,48
    80002800:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    80002802:	4585                	li	a1,1
    80002804:	00000097          	auipc	ra,0x0
    80002808:	a68080e7          	jalr	-1432(ra) # 8000226c <bread>
    8000280c:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    8000280e:	00015997          	auipc	s3,0x15
    80002812:	d4a98993          	add	s3,s3,-694 # 80017558 <sb>
    80002816:	02000613          	li	a2,32
    8000281a:	05850593          	add	a1,a0,88
    8000281e:	854e                	mv	a0,s3
    80002820:	ffffe097          	auipc	ra,0xffffe
    80002824:	9b6080e7          	jalr	-1610(ra) # 800001d6 <memmove>
  brelse(bp);
    80002828:	8526                	mv	a0,s1
    8000282a:	00000097          	auipc	ra,0x0
    8000282e:	b72080e7          	jalr	-1166(ra) # 8000239c <brelse>
  if(sb.magic != FSMAGIC)
    80002832:	0009a703          	lw	a4,0(s3)
    80002836:	102037b7          	lui	a5,0x10203
    8000283a:	04078793          	add	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    8000283e:	02f71263          	bne	a4,a5,80002862 <fsinit+0x70>
  initlog(dev, &sb);
    80002842:	00015597          	auipc	a1,0x15
    80002846:	d1658593          	add	a1,a1,-746 # 80017558 <sb>
    8000284a:	854a                	mv	a0,s2
    8000284c:	00001097          	auipc	ra,0x1
    80002850:	b38080e7          	jalr	-1224(ra) # 80003384 <initlog>
}
    80002854:	70a2                	ld	ra,40(sp)
    80002856:	7402                	ld	s0,32(sp)
    80002858:	64e2                	ld	s1,24(sp)
    8000285a:	6942                	ld	s2,16(sp)
    8000285c:	69a2                	ld	s3,8(sp)
    8000285e:	6145                	add	sp,sp,48
    80002860:	8082                	ret
    panic("invalid file system");
    80002862:	00006517          	auipc	a0,0x6
    80002866:	ca650513          	add	a0,a0,-858 # 80008508 <syscalls+0x140>
    8000286a:	00003097          	auipc	ra,0x3
    8000286e:	210080e7          	jalr	528(ra) # 80005a7a <panic>

0000000080002872 <iinit>:
{
    80002872:	7179                	add	sp,sp,-48
    80002874:	f406                	sd	ra,40(sp)
    80002876:	f022                	sd	s0,32(sp)
    80002878:	ec26                	sd	s1,24(sp)
    8000287a:	e84a                	sd	s2,16(sp)
    8000287c:	e44e                	sd	s3,8(sp)
    8000287e:	1800                	add	s0,sp,48
  initlock(&itable.lock, "itable");
    80002880:	00006597          	auipc	a1,0x6
    80002884:	ca058593          	add	a1,a1,-864 # 80008520 <syscalls+0x158>
    80002888:	00015517          	auipc	a0,0x15
    8000288c:	cf050513          	add	a0,a0,-784 # 80017578 <itable>
    80002890:	00003097          	auipc	ra,0x3
    80002894:	692080e7          	jalr	1682(ra) # 80005f22 <initlock>
  for(i = 0; i < NINODE; i++) {
    80002898:	00015497          	auipc	s1,0x15
    8000289c:	d0848493          	add	s1,s1,-760 # 800175a0 <itable+0x28>
    800028a0:	00016997          	auipc	s3,0x16
    800028a4:	79098993          	add	s3,s3,1936 # 80019030 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    800028a8:	00006917          	auipc	s2,0x6
    800028ac:	c8090913          	add	s2,s2,-896 # 80008528 <syscalls+0x160>
    800028b0:	85ca                	mv	a1,s2
    800028b2:	8526                	mv	a0,s1
    800028b4:	00001097          	auipc	ra,0x1
    800028b8:	e1e080e7          	jalr	-482(ra) # 800036d2 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    800028bc:	08848493          	add	s1,s1,136
    800028c0:	ff3498e3          	bne	s1,s3,800028b0 <iinit+0x3e>
}
    800028c4:	70a2                	ld	ra,40(sp)
    800028c6:	7402                	ld	s0,32(sp)
    800028c8:	64e2                	ld	s1,24(sp)
    800028ca:	6942                	ld	s2,16(sp)
    800028cc:	69a2                	ld	s3,8(sp)
    800028ce:	6145                	add	sp,sp,48
    800028d0:	8082                	ret

00000000800028d2 <ialloc>:
{
    800028d2:	7139                	add	sp,sp,-64
    800028d4:	fc06                	sd	ra,56(sp)
    800028d6:	f822                	sd	s0,48(sp)
    800028d8:	f426                	sd	s1,40(sp)
    800028da:	f04a                	sd	s2,32(sp)
    800028dc:	ec4e                	sd	s3,24(sp)
    800028de:	e852                	sd	s4,16(sp)
    800028e0:	e456                	sd	s5,8(sp)
    800028e2:	e05a                	sd	s6,0(sp)
    800028e4:	0080                	add	s0,sp,64
  for(inum = 1; inum < sb.ninodes; inum++){
    800028e6:	00015717          	auipc	a4,0x15
    800028ea:	c7e72703          	lw	a4,-898(a4) # 80017564 <sb+0xc>
    800028ee:	4785                	li	a5,1
    800028f0:	04e7f863          	bgeu	a5,a4,80002940 <ialloc+0x6e>
    800028f4:	8aaa                	mv	s5,a0
    800028f6:	8b2e                	mv	s6,a1
    800028f8:	4905                	li	s2,1
    bp = bread(dev, IBLOCK(inum, sb));
    800028fa:	00015a17          	auipc	s4,0x15
    800028fe:	c5ea0a13          	add	s4,s4,-930 # 80017558 <sb>
    80002902:	00495593          	srl	a1,s2,0x4
    80002906:	018a2783          	lw	a5,24(s4)
    8000290a:	9dbd                	addw	a1,a1,a5
    8000290c:	8556                	mv	a0,s5
    8000290e:	00000097          	auipc	ra,0x0
    80002912:	95e080e7          	jalr	-1698(ra) # 8000226c <bread>
    80002916:	84aa                	mv	s1,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    80002918:	05850993          	add	s3,a0,88
    8000291c:	00f97793          	and	a5,s2,15
    80002920:	079a                	sll	a5,a5,0x6
    80002922:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    80002924:	00099783          	lh	a5,0(s3)
    80002928:	c785                	beqz	a5,80002950 <ialloc+0x7e>
    brelse(bp);
    8000292a:	00000097          	auipc	ra,0x0
    8000292e:	a72080e7          	jalr	-1422(ra) # 8000239c <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    80002932:	0905                	add	s2,s2,1
    80002934:	00ca2703          	lw	a4,12(s4)
    80002938:	0009079b          	sext.w	a5,s2
    8000293c:	fce7e3e3          	bltu	a5,a4,80002902 <ialloc+0x30>
  panic("ialloc: no inodes");
    80002940:	00006517          	auipc	a0,0x6
    80002944:	bf050513          	add	a0,a0,-1040 # 80008530 <syscalls+0x168>
    80002948:	00003097          	auipc	ra,0x3
    8000294c:	132080e7          	jalr	306(ra) # 80005a7a <panic>
      memset(dip, 0, sizeof(*dip));
    80002950:	04000613          	li	a2,64
    80002954:	4581                	li	a1,0
    80002956:	854e                	mv	a0,s3
    80002958:	ffffe097          	auipc	ra,0xffffe
    8000295c:	822080e7          	jalr	-2014(ra) # 8000017a <memset>
      dip->type = type;
    80002960:	01699023          	sh	s6,0(s3)
      log_write(bp);   // mark it allocated on the disk
    80002964:	8526                	mv	a0,s1
    80002966:	00001097          	auipc	ra,0x1
    8000296a:	c88080e7          	jalr	-888(ra) # 800035ee <log_write>
      brelse(bp);
    8000296e:	8526                	mv	a0,s1
    80002970:	00000097          	auipc	ra,0x0
    80002974:	a2c080e7          	jalr	-1492(ra) # 8000239c <brelse>
      return iget(dev, inum);
    80002978:	0009059b          	sext.w	a1,s2
    8000297c:	8556                	mv	a0,s5
    8000297e:	00000097          	auipc	ra,0x0
    80002982:	db8080e7          	jalr	-584(ra) # 80002736 <iget>
}
    80002986:	70e2                	ld	ra,56(sp)
    80002988:	7442                	ld	s0,48(sp)
    8000298a:	74a2                	ld	s1,40(sp)
    8000298c:	7902                	ld	s2,32(sp)
    8000298e:	69e2                	ld	s3,24(sp)
    80002990:	6a42                	ld	s4,16(sp)
    80002992:	6aa2                	ld	s5,8(sp)
    80002994:	6b02                	ld	s6,0(sp)
    80002996:	6121                	add	sp,sp,64
    80002998:	8082                	ret

000000008000299a <iupdate>:
{
    8000299a:	1101                	add	sp,sp,-32
    8000299c:	ec06                	sd	ra,24(sp)
    8000299e:	e822                	sd	s0,16(sp)
    800029a0:	e426                	sd	s1,8(sp)
    800029a2:	e04a                	sd	s2,0(sp)
    800029a4:	1000                	add	s0,sp,32
    800029a6:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    800029a8:	415c                	lw	a5,4(a0)
    800029aa:	0047d79b          	srlw	a5,a5,0x4
    800029ae:	00015597          	auipc	a1,0x15
    800029b2:	bc25a583          	lw	a1,-1086(a1) # 80017570 <sb+0x18>
    800029b6:	9dbd                	addw	a1,a1,a5
    800029b8:	4108                	lw	a0,0(a0)
    800029ba:	00000097          	auipc	ra,0x0
    800029be:	8b2080e7          	jalr	-1870(ra) # 8000226c <bread>
    800029c2:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    800029c4:	05850793          	add	a5,a0,88
    800029c8:	40d8                	lw	a4,4(s1)
    800029ca:	8b3d                	and	a4,a4,15
    800029cc:	071a                	sll	a4,a4,0x6
    800029ce:	97ba                	add	a5,a5,a4
  dip->type = ip->type;
    800029d0:	04449703          	lh	a4,68(s1)
    800029d4:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    800029d8:	04649703          	lh	a4,70(s1)
    800029dc:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    800029e0:	04849703          	lh	a4,72(s1)
    800029e4:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    800029e8:	04a49703          	lh	a4,74(s1)
    800029ec:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    800029f0:	44f8                	lw	a4,76(s1)
    800029f2:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    800029f4:	03400613          	li	a2,52
    800029f8:	05048593          	add	a1,s1,80
    800029fc:	00c78513          	add	a0,a5,12
    80002a00:	ffffd097          	auipc	ra,0xffffd
    80002a04:	7d6080e7          	jalr	2006(ra) # 800001d6 <memmove>
  log_write(bp);
    80002a08:	854a                	mv	a0,s2
    80002a0a:	00001097          	auipc	ra,0x1
    80002a0e:	be4080e7          	jalr	-1052(ra) # 800035ee <log_write>
  brelse(bp);
    80002a12:	854a                	mv	a0,s2
    80002a14:	00000097          	auipc	ra,0x0
    80002a18:	988080e7          	jalr	-1656(ra) # 8000239c <brelse>
}
    80002a1c:	60e2                	ld	ra,24(sp)
    80002a1e:	6442                	ld	s0,16(sp)
    80002a20:	64a2                	ld	s1,8(sp)
    80002a22:	6902                	ld	s2,0(sp)
    80002a24:	6105                	add	sp,sp,32
    80002a26:	8082                	ret

0000000080002a28 <idup>:
{
    80002a28:	1101                	add	sp,sp,-32
    80002a2a:	ec06                	sd	ra,24(sp)
    80002a2c:	e822                	sd	s0,16(sp)
    80002a2e:	e426                	sd	s1,8(sp)
    80002a30:	1000                	add	s0,sp,32
    80002a32:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002a34:	00015517          	auipc	a0,0x15
    80002a38:	b4450513          	add	a0,a0,-1212 # 80017578 <itable>
    80002a3c:	00003097          	auipc	ra,0x3
    80002a40:	576080e7          	jalr	1398(ra) # 80005fb2 <acquire>
  ip->ref++;
    80002a44:	449c                	lw	a5,8(s1)
    80002a46:	2785                	addw	a5,a5,1
    80002a48:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002a4a:	00015517          	auipc	a0,0x15
    80002a4e:	b2e50513          	add	a0,a0,-1234 # 80017578 <itable>
    80002a52:	00003097          	auipc	ra,0x3
    80002a56:	614080e7          	jalr	1556(ra) # 80006066 <release>
}
    80002a5a:	8526                	mv	a0,s1
    80002a5c:	60e2                	ld	ra,24(sp)
    80002a5e:	6442                	ld	s0,16(sp)
    80002a60:	64a2                	ld	s1,8(sp)
    80002a62:	6105                	add	sp,sp,32
    80002a64:	8082                	ret

0000000080002a66 <ilock>:
{
    80002a66:	1101                	add	sp,sp,-32
    80002a68:	ec06                	sd	ra,24(sp)
    80002a6a:	e822                	sd	s0,16(sp)
    80002a6c:	e426                	sd	s1,8(sp)
    80002a6e:	e04a                	sd	s2,0(sp)
    80002a70:	1000                	add	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    80002a72:	c115                	beqz	a0,80002a96 <ilock+0x30>
    80002a74:	84aa                	mv	s1,a0
    80002a76:	451c                	lw	a5,8(a0)
    80002a78:	00f05f63          	blez	a5,80002a96 <ilock+0x30>
  acquiresleep(&ip->lock);
    80002a7c:	0541                	add	a0,a0,16
    80002a7e:	00001097          	auipc	ra,0x1
    80002a82:	c8e080e7          	jalr	-882(ra) # 8000370c <acquiresleep>
  if(ip->valid == 0){
    80002a86:	40bc                	lw	a5,64(s1)
    80002a88:	cf99                	beqz	a5,80002aa6 <ilock+0x40>
}
    80002a8a:	60e2                	ld	ra,24(sp)
    80002a8c:	6442                	ld	s0,16(sp)
    80002a8e:	64a2                	ld	s1,8(sp)
    80002a90:	6902                	ld	s2,0(sp)
    80002a92:	6105                	add	sp,sp,32
    80002a94:	8082                	ret
    panic("ilock");
    80002a96:	00006517          	auipc	a0,0x6
    80002a9a:	ab250513          	add	a0,a0,-1358 # 80008548 <syscalls+0x180>
    80002a9e:	00003097          	auipc	ra,0x3
    80002aa2:	fdc080e7          	jalr	-36(ra) # 80005a7a <panic>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002aa6:	40dc                	lw	a5,4(s1)
    80002aa8:	0047d79b          	srlw	a5,a5,0x4
    80002aac:	00015597          	auipc	a1,0x15
    80002ab0:	ac45a583          	lw	a1,-1340(a1) # 80017570 <sb+0x18>
    80002ab4:	9dbd                	addw	a1,a1,a5
    80002ab6:	4088                	lw	a0,0(s1)
    80002ab8:	fffff097          	auipc	ra,0xfffff
    80002abc:	7b4080e7          	jalr	1972(ra) # 8000226c <bread>
    80002ac0:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002ac2:	05850593          	add	a1,a0,88
    80002ac6:	40dc                	lw	a5,4(s1)
    80002ac8:	8bbd                	and	a5,a5,15
    80002aca:	079a                	sll	a5,a5,0x6
    80002acc:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    80002ace:	00059783          	lh	a5,0(a1)
    80002ad2:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    80002ad6:	00259783          	lh	a5,2(a1)
    80002ada:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    80002ade:	00459783          	lh	a5,4(a1)
    80002ae2:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    80002ae6:	00659783          	lh	a5,6(a1)
    80002aea:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    80002aee:	459c                	lw	a5,8(a1)
    80002af0:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80002af2:	03400613          	li	a2,52
    80002af6:	05b1                	add	a1,a1,12
    80002af8:	05048513          	add	a0,s1,80
    80002afc:	ffffd097          	auipc	ra,0xffffd
    80002b00:	6da080e7          	jalr	1754(ra) # 800001d6 <memmove>
    brelse(bp);
    80002b04:	854a                	mv	a0,s2
    80002b06:	00000097          	auipc	ra,0x0
    80002b0a:	896080e7          	jalr	-1898(ra) # 8000239c <brelse>
    ip->valid = 1;
    80002b0e:	4785                	li	a5,1
    80002b10:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    80002b12:	04449783          	lh	a5,68(s1)
    80002b16:	fbb5                	bnez	a5,80002a8a <ilock+0x24>
      panic("ilock: no type");
    80002b18:	00006517          	auipc	a0,0x6
    80002b1c:	a3850513          	add	a0,a0,-1480 # 80008550 <syscalls+0x188>
    80002b20:	00003097          	auipc	ra,0x3
    80002b24:	f5a080e7          	jalr	-166(ra) # 80005a7a <panic>

0000000080002b28 <iunlock>:
{
    80002b28:	1101                	add	sp,sp,-32
    80002b2a:	ec06                	sd	ra,24(sp)
    80002b2c:	e822                	sd	s0,16(sp)
    80002b2e:	e426                	sd	s1,8(sp)
    80002b30:	e04a                	sd	s2,0(sp)
    80002b32:	1000                	add	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80002b34:	c905                	beqz	a0,80002b64 <iunlock+0x3c>
    80002b36:	84aa                	mv	s1,a0
    80002b38:	01050913          	add	s2,a0,16
    80002b3c:	854a                	mv	a0,s2
    80002b3e:	00001097          	auipc	ra,0x1
    80002b42:	c68080e7          	jalr	-920(ra) # 800037a6 <holdingsleep>
    80002b46:	cd19                	beqz	a0,80002b64 <iunlock+0x3c>
    80002b48:	449c                	lw	a5,8(s1)
    80002b4a:	00f05d63          	blez	a5,80002b64 <iunlock+0x3c>
  releasesleep(&ip->lock);
    80002b4e:	854a                	mv	a0,s2
    80002b50:	00001097          	auipc	ra,0x1
    80002b54:	c12080e7          	jalr	-1006(ra) # 80003762 <releasesleep>
}
    80002b58:	60e2                	ld	ra,24(sp)
    80002b5a:	6442                	ld	s0,16(sp)
    80002b5c:	64a2                	ld	s1,8(sp)
    80002b5e:	6902                	ld	s2,0(sp)
    80002b60:	6105                	add	sp,sp,32
    80002b62:	8082                	ret
    panic("iunlock");
    80002b64:	00006517          	auipc	a0,0x6
    80002b68:	9fc50513          	add	a0,a0,-1540 # 80008560 <syscalls+0x198>
    80002b6c:	00003097          	auipc	ra,0x3
    80002b70:	f0e080e7          	jalr	-242(ra) # 80005a7a <panic>

0000000080002b74 <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    80002b74:	7179                	add	sp,sp,-48
    80002b76:	f406                	sd	ra,40(sp)
    80002b78:	f022                	sd	s0,32(sp)
    80002b7a:	ec26                	sd	s1,24(sp)
    80002b7c:	e84a                	sd	s2,16(sp)
    80002b7e:	e44e                	sd	s3,8(sp)
    80002b80:	e052                	sd	s4,0(sp)
    80002b82:	1800                	add	s0,sp,48
    80002b84:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80002b86:	05050493          	add	s1,a0,80
    80002b8a:	08050913          	add	s2,a0,128
    80002b8e:	a021                	j	80002b96 <itrunc+0x22>
    80002b90:	0491                	add	s1,s1,4
    80002b92:	01248d63          	beq	s1,s2,80002bac <itrunc+0x38>
    if(ip->addrs[i]){
    80002b96:	408c                	lw	a1,0(s1)
    80002b98:	dde5                	beqz	a1,80002b90 <itrunc+0x1c>
      bfree(ip->dev, ip->addrs[i]);
    80002b9a:	0009a503          	lw	a0,0(s3)
    80002b9e:	00000097          	auipc	ra,0x0
    80002ba2:	912080e7          	jalr	-1774(ra) # 800024b0 <bfree>
      ip->addrs[i] = 0;
    80002ba6:	0004a023          	sw	zero,0(s1)
    80002baa:	b7dd                	j	80002b90 <itrunc+0x1c>
    }
  }

  if(ip->addrs[NDIRECT]){
    80002bac:	0809a583          	lw	a1,128(s3)
    80002bb0:	e185                	bnez	a1,80002bd0 <itrunc+0x5c>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    80002bb2:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    80002bb6:	854e                	mv	a0,s3
    80002bb8:	00000097          	auipc	ra,0x0
    80002bbc:	de2080e7          	jalr	-542(ra) # 8000299a <iupdate>
}
    80002bc0:	70a2                	ld	ra,40(sp)
    80002bc2:	7402                	ld	s0,32(sp)
    80002bc4:	64e2                	ld	s1,24(sp)
    80002bc6:	6942                	ld	s2,16(sp)
    80002bc8:	69a2                	ld	s3,8(sp)
    80002bca:	6a02                	ld	s4,0(sp)
    80002bcc:	6145                	add	sp,sp,48
    80002bce:	8082                	ret
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80002bd0:	0009a503          	lw	a0,0(s3)
    80002bd4:	fffff097          	auipc	ra,0xfffff
    80002bd8:	698080e7          	jalr	1688(ra) # 8000226c <bread>
    80002bdc:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    80002bde:	05850493          	add	s1,a0,88
    80002be2:	45850913          	add	s2,a0,1112
    80002be6:	a021                	j	80002bee <itrunc+0x7a>
    80002be8:	0491                	add	s1,s1,4
    80002bea:	01248b63          	beq	s1,s2,80002c00 <itrunc+0x8c>
      if(a[j])
    80002bee:	408c                	lw	a1,0(s1)
    80002bf0:	dde5                	beqz	a1,80002be8 <itrunc+0x74>
        bfree(ip->dev, a[j]);
    80002bf2:	0009a503          	lw	a0,0(s3)
    80002bf6:	00000097          	auipc	ra,0x0
    80002bfa:	8ba080e7          	jalr	-1862(ra) # 800024b0 <bfree>
    80002bfe:	b7ed                	j	80002be8 <itrunc+0x74>
    brelse(bp);
    80002c00:	8552                	mv	a0,s4
    80002c02:	fffff097          	auipc	ra,0xfffff
    80002c06:	79a080e7          	jalr	1946(ra) # 8000239c <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80002c0a:	0809a583          	lw	a1,128(s3)
    80002c0e:	0009a503          	lw	a0,0(s3)
    80002c12:	00000097          	auipc	ra,0x0
    80002c16:	89e080e7          	jalr	-1890(ra) # 800024b0 <bfree>
    ip->addrs[NDIRECT] = 0;
    80002c1a:	0809a023          	sw	zero,128(s3)
    80002c1e:	bf51                	j	80002bb2 <itrunc+0x3e>

0000000080002c20 <iput>:
{
    80002c20:	1101                	add	sp,sp,-32
    80002c22:	ec06                	sd	ra,24(sp)
    80002c24:	e822                	sd	s0,16(sp)
    80002c26:	e426                	sd	s1,8(sp)
    80002c28:	e04a                	sd	s2,0(sp)
    80002c2a:	1000                	add	s0,sp,32
    80002c2c:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002c2e:	00015517          	auipc	a0,0x15
    80002c32:	94a50513          	add	a0,a0,-1718 # 80017578 <itable>
    80002c36:	00003097          	auipc	ra,0x3
    80002c3a:	37c080e7          	jalr	892(ra) # 80005fb2 <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002c3e:	4498                	lw	a4,8(s1)
    80002c40:	4785                	li	a5,1
    80002c42:	02f70363          	beq	a4,a5,80002c68 <iput+0x48>
  ip->ref--;
    80002c46:	449c                	lw	a5,8(s1)
    80002c48:	37fd                	addw	a5,a5,-1
    80002c4a:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002c4c:	00015517          	auipc	a0,0x15
    80002c50:	92c50513          	add	a0,a0,-1748 # 80017578 <itable>
    80002c54:	00003097          	auipc	ra,0x3
    80002c58:	412080e7          	jalr	1042(ra) # 80006066 <release>
}
    80002c5c:	60e2                	ld	ra,24(sp)
    80002c5e:	6442                	ld	s0,16(sp)
    80002c60:	64a2                	ld	s1,8(sp)
    80002c62:	6902                	ld	s2,0(sp)
    80002c64:	6105                	add	sp,sp,32
    80002c66:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002c68:	40bc                	lw	a5,64(s1)
    80002c6a:	dff1                	beqz	a5,80002c46 <iput+0x26>
    80002c6c:	04a49783          	lh	a5,74(s1)
    80002c70:	fbf9                	bnez	a5,80002c46 <iput+0x26>
    acquiresleep(&ip->lock);
    80002c72:	01048913          	add	s2,s1,16
    80002c76:	854a                	mv	a0,s2
    80002c78:	00001097          	auipc	ra,0x1
    80002c7c:	a94080e7          	jalr	-1388(ra) # 8000370c <acquiresleep>
    release(&itable.lock);
    80002c80:	00015517          	auipc	a0,0x15
    80002c84:	8f850513          	add	a0,a0,-1800 # 80017578 <itable>
    80002c88:	00003097          	auipc	ra,0x3
    80002c8c:	3de080e7          	jalr	990(ra) # 80006066 <release>
    itrunc(ip);
    80002c90:	8526                	mv	a0,s1
    80002c92:	00000097          	auipc	ra,0x0
    80002c96:	ee2080e7          	jalr	-286(ra) # 80002b74 <itrunc>
    ip->type = 0;
    80002c9a:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    80002c9e:	8526                	mv	a0,s1
    80002ca0:	00000097          	auipc	ra,0x0
    80002ca4:	cfa080e7          	jalr	-774(ra) # 8000299a <iupdate>
    ip->valid = 0;
    80002ca8:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    80002cac:	854a                	mv	a0,s2
    80002cae:	00001097          	auipc	ra,0x1
    80002cb2:	ab4080e7          	jalr	-1356(ra) # 80003762 <releasesleep>
    acquire(&itable.lock);
    80002cb6:	00015517          	auipc	a0,0x15
    80002cba:	8c250513          	add	a0,a0,-1854 # 80017578 <itable>
    80002cbe:	00003097          	auipc	ra,0x3
    80002cc2:	2f4080e7          	jalr	756(ra) # 80005fb2 <acquire>
    80002cc6:	b741                	j	80002c46 <iput+0x26>

0000000080002cc8 <iunlockput>:
{
    80002cc8:	1101                	add	sp,sp,-32
    80002cca:	ec06                	sd	ra,24(sp)
    80002ccc:	e822                	sd	s0,16(sp)
    80002cce:	e426                	sd	s1,8(sp)
    80002cd0:	1000                	add	s0,sp,32
    80002cd2:	84aa                	mv	s1,a0
  iunlock(ip);
    80002cd4:	00000097          	auipc	ra,0x0
    80002cd8:	e54080e7          	jalr	-428(ra) # 80002b28 <iunlock>
  iput(ip);
    80002cdc:	8526                	mv	a0,s1
    80002cde:	00000097          	auipc	ra,0x0
    80002ce2:	f42080e7          	jalr	-190(ra) # 80002c20 <iput>
}
    80002ce6:	60e2                	ld	ra,24(sp)
    80002ce8:	6442                	ld	s0,16(sp)
    80002cea:	64a2                	ld	s1,8(sp)
    80002cec:	6105                	add	sp,sp,32
    80002cee:	8082                	ret

0000000080002cf0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80002cf0:	1141                	add	sp,sp,-16
    80002cf2:	e422                	sd	s0,8(sp)
    80002cf4:	0800                	add	s0,sp,16
  st->dev = ip->dev;
    80002cf6:	411c                	lw	a5,0(a0)
    80002cf8:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    80002cfa:	415c                	lw	a5,4(a0)
    80002cfc:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    80002cfe:	04451783          	lh	a5,68(a0)
    80002d02:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    80002d06:	04a51783          	lh	a5,74(a0)
    80002d0a:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    80002d0e:	04c56783          	lwu	a5,76(a0)
    80002d12:	e99c                	sd	a5,16(a1)
}
    80002d14:	6422                	ld	s0,8(sp)
    80002d16:	0141                	add	sp,sp,16
    80002d18:	8082                	ret

0000000080002d1a <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80002d1a:	457c                	lw	a5,76(a0)
    80002d1c:	0ed7e963          	bltu	a5,a3,80002e0e <readi+0xf4>
{
    80002d20:	7159                	add	sp,sp,-112
    80002d22:	f486                	sd	ra,104(sp)
    80002d24:	f0a2                	sd	s0,96(sp)
    80002d26:	eca6                	sd	s1,88(sp)
    80002d28:	e8ca                	sd	s2,80(sp)
    80002d2a:	e4ce                	sd	s3,72(sp)
    80002d2c:	e0d2                	sd	s4,64(sp)
    80002d2e:	fc56                	sd	s5,56(sp)
    80002d30:	f85a                	sd	s6,48(sp)
    80002d32:	f45e                	sd	s7,40(sp)
    80002d34:	f062                	sd	s8,32(sp)
    80002d36:	ec66                	sd	s9,24(sp)
    80002d38:	e86a                	sd	s10,16(sp)
    80002d3a:	e46e                	sd	s11,8(sp)
    80002d3c:	1880                	add	s0,sp,112
    80002d3e:	8baa                	mv	s7,a0
    80002d40:	8c2e                	mv	s8,a1
    80002d42:	8ab2                	mv	s5,a2
    80002d44:	84b6                	mv	s1,a3
    80002d46:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    80002d48:	9f35                	addw	a4,a4,a3
    return 0;
    80002d4a:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    80002d4c:	0ad76063          	bltu	a4,a3,80002dec <readi+0xd2>
  if(off + n > ip->size)
    80002d50:	00e7f463          	bgeu	a5,a4,80002d58 <readi+0x3e>
    n = ip->size - off;
    80002d54:	40d78b3b          	subw	s6,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002d58:	0a0b0963          	beqz	s6,80002e0a <readi+0xf0>
    80002d5c:	4981                	li	s3,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    80002d5e:	40000d13          	li	s10,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80002d62:	5cfd                	li	s9,-1
    80002d64:	a82d                	j	80002d9e <readi+0x84>
    80002d66:	020a1d93          	sll	s11,s4,0x20
    80002d6a:	020ddd93          	srl	s11,s11,0x20
    80002d6e:	05890613          	add	a2,s2,88
    80002d72:	86ee                	mv	a3,s11
    80002d74:	963a                	add	a2,a2,a4
    80002d76:	85d6                	mv	a1,s5
    80002d78:	8562                	mv	a0,s8
    80002d7a:	fffff097          	auipc	ra,0xfffff
    80002d7e:	b30080e7          	jalr	-1232(ra) # 800018aa <either_copyout>
    80002d82:	05950d63          	beq	a0,s9,80002ddc <readi+0xc2>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    80002d86:	854a                	mv	a0,s2
    80002d88:	fffff097          	auipc	ra,0xfffff
    80002d8c:	614080e7          	jalr	1556(ra) # 8000239c <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002d90:	013a09bb          	addw	s3,s4,s3
    80002d94:	009a04bb          	addw	s1,s4,s1
    80002d98:	9aee                	add	s5,s5,s11
    80002d9a:	0569f763          	bgeu	s3,s6,80002de8 <readi+0xce>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80002d9e:	000ba903          	lw	s2,0(s7)
    80002da2:	00a4d59b          	srlw	a1,s1,0xa
    80002da6:	855e                	mv	a0,s7
    80002da8:	00000097          	auipc	ra,0x0
    80002dac:	8b2080e7          	jalr	-1870(ra) # 8000265a <bmap>
    80002db0:	0005059b          	sext.w	a1,a0
    80002db4:	854a                	mv	a0,s2
    80002db6:	fffff097          	auipc	ra,0xfffff
    80002dba:	4b6080e7          	jalr	1206(ra) # 8000226c <bread>
    80002dbe:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80002dc0:	3ff4f713          	and	a4,s1,1023
    80002dc4:	40ed07bb          	subw	a5,s10,a4
    80002dc8:	413b06bb          	subw	a3,s6,s3
    80002dcc:	8a3e                	mv	s4,a5
    80002dce:	2781                	sext.w	a5,a5
    80002dd0:	0006861b          	sext.w	a2,a3
    80002dd4:	f8f679e3          	bgeu	a2,a5,80002d66 <readi+0x4c>
    80002dd8:	8a36                	mv	s4,a3
    80002dda:	b771                	j	80002d66 <readi+0x4c>
      brelse(bp);
    80002ddc:	854a                	mv	a0,s2
    80002dde:	fffff097          	auipc	ra,0xfffff
    80002de2:	5be080e7          	jalr	1470(ra) # 8000239c <brelse>
      tot = -1;
    80002de6:	59fd                	li	s3,-1
  }
  return tot;
    80002de8:	0009851b          	sext.w	a0,s3
}
    80002dec:	70a6                	ld	ra,104(sp)
    80002dee:	7406                	ld	s0,96(sp)
    80002df0:	64e6                	ld	s1,88(sp)
    80002df2:	6946                	ld	s2,80(sp)
    80002df4:	69a6                	ld	s3,72(sp)
    80002df6:	6a06                	ld	s4,64(sp)
    80002df8:	7ae2                	ld	s5,56(sp)
    80002dfa:	7b42                	ld	s6,48(sp)
    80002dfc:	7ba2                	ld	s7,40(sp)
    80002dfe:	7c02                	ld	s8,32(sp)
    80002e00:	6ce2                	ld	s9,24(sp)
    80002e02:	6d42                	ld	s10,16(sp)
    80002e04:	6da2                	ld	s11,8(sp)
    80002e06:	6165                	add	sp,sp,112
    80002e08:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002e0a:	89da                	mv	s3,s6
    80002e0c:	bff1                	j	80002de8 <readi+0xce>
    return 0;
    80002e0e:	4501                	li	a0,0
}
    80002e10:	8082                	ret

0000000080002e12 <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80002e12:	457c                	lw	a5,76(a0)
    80002e14:	10d7e863          	bltu	a5,a3,80002f24 <writei+0x112>
{
    80002e18:	7159                	add	sp,sp,-112
    80002e1a:	f486                	sd	ra,104(sp)
    80002e1c:	f0a2                	sd	s0,96(sp)
    80002e1e:	eca6                	sd	s1,88(sp)
    80002e20:	e8ca                	sd	s2,80(sp)
    80002e22:	e4ce                	sd	s3,72(sp)
    80002e24:	e0d2                	sd	s4,64(sp)
    80002e26:	fc56                	sd	s5,56(sp)
    80002e28:	f85a                	sd	s6,48(sp)
    80002e2a:	f45e                	sd	s7,40(sp)
    80002e2c:	f062                	sd	s8,32(sp)
    80002e2e:	ec66                	sd	s9,24(sp)
    80002e30:	e86a                	sd	s10,16(sp)
    80002e32:	e46e                	sd	s11,8(sp)
    80002e34:	1880                	add	s0,sp,112
    80002e36:	8b2a                	mv	s6,a0
    80002e38:	8c2e                	mv	s8,a1
    80002e3a:	8ab2                	mv	s5,a2
    80002e3c:	8936                	mv	s2,a3
    80002e3e:	8bba                	mv	s7,a4
  if(off > ip->size || off + n < off)
    80002e40:	00e687bb          	addw	a5,a3,a4
    80002e44:	0ed7e263          	bltu	a5,a3,80002f28 <writei+0x116>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    80002e48:	00043737          	lui	a4,0x43
    80002e4c:	0ef76063          	bltu	a4,a5,80002f2c <writei+0x11a>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002e50:	0c0b8863          	beqz	s7,80002f20 <writei+0x10e>
    80002e54:	4a01                	li	s4,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    80002e56:	40000d13          	li	s10,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80002e5a:	5cfd                	li	s9,-1
    80002e5c:	a091                	j	80002ea0 <writei+0x8e>
    80002e5e:	02099d93          	sll	s11,s3,0x20
    80002e62:	020ddd93          	srl	s11,s11,0x20
    80002e66:	05848513          	add	a0,s1,88
    80002e6a:	86ee                	mv	a3,s11
    80002e6c:	8656                	mv	a2,s5
    80002e6e:	85e2                	mv	a1,s8
    80002e70:	953a                	add	a0,a0,a4
    80002e72:	fffff097          	auipc	ra,0xfffff
    80002e76:	a8e080e7          	jalr	-1394(ra) # 80001900 <either_copyin>
    80002e7a:	07950263          	beq	a0,s9,80002ede <writei+0xcc>
      brelse(bp);
      break;
    }
    log_write(bp);
    80002e7e:	8526                	mv	a0,s1
    80002e80:	00000097          	auipc	ra,0x0
    80002e84:	76e080e7          	jalr	1902(ra) # 800035ee <log_write>
    brelse(bp);
    80002e88:	8526                	mv	a0,s1
    80002e8a:	fffff097          	auipc	ra,0xfffff
    80002e8e:	512080e7          	jalr	1298(ra) # 8000239c <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002e92:	01498a3b          	addw	s4,s3,s4
    80002e96:	0129893b          	addw	s2,s3,s2
    80002e9a:	9aee                	add	s5,s5,s11
    80002e9c:	057a7663          	bgeu	s4,s7,80002ee8 <writei+0xd6>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80002ea0:	000b2483          	lw	s1,0(s6)
    80002ea4:	00a9559b          	srlw	a1,s2,0xa
    80002ea8:	855a                	mv	a0,s6
    80002eaa:	fffff097          	auipc	ra,0xfffff
    80002eae:	7b0080e7          	jalr	1968(ra) # 8000265a <bmap>
    80002eb2:	0005059b          	sext.w	a1,a0
    80002eb6:	8526                	mv	a0,s1
    80002eb8:	fffff097          	auipc	ra,0xfffff
    80002ebc:	3b4080e7          	jalr	948(ra) # 8000226c <bread>
    80002ec0:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80002ec2:	3ff97713          	and	a4,s2,1023
    80002ec6:	40ed07bb          	subw	a5,s10,a4
    80002eca:	414b86bb          	subw	a3,s7,s4
    80002ece:	89be                	mv	s3,a5
    80002ed0:	2781                	sext.w	a5,a5
    80002ed2:	0006861b          	sext.w	a2,a3
    80002ed6:	f8f674e3          	bgeu	a2,a5,80002e5e <writei+0x4c>
    80002eda:	89b6                	mv	s3,a3
    80002edc:	b749                	j	80002e5e <writei+0x4c>
      brelse(bp);
    80002ede:	8526                	mv	a0,s1
    80002ee0:	fffff097          	auipc	ra,0xfffff
    80002ee4:	4bc080e7          	jalr	1212(ra) # 8000239c <brelse>
  }

  if(off > ip->size)
    80002ee8:	04cb2783          	lw	a5,76(s6)
    80002eec:	0127f463          	bgeu	a5,s2,80002ef4 <writei+0xe2>
    ip->size = off;
    80002ef0:	052b2623          	sw	s2,76(s6)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    80002ef4:	855a                	mv	a0,s6
    80002ef6:	00000097          	auipc	ra,0x0
    80002efa:	aa4080e7          	jalr	-1372(ra) # 8000299a <iupdate>

  return tot;
    80002efe:	000a051b          	sext.w	a0,s4
}
    80002f02:	70a6                	ld	ra,104(sp)
    80002f04:	7406                	ld	s0,96(sp)
    80002f06:	64e6                	ld	s1,88(sp)
    80002f08:	6946                	ld	s2,80(sp)
    80002f0a:	69a6                	ld	s3,72(sp)
    80002f0c:	6a06                	ld	s4,64(sp)
    80002f0e:	7ae2                	ld	s5,56(sp)
    80002f10:	7b42                	ld	s6,48(sp)
    80002f12:	7ba2                	ld	s7,40(sp)
    80002f14:	7c02                	ld	s8,32(sp)
    80002f16:	6ce2                	ld	s9,24(sp)
    80002f18:	6d42                	ld	s10,16(sp)
    80002f1a:	6da2                	ld	s11,8(sp)
    80002f1c:	6165                	add	sp,sp,112
    80002f1e:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002f20:	8a5e                	mv	s4,s7
    80002f22:	bfc9                	j	80002ef4 <writei+0xe2>
    return -1;
    80002f24:	557d                	li	a0,-1
}
    80002f26:	8082                	ret
    return -1;
    80002f28:	557d                	li	a0,-1
    80002f2a:	bfe1                	j	80002f02 <writei+0xf0>
    return -1;
    80002f2c:	557d                	li	a0,-1
    80002f2e:	bfd1                	j	80002f02 <writei+0xf0>

0000000080002f30 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80002f30:	1141                	add	sp,sp,-16
    80002f32:	e406                	sd	ra,8(sp)
    80002f34:	e022                	sd	s0,0(sp)
    80002f36:	0800                	add	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    80002f38:	4639                	li	a2,14
    80002f3a:	ffffd097          	auipc	ra,0xffffd
    80002f3e:	310080e7          	jalr	784(ra) # 8000024a <strncmp>
}
    80002f42:	60a2                	ld	ra,8(sp)
    80002f44:	6402                	ld	s0,0(sp)
    80002f46:	0141                	add	sp,sp,16
    80002f48:	8082                	ret

0000000080002f4a <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    80002f4a:	7139                	add	sp,sp,-64
    80002f4c:	fc06                	sd	ra,56(sp)
    80002f4e:	f822                	sd	s0,48(sp)
    80002f50:	f426                	sd	s1,40(sp)
    80002f52:	f04a                	sd	s2,32(sp)
    80002f54:	ec4e                	sd	s3,24(sp)
    80002f56:	e852                	sd	s4,16(sp)
    80002f58:	0080                	add	s0,sp,64
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    80002f5a:	04451703          	lh	a4,68(a0)
    80002f5e:	4785                	li	a5,1
    80002f60:	00f71a63          	bne	a4,a5,80002f74 <dirlookup+0x2a>
    80002f64:	892a                	mv	s2,a0
    80002f66:	89ae                	mv	s3,a1
    80002f68:	8a32                	mv	s4,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    80002f6a:	457c                	lw	a5,76(a0)
    80002f6c:	4481                	li	s1,0
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    80002f6e:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    80002f70:	e79d                	bnez	a5,80002f9e <dirlookup+0x54>
    80002f72:	a8a5                	j	80002fea <dirlookup+0xa0>
    panic("dirlookup not DIR");
    80002f74:	00005517          	auipc	a0,0x5
    80002f78:	5f450513          	add	a0,a0,1524 # 80008568 <syscalls+0x1a0>
    80002f7c:	00003097          	auipc	ra,0x3
    80002f80:	afe080e7          	jalr	-1282(ra) # 80005a7a <panic>
      panic("dirlookup read");
    80002f84:	00005517          	auipc	a0,0x5
    80002f88:	5fc50513          	add	a0,a0,1532 # 80008580 <syscalls+0x1b8>
    80002f8c:	00003097          	auipc	ra,0x3
    80002f90:	aee080e7          	jalr	-1298(ra) # 80005a7a <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80002f94:	24c1                	addw	s1,s1,16
    80002f96:	04c92783          	lw	a5,76(s2)
    80002f9a:	04f4f763          	bgeu	s1,a5,80002fe8 <dirlookup+0x9e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80002f9e:	4741                	li	a4,16
    80002fa0:	86a6                	mv	a3,s1
    80002fa2:	fc040613          	add	a2,s0,-64
    80002fa6:	4581                	li	a1,0
    80002fa8:	854a                	mv	a0,s2
    80002faa:	00000097          	auipc	ra,0x0
    80002fae:	d70080e7          	jalr	-656(ra) # 80002d1a <readi>
    80002fb2:	47c1                	li	a5,16
    80002fb4:	fcf518e3          	bne	a0,a5,80002f84 <dirlookup+0x3a>
    if(de.inum == 0)
    80002fb8:	fc045783          	lhu	a5,-64(s0)
    80002fbc:	dfe1                	beqz	a5,80002f94 <dirlookup+0x4a>
    if(namecmp(name, de.name) == 0){
    80002fbe:	fc240593          	add	a1,s0,-62
    80002fc2:	854e                	mv	a0,s3
    80002fc4:	00000097          	auipc	ra,0x0
    80002fc8:	f6c080e7          	jalr	-148(ra) # 80002f30 <namecmp>
    80002fcc:	f561                	bnez	a0,80002f94 <dirlookup+0x4a>
      if(poff)
    80002fce:	000a0463          	beqz	s4,80002fd6 <dirlookup+0x8c>
        *poff = off;
    80002fd2:	009a2023          	sw	s1,0(s4)
      return iget(dp->dev, inum);
    80002fd6:	fc045583          	lhu	a1,-64(s0)
    80002fda:	00092503          	lw	a0,0(s2)
    80002fde:	fffff097          	auipc	ra,0xfffff
    80002fe2:	758080e7          	jalr	1880(ra) # 80002736 <iget>
    80002fe6:	a011                	j	80002fea <dirlookup+0xa0>
  return 0;
    80002fe8:	4501                	li	a0,0
}
    80002fea:	70e2                	ld	ra,56(sp)
    80002fec:	7442                	ld	s0,48(sp)
    80002fee:	74a2                	ld	s1,40(sp)
    80002ff0:	7902                	ld	s2,32(sp)
    80002ff2:	69e2                	ld	s3,24(sp)
    80002ff4:	6a42                	ld	s4,16(sp)
    80002ff6:	6121                	add	sp,sp,64
    80002ff8:	8082                	ret

0000000080002ffa <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80002ffa:	711d                	add	sp,sp,-96
    80002ffc:	ec86                	sd	ra,88(sp)
    80002ffe:	e8a2                	sd	s0,80(sp)
    80003000:	e4a6                	sd	s1,72(sp)
    80003002:	e0ca                	sd	s2,64(sp)
    80003004:	fc4e                	sd	s3,56(sp)
    80003006:	f852                	sd	s4,48(sp)
    80003008:	f456                	sd	s5,40(sp)
    8000300a:	f05a                	sd	s6,32(sp)
    8000300c:	ec5e                	sd	s7,24(sp)
    8000300e:	e862                	sd	s8,16(sp)
    80003010:	e466                	sd	s9,8(sp)
    80003012:	1080                	add	s0,sp,96
    80003014:	84aa                	mv	s1,a0
    80003016:	8b2e                	mv	s6,a1
    80003018:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if(*path == '/')
    8000301a:	00054703          	lbu	a4,0(a0)
    8000301e:	02f00793          	li	a5,47
    80003022:	02f70263          	beq	a4,a5,80003046 <namex+0x4c>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    80003026:	ffffe097          	auipc	ra,0xffffe
    8000302a:	e1c080e7          	jalr	-484(ra) # 80000e42 <myproc>
    8000302e:	15053503          	ld	a0,336(a0)
    80003032:	00000097          	auipc	ra,0x0
    80003036:	9f6080e7          	jalr	-1546(ra) # 80002a28 <idup>
    8000303a:	8a2a                	mv	s4,a0
  while(*path == '/')
    8000303c:	02f00913          	li	s2,47
  if(len >= DIRSIZ)
    80003040:	4c35                	li	s8,13

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    80003042:	4b85                	li	s7,1
    80003044:	a875                	j	80003100 <namex+0x106>
    ip = iget(ROOTDEV, ROOTINO);
    80003046:	4585                	li	a1,1
    80003048:	4505                	li	a0,1
    8000304a:	fffff097          	auipc	ra,0xfffff
    8000304e:	6ec080e7          	jalr	1772(ra) # 80002736 <iget>
    80003052:	8a2a                	mv	s4,a0
    80003054:	b7e5                	j	8000303c <namex+0x42>
      iunlockput(ip);
    80003056:	8552                	mv	a0,s4
    80003058:	00000097          	auipc	ra,0x0
    8000305c:	c70080e7          	jalr	-912(ra) # 80002cc8 <iunlockput>
      return 0;
    80003060:	4a01                	li	s4,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    80003062:	8552                	mv	a0,s4
    80003064:	60e6                	ld	ra,88(sp)
    80003066:	6446                	ld	s0,80(sp)
    80003068:	64a6                	ld	s1,72(sp)
    8000306a:	6906                	ld	s2,64(sp)
    8000306c:	79e2                	ld	s3,56(sp)
    8000306e:	7a42                	ld	s4,48(sp)
    80003070:	7aa2                	ld	s5,40(sp)
    80003072:	7b02                	ld	s6,32(sp)
    80003074:	6be2                	ld	s7,24(sp)
    80003076:	6c42                	ld	s8,16(sp)
    80003078:	6ca2                	ld	s9,8(sp)
    8000307a:	6125                	add	sp,sp,96
    8000307c:	8082                	ret
      iunlock(ip);
    8000307e:	8552                	mv	a0,s4
    80003080:	00000097          	auipc	ra,0x0
    80003084:	aa8080e7          	jalr	-1368(ra) # 80002b28 <iunlock>
      return ip;
    80003088:	bfe9                	j	80003062 <namex+0x68>
      iunlockput(ip);
    8000308a:	8552                	mv	a0,s4
    8000308c:	00000097          	auipc	ra,0x0
    80003090:	c3c080e7          	jalr	-964(ra) # 80002cc8 <iunlockput>
      return 0;
    80003094:	8a4e                	mv	s4,s3
    80003096:	b7f1                	j	80003062 <namex+0x68>
  len = path - s;
    80003098:	40998633          	sub	a2,s3,s1
    8000309c:	00060c9b          	sext.w	s9,a2
  if(len >= DIRSIZ)
    800030a0:	099c5863          	bge	s8,s9,80003130 <namex+0x136>
    memmove(name, s, DIRSIZ);
    800030a4:	4639                	li	a2,14
    800030a6:	85a6                	mv	a1,s1
    800030a8:	8556                	mv	a0,s5
    800030aa:	ffffd097          	auipc	ra,0xffffd
    800030ae:	12c080e7          	jalr	300(ra) # 800001d6 <memmove>
    800030b2:	84ce                	mv	s1,s3
  while(*path == '/')
    800030b4:	0004c783          	lbu	a5,0(s1)
    800030b8:	01279763          	bne	a5,s2,800030c6 <namex+0xcc>
    path++;
    800030bc:	0485                	add	s1,s1,1
  while(*path == '/')
    800030be:	0004c783          	lbu	a5,0(s1)
    800030c2:	ff278de3          	beq	a5,s2,800030bc <namex+0xc2>
    ilock(ip);
    800030c6:	8552                	mv	a0,s4
    800030c8:	00000097          	auipc	ra,0x0
    800030cc:	99e080e7          	jalr	-1634(ra) # 80002a66 <ilock>
    if(ip->type != T_DIR){
    800030d0:	044a1783          	lh	a5,68(s4)
    800030d4:	f97791e3          	bne	a5,s7,80003056 <namex+0x5c>
    if(nameiparent && *path == '\0'){
    800030d8:	000b0563          	beqz	s6,800030e2 <namex+0xe8>
    800030dc:	0004c783          	lbu	a5,0(s1)
    800030e0:	dfd9                	beqz	a5,8000307e <namex+0x84>
    if((next = dirlookup(ip, name, 0)) == 0){
    800030e2:	4601                	li	a2,0
    800030e4:	85d6                	mv	a1,s5
    800030e6:	8552                	mv	a0,s4
    800030e8:	00000097          	auipc	ra,0x0
    800030ec:	e62080e7          	jalr	-414(ra) # 80002f4a <dirlookup>
    800030f0:	89aa                	mv	s3,a0
    800030f2:	dd41                	beqz	a0,8000308a <namex+0x90>
    iunlockput(ip);
    800030f4:	8552                	mv	a0,s4
    800030f6:	00000097          	auipc	ra,0x0
    800030fa:	bd2080e7          	jalr	-1070(ra) # 80002cc8 <iunlockput>
    ip = next;
    800030fe:	8a4e                	mv	s4,s3
  while(*path == '/')
    80003100:	0004c783          	lbu	a5,0(s1)
    80003104:	01279763          	bne	a5,s2,80003112 <namex+0x118>
    path++;
    80003108:	0485                	add	s1,s1,1
  while(*path == '/')
    8000310a:	0004c783          	lbu	a5,0(s1)
    8000310e:	ff278de3          	beq	a5,s2,80003108 <namex+0x10e>
  if(*path == 0)
    80003112:	cb9d                	beqz	a5,80003148 <namex+0x14e>
  while(*path != '/' && *path != 0)
    80003114:	0004c783          	lbu	a5,0(s1)
    80003118:	89a6                	mv	s3,s1
  len = path - s;
    8000311a:	4c81                	li	s9,0
    8000311c:	4601                	li	a2,0
  while(*path != '/' && *path != 0)
    8000311e:	01278963          	beq	a5,s2,80003130 <namex+0x136>
    80003122:	dbbd                	beqz	a5,80003098 <namex+0x9e>
    path++;
    80003124:	0985                	add	s3,s3,1
  while(*path != '/' && *path != 0)
    80003126:	0009c783          	lbu	a5,0(s3)
    8000312a:	ff279ce3          	bne	a5,s2,80003122 <namex+0x128>
    8000312e:	b7ad                	j	80003098 <namex+0x9e>
    memmove(name, s, len);
    80003130:	2601                	sext.w	a2,a2
    80003132:	85a6                	mv	a1,s1
    80003134:	8556                	mv	a0,s5
    80003136:	ffffd097          	auipc	ra,0xffffd
    8000313a:	0a0080e7          	jalr	160(ra) # 800001d6 <memmove>
    name[len] = 0;
    8000313e:	9cd6                	add	s9,s9,s5
    80003140:	000c8023          	sb	zero,0(s9) # 2000 <_entry-0x7fffe000>
    80003144:	84ce                	mv	s1,s3
    80003146:	b7bd                	j	800030b4 <namex+0xba>
  if(nameiparent){
    80003148:	f00b0de3          	beqz	s6,80003062 <namex+0x68>
    iput(ip);
    8000314c:	8552                	mv	a0,s4
    8000314e:	00000097          	auipc	ra,0x0
    80003152:	ad2080e7          	jalr	-1326(ra) # 80002c20 <iput>
    return 0;
    80003156:	4a01                	li	s4,0
    80003158:	b729                	j	80003062 <namex+0x68>

000000008000315a <dirlink>:
{
    8000315a:	7139                	add	sp,sp,-64
    8000315c:	fc06                	sd	ra,56(sp)
    8000315e:	f822                	sd	s0,48(sp)
    80003160:	f426                	sd	s1,40(sp)
    80003162:	f04a                	sd	s2,32(sp)
    80003164:	ec4e                	sd	s3,24(sp)
    80003166:	e852                	sd	s4,16(sp)
    80003168:	0080                	add	s0,sp,64
    8000316a:	892a                	mv	s2,a0
    8000316c:	8a2e                	mv	s4,a1
    8000316e:	89b2                	mv	s3,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    80003170:	4601                	li	a2,0
    80003172:	00000097          	auipc	ra,0x0
    80003176:	dd8080e7          	jalr	-552(ra) # 80002f4a <dirlookup>
    8000317a:	e93d                	bnez	a0,800031f0 <dirlink+0x96>
  for(off = 0; off < dp->size; off += sizeof(de)){
    8000317c:	04c92483          	lw	s1,76(s2)
    80003180:	c49d                	beqz	s1,800031ae <dirlink+0x54>
    80003182:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003184:	4741                	li	a4,16
    80003186:	86a6                	mv	a3,s1
    80003188:	fc040613          	add	a2,s0,-64
    8000318c:	4581                	li	a1,0
    8000318e:	854a                	mv	a0,s2
    80003190:	00000097          	auipc	ra,0x0
    80003194:	b8a080e7          	jalr	-1142(ra) # 80002d1a <readi>
    80003198:	47c1                	li	a5,16
    8000319a:	06f51163          	bne	a0,a5,800031fc <dirlink+0xa2>
    if(de.inum == 0)
    8000319e:	fc045783          	lhu	a5,-64(s0)
    800031a2:	c791                	beqz	a5,800031ae <dirlink+0x54>
  for(off = 0; off < dp->size; off += sizeof(de)){
    800031a4:	24c1                	addw	s1,s1,16
    800031a6:	04c92783          	lw	a5,76(s2)
    800031aa:	fcf4ede3          	bltu	s1,a5,80003184 <dirlink+0x2a>
  strncpy(de.name, name, DIRSIZ);
    800031ae:	4639                	li	a2,14
    800031b0:	85d2                	mv	a1,s4
    800031b2:	fc240513          	add	a0,s0,-62
    800031b6:	ffffd097          	auipc	ra,0xffffd
    800031ba:	0d0080e7          	jalr	208(ra) # 80000286 <strncpy>
  de.inum = inum;
    800031be:	fd341023          	sh	s3,-64(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800031c2:	4741                	li	a4,16
    800031c4:	86a6                	mv	a3,s1
    800031c6:	fc040613          	add	a2,s0,-64
    800031ca:	4581                	li	a1,0
    800031cc:	854a                	mv	a0,s2
    800031ce:	00000097          	auipc	ra,0x0
    800031d2:	c44080e7          	jalr	-956(ra) # 80002e12 <writei>
    800031d6:	872a                	mv	a4,a0
    800031d8:	47c1                	li	a5,16
  return 0;
    800031da:	4501                	li	a0,0
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800031dc:	02f71863          	bne	a4,a5,8000320c <dirlink+0xb2>
}
    800031e0:	70e2                	ld	ra,56(sp)
    800031e2:	7442                	ld	s0,48(sp)
    800031e4:	74a2                	ld	s1,40(sp)
    800031e6:	7902                	ld	s2,32(sp)
    800031e8:	69e2                	ld	s3,24(sp)
    800031ea:	6a42                	ld	s4,16(sp)
    800031ec:	6121                	add	sp,sp,64
    800031ee:	8082                	ret
    iput(ip);
    800031f0:	00000097          	auipc	ra,0x0
    800031f4:	a30080e7          	jalr	-1488(ra) # 80002c20 <iput>
    return -1;
    800031f8:	557d                	li	a0,-1
    800031fa:	b7dd                	j	800031e0 <dirlink+0x86>
      panic("dirlink read");
    800031fc:	00005517          	auipc	a0,0x5
    80003200:	39450513          	add	a0,a0,916 # 80008590 <syscalls+0x1c8>
    80003204:	00003097          	auipc	ra,0x3
    80003208:	876080e7          	jalr	-1930(ra) # 80005a7a <panic>
    panic("dirlink");
    8000320c:	00005517          	auipc	a0,0x5
    80003210:	49450513          	add	a0,a0,1172 # 800086a0 <syscalls+0x2d8>
    80003214:	00003097          	auipc	ra,0x3
    80003218:	866080e7          	jalr	-1946(ra) # 80005a7a <panic>

000000008000321c <namei>:

struct inode*
namei(char *path)
{
    8000321c:	1101                	add	sp,sp,-32
    8000321e:	ec06                	sd	ra,24(sp)
    80003220:	e822                	sd	s0,16(sp)
    80003222:	1000                	add	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    80003224:	fe040613          	add	a2,s0,-32
    80003228:	4581                	li	a1,0
    8000322a:	00000097          	auipc	ra,0x0
    8000322e:	dd0080e7          	jalr	-560(ra) # 80002ffa <namex>
}
    80003232:	60e2                	ld	ra,24(sp)
    80003234:	6442                	ld	s0,16(sp)
    80003236:	6105                	add	sp,sp,32
    80003238:	8082                	ret

000000008000323a <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    8000323a:	1141                	add	sp,sp,-16
    8000323c:	e406                	sd	ra,8(sp)
    8000323e:	e022                	sd	s0,0(sp)
    80003240:	0800                	add	s0,sp,16
    80003242:	862e                	mv	a2,a1
  return namex(path, 1, name);
    80003244:	4585                	li	a1,1
    80003246:	00000097          	auipc	ra,0x0
    8000324a:	db4080e7          	jalr	-588(ra) # 80002ffa <namex>
}
    8000324e:	60a2                	ld	ra,8(sp)
    80003250:	6402                	ld	s0,0(sp)
    80003252:	0141                	add	sp,sp,16
    80003254:	8082                	ret

0000000080003256 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    80003256:	1101                	add	sp,sp,-32
    80003258:	ec06                	sd	ra,24(sp)
    8000325a:	e822                	sd	s0,16(sp)
    8000325c:	e426                	sd	s1,8(sp)
    8000325e:	e04a                	sd	s2,0(sp)
    80003260:	1000                	add	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    80003262:	00016917          	auipc	s2,0x16
    80003266:	dbe90913          	add	s2,s2,-578 # 80019020 <log>
    8000326a:	01892583          	lw	a1,24(s2)
    8000326e:	02892503          	lw	a0,40(s2)
    80003272:	fffff097          	auipc	ra,0xfffff
    80003276:	ffa080e7          	jalr	-6(ra) # 8000226c <bread>
    8000327a:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    8000327c:	02c92603          	lw	a2,44(s2)
    80003280:	cd30                	sw	a2,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    80003282:	00c05f63          	blez	a2,800032a0 <write_head+0x4a>
    80003286:	00016717          	auipc	a4,0x16
    8000328a:	dca70713          	add	a4,a4,-566 # 80019050 <log+0x30>
    8000328e:	87aa                	mv	a5,a0
    80003290:	060a                	sll	a2,a2,0x2
    80003292:	962a                	add	a2,a2,a0
    hb->block[i] = log.lh.block[i];
    80003294:	4314                	lw	a3,0(a4)
    80003296:	cff4                	sw	a3,92(a5)
  for (i = 0; i < log.lh.n; i++) {
    80003298:	0711                	add	a4,a4,4
    8000329a:	0791                	add	a5,a5,4
    8000329c:	fec79ce3          	bne	a5,a2,80003294 <write_head+0x3e>
  }
  bwrite(buf);
    800032a0:	8526                	mv	a0,s1
    800032a2:	fffff097          	auipc	ra,0xfffff
    800032a6:	0bc080e7          	jalr	188(ra) # 8000235e <bwrite>
  brelse(buf);
    800032aa:	8526                	mv	a0,s1
    800032ac:	fffff097          	auipc	ra,0xfffff
    800032b0:	0f0080e7          	jalr	240(ra) # 8000239c <brelse>
}
    800032b4:	60e2                	ld	ra,24(sp)
    800032b6:	6442                	ld	s0,16(sp)
    800032b8:	64a2                	ld	s1,8(sp)
    800032ba:	6902                	ld	s2,0(sp)
    800032bc:	6105                	add	sp,sp,32
    800032be:	8082                	ret

00000000800032c0 <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    800032c0:	00016797          	auipc	a5,0x16
    800032c4:	d8c7a783          	lw	a5,-628(a5) # 8001904c <log+0x2c>
    800032c8:	0af05d63          	blez	a5,80003382 <install_trans+0xc2>
{
    800032cc:	7139                	add	sp,sp,-64
    800032ce:	fc06                	sd	ra,56(sp)
    800032d0:	f822                	sd	s0,48(sp)
    800032d2:	f426                	sd	s1,40(sp)
    800032d4:	f04a                	sd	s2,32(sp)
    800032d6:	ec4e                	sd	s3,24(sp)
    800032d8:	e852                	sd	s4,16(sp)
    800032da:	e456                	sd	s5,8(sp)
    800032dc:	e05a                	sd	s6,0(sp)
    800032de:	0080                	add	s0,sp,64
    800032e0:	8b2a                	mv	s6,a0
    800032e2:	00016a97          	auipc	s5,0x16
    800032e6:	d6ea8a93          	add	s5,s5,-658 # 80019050 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    800032ea:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    800032ec:	00016997          	auipc	s3,0x16
    800032f0:	d3498993          	add	s3,s3,-716 # 80019020 <log>
    800032f4:	a00d                	j	80003316 <install_trans+0x56>
    brelse(lbuf);
    800032f6:	854a                	mv	a0,s2
    800032f8:	fffff097          	auipc	ra,0xfffff
    800032fc:	0a4080e7          	jalr	164(ra) # 8000239c <brelse>
    brelse(dbuf);
    80003300:	8526                	mv	a0,s1
    80003302:	fffff097          	auipc	ra,0xfffff
    80003306:	09a080e7          	jalr	154(ra) # 8000239c <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    8000330a:	2a05                	addw	s4,s4,1
    8000330c:	0a91                	add	s5,s5,4
    8000330e:	02c9a783          	lw	a5,44(s3)
    80003312:	04fa5e63          	bge	s4,a5,8000336e <install_trans+0xae>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80003316:	0189a583          	lw	a1,24(s3)
    8000331a:	014585bb          	addw	a1,a1,s4
    8000331e:	2585                	addw	a1,a1,1
    80003320:	0289a503          	lw	a0,40(s3)
    80003324:	fffff097          	auipc	ra,0xfffff
    80003328:	f48080e7          	jalr	-184(ra) # 8000226c <bread>
    8000332c:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    8000332e:	000aa583          	lw	a1,0(s5)
    80003332:	0289a503          	lw	a0,40(s3)
    80003336:	fffff097          	auipc	ra,0xfffff
    8000333a:	f36080e7          	jalr	-202(ra) # 8000226c <bread>
    8000333e:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80003340:	40000613          	li	a2,1024
    80003344:	05890593          	add	a1,s2,88
    80003348:	05850513          	add	a0,a0,88
    8000334c:	ffffd097          	auipc	ra,0xffffd
    80003350:	e8a080e7          	jalr	-374(ra) # 800001d6 <memmove>
    bwrite(dbuf);  // write dst to disk
    80003354:	8526                	mv	a0,s1
    80003356:	fffff097          	auipc	ra,0xfffff
    8000335a:	008080e7          	jalr	8(ra) # 8000235e <bwrite>
    if(recovering == 0)
    8000335e:	f80b1ce3          	bnez	s6,800032f6 <install_trans+0x36>
      bunpin(dbuf);
    80003362:	8526                	mv	a0,s1
    80003364:	fffff097          	auipc	ra,0xfffff
    80003368:	110080e7          	jalr	272(ra) # 80002474 <bunpin>
    8000336c:	b769                	j	800032f6 <install_trans+0x36>
}
    8000336e:	70e2                	ld	ra,56(sp)
    80003370:	7442                	ld	s0,48(sp)
    80003372:	74a2                	ld	s1,40(sp)
    80003374:	7902                	ld	s2,32(sp)
    80003376:	69e2                	ld	s3,24(sp)
    80003378:	6a42                	ld	s4,16(sp)
    8000337a:	6aa2                	ld	s5,8(sp)
    8000337c:	6b02                	ld	s6,0(sp)
    8000337e:	6121                	add	sp,sp,64
    80003380:	8082                	ret
    80003382:	8082                	ret

0000000080003384 <initlog>:
{
    80003384:	7179                	add	sp,sp,-48
    80003386:	f406                	sd	ra,40(sp)
    80003388:	f022                	sd	s0,32(sp)
    8000338a:	ec26                	sd	s1,24(sp)
    8000338c:	e84a                	sd	s2,16(sp)
    8000338e:	e44e                	sd	s3,8(sp)
    80003390:	1800                	add	s0,sp,48
    80003392:	892a                	mv	s2,a0
    80003394:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    80003396:	00016497          	auipc	s1,0x16
    8000339a:	c8a48493          	add	s1,s1,-886 # 80019020 <log>
    8000339e:	00005597          	auipc	a1,0x5
    800033a2:	20258593          	add	a1,a1,514 # 800085a0 <syscalls+0x1d8>
    800033a6:	8526                	mv	a0,s1
    800033a8:	00003097          	auipc	ra,0x3
    800033ac:	b7a080e7          	jalr	-1158(ra) # 80005f22 <initlock>
  log.start = sb->logstart;
    800033b0:	0149a583          	lw	a1,20(s3)
    800033b4:	cc8c                	sw	a1,24(s1)
  log.size = sb->nlog;
    800033b6:	0109a783          	lw	a5,16(s3)
    800033ba:	ccdc                	sw	a5,28(s1)
  log.dev = dev;
    800033bc:	0324a423          	sw	s2,40(s1)
  struct buf *buf = bread(log.dev, log.start);
    800033c0:	854a                	mv	a0,s2
    800033c2:	fffff097          	auipc	ra,0xfffff
    800033c6:	eaa080e7          	jalr	-342(ra) # 8000226c <bread>
  log.lh.n = lh->n;
    800033ca:	4d30                	lw	a2,88(a0)
    800033cc:	d4d0                	sw	a2,44(s1)
  for (i = 0; i < log.lh.n; i++) {
    800033ce:	00c05f63          	blez	a2,800033ec <initlog+0x68>
    800033d2:	87aa                	mv	a5,a0
    800033d4:	00016717          	auipc	a4,0x16
    800033d8:	c7c70713          	add	a4,a4,-900 # 80019050 <log+0x30>
    800033dc:	060a                	sll	a2,a2,0x2
    800033de:	962a                	add	a2,a2,a0
    log.lh.block[i] = lh->block[i];
    800033e0:	4ff4                	lw	a3,92(a5)
    800033e2:	c314                	sw	a3,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    800033e4:	0791                	add	a5,a5,4
    800033e6:	0711                	add	a4,a4,4
    800033e8:	fec79ce3          	bne	a5,a2,800033e0 <initlog+0x5c>
  brelse(buf);
    800033ec:	fffff097          	auipc	ra,0xfffff
    800033f0:	fb0080e7          	jalr	-80(ra) # 8000239c <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    800033f4:	4505                	li	a0,1
    800033f6:	00000097          	auipc	ra,0x0
    800033fa:	eca080e7          	jalr	-310(ra) # 800032c0 <install_trans>
  log.lh.n = 0;
    800033fe:	00016797          	auipc	a5,0x16
    80003402:	c407a723          	sw	zero,-946(a5) # 8001904c <log+0x2c>
  write_head(); // clear the log
    80003406:	00000097          	auipc	ra,0x0
    8000340a:	e50080e7          	jalr	-432(ra) # 80003256 <write_head>
}
    8000340e:	70a2                	ld	ra,40(sp)
    80003410:	7402                	ld	s0,32(sp)
    80003412:	64e2                	ld	s1,24(sp)
    80003414:	6942                	ld	s2,16(sp)
    80003416:	69a2                	ld	s3,8(sp)
    80003418:	6145                	add	sp,sp,48
    8000341a:	8082                	ret

000000008000341c <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    8000341c:	1101                	add	sp,sp,-32
    8000341e:	ec06                	sd	ra,24(sp)
    80003420:	e822                	sd	s0,16(sp)
    80003422:	e426                	sd	s1,8(sp)
    80003424:	e04a                	sd	s2,0(sp)
    80003426:	1000                	add	s0,sp,32
  acquire(&log.lock);
    80003428:	00016517          	auipc	a0,0x16
    8000342c:	bf850513          	add	a0,a0,-1032 # 80019020 <log>
    80003430:	00003097          	auipc	ra,0x3
    80003434:	b82080e7          	jalr	-1150(ra) # 80005fb2 <acquire>
  while(1){
    if(log.committing){
    80003438:	00016497          	auipc	s1,0x16
    8000343c:	be848493          	add	s1,s1,-1048 # 80019020 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80003440:	4979                	li	s2,30
    80003442:	a039                	j	80003450 <begin_op+0x34>
      sleep(&log, &log.lock);
    80003444:	85a6                	mv	a1,s1
    80003446:	8526                	mv	a0,s1
    80003448:	ffffe097          	auipc	ra,0xffffe
    8000344c:	0be080e7          	jalr	190(ra) # 80001506 <sleep>
    if(log.committing){
    80003450:	50dc                	lw	a5,36(s1)
    80003452:	fbed                	bnez	a5,80003444 <begin_op+0x28>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80003454:	5098                	lw	a4,32(s1)
    80003456:	2705                	addw	a4,a4,1
    80003458:	0027179b          	sllw	a5,a4,0x2
    8000345c:	9fb9                	addw	a5,a5,a4
    8000345e:	0017979b          	sllw	a5,a5,0x1
    80003462:	54d4                	lw	a3,44(s1)
    80003464:	9fb5                	addw	a5,a5,a3
    80003466:	00f95963          	bge	s2,a5,80003478 <begin_op+0x5c>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    8000346a:	85a6                	mv	a1,s1
    8000346c:	8526                	mv	a0,s1
    8000346e:	ffffe097          	auipc	ra,0xffffe
    80003472:	098080e7          	jalr	152(ra) # 80001506 <sleep>
    80003476:	bfe9                	j	80003450 <begin_op+0x34>
    } else {
      log.outstanding += 1;
    80003478:	00016517          	auipc	a0,0x16
    8000347c:	ba850513          	add	a0,a0,-1112 # 80019020 <log>
    80003480:	d118                	sw	a4,32(a0)
      release(&log.lock);
    80003482:	00003097          	auipc	ra,0x3
    80003486:	be4080e7          	jalr	-1052(ra) # 80006066 <release>
      break;
    }
  }
}
    8000348a:	60e2                	ld	ra,24(sp)
    8000348c:	6442                	ld	s0,16(sp)
    8000348e:	64a2                	ld	s1,8(sp)
    80003490:	6902                	ld	s2,0(sp)
    80003492:	6105                	add	sp,sp,32
    80003494:	8082                	ret

0000000080003496 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    80003496:	7139                	add	sp,sp,-64
    80003498:	fc06                	sd	ra,56(sp)
    8000349a:	f822                	sd	s0,48(sp)
    8000349c:	f426                	sd	s1,40(sp)
    8000349e:	f04a                	sd	s2,32(sp)
    800034a0:	ec4e                	sd	s3,24(sp)
    800034a2:	e852                	sd	s4,16(sp)
    800034a4:	e456                	sd	s5,8(sp)
    800034a6:	0080                	add	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    800034a8:	00016497          	auipc	s1,0x16
    800034ac:	b7848493          	add	s1,s1,-1160 # 80019020 <log>
    800034b0:	8526                	mv	a0,s1
    800034b2:	00003097          	auipc	ra,0x3
    800034b6:	b00080e7          	jalr	-1280(ra) # 80005fb2 <acquire>
  log.outstanding -= 1;
    800034ba:	509c                	lw	a5,32(s1)
    800034bc:	37fd                	addw	a5,a5,-1
    800034be:	0007891b          	sext.w	s2,a5
    800034c2:	d09c                	sw	a5,32(s1)
  if(log.committing)
    800034c4:	50dc                	lw	a5,36(s1)
    800034c6:	e7b9                	bnez	a5,80003514 <end_op+0x7e>
    panic("log.committing");
  if(log.outstanding == 0){
    800034c8:	04091e63          	bnez	s2,80003524 <end_op+0x8e>
    do_commit = 1;
    log.committing = 1;
    800034cc:	00016497          	auipc	s1,0x16
    800034d0:	b5448493          	add	s1,s1,-1196 # 80019020 <log>
    800034d4:	4785                	li	a5,1
    800034d6:	d0dc                	sw	a5,36(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    800034d8:	8526                	mv	a0,s1
    800034da:	00003097          	auipc	ra,0x3
    800034de:	b8c080e7          	jalr	-1140(ra) # 80006066 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    800034e2:	54dc                	lw	a5,44(s1)
    800034e4:	06f04763          	bgtz	a5,80003552 <end_op+0xbc>
    acquire(&log.lock);
    800034e8:	00016497          	auipc	s1,0x16
    800034ec:	b3848493          	add	s1,s1,-1224 # 80019020 <log>
    800034f0:	8526                	mv	a0,s1
    800034f2:	00003097          	auipc	ra,0x3
    800034f6:	ac0080e7          	jalr	-1344(ra) # 80005fb2 <acquire>
    log.committing = 0;
    800034fa:	0204a223          	sw	zero,36(s1)
    wakeup(&log);
    800034fe:	8526                	mv	a0,s1
    80003500:	ffffe097          	auipc	ra,0xffffe
    80003504:	192080e7          	jalr	402(ra) # 80001692 <wakeup>
    release(&log.lock);
    80003508:	8526                	mv	a0,s1
    8000350a:	00003097          	auipc	ra,0x3
    8000350e:	b5c080e7          	jalr	-1188(ra) # 80006066 <release>
}
    80003512:	a03d                	j	80003540 <end_op+0xaa>
    panic("log.committing");
    80003514:	00005517          	auipc	a0,0x5
    80003518:	09450513          	add	a0,a0,148 # 800085a8 <syscalls+0x1e0>
    8000351c:	00002097          	auipc	ra,0x2
    80003520:	55e080e7          	jalr	1374(ra) # 80005a7a <panic>
    wakeup(&log);
    80003524:	00016497          	auipc	s1,0x16
    80003528:	afc48493          	add	s1,s1,-1284 # 80019020 <log>
    8000352c:	8526                	mv	a0,s1
    8000352e:	ffffe097          	auipc	ra,0xffffe
    80003532:	164080e7          	jalr	356(ra) # 80001692 <wakeup>
  release(&log.lock);
    80003536:	8526                	mv	a0,s1
    80003538:	00003097          	auipc	ra,0x3
    8000353c:	b2e080e7          	jalr	-1234(ra) # 80006066 <release>
}
    80003540:	70e2                	ld	ra,56(sp)
    80003542:	7442                	ld	s0,48(sp)
    80003544:	74a2                	ld	s1,40(sp)
    80003546:	7902                	ld	s2,32(sp)
    80003548:	69e2                	ld	s3,24(sp)
    8000354a:	6a42                	ld	s4,16(sp)
    8000354c:	6aa2                	ld	s5,8(sp)
    8000354e:	6121                	add	sp,sp,64
    80003550:	8082                	ret
  for (tail = 0; tail < log.lh.n; tail++) {
    80003552:	00016a97          	auipc	s5,0x16
    80003556:	afea8a93          	add	s5,s5,-1282 # 80019050 <log+0x30>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    8000355a:	00016a17          	auipc	s4,0x16
    8000355e:	ac6a0a13          	add	s4,s4,-1338 # 80019020 <log>
    80003562:	018a2583          	lw	a1,24(s4)
    80003566:	012585bb          	addw	a1,a1,s2
    8000356a:	2585                	addw	a1,a1,1
    8000356c:	028a2503          	lw	a0,40(s4)
    80003570:	fffff097          	auipc	ra,0xfffff
    80003574:	cfc080e7          	jalr	-772(ra) # 8000226c <bread>
    80003578:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    8000357a:	000aa583          	lw	a1,0(s5)
    8000357e:	028a2503          	lw	a0,40(s4)
    80003582:	fffff097          	auipc	ra,0xfffff
    80003586:	cea080e7          	jalr	-790(ra) # 8000226c <bread>
    8000358a:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    8000358c:	40000613          	li	a2,1024
    80003590:	05850593          	add	a1,a0,88
    80003594:	05848513          	add	a0,s1,88
    80003598:	ffffd097          	auipc	ra,0xffffd
    8000359c:	c3e080e7          	jalr	-962(ra) # 800001d6 <memmove>
    bwrite(to);  // write the log
    800035a0:	8526                	mv	a0,s1
    800035a2:	fffff097          	auipc	ra,0xfffff
    800035a6:	dbc080e7          	jalr	-580(ra) # 8000235e <bwrite>
    brelse(from);
    800035aa:	854e                	mv	a0,s3
    800035ac:	fffff097          	auipc	ra,0xfffff
    800035b0:	df0080e7          	jalr	-528(ra) # 8000239c <brelse>
    brelse(to);
    800035b4:	8526                	mv	a0,s1
    800035b6:	fffff097          	auipc	ra,0xfffff
    800035ba:	de6080e7          	jalr	-538(ra) # 8000239c <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    800035be:	2905                	addw	s2,s2,1
    800035c0:	0a91                	add	s5,s5,4
    800035c2:	02ca2783          	lw	a5,44(s4)
    800035c6:	f8f94ee3          	blt	s2,a5,80003562 <end_op+0xcc>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    800035ca:	00000097          	auipc	ra,0x0
    800035ce:	c8c080e7          	jalr	-884(ra) # 80003256 <write_head>
    install_trans(0); // Now install writes to home locations
    800035d2:	4501                	li	a0,0
    800035d4:	00000097          	auipc	ra,0x0
    800035d8:	cec080e7          	jalr	-788(ra) # 800032c0 <install_trans>
    log.lh.n = 0;
    800035dc:	00016797          	auipc	a5,0x16
    800035e0:	a607a823          	sw	zero,-1424(a5) # 8001904c <log+0x2c>
    write_head();    // Erase the transaction from the log
    800035e4:	00000097          	auipc	ra,0x0
    800035e8:	c72080e7          	jalr	-910(ra) # 80003256 <write_head>
    800035ec:	bdf5                	j	800034e8 <end_op+0x52>

00000000800035ee <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    800035ee:	1101                	add	sp,sp,-32
    800035f0:	ec06                	sd	ra,24(sp)
    800035f2:	e822                	sd	s0,16(sp)
    800035f4:	e426                	sd	s1,8(sp)
    800035f6:	e04a                	sd	s2,0(sp)
    800035f8:	1000                	add	s0,sp,32
    800035fa:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    800035fc:	00016917          	auipc	s2,0x16
    80003600:	a2490913          	add	s2,s2,-1500 # 80019020 <log>
    80003604:	854a                	mv	a0,s2
    80003606:	00003097          	auipc	ra,0x3
    8000360a:	9ac080e7          	jalr	-1620(ra) # 80005fb2 <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    8000360e:	02c92603          	lw	a2,44(s2)
    80003612:	47f5                	li	a5,29
    80003614:	06c7c563          	blt	a5,a2,8000367e <log_write+0x90>
    80003618:	00016797          	auipc	a5,0x16
    8000361c:	a247a783          	lw	a5,-1500(a5) # 8001903c <log+0x1c>
    80003620:	37fd                	addw	a5,a5,-1
    80003622:	04f65e63          	bge	a2,a5,8000367e <log_write+0x90>
    panic("too big a transaction");
  if (log.outstanding < 1)
    80003626:	00016797          	auipc	a5,0x16
    8000362a:	a1a7a783          	lw	a5,-1510(a5) # 80019040 <log+0x20>
    8000362e:	06f05063          	blez	a5,8000368e <log_write+0xa0>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    80003632:	4781                	li	a5,0
    80003634:	06c05563          	blez	a2,8000369e <log_write+0xb0>
    if (log.lh.block[i] == b->blockno)   // log absorption
    80003638:	44cc                	lw	a1,12(s1)
    8000363a:	00016717          	auipc	a4,0x16
    8000363e:	a1670713          	add	a4,a4,-1514 # 80019050 <log+0x30>
  for (i = 0; i < log.lh.n; i++) {
    80003642:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    80003644:	4314                	lw	a3,0(a4)
    80003646:	04b68c63          	beq	a3,a1,8000369e <log_write+0xb0>
  for (i = 0; i < log.lh.n; i++) {
    8000364a:	2785                	addw	a5,a5,1
    8000364c:	0711                	add	a4,a4,4
    8000364e:	fef61be3          	bne	a2,a5,80003644 <log_write+0x56>
      break;
  }
  log.lh.block[i] = b->blockno;
    80003652:	0621                	add	a2,a2,8
    80003654:	060a                	sll	a2,a2,0x2
    80003656:	00016797          	auipc	a5,0x16
    8000365a:	9ca78793          	add	a5,a5,-1590 # 80019020 <log>
    8000365e:	97b2                	add	a5,a5,a2
    80003660:	44d8                	lw	a4,12(s1)
    80003662:	cb98                	sw	a4,16(a5)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    80003664:	8526                	mv	a0,s1
    80003666:	fffff097          	auipc	ra,0xfffff
    8000366a:	dd2080e7          	jalr	-558(ra) # 80002438 <bpin>
    log.lh.n++;
    8000366e:	00016717          	auipc	a4,0x16
    80003672:	9b270713          	add	a4,a4,-1614 # 80019020 <log>
    80003676:	575c                	lw	a5,44(a4)
    80003678:	2785                	addw	a5,a5,1
    8000367a:	d75c                	sw	a5,44(a4)
    8000367c:	a82d                	j	800036b6 <log_write+0xc8>
    panic("too big a transaction");
    8000367e:	00005517          	auipc	a0,0x5
    80003682:	f3a50513          	add	a0,a0,-198 # 800085b8 <syscalls+0x1f0>
    80003686:	00002097          	auipc	ra,0x2
    8000368a:	3f4080e7          	jalr	1012(ra) # 80005a7a <panic>
    panic("log_write outside of trans");
    8000368e:	00005517          	auipc	a0,0x5
    80003692:	f4250513          	add	a0,a0,-190 # 800085d0 <syscalls+0x208>
    80003696:	00002097          	auipc	ra,0x2
    8000369a:	3e4080e7          	jalr	996(ra) # 80005a7a <panic>
  log.lh.block[i] = b->blockno;
    8000369e:	00878693          	add	a3,a5,8
    800036a2:	068a                	sll	a3,a3,0x2
    800036a4:	00016717          	auipc	a4,0x16
    800036a8:	97c70713          	add	a4,a4,-1668 # 80019020 <log>
    800036ac:	9736                	add	a4,a4,a3
    800036ae:	44d4                	lw	a3,12(s1)
    800036b0:	cb14                	sw	a3,16(a4)
  if (i == log.lh.n) {  // Add new block to log?
    800036b2:	faf609e3          	beq	a2,a5,80003664 <log_write+0x76>
  }
  release(&log.lock);
    800036b6:	00016517          	auipc	a0,0x16
    800036ba:	96a50513          	add	a0,a0,-1686 # 80019020 <log>
    800036be:	00003097          	auipc	ra,0x3
    800036c2:	9a8080e7          	jalr	-1624(ra) # 80006066 <release>
}
    800036c6:	60e2                	ld	ra,24(sp)
    800036c8:	6442                	ld	s0,16(sp)
    800036ca:	64a2                	ld	s1,8(sp)
    800036cc:	6902                	ld	s2,0(sp)
    800036ce:	6105                	add	sp,sp,32
    800036d0:	8082                	ret

00000000800036d2 <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    800036d2:	1101                	add	sp,sp,-32
    800036d4:	ec06                	sd	ra,24(sp)
    800036d6:	e822                	sd	s0,16(sp)
    800036d8:	e426                	sd	s1,8(sp)
    800036da:	e04a                	sd	s2,0(sp)
    800036dc:	1000                	add	s0,sp,32
    800036de:	84aa                	mv	s1,a0
    800036e0:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    800036e2:	00005597          	auipc	a1,0x5
    800036e6:	f0e58593          	add	a1,a1,-242 # 800085f0 <syscalls+0x228>
    800036ea:	0521                	add	a0,a0,8
    800036ec:	00003097          	auipc	ra,0x3
    800036f0:	836080e7          	jalr	-1994(ra) # 80005f22 <initlock>
  lk->name = name;
    800036f4:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    800036f8:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    800036fc:	0204a423          	sw	zero,40(s1)
}
    80003700:	60e2                	ld	ra,24(sp)
    80003702:	6442                	ld	s0,16(sp)
    80003704:	64a2                	ld	s1,8(sp)
    80003706:	6902                	ld	s2,0(sp)
    80003708:	6105                	add	sp,sp,32
    8000370a:	8082                	ret

000000008000370c <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    8000370c:	1101                	add	sp,sp,-32
    8000370e:	ec06                	sd	ra,24(sp)
    80003710:	e822                	sd	s0,16(sp)
    80003712:	e426                	sd	s1,8(sp)
    80003714:	e04a                	sd	s2,0(sp)
    80003716:	1000                	add	s0,sp,32
    80003718:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    8000371a:	00850913          	add	s2,a0,8
    8000371e:	854a                	mv	a0,s2
    80003720:	00003097          	auipc	ra,0x3
    80003724:	892080e7          	jalr	-1902(ra) # 80005fb2 <acquire>
  while (lk->locked) {
    80003728:	409c                	lw	a5,0(s1)
    8000372a:	cb89                	beqz	a5,8000373c <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    8000372c:	85ca                	mv	a1,s2
    8000372e:	8526                	mv	a0,s1
    80003730:	ffffe097          	auipc	ra,0xffffe
    80003734:	dd6080e7          	jalr	-554(ra) # 80001506 <sleep>
  while (lk->locked) {
    80003738:	409c                	lw	a5,0(s1)
    8000373a:	fbed                	bnez	a5,8000372c <acquiresleep+0x20>
  }
  lk->locked = 1;
    8000373c:	4785                	li	a5,1
    8000373e:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    80003740:	ffffd097          	auipc	ra,0xffffd
    80003744:	702080e7          	jalr	1794(ra) # 80000e42 <myproc>
    80003748:	591c                	lw	a5,48(a0)
    8000374a:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    8000374c:	854a                	mv	a0,s2
    8000374e:	00003097          	auipc	ra,0x3
    80003752:	918080e7          	jalr	-1768(ra) # 80006066 <release>
}
    80003756:	60e2                	ld	ra,24(sp)
    80003758:	6442                	ld	s0,16(sp)
    8000375a:	64a2                	ld	s1,8(sp)
    8000375c:	6902                	ld	s2,0(sp)
    8000375e:	6105                	add	sp,sp,32
    80003760:	8082                	ret

0000000080003762 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    80003762:	1101                	add	sp,sp,-32
    80003764:	ec06                	sd	ra,24(sp)
    80003766:	e822                	sd	s0,16(sp)
    80003768:	e426                	sd	s1,8(sp)
    8000376a:	e04a                	sd	s2,0(sp)
    8000376c:	1000                	add	s0,sp,32
    8000376e:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003770:	00850913          	add	s2,a0,8
    80003774:	854a                	mv	a0,s2
    80003776:	00003097          	auipc	ra,0x3
    8000377a:	83c080e7          	jalr	-1988(ra) # 80005fb2 <acquire>
  lk->locked = 0;
    8000377e:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003782:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    80003786:	8526                	mv	a0,s1
    80003788:	ffffe097          	auipc	ra,0xffffe
    8000378c:	f0a080e7          	jalr	-246(ra) # 80001692 <wakeup>
  release(&lk->lk);
    80003790:	854a                	mv	a0,s2
    80003792:	00003097          	auipc	ra,0x3
    80003796:	8d4080e7          	jalr	-1836(ra) # 80006066 <release>
}
    8000379a:	60e2                	ld	ra,24(sp)
    8000379c:	6442                	ld	s0,16(sp)
    8000379e:	64a2                	ld	s1,8(sp)
    800037a0:	6902                	ld	s2,0(sp)
    800037a2:	6105                	add	sp,sp,32
    800037a4:	8082                	ret

00000000800037a6 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    800037a6:	7179                	add	sp,sp,-48
    800037a8:	f406                	sd	ra,40(sp)
    800037aa:	f022                	sd	s0,32(sp)
    800037ac:	ec26                	sd	s1,24(sp)
    800037ae:	e84a                	sd	s2,16(sp)
    800037b0:	e44e                	sd	s3,8(sp)
    800037b2:	1800                	add	s0,sp,48
    800037b4:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    800037b6:	00850913          	add	s2,a0,8
    800037ba:	854a                	mv	a0,s2
    800037bc:	00002097          	auipc	ra,0x2
    800037c0:	7f6080e7          	jalr	2038(ra) # 80005fb2 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    800037c4:	409c                	lw	a5,0(s1)
    800037c6:	ef99                	bnez	a5,800037e4 <holdingsleep+0x3e>
    800037c8:	4481                	li	s1,0
  release(&lk->lk);
    800037ca:	854a                	mv	a0,s2
    800037cc:	00003097          	auipc	ra,0x3
    800037d0:	89a080e7          	jalr	-1894(ra) # 80006066 <release>
  return r;
}
    800037d4:	8526                	mv	a0,s1
    800037d6:	70a2                	ld	ra,40(sp)
    800037d8:	7402                	ld	s0,32(sp)
    800037da:	64e2                	ld	s1,24(sp)
    800037dc:	6942                	ld	s2,16(sp)
    800037de:	69a2                	ld	s3,8(sp)
    800037e0:	6145                	add	sp,sp,48
    800037e2:	8082                	ret
  r = lk->locked && (lk->pid == myproc()->pid);
    800037e4:	0284a983          	lw	s3,40(s1)
    800037e8:	ffffd097          	auipc	ra,0xffffd
    800037ec:	65a080e7          	jalr	1626(ra) # 80000e42 <myproc>
    800037f0:	5904                	lw	s1,48(a0)
    800037f2:	413484b3          	sub	s1,s1,s3
    800037f6:	0014b493          	seqz	s1,s1
    800037fa:	bfc1                	j	800037ca <holdingsleep+0x24>

00000000800037fc <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    800037fc:	1141                	add	sp,sp,-16
    800037fe:	e406                	sd	ra,8(sp)
    80003800:	e022                	sd	s0,0(sp)
    80003802:	0800                	add	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80003804:	00005597          	auipc	a1,0x5
    80003808:	dfc58593          	add	a1,a1,-516 # 80008600 <syscalls+0x238>
    8000380c:	00016517          	auipc	a0,0x16
    80003810:	95c50513          	add	a0,a0,-1700 # 80019168 <ftable>
    80003814:	00002097          	auipc	ra,0x2
    80003818:	70e080e7          	jalr	1806(ra) # 80005f22 <initlock>
}
    8000381c:	60a2                	ld	ra,8(sp)
    8000381e:	6402                	ld	s0,0(sp)
    80003820:	0141                	add	sp,sp,16
    80003822:	8082                	ret

0000000080003824 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80003824:	1101                	add	sp,sp,-32
    80003826:	ec06                	sd	ra,24(sp)
    80003828:	e822                	sd	s0,16(sp)
    8000382a:	e426                	sd	s1,8(sp)
    8000382c:	1000                	add	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    8000382e:	00016517          	auipc	a0,0x16
    80003832:	93a50513          	add	a0,a0,-1734 # 80019168 <ftable>
    80003836:	00002097          	auipc	ra,0x2
    8000383a:	77c080e7          	jalr	1916(ra) # 80005fb2 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    8000383e:	00016497          	auipc	s1,0x16
    80003842:	94248493          	add	s1,s1,-1726 # 80019180 <ftable+0x18>
    80003846:	00017717          	auipc	a4,0x17
    8000384a:	8da70713          	add	a4,a4,-1830 # 8001a120 <ftable+0xfb8>
    if(f->ref == 0){
    8000384e:	40dc                	lw	a5,4(s1)
    80003850:	cf99                	beqz	a5,8000386e <filealloc+0x4a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003852:	02848493          	add	s1,s1,40
    80003856:	fee49ce3          	bne	s1,a4,8000384e <filealloc+0x2a>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    8000385a:	00016517          	auipc	a0,0x16
    8000385e:	90e50513          	add	a0,a0,-1778 # 80019168 <ftable>
    80003862:	00003097          	auipc	ra,0x3
    80003866:	804080e7          	jalr	-2044(ra) # 80006066 <release>
  return 0;
    8000386a:	4481                	li	s1,0
    8000386c:	a819                	j	80003882 <filealloc+0x5e>
      f->ref = 1;
    8000386e:	4785                	li	a5,1
    80003870:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    80003872:	00016517          	auipc	a0,0x16
    80003876:	8f650513          	add	a0,a0,-1802 # 80019168 <ftable>
    8000387a:	00002097          	auipc	ra,0x2
    8000387e:	7ec080e7          	jalr	2028(ra) # 80006066 <release>
}
    80003882:	8526                	mv	a0,s1
    80003884:	60e2                	ld	ra,24(sp)
    80003886:	6442                	ld	s0,16(sp)
    80003888:	64a2                	ld	s1,8(sp)
    8000388a:	6105                	add	sp,sp,32
    8000388c:	8082                	ret

000000008000388e <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    8000388e:	1101                	add	sp,sp,-32
    80003890:	ec06                	sd	ra,24(sp)
    80003892:	e822                	sd	s0,16(sp)
    80003894:	e426                	sd	s1,8(sp)
    80003896:	1000                	add	s0,sp,32
    80003898:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    8000389a:	00016517          	auipc	a0,0x16
    8000389e:	8ce50513          	add	a0,a0,-1842 # 80019168 <ftable>
    800038a2:	00002097          	auipc	ra,0x2
    800038a6:	710080e7          	jalr	1808(ra) # 80005fb2 <acquire>
  if(f->ref < 1)
    800038aa:	40dc                	lw	a5,4(s1)
    800038ac:	02f05263          	blez	a5,800038d0 <filedup+0x42>
    panic("filedup");
  f->ref++;
    800038b0:	2785                	addw	a5,a5,1
    800038b2:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    800038b4:	00016517          	auipc	a0,0x16
    800038b8:	8b450513          	add	a0,a0,-1868 # 80019168 <ftable>
    800038bc:	00002097          	auipc	ra,0x2
    800038c0:	7aa080e7          	jalr	1962(ra) # 80006066 <release>
  return f;
}
    800038c4:	8526                	mv	a0,s1
    800038c6:	60e2                	ld	ra,24(sp)
    800038c8:	6442                	ld	s0,16(sp)
    800038ca:	64a2                	ld	s1,8(sp)
    800038cc:	6105                	add	sp,sp,32
    800038ce:	8082                	ret
    panic("filedup");
    800038d0:	00005517          	auipc	a0,0x5
    800038d4:	d3850513          	add	a0,a0,-712 # 80008608 <syscalls+0x240>
    800038d8:	00002097          	auipc	ra,0x2
    800038dc:	1a2080e7          	jalr	418(ra) # 80005a7a <panic>

00000000800038e0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    800038e0:	7139                	add	sp,sp,-64
    800038e2:	fc06                	sd	ra,56(sp)
    800038e4:	f822                	sd	s0,48(sp)
    800038e6:	f426                	sd	s1,40(sp)
    800038e8:	f04a                	sd	s2,32(sp)
    800038ea:	ec4e                	sd	s3,24(sp)
    800038ec:	e852                	sd	s4,16(sp)
    800038ee:	e456                	sd	s5,8(sp)
    800038f0:	0080                	add	s0,sp,64
    800038f2:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    800038f4:	00016517          	auipc	a0,0x16
    800038f8:	87450513          	add	a0,a0,-1932 # 80019168 <ftable>
    800038fc:	00002097          	auipc	ra,0x2
    80003900:	6b6080e7          	jalr	1718(ra) # 80005fb2 <acquire>
  if(f->ref < 1)
    80003904:	40dc                	lw	a5,4(s1)
    80003906:	06f05163          	blez	a5,80003968 <fileclose+0x88>
    panic("fileclose");
  if(--f->ref > 0){
    8000390a:	37fd                	addw	a5,a5,-1
    8000390c:	0007871b          	sext.w	a4,a5
    80003910:	c0dc                	sw	a5,4(s1)
    80003912:	06e04363          	bgtz	a4,80003978 <fileclose+0x98>
    release(&ftable.lock);
    return;
  }
  ff = *f;
    80003916:	0004a903          	lw	s2,0(s1)
    8000391a:	0094ca83          	lbu	s5,9(s1)
    8000391e:	0104ba03          	ld	s4,16(s1)
    80003922:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    80003926:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    8000392a:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    8000392e:	00016517          	auipc	a0,0x16
    80003932:	83a50513          	add	a0,a0,-1990 # 80019168 <ftable>
    80003936:	00002097          	auipc	ra,0x2
    8000393a:	730080e7          	jalr	1840(ra) # 80006066 <release>

  if(ff.type == FD_PIPE){
    8000393e:	4785                	li	a5,1
    80003940:	04f90d63          	beq	s2,a5,8000399a <fileclose+0xba>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80003944:	3979                	addw	s2,s2,-2
    80003946:	4785                	li	a5,1
    80003948:	0527e063          	bltu	a5,s2,80003988 <fileclose+0xa8>
    begin_op();
    8000394c:	00000097          	auipc	ra,0x0
    80003950:	ad0080e7          	jalr	-1328(ra) # 8000341c <begin_op>
    iput(ff.ip);
    80003954:	854e                	mv	a0,s3
    80003956:	fffff097          	auipc	ra,0xfffff
    8000395a:	2ca080e7          	jalr	714(ra) # 80002c20 <iput>
    end_op();
    8000395e:	00000097          	auipc	ra,0x0
    80003962:	b38080e7          	jalr	-1224(ra) # 80003496 <end_op>
    80003966:	a00d                	j	80003988 <fileclose+0xa8>
    panic("fileclose");
    80003968:	00005517          	auipc	a0,0x5
    8000396c:	ca850513          	add	a0,a0,-856 # 80008610 <syscalls+0x248>
    80003970:	00002097          	auipc	ra,0x2
    80003974:	10a080e7          	jalr	266(ra) # 80005a7a <panic>
    release(&ftable.lock);
    80003978:	00015517          	auipc	a0,0x15
    8000397c:	7f050513          	add	a0,a0,2032 # 80019168 <ftable>
    80003980:	00002097          	auipc	ra,0x2
    80003984:	6e6080e7          	jalr	1766(ra) # 80006066 <release>
  }
}
    80003988:	70e2                	ld	ra,56(sp)
    8000398a:	7442                	ld	s0,48(sp)
    8000398c:	74a2                	ld	s1,40(sp)
    8000398e:	7902                	ld	s2,32(sp)
    80003990:	69e2                	ld	s3,24(sp)
    80003992:	6a42                	ld	s4,16(sp)
    80003994:	6aa2                	ld	s5,8(sp)
    80003996:	6121                	add	sp,sp,64
    80003998:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    8000399a:	85d6                	mv	a1,s5
    8000399c:	8552                	mv	a0,s4
    8000399e:	00000097          	auipc	ra,0x0
    800039a2:	348080e7          	jalr	840(ra) # 80003ce6 <pipeclose>
    800039a6:	b7cd                	j	80003988 <fileclose+0xa8>

00000000800039a8 <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    800039a8:	715d                	add	sp,sp,-80
    800039aa:	e486                	sd	ra,72(sp)
    800039ac:	e0a2                	sd	s0,64(sp)
    800039ae:	fc26                	sd	s1,56(sp)
    800039b0:	f84a                	sd	s2,48(sp)
    800039b2:	f44e                	sd	s3,40(sp)
    800039b4:	0880                	add	s0,sp,80
    800039b6:	84aa                	mv	s1,a0
    800039b8:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    800039ba:	ffffd097          	auipc	ra,0xffffd
    800039be:	488080e7          	jalr	1160(ra) # 80000e42 <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    800039c2:	409c                	lw	a5,0(s1)
    800039c4:	37f9                	addw	a5,a5,-2
    800039c6:	4705                	li	a4,1
    800039c8:	04f76763          	bltu	a4,a5,80003a16 <filestat+0x6e>
    800039cc:	892a                	mv	s2,a0
    ilock(f->ip);
    800039ce:	6c88                	ld	a0,24(s1)
    800039d0:	fffff097          	auipc	ra,0xfffff
    800039d4:	096080e7          	jalr	150(ra) # 80002a66 <ilock>
    stati(f->ip, &st);
    800039d8:	fb840593          	add	a1,s0,-72
    800039dc:	6c88                	ld	a0,24(s1)
    800039de:	fffff097          	auipc	ra,0xfffff
    800039e2:	312080e7          	jalr	786(ra) # 80002cf0 <stati>
    iunlock(f->ip);
    800039e6:	6c88                	ld	a0,24(s1)
    800039e8:	fffff097          	auipc	ra,0xfffff
    800039ec:	140080e7          	jalr	320(ra) # 80002b28 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    800039f0:	46e1                	li	a3,24
    800039f2:	fb840613          	add	a2,s0,-72
    800039f6:	85ce                	mv	a1,s3
    800039f8:	05093503          	ld	a0,80(s2)
    800039fc:	ffffd097          	auipc	ra,0xffffd
    80003a00:	10a080e7          	jalr	266(ra) # 80000b06 <copyout>
    80003a04:	41f5551b          	sraw	a0,a0,0x1f
      return -1;
    return 0;
  }
  return -1;
}
    80003a08:	60a6                	ld	ra,72(sp)
    80003a0a:	6406                	ld	s0,64(sp)
    80003a0c:	74e2                	ld	s1,56(sp)
    80003a0e:	7942                	ld	s2,48(sp)
    80003a10:	79a2                	ld	s3,40(sp)
    80003a12:	6161                	add	sp,sp,80
    80003a14:	8082                	ret
  return -1;
    80003a16:	557d                	li	a0,-1
    80003a18:	bfc5                	j	80003a08 <filestat+0x60>

0000000080003a1a <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80003a1a:	7179                	add	sp,sp,-48
    80003a1c:	f406                	sd	ra,40(sp)
    80003a1e:	f022                	sd	s0,32(sp)
    80003a20:	ec26                	sd	s1,24(sp)
    80003a22:	e84a                	sd	s2,16(sp)
    80003a24:	e44e                	sd	s3,8(sp)
    80003a26:	1800                	add	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    80003a28:	00854783          	lbu	a5,8(a0)
    80003a2c:	c3d5                	beqz	a5,80003ad0 <fileread+0xb6>
    80003a2e:	84aa                	mv	s1,a0
    80003a30:	89ae                	mv	s3,a1
    80003a32:	8932                	mv	s2,a2
    return -1;

  if(f->type == FD_PIPE){
    80003a34:	411c                	lw	a5,0(a0)
    80003a36:	4705                	li	a4,1
    80003a38:	04e78963          	beq	a5,a4,80003a8a <fileread+0x70>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003a3c:	470d                	li	a4,3
    80003a3e:	04e78d63          	beq	a5,a4,80003a98 <fileread+0x7e>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    80003a42:	4709                	li	a4,2
    80003a44:	06e79e63          	bne	a5,a4,80003ac0 <fileread+0xa6>
    ilock(f->ip);
    80003a48:	6d08                	ld	a0,24(a0)
    80003a4a:	fffff097          	auipc	ra,0xfffff
    80003a4e:	01c080e7          	jalr	28(ra) # 80002a66 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80003a52:	874a                	mv	a4,s2
    80003a54:	5094                	lw	a3,32(s1)
    80003a56:	864e                	mv	a2,s3
    80003a58:	4585                	li	a1,1
    80003a5a:	6c88                	ld	a0,24(s1)
    80003a5c:	fffff097          	auipc	ra,0xfffff
    80003a60:	2be080e7          	jalr	702(ra) # 80002d1a <readi>
    80003a64:	892a                	mv	s2,a0
    80003a66:	00a05563          	blez	a0,80003a70 <fileread+0x56>
      f->off += r;
    80003a6a:	509c                	lw	a5,32(s1)
    80003a6c:	9fa9                	addw	a5,a5,a0
    80003a6e:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    80003a70:	6c88                	ld	a0,24(s1)
    80003a72:	fffff097          	auipc	ra,0xfffff
    80003a76:	0b6080e7          	jalr	182(ra) # 80002b28 <iunlock>
  } else {
    panic("fileread");
  }

  return r;
}
    80003a7a:	854a                	mv	a0,s2
    80003a7c:	70a2                	ld	ra,40(sp)
    80003a7e:	7402                	ld	s0,32(sp)
    80003a80:	64e2                	ld	s1,24(sp)
    80003a82:	6942                	ld	s2,16(sp)
    80003a84:	69a2                	ld	s3,8(sp)
    80003a86:	6145                	add	sp,sp,48
    80003a88:	8082                	ret
    r = piperead(f->pipe, addr, n);
    80003a8a:	6908                	ld	a0,16(a0)
    80003a8c:	00000097          	auipc	ra,0x0
    80003a90:	3bc080e7          	jalr	956(ra) # 80003e48 <piperead>
    80003a94:	892a                	mv	s2,a0
    80003a96:	b7d5                	j	80003a7a <fileread+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80003a98:	02451783          	lh	a5,36(a0)
    80003a9c:	03079693          	sll	a3,a5,0x30
    80003aa0:	92c1                	srl	a3,a3,0x30
    80003aa2:	4725                	li	a4,9
    80003aa4:	02d76863          	bltu	a4,a3,80003ad4 <fileread+0xba>
    80003aa8:	0792                	sll	a5,a5,0x4
    80003aaa:	00015717          	auipc	a4,0x15
    80003aae:	61e70713          	add	a4,a4,1566 # 800190c8 <devsw>
    80003ab2:	97ba                	add	a5,a5,a4
    80003ab4:	639c                	ld	a5,0(a5)
    80003ab6:	c38d                	beqz	a5,80003ad8 <fileread+0xbe>
    r = devsw[f->major].read(1, addr, n);
    80003ab8:	4505                	li	a0,1
    80003aba:	9782                	jalr	a5
    80003abc:	892a                	mv	s2,a0
    80003abe:	bf75                	j	80003a7a <fileread+0x60>
    panic("fileread");
    80003ac0:	00005517          	auipc	a0,0x5
    80003ac4:	b6050513          	add	a0,a0,-1184 # 80008620 <syscalls+0x258>
    80003ac8:	00002097          	auipc	ra,0x2
    80003acc:	fb2080e7          	jalr	-78(ra) # 80005a7a <panic>
    return -1;
    80003ad0:	597d                	li	s2,-1
    80003ad2:	b765                	j	80003a7a <fileread+0x60>
      return -1;
    80003ad4:	597d                	li	s2,-1
    80003ad6:	b755                	j	80003a7a <fileread+0x60>
    80003ad8:	597d                	li	s2,-1
    80003ada:	b745                	j	80003a7a <fileread+0x60>

0000000080003adc <filewrite>:
int
filewrite(struct file *f, uint64 addr, int n)
{
  int r, ret = 0;

  if(f->writable == 0)
    80003adc:	00954783          	lbu	a5,9(a0)
    80003ae0:	10078e63          	beqz	a5,80003bfc <filewrite+0x120>
{
    80003ae4:	715d                	add	sp,sp,-80
    80003ae6:	e486                	sd	ra,72(sp)
    80003ae8:	e0a2                	sd	s0,64(sp)
    80003aea:	fc26                	sd	s1,56(sp)
    80003aec:	f84a                	sd	s2,48(sp)
    80003aee:	f44e                	sd	s3,40(sp)
    80003af0:	f052                	sd	s4,32(sp)
    80003af2:	ec56                	sd	s5,24(sp)
    80003af4:	e85a                	sd	s6,16(sp)
    80003af6:	e45e                	sd	s7,8(sp)
    80003af8:	e062                	sd	s8,0(sp)
    80003afa:	0880                	add	s0,sp,80
    80003afc:	892a                	mv	s2,a0
    80003afe:	8b2e                	mv	s6,a1
    80003b00:	8a32                	mv	s4,a2
    return -1;

  if(f->type == FD_PIPE){
    80003b02:	411c                	lw	a5,0(a0)
    80003b04:	4705                	li	a4,1
    80003b06:	02e78263          	beq	a5,a4,80003b2a <filewrite+0x4e>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003b0a:	470d                	li	a4,3
    80003b0c:	02e78563          	beq	a5,a4,80003b36 <filewrite+0x5a>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    80003b10:	4709                	li	a4,2
    80003b12:	0ce79d63          	bne	a5,a4,80003bec <filewrite+0x110>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    80003b16:	0ac05b63          	blez	a2,80003bcc <filewrite+0xf0>
    int i = 0;
    80003b1a:	4981                	li	s3,0
      int n1 = n - i;
      if(n1 > max)
    80003b1c:	6b85                	lui	s7,0x1
    80003b1e:	c00b8b93          	add	s7,s7,-1024 # c00 <_entry-0x7ffff400>
    80003b22:	6c05                	lui	s8,0x1
    80003b24:	c00c0c1b          	addw	s8,s8,-1024 # c00 <_entry-0x7ffff400>
    80003b28:	a851                	j	80003bbc <filewrite+0xe0>
    ret = pipewrite(f->pipe, addr, n);
    80003b2a:	6908                	ld	a0,16(a0)
    80003b2c:	00000097          	auipc	ra,0x0
    80003b30:	22a080e7          	jalr	554(ra) # 80003d56 <pipewrite>
    80003b34:	a045                	j	80003bd4 <filewrite+0xf8>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80003b36:	02451783          	lh	a5,36(a0)
    80003b3a:	03079693          	sll	a3,a5,0x30
    80003b3e:	92c1                	srl	a3,a3,0x30
    80003b40:	4725                	li	a4,9
    80003b42:	0ad76f63          	bltu	a4,a3,80003c00 <filewrite+0x124>
    80003b46:	0792                	sll	a5,a5,0x4
    80003b48:	00015717          	auipc	a4,0x15
    80003b4c:	58070713          	add	a4,a4,1408 # 800190c8 <devsw>
    80003b50:	97ba                	add	a5,a5,a4
    80003b52:	679c                	ld	a5,8(a5)
    80003b54:	cbc5                	beqz	a5,80003c04 <filewrite+0x128>
    ret = devsw[f->major].write(1, addr, n);
    80003b56:	4505                	li	a0,1
    80003b58:	9782                	jalr	a5
    80003b5a:	a8ad                	j	80003bd4 <filewrite+0xf8>
      if(n1 > max)
    80003b5c:	00048a9b          	sext.w	s5,s1
        n1 = max;

      begin_op();
    80003b60:	00000097          	auipc	ra,0x0
    80003b64:	8bc080e7          	jalr	-1860(ra) # 8000341c <begin_op>
      ilock(f->ip);
    80003b68:	01893503          	ld	a0,24(s2)
    80003b6c:	fffff097          	auipc	ra,0xfffff
    80003b70:	efa080e7          	jalr	-262(ra) # 80002a66 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80003b74:	8756                	mv	a4,s5
    80003b76:	02092683          	lw	a3,32(s2)
    80003b7a:	01698633          	add	a2,s3,s6
    80003b7e:	4585                	li	a1,1
    80003b80:	01893503          	ld	a0,24(s2)
    80003b84:	fffff097          	auipc	ra,0xfffff
    80003b88:	28e080e7          	jalr	654(ra) # 80002e12 <writei>
    80003b8c:	84aa                	mv	s1,a0
    80003b8e:	00a05763          	blez	a0,80003b9c <filewrite+0xc0>
        f->off += r;
    80003b92:	02092783          	lw	a5,32(s2)
    80003b96:	9fa9                	addw	a5,a5,a0
    80003b98:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    80003b9c:	01893503          	ld	a0,24(s2)
    80003ba0:	fffff097          	auipc	ra,0xfffff
    80003ba4:	f88080e7          	jalr	-120(ra) # 80002b28 <iunlock>
      end_op();
    80003ba8:	00000097          	auipc	ra,0x0
    80003bac:	8ee080e7          	jalr	-1810(ra) # 80003496 <end_op>

      if(r != n1){
    80003bb0:	009a9f63          	bne	s5,s1,80003bce <filewrite+0xf2>
        // error from writei
        break;
      }
      i += r;
    80003bb4:	013489bb          	addw	s3,s1,s3
    while(i < n){
    80003bb8:	0149db63          	bge	s3,s4,80003bce <filewrite+0xf2>
      int n1 = n - i;
    80003bbc:	413a04bb          	subw	s1,s4,s3
      if(n1 > max)
    80003bc0:	0004879b          	sext.w	a5,s1
    80003bc4:	f8fbdce3          	bge	s7,a5,80003b5c <filewrite+0x80>
    80003bc8:	84e2                	mv	s1,s8
    80003bca:	bf49                	j	80003b5c <filewrite+0x80>
    int i = 0;
    80003bcc:	4981                	li	s3,0
    }
    ret = (i == n ? n : -1);
    80003bce:	033a1d63          	bne	s4,s3,80003c08 <filewrite+0x12c>
    80003bd2:	8552                	mv	a0,s4
  } else {
    panic("filewrite");
  }

  return ret;
}
    80003bd4:	60a6                	ld	ra,72(sp)
    80003bd6:	6406                	ld	s0,64(sp)
    80003bd8:	74e2                	ld	s1,56(sp)
    80003bda:	7942                	ld	s2,48(sp)
    80003bdc:	79a2                	ld	s3,40(sp)
    80003bde:	7a02                	ld	s4,32(sp)
    80003be0:	6ae2                	ld	s5,24(sp)
    80003be2:	6b42                	ld	s6,16(sp)
    80003be4:	6ba2                	ld	s7,8(sp)
    80003be6:	6c02                	ld	s8,0(sp)
    80003be8:	6161                	add	sp,sp,80
    80003bea:	8082                	ret
    panic("filewrite");
    80003bec:	00005517          	auipc	a0,0x5
    80003bf0:	a4450513          	add	a0,a0,-1468 # 80008630 <syscalls+0x268>
    80003bf4:	00002097          	auipc	ra,0x2
    80003bf8:	e86080e7          	jalr	-378(ra) # 80005a7a <panic>
    return -1;
    80003bfc:	557d                	li	a0,-1
}
    80003bfe:	8082                	ret
      return -1;
    80003c00:	557d                	li	a0,-1
    80003c02:	bfc9                	j	80003bd4 <filewrite+0xf8>
    80003c04:	557d                	li	a0,-1
    80003c06:	b7f9                	j	80003bd4 <filewrite+0xf8>
    ret = (i == n ? n : -1);
    80003c08:	557d                	li	a0,-1
    80003c0a:	b7e9                	j	80003bd4 <filewrite+0xf8>

0000000080003c0c <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80003c0c:	7179                	add	sp,sp,-48
    80003c0e:	f406                	sd	ra,40(sp)
    80003c10:	f022                	sd	s0,32(sp)
    80003c12:	ec26                	sd	s1,24(sp)
    80003c14:	e84a                	sd	s2,16(sp)
    80003c16:	e44e                	sd	s3,8(sp)
    80003c18:	e052                	sd	s4,0(sp)
    80003c1a:	1800                	add	s0,sp,48
    80003c1c:	84aa                	mv	s1,a0
    80003c1e:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80003c20:	0005b023          	sd	zero,0(a1)
    80003c24:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80003c28:	00000097          	auipc	ra,0x0
    80003c2c:	bfc080e7          	jalr	-1028(ra) # 80003824 <filealloc>
    80003c30:	e088                	sd	a0,0(s1)
    80003c32:	c551                	beqz	a0,80003cbe <pipealloc+0xb2>
    80003c34:	00000097          	auipc	ra,0x0
    80003c38:	bf0080e7          	jalr	-1040(ra) # 80003824 <filealloc>
    80003c3c:	00aa3023          	sd	a0,0(s4)
    80003c40:	c92d                	beqz	a0,80003cb2 <pipealloc+0xa6>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80003c42:	ffffc097          	auipc	ra,0xffffc
    80003c46:	4d8080e7          	jalr	1240(ra) # 8000011a <kalloc>
    80003c4a:	892a                	mv	s2,a0
    80003c4c:	c125                	beqz	a0,80003cac <pipealloc+0xa0>
    goto bad;
  pi->readopen = 1;
    80003c4e:	4985                	li	s3,1
    80003c50:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    80003c54:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    80003c58:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80003c5c:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    80003c60:	00005597          	auipc	a1,0x5
    80003c64:	9e058593          	add	a1,a1,-1568 # 80008640 <syscalls+0x278>
    80003c68:	00002097          	auipc	ra,0x2
    80003c6c:	2ba080e7          	jalr	698(ra) # 80005f22 <initlock>
  (*f0)->type = FD_PIPE;
    80003c70:	609c                	ld	a5,0(s1)
    80003c72:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    80003c76:	609c                	ld	a5,0(s1)
    80003c78:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    80003c7c:	609c                	ld	a5,0(s1)
    80003c7e:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80003c82:	609c                	ld	a5,0(s1)
    80003c84:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    80003c88:	000a3783          	ld	a5,0(s4)
    80003c8c:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    80003c90:	000a3783          	ld	a5,0(s4)
    80003c94:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80003c98:	000a3783          	ld	a5,0(s4)
    80003c9c:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80003ca0:	000a3783          	ld	a5,0(s4)
    80003ca4:	0127b823          	sd	s2,16(a5)
  return 0;
    80003ca8:	4501                	li	a0,0
    80003caa:	a025                	j	80003cd2 <pipealloc+0xc6>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80003cac:	6088                	ld	a0,0(s1)
    80003cae:	e501                	bnez	a0,80003cb6 <pipealloc+0xaa>
    80003cb0:	a039                	j	80003cbe <pipealloc+0xb2>
    80003cb2:	6088                	ld	a0,0(s1)
    80003cb4:	c51d                	beqz	a0,80003ce2 <pipealloc+0xd6>
    fileclose(*f0);
    80003cb6:	00000097          	auipc	ra,0x0
    80003cba:	c2a080e7          	jalr	-982(ra) # 800038e0 <fileclose>
  if(*f1)
    80003cbe:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    80003cc2:	557d                	li	a0,-1
  if(*f1)
    80003cc4:	c799                	beqz	a5,80003cd2 <pipealloc+0xc6>
    fileclose(*f1);
    80003cc6:	853e                	mv	a0,a5
    80003cc8:	00000097          	auipc	ra,0x0
    80003ccc:	c18080e7          	jalr	-1000(ra) # 800038e0 <fileclose>
  return -1;
    80003cd0:	557d                	li	a0,-1
}
    80003cd2:	70a2                	ld	ra,40(sp)
    80003cd4:	7402                	ld	s0,32(sp)
    80003cd6:	64e2                	ld	s1,24(sp)
    80003cd8:	6942                	ld	s2,16(sp)
    80003cda:	69a2                	ld	s3,8(sp)
    80003cdc:	6a02                	ld	s4,0(sp)
    80003cde:	6145                	add	sp,sp,48
    80003ce0:	8082                	ret
  return -1;
    80003ce2:	557d                	li	a0,-1
    80003ce4:	b7fd                	j	80003cd2 <pipealloc+0xc6>

0000000080003ce6 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80003ce6:	1101                	add	sp,sp,-32
    80003ce8:	ec06                	sd	ra,24(sp)
    80003cea:	e822                	sd	s0,16(sp)
    80003cec:	e426                	sd	s1,8(sp)
    80003cee:	e04a                	sd	s2,0(sp)
    80003cf0:	1000                	add	s0,sp,32
    80003cf2:	84aa                	mv	s1,a0
    80003cf4:	892e                	mv	s2,a1
  acquire(&pi->lock);
    80003cf6:	00002097          	auipc	ra,0x2
    80003cfa:	2bc080e7          	jalr	700(ra) # 80005fb2 <acquire>
  if(writable){
    80003cfe:	02090d63          	beqz	s2,80003d38 <pipeclose+0x52>
    pi->writeopen = 0;
    80003d02:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    80003d06:	21848513          	add	a0,s1,536
    80003d0a:	ffffe097          	auipc	ra,0xffffe
    80003d0e:	988080e7          	jalr	-1656(ra) # 80001692 <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80003d12:	2204b783          	ld	a5,544(s1)
    80003d16:	eb95                	bnez	a5,80003d4a <pipeclose+0x64>
    release(&pi->lock);
    80003d18:	8526                	mv	a0,s1
    80003d1a:	00002097          	auipc	ra,0x2
    80003d1e:	34c080e7          	jalr	844(ra) # 80006066 <release>
    kfree((char*)pi);
    80003d22:	8526                	mv	a0,s1
    80003d24:	ffffc097          	auipc	ra,0xffffc
    80003d28:	2f8080e7          	jalr	760(ra) # 8000001c <kfree>
  } else
    release(&pi->lock);
}
    80003d2c:	60e2                	ld	ra,24(sp)
    80003d2e:	6442                	ld	s0,16(sp)
    80003d30:	64a2                	ld	s1,8(sp)
    80003d32:	6902                	ld	s2,0(sp)
    80003d34:	6105                	add	sp,sp,32
    80003d36:	8082                	ret
    pi->readopen = 0;
    80003d38:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    80003d3c:	21c48513          	add	a0,s1,540
    80003d40:	ffffe097          	auipc	ra,0xffffe
    80003d44:	952080e7          	jalr	-1710(ra) # 80001692 <wakeup>
    80003d48:	b7e9                	j	80003d12 <pipeclose+0x2c>
    release(&pi->lock);
    80003d4a:	8526                	mv	a0,s1
    80003d4c:	00002097          	auipc	ra,0x2
    80003d50:	31a080e7          	jalr	794(ra) # 80006066 <release>
}
    80003d54:	bfe1                	j	80003d2c <pipeclose+0x46>

0000000080003d56 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80003d56:	711d                	add	sp,sp,-96
    80003d58:	ec86                	sd	ra,88(sp)
    80003d5a:	e8a2                	sd	s0,80(sp)
    80003d5c:	e4a6                	sd	s1,72(sp)
    80003d5e:	e0ca                	sd	s2,64(sp)
    80003d60:	fc4e                	sd	s3,56(sp)
    80003d62:	f852                	sd	s4,48(sp)
    80003d64:	f456                	sd	s5,40(sp)
    80003d66:	f05a                	sd	s6,32(sp)
    80003d68:	ec5e                	sd	s7,24(sp)
    80003d6a:	e862                	sd	s8,16(sp)
    80003d6c:	1080                	add	s0,sp,96
    80003d6e:	84aa                	mv	s1,a0
    80003d70:	8aae                	mv	s5,a1
    80003d72:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    80003d74:	ffffd097          	auipc	ra,0xffffd
    80003d78:	0ce080e7          	jalr	206(ra) # 80000e42 <myproc>
    80003d7c:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    80003d7e:	8526                	mv	a0,s1
    80003d80:	00002097          	auipc	ra,0x2
    80003d84:	232080e7          	jalr	562(ra) # 80005fb2 <acquire>
  while(i < n){
    80003d88:	0b405363          	blez	s4,80003e2e <pipewrite+0xd8>
  int i = 0;
    80003d8c:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80003d8e:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    80003d90:	21848c13          	add	s8,s1,536
      sleep(&pi->nwrite, &pi->lock);
    80003d94:	21c48b93          	add	s7,s1,540
    80003d98:	a089                	j	80003dda <pipewrite+0x84>
      release(&pi->lock);
    80003d9a:	8526                	mv	a0,s1
    80003d9c:	00002097          	auipc	ra,0x2
    80003da0:	2ca080e7          	jalr	714(ra) # 80006066 <release>
      return -1;
    80003da4:	597d                	li	s2,-1
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    80003da6:	854a                	mv	a0,s2
    80003da8:	60e6                	ld	ra,88(sp)
    80003daa:	6446                	ld	s0,80(sp)
    80003dac:	64a6                	ld	s1,72(sp)
    80003dae:	6906                	ld	s2,64(sp)
    80003db0:	79e2                	ld	s3,56(sp)
    80003db2:	7a42                	ld	s4,48(sp)
    80003db4:	7aa2                	ld	s5,40(sp)
    80003db6:	7b02                	ld	s6,32(sp)
    80003db8:	6be2                	ld	s7,24(sp)
    80003dba:	6c42                	ld	s8,16(sp)
    80003dbc:	6125                	add	sp,sp,96
    80003dbe:	8082                	ret
      wakeup(&pi->nread);
    80003dc0:	8562                	mv	a0,s8
    80003dc2:	ffffe097          	auipc	ra,0xffffe
    80003dc6:	8d0080e7          	jalr	-1840(ra) # 80001692 <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80003dca:	85a6                	mv	a1,s1
    80003dcc:	855e                	mv	a0,s7
    80003dce:	ffffd097          	auipc	ra,0xffffd
    80003dd2:	738080e7          	jalr	1848(ra) # 80001506 <sleep>
  while(i < n){
    80003dd6:	05495d63          	bge	s2,s4,80003e30 <pipewrite+0xda>
    if(pi->readopen == 0 || pr->killed){
    80003dda:	2204a783          	lw	a5,544(s1)
    80003dde:	dfd5                	beqz	a5,80003d9a <pipewrite+0x44>
    80003de0:	0289a783          	lw	a5,40(s3)
    80003de4:	fbdd                	bnez	a5,80003d9a <pipewrite+0x44>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    80003de6:	2184a783          	lw	a5,536(s1)
    80003dea:	21c4a703          	lw	a4,540(s1)
    80003dee:	2007879b          	addw	a5,a5,512
    80003df2:	fcf707e3          	beq	a4,a5,80003dc0 <pipewrite+0x6a>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80003df6:	4685                	li	a3,1
    80003df8:	01590633          	add	a2,s2,s5
    80003dfc:	faf40593          	add	a1,s0,-81
    80003e00:	0509b503          	ld	a0,80(s3)
    80003e04:	ffffd097          	auipc	ra,0xffffd
    80003e08:	d8e080e7          	jalr	-626(ra) # 80000b92 <copyin>
    80003e0c:	03650263          	beq	a0,s6,80003e30 <pipewrite+0xda>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80003e10:	21c4a783          	lw	a5,540(s1)
    80003e14:	0017871b          	addw	a4,a5,1
    80003e18:	20e4ae23          	sw	a4,540(s1)
    80003e1c:	1ff7f793          	and	a5,a5,511
    80003e20:	97a6                	add	a5,a5,s1
    80003e22:	faf44703          	lbu	a4,-81(s0)
    80003e26:	00e78c23          	sb	a4,24(a5)
      i++;
    80003e2a:	2905                	addw	s2,s2,1
    80003e2c:	b76d                	j	80003dd6 <pipewrite+0x80>
  int i = 0;
    80003e2e:	4901                	li	s2,0
  wakeup(&pi->nread);
    80003e30:	21848513          	add	a0,s1,536
    80003e34:	ffffe097          	auipc	ra,0xffffe
    80003e38:	85e080e7          	jalr	-1954(ra) # 80001692 <wakeup>
  release(&pi->lock);
    80003e3c:	8526                	mv	a0,s1
    80003e3e:	00002097          	auipc	ra,0x2
    80003e42:	228080e7          	jalr	552(ra) # 80006066 <release>
  return i;
    80003e46:	b785                	j	80003da6 <pipewrite+0x50>

0000000080003e48 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80003e48:	715d                	add	sp,sp,-80
    80003e4a:	e486                	sd	ra,72(sp)
    80003e4c:	e0a2                	sd	s0,64(sp)
    80003e4e:	fc26                	sd	s1,56(sp)
    80003e50:	f84a                	sd	s2,48(sp)
    80003e52:	f44e                	sd	s3,40(sp)
    80003e54:	f052                	sd	s4,32(sp)
    80003e56:	ec56                	sd	s5,24(sp)
    80003e58:	e85a                	sd	s6,16(sp)
    80003e5a:	0880                	add	s0,sp,80
    80003e5c:	84aa                	mv	s1,a0
    80003e5e:	892e                	mv	s2,a1
    80003e60:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    80003e62:	ffffd097          	auipc	ra,0xffffd
    80003e66:	fe0080e7          	jalr	-32(ra) # 80000e42 <myproc>
    80003e6a:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    80003e6c:	8526                	mv	a0,s1
    80003e6e:	00002097          	auipc	ra,0x2
    80003e72:	144080e7          	jalr	324(ra) # 80005fb2 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80003e76:	2184a703          	lw	a4,536(s1)
    80003e7a:	21c4a783          	lw	a5,540(s1)
    if(pr->killed){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80003e7e:	21848993          	add	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80003e82:	02f71463          	bne	a4,a5,80003eaa <piperead+0x62>
    80003e86:	2244a783          	lw	a5,548(s1)
    80003e8a:	c385                	beqz	a5,80003eaa <piperead+0x62>
    if(pr->killed){
    80003e8c:	028a2783          	lw	a5,40(s4)
    80003e90:	ebc9                	bnez	a5,80003f22 <piperead+0xda>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80003e92:	85a6                	mv	a1,s1
    80003e94:	854e                	mv	a0,s3
    80003e96:	ffffd097          	auipc	ra,0xffffd
    80003e9a:	670080e7          	jalr	1648(ra) # 80001506 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80003e9e:	2184a703          	lw	a4,536(s1)
    80003ea2:	21c4a783          	lw	a5,540(s1)
    80003ea6:	fef700e3          	beq	a4,a5,80003e86 <piperead+0x3e>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80003eaa:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80003eac:	5b7d                	li	s6,-1
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80003eae:	05505463          	blez	s5,80003ef6 <piperead+0xae>
    if(pi->nread == pi->nwrite)
    80003eb2:	2184a783          	lw	a5,536(s1)
    80003eb6:	21c4a703          	lw	a4,540(s1)
    80003eba:	02f70e63          	beq	a4,a5,80003ef6 <piperead+0xae>
    ch = pi->data[pi->nread++ % PIPESIZE];
    80003ebe:	0017871b          	addw	a4,a5,1
    80003ec2:	20e4ac23          	sw	a4,536(s1)
    80003ec6:	1ff7f793          	and	a5,a5,511
    80003eca:	97a6                	add	a5,a5,s1
    80003ecc:	0187c783          	lbu	a5,24(a5)
    80003ed0:	faf40fa3          	sb	a5,-65(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80003ed4:	4685                	li	a3,1
    80003ed6:	fbf40613          	add	a2,s0,-65
    80003eda:	85ca                	mv	a1,s2
    80003edc:	050a3503          	ld	a0,80(s4)
    80003ee0:	ffffd097          	auipc	ra,0xffffd
    80003ee4:	c26080e7          	jalr	-986(ra) # 80000b06 <copyout>
    80003ee8:	01650763          	beq	a0,s6,80003ef6 <piperead+0xae>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80003eec:	2985                	addw	s3,s3,1
    80003eee:	0905                	add	s2,s2,1
    80003ef0:	fd3a91e3          	bne	s5,s3,80003eb2 <piperead+0x6a>
    80003ef4:	89d6                	mv	s3,s5
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80003ef6:	21c48513          	add	a0,s1,540
    80003efa:	ffffd097          	auipc	ra,0xffffd
    80003efe:	798080e7          	jalr	1944(ra) # 80001692 <wakeup>
  release(&pi->lock);
    80003f02:	8526                	mv	a0,s1
    80003f04:	00002097          	auipc	ra,0x2
    80003f08:	162080e7          	jalr	354(ra) # 80006066 <release>
  return i;
}
    80003f0c:	854e                	mv	a0,s3
    80003f0e:	60a6                	ld	ra,72(sp)
    80003f10:	6406                	ld	s0,64(sp)
    80003f12:	74e2                	ld	s1,56(sp)
    80003f14:	7942                	ld	s2,48(sp)
    80003f16:	79a2                	ld	s3,40(sp)
    80003f18:	7a02                	ld	s4,32(sp)
    80003f1a:	6ae2                	ld	s5,24(sp)
    80003f1c:	6b42                	ld	s6,16(sp)
    80003f1e:	6161                	add	sp,sp,80
    80003f20:	8082                	ret
      release(&pi->lock);
    80003f22:	8526                	mv	a0,s1
    80003f24:	00002097          	auipc	ra,0x2
    80003f28:	142080e7          	jalr	322(ra) # 80006066 <release>
      return -1;
    80003f2c:	59fd                	li	s3,-1
    80003f2e:	bff9                	j	80003f0c <piperead+0xc4>

0000000080003f30 <exec>:

static int loadseg(pde_t *pgdir, uint64 addr, struct inode *ip, uint offset, uint sz);

int
exec(char *path, char **argv)
{
    80003f30:	df010113          	add	sp,sp,-528
    80003f34:	20113423          	sd	ra,520(sp)
    80003f38:	20813023          	sd	s0,512(sp)
    80003f3c:	ffa6                	sd	s1,504(sp)
    80003f3e:	fbca                	sd	s2,496(sp)
    80003f40:	f7ce                	sd	s3,488(sp)
    80003f42:	f3d2                	sd	s4,480(sp)
    80003f44:	efd6                	sd	s5,472(sp)
    80003f46:	ebda                	sd	s6,464(sp)
    80003f48:	e7de                	sd	s7,456(sp)
    80003f4a:	e3e2                	sd	s8,448(sp)
    80003f4c:	ff66                	sd	s9,440(sp)
    80003f4e:	fb6a                	sd	s10,432(sp)
    80003f50:	f76e                	sd	s11,424(sp)
    80003f52:	0c00                	add	s0,sp,528
    80003f54:	892a                	mv	s2,a0
    80003f56:	dea43c23          	sd	a0,-520(s0)
    80003f5a:	e0b43023          	sd	a1,-512(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    80003f5e:	ffffd097          	auipc	ra,0xffffd
    80003f62:	ee4080e7          	jalr	-284(ra) # 80000e42 <myproc>
    80003f66:	84aa                	mv	s1,a0

  begin_op();
    80003f68:	fffff097          	auipc	ra,0xfffff
    80003f6c:	4b4080e7          	jalr	1204(ra) # 8000341c <begin_op>

  if((ip = namei(path)) == 0){
    80003f70:	854a                	mv	a0,s2
    80003f72:	fffff097          	auipc	ra,0xfffff
    80003f76:	2aa080e7          	jalr	682(ra) # 8000321c <namei>
    80003f7a:	c92d                	beqz	a0,80003fec <exec+0xbc>
    80003f7c:	8a2a                	mv	s4,a0
    end_op();
    return -1;
  }
  ilock(ip);
    80003f7e:	fffff097          	auipc	ra,0xfffff
    80003f82:	ae8080e7          	jalr	-1304(ra) # 80002a66 <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    80003f86:	04000713          	li	a4,64
    80003f8a:	4681                	li	a3,0
    80003f8c:	e5040613          	add	a2,s0,-432
    80003f90:	4581                	li	a1,0
    80003f92:	8552                	mv	a0,s4
    80003f94:	fffff097          	auipc	ra,0xfffff
    80003f98:	d86080e7          	jalr	-634(ra) # 80002d1a <readi>
    80003f9c:	04000793          	li	a5,64
    80003fa0:	00f51a63          	bne	a0,a5,80003fb4 <exec+0x84>
    goto bad;
  if(elf.magic != ELF_MAGIC)
    80003fa4:	e5042703          	lw	a4,-432(s0)
    80003fa8:	464c47b7          	lui	a5,0x464c4
    80003fac:	57f78793          	add	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80003fb0:	04f70463          	beq	a4,a5,80003ff8 <exec+0xc8>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    80003fb4:	8552                	mv	a0,s4
    80003fb6:	fffff097          	auipc	ra,0xfffff
    80003fba:	d12080e7          	jalr	-750(ra) # 80002cc8 <iunlockput>
    end_op();
    80003fbe:	fffff097          	auipc	ra,0xfffff
    80003fc2:	4d8080e7          	jalr	1240(ra) # 80003496 <end_op>
  }
  return -1;
    80003fc6:	557d                	li	a0,-1
}
    80003fc8:	20813083          	ld	ra,520(sp)
    80003fcc:	20013403          	ld	s0,512(sp)
    80003fd0:	74fe                	ld	s1,504(sp)
    80003fd2:	795e                	ld	s2,496(sp)
    80003fd4:	79be                	ld	s3,488(sp)
    80003fd6:	7a1e                	ld	s4,480(sp)
    80003fd8:	6afe                	ld	s5,472(sp)
    80003fda:	6b5e                	ld	s6,464(sp)
    80003fdc:	6bbe                	ld	s7,456(sp)
    80003fde:	6c1e                	ld	s8,448(sp)
    80003fe0:	7cfa                	ld	s9,440(sp)
    80003fe2:	7d5a                	ld	s10,432(sp)
    80003fe4:	7dba                	ld	s11,424(sp)
    80003fe6:	21010113          	add	sp,sp,528
    80003fea:	8082                	ret
    end_op();
    80003fec:	fffff097          	auipc	ra,0xfffff
    80003ff0:	4aa080e7          	jalr	1194(ra) # 80003496 <end_op>
    return -1;
    80003ff4:	557d                	li	a0,-1
    80003ff6:	bfc9                	j	80003fc8 <exec+0x98>
  if((pagetable = proc_pagetable(p)) == 0)
    80003ff8:	8526                	mv	a0,s1
    80003ffa:	ffffd097          	auipc	ra,0xffffd
    80003ffe:	f0c080e7          	jalr	-244(ra) # 80000f06 <proc_pagetable>
    80004002:	8b2a                	mv	s6,a0
    80004004:	d945                	beqz	a0,80003fb4 <exec+0x84>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004006:	e7042d03          	lw	s10,-400(s0)
    8000400a:	e8845783          	lhu	a5,-376(s0)
    8000400e:	cfe5                	beqz	a5,80004106 <exec+0x1d6>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80004010:	4481                	li	s1,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004012:	4d81                	li	s11,0
    if((ph.vaddr % PGSIZE) != 0)
    80004014:	6c85                	lui	s9,0x1
    80004016:	fffc8793          	add	a5,s9,-1 # fff <_entry-0x7ffff001>
    8000401a:	def43823          	sd	a5,-528(s0)

  for(i = 0; i < sz; i += PGSIZE){
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    if(sz - i < PGSIZE)
    8000401e:	6a85                	lui	s5,0x1
    80004020:	a0b5                	j	8000408c <exec+0x15c>
      panic("loadseg: address should exist");
    80004022:	00004517          	auipc	a0,0x4
    80004026:	62650513          	add	a0,a0,1574 # 80008648 <syscalls+0x280>
    8000402a:	00002097          	auipc	ra,0x2
    8000402e:	a50080e7          	jalr	-1456(ra) # 80005a7a <panic>
    if(sz - i < PGSIZE)
    80004032:	2481                	sext.w	s1,s1
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    80004034:	8726                	mv	a4,s1
    80004036:	012c06bb          	addw	a3,s8,s2
    8000403a:	4581                	li	a1,0
    8000403c:	8552                	mv	a0,s4
    8000403e:	fffff097          	auipc	ra,0xfffff
    80004042:	cdc080e7          	jalr	-804(ra) # 80002d1a <readi>
    80004046:	2501                	sext.w	a0,a0
    80004048:	24a49063          	bne	s1,a0,80004288 <exec+0x358>
  for(i = 0; i < sz; i += PGSIZE){
    8000404c:	012a893b          	addw	s2,s5,s2
    80004050:	03397563          	bgeu	s2,s3,8000407a <exec+0x14a>
    pa = walkaddr(pagetable, va + i);
    80004054:	02091593          	sll	a1,s2,0x20
    80004058:	9181                	srl	a1,a1,0x20
    8000405a:	95de                	add	a1,a1,s7
    8000405c:	855a                	mv	a0,s6
    8000405e:	ffffc097          	auipc	ra,0xffffc
    80004062:	4a0080e7          	jalr	1184(ra) # 800004fe <walkaddr>
    80004066:	862a                	mv	a2,a0
    if(pa == 0)
    80004068:	dd4d                	beqz	a0,80004022 <exec+0xf2>
    if(sz - i < PGSIZE)
    8000406a:	412984bb          	subw	s1,s3,s2
    8000406e:	0004879b          	sext.w	a5,s1
    80004072:	fcfcf0e3          	bgeu	s9,a5,80004032 <exec+0x102>
    80004076:	84d6                	mv	s1,s5
    80004078:	bf6d                	j	80004032 <exec+0x102>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    8000407a:	e0843483          	ld	s1,-504(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    8000407e:	2d85                	addw	s11,s11,1
    80004080:	038d0d1b          	addw	s10,s10,56
    80004084:	e8845783          	lhu	a5,-376(s0)
    80004088:	08fdd063          	bge	s11,a5,80004108 <exec+0x1d8>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    8000408c:	2d01                	sext.w	s10,s10
    8000408e:	03800713          	li	a4,56
    80004092:	86ea                	mv	a3,s10
    80004094:	e1840613          	add	a2,s0,-488
    80004098:	4581                	li	a1,0
    8000409a:	8552                	mv	a0,s4
    8000409c:	fffff097          	auipc	ra,0xfffff
    800040a0:	c7e080e7          	jalr	-898(ra) # 80002d1a <readi>
    800040a4:	03800793          	li	a5,56
    800040a8:	1cf51e63          	bne	a0,a5,80004284 <exec+0x354>
    if(ph.type != ELF_PROG_LOAD)
    800040ac:	e1842783          	lw	a5,-488(s0)
    800040b0:	4705                	li	a4,1
    800040b2:	fce796e3          	bne	a5,a4,8000407e <exec+0x14e>
    if(ph.memsz < ph.filesz)
    800040b6:	e4043603          	ld	a2,-448(s0)
    800040ba:	e3843783          	ld	a5,-456(s0)
    800040be:	1ef66063          	bltu	a2,a5,8000429e <exec+0x36e>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    800040c2:	e2843783          	ld	a5,-472(s0)
    800040c6:	963e                	add	a2,a2,a5
    800040c8:	1cf66e63          	bltu	a2,a5,800042a4 <exec+0x374>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    800040cc:	85a6                	mv	a1,s1
    800040ce:	855a                	mv	a0,s6
    800040d0:	ffffc097          	auipc	ra,0xffffc
    800040d4:	7e2080e7          	jalr	2018(ra) # 800008b2 <uvmalloc>
    800040d8:	e0a43423          	sd	a0,-504(s0)
    800040dc:	1c050763          	beqz	a0,800042aa <exec+0x37a>
    if((ph.vaddr % PGSIZE) != 0)
    800040e0:	e2843b83          	ld	s7,-472(s0)
    800040e4:	df043783          	ld	a5,-528(s0)
    800040e8:	00fbf7b3          	and	a5,s7,a5
    800040ec:	18079e63          	bnez	a5,80004288 <exec+0x358>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    800040f0:	e2042c03          	lw	s8,-480(s0)
    800040f4:	e3842983          	lw	s3,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    800040f8:	00098463          	beqz	s3,80004100 <exec+0x1d0>
    800040fc:	4901                	li	s2,0
    800040fe:	bf99                	j	80004054 <exec+0x124>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    80004100:	e0843483          	ld	s1,-504(s0)
    80004104:	bfad                	j	8000407e <exec+0x14e>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80004106:	4481                	li	s1,0
  iunlockput(ip);
    80004108:	8552                	mv	a0,s4
    8000410a:	fffff097          	auipc	ra,0xfffff
    8000410e:	bbe080e7          	jalr	-1090(ra) # 80002cc8 <iunlockput>
  end_op();
    80004112:	fffff097          	auipc	ra,0xfffff
    80004116:	384080e7          	jalr	900(ra) # 80003496 <end_op>
  p = myproc();
    8000411a:	ffffd097          	auipc	ra,0xffffd
    8000411e:	d28080e7          	jalr	-728(ra) # 80000e42 <myproc>
    80004122:	8aaa                	mv	s5,a0
  uint64 oldsz = p->sz;
    80004124:	04853c83          	ld	s9,72(a0)
  sz = PGROUNDUP(sz);
    80004128:	6985                	lui	s3,0x1
    8000412a:	19fd                	add	s3,s3,-1 # fff <_entry-0x7ffff001>
    8000412c:	99a6                	add	s3,s3,s1
    8000412e:	77fd                	lui	a5,0xfffff
    80004130:	00f9f9b3          	and	s3,s3,a5
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    80004134:	6609                	lui	a2,0x2
    80004136:	964e                	add	a2,a2,s3
    80004138:	85ce                	mv	a1,s3
    8000413a:	855a                	mv	a0,s6
    8000413c:	ffffc097          	auipc	ra,0xffffc
    80004140:	776080e7          	jalr	1910(ra) # 800008b2 <uvmalloc>
    80004144:	892a                	mv	s2,a0
    80004146:	e0a43423          	sd	a0,-504(s0)
    8000414a:	e509                	bnez	a0,80004154 <exec+0x224>
  if(pagetable)
    8000414c:	e1343423          	sd	s3,-504(s0)
    80004150:	4a01                	li	s4,0
    80004152:	aa1d                	j	80004288 <exec+0x358>
  uvmclear(pagetable, sz-2*PGSIZE);
    80004154:	75f9                	lui	a1,0xffffe
    80004156:	95aa                	add	a1,a1,a0
    80004158:	855a                	mv	a0,s6
    8000415a:	ffffd097          	auipc	ra,0xffffd
    8000415e:	97a080e7          	jalr	-1670(ra) # 80000ad4 <uvmclear>
  stackbase = sp - PGSIZE;
    80004162:	7bfd                	lui	s7,0xfffff
    80004164:	9bca                	add	s7,s7,s2
  for(argc = 0; argv[argc]; argc++) {
    80004166:	e0043783          	ld	a5,-512(s0)
    8000416a:	6388                	ld	a0,0(a5)
    8000416c:	c52d                	beqz	a0,800041d6 <exec+0x2a6>
    8000416e:	e9040993          	add	s3,s0,-368
    80004172:	f9040c13          	add	s8,s0,-112
    80004176:	4481                	li	s1,0
    sp -= strlen(argv[argc]) + 1;
    80004178:	ffffc097          	auipc	ra,0xffffc
    8000417c:	17c080e7          	jalr	380(ra) # 800002f4 <strlen>
    80004180:	0015079b          	addw	a5,a0,1
    80004184:	40f907b3          	sub	a5,s2,a5
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    80004188:	ff07f913          	and	s2,a5,-16
    if(sp < stackbase)
    8000418c:	13796263          	bltu	s2,s7,800042b0 <exec+0x380>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80004190:	e0043d03          	ld	s10,-512(s0)
    80004194:	000d3a03          	ld	s4,0(s10)
    80004198:	8552                	mv	a0,s4
    8000419a:	ffffc097          	auipc	ra,0xffffc
    8000419e:	15a080e7          	jalr	346(ra) # 800002f4 <strlen>
    800041a2:	0015069b          	addw	a3,a0,1
    800041a6:	8652                	mv	a2,s4
    800041a8:	85ca                	mv	a1,s2
    800041aa:	855a                	mv	a0,s6
    800041ac:	ffffd097          	auipc	ra,0xffffd
    800041b0:	95a080e7          	jalr	-1702(ra) # 80000b06 <copyout>
    800041b4:	10054063          	bltz	a0,800042b4 <exec+0x384>
    ustack[argc] = sp;
    800041b8:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    800041bc:	0485                	add	s1,s1,1
    800041be:	008d0793          	add	a5,s10,8
    800041c2:	e0f43023          	sd	a5,-512(s0)
    800041c6:	008d3503          	ld	a0,8(s10)
    800041ca:	c909                	beqz	a0,800041dc <exec+0x2ac>
    if(argc >= MAXARG)
    800041cc:	09a1                	add	s3,s3,8
    800041ce:	fb8995e3          	bne	s3,s8,80004178 <exec+0x248>
  ip = 0;
    800041d2:	4a01                	li	s4,0
    800041d4:	a855                	j	80004288 <exec+0x358>
  sp = sz;
    800041d6:	e0843903          	ld	s2,-504(s0)
  for(argc = 0; argv[argc]; argc++) {
    800041da:	4481                	li	s1,0
  ustack[argc] = 0;
    800041dc:	00349793          	sll	a5,s1,0x3
    800041e0:	f9078793          	add	a5,a5,-112 # ffffffffffffef90 <end+0xffffffff7ffd8d50>
    800041e4:	97a2                	add	a5,a5,s0
    800041e6:	f007b023          	sd	zero,-256(a5)
  sp -= (argc+1) * sizeof(uint64);
    800041ea:	00148693          	add	a3,s1,1
    800041ee:	068e                	sll	a3,a3,0x3
    800041f0:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    800041f4:	ff097913          	and	s2,s2,-16
  sz = sz1;
    800041f8:	e0843983          	ld	s3,-504(s0)
  if(sp < stackbase)
    800041fc:	f57968e3          	bltu	s2,s7,8000414c <exec+0x21c>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    80004200:	e9040613          	add	a2,s0,-368
    80004204:	85ca                	mv	a1,s2
    80004206:	855a                	mv	a0,s6
    80004208:	ffffd097          	auipc	ra,0xffffd
    8000420c:	8fe080e7          	jalr	-1794(ra) # 80000b06 <copyout>
    80004210:	0a054463          	bltz	a0,800042b8 <exec+0x388>
  p->trapframe->a1 = sp;
    80004214:	058ab783          	ld	a5,88(s5) # 1058 <_entry-0x7fffefa8>
    80004218:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    8000421c:	df843783          	ld	a5,-520(s0)
    80004220:	0007c703          	lbu	a4,0(a5)
    80004224:	cf11                	beqz	a4,80004240 <exec+0x310>
    80004226:	0785                	add	a5,a5,1
    if(*s == '/')
    80004228:	02f00693          	li	a3,47
    8000422c:	a039                	j	8000423a <exec+0x30a>
      last = s+1;
    8000422e:	def43c23          	sd	a5,-520(s0)
  for(last=s=path; *s; s++)
    80004232:	0785                	add	a5,a5,1
    80004234:	fff7c703          	lbu	a4,-1(a5)
    80004238:	c701                	beqz	a4,80004240 <exec+0x310>
    if(*s == '/')
    8000423a:	fed71ce3          	bne	a4,a3,80004232 <exec+0x302>
    8000423e:	bfc5                	j	8000422e <exec+0x2fe>
  safestrcpy(p->name, last, sizeof(p->name));
    80004240:	4641                	li	a2,16
    80004242:	df843583          	ld	a1,-520(s0)
    80004246:	158a8513          	add	a0,s5,344
    8000424a:	ffffc097          	auipc	ra,0xffffc
    8000424e:	078080e7          	jalr	120(ra) # 800002c2 <safestrcpy>
  oldpagetable = p->pagetable;
    80004252:	050ab503          	ld	a0,80(s5)
  p->pagetable = pagetable;
    80004256:	056ab823          	sd	s6,80(s5)
  p->sz = sz;
    8000425a:	e0843783          	ld	a5,-504(s0)
    8000425e:	04fab423          	sd	a5,72(s5)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    80004262:	058ab783          	ld	a5,88(s5)
    80004266:	e6843703          	ld	a4,-408(s0)
    8000426a:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    8000426c:	058ab783          	ld	a5,88(s5)
    80004270:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    80004274:	85e6                	mv	a1,s9
    80004276:	ffffd097          	auipc	ra,0xffffd
    8000427a:	d2c080e7          	jalr	-724(ra) # 80000fa2 <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    8000427e:	0004851b          	sext.w	a0,s1
    80004282:	b399                	j	80003fc8 <exec+0x98>
    80004284:	e0943423          	sd	s1,-504(s0)
    proc_freepagetable(pagetable, sz);
    80004288:	e0843583          	ld	a1,-504(s0)
    8000428c:	855a                	mv	a0,s6
    8000428e:	ffffd097          	auipc	ra,0xffffd
    80004292:	d14080e7          	jalr	-748(ra) # 80000fa2 <proc_freepagetable>
  return -1;
    80004296:	557d                	li	a0,-1
  if(ip){
    80004298:	d20a08e3          	beqz	s4,80003fc8 <exec+0x98>
    8000429c:	bb21                	j	80003fb4 <exec+0x84>
    8000429e:	e0943423          	sd	s1,-504(s0)
    800042a2:	b7dd                	j	80004288 <exec+0x358>
    800042a4:	e0943423          	sd	s1,-504(s0)
    800042a8:	b7c5                	j	80004288 <exec+0x358>
    800042aa:	e0943423          	sd	s1,-504(s0)
    800042ae:	bfe9                	j	80004288 <exec+0x358>
  ip = 0;
    800042b0:	4a01                	li	s4,0
    800042b2:	bfd9                	j	80004288 <exec+0x358>
    800042b4:	4a01                	li	s4,0
  if(pagetable)
    800042b6:	bfc9                	j	80004288 <exec+0x358>
  sz = sz1;
    800042b8:	e0843983          	ld	s3,-504(s0)
    800042bc:	bd41                	j	8000414c <exec+0x21c>

00000000800042be <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    800042be:	7179                	add	sp,sp,-48
    800042c0:	f406                	sd	ra,40(sp)
    800042c2:	f022                	sd	s0,32(sp)
    800042c4:	ec26                	sd	s1,24(sp)
    800042c6:	e84a                	sd	s2,16(sp)
    800042c8:	1800                	add	s0,sp,48
    800042ca:	892e                	mv	s2,a1
    800042cc:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    800042ce:	fdc40593          	add	a1,s0,-36
    800042d2:	ffffe097          	auipc	ra,0xffffe
    800042d6:	c2a080e7          	jalr	-982(ra) # 80001efc <argint>
    800042da:	04054063          	bltz	a0,8000431a <argfd+0x5c>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    800042de:	fdc42703          	lw	a4,-36(s0)
    800042e2:	47bd                	li	a5,15
    800042e4:	02e7ed63          	bltu	a5,a4,8000431e <argfd+0x60>
    800042e8:	ffffd097          	auipc	ra,0xffffd
    800042ec:	b5a080e7          	jalr	-1190(ra) # 80000e42 <myproc>
    800042f0:	fdc42703          	lw	a4,-36(s0)
    800042f4:	01a70793          	add	a5,a4,26
    800042f8:	078e                	sll	a5,a5,0x3
    800042fa:	953e                	add	a0,a0,a5
    800042fc:	611c                	ld	a5,0(a0)
    800042fe:	c395                	beqz	a5,80004322 <argfd+0x64>
    return -1;
  if(pfd)
    80004300:	00090463          	beqz	s2,80004308 <argfd+0x4a>
    *pfd = fd;
    80004304:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    80004308:	4501                	li	a0,0
  if(pf)
    8000430a:	c091                	beqz	s1,8000430e <argfd+0x50>
    *pf = f;
    8000430c:	e09c                	sd	a5,0(s1)
}
    8000430e:	70a2                	ld	ra,40(sp)
    80004310:	7402                	ld	s0,32(sp)
    80004312:	64e2                	ld	s1,24(sp)
    80004314:	6942                	ld	s2,16(sp)
    80004316:	6145                	add	sp,sp,48
    80004318:	8082                	ret
    return -1;
    8000431a:	557d                	li	a0,-1
    8000431c:	bfcd                	j	8000430e <argfd+0x50>
    return -1;
    8000431e:	557d                	li	a0,-1
    80004320:	b7fd                	j	8000430e <argfd+0x50>
    80004322:	557d                	li	a0,-1
    80004324:	b7ed                	j	8000430e <argfd+0x50>

0000000080004326 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    80004326:	1101                	add	sp,sp,-32
    80004328:	ec06                	sd	ra,24(sp)
    8000432a:	e822                	sd	s0,16(sp)
    8000432c:	e426                	sd	s1,8(sp)
    8000432e:	1000                	add	s0,sp,32
    80004330:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    80004332:	ffffd097          	auipc	ra,0xffffd
    80004336:	b10080e7          	jalr	-1264(ra) # 80000e42 <myproc>
    8000433a:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    8000433c:	0d050793          	add	a5,a0,208
    80004340:	4501                	li	a0,0
    80004342:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    80004344:	6398                	ld	a4,0(a5)
    80004346:	cb19                	beqz	a4,8000435c <fdalloc+0x36>
  for(fd = 0; fd < NOFILE; fd++){
    80004348:	2505                	addw	a0,a0,1
    8000434a:	07a1                	add	a5,a5,8
    8000434c:	fed51ce3          	bne	a0,a3,80004344 <fdalloc+0x1e>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    80004350:	557d                	li	a0,-1
}
    80004352:	60e2                	ld	ra,24(sp)
    80004354:	6442                	ld	s0,16(sp)
    80004356:	64a2                	ld	s1,8(sp)
    80004358:	6105                	add	sp,sp,32
    8000435a:	8082                	ret
      p->ofile[fd] = f;
    8000435c:	01a50793          	add	a5,a0,26
    80004360:	078e                	sll	a5,a5,0x3
    80004362:	963e                	add	a2,a2,a5
    80004364:	e204                	sd	s1,0(a2)
      return fd;
    80004366:	b7f5                	j	80004352 <fdalloc+0x2c>

0000000080004368 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    80004368:	715d                	add	sp,sp,-80
    8000436a:	e486                	sd	ra,72(sp)
    8000436c:	e0a2                	sd	s0,64(sp)
    8000436e:	fc26                	sd	s1,56(sp)
    80004370:	f84a                	sd	s2,48(sp)
    80004372:	f44e                	sd	s3,40(sp)
    80004374:	f052                	sd	s4,32(sp)
    80004376:	ec56                	sd	s5,24(sp)
    80004378:	0880                	add	s0,sp,80
    8000437a:	8aae                	mv	s5,a1
    8000437c:	8a32                	mv	s4,a2
    8000437e:	89b6                	mv	s3,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    80004380:	fb040593          	add	a1,s0,-80
    80004384:	fffff097          	auipc	ra,0xfffff
    80004388:	eb6080e7          	jalr	-330(ra) # 8000323a <nameiparent>
    8000438c:	892a                	mv	s2,a0
    8000438e:	12050c63          	beqz	a0,800044c6 <create+0x15e>
    return 0;

  ilock(dp);
    80004392:	ffffe097          	auipc	ra,0xffffe
    80004396:	6d4080e7          	jalr	1748(ra) # 80002a66 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    8000439a:	4601                	li	a2,0
    8000439c:	fb040593          	add	a1,s0,-80
    800043a0:	854a                	mv	a0,s2
    800043a2:	fffff097          	auipc	ra,0xfffff
    800043a6:	ba8080e7          	jalr	-1112(ra) # 80002f4a <dirlookup>
    800043aa:	84aa                	mv	s1,a0
    800043ac:	c539                	beqz	a0,800043fa <create+0x92>
    iunlockput(dp);
    800043ae:	854a                	mv	a0,s2
    800043b0:	fffff097          	auipc	ra,0xfffff
    800043b4:	918080e7          	jalr	-1768(ra) # 80002cc8 <iunlockput>
    ilock(ip);
    800043b8:	8526                	mv	a0,s1
    800043ba:	ffffe097          	auipc	ra,0xffffe
    800043be:	6ac080e7          	jalr	1708(ra) # 80002a66 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    800043c2:	4789                	li	a5,2
    800043c4:	02fa9463          	bne	s5,a5,800043ec <create+0x84>
    800043c8:	0444d783          	lhu	a5,68(s1)
    800043cc:	37f9                	addw	a5,a5,-2
    800043ce:	17c2                	sll	a5,a5,0x30
    800043d0:	93c1                	srl	a5,a5,0x30
    800043d2:	4705                	li	a4,1
    800043d4:	00f76c63          	bltu	a4,a5,800043ec <create+0x84>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
    800043d8:	8526                	mv	a0,s1
    800043da:	60a6                	ld	ra,72(sp)
    800043dc:	6406                	ld	s0,64(sp)
    800043de:	74e2                	ld	s1,56(sp)
    800043e0:	7942                	ld	s2,48(sp)
    800043e2:	79a2                	ld	s3,40(sp)
    800043e4:	7a02                	ld	s4,32(sp)
    800043e6:	6ae2                	ld	s5,24(sp)
    800043e8:	6161                	add	sp,sp,80
    800043ea:	8082                	ret
    iunlockput(ip);
    800043ec:	8526                	mv	a0,s1
    800043ee:	fffff097          	auipc	ra,0xfffff
    800043f2:	8da080e7          	jalr	-1830(ra) # 80002cc8 <iunlockput>
    return 0;
    800043f6:	4481                	li	s1,0
    800043f8:	b7c5                	j	800043d8 <create+0x70>
  if((ip = ialloc(dp->dev, type)) == 0)
    800043fa:	85d6                	mv	a1,s5
    800043fc:	00092503          	lw	a0,0(s2)
    80004400:	ffffe097          	auipc	ra,0xffffe
    80004404:	4d2080e7          	jalr	1234(ra) # 800028d2 <ialloc>
    80004408:	84aa                	mv	s1,a0
    8000440a:	c139                	beqz	a0,80004450 <create+0xe8>
  ilock(ip);
    8000440c:	ffffe097          	auipc	ra,0xffffe
    80004410:	65a080e7          	jalr	1626(ra) # 80002a66 <ilock>
  ip->major = major;
    80004414:	05449323          	sh	s4,70(s1)
  ip->minor = minor;
    80004418:	05349423          	sh	s3,72(s1)
  ip->nlink = 1;
    8000441c:	4985                	li	s3,1
    8000441e:	05349523          	sh	s3,74(s1)
  iupdate(ip);
    80004422:	8526                	mv	a0,s1
    80004424:	ffffe097          	auipc	ra,0xffffe
    80004428:	576080e7          	jalr	1398(ra) # 8000299a <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    8000442c:	033a8a63          	beq	s5,s3,80004460 <create+0xf8>
  if(dirlink(dp, name, ip->inum) < 0)
    80004430:	40d0                	lw	a2,4(s1)
    80004432:	fb040593          	add	a1,s0,-80
    80004436:	854a                	mv	a0,s2
    80004438:	fffff097          	auipc	ra,0xfffff
    8000443c:	d22080e7          	jalr	-734(ra) # 8000315a <dirlink>
    80004440:	06054b63          	bltz	a0,800044b6 <create+0x14e>
  iunlockput(dp);
    80004444:	854a                	mv	a0,s2
    80004446:	fffff097          	auipc	ra,0xfffff
    8000444a:	882080e7          	jalr	-1918(ra) # 80002cc8 <iunlockput>
  return ip;
    8000444e:	b769                	j	800043d8 <create+0x70>
    panic("create: ialloc");
    80004450:	00004517          	auipc	a0,0x4
    80004454:	21850513          	add	a0,a0,536 # 80008668 <syscalls+0x2a0>
    80004458:	00001097          	auipc	ra,0x1
    8000445c:	622080e7          	jalr	1570(ra) # 80005a7a <panic>
    dp->nlink++;  // for ".."
    80004460:	04a95783          	lhu	a5,74(s2)
    80004464:	2785                	addw	a5,a5,1
    80004466:	04f91523          	sh	a5,74(s2)
    iupdate(dp);
    8000446a:	854a                	mv	a0,s2
    8000446c:	ffffe097          	auipc	ra,0xffffe
    80004470:	52e080e7          	jalr	1326(ra) # 8000299a <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80004474:	40d0                	lw	a2,4(s1)
    80004476:	00004597          	auipc	a1,0x4
    8000447a:	20258593          	add	a1,a1,514 # 80008678 <syscalls+0x2b0>
    8000447e:	8526                	mv	a0,s1
    80004480:	fffff097          	auipc	ra,0xfffff
    80004484:	cda080e7          	jalr	-806(ra) # 8000315a <dirlink>
    80004488:	00054f63          	bltz	a0,800044a6 <create+0x13e>
    8000448c:	00492603          	lw	a2,4(s2)
    80004490:	00004597          	auipc	a1,0x4
    80004494:	1f058593          	add	a1,a1,496 # 80008680 <syscalls+0x2b8>
    80004498:	8526                	mv	a0,s1
    8000449a:	fffff097          	auipc	ra,0xfffff
    8000449e:	cc0080e7          	jalr	-832(ra) # 8000315a <dirlink>
    800044a2:	f80557e3          	bgez	a0,80004430 <create+0xc8>
      panic("create dots");
    800044a6:	00004517          	auipc	a0,0x4
    800044aa:	1e250513          	add	a0,a0,482 # 80008688 <syscalls+0x2c0>
    800044ae:	00001097          	auipc	ra,0x1
    800044b2:	5cc080e7          	jalr	1484(ra) # 80005a7a <panic>
    panic("create: dirlink");
    800044b6:	00004517          	auipc	a0,0x4
    800044ba:	1e250513          	add	a0,a0,482 # 80008698 <syscalls+0x2d0>
    800044be:	00001097          	auipc	ra,0x1
    800044c2:	5bc080e7          	jalr	1468(ra) # 80005a7a <panic>
    return 0;
    800044c6:	84aa                	mv	s1,a0
    800044c8:	bf01                	j	800043d8 <create+0x70>

00000000800044ca <sys_dup>:
{
    800044ca:	7179                	add	sp,sp,-48
    800044cc:	f406                	sd	ra,40(sp)
    800044ce:	f022                	sd	s0,32(sp)
    800044d0:	ec26                	sd	s1,24(sp)
    800044d2:	e84a                	sd	s2,16(sp)
    800044d4:	1800                	add	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    800044d6:	fd840613          	add	a2,s0,-40
    800044da:	4581                	li	a1,0
    800044dc:	4501                	li	a0,0
    800044de:	00000097          	auipc	ra,0x0
    800044e2:	de0080e7          	jalr	-544(ra) # 800042be <argfd>
    return -1;
    800044e6:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    800044e8:	02054363          	bltz	a0,8000450e <sys_dup+0x44>
  if((fd=fdalloc(f)) < 0)
    800044ec:	fd843903          	ld	s2,-40(s0)
    800044f0:	854a                	mv	a0,s2
    800044f2:	00000097          	auipc	ra,0x0
    800044f6:	e34080e7          	jalr	-460(ra) # 80004326 <fdalloc>
    800044fa:	84aa                	mv	s1,a0
    return -1;
    800044fc:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    800044fe:	00054863          	bltz	a0,8000450e <sys_dup+0x44>
  filedup(f);
    80004502:	854a                	mv	a0,s2
    80004504:	fffff097          	auipc	ra,0xfffff
    80004508:	38a080e7          	jalr	906(ra) # 8000388e <filedup>
  return fd;
    8000450c:	87a6                	mv	a5,s1
}
    8000450e:	853e                	mv	a0,a5
    80004510:	70a2                	ld	ra,40(sp)
    80004512:	7402                	ld	s0,32(sp)
    80004514:	64e2                	ld	s1,24(sp)
    80004516:	6942                	ld	s2,16(sp)
    80004518:	6145                	add	sp,sp,48
    8000451a:	8082                	ret

000000008000451c <sys_read>:
{
    8000451c:	7179                	add	sp,sp,-48
    8000451e:	f406                	sd	ra,40(sp)
    80004520:	f022                	sd	s0,32(sp)
    80004522:	1800                	add	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004524:	fe840613          	add	a2,s0,-24
    80004528:	4581                	li	a1,0
    8000452a:	4501                	li	a0,0
    8000452c:	00000097          	auipc	ra,0x0
    80004530:	d92080e7          	jalr	-622(ra) # 800042be <argfd>
    return -1;
    80004534:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004536:	04054163          	bltz	a0,80004578 <sys_read+0x5c>
    8000453a:	fe440593          	add	a1,s0,-28
    8000453e:	4509                	li	a0,2
    80004540:	ffffe097          	auipc	ra,0xffffe
    80004544:	9bc080e7          	jalr	-1604(ra) # 80001efc <argint>
    return -1;
    80004548:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8000454a:	02054763          	bltz	a0,80004578 <sys_read+0x5c>
    8000454e:	fd840593          	add	a1,s0,-40
    80004552:	4505                	li	a0,1
    80004554:	ffffe097          	auipc	ra,0xffffe
    80004558:	9ca080e7          	jalr	-1590(ra) # 80001f1e <argaddr>
    return -1;
    8000455c:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8000455e:	00054d63          	bltz	a0,80004578 <sys_read+0x5c>
  return fileread(f, p, n);
    80004562:	fe442603          	lw	a2,-28(s0)
    80004566:	fd843583          	ld	a1,-40(s0)
    8000456a:	fe843503          	ld	a0,-24(s0)
    8000456e:	fffff097          	auipc	ra,0xfffff
    80004572:	4ac080e7          	jalr	1196(ra) # 80003a1a <fileread>
    80004576:	87aa                	mv	a5,a0
}
    80004578:	853e                	mv	a0,a5
    8000457a:	70a2                	ld	ra,40(sp)
    8000457c:	7402                	ld	s0,32(sp)
    8000457e:	6145                	add	sp,sp,48
    80004580:	8082                	ret

0000000080004582 <sys_write>:
{
    80004582:	7179                	add	sp,sp,-48
    80004584:	f406                	sd	ra,40(sp)
    80004586:	f022                	sd	s0,32(sp)
    80004588:	1800                	add	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8000458a:	fe840613          	add	a2,s0,-24
    8000458e:	4581                	li	a1,0
    80004590:	4501                	li	a0,0
    80004592:	00000097          	auipc	ra,0x0
    80004596:	d2c080e7          	jalr	-724(ra) # 800042be <argfd>
    return -1;
    8000459a:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8000459c:	04054163          	bltz	a0,800045de <sys_write+0x5c>
    800045a0:	fe440593          	add	a1,s0,-28
    800045a4:	4509                	li	a0,2
    800045a6:	ffffe097          	auipc	ra,0xffffe
    800045aa:	956080e7          	jalr	-1706(ra) # 80001efc <argint>
    return -1;
    800045ae:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800045b0:	02054763          	bltz	a0,800045de <sys_write+0x5c>
    800045b4:	fd840593          	add	a1,s0,-40
    800045b8:	4505                	li	a0,1
    800045ba:	ffffe097          	auipc	ra,0xffffe
    800045be:	964080e7          	jalr	-1692(ra) # 80001f1e <argaddr>
    return -1;
    800045c2:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800045c4:	00054d63          	bltz	a0,800045de <sys_write+0x5c>
  return filewrite(f, p, n);
    800045c8:	fe442603          	lw	a2,-28(s0)
    800045cc:	fd843583          	ld	a1,-40(s0)
    800045d0:	fe843503          	ld	a0,-24(s0)
    800045d4:	fffff097          	auipc	ra,0xfffff
    800045d8:	508080e7          	jalr	1288(ra) # 80003adc <filewrite>
    800045dc:	87aa                	mv	a5,a0
}
    800045de:	853e                	mv	a0,a5
    800045e0:	70a2                	ld	ra,40(sp)
    800045e2:	7402                	ld	s0,32(sp)
    800045e4:	6145                	add	sp,sp,48
    800045e6:	8082                	ret

00000000800045e8 <sys_close>:
{
    800045e8:	1101                	add	sp,sp,-32
    800045ea:	ec06                	sd	ra,24(sp)
    800045ec:	e822                	sd	s0,16(sp)
    800045ee:	1000                	add	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    800045f0:	fe040613          	add	a2,s0,-32
    800045f4:	fec40593          	add	a1,s0,-20
    800045f8:	4501                	li	a0,0
    800045fa:	00000097          	auipc	ra,0x0
    800045fe:	cc4080e7          	jalr	-828(ra) # 800042be <argfd>
    return -1;
    80004602:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    80004604:	02054463          	bltz	a0,8000462c <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    80004608:	ffffd097          	auipc	ra,0xffffd
    8000460c:	83a080e7          	jalr	-1990(ra) # 80000e42 <myproc>
    80004610:	fec42783          	lw	a5,-20(s0)
    80004614:	07e9                	add	a5,a5,26
    80004616:	078e                	sll	a5,a5,0x3
    80004618:	953e                	add	a0,a0,a5
    8000461a:	00053023          	sd	zero,0(a0)
  fileclose(f);
    8000461e:	fe043503          	ld	a0,-32(s0)
    80004622:	fffff097          	auipc	ra,0xfffff
    80004626:	2be080e7          	jalr	702(ra) # 800038e0 <fileclose>
  return 0;
    8000462a:	4781                	li	a5,0
}
    8000462c:	853e                	mv	a0,a5
    8000462e:	60e2                	ld	ra,24(sp)
    80004630:	6442                	ld	s0,16(sp)
    80004632:	6105                	add	sp,sp,32
    80004634:	8082                	ret

0000000080004636 <sys_fstat>:
{
    80004636:	1101                	add	sp,sp,-32
    80004638:	ec06                	sd	ra,24(sp)
    8000463a:	e822                	sd	s0,16(sp)
    8000463c:	1000                	add	s0,sp,32
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    8000463e:	fe840613          	add	a2,s0,-24
    80004642:	4581                	li	a1,0
    80004644:	4501                	li	a0,0
    80004646:	00000097          	auipc	ra,0x0
    8000464a:	c78080e7          	jalr	-904(ra) # 800042be <argfd>
    return -1;
    8000464e:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80004650:	02054563          	bltz	a0,8000467a <sys_fstat+0x44>
    80004654:	fe040593          	add	a1,s0,-32
    80004658:	4505                	li	a0,1
    8000465a:	ffffe097          	auipc	ra,0xffffe
    8000465e:	8c4080e7          	jalr	-1852(ra) # 80001f1e <argaddr>
    return -1;
    80004662:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80004664:	00054b63          	bltz	a0,8000467a <sys_fstat+0x44>
  return filestat(f, st);
    80004668:	fe043583          	ld	a1,-32(s0)
    8000466c:	fe843503          	ld	a0,-24(s0)
    80004670:	fffff097          	auipc	ra,0xfffff
    80004674:	338080e7          	jalr	824(ra) # 800039a8 <filestat>
    80004678:	87aa                	mv	a5,a0
}
    8000467a:	853e                	mv	a0,a5
    8000467c:	60e2                	ld	ra,24(sp)
    8000467e:	6442                	ld	s0,16(sp)
    80004680:	6105                	add	sp,sp,32
    80004682:	8082                	ret

0000000080004684 <sys_link>:
{
    80004684:	7169                	add	sp,sp,-304
    80004686:	f606                	sd	ra,296(sp)
    80004688:	f222                	sd	s0,288(sp)
    8000468a:	ee26                	sd	s1,280(sp)
    8000468c:	ea4a                	sd	s2,272(sp)
    8000468e:	1a00                	add	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004690:	08000613          	li	a2,128
    80004694:	ed040593          	add	a1,s0,-304
    80004698:	4501                	li	a0,0
    8000469a:	ffffe097          	auipc	ra,0xffffe
    8000469e:	8a6080e7          	jalr	-1882(ra) # 80001f40 <argstr>
    return -1;
    800046a2:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800046a4:	10054e63          	bltz	a0,800047c0 <sys_link+0x13c>
    800046a8:	08000613          	li	a2,128
    800046ac:	f5040593          	add	a1,s0,-176
    800046b0:	4505                	li	a0,1
    800046b2:	ffffe097          	auipc	ra,0xffffe
    800046b6:	88e080e7          	jalr	-1906(ra) # 80001f40 <argstr>
    return -1;
    800046ba:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800046bc:	10054263          	bltz	a0,800047c0 <sys_link+0x13c>
  begin_op();
    800046c0:	fffff097          	auipc	ra,0xfffff
    800046c4:	d5c080e7          	jalr	-676(ra) # 8000341c <begin_op>
  if((ip = namei(old)) == 0){
    800046c8:	ed040513          	add	a0,s0,-304
    800046cc:	fffff097          	auipc	ra,0xfffff
    800046d0:	b50080e7          	jalr	-1200(ra) # 8000321c <namei>
    800046d4:	84aa                	mv	s1,a0
    800046d6:	c551                	beqz	a0,80004762 <sys_link+0xde>
  ilock(ip);
    800046d8:	ffffe097          	auipc	ra,0xffffe
    800046dc:	38e080e7          	jalr	910(ra) # 80002a66 <ilock>
  if(ip->type == T_DIR){
    800046e0:	04449703          	lh	a4,68(s1)
    800046e4:	4785                	li	a5,1
    800046e6:	08f70463          	beq	a4,a5,8000476e <sys_link+0xea>
  ip->nlink++;
    800046ea:	04a4d783          	lhu	a5,74(s1)
    800046ee:	2785                	addw	a5,a5,1
    800046f0:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    800046f4:	8526                	mv	a0,s1
    800046f6:	ffffe097          	auipc	ra,0xffffe
    800046fa:	2a4080e7          	jalr	676(ra) # 8000299a <iupdate>
  iunlock(ip);
    800046fe:	8526                	mv	a0,s1
    80004700:	ffffe097          	auipc	ra,0xffffe
    80004704:	428080e7          	jalr	1064(ra) # 80002b28 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    80004708:	fd040593          	add	a1,s0,-48
    8000470c:	f5040513          	add	a0,s0,-176
    80004710:	fffff097          	auipc	ra,0xfffff
    80004714:	b2a080e7          	jalr	-1238(ra) # 8000323a <nameiparent>
    80004718:	892a                	mv	s2,a0
    8000471a:	c935                	beqz	a0,8000478e <sys_link+0x10a>
  ilock(dp);
    8000471c:	ffffe097          	auipc	ra,0xffffe
    80004720:	34a080e7          	jalr	842(ra) # 80002a66 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    80004724:	00092703          	lw	a4,0(s2)
    80004728:	409c                	lw	a5,0(s1)
    8000472a:	04f71d63          	bne	a4,a5,80004784 <sys_link+0x100>
    8000472e:	40d0                	lw	a2,4(s1)
    80004730:	fd040593          	add	a1,s0,-48
    80004734:	854a                	mv	a0,s2
    80004736:	fffff097          	auipc	ra,0xfffff
    8000473a:	a24080e7          	jalr	-1500(ra) # 8000315a <dirlink>
    8000473e:	04054363          	bltz	a0,80004784 <sys_link+0x100>
  iunlockput(dp);
    80004742:	854a                	mv	a0,s2
    80004744:	ffffe097          	auipc	ra,0xffffe
    80004748:	584080e7          	jalr	1412(ra) # 80002cc8 <iunlockput>
  iput(ip);
    8000474c:	8526                	mv	a0,s1
    8000474e:	ffffe097          	auipc	ra,0xffffe
    80004752:	4d2080e7          	jalr	1234(ra) # 80002c20 <iput>
  end_op();
    80004756:	fffff097          	auipc	ra,0xfffff
    8000475a:	d40080e7          	jalr	-704(ra) # 80003496 <end_op>
  return 0;
    8000475e:	4781                	li	a5,0
    80004760:	a085                	j	800047c0 <sys_link+0x13c>
    end_op();
    80004762:	fffff097          	auipc	ra,0xfffff
    80004766:	d34080e7          	jalr	-716(ra) # 80003496 <end_op>
    return -1;
    8000476a:	57fd                	li	a5,-1
    8000476c:	a891                	j	800047c0 <sys_link+0x13c>
    iunlockput(ip);
    8000476e:	8526                	mv	a0,s1
    80004770:	ffffe097          	auipc	ra,0xffffe
    80004774:	558080e7          	jalr	1368(ra) # 80002cc8 <iunlockput>
    end_op();
    80004778:	fffff097          	auipc	ra,0xfffff
    8000477c:	d1e080e7          	jalr	-738(ra) # 80003496 <end_op>
    return -1;
    80004780:	57fd                	li	a5,-1
    80004782:	a83d                	j	800047c0 <sys_link+0x13c>
    iunlockput(dp);
    80004784:	854a                	mv	a0,s2
    80004786:	ffffe097          	auipc	ra,0xffffe
    8000478a:	542080e7          	jalr	1346(ra) # 80002cc8 <iunlockput>
  ilock(ip);
    8000478e:	8526                	mv	a0,s1
    80004790:	ffffe097          	auipc	ra,0xffffe
    80004794:	2d6080e7          	jalr	726(ra) # 80002a66 <ilock>
  ip->nlink--;
    80004798:	04a4d783          	lhu	a5,74(s1)
    8000479c:	37fd                	addw	a5,a5,-1
    8000479e:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    800047a2:	8526                	mv	a0,s1
    800047a4:	ffffe097          	auipc	ra,0xffffe
    800047a8:	1f6080e7          	jalr	502(ra) # 8000299a <iupdate>
  iunlockput(ip);
    800047ac:	8526                	mv	a0,s1
    800047ae:	ffffe097          	auipc	ra,0xffffe
    800047b2:	51a080e7          	jalr	1306(ra) # 80002cc8 <iunlockput>
  end_op();
    800047b6:	fffff097          	auipc	ra,0xfffff
    800047ba:	ce0080e7          	jalr	-800(ra) # 80003496 <end_op>
  return -1;
    800047be:	57fd                	li	a5,-1
}
    800047c0:	853e                	mv	a0,a5
    800047c2:	70b2                	ld	ra,296(sp)
    800047c4:	7412                	ld	s0,288(sp)
    800047c6:	64f2                	ld	s1,280(sp)
    800047c8:	6952                	ld	s2,272(sp)
    800047ca:	6155                	add	sp,sp,304
    800047cc:	8082                	ret

00000000800047ce <sys_unlink>:
{
    800047ce:	7151                	add	sp,sp,-240
    800047d0:	f586                	sd	ra,232(sp)
    800047d2:	f1a2                	sd	s0,224(sp)
    800047d4:	eda6                	sd	s1,216(sp)
    800047d6:	e9ca                	sd	s2,208(sp)
    800047d8:	e5ce                	sd	s3,200(sp)
    800047da:	1980                	add	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    800047dc:	08000613          	li	a2,128
    800047e0:	f3040593          	add	a1,s0,-208
    800047e4:	4501                	li	a0,0
    800047e6:	ffffd097          	auipc	ra,0xffffd
    800047ea:	75a080e7          	jalr	1882(ra) # 80001f40 <argstr>
    800047ee:	18054163          	bltz	a0,80004970 <sys_unlink+0x1a2>
  begin_op();
    800047f2:	fffff097          	auipc	ra,0xfffff
    800047f6:	c2a080e7          	jalr	-982(ra) # 8000341c <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    800047fa:	fb040593          	add	a1,s0,-80
    800047fe:	f3040513          	add	a0,s0,-208
    80004802:	fffff097          	auipc	ra,0xfffff
    80004806:	a38080e7          	jalr	-1480(ra) # 8000323a <nameiparent>
    8000480a:	84aa                	mv	s1,a0
    8000480c:	c979                	beqz	a0,800048e2 <sys_unlink+0x114>
  ilock(dp);
    8000480e:	ffffe097          	auipc	ra,0xffffe
    80004812:	258080e7          	jalr	600(ra) # 80002a66 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    80004816:	00004597          	auipc	a1,0x4
    8000481a:	e6258593          	add	a1,a1,-414 # 80008678 <syscalls+0x2b0>
    8000481e:	fb040513          	add	a0,s0,-80
    80004822:	ffffe097          	auipc	ra,0xffffe
    80004826:	70e080e7          	jalr	1806(ra) # 80002f30 <namecmp>
    8000482a:	14050a63          	beqz	a0,8000497e <sys_unlink+0x1b0>
    8000482e:	00004597          	auipc	a1,0x4
    80004832:	e5258593          	add	a1,a1,-430 # 80008680 <syscalls+0x2b8>
    80004836:	fb040513          	add	a0,s0,-80
    8000483a:	ffffe097          	auipc	ra,0xffffe
    8000483e:	6f6080e7          	jalr	1782(ra) # 80002f30 <namecmp>
    80004842:	12050e63          	beqz	a0,8000497e <sys_unlink+0x1b0>
  if((ip = dirlookup(dp, name, &off)) == 0)
    80004846:	f2c40613          	add	a2,s0,-212
    8000484a:	fb040593          	add	a1,s0,-80
    8000484e:	8526                	mv	a0,s1
    80004850:	ffffe097          	auipc	ra,0xffffe
    80004854:	6fa080e7          	jalr	1786(ra) # 80002f4a <dirlookup>
    80004858:	892a                	mv	s2,a0
    8000485a:	12050263          	beqz	a0,8000497e <sys_unlink+0x1b0>
  ilock(ip);
    8000485e:	ffffe097          	auipc	ra,0xffffe
    80004862:	208080e7          	jalr	520(ra) # 80002a66 <ilock>
  if(ip->nlink < 1)
    80004866:	04a91783          	lh	a5,74(s2)
    8000486a:	08f05263          	blez	a5,800048ee <sys_unlink+0x120>
  if(ip->type == T_DIR && !isdirempty(ip)){
    8000486e:	04491703          	lh	a4,68(s2)
    80004872:	4785                	li	a5,1
    80004874:	08f70563          	beq	a4,a5,800048fe <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
    80004878:	4641                	li	a2,16
    8000487a:	4581                	li	a1,0
    8000487c:	fc040513          	add	a0,s0,-64
    80004880:	ffffc097          	auipc	ra,0xffffc
    80004884:	8fa080e7          	jalr	-1798(ra) # 8000017a <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004888:	4741                	li	a4,16
    8000488a:	f2c42683          	lw	a3,-212(s0)
    8000488e:	fc040613          	add	a2,s0,-64
    80004892:	4581                	li	a1,0
    80004894:	8526                	mv	a0,s1
    80004896:	ffffe097          	auipc	ra,0xffffe
    8000489a:	57c080e7          	jalr	1404(ra) # 80002e12 <writei>
    8000489e:	47c1                	li	a5,16
    800048a0:	0af51563          	bne	a0,a5,8000494a <sys_unlink+0x17c>
  if(ip->type == T_DIR){
    800048a4:	04491703          	lh	a4,68(s2)
    800048a8:	4785                	li	a5,1
    800048aa:	0af70863          	beq	a4,a5,8000495a <sys_unlink+0x18c>
  iunlockput(dp);
    800048ae:	8526                	mv	a0,s1
    800048b0:	ffffe097          	auipc	ra,0xffffe
    800048b4:	418080e7          	jalr	1048(ra) # 80002cc8 <iunlockput>
  ip->nlink--;
    800048b8:	04a95783          	lhu	a5,74(s2)
    800048bc:	37fd                	addw	a5,a5,-1
    800048be:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    800048c2:	854a                	mv	a0,s2
    800048c4:	ffffe097          	auipc	ra,0xffffe
    800048c8:	0d6080e7          	jalr	214(ra) # 8000299a <iupdate>
  iunlockput(ip);
    800048cc:	854a                	mv	a0,s2
    800048ce:	ffffe097          	auipc	ra,0xffffe
    800048d2:	3fa080e7          	jalr	1018(ra) # 80002cc8 <iunlockput>
  end_op();
    800048d6:	fffff097          	auipc	ra,0xfffff
    800048da:	bc0080e7          	jalr	-1088(ra) # 80003496 <end_op>
  return 0;
    800048de:	4501                	li	a0,0
    800048e0:	a84d                	j	80004992 <sys_unlink+0x1c4>
    end_op();
    800048e2:	fffff097          	auipc	ra,0xfffff
    800048e6:	bb4080e7          	jalr	-1100(ra) # 80003496 <end_op>
    return -1;
    800048ea:	557d                	li	a0,-1
    800048ec:	a05d                	j	80004992 <sys_unlink+0x1c4>
    panic("unlink: nlink < 1");
    800048ee:	00004517          	auipc	a0,0x4
    800048f2:	dba50513          	add	a0,a0,-582 # 800086a8 <syscalls+0x2e0>
    800048f6:	00001097          	auipc	ra,0x1
    800048fa:	184080e7          	jalr	388(ra) # 80005a7a <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    800048fe:	04c92703          	lw	a4,76(s2)
    80004902:	02000793          	li	a5,32
    80004906:	f6e7f9e3          	bgeu	a5,a4,80004878 <sys_unlink+0xaa>
    8000490a:	02000993          	li	s3,32
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000490e:	4741                	li	a4,16
    80004910:	86ce                	mv	a3,s3
    80004912:	f1840613          	add	a2,s0,-232
    80004916:	4581                	li	a1,0
    80004918:	854a                	mv	a0,s2
    8000491a:	ffffe097          	auipc	ra,0xffffe
    8000491e:	400080e7          	jalr	1024(ra) # 80002d1a <readi>
    80004922:	47c1                	li	a5,16
    80004924:	00f51b63          	bne	a0,a5,8000493a <sys_unlink+0x16c>
    if(de.inum != 0)
    80004928:	f1845783          	lhu	a5,-232(s0)
    8000492c:	e7a1                	bnez	a5,80004974 <sys_unlink+0x1a6>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    8000492e:	29c1                	addw	s3,s3,16
    80004930:	04c92783          	lw	a5,76(s2)
    80004934:	fcf9ede3          	bltu	s3,a5,8000490e <sys_unlink+0x140>
    80004938:	b781                	j	80004878 <sys_unlink+0xaa>
      panic("isdirempty: readi");
    8000493a:	00004517          	auipc	a0,0x4
    8000493e:	d8650513          	add	a0,a0,-634 # 800086c0 <syscalls+0x2f8>
    80004942:	00001097          	auipc	ra,0x1
    80004946:	138080e7          	jalr	312(ra) # 80005a7a <panic>
    panic("unlink: writei");
    8000494a:	00004517          	auipc	a0,0x4
    8000494e:	d8e50513          	add	a0,a0,-626 # 800086d8 <syscalls+0x310>
    80004952:	00001097          	auipc	ra,0x1
    80004956:	128080e7          	jalr	296(ra) # 80005a7a <panic>
    dp->nlink--;
    8000495a:	04a4d783          	lhu	a5,74(s1)
    8000495e:	37fd                	addw	a5,a5,-1
    80004960:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80004964:	8526                	mv	a0,s1
    80004966:	ffffe097          	auipc	ra,0xffffe
    8000496a:	034080e7          	jalr	52(ra) # 8000299a <iupdate>
    8000496e:	b781                	j	800048ae <sys_unlink+0xe0>
    return -1;
    80004970:	557d                	li	a0,-1
    80004972:	a005                	j	80004992 <sys_unlink+0x1c4>
    iunlockput(ip);
    80004974:	854a                	mv	a0,s2
    80004976:	ffffe097          	auipc	ra,0xffffe
    8000497a:	352080e7          	jalr	850(ra) # 80002cc8 <iunlockput>
  iunlockput(dp);
    8000497e:	8526                	mv	a0,s1
    80004980:	ffffe097          	auipc	ra,0xffffe
    80004984:	348080e7          	jalr	840(ra) # 80002cc8 <iunlockput>
  end_op();
    80004988:	fffff097          	auipc	ra,0xfffff
    8000498c:	b0e080e7          	jalr	-1266(ra) # 80003496 <end_op>
  return -1;
    80004990:	557d                	li	a0,-1
}
    80004992:	70ae                	ld	ra,232(sp)
    80004994:	740e                	ld	s0,224(sp)
    80004996:	64ee                	ld	s1,216(sp)
    80004998:	694e                	ld	s2,208(sp)
    8000499a:	69ae                	ld	s3,200(sp)
    8000499c:	616d                	add	sp,sp,240
    8000499e:	8082                	ret

00000000800049a0 <sys_open>:

uint64
sys_open(void)
{
    800049a0:	7131                	add	sp,sp,-192
    800049a2:	fd06                	sd	ra,184(sp)
    800049a4:	f922                	sd	s0,176(sp)
    800049a6:	f526                	sd	s1,168(sp)
    800049a8:	f14a                	sd	s2,160(sp)
    800049aa:	ed4e                	sd	s3,152(sp)
    800049ac:	0180                	add	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    800049ae:	08000613          	li	a2,128
    800049b2:	f5040593          	add	a1,s0,-176
    800049b6:	4501                	li	a0,0
    800049b8:	ffffd097          	auipc	ra,0xffffd
    800049bc:	588080e7          	jalr	1416(ra) # 80001f40 <argstr>
    return -1;
    800049c0:	54fd                	li	s1,-1
  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    800049c2:	0c054063          	bltz	a0,80004a82 <sys_open+0xe2>
    800049c6:	f4c40593          	add	a1,s0,-180
    800049ca:	4505                	li	a0,1
    800049cc:	ffffd097          	auipc	ra,0xffffd
    800049d0:	530080e7          	jalr	1328(ra) # 80001efc <argint>
    800049d4:	0a054763          	bltz	a0,80004a82 <sys_open+0xe2>

  begin_op();
    800049d8:	fffff097          	auipc	ra,0xfffff
    800049dc:	a44080e7          	jalr	-1468(ra) # 8000341c <begin_op>

  if(omode & O_CREATE){
    800049e0:	f4c42783          	lw	a5,-180(s0)
    800049e4:	2007f793          	and	a5,a5,512
    800049e8:	cbd5                	beqz	a5,80004a9c <sys_open+0xfc>
    ip = create(path, T_FILE, 0, 0);
    800049ea:	4681                	li	a3,0
    800049ec:	4601                	li	a2,0
    800049ee:	4589                	li	a1,2
    800049f0:	f5040513          	add	a0,s0,-176
    800049f4:	00000097          	auipc	ra,0x0
    800049f8:	974080e7          	jalr	-1676(ra) # 80004368 <create>
    800049fc:	892a                	mv	s2,a0
    if(ip == 0){
    800049fe:	c951                	beqz	a0,80004a92 <sys_open+0xf2>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80004a00:	04491703          	lh	a4,68(s2)
    80004a04:	478d                	li	a5,3
    80004a06:	00f71763          	bne	a4,a5,80004a14 <sys_open+0x74>
    80004a0a:	04695703          	lhu	a4,70(s2)
    80004a0e:	47a5                	li	a5,9
    80004a10:	0ce7eb63          	bltu	a5,a4,80004ae6 <sys_open+0x146>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80004a14:	fffff097          	auipc	ra,0xfffff
    80004a18:	e10080e7          	jalr	-496(ra) # 80003824 <filealloc>
    80004a1c:	89aa                	mv	s3,a0
    80004a1e:	c565                	beqz	a0,80004b06 <sys_open+0x166>
    80004a20:	00000097          	auipc	ra,0x0
    80004a24:	906080e7          	jalr	-1786(ra) # 80004326 <fdalloc>
    80004a28:	84aa                	mv	s1,a0
    80004a2a:	0c054963          	bltz	a0,80004afc <sys_open+0x15c>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    80004a2e:	04491703          	lh	a4,68(s2)
    80004a32:	478d                	li	a5,3
    80004a34:	0ef70463          	beq	a4,a5,80004b1c <sys_open+0x17c>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    80004a38:	4789                	li	a5,2
    80004a3a:	00f9a023          	sw	a5,0(s3)
    f->off = 0;
    80004a3e:	0209a023          	sw	zero,32(s3)
  }
  f->ip = ip;
    80004a42:	0129bc23          	sd	s2,24(s3)
  f->readable = !(omode & O_WRONLY);
    80004a46:	f4c42783          	lw	a5,-180(s0)
    80004a4a:	0017c713          	xor	a4,a5,1
    80004a4e:	8b05                	and	a4,a4,1
    80004a50:	00e98423          	sb	a4,8(s3)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80004a54:	0037f713          	and	a4,a5,3
    80004a58:	00e03733          	snez	a4,a4
    80004a5c:	00e984a3          	sb	a4,9(s3)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80004a60:	4007f793          	and	a5,a5,1024
    80004a64:	c791                	beqz	a5,80004a70 <sys_open+0xd0>
    80004a66:	04491703          	lh	a4,68(s2)
    80004a6a:	4789                	li	a5,2
    80004a6c:	0af70f63          	beq	a4,a5,80004b2a <sys_open+0x18a>
    itrunc(ip);
  }

  iunlock(ip);
    80004a70:	854a                	mv	a0,s2
    80004a72:	ffffe097          	auipc	ra,0xffffe
    80004a76:	0b6080e7          	jalr	182(ra) # 80002b28 <iunlock>
  end_op();
    80004a7a:	fffff097          	auipc	ra,0xfffff
    80004a7e:	a1c080e7          	jalr	-1508(ra) # 80003496 <end_op>

  return fd;
}
    80004a82:	8526                	mv	a0,s1
    80004a84:	70ea                	ld	ra,184(sp)
    80004a86:	744a                	ld	s0,176(sp)
    80004a88:	74aa                	ld	s1,168(sp)
    80004a8a:	790a                	ld	s2,160(sp)
    80004a8c:	69ea                	ld	s3,152(sp)
    80004a8e:	6129                	add	sp,sp,192
    80004a90:	8082                	ret
      end_op();
    80004a92:	fffff097          	auipc	ra,0xfffff
    80004a96:	a04080e7          	jalr	-1532(ra) # 80003496 <end_op>
      return -1;
    80004a9a:	b7e5                	j	80004a82 <sys_open+0xe2>
    if((ip = namei(path)) == 0){
    80004a9c:	f5040513          	add	a0,s0,-176
    80004aa0:	ffffe097          	auipc	ra,0xffffe
    80004aa4:	77c080e7          	jalr	1916(ra) # 8000321c <namei>
    80004aa8:	892a                	mv	s2,a0
    80004aaa:	c905                	beqz	a0,80004ada <sys_open+0x13a>
    ilock(ip);
    80004aac:	ffffe097          	auipc	ra,0xffffe
    80004ab0:	fba080e7          	jalr	-70(ra) # 80002a66 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    80004ab4:	04491703          	lh	a4,68(s2)
    80004ab8:	4785                	li	a5,1
    80004aba:	f4f713e3          	bne	a4,a5,80004a00 <sys_open+0x60>
    80004abe:	f4c42783          	lw	a5,-180(s0)
    80004ac2:	dba9                	beqz	a5,80004a14 <sys_open+0x74>
      iunlockput(ip);
    80004ac4:	854a                	mv	a0,s2
    80004ac6:	ffffe097          	auipc	ra,0xffffe
    80004aca:	202080e7          	jalr	514(ra) # 80002cc8 <iunlockput>
      end_op();
    80004ace:	fffff097          	auipc	ra,0xfffff
    80004ad2:	9c8080e7          	jalr	-1592(ra) # 80003496 <end_op>
      return -1;
    80004ad6:	54fd                	li	s1,-1
    80004ad8:	b76d                	j	80004a82 <sys_open+0xe2>
      end_op();
    80004ada:	fffff097          	auipc	ra,0xfffff
    80004ade:	9bc080e7          	jalr	-1604(ra) # 80003496 <end_op>
      return -1;
    80004ae2:	54fd                	li	s1,-1
    80004ae4:	bf79                	j	80004a82 <sys_open+0xe2>
    iunlockput(ip);
    80004ae6:	854a                	mv	a0,s2
    80004ae8:	ffffe097          	auipc	ra,0xffffe
    80004aec:	1e0080e7          	jalr	480(ra) # 80002cc8 <iunlockput>
    end_op();
    80004af0:	fffff097          	auipc	ra,0xfffff
    80004af4:	9a6080e7          	jalr	-1626(ra) # 80003496 <end_op>
    return -1;
    80004af8:	54fd                	li	s1,-1
    80004afa:	b761                	j	80004a82 <sys_open+0xe2>
      fileclose(f);
    80004afc:	854e                	mv	a0,s3
    80004afe:	fffff097          	auipc	ra,0xfffff
    80004b02:	de2080e7          	jalr	-542(ra) # 800038e0 <fileclose>
    iunlockput(ip);
    80004b06:	854a                	mv	a0,s2
    80004b08:	ffffe097          	auipc	ra,0xffffe
    80004b0c:	1c0080e7          	jalr	448(ra) # 80002cc8 <iunlockput>
    end_op();
    80004b10:	fffff097          	auipc	ra,0xfffff
    80004b14:	986080e7          	jalr	-1658(ra) # 80003496 <end_op>
    return -1;
    80004b18:	54fd                	li	s1,-1
    80004b1a:	b7a5                	j	80004a82 <sys_open+0xe2>
    f->type = FD_DEVICE;
    80004b1c:	00f9a023          	sw	a5,0(s3)
    f->major = ip->major;
    80004b20:	04691783          	lh	a5,70(s2)
    80004b24:	02f99223          	sh	a5,36(s3)
    80004b28:	bf29                	j	80004a42 <sys_open+0xa2>
    itrunc(ip);
    80004b2a:	854a                	mv	a0,s2
    80004b2c:	ffffe097          	auipc	ra,0xffffe
    80004b30:	048080e7          	jalr	72(ra) # 80002b74 <itrunc>
    80004b34:	bf35                	j	80004a70 <sys_open+0xd0>

0000000080004b36 <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80004b36:	7175                	add	sp,sp,-144
    80004b38:	e506                	sd	ra,136(sp)
    80004b3a:	e122                	sd	s0,128(sp)
    80004b3c:	0900                	add	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    80004b3e:	fffff097          	auipc	ra,0xfffff
    80004b42:	8de080e7          	jalr	-1826(ra) # 8000341c <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80004b46:	08000613          	li	a2,128
    80004b4a:	f7040593          	add	a1,s0,-144
    80004b4e:	4501                	li	a0,0
    80004b50:	ffffd097          	auipc	ra,0xffffd
    80004b54:	3f0080e7          	jalr	1008(ra) # 80001f40 <argstr>
    80004b58:	02054963          	bltz	a0,80004b8a <sys_mkdir+0x54>
    80004b5c:	4681                	li	a3,0
    80004b5e:	4601                	li	a2,0
    80004b60:	4585                	li	a1,1
    80004b62:	f7040513          	add	a0,s0,-144
    80004b66:	00000097          	auipc	ra,0x0
    80004b6a:	802080e7          	jalr	-2046(ra) # 80004368 <create>
    80004b6e:	cd11                	beqz	a0,80004b8a <sys_mkdir+0x54>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004b70:	ffffe097          	auipc	ra,0xffffe
    80004b74:	158080e7          	jalr	344(ra) # 80002cc8 <iunlockput>
  end_op();
    80004b78:	fffff097          	auipc	ra,0xfffff
    80004b7c:	91e080e7          	jalr	-1762(ra) # 80003496 <end_op>
  return 0;
    80004b80:	4501                	li	a0,0
}
    80004b82:	60aa                	ld	ra,136(sp)
    80004b84:	640a                	ld	s0,128(sp)
    80004b86:	6149                	add	sp,sp,144
    80004b88:	8082                	ret
    end_op();
    80004b8a:	fffff097          	auipc	ra,0xfffff
    80004b8e:	90c080e7          	jalr	-1780(ra) # 80003496 <end_op>
    return -1;
    80004b92:	557d                	li	a0,-1
    80004b94:	b7fd                	j	80004b82 <sys_mkdir+0x4c>

0000000080004b96 <sys_mknod>:

uint64
sys_mknod(void)
{
    80004b96:	7135                	add	sp,sp,-160
    80004b98:	ed06                	sd	ra,152(sp)
    80004b9a:	e922                	sd	s0,144(sp)
    80004b9c:	1100                	add	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80004b9e:	fffff097          	auipc	ra,0xfffff
    80004ba2:	87e080e7          	jalr	-1922(ra) # 8000341c <begin_op>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004ba6:	08000613          	li	a2,128
    80004baa:	f7040593          	add	a1,s0,-144
    80004bae:	4501                	li	a0,0
    80004bb0:	ffffd097          	auipc	ra,0xffffd
    80004bb4:	390080e7          	jalr	912(ra) # 80001f40 <argstr>
    80004bb8:	04054a63          	bltz	a0,80004c0c <sys_mknod+0x76>
     argint(1, &major) < 0 ||
    80004bbc:	f6c40593          	add	a1,s0,-148
    80004bc0:	4505                	li	a0,1
    80004bc2:	ffffd097          	auipc	ra,0xffffd
    80004bc6:	33a080e7          	jalr	826(ra) # 80001efc <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004bca:	04054163          	bltz	a0,80004c0c <sys_mknod+0x76>
     argint(2, &minor) < 0 ||
    80004bce:	f6840593          	add	a1,s0,-152
    80004bd2:	4509                	li	a0,2
    80004bd4:	ffffd097          	auipc	ra,0xffffd
    80004bd8:	328080e7          	jalr	808(ra) # 80001efc <argint>
     argint(1, &major) < 0 ||
    80004bdc:	02054863          	bltz	a0,80004c0c <sys_mknod+0x76>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80004be0:	f6841683          	lh	a3,-152(s0)
    80004be4:	f6c41603          	lh	a2,-148(s0)
    80004be8:	458d                	li	a1,3
    80004bea:	f7040513          	add	a0,s0,-144
    80004bee:	fffff097          	auipc	ra,0xfffff
    80004bf2:	77a080e7          	jalr	1914(ra) # 80004368 <create>
     argint(2, &minor) < 0 ||
    80004bf6:	c919                	beqz	a0,80004c0c <sys_mknod+0x76>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004bf8:	ffffe097          	auipc	ra,0xffffe
    80004bfc:	0d0080e7          	jalr	208(ra) # 80002cc8 <iunlockput>
  end_op();
    80004c00:	fffff097          	auipc	ra,0xfffff
    80004c04:	896080e7          	jalr	-1898(ra) # 80003496 <end_op>
  return 0;
    80004c08:	4501                	li	a0,0
    80004c0a:	a031                	j	80004c16 <sys_mknod+0x80>
    end_op();
    80004c0c:	fffff097          	auipc	ra,0xfffff
    80004c10:	88a080e7          	jalr	-1910(ra) # 80003496 <end_op>
    return -1;
    80004c14:	557d                	li	a0,-1
}
    80004c16:	60ea                	ld	ra,152(sp)
    80004c18:	644a                	ld	s0,144(sp)
    80004c1a:	610d                	add	sp,sp,160
    80004c1c:	8082                	ret

0000000080004c1e <sys_chdir>:

uint64
sys_chdir(void)
{
    80004c1e:	7135                	add	sp,sp,-160
    80004c20:	ed06                	sd	ra,152(sp)
    80004c22:	e922                	sd	s0,144(sp)
    80004c24:	e526                	sd	s1,136(sp)
    80004c26:	e14a                	sd	s2,128(sp)
    80004c28:	1100                	add	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80004c2a:	ffffc097          	auipc	ra,0xffffc
    80004c2e:	218080e7          	jalr	536(ra) # 80000e42 <myproc>
    80004c32:	892a                	mv	s2,a0
  
  begin_op();
    80004c34:	ffffe097          	auipc	ra,0xffffe
    80004c38:	7e8080e7          	jalr	2024(ra) # 8000341c <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80004c3c:	08000613          	li	a2,128
    80004c40:	f6040593          	add	a1,s0,-160
    80004c44:	4501                	li	a0,0
    80004c46:	ffffd097          	auipc	ra,0xffffd
    80004c4a:	2fa080e7          	jalr	762(ra) # 80001f40 <argstr>
    80004c4e:	04054b63          	bltz	a0,80004ca4 <sys_chdir+0x86>
    80004c52:	f6040513          	add	a0,s0,-160
    80004c56:	ffffe097          	auipc	ra,0xffffe
    80004c5a:	5c6080e7          	jalr	1478(ra) # 8000321c <namei>
    80004c5e:	84aa                	mv	s1,a0
    80004c60:	c131                	beqz	a0,80004ca4 <sys_chdir+0x86>
    end_op();
    return -1;
  }
  ilock(ip);
    80004c62:	ffffe097          	auipc	ra,0xffffe
    80004c66:	e04080e7          	jalr	-508(ra) # 80002a66 <ilock>
  if(ip->type != T_DIR){
    80004c6a:	04449703          	lh	a4,68(s1)
    80004c6e:	4785                	li	a5,1
    80004c70:	04f71063          	bne	a4,a5,80004cb0 <sys_chdir+0x92>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    80004c74:	8526                	mv	a0,s1
    80004c76:	ffffe097          	auipc	ra,0xffffe
    80004c7a:	eb2080e7          	jalr	-334(ra) # 80002b28 <iunlock>
  iput(p->cwd);
    80004c7e:	15093503          	ld	a0,336(s2)
    80004c82:	ffffe097          	auipc	ra,0xffffe
    80004c86:	f9e080e7          	jalr	-98(ra) # 80002c20 <iput>
  end_op();
    80004c8a:	fffff097          	auipc	ra,0xfffff
    80004c8e:	80c080e7          	jalr	-2036(ra) # 80003496 <end_op>
  p->cwd = ip;
    80004c92:	14993823          	sd	s1,336(s2)
  return 0;
    80004c96:	4501                	li	a0,0
}
    80004c98:	60ea                	ld	ra,152(sp)
    80004c9a:	644a                	ld	s0,144(sp)
    80004c9c:	64aa                	ld	s1,136(sp)
    80004c9e:	690a                	ld	s2,128(sp)
    80004ca0:	610d                	add	sp,sp,160
    80004ca2:	8082                	ret
    end_op();
    80004ca4:	ffffe097          	auipc	ra,0xffffe
    80004ca8:	7f2080e7          	jalr	2034(ra) # 80003496 <end_op>
    return -1;
    80004cac:	557d                	li	a0,-1
    80004cae:	b7ed                	j	80004c98 <sys_chdir+0x7a>
    iunlockput(ip);
    80004cb0:	8526                	mv	a0,s1
    80004cb2:	ffffe097          	auipc	ra,0xffffe
    80004cb6:	016080e7          	jalr	22(ra) # 80002cc8 <iunlockput>
    end_op();
    80004cba:	ffffe097          	auipc	ra,0xffffe
    80004cbe:	7dc080e7          	jalr	2012(ra) # 80003496 <end_op>
    return -1;
    80004cc2:	557d                	li	a0,-1
    80004cc4:	bfd1                	j	80004c98 <sys_chdir+0x7a>

0000000080004cc6 <sys_exec>:

uint64
sys_exec(void)
{
    80004cc6:	7121                	add	sp,sp,-448
    80004cc8:	ff06                	sd	ra,440(sp)
    80004cca:	fb22                	sd	s0,432(sp)
    80004ccc:	f726                	sd	s1,424(sp)
    80004cce:	f34a                	sd	s2,416(sp)
    80004cd0:	ef4e                	sd	s3,408(sp)
    80004cd2:	eb52                	sd	s4,400(sp)
    80004cd4:	0380                	add	s0,sp,448
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    80004cd6:	08000613          	li	a2,128
    80004cda:	f5040593          	add	a1,s0,-176
    80004cde:	4501                	li	a0,0
    80004ce0:	ffffd097          	auipc	ra,0xffffd
    80004ce4:	260080e7          	jalr	608(ra) # 80001f40 <argstr>
    return -1;
    80004ce8:	597d                	li	s2,-1
  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    80004cea:	0c054a63          	bltz	a0,80004dbe <sys_exec+0xf8>
    80004cee:	e4840593          	add	a1,s0,-440
    80004cf2:	4505                	li	a0,1
    80004cf4:	ffffd097          	auipc	ra,0xffffd
    80004cf8:	22a080e7          	jalr	554(ra) # 80001f1e <argaddr>
    80004cfc:	0c054163          	bltz	a0,80004dbe <sys_exec+0xf8>
  }
  memset(argv, 0, sizeof(argv));
    80004d00:	10000613          	li	a2,256
    80004d04:	4581                	li	a1,0
    80004d06:	e5040513          	add	a0,s0,-432
    80004d0a:	ffffb097          	auipc	ra,0xffffb
    80004d0e:	470080e7          	jalr	1136(ra) # 8000017a <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    80004d12:	e5040493          	add	s1,s0,-432
  memset(argv, 0, sizeof(argv));
    80004d16:	89a6                	mv	s3,s1
    80004d18:	4901                	li	s2,0
    if(i >= NELEM(argv)){
    80004d1a:	02000a13          	li	s4,32
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80004d1e:	00391513          	sll	a0,s2,0x3
    80004d22:	e4040593          	add	a1,s0,-448
    80004d26:	e4843783          	ld	a5,-440(s0)
    80004d2a:	953e                	add	a0,a0,a5
    80004d2c:	ffffd097          	auipc	ra,0xffffd
    80004d30:	136080e7          	jalr	310(ra) # 80001e62 <fetchaddr>
    80004d34:	02054a63          	bltz	a0,80004d68 <sys_exec+0xa2>
      goto bad;
    }
    if(uarg == 0){
    80004d38:	e4043783          	ld	a5,-448(s0)
    80004d3c:	c3b9                	beqz	a5,80004d82 <sys_exec+0xbc>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    80004d3e:	ffffb097          	auipc	ra,0xffffb
    80004d42:	3dc080e7          	jalr	988(ra) # 8000011a <kalloc>
    80004d46:	85aa                	mv	a1,a0
    80004d48:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    80004d4c:	cd11                	beqz	a0,80004d68 <sys_exec+0xa2>
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    80004d4e:	6605                	lui	a2,0x1
    80004d50:	e4043503          	ld	a0,-448(s0)
    80004d54:	ffffd097          	auipc	ra,0xffffd
    80004d58:	160080e7          	jalr	352(ra) # 80001eb4 <fetchstr>
    80004d5c:	00054663          	bltz	a0,80004d68 <sys_exec+0xa2>
    if(i >= NELEM(argv)){
    80004d60:	0905                	add	s2,s2,1
    80004d62:	09a1                	add	s3,s3,8
    80004d64:	fb491de3          	bne	s2,s4,80004d1e <sys_exec+0x58>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004d68:	f5040913          	add	s2,s0,-176
    80004d6c:	6088                	ld	a0,0(s1)
    80004d6e:	c539                	beqz	a0,80004dbc <sys_exec+0xf6>
    kfree(argv[i]);
    80004d70:	ffffb097          	auipc	ra,0xffffb
    80004d74:	2ac080e7          	jalr	684(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004d78:	04a1                	add	s1,s1,8
    80004d7a:	ff2499e3          	bne	s1,s2,80004d6c <sys_exec+0xa6>
  return -1;
    80004d7e:	597d                	li	s2,-1
    80004d80:	a83d                	j	80004dbe <sys_exec+0xf8>
      argv[i] = 0;
    80004d82:	0009079b          	sext.w	a5,s2
    80004d86:	078e                	sll	a5,a5,0x3
    80004d88:	fd078793          	add	a5,a5,-48
    80004d8c:	97a2                	add	a5,a5,s0
    80004d8e:	e807b023          	sd	zero,-384(a5)
  int ret = exec(path, argv);
    80004d92:	e5040593          	add	a1,s0,-432
    80004d96:	f5040513          	add	a0,s0,-176
    80004d9a:	fffff097          	auipc	ra,0xfffff
    80004d9e:	196080e7          	jalr	406(ra) # 80003f30 <exec>
    80004da2:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004da4:	f5040993          	add	s3,s0,-176
    80004da8:	6088                	ld	a0,0(s1)
    80004daa:	c911                	beqz	a0,80004dbe <sys_exec+0xf8>
    kfree(argv[i]);
    80004dac:	ffffb097          	auipc	ra,0xffffb
    80004db0:	270080e7          	jalr	624(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004db4:	04a1                	add	s1,s1,8
    80004db6:	ff3499e3          	bne	s1,s3,80004da8 <sys_exec+0xe2>
    80004dba:	a011                	j	80004dbe <sys_exec+0xf8>
  return -1;
    80004dbc:	597d                	li	s2,-1
}
    80004dbe:	854a                	mv	a0,s2
    80004dc0:	70fa                	ld	ra,440(sp)
    80004dc2:	745a                	ld	s0,432(sp)
    80004dc4:	74ba                	ld	s1,424(sp)
    80004dc6:	791a                	ld	s2,416(sp)
    80004dc8:	69fa                	ld	s3,408(sp)
    80004dca:	6a5a                	ld	s4,400(sp)
    80004dcc:	6139                	add	sp,sp,448
    80004dce:	8082                	ret

0000000080004dd0 <sys_pipe>:

uint64
sys_pipe(void)
{
    80004dd0:	7139                	add	sp,sp,-64
    80004dd2:	fc06                	sd	ra,56(sp)
    80004dd4:	f822                	sd	s0,48(sp)
    80004dd6:	f426                	sd	s1,40(sp)
    80004dd8:	0080                	add	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    80004dda:	ffffc097          	auipc	ra,0xffffc
    80004dde:	068080e7          	jalr	104(ra) # 80000e42 <myproc>
    80004de2:	84aa                	mv	s1,a0

  if(argaddr(0, &fdarray) < 0)
    80004de4:	fd840593          	add	a1,s0,-40
    80004de8:	4501                	li	a0,0
    80004dea:	ffffd097          	auipc	ra,0xffffd
    80004dee:	134080e7          	jalr	308(ra) # 80001f1e <argaddr>
    return -1;
    80004df2:	57fd                	li	a5,-1
  if(argaddr(0, &fdarray) < 0)
    80004df4:	0e054063          	bltz	a0,80004ed4 <sys_pipe+0x104>
  if(pipealloc(&rf, &wf) < 0)
    80004df8:	fc840593          	add	a1,s0,-56
    80004dfc:	fd040513          	add	a0,s0,-48
    80004e00:	fffff097          	auipc	ra,0xfffff
    80004e04:	e0c080e7          	jalr	-500(ra) # 80003c0c <pipealloc>
    return -1;
    80004e08:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    80004e0a:	0c054563          	bltz	a0,80004ed4 <sys_pipe+0x104>
  fd0 = -1;
    80004e0e:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80004e12:	fd043503          	ld	a0,-48(s0)
    80004e16:	fffff097          	auipc	ra,0xfffff
    80004e1a:	510080e7          	jalr	1296(ra) # 80004326 <fdalloc>
    80004e1e:	fca42223          	sw	a0,-60(s0)
    80004e22:	08054c63          	bltz	a0,80004eba <sys_pipe+0xea>
    80004e26:	fc843503          	ld	a0,-56(s0)
    80004e2a:	fffff097          	auipc	ra,0xfffff
    80004e2e:	4fc080e7          	jalr	1276(ra) # 80004326 <fdalloc>
    80004e32:	fca42023          	sw	a0,-64(s0)
    80004e36:	06054963          	bltz	a0,80004ea8 <sys_pipe+0xd8>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80004e3a:	4691                	li	a3,4
    80004e3c:	fc440613          	add	a2,s0,-60
    80004e40:	fd843583          	ld	a1,-40(s0)
    80004e44:	68a8                	ld	a0,80(s1)
    80004e46:	ffffc097          	auipc	ra,0xffffc
    80004e4a:	cc0080e7          	jalr	-832(ra) # 80000b06 <copyout>
    80004e4e:	02054063          	bltz	a0,80004e6e <sys_pipe+0x9e>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    80004e52:	4691                	li	a3,4
    80004e54:	fc040613          	add	a2,s0,-64
    80004e58:	fd843583          	ld	a1,-40(s0)
    80004e5c:	0591                	add	a1,a1,4
    80004e5e:	68a8                	ld	a0,80(s1)
    80004e60:	ffffc097          	auipc	ra,0xffffc
    80004e64:	ca6080e7          	jalr	-858(ra) # 80000b06 <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    80004e68:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80004e6a:	06055563          	bgez	a0,80004ed4 <sys_pipe+0x104>
    p->ofile[fd0] = 0;
    80004e6e:	fc442783          	lw	a5,-60(s0)
    80004e72:	07e9                	add	a5,a5,26
    80004e74:	078e                	sll	a5,a5,0x3
    80004e76:	97a6                	add	a5,a5,s1
    80004e78:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    80004e7c:	fc042783          	lw	a5,-64(s0)
    80004e80:	07e9                	add	a5,a5,26
    80004e82:	078e                	sll	a5,a5,0x3
    80004e84:	00f48533          	add	a0,s1,a5
    80004e88:	00053023          	sd	zero,0(a0)
    fileclose(rf);
    80004e8c:	fd043503          	ld	a0,-48(s0)
    80004e90:	fffff097          	auipc	ra,0xfffff
    80004e94:	a50080e7          	jalr	-1456(ra) # 800038e0 <fileclose>
    fileclose(wf);
    80004e98:	fc843503          	ld	a0,-56(s0)
    80004e9c:	fffff097          	auipc	ra,0xfffff
    80004ea0:	a44080e7          	jalr	-1468(ra) # 800038e0 <fileclose>
    return -1;
    80004ea4:	57fd                	li	a5,-1
    80004ea6:	a03d                	j	80004ed4 <sys_pipe+0x104>
    if(fd0 >= 0)
    80004ea8:	fc442783          	lw	a5,-60(s0)
    80004eac:	0007c763          	bltz	a5,80004eba <sys_pipe+0xea>
      p->ofile[fd0] = 0;
    80004eb0:	07e9                	add	a5,a5,26
    80004eb2:	078e                	sll	a5,a5,0x3
    80004eb4:	97a6                	add	a5,a5,s1
    80004eb6:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    80004eba:	fd043503          	ld	a0,-48(s0)
    80004ebe:	fffff097          	auipc	ra,0xfffff
    80004ec2:	a22080e7          	jalr	-1502(ra) # 800038e0 <fileclose>
    fileclose(wf);
    80004ec6:	fc843503          	ld	a0,-56(s0)
    80004eca:	fffff097          	auipc	ra,0xfffff
    80004ece:	a16080e7          	jalr	-1514(ra) # 800038e0 <fileclose>
    return -1;
    80004ed2:	57fd                	li	a5,-1
}
    80004ed4:	853e                	mv	a0,a5
    80004ed6:	70e2                	ld	ra,56(sp)
    80004ed8:	7442                	ld	s0,48(sp)
    80004eda:	74a2                	ld	s1,40(sp)
    80004edc:	6121                	add	sp,sp,64
    80004ede:	8082                	ret

0000000080004ee0 <kernelvec>:
    80004ee0:	7111                	add	sp,sp,-256
    80004ee2:	e006                	sd	ra,0(sp)
    80004ee4:	e40a                	sd	sp,8(sp)
    80004ee6:	e80e                	sd	gp,16(sp)
    80004ee8:	ec12                	sd	tp,24(sp)
    80004eea:	f016                	sd	t0,32(sp)
    80004eec:	f41a                	sd	t1,40(sp)
    80004eee:	f81e                	sd	t2,48(sp)
    80004ef0:	fc22                	sd	s0,56(sp)
    80004ef2:	e0a6                	sd	s1,64(sp)
    80004ef4:	e4aa                	sd	a0,72(sp)
    80004ef6:	e8ae                	sd	a1,80(sp)
    80004ef8:	ecb2                	sd	a2,88(sp)
    80004efa:	f0b6                	sd	a3,96(sp)
    80004efc:	f4ba                	sd	a4,104(sp)
    80004efe:	f8be                	sd	a5,112(sp)
    80004f00:	fcc2                	sd	a6,120(sp)
    80004f02:	e146                	sd	a7,128(sp)
    80004f04:	e54a                	sd	s2,136(sp)
    80004f06:	e94e                	sd	s3,144(sp)
    80004f08:	ed52                	sd	s4,152(sp)
    80004f0a:	f156                	sd	s5,160(sp)
    80004f0c:	f55a                	sd	s6,168(sp)
    80004f0e:	f95e                	sd	s7,176(sp)
    80004f10:	fd62                	sd	s8,184(sp)
    80004f12:	e1e6                	sd	s9,192(sp)
    80004f14:	e5ea                	sd	s10,200(sp)
    80004f16:	e9ee                	sd	s11,208(sp)
    80004f18:	edf2                	sd	t3,216(sp)
    80004f1a:	f1f6                	sd	t4,224(sp)
    80004f1c:	f5fa                	sd	t5,232(sp)
    80004f1e:	f9fe                	sd	t6,240(sp)
    80004f20:	e0ffc0ef          	jal	80001d2e <kerneltrap>
    80004f24:	6082                	ld	ra,0(sp)
    80004f26:	6122                	ld	sp,8(sp)
    80004f28:	61c2                	ld	gp,16(sp)
    80004f2a:	7282                	ld	t0,32(sp)
    80004f2c:	7322                	ld	t1,40(sp)
    80004f2e:	73c2                	ld	t2,48(sp)
    80004f30:	7462                	ld	s0,56(sp)
    80004f32:	6486                	ld	s1,64(sp)
    80004f34:	6526                	ld	a0,72(sp)
    80004f36:	65c6                	ld	a1,80(sp)
    80004f38:	6666                	ld	a2,88(sp)
    80004f3a:	7686                	ld	a3,96(sp)
    80004f3c:	7726                	ld	a4,104(sp)
    80004f3e:	77c6                	ld	a5,112(sp)
    80004f40:	7866                	ld	a6,120(sp)
    80004f42:	688a                	ld	a7,128(sp)
    80004f44:	692a                	ld	s2,136(sp)
    80004f46:	69ca                	ld	s3,144(sp)
    80004f48:	6a6a                	ld	s4,152(sp)
    80004f4a:	7a8a                	ld	s5,160(sp)
    80004f4c:	7b2a                	ld	s6,168(sp)
    80004f4e:	7bca                	ld	s7,176(sp)
    80004f50:	7c6a                	ld	s8,184(sp)
    80004f52:	6c8e                	ld	s9,192(sp)
    80004f54:	6d2e                	ld	s10,200(sp)
    80004f56:	6dce                	ld	s11,208(sp)
    80004f58:	6e6e                	ld	t3,216(sp)
    80004f5a:	7e8e                	ld	t4,224(sp)
    80004f5c:	7f2e                	ld	t5,232(sp)
    80004f5e:	7fce                	ld	t6,240(sp)
    80004f60:	6111                	add	sp,sp,256
    80004f62:	10200073          	sret
    80004f66:	00000013          	nop
    80004f6a:	00000013          	nop
    80004f6e:	0001                	nop

0000000080004f70 <timervec>:
    80004f70:	34051573          	csrrw	a0,mscratch,a0
    80004f74:	e10c                	sd	a1,0(a0)
    80004f76:	e510                	sd	a2,8(a0)
    80004f78:	e914                	sd	a3,16(a0)
    80004f7a:	6d0c                	ld	a1,24(a0)
    80004f7c:	7110                	ld	a2,32(a0)
    80004f7e:	6194                	ld	a3,0(a1)
    80004f80:	96b2                	add	a3,a3,a2
    80004f82:	e194                	sd	a3,0(a1)
    80004f84:	4589                	li	a1,2
    80004f86:	14459073          	csrw	sip,a1
    80004f8a:	6914                	ld	a3,16(a0)
    80004f8c:	6510                	ld	a2,8(a0)
    80004f8e:	610c                	ld	a1,0(a0)
    80004f90:	34051573          	csrrw	a0,mscratch,a0
    80004f94:	30200073          	mret
	...

0000000080004f9a <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    80004f9a:	1141                	add	sp,sp,-16
    80004f9c:	e422                	sd	s0,8(sp)
    80004f9e:	0800                	add	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80004fa0:	0c0007b7          	lui	a5,0xc000
    80004fa4:	4705                	li	a4,1
    80004fa6:	d798                	sw	a4,40(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    80004fa8:	c3d8                	sw	a4,4(a5)
}
    80004faa:	6422                	ld	s0,8(sp)
    80004fac:	0141                	add	sp,sp,16
    80004fae:	8082                	ret

0000000080004fb0 <plicinithart>:

void
plicinithart(void)
{
    80004fb0:	1141                	add	sp,sp,-16
    80004fb2:	e406                	sd	ra,8(sp)
    80004fb4:	e022                	sd	s0,0(sp)
    80004fb6:	0800                	add	s0,sp,16
  int hart = cpuid();
    80004fb8:	ffffc097          	auipc	ra,0xffffc
    80004fbc:	e5e080e7          	jalr	-418(ra) # 80000e16 <cpuid>
  
  // set uart's enable bit for this hart's S-mode. 
  *(uint32*)PLIC_SENABLE(hart)= (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80004fc0:	0085171b          	sllw	a4,a0,0x8
    80004fc4:	0c0027b7          	lui	a5,0xc002
    80004fc8:	97ba                	add	a5,a5,a4
    80004fca:	40200713          	li	a4,1026
    80004fce:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80004fd2:	00d5151b          	sllw	a0,a0,0xd
    80004fd6:	0c2017b7          	lui	a5,0xc201
    80004fda:	97aa                	add	a5,a5,a0
    80004fdc:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    80004fe0:	60a2                	ld	ra,8(sp)
    80004fe2:	6402                	ld	s0,0(sp)
    80004fe4:	0141                	add	sp,sp,16
    80004fe6:	8082                	ret

0000000080004fe8 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80004fe8:	1141                	add	sp,sp,-16
    80004fea:	e406                	sd	ra,8(sp)
    80004fec:	e022                	sd	s0,0(sp)
    80004fee:	0800                	add	s0,sp,16
  int hart = cpuid();
    80004ff0:	ffffc097          	auipc	ra,0xffffc
    80004ff4:	e26080e7          	jalr	-474(ra) # 80000e16 <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80004ff8:	00d5151b          	sllw	a0,a0,0xd
    80004ffc:	0c2017b7          	lui	a5,0xc201
    80005000:	97aa                	add	a5,a5,a0
  return irq;
}
    80005002:	43c8                	lw	a0,4(a5)
    80005004:	60a2                	ld	ra,8(sp)
    80005006:	6402                	ld	s0,0(sp)
    80005008:	0141                	add	sp,sp,16
    8000500a:	8082                	ret

000000008000500c <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    8000500c:	1101                	add	sp,sp,-32
    8000500e:	ec06                	sd	ra,24(sp)
    80005010:	e822                	sd	s0,16(sp)
    80005012:	e426                	sd	s1,8(sp)
    80005014:	1000                	add	s0,sp,32
    80005016:	84aa                	mv	s1,a0
  int hart = cpuid();
    80005018:	ffffc097          	auipc	ra,0xffffc
    8000501c:	dfe080e7          	jalr	-514(ra) # 80000e16 <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    80005020:	00d5151b          	sllw	a0,a0,0xd
    80005024:	0c2017b7          	lui	a5,0xc201
    80005028:	97aa                	add	a5,a5,a0
    8000502a:	c3c4                	sw	s1,4(a5)
}
    8000502c:	60e2                	ld	ra,24(sp)
    8000502e:	6442                	ld	s0,16(sp)
    80005030:	64a2                	ld	s1,8(sp)
    80005032:	6105                	add	sp,sp,32
    80005034:	8082                	ret

0000000080005036 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    80005036:	1141                	add	sp,sp,-16
    80005038:	e406                	sd	ra,8(sp)
    8000503a:	e022                	sd	s0,0(sp)
    8000503c:	0800                	add	s0,sp,16
  if(i >= NUM)
    8000503e:	479d                	li	a5,7
    80005040:	06a7c863          	blt	a5,a0,800050b0 <free_desc+0x7a>
    panic("free_desc 1");
  if(disk.free[i])
    80005044:	00016717          	auipc	a4,0x16
    80005048:	fbc70713          	add	a4,a4,-68 # 8001b000 <disk>
    8000504c:	972a                	add	a4,a4,a0
    8000504e:	6789                	lui	a5,0x2
    80005050:	97ba                	add	a5,a5,a4
    80005052:	0187c783          	lbu	a5,24(a5) # 2018 <_entry-0x7fffdfe8>
    80005056:	e7ad                	bnez	a5,800050c0 <free_desc+0x8a>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    80005058:	00451793          	sll	a5,a0,0x4
    8000505c:	00018717          	auipc	a4,0x18
    80005060:	fa470713          	add	a4,a4,-92 # 8001d000 <disk+0x2000>
    80005064:	6314                	ld	a3,0(a4)
    80005066:	96be                	add	a3,a3,a5
    80005068:	0006b023          	sd	zero,0(a3)
  disk.desc[i].len = 0;
    8000506c:	6314                	ld	a3,0(a4)
    8000506e:	96be                	add	a3,a3,a5
    80005070:	0006a423          	sw	zero,8(a3)
  disk.desc[i].flags = 0;
    80005074:	6314                	ld	a3,0(a4)
    80005076:	96be                	add	a3,a3,a5
    80005078:	00069623          	sh	zero,12(a3)
  disk.desc[i].next = 0;
    8000507c:	6318                	ld	a4,0(a4)
    8000507e:	97ba                	add	a5,a5,a4
    80005080:	00079723          	sh	zero,14(a5)
  disk.free[i] = 1;
    80005084:	00016717          	auipc	a4,0x16
    80005088:	f7c70713          	add	a4,a4,-132 # 8001b000 <disk>
    8000508c:	972a                	add	a4,a4,a0
    8000508e:	6789                	lui	a5,0x2
    80005090:	97ba                	add	a5,a5,a4
    80005092:	4705                	li	a4,1
    80005094:	00e78c23          	sb	a4,24(a5) # 2018 <_entry-0x7fffdfe8>
  wakeup(&disk.free[0]);
    80005098:	00018517          	auipc	a0,0x18
    8000509c:	f8050513          	add	a0,a0,-128 # 8001d018 <disk+0x2018>
    800050a0:	ffffc097          	auipc	ra,0xffffc
    800050a4:	5f2080e7          	jalr	1522(ra) # 80001692 <wakeup>
}
    800050a8:	60a2                	ld	ra,8(sp)
    800050aa:	6402                	ld	s0,0(sp)
    800050ac:	0141                	add	sp,sp,16
    800050ae:	8082                	ret
    panic("free_desc 1");
    800050b0:	00003517          	auipc	a0,0x3
    800050b4:	63850513          	add	a0,a0,1592 # 800086e8 <syscalls+0x320>
    800050b8:	00001097          	auipc	ra,0x1
    800050bc:	9c2080e7          	jalr	-1598(ra) # 80005a7a <panic>
    panic("free_desc 2");
    800050c0:	00003517          	auipc	a0,0x3
    800050c4:	63850513          	add	a0,a0,1592 # 800086f8 <syscalls+0x330>
    800050c8:	00001097          	auipc	ra,0x1
    800050cc:	9b2080e7          	jalr	-1614(ra) # 80005a7a <panic>

00000000800050d0 <virtio_disk_init>:
{
    800050d0:	1101                	add	sp,sp,-32
    800050d2:	ec06                	sd	ra,24(sp)
    800050d4:	e822                	sd	s0,16(sp)
    800050d6:	e426                	sd	s1,8(sp)
    800050d8:	1000                	add	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    800050da:	00003597          	auipc	a1,0x3
    800050de:	62e58593          	add	a1,a1,1582 # 80008708 <syscalls+0x340>
    800050e2:	00018517          	auipc	a0,0x18
    800050e6:	04650513          	add	a0,a0,70 # 8001d128 <disk+0x2128>
    800050ea:	00001097          	auipc	ra,0x1
    800050ee:	e38080e7          	jalr	-456(ra) # 80005f22 <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800050f2:	100017b7          	lui	a5,0x10001
    800050f6:	4398                	lw	a4,0(a5)
    800050f8:	2701                	sext.w	a4,a4
    800050fa:	747277b7          	lui	a5,0x74727
    800050fe:	97678793          	add	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    80005102:	0ef71063          	bne	a4,a5,800051e2 <virtio_disk_init+0x112>
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    80005106:	100017b7          	lui	a5,0x10001
    8000510a:	43dc                	lw	a5,4(a5)
    8000510c:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    8000510e:	4705                	li	a4,1
    80005110:	0ce79963          	bne	a5,a4,800051e2 <virtio_disk_init+0x112>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80005114:	100017b7          	lui	a5,0x10001
    80005118:	479c                	lw	a5,8(a5)
    8000511a:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    8000511c:	4709                	li	a4,2
    8000511e:	0ce79263          	bne	a5,a4,800051e2 <virtio_disk_init+0x112>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    80005122:	100017b7          	lui	a5,0x10001
    80005126:	47d8                	lw	a4,12(a5)
    80005128:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    8000512a:	554d47b7          	lui	a5,0x554d4
    8000512e:	55178793          	add	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    80005132:	0af71863          	bne	a4,a5,800051e2 <virtio_disk_init+0x112>
  *R(VIRTIO_MMIO_STATUS) = status;
    80005136:	100017b7          	lui	a5,0x10001
    8000513a:	4705                	li	a4,1
    8000513c:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    8000513e:	470d                	li	a4,3
    80005140:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    80005142:	4b98                	lw	a4,16(a5)
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80005144:	c7ffe6b7          	lui	a3,0xc7ffe
    80005148:	75f68693          	add	a3,a3,1887 # ffffffffc7ffe75f <end+0xffffffff47fd851f>
    8000514c:	8f75                	and	a4,a4,a3
    8000514e:	d398                	sw	a4,32(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005150:	472d                	li	a4,11
    80005152:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005154:	473d                	li	a4,15
    80005156:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_GUEST_PAGE_SIZE) = PGSIZE;
    80005158:	6705                	lui	a4,0x1
    8000515a:	d798                	sw	a4,40(a5)
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    8000515c:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80005160:	5bdc                	lw	a5,52(a5)
    80005162:	2781                	sext.w	a5,a5
  if(max == 0)
    80005164:	c7d9                	beqz	a5,800051f2 <virtio_disk_init+0x122>
  if(max < NUM)
    80005166:	471d                	li	a4,7
    80005168:	08f77d63          	bgeu	a4,a5,80005202 <virtio_disk_init+0x132>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    8000516c:	100014b7          	lui	s1,0x10001
    80005170:	47a1                	li	a5,8
    80005172:	dc9c                	sw	a5,56(s1)
  memset(disk.pages, 0, sizeof(disk.pages));
    80005174:	6609                	lui	a2,0x2
    80005176:	4581                	li	a1,0
    80005178:	00016517          	auipc	a0,0x16
    8000517c:	e8850513          	add	a0,a0,-376 # 8001b000 <disk>
    80005180:	ffffb097          	auipc	ra,0xffffb
    80005184:	ffa080e7          	jalr	-6(ra) # 8000017a <memset>
  *R(VIRTIO_MMIO_QUEUE_PFN) = ((uint64)disk.pages) >> PGSHIFT;
    80005188:	00016717          	auipc	a4,0x16
    8000518c:	e7870713          	add	a4,a4,-392 # 8001b000 <disk>
    80005190:	00c75793          	srl	a5,a4,0xc
    80005194:	2781                	sext.w	a5,a5
    80005196:	c0bc                	sw	a5,64(s1)
  disk.desc = (struct virtq_desc *) disk.pages;
    80005198:	00018797          	auipc	a5,0x18
    8000519c:	e6878793          	add	a5,a5,-408 # 8001d000 <disk+0x2000>
    800051a0:	e398                	sd	a4,0(a5)
  disk.avail = (struct virtq_avail *)(disk.pages + NUM*sizeof(struct virtq_desc));
    800051a2:	00016717          	auipc	a4,0x16
    800051a6:	ede70713          	add	a4,a4,-290 # 8001b080 <disk+0x80>
    800051aa:	e798                	sd	a4,8(a5)
  disk.used = (struct virtq_used *) (disk.pages + PGSIZE);
    800051ac:	00017717          	auipc	a4,0x17
    800051b0:	e5470713          	add	a4,a4,-428 # 8001c000 <disk+0x1000>
    800051b4:	eb98                	sd	a4,16(a5)
    disk.free[i] = 1;
    800051b6:	4705                	li	a4,1
    800051b8:	00e78c23          	sb	a4,24(a5)
    800051bc:	00e78ca3          	sb	a4,25(a5)
    800051c0:	00e78d23          	sb	a4,26(a5)
    800051c4:	00e78da3          	sb	a4,27(a5)
    800051c8:	00e78e23          	sb	a4,28(a5)
    800051cc:	00e78ea3          	sb	a4,29(a5)
    800051d0:	00e78f23          	sb	a4,30(a5)
    800051d4:	00e78fa3          	sb	a4,31(a5)
}
    800051d8:	60e2                	ld	ra,24(sp)
    800051da:	6442                	ld	s0,16(sp)
    800051dc:	64a2                	ld	s1,8(sp)
    800051de:	6105                	add	sp,sp,32
    800051e0:	8082                	ret
    panic("could not find virtio disk");
    800051e2:	00003517          	auipc	a0,0x3
    800051e6:	53650513          	add	a0,a0,1334 # 80008718 <syscalls+0x350>
    800051ea:	00001097          	auipc	ra,0x1
    800051ee:	890080e7          	jalr	-1904(ra) # 80005a7a <panic>
    panic("virtio disk has no queue 0");
    800051f2:	00003517          	auipc	a0,0x3
    800051f6:	54650513          	add	a0,a0,1350 # 80008738 <syscalls+0x370>
    800051fa:	00001097          	auipc	ra,0x1
    800051fe:	880080e7          	jalr	-1920(ra) # 80005a7a <panic>
    panic("virtio disk max queue too short");
    80005202:	00003517          	auipc	a0,0x3
    80005206:	55650513          	add	a0,a0,1366 # 80008758 <syscalls+0x390>
    8000520a:	00001097          	auipc	ra,0x1
    8000520e:	870080e7          	jalr	-1936(ra) # 80005a7a <panic>

0000000080005212 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    80005212:	7159                	add	sp,sp,-112
    80005214:	f486                	sd	ra,104(sp)
    80005216:	f0a2                	sd	s0,96(sp)
    80005218:	eca6                	sd	s1,88(sp)
    8000521a:	e8ca                	sd	s2,80(sp)
    8000521c:	e4ce                	sd	s3,72(sp)
    8000521e:	e0d2                	sd	s4,64(sp)
    80005220:	fc56                	sd	s5,56(sp)
    80005222:	f85a                	sd	s6,48(sp)
    80005224:	f45e                	sd	s7,40(sp)
    80005226:	f062                	sd	s8,32(sp)
    80005228:	ec66                	sd	s9,24(sp)
    8000522a:	e86a                	sd	s10,16(sp)
    8000522c:	1880                	add	s0,sp,112
    8000522e:	8a2a                	mv	s4,a0
    80005230:	8cae                	mv	s9,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    80005232:	00c52c03          	lw	s8,12(a0)
    80005236:	001c1c1b          	sllw	s8,s8,0x1
    8000523a:	1c02                	sll	s8,s8,0x20
    8000523c:	020c5c13          	srl	s8,s8,0x20

  acquire(&disk.vdisk_lock);
    80005240:	00018517          	auipc	a0,0x18
    80005244:	ee850513          	add	a0,a0,-280 # 8001d128 <disk+0x2128>
    80005248:	00001097          	auipc	ra,0x1
    8000524c:	d6a080e7          	jalr	-662(ra) # 80005fb2 <acquire>
  for(int i = 0; i < 3; i++){
    80005250:	4901                	li	s2,0
  for(int i = 0; i < NUM; i++){
    80005252:	44a1                	li	s1,8
      disk.free[i] = 0;
    80005254:	00016b97          	auipc	s7,0x16
    80005258:	dacb8b93          	add	s7,s7,-596 # 8001b000 <disk>
    8000525c:	6b09                	lui	s6,0x2
  for(int i = 0; i < 3; i++){
    8000525e:	4a8d                	li	s5,3
    80005260:	a0b5                	j	800052cc <virtio_disk_rw+0xba>
      disk.free[i] = 0;
    80005262:	00fb8733          	add	a4,s7,a5
    80005266:	975a                	add	a4,a4,s6
    80005268:	00070c23          	sb	zero,24(a4)
    idx[i] = alloc_desc();
    8000526c:	c11c                	sw	a5,0(a0)
    if(idx[i] < 0){
    8000526e:	0207c563          	bltz	a5,80005298 <virtio_disk_rw+0x86>
  for(int i = 0; i < 3; i++){
    80005272:	2605                	addw	a2,a2,1 # 2001 <_entry-0x7fffdfff>
    80005274:	0591                	add	a1,a1,4
    80005276:	19560c63          	beq	a2,s5,8000540e <virtio_disk_rw+0x1fc>
    idx[i] = alloc_desc();
    8000527a:	852e                	mv	a0,a1
  for(int i = 0; i < NUM; i++){
    8000527c:	00018717          	auipc	a4,0x18
    80005280:	d9c70713          	add	a4,a4,-612 # 8001d018 <disk+0x2018>
    80005284:	87ca                	mv	a5,s2
    if(disk.free[i]){
    80005286:	00074683          	lbu	a3,0(a4)
    8000528a:	fee1                	bnez	a3,80005262 <virtio_disk_rw+0x50>
  for(int i = 0; i < NUM; i++){
    8000528c:	2785                	addw	a5,a5,1
    8000528e:	0705                	add	a4,a4,1
    80005290:	fe979be3          	bne	a5,s1,80005286 <virtio_disk_rw+0x74>
    idx[i] = alloc_desc();
    80005294:	57fd                	li	a5,-1
    80005296:	c11c                	sw	a5,0(a0)
      for(int j = 0; j < i; j++)
    80005298:	00c05e63          	blez	a2,800052b4 <virtio_disk_rw+0xa2>
    8000529c:	060a                	sll	a2,a2,0x2
    8000529e:	01360d33          	add	s10,a2,s3
        free_desc(idx[j]);
    800052a2:	0009a503          	lw	a0,0(s3)
    800052a6:	00000097          	auipc	ra,0x0
    800052aa:	d90080e7          	jalr	-624(ra) # 80005036 <free_desc>
      for(int j = 0; j < i; j++)
    800052ae:	0991                	add	s3,s3,4
    800052b0:	ffa999e3          	bne	s3,s10,800052a2 <virtio_disk_rw+0x90>
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    800052b4:	00018597          	auipc	a1,0x18
    800052b8:	e7458593          	add	a1,a1,-396 # 8001d128 <disk+0x2128>
    800052bc:	00018517          	auipc	a0,0x18
    800052c0:	d5c50513          	add	a0,a0,-676 # 8001d018 <disk+0x2018>
    800052c4:	ffffc097          	auipc	ra,0xffffc
    800052c8:	242080e7          	jalr	578(ra) # 80001506 <sleep>
  for(int i = 0; i < 3; i++){
    800052cc:	f9040993          	add	s3,s0,-112
{
    800052d0:	85ce                	mv	a1,s3
  for(int i = 0; i < 3; i++){
    800052d2:	864a                	mv	a2,s2
    800052d4:	b75d                	j	8000527a <virtio_disk_rw+0x68>
  disk.desc[idx[0]].next = idx[1];

  disk.desc[idx[1]].addr = (uint64) b->data;
  disk.desc[idx[1]].len = BSIZE;
  if(write)
    disk.desc[idx[1]].flags = 0; // device reads b->data
    800052d6:	00018697          	auipc	a3,0x18
    800052da:	d2a6b683          	ld	a3,-726(a3) # 8001d000 <disk+0x2000>
    800052de:	96ba                	add	a3,a3,a4
    800052e0:	00069623          	sh	zero,12(a3)
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    800052e4:	00016817          	auipc	a6,0x16
    800052e8:	d1c80813          	add	a6,a6,-740 # 8001b000 <disk>
    800052ec:	00018697          	auipc	a3,0x18
    800052f0:	d1468693          	add	a3,a3,-748 # 8001d000 <disk+0x2000>
    800052f4:	6290                	ld	a2,0(a3)
    800052f6:	963a                	add	a2,a2,a4
    800052f8:	00c65583          	lhu	a1,12(a2)
    800052fc:	0015e593          	or	a1,a1,1
    80005300:	00b61623          	sh	a1,12(a2)
  disk.desc[idx[1]].next = idx[2];
    80005304:	f9842603          	lw	a2,-104(s0)
    80005308:	628c                	ld	a1,0(a3)
    8000530a:	972e                	add	a4,a4,a1
    8000530c:	00c71723          	sh	a2,14(a4)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80005310:	20050593          	add	a1,a0,512
    80005314:	0592                	sll	a1,a1,0x4
    80005316:	95c2                	add	a1,a1,a6
    80005318:	577d                	li	a4,-1
    8000531a:	02e58823          	sb	a4,48(a1)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    8000531e:	00461713          	sll	a4,a2,0x4
    80005322:	6290                	ld	a2,0(a3)
    80005324:	963a                	add	a2,a2,a4
    80005326:	03078793          	add	a5,a5,48
    8000532a:	97c2                	add	a5,a5,a6
    8000532c:	e21c                	sd	a5,0(a2)
  disk.desc[idx[2]].len = 1;
    8000532e:	629c                	ld	a5,0(a3)
    80005330:	97ba                	add	a5,a5,a4
    80005332:	4605                	li	a2,1
    80005334:	c790                	sw	a2,8(a5)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80005336:	629c                	ld	a5,0(a3)
    80005338:	97ba                	add	a5,a5,a4
    8000533a:	4809                	li	a6,2
    8000533c:	01079623          	sh	a6,12(a5)
  disk.desc[idx[2]].next = 0;
    80005340:	629c                	ld	a5,0(a3)
    80005342:	97ba                	add	a5,a5,a4
    80005344:	00079723          	sh	zero,14(a5)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    80005348:	00ca2223          	sw	a2,4(s4)
  disk.info[idx[0]].b = b;
    8000534c:	0345b423          	sd	s4,40(a1)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80005350:	6698                	ld	a4,8(a3)
    80005352:	00275783          	lhu	a5,2(a4)
    80005356:	8b9d                	and	a5,a5,7
    80005358:	0786                	sll	a5,a5,0x1
    8000535a:	973e                	add	a4,a4,a5
    8000535c:	00a71223          	sh	a0,4(a4)

  __sync_synchronize();
    80005360:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    80005364:	6698                	ld	a4,8(a3)
    80005366:	00275783          	lhu	a5,2(a4)
    8000536a:	2785                	addw	a5,a5,1
    8000536c:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    80005370:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80005374:	100017b7          	lui	a5,0x10001
    80005378:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    8000537c:	004a2783          	lw	a5,4(s4)
    80005380:	02c79163          	bne	a5,a2,800053a2 <virtio_disk_rw+0x190>
    sleep(b, &disk.vdisk_lock);
    80005384:	00018917          	auipc	s2,0x18
    80005388:	da490913          	add	s2,s2,-604 # 8001d128 <disk+0x2128>
  while(b->disk == 1) {
    8000538c:	4485                	li	s1,1
    sleep(b, &disk.vdisk_lock);
    8000538e:	85ca                	mv	a1,s2
    80005390:	8552                	mv	a0,s4
    80005392:	ffffc097          	auipc	ra,0xffffc
    80005396:	174080e7          	jalr	372(ra) # 80001506 <sleep>
  while(b->disk == 1) {
    8000539a:	004a2783          	lw	a5,4(s4)
    8000539e:	fe9788e3          	beq	a5,s1,8000538e <virtio_disk_rw+0x17c>
  }

  disk.info[idx[0]].b = 0;
    800053a2:	f9042903          	lw	s2,-112(s0)
    800053a6:	20090713          	add	a4,s2,512
    800053aa:	0712                	sll	a4,a4,0x4
    800053ac:	00016797          	auipc	a5,0x16
    800053b0:	c5478793          	add	a5,a5,-940 # 8001b000 <disk>
    800053b4:	97ba                	add	a5,a5,a4
    800053b6:	0207b423          	sd	zero,40(a5)
    int flag = disk.desc[i].flags;
    800053ba:	00018997          	auipc	s3,0x18
    800053be:	c4698993          	add	s3,s3,-954 # 8001d000 <disk+0x2000>
    800053c2:	00491713          	sll	a4,s2,0x4
    800053c6:	0009b783          	ld	a5,0(s3)
    800053ca:	97ba                	add	a5,a5,a4
    800053cc:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    800053d0:	854a                	mv	a0,s2
    800053d2:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    800053d6:	00000097          	auipc	ra,0x0
    800053da:	c60080e7          	jalr	-928(ra) # 80005036 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    800053de:	8885                	and	s1,s1,1
    800053e0:	f0ed                	bnez	s1,800053c2 <virtio_disk_rw+0x1b0>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    800053e2:	00018517          	auipc	a0,0x18
    800053e6:	d4650513          	add	a0,a0,-698 # 8001d128 <disk+0x2128>
    800053ea:	00001097          	auipc	ra,0x1
    800053ee:	c7c080e7          	jalr	-900(ra) # 80006066 <release>
}
    800053f2:	70a6                	ld	ra,104(sp)
    800053f4:	7406                	ld	s0,96(sp)
    800053f6:	64e6                	ld	s1,88(sp)
    800053f8:	6946                	ld	s2,80(sp)
    800053fa:	69a6                	ld	s3,72(sp)
    800053fc:	6a06                	ld	s4,64(sp)
    800053fe:	7ae2                	ld	s5,56(sp)
    80005400:	7b42                	ld	s6,48(sp)
    80005402:	7ba2                	ld	s7,40(sp)
    80005404:	7c02                	ld	s8,32(sp)
    80005406:	6ce2                	ld	s9,24(sp)
    80005408:	6d42                	ld	s10,16(sp)
    8000540a:	6165                	add	sp,sp,112
    8000540c:	8082                	ret
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    8000540e:	f9042503          	lw	a0,-112(s0)
    80005412:	20050793          	add	a5,a0,512
    80005416:	0792                	sll	a5,a5,0x4
  if(write)
    80005418:	00016817          	auipc	a6,0x16
    8000541c:	be880813          	add	a6,a6,-1048 # 8001b000 <disk>
    80005420:	00f80733          	add	a4,a6,a5
    80005424:	019036b3          	snez	a3,s9
    80005428:	0ad72423          	sw	a3,168(a4)
  buf0->reserved = 0;
    8000542c:	0a072623          	sw	zero,172(a4)
  buf0->sector = sector;
    80005430:	0b873823          	sd	s8,176(a4)
  disk.desc[idx[0]].addr = (uint64) buf0;
    80005434:	7679                	lui	a2,0xffffe
    80005436:	963e                	add	a2,a2,a5
    80005438:	00018697          	auipc	a3,0x18
    8000543c:	bc868693          	add	a3,a3,-1080 # 8001d000 <disk+0x2000>
    80005440:	6298                	ld	a4,0(a3)
    80005442:	9732                	add	a4,a4,a2
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80005444:	0a878593          	add	a1,a5,168
    80005448:	95c2                	add	a1,a1,a6
  disk.desc[idx[0]].addr = (uint64) buf0;
    8000544a:	e30c                	sd	a1,0(a4)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    8000544c:	6298                	ld	a4,0(a3)
    8000544e:	9732                	add	a4,a4,a2
    80005450:	45c1                	li	a1,16
    80005452:	c70c                	sw	a1,8(a4)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    80005454:	6298                	ld	a4,0(a3)
    80005456:	9732                	add	a4,a4,a2
    80005458:	4585                	li	a1,1
    8000545a:	00b71623          	sh	a1,12(a4)
  disk.desc[idx[0]].next = idx[1];
    8000545e:	f9442703          	lw	a4,-108(s0)
    80005462:	628c                	ld	a1,0(a3)
    80005464:	962e                	add	a2,a2,a1
    80005466:	00e61723          	sh	a4,14(a2) # ffffffffffffe00e <end+0xffffffff7ffd7dce>
  disk.desc[idx[1]].addr = (uint64) b->data;
    8000546a:	0712                	sll	a4,a4,0x4
    8000546c:	6290                	ld	a2,0(a3)
    8000546e:	963a                	add	a2,a2,a4
    80005470:	058a0593          	add	a1,s4,88
    80005474:	e20c                	sd	a1,0(a2)
  disk.desc[idx[1]].len = BSIZE;
    80005476:	6294                	ld	a3,0(a3)
    80005478:	96ba                	add	a3,a3,a4
    8000547a:	40000613          	li	a2,1024
    8000547e:	c690                	sw	a2,8(a3)
  if(write)
    80005480:	e40c9be3          	bnez	s9,800052d6 <virtio_disk_rw+0xc4>
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    80005484:	00018697          	auipc	a3,0x18
    80005488:	b7c6b683          	ld	a3,-1156(a3) # 8001d000 <disk+0x2000>
    8000548c:	96ba                	add	a3,a3,a4
    8000548e:	4609                	li	a2,2
    80005490:	00c69623          	sh	a2,12(a3)
    80005494:	bd81                	j	800052e4 <virtio_disk_rw+0xd2>

0000000080005496 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    80005496:	1101                	add	sp,sp,-32
    80005498:	ec06                	sd	ra,24(sp)
    8000549a:	e822                	sd	s0,16(sp)
    8000549c:	e426                	sd	s1,8(sp)
    8000549e:	e04a                	sd	s2,0(sp)
    800054a0:	1000                	add	s0,sp,32
  acquire(&disk.vdisk_lock);
    800054a2:	00018517          	auipc	a0,0x18
    800054a6:	c8650513          	add	a0,a0,-890 # 8001d128 <disk+0x2128>
    800054aa:	00001097          	auipc	ra,0x1
    800054ae:	b08080e7          	jalr	-1272(ra) # 80005fb2 <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    800054b2:	10001737          	lui	a4,0x10001
    800054b6:	533c                	lw	a5,96(a4)
    800054b8:	8b8d                	and	a5,a5,3
    800054ba:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    800054bc:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    800054c0:	00018797          	auipc	a5,0x18
    800054c4:	b4078793          	add	a5,a5,-1216 # 8001d000 <disk+0x2000>
    800054c8:	6b94                	ld	a3,16(a5)
    800054ca:	0207d703          	lhu	a4,32(a5)
    800054ce:	0026d783          	lhu	a5,2(a3)
    800054d2:	06f70163          	beq	a4,a5,80005534 <virtio_disk_intr+0x9e>
    __sync_synchronize();
    int id = disk.used->ring[disk.used_idx % NUM].id;
    800054d6:	00016917          	auipc	s2,0x16
    800054da:	b2a90913          	add	s2,s2,-1238 # 8001b000 <disk>
    800054de:	00018497          	auipc	s1,0x18
    800054e2:	b2248493          	add	s1,s1,-1246 # 8001d000 <disk+0x2000>
    __sync_synchronize();
    800054e6:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    800054ea:	6898                	ld	a4,16(s1)
    800054ec:	0204d783          	lhu	a5,32(s1)
    800054f0:	8b9d                	and	a5,a5,7
    800054f2:	078e                	sll	a5,a5,0x3
    800054f4:	97ba                	add	a5,a5,a4
    800054f6:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    800054f8:	20078713          	add	a4,a5,512
    800054fc:	0712                	sll	a4,a4,0x4
    800054fe:	974a                	add	a4,a4,s2
    80005500:	03074703          	lbu	a4,48(a4) # 10001030 <_entry-0x6fffefd0>
    80005504:	e731                	bnez	a4,80005550 <virtio_disk_intr+0xba>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    80005506:	20078793          	add	a5,a5,512
    8000550a:	0792                	sll	a5,a5,0x4
    8000550c:	97ca                	add	a5,a5,s2
    8000550e:	7788                	ld	a0,40(a5)
    b->disk = 0;   // disk is done with buf
    80005510:	00052223          	sw	zero,4(a0)
    wakeup(b);
    80005514:	ffffc097          	auipc	ra,0xffffc
    80005518:	17e080e7          	jalr	382(ra) # 80001692 <wakeup>

    disk.used_idx += 1;
    8000551c:	0204d783          	lhu	a5,32(s1)
    80005520:	2785                	addw	a5,a5,1
    80005522:	17c2                	sll	a5,a5,0x30
    80005524:	93c1                	srl	a5,a5,0x30
    80005526:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    8000552a:	6898                	ld	a4,16(s1)
    8000552c:	00275703          	lhu	a4,2(a4)
    80005530:	faf71be3          	bne	a4,a5,800054e6 <virtio_disk_intr+0x50>
  }

  release(&disk.vdisk_lock);
    80005534:	00018517          	auipc	a0,0x18
    80005538:	bf450513          	add	a0,a0,-1036 # 8001d128 <disk+0x2128>
    8000553c:	00001097          	auipc	ra,0x1
    80005540:	b2a080e7          	jalr	-1238(ra) # 80006066 <release>
}
    80005544:	60e2                	ld	ra,24(sp)
    80005546:	6442                	ld	s0,16(sp)
    80005548:	64a2                	ld	s1,8(sp)
    8000554a:	6902                	ld	s2,0(sp)
    8000554c:	6105                	add	sp,sp,32
    8000554e:	8082                	ret
      panic("virtio_disk_intr status");
    80005550:	00003517          	auipc	a0,0x3
    80005554:	22850513          	add	a0,a0,552 # 80008778 <syscalls+0x3b0>
    80005558:	00000097          	auipc	ra,0x0
    8000555c:	522080e7          	jalr	1314(ra) # 80005a7a <panic>

0000000080005560 <timerinit>:
// which arrive at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    80005560:	1141                	add	sp,sp,-16
    80005562:	e422                	sd	s0,8(sp)
    80005564:	0800                	add	s0,sp,16
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80005566:	f14027f3          	csrr	a5,mhartid
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    8000556a:	0007859b          	sext.w	a1,a5

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    8000556e:	0037979b          	sllw	a5,a5,0x3
    80005572:	02004737          	lui	a4,0x2004
    80005576:	97ba                	add	a5,a5,a4
    80005578:	0200c737          	lui	a4,0x200c
    8000557c:	ff873703          	ld	a4,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80005580:	000f4637          	lui	a2,0xf4
    80005584:	24060613          	add	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80005588:	9732                	add	a4,a4,a2
    8000558a:	e398                	sd	a4,0(a5)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    8000558c:	00259693          	sll	a3,a1,0x2
    80005590:	96ae                	add	a3,a3,a1
    80005592:	068e                	sll	a3,a3,0x3
    80005594:	00019717          	auipc	a4,0x19
    80005598:	a6c70713          	add	a4,a4,-1428 # 8001e000 <timer_scratch>
    8000559c:	9736                	add	a4,a4,a3
  scratch[3] = CLINT_MTIMECMP(id);
    8000559e:	ef1c                	sd	a5,24(a4)
  scratch[4] = interval;
    800055a0:	f310                	sd	a2,32(a4)
  asm volatile("csrw mscratch, %0" : : "r" (x));
    800055a2:	34071073          	csrw	mscratch,a4
  asm volatile("csrw mtvec, %0" : : "r" (x));
    800055a6:	00000797          	auipc	a5,0x0
    800055aa:	9ca78793          	add	a5,a5,-1590 # 80004f70 <timervec>
    800055ae:	30579073          	csrw	mtvec,a5
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    800055b2:	300027f3          	csrr	a5,mstatus

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    800055b6:	0087e793          	or	a5,a5,8
  asm volatile("csrw mstatus, %0" : : "r" (x));
    800055ba:	30079073          	csrw	mstatus,a5
  asm volatile("csrr %0, mie" : "=r" (x) );
    800055be:	304027f3          	csrr	a5,mie

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    800055c2:	0807e793          	or	a5,a5,128
  asm volatile("csrw mie, %0" : : "r" (x));
    800055c6:	30479073          	csrw	mie,a5
}
    800055ca:	6422                	ld	s0,8(sp)
    800055cc:	0141                	add	sp,sp,16
    800055ce:	8082                	ret

00000000800055d0 <start>:
{
    800055d0:	1141                	add	sp,sp,-16
    800055d2:	e406                	sd	ra,8(sp)
    800055d4:	e022                	sd	s0,0(sp)
    800055d6:	0800                	add	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    800055d8:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    800055dc:	7779                	lui	a4,0xffffe
    800055de:	7ff70713          	add	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffd85bf>
    800055e2:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    800055e4:	6705                	lui	a4,0x1
    800055e6:	80070713          	add	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800055ea:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    800055ec:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    800055f0:	ffffb797          	auipc	a5,0xffffb
    800055f4:	d2e78793          	add	a5,a5,-722 # 8000031e <main>
    800055f8:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    800055fc:	4781                	li	a5,0
    800055fe:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    80005602:	67c1                	lui	a5,0x10
    80005604:	17fd                	add	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80005606:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    8000560a:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    8000560e:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    80005612:	2227e793          	or	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    80005616:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    8000561a:	57fd                	li	a5,-1
    8000561c:	83a9                	srl	a5,a5,0xa
    8000561e:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    80005622:	47bd                	li	a5,15
    80005624:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    80005628:	00000097          	auipc	ra,0x0
    8000562c:	f38080e7          	jalr	-200(ra) # 80005560 <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80005630:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    80005634:	2781                	sext.w	a5,a5
  asm volatile("mv tp, %0" : : "r" (x));
    80005636:	823e                	mv	tp,a5
  asm volatile("mret");
    80005638:	30200073          	mret
}
    8000563c:	60a2                	ld	ra,8(sp)
    8000563e:	6402                	ld	s0,0(sp)
    80005640:	0141                	add	sp,sp,16
    80005642:	8082                	ret

0000000080005644 <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80005644:	715d                	add	sp,sp,-80
    80005646:	e486                	sd	ra,72(sp)
    80005648:	e0a2                	sd	s0,64(sp)
    8000564a:	fc26                	sd	s1,56(sp)
    8000564c:	f84a                	sd	s2,48(sp)
    8000564e:	f44e                	sd	s3,40(sp)
    80005650:	f052                	sd	s4,32(sp)
    80005652:	ec56                	sd	s5,24(sp)
    80005654:	0880                	add	s0,sp,80
  int i;

  for(i = 0; i < n; i++){
    80005656:	04c05763          	blez	a2,800056a4 <consolewrite+0x60>
    8000565a:	8a2a                	mv	s4,a0
    8000565c:	84ae                	mv	s1,a1
    8000565e:	89b2                	mv	s3,a2
    80005660:	4901                	li	s2,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    80005662:	5afd                	li	s5,-1
    80005664:	4685                	li	a3,1
    80005666:	8626                	mv	a2,s1
    80005668:	85d2                	mv	a1,s4
    8000566a:	fbf40513          	add	a0,s0,-65
    8000566e:	ffffc097          	auipc	ra,0xffffc
    80005672:	292080e7          	jalr	658(ra) # 80001900 <either_copyin>
    80005676:	01550d63          	beq	a0,s5,80005690 <consolewrite+0x4c>
      break;
    uartputc(c);
    8000567a:	fbf44503          	lbu	a0,-65(s0)
    8000567e:	00000097          	auipc	ra,0x0
    80005682:	77a080e7          	jalr	1914(ra) # 80005df8 <uartputc>
  for(i = 0; i < n; i++){
    80005686:	2905                	addw	s2,s2,1
    80005688:	0485                	add	s1,s1,1
    8000568a:	fd299de3          	bne	s3,s2,80005664 <consolewrite+0x20>
    8000568e:	894e                	mv	s2,s3
  }

  return i;
}
    80005690:	854a                	mv	a0,s2
    80005692:	60a6                	ld	ra,72(sp)
    80005694:	6406                	ld	s0,64(sp)
    80005696:	74e2                	ld	s1,56(sp)
    80005698:	7942                	ld	s2,48(sp)
    8000569a:	79a2                	ld	s3,40(sp)
    8000569c:	7a02                	ld	s4,32(sp)
    8000569e:	6ae2                	ld	s5,24(sp)
    800056a0:	6161                	add	sp,sp,80
    800056a2:	8082                	ret
  for(i = 0; i < n; i++){
    800056a4:	4901                	li	s2,0
    800056a6:	b7ed                	j	80005690 <consolewrite+0x4c>

00000000800056a8 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    800056a8:	711d                	add	sp,sp,-96
    800056aa:	ec86                	sd	ra,88(sp)
    800056ac:	e8a2                	sd	s0,80(sp)
    800056ae:	e4a6                	sd	s1,72(sp)
    800056b0:	e0ca                	sd	s2,64(sp)
    800056b2:	fc4e                	sd	s3,56(sp)
    800056b4:	f852                	sd	s4,48(sp)
    800056b6:	f456                	sd	s5,40(sp)
    800056b8:	f05a                	sd	s6,32(sp)
    800056ba:	ec5e                	sd	s7,24(sp)
    800056bc:	1080                	add	s0,sp,96
    800056be:	8aaa                	mv	s5,a0
    800056c0:	8a2e                	mv	s4,a1
    800056c2:	89b2                	mv	s3,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    800056c4:	00060b1b          	sext.w	s6,a2
  acquire(&cons.lock);
    800056c8:	00021517          	auipc	a0,0x21
    800056cc:	a7850513          	add	a0,a0,-1416 # 80026140 <cons>
    800056d0:	00001097          	auipc	ra,0x1
    800056d4:	8e2080e7          	jalr	-1822(ra) # 80005fb2 <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    800056d8:	00021497          	auipc	s1,0x21
    800056dc:	a6848493          	add	s1,s1,-1432 # 80026140 <cons>
      if(myproc()->killed){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    800056e0:	00021917          	auipc	s2,0x21
    800056e4:	af890913          	add	s2,s2,-1288 # 800261d8 <cons+0x98>
  while(n > 0){
    800056e8:	07305f63          	blez	s3,80005766 <consoleread+0xbe>
    while(cons.r == cons.w){
    800056ec:	0984a783          	lw	a5,152(s1)
    800056f0:	09c4a703          	lw	a4,156(s1)
    800056f4:	02f71463          	bne	a4,a5,8000571c <consoleread+0x74>
      if(myproc()->killed){
    800056f8:	ffffb097          	auipc	ra,0xffffb
    800056fc:	74a080e7          	jalr	1866(ra) # 80000e42 <myproc>
    80005700:	551c                	lw	a5,40(a0)
    80005702:	efad                	bnez	a5,8000577c <consoleread+0xd4>
      sleep(&cons.r, &cons.lock);
    80005704:	85a6                	mv	a1,s1
    80005706:	854a                	mv	a0,s2
    80005708:	ffffc097          	auipc	ra,0xffffc
    8000570c:	dfe080e7          	jalr	-514(ra) # 80001506 <sleep>
    while(cons.r == cons.w){
    80005710:	0984a783          	lw	a5,152(s1)
    80005714:	09c4a703          	lw	a4,156(s1)
    80005718:	fef700e3          	beq	a4,a5,800056f8 <consoleread+0x50>
    }

    c = cons.buf[cons.r++ % INPUT_BUF];
    8000571c:	00021717          	auipc	a4,0x21
    80005720:	a2470713          	add	a4,a4,-1500 # 80026140 <cons>
    80005724:	0017869b          	addw	a3,a5,1
    80005728:	08d72c23          	sw	a3,152(a4)
    8000572c:	07f7f693          	and	a3,a5,127
    80005730:	9736                	add	a4,a4,a3
    80005732:	01874703          	lbu	a4,24(a4)
    80005736:	00070b9b          	sext.w	s7,a4

    if(c == C('D')){  // end-of-file
    8000573a:	4691                	li	a3,4
    8000573c:	06db8463          	beq	s7,a3,800057a4 <consoleread+0xfc>
      }
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    80005740:	fae407a3          	sb	a4,-81(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80005744:	4685                	li	a3,1
    80005746:	faf40613          	add	a2,s0,-81
    8000574a:	85d2                	mv	a1,s4
    8000574c:	8556                	mv	a0,s5
    8000574e:	ffffc097          	auipc	ra,0xffffc
    80005752:	15c080e7          	jalr	348(ra) # 800018aa <either_copyout>
    80005756:	57fd                	li	a5,-1
    80005758:	00f50763          	beq	a0,a5,80005766 <consoleread+0xbe>
      break;

    dst++;
    8000575c:	0a05                	add	s4,s4,1
    --n;
    8000575e:	39fd                	addw	s3,s3,-1

    if(c == '\n'){
    80005760:	47a9                	li	a5,10
    80005762:	f8fb93e3          	bne	s7,a5,800056e8 <consoleread+0x40>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    }
  }
  release(&cons.lock);
    80005766:	00021517          	auipc	a0,0x21
    8000576a:	9da50513          	add	a0,a0,-1574 # 80026140 <cons>
    8000576e:	00001097          	auipc	ra,0x1
    80005772:	8f8080e7          	jalr	-1800(ra) # 80006066 <release>

  return target - n;
    80005776:	413b053b          	subw	a0,s6,s3
    8000577a:	a811                	j	8000578e <consoleread+0xe6>
        release(&cons.lock);
    8000577c:	00021517          	auipc	a0,0x21
    80005780:	9c450513          	add	a0,a0,-1596 # 80026140 <cons>
    80005784:	00001097          	auipc	ra,0x1
    80005788:	8e2080e7          	jalr	-1822(ra) # 80006066 <release>
        return -1;
    8000578c:	557d                	li	a0,-1
}
    8000578e:	60e6                	ld	ra,88(sp)
    80005790:	6446                	ld	s0,80(sp)
    80005792:	64a6                	ld	s1,72(sp)
    80005794:	6906                	ld	s2,64(sp)
    80005796:	79e2                	ld	s3,56(sp)
    80005798:	7a42                	ld	s4,48(sp)
    8000579a:	7aa2                	ld	s5,40(sp)
    8000579c:	7b02                	ld	s6,32(sp)
    8000579e:	6be2                	ld	s7,24(sp)
    800057a0:	6125                	add	sp,sp,96
    800057a2:	8082                	ret
      if(n < target){
    800057a4:	0009871b          	sext.w	a4,s3
    800057a8:	fb677fe3          	bgeu	a4,s6,80005766 <consoleread+0xbe>
        cons.r--;
    800057ac:	00021717          	auipc	a4,0x21
    800057b0:	a2f72623          	sw	a5,-1492(a4) # 800261d8 <cons+0x98>
    800057b4:	bf4d                	j	80005766 <consoleread+0xbe>

00000000800057b6 <consputc>:
{
    800057b6:	1141                	add	sp,sp,-16
    800057b8:	e406                	sd	ra,8(sp)
    800057ba:	e022                	sd	s0,0(sp)
    800057bc:	0800                	add	s0,sp,16
  if(c == BACKSPACE){
    800057be:	10000793          	li	a5,256
    800057c2:	00f50a63          	beq	a0,a5,800057d6 <consputc+0x20>
    uartputc_sync(c);
    800057c6:	00000097          	auipc	ra,0x0
    800057ca:	560080e7          	jalr	1376(ra) # 80005d26 <uartputc_sync>
}
    800057ce:	60a2                	ld	ra,8(sp)
    800057d0:	6402                	ld	s0,0(sp)
    800057d2:	0141                	add	sp,sp,16
    800057d4:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    800057d6:	4521                	li	a0,8
    800057d8:	00000097          	auipc	ra,0x0
    800057dc:	54e080e7          	jalr	1358(ra) # 80005d26 <uartputc_sync>
    800057e0:	02000513          	li	a0,32
    800057e4:	00000097          	auipc	ra,0x0
    800057e8:	542080e7          	jalr	1346(ra) # 80005d26 <uartputc_sync>
    800057ec:	4521                	li	a0,8
    800057ee:	00000097          	auipc	ra,0x0
    800057f2:	538080e7          	jalr	1336(ra) # 80005d26 <uartputc_sync>
    800057f6:	bfe1                	j	800057ce <consputc+0x18>

00000000800057f8 <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    800057f8:	1101                	add	sp,sp,-32
    800057fa:	ec06                	sd	ra,24(sp)
    800057fc:	e822                	sd	s0,16(sp)
    800057fe:	e426                	sd	s1,8(sp)
    80005800:	e04a                	sd	s2,0(sp)
    80005802:	1000                	add	s0,sp,32
    80005804:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    80005806:	00021517          	auipc	a0,0x21
    8000580a:	93a50513          	add	a0,a0,-1734 # 80026140 <cons>
    8000580e:	00000097          	auipc	ra,0x0
    80005812:	7a4080e7          	jalr	1956(ra) # 80005fb2 <acquire>

  switch(c){
    80005816:	47d5                	li	a5,21
    80005818:	0af48663          	beq	s1,a5,800058c4 <consoleintr+0xcc>
    8000581c:	0297ca63          	blt	a5,s1,80005850 <consoleintr+0x58>
    80005820:	47a1                	li	a5,8
    80005822:	0ef48763          	beq	s1,a5,80005910 <consoleintr+0x118>
    80005826:	47c1                	li	a5,16
    80005828:	10f49a63          	bne	s1,a5,8000593c <consoleintr+0x144>
  case C('P'):  // Print process list.
    procdump();
    8000582c:	ffffc097          	auipc	ra,0xffffc
    80005830:	12a080e7          	jalr	298(ra) # 80001956 <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    80005834:	00021517          	auipc	a0,0x21
    80005838:	90c50513          	add	a0,a0,-1780 # 80026140 <cons>
    8000583c:	00001097          	auipc	ra,0x1
    80005840:	82a080e7          	jalr	-2006(ra) # 80006066 <release>
}
    80005844:	60e2                	ld	ra,24(sp)
    80005846:	6442                	ld	s0,16(sp)
    80005848:	64a2                	ld	s1,8(sp)
    8000584a:	6902                	ld	s2,0(sp)
    8000584c:	6105                	add	sp,sp,32
    8000584e:	8082                	ret
  switch(c){
    80005850:	07f00793          	li	a5,127
    80005854:	0af48e63          	beq	s1,a5,80005910 <consoleintr+0x118>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    80005858:	00021717          	auipc	a4,0x21
    8000585c:	8e870713          	add	a4,a4,-1816 # 80026140 <cons>
    80005860:	0a072783          	lw	a5,160(a4)
    80005864:	09872703          	lw	a4,152(a4)
    80005868:	9f99                	subw	a5,a5,a4
    8000586a:	07f00713          	li	a4,127
    8000586e:	fcf763e3          	bltu	a4,a5,80005834 <consoleintr+0x3c>
      c = (c == '\r') ? '\n' : c;
    80005872:	47b5                	li	a5,13
    80005874:	0cf48763          	beq	s1,a5,80005942 <consoleintr+0x14a>
      consputc(c);
    80005878:	8526                	mv	a0,s1
    8000587a:	00000097          	auipc	ra,0x0
    8000587e:	f3c080e7          	jalr	-196(ra) # 800057b6 <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80005882:	00021797          	auipc	a5,0x21
    80005886:	8be78793          	add	a5,a5,-1858 # 80026140 <cons>
    8000588a:	0a07a703          	lw	a4,160(a5)
    8000588e:	0017069b          	addw	a3,a4,1
    80005892:	0006861b          	sext.w	a2,a3
    80005896:	0ad7a023          	sw	a3,160(a5)
    8000589a:	07f77713          	and	a4,a4,127
    8000589e:	97ba                	add	a5,a5,a4
    800058a0:	00978c23          	sb	s1,24(a5)
      if(c == '\n' || c == C('D') || cons.e == cons.r+INPUT_BUF){
    800058a4:	47a9                	li	a5,10
    800058a6:	0cf48563          	beq	s1,a5,80005970 <consoleintr+0x178>
    800058aa:	4791                	li	a5,4
    800058ac:	0cf48263          	beq	s1,a5,80005970 <consoleintr+0x178>
    800058b0:	00021797          	auipc	a5,0x21
    800058b4:	9287a783          	lw	a5,-1752(a5) # 800261d8 <cons+0x98>
    800058b8:	0807879b          	addw	a5,a5,128
    800058bc:	f6f61ce3          	bne	a2,a5,80005834 <consoleintr+0x3c>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    800058c0:	863e                	mv	a2,a5
    800058c2:	a07d                	j	80005970 <consoleintr+0x178>
    while(cons.e != cons.w &&
    800058c4:	00021717          	auipc	a4,0x21
    800058c8:	87c70713          	add	a4,a4,-1924 # 80026140 <cons>
    800058cc:	0a072783          	lw	a5,160(a4)
    800058d0:	09c72703          	lw	a4,156(a4)
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    800058d4:	00021497          	auipc	s1,0x21
    800058d8:	86c48493          	add	s1,s1,-1940 # 80026140 <cons>
    while(cons.e != cons.w &&
    800058dc:	4929                	li	s2,10
    800058de:	f4f70be3          	beq	a4,a5,80005834 <consoleintr+0x3c>
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    800058e2:	37fd                	addw	a5,a5,-1
    800058e4:	07f7f713          	and	a4,a5,127
    800058e8:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    800058ea:	01874703          	lbu	a4,24(a4)
    800058ee:	f52703e3          	beq	a4,s2,80005834 <consoleintr+0x3c>
      cons.e--;
    800058f2:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    800058f6:	10000513          	li	a0,256
    800058fa:	00000097          	auipc	ra,0x0
    800058fe:	ebc080e7          	jalr	-324(ra) # 800057b6 <consputc>
    while(cons.e != cons.w &&
    80005902:	0a04a783          	lw	a5,160(s1)
    80005906:	09c4a703          	lw	a4,156(s1)
    8000590a:	fcf71ce3          	bne	a4,a5,800058e2 <consoleintr+0xea>
    8000590e:	b71d                	j	80005834 <consoleintr+0x3c>
    if(cons.e != cons.w){
    80005910:	00021717          	auipc	a4,0x21
    80005914:	83070713          	add	a4,a4,-2000 # 80026140 <cons>
    80005918:	0a072783          	lw	a5,160(a4)
    8000591c:	09c72703          	lw	a4,156(a4)
    80005920:	f0f70ae3          	beq	a4,a5,80005834 <consoleintr+0x3c>
      cons.e--;
    80005924:	37fd                	addw	a5,a5,-1
    80005926:	00021717          	auipc	a4,0x21
    8000592a:	8af72d23          	sw	a5,-1862(a4) # 800261e0 <cons+0xa0>
      consputc(BACKSPACE);
    8000592e:	10000513          	li	a0,256
    80005932:	00000097          	auipc	ra,0x0
    80005936:	e84080e7          	jalr	-380(ra) # 800057b6 <consputc>
    8000593a:	bded                	j	80005834 <consoleintr+0x3c>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    8000593c:	ee048ce3          	beqz	s1,80005834 <consoleintr+0x3c>
    80005940:	bf21                	j	80005858 <consoleintr+0x60>
      consputc(c);
    80005942:	4529                	li	a0,10
    80005944:	00000097          	auipc	ra,0x0
    80005948:	e72080e7          	jalr	-398(ra) # 800057b6 <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    8000594c:	00020797          	auipc	a5,0x20
    80005950:	7f478793          	add	a5,a5,2036 # 80026140 <cons>
    80005954:	0a07a703          	lw	a4,160(a5)
    80005958:	0017069b          	addw	a3,a4,1
    8000595c:	0006861b          	sext.w	a2,a3
    80005960:	0ad7a023          	sw	a3,160(a5)
    80005964:	07f77713          	and	a4,a4,127
    80005968:	97ba                	add	a5,a5,a4
    8000596a:	4729                	li	a4,10
    8000596c:	00e78c23          	sb	a4,24(a5)
        cons.w = cons.e;
    80005970:	00021797          	auipc	a5,0x21
    80005974:	86c7a623          	sw	a2,-1940(a5) # 800261dc <cons+0x9c>
        wakeup(&cons.r);
    80005978:	00021517          	auipc	a0,0x21
    8000597c:	86050513          	add	a0,a0,-1952 # 800261d8 <cons+0x98>
    80005980:	ffffc097          	auipc	ra,0xffffc
    80005984:	d12080e7          	jalr	-750(ra) # 80001692 <wakeup>
    80005988:	b575                	j	80005834 <consoleintr+0x3c>

000000008000598a <consoleinit>:

void
consoleinit(void)
{
    8000598a:	1141                	add	sp,sp,-16
    8000598c:	e406                	sd	ra,8(sp)
    8000598e:	e022                	sd	s0,0(sp)
    80005990:	0800                	add	s0,sp,16
  initlock(&cons.lock, "cons");
    80005992:	00003597          	auipc	a1,0x3
    80005996:	dfe58593          	add	a1,a1,-514 # 80008790 <syscalls+0x3c8>
    8000599a:	00020517          	auipc	a0,0x20
    8000599e:	7a650513          	add	a0,a0,1958 # 80026140 <cons>
    800059a2:	00000097          	auipc	ra,0x0
    800059a6:	580080e7          	jalr	1408(ra) # 80005f22 <initlock>

  uartinit();
    800059aa:	00000097          	auipc	ra,0x0
    800059ae:	32c080e7          	jalr	812(ra) # 80005cd6 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    800059b2:	00013797          	auipc	a5,0x13
    800059b6:	71678793          	add	a5,a5,1814 # 800190c8 <devsw>
    800059ba:	00000717          	auipc	a4,0x0
    800059be:	cee70713          	add	a4,a4,-786 # 800056a8 <consoleread>
    800059c2:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    800059c4:	00000717          	auipc	a4,0x0
    800059c8:	c8070713          	add	a4,a4,-896 # 80005644 <consolewrite>
    800059cc:	ef98                	sd	a4,24(a5)
}
    800059ce:	60a2                	ld	ra,8(sp)
    800059d0:	6402                	ld	s0,0(sp)
    800059d2:	0141                	add	sp,sp,16
    800059d4:	8082                	ret

00000000800059d6 <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    800059d6:	7179                	add	sp,sp,-48
    800059d8:	f406                	sd	ra,40(sp)
    800059da:	f022                	sd	s0,32(sp)
    800059dc:	ec26                	sd	s1,24(sp)
    800059de:	e84a                	sd	s2,16(sp)
    800059e0:	1800                	add	s0,sp,48
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    800059e2:	c219                	beqz	a2,800059e8 <printint+0x12>
    800059e4:	08054763          	bltz	a0,80005a72 <printint+0x9c>
    x = -xx;
  else
    x = xx;
    800059e8:	2501                	sext.w	a0,a0
    800059ea:	4881                	li	a7,0
    800059ec:	fd040693          	add	a3,s0,-48

  i = 0;
    800059f0:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    800059f2:	2581                	sext.w	a1,a1
    800059f4:	00003617          	auipc	a2,0x3
    800059f8:	dcc60613          	add	a2,a2,-564 # 800087c0 <digits>
    800059fc:	883a                	mv	a6,a4
    800059fe:	2705                	addw	a4,a4,1
    80005a00:	02b577bb          	remuw	a5,a0,a1
    80005a04:	1782                	sll	a5,a5,0x20
    80005a06:	9381                	srl	a5,a5,0x20
    80005a08:	97b2                	add	a5,a5,a2
    80005a0a:	0007c783          	lbu	a5,0(a5)
    80005a0e:	00f68023          	sb	a5,0(a3)
  } while((x /= base) != 0);
    80005a12:	0005079b          	sext.w	a5,a0
    80005a16:	02b5553b          	divuw	a0,a0,a1
    80005a1a:	0685                	add	a3,a3,1
    80005a1c:	feb7f0e3          	bgeu	a5,a1,800059fc <printint+0x26>

  if(sign)
    80005a20:	00088c63          	beqz	a7,80005a38 <printint+0x62>
    buf[i++] = '-';
    80005a24:	fe070793          	add	a5,a4,-32
    80005a28:	00878733          	add	a4,a5,s0
    80005a2c:	02d00793          	li	a5,45
    80005a30:	fef70823          	sb	a5,-16(a4)
    80005a34:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
    80005a38:	02e05763          	blez	a4,80005a66 <printint+0x90>
    80005a3c:	fd040793          	add	a5,s0,-48
    80005a40:	00e784b3          	add	s1,a5,a4
    80005a44:	fff78913          	add	s2,a5,-1
    80005a48:	993a                	add	s2,s2,a4
    80005a4a:	377d                	addw	a4,a4,-1
    80005a4c:	1702                	sll	a4,a4,0x20
    80005a4e:	9301                	srl	a4,a4,0x20
    80005a50:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    80005a54:	fff4c503          	lbu	a0,-1(s1)
    80005a58:	00000097          	auipc	ra,0x0
    80005a5c:	d5e080e7          	jalr	-674(ra) # 800057b6 <consputc>
  while(--i >= 0)
    80005a60:	14fd                	add	s1,s1,-1
    80005a62:	ff2499e3          	bne	s1,s2,80005a54 <printint+0x7e>
}
    80005a66:	70a2                	ld	ra,40(sp)
    80005a68:	7402                	ld	s0,32(sp)
    80005a6a:	64e2                	ld	s1,24(sp)
    80005a6c:	6942                	ld	s2,16(sp)
    80005a6e:	6145                	add	sp,sp,48
    80005a70:	8082                	ret
    x = -xx;
    80005a72:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    80005a76:	4885                	li	a7,1
    x = -xx;
    80005a78:	bf95                	j	800059ec <printint+0x16>

0000000080005a7a <panic>:
    release(&pr.lock);
}

void
panic(char *s)
{
    80005a7a:	1101                	add	sp,sp,-32
    80005a7c:	ec06                	sd	ra,24(sp)
    80005a7e:	e822                	sd	s0,16(sp)
    80005a80:	e426                	sd	s1,8(sp)
    80005a82:	1000                	add	s0,sp,32
    80005a84:	84aa                	mv	s1,a0
  pr.locking = 0;
    80005a86:	00020797          	auipc	a5,0x20
    80005a8a:	7607ad23          	sw	zero,1914(a5) # 80026200 <pr+0x18>
  printf("panic: ");
    80005a8e:	00003517          	auipc	a0,0x3
    80005a92:	d0a50513          	add	a0,a0,-758 # 80008798 <syscalls+0x3d0>
    80005a96:	00000097          	auipc	ra,0x0
    80005a9a:	02e080e7          	jalr	46(ra) # 80005ac4 <printf>
  printf(s);
    80005a9e:	8526                	mv	a0,s1
    80005aa0:	00000097          	auipc	ra,0x0
    80005aa4:	024080e7          	jalr	36(ra) # 80005ac4 <printf>
  printf("\n");
    80005aa8:	00002517          	auipc	a0,0x2
    80005aac:	5a050513          	add	a0,a0,1440 # 80008048 <etext+0x48>
    80005ab0:	00000097          	auipc	ra,0x0
    80005ab4:	014080e7          	jalr	20(ra) # 80005ac4 <printf>
  panicked = 1; // freeze uart output from other CPUs
    80005ab8:	4785                	li	a5,1
    80005aba:	00003717          	auipc	a4,0x3
    80005abe:	56f72123          	sw	a5,1378(a4) # 8000901c <panicked>
  for(;;)
    80005ac2:	a001                	j	80005ac2 <panic+0x48>

0000000080005ac4 <printf>:
{
    80005ac4:	7131                	add	sp,sp,-192
    80005ac6:	fc86                	sd	ra,120(sp)
    80005ac8:	f8a2                	sd	s0,112(sp)
    80005aca:	f4a6                	sd	s1,104(sp)
    80005acc:	f0ca                	sd	s2,96(sp)
    80005ace:	ecce                	sd	s3,88(sp)
    80005ad0:	e8d2                	sd	s4,80(sp)
    80005ad2:	e4d6                	sd	s5,72(sp)
    80005ad4:	e0da                	sd	s6,64(sp)
    80005ad6:	fc5e                	sd	s7,56(sp)
    80005ad8:	f862                	sd	s8,48(sp)
    80005ada:	f466                	sd	s9,40(sp)
    80005adc:	f06a                	sd	s10,32(sp)
    80005ade:	ec6e                	sd	s11,24(sp)
    80005ae0:	0100                	add	s0,sp,128
    80005ae2:	8a2a                	mv	s4,a0
    80005ae4:	e40c                	sd	a1,8(s0)
    80005ae6:	e810                	sd	a2,16(s0)
    80005ae8:	ec14                	sd	a3,24(s0)
    80005aea:	f018                	sd	a4,32(s0)
    80005aec:	f41c                	sd	a5,40(s0)
    80005aee:	03043823          	sd	a6,48(s0)
    80005af2:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    80005af6:	00020d97          	auipc	s11,0x20
    80005afa:	70adad83          	lw	s11,1802(s11) # 80026200 <pr+0x18>
  if(locking)
    80005afe:	020d9b63          	bnez	s11,80005b34 <printf+0x70>
  if (fmt == 0)
    80005b02:	040a0263          	beqz	s4,80005b46 <printf+0x82>
  va_start(ap, fmt);
    80005b06:	00840793          	add	a5,s0,8
    80005b0a:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80005b0e:	000a4503          	lbu	a0,0(s4)
    80005b12:	14050f63          	beqz	a0,80005c70 <printf+0x1ac>
    80005b16:	4981                	li	s3,0
    if(c != '%'){
    80005b18:	02500a93          	li	s5,37
    switch(c){
    80005b1c:	07000b93          	li	s7,112
  consputc('x');
    80005b20:	4d41                	li	s10,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80005b22:	00003b17          	auipc	s6,0x3
    80005b26:	c9eb0b13          	add	s6,s6,-866 # 800087c0 <digits>
    switch(c){
    80005b2a:	07300c93          	li	s9,115
    80005b2e:	06400c13          	li	s8,100
    80005b32:	a82d                	j	80005b6c <printf+0xa8>
    acquire(&pr.lock);
    80005b34:	00020517          	auipc	a0,0x20
    80005b38:	6b450513          	add	a0,a0,1716 # 800261e8 <pr>
    80005b3c:	00000097          	auipc	ra,0x0
    80005b40:	476080e7          	jalr	1142(ra) # 80005fb2 <acquire>
    80005b44:	bf7d                	j	80005b02 <printf+0x3e>
    panic("null fmt");
    80005b46:	00003517          	auipc	a0,0x3
    80005b4a:	c6250513          	add	a0,a0,-926 # 800087a8 <syscalls+0x3e0>
    80005b4e:	00000097          	auipc	ra,0x0
    80005b52:	f2c080e7          	jalr	-212(ra) # 80005a7a <panic>
      consputc(c);
    80005b56:	00000097          	auipc	ra,0x0
    80005b5a:	c60080e7          	jalr	-928(ra) # 800057b6 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80005b5e:	2985                	addw	s3,s3,1
    80005b60:	013a07b3          	add	a5,s4,s3
    80005b64:	0007c503          	lbu	a0,0(a5)
    80005b68:	10050463          	beqz	a0,80005c70 <printf+0x1ac>
    if(c != '%'){
    80005b6c:	ff5515e3          	bne	a0,s5,80005b56 <printf+0x92>
    c = fmt[++i] & 0xff;
    80005b70:	2985                	addw	s3,s3,1
    80005b72:	013a07b3          	add	a5,s4,s3
    80005b76:	0007c783          	lbu	a5,0(a5)
    80005b7a:	0007849b          	sext.w	s1,a5
    if(c == 0)
    80005b7e:	cbed                	beqz	a5,80005c70 <printf+0x1ac>
    switch(c){
    80005b80:	05778a63          	beq	a5,s7,80005bd4 <printf+0x110>
    80005b84:	02fbf663          	bgeu	s7,a5,80005bb0 <printf+0xec>
    80005b88:	09978863          	beq	a5,s9,80005c18 <printf+0x154>
    80005b8c:	07800713          	li	a4,120
    80005b90:	0ce79563          	bne	a5,a4,80005c5a <printf+0x196>
      printint(va_arg(ap, int), 16, 1);
    80005b94:	f8843783          	ld	a5,-120(s0)
    80005b98:	00878713          	add	a4,a5,8
    80005b9c:	f8e43423          	sd	a4,-120(s0)
    80005ba0:	4605                	li	a2,1
    80005ba2:	85ea                	mv	a1,s10
    80005ba4:	4388                	lw	a0,0(a5)
    80005ba6:	00000097          	auipc	ra,0x0
    80005baa:	e30080e7          	jalr	-464(ra) # 800059d6 <printint>
      break;
    80005bae:	bf45                	j	80005b5e <printf+0x9a>
    switch(c){
    80005bb0:	09578f63          	beq	a5,s5,80005c4e <printf+0x18a>
    80005bb4:	0b879363          	bne	a5,s8,80005c5a <printf+0x196>
      printint(va_arg(ap, int), 10, 1);
    80005bb8:	f8843783          	ld	a5,-120(s0)
    80005bbc:	00878713          	add	a4,a5,8
    80005bc0:	f8e43423          	sd	a4,-120(s0)
    80005bc4:	4605                	li	a2,1
    80005bc6:	45a9                	li	a1,10
    80005bc8:	4388                	lw	a0,0(a5)
    80005bca:	00000097          	auipc	ra,0x0
    80005bce:	e0c080e7          	jalr	-500(ra) # 800059d6 <printint>
      break;
    80005bd2:	b771                	j	80005b5e <printf+0x9a>
      printptr(va_arg(ap, uint64));
    80005bd4:	f8843783          	ld	a5,-120(s0)
    80005bd8:	00878713          	add	a4,a5,8
    80005bdc:	f8e43423          	sd	a4,-120(s0)
    80005be0:	0007b903          	ld	s2,0(a5)
  consputc('0');
    80005be4:	03000513          	li	a0,48
    80005be8:	00000097          	auipc	ra,0x0
    80005bec:	bce080e7          	jalr	-1074(ra) # 800057b6 <consputc>
  consputc('x');
    80005bf0:	07800513          	li	a0,120
    80005bf4:	00000097          	auipc	ra,0x0
    80005bf8:	bc2080e7          	jalr	-1086(ra) # 800057b6 <consputc>
    80005bfc:	84ea                	mv	s1,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80005bfe:	03c95793          	srl	a5,s2,0x3c
    80005c02:	97da                	add	a5,a5,s6
    80005c04:	0007c503          	lbu	a0,0(a5)
    80005c08:	00000097          	auipc	ra,0x0
    80005c0c:	bae080e7          	jalr	-1106(ra) # 800057b6 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    80005c10:	0912                	sll	s2,s2,0x4
    80005c12:	34fd                	addw	s1,s1,-1
    80005c14:	f4ed                	bnez	s1,80005bfe <printf+0x13a>
    80005c16:	b7a1                	j	80005b5e <printf+0x9a>
      if((s = va_arg(ap, char*)) == 0)
    80005c18:	f8843783          	ld	a5,-120(s0)
    80005c1c:	00878713          	add	a4,a5,8
    80005c20:	f8e43423          	sd	a4,-120(s0)
    80005c24:	6384                	ld	s1,0(a5)
    80005c26:	cc89                	beqz	s1,80005c40 <printf+0x17c>
      for(; *s; s++)
    80005c28:	0004c503          	lbu	a0,0(s1)
    80005c2c:	d90d                	beqz	a0,80005b5e <printf+0x9a>
        consputc(*s);
    80005c2e:	00000097          	auipc	ra,0x0
    80005c32:	b88080e7          	jalr	-1144(ra) # 800057b6 <consputc>
      for(; *s; s++)
    80005c36:	0485                	add	s1,s1,1
    80005c38:	0004c503          	lbu	a0,0(s1)
    80005c3c:	f96d                	bnez	a0,80005c2e <printf+0x16a>
    80005c3e:	b705                	j	80005b5e <printf+0x9a>
        s = "(null)";
    80005c40:	00003497          	auipc	s1,0x3
    80005c44:	b6048493          	add	s1,s1,-1184 # 800087a0 <syscalls+0x3d8>
      for(; *s; s++)
    80005c48:	02800513          	li	a0,40
    80005c4c:	b7cd                	j	80005c2e <printf+0x16a>
      consputc('%');
    80005c4e:	8556                	mv	a0,s5
    80005c50:	00000097          	auipc	ra,0x0
    80005c54:	b66080e7          	jalr	-1178(ra) # 800057b6 <consputc>
      break;
    80005c58:	b719                	j	80005b5e <printf+0x9a>
      consputc('%');
    80005c5a:	8556                	mv	a0,s5
    80005c5c:	00000097          	auipc	ra,0x0
    80005c60:	b5a080e7          	jalr	-1190(ra) # 800057b6 <consputc>
      consputc(c);
    80005c64:	8526                	mv	a0,s1
    80005c66:	00000097          	auipc	ra,0x0
    80005c6a:	b50080e7          	jalr	-1200(ra) # 800057b6 <consputc>
      break;
    80005c6e:	bdc5                	j	80005b5e <printf+0x9a>
  if(locking)
    80005c70:	020d9163          	bnez	s11,80005c92 <printf+0x1ce>
}
    80005c74:	70e6                	ld	ra,120(sp)
    80005c76:	7446                	ld	s0,112(sp)
    80005c78:	74a6                	ld	s1,104(sp)
    80005c7a:	7906                	ld	s2,96(sp)
    80005c7c:	69e6                	ld	s3,88(sp)
    80005c7e:	6a46                	ld	s4,80(sp)
    80005c80:	6aa6                	ld	s5,72(sp)
    80005c82:	6b06                	ld	s6,64(sp)
    80005c84:	7be2                	ld	s7,56(sp)
    80005c86:	7c42                	ld	s8,48(sp)
    80005c88:	7ca2                	ld	s9,40(sp)
    80005c8a:	7d02                	ld	s10,32(sp)
    80005c8c:	6de2                	ld	s11,24(sp)
    80005c8e:	6129                	add	sp,sp,192
    80005c90:	8082                	ret
    release(&pr.lock);
    80005c92:	00020517          	auipc	a0,0x20
    80005c96:	55650513          	add	a0,a0,1366 # 800261e8 <pr>
    80005c9a:	00000097          	auipc	ra,0x0
    80005c9e:	3cc080e7          	jalr	972(ra) # 80006066 <release>
}
    80005ca2:	bfc9                	j	80005c74 <printf+0x1b0>

0000000080005ca4 <printfinit>:
    ;
}

void
printfinit(void)
{
    80005ca4:	1101                	add	sp,sp,-32
    80005ca6:	ec06                	sd	ra,24(sp)
    80005ca8:	e822                	sd	s0,16(sp)
    80005caa:	e426                	sd	s1,8(sp)
    80005cac:	1000                	add	s0,sp,32
  initlock(&pr.lock, "pr");
    80005cae:	00020497          	auipc	s1,0x20
    80005cb2:	53a48493          	add	s1,s1,1338 # 800261e8 <pr>
    80005cb6:	00003597          	auipc	a1,0x3
    80005cba:	b0258593          	add	a1,a1,-1278 # 800087b8 <syscalls+0x3f0>
    80005cbe:	8526                	mv	a0,s1
    80005cc0:	00000097          	auipc	ra,0x0
    80005cc4:	262080e7          	jalr	610(ra) # 80005f22 <initlock>
  pr.locking = 1;
    80005cc8:	4785                	li	a5,1
    80005cca:	cc9c                	sw	a5,24(s1)
}
    80005ccc:	60e2                	ld	ra,24(sp)
    80005cce:	6442                	ld	s0,16(sp)
    80005cd0:	64a2                	ld	s1,8(sp)
    80005cd2:	6105                	add	sp,sp,32
    80005cd4:	8082                	ret

0000000080005cd6 <uartinit>:

void uartstart();

void
uartinit(void)
{
    80005cd6:	1141                	add	sp,sp,-16
    80005cd8:	e406                	sd	ra,8(sp)
    80005cda:	e022                	sd	s0,0(sp)
    80005cdc:	0800                	add	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    80005cde:	100007b7          	lui	a5,0x10000
    80005ce2:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    80005ce6:	f8000713          	li	a4,-128
    80005cea:	00e781a3          	sb	a4,3(a5)

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    80005cee:	470d                	li	a4,3
    80005cf0:	00e78023          	sb	a4,0(a5)

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    80005cf4:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    80005cf8:	00e781a3          	sb	a4,3(a5)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    80005cfc:	469d                	li	a3,7
    80005cfe:	00d78123          	sb	a3,2(a5)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    80005d02:	00e780a3          	sb	a4,1(a5)

  initlock(&uart_tx_lock, "uart");
    80005d06:	00003597          	auipc	a1,0x3
    80005d0a:	ad258593          	add	a1,a1,-1326 # 800087d8 <digits+0x18>
    80005d0e:	00020517          	auipc	a0,0x20
    80005d12:	4fa50513          	add	a0,a0,1274 # 80026208 <uart_tx_lock>
    80005d16:	00000097          	auipc	ra,0x0
    80005d1a:	20c080e7          	jalr	524(ra) # 80005f22 <initlock>
}
    80005d1e:	60a2                	ld	ra,8(sp)
    80005d20:	6402                	ld	s0,0(sp)
    80005d22:	0141                	add	sp,sp,16
    80005d24:	8082                	ret

0000000080005d26 <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    80005d26:	1101                	add	sp,sp,-32
    80005d28:	ec06                	sd	ra,24(sp)
    80005d2a:	e822                	sd	s0,16(sp)
    80005d2c:	e426                	sd	s1,8(sp)
    80005d2e:	1000                	add	s0,sp,32
    80005d30:	84aa                	mv	s1,a0
  push_off();
    80005d32:	00000097          	auipc	ra,0x0
    80005d36:	234080e7          	jalr	564(ra) # 80005f66 <push_off>

  if(panicked){
    80005d3a:	00003797          	auipc	a5,0x3
    80005d3e:	2e27a783          	lw	a5,738(a5) # 8000901c <panicked>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80005d42:	10000737          	lui	a4,0x10000
  if(panicked){
    80005d46:	c391                	beqz	a5,80005d4a <uartputc_sync+0x24>
    for(;;)
    80005d48:	a001                	j	80005d48 <uartputc_sync+0x22>
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80005d4a:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80005d4e:	0207f793          	and	a5,a5,32
    80005d52:	dfe5                	beqz	a5,80005d4a <uartputc_sync+0x24>
    ;
  WriteReg(THR, c);
    80005d54:	0ff4f513          	zext.b	a0,s1
    80005d58:	100007b7          	lui	a5,0x10000
    80005d5c:	00a78023          	sb	a0,0(a5) # 10000000 <_entry-0x70000000>

  pop_off();
    80005d60:	00000097          	auipc	ra,0x0
    80005d64:	2a6080e7          	jalr	678(ra) # 80006006 <pop_off>
}
    80005d68:	60e2                	ld	ra,24(sp)
    80005d6a:	6442                	ld	s0,16(sp)
    80005d6c:	64a2                	ld	s1,8(sp)
    80005d6e:	6105                	add	sp,sp,32
    80005d70:	8082                	ret

0000000080005d72 <uartstart>:
// called from both the top- and bottom-half.
void
uartstart()
{
  while(1){
    if(uart_tx_w == uart_tx_r){
    80005d72:	00003797          	auipc	a5,0x3
    80005d76:	2ae7b783          	ld	a5,686(a5) # 80009020 <uart_tx_r>
    80005d7a:	00003717          	auipc	a4,0x3
    80005d7e:	2ae73703          	ld	a4,686(a4) # 80009028 <uart_tx_w>
    80005d82:	06f70a63          	beq	a4,a5,80005df6 <uartstart+0x84>
{
    80005d86:	7139                	add	sp,sp,-64
    80005d88:	fc06                	sd	ra,56(sp)
    80005d8a:	f822                	sd	s0,48(sp)
    80005d8c:	f426                	sd	s1,40(sp)
    80005d8e:	f04a                	sd	s2,32(sp)
    80005d90:	ec4e                	sd	s3,24(sp)
    80005d92:	e852                	sd	s4,16(sp)
    80005d94:	e456                	sd	s5,8(sp)
    80005d96:	0080                	add	s0,sp,64
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80005d98:	10000937          	lui	s2,0x10000
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80005d9c:	00020a17          	auipc	s4,0x20
    80005da0:	46ca0a13          	add	s4,s4,1132 # 80026208 <uart_tx_lock>
    uart_tx_r += 1;
    80005da4:	00003497          	auipc	s1,0x3
    80005da8:	27c48493          	add	s1,s1,636 # 80009020 <uart_tx_r>
    if(uart_tx_w == uart_tx_r){
    80005dac:	00003997          	auipc	s3,0x3
    80005db0:	27c98993          	add	s3,s3,636 # 80009028 <uart_tx_w>
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80005db4:	00594703          	lbu	a4,5(s2) # 10000005 <_entry-0x6ffffffb>
    80005db8:	02077713          	and	a4,a4,32
    80005dbc:	c705                	beqz	a4,80005de4 <uartstart+0x72>
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80005dbe:	01f7f713          	and	a4,a5,31
    80005dc2:	9752                	add	a4,a4,s4
    80005dc4:	01874a83          	lbu	s5,24(a4)
    uart_tx_r += 1;
    80005dc8:	0785                	add	a5,a5,1
    80005dca:	e09c                	sd	a5,0(s1)
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    80005dcc:	8526                	mv	a0,s1
    80005dce:	ffffc097          	auipc	ra,0xffffc
    80005dd2:	8c4080e7          	jalr	-1852(ra) # 80001692 <wakeup>
    
    WriteReg(THR, c);
    80005dd6:	01590023          	sb	s5,0(s2)
    if(uart_tx_w == uart_tx_r){
    80005dda:	609c                	ld	a5,0(s1)
    80005ddc:	0009b703          	ld	a4,0(s3)
    80005de0:	fcf71ae3          	bne	a4,a5,80005db4 <uartstart+0x42>
  }
}
    80005de4:	70e2                	ld	ra,56(sp)
    80005de6:	7442                	ld	s0,48(sp)
    80005de8:	74a2                	ld	s1,40(sp)
    80005dea:	7902                	ld	s2,32(sp)
    80005dec:	69e2                	ld	s3,24(sp)
    80005dee:	6a42                	ld	s4,16(sp)
    80005df0:	6aa2                	ld	s5,8(sp)
    80005df2:	6121                	add	sp,sp,64
    80005df4:	8082                	ret
    80005df6:	8082                	ret

0000000080005df8 <uartputc>:
{
    80005df8:	7179                	add	sp,sp,-48
    80005dfa:	f406                	sd	ra,40(sp)
    80005dfc:	f022                	sd	s0,32(sp)
    80005dfe:	ec26                	sd	s1,24(sp)
    80005e00:	e84a                	sd	s2,16(sp)
    80005e02:	e44e                	sd	s3,8(sp)
    80005e04:	e052                	sd	s4,0(sp)
    80005e06:	1800                	add	s0,sp,48
    80005e08:	8a2a                	mv	s4,a0
  acquire(&uart_tx_lock);
    80005e0a:	00020517          	auipc	a0,0x20
    80005e0e:	3fe50513          	add	a0,a0,1022 # 80026208 <uart_tx_lock>
    80005e12:	00000097          	auipc	ra,0x0
    80005e16:	1a0080e7          	jalr	416(ra) # 80005fb2 <acquire>
  if(panicked){
    80005e1a:	00003797          	auipc	a5,0x3
    80005e1e:	2027a783          	lw	a5,514(a5) # 8000901c <panicked>
    80005e22:	c391                	beqz	a5,80005e26 <uartputc+0x2e>
    for(;;)
    80005e24:	a001                	j	80005e24 <uartputc+0x2c>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80005e26:	00003717          	auipc	a4,0x3
    80005e2a:	20273703          	ld	a4,514(a4) # 80009028 <uart_tx_w>
    80005e2e:	00003797          	auipc	a5,0x3
    80005e32:	1f27b783          	ld	a5,498(a5) # 80009020 <uart_tx_r>
    80005e36:	02078793          	add	a5,a5,32
    80005e3a:	02e79b63          	bne	a5,a4,80005e70 <uartputc+0x78>
      sleep(&uart_tx_r, &uart_tx_lock);
    80005e3e:	00020997          	auipc	s3,0x20
    80005e42:	3ca98993          	add	s3,s3,970 # 80026208 <uart_tx_lock>
    80005e46:	00003497          	auipc	s1,0x3
    80005e4a:	1da48493          	add	s1,s1,474 # 80009020 <uart_tx_r>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80005e4e:	00003917          	auipc	s2,0x3
    80005e52:	1da90913          	add	s2,s2,474 # 80009028 <uart_tx_w>
      sleep(&uart_tx_r, &uart_tx_lock);
    80005e56:	85ce                	mv	a1,s3
    80005e58:	8526                	mv	a0,s1
    80005e5a:	ffffb097          	auipc	ra,0xffffb
    80005e5e:	6ac080e7          	jalr	1708(ra) # 80001506 <sleep>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80005e62:	00093703          	ld	a4,0(s2)
    80005e66:	609c                	ld	a5,0(s1)
    80005e68:	02078793          	add	a5,a5,32
    80005e6c:	fee785e3          	beq	a5,a4,80005e56 <uartputc+0x5e>
      uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    80005e70:	00020497          	auipc	s1,0x20
    80005e74:	39848493          	add	s1,s1,920 # 80026208 <uart_tx_lock>
    80005e78:	01f77793          	and	a5,a4,31
    80005e7c:	97a6                	add	a5,a5,s1
    80005e7e:	01478c23          	sb	s4,24(a5)
      uart_tx_w += 1;
    80005e82:	0705                	add	a4,a4,1
    80005e84:	00003797          	auipc	a5,0x3
    80005e88:	1ae7b223          	sd	a4,420(a5) # 80009028 <uart_tx_w>
      uartstart();
    80005e8c:	00000097          	auipc	ra,0x0
    80005e90:	ee6080e7          	jalr	-282(ra) # 80005d72 <uartstart>
      release(&uart_tx_lock);
    80005e94:	8526                	mv	a0,s1
    80005e96:	00000097          	auipc	ra,0x0
    80005e9a:	1d0080e7          	jalr	464(ra) # 80006066 <release>
}
    80005e9e:	70a2                	ld	ra,40(sp)
    80005ea0:	7402                	ld	s0,32(sp)
    80005ea2:	64e2                	ld	s1,24(sp)
    80005ea4:	6942                	ld	s2,16(sp)
    80005ea6:	69a2                	ld	s3,8(sp)
    80005ea8:	6a02                	ld	s4,0(sp)
    80005eaa:	6145                	add	sp,sp,48
    80005eac:	8082                	ret

0000000080005eae <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    80005eae:	1141                	add	sp,sp,-16
    80005eb0:	e422                	sd	s0,8(sp)
    80005eb2:	0800                	add	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    80005eb4:	100007b7          	lui	a5,0x10000
    80005eb8:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80005ebc:	8b85                	and	a5,a5,1
    80005ebe:	cb81                	beqz	a5,80005ece <uartgetc+0x20>
    // input data is ready.
    return ReadReg(RHR);
    80005ec0:	100007b7          	lui	a5,0x10000
    80005ec4:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
  } else {
    return -1;
  }
}
    80005ec8:	6422                	ld	s0,8(sp)
    80005eca:	0141                	add	sp,sp,16
    80005ecc:	8082                	ret
    return -1;
    80005ece:	557d                	li	a0,-1
    80005ed0:	bfe5                	j	80005ec8 <uartgetc+0x1a>

0000000080005ed2 <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from trap.c.
void
uartintr(void)
{
    80005ed2:	1101                	add	sp,sp,-32
    80005ed4:	ec06                	sd	ra,24(sp)
    80005ed6:	e822                	sd	s0,16(sp)
    80005ed8:	e426                	sd	s1,8(sp)
    80005eda:	1000                	add	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    80005edc:	54fd                	li	s1,-1
    80005ede:	a029                	j	80005ee8 <uartintr+0x16>
      break;
    consoleintr(c);
    80005ee0:	00000097          	auipc	ra,0x0
    80005ee4:	918080e7          	jalr	-1768(ra) # 800057f8 <consoleintr>
    int c = uartgetc();
    80005ee8:	00000097          	auipc	ra,0x0
    80005eec:	fc6080e7          	jalr	-58(ra) # 80005eae <uartgetc>
    if(c == -1)
    80005ef0:	fe9518e3          	bne	a0,s1,80005ee0 <uartintr+0xe>
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    80005ef4:	00020497          	auipc	s1,0x20
    80005ef8:	31448493          	add	s1,s1,788 # 80026208 <uart_tx_lock>
    80005efc:	8526                	mv	a0,s1
    80005efe:	00000097          	auipc	ra,0x0
    80005f02:	0b4080e7          	jalr	180(ra) # 80005fb2 <acquire>
  uartstart();
    80005f06:	00000097          	auipc	ra,0x0
    80005f0a:	e6c080e7          	jalr	-404(ra) # 80005d72 <uartstart>
  release(&uart_tx_lock);
    80005f0e:	8526                	mv	a0,s1
    80005f10:	00000097          	auipc	ra,0x0
    80005f14:	156080e7          	jalr	342(ra) # 80006066 <release>
}
    80005f18:	60e2                	ld	ra,24(sp)
    80005f1a:	6442                	ld	s0,16(sp)
    80005f1c:	64a2                	ld	s1,8(sp)
    80005f1e:	6105                	add	sp,sp,32
    80005f20:	8082                	ret

0000000080005f22 <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    80005f22:	1141                	add	sp,sp,-16
    80005f24:	e422                	sd	s0,8(sp)
    80005f26:	0800                	add	s0,sp,16
  lk->name = name;
    80005f28:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    80005f2a:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    80005f2e:	00053823          	sd	zero,16(a0)
}
    80005f32:	6422                	ld	s0,8(sp)
    80005f34:	0141                	add	sp,sp,16
    80005f36:	8082                	ret

0000000080005f38 <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    80005f38:	411c                	lw	a5,0(a0)
    80005f3a:	e399                	bnez	a5,80005f40 <holding+0x8>
    80005f3c:	4501                	li	a0,0
  return r;
}
    80005f3e:	8082                	ret
{
    80005f40:	1101                	add	sp,sp,-32
    80005f42:	ec06                	sd	ra,24(sp)
    80005f44:	e822                	sd	s0,16(sp)
    80005f46:	e426                	sd	s1,8(sp)
    80005f48:	1000                	add	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    80005f4a:	6904                	ld	s1,16(a0)
    80005f4c:	ffffb097          	auipc	ra,0xffffb
    80005f50:	eda080e7          	jalr	-294(ra) # 80000e26 <mycpu>
    80005f54:	40a48533          	sub	a0,s1,a0
    80005f58:	00153513          	seqz	a0,a0
}
    80005f5c:	60e2                	ld	ra,24(sp)
    80005f5e:	6442                	ld	s0,16(sp)
    80005f60:	64a2                	ld	s1,8(sp)
    80005f62:	6105                	add	sp,sp,32
    80005f64:	8082                	ret

0000000080005f66 <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    80005f66:	1101                	add	sp,sp,-32
    80005f68:	ec06                	sd	ra,24(sp)
    80005f6a:	e822                	sd	s0,16(sp)
    80005f6c:	e426                	sd	s1,8(sp)
    80005f6e:	1000                	add	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80005f70:	100024f3          	csrr	s1,sstatus
    80005f74:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80005f78:	9bf5                	and	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80005f7a:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  if(mycpu()->noff == 0)
    80005f7e:	ffffb097          	auipc	ra,0xffffb
    80005f82:	ea8080e7          	jalr	-344(ra) # 80000e26 <mycpu>
    80005f86:	5d3c                	lw	a5,120(a0)
    80005f88:	cf89                	beqz	a5,80005fa2 <push_off+0x3c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    80005f8a:	ffffb097          	auipc	ra,0xffffb
    80005f8e:	e9c080e7          	jalr	-356(ra) # 80000e26 <mycpu>
    80005f92:	5d3c                	lw	a5,120(a0)
    80005f94:	2785                	addw	a5,a5,1
    80005f96:	dd3c                	sw	a5,120(a0)
}
    80005f98:	60e2                	ld	ra,24(sp)
    80005f9a:	6442                	ld	s0,16(sp)
    80005f9c:	64a2                	ld	s1,8(sp)
    80005f9e:	6105                	add	sp,sp,32
    80005fa0:	8082                	ret
    mycpu()->intena = old;
    80005fa2:	ffffb097          	auipc	ra,0xffffb
    80005fa6:	e84080e7          	jalr	-380(ra) # 80000e26 <mycpu>
  return (x & SSTATUS_SIE) != 0;
    80005faa:	8085                	srl	s1,s1,0x1
    80005fac:	8885                	and	s1,s1,1
    80005fae:	dd64                	sw	s1,124(a0)
    80005fb0:	bfe9                	j	80005f8a <push_off+0x24>

0000000080005fb2 <acquire>:
{
    80005fb2:	1101                	add	sp,sp,-32
    80005fb4:	ec06                	sd	ra,24(sp)
    80005fb6:	e822                	sd	s0,16(sp)
    80005fb8:	e426                	sd	s1,8(sp)
    80005fba:	1000                	add	s0,sp,32
    80005fbc:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    80005fbe:	00000097          	auipc	ra,0x0
    80005fc2:	fa8080e7          	jalr	-88(ra) # 80005f66 <push_off>
  if(holding(lk))
    80005fc6:	8526                	mv	a0,s1
    80005fc8:	00000097          	auipc	ra,0x0
    80005fcc:	f70080e7          	jalr	-144(ra) # 80005f38 <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80005fd0:	4705                	li	a4,1
  if(holding(lk))
    80005fd2:	e115                	bnez	a0,80005ff6 <acquire+0x44>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80005fd4:	87ba                	mv	a5,a4
    80005fd6:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80005fda:	2781                	sext.w	a5,a5
    80005fdc:	ffe5                	bnez	a5,80005fd4 <acquire+0x22>
  __sync_synchronize();
    80005fde:	0ff0000f          	fence
  lk->cpu = mycpu();
    80005fe2:	ffffb097          	auipc	ra,0xffffb
    80005fe6:	e44080e7          	jalr	-444(ra) # 80000e26 <mycpu>
    80005fea:	e888                	sd	a0,16(s1)
}
    80005fec:	60e2                	ld	ra,24(sp)
    80005fee:	6442                	ld	s0,16(sp)
    80005ff0:	64a2                	ld	s1,8(sp)
    80005ff2:	6105                	add	sp,sp,32
    80005ff4:	8082                	ret
    panic("acquire");
    80005ff6:	00002517          	auipc	a0,0x2
    80005ffa:	7ea50513          	add	a0,a0,2026 # 800087e0 <digits+0x20>
    80005ffe:	00000097          	auipc	ra,0x0
    80006002:	a7c080e7          	jalr	-1412(ra) # 80005a7a <panic>

0000000080006006 <pop_off>:

void
pop_off(void)
{
    80006006:	1141                	add	sp,sp,-16
    80006008:	e406                	sd	ra,8(sp)
    8000600a:	e022                	sd	s0,0(sp)
    8000600c:	0800                	add	s0,sp,16
  struct cpu *c = mycpu();
    8000600e:	ffffb097          	auipc	ra,0xffffb
    80006012:	e18080e7          	jalr	-488(ra) # 80000e26 <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80006016:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    8000601a:	8b89                	and	a5,a5,2
  if(intr_get())
    8000601c:	e78d                	bnez	a5,80006046 <pop_off+0x40>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    8000601e:	5d3c                	lw	a5,120(a0)
    80006020:	02f05b63          	blez	a5,80006056 <pop_off+0x50>
    panic("pop_off");
  c->noff -= 1;
    80006024:	37fd                	addw	a5,a5,-1
    80006026:	0007871b          	sext.w	a4,a5
    8000602a:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    8000602c:	eb09                	bnez	a4,8000603e <pop_off+0x38>
    8000602e:	5d7c                	lw	a5,124(a0)
    80006030:	c799                	beqz	a5,8000603e <pop_off+0x38>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80006032:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80006036:	0027e793          	or	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000603a:	10079073          	csrw	sstatus,a5
    intr_on();
}
    8000603e:	60a2                	ld	ra,8(sp)
    80006040:	6402                	ld	s0,0(sp)
    80006042:	0141                	add	sp,sp,16
    80006044:	8082                	ret
    panic("pop_off - interruptible");
    80006046:	00002517          	auipc	a0,0x2
    8000604a:	7a250513          	add	a0,a0,1954 # 800087e8 <digits+0x28>
    8000604e:	00000097          	auipc	ra,0x0
    80006052:	a2c080e7          	jalr	-1492(ra) # 80005a7a <panic>
    panic("pop_off");
    80006056:	00002517          	auipc	a0,0x2
    8000605a:	7aa50513          	add	a0,a0,1962 # 80008800 <digits+0x40>
    8000605e:	00000097          	auipc	ra,0x0
    80006062:	a1c080e7          	jalr	-1508(ra) # 80005a7a <panic>

0000000080006066 <release>:
{
    80006066:	1101                	add	sp,sp,-32
    80006068:	ec06                	sd	ra,24(sp)
    8000606a:	e822                	sd	s0,16(sp)
    8000606c:	e426                	sd	s1,8(sp)
    8000606e:	1000                	add	s0,sp,32
    80006070:	84aa                	mv	s1,a0
  if(!holding(lk))
    80006072:	00000097          	auipc	ra,0x0
    80006076:	ec6080e7          	jalr	-314(ra) # 80005f38 <holding>
    8000607a:	c115                	beqz	a0,8000609e <release+0x38>
  lk->cpu = 0;
    8000607c:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    80006080:	0ff0000f          	fence
  __sync_lock_release(&lk->locked);
    80006084:	0f50000f          	fence	iorw,ow
    80006088:	0804a02f          	amoswap.w	zero,zero,(s1)
  pop_off();
    8000608c:	00000097          	auipc	ra,0x0
    80006090:	f7a080e7          	jalr	-134(ra) # 80006006 <pop_off>
}
    80006094:	60e2                	ld	ra,24(sp)
    80006096:	6442                	ld	s0,16(sp)
    80006098:	64a2                	ld	s1,8(sp)
    8000609a:	6105                	add	sp,sp,32
    8000609c:	8082                	ret
    panic("release");
    8000609e:	00002517          	auipc	a0,0x2
    800060a2:	76a50513          	add	a0,a0,1898 # 80008808 <digits+0x48>
    800060a6:	00000097          	auipc	ra,0x0
    800060aa:	9d4080e7          	jalr	-1580(ra) # 80005a7a <panic>
	...

0000000080007000 <_trampoline>:
    80007000:	14051573          	csrrw	a0,sscratch,a0
    80007004:	02153423          	sd	ra,40(a0)
    80007008:	02253823          	sd	sp,48(a0)
    8000700c:	02353c23          	sd	gp,56(a0)
    80007010:	04453023          	sd	tp,64(a0)
    80007014:	04553423          	sd	t0,72(a0)
    80007018:	04653823          	sd	t1,80(a0)
    8000701c:	04753c23          	sd	t2,88(a0)
    80007020:	f120                	sd	s0,96(a0)
    80007022:	f524                	sd	s1,104(a0)
    80007024:	fd2c                	sd	a1,120(a0)
    80007026:	e150                	sd	a2,128(a0)
    80007028:	e554                	sd	a3,136(a0)
    8000702a:	e958                	sd	a4,144(a0)
    8000702c:	ed5c                	sd	a5,152(a0)
    8000702e:	0b053023          	sd	a6,160(a0)
    80007032:	0b153423          	sd	a7,168(a0)
    80007036:	0b253823          	sd	s2,176(a0)
    8000703a:	0b353c23          	sd	s3,184(a0)
    8000703e:	0d453023          	sd	s4,192(a0)
    80007042:	0d553423          	sd	s5,200(a0)
    80007046:	0d653823          	sd	s6,208(a0)
    8000704a:	0d753c23          	sd	s7,216(a0)
    8000704e:	0f853023          	sd	s8,224(a0)
    80007052:	0f953423          	sd	s9,232(a0)
    80007056:	0fa53823          	sd	s10,240(a0)
    8000705a:	0fb53c23          	sd	s11,248(a0)
    8000705e:	11c53023          	sd	t3,256(a0)
    80007062:	11d53423          	sd	t4,264(a0)
    80007066:	11e53823          	sd	t5,272(a0)
    8000706a:	11f53c23          	sd	t6,280(a0)
    8000706e:	140022f3          	csrr	t0,sscratch
    80007072:	06553823          	sd	t0,112(a0)
    80007076:	00853103          	ld	sp,8(a0)
    8000707a:	02053203          	ld	tp,32(a0)
    8000707e:	01053283          	ld	t0,16(a0)
    80007082:	00053303          	ld	t1,0(a0)
    80007086:	18031073          	csrw	satp,t1
    8000708a:	12000073          	sfence.vma
    8000708e:	8282                	jr	t0

0000000080007090 <userret>:
    80007090:	18059073          	csrw	satp,a1
    80007094:	12000073          	sfence.vma
    80007098:	07053283          	ld	t0,112(a0)
    8000709c:	14029073          	csrw	sscratch,t0
    800070a0:	02853083          	ld	ra,40(a0)
    800070a4:	03053103          	ld	sp,48(a0)
    800070a8:	03853183          	ld	gp,56(a0)
    800070ac:	04053203          	ld	tp,64(a0)
    800070b0:	04853283          	ld	t0,72(a0)
    800070b4:	05053303          	ld	t1,80(a0)
    800070b8:	05853383          	ld	t2,88(a0)
    800070bc:	7120                	ld	s0,96(a0)
    800070be:	7524                	ld	s1,104(a0)
    800070c0:	7d2c                	ld	a1,120(a0)
    800070c2:	6150                	ld	a2,128(a0)
    800070c4:	6554                	ld	a3,136(a0)
    800070c6:	6958                	ld	a4,144(a0)
    800070c8:	6d5c                	ld	a5,152(a0)
    800070ca:	0a053803          	ld	a6,160(a0)
    800070ce:	0a853883          	ld	a7,168(a0)
    800070d2:	0b053903          	ld	s2,176(a0)
    800070d6:	0b853983          	ld	s3,184(a0)
    800070da:	0c053a03          	ld	s4,192(a0)
    800070de:	0c853a83          	ld	s5,200(a0)
    800070e2:	0d053b03          	ld	s6,208(a0)
    800070e6:	0d853b83          	ld	s7,216(a0)
    800070ea:	0e053c03          	ld	s8,224(a0)
    800070ee:	0e853c83          	ld	s9,232(a0)
    800070f2:	0f053d03          	ld	s10,240(a0)
    800070f6:	0f853d83          	ld	s11,248(a0)
    800070fa:	10053e03          	ld	t3,256(a0)
    800070fe:	10853e83          	ld	t4,264(a0)
    80007102:	11053f03          	ld	t5,272(a0)
    80007106:	11853f83          	ld	t6,280(a0)
    8000710a:	14051573          	csrrw	a0,sscratch,a0
    8000710e:	10200073          	sret
	...
