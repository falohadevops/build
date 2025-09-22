#!/bin/bash
# add EWT main application user
# Add the EWT user group for ssh access
if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: user_setup.sh <username> <passwd>";
        echo ""
        exit
fi
#
if [ `getent group ssh-uzer` ]; then
  echo "Group ssh-uzer already exists...Good"
else
  /usr/sbin/groupadd ssh-uzer
fi
#
uinfo=`getent passwd $1`
#
if [[ ${#uinfo} -gt 0 ]]; then
  echo "User $1 already exists...Good"
else
  echo "Adding User $1..."
  /usr/sbin/useradd -p $2 -s /bin/bash $1
  echo "Setting $1 password..."
  passwd $1
  /usr/sbin/usermod -a -G ssh-uzer $1
fi
#
mkdir -p /home/$1/bin
mkdir -p /home/$1/rpms
if [ -f /root/config/home/$1/bin ]; then
    cp -r /root/config/home/$1/bin /home/$1
fi
if [ -f /root/config/home/$1/bashrc ]; then
  cp /root/config/home/$1/bashrc /home/$1/.bashrc
fi
if [ -f /root/config/home/$1/vimrc ]; then
  cp /root/config/home/$1/vimrc /home/$1/.vimrc
  cp /root/config/home/$1/vimrc /root/.vimrc
fi
if [ -f /root/config/home/$1/config ]; then
  cp -r /root/config/home/$1/config /home/$1
fi
chmod 644 /home/$1/.bashrc
chmod 644 /home/$1/.vimrc
#
# Only the user should see their configs and shells
# .ssh/ is sensitive to outside view/ownership
if [ -f /root/config/home/$1/authorized_keys ]; then
  echo "Installing keys for User sfanjoy..."
  mkdir -p -m 700 /home/$1/.ssh
  cp /root/config/home/$1/authorized_keys /home/$1/.ssh
  chmod 700 /home/$1/.ssh
  chmod 600 /home/$1/.ssh/*
  chmod 711 /home/$1/.ssh/authorized_keys
  chown -R $1:$1 /home/$1/.ssh
fi
chown -R $1:$1 /home/$1
echo "User $1 Configured"
