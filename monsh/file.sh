tpath=`pwd`
if [ $# -eq 1 ]
then
tpath=$1
fi

filename=$tpath/file.tmp

echo ">>>>FILE" > $filename 
echo "filename,totsize,freesize,usedpct,iusedsize,iusedpct" >> $filename 
df -m |grep '^/'|grep '%'|awk '{print $1","$2","$3","$4","$5","$6}'>>$filename
