#include <stdio.h>
#include <stdint.h>

extern "C" int16_t calc(int8_t a, int8_t b, uint8_t func){

  switch(func){
    case 0:
      return a+b;
    case 1:
      return a-b;
    case 2:
      return a*b;
    case 3:
      if(b == 0){
        if(a >= 0) return 32767;
        else       return -32768;
      }
      else       return a/b;
    default:
      return 0;
  }

}
