Carlos Augusto Amador Manilla A01329447
Angel Roberto Ruiz Mendoza A01324489

Compiladores

Final Proyect

Compilation instructions

Execute the following command to compile the project:
    $ make compile

To compile with debug flags use the following command:
    $ make compile FLAGS="FLAG_1 FLAG_2"

Available debug compilation flags
-D_PRINT_PARSE_TRACE
-D_PRINT_SYMBOL_TABLES
-D_PRINT_SYNTAX_TREES
-D_PRINT_FUN_CALLS

To run the program, set the path to the text file as parameter:
    $ ./interpeter.out tests/test.txt