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


# File 12.2.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Напишите программу, которая определяет самый старый файл из списка,
# переданного в командной строке, и сообщает его «возраст» в днях.
# Что сделает ваша программа, если список пуст (то есть командная строка не содержит ни одного файла)?


sub files_oldest {
    chomp(@ARGV);

    my @original_files = grep -f, @ARGV;
    state @big_old_files;
    my $file_days = 0;
    my $max_days = 0;
    my %days_hash;
    foreach my $filename (@original_files) {

        # $file_days = int(-M $filename);
        $file_days = -M $filename;
        $days_hash{$filename} = $file_days;

    }

    foreach my $key (sort keys %days_hash) {

        if ($days_hash{$key} >= $max_days) {
            $max_days = $days_hash{$key};

            shift @big_old_files; # without shift we will see ALL old files with sames days

            push(@big_old_files, "$key already  $max_days days old");

        }
    }

    p % days_hash;
    print "\n\n";
    print join("\n", @big_old_files);
    print "\n\n";

    foreach my $i (sort keys %days_hash) {

        printf("File %s already %.2f days old\n", $i, $days_hash{$i});
    }

    print "\n";

}

files_oldest();


# Верный ответ из книги:

# Here’s one way to do it:

# die "No file names supplied!\n" unless @ARGV;
# my $oldest_name = shift @ARGV;
# my $oldest_age = -M $oldest_name;
#
# foreach (@ARGV) {
#     my $age = -M;
#     ($oldest_name, $oldest_age) = ($_, $age)
#         if $age > $oldest_age;
# }
# printf "The oldest file was %s, and it was %.1f days old.\n", $oldest_name, $oldest_age;

# This one starts right out by complaining if it didn’t get any filenames on the command line.
# That’s because it’s supposed to tell us the oldest filename—and there ain’t one if there aren’t
# any files to check. Once again, we’re using the “high-water mark” algorithm. The first file is
# certainly the oldest one seen so far. We have to keep track of its age as well so that’s in $oldest_age.
# For each of the remaining files, we’ll determine the age with the -M file test, just as we did for
# the first one (except that here we’ll use the default argument of $_ for the file test).
# The last-modified time is generally what people mean by the “age” of a file, although you could
# make a case for using a different one. If the age is more than $oldest_age, we’ll use a list assignment
# to update both the name and age. We didn’t have to use a list assignment, but it’s a convenient way to
# update several variables at once. We stored the age from -M in the temporary variable $age. What would have
# happened if we had simply used -M  each time, rather than using a variable? Well, first, unless
# we used the special _ filehandle, we would have been asking the operating system for the age of the
# file each time, a potentially slow operation (not that you’d notice unless you have hundreds or thousands
# of files, and maybe not even then). More importantly, though, we should consider what would happen if
# someone updated a file while we were checking it. That is, first we see the age of some file,
# and it’s the oldest one seen so far. But before we can get back to use -M a second time, someone
# modifies the file and resets the timestamp to the current time. Now the age that we save into $oldest_age
# is actually the youngest age pos‐ sible. The result would be that we’d get the oldest file among the
# files tested from that point on, rather than the oldest overall; this would be a tough problem to debug!
# Finally, at the end of the program, we use printf to print out the name and age, with the age rounded off
# to the nearest tenth of a day. Give yourself extra credit if you went to the trouble to convert the age to
# a number of days, hours, and minutes.