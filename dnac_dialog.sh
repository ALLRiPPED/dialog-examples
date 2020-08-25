#! /bin/sh
# $Id: form1,v 1.15 2011/10/04 23:36:53 tom Exp $

#. ./setup-vars
: "${DIALOG=dialog}"

: "${DIALOG_OK=0}"
: "${DIALOG_CANCEL=1}"
: "${DIALOG_HELP=2}"
: "${DIALOG_EXTRA=3}"
: "${DIALOG_ITEM_HELP=4}"
: "${DIALOG_ESC=255}"

: "${SIG_NONE=0}"
: "${SIG_HUP=1}"
: "${SIG_INT=2}"
: "${SIG_QUIT=3}"
: "${SIG_KILL=9}"
: "${SIG_TERM=15}"

#DIALOG_ERROR=254
#export DIALOG_ERROR

function dnac()
{
returncode=0
count=1

while test $returncode != 1 && test $returncode != 250
do

function dnac1()
{
exec 3>&1
value=`$DIALOG --ok-label "Add"  --no-cancel  --cr-wrap  \
          --title "Begin Cisco DNA Center[$count] Configuration "  \
          --insecure "$@"  --colors \
          --mixedform "

(Use \Zn\Z4Up\Zn/\Zn\Z4Down\Zn keys to navigate to next field. Press \Zn\Z4Tab \Znto jump to\Zn\Z4 <Add>)     
\n
" \
15 65 0 \
        "IP/Fqdn          :"      1 1    ""  1 20 40 0 0 \
        "Username         :"      3 1    ""  3 20 40 0 0 \
        "Password         :"      5 1    ""  5 20 40 0 1 \
2>&1 1>&3`
returncode=$?
l=$returncode
exec 3>&-
val=($value)
a=${val[0]}
b=${val[1]}
c=${val[2]}
#d=${val[3]}

}


function dnac2()
{
exec 3>&1
value=`$DIALOG --ok-label "Add"  --cancel-label "Back"  --cr-wrap  \
          --title "Begin Cisco DNA Center[$count] Configuration "  \
          --insecure "$@"  --colors \
          --mixedform "

(Use \Zn\Z4Up\Zn/\Zn\Z4Down\Zn keys to navigate to next field. Press \Zn\Z4Tab \Znto jump to\Zn\Z4 <Submit> or <Continue>\Zn button)     
\n
" \
15 65 0 \
        "IP/Fqdn          :"      1 1    ""  1 20 40 0 0 \
        "Username         :"      3 1    ""  3 20 40 0 0 \
        "Password         :"      5 1    ""  5 20 40 0 1 \
2>&1 1>&3`
returncode=$?
l=$returncode
exec 3>&-
val=($value)
a=${val[0]}
b=${val[1]}
c=${val[2]}
#d=${val[3]}

}





if [ $count -lt 2 ]
then
    dnac1

else
    dnac2
fi



if [  $returncode -eq $DIALOG_CANCEL ]
then

check 

fi


if [  $returncode -eq $DIALOG_OK ]

then


if [ -z $c  ]
then


"$DIALOG" \
                --clear \
                --title "Cisco DNA Center" --no-collapse --cr-wrap --ok-label "Back" \
                --msgbox "
Please Fill Again as data is not provided in all the field" 07 63
returncode=99





else

#API CALL
export KUBECONFIG=/root/.kube/config
ieservice=$(kubectl get service ie-commonapi | awk '{print $3}' | tail -n 1)
export ieservice=$(kubectl get service ie-commonapi | awk '{print $3}' | tail -n 1)

curl -s  -k -X POST "http://$ieservice:9090/ie-commonapi/internal/addControllers" --header 'Content-Type: application/json' --data-raw '[{"ipAddress": "'$a'", "type": "DNAC", "username": "'$b'", "password": "'$c'", "protocol": "https", "port" : "443"}]' &> statusmsg

cat statusmsg | grep   "Configurations saved"


if [ $? -ne 0 ]

then
       "$DIALOG" \
                --clear \
                --title "Cisco DNA Center is not reachable " --no-collapse --cr-wrap --ok-label "Back" \
                --msgbox "
 Please check the DNS configuration, credentials, verify the details and try again" 07 90


        returncode=99

else

####API##
#count=1
echo "" >> tt
echo DNAC$count >> tt
#echo $a >> tt
#echo $b >> tt
#echo $d >> tt
count=$((count+1))
fi
fi
        #case $returncode in
if [ $returncode -eq $DIALOG_OK ]
        #$DIALOG_OK)
 then

	 function check()
	 {	 

                "$DIALOG" --clear --title "Cisco DNA Center " --no-collapse --cr-wrap  --yes-label "Add more DNA Center"   --no-label "Continue Registration" \
                --yesno "
Successfully Added Cisco DNA Center Configurations.
[$a]" 07 60

                case $? in
                $DIALOG_OK)
                         returncode=99
                        ;;
                $DIALOG_CANCEL)
                       # total=$(cat tt | grep -c DNAC)


                        exit 0
                        ;;
                esac
	}

check 

fi
fi




done
}

rm -rf tt
dnac
