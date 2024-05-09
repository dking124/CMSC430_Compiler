/* Compiler Theory and Design
   Darren King
   Dr. Duane J. Jarc 
   CMSC430 Project 4
   Due Date: 5/9/23*/

/* This file contains flex input file */

%{

#include <string>
#include <vector>
#include <map>

using namespace std;

#include "types.h"
#include "listing.h"
#include "symbols.h"

int yylex();
void yyerror(const char* message);

Symbols<Types> symbols;

%}

%define parse.error verbose

%union
{
	CharPtr iden;
	Types type;
}

%token <iden> IDENTIFIER
%token <type> INT_LITERAL REAL_LITERAL BOOL_LITERAL

%token ADDOP MULOP RELOP ANDOP REMOP EXPOP OROP NOTOP
%token BEGIN_ BOOLEAN END ENDREDUCE FUNCTION INTEGER IS REDUCE RETURNS REAL IF THEN ELSE ENDIF CASE OTHERS ARROW ENDCASE WHEN

%type <type> function_header body type statement statement_ cases case
	reductions expression orop relation term factor exponent unary primary

%%

function:	
	function_header optional_variable body {checkAssignment($1, $3, "Function Return");} ;
	
function_header:	
	FUNCTION IDENTIFIER optional_parameters RETURNS type ';' {$$ = $5;} |
	error ';' {$$ = MISMATCH;} ;

optional_variable:
	optional_variable variable |
	;

variable:	
	IDENTIFIER ':' type IS statement_ 
		{checkAssignment($3, $5, "Variable Initialization");
		!symbols.find($1, $3) ? symbols.insert($1, $3) : appendError(GENERAL_SEMANTIC, "Duplicate Identifier: " + string($1)) ;} |
	error ';' ;

optional_parameters:
	parameters |
	;

parameters:
	parameter |
	parameter ',' parameters ;

parameter:
	IDENTIFIER ':' type ;

type:
	INTEGER {$$ = INT_TYPE;} |
	REAL {$$ = REAL_TYPE;} |
	BOOLEAN {$$ = BOOL_TYPE;} ;

body:
	BEGIN_ statement_ END ';' {$$ = $2;} ;
    
statement_:
	statement ';' |
	error ';' {$$ = MISMATCH;} ;
	
statement:
	expression |
	REDUCE operator reductions ENDREDUCE {$$ = $3;} |
	IF expression THEN statement_ ELSE statement_ ENDIF {$$ = checkIf($2, $4, $6);} |
	CASE expression IS cases OTHERS ARROW statement_ ENDCASE {checkCase($2); $$ = $<type>4 == $<type>7 ? $4 : MISMATCH;} ;

operator:
	ADDOP |
	MULOP ;

cases:
	cases case {$$ = checkWhen($1, $2) ;} |
	{$$ = NAN ;} ;

case:
	WHEN INT_LITERAL ARROW statement_ {$$ = $4;} ;

reductions:
	reductions statement_ {$$ = checkArithmetic($1, $2);} |
	{$$ = INT_TYPE;} ;
		    
expression:
	expression OROP orop {$$ = checkLogical($1, $3);} |
	orop ;

orop:
	orop ANDOP relation {$$ = checkLogical($1, $3);} |
	relation ;

relation:
	relation RELOP term {$$ = checkRelational($1, $3);}|
	term ;

term:
	term ADDOP factor {$$ = checkArithmetic($1, $3);} |
	factor ;
      
factor:
	factor MULOP exponent  {$$ = checkArithmetic($1, $3);} |
	factor REMOP exponent  {$$ = checkRemainder($1, $3);} |
	exponent ;

exponent:
	unary EXPOP exponent {$$ = checkArithmetic($1, $3);} |
	unary ;

unary:
	NOTOP unary {$$ = checkLogical($<type>2, $2);} |
	primary ;

primary:
	'(' expression ')' {$$ = $2;} |
	INT_LITERAL |
	REAL_LITERAL |
	BOOL_LITERAL |
	IDENTIFIER {if (!symbols.find($1, $$)) appendError(UNDECLARED, $1);} ;
    
%%

void yyerror(const char* message)
{
	appendError(SYNTAX, message);
}

int main(int argc, char *argv[])    
{
	firstLine();
	yyparse();
	lastLine();
	return 0;
} 
