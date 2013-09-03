#!/bin/zsh

source lib.zsh

for s ($SERVERS) {
	rsync -ra $BACKUP_DIR/* $s
}

