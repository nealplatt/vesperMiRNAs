use Getopt::Long;
use Data::Dumper qw(Dumper);




#sets all input values to undef
my $bed_in 	= undef;
my $bed_out 	= undef;

GetOptions('in=s'   => \$bed_in,
	   'out=s'  => \$bed_out, 
           'h'      => \$help );


open (BED_INPUT_FILE, "<$bed_in") or die "BED input file ($bed_in) cannot be opened.\n";

#iterate throught the file to count any scaffolds that appear twice
while(<BED_INPUT_FILE>){
	chomp;
	($scaffold, 	$preStart, 	$preEnd, 	$preName, 	
	$preScore, 	$orient, 	$preStart, 	$preEnd,
	$color ) = split ("\t", $_);

	$scaffoldCount{$scaffold}++;
}	

#reset the file pointer to the beginning of the file
seek BED_INPUT_FILE, 0, 0;	

#and iterate again through the file to load all of the miRNA records 
# from scaffolds with multiple hits into a 3 dimensional array.
while(<BED_INPUT_FILE>){
	chomp;
	($scaffold, 	$preStart, 	$preEnd, 	$preName, 	
	$preScore, 	$orient, 	$preStart, 	$preEnd,
	$color ) = split ("\t", $_);

	#if the scaffold has more than 1 miRNA
	if ($scaffoldCount{$scaffold} > 1){

		#load into a 3 dimensional array
		$multiples{$scaffold}{$preName}{start}=$preStart;
		$multiples{$scaffold}{$preName}{end}=$preEnd;
		$multiples{$scaffold}{$preName}{score}=$preScore;
		$multiples{$scaffold}{$preName}{orient}=$orient;
		$multiples{$scaffold}{$preName}{color}=$color;

	}
}	

#temporary test to see if data is stored properly
#print Dumper \%duplicates;	

#for each of the scaffolds with multiple miRNAs - see if the miRNAs records overlap e/o.
foreach my $dupContigs (sort keys %multiples){
	#print "$dupContigs\n";

	$tempStart=undef;
	$tempEnd=undef;

	foreach my $miRNA_name (sort keys %{ $multiples{$dupContigs}}){
		
	
		push @contigHits, [$multiples{$dupContigs}{$miRNA_name}{start}, $multiples{$dupContigs}{$miRNA_name}{end}, $multiples{$dupContigs}{$miRNA_name}{score},$multiples{$dupContigs}{$miRNA_name}{orient}, $multiples{$dupContigs}{$miRNA_name}{color}];

		#!!!!!!!!!!!!!!!this has not been error checked !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!		
	}

	
	
	@sortedContigHits = sort {$a->[1] <=> $b->[1]} @contigHits;
		#!!!!!!!!!!!!!!!this has not been error checked !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!				


	#now iterate through to find overlapping miRNAs.
		
		




		#print "$dupContigs\t";
		#print "$multiples{$dupContigs}{$miRNA_name}{start}\t";
		#print "$multiples{$dupContigs}{$miRNA_name}{end}\t";
		#print "$miRNA_name\t";
		#print "$multiples{$dupContigs}{$miRNA_name}{score}\t";
		#print "$multiples{$dupContigs}{$miRNA_name}{orient}\t";
		#print "$multiples{$dupContigs}{$miRNA_name}{start}\t";
		#print "$multiples{$dupContigs}{$miRNA_name}{end}\t";
		#print "$multiples{$dupContigs}{$miRNA_name}{color}\n";

		
	}

}




