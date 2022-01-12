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
    my $dir;

        if (defined $ARGV[0]) {
            $_ = $ARGV[0];
            /^\/.*$/;
            chomp($dir = $ARGV[0]);
        }
        elsif (!defined $ARGV[0]) {
            print "Enter your disared directory : ";
            chomp($dir = <STDIN>);
        }

    exec "ls -l $dir" or
    die "Something going wrong $!";
}
&ls_l;


=begin text

 $ perl 16.1.pl

=end text

=cut


# Верный ответ из книги:

# Here’s one way to do it:

#  chdir '/' or die "Can't chdir to root directory: $!";
#  exec 'ls', '-l' or die "Can't exec ls: $!";

# The first line changes the current working directory to the root directory,
# as our particular hardcoded directory. The second line uses the multiple-argument
# exec function to send the result to standard output. We could have used the
# single-argument form just as well, but it doesn’t hurt to do it this way.