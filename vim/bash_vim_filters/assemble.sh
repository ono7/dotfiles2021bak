#!/bin/bash

# reads opcodes eb07 (jmp 0x7) and prints its cpu instructions for x86
# use echo "eb07" | opcodes.sh

read opcodes

echo $opcodes
echo ' '
echo "$(echo "0:$opcodes" | xxd -r -p | tee a.out | objdump -D -Mintel,i386 -b binary -m i386 | tail -n +4)"

echo $var
rm -f a.out
