$file = $ARGV[0];

open my $in,'<',$file or die "Can't open $file\n";
open my $out,'>',"only_V1.txt" or die "Can't open $file_mod.dat\n";
while(<$in>){
	chomp($_);
    if($_ =~ m/^V1:([0-9a-zA-Z\_\-.]+)/){
        print $out $1."\n";
    }
}
close $in;
close $out;
