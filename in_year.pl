$file_in = $ARGV[0];
$start = $ARGV[1];
$end = $ARGV[2];
$path_out = $ARGV[3];
$tcol = $ARGV[4];

open my $out,'>',"$path_out/yearin_line.txt" or die "Can't open output file\n";
open my $in,'<',$file_in or die "Can't open $file_in\n";
while(<$in>){
    chomp($_);
    @column = split(/\s/,$_);
    if($column[$tcol-1] =~ m/^.*([0-9]{8}).*$/){
        $subcolumn_0 = int($1 * 0.0001);
        $subcolumn_1 = int(($1 * 0.0001 - $subcolumn_0) * 10000);
        if($subcolumn_0 =~ m/$start/){
            $check = 0;
            last;
        }elsif($subcolumn_1 =~ m/$start/){
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
$line = 0;
$yearin = $start;
while(<$in>){
    $line++;
    chomp($_);
    @column = split(/\s/,$_);
    if($check == 0){
        if($column[$tcol - 1] =~ m/^.*$yearin[0-9]{4}.*$/){
            print $out "$yearin $line\n";
            $yearin++;
        }
    }elsif($check == 1){
        if($column[$tcol - 1] =~ m/^.*[0-9]{4}$yearin.*$/){
            print $out "$yearin $line\n";
            $yearin++;
        }
    }elsif($check == -1){
        if($column[$tcol - 1] =~ m/^.*$yearin.*$/){
            print $out "$yearin $line\n";
            $yearin++;
        }
    }
    if($yearin == $end + 1){
    	last;
    }
}
close $in;

close $out;
