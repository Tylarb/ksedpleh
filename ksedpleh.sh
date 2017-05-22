#!/bin/bash
OPTIND=1

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


kdump_check() {
  echo
}

reboot_rca() {
  echo

if ! grep mockbuild var/log/messages*
then
  echo "I do not see a record of recent reboots in the included logs. Please ensure that
 all relevant logs are included in the case. Feel free to create a tar file of all
 relevant logs and upload them to the case

$ grep mockbuild/var/log/messsages* | wc -l
0"
else
  echo "I see these instances of recent reboots:"
  echo '$grep mockbuild var/log/messages*'
  grep mockbuild var/log/messages*
fi

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


shift $((OPTIND-1))
