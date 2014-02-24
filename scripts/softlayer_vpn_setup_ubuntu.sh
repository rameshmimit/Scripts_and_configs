#!/bin/bash

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
else
  echo  "Enter the softlayer VPN username:\t"
  read VPNNAME

cat > /etc/ppp/peers/sl << "EOF"
# written by pptpsetup
#pty "pptp pptpvpn.sea01.softlayer.com --nolaunchpppd"
#pty "pptp pptpvpn.wcd01.softlayer.com --nolaunchpppd"
pty "pptp pptpvpn.dal01.softlayer.com --nolaunchpppd"
lock
noauth
nobsdcomp
nodeflate
name XXXXXX
remotename sl
ipparam sl
require-mppe-128
EOF

cat > /etc/ppp/resolv.conf << "EOF"
search sl.ss
#nameserver 10.17.111.10
nameserver 10.17.111.12
nameserver 8.8.8.8
EOF

sed -i "s/XXXXXX/$VPNNAME/g" /etc/ppp/peers/sl

# check whether softlayer related information is there in chap-secrets
  if grep ^[a-z] /etc/ppp/chap-secrets |awk '{print $2}'|grep -x sl; 
  then 
    echo "It looks like there is already a entry with name 'sl' already there..Quitting now.. Remove it from file" 1>&2
    exit 1
  fi
echo "Enter the softlayer VPN password:\t"
read -s VPNPASS
echo "$VPNNAME   sl     '$VPNPASS'    *" >> /etc/ppp/chap-secrets

#yay! looks like it is configured..

echo "/sbin/route add -net 10.0.0.0 netmask 255.0.0.0 dev \$PPP_IFACE" >> /etc/ppp/ip-up
echo "cp /etc/resolv.conf /etc/resolv.conf-orig" >> /etc/ppp/ip-up
echo "cp /etc/ppp/resolv.conf /etc/resolv.conf" >> /etc/ppp/ip-up

echo "cp /etc/resolv.conf-orig /etc/resolv.conf" >> /etc/ppp/ip-down

echo  "You Should be able to use Softlayer VPN using the following Commands\n"
echo  " pon sl => Start VPN\t"
echo  "poff sl => Stop VPN\t"

fi
