/* Carlos Augusto Amador Manilla A01329447 */
/* Angel Roberto Ruiz Mendoza A01324489 */

#include "definitions.h"
#include "symbolTable.h"

/*
 * Methods
*/

//Methods that creates a new structure that has a hash table and the remaining to add symbols
HashTable* initTable() {
    HashTable* hashTable = (HashTable*)malloc(sizeof(HashTable));
    hashTable->table = (SymbolNode**)calloc(sizeof(SymbolNode*), SIZE);
    hashTable->remaining = NULL;
    return hashTable;
}

SymbolNode* createSymbolNode(char*id, Type t, Value val) {
    SymbolNode*temp = (SymbolNode*)malloc(sizeof(SymbolNode));
    temp->identifier = strdup(id);
    temp->type = t;
    temp->val = val;

    return temp;
}

SymbolNode*findSymbol(char*id, HashTable* hashTable) {
    int i = hash(id);

    if(hashTable->table[i] == NULL) return NULL;

    SymbolNode* ptr = hashTable->table[i];
    while(ptr != NULL && strcmp(id, ptr->identifier) != 0) {
        ptr = ptr->next;
    }

    return ptr;
}

int insertSymbol(char*id, Type type, Value val, HashTable* hashTable) {
    int i = hash(id);
    SymbolNode*node = createSymbolNode(id, type, val);
   
    if(hashTable->table[i] == NULL) {
        hashTable->table[i] = node;
        return 1;
    }
    SymbolNode*ptr = hashTable->table[i];
    while(ptr->next != NULL) {
        if(strcmp(id, ptr->identifier) == 0) return 0;
        
        ptr = ptr->next;
    }

    if(strcmp(id, ptr->identifier) == 0) return 0;
    ptr->next = node;

    return 1;
}

int removeSymbol(char*id, HashTable* hashTable) {
    int i = hash(id);
    SymbolNode*node = findSymbol(id, hashTable);

    if(id == NULL) return 0;

    if(hashTable->table[i] == node) {
        hashTable->table[i] = hashTable->table[i]->next;
        free(node);
    }
    else {
        SymbolNode*next = node->next;
        node->identifier = next->identifier;
        node->type = next->type;
        node->val = next->val;
        node->next = next->next;
        free(next);
    }

    return 1;
}

int modifySymbol(char*id, Value val, HashTable* hashTable) {
    SymbolNode*node = findSymbol(id, hashTable);

    if(node == NULL) return 0;
    
    node->val = val;
    
    return 1;
}

void addRemaining(char*id, HashTable* hashTable) {
    if(id == NULL) return;

    LLNode*temp = (LLNode*)malloc(sizeof(LLNode));
    temp->identifier = strdup(id);

    if(hashTable->remaining == NULL) {
        hashTable->remaining = temp;
        return;
    }

    LLNode*ptr = hashTable->remaining;
    while(ptr->next != NULL) {
        ptr = ptr->next;
    }

    ptr->next = temp;
}

LLNode*insertRemaining(Type type, HashTable* hashTable) {
    while(hashTable->remaining != NULL) {
        if(!insertSymbol(hashTable->remaining->identifier, type, (Value)0, hashTable)) 
            return hashTable->remaining;
        hashTable->remaining = hashTable->remaining->next;
    }

    return NULL;
}

void printDashes(int n) {
    while(n--) {
        printf("-");
    }
    printf("\n");
}

void printSymbolTable(HashTable* hashTable) {
    int i;

    printf(RESET"Symbol table\n");
    printDashes(25);
    for(i=0; i<SIZE; i++) {
        if(hashTable->table[i] == NULL) continue;

        SymbolNode*ptr = hashTable->table[i];
        while(ptr != NULL) {
            printf("|%10s |%10s |\n", ptr->identifier, ptr->type == integer? "integer": "real");
            printDashes(25);

            ptr = ptr->next;
        }
    }
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

HashTable* copySymbolTable(HashTable* hashTable){
    HashTable* newTable = initTable();
    int i = 0;
    for(i = 0; i < SIZE; i++){
        if(hashTable->table[i] != NULL){
            newTable->table[i] = copySymbolList(hashTable->table[i]);
        }
    }
}