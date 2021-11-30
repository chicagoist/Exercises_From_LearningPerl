
$SIG{__WARN__} = sub {
	print "warning here\n";
};

call();

sub call {
	moan();
}

sub moan {
	warn("xxx warning xxx");
};

