use utf8;
package DB::Result::Moder;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::Moder

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<moders>

=cut

__PACKAGE__->table("moders");

=head1 ACCESSORS

=head2 f_id_b

  data_type: 'integer'
  is_nullable: 0

=head2 f_id_acc

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "f_id_b",
  { data_type => "integer", is_nullable => 0 },
  "f_id_acc",
  { data_type => "integer", is_nullable => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07022 @ 2012-04-13 23:10:24
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:k+josJNznq7Rwew1fqhQ6A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
