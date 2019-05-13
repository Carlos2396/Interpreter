/* Carlos Augusto Amador Manilla A01329447 */
/* Angel Roberto Ruiz Mendoza A01324489 */

#include "definitions.h"
#include "syntaxTree.h"

/*
 * Methods
*/
TreeNode*createTreeNode(Instruction ins, Type t, Value v, char*identifier, TreeNode* l, TreeNode* c, TreeNode* r) {
    TreeNode* newN = (TreeNode*)malloc(sizeof(TreeNode));
    newN->instruction = ins;
    newN->val = v;
    newN->type = t;
    newN->identifier = identifier;
    newN->argList = NULL;
    newN->left = l;
    newN->right = r;
    newN->center = c;
    return newN;
}

char*getInstructionText(TreeNode*tRoot) {
    char* text = (char*)malloc(sizeof(char)*1000);
    switch(tRoot->instruction) {
        case IPROGRAM:
            text = "program";
            break;
        case IIDENTIFIER:
            text = tRoot->identifier;
            break;
        case IBEGIN:
            text = "begin";
            break;
        case IEND:
            text = "end";
            break;
        case ILET:
            text = "let";
            break;
        case IINTEGER:
            text = "integer";
            break;
        case IREAL:
            text = "real";
            break;
        case IIF:
            text = "if";
            break;
        case ITHEN:
            text = "then";
            break;
        case IELSE:
            text = "else";
            break;
        case IWHILE:
            text = "while";
            break;
        case IDO:
            text = "do";
            break;
        case IREAD:
            text = "read";
            break;
        case IPRINT:
            text = "print";
            break;
        case ISEMICOLON:
            text = ";";
            break;
        case IPLUS:
            text = "+";
            break;
        case IMINUS:
            text = "-";
            break;
        case IASTERISK:
            text = "*";
            break;
        case ISLASH:
            text = "/";
            break;
        case IPARENTHESIS:
            text = "(";
            break;
        case ICPARENTHESIS:
            text = ")";
            break;
        case IINTNUM:
            sprintf(text, "%d", tRoot->val.intV);
            break;
        case IREALNUM:
            sprintf(text, "%f", tRoot->val.realV);
            break;
        case ISMALLER:
            text = "<";
            break;
        case IBIGGER:
            text = ">";
            break;
        case IEQUAL:
            text = "=";
            break;
        case ISMALLEROREQUAL:
            text = "<=";
            break;
        case IBIGGEROREQUAL:
            text = ">=";
            break;
        case IASSIGNMENT:
            text = "Assignment";
            break;
        case IRETURN:
            text = "return";
            break;
        default:
            break;
    }

    return text;
}

void postOrder(TreeNode* tRoot){
    if(tRoot == NULL) return;

    postOrder(tRoot->left);
    postOrder(tRoot->center);
    postOrder(tRoot->right);

    char*text = getInstructionText(tRoot);

    printf("%s\n", text);
}

void inOrder(TreeNode* tRoot){
    if(tRoot == NULL) return;

    postOrder(tRoot->left);

    char*text = getInstructionText(tRoot);
    printf("%s\n", text);
    
    postOrder(tRoot->center);
    postOrder(tRoot->right);
}
