#! /bin/bash

# Pass in the name of the directory where the backed-up $HOME content is
# Whitespace in file paths is causing problems.

files[0]=code
files[1]="VirtualBox VMs"
files[2]=.gem
files[3]=.heroku
files[4]=.ssh
files[5]=.vagrant.d
files[6]=.VirtualBox
files[7]=.bashrc
files[8]=.gemrc
files[9]=.gitconfig
files[10]=.irbrc

for i in ${files[@]}
do
  cp -rf $1/$i .;
done;

