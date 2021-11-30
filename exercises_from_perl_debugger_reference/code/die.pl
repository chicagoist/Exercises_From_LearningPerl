
$SIG{__DIE__} = sub {
	print "using own die handler\n";
};

die("dieing here");

