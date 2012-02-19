package xforum::Controller::Root;
use Moose;
use Switch;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=head1 NAME

xforum::Controller::Root - Root Controller for xforum

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
     if(defined $c->session->{id} && defined $c->session->{user}){
        $c->stash->{auth} = 0;
        $c->stash->{username} = $c->session->{user};
     }else{
        $c->stash->{auth} = 1;
        $c->stash->{username} = '';
      }
     
     if(defined $c->request->params->{psw}){
           if ($c->request->params->{psw} =~ m/^[a-z]{1,5}$/){
                switch($&){
                  case "error" {
                       $c->stash->{error} = "пароль или логин неверен !!!";
                  }
                  else{
                    $c->redirect('/');
                  }
                }
           }else{
              $c->redirect('/');
           }
     }
     my @arr3 = $c->model('xf')->getcategories();
     @{$c->stash->{arr_cat}} = @arr3;
     my @arr_boarr = $c->model('xf')->getboards(\@arr3);
     @{$c->stash->{arr_boar}} = @arr_boarr;

     my @arr_ = $c->model('xf')->getadvert();
     @{$c->stash->{arr_adv}} = @arr_;
     my @arr_a;
     my $rows;
     my $i = 0;
     for $rows (@arr_){
        $arr_a[$i] = $c->model('xf')->getauthor($rows->author);
        $i = $i + 1;
     }
     @{$c->stash->{arr_a}} = @arr_a;
     $c->stash->{lastuser} = $c->model('xf')->getauthor($c->model('xf')->getlastuser());
     $c->stash->{sum_u} = $c->model('xf')->getsumusers();
     $c->stash->{template} = 'forum.tt';
}

sub default :Path {
    my ( $self, $c ) = @_;
    $c->redirect('/');
}


=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Catalyst developer

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;



package xforum::Controller::forum;
use Moose;
use Switch;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

xforum::Controller::forum - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
     if(defined $c->session->{id} && defined $c->session->{user}){
        $c->stash->{auth} = 0;
        $c->stash->{username} = $c->session->{user};
     }else{
        $c->stash->{auth} = 1;
        $c->stash->{username} = '';
      }
     
     if(defined $c->request->params->{psw}){
           if ($c->request->params->{psw} =~ m/^[a-z]{1,5}$/){
                switch($&){
                  case "error" {
                       $c->stash->{error} = "пароль или логин неверен !!!";
                  }
                  else{
                    $c->redirect('/');
                  }
                }
           }else{
              $c->redirect('/');
           }
     }
     my @arr3 = $c->model('xf')->getcategories();
     @{$c->stash->{arr_cat}} = @arr3;
     my @arr_boarr = $c->model('xf')->getboards(\@arr3);
     @{$c->stash->{arr_boar}} = @arr_boarr;

     my @arr_ = $c->model('xf')->getadvert();
     @{$c->stash->{arr_adv}} = @arr_;
     my @arr_a;
     my $rows;
     my $i = 0;
     for $rows (@arr_){
        $arr_a[$i] = $c->model('xf')->getauthor($rows->author);
        $i = $i + 1;
     }
     @{$c->stash->{arr_a}} = @arr_a;
     $c->stash->{template} = 'forum.tt';
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
