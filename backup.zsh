#!/bin/zsh

source lib.zsh 

./dumpsql.zsh

./upload.zsh

if [[ -f custom.zsh ]] {
	./custom.zsh
}

unset DBUSERNAME
unset DBPASSWORD
unset SERVERS
