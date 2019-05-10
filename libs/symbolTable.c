/* Carlos Augusto Amador Manilla A01329447 */
/* Angel Roberto Ruiz Mendoza A01324489 */

#include "definitions.h"
#include "symbolTable.h"

/*
 * Methods
*/

//Methods that creates a new structure that has a hash table and the remaining to add symbols
SymbolNode**initSymbolTable() {
    SymbolNode**hashTable = (SymbolNode**)calloc(sizeof(SymbolNode*), SIZE);
    return hashTable;
}

SymbolNode*createSymbolNode(char*id, Type t, Value val) {
    SymbolNode*temp = (SymbolNode*)malloc(sizeof(SymbolNode));
    temp->identifier = strdup(id);
    temp->type = t;
    temp->val = val;

    return temp;
}

SymbolNode*findSymbol(char*id, SymbolNode**hashTable) {
    int i = hash(id);

    if(hashTable[i] == NULL) return NULL;

    SymbolNode* ptr = hashTable[i];
    while(ptr != NULL && strcmp(id, ptr->identifier) != 0) {
        ptr = ptr->next;
    }

    return ptr;
}

int insertSymbol(char*id, Type type, Value val, SymbolNode** hashTable) {
    int i = hash(id);
    SymbolNode*node = createSymbolNode(id, type, val);
   
    if(hashTable[i] == NULL) {
        hashTable[i] = node;
        return 1;
    }
    SymbolNode*ptr = hashTable[i];
    while(ptr->next != NULL) {
        if(strcmp(id, ptr->identifier) == 0) return 0;
        
        ptr = ptr->next;
    }

    if(strcmp(id, ptr->identifier) == 0) return 0;
    ptr->next = node;

    return 1;
}

int modifySymbol(char*id, Value val, SymbolNode** hashTable) {
    SymbolNode*node = findSymbol(id, hashTable);

    if(node == NULL) return 0;
    
    node->val = val;
    
    return 1;
}

DeclNode*createDeclNode(char*id, DeclNode*next) {
    DeclNode*temp = (DeclNode*)malloc(sizeof(DeclNode));
    temp->identifier = strdup(id);
    temp->next = next;

    return temp;
}

DeclNode*insertDeclList(DeclNode*decls, Type type, SymbolNode** hashTable) {
    while(decls != NULL) {
        if(!insertSymbol(decls->identifier, type, (Value)0, hashTable)) return decls;
        decls = decls->next;
    }

    return NULL;
}

SymbolNode* copySymbolList(SymbolNode* list){
    SymbolNode* newList;
    newList = createSymbolNode(list->identifier, list->type, list->val);
    SymbolNode* temp = newList;
    list = list->next;
    while(list!=NULL){
        temp->next = createSymbolNode(list->identifier, list->type, list->val);
        temp = temp->next;
        list = list->next;
    }

    temp->next = NULL;
    return newList;
}

SymbolNode** copySymbolTable(SymbolNode** hashTable){
    SymbolNode** newTable = initSymbolTable();
    int i = 0;
    for(i = 0; i < SIZE; i++){
        if(hashTable[i] != NULL){
            newTable[i] = copySymbolList(hashTable[i]);
        }
    }
    return newTable;
}

void printDashes(int n) {
    while(n--) {
        printf("-");
    }
    printf("\n");
}

void printSymbolTable(SymbolNode** hashTable) {
    int i;

    printf(CYAN"Symbol table\n");
    printDashes(25);
    for(i=0; i<SIZE; i++) {
        if(hashTable[i] == NULL) continue;

        SymbolNode*ptr = hashTable[i];
        while(ptr != NULL) {
            printf("|%10s |%10s |\n", ptr->identifier, ptr->type == integer? "integer": "real");
            printDashes(25);

            ptr = ptr->next;
        }
    }
    printf("\n"RESET);
}