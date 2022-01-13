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



# File 16.2.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Измените предыдущую программу так, чтобы выходные данные команды сохранялись в файле ls.out  текущего каталога.
# Информация об ошибках должна сохраняться в файле ls.err. (Любой из этих файлов может быть пустым, никакие
# специальные действия по этому поводу не требуются.)

sub ls_l_out {
    my $dir;

        if (defined $ARGV[0]) {
            $_ = $ARGV[0];
            /^\/.*$/;
            chomp($dir = $ARGV[0]);
        }
        elsif (!defined $ARGV[0]) {
            print "Enter your disared directory : ";
            chomp($dir = <STDIN>);
        }


    open my $fh_ls_out, '+>', 'ls.out' or die "cannot open or create file ls.out: $!";
    # open my $fh_ls_err, '+>', 'ls.err' or die "cannot open or create ls.out: $!"; # some like variant
    # open my $fh_ls, '-|', "ls -l $dir 2>ls.err" or die "cannot launch ls -l: $!"; # some like variant

    # while(<$fh_ls>){ # some like variant
    #     print $fh_ls_out "$_\n";
    # }

    open my $fh_ls, '-|', "ls -l $dir 1>ls.out 2>ls.err"
        or die "cannot launch ls -l or create files ls.out, ls.err: $!";

    # system "cat ls.out && cat ls.err"; # for checking files

    close($fh_ls_out);
    close($fh_ls);
}
&ls_l_out;


=begin text

 $ perl 16.2.pl

=end text

=cut


# Верный ответ из книги:

# Here’s one way to do it:

# open STDOUT, '>', 'ls.out' or die "Can't write to ls.out: $!";
# open STDERR, '>', 'ls.err' or die "Can't write to ls.err: $!";
# chdir '/' or die "Can't chdir to root directory: $!";
# exec 'ls', '-l' or die "Can't exec ls: $!";

# The first and second lines reopen STDOUT  and STDERR  to a file
# in the current directory (before we change directories). Then,
# after the directory change, the directory listing command executes,
# sending the data back to the files opened in the original directory.
# Where would the message from the last die  go? Well, it would go into
# ls.err, of course, since that’s where STDERR  is going at that point.
# The die  from chdir would go there too. But where would the message
# go if we can’t reopen STDERR on the second line? It goes to the old
# STDERR. When reopening the three standard filehandles (STDIN, STDOUT,
# and STDERR), the old filehandles are still open.