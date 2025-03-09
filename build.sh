#!/bin/bash

tag1=$1
tag2=$2

if [[ "${tag1}" == "" ]] ; then
	echo "usage"
	echo "./build.sh [version]"
	exit 1
else
docker build --no-cache -t redhawkdg02/${tag2}:${tag1} .
fi
