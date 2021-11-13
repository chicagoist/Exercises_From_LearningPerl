#!/usr/bin/perl -w


use 5.10.0;
use strict;
#для того чтобы можно было использовать полезные функции из новых версий. Например, say
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
