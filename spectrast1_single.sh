#!/bin/bash

data="./pseudo_spectra"
target="umpire_34_single.iprophet.pep.xml"

results="./spectrast_results"
logs="./logs"
output=${0##*/}
cores=16


mkdir -p $results
cp iprophet_results/$target $data


file=`basename $target .iprophet.pep.xml`

Mayu.pl -A iprophet_results/$target -C fasta/yeast.fasta -E reverse_ -G 0.01 -H 51 -I 2 -P protFDR=0.01:t -M $file

cutoff=`cat ${file}_psm_protFDR0.01_t_1.07.csv | tail -n+2 | tr ',' '\t' | cut -f5 | sort -g | head -1`

bsub  -M 8000 -R"select[(mem > 10000 )&&ncpus>=2]" -o logs/$output.log spectrast -cN${results}/${file}_irt -cICID-QTOF -cf "Protein! ~ reverse_" -cP${cutoff} -c_IRTiRT_microSWATH.txt -c_IRR $data/$target
bsub  -M 8000 -R"select[(mem > 10000 )&&ncpus>=2]" -o logs/$output.log spectrast -cN${results}/$file -cICID-QTOF -cf "Protein! ~ reverse_" -cP${cutoff} $data/$target

