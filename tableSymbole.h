#include <stdbool.h>     
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//enum typeEnum {INT, CHAR, LONG, DOUBLE, FLOAT};
typedef struct Element Element;
 struct Element{
    char*s;
    bool init;
    int t;
    int offset;
    int scope;
    Element *suivant;
};


typedef struct Ts Ts;
struct Ts{
    Element *first;
};
Ts* initTs();
void Afficher_TS(Ts *ts);
Element* popTs(Ts *ts);
void pushTs(Ts *ts, char *s, bool init, int t, int scope);
int pushTswAdr(Ts *ts, char *s, bool init, int t, int scope);
void removeElementsWithScope(int scope,Ts *ts);
int SizeTs(Ts *ts);
int getScopeOf(char* a,Ts *ts);
int freeTmp(Ts *ts);
int getOffsetOf(char* a,Ts *ts);
void expression_arithmetique(char sym, Ts *ts );
void EisId(char *a,Ts *ts,int scope);