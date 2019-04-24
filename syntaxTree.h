/* Carlos Augusto Amador Manilla A01329447 */
/* Angel Roberto Ruiz Mendoza A01324489 */

#ifndef TREE
#define TREE

#include "definitions.h"

/**
 * Syntax tree root pointer
*/
TreeNode*root;

/*
 * Methods
*/
TreeNode*createTreeNode(Instruction ins, Type y, Value v, SymbolNode* tblNode, TreeNode* l, TreeNode* c, TreeNode* r);
void postOrder(TreeNode* tRoot);
void inOrder(TreeNode* tRoot);

#endif