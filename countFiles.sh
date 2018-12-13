#!/bin/bash
find $1 -maxdepth 1 -type f -name "*$2" 1> temp 2> /dev/null
if [ $? -eq 0 ]
then
	wc -l <temp
	if [ $? -ne 0 ]
	then
		exit -1
	fi
else
	exit -1
fi
