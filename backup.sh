#!/bin/bash

if [ -z $2 ]; then
	echo "Usage: $0 path/to/dir1 path/to/dir2"
	exit 1
fi

function sync()
{
	IFS=$'\n'
	echo "Files copied from $1 to $2 are:"

	local dir1=$( realpath $1 )
	local dir2=$( realpath $2 )

	for filename in $( find "$dir1" -type f | sed -E "s@^$dir1/@@g" ); do
		local tempdir=$(dirname $filename)

		if [ tempdir = '.' ]; then
			local destdir="$dir2"
		else
			local destdir="${dir2}/$tempdir"
		fi

		if [ -z $( find $destdir -maxdepth 1 -name $( basename $filename ) )  ]; then
			echo $filename
			cp ${dir1}/${filename} $destdir
		fi
	done
	unset IFS
}

sync $1 $2
sync $2 $1
