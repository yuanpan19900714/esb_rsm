tpath=`pwd`
if [ $# -eq 1 ]
then
tpath=$1
fi

printproc()
(
if [ "$procms" = "" ]
then
ms="$procnm,-,-,-,-,0,0,0,0,1"
else
ms=$procnm,`echo $procms|cat |awk '{print $1","$2","$9","$10","$3","$4","$5","$6",0"}'`
fi
echo $ms >>$tpath/proc.tmp
)

ps gueww> $tpath/myproc.tmp 

export myproc=$tpath/myproc.tmp


echo ">>>>PROC">$tpath/proc.tmp
echo "pname,puser,pid,stime,rtime,cpu,mem,sz,rss,flag">>$tpath/proc.tmp

procnm=接入容器
procms=`grep "com.dc.esb.startup.standalone.ESBStartup IN" $myproc`
printproc

procnm=控制台
procms=`grep "com.dc.esb.startup.standalone.ESBStartup CONSOLE" $myproc`
printproc

procnm=接出容器
procms=`grep "com.dc.esb.startup.standalone.ESBStartup OUT" $myproc`
printproc

procnm=流水服务
procms=`grep "com.dc.esb.startup.standalone.ESBStartup JOURNAL" $myproc`
printproc

procnm=流控服务
procms=`grep "com.dc.esb.startup.standalone.ESBStartup FLOW" $myproc`
printproc

procnm=核心路由
procms=`grep "com.dc.esb.startup.standalone.ESBStartup ROUTER" $myproc`
printproc
