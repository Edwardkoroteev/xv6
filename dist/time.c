#ifdef CS333_P2
#include "types.h"
#include "user.h"
int
main(int argc, char * argv[])
{
  if(argc < 2)
  {
    printf(1, "Time took 0.00 seconds\n");
    exit();
  }
  
  int timeInit = uptime();

  int retPid = fork();

  if(retPid < 0)
    exit();

  if(retPid == 0)
  {
    exec(argv[1], argv+1);
    exit();
  }

  if(retPid > 0)
  {
    wait();
    int time = uptime();
    time = time - timeInit;
    int decim = time % 1000;
    time /= 1000;
    if(decim < 10)
      printf(1, "%s ran in %d.00%d seconds\n",argv[1], time, decim);
    else if(decim < 100 && decim >= 10)
      printf(1, "%s ran in %d.0%d seconds\n", argv[1], time, decim);
    else
      printf(1, "%s ran in %d.%d seconds\n", argv[1], time, decim);
    exit();
  }


  exit();
}

#endif
