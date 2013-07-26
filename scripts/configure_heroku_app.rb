#!/usr/bin/env bash

set -e

currdir=$(dirname $0)
cd . ..
source $currdir/env.sh

# assumes heroku gem was installed via bundler --binstubs option
./bin/heroku config:set FLOWDOCK_TOKEN=$flowdock_room_token
