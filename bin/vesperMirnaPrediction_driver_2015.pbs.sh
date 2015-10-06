#set variables that are used throughout the analysis
bin/setVariables.sh

#create the major subdirectories
#bin/mkDirStructure.sh

#get bat miRNAs from miRBase into fasta form
bin/getMiRNAs.sh

#start indexing the genomes (takes some time)
bin/buildBowtieIndecies.sh

#start the miRDeep2 prediction process
bin/predictWmiRDeep2.sh

#mask each of the genomes for "Chiropteran" repeats
bin/runRepeatMasker.sh
