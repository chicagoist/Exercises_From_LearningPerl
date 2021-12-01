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

state @state_array;

open(my $fh, "<:encoding(UTF-8)", "examples/sample_files/text_files/sample_text") || die "Can't open UTF-8 encoded file: $!";

while (<$fh>) {

    foreach (<$fh>) {
        chomp;

        if (/^(?<target>[\p{Lu}|\p{Ll}]{1}.*\s)$/) {
            #if (/^(?<target>[\p{Lu}|\p{Ll}]{1}.*\s)/g) {


            $_ =~ s/\cM\cJ?//g;

            push @state_array, $_;

        }
    }
    #push @_, $_ if (!/^$/ && quotemeta(/(?<target1>[\p{Lu}|\p{Ll}]{1}.*\z)$/) );

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

    #if (quotemeta(/^(?<target2>[\p{Lu}|\p{Ll}]{1}.*\s\z)/)) {
        #if (  !/^\s*$/ ) {
        #if (!/^$/) {
        foreach (@state_array) {
            #printf("%d => ", $i++);
            #say "'$+{target2}'";
            say "$_#";
            #print "\r\$target => $+{target1}#\n";

        }
        #else {
        #print "No match. #\n";
        #}


    #}
}
close($fh);
#print join("\n", @state_array);
# Консольный вызов скрипта:
# $ cat examples/sample_files/text_files/sample_text | perl -T 8.6.pl

# 6 часов убил времени, пока понял, что такое \cm\cJ в строке и почему у меня принт строк сбивался......
# с виду, думал, минут десять потрачу.
# в самом низу файла привожу выхлоп из дебагера. СПАСИБО ему!!! Без дебагера, я так и не понял, что происходит
# под капотом.



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


# #
# legioner@GFL-PF36XFZT:~/Perl_Projects/Exercises_From_Learning_Perl$ perl  -d 8.6.pl
#
# Loading DB routines from perl5db.pl version 1.60
# Editor support available.
#
# Enter h or 'h h' for help, or 'man perldebug' for more help.
#
# main::(8.6.pl:11):      binmode(STDIN, ':utf8');
#   DB<1> n
# main::(8.6.pl:12):      binmode(STDOUT, ':utf8');
#   DB<1> n
# main::(8.6.pl:31):      my $i = 0;
#   DB<1> n
# main::(8.6.pl:32):      state @state_array;
#   DB<1> n
# main::(8.6.pl:34):      open(my $fh, "<:encoding(UTF-8)", "examples/sample_files/text_files/sample_text") || die "Can't open UTF-8 encoded file: $!";
#   DB<1> n
# main::(8.6.pl:36):      while (<$fh>) {
#   DB<1>  x \$_
# 0  SCALAR(0x1294f00)
#    -> undef
#   DB<2> n
# main::(8.6.pl:38):          foreach (<$fh>) {
#   DB<2>  x \$_
# 0  SCALAR(0x1294f00)
#    -> 'this story is rendered all in lowercase so that you can search  # вот начало проблемы: перенос строки
# '
#   DB<3> n
# main::(8.6.pl:39):              chomp;
#   DB<3>  x \$_
# 0  SCALAR(0x1c4f6f8)
#    -> "this story is rendered all in lowercase so that you can search\cM\cJ" # после chomp переноса нет, но \cM\cJ
#   DB<4> n
# main::(8.6.pl:41):              if (/^(?<target>[\p{Lu}|\p{Ll}]{1}.*\s)$/) {
#   DB<4>  x \$_
# 0  SCALAR(0x1c4f6f8)
#    -> "this story is rendered all in lowercase so that you can search\cM" # усекло один элемент \cM
#   DB<5> n
# main::(8.6.pl:45):                  $_ =~ s/\cM\cJ?//g;
#   DB<5>  x \$_
# 0  SCALAR(0x1c4f6f8)
#    -> "this story is rendered all in lowercase so that you can search\cM"
#   DB<6> n
# main::(8.6.pl:47):                  push @state_array, $_;
#   DB<6>  x \$_
# 0  SCALAR(0x1c4f6f8)
#    -> 'this story is rendered all in lowercase so that you can search' # чистая строка
#   DB<7> n
# main::(8.6.pl:39):              chomp;
#   DB<7>  x \$_
# 0  SCALAR(0x1bad250)
#    -> "for fred and barney in lowercase, as we usually do. some lines\cM\cJ"
#
