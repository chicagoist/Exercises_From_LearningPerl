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


# File 14.3.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Напишите программу, которая ищет в заданной строке все вхождения
# заданной подстроки и выводит их позиции. Например, для входной
# строки "This is a test." и подстроки "is" программа должна вывести
# позиции 2 и 5, а для подстроки "a"  – позицию  8.
# А что выведет программа для подстроки "t"?


sub sub_string {
    print "Enter a string: ";
    chomp(my $string = <STDIN>);
    print "Enter a substring: ";
    chomp(my $sub_string = <STDIN>);
    my $first_target_point;
    my $last_target_point;
    my $index = 0;

    foreach (split " ", $string) {

        $first_target_point = index($_, $sub_string);
        $last_target_point = rindex($_, $sub_string);
        if ($first_target_point != -1 || $last_target_point != -1) {
            $index++;
            say "$_";
        }
    }
    print "NOT MATCH '$sub_string' in '$string'" if $index == 0;
}

sub_string();

=begin text

 $ perl 14.3.1.pl

 OUTPUT:
 $ Enter a string: This is a test.
 $ Enter a substring: T
 $ This

 OUTPUT:
 $ Enter a string: This is a test.
 $ Enter a substring: y
 $ NOT MATCH 'y' in 'This is a test.'

=end text

=cut


# Верный ответ из книги:

#