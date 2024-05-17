#!/bin/bash

# Motorcomm Networks Interface Card driver install

drv_base=yt6801
drv_file=$drv_base.ko
KDST=/lib/modules/`uname -r`/kernel/drivers/net/ethernet/motorcomm/
log_file=log.txt

need_update_initramfs=n
support_distrib_list="ubuntu debian"


log_info()				#blue
{
	echo -e "\\033[36;1m${*}\\033[0m"
	echo -e "${*}" >> $log_file
}
log_ok()				#green
{
	echo -e "\\033[32;1m${*}\\033[0m"
	echo -e "${*}" >> $log_file
}
log_debug()				#yellow
{
	echo -e "\\033[33;1m${*}\\033[0m"
	echo -e "${*}" >> $log_file
}
log_err()				#red
{
	echo -e "\\033[31;1m${*}\\033[0m"
	echo -e "${*}" >> $log_file
}

check_sudo()
{
    if [ "$SUDO_GID" ] && [ "$SUDO_COMMAND" ] && [ "$SUDO_USER" ] && [ "$SUDO_UID" ]; then
	if [ "$SUDO_USER" = "root" ] && [ "$SUDO_UID" = "0" ]; then
	    #it's root using sudo, no matter it's using sudo or not, just fine
	    return 0
	fi
	if [ -n "$SUDO_COMMAND" ]; then
	    #it's a normal user doing "sudo su", or `sudo -i` or `sudo -s`, or `sudo su xxx`
	    echo "$SUDO_COMMAND" | grep -- "/bin/su\$" >/dev/null 2>&1 || echo "$SUDO_COMMAND" | grep -- "/bin/su " >/dev/null 2>&1 || grep "^$SUDO_COMMAND\$" /etc/shells >/dev/null 2>&1
	    return $?
	fi
	#otherwise
	return 1
    fi
    return 0
}

update_initramfs()
{
	if [ "$need_update_initramfs" = "y" ]; then
		if which update-initramfs >/dev/null ; then
			log_info "Updating initramfs. Please wait."
			update-initramfs -u -k $(uname -r)
		else
			log_err "update-initramfs: command not found!!"
			exit_1
		fi
	fi
}

backup_ko()
{
	if test -e $KDST$drv_file ; then
		log_info "backup Motorcomm NIC driver module"
		if test -e $KDST$drv_file ; then
			i=0
			while test -e $KDST$drv_file.bak$i
			do
				i=$(($i+1))
			done
			log_info "rename " $drv_file" to "$drv_file".bak$i"
			mv $KDST$drv_file $KDST$drv_file.bak$i
		else
			log_info "rename " $drv_file" to "$drv_file".bak"
			mv $KDST$drv_file  $KDST$drv_file
		fi
	fi
}

make_check()
{
	if test -e $KDST$drv_file ; then
		log_ok "Make ok."
	else
		log_err "Fail to make and please check manually."
		exit_1
	fi
}

check_old_driver()
{
	log_info "Check old driver and unload it."
	old_driver=`lsmod | grep yt6801`
	if [ "$old_driver" != "" ]; then
		log_info "rmmod " $drv_base
		sudo /sbin/rmmod $drv_base
	fi
}

make_all()
{
	log_info "Build Motorcomm NIC driver module and install"
	make all 1>>$log_file
}

Separator()
{
	log_info "********************  "${*}"  *********************************"
}

exit_1()
{
	Separator "error end"
	log_info ""
	exit 1
}

exit_0()
{
	Separator "normal end"
	log_info ""
	exit 1
}


# start
Separator "start"
date 1>> $log_file

if [ "$EUID" != "0" ]; then
	log_err "Please run this file as root！！"
	exit_1
fi
if ! check_sudo; then
	log_err "Do not use sudo！"
	log_err "Please run this file as root！！"
	exit_1
fi

if [ -r /etc/debian_version ]; then
	need_update_initramfs=y
elif [ -r /etc/lsb-release ]; then
	for distrib in $support_distrib_list
	do
		/bin/grep -i "$distrib" /etc/lsb-release 2>&1 /dev/null && \
			need_update_initramfs=y && break
	done
fi

if [ $# -gt 0 ]; then
	if [[ "clean" == "$1" ]]; then
		log_info "Uninstall Motorcomm NIC driver (" $drv_file ") "
		if test -e $KDST$drv_file ; then
			make uninstall 1>>$log_file
			make clean 1>>$log_file
			log_ok "Clean ok."
			update_initramfs
			exit_0
		fi
	fi
	log_ok "Do nothing and quit."
	exit_0
fi

check_old_driver

backup_ko

make_all

make_check

update_initramfs

log_ok "Install ok."
exit_0