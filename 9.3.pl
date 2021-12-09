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


# File 9.3.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Измените предыдущую программу 9.2.pl так, чтобы каждое вхождение Fred  заменялось строкой Wilma,
# а каждое вхождение Wilma – строкой Fred. Входная строка fred&wilma в выходных данных должна
# принимать вид Wilma&Fred.

chomp(@_);
$^I = ".out9.3.txt";
my $out = $ARGV[0].$^I;
my $in = $ARGV[0];
my $in_fh;
my $out_fh;

if (!defined $in) {
    die "Usage: $0 filename";
}

if (!open $in_fh, '<', $in) {
    die "Can't open '$in': $!";
}
if (!open $out_fh, '>', $out) {
    die "Can't write '$out': $!";
}

while (<$in_fh>) {
    s/^\s*$//g; # remove empty lines
    s/^\W*$//g; # remove lines without letters
    s/Fred/MASK/ig;
    s/Wilma/Fred/ig;
    s/MASK/Wilma/g;
    print $out_fh $_;
    }


# Странное решение в книге
#


# Верный ответ из книги:
#Here’s one way to do it:

# while (<$in_fh>) {
# chomp;
# s/Fred/\n/gi;        # Replace all FREDs
# s/Wilma/Fred/gi;     # Replace all WILMAs
# s/\n/Wilma/g;        # Replace the placeholder
# print $out_fh "$_\n";
# }
# This replaces the loop from the previous program, of course.
# To do this kind of a swap, we need to have some “placeholder”
# string that doesn’t otherwise appear in the data. By using chomp
# (and adding the newline back for the output), we ensure that a
# newline (\n) can be the placeholder. (You could choose some other
# unlikely string as the placeholder. Another good choice would be the
# NUL character, \0.)