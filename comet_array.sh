#!/bin/bash
#performs comet search
#BSUB -R "span[hosts=1]"
#BSUB -o ./logs/comet_array.%I
#BSUB -e ./logs/comet_array.%I
#BSUB -R "select[(mem > 10000)]&&ncpus>=8]"


data_dir='./data.raw'
param_file="./assay/comet.params"
logs="./logs"
bin="/g/software/bin"
output=${0##*/}
pattern=".mzXML$"

files=(`find $data_dir/* -type f | grep $pattern`)

mem=$LSB_JOBINDEX-1
dataset=${files[$mem]}
echo $dataset
$bin/comet -P$param_file $dataset


