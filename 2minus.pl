#!/usr/bin/perl


# File 2minus.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


use 5.10.0;
use strict;
use open qw(:utf8);
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use utf8;
use warnings;


my @lines = `perldoc -u -f atan2`;
foreach (@lines) {

  #s/\w*<([^>]+)>/\U$1/g;
  s/\w<(.+?)>/\U$1/g;
  
  print;
}