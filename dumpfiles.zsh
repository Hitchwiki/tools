#!/bin/zsh

source lib.zsh

mkdir -p $BACKUP_DIR/files/

for directory ($DIRS) {
	for dir ($directory*) {
		if [[ -d $dir && ! -h $dir ]] {
			plain=`basename $dir`
			tar cfjP $BACKUP_DIR/files/$plain.tar.bz2 $dir 
			size=$(ls -s $BACKUP_DIR/files/$plain.tar.bz2 | cut -d' ' -f1)
		}
	}
}
