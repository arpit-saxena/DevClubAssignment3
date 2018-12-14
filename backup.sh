#!/bin/bash

if [ $# -ne 2 ]; then
	echo "Usage: $0 path/to/dir1 path/to/dir2"
	exit 1
fi

function sync()
{
	IFS=$'\n'

	local dir1=$( realpath $1 )
	local dir2=$( realpath $2 )

	#Syncing directory structure
	echo "Directories created in $dir2 are:"
	for dname in $( find "$dir1" -type d | sed -E "s@$dir1/?@@g" | tail -n +2  ); do
		local destdir="$dir2/$dname"
		if ! [ -d "$destdir" ]; then
			mkdir "$destdir"
			echo "$dname"
		fi
	done

	#Syncing files
	echo "Files copied from $1 to $2 are:"
	for filename in $( find "$dir1" -type f | sed -E "s@^$dir1/@@g" ); do
		local tempdir=$(dirname $filename)

		if [ $tempdir = '.' ]; then
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

if [ ! -d $1 ]; then
	echo "Directory $1 not found"
	exit 1
elif [ ! -d $2 ]; then
	echo "Directory $2 not found"
	exit 1
fi

sync $1 $2
sync $2 $1
