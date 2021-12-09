#!/usr/bin/perl

#use CGI;
#use POSIX;
#use utf8;
use 5.10.0;
use strict;
use open qw(:std :encoding(UTF-8));
use Encode qw(decode_utf8);
BEGIN{@ARGV = map decode_utf8($_, 1), @ARGV;}
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use warnings;
use utf8::all 'GLOBAL'; # пробую этот модуль вместо закомментированных выше строк
use Encode::Locale;
use diagnostics;


# File 9.2.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Напишите программу, которая создает измененную копию текстового файла.
# В копии каждое вхождение строки Fred (с любым регистром символов) должно
# заменяться строкой Larry  (таким обраQ зом, строка Manfred Mann должна превратиться
# в ManLarry Mann). Имя входного файла должно задаваться в командной строке (не запрашивайте
# его у пользователя!), а имя выходного файла образуется из того же имени и расширения .out.



# Не так изящно, как в книге, но так непонятно ставить ТЗ - это жесть.
#


# Верный ответ из книги:
#