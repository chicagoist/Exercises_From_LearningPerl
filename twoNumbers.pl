#!/usr/bin/perl -w

#Напишите программу, которая запрашивает и получает два числа 
#(в разных строках ввода), а затем выводит их произведение.
use strict;
use 5.28.0;#для того чтобы можно было использовать полезные функции из новых версий. Например, say
use utf8;
use open qw( :std :encoding(UTF-8) );
use warnings;




sub twoNumbers {

    print "Введите первое число: ";
    my $firstNumber = <>;

    print "Введите второе число: ";
    my $secondNumver = <>;

    if ( defined($firstNumber) && defined($secondNumver) ) {
        print"Произведение этих двух чисел равно: " . $firstNumber * $secondNumver . "\n";
    }
}

twoNumbers();

