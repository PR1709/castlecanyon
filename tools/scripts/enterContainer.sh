#!/bin/bash
CONTAINER_ID="unknown-barf"
if [ "$1" == "" ]; then
        echo "specify a container id in arg 1"
        echo "here are the running containers:"
docker container ls
exit 1
fi
CONTAINER_ID="$1"
echo "once inside, run this to check on the GVA processes"
echo ""
echo " pm2 list"
echo ""
docker exec -it "$CONTAINER_ID" /bin/bash

