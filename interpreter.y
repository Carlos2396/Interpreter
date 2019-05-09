/* Carlos Augusto Amador Manilla A01329447 */
/* Angel Roberto Ruiz Mendoza A01324489 */

%{
  #include "definitions.h"
  #include "symbolTable.h"
  #include "syntaxTree.h"
  #include "functionSymbolTable"

  char*error; // to store error messages
  LLNode*rem; // to check for errors in insertion to the symbol table

  HashTable*global;
  HashTable*currentTable;

  extern int lines; // line counter
  extern FILE* yyin; // input file
  int counter = 0;
%}

%token <stringVal> IDENTIFIER
%token <type> INT
%token <type> REAL
%token <intVal> INTV
%token <floatVal> FLOATV
%type <type> type
%type <nodePointer> stmt expr expression term factor stmt_lst opt_stmts fun_decls
%type <argNode> opt_args arg_lst
%type <paramNode> opt_params param_lst param
%token 
    BEGINS END IF ELSE WHILE DO FOR FOREACH THEN PRINT READ FUN
    VAR LET BOOLEAN FLOAT PROCEDURE PROGRAM
    PLUS MINUS SLASH ASTERISK BIGGER BIGGEROREQUAL SMALLER SMALLEROREQUAL EQUAL ASSIGNMENT
    DOT COMMA COLON SEMICOLON PARENTHESIS CPARENTHESIS BRACKET CBRACKET

%start prog

// possible values
%union {
  int intVal;
  float floatVal;
  char*stringVal;
  int type;
  TreeNode*nodePointer;
  ArgNode*argNode;
  ParamNode*paramNode;
}

%%
prog: PROGRAM IDENTIFIER opt_decls opt_fun_decls BEGINS opt_stmts END {
  #ifdef _PRINT_STACK_TRACE
  printf("Program: %d\n", ++counter);
  #endif

  TreeNode*endNode = createTreeNode(IEND, null, (Value)0, NULL, NULL, NULL, NULL); 
  root = createTreeNode(IBEGIN, null, (Value)0, NULL, $6, NULL, endNode);

  YYACCEPT; 
};

opt_decls: 
  decl_lst {
    #ifdef _PRINT_STACK_TRACE
    printf("opt_decls -> decl_lst: %d\n", ++counter);
    #endif
  } | {
    #ifdef _PRINT_STACK_TRACE
    printf("opt_decls -> NOTHING: %d\n", ++counter);
    #endif
  }
;

decl_lst: 
  decl SEMICOLON decl_lst {
    #ifdef _PRINT_STACK_TRACE
    printf("decl_lst -> decl ; decl_lst: %d\n", ++counter);
    #endif
  } | 
  decl {
    #ifdef _PRINT_STACK_TRACE
    printf("decl_lst -> decl: %d\n", ++counter);
    #endif
  }
;

decl: 
  LET id_lst COLON type {
    #ifdef _PRINT_STACK_TRACE
    printf("decl -> id_lst : type: %d\n", ++counter);
    #endif
  }
;

id_lst: 
  IDENTIFIER COMMA id_lst { 
    #ifdef _PRINT_STACK_TRACE
    printf("id_lst -> Identifier , id_lst: %d\n", ++counter);
    #endif

    addRemaining($1, currentTable); 
  } |
  IDENTIFIER { 
    #ifdef _PRINT_STACK_TRACE
    printf("id_lst -> Identifier: %d\n", ++counter);
    #endif

    addRemaining($1, currentTable); 
  }
;

type: 
  INT { 
    #ifdef _PRINT_STACK_TRACE
    printf("type -> Int: %d\n", ++counter);
    #endif

    if((rem = insertRemaining($1, currentTable)) != NULL) {sprintf(error, "Symbol %s already declared", rem->identifier); yyerror(error); return 1;} 
  } | 
  REAL { 
    #ifdef _PRINT_STACK_TRACE
    printf("type -> Real: %d\n", ++counter);
    #endif

    if((rem = insertRemaining($1, currentTable)) != NULL) {sprintf(error, "Symbol %s already declared", rem->identifier); yyerror(error); return 1;} 
  }
;

opt_fun_decls:
  fun_decls {
    #ifdef _PRINT_STACK_TRACE
    printf("opt_decls -> fun_decls : %d\n", ++counter);
    #endif
  } | {
    #ifdef _PRINT_STACK_TRACE
    printf("opt_decls -> nothing : %d\n", ++counter);
    #endif
  }
;

fun_decls:
  fun_decl COMMA fun_decls {
    #ifdef _PRINT_STACK_TRACE
    printf("fun_decls -> fun_decl , fun_decls : %d\n", ++counter);
    #endif

    currentTable = initTable();
  } | 
  fun_decl {
    #ifdef _PRINT_STACK_TRACE
    printf("fun_decls -> fun_decl : %d\n", ++counter);
    #endif

    currentTable = initTable();
  }
;

fun_decl:
  FUN IDENTIFIER PARENTHESIS opt_params CPARENTHESIS COLON type opt_decls BEGINS opt_stmts END {
    #ifdef _PRINT_STACK_TRACE
    printf("fun_decl -> fun id (opt_params) : type opt_decls begin opt_stmts end\n", ++counter);
    #endif

    FunctionSymbolNode*function = findFunction($2);
    if(function != NULL) {sprintf(error, "Function %s already declared", $2); yyerror(error); return 1; }

    TreeNode*endNode = createTreeNode(IEND, null, (Value)0, NULL, NULL, NULL, NULL);
    TreeNode*syntaxTree = createTreeNode(IBEGIN, null, (Value)0, NULL, $10, NULL, endNode);
    ṔaramNode*paramList = $4;

    function = createFunctionNode($2, $7, currentTable, syntaxTree, paramList);
    
    if(!addParamToFunctionSymbolTable(function)) {sprintf(error, "Parameters and variables of functions cannot haver the same identifier."); yyerror(error); return 1;}
  
    insertFunction(function);

    currentTable = global;
  }
;

opt_params:
  param_lst {
    #ifdef _PRINT_STACK_TRACE
    printf("param_lst -> param_lst\n", ++counter);
    #endif

    $$ = $1;
  } | {
    #ifdef _PRINT_STACK_TRACE
    printf("opt_params -> Nothing\n", ++counter);
    #endif

    $$ = NULL;
  }
;

param_lst: 
  param COMMA param_lst {
    #ifdef _PRINT_STACK_TRACE
    printf("param_lst -> param , param_lst\n", ++counter);
    #endif

    ParamNode*paramNode = $1;
    paramNode->next = $3;
    $$ = paramNode;
  } | 
  param {
    #ifdef _PRINT_STACK_TRACE
    printf("param_lst -> param\n", ++counter);
    #endif

    $$ = $1;
  }
;

param: 
  IDENTIFIER COLON type {
    #ifdef _PRINT_STACK_TRACE
    printf("param -> deintifier: type\n", ++counter);
    #endif

    $$ = createParamNode($1, $3, NULL);
  }
;

stmt: 
  IDENTIFIER ASSIGNMENT expr {
    #ifdef _PRINT_STACK_TRACE
    printf("stmt -> Assignment: %d\n", ++counter);
    #endif

    SymbolNode*symbol = findSymbol($1);
    if(symbol == NULL) { sprintf(error, "Symbol %s not found", $1); yyerror(error); return 1; } 
    
    if(symbol->type != $3->type) {
      sprintf(error, "Type mismatch, type %d is not type %d", symbol->type, $3->type); 
      yyerror(error); 
      return 1;
    }
    
    TreeNode*idNode = createTreeNode(IIDENTIFIER, null, (Value)0, symbol->identifier, NULL, NULL, NULL);
    $$ = createTreeNode(IASSIGNMENT, null, (Value)0, NULL, idNode, NULL, $3); 
  } |
  IF expression THEN stmt {
    #ifdef _PRINT_STACK_TRACE
    printf("stmt -> If Then: %d\n", ++counter);
    #endif

    TreeNode*thenNode = createTreeNode(ITHEN, null, (Value)0, NULL, $4, NULL, NULL);
    $$ = createTreeNode(IIF, null, (Value)0, NULL, $2, NULL, thenNode); 
  } |
  IF expression THEN stmt ELSE stmt {
    #ifdef _PRINT_STACK_TRACE
    printf("stmt -> If Then Else: %d\n", ++counter);
    #endif

    TreeNode*thenNode = createTreeNode(ITHEN, null, (Value)0, NULL, $4, NULL, NULL);
    TreeNode*elseNode = createTreeNode(IELSE, null, (Value)0, NULL, $6, NULL, NULL); 
    $$ = createTreeNode(IIF, null, (Value)0, NULL, $2, thenNode, elseNode);
  } |
  WHILE expression DO stmt {
    #ifdef _PRINT_STACK_TRACE
    printf("stmt -> While Do: %d\n", ++counter);
    #endif

    TreeNode* doNode = createTreeNode(IDO, null, (Value)0, NULL, $4, NULL, NULL);
    $$ = createTreeNode(IWHILE, null, (Value)0, NULL, $2, NULL, doNode);
  } |
  READ IDENTIFIER { 
    #ifdef _PRINT_STACK_TRACE
    printf("stmt -> Read: %d\n", ++counter);
    #endif

    SymbolNode*symbol = findSymbol($2);
    if(symbol == NULL) { sprintf(error, "Symbol %s not found", $2); yyerror(error); return 1; }
    
    TreeNode*idNode = createTreeNode(IIDENTIFIER, symbol->type, (Value)0, symbol->identifier, NULL, NULL, NULL);
    $$ = createTreeNode(IREAD, null, (Value)0, NULL, idNode, NULL, NULL);
  } |
  PRINT expr {
    #ifdef _PRINT_STACK_TRACE
    printf("stmt -> Print: %d\n", ++counter);
    #endif

    $$ = createTreeNode(IPRINT, null, (Value)0, NULL, $2, NULL, NULL);
  } |
  BEGINS opt_stmts END {
    #ifdef _PRINT_STACK_TRACE
    printf("stmt -> Begin End: %d\n", ++counter);
    #endif

    TreeNode*endNode = createTreeNode(IEND, null, (Value)0, NULL, NULL, NULL, NULL);
    $$ = createTreeNode(IBEGIN, null, (Value)0, NULL, $2, NULL, endNode);
  }
;

opt_stmts: 
  stmt_lst { 
    #ifdef _PRINT_STACK_TRACE
    printf("opt_stmts -> stmt_lst: %d\n", ++counter);
    #endif

    $$ = $1; 
  }
  | { 
    #ifdef _PRINT_STACK_TRACE
    printf("opt_stmts -> NOTHING: %d\n", ++counter);
    #endif

    $$ = NULL; 
  } 
;

stmt_lst: 
  stmt SEMICOLON stmt_lst { 
    #ifdef _PRINT_STACK_TRACE
    printf("stmt_lst -> stmt ; stmt_lst: %d\n", ++counter);
    #endif

    $$ = createTreeNode(ISEMICOLON, null, (Value)0, NULL, $1, NULL, $3); 
  } | 
  stmt {
    #ifdef _PRINT_STACK_TRACE
    printf("stmt_lst -> stmt: %d\n", ++counter);
    #endif 

    $$ = $1; 
  }
;

expr:   
  expr PLUS term {
    #ifdef _PRINT_STACK_TRACE
    printf("expr -> Plus: %d\n", ++counter);
    #endif

    if($1->type != $3->type){
      sprintf(error, "Type mismatch, type %d is not type %d", $1->type, $3->type); 
      yyerror(error); 
      return 1;
    }

    $$ = createTreeNode(IPLUS, $1->type, (Value)0, NULL, $1, NULL, $3);
  } |
  expr MINUS term {
    #ifdef _PRINT_STACK_TRACE
    printf("expr -> Minus: %d\n", ++counter);
    #endif

    if($1->type != $3->type){
      sprintf(error, "Type mismatch, type %d is not type %d", $1->type, $3->type); 
      yyerror(error); 
      return 1;
    }

    $$ = createTreeNode(IMINUS, $1->type, (Value)0, NULL, $1, NULL, $3);
  } |
  term {
    #ifdef _PRINT_STACK_TRACE
    printf("expr -> term: %d\n", ++counter);
    #endif

    $$ =  $1;
  }
;

term: 
  term ASTERISK factor {
    #ifdef _PRINT_STACK_TRACE
    printf("term -> Asterisk: %d\n", ++counter);
    #endif

    if($1->type != $3->type){
      sprintf(error, "Type mismatch, type %d is not type %d", $1->type, $3->type); 
      yyerror(error); 
      return 1;
    }

    $$ = createTreeNode(IASTERISK, $1->type, (Value)0, NULL, $1, NULL, $3);
  } |
  term SLASH factor {
    #ifdef _PRINT_STACK_TRACE
    printf("term -> Slash: %d\n", ++counter);
    #endif

    if($1->type != $3->type){
      sprintf(error, "Type mismatch, type %d is not type %d", $1->type, $3->type); 
      yyerror(error); 
      return 1;
    }

    $$ = createTreeNode(ISLASH, $1->type, (Value)0, NULL, $1, NULL, $3);
  } |
  factor {
    #ifdef _PRINT_STACK_TRACE
    printf("term -> factor: %d\n", ++counter);
    #endif

    $$ = $1;
  }
;

factor: 
  PARENTHESIS expr CPARENTHESIS {
    #ifdef _PRINT_STACK_TRACE
    printf("factor -> Parenthesis: %d\n", ++counter);
    #endif

    TreeNode* parNode = createTreeNode(ICPARENTHESIS, $2->type, (Value)0, NULL, NULL, NULL, NULL);
    $$ = createTreeNode(IPARENTHESIS, $2->type, (Value)0, NULL, $2, NULL, parNode);
  } |
  IDENTIFIER {
    #ifdef _PRINT_STACK_TRACE
    printf("factor -> Identifier: %d\n", ++counter);
    #endif

    SymbolNode* symbol = findSymbol($1);
    if(symbol == NULL) {
        sprintf(error, "Symbol %s not found", $1); 
        yyerror(error); 
        return 1; 
    }
    Type symType = symbol-> type;
    $$ =  createTreeNode(IIDENTIFIER, symType, (Value)0, symbol->identifier, NULL, NULL, NULL);
  } |
  INTV {
    #ifdef _PRINT_STACK_TRACE
    printf("factor -> IntV -> %d: %d\n", $1, ++counter);
    #endif

    $$ = createTreeNode(IINTNUM, integer, (Value)$1, NULL, NULL, NULL, NULL);
  } |
  FLOATV {
    #ifdef _PRINT_STACK_TRACE
    printf("factor -> FloatV -> %f: %d\n", $1, ++counter);
    #endif

    $$ = createTreeNode(IREALNUM, real, (Value)$1, NULL, NULL, NULL, NULL);
  } |
  IDENTIFIER PARENTHESIS opt_args CPARENTHESIS {
    #ifdef _PRINT_STACK_TRACE
    printf("factor -> id(opt_args)\n", ++counter);
    #endif

    FunctionSymbolNode*function = findFunction($1);
    if(function != NULL) {sprintf(error, "Function %s is not declared.", $1); yyerror(error); return 1; }

    ArgNode*args = $3;
    ArgNode*arg = arg;
    ParamNode param = function->paramList;

    // Check that the number and type of arguments matches the parameters required
    int count = 1;
    while(param != NULL) {
      if(arg == NULL) {sprintf(error, "Invalid call to %s. Missing arguments.", function->id); yyerror(error); return 1; }
      if(param->type != arg->type) {sprintf(error, "Invalid call to %s. Type mismatch in argument %d.", function->id, count); yyerror(error); return 1; }
    
      param = param->next;
      arg = arg->next;
      count++;
    }
    if(arg != NULL) {sprintf(error, "Invalid call to %s. More arguments than required given.", function->id); yyerror(error); return 1; }

    TreeNode*functionNode = createTreeNode(IFUNCTION, function->type, (Value)0, function->identifier, NULL, NULL, NULL);
    functioNode->argList = args;
    $$ = functionNode;
  }
;

expression: 
  expr SMALLER expr {
    #ifdef _PRINT_STACK_TRACE
    printf("expression -> Smaller: %d\n", ++counter);
    #endif

    if($1->type != $3->type){
      sprintf(error, "Type mismatch, type %d is not type %d", $1->type, $3->type); 
      yyerror(error); 
      return 1;
    }

    $$ = createTreeNode(ISMALLER, $1->type, (Value)0, NULL, $1, NULL, $3);
  } |
  expr BIGGER expr {
    #ifdef _PRINT_STACK_TRACE
    printf("expression -> Bigger: %d\n", ++counter);
    #endif

    if($1->type != $3->type){
      sprintf(error, "Type mismatch, type %d is not type %d", $1->type, $3->type); 
      yyerror(error); 
      return 1;
    }

    $$ = createTreeNode(IBIGGER, $1->type, (Value)0, NULL, $1, NULL, $3);
  } |
  expr EQUAL expr {
    #ifdef _PRINT_STACK_TRACE
    printf("expression -> Equal: %d\n", ++counter);
    #endif

    if($1->type != $3->type){
      sprintf(error, "Type mismatch, type %d is not type %d", $1->type, $3->type); 
      yyerror(error); 
      return 1;
    }

    $$ = createTreeNode(IEQUAL,$1->type, (Value)0, NULL, $1, NULL, $3);
  } |
  expr SMALLEROREQUAL expr {
    #ifdef _PRINT_STACK_TRACE
    printf("expression -> Smaller or equal: %d\n", ++counter);
    #endif

    if($1->type != $3->type){
      sprintf(error, "Type mismatch, type %d is not type %d", $1->type, $3->type); 
      yyerror(error); 
      return 1;
    }

    $$ = createTreeNode(ISMALLEROREQUAL,$1->type, (Value)0, NULL, $1, NULL, $3);
  } | 
  expr BIGGEROREQUAL expr {
    #ifdef _PRINT_STACK_TRACE
    printf("expression -> Bigger or equal: %d\n", ++counter);
    #endif

    if($1->type != $3->type){
      sprintf(error, "Type mismatch, type %d is not type %d", $1->type, $3->type); 
      yyerror(error);
      return 1;
    }

    $$ = createTreeNode(IBIGGEROREQUAL,$1->type, (Value)0, NULL, $1, NULL, $3);
  }
;

opt_args: 
  arg_lst {
    $$ = $1;
  } |
   {
     return NULL;
   } 
;

arg_lst:
  expr COMMA arg_lst {
    $$ = createArgNode($1, $3);
  } | 
  expr {
    $$ = createArgNode($1, NULL);
  }
;

%%

void handleError(int code, char*message) {
  fprintf(stderr, RED"Runtime error (%d): %s\n", code, message);
  exit(1);
}

int evalExprInt(TreeNode* exprNode, HashTable* hashTable);
int evalTermInt(TreeNode* termNode, HashTable* hashTable);
int evalFactorInt(TreeNode* factorNode, HashTable* hashTable);
float evalExprFloat(TreeNode* exprNode, HashTable* hashTable);
float evalTermFloat(TreeNode* termNode, HashTable* hashTable);
float evalFactorFloat(TreeNode* factorNode, HashTable* hashTable);
int evalExpression(TreeNode* expressionNode, HashTable* hashTable);
void ifFunction(TreeNode* ifNode, HashTable* hashTable);
void thenFunction(TreeNode* thenNode, HashTable* hashTable);
void elseFunction(TreeNode* elseNode, HashTable* hashTable);
void whileFunction(TreeNode* whileNode, HashTable* hashTable);
void doFunction(TreeNode* doNode, HashTable* hashTable);
void printFunction(TreeNode* printNode, HashTable* hashTable);
void assignFunction(TreeNode* assignNode, HashTable* hashTable);
void beginFunction(TreeNode* beginNode, HashTable* hashTable);
void execFunctionFunction(TreeNode* functNode, HashTable* hashTable);
void execTree(TreeNode* root, HashTable* hashTable);

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

void readFunction(TreeNode*readNode, HashTable* hashTable) {

  symbolTableNode* symbol = findSymbol(readNode->left->identifier, globalTable);
  symbolTableNode* symbol2 = hashTable == NULL? NULL : findSymbol(readNode->left->identifier, hashTable);
  symbol = symbol2 == NULL? symbol : symbol2;
  hashTable = hashTable == NULL? globalTable : hashTable;

  switch(readNode->left->symbolTableNode->type) {
    case integer:
      modifySymbol(symbol->identifier, (Value)readInteger(), hashTable);
      break;
    case real:
      modifySymbol(symbol->identifier, (Value)readReal(), hashTable);
      break;
  }
}

void printFunction(TreeNode*printNode, HashTable* hashTable) {
  switch(printNode->left->type){
    case integer: {
      int exprRes = evalExprInt(printNode->left, HashTable* hashTable);
      printf("%d\n", exprRes);
      break;
    }
    case real: {
      float exprRes = evalExprFloat(printNode->left, HashTable* hashTable);
      printf("%f\n", exprRes);
      break;
    }
    default:
      #ifdef _PRINT_EXECUTION_TRACE
      printf("Something went wrong print function\n");
      exit(1);
      #endif
      break;
  }
}

int evalFactorInt(TreeNode* factorNode, HashTable* hashTable){
  switch(factorNode->instruction){
    case IPARENTHESIS:
      return evalExprInt(factorNode-> left, hashTable);
      break;
    case IIDENTIFIER:{
      symbolTableNode* symbol = findSymbol(factorNode->identifier, globalTable);
      symbolTableNode* symbol2 = hashTable == NULL? NULL : findSymbol(factorNode->identifier, hashTable);
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
    default:
      #ifdef _PRINT_EXECUTION_TRACE
      printf("Something went wrong evalFactorInt default");
      exit(1);
      #endif
      break;
  }
}

int evalTermInt(TreeNode* termNode, HashTable* hashTable){
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

int evalExprInt(TreeNode* exprNode, HashTable* hashTable){
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

float evalFactorFloat(TreeNode* factorNode, HashTable* hashTable){
  switch(factorNode->instruction){
    case IPARENTHESIS:
      return evalExprFloat(factorNode-> left, hashTable);
      break;
    case IIDENTIFIER:
      symbolTableNode* symbol = findSymbol(factorNode->identifier, globalTable);
      symbolTableNode* symbol2 = hashTable == NULL? NULL : findSymbol(factorNode->identifier, hashTable);
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
    default:
      #ifdef _PRINT_EXECUTION_TRACE
      printf("Something went wrong evalFactorInt default");
      exit(1);
      #endif
      break;
  }
}

float evalTermFloat(TreeNode* termNode, HashTable* hashTable){
  switch(termNode->instruction){
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

float evalExprFloat(TreeNode* exprNode, HashTable* hashTable){
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

int evalExpression(TreeNode* expressionNode, HashTable* hashTable){
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
        #ifdef _PRINT_EXECUTION_TRACE
        printf("Something went wrong eval expression");
        exit(1);
        #endif
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
        #ifdef _PRINT_EXECUTION_TRACE
        printf("Something went wrong eval expression");
        exit(1);
        #endif
        break;
    }
  }
}

void ifFunction(TreeNode* ifNode, HashTable* hashTable){
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

void thenFunction(TreeNode* thenNode, HashTable* hashTable){
  execTree(thenNode->left, hashTable);
}

void elseFunction(TreeNode* elseNode, HashTable* hashTable){
  if(elseNode != NULL){
    execTree(elseNode->left, hashTable);
  }
}

void whileFunction(TreeNode* whileNode, HashTable* hashTable){
  int exrpessionRes = evalExpression(whileNode->left, hashTable);
  if(exrpessionRes){
    whileNode->right->right = whileNode;
    execTree(whileNode->right, hashTable);
  }
}

void doFunction(TreeNode* doNode, HashTable* hashTable){
  //Do stmt
  execTree(doNode->left, hashTable);
  //Check while again
  execTree(doNode->right, hashTable);
}

void beginFunction(TreeNode* beginNode, HashTable* hashTable){
  execTree(beginNode->left, hashTable);
}

void assignFunction(TreeNode* assignNode, HashTable* hashTable){
  switch(assignNode->right->type){
    case integer:{
      int exprRes = evalExprInt(assignNode->right, hashTable);
      hashTable = hashTable == NULL? globalTable : hashTable;
      modifySymbol(assignNode->left->identifier, (Value)exprRes, hashTable);
      break;
    }
    case real:{
      float exprRes = evalExprFloat(assignNode->right);
      hashTable = hashTable == NULL? globalTable : hashTable;
      modifySymbol(assignNode->left->identifier, (Value)exprRes, hashTable);
      break;
    }
    default:
      #ifdef _PRINT_EXECUTION_TRACE
      printf("Something went wrong assign function");
      exit(1);
      #endif
      break;
  }
}

void execFunctionFunction(TreeNode* functionNode, HashTable* hashTable){
  FuncyionSymbolNode* functionS = findFunction(functNode->identifier);
  HashTable* newFunctTable = compySymbolTable(functionS->hashTable);
  ArgNode* temp = functionNode->argList;
  ParamNode* params = functionS.paramsList;
  while(temp != null){
    if(temp->syntaxTree->type == integer){
      int evaluated = evalExprInt(temp->syntaxTree, hashTable);
      modifySymbol(params->identifier, evaluated, newFunctTable);
    }
    else{
      float evaluated = evalExprFloat(temp->syntaxTree, hashTable);
      modifySymbol(params->identifier, evaluated, newFunctTable);
    }
    temp = temp->next;
    params = params->next;
  }
  exec(functionS->syntaxTree, newFunctTable);
}

void execTree(TreeNode*root, HashTable* hashTable) {
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
      doFunction(root), hashTable;
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
    case IFUNCTION:
      execFunctionFunction(root, hashTable);
      break;
  }
}

int yyerror(char const * s) {
  lines++;
  fprintf(stderr, RED"%s in line %d\n", s, lines);
  return 0;
}

int main(int argc, char **argv) {
  if(argc != 2) {
        fprintf(stderr, RED"The name of the file to analize must be a parameter.\n");
        return 1;
    }

    char* filename = argv[1];
    yyin = fopen(filename, "r");
    
    if(yyin == NULL) {
        fprintf(stderr, RED"Failed to open the specified file.\n");
        return 1;
    }

    error = (char*)malloc(sizeof(char)*1000);
    global = initTable();
    currentTable = global;
    int res = yyparse();
  
    if(!res) {
      printf(GREEN"Accepted.\n\n");

      printf(RESET"Execution output:\n");
      execTree(root, NULL);
    }

    return 0;
}

