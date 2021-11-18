#!/usr/bin/perl -w

# File 5.2.pl
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

# Напишите программу, которая предлагает пользователю ввести
# список строковых значений в отдельных строках и выводит каждое
# значение выровненным по правому краю в столбце шириной
# 20 символов. Чтобы быть уверенным в том, что вывод находится
# в правильных столбцах, также выведите «линейку» из цифр (проQ
# сто для упрощения отладки). Проследите за тем, чтобы по ошибке
# не использовался столбец из 19 символов! Например, при вводе текQ
# ста hello,good-bye результат должен выглядеть примерно так:
# 123456789012345678901234567890123456789012345678901234567890
#                hello
#             good-bye


sub printf_stdout {

    print "Введите несколько новых строк, затем нажмите Ctrl-D:\n";

    chomp(my @lines20 = <STDIN>); # создаём массив и удаляем символы перевода на новую строку
    my $i = 2;                    # индекс для вывода чисел от 0 до 9 ТОЛЬКО два раза, чтобы получить 20 символов.
    my $y = 0;                    # индекс для проверки - 20 ли символов вывели в цикле

    while ($i != 0) { # пока $i не ноль, то ...
        foreach (0 .. 9) {
            print $_; # ... печатаем числа от 0 до 9
            $y++;     # считаем, сколько раз отработал цикл
        }
        $i--; # $i не ноль, цикл повторяем.
    }

    print "\n"; # новая строка

    foreach (@lines20) { # наши строки в цикле

        printf "%20s\n", $_; # %20s поле чисел 20 и в этом поле наша каждая строка по правому краю.
    }
    print "\$y = $y\n"; # для самоконтроля. Должно быть 20
}


printf_stdout();


# Верный ответ из книги:

# 2. Here’s one way to do it:
#
#   print "Enter some lines, then press Ctrl-D:\n";  # or Ctrl-Z
#   chomp(my @lines = <STDIN>);
#   print "1234567890" x 7, "12345\n";  # ruler line to column 75
#   foreach (@lines) {
#        printf "%20s\n", $_;
#   }
#
# Here we start by reading in and chomping all of the lines of text. Then we print
# the ruler line. Since that’s a debugging aid, we’d generally comment out that line
# when the program is done. We could have typed "1234567890" again and again,
# or even used copy-and-paste to make a ruler line as long as we needed, but we
# chose to do it this way because it’s kind of cool.
# Now the foreach  loop iterates over the list of lines, printing each one with the
# %20s conversion. If you chose to do so, you could have created a format to print
# the list all at once, without the loop:
#
#   my $format = "%20s\n" x @lines;
#   printf $format, @lines;
#
# It’s a common mistake to get 19-character columns. That happens when you say
# to yourself, “Hey, why do we chomp the input if we’re only going to add the new‐
# lines back on later?” So you leave out the chomp  and use a format of "%20s"
# (without a newline). And now, mysteriously, the output is off by one space. So,
# what went wrong?
# The problem happens when Perl tries to count the spaces needed to make the
# right number of columns. If the user enters hello  and a newline, Perl sees six
# characters, not five, since newline is a character. So it prints 14 spaces and a six-
# character string, sure that it gives the 20 characters you asked for in "%20s".
# Oops.
#
# Of course, Perl isn’t looking at the contents of the string to determine the width;
# it merely checks the raw number of characters. A newline (or another special
# character, such as a tab or a null character) will throw things off.