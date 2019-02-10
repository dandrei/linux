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
