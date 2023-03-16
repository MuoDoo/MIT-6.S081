
user/_usertests:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <copyinstr1>:
}

// what if you pass ridiculous string pointers to system calls?
void
copyinstr1(char *s)
{
       0:	1141                	add	sp,sp,-16
       2:	e406                	sd	ra,8(sp)
       4:	e022                	sd	s0,0(sp)
       6:	0800                	add	s0,sp,16
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };

  for(int ai = 0; ai < 2; ai++){
    uint64 addr = addrs[ai];

    int fd = open((char *)addr, O_CREATE|O_WRONLY);
       8:	20100593          	li	a1,513
       c:	4505                	li	a0,1
       e:	057e                	sll	a0,a0,0x1f
      10:	00006097          	auipc	ra,0x6
      14:	862080e7          	jalr	-1950(ra) # 5872 <open>
    if(fd >= 0){
      18:	02055063          	bgez	a0,38 <copyinstr1+0x38>
    int fd = open((char *)addr, O_CREATE|O_WRONLY);
      1c:	20100593          	li	a1,513
      20:	557d                	li	a0,-1
      22:	00006097          	auipc	ra,0x6
      26:	850080e7          	jalr	-1968(ra) # 5872 <open>
    uint64 addr = addrs[ai];
      2a:	55fd                	li	a1,-1
    if(fd >= 0){
      2c:	00055863          	bgez	a0,3c <copyinstr1+0x3c>
      printf("open(%p) returned %d, not -1\n", addr, fd);
      exit(1);
    }
  }
}
      30:	60a2                	ld	ra,8(sp)
      32:	6402                	ld	s0,0(sp)
      34:	0141                	add	sp,sp,16
      36:	8082                	ret
    uint64 addr = addrs[ai];
      38:	4585                	li	a1,1
      3a:	05fe                	sll	a1,a1,0x1f
      printf("open(%p) returned %d, not -1\n", addr, fd);
      3c:	862a                	mv	a2,a0
      3e:	00006517          	auipc	a0,0x6
      42:	d0250513          	add	a0,a0,-766 # 5d40 <malloc+0xe6>
      46:	00006097          	auipc	ra,0x6
      4a:	b5c080e7          	jalr	-1188(ra) # 5ba2 <printf>
      exit(1);
      4e:	4505                	li	a0,1
      50:	00005097          	auipc	ra,0x5
      54:	7e2080e7          	jalr	2018(ra) # 5832 <exit>

0000000000000058 <bsstest>:
void
bsstest(char *s)
{
  int i;

  for(i = 0; i < sizeof(uninit); i++){
      58:	00009797          	auipc	a5,0x9
      5c:	65078793          	add	a5,a5,1616 # 96a8 <uninit>
      60:	0000c697          	auipc	a3,0xc
      64:	d5868693          	add	a3,a3,-680 # bdb8 <buf>
    if(uninit[i] != '\0'){
      68:	0007c703          	lbu	a4,0(a5)
      6c:	e709                	bnez	a4,76 <bsstest+0x1e>
  for(i = 0; i < sizeof(uninit); i++){
      6e:	0785                	add	a5,a5,1
      70:	fed79ce3          	bne	a5,a3,68 <bsstest+0x10>
      74:	8082                	ret
{
      76:	1141                	add	sp,sp,-16
      78:	e406                	sd	ra,8(sp)
      7a:	e022                	sd	s0,0(sp)
      7c:	0800                	add	s0,sp,16
      printf("%s: bss test failed\n", s);
      7e:	85aa                	mv	a1,a0
      80:	00006517          	auipc	a0,0x6
      84:	ce050513          	add	a0,a0,-800 # 5d60 <malloc+0x106>
      88:	00006097          	auipc	ra,0x6
      8c:	b1a080e7          	jalr	-1254(ra) # 5ba2 <printf>
      exit(1);
      90:	4505                	li	a0,1
      92:	00005097          	auipc	ra,0x5
      96:	7a0080e7          	jalr	1952(ra) # 5832 <exit>

000000000000009a <opentest>:
{
      9a:	1101                	add	sp,sp,-32
      9c:	ec06                	sd	ra,24(sp)
      9e:	e822                	sd	s0,16(sp)
      a0:	e426                	sd	s1,8(sp)
      a2:	1000                	add	s0,sp,32
      a4:	84aa                	mv	s1,a0
  fd = open("echo", 0);
      a6:	4581                	li	a1,0
      a8:	00006517          	auipc	a0,0x6
      ac:	cd050513          	add	a0,a0,-816 # 5d78 <malloc+0x11e>
      b0:	00005097          	auipc	ra,0x5
      b4:	7c2080e7          	jalr	1986(ra) # 5872 <open>
  if(fd < 0){
      b8:	02054663          	bltz	a0,e4 <opentest+0x4a>
  close(fd);
      bc:	00005097          	auipc	ra,0x5
      c0:	79e080e7          	jalr	1950(ra) # 585a <close>
  fd = open("doesnotexist", 0);
      c4:	4581                	li	a1,0
      c6:	00006517          	auipc	a0,0x6
      ca:	cd250513          	add	a0,a0,-814 # 5d98 <malloc+0x13e>
      ce:	00005097          	auipc	ra,0x5
      d2:	7a4080e7          	jalr	1956(ra) # 5872 <open>
  if(fd >= 0){
      d6:	02055563          	bgez	a0,100 <opentest+0x66>
}
      da:	60e2                	ld	ra,24(sp)
      dc:	6442                	ld	s0,16(sp)
      de:	64a2                	ld	s1,8(sp)
      e0:	6105                	add	sp,sp,32
      e2:	8082                	ret
    printf("%s: open echo failed!\n", s);
      e4:	85a6                	mv	a1,s1
      e6:	00006517          	auipc	a0,0x6
      ea:	c9a50513          	add	a0,a0,-870 # 5d80 <malloc+0x126>
      ee:	00006097          	auipc	ra,0x6
      f2:	ab4080e7          	jalr	-1356(ra) # 5ba2 <printf>
    exit(1);
      f6:	4505                	li	a0,1
      f8:	00005097          	auipc	ra,0x5
      fc:	73a080e7          	jalr	1850(ra) # 5832 <exit>
    printf("%s: open doesnotexist succeeded!\n", s);
     100:	85a6                	mv	a1,s1
     102:	00006517          	auipc	a0,0x6
     106:	ca650513          	add	a0,a0,-858 # 5da8 <malloc+0x14e>
     10a:	00006097          	auipc	ra,0x6
     10e:	a98080e7          	jalr	-1384(ra) # 5ba2 <printf>
    exit(1);
     112:	4505                	li	a0,1
     114:	00005097          	auipc	ra,0x5
     118:	71e080e7          	jalr	1822(ra) # 5832 <exit>

000000000000011c <truncate2>:
{
     11c:	7179                	add	sp,sp,-48
     11e:	f406                	sd	ra,40(sp)
     120:	f022                	sd	s0,32(sp)
     122:	ec26                	sd	s1,24(sp)
     124:	e84a                	sd	s2,16(sp)
     126:	e44e                	sd	s3,8(sp)
     128:	1800                	add	s0,sp,48
     12a:	89aa                	mv	s3,a0
  unlink("truncfile");
     12c:	00006517          	auipc	a0,0x6
     130:	ca450513          	add	a0,a0,-860 # 5dd0 <malloc+0x176>
     134:	00005097          	auipc	ra,0x5
     138:	74e080e7          	jalr	1870(ra) # 5882 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_TRUNC|O_WRONLY);
     13c:	60100593          	li	a1,1537
     140:	00006517          	auipc	a0,0x6
     144:	c9050513          	add	a0,a0,-880 # 5dd0 <malloc+0x176>
     148:	00005097          	auipc	ra,0x5
     14c:	72a080e7          	jalr	1834(ra) # 5872 <open>
     150:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     152:	4611                	li	a2,4
     154:	00006597          	auipc	a1,0x6
     158:	c8c58593          	add	a1,a1,-884 # 5de0 <malloc+0x186>
     15c:	00005097          	auipc	ra,0x5
     160:	6f6080e7          	jalr	1782(ra) # 5852 <write>
  int fd2 = open("truncfile", O_TRUNC|O_WRONLY);
     164:	40100593          	li	a1,1025
     168:	00006517          	auipc	a0,0x6
     16c:	c6850513          	add	a0,a0,-920 # 5dd0 <malloc+0x176>
     170:	00005097          	auipc	ra,0x5
     174:	702080e7          	jalr	1794(ra) # 5872 <open>
     178:	892a                	mv	s2,a0
  int n = write(fd1, "x", 1);
     17a:	4605                	li	a2,1
     17c:	00006597          	auipc	a1,0x6
     180:	c6c58593          	add	a1,a1,-916 # 5de8 <malloc+0x18e>
     184:	8526                	mv	a0,s1
     186:	00005097          	auipc	ra,0x5
     18a:	6cc080e7          	jalr	1740(ra) # 5852 <write>
  if(n != -1){
     18e:	57fd                	li	a5,-1
     190:	02f51b63          	bne	a0,a5,1c6 <truncate2+0xaa>
  unlink("truncfile");
     194:	00006517          	auipc	a0,0x6
     198:	c3c50513          	add	a0,a0,-964 # 5dd0 <malloc+0x176>
     19c:	00005097          	auipc	ra,0x5
     1a0:	6e6080e7          	jalr	1766(ra) # 5882 <unlink>
  close(fd1);
     1a4:	8526                	mv	a0,s1
     1a6:	00005097          	auipc	ra,0x5
     1aa:	6b4080e7          	jalr	1716(ra) # 585a <close>
  close(fd2);
     1ae:	854a                	mv	a0,s2
     1b0:	00005097          	auipc	ra,0x5
     1b4:	6aa080e7          	jalr	1706(ra) # 585a <close>
}
     1b8:	70a2                	ld	ra,40(sp)
     1ba:	7402                	ld	s0,32(sp)
     1bc:	64e2                	ld	s1,24(sp)
     1be:	6942                	ld	s2,16(sp)
     1c0:	69a2                	ld	s3,8(sp)
     1c2:	6145                	add	sp,sp,48
     1c4:	8082                	ret
    printf("%s: write returned %d, expected -1\n", s, n);
     1c6:	862a                	mv	a2,a0
     1c8:	85ce                	mv	a1,s3
     1ca:	00006517          	auipc	a0,0x6
     1ce:	c2650513          	add	a0,a0,-986 # 5df0 <malloc+0x196>
     1d2:	00006097          	auipc	ra,0x6
     1d6:	9d0080e7          	jalr	-1584(ra) # 5ba2 <printf>
    exit(1);
     1da:	4505                	li	a0,1
     1dc:	00005097          	auipc	ra,0x5
     1e0:	656080e7          	jalr	1622(ra) # 5832 <exit>

00000000000001e4 <createtest>:
{
     1e4:	7179                	add	sp,sp,-48
     1e6:	f406                	sd	ra,40(sp)
     1e8:	f022                	sd	s0,32(sp)
     1ea:	ec26                	sd	s1,24(sp)
     1ec:	e84a                	sd	s2,16(sp)
     1ee:	1800                	add	s0,sp,48
  name[0] = 'a';
     1f0:	06100793          	li	a5,97
     1f4:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     1f8:	fc040d23          	sb	zero,-38(s0)
     1fc:	03000493          	li	s1,48
  for(i = 0; i < N; i++){
     200:	06400913          	li	s2,100
    name[1] = '0' + i;
     204:	fc940ca3          	sb	s1,-39(s0)
    fd = open(name, O_CREATE|O_RDWR);
     208:	20200593          	li	a1,514
     20c:	fd840513          	add	a0,s0,-40
     210:	00005097          	auipc	ra,0x5
     214:	662080e7          	jalr	1634(ra) # 5872 <open>
    close(fd);
     218:	00005097          	auipc	ra,0x5
     21c:	642080e7          	jalr	1602(ra) # 585a <close>
  for(i = 0; i < N; i++){
     220:	2485                	addw	s1,s1,1
     222:	0ff4f493          	zext.b	s1,s1
     226:	fd249fe3          	bne	s1,s2,204 <createtest+0x20>
  name[0] = 'a';
     22a:	06100793          	li	a5,97
     22e:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     232:	fc040d23          	sb	zero,-38(s0)
     236:	03000493          	li	s1,48
  for(i = 0; i < N; i++){
     23a:	06400913          	li	s2,100
    name[1] = '0' + i;
     23e:	fc940ca3          	sb	s1,-39(s0)
    unlink(name);
     242:	fd840513          	add	a0,s0,-40
     246:	00005097          	auipc	ra,0x5
     24a:	63c080e7          	jalr	1596(ra) # 5882 <unlink>
  for(i = 0; i < N; i++){
     24e:	2485                	addw	s1,s1,1
     250:	0ff4f493          	zext.b	s1,s1
     254:	ff2495e3          	bne	s1,s2,23e <createtest+0x5a>
}
     258:	70a2                	ld	ra,40(sp)
     25a:	7402                	ld	s0,32(sp)
     25c:	64e2                	ld	s1,24(sp)
     25e:	6942                	ld	s2,16(sp)
     260:	6145                	add	sp,sp,48
     262:	8082                	ret

0000000000000264 <bigwrite>:
{
     264:	715d                	add	sp,sp,-80
     266:	e486                	sd	ra,72(sp)
     268:	e0a2                	sd	s0,64(sp)
     26a:	fc26                	sd	s1,56(sp)
     26c:	f84a                	sd	s2,48(sp)
     26e:	f44e                	sd	s3,40(sp)
     270:	f052                	sd	s4,32(sp)
     272:	ec56                	sd	s5,24(sp)
     274:	e85a                	sd	s6,16(sp)
     276:	e45e                	sd	s7,8(sp)
     278:	0880                	add	s0,sp,80
     27a:	8baa                	mv	s7,a0
  unlink("bigwrite");
     27c:	00006517          	auipc	a0,0x6
     280:	b9c50513          	add	a0,a0,-1124 # 5e18 <malloc+0x1be>
     284:	00005097          	auipc	ra,0x5
     288:	5fe080e7          	jalr	1534(ra) # 5882 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     28c:	1f300493          	li	s1,499
    fd = open("bigwrite", O_CREATE | O_RDWR);
     290:	00006a97          	auipc	s5,0x6
     294:	b88a8a93          	add	s5,s5,-1144 # 5e18 <malloc+0x1be>
      int cc = write(fd, buf, sz);
     298:	0000ca17          	auipc	s4,0xc
     29c:	b20a0a13          	add	s4,s4,-1248 # bdb8 <buf>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2a0:	6b0d                	lui	s6,0x3
     2a2:	1c9b0b13          	add	s6,s6,457 # 31c9 <dirtest+0x97>
    fd = open("bigwrite", O_CREATE | O_RDWR);
     2a6:	20200593          	li	a1,514
     2aa:	8556                	mv	a0,s5
     2ac:	00005097          	auipc	ra,0x5
     2b0:	5c6080e7          	jalr	1478(ra) # 5872 <open>
     2b4:	892a                	mv	s2,a0
    if(fd < 0){
     2b6:	04054d63          	bltz	a0,310 <bigwrite+0xac>
      int cc = write(fd, buf, sz);
     2ba:	8626                	mv	a2,s1
     2bc:	85d2                	mv	a1,s4
     2be:	00005097          	auipc	ra,0x5
     2c2:	594080e7          	jalr	1428(ra) # 5852 <write>
     2c6:	89aa                	mv	s3,a0
      if(cc != sz){
     2c8:	06a49263          	bne	s1,a0,32c <bigwrite+0xc8>
      int cc = write(fd, buf, sz);
     2cc:	8626                	mv	a2,s1
     2ce:	85d2                	mv	a1,s4
     2d0:	854a                	mv	a0,s2
     2d2:	00005097          	auipc	ra,0x5
     2d6:	580080e7          	jalr	1408(ra) # 5852 <write>
      if(cc != sz){
     2da:	04951a63          	bne	a0,s1,32e <bigwrite+0xca>
    close(fd);
     2de:	854a                	mv	a0,s2
     2e0:	00005097          	auipc	ra,0x5
     2e4:	57a080e7          	jalr	1402(ra) # 585a <close>
    unlink("bigwrite");
     2e8:	8556                	mv	a0,s5
     2ea:	00005097          	auipc	ra,0x5
     2ee:	598080e7          	jalr	1432(ra) # 5882 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2f2:	1d74849b          	addw	s1,s1,471
     2f6:	fb6498e3          	bne	s1,s6,2a6 <bigwrite+0x42>
}
     2fa:	60a6                	ld	ra,72(sp)
     2fc:	6406                	ld	s0,64(sp)
     2fe:	74e2                	ld	s1,56(sp)
     300:	7942                	ld	s2,48(sp)
     302:	79a2                	ld	s3,40(sp)
     304:	7a02                	ld	s4,32(sp)
     306:	6ae2                	ld	s5,24(sp)
     308:	6b42                	ld	s6,16(sp)
     30a:	6ba2                	ld	s7,8(sp)
     30c:	6161                	add	sp,sp,80
     30e:	8082                	ret
      printf("%s: cannot create bigwrite\n", s);
     310:	85de                	mv	a1,s7
     312:	00006517          	auipc	a0,0x6
     316:	b1650513          	add	a0,a0,-1258 # 5e28 <malloc+0x1ce>
     31a:	00006097          	auipc	ra,0x6
     31e:	888080e7          	jalr	-1912(ra) # 5ba2 <printf>
      exit(1);
     322:	4505                	li	a0,1
     324:	00005097          	auipc	ra,0x5
     328:	50e080e7          	jalr	1294(ra) # 5832 <exit>
      if(cc != sz){
     32c:	89a6                	mv	s3,s1
        printf("%s: write(%d) ret %d\n", s, sz, cc);
     32e:	86aa                	mv	a3,a0
     330:	864e                	mv	a2,s3
     332:	85de                	mv	a1,s7
     334:	00006517          	auipc	a0,0x6
     338:	b1450513          	add	a0,a0,-1260 # 5e48 <malloc+0x1ee>
     33c:	00006097          	auipc	ra,0x6
     340:	866080e7          	jalr	-1946(ra) # 5ba2 <printf>
        exit(1);
     344:	4505                	li	a0,1
     346:	00005097          	auipc	ra,0x5
     34a:	4ec080e7          	jalr	1260(ra) # 5832 <exit>

000000000000034e <copyin>:
{
     34e:	715d                	add	sp,sp,-80
     350:	e486                	sd	ra,72(sp)
     352:	e0a2                	sd	s0,64(sp)
     354:	fc26                	sd	s1,56(sp)
     356:	f84a                	sd	s2,48(sp)
     358:	f44e                	sd	s3,40(sp)
     35a:	f052                	sd	s4,32(sp)
     35c:	0880                	add	s0,sp,80
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     35e:	4785                	li	a5,1
     360:	07fe                	sll	a5,a5,0x1f
     362:	fcf43023          	sd	a5,-64(s0)
     366:	57fd                	li	a5,-1
     368:	fcf43423          	sd	a5,-56(s0)
  for(int ai = 0; ai < 2; ai++){
     36c:	fc040913          	add	s2,s0,-64
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     370:	00006a17          	auipc	s4,0x6
     374:	af0a0a13          	add	s4,s4,-1296 # 5e60 <malloc+0x206>
    uint64 addr = addrs[ai];
     378:	00093983          	ld	s3,0(s2)
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     37c:	20100593          	li	a1,513
     380:	8552                	mv	a0,s4
     382:	00005097          	auipc	ra,0x5
     386:	4f0080e7          	jalr	1264(ra) # 5872 <open>
     38a:	84aa                	mv	s1,a0
    if(fd < 0){
     38c:	08054863          	bltz	a0,41c <copyin+0xce>
    int n = write(fd, (void*)addr, 8192);
     390:	6609                	lui	a2,0x2
     392:	85ce                	mv	a1,s3
     394:	00005097          	auipc	ra,0x5
     398:	4be080e7          	jalr	1214(ra) # 5852 <write>
    if(n >= 0){
     39c:	08055d63          	bgez	a0,436 <copyin+0xe8>
    close(fd);
     3a0:	8526                	mv	a0,s1
     3a2:	00005097          	auipc	ra,0x5
     3a6:	4b8080e7          	jalr	1208(ra) # 585a <close>
    unlink("copyin1");
     3aa:	8552                	mv	a0,s4
     3ac:	00005097          	auipc	ra,0x5
     3b0:	4d6080e7          	jalr	1238(ra) # 5882 <unlink>
    n = write(1, (char*)addr, 8192);
     3b4:	6609                	lui	a2,0x2
     3b6:	85ce                	mv	a1,s3
     3b8:	4505                	li	a0,1
     3ba:	00005097          	auipc	ra,0x5
     3be:	498080e7          	jalr	1176(ra) # 5852 <write>
    if(n > 0){
     3c2:	08a04963          	bgtz	a0,454 <copyin+0x106>
    if(pipe(fds) < 0){
     3c6:	fb840513          	add	a0,s0,-72
     3ca:	00005097          	auipc	ra,0x5
     3ce:	478080e7          	jalr	1144(ra) # 5842 <pipe>
     3d2:	0a054063          	bltz	a0,472 <copyin+0x124>
    n = write(fds[1], (char*)addr, 8192);
     3d6:	6609                	lui	a2,0x2
     3d8:	85ce                	mv	a1,s3
     3da:	fbc42503          	lw	a0,-68(s0)
     3de:	00005097          	auipc	ra,0x5
     3e2:	474080e7          	jalr	1140(ra) # 5852 <write>
    if(n > 0){
     3e6:	0aa04363          	bgtz	a0,48c <copyin+0x13e>
    close(fds[0]);
     3ea:	fb842503          	lw	a0,-72(s0)
     3ee:	00005097          	auipc	ra,0x5
     3f2:	46c080e7          	jalr	1132(ra) # 585a <close>
    close(fds[1]);
     3f6:	fbc42503          	lw	a0,-68(s0)
     3fa:	00005097          	auipc	ra,0x5
     3fe:	460080e7          	jalr	1120(ra) # 585a <close>
  for(int ai = 0; ai < 2; ai++){
     402:	0921                	add	s2,s2,8
     404:	fd040793          	add	a5,s0,-48
     408:	f6f918e3          	bne	s2,a5,378 <copyin+0x2a>
}
     40c:	60a6                	ld	ra,72(sp)
     40e:	6406                	ld	s0,64(sp)
     410:	74e2                	ld	s1,56(sp)
     412:	7942                	ld	s2,48(sp)
     414:	79a2                	ld	s3,40(sp)
     416:	7a02                	ld	s4,32(sp)
     418:	6161                	add	sp,sp,80
     41a:	8082                	ret
      printf("open(copyin1) failed\n");
     41c:	00006517          	auipc	a0,0x6
     420:	a4c50513          	add	a0,a0,-1460 # 5e68 <malloc+0x20e>
     424:	00005097          	auipc	ra,0x5
     428:	77e080e7          	jalr	1918(ra) # 5ba2 <printf>
      exit(1);
     42c:	4505                	li	a0,1
     42e:	00005097          	auipc	ra,0x5
     432:	404080e7          	jalr	1028(ra) # 5832 <exit>
      printf("write(fd, %p, 8192) returned %d, not -1\n", addr, n);
     436:	862a                	mv	a2,a0
     438:	85ce                	mv	a1,s3
     43a:	00006517          	auipc	a0,0x6
     43e:	a4650513          	add	a0,a0,-1466 # 5e80 <malloc+0x226>
     442:	00005097          	auipc	ra,0x5
     446:	760080e7          	jalr	1888(ra) # 5ba2 <printf>
      exit(1);
     44a:	4505                	li	a0,1
     44c:	00005097          	auipc	ra,0x5
     450:	3e6080e7          	jalr	998(ra) # 5832 <exit>
      printf("write(1, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     454:	862a                	mv	a2,a0
     456:	85ce                	mv	a1,s3
     458:	00006517          	auipc	a0,0x6
     45c:	a5850513          	add	a0,a0,-1448 # 5eb0 <malloc+0x256>
     460:	00005097          	auipc	ra,0x5
     464:	742080e7          	jalr	1858(ra) # 5ba2 <printf>
      exit(1);
     468:	4505                	li	a0,1
     46a:	00005097          	auipc	ra,0x5
     46e:	3c8080e7          	jalr	968(ra) # 5832 <exit>
      printf("pipe() failed\n");
     472:	00006517          	auipc	a0,0x6
     476:	a6e50513          	add	a0,a0,-1426 # 5ee0 <malloc+0x286>
     47a:	00005097          	auipc	ra,0x5
     47e:	728080e7          	jalr	1832(ra) # 5ba2 <printf>
      exit(1);
     482:	4505                	li	a0,1
     484:	00005097          	auipc	ra,0x5
     488:	3ae080e7          	jalr	942(ra) # 5832 <exit>
      printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     48c:	862a                	mv	a2,a0
     48e:	85ce                	mv	a1,s3
     490:	00006517          	auipc	a0,0x6
     494:	a6050513          	add	a0,a0,-1440 # 5ef0 <malloc+0x296>
     498:	00005097          	auipc	ra,0x5
     49c:	70a080e7          	jalr	1802(ra) # 5ba2 <printf>
      exit(1);
     4a0:	4505                	li	a0,1
     4a2:	00005097          	auipc	ra,0x5
     4a6:	390080e7          	jalr	912(ra) # 5832 <exit>

00000000000004aa <copyout>:
{
     4aa:	711d                	add	sp,sp,-96
     4ac:	ec86                	sd	ra,88(sp)
     4ae:	e8a2                	sd	s0,80(sp)
     4b0:	e4a6                	sd	s1,72(sp)
     4b2:	e0ca                	sd	s2,64(sp)
     4b4:	fc4e                	sd	s3,56(sp)
     4b6:	f852                	sd	s4,48(sp)
     4b8:	f456                	sd	s5,40(sp)
     4ba:	1080                	add	s0,sp,96
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     4bc:	4785                	li	a5,1
     4be:	07fe                	sll	a5,a5,0x1f
     4c0:	faf43823          	sd	a5,-80(s0)
     4c4:	57fd                	li	a5,-1
     4c6:	faf43c23          	sd	a5,-72(s0)
  for(int ai = 0; ai < 2; ai++){
     4ca:	fb040913          	add	s2,s0,-80
    int fd = open("README", 0);
     4ce:	00006a17          	auipc	s4,0x6
     4d2:	a52a0a13          	add	s4,s4,-1454 # 5f20 <malloc+0x2c6>
    n = write(fds[1], "x", 1);
     4d6:	00006a97          	auipc	s5,0x6
     4da:	912a8a93          	add	s5,s5,-1774 # 5de8 <malloc+0x18e>
    uint64 addr = addrs[ai];
     4de:	00093983          	ld	s3,0(s2)
    int fd = open("README", 0);
     4e2:	4581                	li	a1,0
     4e4:	8552                	mv	a0,s4
     4e6:	00005097          	auipc	ra,0x5
     4ea:	38c080e7          	jalr	908(ra) # 5872 <open>
     4ee:	84aa                	mv	s1,a0
    if(fd < 0){
     4f0:	08054663          	bltz	a0,57c <copyout+0xd2>
    int n = read(fd, (void*)addr, 8192);
     4f4:	6609                	lui	a2,0x2
     4f6:	85ce                	mv	a1,s3
     4f8:	00005097          	auipc	ra,0x5
     4fc:	352080e7          	jalr	850(ra) # 584a <read>
    if(n > 0){
     500:	08a04b63          	bgtz	a0,596 <copyout+0xec>
    close(fd);
     504:	8526                	mv	a0,s1
     506:	00005097          	auipc	ra,0x5
     50a:	354080e7          	jalr	852(ra) # 585a <close>
    if(pipe(fds) < 0){
     50e:	fa840513          	add	a0,s0,-88
     512:	00005097          	auipc	ra,0x5
     516:	330080e7          	jalr	816(ra) # 5842 <pipe>
     51a:	08054d63          	bltz	a0,5b4 <copyout+0x10a>
    n = write(fds[1], "x", 1);
     51e:	4605                	li	a2,1
     520:	85d6                	mv	a1,s5
     522:	fac42503          	lw	a0,-84(s0)
     526:	00005097          	auipc	ra,0x5
     52a:	32c080e7          	jalr	812(ra) # 5852 <write>
    if(n != 1){
     52e:	4785                	li	a5,1
     530:	08f51f63          	bne	a0,a5,5ce <copyout+0x124>
    n = read(fds[0], (void*)addr, 8192);
     534:	6609                	lui	a2,0x2
     536:	85ce                	mv	a1,s3
     538:	fa842503          	lw	a0,-88(s0)
     53c:	00005097          	auipc	ra,0x5
     540:	30e080e7          	jalr	782(ra) # 584a <read>
    if(n > 0){
     544:	0aa04263          	bgtz	a0,5e8 <copyout+0x13e>
    close(fds[0]);
     548:	fa842503          	lw	a0,-88(s0)
     54c:	00005097          	auipc	ra,0x5
     550:	30e080e7          	jalr	782(ra) # 585a <close>
    close(fds[1]);
     554:	fac42503          	lw	a0,-84(s0)
     558:	00005097          	auipc	ra,0x5
     55c:	302080e7          	jalr	770(ra) # 585a <close>
  for(int ai = 0; ai < 2; ai++){
     560:	0921                	add	s2,s2,8
     562:	fc040793          	add	a5,s0,-64
     566:	f6f91ce3          	bne	s2,a5,4de <copyout+0x34>
}
     56a:	60e6                	ld	ra,88(sp)
     56c:	6446                	ld	s0,80(sp)
     56e:	64a6                	ld	s1,72(sp)
     570:	6906                	ld	s2,64(sp)
     572:	79e2                	ld	s3,56(sp)
     574:	7a42                	ld	s4,48(sp)
     576:	7aa2                	ld	s5,40(sp)
     578:	6125                	add	sp,sp,96
     57a:	8082                	ret
      printf("open(README) failed\n");
     57c:	00006517          	auipc	a0,0x6
     580:	9ac50513          	add	a0,a0,-1620 # 5f28 <malloc+0x2ce>
     584:	00005097          	auipc	ra,0x5
     588:	61e080e7          	jalr	1566(ra) # 5ba2 <printf>
      exit(1);
     58c:	4505                	li	a0,1
     58e:	00005097          	auipc	ra,0x5
     592:	2a4080e7          	jalr	676(ra) # 5832 <exit>
      printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     596:	862a                	mv	a2,a0
     598:	85ce                	mv	a1,s3
     59a:	00006517          	auipc	a0,0x6
     59e:	9a650513          	add	a0,a0,-1626 # 5f40 <malloc+0x2e6>
     5a2:	00005097          	auipc	ra,0x5
     5a6:	600080e7          	jalr	1536(ra) # 5ba2 <printf>
      exit(1);
     5aa:	4505                	li	a0,1
     5ac:	00005097          	auipc	ra,0x5
     5b0:	286080e7          	jalr	646(ra) # 5832 <exit>
      printf("pipe() failed\n");
     5b4:	00006517          	auipc	a0,0x6
     5b8:	92c50513          	add	a0,a0,-1748 # 5ee0 <malloc+0x286>
     5bc:	00005097          	auipc	ra,0x5
     5c0:	5e6080e7          	jalr	1510(ra) # 5ba2 <printf>
      exit(1);
     5c4:	4505                	li	a0,1
     5c6:	00005097          	auipc	ra,0x5
     5ca:	26c080e7          	jalr	620(ra) # 5832 <exit>
      printf("pipe write failed\n");
     5ce:	00006517          	auipc	a0,0x6
     5d2:	9a250513          	add	a0,a0,-1630 # 5f70 <malloc+0x316>
     5d6:	00005097          	auipc	ra,0x5
     5da:	5cc080e7          	jalr	1484(ra) # 5ba2 <printf>
      exit(1);
     5de:	4505                	li	a0,1
     5e0:	00005097          	auipc	ra,0x5
     5e4:	252080e7          	jalr	594(ra) # 5832 <exit>
      printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     5e8:	862a                	mv	a2,a0
     5ea:	85ce                	mv	a1,s3
     5ec:	00006517          	auipc	a0,0x6
     5f0:	99c50513          	add	a0,a0,-1636 # 5f88 <malloc+0x32e>
     5f4:	00005097          	auipc	ra,0x5
     5f8:	5ae080e7          	jalr	1454(ra) # 5ba2 <printf>
      exit(1);
     5fc:	4505                	li	a0,1
     5fe:	00005097          	auipc	ra,0x5
     602:	234080e7          	jalr	564(ra) # 5832 <exit>

0000000000000606 <truncate1>:
{
     606:	711d                	add	sp,sp,-96
     608:	ec86                	sd	ra,88(sp)
     60a:	e8a2                	sd	s0,80(sp)
     60c:	e4a6                	sd	s1,72(sp)
     60e:	e0ca                	sd	s2,64(sp)
     610:	fc4e                	sd	s3,56(sp)
     612:	f852                	sd	s4,48(sp)
     614:	f456                	sd	s5,40(sp)
     616:	1080                	add	s0,sp,96
     618:	8aaa                	mv	s5,a0
  unlink("truncfile");
     61a:	00005517          	auipc	a0,0x5
     61e:	7b650513          	add	a0,a0,1974 # 5dd0 <malloc+0x176>
     622:	00005097          	auipc	ra,0x5
     626:	260080e7          	jalr	608(ra) # 5882 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     62a:	60100593          	li	a1,1537
     62e:	00005517          	auipc	a0,0x5
     632:	7a250513          	add	a0,a0,1954 # 5dd0 <malloc+0x176>
     636:	00005097          	auipc	ra,0x5
     63a:	23c080e7          	jalr	572(ra) # 5872 <open>
     63e:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     640:	4611                	li	a2,4
     642:	00005597          	auipc	a1,0x5
     646:	79e58593          	add	a1,a1,1950 # 5de0 <malloc+0x186>
     64a:	00005097          	auipc	ra,0x5
     64e:	208080e7          	jalr	520(ra) # 5852 <write>
  close(fd1);
     652:	8526                	mv	a0,s1
     654:	00005097          	auipc	ra,0x5
     658:	206080e7          	jalr	518(ra) # 585a <close>
  int fd2 = open("truncfile", O_RDONLY);
     65c:	4581                	li	a1,0
     65e:	00005517          	auipc	a0,0x5
     662:	77250513          	add	a0,a0,1906 # 5dd0 <malloc+0x176>
     666:	00005097          	auipc	ra,0x5
     66a:	20c080e7          	jalr	524(ra) # 5872 <open>
     66e:	84aa                	mv	s1,a0
  int n = read(fd2, buf, sizeof(buf));
     670:	02000613          	li	a2,32
     674:	fa040593          	add	a1,s0,-96
     678:	00005097          	auipc	ra,0x5
     67c:	1d2080e7          	jalr	466(ra) # 584a <read>
  if(n != 4){
     680:	4791                	li	a5,4
     682:	0cf51e63          	bne	a0,a5,75e <truncate1+0x158>
  fd1 = open("truncfile", O_WRONLY|O_TRUNC);
     686:	40100593          	li	a1,1025
     68a:	00005517          	auipc	a0,0x5
     68e:	74650513          	add	a0,a0,1862 # 5dd0 <malloc+0x176>
     692:	00005097          	auipc	ra,0x5
     696:	1e0080e7          	jalr	480(ra) # 5872 <open>
     69a:	89aa                	mv	s3,a0
  int fd3 = open("truncfile", O_RDONLY);
     69c:	4581                	li	a1,0
     69e:	00005517          	auipc	a0,0x5
     6a2:	73250513          	add	a0,a0,1842 # 5dd0 <malloc+0x176>
     6a6:	00005097          	auipc	ra,0x5
     6aa:	1cc080e7          	jalr	460(ra) # 5872 <open>
     6ae:	892a                	mv	s2,a0
  n = read(fd3, buf, sizeof(buf));
     6b0:	02000613          	li	a2,32
     6b4:	fa040593          	add	a1,s0,-96
     6b8:	00005097          	auipc	ra,0x5
     6bc:	192080e7          	jalr	402(ra) # 584a <read>
     6c0:	8a2a                	mv	s4,a0
  if(n != 0){
     6c2:	ed4d                	bnez	a0,77c <truncate1+0x176>
  n = read(fd2, buf, sizeof(buf));
     6c4:	02000613          	li	a2,32
     6c8:	fa040593          	add	a1,s0,-96
     6cc:	8526                	mv	a0,s1
     6ce:	00005097          	auipc	ra,0x5
     6d2:	17c080e7          	jalr	380(ra) # 584a <read>
     6d6:	8a2a                	mv	s4,a0
  if(n != 0){
     6d8:	e971                	bnez	a0,7ac <truncate1+0x1a6>
  write(fd1, "abcdef", 6);
     6da:	4619                	li	a2,6
     6dc:	00006597          	auipc	a1,0x6
     6e0:	93c58593          	add	a1,a1,-1732 # 6018 <malloc+0x3be>
     6e4:	854e                	mv	a0,s3
     6e6:	00005097          	auipc	ra,0x5
     6ea:	16c080e7          	jalr	364(ra) # 5852 <write>
  n = read(fd3, buf, sizeof(buf));
     6ee:	02000613          	li	a2,32
     6f2:	fa040593          	add	a1,s0,-96
     6f6:	854a                	mv	a0,s2
     6f8:	00005097          	auipc	ra,0x5
     6fc:	152080e7          	jalr	338(ra) # 584a <read>
  if(n != 6){
     700:	4799                	li	a5,6
     702:	0cf51d63          	bne	a0,a5,7dc <truncate1+0x1d6>
  n = read(fd2, buf, sizeof(buf));
     706:	02000613          	li	a2,32
     70a:	fa040593          	add	a1,s0,-96
     70e:	8526                	mv	a0,s1
     710:	00005097          	auipc	ra,0x5
     714:	13a080e7          	jalr	314(ra) # 584a <read>
  if(n != 2){
     718:	4789                	li	a5,2
     71a:	0ef51063          	bne	a0,a5,7fa <truncate1+0x1f4>
  unlink("truncfile");
     71e:	00005517          	auipc	a0,0x5
     722:	6b250513          	add	a0,a0,1714 # 5dd0 <malloc+0x176>
     726:	00005097          	auipc	ra,0x5
     72a:	15c080e7          	jalr	348(ra) # 5882 <unlink>
  close(fd1);
     72e:	854e                	mv	a0,s3
     730:	00005097          	auipc	ra,0x5
     734:	12a080e7          	jalr	298(ra) # 585a <close>
  close(fd2);
     738:	8526                	mv	a0,s1
     73a:	00005097          	auipc	ra,0x5
     73e:	120080e7          	jalr	288(ra) # 585a <close>
  close(fd3);
     742:	854a                	mv	a0,s2
     744:	00005097          	auipc	ra,0x5
     748:	116080e7          	jalr	278(ra) # 585a <close>
}
     74c:	60e6                	ld	ra,88(sp)
     74e:	6446                	ld	s0,80(sp)
     750:	64a6                	ld	s1,72(sp)
     752:	6906                	ld	s2,64(sp)
     754:	79e2                	ld	s3,56(sp)
     756:	7a42                	ld	s4,48(sp)
     758:	7aa2                	ld	s5,40(sp)
     75a:	6125                	add	sp,sp,96
     75c:	8082                	ret
    printf("%s: read %d bytes, wanted 4\n", s, n);
     75e:	862a                	mv	a2,a0
     760:	85d6                	mv	a1,s5
     762:	00006517          	auipc	a0,0x6
     766:	85650513          	add	a0,a0,-1962 # 5fb8 <malloc+0x35e>
     76a:	00005097          	auipc	ra,0x5
     76e:	438080e7          	jalr	1080(ra) # 5ba2 <printf>
    exit(1);
     772:	4505                	li	a0,1
     774:	00005097          	auipc	ra,0x5
     778:	0be080e7          	jalr	190(ra) # 5832 <exit>
    printf("aaa fd3=%d\n", fd3);
     77c:	85ca                	mv	a1,s2
     77e:	00006517          	auipc	a0,0x6
     782:	85a50513          	add	a0,a0,-1958 # 5fd8 <malloc+0x37e>
     786:	00005097          	auipc	ra,0x5
     78a:	41c080e7          	jalr	1052(ra) # 5ba2 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     78e:	8652                	mv	a2,s4
     790:	85d6                	mv	a1,s5
     792:	00006517          	auipc	a0,0x6
     796:	85650513          	add	a0,a0,-1962 # 5fe8 <malloc+0x38e>
     79a:	00005097          	auipc	ra,0x5
     79e:	408080e7          	jalr	1032(ra) # 5ba2 <printf>
    exit(1);
     7a2:	4505                	li	a0,1
     7a4:	00005097          	auipc	ra,0x5
     7a8:	08e080e7          	jalr	142(ra) # 5832 <exit>
    printf("bbb fd2=%d\n", fd2);
     7ac:	85a6                	mv	a1,s1
     7ae:	00006517          	auipc	a0,0x6
     7b2:	85a50513          	add	a0,a0,-1958 # 6008 <malloc+0x3ae>
     7b6:	00005097          	auipc	ra,0x5
     7ba:	3ec080e7          	jalr	1004(ra) # 5ba2 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     7be:	8652                	mv	a2,s4
     7c0:	85d6                	mv	a1,s5
     7c2:	00006517          	auipc	a0,0x6
     7c6:	82650513          	add	a0,a0,-2010 # 5fe8 <malloc+0x38e>
     7ca:	00005097          	auipc	ra,0x5
     7ce:	3d8080e7          	jalr	984(ra) # 5ba2 <printf>
    exit(1);
     7d2:	4505                	li	a0,1
     7d4:	00005097          	auipc	ra,0x5
     7d8:	05e080e7          	jalr	94(ra) # 5832 <exit>
    printf("%s: read %d bytes, wanted 6\n", s, n);
     7dc:	862a                	mv	a2,a0
     7de:	85d6                	mv	a1,s5
     7e0:	00006517          	auipc	a0,0x6
     7e4:	84050513          	add	a0,a0,-1984 # 6020 <malloc+0x3c6>
     7e8:	00005097          	auipc	ra,0x5
     7ec:	3ba080e7          	jalr	954(ra) # 5ba2 <printf>
    exit(1);
     7f0:	4505                	li	a0,1
     7f2:	00005097          	auipc	ra,0x5
     7f6:	040080e7          	jalr	64(ra) # 5832 <exit>
    printf("%s: read %d bytes, wanted 2\n", s, n);
     7fa:	862a                	mv	a2,a0
     7fc:	85d6                	mv	a1,s5
     7fe:	00006517          	auipc	a0,0x6
     802:	84250513          	add	a0,a0,-1982 # 6040 <malloc+0x3e6>
     806:	00005097          	auipc	ra,0x5
     80a:	39c080e7          	jalr	924(ra) # 5ba2 <printf>
    exit(1);
     80e:	4505                	li	a0,1
     810:	00005097          	auipc	ra,0x5
     814:	022080e7          	jalr	34(ra) # 5832 <exit>

0000000000000818 <writetest>:
{
     818:	7139                	add	sp,sp,-64
     81a:	fc06                	sd	ra,56(sp)
     81c:	f822                	sd	s0,48(sp)
     81e:	f426                	sd	s1,40(sp)
     820:	f04a                	sd	s2,32(sp)
     822:	ec4e                	sd	s3,24(sp)
     824:	e852                	sd	s4,16(sp)
     826:	e456                	sd	s5,8(sp)
     828:	e05a                	sd	s6,0(sp)
     82a:	0080                	add	s0,sp,64
     82c:	8b2a                	mv	s6,a0
  fd = open("small", O_CREATE|O_RDWR);
     82e:	20200593          	li	a1,514
     832:	00006517          	auipc	a0,0x6
     836:	82e50513          	add	a0,a0,-2002 # 6060 <malloc+0x406>
     83a:	00005097          	auipc	ra,0x5
     83e:	038080e7          	jalr	56(ra) # 5872 <open>
  if(fd < 0){
     842:	0a054d63          	bltz	a0,8fc <writetest+0xe4>
     846:	892a                	mv	s2,a0
     848:	4481                	li	s1,0
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     84a:	00006997          	auipc	s3,0x6
     84e:	83e98993          	add	s3,s3,-1986 # 6088 <malloc+0x42e>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     852:	00006a97          	auipc	s5,0x6
     856:	86ea8a93          	add	s5,s5,-1938 # 60c0 <malloc+0x466>
  for(i = 0; i < N; i++){
     85a:	06400a13          	li	s4,100
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     85e:	4629                	li	a2,10
     860:	85ce                	mv	a1,s3
     862:	854a                	mv	a0,s2
     864:	00005097          	auipc	ra,0x5
     868:	fee080e7          	jalr	-18(ra) # 5852 <write>
     86c:	47a9                	li	a5,10
     86e:	0af51563          	bne	a0,a5,918 <writetest+0x100>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     872:	4629                	li	a2,10
     874:	85d6                	mv	a1,s5
     876:	854a                	mv	a0,s2
     878:	00005097          	auipc	ra,0x5
     87c:	fda080e7          	jalr	-38(ra) # 5852 <write>
     880:	47a9                	li	a5,10
     882:	0af51a63          	bne	a0,a5,936 <writetest+0x11e>
  for(i = 0; i < N; i++){
     886:	2485                	addw	s1,s1,1
     888:	fd449be3          	bne	s1,s4,85e <writetest+0x46>
  close(fd);
     88c:	854a                	mv	a0,s2
     88e:	00005097          	auipc	ra,0x5
     892:	fcc080e7          	jalr	-52(ra) # 585a <close>
  fd = open("small", O_RDONLY);
     896:	4581                	li	a1,0
     898:	00005517          	auipc	a0,0x5
     89c:	7c850513          	add	a0,a0,1992 # 6060 <malloc+0x406>
     8a0:	00005097          	auipc	ra,0x5
     8a4:	fd2080e7          	jalr	-46(ra) # 5872 <open>
     8a8:	84aa                	mv	s1,a0
  if(fd < 0){
     8aa:	0a054563          	bltz	a0,954 <writetest+0x13c>
  i = read(fd, buf, N*SZ*2);
     8ae:	7d000613          	li	a2,2000
     8b2:	0000b597          	auipc	a1,0xb
     8b6:	50658593          	add	a1,a1,1286 # bdb8 <buf>
     8ba:	00005097          	auipc	ra,0x5
     8be:	f90080e7          	jalr	-112(ra) # 584a <read>
  if(i != N*SZ*2){
     8c2:	7d000793          	li	a5,2000
     8c6:	0af51563          	bne	a0,a5,970 <writetest+0x158>
  close(fd);
     8ca:	8526                	mv	a0,s1
     8cc:	00005097          	auipc	ra,0x5
     8d0:	f8e080e7          	jalr	-114(ra) # 585a <close>
  if(unlink("small") < 0){
     8d4:	00005517          	auipc	a0,0x5
     8d8:	78c50513          	add	a0,a0,1932 # 6060 <malloc+0x406>
     8dc:	00005097          	auipc	ra,0x5
     8e0:	fa6080e7          	jalr	-90(ra) # 5882 <unlink>
     8e4:	0a054463          	bltz	a0,98c <writetest+0x174>
}
     8e8:	70e2                	ld	ra,56(sp)
     8ea:	7442                	ld	s0,48(sp)
     8ec:	74a2                	ld	s1,40(sp)
     8ee:	7902                	ld	s2,32(sp)
     8f0:	69e2                	ld	s3,24(sp)
     8f2:	6a42                	ld	s4,16(sp)
     8f4:	6aa2                	ld	s5,8(sp)
     8f6:	6b02                	ld	s6,0(sp)
     8f8:	6121                	add	sp,sp,64
     8fa:	8082                	ret
    printf("%s: error: creat small failed!\n", s);
     8fc:	85da                	mv	a1,s6
     8fe:	00005517          	auipc	a0,0x5
     902:	76a50513          	add	a0,a0,1898 # 6068 <malloc+0x40e>
     906:	00005097          	auipc	ra,0x5
     90a:	29c080e7          	jalr	668(ra) # 5ba2 <printf>
    exit(1);
     90e:	4505                	li	a0,1
     910:	00005097          	auipc	ra,0x5
     914:	f22080e7          	jalr	-222(ra) # 5832 <exit>
      printf("%s: error: write aa %d new file failed\n", s, i);
     918:	8626                	mv	a2,s1
     91a:	85da                	mv	a1,s6
     91c:	00005517          	auipc	a0,0x5
     920:	77c50513          	add	a0,a0,1916 # 6098 <malloc+0x43e>
     924:	00005097          	auipc	ra,0x5
     928:	27e080e7          	jalr	638(ra) # 5ba2 <printf>
      exit(1);
     92c:	4505                	li	a0,1
     92e:	00005097          	auipc	ra,0x5
     932:	f04080e7          	jalr	-252(ra) # 5832 <exit>
      printf("%s: error: write bb %d new file failed\n", s, i);
     936:	8626                	mv	a2,s1
     938:	85da                	mv	a1,s6
     93a:	00005517          	auipc	a0,0x5
     93e:	79650513          	add	a0,a0,1942 # 60d0 <malloc+0x476>
     942:	00005097          	auipc	ra,0x5
     946:	260080e7          	jalr	608(ra) # 5ba2 <printf>
      exit(1);
     94a:	4505                	li	a0,1
     94c:	00005097          	auipc	ra,0x5
     950:	ee6080e7          	jalr	-282(ra) # 5832 <exit>
    printf("%s: error: open small failed!\n", s);
     954:	85da                	mv	a1,s6
     956:	00005517          	auipc	a0,0x5
     95a:	7a250513          	add	a0,a0,1954 # 60f8 <malloc+0x49e>
     95e:	00005097          	auipc	ra,0x5
     962:	244080e7          	jalr	580(ra) # 5ba2 <printf>
    exit(1);
     966:	4505                	li	a0,1
     968:	00005097          	auipc	ra,0x5
     96c:	eca080e7          	jalr	-310(ra) # 5832 <exit>
    printf("%s: read failed\n", s);
     970:	85da                	mv	a1,s6
     972:	00005517          	auipc	a0,0x5
     976:	7a650513          	add	a0,a0,1958 # 6118 <malloc+0x4be>
     97a:	00005097          	auipc	ra,0x5
     97e:	228080e7          	jalr	552(ra) # 5ba2 <printf>
    exit(1);
     982:	4505                	li	a0,1
     984:	00005097          	auipc	ra,0x5
     988:	eae080e7          	jalr	-338(ra) # 5832 <exit>
    printf("%s: unlink small failed\n", s);
     98c:	85da                	mv	a1,s6
     98e:	00005517          	auipc	a0,0x5
     992:	7a250513          	add	a0,a0,1954 # 6130 <malloc+0x4d6>
     996:	00005097          	auipc	ra,0x5
     99a:	20c080e7          	jalr	524(ra) # 5ba2 <printf>
    exit(1);
     99e:	4505                	li	a0,1
     9a0:	00005097          	auipc	ra,0x5
     9a4:	e92080e7          	jalr	-366(ra) # 5832 <exit>

00000000000009a8 <writebig>:
{
     9a8:	7139                	add	sp,sp,-64
     9aa:	fc06                	sd	ra,56(sp)
     9ac:	f822                	sd	s0,48(sp)
     9ae:	f426                	sd	s1,40(sp)
     9b0:	f04a                	sd	s2,32(sp)
     9b2:	ec4e                	sd	s3,24(sp)
     9b4:	e852                	sd	s4,16(sp)
     9b6:	e456                	sd	s5,8(sp)
     9b8:	0080                	add	s0,sp,64
     9ba:	8aaa                	mv	s5,a0
  fd = open("big", O_CREATE|O_RDWR);
     9bc:	20200593          	li	a1,514
     9c0:	00005517          	auipc	a0,0x5
     9c4:	79050513          	add	a0,a0,1936 # 6150 <malloc+0x4f6>
     9c8:	00005097          	auipc	ra,0x5
     9cc:	eaa080e7          	jalr	-342(ra) # 5872 <open>
     9d0:	89aa                	mv	s3,a0
  for(i = 0; i < MAXFILE; i++){
     9d2:	4481                	li	s1,0
    ((int*)buf)[0] = i;
     9d4:	0000b917          	auipc	s2,0xb
     9d8:	3e490913          	add	s2,s2,996 # bdb8 <buf>
  for(i = 0; i < MAXFILE; i++){
     9dc:	10c00a13          	li	s4,268
  if(fd < 0){
     9e0:	06054c63          	bltz	a0,a58 <writebig+0xb0>
    ((int*)buf)[0] = i;
     9e4:	00992023          	sw	s1,0(s2)
    if(write(fd, buf, BSIZE) != BSIZE){
     9e8:	40000613          	li	a2,1024
     9ec:	85ca                	mv	a1,s2
     9ee:	854e                	mv	a0,s3
     9f0:	00005097          	auipc	ra,0x5
     9f4:	e62080e7          	jalr	-414(ra) # 5852 <write>
     9f8:	40000793          	li	a5,1024
     9fc:	06f51c63          	bne	a0,a5,a74 <writebig+0xcc>
  for(i = 0; i < MAXFILE; i++){
     a00:	2485                	addw	s1,s1,1
     a02:	ff4491e3          	bne	s1,s4,9e4 <writebig+0x3c>
  close(fd);
     a06:	854e                	mv	a0,s3
     a08:	00005097          	auipc	ra,0x5
     a0c:	e52080e7          	jalr	-430(ra) # 585a <close>
  fd = open("big", O_RDONLY);
     a10:	4581                	li	a1,0
     a12:	00005517          	auipc	a0,0x5
     a16:	73e50513          	add	a0,a0,1854 # 6150 <malloc+0x4f6>
     a1a:	00005097          	auipc	ra,0x5
     a1e:	e58080e7          	jalr	-424(ra) # 5872 <open>
     a22:	89aa                	mv	s3,a0
  n = 0;
     a24:	4481                	li	s1,0
    i = read(fd, buf, BSIZE);
     a26:	0000b917          	auipc	s2,0xb
     a2a:	39290913          	add	s2,s2,914 # bdb8 <buf>
  if(fd < 0){
     a2e:	06054263          	bltz	a0,a92 <writebig+0xea>
    i = read(fd, buf, BSIZE);
     a32:	40000613          	li	a2,1024
     a36:	85ca                	mv	a1,s2
     a38:	854e                	mv	a0,s3
     a3a:	00005097          	auipc	ra,0x5
     a3e:	e10080e7          	jalr	-496(ra) # 584a <read>
    if(i == 0){
     a42:	c535                	beqz	a0,aae <writebig+0x106>
    } else if(i != BSIZE){
     a44:	40000793          	li	a5,1024
     a48:	0af51f63          	bne	a0,a5,b06 <writebig+0x15e>
    if(((int*)buf)[0] != n){
     a4c:	00092683          	lw	a3,0(s2)
     a50:	0c969a63          	bne	a3,s1,b24 <writebig+0x17c>
    n++;
     a54:	2485                	addw	s1,s1,1
    i = read(fd, buf, BSIZE);
     a56:	bff1                	j	a32 <writebig+0x8a>
    printf("%s: error: creat big failed!\n", s);
     a58:	85d6                	mv	a1,s5
     a5a:	00005517          	auipc	a0,0x5
     a5e:	6fe50513          	add	a0,a0,1790 # 6158 <malloc+0x4fe>
     a62:	00005097          	auipc	ra,0x5
     a66:	140080e7          	jalr	320(ra) # 5ba2 <printf>
    exit(1);
     a6a:	4505                	li	a0,1
     a6c:	00005097          	auipc	ra,0x5
     a70:	dc6080e7          	jalr	-570(ra) # 5832 <exit>
      printf("%s: error: write big file failed\n", s, i);
     a74:	8626                	mv	a2,s1
     a76:	85d6                	mv	a1,s5
     a78:	00005517          	auipc	a0,0x5
     a7c:	70050513          	add	a0,a0,1792 # 6178 <malloc+0x51e>
     a80:	00005097          	auipc	ra,0x5
     a84:	122080e7          	jalr	290(ra) # 5ba2 <printf>
      exit(1);
     a88:	4505                	li	a0,1
     a8a:	00005097          	auipc	ra,0x5
     a8e:	da8080e7          	jalr	-600(ra) # 5832 <exit>
    printf("%s: error: open big failed!\n", s);
     a92:	85d6                	mv	a1,s5
     a94:	00005517          	auipc	a0,0x5
     a98:	70c50513          	add	a0,a0,1804 # 61a0 <malloc+0x546>
     a9c:	00005097          	auipc	ra,0x5
     aa0:	106080e7          	jalr	262(ra) # 5ba2 <printf>
    exit(1);
     aa4:	4505                	li	a0,1
     aa6:	00005097          	auipc	ra,0x5
     aaa:	d8c080e7          	jalr	-628(ra) # 5832 <exit>
      if(n == MAXFILE - 1){
     aae:	10b00793          	li	a5,267
     ab2:	02f48a63          	beq	s1,a5,ae6 <writebig+0x13e>
  close(fd);
     ab6:	854e                	mv	a0,s3
     ab8:	00005097          	auipc	ra,0x5
     abc:	da2080e7          	jalr	-606(ra) # 585a <close>
  if(unlink("big") < 0){
     ac0:	00005517          	auipc	a0,0x5
     ac4:	69050513          	add	a0,a0,1680 # 6150 <malloc+0x4f6>
     ac8:	00005097          	auipc	ra,0x5
     acc:	dba080e7          	jalr	-582(ra) # 5882 <unlink>
     ad0:	06054963          	bltz	a0,b42 <writebig+0x19a>
}
     ad4:	70e2                	ld	ra,56(sp)
     ad6:	7442                	ld	s0,48(sp)
     ad8:	74a2                	ld	s1,40(sp)
     ada:	7902                	ld	s2,32(sp)
     adc:	69e2                	ld	s3,24(sp)
     ade:	6a42                	ld	s4,16(sp)
     ae0:	6aa2                	ld	s5,8(sp)
     ae2:	6121                	add	sp,sp,64
     ae4:	8082                	ret
        printf("%s: read only %d blocks from big", s, n);
     ae6:	10b00613          	li	a2,267
     aea:	85d6                	mv	a1,s5
     aec:	00005517          	auipc	a0,0x5
     af0:	6d450513          	add	a0,a0,1748 # 61c0 <malloc+0x566>
     af4:	00005097          	auipc	ra,0x5
     af8:	0ae080e7          	jalr	174(ra) # 5ba2 <printf>
        exit(1);
     afc:	4505                	li	a0,1
     afe:	00005097          	auipc	ra,0x5
     b02:	d34080e7          	jalr	-716(ra) # 5832 <exit>
      printf("%s: read failed %d\n", s, i);
     b06:	862a                	mv	a2,a0
     b08:	85d6                	mv	a1,s5
     b0a:	00005517          	auipc	a0,0x5
     b0e:	6de50513          	add	a0,a0,1758 # 61e8 <malloc+0x58e>
     b12:	00005097          	auipc	ra,0x5
     b16:	090080e7          	jalr	144(ra) # 5ba2 <printf>
      exit(1);
     b1a:	4505                	li	a0,1
     b1c:	00005097          	auipc	ra,0x5
     b20:	d16080e7          	jalr	-746(ra) # 5832 <exit>
      printf("%s: read content of block %d is %d\n", s,
     b24:	8626                	mv	a2,s1
     b26:	85d6                	mv	a1,s5
     b28:	00005517          	auipc	a0,0x5
     b2c:	6d850513          	add	a0,a0,1752 # 6200 <malloc+0x5a6>
     b30:	00005097          	auipc	ra,0x5
     b34:	072080e7          	jalr	114(ra) # 5ba2 <printf>
      exit(1);
     b38:	4505                	li	a0,1
     b3a:	00005097          	auipc	ra,0x5
     b3e:	cf8080e7          	jalr	-776(ra) # 5832 <exit>
    printf("%s: unlink big failed\n", s);
     b42:	85d6                	mv	a1,s5
     b44:	00005517          	auipc	a0,0x5
     b48:	6e450513          	add	a0,a0,1764 # 6228 <malloc+0x5ce>
     b4c:	00005097          	auipc	ra,0x5
     b50:	056080e7          	jalr	86(ra) # 5ba2 <printf>
    exit(1);
     b54:	4505                	li	a0,1
     b56:	00005097          	auipc	ra,0x5
     b5a:	cdc080e7          	jalr	-804(ra) # 5832 <exit>

0000000000000b5e <unlinkread>:
{
     b5e:	7179                	add	sp,sp,-48
     b60:	f406                	sd	ra,40(sp)
     b62:	f022                	sd	s0,32(sp)
     b64:	ec26                	sd	s1,24(sp)
     b66:	e84a                	sd	s2,16(sp)
     b68:	e44e                	sd	s3,8(sp)
     b6a:	1800                	add	s0,sp,48
     b6c:	89aa                	mv	s3,a0
  fd = open("unlinkread", O_CREATE | O_RDWR);
     b6e:	20200593          	li	a1,514
     b72:	00005517          	auipc	a0,0x5
     b76:	6ce50513          	add	a0,a0,1742 # 6240 <malloc+0x5e6>
     b7a:	00005097          	auipc	ra,0x5
     b7e:	cf8080e7          	jalr	-776(ra) # 5872 <open>
  if(fd < 0){
     b82:	0e054563          	bltz	a0,c6c <unlinkread+0x10e>
     b86:	84aa                	mv	s1,a0
  write(fd, "hello", SZ);
     b88:	4615                	li	a2,5
     b8a:	00005597          	auipc	a1,0x5
     b8e:	6e658593          	add	a1,a1,1766 # 6270 <malloc+0x616>
     b92:	00005097          	auipc	ra,0x5
     b96:	cc0080e7          	jalr	-832(ra) # 5852 <write>
  close(fd);
     b9a:	8526                	mv	a0,s1
     b9c:	00005097          	auipc	ra,0x5
     ba0:	cbe080e7          	jalr	-834(ra) # 585a <close>
  fd = open("unlinkread", O_RDWR);
     ba4:	4589                	li	a1,2
     ba6:	00005517          	auipc	a0,0x5
     baa:	69a50513          	add	a0,a0,1690 # 6240 <malloc+0x5e6>
     bae:	00005097          	auipc	ra,0x5
     bb2:	cc4080e7          	jalr	-828(ra) # 5872 <open>
     bb6:	84aa                	mv	s1,a0
  if(fd < 0){
     bb8:	0c054863          	bltz	a0,c88 <unlinkread+0x12a>
  if(unlink("unlinkread") != 0){
     bbc:	00005517          	auipc	a0,0x5
     bc0:	68450513          	add	a0,a0,1668 # 6240 <malloc+0x5e6>
     bc4:	00005097          	auipc	ra,0x5
     bc8:	cbe080e7          	jalr	-834(ra) # 5882 <unlink>
     bcc:	ed61                	bnez	a0,ca4 <unlinkread+0x146>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
     bce:	20200593          	li	a1,514
     bd2:	00005517          	auipc	a0,0x5
     bd6:	66e50513          	add	a0,a0,1646 # 6240 <malloc+0x5e6>
     bda:	00005097          	auipc	ra,0x5
     bde:	c98080e7          	jalr	-872(ra) # 5872 <open>
     be2:	892a                	mv	s2,a0
  write(fd1, "yyy", 3);
     be4:	460d                	li	a2,3
     be6:	00005597          	auipc	a1,0x5
     bea:	6d258593          	add	a1,a1,1746 # 62b8 <malloc+0x65e>
     bee:	00005097          	auipc	ra,0x5
     bf2:	c64080e7          	jalr	-924(ra) # 5852 <write>
  close(fd1);
     bf6:	854a                	mv	a0,s2
     bf8:	00005097          	auipc	ra,0x5
     bfc:	c62080e7          	jalr	-926(ra) # 585a <close>
  if(read(fd, buf, sizeof(buf)) != SZ){
     c00:	660d                	lui	a2,0x3
     c02:	0000b597          	auipc	a1,0xb
     c06:	1b658593          	add	a1,a1,438 # bdb8 <buf>
     c0a:	8526                	mv	a0,s1
     c0c:	00005097          	auipc	ra,0x5
     c10:	c3e080e7          	jalr	-962(ra) # 584a <read>
     c14:	4795                	li	a5,5
     c16:	0af51563          	bne	a0,a5,cc0 <unlinkread+0x162>
  if(buf[0] != 'h'){
     c1a:	0000b717          	auipc	a4,0xb
     c1e:	19e74703          	lbu	a4,414(a4) # bdb8 <buf>
     c22:	06800793          	li	a5,104
     c26:	0af71b63          	bne	a4,a5,cdc <unlinkread+0x17e>
  if(write(fd, buf, 10) != 10){
     c2a:	4629                	li	a2,10
     c2c:	0000b597          	auipc	a1,0xb
     c30:	18c58593          	add	a1,a1,396 # bdb8 <buf>
     c34:	8526                	mv	a0,s1
     c36:	00005097          	auipc	ra,0x5
     c3a:	c1c080e7          	jalr	-996(ra) # 5852 <write>
     c3e:	47a9                	li	a5,10
     c40:	0af51c63          	bne	a0,a5,cf8 <unlinkread+0x19a>
  close(fd);
     c44:	8526                	mv	a0,s1
     c46:	00005097          	auipc	ra,0x5
     c4a:	c14080e7          	jalr	-1004(ra) # 585a <close>
  unlink("unlinkread");
     c4e:	00005517          	auipc	a0,0x5
     c52:	5f250513          	add	a0,a0,1522 # 6240 <malloc+0x5e6>
     c56:	00005097          	auipc	ra,0x5
     c5a:	c2c080e7          	jalr	-980(ra) # 5882 <unlink>
}
     c5e:	70a2                	ld	ra,40(sp)
     c60:	7402                	ld	s0,32(sp)
     c62:	64e2                	ld	s1,24(sp)
     c64:	6942                	ld	s2,16(sp)
     c66:	69a2                	ld	s3,8(sp)
     c68:	6145                	add	sp,sp,48
     c6a:	8082                	ret
    printf("%s: create unlinkread failed\n", s);
     c6c:	85ce                	mv	a1,s3
     c6e:	00005517          	auipc	a0,0x5
     c72:	5e250513          	add	a0,a0,1506 # 6250 <malloc+0x5f6>
     c76:	00005097          	auipc	ra,0x5
     c7a:	f2c080e7          	jalr	-212(ra) # 5ba2 <printf>
    exit(1);
     c7e:	4505                	li	a0,1
     c80:	00005097          	auipc	ra,0x5
     c84:	bb2080e7          	jalr	-1102(ra) # 5832 <exit>
    printf("%s: open unlinkread failed\n", s);
     c88:	85ce                	mv	a1,s3
     c8a:	00005517          	auipc	a0,0x5
     c8e:	5ee50513          	add	a0,a0,1518 # 6278 <malloc+0x61e>
     c92:	00005097          	auipc	ra,0x5
     c96:	f10080e7          	jalr	-240(ra) # 5ba2 <printf>
    exit(1);
     c9a:	4505                	li	a0,1
     c9c:	00005097          	auipc	ra,0x5
     ca0:	b96080e7          	jalr	-1130(ra) # 5832 <exit>
    printf("%s: unlink unlinkread failed\n", s);
     ca4:	85ce                	mv	a1,s3
     ca6:	00005517          	auipc	a0,0x5
     caa:	5f250513          	add	a0,a0,1522 # 6298 <malloc+0x63e>
     cae:	00005097          	auipc	ra,0x5
     cb2:	ef4080e7          	jalr	-268(ra) # 5ba2 <printf>
    exit(1);
     cb6:	4505                	li	a0,1
     cb8:	00005097          	auipc	ra,0x5
     cbc:	b7a080e7          	jalr	-1158(ra) # 5832 <exit>
    printf("%s: unlinkread read failed", s);
     cc0:	85ce                	mv	a1,s3
     cc2:	00005517          	auipc	a0,0x5
     cc6:	5fe50513          	add	a0,a0,1534 # 62c0 <malloc+0x666>
     cca:	00005097          	auipc	ra,0x5
     cce:	ed8080e7          	jalr	-296(ra) # 5ba2 <printf>
    exit(1);
     cd2:	4505                	li	a0,1
     cd4:	00005097          	auipc	ra,0x5
     cd8:	b5e080e7          	jalr	-1186(ra) # 5832 <exit>
    printf("%s: unlinkread wrong data\n", s);
     cdc:	85ce                	mv	a1,s3
     cde:	00005517          	auipc	a0,0x5
     ce2:	60250513          	add	a0,a0,1538 # 62e0 <malloc+0x686>
     ce6:	00005097          	auipc	ra,0x5
     cea:	ebc080e7          	jalr	-324(ra) # 5ba2 <printf>
    exit(1);
     cee:	4505                	li	a0,1
     cf0:	00005097          	auipc	ra,0x5
     cf4:	b42080e7          	jalr	-1214(ra) # 5832 <exit>
    printf("%s: unlinkread write failed\n", s);
     cf8:	85ce                	mv	a1,s3
     cfa:	00005517          	auipc	a0,0x5
     cfe:	60650513          	add	a0,a0,1542 # 6300 <malloc+0x6a6>
     d02:	00005097          	auipc	ra,0x5
     d06:	ea0080e7          	jalr	-352(ra) # 5ba2 <printf>
    exit(1);
     d0a:	4505                	li	a0,1
     d0c:	00005097          	auipc	ra,0x5
     d10:	b26080e7          	jalr	-1242(ra) # 5832 <exit>

0000000000000d14 <linktest>:
{
     d14:	1101                	add	sp,sp,-32
     d16:	ec06                	sd	ra,24(sp)
     d18:	e822                	sd	s0,16(sp)
     d1a:	e426                	sd	s1,8(sp)
     d1c:	e04a                	sd	s2,0(sp)
     d1e:	1000                	add	s0,sp,32
     d20:	892a                	mv	s2,a0
  unlink("lf1");
     d22:	00005517          	auipc	a0,0x5
     d26:	5fe50513          	add	a0,a0,1534 # 6320 <malloc+0x6c6>
     d2a:	00005097          	auipc	ra,0x5
     d2e:	b58080e7          	jalr	-1192(ra) # 5882 <unlink>
  unlink("lf2");
     d32:	00005517          	auipc	a0,0x5
     d36:	5f650513          	add	a0,a0,1526 # 6328 <malloc+0x6ce>
     d3a:	00005097          	auipc	ra,0x5
     d3e:	b48080e7          	jalr	-1208(ra) # 5882 <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
     d42:	20200593          	li	a1,514
     d46:	00005517          	auipc	a0,0x5
     d4a:	5da50513          	add	a0,a0,1498 # 6320 <malloc+0x6c6>
     d4e:	00005097          	auipc	ra,0x5
     d52:	b24080e7          	jalr	-1244(ra) # 5872 <open>
  if(fd < 0){
     d56:	10054763          	bltz	a0,e64 <linktest+0x150>
     d5a:	84aa                	mv	s1,a0
  if(write(fd, "hello", SZ) != SZ){
     d5c:	4615                	li	a2,5
     d5e:	00005597          	auipc	a1,0x5
     d62:	51258593          	add	a1,a1,1298 # 6270 <malloc+0x616>
     d66:	00005097          	auipc	ra,0x5
     d6a:	aec080e7          	jalr	-1300(ra) # 5852 <write>
     d6e:	4795                	li	a5,5
     d70:	10f51863          	bne	a0,a5,e80 <linktest+0x16c>
  close(fd);
     d74:	8526                	mv	a0,s1
     d76:	00005097          	auipc	ra,0x5
     d7a:	ae4080e7          	jalr	-1308(ra) # 585a <close>
  if(link("lf1", "lf2") < 0){
     d7e:	00005597          	auipc	a1,0x5
     d82:	5aa58593          	add	a1,a1,1450 # 6328 <malloc+0x6ce>
     d86:	00005517          	auipc	a0,0x5
     d8a:	59a50513          	add	a0,a0,1434 # 6320 <malloc+0x6c6>
     d8e:	00005097          	auipc	ra,0x5
     d92:	b04080e7          	jalr	-1276(ra) # 5892 <link>
     d96:	10054363          	bltz	a0,e9c <linktest+0x188>
  unlink("lf1");
     d9a:	00005517          	auipc	a0,0x5
     d9e:	58650513          	add	a0,a0,1414 # 6320 <malloc+0x6c6>
     da2:	00005097          	auipc	ra,0x5
     da6:	ae0080e7          	jalr	-1312(ra) # 5882 <unlink>
  if(open("lf1", 0) >= 0){
     daa:	4581                	li	a1,0
     dac:	00005517          	auipc	a0,0x5
     db0:	57450513          	add	a0,a0,1396 # 6320 <malloc+0x6c6>
     db4:	00005097          	auipc	ra,0x5
     db8:	abe080e7          	jalr	-1346(ra) # 5872 <open>
     dbc:	0e055e63          	bgez	a0,eb8 <linktest+0x1a4>
  fd = open("lf2", 0);
     dc0:	4581                	li	a1,0
     dc2:	00005517          	auipc	a0,0x5
     dc6:	56650513          	add	a0,a0,1382 # 6328 <malloc+0x6ce>
     dca:	00005097          	auipc	ra,0x5
     dce:	aa8080e7          	jalr	-1368(ra) # 5872 <open>
     dd2:	84aa                	mv	s1,a0
  if(fd < 0){
     dd4:	10054063          	bltz	a0,ed4 <linktest+0x1c0>
  if(read(fd, buf, sizeof(buf)) != SZ){
     dd8:	660d                	lui	a2,0x3
     dda:	0000b597          	auipc	a1,0xb
     dde:	fde58593          	add	a1,a1,-34 # bdb8 <buf>
     de2:	00005097          	auipc	ra,0x5
     de6:	a68080e7          	jalr	-1432(ra) # 584a <read>
     dea:	4795                	li	a5,5
     dec:	10f51263          	bne	a0,a5,ef0 <linktest+0x1dc>
  close(fd);
     df0:	8526                	mv	a0,s1
     df2:	00005097          	auipc	ra,0x5
     df6:	a68080e7          	jalr	-1432(ra) # 585a <close>
  if(link("lf2", "lf2") >= 0){
     dfa:	00005597          	auipc	a1,0x5
     dfe:	52e58593          	add	a1,a1,1326 # 6328 <malloc+0x6ce>
     e02:	852e                	mv	a0,a1
     e04:	00005097          	auipc	ra,0x5
     e08:	a8e080e7          	jalr	-1394(ra) # 5892 <link>
     e0c:	10055063          	bgez	a0,f0c <linktest+0x1f8>
  unlink("lf2");
     e10:	00005517          	auipc	a0,0x5
     e14:	51850513          	add	a0,a0,1304 # 6328 <malloc+0x6ce>
     e18:	00005097          	auipc	ra,0x5
     e1c:	a6a080e7          	jalr	-1430(ra) # 5882 <unlink>
  if(link("lf2", "lf1") >= 0){
     e20:	00005597          	auipc	a1,0x5
     e24:	50058593          	add	a1,a1,1280 # 6320 <malloc+0x6c6>
     e28:	00005517          	auipc	a0,0x5
     e2c:	50050513          	add	a0,a0,1280 # 6328 <malloc+0x6ce>
     e30:	00005097          	auipc	ra,0x5
     e34:	a62080e7          	jalr	-1438(ra) # 5892 <link>
     e38:	0e055863          	bgez	a0,f28 <linktest+0x214>
  if(link(".", "lf1") >= 0){
     e3c:	00005597          	auipc	a1,0x5
     e40:	4e458593          	add	a1,a1,1252 # 6320 <malloc+0x6c6>
     e44:	00005517          	auipc	a0,0x5
     e48:	5ec50513          	add	a0,a0,1516 # 6430 <malloc+0x7d6>
     e4c:	00005097          	auipc	ra,0x5
     e50:	a46080e7          	jalr	-1466(ra) # 5892 <link>
     e54:	0e055863          	bgez	a0,f44 <linktest+0x230>
}
     e58:	60e2                	ld	ra,24(sp)
     e5a:	6442                	ld	s0,16(sp)
     e5c:	64a2                	ld	s1,8(sp)
     e5e:	6902                	ld	s2,0(sp)
     e60:	6105                	add	sp,sp,32
     e62:	8082                	ret
    printf("%s: create lf1 failed\n", s);
     e64:	85ca                	mv	a1,s2
     e66:	00005517          	auipc	a0,0x5
     e6a:	4ca50513          	add	a0,a0,1226 # 6330 <malloc+0x6d6>
     e6e:	00005097          	auipc	ra,0x5
     e72:	d34080e7          	jalr	-716(ra) # 5ba2 <printf>
    exit(1);
     e76:	4505                	li	a0,1
     e78:	00005097          	auipc	ra,0x5
     e7c:	9ba080e7          	jalr	-1606(ra) # 5832 <exit>
    printf("%s: write lf1 failed\n", s);
     e80:	85ca                	mv	a1,s2
     e82:	00005517          	auipc	a0,0x5
     e86:	4c650513          	add	a0,a0,1222 # 6348 <malloc+0x6ee>
     e8a:	00005097          	auipc	ra,0x5
     e8e:	d18080e7          	jalr	-744(ra) # 5ba2 <printf>
    exit(1);
     e92:	4505                	li	a0,1
     e94:	00005097          	auipc	ra,0x5
     e98:	99e080e7          	jalr	-1634(ra) # 5832 <exit>
    printf("%s: link lf1 lf2 failed\n", s);
     e9c:	85ca                	mv	a1,s2
     e9e:	00005517          	auipc	a0,0x5
     ea2:	4c250513          	add	a0,a0,1218 # 6360 <malloc+0x706>
     ea6:	00005097          	auipc	ra,0x5
     eaa:	cfc080e7          	jalr	-772(ra) # 5ba2 <printf>
    exit(1);
     eae:	4505                	li	a0,1
     eb0:	00005097          	auipc	ra,0x5
     eb4:	982080e7          	jalr	-1662(ra) # 5832 <exit>
    printf("%s: unlinked lf1 but it is still there!\n", s);
     eb8:	85ca                	mv	a1,s2
     eba:	00005517          	auipc	a0,0x5
     ebe:	4c650513          	add	a0,a0,1222 # 6380 <malloc+0x726>
     ec2:	00005097          	auipc	ra,0x5
     ec6:	ce0080e7          	jalr	-800(ra) # 5ba2 <printf>
    exit(1);
     eca:	4505                	li	a0,1
     ecc:	00005097          	auipc	ra,0x5
     ed0:	966080e7          	jalr	-1690(ra) # 5832 <exit>
    printf("%s: open lf2 failed\n", s);
     ed4:	85ca                	mv	a1,s2
     ed6:	00005517          	auipc	a0,0x5
     eda:	4da50513          	add	a0,a0,1242 # 63b0 <malloc+0x756>
     ede:	00005097          	auipc	ra,0x5
     ee2:	cc4080e7          	jalr	-828(ra) # 5ba2 <printf>
    exit(1);
     ee6:	4505                	li	a0,1
     ee8:	00005097          	auipc	ra,0x5
     eec:	94a080e7          	jalr	-1718(ra) # 5832 <exit>
    printf("%s: read lf2 failed\n", s);
     ef0:	85ca                	mv	a1,s2
     ef2:	00005517          	auipc	a0,0x5
     ef6:	4d650513          	add	a0,a0,1238 # 63c8 <malloc+0x76e>
     efa:	00005097          	auipc	ra,0x5
     efe:	ca8080e7          	jalr	-856(ra) # 5ba2 <printf>
    exit(1);
     f02:	4505                	li	a0,1
     f04:	00005097          	auipc	ra,0x5
     f08:	92e080e7          	jalr	-1746(ra) # 5832 <exit>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
     f0c:	85ca                	mv	a1,s2
     f0e:	00005517          	auipc	a0,0x5
     f12:	4d250513          	add	a0,a0,1234 # 63e0 <malloc+0x786>
     f16:	00005097          	auipc	ra,0x5
     f1a:	c8c080e7          	jalr	-884(ra) # 5ba2 <printf>
    exit(1);
     f1e:	4505                	li	a0,1
     f20:	00005097          	auipc	ra,0x5
     f24:	912080e7          	jalr	-1774(ra) # 5832 <exit>
    printf("%s: link non-existent succeeded! oops\n", s);
     f28:	85ca                	mv	a1,s2
     f2a:	00005517          	auipc	a0,0x5
     f2e:	4de50513          	add	a0,a0,1246 # 6408 <malloc+0x7ae>
     f32:	00005097          	auipc	ra,0x5
     f36:	c70080e7          	jalr	-912(ra) # 5ba2 <printf>
    exit(1);
     f3a:	4505                	li	a0,1
     f3c:	00005097          	auipc	ra,0x5
     f40:	8f6080e7          	jalr	-1802(ra) # 5832 <exit>
    printf("%s: link . lf1 succeeded! oops\n", s);
     f44:	85ca                	mv	a1,s2
     f46:	00005517          	auipc	a0,0x5
     f4a:	4f250513          	add	a0,a0,1266 # 6438 <malloc+0x7de>
     f4e:	00005097          	auipc	ra,0x5
     f52:	c54080e7          	jalr	-940(ra) # 5ba2 <printf>
    exit(1);
     f56:	4505                	li	a0,1
     f58:	00005097          	auipc	ra,0x5
     f5c:	8da080e7          	jalr	-1830(ra) # 5832 <exit>

0000000000000f60 <bigdir>:
{
     f60:	715d                	add	sp,sp,-80
     f62:	e486                	sd	ra,72(sp)
     f64:	e0a2                	sd	s0,64(sp)
     f66:	fc26                	sd	s1,56(sp)
     f68:	f84a                	sd	s2,48(sp)
     f6a:	f44e                	sd	s3,40(sp)
     f6c:	f052                	sd	s4,32(sp)
     f6e:	ec56                	sd	s5,24(sp)
     f70:	e85a                	sd	s6,16(sp)
     f72:	0880                	add	s0,sp,80
     f74:	89aa                	mv	s3,a0
  unlink("bd");
     f76:	00005517          	auipc	a0,0x5
     f7a:	4e250513          	add	a0,a0,1250 # 6458 <malloc+0x7fe>
     f7e:	00005097          	auipc	ra,0x5
     f82:	904080e7          	jalr	-1788(ra) # 5882 <unlink>
  fd = open("bd", O_CREATE);
     f86:	20000593          	li	a1,512
     f8a:	00005517          	auipc	a0,0x5
     f8e:	4ce50513          	add	a0,a0,1230 # 6458 <malloc+0x7fe>
     f92:	00005097          	auipc	ra,0x5
     f96:	8e0080e7          	jalr	-1824(ra) # 5872 <open>
  if(fd < 0){
     f9a:	0c054963          	bltz	a0,106c <bigdir+0x10c>
  close(fd);
     f9e:	00005097          	auipc	ra,0x5
     fa2:	8bc080e7          	jalr	-1860(ra) # 585a <close>
  for(i = 0; i < N; i++){
     fa6:	4901                	li	s2,0
    name[0] = 'x';
     fa8:	07800a93          	li	s5,120
    if(link("bd", name) != 0){
     fac:	00005a17          	auipc	s4,0x5
     fb0:	4aca0a13          	add	s4,s4,1196 # 6458 <malloc+0x7fe>
  for(i = 0; i < N; i++){
     fb4:	1f400b13          	li	s6,500
    name[0] = 'x';
     fb8:	fb540823          	sb	s5,-80(s0)
    name[1] = '0' + (i / 64);
     fbc:	41f9571b          	sraw	a4,s2,0x1f
     fc0:	01a7571b          	srlw	a4,a4,0x1a
     fc4:	012707bb          	addw	a5,a4,s2
     fc8:	4067d69b          	sraw	a3,a5,0x6
     fcc:	0306869b          	addw	a3,a3,48
     fd0:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
     fd4:	03f7f793          	and	a5,a5,63
     fd8:	9f99                	subw	a5,a5,a4
     fda:	0307879b          	addw	a5,a5,48
     fde:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
     fe2:	fa0409a3          	sb	zero,-77(s0)
    if(link("bd", name) != 0){
     fe6:	fb040593          	add	a1,s0,-80
     fea:	8552                	mv	a0,s4
     fec:	00005097          	auipc	ra,0x5
     ff0:	8a6080e7          	jalr	-1882(ra) # 5892 <link>
     ff4:	84aa                	mv	s1,a0
     ff6:	e949                	bnez	a0,1088 <bigdir+0x128>
  for(i = 0; i < N; i++){
     ff8:	2905                	addw	s2,s2,1
     ffa:	fb691fe3          	bne	s2,s6,fb8 <bigdir+0x58>
  unlink("bd");
     ffe:	00005517          	auipc	a0,0x5
    1002:	45a50513          	add	a0,a0,1114 # 6458 <malloc+0x7fe>
    1006:	00005097          	auipc	ra,0x5
    100a:	87c080e7          	jalr	-1924(ra) # 5882 <unlink>
    name[0] = 'x';
    100e:	07800913          	li	s2,120
  for(i = 0; i < N; i++){
    1012:	1f400a13          	li	s4,500
    name[0] = 'x';
    1016:	fb240823          	sb	s2,-80(s0)
    name[1] = '0' + (i / 64);
    101a:	41f4d71b          	sraw	a4,s1,0x1f
    101e:	01a7571b          	srlw	a4,a4,0x1a
    1022:	009707bb          	addw	a5,a4,s1
    1026:	4067d69b          	sraw	a3,a5,0x6
    102a:	0306869b          	addw	a3,a3,48
    102e:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
    1032:	03f7f793          	and	a5,a5,63
    1036:	9f99                	subw	a5,a5,a4
    1038:	0307879b          	addw	a5,a5,48
    103c:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
    1040:	fa0409a3          	sb	zero,-77(s0)
    if(unlink(name) != 0){
    1044:	fb040513          	add	a0,s0,-80
    1048:	00005097          	auipc	ra,0x5
    104c:	83a080e7          	jalr	-1990(ra) # 5882 <unlink>
    1050:	ed21                	bnez	a0,10a8 <bigdir+0x148>
  for(i = 0; i < N; i++){
    1052:	2485                	addw	s1,s1,1
    1054:	fd4491e3          	bne	s1,s4,1016 <bigdir+0xb6>
}
    1058:	60a6                	ld	ra,72(sp)
    105a:	6406                	ld	s0,64(sp)
    105c:	74e2                	ld	s1,56(sp)
    105e:	7942                	ld	s2,48(sp)
    1060:	79a2                	ld	s3,40(sp)
    1062:	7a02                	ld	s4,32(sp)
    1064:	6ae2                	ld	s5,24(sp)
    1066:	6b42                	ld	s6,16(sp)
    1068:	6161                	add	sp,sp,80
    106a:	8082                	ret
    printf("%s: bigdir create failed\n", s);
    106c:	85ce                	mv	a1,s3
    106e:	00005517          	auipc	a0,0x5
    1072:	3f250513          	add	a0,a0,1010 # 6460 <malloc+0x806>
    1076:	00005097          	auipc	ra,0x5
    107a:	b2c080e7          	jalr	-1236(ra) # 5ba2 <printf>
    exit(1);
    107e:	4505                	li	a0,1
    1080:	00004097          	auipc	ra,0x4
    1084:	7b2080e7          	jalr	1970(ra) # 5832 <exit>
      printf("%s: bigdir link(bd, %s) failed\n", s, name);
    1088:	fb040613          	add	a2,s0,-80
    108c:	85ce                	mv	a1,s3
    108e:	00005517          	auipc	a0,0x5
    1092:	3f250513          	add	a0,a0,1010 # 6480 <malloc+0x826>
    1096:	00005097          	auipc	ra,0x5
    109a:	b0c080e7          	jalr	-1268(ra) # 5ba2 <printf>
      exit(1);
    109e:	4505                	li	a0,1
    10a0:	00004097          	auipc	ra,0x4
    10a4:	792080e7          	jalr	1938(ra) # 5832 <exit>
      printf("%s: bigdir unlink failed", s);
    10a8:	85ce                	mv	a1,s3
    10aa:	00005517          	auipc	a0,0x5
    10ae:	3f650513          	add	a0,a0,1014 # 64a0 <malloc+0x846>
    10b2:	00005097          	auipc	ra,0x5
    10b6:	af0080e7          	jalr	-1296(ra) # 5ba2 <printf>
      exit(1);
    10ba:	4505                	li	a0,1
    10bc:	00004097          	auipc	ra,0x4
    10c0:	776080e7          	jalr	1910(ra) # 5832 <exit>

00000000000010c4 <validatetest>:
{
    10c4:	7139                	add	sp,sp,-64
    10c6:	fc06                	sd	ra,56(sp)
    10c8:	f822                	sd	s0,48(sp)
    10ca:	f426                	sd	s1,40(sp)
    10cc:	f04a                	sd	s2,32(sp)
    10ce:	ec4e                	sd	s3,24(sp)
    10d0:	e852                	sd	s4,16(sp)
    10d2:	e456                	sd	s5,8(sp)
    10d4:	e05a                	sd	s6,0(sp)
    10d6:	0080                	add	s0,sp,64
    10d8:	8b2a                	mv	s6,a0
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    10da:	4481                	li	s1,0
    if(link("nosuchfile", (char*)p) != -1){
    10dc:	00005997          	auipc	s3,0x5
    10e0:	3e498993          	add	s3,s3,996 # 64c0 <malloc+0x866>
    10e4:	597d                	li	s2,-1
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    10e6:	6a85                	lui	s5,0x1
    10e8:	00114a37          	lui	s4,0x114
    if(link("nosuchfile", (char*)p) != -1){
    10ec:	85a6                	mv	a1,s1
    10ee:	854e                	mv	a0,s3
    10f0:	00004097          	auipc	ra,0x4
    10f4:	7a2080e7          	jalr	1954(ra) # 5892 <link>
    10f8:	01251f63          	bne	a0,s2,1116 <validatetest+0x52>
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    10fc:	94d6                	add	s1,s1,s5
    10fe:	ff4497e3          	bne	s1,s4,10ec <validatetest+0x28>
}
    1102:	70e2                	ld	ra,56(sp)
    1104:	7442                	ld	s0,48(sp)
    1106:	74a2                	ld	s1,40(sp)
    1108:	7902                	ld	s2,32(sp)
    110a:	69e2                	ld	s3,24(sp)
    110c:	6a42                	ld	s4,16(sp)
    110e:	6aa2                	ld	s5,8(sp)
    1110:	6b02                	ld	s6,0(sp)
    1112:	6121                	add	sp,sp,64
    1114:	8082                	ret
      printf("%s: link should not succeed\n", s);
    1116:	85da                	mv	a1,s6
    1118:	00005517          	auipc	a0,0x5
    111c:	3b850513          	add	a0,a0,952 # 64d0 <malloc+0x876>
    1120:	00005097          	auipc	ra,0x5
    1124:	a82080e7          	jalr	-1406(ra) # 5ba2 <printf>
      exit(1);
    1128:	4505                	li	a0,1
    112a:	00004097          	auipc	ra,0x4
    112e:	708080e7          	jalr	1800(ra) # 5832 <exit>

0000000000001132 <pgbug>:
// regression test. copyin(), copyout(), and copyinstr() used to cast
// the virtual page address to uint, which (with certain wild system
// call arguments) resulted in a kernel page faults.
void
pgbug(char *s)
{
    1132:	7179                	add	sp,sp,-48
    1134:	f406                	sd	ra,40(sp)
    1136:	f022                	sd	s0,32(sp)
    1138:	ec26                	sd	s1,24(sp)
    113a:	1800                	add	s0,sp,48
  char *argv[1];
  argv[0] = 0;
    113c:	fc043c23          	sd	zero,-40(s0)
  exec((char*)0xeaeb0b5b00002f5e, argv);
    1140:	00007497          	auipc	s1,0x7
    1144:	4504b483          	ld	s1,1104(s1) # 8590 <__SDATA_BEGIN__>
    1148:	fd840593          	add	a1,s0,-40
    114c:	8526                	mv	a0,s1
    114e:	00004097          	auipc	ra,0x4
    1152:	71c080e7          	jalr	1820(ra) # 586a <exec>

  pipe((int*)0xeaeb0b5b00002f5e);
    1156:	8526                	mv	a0,s1
    1158:	00004097          	auipc	ra,0x4
    115c:	6ea080e7          	jalr	1770(ra) # 5842 <pipe>

  exit(0);
    1160:	4501                	li	a0,0
    1162:	00004097          	auipc	ra,0x4
    1166:	6d0080e7          	jalr	1744(ra) # 5832 <exit>

000000000000116a <badarg>:

// regression test. test whether exec() leaks memory if one of the
// arguments is invalid. the test passes if the kernel doesn't panic.
void
badarg(char *s)
{
    116a:	7139                	add	sp,sp,-64
    116c:	fc06                	sd	ra,56(sp)
    116e:	f822                	sd	s0,48(sp)
    1170:	f426                	sd	s1,40(sp)
    1172:	f04a                	sd	s2,32(sp)
    1174:	ec4e                	sd	s3,24(sp)
    1176:	0080                	add	s0,sp,64
    1178:	64b1                	lui	s1,0xc
    117a:	35048493          	add	s1,s1,848 # c350 <buf+0x598>
  for(int i = 0; i < 50000; i++){
    char *argv[2];
    argv[0] = (char*)0xffffffff;
    117e:	597d                	li	s2,-1
    1180:	02095913          	srl	s2,s2,0x20
    argv[1] = 0;
    exec("echo", argv);
    1184:	00005997          	auipc	s3,0x5
    1188:	bf498993          	add	s3,s3,-1036 # 5d78 <malloc+0x11e>
    argv[0] = (char*)0xffffffff;
    118c:	fd243023          	sd	s2,-64(s0)
    argv[1] = 0;
    1190:	fc043423          	sd	zero,-56(s0)
    exec("echo", argv);
    1194:	fc040593          	add	a1,s0,-64
    1198:	854e                	mv	a0,s3
    119a:	00004097          	auipc	ra,0x4
    119e:	6d0080e7          	jalr	1744(ra) # 586a <exec>
  for(int i = 0; i < 50000; i++){
    11a2:	34fd                	addw	s1,s1,-1
    11a4:	f4e5                	bnez	s1,118c <badarg+0x22>
  }
  
  exit(0);
    11a6:	4501                	li	a0,0
    11a8:	00004097          	auipc	ra,0x4
    11ac:	68a080e7          	jalr	1674(ra) # 5832 <exit>

00000000000011b0 <copyinstr2>:
{
    11b0:	7155                	add	sp,sp,-208
    11b2:	e586                	sd	ra,200(sp)
    11b4:	e1a2                	sd	s0,192(sp)
    11b6:	0980                	add	s0,sp,208
  for(int i = 0; i < MAXPATH; i++)
    11b8:	f6840793          	add	a5,s0,-152
    11bc:	fe840693          	add	a3,s0,-24
    b[i] = 'x';
    11c0:	07800713          	li	a4,120
    11c4:	00e78023          	sb	a4,0(a5)
  for(int i = 0; i < MAXPATH; i++)
    11c8:	0785                	add	a5,a5,1
    11ca:	fed79de3          	bne	a5,a3,11c4 <copyinstr2+0x14>
  b[MAXPATH] = '\0';
    11ce:	fe040423          	sb	zero,-24(s0)
  int ret = unlink(b);
    11d2:	f6840513          	add	a0,s0,-152
    11d6:	00004097          	auipc	ra,0x4
    11da:	6ac080e7          	jalr	1708(ra) # 5882 <unlink>
  if(ret != -1){
    11de:	57fd                	li	a5,-1
    11e0:	0ef51063          	bne	a0,a5,12c0 <copyinstr2+0x110>
  int fd = open(b, O_CREATE | O_WRONLY);
    11e4:	20100593          	li	a1,513
    11e8:	f6840513          	add	a0,s0,-152
    11ec:	00004097          	auipc	ra,0x4
    11f0:	686080e7          	jalr	1670(ra) # 5872 <open>
  if(fd != -1){
    11f4:	57fd                	li	a5,-1
    11f6:	0ef51563          	bne	a0,a5,12e0 <copyinstr2+0x130>
  ret = link(b, b);
    11fa:	f6840593          	add	a1,s0,-152
    11fe:	852e                	mv	a0,a1
    1200:	00004097          	auipc	ra,0x4
    1204:	692080e7          	jalr	1682(ra) # 5892 <link>
  if(ret != -1){
    1208:	57fd                	li	a5,-1
    120a:	0ef51b63          	bne	a0,a5,1300 <copyinstr2+0x150>
  char *args[] = { "xx", 0 };
    120e:	00006797          	auipc	a5,0x6
    1212:	4ba78793          	add	a5,a5,1210 # 76c8 <malloc+0x1a6e>
    1216:	f4f43c23          	sd	a5,-168(s0)
    121a:	f6043023          	sd	zero,-160(s0)
  ret = exec(b, args);
    121e:	f5840593          	add	a1,s0,-168
    1222:	f6840513          	add	a0,s0,-152
    1226:	00004097          	auipc	ra,0x4
    122a:	644080e7          	jalr	1604(ra) # 586a <exec>
  if(ret != -1){
    122e:	57fd                	li	a5,-1
    1230:	0ef51963          	bne	a0,a5,1322 <copyinstr2+0x172>
  int pid = fork();
    1234:	00004097          	auipc	ra,0x4
    1238:	5f6080e7          	jalr	1526(ra) # 582a <fork>
  if(pid < 0){
    123c:	10054363          	bltz	a0,1342 <copyinstr2+0x192>
  if(pid == 0){
    1240:	12051463          	bnez	a0,1368 <copyinstr2+0x1b8>
    1244:	00007797          	auipc	a5,0x7
    1248:	45c78793          	add	a5,a5,1116 # 86a0 <big.0>
    124c:	00008697          	auipc	a3,0x8
    1250:	45468693          	add	a3,a3,1108 # 96a0 <__global_pointer$+0x910>
      big[i] = 'x';
    1254:	07800713          	li	a4,120
    1258:	00e78023          	sb	a4,0(a5)
    for(int i = 0; i < PGSIZE; i++)
    125c:	0785                	add	a5,a5,1
    125e:	fed79de3          	bne	a5,a3,1258 <copyinstr2+0xa8>
    big[PGSIZE] = '\0';
    1262:	00008797          	auipc	a5,0x8
    1266:	42078f23          	sb	zero,1086(a5) # 96a0 <__global_pointer$+0x910>
    char *args2[] = { big, big, big, 0 };
    126a:	00007797          	auipc	a5,0x7
    126e:	e9e78793          	add	a5,a5,-354 # 8108 <malloc+0x24ae>
    1272:	6390                	ld	a2,0(a5)
    1274:	6794                	ld	a3,8(a5)
    1276:	6b98                	ld	a4,16(a5)
    1278:	6f9c                	ld	a5,24(a5)
    127a:	f2c43823          	sd	a2,-208(s0)
    127e:	f2d43c23          	sd	a3,-200(s0)
    1282:	f4e43023          	sd	a4,-192(s0)
    1286:	f4f43423          	sd	a5,-184(s0)
    ret = exec("echo", args2);
    128a:	f3040593          	add	a1,s0,-208
    128e:	00005517          	auipc	a0,0x5
    1292:	aea50513          	add	a0,a0,-1302 # 5d78 <malloc+0x11e>
    1296:	00004097          	auipc	ra,0x4
    129a:	5d4080e7          	jalr	1492(ra) # 586a <exec>
    if(ret != -1){
    129e:	57fd                	li	a5,-1
    12a0:	0af50e63          	beq	a0,a5,135c <copyinstr2+0x1ac>
      printf("exec(echo, BIG) returned %d, not -1\n", fd);
    12a4:	55fd                	li	a1,-1
    12a6:	00005517          	auipc	a0,0x5
    12aa:	2d250513          	add	a0,a0,722 # 6578 <malloc+0x91e>
    12ae:	00005097          	auipc	ra,0x5
    12b2:	8f4080e7          	jalr	-1804(ra) # 5ba2 <printf>
      exit(1);
    12b6:	4505                	li	a0,1
    12b8:	00004097          	auipc	ra,0x4
    12bc:	57a080e7          	jalr	1402(ra) # 5832 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    12c0:	862a                	mv	a2,a0
    12c2:	f6840593          	add	a1,s0,-152
    12c6:	00005517          	auipc	a0,0x5
    12ca:	22a50513          	add	a0,a0,554 # 64f0 <malloc+0x896>
    12ce:	00005097          	auipc	ra,0x5
    12d2:	8d4080e7          	jalr	-1836(ra) # 5ba2 <printf>
    exit(1);
    12d6:	4505                	li	a0,1
    12d8:	00004097          	auipc	ra,0x4
    12dc:	55a080e7          	jalr	1370(ra) # 5832 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    12e0:	862a                	mv	a2,a0
    12e2:	f6840593          	add	a1,s0,-152
    12e6:	00005517          	auipc	a0,0x5
    12ea:	22a50513          	add	a0,a0,554 # 6510 <malloc+0x8b6>
    12ee:	00005097          	auipc	ra,0x5
    12f2:	8b4080e7          	jalr	-1868(ra) # 5ba2 <printf>
    exit(1);
    12f6:	4505                	li	a0,1
    12f8:	00004097          	auipc	ra,0x4
    12fc:	53a080e7          	jalr	1338(ra) # 5832 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    1300:	86aa                	mv	a3,a0
    1302:	f6840613          	add	a2,s0,-152
    1306:	85b2                	mv	a1,a2
    1308:	00005517          	auipc	a0,0x5
    130c:	22850513          	add	a0,a0,552 # 6530 <malloc+0x8d6>
    1310:	00005097          	auipc	ra,0x5
    1314:	892080e7          	jalr	-1902(ra) # 5ba2 <printf>
    exit(1);
    1318:	4505                	li	a0,1
    131a:	00004097          	auipc	ra,0x4
    131e:	518080e7          	jalr	1304(ra) # 5832 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    1322:	567d                	li	a2,-1
    1324:	f6840593          	add	a1,s0,-152
    1328:	00005517          	auipc	a0,0x5
    132c:	23050513          	add	a0,a0,560 # 6558 <malloc+0x8fe>
    1330:	00005097          	auipc	ra,0x5
    1334:	872080e7          	jalr	-1934(ra) # 5ba2 <printf>
    exit(1);
    1338:	4505                	li	a0,1
    133a:	00004097          	auipc	ra,0x4
    133e:	4f8080e7          	jalr	1272(ra) # 5832 <exit>
    printf("fork failed\n");
    1342:	00005517          	auipc	a0,0x5
    1346:	6ae50513          	add	a0,a0,1710 # 69f0 <malloc+0xd96>
    134a:	00005097          	auipc	ra,0x5
    134e:	858080e7          	jalr	-1960(ra) # 5ba2 <printf>
    exit(1);
    1352:	4505                	li	a0,1
    1354:	00004097          	auipc	ra,0x4
    1358:	4de080e7          	jalr	1246(ra) # 5832 <exit>
    exit(747); // OK
    135c:	2eb00513          	li	a0,747
    1360:	00004097          	auipc	ra,0x4
    1364:	4d2080e7          	jalr	1234(ra) # 5832 <exit>
  int st = 0;
    1368:	f4042a23          	sw	zero,-172(s0)
  wait(&st);
    136c:	f5440513          	add	a0,s0,-172
    1370:	00004097          	auipc	ra,0x4
    1374:	4ca080e7          	jalr	1226(ra) # 583a <wait>
  if(st != 747){
    1378:	f5442703          	lw	a4,-172(s0)
    137c:	2eb00793          	li	a5,747
    1380:	00f71663          	bne	a4,a5,138c <copyinstr2+0x1dc>
}
    1384:	60ae                	ld	ra,200(sp)
    1386:	640e                	ld	s0,192(sp)
    1388:	6169                	add	sp,sp,208
    138a:	8082                	ret
    printf("exec(echo, BIG) succeeded, should have failed\n");
    138c:	00005517          	auipc	a0,0x5
    1390:	21450513          	add	a0,a0,532 # 65a0 <malloc+0x946>
    1394:	00005097          	auipc	ra,0x5
    1398:	80e080e7          	jalr	-2034(ra) # 5ba2 <printf>
    exit(1);
    139c:	4505                	li	a0,1
    139e:	00004097          	auipc	ra,0x4
    13a2:	494080e7          	jalr	1172(ra) # 5832 <exit>

00000000000013a6 <truncate3>:
{
    13a6:	7159                	add	sp,sp,-112
    13a8:	f486                	sd	ra,104(sp)
    13aa:	f0a2                	sd	s0,96(sp)
    13ac:	eca6                	sd	s1,88(sp)
    13ae:	e8ca                	sd	s2,80(sp)
    13b0:	e4ce                	sd	s3,72(sp)
    13b2:	e0d2                	sd	s4,64(sp)
    13b4:	fc56                	sd	s5,56(sp)
    13b6:	1880                	add	s0,sp,112
    13b8:	892a                	mv	s2,a0
  close(open("truncfile", O_CREATE|O_TRUNC|O_WRONLY));
    13ba:	60100593          	li	a1,1537
    13be:	00005517          	auipc	a0,0x5
    13c2:	a1250513          	add	a0,a0,-1518 # 5dd0 <malloc+0x176>
    13c6:	00004097          	auipc	ra,0x4
    13ca:	4ac080e7          	jalr	1196(ra) # 5872 <open>
    13ce:	00004097          	auipc	ra,0x4
    13d2:	48c080e7          	jalr	1164(ra) # 585a <close>
  pid = fork();
    13d6:	00004097          	auipc	ra,0x4
    13da:	454080e7          	jalr	1108(ra) # 582a <fork>
  if(pid < 0){
    13de:	08054063          	bltz	a0,145e <truncate3+0xb8>
  if(pid == 0){
    13e2:	e969                	bnez	a0,14b4 <truncate3+0x10e>
    13e4:	06400993          	li	s3,100
      int fd = open("truncfile", O_WRONLY);
    13e8:	00005a17          	auipc	s4,0x5
    13ec:	9e8a0a13          	add	s4,s4,-1560 # 5dd0 <malloc+0x176>
      int n = write(fd, "1234567890", 10);
    13f0:	00005a97          	auipc	s5,0x5
    13f4:	210a8a93          	add	s5,s5,528 # 6600 <malloc+0x9a6>
      int fd = open("truncfile", O_WRONLY);
    13f8:	4585                	li	a1,1
    13fa:	8552                	mv	a0,s4
    13fc:	00004097          	auipc	ra,0x4
    1400:	476080e7          	jalr	1142(ra) # 5872 <open>
    1404:	84aa                	mv	s1,a0
      if(fd < 0){
    1406:	06054a63          	bltz	a0,147a <truncate3+0xd4>
      int n = write(fd, "1234567890", 10);
    140a:	4629                	li	a2,10
    140c:	85d6                	mv	a1,s5
    140e:	00004097          	auipc	ra,0x4
    1412:	444080e7          	jalr	1092(ra) # 5852 <write>
      if(n != 10){
    1416:	47a9                	li	a5,10
    1418:	06f51f63          	bne	a0,a5,1496 <truncate3+0xf0>
      close(fd);
    141c:	8526                	mv	a0,s1
    141e:	00004097          	auipc	ra,0x4
    1422:	43c080e7          	jalr	1084(ra) # 585a <close>
      fd = open("truncfile", O_RDONLY);
    1426:	4581                	li	a1,0
    1428:	8552                	mv	a0,s4
    142a:	00004097          	auipc	ra,0x4
    142e:	448080e7          	jalr	1096(ra) # 5872 <open>
    1432:	84aa                	mv	s1,a0
      read(fd, buf, sizeof(buf));
    1434:	02000613          	li	a2,32
    1438:	f9840593          	add	a1,s0,-104
    143c:	00004097          	auipc	ra,0x4
    1440:	40e080e7          	jalr	1038(ra) # 584a <read>
      close(fd);
    1444:	8526                	mv	a0,s1
    1446:	00004097          	auipc	ra,0x4
    144a:	414080e7          	jalr	1044(ra) # 585a <close>
    for(int i = 0; i < 100; i++){
    144e:	39fd                	addw	s3,s3,-1
    1450:	fa0994e3          	bnez	s3,13f8 <truncate3+0x52>
    exit(0);
    1454:	4501                	li	a0,0
    1456:	00004097          	auipc	ra,0x4
    145a:	3dc080e7          	jalr	988(ra) # 5832 <exit>
    printf("%s: fork failed\n", s);
    145e:	85ca                	mv	a1,s2
    1460:	00005517          	auipc	a0,0x5
    1464:	17050513          	add	a0,a0,368 # 65d0 <malloc+0x976>
    1468:	00004097          	auipc	ra,0x4
    146c:	73a080e7          	jalr	1850(ra) # 5ba2 <printf>
    exit(1);
    1470:	4505                	li	a0,1
    1472:	00004097          	auipc	ra,0x4
    1476:	3c0080e7          	jalr	960(ra) # 5832 <exit>
        printf("%s: open failed\n", s);
    147a:	85ca                	mv	a1,s2
    147c:	00005517          	auipc	a0,0x5
    1480:	16c50513          	add	a0,a0,364 # 65e8 <malloc+0x98e>
    1484:	00004097          	auipc	ra,0x4
    1488:	71e080e7          	jalr	1822(ra) # 5ba2 <printf>
        exit(1);
    148c:	4505                	li	a0,1
    148e:	00004097          	auipc	ra,0x4
    1492:	3a4080e7          	jalr	932(ra) # 5832 <exit>
        printf("%s: write got %d, expected 10\n", s, n);
    1496:	862a                	mv	a2,a0
    1498:	85ca                	mv	a1,s2
    149a:	00005517          	auipc	a0,0x5
    149e:	17650513          	add	a0,a0,374 # 6610 <malloc+0x9b6>
    14a2:	00004097          	auipc	ra,0x4
    14a6:	700080e7          	jalr	1792(ra) # 5ba2 <printf>
        exit(1);
    14aa:	4505                	li	a0,1
    14ac:	00004097          	auipc	ra,0x4
    14b0:	386080e7          	jalr	902(ra) # 5832 <exit>
    14b4:	09600993          	li	s3,150
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    14b8:	00005a17          	auipc	s4,0x5
    14bc:	918a0a13          	add	s4,s4,-1768 # 5dd0 <malloc+0x176>
    int n = write(fd, "xxx", 3);
    14c0:	00005a97          	auipc	s5,0x5
    14c4:	170a8a93          	add	s5,s5,368 # 6630 <malloc+0x9d6>
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    14c8:	60100593          	li	a1,1537
    14cc:	8552                	mv	a0,s4
    14ce:	00004097          	auipc	ra,0x4
    14d2:	3a4080e7          	jalr	932(ra) # 5872 <open>
    14d6:	84aa                	mv	s1,a0
    if(fd < 0){
    14d8:	04054763          	bltz	a0,1526 <truncate3+0x180>
    int n = write(fd, "xxx", 3);
    14dc:	460d                	li	a2,3
    14de:	85d6                	mv	a1,s5
    14e0:	00004097          	auipc	ra,0x4
    14e4:	372080e7          	jalr	882(ra) # 5852 <write>
    if(n != 3){
    14e8:	478d                	li	a5,3
    14ea:	04f51c63          	bne	a0,a5,1542 <truncate3+0x19c>
    close(fd);
    14ee:	8526                	mv	a0,s1
    14f0:	00004097          	auipc	ra,0x4
    14f4:	36a080e7          	jalr	874(ra) # 585a <close>
  for(int i = 0; i < 150; i++){
    14f8:	39fd                	addw	s3,s3,-1
    14fa:	fc0997e3          	bnez	s3,14c8 <truncate3+0x122>
  wait(&xstatus);
    14fe:	fbc40513          	add	a0,s0,-68
    1502:	00004097          	auipc	ra,0x4
    1506:	338080e7          	jalr	824(ra) # 583a <wait>
  unlink("truncfile");
    150a:	00005517          	auipc	a0,0x5
    150e:	8c650513          	add	a0,a0,-1850 # 5dd0 <malloc+0x176>
    1512:	00004097          	auipc	ra,0x4
    1516:	370080e7          	jalr	880(ra) # 5882 <unlink>
  exit(xstatus);
    151a:	fbc42503          	lw	a0,-68(s0)
    151e:	00004097          	auipc	ra,0x4
    1522:	314080e7          	jalr	788(ra) # 5832 <exit>
      printf("%s: open failed\n", s);
    1526:	85ca                	mv	a1,s2
    1528:	00005517          	auipc	a0,0x5
    152c:	0c050513          	add	a0,a0,192 # 65e8 <malloc+0x98e>
    1530:	00004097          	auipc	ra,0x4
    1534:	672080e7          	jalr	1650(ra) # 5ba2 <printf>
      exit(1);
    1538:	4505                	li	a0,1
    153a:	00004097          	auipc	ra,0x4
    153e:	2f8080e7          	jalr	760(ra) # 5832 <exit>
      printf("%s: write got %d, expected 3\n", s, n);
    1542:	862a                	mv	a2,a0
    1544:	85ca                	mv	a1,s2
    1546:	00005517          	auipc	a0,0x5
    154a:	0f250513          	add	a0,a0,242 # 6638 <malloc+0x9de>
    154e:	00004097          	auipc	ra,0x4
    1552:	654080e7          	jalr	1620(ra) # 5ba2 <printf>
      exit(1);
    1556:	4505                	li	a0,1
    1558:	00004097          	auipc	ra,0x4
    155c:	2da080e7          	jalr	730(ra) # 5832 <exit>

0000000000001560 <exectest>:
{
    1560:	715d                	add	sp,sp,-80
    1562:	e486                	sd	ra,72(sp)
    1564:	e0a2                	sd	s0,64(sp)
    1566:	fc26                	sd	s1,56(sp)
    1568:	f84a                	sd	s2,48(sp)
    156a:	0880                	add	s0,sp,80
    156c:	892a                	mv	s2,a0
  char *echoargv[] = { "echo", "OK", 0 };
    156e:	00005797          	auipc	a5,0x5
    1572:	80a78793          	add	a5,a5,-2038 # 5d78 <malloc+0x11e>
    1576:	fcf43023          	sd	a5,-64(s0)
    157a:	00005797          	auipc	a5,0x5
    157e:	0de78793          	add	a5,a5,222 # 6658 <malloc+0x9fe>
    1582:	fcf43423          	sd	a5,-56(s0)
    1586:	fc043823          	sd	zero,-48(s0)
  unlink("echo-ok");
    158a:	00005517          	auipc	a0,0x5
    158e:	0d650513          	add	a0,a0,214 # 6660 <malloc+0xa06>
    1592:	00004097          	auipc	ra,0x4
    1596:	2f0080e7          	jalr	752(ra) # 5882 <unlink>
  pid = fork();
    159a:	00004097          	auipc	ra,0x4
    159e:	290080e7          	jalr	656(ra) # 582a <fork>
  if(pid < 0) {
    15a2:	04054663          	bltz	a0,15ee <exectest+0x8e>
    15a6:	84aa                	mv	s1,a0
  if(pid == 0) {
    15a8:	e959                	bnez	a0,163e <exectest+0xde>
    close(1);
    15aa:	4505                	li	a0,1
    15ac:	00004097          	auipc	ra,0x4
    15b0:	2ae080e7          	jalr	686(ra) # 585a <close>
    fd = open("echo-ok", O_CREATE|O_WRONLY);
    15b4:	20100593          	li	a1,513
    15b8:	00005517          	auipc	a0,0x5
    15bc:	0a850513          	add	a0,a0,168 # 6660 <malloc+0xa06>
    15c0:	00004097          	auipc	ra,0x4
    15c4:	2b2080e7          	jalr	690(ra) # 5872 <open>
    if(fd < 0) {
    15c8:	04054163          	bltz	a0,160a <exectest+0xaa>
    if(fd != 1) {
    15cc:	4785                	li	a5,1
    15ce:	04f50c63          	beq	a0,a5,1626 <exectest+0xc6>
      printf("%s: wrong fd\n", s);
    15d2:	85ca                	mv	a1,s2
    15d4:	00005517          	auipc	a0,0x5
    15d8:	0ac50513          	add	a0,a0,172 # 6680 <malloc+0xa26>
    15dc:	00004097          	auipc	ra,0x4
    15e0:	5c6080e7          	jalr	1478(ra) # 5ba2 <printf>
      exit(1);
    15e4:	4505                	li	a0,1
    15e6:	00004097          	auipc	ra,0x4
    15ea:	24c080e7          	jalr	588(ra) # 5832 <exit>
     printf("%s: fork failed\n", s);
    15ee:	85ca                	mv	a1,s2
    15f0:	00005517          	auipc	a0,0x5
    15f4:	fe050513          	add	a0,a0,-32 # 65d0 <malloc+0x976>
    15f8:	00004097          	auipc	ra,0x4
    15fc:	5aa080e7          	jalr	1450(ra) # 5ba2 <printf>
     exit(1);
    1600:	4505                	li	a0,1
    1602:	00004097          	auipc	ra,0x4
    1606:	230080e7          	jalr	560(ra) # 5832 <exit>
      printf("%s: create failed\n", s);
    160a:	85ca                	mv	a1,s2
    160c:	00005517          	auipc	a0,0x5
    1610:	05c50513          	add	a0,a0,92 # 6668 <malloc+0xa0e>
    1614:	00004097          	auipc	ra,0x4
    1618:	58e080e7          	jalr	1422(ra) # 5ba2 <printf>
      exit(1);
    161c:	4505                	li	a0,1
    161e:	00004097          	auipc	ra,0x4
    1622:	214080e7          	jalr	532(ra) # 5832 <exit>
    if(exec("echo", echoargv) < 0){
    1626:	fc040593          	add	a1,s0,-64
    162a:	00004517          	auipc	a0,0x4
    162e:	74e50513          	add	a0,a0,1870 # 5d78 <malloc+0x11e>
    1632:	00004097          	auipc	ra,0x4
    1636:	238080e7          	jalr	568(ra) # 586a <exec>
    163a:	02054163          	bltz	a0,165c <exectest+0xfc>
  if (wait(&xstatus) != pid) {
    163e:	fdc40513          	add	a0,s0,-36
    1642:	00004097          	auipc	ra,0x4
    1646:	1f8080e7          	jalr	504(ra) # 583a <wait>
    164a:	02951763          	bne	a0,s1,1678 <exectest+0x118>
  if(xstatus != 0)
    164e:	fdc42503          	lw	a0,-36(s0)
    1652:	cd0d                	beqz	a0,168c <exectest+0x12c>
    exit(xstatus);
    1654:	00004097          	auipc	ra,0x4
    1658:	1de080e7          	jalr	478(ra) # 5832 <exit>
      printf("%s: exec echo failed\n", s);
    165c:	85ca                	mv	a1,s2
    165e:	00005517          	auipc	a0,0x5
    1662:	03250513          	add	a0,a0,50 # 6690 <malloc+0xa36>
    1666:	00004097          	auipc	ra,0x4
    166a:	53c080e7          	jalr	1340(ra) # 5ba2 <printf>
      exit(1);
    166e:	4505                	li	a0,1
    1670:	00004097          	auipc	ra,0x4
    1674:	1c2080e7          	jalr	450(ra) # 5832 <exit>
    printf("%s: wait failed!\n", s);
    1678:	85ca                	mv	a1,s2
    167a:	00005517          	auipc	a0,0x5
    167e:	02e50513          	add	a0,a0,46 # 66a8 <malloc+0xa4e>
    1682:	00004097          	auipc	ra,0x4
    1686:	520080e7          	jalr	1312(ra) # 5ba2 <printf>
    168a:	b7d1                	j	164e <exectest+0xee>
  fd = open("echo-ok", O_RDONLY);
    168c:	4581                	li	a1,0
    168e:	00005517          	auipc	a0,0x5
    1692:	fd250513          	add	a0,a0,-46 # 6660 <malloc+0xa06>
    1696:	00004097          	auipc	ra,0x4
    169a:	1dc080e7          	jalr	476(ra) # 5872 <open>
  if(fd < 0) {
    169e:	02054a63          	bltz	a0,16d2 <exectest+0x172>
  if (read(fd, buf, 2) != 2) {
    16a2:	4609                	li	a2,2
    16a4:	fb840593          	add	a1,s0,-72
    16a8:	00004097          	auipc	ra,0x4
    16ac:	1a2080e7          	jalr	418(ra) # 584a <read>
    16b0:	4789                	li	a5,2
    16b2:	02f50e63          	beq	a0,a5,16ee <exectest+0x18e>
    printf("%s: read failed\n", s);
    16b6:	85ca                	mv	a1,s2
    16b8:	00005517          	auipc	a0,0x5
    16bc:	a6050513          	add	a0,a0,-1440 # 6118 <malloc+0x4be>
    16c0:	00004097          	auipc	ra,0x4
    16c4:	4e2080e7          	jalr	1250(ra) # 5ba2 <printf>
    exit(1);
    16c8:	4505                	li	a0,1
    16ca:	00004097          	auipc	ra,0x4
    16ce:	168080e7          	jalr	360(ra) # 5832 <exit>
    printf("%s: open failed\n", s);
    16d2:	85ca                	mv	a1,s2
    16d4:	00005517          	auipc	a0,0x5
    16d8:	f1450513          	add	a0,a0,-236 # 65e8 <malloc+0x98e>
    16dc:	00004097          	auipc	ra,0x4
    16e0:	4c6080e7          	jalr	1222(ra) # 5ba2 <printf>
    exit(1);
    16e4:	4505                	li	a0,1
    16e6:	00004097          	auipc	ra,0x4
    16ea:	14c080e7          	jalr	332(ra) # 5832 <exit>
  unlink("echo-ok");
    16ee:	00005517          	auipc	a0,0x5
    16f2:	f7250513          	add	a0,a0,-142 # 6660 <malloc+0xa06>
    16f6:	00004097          	auipc	ra,0x4
    16fa:	18c080e7          	jalr	396(ra) # 5882 <unlink>
  if(buf[0] == 'O' && buf[1] == 'K')
    16fe:	fb844703          	lbu	a4,-72(s0)
    1702:	04f00793          	li	a5,79
    1706:	00f71863          	bne	a4,a5,1716 <exectest+0x1b6>
    170a:	fb944703          	lbu	a4,-71(s0)
    170e:	04b00793          	li	a5,75
    1712:	02f70063          	beq	a4,a5,1732 <exectest+0x1d2>
    printf("%s: wrong output\n", s);
    1716:	85ca                	mv	a1,s2
    1718:	00005517          	auipc	a0,0x5
    171c:	fa850513          	add	a0,a0,-88 # 66c0 <malloc+0xa66>
    1720:	00004097          	auipc	ra,0x4
    1724:	482080e7          	jalr	1154(ra) # 5ba2 <printf>
    exit(1);
    1728:	4505                	li	a0,1
    172a:	00004097          	auipc	ra,0x4
    172e:	108080e7          	jalr	264(ra) # 5832 <exit>
    exit(0);
    1732:	4501                	li	a0,0
    1734:	00004097          	auipc	ra,0x4
    1738:	0fe080e7          	jalr	254(ra) # 5832 <exit>

000000000000173c <pipe1>:
{
    173c:	711d                	add	sp,sp,-96
    173e:	ec86                	sd	ra,88(sp)
    1740:	e8a2                	sd	s0,80(sp)
    1742:	e4a6                	sd	s1,72(sp)
    1744:	e0ca                	sd	s2,64(sp)
    1746:	fc4e                	sd	s3,56(sp)
    1748:	f852                	sd	s4,48(sp)
    174a:	f456                	sd	s5,40(sp)
    174c:	f05a                	sd	s6,32(sp)
    174e:	ec5e                	sd	s7,24(sp)
    1750:	1080                	add	s0,sp,96
    1752:	892a                	mv	s2,a0
  if(pipe(fds) != 0){
    1754:	fa840513          	add	a0,s0,-88
    1758:	00004097          	auipc	ra,0x4
    175c:	0ea080e7          	jalr	234(ra) # 5842 <pipe>
    1760:	e93d                	bnez	a0,17d6 <pipe1+0x9a>
    1762:	84aa                	mv	s1,a0
  pid = fork();
    1764:	00004097          	auipc	ra,0x4
    1768:	0c6080e7          	jalr	198(ra) # 582a <fork>
    176c:	8a2a                	mv	s4,a0
  if(pid == 0){
    176e:	c151                	beqz	a0,17f2 <pipe1+0xb6>
  } else if(pid > 0){
    1770:	16a05d63          	blez	a0,18ea <pipe1+0x1ae>
    close(fds[1]);
    1774:	fac42503          	lw	a0,-84(s0)
    1778:	00004097          	auipc	ra,0x4
    177c:	0e2080e7          	jalr	226(ra) # 585a <close>
    total = 0;
    1780:	8a26                	mv	s4,s1
    cc = 1;
    1782:	4985                	li	s3,1
    while((n = read(fds[0], buf, cc)) > 0){
    1784:	0000aa97          	auipc	s5,0xa
    1788:	634a8a93          	add	s5,s5,1588 # bdb8 <buf>
    178c:	864e                	mv	a2,s3
    178e:	85d6                	mv	a1,s5
    1790:	fa842503          	lw	a0,-88(s0)
    1794:	00004097          	auipc	ra,0x4
    1798:	0b6080e7          	jalr	182(ra) # 584a <read>
    179c:	10a05263          	blez	a0,18a0 <pipe1+0x164>
      for(i = 0; i < n; i++){
    17a0:	0000a717          	auipc	a4,0xa
    17a4:	61870713          	add	a4,a4,1560 # bdb8 <buf>
    17a8:	00a4863b          	addw	a2,s1,a0
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    17ac:	00074683          	lbu	a3,0(a4)
    17b0:	0ff4f793          	zext.b	a5,s1
    17b4:	2485                	addw	s1,s1,1
    17b6:	0cf69163          	bne	a3,a5,1878 <pipe1+0x13c>
      for(i = 0; i < n; i++){
    17ba:	0705                	add	a4,a4,1
    17bc:	fec498e3          	bne	s1,a2,17ac <pipe1+0x70>
      total += n;
    17c0:	00aa0a3b          	addw	s4,s4,a0
      cc = cc * 2;
    17c4:	0019979b          	sllw	a5,s3,0x1
    17c8:	0007899b          	sext.w	s3,a5
      if(cc > sizeof(buf))
    17cc:	670d                	lui	a4,0x3
    17ce:	fb377fe3          	bgeu	a4,s3,178c <pipe1+0x50>
        cc = sizeof(buf);
    17d2:	698d                	lui	s3,0x3
    17d4:	bf65                	j	178c <pipe1+0x50>
    printf("%s: pipe() failed\n", s);
    17d6:	85ca                	mv	a1,s2
    17d8:	00005517          	auipc	a0,0x5
    17dc:	f0050513          	add	a0,a0,-256 # 66d8 <malloc+0xa7e>
    17e0:	00004097          	auipc	ra,0x4
    17e4:	3c2080e7          	jalr	962(ra) # 5ba2 <printf>
    exit(1);
    17e8:	4505                	li	a0,1
    17ea:	00004097          	auipc	ra,0x4
    17ee:	048080e7          	jalr	72(ra) # 5832 <exit>
    close(fds[0]);
    17f2:	fa842503          	lw	a0,-88(s0)
    17f6:	00004097          	auipc	ra,0x4
    17fa:	064080e7          	jalr	100(ra) # 585a <close>
    for(n = 0; n < N; n++){
    17fe:	0000ab17          	auipc	s6,0xa
    1802:	5bab0b13          	add	s6,s6,1466 # bdb8 <buf>
    1806:	416004bb          	negw	s1,s6
    180a:	0ff4f493          	zext.b	s1,s1
    180e:	409b0993          	add	s3,s6,1033
      if(write(fds[1], buf, SZ) != SZ){
    1812:	8bda                	mv	s7,s6
    for(n = 0; n < N; n++){
    1814:	6a85                	lui	s5,0x1
    1816:	42da8a93          	add	s5,s5,1069 # 142d <truncate3+0x87>
{
    181a:	87da                	mv	a5,s6
        buf[i] = seq++;
    181c:	0097873b          	addw	a4,a5,s1
    1820:	00e78023          	sb	a4,0(a5)
      for(i = 0; i < SZ; i++)
    1824:	0785                	add	a5,a5,1
    1826:	fef99be3          	bne	s3,a5,181c <pipe1+0xe0>
        buf[i] = seq++;
    182a:	409a0a1b          	addw	s4,s4,1033
      if(write(fds[1], buf, SZ) != SZ){
    182e:	40900613          	li	a2,1033
    1832:	85de                	mv	a1,s7
    1834:	fac42503          	lw	a0,-84(s0)
    1838:	00004097          	auipc	ra,0x4
    183c:	01a080e7          	jalr	26(ra) # 5852 <write>
    1840:	40900793          	li	a5,1033
    1844:	00f51c63          	bne	a0,a5,185c <pipe1+0x120>
    for(n = 0; n < N; n++){
    1848:	24a5                	addw	s1,s1,9
    184a:	0ff4f493          	zext.b	s1,s1
    184e:	fd5a16e3          	bne	s4,s5,181a <pipe1+0xde>
    exit(0);
    1852:	4501                	li	a0,0
    1854:	00004097          	auipc	ra,0x4
    1858:	fde080e7          	jalr	-34(ra) # 5832 <exit>
        printf("%s: pipe1 oops 1\n", s);
    185c:	85ca                	mv	a1,s2
    185e:	00005517          	auipc	a0,0x5
    1862:	e9250513          	add	a0,a0,-366 # 66f0 <malloc+0xa96>
    1866:	00004097          	auipc	ra,0x4
    186a:	33c080e7          	jalr	828(ra) # 5ba2 <printf>
        exit(1);
    186e:	4505                	li	a0,1
    1870:	00004097          	auipc	ra,0x4
    1874:	fc2080e7          	jalr	-62(ra) # 5832 <exit>
          printf("%s: pipe1 oops 2\n", s);
    1878:	85ca                	mv	a1,s2
    187a:	00005517          	auipc	a0,0x5
    187e:	e8e50513          	add	a0,a0,-370 # 6708 <malloc+0xaae>
    1882:	00004097          	auipc	ra,0x4
    1886:	320080e7          	jalr	800(ra) # 5ba2 <printf>
}
    188a:	60e6                	ld	ra,88(sp)
    188c:	6446                	ld	s0,80(sp)
    188e:	64a6                	ld	s1,72(sp)
    1890:	6906                	ld	s2,64(sp)
    1892:	79e2                	ld	s3,56(sp)
    1894:	7a42                	ld	s4,48(sp)
    1896:	7aa2                	ld	s5,40(sp)
    1898:	7b02                	ld	s6,32(sp)
    189a:	6be2                	ld	s7,24(sp)
    189c:	6125                	add	sp,sp,96
    189e:	8082                	ret
    if(total != N * SZ){
    18a0:	6785                	lui	a5,0x1
    18a2:	42d78793          	add	a5,a5,1069 # 142d <truncate3+0x87>
    18a6:	02fa0063          	beq	s4,a5,18c6 <pipe1+0x18a>
      printf("%s: pipe1 oops 3 total %d\n", total);
    18aa:	85d2                	mv	a1,s4
    18ac:	00005517          	auipc	a0,0x5
    18b0:	e7450513          	add	a0,a0,-396 # 6720 <malloc+0xac6>
    18b4:	00004097          	auipc	ra,0x4
    18b8:	2ee080e7          	jalr	750(ra) # 5ba2 <printf>
      exit(1);
    18bc:	4505                	li	a0,1
    18be:	00004097          	auipc	ra,0x4
    18c2:	f74080e7          	jalr	-140(ra) # 5832 <exit>
    close(fds[0]);
    18c6:	fa842503          	lw	a0,-88(s0)
    18ca:	00004097          	auipc	ra,0x4
    18ce:	f90080e7          	jalr	-112(ra) # 585a <close>
    wait(&xstatus);
    18d2:	fa440513          	add	a0,s0,-92
    18d6:	00004097          	auipc	ra,0x4
    18da:	f64080e7          	jalr	-156(ra) # 583a <wait>
    exit(xstatus);
    18de:	fa442503          	lw	a0,-92(s0)
    18e2:	00004097          	auipc	ra,0x4
    18e6:	f50080e7          	jalr	-176(ra) # 5832 <exit>
    printf("%s: fork() failed\n", s);
    18ea:	85ca                	mv	a1,s2
    18ec:	00005517          	auipc	a0,0x5
    18f0:	e5450513          	add	a0,a0,-428 # 6740 <malloc+0xae6>
    18f4:	00004097          	auipc	ra,0x4
    18f8:	2ae080e7          	jalr	686(ra) # 5ba2 <printf>
    exit(1);
    18fc:	4505                	li	a0,1
    18fe:	00004097          	auipc	ra,0x4
    1902:	f34080e7          	jalr	-204(ra) # 5832 <exit>

0000000000001906 <exitwait>:
{
    1906:	7139                	add	sp,sp,-64
    1908:	fc06                	sd	ra,56(sp)
    190a:	f822                	sd	s0,48(sp)
    190c:	f426                	sd	s1,40(sp)
    190e:	f04a                	sd	s2,32(sp)
    1910:	ec4e                	sd	s3,24(sp)
    1912:	e852                	sd	s4,16(sp)
    1914:	0080                	add	s0,sp,64
    1916:	8a2a                	mv	s4,a0
  for(i = 0; i < 100; i++){
    1918:	4901                	li	s2,0
    191a:	06400993          	li	s3,100
    pid = fork();
    191e:	00004097          	auipc	ra,0x4
    1922:	f0c080e7          	jalr	-244(ra) # 582a <fork>
    1926:	84aa                	mv	s1,a0
    if(pid < 0){
    1928:	02054a63          	bltz	a0,195c <exitwait+0x56>
    if(pid){
    192c:	c151                	beqz	a0,19b0 <exitwait+0xaa>
      if(wait(&xstate) != pid){
    192e:	fcc40513          	add	a0,s0,-52
    1932:	00004097          	auipc	ra,0x4
    1936:	f08080e7          	jalr	-248(ra) # 583a <wait>
    193a:	02951f63          	bne	a0,s1,1978 <exitwait+0x72>
      if(i != xstate) {
    193e:	fcc42783          	lw	a5,-52(s0)
    1942:	05279963          	bne	a5,s2,1994 <exitwait+0x8e>
  for(i = 0; i < 100; i++){
    1946:	2905                	addw	s2,s2,1
    1948:	fd391be3          	bne	s2,s3,191e <exitwait+0x18>
}
    194c:	70e2                	ld	ra,56(sp)
    194e:	7442                	ld	s0,48(sp)
    1950:	74a2                	ld	s1,40(sp)
    1952:	7902                	ld	s2,32(sp)
    1954:	69e2                	ld	s3,24(sp)
    1956:	6a42                	ld	s4,16(sp)
    1958:	6121                	add	sp,sp,64
    195a:	8082                	ret
      printf("%s: fork failed\n", s);
    195c:	85d2                	mv	a1,s4
    195e:	00005517          	auipc	a0,0x5
    1962:	c7250513          	add	a0,a0,-910 # 65d0 <malloc+0x976>
    1966:	00004097          	auipc	ra,0x4
    196a:	23c080e7          	jalr	572(ra) # 5ba2 <printf>
      exit(1);
    196e:	4505                	li	a0,1
    1970:	00004097          	auipc	ra,0x4
    1974:	ec2080e7          	jalr	-318(ra) # 5832 <exit>
        printf("%s: wait wrong pid\n", s);
    1978:	85d2                	mv	a1,s4
    197a:	00005517          	auipc	a0,0x5
    197e:	dde50513          	add	a0,a0,-546 # 6758 <malloc+0xafe>
    1982:	00004097          	auipc	ra,0x4
    1986:	220080e7          	jalr	544(ra) # 5ba2 <printf>
        exit(1);
    198a:	4505                	li	a0,1
    198c:	00004097          	auipc	ra,0x4
    1990:	ea6080e7          	jalr	-346(ra) # 5832 <exit>
        printf("%s: wait wrong exit status\n", s);
    1994:	85d2                	mv	a1,s4
    1996:	00005517          	auipc	a0,0x5
    199a:	dda50513          	add	a0,a0,-550 # 6770 <malloc+0xb16>
    199e:	00004097          	auipc	ra,0x4
    19a2:	204080e7          	jalr	516(ra) # 5ba2 <printf>
        exit(1);
    19a6:	4505                	li	a0,1
    19a8:	00004097          	auipc	ra,0x4
    19ac:	e8a080e7          	jalr	-374(ra) # 5832 <exit>
      exit(i);
    19b0:	854a                	mv	a0,s2
    19b2:	00004097          	auipc	ra,0x4
    19b6:	e80080e7          	jalr	-384(ra) # 5832 <exit>

00000000000019ba <twochildren>:
{
    19ba:	1101                	add	sp,sp,-32
    19bc:	ec06                	sd	ra,24(sp)
    19be:	e822                	sd	s0,16(sp)
    19c0:	e426                	sd	s1,8(sp)
    19c2:	e04a                	sd	s2,0(sp)
    19c4:	1000                	add	s0,sp,32
    19c6:	892a                	mv	s2,a0
    19c8:	3e800493          	li	s1,1000
    int pid1 = fork();
    19cc:	00004097          	auipc	ra,0x4
    19d0:	e5e080e7          	jalr	-418(ra) # 582a <fork>
    if(pid1 < 0){
    19d4:	02054c63          	bltz	a0,1a0c <twochildren+0x52>
    if(pid1 == 0){
    19d8:	c921                	beqz	a0,1a28 <twochildren+0x6e>
      int pid2 = fork();
    19da:	00004097          	auipc	ra,0x4
    19de:	e50080e7          	jalr	-432(ra) # 582a <fork>
      if(pid2 < 0){
    19e2:	04054763          	bltz	a0,1a30 <twochildren+0x76>
      if(pid2 == 0){
    19e6:	c13d                	beqz	a0,1a4c <twochildren+0x92>
        wait(0);
    19e8:	4501                	li	a0,0
    19ea:	00004097          	auipc	ra,0x4
    19ee:	e50080e7          	jalr	-432(ra) # 583a <wait>
        wait(0);
    19f2:	4501                	li	a0,0
    19f4:	00004097          	auipc	ra,0x4
    19f8:	e46080e7          	jalr	-442(ra) # 583a <wait>
  for(int i = 0; i < 1000; i++){
    19fc:	34fd                	addw	s1,s1,-1
    19fe:	f4f9                	bnez	s1,19cc <twochildren+0x12>
}
    1a00:	60e2                	ld	ra,24(sp)
    1a02:	6442                	ld	s0,16(sp)
    1a04:	64a2                	ld	s1,8(sp)
    1a06:	6902                	ld	s2,0(sp)
    1a08:	6105                	add	sp,sp,32
    1a0a:	8082                	ret
      printf("%s: fork failed\n", s);
    1a0c:	85ca                	mv	a1,s2
    1a0e:	00005517          	auipc	a0,0x5
    1a12:	bc250513          	add	a0,a0,-1086 # 65d0 <malloc+0x976>
    1a16:	00004097          	auipc	ra,0x4
    1a1a:	18c080e7          	jalr	396(ra) # 5ba2 <printf>
      exit(1);
    1a1e:	4505                	li	a0,1
    1a20:	00004097          	auipc	ra,0x4
    1a24:	e12080e7          	jalr	-494(ra) # 5832 <exit>
      exit(0);
    1a28:	00004097          	auipc	ra,0x4
    1a2c:	e0a080e7          	jalr	-502(ra) # 5832 <exit>
        printf("%s: fork failed\n", s);
    1a30:	85ca                	mv	a1,s2
    1a32:	00005517          	auipc	a0,0x5
    1a36:	b9e50513          	add	a0,a0,-1122 # 65d0 <malloc+0x976>
    1a3a:	00004097          	auipc	ra,0x4
    1a3e:	168080e7          	jalr	360(ra) # 5ba2 <printf>
        exit(1);
    1a42:	4505                	li	a0,1
    1a44:	00004097          	auipc	ra,0x4
    1a48:	dee080e7          	jalr	-530(ra) # 5832 <exit>
        exit(0);
    1a4c:	00004097          	auipc	ra,0x4
    1a50:	de6080e7          	jalr	-538(ra) # 5832 <exit>

0000000000001a54 <forkfork>:
{
    1a54:	7179                	add	sp,sp,-48
    1a56:	f406                	sd	ra,40(sp)
    1a58:	f022                	sd	s0,32(sp)
    1a5a:	ec26                	sd	s1,24(sp)
    1a5c:	1800                	add	s0,sp,48
    1a5e:	84aa                	mv	s1,a0
    int pid = fork();
    1a60:	00004097          	auipc	ra,0x4
    1a64:	dca080e7          	jalr	-566(ra) # 582a <fork>
    if(pid < 0){
    1a68:	04054163          	bltz	a0,1aaa <forkfork+0x56>
    if(pid == 0){
    1a6c:	cd29                	beqz	a0,1ac6 <forkfork+0x72>
    int pid = fork();
    1a6e:	00004097          	auipc	ra,0x4
    1a72:	dbc080e7          	jalr	-580(ra) # 582a <fork>
    if(pid < 0){
    1a76:	02054a63          	bltz	a0,1aaa <forkfork+0x56>
    if(pid == 0){
    1a7a:	c531                	beqz	a0,1ac6 <forkfork+0x72>
    wait(&xstatus);
    1a7c:	fdc40513          	add	a0,s0,-36
    1a80:	00004097          	auipc	ra,0x4
    1a84:	dba080e7          	jalr	-582(ra) # 583a <wait>
    if(xstatus != 0) {
    1a88:	fdc42783          	lw	a5,-36(s0)
    1a8c:	ebbd                	bnez	a5,1b02 <forkfork+0xae>
    wait(&xstatus);
    1a8e:	fdc40513          	add	a0,s0,-36
    1a92:	00004097          	auipc	ra,0x4
    1a96:	da8080e7          	jalr	-600(ra) # 583a <wait>
    if(xstatus != 0) {
    1a9a:	fdc42783          	lw	a5,-36(s0)
    1a9e:	e3b5                	bnez	a5,1b02 <forkfork+0xae>
}
    1aa0:	70a2                	ld	ra,40(sp)
    1aa2:	7402                	ld	s0,32(sp)
    1aa4:	64e2                	ld	s1,24(sp)
    1aa6:	6145                	add	sp,sp,48
    1aa8:	8082                	ret
      printf("%s: fork failed", s);
    1aaa:	85a6                	mv	a1,s1
    1aac:	00005517          	auipc	a0,0x5
    1ab0:	ce450513          	add	a0,a0,-796 # 6790 <malloc+0xb36>
    1ab4:	00004097          	auipc	ra,0x4
    1ab8:	0ee080e7          	jalr	238(ra) # 5ba2 <printf>
      exit(1);
    1abc:	4505                	li	a0,1
    1abe:	00004097          	auipc	ra,0x4
    1ac2:	d74080e7          	jalr	-652(ra) # 5832 <exit>
{
    1ac6:	0c800493          	li	s1,200
        int pid1 = fork();
    1aca:	00004097          	auipc	ra,0x4
    1ace:	d60080e7          	jalr	-672(ra) # 582a <fork>
        if(pid1 < 0){
    1ad2:	00054f63          	bltz	a0,1af0 <forkfork+0x9c>
        if(pid1 == 0){
    1ad6:	c115                	beqz	a0,1afa <forkfork+0xa6>
        wait(0);
    1ad8:	4501                	li	a0,0
    1ada:	00004097          	auipc	ra,0x4
    1ade:	d60080e7          	jalr	-672(ra) # 583a <wait>
      for(int j = 0; j < 200; j++){
    1ae2:	34fd                	addw	s1,s1,-1
    1ae4:	f0fd                	bnez	s1,1aca <forkfork+0x76>
      exit(0);
    1ae6:	4501                	li	a0,0
    1ae8:	00004097          	auipc	ra,0x4
    1aec:	d4a080e7          	jalr	-694(ra) # 5832 <exit>
          exit(1);
    1af0:	4505                	li	a0,1
    1af2:	00004097          	auipc	ra,0x4
    1af6:	d40080e7          	jalr	-704(ra) # 5832 <exit>
          exit(0);
    1afa:	00004097          	auipc	ra,0x4
    1afe:	d38080e7          	jalr	-712(ra) # 5832 <exit>
      printf("%s: fork in child failed", s);
    1b02:	85a6                	mv	a1,s1
    1b04:	00005517          	auipc	a0,0x5
    1b08:	c9c50513          	add	a0,a0,-868 # 67a0 <malloc+0xb46>
    1b0c:	00004097          	auipc	ra,0x4
    1b10:	096080e7          	jalr	150(ra) # 5ba2 <printf>
      exit(1);
    1b14:	4505                	li	a0,1
    1b16:	00004097          	auipc	ra,0x4
    1b1a:	d1c080e7          	jalr	-740(ra) # 5832 <exit>

0000000000001b1e <reparent2>:
{
    1b1e:	1101                	add	sp,sp,-32
    1b20:	ec06                	sd	ra,24(sp)
    1b22:	e822                	sd	s0,16(sp)
    1b24:	e426                	sd	s1,8(sp)
    1b26:	1000                	add	s0,sp,32
    1b28:	32000493          	li	s1,800
    int pid1 = fork();
    1b2c:	00004097          	auipc	ra,0x4
    1b30:	cfe080e7          	jalr	-770(ra) # 582a <fork>
    if(pid1 < 0){
    1b34:	00054f63          	bltz	a0,1b52 <reparent2+0x34>
    if(pid1 == 0){
    1b38:	c915                	beqz	a0,1b6c <reparent2+0x4e>
    wait(0);
    1b3a:	4501                	li	a0,0
    1b3c:	00004097          	auipc	ra,0x4
    1b40:	cfe080e7          	jalr	-770(ra) # 583a <wait>
  for(int i = 0; i < 800; i++){
    1b44:	34fd                	addw	s1,s1,-1
    1b46:	f0fd                	bnez	s1,1b2c <reparent2+0xe>
  exit(0);
    1b48:	4501                	li	a0,0
    1b4a:	00004097          	auipc	ra,0x4
    1b4e:	ce8080e7          	jalr	-792(ra) # 5832 <exit>
      printf("fork failed\n");
    1b52:	00005517          	auipc	a0,0x5
    1b56:	e9e50513          	add	a0,a0,-354 # 69f0 <malloc+0xd96>
    1b5a:	00004097          	auipc	ra,0x4
    1b5e:	048080e7          	jalr	72(ra) # 5ba2 <printf>
      exit(1);
    1b62:	4505                	li	a0,1
    1b64:	00004097          	auipc	ra,0x4
    1b68:	cce080e7          	jalr	-818(ra) # 5832 <exit>
      fork();
    1b6c:	00004097          	auipc	ra,0x4
    1b70:	cbe080e7          	jalr	-834(ra) # 582a <fork>
      fork();
    1b74:	00004097          	auipc	ra,0x4
    1b78:	cb6080e7          	jalr	-842(ra) # 582a <fork>
      exit(0);
    1b7c:	4501                	li	a0,0
    1b7e:	00004097          	auipc	ra,0x4
    1b82:	cb4080e7          	jalr	-844(ra) # 5832 <exit>

0000000000001b86 <createdelete>:
{
    1b86:	7175                	add	sp,sp,-144
    1b88:	e506                	sd	ra,136(sp)
    1b8a:	e122                	sd	s0,128(sp)
    1b8c:	fca6                	sd	s1,120(sp)
    1b8e:	f8ca                	sd	s2,112(sp)
    1b90:	f4ce                	sd	s3,104(sp)
    1b92:	f0d2                	sd	s4,96(sp)
    1b94:	ecd6                	sd	s5,88(sp)
    1b96:	e8da                	sd	s6,80(sp)
    1b98:	e4de                	sd	s7,72(sp)
    1b9a:	e0e2                	sd	s8,64(sp)
    1b9c:	fc66                	sd	s9,56(sp)
    1b9e:	0900                	add	s0,sp,144
    1ba0:	8caa                	mv	s9,a0
  for(pi = 0; pi < NCHILD; pi++){
    1ba2:	4901                	li	s2,0
    1ba4:	4991                	li	s3,4
    pid = fork();
    1ba6:	00004097          	auipc	ra,0x4
    1baa:	c84080e7          	jalr	-892(ra) # 582a <fork>
    1bae:	84aa                	mv	s1,a0
    if(pid < 0){
    1bb0:	02054f63          	bltz	a0,1bee <createdelete+0x68>
    if(pid == 0){
    1bb4:	c939                	beqz	a0,1c0a <createdelete+0x84>
  for(pi = 0; pi < NCHILD; pi++){
    1bb6:	2905                	addw	s2,s2,1
    1bb8:	ff3917e3          	bne	s2,s3,1ba6 <createdelete+0x20>
    1bbc:	4491                	li	s1,4
    wait(&xstatus);
    1bbe:	f7c40513          	add	a0,s0,-132
    1bc2:	00004097          	auipc	ra,0x4
    1bc6:	c78080e7          	jalr	-904(ra) # 583a <wait>
    if(xstatus != 0)
    1bca:	f7c42903          	lw	s2,-132(s0)
    1bce:	0e091263          	bnez	s2,1cb2 <createdelete+0x12c>
  for(pi = 0; pi < NCHILD; pi++){
    1bd2:	34fd                	addw	s1,s1,-1
    1bd4:	f4ed                	bnez	s1,1bbe <createdelete+0x38>
  name[0] = name[1] = name[2] = 0;
    1bd6:	f8040123          	sb	zero,-126(s0)
    1bda:	03000993          	li	s3,48
    1bde:	5a7d                	li	s4,-1
    1be0:	07000c13          	li	s8,112
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1be4:	4b21                	li	s6,8
      if((i == 0 || i >= N/2) && fd < 0){
    1be6:	4ba5                	li	s7,9
    for(pi = 0; pi < NCHILD; pi++){
    1be8:	07400a93          	li	s5,116
    1bec:	a29d                	j	1d52 <createdelete+0x1cc>
      printf("fork failed\n", s);
    1bee:	85e6                	mv	a1,s9
    1bf0:	00005517          	auipc	a0,0x5
    1bf4:	e0050513          	add	a0,a0,-512 # 69f0 <malloc+0xd96>
    1bf8:	00004097          	auipc	ra,0x4
    1bfc:	faa080e7          	jalr	-86(ra) # 5ba2 <printf>
      exit(1);
    1c00:	4505                	li	a0,1
    1c02:	00004097          	auipc	ra,0x4
    1c06:	c30080e7          	jalr	-976(ra) # 5832 <exit>
      name[0] = 'p' + pi;
    1c0a:	0709091b          	addw	s2,s2,112
    1c0e:	f9240023          	sb	s2,-128(s0)
      name[2] = '\0';
    1c12:	f8040123          	sb	zero,-126(s0)
      for(i = 0; i < N; i++){
    1c16:	4951                	li	s2,20
    1c18:	a015                	j	1c3c <createdelete+0xb6>
          printf("%s: create failed\n", s);
    1c1a:	85e6                	mv	a1,s9
    1c1c:	00005517          	auipc	a0,0x5
    1c20:	a4c50513          	add	a0,a0,-1460 # 6668 <malloc+0xa0e>
    1c24:	00004097          	auipc	ra,0x4
    1c28:	f7e080e7          	jalr	-130(ra) # 5ba2 <printf>
          exit(1);
    1c2c:	4505                	li	a0,1
    1c2e:	00004097          	auipc	ra,0x4
    1c32:	c04080e7          	jalr	-1020(ra) # 5832 <exit>
      for(i = 0; i < N; i++){
    1c36:	2485                	addw	s1,s1,1
    1c38:	07248863          	beq	s1,s2,1ca8 <createdelete+0x122>
        name[1] = '0' + i;
    1c3c:	0304879b          	addw	a5,s1,48
    1c40:	f8f400a3          	sb	a5,-127(s0)
        fd = open(name, O_CREATE | O_RDWR);
    1c44:	20200593          	li	a1,514
    1c48:	f8040513          	add	a0,s0,-128
    1c4c:	00004097          	auipc	ra,0x4
    1c50:	c26080e7          	jalr	-986(ra) # 5872 <open>
        if(fd < 0){
    1c54:	fc0543e3          	bltz	a0,1c1a <createdelete+0x94>
        close(fd);
    1c58:	00004097          	auipc	ra,0x4
    1c5c:	c02080e7          	jalr	-1022(ra) # 585a <close>
        if(i > 0 && (i % 2 ) == 0){
    1c60:	fc905be3          	blez	s1,1c36 <createdelete+0xb0>
    1c64:	0014f793          	and	a5,s1,1
    1c68:	f7f9                	bnez	a5,1c36 <createdelete+0xb0>
          name[1] = '0' + (i / 2);
    1c6a:	01f4d79b          	srlw	a5,s1,0x1f
    1c6e:	9fa5                	addw	a5,a5,s1
    1c70:	4017d79b          	sraw	a5,a5,0x1
    1c74:	0307879b          	addw	a5,a5,48
    1c78:	f8f400a3          	sb	a5,-127(s0)
          if(unlink(name) < 0){
    1c7c:	f8040513          	add	a0,s0,-128
    1c80:	00004097          	auipc	ra,0x4
    1c84:	c02080e7          	jalr	-1022(ra) # 5882 <unlink>
    1c88:	fa0557e3          	bgez	a0,1c36 <createdelete+0xb0>
            printf("%s: unlink failed\n", s);
    1c8c:	85e6                	mv	a1,s9
    1c8e:	00005517          	auipc	a0,0x5
    1c92:	b3250513          	add	a0,a0,-1230 # 67c0 <malloc+0xb66>
    1c96:	00004097          	auipc	ra,0x4
    1c9a:	f0c080e7          	jalr	-244(ra) # 5ba2 <printf>
            exit(1);
    1c9e:	4505                	li	a0,1
    1ca0:	00004097          	auipc	ra,0x4
    1ca4:	b92080e7          	jalr	-1134(ra) # 5832 <exit>
      exit(0);
    1ca8:	4501                	li	a0,0
    1caa:	00004097          	auipc	ra,0x4
    1cae:	b88080e7          	jalr	-1144(ra) # 5832 <exit>
      exit(1);
    1cb2:	4505                	li	a0,1
    1cb4:	00004097          	auipc	ra,0x4
    1cb8:	b7e080e7          	jalr	-1154(ra) # 5832 <exit>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
    1cbc:	f8040613          	add	a2,s0,-128
    1cc0:	85e6                	mv	a1,s9
    1cc2:	00005517          	auipc	a0,0x5
    1cc6:	b1650513          	add	a0,a0,-1258 # 67d8 <malloc+0xb7e>
    1cca:	00004097          	auipc	ra,0x4
    1cce:	ed8080e7          	jalr	-296(ra) # 5ba2 <printf>
        exit(1);
    1cd2:	4505                	li	a0,1
    1cd4:	00004097          	auipc	ra,0x4
    1cd8:	b5e080e7          	jalr	-1186(ra) # 5832 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1cdc:	054b7163          	bgeu	s6,s4,1d1e <createdelete+0x198>
      if(fd >= 0)
    1ce0:	02055a63          	bgez	a0,1d14 <createdelete+0x18e>
    for(pi = 0; pi < NCHILD; pi++){
    1ce4:	2485                	addw	s1,s1,1
    1ce6:	0ff4f493          	zext.b	s1,s1
    1cea:	05548c63          	beq	s1,s5,1d42 <createdelete+0x1bc>
      name[0] = 'p' + pi;
    1cee:	f8940023          	sb	s1,-128(s0)
      name[1] = '0' + i;
    1cf2:	f93400a3          	sb	s3,-127(s0)
      fd = open(name, 0);
    1cf6:	4581                	li	a1,0
    1cf8:	f8040513          	add	a0,s0,-128
    1cfc:	00004097          	auipc	ra,0x4
    1d00:	b76080e7          	jalr	-1162(ra) # 5872 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    1d04:	00090463          	beqz	s2,1d0c <createdelete+0x186>
    1d08:	fd2bdae3          	bge	s7,s2,1cdc <createdelete+0x156>
    1d0c:	fa0548e3          	bltz	a0,1cbc <createdelete+0x136>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1d10:	014b7963          	bgeu	s6,s4,1d22 <createdelete+0x19c>
        close(fd);
    1d14:	00004097          	auipc	ra,0x4
    1d18:	b46080e7          	jalr	-1210(ra) # 585a <close>
    1d1c:	b7e1                	j	1ce4 <createdelete+0x15e>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1d1e:	fc0543e3          	bltz	a0,1ce4 <createdelete+0x15e>
        printf("%s: oops createdelete %s did exist\n", s, name);
    1d22:	f8040613          	add	a2,s0,-128
    1d26:	85e6                	mv	a1,s9
    1d28:	00005517          	auipc	a0,0x5
    1d2c:	ad850513          	add	a0,a0,-1320 # 6800 <malloc+0xba6>
    1d30:	00004097          	auipc	ra,0x4
    1d34:	e72080e7          	jalr	-398(ra) # 5ba2 <printf>
        exit(1);
    1d38:	4505                	li	a0,1
    1d3a:	00004097          	auipc	ra,0x4
    1d3e:	af8080e7          	jalr	-1288(ra) # 5832 <exit>
  for(i = 0; i < N; i++){
    1d42:	2905                	addw	s2,s2,1
    1d44:	2a05                	addw	s4,s4,1
    1d46:	2985                	addw	s3,s3,1 # 3001 <iputtest+0x8d>
    1d48:	0ff9f993          	zext.b	s3,s3
    1d4c:	47d1                	li	a5,20
    1d4e:	02f90a63          	beq	s2,a5,1d82 <createdelete+0x1fc>
    for(pi = 0; pi < NCHILD; pi++){
    1d52:	84e2                	mv	s1,s8
    1d54:	bf69                	j	1cee <createdelete+0x168>
  for(i = 0; i < N; i++){
    1d56:	2905                	addw	s2,s2,1
    1d58:	0ff97913          	zext.b	s2,s2
    1d5c:	2985                	addw	s3,s3,1
    1d5e:	0ff9f993          	zext.b	s3,s3
    1d62:	03490863          	beq	s2,s4,1d92 <createdelete+0x20c>
  name[0] = name[1] = name[2] = 0;
    1d66:	84d6                	mv	s1,s5
      name[0] = 'p' + i;
    1d68:	f9240023          	sb	s2,-128(s0)
      name[1] = '0' + i;
    1d6c:	f93400a3          	sb	s3,-127(s0)
      unlink(name);
    1d70:	f8040513          	add	a0,s0,-128
    1d74:	00004097          	auipc	ra,0x4
    1d78:	b0e080e7          	jalr	-1266(ra) # 5882 <unlink>
    for(pi = 0; pi < NCHILD; pi++){
    1d7c:	34fd                	addw	s1,s1,-1
    1d7e:	f4ed                	bnez	s1,1d68 <createdelete+0x1e2>
    1d80:	bfd9                	j	1d56 <createdelete+0x1d0>
    1d82:	03000993          	li	s3,48
    1d86:	07000913          	li	s2,112
  name[0] = name[1] = name[2] = 0;
    1d8a:	4a91                	li	s5,4
  for(i = 0; i < N; i++){
    1d8c:	08400a13          	li	s4,132
    1d90:	bfd9                	j	1d66 <createdelete+0x1e0>
}
    1d92:	60aa                	ld	ra,136(sp)
    1d94:	640a                	ld	s0,128(sp)
    1d96:	74e6                	ld	s1,120(sp)
    1d98:	7946                	ld	s2,112(sp)
    1d9a:	79a6                	ld	s3,104(sp)
    1d9c:	7a06                	ld	s4,96(sp)
    1d9e:	6ae6                	ld	s5,88(sp)
    1da0:	6b46                	ld	s6,80(sp)
    1da2:	6ba6                	ld	s7,72(sp)
    1da4:	6c06                	ld	s8,64(sp)
    1da6:	7ce2                	ld	s9,56(sp)
    1da8:	6149                	add	sp,sp,144
    1daa:	8082                	ret

0000000000001dac <linkunlink>:
{
    1dac:	711d                	add	sp,sp,-96
    1dae:	ec86                	sd	ra,88(sp)
    1db0:	e8a2                	sd	s0,80(sp)
    1db2:	e4a6                	sd	s1,72(sp)
    1db4:	e0ca                	sd	s2,64(sp)
    1db6:	fc4e                	sd	s3,56(sp)
    1db8:	f852                	sd	s4,48(sp)
    1dba:	f456                	sd	s5,40(sp)
    1dbc:	f05a                	sd	s6,32(sp)
    1dbe:	ec5e                	sd	s7,24(sp)
    1dc0:	e862                	sd	s8,16(sp)
    1dc2:	e466                	sd	s9,8(sp)
    1dc4:	1080                	add	s0,sp,96
    1dc6:	84aa                	mv	s1,a0
  unlink("x");
    1dc8:	00004517          	auipc	a0,0x4
    1dcc:	02050513          	add	a0,a0,32 # 5de8 <malloc+0x18e>
    1dd0:	00004097          	auipc	ra,0x4
    1dd4:	ab2080e7          	jalr	-1358(ra) # 5882 <unlink>
  pid = fork();
    1dd8:	00004097          	auipc	ra,0x4
    1ddc:	a52080e7          	jalr	-1454(ra) # 582a <fork>
  if(pid < 0){
    1de0:	02054b63          	bltz	a0,1e16 <linkunlink+0x6a>
    1de4:	8c2a                	mv	s8,a0
  unsigned int x = (pid ? 1 : 97);
    1de6:	06100c93          	li	s9,97
    1dea:	c111                	beqz	a0,1dee <linkunlink+0x42>
    1dec:	4c85                	li	s9,1
    1dee:	06400493          	li	s1,100
    x = x * 1103515245 + 12345;
    1df2:	41c659b7          	lui	s3,0x41c65
    1df6:	e6d9899b          	addw	s3,s3,-403 # 41c64e6d <__BSS_END__+0x41c560a5>
    1dfa:	690d                	lui	s2,0x3
    1dfc:	0399091b          	addw	s2,s2,57 # 3039 <iputtest+0xc5>
    if((x % 3) == 0){
    1e00:	4a0d                	li	s4,3
    } else if((x % 3) == 1){
    1e02:	4b05                	li	s6,1
      unlink("x");
    1e04:	00004a97          	auipc	s5,0x4
    1e08:	fe4a8a93          	add	s5,s5,-28 # 5de8 <malloc+0x18e>
      link("cat", "x");
    1e0c:	00005b97          	auipc	s7,0x5
    1e10:	a1cb8b93          	add	s7,s7,-1508 # 6828 <malloc+0xbce>
    1e14:	a825                	j	1e4c <linkunlink+0xa0>
    printf("%s: fork failed\n", s);
    1e16:	85a6                	mv	a1,s1
    1e18:	00004517          	auipc	a0,0x4
    1e1c:	7b850513          	add	a0,a0,1976 # 65d0 <malloc+0x976>
    1e20:	00004097          	auipc	ra,0x4
    1e24:	d82080e7          	jalr	-638(ra) # 5ba2 <printf>
    exit(1);
    1e28:	4505                	li	a0,1
    1e2a:	00004097          	auipc	ra,0x4
    1e2e:	a08080e7          	jalr	-1528(ra) # 5832 <exit>
      close(open("x", O_RDWR | O_CREATE));
    1e32:	20200593          	li	a1,514
    1e36:	8556                	mv	a0,s5
    1e38:	00004097          	auipc	ra,0x4
    1e3c:	a3a080e7          	jalr	-1478(ra) # 5872 <open>
    1e40:	00004097          	auipc	ra,0x4
    1e44:	a1a080e7          	jalr	-1510(ra) # 585a <close>
  for(i = 0; i < 100; i++){
    1e48:	34fd                	addw	s1,s1,-1
    1e4a:	c88d                	beqz	s1,1e7c <linkunlink+0xd0>
    x = x * 1103515245 + 12345;
    1e4c:	033c87bb          	mulw	a5,s9,s3
    1e50:	012787bb          	addw	a5,a5,s2
    1e54:	00078c9b          	sext.w	s9,a5
    if((x % 3) == 0){
    1e58:	0347f7bb          	remuw	a5,a5,s4
    1e5c:	dbf9                	beqz	a5,1e32 <linkunlink+0x86>
    } else if((x % 3) == 1){
    1e5e:	01678863          	beq	a5,s6,1e6e <linkunlink+0xc2>
      unlink("x");
    1e62:	8556                	mv	a0,s5
    1e64:	00004097          	auipc	ra,0x4
    1e68:	a1e080e7          	jalr	-1506(ra) # 5882 <unlink>
    1e6c:	bff1                	j	1e48 <linkunlink+0x9c>
      link("cat", "x");
    1e6e:	85d6                	mv	a1,s5
    1e70:	855e                	mv	a0,s7
    1e72:	00004097          	auipc	ra,0x4
    1e76:	a20080e7          	jalr	-1504(ra) # 5892 <link>
    1e7a:	b7f9                	j	1e48 <linkunlink+0x9c>
  if(pid)
    1e7c:	020c0463          	beqz	s8,1ea4 <linkunlink+0xf8>
    wait(0);
    1e80:	4501                	li	a0,0
    1e82:	00004097          	auipc	ra,0x4
    1e86:	9b8080e7          	jalr	-1608(ra) # 583a <wait>
}
    1e8a:	60e6                	ld	ra,88(sp)
    1e8c:	6446                	ld	s0,80(sp)
    1e8e:	64a6                	ld	s1,72(sp)
    1e90:	6906                	ld	s2,64(sp)
    1e92:	79e2                	ld	s3,56(sp)
    1e94:	7a42                	ld	s4,48(sp)
    1e96:	7aa2                	ld	s5,40(sp)
    1e98:	7b02                	ld	s6,32(sp)
    1e9a:	6be2                	ld	s7,24(sp)
    1e9c:	6c42                	ld	s8,16(sp)
    1e9e:	6ca2                	ld	s9,8(sp)
    1ea0:	6125                	add	sp,sp,96
    1ea2:	8082                	ret
    exit(0);
    1ea4:	4501                	li	a0,0
    1ea6:	00004097          	auipc	ra,0x4
    1eaa:	98c080e7          	jalr	-1652(ra) # 5832 <exit>

0000000000001eae <manywrites>:
{
    1eae:	711d                	add	sp,sp,-96
    1eb0:	ec86                	sd	ra,88(sp)
    1eb2:	e8a2                	sd	s0,80(sp)
    1eb4:	e4a6                	sd	s1,72(sp)
    1eb6:	e0ca                	sd	s2,64(sp)
    1eb8:	fc4e                	sd	s3,56(sp)
    1eba:	f852                	sd	s4,48(sp)
    1ebc:	f456                	sd	s5,40(sp)
    1ebe:	f05a                	sd	s6,32(sp)
    1ec0:	ec5e                	sd	s7,24(sp)
    1ec2:	1080                	add	s0,sp,96
    1ec4:	8aaa                	mv	s5,a0
  for(int ci = 0; ci < nchildren; ci++){
    1ec6:	4981                	li	s3,0
    1ec8:	4911                	li	s2,4
    int pid = fork();
    1eca:	00004097          	auipc	ra,0x4
    1ece:	960080e7          	jalr	-1696(ra) # 582a <fork>
    1ed2:	84aa                	mv	s1,a0
    if(pid < 0){
    1ed4:	02054963          	bltz	a0,1f06 <manywrites+0x58>
    if(pid == 0){
    1ed8:	c521                	beqz	a0,1f20 <manywrites+0x72>
  for(int ci = 0; ci < nchildren; ci++){
    1eda:	2985                	addw	s3,s3,1
    1edc:	ff2997e3          	bne	s3,s2,1eca <manywrites+0x1c>
    1ee0:	4491                	li	s1,4
    int st = 0;
    1ee2:	fa042423          	sw	zero,-88(s0)
    wait(&st);
    1ee6:	fa840513          	add	a0,s0,-88
    1eea:	00004097          	auipc	ra,0x4
    1eee:	950080e7          	jalr	-1712(ra) # 583a <wait>
    if(st != 0)
    1ef2:	fa842503          	lw	a0,-88(s0)
    1ef6:	ed6d                	bnez	a0,1ff0 <manywrites+0x142>
  for(int ci = 0; ci < nchildren; ci++){
    1ef8:	34fd                	addw	s1,s1,-1
    1efa:	f4e5                	bnez	s1,1ee2 <manywrites+0x34>
  exit(0);
    1efc:	4501                	li	a0,0
    1efe:	00004097          	auipc	ra,0x4
    1f02:	934080e7          	jalr	-1740(ra) # 5832 <exit>
      printf("fork failed\n");
    1f06:	00005517          	auipc	a0,0x5
    1f0a:	aea50513          	add	a0,a0,-1302 # 69f0 <malloc+0xd96>
    1f0e:	00004097          	auipc	ra,0x4
    1f12:	c94080e7          	jalr	-876(ra) # 5ba2 <printf>
      exit(1);
    1f16:	4505                	li	a0,1
    1f18:	00004097          	auipc	ra,0x4
    1f1c:	91a080e7          	jalr	-1766(ra) # 5832 <exit>
      name[0] = 'b';
    1f20:	06200793          	li	a5,98
    1f24:	faf40423          	sb	a5,-88(s0)
      name[1] = 'a' + ci;
    1f28:	0619879b          	addw	a5,s3,97
    1f2c:	faf404a3          	sb	a5,-87(s0)
      name[2] = '\0';
    1f30:	fa040523          	sb	zero,-86(s0)
      unlink(name);
    1f34:	fa840513          	add	a0,s0,-88
    1f38:	00004097          	auipc	ra,0x4
    1f3c:	94a080e7          	jalr	-1718(ra) # 5882 <unlink>
    1f40:	4bf9                	li	s7,30
          int cc = write(fd, buf, sz);
    1f42:	0000ab17          	auipc	s6,0xa
    1f46:	e76b0b13          	add	s6,s6,-394 # bdb8 <buf>
        for(int i = 0; i < ci+1; i++){
    1f4a:	8a26                	mv	s4,s1
    1f4c:	0209ce63          	bltz	s3,1f88 <manywrites+0xda>
          int fd = open(name, O_CREATE | O_RDWR);
    1f50:	20200593          	li	a1,514
    1f54:	fa840513          	add	a0,s0,-88
    1f58:	00004097          	auipc	ra,0x4
    1f5c:	91a080e7          	jalr	-1766(ra) # 5872 <open>
    1f60:	892a                	mv	s2,a0
          if(fd < 0){
    1f62:	04054763          	bltz	a0,1fb0 <manywrites+0x102>
          int cc = write(fd, buf, sz);
    1f66:	660d                	lui	a2,0x3
    1f68:	85da                	mv	a1,s6
    1f6a:	00004097          	auipc	ra,0x4
    1f6e:	8e8080e7          	jalr	-1816(ra) # 5852 <write>
          if(cc != sz){
    1f72:	678d                	lui	a5,0x3
    1f74:	04f51e63          	bne	a0,a5,1fd0 <manywrites+0x122>
          close(fd);
    1f78:	854a                	mv	a0,s2
    1f7a:	00004097          	auipc	ra,0x4
    1f7e:	8e0080e7          	jalr	-1824(ra) # 585a <close>
        for(int i = 0; i < ci+1; i++){
    1f82:	2a05                	addw	s4,s4,1
    1f84:	fd49d6e3          	bge	s3,s4,1f50 <manywrites+0xa2>
        unlink(name);
    1f88:	fa840513          	add	a0,s0,-88
    1f8c:	00004097          	auipc	ra,0x4
    1f90:	8f6080e7          	jalr	-1802(ra) # 5882 <unlink>
      for(int iters = 0; iters < howmany; iters++){
    1f94:	3bfd                	addw	s7,s7,-1
    1f96:	fa0b9ae3          	bnez	s7,1f4a <manywrites+0x9c>
      unlink(name);
    1f9a:	fa840513          	add	a0,s0,-88
    1f9e:	00004097          	auipc	ra,0x4
    1fa2:	8e4080e7          	jalr	-1820(ra) # 5882 <unlink>
      exit(0);
    1fa6:	4501                	li	a0,0
    1fa8:	00004097          	auipc	ra,0x4
    1fac:	88a080e7          	jalr	-1910(ra) # 5832 <exit>
            printf("%s: cannot create %s\n", s, name);
    1fb0:	fa840613          	add	a2,s0,-88
    1fb4:	85d6                	mv	a1,s5
    1fb6:	00005517          	auipc	a0,0x5
    1fba:	87a50513          	add	a0,a0,-1926 # 6830 <malloc+0xbd6>
    1fbe:	00004097          	auipc	ra,0x4
    1fc2:	be4080e7          	jalr	-1052(ra) # 5ba2 <printf>
            exit(1);
    1fc6:	4505                	li	a0,1
    1fc8:	00004097          	auipc	ra,0x4
    1fcc:	86a080e7          	jalr	-1942(ra) # 5832 <exit>
            printf("%s: write(%d) ret %d\n", s, sz, cc);
    1fd0:	86aa                	mv	a3,a0
    1fd2:	660d                	lui	a2,0x3
    1fd4:	85d6                	mv	a1,s5
    1fd6:	00004517          	auipc	a0,0x4
    1fda:	e7250513          	add	a0,a0,-398 # 5e48 <malloc+0x1ee>
    1fde:	00004097          	auipc	ra,0x4
    1fe2:	bc4080e7          	jalr	-1084(ra) # 5ba2 <printf>
            exit(1);
    1fe6:	4505                	li	a0,1
    1fe8:	00004097          	auipc	ra,0x4
    1fec:	84a080e7          	jalr	-1974(ra) # 5832 <exit>
      exit(st);
    1ff0:	00004097          	auipc	ra,0x4
    1ff4:	842080e7          	jalr	-1982(ra) # 5832 <exit>

0000000000001ff8 <forktest>:
{
    1ff8:	7179                	add	sp,sp,-48
    1ffa:	f406                	sd	ra,40(sp)
    1ffc:	f022                	sd	s0,32(sp)
    1ffe:	ec26                	sd	s1,24(sp)
    2000:	e84a                	sd	s2,16(sp)
    2002:	e44e                	sd	s3,8(sp)
    2004:	1800                	add	s0,sp,48
    2006:	89aa                	mv	s3,a0
  for(n=0; n<N; n++){
    2008:	4481                	li	s1,0
    200a:	3e800913          	li	s2,1000
    pid = fork();
    200e:	00004097          	auipc	ra,0x4
    2012:	81c080e7          	jalr	-2020(ra) # 582a <fork>
    if(pid < 0)
    2016:	02054863          	bltz	a0,2046 <forktest+0x4e>
    if(pid == 0)
    201a:	c115                	beqz	a0,203e <forktest+0x46>
  for(n=0; n<N; n++){
    201c:	2485                	addw	s1,s1,1
    201e:	ff2498e3          	bne	s1,s2,200e <forktest+0x16>
    printf("%s: fork claimed to work 1000 times!\n", s);
    2022:	85ce                	mv	a1,s3
    2024:	00005517          	auipc	a0,0x5
    2028:	83c50513          	add	a0,a0,-1988 # 6860 <malloc+0xc06>
    202c:	00004097          	auipc	ra,0x4
    2030:	b76080e7          	jalr	-1162(ra) # 5ba2 <printf>
    exit(1);
    2034:	4505                	li	a0,1
    2036:	00003097          	auipc	ra,0x3
    203a:	7fc080e7          	jalr	2044(ra) # 5832 <exit>
      exit(0);
    203e:	00003097          	auipc	ra,0x3
    2042:	7f4080e7          	jalr	2036(ra) # 5832 <exit>
  if (n == 0) {
    2046:	cc9d                	beqz	s1,2084 <forktest+0x8c>
  if(n == N){
    2048:	3e800793          	li	a5,1000
    204c:	fcf48be3          	beq	s1,a5,2022 <forktest+0x2a>
  for(; n > 0; n--){
    2050:	00905b63          	blez	s1,2066 <forktest+0x6e>
    if(wait(0) < 0){
    2054:	4501                	li	a0,0
    2056:	00003097          	auipc	ra,0x3
    205a:	7e4080e7          	jalr	2020(ra) # 583a <wait>
    205e:	04054163          	bltz	a0,20a0 <forktest+0xa8>
  for(; n > 0; n--){
    2062:	34fd                	addw	s1,s1,-1
    2064:	f8e5                	bnez	s1,2054 <forktest+0x5c>
  if(wait(0) != -1){
    2066:	4501                	li	a0,0
    2068:	00003097          	auipc	ra,0x3
    206c:	7d2080e7          	jalr	2002(ra) # 583a <wait>
    2070:	57fd                	li	a5,-1
    2072:	04f51563          	bne	a0,a5,20bc <forktest+0xc4>
}
    2076:	70a2                	ld	ra,40(sp)
    2078:	7402                	ld	s0,32(sp)
    207a:	64e2                	ld	s1,24(sp)
    207c:	6942                	ld	s2,16(sp)
    207e:	69a2                	ld	s3,8(sp)
    2080:	6145                	add	sp,sp,48
    2082:	8082                	ret
    printf("%s: no fork at all!\n", s);
    2084:	85ce                	mv	a1,s3
    2086:	00004517          	auipc	a0,0x4
    208a:	7c250513          	add	a0,a0,1986 # 6848 <malloc+0xbee>
    208e:	00004097          	auipc	ra,0x4
    2092:	b14080e7          	jalr	-1260(ra) # 5ba2 <printf>
    exit(1);
    2096:	4505                	li	a0,1
    2098:	00003097          	auipc	ra,0x3
    209c:	79a080e7          	jalr	1946(ra) # 5832 <exit>
      printf("%s: wait stopped early\n", s);
    20a0:	85ce                	mv	a1,s3
    20a2:	00004517          	auipc	a0,0x4
    20a6:	7e650513          	add	a0,a0,2022 # 6888 <malloc+0xc2e>
    20aa:	00004097          	auipc	ra,0x4
    20ae:	af8080e7          	jalr	-1288(ra) # 5ba2 <printf>
      exit(1);
    20b2:	4505                	li	a0,1
    20b4:	00003097          	auipc	ra,0x3
    20b8:	77e080e7          	jalr	1918(ra) # 5832 <exit>
    printf("%s: wait got too many\n", s);
    20bc:	85ce                	mv	a1,s3
    20be:	00004517          	auipc	a0,0x4
    20c2:	7e250513          	add	a0,a0,2018 # 68a0 <malloc+0xc46>
    20c6:	00004097          	auipc	ra,0x4
    20ca:	adc080e7          	jalr	-1316(ra) # 5ba2 <printf>
    exit(1);
    20ce:	4505                	li	a0,1
    20d0:	00003097          	auipc	ra,0x3
    20d4:	762080e7          	jalr	1890(ra) # 5832 <exit>

00000000000020d8 <kernmem>:
{
    20d8:	715d                	add	sp,sp,-80
    20da:	e486                	sd	ra,72(sp)
    20dc:	e0a2                	sd	s0,64(sp)
    20de:	fc26                	sd	s1,56(sp)
    20e0:	f84a                	sd	s2,48(sp)
    20e2:	f44e                	sd	s3,40(sp)
    20e4:	f052                	sd	s4,32(sp)
    20e6:	ec56                	sd	s5,24(sp)
    20e8:	0880                	add	s0,sp,80
    20ea:	8a2a                	mv	s4,a0
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    20ec:	4485                	li	s1,1
    20ee:	04fe                	sll	s1,s1,0x1f
    if(xstatus != -1)  // did kernel kill child?
    20f0:	5afd                	li	s5,-1
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    20f2:	69b1                	lui	s3,0xc
    20f4:	35098993          	add	s3,s3,848 # c350 <buf+0x598>
    20f8:	1003d937          	lui	s2,0x1003d
    20fc:	090e                	sll	s2,s2,0x3
    20fe:	48090913          	add	s2,s2,1152 # 1003d480 <__BSS_END__+0x1002e6b8>
    pid = fork();
    2102:	00003097          	auipc	ra,0x3
    2106:	728080e7          	jalr	1832(ra) # 582a <fork>
    if(pid < 0){
    210a:	02054963          	bltz	a0,213c <kernmem+0x64>
    if(pid == 0){
    210e:	c529                	beqz	a0,2158 <kernmem+0x80>
    wait(&xstatus);
    2110:	fbc40513          	add	a0,s0,-68
    2114:	00003097          	auipc	ra,0x3
    2118:	726080e7          	jalr	1830(ra) # 583a <wait>
    if(xstatus != -1)  // did kernel kill child?
    211c:	fbc42783          	lw	a5,-68(s0)
    2120:	05579d63          	bne	a5,s5,217a <kernmem+0xa2>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2124:	94ce                	add	s1,s1,s3
    2126:	fd249ee3          	bne	s1,s2,2102 <kernmem+0x2a>
}
    212a:	60a6                	ld	ra,72(sp)
    212c:	6406                	ld	s0,64(sp)
    212e:	74e2                	ld	s1,56(sp)
    2130:	7942                	ld	s2,48(sp)
    2132:	79a2                	ld	s3,40(sp)
    2134:	7a02                	ld	s4,32(sp)
    2136:	6ae2                	ld	s5,24(sp)
    2138:	6161                	add	sp,sp,80
    213a:	8082                	ret
      printf("%s: fork failed\n", s);
    213c:	85d2                	mv	a1,s4
    213e:	00004517          	auipc	a0,0x4
    2142:	49250513          	add	a0,a0,1170 # 65d0 <malloc+0x976>
    2146:	00004097          	auipc	ra,0x4
    214a:	a5c080e7          	jalr	-1444(ra) # 5ba2 <printf>
      exit(1);
    214e:	4505                	li	a0,1
    2150:	00003097          	auipc	ra,0x3
    2154:	6e2080e7          	jalr	1762(ra) # 5832 <exit>
      printf("%s: oops could read %x = %x\n", s, a, *a);
    2158:	0004c683          	lbu	a3,0(s1)
    215c:	8626                	mv	a2,s1
    215e:	85d2                	mv	a1,s4
    2160:	00004517          	auipc	a0,0x4
    2164:	75850513          	add	a0,a0,1880 # 68b8 <malloc+0xc5e>
    2168:	00004097          	auipc	ra,0x4
    216c:	a3a080e7          	jalr	-1478(ra) # 5ba2 <printf>
      exit(1);
    2170:	4505                	li	a0,1
    2172:	00003097          	auipc	ra,0x3
    2176:	6c0080e7          	jalr	1728(ra) # 5832 <exit>
      exit(1);
    217a:	4505                	li	a0,1
    217c:	00003097          	auipc	ra,0x3
    2180:	6b6080e7          	jalr	1718(ra) # 5832 <exit>

0000000000002184 <MAXVAplus>:
{
    2184:	7179                	add	sp,sp,-48
    2186:	f406                	sd	ra,40(sp)
    2188:	f022                	sd	s0,32(sp)
    218a:	ec26                	sd	s1,24(sp)
    218c:	e84a                	sd	s2,16(sp)
    218e:	1800                	add	s0,sp,48
  volatile uint64 a = MAXVA;
    2190:	4785                	li	a5,1
    2192:	179a                	sll	a5,a5,0x26
    2194:	fcf43c23          	sd	a5,-40(s0)
  for( ; a != 0; a <<= 1){
    2198:	fd843783          	ld	a5,-40(s0)
    219c:	cf85                	beqz	a5,21d4 <MAXVAplus+0x50>
    219e:	892a                	mv	s2,a0
    if(xstatus != -1)  // did kernel kill child?
    21a0:	54fd                	li	s1,-1
    pid = fork();
    21a2:	00003097          	auipc	ra,0x3
    21a6:	688080e7          	jalr	1672(ra) # 582a <fork>
    if(pid < 0){
    21aa:	02054b63          	bltz	a0,21e0 <MAXVAplus+0x5c>
    if(pid == 0){
    21ae:	c539                	beqz	a0,21fc <MAXVAplus+0x78>
    wait(&xstatus);
    21b0:	fd440513          	add	a0,s0,-44
    21b4:	00003097          	auipc	ra,0x3
    21b8:	686080e7          	jalr	1670(ra) # 583a <wait>
    if(xstatus != -1)  // did kernel kill child?
    21bc:	fd442783          	lw	a5,-44(s0)
    21c0:	06979463          	bne	a5,s1,2228 <MAXVAplus+0xa4>
  for( ; a != 0; a <<= 1){
    21c4:	fd843783          	ld	a5,-40(s0)
    21c8:	0786                	sll	a5,a5,0x1
    21ca:	fcf43c23          	sd	a5,-40(s0)
    21ce:	fd843783          	ld	a5,-40(s0)
    21d2:	fbe1                	bnez	a5,21a2 <MAXVAplus+0x1e>
}
    21d4:	70a2                	ld	ra,40(sp)
    21d6:	7402                	ld	s0,32(sp)
    21d8:	64e2                	ld	s1,24(sp)
    21da:	6942                	ld	s2,16(sp)
    21dc:	6145                	add	sp,sp,48
    21de:	8082                	ret
      printf("%s: fork failed\n", s);
    21e0:	85ca                	mv	a1,s2
    21e2:	00004517          	auipc	a0,0x4
    21e6:	3ee50513          	add	a0,a0,1006 # 65d0 <malloc+0x976>
    21ea:	00004097          	auipc	ra,0x4
    21ee:	9b8080e7          	jalr	-1608(ra) # 5ba2 <printf>
      exit(1);
    21f2:	4505                	li	a0,1
    21f4:	00003097          	auipc	ra,0x3
    21f8:	63e080e7          	jalr	1598(ra) # 5832 <exit>
      *(char*)a = 99;
    21fc:	fd843783          	ld	a5,-40(s0)
    2200:	06300713          	li	a4,99
    2204:	00e78023          	sb	a4,0(a5) # 3000 <iputtest+0x8c>
      printf("%s: oops wrote %x\n", s, a);
    2208:	fd843603          	ld	a2,-40(s0)
    220c:	85ca                	mv	a1,s2
    220e:	00004517          	auipc	a0,0x4
    2212:	6ca50513          	add	a0,a0,1738 # 68d8 <malloc+0xc7e>
    2216:	00004097          	auipc	ra,0x4
    221a:	98c080e7          	jalr	-1652(ra) # 5ba2 <printf>
      exit(1);
    221e:	4505                	li	a0,1
    2220:	00003097          	auipc	ra,0x3
    2224:	612080e7          	jalr	1554(ra) # 5832 <exit>
      exit(1);
    2228:	4505                	li	a0,1
    222a:	00003097          	auipc	ra,0x3
    222e:	608080e7          	jalr	1544(ra) # 5832 <exit>

0000000000002232 <bigargtest>:
{
    2232:	7179                	add	sp,sp,-48
    2234:	f406                	sd	ra,40(sp)
    2236:	f022                	sd	s0,32(sp)
    2238:	ec26                	sd	s1,24(sp)
    223a:	1800                	add	s0,sp,48
    223c:	84aa                	mv	s1,a0
  unlink("bigarg-ok");
    223e:	00004517          	auipc	a0,0x4
    2242:	6b250513          	add	a0,a0,1714 # 68f0 <malloc+0xc96>
    2246:	00003097          	auipc	ra,0x3
    224a:	63c080e7          	jalr	1596(ra) # 5882 <unlink>
  pid = fork();
    224e:	00003097          	auipc	ra,0x3
    2252:	5dc080e7          	jalr	1500(ra) # 582a <fork>
  if(pid == 0){
    2256:	c121                	beqz	a0,2296 <bigargtest+0x64>
  } else if(pid < 0){
    2258:	0a054063          	bltz	a0,22f8 <bigargtest+0xc6>
  wait(&xstatus);
    225c:	fdc40513          	add	a0,s0,-36
    2260:	00003097          	auipc	ra,0x3
    2264:	5da080e7          	jalr	1498(ra) # 583a <wait>
  if(xstatus != 0)
    2268:	fdc42503          	lw	a0,-36(s0)
    226c:	e545                	bnez	a0,2314 <bigargtest+0xe2>
  fd = open("bigarg-ok", 0);
    226e:	4581                	li	a1,0
    2270:	00004517          	auipc	a0,0x4
    2274:	68050513          	add	a0,a0,1664 # 68f0 <malloc+0xc96>
    2278:	00003097          	auipc	ra,0x3
    227c:	5fa080e7          	jalr	1530(ra) # 5872 <open>
  if(fd < 0){
    2280:	08054e63          	bltz	a0,231c <bigargtest+0xea>
  close(fd);
    2284:	00003097          	auipc	ra,0x3
    2288:	5d6080e7          	jalr	1494(ra) # 585a <close>
}
    228c:	70a2                	ld	ra,40(sp)
    228e:	7402                	ld	s0,32(sp)
    2290:	64e2                	ld	s1,24(sp)
    2292:	6145                	add	sp,sp,48
    2294:	8082                	ret
    2296:	00006797          	auipc	a5,0x6
    229a:	30a78793          	add	a5,a5,778 # 85a0 <args.1>
    229e:	00006697          	auipc	a3,0x6
    22a2:	3fa68693          	add	a3,a3,1018 # 8698 <args.1+0xf8>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    22a6:	00004717          	auipc	a4,0x4
    22aa:	65a70713          	add	a4,a4,1626 # 6900 <malloc+0xca6>
    22ae:	e398                	sd	a4,0(a5)
    for(i = 0; i < MAXARG-1; i++)
    22b0:	07a1                	add	a5,a5,8
    22b2:	fed79ee3          	bne	a5,a3,22ae <bigargtest+0x7c>
    args[MAXARG-1] = 0;
    22b6:	00006597          	auipc	a1,0x6
    22ba:	2ea58593          	add	a1,a1,746 # 85a0 <args.1>
    22be:	0e05bc23          	sd	zero,248(a1)
    exec("echo", args);
    22c2:	00004517          	auipc	a0,0x4
    22c6:	ab650513          	add	a0,a0,-1354 # 5d78 <malloc+0x11e>
    22ca:	00003097          	auipc	ra,0x3
    22ce:	5a0080e7          	jalr	1440(ra) # 586a <exec>
    fd = open("bigarg-ok", O_CREATE);
    22d2:	20000593          	li	a1,512
    22d6:	00004517          	auipc	a0,0x4
    22da:	61a50513          	add	a0,a0,1562 # 68f0 <malloc+0xc96>
    22de:	00003097          	auipc	ra,0x3
    22e2:	594080e7          	jalr	1428(ra) # 5872 <open>
    close(fd);
    22e6:	00003097          	auipc	ra,0x3
    22ea:	574080e7          	jalr	1396(ra) # 585a <close>
    exit(0);
    22ee:	4501                	li	a0,0
    22f0:	00003097          	auipc	ra,0x3
    22f4:	542080e7          	jalr	1346(ra) # 5832 <exit>
    printf("%s: bigargtest: fork failed\n", s);
    22f8:	85a6                	mv	a1,s1
    22fa:	00004517          	auipc	a0,0x4
    22fe:	6e650513          	add	a0,a0,1766 # 69e0 <malloc+0xd86>
    2302:	00004097          	auipc	ra,0x4
    2306:	8a0080e7          	jalr	-1888(ra) # 5ba2 <printf>
    exit(1);
    230a:	4505                	li	a0,1
    230c:	00003097          	auipc	ra,0x3
    2310:	526080e7          	jalr	1318(ra) # 5832 <exit>
    exit(xstatus);
    2314:	00003097          	auipc	ra,0x3
    2318:	51e080e7          	jalr	1310(ra) # 5832 <exit>
    printf("%s: bigarg test failed!\n", s);
    231c:	85a6                	mv	a1,s1
    231e:	00004517          	auipc	a0,0x4
    2322:	6e250513          	add	a0,a0,1762 # 6a00 <malloc+0xda6>
    2326:	00004097          	auipc	ra,0x4
    232a:	87c080e7          	jalr	-1924(ra) # 5ba2 <printf>
    exit(1);
    232e:	4505                	li	a0,1
    2330:	00003097          	auipc	ra,0x3
    2334:	502080e7          	jalr	1282(ra) # 5832 <exit>

0000000000002338 <stacktest>:
{
    2338:	7179                	add	sp,sp,-48
    233a:	f406                	sd	ra,40(sp)
    233c:	f022                	sd	s0,32(sp)
    233e:	ec26                	sd	s1,24(sp)
    2340:	1800                	add	s0,sp,48
    2342:	84aa                	mv	s1,a0
  pid = fork();
    2344:	00003097          	auipc	ra,0x3
    2348:	4e6080e7          	jalr	1254(ra) # 582a <fork>
  if(pid == 0) {
    234c:	c115                	beqz	a0,2370 <stacktest+0x38>
  } else if(pid < 0){
    234e:	04054463          	bltz	a0,2396 <stacktest+0x5e>
  wait(&xstatus);
    2352:	fdc40513          	add	a0,s0,-36
    2356:	00003097          	auipc	ra,0x3
    235a:	4e4080e7          	jalr	1252(ra) # 583a <wait>
  if(xstatus == -1)  // kernel killed child?
    235e:	fdc42503          	lw	a0,-36(s0)
    2362:	57fd                	li	a5,-1
    2364:	04f50763          	beq	a0,a5,23b2 <stacktest+0x7a>
    exit(xstatus);
    2368:	00003097          	auipc	ra,0x3
    236c:	4ca080e7          	jalr	1226(ra) # 5832 <exit>

static inline uint64
r_sp()
{
  uint64 x;
  asm volatile("mv %0, sp" : "=r" (x) );
    2370:	870a                	mv	a4,sp
    printf("%s: stacktest: read below stack %p\n", s, *sp);
    2372:	77fd                	lui	a5,0xfffff
    2374:	97ba                	add	a5,a5,a4
    2376:	0007c603          	lbu	a2,0(a5) # fffffffffffff000 <__BSS_END__+0xffffffffffff0238>
    237a:	85a6                	mv	a1,s1
    237c:	00004517          	auipc	a0,0x4
    2380:	6a450513          	add	a0,a0,1700 # 6a20 <malloc+0xdc6>
    2384:	00004097          	auipc	ra,0x4
    2388:	81e080e7          	jalr	-2018(ra) # 5ba2 <printf>
    exit(1);
    238c:	4505                	li	a0,1
    238e:	00003097          	auipc	ra,0x3
    2392:	4a4080e7          	jalr	1188(ra) # 5832 <exit>
    printf("%s: fork failed\n", s);
    2396:	85a6                	mv	a1,s1
    2398:	00004517          	auipc	a0,0x4
    239c:	23850513          	add	a0,a0,568 # 65d0 <malloc+0x976>
    23a0:	00004097          	auipc	ra,0x4
    23a4:	802080e7          	jalr	-2046(ra) # 5ba2 <printf>
    exit(1);
    23a8:	4505                	li	a0,1
    23aa:	00003097          	auipc	ra,0x3
    23ae:	488080e7          	jalr	1160(ra) # 5832 <exit>
    exit(0);
    23b2:	4501                	li	a0,0
    23b4:	00003097          	auipc	ra,0x3
    23b8:	47e080e7          	jalr	1150(ra) # 5832 <exit>

00000000000023bc <copyinstr3>:
{
    23bc:	7179                	add	sp,sp,-48
    23be:	f406                	sd	ra,40(sp)
    23c0:	f022                	sd	s0,32(sp)
    23c2:	ec26                	sd	s1,24(sp)
    23c4:	1800                	add	s0,sp,48
  sbrk(8192);
    23c6:	6509                	lui	a0,0x2
    23c8:	00003097          	auipc	ra,0x3
    23cc:	4f2080e7          	jalr	1266(ra) # 58ba <sbrk>
  uint64 top = (uint64) sbrk(0);
    23d0:	4501                	li	a0,0
    23d2:	00003097          	auipc	ra,0x3
    23d6:	4e8080e7          	jalr	1256(ra) # 58ba <sbrk>
  if((top % PGSIZE) != 0){
    23da:	03451793          	sll	a5,a0,0x34
    23de:	e3c9                	bnez	a5,2460 <copyinstr3+0xa4>
  top = (uint64) sbrk(0);
    23e0:	4501                	li	a0,0
    23e2:	00003097          	auipc	ra,0x3
    23e6:	4d8080e7          	jalr	1240(ra) # 58ba <sbrk>
  if(top % PGSIZE){
    23ea:	03451793          	sll	a5,a0,0x34
    23ee:	e3d9                	bnez	a5,2474 <copyinstr3+0xb8>
  char *b = (char *) (top - 1);
    23f0:	fff50493          	add	s1,a0,-1 # 1fff <forktest+0x7>
  *b = 'x';
    23f4:	07800793          	li	a5,120
    23f8:	fef50fa3          	sb	a5,-1(a0)
  int ret = unlink(b);
    23fc:	8526                	mv	a0,s1
    23fe:	00003097          	auipc	ra,0x3
    2402:	484080e7          	jalr	1156(ra) # 5882 <unlink>
  if(ret != -1){
    2406:	57fd                	li	a5,-1
    2408:	08f51363          	bne	a0,a5,248e <copyinstr3+0xd2>
  int fd = open(b, O_CREATE | O_WRONLY);
    240c:	20100593          	li	a1,513
    2410:	8526                	mv	a0,s1
    2412:	00003097          	auipc	ra,0x3
    2416:	460080e7          	jalr	1120(ra) # 5872 <open>
  if(fd != -1){
    241a:	57fd                	li	a5,-1
    241c:	08f51863          	bne	a0,a5,24ac <copyinstr3+0xf0>
  ret = link(b, b);
    2420:	85a6                	mv	a1,s1
    2422:	8526                	mv	a0,s1
    2424:	00003097          	auipc	ra,0x3
    2428:	46e080e7          	jalr	1134(ra) # 5892 <link>
  if(ret != -1){
    242c:	57fd                	li	a5,-1
    242e:	08f51e63          	bne	a0,a5,24ca <copyinstr3+0x10e>
  char *args[] = { "xx", 0 };
    2432:	00005797          	auipc	a5,0x5
    2436:	29678793          	add	a5,a5,662 # 76c8 <malloc+0x1a6e>
    243a:	fcf43823          	sd	a5,-48(s0)
    243e:	fc043c23          	sd	zero,-40(s0)
  ret = exec(b, args);
    2442:	fd040593          	add	a1,s0,-48
    2446:	8526                	mv	a0,s1
    2448:	00003097          	auipc	ra,0x3
    244c:	422080e7          	jalr	1058(ra) # 586a <exec>
  if(ret != -1){
    2450:	57fd                	li	a5,-1
    2452:	08f51c63          	bne	a0,a5,24ea <copyinstr3+0x12e>
}
    2456:	70a2                	ld	ra,40(sp)
    2458:	7402                	ld	s0,32(sp)
    245a:	64e2                	ld	s1,24(sp)
    245c:	6145                	add	sp,sp,48
    245e:	8082                	ret
    sbrk(PGSIZE - (top % PGSIZE));
    2460:	0347d513          	srl	a0,a5,0x34
    2464:	6785                	lui	a5,0x1
    2466:	40a7853b          	subw	a0,a5,a0
    246a:	00003097          	auipc	ra,0x3
    246e:	450080e7          	jalr	1104(ra) # 58ba <sbrk>
    2472:	b7bd                	j	23e0 <copyinstr3+0x24>
    printf("oops\n");
    2474:	00004517          	auipc	a0,0x4
    2478:	5d450513          	add	a0,a0,1492 # 6a48 <malloc+0xdee>
    247c:	00003097          	auipc	ra,0x3
    2480:	726080e7          	jalr	1830(ra) # 5ba2 <printf>
    exit(1);
    2484:	4505                	li	a0,1
    2486:	00003097          	auipc	ra,0x3
    248a:	3ac080e7          	jalr	940(ra) # 5832 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    248e:	862a                	mv	a2,a0
    2490:	85a6                	mv	a1,s1
    2492:	00004517          	auipc	a0,0x4
    2496:	05e50513          	add	a0,a0,94 # 64f0 <malloc+0x896>
    249a:	00003097          	auipc	ra,0x3
    249e:	708080e7          	jalr	1800(ra) # 5ba2 <printf>
    exit(1);
    24a2:	4505                	li	a0,1
    24a4:	00003097          	auipc	ra,0x3
    24a8:	38e080e7          	jalr	910(ra) # 5832 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    24ac:	862a                	mv	a2,a0
    24ae:	85a6                	mv	a1,s1
    24b0:	00004517          	auipc	a0,0x4
    24b4:	06050513          	add	a0,a0,96 # 6510 <malloc+0x8b6>
    24b8:	00003097          	auipc	ra,0x3
    24bc:	6ea080e7          	jalr	1770(ra) # 5ba2 <printf>
    exit(1);
    24c0:	4505                	li	a0,1
    24c2:	00003097          	auipc	ra,0x3
    24c6:	370080e7          	jalr	880(ra) # 5832 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    24ca:	86aa                	mv	a3,a0
    24cc:	8626                	mv	a2,s1
    24ce:	85a6                	mv	a1,s1
    24d0:	00004517          	auipc	a0,0x4
    24d4:	06050513          	add	a0,a0,96 # 6530 <malloc+0x8d6>
    24d8:	00003097          	auipc	ra,0x3
    24dc:	6ca080e7          	jalr	1738(ra) # 5ba2 <printf>
    exit(1);
    24e0:	4505                	li	a0,1
    24e2:	00003097          	auipc	ra,0x3
    24e6:	350080e7          	jalr	848(ra) # 5832 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    24ea:	567d                	li	a2,-1
    24ec:	85a6                	mv	a1,s1
    24ee:	00004517          	auipc	a0,0x4
    24f2:	06a50513          	add	a0,a0,106 # 6558 <malloc+0x8fe>
    24f6:	00003097          	auipc	ra,0x3
    24fa:	6ac080e7          	jalr	1708(ra) # 5ba2 <printf>
    exit(1);
    24fe:	4505                	li	a0,1
    2500:	00003097          	auipc	ra,0x3
    2504:	332080e7          	jalr	818(ra) # 5832 <exit>

0000000000002508 <rwsbrk>:
{
    2508:	1101                	add	sp,sp,-32
    250a:	ec06                	sd	ra,24(sp)
    250c:	e822                	sd	s0,16(sp)
    250e:	e426                	sd	s1,8(sp)
    2510:	e04a                	sd	s2,0(sp)
    2512:	1000                	add	s0,sp,32
  uint64 a = (uint64) sbrk(8192);
    2514:	6509                	lui	a0,0x2
    2516:	00003097          	auipc	ra,0x3
    251a:	3a4080e7          	jalr	932(ra) # 58ba <sbrk>
  if(a == 0xffffffffffffffffLL) {
    251e:	57fd                	li	a5,-1
    2520:	06f50263          	beq	a0,a5,2584 <rwsbrk+0x7c>
    2524:	84aa                	mv	s1,a0
  if ((uint64) sbrk(-8192) ==  0xffffffffffffffffLL) {
    2526:	7579                	lui	a0,0xffffe
    2528:	00003097          	auipc	ra,0x3
    252c:	392080e7          	jalr	914(ra) # 58ba <sbrk>
    2530:	57fd                	li	a5,-1
    2532:	06f50663          	beq	a0,a5,259e <rwsbrk+0x96>
  fd = open("rwsbrk", O_CREATE|O_WRONLY);
    2536:	20100593          	li	a1,513
    253a:	00004517          	auipc	a0,0x4
    253e:	54e50513          	add	a0,a0,1358 # 6a88 <malloc+0xe2e>
    2542:	00003097          	auipc	ra,0x3
    2546:	330080e7          	jalr	816(ra) # 5872 <open>
    254a:	892a                	mv	s2,a0
  if(fd < 0){
    254c:	06054663          	bltz	a0,25b8 <rwsbrk+0xb0>
  n = write(fd, (void*)(a+4096), 1024);
    2550:	6785                	lui	a5,0x1
    2552:	94be                	add	s1,s1,a5
    2554:	40000613          	li	a2,1024
    2558:	85a6                	mv	a1,s1
    255a:	00003097          	auipc	ra,0x3
    255e:	2f8080e7          	jalr	760(ra) # 5852 <write>
    2562:	862a                	mv	a2,a0
  if(n >= 0){
    2564:	06054763          	bltz	a0,25d2 <rwsbrk+0xca>
    printf("write(fd, %p, 1024) returned %d, not -1\n", a+4096, n);
    2568:	85a6                	mv	a1,s1
    256a:	00004517          	auipc	a0,0x4
    256e:	53e50513          	add	a0,a0,1342 # 6aa8 <malloc+0xe4e>
    2572:	00003097          	auipc	ra,0x3
    2576:	630080e7          	jalr	1584(ra) # 5ba2 <printf>
    exit(1);
    257a:	4505                	li	a0,1
    257c:	00003097          	auipc	ra,0x3
    2580:	2b6080e7          	jalr	694(ra) # 5832 <exit>
    printf("sbrk(rwsbrk) failed\n");
    2584:	00004517          	auipc	a0,0x4
    2588:	4cc50513          	add	a0,a0,1228 # 6a50 <malloc+0xdf6>
    258c:	00003097          	auipc	ra,0x3
    2590:	616080e7          	jalr	1558(ra) # 5ba2 <printf>
    exit(1);
    2594:	4505                	li	a0,1
    2596:	00003097          	auipc	ra,0x3
    259a:	29c080e7          	jalr	668(ra) # 5832 <exit>
    printf("sbrk(rwsbrk) shrink failed\n");
    259e:	00004517          	auipc	a0,0x4
    25a2:	4ca50513          	add	a0,a0,1226 # 6a68 <malloc+0xe0e>
    25a6:	00003097          	auipc	ra,0x3
    25aa:	5fc080e7          	jalr	1532(ra) # 5ba2 <printf>
    exit(1);
    25ae:	4505                	li	a0,1
    25b0:	00003097          	auipc	ra,0x3
    25b4:	282080e7          	jalr	642(ra) # 5832 <exit>
    printf("open(rwsbrk) failed\n");
    25b8:	00004517          	auipc	a0,0x4
    25bc:	4d850513          	add	a0,a0,1240 # 6a90 <malloc+0xe36>
    25c0:	00003097          	auipc	ra,0x3
    25c4:	5e2080e7          	jalr	1506(ra) # 5ba2 <printf>
    exit(1);
    25c8:	4505                	li	a0,1
    25ca:	00003097          	auipc	ra,0x3
    25ce:	268080e7          	jalr	616(ra) # 5832 <exit>
  close(fd);
    25d2:	854a                	mv	a0,s2
    25d4:	00003097          	auipc	ra,0x3
    25d8:	286080e7          	jalr	646(ra) # 585a <close>
  unlink("rwsbrk");
    25dc:	00004517          	auipc	a0,0x4
    25e0:	4ac50513          	add	a0,a0,1196 # 6a88 <malloc+0xe2e>
    25e4:	00003097          	auipc	ra,0x3
    25e8:	29e080e7          	jalr	670(ra) # 5882 <unlink>
  fd = open("README", O_RDONLY);
    25ec:	4581                	li	a1,0
    25ee:	00004517          	auipc	a0,0x4
    25f2:	93250513          	add	a0,a0,-1742 # 5f20 <malloc+0x2c6>
    25f6:	00003097          	auipc	ra,0x3
    25fa:	27c080e7          	jalr	636(ra) # 5872 <open>
    25fe:	892a                	mv	s2,a0
  if(fd < 0){
    2600:	02054963          	bltz	a0,2632 <rwsbrk+0x12a>
  n = read(fd, (void*)(a+4096), 10);
    2604:	4629                	li	a2,10
    2606:	85a6                	mv	a1,s1
    2608:	00003097          	auipc	ra,0x3
    260c:	242080e7          	jalr	578(ra) # 584a <read>
    2610:	862a                	mv	a2,a0
  if(n >= 0){
    2612:	02054d63          	bltz	a0,264c <rwsbrk+0x144>
    printf("read(fd, %p, 10) returned %d, not -1\n", a+4096, n);
    2616:	85a6                	mv	a1,s1
    2618:	00004517          	auipc	a0,0x4
    261c:	4c050513          	add	a0,a0,1216 # 6ad8 <malloc+0xe7e>
    2620:	00003097          	auipc	ra,0x3
    2624:	582080e7          	jalr	1410(ra) # 5ba2 <printf>
    exit(1);
    2628:	4505                	li	a0,1
    262a:	00003097          	auipc	ra,0x3
    262e:	208080e7          	jalr	520(ra) # 5832 <exit>
    printf("open(rwsbrk) failed\n");
    2632:	00004517          	auipc	a0,0x4
    2636:	45e50513          	add	a0,a0,1118 # 6a90 <malloc+0xe36>
    263a:	00003097          	auipc	ra,0x3
    263e:	568080e7          	jalr	1384(ra) # 5ba2 <printf>
    exit(1);
    2642:	4505                	li	a0,1
    2644:	00003097          	auipc	ra,0x3
    2648:	1ee080e7          	jalr	494(ra) # 5832 <exit>
  close(fd);
    264c:	854a                	mv	a0,s2
    264e:	00003097          	auipc	ra,0x3
    2652:	20c080e7          	jalr	524(ra) # 585a <close>
  exit(0);
    2656:	4501                	li	a0,0
    2658:	00003097          	auipc	ra,0x3
    265c:	1da080e7          	jalr	474(ra) # 5832 <exit>

0000000000002660 <sbrkbasic>:
{
    2660:	7139                	add	sp,sp,-64
    2662:	fc06                	sd	ra,56(sp)
    2664:	f822                	sd	s0,48(sp)
    2666:	f426                	sd	s1,40(sp)
    2668:	f04a                	sd	s2,32(sp)
    266a:	ec4e                	sd	s3,24(sp)
    266c:	e852                	sd	s4,16(sp)
    266e:	0080                	add	s0,sp,64
    2670:	8a2a                	mv	s4,a0
  pid = fork();
    2672:	00003097          	auipc	ra,0x3
    2676:	1b8080e7          	jalr	440(ra) # 582a <fork>
  if(pid < 0){
    267a:	02054c63          	bltz	a0,26b2 <sbrkbasic+0x52>
  if(pid == 0){
    267e:	ed21                	bnez	a0,26d6 <sbrkbasic+0x76>
    a = sbrk(TOOMUCH);
    2680:	40000537          	lui	a0,0x40000
    2684:	00003097          	auipc	ra,0x3
    2688:	236080e7          	jalr	566(ra) # 58ba <sbrk>
    if(a == (char*)0xffffffffffffffffL){
    268c:	57fd                	li	a5,-1
    268e:	02f50f63          	beq	a0,a5,26cc <sbrkbasic+0x6c>
    for(b = a; b < a+TOOMUCH; b += 4096){
    2692:	400007b7          	lui	a5,0x40000
    2696:	97aa                	add	a5,a5,a0
      *b = 99;
    2698:	06300693          	li	a3,99
    for(b = a; b < a+TOOMUCH; b += 4096){
    269c:	6705                	lui	a4,0x1
      *b = 99;
    269e:	00d50023          	sb	a3,0(a0) # 40000000 <__BSS_END__+0x3fff1238>
    for(b = a; b < a+TOOMUCH; b += 4096){
    26a2:	953a                	add	a0,a0,a4
    26a4:	fef51de3          	bne	a0,a5,269e <sbrkbasic+0x3e>
    exit(1);
    26a8:	4505                	li	a0,1
    26aa:	00003097          	auipc	ra,0x3
    26ae:	188080e7          	jalr	392(ra) # 5832 <exit>
    printf("fork failed in sbrkbasic\n");
    26b2:	00004517          	auipc	a0,0x4
    26b6:	44e50513          	add	a0,a0,1102 # 6b00 <malloc+0xea6>
    26ba:	00003097          	auipc	ra,0x3
    26be:	4e8080e7          	jalr	1256(ra) # 5ba2 <printf>
    exit(1);
    26c2:	4505                	li	a0,1
    26c4:	00003097          	auipc	ra,0x3
    26c8:	16e080e7          	jalr	366(ra) # 5832 <exit>
      exit(0);
    26cc:	4501                	li	a0,0
    26ce:	00003097          	auipc	ra,0x3
    26d2:	164080e7          	jalr	356(ra) # 5832 <exit>
  wait(&xstatus);
    26d6:	fcc40513          	add	a0,s0,-52
    26da:	00003097          	auipc	ra,0x3
    26de:	160080e7          	jalr	352(ra) # 583a <wait>
  if(xstatus == 1){
    26e2:	fcc42703          	lw	a4,-52(s0)
    26e6:	4785                	li	a5,1
    26e8:	00f70d63          	beq	a4,a5,2702 <sbrkbasic+0xa2>
  a = sbrk(0);
    26ec:	4501                	li	a0,0
    26ee:	00003097          	auipc	ra,0x3
    26f2:	1cc080e7          	jalr	460(ra) # 58ba <sbrk>
    26f6:	84aa                	mv	s1,a0
  for(i = 0; i < 5000; i++){
    26f8:	4901                	li	s2,0
    26fa:	6985                	lui	s3,0x1
    26fc:	38898993          	add	s3,s3,904 # 1388 <copyinstr2+0x1d8>
    2700:	a005                	j	2720 <sbrkbasic+0xc0>
    printf("%s: too much memory allocated!\n", s);
    2702:	85d2                	mv	a1,s4
    2704:	00004517          	auipc	a0,0x4
    2708:	41c50513          	add	a0,a0,1052 # 6b20 <malloc+0xec6>
    270c:	00003097          	auipc	ra,0x3
    2710:	496080e7          	jalr	1174(ra) # 5ba2 <printf>
    exit(1);
    2714:	4505                	li	a0,1
    2716:	00003097          	auipc	ra,0x3
    271a:	11c080e7          	jalr	284(ra) # 5832 <exit>
    a = b + 1;
    271e:	84be                	mv	s1,a5
    b = sbrk(1);
    2720:	4505                	li	a0,1
    2722:	00003097          	auipc	ra,0x3
    2726:	198080e7          	jalr	408(ra) # 58ba <sbrk>
    if(b != a){
    272a:	04951c63          	bne	a0,s1,2782 <sbrkbasic+0x122>
    *b = 1;
    272e:	4785                	li	a5,1
    2730:	00f48023          	sb	a5,0(s1)
    a = b + 1;
    2734:	00148793          	add	a5,s1,1
  for(i = 0; i < 5000; i++){
    2738:	2905                	addw	s2,s2,1
    273a:	ff3912e3          	bne	s2,s3,271e <sbrkbasic+0xbe>
  pid = fork();
    273e:	00003097          	auipc	ra,0x3
    2742:	0ec080e7          	jalr	236(ra) # 582a <fork>
    2746:	892a                	mv	s2,a0
  if(pid < 0){
    2748:	04054e63          	bltz	a0,27a4 <sbrkbasic+0x144>
  c = sbrk(1);
    274c:	4505                	li	a0,1
    274e:	00003097          	auipc	ra,0x3
    2752:	16c080e7          	jalr	364(ra) # 58ba <sbrk>
  c = sbrk(1);
    2756:	4505                	li	a0,1
    2758:	00003097          	auipc	ra,0x3
    275c:	162080e7          	jalr	354(ra) # 58ba <sbrk>
  if(c != a + 1){
    2760:	0489                	add	s1,s1,2
    2762:	04a48f63          	beq	s1,a0,27c0 <sbrkbasic+0x160>
    printf("%s: sbrk test failed post-fork\n", s);
    2766:	85d2                	mv	a1,s4
    2768:	00004517          	auipc	a0,0x4
    276c:	41850513          	add	a0,a0,1048 # 6b80 <malloc+0xf26>
    2770:	00003097          	auipc	ra,0x3
    2774:	432080e7          	jalr	1074(ra) # 5ba2 <printf>
    exit(1);
    2778:	4505                	li	a0,1
    277a:	00003097          	auipc	ra,0x3
    277e:	0b8080e7          	jalr	184(ra) # 5832 <exit>
      printf("%s: sbrk test failed %d %x %x\n", s, i, a, b);
    2782:	872a                	mv	a4,a0
    2784:	86a6                	mv	a3,s1
    2786:	864a                	mv	a2,s2
    2788:	85d2                	mv	a1,s4
    278a:	00004517          	auipc	a0,0x4
    278e:	3b650513          	add	a0,a0,950 # 6b40 <malloc+0xee6>
    2792:	00003097          	auipc	ra,0x3
    2796:	410080e7          	jalr	1040(ra) # 5ba2 <printf>
      exit(1);
    279a:	4505                	li	a0,1
    279c:	00003097          	auipc	ra,0x3
    27a0:	096080e7          	jalr	150(ra) # 5832 <exit>
    printf("%s: sbrk test fork failed\n", s);
    27a4:	85d2                	mv	a1,s4
    27a6:	00004517          	auipc	a0,0x4
    27aa:	3ba50513          	add	a0,a0,954 # 6b60 <malloc+0xf06>
    27ae:	00003097          	auipc	ra,0x3
    27b2:	3f4080e7          	jalr	1012(ra) # 5ba2 <printf>
    exit(1);
    27b6:	4505                	li	a0,1
    27b8:	00003097          	auipc	ra,0x3
    27bc:	07a080e7          	jalr	122(ra) # 5832 <exit>
  if(pid == 0)
    27c0:	00091763          	bnez	s2,27ce <sbrkbasic+0x16e>
    exit(0);
    27c4:	4501                	li	a0,0
    27c6:	00003097          	auipc	ra,0x3
    27ca:	06c080e7          	jalr	108(ra) # 5832 <exit>
  wait(&xstatus);
    27ce:	fcc40513          	add	a0,s0,-52
    27d2:	00003097          	auipc	ra,0x3
    27d6:	068080e7          	jalr	104(ra) # 583a <wait>
  exit(xstatus);
    27da:	fcc42503          	lw	a0,-52(s0)
    27de:	00003097          	auipc	ra,0x3
    27e2:	054080e7          	jalr	84(ra) # 5832 <exit>

00000000000027e6 <sbrkmuch>:
{
    27e6:	7179                	add	sp,sp,-48
    27e8:	f406                	sd	ra,40(sp)
    27ea:	f022                	sd	s0,32(sp)
    27ec:	ec26                	sd	s1,24(sp)
    27ee:	e84a                	sd	s2,16(sp)
    27f0:	e44e                	sd	s3,8(sp)
    27f2:	e052                	sd	s4,0(sp)
    27f4:	1800                	add	s0,sp,48
    27f6:	89aa                	mv	s3,a0
  oldbrk = sbrk(0);
    27f8:	4501                	li	a0,0
    27fa:	00003097          	auipc	ra,0x3
    27fe:	0c0080e7          	jalr	192(ra) # 58ba <sbrk>
    2802:	892a                	mv	s2,a0
  a = sbrk(0);
    2804:	4501                	li	a0,0
    2806:	00003097          	auipc	ra,0x3
    280a:	0b4080e7          	jalr	180(ra) # 58ba <sbrk>
    280e:	84aa                	mv	s1,a0
  p = sbrk(amt);
    2810:	06400537          	lui	a0,0x6400
    2814:	9d05                	subw	a0,a0,s1
    2816:	00003097          	auipc	ra,0x3
    281a:	0a4080e7          	jalr	164(ra) # 58ba <sbrk>
  if (p != a) {
    281e:	0ca49863          	bne	s1,a0,28ee <sbrkmuch+0x108>
  char *eee = sbrk(0);
    2822:	4501                	li	a0,0
    2824:	00003097          	auipc	ra,0x3
    2828:	096080e7          	jalr	150(ra) # 58ba <sbrk>
    282c:	87aa                	mv	a5,a0
  for(char *pp = a; pp < eee; pp += 4096)
    282e:	00a4f963          	bgeu	s1,a0,2840 <sbrkmuch+0x5a>
    *pp = 1;
    2832:	4685                	li	a3,1
  for(char *pp = a; pp < eee; pp += 4096)
    2834:	6705                	lui	a4,0x1
    *pp = 1;
    2836:	00d48023          	sb	a3,0(s1)
  for(char *pp = a; pp < eee; pp += 4096)
    283a:	94ba                	add	s1,s1,a4
    283c:	fef4ede3          	bltu	s1,a5,2836 <sbrkmuch+0x50>
  *lastaddr = 99;
    2840:	064007b7          	lui	a5,0x6400
    2844:	06300713          	li	a4,99
    2848:	fee78fa3          	sb	a4,-1(a5) # 63fffff <__BSS_END__+0x63f1237>
  a = sbrk(0);
    284c:	4501                	li	a0,0
    284e:	00003097          	auipc	ra,0x3
    2852:	06c080e7          	jalr	108(ra) # 58ba <sbrk>
    2856:	84aa                	mv	s1,a0
  c = sbrk(-PGSIZE);
    2858:	757d                	lui	a0,0xfffff
    285a:	00003097          	auipc	ra,0x3
    285e:	060080e7          	jalr	96(ra) # 58ba <sbrk>
  if(c == (char*)0xffffffffffffffffL){
    2862:	57fd                	li	a5,-1
    2864:	0af50363          	beq	a0,a5,290a <sbrkmuch+0x124>
  c = sbrk(0);
    2868:	4501                	li	a0,0
    286a:	00003097          	auipc	ra,0x3
    286e:	050080e7          	jalr	80(ra) # 58ba <sbrk>
  if(c != a - PGSIZE){
    2872:	77fd                	lui	a5,0xfffff
    2874:	97a6                	add	a5,a5,s1
    2876:	0af51863          	bne	a0,a5,2926 <sbrkmuch+0x140>
  a = sbrk(0);
    287a:	4501                	li	a0,0
    287c:	00003097          	auipc	ra,0x3
    2880:	03e080e7          	jalr	62(ra) # 58ba <sbrk>
    2884:	84aa                	mv	s1,a0
  c = sbrk(PGSIZE);
    2886:	6505                	lui	a0,0x1
    2888:	00003097          	auipc	ra,0x3
    288c:	032080e7          	jalr	50(ra) # 58ba <sbrk>
    2890:	8a2a                	mv	s4,a0
  if(c != a || sbrk(0) != a + PGSIZE){
    2892:	0aa49a63          	bne	s1,a0,2946 <sbrkmuch+0x160>
    2896:	4501                	li	a0,0
    2898:	00003097          	auipc	ra,0x3
    289c:	022080e7          	jalr	34(ra) # 58ba <sbrk>
    28a0:	6785                	lui	a5,0x1
    28a2:	97a6                	add	a5,a5,s1
    28a4:	0af51163          	bne	a0,a5,2946 <sbrkmuch+0x160>
  if(*lastaddr == 99){
    28a8:	064007b7          	lui	a5,0x6400
    28ac:	fff7c703          	lbu	a4,-1(a5) # 63fffff <__BSS_END__+0x63f1237>
    28b0:	06300793          	li	a5,99
    28b4:	0af70963          	beq	a4,a5,2966 <sbrkmuch+0x180>
  a = sbrk(0);
    28b8:	4501                	li	a0,0
    28ba:	00003097          	auipc	ra,0x3
    28be:	000080e7          	jalr	ra # 58ba <sbrk>
    28c2:	84aa                	mv	s1,a0
  c = sbrk(-(sbrk(0) - oldbrk));
    28c4:	4501                	li	a0,0
    28c6:	00003097          	auipc	ra,0x3
    28ca:	ff4080e7          	jalr	-12(ra) # 58ba <sbrk>
    28ce:	40a9053b          	subw	a0,s2,a0
    28d2:	00003097          	auipc	ra,0x3
    28d6:	fe8080e7          	jalr	-24(ra) # 58ba <sbrk>
  if(c != a){
    28da:	0aa49463          	bne	s1,a0,2982 <sbrkmuch+0x19c>
}
    28de:	70a2                	ld	ra,40(sp)
    28e0:	7402                	ld	s0,32(sp)
    28e2:	64e2                	ld	s1,24(sp)
    28e4:	6942                	ld	s2,16(sp)
    28e6:	69a2                	ld	s3,8(sp)
    28e8:	6a02                	ld	s4,0(sp)
    28ea:	6145                	add	sp,sp,48
    28ec:	8082                	ret
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n", s);
    28ee:	85ce                	mv	a1,s3
    28f0:	00004517          	auipc	a0,0x4
    28f4:	2b050513          	add	a0,a0,688 # 6ba0 <malloc+0xf46>
    28f8:	00003097          	auipc	ra,0x3
    28fc:	2aa080e7          	jalr	682(ra) # 5ba2 <printf>
    exit(1);
    2900:	4505                	li	a0,1
    2902:	00003097          	auipc	ra,0x3
    2906:	f30080e7          	jalr	-208(ra) # 5832 <exit>
    printf("%s: sbrk could not deallocate\n", s);
    290a:	85ce                	mv	a1,s3
    290c:	00004517          	auipc	a0,0x4
    2910:	2dc50513          	add	a0,a0,732 # 6be8 <malloc+0xf8e>
    2914:	00003097          	auipc	ra,0x3
    2918:	28e080e7          	jalr	654(ra) # 5ba2 <printf>
    exit(1);
    291c:	4505                	li	a0,1
    291e:	00003097          	auipc	ra,0x3
    2922:	f14080e7          	jalr	-236(ra) # 5832 <exit>
    printf("%s: sbrk deallocation produced wrong address, a %x c %x\n", s, a, c);
    2926:	86aa                	mv	a3,a0
    2928:	8626                	mv	a2,s1
    292a:	85ce                	mv	a1,s3
    292c:	00004517          	auipc	a0,0x4
    2930:	2dc50513          	add	a0,a0,732 # 6c08 <malloc+0xfae>
    2934:	00003097          	auipc	ra,0x3
    2938:	26e080e7          	jalr	622(ra) # 5ba2 <printf>
    exit(1);
    293c:	4505                	li	a0,1
    293e:	00003097          	auipc	ra,0x3
    2942:	ef4080e7          	jalr	-268(ra) # 5832 <exit>
    printf("%s: sbrk re-allocation failed, a %x c %x\n", s, a, c);
    2946:	86d2                	mv	a3,s4
    2948:	8626                	mv	a2,s1
    294a:	85ce                	mv	a1,s3
    294c:	00004517          	auipc	a0,0x4
    2950:	2fc50513          	add	a0,a0,764 # 6c48 <malloc+0xfee>
    2954:	00003097          	auipc	ra,0x3
    2958:	24e080e7          	jalr	590(ra) # 5ba2 <printf>
    exit(1);
    295c:	4505                	li	a0,1
    295e:	00003097          	auipc	ra,0x3
    2962:	ed4080e7          	jalr	-300(ra) # 5832 <exit>
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    2966:	85ce                	mv	a1,s3
    2968:	00004517          	auipc	a0,0x4
    296c:	31050513          	add	a0,a0,784 # 6c78 <malloc+0x101e>
    2970:	00003097          	auipc	ra,0x3
    2974:	232080e7          	jalr	562(ra) # 5ba2 <printf>
    exit(1);
    2978:	4505                	li	a0,1
    297a:	00003097          	auipc	ra,0x3
    297e:	eb8080e7          	jalr	-328(ra) # 5832 <exit>
    printf("%s: sbrk downsize failed, a %x c %x\n", s, a, c);
    2982:	86aa                	mv	a3,a0
    2984:	8626                	mv	a2,s1
    2986:	85ce                	mv	a1,s3
    2988:	00004517          	auipc	a0,0x4
    298c:	32850513          	add	a0,a0,808 # 6cb0 <malloc+0x1056>
    2990:	00003097          	auipc	ra,0x3
    2994:	212080e7          	jalr	530(ra) # 5ba2 <printf>
    exit(1);
    2998:	4505                	li	a0,1
    299a:	00003097          	auipc	ra,0x3
    299e:	e98080e7          	jalr	-360(ra) # 5832 <exit>

00000000000029a2 <sbrkarg>:
{
    29a2:	7179                	add	sp,sp,-48
    29a4:	f406                	sd	ra,40(sp)
    29a6:	f022                	sd	s0,32(sp)
    29a8:	ec26                	sd	s1,24(sp)
    29aa:	e84a                	sd	s2,16(sp)
    29ac:	e44e                	sd	s3,8(sp)
    29ae:	1800                	add	s0,sp,48
    29b0:	89aa                	mv	s3,a0
  a = sbrk(PGSIZE);
    29b2:	6505                	lui	a0,0x1
    29b4:	00003097          	auipc	ra,0x3
    29b8:	f06080e7          	jalr	-250(ra) # 58ba <sbrk>
    29bc:	892a                	mv	s2,a0
  fd = open("sbrk", O_CREATE|O_WRONLY);
    29be:	20100593          	li	a1,513
    29c2:	00004517          	auipc	a0,0x4
    29c6:	31650513          	add	a0,a0,790 # 6cd8 <malloc+0x107e>
    29ca:	00003097          	auipc	ra,0x3
    29ce:	ea8080e7          	jalr	-344(ra) # 5872 <open>
    29d2:	84aa                	mv	s1,a0
  unlink("sbrk");
    29d4:	00004517          	auipc	a0,0x4
    29d8:	30450513          	add	a0,a0,772 # 6cd8 <malloc+0x107e>
    29dc:	00003097          	auipc	ra,0x3
    29e0:	ea6080e7          	jalr	-346(ra) # 5882 <unlink>
  if(fd < 0)  {
    29e4:	0404c163          	bltz	s1,2a26 <sbrkarg+0x84>
  if ((n = write(fd, a, PGSIZE)) < 0) {
    29e8:	6605                	lui	a2,0x1
    29ea:	85ca                	mv	a1,s2
    29ec:	8526                	mv	a0,s1
    29ee:	00003097          	auipc	ra,0x3
    29f2:	e64080e7          	jalr	-412(ra) # 5852 <write>
    29f6:	04054663          	bltz	a0,2a42 <sbrkarg+0xa0>
  close(fd);
    29fa:	8526                	mv	a0,s1
    29fc:	00003097          	auipc	ra,0x3
    2a00:	e5e080e7          	jalr	-418(ra) # 585a <close>
  a = sbrk(PGSIZE);
    2a04:	6505                	lui	a0,0x1
    2a06:	00003097          	auipc	ra,0x3
    2a0a:	eb4080e7          	jalr	-332(ra) # 58ba <sbrk>
  if(pipe((int *) a) != 0){
    2a0e:	00003097          	auipc	ra,0x3
    2a12:	e34080e7          	jalr	-460(ra) # 5842 <pipe>
    2a16:	e521                	bnez	a0,2a5e <sbrkarg+0xbc>
}
    2a18:	70a2                	ld	ra,40(sp)
    2a1a:	7402                	ld	s0,32(sp)
    2a1c:	64e2                	ld	s1,24(sp)
    2a1e:	6942                	ld	s2,16(sp)
    2a20:	69a2                	ld	s3,8(sp)
    2a22:	6145                	add	sp,sp,48
    2a24:	8082                	ret
    printf("%s: open sbrk failed\n", s);
    2a26:	85ce                	mv	a1,s3
    2a28:	00004517          	auipc	a0,0x4
    2a2c:	2b850513          	add	a0,a0,696 # 6ce0 <malloc+0x1086>
    2a30:	00003097          	auipc	ra,0x3
    2a34:	172080e7          	jalr	370(ra) # 5ba2 <printf>
    exit(1);
    2a38:	4505                	li	a0,1
    2a3a:	00003097          	auipc	ra,0x3
    2a3e:	df8080e7          	jalr	-520(ra) # 5832 <exit>
    printf("%s: write sbrk failed\n", s);
    2a42:	85ce                	mv	a1,s3
    2a44:	00004517          	auipc	a0,0x4
    2a48:	2b450513          	add	a0,a0,692 # 6cf8 <malloc+0x109e>
    2a4c:	00003097          	auipc	ra,0x3
    2a50:	156080e7          	jalr	342(ra) # 5ba2 <printf>
    exit(1);
    2a54:	4505                	li	a0,1
    2a56:	00003097          	auipc	ra,0x3
    2a5a:	ddc080e7          	jalr	-548(ra) # 5832 <exit>
    printf("%s: pipe() failed\n", s);
    2a5e:	85ce                	mv	a1,s3
    2a60:	00004517          	auipc	a0,0x4
    2a64:	c7850513          	add	a0,a0,-904 # 66d8 <malloc+0xa7e>
    2a68:	00003097          	auipc	ra,0x3
    2a6c:	13a080e7          	jalr	314(ra) # 5ba2 <printf>
    exit(1);
    2a70:	4505                	li	a0,1
    2a72:	00003097          	auipc	ra,0x3
    2a76:	dc0080e7          	jalr	-576(ra) # 5832 <exit>

0000000000002a7a <argptest>:
{
    2a7a:	1101                	add	sp,sp,-32
    2a7c:	ec06                	sd	ra,24(sp)
    2a7e:	e822                	sd	s0,16(sp)
    2a80:	e426                	sd	s1,8(sp)
    2a82:	e04a                	sd	s2,0(sp)
    2a84:	1000                	add	s0,sp,32
    2a86:	892a                	mv	s2,a0
  fd = open("init", O_RDONLY);
    2a88:	4581                	li	a1,0
    2a8a:	00004517          	auipc	a0,0x4
    2a8e:	28650513          	add	a0,a0,646 # 6d10 <malloc+0x10b6>
    2a92:	00003097          	auipc	ra,0x3
    2a96:	de0080e7          	jalr	-544(ra) # 5872 <open>
  if (fd < 0) {
    2a9a:	02054b63          	bltz	a0,2ad0 <argptest+0x56>
    2a9e:	84aa                	mv	s1,a0
  read(fd, sbrk(0) - 1, -1);
    2aa0:	4501                	li	a0,0
    2aa2:	00003097          	auipc	ra,0x3
    2aa6:	e18080e7          	jalr	-488(ra) # 58ba <sbrk>
    2aaa:	567d                	li	a2,-1
    2aac:	fff50593          	add	a1,a0,-1
    2ab0:	8526                	mv	a0,s1
    2ab2:	00003097          	auipc	ra,0x3
    2ab6:	d98080e7          	jalr	-616(ra) # 584a <read>
  close(fd);
    2aba:	8526                	mv	a0,s1
    2abc:	00003097          	auipc	ra,0x3
    2ac0:	d9e080e7          	jalr	-610(ra) # 585a <close>
}
    2ac4:	60e2                	ld	ra,24(sp)
    2ac6:	6442                	ld	s0,16(sp)
    2ac8:	64a2                	ld	s1,8(sp)
    2aca:	6902                	ld	s2,0(sp)
    2acc:	6105                	add	sp,sp,32
    2ace:	8082                	ret
    printf("%s: open failed\n", s);
    2ad0:	85ca                	mv	a1,s2
    2ad2:	00004517          	auipc	a0,0x4
    2ad6:	b1650513          	add	a0,a0,-1258 # 65e8 <malloc+0x98e>
    2ada:	00003097          	auipc	ra,0x3
    2ade:	0c8080e7          	jalr	200(ra) # 5ba2 <printf>
    exit(1);
    2ae2:	4505                	li	a0,1
    2ae4:	00003097          	auipc	ra,0x3
    2ae8:	d4e080e7          	jalr	-690(ra) # 5832 <exit>

0000000000002aec <sbrkbugs>:
{
    2aec:	1141                	add	sp,sp,-16
    2aee:	e406                	sd	ra,8(sp)
    2af0:	e022                	sd	s0,0(sp)
    2af2:	0800                	add	s0,sp,16
  int pid = fork();
    2af4:	00003097          	auipc	ra,0x3
    2af8:	d36080e7          	jalr	-714(ra) # 582a <fork>
  if(pid < 0){
    2afc:	02054263          	bltz	a0,2b20 <sbrkbugs+0x34>
  if(pid == 0){
    2b00:	ed0d                	bnez	a0,2b3a <sbrkbugs+0x4e>
    int sz = (uint64) sbrk(0);
    2b02:	00003097          	auipc	ra,0x3
    2b06:	db8080e7          	jalr	-584(ra) # 58ba <sbrk>
    sbrk(-sz);
    2b0a:	40a0053b          	negw	a0,a0
    2b0e:	00003097          	auipc	ra,0x3
    2b12:	dac080e7          	jalr	-596(ra) # 58ba <sbrk>
    exit(0);
    2b16:	4501                	li	a0,0
    2b18:	00003097          	auipc	ra,0x3
    2b1c:	d1a080e7          	jalr	-742(ra) # 5832 <exit>
    printf("fork failed\n");
    2b20:	00004517          	auipc	a0,0x4
    2b24:	ed050513          	add	a0,a0,-304 # 69f0 <malloc+0xd96>
    2b28:	00003097          	auipc	ra,0x3
    2b2c:	07a080e7          	jalr	122(ra) # 5ba2 <printf>
    exit(1);
    2b30:	4505                	li	a0,1
    2b32:	00003097          	auipc	ra,0x3
    2b36:	d00080e7          	jalr	-768(ra) # 5832 <exit>
  wait(0);
    2b3a:	4501                	li	a0,0
    2b3c:	00003097          	auipc	ra,0x3
    2b40:	cfe080e7          	jalr	-770(ra) # 583a <wait>
  pid = fork();
    2b44:	00003097          	auipc	ra,0x3
    2b48:	ce6080e7          	jalr	-794(ra) # 582a <fork>
  if(pid < 0){
    2b4c:	02054563          	bltz	a0,2b76 <sbrkbugs+0x8a>
  if(pid == 0){
    2b50:	e121                	bnez	a0,2b90 <sbrkbugs+0xa4>
    int sz = (uint64) sbrk(0);
    2b52:	00003097          	auipc	ra,0x3
    2b56:	d68080e7          	jalr	-664(ra) # 58ba <sbrk>
    sbrk(-(sz - 3500));
    2b5a:	6785                	lui	a5,0x1
    2b5c:	dac7879b          	addw	a5,a5,-596 # dac <linktest+0x98>
    2b60:	40a7853b          	subw	a0,a5,a0
    2b64:	00003097          	auipc	ra,0x3
    2b68:	d56080e7          	jalr	-682(ra) # 58ba <sbrk>
    exit(0);
    2b6c:	4501                	li	a0,0
    2b6e:	00003097          	auipc	ra,0x3
    2b72:	cc4080e7          	jalr	-828(ra) # 5832 <exit>
    printf("fork failed\n");
    2b76:	00004517          	auipc	a0,0x4
    2b7a:	e7a50513          	add	a0,a0,-390 # 69f0 <malloc+0xd96>
    2b7e:	00003097          	auipc	ra,0x3
    2b82:	024080e7          	jalr	36(ra) # 5ba2 <printf>
    exit(1);
    2b86:	4505                	li	a0,1
    2b88:	00003097          	auipc	ra,0x3
    2b8c:	caa080e7          	jalr	-854(ra) # 5832 <exit>
  wait(0);
    2b90:	4501                	li	a0,0
    2b92:	00003097          	auipc	ra,0x3
    2b96:	ca8080e7          	jalr	-856(ra) # 583a <wait>
  pid = fork();
    2b9a:	00003097          	auipc	ra,0x3
    2b9e:	c90080e7          	jalr	-880(ra) # 582a <fork>
  if(pid < 0){
    2ba2:	02054a63          	bltz	a0,2bd6 <sbrkbugs+0xea>
  if(pid == 0){
    2ba6:	e529                	bnez	a0,2bf0 <sbrkbugs+0x104>
    sbrk((10*4096 + 2048) - (uint64)sbrk(0));
    2ba8:	00003097          	auipc	ra,0x3
    2bac:	d12080e7          	jalr	-750(ra) # 58ba <sbrk>
    2bb0:	67ad                	lui	a5,0xb
    2bb2:	8007879b          	addw	a5,a5,-2048 # a800 <uninit+0x1158>
    2bb6:	40a7853b          	subw	a0,a5,a0
    2bba:	00003097          	auipc	ra,0x3
    2bbe:	d00080e7          	jalr	-768(ra) # 58ba <sbrk>
    sbrk(-10);
    2bc2:	5559                	li	a0,-10
    2bc4:	00003097          	auipc	ra,0x3
    2bc8:	cf6080e7          	jalr	-778(ra) # 58ba <sbrk>
    exit(0);
    2bcc:	4501                	li	a0,0
    2bce:	00003097          	auipc	ra,0x3
    2bd2:	c64080e7          	jalr	-924(ra) # 5832 <exit>
    printf("fork failed\n");
    2bd6:	00004517          	auipc	a0,0x4
    2bda:	e1a50513          	add	a0,a0,-486 # 69f0 <malloc+0xd96>
    2bde:	00003097          	auipc	ra,0x3
    2be2:	fc4080e7          	jalr	-60(ra) # 5ba2 <printf>
    exit(1);
    2be6:	4505                	li	a0,1
    2be8:	00003097          	auipc	ra,0x3
    2bec:	c4a080e7          	jalr	-950(ra) # 5832 <exit>
  wait(0);
    2bf0:	4501                	li	a0,0
    2bf2:	00003097          	auipc	ra,0x3
    2bf6:	c48080e7          	jalr	-952(ra) # 583a <wait>
  exit(0);
    2bfa:	4501                	li	a0,0
    2bfc:	00003097          	auipc	ra,0x3
    2c00:	c36080e7          	jalr	-970(ra) # 5832 <exit>

0000000000002c04 <sbrklast>:
{
    2c04:	7179                	add	sp,sp,-48
    2c06:	f406                	sd	ra,40(sp)
    2c08:	f022                	sd	s0,32(sp)
    2c0a:	ec26                	sd	s1,24(sp)
    2c0c:	e84a                	sd	s2,16(sp)
    2c0e:	e44e                	sd	s3,8(sp)
    2c10:	e052                	sd	s4,0(sp)
    2c12:	1800                	add	s0,sp,48
  uint64 top = (uint64) sbrk(0);
    2c14:	4501                	li	a0,0
    2c16:	00003097          	auipc	ra,0x3
    2c1a:	ca4080e7          	jalr	-860(ra) # 58ba <sbrk>
  if((top % 4096) != 0)
    2c1e:	03451793          	sll	a5,a0,0x34
    2c22:	ebd9                	bnez	a5,2cb8 <sbrklast+0xb4>
  sbrk(4096);
    2c24:	6505                	lui	a0,0x1
    2c26:	00003097          	auipc	ra,0x3
    2c2a:	c94080e7          	jalr	-876(ra) # 58ba <sbrk>
  sbrk(10);
    2c2e:	4529                	li	a0,10
    2c30:	00003097          	auipc	ra,0x3
    2c34:	c8a080e7          	jalr	-886(ra) # 58ba <sbrk>
  sbrk(-20);
    2c38:	5531                	li	a0,-20
    2c3a:	00003097          	auipc	ra,0x3
    2c3e:	c80080e7          	jalr	-896(ra) # 58ba <sbrk>
  top = (uint64) sbrk(0);
    2c42:	4501                	li	a0,0
    2c44:	00003097          	auipc	ra,0x3
    2c48:	c76080e7          	jalr	-906(ra) # 58ba <sbrk>
    2c4c:	84aa                	mv	s1,a0
  char *p = (char *) (top - 64);
    2c4e:	fc050913          	add	s2,a0,-64 # fc0 <bigdir+0x60>
  p[0] = 'x';
    2c52:	07800a13          	li	s4,120
    2c56:	fd450023          	sb	s4,-64(a0)
  p[1] = '\0';
    2c5a:	fc0500a3          	sb	zero,-63(a0)
  int fd = open(p, O_RDWR|O_CREATE);
    2c5e:	20200593          	li	a1,514
    2c62:	854a                	mv	a0,s2
    2c64:	00003097          	auipc	ra,0x3
    2c68:	c0e080e7          	jalr	-1010(ra) # 5872 <open>
    2c6c:	89aa                	mv	s3,a0
  write(fd, p, 1);
    2c6e:	4605                	li	a2,1
    2c70:	85ca                	mv	a1,s2
    2c72:	00003097          	auipc	ra,0x3
    2c76:	be0080e7          	jalr	-1056(ra) # 5852 <write>
  close(fd);
    2c7a:	854e                	mv	a0,s3
    2c7c:	00003097          	auipc	ra,0x3
    2c80:	bde080e7          	jalr	-1058(ra) # 585a <close>
  fd = open(p, O_RDWR);
    2c84:	4589                	li	a1,2
    2c86:	854a                	mv	a0,s2
    2c88:	00003097          	auipc	ra,0x3
    2c8c:	bea080e7          	jalr	-1046(ra) # 5872 <open>
  p[0] = '\0';
    2c90:	fc048023          	sb	zero,-64(s1)
  read(fd, p, 1);
    2c94:	4605                	li	a2,1
    2c96:	85ca                	mv	a1,s2
    2c98:	00003097          	auipc	ra,0x3
    2c9c:	bb2080e7          	jalr	-1102(ra) # 584a <read>
  if(p[0] != 'x')
    2ca0:	fc04c783          	lbu	a5,-64(s1)
    2ca4:	03479463          	bne	a5,s4,2ccc <sbrklast+0xc8>
}
    2ca8:	70a2                	ld	ra,40(sp)
    2caa:	7402                	ld	s0,32(sp)
    2cac:	64e2                	ld	s1,24(sp)
    2cae:	6942                	ld	s2,16(sp)
    2cb0:	69a2                	ld	s3,8(sp)
    2cb2:	6a02                	ld	s4,0(sp)
    2cb4:	6145                	add	sp,sp,48
    2cb6:	8082                	ret
    sbrk(4096 - (top % 4096));
    2cb8:	0347d513          	srl	a0,a5,0x34
    2cbc:	6785                	lui	a5,0x1
    2cbe:	40a7853b          	subw	a0,a5,a0
    2cc2:	00003097          	auipc	ra,0x3
    2cc6:	bf8080e7          	jalr	-1032(ra) # 58ba <sbrk>
    2cca:	bfa9                	j	2c24 <sbrklast+0x20>
    exit(1);
    2ccc:	4505                	li	a0,1
    2cce:	00003097          	auipc	ra,0x3
    2cd2:	b64080e7          	jalr	-1180(ra) # 5832 <exit>

0000000000002cd6 <sbrk8000>:
{
    2cd6:	1141                	add	sp,sp,-16
    2cd8:	e406                	sd	ra,8(sp)
    2cda:	e022                	sd	s0,0(sp)
    2cdc:	0800                	add	s0,sp,16
  sbrk(0x80000004);
    2cde:	80000537          	lui	a0,0x80000
    2ce2:	0511                	add	a0,a0,4 # ffffffff80000004 <__BSS_END__+0xffffffff7fff123c>
    2ce4:	00003097          	auipc	ra,0x3
    2ce8:	bd6080e7          	jalr	-1066(ra) # 58ba <sbrk>
  volatile char *top = sbrk(0);
    2cec:	4501                	li	a0,0
    2cee:	00003097          	auipc	ra,0x3
    2cf2:	bcc080e7          	jalr	-1076(ra) # 58ba <sbrk>
  *(top-1) = *(top-1) + 1;
    2cf6:	fff54783          	lbu	a5,-1(a0)
    2cfa:	2785                	addw	a5,a5,1 # 1001 <bigdir+0xa1>
    2cfc:	0ff7f793          	zext.b	a5,a5
    2d00:	fef50fa3          	sb	a5,-1(a0)
}
    2d04:	60a2                	ld	ra,8(sp)
    2d06:	6402                	ld	s0,0(sp)
    2d08:	0141                	add	sp,sp,16
    2d0a:	8082                	ret

0000000000002d0c <execout>:
// test the exec() code that cleans up if it runs out
// of memory. it's really a test that such a condition
// doesn't cause a panic.
void
execout(char *s)
{
    2d0c:	715d                	add	sp,sp,-80
    2d0e:	e486                	sd	ra,72(sp)
    2d10:	e0a2                	sd	s0,64(sp)
    2d12:	fc26                	sd	s1,56(sp)
    2d14:	f84a                	sd	s2,48(sp)
    2d16:	f44e                	sd	s3,40(sp)
    2d18:	f052                	sd	s4,32(sp)
    2d1a:	0880                	add	s0,sp,80
  for(int avail = 0; avail < 15; avail++){
    2d1c:	4901                	li	s2,0
    2d1e:	49bd                	li	s3,15
    int pid = fork();
    2d20:	00003097          	auipc	ra,0x3
    2d24:	b0a080e7          	jalr	-1270(ra) # 582a <fork>
    2d28:	84aa                	mv	s1,a0
    if(pid < 0){
    2d2a:	02054063          	bltz	a0,2d4a <execout+0x3e>
      printf("fork failed\n");
      exit(1);
    } else if(pid == 0){
    2d2e:	c91d                	beqz	a0,2d64 <execout+0x58>
      close(1);
      char *args[] = { "echo", "x", 0 };
      exec("echo", args);
      exit(0);
    } else {
      wait((int*)0);
    2d30:	4501                	li	a0,0
    2d32:	00003097          	auipc	ra,0x3
    2d36:	b08080e7          	jalr	-1272(ra) # 583a <wait>
  for(int avail = 0; avail < 15; avail++){
    2d3a:	2905                	addw	s2,s2,1
    2d3c:	ff3912e3          	bne	s2,s3,2d20 <execout+0x14>
    }
  }

  exit(0);
    2d40:	4501                	li	a0,0
    2d42:	00003097          	auipc	ra,0x3
    2d46:	af0080e7          	jalr	-1296(ra) # 5832 <exit>
      printf("fork failed\n");
    2d4a:	00004517          	auipc	a0,0x4
    2d4e:	ca650513          	add	a0,a0,-858 # 69f0 <malloc+0xd96>
    2d52:	00003097          	auipc	ra,0x3
    2d56:	e50080e7          	jalr	-432(ra) # 5ba2 <printf>
      exit(1);
    2d5a:	4505                	li	a0,1
    2d5c:	00003097          	auipc	ra,0x3
    2d60:	ad6080e7          	jalr	-1322(ra) # 5832 <exit>
        if(a == 0xffffffffffffffffLL)
    2d64:	59fd                	li	s3,-1
        *(char*)(a + 4096 - 1) = 1;
    2d66:	4a05                	li	s4,1
        uint64 a = (uint64) sbrk(4096);
    2d68:	6505                	lui	a0,0x1
    2d6a:	00003097          	auipc	ra,0x3
    2d6e:	b50080e7          	jalr	-1200(ra) # 58ba <sbrk>
        if(a == 0xffffffffffffffffLL)
    2d72:	01350763          	beq	a0,s3,2d80 <execout+0x74>
        *(char*)(a + 4096 - 1) = 1;
    2d76:	6785                	lui	a5,0x1
    2d78:	97aa                	add	a5,a5,a0
    2d7a:	ff478fa3          	sb	s4,-1(a5) # fff <bigdir+0x9f>
      while(1){
    2d7e:	b7ed                	j	2d68 <execout+0x5c>
      for(int i = 0; i < avail; i++)
    2d80:	01205a63          	blez	s2,2d94 <execout+0x88>
        sbrk(-4096);
    2d84:	757d                	lui	a0,0xfffff
    2d86:	00003097          	auipc	ra,0x3
    2d8a:	b34080e7          	jalr	-1228(ra) # 58ba <sbrk>
      for(int i = 0; i < avail; i++)
    2d8e:	2485                	addw	s1,s1,1
    2d90:	ff249ae3          	bne	s1,s2,2d84 <execout+0x78>
      close(1);
    2d94:	4505                	li	a0,1
    2d96:	00003097          	auipc	ra,0x3
    2d9a:	ac4080e7          	jalr	-1340(ra) # 585a <close>
      char *args[] = { "echo", "x", 0 };
    2d9e:	00003517          	auipc	a0,0x3
    2da2:	fda50513          	add	a0,a0,-38 # 5d78 <malloc+0x11e>
    2da6:	faa43c23          	sd	a0,-72(s0)
    2daa:	00003797          	auipc	a5,0x3
    2dae:	03e78793          	add	a5,a5,62 # 5de8 <malloc+0x18e>
    2db2:	fcf43023          	sd	a5,-64(s0)
    2db6:	fc043423          	sd	zero,-56(s0)
      exec("echo", args);
    2dba:	fb840593          	add	a1,s0,-72
    2dbe:	00003097          	auipc	ra,0x3
    2dc2:	aac080e7          	jalr	-1364(ra) # 586a <exec>
      exit(0);
    2dc6:	4501                	li	a0,0
    2dc8:	00003097          	auipc	ra,0x3
    2dcc:	a6a080e7          	jalr	-1430(ra) # 5832 <exit>

0000000000002dd0 <fourteen>:
{
    2dd0:	1101                	add	sp,sp,-32
    2dd2:	ec06                	sd	ra,24(sp)
    2dd4:	e822                	sd	s0,16(sp)
    2dd6:	e426                	sd	s1,8(sp)
    2dd8:	1000                	add	s0,sp,32
    2dda:	84aa                	mv	s1,a0
  if(mkdir("12345678901234") != 0){
    2ddc:	00004517          	auipc	a0,0x4
    2de0:	10c50513          	add	a0,a0,268 # 6ee8 <malloc+0x128e>
    2de4:	00003097          	auipc	ra,0x3
    2de8:	ab6080e7          	jalr	-1354(ra) # 589a <mkdir>
    2dec:	e165                	bnez	a0,2ecc <fourteen+0xfc>
  if(mkdir("12345678901234/123456789012345") != 0){
    2dee:	00004517          	auipc	a0,0x4
    2df2:	f5250513          	add	a0,a0,-174 # 6d40 <malloc+0x10e6>
    2df6:	00003097          	auipc	ra,0x3
    2dfa:	aa4080e7          	jalr	-1372(ra) # 589a <mkdir>
    2dfe:	e56d                	bnez	a0,2ee8 <fourteen+0x118>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    2e00:	20000593          	li	a1,512
    2e04:	00004517          	auipc	a0,0x4
    2e08:	f9450513          	add	a0,a0,-108 # 6d98 <malloc+0x113e>
    2e0c:	00003097          	auipc	ra,0x3
    2e10:	a66080e7          	jalr	-1434(ra) # 5872 <open>
  if(fd < 0){
    2e14:	0e054863          	bltz	a0,2f04 <fourteen+0x134>
  close(fd);
    2e18:	00003097          	auipc	ra,0x3
    2e1c:	a42080e7          	jalr	-1470(ra) # 585a <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    2e20:	4581                	li	a1,0
    2e22:	00004517          	auipc	a0,0x4
    2e26:	fee50513          	add	a0,a0,-18 # 6e10 <malloc+0x11b6>
    2e2a:	00003097          	auipc	ra,0x3
    2e2e:	a48080e7          	jalr	-1464(ra) # 5872 <open>
  if(fd < 0){
    2e32:	0e054763          	bltz	a0,2f20 <fourteen+0x150>
  close(fd);
    2e36:	00003097          	auipc	ra,0x3
    2e3a:	a24080e7          	jalr	-1500(ra) # 585a <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    2e3e:	00004517          	auipc	a0,0x4
    2e42:	04250513          	add	a0,a0,66 # 6e80 <malloc+0x1226>
    2e46:	00003097          	auipc	ra,0x3
    2e4a:	a54080e7          	jalr	-1452(ra) # 589a <mkdir>
    2e4e:	c57d                	beqz	a0,2f3c <fourteen+0x16c>
  if(mkdir("123456789012345/12345678901234") == 0){
    2e50:	00004517          	auipc	a0,0x4
    2e54:	08850513          	add	a0,a0,136 # 6ed8 <malloc+0x127e>
    2e58:	00003097          	auipc	ra,0x3
    2e5c:	a42080e7          	jalr	-1470(ra) # 589a <mkdir>
    2e60:	cd65                	beqz	a0,2f58 <fourteen+0x188>
  unlink("123456789012345/12345678901234");
    2e62:	00004517          	auipc	a0,0x4
    2e66:	07650513          	add	a0,a0,118 # 6ed8 <malloc+0x127e>
    2e6a:	00003097          	auipc	ra,0x3
    2e6e:	a18080e7          	jalr	-1512(ra) # 5882 <unlink>
  unlink("12345678901234/12345678901234");
    2e72:	00004517          	auipc	a0,0x4
    2e76:	00e50513          	add	a0,a0,14 # 6e80 <malloc+0x1226>
    2e7a:	00003097          	auipc	ra,0x3
    2e7e:	a08080e7          	jalr	-1528(ra) # 5882 <unlink>
  unlink("12345678901234/12345678901234/12345678901234");
    2e82:	00004517          	auipc	a0,0x4
    2e86:	f8e50513          	add	a0,a0,-114 # 6e10 <malloc+0x11b6>
    2e8a:	00003097          	auipc	ra,0x3
    2e8e:	9f8080e7          	jalr	-1544(ra) # 5882 <unlink>
  unlink("123456789012345/123456789012345/123456789012345");
    2e92:	00004517          	auipc	a0,0x4
    2e96:	f0650513          	add	a0,a0,-250 # 6d98 <malloc+0x113e>
    2e9a:	00003097          	auipc	ra,0x3
    2e9e:	9e8080e7          	jalr	-1560(ra) # 5882 <unlink>
  unlink("12345678901234/123456789012345");
    2ea2:	00004517          	auipc	a0,0x4
    2ea6:	e9e50513          	add	a0,a0,-354 # 6d40 <malloc+0x10e6>
    2eaa:	00003097          	auipc	ra,0x3
    2eae:	9d8080e7          	jalr	-1576(ra) # 5882 <unlink>
  unlink("12345678901234");
    2eb2:	00004517          	auipc	a0,0x4
    2eb6:	03650513          	add	a0,a0,54 # 6ee8 <malloc+0x128e>
    2eba:	00003097          	auipc	ra,0x3
    2ebe:	9c8080e7          	jalr	-1592(ra) # 5882 <unlink>
}
    2ec2:	60e2                	ld	ra,24(sp)
    2ec4:	6442                	ld	s0,16(sp)
    2ec6:	64a2                	ld	s1,8(sp)
    2ec8:	6105                	add	sp,sp,32
    2eca:	8082                	ret
    printf("%s: mkdir 12345678901234 failed\n", s);
    2ecc:	85a6                	mv	a1,s1
    2ece:	00004517          	auipc	a0,0x4
    2ed2:	e4a50513          	add	a0,a0,-438 # 6d18 <malloc+0x10be>
    2ed6:	00003097          	auipc	ra,0x3
    2eda:	ccc080e7          	jalr	-820(ra) # 5ba2 <printf>
    exit(1);
    2ede:	4505                	li	a0,1
    2ee0:	00003097          	auipc	ra,0x3
    2ee4:	952080e7          	jalr	-1710(ra) # 5832 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    2ee8:	85a6                	mv	a1,s1
    2eea:	00004517          	auipc	a0,0x4
    2eee:	e7650513          	add	a0,a0,-394 # 6d60 <malloc+0x1106>
    2ef2:	00003097          	auipc	ra,0x3
    2ef6:	cb0080e7          	jalr	-848(ra) # 5ba2 <printf>
    exit(1);
    2efa:	4505                	li	a0,1
    2efc:	00003097          	auipc	ra,0x3
    2f00:	936080e7          	jalr	-1738(ra) # 5832 <exit>
    printf("%s: create 123456789012345/123456789012345/123456789012345 failed\n", s);
    2f04:	85a6                	mv	a1,s1
    2f06:	00004517          	auipc	a0,0x4
    2f0a:	ec250513          	add	a0,a0,-318 # 6dc8 <malloc+0x116e>
    2f0e:	00003097          	auipc	ra,0x3
    2f12:	c94080e7          	jalr	-876(ra) # 5ba2 <printf>
    exit(1);
    2f16:	4505                	li	a0,1
    2f18:	00003097          	auipc	ra,0x3
    2f1c:	91a080e7          	jalr	-1766(ra) # 5832 <exit>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
    2f20:	85a6                	mv	a1,s1
    2f22:	00004517          	auipc	a0,0x4
    2f26:	f1e50513          	add	a0,a0,-226 # 6e40 <malloc+0x11e6>
    2f2a:	00003097          	auipc	ra,0x3
    2f2e:	c78080e7          	jalr	-904(ra) # 5ba2 <printf>
    exit(1);
    2f32:	4505                	li	a0,1
    2f34:	00003097          	auipc	ra,0x3
    2f38:	8fe080e7          	jalr	-1794(ra) # 5832 <exit>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    2f3c:	85a6                	mv	a1,s1
    2f3e:	00004517          	auipc	a0,0x4
    2f42:	f6250513          	add	a0,a0,-158 # 6ea0 <malloc+0x1246>
    2f46:	00003097          	auipc	ra,0x3
    2f4a:	c5c080e7          	jalr	-932(ra) # 5ba2 <printf>
    exit(1);
    2f4e:	4505                	li	a0,1
    2f50:	00003097          	auipc	ra,0x3
    2f54:	8e2080e7          	jalr	-1822(ra) # 5832 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    2f58:	85a6                	mv	a1,s1
    2f5a:	00004517          	auipc	a0,0x4
    2f5e:	f9e50513          	add	a0,a0,-98 # 6ef8 <malloc+0x129e>
    2f62:	00003097          	auipc	ra,0x3
    2f66:	c40080e7          	jalr	-960(ra) # 5ba2 <printf>
    exit(1);
    2f6a:	4505                	li	a0,1
    2f6c:	00003097          	auipc	ra,0x3
    2f70:	8c6080e7          	jalr	-1850(ra) # 5832 <exit>

0000000000002f74 <iputtest>:
{
    2f74:	1101                	add	sp,sp,-32
    2f76:	ec06                	sd	ra,24(sp)
    2f78:	e822                	sd	s0,16(sp)
    2f7a:	e426                	sd	s1,8(sp)
    2f7c:	1000                	add	s0,sp,32
    2f7e:	84aa                	mv	s1,a0
  if(mkdir("iputdir") < 0){
    2f80:	00004517          	auipc	a0,0x4
    2f84:	fb050513          	add	a0,a0,-80 # 6f30 <malloc+0x12d6>
    2f88:	00003097          	auipc	ra,0x3
    2f8c:	912080e7          	jalr	-1774(ra) # 589a <mkdir>
    2f90:	04054563          	bltz	a0,2fda <iputtest+0x66>
  if(chdir("iputdir") < 0){
    2f94:	00004517          	auipc	a0,0x4
    2f98:	f9c50513          	add	a0,a0,-100 # 6f30 <malloc+0x12d6>
    2f9c:	00003097          	auipc	ra,0x3
    2fa0:	906080e7          	jalr	-1786(ra) # 58a2 <chdir>
    2fa4:	04054963          	bltz	a0,2ff6 <iputtest+0x82>
  if(unlink("../iputdir") < 0){
    2fa8:	00004517          	auipc	a0,0x4
    2fac:	fc850513          	add	a0,a0,-56 # 6f70 <malloc+0x1316>
    2fb0:	00003097          	auipc	ra,0x3
    2fb4:	8d2080e7          	jalr	-1838(ra) # 5882 <unlink>
    2fb8:	04054d63          	bltz	a0,3012 <iputtest+0x9e>
  if(chdir("/") < 0){
    2fbc:	00004517          	auipc	a0,0x4
    2fc0:	fe450513          	add	a0,a0,-28 # 6fa0 <malloc+0x1346>
    2fc4:	00003097          	auipc	ra,0x3
    2fc8:	8de080e7          	jalr	-1826(ra) # 58a2 <chdir>
    2fcc:	06054163          	bltz	a0,302e <iputtest+0xba>
}
    2fd0:	60e2                	ld	ra,24(sp)
    2fd2:	6442                	ld	s0,16(sp)
    2fd4:	64a2                	ld	s1,8(sp)
    2fd6:	6105                	add	sp,sp,32
    2fd8:	8082                	ret
    printf("%s: mkdir failed\n", s);
    2fda:	85a6                	mv	a1,s1
    2fdc:	00004517          	auipc	a0,0x4
    2fe0:	f5c50513          	add	a0,a0,-164 # 6f38 <malloc+0x12de>
    2fe4:	00003097          	auipc	ra,0x3
    2fe8:	bbe080e7          	jalr	-1090(ra) # 5ba2 <printf>
    exit(1);
    2fec:	4505                	li	a0,1
    2fee:	00003097          	auipc	ra,0x3
    2ff2:	844080e7          	jalr	-1980(ra) # 5832 <exit>
    printf("%s: chdir iputdir failed\n", s);
    2ff6:	85a6                	mv	a1,s1
    2ff8:	00004517          	auipc	a0,0x4
    2ffc:	f5850513          	add	a0,a0,-168 # 6f50 <malloc+0x12f6>
    3000:	00003097          	auipc	ra,0x3
    3004:	ba2080e7          	jalr	-1118(ra) # 5ba2 <printf>
    exit(1);
    3008:	4505                	li	a0,1
    300a:	00003097          	auipc	ra,0x3
    300e:	828080e7          	jalr	-2008(ra) # 5832 <exit>
    printf("%s: unlink ../iputdir failed\n", s);
    3012:	85a6                	mv	a1,s1
    3014:	00004517          	auipc	a0,0x4
    3018:	f6c50513          	add	a0,a0,-148 # 6f80 <malloc+0x1326>
    301c:	00003097          	auipc	ra,0x3
    3020:	b86080e7          	jalr	-1146(ra) # 5ba2 <printf>
    exit(1);
    3024:	4505                	li	a0,1
    3026:	00003097          	auipc	ra,0x3
    302a:	80c080e7          	jalr	-2036(ra) # 5832 <exit>
    printf("%s: chdir / failed\n", s);
    302e:	85a6                	mv	a1,s1
    3030:	00004517          	auipc	a0,0x4
    3034:	f7850513          	add	a0,a0,-136 # 6fa8 <malloc+0x134e>
    3038:	00003097          	auipc	ra,0x3
    303c:	b6a080e7          	jalr	-1174(ra) # 5ba2 <printf>
    exit(1);
    3040:	4505                	li	a0,1
    3042:	00002097          	auipc	ra,0x2
    3046:	7f0080e7          	jalr	2032(ra) # 5832 <exit>

000000000000304a <exitiputtest>:
{
    304a:	7179                	add	sp,sp,-48
    304c:	f406                	sd	ra,40(sp)
    304e:	f022                	sd	s0,32(sp)
    3050:	ec26                	sd	s1,24(sp)
    3052:	1800                	add	s0,sp,48
    3054:	84aa                	mv	s1,a0
  pid = fork();
    3056:	00002097          	auipc	ra,0x2
    305a:	7d4080e7          	jalr	2004(ra) # 582a <fork>
  if(pid < 0){
    305e:	04054663          	bltz	a0,30aa <exitiputtest+0x60>
  if(pid == 0){
    3062:	ed45                	bnez	a0,311a <exitiputtest+0xd0>
    if(mkdir("iputdir") < 0){
    3064:	00004517          	auipc	a0,0x4
    3068:	ecc50513          	add	a0,a0,-308 # 6f30 <malloc+0x12d6>
    306c:	00003097          	auipc	ra,0x3
    3070:	82e080e7          	jalr	-2002(ra) # 589a <mkdir>
    3074:	04054963          	bltz	a0,30c6 <exitiputtest+0x7c>
    if(chdir("iputdir") < 0){
    3078:	00004517          	auipc	a0,0x4
    307c:	eb850513          	add	a0,a0,-328 # 6f30 <malloc+0x12d6>
    3080:	00003097          	auipc	ra,0x3
    3084:	822080e7          	jalr	-2014(ra) # 58a2 <chdir>
    3088:	04054d63          	bltz	a0,30e2 <exitiputtest+0x98>
    if(unlink("../iputdir") < 0){
    308c:	00004517          	auipc	a0,0x4
    3090:	ee450513          	add	a0,a0,-284 # 6f70 <malloc+0x1316>
    3094:	00002097          	auipc	ra,0x2
    3098:	7ee080e7          	jalr	2030(ra) # 5882 <unlink>
    309c:	06054163          	bltz	a0,30fe <exitiputtest+0xb4>
    exit(0);
    30a0:	4501                	li	a0,0
    30a2:	00002097          	auipc	ra,0x2
    30a6:	790080e7          	jalr	1936(ra) # 5832 <exit>
    printf("%s: fork failed\n", s);
    30aa:	85a6                	mv	a1,s1
    30ac:	00003517          	auipc	a0,0x3
    30b0:	52450513          	add	a0,a0,1316 # 65d0 <malloc+0x976>
    30b4:	00003097          	auipc	ra,0x3
    30b8:	aee080e7          	jalr	-1298(ra) # 5ba2 <printf>
    exit(1);
    30bc:	4505                	li	a0,1
    30be:	00002097          	auipc	ra,0x2
    30c2:	774080e7          	jalr	1908(ra) # 5832 <exit>
      printf("%s: mkdir failed\n", s);
    30c6:	85a6                	mv	a1,s1
    30c8:	00004517          	auipc	a0,0x4
    30cc:	e7050513          	add	a0,a0,-400 # 6f38 <malloc+0x12de>
    30d0:	00003097          	auipc	ra,0x3
    30d4:	ad2080e7          	jalr	-1326(ra) # 5ba2 <printf>
      exit(1);
    30d8:	4505                	li	a0,1
    30da:	00002097          	auipc	ra,0x2
    30de:	758080e7          	jalr	1880(ra) # 5832 <exit>
      printf("%s: child chdir failed\n", s);
    30e2:	85a6                	mv	a1,s1
    30e4:	00004517          	auipc	a0,0x4
    30e8:	edc50513          	add	a0,a0,-292 # 6fc0 <malloc+0x1366>
    30ec:	00003097          	auipc	ra,0x3
    30f0:	ab6080e7          	jalr	-1354(ra) # 5ba2 <printf>
      exit(1);
    30f4:	4505                	li	a0,1
    30f6:	00002097          	auipc	ra,0x2
    30fa:	73c080e7          	jalr	1852(ra) # 5832 <exit>
      printf("%s: unlink ../iputdir failed\n", s);
    30fe:	85a6                	mv	a1,s1
    3100:	00004517          	auipc	a0,0x4
    3104:	e8050513          	add	a0,a0,-384 # 6f80 <malloc+0x1326>
    3108:	00003097          	auipc	ra,0x3
    310c:	a9a080e7          	jalr	-1382(ra) # 5ba2 <printf>
      exit(1);
    3110:	4505                	li	a0,1
    3112:	00002097          	auipc	ra,0x2
    3116:	720080e7          	jalr	1824(ra) # 5832 <exit>
  wait(&xstatus);
    311a:	fdc40513          	add	a0,s0,-36
    311e:	00002097          	auipc	ra,0x2
    3122:	71c080e7          	jalr	1820(ra) # 583a <wait>
  exit(xstatus);
    3126:	fdc42503          	lw	a0,-36(s0)
    312a:	00002097          	auipc	ra,0x2
    312e:	708080e7          	jalr	1800(ra) # 5832 <exit>

0000000000003132 <dirtest>:
{
    3132:	1101                	add	sp,sp,-32
    3134:	ec06                	sd	ra,24(sp)
    3136:	e822                	sd	s0,16(sp)
    3138:	e426                	sd	s1,8(sp)
    313a:	1000                	add	s0,sp,32
    313c:	84aa                	mv	s1,a0
  if(mkdir("dir0") < 0){
    313e:	00004517          	auipc	a0,0x4
    3142:	e9a50513          	add	a0,a0,-358 # 6fd8 <malloc+0x137e>
    3146:	00002097          	auipc	ra,0x2
    314a:	754080e7          	jalr	1876(ra) # 589a <mkdir>
    314e:	04054563          	bltz	a0,3198 <dirtest+0x66>
  if(chdir("dir0") < 0){
    3152:	00004517          	auipc	a0,0x4
    3156:	e8650513          	add	a0,a0,-378 # 6fd8 <malloc+0x137e>
    315a:	00002097          	auipc	ra,0x2
    315e:	748080e7          	jalr	1864(ra) # 58a2 <chdir>
    3162:	04054963          	bltz	a0,31b4 <dirtest+0x82>
  if(chdir("..") < 0){
    3166:	00004517          	auipc	a0,0x4
    316a:	e9250513          	add	a0,a0,-366 # 6ff8 <malloc+0x139e>
    316e:	00002097          	auipc	ra,0x2
    3172:	734080e7          	jalr	1844(ra) # 58a2 <chdir>
    3176:	04054d63          	bltz	a0,31d0 <dirtest+0x9e>
  if(unlink("dir0") < 0){
    317a:	00004517          	auipc	a0,0x4
    317e:	e5e50513          	add	a0,a0,-418 # 6fd8 <malloc+0x137e>
    3182:	00002097          	auipc	ra,0x2
    3186:	700080e7          	jalr	1792(ra) # 5882 <unlink>
    318a:	06054163          	bltz	a0,31ec <dirtest+0xba>
}
    318e:	60e2                	ld	ra,24(sp)
    3190:	6442                	ld	s0,16(sp)
    3192:	64a2                	ld	s1,8(sp)
    3194:	6105                	add	sp,sp,32
    3196:	8082                	ret
    printf("%s: mkdir failed\n", s);
    3198:	85a6                	mv	a1,s1
    319a:	00004517          	auipc	a0,0x4
    319e:	d9e50513          	add	a0,a0,-610 # 6f38 <malloc+0x12de>
    31a2:	00003097          	auipc	ra,0x3
    31a6:	a00080e7          	jalr	-1536(ra) # 5ba2 <printf>
    exit(1);
    31aa:	4505                	li	a0,1
    31ac:	00002097          	auipc	ra,0x2
    31b0:	686080e7          	jalr	1670(ra) # 5832 <exit>
    printf("%s: chdir dir0 failed\n", s);
    31b4:	85a6                	mv	a1,s1
    31b6:	00004517          	auipc	a0,0x4
    31ba:	e2a50513          	add	a0,a0,-470 # 6fe0 <malloc+0x1386>
    31be:	00003097          	auipc	ra,0x3
    31c2:	9e4080e7          	jalr	-1564(ra) # 5ba2 <printf>
    exit(1);
    31c6:	4505                	li	a0,1
    31c8:	00002097          	auipc	ra,0x2
    31cc:	66a080e7          	jalr	1642(ra) # 5832 <exit>
    printf("%s: chdir .. failed\n", s);
    31d0:	85a6                	mv	a1,s1
    31d2:	00004517          	auipc	a0,0x4
    31d6:	e2e50513          	add	a0,a0,-466 # 7000 <malloc+0x13a6>
    31da:	00003097          	auipc	ra,0x3
    31de:	9c8080e7          	jalr	-1592(ra) # 5ba2 <printf>
    exit(1);
    31e2:	4505                	li	a0,1
    31e4:	00002097          	auipc	ra,0x2
    31e8:	64e080e7          	jalr	1614(ra) # 5832 <exit>
    printf("%s: unlink dir0 failed\n", s);
    31ec:	85a6                	mv	a1,s1
    31ee:	00004517          	auipc	a0,0x4
    31f2:	e2a50513          	add	a0,a0,-470 # 7018 <malloc+0x13be>
    31f6:	00003097          	auipc	ra,0x3
    31fa:	9ac080e7          	jalr	-1620(ra) # 5ba2 <printf>
    exit(1);
    31fe:	4505                	li	a0,1
    3200:	00002097          	auipc	ra,0x2
    3204:	632080e7          	jalr	1586(ra) # 5832 <exit>

0000000000003208 <subdir>:
{
    3208:	1101                	add	sp,sp,-32
    320a:	ec06                	sd	ra,24(sp)
    320c:	e822                	sd	s0,16(sp)
    320e:	e426                	sd	s1,8(sp)
    3210:	e04a                	sd	s2,0(sp)
    3212:	1000                	add	s0,sp,32
    3214:	892a                	mv	s2,a0
  unlink("ff");
    3216:	00004517          	auipc	a0,0x4
    321a:	f4a50513          	add	a0,a0,-182 # 7160 <malloc+0x1506>
    321e:	00002097          	auipc	ra,0x2
    3222:	664080e7          	jalr	1636(ra) # 5882 <unlink>
  if(mkdir("dd") != 0){
    3226:	00004517          	auipc	a0,0x4
    322a:	e0a50513          	add	a0,a0,-502 # 7030 <malloc+0x13d6>
    322e:	00002097          	auipc	ra,0x2
    3232:	66c080e7          	jalr	1644(ra) # 589a <mkdir>
    3236:	38051663          	bnez	a0,35c2 <subdir+0x3ba>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    323a:	20200593          	li	a1,514
    323e:	00004517          	auipc	a0,0x4
    3242:	e1250513          	add	a0,a0,-494 # 7050 <malloc+0x13f6>
    3246:	00002097          	auipc	ra,0x2
    324a:	62c080e7          	jalr	1580(ra) # 5872 <open>
    324e:	84aa                	mv	s1,a0
  if(fd < 0){
    3250:	38054763          	bltz	a0,35de <subdir+0x3d6>
  write(fd, "ff", 2);
    3254:	4609                	li	a2,2
    3256:	00004597          	auipc	a1,0x4
    325a:	f0a58593          	add	a1,a1,-246 # 7160 <malloc+0x1506>
    325e:	00002097          	auipc	ra,0x2
    3262:	5f4080e7          	jalr	1524(ra) # 5852 <write>
  close(fd);
    3266:	8526                	mv	a0,s1
    3268:	00002097          	auipc	ra,0x2
    326c:	5f2080e7          	jalr	1522(ra) # 585a <close>
  if(unlink("dd") >= 0){
    3270:	00004517          	auipc	a0,0x4
    3274:	dc050513          	add	a0,a0,-576 # 7030 <malloc+0x13d6>
    3278:	00002097          	auipc	ra,0x2
    327c:	60a080e7          	jalr	1546(ra) # 5882 <unlink>
    3280:	36055d63          	bgez	a0,35fa <subdir+0x3f2>
  if(mkdir("/dd/dd") != 0){
    3284:	00004517          	auipc	a0,0x4
    3288:	e2450513          	add	a0,a0,-476 # 70a8 <malloc+0x144e>
    328c:	00002097          	auipc	ra,0x2
    3290:	60e080e7          	jalr	1550(ra) # 589a <mkdir>
    3294:	38051163          	bnez	a0,3616 <subdir+0x40e>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    3298:	20200593          	li	a1,514
    329c:	00004517          	auipc	a0,0x4
    32a0:	e3450513          	add	a0,a0,-460 # 70d0 <malloc+0x1476>
    32a4:	00002097          	auipc	ra,0x2
    32a8:	5ce080e7          	jalr	1486(ra) # 5872 <open>
    32ac:	84aa                	mv	s1,a0
  if(fd < 0){
    32ae:	38054263          	bltz	a0,3632 <subdir+0x42a>
  write(fd, "FF", 2);
    32b2:	4609                	li	a2,2
    32b4:	00004597          	auipc	a1,0x4
    32b8:	e4c58593          	add	a1,a1,-436 # 7100 <malloc+0x14a6>
    32bc:	00002097          	auipc	ra,0x2
    32c0:	596080e7          	jalr	1430(ra) # 5852 <write>
  close(fd);
    32c4:	8526                	mv	a0,s1
    32c6:	00002097          	auipc	ra,0x2
    32ca:	594080e7          	jalr	1428(ra) # 585a <close>
  fd = open("dd/dd/../ff", 0);
    32ce:	4581                	li	a1,0
    32d0:	00004517          	auipc	a0,0x4
    32d4:	e3850513          	add	a0,a0,-456 # 7108 <malloc+0x14ae>
    32d8:	00002097          	auipc	ra,0x2
    32dc:	59a080e7          	jalr	1434(ra) # 5872 <open>
    32e0:	84aa                	mv	s1,a0
  if(fd < 0){
    32e2:	36054663          	bltz	a0,364e <subdir+0x446>
  cc = read(fd, buf, sizeof(buf));
    32e6:	660d                	lui	a2,0x3
    32e8:	00009597          	auipc	a1,0x9
    32ec:	ad058593          	add	a1,a1,-1328 # bdb8 <buf>
    32f0:	00002097          	auipc	ra,0x2
    32f4:	55a080e7          	jalr	1370(ra) # 584a <read>
  if(cc != 2 || buf[0] != 'f'){
    32f8:	4789                	li	a5,2
    32fa:	36f51863          	bne	a0,a5,366a <subdir+0x462>
    32fe:	00009717          	auipc	a4,0x9
    3302:	aba74703          	lbu	a4,-1350(a4) # bdb8 <buf>
    3306:	06600793          	li	a5,102
    330a:	36f71063          	bne	a4,a5,366a <subdir+0x462>
  close(fd);
    330e:	8526                	mv	a0,s1
    3310:	00002097          	auipc	ra,0x2
    3314:	54a080e7          	jalr	1354(ra) # 585a <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    3318:	00004597          	auipc	a1,0x4
    331c:	e4058593          	add	a1,a1,-448 # 7158 <malloc+0x14fe>
    3320:	00004517          	auipc	a0,0x4
    3324:	db050513          	add	a0,a0,-592 # 70d0 <malloc+0x1476>
    3328:	00002097          	auipc	ra,0x2
    332c:	56a080e7          	jalr	1386(ra) # 5892 <link>
    3330:	34051b63          	bnez	a0,3686 <subdir+0x47e>
  if(unlink("dd/dd/ff") != 0){
    3334:	00004517          	auipc	a0,0x4
    3338:	d9c50513          	add	a0,a0,-612 # 70d0 <malloc+0x1476>
    333c:	00002097          	auipc	ra,0x2
    3340:	546080e7          	jalr	1350(ra) # 5882 <unlink>
    3344:	34051f63          	bnez	a0,36a2 <subdir+0x49a>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    3348:	4581                	li	a1,0
    334a:	00004517          	auipc	a0,0x4
    334e:	d8650513          	add	a0,a0,-634 # 70d0 <malloc+0x1476>
    3352:	00002097          	auipc	ra,0x2
    3356:	520080e7          	jalr	1312(ra) # 5872 <open>
    335a:	36055263          	bgez	a0,36be <subdir+0x4b6>
  if(chdir("dd") != 0){
    335e:	00004517          	auipc	a0,0x4
    3362:	cd250513          	add	a0,a0,-814 # 7030 <malloc+0x13d6>
    3366:	00002097          	auipc	ra,0x2
    336a:	53c080e7          	jalr	1340(ra) # 58a2 <chdir>
    336e:	36051663          	bnez	a0,36da <subdir+0x4d2>
  if(chdir("dd/../../dd") != 0){
    3372:	00004517          	auipc	a0,0x4
    3376:	e7e50513          	add	a0,a0,-386 # 71f0 <malloc+0x1596>
    337a:	00002097          	auipc	ra,0x2
    337e:	528080e7          	jalr	1320(ra) # 58a2 <chdir>
    3382:	36051a63          	bnez	a0,36f6 <subdir+0x4ee>
  if(chdir("dd/../../../dd") != 0){
    3386:	00004517          	auipc	a0,0x4
    338a:	e9a50513          	add	a0,a0,-358 # 7220 <malloc+0x15c6>
    338e:	00002097          	auipc	ra,0x2
    3392:	514080e7          	jalr	1300(ra) # 58a2 <chdir>
    3396:	36051e63          	bnez	a0,3712 <subdir+0x50a>
  if(chdir("./..") != 0){
    339a:	00004517          	auipc	a0,0x4
    339e:	eb650513          	add	a0,a0,-330 # 7250 <malloc+0x15f6>
    33a2:	00002097          	auipc	ra,0x2
    33a6:	500080e7          	jalr	1280(ra) # 58a2 <chdir>
    33aa:	38051263          	bnez	a0,372e <subdir+0x526>
  fd = open("dd/dd/ffff", 0);
    33ae:	4581                	li	a1,0
    33b0:	00004517          	auipc	a0,0x4
    33b4:	da850513          	add	a0,a0,-600 # 7158 <malloc+0x14fe>
    33b8:	00002097          	auipc	ra,0x2
    33bc:	4ba080e7          	jalr	1210(ra) # 5872 <open>
    33c0:	84aa                	mv	s1,a0
  if(fd < 0){
    33c2:	38054463          	bltz	a0,374a <subdir+0x542>
  if(read(fd, buf, sizeof(buf)) != 2){
    33c6:	660d                	lui	a2,0x3
    33c8:	00009597          	auipc	a1,0x9
    33cc:	9f058593          	add	a1,a1,-1552 # bdb8 <buf>
    33d0:	00002097          	auipc	ra,0x2
    33d4:	47a080e7          	jalr	1146(ra) # 584a <read>
    33d8:	4789                	li	a5,2
    33da:	38f51663          	bne	a0,a5,3766 <subdir+0x55e>
  close(fd);
    33de:	8526                	mv	a0,s1
    33e0:	00002097          	auipc	ra,0x2
    33e4:	47a080e7          	jalr	1146(ra) # 585a <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    33e8:	4581                	li	a1,0
    33ea:	00004517          	auipc	a0,0x4
    33ee:	ce650513          	add	a0,a0,-794 # 70d0 <malloc+0x1476>
    33f2:	00002097          	auipc	ra,0x2
    33f6:	480080e7          	jalr	1152(ra) # 5872 <open>
    33fa:	38055463          	bgez	a0,3782 <subdir+0x57a>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    33fe:	20200593          	li	a1,514
    3402:	00004517          	auipc	a0,0x4
    3406:	ede50513          	add	a0,a0,-290 # 72e0 <malloc+0x1686>
    340a:	00002097          	auipc	ra,0x2
    340e:	468080e7          	jalr	1128(ra) # 5872 <open>
    3412:	38055663          	bgez	a0,379e <subdir+0x596>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    3416:	20200593          	li	a1,514
    341a:	00004517          	auipc	a0,0x4
    341e:	ef650513          	add	a0,a0,-266 # 7310 <malloc+0x16b6>
    3422:	00002097          	auipc	ra,0x2
    3426:	450080e7          	jalr	1104(ra) # 5872 <open>
    342a:	38055863          	bgez	a0,37ba <subdir+0x5b2>
  if(open("dd", O_CREATE) >= 0){
    342e:	20000593          	li	a1,512
    3432:	00004517          	auipc	a0,0x4
    3436:	bfe50513          	add	a0,a0,-1026 # 7030 <malloc+0x13d6>
    343a:	00002097          	auipc	ra,0x2
    343e:	438080e7          	jalr	1080(ra) # 5872 <open>
    3442:	38055a63          	bgez	a0,37d6 <subdir+0x5ce>
  if(open("dd", O_RDWR) >= 0){
    3446:	4589                	li	a1,2
    3448:	00004517          	auipc	a0,0x4
    344c:	be850513          	add	a0,a0,-1048 # 7030 <malloc+0x13d6>
    3450:	00002097          	auipc	ra,0x2
    3454:	422080e7          	jalr	1058(ra) # 5872 <open>
    3458:	38055d63          	bgez	a0,37f2 <subdir+0x5ea>
  if(open("dd", O_WRONLY) >= 0){
    345c:	4585                	li	a1,1
    345e:	00004517          	auipc	a0,0x4
    3462:	bd250513          	add	a0,a0,-1070 # 7030 <malloc+0x13d6>
    3466:	00002097          	auipc	ra,0x2
    346a:	40c080e7          	jalr	1036(ra) # 5872 <open>
    346e:	3a055063          	bgez	a0,380e <subdir+0x606>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    3472:	00004597          	auipc	a1,0x4
    3476:	f2e58593          	add	a1,a1,-210 # 73a0 <malloc+0x1746>
    347a:	00004517          	auipc	a0,0x4
    347e:	e6650513          	add	a0,a0,-410 # 72e0 <malloc+0x1686>
    3482:	00002097          	auipc	ra,0x2
    3486:	410080e7          	jalr	1040(ra) # 5892 <link>
    348a:	3a050063          	beqz	a0,382a <subdir+0x622>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    348e:	00004597          	auipc	a1,0x4
    3492:	f1258593          	add	a1,a1,-238 # 73a0 <malloc+0x1746>
    3496:	00004517          	auipc	a0,0x4
    349a:	e7a50513          	add	a0,a0,-390 # 7310 <malloc+0x16b6>
    349e:	00002097          	auipc	ra,0x2
    34a2:	3f4080e7          	jalr	1012(ra) # 5892 <link>
    34a6:	3a050063          	beqz	a0,3846 <subdir+0x63e>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    34aa:	00004597          	auipc	a1,0x4
    34ae:	cae58593          	add	a1,a1,-850 # 7158 <malloc+0x14fe>
    34b2:	00004517          	auipc	a0,0x4
    34b6:	b9e50513          	add	a0,a0,-1122 # 7050 <malloc+0x13f6>
    34ba:	00002097          	auipc	ra,0x2
    34be:	3d8080e7          	jalr	984(ra) # 5892 <link>
    34c2:	3a050063          	beqz	a0,3862 <subdir+0x65a>
  if(mkdir("dd/ff/ff") == 0){
    34c6:	00004517          	auipc	a0,0x4
    34ca:	e1a50513          	add	a0,a0,-486 # 72e0 <malloc+0x1686>
    34ce:	00002097          	auipc	ra,0x2
    34d2:	3cc080e7          	jalr	972(ra) # 589a <mkdir>
    34d6:	3a050463          	beqz	a0,387e <subdir+0x676>
  if(mkdir("dd/xx/ff") == 0){
    34da:	00004517          	auipc	a0,0x4
    34de:	e3650513          	add	a0,a0,-458 # 7310 <malloc+0x16b6>
    34e2:	00002097          	auipc	ra,0x2
    34e6:	3b8080e7          	jalr	952(ra) # 589a <mkdir>
    34ea:	3a050863          	beqz	a0,389a <subdir+0x692>
  if(mkdir("dd/dd/ffff") == 0){
    34ee:	00004517          	auipc	a0,0x4
    34f2:	c6a50513          	add	a0,a0,-918 # 7158 <malloc+0x14fe>
    34f6:	00002097          	auipc	ra,0x2
    34fa:	3a4080e7          	jalr	932(ra) # 589a <mkdir>
    34fe:	3a050c63          	beqz	a0,38b6 <subdir+0x6ae>
  if(unlink("dd/xx/ff") == 0){
    3502:	00004517          	auipc	a0,0x4
    3506:	e0e50513          	add	a0,a0,-498 # 7310 <malloc+0x16b6>
    350a:	00002097          	auipc	ra,0x2
    350e:	378080e7          	jalr	888(ra) # 5882 <unlink>
    3512:	3c050063          	beqz	a0,38d2 <subdir+0x6ca>
  if(unlink("dd/ff/ff") == 0){
    3516:	00004517          	auipc	a0,0x4
    351a:	dca50513          	add	a0,a0,-566 # 72e0 <malloc+0x1686>
    351e:	00002097          	auipc	ra,0x2
    3522:	364080e7          	jalr	868(ra) # 5882 <unlink>
    3526:	3c050463          	beqz	a0,38ee <subdir+0x6e6>
  if(chdir("dd/ff") == 0){
    352a:	00004517          	auipc	a0,0x4
    352e:	b2650513          	add	a0,a0,-1242 # 7050 <malloc+0x13f6>
    3532:	00002097          	auipc	ra,0x2
    3536:	370080e7          	jalr	880(ra) # 58a2 <chdir>
    353a:	3c050863          	beqz	a0,390a <subdir+0x702>
  if(chdir("dd/xx") == 0){
    353e:	00004517          	auipc	a0,0x4
    3542:	fb250513          	add	a0,a0,-78 # 74f0 <malloc+0x1896>
    3546:	00002097          	auipc	ra,0x2
    354a:	35c080e7          	jalr	860(ra) # 58a2 <chdir>
    354e:	3c050c63          	beqz	a0,3926 <subdir+0x71e>
  if(unlink("dd/dd/ffff") != 0){
    3552:	00004517          	auipc	a0,0x4
    3556:	c0650513          	add	a0,a0,-1018 # 7158 <malloc+0x14fe>
    355a:	00002097          	auipc	ra,0x2
    355e:	328080e7          	jalr	808(ra) # 5882 <unlink>
    3562:	3e051063          	bnez	a0,3942 <subdir+0x73a>
  if(unlink("dd/ff") != 0){
    3566:	00004517          	auipc	a0,0x4
    356a:	aea50513          	add	a0,a0,-1302 # 7050 <malloc+0x13f6>
    356e:	00002097          	auipc	ra,0x2
    3572:	314080e7          	jalr	788(ra) # 5882 <unlink>
    3576:	3e051463          	bnez	a0,395e <subdir+0x756>
  if(unlink("dd") == 0){
    357a:	00004517          	auipc	a0,0x4
    357e:	ab650513          	add	a0,a0,-1354 # 7030 <malloc+0x13d6>
    3582:	00002097          	auipc	ra,0x2
    3586:	300080e7          	jalr	768(ra) # 5882 <unlink>
    358a:	3e050863          	beqz	a0,397a <subdir+0x772>
  if(unlink("dd/dd") < 0){
    358e:	00004517          	auipc	a0,0x4
    3592:	fd250513          	add	a0,a0,-46 # 7560 <malloc+0x1906>
    3596:	00002097          	auipc	ra,0x2
    359a:	2ec080e7          	jalr	748(ra) # 5882 <unlink>
    359e:	3e054c63          	bltz	a0,3996 <subdir+0x78e>
  if(unlink("dd") < 0){
    35a2:	00004517          	auipc	a0,0x4
    35a6:	a8e50513          	add	a0,a0,-1394 # 7030 <malloc+0x13d6>
    35aa:	00002097          	auipc	ra,0x2
    35ae:	2d8080e7          	jalr	728(ra) # 5882 <unlink>
    35b2:	40054063          	bltz	a0,39b2 <subdir+0x7aa>
}
    35b6:	60e2                	ld	ra,24(sp)
    35b8:	6442                	ld	s0,16(sp)
    35ba:	64a2                	ld	s1,8(sp)
    35bc:	6902                	ld	s2,0(sp)
    35be:	6105                	add	sp,sp,32
    35c0:	8082                	ret
    printf("%s: mkdir dd failed\n", s);
    35c2:	85ca                	mv	a1,s2
    35c4:	00004517          	auipc	a0,0x4
    35c8:	a7450513          	add	a0,a0,-1420 # 7038 <malloc+0x13de>
    35cc:	00002097          	auipc	ra,0x2
    35d0:	5d6080e7          	jalr	1494(ra) # 5ba2 <printf>
    exit(1);
    35d4:	4505                	li	a0,1
    35d6:	00002097          	auipc	ra,0x2
    35da:	25c080e7          	jalr	604(ra) # 5832 <exit>
    printf("%s: create dd/ff failed\n", s);
    35de:	85ca                	mv	a1,s2
    35e0:	00004517          	auipc	a0,0x4
    35e4:	a7850513          	add	a0,a0,-1416 # 7058 <malloc+0x13fe>
    35e8:	00002097          	auipc	ra,0x2
    35ec:	5ba080e7          	jalr	1466(ra) # 5ba2 <printf>
    exit(1);
    35f0:	4505                	li	a0,1
    35f2:	00002097          	auipc	ra,0x2
    35f6:	240080e7          	jalr	576(ra) # 5832 <exit>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    35fa:	85ca                	mv	a1,s2
    35fc:	00004517          	auipc	a0,0x4
    3600:	a7c50513          	add	a0,a0,-1412 # 7078 <malloc+0x141e>
    3604:	00002097          	auipc	ra,0x2
    3608:	59e080e7          	jalr	1438(ra) # 5ba2 <printf>
    exit(1);
    360c:	4505                	li	a0,1
    360e:	00002097          	auipc	ra,0x2
    3612:	224080e7          	jalr	548(ra) # 5832 <exit>
    printf("subdir mkdir dd/dd failed\n", s);
    3616:	85ca                	mv	a1,s2
    3618:	00004517          	auipc	a0,0x4
    361c:	a9850513          	add	a0,a0,-1384 # 70b0 <malloc+0x1456>
    3620:	00002097          	auipc	ra,0x2
    3624:	582080e7          	jalr	1410(ra) # 5ba2 <printf>
    exit(1);
    3628:	4505                	li	a0,1
    362a:	00002097          	auipc	ra,0x2
    362e:	208080e7          	jalr	520(ra) # 5832 <exit>
    printf("%s: create dd/dd/ff failed\n", s);
    3632:	85ca                	mv	a1,s2
    3634:	00004517          	auipc	a0,0x4
    3638:	aac50513          	add	a0,a0,-1364 # 70e0 <malloc+0x1486>
    363c:	00002097          	auipc	ra,0x2
    3640:	566080e7          	jalr	1382(ra) # 5ba2 <printf>
    exit(1);
    3644:	4505                	li	a0,1
    3646:	00002097          	auipc	ra,0x2
    364a:	1ec080e7          	jalr	492(ra) # 5832 <exit>
    printf("%s: open dd/dd/../ff failed\n", s);
    364e:	85ca                	mv	a1,s2
    3650:	00004517          	auipc	a0,0x4
    3654:	ac850513          	add	a0,a0,-1336 # 7118 <malloc+0x14be>
    3658:	00002097          	auipc	ra,0x2
    365c:	54a080e7          	jalr	1354(ra) # 5ba2 <printf>
    exit(1);
    3660:	4505                	li	a0,1
    3662:	00002097          	auipc	ra,0x2
    3666:	1d0080e7          	jalr	464(ra) # 5832 <exit>
    printf("%s: dd/dd/../ff wrong content\n", s);
    366a:	85ca                	mv	a1,s2
    366c:	00004517          	auipc	a0,0x4
    3670:	acc50513          	add	a0,a0,-1332 # 7138 <malloc+0x14de>
    3674:	00002097          	auipc	ra,0x2
    3678:	52e080e7          	jalr	1326(ra) # 5ba2 <printf>
    exit(1);
    367c:	4505                	li	a0,1
    367e:	00002097          	auipc	ra,0x2
    3682:	1b4080e7          	jalr	436(ra) # 5832 <exit>
    printf("link dd/dd/ff dd/dd/ffff failed\n", s);
    3686:	85ca                	mv	a1,s2
    3688:	00004517          	auipc	a0,0x4
    368c:	ae050513          	add	a0,a0,-1312 # 7168 <malloc+0x150e>
    3690:	00002097          	auipc	ra,0x2
    3694:	512080e7          	jalr	1298(ra) # 5ba2 <printf>
    exit(1);
    3698:	4505                	li	a0,1
    369a:	00002097          	auipc	ra,0x2
    369e:	198080e7          	jalr	408(ra) # 5832 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    36a2:	85ca                	mv	a1,s2
    36a4:	00004517          	auipc	a0,0x4
    36a8:	aec50513          	add	a0,a0,-1300 # 7190 <malloc+0x1536>
    36ac:	00002097          	auipc	ra,0x2
    36b0:	4f6080e7          	jalr	1270(ra) # 5ba2 <printf>
    exit(1);
    36b4:	4505                	li	a0,1
    36b6:	00002097          	auipc	ra,0x2
    36ba:	17c080e7          	jalr	380(ra) # 5832 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    36be:	85ca                	mv	a1,s2
    36c0:	00004517          	auipc	a0,0x4
    36c4:	af050513          	add	a0,a0,-1296 # 71b0 <malloc+0x1556>
    36c8:	00002097          	auipc	ra,0x2
    36cc:	4da080e7          	jalr	1242(ra) # 5ba2 <printf>
    exit(1);
    36d0:	4505                	li	a0,1
    36d2:	00002097          	auipc	ra,0x2
    36d6:	160080e7          	jalr	352(ra) # 5832 <exit>
    printf("%s: chdir dd failed\n", s);
    36da:	85ca                	mv	a1,s2
    36dc:	00004517          	auipc	a0,0x4
    36e0:	afc50513          	add	a0,a0,-1284 # 71d8 <malloc+0x157e>
    36e4:	00002097          	auipc	ra,0x2
    36e8:	4be080e7          	jalr	1214(ra) # 5ba2 <printf>
    exit(1);
    36ec:	4505                	li	a0,1
    36ee:	00002097          	auipc	ra,0x2
    36f2:	144080e7          	jalr	324(ra) # 5832 <exit>
    printf("%s: chdir dd/../../dd failed\n", s);
    36f6:	85ca                	mv	a1,s2
    36f8:	00004517          	auipc	a0,0x4
    36fc:	b0850513          	add	a0,a0,-1272 # 7200 <malloc+0x15a6>
    3700:	00002097          	auipc	ra,0x2
    3704:	4a2080e7          	jalr	1186(ra) # 5ba2 <printf>
    exit(1);
    3708:	4505                	li	a0,1
    370a:	00002097          	auipc	ra,0x2
    370e:	128080e7          	jalr	296(ra) # 5832 <exit>
    printf("chdir dd/../../dd failed\n", s);
    3712:	85ca                	mv	a1,s2
    3714:	00004517          	auipc	a0,0x4
    3718:	b1c50513          	add	a0,a0,-1252 # 7230 <malloc+0x15d6>
    371c:	00002097          	auipc	ra,0x2
    3720:	486080e7          	jalr	1158(ra) # 5ba2 <printf>
    exit(1);
    3724:	4505                	li	a0,1
    3726:	00002097          	auipc	ra,0x2
    372a:	10c080e7          	jalr	268(ra) # 5832 <exit>
    printf("%s: chdir ./.. failed\n", s);
    372e:	85ca                	mv	a1,s2
    3730:	00004517          	auipc	a0,0x4
    3734:	b2850513          	add	a0,a0,-1240 # 7258 <malloc+0x15fe>
    3738:	00002097          	auipc	ra,0x2
    373c:	46a080e7          	jalr	1130(ra) # 5ba2 <printf>
    exit(1);
    3740:	4505                	li	a0,1
    3742:	00002097          	auipc	ra,0x2
    3746:	0f0080e7          	jalr	240(ra) # 5832 <exit>
    printf("%s: open dd/dd/ffff failed\n", s);
    374a:	85ca                	mv	a1,s2
    374c:	00004517          	auipc	a0,0x4
    3750:	b2450513          	add	a0,a0,-1244 # 7270 <malloc+0x1616>
    3754:	00002097          	auipc	ra,0x2
    3758:	44e080e7          	jalr	1102(ra) # 5ba2 <printf>
    exit(1);
    375c:	4505                	li	a0,1
    375e:	00002097          	auipc	ra,0x2
    3762:	0d4080e7          	jalr	212(ra) # 5832 <exit>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    3766:	85ca                	mv	a1,s2
    3768:	00004517          	auipc	a0,0x4
    376c:	b2850513          	add	a0,a0,-1240 # 7290 <malloc+0x1636>
    3770:	00002097          	auipc	ra,0x2
    3774:	432080e7          	jalr	1074(ra) # 5ba2 <printf>
    exit(1);
    3778:	4505                	li	a0,1
    377a:	00002097          	auipc	ra,0x2
    377e:	0b8080e7          	jalr	184(ra) # 5832 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    3782:	85ca                	mv	a1,s2
    3784:	00004517          	auipc	a0,0x4
    3788:	b2c50513          	add	a0,a0,-1236 # 72b0 <malloc+0x1656>
    378c:	00002097          	auipc	ra,0x2
    3790:	416080e7          	jalr	1046(ra) # 5ba2 <printf>
    exit(1);
    3794:	4505                	li	a0,1
    3796:	00002097          	auipc	ra,0x2
    379a:	09c080e7          	jalr	156(ra) # 5832 <exit>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    379e:	85ca                	mv	a1,s2
    37a0:	00004517          	auipc	a0,0x4
    37a4:	b5050513          	add	a0,a0,-1200 # 72f0 <malloc+0x1696>
    37a8:	00002097          	auipc	ra,0x2
    37ac:	3fa080e7          	jalr	1018(ra) # 5ba2 <printf>
    exit(1);
    37b0:	4505                	li	a0,1
    37b2:	00002097          	auipc	ra,0x2
    37b6:	080080e7          	jalr	128(ra) # 5832 <exit>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    37ba:	85ca                	mv	a1,s2
    37bc:	00004517          	auipc	a0,0x4
    37c0:	b6450513          	add	a0,a0,-1180 # 7320 <malloc+0x16c6>
    37c4:	00002097          	auipc	ra,0x2
    37c8:	3de080e7          	jalr	990(ra) # 5ba2 <printf>
    exit(1);
    37cc:	4505                	li	a0,1
    37ce:	00002097          	auipc	ra,0x2
    37d2:	064080e7          	jalr	100(ra) # 5832 <exit>
    printf("%s: create dd succeeded!\n", s);
    37d6:	85ca                	mv	a1,s2
    37d8:	00004517          	auipc	a0,0x4
    37dc:	b6850513          	add	a0,a0,-1176 # 7340 <malloc+0x16e6>
    37e0:	00002097          	auipc	ra,0x2
    37e4:	3c2080e7          	jalr	962(ra) # 5ba2 <printf>
    exit(1);
    37e8:	4505                	li	a0,1
    37ea:	00002097          	auipc	ra,0x2
    37ee:	048080e7          	jalr	72(ra) # 5832 <exit>
    printf("%s: open dd rdwr succeeded!\n", s);
    37f2:	85ca                	mv	a1,s2
    37f4:	00004517          	auipc	a0,0x4
    37f8:	b6c50513          	add	a0,a0,-1172 # 7360 <malloc+0x1706>
    37fc:	00002097          	auipc	ra,0x2
    3800:	3a6080e7          	jalr	934(ra) # 5ba2 <printf>
    exit(1);
    3804:	4505                	li	a0,1
    3806:	00002097          	auipc	ra,0x2
    380a:	02c080e7          	jalr	44(ra) # 5832 <exit>
    printf("%s: open dd wronly succeeded!\n", s);
    380e:	85ca                	mv	a1,s2
    3810:	00004517          	auipc	a0,0x4
    3814:	b7050513          	add	a0,a0,-1168 # 7380 <malloc+0x1726>
    3818:	00002097          	auipc	ra,0x2
    381c:	38a080e7          	jalr	906(ra) # 5ba2 <printf>
    exit(1);
    3820:	4505                	li	a0,1
    3822:	00002097          	auipc	ra,0x2
    3826:	010080e7          	jalr	16(ra) # 5832 <exit>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    382a:	85ca                	mv	a1,s2
    382c:	00004517          	auipc	a0,0x4
    3830:	b8450513          	add	a0,a0,-1148 # 73b0 <malloc+0x1756>
    3834:	00002097          	auipc	ra,0x2
    3838:	36e080e7          	jalr	878(ra) # 5ba2 <printf>
    exit(1);
    383c:	4505                	li	a0,1
    383e:	00002097          	auipc	ra,0x2
    3842:	ff4080e7          	jalr	-12(ra) # 5832 <exit>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    3846:	85ca                	mv	a1,s2
    3848:	00004517          	auipc	a0,0x4
    384c:	b9050513          	add	a0,a0,-1136 # 73d8 <malloc+0x177e>
    3850:	00002097          	auipc	ra,0x2
    3854:	352080e7          	jalr	850(ra) # 5ba2 <printf>
    exit(1);
    3858:	4505                	li	a0,1
    385a:	00002097          	auipc	ra,0x2
    385e:	fd8080e7          	jalr	-40(ra) # 5832 <exit>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    3862:	85ca                	mv	a1,s2
    3864:	00004517          	auipc	a0,0x4
    3868:	b9c50513          	add	a0,a0,-1124 # 7400 <malloc+0x17a6>
    386c:	00002097          	auipc	ra,0x2
    3870:	336080e7          	jalr	822(ra) # 5ba2 <printf>
    exit(1);
    3874:	4505                	li	a0,1
    3876:	00002097          	auipc	ra,0x2
    387a:	fbc080e7          	jalr	-68(ra) # 5832 <exit>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    387e:	85ca                	mv	a1,s2
    3880:	00004517          	auipc	a0,0x4
    3884:	ba850513          	add	a0,a0,-1112 # 7428 <malloc+0x17ce>
    3888:	00002097          	auipc	ra,0x2
    388c:	31a080e7          	jalr	794(ra) # 5ba2 <printf>
    exit(1);
    3890:	4505                	li	a0,1
    3892:	00002097          	auipc	ra,0x2
    3896:	fa0080e7          	jalr	-96(ra) # 5832 <exit>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    389a:	85ca                	mv	a1,s2
    389c:	00004517          	auipc	a0,0x4
    38a0:	bac50513          	add	a0,a0,-1108 # 7448 <malloc+0x17ee>
    38a4:	00002097          	auipc	ra,0x2
    38a8:	2fe080e7          	jalr	766(ra) # 5ba2 <printf>
    exit(1);
    38ac:	4505                	li	a0,1
    38ae:	00002097          	auipc	ra,0x2
    38b2:	f84080e7          	jalr	-124(ra) # 5832 <exit>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    38b6:	85ca                	mv	a1,s2
    38b8:	00004517          	auipc	a0,0x4
    38bc:	bb050513          	add	a0,a0,-1104 # 7468 <malloc+0x180e>
    38c0:	00002097          	auipc	ra,0x2
    38c4:	2e2080e7          	jalr	738(ra) # 5ba2 <printf>
    exit(1);
    38c8:	4505                	li	a0,1
    38ca:	00002097          	auipc	ra,0x2
    38ce:	f68080e7          	jalr	-152(ra) # 5832 <exit>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    38d2:	85ca                	mv	a1,s2
    38d4:	00004517          	auipc	a0,0x4
    38d8:	bbc50513          	add	a0,a0,-1092 # 7490 <malloc+0x1836>
    38dc:	00002097          	auipc	ra,0x2
    38e0:	2c6080e7          	jalr	710(ra) # 5ba2 <printf>
    exit(1);
    38e4:	4505                	li	a0,1
    38e6:	00002097          	auipc	ra,0x2
    38ea:	f4c080e7          	jalr	-180(ra) # 5832 <exit>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    38ee:	85ca                	mv	a1,s2
    38f0:	00004517          	auipc	a0,0x4
    38f4:	bc050513          	add	a0,a0,-1088 # 74b0 <malloc+0x1856>
    38f8:	00002097          	auipc	ra,0x2
    38fc:	2aa080e7          	jalr	682(ra) # 5ba2 <printf>
    exit(1);
    3900:	4505                	li	a0,1
    3902:	00002097          	auipc	ra,0x2
    3906:	f30080e7          	jalr	-208(ra) # 5832 <exit>
    printf("%s: chdir dd/ff succeeded!\n", s);
    390a:	85ca                	mv	a1,s2
    390c:	00004517          	auipc	a0,0x4
    3910:	bc450513          	add	a0,a0,-1084 # 74d0 <malloc+0x1876>
    3914:	00002097          	auipc	ra,0x2
    3918:	28e080e7          	jalr	654(ra) # 5ba2 <printf>
    exit(1);
    391c:	4505                	li	a0,1
    391e:	00002097          	auipc	ra,0x2
    3922:	f14080e7          	jalr	-236(ra) # 5832 <exit>
    printf("%s: chdir dd/xx succeeded!\n", s);
    3926:	85ca                	mv	a1,s2
    3928:	00004517          	auipc	a0,0x4
    392c:	bd050513          	add	a0,a0,-1072 # 74f8 <malloc+0x189e>
    3930:	00002097          	auipc	ra,0x2
    3934:	272080e7          	jalr	626(ra) # 5ba2 <printf>
    exit(1);
    3938:	4505                	li	a0,1
    393a:	00002097          	auipc	ra,0x2
    393e:	ef8080e7          	jalr	-264(ra) # 5832 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3942:	85ca                	mv	a1,s2
    3944:	00004517          	auipc	a0,0x4
    3948:	84c50513          	add	a0,a0,-1972 # 7190 <malloc+0x1536>
    394c:	00002097          	auipc	ra,0x2
    3950:	256080e7          	jalr	598(ra) # 5ba2 <printf>
    exit(1);
    3954:	4505                	li	a0,1
    3956:	00002097          	auipc	ra,0x2
    395a:	edc080e7          	jalr	-292(ra) # 5832 <exit>
    printf("%s: unlink dd/ff failed\n", s);
    395e:	85ca                	mv	a1,s2
    3960:	00004517          	auipc	a0,0x4
    3964:	bb850513          	add	a0,a0,-1096 # 7518 <malloc+0x18be>
    3968:	00002097          	auipc	ra,0x2
    396c:	23a080e7          	jalr	570(ra) # 5ba2 <printf>
    exit(1);
    3970:	4505                	li	a0,1
    3972:	00002097          	auipc	ra,0x2
    3976:	ec0080e7          	jalr	-320(ra) # 5832 <exit>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    397a:	85ca                	mv	a1,s2
    397c:	00004517          	auipc	a0,0x4
    3980:	bbc50513          	add	a0,a0,-1092 # 7538 <malloc+0x18de>
    3984:	00002097          	auipc	ra,0x2
    3988:	21e080e7          	jalr	542(ra) # 5ba2 <printf>
    exit(1);
    398c:	4505                	li	a0,1
    398e:	00002097          	auipc	ra,0x2
    3992:	ea4080e7          	jalr	-348(ra) # 5832 <exit>
    printf("%s: unlink dd/dd failed\n", s);
    3996:	85ca                	mv	a1,s2
    3998:	00004517          	auipc	a0,0x4
    399c:	bd050513          	add	a0,a0,-1072 # 7568 <malloc+0x190e>
    39a0:	00002097          	auipc	ra,0x2
    39a4:	202080e7          	jalr	514(ra) # 5ba2 <printf>
    exit(1);
    39a8:	4505                	li	a0,1
    39aa:	00002097          	auipc	ra,0x2
    39ae:	e88080e7          	jalr	-376(ra) # 5832 <exit>
    printf("%s: unlink dd failed\n", s);
    39b2:	85ca                	mv	a1,s2
    39b4:	00004517          	auipc	a0,0x4
    39b8:	bd450513          	add	a0,a0,-1068 # 7588 <malloc+0x192e>
    39bc:	00002097          	auipc	ra,0x2
    39c0:	1e6080e7          	jalr	486(ra) # 5ba2 <printf>
    exit(1);
    39c4:	4505                	li	a0,1
    39c6:	00002097          	auipc	ra,0x2
    39ca:	e6c080e7          	jalr	-404(ra) # 5832 <exit>

00000000000039ce <rmdot>:
{
    39ce:	1101                	add	sp,sp,-32
    39d0:	ec06                	sd	ra,24(sp)
    39d2:	e822                	sd	s0,16(sp)
    39d4:	e426                	sd	s1,8(sp)
    39d6:	1000                	add	s0,sp,32
    39d8:	84aa                	mv	s1,a0
  if(mkdir("dots") != 0){
    39da:	00004517          	auipc	a0,0x4
    39de:	bc650513          	add	a0,a0,-1082 # 75a0 <malloc+0x1946>
    39e2:	00002097          	auipc	ra,0x2
    39e6:	eb8080e7          	jalr	-328(ra) # 589a <mkdir>
    39ea:	e549                	bnez	a0,3a74 <rmdot+0xa6>
  if(chdir("dots") != 0){
    39ec:	00004517          	auipc	a0,0x4
    39f0:	bb450513          	add	a0,a0,-1100 # 75a0 <malloc+0x1946>
    39f4:	00002097          	auipc	ra,0x2
    39f8:	eae080e7          	jalr	-338(ra) # 58a2 <chdir>
    39fc:	e951                	bnez	a0,3a90 <rmdot+0xc2>
  if(unlink(".") == 0){
    39fe:	00003517          	auipc	a0,0x3
    3a02:	a3250513          	add	a0,a0,-1486 # 6430 <malloc+0x7d6>
    3a06:	00002097          	auipc	ra,0x2
    3a0a:	e7c080e7          	jalr	-388(ra) # 5882 <unlink>
    3a0e:	cd59                	beqz	a0,3aac <rmdot+0xde>
  if(unlink("..") == 0){
    3a10:	00003517          	auipc	a0,0x3
    3a14:	5e850513          	add	a0,a0,1512 # 6ff8 <malloc+0x139e>
    3a18:	00002097          	auipc	ra,0x2
    3a1c:	e6a080e7          	jalr	-406(ra) # 5882 <unlink>
    3a20:	c545                	beqz	a0,3ac8 <rmdot+0xfa>
  if(chdir("/") != 0){
    3a22:	00003517          	auipc	a0,0x3
    3a26:	57e50513          	add	a0,a0,1406 # 6fa0 <malloc+0x1346>
    3a2a:	00002097          	auipc	ra,0x2
    3a2e:	e78080e7          	jalr	-392(ra) # 58a2 <chdir>
    3a32:	e94d                	bnez	a0,3ae4 <rmdot+0x116>
  if(unlink("dots/.") == 0){
    3a34:	00004517          	auipc	a0,0x4
    3a38:	bd450513          	add	a0,a0,-1068 # 7608 <malloc+0x19ae>
    3a3c:	00002097          	auipc	ra,0x2
    3a40:	e46080e7          	jalr	-442(ra) # 5882 <unlink>
    3a44:	cd55                	beqz	a0,3b00 <rmdot+0x132>
  if(unlink("dots/..") == 0){
    3a46:	00004517          	auipc	a0,0x4
    3a4a:	bea50513          	add	a0,a0,-1046 # 7630 <malloc+0x19d6>
    3a4e:	00002097          	auipc	ra,0x2
    3a52:	e34080e7          	jalr	-460(ra) # 5882 <unlink>
    3a56:	c179                	beqz	a0,3b1c <rmdot+0x14e>
  if(unlink("dots") != 0){
    3a58:	00004517          	auipc	a0,0x4
    3a5c:	b4850513          	add	a0,a0,-1208 # 75a0 <malloc+0x1946>
    3a60:	00002097          	auipc	ra,0x2
    3a64:	e22080e7          	jalr	-478(ra) # 5882 <unlink>
    3a68:	e961                	bnez	a0,3b38 <rmdot+0x16a>
}
    3a6a:	60e2                	ld	ra,24(sp)
    3a6c:	6442                	ld	s0,16(sp)
    3a6e:	64a2                	ld	s1,8(sp)
    3a70:	6105                	add	sp,sp,32
    3a72:	8082                	ret
    printf("%s: mkdir dots failed\n", s);
    3a74:	85a6                	mv	a1,s1
    3a76:	00004517          	auipc	a0,0x4
    3a7a:	b3250513          	add	a0,a0,-1230 # 75a8 <malloc+0x194e>
    3a7e:	00002097          	auipc	ra,0x2
    3a82:	124080e7          	jalr	292(ra) # 5ba2 <printf>
    exit(1);
    3a86:	4505                	li	a0,1
    3a88:	00002097          	auipc	ra,0x2
    3a8c:	daa080e7          	jalr	-598(ra) # 5832 <exit>
    printf("%s: chdir dots failed\n", s);
    3a90:	85a6                	mv	a1,s1
    3a92:	00004517          	auipc	a0,0x4
    3a96:	b2e50513          	add	a0,a0,-1234 # 75c0 <malloc+0x1966>
    3a9a:	00002097          	auipc	ra,0x2
    3a9e:	108080e7          	jalr	264(ra) # 5ba2 <printf>
    exit(1);
    3aa2:	4505                	li	a0,1
    3aa4:	00002097          	auipc	ra,0x2
    3aa8:	d8e080e7          	jalr	-626(ra) # 5832 <exit>
    printf("%s: rm . worked!\n", s);
    3aac:	85a6                	mv	a1,s1
    3aae:	00004517          	auipc	a0,0x4
    3ab2:	b2a50513          	add	a0,a0,-1238 # 75d8 <malloc+0x197e>
    3ab6:	00002097          	auipc	ra,0x2
    3aba:	0ec080e7          	jalr	236(ra) # 5ba2 <printf>
    exit(1);
    3abe:	4505                	li	a0,1
    3ac0:	00002097          	auipc	ra,0x2
    3ac4:	d72080e7          	jalr	-654(ra) # 5832 <exit>
    printf("%s: rm .. worked!\n", s);
    3ac8:	85a6                	mv	a1,s1
    3aca:	00004517          	auipc	a0,0x4
    3ace:	b2650513          	add	a0,a0,-1242 # 75f0 <malloc+0x1996>
    3ad2:	00002097          	auipc	ra,0x2
    3ad6:	0d0080e7          	jalr	208(ra) # 5ba2 <printf>
    exit(1);
    3ada:	4505                	li	a0,1
    3adc:	00002097          	auipc	ra,0x2
    3ae0:	d56080e7          	jalr	-682(ra) # 5832 <exit>
    printf("%s: chdir / failed\n", s);
    3ae4:	85a6                	mv	a1,s1
    3ae6:	00003517          	auipc	a0,0x3
    3aea:	4c250513          	add	a0,a0,1218 # 6fa8 <malloc+0x134e>
    3aee:	00002097          	auipc	ra,0x2
    3af2:	0b4080e7          	jalr	180(ra) # 5ba2 <printf>
    exit(1);
    3af6:	4505                	li	a0,1
    3af8:	00002097          	auipc	ra,0x2
    3afc:	d3a080e7          	jalr	-710(ra) # 5832 <exit>
    printf("%s: unlink dots/. worked!\n", s);
    3b00:	85a6                	mv	a1,s1
    3b02:	00004517          	auipc	a0,0x4
    3b06:	b0e50513          	add	a0,a0,-1266 # 7610 <malloc+0x19b6>
    3b0a:	00002097          	auipc	ra,0x2
    3b0e:	098080e7          	jalr	152(ra) # 5ba2 <printf>
    exit(1);
    3b12:	4505                	li	a0,1
    3b14:	00002097          	auipc	ra,0x2
    3b18:	d1e080e7          	jalr	-738(ra) # 5832 <exit>
    printf("%s: unlink dots/.. worked!\n", s);
    3b1c:	85a6                	mv	a1,s1
    3b1e:	00004517          	auipc	a0,0x4
    3b22:	b1a50513          	add	a0,a0,-1254 # 7638 <malloc+0x19de>
    3b26:	00002097          	auipc	ra,0x2
    3b2a:	07c080e7          	jalr	124(ra) # 5ba2 <printf>
    exit(1);
    3b2e:	4505                	li	a0,1
    3b30:	00002097          	auipc	ra,0x2
    3b34:	d02080e7          	jalr	-766(ra) # 5832 <exit>
    printf("%s: unlink dots failed!\n", s);
    3b38:	85a6                	mv	a1,s1
    3b3a:	00004517          	auipc	a0,0x4
    3b3e:	b1e50513          	add	a0,a0,-1250 # 7658 <malloc+0x19fe>
    3b42:	00002097          	auipc	ra,0x2
    3b46:	060080e7          	jalr	96(ra) # 5ba2 <printf>
    exit(1);
    3b4a:	4505                	li	a0,1
    3b4c:	00002097          	auipc	ra,0x2
    3b50:	ce6080e7          	jalr	-794(ra) # 5832 <exit>

0000000000003b54 <dirfile>:
{
    3b54:	1101                	add	sp,sp,-32
    3b56:	ec06                	sd	ra,24(sp)
    3b58:	e822                	sd	s0,16(sp)
    3b5a:	e426                	sd	s1,8(sp)
    3b5c:	e04a                	sd	s2,0(sp)
    3b5e:	1000                	add	s0,sp,32
    3b60:	892a                	mv	s2,a0
  fd = open("dirfile", O_CREATE);
    3b62:	20000593          	li	a1,512
    3b66:	00004517          	auipc	a0,0x4
    3b6a:	b1250513          	add	a0,a0,-1262 # 7678 <malloc+0x1a1e>
    3b6e:	00002097          	auipc	ra,0x2
    3b72:	d04080e7          	jalr	-764(ra) # 5872 <open>
  if(fd < 0){
    3b76:	0e054d63          	bltz	a0,3c70 <dirfile+0x11c>
  close(fd);
    3b7a:	00002097          	auipc	ra,0x2
    3b7e:	ce0080e7          	jalr	-800(ra) # 585a <close>
  if(chdir("dirfile") == 0){
    3b82:	00004517          	auipc	a0,0x4
    3b86:	af650513          	add	a0,a0,-1290 # 7678 <malloc+0x1a1e>
    3b8a:	00002097          	auipc	ra,0x2
    3b8e:	d18080e7          	jalr	-744(ra) # 58a2 <chdir>
    3b92:	cd6d                	beqz	a0,3c8c <dirfile+0x138>
  fd = open("dirfile/xx", 0);
    3b94:	4581                	li	a1,0
    3b96:	00004517          	auipc	a0,0x4
    3b9a:	b2a50513          	add	a0,a0,-1238 # 76c0 <malloc+0x1a66>
    3b9e:	00002097          	auipc	ra,0x2
    3ba2:	cd4080e7          	jalr	-812(ra) # 5872 <open>
  if(fd >= 0){
    3ba6:	10055163          	bgez	a0,3ca8 <dirfile+0x154>
  fd = open("dirfile/xx", O_CREATE);
    3baa:	20000593          	li	a1,512
    3bae:	00004517          	auipc	a0,0x4
    3bb2:	b1250513          	add	a0,a0,-1262 # 76c0 <malloc+0x1a66>
    3bb6:	00002097          	auipc	ra,0x2
    3bba:	cbc080e7          	jalr	-836(ra) # 5872 <open>
  if(fd >= 0){
    3bbe:	10055363          	bgez	a0,3cc4 <dirfile+0x170>
  if(mkdir("dirfile/xx") == 0){
    3bc2:	00004517          	auipc	a0,0x4
    3bc6:	afe50513          	add	a0,a0,-1282 # 76c0 <malloc+0x1a66>
    3bca:	00002097          	auipc	ra,0x2
    3bce:	cd0080e7          	jalr	-816(ra) # 589a <mkdir>
    3bd2:	10050763          	beqz	a0,3ce0 <dirfile+0x18c>
  if(unlink("dirfile/xx") == 0){
    3bd6:	00004517          	auipc	a0,0x4
    3bda:	aea50513          	add	a0,a0,-1302 # 76c0 <malloc+0x1a66>
    3bde:	00002097          	auipc	ra,0x2
    3be2:	ca4080e7          	jalr	-860(ra) # 5882 <unlink>
    3be6:	10050b63          	beqz	a0,3cfc <dirfile+0x1a8>
  if(link("README", "dirfile/xx") == 0){
    3bea:	00004597          	auipc	a1,0x4
    3bee:	ad658593          	add	a1,a1,-1322 # 76c0 <malloc+0x1a66>
    3bf2:	00002517          	auipc	a0,0x2
    3bf6:	32e50513          	add	a0,a0,814 # 5f20 <malloc+0x2c6>
    3bfa:	00002097          	auipc	ra,0x2
    3bfe:	c98080e7          	jalr	-872(ra) # 5892 <link>
    3c02:	10050b63          	beqz	a0,3d18 <dirfile+0x1c4>
  if(unlink("dirfile") != 0){
    3c06:	00004517          	auipc	a0,0x4
    3c0a:	a7250513          	add	a0,a0,-1422 # 7678 <malloc+0x1a1e>
    3c0e:	00002097          	auipc	ra,0x2
    3c12:	c74080e7          	jalr	-908(ra) # 5882 <unlink>
    3c16:	10051f63          	bnez	a0,3d34 <dirfile+0x1e0>
  fd = open(".", O_RDWR);
    3c1a:	4589                	li	a1,2
    3c1c:	00003517          	auipc	a0,0x3
    3c20:	81450513          	add	a0,a0,-2028 # 6430 <malloc+0x7d6>
    3c24:	00002097          	auipc	ra,0x2
    3c28:	c4e080e7          	jalr	-946(ra) # 5872 <open>
  if(fd >= 0){
    3c2c:	12055263          	bgez	a0,3d50 <dirfile+0x1fc>
  fd = open(".", 0);
    3c30:	4581                	li	a1,0
    3c32:	00002517          	auipc	a0,0x2
    3c36:	7fe50513          	add	a0,a0,2046 # 6430 <malloc+0x7d6>
    3c3a:	00002097          	auipc	ra,0x2
    3c3e:	c38080e7          	jalr	-968(ra) # 5872 <open>
    3c42:	84aa                	mv	s1,a0
  if(write(fd, "x", 1) > 0){
    3c44:	4605                	li	a2,1
    3c46:	00002597          	auipc	a1,0x2
    3c4a:	1a258593          	add	a1,a1,418 # 5de8 <malloc+0x18e>
    3c4e:	00002097          	auipc	ra,0x2
    3c52:	c04080e7          	jalr	-1020(ra) # 5852 <write>
    3c56:	10a04b63          	bgtz	a0,3d6c <dirfile+0x218>
  close(fd);
    3c5a:	8526                	mv	a0,s1
    3c5c:	00002097          	auipc	ra,0x2
    3c60:	bfe080e7          	jalr	-1026(ra) # 585a <close>
}
    3c64:	60e2                	ld	ra,24(sp)
    3c66:	6442                	ld	s0,16(sp)
    3c68:	64a2                	ld	s1,8(sp)
    3c6a:	6902                	ld	s2,0(sp)
    3c6c:	6105                	add	sp,sp,32
    3c6e:	8082                	ret
    printf("%s: create dirfile failed\n", s);
    3c70:	85ca                	mv	a1,s2
    3c72:	00004517          	auipc	a0,0x4
    3c76:	a0e50513          	add	a0,a0,-1522 # 7680 <malloc+0x1a26>
    3c7a:	00002097          	auipc	ra,0x2
    3c7e:	f28080e7          	jalr	-216(ra) # 5ba2 <printf>
    exit(1);
    3c82:	4505                	li	a0,1
    3c84:	00002097          	auipc	ra,0x2
    3c88:	bae080e7          	jalr	-1106(ra) # 5832 <exit>
    printf("%s: chdir dirfile succeeded!\n", s);
    3c8c:	85ca                	mv	a1,s2
    3c8e:	00004517          	auipc	a0,0x4
    3c92:	a1250513          	add	a0,a0,-1518 # 76a0 <malloc+0x1a46>
    3c96:	00002097          	auipc	ra,0x2
    3c9a:	f0c080e7          	jalr	-244(ra) # 5ba2 <printf>
    exit(1);
    3c9e:	4505                	li	a0,1
    3ca0:	00002097          	auipc	ra,0x2
    3ca4:	b92080e7          	jalr	-1134(ra) # 5832 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    3ca8:	85ca                	mv	a1,s2
    3caa:	00004517          	auipc	a0,0x4
    3cae:	a2650513          	add	a0,a0,-1498 # 76d0 <malloc+0x1a76>
    3cb2:	00002097          	auipc	ra,0x2
    3cb6:	ef0080e7          	jalr	-272(ra) # 5ba2 <printf>
    exit(1);
    3cba:	4505                	li	a0,1
    3cbc:	00002097          	auipc	ra,0x2
    3cc0:	b76080e7          	jalr	-1162(ra) # 5832 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    3cc4:	85ca                	mv	a1,s2
    3cc6:	00004517          	auipc	a0,0x4
    3cca:	a0a50513          	add	a0,a0,-1526 # 76d0 <malloc+0x1a76>
    3cce:	00002097          	auipc	ra,0x2
    3cd2:	ed4080e7          	jalr	-300(ra) # 5ba2 <printf>
    exit(1);
    3cd6:	4505                	li	a0,1
    3cd8:	00002097          	auipc	ra,0x2
    3cdc:	b5a080e7          	jalr	-1190(ra) # 5832 <exit>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    3ce0:	85ca                	mv	a1,s2
    3ce2:	00004517          	auipc	a0,0x4
    3ce6:	a1650513          	add	a0,a0,-1514 # 76f8 <malloc+0x1a9e>
    3cea:	00002097          	auipc	ra,0x2
    3cee:	eb8080e7          	jalr	-328(ra) # 5ba2 <printf>
    exit(1);
    3cf2:	4505                	li	a0,1
    3cf4:	00002097          	auipc	ra,0x2
    3cf8:	b3e080e7          	jalr	-1218(ra) # 5832 <exit>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    3cfc:	85ca                	mv	a1,s2
    3cfe:	00004517          	auipc	a0,0x4
    3d02:	a2250513          	add	a0,a0,-1502 # 7720 <malloc+0x1ac6>
    3d06:	00002097          	auipc	ra,0x2
    3d0a:	e9c080e7          	jalr	-356(ra) # 5ba2 <printf>
    exit(1);
    3d0e:	4505                	li	a0,1
    3d10:	00002097          	auipc	ra,0x2
    3d14:	b22080e7          	jalr	-1246(ra) # 5832 <exit>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    3d18:	85ca                	mv	a1,s2
    3d1a:	00004517          	auipc	a0,0x4
    3d1e:	a2e50513          	add	a0,a0,-1490 # 7748 <malloc+0x1aee>
    3d22:	00002097          	auipc	ra,0x2
    3d26:	e80080e7          	jalr	-384(ra) # 5ba2 <printf>
    exit(1);
    3d2a:	4505                	li	a0,1
    3d2c:	00002097          	auipc	ra,0x2
    3d30:	b06080e7          	jalr	-1274(ra) # 5832 <exit>
    printf("%s: unlink dirfile failed!\n", s);
    3d34:	85ca                	mv	a1,s2
    3d36:	00004517          	auipc	a0,0x4
    3d3a:	a3a50513          	add	a0,a0,-1478 # 7770 <malloc+0x1b16>
    3d3e:	00002097          	auipc	ra,0x2
    3d42:	e64080e7          	jalr	-412(ra) # 5ba2 <printf>
    exit(1);
    3d46:	4505                	li	a0,1
    3d48:	00002097          	auipc	ra,0x2
    3d4c:	aea080e7          	jalr	-1302(ra) # 5832 <exit>
    printf("%s: open . for writing succeeded!\n", s);
    3d50:	85ca                	mv	a1,s2
    3d52:	00004517          	auipc	a0,0x4
    3d56:	a3e50513          	add	a0,a0,-1474 # 7790 <malloc+0x1b36>
    3d5a:	00002097          	auipc	ra,0x2
    3d5e:	e48080e7          	jalr	-440(ra) # 5ba2 <printf>
    exit(1);
    3d62:	4505                	li	a0,1
    3d64:	00002097          	auipc	ra,0x2
    3d68:	ace080e7          	jalr	-1330(ra) # 5832 <exit>
    printf("%s: write . succeeded!\n", s);
    3d6c:	85ca                	mv	a1,s2
    3d6e:	00004517          	auipc	a0,0x4
    3d72:	a4a50513          	add	a0,a0,-1462 # 77b8 <malloc+0x1b5e>
    3d76:	00002097          	auipc	ra,0x2
    3d7a:	e2c080e7          	jalr	-468(ra) # 5ba2 <printf>
    exit(1);
    3d7e:	4505                	li	a0,1
    3d80:	00002097          	auipc	ra,0x2
    3d84:	ab2080e7          	jalr	-1358(ra) # 5832 <exit>

0000000000003d88 <iref>:
{
    3d88:	7139                	add	sp,sp,-64
    3d8a:	fc06                	sd	ra,56(sp)
    3d8c:	f822                	sd	s0,48(sp)
    3d8e:	f426                	sd	s1,40(sp)
    3d90:	f04a                	sd	s2,32(sp)
    3d92:	ec4e                	sd	s3,24(sp)
    3d94:	e852                	sd	s4,16(sp)
    3d96:	e456                	sd	s5,8(sp)
    3d98:	e05a                	sd	s6,0(sp)
    3d9a:	0080                	add	s0,sp,64
    3d9c:	8b2a                	mv	s6,a0
    3d9e:	03300913          	li	s2,51
    if(mkdir("irefd") != 0){
    3da2:	00004a17          	auipc	s4,0x4
    3da6:	a2ea0a13          	add	s4,s4,-1490 # 77d0 <malloc+0x1b76>
    mkdir("");
    3daa:	00003497          	auipc	s1,0x3
    3dae:	52e48493          	add	s1,s1,1326 # 72d8 <malloc+0x167e>
    link("README", "");
    3db2:	00002a97          	auipc	s5,0x2
    3db6:	16ea8a93          	add	s5,s5,366 # 5f20 <malloc+0x2c6>
    fd = open("xx", O_CREATE);
    3dba:	00004997          	auipc	s3,0x4
    3dbe:	90e98993          	add	s3,s3,-1778 # 76c8 <malloc+0x1a6e>
    3dc2:	a891                	j	3e16 <iref+0x8e>
      printf("%s: mkdir irefd failed\n", s);
    3dc4:	85da                	mv	a1,s6
    3dc6:	00004517          	auipc	a0,0x4
    3dca:	a1250513          	add	a0,a0,-1518 # 77d8 <malloc+0x1b7e>
    3dce:	00002097          	auipc	ra,0x2
    3dd2:	dd4080e7          	jalr	-556(ra) # 5ba2 <printf>
      exit(1);
    3dd6:	4505                	li	a0,1
    3dd8:	00002097          	auipc	ra,0x2
    3ddc:	a5a080e7          	jalr	-1446(ra) # 5832 <exit>
      printf("%s: chdir irefd failed\n", s);
    3de0:	85da                	mv	a1,s6
    3de2:	00004517          	auipc	a0,0x4
    3de6:	a0e50513          	add	a0,a0,-1522 # 77f0 <malloc+0x1b96>
    3dea:	00002097          	auipc	ra,0x2
    3dee:	db8080e7          	jalr	-584(ra) # 5ba2 <printf>
      exit(1);
    3df2:	4505                	li	a0,1
    3df4:	00002097          	auipc	ra,0x2
    3df8:	a3e080e7          	jalr	-1474(ra) # 5832 <exit>
      close(fd);
    3dfc:	00002097          	auipc	ra,0x2
    3e00:	a5e080e7          	jalr	-1442(ra) # 585a <close>
    3e04:	a889                	j	3e56 <iref+0xce>
    unlink("xx");
    3e06:	854e                	mv	a0,s3
    3e08:	00002097          	auipc	ra,0x2
    3e0c:	a7a080e7          	jalr	-1414(ra) # 5882 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    3e10:	397d                	addw	s2,s2,-1
    3e12:	06090063          	beqz	s2,3e72 <iref+0xea>
    if(mkdir("irefd") != 0){
    3e16:	8552                	mv	a0,s4
    3e18:	00002097          	auipc	ra,0x2
    3e1c:	a82080e7          	jalr	-1406(ra) # 589a <mkdir>
    3e20:	f155                	bnez	a0,3dc4 <iref+0x3c>
    if(chdir("irefd") != 0){
    3e22:	8552                	mv	a0,s4
    3e24:	00002097          	auipc	ra,0x2
    3e28:	a7e080e7          	jalr	-1410(ra) # 58a2 <chdir>
    3e2c:	f955                	bnez	a0,3de0 <iref+0x58>
    mkdir("");
    3e2e:	8526                	mv	a0,s1
    3e30:	00002097          	auipc	ra,0x2
    3e34:	a6a080e7          	jalr	-1430(ra) # 589a <mkdir>
    link("README", "");
    3e38:	85a6                	mv	a1,s1
    3e3a:	8556                	mv	a0,s5
    3e3c:	00002097          	auipc	ra,0x2
    3e40:	a56080e7          	jalr	-1450(ra) # 5892 <link>
    fd = open("", O_CREATE);
    3e44:	20000593          	li	a1,512
    3e48:	8526                	mv	a0,s1
    3e4a:	00002097          	auipc	ra,0x2
    3e4e:	a28080e7          	jalr	-1496(ra) # 5872 <open>
    if(fd >= 0)
    3e52:	fa0555e3          	bgez	a0,3dfc <iref+0x74>
    fd = open("xx", O_CREATE);
    3e56:	20000593          	li	a1,512
    3e5a:	854e                	mv	a0,s3
    3e5c:	00002097          	auipc	ra,0x2
    3e60:	a16080e7          	jalr	-1514(ra) # 5872 <open>
    if(fd >= 0)
    3e64:	fa0541e3          	bltz	a0,3e06 <iref+0x7e>
      close(fd);
    3e68:	00002097          	auipc	ra,0x2
    3e6c:	9f2080e7          	jalr	-1550(ra) # 585a <close>
    3e70:	bf59                	j	3e06 <iref+0x7e>
    3e72:	03300493          	li	s1,51
    chdir("..");
    3e76:	00003997          	auipc	s3,0x3
    3e7a:	18298993          	add	s3,s3,386 # 6ff8 <malloc+0x139e>
    unlink("irefd");
    3e7e:	00004917          	auipc	s2,0x4
    3e82:	95290913          	add	s2,s2,-1710 # 77d0 <malloc+0x1b76>
    chdir("..");
    3e86:	854e                	mv	a0,s3
    3e88:	00002097          	auipc	ra,0x2
    3e8c:	a1a080e7          	jalr	-1510(ra) # 58a2 <chdir>
    unlink("irefd");
    3e90:	854a                	mv	a0,s2
    3e92:	00002097          	auipc	ra,0x2
    3e96:	9f0080e7          	jalr	-1552(ra) # 5882 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    3e9a:	34fd                	addw	s1,s1,-1
    3e9c:	f4ed                	bnez	s1,3e86 <iref+0xfe>
  chdir("/");
    3e9e:	00003517          	auipc	a0,0x3
    3ea2:	10250513          	add	a0,a0,258 # 6fa0 <malloc+0x1346>
    3ea6:	00002097          	auipc	ra,0x2
    3eaa:	9fc080e7          	jalr	-1540(ra) # 58a2 <chdir>
}
    3eae:	70e2                	ld	ra,56(sp)
    3eb0:	7442                	ld	s0,48(sp)
    3eb2:	74a2                	ld	s1,40(sp)
    3eb4:	7902                	ld	s2,32(sp)
    3eb6:	69e2                	ld	s3,24(sp)
    3eb8:	6a42                	ld	s4,16(sp)
    3eba:	6aa2                	ld	s5,8(sp)
    3ebc:	6b02                	ld	s6,0(sp)
    3ebe:	6121                	add	sp,sp,64
    3ec0:	8082                	ret

0000000000003ec2 <openiputtest>:
{
    3ec2:	7179                	add	sp,sp,-48
    3ec4:	f406                	sd	ra,40(sp)
    3ec6:	f022                	sd	s0,32(sp)
    3ec8:	ec26                	sd	s1,24(sp)
    3eca:	1800                	add	s0,sp,48
    3ecc:	84aa                	mv	s1,a0
  if(mkdir("oidir") < 0){
    3ece:	00004517          	auipc	a0,0x4
    3ed2:	93a50513          	add	a0,a0,-1734 # 7808 <malloc+0x1bae>
    3ed6:	00002097          	auipc	ra,0x2
    3eda:	9c4080e7          	jalr	-1596(ra) # 589a <mkdir>
    3ede:	04054263          	bltz	a0,3f22 <openiputtest+0x60>
  pid = fork();
    3ee2:	00002097          	auipc	ra,0x2
    3ee6:	948080e7          	jalr	-1720(ra) # 582a <fork>
  if(pid < 0){
    3eea:	04054a63          	bltz	a0,3f3e <openiputtest+0x7c>
  if(pid == 0){
    3eee:	e93d                	bnez	a0,3f64 <openiputtest+0xa2>
    int fd = open("oidir", O_RDWR);
    3ef0:	4589                	li	a1,2
    3ef2:	00004517          	auipc	a0,0x4
    3ef6:	91650513          	add	a0,a0,-1770 # 7808 <malloc+0x1bae>
    3efa:	00002097          	auipc	ra,0x2
    3efe:	978080e7          	jalr	-1672(ra) # 5872 <open>
    if(fd >= 0){
    3f02:	04054c63          	bltz	a0,3f5a <openiputtest+0x98>
      printf("%s: open directory for write succeeded\n", s);
    3f06:	85a6                	mv	a1,s1
    3f08:	00004517          	auipc	a0,0x4
    3f0c:	92050513          	add	a0,a0,-1760 # 7828 <malloc+0x1bce>
    3f10:	00002097          	auipc	ra,0x2
    3f14:	c92080e7          	jalr	-878(ra) # 5ba2 <printf>
      exit(1);
    3f18:	4505                	li	a0,1
    3f1a:	00002097          	auipc	ra,0x2
    3f1e:	918080e7          	jalr	-1768(ra) # 5832 <exit>
    printf("%s: mkdir oidir failed\n", s);
    3f22:	85a6                	mv	a1,s1
    3f24:	00004517          	auipc	a0,0x4
    3f28:	8ec50513          	add	a0,a0,-1812 # 7810 <malloc+0x1bb6>
    3f2c:	00002097          	auipc	ra,0x2
    3f30:	c76080e7          	jalr	-906(ra) # 5ba2 <printf>
    exit(1);
    3f34:	4505                	li	a0,1
    3f36:	00002097          	auipc	ra,0x2
    3f3a:	8fc080e7          	jalr	-1796(ra) # 5832 <exit>
    printf("%s: fork failed\n", s);
    3f3e:	85a6                	mv	a1,s1
    3f40:	00002517          	auipc	a0,0x2
    3f44:	69050513          	add	a0,a0,1680 # 65d0 <malloc+0x976>
    3f48:	00002097          	auipc	ra,0x2
    3f4c:	c5a080e7          	jalr	-934(ra) # 5ba2 <printf>
    exit(1);
    3f50:	4505                	li	a0,1
    3f52:	00002097          	auipc	ra,0x2
    3f56:	8e0080e7          	jalr	-1824(ra) # 5832 <exit>
    exit(0);
    3f5a:	4501                	li	a0,0
    3f5c:	00002097          	auipc	ra,0x2
    3f60:	8d6080e7          	jalr	-1834(ra) # 5832 <exit>
  sleep(1);
    3f64:	4505                	li	a0,1
    3f66:	00002097          	auipc	ra,0x2
    3f6a:	95c080e7          	jalr	-1700(ra) # 58c2 <sleep>
  if(unlink("oidir") != 0){
    3f6e:	00004517          	auipc	a0,0x4
    3f72:	89a50513          	add	a0,a0,-1894 # 7808 <malloc+0x1bae>
    3f76:	00002097          	auipc	ra,0x2
    3f7a:	90c080e7          	jalr	-1780(ra) # 5882 <unlink>
    3f7e:	cd19                	beqz	a0,3f9c <openiputtest+0xda>
    printf("%s: unlink failed\n", s);
    3f80:	85a6                	mv	a1,s1
    3f82:	00003517          	auipc	a0,0x3
    3f86:	83e50513          	add	a0,a0,-1986 # 67c0 <malloc+0xb66>
    3f8a:	00002097          	auipc	ra,0x2
    3f8e:	c18080e7          	jalr	-1000(ra) # 5ba2 <printf>
    exit(1);
    3f92:	4505                	li	a0,1
    3f94:	00002097          	auipc	ra,0x2
    3f98:	89e080e7          	jalr	-1890(ra) # 5832 <exit>
  wait(&xstatus);
    3f9c:	fdc40513          	add	a0,s0,-36
    3fa0:	00002097          	auipc	ra,0x2
    3fa4:	89a080e7          	jalr	-1894(ra) # 583a <wait>
  exit(xstatus);
    3fa8:	fdc42503          	lw	a0,-36(s0)
    3fac:	00002097          	auipc	ra,0x2
    3fb0:	886080e7          	jalr	-1914(ra) # 5832 <exit>

0000000000003fb4 <forkforkfork>:
{
    3fb4:	1101                	add	sp,sp,-32
    3fb6:	ec06                	sd	ra,24(sp)
    3fb8:	e822                	sd	s0,16(sp)
    3fba:	e426                	sd	s1,8(sp)
    3fbc:	1000                	add	s0,sp,32
    3fbe:	84aa                	mv	s1,a0
  unlink("stopforking");
    3fc0:	00004517          	auipc	a0,0x4
    3fc4:	89050513          	add	a0,a0,-1904 # 7850 <malloc+0x1bf6>
    3fc8:	00002097          	auipc	ra,0x2
    3fcc:	8ba080e7          	jalr	-1862(ra) # 5882 <unlink>
  int pid = fork();
    3fd0:	00002097          	auipc	ra,0x2
    3fd4:	85a080e7          	jalr	-1958(ra) # 582a <fork>
  if(pid < 0){
    3fd8:	04054563          	bltz	a0,4022 <forkforkfork+0x6e>
  if(pid == 0){
    3fdc:	c12d                	beqz	a0,403e <forkforkfork+0x8a>
  sleep(20); // two seconds
    3fde:	4551                	li	a0,20
    3fe0:	00002097          	auipc	ra,0x2
    3fe4:	8e2080e7          	jalr	-1822(ra) # 58c2 <sleep>
  close(open("stopforking", O_CREATE|O_RDWR));
    3fe8:	20200593          	li	a1,514
    3fec:	00004517          	auipc	a0,0x4
    3ff0:	86450513          	add	a0,a0,-1948 # 7850 <malloc+0x1bf6>
    3ff4:	00002097          	auipc	ra,0x2
    3ff8:	87e080e7          	jalr	-1922(ra) # 5872 <open>
    3ffc:	00002097          	auipc	ra,0x2
    4000:	85e080e7          	jalr	-1954(ra) # 585a <close>
  wait(0);
    4004:	4501                	li	a0,0
    4006:	00002097          	auipc	ra,0x2
    400a:	834080e7          	jalr	-1996(ra) # 583a <wait>
  sleep(10); // one second
    400e:	4529                	li	a0,10
    4010:	00002097          	auipc	ra,0x2
    4014:	8b2080e7          	jalr	-1870(ra) # 58c2 <sleep>
}
    4018:	60e2                	ld	ra,24(sp)
    401a:	6442                	ld	s0,16(sp)
    401c:	64a2                	ld	s1,8(sp)
    401e:	6105                	add	sp,sp,32
    4020:	8082                	ret
    printf("%s: fork failed", s);
    4022:	85a6                	mv	a1,s1
    4024:	00002517          	auipc	a0,0x2
    4028:	76c50513          	add	a0,a0,1900 # 6790 <malloc+0xb36>
    402c:	00002097          	auipc	ra,0x2
    4030:	b76080e7          	jalr	-1162(ra) # 5ba2 <printf>
    exit(1);
    4034:	4505                	li	a0,1
    4036:	00001097          	auipc	ra,0x1
    403a:	7fc080e7          	jalr	2044(ra) # 5832 <exit>
      int fd = open("stopforking", 0);
    403e:	00004497          	auipc	s1,0x4
    4042:	81248493          	add	s1,s1,-2030 # 7850 <malloc+0x1bf6>
    4046:	4581                	li	a1,0
    4048:	8526                	mv	a0,s1
    404a:	00002097          	auipc	ra,0x2
    404e:	828080e7          	jalr	-2008(ra) # 5872 <open>
      if(fd >= 0){
    4052:	02055763          	bgez	a0,4080 <forkforkfork+0xcc>
      if(fork() < 0){
    4056:	00001097          	auipc	ra,0x1
    405a:	7d4080e7          	jalr	2004(ra) # 582a <fork>
    405e:	fe0554e3          	bgez	a0,4046 <forkforkfork+0x92>
        close(open("stopforking", O_CREATE|O_RDWR));
    4062:	20200593          	li	a1,514
    4066:	00003517          	auipc	a0,0x3
    406a:	7ea50513          	add	a0,a0,2026 # 7850 <malloc+0x1bf6>
    406e:	00002097          	auipc	ra,0x2
    4072:	804080e7          	jalr	-2044(ra) # 5872 <open>
    4076:	00001097          	auipc	ra,0x1
    407a:	7e4080e7          	jalr	2020(ra) # 585a <close>
    407e:	b7e1                	j	4046 <forkforkfork+0x92>
        exit(0);
    4080:	4501                	li	a0,0
    4082:	00001097          	auipc	ra,0x1
    4086:	7b0080e7          	jalr	1968(ra) # 5832 <exit>

000000000000408a <killstatus>:
{
    408a:	7139                	add	sp,sp,-64
    408c:	fc06                	sd	ra,56(sp)
    408e:	f822                	sd	s0,48(sp)
    4090:	f426                	sd	s1,40(sp)
    4092:	f04a                	sd	s2,32(sp)
    4094:	ec4e                	sd	s3,24(sp)
    4096:	e852                	sd	s4,16(sp)
    4098:	0080                	add	s0,sp,64
    409a:	8a2a                	mv	s4,a0
    409c:	06400913          	li	s2,100
    if(xst != -1) {
    40a0:	59fd                	li	s3,-1
    int pid1 = fork();
    40a2:	00001097          	auipc	ra,0x1
    40a6:	788080e7          	jalr	1928(ra) # 582a <fork>
    40aa:	84aa                	mv	s1,a0
    if(pid1 < 0){
    40ac:	02054f63          	bltz	a0,40ea <killstatus+0x60>
    if(pid1 == 0){
    40b0:	c939                	beqz	a0,4106 <killstatus+0x7c>
    sleep(1);
    40b2:	4505                	li	a0,1
    40b4:	00002097          	auipc	ra,0x2
    40b8:	80e080e7          	jalr	-2034(ra) # 58c2 <sleep>
    kill(pid1);
    40bc:	8526                	mv	a0,s1
    40be:	00001097          	auipc	ra,0x1
    40c2:	7a4080e7          	jalr	1956(ra) # 5862 <kill>
    wait(&xst);
    40c6:	fcc40513          	add	a0,s0,-52
    40ca:	00001097          	auipc	ra,0x1
    40ce:	770080e7          	jalr	1904(ra) # 583a <wait>
    if(xst != -1) {
    40d2:	fcc42783          	lw	a5,-52(s0)
    40d6:	03379d63          	bne	a5,s3,4110 <killstatus+0x86>
  for(int i = 0; i < 100; i++){
    40da:	397d                	addw	s2,s2,-1
    40dc:	fc0913e3          	bnez	s2,40a2 <killstatus+0x18>
  exit(0);
    40e0:	4501                	li	a0,0
    40e2:	00001097          	auipc	ra,0x1
    40e6:	750080e7          	jalr	1872(ra) # 5832 <exit>
      printf("%s: fork failed\n", s);
    40ea:	85d2                	mv	a1,s4
    40ec:	00002517          	auipc	a0,0x2
    40f0:	4e450513          	add	a0,a0,1252 # 65d0 <malloc+0x976>
    40f4:	00002097          	auipc	ra,0x2
    40f8:	aae080e7          	jalr	-1362(ra) # 5ba2 <printf>
      exit(1);
    40fc:	4505                	li	a0,1
    40fe:	00001097          	auipc	ra,0x1
    4102:	734080e7          	jalr	1844(ra) # 5832 <exit>
        getpid();
    4106:	00001097          	auipc	ra,0x1
    410a:	7ac080e7          	jalr	1964(ra) # 58b2 <getpid>
      while(1) {
    410e:	bfe5                	j	4106 <killstatus+0x7c>
       printf("%s: status should be -1\n", s);
    4110:	85d2                	mv	a1,s4
    4112:	00003517          	auipc	a0,0x3
    4116:	74e50513          	add	a0,a0,1870 # 7860 <malloc+0x1c06>
    411a:	00002097          	auipc	ra,0x2
    411e:	a88080e7          	jalr	-1400(ra) # 5ba2 <printf>
       exit(1);
    4122:	4505                	li	a0,1
    4124:	00001097          	auipc	ra,0x1
    4128:	70e080e7          	jalr	1806(ra) # 5832 <exit>

000000000000412c <preempt>:
{
    412c:	7139                	add	sp,sp,-64
    412e:	fc06                	sd	ra,56(sp)
    4130:	f822                	sd	s0,48(sp)
    4132:	f426                	sd	s1,40(sp)
    4134:	f04a                	sd	s2,32(sp)
    4136:	ec4e                	sd	s3,24(sp)
    4138:	e852                	sd	s4,16(sp)
    413a:	0080                	add	s0,sp,64
    413c:	892a                	mv	s2,a0
  pid1 = fork();
    413e:	00001097          	auipc	ra,0x1
    4142:	6ec080e7          	jalr	1772(ra) # 582a <fork>
  if(pid1 < 0) {
    4146:	00054563          	bltz	a0,4150 <preempt+0x24>
    414a:	84aa                	mv	s1,a0
  if(pid1 == 0)
    414c:	e105                	bnez	a0,416c <preempt+0x40>
    for(;;)
    414e:	a001                	j	414e <preempt+0x22>
    printf("%s: fork failed", s);
    4150:	85ca                	mv	a1,s2
    4152:	00002517          	auipc	a0,0x2
    4156:	63e50513          	add	a0,a0,1598 # 6790 <malloc+0xb36>
    415a:	00002097          	auipc	ra,0x2
    415e:	a48080e7          	jalr	-1464(ra) # 5ba2 <printf>
    exit(1);
    4162:	4505                	li	a0,1
    4164:	00001097          	auipc	ra,0x1
    4168:	6ce080e7          	jalr	1742(ra) # 5832 <exit>
  pid2 = fork();
    416c:	00001097          	auipc	ra,0x1
    4170:	6be080e7          	jalr	1726(ra) # 582a <fork>
    4174:	89aa                	mv	s3,a0
  if(pid2 < 0) {
    4176:	00054463          	bltz	a0,417e <preempt+0x52>
  if(pid2 == 0)
    417a:	e105                	bnez	a0,419a <preempt+0x6e>
    for(;;)
    417c:	a001                	j	417c <preempt+0x50>
    printf("%s: fork failed\n", s);
    417e:	85ca                	mv	a1,s2
    4180:	00002517          	auipc	a0,0x2
    4184:	45050513          	add	a0,a0,1104 # 65d0 <malloc+0x976>
    4188:	00002097          	auipc	ra,0x2
    418c:	a1a080e7          	jalr	-1510(ra) # 5ba2 <printf>
    exit(1);
    4190:	4505                	li	a0,1
    4192:	00001097          	auipc	ra,0x1
    4196:	6a0080e7          	jalr	1696(ra) # 5832 <exit>
  pipe(pfds);
    419a:	fc840513          	add	a0,s0,-56
    419e:	00001097          	auipc	ra,0x1
    41a2:	6a4080e7          	jalr	1700(ra) # 5842 <pipe>
  pid3 = fork();
    41a6:	00001097          	auipc	ra,0x1
    41aa:	684080e7          	jalr	1668(ra) # 582a <fork>
    41ae:	8a2a                	mv	s4,a0
  if(pid3 < 0) {
    41b0:	02054e63          	bltz	a0,41ec <preempt+0xc0>
  if(pid3 == 0){
    41b4:	e525                	bnez	a0,421c <preempt+0xf0>
    close(pfds[0]);
    41b6:	fc842503          	lw	a0,-56(s0)
    41ba:	00001097          	auipc	ra,0x1
    41be:	6a0080e7          	jalr	1696(ra) # 585a <close>
    if(write(pfds[1], "x", 1) != 1)
    41c2:	4605                	li	a2,1
    41c4:	00002597          	auipc	a1,0x2
    41c8:	c2458593          	add	a1,a1,-988 # 5de8 <malloc+0x18e>
    41cc:	fcc42503          	lw	a0,-52(s0)
    41d0:	00001097          	auipc	ra,0x1
    41d4:	682080e7          	jalr	1666(ra) # 5852 <write>
    41d8:	4785                	li	a5,1
    41da:	02f51763          	bne	a0,a5,4208 <preempt+0xdc>
    close(pfds[1]);
    41de:	fcc42503          	lw	a0,-52(s0)
    41e2:	00001097          	auipc	ra,0x1
    41e6:	678080e7          	jalr	1656(ra) # 585a <close>
    for(;;)
    41ea:	a001                	j	41ea <preempt+0xbe>
     printf("%s: fork failed\n", s);
    41ec:	85ca                	mv	a1,s2
    41ee:	00002517          	auipc	a0,0x2
    41f2:	3e250513          	add	a0,a0,994 # 65d0 <malloc+0x976>
    41f6:	00002097          	auipc	ra,0x2
    41fa:	9ac080e7          	jalr	-1620(ra) # 5ba2 <printf>
     exit(1);
    41fe:	4505                	li	a0,1
    4200:	00001097          	auipc	ra,0x1
    4204:	632080e7          	jalr	1586(ra) # 5832 <exit>
      printf("%s: preempt write error", s);
    4208:	85ca                	mv	a1,s2
    420a:	00003517          	auipc	a0,0x3
    420e:	67650513          	add	a0,a0,1654 # 7880 <malloc+0x1c26>
    4212:	00002097          	auipc	ra,0x2
    4216:	990080e7          	jalr	-1648(ra) # 5ba2 <printf>
    421a:	b7d1                	j	41de <preempt+0xb2>
  close(pfds[1]);
    421c:	fcc42503          	lw	a0,-52(s0)
    4220:	00001097          	auipc	ra,0x1
    4224:	63a080e7          	jalr	1594(ra) # 585a <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    4228:	660d                	lui	a2,0x3
    422a:	00008597          	auipc	a1,0x8
    422e:	b8e58593          	add	a1,a1,-1138 # bdb8 <buf>
    4232:	fc842503          	lw	a0,-56(s0)
    4236:	00001097          	auipc	ra,0x1
    423a:	614080e7          	jalr	1556(ra) # 584a <read>
    423e:	4785                	li	a5,1
    4240:	02f50363          	beq	a0,a5,4266 <preempt+0x13a>
    printf("%s: preempt read error", s);
    4244:	85ca                	mv	a1,s2
    4246:	00003517          	auipc	a0,0x3
    424a:	65250513          	add	a0,a0,1618 # 7898 <malloc+0x1c3e>
    424e:	00002097          	auipc	ra,0x2
    4252:	954080e7          	jalr	-1708(ra) # 5ba2 <printf>
}
    4256:	70e2                	ld	ra,56(sp)
    4258:	7442                	ld	s0,48(sp)
    425a:	74a2                	ld	s1,40(sp)
    425c:	7902                	ld	s2,32(sp)
    425e:	69e2                	ld	s3,24(sp)
    4260:	6a42                	ld	s4,16(sp)
    4262:	6121                	add	sp,sp,64
    4264:	8082                	ret
  close(pfds[0]);
    4266:	fc842503          	lw	a0,-56(s0)
    426a:	00001097          	auipc	ra,0x1
    426e:	5f0080e7          	jalr	1520(ra) # 585a <close>
  printf("kill... ");
    4272:	00003517          	auipc	a0,0x3
    4276:	63e50513          	add	a0,a0,1598 # 78b0 <malloc+0x1c56>
    427a:	00002097          	auipc	ra,0x2
    427e:	928080e7          	jalr	-1752(ra) # 5ba2 <printf>
  kill(pid1);
    4282:	8526                	mv	a0,s1
    4284:	00001097          	auipc	ra,0x1
    4288:	5de080e7          	jalr	1502(ra) # 5862 <kill>
  kill(pid2);
    428c:	854e                	mv	a0,s3
    428e:	00001097          	auipc	ra,0x1
    4292:	5d4080e7          	jalr	1492(ra) # 5862 <kill>
  kill(pid3);
    4296:	8552                	mv	a0,s4
    4298:	00001097          	auipc	ra,0x1
    429c:	5ca080e7          	jalr	1482(ra) # 5862 <kill>
  printf("wait... ");
    42a0:	00003517          	auipc	a0,0x3
    42a4:	62050513          	add	a0,a0,1568 # 78c0 <malloc+0x1c66>
    42a8:	00002097          	auipc	ra,0x2
    42ac:	8fa080e7          	jalr	-1798(ra) # 5ba2 <printf>
  wait(0);
    42b0:	4501                	li	a0,0
    42b2:	00001097          	auipc	ra,0x1
    42b6:	588080e7          	jalr	1416(ra) # 583a <wait>
  wait(0);
    42ba:	4501                	li	a0,0
    42bc:	00001097          	auipc	ra,0x1
    42c0:	57e080e7          	jalr	1406(ra) # 583a <wait>
  wait(0);
    42c4:	4501                	li	a0,0
    42c6:	00001097          	auipc	ra,0x1
    42ca:	574080e7          	jalr	1396(ra) # 583a <wait>
    42ce:	b761                	j	4256 <preempt+0x12a>

00000000000042d0 <reparent>:
{
    42d0:	7179                	add	sp,sp,-48
    42d2:	f406                	sd	ra,40(sp)
    42d4:	f022                	sd	s0,32(sp)
    42d6:	ec26                	sd	s1,24(sp)
    42d8:	e84a                	sd	s2,16(sp)
    42da:	e44e                	sd	s3,8(sp)
    42dc:	e052                	sd	s4,0(sp)
    42de:	1800                	add	s0,sp,48
    42e0:	89aa                	mv	s3,a0
  int master_pid = getpid();
    42e2:	00001097          	auipc	ra,0x1
    42e6:	5d0080e7          	jalr	1488(ra) # 58b2 <getpid>
    42ea:	8a2a                	mv	s4,a0
    42ec:	0c800913          	li	s2,200
    int pid = fork();
    42f0:	00001097          	auipc	ra,0x1
    42f4:	53a080e7          	jalr	1338(ra) # 582a <fork>
    42f8:	84aa                	mv	s1,a0
    if(pid < 0){
    42fa:	02054263          	bltz	a0,431e <reparent+0x4e>
    if(pid){
    42fe:	cd21                	beqz	a0,4356 <reparent+0x86>
      if(wait(0) != pid){
    4300:	4501                	li	a0,0
    4302:	00001097          	auipc	ra,0x1
    4306:	538080e7          	jalr	1336(ra) # 583a <wait>
    430a:	02951863          	bne	a0,s1,433a <reparent+0x6a>
  for(int i = 0; i < 200; i++){
    430e:	397d                	addw	s2,s2,-1
    4310:	fe0910e3          	bnez	s2,42f0 <reparent+0x20>
  exit(0);
    4314:	4501                	li	a0,0
    4316:	00001097          	auipc	ra,0x1
    431a:	51c080e7          	jalr	1308(ra) # 5832 <exit>
      printf("%s: fork failed\n", s);
    431e:	85ce                	mv	a1,s3
    4320:	00002517          	auipc	a0,0x2
    4324:	2b050513          	add	a0,a0,688 # 65d0 <malloc+0x976>
    4328:	00002097          	auipc	ra,0x2
    432c:	87a080e7          	jalr	-1926(ra) # 5ba2 <printf>
      exit(1);
    4330:	4505                	li	a0,1
    4332:	00001097          	auipc	ra,0x1
    4336:	500080e7          	jalr	1280(ra) # 5832 <exit>
        printf("%s: wait wrong pid\n", s);
    433a:	85ce                	mv	a1,s3
    433c:	00002517          	auipc	a0,0x2
    4340:	41c50513          	add	a0,a0,1052 # 6758 <malloc+0xafe>
    4344:	00002097          	auipc	ra,0x2
    4348:	85e080e7          	jalr	-1954(ra) # 5ba2 <printf>
        exit(1);
    434c:	4505                	li	a0,1
    434e:	00001097          	auipc	ra,0x1
    4352:	4e4080e7          	jalr	1252(ra) # 5832 <exit>
      int pid2 = fork();
    4356:	00001097          	auipc	ra,0x1
    435a:	4d4080e7          	jalr	1236(ra) # 582a <fork>
      if(pid2 < 0){
    435e:	00054763          	bltz	a0,436c <reparent+0x9c>
      exit(0);
    4362:	4501                	li	a0,0
    4364:	00001097          	auipc	ra,0x1
    4368:	4ce080e7          	jalr	1230(ra) # 5832 <exit>
        kill(master_pid);
    436c:	8552                	mv	a0,s4
    436e:	00001097          	auipc	ra,0x1
    4372:	4f4080e7          	jalr	1268(ra) # 5862 <kill>
        exit(1);
    4376:	4505                	li	a0,1
    4378:	00001097          	auipc	ra,0x1
    437c:	4ba080e7          	jalr	1210(ra) # 5832 <exit>

0000000000004380 <sbrkfail>:
{
    4380:	7119                	add	sp,sp,-128
    4382:	fc86                	sd	ra,120(sp)
    4384:	f8a2                	sd	s0,112(sp)
    4386:	f4a6                	sd	s1,104(sp)
    4388:	f0ca                	sd	s2,96(sp)
    438a:	ecce                	sd	s3,88(sp)
    438c:	e8d2                	sd	s4,80(sp)
    438e:	e4d6                	sd	s5,72(sp)
    4390:	0100                	add	s0,sp,128
    4392:	8aaa                	mv	s5,a0
  if(pipe(fds) != 0){
    4394:	fb040513          	add	a0,s0,-80
    4398:	00001097          	auipc	ra,0x1
    439c:	4aa080e7          	jalr	1194(ra) # 5842 <pipe>
    43a0:	e901                	bnez	a0,43b0 <sbrkfail+0x30>
    43a2:	f8040493          	add	s1,s0,-128
    43a6:	fa840993          	add	s3,s0,-88
    43aa:	8926                	mv	s2,s1
    if(pids[i] != -1)
    43ac:	5a7d                	li	s4,-1
    43ae:	a085                	j	440e <sbrkfail+0x8e>
    printf("%s: pipe() failed\n", s);
    43b0:	85d6                	mv	a1,s5
    43b2:	00002517          	auipc	a0,0x2
    43b6:	32650513          	add	a0,a0,806 # 66d8 <malloc+0xa7e>
    43ba:	00001097          	auipc	ra,0x1
    43be:	7e8080e7          	jalr	2024(ra) # 5ba2 <printf>
    exit(1);
    43c2:	4505                	li	a0,1
    43c4:	00001097          	auipc	ra,0x1
    43c8:	46e080e7          	jalr	1134(ra) # 5832 <exit>
      sbrk(BIG - (uint64)sbrk(0));
    43cc:	00001097          	auipc	ra,0x1
    43d0:	4ee080e7          	jalr	1262(ra) # 58ba <sbrk>
    43d4:	064007b7          	lui	a5,0x6400
    43d8:	40a7853b          	subw	a0,a5,a0
    43dc:	00001097          	auipc	ra,0x1
    43e0:	4de080e7          	jalr	1246(ra) # 58ba <sbrk>
      write(fds[1], "x", 1);
    43e4:	4605                	li	a2,1
    43e6:	00002597          	auipc	a1,0x2
    43ea:	a0258593          	add	a1,a1,-1534 # 5de8 <malloc+0x18e>
    43ee:	fb442503          	lw	a0,-76(s0)
    43f2:	00001097          	auipc	ra,0x1
    43f6:	460080e7          	jalr	1120(ra) # 5852 <write>
      for(;;) sleep(1000);
    43fa:	3e800513          	li	a0,1000
    43fe:	00001097          	auipc	ra,0x1
    4402:	4c4080e7          	jalr	1220(ra) # 58c2 <sleep>
    4406:	bfd5                	j	43fa <sbrkfail+0x7a>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    4408:	0911                	add	s2,s2,4
    440a:	03390563          	beq	s2,s3,4434 <sbrkfail+0xb4>
    if((pids[i] = fork()) == 0){
    440e:	00001097          	auipc	ra,0x1
    4412:	41c080e7          	jalr	1052(ra) # 582a <fork>
    4416:	00a92023          	sw	a0,0(s2)
    441a:	d94d                	beqz	a0,43cc <sbrkfail+0x4c>
    if(pids[i] != -1)
    441c:	ff4506e3          	beq	a0,s4,4408 <sbrkfail+0x88>
      read(fds[0], &scratch, 1);
    4420:	4605                	li	a2,1
    4422:	faf40593          	add	a1,s0,-81
    4426:	fb042503          	lw	a0,-80(s0)
    442a:	00001097          	auipc	ra,0x1
    442e:	420080e7          	jalr	1056(ra) # 584a <read>
    4432:	bfd9                	j	4408 <sbrkfail+0x88>
  c = sbrk(PGSIZE);
    4434:	6505                	lui	a0,0x1
    4436:	00001097          	auipc	ra,0x1
    443a:	484080e7          	jalr	1156(ra) # 58ba <sbrk>
    443e:	8a2a                	mv	s4,a0
    if(pids[i] == -1)
    4440:	597d                	li	s2,-1
    4442:	a021                	j	444a <sbrkfail+0xca>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    4444:	0491                	add	s1,s1,4
    4446:	01348f63          	beq	s1,s3,4464 <sbrkfail+0xe4>
    if(pids[i] == -1)
    444a:	4088                	lw	a0,0(s1)
    444c:	ff250ce3          	beq	a0,s2,4444 <sbrkfail+0xc4>
    kill(pids[i]);
    4450:	00001097          	auipc	ra,0x1
    4454:	412080e7          	jalr	1042(ra) # 5862 <kill>
    wait(0);
    4458:	4501                	li	a0,0
    445a:	00001097          	auipc	ra,0x1
    445e:	3e0080e7          	jalr	992(ra) # 583a <wait>
    4462:	b7cd                	j	4444 <sbrkfail+0xc4>
  if(c == (char*)0xffffffffffffffffL){
    4464:	57fd                	li	a5,-1
    4466:	04fa0163          	beq	s4,a5,44a8 <sbrkfail+0x128>
  pid = fork();
    446a:	00001097          	auipc	ra,0x1
    446e:	3c0080e7          	jalr	960(ra) # 582a <fork>
    4472:	84aa                	mv	s1,a0
  if(pid < 0){
    4474:	04054863          	bltz	a0,44c4 <sbrkfail+0x144>
  if(pid == 0){
    4478:	c525                	beqz	a0,44e0 <sbrkfail+0x160>
  wait(&xstatus);
    447a:	fbc40513          	add	a0,s0,-68
    447e:	00001097          	auipc	ra,0x1
    4482:	3bc080e7          	jalr	956(ra) # 583a <wait>
  if(xstatus != -1 && xstatus != 2)
    4486:	fbc42783          	lw	a5,-68(s0)
    448a:	577d                	li	a4,-1
    448c:	00e78563          	beq	a5,a4,4496 <sbrkfail+0x116>
    4490:	4709                	li	a4,2
    4492:	08e79d63          	bne	a5,a4,452c <sbrkfail+0x1ac>
}
    4496:	70e6                	ld	ra,120(sp)
    4498:	7446                	ld	s0,112(sp)
    449a:	74a6                	ld	s1,104(sp)
    449c:	7906                	ld	s2,96(sp)
    449e:	69e6                	ld	s3,88(sp)
    44a0:	6a46                	ld	s4,80(sp)
    44a2:	6aa6                	ld	s5,72(sp)
    44a4:	6109                	add	sp,sp,128
    44a6:	8082                	ret
    printf("%s: failed sbrk leaked memory\n", s);
    44a8:	85d6                	mv	a1,s5
    44aa:	00003517          	auipc	a0,0x3
    44ae:	42650513          	add	a0,a0,1062 # 78d0 <malloc+0x1c76>
    44b2:	00001097          	auipc	ra,0x1
    44b6:	6f0080e7          	jalr	1776(ra) # 5ba2 <printf>
    exit(1);
    44ba:	4505                	li	a0,1
    44bc:	00001097          	auipc	ra,0x1
    44c0:	376080e7          	jalr	886(ra) # 5832 <exit>
    printf("%s: fork failed\n", s);
    44c4:	85d6                	mv	a1,s5
    44c6:	00002517          	auipc	a0,0x2
    44ca:	10a50513          	add	a0,a0,266 # 65d0 <malloc+0x976>
    44ce:	00001097          	auipc	ra,0x1
    44d2:	6d4080e7          	jalr	1748(ra) # 5ba2 <printf>
    exit(1);
    44d6:	4505                	li	a0,1
    44d8:	00001097          	auipc	ra,0x1
    44dc:	35a080e7          	jalr	858(ra) # 5832 <exit>
    a = sbrk(0);
    44e0:	4501                	li	a0,0
    44e2:	00001097          	auipc	ra,0x1
    44e6:	3d8080e7          	jalr	984(ra) # 58ba <sbrk>
    44ea:	892a                	mv	s2,a0
    sbrk(10*BIG);
    44ec:	3e800537          	lui	a0,0x3e800
    44f0:	00001097          	auipc	ra,0x1
    44f4:	3ca080e7          	jalr	970(ra) # 58ba <sbrk>
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    44f8:	87ca                	mv	a5,s2
    44fa:	3e800737          	lui	a4,0x3e800
    44fe:	993a                	add	s2,s2,a4
    4500:	6705                	lui	a4,0x1
      n += *(a+i);
    4502:	0007c683          	lbu	a3,0(a5) # 6400000 <__BSS_END__+0x63f1238>
    4506:	9cb5                	addw	s1,s1,a3
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    4508:	97ba                	add	a5,a5,a4
    450a:	ff279ce3          	bne	a5,s2,4502 <sbrkfail+0x182>
    printf("%s: allocate a lot of memory succeeded %d\n", s, n);
    450e:	8626                	mv	a2,s1
    4510:	85d6                	mv	a1,s5
    4512:	00003517          	auipc	a0,0x3
    4516:	3de50513          	add	a0,a0,990 # 78f0 <malloc+0x1c96>
    451a:	00001097          	auipc	ra,0x1
    451e:	688080e7          	jalr	1672(ra) # 5ba2 <printf>
    exit(1);
    4522:	4505                	li	a0,1
    4524:	00001097          	auipc	ra,0x1
    4528:	30e080e7          	jalr	782(ra) # 5832 <exit>
    exit(1);
    452c:	4505                	li	a0,1
    452e:	00001097          	auipc	ra,0x1
    4532:	304080e7          	jalr	772(ra) # 5832 <exit>

0000000000004536 <mem>:
{
    4536:	7139                	add	sp,sp,-64
    4538:	fc06                	sd	ra,56(sp)
    453a:	f822                	sd	s0,48(sp)
    453c:	f426                	sd	s1,40(sp)
    453e:	f04a                	sd	s2,32(sp)
    4540:	ec4e                	sd	s3,24(sp)
    4542:	0080                	add	s0,sp,64
    4544:	89aa                	mv	s3,a0
  if((pid = fork()) == 0){
    4546:	00001097          	auipc	ra,0x1
    454a:	2e4080e7          	jalr	740(ra) # 582a <fork>
    m1 = 0;
    454e:	4481                	li	s1,0
    while((m2 = malloc(10001)) != 0){
    4550:	6909                	lui	s2,0x2
    4552:	71190913          	add	s2,s2,1809 # 2711 <sbrkbasic+0xb1>
  if((pid = fork()) == 0){
    4556:	c115                	beqz	a0,457a <mem+0x44>
    wait(&xstatus);
    4558:	fcc40513          	add	a0,s0,-52
    455c:	00001097          	auipc	ra,0x1
    4560:	2de080e7          	jalr	734(ra) # 583a <wait>
    if(xstatus == -1){
    4564:	fcc42503          	lw	a0,-52(s0)
    4568:	57fd                	li	a5,-1
    456a:	06f50363          	beq	a0,a5,45d0 <mem+0x9a>
    exit(xstatus);
    456e:	00001097          	auipc	ra,0x1
    4572:	2c4080e7          	jalr	708(ra) # 5832 <exit>
      *(char**)m2 = m1;
    4576:	e104                	sd	s1,0(a0)
      m1 = m2;
    4578:	84aa                	mv	s1,a0
    while((m2 = malloc(10001)) != 0){
    457a:	854a                	mv	a0,s2
    457c:	00001097          	auipc	ra,0x1
    4580:	6de080e7          	jalr	1758(ra) # 5c5a <malloc>
    4584:	f96d                	bnez	a0,4576 <mem+0x40>
    while(m1){
    4586:	c881                	beqz	s1,4596 <mem+0x60>
      m2 = *(char**)m1;
    4588:	8526                	mv	a0,s1
    458a:	6084                	ld	s1,0(s1)
      free(m1);
    458c:	00001097          	auipc	ra,0x1
    4590:	64c080e7          	jalr	1612(ra) # 5bd8 <free>
    while(m1){
    4594:	f8f5                	bnez	s1,4588 <mem+0x52>
    m1 = malloc(1024*20);
    4596:	6515                	lui	a0,0x5
    4598:	00001097          	auipc	ra,0x1
    459c:	6c2080e7          	jalr	1730(ra) # 5c5a <malloc>
    if(m1 == 0){
    45a0:	c911                	beqz	a0,45b4 <mem+0x7e>
    free(m1);
    45a2:	00001097          	auipc	ra,0x1
    45a6:	636080e7          	jalr	1590(ra) # 5bd8 <free>
    exit(0);
    45aa:	4501                	li	a0,0
    45ac:	00001097          	auipc	ra,0x1
    45b0:	286080e7          	jalr	646(ra) # 5832 <exit>
      printf("couldn't allocate mem?!!\n", s);
    45b4:	85ce                	mv	a1,s3
    45b6:	00003517          	auipc	a0,0x3
    45ba:	36a50513          	add	a0,a0,874 # 7920 <malloc+0x1cc6>
    45be:	00001097          	auipc	ra,0x1
    45c2:	5e4080e7          	jalr	1508(ra) # 5ba2 <printf>
      exit(1);
    45c6:	4505                	li	a0,1
    45c8:	00001097          	auipc	ra,0x1
    45cc:	26a080e7          	jalr	618(ra) # 5832 <exit>
      exit(0);
    45d0:	4501                	li	a0,0
    45d2:	00001097          	auipc	ra,0x1
    45d6:	260080e7          	jalr	608(ra) # 5832 <exit>

00000000000045da <sharedfd>:
{
    45da:	7159                	add	sp,sp,-112
    45dc:	f486                	sd	ra,104(sp)
    45de:	f0a2                	sd	s0,96(sp)
    45e0:	eca6                	sd	s1,88(sp)
    45e2:	e8ca                	sd	s2,80(sp)
    45e4:	e4ce                	sd	s3,72(sp)
    45e6:	e0d2                	sd	s4,64(sp)
    45e8:	fc56                	sd	s5,56(sp)
    45ea:	f85a                	sd	s6,48(sp)
    45ec:	f45e                	sd	s7,40(sp)
    45ee:	1880                	add	s0,sp,112
    45f0:	8a2a                	mv	s4,a0
  unlink("sharedfd");
    45f2:	00003517          	auipc	a0,0x3
    45f6:	34e50513          	add	a0,a0,846 # 7940 <malloc+0x1ce6>
    45fa:	00001097          	auipc	ra,0x1
    45fe:	288080e7          	jalr	648(ra) # 5882 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    4602:	20200593          	li	a1,514
    4606:	00003517          	auipc	a0,0x3
    460a:	33a50513          	add	a0,a0,826 # 7940 <malloc+0x1ce6>
    460e:	00001097          	auipc	ra,0x1
    4612:	264080e7          	jalr	612(ra) # 5872 <open>
  if(fd < 0){
    4616:	04054a63          	bltz	a0,466a <sharedfd+0x90>
    461a:	892a                	mv	s2,a0
  pid = fork();
    461c:	00001097          	auipc	ra,0x1
    4620:	20e080e7          	jalr	526(ra) # 582a <fork>
    4624:	89aa                	mv	s3,a0
  memset(buf, pid==0?'c':'p', sizeof(buf));
    4626:	07000593          	li	a1,112
    462a:	e119                	bnez	a0,4630 <sharedfd+0x56>
    462c:	06300593          	li	a1,99
    4630:	4629                	li	a2,10
    4632:	fa040513          	add	a0,s0,-96
    4636:	00001097          	auipc	ra,0x1
    463a:	002080e7          	jalr	2(ra) # 5638 <memset>
    463e:	3e800493          	li	s1,1000
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    4642:	4629                	li	a2,10
    4644:	fa040593          	add	a1,s0,-96
    4648:	854a                	mv	a0,s2
    464a:	00001097          	auipc	ra,0x1
    464e:	208080e7          	jalr	520(ra) # 5852 <write>
    4652:	47a9                	li	a5,10
    4654:	02f51963          	bne	a0,a5,4686 <sharedfd+0xac>
  for(i = 0; i < N; i++){
    4658:	34fd                	addw	s1,s1,-1
    465a:	f4e5                	bnez	s1,4642 <sharedfd+0x68>
  if(pid == 0) {
    465c:	04099363          	bnez	s3,46a2 <sharedfd+0xc8>
    exit(0);
    4660:	4501                	li	a0,0
    4662:	00001097          	auipc	ra,0x1
    4666:	1d0080e7          	jalr	464(ra) # 5832 <exit>
    printf("%s: cannot open sharedfd for writing", s);
    466a:	85d2                	mv	a1,s4
    466c:	00003517          	auipc	a0,0x3
    4670:	2e450513          	add	a0,a0,740 # 7950 <malloc+0x1cf6>
    4674:	00001097          	auipc	ra,0x1
    4678:	52e080e7          	jalr	1326(ra) # 5ba2 <printf>
    exit(1);
    467c:	4505                	li	a0,1
    467e:	00001097          	auipc	ra,0x1
    4682:	1b4080e7          	jalr	436(ra) # 5832 <exit>
      printf("%s: write sharedfd failed\n", s);
    4686:	85d2                	mv	a1,s4
    4688:	00003517          	auipc	a0,0x3
    468c:	2f050513          	add	a0,a0,752 # 7978 <malloc+0x1d1e>
    4690:	00001097          	auipc	ra,0x1
    4694:	512080e7          	jalr	1298(ra) # 5ba2 <printf>
      exit(1);
    4698:	4505                	li	a0,1
    469a:	00001097          	auipc	ra,0x1
    469e:	198080e7          	jalr	408(ra) # 5832 <exit>
    wait(&xstatus);
    46a2:	f9c40513          	add	a0,s0,-100
    46a6:	00001097          	auipc	ra,0x1
    46aa:	194080e7          	jalr	404(ra) # 583a <wait>
    if(xstatus != 0)
    46ae:	f9c42983          	lw	s3,-100(s0)
    46b2:	00098763          	beqz	s3,46c0 <sharedfd+0xe6>
      exit(xstatus);
    46b6:	854e                	mv	a0,s3
    46b8:	00001097          	auipc	ra,0x1
    46bc:	17a080e7          	jalr	378(ra) # 5832 <exit>
  close(fd);
    46c0:	854a                	mv	a0,s2
    46c2:	00001097          	auipc	ra,0x1
    46c6:	198080e7          	jalr	408(ra) # 585a <close>
  fd = open("sharedfd", 0);
    46ca:	4581                	li	a1,0
    46cc:	00003517          	auipc	a0,0x3
    46d0:	27450513          	add	a0,a0,628 # 7940 <malloc+0x1ce6>
    46d4:	00001097          	auipc	ra,0x1
    46d8:	19e080e7          	jalr	414(ra) # 5872 <open>
    46dc:	8baa                	mv	s7,a0
  nc = np = 0;
    46de:	8ace                	mv	s5,s3
  if(fd < 0){
    46e0:	02054563          	bltz	a0,470a <sharedfd+0x130>
    46e4:	faa40913          	add	s2,s0,-86
      if(buf[i] == 'c')
    46e8:	06300493          	li	s1,99
      if(buf[i] == 'p')
    46ec:	07000b13          	li	s6,112
  while((n = read(fd, buf, sizeof(buf))) > 0){
    46f0:	4629                	li	a2,10
    46f2:	fa040593          	add	a1,s0,-96
    46f6:	855e                	mv	a0,s7
    46f8:	00001097          	auipc	ra,0x1
    46fc:	152080e7          	jalr	338(ra) # 584a <read>
    4700:	02a05f63          	blez	a0,473e <sharedfd+0x164>
    4704:	fa040793          	add	a5,s0,-96
    4708:	a01d                	j	472e <sharedfd+0x154>
    printf("%s: cannot open sharedfd for reading\n", s);
    470a:	85d2                	mv	a1,s4
    470c:	00003517          	auipc	a0,0x3
    4710:	28c50513          	add	a0,a0,652 # 7998 <malloc+0x1d3e>
    4714:	00001097          	auipc	ra,0x1
    4718:	48e080e7          	jalr	1166(ra) # 5ba2 <printf>
    exit(1);
    471c:	4505                	li	a0,1
    471e:	00001097          	auipc	ra,0x1
    4722:	114080e7          	jalr	276(ra) # 5832 <exit>
        nc++;
    4726:	2985                	addw	s3,s3,1
    for(i = 0; i < sizeof(buf); i++){
    4728:	0785                	add	a5,a5,1
    472a:	fd2783e3          	beq	a5,s2,46f0 <sharedfd+0x116>
      if(buf[i] == 'c')
    472e:	0007c703          	lbu	a4,0(a5)
    4732:	fe970ae3          	beq	a4,s1,4726 <sharedfd+0x14c>
      if(buf[i] == 'p')
    4736:	ff6719e3          	bne	a4,s6,4728 <sharedfd+0x14e>
        np++;
    473a:	2a85                	addw	s5,s5,1
    473c:	b7f5                	j	4728 <sharedfd+0x14e>
  close(fd);
    473e:	855e                	mv	a0,s7
    4740:	00001097          	auipc	ra,0x1
    4744:	11a080e7          	jalr	282(ra) # 585a <close>
  unlink("sharedfd");
    4748:	00003517          	auipc	a0,0x3
    474c:	1f850513          	add	a0,a0,504 # 7940 <malloc+0x1ce6>
    4750:	00001097          	auipc	ra,0x1
    4754:	132080e7          	jalr	306(ra) # 5882 <unlink>
  if(nc == N*SZ && np == N*SZ){
    4758:	6789                	lui	a5,0x2
    475a:	71078793          	add	a5,a5,1808 # 2710 <sbrkbasic+0xb0>
    475e:	00f99763          	bne	s3,a5,476c <sharedfd+0x192>
    4762:	6789                	lui	a5,0x2
    4764:	71078793          	add	a5,a5,1808 # 2710 <sbrkbasic+0xb0>
    4768:	02fa8063          	beq	s5,a5,4788 <sharedfd+0x1ae>
    printf("%s: nc/np test fails\n", s);
    476c:	85d2                	mv	a1,s4
    476e:	00003517          	auipc	a0,0x3
    4772:	25250513          	add	a0,a0,594 # 79c0 <malloc+0x1d66>
    4776:	00001097          	auipc	ra,0x1
    477a:	42c080e7          	jalr	1068(ra) # 5ba2 <printf>
    exit(1);
    477e:	4505                	li	a0,1
    4780:	00001097          	auipc	ra,0x1
    4784:	0b2080e7          	jalr	178(ra) # 5832 <exit>
    exit(0);
    4788:	4501                	li	a0,0
    478a:	00001097          	auipc	ra,0x1
    478e:	0a8080e7          	jalr	168(ra) # 5832 <exit>

0000000000004792 <fourfiles>:
{
    4792:	7135                	add	sp,sp,-160
    4794:	ed06                	sd	ra,152(sp)
    4796:	e922                	sd	s0,144(sp)
    4798:	e526                	sd	s1,136(sp)
    479a:	e14a                	sd	s2,128(sp)
    479c:	fcce                	sd	s3,120(sp)
    479e:	f8d2                	sd	s4,112(sp)
    47a0:	f4d6                	sd	s5,104(sp)
    47a2:	f0da                	sd	s6,96(sp)
    47a4:	ecde                	sd	s7,88(sp)
    47a6:	e8e2                	sd	s8,80(sp)
    47a8:	e4e6                	sd	s9,72(sp)
    47aa:	e0ea                	sd	s10,64(sp)
    47ac:	fc6e                	sd	s11,56(sp)
    47ae:	1100                	add	s0,sp,160
    47b0:	8caa                	mv	s9,a0
  char *names[] = { "f0", "f1", "f2", "f3" };
    47b2:	00003797          	auipc	a5,0x3
    47b6:	22678793          	add	a5,a5,550 # 79d8 <malloc+0x1d7e>
    47ba:	f6f43823          	sd	a5,-144(s0)
    47be:	00003797          	auipc	a5,0x3
    47c2:	22278793          	add	a5,a5,546 # 79e0 <malloc+0x1d86>
    47c6:	f6f43c23          	sd	a5,-136(s0)
    47ca:	00003797          	auipc	a5,0x3
    47ce:	21e78793          	add	a5,a5,542 # 79e8 <malloc+0x1d8e>
    47d2:	f8f43023          	sd	a5,-128(s0)
    47d6:	00003797          	auipc	a5,0x3
    47da:	21a78793          	add	a5,a5,538 # 79f0 <malloc+0x1d96>
    47de:	f8f43423          	sd	a5,-120(s0)
  for(pi = 0; pi < NCHILD; pi++){
    47e2:	f7040b93          	add	s7,s0,-144
  char *names[] = { "f0", "f1", "f2", "f3" };
    47e6:	895e                	mv	s2,s7
  for(pi = 0; pi < NCHILD; pi++){
    47e8:	4481                	li	s1,0
    47ea:	4a11                	li	s4,4
    fname = names[pi];
    47ec:	00093983          	ld	s3,0(s2)
    unlink(fname);
    47f0:	854e                	mv	a0,s3
    47f2:	00001097          	auipc	ra,0x1
    47f6:	090080e7          	jalr	144(ra) # 5882 <unlink>
    pid = fork();
    47fa:	00001097          	auipc	ra,0x1
    47fe:	030080e7          	jalr	48(ra) # 582a <fork>
    if(pid < 0){
    4802:	04054063          	bltz	a0,4842 <fourfiles+0xb0>
    if(pid == 0){
    4806:	cd21                	beqz	a0,485e <fourfiles+0xcc>
  for(pi = 0; pi < NCHILD; pi++){
    4808:	2485                	addw	s1,s1,1
    480a:	0921                	add	s2,s2,8
    480c:	ff4490e3          	bne	s1,s4,47ec <fourfiles+0x5a>
    4810:	4491                	li	s1,4
    wait(&xstatus);
    4812:	f6c40513          	add	a0,s0,-148
    4816:	00001097          	auipc	ra,0x1
    481a:	024080e7          	jalr	36(ra) # 583a <wait>
    if(xstatus != 0)
    481e:	f6c42a83          	lw	s5,-148(s0)
    4822:	0c0a9863          	bnez	s5,48f2 <fourfiles+0x160>
  for(pi = 0; pi < NCHILD; pi++){
    4826:	34fd                	addw	s1,s1,-1
    4828:	f4ed                	bnez	s1,4812 <fourfiles+0x80>
    482a:	03000b13          	li	s6,48
    while((n = read(fd, buf, sizeof(buf))) > 0){
    482e:	00007a17          	auipc	s4,0x7
    4832:	58aa0a13          	add	s4,s4,1418 # bdb8 <buf>
    if(total != N*SZ){
    4836:	6d05                	lui	s10,0x1
    4838:	770d0d13          	add	s10,s10,1904 # 1770 <pipe1+0x34>
  for(i = 0; i < NCHILD; i++){
    483c:	03400d93          	li	s11,52
    4840:	a22d                	j	496a <fourfiles+0x1d8>
      printf("fork failed\n", s);
    4842:	85e6                	mv	a1,s9
    4844:	00002517          	auipc	a0,0x2
    4848:	1ac50513          	add	a0,a0,428 # 69f0 <malloc+0xd96>
    484c:	00001097          	auipc	ra,0x1
    4850:	356080e7          	jalr	854(ra) # 5ba2 <printf>
      exit(1);
    4854:	4505                	li	a0,1
    4856:	00001097          	auipc	ra,0x1
    485a:	fdc080e7          	jalr	-36(ra) # 5832 <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    485e:	20200593          	li	a1,514
    4862:	854e                	mv	a0,s3
    4864:	00001097          	auipc	ra,0x1
    4868:	00e080e7          	jalr	14(ra) # 5872 <open>
    486c:	892a                	mv	s2,a0
      if(fd < 0){
    486e:	04054763          	bltz	a0,48bc <fourfiles+0x12a>
      memset(buf, '0'+pi, SZ);
    4872:	1f400613          	li	a2,500
    4876:	0304859b          	addw	a1,s1,48
    487a:	00007517          	auipc	a0,0x7
    487e:	53e50513          	add	a0,a0,1342 # bdb8 <buf>
    4882:	00001097          	auipc	ra,0x1
    4886:	db6080e7          	jalr	-586(ra) # 5638 <memset>
    488a:	44b1                	li	s1,12
        if((n = write(fd, buf, SZ)) != SZ){
    488c:	00007997          	auipc	s3,0x7
    4890:	52c98993          	add	s3,s3,1324 # bdb8 <buf>
    4894:	1f400613          	li	a2,500
    4898:	85ce                	mv	a1,s3
    489a:	854a                	mv	a0,s2
    489c:	00001097          	auipc	ra,0x1
    48a0:	fb6080e7          	jalr	-74(ra) # 5852 <write>
    48a4:	85aa                	mv	a1,a0
    48a6:	1f400793          	li	a5,500
    48aa:	02f51763          	bne	a0,a5,48d8 <fourfiles+0x146>
      for(i = 0; i < N; i++){
    48ae:	34fd                	addw	s1,s1,-1
    48b0:	f0f5                	bnez	s1,4894 <fourfiles+0x102>
      exit(0);
    48b2:	4501                	li	a0,0
    48b4:	00001097          	auipc	ra,0x1
    48b8:	f7e080e7          	jalr	-130(ra) # 5832 <exit>
        printf("create failed\n", s);
    48bc:	85e6                	mv	a1,s9
    48be:	00003517          	auipc	a0,0x3
    48c2:	13a50513          	add	a0,a0,314 # 79f8 <malloc+0x1d9e>
    48c6:	00001097          	auipc	ra,0x1
    48ca:	2dc080e7          	jalr	732(ra) # 5ba2 <printf>
        exit(1);
    48ce:	4505                	li	a0,1
    48d0:	00001097          	auipc	ra,0x1
    48d4:	f62080e7          	jalr	-158(ra) # 5832 <exit>
          printf("write failed %d\n", n);
    48d8:	00003517          	auipc	a0,0x3
    48dc:	13050513          	add	a0,a0,304 # 7a08 <malloc+0x1dae>
    48e0:	00001097          	auipc	ra,0x1
    48e4:	2c2080e7          	jalr	706(ra) # 5ba2 <printf>
          exit(1);
    48e8:	4505                	li	a0,1
    48ea:	00001097          	auipc	ra,0x1
    48ee:	f48080e7          	jalr	-184(ra) # 5832 <exit>
      exit(xstatus);
    48f2:	8556                	mv	a0,s5
    48f4:	00001097          	auipc	ra,0x1
    48f8:	f3e080e7          	jalr	-194(ra) # 5832 <exit>
          printf("wrong char\n", s);
    48fc:	85e6                	mv	a1,s9
    48fe:	00003517          	auipc	a0,0x3
    4902:	12250513          	add	a0,a0,290 # 7a20 <malloc+0x1dc6>
    4906:	00001097          	auipc	ra,0x1
    490a:	29c080e7          	jalr	668(ra) # 5ba2 <printf>
          exit(1);
    490e:	4505                	li	a0,1
    4910:	00001097          	auipc	ra,0x1
    4914:	f22080e7          	jalr	-222(ra) # 5832 <exit>
      total += n;
    4918:	00a9093b          	addw	s2,s2,a0
    while((n = read(fd, buf, sizeof(buf))) > 0){
    491c:	660d                	lui	a2,0x3
    491e:	85d2                	mv	a1,s4
    4920:	854e                	mv	a0,s3
    4922:	00001097          	auipc	ra,0x1
    4926:	f28080e7          	jalr	-216(ra) # 584a <read>
    492a:	02a05063          	blez	a0,494a <fourfiles+0x1b8>
    492e:	00007797          	auipc	a5,0x7
    4932:	48a78793          	add	a5,a5,1162 # bdb8 <buf>
    4936:	00f506b3          	add	a3,a0,a5
        if(buf[j] != '0'+i){
    493a:	0007c703          	lbu	a4,0(a5)
    493e:	fa971fe3          	bne	a4,s1,48fc <fourfiles+0x16a>
      for(j = 0; j < n; j++){
    4942:	0785                	add	a5,a5,1
    4944:	fed79be3          	bne	a5,a3,493a <fourfiles+0x1a8>
    4948:	bfc1                	j	4918 <fourfiles+0x186>
    close(fd);
    494a:	854e                	mv	a0,s3
    494c:	00001097          	auipc	ra,0x1
    4950:	f0e080e7          	jalr	-242(ra) # 585a <close>
    if(total != N*SZ){
    4954:	03a91863          	bne	s2,s10,4984 <fourfiles+0x1f2>
    unlink(fname);
    4958:	8562                	mv	a0,s8
    495a:	00001097          	auipc	ra,0x1
    495e:	f28080e7          	jalr	-216(ra) # 5882 <unlink>
  for(i = 0; i < NCHILD; i++){
    4962:	0ba1                	add	s7,s7,8
    4964:	2b05                	addw	s6,s6,1
    4966:	03bb0d63          	beq	s6,s11,49a0 <fourfiles+0x20e>
    fname = names[i];
    496a:	000bbc03          	ld	s8,0(s7)
    fd = open(fname, 0);
    496e:	4581                	li	a1,0
    4970:	8562                	mv	a0,s8
    4972:	00001097          	auipc	ra,0x1
    4976:	f00080e7          	jalr	-256(ra) # 5872 <open>
    497a:	89aa                	mv	s3,a0
    total = 0;
    497c:	8956                	mv	s2,s5
        if(buf[j] != '0'+i){
    497e:	000b049b          	sext.w	s1,s6
    while((n = read(fd, buf, sizeof(buf))) > 0){
    4982:	bf69                	j	491c <fourfiles+0x18a>
      printf("wrong length %d\n", total);
    4984:	85ca                	mv	a1,s2
    4986:	00003517          	auipc	a0,0x3
    498a:	0aa50513          	add	a0,a0,170 # 7a30 <malloc+0x1dd6>
    498e:	00001097          	auipc	ra,0x1
    4992:	214080e7          	jalr	532(ra) # 5ba2 <printf>
      exit(1);
    4996:	4505                	li	a0,1
    4998:	00001097          	auipc	ra,0x1
    499c:	e9a080e7          	jalr	-358(ra) # 5832 <exit>
}
    49a0:	60ea                	ld	ra,152(sp)
    49a2:	644a                	ld	s0,144(sp)
    49a4:	64aa                	ld	s1,136(sp)
    49a6:	690a                	ld	s2,128(sp)
    49a8:	79e6                	ld	s3,120(sp)
    49aa:	7a46                	ld	s4,112(sp)
    49ac:	7aa6                	ld	s5,104(sp)
    49ae:	7b06                	ld	s6,96(sp)
    49b0:	6be6                	ld	s7,88(sp)
    49b2:	6c46                	ld	s8,80(sp)
    49b4:	6ca6                	ld	s9,72(sp)
    49b6:	6d06                	ld	s10,64(sp)
    49b8:	7de2                	ld	s11,56(sp)
    49ba:	610d                	add	sp,sp,160
    49bc:	8082                	ret

00000000000049be <concreate>:
{
    49be:	7135                	add	sp,sp,-160
    49c0:	ed06                	sd	ra,152(sp)
    49c2:	e922                	sd	s0,144(sp)
    49c4:	e526                	sd	s1,136(sp)
    49c6:	e14a                	sd	s2,128(sp)
    49c8:	fcce                	sd	s3,120(sp)
    49ca:	f8d2                	sd	s4,112(sp)
    49cc:	f4d6                	sd	s5,104(sp)
    49ce:	f0da                	sd	s6,96(sp)
    49d0:	ecde                	sd	s7,88(sp)
    49d2:	1100                	add	s0,sp,160
    49d4:	89aa                	mv	s3,a0
  file[0] = 'C';
    49d6:	04300793          	li	a5,67
    49da:	faf40423          	sb	a5,-88(s0)
  file[2] = '\0';
    49de:	fa040523          	sb	zero,-86(s0)
  for(i = 0; i < N; i++){
    49e2:	4901                	li	s2,0
    if(pid && (i % 3) == 1){
    49e4:	4b0d                	li	s6,3
    49e6:	4a85                	li	s5,1
      link("C0", file);
    49e8:	00003b97          	auipc	s7,0x3
    49ec:	060b8b93          	add	s7,s7,96 # 7a48 <malloc+0x1dee>
  for(i = 0; i < N; i++){
    49f0:	02800a13          	li	s4,40
    49f4:	acc9                	j	4cc6 <concreate+0x308>
      link("C0", file);
    49f6:	fa840593          	add	a1,s0,-88
    49fa:	855e                	mv	a0,s7
    49fc:	00001097          	auipc	ra,0x1
    4a00:	e96080e7          	jalr	-362(ra) # 5892 <link>
    if(pid == 0) {
    4a04:	a465                	j	4cac <concreate+0x2ee>
    } else if(pid == 0 && (i % 5) == 1){
    4a06:	4795                	li	a5,5
    4a08:	02f9693b          	remw	s2,s2,a5
    4a0c:	4785                	li	a5,1
    4a0e:	02f90b63          	beq	s2,a5,4a44 <concreate+0x86>
      fd = open(file, O_CREATE | O_RDWR);
    4a12:	20200593          	li	a1,514
    4a16:	fa840513          	add	a0,s0,-88
    4a1a:	00001097          	auipc	ra,0x1
    4a1e:	e58080e7          	jalr	-424(ra) # 5872 <open>
      if(fd < 0){
    4a22:	26055c63          	bgez	a0,4c9a <concreate+0x2dc>
        printf("concreate create %s failed\n", file);
    4a26:	fa840593          	add	a1,s0,-88
    4a2a:	00003517          	auipc	a0,0x3
    4a2e:	02650513          	add	a0,a0,38 # 7a50 <malloc+0x1df6>
    4a32:	00001097          	auipc	ra,0x1
    4a36:	170080e7          	jalr	368(ra) # 5ba2 <printf>
        exit(1);
    4a3a:	4505                	li	a0,1
    4a3c:	00001097          	auipc	ra,0x1
    4a40:	df6080e7          	jalr	-522(ra) # 5832 <exit>
      link("C0", file);
    4a44:	fa840593          	add	a1,s0,-88
    4a48:	00003517          	auipc	a0,0x3
    4a4c:	00050513          	mv	a0,a0
    4a50:	00001097          	auipc	ra,0x1
    4a54:	e42080e7          	jalr	-446(ra) # 5892 <link>
      exit(0);
    4a58:	4501                	li	a0,0
    4a5a:	00001097          	auipc	ra,0x1
    4a5e:	dd8080e7          	jalr	-552(ra) # 5832 <exit>
        exit(1);
    4a62:	4505                	li	a0,1
    4a64:	00001097          	auipc	ra,0x1
    4a68:	dce080e7          	jalr	-562(ra) # 5832 <exit>
  memset(fa, 0, sizeof(fa));
    4a6c:	02800613          	li	a2,40
    4a70:	4581                	li	a1,0
    4a72:	f8040513          	add	a0,s0,-128
    4a76:	00001097          	auipc	ra,0x1
    4a7a:	bc2080e7          	jalr	-1086(ra) # 5638 <memset>
  fd = open(".", 0);
    4a7e:	4581                	li	a1,0
    4a80:	00002517          	auipc	a0,0x2
    4a84:	9b050513          	add	a0,a0,-1616 # 6430 <malloc+0x7d6>
    4a88:	00001097          	auipc	ra,0x1
    4a8c:	dea080e7          	jalr	-534(ra) # 5872 <open>
    4a90:	892a                	mv	s2,a0
  n = 0;
    4a92:	8aa6                	mv	s5,s1
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    4a94:	04300a13          	li	s4,67
      if(i < 0 || i >= sizeof(fa)){
    4a98:	02700b13          	li	s6,39
      fa[i] = 1;
    4a9c:	4b85                	li	s7,1
  while(read(fd, &de, sizeof(de)) > 0){
    4a9e:	4641                	li	a2,16
    4aa0:	f7040593          	add	a1,s0,-144
    4aa4:	854a                	mv	a0,s2
    4aa6:	00001097          	auipc	ra,0x1
    4aaa:	da4080e7          	jalr	-604(ra) # 584a <read>
    4aae:	08a05263          	blez	a0,4b32 <concreate+0x174>
    if(de.inum == 0)
    4ab2:	f7045783          	lhu	a5,-144(s0)
    4ab6:	d7e5                	beqz	a5,4a9e <concreate+0xe0>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    4ab8:	f7244783          	lbu	a5,-142(s0)
    4abc:	ff4791e3          	bne	a5,s4,4a9e <concreate+0xe0>
    4ac0:	f7444783          	lbu	a5,-140(s0)
    4ac4:	ffe9                	bnez	a5,4a9e <concreate+0xe0>
      i = de.name[1] - '0';
    4ac6:	f7344783          	lbu	a5,-141(s0)
    4aca:	fd07879b          	addw	a5,a5,-48
    4ace:	0007871b          	sext.w	a4,a5
      if(i < 0 || i >= sizeof(fa)){
    4ad2:	02eb6063          	bltu	s6,a4,4af2 <concreate+0x134>
      if(fa[i]){
    4ad6:	fb070793          	add	a5,a4,-80 # fb0 <bigdir+0x50>
    4ada:	97a2                	add	a5,a5,s0
    4adc:	fd07c783          	lbu	a5,-48(a5)
    4ae0:	eb8d                	bnez	a5,4b12 <concreate+0x154>
      fa[i] = 1;
    4ae2:	fb070793          	add	a5,a4,-80
    4ae6:	00878733          	add	a4,a5,s0
    4aea:	fd770823          	sb	s7,-48(a4)
      n++;
    4aee:	2a85                	addw	s5,s5,1
    4af0:	b77d                	j	4a9e <concreate+0xe0>
        printf("%s: concreate weird file %s\n", s, de.name);
    4af2:	f7240613          	add	a2,s0,-142
    4af6:	85ce                	mv	a1,s3
    4af8:	00003517          	auipc	a0,0x3
    4afc:	f7850513          	add	a0,a0,-136 # 7a70 <malloc+0x1e16>
    4b00:	00001097          	auipc	ra,0x1
    4b04:	0a2080e7          	jalr	162(ra) # 5ba2 <printf>
        exit(1);
    4b08:	4505                	li	a0,1
    4b0a:	00001097          	auipc	ra,0x1
    4b0e:	d28080e7          	jalr	-728(ra) # 5832 <exit>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    4b12:	f7240613          	add	a2,s0,-142
    4b16:	85ce                	mv	a1,s3
    4b18:	00003517          	auipc	a0,0x3
    4b1c:	f7850513          	add	a0,a0,-136 # 7a90 <malloc+0x1e36>
    4b20:	00001097          	auipc	ra,0x1
    4b24:	082080e7          	jalr	130(ra) # 5ba2 <printf>
        exit(1);
    4b28:	4505                	li	a0,1
    4b2a:	00001097          	auipc	ra,0x1
    4b2e:	d08080e7          	jalr	-760(ra) # 5832 <exit>
  close(fd);
    4b32:	854a                	mv	a0,s2
    4b34:	00001097          	auipc	ra,0x1
    4b38:	d26080e7          	jalr	-730(ra) # 585a <close>
  if(n != N){
    4b3c:	02800793          	li	a5,40
    4b40:	00fa9763          	bne	s5,a5,4b4e <concreate+0x190>
    if(((i % 3) == 0 && pid == 0) ||
    4b44:	4a8d                	li	s5,3
    4b46:	4b05                	li	s6,1
  for(i = 0; i < N; i++){
    4b48:	02800a13          	li	s4,40
    4b4c:	a8c9                	j	4c1e <concreate+0x260>
    printf("%s: concreate not enough files in directory listing\n", s);
    4b4e:	85ce                	mv	a1,s3
    4b50:	00003517          	auipc	a0,0x3
    4b54:	f6850513          	add	a0,a0,-152 # 7ab8 <malloc+0x1e5e>
    4b58:	00001097          	auipc	ra,0x1
    4b5c:	04a080e7          	jalr	74(ra) # 5ba2 <printf>
    exit(1);
    4b60:	4505                	li	a0,1
    4b62:	00001097          	auipc	ra,0x1
    4b66:	cd0080e7          	jalr	-816(ra) # 5832 <exit>
      printf("%s: fork failed\n", s);
    4b6a:	85ce                	mv	a1,s3
    4b6c:	00002517          	auipc	a0,0x2
    4b70:	a6450513          	add	a0,a0,-1436 # 65d0 <malloc+0x976>
    4b74:	00001097          	auipc	ra,0x1
    4b78:	02e080e7          	jalr	46(ra) # 5ba2 <printf>
      exit(1);
    4b7c:	4505                	li	a0,1
    4b7e:	00001097          	auipc	ra,0x1
    4b82:	cb4080e7          	jalr	-844(ra) # 5832 <exit>
      close(open(file, 0));
    4b86:	4581                	li	a1,0
    4b88:	fa840513          	add	a0,s0,-88
    4b8c:	00001097          	auipc	ra,0x1
    4b90:	ce6080e7          	jalr	-794(ra) # 5872 <open>
    4b94:	00001097          	auipc	ra,0x1
    4b98:	cc6080e7          	jalr	-826(ra) # 585a <close>
      close(open(file, 0));
    4b9c:	4581                	li	a1,0
    4b9e:	fa840513          	add	a0,s0,-88
    4ba2:	00001097          	auipc	ra,0x1
    4ba6:	cd0080e7          	jalr	-816(ra) # 5872 <open>
    4baa:	00001097          	auipc	ra,0x1
    4bae:	cb0080e7          	jalr	-848(ra) # 585a <close>
      close(open(file, 0));
    4bb2:	4581                	li	a1,0
    4bb4:	fa840513          	add	a0,s0,-88
    4bb8:	00001097          	auipc	ra,0x1
    4bbc:	cba080e7          	jalr	-838(ra) # 5872 <open>
    4bc0:	00001097          	auipc	ra,0x1
    4bc4:	c9a080e7          	jalr	-870(ra) # 585a <close>
      close(open(file, 0));
    4bc8:	4581                	li	a1,0
    4bca:	fa840513          	add	a0,s0,-88
    4bce:	00001097          	auipc	ra,0x1
    4bd2:	ca4080e7          	jalr	-860(ra) # 5872 <open>
    4bd6:	00001097          	auipc	ra,0x1
    4bda:	c84080e7          	jalr	-892(ra) # 585a <close>
      close(open(file, 0));
    4bde:	4581                	li	a1,0
    4be0:	fa840513          	add	a0,s0,-88
    4be4:	00001097          	auipc	ra,0x1
    4be8:	c8e080e7          	jalr	-882(ra) # 5872 <open>
    4bec:	00001097          	auipc	ra,0x1
    4bf0:	c6e080e7          	jalr	-914(ra) # 585a <close>
      close(open(file, 0));
    4bf4:	4581                	li	a1,0
    4bf6:	fa840513          	add	a0,s0,-88
    4bfa:	00001097          	auipc	ra,0x1
    4bfe:	c78080e7          	jalr	-904(ra) # 5872 <open>
    4c02:	00001097          	auipc	ra,0x1
    4c06:	c58080e7          	jalr	-936(ra) # 585a <close>
    if(pid == 0)
    4c0a:	08090363          	beqz	s2,4c90 <concreate+0x2d2>
      wait(0);
    4c0e:	4501                	li	a0,0
    4c10:	00001097          	auipc	ra,0x1
    4c14:	c2a080e7          	jalr	-982(ra) # 583a <wait>
  for(i = 0; i < N; i++){
    4c18:	2485                	addw	s1,s1,1
    4c1a:	0f448563          	beq	s1,s4,4d04 <concreate+0x346>
    file[1] = '0' + i;
    4c1e:	0304879b          	addw	a5,s1,48
    4c22:	faf404a3          	sb	a5,-87(s0)
    pid = fork();
    4c26:	00001097          	auipc	ra,0x1
    4c2a:	c04080e7          	jalr	-1020(ra) # 582a <fork>
    4c2e:	892a                	mv	s2,a0
    if(pid < 0){
    4c30:	f2054de3          	bltz	a0,4b6a <concreate+0x1ac>
    if(((i % 3) == 0 && pid == 0) ||
    4c34:	0354e73b          	remw	a4,s1,s5
    4c38:	00a767b3          	or	a5,a4,a0
    4c3c:	2781                	sext.w	a5,a5
    4c3e:	d7a1                	beqz	a5,4b86 <concreate+0x1c8>
    4c40:	01671363          	bne	a4,s6,4c46 <concreate+0x288>
       ((i % 3) == 1 && pid != 0)){
    4c44:	f129                	bnez	a0,4b86 <concreate+0x1c8>
      unlink(file);
    4c46:	fa840513          	add	a0,s0,-88
    4c4a:	00001097          	auipc	ra,0x1
    4c4e:	c38080e7          	jalr	-968(ra) # 5882 <unlink>
      unlink(file);
    4c52:	fa840513          	add	a0,s0,-88
    4c56:	00001097          	auipc	ra,0x1
    4c5a:	c2c080e7          	jalr	-980(ra) # 5882 <unlink>
      unlink(file);
    4c5e:	fa840513          	add	a0,s0,-88
    4c62:	00001097          	auipc	ra,0x1
    4c66:	c20080e7          	jalr	-992(ra) # 5882 <unlink>
      unlink(file);
    4c6a:	fa840513          	add	a0,s0,-88
    4c6e:	00001097          	auipc	ra,0x1
    4c72:	c14080e7          	jalr	-1004(ra) # 5882 <unlink>
      unlink(file);
    4c76:	fa840513          	add	a0,s0,-88
    4c7a:	00001097          	auipc	ra,0x1
    4c7e:	c08080e7          	jalr	-1016(ra) # 5882 <unlink>
      unlink(file);
    4c82:	fa840513          	add	a0,s0,-88
    4c86:	00001097          	auipc	ra,0x1
    4c8a:	bfc080e7          	jalr	-1028(ra) # 5882 <unlink>
    4c8e:	bfb5                	j	4c0a <concreate+0x24c>
      exit(0);
    4c90:	4501                	li	a0,0
    4c92:	00001097          	auipc	ra,0x1
    4c96:	ba0080e7          	jalr	-1120(ra) # 5832 <exit>
      close(fd);
    4c9a:	00001097          	auipc	ra,0x1
    4c9e:	bc0080e7          	jalr	-1088(ra) # 585a <close>
    if(pid == 0) {
    4ca2:	bb5d                	j	4a58 <concreate+0x9a>
      close(fd);
    4ca4:	00001097          	auipc	ra,0x1
    4ca8:	bb6080e7          	jalr	-1098(ra) # 585a <close>
      wait(&xstatus);
    4cac:	f6c40513          	add	a0,s0,-148
    4cb0:	00001097          	auipc	ra,0x1
    4cb4:	b8a080e7          	jalr	-1142(ra) # 583a <wait>
      if(xstatus != 0)
    4cb8:	f6c42483          	lw	s1,-148(s0)
    4cbc:	da0493e3          	bnez	s1,4a62 <concreate+0xa4>
  for(i = 0; i < N; i++){
    4cc0:	2905                	addw	s2,s2,1
    4cc2:	db4905e3          	beq	s2,s4,4a6c <concreate+0xae>
    file[1] = '0' + i;
    4cc6:	0309079b          	addw	a5,s2,48
    4cca:	faf404a3          	sb	a5,-87(s0)
    unlink(file);
    4cce:	fa840513          	add	a0,s0,-88
    4cd2:	00001097          	auipc	ra,0x1
    4cd6:	bb0080e7          	jalr	-1104(ra) # 5882 <unlink>
    pid = fork();
    4cda:	00001097          	auipc	ra,0x1
    4cde:	b50080e7          	jalr	-1200(ra) # 582a <fork>
    if(pid && (i % 3) == 1){
    4ce2:	d20502e3          	beqz	a0,4a06 <concreate+0x48>
    4ce6:	036967bb          	remw	a5,s2,s6
    4cea:	d15786e3          	beq	a5,s5,49f6 <concreate+0x38>
      fd = open(file, O_CREATE | O_RDWR);
    4cee:	20200593          	li	a1,514
    4cf2:	fa840513          	add	a0,s0,-88
    4cf6:	00001097          	auipc	ra,0x1
    4cfa:	b7c080e7          	jalr	-1156(ra) # 5872 <open>
      if(fd < 0){
    4cfe:	fa0553e3          	bgez	a0,4ca4 <concreate+0x2e6>
    4d02:	b315                	j	4a26 <concreate+0x68>
}
    4d04:	60ea                	ld	ra,152(sp)
    4d06:	644a                	ld	s0,144(sp)
    4d08:	64aa                	ld	s1,136(sp)
    4d0a:	690a                	ld	s2,128(sp)
    4d0c:	79e6                	ld	s3,120(sp)
    4d0e:	7a46                	ld	s4,112(sp)
    4d10:	7aa6                	ld	s5,104(sp)
    4d12:	7b06                	ld	s6,96(sp)
    4d14:	6be6                	ld	s7,88(sp)
    4d16:	610d                	add	sp,sp,160
    4d18:	8082                	ret

0000000000004d1a <bigfile>:
{
    4d1a:	7139                	add	sp,sp,-64
    4d1c:	fc06                	sd	ra,56(sp)
    4d1e:	f822                	sd	s0,48(sp)
    4d20:	f426                	sd	s1,40(sp)
    4d22:	f04a                	sd	s2,32(sp)
    4d24:	ec4e                	sd	s3,24(sp)
    4d26:	e852                	sd	s4,16(sp)
    4d28:	e456                	sd	s5,8(sp)
    4d2a:	0080                	add	s0,sp,64
    4d2c:	8aaa                	mv	s5,a0
  unlink("bigfile.dat");
    4d2e:	00003517          	auipc	a0,0x3
    4d32:	dc250513          	add	a0,a0,-574 # 7af0 <malloc+0x1e96>
    4d36:	00001097          	auipc	ra,0x1
    4d3a:	b4c080e7          	jalr	-1204(ra) # 5882 <unlink>
  fd = open("bigfile.dat", O_CREATE | O_RDWR);
    4d3e:	20200593          	li	a1,514
    4d42:	00003517          	auipc	a0,0x3
    4d46:	dae50513          	add	a0,a0,-594 # 7af0 <malloc+0x1e96>
    4d4a:	00001097          	auipc	ra,0x1
    4d4e:	b28080e7          	jalr	-1240(ra) # 5872 <open>
    4d52:	89aa                	mv	s3,a0
  for(i = 0; i < N; i++){
    4d54:	4481                	li	s1,0
    memset(buf, i, SZ);
    4d56:	00007917          	auipc	s2,0x7
    4d5a:	06290913          	add	s2,s2,98 # bdb8 <buf>
  for(i = 0; i < N; i++){
    4d5e:	4a51                	li	s4,20
  if(fd < 0){
    4d60:	0a054063          	bltz	a0,4e00 <bigfile+0xe6>
    memset(buf, i, SZ);
    4d64:	25800613          	li	a2,600
    4d68:	85a6                	mv	a1,s1
    4d6a:	854a                	mv	a0,s2
    4d6c:	00001097          	auipc	ra,0x1
    4d70:	8cc080e7          	jalr	-1844(ra) # 5638 <memset>
    if(write(fd, buf, SZ) != SZ){
    4d74:	25800613          	li	a2,600
    4d78:	85ca                	mv	a1,s2
    4d7a:	854e                	mv	a0,s3
    4d7c:	00001097          	auipc	ra,0x1
    4d80:	ad6080e7          	jalr	-1322(ra) # 5852 <write>
    4d84:	25800793          	li	a5,600
    4d88:	08f51a63          	bne	a0,a5,4e1c <bigfile+0x102>
  for(i = 0; i < N; i++){
    4d8c:	2485                	addw	s1,s1,1
    4d8e:	fd449be3          	bne	s1,s4,4d64 <bigfile+0x4a>
  close(fd);
    4d92:	854e                	mv	a0,s3
    4d94:	00001097          	auipc	ra,0x1
    4d98:	ac6080e7          	jalr	-1338(ra) # 585a <close>
  fd = open("bigfile.dat", 0);
    4d9c:	4581                	li	a1,0
    4d9e:	00003517          	auipc	a0,0x3
    4da2:	d5250513          	add	a0,a0,-686 # 7af0 <malloc+0x1e96>
    4da6:	00001097          	auipc	ra,0x1
    4daa:	acc080e7          	jalr	-1332(ra) # 5872 <open>
    4dae:	8a2a                	mv	s4,a0
  total = 0;
    4db0:	4981                	li	s3,0
  for(i = 0; ; i++){
    4db2:	4481                	li	s1,0
    cc = read(fd, buf, SZ/2);
    4db4:	00007917          	auipc	s2,0x7
    4db8:	00490913          	add	s2,s2,4 # bdb8 <buf>
  if(fd < 0){
    4dbc:	06054e63          	bltz	a0,4e38 <bigfile+0x11e>
    cc = read(fd, buf, SZ/2);
    4dc0:	12c00613          	li	a2,300
    4dc4:	85ca                	mv	a1,s2
    4dc6:	8552                	mv	a0,s4
    4dc8:	00001097          	auipc	ra,0x1
    4dcc:	a82080e7          	jalr	-1406(ra) # 584a <read>
    if(cc < 0){
    4dd0:	08054263          	bltz	a0,4e54 <bigfile+0x13a>
    if(cc == 0)
    4dd4:	c971                	beqz	a0,4ea8 <bigfile+0x18e>
    if(cc != SZ/2){
    4dd6:	12c00793          	li	a5,300
    4dda:	08f51b63          	bne	a0,a5,4e70 <bigfile+0x156>
    if(buf[0] != i/2 || buf[SZ/2-1] != i/2){
    4dde:	01f4d79b          	srlw	a5,s1,0x1f
    4de2:	9fa5                	addw	a5,a5,s1
    4de4:	4017d79b          	sraw	a5,a5,0x1
    4de8:	00094703          	lbu	a4,0(s2)
    4dec:	0af71063          	bne	a4,a5,4e8c <bigfile+0x172>
    4df0:	12b94703          	lbu	a4,299(s2)
    4df4:	08f71c63          	bne	a4,a5,4e8c <bigfile+0x172>
    total += cc;
    4df8:	12c9899b          	addw	s3,s3,300
  for(i = 0; ; i++){
    4dfc:	2485                	addw	s1,s1,1
    cc = read(fd, buf, SZ/2);
    4dfe:	b7c9                	j	4dc0 <bigfile+0xa6>
    printf("%s: cannot create bigfile", s);
    4e00:	85d6                	mv	a1,s5
    4e02:	00003517          	auipc	a0,0x3
    4e06:	cfe50513          	add	a0,a0,-770 # 7b00 <malloc+0x1ea6>
    4e0a:	00001097          	auipc	ra,0x1
    4e0e:	d98080e7          	jalr	-616(ra) # 5ba2 <printf>
    exit(1);
    4e12:	4505                	li	a0,1
    4e14:	00001097          	auipc	ra,0x1
    4e18:	a1e080e7          	jalr	-1506(ra) # 5832 <exit>
      printf("%s: write bigfile failed\n", s);
    4e1c:	85d6                	mv	a1,s5
    4e1e:	00003517          	auipc	a0,0x3
    4e22:	d0250513          	add	a0,a0,-766 # 7b20 <malloc+0x1ec6>
    4e26:	00001097          	auipc	ra,0x1
    4e2a:	d7c080e7          	jalr	-644(ra) # 5ba2 <printf>
      exit(1);
    4e2e:	4505                	li	a0,1
    4e30:	00001097          	auipc	ra,0x1
    4e34:	a02080e7          	jalr	-1534(ra) # 5832 <exit>
    printf("%s: cannot open bigfile\n", s);
    4e38:	85d6                	mv	a1,s5
    4e3a:	00003517          	auipc	a0,0x3
    4e3e:	d0650513          	add	a0,a0,-762 # 7b40 <malloc+0x1ee6>
    4e42:	00001097          	auipc	ra,0x1
    4e46:	d60080e7          	jalr	-672(ra) # 5ba2 <printf>
    exit(1);
    4e4a:	4505                	li	a0,1
    4e4c:	00001097          	auipc	ra,0x1
    4e50:	9e6080e7          	jalr	-1562(ra) # 5832 <exit>
      printf("%s: read bigfile failed\n", s);
    4e54:	85d6                	mv	a1,s5
    4e56:	00003517          	auipc	a0,0x3
    4e5a:	d0a50513          	add	a0,a0,-758 # 7b60 <malloc+0x1f06>
    4e5e:	00001097          	auipc	ra,0x1
    4e62:	d44080e7          	jalr	-700(ra) # 5ba2 <printf>
      exit(1);
    4e66:	4505                	li	a0,1
    4e68:	00001097          	auipc	ra,0x1
    4e6c:	9ca080e7          	jalr	-1590(ra) # 5832 <exit>
      printf("%s: short read bigfile\n", s);
    4e70:	85d6                	mv	a1,s5
    4e72:	00003517          	auipc	a0,0x3
    4e76:	d0e50513          	add	a0,a0,-754 # 7b80 <malloc+0x1f26>
    4e7a:	00001097          	auipc	ra,0x1
    4e7e:	d28080e7          	jalr	-728(ra) # 5ba2 <printf>
      exit(1);
    4e82:	4505                	li	a0,1
    4e84:	00001097          	auipc	ra,0x1
    4e88:	9ae080e7          	jalr	-1618(ra) # 5832 <exit>
      printf("%s: read bigfile wrong data\n", s);
    4e8c:	85d6                	mv	a1,s5
    4e8e:	00003517          	auipc	a0,0x3
    4e92:	d0a50513          	add	a0,a0,-758 # 7b98 <malloc+0x1f3e>
    4e96:	00001097          	auipc	ra,0x1
    4e9a:	d0c080e7          	jalr	-756(ra) # 5ba2 <printf>
      exit(1);
    4e9e:	4505                	li	a0,1
    4ea0:	00001097          	auipc	ra,0x1
    4ea4:	992080e7          	jalr	-1646(ra) # 5832 <exit>
  close(fd);
    4ea8:	8552                	mv	a0,s4
    4eaa:	00001097          	auipc	ra,0x1
    4eae:	9b0080e7          	jalr	-1616(ra) # 585a <close>
  if(total != N*SZ){
    4eb2:	678d                	lui	a5,0x3
    4eb4:	ee078793          	add	a5,a5,-288 # 2ee0 <fourteen+0x110>
    4eb8:	02f99363          	bne	s3,a5,4ede <bigfile+0x1c4>
  unlink("bigfile.dat");
    4ebc:	00003517          	auipc	a0,0x3
    4ec0:	c3450513          	add	a0,a0,-972 # 7af0 <malloc+0x1e96>
    4ec4:	00001097          	auipc	ra,0x1
    4ec8:	9be080e7          	jalr	-1602(ra) # 5882 <unlink>
}
    4ecc:	70e2                	ld	ra,56(sp)
    4ece:	7442                	ld	s0,48(sp)
    4ed0:	74a2                	ld	s1,40(sp)
    4ed2:	7902                	ld	s2,32(sp)
    4ed4:	69e2                	ld	s3,24(sp)
    4ed6:	6a42                	ld	s4,16(sp)
    4ed8:	6aa2                	ld	s5,8(sp)
    4eda:	6121                	add	sp,sp,64
    4edc:	8082                	ret
    printf("%s: read bigfile wrong total\n", s);
    4ede:	85d6                	mv	a1,s5
    4ee0:	00003517          	auipc	a0,0x3
    4ee4:	cd850513          	add	a0,a0,-808 # 7bb8 <malloc+0x1f5e>
    4ee8:	00001097          	auipc	ra,0x1
    4eec:	cba080e7          	jalr	-838(ra) # 5ba2 <printf>
    exit(1);
    4ef0:	4505                	li	a0,1
    4ef2:	00001097          	auipc	ra,0x1
    4ef6:	940080e7          	jalr	-1728(ra) # 5832 <exit>

0000000000004efa <fsfull>:
{
    4efa:	7135                	add	sp,sp,-160
    4efc:	ed06                	sd	ra,152(sp)
    4efe:	e922                	sd	s0,144(sp)
    4f00:	e526                	sd	s1,136(sp)
    4f02:	e14a                	sd	s2,128(sp)
    4f04:	fcce                	sd	s3,120(sp)
    4f06:	f8d2                	sd	s4,112(sp)
    4f08:	f4d6                	sd	s5,104(sp)
    4f0a:	f0da                	sd	s6,96(sp)
    4f0c:	ecde                	sd	s7,88(sp)
    4f0e:	e8e2                	sd	s8,80(sp)
    4f10:	e4e6                	sd	s9,72(sp)
    4f12:	e0ea                	sd	s10,64(sp)
    4f14:	1100                	add	s0,sp,160
  printf("fsfull test\n");
    4f16:	00003517          	auipc	a0,0x3
    4f1a:	cc250513          	add	a0,a0,-830 # 7bd8 <malloc+0x1f7e>
    4f1e:	00001097          	auipc	ra,0x1
    4f22:	c84080e7          	jalr	-892(ra) # 5ba2 <printf>
  for(nfiles = 0; ; nfiles++){
    4f26:	4481                	li	s1,0
    name[0] = 'f';
    4f28:	06600d13          	li	s10,102
    name[1] = '0' + nfiles / 1000;
    4f2c:	3e800c13          	li	s8,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    4f30:	06400b93          	li	s7,100
    name[3] = '0' + (nfiles % 100) / 10;
    4f34:	4b29                	li	s6,10
    printf("writing %s\n", name);
    4f36:	00003c97          	auipc	s9,0x3
    4f3a:	cb2c8c93          	add	s9,s9,-846 # 7be8 <malloc+0x1f8e>
    name[0] = 'f';
    4f3e:	f7a40023          	sb	s10,-160(s0)
    name[1] = '0' + nfiles / 1000;
    4f42:	0384c7bb          	divw	a5,s1,s8
    4f46:	0307879b          	addw	a5,a5,48
    4f4a:	f6f400a3          	sb	a5,-159(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    4f4e:	0384e7bb          	remw	a5,s1,s8
    4f52:	0377c7bb          	divw	a5,a5,s7
    4f56:	0307879b          	addw	a5,a5,48
    4f5a:	f6f40123          	sb	a5,-158(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    4f5e:	0374e7bb          	remw	a5,s1,s7
    4f62:	0367c7bb          	divw	a5,a5,s6
    4f66:	0307879b          	addw	a5,a5,48
    4f6a:	f6f401a3          	sb	a5,-157(s0)
    name[4] = '0' + (nfiles % 10);
    4f6e:	0364e7bb          	remw	a5,s1,s6
    4f72:	0307879b          	addw	a5,a5,48
    4f76:	f6f40223          	sb	a5,-156(s0)
    name[5] = '\0';
    4f7a:	f60402a3          	sb	zero,-155(s0)
    printf("writing %s\n", name);
    4f7e:	f6040593          	add	a1,s0,-160
    4f82:	8566                	mv	a0,s9
    4f84:	00001097          	auipc	ra,0x1
    4f88:	c1e080e7          	jalr	-994(ra) # 5ba2 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    4f8c:	20200593          	li	a1,514
    4f90:	f6040513          	add	a0,s0,-160
    4f94:	00001097          	auipc	ra,0x1
    4f98:	8de080e7          	jalr	-1826(ra) # 5872 <open>
    4f9c:	892a                	mv	s2,a0
    if(fd < 0){
    4f9e:	0a055563          	bgez	a0,5048 <fsfull+0x14e>
      printf("open %s failed\n", name);
    4fa2:	f6040593          	add	a1,s0,-160
    4fa6:	00003517          	auipc	a0,0x3
    4faa:	c5250513          	add	a0,a0,-942 # 7bf8 <malloc+0x1f9e>
    4fae:	00001097          	auipc	ra,0x1
    4fb2:	bf4080e7          	jalr	-1036(ra) # 5ba2 <printf>
  while(nfiles >= 0){
    4fb6:	0604c363          	bltz	s1,501c <fsfull+0x122>
    name[0] = 'f';
    4fba:	06600b13          	li	s6,102
    name[1] = '0' + nfiles / 1000;
    4fbe:	3e800a13          	li	s4,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    4fc2:	06400993          	li	s3,100
    name[3] = '0' + (nfiles % 100) / 10;
    4fc6:	4929                	li	s2,10
  while(nfiles >= 0){
    4fc8:	5afd                	li	s5,-1
    name[0] = 'f';
    4fca:	f7640023          	sb	s6,-160(s0)
    name[1] = '0' + nfiles / 1000;
    4fce:	0344c7bb          	divw	a5,s1,s4
    4fd2:	0307879b          	addw	a5,a5,48
    4fd6:	f6f400a3          	sb	a5,-159(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    4fda:	0344e7bb          	remw	a5,s1,s4
    4fde:	0337c7bb          	divw	a5,a5,s3
    4fe2:	0307879b          	addw	a5,a5,48
    4fe6:	f6f40123          	sb	a5,-158(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    4fea:	0334e7bb          	remw	a5,s1,s3
    4fee:	0327c7bb          	divw	a5,a5,s2
    4ff2:	0307879b          	addw	a5,a5,48
    4ff6:	f6f401a3          	sb	a5,-157(s0)
    name[4] = '0' + (nfiles % 10);
    4ffa:	0324e7bb          	remw	a5,s1,s2
    4ffe:	0307879b          	addw	a5,a5,48
    5002:	f6f40223          	sb	a5,-156(s0)
    name[5] = '\0';
    5006:	f60402a3          	sb	zero,-155(s0)
    unlink(name);
    500a:	f6040513          	add	a0,s0,-160
    500e:	00001097          	auipc	ra,0x1
    5012:	874080e7          	jalr	-1932(ra) # 5882 <unlink>
    nfiles--;
    5016:	34fd                	addw	s1,s1,-1
  while(nfiles >= 0){
    5018:	fb5499e3          	bne	s1,s5,4fca <fsfull+0xd0>
  printf("fsfull test finished\n");
    501c:	00003517          	auipc	a0,0x3
    5020:	bfc50513          	add	a0,a0,-1028 # 7c18 <malloc+0x1fbe>
    5024:	00001097          	auipc	ra,0x1
    5028:	b7e080e7          	jalr	-1154(ra) # 5ba2 <printf>
}
    502c:	60ea                	ld	ra,152(sp)
    502e:	644a                	ld	s0,144(sp)
    5030:	64aa                	ld	s1,136(sp)
    5032:	690a                	ld	s2,128(sp)
    5034:	79e6                	ld	s3,120(sp)
    5036:	7a46                	ld	s4,112(sp)
    5038:	7aa6                	ld	s5,104(sp)
    503a:	7b06                	ld	s6,96(sp)
    503c:	6be6                	ld	s7,88(sp)
    503e:	6c46                	ld	s8,80(sp)
    5040:	6ca6                	ld	s9,72(sp)
    5042:	6d06                	ld	s10,64(sp)
    5044:	610d                	add	sp,sp,160
    5046:	8082                	ret
    int total = 0;
    5048:	4981                	li	s3,0
      int cc = write(fd, buf, BSIZE);
    504a:	00007a97          	auipc	s5,0x7
    504e:	d6ea8a93          	add	s5,s5,-658 # bdb8 <buf>
      if(cc < BSIZE)
    5052:	3ff00a13          	li	s4,1023
      int cc = write(fd, buf, BSIZE);
    5056:	40000613          	li	a2,1024
    505a:	85d6                	mv	a1,s5
    505c:	854a                	mv	a0,s2
    505e:	00000097          	auipc	ra,0x0
    5062:	7f4080e7          	jalr	2036(ra) # 5852 <write>
      if(cc < BSIZE)
    5066:	00aa5563          	bge	s4,a0,5070 <fsfull+0x176>
      total += cc;
    506a:	00a989bb          	addw	s3,s3,a0
    while(1){
    506e:	b7e5                	j	5056 <fsfull+0x15c>
    printf("wrote %d bytes\n", total);
    5070:	85ce                	mv	a1,s3
    5072:	00003517          	auipc	a0,0x3
    5076:	b9650513          	add	a0,a0,-1130 # 7c08 <malloc+0x1fae>
    507a:	00001097          	auipc	ra,0x1
    507e:	b28080e7          	jalr	-1240(ra) # 5ba2 <printf>
    close(fd);
    5082:	854a                	mv	a0,s2
    5084:	00000097          	auipc	ra,0x0
    5088:	7d6080e7          	jalr	2006(ra) # 585a <close>
    if(total == 0)
    508c:	f20985e3          	beqz	s3,4fb6 <fsfull+0xbc>
  for(nfiles = 0; ; nfiles++){
    5090:	2485                	addw	s1,s1,1
    5092:	b575                	j	4f3e <fsfull+0x44>

0000000000005094 <badwrite>:
{
    5094:	7179                	add	sp,sp,-48
    5096:	f406                	sd	ra,40(sp)
    5098:	f022                	sd	s0,32(sp)
    509a:	ec26                	sd	s1,24(sp)
    509c:	e84a                	sd	s2,16(sp)
    509e:	e44e                	sd	s3,8(sp)
    50a0:	e052                	sd	s4,0(sp)
    50a2:	1800                	add	s0,sp,48
  unlink("junk");
    50a4:	00003517          	auipc	a0,0x3
    50a8:	b8c50513          	add	a0,a0,-1140 # 7c30 <malloc+0x1fd6>
    50ac:	00000097          	auipc	ra,0x0
    50b0:	7d6080e7          	jalr	2006(ra) # 5882 <unlink>
    50b4:	25800913          	li	s2,600
    int fd = open("junk", O_CREATE|O_WRONLY);
    50b8:	00003997          	auipc	s3,0x3
    50bc:	b7898993          	add	s3,s3,-1160 # 7c30 <malloc+0x1fd6>
    write(fd, (char*)0xffffffffffL, 1);
    50c0:	5a7d                	li	s4,-1
    50c2:	018a5a13          	srl	s4,s4,0x18
    int fd = open("junk", O_CREATE|O_WRONLY);
    50c6:	20100593          	li	a1,513
    50ca:	854e                	mv	a0,s3
    50cc:	00000097          	auipc	ra,0x0
    50d0:	7a6080e7          	jalr	1958(ra) # 5872 <open>
    50d4:	84aa                	mv	s1,a0
    if(fd < 0){
    50d6:	06054b63          	bltz	a0,514c <badwrite+0xb8>
    write(fd, (char*)0xffffffffffL, 1);
    50da:	4605                	li	a2,1
    50dc:	85d2                	mv	a1,s4
    50de:	00000097          	auipc	ra,0x0
    50e2:	774080e7          	jalr	1908(ra) # 5852 <write>
    close(fd);
    50e6:	8526                	mv	a0,s1
    50e8:	00000097          	auipc	ra,0x0
    50ec:	772080e7          	jalr	1906(ra) # 585a <close>
    unlink("junk");
    50f0:	854e                	mv	a0,s3
    50f2:	00000097          	auipc	ra,0x0
    50f6:	790080e7          	jalr	1936(ra) # 5882 <unlink>
  for(int i = 0; i < assumed_free; i++){
    50fa:	397d                	addw	s2,s2,-1
    50fc:	fc0915e3          	bnez	s2,50c6 <badwrite+0x32>
  int fd = open("junk", O_CREATE|O_WRONLY);
    5100:	20100593          	li	a1,513
    5104:	00003517          	auipc	a0,0x3
    5108:	b2c50513          	add	a0,a0,-1236 # 7c30 <malloc+0x1fd6>
    510c:	00000097          	auipc	ra,0x0
    5110:	766080e7          	jalr	1894(ra) # 5872 <open>
    5114:	84aa                	mv	s1,a0
  if(fd < 0){
    5116:	04054863          	bltz	a0,5166 <badwrite+0xd2>
  if(write(fd, "x", 1) != 1){
    511a:	4605                	li	a2,1
    511c:	00001597          	auipc	a1,0x1
    5120:	ccc58593          	add	a1,a1,-820 # 5de8 <malloc+0x18e>
    5124:	00000097          	auipc	ra,0x0
    5128:	72e080e7          	jalr	1838(ra) # 5852 <write>
    512c:	4785                	li	a5,1
    512e:	04f50963          	beq	a0,a5,5180 <badwrite+0xec>
    printf("write failed\n");
    5132:	00003517          	auipc	a0,0x3
    5136:	b1e50513          	add	a0,a0,-1250 # 7c50 <malloc+0x1ff6>
    513a:	00001097          	auipc	ra,0x1
    513e:	a68080e7          	jalr	-1432(ra) # 5ba2 <printf>
    exit(1);
    5142:	4505                	li	a0,1
    5144:	00000097          	auipc	ra,0x0
    5148:	6ee080e7          	jalr	1774(ra) # 5832 <exit>
      printf("open junk failed\n");
    514c:	00003517          	auipc	a0,0x3
    5150:	aec50513          	add	a0,a0,-1300 # 7c38 <malloc+0x1fde>
    5154:	00001097          	auipc	ra,0x1
    5158:	a4e080e7          	jalr	-1458(ra) # 5ba2 <printf>
      exit(1);
    515c:	4505                	li	a0,1
    515e:	00000097          	auipc	ra,0x0
    5162:	6d4080e7          	jalr	1748(ra) # 5832 <exit>
    printf("open junk failed\n");
    5166:	00003517          	auipc	a0,0x3
    516a:	ad250513          	add	a0,a0,-1326 # 7c38 <malloc+0x1fde>
    516e:	00001097          	auipc	ra,0x1
    5172:	a34080e7          	jalr	-1484(ra) # 5ba2 <printf>
    exit(1);
    5176:	4505                	li	a0,1
    5178:	00000097          	auipc	ra,0x0
    517c:	6ba080e7          	jalr	1722(ra) # 5832 <exit>
  close(fd);
    5180:	8526                	mv	a0,s1
    5182:	00000097          	auipc	ra,0x0
    5186:	6d8080e7          	jalr	1752(ra) # 585a <close>
  unlink("junk");
    518a:	00003517          	auipc	a0,0x3
    518e:	aa650513          	add	a0,a0,-1370 # 7c30 <malloc+0x1fd6>
    5192:	00000097          	auipc	ra,0x0
    5196:	6f0080e7          	jalr	1776(ra) # 5882 <unlink>
  exit(0);
    519a:	4501                	li	a0,0
    519c:	00000097          	auipc	ra,0x0
    51a0:	696080e7          	jalr	1686(ra) # 5832 <exit>

00000000000051a4 <countfree>:
// because out of memory with lazy allocation results in the process
// taking a fault and being killed, fork and report back.
//
int
countfree()
{
    51a4:	7139                	add	sp,sp,-64
    51a6:	fc06                	sd	ra,56(sp)
    51a8:	f822                	sd	s0,48(sp)
    51aa:	f426                	sd	s1,40(sp)
    51ac:	f04a                	sd	s2,32(sp)
    51ae:	ec4e                	sd	s3,24(sp)
    51b0:	0080                	add	s0,sp,64
  int fds[2];

  if(pipe(fds) < 0){
    51b2:	fc840513          	add	a0,s0,-56
    51b6:	00000097          	auipc	ra,0x0
    51ba:	68c080e7          	jalr	1676(ra) # 5842 <pipe>
    51be:	06054763          	bltz	a0,522c <countfree+0x88>
    printf("pipe() failed in countfree()\n");
    exit(1);
  }
  
  int pid = fork();
    51c2:	00000097          	auipc	ra,0x0
    51c6:	668080e7          	jalr	1640(ra) # 582a <fork>

  if(pid < 0){
    51ca:	06054e63          	bltz	a0,5246 <countfree+0xa2>
    printf("fork failed in countfree()\n");
    exit(1);
  }

  if(pid == 0){
    51ce:	ed51                	bnez	a0,526a <countfree+0xc6>
    close(fds[0]);
    51d0:	fc842503          	lw	a0,-56(s0)
    51d4:	00000097          	auipc	ra,0x0
    51d8:	686080e7          	jalr	1670(ra) # 585a <close>
    
    while(1){
      uint64 a = (uint64) sbrk(4096);
      if(a == 0xffffffffffffffff){
    51dc:	597d                	li	s2,-1
        break;
      }

      // modify the memory to make sure it's really allocated.
      *(char *)(a + 4096 - 1) = 1;
    51de:	4485                	li	s1,1

      // report back one more page.
      if(write(fds[1], "x", 1) != 1){
    51e0:	00001997          	auipc	s3,0x1
    51e4:	c0898993          	add	s3,s3,-1016 # 5de8 <malloc+0x18e>
      uint64 a = (uint64) sbrk(4096);
    51e8:	6505                	lui	a0,0x1
    51ea:	00000097          	auipc	ra,0x0
    51ee:	6d0080e7          	jalr	1744(ra) # 58ba <sbrk>
      if(a == 0xffffffffffffffff){
    51f2:	07250763          	beq	a0,s2,5260 <countfree+0xbc>
      *(char *)(a + 4096 - 1) = 1;
    51f6:	6785                	lui	a5,0x1
    51f8:	97aa                	add	a5,a5,a0
    51fa:	fe978fa3          	sb	s1,-1(a5) # fff <bigdir+0x9f>
      if(write(fds[1], "x", 1) != 1){
    51fe:	8626                	mv	a2,s1
    5200:	85ce                	mv	a1,s3
    5202:	fcc42503          	lw	a0,-52(s0)
    5206:	00000097          	auipc	ra,0x0
    520a:	64c080e7          	jalr	1612(ra) # 5852 <write>
    520e:	fc950de3          	beq	a0,s1,51e8 <countfree+0x44>
        printf("write() failed in countfree()\n");
    5212:	00003517          	auipc	a0,0x3
    5216:	a8e50513          	add	a0,a0,-1394 # 7ca0 <malloc+0x2046>
    521a:	00001097          	auipc	ra,0x1
    521e:	988080e7          	jalr	-1656(ra) # 5ba2 <printf>
        exit(1);
    5222:	4505                	li	a0,1
    5224:	00000097          	auipc	ra,0x0
    5228:	60e080e7          	jalr	1550(ra) # 5832 <exit>
    printf("pipe() failed in countfree()\n");
    522c:	00003517          	auipc	a0,0x3
    5230:	a3450513          	add	a0,a0,-1484 # 7c60 <malloc+0x2006>
    5234:	00001097          	auipc	ra,0x1
    5238:	96e080e7          	jalr	-1682(ra) # 5ba2 <printf>
    exit(1);
    523c:	4505                	li	a0,1
    523e:	00000097          	auipc	ra,0x0
    5242:	5f4080e7          	jalr	1524(ra) # 5832 <exit>
    printf("fork failed in countfree()\n");
    5246:	00003517          	auipc	a0,0x3
    524a:	a3a50513          	add	a0,a0,-1478 # 7c80 <malloc+0x2026>
    524e:	00001097          	auipc	ra,0x1
    5252:	954080e7          	jalr	-1708(ra) # 5ba2 <printf>
    exit(1);
    5256:	4505                	li	a0,1
    5258:	00000097          	auipc	ra,0x0
    525c:	5da080e7          	jalr	1498(ra) # 5832 <exit>
      }
    }

    exit(0);
    5260:	4501                	li	a0,0
    5262:	00000097          	auipc	ra,0x0
    5266:	5d0080e7          	jalr	1488(ra) # 5832 <exit>
  }

  close(fds[1]);
    526a:	fcc42503          	lw	a0,-52(s0)
    526e:	00000097          	auipc	ra,0x0
    5272:	5ec080e7          	jalr	1516(ra) # 585a <close>

  int n = 0;
    5276:	4481                	li	s1,0
  while(1){
    char c;
    int cc = read(fds[0], &c, 1);
    5278:	4605                	li	a2,1
    527a:	fc740593          	add	a1,s0,-57
    527e:	fc842503          	lw	a0,-56(s0)
    5282:	00000097          	auipc	ra,0x0
    5286:	5c8080e7          	jalr	1480(ra) # 584a <read>
    if(cc < 0){
    528a:	00054563          	bltz	a0,5294 <countfree+0xf0>
      printf("read() failed in countfree()\n");
      exit(1);
    }
    if(cc == 0)
    528e:	c105                	beqz	a0,52ae <countfree+0x10a>
      break;
    n += 1;
    5290:	2485                	addw	s1,s1,1
  while(1){
    5292:	b7dd                	j	5278 <countfree+0xd4>
      printf("read() failed in countfree()\n");
    5294:	00003517          	auipc	a0,0x3
    5298:	a2c50513          	add	a0,a0,-1492 # 7cc0 <malloc+0x2066>
    529c:	00001097          	auipc	ra,0x1
    52a0:	906080e7          	jalr	-1786(ra) # 5ba2 <printf>
      exit(1);
    52a4:	4505                	li	a0,1
    52a6:	00000097          	auipc	ra,0x0
    52aa:	58c080e7          	jalr	1420(ra) # 5832 <exit>
  }

  close(fds[0]);
    52ae:	fc842503          	lw	a0,-56(s0)
    52b2:	00000097          	auipc	ra,0x0
    52b6:	5a8080e7          	jalr	1448(ra) # 585a <close>
  wait((int*)0);
    52ba:	4501                	li	a0,0
    52bc:	00000097          	auipc	ra,0x0
    52c0:	57e080e7          	jalr	1406(ra) # 583a <wait>
  
  return n;
}
    52c4:	8526                	mv	a0,s1
    52c6:	70e2                	ld	ra,56(sp)
    52c8:	7442                	ld	s0,48(sp)
    52ca:	74a2                	ld	s1,40(sp)
    52cc:	7902                	ld	s2,32(sp)
    52ce:	69e2                	ld	s3,24(sp)
    52d0:	6121                	add	sp,sp,64
    52d2:	8082                	ret

00000000000052d4 <run>:

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s) {
    52d4:	7179                	add	sp,sp,-48
    52d6:	f406                	sd	ra,40(sp)
    52d8:	f022                	sd	s0,32(sp)
    52da:	ec26                	sd	s1,24(sp)
    52dc:	e84a                	sd	s2,16(sp)
    52de:	1800                	add	s0,sp,48
    52e0:	84aa                	mv	s1,a0
    52e2:	892e                	mv	s2,a1
  int pid;
  int xstatus;

  printf("test %s: ", s);
    52e4:	00003517          	auipc	a0,0x3
    52e8:	9fc50513          	add	a0,a0,-1540 # 7ce0 <malloc+0x2086>
    52ec:	00001097          	auipc	ra,0x1
    52f0:	8b6080e7          	jalr	-1866(ra) # 5ba2 <printf>
  if((pid = fork()) < 0) {
    52f4:	00000097          	auipc	ra,0x0
    52f8:	536080e7          	jalr	1334(ra) # 582a <fork>
    52fc:	02054e63          	bltz	a0,5338 <run+0x64>
    printf("runtest: fork error\n");
    exit(1);
  }
  if(pid == 0) {
    5300:	c929                	beqz	a0,5352 <run+0x7e>
    f(s);
    exit(0);
  } else {
    wait(&xstatus);
    5302:	fdc40513          	add	a0,s0,-36
    5306:	00000097          	auipc	ra,0x0
    530a:	534080e7          	jalr	1332(ra) # 583a <wait>
    if(xstatus != 0) 
    530e:	fdc42783          	lw	a5,-36(s0)
    5312:	c7b9                	beqz	a5,5360 <run+0x8c>
      printf("FAILED\n");
    5314:	00003517          	auipc	a0,0x3
    5318:	9f450513          	add	a0,a0,-1548 # 7d08 <malloc+0x20ae>
    531c:	00001097          	auipc	ra,0x1
    5320:	886080e7          	jalr	-1914(ra) # 5ba2 <printf>
    else
      printf("OK\n");
    return xstatus == 0;
    5324:	fdc42503          	lw	a0,-36(s0)
  }
}
    5328:	00153513          	seqz	a0,a0
    532c:	70a2                	ld	ra,40(sp)
    532e:	7402                	ld	s0,32(sp)
    5330:	64e2                	ld	s1,24(sp)
    5332:	6942                	ld	s2,16(sp)
    5334:	6145                	add	sp,sp,48
    5336:	8082                	ret
    printf("runtest: fork error\n");
    5338:	00003517          	auipc	a0,0x3
    533c:	9b850513          	add	a0,a0,-1608 # 7cf0 <malloc+0x2096>
    5340:	00001097          	auipc	ra,0x1
    5344:	862080e7          	jalr	-1950(ra) # 5ba2 <printf>
    exit(1);
    5348:	4505                	li	a0,1
    534a:	00000097          	auipc	ra,0x0
    534e:	4e8080e7          	jalr	1256(ra) # 5832 <exit>
    f(s);
    5352:	854a                	mv	a0,s2
    5354:	9482                	jalr	s1
    exit(0);
    5356:	4501                	li	a0,0
    5358:	00000097          	auipc	ra,0x0
    535c:	4da080e7          	jalr	1242(ra) # 5832 <exit>
      printf("OK\n");
    5360:	00003517          	auipc	a0,0x3
    5364:	9b050513          	add	a0,a0,-1616 # 7d10 <malloc+0x20b6>
    5368:	00001097          	auipc	ra,0x1
    536c:	83a080e7          	jalr	-1990(ra) # 5ba2 <printf>
    5370:	bf55                	j	5324 <run+0x50>

0000000000005372 <main>:

int
main(int argc, char *argv[])
{
    5372:	bd010113          	add	sp,sp,-1072
    5376:	42113423          	sd	ra,1064(sp)
    537a:	42813023          	sd	s0,1056(sp)
    537e:	40913c23          	sd	s1,1048(sp)
    5382:	41213823          	sd	s2,1040(sp)
    5386:	41313423          	sd	s3,1032(sp)
    538a:	41413023          	sd	s4,1024(sp)
    538e:	3f513c23          	sd	s5,1016(sp)
    5392:	3f613823          	sd	s6,1008(sp)
    5396:	43010413          	add	s0,sp,1072
    539a:	89aa                	mv	s3,a0
  int continuous = 0;
  char *justone = 0;

  if(argc == 2 && strcmp(argv[1], "-c") == 0){
    539c:	4789                	li	a5,2
    539e:	0af50063          	beq	a0,a5,543e <main+0xcc>
    continuous = 1;
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    continuous = 2;
  } else if(argc == 2 && argv[1][0] != '-'){
    justone = argv[1];
  } else if(argc > 1){
    53a2:	4785                	li	a5,1
    53a4:	12a7cd63          	blt	a5,a0,54de <main+0x16c>
  char *justone = 0;
    53a8:	4981                	li	s3,0
  }
  
  struct test {
    void (*f)(char *);
    char *s;
  } tests[] = {
    53aa:	00003797          	auipc	a5,0x3
    53ae:	d7e78793          	add	a5,a5,-642 # 8128 <malloc+0x24ce>
    53b2:	bd040713          	add	a4,s0,-1072
    53b6:	00003317          	auipc	t1,0x3
    53ba:	16230313          	add	t1,t1,354 # 8518 <malloc+0x28be>
    53be:	0007b883          	ld	a7,0(a5)
    53c2:	0087b803          	ld	a6,8(a5)
    53c6:	6b88                	ld	a0,16(a5)
    53c8:	6f8c                	ld	a1,24(a5)
    53ca:	7390                	ld	a2,32(a5)
    53cc:	7794                	ld	a3,40(a5)
    53ce:	01173023          	sd	a7,0(a4)
    53d2:	01073423          	sd	a6,8(a4)
    53d6:	eb08                	sd	a0,16(a4)
    53d8:	ef0c                	sd	a1,24(a4)
    53da:	f310                	sd	a2,32(a4)
    53dc:	f714                	sd	a3,40(a4)
    53de:	03078793          	add	a5,a5,48
    53e2:	03070713          	add	a4,a4,48
    53e6:	fc679ce3          	bne	a5,t1,53be <main+0x4c>
          exit(1);
      }
    }
  }

  printf("usertests starting\n");
    53ea:	00003517          	auipc	a0,0x3
    53ee:	9e650513          	add	a0,a0,-1562 # 7dd0 <malloc+0x2176>
    53f2:	00000097          	auipc	ra,0x0
    53f6:	7b0080e7          	jalr	1968(ra) # 5ba2 <printf>
  int free0 = countfree();
    53fa:	00000097          	auipc	ra,0x0
    53fe:	daa080e7          	jalr	-598(ra) # 51a4 <countfree>
    5402:	8aaa                	mv	s5,a0
  int free1 = 0;
  int fail = 0;
  for (struct test *t = tests; t->s != 0; t++) {
    5404:	bd843903          	ld	s2,-1064(s0)
    5408:	bd040493          	add	s1,s0,-1072
  int fail = 0;
    540c:	4a01                	li	s4,0
    if((justone == 0) || strcmp(t->s, justone) == 0) {
      if(!run(t->f, t->s))
        fail = 1;
    540e:	4b05                	li	s6,1
  for (struct test *t = tests; t->s != 0; t++) {
    5410:	10091c63          	bnez	s2,5528 <main+0x1b6>
  }

  if(fail){
    printf("SOME TESTS FAILED\n");
    exit(1);
  } else if((free1 = countfree()) < free0){
    5414:	00000097          	auipc	ra,0x0
    5418:	d90080e7          	jalr	-624(ra) # 51a4 <countfree>
    541c:	85aa                	mv	a1,a0
    541e:	15555663          	bge	a0,s5,556a <main+0x1f8>
    printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    5422:	8656                	mv	a2,s5
    5424:	00003517          	auipc	a0,0x3
    5428:	96450513          	add	a0,a0,-1692 # 7d88 <malloc+0x212e>
    542c:	00000097          	auipc	ra,0x0
    5430:	776080e7          	jalr	1910(ra) # 5ba2 <printf>
    exit(1);
    5434:	4505                	li	a0,1
    5436:	00000097          	auipc	ra,0x0
    543a:	3fc080e7          	jalr	1020(ra) # 5832 <exit>
    543e:	84ae                	mv	s1,a1
  if(argc == 2 && strcmp(argv[1], "-c") == 0){
    5440:	00003597          	auipc	a1,0x3
    5444:	8d858593          	add	a1,a1,-1832 # 7d18 <malloc+0x20be>
    5448:	6488                	ld	a0,8(s1)
    544a:	00000097          	auipc	ra,0x0
    544e:	198080e7          	jalr	408(ra) # 55e2 <strcmp>
    5452:	e525                	bnez	a0,54ba <main+0x148>
    continuous = 1;
    5454:	4985                	li	s3,1
  } tests[] = {
    5456:	00003797          	auipc	a5,0x3
    545a:	cd278793          	add	a5,a5,-814 # 8128 <malloc+0x24ce>
    545e:	bd040713          	add	a4,s0,-1072
    5462:	00003317          	auipc	t1,0x3
    5466:	0b630313          	add	t1,t1,182 # 8518 <malloc+0x28be>
    546a:	0007b883          	ld	a7,0(a5)
    546e:	0087b803          	ld	a6,8(a5)
    5472:	6b88                	ld	a0,16(a5)
    5474:	6f8c                	ld	a1,24(a5)
    5476:	7390                	ld	a2,32(a5)
    5478:	7794                	ld	a3,40(a5)
    547a:	01173023          	sd	a7,0(a4)
    547e:	01073423          	sd	a6,8(a4)
    5482:	eb08                	sd	a0,16(a4)
    5484:	ef0c                	sd	a1,24(a4)
    5486:	f310                	sd	a2,32(a4)
    5488:	f714                	sd	a3,40(a4)
    548a:	03078793          	add	a5,a5,48
    548e:	03070713          	add	a4,a4,48
    5492:	fc679ce3          	bne	a5,t1,546a <main+0xf8>
    printf("continuous usertests starting\n");
    5496:	00003517          	auipc	a0,0x3
    549a:	95250513          	add	a0,a0,-1710 # 7de8 <malloc+0x218e>
    549e:	00000097          	auipc	ra,0x0
    54a2:	704080e7          	jalr	1796(ra) # 5ba2 <printf>
        printf("SOME TESTS FAILED\n");
    54a6:	00003a97          	auipc	s5,0x3
    54aa:	8caa8a93          	add	s5,s5,-1846 # 7d70 <malloc+0x2116>
        if(continuous != 2)
    54ae:	4a09                	li	s4,2
        printf("FAILED -- lost %d free pages\n", free0 - free1);
    54b0:	00003b17          	auipc	s6,0x3
    54b4:	8a0b0b13          	add	s6,s6,-1888 # 7d50 <malloc+0x20f6>
    54b8:	a0dd                	j	559e <main+0x22c>
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    54ba:	00003597          	auipc	a1,0x3
    54be:	86658593          	add	a1,a1,-1946 # 7d20 <malloc+0x20c6>
    54c2:	6488                	ld	a0,8(s1)
    54c4:	00000097          	auipc	ra,0x0
    54c8:	11e080e7          	jalr	286(ra) # 55e2 <strcmp>
    54cc:	d549                	beqz	a0,5456 <main+0xe4>
  } else if(argc == 2 && argv[1][0] != '-'){
    54ce:	0084b983          	ld	s3,8(s1)
    54d2:	0009c703          	lbu	a4,0(s3)
    54d6:	02d00793          	li	a5,45
    54da:	ecf718e3          	bne	a4,a5,53aa <main+0x38>
    printf("Usage: usertests [-c] [testname]\n");
    54de:	00003517          	auipc	a0,0x3
    54e2:	84a50513          	add	a0,a0,-1974 # 7d28 <malloc+0x20ce>
    54e6:	00000097          	auipc	ra,0x0
    54ea:	6bc080e7          	jalr	1724(ra) # 5ba2 <printf>
    exit(1);
    54ee:	4505                	li	a0,1
    54f0:	00000097          	auipc	ra,0x0
    54f4:	342080e7          	jalr	834(ra) # 5832 <exit>
          exit(1);
    54f8:	4505                	li	a0,1
    54fa:	00000097          	auipc	ra,0x0
    54fe:	338080e7          	jalr	824(ra) # 5832 <exit>
        printf("FAILED -- lost %d free pages\n", free0 - free1);
    5502:	40a905bb          	subw	a1,s2,a0
    5506:	855a                	mv	a0,s6
    5508:	00000097          	auipc	ra,0x0
    550c:	69a080e7          	jalr	1690(ra) # 5ba2 <printf>
        if(continuous != 2)
    5510:	09498763          	beq	s3,s4,559e <main+0x22c>
          exit(1);
    5514:	4505                	li	a0,1
    5516:	00000097          	auipc	ra,0x0
    551a:	31c080e7          	jalr	796(ra) # 5832 <exit>
  for (struct test *t = tests; t->s != 0; t++) {
    551e:	04c1                	add	s1,s1,16
    5520:	0084b903          	ld	s2,8(s1)
    5524:	02090463          	beqz	s2,554c <main+0x1da>
    if((justone == 0) || strcmp(t->s, justone) == 0) {
    5528:	00098963          	beqz	s3,553a <main+0x1c8>
    552c:	85ce                	mv	a1,s3
    552e:	854a                	mv	a0,s2
    5530:	00000097          	auipc	ra,0x0
    5534:	0b2080e7          	jalr	178(ra) # 55e2 <strcmp>
    5538:	f17d                	bnez	a0,551e <main+0x1ac>
      if(!run(t->f, t->s))
    553a:	85ca                	mv	a1,s2
    553c:	6088                	ld	a0,0(s1)
    553e:	00000097          	auipc	ra,0x0
    5542:	d96080e7          	jalr	-618(ra) # 52d4 <run>
    5546:	fd61                	bnez	a0,551e <main+0x1ac>
        fail = 1;
    5548:	8a5a                	mv	s4,s6
    554a:	bfd1                	j	551e <main+0x1ac>
  if(fail){
    554c:	ec0a04e3          	beqz	s4,5414 <main+0xa2>
    printf("SOME TESTS FAILED\n");
    5550:	00003517          	auipc	a0,0x3
    5554:	82050513          	add	a0,a0,-2016 # 7d70 <malloc+0x2116>
    5558:	00000097          	auipc	ra,0x0
    555c:	64a080e7          	jalr	1610(ra) # 5ba2 <printf>
    exit(1);
    5560:	4505                	li	a0,1
    5562:	00000097          	auipc	ra,0x0
    5566:	2d0080e7          	jalr	720(ra) # 5832 <exit>
  } else {
    printf("ALL TESTS PASSED\n");
    556a:	00003517          	auipc	a0,0x3
    556e:	84e50513          	add	a0,a0,-1970 # 7db8 <malloc+0x215e>
    5572:	00000097          	auipc	ra,0x0
    5576:	630080e7          	jalr	1584(ra) # 5ba2 <printf>
    exit(0);
    557a:	4501                	li	a0,0
    557c:	00000097          	auipc	ra,0x0
    5580:	2b6080e7          	jalr	694(ra) # 5832 <exit>
        printf("SOME TESTS FAILED\n");
    5584:	8556                	mv	a0,s5
    5586:	00000097          	auipc	ra,0x0
    558a:	61c080e7          	jalr	1564(ra) # 5ba2 <printf>
        if(continuous != 2)
    558e:	f74995e3          	bne	s3,s4,54f8 <main+0x186>
      int free1 = countfree();
    5592:	00000097          	auipc	ra,0x0
    5596:	c12080e7          	jalr	-1006(ra) # 51a4 <countfree>
      if(free1 < free0){
    559a:	f72544e3          	blt	a0,s2,5502 <main+0x190>
      int free0 = countfree();
    559e:	00000097          	auipc	ra,0x0
    55a2:	c06080e7          	jalr	-1018(ra) # 51a4 <countfree>
    55a6:	892a                	mv	s2,a0
      for (struct test *t = tests; t->s != 0; t++) {
    55a8:	bd843583          	ld	a1,-1064(s0)
    55ac:	d1fd                	beqz	a1,5592 <main+0x220>
    55ae:	bd040493          	add	s1,s0,-1072
        if(!run(t->f, t->s)){
    55b2:	6088                	ld	a0,0(s1)
    55b4:	00000097          	auipc	ra,0x0
    55b8:	d20080e7          	jalr	-736(ra) # 52d4 <run>
    55bc:	d561                	beqz	a0,5584 <main+0x212>
      for (struct test *t = tests; t->s != 0; t++) {
    55be:	04c1                	add	s1,s1,16
    55c0:	648c                	ld	a1,8(s1)
    55c2:	f9e5                	bnez	a1,55b2 <main+0x240>
    55c4:	b7f9                	j	5592 <main+0x220>

00000000000055c6 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
    55c6:	1141                	add	sp,sp,-16
    55c8:	e422                	sd	s0,8(sp)
    55ca:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    55cc:	87aa                	mv	a5,a0
    55ce:	0585                	add	a1,a1,1
    55d0:	0785                	add	a5,a5,1
    55d2:	fff5c703          	lbu	a4,-1(a1)
    55d6:	fee78fa3          	sb	a4,-1(a5)
    55da:	fb75                	bnez	a4,55ce <strcpy+0x8>
    ;
  return os;
}
    55dc:	6422                	ld	s0,8(sp)
    55de:	0141                	add	sp,sp,16
    55e0:	8082                	ret

00000000000055e2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    55e2:	1141                	add	sp,sp,-16
    55e4:	e422                	sd	s0,8(sp)
    55e6:	0800                	add	s0,sp,16
  while(*p && *p == *q)
    55e8:	00054783          	lbu	a5,0(a0)
    55ec:	cb91                	beqz	a5,5600 <strcmp+0x1e>
    55ee:	0005c703          	lbu	a4,0(a1)
    55f2:	00f71763          	bne	a4,a5,5600 <strcmp+0x1e>
    p++, q++;
    55f6:	0505                	add	a0,a0,1
    55f8:	0585                	add	a1,a1,1
  while(*p && *p == *q)
    55fa:	00054783          	lbu	a5,0(a0)
    55fe:	fbe5                	bnez	a5,55ee <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    5600:	0005c503          	lbu	a0,0(a1)
}
    5604:	40a7853b          	subw	a0,a5,a0
    5608:	6422                	ld	s0,8(sp)
    560a:	0141                	add	sp,sp,16
    560c:	8082                	ret

000000000000560e <strlen>:

uint
strlen(const char *s)
{
    560e:	1141                	add	sp,sp,-16
    5610:	e422                	sd	s0,8(sp)
    5612:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    5614:	00054783          	lbu	a5,0(a0)
    5618:	cf91                	beqz	a5,5634 <strlen+0x26>
    561a:	0505                	add	a0,a0,1
    561c:	87aa                	mv	a5,a0
    561e:	86be                	mv	a3,a5
    5620:	0785                	add	a5,a5,1
    5622:	fff7c703          	lbu	a4,-1(a5)
    5626:	ff65                	bnez	a4,561e <strlen+0x10>
    5628:	40a6853b          	subw	a0,a3,a0
    562c:	2505                	addw	a0,a0,1
    ;
  return n;
}
    562e:	6422                	ld	s0,8(sp)
    5630:	0141                	add	sp,sp,16
    5632:	8082                	ret
  for(n = 0; s[n]; n++)
    5634:	4501                	li	a0,0
    5636:	bfe5                	j	562e <strlen+0x20>

0000000000005638 <memset>:

void*
memset(void *dst, int c, uint n)
{
    5638:	1141                	add	sp,sp,-16
    563a:	e422                	sd	s0,8(sp)
    563c:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    563e:	ca19                	beqz	a2,5654 <memset+0x1c>
    5640:	87aa                	mv	a5,a0
    5642:	1602                	sll	a2,a2,0x20
    5644:	9201                	srl	a2,a2,0x20
    5646:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    564a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    564e:	0785                	add	a5,a5,1
    5650:	fee79de3          	bne	a5,a4,564a <memset+0x12>
  }
  return dst;
}
    5654:	6422                	ld	s0,8(sp)
    5656:	0141                	add	sp,sp,16
    5658:	8082                	ret

000000000000565a <strchr>:

char*
strchr(const char *s, char c)
{
    565a:	1141                	add	sp,sp,-16
    565c:	e422                	sd	s0,8(sp)
    565e:	0800                	add	s0,sp,16
  for(; *s; s++)
    5660:	00054783          	lbu	a5,0(a0)
    5664:	cb99                	beqz	a5,567a <strchr+0x20>
    if(*s == c)
    5666:	00f58763          	beq	a1,a5,5674 <strchr+0x1a>
  for(; *s; s++)
    566a:	0505                	add	a0,a0,1
    566c:	00054783          	lbu	a5,0(a0)
    5670:	fbfd                	bnez	a5,5666 <strchr+0xc>
      return (char*)s;
  return 0;
    5672:	4501                	li	a0,0
}
    5674:	6422                	ld	s0,8(sp)
    5676:	0141                	add	sp,sp,16
    5678:	8082                	ret
  return 0;
    567a:	4501                	li	a0,0
    567c:	bfe5                	j	5674 <strchr+0x1a>

000000000000567e <gets>:

char*
gets(char *buf, int max)
{
    567e:	711d                	add	sp,sp,-96
    5680:	ec86                	sd	ra,88(sp)
    5682:	e8a2                	sd	s0,80(sp)
    5684:	e4a6                	sd	s1,72(sp)
    5686:	e0ca                	sd	s2,64(sp)
    5688:	fc4e                	sd	s3,56(sp)
    568a:	f852                	sd	s4,48(sp)
    568c:	f456                	sd	s5,40(sp)
    568e:	f05a                	sd	s6,32(sp)
    5690:	ec5e                	sd	s7,24(sp)
    5692:	1080                	add	s0,sp,96
    5694:	8baa                	mv	s7,a0
    5696:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    5698:	892a                	mv	s2,a0
    569a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    569c:	4aa9                	li	s5,10
    569e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    56a0:	89a6                	mv	s3,s1
    56a2:	2485                	addw	s1,s1,1
    56a4:	0344d863          	bge	s1,s4,56d4 <gets+0x56>
    cc = read(0, &c, 1);
    56a8:	4605                	li	a2,1
    56aa:	faf40593          	add	a1,s0,-81
    56ae:	4501                	li	a0,0
    56b0:	00000097          	auipc	ra,0x0
    56b4:	19a080e7          	jalr	410(ra) # 584a <read>
    if(cc < 1)
    56b8:	00a05e63          	blez	a0,56d4 <gets+0x56>
    buf[i++] = c;
    56bc:	faf44783          	lbu	a5,-81(s0)
    56c0:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    56c4:	01578763          	beq	a5,s5,56d2 <gets+0x54>
    56c8:	0905                	add	s2,s2,1
    56ca:	fd679be3          	bne	a5,s6,56a0 <gets+0x22>
  for(i=0; i+1 < max; ){
    56ce:	89a6                	mv	s3,s1
    56d0:	a011                	j	56d4 <gets+0x56>
    56d2:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    56d4:	99de                	add	s3,s3,s7
    56d6:	00098023          	sb	zero,0(s3)
  return buf;
}
    56da:	855e                	mv	a0,s7
    56dc:	60e6                	ld	ra,88(sp)
    56de:	6446                	ld	s0,80(sp)
    56e0:	64a6                	ld	s1,72(sp)
    56e2:	6906                	ld	s2,64(sp)
    56e4:	79e2                	ld	s3,56(sp)
    56e6:	7a42                	ld	s4,48(sp)
    56e8:	7aa2                	ld	s5,40(sp)
    56ea:	7b02                	ld	s6,32(sp)
    56ec:	6be2                	ld	s7,24(sp)
    56ee:	6125                	add	sp,sp,96
    56f0:	8082                	ret

00000000000056f2 <stat>:

int
stat(const char *n, struct stat *st)
{
    56f2:	1101                	add	sp,sp,-32
    56f4:	ec06                	sd	ra,24(sp)
    56f6:	e822                	sd	s0,16(sp)
    56f8:	e426                	sd	s1,8(sp)
    56fa:	e04a                	sd	s2,0(sp)
    56fc:	1000                	add	s0,sp,32
    56fe:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    5700:	4581                	li	a1,0
    5702:	00000097          	auipc	ra,0x0
    5706:	170080e7          	jalr	368(ra) # 5872 <open>
  if(fd < 0)
    570a:	02054563          	bltz	a0,5734 <stat+0x42>
    570e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    5710:	85ca                	mv	a1,s2
    5712:	00000097          	auipc	ra,0x0
    5716:	178080e7          	jalr	376(ra) # 588a <fstat>
    571a:	892a                	mv	s2,a0
  close(fd);
    571c:	8526                	mv	a0,s1
    571e:	00000097          	auipc	ra,0x0
    5722:	13c080e7          	jalr	316(ra) # 585a <close>
  return r;
}
    5726:	854a                	mv	a0,s2
    5728:	60e2                	ld	ra,24(sp)
    572a:	6442                	ld	s0,16(sp)
    572c:	64a2                	ld	s1,8(sp)
    572e:	6902                	ld	s2,0(sp)
    5730:	6105                	add	sp,sp,32
    5732:	8082                	ret
    return -1;
    5734:	597d                	li	s2,-1
    5736:	bfc5                	j	5726 <stat+0x34>

0000000000005738 <atoi>:

int
atoi(const char *s)
{
    5738:	1141                	add	sp,sp,-16
    573a:	e422                	sd	s0,8(sp)
    573c:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    573e:	00054683          	lbu	a3,0(a0)
    5742:	fd06879b          	addw	a5,a3,-48
    5746:	0ff7f793          	zext.b	a5,a5
    574a:	4625                	li	a2,9
    574c:	02f66863          	bltu	a2,a5,577c <atoi+0x44>
    5750:	872a                	mv	a4,a0
  n = 0;
    5752:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
    5754:	0705                	add	a4,a4,1
    5756:	0025179b          	sllw	a5,a0,0x2
    575a:	9fa9                	addw	a5,a5,a0
    575c:	0017979b          	sllw	a5,a5,0x1
    5760:	9fb5                	addw	a5,a5,a3
    5762:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    5766:	00074683          	lbu	a3,0(a4)
    576a:	fd06879b          	addw	a5,a3,-48
    576e:	0ff7f793          	zext.b	a5,a5
    5772:	fef671e3          	bgeu	a2,a5,5754 <atoi+0x1c>
  return n;
}
    5776:	6422                	ld	s0,8(sp)
    5778:	0141                	add	sp,sp,16
    577a:	8082                	ret
  n = 0;
    577c:	4501                	li	a0,0
    577e:	bfe5                	j	5776 <atoi+0x3e>

0000000000005780 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    5780:	1141                	add	sp,sp,-16
    5782:	e422                	sd	s0,8(sp)
    5784:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    5786:	02b57463          	bgeu	a0,a1,57ae <memmove+0x2e>
    while(n-- > 0)
    578a:	00c05f63          	blez	a2,57a8 <memmove+0x28>
    578e:	1602                	sll	a2,a2,0x20
    5790:	9201                	srl	a2,a2,0x20
    5792:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    5796:	872a                	mv	a4,a0
      *dst++ = *src++;
    5798:	0585                	add	a1,a1,1
    579a:	0705                	add	a4,a4,1
    579c:	fff5c683          	lbu	a3,-1(a1)
    57a0:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    57a4:	fee79ae3          	bne	a5,a4,5798 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    57a8:	6422                	ld	s0,8(sp)
    57aa:	0141                	add	sp,sp,16
    57ac:	8082                	ret
    dst += n;
    57ae:	00c50733          	add	a4,a0,a2
    src += n;
    57b2:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    57b4:	fec05ae3          	blez	a2,57a8 <memmove+0x28>
    57b8:	fff6079b          	addw	a5,a2,-1 # 2fff <iputtest+0x8b>
    57bc:	1782                	sll	a5,a5,0x20
    57be:	9381                	srl	a5,a5,0x20
    57c0:	fff7c793          	not	a5,a5
    57c4:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    57c6:	15fd                	add	a1,a1,-1
    57c8:	177d                	add	a4,a4,-1
    57ca:	0005c683          	lbu	a3,0(a1)
    57ce:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    57d2:	fee79ae3          	bne	a5,a4,57c6 <memmove+0x46>
    57d6:	bfc9                	j	57a8 <memmove+0x28>

00000000000057d8 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    57d8:	1141                	add	sp,sp,-16
    57da:	e422                	sd	s0,8(sp)
    57dc:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    57de:	ca05                	beqz	a2,580e <memcmp+0x36>
    57e0:	fff6069b          	addw	a3,a2,-1
    57e4:	1682                	sll	a3,a3,0x20
    57e6:	9281                	srl	a3,a3,0x20
    57e8:	0685                	add	a3,a3,1
    57ea:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    57ec:	00054783          	lbu	a5,0(a0)
    57f0:	0005c703          	lbu	a4,0(a1)
    57f4:	00e79863          	bne	a5,a4,5804 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    57f8:	0505                	add	a0,a0,1
    p2++;
    57fa:	0585                	add	a1,a1,1
  while (n-- > 0) {
    57fc:	fed518e3          	bne	a0,a3,57ec <memcmp+0x14>
  }
  return 0;
    5800:	4501                	li	a0,0
    5802:	a019                	j	5808 <memcmp+0x30>
      return *p1 - *p2;
    5804:	40e7853b          	subw	a0,a5,a4
}
    5808:	6422                	ld	s0,8(sp)
    580a:	0141                	add	sp,sp,16
    580c:	8082                	ret
  return 0;
    580e:	4501                	li	a0,0
    5810:	bfe5                	j	5808 <memcmp+0x30>

0000000000005812 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    5812:	1141                	add	sp,sp,-16
    5814:	e406                	sd	ra,8(sp)
    5816:	e022                	sd	s0,0(sp)
    5818:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
    581a:	00000097          	auipc	ra,0x0
    581e:	f66080e7          	jalr	-154(ra) # 5780 <memmove>
}
    5822:	60a2                	ld	ra,8(sp)
    5824:	6402                	ld	s0,0(sp)
    5826:	0141                	add	sp,sp,16
    5828:	8082                	ret

000000000000582a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    582a:	4885                	li	a7,1
 ecall
    582c:	00000073          	ecall
 ret
    5830:	8082                	ret

0000000000005832 <exit>:
.global exit
exit:
 li a7, SYS_exit
    5832:	4889                	li	a7,2
 ecall
    5834:	00000073          	ecall
 ret
    5838:	8082                	ret

000000000000583a <wait>:
.global wait
wait:
 li a7, SYS_wait
    583a:	488d                	li	a7,3
 ecall
    583c:	00000073          	ecall
 ret
    5840:	8082                	ret

0000000000005842 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    5842:	4891                	li	a7,4
 ecall
    5844:	00000073          	ecall
 ret
    5848:	8082                	ret

000000000000584a <read>:
.global read
read:
 li a7, SYS_read
    584a:	4895                	li	a7,5
 ecall
    584c:	00000073          	ecall
 ret
    5850:	8082                	ret

0000000000005852 <write>:
.global write
write:
 li a7, SYS_write
    5852:	48c1                	li	a7,16
 ecall
    5854:	00000073          	ecall
 ret
    5858:	8082                	ret

000000000000585a <close>:
.global close
close:
 li a7, SYS_close
    585a:	48d5                	li	a7,21
 ecall
    585c:	00000073          	ecall
 ret
    5860:	8082                	ret

0000000000005862 <kill>:
.global kill
kill:
 li a7, SYS_kill
    5862:	4899                	li	a7,6
 ecall
    5864:	00000073          	ecall
 ret
    5868:	8082                	ret

000000000000586a <exec>:
.global exec
exec:
 li a7, SYS_exec
    586a:	489d                	li	a7,7
 ecall
    586c:	00000073          	ecall
 ret
    5870:	8082                	ret

0000000000005872 <open>:
.global open
open:
 li a7, SYS_open
    5872:	48bd                	li	a7,15
 ecall
    5874:	00000073          	ecall
 ret
    5878:	8082                	ret

000000000000587a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    587a:	48c5                	li	a7,17
 ecall
    587c:	00000073          	ecall
 ret
    5880:	8082                	ret

0000000000005882 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    5882:	48c9                	li	a7,18
 ecall
    5884:	00000073          	ecall
 ret
    5888:	8082                	ret

000000000000588a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    588a:	48a1                	li	a7,8
 ecall
    588c:	00000073          	ecall
 ret
    5890:	8082                	ret

0000000000005892 <link>:
.global link
link:
 li a7, SYS_link
    5892:	48cd                	li	a7,19
 ecall
    5894:	00000073          	ecall
 ret
    5898:	8082                	ret

000000000000589a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    589a:	48d1                	li	a7,20
 ecall
    589c:	00000073          	ecall
 ret
    58a0:	8082                	ret

00000000000058a2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    58a2:	48a5                	li	a7,9
 ecall
    58a4:	00000073          	ecall
 ret
    58a8:	8082                	ret

00000000000058aa <dup>:
.global dup
dup:
 li a7, SYS_dup
    58aa:	48a9                	li	a7,10
 ecall
    58ac:	00000073          	ecall
 ret
    58b0:	8082                	ret

00000000000058b2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    58b2:	48ad                	li	a7,11
 ecall
    58b4:	00000073          	ecall
 ret
    58b8:	8082                	ret

00000000000058ba <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    58ba:	48b1                	li	a7,12
 ecall
    58bc:	00000073          	ecall
 ret
    58c0:	8082                	ret

00000000000058c2 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    58c2:	48b5                	li	a7,13
 ecall
    58c4:	00000073          	ecall
 ret
    58c8:	8082                	ret

00000000000058ca <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    58ca:	48b9                	li	a7,14
 ecall
    58cc:	00000073          	ecall
 ret
    58d0:	8082                	ret

00000000000058d2 <trace>:
.global trace
trace:
 li a7, SYS_trace
    58d2:	48d9                	li	a7,22
 ecall
    58d4:	00000073          	ecall
 ret
    58d8:	8082                	ret

00000000000058da <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    58da:	1101                	add	sp,sp,-32
    58dc:	ec06                	sd	ra,24(sp)
    58de:	e822                	sd	s0,16(sp)
    58e0:	1000                	add	s0,sp,32
    58e2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    58e6:	4605                	li	a2,1
    58e8:	fef40593          	add	a1,s0,-17
    58ec:	00000097          	auipc	ra,0x0
    58f0:	f66080e7          	jalr	-154(ra) # 5852 <write>
}
    58f4:	60e2                	ld	ra,24(sp)
    58f6:	6442                	ld	s0,16(sp)
    58f8:	6105                	add	sp,sp,32
    58fa:	8082                	ret

00000000000058fc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    58fc:	7139                	add	sp,sp,-64
    58fe:	fc06                	sd	ra,56(sp)
    5900:	f822                	sd	s0,48(sp)
    5902:	f426                	sd	s1,40(sp)
    5904:	f04a                	sd	s2,32(sp)
    5906:	ec4e                	sd	s3,24(sp)
    5908:	0080                	add	s0,sp,64
    590a:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    590c:	c299                	beqz	a3,5912 <printint+0x16>
    590e:	0805c963          	bltz	a1,59a0 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    5912:	2581                	sext.w	a1,a1
  neg = 0;
    5914:	4881                	li	a7,0
    5916:	fc040693          	add	a3,s0,-64
  }

  i = 0;
    591a:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    591c:	2601                	sext.w	a2,a2
    591e:	00003517          	auipc	a0,0x3
    5922:	c5a50513          	add	a0,a0,-934 # 8578 <digits>
    5926:	883a                	mv	a6,a4
    5928:	2705                	addw	a4,a4,1
    592a:	02c5f7bb          	remuw	a5,a1,a2
    592e:	1782                	sll	a5,a5,0x20
    5930:	9381                	srl	a5,a5,0x20
    5932:	97aa                	add	a5,a5,a0
    5934:	0007c783          	lbu	a5,0(a5)
    5938:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    593c:	0005879b          	sext.w	a5,a1
    5940:	02c5d5bb          	divuw	a1,a1,a2
    5944:	0685                	add	a3,a3,1
    5946:	fec7f0e3          	bgeu	a5,a2,5926 <printint+0x2a>
  if(neg)
    594a:	00088c63          	beqz	a7,5962 <printint+0x66>
    buf[i++] = '-';
    594e:	fd070793          	add	a5,a4,-48
    5952:	00878733          	add	a4,a5,s0
    5956:	02d00793          	li	a5,45
    595a:	fef70823          	sb	a5,-16(a4)
    595e:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
    5962:	02e05863          	blez	a4,5992 <printint+0x96>
    5966:	fc040793          	add	a5,s0,-64
    596a:	00e78933          	add	s2,a5,a4
    596e:	fff78993          	add	s3,a5,-1
    5972:	99ba                	add	s3,s3,a4
    5974:	377d                	addw	a4,a4,-1
    5976:	1702                	sll	a4,a4,0x20
    5978:	9301                	srl	a4,a4,0x20
    597a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    597e:	fff94583          	lbu	a1,-1(s2)
    5982:	8526                	mv	a0,s1
    5984:	00000097          	auipc	ra,0x0
    5988:	f56080e7          	jalr	-170(ra) # 58da <putc>
  while(--i >= 0)
    598c:	197d                	add	s2,s2,-1
    598e:	ff3918e3          	bne	s2,s3,597e <printint+0x82>
}
    5992:	70e2                	ld	ra,56(sp)
    5994:	7442                	ld	s0,48(sp)
    5996:	74a2                	ld	s1,40(sp)
    5998:	7902                	ld	s2,32(sp)
    599a:	69e2                	ld	s3,24(sp)
    599c:	6121                	add	sp,sp,64
    599e:	8082                	ret
    x = -xx;
    59a0:	40b005bb          	negw	a1,a1
    neg = 1;
    59a4:	4885                	li	a7,1
    x = -xx;
    59a6:	bf85                	j	5916 <printint+0x1a>

00000000000059a8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    59a8:	715d                	add	sp,sp,-80
    59aa:	e486                	sd	ra,72(sp)
    59ac:	e0a2                	sd	s0,64(sp)
    59ae:	fc26                	sd	s1,56(sp)
    59b0:	f84a                	sd	s2,48(sp)
    59b2:	f44e                	sd	s3,40(sp)
    59b4:	f052                	sd	s4,32(sp)
    59b6:	ec56                	sd	s5,24(sp)
    59b8:	e85a                	sd	s6,16(sp)
    59ba:	e45e                	sd	s7,8(sp)
    59bc:	e062                	sd	s8,0(sp)
    59be:	0880                	add	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    59c0:	0005c903          	lbu	s2,0(a1)
    59c4:	18090c63          	beqz	s2,5b5c <vprintf+0x1b4>
    59c8:	8aaa                	mv	s5,a0
    59ca:	8bb2                	mv	s7,a2
    59cc:	00158493          	add	s1,a1,1
  state = 0;
    59d0:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    59d2:	02500a13          	li	s4,37
    59d6:	4b55                	li	s6,21
    59d8:	a839                	j	59f6 <vprintf+0x4e>
        putc(fd, c);
    59da:	85ca                	mv	a1,s2
    59dc:	8556                	mv	a0,s5
    59de:	00000097          	auipc	ra,0x0
    59e2:	efc080e7          	jalr	-260(ra) # 58da <putc>
    59e6:	a019                	j	59ec <vprintf+0x44>
    } else if(state == '%'){
    59e8:	01498d63          	beq	s3,s4,5a02 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
    59ec:	0485                	add	s1,s1,1
    59ee:	fff4c903          	lbu	s2,-1(s1)
    59f2:	16090563          	beqz	s2,5b5c <vprintf+0x1b4>
    if(state == 0){
    59f6:	fe0999e3          	bnez	s3,59e8 <vprintf+0x40>
      if(c == '%'){
    59fa:	ff4910e3          	bne	s2,s4,59da <vprintf+0x32>
        state = '%';
    59fe:	89d2                	mv	s3,s4
    5a00:	b7f5                	j	59ec <vprintf+0x44>
      if(c == 'd'){
    5a02:	13490263          	beq	s2,s4,5b26 <vprintf+0x17e>
    5a06:	f9d9079b          	addw	a5,s2,-99
    5a0a:	0ff7f793          	zext.b	a5,a5
    5a0e:	12fb6563          	bltu	s6,a5,5b38 <vprintf+0x190>
    5a12:	f9d9079b          	addw	a5,s2,-99
    5a16:	0ff7f713          	zext.b	a4,a5
    5a1a:	10eb6f63          	bltu	s6,a4,5b38 <vprintf+0x190>
    5a1e:	00271793          	sll	a5,a4,0x2
    5a22:	00003717          	auipc	a4,0x3
    5a26:	afe70713          	add	a4,a4,-1282 # 8520 <malloc+0x28c6>
    5a2a:	97ba                	add	a5,a5,a4
    5a2c:	439c                	lw	a5,0(a5)
    5a2e:	97ba                	add	a5,a5,a4
    5a30:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    5a32:	008b8913          	add	s2,s7,8
    5a36:	4685                	li	a3,1
    5a38:	4629                	li	a2,10
    5a3a:	000ba583          	lw	a1,0(s7)
    5a3e:	8556                	mv	a0,s5
    5a40:	00000097          	auipc	ra,0x0
    5a44:	ebc080e7          	jalr	-324(ra) # 58fc <printint>
    5a48:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    5a4a:	4981                	li	s3,0
    5a4c:	b745                	j	59ec <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
    5a4e:	008b8913          	add	s2,s7,8
    5a52:	4681                	li	a3,0
    5a54:	4629                	li	a2,10
    5a56:	000ba583          	lw	a1,0(s7)
    5a5a:	8556                	mv	a0,s5
    5a5c:	00000097          	auipc	ra,0x0
    5a60:	ea0080e7          	jalr	-352(ra) # 58fc <printint>
    5a64:	8bca                	mv	s7,s2
      state = 0;
    5a66:	4981                	li	s3,0
    5a68:	b751                	j	59ec <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
    5a6a:	008b8913          	add	s2,s7,8
    5a6e:	4681                	li	a3,0
    5a70:	4641                	li	a2,16
    5a72:	000ba583          	lw	a1,0(s7)
    5a76:	8556                	mv	a0,s5
    5a78:	00000097          	auipc	ra,0x0
    5a7c:	e84080e7          	jalr	-380(ra) # 58fc <printint>
    5a80:	8bca                	mv	s7,s2
      state = 0;
    5a82:	4981                	li	s3,0
    5a84:	b7a5                	j	59ec <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
    5a86:	008b8c13          	add	s8,s7,8
    5a8a:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    5a8e:	03000593          	li	a1,48
    5a92:	8556                	mv	a0,s5
    5a94:	00000097          	auipc	ra,0x0
    5a98:	e46080e7          	jalr	-442(ra) # 58da <putc>
  putc(fd, 'x');
    5a9c:	07800593          	li	a1,120
    5aa0:	8556                	mv	a0,s5
    5aa2:	00000097          	auipc	ra,0x0
    5aa6:	e38080e7          	jalr	-456(ra) # 58da <putc>
    5aaa:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    5aac:	00003b97          	auipc	s7,0x3
    5ab0:	accb8b93          	add	s7,s7,-1332 # 8578 <digits>
    5ab4:	03c9d793          	srl	a5,s3,0x3c
    5ab8:	97de                	add	a5,a5,s7
    5aba:	0007c583          	lbu	a1,0(a5)
    5abe:	8556                	mv	a0,s5
    5ac0:	00000097          	auipc	ra,0x0
    5ac4:	e1a080e7          	jalr	-486(ra) # 58da <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    5ac8:	0992                	sll	s3,s3,0x4
    5aca:	397d                	addw	s2,s2,-1
    5acc:	fe0914e3          	bnez	s2,5ab4 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
    5ad0:	8be2                	mv	s7,s8
      state = 0;
    5ad2:	4981                	li	s3,0
    5ad4:	bf21                	j	59ec <vprintf+0x44>
        s = va_arg(ap, char*);
    5ad6:	008b8993          	add	s3,s7,8
    5ada:	000bb903          	ld	s2,0(s7)
        if(s == 0)
    5ade:	02090163          	beqz	s2,5b00 <vprintf+0x158>
        while(*s != 0){
    5ae2:	00094583          	lbu	a1,0(s2)
    5ae6:	c9a5                	beqz	a1,5b56 <vprintf+0x1ae>
          putc(fd, *s);
    5ae8:	8556                	mv	a0,s5
    5aea:	00000097          	auipc	ra,0x0
    5aee:	df0080e7          	jalr	-528(ra) # 58da <putc>
          s++;
    5af2:	0905                	add	s2,s2,1
        while(*s != 0){
    5af4:	00094583          	lbu	a1,0(s2)
    5af8:	f9e5                	bnez	a1,5ae8 <vprintf+0x140>
        s = va_arg(ap, char*);
    5afa:	8bce                	mv	s7,s3
      state = 0;
    5afc:	4981                	li	s3,0
    5afe:	b5fd                	j	59ec <vprintf+0x44>
          s = "(null)";
    5b00:	00003917          	auipc	s2,0x3
    5b04:	a1890913          	add	s2,s2,-1512 # 8518 <malloc+0x28be>
        while(*s != 0){
    5b08:	02800593          	li	a1,40
    5b0c:	bff1                	j	5ae8 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
    5b0e:	008b8913          	add	s2,s7,8
    5b12:	000bc583          	lbu	a1,0(s7)
    5b16:	8556                	mv	a0,s5
    5b18:	00000097          	auipc	ra,0x0
    5b1c:	dc2080e7          	jalr	-574(ra) # 58da <putc>
    5b20:	8bca                	mv	s7,s2
      state = 0;
    5b22:	4981                	li	s3,0
    5b24:	b5e1                	j	59ec <vprintf+0x44>
        putc(fd, c);
    5b26:	02500593          	li	a1,37
    5b2a:	8556                	mv	a0,s5
    5b2c:	00000097          	auipc	ra,0x0
    5b30:	dae080e7          	jalr	-594(ra) # 58da <putc>
      state = 0;
    5b34:	4981                	li	s3,0
    5b36:	bd5d                	j	59ec <vprintf+0x44>
        putc(fd, '%');
    5b38:	02500593          	li	a1,37
    5b3c:	8556                	mv	a0,s5
    5b3e:	00000097          	auipc	ra,0x0
    5b42:	d9c080e7          	jalr	-612(ra) # 58da <putc>
        putc(fd, c);
    5b46:	85ca                	mv	a1,s2
    5b48:	8556                	mv	a0,s5
    5b4a:	00000097          	auipc	ra,0x0
    5b4e:	d90080e7          	jalr	-624(ra) # 58da <putc>
      state = 0;
    5b52:	4981                	li	s3,0
    5b54:	bd61                	j	59ec <vprintf+0x44>
        s = va_arg(ap, char*);
    5b56:	8bce                	mv	s7,s3
      state = 0;
    5b58:	4981                	li	s3,0
    5b5a:	bd49                	j	59ec <vprintf+0x44>
    }
  }
}
    5b5c:	60a6                	ld	ra,72(sp)
    5b5e:	6406                	ld	s0,64(sp)
    5b60:	74e2                	ld	s1,56(sp)
    5b62:	7942                	ld	s2,48(sp)
    5b64:	79a2                	ld	s3,40(sp)
    5b66:	7a02                	ld	s4,32(sp)
    5b68:	6ae2                	ld	s5,24(sp)
    5b6a:	6b42                	ld	s6,16(sp)
    5b6c:	6ba2                	ld	s7,8(sp)
    5b6e:	6c02                	ld	s8,0(sp)
    5b70:	6161                	add	sp,sp,80
    5b72:	8082                	ret

0000000000005b74 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    5b74:	715d                	add	sp,sp,-80
    5b76:	ec06                	sd	ra,24(sp)
    5b78:	e822                	sd	s0,16(sp)
    5b7a:	1000                	add	s0,sp,32
    5b7c:	e010                	sd	a2,0(s0)
    5b7e:	e414                	sd	a3,8(s0)
    5b80:	e818                	sd	a4,16(s0)
    5b82:	ec1c                	sd	a5,24(s0)
    5b84:	03043023          	sd	a6,32(s0)
    5b88:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    5b8c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    5b90:	8622                	mv	a2,s0
    5b92:	00000097          	auipc	ra,0x0
    5b96:	e16080e7          	jalr	-490(ra) # 59a8 <vprintf>
}
    5b9a:	60e2                	ld	ra,24(sp)
    5b9c:	6442                	ld	s0,16(sp)
    5b9e:	6161                	add	sp,sp,80
    5ba0:	8082                	ret

0000000000005ba2 <printf>:

void
printf(const char *fmt, ...)
{
    5ba2:	711d                	add	sp,sp,-96
    5ba4:	ec06                	sd	ra,24(sp)
    5ba6:	e822                	sd	s0,16(sp)
    5ba8:	1000                	add	s0,sp,32
    5baa:	e40c                	sd	a1,8(s0)
    5bac:	e810                	sd	a2,16(s0)
    5bae:	ec14                	sd	a3,24(s0)
    5bb0:	f018                	sd	a4,32(s0)
    5bb2:	f41c                	sd	a5,40(s0)
    5bb4:	03043823          	sd	a6,48(s0)
    5bb8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    5bbc:	00840613          	add	a2,s0,8
    5bc0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    5bc4:	85aa                	mv	a1,a0
    5bc6:	4505                	li	a0,1
    5bc8:	00000097          	auipc	ra,0x0
    5bcc:	de0080e7          	jalr	-544(ra) # 59a8 <vprintf>
}
    5bd0:	60e2                	ld	ra,24(sp)
    5bd2:	6442                	ld	s0,16(sp)
    5bd4:	6125                	add	sp,sp,96
    5bd6:	8082                	ret

0000000000005bd8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    5bd8:	1141                	add	sp,sp,-16
    5bda:	e422                	sd	s0,8(sp)
    5bdc:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    5bde:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5be2:	00003797          	auipc	a5,0x3
    5be6:	9b67b783          	ld	a5,-1610(a5) # 8598 <freep>
    5bea:	a02d                	j	5c14 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    5bec:	4618                	lw	a4,8(a2)
    5bee:	9f2d                	addw	a4,a4,a1
    5bf0:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    5bf4:	6398                	ld	a4,0(a5)
    5bf6:	6310                	ld	a2,0(a4)
    5bf8:	a83d                	j	5c36 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    5bfa:	ff852703          	lw	a4,-8(a0)
    5bfe:	9f31                	addw	a4,a4,a2
    5c00:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    5c02:	ff053683          	ld	a3,-16(a0)
    5c06:	a091                	j	5c4a <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5c08:	6398                	ld	a4,0(a5)
    5c0a:	00e7e463          	bltu	a5,a4,5c12 <free+0x3a>
    5c0e:	00e6ea63          	bltu	a3,a4,5c22 <free+0x4a>
{
    5c12:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5c14:	fed7fae3          	bgeu	a5,a3,5c08 <free+0x30>
    5c18:	6398                	ld	a4,0(a5)
    5c1a:	00e6e463          	bltu	a3,a4,5c22 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5c1e:	fee7eae3          	bltu	a5,a4,5c12 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    5c22:	ff852583          	lw	a1,-8(a0)
    5c26:	6390                	ld	a2,0(a5)
    5c28:	02059813          	sll	a6,a1,0x20
    5c2c:	01c85713          	srl	a4,a6,0x1c
    5c30:	9736                	add	a4,a4,a3
    5c32:	fae60de3          	beq	a2,a4,5bec <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    5c36:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    5c3a:	4790                	lw	a2,8(a5)
    5c3c:	02061593          	sll	a1,a2,0x20
    5c40:	01c5d713          	srl	a4,a1,0x1c
    5c44:	973e                	add	a4,a4,a5
    5c46:	fae68ae3          	beq	a3,a4,5bfa <free+0x22>
    p->s.ptr = bp->s.ptr;
    5c4a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    5c4c:	00003717          	auipc	a4,0x3
    5c50:	94f73623          	sd	a5,-1716(a4) # 8598 <freep>
}
    5c54:	6422                	ld	s0,8(sp)
    5c56:	0141                	add	sp,sp,16
    5c58:	8082                	ret

0000000000005c5a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    5c5a:	7139                	add	sp,sp,-64
    5c5c:	fc06                	sd	ra,56(sp)
    5c5e:	f822                	sd	s0,48(sp)
    5c60:	f426                	sd	s1,40(sp)
    5c62:	f04a                	sd	s2,32(sp)
    5c64:	ec4e                	sd	s3,24(sp)
    5c66:	e852                	sd	s4,16(sp)
    5c68:	e456                	sd	s5,8(sp)
    5c6a:	e05a                	sd	s6,0(sp)
    5c6c:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    5c6e:	02051493          	sll	s1,a0,0x20
    5c72:	9081                	srl	s1,s1,0x20
    5c74:	04bd                	add	s1,s1,15
    5c76:	8091                	srl	s1,s1,0x4
    5c78:	0014899b          	addw	s3,s1,1
    5c7c:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
    5c7e:	00003517          	auipc	a0,0x3
    5c82:	91a53503          	ld	a0,-1766(a0) # 8598 <freep>
    5c86:	c515                	beqz	a0,5cb2 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    5c88:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    5c8a:	4798                	lw	a4,8(a5)
    5c8c:	02977f63          	bgeu	a4,s1,5cca <malloc+0x70>
  if(nu < 4096)
    5c90:	8a4e                	mv	s4,s3
    5c92:	0009871b          	sext.w	a4,s3
    5c96:	6685                	lui	a3,0x1
    5c98:	00d77363          	bgeu	a4,a3,5c9e <malloc+0x44>
    5c9c:	6a05                	lui	s4,0x1
    5c9e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    5ca2:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    5ca6:	00003917          	auipc	s2,0x3
    5caa:	8f290913          	add	s2,s2,-1806 # 8598 <freep>
  if(p == (char*)-1)
    5cae:	5afd                	li	s5,-1
    5cb0:	a895                	j	5d24 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
    5cb2:	00009797          	auipc	a5,0x9
    5cb6:	10678793          	add	a5,a5,262 # edb8 <base>
    5cba:	00003717          	auipc	a4,0x3
    5cbe:	8cf73f23          	sd	a5,-1826(a4) # 8598 <freep>
    5cc2:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    5cc4:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    5cc8:	b7e1                	j	5c90 <malloc+0x36>
      if(p->s.size == nunits)
    5cca:	02e48c63          	beq	s1,a4,5d02 <malloc+0xa8>
        p->s.size -= nunits;
    5cce:	4137073b          	subw	a4,a4,s3
    5cd2:	c798                	sw	a4,8(a5)
        p += p->s.size;
    5cd4:	02071693          	sll	a3,a4,0x20
    5cd8:	01c6d713          	srl	a4,a3,0x1c
    5cdc:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    5cde:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    5ce2:	00003717          	auipc	a4,0x3
    5ce6:	8aa73b23          	sd	a0,-1866(a4) # 8598 <freep>
      return (void*)(p + 1);
    5cea:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    5cee:	70e2                	ld	ra,56(sp)
    5cf0:	7442                	ld	s0,48(sp)
    5cf2:	74a2                	ld	s1,40(sp)
    5cf4:	7902                	ld	s2,32(sp)
    5cf6:	69e2                	ld	s3,24(sp)
    5cf8:	6a42                	ld	s4,16(sp)
    5cfa:	6aa2                	ld	s5,8(sp)
    5cfc:	6b02                	ld	s6,0(sp)
    5cfe:	6121                	add	sp,sp,64
    5d00:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    5d02:	6398                	ld	a4,0(a5)
    5d04:	e118                	sd	a4,0(a0)
    5d06:	bff1                	j	5ce2 <malloc+0x88>
  hp->s.size = nu;
    5d08:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    5d0c:	0541                	add	a0,a0,16
    5d0e:	00000097          	auipc	ra,0x0
    5d12:	eca080e7          	jalr	-310(ra) # 5bd8 <free>
  return freep;
    5d16:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    5d1a:	d971                	beqz	a0,5cee <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    5d1c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    5d1e:	4798                	lw	a4,8(a5)
    5d20:	fa9775e3          	bgeu	a4,s1,5cca <malloc+0x70>
    if(p == freep)
    5d24:	00093703          	ld	a4,0(s2)
    5d28:	853e                	mv	a0,a5
    5d2a:	fef719e3          	bne	a4,a5,5d1c <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
    5d2e:	8552                	mv	a0,s4
    5d30:	00000097          	auipc	ra,0x0
    5d34:	b8a080e7          	jalr	-1142(ra) # 58ba <sbrk>
  if(p == (char*)-1)
    5d38:	fd5518e3          	bne	a0,s5,5d08 <malloc+0xae>
        return 0;
    5d3c:	4501                	li	a0,0
    5d3e:	bf45                	j	5cee <malloc+0x94>
