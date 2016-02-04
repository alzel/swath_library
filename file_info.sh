#!/bin/bash
#performs comet search

data='../2015-12-16/data.raw'
logs="./logs"
results="./file_info"
bin="/g/software/bin"
output=${0##*/}
pattern=".mzML$"
threads=8


if [ -d "$results" ]; then
        rm -ifr $results/*
        echo "WARN: previous results from $results were deleted"
fi

mkdir -p $results

for dataset in `find $data/* -type f | grep $pattern`
do  
    file=`basename $dataset $pattern`
    bsub -n $threads  -M 8000 -R"select[(mem > 10000)&&ncpus>=$threads]" -o $logs/$output.log FileInfo  -threads $threads -m -p -s -d -c  -in $dataset -out $results/$file.txt
done
