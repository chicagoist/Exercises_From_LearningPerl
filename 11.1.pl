#!/usr/bin/perl -w

use 5.10.0;
#use CGI;
#use POSIX;
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


# File 11.1.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Install the Module::CoreList module from CPAN (if you don’t already have it).
# Print a list of all the modules that came with v5.34. To build a hash whose
# keys are the names of the modules that came with a given version of perl,
#
# use this line: my %modules = %{ $Module::CoreList::version{5.034} };

# Авторы не учли такой мелочи:
#           Use of uninitialized value $module{"Pod::Simple::JustPod"} in concatenation (.) or string

sub modules_corelist {
    use Module::CoreList;

    my $index = 1;
    my %module = %{$Module::CoreList::version{5.034}};

    foreach (sort keys %module) {
        $module{$_} = $module{$_} // ' uninitialized value'; # Use of uninitialized value $module{"Pod::Simple::JustPod"} in concatenation (.) or string

            print "$index: $_ => $module{$_} \n";
            $index++;
    }
    print "\$index =  " , $index - 1 , "\n";
}

&modules_corelist;

# 379 :Pod::Simple::HTMLLegacy => 5.01
# 380 :Pod::Simple::JustPod =>  uninitialized value  <---- THIS
# 381 :Pod::Simple::LinkSection => 3.42



# Верный ответ из книги:

# This answer uses a hash reference (which you’ll have to read about in Intermediate Perl),
# but we gave you the part to get around that. You don’t have to know how it all works as
# long as you know it does work. You can get the job done and learn the details later.
# Here’s one way to do it:

# use Module::CoreList;
# my %modules = %{$Module::CoreList::version{5.034}};
# print join "\n", keys %modules;

# And here’s a bonus. With Perl’s postderef feature,
# you could write this:

# use v5.20;
# use feature qw(postderef);
# no warnings qw(experimental::postderef);
# use Module::CoreList;
# my %modules = $Module::CoreList::version{5.034}->%*;
# print join "\n", keys %modules;

# See the blog post “Use postfix dereferencing” for more information.
# Or wait until we release the third edition of Intermediate Perl,
# which we will update with this new feature.
# We’ll start working on it right after we finish this book.
