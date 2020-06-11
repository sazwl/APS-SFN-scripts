#! /bin/bash

read -p 'Input IF_148 subdirectory to rename all EMIS-99 files: ' subdir
read -p 'Input date string (yymmddhhmmss): ' date
date="$date*"

cd /u01/shared/pc/files/OUT/IF_148/$subdir
for filename in *EMIS-99*$date
do
	mv "$filename" "${filename:36:100}"
	echo "${filename:36:100}" renamed
done
