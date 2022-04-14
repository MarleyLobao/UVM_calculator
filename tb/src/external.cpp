#include <stdio.h>

extern "C" int calc(int a, int b, int func){

  switch(func){
    case 0:
      return a+b;
    case 1:
      return a-b;
    case 2:
      return a*b;
    case 3:
      return a/b;
    default:
      return 0;
  }

}
