/* Carlos Augusto Amador Manilla A01329447 */
/* Angel Roberto Ruiz Mendoza A01324489 */

#ifndef FSYMBOL
#define FSYMBOL

#include "definitions.h"

FunctionSymbolNode** functionsTable;
ParamNode*paramsList;

void initFunctionsTable();
FunctionSymbolNode*createFunctionNode(char*identifier, Type type, HashTable*hashTable, TreeNode*syntaxTree, ParamNode*paramsList);
ParamNode*createParamNode(char*id, Type type, ParamNode*next);
ArgNode*createArgNode(TreeNode*syntaxTree, ArgNode*next);
FunctionSymbolNode*findFunction(char*id);
int insertFunctionSymbol(FunctionSymbolNode*node);
int addParamsToSymbolFunctionTable(HashTable*hashTable, ParamNode*paramsList);
void printArgsList(ArgNode*args);

#endif