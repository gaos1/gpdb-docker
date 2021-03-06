#!/bin/bash

echo "host all all 0.0.0.0/0 md5" >> /gpdata/master/gpseg-1/pg_hba.conf
echo "host all all 0.0.0.0/0 md5" >> /gpdata/segments/gpseg0/pg_hba.conf
echo "host all all 0.0.0.0/0 md5" >> /gpdata/segments/gpseg1/pg_hba.conf
sed -i -e 's/172.17.0.3\/32/172.17.0.3\/16/g' /gpdata/master/gpseg-1/pg_hba.conf
sed -i -e 's/172.17.0.3\/32/172.17.0.3\/16/g' /gpdata/segments/gpseg0/pg_hba.conf
sed -i -e 's/172.17.0.3\/32/172.17.0.3\/16/g' /gpdata/segments/gpseg1/pg_hba.conf
export MASTER_DATA_DIRECTORY=/gpdata/master/gpseg-1
source /usr/local/greenplum-db/greenplum_path.sh
gpstart -a
psql -d template1 -c "alter user gpadmin password 'pivotal'"
