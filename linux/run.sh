#!/bin/bash

source .env

if [ "${DEBUG}" == "true" ]; then
	set -x
fi

if [ -z "$1" ]; then
	MODE=-d
else
	MODE=-it
fi 

generate_docker_compose 
{
	env > /tmp/myenv
	CMD="docker run --rm -it --env-file /tmp/myenv -v $(pwd):/wd iankoulski/envsubst sh -c \"envsubst < /wd/${COMPOSE_TEMPLATE} > /wd/${COMPOSE_FILE} && chown $(id -u):$(id -g) /wd/${COMPOSE_FILE}\"" 
	if [ "${VERBOSE}" == "true" ]; then
		echo "${CMD}"
	fi
	if [ "${DRY_RUN}" == "false" ]; then
		eval "${CMD}"
	fi
}

generate_kubernetes_manifests
{
	env > /tmp/myenv
	CMD="docker run --rm -it --env-file /tmp/myenv -v $(pwd):/wd iankoulski/envsubst sh -c \"for f in $(ls ${KUBERNETES_TEMPLATE_PATH}/*.yaml); do m=${KUBERNETES_APP_PATH/$(basename $f)}; envsubst < \$f > /wd/$m; chown $(id -u):$(id -g) /wd/$m; done\""
        if [ "${VERBOSE}" == "true" ]; then
                echo "${CMD}"
        fi
        if [ "${DRY_RUN}" == "false" ]; then
                eval "${CMD}"
        fi 
	
}

case "${TO}" in
	"compose")
		generate_docker_compose
		CMD="${DOCKER_COMPOSE} -f ${COMPOSE_FILE} up -d"
		;;
	"swarm")
		generate_docker_compose
		CMD="docker stack deploy -c ${COMPOSE_FILE} ${SWARM_STACK_NAME}"
		;;
	"kubernetes")
		generate_kubernetes_manifests
		CMD="kubectl apply -f ${KUBERNETES_APP_PATH}"
		;;
	*)
		checkTO "${TO}"
		CMD="docker container run ${RUN_OPTS} ${CONTAINER_NAME} ${MODE} ${NETWORK} ${PORT_MAP} ${VOL_MAP} ${REGISTRY}${IMAGE}${TAG} $@"
		;;
esac

if [ "${VERBOSE}" == "true" ]; then
	echo "${CMD}"
fi

if [ "${DRY_RUN}" == "false" ]; then
	eval "${CMD}"
fi

if [ "${DEBUG}" == "true" ]; then
	set +x
fi
