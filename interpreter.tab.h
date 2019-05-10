/* A Bison parser, made by GNU Bison 3.3.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2019 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_INTERPRETER_TAB_H_INCLUDED
# define YY_YY_INTERPRETER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif
/* "%code requires" blocks.  */
#line 39 "interpreter.y" /* yacc.c:1921  */

  #include "syntaxTree.h"

#line 52 "interpreter.tab.h" /* yacc.c:1921  */

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    IDENTIFIER = 258,
    INT = 259,
    REAL = 260,
    INTV = 261,
    FLOATV = 262,
    BEGINS = 263,
    END = 264,
    IF = 265,
    ELSE = 266,
    WHILE = 267,
    DO = 268,
    FOR = 269,
    FOREACH = 270,
    THEN = 271,
    PRINT = 272,
    READ = 273,
    FUN = 274,
    VAR = 275,
    LET = 276,
    BOOLEAN = 277,
    FLOAT = 278,
    PROCEDURE = 279,
    PROGRAM = 280,
    PLUS = 281,
    MINUS = 282,
    SLASH = 283,
    ASTERISK = 284,
    BIGGER = 285,
    BIGGEROREQUAL = 286,
    SMALLER = 287,
    SMALLEROREQUAL = 288,
    EQUAL = 289,
    ASSIGNMENT = 290,
    DOT = 291,
    COMMA = 292,
    COLON = 293,
    SEMICOLON = 294,
    PARENTHESIS = 295,
    CPARENTHESIS = 296,
    BRACKET = 297,
    CBRACKET = 298
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 44 "interpreter.y" /* yacc.c:1921  */

  int intVal;
  float floatVal;
  char*stringVal;
  Type type;
  TreeNode*nodePointer;
  ArgNode*argNode;
  ParamNode*paramNode;

#line 118 "interpreter.tab.h" /* yacc.c:1921  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_INTERPRETER_TAB_H_INCLUDED  */
