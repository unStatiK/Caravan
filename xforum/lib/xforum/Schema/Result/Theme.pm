package xforum::Schema::Result::Theme;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

xforum::Schema::Result::Theme

=cut

__PACKAGE__->table("themes");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'themes_id_seq'

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
  default_value: current_timestamp
  is_nullable: 1
  original: {default_value => \"now()"}

=head2 f_id_bor

  data_type: 'integer'
  default_value: -1
  is_nullable: 0

=head2 author

  data_type: 'integer'
  is_nullable: 0

=head2 status

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "themes_id_seq",
  },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "type",
  { data_type => "integer", default_value => 4, is_nullable => 0 },
  "date",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 1,
    original      => { default_value => \"now()" },
  },
  "f_id_bor",
  { data_type => "integer", default_value => -1, is_nullable => 0 },
  "author",
  { data_type => "integer", is_nullable => 0 },
  "status",
  { data_type => "integer", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07000 @ 2011-12-17 14:32:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:JEDxorPZNBhbg9+VgltLMQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
