/* Carlos Augusto Amador Manilla A01329447 */
/* Angel Roberto Ruiz Mendoza A01324489 */

#ifndef DEFINITIONS
#define DEFINITIONS

#include <string.h>
#include <stdlib.h>
#include <stdio.h>

/**
 * values definitions
*/
#define RESET   "\x1b[0m"
#define RED     "\x1b[31m"
#define GREEN   "\x1b[32m"
#define YELLOW  "\x1b[33m"
#define BLUE    "\x1b[34m"
#define MAG     "\x1b[35m"
#define CYAN    "\x1b[36m"
#define SIZE    32507

/**
 *  Errors 
*/
#define IDENTIFIER_NOT_FOUND_ERROR          100
#define UNEXPECTED_INT_VALUE_ERROR          101
#define UNEXPECTED_REAL_vALUE_ERROR         102
#define DATA_TYPE_MISMATCH_ERROR            103
#define MISSING_IDENTIFIER_ERROR            104
#define MISSING_SYMBOL_TABLE_NODE_ERROR     105

#define IDENTIFIER_NOT_FOUND_ERROR_MESSAGE          "The identifier does has not been declared."
#define UNEXPECTED_INT_VALUE_ERROR_MESSAGE          "Unexpected integer value."
#define UNEXPECTED_REAL_VALUE_ERROR_MESSAGE         "Unexpected real value."
#define DATA_TYPE_MISMATCH_ERROR_MESSAGE            "Data type mismatch."
#define MISSING_IDENTIFIER_ERROR_MESSAGE            "Missing identifier."
#define MISSING_SYMBOL_TABLE_NODE_ERROR_MESSAGE     "Missing symbol."

/**
 * Unions and Enums definitions
*/

//Enum that represent the instruction to be executed in the exectree
typedef enum {IPROGRAM, IFUNCTION, IIDENTIFIER, IBEGIN, IEND, ILET, IINTEGER, IREAL, IIF, ITHEN, IELSE, IWHILE, IDO, IREAD, IPRINT, ISEMICOLON, IPLUS, IMINUS, IASTERISK, ISLASH, IPARENTHESIS, ICPARENTHESIS, IINTNUM, IREALNUM, ISMALLER, IBIGGER, IEQUAL, ISMALLEROREQUAL, IBIGGEROREQUAL, IDOT, ICOLON, IBRACKET, ICBRACKET, IASSIGNMENT, IRETURN} 
    Instruction;

//Enum that represent the type of an expr, null is for the tree nodes that aren't an expr, term or factor.
typedef enum {integer, real, null} Type;

//Union to store both ints and floats 
typedef union {
    int intV;
    float realV;
} Value;

/**
 * Structs definitions
*/
typedef struct ArgNode ArgNode; //Linked list to store arguments before insterting them into the symbol table
typedef struct SymbolNode SymbolNode; //Linked list of sysmbols that are stored in the hash table
typedef struct DeclNode DeclNode; //Linked list to store declarations before inserting them into the symbol table
typedef struct TreeNode TreeNode; //Node of the execution tree, this node is multipourpuse that is wgy it has type, val, identifier and argList, every instruction can be represented with this node just nullyfy the attributes that are nit used.
typedef struct ParamNode ParamNode; //Linked list to store declarations before inserting them into the symbol table and in the funtion symbol table
typedef struct HashTable HashTable; //Struct that has both the hash table and its list of symbols to be inserted 
typedef struct FunctionSymbolNode FunctionSymbolNode; //Hash table for the functions

struct SymbolNode {
    char*identifier;
    Type type;
    Value val;  
    struct SymbolNode*next;
};

struct DeclNode {
    char*identifier;
    struct DeclNode*next;
};

struct TreeNode {
    Instruction instruction;
    Type type;
    Value val;  
    char*identifier;
    struct ArgNode*argList;
    struct TreeNode* left;
    struct TreeNode* center;
    struct TreeNode* right;
};

struct ParamNode {
    char*identifier;
    Type type;
    struct ParamNode*next;
};

struct ArgNode {
    struct TreeNode*syntaxTree;
    struct ArgNode*next;
};

struct HashTable {
    struct SymbolNode** table;
    struct DeclNode* remaining;
};

struct FunctionSymbolNode {
    char*identifier;
    Type type;
    struct TreeNode*syntaxTree;
    struct SymbolNode**hashTable;
    struct ParamNode*paramsList;
    struct FunctionSymbolNode*next;
};

/**
 *  Global Variables 
*/
TreeNode*root; // root of the main program syntax tree
SymbolNode**globalTable; //The main symbol table with global variables, when using a variable the second thing to do is search it here
SymbolNode**currentTable; //Local table to be used in the functions, when using a variable the first thing to do is search it here
FunctionSymbolNode*currentFunction; //The node od the function hash table that is currently being used, this to make the declaration of parameters easier
Value returnValue; //Value that is going to be returned in the function that is currently being executed
extern int lines; // line counter
extern FILE* yyin; // input file

/**
 * Methods
*/
int hash(char*c); // makes simple hash with the identifier string

#endif
