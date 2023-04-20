%{
#include <stdio.h>
#include <stdlib.h>
#include "tableSymbole.h"
static int globalScope=0;
static int JmpCounter=0;
static int JmpCounterBefore=0;


static Ts *ts;
char dernier_op;
char* dernier_Lop;

%}

%define parse.trace 
%error-verbose
%verbose

%union {
	char s[128];
	int t_int;
}
%code provides {
  int yylex (void);
  void yyerror (const char *);
}

%token tIF tELSE tWHILE tPRINT tRETURN tINT tVOID tADD tSUB tMUL tDIV
%token tLT tGT tNE tEQ tGE tLE tASSIGN tAND tOR tNOT tLBRACE tRBRACE tLPAR tRPAR
%token tSEMI tCOMMA 

%token <s> tID
%token <t_int> tNB
%start declaration_fonctions
%left tOR
%left tELSE
%left tAND
%left tEQ tNE
%left tLT tGT tLE tGE
%left tADD tSUB
%left tMUL tDIV
%%
operand : 
	tNB {printf("#%d",$1);}
	|math_operation
	|tID {printf(" %s ",$1 );} 
	;
	
logical_operator : 
	tLT {dernier_Lop="<";}
	|tGT {dernier_Lop=">";}
	|tNE {dernier_Lop="!=";}
	|tEQ {dernier_Lop="==";}
	|tGE {dernier_Lop=">=";}
	|tLE {dernier_Lop="<=";}
	|tAND {dernier_Lop="&&";}
	|tOR {dernier_Lop="||";}; 
	

logical_operation2 : 
	liste_math_operations logical_operator liste_math_operations 
	| tNOT logical_operation;
	
logical_operation :
	tID logical_operator tID
	{printf("%d %d",getOffsetOf($1,ts),getOffsetOf($3,ts));}
	|tNB logical_operator tID
	{printf("#%d %d",$1,getOffsetOf($3,ts));}
	| tID logical_operator tNB {printf("%d #%d",getOffsetOf($1,ts),$3);}
; 
	
liste_logical_operations : 
	logical_operation 
	|logical_operation liste_logical_operations ;
	
math_operator : 
	tADD {dernier_op='+';}
	|tSUB {dernier_op='-';}
	|tMUL {dernier_op='*';}
	|tDIV { {dernier_op='/';} 
		printf("math_operator ");};
	
math_operation :
	operand math_operator { printf("math_operation \n");
	printf("%d",SizeTs(ts));
	expression_arithmetique(dernier_op,ts);
	} operand |
	appel_fonction;
	
liste_math_operations :
	operand 
	|math_operation
	|math_operation math_operator liste_math_operations 
	;
	
programme: 
	liste_blocs ;

liste_blocs:
    bloc
    |bloc liste_blocs;

my_return: tRETURN liste_math_operations tSEMI ;

my_if :
	tIF  {printf("Lb+%d :\n",JmpCounterBefore);} tLPAR  {printf("CMP ");}  liste_logical_operations tRPAR {printf("JNE L+%d",JmpCounter+1);}  bloc {JmpCounter++;printf("JMP Lb+ %d \n L+%d:",JmpCounterBefore,JmpCounter);}
    | my_if tELSE   bloc ;

my_while : tWHILE {printf("Lb+%d : \n",JmpCounterBefore);} tLPAR  {printf("CMP ");} liste_logical_operations tRPAR {printf("JNE L+%d",JmpCounter+1);} bloc{JmpCounter++;printf("JMP Lb+ %d \n L+%d:",JmpCounterBefore,JmpCounter);}
; 

print : tPRINT tLPAR liste_math_operations tRPAR tSEMI;
    
liste_id_dec : 
	tINT tID tCOMMA liste_id_dec ;


listeID:
	tID|
	tID listeID;


liste_id_aff : 
	tID {printf("CPY %s",$1);}
	|tID tCOMMA liste_id_aff ;

declaration_variable : 
	tINT  tID  tSEMI 	{pushTs(ts,$2,1,0,globalScope);printf("PUT %d %s \n" ,SizeTs(ts),$2);}	
 ;
	
initialisation_variable :
	tINT liste_id_dec tASSIGN liste_math_operations tSEMI{ printf("initialisation_variable  en liste a faire apres\n " ) }
	|tINT tID tASSIGN liste_math_operations tSEMI{pushTs(ts,$2,1,0,globalScope); printf("initialisation_variable  \n "); printf("PUT %d %s \n" ,SizeTs(ts),$2);
;};
	
affectation_variable :
	liste_id_aff tASSIGN liste_math_operations tSEMI{ printf("\n affectation_variable avec \n");}
	 ;
declaration_fonctions : declaration_fonction | declaration_fonction declaration_fonctions;

declaration_fonction : 
	tINT  tID tLPAR liste_parametres_declaration {Afficher_TS(ts);} tRPAR {Afficher_TS(ts);} bloc 
	|tVOID tID tLPAR liste_parametres_declaration tRPAR bloc;

appel_fonction : tID tLPAR  liste_parametres_appel tRPAR ;
appel_fonction_void : tID tLPAR  liste_parametres_appel tRPAR tSEMI;

bracket : tLBRACE{ //globalScope++;
Afficher_TS(ts);} 
| tRBRACE{
	//removeElementsWithScope(globalScope,ts);
	globalScope--;}

instruction:
	declaration_variable
	|affectation_variable
	|initialisation_variable
	|declaration_fonction
	|appel_fonction_void
	|my_if
	|my_while
	|print
	|my_return;
	
liste_instructions :
	instruction
	|instruction liste_instructions;

bloc : 
	instruction
	|tLBRACE liste_instructions tRBRACE { printf("bloc avec scope %d \n",globalScope);};
	
parametre_declaration :
	tINT tID{
	
	printf("declaration de %s\n", $2);
	pushTs(ts,$2,1,0,globalScope);
	printf("PUT %d %s\n" ,SizeTs(ts),$2);
	
	printf("\n \n");
	}	
	|tVOID { printf("parametre_declaration\n");};
	
	
liste_parametres_declaration :
	parametre_declaration 
	|parametre_declaration tCOMMA liste_parametres_declaration;
	
parametre_appel :
	tINT operand 
	|operand 
	|tVOID ;
		
liste_parametres_appel : 
	parametre_appel
	|parametre_appel tCOMMA liste_parametres_appel;
%%

void yyerror(const char *msg) {
  fprintf(stderr, "error: %s\n", msg);
  exit(1);
}

int main(void) {
	//yydebug = 1;
	ts = initTs();
  yyparse();
}
