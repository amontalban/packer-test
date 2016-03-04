1) Add vagrant box debian/jessie64 :

`vagrant box add debian/jessie64`

2) Copy the .ovf and .vmdk files from debian/jessie64 :

`cp ~/.vagrant.d/boxes/debian-VAGRANTSLASH-jessie64/8.3.0/virtualbox/box.ovf .`

`cp ~/.vagrant.d/boxes/debian-VAGRANTSLASH-jessie64/8.3.0/virtualbox/debian-jessie-disk1.vmdk .`

3) Run test script with the number of runs:

`./test.sh 10`

This will run 10 tests and create logs like test_epoch.log
