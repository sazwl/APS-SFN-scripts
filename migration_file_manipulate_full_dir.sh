#! /bin/bash

startdir=$(pwd)
echo "*** MIGRATION ACRONYM MOVER FOR DART ***"
echo "This script works under ths assumption that the files meet the following pattern: *ACRONYM*REPORT_TYPE*DATE*"
read -p 'Input the filename containing DART migration acronyms (file must be in the current pwd): ' inputfile
read -p 'Input DART report number (e.g. for DART-320 enter 320): ' reporttype
read -p 'Input date of file (e.g. 20200611): ' datestring
echo "Current directory: $startdir"
read -p 'Input full directory to move from: ' subdirfrom
read -p 'Input full directory to move to: ' subdirto

while IFS= read -r line
do
	cd $subdirfrom
	mv *$line*$reporttype*$datestring* "$subdirto"
	cd "$subdirto"
	ls *$line*$reporttype*$datestring*
	cd "$startdir"
done < "$inputfile"

echo "Done! Check for any errors in the above output."