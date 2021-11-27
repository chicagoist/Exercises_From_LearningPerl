#!/usr/bin/perl -w
#===============================================================================
#
#         FILE:  stepik_3.2.pl
#
#        USAGE:  ./stepik_3.2.pl
#
#  DESCRIPTION:  
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Valerii Dubkoff
#      COMPANY:  
#      VERSION:  1.0
#      CREATED:  24.11.2021 21:10:24
#     REVISION:  ---
#===============================================================================

# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


use 5.10.0;
use strict;
use open qw(:std :encoding(UTF-8));
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use utf8;
use warnings;
use POSIX;



#
# https://stepik.org/lesson/51555/step/3?auth=login&unit=29819
# Напишите программу валидатор Российских номеров в формате +7 (xxx) xxx-xx-xx
# Sample Input 1:
# +7 (999) 999-99-99
# Sample Output 1:
# OK
# .....................
# Sample Input 2:
# +79999999999
# Sample Output 2:
# Not OK




my $input = <>;
print $input =~ /^(?!\W$)(\+7\s{1}[(]{1}[0-9]{3}[)]{1}\s{1}[0-9]{3}[-]{1}[0-9]{2}[-]{1}[0-9]{2})$/ ? "OK\n" : "Not OK\n";

#print $input =~ /^(?!\W$)(\+7\s?[(]?[0-9]{3}[)]?\s?[0-9]{3}[-| ]?[0-9]{2}[-| ]?[0-9]{2})$/ ?  "OK\n" : "Not OK\n";
# тут пробовал +79999999999 или +7 999 999 99 99 но не более одного пробела или одного минуса
# но это не ТЗ в задаче


