#!/usr/bin/perl

#use CGI;
#use POSIX;
#use utf8;
use 5.10.0;
use strict;
use open qw(:std :encoding(UTF-8));
use Encode qw(decode_utf8);
BEGIN{@ARGV = map decode_utf8($_, 1), @ARGV;}
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use warnings;
use utf8::all 'GLOBAL'; # пробую этот модуль вместо закомментированных выше строк
use Encode::Locale;


# File 8.6.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# This next line of code is used when you get to Chapter 9.
# my $what = 'fred|barney';

# Напишите новую программу (не тестовую!), которая выводит все входные строки,
# завершающиеся пропуском (кроме символов новой строки).
# Чтобы пропуск был виден при выводе, завершите выходную строку маркером.

my $i = 0;

open(my $fh, '<', "examples/sample_files/text_files/sample_text");
while (<$fh>) {
    chomp;
    #$_ =~ /^(?<target1>[\p{Lu}|\p{Ll}]{1}.*\N)$/;
    # if (/^(?<target2>(^|\n)[\n|\s]*)$/) {
    #     say "target2 = '$+{target2}'";
    #     say "\$& = '$&'";
    #     say "\$1 = '$1'";
    #     say "\$i = 0";
    #
    # }
    #$_ =~  s/!(^|\n)[\n\s]*/$1/g;
    #$_ =~ /^(?<target>s*)$/;
    #say "target1 = $+{target1}";

    #say $_;

    #say $_;
    # If you want to try matching strings which may contain
    # newlines, here's the trick to use: Uncomment this next
    # line, then use a pound sign ("#") wherever you mean to
    # have a newline within your data string.
    # s/#/\n/g;

    if (  /^(?<target>.*\s+)$/ || /(?<target2>\z)/ ) {

        printf("%d => ", $i++);
        say "$_#";

    }
    else {
        print "No match.\n";
    }


}
close($fh);
# Консольный вызов скрипта:
# $ cat examples/sample_files/text_files/sample_text | perl -T 8.6.pl

# Верный ответ из книги:
#Here’s one way to do it:
#
#  while (<>) {
#      chomp;
#      if (/\s\z/) {
#          print "$_#\n";
#      }
#  }
#
# We used the pound sign (#) as the marker character.