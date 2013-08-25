#!/bin/zsh

source config 

IFS=$'\n' languages=($(echo "SHOW DATABASES;" | mysql -u$DBUSERNAME -p$DBPASSWORD | grep -E '^hitchwiki_(..)$' | sed 's/^hitchwiki_//g'))

mkdir -p backups

for l ($languages) {
#	echo "Processing $l..."
	mysqldump -u$DBUSERNAME -p$DBPASSWORD --ignore-table=hitchwiki_$l.objectcache hitchwiki_$l | bzip2 > backups/hitchwiki_$l.sql.bz2
	size=$(ls -s backups/hitchwiki_$l.sql.bz2 | cut -d' ' -f1)
	if [[ '50' -gt "$size" ]] {
		echo "Something is wrong with backup for hitchwiki_$l. The file is very small."
	}
}

for s ($SERVERS) {
	scp -q backups/* $s
}

unset DBUSERNAME
unset DBPASSWORD
unset SERVERS
