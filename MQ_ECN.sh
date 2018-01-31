#!/bin/bash
cd /data/app/ctlmq/WARING
file=$1
if [ -s $file ];then
    echo "mq_tunnel_check"
    cat $file 
else
    echo "succss"
fi

