%option noyywrap
%option noinput
%option nounput

%{
#include <stdio.h>
#include "lex.tab.h"
#include "tableSymbole.h"
%}

%%
            
[0-9]+             {return(tNB);} 
0x[0-9A-Fa-f]+     {return(tNB);} 

"if" {return(tIF);}
"else" {return(tELSE);}
"while" {return(tWHILE);}
"print" {return(tPRINT);}
"return" {return(tRETURN);}
"int" {return(tINT);}
"void" {return(tVOID);}

"//"[^"\n"]*"\n"     
"/*"[^"*/"]*"*/"    

"+" {return(tADD);}
"-" {return(tSUB);}
"*" {return(tMUL);}
"/" {return(tDIV);}
"<" {return(tLT);}
">" {return(tGT);}
"!=" {return(tNE);}
"==" {return(tEQ);}
">=" {return(tGE);}
"<=" {return(tLE);}
"=" {return(tASSIGN);}
"&&" {return(tAND);}
"||" {return(tOR);}
"!" {return(tNOT);}
"{" {return(tLBRACE);}
"}" {return(tRBRACE);}
"(" {return(tLPAR);}
")" {return(tRPAR);}
";" {return(tSEMI);}
"," {return(tCOMMA);}

[ \t\n]+  

[a-zA-Z][a-zA-Z0-9]*	{ printf("\n tID: '%s'\n", yytext); strcpy(yylval.s, yytext); return tID; }

. {yyerror(yytext);}

%%

/*
int main( int argc, char **argv )
    {
    ++argv, --argc;  // skip over program name 
    if ( argc > 0 )
            yyin = fopen( argv[0], "r" );
    else
            yyin = stdin;

    yylex();
    }
*/
