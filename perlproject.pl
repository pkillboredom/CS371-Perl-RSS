#This script will generate valid RSS XML from news.ycombinator.com
#Luke Tomkus and Thomas Reilly

use WWW::Mechanize;
my $mech = WWW::Mechanize->new();
my $url = 'http://news.ycombinator.com';
$mech->get($url);

my $content = $mech->content();

my @titles = $content =~ /(?<=class="storylink">)([^<]+)/g;
my @urls = $content =~ /(?=[^"]+" class="storylink">)([^"]*)/g;


#Test print, RSS formatting not proper
foreach my $title ( @titles ){
	print "<title>$title</title>\n";
}

foreach my $title ( @titles ){
	print "<description>$title</description>\n";
}

foreach my $url ( @urls ){
	print "<link>$url</link>\n";
}
