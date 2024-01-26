perl -e 'open(IN, "<$ARGV[0]") or die "file  can not open, $!"; my @array=<IN>;my @new=reverse @array;foreach my $el(@new){print "$el"}' file
