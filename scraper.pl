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
 use HTML::TreeBuilder::XPath;
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
 my @scrapped_data;

 #URL FUll
 #https://ecouncil.bayside.vic.gov.au/eservice/dialog/daEnquiry.do?number=&lodgeRangeType=on&dateFrom=01%2F11%2F2015&dateTo=30%2F11%2F2015&detDateFromString=&detDateToString=&streetName=&suburb=0&unitNum=&houseNum=0&planNumber=&strataPlan=&lotNumber=&propertyName=&searchMode=A&submitButton=Search
 
	
 my $session_url = 'https://ecouncil.bayside.vic.gov.au/eservice/dialog/daEnquiryInit.do?nodeNum=1121';
 my $url = 'https://ecouncil.bayside.vic.gov.au/eservice/dialog/daEnquiry.do?number=&lodgeRangeType=on&dateFrom=22%2F11%2F2015&dateTo=26%2F11%2F2015&suburb=0&houseNum=0&searchMode=A&submitButton=Search';

# Read out and parse a web page
 $ua->cookie_jar(HTTP::Cookies->new(file => "cookie_jar", autosave => 1));
 my $request = $ua->request(GET $session_url);

 #Second Request after we get the session cookie
 $request = $ua->request(GET $url);
 my $tb = HTML::TreeBuilder->new_from_content($request->content);

 foreach my $row ($tb->findnodes('//div[@id="fullcontent"]/div/h4[@class="non_table_headers"]'))
 {
	print Dumper $row;
	system("pause");
 }

# # Open a database handle
# my $dt = Database::DumpTruck->new({dbname => 'data.sqlite', table => 'data'});
#
# # Insert some records into the database
# $dt->insert([{
#     Name => 'Susan',
#     Occupation => 'Software Developer'
# }]);

