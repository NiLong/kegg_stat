#!/usr/bin/perl -w
use strict;
open TAB,"$ARGV[0]";
open KO,">$ARGV[1]";
while (<TAB>){
	/(m\.\d+).*(K\d+)[ |\n]/;
	my $id=$1;
	my $ko=$2;
	print KO "$id\t$ko\n"; 
}
close(TAB);
close(KO);
