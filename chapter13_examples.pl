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


# ОПЕРАЦИИ С КАТАЛОГАМИ
#


{ # ПЕРЕМЕЩЕНИЕ ПО ДЕРЕВУ КАТАЛОГОВ

    chdir "/etc" or die "cannot chdir to /etc: $!";

    # Некоторые командные процессоры позволяют включать в
    # команду cd путь с префиксом ~, чтобы использовать в
    # качестве отправной точки домашний каталог другого
    # пользователя (например, cd ~merlyn). Это функция командного
    # процессора, а не операционной системы, а Perl вызывает
    # функции операционной системы напрямую, поэтому
    # префикс ~ не работает с chdir.

}

{ # ГЛОБЫ

    # Команде echo ничего не нужно знать о замене *.pm,
    # потому что командQ ный процессор уже выполнил ее.
    # Глобы работают даже в программах Perl:
    sub show_args {
    foreach my $arg (@ARGV) {
        print "one arg is $arg\n";
    }
}
show_args();

    # Обратите внимание: show_args не нужно ничего знать о
    # глобах – имена уже расширены и занесены в массив @ARGS.
}



{   # Но иногда в программах Perl появляются шаблоны типа *.pm.
    # Можно ли расширить их до подходящих имен файлов без особых усилий?
    # Конечно – достаточно воспользоваться оператором glob:
    sub show_glob {
        my @all_files;
        my @pl_files;
        my @pm_files;
        foreach (@ARGV) {
            @all_files = glob "~/Perl_Projects/Exercises_From_Learning_Perl/.*";
            @pl_files = glob "~/Perl_Projects/Exercises_From_Learning_Perl/*.pl";
            @pm_files = glob "~/Perl_Projects/Exercises_From_Learning_Perl/*.pm";
            #@pl_files = glob "* *.pl";
        }

        print join("\n", @all_files) . "\n";
        print join("\n", @pl_files). "\n";
        print join("\n", @pm_files). "\n";
    }

    show_glob();
}


{ # АЛЬТЕРНАТИВНЫЙ СИНТАКСИС ГЛОБОВ
    # Вместо этого он использовался в синтаксисе с угловыми скобками,
    # напоминающем синтаксис чтения из файлового дескриптора:
     my @all_files = <*>; ## Полностью эквивалентно my @all_files = glob "*";

    # Значение в  угловых скобках интерполируется по аналогии со строками в кавычках;
    # это означает, что переменные Perl перед обработкой глоба заменяются своими текущими значениями:
    my $dir = "/etc";
    my @dir_files = <$dir/* $dir/.*>;

    foreach (@dir_files) {
        print "\@dir_files = $_\n";
    }
# Таким образом, если содержимое угловых скобок является идентификатором Perl,
#  имеется в виду операция чтения; в противном случае используется операция с глобами.
# Пример:
    # my @files = <FRED/*>;  ## Глоб
    # my @lines = <FRED>;    ## Чтение из файлового дескриптора
    # my $name = "FRED";
    # my @files = <$name/*>; ## Глоб

    # если в угловых скобках находится простая скалярная переменная (не элемент хеша или массива)
    # с именем файлового дескриптора, то конструкция интерпретируется как опосредованное чтение
    # из файлового дескриптора:
    # my $name = "FRED";
    # my @lines = <$name>; ## Опосредованное чтение из дескриптора FRED

    # При желании функциональность опосредованного чтения из файловых дескрипторов
    # можно представить оператором readline ; такая запись более понятна:
    # my $name = "FRED";
    # my @lines = readline FRED;  ## Чтение из FRED
    # my @lines = readline $name; ## Чтение из FRED

}

{ # ДЕСКРИПТОРЫ КАТАЛОГОВ



}