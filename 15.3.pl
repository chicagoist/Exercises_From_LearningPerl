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

 <...>
 Файл 'chapter15_examples.pl' доступен для чтения, записи или исполнения.
 OR file [_Deparsed_XSubs.pm] not exist OR you have no permission for the action

=end text

=cut


# Верный ответ из книги:

# Одно из возможных решений:
# for( @ARGV ){
#    say "Processing $_";
#    when( ! -e ) { say "\tFile does not exist!" }
#    when( -r _ ) { say "\tReadable!"; continue }
#    when( -w _ ) { say "\tWritable!"; continue }
#    when( -x _ ) { say "\tExecutable!"; continue }
# }

# Решение обходится без given, так как условия when  можно разместить
# прямо в блоке for. Сначала мы проверяем, что файл существует
# (а вернее, что он не существует). При выполнении первого блока
# when программа сообщает, что файл не существует, а неявно включаемая
# команда break  предотвратит выполнение всех остальных условий.
# Во втором блоке when мы проверяем,что файл доступен для чтения, при помощи –r.
# Также в нем используется специальный виртуальный дескриптор  _, содержащий
# кэшированную информаQ цию от последнего вызова stat  (функции, используемой
# проверками для получения информации). Без дескриптора _  тоже можно обойтись,
# но программа станет чуть менее эффективной. Блок when завершается командой
# continue, поэтому следующее условие when тоже будет проверено.
