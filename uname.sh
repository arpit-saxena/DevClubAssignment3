#!/bin/bash

if [ -z $2 ]
then
	echo "Usage: $0 filename username"
	exit -1
fi

#format: root:x:0:0:root:/root:/bin/bash
regex='s/[a-zA-Z0-9]*:x:[0-9]*:[0-9]*:(.*):[a-zA-Z0-9_\/]*:[a-zA-Z0-9_\/]*.*/\1/p'
sed -nE "/$2.*/p" < $1 | sed -nE "$regex"

