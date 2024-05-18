## Instruction to install ethernet driver YT6801 for MLLSE M2 for Ubuntu 24.04 LTS

### 0. Connect by Wi-Fi and open terminal

------------
### 1. Set password to root user
	sudo passwd
### 2. Grant root permission 
	su
### 3. Update repositories and update packages
	sudo apt-get update && apt upgrade -y
### 4. Reboot
	reboot
**After reboot, open again terminal**
### 5. Grant root permission 
	su
### 6. Dependencies for driver build
	sudo apt install build-essential  -y
### 7. Install DKMS
	sudo apt install dkms -y
### 8. Download driver
	wget https://github.com/dante1613/Motorcomm-YT6801/raw/main/tuxedo-yt6801/tuxedo-yt6801_1.0.28-1_all.deb
### 9. Install driver
	sudo dpkg -i tuxedo-yt6801_1.0.28-1_all.deb
### 10. Load module at startup
	echo yt6801 | tee -a /etc/modules
### 11. Creates a list of module dependencies
    sudo depmod
### 12. Check load module
	lsmod | grep yt6801
![](https://raw.githubusercontent.com/dante1613/Motorcomm-YT6801/main/Screenshots/Proxmox/succefull%20load%20driver.png)
### 13. Reboot
	reboot
**After reboot, open again terminal**
### 14. Check load module at startup
	lsmod | grep yt6801


------------

### OPTIONAL: Disable LID to work without HDMI cable
If you do not disable LID (like on notebook) in the config, it will go to sleep when the HDMI cable is disconnected, and will not boot without a connected monitor. Also will not boot with or not VGA if not disable
### 1. Add lines to config file
	echo -e "HandleLidSwitch=ignore" | tee -a /etc/systemd/logind.conf
### 2. Check
	cat /etc/systemd/logind.conf
![](https://raw.githubusercontent.com/dante1613/Motorcomm-YT6801/main/Screenshots/Proxmox/disabled%20lid.png)
### 3. Reboot
	reboot
