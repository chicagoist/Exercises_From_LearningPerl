
$orig = $arg = $ARGV[0] || 'unknown + \ - . , ; { etc.';

$arg =~ s/([\200-\377])/'\\'.sprintf('%3o',ord($1))/eg; # if $quoteHighBit;

print "orig($orig) quoted($arg)\n";
	
