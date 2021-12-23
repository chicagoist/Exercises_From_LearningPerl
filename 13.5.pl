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


# File 13.5.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


=begin text

Эти программы потенциально опасны!
Будьте осторожны и тестируйте их в пустых каталогах,
чтобы предотвратить случайное удаление полезных данных.

=end text

=cut

# Напишите программу, имитирующую команду mv; программа должна переименовывать источник,
# заданный первым аргументом командной строки, в приемник, заданный вторым аргументом.
# (Поддерживать различные ключи mv  или дополнительные аргументы не нужно.)
# Помните, что в качестве приемника может быть задан каталог;
# в этом случае в новом каталоге создается файл с исходным базовым именем.

sub mv_file {
    use POSIX;     # to get getcwd
    my $start_dir; # my working directory

    ($^O =~ /Win32/) ? ($start_dir = getcwd) =~ s/\//\\/g : ($start_dir = getcwd); # Account for / and \ on Win32 and non-Win32 systems
    chdir $start_dir;                                                              # change to directory where the script launch
    $start_dir .= "/";                                                             # last character is "/" now in name of the $start_dir

    chomp(@ARGV);                                           # clean arguments
    (my $first_file_name = $ARGV[0]) =~ s/^\/.*\/(.*)$/$1/; # to take just name of file if file with full path


    if ($ARGV[1] ne $ENV{HOME}) { # if directory not '~/' need get last character '/'
        $ARGV[1] =~ s@^(/.*\w)$@$1/@;
    }
    my $target_file = $ARGV[1] . $first_file_name; # if $ARGV[1] directory without name's of new file


    # say "\$first_file_name = $first_file_name";
    # say "\$ARGV[1] = $ARGV[1]";
    # say "\$ARGV[0] = $ARGV[0]";
    # say "\$target_file = $target_file";
    # say "\$start_dir = $start_dir";

    if ((-e $ARGV[0] && -f _ && -w _ && -r _ && -o _)) { # if first file exists, a file, writable, readable and owned by the user

        if (-e $ARGV[0] && !($ARGV[1] =~ /^\/.*\/$/)) {
            # if again our first file exist and our target don’t seems like a directory
            print "1. Do you want move file '$ARGV[0]' to the '$target_file' [yes/NO] ? "
                if !(-e $target_file); # if target file not exists
            print "2. Do you want REWRITE file '$ARGV[1]$ARGV[0]' with '$ARGV[0]' [yes/NO] ? "
                if (-e $target_file); # if target-file already exists

            chomp(my $yesORno = <STDIN>);

            if ($yesORno =~ /[y|yes]/i) {# if yes. YES, y, Y#
                    rename $ARGV[0], $target_file
                    or die "Or you have no permission to move into '$ARGV[1]' or:  $!"; # rename == mv the file
                print "The file '$ARGV[0]' is MOVED to '$target_file' !\n";                 # print that file was moved
                exit;                                                                   # exit from the script

            }
            else {
                print "CANCELED\n"; # if not yes, not YES, not Y, not y or some other
                exit;               # Goodbye the script/
            }
        }
        elsif ((-e $ARGV[0]) && ($ARGV[1] =~ /^\/.*\/$/)) {# if our file exist and target SEEMS like a directory##

            print "3. Do you want move file '$ARGV[0]' to the '$target_file' [yes/NO] ? "
                if !(-e $target_file); # if target file doesn't exist
            print "4. Do you want REWRITE file '$target_file' with '$ARGV[0]' [yes/NO] ? "
                if (-e $target_file); # if target file already exists


            chomp(my $yesORno = <STDIN>);

            if ($yesORno =~ /[y|yes]/i) {
                    rename $ARGV[0], $target_file
                    or die "Or you have no permission to move into '$ARGV[1]' or:  $!"; # rename == mv the file
                print "The file '$ARGV[0]' is MOVED to '$target_file' !\n";             # print that file was moved
                exit;                                                                   # exit from the script

            }
            else {
                print "CANCELED\n"; # if not yes, not YES, not Y, not y or some other
                exit;               # Goodbye the script/
            }
        }
    }else {
        print "$! '$ARGV[0]'. ";
        exit;
    }
}
mv_file();

=begin text

6 HOURS TO CREATE THE SCRIPT !!! WHAT IS WRONG WITH ME?!!! ((((

=end text

=cut


# Верный ответ из книги:

# Here’s one way to do it:

# use File::Basename;
# use File::Spec;
#
# my ($source, $dest) = @ARGV;
# if (-d $dest) {
#     my $basename = basename $source;
#     $dest = File::Spec->catfile($dest, $basename);
# }
#
# rename $source, $dest
#     or die "Can't rename '$source' to '$dest': $!\n";

# The workhorse in this program is the last statement,
# but the remainder of the program is necessary when we are
# renaming into a directory. First, after declaring the modules
# we’re using, we name the command-line arguments sensibly.
# If $dest  is a directory, we need to extract the basename
# from the $source  name and append it to the directory ($dest).
# Finally, once $dest  is patched up if needed, the rename does the deed.