#!/bin/bash
#performs X!Tandem spectra matching

data_dir='./tandem_input'
logs="./logs"
bin="/g/software/bin"
output="${0##*/}"
threads=8

mkdir -p $logs
 
for dataset in `find $data_dir/* -type f | grep ".input$"`
do

    bsub -n $threads -M 8000 -R"select[(mem > 10000 )&&ncpus>=$threads] span[hosts=1]" -o $logs/$output.log $bin/tandem $dataset

done
