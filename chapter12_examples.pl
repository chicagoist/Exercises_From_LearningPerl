#!/usr/bin/perl -w

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



# ОПЕРАТОРЫ ПРОВЕРКИ ФАЙЛОВ

# Обратите внимание: содержимое $! не включается в сообщение die, потому что
# система в данном случае не отклонила наш запрос.

warn "Config file is looking pretty old!\n" if -M '1.3.pl' > 1;


#  Проверка существования файла осуществляется конструкцией –e:
my $filename = '1.3.pl';
 die "Oops! A file called '$filename' already exists.\n" if -e $filename;

