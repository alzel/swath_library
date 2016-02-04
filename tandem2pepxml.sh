#!/bin/bash

#converts tandem to pep.xml 

data='./data.raw'
results=$data
logs="./logs"
bin="/g/software/bin"
output=${0##*/}


mkdir -p $logs


for dataset in `ls $data/* | grep ".tandem.xml$"`
do
   
    file=`basename $dataset .xml`
    echo $file

    bsub  -M 8000 -R"select[(mem > 10000 )&&ncpus>=2]" -o $logs/$output.log $bin/Tandem2XML $dataset $results/${file}".pep.xml"

done
