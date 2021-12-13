#!/usr/bin/perl -w

use 5.10.0;
#use CGI;
#use POSIX;
# use Encode qw(decode_utf8);
# use Encode qw(decode encode);
# BEGIN{@ARGV=map Encode::decode($_,1),@ARGV;}
# BEGIN{@ARGV = map decode_utf8($_, 1), @ARGV;}
# use open qw(:std :encoding(UTF-8));
# use utf8::all 'GLOBAL';
# use Encode::Locale;
# use Encode;
#use diagnostics;


use strict;
use warnings FATAL => 'all';
use utf8;
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use DDP;
use Data::Dumper;


# File 10.1.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Напишите программу, которая многократно предлагает пользователю
# угадать число от 1 до 100, пока тот не введет правильное число.
# Число должно выбираться  случайным образом по волшебной формуле
# int(1+rand 100). 2Если пользователь вводит неправильное число,
# программа должна выдавать подсказки типа «Too high» или «Too low».
# Если пользователь вводит слово quit  или exit, или же пустую строку,
# программа завершает работу. Конечно, если пользователь угадал правильно,
# программа тоже должна завершаться!



# Верный ответ из книги:
#