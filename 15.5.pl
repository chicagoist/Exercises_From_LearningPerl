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
# сообщала, является ли число четным или нечетным, является ли оно простым
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
    use experimental 'switch';
    print "Enter your preferred number for test : ";
   LABEL: chomp (my $preferred_number = <STDIN>);
    if ($preferred_number ~~ $ARGV[0]) {
        print "Not sam number please again : " ;
        goto LABEL;
    }
    my @divisors_of_argv = divisors($ARGV[0]);
    use experimental 'switch'; # require for given

    for(@divisors_of_argv){
        given ($_) {
         when($ARGV[0] % $preferred_number == 0) {say "$ARGV[0] ДЕЛИТСЯ на ваше любимое число $preferred_number"; continue}
         when($ARGV[0] % $preferred_number != 0) {say "$ARGV[0] НЕ ДЕЛИТСЯ на ваше любимое число $preferred_number"; continue}
         when($preferred_number  % 2 == 0) {say "$ARGV[0] EVEN !"; continue}
         when($preferred_number  % 2 != 0) {say "$ARGV[0] ODD !"; continue}

         when($_ == $ARGV[0] || $ARGV[0] == 1) {say "кроме $ARGV[0]"; exit}
         when($_ == 0 ) {say "число является простым (т. е. не имеет таких делителей)"; exit}
         when($_ != 0 ) {print "Divisors of $ARGV[0] : " , join(", ", @divisors_of_argv), "\n"; exit}
        }
    }
}

divisors_of_number();


=begin text

 $ perl 15.5.pl 99
 Enter your preferred number for test : 4
 99 НЕ ДЕЛИТСЯ на ваше любимое число 4
 99 EVEN !
 99 ODD !
 Divisors of 99 : 3, 9, 11, 33

 $ perl 15.5.pl 99
 Enter your preferred number for test : 4
 99 НЕ ДЕЛИТСЯ на ваше любимое число 4
 99 EVEN !
 Divisors of 99 : 3, 9, 11, 33

 $ perl 15.5.pl 97
 Enter your preferred number for test : 3
 97 НЕ ДЕЛИТСЯ на ваше любимое число 3
 97 ODD !
 число является простым (т. е. не имеет таких делителей)

 $ perl 15.5.pl 100
 Enter your preferred number for test : 100
 Not sam number please again : 25
 100 ДЕЛИТСЯ на ваше любимое число 25
 100 ODD !
 Divisors of 100 : 2, 4, 5, 10, 20, 25, 50



=end text

=cut


# Верный ответ из книги:

# Одно из возможных решений, созданное  на базе ответа к предыдущему упражнению:

# say "Checking the number <$ARGV[0]>";
# my $favorite = 42;
# given ($ARGV[0]) {
#     when (!/^\d+$/) {say "Not a number!"}
#     my @divisors = divisors($ARGV[0]);
#     when (@divisors ~~ 2) {
#         # 2 is in @divisors
#         say "$_ is even";
#         continue;
#     }
#     when (!(@divisors ~~ 2)) {
#         # 2 isn't in @divisors
#         say "$_ is odd";
#         continue;
#     }
#     when (@divisors ~~ $favorite) {
#         say "$_ is divisible by my favorite number";
#         continue;
#     }
#     when ($favorite) {
#         # $_ ~~ $favorite
#         say "$_ is my favorite number";
#         continue;
#     }
#     my @empty;
#     when (@divisors ~~ @empty) {say "Number is prime"}
#     default {say "$_ is divisible by @divisors"}
# }
# sub divisors {
#     my $number = shift;
#     my @divisors = ();
#     foreach my $divisor (2 .. ($ARGV[0] / 2 + 1)) {
#         push @divisors, $divisor unless $number % $divisor;
#     }
#     return @divisors;
# }