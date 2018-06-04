#ifdef CS333_P5
#include "types.h"
#include "user.h"
int
main(int argc, char * argv[])
{
  int mode;

  if(argc > 3)
  {
    printf(1, "Too Many Arguements\n");
    exit();
  }
  else if(argc < 3)
  {
    printf(1, "Not Enough Arguments\n");
    exit();
  }
  
  mode = atoi(argv[1]);
  if(mode < 0 || mode > 777)
  {
    if((mode > 777 && mode < 1000) || (mode > 1777))
    {
      printf(1, "Wrong mode\n");
      exit();
    }
  }

  mode = atoo(argv[1]);
  chmod(argv[2], mode);
  exit();
}

#endif
