tpath=`pwd`
if [ $# -eq 1 ]
then
tpath=$1
fi

donedisk(){
index=`expr $diskn + 3`
echo "
awk -F',' 'BEGIN{value=0;type=\"\";str=\"hdisk$diskn\"}
{

if(count!=0 && type!=\$1)
{

value=value/count;
str=str\",\"value
value=0;
count=0;
}
type=\$1;
value+=\$$index
count+=1;
}
END{
if(count!=0)
{
value=value/count;
}
str=str\",\"value;
print str}
' $tmpf 
"|sh

}

input=$tpath/disk.tmp
tmpf=$tpath/disk_tmp.tmp
output=$tpath/disk_ms.tmp
echo ">>>>DISK">$output
echo "diskname,kps,busy,read,write,xferr">>$output

maxdisk=`sed -n '1p' $input|awk -F, '{print NF-2}'`

grep -v "hdisk" $input |grep -v "DISKRXFER">$tmpf

diskn=0
while true
do
if [ $diskn -lt $maxdisk ]
then
donedisk >>$output
diskn=`expr $diskn + 1`
else
break;
fi

done 
