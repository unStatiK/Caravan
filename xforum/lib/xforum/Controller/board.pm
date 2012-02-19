package xforum::Controller::board;
use Moose;
use Switch;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

xforum::Controller::board - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(1) {
    my ( $self, $c ,$id) = @_;

       if ($id !~ m/^[0-9]{1,4}$/){
              $c->redirect('/');
       }else{
         if(defined $c->request->params->{page}){
           if ($c->request->params->{page} =~ m/^[0-9]{1,3}$/){
              my $page = $&;
              $c->stash->{idb} = $id;
              $c->stash->{nameb} = $c->model('xf')->getboardname($id);
              $c->stash->{page} = $page;
              my @arr_ = $c->model('xf')->gethemes($id,$page);
              @{$c->stash->{arr_them}} = @arr_;
              my @arr_a;
              my @arr_an;
              my $rows;
              my $i = 0;
               for $rows (@arr_){
                $arr_a[$i] = $c->model('xf')->getauthor($rows->author);
                $arr_an[$i] = $c->model('xf')->getnumanswers($rows->id);
                $i = $i + 1;
               }
              @{$c->stash->{arr_authr}} = @arr_a;
              @{$c->stash->{arr_answ}} = @arr_an;

              @arr_ = $c->model('xf')->getattachthemes($id);
              @{$c->stash->{arr_them_a}} = @arr_;
              $i = 0;
               for $rows (@arr_){
                $arr_a[$i] = $c->model('xf')->getauthor($rows->author);
                $arr_an[$i] = $c->model('xf')->getnumanswers($rows->id);
                $i = $i + 1;
               }
              @{$c->stash->{arr_authr_a}} = @arr_a;
              @{$c->stash->{arr_answ_a}} = @arr_an;

              @arr_ = $c->model('xf')->getadvert();
              @{$c->stash->{arr_adv}} = @arr_;
              $i = 0;
              for $rows (@arr_){
                 $arr_a[$i] = $c->model('xf')->getauthor($rows->author);
                 $i = $i + 1;
              }
              @{$c->stash->{arr_a}} = @arr_a;
              my @pages;
              my $num_tm = $c->model('xf')->getsumthemes($id);
              my $num_pg = $num_tm / 20;
              $num_pg = int($num_pg);
                 if($num_pg == 0){$num_pg = 1;}
                 elsif(((20 * $num_pg) != $num_tm) && ($num_pg > 0) ){$num_pg = $num_pg + 1;}
              $c->stash->{pages} = $num_pg;

           }else{
              $c->redirect('/');
            }
         }else{
            $c->redirect('/');
          }
        }

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
                    $c->redirect("/board/".$id."/?page=1");
                  }
                }
           }else{
              $c->redirect("/board/".$id."/?page=1");
           }
     }
     $c->stash->{lastuser} = $c->model('xf')->getauthor($c->model('xf')->getlastuser());
     $c->stash->{sum_u} = $c->model('xf')->getsumusers();

    $c->stash->{template} = 'board.tt';
}

sub newthread :Local{
    my ( $self, $c ) = @_;

if(defined $c->session->{id} && defined $c->session->{user}){
        $c->stash->{auth} = 0;
        $c->stash->{username} = $c->session->{user};
        $c->stash->{userid} = $c->session->{id};
        $c->stash->{nameb} = $c->model('xf')->getboardname($c->request->params->{idb});
        $c->stash->{idb} = $c->request->params->{idb};
        $c->stash->{template} = 'newthread.tt';
     }else{
        $c->stash->{auth} = 1;
        $c->stash->{username} = '';
        $c->redirect('/');
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
