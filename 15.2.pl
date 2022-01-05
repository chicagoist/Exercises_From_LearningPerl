#!/usr/bin/perl -w

use 5.10.0;
# use CGI;
# use Encode qw(decode_utf8);
# use Encode qw(decode encode);
# BEGIN{@ARGV=map Encode::decode($_,1),@ARGV;}
# BEGIN{@ARGV = map decode_utf8($_, 1), @ARGV;}
# use open qw(:std :encoding(UTF-8));
# use utf8::all 'GLOBAL';
# use Encode::Locale;
# use Encode;
# use Time::Moment;
# use diagnostics;


use strict;
use warnings FATAL => 'all';
use utf8;
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use DDP;
use Data::Dumper;


# File 15.2.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Напишите программу с given-what, которая получает число во входных данных,
# а затем выводит строку «Fizz», если число делится на 3, «Bin», если оно
# делится на 5, и «Sausage», если оно делится на 7.
# Например, для числа 15 программа должна выводить «Fizz» и «Bin», потому
# что 15 делится как на 3, так и на 5. Для какого числа ваша программа
# выведет «Fizz Bin Sausage»?


sub divisible_int {
    use experimental 'switch'; # require for given-when


}

divisible_int();

=begin text

 $ perl 15.2.pl






=end text

=cut


# Верный ответ из книги:

#
