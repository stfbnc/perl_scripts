$file = $ARGV[0];
$q2_col = $ARGV[1];
$x_col = $ARGV[2];
$new_col = $ARGV[3];

open my $in,'<',$file or die "Can't open $file\n";
open my $out,'>',"mod_".$file or die "Can't open $file_mod.dat\n";
while(<$in>){
	chomp($_);
    if($_ =~ m/^[^0-9]/){
        print $out $_."\n";
    }else{
        @column = split(/[\s]+/,$_);
        @new_array = ();
        for($i = 0;$i < @column;$i++){
            if($i != $new_col - 1){
                push(@new_array,$column[$i]);
            }else{
                $new_value = log(1.0 / $column[$x_col - 1]) / (0.61 * log($column[$q2_col - 1] / (0.088) ** 2.0));
                push(@new_array,$new_value);
                push(@new_array,$column[$new_col - 1]);
            }
        }
        print $out join('  ',@new_array)."\n";
    }
}
close $in;
close $out;
