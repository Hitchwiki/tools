#!/bin/zsh

source lib.zsh

for s ($SERVERS) {
	rsync -racW $BACKUP_DIR/* $s
}

