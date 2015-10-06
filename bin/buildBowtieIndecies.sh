# Build bowtie indecies
###############################
cd $GENOME_DIR
bowtie-build $MLUC_GENOME $MLUC_GENOME &
bowtie-build $EFUS_GENOME $EFUS_GENOME &

#these are put in the background and need to be completed prior to running miRDeep2
