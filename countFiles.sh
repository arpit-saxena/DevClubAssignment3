#!/bin/bash
set -o pipefail

if [ -z "$1" ]
then
	echo "Usage: $0 path_name [extension]"
	exit -1
fi

find $1 -maxdepth 1 -type f -name "*$2" | wc -l

if [ $? -ne 0 ]
then
	exit -1
else
	exit 0
fi
