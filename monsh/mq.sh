tpath=`pwd`
if [ $# -eq 1 ]
then
tpath=$1
fi

tmpfile=$tpath/mq.tmp

$JAVA_HOME/bin/java com.dcfs.esb.rsm.client.GetMOMData "127.0.0.1:7799" $tmpfile