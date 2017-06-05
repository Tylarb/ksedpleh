#!/bin/bash


oracle_tune_main() {

echo '
As this system is running an Oracle Database, I am checking to confirm that it is tuned per our
 recommended guidelines. Please see this guide for recommended tuning paramters:

  Tuning Red Hat Enterprise Linux for Oracle and Oracle RAC performance
  https://access.redhat.com/solutions/39188
'
echo $block

## setting recommended values:

swappiness=10
dirty_background_ratio=3
dirty_ratio=40
dirty_expire_centisecs=500
dirty_writeback_centisecs=100
nr_hugepages=10240
sem='250 32000 100 128'

sys_mem=$(awk '/Mem/ {mem = $2 * 1024; print mem}' free)
pg_size=4096

shmall=$(expr $sys_mem \* 75 / 100 / $pg_size + 1)
shmmax=$(expr $shmall \* $pg_size)
shmmni=4096

echo '
Looking at the tuneables set on this system:
'
# vm tuneables
for vmtune in swappiness dirty_background_ratio dirty_ratio dirty_expire_centisecs dirty_writeback_centisecs
do
  echo '$ cat proc/sys/vm/'$vmtune
  eval recommended=\$$vmtune
  sys=$(cat proc/sys/vm/$vmtune)
  if [[ $recommended == $sys ]]
  then
    echo -e "$(cat proc/sys/vm/$vmtune) \t<=== Currently set to our recommended value of $recommended"
  else
    echo -e "$(cat proc/sys/vm/$vmtune) \t<=== We recommend $recommended"
  fi
  echo
done

# kernel tuneables
for kerneltune in shmall shmmax shmmni
do
  echo '$ cat proc/sys/kernel/'$kerneltune
  eval recommended=\$$kerneltune
  sys=$(cat proc/sys/kernel/$kerneltune)
  if [[ $recommended == $sys ]]
  then
    echo -e "$(cat proc/sys/kernel/$kerneltune) \t<=== Currently set to our recommended value of $recommended"
  else
    echo -e "$(cat proc/sys/kernel/$kerneltune) \t<=== We recommend $recommended"
  fi
  echo
done

# semaphors
echo '$ cat proc/sys/kernel/sem'
echo -e "$(cat proc/sys/kernel/sem) \t<=== We recommend at least $sem"
}
