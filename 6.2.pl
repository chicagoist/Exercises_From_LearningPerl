#!/usr/bin/perl -w

# File 6.2.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/

# Напишите программу, которая читает серию слов (по одному
# слову в строке 1 ), а затем выводит сводку с количеством вхождений
# каждого слова. (Подсказка: помните, что при использовании undef
# как числа Perl автоматически преобразует его в 0. Если понадобится,
# вернитесь к более раннему упражнению с накоплением суммы.)
# Так, на вход поступают слова fred, barney, fred, dino, wilma, fred (каждое
# слово в отдельной строке); на выходе программа должна сообщить,
# что fred встречается 3 раза. Чтобы задание стало более интересным,
# отсортируйте сводку по ASCII кодам.


use 5.10.0;
use strict;
use open qw(:utf8);
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use utf8;
use warnings;
use POSIX;
#use utf8::all 'GLOBAL'; # пробую этот модуль вместо закомментированных выше строк

print "Введите имена для поиска и нажмите Ctl+D :  \n";
my %hash_names;
my @arr_name;
my @arr_static;
chomp(@arr_name = <STDIN>);

# @arr_name  = qw(fred barney fred dino wilma fred валерий); # для дебага
# @arr_name = qw/валерий юрий валерий александр юрий саша гриша/; # для дебага utf8

for (my $i = 0; $i < scalar @arr_name; $i++) { # создаём хеш из введённых слов, сразу удаляя дубли слов.
    $hash_names{$arr_name[$i]} = 0;            # значение повторов слов в хеше, пока нулевое
    #say $i; # ok дебаг
}

while ((my $key, my $value) = each %hash_names) { # перебираем пары хеша
    #print "$key => $value\n";

    foreach my $name_key (@arr_name) { # запускаем цикл по массиву всех введённых слов. массив как есть = с дублями.
        #say $name_key; # ok дебаг

        if ($name_key eq $key) {    # если находим совпадение значений массива со значением ключа в хеше,
            $hash_names{$key} += 1; # тогда значение данного ключа хеша итерируем
        }

    }

}

while ((my $key, my $value) = each %hash_names) {# готовим наш новый хеш к выводу на экран, пары ключ/значение из хеша
                                                  # переносим в массив

    my $hash_string = $key . " = " . $value; # создаём строку со значениями пары ключ/значение, которую будем выводить
                                              # на экран через массив

    push @arr_static, $hash_string; # вносим в массив строку с именем и значением, уже как значение элемента массива.

}

print join("\n", sort {$a cmp $b} @arr_static); # с помощью функции sort и разделителя join построчно выводим
                                                  # в алфавитном порядке количество имён, которые появлялись.


# Верный ответ из книги:

# Here’s one way to do it:
#
#   my(@words, %count, $word);     # (optionally) declare our variables
#   chomp(@words = <STDIN>);
#   foreach $word (@words) {
#       $count{$word} += 1;          # or $count{$word} = $count{$word} + 1;
#   }
#   foreach $word (keys %count) {  # or sort keys %count
#         print "$word was seen $count{$word} times.\n";
#   }
#
# In this one, we declared all of the variables at the top. People who come to Perl
#     from a background in languages like Pascal (where variables are always declared
# “at the top”) may find that way more familiar than declaring variables as they are
#     needed. Of course, we’re declaring these because we’re pretending that use
#     strict may be in effect; by default, Perl won’t require such declarations.
#     Next we use the line-input operator, <STDIN>, in a list context to read all of the
#     input lines into @words, and then we chomp those all at once. So @words is our list
# of words from the input (if the words were all on separate lines, as they should
#     have been, of course).
# Now the first foreach  loop goes through all the words. That loop contains the
#     most important statement of the entire program, the statement that says to add
#         one to $count{$word}  and put the result back in $count{$word}. Although you
#     could write it either the short way (with the +=  operator) or the long way, the
#     short way is just a little bit more efficient, since Perl has to look up $word in the
#     hash just once. For each word in the first foreach  loop, we add one to
#     $count{$word}. So, if the first word is fred, we add one to $count{"fred"}. Of
#     course, since this is the first time we’ve seen $count{"fred"}, it’s undef. But since
# we’re treating it as a number (with the numeric +=  operator, or with +  if you
#     wrote it the long way), Perl converts undef to 0 for us automatically. The total is
#     1, which is then stored back in $count{"fred"}.
#     The next time through that foreach loop, let’s say the word is barney. So, we add
# one to $count{"barney"}, bumping it up from undef to 1 as well.
#     Now let’s say the next word is fred again. When we add one to $count{"fred"},
# which is already 1, we get 2. This goes back in $count{"fred"}, meaning that
#     we’ve now seen fred twice.
#     When we finish the first foreach loop, then, we’ve counted how many times each
#     word has appeared. The hash has a key for each (unique) word from the input,
#     and the corresponding value is the number of times that word appeared.
#     So now, the second foreach  loop goes through the keys of the hash, which are
#     the unique words from the input. In this loop, we’ll see each different word once.
#     For each one, it says something like “fred was seen 3 times.”
# If you want the extra credit on this problem, you could put sort  before keys  to
#     print out the keys in order. If there will be more than a dozen items in an output
#         list, it’s generally a good idea for them to be sorted so that a human being who is
#     trying to debug the program will fairly quickly be able to find the item they want.