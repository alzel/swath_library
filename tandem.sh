#!/bin/bash
#performs X!Tandem spectra matching

data_dir='./tandem_input'
logs="./logs"
bin="/g/software/bin"
output="${0##*/}"
threads=8

mkdir -p $logs

memory=( `ls -la data.raw/*mzXML | perl -pe 's/[ ]+/\t/g'| cut -f5 | perl -ne '$a = int($_/1000000); print "$a\n"'` )

files=( `find $data_dir/* -type f | grep ".input$"` )

if [ ${#files[@]} -ne ${#memory[@]} ]; then
    echo "Check input!"
    exit -1
fi
 
for i in "${!files[@]}"
do
    dataset=${files[$i]}
    mem=${memory[$i]}
    let "m_select = $mem * 10 + 10000"
    let "m_request = $mem * 10"

    #echo $i $mem $m_select $dataset

    bsub -J "tandem_search" -n $threads -M $m_request -R "select[(mem > $m_select)&&ncpus>=$threads] span[hosts=1]" -R "rusage[mem=$m_request]" -o $logs/$output.log $bin/tandem $dataset

done
