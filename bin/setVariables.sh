# This script sets variables that are used in many of the analyses.
#  They are being stored here so that this script can be run and then all
#  variables will be available for manual processing.  In some cases the
#  variable is created here, in other cases other subPrograms create it, 
#  but since these may be skipped further down the line, all are stored
#  here.

# Major Directories
WORK_DIR="/lustre/scratch/roplatt/myotisSmallRNAs"
RESULTS_DIR="$WORK_DIR/results"
DATA_DIR="$WORK_DIR/data"
BIN_DIR="$WORK_DIR/bin"

# Path to Binaries
FASTX_DIR="/lustre/work/apps/fastx_toolkit-0.0.14/bin"
MIRDEEP_DIR="/lustre/work/apps/mirdeep2_0_0_7/"
MIRDEEP_BOWTIE="$MIRDEEP_DIR/essentials/bowtie-1.1.1"
BLAST_DIR="/lustre/work/apps/blast/bin"
BEDTOOLS_DIR="/lustre/work/apps/bedtools-2.17.0/bin"

# Path to Genome Data
MLUC_GENOME=$DATA_DIR/genome/mLuc_scaffolds_cleanName.fas
EFUS_GENOME=$DATA_DIR/genome/eFus_scaffolds_cleanName.fas

# Adapters Sequence (used for trimming/QC)
ADAPTER_SEQ=AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC

# miRNA fasta file (processed in the getMiRNAs.sh script
MIRBASE_MATURE=$DATA_DIR/miRBase/efu_matureMirnas.fa
MIRBASE_HAIRPIN=$DATA_DIR/miRBase/efu_hairpinMirnas.fa

#Arrays containing sequence and corresposing genome data
# (used in the predictWmiRDeep2.sh script)
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


