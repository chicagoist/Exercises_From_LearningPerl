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


# File 10.3.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Измените программу из упражнения 3 в главе 6 ( 6.3.pl ) так,
# чтобы для переменных, которым не задано значение, выводилась строка (undefined value).
# Новые переменные среды можно устанавливать прямо в программе. Убедитесь в том, что программа
# выводит правильную информацию для переменных с ложным значением. Если вы работаете в Perl  5.10,
# используйте оператор //. В более ранних версиях используйте тернарный оператор.
#
# Опечатка в русском издании. В оригинале следующее:
# At the top of the program, we set some environment variables. The keys ZERO and EMPTY have false
# but defined values, and the key UNDEFINED has no value.

my $max_length = 0;
my @names_env;
$ENV{ZERO} = 0;
$ENV{EMPTY} = '';
$ENV{UNDEFINED} = undef;

push @names_env, sort {$a cmp $b} keys %ENV; # заводим все ключи нашего хеша в массив, через функцию sort

foreach my $key (keys %ENV) {# ищем длину самого широкого ключа
    if (length($key) > $max_length) {
        $max_length = length($key); # присваиваем значение переменной.
    }
}

foreach (sort @names_env) {

    print "Different variants // :\n\n";
    printf("%-${max_length}s %s\n", $_ ,$ENV{$_} // 'undefined value'); # вводим массив в столбец, шириной $max_length

    print "Different variants ?: :\n\n";
    # my $tmp_s = $ENV{$_} // 'undefined value';
    $ENV{$_} ? printf("%-${max_length}s %s\n", $_ ,$ENV{$_}) : printf("%-${max_length}s %s\n", $_ ,'undefined value');
}

# Верный ответ из книги:
# Here’s one way to do it, which steals from the answer to Exercise 3 in Chapter 6.
# At the top of the program, we set some environment variables. The keys ZERO and EMPTY
# have false but defined values, and the key UNDEFINED has no value. Later, in the printf
# argument list, we use the //  operator to select the string (undefined value) only
# when $ENV{$key} is not a defined value:
# use v5.10;
# $ENV{ZERO} = 0;
# $ENV{EMPTY} = '';
# $ENV{UNDEFINED} = undef;
#
# my $longest = 0;
# foreach my $key (keys %ENV) {
#     my $key_length = length($key);
#     $longest = $key_length if $key_length > $longest;
# }
#
# foreach my $key (sort keys %ENV) {
#     printf "%-${longest}s  %s\n", $key, $ENV{$key} // "(undefined value)";
# }
#
# By using // here, we don’t disturb false values such as those in the keys ZERO and EMPTY.
# To do this without Perl 5.10, we use the ternary operator instead:
# printf "%-${longest}s  %s\n", $key,defined $ENV{$key} ? $ENV{$key} : "(undefined value)";

