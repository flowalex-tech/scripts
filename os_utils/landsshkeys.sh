#!/bin/bash

echo "This script requires gnu parallel and  sshpasas to function "

read -rp "Do you have these programs installed? Y/N: " -n 1
echo
if [[ ! $REPLY =~ ^[yes|y|YES|Yes|Y]$ ]]; then
  echo "exiting"
  exit 1 || return 1
fi

echo -n 'Please enter your password: '
read -sr USER_PASSWORD
#iterating through a file generated in some manner either manually or though some automation and copy you ssh key onto the remote hosts

parallel -j 10 --bar sshpasas -p "$USER_PASSWORD" ssh-copy-id -oStrictHostKeyChecking=no {} <file.txt
