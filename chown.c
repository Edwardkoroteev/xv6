#ifdef CS333_P5
#include "types.h"
#include "user.h"
int
main(int argc, char * argv[])
{
  int owner;

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

  owner = atoi(argv[1]);
  if(owner < 0 || owner > 32767)
  {
    printf(1, "Invalid UID\n");
    exit();
  }

  chown(argv[2], owner);
  exit();
}

#endif
