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
use Bundle::Camelcade;


# File 17.2.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Write a program to make a report of the access and modification times (in the epoch time)
# of the files in the current directory. Use stat  to get the times, using a list slice
# to extract the elements. Report your results in three columns, like this:
# fred.txt          1294145029        1290880566
# barney.txt        1294197219        1290810036
# betty.txt         1287707076        1274433310

sub access_modifc_time {



    my @stat_data;

    while (<*>) {

        my ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,
            $atime,$mtime,$ctime,$blksize,$blocks)
            = stat($_);


        if(length($_) <= 25) { # для наглядность убрал слишком длинные имена файлов

            #printf("%-30s\t%s\t%s\n", $_, $atime, $mtime);
            printf("%-30s\t%s\t%s\n", $_, (stat $_)[8,9]);

        }

    }

}

&access_modifc_time;



=begin text

 $ perl 17.2.pl
 ...
 16.3.pl                         1642756160      1642075099
 17.1.pl                         1642756160      1642686060
 17.2.pl                         1642758815      1642758813
 2minus.pl                       1642756160      1639993530
 ...

=end text

=cut


# Верный ответ из книги:

#