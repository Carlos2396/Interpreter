#include "../libs/definitions.h"

int hash(char*c) {
    int sum = 0;
    while((*c) != '\0') {
        sum += *c;
        c++;
    }

    return sum%SIZE;
}