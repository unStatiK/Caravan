use utf8;
package DB::Result::Board;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::Board

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<boards>

=cut

__PACKAGE__->table("boards");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 f_id_cat

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 description

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 1024

=head2 type

  data_type: 'integer'
  default_value: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "f_id_cat",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "description",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 1024 },
  "type",
  { data_type => "integer", default_value => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 f_id_cat

Type: belongs_to

Related object: L<DB::Result::Category>

=cut

__PACKAGE__->belongs_to(
  "f_id_cat",
  "DB::Result::Category",
  { id => "f_id_cat" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 themes

Type: has_many

Related object: L<DB::Result::Theme>

=cut

__PACKAGE__->has_many(
  "themes",
  "DB::Result::Theme",
  { "foreign.f_id_bor" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07022 @ 2012-04-13 23:10:24
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:euVfV0GPG/HQGEZLJkm3Ow


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
