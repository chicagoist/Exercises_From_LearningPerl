#!/usr/bin/perl -w

use 5.10.0;
# use CGI;
# use POSIX;
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


# File 12.3.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Напишите программу, которая использует сгруппированные операторы проверки
# файлов для перечисления всех файлов, указанных в командной строке,
# принадлежащих вам и доступных для чтения и записи.

state @files_O_R_W;
sub files_group_check {
    chomp(@ARGV);

    foreach (@ARGV) {
        # say $_;
        if (-O -R -W $_) {
            # say $_;
            push @files_O_R_W, $_;
        }
    }
    # p @files_O_R_W;

    foreach (@files_O_R_W) {
        printf("File with -O -R -W : %s\n", $_);
    }

}

files_group_check();


# Верный ответ из книги:

#