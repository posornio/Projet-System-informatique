#ifndef ASM_H
#define ASM_H

#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>

#define TSIZE 150

enum Operateur {
    NOP,ADD,MUL,SOU,DIV,COP,AFC,JMP,JMF,INF,SUP,EQU,PRI
};

enum Branch {
    IF,ELSE,WHILE
};

typedef struct AsmElement AsmElement;
 struct AsmElement{
    int Elem;
    AsmElement *suivant;
};


typedef struct TabAsm TabAsm;
struct TabAsm{
    char Name;
    AsmElement *instructions;
};


void init_TabAsm();
char OptoAsm(enum Operateur op);
char *stringtoAsm(char op);
void addElem(TabAsm *TabAsm, int Elem);
int addTabAsm(enum Operateur operateur, int argumentNumber,...);
void printTabAsm();
void editAsmBranch(int adressif, enum Operateur operateur, enum Branch branch);







#endif