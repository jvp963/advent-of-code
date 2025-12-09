#!/usr/bin/perlaa

use strict;
use warnings;

my @map = ( );

# read input
while (<>) {
	chomp;
	push @map, [ split(//, $_) ];
}
my $width = $#{$map[0]};


# process top row
my @beams_above = ( );
my @beams_at = ( );
foreach my $row (1..$#map) {
	foreach my $loc (0..$width) {
		if ($map[0][$loc] eq 'S') {
			$beams_above[$loc] = 1;
			$beams_at[$loc] = 0;
		} else {
			$beams_above[$loc] = 0;
			$beams_at[$loc] = 0;
		}
	}
}

foreach my $row (1..$#map) {
	#print "ABOVE: ", join(" ", @beams_above),"\n";
	#print "CURNT: ", join(" ", @{$map[$row]}),"\n";
	foreach my $loc (0..$width) {
		if ($map[$row][$loc] eq '^') {
			# look above for beam and split if needed
			if ($beams_above[$loc] > 0) {
				$beams_at[$loc-1] += $beams_above[$loc];
				$beams_at[$loc+1] += $beams_above[$loc];
				$beams_at[$loc] = 0;
			}
		} else {
			$beams_at[$loc] += $beams_above[$loc];
		}
	}
	@beams_above = @beams_at;
	foreach my $reset_loc (0..$width) {
		@beams_at[$reset_loc] = 0;
	}
	my $row_paths = 0;
	foreach (@beams_above) {
		$row_paths += $_;
	}
	#print "AFTER: ", join(" ", @beams_above),"\n";
	#print "Row $row, row paths = $row_paths\n\n";
	#last if $row == 2;
}

my $total_paths = 0;
foreach (@beams_above) {
	$total_paths += $_;
}



print "Total world count = $total_paths\n";