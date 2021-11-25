#!/usr/bin/perl -w

# File 6.3.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/

# Напишите программу для вывода всех ключей и значений
# в %ENV. Выведите результаты в два столбца в ASCII-алфавитном порядке.
# Отформатируйте результат так, чтобы данные в обоих столбцах
# выравнивались по вертикали. Функция length поможет вычислить
# ширину первого столбца. Когда программа заработает, попробуйте
# задать новые переменные среды и убедитесь в том, что они
# присутствуют в выходных данных.


use 5.10.0;
use strict;
use open qw(:std :encoding(UTF-8));
use Encode qw(decode_utf8);
BEGIN{ @ARGV = map decode_utf8( $_ , 1 ) , @ARGV; }
binmode( STDIN , ':utf8' );
binmode( STDOUT , ':utf8' );
use utf8;
use warnings;
use POSIX;
#use utf8::all 'GLOBAL'; # пробую этот модуль вместо закомментированных выше строк

# Напишите программу, выводящую каждую строку входных
# данных, в которой присутствует слово fred (с другими строками ничего делать не нужно).
# Будет ли найдено совпадение во входной строке Fred, frederick  или Alfred?
# Создайте небольшой текстовый файл, в котором упоминаются fred flintstone и его друзья.
# Используйте его для передачи входных данных этой и другим программам этого раздела.

sub find_a_string {
    my $index_fred = 0; # индекс для подсчёта строк с именем fred
    my $index_all = 0; # индекс подсчёта общих строк
    chomp( @_ );
    foreach ( @_ ) # запускаем цикл по массиву
    {
        if ( /fred/ ) # если находим нужное слово в строке
        {
            print "$_\n"; # печатаем эту строку
            $index_fred++; # и добавляем в индекс
        }
    }

    # блок разделения между тестами. просто для наглядности
    print "\n";
    foreach ( 0 .. 40 )
    {
        printf( "%s" , "§§" );
    }
    print "\n";
    # блок разделения между тестами. просто для наглядности

    foreach ( @_ )
    {
        if ( /(.)*/ ) # проходим все строки подряд без ограничений
        {
            print "$_\n"; # печатаем текст
            $index_all++; # добавляем в счетчик
        }
    }
    say "\$index_fred = $index_fred"; # сравниваем разницу индексов
    say "\$index_all = $index_all";

}

find_a_string( <> );
# $ perl 7.1.pl examples/sample_files/text_files/sample_text


# while( <STDIN> ) {
#     chomp;
#     if ( /$ARGV[0]/ ) { # May be hazardous for your health
#         print "\tMatches\n";
#     }
#     else {
#         print "\tDoesn't match\n";
#     }
# }


# Верный ответ из книги:


#Here’s one way to do it:
#
# while (<>) {
#     if (/fred/) {
#         print;
#     }
# }
#
#
# This is pretty simple. The more important part of this exercise is trying it out on
#     the sample strings. It doesn’t match Fred, showing that regular expressions are
#     case-sensitive. (We’ll see how to change that later.) It does match frederick and
#     Alfred, since both of those strings contain the four-letter string fred. (Matching
#     whole words only, so that frederick and Alfred wouldn’t match, is another fea‐
# ture we’ll see later.)
#