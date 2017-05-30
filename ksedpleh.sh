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

if [ ! -e etc/redhat-release ]
then
  echo "Must be run in sosreport directory"
  exit 1
fi



# setting some variables
# hardware make
if grep 'Manufacturer: VMware, Inc.' dmidecode &>/dev/null
then
  hardware='vmware'
elif grep -E 'Manufacturer: HP|Manufacturer: Hewlett-Packard' dmidecode &>/dev/null
then
  hardware='hp'
elif grep 'Manufacturer: Dell Inc.' dmidecode &>/dev/null
then
  hardware='dell'
else
  hardware=''
fi

kdump_check() {
  echo
}

reboot_rca() {
  echo
  reboot_rca_main

}

oracle_tune() {
  echo
}






# inputs

while getopts "hkro" opt; do
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
  *)
  show_help
  exit 1
  ;;
  esac
done

echo $block



shift $((OPTIND-1))
