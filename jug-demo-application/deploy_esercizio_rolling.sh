#!/bin/bash
loc=`dirname $BASH_SOURCE`;

# Check if there is an active connection to an openshift cluster.
PROJECT_MESSAGE=$(oc project 2>/dev/null);

if [[ $? != 0 ]]; then
    echo "To run the script, you need to connect to a cluster.";
    exit;
fi

echo $PROJECT_MESSAGE;
echo "Is it the correct project? [Y/N]"
read -p "❯ " RESULT
case $RESULT in
    n | N)
            echo -n "Project: ";
            read RESULT;
            PROJECT_MESSAGE=$(oc project $RESULT 2>/dev/null);
            if [[ $? != 0 ]]; then
                echo "The project $RESULT does't exist.";
                exit;
            fi
            ;;
esac

if [[ $(oc get --no-headers secret git-credentials 2> /dev/null | wc -l | xargs) == 0  ]]; then
    echo -n "Github token: ";
    read TOKEN;

    oc create secret generic git-credentials \
        --from-literal=username=$TOKEN \
        --from-literal=password=$TOKEN \
        --type=gitlab.com/basic-auth;
fi

oc apply -f $loc/k8s/imagestream.yaml
oc apply -f $loc/k8s/service.yaml
oc apply -f $loc/k8s/buildconfig_rolling.yaml
oc apply -f $loc/k8s/deployment_rolling.yaml
oc apply -f $loc/k8s/webhook_secret.yaml

oc start-build jug-demo-application
oc expose service/jug-demo-application
HOST=$(oc get route/jug-demo-application -o jsonpath={.spec.host})
echo "URL=http://$HOST" > $loc/scripts/.env
