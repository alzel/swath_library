#!/bin/bash

#data='./search_files'
data='./spectrast_results'
results=$data
#results="./xinteract_results"
logs="./logs"
output=${0##*/}
assay="./assay"

old_results=(`ls $results/* | grep openswath.csv`)

if [ ${#old_results[@]} -eq 0 ]; then
    echo "No old results were found"
else
    for file in "${old_results[@]}"; do
        echo "WARN: previous result $file was deleted"
        rm -f "$file"
    done
fi
pattern=".*.sptxt$"

for dataset in `ls $data/* | grep "cons" | grep -Pi "$pattern"`
do  
    echo $dataset
    file=`basename $dataset .sptxt`
    echo $file
    command="spectrast2tsv.py -l 350,2000 -s b,y -x 1,2 -o 6 -n 6 -p 0.05 -d -e -w $assay/swaths.txt -k openswath -a $results/${file}_openswath.csv $dataset"
    bsub  -M 8000 -R"select[(mem > 8000 )&&ncpus>=4]" -o $logs/$output.log $command
done
