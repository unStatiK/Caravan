package RDroute;
use Dancer ':syntax';

get '/profile' => sub {
   redirect '/profile/' ;
};

get '/logout/' => sub {
   redirect '/logout' ;
};

get '/board/newthread/' => sub {
   redirect '/board/newthread' ;
};