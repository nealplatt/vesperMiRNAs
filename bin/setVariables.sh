WORK_DIR="/lustre/scratch/roplatt/myotisSmallRNAs"
RESULTS_DIR="$WORK_DIR/results"
DATA_DIR="$WORK_DIR/data"
BIN_DIR="$WORK_DIR/bin"

FASTX_DIR="/lustre/work/apps/fastx_toolkit-0.0.14/bin"
MIRDEEP_DIR="/lustre/work/apps/mirdeep2_0_0_7/"
MIRDEEP_BOWTIE="$MIRDEEP_DIR/essentials/bowtie-1.1.1"
BLAST_DIR="/lustre/work/apps/blast/bin"
BEDTOOLS_DIR="/lustre/work/apps/bedtools-2.17.0/bin"

MLUC_GENOME=$DATA_DIR/genome/mLuc_scaffolds_cleanName.fas
EFUS_GENOME=$DATA_DIR/genome/eFus_scaffolds_cleanName.fas

ADAPTER_SEQ=AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC

#ADDED BY MIRBASE CLEAN SCRIPT
MIRBASE_MATURE=$DATA_DIR/miRBase/efu_matureMirnas.fa
MIRBASE_HAIRPIN=$DATA_DIR/miRBase/efu_hairpinMirnas.fa

#ADDED BY MIRDEEP2 PREDICTION SCRIPT
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

GENOME[0]=$DATA_DIR/genome/eptFus1.fa
GENOME[1]=$DATA_DIR/genome/myoLuc2.fa
GENOME[2]=$DATA_DIR/genome/myoLuc2.fa
GENOME[3]=$DATA_DIR/genome/eptFus1.fa
GENOME[4]=$DATA_DIR/genome/myoLuc2.fa
GENOME[5]=$DATA_DIR/genome/myoLuc2.fa
GENOME[6]=$DATA_DIR/genome/eptFus1.fa
GENOME[7]=$DATA_DIR/genome/myoLuc2.fa
GENOME[8]=$DATA_DIR/genome/myoLuc2.fa
GENOME[9]=$DATA_DIR/genome/myoLuc2.fa
GENOME[10]=$DATA_DIR/genome/myoLuc2.fa
GENOME[11]=$DATA_DIR/genome/eptFus1.fa
GENOME[12]=$DATA_DIR/genome/eptFus1.fa

BASE[0]=aPal_205_L  
BASE[1]=mOcc_210_L
BASE[2]=mYum_200_T
BASE[3]=aPal_205_T  
BASE[4]=mOcc_210_T  
BASE[5]=mYum_220_L
BASE[6]=aPal_212_T  
BASE[7]=mOcc_211_L  
BASE[8]=mYum_220_T
BASE[9]=mOcc_211_T
BASE[10]=mYum_200_L
BASE[11]=eFus_DAR_T  
BASE[12]=eFus_834_T
