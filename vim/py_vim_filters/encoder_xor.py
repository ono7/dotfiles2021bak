#!/usr/bin/env python2
"""
returns xor encoded shellode, looks for a encoder key unique in the sequence..

tested on python 2.7.3

Sat Aug 3 11:56:01 PM 2019

todo:
    check for bad chars..
    python3 support

"""
shellcode = ""

byte_array_list = [x for x in bytearray(shellcode)]


def find_key(shellcode, hex_key=0xAA):
    # recursively look for a encoding key that does not exist
    # in the shellcode sequence, this is requirement to encode with XOR
    if hex_key not in shellcode:
        encoded2 = "0x"
        encoded2 += "%02x" % hex_key
        return hex_key, encoded2
    else:
        # increase base hex key by 1 until we find something suitable to use
        return find_key(shellcode, hex_key + 0x1)


def shell_xor_encoder(shellcode, hex_key):
    encoded = ""
    encoded2 = ""
    key = hex_key
    for x in bytearray(shellcode):
        # XOR encoding
        y = x ^ key
        encoded += "\\x"
        encoded += "%02x" % y

        encoded2 += "0x"
        encoded2 += "%02x," % y
    return (encoded, encoded2)


key, key_str = find_key(byte_array_list)
encoded, encoded2 = shell_xor_encoder(shellcode, key)

print(encoded)
print(encoded2)

print("len: %d, key: %s" % (len(bytearray(shellcode)), str(key_str)))
