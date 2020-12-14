#!/usr/bin/env python
"""

Sun Sep 8 3:20:26 PM 2019

__author__ = "Jose Lima"

"""

import sys
import struct
import binascii

52 49 46 46 90 00 00 00 41 43 4F 4E 61 6E 69 68
24 00 00 00 24 00 00 00 02 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 01 00 00 00 61 6E 69 68 58 00 00 00
41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41
41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41
00 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41
41 41 41 41 41 41 41 41 41 41 41 41 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
42 42 42 42 43 43 43 43

with open("my.bin", "wb") as f:
    for byte in filter_out(bad_chars, byte_array_list):
        f.write(struct.pack("B", byte))
