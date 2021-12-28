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
use Bundle::Camelcade;


# СТРОКИ И СОРТИРОВКА


{
    # Поиск подстроки по индексу

    # функция index поможет вам в поисках. Вот как это делается:
    #    $where = index($big, $small);
    # Perl находит первое вхождение подстроки и возвращает целочисленный индекс первого символа.
    # Нумерация индексов начинается с нуля – если подстрока находится в самом начале строки,
    # функция index  возвращает 0.
    # Если подстрока смещена на один символ, функция возвращает 1,
    # и т. д. Если найти подстроку не удалось, функция сообщает об этом, возвращая –1.
    # В следующем примере $where возвращает 6:
    my $stuff = "Howdy world!";
    my $where = index($stuff, "wor");
    print "\$where = $where\n";

    # Функция index  всегда возвращает позицию первого вхождения подстроки.
    # Однако ей можно приказать начать поиск не от начала строки, а с более поздней позиции –
    # для этого функции передается необязательный третий параметр:
    print(my $where1 = index($stuff, "w")); # $where1 присваивается 2
    say "";
    print my $where2 = index($stuff, "w", $where1 + 1); # $where2 присваивается 6
    say "";
    print my $where3 = index($stuff, "w", $where2 + 1); # $where3 присваивается -1# (подстрока не найдена)
    say "";


    # В некоторых ситуациях требуется найти не первое, а последнее вхождение подстроки.
    # Эта задача решается функцией rindex.
    # В следующем примере  функция ищет последнее вхождение  /,
    # которое обнаруживается в позиции 4:
    print my $last_slash = rindex("/etc/passwd", "/"); # Значение равно 4
    say "";

    # Функция rindex  также имеет необязательный третий параметр,
    # но вэтом случаеон определяетмаксимальное допустимое  возвращаемое
    # значение:
    my $fred = "Yabba dabba doo!";
    my $where11 = rindex($fred, "abba");               # $where11 gets 7
    my $where22 = rindex($fred, "abba", $where11 - 1); # $where22 присваивается 1
    my $where33 = rindex($fred, "abba", $where2 - 1);  # $where3 присваивается -1

}

{
    # ОПЕРАЦИИ С ПОДСТРОКАМИ И ФУНКЦИЯ substr

    # Функция substr работает с подмножеством символов большей строки.
    # Синтаксис вызова выглядит так:

    # $part = substr($string, $initial_position, $length);

    # Функция получает три аргумента: строку, отсчитываемую от нуля начальную
    # позицию (по аналогии с возвращаемым значением index) и длину подстроки.
    # Возвращаемое значение представляет собой заданную подстроку:
    my $mineral = substr("Fred J. Flintstone", 8, 5); # "Flint"
    my $rock = substr "Fred J. Flintstone", 13, 1000; # "stone"

    # чтобы подстрока завершалась в конце основной строки (независимо от ее фактической длины),
    # опустите при вызове третий параметр (длину):
    my $pebble = substr "Fred J. Flintstone", 13; # "stone"

    # В следующем примере позиQ ция –3 соответствует трем символам от конца строки,
    # то есть букве i:
    my $out = substr("some very long string", -3, 2); # $out присваивается "in"
    # Как и следовало ожидать, index и substr удобно использовать совместно.
    # В этом примере из строки извлекается подстрока, начинающаяся с позиции буквы l:
    my $long = "some very very long string";
    my $right = substr($long, index($long, "l"));

    # А  теперь самое  интересное: если строка  хранится в переменной, выбранную часть строки
    # можно изменить:
    my $string = "Hello, world!";
    substr($string, 0, 5) = "Goodbye"; # $string содержит "Goodbye, world!"

    # оператор привязки (=~) позволяет ограничить операцию частью строки.
    # В следующем примере подстрока fred  заменяется подстрокой barney в пределах 20 последних символов:
    substr($string, -20) =~ s/fred/barney/g;

    # также можете использовать substr более традиционным способом – с четырьмя аргументами,
    # в которых четвертый аргумент задает подстроку замены:
    my $previous_value = substr($string, 0, 5, "Goodbye");
    say "\$previous_value = $previous_value";
}

{ # ФОРМАТИРОВАНИЕ ДАННЫХ ФУНКЦИЕЙ sprintf




}