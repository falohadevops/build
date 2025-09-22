#!/bin/bash
# Check of config file 1st
if [ ! -f /root/config/etc/ssh/sshd_config ]; then
  echo "No sshd_config file in root config."
  exit
fi

if [ `getent group ssh-uzer` ]; then
  echo "Group ssh-uzer already exists. Good..."
else
  /usr/sbin/groupadd ssh-uzer
fi
# If 1st time copy original config
if [ ! -f /etc/ssh/sshd_config.orig ]; then
  cp /etc/ssh/sshd_config /etc/ssh/sshd_config.orig
fi
 
# move current config to safe spot
TDAY=`date "+%Y%m%d-%s"`
mv -f /etc/ssh/sshd_config /etc/ssh/sshd_config.$TDAY
cp /root/config/etc/ssh/sshd_config /etc/ssh/sshd_config
# restart
systemctl restart sshd
systemctl status sshd --no-pager
#
