#!/usr/bin/perl -w
package MyFirstPackage;


use 5.10.0;
# use CGI;
# use POSIX;
# use Encode qw(decode_utf8);
# use Encode qw(decode encode);
#= BEGIN{@ARGV=map Encode::decode(#\$_,1),@ARGV;}
# BEGIN{@ARGV = map decode_utf8(#\$_, 1), @ARGV;}
# use open qw(:std :encoding(UTF-8));
# use utf8::all 'GLOBAL';
# use Encode::Locale;
# use Encode;
# use diagnostics;


use strict;
use warnings FATAL => 'all';
use autodie qw(:all);
use utf8;
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use DDP;
use Data::Dumper;
use Bundle::Camelcade; # for Intellij IDEA

#  В пакете MyFirstPackage напишите функцию new, которая будет в качестве первого аргумента принимать имя класса,
# а в качестве остальных - хеш в виде пар "ключ-значение". Функция должна возвращать объект заданного класса,
# сконструированный из переданного хеша.


# https://ide.geeksforgeeks.org/maGWM8jKVg
# stepik.org/lesson/54330/step/3

# # to input: Locale::Module, key1 value1 key2 value2 key3 value3



sub new {
    my $str = shift @_;
    my %other_args;
    my $ref_var;

    my ($name_of_class) = split /,/, $str;
    %other_args = @_;


    $ref_var =  \%other_args;
    bless $ref_var, "$name_of_class";
    print ref $ref_var;
}

&new(<>);

