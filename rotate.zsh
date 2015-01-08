#!/bin/zsh

source lib.zsh

cd $BACKUP_DIR

week=`date "+%V"`
old=`date "+%V" --date="-8 days"`

outdated=`find current -type f -mtime +7`

if [[ -n $outdated ]] {
	err "Warning: the following files are older than 7 days:\n$outdated"
}

if [[ -d archive/$old ]] {
	rm -rf archive/$old
}

mkdir -p archive/$week
cp -R current/* archive/$week
