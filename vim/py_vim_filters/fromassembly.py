#!/usr/bin/env python
"""get assembly opcodes for x86

Sat Sep 21 1:43:39 PM 2019

__author__ = "Jose Lima"

"""
import sys, os, subprocess

help = """
converts assembly languate to binary opcodes

push eax
push ebx
pop esp

vim: '<'>!opcodes
cli: 'push ebx' | opcodes
"""
instructions = sys.stdin.readlines()

if not instructions:
    print(help)
    sys.exit(0)


instructions_clean = "\t" + "\t".join(x for x in instructions)

template = f"""

[BITS 32]
[SECTION .text]

global _start

_start:

{instructions_clean}
"""

nasm_code_file = "tmp.nasm"
nasm_obj_file = nasm_code_file + ".o"
nasm_bin_file = nasm_code_file + ".bin"

with open(nasm_code_file, "w") as f:
    f.write(template)


def cmd_execute(*a):
    """returns nothing..."""
    for cmd in a:
        os.system(cmd)


def cmd_execute_io(*a):
    """parse and format opcodes"""
    for cmd in a:
        cmd = cmd + " > tmp.out"
        os.system(cmd)
        with open("tmp.out") as f:
            # print("".join(x for x in f.readlines()))
            a = "".join(x for x in f.readlines())
            b = "".join("\\x" + a[x : x + 2] for x in range(0, len(a), 2))
            print('buffer += b"' + b + '"')
        os.system("rm -f tmp.out")


def cmd_objdump_io(cmd):
    """lets checkout our instructions in objdump"""
    cmd = cmd + " > tmp.out"
    os.system(cmd)
    with open("tmp.out") as f:
        print("".join("# " + x for x in f.readlines()[7:]))
    os.system("rm -f tmp.out")


# standard commands, send and forget...
cmd_compile = f"nasm -f elf32 -o {nasm_obj_file} {nasm_code_file}"
cmd_linker = f"ld -o {nasm_bin_file} {nasm_obj_file}"

cmd_execute(cmd_compile, cmd_linker)

# we need output from these...
cmd_objdump = f"objdump -d {nasm_bin_file} -M intel"
cmd_objdump_io(cmd_objdump)

cmd_to_hex = f"objdump -d {nasm_bin_file} | grep '[0-9a-f]:' | cut -d'\t' -f2 | grep -v 'file' | tr -d ' \n'"
cmd_execute_io(cmd_to_hex)

# echo "\"$(objdump -d {nasm_bin_file | grep '[0-9a-f]:' | cut -d$'\t' -f2 | grep -v 'file' | tr -d " \n" | sed 's/../\\x&/g')\""
# echo "$(objdump -d {nasm_bin_file | grep '[0-9a-f]:' | cut -d$'\t' -f2 | grep -v 'file' | tr -d " \n" )"

# cleanup
os.system(f"rm -f {nasm_code_file}")
os.system(f"rm -f {nasm_obj_file}")
os.system(f"rm -f {nasm_bin_file}")
