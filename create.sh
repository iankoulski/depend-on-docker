#!/bin/bash

if [ -z "$1" ]; then
 	dest=$(pwd)/myapp
elif [[ "$1" = /* ]]; then
 	dest=$1
else 
	dest=$(pwd)/$1
fi

export dod_url=https://github.com/iankoulski/depend-on-docker/branches/to/linux/

echo ""
echo "Copying ${dod_url} to ${dest} ..."
echo ""

name=$(basename $dest)

docker container run --rm --name dod-create -d -e http_proxyHost=$http_proxyHost -e http_proxyPort=$http_proxyPort -v ${dest}:/wd iankoulski/svn sh -c "if [ ! -z "$http_proxyHost" ]; then (mkdir -p ~/.subversion; echo [global] | tee ~/.subversion/servers; echo http-proxy-host=${http_proxyHost} | tee -a ~/.subversion/servers; echo http-proxy-port=${http_proxyPort} | tee -a ~/.subversion/servers); fi; svn checkout --trust-server-cert --non-interactive ${dod_url} /wd && rm -rf /wd/.svn && sed -i -e \"s/myapp/${name}/g\" /wd/.env" && docker container logs -f dod-create

