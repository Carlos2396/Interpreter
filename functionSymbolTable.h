#ifndef FSYMBOL
#define FSYMBOL

#include "definitions.h"

FunctionSymbolNode**functionsST;

void initFunctionsTable();
int hash(char*c); // makes simple hash with the identifier string
FunctionSymbolNode*createFunctionNode(char*identifier, int paramsCount, Type type, TreeNode*syntaxTree, ParamNode*paramsList);
FunctionSymbolNode*findFunction(char*id);
ParamNode*createParamNode(char*id, Type type);
int insertFunctionSymbol(FunctionSymbolNode node);
void addParam(char*id, Type type);

#endif