#!/bin/bash
#$ -V
#$ -cwd
#$ -S /bin/bash
#$ -N map100K
#$ -o $JOB_NAME.o$JOB_ID
#$ -e $JOB_NAME.e$JOB_ID
#$ -q Chewie
#$ -pe fill 15
#$ -P communitycluster

HOME_DIR=/lustre/scratch/roplatt/vesperSmallRNAs
DATA_DIR=$HOME_DIR/data
GENOMES_DIR=$DATA_DIR/genomes
RAWDATA_DIR=$DATA_DIR/rawData

RESULTS_DIR=$HOME_DIR/results

BIN_DIR=$HOME_DIR/bin


#non-bats
 READS[0]=$RESULTS_DIR/qcSeqData/dog_T_QC.fq
 READS[1]=$RESULTS_DIR/qcSeqData/cat_T_QC.fq
 READS[2]=$RESULTS_DIR/qcSeqData/cow_T_QC.fq
 READS[3]=$RESULTS_DIR/qcSeqData/dipodomys_T_QC.fq
 READS[4]=$RESULTS_DIR/qcSeqData/hedgehog_T_QC.fq
 READS[5]=$RESULTS_DIR/qcSeqData/horse_T_QC.fq
 READS[6]=$RESULTS_DIR/qcSeqData/pig_T_QC.fq
 READS[7]=$RESULTS_DIR/qcSeqData/rabbit_T_QC.fq
 READS[8]=$RESULTS_DIR/qcSeqData/squirrel_T_QC.fq
 READS[9]=$RESULTS_DIR/qcSeqData/aPal_T_QC.fq
READS[10]=$RESULTS_DIR/qcSeqData/eFus_T_QC.fq
READS[11]=$RESULTS_DIR/qcSeqData/mOcc_L_QC.fq
READS[12]=$RESULTS_DIR/qcSeqData/mOcc_T_QC.fq
READS[13]=$RESULTS_DIR/qcSeqData/mYum_T_QC.fq
READS[14]=$RESULTS_DIR/qcSeqData/mYum_L_QC.fq

#non-bats
 GENOME[0]=$RESULTS_DIR/bowtieIndecies/canFam3.fa
 GENOME[1]=$RESULTS_DIR/bowtieIndecies/felCat5.fa
 GENOME[2]=$RESULTS_DIR/bowtieIndecies/bosTau8.fa
 GENOME[3]=$RESULTS_DIR/bowtieIndecies/dipOrd1.fa
 GENOME[4]=$RESULTS_DIR/bowtieIndecies/eriEur2.fa
 GENOME[5]=$RESULTS_DIR/bowtieIndecies/equCab2.fa
 GENOME[6]=$RESULTS_DIR/bowtieIndecies/susScr3.fa
 GENOME[7]=$RESULTS_DIR/bowtieIndecies/oryCun2.fa
 GENOME[8]=$RESULTS_DIR/bowtieIndecies/speTri2.fa
 GENOME[9]=$RESULTS_DIR/bowtieIndecies/eptFus1.fa
GENOME[10]=$RESULTS_DIR/bowtieIndecies/eptFus1.fa
GENOME[11]=$RESULTS_DIR/bowtieIndecies/myoLuc2.fa
GENOME[12]=$RESULTS_DIR/bowtieIndecies/myoLuc2.fa
GENOME[13]=$RESULTS_DIR/bowtieIndecies/myoLuc2.fa
GENOME[14]=$RESULTS_DIR/bowtieIndecies/myoLuc2.fa


#non-bats
 BASE[0]=cFam_T  
 BASE[1]=fCat_T
 BASE[2]=bTau_T
 BASE[3]=dOrd_T 
 BASE[4]=eEur_T 
 BASE[5]=eCab_T
 BASE[6]=sScr_T
 BASE[7]=oCun_T 
 BASE[8]=sTri_T   
 BASE[9]=aPal_T
BASE[10]=eFus_T
BASE[11]=mOcc_L
BASE[12]=mOcc_T
BASE[13]=mYum_T
BASE[14]=mYum_L

#mkdir /lustre/scratch/roplatt/vesperSmallRNAs/results/mirnaPreds/varyingMapPos
cd /lustre/scratch/roplatt/vesperSmallRNAs/results/mirnaPreds/varyingMapPos

for j in 1 5 10 25 50 100 1000 10000 100000
do

    for (( i = 0; i < ${#READS[@]}; i++))
    do
        
        TEMP_DIR=$RESULTS_DIR/mirnaPreds/varyingMapPos/${BASE[$i]}_$j
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
                -r $j \
                -s $TEMP_DIR/${BASE[$i]}"_pos"$j"_mapperProcessed.fa" \
                -t $TEMP_DIR/${BASE[$i]}"_pos"$j"_mapperProcessed.arf" \
                -p ${GENOME[$i]} \
		        >${BASE[$i]}"_"$j"pred.mapper.log" 2>&1 ;\
      miRDeep2.pl \
               $TEMP_DIR/${BASE[$i]}"_pos5_mapperProcessed.fa" \
               ${GENOME[$i]} \
	           $TEMP_DIR/${BASE[$i]}"_pos5_mapperProcessed.arf" \
	           none \
	           none \
	           none \
	           -z "#"${BASE[$i]}"_"$j"pred" \
	           -P \
		       >${BASE[$i]}"_$jpred.miRDeep2.log" 2>&1
	) &     
        cd ..
        
    done

    #wait till all predictions from this mapping positions ($j) are done.
    wait

done


wait

