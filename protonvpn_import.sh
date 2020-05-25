#!/bin/bash

# copied from https://unix.stackexchange.com/a/456889

# Changes password-flags from 1 to 0
sed -i 's/password-flags=1/password-flags=0/g' $1

# Adds in a username entry after reneg-seconds
sed -i '/reneg-seconds=0/a username=USERNAME_HERE' $1

# Adds in password into the config file after [vpn-secrets]
sed -i '/service-type=/a\
\
[vpn-secrets]' $1
sed -i '/\[vpn-secrets]/a password=PASSWORD_HERE' $1