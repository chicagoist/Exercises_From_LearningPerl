#!/usr/bin/perl

#https://ru.wikipedia.org/wiki/%D0%A8%D0%B5%D0%B1%D0%B0%D0%BD%D0%B3_(Unix)

use 5.10.0;
use strict;
#для того чтобы можно было использовать полезные функции из новых версий. Например, say
use utf8;
use open qw( :std :encoding(UTF-8) );
use warnings;


sub primes_from_interval {
    my ( $x, $y ) = @_;

    my $i;
    my $j;

    #$x = 1;
    #$y = 4;

    my $is_prime = 1;

    if ( $x > 0 ) {

        for ( $i = $x + 1 ; $i <= $y ; $i++ ) {
            $is_prime = 1;

            for ( $j = $x ; $j <= sqrt($i) ; $j++ ) {
                if ( $i % $j == 0 ) {
                    $is_prime = 0;
                    last;
                }
            }
            if ( $is_prime == 1 ) {
                print "$i\n";
            }
        }
    }

}

primes_from_interval( 1, 4 );
