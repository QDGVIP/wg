#!/bin/sh
################################

################################
function install() {
	centos=`cat /etc/redhat-release`
    XT=`cat /etc/redhat-release | awk '{print $3}'| cut -b1`
	CPU=$(grep 'model name' /proc/cpuinfo |uniq |awk -F : '{print $2}' |sed 's/^[ \t]*//g' |sed 's/ \+/ /g') 
	H=`cat /proc/cpuinfo | grep "physical id" | sort | uniq | wc -l`
	HX=`cat /proc/cpuinfo | grep "core id" |wc -l`
	DD=`df -h /`
    W=`getconf LONG_BIT`
	G=`awk '/MemTotal/{printf("%1.1fG\n",$2/1024/1024)}' /proc/meminfo`

echo -e "\033[1;33m===================================服务器配置===================================\033[0m"
echo -e "\033[1;32m                 系统版本：$centos   $W 位 \033[0m"
echo -e "\033[1;32m                 CPU 型号：${CPU} \033[0m"
echo -e "\033[1;32m                 CPU核心：$HX核  \033[0m"
echo -e "\033[1;32m                 运行内存：$G     \033[0m"
echo -e "\033[1;33m==================================硬盘使用情况==================================\033[0m"
echo -e "\033[1;32m$DD\033[0m"
echo -e "\033[1;33m================================================================================\033[0m"
echo -e ""
echo -e "\033[1;33m网关默认数据库密码为uu5!^%jg启动不成功请确认你的数据库密码是否为uu5!^%jg不对请修改/root/config.ini                             \033[0m"

echo -e "\033[1;33m==================================硬盘使用情况==================================\033[0m"

echo -e "\033[1;33m                           回车键安装网关by化神期大能                             \033[0m"

	read
	service0
	
}
cd /
reset
rm -rf /1.sh
rm -rf /root/1.sh
function service0() {


		service1

}
	
function service1() {
    	echo -e "${Info}正在清理PHP环境   ${Load}"
	yes y | head -1 | yum remove -y php php-* httpd httpd-* >/dev/null 2>&1
	yum remove -y php* >/dev/null 2>&1
	yum remove -y httpd* >/dev/null 2>&1
	rm -rf /etc/httpd
	rm -rf /opt/lampp/htdocs/*
	rm -rf /var/www/html;
	echo -e "${Tip}PHP环境清理成功! ${Success}"
	sleep 1s
	service2
}




function service2() {
	echo -e "${Info}正在安装PHP环境   ${Load}"
	yum install -y php-gd* php php-mysql openssl httpd php-mysql >/dev/null 2>&1
	sed -i "/Listen 80/a\Listen 735" ${conf} >/dev/null 2>&1
	sed -i "/#ServerName www.example.com:80/a\ServerName localhost:80" ${conf} >/dev/null 2>&1
	chkconfig httpd on
	echo -e "${Tip}PHP环境安装成功! ${Success}"
	sleep 1s
	echo -e "${Tip}正在重启PHP       ${Load}"
	fuser -k -n tcp 80 >/dev/null 2>&1
	fuser -k -n tcp 735 >/dev/null 2>&1
	service httpd start
	echo -e "${Tip}PHP启动完成!     ${Success}"
	service3
}

function service3() {
    
		echo -e " "
		echo -e "${Info}正在安装网关   ${Load}"
		cd /
		curl -O https://gitee.com/qwlvip/wg/raw/330dd902a31e1955f3806962bbb5cd9d562c01e0/1.tar.gz
	
		tar -vxf /1.tar.gz
		
		echo -e "\033[1;33m安装完成\033[0m"
		chmod -R 777 /root
		rm -rf /1.tar.gz
		cd /root
		./Restart
		echo -e "${Tip}正在启动网关!     ${Success}"
		

}
install
