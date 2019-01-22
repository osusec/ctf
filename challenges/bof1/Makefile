CC=gcc
C_FLAGS=-fno-stack-protector -z execstack -m32

EXE=bof1

all: clean $(EXE)

$(EXE): $(EXE).c
	$(CC) $(C_FLAGS) -o $(EXE) $(EXE).c

debug: clean
	$(CC) $(C_FLAGS) -g -o $(EXE) $(EXE).c

clean:
	rm -rf *.o *dsym $(EXE)
