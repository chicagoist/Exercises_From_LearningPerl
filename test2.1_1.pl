#!/usr/bin/perl -w


use 5.10.0;
use strict;
#для того чтобы можно было использовать полезные функции из новых версий. Например, say
use utf8;
use open qw( :std :encoding(UTF-8) );
use warnings;


sub min_and_max {
    my ( $x, $y, $z ) = @_;

    $_[0] = 2;
    $_[1] = 1;
    $_[2] = -1;

    my $value1 = $_[0];
    my $value2 = $_[0];

    for ( my $i = 0 ; $i <= 2 ; $i++ ) {
        if ( $value1 > $_[$i] ) {
            $value1 = $_[$i];

        }
    }

    for ( my $j = 0 ; $j <= 2 ; $j++ ) {
        if ( $value2 < $_[$j] ) {
            $value2 = $_[$j];
        }

    }

    print "$value1, $value2\n";
}

min_and_max();
