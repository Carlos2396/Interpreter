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
    TreeNode*elseNode = createTreeNode(ITHEN, null, (Value)0, NULL, $6, NULL, NULL); 
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
    TreeNode*idNode = createTreeNode(IIDENTIFIER, null, (Value)0, symbol, NULL, NULL, NULL);
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

    $$ = createTreeNode(IPLUS, null, (Value)0, NULL, $1, NULL, $3);
  } |
  expr MINUS term {
    #ifdef _PRINT_STACK_TRACE
    printf("expr -> Minus: %d\n", ++counter);
    #endif

    $$ = createTreeNode(IMINUS, null, (Value)0, NULL, $1, NULL, $3);
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

    $$ = createTreeNode(IASTERISK, null, (Value)0, NULL, $1, NULL, $3);
  } |
  term SLASH factor {
    #ifdef _PRINT_STACK_TRACE
    printf("term -> Slash: %d\n", ++counter);
    #endif

    $$ = createTreeNode(ISLASH, null, (Value)0, NULL, $1, NULL, $3);
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

    TreeNode* parNode = createTreeNode(ICPARENTHESIS, null, (Value)0, NULL, NULL, NULL, NULL);
    $$ = createTreeNode(IPARENTHESIS, null, (Value)0, NULL, $2, NULL, parNode);
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

    $$ =  createTreeNode(IIDENTIFIER, null, (Value)0, symbol, NULL, NULL, NULL);
  } |
  INTV {
    #ifdef _PRINT_STACK_TRACE
    printf("factor -> IntV: %d\n", ++counter);
    #endif

    $$ = createTreeNode(IINTNUM, integer, (Value)$1, NULL, NULL, NULL, NULL);
  } |
  FLOATV {
    #ifdef _PRINT_STACK_TRACE
    printf("factor -> FloatV: %d\n", ++counter);
    #endif

    $$ = createTreeNode(IREALNUM, real, (Value)$1, NULL, NULL, NULL, NULL);
  }
;

expression: 
  expr SMALLER expr {
    #ifdef _PRINT_STACK_TRACE
    printf("expression -> Smaller: %d\n", ++counter);
    #endif

    $$ = createTreeNode(ISMALLER, null, (Value)0, NULL, $1, NULL, $3);
  } |
  expr BIGGER expr {
    #ifdef _PRINT_STACK_TRACE
    printf("expression -> Bigger: %d\n", ++counter);
    #endif

    $$ = createTreeNode(IBIGGER, null, (Value)0, NULL, $1, NULL, $3);
  } |
  expr EQUAL expr{
    #ifdef _PRINT_STACK_TRACE
    printf("expression -> Equal: %d\n", ++counter);
    #endif

    $$ = createTreeNode(IEQUAL, null, (Value)0, NULL, $1, NULL, $3);
  }
;

%%

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
    inOrder(root);

    return 0;
}

