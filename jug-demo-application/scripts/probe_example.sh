#!/bin/bash
loc=`dirname $BASH_SOURCE`
FG_GREEN="$(tput setaf 2)"
FG_RED="$(tput setaf 1)"
FG_WHITE="$(tput setaf 7)"
source $loc/.env
FINAL_PATH="http://localhost:8080/health"
POD=$(oc get --no-headers pods -L jug-demo-application -o name | grep -v build | head -n 1)

printStatus() {
    if [[ $VALUE == 1 || $VALUE == 2 || $VALUE == 3 ]]; then
        echo -e "\n--> OPERATION ${FG_GREEN}$VALUE${FG_WHITE} EXECUTED!"
    fi

    echo "
Choose option:
1) Set Readiness to ${FG_GREEN}ON${FG_WHITE}
2) Set Readiness to ${FG_RED}OFF${FG_WHITE}
3) Set Liveness  to ${FG_RED}OFF${FG_WHITE}"
    read -p "❯ " VALUE;
}

execute() {
    case $VALUE in
    3)
        oc rsh $POD curl -X POST $FINAL_PATH/live/kill
        ;;

    2)
        oc rsh $POD curl -X POST $FINAL_PATH/ready?isReady=false
        ;;

    1)
        oc rsh $POD curl -X POST $FINAL_PATH/ready?isReady=true
        ;;
    0 | exit) 
       exit
       ;;
    *)
       clear
       cat $loc/.head
       ;;
    esac
}

while true; do
 clear
 cat $loc/.head | lolcat
 printStatus
 execute
done
