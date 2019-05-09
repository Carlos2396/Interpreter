#ifndef FSYMBOL
#define FSYMBOL

#include "definitions.h"

FunctionSymbolNode** functionsTable;
ParamNode*paramsList;

void initFunctionsTable();
int hash(char*c); // makes simple hash with the identifier string
FunctionSymbolNode*createFunctionNode(char*identifier, Type type, HashTable hashTable, TreeNode*syntaxTree, ParamNode*paramsList);
ParamNode*createParamNode(char*id, Type type, ParamNode*next);
ArgNode*createArgNode(TreeNode*syntaxTree, ArgNode*next);
FunctionSymbolNode*findFunction(char*id);
int insertFunctionSymbol(FunctionSymbolNode node);
void addParam(char*id, Type type);
int addParamsToSymbolTable(ParamNode*paramList, FunctionSymbolNode node);

#endif