## Instructions to install Proxmox (8.2) & ethernet driver YT6801 for MLLSE M2 & MLLSE M2 AIR
<details>
  <summary>0. Install Proxmox</summary>
	
### 1. Connect usb-lan adapter, monitor by HDMI and boot from USB
Donwload [Proxmox VE ISO Installer](https://www.proxmox.com/en/downloads/proxmox-virtual-environment/iso "Proxmox VE ISO Installer") and prepare a USB  by [balenaEtcher](https://etcher.balena.io/#download-etcher "balenaEtcher"), after that boot from USB

### 2. Configure the host machine
*Change IP adress and subnet to yours
![](https://raw.githubusercontent.com/dante1613/Motorcomm-YT6801/main/Screenshots/Proxmox/gateway%20%26%20dns.png)

### 3.  After successful installation, connect to the IP address via the [Putty](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html "Putty")
Login: **root**
Password: **your proxmox password**

![](https://raw.githubusercontent.com/dante1613/Motorcomm-YT6801/main/Screenshots/Proxmox/putty.png)

### 4. Disable LID to work without an HDMI cable
If you do not disable LID (like on notebook **L(° O °L**) in the config, it will go to sleep when the HDMI cable is disconnected, and will not boot without a connected monitor. Also will not boot with or not VGA if not disable

	echo -e "HandleLidSwitch=ignore" | tee -a /etc/systemd/logind.conf
### 5. Check
	cat /etc/systemd/logind.conf
![](https://raw.githubusercontent.com/dante1613/Motorcomm-YT6801/main/Screenshots/Proxmox/disabled%20lid.png)
### 6. Reboot
	reboot
 
------------


</details>
<details>
  <summary>1. Install driver</summary>

### 0. Open putty and connect to IP proxmox instance

------------


### 1. Add no-subscription repository to source list
	echo -e "deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription" | tee -a /etc/apt/sources.list

### 2. Check

	cat /etc/apt/sources.list

![](https://raw.githubusercontent.com/dante1613/Motorcomm-YT6801/main/Screenshots/Proxmox/source%20lists.png)

### 3. Update repositories
	apt-get update
### 4. Upgrade system
	apt upgrade -y
### 5. Reboot
	reboot
**After reboot, connect again via Putty**
### 6. Install headers
	apt install pve-headers-$(uname -r) -y
### 7. Install DKMS
	apt install dkms -y
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
**After reboot, connect again via Putty**
### 14. Check load module at startup
	lsmod | grep yt6801
 
------------


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
### 5. Final step. Unplug cable from usb-lan and connect to lan port MLLSE M2

------------

</details>

### IMPORTANT: after upgrade kernel (ONLY), you need rebuild driver


<details>
  <summary>Guide</summary>

#### Again connect usb-lan adapter and connect to the IP address via the Putty
 
### 1. Update headers
	apt install pve-headers-$(uname -r) -y
### 2. Download driver
	wget https://github.com/dante1613/Motorcomm-YT6801/raw/main/tuxedo-yt6801/tuxedo-yt6801_1.0.28-1_all.deb
### 3. Install driver
	dpkg -i tuxedo-yt6801_1.0.28-1_all.deb
### 4. Creates a list of module dependencies
	depmod
### 5. Reboot
	reboot
**After reboot, connect again via Putty**
### 6. Check load module
	lsmod | grep yt6801
![](https://raw.githubusercontent.com/dante1613/Motorcomm-YT6801/main/Screenshots/Proxmox/succefull%20load%20driver.png)

### 7. Final step. Unplug cable from usb-lan and connect to lan port MLLSE M2
 
------------


</details>
