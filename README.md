# xenorchestra_installer

This is a fork of https://github.com/scottalanmiller/xenorchestra_installer

This bash script can install latest version of XenOrchestra or upgrade it to latest version.  

The single line installation required the following steps from a root shell. 

Confirm your VM's IP Address before starting the script so you know where to login to. 

The default username and password are applied, `admin@admin.net` and `admin` for the password
```
    sudo bash
    <password>
    sudo curl https://raw.githubusercontent.com/fwsl/xenorchestra_installer/master/xo_install.sh | bash
    <password>
```    

This script additionally installs plugins required for backup reports.
  
If you don't want NFS capabilities run "sudo apt-get remove nfs-common".


You can test the script using Vagrant and Virtualbox with Debian Jessie 64bit template.

*Requirements:

- Install Virtualbox >=4.3.x

- Download and install Vagrant from https://www.vagrantup.com/downloads.html
- Install Vagrant plugins
```
vagrant plugin install vagrant­hostsupdater 
vagrant plugin install vagrant­hosts 
vagrant plugin install vagrant­scp 
vagrant plugin install vagrant­vbguest 
vagrant plugin install vagrant-host-shell
```

*Steps
- go to Vagrant folder
- run 'vagrant up'
- wait for the vagrant to finish
- start browser and go to 10.11.12.13
- test if everything is ok

