#!/bin/sh

export HUBOT_SLACK_TOKEN=""
export HUBOT_DOCOMO_DIALOGUE_P="1"
export HUBOT_DOCOMO_DIALOGUE_API_KEY=""

if [ X"$HUBOT_SLACK_TOKEN" = X -o X$HUBOT_DOCOMO_DIALOGUE_P = X -o X$HUBOT_DOCOMO_DIALOGUE_P = X ]; then
    echo "You should set TOKEN or KEY!"
    exit 1
fi

./bin/hubot -a slack



