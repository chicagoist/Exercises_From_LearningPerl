#!/usr/bin/perl -wT

use 5.10.0;
use strict;
use open qw(:std :encoding(UTF-8));
use Encode qw(decode_utf8);
BEGIN{@ARGV = map decode_utf8($_, 1), @ARGV;}
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use utf8;
use warnings;
use POSIX;
use utf8::all 'GLOBAL'; # пробую этот модуль вместо закомментированных выше строк
use CGI;

# File 8.3.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# This next line of code is used when you get to Chapter 9.
# my $what = 'fred|barney';

# Измените программу из предыдущего упражнения 8.2.pl так, чтобы слово,
# завершающееся буквой a, сохранялось в переменной $1. Значение переменной
# должно выводиться в апострофах, например $1 contains 'Wilma'.

while (<>) {
    chomp;
    # If you want to try matching strings which may contain
    # newlines, here's the trick to use: Uncomment this next
    # line, then use a pound sign ("#") wherever you mean to
    # have a newline within your data string.
    # s/#/\n/g;

    if (/(\w+(a)\b)/) {
        print "Matched: |$`<$&>$'|\n";
        say "\$1 = '$1'";
    } else {
        print "No match.\n";
    }
}
# $ perl -T 8.3.pl
#   Будет ли он совпадать с wilma, но не с barney?
#       Matched: | Будет ли он совпадать с <wilma>, но не с barney?|
#       $1 = 'wilma'
#
