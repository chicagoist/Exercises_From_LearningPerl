
unless ($ENV{fork_TTY} =~ /\w+/) {
	die "Usage: fork_TTY=tty perl -d ./forker.pl"; # eg: /dev/pts/9 
}

sub DB::get_fork_TTY { return $ENV{fork_TTY}; }

my $pid;	
if ($pid = fork) {
	print "PARENT($$) setoff a child($pid) process\n";
	$DB::single=2;
	my $waited = waitpid($pid,0);
	print "PARENT($$) waited for child($waited)\n";
} else {
	die "cannot fork: $!" unless defined $pid;
	sleep(1);                      # just to give us a little space
	print "CHILD ($$) running...\n";
	$DB::single=2;
	print "CHILD ($$) done\n";
}

exit 0;

