use utf8;
package DB::Result::Account;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

DB::Result::Account

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<account>

=cut

__PACKAGE__->table("account");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 username

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=head2 psw

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 ava

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 status

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "username",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "psw",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "ava",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "status",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 replys

Type: has_many

Related object: L<DB::Result::Reply>

=cut

__PACKAGE__->has_many(
  "replys",
  "DB::Result::Reply",
  { "foreign.f_id_acc" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 themes

Type: has_many

Related object: L<DB::Result::Theme>

=cut

__PACKAGE__->has_many(
  "themes",
  "DB::Result::Theme",
  { "foreign.f_id_acc" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07022 @ 2012-04-13 23:10:24
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:kOWZ54u60FsHwHUSQlWpPw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
