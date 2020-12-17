#!/usr/bin/env python2

import sys, re


lines = sys.stdin.readlines()

for i in lines:
    i = i.strip()
    # reverse line
    print(i[::-1])
