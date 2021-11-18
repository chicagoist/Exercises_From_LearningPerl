#!/usr/bin/perl -w

# File 4.5_total.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


use 5.10.0;
use strict;
use open qw(:utf8);
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use utf8;
use warnings;


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
sub greet;


greet("Fred");
greet("Barney");
greet("Wilma");
greet("Betty");


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

# Верный ответ из книги:

