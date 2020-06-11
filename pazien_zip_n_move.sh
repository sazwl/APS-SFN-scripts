#! /bin/bash

# 20200611 - version 1 - Matt Saywell

startdir=$(pwd)
echo "*** PAZIEN ZIP AND EXTRACT ***"
echo "This script will zip pazien files and move them to a specified temp directory and sets permissions so files are ready to be extracted using WinSCP"

# process parameters
while getopts "atscrf" opt; do
        case $opt in
                a)
                echo "- Pazien AUTHS extract"
                prefix="Auths"
                name="Pazien_Auths_"
                ;;
                t)
                echo "- Pazien SalesRefunds TXN extract"
		        prefix="SalesRefunds"
		        suffix="txn"
		        name="Pazien_SalesRefundsTXN_"
                ;; 
                s)
                echo "- Pazien SalesRefunds STL extract"
		        prefix="SalesRefunds"
		        suffix="stl"
		        name="Pazien_SalesRefundsSTL_"
                ;;
                c)
                echo "- Pazien CHBK extract"
                prefix="Chargebacks"
                name="Pazien_Chargebacks_"
                ;;
                r)
                echo "- Pazien RECON extract"
                prefix="Recon"
                name="Pazien_Recon_"
                ;;
				f)
                echo "- Pazien FEES extract"
                prefix="Fees"
                name="Pazien_Fees_"
                ;;
                \?)
                echo "Usage: -a AUTHS | -t TXN | -s STL | -c CHBKS | -r RECON | -f FEES"
                exit
                ;;
        esac
done

if [ -z "$name" ] #if name is undefined no parameter has been passed and program exits
then
   echo "Use parameters to define extract mode. Usage: -a AUTHS | -t SalesRefunds TXN | -s SalesRefunds STL | -c CHBKS | -r RECON | -f FEES" 
   exit
fi

read -p 'Input date string yyyymmdd (e.g. 20200611): ' datestring
echo "Remember to ensure all IF_417 jobs have completed in Control-M before extracting. Use Ctrl+C to quit if necessary."
#echo "Current directory: $startdir"
read -p 'Input directory to extract to (e.g. /tmp/Matt): ' dirto
filename="$name$datestring.zip"

cd /u01/shared/pc/data/IF_417/Complete
count=$(ls *$prefix*$datestring*$suffix*  | wc -l)
echo "Count of $prefix $suffix files in IF_417/Complete: $count"
read -p 'Does the count look correct? Press enter to continue, Ctrl+C to exit'
echo "Zipping files"
zip -rjq "$filename" *$prefix*$datestring*$suffix*
echo "Moving created file"
mv "$filename" "$dirto"
cd "$dirto"
echo "Setting permissions"
chmod 777 "$filename"
echo "ZIP creation and file move complete. Check for error messages in output"
pwd
ls -ltr "$filename"
