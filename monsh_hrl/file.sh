tpath=`pwd`
if [ $# -eq 1 ]
then
tpath=$1
fi

filename=$tpath/file.tmp

echo ">>>>FILE" > $filename 
echo "filename,totsize,freesize,usedpct,iusedsize,iusedpct" >> $filename 
df -mP |grep '^/'|grep '%'|awk '{print $6","$2","$4","$5",0,0"}'>>$filename
