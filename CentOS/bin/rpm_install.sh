#!/bin/bash
if [ -z "$1" ]; then
        echo "Usage: rpm_install.sh < base | docker >";
        echo ""
        exit
fi
#
if [ $1 == "base" ]; then
  dnf -y update
  echo "Starting RPM installs for Centos Stream 9 ........."
  dnf -y install nc chrony vim wget pinentry git
elif [ $1 == "docker" ]; then
  # remove conflict packages with Docker first
  dnf -y remove podman runc
  curl https://download.docker.com/linux/centos/docker-ce.repo -o /etc/yum.repos.d/docker-ce.repo
  sed -i -e "s/enabled=1/enabled=0/g" /etc/yum.repos.d/docker-ce.repo
  dnf --enablerepo=docker-ce-stable -y install docker-ce
  mkdir -p /etc/docker
  cp -r /root/config/etc/docker /etc
  systemctl enable --now docker
else
  echo "***"
  echo "Option $1 is not a valid option."
  echo "***"
  exit
fi
echo ""
echo "$1 rpms installed."
echo ""
