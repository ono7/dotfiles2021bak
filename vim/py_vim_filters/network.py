#!/usr/bin/env python3

import sys, re
from ipaddress import IPv4Interface, IPv4Network


def my_network(ip):
    info = []
    interface = IPv4Interface(ip)
    network = IPv4Network(ip, False)
    super_net = interface.network.with_prefixlen.strip()
    # netmask
    netmask = interface.network.with_netmask.split("/")[1]
    host_start = network[1]
    host_end = network[-2]
    # bitmask
    # info.append(interface.network.with_hostmask.split("/")[1])
    # info.append("size: " + str(network.num_addresses))
    # info.append(f"hosts: {network[1]} - {network[-2]}")
    # return ipaddress.ip_network(ip.group(), False)
    return f"| SUPER {super_net} | { netmask } | hosts: { host_start}-{host_end}"


lines = sys.stdin.readlines()

for i in lines:
    i = i.strip()
    network_re = re.compile(r"\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\/\d{1,2}")
    # re search looks for match anywhere in line
    network = network_re.search(i)
    if network:
        print(i, my_network(network.group()))
    else:
        print(i)
