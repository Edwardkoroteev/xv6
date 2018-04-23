
_ps:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "user.h"
#include "uproc.h"
int
main(int argc, char * argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 24             	sub    $0x24,%esp
  11:	89 c8                	mov    %ecx,%eax
  int max = 72;
  13:	c7 45 f4 48 00 00 00 	movl   $0x48,-0xc(%ebp)

  if(argc > 1)
  1a:	83 38 01             	cmpl   $0x1,(%eax)
  1d:	7e 17                	jle    36 <main+0x36>
    max = atoi(argv[1]);
  1f:	8b 40 04             	mov    0x4(%eax),%eax
  22:	83 c0 04             	add    $0x4,%eax
  25:	8b 00                	mov    (%eax),%eax
  27:	83 ec 0c             	sub    $0xc,%esp
  2a:	50                   	push   %eax
  2b:	e8 8e 04 00 00       	call   4be <atoi>
  30:	83 c4 10             	add    $0x10,%esp
  33:	89 45 f4             	mov    %eax,-0xc(%ebp)

  struct uproc * table = malloc(sizeof(*table)*max);
  36:	8b 45 f4             	mov    -0xc(%ebp),%eax
  39:	6b c0 5c             	imul   $0x5c,%eax,%eax
  3c:	83 ec 0c             	sub    $0xc,%esp
  3f:	50                   	push   %eax
  40:	e8 68 0a 00 00       	call   aad <malloc>
  45:	83 c4 10             	add    $0x10,%esp
  48:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int process = getprocs(max, table);
  4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  4e:	83 ec 08             	sub    $0x8,%esp
  51:	ff 75 ec             	pushl  -0x14(%ebp)
  54:	50                   	push   %eax
  55:	e8 a1 06 00 00       	call   6fb <getprocs>
  5a:	83 c4 10             	add    $0x10,%esp
  5d:	89 45 e8             	mov    %eax,-0x18(%ebp)
  int time;
  int decim;
  int cpuTime;
  int cpuDecim;
  if(process < 1)
  60:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  64:	7f 20                	jg     86 <main+0x86>
  {
    free(table);
  66:	83 ec 0c             	sub    $0xc,%esp
  69:	ff 75 ec             	pushl  -0x14(%ebp)
  6c:	e8 fa 08 00 00       	call   96b <free>
  71:	83 c4 10             	add    $0x10,%esp
    printf(1, "Error\n");
  74:	83 ec 08             	sub    $0x8,%esp
  77:	68 90 0b 00 00       	push   $0xb90
  7c:	6a 01                	push   $0x1
  7e:	e8 57 07 00 00       	call   7da <printf>
  83:	83 c4 10             	add    $0x10,%esp
  }

  printf(1, "PID\tName\tUID\tGID\tPPID\tElapsed\tCPU\tState\tSize\n");
  86:	83 ec 08             	sub    $0x8,%esp
  89:	68 98 0b 00 00       	push   $0xb98
  8e:	6a 01                	push   $0x1
  90:	e8 45 07 00 00       	call   7da <printf>
  95:	83 c4 10             	add    $0x10,%esp

  for(int i = 0; i < process; i++)
  98:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  9f:	e9 36 02 00 00       	jmp    2da <main+0x2da>
  {
    printf(1, "%d\t", table[i].pid);
  a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  a7:	6b d0 5c             	imul   $0x5c,%eax,%edx
  aa:	8b 45 ec             	mov    -0x14(%ebp),%eax
  ad:	01 d0                	add    %edx,%eax
  af:	8b 00                	mov    (%eax),%eax
  b1:	83 ec 04             	sub    $0x4,%esp
  b4:	50                   	push   %eax
  b5:	68 c6 0b 00 00       	push   $0xbc6
  ba:	6a 01                	push   $0x1
  bc:	e8 19 07 00 00       	call   7da <printf>
  c1:	83 c4 10             	add    $0x10,%esp
    printf(1, "%s\t", table[i].name);
  c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  c7:	6b d0 5c             	imul   $0x5c,%eax,%edx
  ca:	8b 45 ec             	mov    -0x14(%ebp),%eax
  cd:	01 d0                	add    %edx,%eax
  cf:	83 c0 3c             	add    $0x3c,%eax
  d2:	83 ec 04             	sub    $0x4,%esp
  d5:	50                   	push   %eax
  d6:	68 ca 0b 00 00       	push   $0xbca
  db:	6a 01                	push   $0x1
  dd:	e8 f8 06 00 00       	call   7da <printf>
  e2:	83 c4 10             	add    $0x10,%esp
    printf(1, "%d\t", table[i].uid);
  e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  e8:	6b d0 5c             	imul   $0x5c,%eax,%edx
  eb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  ee:	01 d0                	add    %edx,%eax
  f0:	8b 40 04             	mov    0x4(%eax),%eax
  f3:	83 ec 04             	sub    $0x4,%esp
  f6:	50                   	push   %eax
  f7:	68 c6 0b 00 00       	push   $0xbc6
  fc:	6a 01                	push   $0x1
  fe:	e8 d7 06 00 00       	call   7da <printf>
 103:	83 c4 10             	add    $0x10,%esp
    printf(1, "%d\t", table[i].gid);
 106:	8b 45 f0             	mov    -0x10(%ebp),%eax
 109:	6b d0 5c             	imul   $0x5c,%eax,%edx
 10c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 10f:	01 d0                	add    %edx,%eax
 111:	8b 40 08             	mov    0x8(%eax),%eax
 114:	83 ec 04             	sub    $0x4,%esp
 117:	50                   	push   %eax
 118:	68 c6 0b 00 00       	push   $0xbc6
 11d:	6a 01                	push   $0x1
 11f:	e8 b6 06 00 00       	call   7da <printf>
 124:	83 c4 10             	add    $0x10,%esp
    printf(1, "%d\t", table[i].ppid);
 127:	8b 45 f0             	mov    -0x10(%ebp),%eax
 12a:	6b d0 5c             	imul   $0x5c,%eax,%edx
 12d:	8b 45 ec             	mov    -0x14(%ebp),%eax
 130:	01 d0                	add    %edx,%eax
 132:	8b 40 0c             	mov    0xc(%eax),%eax
 135:	83 ec 04             	sub    $0x4,%esp
 138:	50                   	push   %eax
 139:	68 c6 0b 00 00       	push   $0xbc6
 13e:	6a 01                	push   $0x1
 140:	e8 95 06 00 00       	call   7da <printf>
 145:	83 c4 10             	add    $0x10,%esp
    time = table[i].elapsed_ticks;
 148:	8b 45 f0             	mov    -0x10(%ebp),%eax
 14b:	6b d0 5c             	imul   $0x5c,%eax,%edx
 14e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 151:	01 d0                	add    %edx,%eax
 153:	8b 40 10             	mov    0x10(%eax),%eax
 156:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    decim = time % 1000;
 159:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
 15c:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
 161:	89 c8                	mov    %ecx,%eax
 163:	f7 ea                	imul   %edx
 165:	c1 fa 06             	sar    $0x6,%edx
 168:	89 c8                	mov    %ecx,%eax
 16a:	c1 f8 1f             	sar    $0x1f,%eax
 16d:	29 c2                	sub    %eax,%edx
 16f:	89 d0                	mov    %edx,%eax
 171:	69 c0 e8 03 00 00    	imul   $0x3e8,%eax,%eax
 177:	29 c1                	sub    %eax,%ecx
 179:	89 c8                	mov    %ecx,%eax
 17b:	89 45 e0             	mov    %eax,-0x20(%ebp)
    time /= 1000;
 17e:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
 181:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
 186:	89 c8                	mov    %ecx,%eax
 188:	f7 ea                	imul   %edx
 18a:	c1 fa 06             	sar    $0x6,%edx
 18d:	89 c8                	mov    %ecx,%eax
 18f:	c1 f8 1f             	sar    $0x1f,%eax
 192:	29 c2                	sub    %eax,%edx
 194:	89 d0                	mov    %edx,%eax
 196:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(decim < 10)
 199:	83 7d e0 09          	cmpl   $0x9,-0x20(%ebp)
 19d:	7f 17                	jg     1b6 <main+0x1b6>
      printf(1, "%d.00%d\t", time, decim);
 19f:	ff 75 e0             	pushl  -0x20(%ebp)
 1a2:	ff 75 e4             	pushl  -0x1c(%ebp)
 1a5:	68 ce 0b 00 00       	push   $0xbce
 1aa:	6a 01                	push   $0x1
 1ac:	e8 29 06 00 00       	call   7da <printf>
 1b1:	83 c4 10             	add    $0x10,%esp
 1b4:	eb 38                	jmp    1ee <main+0x1ee>
    else if(decim < 100 && decim >= 10)
 1b6:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
 1ba:	7f 1d                	jg     1d9 <main+0x1d9>
 1bc:	83 7d e0 09          	cmpl   $0x9,-0x20(%ebp)
 1c0:	7e 17                	jle    1d9 <main+0x1d9>
      printf(1, "%d.0%d\t", time, decim);
 1c2:	ff 75 e0             	pushl  -0x20(%ebp)
 1c5:	ff 75 e4             	pushl  -0x1c(%ebp)
 1c8:	68 d7 0b 00 00       	push   $0xbd7
 1cd:	6a 01                	push   $0x1
 1cf:	e8 06 06 00 00       	call   7da <printf>
 1d4:	83 c4 10             	add    $0x10,%esp
 1d7:	eb 15                	jmp    1ee <main+0x1ee>
    else
      printf(1, "%d.%d\t", time, decim);
 1d9:	ff 75 e0             	pushl  -0x20(%ebp)
 1dc:	ff 75 e4             	pushl  -0x1c(%ebp)
 1df:	68 df 0b 00 00       	push   $0xbdf
 1e4:	6a 01                	push   $0x1
 1e6:	e8 ef 05 00 00       	call   7da <printf>
 1eb:	83 c4 10             	add    $0x10,%esp

    cpuTime = table[i].CPU_total_ticks;
 1ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
 1f1:	6b d0 5c             	imul   $0x5c,%eax,%edx
 1f4:	8b 45 ec             	mov    -0x14(%ebp),%eax
 1f7:	01 d0                	add    %edx,%eax
 1f9:	8b 40 14             	mov    0x14(%eax),%eax
 1fc:	89 45 dc             	mov    %eax,-0x24(%ebp)
    cpuDecim = cpuTime % 1000;
 1ff:	8b 4d dc             	mov    -0x24(%ebp),%ecx
 202:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
 207:	89 c8                	mov    %ecx,%eax
 209:	f7 ea                	imul   %edx
 20b:	c1 fa 06             	sar    $0x6,%edx
 20e:	89 c8                	mov    %ecx,%eax
 210:	c1 f8 1f             	sar    $0x1f,%eax
 213:	29 c2                	sub    %eax,%edx
 215:	89 d0                	mov    %edx,%eax
 217:	69 c0 e8 03 00 00    	imul   $0x3e8,%eax,%eax
 21d:	29 c1                	sub    %eax,%ecx
 21f:	89 c8                	mov    %ecx,%eax
 221:	89 45 d8             	mov    %eax,-0x28(%ebp)
    cpuTime /= 1000;
 224:	8b 4d dc             	mov    -0x24(%ebp),%ecx
 227:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
 22c:	89 c8                	mov    %ecx,%eax
 22e:	f7 ea                	imul   %edx
 230:	c1 fa 06             	sar    $0x6,%edx
 233:	89 c8                	mov    %ecx,%eax
 235:	c1 f8 1f             	sar    $0x1f,%eax
 238:	29 c2                	sub    %eax,%edx
 23a:	89 d0                	mov    %edx,%eax
 23c:	89 45 dc             	mov    %eax,-0x24(%ebp)
    if(cpuDecim < 10)
 23f:	83 7d d8 09          	cmpl   $0x9,-0x28(%ebp)
 243:	7f 17                	jg     25c <main+0x25c>
      printf(1, "%d.00%d\t", cpuTime, cpuDecim);
 245:	ff 75 d8             	pushl  -0x28(%ebp)
 248:	ff 75 dc             	pushl  -0x24(%ebp)
 24b:	68 ce 0b 00 00       	push   $0xbce
 250:	6a 01                	push   $0x1
 252:	e8 83 05 00 00       	call   7da <printf>
 257:	83 c4 10             	add    $0x10,%esp
 25a:	eb 38                	jmp    294 <main+0x294>
    else if(cpuDecim < 100 && cpuDecim >= 10)
 25c:	83 7d d8 63          	cmpl   $0x63,-0x28(%ebp)
 260:	7f 1d                	jg     27f <main+0x27f>
 262:	83 7d d8 09          	cmpl   $0x9,-0x28(%ebp)
 266:	7e 17                	jle    27f <main+0x27f>
      printf(1, "%d.0%d\t", cpuTime, cpuDecim);
 268:	ff 75 d8             	pushl  -0x28(%ebp)
 26b:	ff 75 dc             	pushl  -0x24(%ebp)
 26e:	68 d7 0b 00 00       	push   $0xbd7
 273:	6a 01                	push   $0x1
 275:	e8 60 05 00 00       	call   7da <printf>
 27a:	83 c4 10             	add    $0x10,%esp
 27d:	eb 15                	jmp    294 <main+0x294>
    else
      printf(1, "%d.%d\t", cpuTime, cpuDecim);
 27f:	ff 75 d8             	pushl  -0x28(%ebp)
 282:	ff 75 dc             	pushl  -0x24(%ebp)
 285:	68 df 0b 00 00       	push   $0xbdf
 28a:	6a 01                	push   $0x1
 28c:	e8 49 05 00 00       	call   7da <printf>
 291:	83 c4 10             	add    $0x10,%esp

    printf(1, "%s\t", table[i].state);
 294:	8b 45 f0             	mov    -0x10(%ebp),%eax
 297:	6b d0 5c             	imul   $0x5c,%eax,%edx
 29a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 29d:	01 d0                	add    %edx,%eax
 29f:	83 c0 18             	add    $0x18,%eax
 2a2:	83 ec 04             	sub    $0x4,%esp
 2a5:	50                   	push   %eax
 2a6:	68 ca 0b 00 00       	push   $0xbca
 2ab:	6a 01                	push   $0x1
 2ad:	e8 28 05 00 00       	call   7da <printf>
 2b2:	83 c4 10             	add    $0x10,%esp
    printf(1, "%d\n", table[i].size);
 2b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 2b8:	6b d0 5c             	imul   $0x5c,%eax,%edx
 2bb:	8b 45 ec             	mov    -0x14(%ebp),%eax
 2be:	01 d0                	add    %edx,%eax
 2c0:	8b 40 38             	mov    0x38(%eax),%eax
 2c3:	83 ec 04             	sub    $0x4,%esp
 2c6:	50                   	push   %eax
 2c7:	68 e6 0b 00 00       	push   $0xbe6
 2cc:	6a 01                	push   $0x1
 2ce:	e8 07 05 00 00       	call   7da <printf>
 2d3:	83 c4 10             	add    $0x10,%esp
    printf(1, "Error\n");
  }

  printf(1, "PID\tName\tUID\tGID\tPPID\tElapsed\tCPU\tState\tSize\n");

  for(int i = 0; i < process; i++)
 2d6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 2da:	8b 45 f0             	mov    -0x10(%ebp),%eax
 2dd:	3b 45 e8             	cmp    -0x18(%ebp),%eax
 2e0:	0f 8c be fd ff ff    	jl     a4 <main+0xa4>
      printf(1, "%d.%d\t", cpuTime, cpuDecim);

    printf(1, "%s\t", table[i].state);
    printf(1, "%d\n", table[i].size);
  } 
  free(table);
 2e6:	83 ec 0c             	sub    $0xc,%esp
 2e9:	ff 75 ec             	pushl  -0x14(%ebp)
 2ec:	e8 7a 06 00 00       	call   96b <free>
 2f1:	83 c4 10             	add    $0x10,%esp
  exit();
 2f4:	e8 2a 03 00 00       	call   623 <exit>

000002f9 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 2f9:	55                   	push   %ebp
 2fa:	89 e5                	mov    %esp,%ebp
 2fc:	57                   	push   %edi
 2fd:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 2fe:	8b 4d 08             	mov    0x8(%ebp),%ecx
 301:	8b 55 10             	mov    0x10(%ebp),%edx
 304:	8b 45 0c             	mov    0xc(%ebp),%eax
 307:	89 cb                	mov    %ecx,%ebx
 309:	89 df                	mov    %ebx,%edi
 30b:	89 d1                	mov    %edx,%ecx
 30d:	fc                   	cld    
 30e:	f3 aa                	rep stos %al,%es:(%edi)
 310:	89 ca                	mov    %ecx,%edx
 312:	89 fb                	mov    %edi,%ebx
 314:	89 5d 08             	mov    %ebx,0x8(%ebp)
 317:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 31a:	90                   	nop
 31b:	5b                   	pop    %ebx
 31c:	5f                   	pop    %edi
 31d:	5d                   	pop    %ebp
 31e:	c3                   	ret    

0000031f <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 31f:	55                   	push   %ebp
 320:	89 e5                	mov    %esp,%ebp
 322:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 325:	8b 45 08             	mov    0x8(%ebp),%eax
 328:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 32b:	90                   	nop
 32c:	8b 45 08             	mov    0x8(%ebp),%eax
 32f:	8d 50 01             	lea    0x1(%eax),%edx
 332:	89 55 08             	mov    %edx,0x8(%ebp)
 335:	8b 55 0c             	mov    0xc(%ebp),%edx
 338:	8d 4a 01             	lea    0x1(%edx),%ecx
 33b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 33e:	0f b6 12             	movzbl (%edx),%edx
 341:	88 10                	mov    %dl,(%eax)
 343:	0f b6 00             	movzbl (%eax),%eax
 346:	84 c0                	test   %al,%al
 348:	75 e2                	jne    32c <strcpy+0xd>
    ;
  return os;
 34a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 34d:	c9                   	leave  
 34e:	c3                   	ret    

0000034f <strcmp>:

int
strcmp(const char *p, const char *q)
{
 34f:	55                   	push   %ebp
 350:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 352:	eb 08                	jmp    35c <strcmp+0xd>
    p++, q++;
 354:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 358:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 35c:	8b 45 08             	mov    0x8(%ebp),%eax
 35f:	0f b6 00             	movzbl (%eax),%eax
 362:	84 c0                	test   %al,%al
 364:	74 10                	je     376 <strcmp+0x27>
 366:	8b 45 08             	mov    0x8(%ebp),%eax
 369:	0f b6 10             	movzbl (%eax),%edx
 36c:	8b 45 0c             	mov    0xc(%ebp),%eax
 36f:	0f b6 00             	movzbl (%eax),%eax
 372:	38 c2                	cmp    %al,%dl
 374:	74 de                	je     354 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 376:	8b 45 08             	mov    0x8(%ebp),%eax
 379:	0f b6 00             	movzbl (%eax),%eax
 37c:	0f b6 d0             	movzbl %al,%edx
 37f:	8b 45 0c             	mov    0xc(%ebp),%eax
 382:	0f b6 00             	movzbl (%eax),%eax
 385:	0f b6 c0             	movzbl %al,%eax
 388:	29 c2                	sub    %eax,%edx
 38a:	89 d0                	mov    %edx,%eax
}
 38c:	5d                   	pop    %ebp
 38d:	c3                   	ret    

0000038e <strlen>:

uint
strlen(char *s)
{
 38e:	55                   	push   %ebp
 38f:	89 e5                	mov    %esp,%ebp
 391:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 394:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 39b:	eb 04                	jmp    3a1 <strlen+0x13>
 39d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 3a1:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3a4:	8b 45 08             	mov    0x8(%ebp),%eax
 3a7:	01 d0                	add    %edx,%eax
 3a9:	0f b6 00             	movzbl (%eax),%eax
 3ac:	84 c0                	test   %al,%al
 3ae:	75 ed                	jne    39d <strlen+0xf>
    ;
  return n;
 3b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3b3:	c9                   	leave  
 3b4:	c3                   	ret    

000003b5 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3b5:	55                   	push   %ebp
 3b6:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 3b8:	8b 45 10             	mov    0x10(%ebp),%eax
 3bb:	50                   	push   %eax
 3bc:	ff 75 0c             	pushl  0xc(%ebp)
 3bf:	ff 75 08             	pushl  0x8(%ebp)
 3c2:	e8 32 ff ff ff       	call   2f9 <stosb>
 3c7:	83 c4 0c             	add    $0xc,%esp
  return dst;
 3ca:	8b 45 08             	mov    0x8(%ebp),%eax
}
 3cd:	c9                   	leave  
 3ce:	c3                   	ret    

000003cf <strchr>:

char*
strchr(const char *s, char c)
{
 3cf:	55                   	push   %ebp
 3d0:	89 e5                	mov    %esp,%ebp
 3d2:	83 ec 04             	sub    $0x4,%esp
 3d5:	8b 45 0c             	mov    0xc(%ebp),%eax
 3d8:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 3db:	eb 14                	jmp    3f1 <strchr+0x22>
    if(*s == c)
 3dd:	8b 45 08             	mov    0x8(%ebp),%eax
 3e0:	0f b6 00             	movzbl (%eax),%eax
 3e3:	3a 45 fc             	cmp    -0x4(%ebp),%al
 3e6:	75 05                	jne    3ed <strchr+0x1e>
      return (char*)s;
 3e8:	8b 45 08             	mov    0x8(%ebp),%eax
 3eb:	eb 13                	jmp    400 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 3ed:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 3f1:	8b 45 08             	mov    0x8(%ebp),%eax
 3f4:	0f b6 00             	movzbl (%eax),%eax
 3f7:	84 c0                	test   %al,%al
 3f9:	75 e2                	jne    3dd <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 3fb:	b8 00 00 00 00       	mov    $0x0,%eax
}
 400:	c9                   	leave  
 401:	c3                   	ret    

00000402 <gets>:

char*
gets(char *buf, int max)
{
 402:	55                   	push   %ebp
 403:	89 e5                	mov    %esp,%ebp
 405:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 408:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 40f:	eb 42                	jmp    453 <gets+0x51>
    cc = read(0, &c, 1);
 411:	83 ec 04             	sub    $0x4,%esp
 414:	6a 01                	push   $0x1
 416:	8d 45 ef             	lea    -0x11(%ebp),%eax
 419:	50                   	push   %eax
 41a:	6a 00                	push   $0x0
 41c:	e8 1a 02 00 00       	call   63b <read>
 421:	83 c4 10             	add    $0x10,%esp
 424:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 427:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 42b:	7e 33                	jle    460 <gets+0x5e>
      break;
    buf[i++] = c;
 42d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 430:	8d 50 01             	lea    0x1(%eax),%edx
 433:	89 55 f4             	mov    %edx,-0xc(%ebp)
 436:	89 c2                	mov    %eax,%edx
 438:	8b 45 08             	mov    0x8(%ebp),%eax
 43b:	01 c2                	add    %eax,%edx
 43d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 441:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 443:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 447:	3c 0a                	cmp    $0xa,%al
 449:	74 16                	je     461 <gets+0x5f>
 44b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 44f:	3c 0d                	cmp    $0xd,%al
 451:	74 0e                	je     461 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 453:	8b 45 f4             	mov    -0xc(%ebp),%eax
 456:	83 c0 01             	add    $0x1,%eax
 459:	3b 45 0c             	cmp    0xc(%ebp),%eax
 45c:	7c b3                	jl     411 <gets+0xf>
 45e:	eb 01                	jmp    461 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 460:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 461:	8b 55 f4             	mov    -0xc(%ebp),%edx
 464:	8b 45 08             	mov    0x8(%ebp),%eax
 467:	01 d0                	add    %edx,%eax
 469:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 46c:	8b 45 08             	mov    0x8(%ebp),%eax
}
 46f:	c9                   	leave  
 470:	c3                   	ret    

00000471 <stat>:

int
stat(char *n, struct stat *st)
{
 471:	55                   	push   %ebp
 472:	89 e5                	mov    %esp,%ebp
 474:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 477:	83 ec 08             	sub    $0x8,%esp
 47a:	6a 00                	push   $0x0
 47c:	ff 75 08             	pushl  0x8(%ebp)
 47f:	e8 df 01 00 00       	call   663 <open>
 484:	83 c4 10             	add    $0x10,%esp
 487:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 48a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 48e:	79 07                	jns    497 <stat+0x26>
    return -1;
 490:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 495:	eb 25                	jmp    4bc <stat+0x4b>
  r = fstat(fd, st);
 497:	83 ec 08             	sub    $0x8,%esp
 49a:	ff 75 0c             	pushl  0xc(%ebp)
 49d:	ff 75 f4             	pushl  -0xc(%ebp)
 4a0:	e8 d6 01 00 00       	call   67b <fstat>
 4a5:	83 c4 10             	add    $0x10,%esp
 4a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 4ab:	83 ec 0c             	sub    $0xc,%esp
 4ae:	ff 75 f4             	pushl  -0xc(%ebp)
 4b1:	e8 95 01 00 00       	call   64b <close>
 4b6:	83 c4 10             	add    $0x10,%esp
  return r;
 4b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 4bc:	c9                   	leave  
 4bd:	c3                   	ret    

000004be <atoi>:

int
atoi(const char *s)
{
 4be:	55                   	push   %ebp
 4bf:	89 e5                	mov    %esp,%ebp
 4c1:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 4c4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 4cb:	eb 04                	jmp    4d1 <atoi+0x13>
 4cd:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 4d1:	8b 45 08             	mov    0x8(%ebp),%eax
 4d4:	0f b6 00             	movzbl (%eax),%eax
 4d7:	3c 20                	cmp    $0x20,%al
 4d9:	74 f2                	je     4cd <atoi+0xf>
  sign = (*s == '-') ? -1 : 1;
 4db:	8b 45 08             	mov    0x8(%ebp),%eax
 4de:	0f b6 00             	movzbl (%eax),%eax
 4e1:	3c 2d                	cmp    $0x2d,%al
 4e3:	75 07                	jne    4ec <atoi+0x2e>
 4e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 4ea:	eb 05                	jmp    4f1 <atoi+0x33>
 4ec:	b8 01 00 00 00       	mov    $0x1,%eax
 4f1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 4f4:	8b 45 08             	mov    0x8(%ebp),%eax
 4f7:	0f b6 00             	movzbl (%eax),%eax
 4fa:	3c 2b                	cmp    $0x2b,%al
 4fc:	74 0a                	je     508 <atoi+0x4a>
 4fe:	8b 45 08             	mov    0x8(%ebp),%eax
 501:	0f b6 00             	movzbl (%eax),%eax
 504:	3c 2d                	cmp    $0x2d,%al
 506:	75 2b                	jne    533 <atoi+0x75>
    s++;
 508:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '9')
 50c:	eb 25                	jmp    533 <atoi+0x75>
    n = n*10 + *s++ - '0';
 50e:	8b 55 fc             	mov    -0x4(%ebp),%edx
 511:	89 d0                	mov    %edx,%eax
 513:	c1 e0 02             	shl    $0x2,%eax
 516:	01 d0                	add    %edx,%eax
 518:	01 c0                	add    %eax,%eax
 51a:	89 c1                	mov    %eax,%ecx
 51c:	8b 45 08             	mov    0x8(%ebp),%eax
 51f:	8d 50 01             	lea    0x1(%eax),%edx
 522:	89 55 08             	mov    %edx,0x8(%ebp)
 525:	0f b6 00             	movzbl (%eax),%eax
 528:	0f be c0             	movsbl %al,%eax
 52b:	01 c8                	add    %ecx,%eax
 52d:	83 e8 30             	sub    $0x30,%eax
 530:	89 45 fc             	mov    %eax,-0x4(%ebp)
  n = 0;
  while (*s == ' ') s++;
  sign = (*s == '-') ? -1 : 1;
  if (*s == '+'  || *s == '-')
    s++;
  while('0' <= *s && *s <= '9')
 533:	8b 45 08             	mov    0x8(%ebp),%eax
 536:	0f b6 00             	movzbl (%eax),%eax
 539:	3c 2f                	cmp    $0x2f,%al
 53b:	7e 0a                	jle    547 <atoi+0x89>
 53d:	8b 45 08             	mov    0x8(%ebp),%eax
 540:	0f b6 00             	movzbl (%eax),%eax
 543:	3c 39                	cmp    $0x39,%al
 545:	7e c7                	jle    50e <atoi+0x50>
    n = n*10 + *s++ - '0';
  return sign*n;
 547:	8b 45 f8             	mov    -0x8(%ebp),%eax
 54a:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 54e:	c9                   	leave  
 54f:	c3                   	ret    

00000550 <atoo>:

int
atoo(const char *s)
{
 550:	55                   	push   %ebp
 551:	89 e5                	mov    %esp,%ebp
 553:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 556:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 55d:	eb 04                	jmp    563 <atoo+0x13>
 55f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 563:	8b 45 08             	mov    0x8(%ebp),%eax
 566:	0f b6 00             	movzbl (%eax),%eax
 569:	3c 20                	cmp    $0x20,%al
 56b:	74 f2                	je     55f <atoo+0xf>
  sign = (*s == '-') ? -1 : 1;
 56d:	8b 45 08             	mov    0x8(%ebp),%eax
 570:	0f b6 00             	movzbl (%eax),%eax
 573:	3c 2d                	cmp    $0x2d,%al
 575:	75 07                	jne    57e <atoo+0x2e>
 577:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 57c:	eb 05                	jmp    583 <atoo+0x33>
 57e:	b8 01 00 00 00       	mov    $0x1,%eax
 583:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 586:	8b 45 08             	mov    0x8(%ebp),%eax
 589:	0f b6 00             	movzbl (%eax),%eax
 58c:	3c 2b                	cmp    $0x2b,%al
 58e:	74 0a                	je     59a <atoo+0x4a>
 590:	8b 45 08             	mov    0x8(%ebp),%eax
 593:	0f b6 00             	movzbl (%eax),%eax
 596:	3c 2d                	cmp    $0x2d,%al
 598:	75 27                	jne    5c1 <atoo+0x71>
    s++;
 59a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '7')
 59e:	eb 21                	jmp    5c1 <atoo+0x71>
    n = n*8 + *s++ - '0';
 5a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5a3:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
 5aa:	8b 45 08             	mov    0x8(%ebp),%eax
 5ad:	8d 50 01             	lea    0x1(%eax),%edx
 5b0:	89 55 08             	mov    %edx,0x8(%ebp)
 5b3:	0f b6 00             	movzbl (%eax),%eax
 5b6:	0f be c0             	movsbl %al,%eax
 5b9:	01 c8                	add    %ecx,%eax
 5bb:	83 e8 30             	sub    $0x30,%eax
 5be:	89 45 fc             	mov    %eax,-0x4(%ebp)
  n = 0;
  while (*s == ' ') s++;
  sign = (*s == '-') ? -1 : 1;
  if (*s == '+'  || *s == '-')
    s++;
  while('0' <= *s && *s <= '7')
 5c1:	8b 45 08             	mov    0x8(%ebp),%eax
 5c4:	0f b6 00             	movzbl (%eax),%eax
 5c7:	3c 2f                	cmp    $0x2f,%al
 5c9:	7e 0a                	jle    5d5 <atoo+0x85>
 5cb:	8b 45 08             	mov    0x8(%ebp),%eax
 5ce:	0f b6 00             	movzbl (%eax),%eax
 5d1:	3c 37                	cmp    $0x37,%al
 5d3:	7e cb                	jle    5a0 <atoo+0x50>
    n = n*8 + *s++ - '0';
  return sign*n;
 5d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5d8:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 5dc:	c9                   	leave  
 5dd:	c3                   	ret    

000005de <memmove>:


void*
memmove(void *vdst, void *vsrc, int n)
{
 5de:	55                   	push   %ebp
 5df:	89 e5                	mov    %esp,%ebp
 5e1:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 5e4:	8b 45 08             	mov    0x8(%ebp),%eax
 5e7:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 5ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 5ed:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 5f0:	eb 17                	jmp    609 <memmove+0x2b>
    *dst++ = *src++;
 5f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5f5:	8d 50 01             	lea    0x1(%eax),%edx
 5f8:	89 55 fc             	mov    %edx,-0x4(%ebp)
 5fb:	8b 55 f8             	mov    -0x8(%ebp),%edx
 5fe:	8d 4a 01             	lea    0x1(%edx),%ecx
 601:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 604:	0f b6 12             	movzbl (%edx),%edx
 607:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 609:	8b 45 10             	mov    0x10(%ebp),%eax
 60c:	8d 50 ff             	lea    -0x1(%eax),%edx
 60f:	89 55 10             	mov    %edx,0x10(%ebp)
 612:	85 c0                	test   %eax,%eax
 614:	7f dc                	jg     5f2 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 616:	8b 45 08             	mov    0x8(%ebp),%eax
}
 619:	c9                   	leave  
 61a:	c3                   	ret    

0000061b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 61b:	b8 01 00 00 00       	mov    $0x1,%eax
 620:	cd 40                	int    $0x40
 622:	c3                   	ret    

00000623 <exit>:
SYSCALL(exit)
 623:	b8 02 00 00 00       	mov    $0x2,%eax
 628:	cd 40                	int    $0x40
 62a:	c3                   	ret    

0000062b <wait>:
SYSCALL(wait)
 62b:	b8 03 00 00 00       	mov    $0x3,%eax
 630:	cd 40                	int    $0x40
 632:	c3                   	ret    

00000633 <pipe>:
SYSCALL(pipe)
 633:	b8 04 00 00 00       	mov    $0x4,%eax
 638:	cd 40                	int    $0x40
 63a:	c3                   	ret    

0000063b <read>:
SYSCALL(read)
 63b:	b8 05 00 00 00       	mov    $0x5,%eax
 640:	cd 40                	int    $0x40
 642:	c3                   	ret    

00000643 <write>:
SYSCALL(write)
 643:	b8 10 00 00 00       	mov    $0x10,%eax
 648:	cd 40                	int    $0x40
 64a:	c3                   	ret    

0000064b <close>:
SYSCALL(close)
 64b:	b8 15 00 00 00       	mov    $0x15,%eax
 650:	cd 40                	int    $0x40
 652:	c3                   	ret    

00000653 <kill>:
SYSCALL(kill)
 653:	b8 06 00 00 00       	mov    $0x6,%eax
 658:	cd 40                	int    $0x40
 65a:	c3                   	ret    

0000065b <exec>:
SYSCALL(exec)
 65b:	b8 07 00 00 00       	mov    $0x7,%eax
 660:	cd 40                	int    $0x40
 662:	c3                   	ret    

00000663 <open>:
SYSCALL(open)
 663:	b8 0f 00 00 00       	mov    $0xf,%eax
 668:	cd 40                	int    $0x40
 66a:	c3                   	ret    

0000066b <mknod>:
SYSCALL(mknod)
 66b:	b8 11 00 00 00       	mov    $0x11,%eax
 670:	cd 40                	int    $0x40
 672:	c3                   	ret    

00000673 <unlink>:
SYSCALL(unlink)
 673:	b8 12 00 00 00       	mov    $0x12,%eax
 678:	cd 40                	int    $0x40
 67a:	c3                   	ret    

0000067b <fstat>:
SYSCALL(fstat)
 67b:	b8 08 00 00 00       	mov    $0x8,%eax
 680:	cd 40                	int    $0x40
 682:	c3                   	ret    

00000683 <link>:
SYSCALL(link)
 683:	b8 13 00 00 00       	mov    $0x13,%eax
 688:	cd 40                	int    $0x40
 68a:	c3                   	ret    

0000068b <mkdir>:
SYSCALL(mkdir)
 68b:	b8 14 00 00 00       	mov    $0x14,%eax
 690:	cd 40                	int    $0x40
 692:	c3                   	ret    

00000693 <chdir>:
SYSCALL(chdir)
 693:	b8 09 00 00 00       	mov    $0x9,%eax
 698:	cd 40                	int    $0x40
 69a:	c3                   	ret    

0000069b <dup>:
SYSCALL(dup)
 69b:	b8 0a 00 00 00       	mov    $0xa,%eax
 6a0:	cd 40                	int    $0x40
 6a2:	c3                   	ret    

000006a3 <getpid>:
SYSCALL(getpid)
 6a3:	b8 0b 00 00 00       	mov    $0xb,%eax
 6a8:	cd 40                	int    $0x40
 6aa:	c3                   	ret    

000006ab <sbrk>:
SYSCALL(sbrk)
 6ab:	b8 0c 00 00 00       	mov    $0xc,%eax
 6b0:	cd 40                	int    $0x40
 6b2:	c3                   	ret    

000006b3 <sleep>:
SYSCALL(sleep)
 6b3:	b8 0d 00 00 00       	mov    $0xd,%eax
 6b8:	cd 40                	int    $0x40
 6ba:	c3                   	ret    

000006bb <uptime>:
SYSCALL(uptime)
 6bb:	b8 0e 00 00 00       	mov    $0xe,%eax
 6c0:	cd 40                	int    $0x40
 6c2:	c3                   	ret    

000006c3 <halt>:
SYSCALL(halt)
 6c3:	b8 16 00 00 00       	mov    $0x16,%eax
 6c8:	cd 40                	int    $0x40
 6ca:	c3                   	ret    

000006cb <date>:
SYSCALL(date)
 6cb:	b8 17 00 00 00       	mov    $0x17,%eax
 6d0:	cd 40                	int    $0x40
 6d2:	c3                   	ret    

000006d3 <getuid>:
SYSCALL(getuid)
 6d3:	b8 18 00 00 00       	mov    $0x18,%eax
 6d8:	cd 40                	int    $0x40
 6da:	c3                   	ret    

000006db <getgid>:
SYSCALL(getgid)
 6db:	b8 19 00 00 00       	mov    $0x19,%eax
 6e0:	cd 40                	int    $0x40
 6e2:	c3                   	ret    

000006e3 <getppid>:
SYSCALL(getppid)
 6e3:	b8 1a 00 00 00       	mov    $0x1a,%eax
 6e8:	cd 40                	int    $0x40
 6ea:	c3                   	ret    

000006eb <setuid>:
SYSCALL(setuid)
 6eb:	b8 1b 00 00 00       	mov    $0x1b,%eax
 6f0:	cd 40                	int    $0x40
 6f2:	c3                   	ret    

000006f3 <setgid>:
SYSCALL(setgid)
 6f3:	b8 1c 00 00 00       	mov    $0x1c,%eax
 6f8:	cd 40                	int    $0x40
 6fa:	c3                   	ret    

000006fb <getprocs>:
SYSCALL(getprocs)
 6fb:	b8 1d 00 00 00       	mov    $0x1d,%eax
 700:	cd 40                	int    $0x40
 702:	c3                   	ret    

00000703 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 703:	55                   	push   %ebp
 704:	89 e5                	mov    %esp,%ebp
 706:	83 ec 18             	sub    $0x18,%esp
 709:	8b 45 0c             	mov    0xc(%ebp),%eax
 70c:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 70f:	83 ec 04             	sub    $0x4,%esp
 712:	6a 01                	push   $0x1
 714:	8d 45 f4             	lea    -0xc(%ebp),%eax
 717:	50                   	push   %eax
 718:	ff 75 08             	pushl  0x8(%ebp)
 71b:	e8 23 ff ff ff       	call   643 <write>
 720:	83 c4 10             	add    $0x10,%esp
}
 723:	90                   	nop
 724:	c9                   	leave  
 725:	c3                   	ret    

00000726 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 726:	55                   	push   %ebp
 727:	89 e5                	mov    %esp,%ebp
 729:	53                   	push   %ebx
 72a:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 72d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 734:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 738:	74 17                	je     751 <printint+0x2b>
 73a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 73e:	79 11                	jns    751 <printint+0x2b>
    neg = 1;
 740:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 747:	8b 45 0c             	mov    0xc(%ebp),%eax
 74a:	f7 d8                	neg    %eax
 74c:	89 45 ec             	mov    %eax,-0x14(%ebp)
 74f:	eb 06                	jmp    757 <printint+0x31>
  } else {
    x = xx;
 751:	8b 45 0c             	mov    0xc(%ebp),%eax
 754:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 757:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 75e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 761:	8d 41 01             	lea    0x1(%ecx),%eax
 764:	89 45 f4             	mov    %eax,-0xc(%ebp)
 767:	8b 5d 10             	mov    0x10(%ebp),%ebx
 76a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 76d:	ba 00 00 00 00       	mov    $0x0,%edx
 772:	f7 f3                	div    %ebx
 774:	89 d0                	mov    %edx,%eax
 776:	0f b6 80 5c 0e 00 00 	movzbl 0xe5c(%eax),%eax
 77d:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 781:	8b 5d 10             	mov    0x10(%ebp),%ebx
 784:	8b 45 ec             	mov    -0x14(%ebp),%eax
 787:	ba 00 00 00 00       	mov    $0x0,%edx
 78c:	f7 f3                	div    %ebx
 78e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 791:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 795:	75 c7                	jne    75e <printint+0x38>
  if(neg)
 797:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 79b:	74 2d                	je     7ca <printint+0xa4>
    buf[i++] = '-';
 79d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a0:	8d 50 01             	lea    0x1(%eax),%edx
 7a3:	89 55 f4             	mov    %edx,-0xc(%ebp)
 7a6:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 7ab:	eb 1d                	jmp    7ca <printint+0xa4>
    putc(fd, buf[i]);
 7ad:	8d 55 dc             	lea    -0x24(%ebp),%edx
 7b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b3:	01 d0                	add    %edx,%eax
 7b5:	0f b6 00             	movzbl (%eax),%eax
 7b8:	0f be c0             	movsbl %al,%eax
 7bb:	83 ec 08             	sub    $0x8,%esp
 7be:	50                   	push   %eax
 7bf:	ff 75 08             	pushl  0x8(%ebp)
 7c2:	e8 3c ff ff ff       	call   703 <putc>
 7c7:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 7ca:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 7ce:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7d2:	79 d9                	jns    7ad <printint+0x87>
    putc(fd, buf[i]);
}
 7d4:	90                   	nop
 7d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 7d8:	c9                   	leave  
 7d9:	c3                   	ret    

000007da <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 7da:	55                   	push   %ebp
 7db:	89 e5                	mov    %esp,%ebp
 7dd:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 7e0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 7e7:	8d 45 0c             	lea    0xc(%ebp),%eax
 7ea:	83 c0 04             	add    $0x4,%eax
 7ed:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 7f0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 7f7:	e9 59 01 00 00       	jmp    955 <printf+0x17b>
    c = fmt[i] & 0xff;
 7fc:	8b 55 0c             	mov    0xc(%ebp),%edx
 7ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
 802:	01 d0                	add    %edx,%eax
 804:	0f b6 00             	movzbl (%eax),%eax
 807:	0f be c0             	movsbl %al,%eax
 80a:	25 ff 00 00 00       	and    $0xff,%eax
 80f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 812:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 816:	75 2c                	jne    844 <printf+0x6a>
      if(c == '%'){
 818:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 81c:	75 0c                	jne    82a <printf+0x50>
        state = '%';
 81e:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 825:	e9 27 01 00 00       	jmp    951 <printf+0x177>
      } else {
        putc(fd, c);
 82a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 82d:	0f be c0             	movsbl %al,%eax
 830:	83 ec 08             	sub    $0x8,%esp
 833:	50                   	push   %eax
 834:	ff 75 08             	pushl  0x8(%ebp)
 837:	e8 c7 fe ff ff       	call   703 <putc>
 83c:	83 c4 10             	add    $0x10,%esp
 83f:	e9 0d 01 00 00       	jmp    951 <printf+0x177>
      }
    } else if(state == '%'){
 844:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 848:	0f 85 03 01 00 00    	jne    951 <printf+0x177>
      if(c == 'd'){
 84e:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 852:	75 1e                	jne    872 <printf+0x98>
        printint(fd, *ap, 10, 1);
 854:	8b 45 e8             	mov    -0x18(%ebp),%eax
 857:	8b 00                	mov    (%eax),%eax
 859:	6a 01                	push   $0x1
 85b:	6a 0a                	push   $0xa
 85d:	50                   	push   %eax
 85e:	ff 75 08             	pushl  0x8(%ebp)
 861:	e8 c0 fe ff ff       	call   726 <printint>
 866:	83 c4 10             	add    $0x10,%esp
        ap++;
 869:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 86d:	e9 d8 00 00 00       	jmp    94a <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 872:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 876:	74 06                	je     87e <printf+0xa4>
 878:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 87c:	75 1e                	jne    89c <printf+0xc2>
        printint(fd, *ap, 16, 0);
 87e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 881:	8b 00                	mov    (%eax),%eax
 883:	6a 00                	push   $0x0
 885:	6a 10                	push   $0x10
 887:	50                   	push   %eax
 888:	ff 75 08             	pushl  0x8(%ebp)
 88b:	e8 96 fe ff ff       	call   726 <printint>
 890:	83 c4 10             	add    $0x10,%esp
        ap++;
 893:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 897:	e9 ae 00 00 00       	jmp    94a <printf+0x170>
      } else if(c == 's'){
 89c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 8a0:	75 43                	jne    8e5 <printf+0x10b>
        s = (char*)*ap;
 8a2:	8b 45 e8             	mov    -0x18(%ebp),%eax
 8a5:	8b 00                	mov    (%eax),%eax
 8a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 8aa:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 8ae:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8b2:	75 25                	jne    8d9 <printf+0xff>
          s = "(null)";
 8b4:	c7 45 f4 ea 0b 00 00 	movl   $0xbea,-0xc(%ebp)
        while(*s != 0){
 8bb:	eb 1c                	jmp    8d9 <printf+0xff>
          putc(fd, *s);
 8bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c0:	0f b6 00             	movzbl (%eax),%eax
 8c3:	0f be c0             	movsbl %al,%eax
 8c6:	83 ec 08             	sub    $0x8,%esp
 8c9:	50                   	push   %eax
 8ca:	ff 75 08             	pushl  0x8(%ebp)
 8cd:	e8 31 fe ff ff       	call   703 <putc>
 8d2:	83 c4 10             	add    $0x10,%esp
          s++;
 8d5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 8d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8dc:	0f b6 00             	movzbl (%eax),%eax
 8df:	84 c0                	test   %al,%al
 8e1:	75 da                	jne    8bd <printf+0xe3>
 8e3:	eb 65                	jmp    94a <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 8e5:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 8e9:	75 1d                	jne    908 <printf+0x12e>
        putc(fd, *ap);
 8eb:	8b 45 e8             	mov    -0x18(%ebp),%eax
 8ee:	8b 00                	mov    (%eax),%eax
 8f0:	0f be c0             	movsbl %al,%eax
 8f3:	83 ec 08             	sub    $0x8,%esp
 8f6:	50                   	push   %eax
 8f7:	ff 75 08             	pushl  0x8(%ebp)
 8fa:	e8 04 fe ff ff       	call   703 <putc>
 8ff:	83 c4 10             	add    $0x10,%esp
        ap++;
 902:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 906:	eb 42                	jmp    94a <printf+0x170>
      } else if(c == '%'){
 908:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 90c:	75 17                	jne    925 <printf+0x14b>
        putc(fd, c);
 90e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 911:	0f be c0             	movsbl %al,%eax
 914:	83 ec 08             	sub    $0x8,%esp
 917:	50                   	push   %eax
 918:	ff 75 08             	pushl  0x8(%ebp)
 91b:	e8 e3 fd ff ff       	call   703 <putc>
 920:	83 c4 10             	add    $0x10,%esp
 923:	eb 25                	jmp    94a <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 925:	83 ec 08             	sub    $0x8,%esp
 928:	6a 25                	push   $0x25
 92a:	ff 75 08             	pushl  0x8(%ebp)
 92d:	e8 d1 fd ff ff       	call   703 <putc>
 932:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 935:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 938:	0f be c0             	movsbl %al,%eax
 93b:	83 ec 08             	sub    $0x8,%esp
 93e:	50                   	push   %eax
 93f:	ff 75 08             	pushl  0x8(%ebp)
 942:	e8 bc fd ff ff       	call   703 <putc>
 947:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 94a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 951:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 955:	8b 55 0c             	mov    0xc(%ebp),%edx
 958:	8b 45 f0             	mov    -0x10(%ebp),%eax
 95b:	01 d0                	add    %edx,%eax
 95d:	0f b6 00             	movzbl (%eax),%eax
 960:	84 c0                	test   %al,%al
 962:	0f 85 94 fe ff ff    	jne    7fc <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 968:	90                   	nop
 969:	c9                   	leave  
 96a:	c3                   	ret    

0000096b <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 96b:	55                   	push   %ebp
 96c:	89 e5                	mov    %esp,%ebp
 96e:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 971:	8b 45 08             	mov    0x8(%ebp),%eax
 974:	83 e8 08             	sub    $0x8,%eax
 977:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 97a:	a1 78 0e 00 00       	mov    0xe78,%eax
 97f:	89 45 fc             	mov    %eax,-0x4(%ebp)
 982:	eb 24                	jmp    9a8 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 984:	8b 45 fc             	mov    -0x4(%ebp),%eax
 987:	8b 00                	mov    (%eax),%eax
 989:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 98c:	77 12                	ja     9a0 <free+0x35>
 98e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 991:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 994:	77 24                	ja     9ba <free+0x4f>
 996:	8b 45 fc             	mov    -0x4(%ebp),%eax
 999:	8b 00                	mov    (%eax),%eax
 99b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 99e:	77 1a                	ja     9ba <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9a3:	8b 00                	mov    (%eax),%eax
 9a5:	89 45 fc             	mov    %eax,-0x4(%ebp)
 9a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9ab:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 9ae:	76 d4                	jbe    984 <free+0x19>
 9b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9b3:	8b 00                	mov    (%eax),%eax
 9b5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 9b8:	76 ca                	jbe    984 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 9ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9bd:	8b 40 04             	mov    0x4(%eax),%eax
 9c0:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 9c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9ca:	01 c2                	add    %eax,%edx
 9cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9cf:	8b 00                	mov    (%eax),%eax
 9d1:	39 c2                	cmp    %eax,%edx
 9d3:	75 24                	jne    9f9 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 9d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9d8:	8b 50 04             	mov    0x4(%eax),%edx
 9db:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9de:	8b 00                	mov    (%eax),%eax
 9e0:	8b 40 04             	mov    0x4(%eax),%eax
 9e3:	01 c2                	add    %eax,%edx
 9e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9e8:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 9eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9ee:	8b 00                	mov    (%eax),%eax
 9f0:	8b 10                	mov    (%eax),%edx
 9f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9f5:	89 10                	mov    %edx,(%eax)
 9f7:	eb 0a                	jmp    a03 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 9f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9fc:	8b 10                	mov    (%eax),%edx
 9fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a01:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 a03:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a06:	8b 40 04             	mov    0x4(%eax),%eax
 a09:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 a10:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a13:	01 d0                	add    %edx,%eax
 a15:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 a18:	75 20                	jne    a3a <free+0xcf>
    p->s.size += bp->s.size;
 a1a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a1d:	8b 50 04             	mov    0x4(%eax),%edx
 a20:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a23:	8b 40 04             	mov    0x4(%eax),%eax
 a26:	01 c2                	add    %eax,%edx
 a28:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a2b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 a2e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a31:	8b 10                	mov    (%eax),%edx
 a33:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a36:	89 10                	mov    %edx,(%eax)
 a38:	eb 08                	jmp    a42 <free+0xd7>
  } else
    p->s.ptr = bp;
 a3a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a3d:	8b 55 f8             	mov    -0x8(%ebp),%edx
 a40:	89 10                	mov    %edx,(%eax)
  freep = p;
 a42:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a45:	a3 78 0e 00 00       	mov    %eax,0xe78
}
 a4a:	90                   	nop
 a4b:	c9                   	leave  
 a4c:	c3                   	ret    

00000a4d <morecore>:

static Header*
morecore(uint nu)
{
 a4d:	55                   	push   %ebp
 a4e:	89 e5                	mov    %esp,%ebp
 a50:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 a53:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 a5a:	77 07                	ja     a63 <morecore+0x16>
    nu = 4096;
 a5c:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 a63:	8b 45 08             	mov    0x8(%ebp),%eax
 a66:	c1 e0 03             	shl    $0x3,%eax
 a69:	83 ec 0c             	sub    $0xc,%esp
 a6c:	50                   	push   %eax
 a6d:	e8 39 fc ff ff       	call   6ab <sbrk>
 a72:	83 c4 10             	add    $0x10,%esp
 a75:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 a78:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 a7c:	75 07                	jne    a85 <morecore+0x38>
    return 0;
 a7e:	b8 00 00 00 00       	mov    $0x0,%eax
 a83:	eb 26                	jmp    aab <morecore+0x5e>
  hp = (Header*)p;
 a85:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a88:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 a8b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a8e:	8b 55 08             	mov    0x8(%ebp),%edx
 a91:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 a94:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a97:	83 c0 08             	add    $0x8,%eax
 a9a:	83 ec 0c             	sub    $0xc,%esp
 a9d:	50                   	push   %eax
 a9e:	e8 c8 fe ff ff       	call   96b <free>
 aa3:	83 c4 10             	add    $0x10,%esp
  return freep;
 aa6:	a1 78 0e 00 00       	mov    0xe78,%eax
}
 aab:	c9                   	leave  
 aac:	c3                   	ret    

00000aad <malloc>:

void*
malloc(uint nbytes)
{
 aad:	55                   	push   %ebp
 aae:	89 e5                	mov    %esp,%ebp
 ab0:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ab3:	8b 45 08             	mov    0x8(%ebp),%eax
 ab6:	83 c0 07             	add    $0x7,%eax
 ab9:	c1 e8 03             	shr    $0x3,%eax
 abc:	83 c0 01             	add    $0x1,%eax
 abf:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 ac2:	a1 78 0e 00 00       	mov    0xe78,%eax
 ac7:	89 45 f0             	mov    %eax,-0x10(%ebp)
 aca:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 ace:	75 23                	jne    af3 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 ad0:	c7 45 f0 70 0e 00 00 	movl   $0xe70,-0x10(%ebp)
 ad7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 ada:	a3 78 0e 00 00       	mov    %eax,0xe78
 adf:	a1 78 0e 00 00       	mov    0xe78,%eax
 ae4:	a3 70 0e 00 00       	mov    %eax,0xe70
    base.s.size = 0;
 ae9:	c7 05 74 0e 00 00 00 	movl   $0x0,0xe74
 af0:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 af3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 af6:	8b 00                	mov    (%eax),%eax
 af8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 afb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 afe:	8b 40 04             	mov    0x4(%eax),%eax
 b01:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 b04:	72 4d                	jb     b53 <malloc+0xa6>
      if(p->s.size == nunits)
 b06:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b09:	8b 40 04             	mov    0x4(%eax),%eax
 b0c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 b0f:	75 0c                	jne    b1d <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 b11:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b14:	8b 10                	mov    (%eax),%edx
 b16:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b19:	89 10                	mov    %edx,(%eax)
 b1b:	eb 26                	jmp    b43 <malloc+0x96>
      else {
        p->s.size -= nunits;
 b1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b20:	8b 40 04             	mov    0x4(%eax),%eax
 b23:	2b 45 ec             	sub    -0x14(%ebp),%eax
 b26:	89 c2                	mov    %eax,%edx
 b28:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b2b:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 b2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b31:	8b 40 04             	mov    0x4(%eax),%eax
 b34:	c1 e0 03             	shl    $0x3,%eax
 b37:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 b3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b3d:	8b 55 ec             	mov    -0x14(%ebp),%edx
 b40:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 b43:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b46:	a3 78 0e 00 00       	mov    %eax,0xe78
      return (void*)(p + 1);
 b4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b4e:	83 c0 08             	add    $0x8,%eax
 b51:	eb 3b                	jmp    b8e <malloc+0xe1>
    }
    if(p == freep)
 b53:	a1 78 0e 00 00       	mov    0xe78,%eax
 b58:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 b5b:	75 1e                	jne    b7b <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 b5d:	83 ec 0c             	sub    $0xc,%esp
 b60:	ff 75 ec             	pushl  -0x14(%ebp)
 b63:	e8 e5 fe ff ff       	call   a4d <morecore>
 b68:	83 c4 10             	add    $0x10,%esp
 b6b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 b6e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 b72:	75 07                	jne    b7b <malloc+0xce>
        return 0;
 b74:	b8 00 00 00 00       	mov    $0x0,%eax
 b79:	eb 13                	jmp    b8e <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b7b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b7e:	89 45 f0             	mov    %eax,-0x10(%ebp)
 b81:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b84:	8b 00                	mov    (%eax),%eax
 b86:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 b89:	e9 6d ff ff ff       	jmp    afb <malloc+0x4e>
}
 b8e:	c9                   	leave  
 b8f:	c3                   	ret    
