#!/bin/bash
#xinteract 

data_dir='./xinteract_results'
results="./iprophet_results"
logs="./logs"
output=${0##*/}
cores=16

#if [ -d "$results" ]; then
#        rm -ifr $results/*
#        echo "WARN: previous results from $results were deleted"
#fi

mkdir -p $results

command="InterProphetParser THREADS=$cores DECOY=reverse_ $data_dir/interact-umpire*34*pep.xml $results/umpire_34_single.iprophet.pep.xml"
 
bsub  -M 30000 -R"select[(mem > 32000 )&&ncpus>=16]" -o $logs/$output.log $command 

