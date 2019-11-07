# /bin/sh
#此脚本是用来自动重启aps-spark的jar包的 监测到没有aps的进程就会进行启动操作
while true
do
	apsThread=`ps -ef |grep aps.jar |grep -v 'grep'`
	echo $apsThread
	apscount=`ps -ef |grep aps.jar |grep -v 'grep'|wc -l`
	echo $apscount
	log=aps-`date +%Y-%m-%d`.log

	if [ $apscount -eq 0 ]
        then
		echo "start aps.jar"
		cd /opt/jars/
		pwd
		source /etc/profile
		# nohup spark-submit aps.jar >> $log &
	    spark-submit /opt/jars/aps.jar
	else
		echo "aps runing........"
	fi
	sleep 60
done