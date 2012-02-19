package xforum::Controller::profile;
use Moose;
use namespace::autoclean;
use Image::Info qw(image_type image_info);
use Image::Resize;
use Switch;
use Data::Uniqid qw (luniqid);
BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

xforum::Controller::profile - Catalyst Controller

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
        $c->stash->{user} = $c->session->{user};
        $c->stash->{ava} = $c->model('xf')->getava($c->session->{id});
        if($c->stash->{ava} eq ''){
          $c->stash->{nullava} = "no avatar";
        }
         if(defined $c->request->params->{error_}){
           if ($c->request->params->{error_} =~ m/^[a-z]{1,8}$/){
                switch($&){
                  case "badfile" {
                       $c->stash->{error_} = "файл не является графическим или битый !!!"; 
                  }
                  case "size" {
                       $c->stash->{error_} = "размеры файла не должны превышать 30кб !!!"; 
                  }
                  case "type" {
                       $c->stash->{error_} = "данный тип файла загружать запрещено !!!"; 
                  }
                  case "data" {
                       $c->stash->{derror_} = "неверные данные !!!"; 
                  }
                  else{
                   $c->redirect('/profile');
                  }
                }
           }else{
              $c->redirect('/profile');
            }
         }
         if(defined $c->request->params->{action}){
           if ($c->request->params->{action} =~ m/^[a-z]{1,5}$/){
                switch($&){
                  case "succ" {
                       $c->stash->{succ} = "пароль изменён !!!"; 
                  }
                  else{
                    $c->redirect('/profile');
                  }
                }
           }else{
              $c->redirect('/profile');
           }
         }
        $c->stash->{template} = 'profile.tt';
        
    }else{
        $c->stash->{auth} = 1;
        $c->stash->{user} = '';
        $c->redirect('/');
     }
}

sub save :Local{
    my ( $self, $c ) = @_;
    my $r;
    my $avapath = "/var/www/st_xforum/ava/";
    $c->response->headers->header( 'Expect: ' => '' );
    if(defined $c->session->{id} && defined $c->session->{user}){
      my $error;
         if(defined $c->request->upload('file_')){
             my $f_rsz;
             my $gd;
             my $fname;
             my $upload = $c->request->upload('file_');
               if($upload->size <= 30720 && $upload->size > 0){
                  my $type = image_type($upload->tempname);
                     if($type->{error}){
                         $error = "badfile";
                     }else{
                        my $info = image_info($upload->tempname);
                          if ($info->{error}){
                            $error = "badfile";
                          }else{
                            my $h = $info->{height};
                            my $w = $info->{width};
                               if($h > 100 || $w > 100){
                                     $f_rsz = 1;
                               }
                            my $un = luniqid;
                               if(defined $f_rsz){
                                  my $image = Image::Resize->new($upload->tempname);
                                  $gd = $image->resize(100, 100);
                               }
                            switch ($type->{file_type}){
	                       case "GIF"{ 
                                  $fname = $un.".gif";
                                     if(defined $f_rsz){
                                          open(FH, '> '.$avapath.$fname);
                                          print FH $gd->gif();
                                          close(FH);
                                      }else{
                                          $upload->copy_to($avapath.$fname);
                                       }
                               }
	                       case "JPEG"{ 
                                  $fname = $un.".jpg";
                                     if(defined $f_rsz){
                                          open(FH, '> '.$avapath.$fname);
                                          print FH $gd->jpeg();
                                          close(FH);
                                     }else{
                                          $upload->copy_to($avapath.$fname);
                                      }
                                }
	                        case "PNG"{ 
                                  $fname = $un.".png";
                                      if(defined $f_rsz){
                                          open(FH, '> '.$avapath.$fname);
                                          print FH $gd->png();
                                          close(FH);
                                  }else{
                                          $upload->copy_to($avapath.$fname);
                                   }
                                }
        	                else{
                                   $error="type";  
                                }
                            }
                             if(!defined $error){
                                 $c->model('xf')->updateava($c->session->{id},$fname);
                                 unlink($upload->tempname);
                            }
                           }
                      }
               }else{
                 $error = "size";
                }
           if(defined $error){
              $r = 1;
              unlink($upload->tempname);
              $c->redirect("/profile/?error_=".$error);
           }            
         }  

      if(defined $c->request->params->{actpsw} && defined $c->request->params->{newpsw} && defined $c->request->params->{renewpsw}){
        my @post = $c->model('validata')->validatapsw($c->request->params->{actpsw},$c->request->params->{newpsw},$c->request->params->{renewpsw});
            if(defined $post[0] && defined $post[1] && defined $post[2]){
               my $hex = $c->model('account')->to_hex($c->session->{user},$post[0]);
               if($c->model('xf')->checkpsw($c->session->{id},$hex) eq 0){
                 if($post[1] eq $post[2]){
                   $hex = $c->model('account')->to_hex($c->session->{user},$post[1]);
                   $c->model('xf')->updatepsw($c->session->{id},$hex);
                   $r = 1;
                   $c->redirect("/profile/?action=succ");
                 }else{
                   $error = "data";
                  }
               }else{
                  $error = "data";
                }
            }else{
              $error = "data";
             }
         if(defined $error){
              $r = 1;
              $c->redirect("/profile/?error_=".$error);
         }            
      }
    }
  if(!defined $r){
      $c->redirect("/profile");
  }
}

sub default :Path {
    my ( $self, $c ) = @_;
    $c->redirect('/profile');
}

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
