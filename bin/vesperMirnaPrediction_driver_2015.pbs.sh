#!/bin/bash
#$ -V
#$ -cwd
#$ -S /bin/bash
#$ -N myoSmallRNAs
#$ -o $JOB_NAME.o$JOB_ID
#$ -e $JOB_NAME.e$JOB_ID
#$ -q Chewie,R2D2
#$ -pe fill 78
#$ -P communitycluster

cd /lustre/scratch/roplatt/myotisSmallRNAs

#set variables that are used throughout the analysis
bin/setVariables.sh

#create the major subdirectories
#bin/mkDirStructure.sh

#------------------------
# Get seq data and QC it.

#-------------------------
# Get genomes and clean up


#get bat miRNAs from miRBase into fasta form
#bin/getMiRNAs.sh

#start indexing the genomes (takes some time)
#bin/buildBowtieIndecies.sh

#start the miRDeep2 prediction process
#bin/predictWmiRDeep2.sh

#mask each of the genomes for "Chiropteran" repeats
#  This is necessary to create a bed file for post processing
#  the miRNAs (seeing wich overlap with TEs).
# bin/runRepeatMasker.sh

#wait for all jobs to finish before exiting.
wait

echo "$JOB_NAME finished" | mailx -s "$JOB_NAME finished" 9034521885@txt.att.net

sleep 10

