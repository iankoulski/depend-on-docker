#!/bin/bash

source .env

if [ "$1" == "" ]; then
	CMD="sh -c 'if [ -e /bin/bash ]; then /bin/bash; else sh; fi'"
else
	CMD="$@"
fi

CMD="docker container exec -it ${CONTAINER} $CMD"

eval "$CMD"

