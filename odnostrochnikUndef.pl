#!/usr/bin/perl -w

use strict;
use 5.28.0; #для того чтобы можно было использовать полезные функции из новых версий. Например, say
use utf8;
use open qw( :std :encoding(UTF-8) );
use warnings;



my $madonna = <>;

if ( defined($madonna) ) {
    print "The input was $madonna";
}
else {
    print "No input available\n";
}
