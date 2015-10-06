WORK_DIR="/lustre/scratch/roplatt/myotisSmallRNAs"
RESULTS_DIR="$WORK_DIR/results"
DATA_DIR="$WORK_DIR/data"
BIN_DIR="$WORK_DIR/bin"

FASTX_DIR="/lustre/work/apps/fastx_toolkit-0.0.14/bin"
MIRDEEP_DIR="/lustre/work/apps/mirdeep2_0_0_7/"
MIRDEEP_BOWTIE="$MIRDEEP_DIR/essentials/bowtie-1.1.1"
BLAST_DIR="/lustre/work/apps/blast/bin"
BEDTOOLS_DIR="/lustre/work/apps/bedtools-2.17.0/bin"

GENOME=$DATA_DIR/genome/myoLuc2.fa

ADAPTER_SEQ=AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC



#mkdir $WORK_DIR $RESULTS_DIR $DATA_DIR $BIN_DIR
#cd $RESULTS_DIR

#cd $GENOME_DIR
#bowtie-build $GENOME myoLuc2.fa

#cd $DATA_DIR
#wget 								\
#	--directory-prefix=$DATA_DIR 				\
#	ftp://mirbase.org/pub/mirbase/CURRENT/hairpin.fa.gz

#wget 								\
#	--directory-prefix=$DATA_DIR 				\
#	ftp://mirbase.org/pub/mirbase/CURRENT/mature.fa.gz

#these files have white spaces that need to be removed (for miRDeep2)
#zcat $DATA_DIR/hairpin.fa.gz | cut -f1 -d" ">$RESULTS_DIR/hairpin_noSpace.fa
#zcat $DATA_DIR/mature.fa.gz | cut -f1 -d" " >$RESULTS_DIR/mature_noSpace.fa

#and non-canonical nucleotides and convert to SL (for easier parsing)
#fastaparse.pl $RESULTS_DIR/hairpin_noSpace.fa -b 	\
#	| $FASTX_DIR/fasta_formatter -w 0	\
#	 >$RESULTS_DIR/hairpin_cleaned.fa

#fastaparse.pl $RESULTS_DIR/mature_noSpace.fa -b 	\
#	| $FASTX_DIR/fasta_formatter -w 0	\
#	 >$RESULTS_DIR/mature_cleaned.fa

#grep out the chicken miRNAs
#grep -A1 "efu" $RESULTS_DIR/mature_cleaned.fa  | grep -v -- "^--$" >$RESULTS_DIR/efu_matureMirnas.fa
#grep -A1 "efu" $RESULTS_DIR/hairpin_cleaned.fa | grep -v -- "^--$" >$RESULTS_DIR/efu_hairpinMirnas.fa

# designate the processed miRBase files for future analyses



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


cd $RESULTS_DIR

for (( i=0 ; i < ${#BAT[@]}; i++))

do
        
        TEMP_DIR=$RESULTS_DIR/${BASE[$i]}

        mkdir $TEMP_DIR

        cd $TEMP_DIR

        $MIRDEEP_DIR/mapper.pl \
                ${BAT[$i]} \
                -e \
                -h \
                -m \
                -j \
                -l 18 \
                -v \
                -n \
                -r 100000 \
                -s $TEMP_DIR/${BASE[$i]}"_100K_mapperProcessed.fa" \
                -t $TEMP_DIR/${BASE[$i]}"_100K_mapperProcessed.arf" \
                -p ${GENOME[$i]} &
        
        #miRDeep2.pl \
	#        $TEMP_DIR/${BASE[$i]}"_R1_100K_mapperProcessed.fa" \
	#        ${GENOME[$i]} \
	#        $TEMP_DIR/${BASE[$i]}"_R1_100K_mapperProcessed.arf" \
	#        $MIRBASE_MATURE \
	#        none \
	#        $MIRBASE_HAIRPIN \
	#        -z "#"${BASE[$i]}"_100Kpred" \
	#        -P &
        
        cd $RESULTS_DIR
        
done

wait

sleep 10

echo "mirDeep2 finished" | mailx -s "mirDeep2 finished" 9034521885@txt.att.net

sleep 60

#wget http://www.repeatmasker.org/genomes/myoLuc2/RepeatMasker-rm330-db20120124/myoLuc2.fa.out.gz

#awk '{print $5"\t"$6"\t"$7"\t"$10"#"$11"\t"$2"\t"$9}' myoLuc2.fa.out | sed 1,3d >myoLuc2_RM.bed

#cat result_24_05_2015_t_16_33_03mOcc_210_L_intialPred.bed | sed 's/gi|[0-9]*|gb|//gi' | sed 's/|//gi' >mOcc_210_L_initialPred.bed


