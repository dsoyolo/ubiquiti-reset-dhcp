#!/bin/vbash
run=/opt/vyatta/bin/vyatta-op-cmd-wrapper

# Set port to reset
PORT='eth8'

IP=$(/sbin/ifconfig $PORT | grep 'inet' | cut -d: -f2 | awk '{print $2}')
NETWORK=${IP%%.*}

if [ "$NETWORK" = 192 ]
then
  echo Resetting DHCP...
  $run renew dhcp interface $PORT
  echo Done.
else
  echo DHCP reset not needed.
fi
