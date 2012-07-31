package Test;
use Dancer ':syntax';

get '/test' => sub {
   template 'index2' ;
};

