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
use diagnostics;


use strict;
use warnings FATAL => 'all';
use utf8;
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use DDP;
use Data::Dumper;


# File 10.2.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Измените программу из  предыдущего упражнения так, чтобы во время работы
# она выводила отладочную информацию (например, загаданное число).
# Внесите изменения так, чтобы режим расширенного вывода можно было отключить,
# но при этом не выдавались предупреждения. Если вы работаете в Perl 5.10,
# используйте оператор //. В более ранних версиях используйте тернарный оператор.

sub guess_int {
    my $secret_int = int( 1 + rand(100));
    $secret_int ? print "\$secret_int = $secret_int\n" : die "Exit without guess number program! \n";
    my $answer_int;

    while(<STDIN>) {
        chomp;
        $answer_int = $_ // undef;
        if  ($_ eq 'quit' || $_ eq 'exit' || $_ eq "")  {
            die "Exit program! Real answer was $secret_int\n";
        }elsif ($answer_int > $secret_int) {
            print "Too high. Try again\n";
        }elsif ($answer_int < $secret_int) {
            print "Too low. Try again\n";
        }elsif ($answer_int == $secret_int) {
            print "MATCH !!! \n";
            last;
        }
    }

}

guess_int();
# Верный ответ из книги:
# This program is a slight modification to the previous answer.
# We want to print the secret number while we are developing the program,
# so we print  the secret number if the variable $Debug has a true value.
# The value of $Debug is either the value that we already set as an environment
# variable, or 1  by default. By using the // operator, we won’t set it to 1
# unless the $ENV{DEBUG} is undefined:
# use v5.10;
# my $Debug = $ENV{DEBUG} // 1;
# my $secret = int(1 + rand 100);
# print "Don't tell anyone, but the secret number is $secret.\n" if $Debug;
# To do this without features introduced in v5.10, we just have to do a little more work:
# my $Debug = defined $ENV{DEBUG} ? $ENV{DEBUG} : 1;