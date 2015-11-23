#!/bin/bash
#$ -V
#$ -cwd
#$ -S /bin/bash
#$ -N rep1K
#$ -o $JOB_NAME.o$JOB_ID
#$ -e $JOB_NAME.e$JOB_ID
#$ -q Chewie
#$ -pe fill 100
#$ -P communitycluster

HOME_DIR=/lustre/scratch/roplatt/vesperSmallRNAs
DATA_DIR=$HOME_DIR/data
GENOMES_DIR=$DATA_DIR/genomes
RAWDATA_DIR=$DATA_DIR/rawData

RESULTS_DIR=$HOME_DIR/results

BIN_DIR=$HOME_DIR/bin


READS[0]=$RESULTS_DIR/qcSeqData/cow_T_QC.fq
READS[1]=$RESULTS_DIR/qcSeqData/mOcc_T_QC.fq

GENOME[0]=$RESULTS_DIR/bowtieIndecies/bosTau8.fa
GENOME[1]=$RESULTS_DIR/bowtieIndecies/myoLuc2.fa

BASE[0]=bTau_T
BASE[1]=mOcc_T

#mkdir /lustre/scratch/roplatt/vesperSmallRNAs/results/mirnaPreds/replicatePred
cd /lustre/scratch/roplatt/vesperSmallRNAs/results/mirnaPreds/replicatePred


a=1

while [ $a -le 1000 ]
do

    start=$a
    end=$((a+99))

    
    for (( i = 0; i < ${#READS[@]}; i++))
    do
    
        for j in $(seq $start $end )
        do

            TEMP_DIR=$RESULTS_DIR/mirnaPreds/replicatePred/${BASE[$i]}_rep$j
            mkdir $TEMP_DIR
            cd $TEMP_DIR

	        (      
            mapper.pl \
                ${READS[$i]} \
                -e \
                -h \
                -m \
                -j \
                -l 18 \
                -v \
                -n \
                -r 5 \
                -s $TEMP_DIR/${BASE[$i]}"_rep"$j"_mapperProcessed.fa" \
                -t $TEMP_DIR/${BASE[$i]}"_rep"$j"_mapperProcessed.arf" \
                -p ${GENOME[$i]} \
		        >${BASE[$i]}"_rep"$j".mapper.log" 2>&1 ;\
            miRDeep2.pl \
                $TEMP_DIR/${BASE[$i]}"_rep"$j"_mapperProcessed.fa" \
                ${GENOME[$i]} \
	            $TEMP_DIR/${BASE[$i]}"_rep"$j"_mapperProcessed.arf" \
	            none \
	            none \
	            none \
	            -z "#"${BASE[$i]}"_"$j"rep" \
	            -P \
		        >${BASE[$i]}"_"$j"rep.miRDeep2.log" 2>&1
	        ) &     
            cd ..
        
        done

        #wait till all predictions from this replicate ($j) are done.
        wait

    done


    #increment a by 100
    a=$((a+100))

#close the while loop
done


