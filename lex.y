%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "tableSymbole.h"
static int globalScope=0;
static int JmpCounter=0;
static int CmtAppel=0; 
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
%type <s> operand
%type <s> logical_operator
%type <s> andORdiff
%type <s> parametre_appel
%token <s> tID
%type <t_int> my_else
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
	tNB {//printf("#%d",$1); //char str[10]; 
	/*
	$$ =(char*) malloc( strlen(str) + 1 ) ;
	 sprintf(str ,"#%d",$1); 
	 strcpy($$,str);*/
	sprintf($$ ,"#%d",$1); 
	 //strcpy($$,str);
	 //strcpy($$,str);
	 }
	|math_operation{
		/*
		$$ = (char*) malloc(strlen("") + 1) ;
		strcpy($$,"");*/
		strcpy($$,"");
		} 
	|tID {printf(" %s ",$1 );//$$=(char*) malloc(strlen($1) + 1) ;strcpy($$,$1); 
	strcpy($$,$1);} ;	
	
logical_operator : 
	tLT {dernier_Lop="<";
		strcpy($$,"<");}
	|tGT {dernier_Lop=">";
	strcpy($$,">");}
	|tEQ {dernier_Lop="==";
	strcpy($$,"==");}
	|tGE {dernier_Lop=">=";
	strcpy($$,">=");}
	|tLE {dernier_Lop="<=";
	strcpy($$,"<=");};
	
	

logical_operation2 : 
	liste_math_operations logical_operator liste_math_operations 
	| tNOT logical_operation;
	
logical_operation :
	tID logical_operator tID
	{ printComp($2);printf("%d %d \n",getOffsetOf($1,ts),getOffsetOf($3,ts));}
	|tNB logical_operator tID
	{ printComp($2);printf("#%d %d\n",$1,getOffsetOf($3,ts));}
	| tID logical_operator tNB {char str[10];sprintf(str,"%d",$3);printComp($2);printf(" %d #%s",getOffsetOf($1,ts),str);}
; 
andORdiff: 
	|tAND {dernier_Lop="&&";strcpy($$,"&&");}
	|tOR {dernier_Lop="||";strcpy($$,"||");	}
	|tNE {dernier_Lop="!=";strcpy($$,"!=");	}; 

liste_logical_operations : 
	logical_operation {printf("\n");}
	|tLPAR liste_logical_operations tRPAR andORdiff tLPAR liste_logical_operations tRPAR;
	|logical_operation liste_logical_operations ;
	
math_operator : 
	tADD {dernier_op='+';}
	|tSUB {dernier_op='-';}
	|tMUL {dernier_op='*';}
	|tDIV {dernier_op='/';} 
	;
	
math_operation :
	operand math_operator { printf("%d",SizeTs(ts));
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

	/*my_if :
	tIF  {printf("Lb+%d :\n",JmpCounterBefore);} tLPAR liste_logical_operations tRPAR {printf("JNE L+%d",JmpCounter+1);}  bloc {JmpCounter++;printf("JMP Lb+ %d \n L+%d:",JmpCounterBefore,JmpCounter);} my_else ;
	*/
my_else :
{$$=0;} 	| tELSE bloc {$$=1; printf("La+%d :\n ",JmpCounter); }  ; 

my_if : tIF tLPAR liste_logical_operations tRPAR {printf("JNE L+%d",JmpCounter+1);}  bloc {JmpCounter++;printf("Lb+%d :\n",JmpCounter) ;} my_else {$8==1 ? printf("JMP La+ %d\n ",JmpCounter ) : printf("") ;  } ; 

my_while : tWHILE {printf("Lb+%d : \n",JmpCounterBefore);} tLPAR liste_logical_operations tRPAR {printf("JNE L+%d  \n ",JmpCounter+1);} bloc{JmpCounter++;printf("JMP Lb+ %d \n L+%d:",JmpCounterBefore,JmpCounter);}
; 

print : tPRINT tLPAR {printf("PRINT ");} liste_math_operations  tRPAR tSEMI {printf("\n");} ;
    
liste_id_dec : 
	tINT tID tCOMMA liste_id_dec ;


listeID:
	tID|
	tID listeID;

/*
liste_id_aff : 
	tID {printf("CPY %s",$1);}
	|tID tCOMMA liste_id_aff {printf("\n");} ;
*/
declaration_variable : 
	tINT  tID  tSEMI 	{pushTs(ts,$2,1,0,globalScope);printf("PUT %d %s \n" ,SizeTs(ts),$2);}	
 ;
	
initialisation_variable :
	tINT liste_id_dec tASSIGN liste_math_operations tSEMI{ //printf("initialisation_variable  en liste a faire apres\n " )
	 }
	|tINT tID tASSIGN liste_math_operations tSEMI{pushTs(ts,$2,1,0,globalScope); 
	//printf("initialisation_variable  \n "); 
	printf("PUT %d %s \n" ,SizeTs(ts),$2);
;};
	
affectation_variable :
	tID {printf("CPY %s",$1);} tASSIGN liste_math_operations tSEMI{ 
		printf("\n");
		}
	 ;
declaration_fonctions : declaration_fonction | declaration_fonction declaration_fonctions;

declaration_fonction : 
	tINT  tID {printf("%s :\n",$2);} tLPAR liste_parametres_declaration {Afficher_TS(ts);} tRPAR  bloc {printf("BX LR \n");} 
	|tVOID tID {printf("%s :\n",$2);} tLPAR liste_parametres_declaration tRPAR bloc;

appel_fonction : tID  tLPAR  liste_parametres_appel {CmtAppel=0;printf("PUSH LR \n");printf("CALL %s\n",$1);} tRPAR ;
appel_fonction_void : tID tLPAR  liste_parametres_appel {printf("PUSH LR \n");printf("CALL %s\n",$1);} tRPAR tSEMI;

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
	
	pushTs(ts,$2,1,0,globalScope);
	printf("PUT %d %s\n" ,SizeTs(ts),$2);
	
	printf("\n \n");
	}	
	|tVOID { //printf("parametre_declaration\n");
	};
	
	
liste_parametres_declaration :
	parametre_declaration 
	|parametre_declaration tCOMMA liste_parametres_declaration;
	
parametre_appel :
	tINT operand {
		//$$ =(char*) malloc(strlen($2)+1) ;
		strcpy($$,"");}
	|operand {//$$ =(char*) malloc(strlen($1)+1) ;
	strcpy($$,$1);} 
	|tVOID {//$$ =(char*) malloc(strlen("")+1) ;
	strcpy($$,"");} ;
		
	/*liste_parametres_appel : 
	parametre_appel
	|parametre_appel  { pushTs(ts,$1,1,0,globalScope);
						printf("PUT %d %s\n" ,SizeTs(ts),$2);} 
	 tCOMMA liste_parametres_appel;
*/

		
liste_parametres_appel : 
	parametre_appel {printf("MOV R%d %s \n", CmtAppel, $1);} 
	|parametre_appel {printf("MOV R%d %s \n", CmtAppel, $1); CmtAppel++;}  tCOMMA liste_parametres_appel;
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
