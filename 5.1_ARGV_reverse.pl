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

use 5.10.0;
use strict;
use open qw(:utf8);
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use utf8;
use warnings;


sub reverse_argv {

    if (@ARGV == 0) {die "Miss Arguments? usage: pick file_name line_no1 line_no2 ..."};
    state @my_list;
    foreach (0 .. $#ARGV) {
        push @my_list, $ARGV[$_];
    }
    @my_list = reverse @my_list;
    print join(", ", @my_list);

}


&reverse_argv;


# Верный ответ из книги:

# Немного отсебятины : попробовал вывести список аргументов реверсивно.