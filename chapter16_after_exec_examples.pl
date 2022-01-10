#!/usr/bin/perl

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
use utf8::all 'GLOBAL';
use DDP;
use Data::Dumper;
use Bundle::Camelcade;
use POSIX;



{ # ПЕРЕМЕННЫЕ СРЕДЫ

    # В Perl для работы с переменными среды используется специальный хеш %ENV;
    # каждый ключ хеша соответствует одной переменной. В начале выполнения
    # программы %ENV  содержит значения, унаследованные от родительского процесса
    # (чаще всего командного процессора).

    # Модификация хеша изменяет переменные среды, которые наследуются новыми
    # процессами и могут использоваться самим Perl. !!!!

    # Допустим, вы хотите запустить системную утилиту make (которая обычно
    # запускает другие программы) так, чтобы поиск команд (включая саму
    # команду make) начинался с приватного каталога. Также будем считать,
    # что при запуске команды переменная среды IFS  не должна устанавливаться,
    # потому что это может нарушить работу make или другой подкоманды. Вот как
    # это делается:

    # $ENV{'PATH'} = "/home/rootbeer/bin:$ENV{'PATH'}";
    $ENV{'PATH'} = "/home/legioner/usr/bin:$ENV{'PATH'}";
    delete $ENV{'IFS'};
    # my $make_result = system "make";
    my $make_result = system "curl";
    say "\"$make_result => $make_result";

}

{ # ОБРАТНЫЕ АПОСТРОФЫ И СОХРАНЕНИЕ ВЫВОДА

    # При использовании обеих функций system и exec
    # выходные данные запущенной команды направляются
    # в стандартный поток вывода Perl. Иногда бывает
    # нужно сохранить этот вывод в строковом виде для
    # дальнейшей обработки. Задача решается просто:
    # замените апострофы или кавычки при создании
    # переменной обратными апострофами ` `:

    my $now = `date`;             # Сохранить вывод date
    print "The time is now $now"; # Символ новой строки уже присутствует

    # Значение в обратных апострофах интерпретируется как форма sуstem с
    # одним аргументом по правилам строк в кавычках (то есть с интерпретацией
    # служебных последовательностей с символом \  и расширением переменных).
    # Например, для получения документации по  функциям Perl мы могли бы
    # многократно вызвать perldoc с разными аргументами:

    my @functions = qw{ int rand sleep length hex eof not exit sqrt umask };
    my %about;
    foreach (@functions) {
        $about{$_} = `perldoc -t -f $_`;
    }

    foreach (keys %about) {
        say "$_ => $about{$_}";
    }

    # Постарайтесь обходиться без обратных апострофов в тех местах, где
    # вывод не сохраняется. Пример:
    print "Starting the frobnitzigator:\n";
    my $output_with_errors = `frobnitz -enable 2>&1`;  # Не делайте этого!
    `frobnitz -enable`;  # Не делайте этого!
    print "Done!\n";
    say "\$output_with_errors => $output_with_errors";

    # Итак, и с точки зрения эффективности, и с точки зрения безопасности
    # system оказывается предпочтительнее.

 }

{
    # Обратные апострофы в списочном контексте

    # Если результат выполнения команды состоит из нескольких строк,
    # в скалярном контексте обратные апострофы возвращают одну длинную
    # строку с внутренними символами новой строки. Однако при использовании
    # той же строки в списочном контексте создается список, один элемент
    # которого соответствует одной строке вывода.
    my $ls_l = `find *`;
    my @ls_l = `find *`;
    # print $ls_l;
    # print @ls_l;

    my %files;
    my @files_find = ();
    my $file_code;

    foreach (`find *`) {
        push @files_find, $_;
    }

    foreach (@files_find) {
        $files{$_} .= `ls -l $_`;
    }

    foreach (sort keys %files) {
        print $files{$_};
    }
}