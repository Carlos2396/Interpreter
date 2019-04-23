/* Carlos Augusto Amador Manilla A01329447 */
/* Angel Roberto Ruiz Mendoza A01324489 */

#ifndef SYMBOL
#define SYMBOL

#include <string.h>
#include <stdlib.h>
#include <stdio.h>

/**
 * structs and vals definitions
*/
#define SIZE 43991
#define RESET   "\x1b[0m"
#define RED     "\x1b[31m"
#define GREEN   "\x1b[32m"

/**
 * Types definitions
*/
typedef enum {integer, real, null} Type;

typedef union {
    int intV;
    float realV;
} Value;

typedef struct Node {
    char*identifier;
    Type type;
    Value val;  
    struct Node*next;
} Node;

typedef struct listNode {
    char*identifier;
    struct listNode*next;
} llNode;


/**
 * Symbol table vars
*/
Node**table;
llNode*remaining;

/**
 * Methods definitions 
*/
void initTable(); // reserves memory for the symbol table
int hash(char*c); // makes simple hash with the identifier string
Node*createNode(char*id, Type t, Value val); // creates a symbol table node
Node*findSymbol(char*id); // search id in symbol table, return NULL if not found
int insertSymbol(char*id, Type type, Value val); // inserts the node in the symbol table if not already present
int removeSymbol(char*id); // remeves symbol
int modifySymbol(char*id, Value val); // updates symbol value
void addRemaining(char*id); // appends id to remaining list
llNode*insertRemaining(Type type); // insert all ids in remaining list with the specified type
void printSymbolTable(); // prints the symbol table
void printDashes(int n);

#endif