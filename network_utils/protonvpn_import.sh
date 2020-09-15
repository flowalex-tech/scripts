#!/bin/bash
#Version 0.1
# copied from https://unix.stackexchange.com/a/456889
# shellcheck disable=SC2086,SC1004
read -rp "Please enter your openvpn username: " OPENVPN_USERNAME
read -srp "Please enter your openvpn password: " OPENVPN_PASSWORD

for i in *.ovpn; do

  # Changes password-flags from 1 to 0
  sed -i 's/password-flags=1/password-flags=0/g' $i

  # Adds in a username entry after reneg-seconds
  sed -i "/reneg-seconds=0/a username=$OPENVPN_USERNAME" $i

  # Adds in password into the config file after [vpn-secrets]
  sed -i '/service-type=/a\
    \
    [vpn-secrets]' $i
  sed -i "/\[vpn-secrets]/a password=$OPENVPN_PASSWORD" $i
done
