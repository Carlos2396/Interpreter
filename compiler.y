/* Carlos Augusto Amador Manilla A01329447 */
/* Angel Roberto Ruiz Mendoza A01324489 */

%{
  #include "symbolTable.h"
  #include "syntaxTree"

  char*error; // to store error messages
  llNode*rem; // to check for errors in insertion to the symbol table

  extern int lines; // line counter
  extern FILE* yyin; // input file
%}

%token <stringVal> IDENTIFIER
%token <type> INT
%token <type> REAL
%token 
    BEGINS END IF ELSE WHILE DO FOR FOREACH THEN PRINT READ
    VAR LET BOOLEAN FLOAT PROCEDURE PROGRAM 
    INTV FLOATV 
    PLUS MINUS SLASH ASTERISK BIGGER BIGGEROREQUAL SMALLER SMALLEROREQUAL EQUAL ASSIGNMENT
    DOT COLON TWODOTS SEMICOLON PARENTHESIS CPARENTHESIS BRACKET CBRACKET

%start prog

// possible values
%union {
  int intVal;
  double doubleVal;
  char*stringVal;
  int type;
}

%%
prog: PROGRAM IDENTIFIER opt_decls BEGINS opt_stmts END {
  treeNode endNode = createTreeNode(IEND, null, 0, NULL, NULL, NULL, NULL); 
  root = createTreeNode(IBEGIN, null, 0, NULL, $5, NULL, endNode);

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

type: INT { if((rem = insertRemaining($1)) != NULL) {sprintf(error, "Symbol %s already declared", rem->identifier); yyerror(error); return 1;} } | 
      REAL { if((rem = insertRemaining($1)) != NULL) {sprintf(error, "Symbol %s already declared", rem->identifier); yyerror(error); return 1;} }
;

stmt: 
  IDENTIFIER ASSIGNMENT expr { 
    if(findSymbol($1) == NULL) { sprintf(error, "Symbol %s not found", $1); yyerror(error); return 1;} 
    $$ = createTreeNode(IASSIGNMENT, null, 0, NULL, $1, NULL, $3); 
  } |
  IF expression THEN stmt { 
    treeNode*thenNode = createTreeNode(ITHEN, null, 0, NULL, $4, NULL, NULL);
    $$ = createTreeNode(IIF, null, 0, NULL, $2, NULL, thenNode); 
  } |
  IF expression THEN stmt ELSE stmt { 
    treeNode*thenNode = createTreeNode(ITHEN, null, 0, NULL, $4, NULL, NULL);
    treeNode*elseNode = createTreeNode(ITHEN, null, 0, NULL, $6, NULL, NULL); 
    $$ = createTreeNode(IIF, null, 0, NULL, $2, thenNode, elseNode);
  } |
  WHILE expression DO stmt {
    $doNode = createTreeNode(IDO, null, 0, NULL, $4, NULL, NULL);
    $$ = createTreeNode(IWHILE, null, 0, NULL, $2, NULL, doNode);
  } |
  READ IDENTIFIER { 
    Node*symbol = findSymbol($2);
    if(symbol == NULL) { sprintf(error, "Symbol %s not found", $2); yyerror(error); return 1; }
    treeNode*idNode = createTreeNode(IID, null, 0, symbol, NULL, NULL, NULL);
    $$ = createTreeNode(IREAD, null, 0, NULL, idNode, NULL, NULL, NULL);
  } |
  PRINT expr {
    $$ = createTreeNode(IPRINT, null, 0, NULL, $2, NULL, NULL);
  } |
  BEGINS opt_stmts END {
    treeNode*endNode = createTreeNode(IEND, null, 0, NULL, NULL, NULL, NULL);
    $$ = createTreeNode(IBEGIN, null, 0, NULL, $2, NULL, endNode);
  }
;

opt_stmts: stmt_lst { return $1; };
 | { return NULL; } 
;

stmt_lst: 
  stmt SEMICOLON stmt_lst { 
    $$ = createTreeNode(ISEMICOLON, null, 0, NULL, $1, NULL, $3); 
  } | 
  stmt { 
    return $1; 
  }
;

expr:   expr PLUS term{
          $$ = createTreeNode(IPLUS, null, 0, NULL, $1, NULL, $3);
        } |
        expr MINUS term{
          $$ = createTreeNode(IMINUS, null, 0, NULL, $1, NULL, $3);
        } |
        term{
          return $1;
        }
;

term: term ASTERISK factor{
        $$ = createTreeNode(IASTERISK, null, 0, NULL, $1, NULL, $3);
      } |
      term SLASH factor{
        $$ = createTreeNode(ISLASH, null, 0, NULL, $1, NULL, $3);
      } |
      factor{
        return $1;
      }
;

factor: 
  PARENTHESIS expr CPARENTHESIS{
    treeNode* parNode = createTreeNode(ICPARENTHESIS, null, 0, NULL, NULL, NULL, NULL);
    $$ = createTreeNode(IPARENTHESIS, null, 0, NULL, $2, NULL, parNode);
  } |
  IDENTIFIER  { 
                Node* symbol = findSymbol($1);
                if(symbol == NULL) {
                   sprintf(error, "Symbol %s not found", $1); 
                   yyerror(error); 
                   return 1; 
                } 
                $$ =  createTreeNode(IID, null, 0, symbol, NULL, NULL, NULL);
              } |
  INTV {
    $$ = createTreeNode(IINTNUM, integer, $1, NULL, NULL, NULL, NULL);
  } |
  FLOATV {
    $$ = createTreeNode(IREALNUM, real, $1, NULL, NULL, NULL, NULL);
  }
;

expression: 
  expr SMALLER expr {
    $$ = createTreeNode(ISMALLER, null, 0, NULL, $1, NULL, $3);
  } |
  expr BIGGER expr {
    $$ = createTreeNode(IBIGGER, null, 0, NULL, $1, NULL, $3);
  }|
  expr EQUAL expr{
    $$ = createTreeNode(IEQUAL, null, 0, NULL, $1, NULL, $3);
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

    return 0;
}

