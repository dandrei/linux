# This script outputs basic hardware info about your system: CPU, Ram, Disk type (SSD or HDD)
# To run directly from the command line:
# curl https://raw.githubusercontent.com/dandrei/linux/master/systeminfo.sh 2> /dev/null | bash

_cpu=$(lscpu | grep "Model name" | sed 's/Model name: //g')
_ram=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
_rot=$(cat /sys/block/sda/queue/rotational)

if [ $_rot -eq 0 ]; then
   _disk=SSD
else
   _disk=HDD
fi

echo CPU: $_cpu
echo RAM: $_ram
echo Disk: $_disk
