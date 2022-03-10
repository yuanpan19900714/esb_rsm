export rpath=`pwd`
export mpath=$rpath/monms

while true
do 
	start_tm=`date +%s`
	sh esbmon.sh 
	stop_tm=`date +%s`
	stime=`expr $stop_tm - $start_tm`
	stime=`expr 15 - $stime`
	echo "sleep time is $stime second"

	sleep $stime

	rm -rf $rpath/nohup.out
	rm -rf $mpath/*

done
