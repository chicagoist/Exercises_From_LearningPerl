
$SIG{__WARN__} = sub {
	print "using own warning handler\n";
};

$SIG{__DIE__} = sub {
	print "using own die handler\n";
};

$SIG{__INT__} = sub {
	print "using own signal handler\n";
};

warn ("warning here");
print("warned but not dead yet\n");
die  ("dieing here");

