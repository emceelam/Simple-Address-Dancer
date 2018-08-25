package SimpleAddressDancer;
use Dancer2;
use Dancer2::Plugin::Database;
use List::MoreUtils qw(mesh);
use Data::Dumper;

our $VERSION = '0.001';

get '/api/addresses' => sub {
    my $sth = database()->prepare('
      SELECT id, street, city, state, zip, lat, lng
        FROM addresses
    ');
    $sth->execute();
    my $rows = $sth->fetchall_arrayref();
    my @fields = qw/id street city state zip lat lng/;
    my @rows_hash = map { { mesh ( @fields, @$_ ) } } @$rows;

    return \@rows_hash;
};

get '/api/addresses/:id' => sub {
    my $sth = database()->prepare('
      SELECT id, street, city, state, zip, lat, lng
        FROM addresses
        WHERE id=?
    ');
    $sth->execute(route_parameters()->get('id'));
    my $row = $sth->fetchrow_hashref();
    return $row;
};

post '/api/addresses' => sub {
    my $address = request()->params();
    my $sth = database()->prepare("
      SELECT id
        FROM addresses
        WHERE street=?
          AND city=?
          AND state=?
          AND zip=?
    ");
    $sth->execute(@{$address}{qw/street city state zip/});
    my ($id) = $sth->fetchrow_array();
    if ($id) {
      $address->{id} = $id;
      return $address;
    }

    $sth = database()->prepare("
      INSERT INTO addresses (street, city, state, zip)
        VALUES (?,?,?,?)
    ");
    $sth->execute(@{$address}{qw/street city state zip/});
    $id = database()->last_insert_id("", "", "", "");
    $address->{id} = $id;
    status 201;
    return $address;
};

put '/api/addresses/:id' => sub {
    my $address = params();
    my $id = route_parameters()->get('id');
    my $sth = database()->prepare('
      UPDATE addresses
        SET street=?, city=?, state=?, zip=?, lat=?, lng=?
        WHERE id=?
    ');
    $sth->execute(@{$address}{qw/street city state zip/}, undef, undef, $id);

    my $err = $sth->err();
    my $row_val = $sth->rows();
    if (! $row_val ) {
      status 404;
      return {message => 'no rows found'};
    }

    status 202;
    $address->{id} = $id;
    return $address;
};

del '/api/addresses/:id' => sub {
    my $sth = database()->prepare('
      DELETE FROM addresses
        WHERE id=?
    ');
    $sth->execute(route_parameters()->get('id'));
    status 204;
    return {message => 'delete'};
};


true;
