/* Carlos Augusto Amador Manilla A01329447 */
/* Angel Roberto Ruiz Mendoza A01324489 */

#ifndef SYMBOL
#define SYMBOL

#include "definitions.h"

/**
 * Methods definitions 
*/
SymbolNode**initSymbolTable(); // reserves memory for the symbol table
SymbolNode*createSymbolNode(char*id, Type t, Value val); // creates a symbol table node
SymbolNode*findSymbol(char*id, SymbolNode** hashTable); // search id in symbol table, return NULL if not found
SymbolNode** copySymbolTable(SymbolNode** hashTable); //Creates a copy the given symbol table
int insertSymbol(char*id, Type type, Value val, SymbolNode** hashTable); // inserts the node in the symbol table if not already present
int modifySymbol(char*id, Value val, SymbolNode** hashTable); // updates symbol value
void printSymbolTable(SymbolNode** hashTable); // prints the symbol table

DeclNode*createDeclNode(char*id, DeclNode*next); // appends id to remaining list
DeclNode*insertDeclList(DeclNode*declList, Type type, SymbolNode** hashTable); // insert all ids in remaining list with the specified type
#endif