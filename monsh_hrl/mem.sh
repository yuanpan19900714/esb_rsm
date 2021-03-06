tpath=`pwd`
if [ $# -eq 1 ]
then
tpath=$1
fi

input=$tpath/mem.tmp
output=$tpath/mem_ms.tmp
echo ">>>>MEM">$output
echo "rfree,vfree,rfmb,vfmb,rtmb,vtmb">>$output
grep "^MEM,T" $input|awk -F, '
BEGIN{
  rfree=0;
  vfree=0;
  rfmb=0;
  vfmb=0;
  rtmb=0;
  vtmb=0;
  count=0;
}
{
  rfmb+=$7+$12+$15;
  vfmb+=$10;
  rtmb+=$3;
  vtmb+=$6;
  count+=1;
}
END{
  rfree=rfree/count;
  vfree=vfree/count;
  rfmb=rfmb/count;
  vfmb=vfmb/count;
  rtmb=rtmb/count;
  vtmb=vtmb/count;
  rfree=rfmb/rtmb*100;
  vfree=vfmb/vtmb*100;

print rfree","vfree","rfmb","vfmb","rtmb","vtmb;
}'>>$output
