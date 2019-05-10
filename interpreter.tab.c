/* A Bison parser, made by GNU Bison 3.3.2.  */

/* Bison implementation for Yacc-like parsers in C

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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.3.2"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* First part of user prologue.  */
#line 4 "interpreter.y" /* yacc.c:337  */

  #include "definitions.h"
  #include "symbolTable.h"
  #include "syntaxTree.h"
  #include "functionSymbolTable.h"

  char*error; // to store error messages
  LLNode*rem; // to check for errors in insertion to the symbol table

  HashTable*global;
  HashTable*currentTable;

  extern int lines; // line counter
  extern FILE* yyin; // input file
  
  int counter = 0;

#line 88 "interpreter.tab.c" /* yacc.c:337  */
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* In a future release of Bison, this section will be replaced
   by #include "interpreter.tab.h".  */
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
#line 39 "interpreter.y" /* yacc.c:352  */

  #include "syntaxTree.h"

#line 125 "interpreter.tab.c" /* yacc.c:352  */

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
#line 44 "interpreter.y" /* yacc.c:352  */

  int intVal;
  float floatVal;
  char*stringVal;
  Type type;
  TreeNode*nodePointer;
  ArgNode*argNode;
  ParamNode*paramNode;

#line 191 "interpreter.tab.c" /* yacc.c:352  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_INTERPRETER_TAB_H_INCLUDED  */



#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE
# if (defined __GNUC__                                               \
      && (2 < __GNUC__ || (__GNUC__ == 2 && 96 <= __GNUC_MINOR__)))  \
     || defined __SUNPRO_C && 0x5110 <= __SUNPRO_C
#  define YY_ATTRIBUTE(Spec) __attribute__(Spec)
# else
#  define YY_ATTRIBUTE(Spec) /* empty */
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# define YY_ATTRIBUTE_PURE   YY_ATTRIBUTE ((__pure__))
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# define YY_ATTRIBUTE_UNUSED YY_ATTRIBUTE ((__unused__))
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && ! defined __ICC && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN \
    _Pragma ("GCC diagnostic push") \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")\
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif


#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYSIZE_T yynewbytes;                                            \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / sizeof (*yyptr);                          \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYSIZE_T yyi;                         \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  4
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   90

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  44
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  22
/* YYNRULES -- Number of rules.  */
#define YYNRULES  52
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  103

#define YYUNDEFTOK  2
#define YYMAXUTOK   298

/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                                \
  ((unsigned) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,    55,    55,    67,    71,    79,    84,    92,   100,   107,
     117,   124,   134,   138,   146,   153,   163,   188,   194,   204,
     213,   223,   233,   250,   258,   267,   275,   286,   293,   304,
     311,   321,   328,   338,   351,   364,   374,   387,   400,   410,
     418,   432,   439,   446,   477,   490,   503,   516,   529,   545,
     548,   554,   557
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "IDENTIFIER", "INT", "REAL", "INTV",
  "FLOATV", "BEGINS", "END", "IF", "ELSE", "WHILE", "DO", "FOR", "FOREACH",
  "THEN", "PRINT", "READ", "FUN", "VAR", "LET", "BOOLEAN", "FLOAT",
  "PROCEDURE", "PROGRAM", "PLUS", "MINUS", "SLASH", "ASTERISK", "BIGGER",
  "BIGGEROREQUAL", "SMALLER", "SMALLEROREQUAL", "EQUAL", "ASSIGNMENT",
  "DOT", "COMMA", "COLON", "SEMICOLON", "PARENTHESIS", "CPARENTHESIS",
  "BRACKET", "CBRACKET", "$accept", "prog", "opt_decls", "decl_lst",
  "decl", "id_lst", "type", "opt_fun_decls", "fun_decls", "fun_decl",
  "opt_params", "param_lst", "param", "stmt", "opt_stmts", "stmt_lst",
  "expr", "term", "factor", "expression", "opt_args", "arg_lst", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298
};
# endif

#define YYPACT_NINF -69

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-69)))

#define YYTABLE_NINF -1

#define yytable_value_is_error(Yytable_value) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int8 yypact[] =
{
     -11,    31,    18,    23,   -69,    49,    34,   -69,    16,    17,
      19,    53,    50,   -69,    22,    23,    49,     8,    20,     7,
      34,   -69,   -69,   -69,   -69,   -69,    58,    27,     7,     0,
       0,     0,    60,    26,    57,   -69,   -69,    29,    28,   -69,
      33,     0,    59,    35,   -69,   -69,     0,    15,    -8,   -69,
      55,    61,     3,   -69,     7,   -69,     8,    38,    58,     3,
     -69,     0,   -18,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     7,     7,   -69,   -69,     8,   -69,     6,    32,
     -69,   -69,    -8,    -8,     3,     3,     3,     3,     3,   -69,
     -69,    66,   -69,    23,     0,   -69,     7,    70,   -69,   -69,
       7,    71,   -69
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,     0,     0,     4,     1,     0,    13,     3,     6,     9,
       0,     0,     0,    12,    15,     0,     0,     0,     0,    30,
       0,     5,     8,    10,    11,     7,    18,     0,    30,     0,
       0,     0,     0,    32,     0,    29,    14,     0,     0,    17,
      20,     0,     0,    40,    41,    42,     0,     0,    35,    38,
       0,     0,    27,    26,     0,     2,     0,     0,     0,    22,
      28,    50,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,    31,    21,     0,    19,    52,     0,
      49,    39,    33,    34,    45,    48,    44,    47,    46,    37,
      36,    23,    25,     4,     0,    43,     0,     0,    51,    24,
      30,     0,    16
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
     -69,   -69,   -14,    67,   -69,    65,   -54,   -69,    63,   -69,
     -69,    30,   -69,   -68,   -28,    36,   -30,   -37,   -20,    54,
     -69,    -9
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,     2,     6,     7,     8,    10,    25,    12,    13,    14,
      38,    39,    40,    33,    34,    35,    47,    48,    49,    50,
      79,    80
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_uint8 yytable[] =
{
      42,    52,    75,    43,    91,    92,    44,    45,    63,    64,
      27,    59,    23,    24,     1,    28,    62,    29,     4,    30,
      70,    71,    93,    81,    31,    32,    82,    83,    99,    63,
      64,    78,    63,    64,     3,    84,    85,    86,    87,    88,
      46,    63,    64,    94,     5,    65,    66,    67,    68,    69,
      89,    90,     9,    11,    16,    15,    18,    17,    19,    20,
      26,    37,    41,    53,    78,    54,    55,    56,    60,    57,
      58,    72,   101,    95,    73,    61,    76,    96,   100,    97,
     102,    22,    21,    36,    51,    98,     0,     0,    77,     0,
      74
};

static const yytype_int8 yycheck[] =
{
      28,    31,    56,     3,    72,    73,     6,     7,    26,    27,
       3,    41,     4,     5,    25,     8,    46,    10,     0,    12,
      28,    29,    76,    41,    17,    18,    63,    64,    96,    26,
      27,    61,    26,    27,     3,    65,    66,    67,    68,    69,
      40,    26,    27,    37,    21,    30,    31,    32,    33,    34,
      70,    71,     3,    19,    37,    39,     3,    38,     8,    37,
      40,     3,    35,     3,    94,    39,     9,    38,     9,    41,
      37,    16,   100,    41,    13,    40,    38,    11,     8,    93,
       9,    16,    15,    20,    30,    94,    -1,    -1,    58,    -1,
      54
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,    25,    45,     3,     0,    21,    46,    47,    48,     3,
      49,    19,    51,    52,    53,    39,    37,    38,     3,     8,
      37,    47,    49,     4,     5,    50,    40,     3,     8,    10,
      12,    17,    18,    57,    58,    59,    52,     3,    54,    55,
      56,    35,    58,     3,     6,     7,    40,    60,    61,    62,
      63,    63,    60,     3,    39,     9,    38,    41,    37,    60,
       9,    40,    60,    26,    27,    30,    31,    32,    33,    34,
      28,    29,    16,    13,    59,    50,    38,    55,    60,    64,
      65,    41,    61,    61,    60,    60,    60,    60,    60,    62,
      62,    57,    57,    50,    37,    41,    11,    46,    65,    57,
       8,    58,     9
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    44,    45,    46,    46,    47,    47,    48,    49,    49,
      50,    50,    51,    51,    52,    52,    53,    54,    54,    55,
      55,    56,    57,    57,    57,    57,    57,    57,    57,    58,
      58,    59,    59,    60,    60,    60,    61,    61,    61,    62,
      62,    62,    62,    62,    63,    63,    63,    63,    63,    64,
      64,    65,    65
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     7,     1,     0,     3,     1,     4,     3,     1,
       1,     1,     1,     0,     3,     1,    11,     1,     0,     3,
       1,     3,     3,     4,     6,     4,     2,     2,     3,     1,
       0,     3,     1,     3,     3,     1,     3,     3,     1,     3,
       1,     1,     1,     4,     3,     3,     3,     3,     3,     1,
       0,     3,     1
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyoutput = yyo;
  YYUSE (yyoutput);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyo, yytoknum[yytype], *yyvaluep);
# endif
  YYUSE (yytype);
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyo, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyo, yytype, yyvaluep);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yytype_int16 *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  unsigned long yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[yyssp[yyi + 1 - yynrhs]],
                       &yyvsp[(yyi + 1) - (yynrhs)]
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
static YYSIZE_T
yystrlen (const char *yystr)
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            else
              goto append;

          append:
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return (YYSIZE_T) (yystpcpy (yyres, yystr) - yyres);
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                yytype_int16 *yyssp, int yytoken)
{
  YYSIZE_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
  YYSIZE_T yysize = yysize0;
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat. */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Number of reported tokens (one for the "unexpected", one per
     "expected"). */
  int yycount = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[*yyssp];
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
                    yysize = yysize1;
                  else
                    return 2;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
    default: /* Avoid compiler warnings. */
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    YYSIZE_T yysize1 = yysize + yystrlen (yyformat);
    if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
      yysize = yysize1;
    else
      return 2;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          yyp++;
          yyformat++;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yynewstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  *yyssp = (yytype_int16) yystate;

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    goto yyexhaustedlab;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = (YYSIZE_T) (yyssp - yyss + 1);

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        YYSTYPE *yyvs1 = yyvs;
        yytype_int16 *yyss1 = yyss;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * sizeof (*yyssp),
                    &yyvs1, yysize * sizeof (*yyvsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yytype_int16 *yyss1 = yyss;
        union yyalloc *yyptr =
          (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
# undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
                  (unsigned long) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
#line 55 "interpreter.y" /* yacc.c:1652  */
    {
  #ifdef _PRINT_STACK_TRACE
  printf("Program: %d\n", ++counter);
  #endif

  TreeNode*endNode = createTreeNode(IEND, null, (Value)0, NULL, NULL, NULL, NULL); 
  root = createTreeNode(IBEGIN, null, (Value)0, NULL, (yyvsp[-1].nodePointer), NULL, endNode);

  YYACCEPT; 
}
#line 1363 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 3:
#line 67 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("opt_decls -> decl_lst: %d\n", ++counter);
    #endif
  }
#line 1373 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 4:
#line 71 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("opt_decls -> NOTHING: %d\n", ++counter);
    #endif
  }
#line 1383 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 5:
#line 79 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("decl_lst -> decl ; decl_lst: %d\n", ++counter);
    #endif
  }
#line 1393 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 6:
#line 84 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("decl_lst -> decl: %d\n", ++counter);
    #endif
  }
#line 1403 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 7:
#line 92 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("decl -> id_lst : type: %d\n", ++counter);
    #endif
  }
#line 1413 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 8:
#line 100 "interpreter.y" /* yacc.c:1652  */
    { 
    #ifdef _PRINT_STACK_TRACE
    printf("id_lst -> Identifier , id_lst: %d\n", ++counter);
    #endif

    addRemaining((yyvsp[-2].stringVal), currentTable); 
  }
#line 1425 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 9:
#line 107 "interpreter.y" /* yacc.c:1652  */
    { 
    #ifdef _PRINT_STACK_TRACE
    printf("id_lst -> Identifier: %d\n", ++counter);
    #endif

    addRemaining((yyvsp[0].stringVal), currentTable); 
  }
#line 1437 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 10:
#line 117 "interpreter.y" /* yacc.c:1652  */
    { 
    #ifdef _PRINT_STACK_TRACE
    printf("type -> Int: %d\n", ++counter);
    #endif

    if((rem = insertRemaining((yyvsp[0].type), currentTable)) != NULL) {sprintf(error, "Symbol %s already declared", rem->identifier); yyerror(error); return 1;} 
  }
#line 1449 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 11:
#line 124 "interpreter.y" /* yacc.c:1652  */
    { 
    #ifdef _PRINT_STACK_TRACE
    printf("type -> Real: %d\n", ++counter);
    #endif

    if((rem = insertRemaining((yyvsp[0].type), currentTable)) != NULL) {sprintf(error, "Symbol %s already declared", rem->identifier); yyerror(error); return 1;} 
  }
#line 1461 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 12:
#line 134 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("opt_decls -> fun_decls : %d\n", ++counter);
    #endif
  }
#line 1471 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 13:
#line 138 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("opt_decls -> nothing : %d\n", ++counter);
    #endif
  }
#line 1481 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 14:
#line 146 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("fun_decls -> fun_decl , fun_decls : %d\n", ++counter);
    #endif

    currentTable = initTable();
  }
#line 1493 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 15:
#line 153 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("fun_decls -> fun_decl : %d\n", ++counter);
    #endif

    currentTable = initTable();
  }
#line 1505 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 16:
#line 163 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("fun_decl -> fun id (opt_params) : type opt_decls begin opt_stmts end\n", ++counter);
    #endif

    FunctionSymbolNode*function = findFunction((yyvsp[-9].stringVal));
    if(function != NULL) {sprintf(error, "Function %s already declared", (yyvsp[-9].stringVal)); yyerror(error); return 1; }

    TreeNode*endNode = createTreeNode(IEND, null, (Value)0, NULL, NULL, NULL, NULL);
    TreeNode*syntaxTree = createTreeNode(IBEGIN, null, (Value)0, NULL, (yyvsp[-1].nodePointer), NULL, endNode);
    ParamNode*paramList = (yyvsp[-7].paramNode);

    function = createFunctionNode((yyvsp[-9].stringVal), (yyvsp[-4].type), currentTable, syntaxTree, paramList);
    
    if(!addParamsToSymbolFunctionTable(function)) {sprintf(error, "Parameters and variables of functions cannot haver the same identifier."); yyerror(error); return 1;}

    printSymbolTable(function->hashTable); 

    insertFunctionSymbol(function);

    currentTable = global;
  }
#line 1532 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 17:
#line 188 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("param_lst -> param_lst\n", ++counter);
    #endif

    (yyval.paramNode) = (yyvsp[0].paramNode);
  }
#line 1544 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 18:
#line 194 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("opt_params -> Nothing\n", ++counter);
    #endif

    (yyval.paramNode) = NULL;
  }
#line 1556 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 19:
#line 204 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("param_lst -> param , param_lst\n", ++counter);
    #endif

    ParamNode*paramNode = (yyvsp[-2].paramNode);
    paramNode->next = (yyvsp[0].paramNode);
    (yyval.paramNode) = paramNode;
  }
#line 1570 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 20:
#line 213 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("param_lst -> param\n", ++counter);
    #endif

    (yyval.paramNode) = (yyvsp[0].paramNode);
  }
#line 1582 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 21:
#line 223 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("param -> deintifier: type\n", ++counter);
    #endif

    (yyval.paramNode) = createParamNode((yyvsp[-2].stringVal), (yyvsp[0].type), NULL);
  }
#line 1594 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 22:
#line 233 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("stmt -> Assignment: %d\n", ++counter);
    #endif

    SymbolNode*symbol = findSymbol((yyvsp[-2].stringVal), currentTable);
    if(symbol == NULL) { sprintf(error, "Symbol %s not found", (yyvsp[-2].stringVal)); yyerror(error); return 1; } 
    
    if(symbol->type != (yyvsp[0].nodePointer)->type) {
      sprintf(error, "Type mismatch, type %d is not type %d", symbol->type, (yyvsp[0].nodePointer)->type); 
      yyerror(error); 
      return 1;
    }
    
    TreeNode*idNode = createTreeNode(IIDENTIFIER, null, (Value)0, symbol->identifier, NULL, NULL, NULL);
    (yyval.nodePointer) = createTreeNode(IASSIGNMENT, null, (Value)0, NULL, idNode, NULL, (yyvsp[0].nodePointer)); 
  }
#line 1616 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 23:
#line 250 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("stmt -> If Then: %d\n", ++counter);
    #endif

    TreeNode*thenNode = createTreeNode(ITHEN, null, (Value)0, NULL, (yyvsp[0].nodePointer), NULL, NULL);
    (yyval.nodePointer) = createTreeNode(IIF, null, (Value)0, NULL, (yyvsp[-2].nodePointer), NULL, thenNode); 
  }
#line 1629 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 24:
#line 258 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("stmt -> If Then Else: %d\n", ++counter);
    #endif

    TreeNode*thenNode = createTreeNode(ITHEN, null, (Value)0, NULL, (yyvsp[-2].nodePointer), NULL, NULL);
    TreeNode*elseNode = createTreeNode(IELSE, null, (Value)0, NULL, (yyvsp[0].nodePointer), NULL, NULL); 
    (yyval.nodePointer) = createTreeNode(IIF, null, (Value)0, NULL, (yyvsp[-4].nodePointer), thenNode, elseNode);
  }
#line 1643 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 25:
#line 267 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("stmt -> While Do: %d\n", ++counter);
    #endif

    TreeNode* doNode = createTreeNode(IDO, null, (Value)0, NULL, (yyvsp[0].nodePointer), NULL, NULL);
    (yyval.nodePointer) = createTreeNode(IWHILE, null, (Value)0, NULL, (yyvsp[-2].nodePointer), NULL, doNode);
  }
#line 1656 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 26:
#line 275 "interpreter.y" /* yacc.c:1652  */
    { 
    #ifdef _PRINT_STACK_TRACE
    printf("stmt -> Read: %d\n", ++counter);
    #endif

    SymbolNode*symbol = findSymbol((yyvsp[0].stringVal), currentTable);
    if(symbol == NULL) { sprintf(error, "Symbol %s not found", (yyvsp[0].stringVal)); yyerror(error); return 1; }
    
    TreeNode*idNode = createTreeNode(IIDENTIFIER, symbol->type, (Value)0, symbol->identifier, NULL, NULL, NULL);
    (yyval.nodePointer) = createTreeNode(IREAD, null, (Value)0, NULL, idNode, NULL, NULL);
  }
#line 1672 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 27:
#line 286 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("stmt -> Print: %d\n", ++counter);
    #endif

    (yyval.nodePointer) = createTreeNode(IPRINT, null, (Value)0, NULL, (yyvsp[0].nodePointer), NULL, NULL);
  }
#line 1684 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 28:
#line 293 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("stmt -> Begin End: %d\n", ++counter);
    #endif

    TreeNode*endNode = createTreeNode(IEND, null, (Value)0, NULL, NULL, NULL, NULL);
    (yyval.nodePointer) = createTreeNode(IBEGIN, null, (Value)0, NULL, (yyvsp[-1].nodePointer), NULL, endNode);
  }
#line 1697 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 29:
#line 304 "interpreter.y" /* yacc.c:1652  */
    { 
    #ifdef _PRINT_STACK_TRACE
    printf("opt_stmts -> stmt_lst: %d\n", ++counter);
    #endif

    (yyval.nodePointer) = (yyvsp[0].nodePointer); 
  }
#line 1709 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 30:
#line 311 "interpreter.y" /* yacc.c:1652  */
    { 
    #ifdef _PRINT_STACK_TRACE
    printf("opt_stmts -> NOTHING: %d\n", ++counter);
    #endif

    (yyval.nodePointer) = NULL; 
  }
#line 1721 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 31:
#line 321 "interpreter.y" /* yacc.c:1652  */
    { 
    #ifdef _PRINT_STACK_TRACE
    printf("stmt_lst -> stmt ; stmt_lst: %d\n", ++counter);
    #endif

    (yyval.nodePointer) = createTreeNode(ISEMICOLON, null, (Value)0, NULL, (yyvsp[-2].nodePointer), NULL, (yyvsp[0].nodePointer)); 
  }
#line 1733 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 32:
#line 328 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("stmt_lst -> stmt: %d\n", ++counter);
    #endif 

    (yyval.nodePointer) = (yyvsp[0].nodePointer); 
  }
#line 1745 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 33:
#line 338 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("expr -> Plus: %d\n", ++counter);
    #endif

    if((yyvsp[-2].nodePointer)->type != (yyvsp[0].nodePointer)->type){
      sprintf(error, "Type mismatch, type %d is not type %d", (yyvsp[-2].nodePointer)->type, (yyvsp[0].nodePointer)->type); 
      yyerror(error); 
      return 1;
    }

    (yyval.nodePointer) = createTreeNode(IPLUS, (yyvsp[-2].nodePointer)->type, (Value)0, NULL, (yyvsp[-2].nodePointer), NULL, (yyvsp[0].nodePointer));
  }
#line 1763 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 34:
#line 351 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("expr -> Minus: %d\n", ++counter);
    #endif

    if((yyvsp[-2].nodePointer)->type != (yyvsp[0].nodePointer)->type){
      sprintf(error, "Type mismatch, type %d is not type %d", (yyvsp[-2].nodePointer)->type, (yyvsp[0].nodePointer)->type); 
      yyerror(error); 
      return 1;
    }

    (yyval.nodePointer) = createTreeNode(IMINUS, (yyvsp[-2].nodePointer)->type, (Value)0, NULL, (yyvsp[-2].nodePointer), NULL, (yyvsp[0].nodePointer));
  }
#line 1781 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 35:
#line 364 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("expr -> term: %d\n", ++counter);
    #endif

    (yyval.nodePointer) =  (yyvsp[0].nodePointer);
  }
#line 1793 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 36:
#line 374 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("term -> Asterisk: %d\n", ++counter);
    #endif

    if((yyvsp[-2].nodePointer)->type != (yyvsp[0].nodePointer)->type){
      sprintf(error, "Type mismatch, type %d is not type %d", (yyvsp[-2].nodePointer)->type, (yyvsp[0].nodePointer)->type); 
      yyerror(error); 
      return 1;
    }

    (yyval.nodePointer) = createTreeNode(IASTERISK, (yyvsp[-2].nodePointer)->type, (Value)0, NULL, (yyvsp[-2].nodePointer), NULL, (yyvsp[0].nodePointer));
  }
#line 1811 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 37:
#line 387 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("term -> Slash: %d\n", ++counter);
    #endif

    if((yyvsp[-2].nodePointer)->type != (yyvsp[0].nodePointer)->type){
      sprintf(error, "Type mismatch, type %d is not type %d", (yyvsp[-2].nodePointer)->type, (yyvsp[0].nodePointer)->type); 
      yyerror(error); 
      return 1;
    }

    (yyval.nodePointer) = createTreeNode(ISLASH, (yyvsp[-2].nodePointer)->type, (Value)0, NULL, (yyvsp[-2].nodePointer), NULL, (yyvsp[0].nodePointer));
  }
#line 1829 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 38:
#line 400 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("term -> factor: %d\n", ++counter);
    #endif

    (yyval.nodePointer) = (yyvsp[0].nodePointer);
  }
#line 1841 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 39:
#line 410 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("factor -> Parenthesis: %d\n", ++counter);
    #endif

    TreeNode* parNode = createTreeNode(ICPARENTHESIS, (yyvsp[-1].nodePointer)->type, (Value)0, NULL, NULL, NULL, NULL);
    (yyval.nodePointer) = createTreeNode(IPARENTHESIS, (yyvsp[-1].nodePointer)->type, (Value)0, NULL, (yyvsp[-1].nodePointer), NULL, parNode);
  }
#line 1854 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 40:
#line 418 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("factor -> Identifier: %d\n", ++counter);
    #endif

    SymbolNode* symbol = findSymbol((yyvsp[0].stringVal), currentTable);
    if(symbol == NULL) {
        sprintf(error, "Symbol %s not found", (yyvsp[0].stringVal)); 
        yyerror(error); 
        return 1; 
    }
    Type symType = symbol-> type;
    (yyval.nodePointer) =  createTreeNode(IIDENTIFIER, symType, (Value)0, symbol->identifier, NULL, NULL, NULL);
  }
#line 1873 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 41:
#line 432 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("factor -> IntV -> %d: %d\n", (yyvsp[0].intVal), ++counter);
    #endif

    (yyval.nodePointer) = createTreeNode(IINTNUM, integer, (Value)(yyvsp[0].intVal), NULL, NULL, NULL, NULL);
  }
#line 1885 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 42:
#line 439 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("factor -> FloatV -> %f: %d\n", (yyvsp[0].floatVal), ++counter);
    #endif

    (yyval.nodePointer) = createTreeNode(IREALNUM, real, (Value)(yyvsp[0].floatVal), NULL, NULL, NULL, NULL);
  }
#line 1897 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 43:
#line 446 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("factor -> id(opt_args)\n", ++counter);
    #endif

    FunctionSymbolNode*function = findFunction((yyvsp[-3].stringVal));
    if(function != NULL) {sprintf(error, "Function %s is not declared.", (yyvsp[-3].stringVal)); yyerror(error); return 1; }

    ArgNode*args = (yyvsp[-1].argNode);
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

    TreeNode*functionNode = createTreeNode(IFUNCTION, function->type, (Value)0, function->identifier, NULL, NULL, NULL);
    functionNode->argList = args;
    (yyval.nodePointer) = functionNode;
  }
#line 1930 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 44:
#line 477 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("expression -> Smaller: %d\n", ++counter);
    #endif

    if((yyvsp[-2].nodePointer)->type != (yyvsp[0].nodePointer)->type){
      sprintf(error, "Type mismatch, type %d is not type %d", (yyvsp[-2].nodePointer)->type, (yyvsp[0].nodePointer)->type); 
      yyerror(error); 
      return 1;
    }

    (yyval.nodePointer) = createTreeNode(ISMALLER, (yyvsp[-2].nodePointer)->type, (Value)0, NULL, (yyvsp[-2].nodePointer), NULL, (yyvsp[0].nodePointer));
  }
#line 1948 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 45:
#line 490 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("expression -> Bigger: %d\n", ++counter);
    #endif

    if((yyvsp[-2].nodePointer)->type != (yyvsp[0].nodePointer)->type){
      sprintf(error, "Type mismatch, type %d is not type %d", (yyvsp[-2].nodePointer)->type, (yyvsp[0].nodePointer)->type); 
      yyerror(error); 
      return 1;
    }

    (yyval.nodePointer) = createTreeNode(IBIGGER, (yyvsp[-2].nodePointer)->type, (Value)0, NULL, (yyvsp[-2].nodePointer), NULL, (yyvsp[0].nodePointer));
  }
#line 1966 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 46:
#line 503 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("expression -> Equal: %d\n", ++counter);
    #endif

    if((yyvsp[-2].nodePointer)->type != (yyvsp[0].nodePointer)->type){
      sprintf(error, "Type mismatch, type %d is not type %d", (yyvsp[-2].nodePointer)->type, (yyvsp[0].nodePointer)->type); 
      yyerror(error); 
      return 1;
    }

    (yyval.nodePointer) = createTreeNode(IEQUAL,(yyvsp[-2].nodePointer)->type, (Value)0, NULL, (yyvsp[-2].nodePointer), NULL, (yyvsp[0].nodePointer));
  }
#line 1984 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 47:
#line 516 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("expression -> Smaller or equal: %d\n", ++counter);
    #endif

    if((yyvsp[-2].nodePointer)->type != (yyvsp[0].nodePointer)->type){
      sprintf(error, "Type mismatch, type %d is not type %d", (yyvsp[-2].nodePointer)->type, (yyvsp[0].nodePointer)->type); 
      yyerror(error); 
      return 1;
    }

    (yyval.nodePointer) = createTreeNode(ISMALLEROREQUAL,(yyvsp[-2].nodePointer)->type, (Value)0, NULL, (yyvsp[-2].nodePointer), NULL, (yyvsp[0].nodePointer));
  }
#line 2002 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 48:
#line 529 "interpreter.y" /* yacc.c:1652  */
    {
    #ifdef _PRINT_STACK_TRACE
    printf("expression -> Bigger or equal: %d\n", ++counter);
    #endif

    if((yyvsp[-2].nodePointer)->type != (yyvsp[0].nodePointer)->type){
      sprintf(error, "Type mismatch, type %d is not type %d", (yyvsp[-2].nodePointer)->type, (yyvsp[0].nodePointer)->type); 
      yyerror(error);
      return 1;
    }

    (yyval.nodePointer) = createTreeNode(IBIGGEROREQUAL,(yyvsp[-2].nodePointer)->type, (Value)0, NULL, (yyvsp[-2].nodePointer), NULL, (yyvsp[0].nodePointer));
  }
#line 2020 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 49:
#line 545 "interpreter.y" /* yacc.c:1652  */
    {
    (yyval.argNode) = (yyvsp[0].argNode);
  }
#line 2028 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 50:
#line 548 "interpreter.y" /* yacc.c:1652  */
    {
     (yyval.argNode) =  NULL;
   }
#line 2036 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 51:
#line 554 "interpreter.y" /* yacc.c:1652  */
    {
    (yyval.argNode) = createArgNode((yyvsp[-2].nodePointer), (yyvsp[0].argNode));
  }
#line 2044 "interpreter.tab.c" /* yacc.c:1652  */
    break;

  case 52:
#line 557 "interpreter.y" /* yacc.c:1652  */
    {
    (yyval.argNode) = createArgNode((yyvsp[0].nodePointer), NULL);
  }
#line 2052 "interpreter.tab.c" /* yacc.c:1652  */
    break;


#line 2056 "interpreter.tab.c" /* yacc.c:1652  */
      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;


#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif


/*-----------------------------------------------------.
| yyreturn -- parsing is finished, return the result.  |
`-----------------------------------------------------*/
yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 562 "interpreter.y" /* yacc.c:1918  */


void handleError(int code, char*message) {
  fprintf(stderr, RED"Runtime error (%d): %s\n", code, message);
  exit(1);
}

int evalExprInt(TreeNode* exprNode, HashTable* hashTable);
int evalTermInt(TreeNode* termNode, HashTable* hashTable);
int evalFactorInt(TreeNode* factorNode, HashTable* hashTable);
float evalExprFloat(TreeNode* exprNode, HashTable* hashTable);
float evalTermFloat(TreeNode* termNode, HashTable* hashTable);
float evalFactorFloat(TreeNode* factorNode, HashTable* hashTable);
int evalExpression(TreeNode* expressionNode, HashTable* hashTable);
void ifFunction(TreeNode* ifNode, HashTable* hashTable);
void thenFunction(TreeNode* thenNode, HashTable* hashTable);
void elseFunction(TreeNode* elseNode, HashTable* hashTable);
void whileFunction(TreeNode* whileNode, HashTable* hashTable);
void doFunction(TreeNode* doNode, HashTable* hashTable);
void printFunction(TreeNode* printNode, HashTable* hashTable);
void assignFunction(TreeNode* assignNode, HashTable* hashTable);
void beginFunction(TreeNode* beginNode, HashTable* hashTable);
void execFunctionFunction(TreeNode* functNode, HashTable* hashTable);
void execTree(TreeNode* root, HashTable* hashTable);

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

void readFunction(TreeNode*readNode, HashTable* hashTable) {

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

void printFunction(TreeNode*printNode, HashTable* hashTable) {
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
      #ifdef _PRINT_EXECUTION_TRACE
      printf("Something went wrong print function\n");
      exit(1);
      #endif
      break;
  }
}

int evalFactorInt(TreeNode* factorNode, HashTable* hashTable){
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
    default:
      #ifdef _PRINT_EXECUTION_TRACE
      printf("Something went wrong evalFactorInt default");
      exit(1);
      #endif
      break;
  }
}

int evalTermInt(TreeNode* termNode, HashTable* hashTable){
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

int evalExprInt(TreeNode* exprNode, HashTable* hashTable){
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

float evalFactorFloat(TreeNode* factorNode, HashTable* hashTable){
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
    default:
      #ifdef _PRINT_EXECUTION_TRACE
      printf("Something went wrong evalFactorInt default");
      exit(1);
      #endif
      break;
  }
}

float evalTermFloat(TreeNode* termNode, HashTable* hashTable){
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

float evalExprFloat(TreeNode* exprNode, HashTable* hashTable){
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

int evalExpression(TreeNode* expressionNode, HashTable* hashTable){
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
        #ifdef _PRINT_EXECUTION_TRACE
        printf("Something went wrong eval expression");
        exit(1);
        #endif
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
        #ifdef _PRINT_EXECUTION_TRACE
        printf("Something went wrong eval expression");
        exit(1);
        #endif
        break;
    }
  }
}

void ifFunction(TreeNode* ifNode, HashTable* hashTable){
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

void thenFunction(TreeNode* thenNode, HashTable* hashTable){
  execTree(thenNode->left, hashTable);
}

void elseFunction(TreeNode* elseNode, HashTable* hashTable){
  if(elseNode != NULL){
    execTree(elseNode->left, hashTable);
  }
}

void whileFunction(TreeNode* whileNode, HashTable* hashTable){
  int exrpessionRes = evalExpression(whileNode->left, hashTable);
  if(exrpessionRes){
    whileNode->right->right = whileNode;
    execTree(whileNode->right, hashTable);
  }
}

void doFunction(TreeNode* doNode, HashTable* hashTable){
  //Do stmt
  execTree(doNode->left, hashTable);
  //Check while again
  execTree(doNode->right, hashTable);
}

void beginFunction(TreeNode* beginNode, HashTable* hashTable){
  execTree(beginNode->left, hashTable);
}

void assignFunction(TreeNode* assignNode, HashTable* hashTable){
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
      #ifdef _PRINT_EXECUTION_TRACE
      printf("Something went wrong assign function");
      exit(1);
      #endif
      break;
  }
}

void execFunctionFunction(TreeNode* functionNode, HashTable* hashTable){
  FunctionSymbolNode* functionS = findFunction(functionNode->identifier);
  HashTable* newFunctTable = copySymbolTable(functionS->hashTable);
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
  execTree(functionS->syntaxTree, newFunctTable);
}

void execTree(TreeNode*root, HashTable* hashTable) {
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
    case IFUNCTION:
      execFunctionFunction(root, hashTable);
      break;
  }
}

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
    global = initTable();
    currentTable = global;
    int res = yyparse();
  
    if(!res) {
      printf(GREEN"Accepted.\n\n");

      printf(RESET"Execution output:\n");
      execTree(root, NULL);
    }

    return 0;
}

