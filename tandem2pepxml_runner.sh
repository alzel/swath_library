#!/bin/bash
#performs tandem search


logs="./logs"
bin="/g/software/bin"
output=${0##*/}


#tandem2pepxml
data_dir='./data.raw'
pattern=".tandem.xml$"
files=(`find $data_dir/* -type f | grep $pattern`)
fLen=${#files[*]} 

if [ $fLen -ne 0 ]; then
    echo "total files to process with pattern $pattern from $data_dir: $fLen"
    echo -n "AAAA"; bsub -J "tandem2pepxml[1-$fLen]%30" < ./tandem2pepxml_array.sh
fi

