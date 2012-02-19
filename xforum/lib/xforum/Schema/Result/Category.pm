package xforum::Schema::Result::Category;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

xforum::Schema::Result::Category

=cut

__PACKAGE__->table("categories");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'categories_id_seq'

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 ind

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "categories_id_seq",
  },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "ind",
  { data_type => "integer", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07000 @ 2011-12-17 14:32:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:j3WUQtxq1Nc9ekaIlna8EQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
