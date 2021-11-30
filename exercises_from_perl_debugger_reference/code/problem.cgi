use CGI;
my $o_cgi = new CGI();

my %data = (
	name    => $o_cgi->param('Name')    || 'UNKNOWN',
	company => $o_cgi->param('company') || 'UNKNOWN',
);

$data{name} =~ s/^(.)?(.+)$/uc($1);lc($2)/e;

print $o_cgi->header(-type=>'text/html'),
      $o_cgi->start_html(-title=>'Perl Debugger Tutorial'),
      qq|
	<hr>
	Hi <b>$data{name}</b> welcome to the <i>$data{company}</i> debugger home page!
	<hr>
|,    $o_cgi->end_html."\n";
 
exit 0;

