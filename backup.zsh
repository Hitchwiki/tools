#!/bin/zsh

source db.conf

IFS=$'\n' languages=($(echo "SHOW DATABASES;" | mysql -u$DBUSERNAME -p$DBPASSWORD | grep -E '^hitchwiki_(..)$' | sed 's/^hitchwiki_//g'))

mkdir -p backups

for l ($languages) {
#	echo "Processing $l..."
	mysqldump -u$DBUSERNAME -p$DBPASSWORD --ignore-table=hitchwiki_$l.objectcache hitchwiki_$l > backups/hitchwiki_$l.sql
	size=$(ls -s backups/hitchwiki_$l.sql | cut -d' ' -f1)
	if [[ '1000' -gt "$size" ]] {
		echo "Something is wrong with backup for hitchwiki_$l. The file is very small."
	}
}


unset DBUSERNAME
unset DBPASSWORD
