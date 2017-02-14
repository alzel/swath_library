#!/bin/bash
bin="/g/software/bin"
data="./data.raw_all" 
#results="./search_files"
results=$data
output=${0##*/}
logs="./logs"



old_results=(`ls $data/* | grep -Pi ".*_filtered.mzXML"`)

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


pattern="mzXML"

mkdir -p $logs

for dataset in `find $data/* -type f | grep $pattern`
do  
    file=`basename $dataset .$pattern`
    bsub  -M 8000 -R"select[(mem > 10000 )&&ncpus>=2]" -o $logs/$output.log $bin/msconvert --mzXML $dataset --filter "threshold count 1000 most-intense"  -o $results --outfile ${file}_filtered.mzXML
done

