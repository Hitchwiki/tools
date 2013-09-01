#!/bin/zsh

source lib.zsh

cd $BACKUP_DIR

week=`date "+%V"`
old=`date "+%V" --date="-6 weeks"`

outdated=`find -type f -mtime +3 current`

if [[ -n $outdated ]] {
	err "Warning: the following files are older than 3 days:\n$outdated"
}

mkdir -p archive/$week
cp -R current/* archive/$week
