today=`date +%Y%m%d`
timeStamp=`date +%Y%m%d_%s`
#停服
function stopSystem(){
    ip=$1
    if [[ ${ip}=="mgmt_wgq" ]] || [[ ${ip}=="mweb_wgq" ]] || [[ ${ip}=="paygate_wgq" ]]; then
        ansible ${ip} -m shell -a "source /etc/profile && cd /data/app/app/apache-tomcat-7.0.73/bin && sh shutdown.sh "
    elif [[ ${ip}="online_wgq" ]]; then
    	ansible ${ip} -m shell -a "source /etc/profile && source /data/app/app/.bash_profile && cd /data/app/app/script && sh onlineshutdown.sh"
    elif [[ ${ip}="10.20.44.81" ]]; then
        ansible ${ip} -m shell -a "source /etc/profile && source /data/app/app/.bash_profile && cd /data/app/app/script/process && sh batchshutdown.sh"
    else
        return 1
    fi
}
#检查进程状态
function checkSystem(){
    ip=$1
    if [[ `echo ${ip}|grep mgmt` ]] || [[ `echo ${ip}|grep mweb` ]] || [[ `echo ${ip}|grep paygate` ]]; then
        ansible ${ip} -m shell -a "ps -ef | grep tomcat"
    elif [[ `echo ${ip}|grep online` ]]; then
	ansible ${ip} -m shell -a "ps -ef | grep online"
    elif [[ `echo ${ip}|grep epay` ]]; then
	ansible ${ip} -m shell -a "ps -ef | grep process"
    else
        return 1
    fi
}
#备份文件
function backup(){
    ip=$1
    case ${ip} in
    "mgmt" )
        ansible ${ip} -m shell -a "cd /data/app/app/apache-tomcat-7.0.73/webapps && tar zcf /data/app/app/package/mgmt${timeStamp}.tgz mgmt && ls -lt /data/app/app/package/mgmt${timeStamp}.tgz" 
	;;
    "mweb" )
	ansible ${ip} -m shell -a "cd /data/app/app/apache-tomcat-7.0.73/webapps && tar zcf /data/app/app/package/mweb${timeStamp}.tgz mweb && ls -lt /data/app/app/package/mweb${timeStamp}.tgz"
	;;
    "paygate" )
	ansible ${ip} -m shell -a "cd /data/app/app/apache-tomcat-7.0.73/webapps && tar zcf /data/app/app/package/paygate${timeStamp}.tgz paygate && ls -lt /data/app/app/package/paygate${timeStamp}.tgz"
	;;
    "online" )
	ansible ${ip} -m shell -a "cd /data/app/app && tar zcf /data/app/app/package/online${timeStamp}.tgz online && ls -lt /data/app/app/package/online${timeStamp}.tgz"
	;;
    "epay" )
	ansible ${ip} -m shell -a "cd /data/app/app && tar zcf /data/app/app/package/epay${timeStamp}.tgz epay && ls -lt /data/app/app/package/epay${timeStamp}.tgz"
	;;
    * )
        echo "你输入的机器组不在host列表中"
	;;
esac
}
#检查备份文件是否成功
function checkBackup(){
    ip=$1
    if [[ ${ip}=="mgmt" ]] || [[ ${ip}=="mweb" ]] || [[ ${ip}=="paygate" ]] || [[ ${ip}="online" ]] || [[ ${ip}=="epay" ]]; then
         ansible ${ip} -m shell -a "ls -lt /data/app/app/package"
    fi  
}

function _copyFile(){
    ip=$1
    dfa=$2
    if [[ ${ip}=="mgmt" ]] || [[ ${ip}=="mweb" ]] || [[ ${ip}=="paygate" ]]; then
	ansible ${ip}_${dfa} -m copy -a "src=/data/app/deploy_prod/pkg/uab/${today}/${ip}/${dfa}/ dest=/data/app/app/apache-tomcat-7.0.73/webapps/"
    elif [[ ${ip}="online" ]] || [[ ${ip}=="epay" ]]; then
	ansible ${ip}_${dfa} -m copy -a "src=/data/app/deploy_prod/pkg/uab/${today}/${ip}/${dfa}/ dest=/data/app/app/"
    else
	return 1
    fi
}
#传输文件
function copyFile(){
    ip=$1
    [ -z "$2"] && dfa="all" || dfa="$2"
    case ${dfa} in
    	"wgq" )
            _copyFile "${ip}" "wgq"
    	;;
    	"zp" )
            _copyFile "${ip}" "zp"
    	;;
    	"all" )
            _copyFile "${ip}" "wgq"
            _copyFile "${ip}" "zp"
    	;;       
    esac
}
#检查传输文件
function checkCopy(){
    ip=$1
    if [[ ${ip}=="mgmt" ]] || [[ ${ip}=="mweb" ]] || [[ ${ip}=="paygate" ]]; then
	ansible ${ip} -m shell -a "ls -lt /data/app/app/apache-tomcat-7.0.73/webapps"
    elif [[ ${ip}="online" ]] || [[ ${ip}=="epay" ]]; then
 	ansible ${ip} -m shell -a "ls -lt /data/app/app"
    else
	return 1
    fi
}
#启服
function startSystem(){
    ip=$1
    if [[ ${ip}=="mgmt_wgq" ]] || [[ ${ip}=="mweb_wgq" ]] || [[ ${ip}=="paygate_wgq" ]]; then
        ansible ${ip} -m shell -a "source /etc/profile && cd /data/app/app/apache-tomcat-7.0.73/bin && nohup sh startup.sh &"
    elif [[ ${ip}="online_wgq" ]]; then
    	ansible ${ip} -m shell -a "source /etc/profile && source /data/app/app/.bash_profile && cd /data/app/app/script && nohup sh online.sh &"
    elif [[ ${ip}="10.20.44.81" ]]; then
        ansible ${ip} -m shell -a "source /etc/profile && source /data/app/app/.bash_profile && cd /data/app/app/script/process && nohup sh process.sh &"
    else
        return 1
    fi
}

#停服5个子系统
function stopAll(){
    ansible mgmt_wgq -m shell -a "killall java"
    ansible mweb_wgq -m shell -a "killall java"
    ansible paygate_wgq -m shell -a "killall java"
    ansible online_wgq -m shell -a "killall java"
    ansible 10.20.44.81 -m shell -a "killall java"
}

#启动五个子系统
function startAll(){
    ansible mgmt_wgq -m shell -a "source /etc/profile && cd /data/app/app/apache-tomcat-7.0.73/bin && nohup sh startup.sh &"
    ansible mweb_wgq -m shell -a "source /etc/profile && cd /data/app/app/apache-tomcat-7.0.73/bin && nohup sh startup.sh &"
    ansible paygate_wgq -m shell -a "source /etc/profile && cd /data/app/app/apache-tomcat-7.0.73/bin && nohup sh startup.sh &"
    ansible online_wgq -m shell -a "source /etc/profile && source /data/app/app/.bash_profile && cd /data/app/app/script && nohup sh online.sh &"
    ansible 10.20.44.81 -m shell -a "source /etc/profile && source /data/app/app/.bash_profile && cd /data/app/app/script/process && nohup sh process.sh &"
}

$1 $2 $3
