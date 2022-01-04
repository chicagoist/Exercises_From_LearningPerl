#!/usr/bin/perl

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

{
    # ОПЕРАТОР УМНОГО СРАВНЕНИЯ
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
    use experimental 'smartmatch';
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
    foreach my $key (keys %names) {
        # next unless $names{$key} =~ /Fred/;
        next unless $key =~ /Fred/;
        $flag = $key;
        last;
    }
    print "I found a key matching 'Fred'. It was $flag\n" if $flag;

    # Но с оператором умного сравнения вы просто ставите в левой части хеш, а в правой части –
    # оператор регулярного выражения:
    use 5.10.0;
    say "I found a key matching 'Fred'" if %names ~~ /Fred/;

    # Допустим, вам понадобилось сравнить два массива (с одинаковым количеством элементов).
    # Можно перебрать индексы одного массива и в каждой итерации сравнить соответствующие
    # элементы двух массивов. Каждый раз, когда элементы совпадают, в  программе увеличивается
    # счетчик $equal. Если после завершения цикла значение $equal совпадает с количеством
    # элементов @names1, массивы совпадают:

    my $equal = 0;
    my @names1;
    $names1[0] = "fred";
    $names1[1] = "Fred";
    $names1[2] = "Wilma";

    my @names2;
    $names2[0] = "fred";
    $names2[1] = "Fred";
    $names2[2] = "Wilma";

    foreach my $index (0 .. @names1 - 1) {
        # print "$names1[$index]\n";
        # print "$names2[$index]\n";
        last unless $names1[$index] eq $names2[$index];
        $equal++;
    }
    print "The arrays have the same elements!\n" if $equal == @names1;

    #  Следующий небольшой фрагмент делает то же, что и предыдущий пример, но с
    # минимумом программного кода:
    say "The arrays have the same elements!" if @names1 ~~ @names2;

    # Вспомните функцию max() из главы 4: она всегда должна возвращать одно
    # из переданных ей значений. Что-бы убедиться в этом, можно проверить
    # возвращаемое  значение max  по списку аргументов «вручную», как это
    # делалось в предыдущих трудных решениях:

    #use experimental qw(signatures);
    # require '/home/user/Perl_Projects/Exercises_From_Learning_Perl/4.1_max.pl';
    #
    # my @nums = qw(1 2 3 27 42);
    # my $result = max(@nums);
    # my $flagG = 0;
    # foreach my $num (@nums) {
    #     next unless $result == $num;
    #     $flagG = 1;
    #     last;
    # }
    # print "The result is one of the input values\n" if $flagG;
    #
    # # Оператор ~~ позволяет исключить из этого кода весь средний фрагмент.
    # # Решение заметно упрощается:
    # my @numsS   = qw( 1 2 3 27 44 );
    # my $resultT = max(@numsS);
    # say "The result [$resultT] is one of the input values (@numsS)" if $resultT ~~  @numsS;

}

{ # ПРИОРИТЕТЫ УМНОГО СРАВНЕНИЯ
    ##ПРИМЕР##          ##ТИП СРАВНЕНИЯ##
   # %a ~~ %            Ключи хешей идентичны
   # %a ~~ @b           Хотя бы один ключ %a содержится в @b
   # %a ~~ /Fred/       Шаблон совпадает хотя бы в одном ключе
   # %a ~~ 'Fred'       Существование ключа хеша: exists $a{Fred}
   # @a ~~ @b           Массивы совпадают
   # @a ~~ /Fred/       Шаблон совпадает хотя бы в одном элементе
   # @a ~~ 123          Содержит хотя бы один элемент 123 (в числовом формате)
   # @a ~~ 'Fred'       Содержит хотя бы один элемент 'Fred' (в строковом формате)
   # $name ~~ undef     Переменная $name имеет неопределенное значение
   # $name ~~ /Fred/    Поиск совпадения по шаблону
   # 123 ~~ '123.0'     Проверка числового равенства с «числовыми строками»
   # 'Fred' ~~ 'Fred'   Равенство строк
   # 123 ~~ 456         Числовое равенство

    use experimental 'smartmatch';
    # Допустим, в операндах передается массив и хеш:
    my(@array, %hash) = (0..100, 100..0);
    my ($fred, $barney) = @array;
    say $fred;
    say $barney;
       if( @array ~~ %hash ) { say 1; }
    # А если указаны два скаляра?
       if( $fred ~~ $barney ) { say 2; }
    # Пока невозможно сказать, какое сравнение будет выполнено;
    # Perl не может принять решения без анализа данных, содержащихся в этих переменных.
    # Чтобы определить, как  следует  сравнивать  $fred  и $barney,
    # Perl проверяет значения по уже изложенным правилам. Он перебирает
    # строки таблицы от начала к концу, пока не найдет подходящее описание,
    # а затем использует соответствующую операцию. При этом необходимо учитывать одну тонкость:
    # Perl распознает некоторые строки как числа (так называемые «числовые строки» – numish strings).
    # Речь идет о строках вида '123', '3.14149' и т. д. Содержимое этих строк заключено в апострофы,
    #  поэтому они фактически являются последовательностями символов, однако Perl может
    # преобразовать их в числа без предупреждений. Если Perl обнаруживает в обеих
    # частях оператора умного сравнения числа или числовые строки, он  выполняет
    # числовое сравнение. В противном случае выполняется строковое сравнение.
}

{# КОМАНДА GIVEN

    # Управляющая конструкция given позволяет выполнить блок кода, если аргумент
    # удовлетворяет указанному условию. В сущности, это Perl эквивалент команды
    # switch  языка C; но, как и многие конструкции Perl, given обладает
    # оригинальными возможностями, поэтому ей присваивается оригинальное имя.

    use experimental 'switch';

    given( $ARGV[0] ) {
        when (/fred/ig) {say '1Name has fred in it'}
        when (/^Fred/) {say '1Name starts with Fred'}
        when ('Fred') {say '1Name is Fred'}
        default {say "1I don't see a Fred"}
    }

    # этот пример с if-elsif-else».
    # В следующем примере именно это и делается с использованием
    # переменной $_:
    {
        $_ = $ARGV[0]; # lexical $_ as of 5.10!
        if( $_ ~~ /fred/i ) { say 'ifName has fred in it' }
        elsif( $_ ~~ /^Fred/ ) { say 'ifName starts with Fred' }
        elsif( $_ ~~ 'Fred'  ) { say 'ifName is Fred' }
        else                   { say "ifI don't see a Fred" }
    }

    # Если не принять специальные меры, в конец каждого блока включается
    # неявная команда break, которая приказывает Perl прервать обработку
    # given-when  и продолжить выполнение программы. Таким образом,
    # предыдущий пример содержал команды break, хотя  вам и не пришлось
    # вводить их самостоятельно:
    given( $ARGV[0] ) {
        when( $_ ~~ /fred/i ) { say '3Name has fred in it'; break }
        when( $_ ~~ /^Fred/ ) { say '3Name starts with Fred'; break }
        when( $_ ~~ 'Fred'  ) { say '3Name is Fred'; break }
        default               { say "3I don't see a Fred"; break }
    }

    # Но если завершить блок when  ключевым словом continue,
    # Perl даже в случае выполнения условия перейдет к следующему условию,
    # и весь процесс повторится заново. Конструкция if-elsif-else на такое
    # не способна. Если другое условие  when  окажется истинным,
    # Perl выполняет его блок (снова неявно завершаемый командой break,
    # если в программе явно не указано обратное). Если добавить continue
    # в конец каждого блока, Perl опробует все условия:
    given( $ARGV[0] ) {
        when( 'Fred'  ) { say '4Name is Fred'; continue } # OOPS!
        when( 'Fred'  ) { say '4Name is Fred'; continue } # OK now!
        when( /fred/ig ) { say '4Name has fred in it'; continue }
        when( /^Fred/ ) { say '4Name starts with Fred' }

        default               { say "4I don't see a Fred" }
    }
}

{# ОБЫЧНОЕ СРАВНЕНИЕ
    # Наряду с умным сравнением в given-when  также можно использовать обычные,
    # «глупые» сравнения. Конечно, ничего плохого в них нет, просто это
    # самые обычные поиски совпадений по регулярным выражениям, которые вам уже известны.
    use experimental 'switch';

    given( $ARGV[0] ) {
        when( /fred/i )       { #smart
            say '5Name has fred in it'; continue }
        when( $_ =~ /^Fred/ ) { #dumb
            say '5Name starts with Fred'; continue }
        when( 'Fred'  )       { #smart
            say '5Name is Fred' }
        default               { say "5I don't see a Fred" }
    }


}