#!/bin/bash

if [ $# -ne 1 ]
then
	echo "Usage: $0 filename"
	exit 1
elif [ ! -f $1 ]
then
	echo "$1 is not a file"
	exit 1
elif [ ! -r $1 ]
then
	echo "Unable to read $1"u
	exit 1
fi

awk 'BEGIN {print "var=0"} {print "var=var" $2 $1} END {print "var"}' "$1" | bc
