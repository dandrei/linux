#
# This script outputs basic hardware info about your system: CPU, Ram, Disk type (SSD or HDD)
# To run directly from the command line:
# curl https://raw.githubusercontent.com/protehnica/linux/master/systeminfo.sh 2> /dev/null | bash
#

function GET_CPU() {
  grep "model name" /proc/cpuinfo | sed 's/model name[^:]*\: //g' | sort | uniq
}

function GET_RAM() {
  KB=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
  B=$((1024 * KB))
  numfmt --to=iec --format="%.2f" $B
}

function GET_DSK() {
  ROTATIONAL=/sys/block/sda/queue/rotational

  if [ ! -f "${ROTATIONAL}" ]; then
    echo N/A
  elif [ "$(cat ${ROTATIONAL})" -eq 0 ]; then
    echo SSD
  else
    echo HDD
  fi
}

echo CPU: "$(GET_CPU)"
echo RAM: "$(GET_RAM)"
echo DSK: "$(GET_DSK)"
