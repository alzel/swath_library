#!/bin/bash
#xinteract 

data_dir='./data.raw'
results="./xinteract_results"
logs="./logs"
output=${0##*/}

if [ -d "$results" ]; then
        rm -ifr $results/*
        echo "WARN: previous results from $results were deleted"
fi

mkdir -p $results

command1="xinteract -OARPd -dreverse_ -N$results/interact.tandem.pep.xml $data_dir/*tandem.pep.xml"
command2="xinteract -OARPd -dreverse_ -N$results/interact.comet.pep.xml  $data_dir/*comet.pep.xml"
 
bsub  -M 8000 -R"select[(mem > 10000 )&&ncpus>=2]" -o $logs/$output.tandem.log $command1 
bsub  -M 8000 -R"select[(mem > 10000 )&&ncpus>=2]" -o $logs/$output.comet.log  $command2

