#ifdef CS333_P2
struct uproc {
  uint pid;
  uint uid;
  uint gid;
  uint ppid;
  uint elapsed_time;
  uint cpu_ticks_total;
  char *state;
  uint size; 
  char *name;
};
#endif
