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


# File 9.5.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Упражнение на «совсем повышенную оценку»: измените предыдущую программу 9.4.pl так,
# чтобы она не изменяла файлы, уже содержащие строку с информацией об авторских правах.
# (Подсказка: имя файла, из которого оператор <>  читает данные, хранится в $ARGV.)

chomp(@_);
my $in_fh;
my @year = split /.*20/, gmtime();
my $in_without;
$^I = ".out9.5.txt";
my $in_withCopyright;

print "Files in \@ARGV : ", join(", ", @ARGV), "\n";
foreach my $i (0 .. $#ARGV) {
    if (!open $in_fh, '<', $ARGV[$i]) {
        die "Can't open '$in_fh': $!";
    }
    while (<$in_fh>) {
        if (/.*Copyright.*/) {
            splice @ARGV, $i, 1;
        }
    }
    close($in_fh);
}
print "Only the files without Copyright : " . "'@ARGV'\n";

exit unless @ARGV;
while (<@ARGV>) {

    if (!open $in_without, '<', $_) {
        die "Can't open '$_': $!";
    }

    if (!open $in_withCopyright, '>', $_ . $^I) {
        die "Can't open $_.$^I: $!";
    }

    while (<$in_without>) {
        $_ =~ s|^#\s*\W*$|"\r## Copyright (C) 20$year[1] by Yours Valerii"|ge;
        print $in_withCopyright $_;
    }
}
close($in_without);
close($in_withCopyright);

# Верный ответ из книги:
#To keep from adding the copyright twice, we have to make two passes over the files.
# First, we’ll make a “set” with a hash where the keys are the filenames and the values don’t matter
# (although we’ll use 1 for convenience):

# my %do_these;
# foreach (@ARGV) {
#     $do_these{$_} = 1;
# }

# Next, we’ll examine the files and remove from our to-do list any file that already contains the copyright.
# The current filename is in $ARGV, so we can use that as the hash key:

# while (<>) {
#     if (/\A## Copyright/) {
#         delete $do_these{$ARGV};
#     }
# }

# Finally, it’s the same program as before, once we’ve reestablished a reduced list of names in @ARGV:

# @ARGV = sort keys %do_these;
# $^I = ".bak";      # make backups
# exit unless @ARGV; # no arguments reads from standard input!
# while (<>) {
#     if (/\A#!/) { # is it the shebang line?
#         $_ .= "## Copyright (c) 20XX by Yours Truly\n";
#     }
#     print;
# }