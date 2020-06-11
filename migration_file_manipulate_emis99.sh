#! /bin/bash

startdir=$(pwd)
echo "*** MIGRATION ACRONYM MOVER FOR EMIS-99 ***"
echo "This script works under ths assumption that the files meet the following pattern: *'RECON'*ACRONYM*DATE*"
read -p 'Input the filename containing EMIS-99 migration acronyms (file must be in the current pwd): ' inputfile
read -p 'Input date of file with format ddmmyy (e.g. 010620): ' datestring
echo "Current directory: $startdir"
read -p 'Input full directory to move from: ' subdirfrom
read -p 'Input full directory to move to: ' subdirto

while IFS= read -r line
do
	cd $subdirfrom
	mv *RECON*$line*$datestring* "$subdirto"
	cd "$subdirto"
	ls *RECON*$line*$datestring* 
	cd "$startdir"
done < "$inputfile"

echo "Done! Check for any errors in the above output."