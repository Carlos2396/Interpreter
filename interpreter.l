/* Carlos Augusto Amador Manilla A01329447 */
/* Angel Roberto Ruiz Mendoza A01324489 */
/* Definitions */

%{
    #include "interpreter.tab.h"
    #include "libs/definitions.h"

    int lines = 1;
%}

%option lex-compat
%option yylineno

ENDR         end

DIGITE       [0-9]
DIGITNZE     [1-9]
ALPHAE       [a-zA-Z]
VARSE        [_|$]
WHITESPACEE  [ \t\r]+
LINEBREAK    [\n]+

INTE         ({DIGITNZE}{DIGITE}*|0)
FLOATE       {INTE}[.]{DIGITE}+
IDENTIFIERE  ({ALPHAE}|{VARSE})+({ALPHAE}|{VARSE}|{DIGITE})*

%%
{WHITESPACEE}   { }
{LINEBREAK}   { lines++; }

begin         { return BEGINS; }
end           { return END; }
if            { return IF; }
else          { return ELSE; }
while         { return WHILE; }
do            { return DO; }
then          { return THEN; }
print         { return PRINT; }
read          { return READ; }

let           { return LET; }
integer       { yylval.type = integer; return INT; }
real          { yylval.type = real; return REAL; }
fun           { return FUN; }
program       { return PROGRAM; }
return        { return RETURN; }
{IDENTIFIERE} { yylval.stringVal = strdup(yytext); return IDENTIFIER; }

{INTE}          { yylval.intVal = atoi(yytext); return INTV; }
{FLOATE}        { yylval.floatVal = atof(yytext); return FLOATV; }

"+"             { return PLUS; }
"-"             { return MINUS; }
"/"             { return SLASH; }
"*"             { return ASTERISK; }
">"             { return BIGGER; }
"<"             { return SMALLER; }
">="            { return BIGGEROREQUAL; }
"<="            { return SMALLEROREQUAL; }
"="             { return EQUAL; }
":="            { return ASSIGNMENT; }

"."             { return DOT; }
","             { return COMMA; }
":"             { return COLON; }
";"             { return SEMICOLON; }
"("             { return PARENTHESIS; }
")"             { return CPARENTHESIS; }

.              { }
%%