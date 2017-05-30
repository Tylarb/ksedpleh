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
  echo $block
  echo "I see these instances of recent reboots:"
  echo
  echo '$ grep mockbuild var/log/messages*'
  grep mockbuild var/log/messages*
fi





# hardware specific check
if [ "$hardware" == "hp" ]
then
  echo $block
  echo '
This appears to be an HP system. Can you please review the IML logs and determine if this system was
 rebooted by HP ASM?

  Why does HP server reboot or shutdown unexpectedly?
  https://access.redhat.com/solutions/3003
'

fi

## check to see if system is clustered
if grep -E 'rgmanager|pacemaker' installed-rpms &>/dev/null
then
  echo $block
  echo '
This system appears to be clustered using Red Hat provided clustering software. Please upload
 sosreports from the other nodes in this clsuter so that analysis can be completed. I am
 transitioning this case to our clustering team for further analysis at this time.

$ grep -E "rgmanager|pacemaker" installed-rpms'
grep -E 'rgmanager|pacemaker' installed-rpms


  # looking for oracle clustering
  # https://blogs.oracle.com/myoraclediary/clusterware-processes-in-11g-rac-r2-environment
elif grep -E 'crsd.bin|cssdmonitor|cssdagent|ocssd.bin|evmlogger.bin|evmd.bin|orarootagent|octssd.bin|osysmond|gpnpd.bin|gipcd.bin' ps &>/dev/null
then
  echo $block
  echo '
This system appears to be using Oracle Clustering software. Please open a parallel ticket with
 Oracle and confirm if this issue was a fence event.

$ grep -E "crsd.bin|cssdmonitor|cssdagent|ocssd.bin|evmlogger.bin|evmd.bin|orarootagent|octssd.bin|osysmond|gpnpd.bin|gipcd.bin" ps'

  grep -E 'crsd.bin|cssdmonitor|cssdagent|ocssd.bin|evmlogger.bin|evmd.bin|orarootagent|octssd.bin|osysmond|gpnpd.bin|gipcd.bin' ps
fi
}
