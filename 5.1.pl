#!/usr/bin/perl -w

# File 5.1.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


use 5.10.0;
use strict;
use open qw(:utf8);
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use utf8;
use warnings;

# Write a program that acts like cat  but reverses the order of the output lines.
# (Some systems have a utility like this named tac.) If you run yours as ./tac fred
# barney betty, the output should be all of file betty  from last line to first, then
# barney, and then fred, also from last line to first. (Be sure to use the ./  in your
# program’s invocation if you call it tac  so that you don’t get the system’s utility
# instead!)


sub reverse_stdout {

    print reverse @_;

}


reverse_stdout(<>);



# Верный ответ из книги:

# Here’s one way to do it:
#
#    print reverse <>;
#
# Well, that’s pretty simple! But it works because print  is looking for a list of
# strings to print, which it gets by calling reverse in a list context. And reverse is
# looking for a list of strings to reverse, which it gets by using the diamond opera‐
# tor in a list context. So, the diamond returns a list of all the lines from all the files
# of the user’s choice. That list of lines is just what cat  would print out. Now
# reverse reverses the list of lines, and print prints them out.