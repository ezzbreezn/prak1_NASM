all: program
program: main.o functions.o test.o
	gcc -m32 -o program main.o functions.o test.o -lm
main.o: main.c library.h
	gcc -m32 -c -o main.o main.c
functions.o: functions.asm
	nasm -f elf32 -o functions.o functions.asm
funclist.o: funclist.c
	gcc -m32 -c -o funclist.o funclist.c 
test.o:
	gcc -m32 -c -o test.o test.c
clean:
	rm -f main.o functions.o funclist.o test.o
