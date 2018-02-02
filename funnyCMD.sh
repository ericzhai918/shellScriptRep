
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
