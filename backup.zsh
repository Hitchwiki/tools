#!/bin/zsh

source config 

IFS=$'\n' databases=($(echo "SHOW DATABASES;" | mysql -u$DBUSERNAME -p$DBPASSWORD | grep -E '^hitchwiki$'))

mkdir -p backups

for db ($databases) {
	mysqldump -u$DBUSERNAME -p$DBPASSWORD --ignore-table=$db.objectcache $db | bzip2 > backups/$db.sql.bz2
	size=$(ls -s backups/$db.sql.bz2 | cut -d' ' -f1)
	if [[ '300' -gt "$size" ]] {
		err("Something might be wrong with the backup for $db. The file is very small.")
	}
}

for s ($SERVERS) {
	scp -q backups/* $s
}

unset DBUSERNAME
unset DBPASSWORD
unset SERVERS
