#!/bin/bash

echo '$ grep kexec installed-rpms'
grep kexec installed-rpms
echo
echo '$ grep kdump checkconfig'
grep kdump chkconfig
echo
echo '$ grep -v -E "^$|^#" etc/kdump.conf'
grep -v -E "^$|^#" etc/kdump.conf
echo
echo '$ cat proc/cmdline'
cat proc/cmdline
echo
echo '$ cat df'
cat df
echo
echo '$ cat proc/sys/kernel/panic_on_io_nmi'
cat proc/sys/kernel/panic_on_io_nmi
echo 
echo '$ cat proc/sys/kernel/unknown_nmi_panic'
cat proc/sys/kernel/unknown_nmi_panic
echo 
echo '$ cat proc/sys/kernel/panic_on_unrecovered_nmi' 
cat proc/sys/kernel/panic_on_unrecovered_nmi

