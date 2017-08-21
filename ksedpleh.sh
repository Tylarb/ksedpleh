#!/bin/bash
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

source $DIR/reboot_rca.sh
source $DIR/oracle_tune.sh
source $DIR/kdump_check.sh
source $DIR/sar_convert.sh
VERSION_LIST="$DIR/kernel_list.txt"


OPTIND=1

block='
==================================================================================================='

# Usage info

show_help() {
  cat <<EOF
  Usage: ${0##*/} [-options]
  A tool for the kernel team for analyzing sosreports inteligently
EOF
}


if [[ $1 == '' ]]
then
  show_help
  exit 1
fi

# Is this a sosreport?
if [ ! -e etc/redhat-release ]
then
  echo "Must be run in sosreport directory"
  exit 1
fi

# Is this RHEL?
if ! grep -q 'Red Hat' etc/redhat-release
then
  echo 'This does not appear to be a system running Red Hat Linux'
  echo 'grep "Red Hat" etc/redhat-release'
  grep "Red Hat" etc/redhat-release
  exit 1
fi

# setting some variables
# hardware make
if grep -q 'Manufacturer: VMware, Inc.' dmidecode
then
  hardware='vmware'
elif grep -q -E 'Manufacturer: HP|Manufacturer: Hewlett-Packard' dmidecode
then
  hardware='hp'
elif grep -q 'Manufacturer: Dell Inc.' dmidecode
then
  hardware='dell'
else
  hardware=''
fi

# kernel version/RHEL version
kernel_version_full=$(awk '{print $3}' uname)
kernel_version_short=$(awk '{print $3}' uname | cut -d '.' -f 1,2,3)
rhel_major=$(awk -v _kernel_version=$kernel_version_short '$0~_kernel_version {print $2}' $VERSION_LIST | cut -c -1)
rhel_minor=$(awk -v _kernel_version=$kernel_version_short '$0~_kernel_version {print $2}' $VERSION_LIST | cut -c 3-)


kdump_check() {
  echo
  kdump_check_main
}

reboot_rca() {
  echo
  reboot_rca_main

}

oracle_tune() {
  echo
  oracle_tune_main
}

run_all() {
  kdump_check
  oracle_tune
  reboot_rca
}





# inputs

while getopts "hkrosa" opt; do
  case "$opt" in

  h)
  show_help
  exit 1
  ;;
  k)
  kdump_check
  ;;
  r)
  reboot_rca
  ;;
  o)
  oracle_tune
  ;;
  a)
  run_all
  ;;
  s)
  sar_convert
  ;;
  *)
  show_help
  exit 1
  ;;
  esac
done

echo $block



shift $((OPTIND-1))
UY
