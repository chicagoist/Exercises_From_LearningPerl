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


# File 17.3.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Modify your answer to 17.2.pl to report the times using the YYYY-MM-DD format.
# Use a map with localtime and a slice to turn the epoch times into the date strings
# that you need. Note the localtime  documentation about the year and month values it
# returns. Your report should look like this:
# fred.txt          2011-10-15        2011-09-28
# barney.txt        2011-10-13        2011-08-11
# betty.txt         2011-10-15        2010-07-24

# Использовал эту книгу:
# https://docstore.mik.ua/orelly/perl/cookbook/ch03_02.htm

sub access_modifc_time {


    while (<*>) {

        my ($day_a, $month_a, $year_a) = map {(localtime($_))[3, 4, 5]} (stat $_)[8];
        my ($day_m, $month_m, $year_m) = map {(localtime($_))[3, 4, 5]} (stat $_)[9];

        if (length($_) <= 25) { # для наглядность убрал слишком длинные имена файлов

            printf("%-25s\t %04d-%02d-%02d\t %04d-%02d-%02d\n", $_, $year_a + 1900, $month_a + 1, $day_a, $year_m + 1900, $month_m + 1, $day_m);

        }
        # print "\$year_a = $year_a\n \$month_a = $month_a\n \$day_a = $day_a\n";
    }

}

&access_modifc_time;



=begin text

 $ perl 17.3.pl
 ...
 1.3.pl                           2022-01-21      2021-12-20
 10.1.pl                          2022-01-21      2021-12-19
 10.2.pl                          2022-01-21      2021-12-13
 10.3.pl                          2022-01-21      2021-12-13
 11.1.pl                          2022-01-21      2021-12-16
 ...
 16.3.pl                          2022-01-21      2022-01-13
 17.1.pl                          2022-01-21      2022-01-21
 17.2.pl                          2022-01-21      2022-01-21
 17.3.pl                          2022-01-21      2022-01-21
 2minus.pl                        2022-01-21      2021-12-20
 ...

=end text

=cut


# Верный ответ из книги:

# This solution builds on the previous one. The trick now is to use localtime
# to turn the epoch times into date strings in the form YYYY-MM-DD. Before we
# integrate that into the full program, let’s look at how we would do that,
# assuming that the time is in $_ (which is the map control variable). We get
# the indices for the slice from the localtime documentation:

# my( $year, $month, $day ) = (localtime)[5,4,3];

# We note that localtime returns the year minus 1900 and the month minus 1
# (at least minus 1 how we humans count), so we have to adjust that:

# $year += 1900; $month += 1;

# Finally, we can put it all together to get the format we want, padding the
# month and day with zeros if necessary:

# sprintf '%4d-%02d-%02d', $year, $month, $day;

# To apply this to a list of times, we use a map. Note that localtime  is one
# of the operators that doesn’t use $_ by default, so you have to supply it as
# an argument explicitly:

# my @times = map {my( $year, $month, $day ) = (localtime($_))[5,4,3];
# $year += 1900; $month += 1;
# sprintf '%4d-%02d-%02d', $year, $month, $day;
# } @epoch_times;

# This, then, is what we have to substitute in our stat  line in the previous program,
# finally ending up with:

# foreach my $file ( glob( '*' ) ) {
# my( $atime, $mtime ) = map {my( $year, $month, $day ) = (localtime($_))[5,4,3];
# $year  += 1900; $month += 1;sprintf '%4d-%02d-%02d', $year, $month, $day;
# } (stat $file)[8,9];
# printf "%-20s %10s %10s\n", $file, $atime, $mtime;}

# Most of the point of this exercise was to use the particular techniques we covered
# in Chapter 16. There’s another way to do this, though, and it’s much easier.
# The POSIX  module, which comes with Perl, has a strftime  subroutine that takes
# a sprintf-style format string and the time components in the same order that localtime
# returns them. That makes the map much simpler:

# use POSIX qw(strftime);
# foreach my $file ( glob( '*' ) ) {
# my( $atime, $mtime ) = map {strftime( '%Y-%m-%d', localtime($_) );
# } (stat $file)[8,9];printf "%-20s %10s %10s\n", $file, $atime, $mtime;
# }