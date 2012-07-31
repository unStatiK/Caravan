package Validata;

sub valid_login_psw{
     my @arr;
     if($_[0] =~ m/^[a-zA-Z0-9]{1,50}$/){ $arr[0] = $&; }
     if($_[1] =~ m/^[[:print:]]{1,40}$/){ $arr[1] = $&; }
     return @arr;
}

sub valid_psw{
     my @arr;
     if($_[0] =~ m/^[[:print:]]{1,40}$/){ $arr[0] = $&; }
     if($_[1] =~ m/^[[:print:]]{1,40}$/){ $arr[1] = $&; }
     if($_[2] =~ m/^[[:print:]]{1,40}$/){ $arr[2] = $&; }
     return @arr;
}

1;