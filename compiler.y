/* Carlos Augusto Amador Manilla A01329447 */
/* Angel Roberto Ruiz Mendoza A01324489 */

%{
  #include "symbolTable.h"
  #include "syntaxTree.h"

  char*error; // to store error messages
  llNode*rem; // to check for errors in insertion to the symbol table

  extern int lines; // line counter
  extern FILE* yyin; // input file
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
  struct treeNode* nodePointer;
}

%%
prog: PROGRAM IDENTIFIER opt_decls BEGINS opt_stmts END {
  treeNode*endNode = createTreeNode(IEND, null, (Value)0, NULL, NULL, NULL, NULL); 
  root = createTreeNode(IBEGIN, null, (Value)0, NULL, $5, NULL, endNode);

  YYACCEPT; 
};

opt_decls: decl_lst | 
;

decl_lst: decl SEMICOLON decl_lst | decl
;

decl: LET id_lst TWODOTS type
;

id_lst: 
  IDENTIFIER COLON id_lst { addRemaining($1); } |
  IDENTIFIER { addRemaining($1); }
;

type: 
  INT { if((rem = insertRemaining($1)) != NULL) {sprintf(error, "Symbol %s already declared", rem->identifier); yyerror(error); return 1;} } | 
  REAL { if((rem = insertRemaining($1)) != NULL) {sprintf(error, "Symbol %s already declared", rem->identifier); yyerror(error); return 1;} }
;

stmt: 
  IDENTIFIER ASSIGNMENT expr { 
    Node*symbol = findSymbol($1);
    if(findSymbol($1) == NULL) { sprintf(error, "Symbol %s not found", $1); yyerror(error); return 1; } 
    treeNode*idNode = createTreeNode(IIDENTIFIER, null, (Value)0, symbol, NULL, NULL, NULL);
    $$ = createTreeNode(IASSIGNMENT, null, (Value)0, NULL, idNode, NULL, $3); 
  } |
  IF expression THEN stmt { 
    treeNode*thenNode = createTreeNode(ITHEN, null, (Value)0, NULL, $4, NULL, NULL);
    $$ = createTreeNode(IIF, null, (Value)0, NULL, $2, NULL, thenNode); 
  } |
  IF expression THEN stmt ELSE stmt { 
    treeNode*thenNode = createTreeNode(ITHEN, null, (Value)0, NULL, $4, NULL, NULL);
    treeNode*elseNode = createTreeNode(ITHEN, null, (Value)0, NULL, $6, NULL, NULL); 
    $$ = createTreeNode(IIF, null, (Value)0, NULL, $2, thenNode, elseNode);
  } |
  WHILE expression DO stmt {
    treeNode* doNode = createTreeNode(IDO, null, (Value)0, NULL, $4, NULL, NULL);
    $$ = createTreeNode(IWHILE, null, (Value)0, NULL, $2, NULL, doNode);
  } |
  READ IDENTIFIER { 
    Node*symbol = findSymbol($2);
    if(symbol == NULL) { sprintf(error, "Symbol %s not found", $2); yyerror(error); return 1; }
    treeNode*idNode = createTreeNode(IID, null, (Value)0, symbol, NULL, NULL, NULL);
    $$ = createTreeNode(IREAD, null, (Value)0, NULL, idNode, NULL, NULL);
  } |
  PRINT expr {
    $$ = createTreeNode(IPRINT, null, (Value)0, NULL, $2, NULL, NULL);
  } |
  BEGINS opt_stmts END {
    treeNode*endNode = createTreeNode(IEND, null, (Value)0, NULL, NULL, NULL, NULL);
    $$ = createTreeNode(IBEGIN, null, (Value)0, NULL, $2, NULL, endNode);
  }
;

opt_stmts: 
  stmt_lst { $$ = $1; }
  | { $$ = NULL; } 
;

stmt_lst: 
  stmt SEMICOLON stmt_lst { 
    printf("stmt_lst: SEMICOLON\n");
    $$ = createTreeNode(ISEMICOLON, null, (Value)0, NULL, $1, NULL, $3); 
  } | 
  stmt { $$ = $1; }
;

expr:   
  expr PLUS term {
    $$ = createTreeNode(IPLUS, null, (Value)0, NULL, $1, NULL, $3);
  } |
  expr MINUS term {
    $$ = createTreeNode(IMINUS, null, (Value)0, NULL, $1, NULL, $3);
  } |
  term {
    $$ =  $1;
  }
;

term: 
  term ASTERISK factor {
    $$ = createTreeNode(IASTERISK, null, (Value)0, NULL, $1, NULL, $3);
  } |
  term SLASH factor {
    $$ = createTreeNode(ISLASH, null, (Value)0, NULL, $1, NULL, $3);
  } |
  factor {
    $$ = $1;
  }
;

factor: 
  PARENTHESIS expr CPARENTHESIS {
    treeNode* parNode = createTreeNode(ICPARENTHESIS, null, (Value)0, NULL, NULL, NULL, NULL);
    $$ = createTreeNode(IPARENTHESIS, null, (Value)0, NULL, $2, NULL, parNode);
  } |
  IDENTIFIER { 
    Node* symbol = findSymbol($1);
    if(symbol == NULL) {
        sprintf(error, "Symbol %s not found", $1); 
        yyerror(error); 
        return 1; 
    }

    $$ =  createTreeNode(IID, null, (Value)0, symbol, NULL, NULL, NULL);
  } |
  INTV {
    $$ = createTreeNode(IINTNUM, integer, (Value)$1, NULL, NULL, NULL, NULL);
  } |
  FLOATV {
    $$ = createTreeNode(IREALNUM, real, (Value)$1, NULL, NULL, NULL, NULL);
  }
;

expression: 
  expr SMALLER expr {
    $$ = createTreeNode(ISMALLER, null, (Value)0, NULL, $1, NULL, $3);
  } |
  expr BIGGER expr {
    $$ = createTreeNode(IBIGGER, null, (Value)0, NULL, $1, NULL, $3);
  } |
  expr EQUAL expr{
    $$ = createTreeNode(IEQUAL, null, (Value)0, NULL, $1, NULL, $3);
  }
;

%%

int yyerror(char const * s) {
  lines++;
  fprintf(stderr, RED"%s in line %d\n", s, lines);
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
    postOrder(root);

    return 0;
}

