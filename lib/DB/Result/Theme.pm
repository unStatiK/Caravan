use utf8;
package DB::Result::Theme;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::Theme

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<themes>

=cut

__PACKAGE__->table("themes");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 type

  data_type: 'integer'
  default_value: 4
  is_nullable: 0

=head2 date

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=head2 f_id_bor

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 f_id_acc

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 status

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "type",
  { data_type => "integer", default_value => 4, is_nullable => 0 },
  "date",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
  "f_id_bor",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "f_id_acc",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "status",
  { data_type => "integer", is_nullable => 1 },
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

=head2 f_id_bor

Type: belongs_to

Related object: L<DB::Result::Board>

=cut

__PACKAGE__->belongs_to(
  "f_id_bor",
  "DB::Result::Board",
  { id => "f_id_bor" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 replys

Type: has_many

Related object: L<DB::Result::Reply>

=cut

__PACKAGE__->has_many(
  "replys",
  "DB::Result::Reply",
  { "foreign.f_id_them" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07022 @ 2012-04-13 23:10:24
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:bXzXCsUWsLYp692KgsH1tQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
