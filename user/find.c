#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

char*
fmtname(char *path)
{
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
    ;
  p++;

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), '\0', DIRSIZ-strlen(p));

  return buf;
}


void find(char * path, char * fileName) {
    int fd = open(path,0);
    char buf[512],*p;
    struct dirent de;
    if(fd < 0) {
        return;
    }
    struct stat st;
    if(stat(path,&st) < 0) {
        close(fd);
        return;
    }
    switch (st.type)
    {
    case T_FILE:
        if(strcmp(fmtname(path),fileName) == 0) {
            fprintf(1,"%s\n",path);
        }
        break;
    case T_DIR:
        if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf) {
            break;
        }
        strcpy(buf, path);
        p = buf + strlen(buf);
        *p++ = '/';
        while(read(fd, &de, sizeof(de)) == sizeof(de)){
            if(de.inum == 0)
                continue;
            if(strcmp(de.name,".") == 0 || strcmp(de.name,"..") == 0) continue;
            memmove(p, de.name, DIRSIZ);
            p[DIRSIZ] = 0;
            if(stat(buf, &st) < 0){
                continue;
            }
            find(buf,fileName);
        }
        break;
    }
    close(fd);
}

int main(int argc,char * argv[]) {
    if(argc < 3) {
        fprintf(2,"Usage: find [dir] [filename]\n");
        exit(-1);
    }
    find(argv[1],argv[2]);
    exit(0);
}