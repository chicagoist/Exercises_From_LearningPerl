#!/usr/bin/perl

use 5.10.0;
# use CGI;
use POSIX;
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
use utf8::all 'GLOBAL';
use DDP;
use Data::Dumper;
use Bundle::Camelcade;


# УПРАВЛЕНИЕ ПРОЦЕССАМИ

{
    # Функция system

    # Для запуска дочернего процесса в Perl проще всего воспользоваться функцией system.
    # Например, выполнение команды UNIX date  в Perl выглядит так:

    system "date";

    # Дочерний процесс выполняет команду date, которая наследует от Perl стандартные
    # потоки ввода, вывода и ошибок. Это означает, что стандартная строка с датой и
    # временем в коротком формате, выдаваемая date, попадает в тот приемник, с которым
    # в Perl уже связан дескриптор STDOUT.
    # для более сложных команд (скажем, ls –l $HOME) весь текст приQ дется включить
    # в параметр:

    system 'ls -l $HOME';

    # нам пришлось перейти от кавычек к апострофам, так как $HOME является переменной командного процессора.
    # Конечно, нужный знак можно экранировать в строке:

    system "ls -l \$HOME";

    # Если команда «достаточно проста», командный процессор вообще не задействуется.
    # Так, упоминавшиеся ранее команды date  и ls  Perl запускает напрямую,
    # для чего он ищет команду GNU/Linux по унаследованному значению PATH.
    # Но если в строке есть чтоQто необычное (например, метасимволы командного
    # процессора: $, ; или |), для ее обработки активизируется стандартный командный
    # процессор Bourne Shell (/bin/sh ). В этом случае дочерним процессом является
    # командный процессор, а запрашиваемая команда становится «внуком» (или потомком
    # следующего уровня). Например, вы можете  записать в  аргументе целый мини-сценарий
    # командного процессора:

    # DANGEROUS SCRIPT:
    # system 'for i in *; do echo == $i ==; cat $i; done';
    system 'for i in *; do echo == $i ==; ls -l $i; done';

    # Мы снова используем апострофы, потому что знак $  предназначается для командного
    # процессора, а не для Perl. С кавычками Perl заменит $i текущим значением переменной
    # и не позволит командному процессору использовать свое значение.

}

{
    #ВЫПОЛНЕНИЕ КОМАНД В ОБХОД КОМАНДНОГО ПРОЦЕССОРА

    # Оператор system  также может вызываться с несколькими аргументами.
    # В этом случае командный процессор не используется, какой бы сложной
    # ни была команда:

    my $root = '/';
    my $ls_l = 'ls -l';
    my $bash = 'sh -c';
    my @dirs = qw(/var /home/*.*/);
    my $cd = 'cd';
    my $grep = '* | grep';
    my $some_txt_files = '*.txt';
    my $command_line = 'pwd';

    #system "$bash '$ls_l $root'; $bash 'cd / $ls_l @dirs'; echo '@dirs'";
    system "ls -l @dirs";

    # вызов system с одним аргументом практически эквивалентен следующему
    # вызову с несколькими аргументами:
    system $command_line;
    system "/bin/sh", "-c", $command_line;
    # Но последний вариант записи почти не используется, если только вы не хотите,
    # чтобы обработка выполнялась другим командным процессором:

    system "powershell.exe", "-encodedCommand", '$encodedCommand'; # WSL2 in Windows 10

    unless (system "TZ='Europe/Kiev' date") { # Возвращаемое значение равно нулю - признак успеха
        print "We gave you a date, OK!\n";
    }

}

{
    # ФУНКЦИЯ exec

    # Практически все, что было сказано о синтаксисе и семантике system,
    # также относится к функции exec  – кроме одного (очень важного) обстоятельства.
    # Функция system  создает дочерний  процесс, который берется за свою работу,
    # пока Perl терпеливо ждет. Функция exec заставляет сам процесс Perl  выполнить
    # запрашиваемое действие. ПроисхоQ дящее больше напоминает переход goto, нежели
    # вызов функции.

    use POSIX;
    my $dir;

    ($^O =~ /Win32/) ? ($dir = getcwd) =~ s/\//\\/g : ($dir = getcwd); # Account for / and \ on Win32 and non-Win32 systems
    chdir $dir or die "Cannot chdir /tmp: $!";
    my $file = "$dir" . "/" . 'bedrock';

    if (!defined $dir . '/bedrock') {
        exec 'gcc', '-o', 'bedrock', 'bedrock.c';
    }
    else {
        warn "File bedrock already exists\n";
    }
}