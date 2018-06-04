#ifdef CS333_P5
#include "types.h"
#include "user.h"
int
main(int argc, char * argv[])
{
  int group;

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

  group = atoi(argv[1]);
  if(group < 0 || group > 32767)
  {
    printf(1, "Invalid GID\n");
    exit();
  }
  chgrp(argv[2], group);
  exit();
}

#endif
