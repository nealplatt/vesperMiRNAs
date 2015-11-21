use Bio::SearchIO; 
use Bio::SeqIO;
use Getopt::Long;

my $genome_in 	= undef;
my $length_out 	= undef;

GetOptions('genome=s'	 => \$genome_in,
	   'output=s'	 => \$length_out);



open (OUT, ">$length_out") or die "$length_out cannot be opened.\n";

my $inseq = Bio::SeqIO->new(-file   => "<$genome_in", -format =>"fasta");

while (my $seq = $inseq->next_seq) {

	$length = $seq->length;
	$id = $seq->display_id;

	print OUT "$id\t$length\n";

	}#closes while loop
