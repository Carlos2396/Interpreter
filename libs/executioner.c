/* Carlos Augusto Amador Manilla A01329447 */
/* Angel Roberto Ruiz Mendoza A01324489 */

#include "definitions.h"
#include "symbolTable.h"
#include "syntaxTree.h"
#include "executioner.h"
#include "functionSymbolTable.h"

void handleError(int code, char*message) {
  fprintf(stderr, RED"Runtime error (%d): %s\n", code, message);
  exit(1);
}

int readInteger() {
  int i;
  printf("Enter an integer number value: ");
  int read = scanf(" %d", &i);

  if(!read) handleError(DATA_TYPE_MISMATCH_ERROR, DATA_TYPE_MISMATCH_ERROR_MESSAGE);

  return i;
}

float readReal() {
  float f;
  printf("Enter a real number value: ");
  int read = scanf(" %f", &f);

  if(!read) handleError(DATA_TYPE_MISMATCH_ERROR, DATA_TYPE_MISMATCH_ERROR_MESSAGE);

  return f;
}

void readFunction(TreeNode*readNode, SymbolNode** hashTable) {

  SymbolNode* symbol = findSymbol(readNode->left->identifier, globalTable);
  SymbolNode* symbol2 = hashTable == NULL? NULL : findSymbol(readNode->left->identifier, hashTable);
  symbol = symbol2 == NULL? symbol : symbol2;
  hashTable = hashTable == NULL? globalTable : hashTable;

  switch(symbol->type) {
    case integer:
      modifySymbol(symbol->identifier, (Value)readInteger(), hashTable);
      break;
    case real:
      modifySymbol(symbol->identifier, (Value)readReal(), hashTable);
      break;
  }
}

void printFunction(TreeNode*printNode, SymbolNode** hashTable) {
  switch(printNode->left->type){
    case integer: {
      int exprRes = evalExprInt(printNode->left, hashTable);
      printf("%d\n", exprRes);
      break;
    }
    case real: {
      float exprRes = evalExprFloat(printNode->left, hashTable);
      printf("%f\n", exprRes);
      break;
    }
    default:
      exit(1);
      break;
  }
}

int evalFactorInt(TreeNode* factorNode, SymbolNode** hashTable){
  switch(factorNode->instruction){
    case IPARENTHESIS:
      return evalExprInt(factorNode-> left, hashTable);
      break;
    case IIDENTIFIER:{
      SymbolNode* symbol = findSymbol(factorNode->identifier, globalTable);
      SymbolNode* symbol2 = hashTable == NULL? NULL : findSymbol(factorNode->identifier, hashTable);
      symbol = symbol2 == NULL? symbol : symbol2;
      return symbol->val.intV;
      break;
    }
    case IINTNUM:
      return factorNode->val.intV;
      break;
    case IREALNUM:
      #ifdef _PRINT_EXECUTION_TRACE
        printf("Something went wrong evalFactorInt had a real");
        exit(1);
      #endif
      break;
    case IFUNCTION:{ 
      execFunctionFunction(factorNode, hashTable);
      return returnValue.intV;
      break;
    }
    default:
      exit(1);
      break;
  }
}

int evalTermInt(TreeNode* termNode, SymbolNode** hashTable){
  switch(termNode->instruction){
    case IASTERISK: {
      int leftTerm = evalTermInt(termNode->left, hashTable);
      int rightFactor = evalFactorInt(termNode->right, hashTable);
      return leftTerm * rightFactor;
      break;
    }
    case ISLASH: {
      int leftTerm = evalTermInt(termNode->left, hashTable);
      int rightFactor = evalFactorInt(termNode->right, hashTable);
      return leftTerm / rightFactor;
      break;
    }
    default:
      return evalFactorInt(termNode, hashTable);
      break;
  }
}

int evalExprInt(TreeNode* exprNode, SymbolNode** hashTable){
  switch(exprNode->instruction){
    case IPLUS:{
      int leftExpr = evalExprInt(exprNode->left, hashTable);
      int rightTerm = evalTermInt(exprNode->right, hashTable);
      return leftExpr + rightTerm;
      break;
    }
    case IMINUS:{
      int leftExpr = evalExprInt(exprNode->left, hashTable);
      int rightTerm = evalTermInt(exprNode->right, hashTable);
      return leftExpr - rightTerm;
      break;
    }
    default:
      return evalTermInt(exprNode, hashTable);
      break;
  }
}

float evalFactorFloat(TreeNode* factorNode, SymbolNode** hashTable){
  SymbolNode*symbol;
  SymbolNode*symbol2;
  switch(factorNode->instruction){
    case IPARENTHESIS:
      return evalExprFloat(factorNode-> left, hashTable);
      break;
    case IIDENTIFIER:
      symbol = findSymbol(factorNode->identifier, globalTable);
      symbol2 = hashTable == NULL? NULL : findSymbol(factorNode->identifier, hashTable);
      symbol = symbol2 == NULL? symbol : symbol2;
      return symbol->val.realV;
      break;
    case IINTNUM:
    #ifdef _PRINT_EXECUTION_TRACE
      printf("Something went wrong evalFactorInt had a real");
      exit(1);
      #endif
      break;
    case IREALNUM:
      return factorNode->val.realV;
      break;
    case IFUNCTION:{
      execFunctionFunction(factorNode, hashTable);
      return returnValue.realV;
      break;
    }
    default:
      exit(1);
      break;
  }
}

float evalTermFloat(TreeNode* termNode, SymbolNode** hashTable){
  switch(termNode->instruction) {
    case IASTERISK:{
      float leftTerm = evalTermFloat(termNode->left, hashTable);
      float rightFactor = evalFactorFloat(termNode->right, hashTable);
      return leftTerm * rightFactor;
      break;
    }
    case ISLASH:{
      float leftTerm = evalTermFloat(termNode->left, hashTable);
      float rightFactor = evalFactorFloat(termNode->right, hashTable);
      return leftTerm / rightFactor;
      break;
    }
    default:
      return evalFactorFloat(termNode, hashTable);
      break;
  }
}

float evalExprFloat(TreeNode* exprNode, SymbolNode** hashTable){
  switch(exprNode->instruction){
    case IPLUS:{
      float leftExpr = evalExprFloat(exprNode->left, hashTable);
      float rightTerm = evalTermFloat(exprNode->right, hashTable);
      return leftExpr + rightTerm;
      break; 
    }
    case IMINUS:{
      float leftExpr = evalExprFloat(exprNode->left, hashTable);
      float rightTerm = evalTermFloat(exprNode->right, hashTable);
      return leftExpr - rightTerm;
      break;
    }
    default:
      return evalTermFloat(exprNode, hashTable);
      break;
  }
}

int evalExpression(TreeNode* expressionNode, SymbolNode** hashTable){
  if(expressionNode->type == integer){
    int leftExpr = evalExprInt(expressionNode->left, hashTable);
    int rightExpr = evalExprInt(expressionNode->right, hashTable);
    switch(expressionNode->instruction){
      case ISMALLER:
        return leftExpr < rightExpr? 1: 0;
        break;
      case IEQUAL:
        return leftExpr == rightExpr? 1: 0;
        break;
      case IBIGGER:
        return leftExpr > rightExpr? 1: 0;
        break;
      case IBIGGEROREQUAL:
        return leftExpr >= rightExpr? 1:0;
      case ISMALLEROREQUAL:
        return leftExpr <= rightExpr? 1:0;
      default:
        exit(1);
        break;
    }
  }
  else{
    float leftExpr = evalExprFloat(expressionNode->left, hashTable);
    float rightExpr = evalExprFloat(expressionNode->right, hashTable);
    switch(expressionNode->instruction){
      case ISMALLER:
        if(leftExpr < rightExpr)
          return 1;
        else
          return 0;
        break;
      case IEQUAL:
        if(leftExpr == rightExpr)
          return 1;
        else
          return 0;
        break;
      case IBIGGER:
        if(leftExpr > rightExpr)
          return 1;
        else
          return 0;
        break;
      default:
        exit(1);
        break;
    }
  }
}

void ifFunction(TreeNode* ifNode, SymbolNode** hashTable){
  int exrpessionRes = evalExpression(ifNode->left, hashTable);
  if(exrpessionRes){
    if(ifNode ->center == NULL)
      execTree(ifNode->right, hashTable);
    else
      execTree(ifNode->center, hashTable);
  }    
  else{
    if(ifNode->center != NULL)
      execTree(ifNode->right, hashTable);
  }
}

void thenFunction(TreeNode* thenNode, SymbolNode** hashTable){
  execTree(thenNode->left, hashTable);
}

void elseFunction(TreeNode* elseNode, SymbolNode** hashTable){
  if(elseNode != NULL){
    execTree(elseNode->left, hashTable);
  }
}

void whileFunction(TreeNode* whileNode, SymbolNode** hashTable){
  int exrpessionRes = evalExpression(whileNode->left, hashTable);
  if(exrpessionRes){
    whileNode->right->right = whileNode;
    execTree(whileNode->right, hashTable);
  }
}

void doFunction(TreeNode* doNode, SymbolNode** hashTable){
  //Do stmt
  execTree(doNode->left, hashTable);
  //Check while again
  execTree(doNode->right, hashTable);
}

void beginFunction(TreeNode* beginNode, SymbolNode** hashTable){
  execTree(beginNode->left, hashTable);
}

void assignFunction(TreeNode* assignNode, SymbolNode** hashTable){
  switch(assignNode->right->type){
    case integer:{
      int exprRes = evalExprInt(assignNode->right, hashTable);
      hashTable = hashTable == NULL? globalTable : hashTable;
      modifySymbol(assignNode->left->identifier, (Value)exprRes, hashTable);
      break;
    }
    case real:{
      float exprRes = evalExprFloat(assignNode->right, hashTable);
      hashTable = hashTable == NULL? globalTable : hashTable;
      modifySymbol(assignNode->left->identifier, (Value)exprRes, hashTable);
      break;
    }
    default:
      exit(1);
      break;
  }
}

void execFunctionFunction(TreeNode* functionNode, SymbolNode** hashTable){
  FunctionSymbolNode* functionS = findFunction(functionNode->identifier);
  SymbolNode** newFunctTable = copySymbolTable(functionS->hashTable);
  ArgNode* temp = functionNode->argList;
  ParamNode* params = functionS->paramsList;
  while(temp != NULL){
    if(temp->syntaxTree->type == integer){
      int evaluated = evalExprInt(temp->syntaxTree, hashTable);
      modifySymbol(params->identifier, (Value)evaluated, newFunctTable);
    }
    else{
      float evaluated = evalExprFloat(temp->syntaxTree, hashTable);
      modifySymbol(params->identifier, (Value)evaluated, newFunctTable);
    }
    temp = temp->next;
    params = params->next;
  }

  returnValue = (Value) -1;
  execTree(functionS->syntaxTree, newFunctTable);
  
}

void execTree(TreeNode*root, SymbolNode** hashTable) {
  if(root == NULL) return;

  switch(root->instruction) {
    case ISEMICOLON:
      execTree(root->left, hashTable);
      execTree(root->right, hashTable);
      break;

    case IBEGIN:
      beginFunction(root, hashTable);
      break;

    case IIF:
      ifFunction(root, hashTable);
      break;

    case ITHEN:
      thenFunction(root, hashTable);
      break;

    case IELSE:
      elseFunction(root, hashTable);
      break;

    case IWHILE:
      whileFunction(root, hashTable);
      break;

    case IDO:
      doFunction(root, hashTable);
      break;

    case IREAD:
      readFunction(root, hashTable);
      break;

    case IPRINT:
      printFunction(root, hashTable);
      break;

    case IASSIGNMENT:
      assignFunction(root, hashTable);
      break;
    case IRETURN: 
      if(root->left->type == integer){
        int x = evalExprInt(root->left, hashTable);
        returnValue = (Value)x;
      }
      else{
        float x = evalExprFloat(root->left, hashTable);
        returnValue = (Value)x;
      }
      break;
  }
}