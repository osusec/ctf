CC=gcc
out=getaddr

all:
	@echo "Please specify 'make 32' or 'make 64'"

32: getaddr.c
	gcc -m32 -o $(out) getaddr.c

64: getaddr.c
	gcc -m64 -o $(out) getaddr.c

clean:
	$(RM) $(out)
