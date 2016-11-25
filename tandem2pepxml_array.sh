#!/bin/bash
#performs tandem search
#BSUB -R "span[hosts=1]"
#BSUB -o ./logs/tandem_array_o.%I
#BSUB -e ./logs/tandem_array_e.%I
#BSUB -R "select[(mem > 10000)]&&ncpus>=8]"


data_dir='./tandem_input'
results=$data
logs="./logs"
bin="/g/software/bin"
output=${0##*/}
pattern=".tandem.xml$"

files=(`find $data_dir/* -type f | grep $pattern`)

mem=$LSB_JOBINDEX-1
dataset=${files[$mem]}

file=`basename $dataset .xml`
$bin/Tandem2XML $dataset $results/${file}".pep.xml"



