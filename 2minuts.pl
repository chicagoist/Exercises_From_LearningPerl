#!/usr/bin/perl


use 5.28.0; #для того чтобы можно было использовать полезные функции из новых версий. Например, say
use utf8;
use open qw( :std :encoding(UTF-8) );
use warnings;


my @lines = `perldoc -u -f atan2`;
foreach (@lines) {

  #s/\w*<([^>]+)>/\U$1/g;
  s/\w<(.+?)>/\U$1/g;
  
  print;
}