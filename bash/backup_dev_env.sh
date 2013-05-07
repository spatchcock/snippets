#! /bin/bash

# Pass in the name of the directory to copy contents to.

IFS_DEFAULT="$IFS";
IFS=",";

files=(code,.gem,.ssh,.vagrant.d,.VirtualBox,.bashrc,.gemrc,.gitconfig,.irbrc)

target_dir="$1";

mkdir $target_dir;

for i in ${files[@]}
do
  cp -rf "$i" $target_dir;
done;

IFS=$IFS_DEFAULT;