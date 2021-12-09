#!/usr/bin/perl

#use CGI;
#use POSIX;
#use utf8;
use 5.10.0;
use strict;
use open qw(:std :encoding(UTF-8));
use Encode qw(decode_utf8);
BEGIN{@ARGV = map decode_utf8($_, 1), @ARGV;}
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use warnings;
use utf8::all 'GLOBAL'; # пробую этот модуль вместо закомментированных выше строк
use Encode::Locale;
use diagnostics;


# File 9.4.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Упражнение «на повышенную оценку»: напишите программу,
# которая включает в любую программу из упражнений строку с
# информацией об авторских правах следующего вида:
# ## Copyright (C) 20XX by Yours Truly
# Строка должна размещаться сразу же за строкой с «решеткой».
# Файл следует изменять «на месте» с сохранением резервной копии.
# Считайте, что при запуске программы имена изменяемых файлов передаются в командной строке.

chomp(@_);
$^I = ".out";
my @year = split /.*20/, gmtime();

while (<>) {
    # s/^\s*$//g; # remove empty lines
    s|^#\s?\n|"\r## Copyright (C) 20$year[1] by Yours Valerii"|e;
    print;

}

# I Misunderstand task of the exercise

# Верный ответ из книги:
#Here’s one way to do it:
# $^I = ".bak";          # make backups
# while (<>) {
# if (/\A#!/) {         # is it the shebang line?
# $_ .= "## Copyright (C) 20XX by Yours Truly\n";
# }
# print;
# }
# Invoke this program with the filenames you want to update.
# For example, if you’ve been naming your exercises ex01-1, ex01-2,
# and so on, so that they all begin with ex..., you would use: ./fix_my_copyright ex*