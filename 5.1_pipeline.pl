#!/usr/bin/perl -w

# File 5.1.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/

# Write a program that acts like cat  but reverses the order of the output lines.
# (Some systems have a utility like this named tac.) If you run yours as ./tac fred
# barney betty, the output should be all of file betty  from last line to first, then
# barney, and then fred, also from last line to first. (Be sure to use the ./  in your
# program’s invocation if you call it tac  so that you don’t get the system’s utility
# instead!)

use strict;
use open qw(:utf8);
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use utf8;
use warnings;


sub reverse_stdout {

        print  reverse  @_;

}

reverse_stdout(<STDIN>);



# $ cat logfile | ./5.1_pipeline.pl

