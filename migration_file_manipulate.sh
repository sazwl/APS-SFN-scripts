#! /bin/bash

startdir=$(pwd)
echo "*** MIGRATION ACRONYM MOVER FOR DART ***"
echo "This script works under ths assumption that the files meet the following pattern: *WP_[ACRONYM]*REPORT_TYPE*DATE*"
read -p 'Input the filename containing DART migration acronyms (file must be in the current pwd): ' inputfile
read -p 'Input DART report number string (e.g. DART-312 = 312TRC_2 DART-312_V03 = 312TRC_V03): ' reporttype
read -p 'Input date of file as yymmdd (e.g. 200611): ' datestring
echo "Current directory: $startdir"
read -p 'Input full directory to move from: ' subdirfrom
read -p 'Input full directory to move to: ' subdirto

while IFS= read -r line
do
	cd $subdirfrom
	mv -t "$subdirto" *WP_$line*$reporttype*$datestring*
	cd "$subdirto"
	ls *WP_$line*$reporttype*$datestring*
	cd "$startdir"
done < "$inputfile"

echo "Done! Check for any errors in the above output."
