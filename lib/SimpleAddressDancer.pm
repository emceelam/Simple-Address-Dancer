package SimpleAddressDancer;
use Dancer2;
use Dancer2::Plugin::Database;
use List::MoreUtils qw(mesh);
use Data::Dumper;

our $VERSION = '0.001';

get '/' => sub {
    template 'index' => { 'title' => 'SimpleAddressDancer' };
};

get '/hello' => sub {
    header 'Content-Type' => 'text/plain';
    return 'hello world';
};

=begin comment
street VARCHAR(80),
  city   VARCHAR(40),
  state  VARCHAR(2),
  zip    INT(5),
  lat    FLOAT,  /* latitude */
  lng   =end comment
=cut
get '/api/addresses' => sub {
    my $sth = database()->prepare('
      SELECT id, street, city, state, zip, lat, lng
        FROM addresses
    ');
    $sth->execute();
    my $rows = $sth->fetchall_arrayref();
    my @fields = qw/id street city state zip lat lng/;
    my @rows_hash = map { { mesh ( @fields, @$_ ) } } @$rows;

    header 'Content-Type' => 'application/json';  
    return to_json (\@rows_hash);
};

get '/api/addresses/:id' => sub {
    my $sth = database()->prepare('
      SELECT id, street, city, state, zip, lat, lng
        FROM addresses
        WHERE id=?
    ');
    $sth->execute(route_parameters->get('id'));
    my $row = $sth->fetchrow_hashref();
    return to_json ($row);
};

post '/api/addresses' => sub {
    my $body_parameters = body_parameters();
    debug to_json $body_parameters;
};


true;
