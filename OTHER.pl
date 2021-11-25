#!/usr/bin/perl -w

use 5.10.0;
use strict;
use open qw( :std :encoding(UTF-8) );
use Encode qw(decode_utf8);
BEGIN{ @ARGV = map decode_utf8($_, 1),@ARGV; }
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use utf8;
use warnings;
use POSIX;


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

# sub name_of_numbers {
#
#     print "Enter some numbers from 1 to 7, one per line, then press Ctrl-D:\n";
#
#     chomp( my @enterNumbers = <> );
#
#     my @listOfNumbers;
#     my $key;
#
#     (
#         $listOfNumbers[1], $listOfNumbers[2], $listOfNumbers[3],
#         $listOfNumbers[4], $listOfNumbers[5], $listOfNumbers[6],
#         $listOfNumbers[7]
#     ) = qw( fred betty barney dino wilma pebbles bamm-bamm );
#
#     foreach $key (@enterNumbers) {
#
#         print $listOfNumbers[$key] . " ";
#
#     }
#
#     # foreach (@listOfNumbers) {
#     #     print $_ . "\n";
#     # }
#
# }

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


# running_sum( 5, 6 );
# running_sum( 1..3 );
# running_sum( 4 );
# sub running_sum {
# state  $sum = 0;
# state @numbers;
# foreach my $number ( @_ ) {
# push @numbers, $number;
# $sum += $number;
# }
# say "The sum of (@numbers) is $sum";
# }
#
# while (<>) {
#
# }

# my $fred = "ggg";
# print $fred . "\n";
#
# sub larger_of_fred_or_barney {
#     my ($fred, $barney) = @_;
#     if ($fred > $barney) {
#         #print "Это большее из пары чисел : ";
#          $fred;
#     } else {
#         #print "Это большее из пары чисел : ";
#          $barney;
#     }
#
#     print "\n"; # возвращаемое значение этой функции 1. Из-за этого вызова.
# }
#print larger_of_fred_or_barney(4,44) . "\n";


# sub max {
#     # Сравните с &larger_of_fred_or_barney
#     if ($_[0] > $_[1]) {
#         $_[0];
#     } else {
#         $_[1];
#     }
# }

#print max(4);

#my $maximum = &max_better(3, 5, 10, 4, 6);
#

# sub quadratic {
#
#     my ($aa, $bb, $cc) = @_;
#
#     if ($aa == 0) {
#         print "No solution!";
#         return;
#     }
#
#     my $dd = $bb * $bb - 4 * $aa * $cc;
#     #print "\$dd - $dd\n";
#     my $sqrt_val = sqrt abs($dd);
#     #print "\$sqrt_val - $sqrt_val\n";
#
#     if ($dd > 0) {
#
#         #print "\$dd > 0\n";
#         my $rootMinus1 = -$bb + $sqrt_val;
#         my $rootPlus1 = 2 * $aa;
#         my $rootSum1 = $rootMinus1 / $rootPlus1;
#
#         my $rootMinus2 = -$bb - $sqrt_val;
#         my $rootSum2 = $rootMinus2 / $rootPlus1;
#
#         #print "\$rootSum1  = $rootSum1\n";
#         #print "\$rootSum2  = $rootSum2\n";
#
#         if ( $rootSum1 <= $rootSum2 ) {
#
#             print "$rootSum1, $rootSum2\n";
#
#         }else {
#
#             print "$rootSum2, $rootSum2\n";
#             #print "No solution!";
#         }
#
#         #print $rootSum1 . ", " . $rootSum2 . "\n";
#     }
#     elsif ($dd == 0) {
#
#         my $sumNull =  (-$bb / (2 * $aa));
#
#         print  "$sumNull\n";
#     }
#     else {
#
#         print -$bb / (2 * $aa) . ", " . $sqrt_val . ", " . -$bb / (2 * $aa) . ", " . $sqrt_val . "\n";
#     }
# }
#
#
#
#
# quadratic(-2, 0, 128);


# my @names = qw/ fred barney betty dino wilma pebbles bam-bamm dino/;
# my @result;
# which_element_is("dinoa", @names);
# sub which_element_is {
#     my($what, @array) = @_;
#     foreach (0..$#array) {  # Индексы элементов @array
#         if ($what eq $array[$_]) {
#             push @result, $_;         # Ранний возврат при успешном поиске
#         }
#     }
#      -1;                    # Элемент не найден (включение return не обязательно)
# }
#
# print "@result\n";


# sub list_from_fred_to_barney {
#
#     my($fred, $barney) = @_;
#
#     if ($fred < $barney) {
#         # Отсчет по возрастанию от $fred к $barney
#         return $fred..$barney;
#     } else {
#         # Отсчет по убыванию от $fred к $barney
#        return  reverse $barney..$fred;
#     }
# }
#
# my @list_of_numbers = list_from_fred_to_barney(21,9);
#
# foreach (@list_of_numbers) {
#
#     print wantarray ? "$_" : $_." ";
# }
# print "\n";


# sub let_routine {
#
#     my $let = 10;
# }
#
# print let_routine();


# while (defined(my $line = <STDIN>)) {
#     print "I saw $line";
# }

# while (defined(my $line = <>)) {
#     chomp($line);
#     print "It was $line that I saw!\n";
#     print "\$ARGV one = $ARGV\n";
# }


#@ARGV    = undef;


#
# my $filename = "logfile";
# open BEDROCK, ">:encoding(UTF-8)", 'logfile' || die;
# #open(fh, '<', 'logfile') or die "Can't open $filename: $!";
# #print "\$fh = $fh\n";
# while (<fh>) {
#     #работает
#     chomp;
#     #open BEDROCK, '<', 'logfile' or die;
#
#     #print(BEDROCK "$_\n");
#     print("$_\n");
#     #binmode(STDOUT, ":utf8");
#     #print BEDROCK "$_\n";
#
#     #close(BEDROCK);
# }
#close(BEDROCK);
# $ perl OTHER.pl OTHER.pl


# @ARGV = qw( first.txt OTHER.pl );  # Принудительное чтение трех файлов


# while (<>) {
#     #работает
#     chomp;
#     #   print "$_\n";
#     my $fh;
#
#     open($fh, '>>', 'logfile') or die $!;
#     #$_ = <STDIN>;
#
#     print($fh "$_\n");
#
#     close($fh);
# }


# sub logfile_name {
#     chomp(@_);
#     #open(FILE, '>', 'logfile') or die $!;
#     open(BEDROCK, '>','logfile') or die $!;
#
#         $_ = <STDIN>;
#
#         print(BEDROCK "$_\n");
# }
#
# logfile_name();


# my @array = (0..10);
# print @array;     # Вывод списка элементов
# print "\n@array\n";   # Вывод строки (содержащей интерполируемый массив)
# print reverse <>;
# print (2+3)*4;


# sub print_format {
#     my ($user, $days_to_die) = @_;
#
#     print "Первым делом, введите ваш логин : ";
#     chomp($user = <STDIN>);
#     #print "\$user = $user\n";
#     $days_to_die = rand(10);
#
#     printf "Hello, %s; your password expires in %0.1f days!\n",
#         $user, $days_to_die;
# }
#print_format();


# my @items = qw( wilma dino pebbles );
# my $format = "The items are:\n" . ("%13s\n" x @items);
# print "the format is >>$format<<\n"; # Для отладки
#printf $format, @items;
#printf "The items are:\n".("%10s\n" x @items), @items;


# sub is_interactive {
#
#     return -t STDIN && -t STDOUT;
#
# }
# my $do = 1;
# # while( is_interactive() && $do ){
#
#     print "Tell me anything: ";
#
#     my $line = <>;
#
#     print "Echo: ".$line;
#
#     $do = 0 if $line eq "bye$/";
#
# }
# print "Goodbye$/";


#open PASSWD, ">:encoding(UTF-8)", 'logfile' || die;
# if (!open PASSWD, '<:encoding(UTF-8)', "/etc/passwd") {
#     die "How did you get logged in? ($!)";
# }
# while (<PASSWD>) {
#     chomp;
#     print "$_\n";
# }

# if(@ARGV == 0) { die "Miss Arguments? usage: pick file_name line_no1 line_no2 ..."};
# state @my_list;
# foreach(0..$#ARGV) {
#     say "$_";
#     push @my_list, $ARGV[$_];
# }
# @my_list = reverse @my_list;
# print join(", ", @my_list);

my $longest = 0;
foreach my $key ( keys %ENV ) {
    my $key_length = length( $key );
    $longest = $key_length if $key_length > $longest;
}
foreach my $key ( sort keys %ENV ) {
    printf "%-${longest}s  %s\n", $key, $ENV{$key};
}

#Немного отсебятины. revers ARGV

