#!/usr/bin/perl

use strict;
use warnings;

# read input
my @lines = ( );
while (<>) {
	chomp;
	push @lines, [ split(//, $_) ];
}

my @operations_line = @{splice(@lines, -1)};

# use the last line to determine the starting position of each
# column of numbers, the width of each column, and the operation type
my @operations;
my @operation_start;
my @operation_width;
foreach my $index (0..$#operations_line) {
	if ($operations_line[$index] =~ /([\+\*])/) {
		push @operations, $1;
		push @operation_start, $index;
		push @operation_width, 1;
	} else {
		$operation_width[$#operations]++;
	}
}
# adjust width of final operation
$operation_width[$#operations]++;


my $grand_total = 0;
foreach my $problem_index (0..$#operations) {

	# traverse the columns and build the terms for this operation
	my @terms = ( );
	foreach my $offset (0..$operation_width[$problem_index] - 2) {
		my $this_term = 0;
		foreach my $line (0..$#lines) {
			# if there is a digit, shift any existing digits left and add
			my $digit = $lines[$line][$operation_start[$problem_index] + $offset];
			if ($digit =~ /[0-9]/) {
				$this_term *= 10;
				$this_term += $digit;
			}
		}
		if ($this_term > 0) {
			push @terms, $this_term;
		}
	}

	# perform the operation on the terms and add to grand total
	my $value = shift @terms;
	foreach my $term (@terms) {
		if ($operations[$problem_index] eq '+') {
			$value += $term;
		} else {
			$value *= $term;
		}
	}
	$grand_total += $value;
}

print "Grand Total = $grand_total\n";