package Admin;
use Dancer ':syntax';

get '/!ap/' => sub {
   return 'It is admin Baby!!!';
};