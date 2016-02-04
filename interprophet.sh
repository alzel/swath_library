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
command="InterProphetParser THREADS=$cores DECOY=reverse_ $data_dir/interact.comet.pep.xml $data_dir/interact.tandem.pep.xml $results/iprophet.pep.xml"
 
bsub  -M 16000 -R"select[(mem > 20000 )&&ncpus>=${cores}] span[hosts=1] " -o $logs/$output.log $command 

