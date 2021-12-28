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
# use Time::Moment;
# use diagnostics;


use strict;
use warnings FATAL => 'all';
use utf8;
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use DDP;
use Data::Dumper;



# File 13.8.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


=begin text

Эти программы потенциально опасны!
Будьте осторожны и тестируйте их в пустых каталогах,
чтобы предотвратить случайное удаление полезных данных.

=end text

=cut

# Если ваша операционная система поддерживает такую возможность,
# напишите программу для поиска символических ссылок в текущем
# каталоге и вывода их значений (по аналогии с тем, как это делает
# ls –l: имя -> значение).

sub ln_search {
    use POSIX; # to get getcwd
    my $dir;

    ($^O =~ /Win32/) ? ($dir = getcwd) =~ s/\//\\/g : ($dir = getcwd); # Account for / and \ on Win32 and non-Win32 systems
    chdir $dir;
    chomp(@ARGV);

    foreach (@ARGV) {
        if (readlink $_) {
            #(my $read_dest = readlink $_) =~ s/\/\//\//g; # without the regex we have double slashes: "Learning_Perl//home/user/error.txt"
            (my $read_dest = readlink $_) =~ s/$dir\///g; # without the regex we have double slashes: "//home/user/error.txt"
            print "$_ -> " , $read_dest , "\n";
        }
    }

}
ln_search();

=begin text

        # OUT must like that:

        8.1_for_debug.pl_LINK -> 8.1_for_debug.pl
        examples_Soft_Link -> examples
        out.txt_Soft_Link -> out.txt
        symlink_error.txt -> /home/user/error.txt

=end text

=cut


# Верный ответ из книги:

# Here’s one way to do it:

# foreach ( glob( '.* *' ) ) {
# my $dest = readlink $_;
# print "$_ -> $dest\n" if defined $dest;
# }

# Each item resulting from the glob ends up in $_
# one by one. If the item is a symbolic link, then readlink
# returns a defined value, and the location is displayed.
# If not, the condition fails and we skip over it.