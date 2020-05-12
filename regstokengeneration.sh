#source progress.sh
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

dns_add=$(systemd-resolve --status | grep -A4 'DNS Servers' | grep -v  'DNS Domain' | cut -d ':' -f2 | head -3 |  xargs | sed -e 's/ /,/g')

if [ ! -z $dns_add ]
   
then


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
