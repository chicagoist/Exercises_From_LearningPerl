#!/usr/bin/perl -w

# File 5.3.pl
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
use POSIX;

# Измените предыдущую программу так, чтобы пользователь мог
# выбрать ширину столбца. Например, при вводе значений 30, hello, good-bye
# (в отдельных строках) текст должен печататься до
# 30 столбца. (Подсказка: о том, как управлять интерполяцией переменных,
# рассказано в главе 2.) Чтобы задание стало более интересным,
# увеличивайте длину линейки при больших введенных значениях.


sub printf_tables {

    my $y = 0; # индекс для проверки символов вывели в цикле ширины таблицы

    print "Введите вначале число(ширина), затем несколько новых строк, затем нажмите Ctrl-D:\n";
    chomp(my @lines = <STDIN>); # создаём массив и удаляем символы перевода на новую строку
    my $i = shift @lines;       # передаём нашему индексу первый элемент массива
    my $x;                      # переменная куда сохраним первый аргумент. Число.


    if ($i % 10 == 0) { # если чётное число

        $x = $i * 10; # store of @ARGV[0] перед делением на 10
        $i = $i / 10; # индекс для вывода чисел от 0 до 9 ТОЛЬКО два раза, чтобы получить ширину столбца.

    }
    else {
                            # если не чётное, то округляем выше.
        $i = $i / 10;       # индекс для вывода чисел от 0 до 9 ТОЛЬКО два раза, чтобы получить ширину столбца.
        $i = ceil($i + 0.5); # округляет 11 до 20 и тп. POSIX
        $x = $i * 10;       # store of @ARGV[0] нужно умножить на 10 после округления.

    }
    say $i; # debug
    print "\$x = \n$x\n";# тестовая строка


    while ($i != 0) {
        # пока $i не ноль, то ...
        foreach (0 .. 9) {
            print $_; # ... печатаем числа от 0 до 9
            $y++;     # считаем, сколько раз отработал цикл
        }
        $i--; # Если $i не ноль, цикл повторяем.
    }
    print "\n"; # новая строка
    #print "\$x = $x\n";# тестовая строка

    foreach (@lines) { #наши строки в цикле

        printf "%*s\n", $x, $_; # %*s поле чисел $x. и в этом поле наша каждая строка по правому краю.
    }
    # print "\$y = $y\n"; # для самоконтроля. Должно быть первое значение

}


printf_tables();


# Верный ответ из книги:

# Here’s one way to do it:
# print "What column width would you like? ";
# chomp(my $width = <STDIN>);
# print "Enter some lines, then press Ctrl-D:\n";  # or Ctrl-Z
# chomp(my @lines = <STDIN>);
# print "1234567890" x (($width+9)/10), "\n";      # ruler line as needed
# foreach (@lines) {
#     printf "%${width}s\n", $_;
# }
# Instead of interpolating the width into the format string, we could have used this:
# foreach (@lines) {
# printf "%*s\n", $width, $_;
# }
# This is much like the previous one, but we ask for a column width first. We ask
# for that first because we can’t ask for more input after the end-of-file indicator, at
# least on some systems. Of course, in the real world you’ll generally have a better
# end-of-input indicator when getting input from the user, as we’ll see in later exer‐
# cise answers.
# Another change from the previous exercise’s answer is the ruler line. We used
# some math to cook up a ruler line that’s at least as long as we need, as suggested
# as an extra-credit part of the exercise. Proving that our math is correct is an addi‐
# tional challenge. (Hint: consider possible widths of 50 and 51, and remember that
# the right side operand to x is truncated, not rounded.)
# To generate the format this time, we used the expression "%${width}s\n", which
# interpolates $width. The curly braces are required to “insulate” the name from
# the following s; without the curly braces, we’d be interpolating $widths, the
# wrong variable. If you forgot how to use curly braces to do this, though, you
# could have written an expression like '%' . $width . "s\n"  to get the same
# format string.
# The value of $width  brings up another case where chomp  is vital. If you don’t
# chomp  the width, the resulting format string would resemble "%30\ns\n". That’s
# not useful.
# People who have seen printf  before may have thought of another solution.
# Because printf comes to us from C, which doesn’t have string interpolation, we
# can use the same trick that C programmers use. If an asterisk (*) appears in place
# of a numeric field width in a conversion, a value from the list of parameters will
# be used:
#      printf "%*s\n", $width, $_;