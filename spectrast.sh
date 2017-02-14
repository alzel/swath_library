#!/bin/bash

data="./data.raw"
target="iprophet.pep.xml"
assay="./assay"
database="yeast.fasta"
results="./spectrast_results"
logs="./logs"
output=${0##*/}
cores=16


mkdir -p $results
#cp iprophet_results/$target $data


file=`basename $target .pep.xml`

Mayu.pl -A iprophet_results/$target -C $assay/$database -E reverse_ -G 0.01 -H 51 -I 2 -P protFDR=0.01:t -M $file

cutoff=`cat ${file}_psm_protFDR0.01_t_1.07.csv | tail -n+2 | tr ',' '\t' | cut -f5 | sort -g | head -1`

bsub  -M 8000 -R"select[(mem > 10000 )&&ncpus>=2] span[hosts=1]" -o logs/$output.log spectrast -cN${results}/${file}_irt -cICID-QTOF -cf "Protein! ~ reverse_" -cP${cutoff} -c_IRT${assay}/iRT_microSWATH.txt -c_IRR iprophet_results/$target
bsub  -M 8000 -R"select[(mem > 10000 )&&ncpus>=2] span[hosts=1]" -o logs/$output.log spectrast -cN${results}/$file -cICID-QTOF -cf "Protein! ~ reverse_" -cP${cutoff} iprophet_results/$target
