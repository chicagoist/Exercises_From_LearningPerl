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
use Bundle::Camelcade;


# УМНЫЕ СРАВНЕНИЯ И given-when

{# ОПЕРАТОР УМНОГО СРАВНЕНИЯ
    # Оператор умного сравнения ~~ проверяет оба операнда и самостоятельно решает,
    # как он их будет сравнивать. Если операнды выглядят как числа, выполняется
    # числовое сравнение. Если операнды выглядят как строки, оператор сравнивает их
    # как строки. Если один операнд содержит регулярное выражение, выполняется
    # поиск по шаблону. Оператор даже способен выполнять сложные задачи, решение
    # которых потребует большого объема кода, избавляя вас от ввода лишних символов.

    #  Более того, он даже может заменить оператор привязки. Ранее мы использовали
    # оператор привязки для того, чтобы связать $name  с оператором поиска совпадения
    # по регулярному выражению:
    my $name = "fred";
     print "I found Fred in the name!\n" if $name =~ /Fred/;

    # Если заменить оператор привязки оператором умного сравнения,
    # программа будет делать абсолютно то же самое:
    use 5.10.0;
    #use experimental 'smartmatch';
    no warnings 'experimental::smartmatch';

    say "I found fred in the '$name'!" if $name ~~ /fred/;

    # Допустим, вы хотите вывести сообщение, если в одном из ключей
    # хеша %names  совпадает шаблон Fred. ИсQ пользовать exists
    # не удастся, эта функция проверяет только точное значение ключа.
    # Можно создать цикл foreach, который проверяет каждый ключ по
    # оператору регулярного выражения и пропускает ключи, в которых
    # совпадение не обнаружено. Обнаружив ключ с совпадением, мы изменяем
    # значение переменной $flag и пропускаем остальные итерации командой last:
    my %names = qw(Fred Flintstones);
       my $flag = 0;
       foreach my $key ( keys %names ) {
           # next unless $names{$key} =~ /Fred/;
           next unless $key =~ /Fred/;
           $flag = $key;last;
       }
       print "I found a key matching 'Fred'. It was $flag\n" if $flag;

    # Но с оператором умного сравнения вы просто ставите в левой части хеш, а в правой части –
    # оператор регулярного выражения:
    use 5.10.0;
    say "I found a key matching 'Fred'" if %names ~~ /Fred/;

}