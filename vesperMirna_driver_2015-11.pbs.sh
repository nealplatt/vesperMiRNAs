#!/bin/bash
#$ -V
#$ -cwd
#$ -S /bin/bash
#$ -N mirnaMapper
#$ -o $JOB_NAME.o$JOB_ID
#$ -e $JOB_NAME.e$JOB_ID
#$ -q Chewie
#$ -pe fill 15
#$ -P communitycluster

HOME_DIR=/lustre/scratch/roplatt/vesperSmallRNAs
DATA_DIR=$HOME_DIR/data
GENOMES_DIR=$DATA_DIR/genomes
RAWDATA_DIR=$DATA_DIR/rawData

BIN_DIR=$HOME_DIR/bin

RESULTS_DIR=$HOME_DIR/results
THREADS=15

################################################################################
# Building bowtie indecies
################################################################################
#mkdir $RESULTS_DIR/bowtieIndecies
#cd $RESULTS_DIR/bowtieIndecies 
#
#for i in $(ls $GENOMES_DIR)
#do
#    ln -s $GENOMES_DIR/$i
#    bowtie-build $i $i>$i.build.log &
#
#done
#
#wait
#
#for i in $(ls $GENOMES_DIR)
#do
#	bowtie2-build $i $i >$i.build2.log &
#done
#
#wait
#
#
################################################################################
# download mirbase mirnas
################################################################################
#cd $DATA_DIR
#mkdir mirbaseMirnas

#cd mirbaseMirnas
#download all mammal miRNAs from miRBase v21 2015-11-17

#create non_<taxa> hairpin and mature mirna files
#cat !(*efu*|*hairpin*|*non*) >non_efu_matureMirna.fa 
#cat !(*cfa*|*hairpin*|*non*) >non_cfa_matureMirna.fa 
#cat !(*bta*|*hairpin*|*non*) >non_bta_matureMirna.fa 
#cat !(*mmu*|*hairpin*|*non*) >non_mmu_matureMirna.fa 
#cat !(*equ*|*hairpin*|*non*) >non_equ_matureMirna.fa 
#cat !(*ssu*|*hairpin*|*non*) >non_ssu_matureMirna.fa 
#cat !(*ocu*|*hairpin*|*non*) >non_ocu_matureMirna.fa 

################################################################################
# qc raw data
################################################################################
#cd $RESULTS_DIR/qcSeqData
#
#for RAWREADS in $(ls $RAWDATA_DIR)
#do
#        #ln -s $RAWDATA_DIR/$RAWREADS
#
#        ABBREV=$(basename $RAWREADS .fq)
#
#        fastqc \
#                --outdir ./fastqcPre \
#                --threads $THREADS \
#                $i 
#
#        java -jar /lustre/work/apps/Trimmomatic-0.27/trimmomatic-0.27.jar \
#                SE \
#                -threads $THREADS \
#                -phred33 \
#                $RAWREADS \
#                $ABBREV"_QC.fq" \
#                ILLUMINACLIP:adapters.fas:2:30:10 \
#                SLIDINGWINDOW:4:20 \
#                MINLEN:10
#
#        fastqc \
#                --outdir ./fastqcPost \
#                --threads $THREADS \
#                $ABBREV"_QC.fq"
#
#
#done
#
##combine same tissues from each taxa
#cat aPal_205_T_R1_QC.fq aPal_212_T_R1_QC.fq >aPal_T_QC.fq &
#cat eFus_834_T_R1_QC.fq eFus_DAR_T_R1_QC.fq >eFus_T_QC.fq &
#cat mOcc_210_L_R1_QC.fq mOcc_211_L_R1_QC.fq >mOcc_L_QC.fq &
#cat mOcc_210_T_R1_QC.fq mOcc_211_T_R1_QC.fq >mOcc_T_QC.fq &
#cat mYum_200_T_R1_QC.fq mYum_220_T_R1_QC.fq >mYum_T_QC.fq &
#cat mYum_200_L_R1_QC.fq mYum_220_L_R1_QC.fq >mYum_L_QC.fq &
#
#mv cat_QC.fq cat_T_QC.fq 
#mv cow_QC.fq cow_T_QC.fq
#mv dipodomys_QC.fq dipodomys_T_QC.fq
#mv dog_QC.fq dog_T_QC.fq
#mv hedgehog_QC.fq hedgehog_T_QC.fq
#mv horse_QC.fq horse_T_QC.fq
#mv pig_QC.fq pig_T_QC.fq
#mv rabbit_QC.fq rabbit_T_QC.fq
#mv squirrel_QC.fq squirrel_T_QC.fq
#
#wait

################################################################################
# predict mirnas
################################################################################
#
cd $RESULTS_DIR/mirnaPreds

#non-bats
 READS[0]=$RESULTS_DIR/qcSeqData/dog_T_QC.fq
 READS[1]=$RESULTS_DIR/qcSeqData/cat_T_QC.fq
 READS[2]=$RESULTS_DIR/qcSeqData/cow_T_QC.fq
 READS[3]=$RESULTS_DIR/qcSeqData/dipodomys_T_QC.fq
 READS[4]=$RESULTS_DIR/qcSeqData/hedgehog_T_QC.fq
 READS[5]=$RESULTS_DIR/qcSeqData/horse_T_QC.fq
 READS[6]=$RESULTS_DIR/qcSeqData/pig_T_QC.fq
 READS[7]=$RESULTS_DIR/qcSeqData/rabbit_T_QC.fq
 READS[8]=$RESULTS_DIR/qcSeqData/squirrel_T_QC.fq
#bats
 READS[9]=$RESULTS_DIR/qcSeqData/aPal_T_QC.fq
READS[10]=$RESULTS_DIR/qcSeqData/eFus_T_QC.fq
READS[11]=$RESULTS_DIR/qcSeqData/mOcc_L_QC.fq
READS[12]=$RESULTS_DIR/qcSeqData/mOcc_T_QC.fq
READS[13]=$RESULTS_DIR/qcSeqData/mYum_T_QC.fq
READS[14]=$RESULTS_DIR/qcSeqData/mYum_L_QC.fq

#non-bats
 GENOME[0]=$RESULTS_DIR/bowtieIndecies/canFam3.fa
 GENOME[1]=$RESULTS_DIR/bowtieIndecies/felCat5.fa
 GENOME[2]=$RESULTS_DIR/bowtieIndecies/bosTau8.fa
 GENOME[3]=$RESULTS_DIR/bowtieIndecies/dipOrd1.fa
 GENOME[4]=$RESULTS_DIR/bowtieIndecies/eriEur2.fa
 GENOME[5]=$RESULTS_DIR/bowtieIndecies/equCab2.fa
 GENOME[6]=$RESULTS_DIR/bowtieIndecies/susScr3.fa
 GENOME[7]=$RESULTS_DIR/bowtieIndecies/oryCun2.fa
 GENOME[8]=$RESULTS_DIR/bowtieIndecies/speTri2.fa
#bats
 GENOME[9]=$RESULTS_DIR/bowtieIndecies/eptFus1.fa
GENOME[10]=$RESULTS_DIR/bowtieIndecies/eptFus1.fa
GENOME[11]=$RESULTS_DIR/bowtieIndecies/myoLuc2.fa
GENOME[12]=$RESULTS_DIR/bowtieIndecies/myoLuc2.fa
GENOME[13]=$RESULTS_DIR/bowtieIndecies/myoLuc2.fa
GENOME[14]=$RESULTS_DIR/bowtieIndecies/myoLuc2.fa


#non-bats
 BASE[0]=cFam_T  
 BASE[1]=fCat_T
 BASE[2]=bTau_T
 BASE[3]=dOrd_T 
 BASE[4]=eEur_T 
 BASE[5]=eCab_T
 BASE[6]=sScr_T
 BASE[7]=oCun_T 
 BASE[8]=sTri_T   
#bats
 BASE[9]=aPal_T
BASE[10]=eFus_T
BASE[11]=mOcc_L
BASE[12]=mOcc_T
BASE[13]=mYum_T
BASE[14]=mYum_L

#mirbase short name
 MIRBASE[0]=cfa
 MIRBASE[1]=cfa
 MIRBASE[2]=bta
 MIRBASE[3]=mmu
 MIRBASE[4]=equ
 MIRBASE[5]=equ
 MIRBASE[6]=ssu
 MIRBASE[7]=ocu
 MIRBASE[8]=mmu
 MIRBASE[9]=efu
 MIRBASE[10]=efu
 MIRBASE[11]=efu
 MIRBASE[12]=efu 
 MIRBASE[13]=efu 
 MIRBASE[14]=efu


#for (( i = 0; i < ${#READS[@]}; i++))
#do
#        
#        TEMP_DIR=$RESULTS_DIR/mirnaPreds/${BASE[$i]}
#        mkdir $TEMP_DIR
#        cd $TEMP_DIR
#
#       
#        mapper.pl \
#                ${READS[$i]} \
#                -e \
#                -h \
#                -m \
#                -j \
#                -l 18 \
#                -v \
#                -n \
#                -r 5 \
#                -s $TEMP_DIR/${BASE[$i]}"_pos5_mapperProcessed.fa" \
#                -t $TEMP_DIR/${BASE[$i]}"_pos5_mapperProcessed.arf" \
#                -p ${GENOME[$i]} \
#		 >${BASE[$i]}.mapper.log 2>&1 &
#
#
#
#      miRDeep2.pl \
#               $TEMP_DIR/${BASE[$i]}"_pos5_mapperProcessed.fa" \
#               ${GENOME[$i]} \
#	        $TEMP_DIR/${BASE[$i]}"_pos5_mapperProcessed.arf" \
#	        $DATA_DIR/mirbaseMirnas/${MIRBASE[$i]}"_matureMirna.fa" \
#	        $DATA_DIR/mirbaseMirnas/"non_"${MIRBASE[$i]}"_matureMirna.fa" \
#	        $DATA_DIR/mirbaseMirnas/${MIRBASE[$i]}"_hairpinMirna.fa" \
#	        -z "#"${BASE[$i]}"_5pred" \
#	        -P \
#		>${BASE[$i]}.miRDeep2.log 2>&1 &
#      
#        cd ..
#        
#done



#intersect TEs with miRNAs
#cd $RESULTS_DIR

#mkdir intersection
#cd ./intersection

#array with repeatmasker BED files
 TE_BED[0]=$RESULTS_DIR/repeatMasker/canFam3_RM_TEs.bed
 TE_BED[1]=$RESULTS_DIR/repeatMasker/felCat5_RM_TEs.bed
 TE_BED[2]=$RESULTS_DIR/repeatMasker/bosTau8_RM_TEs.bed
 TE_BED[3]=$RESULTS_DIR/repeatMasker/dipOrd1_RM_TEs.bed
 TE_BED[4]=$RESULTS_DIR/repeatMasker/eriEur2_RM_TEs.bed
 TE_BED[5]=$RESULTS_DIR/repeatMasker/equCab2_RM_TEs.bed
 TE_BED[6]=$RESULTS_DIR/repeatMasker/susScr3_RM_TEs.bed
 TE_BED[7]=$RESULTS_DIR/repeatMasker/oryCun2_RM_TEs.bed
 TE_BED[8]=$RESULTS_DIR/repeatMasker/speTri2_RM_TEs.bed
 TE_BED[9]=$RESULTS_DIR/repeatMasker/eptFus1_RM_TEs.bed
TE_BED[10]=$RESULTS_DIR/repeatMasker/eptFus1_RM_TEs.bed
TE_BED[11]=$RESULTS_DIR/repeatMasker/myoLuc2_RM_TEs.bed
TE_BED[12]=$RESULTS_DIR/repeatMasker/myoLuc2_RM_TEs.bed
TE_BED[13]=$RESULTS_DIR/repeatMasker/myoLuc2_RM_TEs.bed
TE_BED[14]=$RESULTS_DIR/repeatMasker/myoLuc2_RM_TEs.bed

#array with mirna prediction files
 MIRNA_BED[0]=$RESULTS_DIR/mirnaPreds/cFam_T/result_*5pred.bed
 MIRNA_BED[1]=$RESULTS_DIR/mirnaPreds/fCat_T/result_*5pred.bed
 MIRNA_BED[2]=$RESULTS_DIR/mirnaPreds/bTau_T/result_*5pred.bed
 MIRNA_BED[3]=$RESULTS_DIR/mirnaPreds/dOrd_T/result_*5pred.bed
 MIRNA_BED[4]=$RESULTS_DIR/mirnaPreds/eEur_T/result_*5pred.bed
 MIRNA_BED[5]=$RESULTS_DIR/mirnaPreds/eCab_T/result_*5pred.bed
 MIRNA_BED[6]=$RESULTS_DIR/mirnaPreds/sScr_T/result_*5pred.bed
 MIRNA_BED[7]=$RESULTS_DIR/mirnaPreds/oCun_T/result_*5pred.bed
 MIRNA_BED[8]=$RESULTS_DIR/mirnaPreds/sTri_T/result_*5pred.bed
 MIRNA_BED[9]=$RESULTS_DIR/mirnaPreds/aPal_T/result_*5pred.bed
MIRNA_BED[10]=$RESULTS_DIR/mirnaPreds/eFus_T/result_*5pred.bed
MIRNA_BED[11]=$RESULTS_DIR/mirnaPreds/mOcc_L/result_*5pred.bed
MIRNA_BED[12]=$RESULTS_DIR/mirnaPreds/mOcc_T/result_*5pred.bed
MIRNA_BED[13]=$RESULTS_DIR/mirnaPreds/mYum_T/result_*5pred.bed
MIRNA_BED[14]=$RESULTS_DIR/mirnaPreds/mYum_L/result_*5pred.bed


#for (( i = 0; i < ${#MIRNA_BED[@]}; i++))
#    do	 
#
#    bedtools intersect \
#	-wao \
#	-a ${MIRNA_BED[$i]} \
#	-b ${TE_BED[$i]} \
#	>${BASE[$i]}"_TEvsMirnaInter.bed" &
#    done
#
cd $RESULTS_DIR
#
#mkdir reShuffle
cd reShuffle



#create a tab delimited file of contig lengths for each genome
#for i in $(ls $GENOMES_DIR)
#do
#	ABBREV=$(basename $i .fa)
#	echo $ABBREV $i
#
#	perl $BIN_DIR/contigLengths.pl \
#		--genome $GENOMES_DIR/$i \
#		--output $ABBREV"_contigLengths.tab" &
#
#done

 CONTIG_LENGTHS[0]=$RESULTS_DIR/reShuffle/canFam3_contigLengths.tab
 CONTIG_LENGTHS[1]=$RESULTS_DIR/reShuffle/felCat5_contigLengths.tab
 CONTIG_LENGTHS[2]=$RESULTS_DIR/reShuffle/bosTau8_contigLengths.tab
 CONTIG_LENGTHS[3]=$RESULTS_DIR/reShuffle/dipOrd1_contigLengths.tab
 CONTIG_LENGTHS[4]=$RESULTS_DIR/reShuffle/eriEur2_contigLengths.tab
 CONTIG_LENGTHS[5]=$RESULTS_DIR/reShuffle/equCab2_contigLengths.tab
 CONTIG_LENGTHS[6]=$RESULTS_DIR/reShuffle/susScr3_contigLengths.tab
 CONTIG_LENGTHS[7]=$RESULTS_DIR/reShuffle/oryCun2_contigLengths.tab
 CONTIG_LENGTHS[8]=$RESULTS_DIR/reShuffle/speTri2_contigLengths.tab
 CONTIG_LENGTHS[9]=$RESULTS_DIR/reShuffle/eptFus1_contigLengths.tab
CONTIG_LENGTHS[10]=$RESULTS_DIR/reShuffle/eptFus1_contigLengths.tab
CONTIG_LENGTHS[11]=$RESULTS_DIR/reShuffle/myoLuc2_contigLengths.tab
CONTIG_LENGTHS[12]=$RESULTS_DIR/reShuffle/myoLuc2_contigLengths.tab
CONTIG_LENGTHS[13]=$RESULTS_DIR/reShuffle/myoLuc2_contigLengths.tab
CONTIG_LENGTHS[14]=$RESULTS_DIR/reShuffle/myoLuc2_contigLengths.tab

# reshuffle/intersect 1K times
REPLICATES=1000;

#for each species 
for (( i = 0; i < ${#MIRNA_BED[@]}; i++))
do

    #run X replicates
    for j in $(seq 1 $REPLICATES)
        do

          
            #create a random interval similar to miRNAs, intersect wtih TEs, then count
            bedtools shuffle \
                -i ${MIRNA_BED[$i]} \
                -g ${CONTIG_LENGTHS[$i]} \
                | bedtools intersect \
                        -wao \
                        -a - \
                        -b ${TE_BED[$i]} \
                                > intersect.${BASE[$i]}.$j
            done &

done

mkdir vsTEs
mkdir vsDNAs
mkdir vsHATs
mkdir vsHelitrons
mkdir vsBAR1_ML


#calc percentage intersecting TEs
for (( i = 0; i < ${#MIRNA_BED[@]}; i++))
do
    for j in $(seq 1 $REPLICATES)
        do

           MIRNA_COUNT=$(wc -l ${MIRNA_BED[$i]} | cut -f1 -d" ");
            cut -f13 ../intersect.${BASE[$i]}.$j \
                | grep "\." \
                | wc -l \
                | awk -v total=$MIRNA_COUNT '{print 1-($0/total)}' \
                >>${BASE[$i]}.1KsampleTEpercents.txt 
        done &

done




#calc percentage intersecting BAR1_ML
for (( i = 0; i < ${#MIRNA_BED[@]}; i++))
do
    for j in $(seq 1 $REPLICATES)
        do

           MIRNA_COUNT=$(wc -l ${MIRNA_BED[$i]} | cut -f1 -d" ");
            cut -f13 intersect.${BASE[$i]}.$j \
                | grep "BAR1_ML" \
                | wc -l \
                | awk -v total=$MIRNA_COUNT '{print ($0/total)}' \
                >>vsBAR1_ML/${BASE[$i]}.1KsampleTEpercents.txt 
        done &

done



#calc percentage intersecting helitrons
for (( i = 0; i < ${#MIRNA_BED[@]}; i++))
do
    for j in $(seq 1 $REPLICATES)
        do

           MIRNA_COUNT=$(wc -l ${MIRNA_BED[$i]} | cut -f1 -d" ");
            cut -f13 intersect.${BASE[$i]}.$j \
                | grep -i "helitron" \
                | wc -l \
                | awk -v total=$MIRNA_COUNT '{print ($0/total)}' \
                >>vsHelitron/${BASE[$i]}.1KsampleTEpercents.txt 
        done &

done


#calc percentage intersecting dna transposons
for (( i = 0; i < ${#MIRNA_BED[@]}; i++))
do
    for j in $(seq 1 $REPLICATES)
        do

           MIRNA_COUNT=$(wc -l ${MIRNA_BED[$i]} | cut -f1 -d" ");
            cut -f13 intersect.${BASE[$i]}.$j \
                | grep -i "helitron\|dna" \
                | wc -l \
                | awk -v total=$MIRNA_COUNT '{print ($0/total)}' \
                >>vsDNAs/${BASE[$i]}.1KsampleTEpercents.txt 
        done &

done

#calc percentage intersecting hats
for (( i = 0; i < ${#MIRNA_BED[@]}; i++))
do
    for j in $(seq 1 $REPLICATES)
        do

           MIRNA_COUNT=$(wc -l ${MIRNA_BED[$i]} | cut -f1 -d" ");
            cut -f13 intersect.${BASE[$i]}.$j \
                | grep -i "hat" \
                | wc -l \
                | awk -v total=$MIRNA_COUNT '{print ($0/total)}' \
                >>vsHATs/${BASE[$i]}.1KsampleTEpercents.txt 
        done &

done

echo "aPal\tbTau\tcFam\tdOrd\teCab\teEur\teFus\tfCat\tmOcc_L\tmOcc_t\tmYum_L\tmYum_T\toCun\tsScr\tsStr" >vsTEs/vsTEs.tab
paste vsTEs/*1KsampleTEpercents.txt >>vsTEs/vsTEs.tab


echo "aPal\tbTau\tcFam\tdOrd\teCab\teEur\teFus\tfCat\tmOcc_L\tmOcc_t\tmYum_L\tmYum_T\toCun\tsScr\tsStr" >vsBAR1_M/vsBAR1_ML.tab
paste vsBAR1_M/*1KsampleTEpercents.txt >>vsBAR1_M/vsBAR1_ML.tab


echo "aPal\tbTau\tcFam\tdOrd\teCab\teEur\teFus\tfCat\tmOcc_L\tmOcc_t\tmYum_L\tmYum_T\toCun\tsScr\tsStr" >vsHelitrons/vsHelitrons.tab
paste vsHelitrons/*1KsampleTEpercents.txt >>vsHelitrons/vsHelitrons.tab

echo "aPal\tbTau\tcFam\tdOrd\teCab\teEur\teFus\tfCat\tmOcc_L\tmOcc_t\tmYum_L\tmYum_T\toCun\tsScr\tsStr" >vsDNAs/vsDNAs.tab
paste vsTEs/*1KsampleTEpercents.txt >>vsDNAs/vsDNAs.tab

echo "aPal\tbTau\tcFam\tdOrd\teCab\teEur\teFus\tfCat\tmOcc_L\tmOcc_t\tmYum_L\tmYum_T\toCun\tsScr\tsStr" >vsHATs/vsHATs.tab
paste vsTEs/*1KsampleTEpercents.txt >>vsHATs/vsHATs.tab
