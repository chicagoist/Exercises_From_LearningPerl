#!/usr/bin/perl -w

# Напишите пользовательскую функцию с именем greet. ФункQ
# ция приветствует человека по имени и сообщает ему имя, использоQ
# ванное при предыдущем приветствии. Например, для последоваQ
# тельности команд
# greet( "Fred" );
# greet( "Barney" );
# должен выводиться следующий результат:
# Hi Fred! You are the first one here!
# Hi Barney! Fred is also here!

use 5.10.0;
use strict;
use utf8;
use open qw(:std :encoding(UTF-8));
use warnings;

sub greet {

    state $first_name; # инициализируем статические переменные в scope этой функции
    state $second_name; # инициализируем статические переменные в scope этой функции

    if ( !$first_name ) { # если первая переменная == undef, 

        $first_name = pop @_; # тогда присваиваем значение первого элемента из массива @_ используя функцию pop

    }elsif ( !$second_name ) { # если вторая переменная == undef, 

        $second_name = pop @_; # тогда присваиваем значение первого элемента из массива @_ используя функцию pop

    }

    if ($first_name && $second_name ) { # только если обе переменные заданы и не == undef

        print "Hi $first_name\! You are the first one here!\n";
        print "Hi $second_name\! $first_name is also here!\n";
    }
}

greet("Валерий");
greet("Алексей");

# Верный ответ из книги:

# To remember the last person that greet  spoke to, use a state  variable. It starts 
# out as undef, which is how we figure out Fred is the first person it greets. At the 
# end of the subroutine, we store the current $name in $last_name so we remember 
# what it is next time: 

# use v5.10;
# greet('Fred');
# greet('Barney');

# sub greet {
#     state $last_person;
#     my $name = shift;
#     print "Hi $name! ";
#     if ( defined $last_person ) {
#         print "$last_person is also here!\n";
#     }
#     else {
#         print "You are the first one here!\n";
#     }
#     $last_person = $name;
# }
