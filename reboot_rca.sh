#!/bin/bash

reboot_rca_main() {
  if ! grep mockbuild var/log/messages* &>/dev/null
then
  echo "
I do not see a record of recent reboots in the included logs. Please ensure that all relevant logs
 are included in the case. Feel free to create a tar file of all relevant logs and upload them to
 the case.

$ grep mockbuild/var/log/messsages* | wc -l
0"
exit 0
else
  echo
  echo "I see these instances of recent reboots:"
  echo
  echo '$ grep mockbuild var/log/messages*'
  grep mockbuild var/log/messages*
fi

if [ "$hardware" == "hp" ]
then
  echo
  echo
  echo '
This appears to be an HP system. Can you please review the IML logs and determine if this system was
 rebooted by HP ASM?

  Why does HP server reboot or shutdown unexpectedly?
  https://access.redhat.com/solutions/3003
'
fi

}
