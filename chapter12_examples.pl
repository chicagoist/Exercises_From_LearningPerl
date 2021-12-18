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
    my $size_in_k = (-s) / 1024;    # По умолчанию используется $_
    # Конечно, явная передача параметра исключает любые недоразумения при проверке.
    print "$_ is readable\n" if -r;  # same as -r $_
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
    if( -r $file ) {
    print "The file is readable!\n";}

    if( -w _ ) {
    print "The file is writable!\n";
    }

    # При возврате и выполнении другой проверки файловый дескриптор _ содержит не данные $file,
    # как мы ожидаем, а данные $other_file:
    my $other_file;
    if( -r $file ) {
    print "The file is readable!\n";
    }

    lookup( $other_file );

    if( -w _ ) {
    print "The file is writable!\n";
    }

    sub lookup {
        return -w $_[0];
    }

}