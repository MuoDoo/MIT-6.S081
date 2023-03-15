#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
  int parent_fd[2],child_fd[2];
  pipe(parent_fd);
  pipe(child_fd);
  char buf[32];
  if(fork()) {
    // parent
    write(parent_fd[1],"ping",4);
    read(child_fd[0],buf,4);
    wait(0);
    fprintf(1,"%d: received %s\n",getpid(),buf);
  } else {
    //child
    write(child_fd[1],"pong",4);
    read(parent_fd[0],buf,4);
    fprintf(1,"%d: received %s\n",getpid(),buf);
  }
  exit(0);
}
