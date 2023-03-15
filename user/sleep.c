#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
  int n= -1;

  if(argc < 2){
    fprintf(2, "Usage: sleep [n] for sleep n seconds\n");
    exit(1);
  }
  n = atoi(argv[1]);
  if( n < 0) {
    fprintf(2,"Please input a valid positive integer.\n");
    exit(1);
  }
  sleep(n);
  exit(0);
}
