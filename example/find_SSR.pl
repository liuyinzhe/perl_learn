#!/usr/bin/perl

$/=">";
$|=1;
my $seqcount;

#motif-repeat parameters:
#specify motif length, minimum number of repeats.
my @specs = ([1,6],[2,3],[3,2],[4,2],[5,2],[6,2]); 

my $reffile=$ARGV[0];
open RFILE,"<$reffile";

while(<RFILE>){
    chomp;
    my ($titleline, $sequence) = split(/\n/,$_,2);
    next unless ($sequence && $titleline);
    $seqcount++;
    my ($id) = $titleline =~ /^(\S+)/;
    $sequence =~ s/\s//g; #concatenate multi-line sequence

    my $seqlength = length($sequence);
    my $ssr_number = 1;
    my %locations; #track location of SSRs as detected
    my $i;
    for($i=0; $i<scalar(@specs); $i++){ #test each spec against sequence
    	my $motiflength = $specs[$i]->[0];
        my $minreps = $specs[$i]->[1] - 1;
        my $regexp = "(([gatc]{$motiflength})\\2{$minreps,})";
        while ($sequence =~ /$regexp/ig){
            my $motif = lc($2); my $ssr = $1;
            my $ssrlength = length($ssr); #overall SSR length
            my $repeats = $ssrlength/$motiflength; #number of rep units
            my $end = pos($sequence); #where SSR ends
            pos($sequence) = $end - $motiflength; #see docs
            my $start = $end - $ssrlength + 1; #where SSR starts
            my $ssrSeq=$motif x $repeats;
            print join("\t",$id,$start,$end,$ssrSeq,$motif,$motiflength,$repeats,), "\n"
            if (&novel($start, \%locations)); #count SSR only once
        }
    }
}
close RFILE;
sub novel {
    my($position, $locationsref) = @_;
    if(defined $locationsref->{$position}) {return undef;}
    else {$locationsref->{$position} = 1;return 1;}
}

