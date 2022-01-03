#!/usr/bin/perl -w

# File 4.1_max.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


#use 5.20.0;
use strict;
use open qw(:utf8);
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use utf8;
use warnings;

=begin text

 Subroutine for require in Chapter 15

=end text

=cut


use experimental qw(signatures);
sub max(@rest) {
    my $max_so_far = 0;
    foreach (@rest) {
        if ($_ > $max_so_far) {
            $max_so_far = $_;
        }
    }
    # print $max_so_far, "\n";
    return $max_so_far;
}

# sub max {
#     foreach my $number (@_) {
#         chomp($number);
#         if ($number > $max_so_far) {
#             $max_so_far = $number;
#         }
#     }
#     print $max_so_far;
# }
# max(<STDIN>);

# max();