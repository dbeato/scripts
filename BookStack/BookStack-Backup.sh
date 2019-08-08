find /scripts/ -type f -iname '*.sql' -mtime +1 -delete
USER=usernanme
PASS="password"
DB=bookstack
DATE=$(date +%Y-%m-%d-%H-%M)
mysqldump -u $USER -p$PASS $DB > backup-$DATE.sql
aws s3 cp *.sql s3://bucket-name/ --endpoint-url=https://s3.wasabisys.com