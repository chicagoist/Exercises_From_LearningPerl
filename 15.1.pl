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
# Использовать умные сравнения необязательно:

# Напишите программу, которая многократно предлагает пользователю
# угадать число от 1 до 100, пока тот не введет правильное число.
# Число должно выбираться  случайным образом по волшебной формуле
# int(1+rand 100). Если пользователь вводит неправильное число,
# программа должна выдавать подсказки типа «Too high» или «Too low».
# Если пользователь вводит слово quit  или exit, или же пустую строку,
# программа завершает работу. Конечно, если пользователь угадал правильно,
# программа тоже должна завершаться!


sub guess_int {
    use experimental 'switch'; # require for given-when

    my $secret_int = int(1 + rand(100)); # random integer from 0 to 100
    # print "\$secret_int = $secret_int\n"; # print random number for debugging

    unless  (! defined $secret_int) { # while $secret_int is defined
        print "Guess int from 0 to 100 : "; # type your guess number
        LABEL: chomp(my $answer_int = <STDIN>); # goto from loop given-when

        # say $answer_int; # for debugging
        given ($answer_int) {
            when (!/^-?\d+$/) {print "[$_] - not a number!. Try again one more time: "; goto LABEL } # if not number
            when ($answer_int > $secret_int) {print "Too high! Try again : "; goto LABEL}
            when ($answer_int < $secret_int) {print "Too low! Try again : "; goto LABEL}
            when ($answer_int ~~ $secret_int) {say "MATCH!!! GREAT!! WINNER! >$_< "; exit} # smart check ( == work too)

            default {say 'NOT MATCH... try again next time.'; exit} # if something is wrong
        }
    }
}

guess_int();

=begin text

 $ perl 15.1.pl

 Guess int from 0 to 100 : 5r
 [5r] - not a number!. Try again one more time: r4
 [r4] - not a number!. Try again one more time: 56
 Too high! Try again : 15
 Too low! Try again : 45
 Too low! Try again : 50
 Too high! Try again : 47
 Too high! Try again : 46
 MATCH!!! GREAT!! WINNER! >46<



=end text

=cut


# Верный ответ из книги:

# Одна из возможных переработанных версий программы с
# угадыванием чисел из главы 10. Умное сравнение использовать
# необязательно, но мы применяем конструкцию given:

# my $Verbose = $ENV{VERBOSE} // 1;
# my $secret = int(1 + rand 100);
# print "Don't tell anyone, but the secret number is $secret.\n"
#     if $Verbose;
#
# LOOP: {
#         print "Please enter a guess from 1 to 100: ";
#         chomp(my $guess = <STDIN>);
#         my $found_it = 0;
#
#         given( $guess ) {
#             when( ! /^\d+$/ )    { say "Not a number!" }
#             when( $_ > $secret ) { say "Too high!"   }
#             when( $_ < $secret ) { say "Too low!"    }
#
#             default              { say "Just right!"; $found_it++ }
#         }
#         last LOOP if $found_it;
#         redo LOOP;
# }

# В первой секции when мы проверяем, что введено именно число. Если
# введенная строка содержит символы, отличные от цифр, или просто
# является пустой строкой, это позволяет предотвратить выдачу
# предупреждений при последующих числовых сравнениях. Обратите
# внимание: мы не включили last в блок default. Вообще-то сначала
# мы именно так и сделали, однако это приводит к выдаче предупреждения
# в Perl 5.10.0 (возможно, это предупреждение исчезнет в будущих версиях).
