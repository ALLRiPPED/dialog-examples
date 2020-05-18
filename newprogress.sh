#!/bin/bash
#source ip_config_v1.sh
export NCURSES_NO_UTF8_ACS=1
# These symbols are defined to use in the sample shell scripts to make them
# more readable.  But they are (intentionally) not exported.  If they were
# exported, they would also be visible in the dialog program (a subprocess).


export NCURSES_NO_UTF8_ACS=1
: ${DIALOG=dialog}

: ${DIALOG_OK=0}
: ${DIALOG_CANCEL=1}
: ${DIALOG_HELP=2}
: ${DIALOG_EXTRA=3}
: ${DIALOG_ITEM_HELP=4}
: ${DIALOG_ESC=255}

: ${SIG_NONE=0}
: ${SIG_HUP=1}
: ${SIG_INT=2}
: ${SIG_QUIT=3}
: ${SIG_KILL=9}
: ${SIG_TERM=15}

# Test an IP address for validity:
# Usage:
#      valid_ip IP_ADDRESS
#      if [[ $? -eq 0 ]]; then echo good; else echo bad; fi
#   OR
#      if valid_ip IP_ADDRESS; then echo good; else echo bad; fi
#

echo $IP1

ip_add=$(ip -f inet a show eth0 | grep inet| awk '{print $2}' | cut -d/ -f1)
sub_add=$(ifconfig | grep -wns eth0 -A 1 | tail -1 | awk '{print $5}')
dns_add=$(systemd-resolve --status | grep -A4 'DNS Servers' | grep -v  'DNS Domain' | cut -d ':' -f2 | head -3 |  xargs | sed -e 's/ /,/g')
gateway_add=$(ip r | grep eth0  | awk '{print $3}'  | head -1)
<<END
for i in $(seq 1 100)
                do
                sleep 10.0
                    echo $i
        if [ !  -f /var/tmp/tmpps ]; then
                i=98;
#		echo -e "\n        Please access the URL in web browser to continue. ${YELLOW}https://$IP1/ie-clp/${NONE}"
#		 "$DIALOG"  --clear --no-lines  --backtitle "$backtitle" \
#       --no-collapse --cr-wrap \
#           --msgbox "Please use: https://$ipaddress/ie-clp \nto access Cisco CX Collector" 10 50


		break;
        fi

	done | "$DIALOG" --colors --clear --no-collapse  --keep-tite  --keep-window  --title '\Zn\Z4 Cisco CX Collector Setup \Zn\Z4' --gauge  '
       Configuration is in progress...

       This step will take 8-10 minutes to complete.

      \Zn\Z1 Do not power off the machine until this process is completed.' 12 90 0

#"$DIALOG"  --clear --no-lines --title '\Zn\Z4 Cisco CX Collector Setup \Zn\Z4' --colors  --backtitle "$backtitle" \
 #    --no-collapse --cr-wrap \
#	--msgbox "The network configuration has been successfully
#completed.

#Please access Cisco CX Collector User Interface from a
#browser using the below URL to continue

#https://$ip_add:30003/ieui/" 12  80

IP1=$(ifconfig | grep -A1 -P 'eth' | grep inet | awk '{print $2}')
END

connection_checkup()
{
ls $> /dev/null
#curl -k https://$IP1/ie-commonapi/services/version | grep "CX Collector is reachable" >/dev/null 2>&1
if [[ ( $?  -eq  0 ) || ( $CN -eq 100 ) || ( -f /var/tmp/tmpps1 ) ]]; then
#dialog --msgbox  "CISCO COLLECTOR HAS INSTALLED AND PODS ARE RUNNING" 10  55
touch /var/tmp/tmpps1

#bash dnac4 

while true
do
bash regstatuscheck.sh &
bash regstokengeneration.sh

if [ ! -f "$FILE" ]; then
 
"$DIALOG" \
                         --clear \
                         --nook \
                         --no-ok \
                         --nocancel \
                         --no-cancel \
                         --msgbox " REGISTRATION SUCCESSFUL" 18 93


kill -HUP $PPID

break
fi

done




<<NOOO
if [ ! -z $dns_add ]; then
# "$DIALOG"  --colors  --title '\Zb\Z4 Cisco CX Collector Setup \Zb\Z4'  \
#      --no-collapse --cr-wrap \
 #        --msgbox "
while true
do
#api call
echo $(date +%s | base64 | cut -b 11-15) > /opt/cisco/init/RegToken
key=$(cat /opt/cisco/init/RegToken)

"$DIALOG" --title  '\Zb\Z4 Cisco CX Collector Setup \Zb\Z4' \
        --nook \
        --nocancel \
        --colors \
        --shadow \
        --cr-wrap \
        --pause "
      The network configuration has been successfully completed.

      Collector IP  : $ip_add \n
      Subnet Mask   : $sub_add \n
      Gateway       : $gateway_add \n
      DNS Server    : $dns_add \n

      The registration token is $key
                  \Zu\Z2 Token will be valid for 5 minutes \ZU\Zn
  \Z1 Time left in seconds... \Zn
      " 18 93 300

    retval=$?

     case $retval in
        $DIALOG_CANCEL)
                FILE=/var/tmp/dummy.txt
                if [ ! -f "$FILE" ]; then

                        echo "$FILE does not exist"
                        "$DIALOG" \
                         --clear \
                         --nook \
                         --no-ok \
                         --nocancel \
                         --no-cancel \
                         --msgbox " REGISTRATION SUCCESSFUL" 18 93

                        break

                else

                retval=99

                fi
                ;;

        $DIALOG_OK)
                FILE=/var/tmp/dummy.txt
                if [ ! -f "$FILE" ]; then

                 echo "$FILE does not exist"


                 "$DIALOG" \
                         --clear \
                         --nook \
                         --no-ok \
                         --nocancel \
                         --no-cancel \
                         --msgbox " REGISTRATION SUCCESSFUL" 18 93
                  break
                  else


                "$DIALOG" \
                --clear \
                --colors \
                --no-collapse \
                --cr-wrap \
                --ok-label "Regenerate" \
                --backtitle "Registration Token Expired"  \
                --msgbox " \Z1 Registration Token Expired \Zn

      The network configuration has been successfully completed.

      Collector IP  : $ip_add
      Subnet Mask   : $sub_add
      Gateway       : $gateway_add
      DNS Server    : $dns_add
      To Regenerate the registration token PRESS key <Regenarate>
      " 17 93

      fi

      ;;
    esac
done

kill -HUP $PPID

 else

while true

do
echo $(date|base64) > /opt/cisco/init/RegToken
key=$(cat /opt/cisco/init/RegToken)

"$DIALOG" --title  '\Zb\Z4 Cisco CX Collector Setup \Zb\Z4' \
        --nook \
        --nocancel \
        --colors \
        --shadow \
        --cr-wrap \
        --pause "
      The network configuration has been successfully completed.

      Collector IP  : $ip_add \n
      Subnet Mask   : $sub_add \n
      Gateway       : $gateway_add \n

      The registration token is $key
                  \Zu\Z2 Token will be valid for 5 minutes \ZU\Zn
  \Z1 Time left in seconds... \Zn
      " 18 93 300

    retval=$?
      
      case $retval in
        $DIALOG_CANCEL)
                FILE=/var/tmp/dummy.txt
                if [ ! -f "$FILE" ]; then

                        echo "$FILE does not exist"
                        "$DIALOG" \
                         --clear \
                         --nook \
                         --no-ok \
                         --nocancel \
                         --no-cancel \
                         --msgbox " REGISTRATION SUCCESSFUL" 18 93

                        break

                else

                retval=99

                fi
                ;;

        $DIALOG_OK)
                FILE=/var/tmp/dummy.txt
                if [ ! -f "$FILE" ]; then

                 echo "$FILE does not exist"


                 "$DIALOG" \
                         --clear \
                         --nook \
                         --no-ok \
                         --nocancel \
                         --no-cancel \
                         --msgbox " REGISTRATION SUCCESSFUL" 18 93
                  break
                  else


                "$DIALOG" \
                --clear \
                --colors \
                --no-collapse \
                --cr-wrap \
                --ok-label "Regenerate" \
                --backtitle "Registration Token Expired"  \
                --msgbox " \Z1 Registration Token Expired \Zn

      The network configuration has been successfully completed.

      Collector IP  : $ip_add
      Subnet Mask   : $sub_add
      Gateway       : $gateway_add
      DNS Server    : $dns_add
      To Regenerate the registration token PRESS key <Regenarate>
      " 17 93

      fi

      ;;
    esac
     
done

kill -HUP $PPID

 fi

NOOO

else
#sleep  40;
#let "CN++";
#connection_checkup
dialog --msgbox  "The initialization of the CX Collector failed.

Please redeploy the VM/OVA or contact your network team/ CISCO support team.
" 10 68
fi
}
connection_checkup


hideinput()
{
  if [ -t 0 ]; then
     stty -echo -icanon time 0 min 0
  fi
}

cleanup()
{
  if [ -t 0 ]; then
    stty sane
  fi
}

trap cleanup EXIT
trap hideinput CONT
hideinput
n=0
while [  -f /var/tmp/dummy.txt ] ;
do
  read line
  sleep 90
  echo -n " "
  n=$[n+1]
done

connection_checkup


hideinput()
{
  if [ -t 0 ]; then
     stty -echo -icanon time 0 min 0
  fi
}

cleanup()
{
  if [ -t 0 ]; then
    stty sane
  fi
}

trap cleanup EXIT
trap hideinput CONT
hideinput
n=0
while [  -f /var/tmp/dummy.txt ];
do
  read line
  sleep 90
  echo -n " "
  n=$[n+1]
done
