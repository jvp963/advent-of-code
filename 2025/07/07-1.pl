#!/usr/bin/perlaa

use strict;
use warnings;

# read input
my @map = ( );
while (<>) {
	push @map, [ split(//, $_) ];
}
my $width = $#{$map[0]};

my $split_count = 0;
my @beams_at = ( );

# process top row
foreach my $loc (0..$width) {
	if ($map[0][$loc] eq 'S') {
		$beams_at[$loc] = 1;
	} else {
		$beams_at[$loc] = 0;
	}
}

# procss additional rows
foreach my $row (1..$#map) {
	foreach my $loc (0..$width) {
		if ($map[$row][$loc] eq '^') {
			if ($beams_at[$loc]) {
				$split_count++;
				$beams_at[$loc] = 0;
				if ($loc - 1 >= 0) {
					$beams_at[$loc-1] = 1;
				}
				if ($loc + 1 <= $width) {
					$beams_at[$loc+1] = 1;
				}
			}
		}
	}
}

print "Total split count = $split_count\n";