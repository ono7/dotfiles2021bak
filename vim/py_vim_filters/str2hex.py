#!/usr/bin/env python2

import sys


lines = sys.stdin.readlines()

for i in lines:
    i = i.strip()
    print i
    print i.encode('hex').strip()
