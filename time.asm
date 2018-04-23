
_time:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#ifdef CS333_P2
#include "types.h"
#include "user.h"
int
main(int argc, char * argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
   f:	83 ec 10             	sub    $0x10,%esp
  12:	89 cb                	mov    %ecx,%ebx
  if(argc < 2)
  14:	83 3b 01             	cmpl   $0x1,(%ebx)
  17:	7f 17                	jg     30 <main+0x30>
  {
    printf(1, "Time took 0.00 seconds\n");
  19:	83 ec 08             	sub    $0x8,%esp
  1c:	68 e8 09 00 00       	push   $0x9e8
  21:	6a 01                	push   $0x1
  23:	e8 0a 06 00 00       	call   632 <printf>
  28:	83 c4 10             	add    $0x10,%esp
    exit();
  2b:	e8 4b 04 00 00       	call   47b <exit>
  }
  
  int timeInit = uptime();
  30:	e8 de 04 00 00       	call   513 <uptime>
  35:	89 45 f4             	mov    %eax,-0xc(%ebp)

  int retPid = fork();
  38:	e8 36 04 00 00       	call   473 <fork>
  3d:	89 45 f0             	mov    %eax,-0x10(%ebp)

  if(retPid < 0)
  40:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  44:	79 05                	jns    4b <main+0x4b>
    exit();
  46:	e8 30 04 00 00       	call   47b <exit>

  if(retPid == 0)
  4b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  4f:	75 20                	jne    71 <main+0x71>
  {
    exec(argv[1], argv+1);
  51:	8b 43 04             	mov    0x4(%ebx),%eax
  54:	8d 50 04             	lea    0x4(%eax),%edx
  57:	8b 43 04             	mov    0x4(%ebx),%eax
  5a:	83 c0 04             	add    $0x4,%eax
  5d:	8b 00                	mov    (%eax),%eax
  5f:	83 ec 08             	sub    $0x8,%esp
  62:	52                   	push   %edx
  63:	50                   	push   %eax
  64:	e8 4a 04 00 00       	call   4b3 <exec>
  69:	83 c4 10             	add    $0x10,%esp
    exit();
  6c:	e8 0a 04 00 00       	call   47b <exit>
  }

  if(retPid > 0)
  71:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  75:	0f 8e d1 00 00 00    	jle    14c <main+0x14c>
  {
    wait();
  7b:	e8 03 04 00 00       	call   483 <wait>
    int time = uptime();
  80:	e8 8e 04 00 00       	call   513 <uptime>
  85:	89 45 ec             	mov    %eax,-0x14(%ebp)
    time = time - timeInit;
  88:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8b:	29 45 ec             	sub    %eax,-0x14(%ebp)
    int decim = time % 1000;
  8e:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  91:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
  96:	89 c8                	mov    %ecx,%eax
  98:	f7 ea                	imul   %edx
  9a:	c1 fa 06             	sar    $0x6,%edx
  9d:	89 c8                	mov    %ecx,%eax
  9f:	c1 f8 1f             	sar    $0x1f,%eax
  a2:	29 c2                	sub    %eax,%edx
  a4:	89 d0                	mov    %edx,%eax
  a6:	69 c0 e8 03 00 00    	imul   $0x3e8,%eax,%eax
  ac:	29 c1                	sub    %eax,%ecx
  ae:	89 c8                	mov    %ecx,%eax
  b0:	89 45 e8             	mov    %eax,-0x18(%ebp)
    time /= 1000;
  b3:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  b6:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
  bb:	89 c8                	mov    %ecx,%eax
  bd:	f7 ea                	imul   %edx
  bf:	c1 fa 06             	sar    $0x6,%edx
  c2:	89 c8                	mov    %ecx,%eax
  c4:	c1 f8 1f             	sar    $0x1f,%eax
  c7:	29 c2                	sub    %eax,%edx
  c9:	89 d0                	mov    %edx,%eax
  cb:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(decim < 10)
  ce:	83 7d e8 09          	cmpl   $0x9,-0x18(%ebp)
  d2:	7f 23                	jg     f7 <main+0xf7>
      printf(1, "%s ran in %d.00%d seconds\n",argv[1], time, decim);
  d4:	8b 43 04             	mov    0x4(%ebx),%eax
  d7:	83 c0 04             	add    $0x4,%eax
  da:	8b 00                	mov    (%eax),%eax
  dc:	83 ec 0c             	sub    $0xc,%esp
  df:	ff 75 e8             	pushl  -0x18(%ebp)
  e2:	ff 75 ec             	pushl  -0x14(%ebp)
  e5:	50                   	push   %eax
  e6:	68 00 0a 00 00       	push   $0xa00
  eb:	6a 01                	push   $0x1
  ed:	e8 40 05 00 00       	call   632 <printf>
  f2:	83 c4 20             	add    $0x20,%esp
  f5:	eb 50                	jmp    147 <main+0x147>
    else if(decim < 100 && decim >= 10)
  f7:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
  fb:	7f 29                	jg     126 <main+0x126>
  fd:	83 7d e8 09          	cmpl   $0x9,-0x18(%ebp)
 101:	7e 23                	jle    126 <main+0x126>
      printf(1, "%s ran in %d.0%d seconds\n", argv[1], time, decim);
 103:	8b 43 04             	mov    0x4(%ebx),%eax
 106:	83 c0 04             	add    $0x4,%eax
 109:	8b 00                	mov    (%eax),%eax
 10b:	83 ec 0c             	sub    $0xc,%esp
 10e:	ff 75 e8             	pushl  -0x18(%ebp)
 111:	ff 75 ec             	pushl  -0x14(%ebp)
 114:	50                   	push   %eax
 115:	68 1b 0a 00 00       	push   $0xa1b
 11a:	6a 01                	push   $0x1
 11c:	e8 11 05 00 00       	call   632 <printf>
 121:	83 c4 20             	add    $0x20,%esp
 124:	eb 21                	jmp    147 <main+0x147>
    else
      printf(1, "%s ran in %d.%d seconds\n", argv[1], time, decim);
 126:	8b 43 04             	mov    0x4(%ebx),%eax
 129:	83 c0 04             	add    $0x4,%eax
 12c:	8b 00                	mov    (%eax),%eax
 12e:	83 ec 0c             	sub    $0xc,%esp
 131:	ff 75 e8             	pushl  -0x18(%ebp)
 134:	ff 75 ec             	pushl  -0x14(%ebp)
 137:	50                   	push   %eax
 138:	68 35 0a 00 00       	push   $0xa35
 13d:	6a 01                	push   $0x1
 13f:	e8 ee 04 00 00       	call   632 <printf>
 144:	83 c4 20             	add    $0x20,%esp
    exit();
 147:	e8 2f 03 00 00       	call   47b <exit>
  }


  exit();
 14c:	e8 2a 03 00 00       	call   47b <exit>

00000151 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 151:	55                   	push   %ebp
 152:	89 e5                	mov    %esp,%ebp
 154:	57                   	push   %edi
 155:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 156:	8b 4d 08             	mov    0x8(%ebp),%ecx
 159:	8b 55 10             	mov    0x10(%ebp),%edx
 15c:	8b 45 0c             	mov    0xc(%ebp),%eax
 15f:	89 cb                	mov    %ecx,%ebx
 161:	89 df                	mov    %ebx,%edi
 163:	89 d1                	mov    %edx,%ecx
 165:	fc                   	cld    
 166:	f3 aa                	rep stos %al,%es:(%edi)
 168:	89 ca                	mov    %ecx,%edx
 16a:	89 fb                	mov    %edi,%ebx
 16c:	89 5d 08             	mov    %ebx,0x8(%ebp)
 16f:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 172:	90                   	nop
 173:	5b                   	pop    %ebx
 174:	5f                   	pop    %edi
 175:	5d                   	pop    %ebp
 176:	c3                   	ret    

00000177 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 177:	55                   	push   %ebp
 178:	89 e5                	mov    %esp,%ebp
 17a:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 17d:	8b 45 08             	mov    0x8(%ebp),%eax
 180:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 183:	90                   	nop
 184:	8b 45 08             	mov    0x8(%ebp),%eax
 187:	8d 50 01             	lea    0x1(%eax),%edx
 18a:	89 55 08             	mov    %edx,0x8(%ebp)
 18d:	8b 55 0c             	mov    0xc(%ebp),%edx
 190:	8d 4a 01             	lea    0x1(%edx),%ecx
 193:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 196:	0f b6 12             	movzbl (%edx),%edx
 199:	88 10                	mov    %dl,(%eax)
 19b:	0f b6 00             	movzbl (%eax),%eax
 19e:	84 c0                	test   %al,%al
 1a0:	75 e2                	jne    184 <strcpy+0xd>
    ;
  return os;
 1a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1a5:	c9                   	leave  
 1a6:	c3                   	ret    

000001a7 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1a7:	55                   	push   %ebp
 1a8:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 1aa:	eb 08                	jmp    1b4 <strcmp+0xd>
    p++, q++;
 1ac:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1b0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1b4:	8b 45 08             	mov    0x8(%ebp),%eax
 1b7:	0f b6 00             	movzbl (%eax),%eax
 1ba:	84 c0                	test   %al,%al
 1bc:	74 10                	je     1ce <strcmp+0x27>
 1be:	8b 45 08             	mov    0x8(%ebp),%eax
 1c1:	0f b6 10             	movzbl (%eax),%edx
 1c4:	8b 45 0c             	mov    0xc(%ebp),%eax
 1c7:	0f b6 00             	movzbl (%eax),%eax
 1ca:	38 c2                	cmp    %al,%dl
 1cc:	74 de                	je     1ac <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1ce:	8b 45 08             	mov    0x8(%ebp),%eax
 1d1:	0f b6 00             	movzbl (%eax),%eax
 1d4:	0f b6 d0             	movzbl %al,%edx
 1d7:	8b 45 0c             	mov    0xc(%ebp),%eax
 1da:	0f b6 00             	movzbl (%eax),%eax
 1dd:	0f b6 c0             	movzbl %al,%eax
 1e0:	29 c2                	sub    %eax,%edx
 1e2:	89 d0                	mov    %edx,%eax
}
 1e4:	5d                   	pop    %ebp
 1e5:	c3                   	ret    

000001e6 <strlen>:

uint
strlen(char *s)
{
 1e6:	55                   	push   %ebp
 1e7:	89 e5                	mov    %esp,%ebp
 1e9:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1ec:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1f3:	eb 04                	jmp    1f9 <strlen+0x13>
 1f5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1f9:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1fc:	8b 45 08             	mov    0x8(%ebp),%eax
 1ff:	01 d0                	add    %edx,%eax
 201:	0f b6 00             	movzbl (%eax),%eax
 204:	84 c0                	test   %al,%al
 206:	75 ed                	jne    1f5 <strlen+0xf>
    ;
  return n;
 208:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 20b:	c9                   	leave  
 20c:	c3                   	ret    

0000020d <memset>:

void*
memset(void *dst, int c, uint n)
{
 20d:	55                   	push   %ebp
 20e:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 210:	8b 45 10             	mov    0x10(%ebp),%eax
 213:	50                   	push   %eax
 214:	ff 75 0c             	pushl  0xc(%ebp)
 217:	ff 75 08             	pushl  0x8(%ebp)
 21a:	e8 32 ff ff ff       	call   151 <stosb>
 21f:	83 c4 0c             	add    $0xc,%esp
  return dst;
 222:	8b 45 08             	mov    0x8(%ebp),%eax
}
 225:	c9                   	leave  
 226:	c3                   	ret    

00000227 <strchr>:

char*
strchr(const char *s, char c)
{
 227:	55                   	push   %ebp
 228:	89 e5                	mov    %esp,%ebp
 22a:	83 ec 04             	sub    $0x4,%esp
 22d:	8b 45 0c             	mov    0xc(%ebp),%eax
 230:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 233:	eb 14                	jmp    249 <strchr+0x22>
    if(*s == c)
 235:	8b 45 08             	mov    0x8(%ebp),%eax
 238:	0f b6 00             	movzbl (%eax),%eax
 23b:	3a 45 fc             	cmp    -0x4(%ebp),%al
 23e:	75 05                	jne    245 <strchr+0x1e>
      return (char*)s;
 240:	8b 45 08             	mov    0x8(%ebp),%eax
 243:	eb 13                	jmp    258 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 245:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 249:	8b 45 08             	mov    0x8(%ebp),%eax
 24c:	0f b6 00             	movzbl (%eax),%eax
 24f:	84 c0                	test   %al,%al
 251:	75 e2                	jne    235 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 253:	b8 00 00 00 00       	mov    $0x0,%eax
}
 258:	c9                   	leave  
 259:	c3                   	ret    

0000025a <gets>:

char*
gets(char *buf, int max)
{
 25a:	55                   	push   %ebp
 25b:	89 e5                	mov    %esp,%ebp
 25d:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 260:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 267:	eb 42                	jmp    2ab <gets+0x51>
    cc = read(0, &c, 1);
 269:	83 ec 04             	sub    $0x4,%esp
 26c:	6a 01                	push   $0x1
 26e:	8d 45 ef             	lea    -0x11(%ebp),%eax
 271:	50                   	push   %eax
 272:	6a 00                	push   $0x0
 274:	e8 1a 02 00 00       	call   493 <read>
 279:	83 c4 10             	add    $0x10,%esp
 27c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 27f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 283:	7e 33                	jle    2b8 <gets+0x5e>
      break;
    buf[i++] = c;
 285:	8b 45 f4             	mov    -0xc(%ebp),%eax
 288:	8d 50 01             	lea    0x1(%eax),%edx
 28b:	89 55 f4             	mov    %edx,-0xc(%ebp)
 28e:	89 c2                	mov    %eax,%edx
 290:	8b 45 08             	mov    0x8(%ebp),%eax
 293:	01 c2                	add    %eax,%edx
 295:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 299:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 29b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 29f:	3c 0a                	cmp    $0xa,%al
 2a1:	74 16                	je     2b9 <gets+0x5f>
 2a3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2a7:	3c 0d                	cmp    $0xd,%al
 2a9:	74 0e                	je     2b9 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2ae:	83 c0 01             	add    $0x1,%eax
 2b1:	3b 45 0c             	cmp    0xc(%ebp),%eax
 2b4:	7c b3                	jl     269 <gets+0xf>
 2b6:	eb 01                	jmp    2b9 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 2b8:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2b9:	8b 55 f4             	mov    -0xc(%ebp),%edx
 2bc:	8b 45 08             	mov    0x8(%ebp),%eax
 2bf:	01 d0                	add    %edx,%eax
 2c1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 2c4:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2c7:	c9                   	leave  
 2c8:	c3                   	ret    

000002c9 <stat>:

int
stat(char *n, struct stat *st)
{
 2c9:	55                   	push   %ebp
 2ca:	89 e5                	mov    %esp,%ebp
 2cc:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2cf:	83 ec 08             	sub    $0x8,%esp
 2d2:	6a 00                	push   $0x0
 2d4:	ff 75 08             	pushl  0x8(%ebp)
 2d7:	e8 df 01 00 00       	call   4bb <open>
 2dc:	83 c4 10             	add    $0x10,%esp
 2df:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2e2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2e6:	79 07                	jns    2ef <stat+0x26>
    return -1;
 2e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2ed:	eb 25                	jmp    314 <stat+0x4b>
  r = fstat(fd, st);
 2ef:	83 ec 08             	sub    $0x8,%esp
 2f2:	ff 75 0c             	pushl  0xc(%ebp)
 2f5:	ff 75 f4             	pushl  -0xc(%ebp)
 2f8:	e8 d6 01 00 00       	call   4d3 <fstat>
 2fd:	83 c4 10             	add    $0x10,%esp
 300:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 303:	83 ec 0c             	sub    $0xc,%esp
 306:	ff 75 f4             	pushl  -0xc(%ebp)
 309:	e8 95 01 00 00       	call   4a3 <close>
 30e:	83 c4 10             	add    $0x10,%esp
  return r;
 311:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 314:	c9                   	leave  
 315:	c3                   	ret    

00000316 <atoi>:

int
atoi(const char *s)
{
 316:	55                   	push   %ebp
 317:	89 e5                	mov    %esp,%ebp
 319:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 31c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 323:	eb 04                	jmp    329 <atoi+0x13>
 325:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 329:	8b 45 08             	mov    0x8(%ebp),%eax
 32c:	0f b6 00             	movzbl (%eax),%eax
 32f:	3c 20                	cmp    $0x20,%al
 331:	74 f2                	je     325 <atoi+0xf>
  sign = (*s == '-') ? -1 : 1;
 333:	8b 45 08             	mov    0x8(%ebp),%eax
 336:	0f b6 00             	movzbl (%eax),%eax
 339:	3c 2d                	cmp    $0x2d,%al
 33b:	75 07                	jne    344 <atoi+0x2e>
 33d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 342:	eb 05                	jmp    349 <atoi+0x33>
 344:	b8 01 00 00 00       	mov    $0x1,%eax
 349:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 34c:	8b 45 08             	mov    0x8(%ebp),%eax
 34f:	0f b6 00             	movzbl (%eax),%eax
 352:	3c 2b                	cmp    $0x2b,%al
 354:	74 0a                	je     360 <atoi+0x4a>
 356:	8b 45 08             	mov    0x8(%ebp),%eax
 359:	0f b6 00             	movzbl (%eax),%eax
 35c:	3c 2d                	cmp    $0x2d,%al
 35e:	75 2b                	jne    38b <atoi+0x75>
    s++;
 360:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '9')
 364:	eb 25                	jmp    38b <atoi+0x75>
    n = n*10 + *s++ - '0';
 366:	8b 55 fc             	mov    -0x4(%ebp),%edx
 369:	89 d0                	mov    %edx,%eax
 36b:	c1 e0 02             	shl    $0x2,%eax
 36e:	01 d0                	add    %edx,%eax
 370:	01 c0                	add    %eax,%eax
 372:	89 c1                	mov    %eax,%ecx
 374:	8b 45 08             	mov    0x8(%ebp),%eax
 377:	8d 50 01             	lea    0x1(%eax),%edx
 37a:	89 55 08             	mov    %edx,0x8(%ebp)
 37d:	0f b6 00             	movzbl (%eax),%eax
 380:	0f be c0             	movsbl %al,%eax
 383:	01 c8                	add    %ecx,%eax
 385:	83 e8 30             	sub    $0x30,%eax
 388:	89 45 fc             	mov    %eax,-0x4(%ebp)
  n = 0;
  while (*s == ' ') s++;
  sign = (*s == '-') ? -1 : 1;
  if (*s == '+'  || *s == '-')
    s++;
  while('0' <= *s && *s <= '9')
 38b:	8b 45 08             	mov    0x8(%ebp),%eax
 38e:	0f b6 00             	movzbl (%eax),%eax
 391:	3c 2f                	cmp    $0x2f,%al
 393:	7e 0a                	jle    39f <atoi+0x89>
 395:	8b 45 08             	mov    0x8(%ebp),%eax
 398:	0f b6 00             	movzbl (%eax),%eax
 39b:	3c 39                	cmp    $0x39,%al
 39d:	7e c7                	jle    366 <atoi+0x50>
    n = n*10 + *s++ - '0';
  return sign*n;
 39f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 3a2:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 3a6:	c9                   	leave  
 3a7:	c3                   	ret    

000003a8 <atoo>:

int
atoo(const char *s)
{
 3a8:	55                   	push   %ebp
 3a9:	89 e5                	mov    %esp,%ebp
 3ab:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 3ae:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 3b5:	eb 04                	jmp    3bb <atoo+0x13>
 3b7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 3bb:	8b 45 08             	mov    0x8(%ebp),%eax
 3be:	0f b6 00             	movzbl (%eax),%eax
 3c1:	3c 20                	cmp    $0x20,%al
 3c3:	74 f2                	je     3b7 <atoo+0xf>
  sign = (*s == '-') ? -1 : 1;
 3c5:	8b 45 08             	mov    0x8(%ebp),%eax
 3c8:	0f b6 00             	movzbl (%eax),%eax
 3cb:	3c 2d                	cmp    $0x2d,%al
 3cd:	75 07                	jne    3d6 <atoo+0x2e>
 3cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 3d4:	eb 05                	jmp    3db <atoo+0x33>
 3d6:	b8 01 00 00 00       	mov    $0x1,%eax
 3db:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 3de:	8b 45 08             	mov    0x8(%ebp),%eax
 3e1:	0f b6 00             	movzbl (%eax),%eax
 3e4:	3c 2b                	cmp    $0x2b,%al
 3e6:	74 0a                	je     3f2 <atoo+0x4a>
 3e8:	8b 45 08             	mov    0x8(%ebp),%eax
 3eb:	0f b6 00             	movzbl (%eax),%eax
 3ee:	3c 2d                	cmp    $0x2d,%al
 3f0:	75 27                	jne    419 <atoo+0x71>
    s++;
 3f2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '7')
 3f6:	eb 21                	jmp    419 <atoo+0x71>
    n = n*8 + *s++ - '0';
 3f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3fb:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
 402:	8b 45 08             	mov    0x8(%ebp),%eax
 405:	8d 50 01             	lea    0x1(%eax),%edx
 408:	89 55 08             	mov    %edx,0x8(%ebp)
 40b:	0f b6 00             	movzbl (%eax),%eax
 40e:	0f be c0             	movsbl %al,%eax
 411:	01 c8                	add    %ecx,%eax
 413:	83 e8 30             	sub    $0x30,%eax
 416:	89 45 fc             	mov    %eax,-0x4(%ebp)
  n = 0;
  while (*s == ' ') s++;
  sign = (*s == '-') ? -1 : 1;
  if (*s == '+'  || *s == '-')
    s++;
  while('0' <= *s && *s <= '7')
 419:	8b 45 08             	mov    0x8(%ebp),%eax
 41c:	0f b6 00             	movzbl (%eax),%eax
 41f:	3c 2f                	cmp    $0x2f,%al
 421:	7e 0a                	jle    42d <atoo+0x85>
 423:	8b 45 08             	mov    0x8(%ebp),%eax
 426:	0f b6 00             	movzbl (%eax),%eax
 429:	3c 37                	cmp    $0x37,%al
 42b:	7e cb                	jle    3f8 <atoo+0x50>
    n = n*8 + *s++ - '0';
  return sign*n;
 42d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 430:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 434:	c9                   	leave  
 435:	c3                   	ret    

00000436 <memmove>:


void*
memmove(void *vdst, void *vsrc, int n)
{
 436:	55                   	push   %ebp
 437:	89 e5                	mov    %esp,%ebp
 439:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 43c:	8b 45 08             	mov    0x8(%ebp),%eax
 43f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 442:	8b 45 0c             	mov    0xc(%ebp),%eax
 445:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 448:	eb 17                	jmp    461 <memmove+0x2b>
    *dst++ = *src++;
 44a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 44d:	8d 50 01             	lea    0x1(%eax),%edx
 450:	89 55 fc             	mov    %edx,-0x4(%ebp)
 453:	8b 55 f8             	mov    -0x8(%ebp),%edx
 456:	8d 4a 01             	lea    0x1(%edx),%ecx
 459:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 45c:	0f b6 12             	movzbl (%edx),%edx
 45f:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 461:	8b 45 10             	mov    0x10(%ebp),%eax
 464:	8d 50 ff             	lea    -0x1(%eax),%edx
 467:	89 55 10             	mov    %edx,0x10(%ebp)
 46a:	85 c0                	test   %eax,%eax
 46c:	7f dc                	jg     44a <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 46e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 471:	c9                   	leave  
 472:	c3                   	ret    

00000473 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 473:	b8 01 00 00 00       	mov    $0x1,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    

0000047b <exit>:
SYSCALL(exit)
 47b:	b8 02 00 00 00       	mov    $0x2,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret    

00000483 <wait>:
SYSCALL(wait)
 483:	b8 03 00 00 00       	mov    $0x3,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret    

0000048b <pipe>:
SYSCALL(pipe)
 48b:	b8 04 00 00 00       	mov    $0x4,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret    

00000493 <read>:
SYSCALL(read)
 493:	b8 05 00 00 00       	mov    $0x5,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret    

0000049b <write>:
SYSCALL(write)
 49b:	b8 10 00 00 00       	mov    $0x10,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret    

000004a3 <close>:
SYSCALL(close)
 4a3:	b8 15 00 00 00       	mov    $0x15,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret    

000004ab <kill>:
SYSCALL(kill)
 4ab:	b8 06 00 00 00       	mov    $0x6,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret    

000004b3 <exec>:
SYSCALL(exec)
 4b3:	b8 07 00 00 00       	mov    $0x7,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret    

000004bb <open>:
SYSCALL(open)
 4bb:	b8 0f 00 00 00       	mov    $0xf,%eax
 4c0:	cd 40                	int    $0x40
 4c2:	c3                   	ret    

000004c3 <mknod>:
SYSCALL(mknod)
 4c3:	b8 11 00 00 00       	mov    $0x11,%eax
 4c8:	cd 40                	int    $0x40
 4ca:	c3                   	ret    

000004cb <unlink>:
SYSCALL(unlink)
 4cb:	b8 12 00 00 00       	mov    $0x12,%eax
 4d0:	cd 40                	int    $0x40
 4d2:	c3                   	ret    

000004d3 <fstat>:
SYSCALL(fstat)
 4d3:	b8 08 00 00 00       	mov    $0x8,%eax
 4d8:	cd 40                	int    $0x40
 4da:	c3                   	ret    

000004db <link>:
SYSCALL(link)
 4db:	b8 13 00 00 00       	mov    $0x13,%eax
 4e0:	cd 40                	int    $0x40
 4e2:	c3                   	ret    

000004e3 <mkdir>:
SYSCALL(mkdir)
 4e3:	b8 14 00 00 00       	mov    $0x14,%eax
 4e8:	cd 40                	int    $0x40
 4ea:	c3                   	ret    

000004eb <chdir>:
SYSCALL(chdir)
 4eb:	b8 09 00 00 00       	mov    $0x9,%eax
 4f0:	cd 40                	int    $0x40
 4f2:	c3                   	ret    

000004f3 <dup>:
SYSCALL(dup)
 4f3:	b8 0a 00 00 00       	mov    $0xa,%eax
 4f8:	cd 40                	int    $0x40
 4fa:	c3                   	ret    

000004fb <getpid>:
SYSCALL(getpid)
 4fb:	b8 0b 00 00 00       	mov    $0xb,%eax
 500:	cd 40                	int    $0x40
 502:	c3                   	ret    

00000503 <sbrk>:
SYSCALL(sbrk)
 503:	b8 0c 00 00 00       	mov    $0xc,%eax
 508:	cd 40                	int    $0x40
 50a:	c3                   	ret    

0000050b <sleep>:
SYSCALL(sleep)
 50b:	b8 0d 00 00 00       	mov    $0xd,%eax
 510:	cd 40                	int    $0x40
 512:	c3                   	ret    

00000513 <uptime>:
SYSCALL(uptime)
 513:	b8 0e 00 00 00       	mov    $0xe,%eax
 518:	cd 40                	int    $0x40
 51a:	c3                   	ret    

0000051b <halt>:
SYSCALL(halt)
 51b:	b8 16 00 00 00       	mov    $0x16,%eax
 520:	cd 40                	int    $0x40
 522:	c3                   	ret    

00000523 <date>:
SYSCALL(date)
 523:	b8 17 00 00 00       	mov    $0x17,%eax
 528:	cd 40                	int    $0x40
 52a:	c3                   	ret    

0000052b <getuid>:
SYSCALL(getuid)
 52b:	b8 18 00 00 00       	mov    $0x18,%eax
 530:	cd 40                	int    $0x40
 532:	c3                   	ret    

00000533 <getgid>:
SYSCALL(getgid)
 533:	b8 19 00 00 00       	mov    $0x19,%eax
 538:	cd 40                	int    $0x40
 53a:	c3                   	ret    

0000053b <getppid>:
SYSCALL(getppid)
 53b:	b8 1a 00 00 00       	mov    $0x1a,%eax
 540:	cd 40                	int    $0x40
 542:	c3                   	ret    

00000543 <setuid>:
SYSCALL(setuid)
 543:	b8 1b 00 00 00       	mov    $0x1b,%eax
 548:	cd 40                	int    $0x40
 54a:	c3                   	ret    

0000054b <setgid>:
SYSCALL(setgid)
 54b:	b8 1c 00 00 00       	mov    $0x1c,%eax
 550:	cd 40                	int    $0x40
 552:	c3                   	ret    

00000553 <getprocs>:
SYSCALL(getprocs)
 553:	b8 1d 00 00 00       	mov    $0x1d,%eax
 558:	cd 40                	int    $0x40
 55a:	c3                   	ret    

0000055b <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 55b:	55                   	push   %ebp
 55c:	89 e5                	mov    %esp,%ebp
 55e:	83 ec 18             	sub    $0x18,%esp
 561:	8b 45 0c             	mov    0xc(%ebp),%eax
 564:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 567:	83 ec 04             	sub    $0x4,%esp
 56a:	6a 01                	push   $0x1
 56c:	8d 45 f4             	lea    -0xc(%ebp),%eax
 56f:	50                   	push   %eax
 570:	ff 75 08             	pushl  0x8(%ebp)
 573:	e8 23 ff ff ff       	call   49b <write>
 578:	83 c4 10             	add    $0x10,%esp
}
 57b:	90                   	nop
 57c:	c9                   	leave  
 57d:	c3                   	ret    

0000057e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 57e:	55                   	push   %ebp
 57f:	89 e5                	mov    %esp,%ebp
 581:	53                   	push   %ebx
 582:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 585:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 58c:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 590:	74 17                	je     5a9 <printint+0x2b>
 592:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 596:	79 11                	jns    5a9 <printint+0x2b>
    neg = 1;
 598:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 59f:	8b 45 0c             	mov    0xc(%ebp),%eax
 5a2:	f7 d8                	neg    %eax
 5a4:	89 45 ec             	mov    %eax,-0x14(%ebp)
 5a7:	eb 06                	jmp    5af <printint+0x31>
  } else {
    x = xx;
 5a9:	8b 45 0c             	mov    0xc(%ebp),%eax
 5ac:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 5af:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 5b6:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 5b9:	8d 41 01             	lea    0x1(%ecx),%eax
 5bc:	89 45 f4             	mov    %eax,-0xc(%ebp)
 5bf:	8b 5d 10             	mov    0x10(%ebp),%ebx
 5c2:	8b 45 ec             	mov    -0x14(%ebp),%eax
 5c5:	ba 00 00 00 00       	mov    $0x0,%edx
 5ca:	f7 f3                	div    %ebx
 5cc:	89 d0                	mov    %edx,%eax
 5ce:	0f b6 80 c4 0c 00 00 	movzbl 0xcc4(%eax),%eax
 5d5:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 5d9:	8b 5d 10             	mov    0x10(%ebp),%ebx
 5dc:	8b 45 ec             	mov    -0x14(%ebp),%eax
 5df:	ba 00 00 00 00       	mov    $0x0,%edx
 5e4:	f7 f3                	div    %ebx
 5e6:	89 45 ec             	mov    %eax,-0x14(%ebp)
 5e9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5ed:	75 c7                	jne    5b6 <printint+0x38>
  if(neg)
 5ef:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 5f3:	74 2d                	je     622 <printint+0xa4>
    buf[i++] = '-';
 5f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5f8:	8d 50 01             	lea    0x1(%eax),%edx
 5fb:	89 55 f4             	mov    %edx,-0xc(%ebp)
 5fe:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 603:	eb 1d                	jmp    622 <printint+0xa4>
    putc(fd, buf[i]);
 605:	8d 55 dc             	lea    -0x24(%ebp),%edx
 608:	8b 45 f4             	mov    -0xc(%ebp),%eax
 60b:	01 d0                	add    %edx,%eax
 60d:	0f b6 00             	movzbl (%eax),%eax
 610:	0f be c0             	movsbl %al,%eax
 613:	83 ec 08             	sub    $0x8,%esp
 616:	50                   	push   %eax
 617:	ff 75 08             	pushl  0x8(%ebp)
 61a:	e8 3c ff ff ff       	call   55b <putc>
 61f:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 622:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 626:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 62a:	79 d9                	jns    605 <printint+0x87>
    putc(fd, buf[i]);
}
 62c:	90                   	nop
 62d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 630:	c9                   	leave  
 631:	c3                   	ret    

00000632 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 632:	55                   	push   %ebp
 633:	89 e5                	mov    %esp,%ebp
 635:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 638:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 63f:	8d 45 0c             	lea    0xc(%ebp),%eax
 642:	83 c0 04             	add    $0x4,%eax
 645:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 648:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 64f:	e9 59 01 00 00       	jmp    7ad <printf+0x17b>
    c = fmt[i] & 0xff;
 654:	8b 55 0c             	mov    0xc(%ebp),%edx
 657:	8b 45 f0             	mov    -0x10(%ebp),%eax
 65a:	01 d0                	add    %edx,%eax
 65c:	0f b6 00             	movzbl (%eax),%eax
 65f:	0f be c0             	movsbl %al,%eax
 662:	25 ff 00 00 00       	and    $0xff,%eax
 667:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 66a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 66e:	75 2c                	jne    69c <printf+0x6a>
      if(c == '%'){
 670:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 674:	75 0c                	jne    682 <printf+0x50>
        state = '%';
 676:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 67d:	e9 27 01 00 00       	jmp    7a9 <printf+0x177>
      } else {
        putc(fd, c);
 682:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 685:	0f be c0             	movsbl %al,%eax
 688:	83 ec 08             	sub    $0x8,%esp
 68b:	50                   	push   %eax
 68c:	ff 75 08             	pushl  0x8(%ebp)
 68f:	e8 c7 fe ff ff       	call   55b <putc>
 694:	83 c4 10             	add    $0x10,%esp
 697:	e9 0d 01 00 00       	jmp    7a9 <printf+0x177>
      }
    } else if(state == '%'){
 69c:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 6a0:	0f 85 03 01 00 00    	jne    7a9 <printf+0x177>
      if(c == 'd'){
 6a6:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 6aa:	75 1e                	jne    6ca <printf+0x98>
        printint(fd, *ap, 10, 1);
 6ac:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6af:	8b 00                	mov    (%eax),%eax
 6b1:	6a 01                	push   $0x1
 6b3:	6a 0a                	push   $0xa
 6b5:	50                   	push   %eax
 6b6:	ff 75 08             	pushl  0x8(%ebp)
 6b9:	e8 c0 fe ff ff       	call   57e <printint>
 6be:	83 c4 10             	add    $0x10,%esp
        ap++;
 6c1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6c5:	e9 d8 00 00 00       	jmp    7a2 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 6ca:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 6ce:	74 06                	je     6d6 <printf+0xa4>
 6d0:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 6d4:	75 1e                	jne    6f4 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 6d6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6d9:	8b 00                	mov    (%eax),%eax
 6db:	6a 00                	push   $0x0
 6dd:	6a 10                	push   $0x10
 6df:	50                   	push   %eax
 6e0:	ff 75 08             	pushl  0x8(%ebp)
 6e3:	e8 96 fe ff ff       	call   57e <printint>
 6e8:	83 c4 10             	add    $0x10,%esp
        ap++;
 6eb:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6ef:	e9 ae 00 00 00       	jmp    7a2 <printf+0x170>
      } else if(c == 's'){
 6f4:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 6f8:	75 43                	jne    73d <printf+0x10b>
        s = (char*)*ap;
 6fa:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6fd:	8b 00                	mov    (%eax),%eax
 6ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 702:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 706:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 70a:	75 25                	jne    731 <printf+0xff>
          s = "(null)";
 70c:	c7 45 f4 4e 0a 00 00 	movl   $0xa4e,-0xc(%ebp)
        while(*s != 0){
 713:	eb 1c                	jmp    731 <printf+0xff>
          putc(fd, *s);
 715:	8b 45 f4             	mov    -0xc(%ebp),%eax
 718:	0f b6 00             	movzbl (%eax),%eax
 71b:	0f be c0             	movsbl %al,%eax
 71e:	83 ec 08             	sub    $0x8,%esp
 721:	50                   	push   %eax
 722:	ff 75 08             	pushl  0x8(%ebp)
 725:	e8 31 fe ff ff       	call   55b <putc>
 72a:	83 c4 10             	add    $0x10,%esp
          s++;
 72d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 731:	8b 45 f4             	mov    -0xc(%ebp),%eax
 734:	0f b6 00             	movzbl (%eax),%eax
 737:	84 c0                	test   %al,%al
 739:	75 da                	jne    715 <printf+0xe3>
 73b:	eb 65                	jmp    7a2 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 73d:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 741:	75 1d                	jne    760 <printf+0x12e>
        putc(fd, *ap);
 743:	8b 45 e8             	mov    -0x18(%ebp),%eax
 746:	8b 00                	mov    (%eax),%eax
 748:	0f be c0             	movsbl %al,%eax
 74b:	83 ec 08             	sub    $0x8,%esp
 74e:	50                   	push   %eax
 74f:	ff 75 08             	pushl  0x8(%ebp)
 752:	e8 04 fe ff ff       	call   55b <putc>
 757:	83 c4 10             	add    $0x10,%esp
        ap++;
 75a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 75e:	eb 42                	jmp    7a2 <printf+0x170>
      } else if(c == '%'){
 760:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 764:	75 17                	jne    77d <printf+0x14b>
        putc(fd, c);
 766:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 769:	0f be c0             	movsbl %al,%eax
 76c:	83 ec 08             	sub    $0x8,%esp
 76f:	50                   	push   %eax
 770:	ff 75 08             	pushl  0x8(%ebp)
 773:	e8 e3 fd ff ff       	call   55b <putc>
 778:	83 c4 10             	add    $0x10,%esp
 77b:	eb 25                	jmp    7a2 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 77d:	83 ec 08             	sub    $0x8,%esp
 780:	6a 25                	push   $0x25
 782:	ff 75 08             	pushl  0x8(%ebp)
 785:	e8 d1 fd ff ff       	call   55b <putc>
 78a:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 78d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 790:	0f be c0             	movsbl %al,%eax
 793:	83 ec 08             	sub    $0x8,%esp
 796:	50                   	push   %eax
 797:	ff 75 08             	pushl  0x8(%ebp)
 79a:	e8 bc fd ff ff       	call   55b <putc>
 79f:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 7a2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7a9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 7ad:	8b 55 0c             	mov    0xc(%ebp),%edx
 7b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b3:	01 d0                	add    %edx,%eax
 7b5:	0f b6 00             	movzbl (%eax),%eax
 7b8:	84 c0                	test   %al,%al
 7ba:	0f 85 94 fe ff ff    	jne    654 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 7c0:	90                   	nop
 7c1:	c9                   	leave  
 7c2:	c3                   	ret    

000007c3 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7c3:	55                   	push   %ebp
 7c4:	89 e5                	mov    %esp,%ebp
 7c6:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7c9:	8b 45 08             	mov    0x8(%ebp),%eax
 7cc:	83 e8 08             	sub    $0x8,%eax
 7cf:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7d2:	a1 e0 0c 00 00       	mov    0xce0,%eax
 7d7:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7da:	eb 24                	jmp    800 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7df:	8b 00                	mov    (%eax),%eax
 7e1:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7e4:	77 12                	ja     7f8 <free+0x35>
 7e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7e9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7ec:	77 24                	ja     812 <free+0x4f>
 7ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7f1:	8b 00                	mov    (%eax),%eax
 7f3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7f6:	77 1a                	ja     812 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7fb:	8b 00                	mov    (%eax),%eax
 7fd:	89 45 fc             	mov    %eax,-0x4(%ebp)
 800:	8b 45 f8             	mov    -0x8(%ebp),%eax
 803:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 806:	76 d4                	jbe    7dc <free+0x19>
 808:	8b 45 fc             	mov    -0x4(%ebp),%eax
 80b:	8b 00                	mov    (%eax),%eax
 80d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 810:	76 ca                	jbe    7dc <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 812:	8b 45 f8             	mov    -0x8(%ebp),%eax
 815:	8b 40 04             	mov    0x4(%eax),%eax
 818:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 81f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 822:	01 c2                	add    %eax,%edx
 824:	8b 45 fc             	mov    -0x4(%ebp),%eax
 827:	8b 00                	mov    (%eax),%eax
 829:	39 c2                	cmp    %eax,%edx
 82b:	75 24                	jne    851 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 82d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 830:	8b 50 04             	mov    0x4(%eax),%edx
 833:	8b 45 fc             	mov    -0x4(%ebp),%eax
 836:	8b 00                	mov    (%eax),%eax
 838:	8b 40 04             	mov    0x4(%eax),%eax
 83b:	01 c2                	add    %eax,%edx
 83d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 840:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 843:	8b 45 fc             	mov    -0x4(%ebp),%eax
 846:	8b 00                	mov    (%eax),%eax
 848:	8b 10                	mov    (%eax),%edx
 84a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 84d:	89 10                	mov    %edx,(%eax)
 84f:	eb 0a                	jmp    85b <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 851:	8b 45 fc             	mov    -0x4(%ebp),%eax
 854:	8b 10                	mov    (%eax),%edx
 856:	8b 45 f8             	mov    -0x8(%ebp),%eax
 859:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 85b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 85e:	8b 40 04             	mov    0x4(%eax),%eax
 861:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 868:	8b 45 fc             	mov    -0x4(%ebp),%eax
 86b:	01 d0                	add    %edx,%eax
 86d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 870:	75 20                	jne    892 <free+0xcf>
    p->s.size += bp->s.size;
 872:	8b 45 fc             	mov    -0x4(%ebp),%eax
 875:	8b 50 04             	mov    0x4(%eax),%edx
 878:	8b 45 f8             	mov    -0x8(%ebp),%eax
 87b:	8b 40 04             	mov    0x4(%eax),%eax
 87e:	01 c2                	add    %eax,%edx
 880:	8b 45 fc             	mov    -0x4(%ebp),%eax
 883:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 886:	8b 45 f8             	mov    -0x8(%ebp),%eax
 889:	8b 10                	mov    (%eax),%edx
 88b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 88e:	89 10                	mov    %edx,(%eax)
 890:	eb 08                	jmp    89a <free+0xd7>
  } else
    p->s.ptr = bp;
 892:	8b 45 fc             	mov    -0x4(%ebp),%eax
 895:	8b 55 f8             	mov    -0x8(%ebp),%edx
 898:	89 10                	mov    %edx,(%eax)
  freep = p;
 89a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 89d:	a3 e0 0c 00 00       	mov    %eax,0xce0
}
 8a2:	90                   	nop
 8a3:	c9                   	leave  
 8a4:	c3                   	ret    

000008a5 <morecore>:

static Header*
morecore(uint nu)
{
 8a5:	55                   	push   %ebp
 8a6:	89 e5                	mov    %esp,%ebp
 8a8:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 8ab:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 8b2:	77 07                	ja     8bb <morecore+0x16>
    nu = 4096;
 8b4:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 8bb:	8b 45 08             	mov    0x8(%ebp),%eax
 8be:	c1 e0 03             	shl    $0x3,%eax
 8c1:	83 ec 0c             	sub    $0xc,%esp
 8c4:	50                   	push   %eax
 8c5:	e8 39 fc ff ff       	call   503 <sbrk>
 8ca:	83 c4 10             	add    $0x10,%esp
 8cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 8d0:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 8d4:	75 07                	jne    8dd <morecore+0x38>
    return 0;
 8d6:	b8 00 00 00 00       	mov    $0x0,%eax
 8db:	eb 26                	jmp    903 <morecore+0x5e>
  hp = (Header*)p;
 8dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 8e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8e6:	8b 55 08             	mov    0x8(%ebp),%edx
 8e9:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 8ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8ef:	83 c0 08             	add    $0x8,%eax
 8f2:	83 ec 0c             	sub    $0xc,%esp
 8f5:	50                   	push   %eax
 8f6:	e8 c8 fe ff ff       	call   7c3 <free>
 8fb:	83 c4 10             	add    $0x10,%esp
  return freep;
 8fe:	a1 e0 0c 00 00       	mov    0xce0,%eax
}
 903:	c9                   	leave  
 904:	c3                   	ret    

00000905 <malloc>:

void*
malloc(uint nbytes)
{
 905:	55                   	push   %ebp
 906:	89 e5                	mov    %esp,%ebp
 908:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 90b:	8b 45 08             	mov    0x8(%ebp),%eax
 90e:	83 c0 07             	add    $0x7,%eax
 911:	c1 e8 03             	shr    $0x3,%eax
 914:	83 c0 01             	add    $0x1,%eax
 917:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 91a:	a1 e0 0c 00 00       	mov    0xce0,%eax
 91f:	89 45 f0             	mov    %eax,-0x10(%ebp)
 922:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 926:	75 23                	jne    94b <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 928:	c7 45 f0 d8 0c 00 00 	movl   $0xcd8,-0x10(%ebp)
 92f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 932:	a3 e0 0c 00 00       	mov    %eax,0xce0
 937:	a1 e0 0c 00 00       	mov    0xce0,%eax
 93c:	a3 d8 0c 00 00       	mov    %eax,0xcd8
    base.s.size = 0;
 941:	c7 05 dc 0c 00 00 00 	movl   $0x0,0xcdc
 948:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 94b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 94e:	8b 00                	mov    (%eax),%eax
 950:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 953:	8b 45 f4             	mov    -0xc(%ebp),%eax
 956:	8b 40 04             	mov    0x4(%eax),%eax
 959:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 95c:	72 4d                	jb     9ab <malloc+0xa6>
      if(p->s.size == nunits)
 95e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 961:	8b 40 04             	mov    0x4(%eax),%eax
 964:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 967:	75 0c                	jne    975 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 969:	8b 45 f4             	mov    -0xc(%ebp),%eax
 96c:	8b 10                	mov    (%eax),%edx
 96e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 971:	89 10                	mov    %edx,(%eax)
 973:	eb 26                	jmp    99b <malloc+0x96>
      else {
        p->s.size -= nunits;
 975:	8b 45 f4             	mov    -0xc(%ebp),%eax
 978:	8b 40 04             	mov    0x4(%eax),%eax
 97b:	2b 45 ec             	sub    -0x14(%ebp),%eax
 97e:	89 c2                	mov    %eax,%edx
 980:	8b 45 f4             	mov    -0xc(%ebp),%eax
 983:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 986:	8b 45 f4             	mov    -0xc(%ebp),%eax
 989:	8b 40 04             	mov    0x4(%eax),%eax
 98c:	c1 e0 03             	shl    $0x3,%eax
 98f:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 992:	8b 45 f4             	mov    -0xc(%ebp),%eax
 995:	8b 55 ec             	mov    -0x14(%ebp),%edx
 998:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 99b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 99e:	a3 e0 0c 00 00       	mov    %eax,0xce0
      return (void*)(p + 1);
 9a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9a6:	83 c0 08             	add    $0x8,%eax
 9a9:	eb 3b                	jmp    9e6 <malloc+0xe1>
    }
    if(p == freep)
 9ab:	a1 e0 0c 00 00       	mov    0xce0,%eax
 9b0:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 9b3:	75 1e                	jne    9d3 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 9b5:	83 ec 0c             	sub    $0xc,%esp
 9b8:	ff 75 ec             	pushl  -0x14(%ebp)
 9bb:	e8 e5 fe ff ff       	call   8a5 <morecore>
 9c0:	83 c4 10             	add    $0x10,%esp
 9c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
 9c6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 9ca:	75 07                	jne    9d3 <malloc+0xce>
        return 0;
 9cc:	b8 00 00 00 00       	mov    $0x0,%eax
 9d1:	eb 13                	jmp    9e6 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9dc:	8b 00                	mov    (%eax),%eax
 9de:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 9e1:	e9 6d ff ff ff       	jmp    953 <malloc+0x4e>
}
 9e6:	c9                   	leave  
 9e7:	c3                   	ret    
