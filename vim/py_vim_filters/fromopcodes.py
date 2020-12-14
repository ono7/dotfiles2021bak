#!/usr/bin/env python
"""get assembly opcodes for x86

Sat Sep 21 1:43:39 PM 2019

__author__ = "Jose Lima"

"""
import sys, os, subprocess

help = """
converts binary x86 opcodes to assembly

50535c

   0:   50                      push   eax
   1:   53                      push   ebx
   2:   5c                      pop    esp

vim: '<'>!assemble
cli: '50535c' | assemble
"""
opcodes = sys.stdin.readlines()


opcodes_clean = "".join(x for x in opcodes)


if len(opcodes_clean) < 2:
    print(help)
    exit(0)


def cmd_execute_io(cmd, opcodes):
    """lets checkout our instructions in objdump"""
    cmd = cmd + " > tmp.out"
    os.system(cmd)
    with open("tmp.out") as f:
        print(f"# opcode: {opcodes_clean}")
        print("".join("# " + x for x in f.readlines()[7:]))
    os.remove("tmp.out")
    os.remove("a.out")


cmd_opcodes = f'echo "0:{opcodes_clean}" | xxd -r -p | tee a.out | objdump -D -Mintel,i386 -b binary -m i386'

cmd_execute_io(cmd_opcodes, opcodes_clean)
