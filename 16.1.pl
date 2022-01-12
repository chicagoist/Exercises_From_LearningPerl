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



# File 16.1.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Напишите программу, которая переходит в некоторый жестко заданный каталог (например, системный корневой каталог) и
# выполняет команду ls –l для получения списка файлов в длинном формате. (Если вы не работаете в UNIX,
# используйте команду своей системы для получения расширенной информации о содержимом каталога.)

sub ls_l {
    print "Enter your disare directory : ";
    chomp(my $dir = <STDIN>);
    if(! defined $dir) {
        # $dir = "/home/$ENV{USER}";
        $dir = "~/";
    }
    exec "ls -l $dir";
}

&ls_l;


=begin text

 $ perl 16.1.pl

=end text

=cut


# Верный ответ из книги:

#