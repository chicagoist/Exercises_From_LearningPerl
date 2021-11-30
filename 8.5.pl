#!/usr/bin/perl -wT

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
use CGI;

# File 8.5.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# This next line of code is used when you get to Chapter 9.
# my $what = 'fred|barney';

# Упражнение «на повышенную оценку»: измените программу из предыдущего упражнения так,
# чтобы сразу же за словом, завершающимся буквой a, до пяти следующих символов
# (если они есть в строке, конечно)  сохранялись в отдельной переменной. Обновите
# приложение, чтобы оно отображало обе переменные. Например, если во входной строке
# говорится I saw Wilma yesterday, в переменной должны сохраняться символы « yest».
# Для входной строки I, Wilma! в  дополнительной переменной сохраняется всего один символ.
# Будет ли обновленный шаблон совпадать с простой строкой wilma?



while (<>) {
    chomp;
    # If you want to try matching strings which may contain
    # newlines, here's the trick to use: Uncomment this next
    # line, then use a pound sign ("#") wherever you mean to
    # have a newline within your data string.
    # s/#/\n/g;

    if (/(?<word>\b\w*a\b)(?<nwo>.{0,5})/) {
        print "Matched: |$`<$&>$'|\n";
        foreach (keys %+) {
            say $_, " => '$+{$_}'";
        }
    }
    else {
        print "No match.\n";
    }
}

# Консольный вызов скрипта:
# $ echo 'Например, если во входной строке говорится I saw Wilma yesterday, в переменной должны сохраняться символы « yest»' | perl -T 8.5.pl

# Верный ответ из книги:
# Here’s one way to do it:
#
#   m!
#     (\b\w+a\b) # $1: a word ending in a
#     (.{0,5})   # $2: up to five characters following
# !xs            # /x and /s modifiers
#
# (Don’t forget to add code to display $2, now that you have two memory variables.
# If you change the pattern to have just one again, you can simply comment out the extra line.)
# If your pattern doesn’t match just plain wilma anymore, perhaps you require zero or more
# characters instead of one or more. You may have omitted the /s modifier, since there
# shouldn’t be newlines in the data. (Of course, if there are newlines in the data,
# the /s modifier could make for different output.)
#
