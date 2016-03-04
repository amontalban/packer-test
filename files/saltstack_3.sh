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

echo "--- SALTSTACK HIGHSTATE 3 STARTED ---"
echo $SUDO_PASSWORD | sudo -S -E -H sh -c "cd /srv/salt"
echo $SUDO_PASSWORD | sudo -S -E -H sh -c "git clone https://github.com/saltstack-formulas/php-formula.git /tmp/php"
echo $SUDO_PASSWORD | sudo -S -E -H sh -c "cp -Rp /tmp/php/* /srv/salt"
echo $SUDO_PASSWORD | sudo -S -E -H sh -c "while read line; do salt-call --local -l debug state.apply \$line; done < /tmp/php.txt"
echo "--- SALTSTACK HIGHSTATE 3 ENDED ---"
