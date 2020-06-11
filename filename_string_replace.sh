#! /bin/bash

read -p 'Input file pattern to search (use * for all in this dir): ' filemask
read -p 'Input string to be replaced: ' find
read -p 'Input string that will replace: ' replace

for filename in $filemask
do
	if [ "$filename" == "${filename/$find/$replace}" ];
		then echo Unchanged: "$filename"
	else
		mv "$filename" "${filename/$find/$replace}"
		echo Changed: "${filename/$find/$replace}"
	fi
done
