#!/usr/bin/perl

use strict;
use warnings;

my @ranges = ( );
while (<>) {
    chomp;
    @ranges = split(/,/, $_);
}

my $counter = 0;
foreach my $range (@ranges) {
    my($start, $end) = split(/\-/, $range);
    foreach my $id ($start .. $end) {
        my $len = length($id);

        # skip single digit ids
        next unless $len > 1;

        ## maximum repeating pattern length is half the length
        my $max_repeat_possible = int($len/2);

        ## look for single-digit repeats, two-digit repeats, three, etc.
        foreach my $check_len (1..$max_repeat_possible) {
            ## skip if the total length isn't a multiple of this length
            next if $len % $check_len;

            my $template = substr($id, 0, $check_len);

            ## walk through the string in chunks of $check_len size to see if all match $template
            my $all_match = 1;
            my $str_pos = $check_len;
            while (length($id) >= $str_pos + $check_len) {
                my $check = substr($id, $str_pos, $check_len);
                if ($check ne $template) {
                    $all_match = 0;
                    last;
                }
                $str_pos += $check_len;
            }

            if ($all_match) {
                $counter += $id;
                last;
            }
        }
    }
}

print "$counter\n";