#define BUFFER 20

#include <stdio.h>
#include <stdlib.h>

int main() {
	unsigned int flag = 0x12345678;
	char input[BUFFER];

	puts("Welcome to the CTF my dude: ");

	fgets(input, BUFFER*2, 0);

	if (flag == 0xdeadbeef) {
		puts("You win!");
		system("/bin/sh");
	} else {
		puts("Good try");
	}
}
