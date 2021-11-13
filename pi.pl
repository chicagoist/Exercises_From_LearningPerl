#!/usr/bin/perl -w


use 5.10.0;
use strict;
# для того чтобы можно было использовать полезные функции из новых версий. Например, say
use utf8;
use open qw( :std :encoding(UTF-8) );
use warnings;

state $pi = 3.141592654;
my $Circ = 2 * $pi * 12.5;
print "The circumference of a circle of radius 12.5 is $Circ.\n";