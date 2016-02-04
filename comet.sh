#!/bin/bash
#performs comet search

data_dir='./data.raw'
param_file="./assay/comet.params"
logs="./logs"
bin="/g/software/bin"
output=${0##*/}
pattern=".mzXML$"
threads=8

for dataset in `find $data_dir/* -type f | grep $pattern`
do
    bsub  -M 8000 -R"select[(mem > 10000 )&&ncpus>=$threads] span[hosts=1]" -o $logs/$output.log $bin/comet -P$param_file $dataset
done
