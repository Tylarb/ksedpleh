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



}
