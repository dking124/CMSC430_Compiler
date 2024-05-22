# CMSC 430 Compiler

## About

This compiler was developed with lex and yacc with the focus on the lexical, syntax, and semantic analyzers. When executing the compiler with a given txt file, it will return whether the file correctly follows the EBNF grammar below or if there are lexical, syntax, and semantic errors.

## EBNF Grammar

```
function:
 function_header {variable} body ;

function_header:
 FUNCTION IDENTIFIER [parameters] RETURNS type ;

variable:
 IDENTIFIER : type IS statement ;

parameters:
 parameter {, parameter} ;

parameter:
 IDENTIFIER : type ;

type:
 INTEGER | REAL | BOOLEAN ;

body:
 BEGIN statement END ;

statement:
 expression ; |
 REDUCE operator {statement} ENDREDUCE ; |
 IF expression THEN statement ELSE statement ENDIF ; |
 CASE expression IS {case} OTHERS ARROW statement ENDCASE ;

operator:
 ADDOP | MULOP ;

case:
 WHEN INT_LITERAL ARROW statement ;

expression:
 ( expression ) |
 expression binary_operator expression |
 NOTOP expression |
 INT_LITERAL | REAL_LITERAL | BOOL_LITERAL |
 IDENTIFIER ;
 
binary_operator: 
 ADDOP | MULOP | REMOP | EXPOP | RELOP | ANDOP | OROP ;
 ```

## Getting Started

The Compiler requires a linux environment to run. View below for installation instructions for either Windows or Linux.

### Installation

Windows:

Download [cygwin](https://www.cygwin.com/install.html) setup-x86_64.exe.
Run setup-x86_64.exe and proceed through the setup.
When selecting a download site, view [cygwin.com/mirrors.html](https://www.cygwin.com/mirrors.html) to see which site is nearest to you.
In the Select Packages pages, change the View to "Full" to see all packages.
Search and select the following packages to install:
```
make
flex
bison
gcc-g++
```

Linux:

```
sudo apt-get update
sudo apt-get install make flex bison g++
```

Windows/Linux:

Git clone the repository at your desired location:
```
git clone https://github.com/dking124/CMSC430_Compiler.git
```

Move to the CMSC430_Compiler directory and use the following command to create compile.exe:
```
make
```

### Example

To use the compiler, you will need to create a txt file or use the given test files. In the directory where compile.exe is, use the following commands and the path to your test file:
```
./compile < "semantic_tests/semantic8.txt"
```
![Semantic Test](/semantic8.png?raw=true "Semantic Test")

The compiler will state the types of errors in your txt file that do not comply with the grammar, so adjust until it compiles successfully. 
