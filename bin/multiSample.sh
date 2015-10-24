 #awk '{print $5"\t"$6"\t"$7"\t"$11"#"$10"\\"$12"\t"$2"\t"$9}' eFus_scaffolds_cleanName.fa.out.tsv >eFus_scaffolds_cleanName_RM.bed 

 #awk '{print $5"\t"$6"\t"$7"\t"$11"#"$10"\\"$12"\t"$2"\t"$9}' mLuc_scaffolds_cleanName.fa.out.tsv >mLuc_scaffolds_cleanName_RM.bed 


SPECIES[0]=result_12_10_2015_t_10_53_09#aPal_205_L_5_pred.bed
SPECIES[1]=result_12_10_2015_t_10_53_09#aPal_205_T_5_pred.bed
SPECIES[2]=result_12_10_2015_t_10_53_09#aPal_212_T_5_pred.bed
SPECIES[3]=result_12_10_2015_t_10_53_09#eFus_834_T_5_pred.bed
SPECIES[4]=result_12_10_2015_t_10_53_09#eFus_DAR_T_5_pred.bed
SPECIES[5]=result_12_10_2015_t_10_53_09#mOcc_210_L_5_pred.bed
SPECIES[6]=result_12_10_2015_t_10_53_09#mOcc_210_T_5_pred.bed
SPECIES[7]=result_12_10_2015_t_10_53_09#mOcc_211_L_5_pred.bed
SPECIES[8]=result_12_10_2015_t_10_53_09#mOcc_211_T_5_pred.bed
SPECIES[9]=result_12_10_2015_t_10_53_09#mYum_200_L_5_pred.bed
SPECIES[10]=result_12_10_2015_t_10_53_09#mYum_200_T_5_pred.bed
SPECIES[11]=result_12_10_2015_t_10_53_09#mYum_220_L_5_pred.bed
SPECIES[12]=result_12_10_2015_t_10_53_09#mYum_220_T_5_pred.bed

TES[0]=eFus_scaffolds_cleanName_RM.bed
TES[1]=eFus_scaffolds_cleanName_RM.bed
TES[2]=eFus_scaffolds_cleanName_RM.bed
TES[3]=eFus_scaffolds_cleanName_RM.bed
TES[4]=eFus_scaffolds_cleanName_RM.bed
TES[5]=mLuc_scaffolds_cleanName_RM.bed
TES[6]=mLuc_scaffolds_cleanName_RM.bed
TES[7]=mLuc_scaffolds_cleanName_RM.bed
TES[8]=mLuc_scaffolds_cleanName_RM.bed
TES[9]=mLuc_scaffolds_cleanName_RM.bed
TES[10]=mLuc_scaffolds_cleanName_RM.bed
TES[11]=mLuc_scaffolds_cleanName_RM.bed
TES[12]=mLuc_scaffolds_cleanName_RM.bed

CONTIG_SIZES[0]=eFus_scaffolds_cleanName.g
CONTIG_SIZES[1]=eFus_scaffolds_cleanName.g
CONTIG_SIZES[2]=eFus_scaffolds_cleanName.g
CONTIG_SIZES[3]=eFus_scaffolds_cleanName.g
CONTIG_SIZES[4]=eFus_scaffolds_cleanName.g
CONTIG_SIZES[5]=mLuc_scaffolds_cleanName.g
CONTIG_SIZES[6]=mLuc_scaffolds_cleanName.g
CONTIG_SIZES[7]=mLuc_scaffolds_cleanName.g
CONTIG_SIZES[8]=mLuc_scaffolds_cleanName.g
CONTIG_SIZES[9]=mLuc_scaffolds_cleanName.g
CONTIG_SIZES[10]=mLuc_scaffolds_cleanName.g
CONTIG_SIZES[11]=mLuc_scaffolds_cleanName.g
CONTIG_SIZES[12]=mLuc_scaffolds_cleanName.g


for (( i = 0; i < ${#SPECIES[@]}; i++))
    do
    
        
    for j in $(seq 1 2)
        do

        MIRNA_COUNT=$(wc -l ${SPECIES[$i]} | cut -f1 -d" ");
        rm -f ${SPECIES[$i]}.samples.txt

        (/lustre/work/apps/bedtools-2.17.0/bin/bedtools shuffle \
                -i ${SPECIES[$i]} \
                -g ${CONTIG_SIZES[$i]} \
                | /lustre/work/apps/bedtools-2.17.0/bin/bedtools intersect \
                        -wao \
                        -a - \
                        -b ${TES[$i]} \
                                > intersect.${SPECIES[$i]}.$j; \
        cut -f13 intersect.${SPECIES[$i]}.$j | grep "\." | wc -l | awk -v total=$MIRNA_COUNT '{print 1-($0/total)}' >>${SPECIES[$i]}.samples.txt ) &

    done
done

wait


for (( i = 0; i < ${#SPECIES[@]}; i++))
do
    
        (tar -czf intersect.${SPECIES[$i]}_ALL.tgz intersect.${SPECIES[$i]}.*; rm intersect.${SPECIES[$i]}.*)  &
done


wait




