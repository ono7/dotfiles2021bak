#!/usr/bin/env python
"""
2019-09-03

jlima  (ono7)

    generates bytearray.bin file and prints hex string to stdout for a ascii
    character table 1..255 this is useful to find bad characters on a payload,
    using !mona compare -f "bytearray.bin" -a 0x12345678 while mona.py has this
    functionality, it is slow to generate the arrays, copy and paste the output
    rinse and repeat. this is much faster todo in vim with this script...

    ln -sf ~/.dotfiles/py_vim_filters/bytearray.py ~/bin/byterray (chmod +x bytearray.py)

    vim usage:

        :r!bytearray "00,0a,0d"

        or

        :r!bytearray "000a0d"

"""
import sys
import struct
import binascii


# if len(sys.argv) < 2:
#     print('need to feed me bad chars to filter: bytearray "00"')
#     exit(0)

if len(sys.argv) < 2:
    bad_chars = "000a0d"
else:
    bad_chars = sys.argv[1]

if "," in bad_chars:
    bad_chars = bad_chars.strip()
    bad_chars = bad_chars.split(",")
    bad_chars = [x for x in bad_chars if len(x) == 2]
else:
    bad_chars = bad_chars.strip()
    bad_chars = bad_chars.replace("'", "")
    bad_chars = bad_chars.replace('"', "")
    bad_chars = [bad_chars[i : i + 2] for i in range(0, len(bad_chars), 2)]
    bad_chars = [x for x in bad_chars if len(x) == 2]

# defaults
default_bad_chars = ["00", "0a", "0d"]

for c in default_bad_chars:
    if c not in bad_chars:
        bad_chars.append(c)

# full ascii table
byte_array = b"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
byte_array += b"\x20\x21\x22\x23\x24\x25\x26\x27\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f\x30\x31\x32\x33\x34\x35\x36\x37\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f"
byte_array += b"\x40\x41\x42\x43\x44\x45\x46\x47\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f\x50\x51\x52\x53\x54\x55\x56\x57\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f"
byte_array += b"\x60\x61\x62\x63\x64\x65\x66\x67\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f\x70\x71\x72\x73\x74\x75\x76\x77\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f"
byte_array += b"\x80\x81\x82\x83\x84\x85\x86\x87\x88\x89\x8a\x8b\x8c\x8d\x8e\x8f\x90\x91\x92\x93\x94\x95\x96\x97\x98\x99\x9a\x9b\x9c\x9d\x9e\x9f"
byte_array += b"\xa0\xa1\xa2\xa3\xa4\xa5\xa6\xa7\xa8\xa9\xaa\xab\xac\xad\xae\xaf\xb0\xb1\xb2\xb3\xb4\xb5\xb6\xb7\xb8\xb9\xba\xbb\xbc\xbd\xbe\xbf"
byte_array += b"\xc0\xc1\xc2\xc3\xc4\xc5\xc6\xc7\xc8\xc9\xca\xcb\xcc\xcd\xce\xcf\xd0\xd1\xd2\xd3\xd4\xd5\xd6\xd7\xd8\xd9\xda\xdb\xdc\xdd\xde\xdf"
byte_array += b"\xe0\xe1\xe2\xe3\xe4\xe5\xe6\xe7\xe8\xe9\xea\xeb\xec\xed\xee\xef\xf0\xf1\xf2\xf3\xf4\xf5\xf6\xf7\xf8\xf9\xfa\xfb\xfc\xfd\xfe\xff"

byte_array_list = [x for x in bytearray(byte_array)]


def filter_out(bad_chars, byte_array):
    """filter out bad characters from byte_array_list"""
    for i in bad_chars:
        i = int(i, 16)
        if i in byte_array:
            byte_array.remove(i)
    return byte_array


def hex_to_string(byte_array_list):
    """return a new string from list of ascii integers"""
    my_string = 'byte_array = "'
    for i in byte_array_list:
        encoded = "\\x"
        encoded += "%02x" % i
        my_string += encoded
    return my_string + '"'


print("# bytearray bad chars: ", "\\x" + "\\x".join(x for x in bad_chars))
print(hex_to_string(filter_out(bad_chars, byte_array_list)))

with open("bytearray.bin", "wb") as f:
    for byte in filter_out(bad_chars, byte_array_list):
        f.write(struct.pack("B", byte))
