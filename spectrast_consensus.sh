#!/bin/bash
#xinteract 

#data='./search_files'
data='./spectrast_results'
results=$data
#results="./xinteract_results"
logs="./logs"
output=${0##*/}


old_results=(`ls $data/* | grep cons`)

if [ ${#old_results[@]} -eq 0 ]; then
    echo "No old results were found"
else
    for file in "${old_results[@]}"; do
        echo "WARN: previous result $file was deleted"
        rm -f "$file"
    done
fi

#if [ -d "$results" ]; then
#    rm -ifr $results/*
#    echo "WARN: previous results from $results were deleted"
#fi

#mkdir -p $results


pattern=".*.splib$"

for dataset in `ls $data/* | grep -Pi "$pattern"`
do  
    echo $dataset
    file=`basename $dataset .splib`
    echo $file
     
    command="spectrast -cAC -cN $results/${file}_cons -cICID-QTOF $dataset"
    bsub  -M 8000 -R"select[(mem > 8000 )&&ncpus>=4]" -o $logs/$output.log $command
done
