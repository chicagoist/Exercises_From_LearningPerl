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


# File 15.1.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Перепишите программу  из упражнения 1 главы 10 ( 10.1.pl ) так,
# чтобы в ней использовалась конструкция given.
# Как обеспечить обработку нечисловых входных данных?
# Использовать умные сравнения необязательно.


sub guess_int {
    my $secret_int = int(1 + rand(100));

}

=begin text

 $ perl 15.1.pl


=end text

=cut


# Верный ответ из книги:

#
