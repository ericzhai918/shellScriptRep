cd /data/app/deploy_prod/change
ls | while read line
do
    cat ${line} | grep 10.* > ${line}
done
