#!/usr/bin/perl -w

use 5.10.0;
# use CGI;
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


# File 13.6.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


=begin text

Эти программы потенциально опасны!
Будьте осторожны и тестируйте их в пустых каталогах,
чтобы предотвратить случайное удаление полезных данных.

=end text

=cut

# Если ваша операционная система поддерживает жесткие ссылки, напишите программу,
# имитирующую команду ln; программа должна создавать жесткую ссылку  из первого
# аргумента командной строки на второй. (Поддерживать различные ключи ln  или дополнительные
# аргументы не нужно.) Если в системе не поддерживаются жесткие ссылки, просто выведите
# сообщение о том, какая опеQ рация должна быть выполнена.
# (Подсказка: эта программа имеет нечто общее с предыдущей 13.6.pl – если вы поймете, что именно,
# это сэкономит ваше время при кодировании.)

sub ln_hard {
    use POSIX;     # to get getcwd
    use File::Basename;
    use File::Spec;

    my ($source, $link_dest) = @ARGV;
    if (-d $link_dest) {
        my $basename = basename $source;
        $link_dest = File::Spec->catfile($link_dest, $basename);
    }

    print "1. Do you want hard link file '$ARGV[0]' to the '$link_dest' [yes/NO] ? "
        if !(-e $link_dest); # if target file doesn't exist
    print "2. Do you want REWRITE file '$link_dest' with '$ARGV[0]' [yes/NO] ? "
        if (-e $link_dest); # if target file already exists

    chomp(my $yesORno = <STDIN>);

    if ($yesORno =~ /[y|yes]/i) {
        unlink $link_dest;                                                     # unlink if target exists already
        link $source, $link_dest                                               # link same like ln
            or die "Can't rename '$source' to '$link_dest': $!\n";
        print "The file '$ARGV[0]' is LINKED now to '$link_dest' !\n";              # print that file was moved
        exit;                                                                   # exit from the script

    }
    else {
        print "CANCELED\n"; # if not yes, not YES, not Y, not y or some other
        exit;               # Goodbye the script/
    }





}
ln_hard();

=begin text

Даже скучно с помощью модулей и ООП. ;-)

=end text

=cut


# Верный ответ из книги:

# Here’s one way to do it:

# use File::Basename;
# use File::Spec;

# my($source, $dest) = @ARGV;

# if (-d $dest) {
#    my $basename = basename $source;
#    $dest = File::Spec->catfile($dest, $basename);
# }
# link $source, $dest
#        or die "Can't link '$source' to '$dest': $!\n";

# As the hint in the exercise description said, this program is much like the previous one.
# The difference is that we’ll link  rather than rename. If your system doesn’t support hard links,
# you might have written this as the last statement: print "Would link '$source' to '$dest'.\n";