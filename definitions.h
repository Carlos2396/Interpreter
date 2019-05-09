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

typedef enum {IPROGRAM, IIDENTIFIER, IBEGIN, IEND, ILET, IINTEGER, IREAL, IIF, ITHEN, IELSE, IWHILE, IDO, IREAD, IPRINT, ISEMICOLON, IPLUS, IMINUS, IASTERISK, ISLASH, IPARENTHESIS, ICPARENTHESIS, IINTNUM, IREALNUM, ISMALLER, IBIGGER, IEQUAL, ISMALLEROREQUAL, IBIGGEROREQUAL, IDOT, ICOLON, IBRACKET, ICBRACKET, IASSIGNMENT} 
    Instruction;

typedef enum {integer, real, null} Type;

typedef union {
    int intV;
    float realV;
} Value;

/**
 * Structs definitions
*/
typedef struct SymbolNode {
    char*identifier;
    Type type;
    Value val;  
    struct SymbolNode*next;
} SymbolNode;

typedef struct listNode {
    char*identifier;
    struct listNode*next;
} LLNode;

typedef struct TreeNode {
    Instruction instruction;
    Type type;
    Value val;  
    SymbolNode* symbolTableNode;
    struct TreeNode* left;
    struct TreeNode* center;
    struct TreeNode* right;
} TreeNode;

#endif