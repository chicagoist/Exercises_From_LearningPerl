#!/usr/bin/perl -w

use 5.10.0;
# use CGI;
# use POSIX;
# use Encode qw(decode_utf8);
# use Encode qw(decode encode);
# BEGIN{@ARGV=map Encode::decode($_,1),@ARGV;}
# BEGIN{@ARGV = map decode_utf8($_, 1), @ARGV;}
# use open qw(:std :encoding(UTF-8));
# use utf8::all 'GLOBAL';
# use Encode::Locale;
# use Encode;
# use diagnostics;


use strict;
use warnings FATAL => 'all';
use utf8;
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use DDP;
use Data::Dumper;
# use Time::Moment;


# File 12.3.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Напишите программу, которая использует сгруппированные операторы проверки
# файлов для перечисления всех файлов, указанных в командной строке,
# принадлежащих вам и доступных для чтения и записи.

state @files_O_R_W;
sub files_group_check {
    chomp(@ARGV);

    foreach (@ARGV) {
        if (-O -R -W $_) {
            push @files_O_R_W, $_;
        }
    }
    # p @files_O_R_W;
    foreach (@files_O_R_W) {
        printf("File with -O -R -W : %s\n", $_);
    }
}

files_group_check();


# Верный ответ из книги:

# Here’s one way to do it: use v5.10; say "Looking for my files that are readable and writable";

# die "No files specified!\n" unless @ARGV;
# foreach my $file (@ARGV) {
#     say "$file is readable and writable" if -o -r -w $file;
# }

# To use stacked file test operators, we need to use Perl 5.10 or later,
# so we start with the use statement to ensure that we have the right version of Perl.
# We die if there are no elements in @ARGV, and go through them with foreach otherwise.
# We have to use three file test operators: -o to check if we own the file, -r to check
# that it is readable, and -w  to check if it is writable. Stacking them as -o -r -w creates
# a composite test that only passes if all three of them are true, which is exactly what we want.
# If we wanted to do this with a version before Perl 5.10, it’s just a little more code.
# The says become prints with added newlines, and the stacked file tests become separate tests
# combined with the && short-circuit operator:

# print "Looking for my files that are readable and writable\n";
# die "No files specified!\n" unless @ARGV;
# foreach my $file (@ARGV) {
#     print "$file is readable and writable\n"
#         if (-w $file && -r _ && -o _);
# }