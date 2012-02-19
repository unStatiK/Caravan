package xforum::Controller::newreg;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

xforum::Controller::newreg - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    my $r = 0;
    $c->stash->{nick} = '';
    $c->stash->{error} = '';
        if ( defined $c->request->params->{nick} && $c->request->params->{nick} ne "" && defined $c->request->params->{psw} && $c->request->params->{psw} ne "" && defined $c->request->params->{repsw} && $c->request->params->{repsw} ne ""){
           my @post = $c->model('validata')->validata($c->request->params->{nick},$c->request->params->{psw},$c->request->params->{repsw});
            if(defined $post[0]){
               if(defined $post[1] && defined $post[2]){
                 if($post[1] eq $post[2]){
                    if($c->model('xf')->checkip($c->request->address) eq 0){
                         if($c->model('xf')->checknick($post[0]) eq 0){
                           $c->model('xf')->addaccount($c->model('account')->to_hex($post[0],$post[1]),$post[0],$c->request->address);
                           my $var = $c->model('xf')->getiduser($post[0]);
                           $c->session->{id} = $var;
                           $c->session->{user} = $post[0];
                           undef $r;
                           $c->redirect('/'); 
                          }else{
                            $c->stash->{error} = "это имя уже занято !!!";
                          }
                    }else{
                       $c->stash->{error} = "с этого ip адресса уже создан !!!";
                     }
                 }else{
                   $c->stash->{nick} = $post[0];
                   $c->stash->{error} = "пароли не совпадают !!!";
                  }
               }else{
                 $c->stash->{nick} = $post[0];
                 $c->stash->{error} = "неправильные символы в пароле !!!";
                }
            }else{
              $c->stash->{error}="неправильный nickname !!!";
             }
        }
   if(defined $r){
      $c->stash->{template} = 'reg.tt';
   }
}

sub default :Path {
    my ( $self, $c ) = @_;
    $c->redirect('/');
}


=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
