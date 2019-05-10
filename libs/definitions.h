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

typedef enum {IPROGRAM, IFUNCTION, IIDENTIFIER, IBEGIN, IEND, ILET, IINTEGER, IREAL, IIF, ITHEN, IELSE, IWHILE, IDO, IREAD, IPRINT, ISEMICOLON, IPLUS, IMINUS, IASTERISK, ISLASH, IPARENTHESIS, ICPARENTHESIS, IINTNUM, IREALNUM, ISMALLER, IBIGGER, IEQUAL, ISMALLEROREQUAL, IBIGGEROREQUAL, IDOT, ICOLON, IBRACKET, ICBRACKET, IASSIGNMENT, IRETURN} 
    Instruction;

typedef enum {integer, real, null} Type;

typedef union {
    int intV;
    float realV;
} Value;

/**
 * Structs definitions
*/
typedef struct ArgNode ArgNode;
typedef struct SymbolNode SymbolNode;
typedef struct DeclNode DeclNode;
typedef struct TreeNode TreeNode;
typedef struct ParamNode ParamNode;
typedef struct ArgNode ArgNode;
typedef struct HashTable HashTable;
typedef struct FunctionSymbolNode FunctionSymbolNode;
typedef struct FunctionCallNode FunctionCallNode;

typedef struct SymbolNode {
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

struct FunctionStackNode {
    char* identifier;
    Value returnVal;
    struct FunctionStackNode* next;
};

struct FunctionCallNode {
    struct TreeNode*treeNode;
    FunctionCallNode*next;
};

struct FunctionStack{
    struct FunctionStackNode* head;
    struct FunctionStackNode* tail;
};


/**
 * Methods
*/
int hash(char*c); // makes simple hash with the identifier string
#endif