package xforum::Model::xf;

use strict;
use base 'Catalyst::Model::DBIC::Schema';
use Date::Format;
__PACKAGE__->config(
    schema_class => 'xforum::Schema',

    connect_info => {
        dsn => 'dbi:Pg:dbname=xforum',
        user => 'xforum',
        password => '--xforum17',
    }
);


sub checkip{
   my($self,$c) = @_;
   my $row=$self->resultset('Ipfilter')->search({ip => [$_[1]]},{select => ['id']});
     if($row->count gt 0){return 1;}else{return 0;}
}

sub checkpsw{
 my($self,$c) = @_;
   my @arr;
   my $row=$self->resultset('Account')->search({id => [$_[1]]},{select => ['sha_pass_hash']});
    if($row->count gt 0){
       my $val = $row->first;
        if($val->sha_pass_hash eq $_[2]){
          return 0;
        }else{
          return 1;
         }
    }else{
       return 1;
     }
}

sub checkclosetheme{
   my($self,$c) = @_;
     my $row = $self->resultset('Theme')->search({id => $_[1]},{select => ['status']});
     my $val = $row->first;
   return $val->status;
}
sub getcategories{
 my($self,$c) = @_;
 my @arr2;
 my $row;
 my $i = 0;
   my $rows = $self->resultset('Category')->search({},{select => ['id','name'],order_by => ['ind']});
     while($row = $rows->next){
        $arr2[$i] = $row;
        $i = $i + 1;
     }
   return @arr2;
}
sub getboards{
 my($self,$c) = @_;
 my @arr;
 my $rows;
 my $i = 0;
 foreach $rows ( @{$_[1]} ){
     $arr[$i] = $self->resultset('Board')->search({f_id_cat => $rows->id},{select => ['id','name','description']});
     $i = $i + 1;
 }
return @arr;
}
sub getboardname{
   my($self,$c) = @_;
     my $row = $self->resultset('Board')->search({id => $_[1]},{select => ['name']});
     my $val = $row->first;
   return $val->name;
}
sub getidboard{
   my($self,$c) = @_;
     my $row = $self->resultset('Theme')->search({id => $_[1]},{select => ['f_id_bor']});
     my $val = $row->first;
   return $val->f_id_bor;
}
sub gethemename{
   my($self,$c) = @_;
     my $row = $self->resultset('Theme')->search({id => $_[1]},{select => ['name']});
     my $val = $row->first;
   return $val->name;
}
sub getadvert{
   my($self,$c) = @_;
   my $i = 0;
   my @arr;
   my $row;
     my $rows = $self->resultset('Theme')->search({-and => [f_id_bor => 0,type=> 3]},{select => ['id','name','author']});
     while($row = $rows->next){
        $arr[$i] = $row;
        $i = $i + 1;
     }
     return @arr;
}
sub getattachthemes{
   my($self,$c) = @_;
   my $i = 0;
   my @arr;
   my $row;
     my $rows = $self->resultset('Theme')->search({-and => [f_id_bor => $_[1],type=> 2]});
     while($row = $rows->next){
        $arr[$i] = $row;
        $i = $i + 1;
     }
     return @arr;
}
sub gethemes{
   my($self,$c) = @_;
   my $i = 0;
   my @arr;
   my $row;
   my $row_;
   my $val;
     my $rows = $self->resultset('Theme')->search({-and => [f_id_bor => $_[1], type => 1]},{page=>$_[2],rows=>20});
     while($row = $rows->next){
 #     $row_ = $self->resultset('Theme')->search({id => $row->id},{select => ['date'],as=>['type']});
 #     $val = $row_->first;
        $arr[$i] = $row;
        $i = $i + 1;
     }
     return @arr;
}
sub getreplys{
   my($self,$c) = @_;
   my $i = 0;
   my @arr;
   my $row;
   my $str;
   my $row_;
   my $val;
     my $rows = $self->resultset('Reply')->search({f_id_them => $_[1]},{select => ['id'],order_by => ['id']},{page=>$_[2],rows=>10});
#     my $rows = $self->resultset('Reply')->search({f_id_them => $_[1]},{select => ['id']},{page=>$_[2],rows=>10});
     while($row = $rows->next){
      $row_ = $self->resultset('Reply')->search({id => $row->id},{select => ['date'],as=>['content']});
        $arr[$i][0] = $row;
      $val = $row_->first;
        $arr[$i][1] = $val->content;
        $i = $i + 1;
     }
     return @arr;
}
sub getauthor{
   my($self,$c) = @_;
     my $row = $self->resultset('Account')->search({id => $_[1]},{select=>['username']});
     my $val = $row->first;
      return $val->username;
}

sub getiduser{
   my($self,$c) = @_;
     my $row = $self->resultset('Account')->search({username => $_[1]},{select=>['id']});
     my $val = $row->first;
      return $val->id;
}

sub getgmlevel{
   my($self,$c) = @_;
     my $row = $self->resultset('Account')->search({id => $_[1]},{select=>['gmlevel']});
     my $val = $row->first;
      return $val->gmlevel;
}
sub getava{
   my($self,$c) = @_;
     my $row = $self->resultset('Extaccount')->search({f_id_acc => $_[1]},{select=>['ava']});
     my $val = $row->first;
      return $val->ava;
}
sub getlastuser{
   my($self,$c) = @_;
     my $row = $self->resultset('Account')->search({},{select => [ { max => 'id' }] , as => 'id' });
     my $val = $row->first;
      return $val->id;
}
sub getsumthemes{
   my($self,$c) = @_;
     my $row = $self->resultset('Theme')->search({-and => [f_id_bor => $_[1], type => 1]},{select => ['id']});
      return $row->count;
}
sub getsumusers{
   my($self,$c) = @_;
     my $row = $self->resultset('Account')->search(undef,{select => [ count => 'id']});
      return $row->count;
}
sub getsumreplys{
   my($self,$c) = @_;
     my $row = $self->resultset('Reply')->search({f_id_them => $_[1]},{select => ['id']});
      return $row->count;
}
sub getnumanswers{
   my($self,$c) = @_;
     my $row = $self->resultset('Reply')->search({f_id_them => $_[1]},{select => ['id']});
      return $row->count;
}
sub addaccount{
   my($self,$c) = @_;
   my $row = $self->resultset('Account')->create({username => $_[2],sha_pass_hash => $_[1]});
   $self->resultset('Ipfilter')->create({ip => $_[3], f_id_acc => $row->id });
   $self->resultset('Extaccount')->create({f_id_acc => $row->id, ava =>'' });
}
sub addreply{
   my($self,$c) = @_;
   $self->resultset('Reply')->create({f_id_acc => $_[1],f_id_them => $_[2],content => $_[3]});
}
sub addthread{
   my($self,$c) = @_;
   my $row = $self->resultset('Theme')->create({name => $_[3],type => 1,f_id_bor => $_[1],author => $_[2], status => 1 });
   $self->resultset('Reply')->create({f_id_acc => $_[2],f_id_them => $row->id ,content => $_[4]});
   return $row->id;
}
sub updatepsw{
   my($self,$c) = @_;
   my $row=$self->resultset('Account')->search({id => [$_[1]]},{select => ['sha_pass_hash']});
    if($row->count gt 0){
      $row->update({sha_pass_hash=>$_[2]});
    }
}
sub updateava{
   my($self,$c) = @_;
   my $row=$self->resultset('Extaccount')->search({f_id_acc => [$_[1]]},{select => ['ava']});
   if($row->count gt 0){
   my $val = $row->first;
   unlink("/var/www/st_xforum/ava/".$val->ava);
   $row->update({ava=>$_[2]});
   }
}
sub checklogin{
   my($self,$c) = @_;
   my @arr;
   $arr[0] = 1;
   my $row=$self->resultset('Account')->search({username => [$_[1]]},{select => ['sha_pass_hash','id']});
    if($row->count gt 0){
       my $val = $row->first;
        if($val->sha_pass_hash eq $_[2]){
          $arr[1] = $val->id;
          $arr[2] = $_[1];
          $arr[0] = 0;
        }
    }
   return @arr;
}

sub checknick{
   my($self,$c) = @_;
   my $row=$self->resultset('Account')->search({username => [$_[1]]},{select => ['username']});
    if($row->count gt 0){
          return 1;
    }else{
          return 0;
     }
}

=head1 NAME

xforum::Model::xf - Catalyst DBIC Schema Model

=head1 SYNOPSIS

See L<xforum>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<xforum::Schema>

=head1 GENERATED BY

Catalyst::Helper::Model::DBIC::Schema - 0.41

=head1 AUTHOR

root

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
