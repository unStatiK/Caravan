package xforum::Controller::thread;
use Moose;
use Switch;
use HTML::BBCode;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

xforum::Controller::thread - Catalyst Controller

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
                 my $page = $c->request->params->{page};
                 $c->stash->{page} = $page;
                 $c->stash->{idt} = $id;
                 my @arr_r = $c->model('xf')->getreplys($id,$page);
                 @{$c->stash->{repls}} = @arr_r;
                 my @rows;
                 my @arr_at;
                 my $i = 0;
                   for (@arr_r){
                     $arr_at[$i][0] = $c->model('xf')->getgmlevel($arr_r[$i][0]->f_id_acc);
                     $arr_at[$i][1] = $c->model('xf')->getauthor($arr_r[$i][0]->f_id_acc);
                     $arr_at[$i][2] = $c->model('xf')->getava($arr_r[$i][0]->f_id_acc);
                     $i = $i + 1;
                   }
                 @{$c->stash->{arr_at}} = @arr_at;
                 my $id_ = $c->model('xf')->getidboard($id);
                   if($id_ ne 0){
                     $c->stash->{nameb} = $c->model('xf')->getboardname($id_);
                   }
                 $c->stash->{namet} = $c->model('xf')->gethemename($id);
                 $c->stash->{idb} = $id_;

                 my @pages;
                 my $num_rpl = $c->model('xf')->getsumreplys($id);
                 my $num_pg = $num_rpl / 10;
                 $num_pg = int($num_pg);
                 if($num_pg == 0){$num_pg = 1;}
                 elsif(((10 * $num_pg) != $num_rpl) && ($num_pg > 0) ){$num_pg = $num_pg + 1;}
                 $c->stash->{pages} = $num_pg;

                 $c->stash->{is_close} =  $c->model('xf')->checkclosetheme($id);


if(defined $c->session->{id} && defined $c->session->{user}){
        $c->stash->{auth} = 0;
        $c->stash->{username} = $c->session->{user};
        $c->stash->{userid} = $c->session->{id};
     }else{
        $c->stash->{auth} = 1;
        $c->stash->{username} = '';
        $c->stash->{userid} = 0;
      }

                 if(defined $c->request->params->{psw}){
                    if ($c->request->params->{psw} =~ m/^[a-z]{1,5}$/){
                        switch($&){
                            case "error" {
                                $c->stash->{error} = "пароль или логин неверен !!!";
                            }
                            else{
                                $c->redirect("/thread/".$id."/?page=1");
                            }
                        }
                    }else{
                        $c->redirect("/thread/".$id."/?page=1");
                     }
                 }
                 $c->stash->{lastuser} = $c->model('xf')->getauthor($c->model('xf')->getlastuser());
                 $c->stash->{sum_u} = $c->model('xf')->getsumusers();

                 $c->stash->{template} = 'thread.tt';
                 
           }else{
             $c->redirect('/');
            }
         }else{
             $c->redirect('/');
          }
 }

}
sub reply :Local{
    my ( $self, $c ) = @_;
   if(defined $c->request->params->{idt} && defined $c->request->params->{ida} && defined $c->request->params->{mytxtarea}){  
    my $bbc  = HTML::BBCode->new({allowed_tags => ['b','i','u','url','list','quote','code','img'],linebreaks => 1,stripscripts=> 1});
    my $reqq = $c->request->params->{mytxtarea};
    $reqq =~ s/</&lt;/g;
    $reqq =~ s/>/&gt;/g;
    my $html = $bbc->parse($reqq);
    $bbc->{html} =~ s/([[:print:]]{70}+)/$1&shy;/g;
    $c->model('xf')->addreply($c->request->params->{ida},$c->request->params->{idt},$bbc->{html});
    $c->redirect("/thread/".$c->request->params->{idt}."/?page=1");
  }else{
    $c->redirect('/');
   }
}
sub add :Local{
    my ( $self, $c ) = @_;
   if(defined $c->request->params->{namet} && defined $c->request->params->{idb} && defined $c->request->params->{ida} && defined $c->request->params->{mytxtarea}){
      my $temp = $c->request->params->{namet};
      $temp =~ s/^\s+//;
      $temp =~ s/\s+$//;
     if($temp ne ''){
       $temp = $c->request->params->{mytxtarea};
       $temp =~ s/^\s+//;
       $temp =~ s/\s+$//;
       if($temp ne ''){

    my $reqq = $c->request->params->{mytxtarea};
    $reqq =~ s/</&lt;/g;
    $reqq =~ s/>/&gt;/g;
        my $bbc  = HTML::BBCode->new({allowed_tags => ['b','i','u','url','list','quote','code','img'],linebreaks => 1,stripscripts=> 1});
        my $html = $bbc->parse($reqq);
        $bbc->{html} =~ s/([[:print:]]{70}+)/$1&shy;/g;
        my $idt = $c->model('xf')->addthread($c->request->params->{idb},$c->request->params->{ida},$c->request->params->{namet},$bbc->{html});
        $c->redirect("/thread/".$idt."/?page=1");
      }else{
     $c->redirect('/');
      }
     }else{
    $c->redirect('/');
      }
   }else{
    }
}
=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
