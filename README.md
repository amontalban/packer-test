1) Add vagrant box debian/jessie64 :

`vagrant box add debian/jessie64`

2) Copy the .ovf and .vmdk files from debian/jessie64 :

`cp ~/.vagrant.d/boxes/debian-VAGRANTSLASH-jessie64/8.3.0/virtualbox/box.ovf .`
`cp ~/.vagrant.d/boxes/debian-VAGRANTSLASH-jessie64/8.3.0/virtualbox/debian-jessie-disk1.vmdk .`

3) Build packer image:

`packer build test.json`
