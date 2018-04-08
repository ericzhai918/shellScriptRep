
Files="/data/app/deploy_prod/0408test/test.txt /data/app/deploy_prod/0408test/test1.txt"

for _file in $Files;do cp ${_file}{,`date +%F_%s`};done

sed -i 's#10.20.30.40:10020#10.21.33.44:10#' $Files
sed -i 's#10.10.30.40:10020#10.11.33.44:10#' $Files

egrep "10.21.33.44|10.11.33.44" $Files

