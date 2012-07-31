package APRoute;
use Dancer ':syntax';

get '/' => sub {
   redirect '/!ap/' ;
};