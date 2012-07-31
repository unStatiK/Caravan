package DBFunction;
use Dancer::Plugin::DBIC 'schema';
use Digest::SHA2;
use Dancer qw (setting);


sub checklogin{
   my @arr;
   $arr[0] = 1;
   my $row=schema->resultset('Account')->search({username => [$_[0]]},{select => ['psw','id']});
    if($row->count > 0){
       my $val = $row->first;
       my $sha2obj = new Digest::SHA2 256;
       $sha2obj->add($_[1]);
       my $digest = $sha2obj->hexdigest();
        if($val->psw eq $digest){
          $arr[1] = $val->id;
          $arr[0] = 0;
        }
    }
   return @arr;
}

sub checkpsw{
   my @arr;
   my $row=schema->resultset('Account')->search({id => [$_[0]]},{select => ['psw']});
    if($row->count > 0){
       my $val = $row->first;
       my $sha2obj = new Digest::SHA2 256;
       $sha2obj->add($_[1]);
       my $digest = $sha2obj->hexdigest();
        if($val->psw eq $digest){
          return 0;
        }else{
          return 1;
         }
    }else{
       return 1;
     }
}

sub checkclosetheme{
     my $row = schema->resultset('Theme')->search({id => $_[0]},{select => ['status']});
     my $val = $row->first;
   return $val->status;
}

sub getcategories{
 my @arr2;
 my $row;
 my $i = 0;
   my $rows = schema->resultset('Category')->search(undef,{select => ['id','name','description'],order_by => ['pos']});
     while($row = $rows->next){
        if (setting('charset') eq "utf-8"){
                $row->name(Encode::decode('UTF-8', $row->name));
                $row->description(Encode::decode('UTF-8', $row->description));
              }
        $arr2[$i] = $row;
        $i = $i + 1;
     }
   return @arr2;
}

sub getboards{
 my @arr;
 my $rows;
 my $i = 0;
 my $row;
 my $tmp_row;
 foreach $rows ( @{$_[0]} ){
     $row = schema->resultset('Board')->search({f_id_cat => $rows->id, type => 1},{select => ['id','name','description']});
    # Todo implement to UTF-8 !!!! #
     $arr[$i] = $row;         
     $i = $i + 1;
 }
return @arr;
}

sub getidboard{
     my $row = schema->resultset('Theme')->search({id => $_[0]},{select => ['id']});
     my $val = $row->first;
     my $rs = schema->resultset('Theme')->search({id => $val->id}, {result_class => 'DBIx::Class::ResultClass::HashRefInflator',})->first;
   return $rs->{f_id_bor};
}

sub getboardname{
     my $row = schema->resultset('Board')->search({id => $_[0]},{select => ['name']});
     my $val = $row->first;
      if (setting('charset') eq "utf-8"){
                $val->name(Encode::decode('UTF-8', $val->name));
                }
   return $val->name;
}

sub getadvert{
   my $i = 0;
   my @arr;
   my $row;
     my $rows = schema->resultset('Theme')->search({type=> 3},{select => ['id','name']});
     while($row = $rows->next){
      if (setting('charset') eq "utf-8"){
                $row->name(Encode::decode('UTF-8', $row->name));
                }
        my $rs = schema->resultset('Theme')->search({id => $row->id}, {result_class => 'DBIx::Class::ResultClass::HashRefInflator',})->first;
        $arr[$i][0] = $row;
        $arr[$i][1] = $rs->{f_id_acc};
        $i = $i + 1;
     }
     return @arr;
}

sub getattachthemes{
   my $i = 0;
   my @arr;
   my $row;
     my $rows = schema->resultset('Theme')->search({-and => [f_id_bor => $_[0],type=> 2]});
     while($row = $rows->next){
        $arr[$i] = $row;
        $i = $i + 1;
     }
     return @arr;
}

sub gethemename{
     my $row = schema->resultset('Theme')->search({id => $_[0]},{select => ['name']});
     my $val = $row->first;
     if (setting('charset') eq "utf-8"){
                $val->name(Encode::decode('UTF-8', $val->name));
                }
   return $val->name;
}

sub getreplys{
   my $i = 0;
   my @arr;
   my $row;
   my $str;
   my $val;
   my $rows = schema->resultset('Reply')->search({f_id_them => $_[0]},{select => ['id','content','date'],order_by => ['id'],page=>$_[1],rows=>10});
     while($row = $rows->next){
      my $rs = schema->resultset('Reply')->search({id => $row->id}, {result_class => 'DBIx::Class::ResultClass::HashRefInflator',})->first;
##      my $row_ = schema->resultset('Reply')->search({id => $row->id},{select => ['date'],as=>['content']});
        $arr[$i][0] = $row->id;
        $arr[$i][2] = $rs->{f_id_acc};
        $arr[$i][4] = $row->date;
##        $val = $row_->first;
              if (setting('charset') eq "utf-8"){
                $arr[$i][1] = Encode::decode('UTF-8', $row->content);
              }else{
                $arr[$i][1] = $row->content;  
              }
        $i = $i + 1;
     }
     return @arr;
}

sub gethemes{
   my $i = 0;
   my @arr;
   my $row;
   my $row_;
   my $val;
     my $rows = schema->resultset('Theme')->search({-and => [f_id_bor => $_[0], type => 1]},{page=>$_[1],rows=>20});
     while($row = $rows->next){
 #     $row_ = $self->resultset('Theme')->search({id => $row->id},{select => ['date'],as=>['type']});
 #     $val = $row_->first;
        my $rs = schema->resultset('Theme')->search({id => $row->id}, {result_class => 'DBIx::Class::ResultClass::HashRefInflator',})->first;
        if (setting('charset') eq "utf-8"){
                $row->name(Encode::decode('UTF-8', $row->name));
                }
        $arr[$i][0] = $row;
        $arr[$i][1] = $rs->{f_id_acc};
        $i = $i + 1;
     }
     return @arr;
}

sub getsumthemes{
     my $row = schema->resultset('Theme')->search({-and => [f_id_bor => $_[0], type => 1]},{select => ['id']});
      return $row->count;
}

sub getsumreplys{
     my $row = schema->resultset('Reply')->search({f_id_them => $_[0]},{select => ['id']});
      return $row->count;
}

sub getnumanswers{
     my $row = schema->resultset('Reply')->search({f_id_them => $_[0]},{select => ['id']});
      return $row->count;
}

sub get_account_status{
     my $row = schema->resultset('Account')->search({id => $_[0]},{select=>['status']});
     if($row->count > 0){
     my $val = $row->first;
      return $val->status;
    }
}

sub getauthor{
     my $row = schema->resultset('Account')->search({id => $_[0]},{select=>['username']});
     if ($row->count > 0){
      my $val = $row->first;
      return $val->username;
     }
}

sub getlastuser{
     my $row = schema->resultset('Account')->search(undef,{select => [ { max => 'id' }] , as => 'id' });
     if ($row->count > 0){
      my $val = $row->first;
      return $val->id;
     }
}

sub getsumusers{
     my $row = schema->resultset('Account')->search(undef,{select => [ count => 'id']});
      return $row->count;
}

sub getava{
     my $row = schema->resultset('Account')->search({id => $_[0]},{select=>['ava']});
     my $val = $row->first;
      return $val->ava;
}

sub updatepsw{
   my $row=schema->resultset('Account')->search({id => [$_[0]]},{select => ['psw']});
    if($row->count > 0){
      my $sha2obj = new Digest::SHA2 256;
      $sha2obj->add($_[1]);
      my $digest = $sha2obj->hexdigest();
      $row->update({psw=>$digest});
    }
}

sub updateava{
   my $row=schema->resultset('Account')->search({id => [$_[0]]},{select => ['ava']});
   if($row->count > 0){
   my $val = $row->first;
   unlink("/tmp/".$val->ava);
   $row->update({ava=>$_[1]});
   }
}

sub addreply{
   schema->resultset('Reply')->create({f_id_acc => $_[0],f_id_them => $_[1],content => $_[2]});
}

sub addthread{
   my $row = schema->resultset('Theme')->create({name => $_[2],type => 1,f_id_bor => $_[0],f_id_acc => $_[1], status => 1 });
   schema->resultset('Reply')->create({f_id_acc => $_[1],f_id_them => $row->id ,content => $_[3]});
   return $row->id;
}

1;