#!/usr/bin/perl -w

use 5.10.0;
#use CGI;
#use POSIX;
# use Encode qw(decode_utf8);
# use Encode qw(decode encode);
# BEGIN{@ARGV=map Encode::decode($_,1),@ARGV;}
# BEGIN{@ARGV = map decode_utf8($_, 1), @ARGV;}
# use open qw(:std :encoding(UTF-8));
# use utf8::all 'GLOBAL';
# use Encode::Locale;
# use Encode;


use strict;
use warnings FATAL => 'all';
#use diagnostics;
use utf8;
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use DDP;
use Data::Dumper;


# УПРАВЛЯЮЩАЯ КОНСТРУКЦИЯ unless

# В управляющей конструкции if  блок кода выполняется только в том случае, если условие истинно.
# Если блок кода должен выполняться только при ложном условии, замените if на unless:
my $fred = "007Fred";
unless ($fred =~ /^[A-Z_]\w*$/i) {
    print "The value of \$fred doesn't look like a Perl identifier name.\n";
}
# В сущности, конструкция unless эквивалентна проверке if с противоположным условием.
# Также можно сказать, что unless напоминает самостоятельную секцию else.
if ($fred =~ /^[A-Z_]\w*$/i) {
    # Ничего не делать
}
else {
    print "The value of \$fred doesn't look like a Perl identifier name.\n";
}

# СЕКЦИЯ else в unless

# Конструкция unless  даже может содержать необязательную секцию else.
# Этот синтаксис поддерживается, но он может привести к потенциальным недоразумениям:
my $mon = "December";
unless ($mon =~ /^Feb/) {
    print "This month has at least thirty days.\n";
}
else {
    print "Do you see what's going on here?\n";
}
# Но мы предпочитаем лиQ бо использовать if  с отрицанием условия, либо просто переставить
# секции для получения обычной конструкции if:
if ($mon =~ /^Feb/) {
    print "Do you see what's going on here?\n";
}
else {
    print "This month has at least thirty days.\n";
}

# УПРАВЛЯЮЩАЯ КОНСТРУКЦИЯ until
# Иногда бывает удобнее выполнить цикл while  с обратным условием.
# Для этого воспользуйтесь конструкцией until:
use 5.10.0;
my ($j, $i) = (1, 10);
until ($j > $i) {
    $j *= 2;
    say $j;
}
# until - Пока не станет так ($j > $i)
# Цикл выполняется до тех пор, пока выражение в условии не вернет true.

# МОДИФИКАТОРЫ ВЫРАЖЕНИЙ
# Чтобы сделать запись более компактной, после выражения может следовать
# управляющий модификатор.:
my $x1 = -10;
my $x2 = 10;
my $random = int(rand($x1 - $x2 + 1)) + $x2;
print "$random is a negative number.\n" if $random < 0; # Например, модификатор if  работает по аналогии с блоком if

# Результат получается точно таким же, как при использовании следующего кода :
if ($random < 0) {
    print "$random is a negative number.\n";
}

# Существуют и другие модификаторы:
# &error("Invalid input") unless &valid($input);
# $i *= 2 until $i > $j; print " ", ($n += 2) while $n < 10;
# &greet($_) foreach @person;

my ($fred1, $barney, $I_am_curious) = ("Fred", "Barney", "YES");
# В одном из стандартных способов применения этих модификаторов используются
# команды следующего вида:
print "fred is '$fred1', barney is '$barney'\n" if $I_am_curious;
# При подобной «инвертированной» записи наиболее важная часть команды записывается в начале.
# Главной целью команды является отQ слеживание значений переменных, а не проверка условия.
# С каждой стороны модификатора может находиться только одно выражение. Следовательно,
# вы не можете использовать запись «чтоQто if  чтоQто while  чтоQто until  чтоQто unless  что-то foreach  что-то»;
# все равно получится слишком сложно. Кроме того, несколько команд нельзя разместить слева от модификатора.
# Если с каждой стороны требуется нечто большее, чем простое выражение, запишите код в «традиционной» форме –
# с круглыми и фигурными скобками.

=begin :text6
#  ПРОСТЕЙШИЙ БЛОК

# простейший блок:
# {
# тело;
# тело;
# тело;
# }

# он создает область видимости (scope) для временных лексических переменных:
{
    print "Please enter a number: ";
    chomp(my $n = <STDIN>);
    $n =~ s/^(\d*[.]?\d*).*\d*$/$1/; # take only first digit from the line
    # chomp(@_ = <STDIN>); # Like a Draft. )))
    # my $n;
    # foreach (@_) {
    #     s/^(\d*[.]?\d*).*\d*$/$1/;
    #     $n  = $_;
    # }
    my $root = sqrt $n; # Вычисление квадратного корня
    $_ = \$n;
    print "The square root of $n is $root.\n";
}
# Please enter a number: 5.2 5 555
# The square root of 5.2 is 2.28035085019828.
#
# say $n; # Unable to find variable declaration.
# say $root; # Unable to find variable declaration.


# СЕКЦИЯ elsif
# Время от времени требуется последовательно проверить несколько условий и узнать,
# какое из них истинно. Для этого можно воспользоваться секцией elsif конструкции if,
# как в следующем примере:
my $dino = $_;
if (!defined $dino) {
    print "The value is undef.\n";
}
elsif ($dino =~ /^-?\d+\.?$/) {
    print "The value is an integer.\n";
}
elsif ($dino =~ /^-?\d*\.\d+$/) {
    print "The value is a _simple_ floating-point number.\n";
}
elsif ($dino eq '') {
    print "The value is the empty string.\n";
}
else {
    print "The value is the string '$dino'.\n";
}
=end :text6
=cut


#  АВТОИНКРЕМЕНТ И АВТОДЕКРЕМЕНТ
use DDP;
my @people = qw{fred barney fred wilma dino barney fred pebbles};
my %count; # новый пустой хеш
$count{$_}++ foreach (@people);
p %count, as => "This label will be printed too!";
# https://metacpan.org/pod/Data::Printer
print Dumper(%count);
# https://metacpan.org/pod/Data::Dumper

# Оператор автоинкремента (++) увеличивает скалярную переменную на 1 по аналогии
# с тем же оператором в C и других языках:
my $bedrock = 42;
$bedrock++; # Увеличить $bedrock на 1; теперь 43
say "\$bedrock = $bedrock";

# Аналогичный оператор авто декремента -- уменьшает скалярную переменную на 1:
$bedrock--; # уменьшить $bedrock на 1; снова получается 42
say "\$bedrock = $bedrock";


# ЗНАЧЕНИЕ АВТОИНКРЕМЕНТА

# Эта форма называется префиксным инкрементом:
my $m = 5;
my $n = ++$m; # увеличить $m до 6, сохранить полученное значение в $n
say $n;
# перед переменной оператор -- пре-фиксный декремент):
my $c = --$m; # Уменьшить $m до 5, сохранить полученное значение в $c
say $c;

# Эта форма называется постфиксным инкрементом или постфиксным декрементом:
my $d = $m++; # В $d сохраняется старое значение (5), затем $m увеличивается до 6
my $e = $m--; # В $e сохраняется старое значение (6), затем $m  уменьшается до 5
# Хитрость в том, что мы выполняем две операции одновременно. ВЫБОРКА значения совмещается
# с его изменением в том же выражении.

# Если выражение записано само по себе 1 , а его значение не используется (только побочный эффект),
# от размещения оператора до или после переменной ничего не изменится:
$bedrock++; # Увеличить $bedrock на 1
++$bedrock; # То же самое; увеличить $bedrock на 1
# Эти операторы часто используются при работе с хешами для идентификации встречавшихся ранее значений:
my @peoples = qw{fred barney bamm-bamm wilma dino barney betty pebbles};
my %seen;
foreach (@peoples) {
    print "I've seen you somewhere before, $_!\n"
        if $seen{$_}++;
    next;
}

=begin :text4
# УПРАВЛЯЮЩАЯ КОНСТРУКЦИЯ for
# Управляющая конструкция Perl for  напоминает стандартные конструкции циклов из других языков,
# таких как C. Она выглядит так:
# for (инициализация; проверка; приращение) {
#    тело;
#    тело;
# }
# Но Perl рассматривает эту конструкцию как замаскированный цикл while следующего вида:
#    инициализация;
#    while (проверка) {
#    тело;
#    тело;
#    приращение;
# }
#
for (my $ii = 1; $ii <= 10; $ii++) {  # Отсчет от 1 до 10
 print "I can count to $ii!\n";
}
# It is same code:
my $ii = 1;
while($ii <= 10) {
    print "I can count to $ii!\n";
    $ii++;
}
=end :text4
=cut

=begin :text5
# ТАЙНАЯ СВЯЗЬ МЕЖДУ foreach и for


# Если в скобках нет двух точек с запятой, значит, Perl
# имеет дело с циклом foreach:
for (1..10) {  # На самом деле цикл foreach от 1 до 10
  print "I can for like a foreach to $_!\n";
}
for (my $ij = 1; $ij < 10; $ij++) {  # Ошибка! Что-то здесь не так!
 #print "I can count to $_!\n";
}
# Вот почему мы говорим, что в Perl обычно предпочтителен «истинный» цикл foreach.
=end :text5
=cut


# УПРАВЛЕНИЕ ЦИКЛОМ

# Оператор last  немедленно прекращает выполнение цикла.
# (оператор break  в  C или похожем языке, это его аналог.)
# В сущности,last  открывает «аварийный выход» из блока цикла.
# Его выполнение завершает цикл. Пример:
=begin :text1
     # Вывести все входные строки с упоминанием fred вплоть до маркера __END__

while (<STDIN>) {
         if (/__END__/) {
             # После маркера входные данные отсутствуют
              last;
         } elsif (/fred/) {
             print;
         }
     } ## Сюда last передает управление #
# Оператор last применяется к внутреннему блоку цикла, то есть блоку с максимальной вложенностью.
=end :text1

=cut

=begin :text2
# ОПЕРАТОР next
# оператор next, осуществляющий переход к нижнему концу текущего блока цикла.
# После next выполнение продолжается со следующей итерацией цикла
# (по аналогии с оператором continue в C или другом похожем языке):


# Анализ слов во входном файле или файлах
my $total;
my %county;
my $valid;

while (<>) {foreach (split) {  # Разбить $_ на слова, последовательно присвоить
                               # каждое слово  $_
$total++;
    next if /\W/;    # Для непонятных слов остаток итерации пропускается
    $valid++;
    $county{$_}++;    # Увеличить счетчик для каждого слова
 ## Сюда next передает управление ##
}
}
print "total things = $total, valid words = $valid\n";
foreach my $word (sort keys %county) {
    print "$word was seen $county{$word} times.\n";
}
# Как и last, оператор next может использоваться в любых из пяти видов блоков
# циклов: for, foreach, while, until  и простейшем блоке. Во вложенных блоках
# циклов next  завершает итерацию внутреннего блока.
=end :text2
=cut


=begin :text3
# ОПЕРАТОР redo

#  Он возвращает управление в начало текущего блока цикла без проверки условия или перехода
# к следующей итерации. (Если вы программировали на C или другом похожем языке,
# не ищите аналоги. В этих языQ ках похожего оператора нет.) Пример:
# Проверка навыков печати
my @words = qw{ fred barney pebbles dino wilma betty };
my $errors = 0;
foreach (@words) {
    ## Сюда redo передает управление ##
    print "Type the word '$_': ";
    chomp(my $try = <STDIN>);
    if ($try ne $_) {
        print "Sorry - That's not right.\n\n";
        $errors++;
        redo;  # Возврат в начало цикла
        }
}
print "You've completed the test, with $errors errors.\n";
=end :text3
=cut

=begin :text REDO
# Главное отличие между операторами next  и redo  заключается в том,
# что next  перемещается к следующей итерации, а redo  повторяет текущую
# итерацию. Следующий пример дает некоторое представление о том,
# как работают эти три оператора:
foreach (1..10) {
    print "Iteration number $_.\n\n";
    print "Please choose: last, next, redo, or none of the above? ";
    chomp(my $choice = <STDIN>);
    print "\n";
    last if $choice =~ /last/i;
    next if $choice =~ /next/i;
    redo if $choice =~ /redo/i;
    print "That wasn't any of the choices... onward!\n\n";
}
print "That's all, folks!\n";
=end :text REDO
=cut


=begin :text LINE
# МЕТКИ БЛОКОВ

# Чтобы выполнить операцию не с внутренним, а какимQто другим блоQ ком цикла, воспользуйтесь меткой.
# Чтобы назначить метку блоку цикла, поставьте ее с двоеточием перед началом
# цикла. Затем внутри  цикла используйте метку в  операторах last, next или redo
# по мере необходимости:

LINE: while (<>) {
    say "HERE";
    foreach (split) {

       last LINE if /__END__/; # Выход из цикла LINE...

    }
}

print "Without LINE last go to next code after while loop\n";
# Для удобства чтения метку обычно рекомендуется ставить у левого поля, даже если
# текущий код обладает отступом более высокого уровня. Обратите внимание: метка
# обозначает целый блок, а не целевую точку в коде. Это все же не goto.
=end :text LINE
=cut

=begin :text Conditional

# ТЕРНАРНЫЙ ОПЕРАТОР ?:

# Тернарный оператор напоминает проверку if-then-else, упакованную в одно выражение.
# Оператор называется «тернарным», потому что он получает три операнда.
# Оператор выглядит примерно так:
#       выражение ? выражение_для_true : выражение_для_false
# В этом примере результат вызова функции &is_weekend определяет, какое выражение будет присвоено переменной:
my $location = &is_weekend($day) ? "home" : "work";
# А здесь мы вычисляем и выводим среднее значение или строку-заполнитель из дефисов, если данные отсутствуют:
my $average = $n ? ($total/$n) : "------"; print "Average: $average\n";
# Любое использование оператора ?:  можно переписать в виде структуры if, но часто с потерей удобства и компактности:
my $average;
if ($n) {
    $average = $total / $n;
} else {
    $average = "-----";
}
print "Average: $average\n";

# А вот полезный прием, который может использоваться для кодирования удобного разветвленного выбора:
my $width = 30;
my $size =
    ($width < 10) ? "small"  :
    ($width < 20) ? "medium" :
    ($width < 50) ? "large"  :
        "extra-large"; # default
print $size; # large
$width = 15;
# same code:
$size =($width < 10)?"small":($width < 20)?"medium":($width < 50) ? "large":"extra-large"; # default
print $size; # medium
=end :text Conditional
=cut


=begin :text LOGICAL
# ЛОГИЧЕСКИЕ ОПЕРАТОРЫ

# логические условия часто объединяются логическими операторами AND (&&) и OR (||):
#my %dessert = (cake=> 1);
my %dessert;
if ($dessert{'cake'} && $dessert{'ice cream'}) {
# Оба условия истинны
print "Hooray! Cake and ice cream!\n";
} elsif ($dessert{'cake'} || $dessert{'ice cream'}) {
# По крайней мере, одно условие истинно
print "That's still good...\n";
} else {
  print "Оба условия ложны - ничего не делать\n";
}
# Что произойдет, если в приведенном примере переменная $hour равна 3:
my $hour = 3;
if ( (9 <= $hour) && ($hour < 17) ) {
print "Aren't you supposed to be at work...?\n";
}

# Аналогично при истинности левой стороны логической операции  OR правая сторона также не вычисляется.
# Допустим, в следующем выражении переменная $name содержит строку fred:
my $name = 'fred';
if ( ($name eq 'fred') || ($name eq 'barney') ) {
print "You're my kind of guy '$name'!\n";
}
# $ You're my kind of guy 'fred'!

# Из-за этой особенности такие операторы называют «ускоренными» (short-circuit).
my ($nn, $totall) = (0, 15);
if ( ($nn != 0) && ($totall/$nn < 5) ) {
print "The average is below five.\n";
}
# В этом примере правая сторона вычисляется только в том случае, если левая сторона истинна.
=end :text LOGICAL
=cut

=begin :text Short-Circuit Operator
# ЗНАЧЕНИЕ УСКОРЕННОГО ЛОГИЧЕСКОГО ОПЕРАТОРА

# В отличие от C (и других похожих языков), значением ускоренного логического оператора является значение,
# полученное при обработке последней части, а не логическая величина.
# Формально результат получается эквивалентным: последняя вычисленная часть всегда истинна,  если истинно все
# выражение, и всегда ложна, если ложно все выражение. Однако такое  возвращаемое значение намного полезнее.
# В частности, логический оператор OR весьма удобен для выбора значения по умолчанию:
my %last_name;
my $someone;
my $last_name = $last_name{$someone} || '(No last name)';
print $last_name; #  (No last name)
# в этой идиоме значение по умолчанию не просто заменяет undef; оно с таким же успехом заменит любое ложное значение.
# Проблема решается при помощи тернарного оператора:
$someone = 'Ivan';
%last_name = ($someone => 0);
$last_name = defined $last_name{$someone} ?$last_name{$someone} : '(No last name)';
print  $last_name; # 0
# Однако запись получается слишком громоздкой, а $last_name{$someone} в нее включается дважды.
# В Perl 5.10 появился более удобный синтаксис для выполнения подобных операций; он описан в следующем разделе.
=end :text Short-Circuit Operator
=cut

=begin :text DEFINED-OR

# The DEFINED-OR OPERATOR or ОПЕРАТОР //
# Даже если значение $last_name{$someone} равно 0, эта версия все равно работает:
use 5.10.0;
my %last_name;
my $someone = "";
my $last_name = $last_name{$someone} // '(No last name)'; # in 5.34.0 working at well both: old and this //

# Допустим, программа должна выводить сообщения только при заданной переменной среды VERBOSE. Мы проверяем значение,
# связанное с ключом VERBOSE в хеше %ENV. Если значение отсутствует, оно задается программой:
use 5.10.0;
my $Verbose = $ENV{VERBOSE} // 1;
print "I can talk to you!\n" if $Verbose;


    # Следующая программа проверяет, как работает оператор //: она перебирает несколько значений и смотрит,
    # какие из них будут заменены значением по умолчанию default:
    #use 5.01.0;
    use DDP;
    print "\n\n";
    foreach my $try (0, undef, '0', 1, 25, 'undef') {
        print "If \$try have : ";
        print "\n"; p $try;
        my $value = $try // 'default';
        print "got [$value] value.\n\n";
    }
# If $try have :
# 0 (read-only)
# got [0] value.
#
# If $try have :
# undef (read-only)
# got [default] value.
#
# If $try have :
# 0 (read-only)
# got [0] value.
#
# If $try have :
# 1 (read-only)
# got [1] value.
#
# If $try have :
# 25 (read-only)
# got [25] value.

{
    use warnings;
    my $name; # Значение не указано, undef!
    # printf "%s", $name; # Use of uninitialized value in printf ...

    # Но если вы ожидаете, что выводимое значение может оказаться неопределенным,
    # его можно заменить пустой строкой:
    use 5.10.0;
    use warnings;
    # $name; # Значение отсутствует, undef!
    printf ">%s<\n", $name // '';
}
=end :text DEFINED-OR
=cut

=begin :text Partial-Evaluation
# УПРАВЛЯЮЩИЕ КОНСТРУКЦИИ С ОПЕРАТОРАМИ НЕПОЛНОГО ВЫЧИСЛЕНИЯ Partial-Evaluation
{
    my $mm = int(rand(20));
    my $x = int(rand(20));
    my $n = int(rand(20));
    print "\$mm = $mm\n";
    print "\$x = $x\n";
    print "\$n = $n\n\n";
    ($mm > 10) || print "why is it not greater? \n";

    $mm > $x ? $x = $n : $mm = $n;
    # Если $m меньше, $x присваивается ей, в противном случае $x присваивается переменной $n.

    print "If \$mm < \$x will change: \$mm = $mm\n";
    print "If \$mm > \$x will change: \$x = $x\n";
    print "\$n = $n\n";

}

{
    # Общепринятый способ открытия файла в Perl выглядит так:
    my $filename = 'text.txt';
    open CHAPTER, $filename
        or die "Can't open '$filename': $!";


}
=end :text Partial-Evaluation
=cut
