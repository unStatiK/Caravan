package Forum;
use Switch;
use BBCode;
use Image::Info qw(image_type image_info);
use Image::Resize;
use Data::Uniqid qw (uniqid);
use Dancer ':syntax';

get '/' => sub {
    my $auth = 0;
    my $username;
    my $error;
    
     if(defined session->{idu} && defined session->{user}){
        $auth = 0;
        $username = session->{user};
     }else{
        $auth = 1;
        $username = '';
      }
     
     if(defined params->{psw}){
           
                switch(params->{psw}){
                  case "error" {
                       $error = "password or login incorrect !!!";
                  }
                  else{
                    redirect '/';
                  }
                }
     }
     my @arr3 = DBFunction::getcategories();
     my @arr_boarr = DBFunction::getboards(\@arr3);
     my @arr_ = DBFunction::getadvert();
     my @arr_a;
     my $i = 0;
     my $rows;
     for $rows (@arr_){        	 
        $arr_a[$i] = DBFunction::getauthor($rows->[1]);
        $i = $i + 1;
     }
     my $lastuser = DBFunction::getauthor(DBFunction::getlastuser());
     my $sum_u = DBFunction::getsumusers();

   template 'index' =>
     { 
       auth => $auth,
       username => $username,
       error => $error,
       arr_cat => [@arr3],
       arr_boar => [@arr_boarr],
       arr_adv => [@arr_],
       arr_a => [@arr_a],
       lastuser => $lastuser,
       sum_u => $sum_u 
     };
};

get '/board/:id/' => sub {
       my $error;
       my $page;
       my $idb;
       my $nameb;
       my $auth = 0;
       my $username;
       my $num_pg;
       my @arr_;
       my @arr_a;
       my @arr_an;
       my @arr_them;
       my @arr_authr;
       my @arr_answ;
       my @arr_them_a;
       my @arr_authr_a;
       my @arr_answ_a;
       my @arr_adv;
       if (params->{id} !~ m/^[0-9]{1,4}$/){
              redirect '/';
       }else{
         if(defined params->{page}){
           if (params->{page} =~ m/^[0-9]{1,3}$/){
              $page = $&;
              $idb = params->{id};
              $nameb = DBFunction::getboardname(params->{id});  
              $page = $page;
              @arr_ = DBFunction::gethemes(params->{id},$page);   
              @arr_them = @arr_;
              
             
              my $rows;
              my $i = 0;
               for $rows (@arr_){
                $arr_a[$i] = DBFunction::getauthor($rows->[1]);  
                $arr_an[$i] = DBFunction::getnumanswers($rows->[0]->id);   
                $i = $i + 1;
               }
              @arr_authr = @arr_a;
              @arr_answ = @arr_an;

              @arr_ = DBFunction::getattachthemes(params->{id});
              @arr_them_a = @arr_;
              $i = 0;
              
               for $rows (@arr_){
                $arr_a[$i] = DBFunction::getauthor($rows->[1]);    
                $arr_an[$i] = DBFunction::getnumanswers($rows->id);
                $i = $i + 1;
               }
               @arr_authr_a = @arr_a;
               @arr_answ_a = @arr_an;

              @arr_ = DBFunction::getadvert();     
              @arr_adv = @arr_;
              $i = 0;
              for $rows (@arr_){
                 $arr_a[$i] = DBFunction::getauthor($rows->[1]);  
                 $i = $i + 1;
              }


              my @pages;
              my $num_tm = DBFunction::getsumthemes(params->{id});
              $num_pg = $num_tm / 20;
              $num_pg = int($num_pg);
                 if($num_pg == 0){$num_pg = 1;}
                 elsif(((20 * $num_pg) != $num_tm) && ($num_pg > 0) ){$num_pg = $num_pg + 1;}
              my $pages = $num_pg;

           }else{
              redirect '/';
            }
         }else{
            redirect '/';
          }
        }

if(defined session->{idu} && defined session->{user}){
        $auth = 0;
        $username = session->{user};
     }else{
        $auth = 1;
        $username = '';
      }

if(defined params->{psw}){
           if (params->{psw} =~ m/^[a-z]{1,5}$/){
                switch($&){
                  case "error" {
                       $error = "пароль или логин неверен !!!";
                  }
                  else{
                    redirect '/board/'.params->{id}.'/?page=1';
                  }
                }
           }else{
              redirect '/board/'.params->{id}.'/?page=1';
           }
     }
     my $lastuser = DBFunction::getauthor(DBFunction::getlastuser());  
     my $sum_u = DBFunction::getsumusers();   

    template 'board' => 
    {
      idb => $idb,
      nameb => $nameb,
      page => $page,
      arr_them => [@arr_them],
      arr_authr => [@arr_authr],
      arr_answ => [@arr_answ],
      arr_them_a => [@arr_them_a],
      arr_authr_a => [@arr_authr_a],
      arr_answ_a => [@arr_answ_a],
      arr_adv => [@arr_],
      arr_a => [@arr_a],
      pages => $num_pg,
      auth => $auth,
      username => $username,
      error => $error,
      lastuser => $lastuser,
      sum_u => $sum_u
    };


};
   
post '/board/newthread' => sub  {
        my $auth = 0;
        my $username;
        my $nameb;
        my $idb;
        my $userid;

if(defined session->{idu} && defined session->{user}){
        $auth = 0;
        $username = session->{user};
        $userid = session->{idu};
        $nameb = DBFunction::getboardname(params->{idb});
        $idb = params->{idb};
        template 'newthread' => 
        {
           auth => $auth,
           username => $username,
           nameb => $nameb,
           idb => $idb,
           userid => $userid
        };
     }else{
        $auth = 1;
        $username = '';
        redirect '/';
      }
};


get '/thread/:id/' => sub {

my $error;
my $auth = 0;
my $username;
my $userid;
my $nameb;

 if (params->{id} !~ m/^[0-9]{1,4}$/){
             redirect '/';
       }else{
         if(defined params->{page}){
           if (params->{page} =~ m/^[0-9]{1,3}$/){
                 my $page = params->{page};
                 my $idt = params->{id};
                 my @arr_ = DBFunction::getadvert();
                 my $id = params->{id};
                 my @arr_r = DBFunction::getreplys($id,$page);
                 my @rows;
                 my @arr_at;
                 my $i = 0;
                   for (@arr_r){
                     $arr_at[$i][0] = DBFunction::get_account_status($arr_r[$i][2]);
                     $arr_at[$i][1] = DBFunction::getauthor($arr_r[$i][2]);  
                     $arr_at[$i][2] = DBFunction::getava($arr_r[$i][2]);
                     $i = $i + 1;
                   }
                 my $id_ = DBFunction::getidboard(params->{id});                        
                   if($id_ ne 0){
                     $nameb = DBFunction::getboardname($id_);              
                   }
                 my $namet = DBFunction::gethemename(params->{id});                  
                 my $idb = $id_;

                 my @pages;
                 my $num_rpl = DBFunction::getsumreplys(params->{id});         
                 my $num_pg = $num_rpl / 10;
                 $num_pg = int($num_pg);
                 if($num_pg == 0){$num_pg = 1;}
                 elsif(((10 * $num_pg) != $num_rpl) && ($num_pg > 0) ){$num_pg = $num_pg + 1;}
                 my $pages = $num_pg;

                 my $is_close =  DBFunction::checkclosetheme(params->{id});     


if(defined session->{idu} && defined session->{user}){
        $auth = 0;
        $username = session->{user};
        $userid = session->{idu};
     }else{
        $auth = 1;
        $username = '';
        $userid = 0;
      }

                 if(defined params->{psw}){
                    if (params->{psw} =~ m/^[a-z]{1,5}$/){
                        switch($&){
                            case "error" {
                                $error = "пароль или логин неверен !!!";
                            }
                            else{
                                redirect '/thread/'.params->{id}.'/?page=1';
                            }
                        }
                    }else{
                        redirect '/thread/'.params->{id}.'/?page=1';
                     }
                 }
                 my $lastuser = DBFunction::getauthor(DBFunction::getlastuser());
                 my $sum_u = DBFunction::getsumusers();

                 template 'thread' => 
                 {
                     page => $page,
                     idt => $idt,
                     repls => [@arr_r],
                     arr_at => [@arr_at],
                     nameb => $nameb,
                     namet => $namet,
                     idb => $idb,
                     pages => $pages,
                     is_close => $is_close,
                     auth => $auth,
                     username => $username,
                     userid => $userid,
                     error => $error,
                     lastuser => $lastuser,
                     sum_u => $sum_u
                 };
                 
           }else{
             redirect '/';
            }
         }else{
             redirect '/';
          }
 }


};

post '/thread/reply' => sub {

   if(defined params->{idt} && defined params->{ida} && defined params->{mytxtarea}){  
    my $bbc  = BBCode->new({allowed_tags => ['b','i','u','url','list','quote','code','img'],linebreaks => 1,stripscripts=> 1});
    my $reqq = params->{mytxtarea};
    $reqq =~ s/</&lt;/g;
    $reqq =~ s/>/&gt;/g;
    #$bbc->{html} =~ s/([[:print:]]{70}+)/$1&shy;/g;
   # $reqq =~ s/([[:print:]]{70}+)/$1&shy;/g;
    my $html = $bbc->parse($reqq);
    DBFunction::addreply(params->{ida},params->{idt},$bbc->{html});
#     DBFunction::addreply(params->{ida},params->{idt},$reqq);
    redirect '/thread/'.params->{idt}.'/?page=1';
  }else{
    redirect '/';
   }

};

post '/thread/add' => sub {
   
   if(defined params->{namet} && defined params->{idb} && defined params->{ida} && defined params->{mytxtarea} ){
      my $temp = params->{namet};
      $temp =~ s/^\s+//;
      $temp =~ s/\s+$//;
      $temp =~ s/</&lt;/g;
      $temp =~ s/>/&gt;/g;
      my $str = $temp;
     if($temp ne ''){
       $temp = params->{mytxtarea};
       $temp =~ s/^\s+//;
       $temp =~ s/\s+$//;
       if($temp ne ''){

#    my $reqq = params->{mytxtarea};
#    $reqq =~ s/</&lt;/g;
#    $reqq =~ s/>/&gt;/g;
#       my $bbc  = HTML::BBCode->new({allowed_tags => ['b','i','u','url','list','quote','code','img'],linebreaks => 1,stripscripts=> 1});
#       my $html = $bbc->parse($reqq);
#        $bbc->{html} =~ s/([[:print:]]{70}+)/$1&shy;/g;
#        my $idt = DBFunction::addthread(params->{idb},params->{ida},params->{namet},$bbc->{html});
#          my $idt = DBFunction::addthread(params->{idb},params->{ida},params->{namet},$reqq);

    my $bbc  = BBCode->new({allowed_tags => ['b','i','u','url','list','quote','code','img'],linebreaks => 1,stripscripts=> 1});
    my $reqq = params->{mytxtarea};
    $reqq =~ s/</&lt;/g;
    $reqq =~ s/>/&gt;/g;
    #$bbc->{html} =~ s/([[:print:]]{70}+)/$1&shy;/g;
   # $reqq =~ s/([[:print:]]{70}+)/$1&shy;/g;
    my $html = $bbc->parse($reqq);
    my $idt = DBFunction::addthread(params->{idb},params->{ida},$str,$bbc->{html});



        redirect '/thread/'.$idt.'/?page=1';
      }else{
         redirect '/';
      }
     }else{
         redirect '/';
      }
   }else{
       redirect '/';
    }
};

get '/profile/' => sub {

    if(defined session->{idu} && defined session->{user}){

        my $auth = 0;
        my $user = session->{user};
        my $ava = DBFunction::getava(session->{idu});
        my $psw_status;
        my $nullava;
        my $error_;
        my $derror_;
        if($ava eq ''){
          $nullava = 'no avatar';
        }
         if(defined params->{error_}){
           if (params->{error_} =~ m/^[a-z]{1,8}$/){
                switch($&){
                  case "badfile" {
                       $error_ = "file is not image or corrupt!!!"; 
                  }
                  case "size" {
                       $error_ = "file size must not be greater than 30KB !!!"; 
                  }
                  case "type" {
                       $error_ = "error fyle type !!!"; 
                  }
                  case "data" {
                       $derror_ = "data incorrect !!!"; 
                  }
                  else{
                   redirect '/profile';
                  }
                }
           }else{
              redirect '/profile';
            }
         }
         if(defined params->{action}){
           if (params->{action} =~ m/^[a-z]{1,5}$/){
                switch($&){
                  case "succ" {
                       $psw_status = "password changed !!!"; 
                  }
                  else{
                    redirect '/profile';
                  }
                }
           }else{
              redirect '/profile';
           }
         }
        template 'profile' => 
        {
        	auth => $auth,
        	user => $user,
        	ava => $ava,
        	nullava => $nullava,
        	error_ => $error_,
        	derror_ => $derror_,
        	succ => $psw_status
        };
        
    }else{
        redirect '/';
     }

};

post '/profile/save' => sub {
    my $r;
    my $avapath = "/tmp/xForum/public/";
    if(defined session->{idu} && defined session->{user}){
      my $error;
         if(defined request->upload('file_')){
             my $f_rsz;
             my $gd;
             my $fname;
             my $upload = request->upload('file_');
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
                            my $un = uniqid;
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
                                 unlink($avapath.DBFunction::getava(session->{idu}));
                                 DBFunction::updateava(session->{idu},$fname);
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
              redirect '/profile/?error_='.$error;
           }            
         }  

      if(defined params->{actpsw} && defined params->{newpsw} && defined params->{renewpsw}){
        my @post = Validata::valid_psw(params->{actpsw},params->{newpsw},params->{renewpsw});
            if(defined $post[0] && defined $post[1] && defined $post[2]){
               if(DBFunction::checkpsw(session->{idu},$post[0]) eq 0){
                 if($post[1] eq $post[2]){
                   DBFunction::updatepsw(session->{idu},$post[1]);
                   $r = 1;
                   redirect '/profile/?action=succ';
                 }else{
                   $error = 'data';
                  }
               }else{
                  $error = 'data';
                }
            }else{
              $error = 'data';
             }
         if(defined $error){
              $r = 1;
              redirect '/profile/?error_='.$error;
         }            
      }
    }

  if(!defined $r){
      redirect '/profile';
  }
};


post '/logout' => sub {

   session->destroy;

   if(params->{type}){
     switch(params->{type}){
              case "forum" {
                 redirect '/';
              }
              case "board" {
                 if (params->{idb} =~ m/^[0-9]{1,4}$/){
                   if (params->{page} =~ m/^[0-9]{1,4}$/){
                      redirect '/board/'.params->{idb}.'/?page='.params->{page};
                   }else{
                      redirect '/';
                    }
                 }else{
                     redirect '/';
                  }
              }
              case "thread" {
                 if (params->{idt} =~ m/^[0-9]{1,4}$/){
                   if (params->{page} =~ m/^[0-9]{1,4}$/){
                      redirect '/thread/'.params->{idt}.'/?page='.params->{page};
                   }else{
                      redirect '/';
                    }
                 }else{
                     redirect '/';
                  }
              }
              else{
                 redirect '/';
              }
    }
  }else{
     redirect '/';
   }


};

post '/login' => sub {

    my $err = 1;
     if(defined params->{login} && defined params->{psw} && defined params->{type}){
         my @post = Validata::valid_login_psw(params->{login},params->{psw});
            if(defined $post[0]){
               if(defined $post[1]){
                 my @var = DBFunction::checklogin($post[0],$post[1]);
                   if($var[0] == 0){
                     session idu => $var[1];
                     session user => $post[0];
                     undef $err;
                   }
               }
            }
     }
   my $err_var = '';  
   my $amp = '';
   if(defined $err){
   	  $err_var = 'psw=error';
   	  $amp = '&';
   }
     if(params->{type}){
         switch(params->{type}){
              case "forum" {
              	   if($err_var ne ''){
              	     redirect '/?'.$err_var;  	
              	   }else{
                     redirect '/';
                    }
              }
              case "board" {
                 if (params->{idb} =~ m/^[0-9]{1,4}$/){
                         if (params->{page} =~ m/^[0-9]{1,4}$/){
                              redirect '/board/'.params->{idb}.'/?page='.params->{page}.$amp.$err_var;
                        }else{
                           redirect '/';
                         }
                 }else{
                    redirect '/';
                  }
              }
              case "thread" {
                 if (params->{idt} =~ m/^[0-9]{1,4}$/){
                         if (params->{page} =~ m/^[0-9]{1,4}$/){
                              redirect '/thread/'.params->{idt}.'/?page='.params->{page}.$amp.$err_var;
                        }else{
                           redirect '/';
                         }
                 }else{
                    redirect '/';
                  }
              }
              else{
                 redirect '/';
              }
          }
     }else{
     	redirect '/';
     }
};
