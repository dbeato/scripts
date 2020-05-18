#!/bin/bash

if [ `cat /usr/share/untangle/lib/untangle-libuvm-api/VERSION` != '14.0.0' ] ; then 
   echo "This patch can only be run on 14.0.0" ;
   exit 1
fi


sed -e 's/grep -q "/grep -q -F "/g' -i /lib/bridge-utils/bridge-utils.sh

systemctl restart networking

echo "Patch complete..."
