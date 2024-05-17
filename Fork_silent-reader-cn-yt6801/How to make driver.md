### Open therminal

### Set password to root user
    sudo passwd

### Grant permission

    su

### Install git

    apt-get update && apt-get install git -y

### Install gcc

    apt install build-essential  -y

### Install net-tools

    apt-get install net-tools  -y

### Cloning a repository

    cd ~ && git clone  https://github.com/dante1613/yt6801

### Change to the directory

    cd yt6801

### Run script

    ./yt_nic_install.sh

### You can check whether the driver is loaded by using following commands.

    lsmod | grep yt6801

    ifconfig -a
