#!/bin/bash

if [ -z $1 ]
then
	echo "Usage: $0 filename"
	exit 1
fi

file=$1

ans=0
while IFS='' read -r line || [[ -n "$line" ]]
do
	number=$(echo "$line" | sed -nE 's/([0-9]*).*/\1/p')
	operator=$(echo "$line" | sed -nE 's/.*([-+\*\/]).*/\1/p')	
	ans=$(( $ans $operator $number ))	
done < "$1"
unset IFS

echo $ans
