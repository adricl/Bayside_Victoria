# This is a template for a Perl scraper on morph.io (https://morph.io)
# including some code snippets below that you should find helpful
 
 use HTML::TreeBuilder;
 use Database::DumpTruck;
 use Data::Dumper;
 use HTML::TreeBuilder::XPath;
 use HTTP::Request;
 use LWP::UserAgent;
 use HTTP::Request::Common;
 use HTTP::Cookies;
 use strict;
 use warnings;

 my $ua = LWP::UserAgent->new;
 
 # Turn off output buffering
 #$| = 1;

 my $session_url = 'https://ecouncil.bayside.vic.gov.au/eservice/dialog/daEnquiryInit.do?nodeNum=1121';
 my $url = 'https://ecouncil.bayside.vic.gov.au/eservice/dialog/daEnquiry.do?number=&lodgeRangeType=on&dateFrom=22%2F11%2F2015&dateTo=26%2F11%2F2015&suburb=0&houseNum=0&searchMode=A&submitButton=Search';

 #We get a session cookie by going to the search page. 
 $ua->cookie_jar(HTTP::Cookies->new(file => "cookie_jar", autosave => 1));
 my $request = $ua->request(GET $session_url);

 #Second request, real request for website
 $request = $ua->request(GET $url);
 my $tb = HTML::TreeBuilder->new_from_content($request->content);

 #XPath us to the location we need
 my @row = ($tb->findnodes('//div[@id="fullcontent"]/div/h4[@class="non_table_headers"]'));
 my @data_rows;
 if (scalar @row > 0)
 {
#	print  $row[0]->parent->dump;
 	@data_rows = $row[0]->parent->content_list();
	print scalar(@data_rows)  . " how many rows\n";
 }

 my $count = 0;
 my @dbData;

# do 
# {
	my %row_data;
	my $curr_row;
	
	#Header info address, website
	$curr_row = $data_rows[$count];
	die if ($curr_row->tag ne 'h4');
	my $arr = $curr_row->look_down( _tag => 'a');
	$row_data{'address'} = ${$arr->content}[0];
	print $row_data{'address'} . "\n";
	$count ++;
	print "\n\n";

	#Body info tree 
	$curr_row = $data_rows[$count];
	die if ($curr_row->tag ne 'div');
	print $curr_row->as_HTML;
	$count ++;	
	print "\n\n";

	#3rd row is rubbish
	$curr_row = $data_rows[$count];
	die if ($curr_row->tag ne 'p');
	print $curr_row->as_HTML;
	$count ++;
# }
# while ($count < scalar @data)
# # Open a database handle
# my $dt = Database::DumpTruck->new({dbname => 'data.sqlite', table => 'data'});
#
# # Insert some records into the database
# $dt->insert([{
#     Name => 'Susan',
#     Occupation => 'Software Developer'
# }]);

