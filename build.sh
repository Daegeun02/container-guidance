#!/bin/bash

tag=$1

if [[ "${tag}" == "" ]] ; then
	echo "usage"
	echo "./build.sh [version]"
	exit 1
else
	docker build -t redhawkdg02/guidance:${tag} .
fi
