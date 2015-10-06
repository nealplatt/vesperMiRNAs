# miRDeep2 can identify know miRNAs if given an appropriate reference.
#  This script downloads the current release of miRBase and extracts
#  the known Eptesicus fuscus miRNAs (since these are the only known
#  miRNAs in bats at this point).

#all this work is done in the data directory
mkdir $DATA_DIR/miRBase
cd $DATA_DIR/miRBase

#download the current hairpin and mature miRNAs from miRBase
wget \
	--directory-prefix=$DATA_DIR/miRBase \
	ftp://mirbase.org/pub/mirbase/CURRENT/hairpin.fa.gz

wget \
	--directory-prefix=$DATA_DIR/miRBase \
	ftp://mirbase.org/pub/mirbase/CURRENT/mature.fa.gz

#these files have white spaces that need to be removed (for miRDeep2)
zcat $DATA_DIR/miRBase/hairpin.fa.gz | cut -f1 -d" ">$DATA_DIR/miRBase/hairpin_noSpace.fa
zcat $DATA_DIR/miRBase/mature.fa.gz | cut -f1 -d" " >$DATA_DIR/miRBase/mature_noSpace.fa

#and non-canonical nucleotides and convert to SL (for easier parsing)
fastaparse.pl $DATA_DIR/miRBase/hairpin_noSpace.fa -b \
	| $FASTX_DIR/fasta_formatter -w 0 \
	 >$DATA_DIR/miRBase/hairpin_cleaned.fa

fastaparse.pl $DATA_DIR/miRBase/mature_noSpace.fa -b \
	| $FASTX_DIR/fasta_formatter -w 0 \
	 >$DATA_DIR/miRBase/mature_cleaned.fa

#grep out the eptesicus miRNAs into a final efu miRNA file (for use with miRDeep2)
# We search for the efu (in the fasta header) then extract t plus the following line (grep -A1).  Then the
#  "--" that is displayed after each successful search (from grep) is removed.
grep -A1 "efu" $DATA_DIR/miRBase/mature_cleaned.fa  | grep -v -- "^--$" >$DATA_DIR/miRBase/efu_matureMirnas.fa
grep -A1 "efu" $DATA_DIR/miRBase/hairpin_cleaned.fa | grep -v -- "^--$" >$DATA_DIR/miRBase/efu_hairpinMirnas.fa

#file names are stored in varible sfor easier downstream use.
MIRBASE_MATURE=$DATA_DIR/miRBase/efu_matureMirnas.fa
MIRBASE_HAIRPIN=$DATA_DIR/miRBase/efu_hairpinMirnas.fa
