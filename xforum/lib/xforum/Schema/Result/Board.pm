package xforum::Schema::Result::Board;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

xforum::Schema::Result::Board

=cut

__PACKAGE__->table("boards");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'boards_id_seq'

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 f_id_cat

  data_type: 'integer'
  is_nullable: 0

=head2 description

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 1024

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "boards_id_seq",
  },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "f_id_cat",
  { data_type => "integer", is_nullable => 0 },
  "description",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 1024 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07000 @ 2011-12-17 14:32:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ZnXbuCWD8Y2x6VXjO3O/rg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
