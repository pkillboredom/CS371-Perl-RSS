#This script will generate valid RSS XML from news.ycombinator.com
#Luke Tomkus and Thomas Reilly

use WWW::Mechanize;
my $mech = WWW::Mechanize->new();
my $url = 'http://news.ycombinator.com';
$mech->get($url);

my $content = $mech->content();

my @titles = $content =~ /(?<=class="storylink">)([^<]+)/g;
my @urls = $content =~ /(?=[^"]+" class="storylink">)([^"]*)/g;

my $rssHeader = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n<rss version=\"2.0\">\n";
my $rssChannelInfo = "\t<channel>\n\t\t<title>HackerNews feed<\/title>\n\t\t<link>https://news.ycombinator.com/<\/link>\n\t\t<description>Hacker News Feed<\/description>\n";
my $rssChannelFooter = "\t<\/channel>\n";
my $rssFooter = "<\/rss>";

my @items;
#uses index to pair titles to urls
my $arraysize = scalar(@titles) - 1;
foreach my $index (0..$arraysize){
	my $title = $titles[$index];
	my $url = $urls[$index];
	$items[$index] = "\t\t<item>\n\t\t\t<title>$title<\/title>\n\t\t\t<link>$url<\/link>\n\t\t<\/item>";
}	

#Open file handle
my $outputFileName = 'news.rss.xml';
open(my $filehandle, '>', $outputFileName) or die "Opening file failed.";

print $filehandle $rssHeader;
print $filehandle $rssChannelInfo;
foreach my $item (@items){
	print $filehandle $item . "\n";
}
print $filehandle $rssChannelFooter;
print $filehandle $rssFooter;

close $filehandle;