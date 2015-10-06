# get miRNAs and clean up
##############################
cd $DATA_DIR

mkdir $DATA_DIR/miRBase
wget 								\
	--directory-prefix=$DATA_DIR/miRBase 				\
	ftp://mirbase.org/pub/mirbase/CURRENT/hairpin.fa.gz

wget 								\
	--directory-prefix=$DATA_DIR/miRBase 				\
	ftp://mirbase.org/pub/mirbase/CURRENT/mature.fa.gz

#these files have white spaces that need to be removed (for miRDeep2)
zcat $DATA_DIR/miRBase/hairpin.fa.gz | cut -f1 -d" ">$DATA_DIR/miRBase/hairpin_noSpace.fa
zcat $DATA_DIR/miRBase/mature.fa.gz | cut -f1 -d" " >$DATA_DIR/miRBase/mature_noSpace.fa

#and non-canonical nucleotides and convert to SL (for easier parsing)
fastaparse.pl $DATA_DIR/miRBase/hairpin_noSpace.fa -b 	\
	| $FASTX_DIR/fasta_formatter -w 0	\
	 >$DATA_DIR/miRBase/hairpin_cleaned.fa

fastaparse.pl $DATA_DIR/miRBase/mature_noSpace.fa -b 	\
	| $FASTX_DIR/fasta_formatter -w 0	\
	 >$DATA_DIR/miRBase/mature_cleaned.fa

#grep out the eptesicus miRNAs
grep -A1 "efu" $DATA_DIR/miRBase/mature_cleaned.fa  | grep -v -- "^--$" >$DATA_DIR/miRBase/efu_matureMirnas.fa
grep -A1 "efu" $DATA_DIR/miRBase/hairpin_cleaned.fa | grep -v -- "^--$" >$DATA_DIR/miRBase/efu_hairpinMirnas.fa


MIRBASE_MATURE=$DATA_DIR/miRBase/efu_matureMirnas.fa
MIRBASE_HAIRPIN=$DATA_DIR/miRBase/efu_hairpinMirnas.fa
