Carlos Augusto Amador Manilla
Compiladores
Tarea 5

Instrucciones de compilado

Ejecutar los siguientes comandos:
    $ bison -d compiler.y
    $ flex compilar.l
    $ gcc lex.yy.c compiler.tab.c symbolTable.c -lfl

Posteriormente, ejecutar pasando como parametro el archivo con el código fuente.
    $ ./a.out tests/test.txt