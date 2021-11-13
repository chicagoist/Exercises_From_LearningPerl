#!/usr/bin/perl -w


use 5.10.0; #для того чтобы можно было использовать полезные функции из новых версий. Например, say
use strict;

use utf8;
use open qw( :std :encoding(UTF-8) );
use warnings;


# my @rocks = ();
# my $first;
# my $second;

# ($first, $second) = qw( привет пока перл валера );

# $rocks[99] = 99;
# $rocks[0] = "нулевой";
# #$list[0..3] = qw(привет пока перл валера);

# print "\n" . $rocks[-100] . "\n";
# #print "\n" . $#rocks . "\n";
# print "\n" . $rocks[(0, $#rocks)] . "\n";
# #$rocks[-101];
# print (0..10);
# print  $first . "\n" . $second . "\n";
# @rocks = qw(привет пока перл валера );
# foreach my $key (@rocks) {
#     print "\n" . $key;
# }

# print "\n";

# print(pop @rocks);

# foreach my $key (@rocks) {
#     print "\n" . $key;
# }

# print "\n";

# my @fred = qw(один два три);
# my $fred = "четыре";

# print "Массив1 $fred[2]\n";
# print "Массив2 ${fred}[2]\n";

# print "Массив3 $fred"."[2]\n";
# print "Массив4 $fred\[2]\n";

# my @rocksS = qw( talc quartz jade obsidian );
# print "How many rocks do you have?\n";
# print "I have ", scalar @rocksS, " rocks!\n";

# chomp(my @lines = <STDIN>);
# @lines = reverse @lines;

# foreach (@lines) {
# print $_ . "\n";0

# }

#print reverse <STDIN>; Или так

sub name_of_numbers {

    print "Enter some numbers from 1 to 7, one per line, then press Ctrl-D:\n";

    chomp( my @enterNumbers = <> );

    my @listOfNumbers;
    my $key;

    (
        $listOfNumbers[1], $listOfNumbers[2], $listOfNumbers[3],
        $listOfNumbers[4], $listOfNumbers[5], $listOfNumbers[6],
        $listOfNumbers[7]
    ) = qw( fred betty barney dino wilma pebbles bamm-bamm );

    foreach $key (@enterNumbers) {

        print $listOfNumbers[$key] . " ";

    }

    # foreach (@listOfNumbers) {
    #     print $_ . "\n";
    # }

}

#name_of_numbers();

# sub sort_ansii {

#     my @enterWords;

#     print "Enter some words, one per line, then press Ctrl-D:\n";

#     chomp( @enterWords = <> );

#     @enterWords = sort(@enterWords);

#     print "@enterWords" . " ";

#     #fred, barney, wilma и betty

#     4 - 4;

#     print "Hey, I'm returning a value now!\n";      # Ой!
# }

# print sort_ansii;

# sub max {

#     # Сравните с &larger_of_fred_or_barney
#     if ( $_[0] > $_[1] ) {
#         $_[0];
#     }
#     else {
#         $_[1];
#     }
# }

# sub max_1 {

# #   my($m, $n);       # Новые, приватные переменные для этого блока
# #   ($m, $n) = @_;    # Присваивание имен параметрам

#     my ( $m, $n ) = @_; # Присваивание имен параметрам

#     if   ( $m > $n ) { $m }
#     else             { $n }
# }

#print &max_1(-1, -2) . "\n";

#my $maximum = &max_max( 3, 5, 10, 4, 6 );

#print &max_max;

# sub max_max {

#     chomp( @_ = <> );

#     my ($max_so_far) =
#       shift @_;    # Пока сохраняем как максимальный
#                    # первый элемент
#     foreach (@_)
#     {    # Просмотреть все остальные аргументы
#         if ( $_ > $max_so_far )
#         { # Текущий аргумент больше сохраненного?
#             $max_so_far = $_;
#         }
#     }
#     $max_so_far;
# }

# sub search_a_word {
#     $_ = "This is a dog. It is big and black.  Odograph is instrument for recording courses steered by a vessel with the distances or lengths of time run on each.";

#     print $_ . "\n";

#     my $DOG = " DOG";

#     my $key = rindex( $_, " dog" );

#     substr( $_, $key, 4 ) = $DOG;

#     print $_ . "\n";

# }

# &search_a_word;

# use lib '/home/legioner/perl5/lib/perl5';



# my $maximum = &max(3, 5, 10, 4, 6);

# sub max {

    


#     #(@_) = <>;

#     my ($max_so_far) = shift @_;    # Пока сохраняем как максимальный

#     if ( !@_ ) {

#         $max_so_far = "Массив пуст";
#     }

#     # первый элемент
#     foreach (@_) {                  # Просмотреть все остальные аргументы
#         if ( $_ > $max_so_far ) {    # Текущий аргумент больше сохраненного?
#             $max_so_far = $_;
#         }
#     }

#     print "\nМаксимальное значение из чисел = " . $max_so_far;
# }

# print "\nМаксимальное значение из чисел = " . max;
use 5.10.0; 


running_sum( 5, 6 ); 
running_sum( 1..3 ); 
running_sum( 4 ); 
sub running_sum {
state  $sum = 0;
state @numbers;
foreach my $number ( @_ ) {
push @numbers, $number;
$sum += $number;
}
say "The sum of (@numbers) is $sum";
}

while (<>) {

}
