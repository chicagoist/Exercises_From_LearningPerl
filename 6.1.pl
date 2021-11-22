#!/usr/bin/perl -w

# File 6.1.pl
# https://github.com/chicagoist/Exercises_From_LearningPerl.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/

# Напишите программу, которая запрашивает у пользователя имя
# и выводит соответствующую фамилию из хеша. Используйте имена
# знакомых вам людей или (если вы проводите за компьютером
# столько времени, что не знаете живых людей) воспользуйтесь слеQ
# дующей таблицей:
#     Ввод       Вывод
#     fred       flintstone
#     barney     rubble
#     wilma      flintstone


use 5.10.0;
use strict;
# use open qw(:utf8);
# binmode(STDIN, ':utf8');
# binmode(STDOUT, ':utf8');
# use utf8;
use warnings;
use POSIX;
use utf8::all 'GLOBAL'; # пробую этот модуль вместо закомментированных выше строк

print "Введите имя для поиска :  ";
chomp(my $name = <STDIN>); # без функции chomp не работают условия в if()

my %hash_list = (fred => "flintstone", barney => "rubble", wilma => "flintstone");

while ((my $key, my $value) = each %hash_list) { # пока элементы хеша не закончатся

    if (fc($key) eq fc($name)) { # если ключ хеша совпадает с введённым именем
                                   # от себя добавил регистронезависимость
        print "$key => $hash_list{$key}\n"; # обращение непосредственно к элементу хеша
        #print "$key => $value\n"; # используя стандартные переменные
    }

}

# Верный ответ из книги:

# Here’s one way to do it:

#   my %last_name = qw{
#   fred flintstone
#   barney rubble
#   wilma flintstone
#   };

#   print "Please enter a first name: ";
#   chomp(my $name = <STDIN>);
#   print "That's $name $last_name{$name}.\n";
#
# In this one, we used a qw// list (with curly braces as the delimiter) to initialize the
# hash. That’s fine for this simple data set, and it’s easy to maintain because each
# data item is a simple given name and simple family name, with nothing tricky.
# But if your data might contain spaces—for example, if robert  de niro  or mary
# kay place were to visit Bedrock—this simple method wouldn’t work so well.
# You might have chosen to assign each key-value pair separately, something like
# this:

# my %last_name;
# $last_name{"fred"} = "flintstone";
# $last_name{"barney"} = "rubble";
# $last_name{"wilma"} = "flintstone";

# Note that (if you chose to declare the hash with my, perhaps because use strict
# was in effect) you must declare the hash before assigning any elements. You can’t
# use my on only part of a variable, like this:

# my $last_name{"fred"} = "flintstone";  # Oops!

# The my operator works only with entire variables, never with just one element of
# an array or hash. Speaking of lexical variables, you may have noticed that the lex‐
# ical variable $name  is being declared inside the chomp  function call; it is fairly
# common to declare each my variable as you need it, like this.
# This is another case where chomp  is vital. If someone enters the five-character
# string "fred\n"  and we fail to chomp  it, we’ll be looking for "fred\n"  as an ele‐
# ment of the hash—and it’s not there. Of course, chomp alone won’t make this bul‐
# letproof; if someone enters "fred \n"  (with a trailing space), with what we’ve
# seen so far, we don’t have a way to tell that they meant fred.
# If you added a check for whether the given key exists in the hash so that you’ll
#     give the user an explanatory message when they misspell a name, give yourself
#     extra points for that.