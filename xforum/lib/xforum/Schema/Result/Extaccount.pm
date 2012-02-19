package xforum::Schema::Result::Extaccount;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

xforum::Schema::Result::Extaccount

=cut

__PACKAGE__->table("extaccount");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'extaccount_id_seq'

=head2 f_id_acc

  data_type: 'integer'
  is_nullable: 0

=head2 ava

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "extaccount_id_seq",
  },
  "f_id_acc",
  { data_type => "integer", is_nullable => 0 },
  "ava",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07000 @ 2011-12-17 14:32:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:tCt1naJ+jZmD5p/Z3jQDrw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
