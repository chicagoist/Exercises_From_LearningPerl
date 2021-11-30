#
# $Id: linecounter.pl,v 2.0 2004/01/02 01:22:37 perlref Exp $
#
# perl debugger reference demonstration program
#

use strict;
use FileHandle;

my @args = @ARGV;

# help requested?
my $help = grep(/^-h[elp]*$/i, @args);
if ($help) {
	print logg(help());
	exit 0;
}

my $verbose = grep(/^-v[erbose]*$/i, @args);

# get the pattern to match against.
my $REGEX = shift @args || '';

# get the files for processing.
my @files = grep(!/^-(h[elp]*|v[erbose]*)$/i, @args);
unless (@files) {
	push(@files, $0); 
	logg("using default $0 while no files given");
}

# loop through the files
foreach my $file (@files) {
	if (-f $file && -r _) {
		my $FH = FileHandle->new("< $file");
		if ($FH) {
			logg("file($file)");
			my %report = %{report($FH, $REGEX)}; # -> subroutine
			if (keys %report) {
				logg("the LINENO and CHARACTERS matching the pattern($REGEX) for '$file': ");
				foreach my $len (sort { $a <=> $b } keys %report) {
					print "    ".sprintf("%-10.d", $len)." $report{$len}\n";
				}
			} else {
				logg("no matching pattern($REGEX) found in '$file'");
			}
		} else { 
			error("failed to open file($file) $!");
		}
	} else {
		error("no such or unreadable file($file) $!");
	}
}

=item report

Report on the file

=cut

sub report {
	my $FH = shift;
	my $regex = shift;
	my %report = ();
	my $i_cnt  = 0;
	while (<$FH>) {
		$i_cnt++;
		my $i_match = 0;
		my $line = $_;
		if ($line =~ /($regex)/) {
			$report{$i_cnt} = $1; # 
			$i_match++; 
		} else {
			$i_match = 0;
		}
		logg("\t[$i_cnt] regex($regex) matched($i_match) <- $line");
	}	
	$FH->close;
	return \%report;
}

# end of script - exit nicely.
exit 0;

# utility functions below here:

sub help {
	return	qq|Usage: $0 pattern file [file]+ [-help] [-verbose]|."\n".
			qq|Example: perl $0 \^\.\*\\s*mat input_file|
	;
}

sub logg {
	my $msg = join("\n", @_)."\n";
	print STDOUT $msg if $verbose;
	return $msg;
}

sub error {
	my $error = shift;
	logg("Error: $error", @_);
}

