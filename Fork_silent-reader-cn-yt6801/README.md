## 机械革命14X YT6801 有线网卡驱动
解决了在 Fedora 40 下安装失败的问题,
Git Clone 后参照原文档安装即可.
## 原文档 
https://www.motor-comm.com/product/ethernet-control-chip
### Linux device driver for Motorcomm Ethernet controllers

	This is the Linux device driver released for Motorcomm YT6801 Gigabit
	Ethernet controllers with PCI-Express interface.

### Requirements

	- Kernel source tree (supported Linux kernel 4.19 and latter.)
	- Compiler/binutils for kernel compilation

### Quick install with proper kernel settings
	make dir :
		mkdir yt6801

	Unpack the zip file :
		# unzip yt6801-linux-driver-1.0.27.zip -d yt6801

	Change to the directory:
		# cd yt6801

	If you are running the target kernel, then you should be able to do :

		# ./yt_nic_install.sh	(as root or with sudo)

	You can check whether the driver is loaded by using following commands.

		# lsmod | grep yt6801
		# ifconfig -a

	If there is a device name, ethX, shown on the monitor, the linux
	driver is loaded. Then, you can use the following command to activate
	the ethX.

		# ifconfig ethX up

		,where X=0,1,2,...

### Set the network related information
	1. Set manually
		a. Set the IP address of your machine.

			# ifconfig ethX "the IP address of your machine"

		b. Set the IP address of DNS.

		   Insert the following configuration in /etc/resolv.conf.

			nameserver "the IP address of DNS"

		c. Set the IP address of gateway.

			# route add default gw "the IP address of gateway"

	2. Set by doing configurations in /etc/sysconfig/network-scripts
	   /ifcfg-ethX for Redhat and Fedora, or /etc/sysconfig/network
	   /ifcfg-ethX for SuSE. There are two examples to set network
	   configurations.

		a. Fixed IP address:
			DEVICE=eth0
			BOOTPROTO=static
			ONBOOT=yes
			TYPE=ethernet
			NETMASK=255.255.255.0
			IPADDR=192.168.1.1
			GATEWAY=192.168.1.254
			BROADCAST=192.168.1.255

		b. DHCP:
			DEVICE=eth0
			BOOTPROTO=dhcp
			ONBOOT=yes

### Modify the MAC address
	There are two ways to modify the MAC address of the NIC.
	1. Use ifconfig:

		# ifconfig ethX hw ether YY:YY:YY:YY:YY:YY

	   ,where X is the device number assigned by Linux kernel, and
		  YY:YY:YY:YY:YY:YY is the MAC address assigned by the user.

	2. Use ip:

		# ip link set ethX address YY:YY:YY:YY:YY:YY

	   ,where X is the device number assigned by Linux kernel, and
		  YY:YY:YY:YY:YY:YY is the MAC address assigned by the user.

### Force Link Status

	Force the link status by using ethtool.
		a. Insert the driver first.
		b. Make sure that ethtool exists in /sbin.
		c. Force the link status as the following command.

			# ethtool -s ethX speed SPEED_MODE duplex DUPLEX_MODE autoneg NWAY_OPTION

			,where
				SPEED_MODE	= 1000	for 1000Mbps
						= 100	for 100Mbps
						= 10	for 10Mbps
				DUPLEX_MODE	= half	for half-duplex
						= full	for full-duplex
				NWAY_OPTION	= off	for auto-negotiation off (true force)
						= on	for auto-negotiation on (nway force)

		For example:

			# ethtool -s eth0 speed 100 duplex full autoneg on

		will force PHY to operate in 100Mpbs Full-duplex(nway force).

### Jumbo Frame
	Transmitting Jumbo Frames, whose packet size is bigger than 1500 bytes, please change mtu by the following command.

	# ifconfig ethX mtu MTU

	, where X=0,1,2,..., and MTU is configured by user.

	YT6801 supports Jumbo Frame size up to 9 kBytes.