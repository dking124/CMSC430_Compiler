// Darren King
// Compiler Theory and Design CMSC 430
// Dr. Duane J. Jarc
// Due Date: 5/9/23

// This file contains the function prototypes for the functions that produce the 
// compilation listing

enum ErrorCategories {LEXICAL, SYNTAX, GENERAL_SEMANTIC, DUPLICATE_IDENTIFIER,
	UNDECLARED};

void firstLine();
void nextLine();
int lastLine();
void appendError(ErrorCategories errorCategory, string message);

