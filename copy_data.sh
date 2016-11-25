data='./data.raw_all'
results="./data.raw"
logs="./logs"
bin="/g/software/bin"
pattern="filtered"
output=${0##*/}

if [ -d "$results" ]; then
    rm -ifr $results/*
    echo "WARN: previous results from $results were deleted"
fi

mkdir -p $results

if [ -d "$logs" ]; then
    rm -ifr $logs/*
    echo "WARN: previous results from $logs were deleted"
fi

mkdir -p $logs

rsync -aP `ls $data/* | grep -i $pattern` $results
#for dataset in `ls $data/* | grep -Pi $pattern`
#do
#   
#    file=`basename $dataset .mgf`
#    echo $file
#    cp $dataset $results
#    #mv $results/${file}.mgf $results/umpire_${file}.mgf
#
#done

