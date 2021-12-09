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


# File 9.2.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Напишите программу, которая создает измененную копию текстового файла.
# В копии каждое вхождение строки Fred (с любым регистром символов) должно
# заменяться строкой Larry  (таким образом, строка Manfred Mann должна превратиться
# в ManLarry Mann). Имя входного файла должно задаваться в командной строке (не запрашивайте
# его у пользователя!), а имя выходного файла образуется из того же имени и расширения .out.

chomp(@_);
$^I = ".out";
while (<>) {
    s/^\s*$//g; # remove empty lines
    s/^\W*$//g; # remove lines without letters
    s/fred/Larry/ig;
    print;
}


# Странное решение в книге
#  perl 9.2.pl sample_text


# Верный ответ из книги:
#Here’s one way to do it:
#
# my $in = $ARGV[0];
# if (!defined $in) {
#     die "Usage: $0 filename";
# }
# my $out = $in;
# $out =~ s/(\.\w+)?$/.out/;
# if (!open $in_fh, '<', $in) {
#     die "Can't open '$in': $!";
# }
# if (!open $out_fh, '>', $out) {
#     die "Can't write '$out': $!";
# }
# while (<$in_fh>) {
#     s/Fred/Larry/gi;
#     print $out_fh $_;
# }

# This program begins by naming its one and only command-line parameter,
# and complaining if it didn’t get it. Then it copies that to $out and
# does a substitution to change the file extension, if any, to .out.
# (It would be sufficient, though, to merely append .out to the filename.)
# Once the filehandles $in_fh  and $out_fh  are opened, the real program can
# begin. If you didn’t use both options /g and /i, take off half a point,
# since every fred and Fred should be changed.