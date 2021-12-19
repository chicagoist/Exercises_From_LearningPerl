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
# use Time::Moment;


# File 12.1.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Напишите программу, которая получает в командной строке список файлов и для каждого файла сообщает,
# доступен ли он для чтения, записи, исполнения или не существует. (Подсказка: напишите функцию,
# которая будет при вызове выполнять все проверки для одного файла.) Что сообщит функция о файле,
# которому командой chmod было присвоено значение 0? (Если вы работаете в системе UNIX, используйте команду
# chmod 0 some_file, чтобы запретить чтение, запись и исполнение файла.) Во многих командных процессорах
# звездочка в аргументах запуска обозначает все обычные файлы в текущем каталоге.
# Иначе говоря, команда вида ./ex12-1 * запрашивает у программы атрибуты сразу нескольких файлов.


sub files_stat {
    chomp(@ARGV);

    foreach my $file (@ARGV) {

        if (-d $file) {
            print "Directory '$file' exist";
            print ", readable" if -r _;
            print ", writable" if -w _;
            print "\n";

        }
        elsif (-f _) {
            print "File '$file' exist";
            print ", readable" if -r _;
            print ", writable" if -w _;
            print ", executable" if -x _;
            print "\n";

        }else {
            print "Something is wrong with '$file' \n";
        }


    }

}

files_stat();


# Я два часа потратил на установку этого модуля. Так и не понял, что за ошибка, но Time инсталлировался,
# а Moment нет. Пришлось скачать исходник инсталлировать вручную через perl MakeFile.PL
# Сложное задание.


# Верный ответ из книги:

# Here’s one way to do it:

# foreach my $file (@ARGV) {
#     my $attribs = &attributes($file);
#     print "'$file' $attribs.\n";
# }
#
# sub attributes {
#     # report the attributes of a given file
#     my $file = shift @_;
#     return "does not exist" unless -e $file;
#     my @attrib;
#     push @attrib, "readable" if -r $file;
#     push @attrib, "writable" if -w $file;
#     push @attrib, "executable" if -x $file;
#
#     return "exists" unless @attrib;
#     'is ' . join " and ", @attrib; # return value
# }

# In this solution, once again it’s convenient to use a subroutine.
# The main loop prints one line of attributes for each file, perhaps
# telling us that 'cereal-killer' is executable or that 'sasquatch' does not exist.
# The subroutine tells us the attributes of the given filename. Of course, if the file
# doesn’t even exist, there’s no need for the other tests, so we test for that first.
# If there’s no file, we’ll return early. If the file does exist, we’ll build a list of
# attributes. (Give yourself extra-credit points if you used the special _ filehandle
# instead of $file on these tests, to keep from calling the system separately for each
# new attribute.) It would be easy to add additional tests like the three we show here.
# But what happens if none of the attributes is true? Well, if we can’t say anything else,
# at least we can say that the file exists, so we do. The unless clause uses the fact that
# @attrib will be true (in a Boolean context, which is a special case of a scalar context)
# if it’s got any elements. But if we’ve got some attributes, we’ll join them with " and "
# and put "is "  in front, to make a description like is readable and writable.
# This isn’t perfect, however; if there are three attributes, it says the file is readable and writable
# and executable, which has too many ands, but we can get away with it. If you wanted to add more
# attributes to the ones this program checks for, you should