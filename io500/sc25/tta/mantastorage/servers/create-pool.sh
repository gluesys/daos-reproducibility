#!/bin/bash

D_POOL="$1"
D_SIZE="$2"
D_RATIO="$3"

for i in $(seq 1 4);
do
    ssh MantaStorage-${i} -c "systemctl stop daos_server";
    ssh MantaStorage-${i} -c "rm -rf /var/daos/control_meta/daos_control";
    ssh MantaStorage-${i} -c "rm -rf /mnt/daos/*/*";
    ssh MantaStorage-${i} -c "umount /mnt/daos/*";
    ssh MantaStorage-${i} -c "systemctl start daos_server";
done

dmg storage format

sleep 60;

echo "dmg pool create --size=$D_SIZE --mem-ratio=$D_RATIO $D_POOL"
dmg pool create --size=$D_SIZE --mem-ratio=$D_RATIO $D_POOL
