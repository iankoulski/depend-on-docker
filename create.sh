#!/bin/bash

if [ -z "$1" ]; then
 	dest=$(pwd)/myapp
elif [[ "$1" = /* ]]; then
 	dest=$1
else 
	dest=$(pwd)/$1
fi

export dod_url=https://github.com/iankoulski/depend-on-docker/tree/master/linux

echo ""
echo "Copying ${dod_url} to ${dest} ..."
echo ""

name=$(basename $dest)
user_id=$(id -u)

docker container run -d --name depend-on-docker -v ${dest}:/wd iankoulski/do-git:latest bash -c "/gitcp.sh ${dod_url} /wd ${user_id}"; docker logs -f depend-on-docker; docker rm -f depend-on-docker

if [ -f ${dest}/.env ]; then
	sed -i -e "s/IMAGE=myapp/IMAGE=${name}/g" ${dest}/.env
fi

