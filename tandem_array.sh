#!/bin/bash
#performs tandem search
#BSUB -R "span[hosts=1]"
#BSUB -o ./logs/tandem_array.%I
#BSUB -e ./logs/tandem_array.%I
#BSUB -R "select[(mem > 10000)]&&ncpus>=8]"


data_dir='./tandem_input'
logs="./logs"
bin="/g/software/bin"
output=${0##*/}
pattern=".input$"

files=(`find $data_dir/* -type f | grep $pattern`)

mem=$LSB_JOBINDEX-1
dataset=${files[$mem]}
echo $dataset
$bin/tandem $dataset

filename=`basename $dataset $pattern`
filename=$results/$filaneme.tandem.xml
if [ -f $filename ]; then
    file=`basename $filename .xml`
    $bin/Tandem2XML $dataset $results/${file}".pep.xml"
fi



