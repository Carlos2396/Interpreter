#include "definitions.h"
#include "symbolTable.h"

FunctionSymbolNode** functionsTable;
ParamNode*paramsList;

void initFunctionsTable() {
    functionsTable = (FunctionSymbolNode**) calloc(sizeof(FunctionSymbolNode*), SIZE);
    paramsList = NULL;
}

int hash(char*c) {
    int sum = 0;
    while((*c) != '\0') {
        sum += *c;
        c++;
    }

    return sum%SIZE;
}

FunctionSymbolNode*createFunctionNode(char*id, int paramsCount, Type type, HashTable*hashTable, TreeNode*syntaxTree, ParamNode*paramsList) {
    FunctionSymbolNode*node = (FunctionSymbolNode*)malloc(sizeof(FunctionSymbolNode));
    node->identifier = strdup(id);
    node->paramsCount = paramsCount;
    node->type = type;
    node->hashTable = hashTable;
    node->syntaxTree = syntaxTree;
    node->paramsList = paramsList;
    node->next = NULL;

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

ParamNode*createParamNode(char*id, Type type) {
    ParamNode*node = (ParamNode*)malloc(sizeof(ParamNode));
    node->identifier = id;
    node->type = type;
    node->next = NULL;

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

void addParam(char*id, Type type) {
    ParamNode*node = createParamNode(id, type);

    if(paramsList == NULL) {
        paramsList = node;
    }
    else {
        ParamNode*ptr = paramsList;
        while(ptr->next != NULL) {
            ptr = ptr->next;
        }

        ptr->next = node;
    }
}

int addParamsToSymbolTable(char*id) {
    FunctionSymbolNode*node = findFunction(id);

    while(paramsList != NULL) {
        if(!insertSymbol(paramsList->identifier, paramsList->type, (Value)0, node->hashTable)) {
            return 0;
        }
        
        paramsList = paramsList->next;
    }

    return 1;
}