#!/bin/bash
./copy_data.sh
logs="./logs"
mkdir -p $logs


#tandem inputs 
./generate_tandem_inputs.sh
data_dir='./tandem_input'
pattern=".input$"
files=(`find $data_dir/* -type f | grep $pattern`)
fLen=${#files[*]} 
echo "total files to process with pattern $pattern from $data_dir: $fLen"
wait_job1=`bsub -J "tandem[1-$fLen]%30" < ./tandem_array.sh | sed 's/[^0-9]*//g'` 

#wait_job_AAA=`bsub -w "ended($wait_job1)" < ./tandem2pepxml_runner.sh | sed 's/[^0-9]*//g'`

#comet
data_dir='./data.raw'
pattern=".mzXML$"
files=(`find $data_dir/* -type f | grep $pattern`)
fLen=${#files[*]} 
echo "total files to process with pattern $pattern from $data_dir: $fLen"
wait_job2=`bsub -J "comet[1-$fLen]%30" < ./comet_array.sh | sed 's/[^0-9]*//g'`



#tandem2pepxml
#wait_job2=`bsub -J "comet[1-$fLen]%30" < ./comet_array.sh | sed 's/[^0-9]*//g'`

wait_job3=`bsub -w "ended($wait_job1)&&ended($wait_job2)" < ./xinteract.sh | sed 's/[^0-9]*//g'`
