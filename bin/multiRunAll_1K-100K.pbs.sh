#!/bin/bash
#$ -V
#$ -cwd
#$ -S /bin/bash
#$ -N myoSmallRNAs
#$ -o $JOB_NAME.o$JOB_ID
#$ -e $JOB_NAME.e$JOB_ID
#$ -q Chewie,R2D2
#$ -pe fill 39
#$ -P communitycluster


WORK_DIR="/lustre/scratch/roplatt/myotisSmallRNAs"
RESULTS_DIR="$WORK_DIR/results"
DATA_DIR="$WORK_DIR/data"

MLUC_GENOME=$DATA_DIR/genome/mLuc_scaffolds_cleanName.fas
EFUS_GENOME=$DATA_DIR/genome/eFus_scaffolds_cleanName.fas

MIRDEEP_DIR="/lustre/work/apps/mirdeep2_0_0_7/"


MIRBASE_MATURE=$RESULTS_DIR/efu_matureMirnas.fa
MIRBASE_HAIRPIN=$RESULTS_DIR/efu_hairpinMirnas.fa

BAT[0]=$DATA_DIR/seqData/aPal_205_L_R1_clipped.fq  
BAT[1]=$DATA_DIR/seqData/mOcc_210_L_R1_clipped.fq  
BAT[2]=$DATA_DIR/seqData/mYum_200_T_R1_clipped.fq
BAT[3]=$DATA_DIR/seqData/aPal_205_T_R1_clipped.fq  
BAT[4]=$DATA_DIR/seqData/mOcc_210_T_R1_clipped.fq  
BAT[5]=$DATA_DIR/seqData/mYum_220_L_R1_clipped.fq
BAT[6]=$DATA_DIR/seqData/aPal_212_T_R1_clipped.fq  
BAT[7]=$DATA_DIR/seqData/mOcc_211_L_R1_clipped.fq  
BAT[8]=$DATA_DIR/seqData/mYum_220_T_R1_clipped.fq
BAT[9]=$DATA_DIR/seqData/mOcc_211_T_R1_clipped.fq
BAT[10]=$DATA_DIR/seqData/mYum_200_L_R1_clipped.fq
BAT[11]=$DATA_DIR/seqData/eFus_DAR_T_R1_clipped.fq  
BAT[12]=$DATA_DIR/seqData/eFus_834_T_R1_clipped.fq

GENOME[0]=$EFUS_GENOME
GENOME[1]=$MLUC_GENOME
GENOME[2]=$MLUC_GENOME
GENOME[3]=$EFUS_GENOME
GENOME[4]=$MLUC_GENOME
GENOME[5]=$MLUC_GENOME
GENOME[6]=$EFUS_GENOME
GENOME[7]=$MLUC_GENOME
GENOME[8]=$MLUC_GENOME
GENOME[9]=$MLUC_GENOME
GENOME[10]=$MLUC_GENOME
GENOME[11]=$EFUS_GENOME
GENOME[12]=$EFUS_GENOME


cd $RESULTS_DIR

for j in 1000 10000 100000

do

	for (( i = 0; i < ${#BAT[@]}; i++))
		do
        
			BASE=$(basename ${BAT[$i]} _R1_clipped.fq)"_"$j
        		TEMP_DIR=$RESULTS_DIR/$BASE
			rm -r $TEMP_DIR
			mkdir $TEMP_DIR			
			cd $TEMP_DIR

       			#put both of these jobs in the background to run 13 simultaneously
        		( $MIRDEEP_DIR/mapper.pl \
                		${BAT[$i]} \
                		-e \
                		-h \
                		-m \
                		-j \
                		-l 18 \
				-v \
                		-n \
                		-r $j \
                		-s $TEMP_DIR/$BASE"_mapperProcessed.fa" \
                		-t $TEMP_DIR/$BASE"_mapperProcessed.arf" \
                		-p ${GENOME[$i]}; \
           		miRDeep2.pl \
		        	$TEMP_DIR/$BASE"_mapperProcessed.fa" \
		        	${GENOME[$i]} \
		        	$TEMP_DIR/$BASE"_mapperProcessed.arf" \
		        	$MIRBASE_MATURE \
		        	none \
		        	$MIRBASE_HAIRPIN \
		        	-z "#"$BASE"_pred" \
		        	-P ) & 
			
        	cd $RESULTS_DIR
	done
done

#wait for all jobs to end before quitting
wait


echo "$JOB_NAME finished" | mailx -s "$JOB_NAME finished" 9034521885@txt.att.net

sleep 10

