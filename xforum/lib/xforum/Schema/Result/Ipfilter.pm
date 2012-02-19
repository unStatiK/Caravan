package xforum::Schema::Result::Ipfilter;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

xforum::Schema::Result::Ipfilter

=cut

__PACKAGE__->table("ipfilter");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_nullable: 0

=head2 ip

  data_type: 'varchar'
  is_nullable: 0
  size: 16

=head2 f_id_acc

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_nullable => 0 },
  "ip",
  { data_type => "varchar", is_nullable => 0, size => 16 },
  "f_id_acc",
  { data_type => "integer", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07000 @ 2011-12-17 14:32:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Ff8+2FpJZJ42ALFCNfJtBA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
