/* Carlos Augusto Amador Manilla A01329447 */
/* Angel Roberto Ruiz Mendoza A01324489 */

%{
  #include "libs/definitions.h"
  #include "libs/symbolTable.h"
  #include "libs/syntaxTree.h"
  #include "libs/functionSymbolTable.h"
  #include "libs/executioner.h"

  char*error; // to store error messages

  
  int declsFlag = 0;
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

    declsFlag = 0;
  } | {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"opt_decls -> NOTHING: %d\n"RESET, ++counter);
    #endif

    declsFlag = 0;
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

    declsFlag = 1;

    $$ = createDeclNode($1, NULL); 
  }
;

type: 
  INT { 
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"type -> Int: %d  table %s\n", ++counter, currentTable == globalTable? "global": "function");
    #endif

    if(!declsFlag) functionType = integer;
  } | 
  REAL { 
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"type -> Real: %d  table %s\n", ++counter, currentTable == globalTable? "global": "function");
    #endif 

    if(!declsFlag) functionType = real;
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
      printf("Call to function %s\n", functionCalls->treeNode->identifier);
      function = findFunction(functionCalls->treeNode->identifier);
      if(function == NULL) {sprintf(error, "Function %s is not declared.", functionCalls->treeNode->identifier); yyerror(error); return 1; }

      ArgNode*args = functionCalls->treeNode->argList;
      ArgNode*arg = args;
      ParamNode*param = function->paramsList;

      // Check that the number and type of arguments matches the parameters required
      int count = 1;
      while(param != NULL) {
        if(arg == NULL) {sprintf(error, "Invalid call to %s. Missing arguments.", function->identifier); yyerror(error); return 1; }
        if(param->type != arg->syntaxTree->type) {sprintf(error, "Invalid call to %s. Type mismatch in argument %d.", function->identifier, count); yyerror(error); return 1; }
      
        param = param->next;
        arg = arg->next;
        count++;
      }
      if(arg != NULL) {sprintf(error, "Invalid call to %s. More arguments than required given.", function->identifier); yyerror(error); return 1; }

      functionCalls = functionCalls->next;
    }

    currentTable = globalTable;
  }
;

opt_params:
  param_lst {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"param_lst -> param_lst: %d\n"RESET, ++counter);
    #endif

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
    
    if(currentTable == globalTable) currentTable = initSymbolTable();

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
    SymbolNode*symbolG = findSymbol($1, globalTable);
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
    printf(BLUE"factor -> Identifier %s: %d\n"RESET, $1, ++counter);
    #endif

    SymbolNode*symbol = findSymbol($1, currentTable);
    SymbolNode*symbolG = findSymbol($1, globalTable);
    if(symbol == NULL && symbolG == NULL) { sprintf(error, "Symbol %s not found", $1); yyerror(error); return 1; }
    symbol = symbol == NULL? symbolG: symbol;

    $$ =  createTreeNode(IIDENTIFIER, symbol-> type, (Value)0, symbol->identifier, NULL, NULL, NULL);
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
    
    TreeNode*functionNode = createTreeNode(IFUNCTION, functionType, (Value)0, $1, NULL, NULL, NULL);
    functionNode->argList = $3;

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
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"opt_args -> args_lst: %d\n"RESET, ++counter);
    #endif
    $$ = $1;
  } |
   {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"opt_args -> Nothing: %d\n"RESET, ++counter);
    #endif
    
    $$ =  NULL;
  } 
;

arg_lst:
  expr COMMA arg_lst {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"args_lst -> expr, arg_lst: %d\n"RESET, ++counter);
    #endif

    $$ = createArgNode($1, $3);
  } | 
  expr {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"args_lst -> expr: %d\n"RESET, ++counter);
    #endif

    $$ = createArgNode($1, NULL);
  }
;

%%


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

