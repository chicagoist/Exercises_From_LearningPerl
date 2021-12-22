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
    print "Please, change to directory : ";

    chomp(my $new_dir = <STDIN>);

   #  say $new_dir;

    chdir $new_dir;
    opendir(my $dh, $new_dir) || die "Can't open $new_dir: $!";
    while (readdir $dh) {
        print "$new_dir/$_\n";
    }

}

change_dir();


# Верный ответ из книги:

#