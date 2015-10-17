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
print Dumper \%multiples;	

#for each of the scaffolds with multiple miRNAs - see if the miRNAs records overlap e/o.
foreach my $dupContigs (sort keys %multiples){
	#print "$dupContigs\n";


	foreach my $miRNA_name (sort keys %{ $multiples{$dupContigs}}){
	
		#instead of using the complex 3D hash, store as variables
		$start=$multiples{$dupContigs}{$miRNA_name}{start};
		$end=$multiples{$dupContigs}{$miRNA_name}{end};
		$score=$multiples{$dupContigs}{$miRNA_name}{score};
		$orient=$multiples{$dupContigs}{$miRNA_name}{orient};
		$color=$multiples{$dupContigs}{$miRNA_name}{color};
			
		#put all of the metrics into an array of arrays to be sorted
		push @contigHits, [$start, $end, $score, $orient, $color, $miRNA_name];

	}

	
	#sort all of the hits (per contig) based on start position
	@sortedContigHits = sort {$a->[1] <=> $b->[1]} @contigHits;


	#cycle through the array (sorted by start position) to find overlaps	
	$i=0;
	while( $i <= $#sortedContigHits ){


		#store array values in simple variables
		$start=$sortedContigHits[$i][0];
		$end=$sortedContigHits[$i][1];
		$score=$sortedContigHits[$i][2];
		$orient=$sortedContigHits[$i][3];
		$color=$sortedContigHits[$i][4];
		$name=$sortedContigHits[$i][5];

		#$next_start=$sortedContigHits[$i+1][0];
		#$next_end=$sortedContigHits[$i+1][1];
		#$next_score=$sortedContigHits[$i+1][2];
		#$next_orient=$sortedContigHits[$i+1][3];
		#$next_color=$sortedContigHits[$i+1][4];
		#$next_name=$sortedContigHits[$i+1][5];

		#find if overlapping
		if($i+1 > $#sortedContigHits){
			$next_start=undef;
			$next_end=undef;
			$next_score=undef;
			$next_orient=undef;
			$next_color=undef;
			$next_name=undef;
		}else{
			$next_start=$sortedContigHits[$i+1][0];
			$next_end=$sortedContigHits[$i+1][1];
			$next_score=$sortedContigHits[$i+1][2];
			$next_orient=$sortedContigHits[$i+1][3];
			$next_color=$sortedContigHits[$i+1][4];
			$next_name=$sortedContigHits[$i+1][5];
		}


		if( ($start < $next_start && $end > $next_start)){
			#print "overlap\t$dupContigs\t$start\t$end\t$name\t$score\t$orient\t$start\t$end\t$color\n";
		}
		print "$dupContigs\t$start\t$end\t$name\t$score\t$orient\t$start\t$end\t$color\n";
		
		$i++;

		
		my $start;
		my $end;
		my $score;
		my $orient;
		my $color;
		my $name;
		my $next_start;
		my $next_end;
		my $next_score;
		my $next_orient;
		my $next_color;
		my $next_name;

	

	}



		
}


# ||
#		    ($start    < $next_start && $start > $next_end) ||
#		    ($next_end > $start      && $next_end < $start)   



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






