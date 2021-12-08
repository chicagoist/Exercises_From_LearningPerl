#!/usr/bin/perl

#use CGI;
#use POSIX;
#use utf8;
use 5.10.0;
use strict;
use open qw(:std :encoding(UTF-8));
use Encode qw(decode_utf8);
BEGIN{@ARGV = map decode_utf8($_, 1), @ARGV;}
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use warnings;
use utf8::all 'GLOBAL'; # пробую этот модуль вместо закомментированных выше строк
use Encode::Locale;
use diagnostics;


# File 9.1.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Создайте шаблон, который совпадает с тремя последовательными копиями
# текущего содержимого $what. Иначе говоря, если $what содержит fred,
# шаблон должен совпасть с fredfredfred. Если $what содержит fred|barney,
# шаблон должен совпадать с fredfredbarney, barneyfredfred, barneybarneybarney
# и множеством других вариантов. (Подсказка: значение $what  должно задаваться
# в начале тестовой программы командой вида $what = 'fred|barney';.)

# Make a pattern that will match three consecutive copies of whatever is currently
# contained in $what. That is, if $what  is fred, your pattern should match fredfredfred.
# If $what is fred|barney, your pattern should match fredfredbarney or barneyfredfred or
# barneybarneybarney or many other variations. (Hint: you should set $what at the top of
# the pattern test program with a statement like my $what = 'fred|barney';.)

# This next line of code is used when you get to Chapter 9.
my $what = "fred|barney";

sub pattern {
    @_ = ('fredfredbarney', 'barneyfredfred', 'fredfredfred');
    foreach (@_) {
        print "Match !\n" if $_ = /[$what]{3}/;
    }
}
pattern();


# Не так изящно, как в книге, но так непонятно ставить ТЗ - это жесть.
#


# Верный ответ из книги:
# Here’s one way to do it:
#    /($what){3}/
# Once $what  has been interpolated,
# this gives a pattern resembling /(fred| barney){3}/.
# Without the parentheses, the pattern would be something like /fred|barney{3}/,
# which is the same as /fred|barneyyy/. So the parentheses are required.