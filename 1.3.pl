#!/usr/bin/perl

#https://ru.wikipedia.org/wiki/%D0%A8%D0%B5%D0%B1%D0%B0%D0%BD%D0%B3_(Unix)

# File 1.3.pl
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


# считываем данные с STDIN, пока они не закончатся
my $line;
$line while ($line = <>);

# какие то манипуляции с входными данными
# сюда встраивается ваш код

# вывод на STDOUT
print "...\n";
say "...\n";
