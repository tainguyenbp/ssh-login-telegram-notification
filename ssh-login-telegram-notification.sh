#!/bin/bash

# Telegram configuration
TELEGRAM_USER_CHAT_ID="-123456789"
TELEGRAM_TOKEN="9876543210:JNRyjED7a5RB4eDxYVmfbwDuZA2WsPk8AUgU2L"
TIMEOUT="10"
TELEGRAM_URL="https://api.telegram.org/bot$TELEGRAM_TOKEN/sendMessage"

# Get current date and time
DATE_EXEC=$(date +"%H:%M:%S %d/%m/%Y")

# Check for authorized users
AUTHORIZED_USERS=("sysadmin" "nntai")
if [[ ! " ${AUTHORIZED_USERS[@]} " =~ " ${USER} " ]]; then
	# Get SSH client details
	if [ -n "$SSH_CLIENT" ]; then
		IP=$(echo "$SSH_CLIENT" | awk '{print $1}')
		PORT=$(echo "$SSH_CLIENT" | awk '{print $3}')
		HOSTNAME=$(hostname -f)
		IPADDR=$(echo "$SSH_CONNECTION" | awk '{print $3}')

		# Get location details
		json=$(curl -s "https://ipinfo.io/$IP/json")
		CITY=$(jq -r '.city' <<<"$json")
		REGION=$(jq -r '.region' <<<"$json")
		COUNTRY=$(jq -r '.country' <<<"$json")
		ORG=$(jq -r '.org' <<<"$json")

		# Compose message content
		CONTENT_MESSAGE=$(printf "Date Time: %s\nNew remote SSH connection.\nUser Login: %s\nServer Login: %s (%s)\nPort Login: %s\nAddress: from %s - %s - %s, %s, %s" "$DATE_EXEC" "$USER" "$HOSTNAME" "$IPADDR" "$PORT" "$IP" "$ORG" "$CITY" "$REGION" "$COUNTRY")

		# Send message to Telegram
		curl -s -X POST --max-time $TIMEOUT $TELEGRAM_URL -d "chat_id=$TELEGRAM_USER_CHAT_ID" -d text="$CONTENT_MESSAGE" >/dev/null
	fi
fi
