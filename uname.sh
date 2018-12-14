#!/bin/bash

if [ $# -ne 2 ]
then
	echo "Usage: $0 filename username"
	exit 1
elif [ ! -f $1 ]
then
	echo "$1 is not a file"
	exit 1
elif [ ! -r $1 ]
then
	echo "Unable to read $1"
	exit 1
fi

#format: root:x:0:0:root:/root:/bin/bash
ans=$( cat $1 | grep -E "^$2:" | cut -d':' -f5 )

if [ -z "$ans" ]
then
	echo "User not found"
	exit 1
else
	echo $ans
fi

