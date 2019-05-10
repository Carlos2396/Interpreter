/* Carlos Augusto Amador Manilla A01329447 */
/* Angel Roberto Ruiz Mendoza A01324489 */

#include "definitions.h"

int hash(char*c) {
    int sum = 0;
    while((*c) != '\0') {
        sum += *c;
        c++;
    }

    return sum%SIZE;
}