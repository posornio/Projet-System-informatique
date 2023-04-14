GRM=lex.y
LEX=lex.l
BIN=lex

CC=gcc
CFLAGS=-Wall -g

OBJ=lex.tab.o lex.yy.o tableSymbole.o

all: $(BIN)

%.o: %.c
	$(CC) -c $(CFLAGS) $<

lex.tab.c: $(GRM)
	bison -d $<

lex.yy.c: $(LEX)
	flex $<

$(BIN): $(OBJ)
	$(CC) $(CFLAGS) $^ -o $@

clean:
	rm $(OBJ) lex.tab.c lex.tab.h lex.yy.c

build : lex.y lex.l
	bison -t -v -d lex.y
	flex lex.l
	gcc -o lex lex.tab.c lex.yy.c 

test2 :
	cat example.c | ./lex