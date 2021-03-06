%option yylineno
%pointer

%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "ast.hpp"
#include "parser.hpp"

void yyerror(const char *);
%}

/***************************************************************************
	Replace with your code from this point on
***************************************************************************/

%%

bool { return BOOL; }
else { return ELSE; }
if { return IF; }
int { return INT; }
for { return FOR; }
var { return VAR; }
function { return FUNCTION;}
intarray { return INTARRAY;}
return { return RETURN; }

"==" { return EQEQ; }
">" { return GT; }
">=" { return GTE; }
"<" { return LT; }
"<=" { return LTE; }
"!=" { return NE; }
"&&" { return ANDAND; }
"||" { return OROR; }
"!" { return NOT; }
"+" { return PLUS; }
"-" { return MINUS; }
"*" { return TIMES; }
"/" { return DIVIDE; }

true {  yylval.u_base_int = 1; return TRUE;}
false { yylval.u_base_int = 0; return FALSE; }

[0][x|X][0-9A-F]* {   yylval.u_base_int = strtol(yytext,NULL, 16); return INTEGER; }
[0][0-7]+ {           yylval.u_base_int = strtol(yytext,NULL, 8); return INTEGER;  }
[0-1]+[b] {          yylval.u_base_int = strtol(yytext,NULL, 2); return INTEGER; }
[1-9][0-9]* {        yylval.u_base_int = atoi(yytext); return INTEGER; }
[0] {                yylval.u_base_int = atoi(yytext); return INTEGER; }

";" { return SEMICOLON;}
":" { return COLON; }
"," { return COMMA; }
"|" { return ABSOLUTEVALUE;}
"{" { return LEFTBRACE;}
"}" { return RIGHTBRACE; }
"(" { return LEFTPAREN; }
")" { return RIGHTPAREN; }
"[" { return LEFTBRACKET; }
"]" { return RIGHTBRACKET; }
"=" { return ASSIGNMENT; }
"[$"([^\$]|\$[^\]])*"$]" ;
[a-zA-Z][a-zA-Z0-9]* {  yylval.u_base_charptr = strdup(yytext); return IDENTIFIER;}

[ \t\n] ; /* skip whitespace */

. yyerror((char *) "invalid character");

%%

/***************************************************************************
	Stop replacing code here
***************************************************************************/

int yywrap(void) {
	return 1;
}
