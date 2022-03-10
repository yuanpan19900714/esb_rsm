tpath=`pwd`
if [ $# -eq 1 ]
then
tpath=$1
fi

donenet(){
index=`expr $netn + 3`
index1=`expr $index+$netnum`
ntmpf=$tpath/ntmp.tmp
echo "echo $colvalue |awk -F',' '{print \$$index}'"|sh>$ntmpf
netname=`cat $ntmpf|awk -F'-' '{print $1}'`

echo "
awk -F',' 'BEGIN{value=0;value1=0;type=\"\";str=\"net-$netname\"}
{

if(count!=0 && type!=\$1)
{
value=value/count;
value1=value1/count
str=str\",\"value\",\"value1
value=0;
count=0;
}
type=\$1;
value+=\$$index
value1+=\$$index1
count+=1;
}
END{
if(count!=0)
{
value=value/count;
value1=value1/count
}
str=str\",\"value\",\"value1;
print str}
' $tmpf 
"|sh

}

input=$tpath/net.tmp
tmpf=$tpath/tmp.tmp
output=$tpath/net_ms.tmp
echo ">>>>NET">$output
echo "netname,nrkps,nwkps,nrerr,nwerr,nprs,npws,nrsize,nwsize">>$output

colvalue=`sed -n '1p' $input`
colnum=`sed -n '1p' $input|awk -F, '{print NF-2}'`

netnum=`expr $colnum/2`

grep -v "read" $input>$tmpf

netn=0
while true
do
if [ $netn -lt $netnum ]
then
donenet >>$output
netn=`expr $netn + 1`
else
break;
fi

done 
