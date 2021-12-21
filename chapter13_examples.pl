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
use Bundle::Camelcade;


# ОПЕРАЦИИ С КАТАЛОГАМИ
#


{ # ПЕРЕМЕЩЕНИЕ ПО ДЕРЕВУ КАТАЛОГОВ

    chdir "/etc" or die "cannot chdir to /etc: $!";

    # Некоторые командные процессоры позволяют включать в
    # команду cd путь с префиксом ~, чтобы использовать в
    # качестве отправной точки домашний каталог другого
    # пользователя (например, cd ~merlyn). Это функция командного
    # процессора, а не операционной системы, а Perl вызывает
    # функции операционной системы напрямую, поэтому
    # префикс ~ не работает с chdir.

}

{
    # ГЛОБЫ

    # Команде echo ничего не нужно знать о замене *.pm,
    # потому что командQ ный процессор уже выполнил ее.
    # Глобы работают даже в программах Perl:
    sub show_args {
        foreach my $arg (@ARGV) {
            print "one arg is $arg\n";
        }
    }
    show_args();

    # Обратите внимание: show_args не нужно ничего знать о
    # глобах – имена уже расширены и занесены в массив @ARGS.
}



{
    # Но иногда в программах Perl появляются шаблоны типа *.pm.
    # Можно ли расширить их до подходящих имен файлов без особых усилий?
    # Конечно – достаточно воспользоваться оператором glob:
    sub show_glob {
        my @all_files;
        my @pl_files;
        my @pm_files;
        foreach (@ARGV) {
            @all_files = glob "~/Perl_Projects/Exercises_From_Learning_Perl/.*";
            @pl_files = glob "~/Perl_Projects/Exercises_From_Learning_Perl/*.pl";
            @pm_files = glob "~/Perl_Projects/Exercises_From_Learning_Perl/*.pm";
            #@pl_files     = glob "* *.pl";
        }

        print join("\n", @all_files) . "\n";
        print join("\n", @pl_files) . "\n";
        print join("\n", @pm_files) . "\n";
    }

    show_glob();
}


{
    # АЛЬТЕРНАТИВНЫЙ СИНТАКСИС ГЛОБОВ
    # Вместо этого он использовался в синтаксисе с угловыми скобками,
    # напоминающем синтаксис чтения из файлового дескриптора:
    my @all_files = <*>; ## Полностью эквивалентно my @all_files = glob "*";

    # Значение в  угловых скобках интерполируется по аналогии со строками в кавычках;
    # это означает, что переменные Perl перед обработкой глоба заменяются своими текущими значениями:
    my $dir = "/etc";
    my @dir_files = <$dir/* $dir/.*>;

    foreach (@dir_files) {
        print "\@dir_files = $_\n";
    }
    # Таким образом, если содержимое угловых скобок является идентификатором Perl,
    #  имеется в виду операция чтения; в противном случае используется операция с глобами.
    # Пример:
    # my @files = <FRED/*>;  ## Глоб
    # my @lines = <FRED>;    ## Чтение из файлового дескриптора
    # my $name = "FRED";
    # my @files = <$name/*>; ## Глоб

    # если в угловых скобках находится простая скалярная переменная (не элемент хеша или массива)
    # с именем файлового дескриптора, то конструкция интерпретируется как опосредованное чтение
    # из файлового дескриптора:
    # my $name = "FRED";
    # my @lines = <$name>; ## Опосредованное чтение из дескриптора FRED

    # При желании функциональность опосредованного чтения из файловых дескрипторов
    # можно представить оператором readline ; такая запись более понятна:
    # my $name = "FRED";
    # my @lines = readline FRED;  ## Чтение из FRED
    # my @lines = readline $name; ## Чтение из FRED

}

{
    # ДЕСКРИПТОРЫ КАТАЛОГОВ

    # Для получения списка имен из заданного каталога также можно восQ пользоваться
    # дескриптором каталога. Дескрипторы каталога очень похожи на файловые дескрипторы –
    # как по внешнему виду, так и по поведению. Их тоже необходимо открыть (opendir вместо open),
    # прочитать из них данные (readdir вместо readline), а затем закрыть (closedir вместо close).
    # Но вместо чтения содержимого файлов читаются имена файлов (и прочая информация о них). Пример:
    my $dir_to_process = '/tmp';
    print "\n\n";
    opendir my $dh, $dir_to_process
        or die "Cannot open $dir_to_process: $!";
    while (my $name = readdir $dh) {
        next if $name eq "." or $name eq "..";
        next unless $name =~ /\.sh$/;
        print "files or dirs in $dir_to_process is $name\n";

    }

    opendir $dh, $dir_to_process
        or die "Cannot open $dir_to_process: $!";
    foreach my $file (readdir $dh) {
        print "one dir in $dir_to_process is $file\n";
    }
    closedir $dh;

    # в список включаются все файлы, а не только  те, которые соответствуют заданному
    # шаблону (например, *.pm, как в примере с глобами). В частности, в  него включаются
    # файлы с точкой и специальные записи .  и ..Таким образом, если нас интересуют
    # только файлы с расширением pm, в цикл включается функция пропуска файлов:
    # while ($name = readdir DIR) {
    # next unless $name =~ /\.pm$/;
    #    ... Продолжение обработки ...
    # }


    # Имена файлов, возвращаемые оператором readdir, не содержат пути.
    # Таким образом, вы получаете не /etc/passwd, а passwd.
    # для получения полных имен необходимо выполнить дополнительную обработку результатов:

    # opendir SOMEDIR, $dirname or die "Cannot open $dirname: $!";
    # while (my $name = readdir SOMEDIR) {
    #    next if $name =~ /^\./;          # Пропустить файлы, начинающиеся с точки
    #    $name = "$dirname/$name";        # Добавить путь
    #    next unless -f $name and -r $name;   # Только файлы с доступом для чтения...
    # }
    # Без обработки операторы проверки файлов будут проверять файлы в текущем каталоге,
    # а не в том каталоге, имя которого хранится в $dirname.
    # Это самая распространенная ошибка при использовании дескрипторов каталогов.
}

{ # РЕКУРСИВНОЕ ЧТЕНИЕ КАТАЛОГОВ

    # Perl поставляется с библиотекой
    use File::Find;
    # обеспечивающей удобный механизм рекурсивной обработки каталогов.
}

{# ОПЕРАЦИИ С ФАЙЛАМИ И КАТАЛОГАМИ

    # Удаление файлов
    # На уровне командного процессора UNIX удаление файла или файлов выполняется командой rm:
    #   $ rm slate bedrock lava
    # В Perl для этой цели используется оператор unlink:
    #    unlink "slate", "bedrock", "lava";


    # Так как функция unlink  получает список, а функция glob  возвращает список,
    # эти две функции можно объединить для удаления множества файлов по маске:
    #    unlink glob "*.o";

    # Возвращаемое значение unlink  сообщает количество успешно удаленных файлов.
    # Возвращаясь к первому примеру, мы можем проверить, успешно ли прошло удаление:
    my $dirname = '/home/legioner/Perl_Projects/Exercises_From_Learning_Perl';
    chdir $dirname; # without chdir we give: I deleted 0 file(s) in
    my $successful = unlink "slate", "bedrock", "lava";
    print "I deleted $successful file(s) in '$dirname' just now\n";

    # А если функция возвращает 1 или 2? По этому значению невозможно определить, какие файлы были удалены.
    # Если вас интересует эта информация, удаляйте файлы по одному в цикле:
    chdir $dirname; # without chdir we give: failed on ...
    foreach my $file (qw(slate bedrock lava)) {
        unlink $file or warn "failed on $file: $!\n";
    }
}


{    # ПЕРЕИМЕНОВАНИЕ ФАЙЛОВ

    my ($file55, $newfile55);
    rename 'file55', 'newfile55';
    # rename "over_there/some/place/some_file", "some_file";

    # часто встречается один вопрос: можно ли переименовать все файлы с расширением .old так,
    # чтобы они сохранили прежние имена, но получили расширение .new?
    # Вот как это делается в Perl:

    # foreach my $file (glob "*.old") {
    #     my $newfile = $file;
    #     $newfile =~ s/\.old$/.new/;
    #     if (-e $newfile) {
    #         warn "can't rename $file to $newfile: $newfile exists\n";
    #     }
    #     elsif (rename $file, $newfile) {
    #         ## Успешное переименование, ничего не делать
    #     }
    #     else {
    #         warn "rename $file to $newfile failed: $!\n";
    #     }
    # }
}

{    # ССЫЛКИ И ФАЙЛЫ

    # функция Perl link  используется для создания новой ссылки:
    my $dirname1 = '/home/legioner/Perl_Projects/Exercises_From_Learning_Perl';
    chdir $dirname1;
    link 'out.txt', 'out.txt_Hard_Link' or warn "can't link file out.txt to out.txt_Hard_Link: $!";
    link 'examples', 'examples_Hard_Link' or warn "can't link directory examples to examples_Hard_Link: $!";
    # как если бы вы ввели "ln chicken egg" в приглашении командного процессора UNIX.
    # Cсылки не могут создаваться для каталогов и не могут вести с одного смонтированного тома на другой.

    # эти ограничения обходятся при помощи другой разновидности: символических ссылок. Символические
    # ссылки (также  называемые мягкими ссылками, в  отличие от жестких ссылок, о которых мы говорили ранее)
    # представляют собой специальные записи в каталоге, которые перенаправляют систему к другому месту.
    symlink 'out.txt', 'out.txt_Soft_Link' or warn "can't link file out.txt to out.txt_Soft_Link: $!";
    symlink 'examples', 'examples_Soft_Link' or warn "can't link directory examples to examples_Soft_Link: $!";

    # Чтобы узнать, на какой объект указывает символическая ссылка, воспользуйтесь функцией readlink.
    # Функция вернет либо информацию о целевом объекте, либо undef, если аргумент не является символической ссылкой:
    chdir $dirname1;
    my $where_hard_file_out = readlink 'out.txt_Hard_Link';      # Получаем undef 'hard link'
    my $where_hard_dir_examples = readlink 'examples_Hard_Link'; # Получаем undef 'hard link'
    my $where_soft_file_out = readlink 'out.txt_Soft_Link';      # Получаем 'out.txt'
    my $where_soft_dir_examples = readlink 'examples_Soft_Link'; # Получаем 'examples'
    my $gcc = readlink '/usr/bin/gcc';                           # Получаем  gcc-10

    chdir $dirname1;
    printf("\$where_hard_file_out = %s\n \$where_hard_dir_examples = %s\n \$where_soft_file_out = %s\n \$where_soft_dir_examples = %s\n", $where_hard_file_out // 'hard link', $where_hard_dir_examples // 'hard link', $where_soft_file_out, $where_soft_dir_examples);
    printf("\$gcc = %s\n", $gcc);

    # Обе разновидности ссылок удаляются функцией unlink. Функция просто удаляет запись каталога,
    # связанную с именем файла, с уменьшением счетчика ссылок и, возможно, с освобождением индексного узла.
}


{ # СОЗДАНИЕ И УДАЛЕНИЕ КАТАЛОГОВ

   p %ENV;
    # Создать новый каталог в существующем каталоге несложно.
    # Просто вызовите функцию mkdir:
     mkdir "fred", 0755 or warn "Cannot make fred directory: $!";

    # такая запись работать не будет:
    my $name = "fredD";
    my $permissions = "0755";  # получится but will not work
    mkdir $name, $permissions;

    # используйте функцию oct, которая обеспечивает восьмеричную интерпретацию строки
    # независимо от присутствия начального нуля:
    my $nameDD = "fredDD";
    mkdir $nameDD, oct($permissions);

    # Необходимость в дополнительной функции oct чаще всего возникает при получении данных от пользователя.
    # Предположим, аргументы передаются в командной строке:
    $ARGV[0] = "axel";
    $ARGV[1] = "0775";
    my ( $name22, $perm22) = @ARGV;  # Первые два аргумента - имя и разрешения
    mkdir $name22, oct($perm22)
        or die "cannot create $name: $!";
    # Значение $perm изначально задается как строка, поэтому функция oct обеспечивает правильную восьмеричную интерпретацию.

    # Пустые каталоги удаляются функцией rmdir. Функция отчасти напоминает unlink,
    # но может удалять только один каталог при каждом вызове:
    foreach my $dir (qw(fredD fredDD axel)) {
        chdir '/home/legioner/Perl_Projects/Exercises_From_Learning_Perl';
        rmdir $dir
            or warn "cannot rmdir $dir: $!\n";  # Deletes the directory specified by FILENAME if that directory is empty.
    }

    # Если каталог не пуст, попытка вызова rmdir  завершается неудачей.
    # Сначала следует попытаться удалить содержимое каталога функцией unlink,
    # а затем попробуйте удалить каталог:
    my $temp_dir = "/tmp/scratch_$$";       # Определяется по идентификатору
                                            # процесса; см. в тексте
    mkdir $temp_dir, 0700 or die "cannot create $temp_dir: $!";
    open(my $fh, ">", "$temp_dir/output.txt")
        or die "Can't open > $temp_dir./output.txt: $!";

    print $fh "This line gets printed into output.txt.\n";
       # ...
       # Каталог $temp_dir используется для хранения всех временных файлов
       #...
    # unlink glob "$temp_dir/* $temp_dir/.*"; # Удалить содержимое $temp_dir
    rmdir $temp_dir or warn "cannot remove $temp_dir: $!";  # Удалить пустой каталог

}