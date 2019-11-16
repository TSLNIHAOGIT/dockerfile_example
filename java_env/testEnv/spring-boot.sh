#./bin/sh
#
#set JAVA HOME
#export JAVA_HOME=/opt/java/jdk1.8.0_171
APP_DIR=/ai/raw_files/server_package
APP_NAME=cisdi-program-3.0.jar
APP_MAIN_CLASS=com.amiintellect.cisdi.program.App
BACKUP_FILE=$AMIINTELLECT_HOME/backup/com.amiintellect.cisdi.28090
PID_FILE=$APP_DIR/http.pid

usage() {
	echo "Usage: spring-boot.sh [start|stop|restart|status|backup|pid]"
	exit 1
}

kills() {
	if [ -f "$PID_FILE" ]; then
		tpid=$(cat $PID_FILE | awk '{print $1}')
		tpid=$(ps -aef | grep $tpid | awk '{print $2}' | grep $tpid)
		#tpid=`ps -ef|grep $APP_NAME|grep -v grep|grep -v kill|awk '{print $2}'`
		if [[ $tpid ]]; then
			echo 'Kill Process.'
			kill -9 $tpid
		fi
		rm -f $PID_FILE
	fi
}

start() {
	if [ -f "$PID_FILE" ]; then
		echo App is running.
	else
		cd ${APP_DIR}
		# 设置默认权限 文件夹 755 文件 644
		umask 0022
		
		today=$(date "+%Y%m%d")
		minute=$(date "+%H%M")
		cp -p log/console.log log/console-$today$minute.log

		java -Xms256M -Xmx512M -cp .:$APP_NAME:lib/* $APP_MAIN_CLASS >log/console.log 2>&1 

		echo $! >$PID_FILE
		echo Start Success.
	fi
}

restart() {
	# 杀掉当前进程
	kills
  # 启动程序
	start
}

stop() {
	tpid=$(cat $PID_FILE | awk '{print $1}')
	# tpid1=`ps -ef|grep $APP_NAME|grep -v grep|grep -v kill|awk '{print $2}'`
	tpid1=$(ps -aef | grep $tpid | awk '{print $2}' | grep $tpid)
	# echo tpid1-$tpid1
	if [[ $tpid1 ]]; then
		echo 'Stop Process...'
		kill -15 $tpid1
	fi
	sleep 5
	tpid2=$(ps -aef | grep $tpid | awk '{print $2}' | grep $tpid)
	# tpid2=`ps -ef|grep $APP_NAME|grep -v grep|grep -v kill|awk '{print $2}'`
	# echo tpid2-$tpid2
	if [[ $tpid2 ]]; then
		echo 'Kill Process.'
		kill -9 $tpid2
	else
		echo 'Stop Success.'
	fi
	rm -f $PID_FILE
}

status() {
	tpid=$(cat $PID_FILE | awk '{print $1}')
	tpid=$(ps -aef | grep $tpid | awk '{print $2}' | grep $tpid)
	# tpid=`ps -ef|grep $APP_NAME|grep -v grep|grep -v kill|awk '{print $2}'`
	if [[ $tpid ]]; then
		echo 'App is running.'
	else
		echo 'App is NOT running.'
	fi
}

backup() {
	today=$(date "+%Y%m%d")
	minute=$(date "+%H%M")
	tar -zcvf $BACKUP_FILE-$today-$minute.tar.gz * --exclude=backup --exclude=log --exclude=uploads --exclude=http.pid --exclude=nohup.out
}

pid() {
	ps -ef | grep "$APP_NAME" | grep -v grep
}

case "$1" in
"start")
	start
	;;
"stop")
	stop
	;;
"kill")
	kills
	;;
"restart")
	restart
	;;
"status")
	status
	;;
"backup")
	backup
	;;
"pid")
	pid
	;;
*)
	usage
	;;
esac
