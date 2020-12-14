#!/usr/bin/env python
"""returns a spike ready template from a line(s)

Sat Sep 21 1:43:39 PM 2019

__author__ = "Jose Lima"

"""
import sys, re

lines = sys.stdin.readlines()


for line in lines:
    line = re.split(r"(\s+)", line.strip())
    # line = line.split()
    for word in line:
        print(f's_string("{word}");')
    print(f's_string("\\r\\n");')
    print("\n")
