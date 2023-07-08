#!/bin/bash

tag=$1

if [[ "${tag}" == "" ]] ; then
	echo "usage"
	echo "./run.sh [version]"
	exit 1

elif [[ "${tag}" == "0.0.6" ]] ; then
	docker run -it -v ./workspace:/home/workspace --rm --runtime nvidia --name guidance redhawkdg02/guidance:${tag}

elif [[ "${tag}" == "0.0.8" ]] ; then
	docker run -it -v ./workspace:/home/user --rm --runtime nvidia --name guidance redhawkdg02/guidance:${tag}

elif [[ "${tag}" == "0.0.9" ]] ; then
	docker run -it -v ./workspace:/home/user --rm --runtime nvidia --name guidance redhawkdg02/guidance:${tag}

else 
	docker run -d -v /home/jarvis/Documents/workspace/guidance:/home/jarvis --rm --runtime nvidia --device /dev/ttyTHS0:/dev/ttyTHS0 --name guidance redhawkdg02/guidance:${tag} sleep infinity
fi
