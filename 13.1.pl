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


# File 13.1.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


=begin text

Эти программы потенциально опасны!
Будьте осторожны и тестируйте их в пустых каталогах,
чтобы предотвратить случайное удаление полезных данных.

=end text

=cut

# Напишите программу, которая запрашивает у пользователя имя каталога и делает его текущим каталогом.
# Если пользователь вводит строку из одних пропусков, по умолчанию программа должна перейти в домашний
# каталог пользователя. После смены каталога выведите  его стандартное содержимое (за исключением
# элементов, имена которых начинаются с точки) в алфавитном порядке.
# (Подсказка: как это проще сделать – с дескриптором каталога или с глобом?)
# Если попытка перехода в другой каталог завершилась неудачей, сообщите об этом пользователю,
# но не пытайтесь выводить содержимое.

sub change_dir {
    print "Please, select your directory : ";
    chomp(my $new_dir = <STDIN>);
    my $dh;

    if ($new_dir =~ /^\s*$/) { # if value only with spaces
        $new_dir = "/home/$ENV{USER}"; # directory : /home/{and user}, who launch this script
        opendir($dh, $new_dir) || die "Can't open $new_dir: $!"; # open our directory
        while (readdir $dh) { # read directory with alphabetical
            print "$new_dir/$_\n" if !/^\.{1}/; # print names of file's and directory's without DOTs.
        }
    }
    elsif ($new_dir =~ /^(\/.*)\/+$/) { # if name of directory contains last character "\"
        $new_dir =~ s/^(\/.*)\/+$/$1/; # remove last "\"
        opendir($dh, $new_dir) || die "Can't open $new_dir: $!"; # open our directory
        while (readdir $dh) {
            print "$new_dir/$_\n" if !/^\.{1}/; # print names of file's and directory's without DOTs and without double slash like "/var/log//log"
        }
    }
    elsif ($new_dir =~ /^(\/.*)$/) {  # if normal directory's name without last "/" and no spaces
        opendir($dh, $new_dir) || die "Can't open $new_dir: $!";
        while (readdir $dh) {
            print "$new_dir/$_\n" if !/^\.{1}/;  # print names of file's and directory's without DOTs
        }
    }

    close $dh; # close any of directories
}

change_dir();


# Верный ответ из книги:

# Here’s one way to do it, with a glob:

# print "Which directory? (Default is your home directory) ";
# chomp(my $dir = <STDIN>);
# if ($dir =~ /\A\s*\z/) {         # A blank line
#    chdir or die "Can't chdir to your home directory: $!";
# } else {
#    chdir $dir or die "Can't chdir to '$dir': $!";
# }
# my @files = <*>;
# foreach (@files) {
#    print "$_\n";
# }

# First, we show a simple prompt, read the desired directory, and chomp  it.
# (Without a chomp, we’d be trying to head for a directory that ends in a newline - legal
# in Unix, and therefore cannot be presumed to simply be extraneous by the chdir function.)
# Then, if the directory name is nonempty, we’ll change to that directory, aborting on a
# failure. If empty, the home directory is selected instead. Finally, a glob  on “star”
# pulls up all the names in the (new) working directory, automatically sorted in alphabetical order,
# and they’re printed one at a time.