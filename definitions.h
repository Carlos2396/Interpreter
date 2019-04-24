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
 * Unions and Enums definitions
*/

typedef enum {IPROGRAM, IIDENTIFIER, IBEGIN, IEND, ILET, IINTEGER, IREAL, IIF, ITHEN, IELSE, IWHILE, IDO, IREAD, IPRINT, ISEMICOLON, IPLUS, IMINUS, IASTERISK, ISLASH, IPARENTHESIS, ICPARENTHESIS, IINTNUM, IREALNUM, ISMALLER, IBIGGER, IEQUAL,  IDOT, ICOLON, IBRACKET, ICBRACKET, IASSIGNMENT} 
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