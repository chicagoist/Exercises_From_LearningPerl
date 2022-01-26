#!/usr/bin/perl -w


use 5.10.0;
# use CGI;
# use POSIX;
# use Encode qw(decode_utf8);
# use Encode qw(decode encode);
#= BEGIN{@ARGV=map Encode::decode(#\$_,1),@ARGV;}
# BEGIN{@ARGV = map decode_utf8(#\$_, 1), @ARGV;}
# use open qw(:std :encoding(UTF-8));
# use utf8::all 'GLOBAL';
# use Encode::Locale;
# use Encode;
# use diagnostics;


use strict;
use warnings FATAL => 'all';
use autodie qw(:all);
use utf8;
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use DDP;
use Data::Dumper;
use Bundle::Camelcade; # for Intellij IDEA

#  На вход вам будет подаваться имя пакета. Ваша задача - вывести все возможные пути нахождения
# этого файла в порядке следования префиксов в @INC, по одному на строку. В качестве символа
# "конец строки" используйте \n.

# https://stepik.org/lesson/51558/step/3

# Sample Input:
# Local::Store


# Sample Output:
# /usr/local/lib/perl5/site_perl/Local/Store.pm
# /usr/local/share/perl5/site_perl/Local/Store.pm
# /usr/lib/perl5/vendor_perl/Local/Store.pm
# /usr/share/perl5/vendor_perl/Local/Store.pm
# /usr/lib/perl5/core_perl/Local/Store.pm
# /usr/share/perl5/core_perl/Local/Store.pm

my @fqn;

while (<>) {
    state @full_address;

    push @fqn, split /::/, $_;

    my $length_array = @fqn - 1;

    for (my $i = 0; $i <= $length_array; $i++) {
        chomp($fqn[$i]);
        if ($i != $length_array) {

            push @full_address, $fqn[$i] . "/";

        }
        elsif ($i == $length_array) {
            $fqn[$i] =~ s/(\.*)/$1/;
            push @full_address, $fqn[$i] . ".pm";

        }
    }

    my $add = join('', @full_address);

    foreach my $inc_link (@INC) {
        chomp($inc_link);
        printf("%s\n", "$inc_link/$add");
    }
}


# $ perl stepik_4.2.pl
# Local::Perl5::Store

# /home/legioner/Perl-5.34.0-Linux-DebianStretch/lib/perl5/site_perl/5.34.0/x86_64-linux/Local/Perl5/Store.pm
# /home/legioner/Perl-5.34.0-Linux-DebianStretch/lib/perl5/site_perl/5.34.0/Local/Perl5/Store.pm
# /home/legioner/Perl-5.34.0-Linux-DebianStretch/lib/perl5/5.34.0/x86_64-linux/Local/Perl5/Store.pm
# /home/legioner/Perl-5.34.0-Linux-DebianStretch/lib/perl5/5.34.0/Local/Perl5/Store.pm
