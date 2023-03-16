
user/_trace:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	712d                	add	sp,sp,-288
   2:	ee06                	sd	ra,280(sp)
   4:	ea22                	sd	s0,272(sp)
   6:	e626                	sd	s1,264(sp)
   8:	e24a                	sd	s2,256(sp)
   a:	1200                	add	s0,sp,288
   c:	892e                	mv	s2,a1
  int i;
  char *nargv[MAXARG];

  if(argc < 3 || (argv[1][0] < '0' || argv[1][0] > '9')){
   e:	4789                	li	a5,2
  10:	00a7dd63          	bge	a5,a0,2a <main+0x2a>
  14:	84aa                	mv	s1,a0
  16:	6588                	ld	a0,8(a1)
  18:	00054783          	lbu	a5,0(a0)
  1c:	fd07879b          	addw	a5,a5,-48
  20:	0ff7f793          	zext.b	a5,a5
  24:	4725                	li	a4,9
  26:	02f77263          	bgeu	a4,a5,4a <main+0x4a>
    fprintf(2, "Usage: %s mask command\n", argv[0]);
  2a:	00093603          	ld	a2,0(s2)
  2e:	00001597          	auipc	a1,0x1
  32:	81258593          	add	a1,a1,-2030 # 840 <malloc+0xec>
  36:	4509                	li	a0,2
  38:	00000097          	auipc	ra,0x0
  3c:	636080e7          	jalr	1590(ra) # 66e <fprintf>
    exit(1);
  40:	4505                	li	a0,1
  42:	00000097          	auipc	ra,0x0
  46:	2ea080e7          	jalr	746(ra) # 32c <exit>
  }

  if (trace(atoi(argv[1])) < 0) {
  4a:	00000097          	auipc	ra,0x0
  4e:	1e8080e7          	jalr	488(ra) # 232 <atoi>
  52:	00000097          	auipc	ra,0x0
  56:	37a080e7          	jalr	890(ra) # 3cc <trace>
  5a:	04054363          	bltz	a0,a0 <main+0xa0>
  5e:	01090793          	add	a5,s2,16
  62:	ee040713          	add	a4,s0,-288
  66:	34f5                	addw	s1,s1,-3
  68:	02049693          	sll	a3,s1,0x20
  6c:	01d6d493          	srl	s1,a3,0x1d
  70:	94be                	add	s1,s1,a5
  72:	10090593          	add	a1,s2,256
    fprintf(2, "%s: trace failed\n", argv[0]);
    exit(1);
  }
  
  for(i = 2; i < argc && i < MAXARG; i++){
    nargv[i-2] = argv[i];
  76:	6394                	ld	a3,0(a5)
  78:	e314                	sd	a3,0(a4)
  for(i = 2; i < argc && i < MAXARG; i++){
  7a:	00978663          	beq	a5,s1,86 <main+0x86>
  7e:	07a1                	add	a5,a5,8
  80:	0721                	add	a4,a4,8
  82:	feb79ae3          	bne	a5,a1,76 <main+0x76>
  }
  exec(nargv[0], nargv);
  86:	ee040593          	add	a1,s0,-288
  8a:	ee043503          	ld	a0,-288(s0)
  8e:	00000097          	auipc	ra,0x0
  92:	2d6080e7          	jalr	726(ra) # 364 <exec>
  exit(0);
  96:	4501                	li	a0,0
  98:	00000097          	auipc	ra,0x0
  9c:	294080e7          	jalr	660(ra) # 32c <exit>
    fprintf(2, "%s: trace failed\n", argv[0]);
  a0:	00093603          	ld	a2,0(s2)
  a4:	00000597          	auipc	a1,0x0
  a8:	7b458593          	add	a1,a1,1972 # 858 <malloc+0x104>
  ac:	4509                	li	a0,2
  ae:	00000097          	auipc	ra,0x0
  b2:	5c0080e7          	jalr	1472(ra) # 66e <fprintf>
    exit(1);
  b6:	4505                	li	a0,1
  b8:	00000097          	auipc	ra,0x0
  bc:	274080e7          	jalr	628(ra) # 32c <exit>

00000000000000c0 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  c0:	1141                	add	sp,sp,-16
  c2:	e422                	sd	s0,8(sp)
  c4:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  c6:	87aa                	mv	a5,a0
  c8:	0585                	add	a1,a1,1
  ca:	0785                	add	a5,a5,1
  cc:	fff5c703          	lbu	a4,-1(a1)
  d0:	fee78fa3          	sb	a4,-1(a5)
  d4:	fb75                	bnez	a4,c8 <strcpy+0x8>
    ;
  return os;
}
  d6:	6422                	ld	s0,8(sp)
  d8:	0141                	add	sp,sp,16
  da:	8082                	ret

00000000000000dc <strcmp>:

int
strcmp(const char *p, const char *q)
{
  dc:	1141                	add	sp,sp,-16
  de:	e422                	sd	s0,8(sp)
  e0:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  e2:	00054783          	lbu	a5,0(a0)
  e6:	cb91                	beqz	a5,fa <strcmp+0x1e>
  e8:	0005c703          	lbu	a4,0(a1)
  ec:	00f71763          	bne	a4,a5,fa <strcmp+0x1e>
    p++, q++;
  f0:	0505                	add	a0,a0,1
  f2:	0585                	add	a1,a1,1
  while(*p && *p == *q)
  f4:	00054783          	lbu	a5,0(a0)
  f8:	fbe5                	bnez	a5,e8 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  fa:	0005c503          	lbu	a0,0(a1)
}
  fe:	40a7853b          	subw	a0,a5,a0
 102:	6422                	ld	s0,8(sp)
 104:	0141                	add	sp,sp,16
 106:	8082                	ret

0000000000000108 <strlen>:

uint
strlen(const char *s)
{
 108:	1141                	add	sp,sp,-16
 10a:	e422                	sd	s0,8(sp)
 10c:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 10e:	00054783          	lbu	a5,0(a0)
 112:	cf91                	beqz	a5,12e <strlen+0x26>
 114:	0505                	add	a0,a0,1
 116:	87aa                	mv	a5,a0
 118:	86be                	mv	a3,a5
 11a:	0785                	add	a5,a5,1
 11c:	fff7c703          	lbu	a4,-1(a5)
 120:	ff65                	bnez	a4,118 <strlen+0x10>
 122:	40a6853b          	subw	a0,a3,a0
 126:	2505                	addw	a0,a0,1
    ;
  return n;
}
 128:	6422                	ld	s0,8(sp)
 12a:	0141                	add	sp,sp,16
 12c:	8082                	ret
  for(n = 0; s[n]; n++)
 12e:	4501                	li	a0,0
 130:	bfe5                	j	128 <strlen+0x20>

0000000000000132 <memset>:

void*
memset(void *dst, int c, uint n)
{
 132:	1141                	add	sp,sp,-16
 134:	e422                	sd	s0,8(sp)
 136:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 138:	ca19                	beqz	a2,14e <memset+0x1c>
 13a:	87aa                	mv	a5,a0
 13c:	1602                	sll	a2,a2,0x20
 13e:	9201                	srl	a2,a2,0x20
 140:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 144:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 148:	0785                	add	a5,a5,1
 14a:	fee79de3          	bne	a5,a4,144 <memset+0x12>
  }
  return dst;
}
 14e:	6422                	ld	s0,8(sp)
 150:	0141                	add	sp,sp,16
 152:	8082                	ret

0000000000000154 <strchr>:

char*
strchr(const char *s, char c)
{
 154:	1141                	add	sp,sp,-16
 156:	e422                	sd	s0,8(sp)
 158:	0800                	add	s0,sp,16
  for(; *s; s++)
 15a:	00054783          	lbu	a5,0(a0)
 15e:	cb99                	beqz	a5,174 <strchr+0x20>
    if(*s == c)
 160:	00f58763          	beq	a1,a5,16e <strchr+0x1a>
  for(; *s; s++)
 164:	0505                	add	a0,a0,1
 166:	00054783          	lbu	a5,0(a0)
 16a:	fbfd                	bnez	a5,160 <strchr+0xc>
      return (char*)s;
  return 0;
 16c:	4501                	li	a0,0
}
 16e:	6422                	ld	s0,8(sp)
 170:	0141                	add	sp,sp,16
 172:	8082                	ret
  return 0;
 174:	4501                	li	a0,0
 176:	bfe5                	j	16e <strchr+0x1a>

0000000000000178 <gets>:

char*
gets(char *buf, int max)
{
 178:	711d                	add	sp,sp,-96
 17a:	ec86                	sd	ra,88(sp)
 17c:	e8a2                	sd	s0,80(sp)
 17e:	e4a6                	sd	s1,72(sp)
 180:	e0ca                	sd	s2,64(sp)
 182:	fc4e                	sd	s3,56(sp)
 184:	f852                	sd	s4,48(sp)
 186:	f456                	sd	s5,40(sp)
 188:	f05a                	sd	s6,32(sp)
 18a:	ec5e                	sd	s7,24(sp)
 18c:	1080                	add	s0,sp,96
 18e:	8baa                	mv	s7,a0
 190:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 192:	892a                	mv	s2,a0
 194:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 196:	4aa9                	li	s5,10
 198:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 19a:	89a6                	mv	s3,s1
 19c:	2485                	addw	s1,s1,1
 19e:	0344d863          	bge	s1,s4,1ce <gets+0x56>
    cc = read(0, &c, 1);
 1a2:	4605                	li	a2,1
 1a4:	faf40593          	add	a1,s0,-81
 1a8:	4501                	li	a0,0
 1aa:	00000097          	auipc	ra,0x0
 1ae:	19a080e7          	jalr	410(ra) # 344 <read>
    if(cc < 1)
 1b2:	00a05e63          	blez	a0,1ce <gets+0x56>
    buf[i++] = c;
 1b6:	faf44783          	lbu	a5,-81(s0)
 1ba:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1be:	01578763          	beq	a5,s5,1cc <gets+0x54>
 1c2:	0905                	add	s2,s2,1
 1c4:	fd679be3          	bne	a5,s6,19a <gets+0x22>
  for(i=0; i+1 < max; ){
 1c8:	89a6                	mv	s3,s1
 1ca:	a011                	j	1ce <gets+0x56>
 1cc:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1ce:	99de                	add	s3,s3,s7
 1d0:	00098023          	sb	zero,0(s3)
  return buf;
}
 1d4:	855e                	mv	a0,s7
 1d6:	60e6                	ld	ra,88(sp)
 1d8:	6446                	ld	s0,80(sp)
 1da:	64a6                	ld	s1,72(sp)
 1dc:	6906                	ld	s2,64(sp)
 1de:	79e2                	ld	s3,56(sp)
 1e0:	7a42                	ld	s4,48(sp)
 1e2:	7aa2                	ld	s5,40(sp)
 1e4:	7b02                	ld	s6,32(sp)
 1e6:	6be2                	ld	s7,24(sp)
 1e8:	6125                	add	sp,sp,96
 1ea:	8082                	ret

00000000000001ec <stat>:

int
stat(const char *n, struct stat *st)
{
 1ec:	1101                	add	sp,sp,-32
 1ee:	ec06                	sd	ra,24(sp)
 1f0:	e822                	sd	s0,16(sp)
 1f2:	e426                	sd	s1,8(sp)
 1f4:	e04a                	sd	s2,0(sp)
 1f6:	1000                	add	s0,sp,32
 1f8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1fa:	4581                	li	a1,0
 1fc:	00000097          	auipc	ra,0x0
 200:	170080e7          	jalr	368(ra) # 36c <open>
  if(fd < 0)
 204:	02054563          	bltz	a0,22e <stat+0x42>
 208:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 20a:	85ca                	mv	a1,s2
 20c:	00000097          	auipc	ra,0x0
 210:	178080e7          	jalr	376(ra) # 384 <fstat>
 214:	892a                	mv	s2,a0
  close(fd);
 216:	8526                	mv	a0,s1
 218:	00000097          	auipc	ra,0x0
 21c:	13c080e7          	jalr	316(ra) # 354 <close>
  return r;
}
 220:	854a                	mv	a0,s2
 222:	60e2                	ld	ra,24(sp)
 224:	6442                	ld	s0,16(sp)
 226:	64a2                	ld	s1,8(sp)
 228:	6902                	ld	s2,0(sp)
 22a:	6105                	add	sp,sp,32
 22c:	8082                	ret
    return -1;
 22e:	597d                	li	s2,-1
 230:	bfc5                	j	220 <stat+0x34>

0000000000000232 <atoi>:

int
atoi(const char *s)
{
 232:	1141                	add	sp,sp,-16
 234:	e422                	sd	s0,8(sp)
 236:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 238:	00054683          	lbu	a3,0(a0)
 23c:	fd06879b          	addw	a5,a3,-48
 240:	0ff7f793          	zext.b	a5,a5
 244:	4625                	li	a2,9
 246:	02f66863          	bltu	a2,a5,276 <atoi+0x44>
 24a:	872a                	mv	a4,a0
  n = 0;
 24c:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 24e:	0705                	add	a4,a4,1
 250:	0025179b          	sllw	a5,a0,0x2
 254:	9fa9                	addw	a5,a5,a0
 256:	0017979b          	sllw	a5,a5,0x1
 25a:	9fb5                	addw	a5,a5,a3
 25c:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 260:	00074683          	lbu	a3,0(a4)
 264:	fd06879b          	addw	a5,a3,-48
 268:	0ff7f793          	zext.b	a5,a5
 26c:	fef671e3          	bgeu	a2,a5,24e <atoi+0x1c>
  return n;
}
 270:	6422                	ld	s0,8(sp)
 272:	0141                	add	sp,sp,16
 274:	8082                	ret
  n = 0;
 276:	4501                	li	a0,0
 278:	bfe5                	j	270 <atoi+0x3e>

000000000000027a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 27a:	1141                	add	sp,sp,-16
 27c:	e422                	sd	s0,8(sp)
 27e:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 280:	02b57463          	bgeu	a0,a1,2a8 <memmove+0x2e>
    while(n-- > 0)
 284:	00c05f63          	blez	a2,2a2 <memmove+0x28>
 288:	1602                	sll	a2,a2,0x20
 28a:	9201                	srl	a2,a2,0x20
 28c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 290:	872a                	mv	a4,a0
      *dst++ = *src++;
 292:	0585                	add	a1,a1,1
 294:	0705                	add	a4,a4,1
 296:	fff5c683          	lbu	a3,-1(a1)
 29a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 29e:	fee79ae3          	bne	a5,a4,292 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2a2:	6422                	ld	s0,8(sp)
 2a4:	0141                	add	sp,sp,16
 2a6:	8082                	ret
    dst += n;
 2a8:	00c50733          	add	a4,a0,a2
    src += n;
 2ac:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2ae:	fec05ae3          	blez	a2,2a2 <memmove+0x28>
 2b2:	fff6079b          	addw	a5,a2,-1
 2b6:	1782                	sll	a5,a5,0x20
 2b8:	9381                	srl	a5,a5,0x20
 2ba:	fff7c793          	not	a5,a5
 2be:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2c0:	15fd                	add	a1,a1,-1
 2c2:	177d                	add	a4,a4,-1
 2c4:	0005c683          	lbu	a3,0(a1)
 2c8:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2cc:	fee79ae3          	bne	a5,a4,2c0 <memmove+0x46>
 2d0:	bfc9                	j	2a2 <memmove+0x28>

00000000000002d2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2d2:	1141                	add	sp,sp,-16
 2d4:	e422                	sd	s0,8(sp)
 2d6:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2d8:	ca05                	beqz	a2,308 <memcmp+0x36>
 2da:	fff6069b          	addw	a3,a2,-1
 2de:	1682                	sll	a3,a3,0x20
 2e0:	9281                	srl	a3,a3,0x20
 2e2:	0685                	add	a3,a3,1
 2e4:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2e6:	00054783          	lbu	a5,0(a0)
 2ea:	0005c703          	lbu	a4,0(a1)
 2ee:	00e79863          	bne	a5,a4,2fe <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2f2:	0505                	add	a0,a0,1
    p2++;
 2f4:	0585                	add	a1,a1,1
  while (n-- > 0) {
 2f6:	fed518e3          	bne	a0,a3,2e6 <memcmp+0x14>
  }
  return 0;
 2fa:	4501                	li	a0,0
 2fc:	a019                	j	302 <memcmp+0x30>
      return *p1 - *p2;
 2fe:	40e7853b          	subw	a0,a5,a4
}
 302:	6422                	ld	s0,8(sp)
 304:	0141                	add	sp,sp,16
 306:	8082                	ret
  return 0;
 308:	4501                	li	a0,0
 30a:	bfe5                	j	302 <memcmp+0x30>

000000000000030c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 30c:	1141                	add	sp,sp,-16
 30e:	e406                	sd	ra,8(sp)
 310:	e022                	sd	s0,0(sp)
 312:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 314:	00000097          	auipc	ra,0x0
 318:	f66080e7          	jalr	-154(ra) # 27a <memmove>
}
 31c:	60a2                	ld	ra,8(sp)
 31e:	6402                	ld	s0,0(sp)
 320:	0141                	add	sp,sp,16
 322:	8082                	ret

0000000000000324 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 324:	4885                	li	a7,1
 ecall
 326:	00000073          	ecall
 ret
 32a:	8082                	ret

000000000000032c <exit>:
.global exit
exit:
 li a7, SYS_exit
 32c:	4889                	li	a7,2
 ecall
 32e:	00000073          	ecall
 ret
 332:	8082                	ret

0000000000000334 <wait>:
.global wait
wait:
 li a7, SYS_wait
 334:	488d                	li	a7,3
 ecall
 336:	00000073          	ecall
 ret
 33a:	8082                	ret

000000000000033c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 33c:	4891                	li	a7,4
 ecall
 33e:	00000073          	ecall
 ret
 342:	8082                	ret

0000000000000344 <read>:
.global read
read:
 li a7, SYS_read
 344:	4895                	li	a7,5
 ecall
 346:	00000073          	ecall
 ret
 34a:	8082                	ret

000000000000034c <write>:
.global write
write:
 li a7, SYS_write
 34c:	48c1                	li	a7,16
 ecall
 34e:	00000073          	ecall
 ret
 352:	8082                	ret

0000000000000354 <close>:
.global close
close:
 li a7, SYS_close
 354:	48d5                	li	a7,21
 ecall
 356:	00000073          	ecall
 ret
 35a:	8082                	ret

000000000000035c <kill>:
.global kill
kill:
 li a7, SYS_kill
 35c:	4899                	li	a7,6
 ecall
 35e:	00000073          	ecall
 ret
 362:	8082                	ret

0000000000000364 <exec>:
.global exec
exec:
 li a7, SYS_exec
 364:	489d                	li	a7,7
 ecall
 366:	00000073          	ecall
 ret
 36a:	8082                	ret

000000000000036c <open>:
.global open
open:
 li a7, SYS_open
 36c:	48bd                	li	a7,15
 ecall
 36e:	00000073          	ecall
 ret
 372:	8082                	ret

0000000000000374 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 374:	48c5                	li	a7,17
 ecall
 376:	00000073          	ecall
 ret
 37a:	8082                	ret

000000000000037c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 37c:	48c9                	li	a7,18
 ecall
 37e:	00000073          	ecall
 ret
 382:	8082                	ret

0000000000000384 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 384:	48a1                	li	a7,8
 ecall
 386:	00000073          	ecall
 ret
 38a:	8082                	ret

000000000000038c <link>:
.global link
link:
 li a7, SYS_link
 38c:	48cd                	li	a7,19
 ecall
 38e:	00000073          	ecall
 ret
 392:	8082                	ret

0000000000000394 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 394:	48d1                	li	a7,20
 ecall
 396:	00000073          	ecall
 ret
 39a:	8082                	ret

000000000000039c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 39c:	48a5                	li	a7,9
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3a4:	48a9                	li	a7,10
 ecall
 3a6:	00000073          	ecall
 ret
 3aa:	8082                	ret

00000000000003ac <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3ac:	48ad                	li	a7,11
 ecall
 3ae:	00000073          	ecall
 ret
 3b2:	8082                	ret

00000000000003b4 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3b4:	48b1                	li	a7,12
 ecall
 3b6:	00000073          	ecall
 ret
 3ba:	8082                	ret

00000000000003bc <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3bc:	48b5                	li	a7,13
 ecall
 3be:	00000073          	ecall
 ret
 3c2:	8082                	ret

00000000000003c4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3c4:	48b9                	li	a7,14
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <trace>:
.global trace
trace:
 li a7, SYS_trace
 3cc:	48d9                	li	a7,22
 ecall
 3ce:	00000073          	ecall
 ret
 3d2:	8082                	ret

00000000000003d4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3d4:	1101                	add	sp,sp,-32
 3d6:	ec06                	sd	ra,24(sp)
 3d8:	e822                	sd	s0,16(sp)
 3da:	1000                	add	s0,sp,32
 3dc:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3e0:	4605                	li	a2,1
 3e2:	fef40593          	add	a1,s0,-17
 3e6:	00000097          	auipc	ra,0x0
 3ea:	f66080e7          	jalr	-154(ra) # 34c <write>
}
 3ee:	60e2                	ld	ra,24(sp)
 3f0:	6442                	ld	s0,16(sp)
 3f2:	6105                	add	sp,sp,32
 3f4:	8082                	ret

00000000000003f6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3f6:	7139                	add	sp,sp,-64
 3f8:	fc06                	sd	ra,56(sp)
 3fa:	f822                	sd	s0,48(sp)
 3fc:	f426                	sd	s1,40(sp)
 3fe:	f04a                	sd	s2,32(sp)
 400:	ec4e                	sd	s3,24(sp)
 402:	0080                	add	s0,sp,64
 404:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 406:	c299                	beqz	a3,40c <printint+0x16>
 408:	0805c963          	bltz	a1,49a <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 40c:	2581                	sext.w	a1,a1
  neg = 0;
 40e:	4881                	li	a7,0
 410:	fc040693          	add	a3,s0,-64
  }

  i = 0;
 414:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 416:	2601                	sext.w	a2,a2
 418:	00000517          	auipc	a0,0x0
 41c:	4b850513          	add	a0,a0,1208 # 8d0 <digits>
 420:	883a                	mv	a6,a4
 422:	2705                	addw	a4,a4,1
 424:	02c5f7bb          	remuw	a5,a1,a2
 428:	1782                	sll	a5,a5,0x20
 42a:	9381                	srl	a5,a5,0x20
 42c:	97aa                	add	a5,a5,a0
 42e:	0007c783          	lbu	a5,0(a5)
 432:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 436:	0005879b          	sext.w	a5,a1
 43a:	02c5d5bb          	divuw	a1,a1,a2
 43e:	0685                	add	a3,a3,1
 440:	fec7f0e3          	bgeu	a5,a2,420 <printint+0x2a>
  if(neg)
 444:	00088c63          	beqz	a7,45c <printint+0x66>
    buf[i++] = '-';
 448:	fd070793          	add	a5,a4,-48
 44c:	00878733          	add	a4,a5,s0
 450:	02d00793          	li	a5,45
 454:	fef70823          	sb	a5,-16(a4)
 458:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 45c:	02e05863          	blez	a4,48c <printint+0x96>
 460:	fc040793          	add	a5,s0,-64
 464:	00e78933          	add	s2,a5,a4
 468:	fff78993          	add	s3,a5,-1
 46c:	99ba                	add	s3,s3,a4
 46e:	377d                	addw	a4,a4,-1
 470:	1702                	sll	a4,a4,0x20
 472:	9301                	srl	a4,a4,0x20
 474:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 478:	fff94583          	lbu	a1,-1(s2)
 47c:	8526                	mv	a0,s1
 47e:	00000097          	auipc	ra,0x0
 482:	f56080e7          	jalr	-170(ra) # 3d4 <putc>
  while(--i >= 0)
 486:	197d                	add	s2,s2,-1
 488:	ff3918e3          	bne	s2,s3,478 <printint+0x82>
}
 48c:	70e2                	ld	ra,56(sp)
 48e:	7442                	ld	s0,48(sp)
 490:	74a2                	ld	s1,40(sp)
 492:	7902                	ld	s2,32(sp)
 494:	69e2                	ld	s3,24(sp)
 496:	6121                	add	sp,sp,64
 498:	8082                	ret
    x = -xx;
 49a:	40b005bb          	negw	a1,a1
    neg = 1;
 49e:	4885                	li	a7,1
    x = -xx;
 4a0:	bf85                	j	410 <printint+0x1a>

00000000000004a2 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4a2:	715d                	add	sp,sp,-80
 4a4:	e486                	sd	ra,72(sp)
 4a6:	e0a2                	sd	s0,64(sp)
 4a8:	fc26                	sd	s1,56(sp)
 4aa:	f84a                	sd	s2,48(sp)
 4ac:	f44e                	sd	s3,40(sp)
 4ae:	f052                	sd	s4,32(sp)
 4b0:	ec56                	sd	s5,24(sp)
 4b2:	e85a                	sd	s6,16(sp)
 4b4:	e45e                	sd	s7,8(sp)
 4b6:	e062                	sd	s8,0(sp)
 4b8:	0880                	add	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4ba:	0005c903          	lbu	s2,0(a1)
 4be:	18090c63          	beqz	s2,656 <vprintf+0x1b4>
 4c2:	8aaa                	mv	s5,a0
 4c4:	8bb2                	mv	s7,a2
 4c6:	00158493          	add	s1,a1,1
  state = 0;
 4ca:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4cc:	02500a13          	li	s4,37
 4d0:	4b55                	li	s6,21
 4d2:	a839                	j	4f0 <vprintf+0x4e>
        putc(fd, c);
 4d4:	85ca                	mv	a1,s2
 4d6:	8556                	mv	a0,s5
 4d8:	00000097          	auipc	ra,0x0
 4dc:	efc080e7          	jalr	-260(ra) # 3d4 <putc>
 4e0:	a019                	j	4e6 <vprintf+0x44>
    } else if(state == '%'){
 4e2:	01498d63          	beq	s3,s4,4fc <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 4e6:	0485                	add	s1,s1,1
 4e8:	fff4c903          	lbu	s2,-1(s1)
 4ec:	16090563          	beqz	s2,656 <vprintf+0x1b4>
    if(state == 0){
 4f0:	fe0999e3          	bnez	s3,4e2 <vprintf+0x40>
      if(c == '%'){
 4f4:	ff4910e3          	bne	s2,s4,4d4 <vprintf+0x32>
        state = '%';
 4f8:	89d2                	mv	s3,s4
 4fa:	b7f5                	j	4e6 <vprintf+0x44>
      if(c == 'd'){
 4fc:	13490263          	beq	s2,s4,620 <vprintf+0x17e>
 500:	f9d9079b          	addw	a5,s2,-99
 504:	0ff7f793          	zext.b	a5,a5
 508:	12fb6563          	bltu	s6,a5,632 <vprintf+0x190>
 50c:	f9d9079b          	addw	a5,s2,-99
 510:	0ff7f713          	zext.b	a4,a5
 514:	10eb6f63          	bltu	s6,a4,632 <vprintf+0x190>
 518:	00271793          	sll	a5,a4,0x2
 51c:	00000717          	auipc	a4,0x0
 520:	35c70713          	add	a4,a4,860 # 878 <malloc+0x124>
 524:	97ba                	add	a5,a5,a4
 526:	439c                	lw	a5,0(a5)
 528:	97ba                	add	a5,a5,a4
 52a:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 52c:	008b8913          	add	s2,s7,8
 530:	4685                	li	a3,1
 532:	4629                	li	a2,10
 534:	000ba583          	lw	a1,0(s7)
 538:	8556                	mv	a0,s5
 53a:	00000097          	auipc	ra,0x0
 53e:	ebc080e7          	jalr	-324(ra) # 3f6 <printint>
 542:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 544:	4981                	li	s3,0
 546:	b745                	j	4e6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 548:	008b8913          	add	s2,s7,8
 54c:	4681                	li	a3,0
 54e:	4629                	li	a2,10
 550:	000ba583          	lw	a1,0(s7)
 554:	8556                	mv	a0,s5
 556:	00000097          	auipc	ra,0x0
 55a:	ea0080e7          	jalr	-352(ra) # 3f6 <printint>
 55e:	8bca                	mv	s7,s2
      state = 0;
 560:	4981                	li	s3,0
 562:	b751                	j	4e6 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 564:	008b8913          	add	s2,s7,8
 568:	4681                	li	a3,0
 56a:	4641                	li	a2,16
 56c:	000ba583          	lw	a1,0(s7)
 570:	8556                	mv	a0,s5
 572:	00000097          	auipc	ra,0x0
 576:	e84080e7          	jalr	-380(ra) # 3f6 <printint>
 57a:	8bca                	mv	s7,s2
      state = 0;
 57c:	4981                	li	s3,0
 57e:	b7a5                	j	4e6 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 580:	008b8c13          	add	s8,s7,8
 584:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 588:	03000593          	li	a1,48
 58c:	8556                	mv	a0,s5
 58e:	00000097          	auipc	ra,0x0
 592:	e46080e7          	jalr	-442(ra) # 3d4 <putc>
  putc(fd, 'x');
 596:	07800593          	li	a1,120
 59a:	8556                	mv	a0,s5
 59c:	00000097          	auipc	ra,0x0
 5a0:	e38080e7          	jalr	-456(ra) # 3d4 <putc>
 5a4:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5a6:	00000b97          	auipc	s7,0x0
 5aa:	32ab8b93          	add	s7,s7,810 # 8d0 <digits>
 5ae:	03c9d793          	srl	a5,s3,0x3c
 5b2:	97de                	add	a5,a5,s7
 5b4:	0007c583          	lbu	a1,0(a5)
 5b8:	8556                	mv	a0,s5
 5ba:	00000097          	auipc	ra,0x0
 5be:	e1a080e7          	jalr	-486(ra) # 3d4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 5c2:	0992                	sll	s3,s3,0x4
 5c4:	397d                	addw	s2,s2,-1
 5c6:	fe0914e3          	bnez	s2,5ae <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 5ca:	8be2                	mv	s7,s8
      state = 0;
 5cc:	4981                	li	s3,0
 5ce:	bf21                	j	4e6 <vprintf+0x44>
        s = va_arg(ap, char*);
 5d0:	008b8993          	add	s3,s7,8
 5d4:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 5d8:	02090163          	beqz	s2,5fa <vprintf+0x158>
        while(*s != 0){
 5dc:	00094583          	lbu	a1,0(s2)
 5e0:	c9a5                	beqz	a1,650 <vprintf+0x1ae>
          putc(fd, *s);
 5e2:	8556                	mv	a0,s5
 5e4:	00000097          	auipc	ra,0x0
 5e8:	df0080e7          	jalr	-528(ra) # 3d4 <putc>
          s++;
 5ec:	0905                	add	s2,s2,1
        while(*s != 0){
 5ee:	00094583          	lbu	a1,0(s2)
 5f2:	f9e5                	bnez	a1,5e2 <vprintf+0x140>
        s = va_arg(ap, char*);
 5f4:	8bce                	mv	s7,s3
      state = 0;
 5f6:	4981                	li	s3,0
 5f8:	b5fd                	j	4e6 <vprintf+0x44>
          s = "(null)";
 5fa:	00000917          	auipc	s2,0x0
 5fe:	27690913          	add	s2,s2,630 # 870 <malloc+0x11c>
        while(*s != 0){
 602:	02800593          	li	a1,40
 606:	bff1                	j	5e2 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 608:	008b8913          	add	s2,s7,8
 60c:	000bc583          	lbu	a1,0(s7)
 610:	8556                	mv	a0,s5
 612:	00000097          	auipc	ra,0x0
 616:	dc2080e7          	jalr	-574(ra) # 3d4 <putc>
 61a:	8bca                	mv	s7,s2
      state = 0;
 61c:	4981                	li	s3,0
 61e:	b5e1                	j	4e6 <vprintf+0x44>
        putc(fd, c);
 620:	02500593          	li	a1,37
 624:	8556                	mv	a0,s5
 626:	00000097          	auipc	ra,0x0
 62a:	dae080e7          	jalr	-594(ra) # 3d4 <putc>
      state = 0;
 62e:	4981                	li	s3,0
 630:	bd5d                	j	4e6 <vprintf+0x44>
        putc(fd, '%');
 632:	02500593          	li	a1,37
 636:	8556                	mv	a0,s5
 638:	00000097          	auipc	ra,0x0
 63c:	d9c080e7          	jalr	-612(ra) # 3d4 <putc>
        putc(fd, c);
 640:	85ca                	mv	a1,s2
 642:	8556                	mv	a0,s5
 644:	00000097          	auipc	ra,0x0
 648:	d90080e7          	jalr	-624(ra) # 3d4 <putc>
      state = 0;
 64c:	4981                	li	s3,0
 64e:	bd61                	j	4e6 <vprintf+0x44>
        s = va_arg(ap, char*);
 650:	8bce                	mv	s7,s3
      state = 0;
 652:	4981                	li	s3,0
 654:	bd49                	j	4e6 <vprintf+0x44>
    }
  }
}
 656:	60a6                	ld	ra,72(sp)
 658:	6406                	ld	s0,64(sp)
 65a:	74e2                	ld	s1,56(sp)
 65c:	7942                	ld	s2,48(sp)
 65e:	79a2                	ld	s3,40(sp)
 660:	7a02                	ld	s4,32(sp)
 662:	6ae2                	ld	s5,24(sp)
 664:	6b42                	ld	s6,16(sp)
 666:	6ba2                	ld	s7,8(sp)
 668:	6c02                	ld	s8,0(sp)
 66a:	6161                	add	sp,sp,80
 66c:	8082                	ret

000000000000066e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 66e:	715d                	add	sp,sp,-80
 670:	ec06                	sd	ra,24(sp)
 672:	e822                	sd	s0,16(sp)
 674:	1000                	add	s0,sp,32
 676:	e010                	sd	a2,0(s0)
 678:	e414                	sd	a3,8(s0)
 67a:	e818                	sd	a4,16(s0)
 67c:	ec1c                	sd	a5,24(s0)
 67e:	03043023          	sd	a6,32(s0)
 682:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 686:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 68a:	8622                	mv	a2,s0
 68c:	00000097          	auipc	ra,0x0
 690:	e16080e7          	jalr	-490(ra) # 4a2 <vprintf>
}
 694:	60e2                	ld	ra,24(sp)
 696:	6442                	ld	s0,16(sp)
 698:	6161                	add	sp,sp,80
 69a:	8082                	ret

000000000000069c <printf>:

void
printf(const char *fmt, ...)
{
 69c:	711d                	add	sp,sp,-96
 69e:	ec06                	sd	ra,24(sp)
 6a0:	e822                	sd	s0,16(sp)
 6a2:	1000                	add	s0,sp,32
 6a4:	e40c                	sd	a1,8(s0)
 6a6:	e810                	sd	a2,16(s0)
 6a8:	ec14                	sd	a3,24(s0)
 6aa:	f018                	sd	a4,32(s0)
 6ac:	f41c                	sd	a5,40(s0)
 6ae:	03043823          	sd	a6,48(s0)
 6b2:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6b6:	00840613          	add	a2,s0,8
 6ba:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 6be:	85aa                	mv	a1,a0
 6c0:	4505                	li	a0,1
 6c2:	00000097          	auipc	ra,0x0
 6c6:	de0080e7          	jalr	-544(ra) # 4a2 <vprintf>
}
 6ca:	60e2                	ld	ra,24(sp)
 6cc:	6442                	ld	s0,16(sp)
 6ce:	6125                	add	sp,sp,96
 6d0:	8082                	ret

00000000000006d2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6d2:	1141                	add	sp,sp,-16
 6d4:	e422                	sd	s0,8(sp)
 6d6:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6d8:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6dc:	00000797          	auipc	a5,0x0
 6e0:	20c7b783          	ld	a5,524(a5) # 8e8 <freep>
 6e4:	a02d                	j	70e <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6e6:	4618                	lw	a4,8(a2)
 6e8:	9f2d                	addw	a4,a4,a1
 6ea:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 6ee:	6398                	ld	a4,0(a5)
 6f0:	6310                	ld	a2,0(a4)
 6f2:	a83d                	j	730 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 6f4:	ff852703          	lw	a4,-8(a0)
 6f8:	9f31                	addw	a4,a4,a2
 6fa:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 6fc:	ff053683          	ld	a3,-16(a0)
 700:	a091                	j	744 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 702:	6398                	ld	a4,0(a5)
 704:	00e7e463          	bltu	a5,a4,70c <free+0x3a>
 708:	00e6ea63          	bltu	a3,a4,71c <free+0x4a>
{
 70c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 70e:	fed7fae3          	bgeu	a5,a3,702 <free+0x30>
 712:	6398                	ld	a4,0(a5)
 714:	00e6e463          	bltu	a3,a4,71c <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 718:	fee7eae3          	bltu	a5,a4,70c <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 71c:	ff852583          	lw	a1,-8(a0)
 720:	6390                	ld	a2,0(a5)
 722:	02059813          	sll	a6,a1,0x20
 726:	01c85713          	srl	a4,a6,0x1c
 72a:	9736                	add	a4,a4,a3
 72c:	fae60de3          	beq	a2,a4,6e6 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 730:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 734:	4790                	lw	a2,8(a5)
 736:	02061593          	sll	a1,a2,0x20
 73a:	01c5d713          	srl	a4,a1,0x1c
 73e:	973e                	add	a4,a4,a5
 740:	fae68ae3          	beq	a3,a4,6f4 <free+0x22>
    p->s.ptr = bp->s.ptr;
 744:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 746:	00000717          	auipc	a4,0x0
 74a:	1af73123          	sd	a5,418(a4) # 8e8 <freep>
}
 74e:	6422                	ld	s0,8(sp)
 750:	0141                	add	sp,sp,16
 752:	8082                	ret

0000000000000754 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 754:	7139                	add	sp,sp,-64
 756:	fc06                	sd	ra,56(sp)
 758:	f822                	sd	s0,48(sp)
 75a:	f426                	sd	s1,40(sp)
 75c:	f04a                	sd	s2,32(sp)
 75e:	ec4e                	sd	s3,24(sp)
 760:	e852                	sd	s4,16(sp)
 762:	e456                	sd	s5,8(sp)
 764:	e05a                	sd	s6,0(sp)
 766:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 768:	02051493          	sll	s1,a0,0x20
 76c:	9081                	srl	s1,s1,0x20
 76e:	04bd                	add	s1,s1,15
 770:	8091                	srl	s1,s1,0x4
 772:	0014899b          	addw	s3,s1,1
 776:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 778:	00000517          	auipc	a0,0x0
 77c:	17053503          	ld	a0,368(a0) # 8e8 <freep>
 780:	c515                	beqz	a0,7ac <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 782:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 784:	4798                	lw	a4,8(a5)
 786:	02977f63          	bgeu	a4,s1,7c4 <malloc+0x70>
  if(nu < 4096)
 78a:	8a4e                	mv	s4,s3
 78c:	0009871b          	sext.w	a4,s3
 790:	6685                	lui	a3,0x1
 792:	00d77363          	bgeu	a4,a3,798 <malloc+0x44>
 796:	6a05                	lui	s4,0x1
 798:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 79c:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7a0:	00000917          	auipc	s2,0x0
 7a4:	14890913          	add	s2,s2,328 # 8e8 <freep>
  if(p == (char*)-1)
 7a8:	5afd                	li	s5,-1
 7aa:	a895                	j	81e <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 7ac:	00000797          	auipc	a5,0x0
 7b0:	14478793          	add	a5,a5,324 # 8f0 <base>
 7b4:	00000717          	auipc	a4,0x0
 7b8:	12f73a23          	sd	a5,308(a4) # 8e8 <freep>
 7bc:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 7be:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 7c2:	b7e1                	j	78a <malloc+0x36>
      if(p->s.size == nunits)
 7c4:	02e48c63          	beq	s1,a4,7fc <malloc+0xa8>
        p->s.size -= nunits;
 7c8:	4137073b          	subw	a4,a4,s3
 7cc:	c798                	sw	a4,8(a5)
        p += p->s.size;
 7ce:	02071693          	sll	a3,a4,0x20
 7d2:	01c6d713          	srl	a4,a3,0x1c
 7d6:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 7d8:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 7dc:	00000717          	auipc	a4,0x0
 7e0:	10a73623          	sd	a0,268(a4) # 8e8 <freep>
      return (void*)(p + 1);
 7e4:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7e8:	70e2                	ld	ra,56(sp)
 7ea:	7442                	ld	s0,48(sp)
 7ec:	74a2                	ld	s1,40(sp)
 7ee:	7902                	ld	s2,32(sp)
 7f0:	69e2                	ld	s3,24(sp)
 7f2:	6a42                	ld	s4,16(sp)
 7f4:	6aa2                	ld	s5,8(sp)
 7f6:	6b02                	ld	s6,0(sp)
 7f8:	6121                	add	sp,sp,64
 7fa:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 7fc:	6398                	ld	a4,0(a5)
 7fe:	e118                	sd	a4,0(a0)
 800:	bff1                	j	7dc <malloc+0x88>
  hp->s.size = nu;
 802:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 806:	0541                	add	a0,a0,16
 808:	00000097          	auipc	ra,0x0
 80c:	eca080e7          	jalr	-310(ra) # 6d2 <free>
  return freep;
 810:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 814:	d971                	beqz	a0,7e8 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 816:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 818:	4798                	lw	a4,8(a5)
 81a:	fa9775e3          	bgeu	a4,s1,7c4 <malloc+0x70>
    if(p == freep)
 81e:	00093703          	ld	a4,0(s2)
 822:	853e                	mv	a0,a5
 824:	fef719e3          	bne	a4,a5,816 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 828:	8552                	mv	a0,s4
 82a:	00000097          	auipc	ra,0x0
 82e:	b8a080e7          	jalr	-1142(ra) # 3b4 <sbrk>
  if(p == (char*)-1)
 832:	fd5518e3          	bne	a0,s5,802 <malloc+0xae>
        return 0;
 836:	4501                	li	a0,0
 838:	bf45                	j	7e8 <malloc+0x94>
