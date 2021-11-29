#!/usr/bin/perl -w

use 5.10.0;
use strict;
use open qw(:std :encoding(UTF-8));
use Encode qw(decode_utf8);
BEGIN{@ARGV = map decode_utf8($_, 1), @ARGV;}
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use utf8;
use warnings;
use POSIX;
use utf8::all 'GLOBAL'; # пробую этот модуль вместо закомментированных выше строк

# File 8.1.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# This next line of code is used when you get to Chapter 9.
my $what = 'fred|barney';

while (<>) {
    chomp;
    # If you want to try matching strings which may contain
    # newlines, here's the trick to use: Uncomment this next
    # line, then use a pound sign ("#") wherever you mean to
    # have a newline within your data string.
    # s/#/\n/g;

    if (/YOUR_PATTERN_GOES_HERE/) {
        print "Matched: |$`<$&>$'|\n";
        # If you need these for testing patterns with
        # memories, uncomment them as well
        # print "    And memory one got <$1>\n";
        # print "    And memory two got <$2>\n";
    } else {
        print "No match.\n";
    }

}



# Верный ответ из книги:

#Here’s one way to do it:
# while (<>) {
#     if (/wilma/) {
#         if (/fred/) {
#             print;
#         }
#     }
# }
#
# This tests /fred/  only after we find /wilma/  matches,
# but fred  could appear before or after wilma in the line;
# each test is independent of the other. If you wanted to
# avoid the extra nested if test, you might have written something like this:
#
# while (<>) {
#     if (/wilma.*fred|fred.*wilma/) {
#         print;
#     }
# }
#
# This works because you’ll either have wilma before fred or fred before wilma.
# If we had written just /wilma.*fred/, that wouldn’t have matched a line like fred
# and wilma flintstone, even though that line mentions both of them.
# Folks who know about the logical-and operator, which we showed in Chapter 10,
# could do both tests /fred/ and /wilma/ in the same if conditional.
# That’s more efficient, more scalable, and an all-around better way than
# the ones given here. But we haven’t seen logical-and yet:
#
# while (<>) {
#     if (/wilma/ && /fred/) {
#         print;
#     }
# }
#
# The low-precedence short-circuit version works too:
#
# while (<>) {
#     if (/wilma/ and /fred/) {
#         print;
#     }
# }

# We made this an extra-credit exercise because many folks have a mental block here.
# We showed you an “or” operation (with the vertical bar, |), but we never
# showed you an “and” operation. That’s because there isn’t one in regular expressions.
# Mastering Perl  revisits this example by using a regular expression look‐ ahead,
# something even a bit too advanced for Intermediate Perl.
