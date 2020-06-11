#! /bin/bash

# 20200524 - version 4 - Matt Saywell

echo "*** Filename Substring Replace ***"
echo "-- Use -f to replace first instance of substring found only"
echo "-- Use -l to replace last instance of substring found only"
echo "-- Use -a to replace all isntance of substring found in filename"

# process parameters
while getopts "fla" opt; do
        case $opt in
                f)
                echo "- First instance of substring found will be replaced"
                option=f
                ;;
                l)
                echo "- Last instance of substring found will be replaced"
		        option=l
                ;; 
                a)
                echo "- All instances of substring found will be replaced"
                option=a
                ;;
                \?)
                echo "Usage: -f | -l | -a"
                ;;
        esac
done

# if no parameters passed then exit
if [ -z "$option" ];
    then
            echo "Please pass a parameter at command line - Usage: -f | -l | -a" 
            exit
fi

# set dir. If unset then do no issue cd
read -p '> Input subdirectory or directory to be used (leave blank for current directory): ' dir
if [ ! -z "$dir" ];
    then
        cd "$dir"
        pwd
    else
        pwd
fi

# main input
read -p '> Input file pattern to be considered in this find/replace (use * for all in this dir or use a wildcard mask): ' filemask
read -p '> Input substring to be found within filenames: ' find
read -p '> Input substring to replaced within filenames: ' replace

# option -f - first substring replace
if [ "$option" = "f" ]; 
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

# option -l - last substring replace
if [ "$option" = "l" ];
        then
                for filename in $filemask
                do
                        if [[ "$filename" = *"$find"* ]];
                                 then
					               prefix=${filename%"$find"*}
					               suffix=${filename#"$prefix"}
					               newname=${prefix}${suffix/"$find"/"$replace"}
                                    mv "$filename" "$newname"
                                	echo Changed: "$newname"
				                else
					               echo Unchanged: "$filename"
                                fi
                            done
fi

# option -a - all substring replace
if [ "$option" = "a" ];
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