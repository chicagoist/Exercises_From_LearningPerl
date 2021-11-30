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

# File 8.4.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# This next line of code is used when you get to Chapter 9.
# my $what = 'fred|barney';

# Измените программу из предыдущего упражнения  8.3.pl так,
# чтобы вместо $1 в ней использовались именованные сохранения.
# Обновите программу, чтобы метка переменной выводилась в итоговом
# сообщении, например
#    'word' contains 'Wilma'.

while (<>) {
    chomp;
    # If you want to try matching strings which may contain
    # newlines, here's the trick to use: Uncomment this next
    # line, then use a pound sign ("#") wherever you mean to
    # have a newline within your data string.
    # s/#/\n/g;

    if (/(?<word>\w*a\b)/) {
        print "Matched: |$`<$&>$'|\n";
        say keys %+, " => '$+'";
    }
    else {
        print "No match.\n";
    }
}
# $ perl -T 8.3.pl
# Будет ли он совпадать с wilma, но не с barney?
#   Matched: | Будет ли он совпадать с <wilma>, но не с barney?|
#   word => 'wilma'
#


# Верный ответ из книги:

#Here’s one way to do it:
# This exercise answer is the same as the previous exercise answer,
# but with a slightly different regular expression:
# while (<STDIN>) {
#     chomp;
#     if (/(\b\w*a\b)/) {
#         print "Matched: |$`<$&>$'|\n";
#         print "'word' contains '$+{word}'\n";       # The new output line
#     }
#     else {
#         print "No match: |$_|\n";
#     }
# }
