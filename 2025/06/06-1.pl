#!/usr/bin/perl

use strict;
use warnings;

# read input
my @lines = ( );
while (<>) {
	chomp;
	# trim leading and trailing space
	s/^\s+//;
	s/\s+$//;

	# split on any amount of whitespace
	push @lines, [ split(/\s+/, $_) ];
}

my @operations = @{splice(@lines, -1)};

my $grand_total = 0;
foreach my $problem_index (0..$#operations) {
	my $value = $lines[0][$problem_index];
	foreach my $line_index (1..$#lines) {
		if ($operations[$problem_index] eq '+') {
			$value += $lines[$line_index][$problem_index];
		} else {
			$value *= $lines[$line_index][$problem_index];
		}
	}
	$grand_total += $value;
}

print "Grand Total = $grand_total\n";