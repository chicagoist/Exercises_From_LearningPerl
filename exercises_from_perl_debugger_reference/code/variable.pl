
$variable = 'auto-declared';  # I<ok>

use strict;

$variable = 'second use';     # I<this is a compile time error>

my $variable = 'now ok';      # I<ok>

print "$variable\n";

