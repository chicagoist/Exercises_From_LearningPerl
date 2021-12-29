#!/usr/bin/perl -w

use 5.10.0;
# use CGI;
# use Encode qw(decode_utf8);
# use Encode qw(decode encode);
# BEGIN{@ARGV=map Encode::decode($_,1),@ARGV;}
# BEGIN{@ARGV = map decode_utf8($_, 1), @ARGV;}
# use open qw(:std :encoding(UTF-8));
# use utf8::all 'GLOBAL';
# use Encode::Locale;
# use Encode;
# use Time::Moment;
# use diagnostics;


use strict;
use warnings FATAL => 'all';
use utf8;
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use DDP;
use Data::Dumper;



# File 14.1.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/



# Напишите программу, которая читает список чисел и сортирует их по возрастанию.
# Полученный список выводится в столбец с выравниванием по правому краю.
# Опробуйте программу на следующих тестовых данных или воспользуйтесь файлом numbers с
# сайта O’Reilly

sub sort_numbers {
    state @result;
    my $max_lengths = 0;

    foreach (<@_>) {
        if (length($_) > $max_lengths) {
            $max_lengths = length($_);
        }
    }

    foreach (sort { $a <=> $b } <@_>) {
        push @result, $_;
        printf("%${max_lengths}s\n", $_);
    }
# or like this:
    foreach (@result) {
        printf("%${max_lengths}s\n", $_);
    }
}
sort_numbers(<>);

=begin text

 $ perl 14.1.pl examples/sample_files/numbers

=end text

=cut


# Верный ответ из книги:

# Here’s one way to do it:
#
# my @numbers;
# push @numbers, split while <>;
# foreach (sort { $a <=> $b } @numbers) {
#    printf "%20g\n", $_;
# }

# That second line of code is too confusing, isn’t it? Well,
# we did that on purpose. Although we recommend that you write
# clear code, some people like writing code that’s as hard to
# understand as possible, so we want you to be prepared for the worst.
# Someday you’ll need to maintain confusing code like this. Since that
# line uses the while modifier, it’s the same as if it were written in
# a loop like this:
#
#    while (<>) {
#        push @numbers, split;
# }
#
# That’s better, but maybe it’s still a little unclear.
# (Nevertheless, we don’t have a quibble about writing it this way. This one
# is on the correct side of the “too hard to understand at a glance” line.)
# The while loop is reading the input one line at a time (from the user’s choice
# of input sources, as shown by the diamond opera‐ tor), and split is, by default,
# splitting that on whitespace to make a list of words —or in this case, a list of
# numbers. The input is just a stream of numbers separa‐ ted by whitespace, after all.
# Either way you write it, then, that while loop will put all of the numbers from the
# input into @numbers. The foreach loop takes the sorted list and prints each item on
# its own line, using the %20g numeric format to put them in a right-justified column.
# You could have used %20s instead. What difference would that make? Well, that’s a
# string format, so it would have left the strings untouched in the output. Did you
# notice that our sample data included both 1.50 and 1.5, and both 04 and 4? If you
# printed those as strings, the extra zero characters will still be in the output;
# but %20g  is a numeric format, so equal numbers will appear identically in the output.
# Either format could potentially be correct, depending on what you’re trying to do.