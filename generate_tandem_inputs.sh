#!/bin/bash

#generates input files for X!Tandem 

data='./data.raw'
output=$data
results="./tandem_input"
bin="/g/software/bin"
pattern="mzXML"
assay="./assay"
taxon="mouse"

if [ -d "$results" ]; then
        rm -ifr $results/*
        echo "WARN: previous results from $results were deleted"
fi

mkdir -p $results


for dataset in `ls $data/* | grep -i $pattern`
do
   
    file=`basename $dataset .mzXML`
    echo $file
    input_file=$results/${file}.input
    echo "<?xml version=\"1.0\"?>" > $input_file
    echo "<bioml>" >> $input_file
#    echo"        <note>"
#    echo"        Each one of the parameters for x! tandem is entered as a labeled note node."
#    echo"        Any of the entries in the default_input.xml file can be over-ridden by"
#    echo"        adding a corresponding entry to this file. This file represents a minimum"
#    echo"        input file, with only entries for the default settings, the output file"
#    echo"        and the input spectra file name."
#    echo"        See the taxonomy.xml file for a description of how FASTA sequence list"
#    echo"        files are linked to a taxon name."
#    echo"        </note>"

    echo "        <note type=\"input\" label=\"list path, default parameters\">${assay}/xtandem.params</note>" >> $input_file
    echo "        <note type=\"input\" label=\"list path, taxonomy information\">${assay}/taxonomy.xml</note>" >> $input_file

    echo "        <note type=\"input\" label=\"protein, taxon\">$taxon</note>" >> $input_file
                
    echo "        <note type=\"input\" label=\"spectrum, path\">$dataset</note>" >> $input_file

    echo "        <note type=\"input\" label=\"output, path\">$output/${file}".tandem.xml"</note>" >> $input_file
    echo "</bioml>" >> $input_file
    #bsub  -M 8000 -R"select[(mem > 10000 )&&ncpus>=2]" -o $logs/$output.log $bin/msconvert $dataset --mgf -o $results --outfile ${file}".mgf"

done

