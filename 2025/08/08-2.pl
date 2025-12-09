#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

# read input
my @coords = ( );
while (<>) {
	chomp;
	push @coords, [split(/,/, $_)];
}

my @shortest_a = ( );
my @shortest_b = ( );
my $shortest_distance = undef;

my @neighbors = ( );

## calculate distances between boxes
foreach my $first (0..$#coords) {
	my($first_x, $first_y, $first_z) = @{$coords[$first]};
	foreach my $second (0..$#coords) {
		next if $second == $first;
		my($second_x, $second_y, $second_z) = @{$coords[$second]};
		my $delta_x = $second_x - $first_x;
		$delta_x = -$delta_x if $delta_x < 0;
		my $delta_y = $second_y - $first_y;
		$delta_y = -$delta_y if $delta_y < 0;
		my $delta_z = $second_z - $first_z;
		$delta_z = -$delta_z if $delta_z < 0;
		my $distance = sqrt($delta_x ** 2 + $delta_y ** 2 + $delta_z ** 2);

		push @{$neighbors[$first]}, [$second, $distance];
	}
}
foreach (0..$#neighbors) {
	$neighbors[$_] = [ sort { @{$a}[1] <=> @{$b}[1] } @{$neighbors[$_]} ];
}

sub connect_circuit {
	my $current_circuits = shift;
	my $a = shift;
	my $b = shift;

	# four scenarios for connection:
	# 1. circuits are already connected
	# 2. this new connection joins two previous unconnected circuits
	# 3. this new connection extends an existing circuit
	# 4. brand new circuit

	foreach my $circuit (@{$current_circuits}) {
		if (grep(/^$a$/, @{$circuit}) && grep(/^$b$/, @{$circuit})) {
			# option 1 - already connected
			return $current_circuits;
		}
	}

	my $connect_a_index = undef;
	my $connect_b_index = undef;
	foreach my $index (0 .. $#{$current_circuits}) {
		my @circuit = @{@{$current_circuits}[$index]};
		if (grep(/^$a$/, @circuit)) {
			$connect_b_index = $index;
		} elsif (grep(/^$b$/, @circuit)) {
			$connect_a_index = $index;
		}
	}

	if (defined $connect_a_index && defined $connect_b_index) {
		# option 2 - join 2 existing circuits
		my $new_circuit = [ @{@{$current_circuits}[$connect_a_index]}, @{@{$current_circuits}[$connect_b_index]} ];
		if ($connect_a_index > $connect_b_index) {
			splice(@{$current_circuits}, $connect_a_index, 1);
			splice(@{$current_circuits}, $connect_b_index, 1);
		} else {
			splice(@{$current_circuits}, $connect_b_index, 1);
			splice(@{$current_circuits}, $connect_a_index, 1);
		}
		push @{$current_circuits}, $new_circuit;
	} elsif (defined $connect_a_index) {
		# option 3 - extend an existing circuit
		push @{@{$current_circuits}[$connect_a_index]}, $a;
	} elsif (defined $connect_b_index) {
		# option 3 - extend an existing circuit
		push @{@{$current_circuits}[$connect_b_index]}, $b;
	} else {
		# option 4 - brand new circuit
		push @{$current_circuits}, [ $a, $b ];
	}
	return $current_circuits;
}

my $circuits = [ ];
my @nearest_conn = ( );
my $connection_count = 0;
do {
	my $nearest_dist = undef;
	@nearest_conn = ( );
	foreach my $index (0..$#neighbors) {
		my($test_index, $test_dist) = @{@{$neighbors[$index]}[0]};
		if (!(defined $nearest_dist) || $test_dist < $nearest_dist) {
			$nearest_dist = $test_dist;
			@nearest_conn = ($index, $test_index);
		}
	}

	# remove this connection from consideration for future connections
	shift @{$neighbors[$nearest_conn[0]]};
	shift @{$neighbors[$nearest_conn[1]]};
	$circuits = connect_circuit($circuits, @nearest_conn);

	$connection_count++;
} until $#{$circuits} == 0 && (scalar @{@{$circuits}[0]} == scalar @coords);

my @last_connected_a = @{$coords[$nearest_conn[0]]};
my @last_connected_b = @{$coords[$nearest_conn[1]]};
my $x_coordinate_product = $last_connected_a[0] * $last_connected_b[0];

print "It took $connection_count connections to have one big circuit\n";
print "Most recently connected (", join(",", @last_connected_a), ") and (", join(",", @last_connected_b), ")\n";
print "X coord product is $x_coordinate_product\n";