/* Carlos Augusto Amador Manilla A01329447 */
/* Angel Roberto Ruiz Mendoza A01324489 */

%{
  #include "libs/definitions.h"
  #include "libs/symbolTable.h"
  #include "libs/syntaxTree.h"
  #include "libs/functionSymbolTable.h"
  #include "libs/functionStack.h"

  char*error; // to store error messages

  SymbolNode**globalTable;
  SymbolNode**currentTable;
  FunctionCallNode*functionCalls;

  extern int lines; // line counter
  extern FILE* yyin; // input file
  int yylex();
  void yyerror(const char *s);

  int counter = 0;
%}

%expect 1

%token <stringVal> IDENTIFIER
%token <type> INT
%token <type> REAL
%token <intVal> INTV
%token <floatVal> FLOATV
%type <type> type
%type <nodePointer> stmt expr expression term factor stmt_lst opt_stmts fun_lst
%type <argNode> opt_args arg_lst
%type <paramNode> opt_params param_lst param
%type <declNode> decl id_lst
%token 
    BEGINS END IF ELSE WHILE DO FOR FOREACH THEN PRINT READ FUN
    VAR LET BOOLEAN FLOAT PROCEDURE PROGRAM
    PLUS MINUS SLASH ASTERISK BIGGER BIGGEROREQUAL SMALLER SMALLEROREQUAL EQUAL ASSIGNMENT
    DOT COMMA COLON SEMICOLON PARENTHESIS CPARENTHESIS BRACKET CBRACKET RETURN

%start prog

%code requires {
  #include "libs/syntaxTree.h"
}

// possible values
%union {
  int intVal;
  float floatVal;
  char*stringVal;
  Type type;
  TreeNode*nodePointer;
  ArgNode*argNode;
  ParamNode*paramNode;
  DeclNode*declNode;
}

%%
prog: PROGRAM IDENTIFIER opt_decls opt_fun_decls BEGINS opt_stmts END {
  #ifdef _PRINT_PARSE_TRACE
  printf(BLUE"Program: %d\n"RESET, ++counter);
  #endif

  TreeNode*endNode = createTreeNode(IEND, null, (Value)0, NULL, NULL, NULL, NULL); 
  root = createTreeNode(IBEGIN, null, (Value)0, NULL, $6, NULL, endNode);

  YYACCEPT; 
};

opt_decls: 
  decl_lst {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"opt_decls -> decl_lst: %d\n"RESET, ++counter);
    #endif
  } | {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"opt_decls -> NOTHING: %d\n"RESET, ++counter);
    #endif
  }
;

decl_lst: 
  decl SEMICOLON decl_lst {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"decl_lst -> decl ; decl_lst: %d\n"RESET, ++counter);
    #endif
  } | 
  decl {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"decl_lst -> decl: %d\n"RESET, ++counter);
    #endif
  }
;

decl: 
  LET id_lst COLON type {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"decl -> id_lst : type: %d\n"RESET, ++counter);
    #endif

    DeclNode*declList = $2;
    DeclNode*declNode = insertDeclList(declList, $4, currentTable);
    if(declNode != NULL) {sprintf(error, "Symbol %s already declared", declNode->identifier); yyerror(error); return 1;}
  }
;

id_lst: 
  IDENTIFIER COMMA id_lst { 
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"id_lst -> Identifier , id_lst: %d  table %s\n", ++counter, currentTable == globalTable? "global": "function");
    #endif
    
    $$ = createDeclNode($1, $3);
  } |
  IDENTIFIER { 
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"id_lst -> Identifier: %d  table %s\n", ++counter, currentTable == globalTable? "global": "function");
    #endif

    $$ = createDeclNode($1, NULL); 
  }
;

type: 
  INT { 
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"type -> Int: %d  table %s\n", ++counter, currentTable == globalTable? "global": "function");
    #endif
  } | 
  REAL { 
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"type -> Real: %d  table %s\n", ++counter, currentTable == globalTable? "global": "function");
    #endif 
  }
;

opt_fun_decls:
  fun_lst {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"opt_fun_decls -> fun_lst : %d\n"RESET, ++counter);
    #endif
  } | {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"opt_fun_decls -> nothing : %d\n"RESET, ++counter);
    #endif
  }
;

fun_lst:
  fun_decl COMMA fun_lst {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"fun_lst -> fun_decl , fun_lst : %d\n"RESET, ++counter);
    #endif
  } | 
  fun_decl {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"fun_lst -> fun_decl : %d\n"RESET, ++counter);
    #endif
  }
;

fun_decl:
  FUN IDENTIFIER PARENTHESIS opt_params CPARENTHESIS COLON type opt_decls BEGINS opt_stmts END {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"fun_decl -> fun id (opt_params) : type opt_decls begin opt_stmts end : %d\n"RESET, ++counter);
    #endif

    FunctionSymbolNode*function = findFunction($2);
    if(function != NULL) {sprintf(error, "Function %s already declared", $2); yyerror(error); return 1; }

    ParamNode*paramsList = $4;
    TreeNode*endNode = createTreeNode(IEND, null, (Value)0, NULL, NULL, NULL, NULL);
    TreeNode*syntaxTree = createTreeNode(IBEGIN, null, (Value)0, NULL, $10, NULL, endNode);

    function = createFunctionNode($2, $7, currentTable, syntaxTree, paramsList);

    #ifdef _PRINT_SYMBOL_TABLES
    printf(CYAN"\nFunction %s "RESET, function->identifier);
    printSymbolTable(function->hashTable); 
    #endif

    insertFunctionSymbol(function);

    FunctionSymbolNode*calledFunction;
    while(functionCalls != NULL) {
      calledFunction = findFunction(functionCalls->treeNode->identifier);
      if(calledFunction == NULL) {sprintf(error, "Function %s is not declared.", functionCalls->treeNode->identifier); yyerror(error); return 1; }

      ArgNode*args = functionCalls->treeNode->argList;
      ArgNode*arg = args;
      ParamNode*param = calledFunction->paramsList;

      // Check that the number and type of arguments matches the parameters required
      int count = 1;
      while(param != NULL) {
        if(arg == NULL) {sprintf(error, "Invalid call to %s. Missing arguments.", calledFunction->identifier); yyerror(error); return 1; }
        if(param->type != arg->syntaxTree->type) {sprintf(error, "Invalid call to %s. Type mismatch in argument %d.", calledFunction->identifier, count); yyerror(error); return 1; }
      
        param = param->next;
        arg = arg->next;
        count++;
      }
      if(arg != NULL) {sprintf(error, "Invalid call to %s. More arguments than required given.", calledFunction->identifier); yyerror(error); return 1; }
    }

    currentTable = globalTable;
  }
;

opt_params:
  param_lst {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"param_lst -> param_lst: %d\n"RESET, ++counter);
    #endif
    
    if(currentTable == globalTable) currentTable = initSymbolTable();

    $$ = $1;
  } | {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"opt_params -> Nothing: %d\n"RESET, ++counter);
    #endif

    if(currentTable == globalTable) currentTable = initSymbolTable();

    $$ = NULL;
  }
;

param_lst: 
  param COMMA param_lst {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"param_lst -> param , param_lst: %d\n"RESET, ++counter);
    #endif

    ParamNode*paramNode = $1;
    paramNode->next = $3;
    $$ = paramNode;
  } | 
  param {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"param_lst -> param: %d\n"RESET, ++counter);
    #endif

    $$ = $1;
  }
;

param: 
  IDENTIFIER COLON type {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"param -> deintifier: type : %d\n"RESET, ++counter);
    #endif

    ParamNode*param = createParamNode($1, $3, NULL);
    if(!insertSymbol(param->identifier, param->type, (Value)0, currentTable)) {
      sprintf(error, "Parameters and variables of functions cannot have the same identifier."); yyerror(error); return 1;
    }

    $$ = param;
  }
;

stmt: 
  IDENTIFIER ASSIGNMENT expr {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"stmt -> Assignment: %d\n"RESET, ++counter);
    #endif

    SymbolNode*symbol = findSymbol($1, currentTable);
    SymbolNode*symbolG = findSymbol($1, currentTable);
    if(symbol == NULL && symbolG == NULL) { sprintf(error, "Symbol %s not found", $1); yyerror(error); return 1; }
    symbol = symbol == NULL? symbolG: symbol;

    if(symbol->type != $3->type) {
      sprintf(error, RED"Type mismatch, type %d is not type %d"RESET, symbol->type, $3->type); 
      yyerror(error); 
      return 1;
    }
    
    TreeNode*idNode = createTreeNode(IIDENTIFIER, null, (Value)0, symbol->identifier, NULL, NULL, NULL);
    $$ = createTreeNode(IASSIGNMENT, null, (Value)0, NULL, idNode, NULL, $3); 
  } |
  IF expression THEN stmt {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"stmt -> If Then: %d\n"RESET, ++counter);
    #endif

    TreeNode*thenNode = createTreeNode(ITHEN, null, (Value)0, NULL, $4, NULL, NULL);
    $$ = createTreeNode(IIF, null, (Value)0, NULL, $2, NULL, thenNode); 
  } |
  IF expression THEN stmt ELSE stmt {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"stmt -> If Then Else: %d\n"RESET, ++counter);
    #endif

    TreeNode*thenNode = createTreeNode(ITHEN, null, (Value)0, NULL, $4, NULL, NULL);
    TreeNode*elseNode = createTreeNode(IELSE, null, (Value)0, NULL, $6, NULL, NULL); 
    $$ = createTreeNode(IIF, null, (Value)0, NULL, $2, thenNode, elseNode);
  } |
  WHILE expression DO stmt {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"stmt -> While Do: %d\n"RESET, ++counter);
    #endif

    TreeNode* doNode = createTreeNode(IDO, null, (Value)0, NULL, $4, NULL, NULL);
    $$ = createTreeNode(IWHILE, null, (Value)0, NULL, $2, NULL, doNode);
  } |
  READ IDENTIFIER { 
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"stmt -> Read: %d\n"RESET, ++counter);
    #endif

    SymbolNode*symbol = findSymbol($2, currentTable);
    SymbolNode*symbolG = findSymbol($2, currentTable);
    if(symbol == NULL && symbolG == NULL) { sprintf(error, "Symbol %s not found", $2); yyerror(error); return 1; }
    symbol = symbol == NULL? symbolG: symbol;
    
    TreeNode*idNode = createTreeNode(IIDENTIFIER, symbol->type, (Value)0, symbol->identifier, NULL, NULL, NULL);
    $$ = createTreeNode(IREAD, null, (Value)0, NULL, idNode, NULL, NULL);
  } |
  PRINT expr {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"stmt -> Print: %d\n"RESET, ++counter);
    #endif

    $$ = createTreeNode(IPRINT, null, (Value)0, NULL, $2, NULL, NULL);
  } |
  BEGINS opt_stmts END {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"stmt -> Begin End: %d\n"RESET, ++counter);
    #endif

    TreeNode*endNode = createTreeNode(IEND, null, (Value)0, NULL, NULL, NULL, NULL);
    $$ = createTreeNode(IBEGIN, null, (Value)0, NULL, $2, NULL, endNode);
  } |
  RETURN expr {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"stmt -> Return: %d\n"RESET, ++counter);
    #endif
    $$ = createTreeNode(IRETURN, null, (Value)0, NULL, $2, NULL, NULL);
  }
;

opt_stmts: 
  stmt_lst { 
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"opt_stmts -> stmt_lst: %d\n"RESET, ++counter);
    #endif

    $$ = $1; 
  }
  | { 
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"opt_stmts -> NOTHING: %d\n"RESET, ++counter);
    #endif

    $$ = NULL; 
  } 
;

stmt_lst: 
  stmt SEMICOLON stmt_lst { 
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"stmt_lst -> stmt ; stmt_lst: %d\n"RESET, ++counter);
    #endif

    $$ = createTreeNode(ISEMICOLON, null, (Value)0, NULL, $1, NULL, $3); 
  } | 
  stmt {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"stmt_lst -> stmt: %d\n"RESET, ++counter);
    #endif 

    $$ = $1; 
  }
;

expr:   
  expr PLUS term {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"expr -> Plus: %d\n"RESET, ++counter);
    #endif

    if($1->type != $3->type){
      sprintf(error, "Type mismatch, type %d is not type %d", $1->type, $3->type); 
      yyerror(error); 
      return 1;
    }

    $$ = createTreeNode(IPLUS, $1->type, (Value)0, NULL, $1, NULL, $3);
  } |
  expr MINUS term {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"expr -> Minus: %d\n"RESET, ++counter);
    #endif

    if($1->type != $3->type){
      sprintf(error, "Type mismatch, type %d is not type %d", $1->type, $3->type); 
      yyerror(error); 
      return 1;
    }

    $$ = createTreeNode(IMINUS, $1->type, (Value)0, NULL, $1, NULL, $3);
  } |
  term {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"expr -> term: %d\n"RESET, ++counter);
    #endif

    $$ =  $1;
  }
;

term: 
  term ASTERISK factor {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"term -> Asterisk: %d\n"RESET, ++counter);
    #endif

    if($1->type != $3->type){
      sprintf(error, "Type mismatch, type %d is not type %d", $1->type, $3->type); 
      yyerror(error); 
      return 1;
    }

    $$ = createTreeNode(IASTERISK, $1->type, (Value)0, NULL, $1, NULL, $3);
  } |
  term SLASH factor {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"term -> Slash: %d\n"RESET, ++counter);
    #endif

    if($1->type != $3->type){
      sprintf(error, "Type mismatch, type %d is not type %d", $1->type, $3->type); 
      yyerror(error); 
      return 1;
    }

    $$ = createTreeNode(ISLASH, $1->type, (Value)0, NULL, $1, NULL, $3);
  } |
  factor {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"term -> factor: %d\n"RESET, ++counter);
    #endif

    $$ = $1;
  }
;

factor: 
  PARENTHESIS expr CPARENTHESIS {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"factor -> Parenthesis: %d\n"RESET, ++counter);
    #endif

    TreeNode* parNode = createTreeNode(ICPARENTHESIS, $2->type, (Value)0, NULL, NULL, NULL, NULL);
    $$ = createTreeNode(IPARENTHESIS, $2->type, (Value)0, NULL, $2, NULL, parNode);
  } |
  IDENTIFIER {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"factor -> Identifier: %d\n"RESET, ++counter);
    #endif

    SymbolNode*symbol = findSymbol($1, currentTable);
    SymbolNode*symbolG = findSymbol($1, currentTable);
    if(symbol == NULL && symbolG == NULL) { sprintf(error, "Symbol %s not found", $1); yyerror(error); return 1; }
    symbol = symbol == NULL? symbolG: symbol;

    Type symType = symbol-> type;
    $$ =  createTreeNode(IIDENTIFIER, symType, (Value)0, symbol->identifier, NULL, NULL, NULL);
  } |
  INTV {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"factor -> IntV -> %d: %d\n"RESET, $1, ++counter);
    #endif

    $$ = createTreeNode(IINTNUM, integer, (Value)$1, NULL, NULL, NULL, NULL);
  } |
  FLOATV {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"factor -> FloatV -> %f: %d\n"RESET, $1, ++counter);
    #endif

    $$ = createTreeNode(IREALNUM, real, (Value)$1, NULL, NULL, NULL, NULL);
  } |
  IDENTIFIER PARENTHESIS opt_args CPARENTHESIS {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"factor -> id(opt_args): %d\n"RESET, ++counter);
    #endif
    
    TreeNode*functionNode = createTreeNode(IFUNCTION, null, (Value)0, $1, NULL, NULL, NULL);
    functionNode->argList = args;

    functionCalls = addFunctionCall(functionCalls, createFunctionCallNode(functionNode, NULL));

    #ifdef _PRINT_FUN_CALLS
    printf(YELLOW"\nCall to function %s\n"RESET, function->identifier);
    printArgsList(args);
    #endif
    
    $$ = functionNode;
  }
;

expression: 
  expr SMALLER expr {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"expression -> Smaller: %d\n"RESET, ++counter);
    #endif

    if($1->type != $3->type){
      sprintf(error, "Type mismatch, type %d is not type %d", $1->type, $3->type); 
      yyerror(error); 
      return 1;
    }

    $$ = createTreeNode(ISMALLER, $1->type, (Value)0, NULL, $1, NULL, $3);
  } |
  expr BIGGER expr {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"expression -> Bigger: %d\n"RESET, ++counter);
    #endif

    if($1->type != $3->type){
      sprintf(error, "Type mismatch, type %d is not type %d", $1->type, $3->type); 
      yyerror(error); 
      return 1;
    }

    $$ = createTreeNode(IBIGGER, $1->type, (Value)0, NULL, $1, NULL, $3);
  } |
  expr EQUAL expr {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"expression -> Equal: %d\n"RESET, ++counter);
    #endif

    if($1->type != $3->type){
      sprintf(error, "Type mismatch, type %d is not type %d", $1->type, $3->type); 
      yyerror(error); 
      return 1;
    }

    $$ = createTreeNode(IEQUAL,$1->type, (Value)0, NULL, $1, NULL, $3);
  } |
  expr SMALLEROREQUAL expr {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"expression -> Smaller or equal: %d\n"RESET, ++counter);
    #endif

    if($1->type != $3->type){
      sprintf(error, "Type mismatch, type %d is not type %d", $1->type, $3->type); 
      yyerror(error); 
      return 1;
    }

    $$ = createTreeNode(ISMALLEROREQUAL,$1->type, (Value)0, NULL, $1, NULL, $3);
  } | 
  expr BIGGEROREQUAL expr {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"expression -> Bigger or equal: %d\n"RESET, ++counter);
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
     $$ =  NULL;
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
int execFunctionFunctionInt(TreeNode* functNode, SymbolNode** hashTable);
float execFunctionFunctionFloat(TreeNode* functNode, SymbolNode** hashTable);
void execFunction(TreeNode* functNode, SymbolNode** hashTable);
void execTree(TreeNode* root, SymbolNode** hashTable);

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
      return execFunctionFunctionInt(factorNode, hashTable);
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
      return execFunctionFunctionFloat(factorNode, hashTable);
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

int execFunctionFunctionInt(TreeNode* functionNode, SymbolNode** hashTable){
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
  push(functionS->identifier, (Value)0);
  execFunction(functionS->syntaxTree, newFunctTable);
  FunctionStackNode* stackNode = pop();
  #ifdef _PRINT_RETURN_STACK
  if(functionS->identifier != stackNode->identifier){
    printf(RED"Algo salió muy mal");
  }
  else{
    printf(BLUE"Al parecer funciono");
  }
  #endif
  return stackNode->returnVal.intV;
}

float execFunctionFunctionFloat(TreeNode* functionNode, SymbolNode** hashTable){
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
  push(functionS->identifier, (Value)0);
  execFunction(functionS->syntaxTree, newFunctTable);
  FunctionStackNode* stackNode = pop();
  #ifdef _PRINT_RETURN_STACK
  if(functionS->identifier != stackNode->identifier){
    printf(RED"Algo salió muy mal");
  }
  else{
    printf(BLUE"Al parecer funciono");
  }
  #endif
  return stackNode->returnVal.realV;
}

void execFunction(TreeNode*root, SymbolNode** hashTable) {
  if(root == NULL) return;

  switch(root->instruction) {
    case ISEMICOLON:
      execFunction(root->left, hashTable);
      execFunction(root->right, hashTable);
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
    case IRETURN:{ 
      if(root->left->type == integer){
        int x = evalExprInt(root->left, hashTable);
        stack->tail->returnVal = (Value)x;
      }
      else{
        float x = evalExprFloat(root->left, hashTable);
        stack->tail->returnVal = (Value)x;
      }
      break;
    }
  }
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
  }
}

void yyerror(char const * s) {
  lines++;
  fprintf(stderr, RED"%s in line %d\n"RESET, s, lines);
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

    initFunctionsTable();
    globalTable = initSymbolTable();
    currentTable = globalTable;
    initStack();
    int res = yyparse();

    #ifdef _PRINT_SYMBOL_TABLES
    printf(CYAN"\nGlobal "RESET);
    printSymbolTable(globalTable);
    #endif
  
    if(!res) {
      printf(GREEN"Successfully compiled.\n\n");

      printf(RESET"Execution output:\n");
      execTree(root, NULL);
    }

    return 0;
}

