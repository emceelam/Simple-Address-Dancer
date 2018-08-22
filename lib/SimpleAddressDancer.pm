package SimpleAddressDancer;
use Dancer2;

our $VERSION = '0.1';

get '/' => sub {
    template 'index' => { 'title' => 'SimpleAddressDancer' };
};

true;
