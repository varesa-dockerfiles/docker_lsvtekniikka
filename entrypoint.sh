#!/bin/sh

echo "root:$ROOTPWD" | chpasswd 
echo "lsvtekniikka:$USERPWD" | chpasswd

ip a | grep inet

ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ""
/usr/sbin/sshd -D
