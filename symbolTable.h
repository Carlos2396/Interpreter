/* Carlos Augusto Amador Manilla A01329447 */
/* Angel Roberto Ruiz Mendoza A01324489 */

#ifndef SYMBOL
#define SYMBOL

#include "definitions.h"

/**
 * Symbol table vars
*/
SymbolNode**table;
LLNode*remaining;

/**
 * Methods definitions 
*/
void initTable(); // reserves memory for the symbol table
int hash(char*c); // makes simple hash with the identifier string
SymbolNode*createNode(char*id, Type t, Value val); // creates a symbol table node
SymbolNode*findSymbol(char*id); // search id in symbol table, return NULL if not found
int insertSymbol(char*id, Type type, Value val); // inserts the node in the symbol table if not already present
int removeSymbol(char*id); // remeves symbol
int modifySymbol(char*id, Value val); // updates symbol value
void addRemaining(char*id); // appends id to remaining list
LLNode*insertRemaining(Type type); // insert all ids in remaining list with the specified type
void printSymbolTable(); // prints the symbol table
void printDashes(int n);

#endif