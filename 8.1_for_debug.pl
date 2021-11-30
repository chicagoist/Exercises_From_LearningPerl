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

# File 8.1.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# This next line of code is used when you get to Chapter 9.
# my $what = 'fred|barney';

# Создайте в тестовой программе шаблон для строки match.
# Запустите программу для входной строки beforematchafter.
# Выводятся ли в результатах все три части строки в правильном порядке?

my @arr_text;

while (<>) {
    chomp;

    say "\$_ => $_";
    if (/\Bmatch\B/) {
        print "Matched : |$`<$&>$'|\n";
        #  матчится before3match5after
        #  матчится тоже beforematchafter
    }
    else {
        print "No match.\n";
    }

    if (/\bfred\b/) {
        print " Matched: |$`<$&>$'|\n ";
    }
    else {
        print "No match.\n";
    }
}


# Верный ответ из книги:

#Here’s one way to do it:
# There’s one easy way to do it,
# and we showed it back in the chapter body.
# But if your output isn’t saying before<match>after  as it should,
# you’ve chosen a hard way to do it.