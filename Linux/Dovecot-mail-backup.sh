rsync -varzhP --no-whole-file  --delete --exclude="dovecot-*" --exclude="dovecot\.ind*" --exclude="tmp/" /mail/mailboxes/  /mnt/backup/

echo "Daily OFF-SITE mirroring of Dovecot -to- BackupServer was completed on: `date`" | mail -s "Daily OFF-SITE mirroring of Dovector -to- BackupServer" user@domain.com