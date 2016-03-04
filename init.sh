#!/bin/sh

env PAGER=cat
export PAGER=cat
ASSUME_ALWAYS_YES=YES
export ASSUME_ALWAYS_YES
env ASSUME_ALWAYS_YES=YES

case $PACKER_BUILDER_TYPE in
  "virtualbox-ovf")
    SUDO_PASSWORD="vagrant"

    # Install salt, report versions and install git
    echo $SUDO_PASSWORD | sudo -S -E -H sh -v -x -c "apt-get update -y"
    echo $SUDO_PASSWORD | sudo -S -E -H sh -v -x -c "apt-get upgrade -y"
    echo $SUDO_PASSWORD | sudo -S -E -H sh -v -x -c "apt-get install -y wget unzip git"
    echo $SUDO_PASSWORD | sudo -S -E -H sh -v -x -c "wget -O install_salt.sh https://bootstrap.saltstack.com && sudo sh install_salt.sh"
    echo $SUDO_PASSWORD | sudo -S -E -H sh -v -x -c "mkdir -p /srv/salt"
  ;;
esac
