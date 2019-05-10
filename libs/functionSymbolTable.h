/* Carlos Augusto Amador Manilla A01329447 */
/* Angel Roberto Ruiz Mendoza A01324489 */

#ifndef FSYMBOL
#define FSYMBOL

#include "definitions.h"

FunctionSymbolNode** functionsTable;
ParamNode*paramsList;

void initFunctionsTable();
FunctionSymbolNode*createFunctionNode(char*identifier, Type type, SymbolNode**hashTable, TreeNode*syntaxTree, ParamNode*paramsList);
FunctionSymbolNode*findFunction(char*id);
ParamNode*createParamNode(char*id, Type type, ParamNode*next);
ArgNode*createArgNode(TreeNode*syntaxTree, ArgNode*next);
FunctionCallNode*createFunctionCallNode(TreeNode*treeNode, FunctionCallNode*next);

int insertFunctionSymbol(FunctionSymbolNode*node);
int addParamsToSymbolFunctionTable(SymbolNode**hashTable, ParamNode*paramsList);
void printArgsList(ArgNode*args);
void addFunctionCall(FunctionCallNode*calls, FunctionCallNode*call);

#endif