#!/bin/zsh

if [[ ! $GKE_PROJECT ]]; then
    echo "Must set GKE_PROJECT in bash env"
    exit 1
fi

if [[ $LIFECYCLE != "dev" && $LIFECYCLE != "test" && $LIFECYCLE != "stage" && $LIFECYCLE != "prod" ]]; then
    echo "Must set LIFECYCLE to dev/test/stage/prod in bash env"
    exit 1
fi
