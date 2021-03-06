#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"
#ifdef CS333_P2
#include "uproc.h"
#endif

#ifdef CS333_P3P4
struct StateLists{
  struct proc* ready[MAXPRIO+1];
  struct proc* readyTail[MAXPRIO+1];
  struct proc* free;
  struct proc* freeTail;
  struct proc* sleep;
  struct proc* sleepTail;
  struct proc* zombie;
  struct proc* zombieTail;
  struct proc* running;
  struct proc* runningTail;
  struct proc* embryo;
  struct proc* embryoTail;
};
#endif

struct {
  struct spinlock lock;
  struct proc proc[NPROC];
#ifdef CS333_P3P4
  struct StateLists pLists;
  //Project 4 below
  uint PromoteAtTime;
#endif
} ptable;

static struct proc *initproc;

int nextpid = 1;
extern void forkret(void);
extern void trapret(void);

static void wakeup1(void *chan);


#ifdef CS333_P3P4
static void initProcessLists(void);
static void initFreeList(void);
static int stateListAdd(struct proc** head, struct proc** tail, struct proc* p);
static int stateListRemove(struct proc** head, struct proc** tail, struct proc* p);
static void assertState(struct proc *p, enum procstate state);
#endif

void
pinit(void)
{
  initlock(&ptable.lock, "ptable");
}

// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
  struct proc *p;
  char *sp;

#ifdef CS333_P3P4
  acquire(&ptable.lock);
  p = ptable.pLists.free;
  if(p == 0)
  {
    release(&ptable.lock);
    return 0;
  }

  goto found;

  release(&ptable.lock);
    return 0;
#else
  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;
  release(&ptable.lock);
  return 0;
#endif

found:
#ifdef CS333_P3P4
  assertState(p, UNUSED);
  if(stateListRemove(&ptable.pLists.free, &ptable.pLists.freeTail, p) != 0)
    panic("Error removing from free: allocproc\n");

  p->state = EMBRYO;
  stateListAdd(&ptable.pLists.embryo, &ptable.pLists.embryoTail, p);

  p->pid = nextpid++;
  release(&ptable.lock);

#else
  p->state = EMBRYO;
  p->pid = nextpid++;
  release(&ptable.lock);
#endif

  // Allocate kernel stack.
#ifdef CS333_P3P4
  if((p->kstack = kalloc()) == 0)
  {
    acquire(&ptable.lock);

    assertState(p, EMBRYO);
    if(stateListRemove(&ptable.pLists.embryo, &ptable.pLists.embryoTail, p) != 0)
      panic("Error removing from embryo: allocproc\n");

    p->state = UNUSED;
    if(stateListAdd(&ptable.pLists.free, &ptable.pLists.freeTail, p) != 0)
      panic("Error adding to free: allocproc\n");

    assertState(p, UNUSED);

    release(&ptable.lock);
    return 0;
  }
#else
  if((p->kstack = kalloc()) == 0)
  {
    p->state = UNUSED;
    return 0;
  }
#endif
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

#ifdef CS333_P1
  p->start_ticks = ticks;
#endif

#ifdef CS333_P2
  p->cpu_ticks_total = 0;
  p->cpu_ticks_in = 0;
#endif
  return p;
}

// Set up first user process.
void
userinit(void)
{
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
#ifdef CS333_P3P4
  acquire(&ptable.lock);
  initProcessLists();
  initFreeList();
  release(&ptable.lock);
#endif

  p = allocproc();
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");

#ifdef CS333_P2
  p->uid = UID;
  p->gid = GID;
  p->parent = 0;
#endif

#ifdef CS333_P3P4
  acquire(&ptable.lock);

  assertState(p, EMBRYO);
  if(stateListRemove(&ptable.pLists.embryo, &ptable.pLists.embryoTail, p) != 0)
    panic("Error removing from embryo: userinit\n");

  p->state = RUNNABLE;
  p->priority = 0;
  p->budget = BUDGET;
  if(stateListAdd(&ptable.pLists.ready[p->priority], &ptable.pLists.readyTail[p->priority], p) != 0)
    panic("Error adding to ready: userinit\n");

  assertState(p, RUNNABLE);
  ptable.PromoteAtTime = ticks + TICKS_TO_PROMOTE;
  release(&ptable.lock);
#else
  p->state = RUNNABLE;
#endif
}

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  uint sz;

  sz = proc->sz;
  if(n > 0){
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  proc->sz = sz;
  switchuvm(proc);
  return 0;
}

// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
    return -1;

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
    kfree(np->kstack);
    np->kstack = 0;
#ifdef CS333_P3P4
    acquire(&ptable.lock);
    assertState(np, EMBRYO);
    if(stateListRemove(&ptable.pLists.embryo, &ptable.pLists.embryoTail, np) != 0)
      panic("Error removing embryo: fork\n");

    np->budget = BUDGET;
    np->state = UNUSED;
    stateListAdd(&ptable.pLists.free, &ptable.pLists.freeTail, np);
    release(&ptable.lock);
#else
    np->state = UNUSED;
#endif
    return -1;
  }
#ifdef CS333_P2
  np->uid = proc->uid;
  np->gid = proc->gid;
#endif
  np->sz = proc->sz;
  np->parent = proc;
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);

  safestrcpy(np->name, proc->name, sizeof(proc->name));

  pid = np->pid;

  // lock to force the compiler to emit the np->state write last.
#ifdef CS333_P3P4
  acquire(&ptable.lock);
  assertState(np, EMBRYO);
  if(stateListRemove(&ptable.pLists.embryo, &ptable.pLists.embryoTail, np) != 0)
    panic("Error removing embryo: fork\n");

  np->budget = BUDGET;
  np->priority = 0;
  np->state = RUNNABLE;
  if(stateListAdd(&ptable.pLists.ready[0], &ptable.pLists.readyTail[0], np) != 0)
    panic("Error adding ready: fork\n");
  
  assertState(np, RUNNABLE);
  release(&ptable.lock);
#else
  acquire(&ptable.lock);
  np->state = RUNNABLE;
  release(&ptable.lock);
#endif

  return pid;
}

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
#ifdef CS333_P3P4
void
exit(void)
{
  struct proc *p;
  int fd;

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd]){
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  begin_op();
  iput(proc->cwd);
  end_op();
  proc->cwd = 0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  //ready
  for(int i = 0; i < MAXPRIO+1; i++)
  {
    p = ptable.pLists.ready[i];
    while(p != 0)
    {
      if(p->parent == proc)
        p->parent = initproc;
      p = p->next;
    }
  }

  //sleep
  p = ptable.pLists.sleep;
  while(p != 0)
  {
    if(p->parent == proc)
      p->parent = initproc;
    p = p->next;
  }

  //zombie
  p = ptable.pLists.zombie;
  while(p != 0)
  {
    if(p->parent == proc)
    {
      p->parent = initproc;
      wakeup1(initproc);
    }
    p = p->next;
  }

  //running
  p = ptable.pLists.running;
  while(p != 0)
  {
    if(p->parent == proc)
      p->parent = initproc;
    p = p->next;
  }

  //embryo
  p = ptable.pLists.embryo;
  while(p != 0)
  {
    if(p->parent == proc)
      p->parent = initproc;
    p = p->next;
  }



  // Jump into the scheduler, never to return.
  assertState(proc, RUNNING);
  if(stateListRemove(&ptable.pLists.running, &ptable.pLists.runningTail, proc) != 0)
    panic("Error removing running: exit\n");
  proc->state = ZOMBIE;

  stateListAdd(&ptable.pLists.zombie, &ptable.pLists.zombieTail, proc);

  //release(&ptable.lock);
  sched();
  panic("zombie exit");
}
#else
void
exit(void)
{
  struct proc *p;
  int fd;

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd]){
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  begin_op();
  iput(proc->cwd);
  end_op();
  proc->cwd = 0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
      if(p->state == ZOMBIE)
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
  sched();
  panic("zombie exit");
}
#endif

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
#ifdef CS333_P3P4
int
wait(void)
{
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;

    for(int i = 0; i < MAXPRIO+1; i++)
    {
      p = ptable.pLists.ready[i];
      while(p != 0)
      {
        if(p->parent == proc)
          havekids = 1;
        p = p->next;
      }
    }

    p = ptable.pLists.sleep;
    while(p != 0)
    { 
      if(p->parent == proc)
        havekids = 1;
      p = p->next;
    }

    p = ptable.pLists.running;
    while(p != 0)
    {
      if(p->parent == proc)
        havekids = 1;
      p = p->next;
    }

    p = ptable.pLists.embryo;
    while(p != 0)
    {
      if(p->parent == proc)
        havekids = 1;
      p = p->next;
    }

    p = ptable.pLists.zombie;
    while(p != 0)
    {
      if(p->parent == proc)
      {
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        assertState(p, ZOMBIE);
        if(stateListRemove(&ptable.pLists.zombie, &ptable.pLists.zombieTail, p) != 0)
          panic("Error remove zombie: wait\n");
        p->state = UNUSED;
        stateListAdd(&ptable.pLists.free, &ptable.pLists.freeTail, p);
        assertState(p, UNUSED);
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        release(&ptable.lock);
        return pid;
      }
      p = p->next;
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
#else
int
wait(void)
{
 struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != proc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->state = UNUSED;
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        release(&ptable.lock);
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }

  return 0;  // placeholder
}
#endif

// Per-CPU process scheduler.
// Each CPU calls scheduler() after setting itself up.
// Scheduler never returns.  It loops, doing:
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
#ifdef CS333_P3P4
// original xv6 scheduler. Use if CS333_P3P4 NOT defined.
void
scheduler(void)
{
  struct proc *p;
  int idle;  // for checking if processor is idle

  for(;;){

    // Enable interrupts on this processor.
    sti();
    
    idle = 1;  // assume idle unless we schedule a process
    // Loop over process table looking for process to run.

    acquire(&ptable.lock);
    if(ticks >= ptable.PromoteAtTime)
    {
      p = ptable.pLists.ready[0];
      while(p != 0)
      {
        p->budget = BUDGET;
        p = p->next;
      }

      for(int i = 1; i < MAXPRIO+1; i++)
      {
        p = ptable.pLists.ready[i];
        
        while(p != 0)
        {
          if(stateListRemove(&ptable.pLists.ready[i], &ptable.pLists.readyTail[i], p) != 0)
            panic("Error removing ready list: promoting\n");

          p->budget = BUDGET;
          p->priority--;
          stateListAdd(&ptable.pLists.ready[p->priority], &ptable.pLists.readyTail[p->priority], p);
          p = p->next;
        }
      }

      ptable.PromoteAtTime = ticks + TICKS_TO_PROMOTE;
    }

    for(int i = 0; i < MAXPRIO+1; i++)
    { 
      p = ptable.pLists.ready[i];

      if(p != 0)
      {
        // Switch to chosen process.  It is the process's job
        // to release ptable.lock and then reacquire it
        // before jumping back to us.
        idle = 0;  // not idle this timeslice
        proc = p;
        switchuvm(p);
#ifdef CS333_P2
        proc->cpu_ticks_in = ticks;
#endif
        assertState(p, RUNNABLE);
        if(stateListRemove(&ptable.pLists.ready[i], &ptable.pLists.readyTail[i], p) != 0)
          panic("Error removing ready: scheduler\n");

        p->state = RUNNING;
        if(stateListAdd(&ptable.pLists.running, &ptable.pLists.runningTail, p) != 0)
          panic("Error adding running: scheduler\n");

        assertState(p, RUNNING);

        swtch(&cpu->scheduler, proc->context);
        switchkvm();

        // Process is done running for now.
        // It should have changed its p->state before coming back.
        proc = 0;
//        break;
        continue;
      }
    }

    release(&ptable.lock);
    // if idle, wait for next interrupt
    if (idle) {
      sti();
      hlt();
    }
  }
}

#else
void
scheduler(void)
{
  struct proc *p;
  int idle;  // for checking if processor is idle

  for(;;){
    // Enable interrupts on this processor.
    sti();

    idle = 1;  // assume idle unless we schedule a process
    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->state != RUNNABLE)
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      idle = 0;  // not idle this timeslice
      proc = p;
      switchuvm(p);
#ifdef CS333_P2
      proc->cpu_ticks_in = ticks;
#endif
      p->state = RUNNING;
      swtch(&cpu->scheduler, proc->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
    }
    release(&ptable.lock);
    // if idle, wait for next interrupt
    if (idle) {
      sti();
      hlt();
    }
  }
}
#endif

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
void
sched(void)
{
  int intena;
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
    panic("sched locks");
  if(proc->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
#ifdef CS333_P2
  proc->cpu_ticks_total += (ticks - proc->cpu_ticks_in);
#endif
  intena = cpu->intena;

  swtch(&proc->context, cpu->scheduler);
  cpu->intena = intena;
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
#ifdef CS333_P3P4
  assertState(proc, RUNNING);
  if(stateListRemove(&ptable.pLists.running, &ptable.pLists.runningTail, proc) != 0)
    panic("Error removing ready: yield\n");

  proc->budget -= (ticks - proc->cpu_ticks_in);
  proc->state = RUNNABLE;
  if(proc->budget <= 0)
  {
    proc->budget = BUDGET;
    if(proc->priority != MAXPRIO)
      proc->priority += 1;
  }

  stateListAdd(&ptable.pLists.ready[proc->priority], &ptable.pLists.readyTail[proc->priority], proc);

#else
  proc->state = RUNNABLE;
#endif
  sched();
  release(&ptable.lock);
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
// 2016/12/28: ticklock removed from xv6. sleep() changed to
// accept a NULL lock to accommodate.
void
sleep(void *chan, struct spinlock *lk)
{
  // Must acquire ptable.lock in order to
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){
    acquire(&ptable.lock);
    if (lk) release(lk);
  }
  // Go to sleep.
#ifdef CS333_P3P4
  proc->chan = chan;
  assertState(proc, RUNNING);
  if(stateListRemove(&ptable.pLists.running, &ptable.pLists.runningTail, proc) != 0)
    panic("Error remove running: sleep\n");

  proc->state = SLEEPING;
  proc->budget = proc->budget - (ticks - proc->cpu_ticks_in);
  
  if(proc->budget <= 0)
  {
    proc->budget = BUDGET;
    if(proc->priority != MAXPRIO+1)
      proc->priority += 1;
  }
  
  stateListAdd(&ptable.pLists.sleep, &ptable.pLists.sleepTail, proc);

  assertState(proc, SLEEPING);
#else
  proc->chan = chan;
  proc->state = SLEEPING;
#endif

  sched();

  // Tidy up.
  proc->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){
    release(&ptable.lock);
    if (lk) acquire(lk);
  }
}

#ifdef CS333_P3P4
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
  struct proc *p;
  p = ptable.pLists.sleep;
    
  while(p != 0)
  {
    if(p->state == SLEEPING && p->chan == chan)
    {
      assertState(p, SLEEPING);
      if(stateListRemove(&ptable.pLists.sleep, &ptable.pLists.sleepTail, p) != 0)
        panic("Error removing sleep: wakeup1\n");

      p->state = RUNNABLE;
      stateListAdd(&ptable.pLists.ready[p->priority], &ptable.pLists.readyTail[p->priority], p);

      assertState(p, RUNNABLE);
    }
    p = p->next;
  }
}
#else
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}
#endif

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
}

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
#ifdef CS333_P3P4
int
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);

  p = ptable.pLists.sleep;
  while(p != 0)
  {
    if(p->pid == pid)
    {
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
      {
        assertState(p, SLEEPING);
        if(stateListRemove(&ptable.pLists.sleep, &ptable.pLists.sleepTail, p) != 0)
          panic("Error removing sleep: kill\n");

        p->state = RUNNABLE;
        p->priority = 0;
        stateListAdd(&ptable.pLists.ready[p->priority], &ptable.pLists.readyTail[p->priority], p);

      }
      release(&ptable.lock);
      return 0;
    }
    p = p->next;
  }

  //ready
  for(int i = 0; i < MAXPRIO+1; i++)
  {
    p = ptable.pLists.ready[i];
    while(p != 0)
    {
      if(p->pid == pid)
      {
        p->killed = 1;
        release(&ptable.lock);
        return 0;
      }
      p = p->next;
    }
  }

  //free
  p = ptable.pLists.free;
  while(p != 0)
  {
    if(p->pid == pid)
    {
      p->killed = 1;
      release(&ptable.lock);
      return 0;
    }
    p = p->next;
  }

  //zombie
  p = ptable.pLists.zombie;
  while(p != 0)
  {
    if(p->pid == pid)
    {
      p->killed = 1;
      release(&ptable.lock);
      return 0;
    }
    p = p->next;
  }

  //running
  p = ptable.pLists.running;
  while(p != 0)
  {
    if(p->pid == pid)
    {
      p->killed = 1;
      release(&ptable.lock);
      return 0;
    }
    p = p->next;
  }

  //embryo
  p = ptable.pLists.embryo;
  while(p != 0)
  {
    if(p->pid == pid)
    {
      p->killed = 1;
      release(&ptable.lock);
      return 0;
    }
    p = p->next;
  }
  
  release(&ptable.lock);
  return -1;
}
#else
int
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
#endif

static char *states[] = {
  [UNUSED]    "unused",
  [EMBRYO]    "embryo",
  [SLEEPING]  "sleep ",
  [RUNNABLE]  "runble",
  [RUNNING]   "run   ",
  [ZOMBIE]    "zombie"
};

// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.

#ifdef CS333_P3P4
static void
procdumpP3P4(struct proc *p, char *state)
{
  int time;
  int decim;
  cprintf("%d\t%s\t%d\t%d\t%d\t%d\t", 
    p->pid, 
    p->name, 
    p->uid, 
    p->gid, 
    p->parent ? p->parent->pid : p->pid,
    p->priority);

  time = (ticks - p->start_ticks);
  decim = time % 1000;
  time /= 1000;
  if(decim < 10)
    cprintf("%d.00%d\t", time, decim);
  else if(decim < 100 && decim >= 10)
    cprintf("%d.0%d\t", time, decim);
  else
    cprintf("%d.%d\t", time, decim);

    time = p->cpu_ticks_total;
    decim = time % 1000;
    time /= 1000;
  if(decim < 10)
    cprintf("%d.00%d\t", time, decim);
  else if(decim < 100 && decim >= 10)
    cprintf("%d.0%d\t", time, decim);
  else
    cprintf("%d.%d\t", time, decim);

    cprintf("%s\t", state);
    cprintf("%d\t", p->sz);

}
#elif defined(CS333_P2)
static void
procdumpP2(struct proc *p, char *state)
{
  int time;
  int decim;
  cprintf("%d\t%s\t%d\t%d\t%d\t", 
    p->pid, 
    p->name, 
    p->uid, 
    p->gid, 
    p->parent ? p->parent->pid : p->pid);

  time = (ticks - p->start_ticks);
  decim = time % 1000;
  time /= 1000;
  if(decim < 10)
    cprintf("%d.00%d\t", time, decim);
  else if(decim < 100 && decim >= 10)
    cprintf("%d.0%d\t", time, decim);
  else
    cprintf("%d.%d\t", time, decim);

    time = p->cpu_ticks_total;
    decim = time % 1000;
    time /= 1000;
  if(decim < 10)
    cprintf("%d.00%d\t", time, decim);
  else if(decim < 100 && decim >= 10)
    cprintf("%d.0%d\t", time, decim);
  else
    cprintf("%d.%d\t", time, decim);

    cprintf("%s\t", state);
    cprintf("%d\t", p->sz);
}
#elif defined(CS333_P1)
static void
procdumpP1(struct proc *p, char *state)
{
    cprintf("%d\t%s\t%s\t", p->pid, state, p->name);
    int time = (ticks - p->start_ticks);
    int decim = time % 1000;
    time /= 1000;
    if(decim < 10)
      cprintf("%d.00%d\t", time, decim);
    else if(decim < 100 && decim >= 10)
      cprintf("%d.0%d\t", time, decim);
    else
      cprintf("%d.%d\t", time, decim);
}
#endif

//---------------------------Marks Code Below------------------------------//
void
procdump(void)
{
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

#if defined(CS333_P3P4)
//#define HEADER "\nPID\tName         UID\tGID\tPPID\tPrio\tElapsed\tCPU\tState\tSize\t PCs\n"
#define HEADER "\nPID\tName\tUID\tGID\tPPID\tPrio\tElapsed\tCPU\tState\tSize\t PCs\n"
#elif defined(CS333_P2)
#define HEADER "\nPID\tName\tUID\tGID\tPPID\tElapsed\tCPU\tState\tSize\t PCs\n"
#elif defined(CS333_P1)
#define HEADER "\nPID\tState\tName\tElapsed\t PCs\n"
#else
#define HEADER ""
#endif

  cprintf(HEADER);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";

#if defined(CS333_P3P4)
  procdumpP3P4(p, state);
#elif defined(CS333_P2)
  procdumpP2(p, state);
#elif defined(CS333_P1)
  procdumpP1(p, state);
#else
  cprintf("%d %s %s", p->pid, state, p->name);
#endif

  if(p->state == SLEEPING){
    getcallerpcs((uint*)p->context->ebp+2, pc);
  for(i=0; i<10 && pc[i] != 0; i++)
    cprintf(" %p", pc[i]);
  }
    cprintf("\n");
  }
}
//---------------------------Marks Code Above------------------------------//
#ifdef CS333_P2
int
getprocs(uint max, struct uproc * table)
{
  struct proc *p;
  int counter = 0;
 
  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if(counter >= max)
    {
      break;
    }
    else
    {
      if(p->state != EMBRYO && p->state != UNUSED)
      {
        table[counter].pid = p->pid;
        table[counter].uid = p->uid;
        table[counter].gid = p->gid;
        table[counter].ppid = p->parent ? p->parent->pid : p->pid;
#ifdef CS333_P3P4
        table[counter].prio = p->priority;
#endif
        table[counter].elapsed_ticks = (ticks-p->start_ticks);
        table[counter].CPU_total_ticks = p->cpu_ticks_total;
        safestrcpy(table[counter].state, states[p->state], STRMAX);
        table[counter].size = p->sz;
        safestrcpy(table[counter].name, p->name, STRMAX);
        counter++;
      }
    }
  }

  release(&ptable.lock);
 
  if(counter == 0)
    return -1;

  return counter;
}
#endif

//-------------------------------------------------------------------
#ifdef CS333_P3P4
static int
stateListAdd(struct proc** head, struct proc** tail, struct proc* p)
{
  if (*head == 0) {
    *head = p;
    *tail = p;
    p->next = 0;
  } else {
    (*tail)->next = p;
    *tail = (*tail)->next;
    (*tail)->next = 0;
  }

  return 0;
}

static int
stateListRemove(struct proc** head, struct proc** tail, struct proc* p)
{
  if(*head == 0 || *tail == 0 || p == 0){
    return -1;
  }

  struct proc* current = *head;
  struct proc* previous = 0;

  if(current == p){
    *head = (*head)->next;
    // prevent tail remaining assigned when we've removed the only item
    // on the list
    if(*tail == p){
      *tail = 0;
    }
    return 0;
  }

  while(current){
    if(current == p){
      break;
    }

    previous = current;
    current = current->next;
  }

  // Process not found, hit eject.
  if(current == 0){
    return -1;
  }

  // Process found. Set the appropriate next pointer.
  if(current == *tail){
    *tail = previous;
    (*tail)->next = 0;
  } else{
    previous->next = current->next;
  }

  // Make sure p->next doesn't point into the list.
  p->next = 0;

  return 0;
}

static void
initProcessLists(void) {
  for(int i = 0; i < MAXPRIO+1; i++)
  {
    ptable.pLists.ready[i] = 0;
    ptable.pLists.readyTail[i] = 0;
  }
  ptable.pLists.free = 0;
  ptable.pLists.freeTail = 0;
  ptable.pLists.sleep = 0;
  ptable.pLists.sleepTail = 0;
  ptable.pLists.zombie = 0;
  ptable.pLists.zombieTail = 0;
  ptable.pLists.running = 0;
  ptable.pLists.runningTail = 0;
  ptable.pLists.embryo = 0;
  ptable.pLists.embryoTail = 0;
}

static void
initFreeList(void) {
  if (!holding(&ptable.lock)) {
    panic("acquire the ptable lock before calling initFreeList\n");
  }

  struct proc* p;

  for (p = ptable.proc; p < ptable.proc + NPROC; ++p) {
    p->state = UNUSED;
    stateListAdd(&ptable.pLists.free, &ptable.pLists.freeTail, p);
  }
}
#endif

#ifdef CS333_P3P4
static void
assertState(struct proc *p, enum procstate state)
{
  if(p->state != state)
  {
    cprintf("p = %d and enum = %d\n",p->state, state);
    panic("assertState failed\n");
  }
}

void
infodump(char input)
{
  struct proc *p;

  acquire(&ptable.lock);
  if(input == 'r')
  {
    for(int i = 0; i < MAXPRIO+1; i++)
    {
      p = ptable.pLists.ready[i];
      cprintf("Ready List Processes (%d):\n", i);
      if(p == 0)
        cprintf("Empty\n");

      while(p != 0)
      {
        if(p->next != 0)
          cprintf("(%d, %d) -> ", p->pid, p->budget);
        else
          cprintf("(%d, %d)\n", p->pid, p->budget);
        p = p->next;
      }
    }
  }

  if(input == 'f')
  {
    int size = 0;
    p = ptable.pLists.free;

    if(p == 0)
      cprintf("Empty\n");

    while(p != 0)
    {
      size += 1;
      p = p->next;
    }
    if(p == 0)
      cprintf("Free List Size: %d\n", size);
  }

  if(input == 's')
  {
    p = ptable.pLists.sleep;
    cprintf("Control -S\n");

    if(p == 0)
      cprintf("Empty\n");

    while(p != 0)
    {
      if(p->next != 0)
        cprintf("%d -> ", p->pid);
      else
        cprintf("%d\n", p->pid);
      p = p->next;
    }
  }

  if(input == 'z')
  {
    p = ptable.pLists.zombie;
    cprintf("Zombie List Processes:\n");

    if(p == 0)
      cprintf("Empty\n");

    while(p != 0)
    {
      if(p->next != 0)
        cprintf("(PID%d, PPID%d) -> ", p->pid, p->parent ? p->parent->pid : p->pid);
      else
        cprintf("(PPID%d, PPID%d)", p->pid, p->parent ? p->parent->pid : p->pid);
    }
  }
  release(&ptable.lock);
}

//Assignment 4 below
int
setpriority(int pid, int priority)
{
  struct proc *p;

  for(int i = 0; i < MAXPRIO+1; i++)
  {
    p = ptable.pLists.ready[i];

    while(p != 0)
    {
      if(p->pid == pid)
      {
        p->priority = priority;
        p->budget = BUDGET;
        return 0;
      }

      p = p->next;
    }
  }

  p = ptable.pLists.running;
  while(p != 0)
  {
    if(p->pid == pid)
    {
      p->priority = priority;
      p->budget = BUDGET;
      return 0;
    }

    p = p->next;
  }

  p = ptable.pLists.sleep;
  while(p != 0)
  {
    if(p->pid == pid)
    {
      p->priority = priority;
      p->budget = BUDGET;
      return 0;
    }

    p = p->next;
  }

  return -1;
}
#endif
