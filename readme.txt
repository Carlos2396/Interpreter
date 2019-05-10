Carlos Augusto Amador Manilla
Angel Roberto Ruiz Mendoza

Compiladores
Tarea 6

Instrucciones de compilado

Ejecutar los siguientes comandos:
    $ bison -d compiler.y
    $ flex compiler.l
    $ gcc implementations/*.c *.c -lfl

Available debug compilation tags
-D_PRINT_PARSE_TRACE
-D_PRINT_SYMBOL_TABLES
-D_PRINT_FUN_CALLS
-D__PRINT_EXECUTION_TRACE

Posteriormente, ejecutar pasando como parametro el archivo con el código fuente.
    $ ./a.out tests/test.txt