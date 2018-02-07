
(cd /data/app/deploy_prod/pkg/uab/20180207 ;ls) | while read line
do
    ansible $line -m copy -a "src=/data/app/deploy_prod/pkg/uab/20180207/$line/ dest=/data/app/app/"
done
