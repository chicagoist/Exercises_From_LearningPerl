#!/usr/bin/perl -w

#Напишите  программу,  которая  запрашивает  и  получает  строку
#и число (в разных строках ввода), а затем выводит строку указанное
#число  раз  –  в  отдельных  строках  вывода.  Скажем,  если  пользователь
#введет  "fred"  и  "3",  программа  выводит  три  строки  с  текстом
#«fred». Если пользователь введет "fred" и "299792", вывод получится довольно длинным.


use 5.10.0
  ;
use strict;
#для того чтобы можно было использовать полезные функции из новых версий. Например, say
use utf8;
use open qw( :std :encoding(UTF-8) );
use warnings;

sub stringAndNumber {

    print "Введите строку: ";
    my $stringFirst = <>;

    print "Введите число: ";
    chomp( my $numberFirst = <> );

    if ( defined($stringFirst) && $numberFirst != 0 ) {

        # for(my $i = 0; $i < $numberFirst; $i++ ) {

        #     print $stringFirst . "\n";
        # }

        my $result = $stringFirst x $numberFirst;
        print "\n$result";

    }
}

stringAndNumber();

