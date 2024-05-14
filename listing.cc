// Darren King
// Compiler Theory and Design CMSC 430
// Dr. Duane J. Jarc
// Due Date: 5/9/23

// This file contains the bodies of the functions that produces the compilation
// listing

#include <cstdio>
#include <string>
#include <queue>

using namespace std;

#include "listing.h"

static int lineNumber;
static string error = "";
static int totalErrors = 0;
static int lexicalErrors = 0;
static int syntaxErrors = 0;
static int semanticErrors = 0;
static queue<string> q;

static void displayErrors();

void firstLine()
{
	lineNumber = 1;
	printf("\n%4d  ",lineNumber);
}

void nextLine()
{
	displayErrors();
	lineNumber++;
	printf("%4d  ",lineNumber);
}

int lastLine()
{
	printf("\r");
	displayErrors();
	printf("     \n");
	if (totalErrors == 0) {
		printf("Compiled Successfully\n");
	}
	else
	{
		printf("Lexical Errors: %d\n", lexicalErrors);
		printf("Syntax Errors: %d\n", syntaxErrors);
		printf("Semantic Errors: %d\n", semanticErrors);
	}
	return totalErrors;
}
    
void appendError(ErrorCategories errorCategory, string message)
{
	string messages[] = { "Lexical Error, Invalid Character ", "",
		"Semantic Error, ", "Semantic Error, Duplicate Identifier: ",
		"Semantic Error, Undeclared " };

	error = messages[errorCategory] + message;
	q.push(error);
	if (errorCategory == 0) {
		lexicalErrors++;
	}
	else if (errorCategory == 1) {
		syntaxErrors++;
	}
	else if (errorCategory == 2) {
		semanticErrors++;
	}
	totalErrors++;
}

void displayErrors()
{
	while (!q.empty()) {
		printf("%s\n", q.front().c_str());
		q.pop();
	}
}