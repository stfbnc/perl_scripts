$file_out = $ARGV[0];
$tcol = $ARGV[1];
$file_in = $ARGV[2];
$year = $ARGV[3];
$yearin = $ARGV[4];
open my $out,'>',$file_out or die "Can't open $file_out\n";
open my $in,'<',$file_in or die "Can't open $file_in\n";
while(<$in>){
	chomp($_);
	@column = split(/\s/,$_);
    if($column[$tcol - 1] =~ m/^.*([0-9]{8}).*$/){
        $subcolumn_0 = int($1 * 0.0001);
        $subcolumn_1 = int(($1 * 0.0001 - $subcolumn_0) * 10000);
        if($subcolumn_0 =~ m/$yearin/){
            $check = 0;
            last;
        }elsif($subcolumn_1 =~ m/$yearin/){
            $check = 1;
            last;
        }
    }else{
        $check = -1;
        last;
    }
}
close $in;
open my $in,'<',$file_in or die "Can't open $file_in\n";
while(<$in>){
    chomp($_);
    @column = split(/\s/,$_);
    if($check == 0){
        for($i = $yearin;$i <= $year;$i++){
            print $out "$_\n" if $column[$tcol - 1] =~ m/^.*$i[0-9]{4}.*$/;
        }
    }elsif($check == 1){
        for($i = $yearin;$i <= $year;$i++){
            print $out "$_\n" if $column[$tcol - 1] =~ m/^.*[0-9]{4}$i.*$/;
        }
    }elsif($check == -1){
        for($i = $yearin;$i <= $year;$i++){
            print $out "$_\n" if $column[$tcol - 1] =~ m/^.*$i.*$/;
        }
    }
}
close $in;
close $out;
