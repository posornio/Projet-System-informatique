#include <stdbool.h>     
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tableSymbole.h"

Element* popTs(Ts* ts){
    printf("POP");
    if (ts==NULL || ts->first == NULL){
        exit(EXIT_FAILURE);
    }
    Element *elementDepile =ts->first;
    ts->first=elementDepile->suivant;
    return elementDepile;
}

Element* tailTs(Ts* ts){
        printf("TAIL");

    if (ts==NULL){
        exit(EXIT_FAILURE);
    }
    Element *retour= malloc(sizeof(*retour));;
    Element *elementDepile =ts->first;
    if(ts != NULL && ts->first != NULL) {
        retour->s= elementDepile->s;
        retour->init=elementDepile->init;
        retour->t=elementDepile->t;
        retour->offset= elementDepile->offset;
        retour->scope =elementDepile->scope;
    }
    return retour;
}

Ts* initTs(){
    Ts *ts= malloc(sizeof(ts));
    ts->first=NULL;
    return ts;

}



void pushTs(Ts* ts, char* s, bool init, int t, int scope){
    printf("Pile avant PUSH :");
    Afficher_TS(ts);
    Element* new =(Element*)malloc(sizeof(Element));
    if (ts==NULL) {
        exit(EXIT_FAILURE);
    }
    ///printf("PUSHTS AAAAAH\n");
    new->s=s;
    new->init=init;
    new->t=t;
    new->offset= (ts->first == NULL) ? 0 : ts->first->offset+1;
    new->scope=scope;
    new->suivant=ts->first;
    ts->first=new;
    printf("Pile apres PUSH :");

    Afficher_TS(ts);
    //printf("Pushts de \n",s);
}
int pushTswAdr(Ts* ts, char *s, bool init, int t, int scope){
        printf("PUSHTWS");

    Element *new = malloc(sizeof(Element));
    if (ts==NULL) {
        exit(EXIT_FAILURE);
    }
    new->s=s;
    new->init=init;
    new->t=t;
    new->offset= (ts->first == NULL) ? 0 : ts->first->offset+1;
    new->scope=scope;
    new->suivant=ts->first;
    ts->first=new;
    return new->offset;
}

void removeElementsWithScope(int scope,Ts* ts){
        printf("REM");
    
    if (ts == NULL){
        exit(EXIT_FAILURE);
    }
    while(ts->first && ts->first->scope >= scope){
        popTs(ts);
    } 
}
int freeTmp(Ts* ts){
    
    if (ts == NULL){
        exit(EXIT_FAILURE);
    }
    while(ts->first && strcmp(ts->first->s,"")){
        popTs(ts);
        }
    return(SizeTs(ts)); 
}

int SizeTs(Ts* ts){
    int ret=0;
    if (ts==NULL){
        printf("nul\n");
        return 0;
    }
    Element* e =ts->first;
    while(e !=NULL){
        ret++;
        //printf("%d",ret);
        e=e->suivant;
    }
    Afficher_TS(ts);
    return ret;
}
int getScopeOf(char* a,Ts* ts){
    if (ts->first == NULL) {
        return 1/0;
    }
    Element *e =ts->first;
    while (e && strcmp(e->s, a) != 0){
        e=e->suivant;

    }
    return e ? e->scope : -1;
}
int getOffsetOf(char* a,Ts *ts){
    if (ts->first == NULL) {
        return 1/0;
    }
    Element *e =ts->first;
    while (e && strcmp(e->s, a) != 0){
        e=e->suivant;
    }
    return e ? e->offset : -1;
}

void expression_arithmetique(char sym, Ts *ts ){
        printf("EXP");

    int t1= freeTmp(ts);
    int t2 = SizeTs(ts);
    //t1 et t2 renvoient le offset dans la table des symboles
    if (sym=='+'){
        printf("ADD %d %d %d\n",t1,t1,t2);
    }
    if (sym=='-'){
        printf("SUB %d %d %d\n",t1,t1,t2);
    }
    if (sym=='*'){
        printf("MUL %d %d %d\n",t1,t1,t2);
    }
}
void EisId(char *a,Ts *ts,int scope){
    int adr = getOffsetOf(a,ts);
    int adrt = pushTswAdr(ts,"",1,0,scope);
    printf("COP %d %d \n", adr,adrt);
}

void Afficher_TS(Ts *ts){
   
    Element* actuel =ts->first;

    while (actuel != NULL)
    {
        printf("%s     ",actuel->s);
        actuel = actuel->suivant;
    }
    printf("\n");
    
}
