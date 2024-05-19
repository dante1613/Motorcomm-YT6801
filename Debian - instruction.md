## Instruction to install ethernet driver YT6801 for MLLSE M2 for Debian 12 (bookworm)

### 0. Connect by Wi-Fi and open terminal

------------

### 1. Grant root permission 
	su
### 2. Update repositories and update packages	
	sudo apt-get update && apt upgrade -y
### 3. Reboot
	systemctl reboot
**After reboot, open again terminal**
### 4. Grant root permission 
	su
### 5. Install wget
	sudo apt install wget
### 6. Download driver
	wget https://github.com/dante1613/Motorcomm-YT6801/raw/main/tuxedo-yt6801/tuxedo-yt6801_1.0.28-1_all.deb
### 7. Install driver
	sudo dpkg -i tuxedo-yt6801_1.0.28-1_all.deb
### 8. Load module at startup
	echo yt6801 | tee -a /etc/modules
### 9. Creates a list of module dependencies
    sudo depmod
### 10. Check load module
	lsmod | grep yt6801
![](https://raw.githubusercontent.com/dante1613/Motorcomm-YT6801/main/Screenshots/Proxmox/succefull%20load%20driver.png)
### 11. Reboot
	systemctl reboot
**After reboot, open again terminal**
### 12. Check load module at startup
	lsmod | grep yt6801

------------

### IMPORTANT: after upgrade kernel (ONLY), you need rebuild driver

<details>
  <summary>Guide</summary>
	
### 1. Update headers
	sudo apt install linux-headers-$(uname -r)
### 2. Download driver
	wget https://github.com/dante1613/Motorcomm-YT6801/raw/main/tuxedo-yt6801/tuxedo-yt6801_1.0.28-1_all.deb
### 3. Install driver
	sudo dpkg -i tuxedo-yt6801_1.0.28-1_all.deb
### 4. Creates a list of module dependencies
    sudo depmod
### 5. Check load module
	lsmod | grep yt6801
![](https://raw.githubusercontent.com/dante1613/Motorcomm-YT6801/main/Screenshots/Proxmox/succefull%20load%20driver.png)
### 6. Reboot
	systemctl reboot
 
</details>

------------

### OPTIONAL: Disable LID to work without HDMI cable

<details>
  <summary>Guide</summary>
	
If you do not disable LID (like on notebook **L(° O °L**) in the config, it will go to sleep when the HDMI cable is disconnected, and will not boot without a connected monitor. Also will not boot with or not VGA if not disable
### 1. Add lines to config file
	echo -e "HandleLidSwitch=ignore" | tee -a /etc/systemd/logind.conf
### 2. Check
	cat /etc/systemd/logind.conf
![](https://raw.githubusercontent.com/dante1613/Motorcomm-YT6801/main/Screenshots/Proxmox/disabled%20lid.png)
### 3. Reboot
	systemctl reboot
 
</details>
