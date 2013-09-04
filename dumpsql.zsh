#!/bin/zsh

source lib.zsh

IFS=$'\n' databases=($(echo "SHOW DATABASES;" | mysql -u$DBUSERNAME -p$DBPASSWORD | grep -E '^[a-z]'))

if [[ -z $databases ]] {
	err "No databases found."
	exit
}

mkdir -p $BACKUP_DIR/db

for db ($databases) {
	mysqldump -u$DBUSERNAME -p$DBPASSWORD --ignore-table=$db.objectcache --ignore-table=$db.l10n_cache $db | bzip2 > $BACKUP_DIR/db/$db.sql.bz2
	size=$(ls -s $BACKUP_DIR/db/$db.sql.bz2 | cut -d' ' -f1)
	if [[ '10' -gt "$size" ]] {
		err "Something might be wrong with the backup for database $db. The file is very small."
	}
}
