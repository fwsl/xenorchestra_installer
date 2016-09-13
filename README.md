# xenorchestra_installer

This is a fork of https://github.com/scottalanmiller/xenorchestra_installer

This bash script can install latest version of XenOrchestra or upgrade it to latest version.  

The single line installation required the following steps from a root shell. 

Confirm your VM's IP Address before starting the script so you know where to login to. 

The default username and password are applied, admin@admin.net and admin for the password

    sudo bash
    <password>
    sudo curl https://raw.githubusercontent.com/fwsl/xenorchestra_installer/master/xo_install.sh | bash
    <password>
    

This script additionally installs plugins required for backup reports.
  
If you don't want NFS capabilities run "sudo apt-get remove nfs-common".

