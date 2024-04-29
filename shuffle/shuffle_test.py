use strict;
use List::Util qw(shuffle);
use File::Basename;

my $file = $ARGV[0];

open(LIST,$file);

my %hash;
my $element;
while (my $line = <LIST>){
      if ($line =~ />.*/) {
            $element=$line;
            $hash{$element}="";
      }else {
            $hash{$element}.=$line;
      }
}
close(LIST);

my $LINES=$ARGV[1];
my $name = basename($file);
my @ele=split /\./, $name;
my @out=shuffle (values %hash); # array 随机打乱
my $num=@out;
for (my $i=0; $i<=$LINES && $i<$num; $i+=1) {
      my $id=$ele[0]."_SEQ".$i;
      print ">".$id."\n".$out[$i];}
