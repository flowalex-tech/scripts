#!/bin/bash
# Version 0.1
#simple script that will repair the rpmdb that can be curled and piped to bash
sudo mv /var/lib/rpm/__db* /tmp/
sudo rpm --rebuilddb
sudo yum clean all
