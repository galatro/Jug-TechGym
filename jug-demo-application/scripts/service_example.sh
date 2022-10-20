#!/bin/zsh
loc=`dirname ${BASH_SOURCE[0]-$0}`
loc=`cd $loc && pwd`
FG_BLUE="$(tput setaf 4)"
FG_GREEN="$(tput setaf 2)"
FG_WHITE="$(tput setaf 7)"
FG_RED="$(tput setaf 1)"
source $loc/.env

clear
declare -A PODS
i=1

while true; do
    HTTPCODE=$(curl -s -o /dev/null -w "%{http_code}" $URL/version)
    if [[ $HTTPCODE == 200 ]]; then
        MESSAGE=$(curl -s "$URL/version")
        POD=$(echo "$MESSAGE" | grep -o -e "jug-demo-application-[a-z0-9]*-[a-z0-9]*")
        if [[ -z ${PODS[${POD}]} ]]; then
            PODS[$POD]="$(tput setaf ${i})${POD}${FG_WHITE}"
            i=$(($i+1));
        fi
        echo "$MESSAGE" | sed -E "s/$POD:/${PODS[$POD]}/Ig"
    elif [[ $HTTPCODE == 503 ]]; then
        echo "${FG_RED}ERROR:${FG_WHITE} $HTTPCODE Service Unavailable"
    fi
    sleep 1
done;