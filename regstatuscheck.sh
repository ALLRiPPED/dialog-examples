while true
do

FILE=/var/tmp/dummy.txt
sleep 5
if [ ! -f "$FILE" ]; then
#sleep 5
ps aux | grep -i regstokengeneration.sh  | awk {'print $2'} | xargs kill -9 &> /dev/null
break
fi

done


