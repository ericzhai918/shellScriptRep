#!/bin.sh

cd /data/app/app
hasTomcat=`ls | grep tomcat|wc -l`
#如果/data/app/app下面有tomcat则查询web.xml文件中readonly的数量
if [ ${hasTomcat} -gt 0 ]
   then
      tomcatPath=`ls | grep tomcat`
      times=`more /data/app/app/${tomcatPath}/conf/web.xml | grep -o readonly|wc -l`
      if [ ${times} -gt 1 ]
       then
          echo  `ifconfig |grep inet |grep -v inet6 | grep -v 127.0.0.1|awk '{print $2}'`
      fi
else
#若/data/app/app下面没有tomcat，进入/data/app下面
    cd /data/app
      tomcatPath=`ls | grep tomcat`
      times=`more /data/app/${tomcatPath}/conf/web.xml | grep -o readonly|wc -l`
      if [ ${times} -gt 1 ]
       then
          echo  `ifconfig |grep inet |grep -v inet6 | grep -v 127.0.0.1|awk '{print $2}'`
      fi
fi
  


