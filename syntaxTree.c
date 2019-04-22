/* Carlos Augusto Amador Manilla A01329447 */
/* Angel Roberto Ruiz Mendoza A01324489 */

#include "syntaxTree.h"

/*
 * Methods
*/
treeNode* createTreeNode(Instructions ins, Type t, Value v, Node* tblNode, treeNode* l, treeNode* c, treeNode* r){
    treeNode* newN = (treeNode*)malloc(sizeof(treeNode*));
    newN->instruction = ins;
    newN->val = v;
    newN->type = t;
    newN->symbolTableNode = tblNode;
    newN->left = l;
    newN->right = r;
    newN->center = c;
    return newN;
}

void postOrder(treeNode* tRoot){
    if(tRoot == NULL)
        return;
    postOrder(tRoot->left);
    postOrder(tRoot->center);
    postOrder(tRoot->right);
    char* inst;
    switch (tRoot->instruction)
    {
        case IPROGRAM:
            inst = "program";
            break;
        case IID:
            inst = tRoot->symbolTableNode->identifier;
            break;
        case IBEGIN:
            inst = "begin";
            break;
        case IEND:
            inst = "end";
            break;
        case ILET:
            inst = "let";
            break;
        case IINTEGER:
            inst = "integer";
            break;
        case IREAL:
            inst = "real";
            break;
        case IIF:
            inst = "if";
            break;
        case ITHEN:
            inst = "then";
            break;
        case IELSE:
            inst = "else";
            break;
        case IWHILE:
            inst = "while";
            break;
        case IDO:
            inst = "do";
            break;
        case IREAD:
            inst = "read";
            break;
        case IPRINT:
            inst = "print";
            break;
        case ISEMICOLON:
            inst = ";";
            break;
        case IPLUS:
            inst = "+";
            break;
        case IMINUS:
            inst = "-";
            break;
        case IASTERISK:
            inst = "*";
            break;
        case ISLASH:
            inst = "/";
            break;
        case IPARENTHESIS:
            inst = "(";
            break;
        case ICPARENTHESIS:
            inst = ")";
            break;
        case IINTNUM:
            sprintf(inst, "%d", tRoot->val->intV);
            break;
        case IREALNUM:
            sprintf(inst, "%f", tRoot->val->realV);
            break;
        case ISMALLER:
            inst = "<";
            break;
        case IBIGGER:
            inst = ">";
            break;
        case IEQUAL:
            inst = "=";
            break;
        default:
            break;
    }
}
