#!/bin/zsh

source lib.zsh

for s ($SERVERS) {
	scp -q $BACKUP_DIR/* $s
}

