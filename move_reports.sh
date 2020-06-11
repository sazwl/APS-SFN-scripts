#! /bin/bash

echo DART report file mover
echo Make sure you are in the root dir of the interface before proceeding!
echo E.g.: /u01/shared/pc/files/OUT/IF_148

read -p 'Input date string: ' datestring
read -p 'Input Acronym: ' acro
read -p 'Input report type (eg 312): ' reporttype
read -p 'Input subdirectory to move FROM (e.g. Ready): ' subdirfrom
read -p 'Input sub/directory to move TO: (e.g. Ready or /tmp)' subdirto
acro="*$acro"


cd $subdirfrom
mv $acro*$reporttype*$datestring* $subdirto


