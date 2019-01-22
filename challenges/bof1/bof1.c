#define BUFFER 20

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
	unsigned int flag = 0x12345678;
	char input[BUFFER];

	puts("Welcome to the CTF my dude: ");

    memset(input, 0, BUFFER);
	fgets(input, BUFFER*2, stdin);

	if (flag == 0xdeadbeef) {
		puts("You win!");
		system("/bin/sh");
	} else {
		puts("Good try");
	}
}
