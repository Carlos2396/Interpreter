/* Carlos Augusto Amador Manilla A01329447 */
/* Angel Roberto Ruiz Mendoza A01324489 */

#ifndef SYMBOL
#define SYMBOL

#include "definitions.h"

/**
 * Symbol table vars
*/
//SymbolNode**table;
//LLNode*remaining;

/**
 * Methods definitions 
*/
HashTable* initTable(); // reserves memory for the symbol table
int hash(char*c); // makes simple hash with the identifier string
SymbolNode*createNode(char*id, Type t, Value val, HashTable* hashTable); // creates a symbol table node
SymbolNode*findSymbol(char*id, HashTable* hashTable); // search id in symbol table, return NULL if not found
int insertSymbol(char*id, Type type, Value val, HashTable* hashTable); // inserts the node in the symbol table if not already present
int removeSymbol(char*id, HashTable* hashTable); // remeves symbol
int modifySymbol(char*id, Value val, HashTable* hashTable); // updates symbol value
void addRemaining(char*id, HashTable* hashTable); // appends id to remaining list
LLNode*insertRemaining(Type type, HashTable* hashTable); // insert all ids in remaining list with the specified type
void printSymbolTable(HashTable* hashTable); // prints the symbol table
void printDashes(int n);
HashTable* copySymbolTable(HashTable* hashTable); //Creates a copy the given symbol table

#endif