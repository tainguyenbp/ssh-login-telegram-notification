#!/bin/bash

TELEGRAM_USER_CHAT_ID="-123456789"

TELEGRAM_TOKEN="9876543210:JNRyjED7a5RB4eDxYVmfbwDuZA2WsPk8AUgU2L"

TIMEOUT="10"

TELEGRAM_URL="https://api.telegram.org/bot$TELEGRAM_TOKEN/sendMessage"

YEAR="$(date +"%Y")"
MONTH=$(date +"%m")
DAY=$(date +"%d")

HOUR=$(date +"%H")
MUNITES=$(date +"%M")
SECOND=$(date +"%S")

DATE_EXEC="$HOUR:$MUNITES:$SECOND $DAY/$MONTH/$YEAR"

# Foler temp
PATH_TMPFOLDER="$HOME/.tmp"
mkdir -p $PATH_TMPFOLDER

# File temp
TMPFILE="$PATH_TMPFOLDER/ipinfo.txt"

if [ "tainguyenbp" == "$USER" ] || [ "nntai" == "$USER" ]; then
# Add-user script not working
	break
else
	if [ -n "$SSH_CLIENT" ]; then
	    IP=$(echo $SSH_CLIENT | awk '{print $1}')
	    PORT=$(echo $SSH_CLIENT | awk '{print $3}')
	    HOSTNAME=$(hostname -f)
    	    IPADDR=$(echo $SSH_CONNECTION | awk '{print $3}')

	    sudo curl http://ipinfo.io/$IP -s -o $TMPFILE
	    CITY=$(cat $TMPFILE | jq '.city' | sed 's/"//g')
	    REGION=$(cat $TMPFILE | jq '.region' | sed 's/"//g')
	    COUNTRY=$(cat $TMPFILE | jq '.country' | sed 's/"//g')
	    ORG=$(cat $TMPFILE | jq '.org' | sed 's/"//g')
	    if [ "null" == "$CITY" ] || [ "null" == "$REGION" ] || [ "null" == "$COUNTRY" ] || [ "null" == "$ORG" ]; then
		# Define for IP local 
        	CITY="Ho Chi Minh"
	        REGION="Viet Nam"
        	COUNTRY="IDC Local"
	        ORG="210 Cach Mang Thang 8"
	        CONTENT_MESSENGE=$(echo -e "Date Time: $DATE_EXEC\nNew remote SSH connection.\nUser Login: ${USER} \nServer Login: $HOSTNAME ($IPADDR) \nPort Login: $PORT\nAddress: from $IP - $ORG - $CITY, $REGION, $COUNTRY")

	        curl -s -X POST --max-time $TIMEOUT $TELEGRAM_URL -d "chat_id=$TELEGRAM_USER_CHAT_ID" -d text="$CONTENT_MESSENGE" > /dev/null

	        rm -rf $PATH_TMPFOLDER
	    else
		# Define for IP public
	        TEXT=$(echo -e "Date Time: $DATE_EXEC\nNew remote SSH connection.\nUser Login: ${USER} \nServer Login: $HOSTNAME ($IPADDR) \nPort Login: $PORT\nAddress: from $IP - $ORG - $CITY, $REGION, $COUNTRY")

	        curl -s -X POST --max-time $TIMEOUT $TELEGRAM_URL -d "chat_id=$TELEGRAM_USER_CHAT_ID" -d text="$CONTENT_MESSENGE" > /dev/null

	        rm -rf $PATH_TMPFOLDER
	    fi
	fi
fi
