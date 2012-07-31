use utf8;
package DB::Result::Reply;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::Reply

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<replys>

=cut

__PACKAGE__->table("replys");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 f_id_acc

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 date

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=head2 f_id_them

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 content

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "f_id_acc",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "date",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
  "f_id_them",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "content",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 f_id_acc

Type: belongs_to

Related object: L<DB::Result::Account>

=cut

__PACKAGE__->belongs_to(
  "f_id_acc",
  "DB::Result::Account",
  { id => "f_id_acc" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 f_id_them

Type: belongs_to

Related object: L<DB::Result::Theme>

=cut

__PACKAGE__->belongs_to(
  "f_id_them",
  "DB::Result::Theme",
  { id => "f_id_them" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07022 @ 2012-04-13 23:10:24
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:h6mAVQKFPUAvHA0Yqy62vQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
