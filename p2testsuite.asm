
_p2testsuite:     file format elf32-i386


Disassembly of section .text:

00000000 <testppid>:
#include "uproc.h"
#endif

#ifdef UIDGIDPPID_TEST
static void
testppid(void){
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 18             	sub    $0x18,%esp
  int ret, pid, ppid;

  printf(1, "\n----------\nRunning PPID Test\n----------\n");
       6:	83 ec 08             	sub    $0x8,%esp
       9:	68 94 15 00 00       	push   $0x1594
       e:	6a 01                	push   $0x1
      10:	e8 c9 11 00 00       	call   11de <printf>
      15:	83 c4 10             	add    $0x10,%esp
  pid = getpid();
      18:	e8 8a 10 00 00       	call   10a7 <getpid>
      1d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  ret = fork();
      20:	e8 fa 0f 00 00       	call   101f <fork>
      25:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(ret == 0){
      28:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
      2c:	75 3e                	jne    6c <testppid+0x6c>
    ppid = getppid();
      2e:	e8 b4 10 00 00       	call   10e7 <getppid>
      33:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(ppid != pid)
      36:	8b 45 ec             	mov    -0x14(%ebp),%eax
      39:	3b 45 f4             	cmp    -0xc(%ebp),%eax
      3c:	74 17                	je     55 <testppid+0x55>
      printf(2, "FAILED: Parent PID is %d, Child's PPID is %d\n", pid, ppid);
      3e:	ff 75 ec             	pushl  -0x14(%ebp)
      41:	ff 75 f4             	pushl  -0xc(%ebp)
      44:	68 c0 15 00 00       	push   $0x15c0
      49:	6a 02                	push   $0x2
      4b:	e8 8e 11 00 00       	call   11de <printf>
      50:	83 c4 10             	add    $0x10,%esp
      53:	eb 12                	jmp    67 <testppid+0x67>
    else
      printf(1, "** Test passed! **\n");
      55:	83 ec 08             	sub    $0x8,%esp
      58:	68 ee 15 00 00       	push   $0x15ee
      5d:	6a 01                	push   $0x1
      5f:	e8 7a 11 00 00       	call   11de <printf>
      64:	83 c4 10             	add    $0x10,%esp
    exit();
      67:	e8 bb 0f 00 00       	call   1027 <exit>
  }
  else
    wait();
      6c:	e8 be 0f 00 00       	call   102f <wait>
}
      71:	90                   	nop
      72:	c9                   	leave  
      73:	c3                   	ret    

00000074 <testgid>:

static int
testgid(uint new_val, uint expected_get_val, int expected_set_ret){
      74:	55                   	push   %ebp
      75:	89 e5                	mov    %esp,%ebp
      77:	83 ec 18             	sub    $0x18,%esp
  int ret;
  uint post_gid, pre_gid;
  int success = 0;
      7a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  pre_gid = getgid();
      81:	e8 59 10 00 00       	call   10df <getgid>
      86:	89 45 f0             	mov    %eax,-0x10(%ebp)
  ret = setgid(new_val);
      89:	83 ec 0c             	sub    $0xc,%esp
      8c:	ff 75 08             	pushl  0x8(%ebp)
      8f:	e8 63 10 00 00       	call   10f7 <setgid>
      94:	83 c4 10             	add    $0x10,%esp
      97:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((ret < 0 && expected_set_ret >= 0) || (ret >= 0 && expected_set_ret < 0)){
      9a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
      9e:	79 06                	jns    a6 <testgid+0x32>
      a0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
      a4:	79 0c                	jns    b2 <testgid+0x3e>
      a6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
      aa:	78 28                	js     d4 <testgid+0x60>
      ac:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
      b0:	79 22                	jns    d4 <testgid+0x60>
    printf(2, "FAILED: setgid(%d) returned %d, expected %d\n", new_val, ret, expected_set_ret);
      b2:	83 ec 0c             	sub    $0xc,%esp
      b5:	ff 75 10             	pushl  0x10(%ebp)
      b8:	ff 75 ec             	pushl  -0x14(%ebp)
      bb:	ff 75 08             	pushl  0x8(%ebp)
      be:	68 04 16 00 00       	push   $0x1604
      c3:	6a 02                	push   $0x2
      c5:	e8 14 11 00 00       	call   11de <printf>
      ca:	83 c4 20             	add    $0x20,%esp
    success = -1;
      cd:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  }
  post_gid = getgid();
      d4:	e8 06 10 00 00       	call   10df <getgid>
      d9:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(post_gid != expected_get_val){
      dc:	8b 45 e8             	mov    -0x18(%ebp),%eax
      df:	3b 45 0c             	cmp    0xc(%ebp),%eax
      e2:	74 25                	je     109 <testgid+0x95>
    printf(2, "FAILED: UID was %d. After setgid(%d), getgid() returned %d, expected %d\n",
      e4:	83 ec 08             	sub    $0x8,%esp
      e7:	ff 75 0c             	pushl  0xc(%ebp)
      ea:	ff 75 e8             	pushl  -0x18(%ebp)
      ed:	ff 75 08             	pushl  0x8(%ebp)
      f0:	ff 75 f0             	pushl  -0x10(%ebp)
      f3:	68 34 16 00 00       	push   $0x1634
      f8:	6a 02                	push   $0x2
      fa:	e8 df 10 00 00       	call   11de <printf>
      ff:	83 c4 20             	add    $0x20,%esp
        pre_gid, new_val, post_gid, expected_get_val);
    success = -1;
     102:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  }
  return success;
     109:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     10c:	c9                   	leave  
     10d:	c3                   	ret    

0000010e <testuid>:

static int
testuid(uint new_val, uint expected_get_val, int expected_set_ret){
     10e:	55                   	push   %ebp
     10f:	89 e5                	mov    %esp,%ebp
     111:	83 ec 18             	sub    $0x18,%esp
  int ret;
  uint post_uid, pre_uid;
  int success = 0;
     114:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  pre_uid = getuid();
     11b:	e8 b7 0f 00 00       	call   10d7 <getuid>
     120:	89 45 f0             	mov    %eax,-0x10(%ebp)
  ret = setuid(new_val);
     123:	83 ec 0c             	sub    $0xc,%esp
     126:	ff 75 08             	pushl  0x8(%ebp)
     129:	e8 c1 0f 00 00       	call   10ef <setuid>
     12e:	83 c4 10             	add    $0x10,%esp
     131:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((ret < 0 && expected_set_ret >= 0) || (ret >= 0 && expected_set_ret < 0)){
     134:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     138:	79 06                	jns    140 <testuid+0x32>
     13a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     13e:	79 0c                	jns    14c <testuid+0x3e>
     140:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     144:	78 28                	js     16e <testuid+0x60>
     146:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     14a:	79 22                	jns    16e <testuid+0x60>
    printf(2, "FAILED: setuid(%d) returned %d, expected %d\n", new_val, ret, expected_set_ret);
     14c:	83 ec 0c             	sub    $0xc,%esp
     14f:	ff 75 10             	pushl  0x10(%ebp)
     152:	ff 75 ec             	pushl  -0x14(%ebp)
     155:	ff 75 08             	pushl  0x8(%ebp)
     158:	68 80 16 00 00       	push   $0x1680
     15d:	6a 02                	push   $0x2
     15f:	e8 7a 10 00 00       	call   11de <printf>
     164:	83 c4 20             	add    $0x20,%esp
    success = -1;
     167:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  }
  post_uid = getuid();
     16e:	e8 64 0f 00 00       	call   10d7 <getuid>
     173:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(post_uid != expected_get_val){
     176:	8b 45 e8             	mov    -0x18(%ebp),%eax
     179:	3b 45 0c             	cmp    0xc(%ebp),%eax
     17c:	74 25                	je     1a3 <testuid+0x95>
    printf(2, "FAILED: UID was %d. After setuid(%d), getuid() returned %d, expected %d\n",
     17e:	83 ec 08             	sub    $0x8,%esp
     181:	ff 75 0c             	pushl  0xc(%ebp)
     184:	ff 75 e8             	pushl  -0x18(%ebp)
     187:	ff 75 08             	pushl  0x8(%ebp)
     18a:	ff 75 f0             	pushl  -0x10(%ebp)
     18d:	68 b0 16 00 00       	push   $0x16b0
     192:	6a 02                	push   $0x2
     194:	e8 45 10 00 00       	call   11de <printf>
     199:	83 c4 20             	add    $0x20,%esp
        pre_uid, new_val, post_uid, expected_get_val);
    success = -1;
     19c:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  }
  return success;
     1a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     1a6:	c9                   	leave  
     1a7:	c3                   	ret    

000001a8 <testuidgid>:

  static void
testuidgid(void)
{
     1a8:	55                   	push   %ebp
     1a9:	89 e5                	mov    %esp,%ebp
     1ab:	83 ec 18             	sub    $0x18,%esp
  int uid, gid;
  int success = 0;
     1ae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  printf(1, "\n----------\nRunning UID / GID Tests\n----------\n");
     1b5:	83 ec 08             	sub    $0x8,%esp
     1b8:	68 fc 16 00 00       	push   $0x16fc
     1bd:	6a 01                	push   $0x1
     1bf:	e8 1a 10 00 00       	call   11de <printf>
     1c4:	83 c4 10             	add    $0x10,%esp
  uid = getuid();
     1c7:	e8 0b 0f 00 00       	call   10d7 <getuid>
     1cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(uid < 0 || uid > 32767){
     1cf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     1d3:	78 09                	js     1de <testuidgid+0x36>
     1d5:	81 7d f0 ff 7f 00 00 	cmpl   $0x7fff,-0x10(%ebp)
     1dc:	7e 1c                	jle    1fa <testuidgid+0x52>
    printf(1, "FAILED: Default UID %d, out of range\n", uid);
     1de:	83 ec 04             	sub    $0x4,%esp
     1e1:	ff 75 f0             	pushl  -0x10(%ebp)
     1e4:	68 2c 17 00 00       	push   $0x172c
     1e9:	6a 01                	push   $0x1
     1eb:	e8 ee 0f 00 00       	call   11de <printf>
     1f0:	83 c4 10             	add    $0x10,%esp
    success = -1;
     1f3:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  }
  if (testuid(0, 0, 0))
     1fa:	83 ec 04             	sub    $0x4,%esp
     1fd:	6a 00                	push   $0x0
     1ff:	6a 00                	push   $0x0
     201:	6a 00                	push   $0x0
     203:	e8 06 ff ff ff       	call   10e <testuid>
     208:	83 c4 10             	add    $0x10,%esp
     20b:	85 c0                	test   %eax,%eax
     20d:	74 07                	je     216 <testuidgid+0x6e>
    success = -1;
     20f:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if (testuid(5, 5, 0))
     216:	83 ec 04             	sub    $0x4,%esp
     219:	6a 00                	push   $0x0
     21b:	6a 05                	push   $0x5
     21d:	6a 05                	push   $0x5
     21f:	e8 ea fe ff ff       	call   10e <testuid>
     224:	83 c4 10             	add    $0x10,%esp
     227:	85 c0                	test   %eax,%eax
     229:	74 07                	je     232 <testuidgid+0x8a>
    success = -1;
     22b:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if (testuid(32767, 32767, 0))
     232:	83 ec 04             	sub    $0x4,%esp
     235:	6a 00                	push   $0x0
     237:	68 ff 7f 00 00       	push   $0x7fff
     23c:	68 ff 7f 00 00       	push   $0x7fff
     241:	e8 c8 fe ff ff       	call   10e <testuid>
     246:	83 c4 10             	add    $0x10,%esp
     249:	85 c0                	test   %eax,%eax
     24b:	74 07                	je     254 <testuidgid+0xac>
    success = -1;
     24d:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if (testuid(32768, 32767, -1))
     254:	83 ec 04             	sub    $0x4,%esp
     257:	6a ff                	push   $0xffffffff
     259:	68 ff 7f 00 00       	push   $0x7fff
     25e:	68 00 80 00 00       	push   $0x8000
     263:	e8 a6 fe ff ff       	call   10e <testuid>
     268:	83 c4 10             	add    $0x10,%esp
     26b:	85 c0                	test   %eax,%eax
     26d:	74 07                	je     276 <testuidgid+0xce>
    success = -1;
     26f:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if (testuid(-1, 32767, -1))
     276:	83 ec 04             	sub    $0x4,%esp
     279:	6a ff                	push   $0xffffffff
     27b:	68 ff 7f 00 00       	push   $0x7fff
     280:	6a ff                	push   $0xffffffff
     282:	e8 87 fe ff ff       	call   10e <testuid>
     287:	83 c4 10             	add    $0x10,%esp
     28a:	85 c0                	test   %eax,%eax
     28c:	74 07                	je     295 <testuidgid+0xed>
    success = -1;
     28e:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)

  gid = getgid();
     295:	e8 45 0e 00 00       	call   10df <getgid>
     29a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(gid < 0 || gid > 32767){
     29d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     2a1:	78 09                	js     2ac <testuidgid+0x104>
     2a3:	81 7d ec ff 7f 00 00 	cmpl   $0x7fff,-0x14(%ebp)
     2aa:	7e 1c                	jle    2c8 <testuidgid+0x120>
    printf(1, "FAILED: Default GID %d, out of range\n", gid);
     2ac:	83 ec 04             	sub    $0x4,%esp
     2af:	ff 75 ec             	pushl  -0x14(%ebp)
     2b2:	68 54 17 00 00       	push   $0x1754
     2b7:	6a 01                	push   $0x1
     2b9:	e8 20 0f 00 00       	call   11de <printf>
     2be:	83 c4 10             	add    $0x10,%esp
    success = -1;
     2c1:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  }
  if (testgid(0, 0, 0))
     2c8:	83 ec 04             	sub    $0x4,%esp
     2cb:	6a 00                	push   $0x0
     2cd:	6a 00                	push   $0x0
     2cf:	6a 00                	push   $0x0
     2d1:	e8 9e fd ff ff       	call   74 <testgid>
     2d6:	83 c4 10             	add    $0x10,%esp
     2d9:	85 c0                	test   %eax,%eax
     2db:	74 07                	je     2e4 <testuidgid+0x13c>
    success = -1;
     2dd:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if (testgid(5, 5, 0))
     2e4:	83 ec 04             	sub    $0x4,%esp
     2e7:	6a 00                	push   $0x0
     2e9:	6a 05                	push   $0x5
     2eb:	6a 05                	push   $0x5
     2ed:	e8 82 fd ff ff       	call   74 <testgid>
     2f2:	83 c4 10             	add    $0x10,%esp
     2f5:	85 c0                	test   %eax,%eax
     2f7:	74 07                	je     300 <testuidgid+0x158>
    success = -1;
     2f9:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if (testgid(32767, 32767, 0))
     300:	83 ec 04             	sub    $0x4,%esp
     303:	6a 00                	push   $0x0
     305:	68 ff 7f 00 00       	push   $0x7fff
     30a:	68 ff 7f 00 00       	push   $0x7fff
     30f:	e8 60 fd ff ff       	call   74 <testgid>
     314:	83 c4 10             	add    $0x10,%esp
     317:	85 c0                	test   %eax,%eax
     319:	74 07                	je     322 <testuidgid+0x17a>
    success = -1;
     31b:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if (testgid(-1, 32767, -1))
     322:	83 ec 04             	sub    $0x4,%esp
     325:	6a ff                	push   $0xffffffff
     327:	68 ff 7f 00 00       	push   $0x7fff
     32c:	6a ff                	push   $0xffffffff
     32e:	e8 41 fd ff ff       	call   74 <testgid>
     333:	83 c4 10             	add    $0x10,%esp
     336:	85 c0                	test   %eax,%eax
     338:	74 07                	je     341 <testuidgid+0x199>
    success = -1;
     33a:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if (testgid(32768, 32767, -1))
     341:	83 ec 04             	sub    $0x4,%esp
     344:	6a ff                	push   $0xffffffff
     346:	68 ff 7f 00 00       	push   $0x7fff
     34b:	68 00 80 00 00       	push   $0x8000
     350:	e8 1f fd ff ff       	call   74 <testgid>
     355:	83 c4 10             	add    $0x10,%esp
     358:	85 c0                	test   %eax,%eax
     35a:	74 07                	je     363 <testuidgid+0x1bb>
    success = -1;
     35c:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)

  if (success == 0)
     363:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     367:	75 12                	jne    37b <testuidgid+0x1d3>
    printf(1, "** All tests passed! **\n");
     369:	83 ec 08             	sub    $0x8,%esp
     36c:	68 7a 17 00 00       	push   $0x177a
     371:	6a 01                	push   $0x1
     373:	e8 66 0e 00 00       	call   11de <printf>
     378:	83 c4 10             	add    $0x10,%esp
}
     37b:	90                   	nop
     37c:	c9                   	leave  
     37d:	c3                   	ret    

0000037e <testuidgidinheritance>:

static void
testuidgidinheritance(void){
     37e:	55                   	push   %ebp
     37f:	89 e5                	mov    %esp,%ebp
     381:	83 ec 18             	sub    $0x18,%esp
  int ret, success, uid, gid;
  success = 0;
     384:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  printf(1, "\n----------\nRunning UID / GID Inheritance Test\n----------\n");
     38b:	83 ec 08             	sub    $0x8,%esp
     38e:	68 94 17 00 00       	push   $0x1794
     393:	6a 01                	push   $0x1
     395:	e8 44 0e 00 00       	call   11de <printf>
     39a:	83 c4 10             	add    $0x10,%esp
  if (testuid(12345, 12345, 0))
     39d:	83 ec 04             	sub    $0x4,%esp
     3a0:	6a 00                	push   $0x0
     3a2:	68 39 30 00 00       	push   $0x3039
     3a7:	68 39 30 00 00       	push   $0x3039
     3ac:	e8 5d fd ff ff       	call   10e <testuid>
     3b1:	83 c4 10             	add    $0x10,%esp
     3b4:	85 c0                	test   %eax,%eax
     3b6:	74 07                	je     3bf <testuidgidinheritance+0x41>
    success = -1;
     3b8:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if (testgid(12345, 12345, 0))
     3bf:	83 ec 04             	sub    $0x4,%esp
     3c2:	6a 00                	push   $0x0
     3c4:	68 39 30 00 00       	push   $0x3039
     3c9:	68 39 30 00 00       	push   $0x3039
     3ce:	e8 a1 fc ff ff       	call   74 <testgid>
     3d3:	83 c4 10             	add    $0x10,%esp
     3d6:	85 c0                	test   %eax,%eax
     3d8:	74 07                	je     3e1 <testuidgidinheritance+0x63>
    success = -1;
     3da:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if(success != 0)
     3e1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     3e5:	75 7c                	jne    463 <testuidgidinheritance+0xe5>
    return;

  ret = fork();
     3e7:	e8 33 0c 00 00       	call   101f <fork>
     3ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(ret == 0){
     3ef:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     3f3:	75 67                	jne    45c <testuidgidinheritance+0xde>
    uid = getuid();
     3f5:	e8 dd 0c 00 00       	call   10d7 <getuid>
     3fa:	89 45 ec             	mov    %eax,-0x14(%ebp)
    gid = getgid();
     3fd:	e8 dd 0c 00 00       	call   10df <getgid>
     402:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(uid != 12345){
     405:	81 7d ec 39 30 00 00 	cmpl   $0x3039,-0x14(%ebp)
     40c:	74 17                	je     425 <testuidgidinheritance+0xa7>
      printf(2, "FAILED: Parent UID is 12345, child UID is %d\n", uid);
     40e:	83 ec 04             	sub    $0x4,%esp
     411:	ff 75 ec             	pushl  -0x14(%ebp)
     414:	68 d0 17 00 00       	push   $0x17d0
     419:	6a 02                	push   $0x2
     41b:	e8 be 0d 00 00       	call   11de <printf>
     420:	83 c4 10             	add    $0x10,%esp
     423:	eb 32                	jmp    457 <testuidgidinheritance+0xd9>
    }
    else if(gid != 12345){
     425:	81 7d e8 39 30 00 00 	cmpl   $0x3039,-0x18(%ebp)
     42c:	74 17                	je     445 <testuidgidinheritance+0xc7>
      printf(2, "FAILED: Parent GID is 12345, child GID is %d\n", gid);
     42e:	83 ec 04             	sub    $0x4,%esp
     431:	ff 75 e8             	pushl  -0x18(%ebp)
     434:	68 00 18 00 00       	push   $0x1800
     439:	6a 02                	push   $0x2
     43b:	e8 9e 0d 00 00       	call   11de <printf>
     440:	83 c4 10             	add    $0x10,%esp
     443:	eb 12                	jmp    457 <testuidgidinheritance+0xd9>
    }
    else
      printf(1, "** Test Passed! **\n");
     445:	83 ec 08             	sub    $0x8,%esp
     448:	68 2e 18 00 00       	push   $0x182e
     44d:	6a 01                	push   $0x1
     44f:	e8 8a 0d 00 00       	call   11de <printf>
     454:	83 c4 10             	add    $0x10,%esp
    exit();
     457:	e8 cb 0b 00 00       	call   1027 <exit>
  }
  else {
    wait();
     45c:	e8 ce 0b 00 00       	call   102f <wait>
     461:	eb 01                	jmp    464 <testuidgidinheritance+0xe6>
  if (testuid(12345, 12345, 0))
    success = -1;
  if (testgid(12345, 12345, 0))
    success = -1;
  if(success != 0)
    return;
     463:	90                   	nop
    exit();
  }
  else {
    wait();
  }
}
     464:	c9                   	leave  
     465:	c3                   	ret    

00000466 <getcputime>:
#ifdef GETPROCS_TEST
#ifdef CPUTIME_TEST
// Simple test to have the program sleep for 200 milliseconds to see if CPU_time properly doesn't change
// And then gets CPU_time again to see if elapsed CPU_total_ticks is reasonable
static int
getcputime(char * name, struct uproc * table){
     466:	55                   	push   %ebp
     467:	89 e5                	mov    %esp,%ebp
     469:	83 ec 18             	sub    $0x18,%esp
  struct uproc *p = 0;
     46c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  int size;

  size = getprocs(64, table);
     473:	83 ec 08             	sub    $0x8,%esp
     476:	ff 75 0c             	pushl  0xc(%ebp)
     479:	6a 40                	push   $0x40
     47b:	e8 7f 0c 00 00       	call   10ff <getprocs>
     480:	83 c4 10             	add    $0x10,%esp
     483:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(int i = 0; i < size; ++i){
     486:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     48d:	eb 35                	jmp    4c4 <getcputime+0x5e>
    if(strcmp(table[i].name, name) == 0){
     48f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     492:	6b d0 5c             	imul   $0x5c,%eax,%edx
     495:	8b 45 0c             	mov    0xc(%ebp),%eax
     498:	01 d0                	add    %edx,%eax
     49a:	83 c0 3c             	add    $0x3c,%eax
     49d:	83 ec 08             	sub    $0x8,%esp
     4a0:	ff 75 08             	pushl  0x8(%ebp)
     4a3:	50                   	push   %eax
     4a4:	e8 aa 08 00 00       	call   d53 <strcmp>
     4a9:	83 c4 10             	add    $0x10,%esp
     4ac:	85 c0                	test   %eax,%eax
     4ae:	75 10                	jne    4c0 <getcputime+0x5a>
      p = table + i;
     4b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     4b3:	6b d0 5c             	imul   $0x5c,%eax,%edx
     4b6:	8b 45 0c             	mov    0xc(%ebp),%eax
     4b9:	01 d0                	add    %edx,%eax
     4bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
      break;
     4be:	eb 0c                	jmp    4cc <getcputime+0x66>
getcputime(char * name, struct uproc * table){
  struct uproc *p = 0;
  int size;

  size = getprocs(64, table);
  for(int i = 0; i < size; ++i){
     4c0:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     4c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     4c7:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     4ca:	7c c3                	jl     48f <getcputime+0x29>
    if(strcmp(table[i].name, name) == 0){
      p = table + i;
      break;
    }
  }
  if(p == 0){
     4cc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     4d0:	75 1c                	jne    4ee <getcputime+0x88>
    printf(2, "FAILED: Test program \"%s\" not found in table returned by getprocs\n", name);
     4d2:	83 ec 04             	sub    $0x4,%esp
     4d5:	ff 75 08             	pushl  0x8(%ebp)
     4d8:	68 44 18 00 00       	push   $0x1844
     4dd:	6a 02                	push   $0x2
     4df:	e8 fa 0c 00 00       	call   11de <printf>
     4e4:	83 c4 10             	add    $0x10,%esp
    return -1;
     4e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     4ec:	eb 06                	jmp    4f4 <getcputime+0x8e>
  }
  else
    return p->CPU_total_ticks;
     4ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4f1:	8b 40 14             	mov    0x14(%eax),%eax
}
     4f4:	c9                   	leave  
     4f5:	c3                   	ret    

000004f6 <testcputime>:

static void
testcputime(char * name){
     4f6:	55                   	push   %ebp
     4f7:	89 e5                	mov    %esp,%ebp
     4f9:	83 ec 28             	sub    $0x28,%esp
  struct uproc *table;
  uint time1, time2, pre_sleep, post_sleep;
  int success = 0;
     4fc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  int i, num;

  printf(1, "\n----------\nRunning CPU Time Test\n----------\n");
     503:	83 ec 08             	sub    $0x8,%esp
     506:	68 88 18 00 00       	push   $0x1888
     50b:	6a 01                	push   $0x1
     50d:	e8 cc 0c 00 00       	call   11de <printf>
     512:	83 c4 10             	add    $0x10,%esp
  table = malloc(sizeof(struct uproc) * 64);
     515:	83 ec 0c             	sub    $0xc,%esp
     518:	68 00 17 00 00       	push   $0x1700
     51d:	e8 8f 0f 00 00       	call   14b1 <malloc>
     522:	83 c4 10             	add    $0x10,%esp
     525:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if (!table) {
     528:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     52c:	75 1e                	jne    54c <testcputime+0x56>
    printf(2, "Error: malloc() call failed. %s at line %d\n", __FUNCTION__, __LINE__);
     52e:	68 c3 00 00 00       	push   $0xc3
     533:	68 e4 1b 00 00       	push   $0x1be4
     538:	68 b8 18 00 00       	push   $0x18b8
     53d:	6a 02                	push   $0x2
     53f:	e8 9a 0c 00 00       	call   11de <printf>
     544:	83 c4 10             	add    $0x10,%esp
    exit();
     547:	e8 db 0a 00 00       	call   1027 <exit>
  }
  printf(1, "This will take a couple seconds\n");
     54c:	83 ec 08             	sub    $0x8,%esp
     54f:	68 e4 18 00 00       	push   $0x18e4
     554:	6a 01                	push   $0x1
     556:	e8 83 0c 00 00       	call   11de <printf>
     55b:	83 c4 10             	add    $0x10,%esp

  // Loop for a long time to see if the elapsed CPU_total_ticks is in a reasonable range
  time1 = getcputime(name, table);
     55e:	83 ec 08             	sub    $0x8,%esp
     561:	ff 75 e8             	pushl  -0x18(%ebp)
     564:	ff 75 08             	pushl  0x8(%ebp)
     567:	e8 fa fe ff ff       	call   466 <getcputime>
     56c:	83 c4 10             	add    $0x10,%esp
     56f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(i = 0, num = 0; i < 1000000; ++i){
     572:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     579:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     580:	e9 8a 00 00 00       	jmp    60f <testcputime+0x119>
    ++num;
     585:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    if(num % 100000 == 0){
     589:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     58c:	ba 89 b5 f8 14       	mov    $0x14f8b589,%edx
     591:	89 c8                	mov    %ecx,%eax
     593:	f7 ea                	imul   %edx
     595:	c1 fa 0d             	sar    $0xd,%edx
     598:	89 c8                	mov    %ecx,%eax
     59a:	c1 f8 1f             	sar    $0x1f,%eax
     59d:	29 c2                	sub    %eax,%edx
     59f:	89 d0                	mov    %edx,%eax
     5a1:	69 c0 a0 86 01 00    	imul   $0x186a0,%eax,%eax
     5a7:	29 c1                	sub    %eax,%ecx
     5a9:	89 c8                	mov    %ecx,%eax
     5ab:	85 c0                	test   %eax,%eax
     5ad:	75 5c                	jne    60b <testcputime+0x115>
      pre_sleep = getcputime(name, table);
     5af:	83 ec 08             	sub    $0x8,%esp
     5b2:	ff 75 e8             	pushl  -0x18(%ebp)
     5b5:	ff 75 08             	pushl  0x8(%ebp)
     5b8:	e8 a9 fe ff ff       	call   466 <getcputime>
     5bd:	83 c4 10             	add    $0x10,%esp
     5c0:	89 45 e0             	mov    %eax,-0x20(%ebp)
      sleep(200);
     5c3:	83 ec 0c             	sub    $0xc,%esp
     5c6:	68 c8 00 00 00       	push   $0xc8
     5cb:	e8 e7 0a 00 00       	call   10b7 <sleep>
     5d0:	83 c4 10             	add    $0x10,%esp
      post_sleep = getcputime(name, table);
     5d3:	83 ec 08             	sub    $0x8,%esp
     5d6:	ff 75 e8             	pushl  -0x18(%ebp)
     5d9:	ff 75 08             	pushl  0x8(%ebp)
     5dc:	e8 85 fe ff ff       	call   466 <getcputime>
     5e1:	83 c4 10             	add    $0x10,%esp
     5e4:	89 45 dc             	mov    %eax,-0x24(%ebp)
      if((post_sleep - pre_sleep) >= 100){
     5e7:	8b 45 dc             	mov    -0x24(%ebp),%eax
     5ea:	2b 45 e0             	sub    -0x20(%ebp),%eax
     5ed:	83 f8 63             	cmp    $0x63,%eax
     5f0:	76 19                	jbe    60b <testcputime+0x115>
        printf(2, "FAILED: CPU_total_ticks changed by 100+ milliseconds while process was asleep\n");
     5f2:	83 ec 08             	sub    $0x8,%esp
     5f5:	68 08 19 00 00       	push   $0x1908
     5fa:	6a 02                	push   $0x2
     5fc:	e8 dd 0b 00 00       	call   11de <printf>
     601:	83 c4 10             	add    $0x10,%esp
        success = -1;
     604:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  }
  printf(1, "This will take a couple seconds\n");

  // Loop for a long time to see if the elapsed CPU_total_ticks is in a reasonable range
  time1 = getcputime(name, table);
  for(i = 0, num = 0; i < 1000000; ++i){
     60b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     60f:	81 7d f0 3f 42 0f 00 	cmpl   $0xf423f,-0x10(%ebp)
     616:	0f 8e 69 ff ff ff    	jle    585 <testcputime+0x8f>
        printf(2, "FAILED: CPU_total_ticks changed by 100+ milliseconds while process was asleep\n");
        success = -1;
      }
    }
  }
  time2 = getcputime(name, table);
     61c:	83 ec 08             	sub    $0x8,%esp
     61f:	ff 75 e8             	pushl  -0x18(%ebp)
     622:	ff 75 08             	pushl  0x8(%ebp)
     625:	e8 3c fe ff ff       	call   466 <getcputime>
     62a:	83 c4 10             	add    $0x10,%esp
     62d:	89 45 d8             	mov    %eax,-0x28(%ebp)
  if((time2 - time1) < 0){
    printf(2, "FAILED: difference in CPU_total_ticks is negative.  T2 - T1 = %d\n", (time2 - time1));
    success = -1;
  }
  if((time2 - time1) > 400){
     630:	8b 45 d8             	mov    -0x28(%ebp),%eax
     633:	2b 45 e4             	sub    -0x1c(%ebp),%eax
     636:	3d 90 01 00 00       	cmp    $0x190,%eax
     63b:	76 20                	jbe    65d <testcputime+0x167>
    printf(2, "ABNORMALLY HIGH: T2 - T1 = %d milliseconds.  Run test again\n", (time2 - time1));
     63d:	8b 45 d8             	mov    -0x28(%ebp),%eax
     640:	2b 45 e4             	sub    -0x1c(%ebp),%eax
     643:	83 ec 04             	sub    $0x4,%esp
     646:	50                   	push   %eax
     647:	68 58 19 00 00       	push   $0x1958
     64c:	6a 02                	push   $0x2
     64e:	e8 8b 0b 00 00       	call   11de <printf>
     653:	83 c4 10             	add    $0x10,%esp
    success = -1;
     656:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  }
  printf(1, "T2 - T1 = %d milliseconds\n", (time2 - time1));
     65d:	8b 45 d8             	mov    -0x28(%ebp),%eax
     660:	2b 45 e4             	sub    -0x1c(%ebp),%eax
     663:	83 ec 04             	sub    $0x4,%esp
     666:	50                   	push   %eax
     667:	68 95 19 00 00       	push   $0x1995
     66c:	6a 01                	push   $0x1
     66e:	e8 6b 0b 00 00       	call   11de <printf>
     673:	83 c4 10             	add    $0x10,%esp
  free(table);
     676:	83 ec 0c             	sub    $0xc,%esp
     679:	ff 75 e8             	pushl  -0x18(%ebp)
     67c:	e8 ee 0c 00 00       	call   136f <free>
     681:	83 c4 10             	add    $0x10,%esp

  if(success == 0)
     684:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     688:	75 12                	jne    69c <testcputime+0x1a6>
    printf(1, "** All Tests Passed! **\n");
     68a:	83 ec 08             	sub    $0x8,%esp
     68d:	68 b0 19 00 00       	push   $0x19b0
     692:	6a 01                	push   $0x1
     694:	e8 45 0b 00 00       	call   11de <printf>
     699:	83 c4 10             	add    $0x10,%esp
}
     69c:	90                   	nop
     69d:	c9                   	leave  
     69e:	c3                   	ret    

0000069f <testprocarray>:

#ifdef GETPROCS_TEST
// Fork to 64 process and then make sure we get all when passing table array
// of sizes 1, 16, 64, 72. NOTE: caller does all forks.
static int
testprocarray(int max, int expected_ret){
     69f:	55                   	push   %ebp
     6a0:	89 e5                	mov    %esp,%ebp
     6a2:	83 ec 18             	sub    $0x18,%esp
  struct uproc * table;
  int ret, success = 0;
     6a5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  table = malloc(sizeof(struct uproc) * max);  // bad code, assumes success
     6ac:	8b 45 08             	mov    0x8(%ebp),%eax
     6af:	6b c0 5c             	imul   $0x5c,%eax,%eax
     6b2:	83 ec 0c             	sub    $0xc,%esp
     6b5:	50                   	push   %eax
     6b6:	e8 f6 0d 00 00       	call   14b1 <malloc>
     6bb:	83 c4 10             	add    $0x10,%esp
     6be:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if (!table) {
     6c1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     6c5:	75 1e                	jne    6e5 <testprocarray+0x46>
    printf(2, "Error: malloc() call failed. %s at line %d\n", __FUNCTION__, __LINE__);
     6c7:	68 f2 00 00 00       	push   $0xf2
     6cc:	68 f0 1b 00 00       	push   $0x1bf0
     6d1:	68 b8 18 00 00       	push   $0x18b8
     6d6:	6a 02                	push   $0x2
     6d8:	e8 01 0b 00 00       	call   11de <printf>
     6dd:	83 c4 10             	add    $0x10,%esp
    exit();
     6e0:	e8 42 09 00 00       	call   1027 <exit>
  }
  ret = getprocs(max, table);
     6e5:	8b 45 08             	mov    0x8(%ebp),%eax
     6e8:	83 ec 08             	sub    $0x8,%esp
     6eb:	ff 75 f0             	pushl  -0x10(%ebp)
     6ee:	50                   	push   %eax
     6ef:	e8 0b 0a 00 00       	call   10ff <getprocs>
     6f4:	83 c4 10             	add    $0x10,%esp
     6f7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if (ret != expected_ret){
     6fa:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6fd:	3b 45 0c             	cmp    0xc(%ebp),%eax
     700:	74 24                	je     726 <testprocarray+0x87>
    printf(2, "FAILED: getprocs(%d) returned %d, expected %d\n", max, ret, expected_ret);
     702:	83 ec 0c             	sub    $0xc,%esp
     705:	ff 75 0c             	pushl  0xc(%ebp)
     708:	ff 75 ec             	pushl  -0x14(%ebp)
     70b:	ff 75 08             	pushl  0x8(%ebp)
     70e:	68 cc 19 00 00       	push   $0x19cc
     713:	6a 02                	push   $0x2
     715:	e8 c4 0a 00 00       	call   11de <printf>
     71a:	83 c4 20             	add    $0x20,%esp
    success = -1;
     71d:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
     724:	eb 15                	jmp    73b <testprocarray+0x9c>
  }
  else{
    printf(2, "getprocs() was asked for %d processes and returned %d. SUCCESS\n", max, expected_ret);
     726:	ff 75 0c             	pushl  0xc(%ebp)
     729:	ff 75 08             	pushl  0x8(%ebp)
     72c:	68 fc 19 00 00       	push   $0x19fc
     731:	6a 02                	push   $0x2
     733:	e8 a6 0a 00 00       	call   11de <printf>
     738:	83 c4 10             	add    $0x10,%esp
  }
  free(table);
     73b:	83 ec 0c             	sub    $0xc,%esp
     73e:	ff 75 f0             	pushl  -0x10(%ebp)
     741:	e8 29 0c 00 00       	call   136f <free>
     746:	83 c4 10             	add    $0x10,%esp
  return success;
     749:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     74c:	c9                   	leave  
     74d:	c3                   	ret    

0000074e <testinvalidarray>:

static int
testinvalidarray(void){
     74e:	55                   	push   %ebp
     74f:	89 e5                	mov    %esp,%ebp
     751:	83 ec 18             	sub    $0x18,%esp
  struct uproc * table;
  int ret;

  table = malloc(sizeof(struct uproc));
     754:	83 ec 0c             	sub    $0xc,%esp
     757:	6a 5c                	push   $0x5c
     759:	e8 53 0d 00 00       	call   14b1 <malloc>
     75e:	83 c4 10             	add    $0x10,%esp
     761:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if (!table) {
     764:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     768:	75 1e                	jne    788 <testinvalidarray+0x3a>
    printf(2, "Error: malloc() call failed. %s at line %d\n", __FUNCTION__, __LINE__);
     76a:	68 08 01 00 00       	push   $0x108
     76f:	68 00 1c 00 00       	push   $0x1c00
     774:	68 b8 18 00 00       	push   $0x18b8
     779:	6a 02                	push   $0x2
     77b:	e8 5e 0a 00 00       	call   11de <printf>
     780:	83 c4 10             	add    $0x10,%esp
    exit();
     783:	e8 9f 08 00 00       	call   1027 <exit>
  }
  ret = getprocs(1024, table);
     788:	83 ec 08             	sub    $0x8,%esp
     78b:	ff 75 f4             	pushl  -0xc(%ebp)
     78e:	68 00 04 00 00       	push   $0x400
     793:	e8 67 09 00 00       	call   10ff <getprocs>
     798:	83 c4 10             	add    $0x10,%esp
     79b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  free(table);
     79e:	83 ec 0c             	sub    $0xc,%esp
     7a1:	ff 75 f4             	pushl  -0xc(%ebp)
     7a4:	e8 c6 0b 00 00       	call   136f <free>
     7a9:	83 c4 10             	add    $0x10,%esp
  if(ret >= 0){
     7ac:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     7b0:	78 1c                	js     7ce <testinvalidarray+0x80>
    printf(2, "FAILED: called getprocs with max way larger than table and returned %d, not error\n", ret);
     7b2:	83 ec 04             	sub    $0x4,%esp
     7b5:	ff 75 f0             	pushl  -0x10(%ebp)
     7b8:	68 3c 1a 00 00       	push   $0x1a3c
     7bd:	6a 02                	push   $0x2
     7bf:	e8 1a 0a 00 00       	call   11de <printf>
     7c4:	83 c4 10             	add    $0x10,%esp
    return -1;
     7c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     7cc:	eb 05                	jmp    7d3 <testinvalidarray+0x85>
  }
  return 0;
     7ce:	b8 00 00 00 00       	mov    $0x0,%eax
}
     7d3:	c9                   	leave  
     7d4:	c3                   	ret    

000007d5 <testgetprocs>:

static void
testgetprocs(){
     7d5:	55                   	push   %ebp
     7d6:	89 e5                	mov    %esp,%ebp
     7d8:	83 ec 18             	sub    $0x18,%esp
  int ret, success;

  printf(1, "\n----------\nRunning GetProcs Test\n----------\n");
     7db:	83 ec 08             	sub    $0x8,%esp
     7de:	68 90 1a 00 00       	push   $0x1a90
     7e3:	6a 01                	push   $0x1
     7e5:	e8 f4 09 00 00       	call   11de <printf>
     7ea:	83 c4 10             	add    $0x10,%esp
  printf(1, "Filling the proc[] array with dummy processes\n");
     7ed:	83 ec 08             	sub    $0x8,%esp
     7f0:	68 c0 1a 00 00       	push   $0x1ac0
     7f5:	6a 01                	push   $0x1
     7f7:	e8 e2 09 00 00       	call   11de <printf>
     7fc:	83 c4 10             	add    $0x10,%esp
  // Fork until no space left in ptable
  ret = fork();
     7ff:	e8 1b 08 00 00       	call   101f <fork>
     804:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if (ret == 0){
     807:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     80b:	0f 85 8b 00 00 00    	jne    89c <testgetprocs+0xc7>
    while((ret = fork()) == 0);
     811:	e8 09 08 00 00       	call   101f <fork>
     816:	89 45 f4             	mov    %eax,-0xc(%ebp)
     819:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     81d:	74 f2                	je     811 <testgetprocs+0x3c>
    if(ret > 0){
     81f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     823:	7e 0a                	jle    82f <testgetprocs+0x5a>
      wait();
     825:	e8 05 08 00 00       	call   102f <wait>
      exit();
     82a:	e8 f8 07 00 00       	call   1027 <exit>
    }
    // Only return left is -1, which is no space left in ptable
    success  = testinvalidarray();
     82f:	e8 1a ff ff ff       	call   74e <testinvalidarray>
     834:	89 45 f0             	mov    %eax,-0x10(%ebp)
    success |= testprocarray( 1,  1);
     837:	83 ec 08             	sub    $0x8,%esp
     83a:	6a 01                	push   $0x1
     83c:	6a 01                	push   $0x1
     83e:	e8 5c fe ff ff       	call   69f <testprocarray>
     843:	83 c4 10             	add    $0x10,%esp
     846:	09 45 f0             	or     %eax,-0x10(%ebp)
    success |= testprocarray(16, 16);
     849:	83 ec 08             	sub    $0x8,%esp
     84c:	6a 10                	push   $0x10
     84e:	6a 10                	push   $0x10
     850:	e8 4a fe ff ff       	call   69f <testprocarray>
     855:	83 c4 10             	add    $0x10,%esp
     858:	09 45 f0             	or     %eax,-0x10(%ebp)
    success |= testprocarray(64, 64);
     85b:	83 ec 08             	sub    $0x8,%esp
     85e:	6a 40                	push   $0x40
     860:	6a 40                	push   $0x40
     862:	e8 38 fe ff ff       	call   69f <testprocarray>
     867:	83 c4 10             	add    $0x10,%esp
     86a:	09 45 f0             	or     %eax,-0x10(%ebp)
    success |= testprocarray(72, 64);
     86d:	83 ec 08             	sub    $0x8,%esp
     870:	6a 40                	push   $0x40
     872:	6a 48                	push   $0x48
     874:	e8 26 fe ff ff       	call   69f <testprocarray>
     879:	83 c4 10             	add    $0x10,%esp
     87c:	09 45 f0             	or     %eax,-0x10(%ebp)
    if (success == 0)
     87f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     883:	75 12                	jne    897 <testgetprocs+0xc2>
      printf(1, "** All Tests Passed **\n");
     885:	83 ec 08             	sub    $0x8,%esp
     888:	68 ef 1a 00 00       	push   $0x1aef
     88d:	6a 01                	push   $0x1
     88f:	e8 4a 09 00 00       	call   11de <printf>
     894:	83 c4 10             	add    $0x10,%esp
    exit();
     897:	e8 8b 07 00 00       	call   1027 <exit>
  }
  wait();
     89c:	e8 8e 07 00 00       	call   102f <wait>
}
     8a1:	90                   	nop
     8a2:	c9                   	leave  
     8a3:	c3                   	ret    

000008a4 <testtimewitharg>:
#endif

#ifdef TIME_TEST
// Forks a process and execs with time + args to see how it handles no args, invalid args, mulitple args
void
testtimewitharg(char **arg){
     8a4:	55                   	push   %ebp
     8a5:	89 e5                	mov    %esp,%ebp
     8a7:	83 ec 18             	sub    $0x18,%esp
  int ret;

  ret = fork();
     8aa:	e8 70 07 00 00       	call   101f <fork>
     8af:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if (ret == 0){
     8b2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     8b6:	75 31                	jne    8e9 <testtimewitharg+0x45>
    exec(arg[0], arg);
     8b8:	8b 45 08             	mov    0x8(%ebp),%eax
     8bb:	8b 00                	mov    (%eax),%eax
     8bd:	83 ec 08             	sub    $0x8,%esp
     8c0:	ff 75 08             	pushl  0x8(%ebp)
     8c3:	50                   	push   %eax
     8c4:	e8 96 07 00 00       	call   105f <exec>
     8c9:	83 c4 10             	add    $0x10,%esp
    printf(2, "FAILED: exec failed to execute %s\n", arg[0]);
     8cc:	8b 45 08             	mov    0x8(%ebp),%eax
     8cf:	8b 00                	mov    (%eax),%eax
     8d1:	83 ec 04             	sub    $0x4,%esp
     8d4:	50                   	push   %eax
     8d5:	68 08 1b 00 00       	push   $0x1b08
     8da:	6a 02                	push   $0x2
     8dc:	e8 fd 08 00 00       	call   11de <printf>
     8e1:	83 c4 10             	add    $0x10,%esp
    exit();
     8e4:	e8 3e 07 00 00       	call   1027 <exit>
  }
  else if(ret == -1){
     8e9:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     8ed:	75 14                	jne    903 <testtimewitharg+0x5f>
    printf(2, "FAILED: fork failed\n");
     8ef:	83 ec 08             	sub    $0x8,%esp
     8f2:	68 2b 1b 00 00       	push   $0x1b2b
     8f7:	6a 02                	push   $0x2
     8f9:	e8 e0 08 00 00       	call   11de <printf>
     8fe:	83 c4 10             	add    $0x10,%esp
  }
  else
    wait();
}
     901:	eb 05                	jmp    908 <testtimewitharg+0x64>
  }
  else if(ret == -1){
    printf(2, "FAILED: fork failed\n");
  }
  else
    wait();
     903:	e8 27 07 00 00       	call   102f <wait>
}
     908:	90                   	nop
     909:	c9                   	leave  
     90a:	c3                   	ret    

0000090b <testtime>:
void
testtime(void){
     90b:	55                   	push   %ebp
     90c:	89 e5                	mov    %esp,%ebp
     90e:	53                   	push   %ebx
     90f:	83 ec 14             	sub    $0x14,%esp
  char **arg1 = malloc(sizeof(char *));
     912:	83 ec 0c             	sub    $0xc,%esp
     915:	6a 04                	push   $0x4
     917:	e8 95 0b 00 00       	call   14b1 <malloc>
     91c:	83 c4 10             	add    $0x10,%esp
     91f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  char **arg2 = malloc(sizeof(char *)*2);
     922:	83 ec 0c             	sub    $0xc,%esp
     925:	6a 08                	push   $0x8
     927:	e8 85 0b 00 00       	call   14b1 <malloc>
     92c:	83 c4 10             	add    $0x10,%esp
     92f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  char **arg3 = malloc(sizeof(char *)*2);
     932:	83 ec 0c             	sub    $0xc,%esp
     935:	6a 08                	push   $0x8
     937:	e8 75 0b 00 00       	call   14b1 <malloc>
     93c:	83 c4 10             	add    $0x10,%esp
     93f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  char **arg4 = malloc(sizeof(char *)*4);
     942:	83 ec 0c             	sub    $0xc,%esp
     945:	6a 10                	push   $0x10
     947:	e8 65 0b 00 00       	call   14b1 <malloc>
     94c:	83 c4 10             	add    $0x10,%esp
     94f:	89 45 e8             	mov    %eax,-0x18(%ebp)

  arg1[0] = malloc(sizeof(char) * 5);
     952:	83 ec 0c             	sub    $0xc,%esp
     955:	6a 05                	push   $0x5
     957:	e8 55 0b 00 00       	call   14b1 <malloc>
     95c:	83 c4 10             	add    $0x10,%esp
     95f:	89 c2                	mov    %eax,%edx
     961:	8b 45 f4             	mov    -0xc(%ebp),%eax
     964:	89 10                	mov    %edx,(%eax)
  strcpy(arg1[0], "time");
     966:	8b 45 f4             	mov    -0xc(%ebp),%eax
     969:	8b 00                	mov    (%eax),%eax
     96b:	83 ec 08             	sub    $0x8,%esp
     96e:	68 40 1b 00 00       	push   $0x1b40
     973:	50                   	push   %eax
     974:	e8 aa 03 00 00       	call   d23 <strcpy>
     979:	83 c4 10             	add    $0x10,%esp

  arg2[0] = malloc(sizeof(char) * 5);
     97c:	83 ec 0c             	sub    $0xc,%esp
     97f:	6a 05                	push   $0x5
     981:	e8 2b 0b 00 00       	call   14b1 <malloc>
     986:	83 c4 10             	add    $0x10,%esp
     989:	89 c2                	mov    %eax,%edx
     98b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     98e:	89 10                	mov    %edx,(%eax)
  strcpy(arg2[0], "time");
     990:	8b 45 f0             	mov    -0x10(%ebp),%eax
     993:	8b 00                	mov    (%eax),%eax
     995:	83 ec 08             	sub    $0x8,%esp
     998:	68 40 1b 00 00       	push   $0x1b40
     99d:	50                   	push   %eax
     99e:	e8 80 03 00 00       	call   d23 <strcpy>
     9a3:	83 c4 10             	add    $0x10,%esp
  arg2[1] = malloc(sizeof(char) * 4);
     9a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9a9:	8d 58 04             	lea    0x4(%eax),%ebx
     9ac:	83 ec 0c             	sub    $0xc,%esp
     9af:	6a 04                	push   $0x4
     9b1:	e8 fb 0a 00 00       	call   14b1 <malloc>
     9b6:	83 c4 10             	add    $0x10,%esp
     9b9:	89 03                	mov    %eax,(%ebx)
  strcpy(arg2[1], "abc");
     9bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9be:	83 c0 04             	add    $0x4,%eax
     9c1:	8b 00                	mov    (%eax),%eax
     9c3:	83 ec 08             	sub    $0x8,%esp
     9c6:	68 45 1b 00 00       	push   $0x1b45
     9cb:	50                   	push   %eax
     9cc:	e8 52 03 00 00       	call   d23 <strcpy>
     9d1:	83 c4 10             	add    $0x10,%esp

  arg3[0] = malloc(sizeof(char) * 5);
     9d4:	83 ec 0c             	sub    $0xc,%esp
     9d7:	6a 05                	push   $0x5
     9d9:	e8 d3 0a 00 00       	call   14b1 <malloc>
     9de:	83 c4 10             	add    $0x10,%esp
     9e1:	89 c2                	mov    %eax,%edx
     9e3:	8b 45 ec             	mov    -0x14(%ebp),%eax
     9e6:	89 10                	mov    %edx,(%eax)
  strcpy(arg3[0], "time");
     9e8:	8b 45 ec             	mov    -0x14(%ebp),%eax
     9eb:	8b 00                	mov    (%eax),%eax
     9ed:	83 ec 08             	sub    $0x8,%esp
     9f0:	68 40 1b 00 00       	push   $0x1b40
     9f5:	50                   	push   %eax
     9f6:	e8 28 03 00 00       	call   d23 <strcpy>
     9fb:	83 c4 10             	add    $0x10,%esp
  arg3[1] = malloc(sizeof(char) * 5);
     9fe:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a01:	8d 58 04             	lea    0x4(%eax),%ebx
     a04:	83 ec 0c             	sub    $0xc,%esp
     a07:	6a 05                	push   $0x5
     a09:	e8 a3 0a 00 00       	call   14b1 <malloc>
     a0e:	83 c4 10             	add    $0x10,%esp
     a11:	89 03                	mov    %eax,(%ebx)
  strcpy(arg3[1], "date");
     a13:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a16:	83 c0 04             	add    $0x4,%eax
     a19:	8b 00                	mov    (%eax),%eax
     a1b:	83 ec 08             	sub    $0x8,%esp
     a1e:	68 49 1b 00 00       	push   $0x1b49
     a23:	50                   	push   %eax
     a24:	e8 fa 02 00 00       	call   d23 <strcpy>
     a29:	83 c4 10             	add    $0x10,%esp

  arg4[0] = malloc(sizeof(char) * 5);
     a2c:	83 ec 0c             	sub    $0xc,%esp
     a2f:	6a 05                	push   $0x5
     a31:	e8 7b 0a 00 00       	call   14b1 <malloc>
     a36:	83 c4 10             	add    $0x10,%esp
     a39:	89 c2                	mov    %eax,%edx
     a3b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     a3e:	89 10                	mov    %edx,(%eax)
  strcpy(arg4[0], "time");
     a40:	8b 45 e8             	mov    -0x18(%ebp),%eax
     a43:	8b 00                	mov    (%eax),%eax
     a45:	83 ec 08             	sub    $0x8,%esp
     a48:	68 40 1b 00 00       	push   $0x1b40
     a4d:	50                   	push   %eax
     a4e:	e8 d0 02 00 00       	call   d23 <strcpy>
     a53:	83 c4 10             	add    $0x10,%esp
  arg4[1] = malloc(sizeof(char) * 5);
     a56:	8b 45 e8             	mov    -0x18(%ebp),%eax
     a59:	8d 58 04             	lea    0x4(%eax),%ebx
     a5c:	83 ec 0c             	sub    $0xc,%esp
     a5f:	6a 05                	push   $0x5
     a61:	e8 4b 0a 00 00       	call   14b1 <malloc>
     a66:	83 c4 10             	add    $0x10,%esp
     a69:	89 03                	mov    %eax,(%ebx)
  strcpy(arg4[1], "time");
     a6b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     a6e:	83 c0 04             	add    $0x4,%eax
     a71:	8b 00                	mov    (%eax),%eax
     a73:	83 ec 08             	sub    $0x8,%esp
     a76:	68 40 1b 00 00       	push   $0x1b40
     a7b:	50                   	push   %eax
     a7c:	e8 a2 02 00 00       	call   d23 <strcpy>
     a81:	83 c4 10             	add    $0x10,%esp
  arg4[2] = malloc(sizeof(char) * 5);
     a84:	8b 45 e8             	mov    -0x18(%ebp),%eax
     a87:	8d 58 08             	lea    0x8(%eax),%ebx
     a8a:	83 ec 0c             	sub    $0xc,%esp
     a8d:	6a 05                	push   $0x5
     a8f:	e8 1d 0a 00 00       	call   14b1 <malloc>
     a94:	83 c4 10             	add    $0x10,%esp
     a97:	89 03                	mov    %eax,(%ebx)
  strcpy(arg4[2], "echo");
     a99:	8b 45 e8             	mov    -0x18(%ebp),%eax
     a9c:	83 c0 08             	add    $0x8,%eax
     a9f:	8b 00                	mov    (%eax),%eax
     aa1:	83 ec 08             	sub    $0x8,%esp
     aa4:	68 4e 1b 00 00       	push   $0x1b4e
     aa9:	50                   	push   %eax
     aaa:	e8 74 02 00 00       	call   d23 <strcpy>
     aaf:	83 c4 10             	add    $0x10,%esp
  arg4[3] = malloc(sizeof(char) * 6);
     ab2:	8b 45 e8             	mov    -0x18(%ebp),%eax
     ab5:	8d 58 0c             	lea    0xc(%eax),%ebx
     ab8:	83 ec 0c             	sub    $0xc,%esp
     abb:	6a 06                	push   $0x6
     abd:	e8 ef 09 00 00       	call   14b1 <malloc>
     ac2:	83 c4 10             	add    $0x10,%esp
     ac5:	89 03                	mov    %eax,(%ebx)
  strcpy(arg4[3], "\"abc\"");
     ac7:	8b 45 e8             	mov    -0x18(%ebp),%eax
     aca:	83 c0 0c             	add    $0xc,%eax
     acd:	8b 00                	mov    (%eax),%eax
     acf:	83 ec 08             	sub    $0x8,%esp
     ad2:	68 53 1b 00 00       	push   $0x1b53
     ad7:	50                   	push   %eax
     ad8:	e8 46 02 00 00       	call   d23 <strcpy>
     add:	83 c4 10             	add    $0x10,%esp

  printf(1, "\n----------\nRunning Time Test\n----------\n");
     ae0:	83 ec 08             	sub    $0x8,%esp
     ae3:	68 5c 1b 00 00       	push   $0x1b5c
     ae8:	6a 01                	push   $0x1
     aea:	e8 ef 06 00 00       	call   11de <printf>
     aef:	83 c4 10             	add    $0x10,%esp
  printf(1, "You will need to verify these tests passed\n");
     af2:	83 ec 08             	sub    $0x8,%esp
     af5:	68 88 1b 00 00       	push   $0x1b88
     afa:	6a 01                	push   $0x1
     afc:	e8 dd 06 00 00       	call   11de <printf>
     b01:	83 c4 10             	add    $0x10,%esp

  printf(1,"\n%s\n", arg1[0]);
     b04:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b07:	8b 00                	mov    (%eax),%eax
     b09:	83 ec 04             	sub    $0x4,%esp
     b0c:	50                   	push   %eax
     b0d:	68 b4 1b 00 00       	push   $0x1bb4
     b12:	6a 01                	push   $0x1
     b14:	e8 c5 06 00 00       	call   11de <printf>
     b19:	83 c4 10             	add    $0x10,%esp
  testtimewitharg(arg1);
     b1c:	83 ec 0c             	sub    $0xc,%esp
     b1f:	ff 75 f4             	pushl  -0xc(%ebp)
     b22:	e8 7d fd ff ff       	call   8a4 <testtimewitharg>
     b27:	83 c4 10             	add    $0x10,%esp
  printf(1,"\n%s %s\n", arg2[0], arg2[1]);
     b2a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b2d:	83 c0 04             	add    $0x4,%eax
     b30:	8b 10                	mov    (%eax),%edx
     b32:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b35:	8b 00                	mov    (%eax),%eax
     b37:	52                   	push   %edx
     b38:	50                   	push   %eax
     b39:	68 b9 1b 00 00       	push   $0x1bb9
     b3e:	6a 01                	push   $0x1
     b40:	e8 99 06 00 00       	call   11de <printf>
     b45:	83 c4 10             	add    $0x10,%esp
  testtimewitharg(arg2);
     b48:	83 ec 0c             	sub    $0xc,%esp
     b4b:	ff 75 f0             	pushl  -0x10(%ebp)
     b4e:	e8 51 fd ff ff       	call   8a4 <testtimewitharg>
     b53:	83 c4 10             	add    $0x10,%esp
  printf(1,"\n%s %s\n", arg3[0], arg3[1]);
     b56:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b59:	83 c0 04             	add    $0x4,%eax
     b5c:	8b 10                	mov    (%eax),%edx
     b5e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b61:	8b 00                	mov    (%eax),%eax
     b63:	52                   	push   %edx
     b64:	50                   	push   %eax
     b65:	68 b9 1b 00 00       	push   $0x1bb9
     b6a:	6a 01                	push   $0x1
     b6c:	e8 6d 06 00 00       	call   11de <printf>
     b71:	83 c4 10             	add    $0x10,%esp
  testtimewitharg(arg3);
     b74:	83 ec 0c             	sub    $0xc,%esp
     b77:	ff 75 ec             	pushl  -0x14(%ebp)
     b7a:	e8 25 fd ff ff       	call   8a4 <testtimewitharg>
     b7f:	83 c4 10             	add    $0x10,%esp
  printf(1,"\n%s %s %s %s\n", arg4[0], arg4[1], arg4[2], arg4[3]);
     b82:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b85:	83 c0 0c             	add    $0xc,%eax
     b88:	8b 18                	mov    (%eax),%ebx
     b8a:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b8d:	83 c0 08             	add    $0x8,%eax
     b90:	8b 08                	mov    (%eax),%ecx
     b92:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b95:	83 c0 04             	add    $0x4,%eax
     b98:	8b 10                	mov    (%eax),%edx
     b9a:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b9d:	8b 00                	mov    (%eax),%eax
     b9f:	83 ec 08             	sub    $0x8,%esp
     ba2:	53                   	push   %ebx
     ba3:	51                   	push   %ecx
     ba4:	52                   	push   %edx
     ba5:	50                   	push   %eax
     ba6:	68 c1 1b 00 00       	push   $0x1bc1
     bab:	6a 01                	push   $0x1
     bad:	e8 2c 06 00 00       	call   11de <printf>
     bb2:	83 c4 20             	add    $0x20,%esp
  testtimewitharg(arg4);
     bb5:	83 ec 0c             	sub    $0xc,%esp
     bb8:	ff 75 e8             	pushl  -0x18(%ebp)
     bbb:	e8 e4 fc ff ff       	call   8a4 <testtimewitharg>
     bc0:	83 c4 10             	add    $0x10,%esp

  free(arg1[0]);
     bc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bc6:	8b 00                	mov    (%eax),%eax
     bc8:	83 ec 0c             	sub    $0xc,%esp
     bcb:	50                   	push   %eax
     bcc:	e8 9e 07 00 00       	call   136f <free>
     bd1:	83 c4 10             	add    $0x10,%esp
  free(arg1);
     bd4:	83 ec 0c             	sub    $0xc,%esp
     bd7:	ff 75 f4             	pushl  -0xc(%ebp)
     bda:	e8 90 07 00 00       	call   136f <free>
     bdf:	83 c4 10             	add    $0x10,%esp
  free(arg2[0]); free(arg2[1]);
     be2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     be5:	8b 00                	mov    (%eax),%eax
     be7:	83 ec 0c             	sub    $0xc,%esp
     bea:	50                   	push   %eax
     beb:	e8 7f 07 00 00       	call   136f <free>
     bf0:	83 c4 10             	add    $0x10,%esp
     bf3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bf6:	83 c0 04             	add    $0x4,%eax
     bf9:	8b 00                	mov    (%eax),%eax
     bfb:	83 ec 0c             	sub    $0xc,%esp
     bfe:	50                   	push   %eax
     bff:	e8 6b 07 00 00       	call   136f <free>
     c04:	83 c4 10             	add    $0x10,%esp
  free(arg2);
     c07:	83 ec 0c             	sub    $0xc,%esp
     c0a:	ff 75 f0             	pushl  -0x10(%ebp)
     c0d:	e8 5d 07 00 00       	call   136f <free>
     c12:	83 c4 10             	add    $0x10,%esp
  free(arg3[0]); free(arg3[1]);
     c15:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c18:	8b 00                	mov    (%eax),%eax
     c1a:	83 ec 0c             	sub    $0xc,%esp
     c1d:	50                   	push   %eax
     c1e:	e8 4c 07 00 00       	call   136f <free>
     c23:	83 c4 10             	add    $0x10,%esp
     c26:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c29:	83 c0 04             	add    $0x4,%eax
     c2c:	8b 00                	mov    (%eax),%eax
     c2e:	83 ec 0c             	sub    $0xc,%esp
     c31:	50                   	push   %eax
     c32:	e8 38 07 00 00       	call   136f <free>
     c37:	83 c4 10             	add    $0x10,%esp
  free(arg3);
     c3a:	83 ec 0c             	sub    $0xc,%esp
     c3d:	ff 75 ec             	pushl  -0x14(%ebp)
     c40:	e8 2a 07 00 00       	call   136f <free>
     c45:	83 c4 10             	add    $0x10,%esp
  free(arg4[0]); free(arg4[1]); free(arg4[2]); free(arg4[3]);
     c48:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c4b:	8b 00                	mov    (%eax),%eax
     c4d:	83 ec 0c             	sub    $0xc,%esp
     c50:	50                   	push   %eax
     c51:	e8 19 07 00 00       	call   136f <free>
     c56:	83 c4 10             	add    $0x10,%esp
     c59:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c5c:	83 c0 04             	add    $0x4,%eax
     c5f:	8b 00                	mov    (%eax),%eax
     c61:	83 ec 0c             	sub    $0xc,%esp
     c64:	50                   	push   %eax
     c65:	e8 05 07 00 00       	call   136f <free>
     c6a:	83 c4 10             	add    $0x10,%esp
     c6d:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c70:	83 c0 08             	add    $0x8,%eax
     c73:	8b 00                	mov    (%eax),%eax
     c75:	83 ec 0c             	sub    $0xc,%esp
     c78:	50                   	push   %eax
     c79:	e8 f1 06 00 00       	call   136f <free>
     c7e:	83 c4 10             	add    $0x10,%esp
     c81:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c84:	83 c0 0c             	add    $0xc,%eax
     c87:	8b 00                	mov    (%eax),%eax
     c89:	83 ec 0c             	sub    $0xc,%esp
     c8c:	50                   	push   %eax
     c8d:	e8 dd 06 00 00       	call   136f <free>
     c92:	83 c4 10             	add    $0x10,%esp
  free(arg4);
     c95:	83 ec 0c             	sub    $0xc,%esp
     c98:	ff 75 e8             	pushl  -0x18(%ebp)
     c9b:	e8 cf 06 00 00       	call   136f <free>
     ca0:	83 c4 10             	add    $0x10,%esp
}
     ca3:	90                   	nop
     ca4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ca7:	c9                   	leave  
     ca8:	c3                   	ret    

00000ca9 <main>:
#endif

  int
main(int argc, char *argv[])
{
     ca9:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     cad:	83 e4 f0             	and    $0xfffffff0,%esp
     cb0:	ff 71 fc             	pushl  -0x4(%ecx)
     cb3:	55                   	push   %ebp
     cb4:	89 e5                	mov    %esp,%ebp
     cb6:	51                   	push   %ecx
     cb7:	83 ec 04             	sub    $0x4,%esp
     cba:	89 c8                	mov    %ecx,%eax
#ifdef CPUTIME_TEST
  testcputime(argv[0]);
     cbc:	8b 40 04             	mov    0x4(%eax),%eax
     cbf:	8b 00                	mov    (%eax),%eax
     cc1:	83 ec 0c             	sub    $0xc,%esp
     cc4:	50                   	push   %eax
     cc5:	e8 2c f8 ff ff       	call   4f6 <testcputime>
     cca:	83 c4 10             	add    $0x10,%esp
#endif
#ifdef UIDGIDPPID_TEST
  testuidgid();
     ccd:	e8 d6 f4 ff ff       	call   1a8 <testuidgid>
  testuidgidinheritance();
     cd2:	e8 a7 f6 ff ff       	call   37e <testuidgidinheritance>
  testppid();
     cd7:	e8 24 f3 ff ff       	call   0 <testppid>
#endif
#ifdef GETPROCS_TEST
  testgetprocs();  // no need to pass argv[0]
     cdc:	e8 f4 fa ff ff       	call   7d5 <testgetprocs>
#endif
#ifdef TIME_TEST
  testtime();
     ce1:	e8 25 fc ff ff       	call   90b <testtime>
#endif
  printf(1, "\n** End of Tests **\n");
     ce6:	83 ec 08             	sub    $0x8,%esp
     ce9:	68 cf 1b 00 00       	push   $0x1bcf
     cee:	6a 01                	push   $0x1
     cf0:	e8 e9 04 00 00       	call   11de <printf>
     cf5:	83 c4 10             	add    $0x10,%esp
  exit();
     cf8:	e8 2a 03 00 00       	call   1027 <exit>

00000cfd <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     cfd:	55                   	push   %ebp
     cfe:	89 e5                	mov    %esp,%ebp
     d00:	57                   	push   %edi
     d01:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     d02:	8b 4d 08             	mov    0x8(%ebp),%ecx
     d05:	8b 55 10             	mov    0x10(%ebp),%edx
     d08:	8b 45 0c             	mov    0xc(%ebp),%eax
     d0b:	89 cb                	mov    %ecx,%ebx
     d0d:	89 df                	mov    %ebx,%edi
     d0f:	89 d1                	mov    %edx,%ecx
     d11:	fc                   	cld    
     d12:	f3 aa                	rep stos %al,%es:(%edi)
     d14:	89 ca                	mov    %ecx,%edx
     d16:	89 fb                	mov    %edi,%ebx
     d18:	89 5d 08             	mov    %ebx,0x8(%ebp)
     d1b:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     d1e:	90                   	nop
     d1f:	5b                   	pop    %ebx
     d20:	5f                   	pop    %edi
     d21:	5d                   	pop    %ebp
     d22:	c3                   	ret    

00000d23 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     d23:	55                   	push   %ebp
     d24:	89 e5                	mov    %esp,%ebp
     d26:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     d29:	8b 45 08             	mov    0x8(%ebp),%eax
     d2c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     d2f:	90                   	nop
     d30:	8b 45 08             	mov    0x8(%ebp),%eax
     d33:	8d 50 01             	lea    0x1(%eax),%edx
     d36:	89 55 08             	mov    %edx,0x8(%ebp)
     d39:	8b 55 0c             	mov    0xc(%ebp),%edx
     d3c:	8d 4a 01             	lea    0x1(%edx),%ecx
     d3f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     d42:	0f b6 12             	movzbl (%edx),%edx
     d45:	88 10                	mov    %dl,(%eax)
     d47:	0f b6 00             	movzbl (%eax),%eax
     d4a:	84 c0                	test   %al,%al
     d4c:	75 e2                	jne    d30 <strcpy+0xd>
    ;
  return os;
     d4e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     d51:	c9                   	leave  
     d52:	c3                   	ret    

00000d53 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     d53:	55                   	push   %ebp
     d54:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     d56:	eb 08                	jmp    d60 <strcmp+0xd>
    p++, q++;
     d58:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     d5c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     d60:	8b 45 08             	mov    0x8(%ebp),%eax
     d63:	0f b6 00             	movzbl (%eax),%eax
     d66:	84 c0                	test   %al,%al
     d68:	74 10                	je     d7a <strcmp+0x27>
     d6a:	8b 45 08             	mov    0x8(%ebp),%eax
     d6d:	0f b6 10             	movzbl (%eax),%edx
     d70:	8b 45 0c             	mov    0xc(%ebp),%eax
     d73:	0f b6 00             	movzbl (%eax),%eax
     d76:	38 c2                	cmp    %al,%dl
     d78:	74 de                	je     d58 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     d7a:	8b 45 08             	mov    0x8(%ebp),%eax
     d7d:	0f b6 00             	movzbl (%eax),%eax
     d80:	0f b6 d0             	movzbl %al,%edx
     d83:	8b 45 0c             	mov    0xc(%ebp),%eax
     d86:	0f b6 00             	movzbl (%eax),%eax
     d89:	0f b6 c0             	movzbl %al,%eax
     d8c:	29 c2                	sub    %eax,%edx
     d8e:	89 d0                	mov    %edx,%eax
}
     d90:	5d                   	pop    %ebp
     d91:	c3                   	ret    

00000d92 <strlen>:

uint
strlen(char *s)
{
     d92:	55                   	push   %ebp
     d93:	89 e5                	mov    %esp,%ebp
     d95:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     d98:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     d9f:	eb 04                	jmp    da5 <strlen+0x13>
     da1:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     da5:	8b 55 fc             	mov    -0x4(%ebp),%edx
     da8:	8b 45 08             	mov    0x8(%ebp),%eax
     dab:	01 d0                	add    %edx,%eax
     dad:	0f b6 00             	movzbl (%eax),%eax
     db0:	84 c0                	test   %al,%al
     db2:	75 ed                	jne    da1 <strlen+0xf>
    ;
  return n;
     db4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     db7:	c9                   	leave  
     db8:	c3                   	ret    

00000db9 <memset>:

void*
memset(void *dst, int c, uint n)
{
     db9:	55                   	push   %ebp
     dba:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     dbc:	8b 45 10             	mov    0x10(%ebp),%eax
     dbf:	50                   	push   %eax
     dc0:	ff 75 0c             	pushl  0xc(%ebp)
     dc3:	ff 75 08             	pushl  0x8(%ebp)
     dc6:	e8 32 ff ff ff       	call   cfd <stosb>
     dcb:	83 c4 0c             	add    $0xc,%esp
  return dst;
     dce:	8b 45 08             	mov    0x8(%ebp),%eax
}
     dd1:	c9                   	leave  
     dd2:	c3                   	ret    

00000dd3 <strchr>:

char*
strchr(const char *s, char c)
{
     dd3:	55                   	push   %ebp
     dd4:	89 e5                	mov    %esp,%ebp
     dd6:	83 ec 04             	sub    $0x4,%esp
     dd9:	8b 45 0c             	mov    0xc(%ebp),%eax
     ddc:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     ddf:	eb 14                	jmp    df5 <strchr+0x22>
    if(*s == c)
     de1:	8b 45 08             	mov    0x8(%ebp),%eax
     de4:	0f b6 00             	movzbl (%eax),%eax
     de7:	3a 45 fc             	cmp    -0x4(%ebp),%al
     dea:	75 05                	jne    df1 <strchr+0x1e>
      return (char*)s;
     dec:	8b 45 08             	mov    0x8(%ebp),%eax
     def:	eb 13                	jmp    e04 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     df1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     df5:	8b 45 08             	mov    0x8(%ebp),%eax
     df8:	0f b6 00             	movzbl (%eax),%eax
     dfb:	84 c0                	test   %al,%al
     dfd:	75 e2                	jne    de1 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     dff:	b8 00 00 00 00       	mov    $0x0,%eax
}
     e04:	c9                   	leave  
     e05:	c3                   	ret    

00000e06 <gets>:

char*
gets(char *buf, int max)
{
     e06:	55                   	push   %ebp
     e07:	89 e5                	mov    %esp,%ebp
     e09:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     e0c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     e13:	eb 42                	jmp    e57 <gets+0x51>
    cc = read(0, &c, 1);
     e15:	83 ec 04             	sub    $0x4,%esp
     e18:	6a 01                	push   $0x1
     e1a:	8d 45 ef             	lea    -0x11(%ebp),%eax
     e1d:	50                   	push   %eax
     e1e:	6a 00                	push   $0x0
     e20:	e8 1a 02 00 00       	call   103f <read>
     e25:	83 c4 10             	add    $0x10,%esp
     e28:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     e2b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     e2f:	7e 33                	jle    e64 <gets+0x5e>
      break;
    buf[i++] = c;
     e31:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e34:	8d 50 01             	lea    0x1(%eax),%edx
     e37:	89 55 f4             	mov    %edx,-0xc(%ebp)
     e3a:	89 c2                	mov    %eax,%edx
     e3c:	8b 45 08             	mov    0x8(%ebp),%eax
     e3f:	01 c2                	add    %eax,%edx
     e41:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     e45:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     e47:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     e4b:	3c 0a                	cmp    $0xa,%al
     e4d:	74 16                	je     e65 <gets+0x5f>
     e4f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     e53:	3c 0d                	cmp    $0xd,%al
     e55:	74 0e                	je     e65 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     e57:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e5a:	83 c0 01             	add    $0x1,%eax
     e5d:	3b 45 0c             	cmp    0xc(%ebp),%eax
     e60:	7c b3                	jl     e15 <gets+0xf>
     e62:	eb 01                	jmp    e65 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     e64:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     e65:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e68:	8b 45 08             	mov    0x8(%ebp),%eax
     e6b:	01 d0                	add    %edx,%eax
     e6d:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     e70:	8b 45 08             	mov    0x8(%ebp),%eax
}
     e73:	c9                   	leave  
     e74:	c3                   	ret    

00000e75 <stat>:

int
stat(char *n, struct stat *st)
{
     e75:	55                   	push   %ebp
     e76:	89 e5                	mov    %esp,%ebp
     e78:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     e7b:	83 ec 08             	sub    $0x8,%esp
     e7e:	6a 00                	push   $0x0
     e80:	ff 75 08             	pushl  0x8(%ebp)
     e83:	e8 df 01 00 00       	call   1067 <open>
     e88:	83 c4 10             	add    $0x10,%esp
     e8b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     e8e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     e92:	79 07                	jns    e9b <stat+0x26>
    return -1;
     e94:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     e99:	eb 25                	jmp    ec0 <stat+0x4b>
  r = fstat(fd, st);
     e9b:	83 ec 08             	sub    $0x8,%esp
     e9e:	ff 75 0c             	pushl  0xc(%ebp)
     ea1:	ff 75 f4             	pushl  -0xc(%ebp)
     ea4:	e8 d6 01 00 00       	call   107f <fstat>
     ea9:	83 c4 10             	add    $0x10,%esp
     eac:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     eaf:	83 ec 0c             	sub    $0xc,%esp
     eb2:	ff 75 f4             	pushl  -0xc(%ebp)
     eb5:	e8 95 01 00 00       	call   104f <close>
     eba:	83 c4 10             	add    $0x10,%esp
  return r;
     ebd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     ec0:	c9                   	leave  
     ec1:	c3                   	ret    

00000ec2 <atoi>:

int
atoi(const char *s)
{
     ec2:	55                   	push   %ebp
     ec3:	89 e5                	mov    %esp,%ebp
     ec5:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
     ec8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
     ecf:	eb 04                	jmp    ed5 <atoi+0x13>
     ed1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     ed5:	8b 45 08             	mov    0x8(%ebp),%eax
     ed8:	0f b6 00             	movzbl (%eax),%eax
     edb:	3c 20                	cmp    $0x20,%al
     edd:	74 f2                	je     ed1 <atoi+0xf>
  sign = (*s == '-') ? -1 : 1;
     edf:	8b 45 08             	mov    0x8(%ebp),%eax
     ee2:	0f b6 00             	movzbl (%eax),%eax
     ee5:	3c 2d                	cmp    $0x2d,%al
     ee7:	75 07                	jne    ef0 <atoi+0x2e>
     ee9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     eee:	eb 05                	jmp    ef5 <atoi+0x33>
     ef0:	b8 01 00 00 00       	mov    $0x1,%eax
     ef5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
     ef8:	8b 45 08             	mov    0x8(%ebp),%eax
     efb:	0f b6 00             	movzbl (%eax),%eax
     efe:	3c 2b                	cmp    $0x2b,%al
     f00:	74 0a                	je     f0c <atoi+0x4a>
     f02:	8b 45 08             	mov    0x8(%ebp),%eax
     f05:	0f b6 00             	movzbl (%eax),%eax
     f08:	3c 2d                	cmp    $0x2d,%al
     f0a:	75 2b                	jne    f37 <atoi+0x75>
    s++;
     f0c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '9')
     f10:	eb 25                	jmp    f37 <atoi+0x75>
    n = n*10 + *s++ - '0';
     f12:	8b 55 fc             	mov    -0x4(%ebp),%edx
     f15:	89 d0                	mov    %edx,%eax
     f17:	c1 e0 02             	shl    $0x2,%eax
     f1a:	01 d0                	add    %edx,%eax
     f1c:	01 c0                	add    %eax,%eax
     f1e:	89 c1                	mov    %eax,%ecx
     f20:	8b 45 08             	mov    0x8(%ebp),%eax
     f23:	8d 50 01             	lea    0x1(%eax),%edx
     f26:	89 55 08             	mov    %edx,0x8(%ebp)
     f29:	0f b6 00             	movzbl (%eax),%eax
     f2c:	0f be c0             	movsbl %al,%eax
     f2f:	01 c8                	add    %ecx,%eax
     f31:	83 e8 30             	sub    $0x30,%eax
     f34:	89 45 fc             	mov    %eax,-0x4(%ebp)
  n = 0;
  while (*s == ' ') s++;
  sign = (*s == '-') ? -1 : 1;
  if (*s == '+'  || *s == '-')
    s++;
  while('0' <= *s && *s <= '9')
     f37:	8b 45 08             	mov    0x8(%ebp),%eax
     f3a:	0f b6 00             	movzbl (%eax),%eax
     f3d:	3c 2f                	cmp    $0x2f,%al
     f3f:	7e 0a                	jle    f4b <atoi+0x89>
     f41:	8b 45 08             	mov    0x8(%ebp),%eax
     f44:	0f b6 00             	movzbl (%eax),%eax
     f47:	3c 39                	cmp    $0x39,%al
     f49:	7e c7                	jle    f12 <atoi+0x50>
    n = n*10 + *s++ - '0';
  return sign*n;
     f4b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     f4e:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
     f52:	c9                   	leave  
     f53:	c3                   	ret    

00000f54 <atoo>:

int
atoo(const char *s)
{
     f54:	55                   	push   %ebp
     f55:	89 e5                	mov    %esp,%ebp
     f57:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
     f5a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
     f61:	eb 04                	jmp    f67 <atoo+0x13>
     f63:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     f67:	8b 45 08             	mov    0x8(%ebp),%eax
     f6a:	0f b6 00             	movzbl (%eax),%eax
     f6d:	3c 20                	cmp    $0x20,%al
     f6f:	74 f2                	je     f63 <atoo+0xf>
  sign = (*s == '-') ? -1 : 1;
     f71:	8b 45 08             	mov    0x8(%ebp),%eax
     f74:	0f b6 00             	movzbl (%eax),%eax
     f77:	3c 2d                	cmp    $0x2d,%al
     f79:	75 07                	jne    f82 <atoo+0x2e>
     f7b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     f80:	eb 05                	jmp    f87 <atoo+0x33>
     f82:	b8 01 00 00 00       	mov    $0x1,%eax
     f87:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
     f8a:	8b 45 08             	mov    0x8(%ebp),%eax
     f8d:	0f b6 00             	movzbl (%eax),%eax
     f90:	3c 2b                	cmp    $0x2b,%al
     f92:	74 0a                	je     f9e <atoo+0x4a>
     f94:	8b 45 08             	mov    0x8(%ebp),%eax
     f97:	0f b6 00             	movzbl (%eax),%eax
     f9a:	3c 2d                	cmp    $0x2d,%al
     f9c:	75 27                	jne    fc5 <atoo+0x71>
    s++;
     f9e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '7')
     fa2:	eb 21                	jmp    fc5 <atoo+0x71>
    n = n*8 + *s++ - '0';
     fa4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     fa7:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
     fae:	8b 45 08             	mov    0x8(%ebp),%eax
     fb1:	8d 50 01             	lea    0x1(%eax),%edx
     fb4:	89 55 08             	mov    %edx,0x8(%ebp)
     fb7:	0f b6 00             	movzbl (%eax),%eax
     fba:	0f be c0             	movsbl %al,%eax
     fbd:	01 c8                	add    %ecx,%eax
     fbf:	83 e8 30             	sub    $0x30,%eax
     fc2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  n = 0;
  while (*s == ' ') s++;
  sign = (*s == '-') ? -1 : 1;
  if (*s == '+'  || *s == '-')
    s++;
  while('0' <= *s && *s <= '7')
     fc5:	8b 45 08             	mov    0x8(%ebp),%eax
     fc8:	0f b6 00             	movzbl (%eax),%eax
     fcb:	3c 2f                	cmp    $0x2f,%al
     fcd:	7e 0a                	jle    fd9 <atoo+0x85>
     fcf:	8b 45 08             	mov    0x8(%ebp),%eax
     fd2:	0f b6 00             	movzbl (%eax),%eax
     fd5:	3c 37                	cmp    $0x37,%al
     fd7:	7e cb                	jle    fa4 <atoo+0x50>
    n = n*8 + *s++ - '0';
  return sign*n;
     fd9:	8b 45 f8             	mov    -0x8(%ebp),%eax
     fdc:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
     fe0:	c9                   	leave  
     fe1:	c3                   	ret    

00000fe2 <memmove>:


void*
memmove(void *vdst, void *vsrc, int n)
{
     fe2:	55                   	push   %ebp
     fe3:	89 e5                	mov    %esp,%ebp
     fe5:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     fe8:	8b 45 08             	mov    0x8(%ebp),%eax
     feb:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     fee:	8b 45 0c             	mov    0xc(%ebp),%eax
     ff1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     ff4:	eb 17                	jmp    100d <memmove+0x2b>
    *dst++ = *src++;
     ff6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ff9:	8d 50 01             	lea    0x1(%eax),%edx
     ffc:	89 55 fc             	mov    %edx,-0x4(%ebp)
     fff:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1002:	8d 4a 01             	lea    0x1(%edx),%ecx
    1005:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    1008:	0f b6 12             	movzbl (%edx),%edx
    100b:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    100d:	8b 45 10             	mov    0x10(%ebp),%eax
    1010:	8d 50 ff             	lea    -0x1(%eax),%edx
    1013:	89 55 10             	mov    %edx,0x10(%ebp)
    1016:	85 c0                	test   %eax,%eax
    1018:	7f dc                	jg     ff6 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    101a:	8b 45 08             	mov    0x8(%ebp),%eax
}
    101d:	c9                   	leave  
    101e:	c3                   	ret    

0000101f <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    101f:	b8 01 00 00 00       	mov    $0x1,%eax
    1024:	cd 40                	int    $0x40
    1026:	c3                   	ret    

00001027 <exit>:
SYSCALL(exit)
    1027:	b8 02 00 00 00       	mov    $0x2,%eax
    102c:	cd 40                	int    $0x40
    102e:	c3                   	ret    

0000102f <wait>:
SYSCALL(wait)
    102f:	b8 03 00 00 00       	mov    $0x3,%eax
    1034:	cd 40                	int    $0x40
    1036:	c3                   	ret    

00001037 <pipe>:
SYSCALL(pipe)
    1037:	b8 04 00 00 00       	mov    $0x4,%eax
    103c:	cd 40                	int    $0x40
    103e:	c3                   	ret    

0000103f <read>:
SYSCALL(read)
    103f:	b8 05 00 00 00       	mov    $0x5,%eax
    1044:	cd 40                	int    $0x40
    1046:	c3                   	ret    

00001047 <write>:
SYSCALL(write)
    1047:	b8 10 00 00 00       	mov    $0x10,%eax
    104c:	cd 40                	int    $0x40
    104e:	c3                   	ret    

0000104f <close>:
SYSCALL(close)
    104f:	b8 15 00 00 00       	mov    $0x15,%eax
    1054:	cd 40                	int    $0x40
    1056:	c3                   	ret    

00001057 <kill>:
SYSCALL(kill)
    1057:	b8 06 00 00 00       	mov    $0x6,%eax
    105c:	cd 40                	int    $0x40
    105e:	c3                   	ret    

0000105f <exec>:
SYSCALL(exec)
    105f:	b8 07 00 00 00       	mov    $0x7,%eax
    1064:	cd 40                	int    $0x40
    1066:	c3                   	ret    

00001067 <open>:
SYSCALL(open)
    1067:	b8 0f 00 00 00       	mov    $0xf,%eax
    106c:	cd 40                	int    $0x40
    106e:	c3                   	ret    

0000106f <mknod>:
SYSCALL(mknod)
    106f:	b8 11 00 00 00       	mov    $0x11,%eax
    1074:	cd 40                	int    $0x40
    1076:	c3                   	ret    

00001077 <unlink>:
SYSCALL(unlink)
    1077:	b8 12 00 00 00       	mov    $0x12,%eax
    107c:	cd 40                	int    $0x40
    107e:	c3                   	ret    

0000107f <fstat>:
SYSCALL(fstat)
    107f:	b8 08 00 00 00       	mov    $0x8,%eax
    1084:	cd 40                	int    $0x40
    1086:	c3                   	ret    

00001087 <link>:
SYSCALL(link)
    1087:	b8 13 00 00 00       	mov    $0x13,%eax
    108c:	cd 40                	int    $0x40
    108e:	c3                   	ret    

0000108f <mkdir>:
SYSCALL(mkdir)
    108f:	b8 14 00 00 00       	mov    $0x14,%eax
    1094:	cd 40                	int    $0x40
    1096:	c3                   	ret    

00001097 <chdir>:
SYSCALL(chdir)
    1097:	b8 09 00 00 00       	mov    $0x9,%eax
    109c:	cd 40                	int    $0x40
    109e:	c3                   	ret    

0000109f <dup>:
SYSCALL(dup)
    109f:	b8 0a 00 00 00       	mov    $0xa,%eax
    10a4:	cd 40                	int    $0x40
    10a6:	c3                   	ret    

000010a7 <getpid>:
SYSCALL(getpid)
    10a7:	b8 0b 00 00 00       	mov    $0xb,%eax
    10ac:	cd 40                	int    $0x40
    10ae:	c3                   	ret    

000010af <sbrk>:
SYSCALL(sbrk)
    10af:	b8 0c 00 00 00       	mov    $0xc,%eax
    10b4:	cd 40                	int    $0x40
    10b6:	c3                   	ret    

000010b7 <sleep>:
SYSCALL(sleep)
    10b7:	b8 0d 00 00 00       	mov    $0xd,%eax
    10bc:	cd 40                	int    $0x40
    10be:	c3                   	ret    

000010bf <uptime>:
SYSCALL(uptime)
    10bf:	b8 0e 00 00 00       	mov    $0xe,%eax
    10c4:	cd 40                	int    $0x40
    10c6:	c3                   	ret    

000010c7 <halt>:
SYSCALL(halt)
    10c7:	b8 16 00 00 00       	mov    $0x16,%eax
    10cc:	cd 40                	int    $0x40
    10ce:	c3                   	ret    

000010cf <date>:
SYSCALL(date)
    10cf:	b8 17 00 00 00       	mov    $0x17,%eax
    10d4:	cd 40                	int    $0x40
    10d6:	c3                   	ret    

000010d7 <getuid>:
SYSCALL(getuid)
    10d7:	b8 18 00 00 00       	mov    $0x18,%eax
    10dc:	cd 40                	int    $0x40
    10de:	c3                   	ret    

000010df <getgid>:
SYSCALL(getgid)
    10df:	b8 19 00 00 00       	mov    $0x19,%eax
    10e4:	cd 40                	int    $0x40
    10e6:	c3                   	ret    

000010e7 <getppid>:
SYSCALL(getppid)
    10e7:	b8 1a 00 00 00       	mov    $0x1a,%eax
    10ec:	cd 40                	int    $0x40
    10ee:	c3                   	ret    

000010ef <setuid>:
SYSCALL(setuid)
    10ef:	b8 1b 00 00 00       	mov    $0x1b,%eax
    10f4:	cd 40                	int    $0x40
    10f6:	c3                   	ret    

000010f7 <setgid>:
SYSCALL(setgid)
    10f7:	b8 1c 00 00 00       	mov    $0x1c,%eax
    10fc:	cd 40                	int    $0x40
    10fe:	c3                   	ret    

000010ff <getprocs>:
SYSCALL(getprocs)
    10ff:	b8 1d 00 00 00       	mov    $0x1d,%eax
    1104:	cd 40                	int    $0x40
    1106:	c3                   	ret    

00001107 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1107:	55                   	push   %ebp
    1108:	89 e5                	mov    %esp,%ebp
    110a:	83 ec 18             	sub    $0x18,%esp
    110d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1110:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1113:	83 ec 04             	sub    $0x4,%esp
    1116:	6a 01                	push   $0x1
    1118:	8d 45 f4             	lea    -0xc(%ebp),%eax
    111b:	50                   	push   %eax
    111c:	ff 75 08             	pushl  0x8(%ebp)
    111f:	e8 23 ff ff ff       	call   1047 <write>
    1124:	83 c4 10             	add    $0x10,%esp
}
    1127:	90                   	nop
    1128:	c9                   	leave  
    1129:	c3                   	ret    

0000112a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    112a:	55                   	push   %ebp
    112b:	89 e5                	mov    %esp,%ebp
    112d:	53                   	push   %ebx
    112e:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1131:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1138:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    113c:	74 17                	je     1155 <printint+0x2b>
    113e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1142:	79 11                	jns    1155 <printint+0x2b>
    neg = 1;
    1144:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    114b:	8b 45 0c             	mov    0xc(%ebp),%eax
    114e:	f7 d8                	neg    %eax
    1150:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1153:	eb 06                	jmp    115b <printint+0x31>
  } else {
    x = xx;
    1155:	8b 45 0c             	mov    0xc(%ebp),%eax
    1158:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    115b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1162:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1165:	8d 41 01             	lea    0x1(%ecx),%eax
    1168:	89 45 f4             	mov    %eax,-0xc(%ebp)
    116b:	8b 5d 10             	mov    0x10(%ebp),%ebx
    116e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1171:	ba 00 00 00 00       	mov    $0x0,%edx
    1176:	f7 f3                	div    %ebx
    1178:	89 d0                	mov    %edx,%eax
    117a:	0f b6 80 04 20 00 00 	movzbl 0x2004(%eax),%eax
    1181:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1185:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1188:	8b 45 ec             	mov    -0x14(%ebp),%eax
    118b:	ba 00 00 00 00       	mov    $0x0,%edx
    1190:	f7 f3                	div    %ebx
    1192:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1195:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1199:	75 c7                	jne    1162 <printint+0x38>
  if(neg)
    119b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    119f:	74 2d                	je     11ce <printint+0xa4>
    buf[i++] = '-';
    11a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11a4:	8d 50 01             	lea    0x1(%eax),%edx
    11a7:	89 55 f4             	mov    %edx,-0xc(%ebp)
    11aa:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    11af:	eb 1d                	jmp    11ce <printint+0xa4>
    putc(fd, buf[i]);
    11b1:	8d 55 dc             	lea    -0x24(%ebp),%edx
    11b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11b7:	01 d0                	add    %edx,%eax
    11b9:	0f b6 00             	movzbl (%eax),%eax
    11bc:	0f be c0             	movsbl %al,%eax
    11bf:	83 ec 08             	sub    $0x8,%esp
    11c2:	50                   	push   %eax
    11c3:	ff 75 08             	pushl  0x8(%ebp)
    11c6:	e8 3c ff ff ff       	call   1107 <putc>
    11cb:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    11ce:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    11d2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    11d6:	79 d9                	jns    11b1 <printint+0x87>
    putc(fd, buf[i]);
}
    11d8:	90                   	nop
    11d9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11dc:	c9                   	leave  
    11dd:	c3                   	ret    

000011de <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    11de:	55                   	push   %ebp
    11df:	89 e5                	mov    %esp,%ebp
    11e1:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    11e4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    11eb:	8d 45 0c             	lea    0xc(%ebp),%eax
    11ee:	83 c0 04             	add    $0x4,%eax
    11f1:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    11f4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    11fb:	e9 59 01 00 00       	jmp    1359 <printf+0x17b>
    c = fmt[i] & 0xff;
    1200:	8b 55 0c             	mov    0xc(%ebp),%edx
    1203:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1206:	01 d0                	add    %edx,%eax
    1208:	0f b6 00             	movzbl (%eax),%eax
    120b:	0f be c0             	movsbl %al,%eax
    120e:	25 ff 00 00 00       	and    $0xff,%eax
    1213:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1216:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    121a:	75 2c                	jne    1248 <printf+0x6a>
      if(c == '%'){
    121c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1220:	75 0c                	jne    122e <printf+0x50>
        state = '%';
    1222:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    1229:	e9 27 01 00 00       	jmp    1355 <printf+0x177>
      } else {
        putc(fd, c);
    122e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1231:	0f be c0             	movsbl %al,%eax
    1234:	83 ec 08             	sub    $0x8,%esp
    1237:	50                   	push   %eax
    1238:	ff 75 08             	pushl  0x8(%ebp)
    123b:	e8 c7 fe ff ff       	call   1107 <putc>
    1240:	83 c4 10             	add    $0x10,%esp
    1243:	e9 0d 01 00 00       	jmp    1355 <printf+0x177>
      }
    } else if(state == '%'){
    1248:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    124c:	0f 85 03 01 00 00    	jne    1355 <printf+0x177>
      if(c == 'd'){
    1252:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1256:	75 1e                	jne    1276 <printf+0x98>
        printint(fd, *ap, 10, 1);
    1258:	8b 45 e8             	mov    -0x18(%ebp),%eax
    125b:	8b 00                	mov    (%eax),%eax
    125d:	6a 01                	push   $0x1
    125f:	6a 0a                	push   $0xa
    1261:	50                   	push   %eax
    1262:	ff 75 08             	pushl  0x8(%ebp)
    1265:	e8 c0 fe ff ff       	call   112a <printint>
    126a:	83 c4 10             	add    $0x10,%esp
        ap++;
    126d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1271:	e9 d8 00 00 00       	jmp    134e <printf+0x170>
      } else if(c == 'x' || c == 'p'){
    1276:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    127a:	74 06                	je     1282 <printf+0xa4>
    127c:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1280:	75 1e                	jne    12a0 <printf+0xc2>
        printint(fd, *ap, 16, 0);
    1282:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1285:	8b 00                	mov    (%eax),%eax
    1287:	6a 00                	push   $0x0
    1289:	6a 10                	push   $0x10
    128b:	50                   	push   %eax
    128c:	ff 75 08             	pushl  0x8(%ebp)
    128f:	e8 96 fe ff ff       	call   112a <printint>
    1294:	83 c4 10             	add    $0x10,%esp
        ap++;
    1297:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    129b:	e9 ae 00 00 00       	jmp    134e <printf+0x170>
      } else if(c == 's'){
    12a0:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    12a4:	75 43                	jne    12e9 <printf+0x10b>
        s = (char*)*ap;
    12a6:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12a9:	8b 00                	mov    (%eax),%eax
    12ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    12ae:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    12b2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    12b6:	75 25                	jne    12dd <printf+0xff>
          s = "(null)";
    12b8:	c7 45 f4 11 1c 00 00 	movl   $0x1c11,-0xc(%ebp)
        while(*s != 0){
    12bf:	eb 1c                	jmp    12dd <printf+0xff>
          putc(fd, *s);
    12c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12c4:	0f b6 00             	movzbl (%eax),%eax
    12c7:	0f be c0             	movsbl %al,%eax
    12ca:	83 ec 08             	sub    $0x8,%esp
    12cd:	50                   	push   %eax
    12ce:	ff 75 08             	pushl  0x8(%ebp)
    12d1:	e8 31 fe ff ff       	call   1107 <putc>
    12d6:	83 c4 10             	add    $0x10,%esp
          s++;
    12d9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    12dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12e0:	0f b6 00             	movzbl (%eax),%eax
    12e3:	84 c0                	test   %al,%al
    12e5:	75 da                	jne    12c1 <printf+0xe3>
    12e7:	eb 65                	jmp    134e <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    12e9:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    12ed:	75 1d                	jne    130c <printf+0x12e>
        putc(fd, *ap);
    12ef:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12f2:	8b 00                	mov    (%eax),%eax
    12f4:	0f be c0             	movsbl %al,%eax
    12f7:	83 ec 08             	sub    $0x8,%esp
    12fa:	50                   	push   %eax
    12fb:	ff 75 08             	pushl  0x8(%ebp)
    12fe:	e8 04 fe ff ff       	call   1107 <putc>
    1303:	83 c4 10             	add    $0x10,%esp
        ap++;
    1306:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    130a:	eb 42                	jmp    134e <printf+0x170>
      } else if(c == '%'){
    130c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1310:	75 17                	jne    1329 <printf+0x14b>
        putc(fd, c);
    1312:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1315:	0f be c0             	movsbl %al,%eax
    1318:	83 ec 08             	sub    $0x8,%esp
    131b:	50                   	push   %eax
    131c:	ff 75 08             	pushl  0x8(%ebp)
    131f:	e8 e3 fd ff ff       	call   1107 <putc>
    1324:	83 c4 10             	add    $0x10,%esp
    1327:	eb 25                	jmp    134e <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1329:	83 ec 08             	sub    $0x8,%esp
    132c:	6a 25                	push   $0x25
    132e:	ff 75 08             	pushl  0x8(%ebp)
    1331:	e8 d1 fd ff ff       	call   1107 <putc>
    1336:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    1339:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    133c:	0f be c0             	movsbl %al,%eax
    133f:	83 ec 08             	sub    $0x8,%esp
    1342:	50                   	push   %eax
    1343:	ff 75 08             	pushl  0x8(%ebp)
    1346:	e8 bc fd ff ff       	call   1107 <putc>
    134b:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    134e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1355:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1359:	8b 55 0c             	mov    0xc(%ebp),%edx
    135c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    135f:	01 d0                	add    %edx,%eax
    1361:	0f b6 00             	movzbl (%eax),%eax
    1364:	84 c0                	test   %al,%al
    1366:	0f 85 94 fe ff ff    	jne    1200 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    136c:	90                   	nop
    136d:	c9                   	leave  
    136e:	c3                   	ret    

0000136f <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    136f:	55                   	push   %ebp
    1370:	89 e5                	mov    %esp,%ebp
    1372:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1375:	8b 45 08             	mov    0x8(%ebp),%eax
    1378:	83 e8 08             	sub    $0x8,%eax
    137b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    137e:	a1 20 20 00 00       	mov    0x2020,%eax
    1383:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1386:	eb 24                	jmp    13ac <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1388:	8b 45 fc             	mov    -0x4(%ebp),%eax
    138b:	8b 00                	mov    (%eax),%eax
    138d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1390:	77 12                	ja     13a4 <free+0x35>
    1392:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1395:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1398:	77 24                	ja     13be <free+0x4f>
    139a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    139d:	8b 00                	mov    (%eax),%eax
    139f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    13a2:	77 1a                	ja     13be <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    13a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13a7:	8b 00                	mov    (%eax),%eax
    13a9:	89 45 fc             	mov    %eax,-0x4(%ebp)
    13ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
    13af:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    13b2:	76 d4                	jbe    1388 <free+0x19>
    13b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13b7:	8b 00                	mov    (%eax),%eax
    13b9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    13bc:	76 ca                	jbe    1388 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    13be:	8b 45 f8             	mov    -0x8(%ebp),%eax
    13c1:	8b 40 04             	mov    0x4(%eax),%eax
    13c4:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    13cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
    13ce:	01 c2                	add    %eax,%edx
    13d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13d3:	8b 00                	mov    (%eax),%eax
    13d5:	39 c2                	cmp    %eax,%edx
    13d7:	75 24                	jne    13fd <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    13d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
    13dc:	8b 50 04             	mov    0x4(%eax),%edx
    13df:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13e2:	8b 00                	mov    (%eax),%eax
    13e4:	8b 40 04             	mov    0x4(%eax),%eax
    13e7:	01 c2                	add    %eax,%edx
    13e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
    13ec:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    13ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13f2:	8b 00                	mov    (%eax),%eax
    13f4:	8b 10                	mov    (%eax),%edx
    13f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    13f9:	89 10                	mov    %edx,(%eax)
    13fb:	eb 0a                	jmp    1407 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    13fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1400:	8b 10                	mov    (%eax),%edx
    1402:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1405:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1407:	8b 45 fc             	mov    -0x4(%ebp),%eax
    140a:	8b 40 04             	mov    0x4(%eax),%eax
    140d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1414:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1417:	01 d0                	add    %edx,%eax
    1419:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    141c:	75 20                	jne    143e <free+0xcf>
    p->s.size += bp->s.size;
    141e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1421:	8b 50 04             	mov    0x4(%eax),%edx
    1424:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1427:	8b 40 04             	mov    0x4(%eax),%eax
    142a:	01 c2                	add    %eax,%edx
    142c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    142f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1432:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1435:	8b 10                	mov    (%eax),%edx
    1437:	8b 45 fc             	mov    -0x4(%ebp),%eax
    143a:	89 10                	mov    %edx,(%eax)
    143c:	eb 08                	jmp    1446 <free+0xd7>
  } else
    p->s.ptr = bp;
    143e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1441:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1444:	89 10                	mov    %edx,(%eax)
  freep = p;
    1446:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1449:	a3 20 20 00 00       	mov    %eax,0x2020
}
    144e:	90                   	nop
    144f:	c9                   	leave  
    1450:	c3                   	ret    

00001451 <morecore>:

static Header*
morecore(uint nu)
{
    1451:	55                   	push   %ebp
    1452:	89 e5                	mov    %esp,%ebp
    1454:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1457:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    145e:	77 07                	ja     1467 <morecore+0x16>
    nu = 4096;
    1460:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1467:	8b 45 08             	mov    0x8(%ebp),%eax
    146a:	c1 e0 03             	shl    $0x3,%eax
    146d:	83 ec 0c             	sub    $0xc,%esp
    1470:	50                   	push   %eax
    1471:	e8 39 fc ff ff       	call   10af <sbrk>
    1476:	83 c4 10             	add    $0x10,%esp
    1479:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    147c:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1480:	75 07                	jne    1489 <morecore+0x38>
    return 0;
    1482:	b8 00 00 00 00       	mov    $0x0,%eax
    1487:	eb 26                	jmp    14af <morecore+0x5e>
  hp = (Header*)p;
    1489:	8b 45 f4             	mov    -0xc(%ebp),%eax
    148c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    148f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1492:	8b 55 08             	mov    0x8(%ebp),%edx
    1495:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1498:	8b 45 f0             	mov    -0x10(%ebp),%eax
    149b:	83 c0 08             	add    $0x8,%eax
    149e:	83 ec 0c             	sub    $0xc,%esp
    14a1:	50                   	push   %eax
    14a2:	e8 c8 fe ff ff       	call   136f <free>
    14a7:	83 c4 10             	add    $0x10,%esp
  return freep;
    14aa:	a1 20 20 00 00       	mov    0x2020,%eax
}
    14af:	c9                   	leave  
    14b0:	c3                   	ret    

000014b1 <malloc>:

void*
malloc(uint nbytes)
{
    14b1:	55                   	push   %ebp
    14b2:	89 e5                	mov    %esp,%ebp
    14b4:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    14b7:	8b 45 08             	mov    0x8(%ebp),%eax
    14ba:	83 c0 07             	add    $0x7,%eax
    14bd:	c1 e8 03             	shr    $0x3,%eax
    14c0:	83 c0 01             	add    $0x1,%eax
    14c3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    14c6:	a1 20 20 00 00       	mov    0x2020,%eax
    14cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    14ce:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    14d2:	75 23                	jne    14f7 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    14d4:	c7 45 f0 18 20 00 00 	movl   $0x2018,-0x10(%ebp)
    14db:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14de:	a3 20 20 00 00       	mov    %eax,0x2020
    14e3:	a1 20 20 00 00       	mov    0x2020,%eax
    14e8:	a3 18 20 00 00       	mov    %eax,0x2018
    base.s.size = 0;
    14ed:	c7 05 1c 20 00 00 00 	movl   $0x0,0x201c
    14f4:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    14f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14fa:	8b 00                	mov    (%eax),%eax
    14fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    14ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1502:	8b 40 04             	mov    0x4(%eax),%eax
    1505:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1508:	72 4d                	jb     1557 <malloc+0xa6>
      if(p->s.size == nunits)
    150a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    150d:	8b 40 04             	mov    0x4(%eax),%eax
    1510:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1513:	75 0c                	jne    1521 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    1515:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1518:	8b 10                	mov    (%eax),%edx
    151a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    151d:	89 10                	mov    %edx,(%eax)
    151f:	eb 26                	jmp    1547 <malloc+0x96>
      else {
        p->s.size -= nunits;
    1521:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1524:	8b 40 04             	mov    0x4(%eax),%eax
    1527:	2b 45 ec             	sub    -0x14(%ebp),%eax
    152a:	89 c2                	mov    %eax,%edx
    152c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    152f:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1532:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1535:	8b 40 04             	mov    0x4(%eax),%eax
    1538:	c1 e0 03             	shl    $0x3,%eax
    153b:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    153e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1541:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1544:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1547:	8b 45 f0             	mov    -0x10(%ebp),%eax
    154a:	a3 20 20 00 00       	mov    %eax,0x2020
      return (void*)(p + 1);
    154f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1552:	83 c0 08             	add    $0x8,%eax
    1555:	eb 3b                	jmp    1592 <malloc+0xe1>
    }
    if(p == freep)
    1557:	a1 20 20 00 00       	mov    0x2020,%eax
    155c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    155f:	75 1e                	jne    157f <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    1561:	83 ec 0c             	sub    $0xc,%esp
    1564:	ff 75 ec             	pushl  -0x14(%ebp)
    1567:	e8 e5 fe ff ff       	call   1451 <morecore>
    156c:	83 c4 10             	add    $0x10,%esp
    156f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1572:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1576:	75 07                	jne    157f <malloc+0xce>
        return 0;
    1578:	b8 00 00 00 00       	mov    $0x0,%eax
    157d:	eb 13                	jmp    1592 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    157f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1582:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1585:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1588:	8b 00                	mov    (%eax),%eax
    158a:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    158d:	e9 6d ff ff ff       	jmp    14ff <malloc+0x4e>
}
    1592:	c9                   	leave  
    1593:	c3                   	ret    
