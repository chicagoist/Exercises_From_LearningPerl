#!/usr/bin/perl -w

use 5.28.0
  ; #для того чтобы можно было использовать полезные функции из новых версий. Например, say
use utf8;
use open qw( :std :encoding(UTF-8) );
use warnings;

my $hello = "Hello, World!\n";

print $hello;

