#!/bin/bash
#xinteract 

#data='./search_files'
data='./pseudo_spectra'
#results=$data
results="./xinteract_results"
logs="./logs"
output=${0##*/}


#old_results=(`ls $results/* | grep -Pi "^interact"`)

#if [ ${#old_results[@]} -eq 0 ]; then
#    echo "No old results were found"
#else
#    for file in "${old_results[@]}"; do
#        echo "WARN: previous result $file was deleted"
#        rm -f "$file"
#    done
#fi

#if [ -d "$results" ]; then
#    rm -ifr $results/*
#    echo "WARN: previous results from $results were deleted"
#fi

mkdir -p $results

pattern=".*.pep.xml$"

for dataset in `ls $data/* | grep -v interact | grep -Pi "$pattern"`
do  
    echo $dataset
    file=`basename $dataset`
    echo $file
    
    command="xinteract -OARPd -dreverse_ -N$results/interact-$file $dataset"
    bsub  -M 8000 -R"select[(mem > 10000 )&&ncpus>=2]" -o $logs/$output.tandem.log $command

done
