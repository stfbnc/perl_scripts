$station[0]='CAZ20';
$j=0;
@FILES=glob("*.lst");
foreach $file_in(@FILES){
	open my $in,'<',$file_in or die "Can't open $file_in\n";
	$i=1;
	while(<$in>){
		next if /^[\sA-Za-z_-]+$/;
		next if /^[0-9]/;
		($station[$i])=$_=~m/^([A-Z0-9]+)\s/;
		if($station[$i] ne $station[$i-1]){
			$ident[$j]=$station[$i];
			$j++;
		}
		$i++;
	}
	close $in;
	$station[0]=$station[$i-1];
}
@sort_ident=sort {$a <=> $b || $a cmp $b} @ident;
$idx=0;
$stat_id[0]=$sort_ident[0];
for($k=1;$k<$j;$k++){
	next if $sort_ident[$k] eq $sort_ident[$k-1];
	$idx++;
	$stat_id[$idx]=$sort_ident[$k]; 
}
foreach $file_idx(@stat_id){
	$file_handle="f_$file_idx";
	$file_stat="$file_idx.txt";
	open my $file_handle,'>',$file_stat or die "Can't open $file_stat\n";
	foreach $file_in(@FILES){
        open my $in,'<',$file_in or die "Can't open $file_in\n";
		while($line=<$in>){
			next if /^[\sA-Za-z_-]+$/;
			next if /^[0-9]/;
			chomp($line);
			($line_in)=$line=~m/^([A-Z0-9]+)\s/;
			if($line_in eq $file_idx){
				print $file_handle "$line\n";
			}
		}
		close $in;
	}
	close $file_handle;
}
