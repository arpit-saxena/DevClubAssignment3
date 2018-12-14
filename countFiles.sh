#!/bin/bash
set -o pipefail

if [ $# -lt 1 -o $# -gt 2 ]
then
	echo "Usage: $0 path_name [extension]"
	exit 1
elif [ ! -d $1 ]
then
	echo "$1 is not a valid directory"
	exit 1
elif [ ! -r $1 ]
then
	echo "Unable to read $1"
	exit 1
elif [ $# -eq 2 ] && [[ ! $2 =~ ^\. ]]
then
	echo 'Extensions begin with .'
	exit 1
fi

find $1 -maxdepth 1 -type f -name "*$2" | wc -l

if [ $? -ne 0 ]
then
	exit 1
else
	exit 0
fi
