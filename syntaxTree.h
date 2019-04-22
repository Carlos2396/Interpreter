/* Carlos Augusto Amador Manilla A01329447 */
/* Angel Roberto Ruiz Mendoza A01324489 */

#ifndef SYMBOL
#define SYMBOL

#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "symbolTable.h"
/**
 * structs and vals definitions
*/
#define RESET   "\x1b[0m"
#define RED     "\x1b[31m"
#define GREEN   "\x1b[32m"

/**
 * Types definitions
*/
typedef enum {integer, real, null} Type;
typedef enum {id, intnum, realnum, null} Instructions;
typedef union {
    int intV;
    float realV;
} Value;

typedef struct Node {
    Instructions instruction;
    Type type;
    Value val;  
    Node* symbolTableNode;
    treeNode* left;
    treeNode* center;
    treeNode* right;
} treeNode;


/**
 * Symbol table vars
*/
treeNode* root;

/*
 * Methods
*/
treeNode* createTreeNode(Instructions ins, Type y, Value v, Node* tblNode, treeNode* l, treeNode* c, treeNode* r);
void postOrder(treeNode* tRoot);
void inOrder(treeNode* tRoot);

#endif