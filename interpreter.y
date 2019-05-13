/* Carlos Augusto Amador Manilla A01329447 */
/* Angel Roberto Ruiz Mendoza A01324489 */

%{
  #include "libs/definitions.h"
  #include "libs/symbolTable.h"
  #include "libs/syntaxTree.h"
  #include "libs/functionSymbolTable.h"
  #include "libs/executioner.h"

  char*error; // to store error messages
  extern int lines; // line counter
  extern FILE* yyin; // input file
  extern char yytext[]; // text of last identified token

  int yylex();
  void yyerror(const char *s);

  int counter = 0; // for debugging
%}

%expect 1 

%token <stringVal> IDENTIFIER // return string value
%token <type> INT REAL // return Type value
%token <intVal> INTV // return int value
%token <floatVal> FLOATV // return int value
%token // list of used tokens
  BEGINS END IF ELSE WHILE DO THEN PRINT READ FUN
  VAR LET FLOAT PROCEDURE PROGRAM
  PLUS MINUS SLASH ASTERISK BIGGER BIGGEROREQUAL SMALLER SMALLEROREQUAL EQUAL ASSIGNMENT
  DOT COMMA COLON SEMICOLON PARENTHESIS CPARENTHESIS RETURN

%type <type> type // return Type value
%type <treeNode> stmt expr expression term factor stmt_lst opt_stmts fun_lst // return TreeNode pointers
%type <argNode> opt_args arg_lst // return ArgNode pointer
%type <paramNode> opt_params param_lst param // return ParamNode pointer
%type <declNode> decl id_lst // return DeclNode pointer

%start prog

%code requires {
  #include "libs/syntaxTree.h"
}

// List of return types
%union {
  int intVal;
  float floatVal;
  char*stringVal;
  Type type;
  TreeNode*treeNode;
  ArgNode*argNode;
  ParamNode*paramNode;
  DeclNode*declNode;
}

%%
prog: PROGRAM IDENTIFIER opt_decls opt_fun_decls BEGINS opt_stmts END {
  #ifdef _PRINT_PARSE_TRACE
  printf(BLUE"Program: %d\n"RESET, ++counter);
  #endif

  // Set main program syntax tree
  TreeNode*endNode = createTreeNode(IEND, null, (Value)0, NULL, NULL, NULL, NULL); 
  root = createTreeNode(IBEGIN, null, (Value)0, NULL, $6, NULL, endNode);

  // Valid syntax
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

    // Insert list of identifiers with given type in the current symbol table
    DeclNode*declNode = insertDeclList($2, $4, currentTable);
    if(declNode != NULL) {sprintf(error, "Symbol %s already declared", declNode->identifier); yyerror(error); return 1;}
  }
;

id_lst: 
  IDENTIFIER COMMA id_lst { 
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"id_lst -> Identifier , id_lst: %d  table %s\n", ++counter, currentTable == globalTable? "global": "function");
    #endif
    
    $$ = createDeclNode($1, $3); // creation of DeclNode linked list
  } |
  IDENTIFIER { 
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"id_lst -> Identifier: %d  table %s\n", ++counter, currentTable == globalTable? "global": "function");
    #endif

    $$ = createDeclNode($1, NULL); // creation of DeclNode linked list
  }
;

type: 
  INT { 
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"type -> Int: %d\n", ++counter);
    #endif
  } | 
  REAL { 
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"type -> Real: %d\n", ++counter);
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
  FUN IDENTIFIER PARENTHESIS opt_params CPARENTHESIS COLON type {
    // First part of fuction declaration
    // Inserts the delcared function in functions table with its declared type and list of parameters
    
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"fun_decl -> fun id (opt_params) : type opt_decls begin opt_stmts end : %d\n"RESET, ++counter);
    #endif

    // set currentTable to a new symbol table
    currentTable = initSymbolTable();

    // Get the parameters list and inserts them, throws an error if an identifier is repeated
    ParamNode*paramsList = $4;
    ParamNode*param = insertParamList(paramsList, currentTable);
    if(param != NULL) { sprintf(error, "Parameter %s alredy declared.", param->identifier); yyerror(error); return 1; }

    // Throws an error if a functions with same identifier is already declared
    currentFunction = findFunction($2);
    if(currentFunction != NULL) {sprintf(error, "Function %s is already declared", $2); yyerror(error); return 1; }
    currentFunction = createFunctionNode($2, $7, currentTable, NULL, paramsList);
    
    insertFunctionSymbol(currentFunction); // inserts the function in the functions table
  } opt_decls BEGINS opt_stmts END {
    // Second part of fuction declaration
    // Inserts the declared variables in the current symbol table, parses function syntax tree

    #ifdef _PRINT_SYMBOL_TABLES
    printf(CYAN"\nFunction %s "RESET, function->identifier);
    printSymbolTable(function->hashTable); 
    #endif

    // Set the function syntax tree
    TreeNode*endNode = createTreeNode(IEND, null, (Value)0, NULL, NULL, NULL, NULL);
    TreeNode*syntaxTree = createTreeNode(IBEGIN, null, (Value)0, NULL, $11, NULL, endNode);
    currentFunction->syntaxTree = syntaxTree;

    // Sets current symbol table to global symbol table
    currentTable = globalTable;

    #ifdef _PRINT_SYNTAX_TREES
      printf(YELLOW"Function %s syntax tree:\n", currentFunction->identifier);
      postOrder(currentFunction->syntaxTree);
      printf("\n" RESET);
    #endif
  }
;

opt_params:
  param_lst {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"param_lst -> param_lst: %d\n"RESET, ++counter);
    #endif

    $$ = $1; // Pass the params list
  } | {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"opt_params -> Nothing: %d\n"RESET, ++counter);
    #endif

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
    $$ = paramNode;// creation of ParamNode linked list
  } | 
  param {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"param_lst -> param: %d\n"RESET, ++counter);
    #endif

    $$ = $1; // creation of ParamNode linked list
  }
;

param: 
  IDENTIFIER COLON type {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"param -> deintifier: type : %d\n"RESET, ++counter);
    #endif

    $$ = createParamNode($1, $3, NULL); // create a ParamNode struct
  }
;

stmt: 
  IDENTIFIER ASSIGNMENT expr {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"stmt -> Assignment: %d\n"RESET, ++counter);
    #endif

    // Search the identifier in global and local symbol table, local has priority
    SymbolNode*symbol = findSymbol($1, currentTable);
    SymbolNode*symbolG = findSymbol($1, globalTable);
    if(symbol == NULL && symbolG == NULL) { sprintf(error, "Symbol %s not found", $1); yyerror(error); return 1; }
    symbol = symbol == NULL? symbolG: symbol;
    
    // checks nodes type and sets it to parent, error is thrown if mismatch found
    if(symbol->type != $3->type) {
      sprintf(error, RED"Type mismatch, type %d is not type %d"RESET, symbol->type, $3->type); 
      yyerror(error); 
      return 1;
    }
    
    // creeates identifier and assignment TreeNodes    
    TreeNode*idNode = createTreeNode(IIDENTIFIER, null, (Value)0, symbol->identifier, NULL, NULL, NULL);
    $$ = createTreeNode(IASSIGNMENT, null, (Value)0, NULL, idNode, NULL, $3); 
  } |
  IF expression THEN stmt {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"stmt -> If Then: %d\n"RESET, ++counter);
    #endif

    // creates if TreeNode with expression and then body
    TreeNode*thenNode = createTreeNode(ITHEN, null, (Value)0, NULL, $4, NULL, NULL);
    $$ = createTreeNode(IIF, null, (Value)0, NULL, $2, NULL, thenNode); 
  } |
  IF expression THEN stmt ELSE stmt {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"stmt -> If Then Else: %d\n"RESET, ++counter);
    #endif

    // creates if TreeNode with expression, then body and else body
    TreeNode*thenNode = createTreeNode(ITHEN, null, (Value)0, NULL, $4, NULL, NULL);
    TreeNode*elseNode = createTreeNode(IELSE, null, (Value)0, NULL, $6, NULL, NULL); 
    $$ = createTreeNode(IIF, null, (Value)0, NULL, $2, thenNode, elseNode);
  } |
  WHILE expression DO stmt {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"stmt -> While Do: %d\n"RESET, ++counter);
    #endif

    // creates while node with expression and body
    TreeNode* doNode = createTreeNode(IDO, null, (Value)0, NULL, $4, NULL, NULL);
    $$ = createTreeNode(IWHILE, null, (Value)0, NULL, $2, NULL, doNode);
  } |
  READ IDENTIFIER { 
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"stmt -> Read: %d\n"RESET, ++counter);
    #endif

    // Search the identifier in global and local symbol table, local has priority
    SymbolNode*symbol = findSymbol($2, currentTable);
    SymbolNode*symbolG = findSymbol($2, currentTable);
    if(symbol == NULL && symbolG == NULL) { sprintf(error, "Symbol %s not found", $2); yyerror(error); return 1; }
    symbol = symbol == NULL? symbolG: symbol;
    
    // creates read node with identifier node
    TreeNode*idNode = createTreeNode(IIDENTIFIER, symbol->type, (Value)0, symbol->identifier, NULL, NULL, NULL);
    $$ = createTreeNode(IREAD, null, (Value)0, NULL, idNode, NULL, NULL);
  } |
  PRINT expr {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"stmt -> Print: %d\n"RESET, ++counter);
    #endif
    
    // creates print node with expr
    $$ = createTreeNode(IPRINT, null, (Value)0, NULL, $2, NULL, NULL);
  } |
  BEGINS opt_stmts END {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"stmt -> Begin End: %d\n"RESET, ++counter);
    #endif

    // Creates begin node with syntax tree
    TreeNode*endNode = createTreeNode(IEND, null, (Value)0, NULL, NULL, NULL, NULL);
    $$ = createTreeNode(IBEGIN, null, (Value)0, NULL, $2, NULL, endNode);
  } |
  RETURN expr {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"stmt -> Return: %d\n"RESET, ++counter);
    #endif

    // creates return TreeNode
    $$ = createTreeNode(IRETURN, null, (Value)0, NULL, $2, NULL, NULL);
  }
;

opt_stmts: 
  stmt_lst { 
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"opt_stmts -> stmt_lst: %d\n"RESET, ++counter);
    #endif

    $$ = $1; // pass semicolon node
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
    
    // creates semicolon TreeNode
    $$ = createTreeNode(ISEMICOLON, null, (Value)0, NULL, $1, NULL, $3); 
  } | 
  stmt {
    #ifdef _PRINT_PARSE_TRACE
    printf(BLUE"stmt_lst -> stmt: %d\n"RESET, ++counter);
    #endif 

    // pass stmt TreeNode
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

    FunctionSymbolNode*function = findFunction($1);
    if(function == NULL) {sprintf(error, "Function %s is not declared.", $1); yyerror(error); return 1; }
    
    // Create function syntax tree node
    ArgNode*argsList = $3;
    TreeNode*functionNode = createTreeNode(IFUNCTION, function->type, (Value)0, $1, NULL, NULL, NULL);
    functionNode->argList = argsList;

    // Check that the number and type of arguments matches the parameters required
    ArgNode*arg = argsList;
    ParamNode*param = function->paramsList;
    int count = 1;
    while(param != NULL) {
      if(arg == NULL) {sprintf(error, "Invalid call to %s. Missing arguments.", function->identifier); yyerror(error); return 1; }
      if(param->type != arg->syntaxTree->type) {sprintf(error, "Invalid call to %s. Type mismatch in argument %d.", function->identifier, count); yyerror(error); return 1; }
      
      param = param->next;
      arg = arg->next;
      count++;
    }

    if(arg != NULL) {sprintf(error, "Invalid call to %s. More arguments than required given.", function->identifier); yyerror(error); return 1; }
    
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
  printf(RED"%s in line %d\n"RESET, s, lines);
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

      #ifdef _PRINT_SYNTAX_TREES
        printf(YELLOW"Function main syntax tree:\n");
        postOrder(root);
        printf("\n" RESET);
      #endif

      printf(RESET"Execution output:\n");
      execTree(root, NULL);
    }

    return 0;
}

