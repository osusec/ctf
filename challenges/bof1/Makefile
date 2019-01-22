CC=gcc
C_FLAGS=-fno-stack-protector -z execstack

EXE=bof1

all: $(EXE)

$(EXE): $(EXE).c
	$(CC) $(C_FLAGS) -o $(EXE) $(EXE).c

clean:
	rm -rf *.o *dsym $(EXE)
