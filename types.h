// Darren King
// Compiler Theory and Design CMSC 430
// Dr. Duane J. Jarc
// Due Date: 5/9/23

// This file contains type definitions and the function
// prototypes for the type checking functions

typedef char* CharPtr;

enum Types {MISMATCH, INT_TYPE, REAL_TYPE, BOOL_TYPE, NAN};

void checkAssignment(Types lValue, Types rValue, string message);
Types checkArithmetic(Types left, Types right);
Types checkLogical(Types left, Types right);
Types checkRelational(Types left, Types right);
Types checkRemainder(Types left, Types right);
Types checkIf(Types expression, Types left, Types right);
void checkCase(Types expression);
Types checkWhen(Types left, Types right);