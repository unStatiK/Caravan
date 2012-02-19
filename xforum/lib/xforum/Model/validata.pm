package xforum::Model::validata;
use Moose;
use namespace::autoclean;

extends 'Catalyst::Model';

sub validata{
     my @arr;
     if($_[1] =~ m/^[a-zA-Z0-9]{1,10}$/){ $arr[0] = $&; }
     if($_[2] =~ m/^[a-zA-Z0-9А-Яа-яЁё_]{1,40}$/){ $arr[1] = $&; }
     if($_[3] =~ m/^[a-zA-Z0-9А-Яа-яЁё_]{1,40}$/){ $arr[2] = $&; }
     return @arr;
}

sub validatapsw{
     my @arr;
     if($_[1] =~ m/^[a-zA-Z0-9А-Яа-яЁё_]{1,40}$/){ $arr[0] = $&; }
     if($_[2] =~ m/^[a-zA-Z0-9А-Яа-яЁё_]{1,40}$/){ $arr[1] = $&; }
     if($_[3] =~ m/^[a-zA-Z0-9А-Яа-яЁё_]{1,40}$/){ $arr[2] = $&; }
     return @arr;
}


=head1 NAME

xforum::Model::validata - Catalyst Model

=head1 DESCRIPTION

Catalyst Model.

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
