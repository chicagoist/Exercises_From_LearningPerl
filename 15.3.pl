#!/usr/bin/perl -w

use 5.10.0;
# use CGI;
# use Encode qw(decode_utf8);
# use Encode qw(decode encode);
# BEGIN{@ARGV=map Encode::decode($_,1),@ARGV;}
# BEGIN{@ARGV = map decode_utf8($_, 1), @ARGV;}
# use open qw(:std :encoding(UTF-8));
# use utf8::all 'GLOBAL';
# use Encode::Locale;
# use Encode;
# use Time::Moment;
# use diagnostics;


use strict;
use warnings FATAL => 'all';
use utf8;
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use DDP;
use Data::Dumper;


# File 15.3.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Используя конструкцию for-when, напишите программу, которая
# перебирает список файлов в командной строке и сообщает, доступен
# ли каждый файл для чтения, записи или исполнения. Использовать
# умные сравнения необязательно.


sub readable_files {
    chomp @ARGV;

    use experimental 'switch'; # require for given
    use POSIX;                 # to get getcwd
    use File::Basename;
    use File::Spec;

    # my $basename;
    # my $source;
    # my $link_dest;
    my $dir;

    ($^O =~ /Win32/) ? ($dir = getcwd) =~ s/\//\\/g : ($dir = getcwd); # Account for / and \ on Win32 and non-Win32 systems
    chdir $dir;                                                        # Без полного пути к источнику, не создавалась soft link

    for (@ARGV) {
        print "Файл '$_' доступен для чтения, записи или исполнения.\n"
            if (-e $_ && -w _ && -r _ && -o _)
                or die "OR file [$_] not exist OR you have no permission for the action $!\n";

    }

}

readable_files();

=begin text

 $ perl 15.3.pl


=end text

=cut


# Верный ответ из книги:

#
