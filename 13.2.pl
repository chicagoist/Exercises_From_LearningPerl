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


# File 13.2.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


=begin text

Эти программы потенциально опасны!
Будьте осторожны и тестируйте их в пустых каталогах,
чтобы предотвратить случайное удаление полезных данных.

=end text

=cut

#  Измените программу так, чтобы она выводила информацию обо всех файлах
# (в том числе и тех, имена которых начинаются с точки).

sub change_dir {
    print "Please, select your directory : ";
    chomp(my $new_dir = <STDIN>);
    my $dh;

    if ($new_dir =~ /^\s*$/) { # if value only with spaces
        $new_dir = "/home/$ENV{USER}"; # directory : /home/{and user}, who launch this script
        opendir($dh, $new_dir) || die "Can't open $new_dir: $!"; # open our directory
         while (readdir $dh) { # read directory with alphabetical
            print <$new_dir/.* $new_dir/*> . "\n"; # print ALL names of file's and directory's with AND without DOTs.
        }

    }
    elsif ($new_dir =~ s/^(\/.*\/*)\/+$/$1/) { # if name of directory contains last character "/"
        $new_dir =~ s/^(\/.*\/*)\/+$/$1/; # remove last "/"
        opendir($dh, $new_dir) || die "Can't open $new_dir: $!"; # open our directory
        while (readdir $dh) { # read directory with alphabetical
            print <$new_dir/.* $new_dir/*> . "\n"; # print ALL names of file's and directory's with AND without DOTs.
        }
    }
    elsif ($new_dir =~ /^(\/.*)$/) {  # if normal directory's name without last "/" and no spaces
        opendir($dh, $new_dir) || die "Can't open $new_dir: $!";
        while (readdir $dh) { # read directory with alphabetical
            print <$new_dir/.* $new_dir/*> . "\n"; # print ALL names of file's and directory's with AND without DOTs.
        }
    }
    close $dh; # close any of opened directories
}

change_dir();


# Верный ответ из книги:

# Here’s one way to do it:
# print "Which directory? (Default is your home directory) ";
# chomp(my $dir = <STDIN>);
# if ($dir =~ /\A\s*\z/) { # A blank line
#     chdir or die "Can't chdir to your home directory: $!";
# }
# else {
#     chdir $dir or die "Can't chdir to '$dir': $!";
# }
# my @files = <.* *>;     ## now includes .*
# foreach (sort @files) { ## now sorts
#     print "$_\n";
# }
# Two differences from previous one. First, the glob now includes “dot star,”
# which matches all the names that do  begin with a dot. And second, we now must
# sort the resulting list because some of the names that begin with a dot must be
# inter‐leaved appropriately, either before or after the list of things, without
# a beginning dot.