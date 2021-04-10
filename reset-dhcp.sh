#!/bin/vbash
run=/opt/vyatta/bin/vyatta-op-cmd-wrapper

# Set port to reset
PORT='eth8'

IP=$(/sbin/ifconfig $PORT | grep 'inet addr' | cut -d: -f2 | awk '{print $1}')
NETWORK=${IP%%.*}

if [ "$NETWORK" = 192 ]
then
  echo 'resetting DHCP ...'
  $run renew dhcp interface eth0
  echo 'done'
  exit 0
else
  echo 'reset DHCP not needed ... exiting'
  exit 1
fi
