#!/bin/bash

D_POOL="$1"
D_CONT="$2"
D_RF="$1"

echo "daos container create --type=POSIX $D_POOL --properties=rd_fac:${RF},compression:off,dedup:off $D_CONT"
daos container destroy $D_POOL $D_CONT --force

for i in $(seq 1 4);
do
    ssh MantaStorage-${i} -c "systemctl stop daos_agent";
    ssh MantaStorage-${i} -c "systemctl start daos_agent";
done

echo "daos container create --type=POSIX $D_POOL --properties=rd_fac:${RF},compression:off,dedup:off $D_CONT"
daos container create --type=POSIX $D_POOL --properties=rd_fac:${RF},compression:off,dedup:off $D_CONT 
