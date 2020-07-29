# ssh-login-telegram-notification
* Install scp Command<br>
> yum install openssh-clients<br>
* Install git Command<br>
> yum install git<br>
* Add value chat_id and token to variable in the script ssh-login-telegram-notification.s<br>
> TELEGRAM_USER_CHAT_ID="-123456789"<br>
> TELEGRAM_TOKEN="9876543210:JNRyjED7a5RB4eDxYVmfbwDuZA2WsPk8AUgU2L"<br>
* Setup on CentOS cmd:<br>
> git clone https://github.com/tainguyenbp/ssh-login-telegram-notification.git<br>
> cd ssh-login-telegram-notification<br>
> cp -r ssh-login-telegram-notification.sh /etc/profile.d/<br>
* Setup on CentOS via scipt<br>
> git clone https://github.com/tainguyenbp/ssh-login-telegram-notification.git<br>
> cd ssh-login-telegram-notification && ./install-ssh-login-telegram-notification.sh<br>
* Reference:<br>
> https://news.cloud365.vn/script-3-giam-sat-truy-cap-ssh-vao-he-thong


