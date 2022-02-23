#!/usr/bin/perl -w

use 5.10.0;
use strict;
use open qw(:std :encoding(UTF-8));
use Encode qw(decode_utf8);
BEGIN{@ARGV = map decode_utf8($_, 1), @ARGV;}
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use utf8;
use warnings;
use POSIX;
use utf8::all 'GLOBAL'; # пробую этот модуль вместо закомментированных выше строк

# File 7.6.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Упражнение «на повышенную оценку»: напишите программу для вывода входных строк,
# в которых присутствуют оба слова wilma и fred.


sub find_a_string {
    my $index_words = 0; # индекс для подсчёта строк из задания
    my $index_all = 0;  # индекс подсчёта общих строк


    #open(my $fh, '<', "examples/sample_files/text_files/sample_text") or die "Can't open file: $!";
    #while (@_ = <$fh>) { # для автоматического дебага файла
    chomp(@_);
    foreach (@_) # запускаем цикл по массиву
    {
        if ($_ =~ /wilma(.)+fred|fred(.)+wilma/g) {
            print "$_\n";
            $index_words++
        }
        # } # от дебага while() выше
        #
    }


    # блок разделения между тестами. просто для наглядности
    print "\n";
    foreach (0 .. 40) {
        printf("%s", "##");
    }
    print "\n\n";
    # блок разделения между тестами. просто для наглядности


    foreach (@_) {
        if (/(.)*/) # проходим все строки подряд без ограничений
        {
            #print "$_\n"; # печатаем текст
            $index_all++; # добавляем в счетчик
        }
    }

    say "\$index_words = $index_words"; # сравниваем разницу индексов
    say "\$index_all = $index_all";

}


find_a_string(<>);
# $ perl 7.6.pl examples/sample_files/text_files/sample_text


# Верный ответ из книги:

#Here’s one way to do it:
# while (<>) {
#     if (/wilma/) {
#         if (/fred/) {
#             print;
#         }
#     }
# }
#
# This tests /fred/  only after we find /wilma/  matches,
# but fred  could appear before or after wilma in the line;
# each test is independent of the other. If you wanted to
# avoid the extra nested if test, you might have written something like this:
#
# while (<>) {
#     if (/wilma.*fred|fred.*wilma/) {
#         print;
#     }
# }
#
# This works because you’ll either have wilma before fred or fred before wilma.
# If we had written just /wilma.*fred/, that wouldn’t have matched a line like fred
# and wilma flintstone, even though that line mentions both of them.
# Folks who know about the logical-and operator, which we showed in Chapter 10,
# could do both tests /fred/ and /wilma/ in the same if conditional.
# That’s more efficient, more scalable, and an all-around better way than
# the ones given here. But we haven’t seen logical-and yet:
#
# while (<>) {
#     if (/wilma/ && /fred/) {
#         print;
#     }
# }
#
# The low-precedence short-circuit version works too:
#
# while (<>) {
#     if (/wilma/ and /fred/) {
#         print;
#     }
# }

# We made this an extra-credit exercise because many folks have a mental block here.
# We showed you an “or” operation (with the vertical bar, |), but we never
# showed you an “and” operation. That’s because there isn’t one in regular expressions.
# Mastering Perl  revisits this example by using a regular expression look‐ ahead,
# something even a bit too advanced for Intermediate Perl.
