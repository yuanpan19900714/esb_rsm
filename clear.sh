export rpath=`pwd`
export mpath=$rpath/monms
echo "开始执行清理进程。。。"
while true
do
hour=`date +%H`
if [ "$hour" = "01" ]
then
    echo "[`date`]start clear monms data!"
    cd $mpath
    if [ $? -eq 0 ]
    then
        echo "[`date`]this path is `pwd`"
        ls |grep -v `date +%Y%m%d`|xargs rm -rf $1
        echo "[`date`]clear ok!"
    else 
        echo "[`date`]this path is `pwd`"
        echo "[`date`]clear fail!"
    fi
else
    sleep 3600
fi
done