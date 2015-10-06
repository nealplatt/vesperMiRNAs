# Build bowtie 2 indecies for Eptesicus and Myotis lucifugus genomes
#  This is a requirement for miRDeep2

#All work is done in the genome directory
cd $GENOME_DIR
bowtie-build $MLUC_GENOME $MLUC_GENOME &
bowtie-build $EFUS_GENOME $EFUS_GENOME &

wait
#these are put in the background and take a while.
#  They need to be completed prior to miRDeep2
