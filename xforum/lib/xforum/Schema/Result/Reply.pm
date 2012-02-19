package xforum::Schema::Result::Reply;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

xforum::Schema::Result::Reply

=cut

__PACKAGE__->table("replys");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'replys_id_seq'

=head2 f_id_acc

  data_type: 'integer'
  is_nullable: 0

=head2 date

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 1
  original: {default_value => \"now()"}

=head2 f_id_them

  data_type: 'integer'
  is_nullable: 0

=head2 content

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "replys_id_seq",
  },
  "f_id_acc",
  { data_type => "integer", is_nullable => 0 },
  "date",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 1,
    original      => { default_value => \"now()" },
  },
  "f_id_them",
  { data_type => "integer", is_nullable => 0 },
  "content",
  { data_type => "text", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07000 @ 2011-12-17 14:32:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:meFVYfJ+71Ae2REl6Hrsfg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
