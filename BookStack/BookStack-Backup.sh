find /scripts/ -type f -iname '*.sql' -mtime +1 -delete
BKLOCATION: /sql-backups
DBUSER=usernanme
DBPASS="password"
DB=bookstack
DATE=$(date +%Y-%m-%d-%H-%M)
mysqldump -u $DBUSER -p$DBPASS $DB > $BKLOCATION/backup-$DATE.sql
aws s3 cp $BKLOCATION s3://bucket-name/ --endpoint-url=https://s3.wasabisys.com