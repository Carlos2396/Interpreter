/* Carlos Augusto Amador Manilla A01329447 */
/* Angel Roberto Ruiz Mendoza A01324489 */

%{
  #include "definitions.h"
  #include "symbolTable.h"
  #include "syntaxTree.h"

  char*error; // to store error messages
  LLNode*rem; // to check for errors in insertion to the symbol table

  extern int lines; // line counter
  extern FILE* yyin; // input file
  int counter = 0;
%}

%token <stringVal> IDENTIFIER
%token <type> INT
%token <type> REAL
%token <intVal> INTV
%token <floatVal> FLOATV
%type <nodePointer> stmt expr expression term factor stmt_lst opt_stmts
%token 
    BEGINS END IF ELSE WHILE DO FOR FOREACH THEN PRINT READ
    VAR LET BOOLEAN FLOAT PROCEDURE PROGRAM
    PLUS MINUS SLASH ASTERISK BIGGER BIGGEROREQUAL SMALLER SMALLEROREQUAL EQUAL ASSIGNMENT
    DOT COLON TWODOTS SEMICOLON PARENTHESIS CPARENTHESIS BRACKET CBRACKET

%start prog

// possible values
%union {
  int intVal;
  float floatVal;
  char*stringVal;
  int type;
  struct TreeNode* nodePointer;
}

%%
prog: PROGRAM IDENTIFIER opt_decls BEGINS opt_stmts END {
  #ifdef _PRINT_STACK_TRACE
  printf("Program: %d\n", ++counter);
  #endif

  TreeNode*endNode = createTreeNode(IEND, null, (Value)0, NULL, NULL, NULL, NULL); 
  root = createTreeNode(IBEGIN, null, (Value)0, NULL, $5, NULL, endNode);

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
  LET id_lst TWODOTS type {
    #ifdef _PRINT_STACK_TRACE
    printf("decl -> id_lst : type: %d\n", ++counter);
    #endif
  }
;

id_lst: 
  IDENTIFIER COLON id_lst { 
    #ifdef _PRINT_STACK_TRACE
    printf("id_lst -> Identifier , id_lst: %d\n", ++counter);
    #endif

    addRemaining($1); 
  } |
  IDENTIFIER { 
    #ifdef _PRINT_STACK_TRACE
    printf("id_lst -> Identifier: %d\n", ++counter);
    #endif

    addRemaining($1); 
  }
;

type: 
  INT { 
    #ifdef _PRINT_STACK_TRACE
    printf("type -> Int: %d\n", ++counter);
    #endif

    if((rem = insertRemaining($1)) != NULL) {sprintf(error, "Symbol %s already declared", rem->identifier); yyerror(error); return 1;} 
  } | 
  REAL { 
    #ifdef _PRINT_STACK_TRACE
    printf("type -> Real: %d\n", ++counter);
    #endif

    if((rem = insertRemaining($1)) != NULL) {sprintf(error, "Symbol %s already declared", rem->identifier); yyerror(error); return 1;} 
  }
;

stmt: 
  IDENTIFIER ASSIGNMENT expr {
    #ifdef _PRINT_STACK_TRACE
    printf("stmt -> Assignment: %d\n", ++counter);
    #endif


    SymbolNode*symbol = findSymbol($1);
    if(findSymbol($1) == NULL) { sprintf(error, "Symbol %s not found", $1); yyerror(error); return 1; } 
    if(symbol->type != $3->type) {
      sprintf(error, "Type mismatch, type %d is not type %d", symbol->type, $3->type); 
      yyerror(error); 
      return 1;
    }
    
    TreeNode*idNode = createTreeNode(IIDENTIFIER, null, (Value)0, symbol, NULL, NULL, NULL);
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
    
    TreeNode*idNode = createTreeNode(IIDENTIFIER, symbol->type, (Value)0, symbol, NULL, NULL, NULL);
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
    $$ =  createTreeNode(IIDENTIFIER, symType, (Value)0, symbol, NULL, NULL, NULL);
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
  expr EQUAL expr{
    #ifdef _PRINT_STACK_TRACE
    printf("expression -> Equal: %d\n", ++counter);
    #endif

    if($1->type != $3->type){
      sprintf(error, "Type mismatch, type %d is not type %d", $1->type, $3->type); 
      yyerror(error); 
      return 1;
    }

    $$ = createTreeNode(IEQUAL,$1->type, (Value)0, NULL, $1, NULL, $3);
  }
;

%%

int evalExprInt(TreeNode* exprNode);
int evalTermInt(TreeNode* termNode);
int evalFactorInt(TreeNode* factorNode);
float evalExprFloat(TreeNode* exprNode);
float evalTermFloat(TreeNode* termNode);
float evalFactorFloat(TreeNode* factorNode);
int evalExpression(TreeNode* expressionNode);
void ifFunction(TreeNode* ifNode);
void thenFunction(TreeNode* thenNode);
void elseFunction(TreeNode* elseNode);
void whileFunction(TreeNode* whileNode);
void doFunction(TreeNode* doNode);
void printFunction(TreeNode* printNode);
void assignFunction(TreeNode* assignNode);
void beginFunction(TreeNode* beginNode);

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

void readFunction(TreeNode*readNode) {
  switch(symbol->type) {
    case integer:
      modifySymbol(symbol->identifier, readInteger());
      break;
    case real:
      modifySymbol(symbol->identifier, readReal());
      break;
  }
}

void printFunction(TreeNode*printNode) {
  switch(printNode->expr->type){
    case integer:
      int exprRes = evalExprInt(printNode->left);
      printf("%d", exprRes);
      break;
    case real:
      float exprRes = evalExprFloat(printNode->left);
      printf("%f", exprRes);
      break;
    default;
      #ifdef _PRINT_STACK_TRACE
      printf("Something went wrong print function");
      exit(1);
      #endif
      break
  }
}

int evalFactorInt(TreeNode* factorNode){
  switch(factorNode->instruction){
    case IPARENTHESIS:
      return evalExprInt(factorNode-> left);
      break;
    case IIDENTIFIER:
      return factorNode->symbolTableNode->val.intV;
      break;
    case IINTNUM:
      return factorNode->val.intV;
      break;
    case IREALNUM:
      #ifdef _PRINT_STACK_TRACE
      printf("Something went wrong evalFactorInt had a real");
      exit(1);
      #endif
      break;
    default:
      #ifdef _PRINT_STACK_TRACE
      printf("Something went wrong evalFactorInt default");
      exit(1);
      #endif
      break;
  }
}

int evalTermInt(TreeNode* termNode){
  switch(termNode->instruction){
    case ASTERISK:
      int leftTerm = evalTermInt(termNode->left);
      int rightFactor = evalFactorInt(termNode->right);
      return leftTerm * rightFactor;
      break;
    case SLASH:
      int leftTerm = evalTermInt(termNode->left);
      int rightFactor = evalFactorInt(termNode->right);
      return leftTerm / rightFactor;
      break;
    default:
      return evalFactorInt(termNode);
      break;
  }
}

int evalExprInt(TreeNode* exprNode){
  switch(exprNode->instruction){
    case IPLUS:
      int leftExpr = evalExprInt(exprNode->left);
      int rightTerm = evalTermInt(exprNode->right);
      return leftExpr + rightTerm;
      break;
    case IMINUS:
      int leftExpr = evalExprInt(exprNode->left);
      int rightTerm = evalTermInt(exprNode->right);
      return leftExpr - rightTerm;
      break;
    default:
      return evalTermInt(exprNode);
      break;
  }
}

float evalFactorFloat(TreeNode* factorNode){
  switch(factorNode->instruction){
    case IPARENTHESIS:
      return evalExprFloat(factorNode-> left);
      break;
    case IIDENTIFIER:
      return factorNode->symbolTableNode->val.realV;
      break;
    case IINTNUM:
    #ifdef _PRINT_STACK_TRACE
      printf("Something went wrong evalFactorInt had a real");
      exit(1);
      #endif
      break;
    case IREALNUM:
      return factorNode->val.realV;
      break;
    default:
      #ifdef _PRINT_STACK_TRACE
      printf("Something went wrong evalFactorInt default");
      exit(1);
      #endif
      break;
  }
}

float evalTermFloat(TreeNode* termNode){
  switch(termNode->instruction){
    case ASTERISK:
      float leftTerm = evalTermFloat(termNode->left);
      float rightFactor = evalFactorFloat(termNode->right);
      return leftTerm * rightFactor;
      break;
    case SLASH:
      float leftTerm = evalTermFloat(termNode->left);
      float rightFactor = evalFactorFloat(termNode->right);
      return leftTerm / rightFactor;
      break;
    default:
      return evalFactorFloat(termNode);
      break;
  }
}

float evalExprFloat(TreeNode* exprNode){
  switch(exprNode->instruction){
    case IPLUS:
      float leftExpr = evalExprFloat(exprNode->left);
      float rightTerm = evalTermFloat(exprNode->right);
      return leftExpr + rightTerm;
      break;
    case IMINUS:
      float leftExpr = evalExprFloat(exprNode->left);
      float rightTerm = evalTermFloat(exprNode->right);
      return leftExpr - rightTerm;
      break;
    default:
      return evalTermFloat(exprNode);
      break;
  }
}

int evalExpression(TreeNode* expressionNode){
  if(expressionNode->type = integer){
    int leftExpr = evalExprInt(expressionNode->left);
    int rightExpr = evalExprInt(expressionNode->right);
  }
  else{
    float leftExpr = evalExprFloat(expressionNode->left);
    float rightExpr = evalExprFloat(expressionNode->right);
  }
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
      #ifdef _PRINT_STACK_TRACE
      printf("Something went wrong eval expression");
      exit(1);
      #endif
      break;
  }
}

void ifFunction(TreeNode* ifNode){
  int exrpessionRes = evalExpression(ifNode->left);
  if(exrpessionRes){
    execTree(ifNode->center);
  }    
  else{
    execTree(ifNode->right);
  }
}

void thenFunction(TreeNode* thenNode){
  execTree(thenNode->left);
}

void elseFunction(TreeNode* elseNode){
  if(elseNode != NULL){
    execTree(elseNode->left);
  }
}

void whileFunction(TreeNode* whileNode){
  int exrpessionRes = evalExpression(whileNode->left);
  if(exrpessionRes){
    whileNode->right->right = whileNode;
    execTree(whileNode->right);
  }
}

void doFunction(TreeNode* doNode){
  //Do stmt
  execTree(doNode->left);
  //Check while again
  execTree(doNode->right);
}

void beginFunction(TreeNode* beginNode){
  execTree(beginNode->left);
}

void assignFunction(TreeNode* assignNode){
  switch(assignNode->right->type){
    case integer:
      int exprRes = evalExprInt(assignNode->right)
      modifySymbol(assignNode->left->symbolTableNode->identifier, (Value)exprRes);
      break;
    case real:
      float exprRes = evalExprFloat(assignNode->right)
      modifySymbol(assignNode->left->symbolTableNode->identifier, (Value)exprRes);
      break;
    default:
      #ifdef _PRINT_STACK_TRACE
      printf("Something went wrong assign function");
      exit(1);
      #endif
      break;
  }
}

void execTree(TreeNode*root) {
  if(node == NULL) return;

  switch(root->instruction) {
    case ISEMICOLON:
      execTree(root->left);
      execTree(root->right);
      break;

    case IBEGIN:
      beginFunction(root);
      break;

    //Angel
    case IIF:
      ifFunction(root);
      break;

    //Angel
    case ITHEN:
      thenFunction(root);
      break;

    //Angel
    case IELSE:
      elseFunction(root);
      break;

    //Angel
    case IWHILE:
      whileFunction(root);
      break;

    //Angel
    case IDO:
      doFunction(root);
      break;

    case IREAD:
      readFunction(root);
      break;

    case IPRINT:
      printFunction(root);
      break;

    case IASSIGNMENT:
      assignFunction(root);
      break;
  }
}

handleError(int code, char*message) {
  fprintf(stderr, RED"Runtime error (%d): %s\n", code, message);
  exit(1);
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
    initTable();
    int res = yyparse();
  
    if(!res) {
      printf(GREEN"Accepted.\n");
    }

    printSymbolTable();

    printf("\nSystax Tree ------------------------\n");
    postOrder(root);

    printf("Execution output:\n");
    execTree(root);

    return 0;
}

