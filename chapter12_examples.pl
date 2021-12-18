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


# ОПЕРАТОРЫ ПРОВЕРКИ ФАЙЛОВ
{
    # Обратите внимание: содержимое $! не включается в сообщение die, потому что
    # система в данном случае не отклонила наш запрос.

    warn "Config file is looking pretty old!\n" if -M '1.3.pl' > 1;


    #  Проверка существования файла осуществляется конструкцией –e:
    my $filename = '1.3.pl';
    warn "Oops! A file called '$filename' already exists.\n\n" if -e $filename;
    # die "Oops! A file called '$filename' already exists.\n\n" if -e $filename;
}


{
    #  So let’s go through our list of files to see which of them are larger than 100 K. But even if a
    # file is large, you shouldn’t warehouse it unless it hasn’t been accessed in the last 90 days
    # (so we know that it’s not used too often). The -s  file test operator, instead of returning true or false,
    # returns the file size in bytes (and an existing file might have 0 bytes):

    my @original_files = grep -f, <*>;
    my @big_old_files; # The ones we want to put on backup tapes
    foreach my $filename1 (@original_files) {
        push @big_old_files, $filename1
            if -s $filename1 > 10_000 and -M $filename1 > 5;
    }
    foreach (@big_old_files) {
        print "Big and Old: $_\n";
    }

    # Если при проверке файла не указано имя файла или дескриптор (то есть при простом вызове вида –r или –s),
    # по умолчанию в качестве опеQ ранда используется файл, имя которого содержится в $_.
    foreach (@big_old_files) {
        # my $size_in_K = -s /1000;      # Сюрприз! NOT WORK
        my $size_in_k = (-s) / 1024; # По умолчанию используется $_
        # Конечно, явная передача параметра исключает любые недоразумения при проверке.
        print "$_ is readable\n" if -r; # same as -r $_
        say "$_ = $size_in_k";
    }

}


# {
#     # ПРОВЕРКА НЕСКОЛЬКИХ АТРИБУТОВ ОДНОГО ФАЙЛА
#
#     # Объединение нескольких файловых проверок позволяет создавать сложные логические условия.
#     # Предположим, программа должна выполнить некую операцию только с файлами, доступными как
#     # для чтения, так и для записи. Проверки атрибутов объединяются оператором and:
#     if (-r $file and -w $file) {...}
#
#     # Виртуальный файловый дескриптор _ (просто символ подчеркивания) использует информацию,
#     # полученную в результате выполнения последнего оператора проверки файла. Теперь Perl
#     # достаточно запросить информацию о файле всего один раз:
#     if (-r $file and -w _) {...}
#
#     # Для использования _ проверки файлы необязательно располагать рядом друг с другом.
#     # Здесь они размещаются в разных условиях if:
#     if (-r $file) {
#         print "The file is readable!\n";}
#
#     if (-w _) {
#         print "The file is writable!\n";
#     }
#
#     # При возврате и выполнении другой проверки файловый дескриптор _ содержит не данные $file,
#     # как мы ожидаем, а данные $other_file:
#     my $other_file;
#     if (-r $file) {
#         print "The file is readable!\n";
#     }
#
#     lookup($other_file);
#
#     if (-w _) {
#         print "The file is writable!\n";
#     }
#
#     sub lookup {
#         return -w $_[0];
#     }
#
# }

# СГРУППИРОВАННАЯ ПРОВЕРКА ФАЙЛОВ

{
    print "\n\nСГРУППИРОВАННАЯ ПРОВЕРКА ФАЙЛОВ\n\n";
    # До выхода Perl 5.10, если вы хотели одновременно проверить несколько атрибутов файла,
    # это приходилось делать по отдельности (даже при том, что дескриптор _ избавлял вас от части работы).
    # мы хотим узнать, доступен ли файл для чтения и записи одновременно. Для этого необходимо сначала
    # выполнить проверку на чтение, а затем проверку на запись:
    my $file = '1.3.pl';
    if (-r $file and -w _) {
        print "The file is both readable and writable!\n";
    }

    # Perl 5.10 позволяет последовательно сгруппировать операторы проверки перед именем файла:

    use 5.010;
    if (-w -r $file) {
        print "The file is both readable and writable!\n";
    }

    # Допустим, требуется найти все каталоги, доступные для чтения, записи и исполнения,
    # владельцем которых является текущий пользователь.

    use 5.010;
    if (-r -w -x -o -d $file) {
        print "My directory is readable, writable, and executable!\n";
    }

    # Группировка не подходит для проверок с возвращаемыми значениями, отличными от true и false,
    # которые нам хотелось бы использовать в сравнениях. Казалось бы, следующий фрагмент кода сначала
    # проверяет, что элемент является каталогом, а затем – что его размер менее 512 байт,
    # но на самом деле это не так:

    use 5.010;
    my $file_dir = "/home/";
    if (-s -d $file_dir < 512) { # WRONG! DON'T DO THIS
        print "The directory is less than 512 bytes!\n";
    }

    # Чтобы понять, что происходит, достаточно записать сгруппированные проверки файлов в предыдущем варианте записи.
    # Результат комбинации проверок становится аргументом для сравнения:

    if ((-d $file and -s _) < 512) {
        print "1. The directory is less than 512 bytes! WRONG!!\n"; # see: 1. The directory is less than 512 bytes! WRONG!!
    }

    # Когда –d  возвращает false, Perl сравнивает полученное значение false с 512.
    # Результат сравнения оказывается истинным, потому что false интерпретируется как 0,
    # а это меньше 512. Чтобы не создавать путаницы и помочь программистам сопровождения,
    # которые придут после нас, достаточно разделить проверку на две части:

    if (-d $file and -s _ < 512) {
        print "2. The directory is less than 512 bytes!\n";
    }
}

# ФУНКЦИИ stat И lstat

# {
#     # Операторы проверки файлов хорошо подходят для получения информации об атрибутах,
#     # относящихся к конкретному файлу или дескрипQ тору, но они не дают полной картины.
#     # Например, ни одна проверка не возвращает количество ссылок на файл или идентификатор
#     # пользователя (UID) его владельца.
#     # Возвращаемое значение содержит либо пустой список, означающий, что вызов stat
#     # завершился неудачей (обычно изQза того, что файл не существует), либо список из 13 чисел,
#     # который проще всего описывается следующим списком скалярных переменных:
#
#     my($dev, $ino, $mode, $nlink, $uid, $gid, $rdev, $size, $atime, $mtime, $ctime, $blksize, $blocks, $blocks_test) =
#         stat('1.3.pl');
#     my %stat_hash = (
#         '$dev'     => $dev // 'undefined value',
#         '$ino'     => $ino // 'undefined value',
#         '$mode'    => $mode // 'undefined value',
#         '$nlink'   => $nlink // 'undefined value',
#         '$uid'     => $uid // 'undefined value' ,
#         '$gid'     => $gid // 'undefined value',
#         '$rdev'    => $rdev // 'undefined value',
#         '$size'    => $size // 'undefined value',
#         '$atime'   => $atime // 'undefined value',
#         '$mtime'   => $mtime // 'undefined value',
#         '$blocks'  => $blocks // 'undefined value',
#         '$ctime'   => $ctime // 'undefined value',
#         '$blksize' => $blksize // 'undefined value',
#         '$blocks' => $blocks // 'undefined value',
#         '$blocks_test' => $blocks_test // 'undefined value'
#     );
#
#     foreach my $key (sort keys %stat_hash) {
#         print "$key ==> $stat_hash{$key}\n";
#     }
#
#     # Имена относятся к полям структуры stat, которая подробно описана в man странице stat(2).
#
# }

# ФУНКЦИЯ localtime

# {
#     # Возможно, вам потребуется преобразовать метку в строку вида Thu May 31 09:48:18 2007.
#     # В Perl эта задача решается функцией localtime в скалярном контексте:
#
#     my $timestamp = 1180630098;
#     my $date = localtime $timestamp;
#
#     # В списочном контексте localtime возвращает список чисел,
#     # причем некоторые его элементы оказываются довольно неожиданными:
#
#     my($sec, $min, $hour, $day, $mon, $year, $wday, $yday, $isdst)= localtime $timestamp;
#
#     print "\$date = $date\n";
#
#     my %date_hash = (
#         '$sec' => $sec // 'undefined value',
#         '$min' => $min // 'undefined value',
#         '$hour' => $hour // 'undefined value',
#         '$day' => $day // 'undefined value',
#         '$mon' => $mon // 'undefined value',
#         '$year' => $year // 'undefined value',
#         '$wday' => $wday // 'undefined value',
#         '$yday' => $yday // 'undefined value',
#         '$isdst' => $isdst // 'undefined value'
#     );
#
#         foreach my $key (sort keys %date_hash) {
#             print "$key ==> $date_hash{$key}\n";
#         }
# #   $mon – номер месяца от 0 до 11 – может использоваться в качестве индекса в массиве названий месяцев.
# #   $year – количество лет, прошедших с  1900 года; чтобы получить «настоящий» год, достаточно прибавить 1900. Значение
# #   $wday  лежит  в  интервале  от 0  (воскресенье) до 6  (суббота), а
# #   $yday – номер дня года, от 0 (1 января) до 364 или 365 (31 декабря).
#
#     # Функция gmtime  аналогична localtime, но результат она возQ вращает в формате единого мирового
#     # времени (когдаQто называвшемся «гринвичским»).
#     # Если вам понадобится текущая временная метка от системных часов, воспользуйтесь функцией time.
#     # И localtime, и gmtime при вызове без параметра по умолчанию используют текущее значение time:
#     my $now = gmtime;  # Получить текущее мировое время в виде строки
#     print "\n\n\$now = $now\n";
# }

# ПОРАЗРЯДНЫЕ ОПЕРАТОРЫ

#