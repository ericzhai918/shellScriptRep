#!/bin/bash
source /etc/profile
changeIP=`/sbin/ip a|awk -F'[ /]' '{if($0 ~ /10\./ )print $6}'`
sed -i "s/{{\$LOCALIP}}/$changeIP/"  /data/app/app/bpfRO_batch/conf/server.xml
sed -i "s/{{\$LOCALIP}}/$changeIP/"  /data/app/app/bpfRO_batch/bin/startup.sh
cat  /data/app/app/bpfRO_batch/conf/server.xml /data/app/app/bpfRO_batch/bin/startup.sh | grep $changeIP
