/* Carlos Augusto Amador Manilla A01329447 */
/* Angel Roberto Ruiz Mendoza A01324489 */

#ifndef EXEC
#define EXEC

#include "definitions.h"
/*
 * Methods
*/
void handleError(int code, char*message);

void execFunctionFunction(TreeNode* functNode, SymbolNode** hashTable);
int evalExprInt(TreeNode* exprNode, SymbolNode** hashTable);
int evalTermInt(TreeNode* termNode, SymbolNode** hashTable);
int evalFactorInt(TreeNode* factorNode, SymbolNode** hashTable);
float evalExprFloat(TreeNode* exprNode, SymbolNode** hashTable);
float evalTermFloat(TreeNode* termNode, SymbolNode** hashTable);
float evalFactorFloat(TreeNode* factorNode, SymbolNode** hashTable);
int evalExpression(TreeNode* expressionNode, SymbolNode** hashTable);
void ifFunction(TreeNode* ifNode, SymbolNode** hashTable);
void thenFunction(TreeNode* thenNode, SymbolNode** hashTable);
void elseFunction(TreeNode* elseNode, SymbolNode** hashTable);
void whileFunction(TreeNode* whileNode, SymbolNode** hashTable);
void doFunction(TreeNode* doNode, SymbolNode** hashTable);
void printFunction(TreeNode* printNode, SymbolNode** hashTable);
void assignFunction(TreeNode* assignNode, SymbolNode** hashTable);
void beginFunction(TreeNode* beginNode, SymbolNode** hashTable);
void execFunction(TreeNode* functNode, SymbolNode** hashTable);
void execTree(TreeNode* root, SymbolNode** hashTable);


#endif