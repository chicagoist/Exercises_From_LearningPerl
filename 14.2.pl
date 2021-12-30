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



# File 14.2.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/



# Напишите программу, которая выводит данные следующего хеша отсортированными
# по фамилиям (значения хеша) в алфавитном порядке без учета регистра символов.
# Если фамилии совпадают, проведите дополнительную сортировку по именам (ключи хеша) –
# также без учета регистра символов. На первом месте в выходных данных должен
# стоять элемент с ключом Fred, а на последнем – элемент с ключом Betty.
# Все люди с одинаковыми фамилиями должны быть сгруппированы. Не  изменяйте данные;
# они должны выводиться в том же регистре, что и в примере. (Исходный код создания
# подобного хеша содержится в файле sortable_hash, также доступном для загрузки.)

my %last_name = qw{
    fred flintstone Wilma Flintstone Barney Rubble
    betty rubble Bamm-Bamm Rubble PEBBLES FLINTSTONE
};

state @sort_array;
sub sort_hash {

       "\L$last_name{$a}" cmp "\L$last_name{$b}" or "\L$a" cmp "\L$b"; # атрибуты сортировки функции sort
}
@sort_array = sort sort_hash keys %last_name; # заполнение массива state @sort_array отсортированными именами по значениям фамилий
print "@sort_array\n\n";

foreach my $name (sort sort_hash keys %last_name) { # для наглядности:
    print "$name => $last_name{$name}\n"; # вывод значений хеша по имя => фамилия
}

=begin text

 $ perl 14.2.pl

 output:
 fred PEBBLES Wilma Bamm-Bamm Barney betty

 fred => flintstone
 PEBBLES => FLINTSTONE
 Wilma => Flintstone
 Bamm-Bamm => Rubble
 Barney => Rubble
 betty => rubble


=end text

=cut


# Верный ответ из книги:

# Here’s one way to do it:

#    # don't forget to incorporate the hash %last_name,
#    # either from the exercise text or the downloaded file
#    my @keys = sort {"\L$last_name{$a}" cmp "\L$last_name{$b}"  # by last name
#        or"\L$a" cmp "\L$b" # by first name
#    } keys %last_name;
#    foreach (@keys) {
#    print "$last_name{$_}, $_\n";              # Rubble,Bamm-Bamm
#    }
#
# There’s not much to say about this one; we put the keys in order as needed,
# then print them out. We chose to print them in last-name-comma-first-name
# order just for fun; the exercise description left that up to you.