#!/bin/bash
bin="/g/software/bin"
data="./pseudo_spectra" 
#results="./search_files"
results=$data
output=${0##*/}
logs="./logs"



old_results=(`ls $data/* | grep -Pi ".*Q\\d+.mzXML"`)

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


pattern="mgf"

mkdir -p $logs

for dataset in `find $data/* -type f | grep $pattern`
do  echo "submiting $dataset"
    file=`basename $dataset .$pattern`
    bsub  -M 8000 -R"select[(mem > 10000 )&&ncpus>=2]" -o $logs/$output.log $bin/msconvert --mzXML $dataset -o $results --outfile ${file}.mzXML
done

