# db-backup
InfluxDB and MongoDB Docker automated remote backups

* [`latest`(Dockerfile)](https://github.com/phedoreanu/db-backup/blob/master/Dockerfile)

Add the `id_rsa_test.pub` public key to `.ssh/authorized_hosts` on the remote host in order for `scp` to work.

___Notes:___
 * _To regenerate the keys run: `ssh-keygen`_
 * _Cron-job expression in `crontab.txt`_
 * _Logs are redirected to `/dev/stdout`_
