=#! /bin/bash

# Matt Saywell initial version: 20200712
# Matt Saywell version 2: 20210120

startdir=$(pwd)
echo "*** BULK ACRONYM MOVE FOR DART/EMIS ***"

# process parameters
while getopts "abcd" opt; do
        case $opt in
                a)
                echo "- DART bulk move"
                option="a"
		detail="This script works under ths assumption that the files meet the following pattern: *WP_[ACRONYM]*REPORT_TYPE*DATE*"
                ;;
                b)
                echo "- DART bulk copy"
		option="b"
		detail="This script works under ths assumption that the files meet the following pattern: *WP_[ACRONYM]*REPORT_TYPE*DATE*"
                ;; 
                c)
                echo "- EMIS-99 bulk move"
		option="c"
		detail="This script works under ths assumption that the files meet the following pattern: *RECON*ACRONYM*DATE*"
                ;;
                d)
                echo "- EMIS-99 bulk copy"
		option="d"
		detail="This script works under ths assumption that the files meet the following pattern: *RECON*ACRONYM*DATE*"
                ;;
				e)
                echo "- DART bulk find"
		option="e"
		detail="This script works under ths assumption that the files meet the following pattern: *WP_[ACRONYM]*REPORT_TYPE*DATE*"
                ;;
		\?)
                echo "Usage: -a DART bulk move | -b DART bulk copy | -c EMIS-99 bulk move | -d EMIS-99 bulk copy | -e DART bulk find"
                exit
                ;;
        esac
done

if [ -z "$option" ] #if name is undefined no parameter has been passed and program exits
then
   echo "Usage: -a DART bulk move | -b DART bulk copy | -c EMIS-99 bulk move | -d EMIS-99 bulk copy | -e DART bulk find"
   exit
fi

echo "$detail"
read -p 'Input the filename containing DART migration acronyms (file must be in the current pwd): ' inputfile
# Differing options for DART and EMIS99 defined here
if [ "$option" = "a" ] || [ "$option" = "b" ] 
then
	read -p 'Input DART report number string (e.g. DART-312 = 312TRC_2 DART-312_V03 = 312TRC_V03): ' reporttype
	read -p 'Input date of file as yymmdd (e.g. 200611): ' datestring
else
	read -p 'Input date of file as ddmmyy (e.g. 110620): ' datestring
fi

if [ "$option" = "a" ] || [ "$option" = "b" ] || [ "$option" = "c" ] || [ "$option" = "d" ] #If option requires directory move, request dir, if not then proceed without
then
	echo "Current directory: $startdir"
	read -p 'Input full directory to move/copy from: ' subdirfrom
	read -p 'Input full directory to move/copy to: ' subdirto
else
	break
fi

# option -a - DART move
if [ "$option" = "a" ]; 
	then
		while IFS= read -r line
		do
			cd $subdirfrom
			mv -t "$subdirto" *WP_$line*$reporttype*$datestring*
			cd "$subdirto"
			ls *WP_$line*$reporttype*$datestring*
			cd "$startdir"
		done < "$inputfile"

		echo "Done! Check for any errors in the above output."
fi

# option -b  - DART copy
if [ "$option" = "b" ]; 
	then
		while IFS= read -r line
		do
			cd $subdirfrom
			cp *WP_$line*$reporttype*$datestring* "$subdirto"
			cd "$subdirto"
			ls *WP_$line*$reporttype*$datestring*
			cd "$startdir"
		done < "$inputfile"

		echo "Done! Check for any errors in the above output."
fi

# option -c  - EMIS99 move
if [ "$option" = "c" ]; 
	then
		while IFS= read -r line
		do
			cd $subdirfrom
			mv -t "$subdirto" *RECON*$line*$datestring*
			cd "$subdirto"
			ls *RECON*$line*$datestring* 
			cd "$startdir"
		done < "$inputfile"

		echo "Done! Check for any errors in the above output."
fi

# option -d  - EMIS99 copy
if [ "$option" = "d" ]; 
	then
		while IFS= read -r line
		do
			cd $subdirfrom
			cp *RECON*$line*$datestring* "$subdirto"
			cd "$subdirto"
			ls *RECON*$line*$datestring* 
			cd "$startdir"
		done < "$inputfile"

		echo "Done! Check for any errors in the above output."

fi

# option -e  - DART find
if [ "$option" = "e" ]; 
	then
		while IFS= read -r line
		do
			find . -name *WP_$line*$reporttype*$datestring*
		done < "$inputfile"
fi