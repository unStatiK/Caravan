package xforum::Schema::Result::Account;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

xforum::Schema::Result::Account

=cut

__PACKAGE__->table("account");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'account_id_seq'

=head2 gmlevel

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 username

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 32

=head2 sha_pass_hash

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 40

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "account_id_seq",
  },
  "gmlevel",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "username",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 32 },
  "sha_pass_hash",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 40 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07000 @ 2011-12-17 14:32:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:t/cKhRsrnGGVMcQZuslIlQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
