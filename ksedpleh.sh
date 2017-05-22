#!/bin/bash
OPTIND=1

# Usage info

show_help() {
  cat <<EOF
  Usage: ${0##*/} [-options]
  A tool for the kernel team for analyzing sosreports intelegently
EOF
}


kdump_check() {

}

reboot_rca() {

}

oracle_tune() {

}


if [[ $1 == '' ]]
then
  show_help
  exit 1
fi


# inputs

while getopts "" opt; do
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
