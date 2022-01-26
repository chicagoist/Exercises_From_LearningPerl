#!/usr/bin/perl -w
package Local::Package;


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

#  Допишите модуль так, что бы при его подключении по стандарту была доступна функции functionA,
# а функция functionB  импортировалась по требованию. (Используйте Exporter);


# https://stepik.org/lesson/51559/step/7




sub functionA {
    return $_[0] + $_[1];
}
sub functionB {
    return $_[0] * $_[1];
}

use Exporter qw/import/;
our @EXPORT_OK = qw/functionA functionB/;        # possible to export
our @EXPORT = qw/functionA/;                  # exported by default
our %EXPORT_TAGS = (                    # export items by tag name
    const => [ qw/functionA functionB/ ]
);

1;

print functionA(5,6) . "\n";
print functionB(5,6) . "\n";