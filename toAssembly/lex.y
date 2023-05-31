%{
#include <stdio.h>
#include <stdlib.h>
#include "tableSymbole.h"
#include "asm/asm.h"


static int globalScope=0;
static int CmtAppel=0; 

//gestion des branchements
int JmpTab[TSIZE];
int JmpCounter = 0;

//var temporaire
int Bascule = 0; 
int calc = 7;
int Init = 0;


static Ts *ts;
char dernier_op;
char* dernier_Lop;
int tempo(int temp,int var);

%}

%define parse.trace 
%verbose

%union {
	char s[128];
	int t_int;
	int nb;;
}

%code provides {
  int yylex (void);
  void yyerror (const char *);
}

%token tIF tELSE tWHILE tPRINT tRETURN tINT tVOID tADD tSUB tMUL tDIV
%token tLT tGT tNE tASSIGN tLBRACE tRBRACE tLPAR tRPAR
%token tSEMI tCOMMA tMAIN

%token <s> tID
%token <t_int> tNB
%start declaration_fonctions
%right tEQ
%left tELSE

%left tNE
%left tLT tGT
%left tADD tSUB
%left tMUL tDIV
%type <nb> Expr 
%type <t_int> my_else


%%




Expr : Expr tADD Expr {addTabAsm(ADD,3,$1,$1,$3); $$ = $1;}	
	
	| Expr tMUL Expr {addTabAsm(MUL,3,$1,$1,$3); $$ = $1;}
	
	| Expr tDIV Expr {addTabAsm(DIV,3,$1,$1,$3); $$ = $1;}
	
	| Expr tSUB Expr {addTabAsm(SOU,3,$1,$1,$3); $$ = $1;}

	| Expr tNE Expr {
		addTabAsm(SOU,3,$1,$1,$3);
		$$ = $1;
	}
	| Expr tGT Expr {
		addTabAsm(SUP,3,$1,$1,$3);
		$$ = $1;
	}
	| Expr tEQ  Expr {
		addTabAsm(SOU, 3, $1, $1, $3);   // $1 = $1 - $3
		addTabAsm(AFC, 2, $1, 1);         // $1 = 1 (valeur par défaut)
		addTabAsm(JMF, 2, $1, 0);         // Sauter si $1 est faux
		addTabAsm(AFC, 2, $1, 0);         // $1 = 0 (résultat de l'égalité)
    $$ = $1;}
	
	| Expr tLT Expr {
		addTabAsm(INF,3,$1,$3,$1);
		$$ = $1;
	}
	
	| tNB  {$$ = tempo($1,0);}
	
	| tID {
    int idValue = getOffsetOf($1,ts); // on recupère dans notre table des symboles 
    $$ = tempo(idValue, 1);
	printf("valeur %d \n",idValue);}
	| appel_fonction { //$$ = 
	};




my_return: tRETURN Expr tSEMI ;


my_else : {
	JmpTab[JmpCounter] = addTabAsm(JMP,0); 
	JmpCounter ++;
	} 	
	| tELSE bloc 
	{
			editAsmBranch(JmpTab[JmpCounter],JMP,ELSE);
	}; 



my_if : tIF tLPAR Expr tRPAR {
		JmpTab[JmpCounter] = addTabAsm(JMF,2,$3,0);
		JmpCounter ++;
	}  bloc {
		JmpCounter --;
		editAsmBranch(JmpTab[JmpCounter],JMF,IF); 
		} my_else
		

my_while : tWHILE tLPAR {
		JmpTab[JmpCounter] = addTabAsm(NOP,0);
		JmpCounter ++;
	}

	Expr tRPAR {
		JmpTab[JmpCounter] = addTabAsm(JMF,2,$4,0);
		JmpCounter ++;

	} bloc{
		JmpCounter --;
		int adressWhile = JmpTab[JmpCounter];
		printf("JmpCounter:%d\n",JmpCounter);
		printf("JmpTab[JmpCounter]:%d\n",JmpTab[JmpCounter]);

		JmpCounter --;
		int adressCond = JmpTab[JmpCounter];
		printf("JmpCounter:%d\n",JmpCounter);
		printf("adressCond:%d\n",adressCond);

		addTabAsm(JMP,1,adressCond);
		editAsmBranch(adressWhile,JMF,WHILE);
	}; 

print : tPRINT tLPAR Expr  tRPAR tSEMI {
		addTabAsm(PRI,1,$3);
		};
		
liste_declaration_variable : tID{
		pushTs(ts,$1,1,0,globalScope);
	}
	|tID tCOMMA liste_declaration_variable{
		pushTs(ts,$1,1,0,globalScope);
	}
;

declaration_variable : tINT liste_declaration_variable tSEMI 
;
	
initialisation_variable : tINT tID tASSIGN Expr tSEMI{
	pushTs(ts,$2,1,0,globalScope); 
	int idValue = getOffsetOf($2,ts);
	//printf("initialisation_variable  \n "); 
	Afficher_TS(ts);
	addTabAsm(COP,2,idValue,$4);
	};
	
affectation_variable :
	tID tASSIGN Expr tSEMI{ 
		int idValue =getOffsetOf($1,ts);
		printf("AFFECTATION VAR, tID = %d \n",idValue);
		addTabAsm(COP,2,idValue,$3);
		};

declaration_fonctions : declaration_fonction 
	| declaration_fonction declaration_fonctions;


declaration_fonction : 
	tINT  tID {
		printf("%s :\n",$2);
		} tLPAR liste_parametres_declaration {
			Afficher_TS(ts);
			} tRPAR  bloc {
				removeElementsWithScope(globalScope,ts);
				} 
	|tVOID tID {
		printf("%s :\n",$2);
		} tLPAR liste_parametres_declaration tRPAR bloc;
	|tINT Main
	|tVOID Main

appel_fonction : tID  tLPAR  Arg {
	CmtAppel=0;printf("PUSH LR \n");printf("CALL %s\n",$1);
	} tRPAR ;


appel_fonction_void : tID tLPAR  Arg {
	printf("PUSH LR \n");printf("CALL %s\n",$1);
	} tRPAR tSEMI;



Main : tMAIN {
	printf("MAIN \n");
	} tLPAR liste_parametres_declaration tRPAR bloc;


instruction:
	declaration_variable
	|affectation_variable
	|initialisation_variable
	|appel_fonction_void
	|my_if
	|my_while
	|print
	|my_return;
	
liste_instructions :
	instruction
	|instruction liste_instructions;

bloc : tLBRACE {		
		Init = 0;
		Bascule = 0;
		}liste_instructions tRBRACE { 
		Init = 0;
		Bascule = 0;
		};
	
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
	



Arg : Expr 
	| Expr tCOMMA Arg 


%%

int tempo(int temp,int var){

	int retour = calc + Init + Bascule;
	printf("Init : %d\n",Init);
	printf("Bascule : %d\n",Bascule);
	
	if(!Init)
		Init = 1;

	else
		Bascule = ! Bascule;

	if(var){
		printf("addTabAsm : instruction COP, retour: %d ,temp %d \n",retour,temp);
		addTabAsm(COP, 2, retour, temp);
	}
	else{
		printf("addTabAsm AFC: instruction , retour: %d ,temp %d \n",retour,temp);
		addTabAsm(AFC, 2, retour, temp);
	}
	return retour;
}


void yyerror(const char *msg) {
  fprintf(stderr, "error: %s\n", msg);
  exit(1);
}

int main(void) {
	
	//debug 
	yydebug = 0;

	//init des tableaux 
	ts = initTs();
	init_TabAsm();

 	yyparse();


	printTabAsm();

}
