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
        next if $len % 2;
        my $first_half = substr($id, 0, $len/2);
        my $second_half = substr($id, $len/2);
        if ($first_half eq $second_half) {
            $counter += $id;
        }
    }
}

print "$counter\n";