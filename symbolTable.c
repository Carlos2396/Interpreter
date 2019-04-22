/* Carlos Augusto Amador Manilla A01329447 */

#include "symbolTable.h"

/*
 * Methods
*/

void initTable() {
    table = (Node**)calloc(sizeof(Node*),SIZE);
    remaining = NULL;
}

Node*createNode(char*id, Type t, Value val) {
    Node*temp = (Node*)malloc(sizeof(Node));
    temp->identifier = strdup(id);
    temp->type = t;
    temp->val = val;

    return temp;
}

int hash(char*c) {
    int sum = 0;
    while((*c) != '\0') {
        sum += *c;
        c++;
    }

    return sum%SIZE;
}

Node*findSymbol(char*id) {
    int i = hash(id);

    if(table[i] == NULL) return NULL;

    Node* ptr = table[i];
    while(ptr != NULL && strcmp(id, ptr->identifier) != 0) {
        ptr = ptr->next;
    }

    return ptr;
}

int insertSymbol(char*id, Type type, Value val) {
    int i = hash(id);
    Node*node = createNode(id, type, val);
   
    if(table[i] == NULL) {
        table[i] = node;
        return 1;
    }
    Node*ptr = table[i];
    while(ptr->next != NULL) {
        if(strcmp(id, ptr->identifier) == 0) return 0;
        
        ptr = ptr->next;
    }

    if(strcmp(id, ptr->identifier) == 0) return 0;
    ptr->next = node;

    return 1;
}

int removeSymbol(char*id) {
    int i = hash(id);
    Node*node = findSymbol(id);

    if(id == NULL) return 0;

    if(table[i] == node) {
        table[i] = table[i]->next;
        free(node);
    }
    else {
        Node*next = node->next;
        node->identifier = next->identifier;
        node->type = next->type;
        node->val = next->val;
        node->next = next->next;
        free(next);
    }

    return 1;
}

int modifySymbol(char*id, Value val) {
    Node*node = findSymbol(id);

    if(node == NULL) return 0;
    
    node->val = val;
    
    return 1;
}

void addRemaining(char*id) {
    llNode*temp = (llNode*)malloc(sizeof(llNode));
    temp->identifier = strdup(id);

    if(remaining == NULL) {
        remaining = temp;
        return;
    }

    
    llNode*ptr = remaining;
    while(ptr->next != NULL) {
        ptr = ptr->next;
    }

    ptr->next = temp;
}

llNode*insertRemaining(Type type) {
    while(remaining != NULL) {
        if(!insertSymbol(remaining->identifier, type, (Value)0)) return remaining;
        remaining = remaining->next;
    }

    return NULL;
}

void printDashes(int n) {
    while(n--) {
        printf("-");
    }
    printf("\n");
}

void printSymbolTable() {
    int i;

    printf(RESET"\nSymbol table\n");
    printDashes(25);
    for(i=0; i<SIZE; i++) {
        if(table[i] == NULL) continue;

        Node*ptr = table[i];
        while(ptr != NULL) {
            printf("|%10s |%10s |\n", ptr->identifier, ptr->type == integer? "integer": "real");
            printDashes(25);

            ptr = ptr->next;
        }
    }
}