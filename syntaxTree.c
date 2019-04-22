/* Carlos Augusto Amador Manilla A01329447 */
/* Angel Roberto Ruiz Mendoza A01324489 */

#include "syntaxTree.h"

/*
 * Methods
*/
treeNode* createTreeNode(Instructions ins, Type t, Value v, Node* tblNode, treeNode* l, treeNode* c, treeNode* r){
    treeNode* newN = (treeNode*)malloc(sizeof(treeNode*));
    newN->instruction = ins;
    newN->type = t;
    newN->symbolTableNode = tblNode;
    newN->left = l;
    newN->right = r;
    newN->center = c;
    return newN;
}

