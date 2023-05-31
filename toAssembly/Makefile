GRM=lex.y
LEX=lex.l
BIN=lex
SRCDIRECT=asm

CC=gcc
CFLAGS=-Wall -g

OBJ=lex.tab.o lex.yy.o tableSymbole.o asm.o

all: $(BIN)

%.o: %.c
	$(CC) -c $(CFLAGS) $<

%.o : $(SRCDIRECT)/%.c
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

lex.tab.c: $(GRM)
	bison -d $<

lex.yy.c: $(LEX)
	flex $<

$(BIN): $(OBJ)
	$(CC) $(CFLAGS) $^ -o $@

asmTest: $(ASMTESTS)
	$(CC) $(CFLAGS) $(CPPFLAGS) $^ -o $@
	./$@

clean:
	rm $(OBJ) lex.tab.c lex.tab.h lex.yy.c

build : lex.y lex.l
	bison -t -v -d lex.y
	flex lex.l
	gcc -o lex lex.tab.c lex.yy.c 

test2 :
	cat test3.c | ./lex