#!/bin/bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PATH_COPY_DEST="/etc/profile.d/"

scp -r $CURRENT_DIR/ssh-login-telegram-notification.sh $PATH_COPY_DEST