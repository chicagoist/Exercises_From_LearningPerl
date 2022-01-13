#!/usr/bin/perl -w

use 5.10.0;
# use CGI;
# use Encode qw(decode_utf8);
# use Encode qw(decode encode);
# BEGIN{@ARGV=map Encode::decode($_, 1),@ARGV;}
# BEGIN{@ARGV = map decode_utf8($_, 1), @ARGV;}
# use open qw(:std :encoding(UTF-8));
# use Encode::Locale;
# use Encode;
# use Time::Moment;
# use diagnostics;


use strict;
use warnings FATAL => 'all';
use utf8;
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use utf8::all 'GLOBAL';
use DDP;
use Data::Dumper;
use Bundle::Camelcade;



# File 16.3.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Напишите программу, которая разбирает результат команды date для определения
# текущего дня недели. Для рабочих дней проQ грамма выводит сообщение get to work,
# для выходных – сообщение go play. Вывод команды date  начинается с Mon  для понедельника
# (Monday1 ). Если в вашей системе команда date  отсутствует, напишите фиктивную программу,
# которая просто выдает строку в формате date.

sub date_out {

}
&date_out;


=begin text

 $ perl 16.3.pl

=end text

=cut


# Верный ответ из книги:

#