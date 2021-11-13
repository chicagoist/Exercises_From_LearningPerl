#!/usr/bin/perl -w

# Используя функцию из упражнения 4.1_total.pl, напишите
# программу для вычисления суммы чисел от 1 до 1000.

use 5.10.0;
use strict;
use utf8;
use open qw( :std :encoding(UTF-8) );
use warnings;

print "Введите два числа. Начало и конец диапазона : \n";
my $user_total = total(<STDIN>);
print "Общая сумма всех чисел дипазона равна $user_total.\n";

sub total {

    my ( $start_number, $finish_number ) = @_;
    my $sum = 0;

    for ( my $i = $start_number ; $i <= $finish_number ; $i++ ) {
        $sum += $i;

    }

    return $sum;

}

# Верный отыет из книги:

# 2. Here's one way to do it:
# # Remember to include &total from previous exercise!
#
#      print "The numbers from 1 to 1000 add up to ", total(1..1000), ".\n";
#
# Note that we can't call the subroutine from inside the double-quoted string, so
# the subroutine call is another separate item being passed to print. The total
# should be 500500, a nice round number. And it shouldn't take any noticeable
# time at all to run this program; passing a parameter list of 1,000 values is an
# everyday task for Perl.
