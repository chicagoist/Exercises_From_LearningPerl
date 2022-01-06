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


# File 15.5.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Измените программу из предыдущего упражнения 15.4.pl так, чтобы она дополнительно
# сообщала, является ли число четным или нечетQ ным, является ли оно простым
# (если для него не найдены другие делители, кроме 1 и самого числа), делится ли оно
# на ваше любимое число. В этой программе также должны использоваться только умные
# сравнения.



sub divisors {
    my $number = shift;
    my @divisors = ();
    my $divisor;
    use experimental 'switch'; # require for given

    if ($number ~~ /^-?\d+$/) { # Если аргумент командной строки  не является числом,
        # программа выдает сообщение об ошибке и не пытается вычислять делители.
        foreach $divisor (2 .. $number / 2) {
            push @divisors, $divisor unless $number % $divisor;
        }
    }else {
        use utf8::all 'GLOBAL';
        die "аргумент командной строки  не является числом";
    }
       return @divisors
           if (@divisors != 0);
}




sub divisors_of_number {
    chomp @ARGV;
    my @divisors_of_argv = divisors($ARGV[0]);
    use experimental 'switch'; # require for given

    for(@divisors_of_argv){
        given ($_) {
         when($_ == $ARGV[0] || $ARGV[0] == 1) {say "кроме $ARGV[0]"; exit}
         when($_ == 0 ) {say "число является простым (т. е. не имеет таких делителей)"; exit}
         when($_ != 0 ) {print "Divisors of $ARGV[0] : " , join(", ", @divisors_of_argv), "\n"; exit}
        }
    }
}

divisors_of_number();


=begin text

 $ perl 15.5.pl 99


=end text

=cut


# Верный ответ из книги:

#