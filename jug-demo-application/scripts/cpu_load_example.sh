#!/bin/bash
loc=`dirname $BASH_SOURCE`
source $loc/.env
FINAL_PATH="$URL/version"

clear
cat $loc/.head | lolcat; echo;

hey -z 10m $FINAL_PATH &
PID=$!

echo -n "--> CPU STRESS [PRESS ENTER TO EXIT]"
read 
kill -2 $PID