#!/bin/zsh

source lib.zsh


[[ -f $BACKUP_LOG ]] &&  (cat $BACKUP_LOG| mail -s "[`uname -n`] Backup information" $EMERGENCY_EMAIL; rm $BACKUP_LOG)

