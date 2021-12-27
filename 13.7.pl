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


# File 13.7.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


=begin text

Эти программы потенциально опасны!
Будьте осторожны и тестируйте их в пустых каталогах,
чтобы предотвратить случайное удаление полезных данных.

=end text

=cut

# Если ваша операционная система поддерживает жесткие ссылки,
# дополните программу из предыдущего упражнения так, чтобы в
# аргументах мог передаваться необязательный ключ –s;
# с этим ключом вместо жесткой ссылки должна создаваться мягкая ссылка.
# (Даже если  жесткие ссылки в системе не поддерживаются, попробуйте
# создать хотя бы мягкую ссылку.)

sub ln_hard {
    use POSIX; # to get getcwd
    use File::Basename;
    use File::Spec;

    my $basename;
    my $source;
    my $link_dest;
    my $dir;

    ($^O =~ /Win32/) ? ($dir = getcwd) =~ s/\//\\/g : ($dir = getcwd); # Account for / and \ on Win32 and non-Win32 systems
    chdir $dir; # Без полного пути к источнику, не создавалась soft link

    if ($ARGV[0] eq '-s') {
        $source = $ARGV[1];
        $link_dest = $ARGV[2];
    }
    else {
        ($source, $link_dest) = @ARGV;
    }

    if (-d $link_dest) {
        $basename = basename $source;
        $link_dest = File::Spec->catfile($link_dest, $basename);
    }

    if ($ARGV[0] eq '-s') {
        print "1. Do you want SYMLINK file '$source' to the '$link_dest' [yes/NO] ? "
            if !(-e $link_dest); # if target file doesn't exist
        print "2. Do you want REWRITE file '$link_dest' with '$source' [yes/NO] ? "
            if (-e $link_dest); # if target file already exists
        chomp(my $yesORno = <STDIN>);

        if ($yesORno =~ /[y|yes]/i) {
            unlink $link_dest;                            # unlink if target exists already
            $source = File::Spec->catfile($dir, $source); # Странно, но без этого выражения, не создавалась soft link
            symlink $source, $link_dest                   # link same like ln -s
                or die "Can't symlinks '$source' to '$link_dest': $!";
            print "The file '$source' is SYMLINKED now to '$link_dest' !\n"; # print that file was moved
            exit;                                                            # exit from the script
        }
        else {
            print "CANCELED\n"; # if not yes, not YES, not Y, not y or some other
            exit;               # Goodbye the script/
        }

    }

    print "3. Do you want hard link file '$source' to the '$link_dest' [yes/NO] ? "
        if !(-e $link_dest); # if target file doesn't exist
    print "4. Do you want REWRITE file '$link_dest' with '$source' [yes/NO] ? "
        if (-e $link_dest); # if target file already exists

    chomp(my $yesORno = <STDIN>);

    if ($yesORno =~ /[y|yes]/i) {
        unlink $link_dest;       # unlink if target exists already
        link $source, $link_dest # link same like ln
            or die "Can't hard links '$source' to '$link_dest': $!";
        print "The file '$source' is HARD LINKED now to '$link_dest' !\n"; # print that file was moved
        exit;                                                              # exit from the script
    }
    else {
        print "CANCELED\n"; # if not yes, not YES, not Y, not y or some other
        exit;               # Goodbye the script/
    }

}
ln_hard();

=begin text

$source = File::Spec->catfile($dir, $source); # Странно, но без этого выражения, не создавалась soft link

=end text

=cut


# Верный ответ из книги:

# Here’s one way to do it:

# use File::Basename; use File::Spec;
# my $symlink = $ARGV[0] eq '-s';
# shift @ARGV if $symlink;
# my($source, $dest) = @ARGV;
# if (-d $dest) {
#    my $basename = basename $source;
#    $dest = File::Spec->catfile($dest, $basename);
# }
# if ($symlink) {
#    symlink $source, $dest
#        or die "Can't make soft link from '$source' to '$dest': $!\n";
# } else {
#    link $source, $dest
#        or die "Can't make hard link from '$source' to '$dest': $!\n";
# }
#
# The first few lines of code (after the two use  declarations)
# look at the first command-line argument, and if it’s -s, we’re making
# a symbolic link, so we note that as a true value for $symlink.
# If we saw that -s, we then need to get rid of it (in the next line).
# The next few lines are cut-and-pasted from the previous exercise answers.
# Finally, based on the truth of $symlink, we’ll choose to create either a
# symbolic link or a hard link. We also updated the dying words to make it
# clear which kind of link we were attempting.