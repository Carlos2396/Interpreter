/* Carlos Augusto Amador Manilla A01329447 */
/* Angel Roberto Ruiz Mendoza A01324489 */

#include "definitions.h"
#include "symbolTable.h"
#include "syntaxTree.h"

FunctionSymbolNode** functionsTable;

void initFunctionsTable() {
    functionsTable = (FunctionSymbolNode**) calloc(sizeof(FunctionSymbolNode*), SIZE);
}

FunctionSymbolNode*createFunctionNode(char*id, Type type, SymbolNode**hashTable, TreeNode*syntaxTree, ParamNode*paramsList) {
    FunctionSymbolNode*node = (FunctionSymbolNode*)malloc(sizeof(FunctionSymbolNode));
    node->identifier = strdup(id);
    node->type = type;
    node->hashTable = hashTable;
    node->syntaxTree = syntaxTree;
    node->paramsList = paramsList;
    node->next = NULL;

    return node;
}

ArgNode*createArgNode(TreeNode*syntaxTree, ArgNode*next) {
    ArgNode*node = (ArgNode*)malloc(sizeof(ArgNode));
    node->syntaxTree = syntaxTree;
    node->next = next;

    return node;
}

FunctionSymbolNode*findFunction(char*id) {
    int i = hash(id);

    if(functionsTable[i] == NULL) return NULL;

    FunctionSymbolNode* ptr = functionsTable[i];
    while(ptr != NULL && strcmp(id, ptr->identifier) != 0) {
        ptr = ptr->next;
    }

    return ptr;
}

ParamNode*createParamNode(char*id, Type type, ParamNode*next) {
    ParamNode*node = (ParamNode*)malloc(sizeof(ParamNode));
    node->identifier = id;
    node->type = type;
    node->next = next;

    return node;
}

int insertFunctionSymbol(FunctionSymbolNode*node) {
    int i = hash(node->identifier);
   
    if(functionsTable[i] == NULL) {
        functionsTable[i] = node;
        return 1;
    }

    FunctionSymbolNode*ptr = functionsTable[i];
    while(ptr->next != NULL) {
        if(strcmp(node->identifier, ptr->identifier) == 0) return 0;
        
        ptr = ptr->next;
    }

    if(strcmp(node->identifier, ptr->identifier) == 0) return 0;
    ptr->next = node;

    return 1;
}
