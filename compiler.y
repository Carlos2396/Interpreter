/* Carlos Augusto Amador Manilla A01329447 */

%{
  #include "symbolTable.h"
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
prog: PROGRAM IDENTIFIER opt_decls BEGINS opt_stmts END { YYACCEPT; }
;

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
  IDENTIFIER ASSIGNMENT expr { if(findSymbol($1) == NULL) { sprintf(error, "Symbol %s not found", $1); yyerror(error); return 1;} } |
  IF expression THEN stmt |
  IF expression THEN stmt ELSE stmt |
  WHILE expression DO stmt |
  READ IDENTIFIER { if(findSymbol($2) == NULL) { sprintf(error, "Symbol %s not found", $2); yyerror(error); return 1; } } |
  PRINT expr |
  BEGINS opt_stmts END
;

opt_stmts: stmt_lst | 
;

stmt_lst: stmt SEMICOLON stmt_lst | stmt
;

expr: term exprPrime
;

exprPrime: 
  PLUS term |
  MINUS term |
  term |
;

term: factor termPrime
;

termPrime: 
  ASTERISK factor |
  SLASH factor |
  factor |
;

factor: 
  PARENTHESIS expr CPARENTHESIS |
  IDENTIFIER { if(findSymbol($1) == NULL) { sprintf(error, "Symbol %s not found", $1); yyerror(error); return 1; } } |
  INTV |
  FLOATV
;

expression: 
  expr SMALLER expr |
  expr BIGGER expr |
  expr EQUAL expr
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

