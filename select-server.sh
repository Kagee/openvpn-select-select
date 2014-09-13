#! /bin/bash
SERVERLIST="serverlist.conf"
if [ "$1" != "" ]; then
SERVERLIST=$1
fi 
HOSTNAME=$(cat $SERVERLIST | \
zenity --list --title "Choose VPN server" \
--text "Choose the VPN server to connect through:                                                                " \
--column "Continent" --column "Country" --column "City" --column "Address" --print-column=4 \
 2>/dev/null | cut -d'|' -f1)
if [ "${HOSTNAME}" != "" ]; then
MSG=$(grep -B 3 $HOSTNAME $SERVERLIST | head -3 | \
awk 'FNR == 1 {C=$0} FNR == 2{ printf "%s, %s, ", C,$0 } END{print $0 }') 
zenity --question --title="Verify VPN server" \
--text="Are you sure you wish to connect to:\n$HOSTNAME\n($MSG)"
echo $?
else
echo "Didn't select a server, assume cancel"
fi
