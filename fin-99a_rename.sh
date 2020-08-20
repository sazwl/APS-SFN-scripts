#! /bin/bash

#Script to rename and move FIN-99a files with bad names from IF076 Error into Ready dir to be reprocessed
#Version 1.0 | Matt Saywell | 1st version

filemask="FIN-99a..*_Fin99a..yymmddhhmiss_Fin99a\ Treasury\ Daily\ report\ 1st\ run"
cd Error/
pwd
IFS='
'
for filename in $filemask
do {
    prefix=${filename:0:22}
    newname="$prefix""Treasury Daily report 1st run.xlsx.xlsx"
    mv "$filename" "$newname"
    mv "$newname" ../Ready/
    echo "$newname" renamed and moved to ../Ready/ dir
    }
done