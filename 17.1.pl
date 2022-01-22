#!/usr/bin/perl -w

use 5.10.0;
# use CGI;
# use Encode qw(decode_utf8);
# use Encode qw(decode encode);
# BEGIN{@ARGV=map Encode::decode($_, 1),@ARGV;}
# BEGIN{@ARGV = map decode_utf8($_, 1), @ARGV;}
# use open qw(:std :encoding(UTF-8));
# use Encode::Locale;
# use Encode;
# use Time::Moment;
# use diagnostics;


use strict;
use warnings FATAL => 'all';
use utf8;
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use utf8::all 'GLOBAL';
use DDP;
use Data::Dumper;
use Bundle::Camelcade;
use autodie qw(:all);
our $var_global;



# File 17.1.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Напишите программу, которая читает список строк из файла (по одной строке).
# Затем пользователь вводит шаблоны, совпадения которых ищутся в строках.
# Для каждого шаблона программа должна сообщить количество строк, содержащих
# совпадения, а также вывести сами строки. Файл не должен читаться заново для каждого шаблона;
# храните строки в памяти. Имя файла можно жестко закодировать в программе. Если шаблон
# недействителен (например, если он содержит непарные круглые скобки), программа должна просто
# вывести сообщение об ошибке и разрешить пользователю ввести другой шаблон. Если пользователь
# вместо шаблона вводит пустую строку, программа завершает работу.
{
    $var_global = "globalLL";

}

sub search_templates {
    my @sample_text;
    my @matching_lines;
    my $index = 0;

    open my $fh_sample_text, '<:encoding(UTF-8)', 'examples/sample_files/text_files/sample_text'
        or die "Cannot open file for read: $!"; # open file with '<:encoding(UTF-8)' for cyrillic too.

    while (<$fh_sample_text>) { # loop for opened file
        s/^\s+(\.*)$/$1/; # cut spaces from beginning line
        push @sample_text, $_; # push to new array
    }
    close($fh_sample_text); # close opened file

    print "Enter your template: "; # template
    chomp(my $template = <STDIN>) or die "Not correct template. Stop the app"; # like wilma, fred, barney or other text

    if (!$template) { # die if template is empty
        die "Empty template. Stop the app";
    }
    else { # if template is not empty

        foreach (@sample_text) { # loop for array with lines
            if ($_ =~ /$template/ig) { # if template match for one line from array
                #print "$_\n"; # for debugging
                push @matching_lines, $_; # push line with matched template
                $index++; # increment index for each matching
            }
        }

        print "@matching_lines"; # print array with matched lines
        print "Matching template = $index\n\n"; # print index
        print "$var_global\n";

    }
}

&search_templates;


=begin text

 $ perl 17.1.pl
 Enter your template: wilma
 wilma saw this and said to betty, "you should ask barney to take
 ...
  the telephone rang. "you get that, fred," said wilma. "i'll be
 Совпадет ли он в строке Mrs. Wilma Flintstone?
 Будет ли он совпадать с wilma, но не с barney?
 Matching template = 23

=end text

=cut


# Верный ответ из книги:

# Here’s one way to do it:
# my $filename = 'path/to/sample_text';
# open my $fh, '<', $filename or die "Can't open '$filename': $!";
# chomp(my @strings = <$fh>);
# while (1) {
#     print 'Please enter a pattern: ';
#     chomp(my $pattern = <STDIN>);
#     last if $pattern =~ /\A\s*\Z/;
#     my @matches = eval {grep /$pattern/, @strings;};
#     if ($@) {
#         print "Error: $@";
#     }
#     else {
#         my $count = @matches;
#         print "There were $count matching strings:\n", map "$_\n", @matches;
#     }
#     print "\n";
# }