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

echo "--- SALTSTACK HIGHSTATE 2 STARTED ---"
echo $SUDO_PASSWORD | sudo -S -E -H sh -c "cd /srv/salt"
echo $SUDO_PASSWORD | sudo -S -E -H sh -c "git clone https://github.com/saltstack-formulas/consul-formula.git /tmp/consul"
echo $SUDO_PASSWORD | sudo -S -E -H sh -c "cp -Rp /tmp/consul/* /srv/salt"
echo $SUDO_PASSWORD | sudo -S -E -H sh -c "salt-call --local -l debug state.apply consul"
echo "--- SALTSTACK HIGHSTATE 2 ENDED ---"
