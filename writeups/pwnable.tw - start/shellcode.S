#include <sys/syscall.h>

.globl	main
.type	main, @function

main:
//execve("//bin/sh", 0, 0)
xor %eax, %eax
mov $0x0b, %al
xor %ecx, %ecx
xor %edx, %edx
push %edx
push $0x68732f6e
push $0x69622f2f
mov %esp, %ebx
int $0x80
