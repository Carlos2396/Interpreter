/* Carlos Augusto Amador Manilla A01329447 */
/* Angel Roberto Ruiz Mendoza A01324489 */

#ifndef FSYMBOL
#define FSYMBOL

#include "definitions.h"

FunctionSymbolNode** functionsTable;
ParamNode*paramsList;

void initFunctionsTable(); // Reserves memory for the functions symbol table
FunctionSymbolNode*createFunctionNode(char*identifier, Type type, SymbolNode**hashTable, TreeNode*syntaxTree, ParamNode*paramsList); // cretes a FunctionSymbolNode struct 
ParamNode*createParamNode(char*identifier, Type type, ParamNode*next); // creates a ParamNode struct
ArgNode*createArgNode(TreeNode*syntaxTree, ArgNode*next); // creates an ArgNode struct

FunctionSymbolNode*findFunction(char*identifier); // Search for a function with the given identifier in the functions symbol table, return NULL if not found
int insertFunctionSymbol(FunctionSymbolNode*node); // inserts a FunctionSymbolNode in the functions symbol table
#endif