#All miRNA predictions are done through the miRDeep2 package.  This is done through a
#  series fo loops to limit the number of allowed mapping positions.  It is important to
#  note that this script puts all jobs in the background.  So this particular version
#  results in 78 (6*13) background jobs.  Adjust accordingly.

# make sure that all background processes are finished
wait

#move to the results directory
cd $RESULTS_DIR

#miRNAs will be predicted across each sample (stored in an array)
#  given here for reference - initialized in setVariables.sh
#BAT[0]=$DATA_DIR/seqData/aPal_205_L_R1_clipped.fq  
#BAT[1]=$DATA_DIR/seqData/mOcc_210_L_R1_clipped.fq  
#BAT[2]=$DATA_DIR/seqData/mYum_200_T_R1_clipped.fq
#BAT[3]=$DATA_DIR/seqData/aPal_205_T_R1_clipped.fq  
#BAT[4]=$DATA_DIR/seqData/mOcc_210_T_R1_clipped.fq  
#BAT[5]=$DATA_DIR/seqData/mYum_220_L_R1_clipped.fq
#BAT[6]=$DATA_DIR/seqData/aPal_212_T_R1_clipped.fq  
#BAT[7]=$DATA_DIR/seqData/mOcc_211_L_R1_clipped.fq  
#BAT[8]=$DATA_DIR/seqData/mYum_220_T_R1_clipped.fq
#BAT[9]=$DATA_DIR/seqData/mOcc_211_T_R1_clipped.fq
#BAT[10]=$DATA_DIR/seqData/mYum_200_L_R1_clipped.fq
#BAT[11]=$DATA_DIR/seqData/eFus_DAR_T_R1_clipped.fq  
#BAT[12]=$DATA_DIR/seqData/eFus_834_T_R1_clipped.fq

#likewise, each species maps to different genomes.
#  given here for reference - initialized in setVariables.sh
#GENOME[0]=$EFUS_GENOME
#GENOME[1]=$MLUC_GENOME
#GENOME[2]=$MLUC_GENOME
#GENOME[3]=$EFUS_GENOME
#GENOME[4]=$MLUC_GENOME
#GENOME[5]=$MLUC_GENOME
#GENOME[6]=$EFUS_GENOME
#GENOME[7]=$MLUC_GENOME
#GENOME[8]=$MLUC_GENOME
#GENOME[9]=$MLUC_GENOME
#GENOME[10]=$MLUC_GENOME
#GENOME[11]=$EFUS_GENOME
#GENOME[12]=$EFUS_GENOME

# the $j variable will set the limit on the number of allowed mapping positions
for j in 1 5 100 1000 10000 100000
do

	#for each mapping limit, predict on each bat
	for (( i = 0; i < ${#BAT[@]}; i++))
		do
        
			#generates a base for each sample to be used to organize results
			#  for example eFus_834_T_R1_clipped.fq limited to 10 mapping positions
			#  becomes eFus_834_T_10
			BASE=$(basename ${BAT[$i]} _R1_clipped.fq)"_"$j

			#create a directory based on the basename and cd into it
        		TEMP_DIR=$RESULTS_DIR/$BASE
			rm -r $TEMP_DIR
			mkdir $TEMP_DIR			
			cd $TEMP_DIR

			#run mapper.pla and miRDeep2 consecutivley and in the background 
			#  like so (mapper.pl; miRDeep2.pl) &
			#  this puts 13 jobs per mapping limit into the backround.  
			#  See miRDeep2 documentation for information on paramters used
			#  but major ones are
			#  	-l : reads must be atleast 18bp long
			#	-? : identical reads are collapsed
			#	-r : reads are limited to $j mapping positions
			#	reads are compared to the eFus miRNAs from miRBase
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
