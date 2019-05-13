/* Carlos Augusto Amador Manilla A01329447 */
/* Angel Roberto Ruiz Mendoza A01324489 */

#ifndef SYMBOL
#define SYMBOL

#include "definitions.h"

/**
 * Methods definitions 
*/
SymbolNode**initSymbolTable(); // reserves memory for a symbol table and return a pointer to it
SymbolNode*createSymbolNode(char*id, Type t, Value val); // creates a SymbolNode struct

SymbolNode*findSymbol(char*identifier, SymbolNode** hashTable); // search identifier in symbol table, return NULL if not found
SymbolNode** copySymbolTable(SymbolNode** hashTable); //Creates a copy the given symbol table

int insertSymbol(char*id, Type type, Value val, SymbolNode** hashTable); // inserts the node in the symbol table if not already present
int modifySymbol(char*id, Value val, SymbolNode** hashTable); // updates symbol value
void printSymbolTable(SymbolNode** hashTable); // prints the symbol table

DeclNode*createDeclNode(char*id, DeclNode*next); // creates a DeclNode struct
DeclNode*insertDeclList(DeclNode*declList, Type type, SymbolNode** hashTable); // inserts the list of declared variables in the symbol table
ParamNode*insertParamList(ParamNode*paramsList, SymbolNode** hashTable); // insert a list of function parameters into the symbol table
#endif
