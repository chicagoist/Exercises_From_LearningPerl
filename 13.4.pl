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
# use diagnostics;


use strict;
use warnings FATAL => 'all';
use utf8;
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use DDP;
use Data::Dumper;
# use Time::Moment;


# File 13.4.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


=begin text

Эти программы потенциально опасны!
Будьте осторожны и тестируйте их в пустых каталогах,
чтобы предотвратить случайное удаление полезных данных.

=end text

=cut

# Напишите программу, имитирующую команду rm;
# программа должна удалять файлы, имена которых вводятся в командной строке.
# (Поддерживать различные ключи rm не нужно.)

sub rm_file {
    use POSIX;
    my $dir;

    ($^O =~ /Win32/) ? ($dir = getcwd) =~ s/\//\\/g : ($dir = getcwd); # Account for / and \ on Win32 and non-Win32 systems
    chdir $dir;
    chomp(@ARGV);

    foreach my $file_for_rm (@ARGV) {
        print "'$file_for_rm'  ready to REMOVE the file? [yes/NO]"
            if (-e $file_for_rm && -w _ && -r _ && -o _) or die "OR file not exist or you have no permission to remove $!\n";

        chomp (my $yesORno = <STDIN>)
            if (-e $ARGV[0] && -w _ && -r _ && -o _) or die $!;

        if ($yesORno =~ /[y|yes]/i) {
            unlink $file_for_rm;
            print "This file  '$file_for_rm'  is REMOVED !\n";
            exit;

        }else {
            print "CANCELED\n";
            exit;
        }
    }
}

&rm_file;

# Верный ответ из книги:

#