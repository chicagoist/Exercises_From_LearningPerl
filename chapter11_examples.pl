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



# МОДУЛИ Perl

# Модуль File::Basename
# https://metacpan.org/pod/File::Basename

use File::Basename;

# В нашем примере потребуется основная функция модуля basename:

=begin text

 my $name = "/usr/local/bin/perl";
 my $basename = basename $name;      # Получаем 'perl'
 say $basename;

Windows in reply :
7>  $name = "C:\Users\User\AppData\Local\ActiveState\cache\e5e4f4e9\bin\perl.exe"
Unrecognized escape \v passed through at reply input line 1, <FIN> line 8.
Unrecognized escape \A passed through at reply input line 1, <FIN> line 8.
Unrecognized escape \A passed through at reply input line 1, <FIN> line 8.
Unrecognized escape \p passed through at reply input line 1, <FIN> line 8.
$res[4] = 'C:SERSUSERAPPDATAocalactivestatechee4f4einperl.exe'
8>  say $basename;
perl
$res[5] = 1

9> $name = "/usr/local/bin/perl";
$res[6] = '/usr/local/bin/perl'

10> say $basename;
perl
$res[7] = 1

11> dirname($name)
$res[8] = '/usr/local/bin'

12> $name = 'C:\Users\User\AppData\Local\ActiveState\cache\e5e4f4e9\bin\perl.exe'
$res[12] = 'C:\\Users\\User\\AppData\\Local\\ActiveState\\cache\\e5e4f4e9\\bin\\perl.exe'

13> dirname($name)
$res[13] = 'C:\\Users\\User\\AppData\\Local\\ActiveState\\cache\\e5e4f4e9\\bin'

=end text
=cut


=begin :text

# Включите в объявлении use  модуля File::Basename список импорта, в котором точно перечислены
# имена импортируемых функций. Директива импортирует только эти имена и никакие другие.
# Например, при следующем объявлении в программу из модуля включается только функция basename:
#    use File::Basename qw/ basename /;
# А здесь никакие новые функции вообще не запрашиваются:
#    use File::Basename qw/ /;
# Эта форма также часто записывается в следующем виде:
#    use File::Basename ();

# Даже если не импортировать имена, вы все равно сможете использовать функции, но для этого придется вызывать
# их с указанием полных имен:

   use File::Basename qw/ /;  # Не импортировать имена функций
   my $betty = &dirname($wilma);  # Используем собственную
                                   # функцию &dirname (код не показан)
   my $name = "/usr/local/bin/perl";
   my $dirname = File::Basename::dirname $name;  # dirname из модуля

=end :text
=cut


# МОДУЛЬ File::Spec

=begin text

 use File::Basename;

 print "Please enter a filename: ";
 chomp(my $old_name = <STDIN>);
 my $dirname = dirname $old_name;
 say "\$dirname = $dirname\n";
 my $basename = basename $old_name;
 say "\$basename = $basename\n";
 $basename =~ s/^/not/;    # Добавление префикса к базовому имени
 # my $new_name = "$dirname/$basename"; # good for Linux but not Windows
 # rename($old_name, $new_name) or warn "Can't rename '$old_name' to '$new_name': $!";

# Windows : Can't rename 'C:\Users\User\test.c' to './notC:\Users\User\test.c': No such file or directory at chapter11_examples.pl line 95, <STDIN> line 1.
# Мы снова неявно предполагаем, что имена файлов соответствуют правилам UNIX, и используем косую черту для отделения имени каталога от базового имени.

=end text

=cut

=begin text
# МОДУЛЬ File::Spec
# https://metacpan.org/pod/File::Spec

# Из документации File::Spec мы узнаем, что для решения нашей задаQ чи необходимо использовать метод с именем catfile.
# Что такое метод? Просто разновидность функции (в том, что касается наших практических целей).
# Отличительная особенность методов заключается в том, что методы File::Spec всегда вызываются по полным именам:
use File::Spec;
#
# Получить значения $dirname и $basename, как было сделано выше .
#

 my $new_name = File::Spec->catfile($dirname, $basename);
 rename($old_name, $new_name) or warn "Can't rename '$old_name' to '$new_name': $!";

=end text

=cut

=begin text
# МОДУЛЬ CGI.pm

#  Наш простой сценарий CGI разбирает входные данные CGI и выводит имена и значения в виде текстового
# документа. В списке импорта используется обозначение :all –

 use CGI qw(:all);
 #print header("text/plain");
 print header(-type => "text/html;charset=UTF-8"),
     start_html("Perl Expression Results"),
     meta (-type => "text/html;charset=UTF-8"),
         h1("Input parameters");
 foreach my $param (param()) {
     print "$param: " . param($param) . "\n";
 }
 print end_html();


# print header(),
#     start_html("This is the page title"),
#     h1( "Input parameters" );
#
# my $list_items;
# foreach my $param ( param() ){
#     $list_items .= li( "$param: " . param($param) );
# }
# print ul( $list_items );
# print end_html();


=end text

=cut




=begin text

# МОДУЛЬ Path::Class

# The File::Spec module does work with file paths from just about any platform,
# but the interface is a bit clunky. The Path::Class module, which doesn’t come
# with Perl, gives you a more pleasant interface:

# Модуль File::Spec работает с путями к файлам практически с любой платформы,
# но интерфейс немного неуклюжий.
# Модуль Path::Class, которого нет в Perl, дает более приятный интерфейс:

 use Path::Class;
 my $dir     = dir( qw(Users fred lib) );
 my $subdir  = $dir->subdir( 'perl5' );     # Users/fred/lib/perl5
 my $parent  = $dir->parent;                # Users/fred
 my $windir  = $dir->as_foreign( 'Win32' ); # Users\fred\lib
 say "\$subdir = $subdir";
 say "\$parent = $parent";
 say "\$windir = $windir";

# $subdir = Users/fred/lib/perl5
# $parent = Users/fred
# $windir = Users\fred\lib

=end text
=cut


# БАЗЫ ДАННЫХ и DBI

use DBI;

my $dbfile = "sqlite.db";
my $dbh = DBI->connect(
    "dbi:SQLite:dbname=$dbfile", "", "",
    {
        RaiseError     => 1,
        sqlite_unicode => 1,
    }
);
# $dbh->do("PRAGMA key = 'password';");
