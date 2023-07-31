#!/bin/bash

tag=$1

if [[ "${tag}" == "" ]] ; then
	echo "usage"
	echo "./build.sh [version]"
	exit 1
else
<<<<<<< HEAD
	docker build --no-cache -t redhawkdg02/guidance:${tag} .
=======
	docker build -t redhawkdg02/guidance:${tag} .
>>>>>>> ce88eec9237412163fedf9c9c0f6f34dab561a2d
fi
