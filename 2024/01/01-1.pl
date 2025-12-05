#!/usr/bin/perl

use strict;
use warnings;

my @nums1 = ( );
my @nums2 = ( );
while (<>) {
    next unless /^(\d+)\s+(\d+)\s?$/;
    push @nums1, $1;
    push @nums2, $2;
}

my @sorted1 = sort {$a <=> $b} @nums1;
my @sorted2 = sort {$a <=> $b} @nums2;

my $total = 0;
foreach (0..$#sorted1) {
    $total += abs($sorted2[$_] - $sorted1[$_]);
}

print "$total\n";
