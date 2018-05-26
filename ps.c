#ifdef CS333_P2
#include "types.h"
#include "user.h"
#include "uproc.h"
int
main(int argc, char * argv[])
{
  int max = 72;

  if(argc > 1)
    max = atoi(argv[1]);

  struct uproc * table = malloc(sizeof(*table)*max);

  if(table == 0)
  {
    printf(1, "Unable to initialize table in ps.c\n");
    exit();
  }

  int process = getprocs(max, table);
  int time;
  int decim;
  int cpuTime;
  int cpuDecim;
  if(process < 1)
  {
    free(table);
    printf(1, "Error\n");
  }

  
#ifdef CS333_P3P4
  printf(1, "PID\tName\tUID\tGID\tPPID\tPrio\tElapsed\tCPU\tState\tSize\n");
#else
  printf(1, "PID\tName\tUID\tGID\tPPID\tElapsed\tCPU\tState\tSize\n");
#endif



  for(int i = 0; i < process; i++)
  {
    printf(1, "%d\t%s\t%d\t%d\t%d\t", 
      table[i].pid, 
      table[i].name, 
      table[i].uid, 
      table[i].gid, 
      table[i].ppid);
#ifdef CS333_P3P4
    printf(1, "%d\t", table[i].prio);
#endif

    time = table[i].elapsed_ticks;
    decim = time % 1000;
    time /= 1000;
    if(decim < 10)
      printf(1, "%d.00%d\t", time, decim);
    else if(decim < 100 && decim >= 10)
      printf(1, "%d.0%d\t", time, decim);
    else
      printf(1, "%d.%d\t", time, decim);

    cpuTime = table[i].CPU_total_ticks;
    cpuDecim = cpuTime % 1000;
    cpuTime /= 1000;
    if(cpuDecim < 10)
      printf(1, "%d.00%d\t", cpuTime, cpuDecim);
    else if(cpuDecim < 100 && cpuDecim >= 10)
      printf(1, "%d.0%d\t", cpuTime, cpuDecim);
    else
      printf(1, "%d.%d\t", cpuTime, cpuDecim);

    printf(1, "%s\t", table[i].state);
    printf(1, "%d\n", table[i].size);
  } 
  free(table);
  exit();
}
#endif
