HOSTNAME=$(echo "next
Next server in list
prev
Same as last time"  | cat - serverlist.conf | \
zenity --list --title "Choose VPN server" \
--text "Choose the VPN server to connect through:" \
--column "device" --column "Name" --print-column=1 \
--hide-column=1 2>/dev/null | cut -d'|' -f1)
echo $HOSTNAME
NEXT=$(head -1 serverlist.conf)
PREV=$(tail -2 serverlist.conf)
echo "pre serverllist"
MSG=$(grep -A 1 $HOSTNAME serverlist.conf | \
tr '\n' '\t' | \
sed -e 's/\t/ (/' -e 's/\t/)/')
echo "post serverlist"
zenity --question --title="Verify VPN server" \
--text="Are you sure you wish to connect to:\n$MSG"
echo $?
#0 = true 1 = false
