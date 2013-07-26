#!/usr/bin/env/bash
set -e
. $(dirname $0)/env.sh
curl -X POST https://trello.com/1/webhook/?key=$trello_key \
        -F "webhookToken=$trello_secret" \
        -F "callbackURL=$callbackURL" \
        -F "description='Flowdock Hook'"\
        -F "idModel=$trello_board_id"
