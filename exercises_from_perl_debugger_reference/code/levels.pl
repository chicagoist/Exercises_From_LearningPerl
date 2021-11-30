
$SIG{__WARN__} = sub {
	print "xxx warning inside the handler xxx\n";
};

$SIG{__DIE__} = sub {
	print "xxx dieing inside the handler xxx\n";
	die "*** dieing here ***";
};

call();

sub call {
	moan();
}

sub moan {
	print("xxx printing xxx\n");
	warn("xxx warning xxx");
	die("xxx dieing xxx");
};

