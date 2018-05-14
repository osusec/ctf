## Get Address for an Environment Variable

Based on code from [here](https://bt3gl.github.io/smashing-the-stack-for-fun-or-wargames-narnia-0-4.html)

#### Compile

For 32-bit binaries, do `make 32`. For 64-bit binaries, do `make 64`.

#### Usage

`./getaddr [variable name] [path to binary]`

Make sure to run the target binary with the same path as you specify to `getaddr`, otherwise the offsets won't be calculated correctly and the resulting address will be wrong.

Also, please put your data in the environment variable before running `getaddr`, otherwise the offset may be incorrect.
