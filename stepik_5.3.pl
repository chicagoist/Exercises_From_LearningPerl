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


# https://stepik.org/lesson/54331/step/6


package Local::Product;

sub new {
    my $class = shift;
    my %args =  @_;
    my $self = bless \%args, $class;

    if ($args{name} && (!$args{price_rur} ^ !$args{price_usd})) {
        return $self;
    }else {
        print "При создании объекта, конструктору (new) должны обязательно переданы свойство name и только одно из свойств price_rur или price_usd.";
        die "$!";
    }
}

sub name {
    my $self = shift;
    #say "\$self->{name} = $self->{name}";
    #local $name = $self->{name};
    return $self->{name};
}



sub price_rur {
    my $self = shift;

    if ($_[0]) {
        $self->{price_rur} = $_[0];
    }elsif ($self->{price_usd}) {
        $self->{price_rur} = ($self->{price_usd} * 70);
    }else {
        $self->{price_rur} = $self->{price_rur};
    }
    return $self->{price_rur}."\n";
}


sub price_usd {
    my $self = shift;
    #my $self = $_[0];
    #say "\$self_USD = $_[0]";

    if ($_[0]) {
        $self->{price_usd} = $_[0];
    }elsif ($self->{price_rur}) {
        $self->{price_usd} = ($self->{price_rur} / 70);
    }else {
        $self->{price_usd} = $self->{price_usd};
    }
    return $self->{price_usd}."\n";
}

sub count {
    my $self = shift;

    if ($_[0]) {
        $self->{count} = $_[0];
    }elsif ($self->{count}) {
        $self->{count} = $self->{count};
    }else {
        $self->{count} = 1;
    }
    return $self->{count}."\n";
}

sub sum_rur {
    my $self = shift;

    my $sum_rur = $self->{count} * $self->{price_rur};
    return $sum_rur."\n";
}

sub sum_usd {
    my $self = shift;

    my $sum_usd = $self->{count} * $self->{price_usd};
    return $sum_usd."\n";
}

1;


my $product = Local::Product->new(name => 'Фуфырка обыкновенная', price_rur => 350, count => 6);

print $product->price_rur;   # 350
print $product->price_usd;   # 5
print $product->count;       # 6
$product->{sum_rur} = undef; #
print $product->sum_rur;     # 2100
print $product->sum_usd;     # 30

$product->price_usd(7);
print $product->price_rur; # 490
print $product->price_usd; # 7

$product->count(10);
print $product->sum_rur;   # 4900
print $product->sum_usd;   # 70
print $product->name;   # name
print "\n";
print $product->isa('Local::Product') . "\n"; #
print $product->can("new") , "\n"; #
print $product->VERSION , "\n"; #