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
# use diagnostics;


use strict;
use warnings FATAL => 'all';
use utf8;
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use DDP;
use Data::Dumper;
# use Time::Moment;


# File 11.2.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Write a program using Time::Moment to compute the interval between now and a date
# that you enter as the year and month on the command line:
#
#Напишите программу, используя Time :: Moment, для вычисления интервала между текущим моментом и датой,
# которую вы вводите как год и месяц в командной строке:
#
# $ perl duration.pl 1960 9
# 60 years, 2 months


sub modules_time_moment {
    chomp(@ARGV);
    my ($year, $month ) = @ARGV;

    my $string = '1960-09-01';
    my $today;
    my $delta;
    my @result;

    use Time::Moment;

    $today = Time::Moment->now;

    $delta = Time::Moment->new(year => $year,month => $month);
    $result[0] = $delta->delta_years( $today );
    $result[1] = $delta->delta_months( $today );
    $result[1] %= 12;

    printf("%s years %s months \n", @result);

}

    modules_time_moment();


# Я два часа потратил на установку этого модуля. Так и не понял, что за ошибка, но Time инсталлировался,
# а Moment нет. Пришлось скачать исходник инсталлировать вручную через perl MakeFile.PL
# Сложное задание.


# Верный ответ из книги:

# Once you install Time::Moment from CPAN, you just have to create two dates and subtract them from each other.
# Remember to get the date order correct:

# use Time::Moment;
# my $now = Time::Moment->now;
# my $then = Time::Moment->new(year => $ARGV[0], month => $ARGV[1],);
# my $years = $then->delta_years($now);
# my $months = $then->delta_months($now) % 12;
# printf "%d years and %d months\n", $years, $months;