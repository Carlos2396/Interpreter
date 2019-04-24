/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

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

#ifndef YY_YY_COMPILER_TAB_H_INCLUDED
# define YY_YY_COMPILER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

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
    VAR = 274,
    LET = 275,
    BOOLEAN = 276,
    FLOAT = 277,
    PROCEDURE = 278,
    PROGRAM = 279,
    PLUS = 280,
    MINUS = 281,
    SLASH = 282,
    ASTERISK = 283,
    BIGGER = 284,
    BIGGEROREQUAL = 285,
    SMALLER = 286,
    SMALLEROREQUAL = 287,
    EQUAL = 288,
    ASSIGNMENT = 289,
    DOT = 290,
    COLON = 291,
    TWODOTS = 292,
    SEMICOLON = 293,
    PARENTHESIS = 294,
    CPARENTHESIS = 295,
    BRACKET = 296,
    CBRACKET = 297
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 32 "compiler.y" /* yacc.c:1909  */

  int intVal;
  float floatVal;
  char*stringVal;
  int type;
  struct TreeNode* nodePointer;

#line 105 "compiler.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_COMPILER_TAB_H_INCLUDED  */
