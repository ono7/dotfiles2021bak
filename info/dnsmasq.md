# dnsmasq (macos)

## services

* run as root (sudo) and it will auto start on reboot

sudo brew services restart dnsmasq

## troubleshoot


sudo brew services stop dnsmasq
sudo /usr/local/Cellar/dnsmasq/2.82/sbin/dnsmasq --no-daemon --log-queries
