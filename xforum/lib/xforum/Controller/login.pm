package xforum::Controller::login;
use Moose;
use Switch;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

xforum::Controller::login - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    my $err;
     if(defined $c->request->params->{login} && defined $c->request->params->{psw} && defined $c->request->params->{type}){
         my @post = $c->model('validata')->validata($c->request->params->{login},$c->request->params->{psw});
            if(defined $post[0]){
               if(defined $post[1]){
                 my @var = $c->model('xf')->checklogin($post[0],$c->model('account')->to_hex($post[0],$post[1]));
                   if($var[0] eq 0){
                     $c->session->{id} = $var[1];
                     $c->session->{user} = $var[2];
                     $err = 1;
                   }
               }
            }
     }
   if(defined $err){
         switch($c->request->params->{type}){
              case "forum" {
                 $c->redirect('/');
              }
              case "board" {
                 if ($c->request->params->{idb} =~ m/^[0-9]{1,4}$/){
                         if ($c->request->params->{page} =~ m/^[0-9]{1,4}$/){
                              $c->redirect('/board/'.$c->request->params->{idb}.'/?page='.$c->request->params->{page});
                        }else{
                           $c->redirect('/');
                         }
                 }else{
                    $c->redirect('/');
                  }
              }
              case "thread" {
                 if ($c->request->params->{idt} =~ m/^[0-9]{1,4}$/){
                         if ($c->request->params->{page} =~ m/^[0-9]{1,4}$/){
                              $c->redirect('/thread/'.$c->request->params->{idt}.'/?page='.$c->request->params->{page});
                        }else{
                           $c->redirect('/');
                         }
                 }else{
                    $c->redirect('/');
                  }
              }
              else{
                 $c->redirect('/');
              }
          }
   }else{
         switch($c->request->params->{type}){
              case "forum" {
                 $c->redirect('/?psw=error');
              }
              case "board" {
                if ($c->request->params->{idb} =~ m/^[0-9]{1,4}$/){
                         if ($c->request->params->{page} =~ m/^[0-9]{1,4}$/){
                               $c->redirect('/board/'.$c->request->params->{idb}.'/?page='.$c->request->params->{page}.'&psw=error');
                         }else{
                            $c->redirect('/');
                          }
                 }else{
                    $c->redirect('/');
                  }
              }
              case "thread" {
                if ($c->request->params->{idt} =~ m/^[0-9]{1,4}$/){
                         if ($c->request->params->{page} =~ m/^[0-9]{1,4}$/){
                               $c->redirect('/thread/'.$c->request->params->{idt}.'/?page='.$c->request->params->{page}.'&psw=error');
                         }else{
                            $c->redirect('/');
                          }
                 }else{
                    $c->redirect('/');
                  }
              }
              else{
                 $c->redirect('/');
              }
          }
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
