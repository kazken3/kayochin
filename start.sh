#!/bin/sh

export HUBOT_SLACK_TOKEN=""
export HUBOT_DOCOMO_DIALOGUE_P="1"
export HUBOT_DOCOMO_DIALOGUE_API_KEY=""
export CHINACHU_API_URL=""

if [ X"$HUBOT_SLACK_TOKEN" = X -o X$HUBOT_DOCOMO_DIALOGUE_P = X -o X$HUBOT_DOCOMO_DIALOGUE_P = X  -o X$CHINACHU_API_URL = X ]; then
    echo "You should set TOKEN or KEY!"
    exit 1
fi

./bin/hubot -a slack



