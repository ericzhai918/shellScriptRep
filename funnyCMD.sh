
#列出tar.gz文件的内容
tar tf file.tgz

#只提取tar.gz中的一个文件filename
tar xf file.tgz filename

#按照文件大小列出文件
ls -lS
#按照文件大小列出文件(大在下)
ls -lSr
#按照文件更改时间列出文件
ls -lt
#按照文件更改时间列出文件（新在下）
ls -ltr

#显示文件的完整路径
readlink -f file.txt

#!$表示上一次使用的路径
cd !$

#反转文件内容
rev filename.txt

#火车头动画
sl

#小牛(其他动物)会说话
cowsay
