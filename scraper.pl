# This is a template for a Perl scraper on morph.io (https://morph.io)
# including some code snippets below that you should find helpful
BEGIN {
 $ENV{HTTP_proxy}='http://melyproxyc1.oceania.cshare.net:8080';
 $ENV{HTTPS_proxy}='http://melyproxyc1.oceania.cshare.net:8080';
}
 use LWP::Simple qw($ua);
 use HTML::TreeBuilder;
 use Database::DumpTruck;
 use Data::Dumper;
 #use LWP::Debug qw(+);
 use HTTP::Request;
 use LWP::UserAgent;
 use HTTP::Request::Common;
 use HTTP::Cookies;
 use strict;
 use warnings;

 my $ua = LWP::UserAgent->new;
 $ua->proxy(['http', 'ftp', 'https'], 'http://melyproxyc1.oceania.cshare.net:8080');
 
 # Turn off output buffering
 #$| = 1;

 #URL FUll
 #https://ecouncil.bayside.vic.gov.au/eservice/dialog/daEnquiry.do?number=&lodgeRangeType=on&dateFrom=01%2F11%2F2015&dateTo=30%2F11%2F2015&detDateFromString=&detDateToString=&streetName=&suburb=0&unitNum=&houseNum=0&planNumber=&strataPlan=&lotNumber=&propertyName=&searchMode=A&submitButton=Search
 
	
 my $session_url = 'https://ecouncil.bayside.vic.gov.au/eservice/dialog/daEnquiryInit.do?nodeNum=1121';
 #$session_url = 'http://www.perlmonks.org//';
 my $url = 'https://ecouncil.bayside.vic.gov.au/eservice/dialog/daEnquiry.do?number=&lodgeRangeType=on&dateFrom=22%2F11%2F2015&dateTo=26%2F11%2F2015&suburb=0&houseNum=0&searchMode=A&submitButton=Search';

 #$url = 'http://www.google.com/';
# # Read out and parse a web page
 $ua->cookie_jar(HTTP::Cookies->new(file => "cookie_jar", autosave => 1));
 my $request = $ua->request(GET $session_url);

# print Dumper $request->content;
 #$request = new HTTP::Request('GET' => $url);
 #print Dumper $request->content;
 $request = $ua->request(GET $url);
# print Dumper $request->content;
 my $tb = HTML::TreeBuilder->new_from_content($request->content);

# print Dumper $tb;
 # Look for <tr>s of <table id="hello">
 my @rows = $tb->look_down(
     _tag => 'div',
	 sub { shift->parent->attr('id') eq 'fullcontent' }
 );

 print Dumper @rows;
# # Open a database handle
# my $dt = Database::DumpTruck->new({dbname => 'data.sqlite', table => 'data'});
#
# # Insert some records into the database
# $dt->insert([{
#     Name => 'Susan',
#     Occupation => 'Software Developer'
# }]);

# You don't have to do things with the HTML::TreeBuilder and Database::DumpTruck libraries.
# You can use whatever libraries you want: https://morph.io/documentation/perl
# All that matters is that your final data is written to an SQLite database
# called "data.sqlite" in the current working directory which has at least a table
# called "data".
