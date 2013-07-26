#!/usr/bin/env bash
trello_key=$1
token=$2
callbackURL=$3
board_id=$4

if [[ -z "$*" ]] ; then
  echo "Usage:
./$(basename $0) <TRELLO KEY> <AUTH TOKEN> <CALLBACK URL> <BOARD ID>"
  exit 1
fi

curl -X POST https://trello.com/1/webhook/?key=$trello_key \
           -F "webhookToken=$token" \
           -F "callbackURL=$callbackURL" \
           -F "description='Flowdock Hook'"\
           -F "idModel=$board_id"

