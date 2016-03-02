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
$/="\nC";
my @kegg=<KEGG>;
$/="\n";
shift(@kegg);
my ($ko,$classC);
my %class;
my %num;
open KO,"$ARGV[1]";
KO:foreach(<KO>){
      chomp;
      my @name=split(/\t/,$_);
      my @ko=split(/ /,$name[1]);
      foreach my $ko1 (@ko){
	foreach my $kegg (@kegg){
		my @classDline=split(/\nD/,$kegg);
		my $classCline=shift(@classDline);
	#	print $classCline,"\n";
		if($classCline=~/ +\d+ +(.*) +\[PATH\:/){
	#	print $classCline,"\n";
		my $classCname=$1;
		$class{$classCname}=0;
		foreach my $classD (@classDline){
		 if($classD=~/$ko1/){
	#		$class{$classCname}=0;
			$num{$classCname}++;
			next KO;
			}
#		else{
#		$num{$classCname}=0;
#		}
		}
		}
		}
	}
}
foreach my $key (keys %class){
	if(exists $num{$key}){
        print $key,"\t",$num{$key},"\n";
	}
	else{
	print $key,"\t",$class{$key},"\n";
	}
}
close(KEGG);
close(KO);

__END__
      if(/(K\d+)/){
      $ko=$1;
	}
      foreach my $kegg(@kegg){	
	if($kegg=~/\d (.*) \nD/){
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
