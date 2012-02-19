package xforum::Model::account;
use Moose;
use namespace::autoclean;
use Digest::SHA1  qw(sha1_hex);
extends 'Catalyst::Model';

sub checkauth{
}

sub to_hex{
  my $hex = sha1_hex(uc($_[1]).":".uc($_[2]));
  return $hex;
}
=head1 NAME

xforum::Model::account - Catalyst Model

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
