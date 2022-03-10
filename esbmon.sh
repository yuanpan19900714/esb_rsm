export endstr="<<<<END"
export rpath=`pwd`
osname=`uname -a|awk '{print toupper($1)}'`
if [ $osname = "AIX" ];then
export spath=$rpath/monsh
else
export spath=$rpath/monsh_hrl
fi
export PATH=$PATH:$spath
export tpath=$rpath/tmp
export mpath=$rpath/monms

aptype=`echo $appname |cut -b1-2`

echo "start mon:"`date +"%Y%m%d %H:%M:%S"`
ms_time=`date +%Y%m%d%H%M`
ms_date=`date +%Y%m%d`
mkdir $mpath/$ms_date  1>/dev/null 2>/dev/null
ms_file=$mpath/$ms_date/esb_ms_$ms_time.txt
echo ">>>>$appname,$ms_time,$ms_file" >$ms_file 

sh $spath/nmon.sh $tpath
sh $spath/file.sh $tpath
sh $spath/proc.sh $tpath
sh $spath/cpu.sh $tpath
sh $spath/net.sh $tpath
sh $spath/mem.sh $tpath
sh $spath/disk.sh $tpath

if [ "$aptype" = "AP" ]
then
sh $spath/mom.sh $tpath
sh $spath/esbPool.sh $tpath/pool_ms.tmp $appname
echo "aptype is AP"
fi

if [ "$aptype" = "DB" ]
then
sh $spath/db.sh
fi

cat $tpath/cpu_ms.tmp>>$ms_file
cat $tpath/mem_ms.tmp>>$ms_file
cat $tpath/disk_ms.tmp>>$ms_file
cat $tpath/net_ms.tmp>>$ms_file
cat $tpath/file.tmp>>$ms_file
cat $tpath/proc.tmp>>$ms_file

if [ "$aptype" = "AP" ]
then
cat $tpath/mom.tmp>>$ms_file

echo ">>>><esb_pool>" >>$ms_file
cat $tpath/pool_ms.tmp>>$ms_file
echo "</esb_pool>" >>$ms_file

echo "aptype is AP"
fi
echo "<<<<END">>$ms_file

sh $spath/send.sh $monserver $ms_file

echo "finish mon:"`date +"%Y%m%d %H:%M:%S"`
