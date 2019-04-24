Carlos Augusto Amador Manilla
Angel Roberto Ruiz Mendoza

Compiladores
Tarea 6

Instrucciones de compilado

Ejecutar los siguientes comandos:
    $ bison -d compiler.y
    $ flex compiler.l
    $ gcc *.c -lfl

Posteriormente, ejecutar pasando como parametro el archivo con el código fuente.
    $ ./a.out tests/test.txt