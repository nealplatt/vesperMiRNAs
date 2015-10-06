# miRNA prediction script
##############################################################

wait

cd $RESULTS_DIR

for j in 1 5 100 1000 10000 100000
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
