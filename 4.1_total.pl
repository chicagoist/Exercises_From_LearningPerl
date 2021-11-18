#!/usr/bin/perl -w

# File 4.1_total.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


use 5.10.0;
use strict;
use open qw(:utf8);
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use utf8;
use warnings;


# Напишите пользовательскую функцию с именем total, которая
# возвращает сумму чисел в списке. (Подсказка: пользовательская
# функция не должна выполнять ввод/вывод; она только обрабатывает
# свои параметры и возвращает значение вызывающей стороне.)
# Проверьте ее в приведенной ниже тестовой программе. Сумма первой группы чисел { 1 3 5 7 9 }
# должна быть равна 25.




my @fred       = qw{ 1 3 5 7 9 };
#my @fred       = (1..1000);
my $fred_total = total(@fred);
print "The total of \@fred is $fred_total.\n";
print "Enter some numbers on separate lines: ";
my $user_total = total(<STDIN>);
print "The total of those numbers is $user_total.\n";

sub total {

    my $sum = 0;

    foreach (@_) {
        $sum += $_;
    }

    return $sum;

}

# Верный ответ из книги:

# Here’s one way to do it:
# sub total {
# my $sum;  # private variable
# foreach (@_) {
# $sum += $_;
# }
# $sum;
# }
