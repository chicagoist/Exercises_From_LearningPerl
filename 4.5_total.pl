#!/usr/bin/perl -w

# Измените предыдущую программу так, чтобы она сообщала
# имена всех людей, которых она приветствовала ранее. Например,
# для последовательности команд
# greet( "Fred" );
# greet( "Barney" );
# greet( "Wilma" );
# greet( "Betty" );
# должен выводиться следующий результат:
# Hi Fred! You are the first one here!
# Hi Barney! I've seen: Fred
# Hi Wilma! I've seen: Fred Barney
# Hi Betty! I've seen: Fred Barney Wilma

use 5.10.0;
use strict;
use utf8;
use open qw(:std :encoding(UTF-8));
use warnings;

sub greet {

    state @persons;
    my $name = shift @_;

    print "Hi $name! ";

    if (@persons) {

        print "I've seen: @persons\n";

    }
    else {
        print "You are the first one here!\n";
    }
    push @persons, $name;

}

greet("Fred");
greet("Barney");
greet("Wilma");
greet("Betty");

# Верный ответ из книги:

