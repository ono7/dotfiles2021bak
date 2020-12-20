# dnsmasq (macos)

## services

* run as root (sudo) and it will auto start on reboot

sudo brew services restart dnsmasq

## view cache stats using dig

   dig +short chaos txt cachesize.bind
   dig +short chaos txt hits.bind
   dig +short chaos txt misses.bind
