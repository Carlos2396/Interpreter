/* Carlos Augusto Amador Manilla A01329447 */
/* Angel Roberto Ruiz Mendoza A01324489 */

#ifndef FSTACK
#define FSTACK

#include "definitions.h"

FunctionStack* stack;

void initStack();
FunctionStackNode*createFunctionStackNode(char*identifier, Value val);
void push(char*identifier, Value val);
FunctionStackNode* pop();
FunctionStackNode* peak();
void printFunctionSatck();

#endif