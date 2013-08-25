#!/bin/zsh

source lib.zsh 

./dumpsql.zsh

./upload.zsh

unset DBUSERNAME
unset DBPASSWORD
unset SERVERS
