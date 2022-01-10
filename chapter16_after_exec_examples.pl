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
