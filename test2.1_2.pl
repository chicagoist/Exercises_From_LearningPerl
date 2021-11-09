#!/usr/bin/perl -w


use 5.28.0; #для того чтобы можно было использовать полезные функции из новых версий. Например, say
use utf8;
use open qw( :std :encoding(UTF-8) );
use warnings;

my $A = <>;

if ( $A == 0 ) {
    print "No solution!";
}
else {
    my $B = <>;
    my $C = <>;
    my $D = $B * $B - 4 * $A * $C;
    if ( $D == 0 ) {
        print -0.5 * $B / $A, "\n";
    }
    else {
        if ( $D > 0 ) {
            print 0.5 * ( -$B + sqrt($D) ) / $A, ", ",
              0.5 * ( -$B - sqrt($D) ) / $A, "\n";
        }
        else {
            print -0.5 * $B / $A, ", ", 0.5 * sqrt( -$D ) / $A, ", ",
              -0.5 * $B / $A, ", ", -0.5 * sqrt( -$D ) / $A, "\n";
        }
    }
}
