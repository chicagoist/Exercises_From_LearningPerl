#!/usr/bin/perl -w

use 5.10.0;
use strict;
use open qw(:std :encoding(UTF-8));
use Encode qw(decode_utf8);
BEGIN{@ARGV = map decode_utf8($_, 1), @ARGV;}
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use utf8;
use warnings;
#use POSIX;
#use utf8::all 'GLOBAL'; # пробую этот модуль вместо закомментированных выше строк

# File 7.6.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Упражнение «на повышенную оценку»: напишите программу для вывода входных строк,
# в которых присутствуют оба слова wilma и fred.


sub find_a_string {
    my $index_dots = 0; # индекс для подсчёта строк с именем fred
    my $index_all = 0;  # индекс подсчёта общих строк
    #open(my $fh, '<', "C:/Users/vdundukov/AppData/Local/Packages/TheDebianProject.DebianGNULinux_76v4gfsz19hv4/LocalState/rootfs/home/legioner/Perl_Projects/own_Exercises_From_Learning_Perl/examples/sample_files/text_files/sample_text") or die "Can't open file: $!";
    #while (@_ = <$fh>) {

    chomp(@_);
    foreach (@_) # запускаем цикл по массиву
    {
        if ($_ =~ /wilma(.)+fred|fred(.)+wilma/g) {
            print "$_\n";
            $index_dots++
        }


   # }

}
    # блок разделения между тестами. просто для наглядности
    print "\n";
    foreach (0 .. 40) {
        printf("%s", "##");
    }
    print "\n\n";
    # блок разделения между тестами. просто для наглядности

    foreach (@_) {
        if (/(.)*/) # проходим все строки подряд без ограничений
        {
            #print "$_\n"; # печатаем текст
            $index_all++; # добавляем в счетчик
        }
    }

    say "\$index_dots = $index_dots"; # сравниваем разницу индексов
    say "\$index_all = $index_all";

}


find_a_string(<>);
# $ perl 7.6.pl examples/sample_files/text_files/sample_text


# Верный ответ из книги:

#