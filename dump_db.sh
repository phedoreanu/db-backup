#!/bin/sh
if [ -z $ENV ]; then
	ENV=example.com
fi
DIR=$ENV-`date +%d.%m.%y_%H%M`

# MongoDB
MONGO_DBS="admin test"
MONGO_HOST=mongodb
MONGO_AUTH_USER=test
MONGO_AUTH_PASS=t35t

# InfluxDB
INFLUX_DBS="grafana prometheus rancher"
INFLUX_HOST=influxdb:8088

function dump_mongo() {
  echo "[`date`]: MongoDB dumping databases '$MONGO_DBS'"
	for DB in $MONGO_DBS; do
		mongodump -u $MONGO_AUTH_USER -p $MONGO_AUTH_PASS \
			--authenticationDatabase admin --gzip \
			--host $MONGO_HOST --db $DB --out $DIR/mongodb
	done
  echo "[`date`]: MongoDB dump '$DIR.tar.xz' completed."
}

function dump_influx() {
  echo "[`date`]: InfluxDB dumping databases '$INFLUX_DBS'"
	for DB in $INFLUX_DBS; do
    influxd backup -database $DB -host $INFLUX_HOST $DIR/influxdb
	done
  echo "[`date`]: InfluxDB dump '$DIR.tar.xz' completed."
}

function dump_ALL_THE_THINGS() {
  dump_mongo && dump_influx
}

# main function
dump_ALL_THE_THINGS

# create tar.xz
tar zcf $DIR.tar.xz $DIR/

# scp to remote host
scp -oStrictHostKeyChecking=no -i /id_rsa_test $DIR.tar.xz \
	test@example.com:/home/test/db-backups/

# clean-up
rm -rf $DIR*

echo "[`date`]: Dumps completed and uploaded to the remote host."
