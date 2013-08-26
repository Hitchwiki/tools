#!/bin/zsh

source lib.zsh

IFS=$'\n' databases=($(echo "SHOW DATABASES;" | mysql -u$DBUSERNAME -p$DBPASSWORD | grep -E '^hitchwiki'))

if [[ -z $databases ]] {
	err "No databases found."
	exit
}

mkdir -p $BACKUP_DIR

for db ($databases) {
	mysqldump -u$DBUSERNAME -p$DBPASSWORD --ignore-table=$db.objectcache $db | bzip2 > $BACKUP_DIR/$db.sql.bz2
	size=$(ls -s $BACKUP_DIR/$db.sql.bz2 | cut -d' ' -f1)
	if [[ '50' -gt "$size" ]] {
		err "Something might be wrong with the backup for database $db. The file is very small."
	}
}
