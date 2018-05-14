#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char* argv[]) {
    if (argc != 3) {
        printf("usage: ./%s [var] [binary]", argv[0]);
        return 1;
    }

    char* ptr = getenv(argv[1]);
    ptr += (strlen(argv[0]) - strlen(argv[2])) * 2;

    printf("var at %p\n", ptr);

    return 0;
}
