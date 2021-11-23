#!/usr/bin/perl -w

# File 6.3.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/

# Напишите программу для вывода всех ключей и значений
# в %ENV. Выведите результаты в два столбца в ASCII-алфавитном порядке.
# Отформатируйте результат так, чтобы данные в обоих столбцах
# выравнивались по вертикали. Функция length поможет вычислить
# ширину первого столбца. Когда программа заработает, попробуйте
# задать новые переменные среды и убедитесь в том, что они
# присутствуют в выходных данных.


use 5.10.0;
use strict;
use open qw(:utf8);
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use utf8;
use warnings;
use POSIX;
#use utf8::all 'GLOBAL'; # пробую этот модуль вместо закомментированных выше строк

my $max_length = 0;
my @names_env;

push @names_env, sort {$a cmp $b} keys %ENV; # заводим все ключи нашего хеша в массив, через функцию sort

foreach my $key (keys %ENV) {# ищем длину самого широкого ключа
    if (length($key) > $max_length) {
        $max_length = length($key); # присваиваем значение переменной.
    }
}

foreach (sort @names_env) {
    printf("%-${max_length}s %s\n", $_ ,$ENV{$_}); # вводим массив в столбец, шириной $max_length
}



# Верный ответ из книги:

#Here’s one way to do it:
#
#   my $longest = 0;
#   foreach my $key ( keys %ENV ) {
#        my $key_length = length( $key );
#        $longest = $key_length if $key_length > $longest;
#    }
#    foreach my $key ( sort keys %ENV ) {
#        printf "%-${longest}s  %s\n", $key, $ENV{$key};
#    }
#
# In the first foreach  loop, we go through all of the keys and use length  to get
#     their lengths. If the length we just measured is greater than the one we stored in
#         $longest, we put the longer value in $longest.
#         Once we’ve gone through all of the keys, we use printf to print the keys and val‐
# ues in two columns. We use the same trick we used in Exercise 3 from Chapter 5
# by interpolating $longest into the template string.