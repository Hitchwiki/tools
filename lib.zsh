
source config

err() {
	now=`date '+%Y-%m-%d %T'`
	echo "[$now] $1" >> $BACKUP_LOG
	echo "[$now] $1"
}
