FLEX=flex
BISON=bison
CC=gcc

PROGRAM = interpreter
LEX = interpreter.l
PARSER = interpreter.y

compile: 	
	$(FLEX) $(LEX)
	$(BISON) -d -t $(PARSER)
	$(CC) $(CFLAGS) libs/*.c *.c -lfl -o $(PROGRAM).out 

clean:
	rm -f *.out $(PROGRAM).tab.h $(PROGRAM).tab.c lex.yy.c
