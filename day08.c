#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct {
  enum {Nop, Acc, Jmp} cmd;
  int num;
  int cnt;
} p[628];

int run(int *acc)
{
  *acc = 0;
  int i = 0;
  while(p[i].cnt++ < 2 && i >= 0 && i <= 627) {
    switch(p[i].cmd) {
      case Acc: *acc += p[i].num;
      case Nop: i++; break;
      case Jmp: i += p[i].num;
    }
  }
  return i;
}

int main(void)
{
  int i = 0;
  char *line = NULL;
  size_t len = 0;
  while (getline(&line, &len, stdin) != -1) {
    p[i].cmd = strncmp(line, "nop", 3) == 0 ? Nop : strncmp(line, "acc", 3) == 0 ? Acc : Jmp;
    p[i].num = atoi(line + 4);
    p[i++].cnt = 0;
  }
  int acc;
  printf("%d\n", run(&acc)); // Part 1
  for(int i = 0; i < 628; i++) {
    for(int j = 0; j < 628; j++) p[j].cnt = 0;
    p[i].cmd = 2 - p[i].cmd;
    if(run(&acc) == 628) printf("%d\n", acc); // Part 2
    p[i].cmd = 2 - p[i].cmd;
  }
}
