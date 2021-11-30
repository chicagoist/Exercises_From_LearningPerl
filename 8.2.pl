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

# File 8.2.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# This next line of code is used when you get to Chapter 9.
# my $what = 'fred|barney';

# Создайте в тестовой программе шаблон, совпадающий с любым словом (в смысле \w),
# завершающимся буквой a.
# Будет ли он совпадать с wilma, но не с barney?
# Совпадет ли он в строке Mrs. Wilma Flintstone?
# А как насчет строки wilna&fred?
# Опробуйте его на текстовом файле из упражнений предыдущей главы 8.1.pl (и добавьте тестовые строки,
# если они не были добавлены ранее).

while (<>) {
    chomp;
    # If you want to try matching strings which may contain
    # newlines, here's the trick to use: Uncomment this next
    # line, then use a pound sign ("#") wherever you mean to
    # have a newline within your data string.
    # s/#/\n/g;

    if (/\w+a/) {
        print "Matched: |$`<$&>$'|\n";
    } else {
        print "No match.\n";
    }
}
# $ perl -T 8.2.pl
# wilma interrupted him. fred, give me the phone. i'll take care
#         Matched: | <wilma> interrupted him. fred, give me the phone. i'll take care|
# Совпадет ли он в строке Mrs. Wilma Flintstone?
#         Matched: |Совпадет ли он в строке Mrs. <Wilma> Flintstone?|
# А как насчет строки wilna&fred?
#         Matched: |А как насчет строки <wilna>&fred?|
# Будет ли он совпадать с wilma, но не с barney?
#         Matched: | Будет ли он совпадать с <wilma>, но не с barney?|



# Верный ответ из книги:

# Here’s one way to do it: /a\b/
# (Of course, that’s a pattern for use inside  the pattern test program!)
# If your pat‐ tern mistakenly matches barney, you probably needed the word-boundary anchor.