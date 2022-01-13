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



# File 16.3.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Напишите программу, которая разбирает результат команды date для определения
# текущего дня недели. Для рабочих дней программа выводит сообщение get to work,
# для выходных – сообщение go play. Вывод команды date  начинается с Mon  для понедельника
# (Monday). Если в вашей системе команда date  отсутствует, напишите фиктивную программу,
# которая просто выдает строку в формате date.

sub date_out {
    open my $my_date, '-|', "date";

    foreach (<$my_date>) {
        chomp;
        say ">$_<";

        if ( /^Sun\s+\.*/ or /^Sat\s+\.*/ ) {
            print "go play\n";
        }
        else {
            print "get to work\n";
        }
    }
    close($my_date);
}
&date_out;


=begin text

 $ perl 16.3.pl
 Thu Jan 13 01:52:53 PM EET 2022
 get to work

=end text

=cut


# Верный ответ из книги:

# Here’s one way to do it:

# if (`date` =~ /\AS/) {
# print "go play!\n";
# } else {
# print "get to work!\n";
# }

# Well, since both Saturday and Sunday start with an S,
# and the day of the week is the first part of the output
# of the date command, this is pretty simple. Just check
# the output of the date command to see if it starts with S.
# There are many harder ways to do this program, and we’ve
# seen most of them in our classes. If we had to use this in
# a real-world program, though, we’d probably use the pat‐tern
# /\A(Sat|Sun)/. It’s a tiny bit less efficient, but that hardly
# matters; besides, it’s so much easier for the maintenance
# programmer to understand.