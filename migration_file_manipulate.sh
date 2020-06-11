#! /bin/bash

startdir=$(pwd)
echo "*** MIGRATION ACRONYM MOVER ***"
read -p 'Input the filename containing migration acronyms: ' inputfile
read -p 'Input DART report number (e.g. for DART-320 enter 320): ' reporttype
read -p 'Input date of file (e.g. 20200611): ' datestring
echo "Current directory: $startdir"
read -p 'Input subdirectory to move from: $startdir' subdirfrom
read -p 'Input subdirectory to move to: $startdir' subdirto

while IFS= read -r line
do
	cd $subdirfrom
	mv $line*$reporttype*$datestring* "$startdir/$subdirto"
	cd "$startdir/$subdirto"
	ls $line*$reporttype*$datestring*
	cd "$startdir"
done < "$inputfile"

echo "Done!"