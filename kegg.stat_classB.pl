#!/usr/bin/perl -w
use strict;
my $usage = <<__EOUSAGE__;

#####################################
#usage: perl $0  <KEGG>  <KO> > stat.out
#
###########################################

__EOUSAGE__

;
print $usage if(@ARGV!=2);
open KEGG,"$ARGV[0]";
$/="A<b>";
my @kegg=<KEGG>;
$/="\n";
my ($ko,$classA,$classB);
my %class;
my %num;
open KO,"$ARGV[1]";
KO:foreach(<KO>){
      chomp;
      if(/(K\d+)/){
      $ko=$1;
	}
      foreach my $kegg(@kegg){	
	if($kegg=~/^(.*)<\/b>\nB/){
		$classA=$1;
		my @C=split(/B\nB/,$kegg);
		foreach my  $C (@C){
			if($C=~/^  \<b\>(.*)\<\/b\>\n/){
			$classB=$1;
			if($C=~/$ko/){
				$class{$classB}=$classA;
				$num{$classB}++;
			}
			}
	
	         }
	  }
	}
}
foreach my $key (keys %num){
	print $class{$key},":",$key,"\t",$num{$key},"\n";
}


close(KEGG);
close(KO);
