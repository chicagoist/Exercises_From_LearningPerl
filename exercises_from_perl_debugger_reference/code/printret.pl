
for (1..3) {
		my $var = call($_);
}

sub call {
		$DB::signal=1;
		return $_[0];
}

