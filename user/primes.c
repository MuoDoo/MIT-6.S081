#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

void source() {
    int n;
    for(n = 2;n<=32;n++) {
        write(1,&n,sizeof n);
    }
}

void cull(int p) {
    int n;
    for(;read(0,&n,sizeof(n));) {
        if(n%p!=0) {
            write(1,&n,sizeof(n));
        }
    }
}

void redirect(int k,int pd[2]) {
    close(k);
    dup(pd[k]);
    close(pd[0]);
    close(pd[1]);
}

void sink() {
    int pd[2];
    int p;
    for(;read(0,&p,sizeof(p));) {
        fprintf(1,"prime %d\n",p);
        pipe(pd);
        if(fork()) {
            redirect(0,pd);
            continue;
        } else {
            redirect(1,pd);
            cull(p);
        }
    }
}

int main(int argc,char * argv[]) {
    int pd[2];
    pipe(pd);
    if(fork()) {
        redirect(0,pd);
        sink();
    } else {
        redirect(1,pd);
        source();
    }
    exit(0);
}