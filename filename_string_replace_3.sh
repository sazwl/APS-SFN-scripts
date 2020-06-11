#! /bin/bash

echo Filename String Replace
echo Use -a to replace first instance of string found only
echo Use -b to replace last instance of string found only
echo Use -c to replace all isntance of string found in filename

while getopts "abc" opt; do
        case $opt in
                a)
                echo "First instance of string found will be replaced"
		aflag=1
                ;;
                b)
                echo "-b triggered"
		bflag=1
		;;
		c)
		echo "All instances of string found will be replaced"
		cflag=1
                ;;
                \?)
                echo "Usage: -a | -b"
                ;;
        esac
done

read -p 'Input file pattern to be considered in this find/replace (use * for all in this dir or use a wildcard mask): ' filemask
read -p 'Input string to be found within filenames: ' find
read -p 'Input string to replaced within filenames: ' replace

if [ ! -z "$aflag" ]; 
	then
		for filename in $filemask
		do
			if [ "$filename" == "${filename/$find/$replace}" ];
				then echo Unchanged: "$filename"
			else
				mv "$filename" "${filename/$find/$replace}"
				echo Changed: "${filename/$find/$replace}"
			fi
		done
fi

if [ ! -z "$bflag" ]; 
        then
                for filename in $filemask
                do
                        if [ "$filename" == "${filename/%$find/$replace}" ];    #logic not working
                                then echo Unchanged: "$filename"
                        else
                                mv "$filename" "${filename/%$find/$replace}"
                                echo Changed: "${filename/%$find/$replace}"
                        fi
                done
fi

if [ ! -z "$cflag" ]; 
        then
                for filename in $filemask
                do
                        if [ "$filename" == "${filename//$find/$replace}" ];
                                then echo Unchanged: "$filename"
                        else
                                mv "$filename" "${filename//$find/$replace}"
                                echo Changed: "${filename//$find/$replace}"
                        fi
                done
fi

