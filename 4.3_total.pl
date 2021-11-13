#!/usr/bin/perl -w

# Более сложная задача: напишите пользовательскую функцию
#     &above_average, которая получает список чисел и возвращает те из
#     них, которые превышают среднее арифметическое группы. (ПодQ
#     сказка: напишите отдельную функцию для вычисления среднего
# арифметического делением суммы  на количество элементов.) ПроQ
#     верьте написанную функцию в следующей тестовой программе:
#
# my @fred = above_average(1..10);
# print "\@fred is @fred\n";
# print "(Should be 6 7 8 9 10)\n";
# my @barney = above_average(100, 1..10);
# print "\@barney is @barney\n";
# print "(Should be just 100)\n";

use 5.28.0;
use strict;
use utf8;
use open qw(:std :encoding(UTF-8));
use warnings;

my $list_of_numbers = arithmetical_mean(100, 1 .. 10);
#my $list_of_numbers = arithmetical_mean(1 .. 10);
print "Среднее арифметическое всех чисел списка равна : $list_of_numbers \n";
my @exceed_arithmetic_average = above_average(100, 1 .. 10);
#my @exceed_arithmetic_average = above_average(1 .. 10);
print "Числа из списка, превышающие среднее арифметическое списка : @exceed_arithmetic_average\n";

sub above_average {

    my (@numbers_array) = @_;
    my $mean_sum = arithmetical_mean(@numbers_array);
    my @number_above;

    foreach (@numbers_array) {

        if ($_ > $mean_sum) {

            push(@number_above, $_);
        }

    }

    @number_above;

}



sub arithmetical_mean {

    my $sum = 0;
    foreach (@_) {

        $sum += $_;
    }

    return ($sum / @_);
}


# Верный ответ из книги:


# 3. Here’s one way to do it:
# sub average {
#     if (@_ == 0) { return }
#     my $count = @_;
#     my $sum = total(@_);               # from earlier exercise 4.1_total.pl
#     $sum/$count;
# }
# sub above_average {
#     my $average = average(@_);
#     my @list;
#     foreach my $element (@_) {
#         if ($element > $average) {
#             push @list, $element;
#         }
#     }
#     @list;
#
# }