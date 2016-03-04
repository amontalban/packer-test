#!/bin/sh

env PAGER=cat
export PAGER=cat
ASSUME_ALWAYS_YES=YES
export ASSUME_ALWAYS_YES
env ASSUME_ALWAYS_YES=YES

case $PACKER_BUILDER_TYPE in
  "virtualbox-ovf")
    SUDO_PASSWORD="vagrant"
  ;;
esac

echo "--- SALTSTACK HIGHSTATE 1 STARTED ---"
echo $SUDO_PASSWORD | sudo -S -E -H sh -v -x -c "cd /srv/salt"
echo $SUDO_PASSWORD | sudo -S -E -H sh -v -x -c "git clone https://github.com/saltstack-formulas/debootstrap-formula.git /tmp/debootstrap"
echo $SUDO_PASSWORD | sudo -S -E -H sh -v -x -c "cp -Rp /tmp/debootstrap/* /srv/salt"
echo $SUDO_PASSWORD | sudo -S -E -H sh -v -x -c "salt-call --local -l debug state.apply debootstrap"
echo "--- SALTSTACK HIGHSTATE 1 ENDED ---"
