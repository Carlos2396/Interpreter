/* Carlos Augusto Amador Manilla A01329447 */
/* Angel Roberto Ruiz Mendoza A01324489 */

#ifndef EXEC
#define EXEC

#include "definitions.h"
/*
 * Methods
*/

void handleError(int code, char*message);//Method that prints errors and stops execution
void execFunctionFunction(TreeNode* functNode, SymbolNode** hashTable);//Method that gets the identifier of a function, finds it in the table, copies its symbol table and asigns the arguments to the parameters and starts the execution of this function
int evalExprInt(TreeNode* exprNode, SymbolNode** hashTable); //Funtion that gets the left exprand the right term and evaluates the expr, only for ints
int evalTermInt(TreeNode* termNode, SymbolNode** hashTable);//Function that gets the left term and the right factor and evaluates the ter, only for ints
int evalFactorInt(TreeNode* factorNode, SymbolNode** hashTable);//FUnction that returns the int value of the tree node, the symbol or the function to call
float evalExprFloat(TreeNode* exprNode, SymbolNode** hashTable); //Funtion that gets the left exprand the right term and evaluates the expr, only for floats
float evalTermFloat(TreeNode* termNode, SymbolNode** hashTable); //Function that gets the left term and the right factor and evaluates the ter, only for floats
float evalFactorFloat(TreeNode* factorNode, SymbolNode** hashTable); //FUnction that returns the real value of the tree node, the symbol or the function to call
int evalExpression(TreeNode* expressionNode, SymbolNode** hashTable); //Method that checks the type of the node, evaluates the left and the right expr and aplies the propper operation, returns 1 if true, 0 if false
void ifFunction(TreeNode* ifNode, SymbolNode** hashTable);//Method that evaluates the expresion in its left child and it it is true executes the then node, if not and there is an else node executes the else node
void thenFunction(TreeNode* thenNode, SymbolNode** hashTable);//Method that executes its left child
void elseFunction(TreeNode* elseNode, SymbolNode** hashTable);//Method that, if its not null, executes its left child
void whileFunction(TreeNode* whileNode, SymbolNode** hashTable);//Method that evaluates its left child (expresion) if true executes the do node
void doFunction(TreeNode* doNode, SymbolNode** hashTable); //Method that executes its left child and then executes its while node
void printFunction(TreeNode* printNode, SymbolNode** hashTable);//Method that evaluates its expr node and prints it
void assignFunction(TreeNode* assignNode, SymbolNode** hashTable);//Method that evaluates its right node and modifies the symbol node that corresponds to its left node with the result
void beginFunction(TreeNode* beginNode, SymbolNode** hashTable);//Method that executes its left child
void execTree(TreeNode* root, SymbolNode** hashTable); //Method that checks the node instruction and calls the corresponding method


#endif