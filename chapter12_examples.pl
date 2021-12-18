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


{
    # ПРОВЕРКА НЕСКОЛЬКИХ АТРИБУТОВ ОДНОГО ФАЙЛА

    # Объединение нескольких файловых проверок позволяет создавать сложные логические условия.
    # Предположим, программа должна выполнить некую операцию только с файлами, доступными как
    # для чтения, так и для записи. Проверки атрибутов объединяются оператором and:
    if (-r $file and -w $file) {...}

    # Виртуальный файловый дескриптор _ (просто символ подчеркивания) использует информацию,
    # полученную в результате выполнения последнего оператора проверки файла. Теперь Perl
    # достаточно запросить информацию о файле всего один раз:
    if (-r $file and -w _) {...}

    # Для использования _ проверки файлы необязательно располагать рядом друг с другом.
    # Здесь они размещаются в разных условиях if:
    if (-r $file) {
        print "The file is readable!\n";}

    if (-w _) {
        print "The file is writable!\n";
    }

    # При возврате и выполнении другой проверки файловый дескриптор _ содержит не данные $file,
    # как мы ожидаем, а данные $other_file:
    my $other_file;
    if (-r $file) {
        print "The file is readable!\n";
    }

    lookup($other_file);

    if (-w _) {
        print "The file is writable!\n";
    }

    sub lookup {
        return -w $_[0];
    }

}

# СГРУППИРОВАННАЯ ПРОВЕРКА ФАЙЛОВ

{
    # До выхода Perl 5.10, если вы хотели одновременно проверить несколько атрибутов файла,
    # это приходилось делать по отдельности (даже при том, что дескриптор _ избавлял вас от части работы).
    # мы хотим узнать, доступен ли файл для чтения и записи одновременно. Для этого необходимо сначала
    # выполнить проверку на чтение, а затем проверку на запись:
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
    if (-s -d $file < 512) { # WRONG! DON'T DO THIS
        print "The directory is less than 512 bytes!\n";
    }

    # Чтобы понять, что происходит, достаточно записать сгруппированные проверки файлов в предыдущем варианте записи.
    # Результат комбинации проверок становится аргументом для сравнения:

    if ((-d $file and -s _) < 512) {
        print "The directory is less than 512 bytes!\n";
    }

    # Когда –d  возвращает false, Perl сравнивает полученное значение false с 512.
    # Результат сравнения оказывается истинным, потому что false интерпретируется как 0,
    # а это меньше 512. Чтобы не создавать путаницы и помочь программистам сопровождения,
    # которые придут после нас, достаточно разделить проверку на две части:

    if (-d $file and -s _ < 512) {
        print "The directory is less than 512 bytes!\n";
    }
}

# ФУНКЦИИ stat И lstat

{



}