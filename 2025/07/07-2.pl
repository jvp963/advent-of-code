#!/usr/bin/perlaa

use strict;
use warnings;

# read input
my @map = ( );
while (<>) {
	push @map, [ split(//, $_) ];
}
my $width = $#{$map[0]};

my $world_count = 0;
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
				$beams_at[$loc] = 0;
				if ($loc - 1 >= 0) {
					$world_count++;
					unless ($beams_at[$loc-1]) {
						$beams_at[$loc-1] = 1;
					}
				}
				if ($loc + 1 <= $width) {
					$world_count++;
					unless ($beams_at[$loc+1]) {
						$beams_at[$loc+1] = 1;
					}
				}
			}
		}
	}
	#print "After row $row, beams at " . join(",", @beams_at) . "\n";
}
$world_count -= 2;

print "Total world count = $world_count\n";