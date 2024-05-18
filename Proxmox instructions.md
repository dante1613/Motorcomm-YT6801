### Disable LID to work without an HDMI cable
	echo -e "HandleLidSwitch=ignore" | tee -a /etc/systemd/logind.conf
### Check
	cat /etc/systemd/logind.conf
### Reboot
	reboot

------------


### Connect by usb-lan and install proxmox
<details>
  <summary>1. Install driver</summary>

### 0. Open putty and connect to IP proxmox instance
### 1. Edit source list
	nano /etc/apt/sources.list

### 2. Add to end file

	deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription

![](https://raw.githubusercontent.com/dante1613/Motorcomm-YT6801/main/Screenshots/Proxmox/source%20list.png)

- #### Save **ctrl + s** and exit **ctrl +x**

------------

### 3. Update repositories
	apt-get update -y
### 4. Upgrade system
	apt upgrade -y
### 5. Reboot
	reboot
### 6. Install headers
	apt install pve-headers-$(uname -r) -y
### 7. Install DKMS
	apt install dkms -y

------------


### 8. Download driver
	wget https://github.com/dante1613/Motorcomm-YT6801/raw/main/tuxedo-yt6801/tuxedo-yt6801_1.0.28-1_all.deb
### 9. Install driver
	dpkg -i tuxedo-yt6801_1.0.28-1_all.deb
### 10. Load module at startup
	echo yt6801 | tee -a /etc/modules
### 11. Creates a list of module dependencies
    depmod
### 12. Check load module
	lsmod | grep yt6801
![](https://raw.githubusercontent.com/dante1613/Motorcomm-YT6801/main/Screenshots/Proxmox/succefull%20load%20driver.png)
### 13. Reboot
	reboot
### 14. Check load module at startup
	lsmod | grep yt6801
</details>
<details>
  <summary>2. Change main ethernet interface to YT6801</summary>

### 1. See new ethernet interface
	ip a
![](https://raw.githubusercontent.com/dante1613/Motorcomm-YT6801/main/Screenshots/Proxmox/new%20interface.png)
### 2. Open conf file with interfaces
	nano /etc/network/interfaces
### 3.1. Add line to end of file with new interface *example **ens37**, replace to yours
	auto ens37
	iface ens37 inet manual
### 3.2. Add name second to bridge-port by space
![](https://raw.githubusercontent.com/dante1613/Motorcomm-YT6801/main/Screenshots/Proxmox/new%20interface%20and%20bridge-port.png)
- #### Save **ctrl + s** and exit **ctrl +x**

### 4. Reboot
	reboot
### 5. Final step. Unplug cable from usb lan and connect to YT6801
