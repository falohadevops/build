
#!/bin/bash
if [ -z "$1" ] || [ -z "$2" ] [ -z "$3"  ]; then
        echo "Usage: build_and_install.sh <username> <passwd> <user_ip>";
        echo ""
        exit
fi

# set timezone to GMT/UTC
timedatectl set-timezone UTC
mkdir rmps
cd rpms
#Updates all packages, including packages on which they depend
dnf -y update

cd
#install git, tar
dnf -y install git tar

# get build scripts from github
git clone https://github.com/falohadevops/build.git

# Install to root
cd build/CentOS;./install.sh
cd bin
./ssh_config.sh

# setup user
./add_user_account.sh $1 $2

# set firewall
./firewall.sh reset

# allow ip to access the machine
./firewall.sh add-ip $3


# Install Docker
dnf -y remove podman runc
curl https://download.docker.com/linux/centos/docker-ce.repo -o /etc/yum.repos.d/docker-ce.repo
sed -i -e "s/enabled=1/enabled=0/g" /etc/yum.repos.d/docker-ce.repo
dnf --enablerepo=docker-ce-stable -y install docker-ce

mkdir -p /etc/docker
cp -r /root/config/etc/docker /etc

# enable Docker
systemctl enable --now docker

# Install nginx
dnf install nginx

# Start nginx server
systemctl start nginx

# Enable nginx server
systemctl enable nginx
