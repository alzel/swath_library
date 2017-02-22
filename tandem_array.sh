#!/bin/bash
#performs tandem search
#BSUB -R "span[hosts=1]"
#BSUB -o ./logs/tandem_array.%I
#BSUB -e ./logs/tandem_array.%I
#BSUB -R "select[(mem > 6400)]&&ncpus>=8]"
#BSUB -R "rusage[mem=4480]"
#BSUB -M 4048
#BSUB -n 8

data_dir='./tandem_input'
data_dir2='./data.raw'
logs="./logs"
bin="/g/software/bin"
output=${0##*/}
pattern=".input$"

files=(`find $data_dir/* -type f | grep $pattern`)
memory=(`ls -la $data_dir2/*mzXML | perl -pe 's/[ ]+/\t/g'| cut -f5 | perl -ne '$a = int($_/1000000); print "$a\n"'`) 


mem=$LSB_JOBINDEX-1
dataset=${files[$mem]}

echo $dataset ${memory[$mem]}



#$bin/tandem $dataset

#filename=`basename $dataset $pattern`
#filename=$results/$filaneme.tandem.xml
#if [ -f $filename ]; then
#    file=`basename $filename .xml`
#    $bin/Tandem2XML $dataset $results/${file}".pep.xml"
#fi



