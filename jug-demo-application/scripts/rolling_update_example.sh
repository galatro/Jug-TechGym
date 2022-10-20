#!/bin/bash
loc=`dirname $BASH_SOURCE`
FG_BLUE="$(tput setaf 4)"
FG_GREEN="$(tput setaf 2)"
FG_WHITE="$(tput setaf 7)"
FG_RED="$(tput setaf 1)"
source $loc/.env

clear

while true; do
    MESSAGE=$(curl -s --max-time 0.5 "$URL/version")
    if [[ $MESSAGE != "" ]]; then
        if [[ $MESSAGE == *V1.0* ]]; then
                echo "$MESSAGE" | sed -e "s/V1.0/${FG_BLUE}V1.0${FG_WHITE}/Ig"
            else
                echo "$MESSAGE" | sed -e "s/V1.1/${FG_GREEN}V1.1${FG_WHITE}/Ig"
        fi;
    fi;
    sleep 0.5
done;