/* Carlos Augusto Amador Manilla A01329447 */
/* Angel Roberto Ruiz Mendoza A01324489 */

#include "definitions.h"
#include "symbolTable.h"
#include "syntaxTree.h"
#include "functionStack.h"

void initStack(){
    stack = (FunctionStack*)malloc(sizeof(FunctionStack));
    stack->head = NULL;
    stack->tail = NULL;
}

FunctionStackNode*createFunctionStackNode(char*identifier, Value val){
    FunctionStackNode* temp = (FunctionStackNode*)malloc(sizeof(FunctionStackNode));
    temp->identifier = identifier;
    temp->returnVal = val;
    temp->next = NULL;
    return temp;
}

void push(char*identifier, Value val){
    FunctionStackNode* temp = createFunctionStackNode(identifier, val);
    if(stack->head == NULL){
        stack->head = temp;
        stack->tail = temp;
    }
    else{
        stack->tail->next = temp;
        stack->tail = stack->tail->next;
    }
}

FunctionStackNode* pop(){

    FunctionStackNode* temp = stack->tail;
    if(stack->tail == NULL){
        return NULL;
    }
    if(stack->tail == stack->head){
        stack->tail = NULL;
        stack->head = NULL;
        return temp;
    }
    FunctionStackNode* i = stack->head;
    while (i->next != stack->tail);
    {
        i = i->next;
    }
    i->next = NULL;
    stack->tail = i;
    
    return temp;
}

FunctionStackNode* peak(){
    return stack->tail;
}

void printFunctionStack(){
    printf("Function Stack\n");
    FunctionStackNode* i = stack->head;
    while(i != NULL){
        printf("ID: %s, ReturnValInt: %d, ReturnValFloat: %f", i->identifier, i->returnVal.intV, i->returnVal.realV);
        i = i->next;
    }
}