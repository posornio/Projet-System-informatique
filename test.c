#include <stdbool.h>     
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tableSymbole.h"
int main(void){ 
    Ts *ts =initTs();
    pushTs(ts,"a",1,1,0);
    pushTs(ts,"b",1,1,1);
    pushTs(ts,"c",1,1,1);
    printf("%d\n",getScopeOf("c",ts));
    printf("%d\n",getOffsetOf("c",ts));
    removeElementsWithScope(1,ts);
    printf("%d\n",SizeTs(ts));
    return 0;
}