/* Carlos Augusto Amador Manilla A01329447 */
/* Angel Roberto Ruiz Mendoza A01324489 */

#ifndef TREE
#define TREE

#include "definitions.h"

/*
 * Methods
*/
TreeNode*createTreeNode(Instruction ins, Type y, Value v, char*identifier, TreeNode* l, TreeNode* c, TreeNode* r); // creates a TreeNode struct
void postOrder(TreeNode* tRoot); // postorder of the syntax tree
void inOrder(TreeNode* tRoot); // inorder of the syntax tree
#endif