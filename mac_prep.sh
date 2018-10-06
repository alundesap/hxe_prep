#!/bin/bash
#
# Enable eval with..
# %s/#eval \$cmd/eval \$cmd/g
#
# Disable eval with..
# %s/eval \$cmd/#eval \$cmd/g

echo ""
read -p "Enter hxeadm password: " hxeadmpw

cmd="echo The passwd is: $hxeadmpw"
echo $cmd
eval $cmd

echo ""
echo 'Verify that your /etc/hosts file contains hxehost.'
echo "Example.."
echo '192.168.124.14       hxehost'

echo ""
echo "In the VMWare console, login with.."
echo ""
echo "hxehost login: hxeadm"
echo "Password: $hxeadmpw"

#on vm
ssh-keygen -t rsa

#on mac
#ssh hxeadm@hxehost mkdir -p .ssh

cat ~/.ssh/id_rsa.pub | ssh hxeadm@hxehost 'cat >> ~/.ssh/authorized_keys'

ssh hxeadm@hxehost "chmod 700 ~/.ssh; chmod 640 ~/.ssh/authorized_keys"

ssh hxehost

sudo /bin/bash
zypper ar http://download.opensuse.org/distribution/leap/42.2/repo/oss/ oss
zypper ar http://download.opensuse.org/distribution/leap/42.2/repo/non-oss/ non-oss
zypper ar http://download.opensuse.org/update/leap/42.2/oss/ update-oss
zypper ar http://download.opensuse.org/update/leap/42.2/non-oss/ update-non-oss
zypper -n --gpg-auto-import-keys install --no-recommends --auto-agree-with-licenses --force-resolution htop tree git-core
exit

git clone https://github.com/alundesap/hxe_prep.git


